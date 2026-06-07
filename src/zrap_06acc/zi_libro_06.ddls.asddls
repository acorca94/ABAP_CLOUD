@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZZLIB_LIBRO_06'
@EndUserText.label: 'Vista Base Libros'
@Search.searchable: true
define root view entity ZI_LIBRO_06
  as select from zlib_libro_06 as Libro
{
  key libro_id as LibroID,

  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  titulo as Titulo,

  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  autor as Autor,

  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  genero as Genero,

  num_paginas as NumPaginas,
  disponible as Disponible,
  estado as Estado,

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
