CLASS zcl_clase_bombilla_acc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    DATA:
      mv_ubicacion TYPE string,
      mv_estado    TYPE abap_bool.

    METHODS:
      inicializar
        IMPORTING iv_ubicacion TYPE string,
      get_ubicacion
        RETURNING VALUE(rv_ubicacion) TYPE string,
      get_estado
        RETURNING VALUE(rv_estado) TYPE abap_bool,
      set_ubicacion
        IMPORTING iv_ubicacion TYPE string,
      encender,
      apagar.

ENDCLASS.



CLASS ZCL_CLASE_BOMBILLA_ACC IMPLEMENTATION.


  METHOD set_ubicacion.
    mv_ubicacion = iv_ubicacion.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    DATA lv_estado_txt TYPE string.

    me->inicializar( iv_ubicacion = 'Salón' ).

    IF me->get_estado( ) = abap_true.
      lv_estado_txt = 'Encendida'.
    ELSE.
      lv_estado_txt = 'Apagada'.
    ENDIF.
    out->write( |Ubicación: { me->get_ubicacion( ) } - Estado: { lv_estado_txt }| ).

    me->encender( ).
    IF me->get_estado( ) = abap_true.
      lv_estado_txt = 'Encendida'.
    ELSE.
      lv_estado_txt = 'Apagada'.
    ENDIF.
    out->write( |Ubicación: { me->get_ubicacion( ) } - Estado: { lv_estado_txt }| ).

    me->encender( ).
    IF me->get_estado( ) = abap_true.
      lv_estado_txt = 'Encendida'.
    ELSE.
      lv_estado_txt = 'Apagada'.
    ENDIF.
    out->write( |Ubicación: { me->get_ubicacion( ) } - Estado: { lv_estado_txt }| ).

    me->apagar( ).
    IF me->get_estado( ) = abap_true.
      lv_estado_txt = 'Encendida'.
    ELSE.
      lv_estado_txt = 'Apagada'.
    ENDIF.
    out->write( |Ubicación: { me->get_ubicacion( ) } - Estado: { lv_estado_txt }| ).
  ENDMETHOD.


  METHOD get_ubicacion.
    rv_ubicacion = mv_ubicacion.
  ENDMETHOD.


  METHOD inicializar.
    mv_ubicacion = iv_ubicacion.
    mv_estado    = abap_false.
  ENDMETHOD.


  METHOD get_estado.
    rv_estado = mv_estado.
  ENDMETHOD.


  METHOD apagar.
    IF mv_estado = abap_true.
      mv_estado = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD encender.
    IF mv_estado = abap_false.
      mv_estado = abap_true.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
