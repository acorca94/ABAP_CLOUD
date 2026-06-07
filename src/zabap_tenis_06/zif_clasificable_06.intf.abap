INTERFACE zif_clasificable_06
  PUBLIC.

  METHODS:
    esta_clasificado
      RETURNING VALUE(rv_result) TYPE abap_bool,
    get_posicion_ranking
      RETURNING VALUE(rv_pos) TYPE i.

ENDINTERFACE.

