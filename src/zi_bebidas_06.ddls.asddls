@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vista Base Bebidas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_BEBIDAS_06
  as select from zbebidas_06
{
  key codigo      as Codigo,
      nombre      as Nombre,
      tipo        as Tipo,
      origen      as Origen,
      graduacion  as Graduacion,
      precio      as Precio
}
