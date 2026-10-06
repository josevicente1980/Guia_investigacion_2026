# Auditoría estructural y editorial inicial — Editorial UNL

**Fecha:** 2026-10-05  
**Rama:** `main`  
**Alcance:** estructura del repositorio, configuración Quarto, front matter, trazabilidad editorial y requisitos vigentes UNL.  
**Estado global:** **BLOCK**

> Esta auditoría es inicial. No sustituye la auditoría de contenido, referencias, código, figuras, tablas, estilo ni paquete final.

## Resumen ejecutivo

La obra dispone de una base técnica sólida: proyecto Quarto tipo libro, 35 capítulos, bibliografía BibTeX, CSL APA, salida Word y sitio HTML. Sin embargo, todavía no puede declararse lista para envío porque existen decisiones editoriales y controles críticos pendientes.

**Decisión de autor confirmada:** la obra se presentará como **Libro académico**. Por contenido y estructura, el subtipo institucional compatible es **Monografía académica**, categoría que la Editorial UNL define para obras de autoría individual o colectiva que desarrollan de manera estructurada y completa una temática con aporte disciplinar sustentado en investigación o reflexión académica. El formato objetivo es **24 × 17 cm**. Permanece pendiente únicamente confirmar la variante de plantilla aplicable: individual o colectiva por capítulos.

## Controles

| Área | Hallazgo | Estado | Acción |
|---|---|---:|---|
| Arquitectura | Proyecto Quarto `type: book` con 35 capítulos declarados | PASS | Mantener |
| Salida editorial | Se genera Word editable mediante Quarto | PASS | Mantener y validar render final |
| Bibliografía | Existe `referencias/referencias.bib` y CSL APA | PASS | Auditar contenido y correspondencia |
| Tablas/figuras | Configuración coloca tablas arriba y figuras abajo | PASS | Verificar cada objeto |
| Naturaleza de la obra | Autor confirma **Libro académico** | **PASS** | Mantener esta decisión como objetivo editorial |
| Plantilla | `plantillas/plantilla.docx` está configurada como `reference-doc`, pero no se ha verificado contra la plantilla oficial aplicable | **BLOCK** | Verificar/reconstruir tras confirmar tipología |
| Subtipo y tamaño | **Monografía académica**, formato objetivo **24 × 17 cm** | **PASS** | Confirmar márgenes/estilos con plantilla aplicable |
| IA | No se encontró una declaración de uso de IA en la obra | **BLOCK** | Incorporar declaración final conforme a UNL |
| Contraportada | No se encontró resumen editorial ≤180 palabras | **BLOCK** | Redactar y auditar |
| Portada | No constan tres propuestas de imagen de portada en el paquete | **BLOCK** | Preparar al cierre con derechos verificados |
| Referencias | Falta auditoría de APA 7, citas↔bibliografía y antigüedad | REVIEW | Automatizar controles; revisar excepciones justificadas |
| Figuras | Falta auditoría de resolución ≥300 ppp y derechos de uso | REVIEW | Crear preflight reproducible |
| Tablas | Falta comprobar que todas sean editables y no imágenes | REVIEW | Auditar render y fuente |
| Ecuaciones | Falta comprobar editabilidad en Word | REVIEW | Auditar muestra y render final |
| Front matter | Presentación, prólogo y “Cómo utilizar este libro” existen, pero deben mapearse a la plantilla aplicable | REVIEW | Ajustar después de resolver tipología |
| Prólogo | El prólogo actual está firmado por los tres autores de la obra | REVIEW | Confirmar si debe mantenerse como prólogo o convertirse en prefacio/presentación |
| Introducción de la obra | El capítulo 28 enseña a redactar una introducción; no equivale necesariamente a una introducción propia del libro | REVIEW | Verificar estructura editorial de la obra |
| Cierre de la obra | El capítulo 32 enseña conclusiones/recomendaciones; no equivale necesariamente a un cierre propio del libro | REVIEW | Incorporar reflexión/conclusión final si la plantilla lo requiere |
| Fecha | `date: today` cambia en cada render | REVIEW | Sustituir por fecha editorial controlada o retirar hasta cierre |
| Archivo de salida | `output-file` incluye `.docx`; ya se observó localmente una salida `.docx.docx` | REVIEW | Corregir configuración y comprobar una vez |
| Dependencias | No se encontró `renv` ni un lockfile | REVIEW | Inicializar dependencias reproducibles antes del audit final |
| Diagnóstico | `warning: false` y `message: false` ocultan señales durante render | REVIEW | Crear modo de auditoría con avisos visibles |
| Higiene Git | `.Rproj.user` aparece versionado pese a estar en `.gitignore` | REVIEW | Retirarlo del índice sin borrar configuración local |
| Generados | `docs/` y `reportes/` contienen productos generados versionados | REVIEW | Definir política explícita: Pages vs artefactos editoriales |

## Requisitos UNL incorporados al control permanente

La fuente web oficial vigente exige, entre otros elementos:

- Word editable único y versión final revisada;
- plantilla institucional aplicable;
- tres imágenes propuestas para portada;
- resumen de contraportada de máximo 180 palabras;
- APA 7 y correspondencia citas↔referencias;
- recomendación de que bibliografía con más de cinco años no supere el 20%;
- tablas editables y figuras ≥300 ppp;
- declaración de uso de IA al final, después de las referencias;
- expediente completo y nomenclatura clara de archivos.

La regla de antigüedad bibliográfica **no debe aplicarse de forma mecánica**: se auditará y se justificarán fuentes clásicas, metodológicas, normativas o históricas cuando sean científicamente necesarias.

## Orden de corrección

1. Confirmar la variante de plantilla **obra individual vs. obra colectiva por capítulos**.
2. Ajustar la configuración Quarto y la política de archivos generados para la monografía académica.
3. Localizar, validar o reconstruir el `reference-doc` según la plantilla oficial aplicable.
4. Crear auditoría reproducible de citas, bibliografía, tablas, figuras y dependencias.
5. Auditar los 35 capítulos por bloques, sin reescribir masivamente.
6. Incorporar front matter/back matter faltante, incluida declaración de IA.
7. Renderizar Word final y ejecutar auditoría editorial.
8. Preparar paquete OMP y expediente administrativo.

## Regla de cierre

**SUBMISSION READY: NO.**

Persisten controles críticos en **BLOCK**. La naturaleza y el subtipo de la obra ya quedaron confirmados como **Libro académico — Monografía académica**. El siguiente punto a resolver es la variante de plantilla institucional aplicable.
