# Auditoría metodológica y científica — capítulos 18 a 26

**Fecha:** 2026-10-11  
**Alcance:** transición a modelación, correlación y causalidad, regresión lineal, diagnóstico, variables categóricas, Logit/Probit, panel, espacial, multinivel y frontera estocástica.  
**Estado global:** **REVIEW**

## Correcciones realizadas

- Se separó terminología descriptiva/predictiva de terminología causal.
- Se corrigió el uso automático de «efecto» cuando la especificación solo identifica asociaciones.
- Se aclaró que «endógena» y «exógena» no son sinónimos automáticos de dependiente e independiente.
- Se eliminó el umbral rígido de correlación 0,80 como criterio de multicolinealidad y la recomendación automática de eliminar variables.
- Se reformuló la interpretación del valor p de Pearson para evitar expresiones del tipo «probabilidad de que sea azar».
- Se trató el VIF como diagnóstico continuo; los umbrales 5/10 quedan solo como referencias pedagógicas, no reglas universales.
- Se corrigió la lectura de residuos centrados en cero: con intercepto es una propiedad del ajuste OLS y no prueba ausencia de sesgo predictivo.
- Se reformularon interacciones como diferencias de pendientes, no como efectos causales.
- Se corrigió la interpretación de Odds Ratio: OR describe cambios multiplicativos en odds, no cambios directos en probabilidad.
- Se precisó el papel de la prueba de Hausman como comparación de compatibilidad/consistencia entre estimadores.
- Se reforzó que la descomposición de frontera estocástica entre ruido e ineficiencia depende de forma funcional y supuestos distributivos.
- Se aclaró que un menor AIC representa comparación relativa dentro del conjunto de modelos, no verdad del modelo.

## Estado por capítulo

| Capítulo | Estado | Hallazgo principal |
|---:|:---:|---|
| 18 | PASS | Terminología de variables, causalidad y multicolinealidad corregida |
| 19 | PASS | Correlación, valor p y causalidad interpretados con cautela |
| 20 | PASS | Diagnóstico introductorio y normalidad reformulados |
| 21 | PASS | Asociaciones parciales, ANOVA y residuos corregidos |
| 22 | PASS | Normalidad, homoscedasticidad y VIF sin reglas mecánicas |
| 23 | PASS | Interacciones expresadas como diferencias de pendientes |
| 24 | PASS | Logit/Probit y Odds Ratio corregidos |
| 25 | PASS | Hausman, heterogeneidad y residuos precisados |
| 26 | REVIEW | Enfoques avanzados correctos a nivel pedagógico; falta comprobar que las referencias y paquetes utilizados correspondan exactamente a las funciones y afirmaciones reportadas |

## Controles todavía pendientes

1. Verificar referencias metodológicas específicas y metadatos bibliográficos.
2. Confirmar versiones de paquetes y reproducibilidad del entorno.
3. Ejecutar render completo tras cerrar auditorías de contenido.
4. Revisar advertencias ocultas en un modo de auditoría con mensajes visibles.
5. Comprobar que ejemplos simulados estén identificados como tales en toda aparición relevante.

La modelación de los capítulos 18–26 ya no debe usar lenguaje causal salvo que se expliciten diseño y supuestos de identificación.
