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

## Actualidad bibliográfica / justificación de fuentes antiguas — pendiente independiente

El checklist dice: «Bibliografía >5 años no supera el 20%, salvo justificación por fuentes clásicas/normativas». El propio checklist aclara que no se deben eliminar mecánicamente fuentes clásicas, metodológicas, normativas o históricas necesarias. La fuente no define denominador ni método de justificación.

- Referencias visibles: 88; con más de cinco años: 69 (78,4 % bruto).
- Clasificación funcional: 16 fundacionales, 43 metodológicas, 2 normativas/institucionales, 3 históricas y 5 potencialmente actualizables.
- Candidatas para revisión posterior, sin sustituirlas todavía: `wooldridge2020`, `hernandezsampieri2018`, `martinmartin2018`, `rossheller2017` y `swales2004`.

# Próxima acción

Actualidad bibliográfica y justificación editorial de fuentes >5 años.

Después, ejecutar la auditoría INEN. No reducir contenido para disminuir páginas ni hacer compactación masiva o cambios arbitrarios de márgenes o tipografía.
