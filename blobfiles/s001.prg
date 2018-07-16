/*
 * BLOB Sample n� 1
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to store/retrieve an image into/from
 * a BLOB field and how to show it using an IMAGE control.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "blob.ch"

FUNCTION Main

   LOCAL aStruct := { {"CODE", "N", 3, 0}, {"IMAGE", "M", 10, 0} }
   LOCAL cInput  := "Input.ico"
   LOCAL cOutput := "Output.ico"
   LOCAL oForm
   LOCAL oImage

   REQUEST DBFCDX, DBFFPT
   RDDSETDEFAULT( "DBFCDX")

   DBCREATE( "IMAGES", aStruct )

   USE IMAGES NEW
   APPEND BLANK
   REPLACE code with 1

   // Import
   IF ! BLOBIMPORT( FIELDPOS( "IMAGE" ), cInput )
      ? "Error importing !!!"
      RETURN NIL
   ENDIF

   // Export
   FERASE( cOutput )
   IF ! BLOBEXPORT( FIELDPOS( "IMAGE" ), cOutput, BLOB_EXPORT_OVERWRITE )
      ? "Error exporting !!!"
   ENDIF

   // Show
   DEFINE WINDOW Form_1 ;
      OBJ oForm ;
      AT 0,0 ;
      WIDTH 588 ;
      HEIGHT 480 ;
      TITLE 'Show image from BLOB file' ;
      MAIN ;
      ON RELEASE ( DBCLOSEALL(), DBCOMMITALL() )

      @ 10, 10 IMAGE Img_1 ;
         OBJ oImage ;
         IMAGESIZE ;
         BUFFER BLOBGET( FIELDPOS( "IMAGE" ) )

      ON KEY ESCAPE ACTION oForm:Release()
   END WINDOW

   oForm:Center()
   oForm:Activate()

   CLOSE DATABASES

RETURN NIL

/*
 * EOF
 */
