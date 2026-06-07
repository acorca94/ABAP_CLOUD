CLASS zcl_consola_verano_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_consola_verano_06 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Cambia este valor para probar cada opción:
    " 1 = Alta de reservas
    " 2 = Modificación de reserva
    " 3 = Consulta de reserva concreta
    " 4 = Consulta de todas las reservas
    " 5 = Consulta de los primeros N registros
    DATA lv_opcion TYPE i VALUE 5.

    CASE lv_opcion.

      WHEN 1.
        out->write( '--- Alta de reservas ---' ).

        DATA(lo_r1) = NEW zcl_verano_06(
          iv_nombre      = 'Laura'
          iv_apellido    = 'Sánchez'
          iv_telefono    = '600111222'
          iv_dias        = 3
          iv_actividades = 2
        ).
        out->write( lo_r1->alta_reserva( ) ).

        DATA(lo_r2) = NEW zcl_verano_06(
          iv_nombre      = 'Manuel'
          iv_apellido    = 'Pérez'
          iv_telefono    = '600333444'
          iv_dias        = 5
          iv_actividades = 4
        ).
        out->write( lo_r2->alta_reserva( ) ).

        DATA(lo_r3) = NEW zcl_verano_06(
          iv_nombre      = 'Carmen'
          iv_apellido    = 'Ruiz'
          iv_telefono    = '600555666'
          iv_dias        = 2
          iv_actividades = 1
        ).
        out->write( lo_r3->alta_reserva( ) ).

      WHEN 2.
        out->write( '--- Modificación de reserva ---' ).

        DATA(lo_mod) = NEW zcl_verano_06(
          iv_nombre      = ''
          iv_apellido    = ''
          iv_telefono    = ''
          iv_dias        = 0
          iv_actividades = 0
        ).
        out->write( lo_mod->modificar_reserva(
          iv_id          = 1
          iv_nombre      = 'Laura'
          iv_apellido    = 'García'
          iv_telefono    = '600999888'
          iv_dias        = 4
          iv_actividades = 3
        ) ).

      WHEN 3.
        out->write( '--- Consulta de reserva concreta ---' ).

        DATA(lo_con) = NEW zcl_verano_06(
          iv_nombre      = ''
          iv_apellido    = ''
          iv_telefono    = ''
          iv_dias        = 0
          iv_actividades = 0
        ).
        DATA(lt_res) = lo_con->consultar_reservas( iv_id = 1 ).
        out->write( lt_res ).

      WHEN 4.
        out->write( '--- Consulta de todas las reservas ---' ).

        DATA(lo_all) = NEW zcl_verano_06(
          iv_nombre      = ''
          iv_apellido    = ''
          iv_telefono    = ''
          iv_dias        = 0
          iv_actividades = 0
        ).
        DATA(lt_all) = lo_all->consultar_reservas( iv_id = 0 ).
        out->write( lt_all ).

      WHEN 5.
        out->write( '--- Consulta de primeros N registros ---' ).

        DATA(lo_n) = NEW zcl_verano_06(
          iv_nombre      = ''
          iv_apellido    = ''
          iv_telefono    = ''
          iv_dias        = 0
          iv_actividades = 0
        ).
        DATA(lt_n) = lo_n->consultar_n_reservas( iv_n = 2 ).
        out->write( lt_n ).

    ENDCASE.

  ENDMETHOD.

ENDCLASS.
