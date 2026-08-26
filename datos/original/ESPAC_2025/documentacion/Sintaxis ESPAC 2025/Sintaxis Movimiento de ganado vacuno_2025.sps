* Encoding: UTF-8.
* TÍTULO DE LA SINTAXIS:							   
* TABLAS 51-55 MOVIMIENTO DE GANADO
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
*1- Descargue la Bases de datos de movimiento de ganado"vmnac2025" de la página web: http://www.ecuadorencifras.gob.ec//estadisticas-agropecuarias-2/#

*2- Guarde la base y copie el directorio en:.
*get file = 'C:\....\vmnac2025.sav'.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 50                                   *
*==============================================================================*.

USE ALL.
COMPUTE filter_$=(vm_numl = 1).
VARIABLE LABELS filter_$ 'vm_numl = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd ual_prov DISPLAY=NONE  /VLABELS VARIABLES=vm_k821 
    vm_subtmachos vm_k822 vm_k823 vm_k824 vm_subthembras vm_k825 vm_k826 vm_k827 
    DISPLAY=LABEL
  /TABLE vm_tn + vm_trs + vm_trc + vm_tro +vm_znd + ual_prov BY vm_k821 [SUM] + vm_subtmachos [SUM] + 
    vm_k822 [SUM] + vm_k823 [SUM] + vm_k824 [SUM] + vm_subthembras [SUM] + vm_k825 [SUM] + vm_k826 
    [SUM] + vm_k827 [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 50. NÚMERO DE CABEZAS DE GANADO VACUNO COMPRADAS, SEGUN REGIÓN Y PROVINCIA' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.


WEIGHT OFF.
FILTER OFF.
USE ALL.
EXECUTE.
*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 51                              *
*==============================================================================*.

USE ALL.
COMPUTE filter_$=(vm_numl = 2).
VARIABLE LABELS filter_$ 'vm_numl = 2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=vm_tn vm_trs vm_trc vm_tro  vm_znd ual_prov DISPLAY=NONE  /VLABELS VARIABLES=vm_k821 
    vm_subtmachos vm_k822 vm_k823 vm_k824 vm_subthembras vm_k825 vm_k826 vm_k827 
    DISPLAY=LABEL
  /TABLE vm_tn + vm_trs + vm_trc + vm_tro +vm_znd + ual_prov BY vm_k821 [SUM] + vm_subtmachos [SUM] + 
    vm_k822 [SUM] + vm_k823 [SUM] + vm_k824 [SUM] + vm_subthembras [SUM] + vm_k825 [SUM] + vm_k826 
    [SUM] + vm_k827 [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=vm_tn vm_trs vm_trc vm_tro  vm_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 51. NÚMERO DE CABEZAS DE GANADO VACUNO PERDIDAS POR MUERTE, SEGUN REGIÓN Y PROVINCIA' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.


WEIGHT OFF.
FILTER OFF.
USE ALL.
EXECUTE.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 52                              *
*==============================================================================*.

USE ALL.
COMPUTE filter_$=(vm_numl = 3).
VARIABLE LABELS filter_$ 'vm_numl = 3 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd  ual_prov DISPLAY=NONE  /VLABELS VARIABLES=vm_k821 
    vm_subtmachos vm_k822 vm_k823 vm_k824 vm_subthembras vm_k825 vm_k826 vm_k827 
    DISPLAY=LABEL
  /TABLE vm_tn + vm_trs + vm_trc + vm_tro +vm_znd + ual_prov BY vm_k821 [SUM] + vm_subtmachos [SUM] + 
    vm_k822 [SUM] + vm_k823 [SUM] + vm_k824 [SUM] + vm_subthembras [SUM] + vm_k825 [SUM] + vm_k826 
    [SUM] + vm_k827 [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 52. NÚMERO DE CABEZAS DE GANADO VACUNO PERDIDAS POR OTRAS CAUSAS, SEGUN REGIÓN Y PROVINCIA' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.


WEIGHT OFF.
FILTER OFF.
USE ALL.
EXECUTE.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 53_1                                    *
*==============================================================================*.

USE ALL.
COMPUTE filter_$=(vm_numl = 4).
VARIABLE LABELS filter_$ 'vm_numl = 4 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd  ual_prov DISPLAY=NONE  /VLABELS VARIABLES=vm_k821 
    vm_subtmachos vm_k822 vm_k823 vm_k824 vm_subthembras vm_k825 vm_k826 vm_k827 
    DISPLAY=LABEL
  /TABLE vm_tn + vm_trs + vm_trc + vm_tro + vm_znd + ual_prov BY vm_k821 [SUM] + vm_subtmachos [SUM] + 
    vm_k822 [SUM] + vm_k823 [SUM] + vm_k824 [SUM] + vm_subthembras [SUM] + vm_k825 [SUM] + vm_k826 
    [SUM] + vm_k827 [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCION AGROPECUARIA CONTINUA 2025'
    'TABLA 53. NÚMERO DE CABEZAS DE GANADO VACUNO SACRIFICADAS PARA AUTOCONSUMO, SEGUN REGIÓN Y PROVINCIA' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

WEIGHT OFF.
FILTER OFF.
USE ALL.
EXECUTE.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 53_2                            *
*==============================================================================*.

USE ALL.
COMPUTE filter_$=(vm_numl = 5).
VARIABLE LABELS filter_$ 'vm_numl = 5 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd ual_prov DISPLAY=NONE  /VLABELS VARIABLES=vm_k821 
    vm_subtmachos vm_k822 vm_k823 vm_k824 vm_subthembras vm_k825 vm_k826 vm_k827 
    DISPLAY=LABEL
  /TABLE vm_tn + vm_trs + vm_trc + vm_tro +vm_znd + ual_prov BY vm_k821 [SUM] + vm_subtmachos [SUM] + 
    vm_k822 [SUM] + vm_k823 [SUM] + vm_k824 [SUM] + vm_subthembras [SUM] + vm_k825 [SUM] + vm_k826 
    [SUM] + vm_k827 [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd  ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 53. NÚMERO DE CABEZAS DE GANADO VACUNO SACRIFICADAS PARA LA VENTA DE CARNE, SEGUN REGIÓN Y PROVINCIA' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

WEIGHT OFF.
FILTER OFF.
USE ALL.
EXECUTE.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA NACIDOS                                    *
*==============================================================================*.

USE ALL.
COMPUTE filter_$=(vm_numl = 6).
VARIABLE LABELS filter_$ 'vm_numl = 6 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

WEIGHT BY fact_exp_fin.

* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd ual_prov DISPLAY=NONE  /VLABELS VARIABLES=vm_k821 
 vm_k822 vm_k825 
    DISPLAY=LABEL
  /TABLE vm_tn + vm_trs + vm_trc + vm_tro +vm_znd + ual_prov BY vm_k821 [SUM] + vm_k822 [SUM] + vm_k825 [SUM] 
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 49. NÚMERO DE CABEZAS DE GANADO VACUNO NACIDOS VIVOS, SEGUN REGIÓN Y PROVINCIA' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

WEIGHT OFF.
FILTER OFF.
USE ALL.
EXECUTE.


