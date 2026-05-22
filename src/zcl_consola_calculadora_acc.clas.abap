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

CLASS zcl_consola_calculadora_acc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.  "Permite ejecutar la clase con F9
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CONSOLA_CALCULADORA_ACC IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lo_calc TYPE REF TO zcl_calculadora_acc.  "Variable de referencia a la calculadora

    lo_calc = NEW zcl_calculadora_acc( iv_propietario = 'Manolo' ).  "Crea la calculadora con propietario y valor 0
    out->write( lo_calc->mostrar_estado( ) ).                        "Pantalla: 0

    lo_calc->sumar( 100 ).                          "0 + 100 = 100
    out->write( lo_calc->mostrar_estado( ) ).

    lo_calc->multiplicar( 3 ).                      "100 * 3 = 300
    out->write( lo_calc->mostrar_estado( ) ).

    lo_calc->restar( 50 ).                          "300 - 50 = 250
    out->write( lo_calc->mostrar_estado( ) ).

    lo_calc->dividir( 5 ).                          "250 / 5 = 50
    out->write( lo_calc->mostrar_estado( ) ).

    out->write( lo_calc->dividir( 0 ) ).            "50 / 0 = (rv_error vacío, no muestra nada)
    out->write( lo_calc->mostrar_estado( ) ).

    out->write( cl_abap_char_utilities=>newline ).  "Salto de línea

    lo_calc->reset( ).                              "Reinicia pantalla a 0
    out->write( lo_calc->mostrar_estado( ) ).
  ENDMETHOD.
ENDCLASS.
