param([Parameter(Mandatory = $true)][string]$Path)

# Correcciones de la auditoria final: lista cerrada de labels, nunca estilos.
# Solo sustituye los contenedores seleccionados en document.xml. Los demas
# bytes XML, las imagenes, los campos y las plantillas quedan intactos.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$w = 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'
$targets = [ordered]@{
    # Anchos locales confirmados en la auditoria.
    'tbl-paquetes-r' = @(33, 87)
    'tbl-ch14-resumen-descriptivo' = @(25, 16, 20, 21, 15, 23)
    'tbl-ch19-asociacion-causalidad' = @(28, 44, 48)
    'tbl-ch19-correlacion-espuria' = @(120)
    'tbl-reg29-checklist' = @(60, 60)

    # Casos de caption/cabecera separados: se conserva el ancho interno
    # y solo se aplican propiedades de continuidad.
    'tbl-ch13-valores-perdidos' = @()
    'tbl-ch19-correlacion-pearson' = @()
    'tbl-reg22-checklist' = @()
    'tbl-reg25-pooled' = @()
    'tbl-reg26-resumen-eficiencia' = @()
    'tbl-reg31-coeficientes' = @()
    'tbl-reg32-tipos-recomendacion' = @()
    'tbl-reg33-pdf' = @()
    'tbl-reg34-checklist' = @()
    'fig-reg22-homoscedasticidad' = @()
    'fig-reg22-cook' = @()
    'fig-reg22-leverage' = @()
    'fig-reg25-comparacion-grafica' = @()
    'fig-reg30-regresion' = @()
}

function Set-Property($parent, [string]$name, [hashtable]$attributes = @{}) {
    $node = $parent.SelectSingleNode("w:$name", $script:ns)
    if ($null -eq $node) {
        $node = $parent.OwnerDocument.CreateElement('w', $name, $w)
        if ($name -in @('trPr', 'tcPr', 'pPr', 'tblPr')) {
            [void]$parent.PrependChild($node)
        } elseif ($name -eq 'tblLayout' -and $parent.SelectSingleNode('w:tblLook', $script:ns)) {
            [void]$parent.InsertBefore($node, $parent.SelectSingleNode('w:tblLook', $script:ns))
        } else {
            [void]$parent.AppendChild($node)
        }
    }
    foreach ($key in $attributes.Keys) {
        [void]$node.SetAttribute($key, $w, [string]$attributes[$key])
    }
    return ,$node
}

function Keep-Paragraph($p, [bool]$next) {
    # Quarto puede emitir dos pPr en captions: consolidar solo el afectado.
    $props = @($p.SelectNodes('w:pPr', $script:ns))
    if ($props.Count -eq 0) {
        $pr = $p.OwnerDocument.CreateElement('w', 'pPr', $w)
        [void]$p.PrependChild($pr)
    } else {
        $pr = $props[0]
        foreach ($extra in $props | Select-Object -Skip 1) {
            foreach ($child in @($extra.ChildNodes)) {
                if ($child.NodeType -ne [Xml.XmlNodeType]::Element) { continue }
                $old = $pr.SelectSingleNode("w:$($child.LocalName)", $script:ns)
                if ($old) { [void]$pr.RemoveChild($old) }
                [void]$pr.AppendChild($child)
            }
            [void]$p.RemoveChild($extra)
        }
    }
    [void](Set-Property $pr 'keepNext' @{val = $(if ($next) {'1'} else {'0'})})
    [void](Set-Property $pr 'keepLines' @{val = '1'})
}

function Set-TableWidth($table, [int[]]$widths) {
    $total = ($widths | Measure-Object -Sum).Sum
    $pr = $table.SelectSingleNode('w:tblPr', $script:ns)
    [void](Set-Property $pr 'tblW' @{type = 'dxa'; w = $total})
    [void](Set-Property $pr 'tblLayout' @{type = 'fixed'})
    $grid = @($table.SelectNodes('w:tblGrid/w:gridCol', $script:ns))
    if ($grid.Count -ne $widths.Count) { throw 'Numero de columnas inesperado.' }
    for ($i = 0; $i -lt $grid.Count; $i++) {
        [void]$grid[$i].SetAttribute('w', $w, [string]$widths[$i])
    }
    foreach ($row in $table.SelectNodes('w:tr', $script:ns)) {
        $cells = @($row.SelectNodes('w:tc', $script:ns))
        if ($cells.Count -ne $widths.Count) { throw 'Celdas combinadas no previstas.' }
        for ($i = 0; $i -lt $cells.Count; $i++) {
            $cp = $cells[$i].SelectSingleNode('w:tcPr', $script:ns)
            [void](Set-Property $cp 'tcW' @{type = 'dxa'; w = $widths[$i]})
        }
    }
}

function Get-ScaledWidths($table, [int]$targetTotal) {
    $grid = @($table.SelectNodes('w:tblGrid/w:gridCol', $script:ns))
    if ($grid.Count -eq 0) { throw 'Tabla sin tblGrid.' }
    $current = @($grid | ForEach-Object { [int]$_.GetAttribute('w', $w) })
    $sum = ($current | Measure-Object -Sum).Sum
    if ($sum -le 0) { throw 'Anchos de tabla invalidos.' }
    $scaled = @($current | ForEach-Object { [int][math]::Max(1, [math]::Floor($_ / $sum * $targetTotal)) })
    $scaled[-1] += $targetTotal - ($scaled | Measure-Object -Sum).Sum
    return ,$scaled
}

$fullPath = (Resolve-Path -LiteralPath $Path).Path
if ([IO.Path]::GetFileName($fullPath) -ne 'Investigacion_reproducible_con_R_y_Quarto.docx') {
    throw 'Solo se admite la salida del libro; nunca una plantilla.'
}
$zip = [IO.Compression.ZipFile]::Open($fullPath, [IO.Compression.ZipArchiveMode]::Update)
try {
    $entry = $zip.GetEntry('word/document.xml')
    $reader = [IO.StreamReader]::new($entry.Open())
    try { $xml = $reader.ReadToEnd() } finally { $reader.Dispose() }
    $document = [xml]$xml
    $script:ns = [Xml.XmlNamespaceManager]::new($document.NameTable)
    $script:ns.AddNamespace('w', $w)
    $section = $document.SelectSingleNode('//w:sectPr', $script:ns)
    $size = $section.SelectSingleNode('w:pgSz', $script:ns)
    $margin = $section.SelectSingleNode('w:pgMar', $script:ns)
    $usable = [int]$size.GetAttribute('w', $w) - [int]$margin.GetAttribute('left', $w) - [int]$margin.GetAttribute('right', $w)
    if ([math]::Abs($usable * 25.4 / 1440 - 120) -gt 0.2) {
        throw 'El ancho util no corresponde al formato 17 x 24 validado.'
    }
    $rootTag = [regex]::Match($xml, '<w:document\b[^>]*>').Value.Replace('<w:document', '<root')
    $replacements = @()
    $seen = @{}
    $depth = 0
    foreach ($token in [regex]::Matches($xml, '</?w:tbl\b[^>]*>')) {
        if ($token.Value.StartsWith('</')) {
            $depth--
            if ($depth -ne 0) { continue }
            $length = $token.Index + $token.Length - $start
            $fragment = $xml.Substring($start, $length)
            $labels = @($targets.Keys | Where-Object { $fragment.Contains('w:name="' + $_ + '"') })
            $genericTable = [regex]::Match($fragment, 'w:name="(tbl-[^"]+)"')
            if ($labels.Count -eq 0 -and $genericTable.Success) {
                $labels = @($genericTable.Groups[1].Value)
            }
            if ($labels.Count -eq 0) { continue }
            if ($labels.Count -ne 1) { throw 'Contenedor con varios labels seleccionados.' }
            $label = $labels[0]
            if ($seen.ContainsKey($label)) { throw "Label duplicado: $label" }
            $seen[$label] = $true
            $part = [Xml.XmlDocument]::new()
            $part.PreserveWhitespace = $true
            $part.LoadXml($rootTag + $fragment + '</root>')
            $table = $part.DocumentElement.FirstChild
            $before = ($table.SelectNodes('.//w:t', $script:ns) | ForEach-Object InnerText) -join "`0"
            Set-TableWidth $table @($usable)
            $cell = $table.SelectSingleNode('w:tr/w:tc', $script:ns)
            $cp = $cell.SelectSingleNode('w:tcPr', $script:ns)
            $cm = Set-Property $cp 'tcMar'
            foreach ($side in @('left', 'right')) {
                [void](Set-Property $cm $side @{type = 'dxa'; w = '0'})
            }
            $paragraphs = @($cell.SelectNodes('w:p', $script:ns))
            if ($label.StartsWith('tbl-')) {
                Keep-Paragraph $paragraphs[0] $true
                $inner = $cell.SelectSingleNode('w:tbl', $script:ns)
                if ($null -eq $inner) { throw "Tabla interna ausente: $label" }
                if ($targets.Contains($label) -and @($targets[$label]).Count -gt 0) {
                    $widths = @($targets[$label] | ForEach-Object { [int][math]::Floor($_ / 120 * $usable) })
                    $widths[-1] += $usable - ($widths | Measure-Object -Sum).Sum
                } else {
                    $widths = @(Get-ScaledWidths $inner $usable)
                }
                Set-TableWidth $inner $widths
                $rows = @($inner.SelectNodes('w:tr', $script:ns))
                $rp = Set-Property $rows[0] 'trPr'
                [void](Set-Property $rp 'tblHeader' @{val = '1'})
                foreach ($p in $rows[0].SelectNodes('w:tc/w:p', $script:ns)) { Keep-Paragraph $p $true }
                $rp = Set-Property $rows[1] 'trPr'
                [void](Set-Property $rp 'cantSplit')
                foreach ($p in $rows[1].SelectNodes('w:tc/w:p', $script:ns)) { Keep-Paragraph $p $false }
            } else {
                if ($paragraphs.Count -ne 2) { throw "Estructura de figura inesperada: $label" }
                Keep-Paragraph $paragraphs[0] $true
                Keep-Paragraph $paragraphs[1] $false
                $rp = Set-Property ($table.SelectSingleNode('w:tr', $script:ns)) 'trPr'
                [void](Set-Property $rp 'cantSplit')
            }
            $after = ($table.SelectNodes('.//w:t', $script:ns) | ForEach-Object InnerText) -join "`0"
            if ($after -cne $before) { throw "Cambio de contenido en $label" }
            $replacements += @{start = $start; length = $length; xml = $table.OuterXml}
            Write-Output "Maquetacion local: $label"
        } else {
            if ($depth -eq 0) { $start = $token.Index }
            $depth++
        }
    }
    $missingTargets = @($targets.Keys | Where-Object { -not $seen.ContainsKey($_) })
    if ($missingTargets.Count -gt 0) {
        throw ('Faltan objetos obligatorios: ' + ($missingTargets -join ', '))
    }
    foreach ($replacement in $replacements | Sort-Object { $_.start } -Descending) {
        $xml = $xml.Remove($replacement.start, $replacement.length).Insert($replacement.start, $replacement.xml)
    }
    $check = [Xml.XmlDocument]::new()
    $check.LoadXml($xml)
    $before = ($document.SelectNodes('//w:t', $script:ns) | ForEach-Object InnerText) -join "`0"
    $after = ($check.SelectNodes('//w:t', $script:ns) | ForEach-Object InnerText) -join "`0"
    if ($after -cne $before) { throw 'Contenido del documento alterado.' }
    $entry.Delete()
    $newEntry = $zip.CreateEntry('word/document.xml', [IO.Compression.CompressionLevel]::Optimal)
    $writer = [IO.StreamWriter]::new($newEntry.Open(), [Text.UTF8Encoding]::new($false))
    try { $writer.Write($xml) } finally { $writer.Dispose() }
    Write-Output "Maquetacion local: $($seen.Count) objetos etiquetados ajustados; ancho util $usable twips."
} finally { $zip.Dispose() }
