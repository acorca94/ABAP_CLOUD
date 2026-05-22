CLASS zcl_cp01_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_cp01_06 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_vuelo,
             aerolinea     TYPE c LENGTH 2,
             num_vuelo     TYPE n LENGTH 4,
             origen        TYPE c LENGTH 3,
             destino       TYPE c LENGTH 3,
             precio        TYPE p LENGTH 8 DECIMALS 2,
             plazas_libres TYPE i,
           END OF ty_vuelo.

    TYPES ty_table_vuelos TYPE STANDARD TABLE OF ty_vuelo
                          WITH EMPTY KEY.

    DATA(lt_vuelos) = VALUE ty_table_vuelos(
      ( aerolinea = 'LH' num_vuelo = '0400' origen = 'FRA'
        destino = 'JFK' precio = '899.00' plazas_libres = 15 )
      ( aerolinea = 'AA' num_vuelo = '0017' origen = 'JFK'
        destino = 'SFO' precio = '450.50' plazas_libres = 0  )
      ( aerolinea = 'IB' num_vuelo = '3740' origen = 'MAD'
        destino = 'BCN' precio = '120.00' plazas_libres = 42 )
      ( aerolinea = 'LH' num_vuelo = '0455' origen = 'FRA'
        destino = 'MAD' precio = '310.75' plazas_libres = 8  )
      ( aerolinea = 'AA' num_vuelo = '0064' origen = 'SFO'
        destino = 'JFK' precio = '510.00' plazas_libres = 3  )
      ( aerolinea = 'IB' num_vuelo = '3950' origen = 'BCN'
        destino = 'LHR' precio = '275.30' plazas_libres = 0  )
      ( aerolinea = 'LH' num_vuelo = '2030' origen = 'MUC'
        destino = 'FRA' precio = '95.00'  plazas_libres = 60 )
      ( aerolinea = 'SQ' num_vuelo = '0026' origen = 'SIN'
        destino = 'FRA' precio = '1250.00' plazas_libres = 5 )
    ).

    out->write( lt_vuelos ).

    """""""""""""""""""""""""""""""" TAREA 1.1 """"""""""""""""""""""""""""""""""""""

    out->write( '--- Tarea 1.1 Clasificacion por precio ---' ).

    LOOP AT lt_vuelos INTO DATA(ls_vuelo1).

    DATA(lv_categoria) = COND string(
        WHEN ls_vuelo1-precio < 150   THEN 'Económico'
        WHEN ls_vuelo1-precio <= 500  THEN 'Estándar'
        WHEN ls_vuelo1-precio <= 1000 THEN 'Premium'
        ELSE                              'First Class'
    ).

    out->write( |{ ls_vuelo1-aerolinea } { ls_vuelo1-num_vuelo } → { lv_categoria }| ).

    ENDLOOP.

    """""""""""""""""""""""""""""""" TAREA 1.2 """"""""""""""""""""""""""""""""""""""

    out->write( '--- Tarea 1.2 Filtrado ---' ).

    LOOP AT lt_vuelos INTO DATA(ls_vuelo2)
        WHERE plazas_libres > 0
        AND ( origen = 'FRA' OR destino = 'FRA' )
        AND precio <= 1000.

    out->write( |{ ls_vuelo2-aerolinea } { ls_vuelo2-num_vuelo } | &&
              |{ ls_vuelo2-origen } → { ls_vuelo2-destino } | &&
              |Precio: { ls_vuelo2-precio } Plazas: { ls_vuelo2-plazas_libres }| ).

    ENDLOOP.

    """""""""""""""""""""""""""""""" TAREA 1.3 """"""""""""""""""""""""""""""""""""""

    out->write( '--- Tarea 1.3 Transformacion de cadenas ---' ).

    LOOP AT lt_vuelos INTO DATA(ls_vuelo)
      WHERE plazas_libres > 0
        AND ( origen = 'FRA' OR destino = 'FRA' )
        AND precio <= 1000.

      DATA(lv_codigo) = ls_vuelo-aerolinea && '-' && ls_vuelo-num_vuelo.

      DATA(lv_destino_minus) = to_lower( ls_vuelo-destino ).

      DATA(lv_longitud) = strlen( lv_codigo ).

      out->write( |{ lv_codigo } | &&
                  |{ lv_destino_minus } | &&
                  |{ lv_longitud }| ).

    ENDLOOP.

    """""""""""""""""""""""""""""""" TAREA 1.4 """"""""""""""""""""""""""""""""""""""

    out->write( '--- Tarea 1.4 Resumen numerico ---' ).

    DATA lv_max    TYPE p LENGTH 8 DECIMALS 2.
    DATA lv_min    TYPE p LENGTH 8 DECIMALS 2.
    DATA lv_total  TYPE p LENGTH 8 DECIMALS 2.
    DATA lv_plazas TYPE i.

    LOOP AT lt_vuelos INTO DATA(ls_vuelo4).

      IF ls_vuelo4-precio > lv_max.
        lv_max = ls_vuelo4-precio.
      ENDIF.

      IF lv_min = 0 OR ls_vuelo4-precio < lv_min.
        lv_min = ls_vuelo4-precio.
      ENDIF.

      lv_total = lv_total + ls_vuelo4-precio.

      lv_plazas = lv_plazas + ls_vuelo4-plazas_libres.

    ENDLOOP.

    DATA(lv_media) = round( val = lv_total / lines( lt_vuelos )
                            dec = 2 ).

    out->write( |Precio máximo: { lv_max }|   ).
    out->write( |Precio mínimo: { lv_min }|   ).
    out->write( |Precio medio:  { lv_media }| ).
    out->write( |Plazas libres totales: { lv_plazas }| ).

    ENDMETHOD.

ENDCLASS.
