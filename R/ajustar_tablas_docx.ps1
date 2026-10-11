param(
  [Parameter(Mandatory = $true)]
  [string]$Path
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Path)) {
  throw "No se encontró el DOCX: $Path"
}

$tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("quarto_docx_tables_" + [guid]::NewGuid().ToString("N"))
$expandido = Join-Path $tmp "docx"
$zipEntrada = Join-Path $tmp "entrada.zip"
$zipSalida = Join-Path $tmp "salida.zip"

try {
  New-Item -ItemType Directory -Path $tmp -Force | Out-Null
  Copy-Item -LiteralPath $Path -Destination $zipEntrada -Force
  Expand-Archive -LiteralPath $zipEntrada -DestinationPath $expandido -Force

  $documentXml = Join-Path $expandido "word\document.xml"
  if (-not (Test-Path -LiteralPath $documentXml)) {
    throw "El DOCX no contiene word/document.xml."
  }

  $xml = [System.IO.File]::ReadAllText($documentXml)

  $page = [regex]::Match(
    $xml,
    '<w:pgSz\b[^>]*w:w="(\d+)"[^>]*/?>'
  )
  $margins = [regex]::Match(
    $xml,
    '<w:pgMar\b[^>]*w:left="(\d+)"[^>]*w:right="(\d+)"[^>]*/?>'
  )

  if (-not $page.Success -or -not $margins.Success) {
    throw "No fue posible determinar el ancho de página y los márgenes del DOCX."
  }

  $pageWidth = [int]$page.Groups[1].Value
  $leftMargin = [int]$margins.Groups[1].Value
  $rightMargin = [int]$margins.Groups[2].Value
  $usableWidth = $pageWidth - $leftMargin - $rightMargin

  if ($usableWidth -le 0) {
    throw "El ancho útil calculado para la página no es válido."
  }

  $tablePattern = '(?s)<w:tbl\b.*?</w:tbl>'
  $adjusted = 0

  $xml = [regex]::Replace(
    $xml,
    $tablePattern,
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

      $gridWidths = @(
        foreach ($gridMatch in $gridMatches) {
          [int]$gridMatch.Groups[1].Value
        }
      )

      $gridTotal = ($gridWidths | Measure-Object -Sum).Sum

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
          $newWidth = [math]::Max(1, [math]::Round($oldWidth * $factor))
          return '<w:gridCol' + $grid.Groups[1].Value +
            'w:w="' + $newWidth + '"' + $grid.Groups[3].Value + '/>'
        }
      )

      $table = [regex]::Replace(
        $table,
        '<w:tcW\b([^>]*?)w:w="(\d+)"([^>]*?)w:type="dxa"([^>]*)/?>',
        {
          param($cell)
          $oldWidth = [int]$cell.Groups[2].Value
          $newWidth = [math]::Max(1, [math]::Round($oldWidth * $factor))
          return '<w:tcW' + $cell.Groups[1].Value +
            'w:w="' + $newWidth + '"' + $cell.Groups[3].Value +
            'w:type="dxa"' + $cell.Groups[4].Value + '/>'
        }
      )

      $table = [regex]::Replace(
        $table,
        '<w:tblW\b[^>]*/>',
        '<w:tblW w:type="pct" w:w="5000" />',
        1
      )

      if ([regex]::IsMatch($table, '<w:tblLayout\b[^>]*/>')) {
        $table = [regex]::Replace(
          $table,
          '<w:tblLayout\b[^>]*/>',
          '<w:tblLayout w:type="fixed" />',
          1
        )
      } else {
        $table = [regex]::Replace(
          $table,
          '(<w:tblW\b[^>]*/>)',
          '$1<w:tblLayout w:type="fixed" />',
          1
        )
      }

      $adjusted++
      return $table
    }
  )

  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($documentXml, $xml, $utf8NoBom)

  Compress-Archive -Path (Join-Path $expandido '*') -DestinationPath $zipSalida -CompressionLevel Optimal -Force
  Copy-Item -LiteralPath $zipSalida -Destination $Path -Force

  Write-Output ("Tablas ajustadas al ancho útil del documento: " + $adjusted)
  Write-Output ("Ancho útil OOXML: " + $usableWidth + " twips")
}
finally {
  if (Test-Path -LiteralPath $tmp) {
    Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
  }
}
