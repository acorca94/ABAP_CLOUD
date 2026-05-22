CLASS zcl_cuadro_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_titulo TYPE string
          iv_anio   TYPE i,
      get_titulo
        RETURNING VALUE(rv_resultado) TYPE string,
      get_anio
        RETURNING VALUE(rv_resultado) TYPE i,
      set_titulo
        IMPORTING iv_titulo TYPE string,
      set_anio
        IMPORTING iv_anio TYPE i,
      esta_en_exposicion
        RETURNING VALUE(rv_resultado) TYPE abap_bool,
      mostrar_ficha
        RETURNING VALUE(rv_ficha) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      mv_titulo TYPE string,
      mv_anio   TYPE i.
ENDCLASS.



CLASS ZCL_CUADRO_06 IMPLEMENTATION.


  METHOD constructor.
    mv_titulo = iv_titulo.
    mv_anio   = iv_anio.
  ENDMETHOD.


  METHOD get_titulo.
    rv_resultado = mv_titulo.
  ENDMETHOD.


  METHOD get_anio.
    rv_resultado = mv_anio.
  ENDMETHOD.


  METHOD set_titulo.
    mv_titulo = iv_titulo.
  ENDMETHOD.


  METHOD set_anio.
    mv_anio = iv_anio.
  ENDMETHOD.


  METHOD esta_en_exposicion.
    IF mv_anio > 1800.
      rv_resultado = abap_true.
    ELSE.
      rv_resultado = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD mostrar_ficha.
    DATA lv_mensaje TYPE string.

    IF esta_en_exposicion( ) = abap_true.
      lv_mensaje = 'En exposición'.
    ELSE.
      lv_mensaje = 'Almacenado'.
    ENDIF.

    rv_ficha = |Título: { mv_titulo } - Año: { mv_anio } - Estado: { lv_mensaje }|.

  ENDMETHOD.
ENDCLASS.
