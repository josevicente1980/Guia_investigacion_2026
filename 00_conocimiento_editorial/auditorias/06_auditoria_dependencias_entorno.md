# Auditoría de dependencias y entorno

**Fecha:** 2026-10-11  
**Estado:** **REVIEW**

La lista de dependencias utilizadas por el libro quedó centralizada en `R/auditar_entorno.R`. El pre-render comprobará que los paquetes requeridos y Quarto CLI estén disponibles y guardará, de forma local y no versionada, las versiones detectadas en:

- `00_conocimiento_editorial/auditorias/resultados/entorno_paquetes.csv`
- `00_conocimiento_editorial/auditorias/resultados/resumen_entorno.md`

Este control evita renders parcialmente reproducibles por dependencias faltantes y documenta el entorno real utilizado.

## Estado

- Inventario de paquetes requeridos: **PASS**
- Verificación automática antes del render: **PASS**
- Registro local de versiones utilizadas: **PASS**
- Bloqueo exacto de versiones mediante `renv.lock`: **REVIEW**

La auditoría no instalará paquetes automáticamente. Un entorno incompleto debe detener el render y reportar qué dependencia falta. La incorporación de `renv` se realizará únicamente después de confirmar un render limpio, para congelar un entorno que sabemos que funciona.
