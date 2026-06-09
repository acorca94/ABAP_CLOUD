CLASS zcl_consola_empleado_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_consola_empleado_06 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Cambia este valor para probar cada opción:
    " 1 = Alta de empleados
    " 2 = Modificación de empleado
    " 3 = Consulta de empleado concreto
    " 4 = Consulta de todos los empleados
    " 5 = Consulta de los primeros N empleados
    DATA lv_opcion TYPE i VALUE 1.

    CASE lv_opcion.

      WHEN 1.
        out->write( '--- Alta de empleados ---' ).

        DATA(lo_e1) = NEW zcl_empleado_06(
          iv_nombre          = 'Laura'
          iv_apellido        = 'Sánchez'
          iv_telefono        = '600111222'
          iv_experiencia     = 3
          iv_certificaciones = 2
        ).
        out->write( lo_e1->alta_empleado( ) ).

        DATA(lo_e2) = NEW zcl_empleado_06(
          iv_nombre          = 'Manuel'
          iv_apellido        = 'Pérez'
          iv_telefono        = '600333444'
          iv_experiencia     = 5
          iv_certificaciones = 4
        ).
        out->write( lo_e2->alta_empleado( ) ).

        DATA(lo_e3) = NEW zcl_empleado_06(
          iv_nombre          = 'Carmen'
          iv_apellido        = 'Ruiz'
          iv_telefono        = '600555666'
          iv_experiencia     = 2
          iv_certificaciones = 1
        ).
        out->write( lo_e3->alta_empleado( ) ).

      WHEN 2.
        out->write( '--- Modificación de empleado ---' ).

        DATA(lo_mod) = NEW zcl_empleado_06(
          iv_nombre          = ''
          iv_apellido        = ''
          iv_telefono        = ''
          iv_experiencia     = 0
          iv_certificaciones = 0
        ).
        out->write( lo_mod->modificar_empleado(
          iv_id              = 1
          iv_nombre          = 'Laura'
          iv_apellido        = 'García'
          iv_telefono        = '600999888'
          iv_experiencia     = 5
          iv_certificaciones = 3
        ) ).

      WHEN 3.
        out->write( '--- Consulta de empleado concreto ---' ).

        DATA(lo_con) = NEW zcl_empleado_06(
          iv_nombre          = ''
          iv_apellido        = ''
          iv_telefono        = ''
          iv_experiencia     = 0
          iv_certificaciones = 0
        ).
        DATA(lt_uno) = lo_con->consultar_empleados( iv_id = 1 ).
        out->write( lt_uno ).

      WHEN 4.
        out->write( '--- Consulta de todos los empleados ---' ).

        DATA(lo_all) = NEW zcl_empleado_06(
          iv_nombre          = ''
          iv_apellido        = ''
          iv_telefono        = ''
          iv_experiencia     = 0
          iv_certificaciones = 0
        ).
        DATA(lt_all) = lo_all->consultar_empleados( iv_id = 2 ).
        out->write( lt_all ).

      WHEN 5.
        out->write( '--- Consulta de primeros N empleados ---' ).

        DATA(lo_n) = NEW zcl_empleado_06(
          iv_nombre          = ''
          iv_apellido        = ''
          iv_telefono        = ''
          iv_experiencia     = 0
          iv_certificaciones = 0
        ).
        DATA(lt_n) = lo_n->consultar_n_empleados( iv_n = 2 ).
        out->write( lt_n ).

    ENDCASE.

  ENDMETHOD.

ENDCLASS.
