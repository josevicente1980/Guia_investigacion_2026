-- Renderiza los bloques de código en DOCX como una secuencia de párrafos
-- independientes. Esto evita que Word distribuya los caracteres cuando el
-- estilo base del documento usa justificación completa.
--
-- El resto del documento conserva íntegramente los estilos de la plantilla.

local function xml_escape(text)
  text = text:gsub("&", "&amp;")
  text = text:gsub("<", "&lt;")
  text = text:gsub(">", "&gt;")
  return text
end

local function code_line_paragraph(line)
  local contenido = line
  if contenido == "" then
    contenido = " "
  end

  return
    '<w:p>' ..
      '<w:pPr>' ..
        '<w:pStyle w:val="SourceCode"/>' ..
        '<w:jc w:val="left"/>' ..
        '<w:ind w:left="0" w:right="0" w:firstLine="0"/>' ..
        '<w:spacing w:before="0" w:after="0"/>' ..
      '</w:pPr>' ..
      '<w:r>' ..
        '<w:rPr><w:rStyle w:val="VerbatimChar"/></w:rPr>' ..
        '<w:t xml:space="preserve">' .. xml_escape(contenido) .. '</w:t>' ..
      '</w:r>' ..
    '</w:p>'
end

function CodeBlock(el)
  if FORMAT ~= "docx" then
    return nil
  end

  local paragraphs = {}

  for line in (el.text .. "\n"):gmatch("(.-)\n") do
    table.insert(
      paragraphs,
      code_line_paragraph(line)
    )
  end

  return pandoc.RawBlock(
    "openxml",
    table.concat(paragraphs)
  )
end
