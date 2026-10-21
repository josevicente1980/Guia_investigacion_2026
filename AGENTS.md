# Project identity

Repositorio del libro académico “Investigación reproducible con R y Quarto”.

- Subtítulo: “Una guía práctica para estudiantes universitarios”.
- Autores comunes: José Vicente Ordóñez Yaguache; Yomara Karolina Ruiz Reyes; Kevin Marlow Jiménez Villavicencio; Andrea Yolanda Jaramillo Castillo.
- Tipo editorial: Monografía Individual.

# Source hierarchy

Antes de cualquier trabajo editorial, leer en este orden:

1. `00_conocimiento_editorial/README.md`.
2. `00_conocimiento_editorial/FUENTES.yml`.
3. El checklist editorial aplicable.
4. Las fuentes originales referenciadas.
5. `.agent/memory/DECISIONES_EDITORIALES.md`.
6. `.agent/memory/ESTADO_PROYECTO.md`.
7. `.agent/memory/CHECKPOINT_ACTUAL.md`.

Las reglas oficiales prevalecen sobre cualquier inferencia del agente. Antes del envío, verificar la vigencia de las directrices oficiales y del instructivo OMP; registrar cambios de fuente o requisito en Git. La IA asiste; las decisiones científicas, editoriales, legales y de autoría corresponden a los autores.

# Mandatory skills

Antes de cualquier cambio, aplicar `git-safe-change`. Aplicar además:

- `_quarto.yml`, capítulos, partes, filtros, estructura o render: `quarto-book-maintenance`.
- Word, `reference-doc`, tamaño, márgenes o maquetación: `docx-institutional-format`.
- Después de renderizar: `render-audit`.
- Cumplimiento UNL: `editorial-unl`.
- Figuras o tablas: `figures-tables-editorial`.
- Citas o bibliografía: `apa7-bibliography-audit`.
- Coma decimal, unidades o estilo técnico: `inen-technical-style`.
- Reducciones editoriales: `compact-manuscript`.
- Antes de declarar listo para envío: `submission-readiness`.

# Non-negotiable decisions

- Monografía Individual con cuatro autores comunes; no tratar como obra colectiva por capítulos.
- 29 capítulos numerados y 8 partes visibles no numeradas.
- La compactación general está cerrada. No reintroducir material eliminado sin autorización explícita.
- No modificar el título del libro.
- Objetivo institucional: 170 × 240 mm, vertical, márgenes de 25 mm en los cuatro lados.
- Nunca sobrescribir `plantillas/plantilla.docx` durante pruebas.
- No reabrir correcciones aceptadas sin evidencia nueva. Hacer cambios mínimos y focalizados; no mezclar bloques editoriales.

# Git safety

Antes de editar, ejecutar `git status -sb` y `git rev-parse HEAD`; detenerse ante cambios locales no autorizados. No usar `git reset`, `git restore` ni `git checkout` de forma destructiva sin autorización explícita. Antes de entregar, ejecutar `git diff --check`. No hacer commit ni push sin autorización explícita.

# Rendering

Renderizar solo cuando sea necesario. En Windows, si R falla por `LANG`, `LC_ALL` o `LC_CTYPE` configuradas como `C.UTF-8`, retirarlas solo del proceso de render. No modificar scripts R para resolver ese problema de entorno.

# Change policy and handoff

Editar lo mínimo necesario. No reescribir oportunistamente, mejorar secciones no solicitadas ni reabrir decisiones cerradas. Detenerse si surge una duda que pueda afectar la aceptación editorial.

Cada tarea importante termina con PASS / REVIEW / FAIL, archivos modificados, verificaciones, render si aplica, estado Git, problemas pendientes y confirmación de commit/push.
