CLASS zcx_tenis_error_06 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        textid    LIKE textid    OPTIONAL
        previous  LIKE previous  OPTIONAL
        iv_mensaje TYPE string   OPTIONAL.

    DATA mv_mensaje TYPE string READ-ONLY.

ENDCLASS.

CLASS zcx_tenis_error_06 IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( textid = textid previous = previous ).
    mv_mensaje = iv_mensaje.
  ENDMETHOD.

ENDCLASS.
