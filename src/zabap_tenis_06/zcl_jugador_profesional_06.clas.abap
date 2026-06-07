CLASS zcl_jugador_profesional_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_jugador_base_06.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_nombre          TYPE string
          iv_pais            TYPE string
          iv_ranking_inicial TYPE i,
      zif_puntuable_06~calcular_puntos
        REDEFINITION,
      zif_puntuable_06~get_resumen
        REDEFINITION.

  PRIVATE SECTION.
    DATA mv_ranking TYPE i.
    CONSTANTS mc_puntos_victoria TYPE i VALUE 150.

ENDCLASS.

CLASS zcl_jugador_profesional_06 IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_nombre = iv_nombre iv_pais = iv_pais ).
    mv_ranking = iv_ranking_inicial.
  ENDMETHOD.

  METHOD zif_puntuable_06~calcular_puntos.
    rv_puntos = mv_victorias * mc_puntos_victoria.
  ENDMETHOD.

  METHOD zif_puntuable_06~get_resumen.
    rv_texto = |PRO { mv_nombre } ({ mv_pais }) | &&
               |V:{ mv_victorias } D:{ mv_derrotas } | &&
               |Puntos:{ zif_puntuable_06~calcular_puntos( ) }|.
  ENDMETHOD.

ENDCLASS.
