"1 FORMA (MENOS PRO) DE HACER EL EJERCICIO SERÍA:


CLASS zcl_informe_reservas_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_informe,
           agency_name TYPE /dmo/agency-name,
           booking_id  TYPE /dmo/booking-booking_id,
           flight_date TYPE /dmo/booking-flight_date,
           amount      TYPE /dmo/booking-flight_price,
         END OF ty_informe,
         tt_informe TYPE STANDARD TABLE OF ty_informe WITH EMPTY KEY.

  PROTECTED SECTION.

ENDCLASS.



CLASS ZCL_INFORME_RESERVAS_06 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


*    " PASO 1: Traemos solo 2 reservas (para aprender con pocos datos)
    SELECT travel_id, booking_id, flight_date, flight_price
      FROM /dmo/booking
      INTO TABLE @DATA(lt_bookings)
      UP TO 20 ROWS.
*
*    " PASO 2: Traemos las tablas de referencia COMPLETAS en memoria
*    " (Así el READ TABLE podrá buscar dentro de ellas sin ir a la base de datos)
    SELECT travel_id, agency_id FROM /dmo/travel INTO TABLE @DATA(lt_travels).
    SELECT agency_id, name FROM /dmo/agency INTO TABLE @DATA(lt_agencies).

    DATA: lt_resultado TYPE tt_informe,
          ls_linea     TYPE ty_informe.
*
*    " PASO 3: El LOOP principal (El "cerebro" del informe)
    LOOP AT lt_bookings INTO DATA(ls_reserva).

      out->write( |Procesando Reserva ID: { ls_reserva-booking_id }| ).

      " Búsqueda 1: Usamos READ para encontrar el VIAJE que tiene esta reserva
      " Queremos saber el ID de la agencia que gestiona este viaje.
      READ TABLE lt_travels INTO DATA(ls_viaje)
        WITH KEY travel_id = ls_reserva-travel_id.

      " Esta linea hace lo mismo que la de arriba: READ TABLE... WITH KEY...
      " DATA(ls_travels) = lt_travels[ travel_id = ls_reserva-travel_id ]

      IF sy-subrc = 0.
        out->write( | -> Encontrado Viaje: { ls_viaje-travel_id }. Agencia ID: { ls_viaje-agency_id }| ).

        " Búsqueda 2: Con el Agency_ID del viaje, buscamos el NOMBRE en la tabla de agencias
        READ TABLE lt_agencies INTO DATA(ls_agencia)
          WITH KEY agency_id = ls_viaje-agency_id.

        IF sy-subrc = 0.
          out->write( | -> Nombre Agencia encontrado: { ls_agencia-name }| ).

          " Si todo ha ido bien, montamos la fila
          ls_linea-agency_name = ls_agencia-name.
          ls_linea-booking_id  = ls_reserva-booking_id.
          ls_linea-flight_date = ls_reserva-flight_date.
          ls_linea-amount      = ls_reserva-flight_price.

          APPEND ls_linea TO lt_resultado.
        ENDIF.
      ENDIF.

      out->write( '---' ).
    ENDLOOP.

    " Resultado final
    out->write( 'INFORME FINAL DE 2 LÍNEAS:' ).
    out->write( lt_resultado ).

  ENDMETHOD.
ENDCLASS.
