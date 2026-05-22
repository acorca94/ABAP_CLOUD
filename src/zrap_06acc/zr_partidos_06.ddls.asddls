@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPARTIDOS_06'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PARTIDOS_06
  as select from ZPARTIDOS_06
{
  key id_partido as IdPartido,
  tipo_partido as TipoPartido,
  nombre_jugador as NombreJugador,
  num_jugadores as NumJugadores,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
}
