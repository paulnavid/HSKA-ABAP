*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lhc_language DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    TYPES tt_language_update TYPE TABLE FOR UPDATE yi_lang_m_007.

    METHODS validateReleaseYear FOR VALIDATION Language~validateReleaseYear
      IMPORTING keys FOR Language.

    METHODS validateRating FOR VALIDATION Language~validateRating
      IMPORTING keys FOR Language.

    METHODS rejectLanguage FOR MODIFY
      IMPORTING keys FOR ACTION Language~rejectLanguage RESULT result.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR Language RESULT result.


ENDCLASS.

CLASS lhc_language IMPLEMENTATION.

  METHOD rejectlanguage.
    MODIFY ENTITIES OF yi_lang_m_007 IN LOCAL MODE
      ENTITY Language
      UPDATE FROM VALUE #(
        FOR key IN keys ( language_id    = key-language_id
                          status = 'X'   " Canceled
                          %control-language_id = if_abap_behv=>mk-on ) )
           FAILED   failed
           REPORTED reported.

    " read changed data for result
    READ ENTITIES OF yi_lang_m_007 IN LOCAL MODE
     ENTITY Language
       FIELDS ( language_id
                language_name
                language_description
                release_year
                language_rating
                status )
         WITH VALUE #( FOR key IN keys ( language_id = key-language_id ) )
     RESULT DATA(lt_language).

    result = VALUE #( FOR language IN lt_language ( language_id = language-language_id
                                                %param    = language
                                              ) ).
  ENDMETHOD.

  METHOD get_features.
    READ ENTITY yi_lang_m_007
         FIELDS (  language_id status )
           WITH VALUE #( FOR keyval IN keys (  %key = keyval-%key ) )
         RESULT DATA(lt_language_result).


    result = VALUE #( FOR ls_language IN lt_language_result
                       ( %key                           = ls_language-%key
                         %features-%action-rejectLanguage = COND #( WHEN ls_language-status = 'X'
                                                                    THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled  )
                      ) ).

  MODIFY ENTITIES OF yi_lang_m_007 IN LOCAL MODE
           ENTITY language
              UPDATE FROM VALUE #( FOR key IN keys ( language_id = key-language_id
                                                     status = 'X'
                                                     %control-status = if_abap_behv=>mk-on ) )
           FAILED   failed
           REPORTED reported.

  ENDMETHOD.

  METHOD validatereleaseyear.

    READ ENTITY yi_lang_m_007\\Language FROM VALUE #(
    FOR <root_key> IN keys ( %key     = <root_key>
                             %control = VALUE #( language_id = if_abap_behv=>mk-on ) ) )
          RESULT DATA(lt_language).

     LOOP AT lt_language INTO DATA(ls_language).



      IF NOT ls_language-release_year <= cl_abap_context_info=>get_system_date(  ).
        APPEND VALUE #(  language_id = ls_language-language_id ) TO failed.
        APPEND VALUE #(  language_id = ls_language-language_id
                         %msg      = new_message( id = 'YHSKA99'
                         number   = '002'
                         v1       = ls_language-release_year
                         severity = if_abap_behv_message=>severity-error )
                         %element-release_year = if_abap_behv=>mk-on ) TO reported.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validaterating.

    READ ENTITY yi_lang_m_007\\Language FROM VALUE #(
    FOR <root_key> IN keys ( %key     = <root_key>
                             %control = VALUE #( language_id = if_abap_behv=>mk-on ) ) )
          RESULT DATA(lt_language).

     LOOP AT lt_language INTO DATA(ls_language).

      IF NOT ls_language-language_rating CA '12345'.
        APPEND VALUE #(  language_id = ls_language-language_id ) TO failed.
        APPEND VALUE #(  language_id = ls_language-language_id
                         %msg      = new_message( id = 'YHSKA99'
                         number   = '001'
                         v1       = ls_language-language_rating
                         severity = if_abap_behv_message=>severity-error )
                         %element-language_rating = if_abap_behv=>mk-on ) TO reported.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
