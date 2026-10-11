param(
  [Parameter(Mandatory = $true)]
  [string]$Path
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Path)) {
  throw "No se encontró el DOCX: $Path"
}

$word = $null
$doc = $null

try {
  $fullPath = (Resolve-Path -LiteralPath $Path).Path

  $word = New-Object -ComObject Word.Application
  $word.Visible = $false
  $word.DisplayAlerts = 0

  $doc = $word.Documents.Open(
    $fullPath,
    $false,
    $false
  )

  $count = $doc.Tables.Count

  for ($i = 1; $i -le $count; $i++) {
    $table = $doc.Tables.Item($i)

    # wdAutoFitWindow = 2: ajusta la tabla al ancho disponible
    # entre los márgenes de la sección.
    $table.AllowAutoFit = -1
    $table.AutoFitBehavior(2)

    # wdPreferredWidthPercent = 2
    $table.PreferredWidthType = 2
    $table.PreferredWidth = 100
  }

  $doc.Save()
  $doc.Close()
  $doc = $null

  Write-Output ("Tablas ajustadas por Microsoft Word: " + $count)
}
finally {
  if ($null -ne $doc) {
    try { $doc.Close($false) } catch {}
  }

  if ($null -ne $word) {
    try { $word.Quit() } catch {}
    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($word)
  }

  [GC]::Collect()
  [GC]::WaitForPendingFinalizers()
}
