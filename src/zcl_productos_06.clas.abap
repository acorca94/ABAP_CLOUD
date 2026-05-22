CLASS zcl_productos_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    " Definimos el tipo de tabla para el retorno de listas
    TYPES tt_productos TYPE STANDARD TABLE OF zproductos_06 WITH EMPTY KEY.

    METHODS insertar
      IMPORTING iv_id        TYPE zproducto_id_06
                iv_nombre    TYPE zproducto_nom_06
                iv_cat       TYPE zproducto_cat_06
                iv_precio    TYPE zproducto_prc_06
                iv_stock     TYPE zproducto_stk_06
                iv_activo    TYPE zproducto_act_06
                iv_waers     TYPE waers DEFAULT 'EUR'
      RETURNING VALUE(rv_ok) TYPE abap_bool.

    METHODS buscar_por_id
      IMPORTING iv_id         TYPE zproducto_id_06
      EXPORTING es_producto   TYPE zproductos_06
                ev_encontrado TYPE abap_bool.

    METHODS listar_todos
      RETURNING VALUE(rt_productos) TYPE tt_productos.

    METHODS modificar
      IMPORTING is_producto  TYPE zproductos_06
      RETURNING VALUE(rv_ok) TYPE abap_bool.

    METHODS borrar
      IMPORTING iv_id        TYPE zproducto_id_06
      RETURNING VALUE(rv_ok) TYPE abap_bool.

ENDCLASS.



CLASS ZCL_PRODUCTOS_06 IMPLEMENTATION.


  METHOD insertar.
    DATA(ls_prod) = VALUE zproductos_06(
      producto_id = iv_id
      nombre      = iv_nombre
      categoria   = iv_cat
      precio      = iv_precio
      stock       = iv_stock
      activo      = iv_activo
      waers       = iv_waers
    ).

    INSERT zproductos_06 FROM @ls_prod.
    rv_ok = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD buscar_por_id.

    SELECT SINGLE *
      FROM zproductos_06
      WHERE producto_id = @iv_id
      INTO @es_producto.

    ev_encontrado = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD listar_todos.
    SELECT *
      FROM zproductos_06
      ORDER BY producto_id
      INTO TABLE @rt_productos.
  ENDMETHOD.


  METHOD modificar.
    " Actualización usando la estructura con @
    UPDATE zproductos_06 FROM @is_producto.
    rv_ok = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD borrar.
    DELETE FROM zproductos_06 WHERE producto_id = @iv_id.
    rv_ok = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.
ENDCLASS.
