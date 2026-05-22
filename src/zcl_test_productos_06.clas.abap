CLASS zcl_test_productos_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS ZCL_TEST_PRODUCTOS_06 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_crud) = NEW zcl_productos_06( ).
    DATA: ls_temp TYPE zproductos_06,
          lv_found TYPE abap_bool.

    " 1. Insertar productos
    " Nota: iv_waers no es obligatorio ponerlo porque en la clase pusimos DEFAULT 'EUR'
    out->write( '--- 1. Insertando productos ---' ).
    lo_crud->insertar( iv_id = '00000001' iv_nombre = 'Teclado' iv_cat = 'HW' iv_precio = '50.00' iv_stock = 10 iv_activo = 'X' ).
    lo_crud->insertar( iv_id = '00000002' iv_nombre = 'Monitor' iv_cat = 'HW' iv_precio = '200.00' iv_stock = 5 iv_activo = 'X' ).
    lo_crud->insertar( iv_id = '00000003' iv_nombre = 'Raton'   iv_cat = 'HW' iv_precio = '25.00' iv_stock = 20 iv_activo = 'X' ).

    " 2. Buscar producto 02
    out->write( '--- 2. Buscando producto 00000002 ---' ).
    lo_crud->buscar_por_id( EXPORTING iv_id = '00000002'
                            IMPORTING es_producto = ls_temp
                                      ev_encontrado = lv_found ).
    IF lv_found = abap_true.
      " Ahora mostramos también la moneda que recupera de la tabla
      out->write( |Encontrado: { ls_temp-nombre } - Precio: { ls_temp-precio } { ls_temp-waers }| ).
    ENDIF.

    " 3. Listar todos
    DATA(lt_lista) = lo_crud->listar_todos( ).
    out->write( |--- 3. Total productos iniciales: { lines( lt_lista ) } ---| ).

    " 4. Modificar producto 01
    out->write( '--- 4. Modificando producto 00000001 ---' ).
    " Es mejor buscarlo primero para que ls_temp tenga TODA la estructura (incluido el waers)
    lo_crud->buscar_por_id( EXPORTING iv_id = '00000001' IMPORTING es_producto = ls_temp ).

    ls_temp-nombre = 'Teclado Mecánico'.
    ls_temp-precio = '90.00'.
    ls_temp-stock  = 15.
    " Al llamar a modificar enviamos la estructura ls_temp completa
    lo_crud->modificar( ls_temp ).

    " 5. Confirmar cambio
    lo_crud->buscar_por_id( EXPORTING iv_id = '00000001' IMPORTING es_producto = ls_temp ev_encontrado = lv_found ).
    out->write( |Nuevo precio de 01: { ls_temp-precio } { ls_temp-waers }| ).

    " 6. Borrar producto 03
    out->write( '--- 6. Borrando producto 00000003 ---' ).
    lo_crud->borrar( '00000003' ).

    " 7. Lista final
    lt_lista = lo_crud->listar_todos( ).
    out->write( |--- 7. Lista final confirmada. Quedan: { lines( lt_lista ) } ---| ).

    " Opcional: Mostrar la tabla completa en la consola
    out->write( lt_lista ).

  ENDMETHOD.
ENDCLASS.
