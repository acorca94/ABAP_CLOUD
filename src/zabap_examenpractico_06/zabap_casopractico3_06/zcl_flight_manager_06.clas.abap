CLASS zcl_flight_manager_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_flight_manager_06.

    METHODS constructor
      IMPORTING
        it_vuelos TYPE zif_flight_manager_06=>ty_vuelos
                  OPTIONAL.

  PRIVATE SECTION.
    DATA mt_vuelos TYPE zif_flight_manager_06=>ty_vuelos.

ENDCLASS.

CLASS zcl_flight_manager_06 IMPLEMENTATION.

  METHOD constructor.
    IF it_vuelos IS NOT INITIAL.
      mt_vuelos = it_vuelos.
    ENDIF.
  ENDMETHOD.

  METHOD zif_flight_manager_06~add_flight.
    " Validar precio positivo
    IF iv_precio <= 0.
      RAISE EXCEPTION TYPE zcx_flight_error_06
        EXPORTING iv_mensaje = 'El precio debe ser positivo'.
    ENDIF.

    " Validar que no existe duplicado
    READ TABLE mt_vuelos
      WITH KEY aerolinea = iv_aerolinea
               num_vuelo = iv_num_vuelo
      TRANSPORTING NO FIELDS.

    IF sy-subrc = 0.
      RAISE EXCEPTION TYPE zcx_flight_error_06
        EXPORTING iv_mensaje = |Vuelo { iv_aerolinea } { iv_num_vuelo } ya existe|.
    ENDIF.

    " Añadir vuelo
    APPEND VALUE zif_flight_manager_06=>ty_vuelo(
      aerolinea = iv_aerolinea
      num_vuelo = iv_num_vuelo
      origen    = iv_origen
      destino   = iv_destino
      precio    = iv_precio
    ) TO mt_vuelos.

  ENDMETHOD.

  METHOD zif_flight_manager_06~get_flights_by_airline.
      LOOP AT mt_vuelos INTO DATA(ls_vuelo)
        WHERE aerolinea = iv_aerolinea.
        APPEND ls_vuelo TO rt_vuelos.
      ENDLOOP.
  ENDMETHOD.

  METHOD zif_flight_manager_06~get_cheapest_flight.
    rs_vuelo = REDUCE zif_flight_manager_06=>ty_vuelo(
      INIT min = VALUE zif_flight_manager_06=>ty_vuelo(
                   precio = 99999999 )
      FOR vuelo IN mt_vuelos
      NEXT min = COND #(
        WHEN vuelo-precio < min-precio
        THEN vuelo
        ELSE min )
    ).
  ENDMETHOD.

  METHOD zif_flight_manager_06~get_total_revenue.
    rv_total = REDUCE decfloat34(
      INIT total = CONV decfloat34( 0 )
      FOR vuelo IN mt_vuelos
      NEXT total = total + vuelo-precio
    ).
  ENDMETHOD.

ENDCLASS.
