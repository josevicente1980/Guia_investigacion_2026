
* Encoding: UTF-8.
* TÍTULO DE LA SINTAXIS:							   
* TABLAS 57 MOVIMIENTO DE GANADO
* OPERACIÓN ESTADÍSTICA:													   
* Encuesta de Superficie y Producción Agropecuaria Continua ESPAC_2025
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
*1- Descargue la Bases de datos de movimiento de ganado"vgpnac2025" de la página web: http://www.ecuadorencifras.gob.ec//estadisticas-agropecuarias-2/#

*2- Guarde la base y copie el directorio en:.
*get file = 'C:\....\vgpnac2025.sav'.

*==============================================================================*.
*                            CONSTRUCCIÓN DE LA TABLA 56                                  *
*==============================================================================*.

WEIGHT BY fact_exp_fin.
* Tablas personalizadas.
CTABLES
  /VLABELS VARIABLES=vm_tn vm_trs vm_trc vm_tro vm_znd ual_prov DISPLAY=NONE  /VLABELS VARIABLES=TOTAL ventasm2m ventasmy2m 
    DISPLAY=LABEL
  /TABLE vm_tn + vm_trs + vm_trc + vm_tro + vm_znd + ual_prov BY TOTAL [SUM] + ventasm2m [SUM] + ventasmy2m 
    [SUM]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=vm_tn vm_trs vm_trc vm_tro  vm_znd  ual_prov ORDER=A KEY=VALUE EMPTY=INCLUDE
  /TITLES
    TITLE='ENCUESTA DE SUPERFICIE Y PRODUCCIÓN AGROPECUARIA CONTINUA 2025'
    'TABLA 56. NÚMERO DE CABEZAS DE GANADO PORCINO VENDIDAS, SEGUN REGIÓN Y PROVINCIA' 
    CORNER='REGIÓN Y PROVINCIA'
    CAPTION='INSTITUTO NACIONAL DE ESTADÍSTICA Y CENSOS (INEC) ESPAC - 2025'.

WEIGHT OFF.
FILTER OFF.
USE ALL.
EXECUTE.
