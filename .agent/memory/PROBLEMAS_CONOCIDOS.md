# Problemas conocidos

**PROB-001 — Locale de Windows/R.** R puede heredar `LANG=C.UTF-8`, `LC_ALL=C.UTF-8` o `LC_CTYPE=C.UTF-8`, lo que puede romper `source(..., encoding="UTF-8")`. Retirar esas variables solo del proceso de render. No modificar scripts R.

**PROB-002 — Paginación.** Word y LibreOffice pueden producir conteos distintos. Word es la referencia editorial.

**PROB-003 — TOC.** La tabla de contenido se genera como campo Word, pero puede aparecer sin actualizar. No modificar capítulos para resolverlo.

**PROB-004 — Formato 17 × 24.** La paginación aumentó considerablemente. No compensar bajando márgenes o tipografía arbitrariamente.

**PROB-005 — Outputs.** Algunos outputs de R pueden crecer demasiado en 17 × 24. Corregir solo con reducción quirúrgica autorizada.

**PROB-006 — Captions.** La Figura 11.1 y otras figuras muestran numeración sin título descriptivo completo. Pendiente de un bloque de captions.

**PROB-007 — DOCX y LibreOffice.** No usar LibreOffice para sobrescribir el DOCX final si altera estilos o estructura.

**PROB-008 — Referencia a plantilla colectiva.** `00_conocimiento_editorial/FUENTES.yml` mantiene una referencia histórica a una plantilla de monografía colectiva, aunque la clasificación editorial aprobada del proyecto es Monografía Individual.

Estado: REVIEW.

Acción pendiente: reemplazar esa referencia únicamente cuando la plantilla oficial individual pueda identificarse y registrarse de forma inequívoca.

Regla: no utilizar la referencia colectiva para tomar decisiones sobre la estructura actual del libro.
