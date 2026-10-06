# Decisión editorial — libro académico y subtipo UNL

**Fecha:** 2026-10-05  
**Decisión del autor:** presentar la obra como **Libro académico**.

## Clasificación institucional

Con base en la tipología vigente de la Editorial Universitaria de la UNL, la obra encaja como **Monografía académica** porque desarrolla de forma estructurada y completa una temática académica —investigación reproducible con R y Quarto— y la sustenta en contenidos metodológicos, científicos y de reflexión académica.

La Editorial UNL define para las monografías académicas un formato de **24 × 17 cm**.

## Variante de plantilla

La Editorial distingue entre:

- **Plantilla obra individual**: “UNL - Monografía Individual”.
- **Plantilla obra colectiva**: “UNL - Monografía Colectiva - Autores por Capítulo”.

La obra actual tiene tres autores declarados para el volumen completo y no presenta, en su configuración Quarto, autorías distintas por capítulo. Por ello, la plantilla **colectiva por capítulos** no parece corresponder. Antes de reconstruir el `reference-doc`, debe verificarse si la Editorial denomina “obra individual” a la monografía con autoría común de todo el volumen aunque existan varios coautores.

## Implicaciones técnicas

- Mantener `project.type: book` en Quarto.
- Objetivo editorial: **Libro académico — Monografía académica**.
- Tamaño editorial objetivo: **24 × 17 cm**.
- No aplicar el formato de guía/folleto.
- La selección entre plantilla individual/colectiva permanece en **REVIEW** hasta confirmar la interpretación institucional.

## Estado

**PASS — naturaleza de la obra: Libro académico.**  
**PASS — subtipo: Monografía académica.**  
**REVIEW — variante de plantilla: individual vs. colectiva.**
