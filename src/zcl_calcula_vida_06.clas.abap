CLASS zcl_calcula_vida_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    " Definimos una estructura para devolver los resultados
    TYPES: BEGIN OF ty_tiempo_vida,
             dias    TYPE i,
             semanas TYPE i,
             meses   TYPE i,
           END OF ty_tiempo_vida.

  PRIVATE SECTION.
    " Método interno para hacer los cálculos
    METHODS calcular_estadisticas
      IMPORTING iv_fecha_nacimiento TYPE d
      RETURNING VALUE(rs_vida)      TYPE ty_tiempo_vida.

ENDCLASS.



CLASS ZCL_CALCULA_VIDA_06 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " --- CONFIGURACIÓN: Pon aquí tu fecha de nacimiento (Formato AAAAMMDD) ---
    CONSTANTS c_mi_nacimiento TYPE d VALUE '19940526'.

    " Obtenemos los cálculos
    DATA(ls_mi_vida) = me->calcular_estadisticas( c_mi_nacimiento ).

    " Mostramos los resultados en la consola (F9)
    out->write( |*** ESTADÍSTICAS DE VIDA PARA Antonio Cordero ***| ).
    out->write( |Fecha de nacimiento: { c_mi_nacimiento DATE = ISO }| ).
    out->write( |-------------------------------------------| ).
    out->write( |Días vividos:    { ls_mi_vida-dias }| ).
    out->write( |Semanas vividas: { ls_mi_vida-semanas }| ).
    out->write( |Meses vividos:   { ls_mi_vida-meses } (aprox)| ).
  ENDMETHOD.


  METHOD calcular_estadisticas.
    DATA: lv_hoy TYPE d.

    " 1. Obtenemos la fecha actual del sistema
    lv_hoy = cl_abap_context_info=>get_system_date( ).

    " 2. Cálculo de DÍAS: En ABAP, restar fechas da el número de días directamente
    rs_vida-dias = lv_hoy - iv_fecha_nacimiento.

    " 3. Cálculo de SEMANAS: División entera entre 7
    rs_vida-semanas = rs_vida-dias / 7.

    " 4. Cálculo de MESES: Usamos una aproximación de 30.44 días por mes
    " O podrías usar la función de sistema para meses exactos, pero así es más rápido:
    rs_vida-meses = rs_vida-dias / '30.44'.
  ENDMETHOD.
ENDCLASS.
