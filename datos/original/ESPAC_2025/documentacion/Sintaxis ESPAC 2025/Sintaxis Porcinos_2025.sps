* Encoding: UTF-8.
* TÍTULO DE LA SINTAXIS:							   
* TABLAS 10, 57,  58 y 59 GANADO PORCINO
* OPERACIÓN ESTADÍSTICA:													   
* Encuesta de Superficie y Producción Agropecuaria Continua ESPAC_2023			   
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
*1- Descargue la Bases de datos de ganado porcino"gpnac2025" de la página web: http://www.ecuadorencifras.gob.ec//estadisticas-agropecuarias-2/#

*2- Guarde la base y copie el directorio en:.
*get file = 'C:\....\gpnac2025.sav'.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 10                                    *
*==============================================================================*.


WEIGHT BY fact_exp_fin.
* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=gp_tn gp_trs gp_trc gp_tro gp_znd ual_prov DISPLAY=NONE  /VLABELS 
    VARIABLES=gp_k901 DISPLAY=LABEL
  /TABLE gp_tn + gp_trs + gp_trc + gp_tro  + gp_znd + ual_prov BY gp_k901 [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=gp_tn gp_trs gp_trc gp_tro gp_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE.    

WEIGHT OFF. 
FILTER OFF. 
USE ALL. 
EXECUTE.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 56                               *
*==============================================================================*.

WEIGHT BY fact_exp_fin.
* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=gp_tn gp_trs gp_trc gp_tro gp_znd ual_prov DISPLAY=NONE  /VLABELS VARIABLES=gp_k901 
    gp_k902 gp_k903 DISPLAY=LABEL
  /TABLE gp_tn [C] + gp_trs [C] + gp_trc [C] + gp_tro [C] + gp_znd [C]  + ual_prov [C] BY gp_k901 [SUM] + gp_k902 
    [SUM] + gp_k903 [SUM] 
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=gp_tn gp_trs gp_trc gp_tro gp_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 56. NÚMERO DE CABEZAS DE GANADO PORCINO, SEGÚN REGIÓN Y PROVINCIA'
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

WEIGHT OFF. 
FILTER OFF. 
USE ALL. 
EXECUTE.
*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 57                                    *
*==============================================================================*.

WEIGHT BY fact_exp_fin.
* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=gp_tn gp_trs gp_trc gp_tro  gp_znd ual_prov  DISPLAY=NONE  /VLABELS VARIABLES=gp_total_por_raza gp_deraza 
    gp_mestizo gp_criollo DISPLAY=LABEL
  /TABLE gp_tn [C] + gp_trs [C] + gp_trc [C] + gp_tro [C]  + gp_znd [C] + ual_prov [C] BY 
    gp_total_por_raza [S][SUM] + gp_deraza [S][SUM] + gp_mestizo [S][SUM] + gp_criollo [S][SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=gp_tn gp_trs gp_trc gp_tro  gp_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 57. NÚMERO DE CABEZAS DE GANADO PORCINO POR VARIEDAD GENÉTICA'
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

WEIGHT OFF. 
FILTER OFF. 
USE ALL. 
EXECUTE.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 58                                 *
*==============================================================================*.

WEIGHT BY fact_exp_fin.
* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=gp_tn gp_trs gp_trc gp_tro  gp_znd ual_prov DISPLAY=NONE  /VLABELS 
    VARIABLES=gp_totanio_ntp DISPLAY=LABEL
  /TABLE gp_tn + gp_trs + gp_trc + gp_tro +gp_znd + ual_prov BY gp_totanio_ntp [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=gp_tn gp_trs gp_trc gp_tro gp_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE   
 /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 58. NÚMERO DE CABEZAS DE GANADO PORCINO AL AÑO'
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

WEIGHT OFF. 
FILTER OFF. 
USE ALL. 
EXECUTE.

