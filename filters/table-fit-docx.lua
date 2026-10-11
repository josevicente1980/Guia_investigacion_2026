-- Evita que las tablas DOCX hereden anchos de columna que excedan
-- el ancho útil de la página. En Word, dejar el ancho sin especificar
-- permite que el escritor DOCX de Pandoc adapte las columnas al espacio
-- disponible del documento de referencia.
--
-- Solo actúa sobre DOCX; no modifica HTML, PDF u otros formatos.

function Table(tbl)
  if FORMAT ~= "docx" then
    return nil
  end

  if tbl.colspecs == nil then
    return tbl
  end

  tbl.colspecs = tbl.colspecs:map(function(colspec)
    return { colspec[1], nil }
  end)

  return tbl
end
