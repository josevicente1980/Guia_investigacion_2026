* Encoding: UTF-8.
* TÍTULO DE LA SINTAXIS:							   
* TABLAS 3. ÁRBOLES DISPERSOS	   
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
*1- Descargue la Bases de datos de árboles dispersos "adnac2025" de la página web: http://www.ecuadorencifras.gob.ec//estadisticas-agropecuarias-2/#

*2- Guarde la base y copie el directorio en:.
*get file = 'C:\....\adnac2025.sav'.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 3                                *
*==============================================================================*.
WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=ad_clavecu DISPLAY=NONE  /VLABELS VARIABLES=ad_k604 ad_prod ventas 
    DISPLAY=LABEL
  /TABLE ad_clavecu BY ad_k604 [SUM] + ad_prod [SUM] + ventas [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=ad_clavecu ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 3. NÚMERO DE ÁRBOLES DISPERSOS COSECHADOS, PRODUCCIÓN Y VENTAS'
    CORNER='ÁRBOLES DISPERSOS'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

WEIGHT OFF.
