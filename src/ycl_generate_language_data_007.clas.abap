CLASS ycl_generate_language_data_007 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_generate_language_data_007 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA:itab TYPE TABLE OF ylanguage_007.

*   read current timestamp
    GET TIME STAMP FIELD DATA(zv_tsl).

*   fill internal travel table (itab)
    itab = VALUE #(

  ( language_id = '001' language_name = 'Java' language_rating = '5' language_description =
'Java is one of the most popular and widely-used programming languages in the world. Can be used for Android, desktop or server applications.' language_documentation = 'https://docs.oracle.com/en/java/' release_year = '1995' status = ' ' )

  ( language_id = '002' language_name = 'C++' language_rating = '4' language_description = 'C++ is a high-level, general-purpose programming language created by Bjarne Stroustrup as an extension of the C programming language, or "C with Classes".'
language_documentation = 'https://en.cppreference.com/w/cpp/language' release_year = '1985' status = ' ' )

  ( language_id = '003' language_name = 'JavaScript' language_rating = '2' language_description = 'JavaScript (or JS) is a high-level, multi-paradigmatic programming language that conforms to the ECMAScript specification.' language_documentation =
'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide' release_year = '1995' status = ' ' )

  ( language_id = '004' language_name = 'Python' language_rating = '5' language_description = 'Python is an interpreted, high-level, general-purpose programming language.' language_documentation = 'https://docs.python.org/3/' release_year = '1990'
  status = ' ' )

  ( language_id = '005' language_name = 'C#' language_rating = '4' language_description =
'C# is a general-purpose, multi-paradigm programming language encompassing strong typing, lexically scoped, imperative, declarative, functional, generic, object-oriented (class-based), and component-oriented programming disciplines.'
language_documentation = 'https://docs.microsoft.com/de-de/dotnet/csharp/' release_year = '2000' status = ' ' )

  ( language_id = '006' language_name = 'R' language_rating = '3' language_description = 'R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing.'
language_documentation = 'https://www.r-project.org' release_year = '1993' status = ' ' )

  ( language_id = '007' language_name = 'JSFuck' language_rating = '1' language_description =
'JSFuck is an esoteric and educational programming style based on the atomic parts of JavaScript. It uses only six different characters to write and execute code.' language_documentation = 'http://www.jsfuck.com' release_year = '2013' status = ' ' )

  ( language_id = '008' language_name = 'Go' language_rating = '4' language_description =
'Go is a statically typed, compiled programming language designed at Google. It is syntactically similar to C, but with memory safety, garbage collection, structural typing, and CSP-style concurrency.' language_documentation = 'https://golang.org'
release_year = '2009' status = ' ' )

  ( language_id = '009' language_name = 'Haskell' language_rating = '2' language_description =
'Haskell is a general-purpose, statically typed, purely functional programming language with type inference and lazy evaluation.' language_documentation = 'https://www.haskell.org'
release_year = '1990' status = ' ' )

( language_id = '010' language_name = 'MATLAB' language_rating = '1' language_description =
'MATLAB is a multi-paradigm numerical computing environment and proprietary programming language developed by MathWorks. It allows matrix manipulations, plotting of functions and data, implementation of algorithms and creation of user interfaces.'
language_documentation = 'https://www.mathworks.com/help/documentation-center.html'
release_year = '1984' status = ' ' )


  ).

*   delete existing entries in the database table
    DELETE FROM ylanguage_007.

*   insert the new table entries
    INSERT ylanguage_007 FROM TABLE @itab.

*   check the result
    SELECT * FROM ylanguage_007 INTO TABLE @itab.
    out->write( sy-dbcnt ).
    out->write( 'Language data inserted successfully!').
  ENDMETHOD.

ENDCLASS.
