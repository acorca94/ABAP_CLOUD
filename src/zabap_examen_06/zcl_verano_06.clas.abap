CLASS zcl_verano_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES ty_reservas TYPE STANDARD TABLE OF ztab_verano_06
                      WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        iv_nombre      TYPE string
        iv_apellido    TYPE string
        iv_telefono    TYPE string
        iv_dias        TYPE i
        iv_actividades TYPE i.

    METHODS calcular_importe
      RETURNING VALUE(rv_importe) TYPE zde_importe_total_06.

    METHODS generar_id_reserva
      RETURNING VALUE(rv_id) TYPE zde_id_reserva_06.

    METHODS alta_reserva
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS modificar_reserva
      IMPORTING
        iv_id          TYPE zde_id_reserva_06
        iv_nombre      TYPE string
        iv_apellido    TYPE string
        iv_telefono    TYPE string
        iv_dias        TYPE i
        iv_actividades TYPE i
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS consultar_reservas
      IMPORTING
        iv_id           TYPE zde_id_reserva_06
      RETURNING
        VALUE(rt_result) TYPE ty_reservas.

    METHODS consultar_n_reservas
      IMPORTING
        iv_n            TYPE i
      RETURNING
        VALUE(rt_result) TYPE ty_reservas.

  PRIVATE SECTION.
    DATA mv_nombre      TYPE string.
    DATA mv_apellido    TYPE string.
    DATA mv_telefono    TYPE string.
    DATA mv_dias        TYPE i.
    DATA mv_actividades TYPE i.

ENDCLASS.

CLASS zcl_verano_06 IMPLEMENTATION.

  METHOD constructor.
    mv_nombre      = iv_nombre.
    mv_apellido    = iv_apellido.
    mv_telefono    = iv_telefono.
    mv_dias        = iv_dias.
    mv_actividades = iv_actividades.
  ENDMETHOD.

  METHOD calcular_importe.
    rv_importe = 100 + ( mv_actividades * 25 ) + ( mv_dias * 40 ).
  ENDMETHOD.

  METHOD generar_id_reserva.
    SELECT SINGLE MAX( id_reserva )
      FROM ztab_verano_06
      INTO @rv_id.
    rv_id = rv_id + 1.
  ENDMETHOD.

  METHOD alta_reserva.
    DATA ls_reserva TYPE ztab_verano_06.

    ls_reserva-client           = sy-mandt.
    ls_reserva-id_reserva       = generar_id_reserva( ).
    ls_reserva-nombre_cliente   = mv_nombre.
    ls_reserva-apellido_cliente = mv_apellido.
    ls_reserva-telefono         = mv_telefono.
    ls_reserva-importe_total    = calcular_importe( ).

    INSERT ztab_verano_06 FROM @ls_reserva.

    IF sy-subrc = 0.
      rv_mensaje = |Reserva creada correctamente con ID { ls_reserva-id_reserva }|.
    ELSE.
      rv_mensaje = 'Error al crear la reserva'.
    ENDIF.
  ENDMETHOD.

  METHOD modificar_reserva.
    SELECT SINGLE *
      FROM ztab_verano_06
      WHERE id_reserva = @iv_id
      INTO @DATA(ls_reserva).

    IF sy-subrc <> 0.
      rv_mensaje = 'Error: no existe ninguna reserva con ese ID'.
      RETURN.
    ENDIF.

    ls_reserva-nombre_cliente   = iv_nombre.
    ls_reserva-apellido_cliente = iv_apellido.
    ls_reserva-telefono         = iv_telefono.
    ls_reserva-importe_total    = 100 + ( iv_actividades * 25 ) + ( iv_dias * 40 ).

    UPDATE ztab_verano_06 FROM @ls_reserva.

    IF sy-subrc = 0.
      rv_mensaje = 'Reserva modificada correctamente'.
    ELSE.
      rv_mensaje = 'Error al modificar la reserva'.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_reservas.
    IF iv_id = 0.
      SELECT *
        FROM ztab_verano_06
        INTO TABLE @rt_result.
    ELSE.
      SELECT *
        FROM ztab_verano_06
        WHERE id_reserva = @iv_id
        INTO TABLE @rt_result.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_n_reservas.
    SELECT *
      FROM ztab_verano_06
      ORDER BY id_reserva
      INTO TABLE @rt_result
      UP TO @iv_n ROWS.
  ENDMETHOD.

ENDCLASS.
