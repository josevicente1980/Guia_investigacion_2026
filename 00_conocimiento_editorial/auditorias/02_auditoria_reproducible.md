# Auditoría reproducible de estructura, citas y bibliografía

Ejecutar desde la raíz del proyecto:

```r
source("R/auditar_libro.R")
```

La auditoría usa únicamente **base R** y genera resultados en:

`00_conocimiento_editorial/auditorias/resultados/`

Controles:

- claves de cita presentes en los archivos QMD;
- citas sin entrada en `referencias/referencias.bib`;
- referencias BibTeX no citadas;
- año de las referencias;
- porcentaje de referencias con más de cinco años.

La antigüedad bibliográfica se clasifica como control editorial. No debe eliminarse una referencia clásica, normativa, metodológica o histórica únicamente por su fecha.

Estados:

- **PASS**: control superado;
- **REVIEW**: requiere revisión científica/editorial;
- **BLOCK**: inconsistencia crítica que debe corregirse.
