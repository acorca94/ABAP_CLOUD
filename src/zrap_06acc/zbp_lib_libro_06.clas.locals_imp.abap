CLASS lhc_libro DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR libro
      RESULT result.

    METHODS validar_paginas FOR VALIDATE ON SAVE
      IMPORTING keys FOR libro~validar_paginas.

    METHODS calcular_estado FOR DETERMINE ON MODIFY
      IMPORTING keys FOR libro~calcular_estado.

ENDCLASS.

CLASS lhc_libro IMPLEMENTATION.

  METHOD get_global_authorizations.
    result-%create = if_abap_behv=>auth-allowed.
    result-%update = if_abap_behv=>auth-allowed.
    result-%delete = if_abap_behv=>auth-allowed.
  ENDMETHOD.

  METHOD validar_paginas.

    READ ENTITIES OF zi_libro_06 IN LOCAL MODE
      ENTITY libro
        FIELDS ( numpaginas )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_libros).

    LOOP AT lt_libros INTO DATA(ls_libro).
      IF ls_libro-numpaginas <= 10.
        APPEND VALUE #(
          %tky = ls_libro-%tky
        ) TO failed-libro.

        APPEND VALUE #(
          %tky     = ls_libro-%tky
          %msg     = new_message_with_text(
                       severity = if_abap_behv_message=>severity-error
                       text     = 'El libro debe tener más de 10 páginas' )
          %element-numpaginas = if_abap_behv=>mk-on
        ) TO reported-libro.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD calcular_estado.

    READ ENTITIES OF zi_libro_06 IN LOCAL MODE
      ENTITY libro
        FIELDS ( numpaginas )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_libros).

    MODIFY ENTITIES OF zi_libro_06 IN LOCAL MODE
      ENTITY libro
        UPDATE FIELDS ( estado )
        WITH VALUE #( FOR ls_libro IN lt_libros (
          %tky   = ls_libro-%tky
          estado = COND #(
            WHEN ls_libro-numpaginas < 50   THEN 'Muy deteriorado'
            WHEN ls_libro-numpaginas < 150  THEN 'Deteriorado'
            WHEN ls_libro-numpaginas < 400  THEN 'Bueno'
            ELSE                                 'Nuevo'
          )
          %control-estado = if_abap_behv=>mk-on
        ) )
      REPORTED DATA(lt_reported).

  ENDMETHOD.

ENDCLASS.
