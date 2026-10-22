# Checkpoint actual

Fecha: 2026-10-21
HEAD base aprobado: `c52eed4`

# Último bloque cerrado

Bloque 3: Partes I–VIII visibles en DOCX.
Resultado: PASS.

# Bloque actual

Bloque 4: Formato institucional Word 17 × 24.
Estado: REVIEW favorable.

# Métricas actuales

- A4 con partes: 226 páginas.
- 17 × 24 en Word: 315 páginas.
- Cambio: +89 páginas (+39,4 %).
- La extensión de 315 páginas en Word es aceptable y no requiere reducción por paginación.

# Auditoría visual

- Se realizó una auditoría visual externa y sistemática de las 320 páginas de la compilación DOCX nueva, incluida una comprobación específica de los elementos corregidos.
- Resultado del bloque de figuras, tablas y captions: PASS.
- No se detectaron figuras cortadas, tablas gravemente cortadas, captions vacíos o duplicados evidentes, superposiciones ni desbordamientos graves.
- Las ocho partes aparecen correctamente y la numeración de capítulos permanece continua de 1 a 29.
- Se confirmaron 37 figuras y 122 tablas, con numeración consecutiva.
- Los captions de las figuras 11.1, 12.1, 12.2 y 16.6 son descriptivos.
- La extensión aproximada de 315 páginas en Word es aceptable.
- El TOC sigue pendiente de actualización final. Las salidas de consola extensas que puedan permanecer corresponden a otro bloque y no reabren esta auditoría.
- Algunos outputs extensos y figuras de bajo valor informativo pueden optimizarse quirúrgicamente, sin reducir contenido solo para disminuir la paginación.
- La paginación observada mediante LibreOffice puede diferir de Word. Word sigue siendo la referencia editorial para el conteo final.

# Auditoría APA 7 y bibliografía — estado vigente, 2026-10-21

Estado: **PASS para APA 7 y consistencia bibliográfica**. APA 7 y actualidad bibliográfica son controles distintos.

- 88 referencias renderizadas, cero claves de cita sin resolver y cero duplicados visibles. Las 15 entradas BibTeX no citadas se conservaron fuera de la bibliografía renderizada.
- `wilkinson2016` conserva los 53 autores. La fuente editorial identifica a IJsbrand Jan Aalbersberg; en BibTeX se registraron sus iniciales APA como `I. J.`. El DOCX muestra `Aalbersberg, I. J.` y la abreviación APA de autores largos, sin `etal.` literal.
- DOI Wang confirmado y conservado. `redman1998` se mantiene sin DOI; DOI no incorporado por falta de verificación inequívoca. La ausencia de DOI no se considera un incumplimiento APA 7.
- `unesco2021` usa título oficial y URL de UNESCO.
- Guía y metodología ESPAC conservan 2026, respaldado por las fuentes oficiales. El año 2026 del manual se conserva sin inferencia; la falta de fecha explícita queda como observación editorial menor, no como fallo APA 7.
- `wooldridge2020` sigue siendo la única referencia Wooldridge visible y está identificada como séptima edición. La posible actualización corresponde al bloque de actualidad bibliográfica.
- Render DOCX exitoso. Se verificaron 8 partes, capítulos numerados 1–29 y cero tokens tipo cita sin resolver fuera del código.

## Actualidad bibliográfica / justificación de fuentes >5 años — 2026-10-21

Estado: **REVIEW favorable**, a la espera de valoración editorial de la excepción documentada. APA 7 y actualidad bibliográfica son controles distintos.

- La matriz `00_conocimiento_editorial/justificacion_actualidad_bibliografica.md` documenta las 69 referencias antiguas del punto de partida y sus capítulos, función, clasificación, justificación y decisión.
- De las cinco candidatas, se actualizaron Hernández Sampieri a la 2.ª edición (2023), Wooldridge a la 8.ª edición (2025) y Swales a la 3.ª edición (2012). Se mantuvieron Martín-Martín (estudio comparativo acotado a su periodo) y Ross-Hellauer (fuente de la taxonomía de revisión abierta).
- Referencias visibles: 88; >5 años al inicio: 69 (78,4 %); después de las actualizaciones: 67 (76,1 %).
- Las 67 restantes están justificadas en la matriz: 17 fundacionales, 44 metodológicas, 2 normativas/institucionales y 4 históricas. Referencias antiguas no justificadas: 0; indicador operativo: 0/88 = 0 %. Este indicador no es una fórmula oficial de la Editorial.
- No se eliminaron referencias por antigüedad. Las 15 entradas BibTeX no citadas se mantuvieron intactas.

# Auditoría de estilo técnico / INEN — 2026-10-21

Estado: **PASS**.

- Se revisaron las 42 fuentes `.qmd` activas: 2.563 líneas textuales no vacías examinadas, además de una búsqueda contextual de notación, unidades, cursivas y terminología.
- Se corrigieron cuatro separadores decimales en dos ejemplos narrativos: `3.25`/`0.05` → `3,25`/`0,05` y `4.12`/`0.05` → `4,12`/`0,05`.
- No se identificaron ceros iniciales omitidos, espacios valor-unidad que corregir, cursivas científicas/latinas omitidas ni inconsistencias terminológicas inequívocas.
- Los puntos decimales restantes encontrados pertenecen a código R y se conservaron.
- El instructivo UNL exige INEN/SI y coma decimal; los documentos locales no detallan el espaciado exacto de cada símbolo. La regla SI de espacio entre valor y símbolo (incluido `%` y `°C`) se contrastó con el folleto oficial del BIPM.
- El fallo técnico se resolvió en `R/libro_setup.R`: al cargar el archivo, sus helpers se exponen al entorno de ejecución de knitr, donde los chunks de Quarto pueden encontrarlos. No se duplicaron funciones ni se modificaron capítulos.
- Los cuatro scripts con avisos de entrada (`libro_setup.R`, `pre_render.R`, `preparar_objetos_libro.R` y `auditar_entorno.R`) son UTF-8 válido. Al retirar `LANG`, `LC_ALL` y `LC_CTYPE` solo del proceso de render, desaparecieron los avisos de locale/entrada inválida; no se convirtió ningún archivo.
- El render DOCX completo terminó correctamente. La inspección estructural del DOCX confirmó 8 partes, capítulos numerados 1–29 en secuencia, 37 captions de figura, 122 captions de tabla y 88 párrafos bibliográficos. El DOCX temporal y el de `reportes/` tienen el mismo SHA-256. Esta comprobación fue estructural; no constituye una nueva auditoría visual.

# Próxima acción

Continuar con el siguiente bloque editorial aprobado. El bloque INEN queda cerrado; no reducir contenido para disminuir páginas ni hacer compactación masiva o cambios arbitrarios de márgenes o tipografía.
