CLASS zcl_consola_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CONSOLA_06 IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.

*    DATA: lo_cuadro1 TYPE REF TO zcl_cuadro_06,
*          lo_cuadro2 TYPE REF TO zcl_cuadro_06.
*
*    lo_cuadro1 = NEW zcl_cuadro_06( iv_titulo = 'La maja desnuda' iv_anio = 1800 ).
*    out->write( lo_cuadro1->mostrar_ficha( ) ).
*
*    lo_cuadro1->set_anio( 1801 ).
*    out->write( lo_cuadro1->mostrar_ficha( ) ).
*
*    lo_cuadro2 = NEW zcl_cuadro_06( iv_titulo = 'Las Meninas' iv_anio = 1656 ).
*    out->write( lo_cuadro2->mostrar_ficha( ) ).

* ----------------------------------------------------------------------------------------------- *

* Para saber cuántos asientos hay libres en un determinado vuelo

*    SELECT
*    FROM /dmo/flight
*    FIELDS carrier_id,
*           connection_id,
*           flight_date,
*           seats_max,
*           seats_occupied,
*           seats_max - seats_occupied AS seats_free
*    INTO TABLE @DATA(lt_flights).
*
*    IF lt_flights IS NOT INITIAL.
*        out->write( lt_flights ).
*    ENDIF.

* --------------------------------------------------------------------------------------------- *



  ENDMETHOD.
ENDCLASS.
