@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZPARTIDOS_06'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PARTIDOS_06
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_PARTIDOS_06
  association [1..1] to ZR_PARTIDOS_06 as _BaseEntity on $projection.IDPARTIDO = _BaseEntity.IDPARTIDO
{
  key IdPartido,
  TipoPartido,
  NombreJugador,
  NumJugadores,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
