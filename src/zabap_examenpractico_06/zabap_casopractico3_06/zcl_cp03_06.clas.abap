CLASS zcl_cp03_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_cp03_06 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. Crear instancia
    DATA(lo_manager) = NEW zcl_flight_manager_06( ).

    " 2. Añadir 5 vuelos
    TRY.
        lo_manager->zif_flight_manager_06~add_flight(
          iv_aerolinea = 'LH' iv_num_vuelo = '0400'
          iv_origen = 'FRA'   iv_destino = 'JFK'
          iv_precio = '899.00' ).

        lo_manager->zif_flight_manager_06~add_flight(
          iv_aerolinea = 'AA' iv_num_vuelo = '0017'
          iv_origen = 'JFK'   iv_destino = 'SFO'
          iv_precio = '450.50' ).

        lo_manager->zif_flight_manager_06~add_flight(
          iv_aerolinea = 'IB' iv_num_vuelo = '3740'
          iv_origen = 'MAD'   iv_destino = 'BCN'
          iv_precio = '120.00' ).

        lo_manager->zif_flight_manager_06~add_flight(
          iv_aerolinea = 'LH' iv_num_vuelo = '0455'
          iv_origen = 'FRA'   iv_destino = 'MAD'
          iv_precio = '310.75' ).

        lo_manager->zif_flight_manager_06~add_flight(
          iv_aerolinea = 'SQ' iv_num_vuelo = '0026'
          iv_origen = 'SIN'   iv_destino = 'FRA'
          iv_precio = '1250.00' ).

      CATCH zcx_flight_error_06 INTO DATA(lx_error).
        out->write( lx_error->mv_mensaje ).
    ENDTRY.

    " 3. Precio negativo → excepción
    out->write( '--- Precio negativo ---' ).
    TRY.
        lo_manager->zif_flight_manager_06~add_flight(
          iv_aerolinea = 'AA' iv_num_vuelo = '0099'
          iv_origen = 'MAD'   iv_destino = 'LON'
          iv_precio = '-50.00' ).
      CATCH zcx_flight_error_06 INTO DATA(lx_neg).
        out->write( |Error: { lx_neg->mv_mensaje }| ).
    ENDTRY.

    " 4. Vuelo duplicado → excepción
    out->write( '--- Vuelo duplicado ---' ).
    TRY.
        lo_manager->zif_flight_manager_06~add_flight(
          iv_aerolinea = 'LH' iv_num_vuelo = '0400'
          iv_origen = 'FRA'   iv_destino = 'JFK'
          iv_precio = '899.00' ).
      CATCH zcx_flight_error_06 INTO DATA(lx_dup).
        out->write( |Error: { lx_dup->mv_mensaje }| ).
    ENDTRY.

    " 5. Vuelos de aerolínea LH
    out->write( '--- Vuelos LH ---' ).
    DATA(lt_lh) = lo_manager->zif_flight_manager_06~get_flights_by_airline(
                    iv_aerolinea = 'LH' ).
    out->write( lt_lh ).

    " 6. Vuelo más barato
    out->write( '--- Vuelo más barato ---' ).
    DATA(ls_barato) = lo_manager->zif_flight_manager_06~get_cheapest_flight( ).
    out->write( |{ ls_barato-aerolinea } { ls_barato-num_vuelo } | &&
                |{ ls_barato-origen } → { ls_barato-destino } | &&
                |Precio: { ls_barato-precio }| ).

    " 7. Facturación total
    out->write( '--- Facturación total ---' ).
    DATA(lv_total) = lo_manager->zif_flight_manager_06~get_total_revenue( ).
    out->write( |Total: { lv_total }| ).

  ENDMETHOD.

ENDCLASS.
