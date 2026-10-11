-- Ajusta las tablas DOCX al ancho disponible mediante proporciones
-- explícitas de columna. Dejar ColWidthDefault hacía que Pandoc/Word
-- repartiera el ancho según el contenido y algunas tablas quedaban
-- cortadas o con columnas prácticamente invisibles.
--
-- Para DOCX se asigna a cada columna una fracción igual del ancho total.
-- Pandoc interpreta estas fracciones de forma relativa dentro del ancho
-- disponible de la página definido por el reference-doc.

function Table(tbl)
  if FORMAT ~= "docx" then
    return nil
  end

  if tbl.colspecs == nil or #tbl.colspecs == 0 then
    return tbl
  end

  local n = #tbl.colspecs
  local width = 1 / n

  for i = 1, n do
    tbl.colspecs[i][2] = width
  end

  return tbl
end
