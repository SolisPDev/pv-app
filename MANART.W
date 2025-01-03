&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          pv-app           PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEFINE  SHARED VARIABLE regdir     AS RECID.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-3

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Articulos Clasificaciones

/* Definitions for BROWSE BROWSE-3                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-3 Articulos.Desart Articulos.Claart ~
Articulos.Ex Articulos.Precios[1] 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-3 
&Scoped-define QUERY-STRING-BROWSE-3 FOR EACH Articulos NO-LOCK, ~
      EACH Clasificaciones OF Articulos OUTER-JOIN NO-LOCK ~
    BY Articulos.Desart INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-3 OPEN QUERY BROWSE-3 FOR EACH Articulos NO-LOCK, ~
      EACH Clasificaciones OF Articulos OUTER-JOIN NO-LOCK ~
    BY Articulos.Desart INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-3 Articulos Clasificaciones
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-3 Articulos
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-3 Clasificaciones


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-3}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-3 b-cancel b-aceptar RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-busca 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON b-aceptar AUTO-GO 
     LABEL "Aceptar" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON b-cancel AUTO-END-KEY 
     LABEL "Cancelar" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-busca AS CHARACTER FORMAT "X(40)":U 
      VIEW-AS TEXT 
     SIZE 64 BY .62.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 740  NO-FILL 
     SIZE 66 BY 1.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-3 FOR 
      Articulos, 
      Clasificaciones SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-3 Dialog-Frame _STRUCTURED
  QUERY BROWSE-3 NO-LOCK DISPLAY
      Articulos.Desart FORMAT "X(56)":U WIDTH 67
      Articulos.Claart COLUMN-LABEL "Clave" FORMAT "X(15)":U
      Articulos.Ex COLUMN-LABEL "Existencia" FORMAT "->,>>>,>>9.99":U
      Articulos.Precios[1] COLUMN-LABEL "Precio 1" FORMAT "$>>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 118.8 BY 16.38.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     BROWSE-3 AT ROW 1.48 COL 2.2
     b-cancel AT ROW 18.38 COL 82
     b-aceptar AT ROW 18.38 COL 101
     v-busca AT ROW 18.62 COL 3 COLON-ALIGNED NO-LABEL
     RECT-1 AT ROW 18.38 COL 4
     SPACE(52.19) SKIP(0.37)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Selección por nombre de  Articulo"
         DEFAULT-BUTTON b-aceptar CANCEL-BUTTON b-cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   EXP-POSITION                                                         */
/* BROWSE-TAB BROWSE-3 1 Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:ROW              = 1
       FRAME Dialog-Frame:COLUMN           = 1
       FRAME Dialog-Frame:HIDDEN           = TRUE.

ASSIGN 
       RECT-1:HIDDEN IN FRAME Dialog-Frame           = TRUE.

/* SETTINGS FOR FILL-IN v-busca IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-3
/* Query rebuild information for BROWSE BROWSE-3
     _TblList          = "pv-app.Articulos,pv-app.Clasificaciones OF pv-app.Articulos"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _TblOptList       = ", OUTER"
     _OrdList          = "dbconsis.Articulos.Desart|yes"
     _FldNameList[1]   > pv-app.Articulos.Desart
"Articulos.Desart" ? "X(56)" "character" ? ? ? ? ? ? no ? no no "67" yes no no "U" "" ""
     _FldNameList[2]   > pv-app.Articulos.Claart
"Articulos.Claart" "Clave" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > pv-app.Articulos.Ex
"Articulos.Ex" "Existencia" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > pv-app.Articulos.Precios[1]
"Articulos.Precios[1]" "Precio 1" "$>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-3 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Selección por nombre de  Articulo */
DO:
  regdir= ?. 
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-aceptar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-aceptar Dialog-Frame
ON CHOOSE OF b-aceptar IN FRAME Dialog-Frame /* Aceptar */
DO:
   regdir=recid(Articulos).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-cancel Dialog-Frame
ON CHOOSE OF b-cancel IN FRAME Dialog-Frame /* Cancelar */
DO:
   regdir= ?.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-3
&Scoped-define SELF-NAME BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON ANY-PRINTABLE OF BROWSE-3 IN FRAME Dialog-Frame
DO:
          v-busca = v-busca + CAPS(CHR(LASTKEY)).
          DISPLAY v-busca WITH FRAME {&FRAME-NAME}.
          run echale.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON BACKSPACE OF BROWSE-3 IN FRAME Dialog-Frame
DO:
   v-busca = CAPS(SUBSTRING (v-busca, 1 ,LENGTH(v-busca) - 1,"CHARACTER")).
   DISPLAY v-busca WITH FRAME {&FRAME-NAME}.
     run echale.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON CURSOR-DOWN OF BROWSE-3 IN FRAME Dialog-Frame
DO:
  v-busca:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  ASSIGN v-busca.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON CURSOR-UP OF BROWSE-3 IN FRAME Dialog-Frame
DO:
   v-busca:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  ASSIGN v-busca.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON END OF BROWSE-3 IN FRAME Dialog-Frame
DO:
  v-busca:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  ASSIGN v-busca.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON END-ERROR OF BROWSE-3 IN FRAME Dialog-Frame
DO:
  APPLY "CHOOSE" TO b-cancel IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON HOME OF BROWSE-3 IN FRAME Dialog-Frame
DO:
    v-busca:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  ASSIGN v-busca.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF BROWSE-3 IN FRAME Dialog-Frame
DO:
  APPLY "RETURN" TO BROWSE {&BROWSE-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON PAGE-DOWN OF BROWSE-3 IN FRAME Dialog-Frame
DO:
  v-busca:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  ASSIGN v-busca.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON PAGE-UP OF BROWSE-3 IN FRAME Dialog-Frame
DO:
    v-busca:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  ASSIGN v-busca.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 Dialog-Frame
ON RETURN OF BROWSE-3 IN FRAME Dialog-Frame
DO:
    APPLY "CHOOSE" TO b-aceptar IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE echale Dialog-Frame 
PROCEDURE echale :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  FIND FIRST Articulos WHERE Articulos.desart BEGINS v-busca USE-INDEX desart NO-LOCK NO-ERROR.
  IF AVAILABLE Articulos THEN DO:
     REPOSITION {&BROWSE-NAME} TO RECID RECID(Articulos) NO-ERROR.
     regdir = RECID(articulos).
  END.
  ELSE DO:
     FIND FIRST Articulos WHERE RECID(Articulos) = regdir NO-LOCK NO-ERROR.
  END.
       

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY v-busca 
      WITH FRAME Dialog-Frame.
  ENABLE BROWSE-3 b-cancel b-aceptar RECT-1 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

