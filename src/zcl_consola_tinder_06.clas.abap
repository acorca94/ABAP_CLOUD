CLASS zcl_consola_tinder_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_consola_tinder_06 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Crear match normal
    DATA(lo_match1) = NEW zcl_match_tinder_06(
      iv_usuario1       = 'Antonio'
      iv_usuario2       = 'Laura'
      iv_fecha_match    = '20260514'
      iv_compatibilidad = 75
    ).

    " Crear superlike
    DATA(lo_match2) = NEW zcl_match_superlike_06(
      iv_usuario1       = 'Carlos'
      iv_usuario2       = 'María'
      iv_fecha_match    = '20260515'
      iv_compatibilidad = 95
      iv_mensaje        = 'Eres increíble!'
    ).

    " Polimorfismo — tabla de referencias a la madre
    DATA lt_matches TYPE STANDARD TABLE OF REF TO zcl_match_tinder_06
                    WITH EMPTY KEY.

    APPEND lo_match1 TO lt_matches.
    APPEND lo_match2 TO lt_matches.

    " Recorrer tabla y llamar describir_match polimórficamente
    out->write( '--- Todos los matches ---' ).
    LOOP AT lt_matches INTO DATA(lo_match).
      out->write( lo_match->describir_match( ) ).
    ENDLOOP.

    " Total de matches creados
    out->write( ' ' ).
    out->write( |Total matches creados: { zcl_match_tinder_06=>get_total_matches( ) }| ).

  ENDMETHOD.

ENDCLASS.
