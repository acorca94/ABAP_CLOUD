CLASS zcl_torneo_tenis_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_resultado,
        nombre_ganador  TYPE string,
        nombre_perdedor TYPE string,
        sets_ganador    TYPE i,
        sets_perdedor   TYPE i,
      END OF ty_resultado.

    TYPES ty_resultados TYPE STANDARD TABLE OF ty_resultado
         WITH EMPTY KEY.

    METHODS:
      constructor
        IMPORTING
          iv_nombre_torneo TYPE string,
      registrar_jugador
        IMPORTING
          io_jugador TYPE REF TO zcl_jugador_base_06
        RAISING
          zcx_tenis_error_06,
      registrar_partido
        IMPORTING
          iv_nombre_ganador  TYPE string
          iv_nombre_perdedor TYPE string
          iv_sets_ganador    TYPE i
          iv_sets_perdedor   TYPE i
        RAISING
          zcx_tenis_error_06,
      get_lider
        RETURNING VALUE(ro_lider) TYPE REF TO zcl_jugador_base_06
        RAISING
          zcx_tenis_error_06,
      get_clasificacion
        RETURNING VALUE(rt_clasificacion) TYPE string_table,
      get_nombre_torneo
        RETURNING VALUE(rv_nombre) TYPE string.

  PRIVATE SECTION.
    DATA mv_nombre_torneo TYPE string.
    DATA mt_jugadores TYPE STANDARD TABLE OF REF TO zcl_jugador_base_06
         WITH EMPTY KEY.
    DATA mt_resultados TYPE ty_resultados.

    METHODS buscar_jugador
      IMPORTING iv_nombre TYPE string
      RETURNING VALUE(ro_jugador) TYPE REF TO zcl_jugador_base_06.

ENDCLASS.

CLASS zcl_torneo_tenis_06 IMPLEMENTATION.

  METHOD constructor.
    mv_nombre_torneo = iv_nombre_torneo.
  ENDMETHOD.

  METHOD registrar_jugador.
    DATA lo_existe TYPE REF TO zcl_jugador_base_06.
    lo_existe = buscar_jugador( io_jugador->get_nombre( ) ).
    IF lo_existe IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_tenis_error_06
        EXPORTING iv_mensaje = |Jugador { io_jugador->get_nombre( ) } ya registrado|.
    ENDIF.
    APPEND io_jugador TO mt_jugadores.
  ENDMETHOD.

  METHOD buscar_jugador.
    LOOP AT mt_jugadores INTO DATA(lo_j).
      IF lo_j->get_nombre( ) = iv_nombre.
        ro_jugador = lo_j.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD registrar_partido.
    DATA lo_ganador  TYPE REF TO zcl_jugador_base_06.
    DATA lo_perdedor TYPE REF TO zcl_jugador_base_06.

    lo_ganador  = buscar_jugador( iv_nombre_ganador ).
    lo_perdedor = buscar_jugador( iv_nombre_perdedor ).

    IF lo_ganador IS INITIAL.
      RAISE EXCEPTION TYPE zcx_tenis_error_06
        EXPORTING iv_mensaje = |Jugador { iv_nombre_ganador } no encontrado|.
    ENDIF.
    IF lo_perdedor IS INITIAL.
      RAISE EXCEPTION TYPE zcx_tenis_error_06
        EXPORTING iv_mensaje = |Jugador { iv_nombre_perdedor } no encontrado|.
    ENDIF.

    lo_ganador->registrar_victoria(
      iv_sets_ganados  = iv_sets_ganador
      iv_sets_perdidos = iv_sets_perdedor
    ).

    lo_perdedor->registrar_victoria(
      iv_sets_ganados  = iv_sets_perdedor
      iv_sets_perdidos = iv_sets_ganador
    ).

    DATA ls_res TYPE zcl_torneo_tenis_06=>ty_resultado.
    ls_res-nombre_ganador  = iv_nombre_ganador.
    ls_res-nombre_perdedor = iv_nombre_perdedor.
    ls_res-sets_ganador    = iv_sets_ganador.
    ls_res-sets_perdedor   = iv_sets_perdedor.
    APPEND ls_res TO mt_resultados.
  ENDMETHOD.

  METHOD get_lider.
    DATA lv_max_puntos TYPE i VALUE 0.
    LOOP AT mt_jugadores INTO DATA(lo_j).
      DATA(lv_pts) = lo_j->zif_puntuable_06~calcular_puntos( ).
      IF lv_pts > lv_max_puntos.
        lv_max_puntos = lv_pts.
        ro_lider = lo_j.
      ENDIF.
    ENDLOOP.
    IF ro_lider IS INITIAL.
      RAISE EXCEPTION TYPE zcx_tenis_error_06
        EXPORTING iv_mensaje = 'No hay jugadores en el torneo'.
    ENDIF.
  ENDMETHOD.

  METHOD get_clasificacion.

    TYPES: BEGIN OF ty_par,
             puntos  TYPE i,
             jugador TYPE REF TO zcl_jugador_base_06,
           END OF ty_par.

    DATA lt_pares TYPE STANDARD TABLE OF ty_par WITH EMPTY KEY.

    LOOP AT mt_jugadores INTO DATA(lo_j).
      APPEND VALUE ty_par(
        puntos  = lo_j->zif_puntuable_06~calcular_puntos( )
        jugador = lo_j
      ) TO lt_pares.
    ENDLOOP.

    SORT lt_pares BY puntos DESCENDING.

    DATA lv_pos TYPE i VALUE 1.
    LOOP AT lt_pares INTO DATA(ls_par).
      DATA(lv_linea) = |{ lv_pos }. { ls_par-jugador->zif_puntuable_06~get_resumen( ) }|.
      APPEND lv_linea TO rt_clasificacion.
      lv_pos = lv_pos + 1.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_nombre_torneo.
    rv_nombre = mv_nombre_torneo.
  ENDMETHOD.

ENDCLASS.
