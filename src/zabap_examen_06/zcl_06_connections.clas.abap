CLASS zcl_06_connections DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS get_connections
      IMPORTING
        i_departure   TYPE /dmo/airport_from_id
      RETURNING
        VALUE(r_connections) TYPE zcert_connections.

ENDCLASS.



CLASS zcl_06_connections IMPLEMENTATION.

  METHOD get_connections.

    " Vuelos directos
    SELECT carrier_id,
           airport_from_id,
           airport_to_id,
           '-' AS airport_via_id
      FROM /dmo/connection
      WHERE airport_from_id = @i_departure
      INTO TABLE @r_connections.

    " Vuelos con escala (mismo carrier)
    SELECT c1~carrier_id,
           c1~airport_from_id,
           c2~airport_to_id,
           c1~airport_to_id AS airport_via_id
      FROM /dmo/connection AS c1
      INNER JOIN /dmo/connection AS c2
        ON  c1~carrier_id    = c2~carrier_id
        AND c1~airport_to_id = c2~airport_from_id
      WHERE c1~airport_from_id = @i_departure
        AND c2~airport_to_id  <> @i_departure
      APPENDING TABLE @r_connections.

  ENDMETHOD.

ENDCLASS.
