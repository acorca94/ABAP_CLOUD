CLASS zcl_match_superlike_06 DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_match_tinder_06
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA mensaje_superlike TYPE string.

    METHODS constructor
      IMPORTING
        iv_usuario1        TYPE string
        iv_usuario2        TYPE string
        iv_fecha_match     TYPE d
        iv_compatibilidad  TYPE i
        iv_mensaje         TYPE string.

    METHODS describir_match REDEFINITION.

ENDCLASS.

CLASS zcl_match_superlike_06 IMPLEMENTATION.

  METHOD constructor.
    super->constructor(
      iv_usuario1       = iv_usuario1
      iv_usuario2       = iv_usuario2
      iv_fecha_match    = iv_fecha_match
      iv_compatibilidad = iv_compatibilidad
    ).
    mensaje_superlike = iv_mensaje.
  ENDMETHOD.

  METHOD describir_match.
    DATA(lv_base) = super->describir_match( ).
    rv_descripcion = |{ lv_base } ⭐ SUPERLIKE: { mensaje_superlike }|.
  ENDMETHOD.

ENDCLASS.
