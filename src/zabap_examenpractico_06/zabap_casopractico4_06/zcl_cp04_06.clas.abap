CLASS zcl_cp04_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_cp04_06 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Tarea 4.1 - Análisis del modelo
    " Campos con tipos genéricos en CP2:
    " id_reserva → i       ahora → ZDE_RESERVA_ID_06 (INT4)
    " aerolinea  → c 2     ahora → ZDE_AIRLINE_06 (CHAR 2)
    " num_vuelo  → n 4     ahora → ZDE_FLIGHT_NUM_06 (NUMC 4)
    " pasajero   → string  ahora → ZDE_PASSENGER_06 (CHAR 40)
    " fecha      → d       ahora → DATS
    " precio     → p dec 2 ahora → ZDE_FLIGHT_PRICE_06 (DEC 11,2)
    " estado     → c 1     ahora → ZDE_BOOKING_STATUS_06 (CHAR 1)

    " Usar tipo tabla del diccionario
    DATA lt_reservas TYPE ztt_bookings_06.

    " Cargar datos iniciales
    lt_reservas = VALUE ztt_bookings_06(
      ( id_reserva = 1  aerolinea = 'LH' num_vuelo = '0400' pasajero = 'Ana García'   fecha = '20260515' precio = '899.00'  estado = 'A' )
      ( id_reserva = 2  aerolinea = 'IB' num_vuelo = '3740' pasajero = 'Carlos López' fecha = '20260515' precio = '120.00'  estado = 'A' )
      ( id_reserva = 3  aerolinea = 'AA' num_vuelo = '0017' pasajero = 'John Smith'   fecha = '20260520' precio = '450.50'  estado = 'A' )
      ( id_reserva = 4  aerolinea = 'LH' num_vuelo = '0455' pasajero = 'María Pérez'  fecha = '20260520' precio = '310.75'  estado = 'A' )
      ( id_reserva = 5  aerolinea = 'IB' num_vuelo = '3740' pasajero = 'Pedro Ruiz'   fecha = '20260515' precio = '120.00'  estado = 'C' )
      ( id_reserva = 6  aerolinea = 'SQ' num_vuelo = '0026' pasajero = 'Lisa Tan'     fecha = '20260601' precio = '1250.00' estado = 'A' )
      ( id_reserva = 7  aerolinea = 'LH' num_vuelo = '0400' pasajero = 'Hans Müller'  fecha = '20260515' precio = '899.00'  estado = 'A' )
      ( id_reserva = 8  aerolinea = 'AA' num_vuelo = '0064' pasajero = 'Sarah Jones'  fecha = '20260525' precio = '510.00'  estado = 'A' )
    ).

    " ─────────────────────────────────────────
    " TAREA 2.1 — Altas de reservas
    " ─────────────────────────────────────────
    out->write( '--- Tarea 2.1 Altas ---' ).

    APPEND VALUE zst_booking_06(
      id_reserva = 9  aerolinea = 'IB' num_vuelo = '3950'
      pasajero = 'Elena Martín' fecha = '20260601'
      precio = '275.30' estado = 'A'
    ) TO lt_reservas.

    APPEND VALUE zst_booking_06(
      id_reserva = 10 aerolinea = 'LH' num_vuelo = '2030'
      pasajero = 'Franz Weber' fecha = '20260610'
      precio = '95.00' estado = 'A'
    ) TO lt_reservas.

    out->write( lt_reservas ).

    " ─────────────────────────────────────────
    " TAREA 2.2 — Modificaciones
    " ─────────────────────────────────────────
    out->write( '--- Tarea 2.2 Modificaciones ---' ).

    READ TABLE lt_reservas
      WITH KEY id_reserva = 3
      INTO DATA(ls_reserva).

    IF sy-subrc = 0.
      ls_reserva-precio = '480.00'.
      MODIFY lt_reservas FROM ls_reserva
        TRANSPORTING precio
        WHERE id_reserva = 3.
    ENDIF.

    LOOP AT lt_reservas INTO DATA(ls_res)
      WHERE aerolinea = 'LH'.
      ls_res-precio = ls_res-precio * '0.9'.
      MODIFY lt_reservas FROM ls_res
        TRANSPORTING precio
        WHERE id_reserva = ls_res-id_reserva.
    ENDLOOP.

    LOOP AT lt_reservas INTO DATA(ls_mod)
      WHERE aerolinea = 'LH' OR id_reserva = 3.
      out->write( |ID: { ls_mod-id_reserva } | &&
                  |{ ls_mod-aerolinea } | &&
                  |Precio: { ls_mod-precio }| ).
    ENDLOOP.

    " ─────────────────────────────────────────
    " TAREA 2.3 — Cancelaciones y borrados
    " ─────────────────────────────────────────
    out->write( '--- Tarea 2.3 Cancelaciones ---' ).

    LOOP AT lt_reservas INTO DATA(ls_cancel)
      WHERE id_reserva = 4.
      ls_cancel-estado = 'C'.
      MODIFY lt_reservas FROM ls_cancel
        TRANSPORTING estado
        WHERE id_reserva = 4.
    ENDLOOP.

    DATA lv_canceladas TYPE i.
    LOOP AT lt_reservas INTO DATA(ls_c)
      WHERE estado = 'C'.
      lv_canceladas = lv_canceladas + 1.
    ENDLOOP.

    DELETE lt_reservas WHERE estado = 'C'.

    out->write( |Registros eliminados: { lv_canceladas }| ).
    out->write( lt_reservas ).

    " ─────────────────────────────────────────
    " TAREA 2.4 — Búsquedas
    " ─────────────────────────────────────────
    out->write( '--- Tarea 2.4 Búsquedas ---' ).

    READ TABLE lt_reservas
      WITH KEY pasajero = 'Lisa Tan'
      TRANSPORTING NO FIELDS.

    IF sy-subrc = 0.
      out->write( 'Lisa Tan existe en la tabla' ).
    ELSE.
      out->write( 'Lisa Tan NO encontrada' ).
    ENDIF.

    READ TABLE lt_reservas
      WITH KEY id_reserva = 6
      REFERENCE INTO DATA(lr_reserva).

    IF sy-subrc = 0.
      out->write( |ID: { lr_reserva->id_reserva } | &&
                  |Pasajero: { lr_reserva->pasajero } | &&
                  |Precio: { lr_reserva->precio }| ).
    ENDIF.

    DATA(lv_pasajero) = VALUE zst_booking_06(
      lt_reservas[ id_reserva = 1 ] ).
    out->write( |Pasajero ID 1: { lv_pasajero-pasajero }| ).

    " ─────────────────────────────────────────
    " TAREA 2.5 — Agrupación y agregados
    " ─────────────────────────────────────────
    out->write( '--- Tarea 2.5 Agrupación ---' ).

    LOOP AT lt_reservas INTO DATA(ls_grupo)
      WHERE estado = 'A'
      GROUP BY ls_grupo-aerolinea
      INTO DATA(lv_aerolinea).

      DATA lv_num   TYPE i.
      DATA lv_total TYPE p LENGTH 8 DECIMALS 2.
      lv_num   = 0.
      lv_total = 0.

      LOOP AT GROUP lv_aerolinea INTO DATA(ls_item).
        lv_num   = lv_num + 1.
        lv_total = lv_total + ls_item-precio.
      ENDLOOP.

      DATA(lv_media) = round( val = lv_total / lv_num dec = 2 ).

      out->write( |Aerolínea: { lv_aerolinea } | &&
                  |Reservas: { lv_num } | &&
                  |Total: { lv_total } | &&
                  |Media: { lv_media }| ).

    ENDLOOP.

    " ─────────────────────────────────────────
    " TAREA 4.6 — Reflexión
    " ─────────────────────────────────────────
    " Ventajas tipos diccionario vs locales:
    " 1. Reutilizables por cualquier clase, CDS view o API
    " 2. Tienen etiquetas, documentación y ayuda de búsqueda
    " 3. Cambios centralizados — si cambias el tipo se propaga a todos
    "
    " Cuándo usar TYPES locales:
    " 1. Tipos auxiliares que solo usa esa clase
    " 2. Prototipos o desarrollo temporal
    "
    " Dominios en ABAP clásico vs Cloud:
    " En ABAP clásico: Dominio → Elemento de datos → Campo
    " En ABAP Cloud: los dominios NO existen, se usa
    " directamente Predefined ABAP Type en el elemento de datos

  ENDMETHOD.

ENDCLASS.
