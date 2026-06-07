@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZZLIB_LIBRO_06'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_LIBRO_06
  provider contract TRANSACTIONAL_QUERY
  as projection on ZI_LIBRO_06
  association [1..1] to ZI_LIBRO_06 as _BaseEntity on $projection.LIBROID = _BaseEntity.LIBROID
{
  key LibroID,
  Titulo,
  Autor,
  Genero,
  NumPaginas,
  Disponible,
  Estado,
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
