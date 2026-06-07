CLASS zcl_match_tinder_06 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA usuario1    TYPE string.
    DATA usuario2    TYPE string.
    DATA fecha_match TYPE d.

    CONSTANTS max_matches TYPE i VALUE 999.

    CLASS-DATA gv_total_matches TYPE i.

    METHODS constructor
      IMPORTING
        iv_usuario1       TYPE string
        iv_usuario2       TYPE string
        iv_fecha_match    TYPE d
        iv_compatibilidad TYPE i.

    CLASS-METHODS get_total_matches
      RETURNING
        VALUE(rv_total) TYPE i.

    METHODS es_super_match
      RETURNING
        VALUE(rv_resultado) TYPE abap_bool.

    METHODS describir_match
      RETURNING
        VALUE(rv_descripcion) TYPE string.

  PRIVATE SECTION.
    DATA compatibilidad TYPE i.

ENDCLASS.

CLASS zcl_match_tinder_06 IMPLEMENTATION.

  METHOD constructor.
    usuario1       = iv_usuario1.
    usuario2       = iv_usuario2.
    fecha_match    = iv_fecha_match.
    compatibilidad = iv_compatibilidad.
    gv_total_matches = gv_total_matches + 1.
  ENDMETHOD.

  METHOD get_total_matches.
    rv_total = gv_total_matches.
  ENDMETHOD.

  METHOD es_super_match.
    IF compatibilidad > 80.
      rv_resultado = abap_true.
    ELSE.
      rv_resultado = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD describir_match.
    rv_descripcion = |Match entre { usuario1 } y { usuario2 }| &&
                     | el { fecha_match DATE = USER }| &&
                     | — Compatibilidad: { compatibilidad }%|.
  ENDMETHOD.

ENDCLASS.
