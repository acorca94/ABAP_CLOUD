@AbapCatalog.sqlViewName: 'ZVUELO06'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Creación de la lógica de la vista CDS'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_VUELO_06 
  as select from /dmo/flight as flight
  association [1..1] to /dmo/carrier as _Carrier on flight.carrier_id = _Carrier.carrier_id
{
    key flight.carrier_id,
    key flight.connection_id,
    key flight.flight_date,
    _Carrier.name as name,        -- Nombre de la aerolínea (desde la asociación)
    flight.price as price,        -- Precio del vuelo
    flight.currency_code          -- Siempre es bueno traer la moneda
}
