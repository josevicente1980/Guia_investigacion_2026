* Encoding: UTF-8.
* TÍTULO DE LA SINTAXIS:							   
* TABLAS 10 y 60 GANADO OVINO
* OPERACIÓN ESTADÍSTICA:													   
* Encuesta de Superficie y Producción Agropecuaria Continua ESPAC_2025		   
* UNIDAD TÉCNICA RESPONSABLE: 												   
* Dirección de Estadísticas Agropecuarias y Ambientales					   
* ENTIDAD EJECUTORA:														   
* Instituto Nacional de Estadística y Censos (INEC)							   
*==============================================================================*.
* Fecha de elaboración:          Septiembre - 2014						   
* Fecha última modificación:  Abril- 2026   
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
*1- Descargue la Bases de datos de ganado ovino"gvnac2025" de la página web: http://www.ecuadorencifras.gob.ec//estadisticas-agropecuarias-2/#

*2- Guarde la base y copie el directorio en:.
*get file = 'C:\....\gvnac2025.sav'.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 10                                    *
*==============================================================================*.


WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=gv_tn gv_trs gv_trc gv_tro gv_znd ual_prov DISPLAY=NONE  /VLABELS 
    VARIABLES=gv_k1001 DISPLAY=LABEL
  /TABLE gv_tn + gv_trs + gv_trc + gv_tro + gv_znd + ual_prov BY gv_k1001 [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=gv_tn gv_trs gv_trc gv_tro gv_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE.    

WEIGHT OFF. 
FILTER OFF. 
USE ALL. 
EXECUTE.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 59                                    *
*==============================================================================*.


WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=gv_tn gv_trs gv_trc gv_tro gv_znd  ual_prov DISPLAY=NONE  /VLABELS VARIABLES=gv_k1001 
    gv_k1002 gv_k1003 DISPLAY=LABEL
  /TABLE gv_tn [C] + gv_trs [C] + gv_trc [C] + gv_tro [C] + gv_znd [C] + ual_prov [C] BY gv_k1001 [S][SUM] + 
    gv_k1002 [S][SUM] + gv_k1003 [S][SUM] 
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=gv_tn gv_trs gv_trc gv_tro gv_znd  ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 59. NÚMERO DE CABEZAS DE GANADO OVINO, SEGÚN REGIÓN Y PROVINCIA' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.


WEIGHT OFF. 
FILTER OFF. 
USE ALL. 
EXECUTE.
