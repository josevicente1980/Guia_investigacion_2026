* Encoding: UTF-8.
* TÍTULO DE LA SINTAXIS:							   
* TABLAS 70 PASTOS CULTIVADOS
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
*1- Descargue la Bases de datos de pastos cultivados"pcnac2025" de la página web: http://www.ecuadorencifras.gob.ec//estadisticas-agropecuarias-2/#

*2- Guarde la base y copie el directorio en:.
*get file = 'C:\....\pcnac2025.sav'.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 69                               *
*==============================================================================*.
WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=pc_tn pc_trs pc_trc pc_tro pc_znd ual_prov DISPLAY=NONE  /VLABELS 
    VARIABLES=Total Brachiaria Gramalote Pasto_miel Saboya Pasto_mixto Otros_pastos 
    DISPLAY=LABEL
  /TABLE pc_tn + pc_trs + pc_trc + pc_tro + pc_znd + ual_prov BY Total [SUM] + Brachiaria [SUM] + 
    Gramalote [SUM] + Pasto_miel [SUM] + Saboya [SUM] + Pasto_mixto [SUM] + Otros_pastos [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=pc_tn pc_trs pc_trc pc_tro pc_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 69. SUPERFICIE PLANTADA CON PASTOS CULTIVADOS, SEGUN REGIÓN Y PROVINCIA'
    CORNER='PROVINCIA Y REGIÓN'
    CAPTION='Fuente INEC 2025'.

WEIGHT OFF.
