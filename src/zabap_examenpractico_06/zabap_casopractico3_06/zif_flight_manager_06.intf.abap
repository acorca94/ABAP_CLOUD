INTERFACE zif_flight_manager_06
  PUBLIC.

  TYPES: BEGIN OF ty_vuelo,
           aerolinea TYPE c LENGTH 2,
           num_vuelo TYPE n LENGTH 4,
           origen    TYPE c LENGTH 3,
           destino   TYPE c LENGTH 3,
           precio    TYPE p LENGTH 8 DECIMALS 2,
         END OF ty_vuelo.

  TYPES ty_vuelos TYPE STANDARD TABLE OF ty_vuelo
                  WITH EMPTY KEY.

  METHODS add_flight
    IMPORTING
      iv_aerolinea TYPE c
      iv_num_vuelo TYPE n
      iv_origen    TYPE c
      iv_destino   TYPE c
      iv_precio    TYPE p
    RAISING
      zcx_flight_error_06.

  METHODS get_flights_by_airline
    IMPORTING
      iv_aerolinea    TYPE c
    RETURNING
      VALUE(rt_vuelos) TYPE ty_vuelos.

  METHODS get_cheapest_flight
    RETURNING
      VALUE(rs_vuelo) TYPE ty_vuelo.

  METHODS get_total_revenue
    RETURNING
      VALUE(rv_total) TYPE decfloat34.

ENDINTERFACE.
