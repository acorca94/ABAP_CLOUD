CLASS zcl_tenis_consola_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.

CLASS zcl_tenis_consola_06 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA lo_torneo    TYPE REF TO zcl_torneo_tenis_06.
    DATA lo_j1        TYPE REF TO zcl_jugador_profesional_06.
    DATA lo_j2        TYPE REF TO zcl_jugador_profesional_06.
    DATA lo_j3        TYPE REF TO zcl_jugador_amateur_06.
    DATA lo_j4        TYPE REF TO zcl_jugador_amateur_06.
    DATA lo_lider     TYPE REF TO zcl_jugador_base_06.
    DATA lt_clasif    TYPE string_table.
    DATA lv_linea     TYPE string.

    TRY.
      lo_torneo = NEW zcl_torneo_tenis_06( iv_nombre_torneo = 'Roland Garros 2026' ).

      lo_j1 = NEW zcl_jugador_profesional_06(
               iv_nombre = 'Alcaraz'
               iv_pais   = 'ESP'
               iv_ranking_inicial = 1 ).

      lo_j2 = NEW zcl_jugador_profesional_06(
               iv_nombre = 'Sinner'
               iv_pais   = 'ITA'
               iv_ranking_inicial = 2 ).

      lo_j3 = NEW zcl_jugador_amateur_06(
               iv_nombre = 'Garcia'
               iv_pais   = 'ESP'
               iv_club   = 'Club Sevilla' ).

      lo_j4 = NEW zcl_jugador_amateur_06(
               iv_nombre = 'Lopez'
               iv_pais   = 'ESP'
               iv_club   = 'Club Huelva' ).

      lo_torneo->registrar_jugador( lo_j1 ).
      lo_torneo->registrar_jugador( lo_j2 ).
      lo_torneo->registrar_jugador( lo_j3 ).
      lo_torneo->registrar_jugador( lo_j4 ).

      lo_torneo->registrar_partido(
        iv_nombre_ganador  = 'Alcaraz'
        iv_nombre_perdedor = 'Sinner'
        iv_sets_ganador    = 3
        iv_sets_perdedor   = 1 ).

      lo_torneo->registrar_partido(
        iv_nombre_ganador  = 'Alcaraz'
        iv_nombre_perdedor = 'Garcia'
        iv_sets_ganador    = 3
        iv_sets_perdedor   = 0 ).

      lo_torneo->registrar_partido(
        iv_nombre_ganador  = 'Sinner'
        iv_nombre_perdedor = 'Lopez'
        iv_sets_ganador    = 3
        iv_sets_perdedor   = 2 ).

      lo_torneo->registrar_partido(
        iv_nombre_ganador  = 'Garcia'
        iv_nombre_perdedor = 'Lopez'
        iv_sets_ganador    = 2
        iv_sets_perdedor   = 1 ).

      lo_torneo->registrar_partido(
        iv_nombre_ganador  = 'Sinner'
        iv_nombre_perdedor = 'Garcia'
        iv_sets_ganador    = 3
        iv_sets_perdedor   = 1 ).

      lo_torneo->registrar_partido(
        iv_nombre_ganador  = 'Alcaraz'
        iv_nombre_perdedor = 'Lopez'
        iv_sets_ganador    = 3
        iv_sets_perdedor   = 1 ).

      out->write( |Torneo: { lo_torneo->get_nombre_torneo( ) }| ).
      out->write( '--- CLASIFICACION ---' ).

      lt_clasif = lo_torneo->get_clasificacion( ).
      LOOP AT lt_clasif INTO lv_linea.
        out->write( lv_linea ).
      ENDLOOP.

      lo_lider = lo_torneo->get_lider( ).
      out->write( |Lider: { lo_lider->get_nombre( ) } de { lo_lider->get_pais( ) }| ).

      IF lo_lider->zif_clasificable_06~esta_clasificado( ) = abap_true.
        out->write( |{ lo_lider->get_nombre( ) } esta clasificado para la final| ).
      ELSE.
        out->write( |{ lo_lider->get_nombre( ) } NO esta clasificado aun| ).
      ENDIF.

    CATCH zcx_tenis_error_06 INTO DATA(lx_err).
      out->write( |ERROR: { lx_err->mv_mensaje }| ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
