CLASS zcl_cuenta_bancaria_acc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    METHODS constructor
      IMPORTING
        iv_titular TYPE string OPTIONAL
        iv_saldo   TYPE i      OPTIONAL.

    METHODS ingresar IMPORTING iv_cantidad TYPE i io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS retirar  IMPORTING iv_cantidad TYPE i io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS mostrar_estado RETURNING VALUE(rv_texto) TYPE string.

  PRIVATE SECTION.
    DATA mv_titular TYPE string.
    DATA mv_saldo   TYPE i.
ENDCLASS.



CLASS ZCL_CUENTA_BANCARIA_ACC IMPLEMENTATION.


  METHOD mostrar_estado.
    rv_texto = |ESTADO -> Titular: { me->mv_titular } | && | Saldo: { me->mv_saldo }€|.
  ENDMETHOD.


  METHOD constructor.
    me->mv_titular = iv_titular.
    me->mv_saldo   = iv_saldo.
  ENDMETHOD.


  METHOD retirar.
    IF iv_cantidad <= me->mv_saldo.
      me->mv_saldo -= iv_cantidad.
      io_out->write( |- Retirada OK: { iv_cantidad }€| ).
    ELSE.
      io_out->write( |! ALERTA: Saldo insuficiente para retirar { iv_cantidad }€. Saldo disponible: { me->mv_saldo }€| ).
    ENDIF.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_cuenta) = NEW zcl_cuenta_bancaria_acc( iv_titular = 'Carlos' iv_saldo = 1000 ).

    out->write( |--- INICIO DE OPERACIONES ---| ).
    out->write( lo_cuenta->mostrar_estado( ) ).

    " Pasamos 'out' como parámetro para que el método pueda escribir
    lo_cuenta->ingresar( iv_cantidad = 500 io_out = out ).

    lo_cuenta->retirar( iv_cantidad = 200 io_out = out ).

    " Intento de retirada fallida
    lo_cuenta->retirar( iv_cantidad = 2000 io_out = out ).

    out->write( |--- RESUMEN FINAL ---| ).
    out->write( lo_cuenta->mostrar_estado( ) ).
  ENDMETHOD.


  METHOD ingresar.
    me->mv_saldo += iv_cantidad.
    io_out->write( |+ Ingreso OK: { iv_cantidad }€| ).
  ENDMETHOD.
ENDCLASS.
