* Encoding: UTF-8.
* TÍTULO DE LA SINTAXIS:							   
* TABLAS 71 Caracteristicas Generales de la persona productora
* OPERACIÓN ESTADÍSTICA:													   
* Encuesta de Superficie y Producción Agropecuaria Continua ESPAC_2025		   
* UNIDAD TÉCNICA RESPONSABLE: 												   
* Dirección de Estadísticas Agropecuarias y Ambientales					   
* ENTIDAD EJECUTORA:														   
* Instituto Nacional de Estadística y Censos (INEC)							   
*==============================================================================*.
* Fecha de elaboración:          Marzo - 2023						   
* Fecha última modificación:   Abril - 2026	   
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
*1- Descargue la Bases de datos de caracteristicas generales"cgnac2025" de la página web: http://www.ecuadorencifras.gob.ec//estadisticas-agropecuarias-2/#

*2- Guarde la base y copie el directorio en:.
*get file = 'C:\....\cgnac2025.sav'.

USE ALL.
COMPUTE filter_$=(Productor = 1).
VARIABLE LABELS filter_$ 'Productor = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 70 SEXO                                 *
*==============================================================================*.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=cg_k100 DISPLAY=LABEL
  /TABLE BY cg_k100 [C][ROWPCT.TOTALN PCT40.1]
  /CATEGORIES VARIABLES=cg_k100 ORDER=A KEY=VALUE EMPTY=INCLUDE.


* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=grupo1 DISPLAY=NONE  /VLABELS VARIABLES=cg_k100 DISPLAY=LABEL
  /TABLE grupo1 [ROWPCT.TOTALN PCT40.1] BY cg_k100
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=grupo1 cg_k100 ORDER=A KEY=VALUE EMPTY=INCLUDE
 /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 70. CARACTERISTICAS GENERALES  DE LA PERSONA PRODUCTORA- SEXO' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.


*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 70 - INSTRUCCIÓN FORMAL                               *
*==============================================================================*.
* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=instrucción DISPLAY=LABEL
  /TABLE BY instrucción [C][ROWPCT.TOTALN PCT40.1]
  /CATEGORIES VARIABLES=instrucción ORDER=A KEY=VALUE EMPTY=INCLUDE.



* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=grupo1 DISPLAY=NONE  /VLABELS VARIABLES=instrucción DISPLAY=LABEL
  /TABLE grupo1 [ROWPCT.TOTALN PCT40.1] BY instrucción
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=grupo1 instrucción ORDER=A KEY=VALUE EMPTY=INCLUDE
 /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 70. CARACTERISTICAS GENERALES  DE LA PERSONA PRODUCTORA- INSTRUCCIÓN FORMAL' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 70 - AUTO IDENTIFICACIÓN ÉTNICA                              *
*==============================================================================*.
* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=cg_se_define DISPLAY=LABEL
  /TABLE BY cg_se_define [ROWPCT.TOTALN PCT40.1]
  /CATEGORIES VARIABLES=cg_se_define ORDER=A KEY=VALUE EMPTY=INCLUDE.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=grupo1 DISPLAY=NONE  /VLABELS VARIABLES=cg_se_define DISPLAY=LABEL
  /TABLE grupo1 [ROWPCT.TOTALN PCT40.1] BY cg_se_define
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=grupo1 cg_se_define ORDER=A KEY=VALUE EMPTY=INCLUDE
 /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 70. CARACTERISTICAS GENERALES  DE LA PERSONA PRODUCTORA- AUTO IDENTIFICACIÓN ÉTNICA' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 70 - EDAD                           *
*==============================================================================*.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=edad_rango DISPLAY=LABEL
  /TABLE BY edad_rango [ROWPCT.TOTALN PCT40.1]
  /CATEGORIES VARIABLES=edad_rango ORDER=A KEY=VALUE EMPTY=INCLUDE.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=grupo1 DISPLAY=NONE  /VLABELS VARIABLES=edad_rango DISPLAY=LABEL
  /TABLE grupo1 [ROWPCT.TOTALN PCT40.1] BY edad_rango
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=grupo1 edad_rango ORDER=A KEY=VALUE EMPTY=INCLUDE
 /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 70. CARACTERISTICAS GENERALES DE LA PERSONA PRODUCTORA- EDAD' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

FILTER OFF.
USE ALL.
EXECUTE.


