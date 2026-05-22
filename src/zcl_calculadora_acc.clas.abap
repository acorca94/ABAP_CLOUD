*********************************************************************
* ZCL_CALCULADORA_ACC          ZCL_CONSOLA_CALCULADORA_ACC
* ---------------------        ---------------------------
* DEFINITION                   DEFINITION
*   -> que atributos              -> solo: INTERFACES if_oo_adt_classrun
*   -> que metodos
*                                IMPLEMENTATION
* IMPLEMENTATION                 -> if_oo_adt_classrun~main
*   -> como funciona                  . crea objetos con NEW
*      cada metodo                    . llama a sus metodos
*                                     . escribe en consola con out->write
*********************************************************************

CLASS zcl_calculadora_acc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "MÉTODOS
    METHODS:
      constructor                                    "Inicializa propietario y valor a 0
        IMPORTING
          iv_propietario TYPE string
          iv_valor       TYPE i DEFAULT 0,

      get_valor                                      "Devuelve el valor actual en pantalla
        RETURNING VALUE(rv_resultado) TYPE i,
      get_propietario                                "Devuelve el nombre del propietario
        RETURNING VALUE(rv_resultado) TYPE string,

      set_propietario                                "Cambia el nombre del propietario
        IMPORTING iv_propietario TYPE string,
      sumar                                          "Suma un número al valor en pantalla
        IMPORTING iv_numero TYPE i,
      restar                                         "Resta un número al valor en pantalla
        IMPORTING iv_numero TYPE i,
      multiplicar                                    "Multiplica el valor en pantalla por un número
        IMPORTING iv_numero TYPE i,
      dividir                                        "Divide el valor entre un número; error si es cero
        IMPORTING iv_numero  TYPE i
        RETURNING VALUE(rv_error) TYPE string,
      reset,                                         "Pone el valor en pantalla a cero
      mostrar_estado                                 "Devuelve una línea con el estado completo
        RETURNING VALUE(rv_ficha) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

    "ATRIBUTOS
    DATA:
      mv_valor       TYPE i,        "Valor actual en pantalla
      mv_propietario TYPE string.   "Nombre del propietario
ENDCLASS.



CLASS ZCL_CALCULADORA_ACC IMPLEMENTATION.


  METHOD constructor.
    mv_propietario = iv_propietario.  "Guarda el nombre recibido
    mv_valor       = iv_valor.               "Pantalla siempre arranca en cero
  ENDMETHOD.


  METHOD get_valor.
    rv_resultado = mv_valor.          "Expone el atributo privado mv_valor
  ENDMETHOD.


  METHOD get_propietario.
    rv_resultado = mv_propietario.    "Expone el atributo privado mv_propietario
  ENDMETHOD.


  METHOD set_propietario.
    mv_propietario = iv_propietario.  "Sobreescribe el nombre del propietario
  ENDMETHOD.


  METHOD sumar.
    mv_valor = mv_valor + iv_numero.  "Acumula el número recibido
  ENDMETHOD.


  METHOD restar.
    mv_valor = mv_valor - iv_numero.  "Descuenta el número recibido
  ENDMETHOD.


  METHOD multiplicar.
    mv_valor = mv_valor * iv_numero.  "Multiplica el acumulado por el número recibido
  ENDMETHOD.


  METHOD dividir.
    IF iv_numero = 0.
      rv_error = 'ERROR: división entre cero'.  "No opera y devuelve mensaje de error
    ELSE.
      mv_valor = mv_valor / iv_numero.           "División normal si el divisor es válido
    ENDIF.
  ENDMETHOD.


  METHOD reset.
    mv_valor = 0.  "Reinicia la pantalla a cero
  ENDMETHOD.


  METHOD mostrar_estado.
    "Construye y devuelve la línea completa con propietario y valor actual
    rv_ficha = |Calculadora de { mv_propietario } - Pantalla: { mv_valor }|.
  ENDMETHOD.
ENDCLASS.
