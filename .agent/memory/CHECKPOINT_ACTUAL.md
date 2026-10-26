# Checkpoint actual

Fecha: 2026-10-23
HEAD base del cierre visual: `14dcd96edc2fb689d9900cd30d3be6185892a266`

# Último bloque cerrado

Maquetación final y estructura DOCX.
Resultado: **PASS visual y estructural**.

# Bloque actual

Cierre editorial previo al paquete de entrega.
Estado: **PASS en maquetación, estructura, geometría, figuras, tablas, captions, APA 7 e INEN; REVIEW favorable en actualidad bibliográfica; TOC pendiente de actualización manual final en Word**.
La compilación final revisada del 2026-10-23 conserva las ocho partes y los capítulos 1–29. Las incidencias de ancho de tablas, captions/cabeceras separados y recorte de ejes fueron corregidas sin modificar contenido científico ni la plantilla.

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

Autorizar y delimitar un bloque específico de corrección de anchos, cortes de tablas y unión de captions, antes del cierre de maquetación. No aplicar ajustes globales de plantilla sin aprobación. APA 7 e INEN siguen cerrados; no reducir contenido para disminuir páginas.

# Auditoría final de maquetación y estructura — 2026-10-22

## Ejecución y evidencia

- Preflight: `## main...origin/main`, árbol limpio y HEAD esperado `78e26b2` confirmado.
- Una compilación completa `quarto render --to docx`, exitosa (código 0), con ejecución de las 42 fuentes. Un arranque previo se interrumpió antes de compilar porque el registro abierto dentro de `.render_tmp` impedía su limpieza; se trasladó el registro fuera de la carpeta. No se repitió una compilación completa.
- `LANG`, `LC_ALL` y `LC_CTYPE` se retiraron únicamente del proceso de render. No se persistieron cambios de locale.
- Salida: `reportes/Investigacion_reproducible_con_R_y_Quarto.docx`; coincide con `.render_tmp/Investigacion_reproducible_con_R_y_Quarto.docx`. SHA-256: `D333ABCD7D26F31A2B5DD7DB39A2AB6532271604E08C24E7EFC8FBB9168442D4`.
- Microsoft Word 16.0: **316 páginas** con TOC calculado en memoria. Apertura de solo lectura y cierre sin guardar; el SHA-256 del DOCX no cambió durante la auditoría.
- La exportación PDF mediante Word no concluyó y se canceló. Se obtuvieron en su lugar las **316 imágenes de página directamente desde Word mediante `Page.EnhMetaFileBits`**, además del texto paginado y el TOC. Se cerró la instancia de Word de auditoría.
- Inspección visual panorámica de las 316 páginas y ampliación de casos concretos; no se afirma una inspección al 100 % de cada página ni ausencia exhaustiva de defectos menores. Los defectos confirmados bastan para impedir el cierre visual.
- Evidencia local reconstruible, ignorada por Git: `00_conocimiento_editorial/auditorias/resultados/maquetacion_final/` (`render.log`, `structure.json`, `word_geometry.json`, `toc_word.txt`, `word_pages.json`, `page-001.png` a `page-316.png`, láminas panorámicas y scripts auxiliares). Las páginas citadas abajo son las de esta vista de Word, no las de LibreOffice.
- Fuentes institucionales locales contrastadas: instructivo OMP, p. 2 (170 × 240 mm), y plantilla original PDF, p. 2 (17 × 24 cm y márgenes de 2,5 cm). Esta tarea no constituye auditoría de vigencia web ni declaración de preparación para envío.

## Controles PASS

- **Preliminares:** título y cuatro autores, TOC, Acrónimos (pp. 8–9), Introducción (p. 9), Parte I (p. 10). No reaparecen Presentación, ¿Por qué este libro?, ¿A quién está dirigido? ni Cómo utilizar este libro como secciones independientes.
- **Estructura:** ocho partes visibles no numeradas como capítulos. Ubicación: I p. 10; II p. 22; III p. 37; IV p. 66; V p. 133; VI p. 170; VII p. 247; VIII p. 281.
- **Capítulos:** 1–29 consecutivos; las partes no consumen números. 42 H1, 144 H2 y 269 H3. Comparación secuencial de H1/H2/H3: sin saltos ni encabezados numerados duplicados. En el capítulo 27, Generación de HTML es 27.2.1, PDF 27.2.2 y Word 27.2.3; no aparece el 27.1.1 anómalo señalado como riesgo.
- **Finales:** Reflexión final pp. 307–308; Bibliografía pp. 308–315; Declaración de uso de inteligencia artificial pp. 315–316. Los tres títulos carecen de número y no hay capítulos después. Se conservan los 88 párrafos bibliográficos; no se reabrió APA 7.
- **Inventario:** 37 captions de figura y 122 de tabla; no se modifica contenido científico ni referencias.
- **Geometría:** una sola sección vertical. Word informa 481,9 × 680,3 pt (aprox. 170,00 × 240,00 mm); cuatro márgenes de 70,85 pt (aprox. 24,995 mm). OOXML: 9638 × 13606 twips y márgenes de 1417 twips. Sin secciones con geometría inesperada. Área útil aproximada: 120 × 190 mm.
- **Páginas en blanco:** ninguna accidental detectada en las 316 imágenes; tampoco hay páginas sin texto en la extracción paginada. No se observaron encabezados superpuestos ni ecuaciones cortadas en la revisión realizada.
- **Plantillas protegidas:** ambas intactas. SHA-256 original: `3B3ABB5E51FB8D59BDA36693F18C0BCF5D4F75F8E2FE4C437690DEE94DF1C771`; experimental: `AB363260620CA4C25D450D701B54217B020FBF49B691EED8D4D0FF797516FCF3`.

## TOC: PASS de contenido calculado / REVIEW de persistencia

El DOCX contiene un único campo `TOC \o "1-2" \h \z \u`, marcado para actualización y sin resultado almacenado. Word lo calculó en memoria: **186 entradas**, exactamente los 42 H1 y 144 H2 esperados, en el mismo orden, sin faltantes, extras ni duplicados. Incluye las ocho partes, los 29 capítulos y los finales. Los H3 no se incluyen, conforme a `toc-depth: 2`. La vista calculada ocupa pp. 1–8; comparte la primera página con título/autores y la última con Acrónimos. No se forzó ningún cambio de contenido ni se guardó la actualización en el DOCX.

Actualizar campos de la tabla de contenido en Word antes del envío final.

## Cierre de maquetación — 2026-10-23

Estado: **PASS**.

- Se revisó la compilación final en formato 17 × 24 cm después de las correcciones de maquetación.
- Las tablas problemáticas previamente identificadas (incluidas 3.1, 14.1, 16.6, 16.9, 23.5 y 25.1) se muestran dentro del ancho útil, sin pérdida visible de columnas.
- Los captions de tablas y figuras previamente separados quedaron asociados a sus objetos.
- Las Figuras 18.5 y 18.6 muestran completa la etiqueta final del eje X (`1250`) tras ampliar el margen y la expansión del eje.
- No se detectaron nuevos recortes, superposiciones ni defectos graves en las incidencias revisadas.
- El documento conserva la geometría editorial de 170 × 240 mm y márgenes de 25 mm.
- Las ocho partes permanecen visibles y los capítulos 1–29 mantienen numeración consecutiva.
- La paginación puede variar entre Word y otros motores; el número de páginas no constituye criterio de fallo.
- **Acción manual final obligatoria:** abrir el DOCX definitivo en Microsoft Word, actualizar todos los campos de la tabla de contenido y guardar antes del envío.
- No reabrir este bloque salvo que una nueva compilación cambie la maquetación o la Editorial solicite una corrección adicional.

# Próxima acción

Preparar el cierre editorial y el paquete de entrega: TOC final en Word, portada/contraportada, resumen de hasta 150 palabras, resolución definitiva de imágenes de cubierta y verificación administrativa de anexos/identificaciones. La actualidad bibliográfica permanece como REVIEW favorable documentado para valoración de la Editorial.

## Expediente documental — 2026-10-26

Estado: **PASS documental para la observación 1 del correo de subsanación**.

- Se recibieron por este chat las copias digitales de las cédulas de Yomara Karolina Ruiz Reyes, Kevin Marlow Jiménez Villavicencio y Andrea Yolanda Jaramillo Castillo.
- No se almacenan números de identificación ni copias de documentos personales en GitHub por tratarse de información sensible.
- Para la carga editorial, conservar estos tres PDF como anexos separados junto con la documentación ya disponible de José Vicente Ordóñez Yaguache.
- Próximo bloque pendiente: observación 2, portada y contraportada conforme a plantilla institucional, imagen de alta resolución y resumen de máximo 150 palabras.
