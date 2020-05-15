@AbapCatalog.sqlViewName: 'YVI_LANG_M_007'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Language data - 007'
define root view YI_LANG_M_007
  as select from ylanguage_007 as Language
{

  key language_id,
      language_name,
      language_description,
      language_rating,
      language_documentation,
      release_year,
      status
      
}
