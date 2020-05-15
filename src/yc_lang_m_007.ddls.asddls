@EndUserText.label: 'Language projection view - Processor'
@AccessControl.authorizationCheck: #CHECK

@UI: {
 headerInfo: { typeName: 'Language', typeNamePlural: 'Languages', title: { type: #STANDARD, value: 'Name' } } }
@Search.searchable: true

define root view entity YC_LANG_M_007
  as projection on YI_LANG_M_007
{

      @UI.facet: [ { id:              'Language',
                    purpose:         #STANDARD,
                    type:            #IDENTIFICATION_REFERENCE,
                    label:           'Language',
                    position:        10 },
                  { id:'idHeader',
                    type:  #DATAPOINT_REFERENCE,
                    position: 10,
                    label: 'Header',
                    purpose: #HEADER,
                    targetQualifier: 'Rating'
                   } ]

      @UI: {
          lineItem:       [ { position: 20, importance: #HIGH } ],
          identification: [ { position: 20 , label: 'ID' } ] }
      @Search.defaultSearchElement: true
  key language_id          as Id,

      @UI: {
          lineItem:       [ { position: 25, importance: #HIGH } ],
          identification: [ { position: 25 , label: 'Name' } ] }
      @UI.multiLineText: false
      language_name        as Name,

      @UI: {
                lineItem:       [ { position: 30 } ],
                identification: [ { position: 30 , label: 'Description' } ]
                }
      @UI.multiLineText: true
      language_description as Description,

      @UI: {
         lineItem:       [ { position: 50, importance: #MEDIUM, type: #AS_DATAPOINT } ],
         dataPoint: { title: 'Rating', visualization: #RATING, targetValue: 5 },
         identification: [ { position: 50, label: 'Rating [1-5]' } ] }
      language_rating      as Rating,
      
      @UI: {
                lineItem:       [ { position: 35, type: #WITH_URL , url: 'Documentation' } ],
                identification: [ { position: 35 , type: #WITH_URL, url: 'Documentation', label: 'Documentation' } ]
                }
      language_documentation    as Documentation,

      @UI: {
                lineItem:       [ { position: 40, importance: #MEDIUM } ],
                identification: [ { position: 40 , label: 'Release Year' } ] }
      release_year         as ReleaseYear,

      @UI: {
        lineItem:[ { position: 70, importance: #HIGH }, { type: #FOR_ACTION, dataAction: 'rejectLanguage', label: 'Reject'} ],
        identification: [ { position: 70, label: 'Rejected' } ]  }
      status               as Status

}
