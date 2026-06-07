CLASS zcl_jugador_base_06 DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_puntuable_06.
    INTERFACES zif_clasificable_06.

    METHODS:
      constructor
        IMPORTING
          iv_nombre TYPE string
          iv_pais   TYPE string,
      get_nombre
        RETURNING VALUE(rv_nombre) TYPE string,
      get_pais
        RETURNING VALUE(rv_pais) TYPE string,
      registrar_victoria
        IMPORTING
          iv_sets_ganados  TYPE i
          iv_sets_perdidos TYPE i
        RAISING
          zcx_tenis_error_06,
      get_victorias
        RETURNING VALUE(rv_n) TYPE i,
      get_derrotas
        RETURNING VALUE(rv_n) TYPE i.

  PROTECTED SECTION.
    DATA mv_nombre        TYPE string.
    DATA mv_pais          TYPE string.
    DATA mv_victorias     TYPE i.
    DATA mv_derrotas      TYPE i.
    DATA mv_sets_ganados  TYPE i.
    DATA mv_sets_perdidos TYPE i.

  PRIVATE SECTION.
    DATA mv_posicion_ranking TYPE i.

ENDCLASS.

CLASS zcl_jugador_base_06 IMPLEMENTATION.

  METHOD constructor.
    mv_nombre    = iv_nombre.
    mv_pais      = iv_pais.
    mv_victorias = 0.
    mv_derrotas  = 0.
    mv_sets_ganados  = 0.
    mv_sets_perdidos = 0.
    mv_posicion_ranking = 0.
  ENDMETHOD.

  METHOD get_nombre.
    rv_nombre = mv_nombre.
  ENDMETHOD.

  METHOD get_pais.
    rv_pais = mv_pais.
  ENDMETHOD.

  METHOD registrar_victoria.
    IF iv_sets_ganados < 0 OR iv_sets_perdidos < 0.
      RAISE EXCEPTION TYPE zcx_tenis_error_06
        EXPORTING iv_mensaje = |Sets inválidos para { mv_nombre }|.
    ENDIF.
    mv_victorias = mv_victorias + 0.
    mv_sets_ganados  = mv_sets_ganados + iv_sets_ganados.
    mv_sets_perdidos = mv_sets_perdidos + iv_sets_perdidos.
  ENDMETHOD.

  METHOD get_victorias.
    rv_n = mv_victorias.
  ENDMETHOD.

  METHOD get_derrotas.
    rv_n = mv_derrotas.
  ENDMETHOD.

  METHOD zif_clasificable_06~esta_clasificado.
    IF mv_victorias > 5.
      rv_result = abap_true.
    ELSE.
      rv_result = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD zif_clasificable_06~get_posicion_ranking.
    rv_pos = mv_posicion_ranking.
  ENDMETHOD.

ENDCLASS.
