param(
  [Parameter(Mandatory = $true)]
  [string]$Path
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Path)) {
  throw "No se encontró el DOCX: $Path"
}

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$fullPath = (Resolve-Path -LiteralPath $Path).Path
$stream = [System.IO.File]::Open(
  $fullPath,
  [System.IO.FileMode]::Open,
  [System.IO.FileAccess]::ReadWrite,
  [System.IO.FileShare]::None
)

try {
  $zip = New-Object System.IO.Compression.ZipArchive(
    $stream,
    [System.IO.Compression.ZipArchiveMode]::Update,
    $false
  )

  try {
    $entry = $zip.GetEntry("word/document.xml")
    if ($null -eq $entry) {
      throw "El DOCX no contiene word/document.xml."
    }

    $reader = New-Object System.IO.StreamReader($entry.Open(), [System.Text.Encoding]::UTF8, $true)
    $xml = $reader.ReadToEnd()
    $reader.Close()

    $pageTag = [regex]::Match($xml, '<w:pgSz\b[^>]*>')
    $marginTag = [regex]::Match($xml, '<w:pgMar\b[^>]*>')

    if (-not $pageTag.Success -or -not $marginTag.Success) {
      throw "No fue posible localizar el tamaño de página o los márgenes del documento."
    }

    $pageWidthMatch = [regex]::Match($pageTag.Value, 'w:w="(\d+)"')
    $leftMarginMatch = [regex]::Match($marginTag.Value, 'w:left="(\d+)"')
    $rightMarginMatch = [regex]::Match($marginTag.Value, 'w:right="(\d+)"')

    if (
      -not $pageWidthMatch.Success -or
      -not $leftMarginMatch.Success -or
      -not $rightMarginMatch.Success
    ) {
      throw "No fue posible determinar el ancho útil del documento."
    }

    $pageWidth = [int]$pageWidthMatch.Groups[1].Value
    $leftMargin = [int]$leftMarginMatch.Groups[1].Value
    $rightMargin = [int]$rightMarginMatch.Groups[1].Value
    $usableWidth = $pageWidth - $leftMargin - $rightMargin

    if ($usableWidth -le 0) {
      throw "El ancho útil calculado no es válido."
    }

    $adjusted = 0

    $xml = [regex]::Replace(
      $xml,
      '(?s)<w:tbl\b.*?</w:tbl>',
      {
        param($match)

        $table = $match.Value
        $gridMatches = [regex]::Matches(
          $table,
          '<w:gridCol\b[^>]*w:w="(\d+)"[^>]*/?>'
        )

        if ($gridMatches.Count -eq 0) {
          return $table
        }

        $gridTotal = 0
        foreach ($gridMatch in $gridMatches) {
          $gridTotal += [int]$gridMatch.Groups[1].Value
        }

        if ($gridTotal -le $usableWidth) {
          return $table
        }

        $factor = $usableWidth / [double]$gridTotal

        $table = [regex]::Replace(
          $table,
          '<w:gridCol\b([^>]*?)w:w="(\d+)"([^>]*)/?>',
          {
            param($grid)
            $oldWidth = [int]$grid.Groups[2].Value
            $newWidth = [math]::Max(1, [math]::Floor($oldWidth * $factor))
            '<w:gridCol' + $grid.Groups[1].Value +
              'w:w="' + $newWidth + '"' + $grid.Groups[3].Value + '/>'
          }
        )

        $table = [regex]::Replace(
          $table,
          '<w:tcW\b([^>]*?)w:w="(\d+)"([^>]*?)w:type="dxa"([^>]*)/?>',
          {
            param($cell)
            $oldWidth = [int]$cell.Groups[2].Value
            $newWidth = [math]::Max(1, [math]::Floor($oldWidth * $factor))
            '<w:tcW' + $cell.Groups[1].Value +
              'w:w="' + $newWidth + '"' + $cell.Groups[3].Value +
              'w:type="dxa"' + $cell.Groups[4].Value + '/>'
          }
        )

        $table = [regex]::Replace(
          $table,
          '<w:tblW\b[^>]*/>',
          '<w:tblW w:type="pct" w:w="5000"/>',
          1
        )

        if ([regex]::IsMatch($table, '<w:tblLayout\b[^>]*/>')) {
          $table = [regex]::Replace(
            $table,
            '<w:tblLayout\b[^>]*/>',
            '<w:tblLayout w:type="fixed"/>',
            1
          )
        }
        else {
          $table = [regex]::Replace(
            $table,
            '(<w:tblPr\b[^>]*>)',
            '$1<w:tblLayout w:type="fixed"/>',
            1
          )
        }

        $adjusted++
        return $table
      }
    )

    $entry.Delete()
    $newEntry = $zip.CreateEntry("word/document.xml", [System.IO.Compression.CompressionLevel]::Optimal)
    $writer = New-Object System.IO.StreamWriter($newEntry.Open(), (New-Object System.Text.UTF8Encoding($false)))
    $writer.Write($xml)
    $writer.Flush()
    $writer.Close()

    Write-Output ("Tablas ajustadas al ancho útil del documento: " + $adjusted)
    Write-Output ("Ancho útil OOXML: " + $usableWidth + " twips")
  }
  finally {
    $zip.Dispose()
  }
}
finally {
  $stream.Dispose()
}
