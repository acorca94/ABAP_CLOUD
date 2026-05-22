CLASS zcx_flight_error_06 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA mv_mensaje TYPE string READ-ONLY.

    METHODS constructor
      IMPORTING
        iv_mensaje TYPE string OPTIONAL.

ENDCLASS.

CLASS zcx_flight_error_06 IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( ).
    mv_mensaje = iv_mensaje.
  ENDMETHOD.

ENDCLASS.
