* Encoding: UTF-8.
* TÍTULO DE LA SINTAXIS:							   
* TABLAS 69 EMPLEO EN LOS TERRENOS
* OPERACIÓN ESTADÍSTICA:												   
* Encuesta de Superficie y Producción Agropecuaria Continua ESPAC_2025		   
* UNIDAD TÉCNICA RESPONSABLE: 												   
* Dirección de Estadísticas Agropecuarias y Ambientales					   
* ENTIDAD EJECUTORA:														   
* Instituto Nacional de Estadística y Censos (INEC)							   
*==============================================================================*.
* Fecha de elaboración:          Septiembre - 2014						   
* Fecha última modificación:   Abril- 2026   
*==============================================================================*.
* Elaborado por:													   
* Dirección de Estadísticas Agropecuarias y Ambientales (DEAGA)						   
* Gestión de Estadísticas Agropecuarias    						   
* Aprobado por:													   
* Dirección de Estadísticas Agropecuarias y Ambientales (DEAGA)						   
* Gestión de Estadísticas Agropecuarias  							       
*==============================================================================*.
* Revisado por:																   
* Dirección de Estadísticas Agropecuarias y Ambientales (DEAGA)						   
* Gestión de Estadísticas Agropecuarias     						   
*==============================================================================*.
*Indicaciones.
*1- Descargue la Bases de datos de empleo "eunac2025" de la página web: http://www.ecuadorencifras.gob.ec//estadisticas-agropecuarias-2/#

*2- Guarde la base y copie el directorio en:.
*get file = 'C:\....\eunac2025.sav'.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 68                                 *
*==============================================================================*.

WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=eu_tn eu_trs eu_trc eu_tro eu_znd ual_prov DISPLAY=NONE  /VLABELS VARIABLES=eu_k1301 
    eu_k1302 eu_k1303 eu_k1304 eu_k1305 eu_k1306 eu_k1307 eu_k1308 eu_k1309 eu_k1310 eu_k1311 eu_k1312 
    DISPLAY=LABEL
  /TABLE eu_tn + eu_trs + eu_trc + eu_tro + eu_znd + ual_prov BY eu_k1301 [SUM] + eu_k1302 [SUM] + eu_k1303 
    [SUM] + eu_k1304 [SUM] + eu_k1305 [SUM] + eu_k1306 [SUM] + eu_k1307 [SUM] + eu_k1308 [SUM] + 
    eu_k1309 [SUM] + eu_k1310 [SUM] + eu_k1311 [SUM] + eu_k1312 [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=eu_tn eu_trs eu_trc eu_tro eu_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 68. NÚMERO DE TRABAJADORES NO REMUNERADOS Y REMUNERADOS POR SEXO, SEGÚN REGIÓN '+
    'Y PROVINCIA'
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

WEIGHT OFF.
FILTER OFF.
USE ALL.
EXECUTE.
