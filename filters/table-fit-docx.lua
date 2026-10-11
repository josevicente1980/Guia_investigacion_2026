-- Ajuste de tablas para DOCX -------------------------------------------------
-- El reference-doc del libro usa 17 x 24 cm con márgenes de 2,5 cm.
-- Pandoc calcula las proporciones de tabla sobre un ancho base mayor que
-- el ancho útil real de esta plantilla. Por ello se usa TARGET_TOTAL = 0.85,
-- que deja la tabla dentro del ancho útil y evita desbordamientos.
--
-- Además, las celdas se fuerzan al estilo "Table Text" de la plantilla
-- (Times New Roman 10 pt, sin sangría de primera línea). Esto evita que
-- hereden la sangría del estilo Normal, que estrechaba artificialmente las
-- celdas y partía encabezados y valores en varias líneas.

local TARGET_TOTAL = 0.85
local MIN_WEIGHT = 4
local MAX_WEIGHT = 18

local function text_len(s)
  if utf8 and utf8.len then
    local n = utf8.len(s)
    if n then return n end
  end
  return #s
end

local function longest_token(text)
  local longest = 0
  for token in string.gmatch(text or "", "%S+") do
    local n = text_len(token)
    if n > longest then
      longest = n
    end
  end
  return longest
end

local function add_row_weights(row, weights)
  local col = 1

  for _, cell in ipairs(row.cells or {}) do
    local span = cell.col_span or 1
    local text = pandoc.utils.stringify(cell.contents)
    local needed = longest_token(text)

    if needed < MIN_WEIGHT then needed = MIN_WEIGHT end
    if needed > MAX_WEIGHT then needed = MAX_WEIGHT end

    local per_col = math.max(MIN_WEIGHT, needed / span)

    for j = col, math.min(#weights, col + span - 1) do
      if per_col > weights[j] then
        weights[j] = per_col
      end
    end

    col = col + span
  end
end

local function style_row(row)
  for _, cell in ipairs(row.cells or {}) do
    if cell.contents and #cell.contents > 0 then
      cell.contents = {
        pandoc.Div(
          cell.contents,
          pandoc.Attr("", {}, {["custom-style"] = "Table Text"})
        )
      }
    end
  end
end

local function each_row(tbl, fn)
  if tbl.head and tbl.head.rows then
    for _, row in ipairs(tbl.head.rows) do fn(row) end
  end

  for _, body in ipairs(tbl.bodies or {}) do
    for _, row in ipairs(body.head or {}) do fn(row) end
    for _, row in ipairs(body.body or {}) do fn(row) end
  end

  if tbl.foot and tbl.foot.rows then
    for _, row in ipairs(tbl.foot.rows) do fn(row) end
  end
end

function Table(tbl)
  if FORMAT ~= "docx" then
    return nil
  end

  if tbl.colspecs == nil or #tbl.colspecs == 0 then
    return tbl
  end

  local n = #tbl.colspecs
  local weights = {}

  for i = 1, n do
    weights[i] = MIN_WEIGHT
  end

  each_row(tbl, function(row)
    add_row_weights(row, weights)
  end)

  local total = 0
  for i = 1, n do
    total = total + weights[i]
  end

  if total <= 0 then
    total = n
    for i = 1, n do weights[i] = 1 end
  end

  for i = 1, n do
    tbl.colspecs[i][2] = TARGET_TOTAL * weights[i] / total
  end

  each_row(tbl, style_row)

  return tbl
end
