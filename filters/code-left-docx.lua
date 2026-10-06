-- Alinea a la izquierda únicamente los bloques de código en DOCX.
-- El resto del documento conserva los estilos de la plantilla Word.

local function xml_escape(text)
  text = text:gsub("&", "&amp;")
  text = text:gsub("<", "&lt;")
  text = text:gsub(">", "&gt;")
  return text
end

local function codeblock_to_openxml(el)
  if FORMAT ~= "docx" then
    return nil
  end

  local lines = {}
  for line in (el.text .. "\n"):gmatch("(.-)\n") do
    table.insert(lines, line)
  end

  local runs = {}
  for i, line in ipairs(lines) do
    table.insert(
      runs,
      '<w:r><w:rPr><w:rStyle w:val="VerbatimChar"/></w:rPr>' ..
      '<w:t xml:space="preserve">' .. xml_escape(line) .. '</w:t></w:r>'
    )

    if i < #lines then
      table.insert(runs, '<w:r><w:br/></w:r>')
    end
  end

  local xml =
    '<w:p>' ..
      '<w:pPr>' ..
        '<w:pStyle w:val="SourceCode"/>' ..
        '<w:jc w:val="left"/>' ..
        '<w:ind w:left="0" w:right="0" w:firstLine="0"/>' ..
      '</w:pPr>' ..
      table.concat(runs) ..
    '</w:p>'

  return pandoc.RawBlock("openxml", xml)
end

function CodeBlock(el)
  return codeblock_to_openxml(el)
end
