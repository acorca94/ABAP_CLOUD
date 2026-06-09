CLASS zcl_empleado_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES ty_empleados TYPE STANDARD TABLE OF ztab_usuario_06
                       WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        iv_nombre         TYPE string
        iv_apellido       TYPE string
        iv_telefono       TYPE string
        iv_experiencia    TYPE i
        iv_certificaciones TYPE i.

    METHODS calcular_sueldo
      RETURNING VALUE(rv_sueldo) TYPE zde_sueldo_empleado_06.

    METHODS generar_id_empleado
      RETURNING VALUE(rv_id) TYPE zde_id_empleado_06.

    METHODS alta_empleado
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS modificar_empleado
      IMPORTING
        iv_id             TYPE zde_id_empleado_06
        iv_nombre         TYPE string
        iv_apellido       TYPE string
        iv_telefono       TYPE string
        iv_experiencia    TYPE i
        iv_certificaciones TYPE i
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS consultar_empleados
      IMPORTING
        iv_id            TYPE zde_id_empleado_06
      RETURNING
        VALUE(rt_result) TYPE ty_empleados.

    METHODS consultar_n_empleados
      IMPORTING
        iv_n             TYPE i
      RETURNING
        VALUE(rt_result) TYPE ty_empleados.

  PRIVATE SECTION.
    DATA mv_nombre         TYPE string.
    DATA mv_apellido       TYPE string.
    DATA mv_telefono       TYPE string.
    DATA mv_experiencia    TYPE i.
    DATA mv_certificaciones TYPE i.

ENDCLASS.

CLASS zcl_empleado_06 IMPLEMENTATION.

  METHOD constructor.
    mv_nombre          = iv_nombre.
    mv_apellido        = iv_apellido.
    mv_telefono        = iv_telefono.
    mv_experiencia     = iv_experiencia.
    mv_certificaciones = iv_certificaciones.
  ENDMETHOD.

  METHOD calcular_sueldo.
    rv_sueldo = 1000 + ( mv_certificaciones * 50 ) + ( mv_experiencia * 100 ).
  ENDMETHOD.

  METHOD generar_id_empleado.
    SELECT SINGLE MAX( id_empleado )
      FROM ztab_usuario_06
      INTO @rv_id.
    rv_id = rv_id + 1.
  ENDMETHOD.

  METHOD alta_empleado.
    DATA ls_empleado TYPE ztab_usuario_06.

    ls_empleado-client      = sy-mandt.
    ls_empleado-id_empleado = generar_id_empleado( ).
    ls_empleado-nombre      = mv_nombre.
    ls_empleado-apellido    = mv_apellido.
    ls_empleado-telefono    = mv_telefono.
    ls_empleado-sueldo      = calcular_sueldo( ).

    INSERT ztab_usuario_06 FROM @ls_empleado.

    IF sy-subrc = 0.
      rv_mensaje = |Empleado creado correctamente con ID { ls_empleado-id_empleado }|.
    ELSE.
      rv_mensaje = 'Error al crear el empleado'.
    ENDIF.
  ENDMETHOD.

  METHOD modificar_empleado.
    SELECT SINGLE *
      FROM ztab_usuario_06
      WHERE id_empleado = @iv_id
      INTO @DATA(ls_empleado).

    IF sy-subrc <> 0.
      rv_mensaje = 'Error: no existe ningún empleado con ese ID'.
      RETURN.
    ENDIF.

    ls_empleado-nombre   = iv_nombre.
    ls_empleado-apellido = iv_apellido.
    ls_empleado-telefono = iv_telefono.
    ls_empleado-sueldo   = 1000 + ( iv_certificaciones * 50 ) + ( iv_experiencia * 100 ).

    UPDATE ztab_usuario_06 FROM @ls_empleado.

    IF sy-subrc = 0.
      rv_mensaje = 'Empleado modificado correctamente'.
    ELSE.
      rv_mensaje = 'Error al modificar el empleado'.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_empleados.
    IF iv_id = 0.
      SELECT *
        FROM ztab_usuario_06
        INTO TABLE @rt_result.
    ELSE.
      SELECT *
        FROM ztab_usuario_06
        WHERE id_empleado = @iv_id
        INTO TABLE @rt_result.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_n_empleados.
    SELECT *
      FROM ztab_usuario_06
      ORDER BY id_empleado
      INTO TABLE @rt_result
      UP TO @iv_n ROWS.
  ENDMETHOD.

ENDCLASS.
