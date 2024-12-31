&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: articulos.w 

  Description: catalogo de articulos

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: Ing. Antonio Solis Perales

  Created: 30 de diciembre del 2024

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

DEFINE NEW  SHARED  VARIABLE v-derechos AS INTEGER.
  
v-derechos = 1.

DEFINE  SHARED  VARIABLE programas  AS CHARACTER.
DEFINE  SHARED  VARIABLE imagepath AS CHARACTER.
DEFINE  SHARED  VARIABLE ext        AS CHARACTER.
DEFINE  NEW SHARED  VARIABLE v-query AS LOGICAL.

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE i AS INTEGER.
DEFINE              VARIABLE v-opcion   AS LOGICAL INITIAL FALSE.
DEFINE              VARIABLE v-bandera  AS CHARACTER INITIAL "NADA".
DEFINE  NEW GLOBAL SHARED  VARIABLE regdir     AS RECID.
DEFINE VARIABLE v-path AS CHARACTER FORMAT "X(256)":U INITIAL "adeicon/blank".
DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
DEFINE VARIABLE v-lista AS CHARACTER.
DEFINE VARIABLE v-temporal AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMP-ART B-BUSLIN b-anterior b-baja b-cambio ~
b-cancelar b-final b-grabar b-lista b-nuevo b-principio b-siguiente ~
Btn_Done v-claart v-desart V-UNIDAD v-linea v-iva v-desex v-prec1 v-rango1 ~
v-rango2 v-prec2 v-rango3 v-rango4 v-prec3 v-rango5 v-rango6 v-prec4 ~
v-rango7 b-agregar v-rango8 v-prec5 v-rango9 v-rango10 v-codigo v-liscod ~
v-ctopro b-quitar v-existencia v-fecultcom v-fecultven v-deslin RECT-1 ~
RECT-12 RECT-13 RECT-15 RECT-16 
&Scoped-Define DISPLAYED-OBJECTS v-claart v-desart V-UNIDAD v-linea v-iva ~
v-desex v-prec1 v-rango1 v-rango2 v-prec2 v-rango3 v-rango4 v-prec3 ~
v-rango5 v-rango6 v-prec4 v-rango7 v-rango8 v-prec5 v-rango9 v-rango10 ~
v-codigo v-liscod v-ctopro v-existencia v-fecultcom v-fecultven v-deslin 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */
&Scoped-define List-1 B-BUSLIN v-desart V-UNIDAD v-linea v-iva v-desex ~
v-prec1 v-rango1 v-rango2 v-prec2 v-rango3 v-rango4 v-prec3 v-rango5 ~
v-rango6 v-prec4 v-rango7 b-agregar v-rango8 v-prec5 v-rango9 v-rango10 ~
v-codigo v-liscod v-ctopro b-quitar 
&Scoped-define List-2 b-anterior b-final b-lista b-principio b-siguiente 
&Scoped-define List-3 V-UNIDAD v-rango1 v-rango2 v-rango3 v-rango4 v-rango5 ~
v-rango6 v-rango7 v-rango8 v-rango9 v-rango10 
&Scoped-define List-5 v-deslin 

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON b-agregar  NO-FOCUS
     LABEL "Agregar  >" 
     SIZE 12 BY 1.14 TOOLTIP "Agregar el codigo capturado".

DEFINE BUTTON b-anterior  NO-FOCUS FLAT-BUTTON
     LABEL "Anterior" 
     SIZE 15.6 BY 1.33 TOOLTIP "Regresa al registro anterior".

DEFINE BUTTON b-baja  NO-FOCUS FLAT-BUTTON
     LABEL "Borrar" 
     SIZE 15.6 BY 1.33 TOOLTIP "Borrar el registro".

DEFINE BUTTON B-BUSLIN  NO-FOCUS FLAT-BUTTON
     LABEL "..." 
     SIZE 4 BY .95 TOOLTIP "Linea de Producto"
     FONT 6.

DEFINE BUTTON b-cambio  NO-FOCUS FLAT-BUTTON
     LABEL "Cambios" 
     SIZE 15.6 BY 1.33 TOOLTIP "Cambiar datos".

DEFINE BUTTON b-cancelar  NO-FOCUS FLAT-BUTTON
     LABEL "Cancelar" 
     SIZE 15.6 BY 1.33 TOOLTIP "Cancela la captura".

DEFINE BUTTON b-final  NO-FOCUS FLAT-BUTTON
     LABEL "Final" 
     SIZE 15.6 BY 1.33 TOOLTIP "Ver ultimo registro".

DEFINE BUTTON b-grabar  NO-FOCUS FLAT-BUTTON
     LABEL "Grabar" 
     SIZE 15.6 BY 1.33 TOOLTIP "Graba la información".

DEFINE BUTTON b-lista  NO-FOCUS FLAT-BUTTON
     LABEL "Lista" 
     SIZE 15.6 BY 1.33 TOOLTIP "Lista registros almacenados".

DEFINE BUTTON b-nuevo  NO-FOCUS FLAT-BUTTON
     LABEL "Nuevo" 
     SIZE 15.6 BY 1.33 TOOLTIP "Crear nuevo registro".

DEFINE BUTTON b-principio  NO-FOCUS FLAT-BUTTON
     LABEL "Primero" 
     SIZE 15.6 BY 1.33 TOOLTIP "Ver primer registro".

DEFINE BUTTON b-quitar  NO-FOCUS
     LABEL "<   Quitar" 
     SIZE 12 BY 1.14 TOOLTIP "Quita el codigo seleccionado en la lista".

DEFINE BUTTON b-siguiente  NO-FOCUS FLAT-BUTTON
     LABEL "siguiente" 
     SIZE 15.6 BY 1.33 TOOLTIP "Ver siguiente registro".

DEFINE BUTTON Btn_Done DEFAULT  NO-FOCUS FLAT-BUTTON
     LABEL "Salir" 
     SIZE 15.6 BY 1.33 TOOLTIP "Salir del programa"
     BGCOLOR 8 .

DEFINE BUTTON IMP-ART  NO-FOCUS FLAT-BUTTON
     LABEL "Reporte" 
     SIZE 15 BY 1.14 TOOLTIP "Genera archivo en Excel de Productos".

DEFINE VARIABLE V-UNIDAD AS INTEGER FORMAT "->,>>9":U INITIAL 0 
     LABEL "Unidad" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "PZA.",1,
                     "LTS.",2,
                     "PAQ.",3
     DROP-DOWN-LIST
     SIZE 23 BY 1 NO-UNDO.

DEFINE VARIABLE v-claart AS CHARACTER FORMAT "X(20)":U 
     LABEL "Clave" 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1 NO-UNDO.

DEFINE VARIABLE v-codigo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1 NO-UNDO.

DEFINE VARIABLE v-ctopro AS DECIMAL FORMAT "->>>,>>9.99999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1 NO-UNDO.

DEFINE VARIABLE v-desart AS CHARACTER FORMAT "X(50)":U 
     LABEL "Descripción" 
     VIEW-AS FILL-IN 
     SIZE 68 BY 1 NO-UNDO.

DEFINE VARIABLE v-deslin AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1 NO-UNDO.

DEFINE VARIABLE v-existencia AS DECIMAL FORMAT "->>>,>>9.999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1.2
     BGCOLOR 0 FGCOLOR 15 FONT 15 NO-UNDO.

DEFINE VARIABLE v-fecultcom AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1 NO-UNDO.

DEFINE VARIABLE v-fecultven AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1 NO-UNDO.

DEFINE VARIABLE v-iva AS DECIMAL FORMAT "->>9.99":U INITIAL 0 
     LABEL "I.V.A." 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1 NO-UNDO.

DEFINE VARIABLE v-linea AS INTEGER FORMAT ">>9":U INITIAL 0 
     LABEL "Linea" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1 NO-UNDO.

DEFINE VARIABLE v-prec1 AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 NO-UNDO.

DEFINE VARIABLE v-prec2 AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 NO-UNDO.

DEFINE VARIABLE v-prec3 AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 NO-UNDO.

DEFINE VARIABLE v-prec4 AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 NO-UNDO.

DEFINE VARIABLE v-prec5 AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango1 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango10 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango2 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango3 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango4 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango5 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango6 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango7 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango8 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-rango9 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 19 BY 18.81.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 67 BY 9.05.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 31 BY 13.1.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 84 BY 8.81.

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 29 BY 10.

DEFINE VARIABLE v-liscod AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 26 BY 8.81 NO-UNDO.

DEFINE VARIABLE v-desex AS LOGICAL INITIAL yes 
     LABEL "Descuenta Existencia" 
     VIEW-AS TOGGLE-BOX
     SIZE 25 BY .81 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMP-ART AT ROW 15.1 COL 121 NO-TAB-STOP 
     B-BUSLIN AT ROW 6.24 COL 26
     b-anterior AT ROW 3.38 COL 120.6 NO-TAB-STOP 
     b-baja AT ROW 10.62 COL 120.6 NO-TAB-STOP 
     b-cambio AT ROW 12.1 COL 120.6 NO-TAB-STOP 
     b-cancelar AT ROW 16.71 COL 120.6 NO-TAB-STOP 
     b-final AT ROW 6.24 COL 120.6 NO-TAB-STOP 
     b-grabar AT ROW 13.57 COL 120.6 NO-TAB-STOP 
     b-lista AT ROW 7.67 COL 120.6 NO-TAB-STOP 
     b-nuevo AT ROW 9.14 COL 120.6 NO-TAB-STOP 
     b-principio AT ROW 1.95 COL 120.6 NO-TAB-STOP 
     b-siguiente AT ROW 4.81 COL 120.6 NO-TAB-STOP 
     Btn_Done AT ROW 18.38 COL 120.6 NO-TAB-STOP 
     v-claart AT ROW 2.43 COL 16 COLON-ALIGNED HELP
          "Tecle la clave del articulo"
     v-desart AT ROW 3.62 COL 16 COLON-ALIGNED HELP
          "Tecle la descripción"
     V-UNIDAD AT ROW 4.81 COL 16 COLON-ALIGNED
     v-linea AT ROW 6.24 COL 16 COLON-ALIGNED HELP
          "Tecle la linea"
     v-iva AT ROW 7.67 COL 16 COLON-ALIGNED HELP
          "Tecle el porcentaje de impuesto"
     v-desex AT ROW 9.1 COL 18
     v-prec1 AT ROW 13.14 COL 20 COLON-ALIGNED NO-LABEL
     v-rango1 AT ROW 13.14 COL 39 COLON-ALIGNED NO-LABEL
     v-rango2 AT ROW 13.14 COL 55 COLON-ALIGNED NO-LABEL
     v-prec2 AT ROW 14.57 COL 20 COLON-ALIGNED NO-LABEL
     v-rango3 AT ROW 14.57 COL 39 COLON-ALIGNED NO-LABEL
     v-rango4 AT ROW 14.57 COL 55 COLON-ALIGNED NO-LABEL
     v-prec3 AT ROW 16 COL 20 COLON-ALIGNED NO-LABEL
     v-rango5 AT ROW 16 COL 39 COLON-ALIGNED NO-LABEL
     v-rango6 AT ROW 16 COL 55 COLON-ALIGNED NO-LABEL
     v-prec4 AT ROW 17.43 COL 20 COLON-ALIGNED NO-LABEL
     v-rango7 AT ROW 17.43 COL 39 COLON-ALIGNED NO-LABEL
     b-agregar AT ROW 14.1 COL 89 NO-TAB-STOP 
     v-rango8 AT ROW 17.43 COL 55 COLON-ALIGNED NO-LABEL
     v-prec5 AT ROW 18.86 COL 20 COLON-ALIGNED NO-LABEL
     v-rango9 AT ROW 18.86 COL 39 COLON-ALIGNED NO-LABEL
     v-rango10 AT ROW 18.86 COL 55 COLON-ALIGNED NO-LABEL
     v-codigo AT ROW 12.91 COL 87 COLON-ALIGNED NO-LABEL
     v-liscod AT ROW 15.52 COL 89 NO-LABEL
     v-ctopro AT ROW 9.1 COL 112 RIGHT-ALIGNED HELP
          "Tecle el costo promedio" NO-LABEL
     b-quitar AT ROW 14.1 COL 103 NO-TAB-STOP 
     v-existencia AT ROW 2.19 COL 112 RIGHT-ALIGNED HELP
          "Tecle la existencia" NO-LABEL NO-TAB-STOP 
     v-fecultcom AT ROW 4.57 COL 91 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     v-fecultven AT ROW 6.95 COL 91 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     v-deslin AT ROW 6.24 COL 35 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     RECT-1 AT ROW 1.48 COL 119
     RECT-12 AT ROW 11.71 COL 11
     RECT-13 AT ROW 11.71 COL 87
     RECT-15 AT ROW 1.48 COL 4
     RECT-16 AT ROW 1.48 COL 89
     "4" VIEW-AS TEXT
          SIZE 2 BY .62 AT ROW 17.67 COL 20
          FGCOLOR 1 FONT 6
     "== Ultima Venta ==" VIEW-AS TEXT
          SIZE 23 BY .62 AT ROW 6.24 COL 92
          FONT 6
     "== Costo ==" VIEW-AS TEXT
          SIZE 15 BY .62 AT ROW 8.38 COL 96
          FONT 6
     "5" VIEW-AS TEXT
          SIZE 2 BY .62 AT ROW 19.1 COL 20
          FGCOLOR 1 FONT 6
     "2" VIEW-AS TEXT
          SIZE 2 BY .62 AT ROW 14.81 COL 20
          FGCOLOR 1 FONT 6
     "1" VIEW-AS TEXT
          SIZE 2 BY .62 AT ROW 13.38 COL 20
          FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 139 BY 24.29.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     "3" VIEW-AS TEXT
          SIZE 2 BY .62 AT ROW 16.24 COL 20
          FGCOLOR 1 FONT 6
     "Codigo de Barras" VIEW-AS TEXT
          SIZE 17 BY .62 AT ROW 12.19 COL 89
     "Precios            Rangos" VIEW-AS TEXT
          SIZE 32 BY .62 AT ROW 12.43 COL 23
          FONT 6
     "== Existencias ==" VIEW-AS TEXT
          SIZE 20 BY .62 AT ROW 1.24 COL 93
          FONT 6
     "== Ultima Compra ==" VIEW-AS TEXT
          SIZE 24 BY .62 AT ROW 3.86 COL 91
          FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 139 BY 24.29.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Catálogo de Articulos"
         COLUMN             = 68
         ROW                = 7.1
         HEIGHT             = 24.33
         WIDTH              = 140
         MAX-HEIGHT         = 29.52
         MAX-WIDTH          = 224.6
         VIRTUAL-HEIGHT     = 29.52
         VIRTUAL-WIDTH      = 224.6
         CONTROL-BOX        = no
         MIN-BUTTON         = no
         MAX-BUTTON         = no
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = yes
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   Custom                                                               */
/* SETTINGS FOR BUTTON b-agregar IN FRAME DEFAULT-FRAME
   1                                                                    */
/* SETTINGS FOR BUTTON b-anterior IN FRAME DEFAULT-FRAME
   2                                                                    */
/* SETTINGS FOR BUTTON B-BUSLIN IN FRAME DEFAULT-FRAME
   1                                                                    */
/* SETTINGS FOR BUTTON b-final IN FRAME DEFAULT-FRAME
   2                                                                    */
/* SETTINGS FOR BUTTON b-lista IN FRAME DEFAULT-FRAME
   2                                                                    */
/* SETTINGS FOR BUTTON b-principio IN FRAME DEFAULT-FRAME
   2                                                                    */
/* SETTINGS FOR BUTTON b-quitar IN FRAME DEFAULT-FRAME
   1                                                                    */
/* SETTINGS FOR BUTTON b-siguiente IN FRAME DEFAULT-FRAME
   2                                                                    */
ASSIGN 
       v-claart:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-codigo IN FRAME DEFAULT-FRAME
   1                                                                    */
ASSIGN 
       v-codigo:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-ctopro IN FRAME DEFAULT-FRAME
   ALIGN-R 1                                                            */
/* SETTINGS FOR FILL-IN v-desart IN FRAME DEFAULT-FRAME
   1                                                                    */
ASSIGN 
       v-desart:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR TOGGLE-BOX v-desex IN FRAME DEFAULT-FRAME
   1                                                                    */
/* SETTINGS FOR FILL-IN v-deslin IN FRAME DEFAULT-FRAME
   5                                                                    */
ASSIGN 
       v-deslin:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-existencia IN FRAME DEFAULT-FRAME
   ALIGN-R                                                              */
ASSIGN 
       v-existencia:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       v-fecultcom:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       v-fecultven:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-iva IN FRAME DEFAULT-FRAME
   1                                                                    */
ASSIGN 
       v-iva:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-linea IN FRAME DEFAULT-FRAME
   1                                                                    */
ASSIGN 
       v-linea:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR SELECTION-LIST v-liscod IN FRAME DEFAULT-FRAME
   1                                                                    */
/* SETTINGS FOR FILL-IN v-prec1 IN FRAME DEFAULT-FRAME
   1                                                                    */
ASSIGN 
       v-prec1:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-prec2 IN FRAME DEFAULT-FRAME
   1                                                                    */
ASSIGN 
       v-prec2:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-prec3 IN FRAME DEFAULT-FRAME
   1                                                                    */
ASSIGN 
       v-prec3:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-prec4 IN FRAME DEFAULT-FRAME
   1                                                                    */
ASSIGN 
       v-prec4:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-prec5 IN FRAME DEFAULT-FRAME
   1                                                                    */
ASSIGN 
       v-prec5:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango1 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango1:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango10 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango10:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango2 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango2:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango3 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango3:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango4 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango4:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango5 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango5:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango6 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango6:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango7 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango7:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango8 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango8:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-rango9 IN FRAME DEFAULT-FRAME
   1 3                                                                  */
ASSIGN 
       v-rango9:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR COMBO-BOX V-UNIDAD IN FRAME DEFAULT-FRAME
   1 3                                                                  */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Catálogo de Articulos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /*  APPLY "CHOOSE" TO Btn_Done IN FRAME {&FRAME-NAME}.*/

  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Catálogo de Articulos */
DO:
    APPLY "CHOOSE" TO Btn_Done IN FRAME {&FRAME-NAME}.
    
/*  /* This event will close the window and terminate the procedure.  */
 *   APPLY "CLOSE":U TO THIS-PROCEDURE.
 *   RETURN NO-APPLY.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-agregar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-agregar C-Win
ON CHOOSE OF b-agregar IN FRAME DEFAULT-FRAME /* Agregar  > */
DO:
    IF v-codigo:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> "" THEN DO:
        ASSIGN
            v-codigo
            v-claart.
        
        FIND FIRST rartcod NO-LOCK
        WHERE rartcod.codbar = v-codigo
        USE-INDEX codcla NO-ERROR.
        IF NOT AVAILABLE rartcod THEN DO:
            
            DO i = 1 TO v-liscod:NUM-ITEMS IN FRAME {&FRAME-NAME} BY 1:
                IF v-codigo = v-liscod:ENTRY(i) THEN DO:
                    MESSAGE "Este Codigo ya esta en la Lista..." VIEW-AS
                    ALERT-BOX WARNING TITLE "Aviso".
                    DISPLAY "" @ v-codigo WITH FRAME {&FRAME-NAME}.
                    RETURN NO-APPLY.
                END.
            END.
            
            ASSIGN v-temporal = v-liscod:INSERT(v-codigo,1).
            DISPLAY "" @ v-codigo WITH FRAME {&FRAME-NAME}.
            APPLY "ENTRY" TO v-codigo.
        END.
        ELSE
        DO:
            MESSAGE "Este Codigo de Barras ya Existe..." VIEW-AS
            ALERT-BOX WARNING TITLE "Precaución".
            DISPLAY "" @ v-codigo WITH FRAME {&FRAME-NAME}.
            APPLY "ENTRY" TO v-codigo IN FRAME {&FRAME-NAME}.
        END.    
    END. 
    ELSE
        MESSAGE "Introduzca un codigo de barras..." VIEW-AS
        ALERT-BOX INFORMATION TITLE "Aviso".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-anterior
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-anterior C-Win
ON CHOOSE OF b-anterior IN FRAME DEFAULT-FRAME /* Anterior */
DO:
    IF AVAILABLE articulos THEN DO:
        FIND PREV articulos NO-LOCK USE-INDEX claart NO-ERROR.
        IF AVAILABLE articulos THEN
            RUN DESPLIEGA.
        ELSE
            FIND NEXT articulos NO-LOCK USE-INDEX claart NO-ERROR.
    END.
    ELSE
    DO:
        APPLY "CHOOSE" TO b-principio.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-baja
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-baja C-Win
ON CHOOSE OF b-baja IN FRAME DEFAULT-FRAME /* Borrar */
DO:
    RUN VALIDA_CLAVE.
    ASSIGN v-claart.
    
    IF v-claart <> "" THEN DO:
        MESSAGE "¿Desea borrar el registro?" VIEW-AS ALERT-BOX
        QUESTION BUTTONS YES-NO TITLE "Confirma" UPDATE v-opcion.
        IF NOT v-opcion THEN
            UNDO,RETRY.
        ELSE DO:
            FIND FIRST articulos EXCLUSIVE-LOCK
            WHERE articulos.claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
            USE-INDEX claart NO-ERROR.
            IF AVAILABLE articulos THEN DO:
/*                IF ARTICULOS.EX > 0 THEN DO:
                    MESSAGE "ARTICULO CON EXISTENCIA..." SKIP "BAJA INVALIDA...".
                    RELEASE ARTICULOS.
                    RETURN NO-APPLY.
                END.*/
            END.        
                    
            FOR EACH rartcod EXCLUSIVE-LOCK
            WHERE rartcod.claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
            USE-INDEX claart:
                DELETE rartcod.
            END.
            RELEASE rartcod.
            
            FOR EACH rangoart EXCLUSIVE-LOCK
            WHERE rangoart.claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
            USE-INDEX claart:
                DELETE rangoart.
            END.
            RELEASE rangoart.
            
            
            IF AVAILABLE articulos THEN DO:
                DELETE  articulos.
            END.
            RELEASE articulos.
            RUN COMIENZA.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME B-BUSLIN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B-BUSLIN C-Win
ON CHOOSE OF B-BUSLIN IN FRAME DEFAULT-FRAME /* ... */
DO:
    RUN RESTAURA_TECLAS.
    RUN VALUE(programas + "manlin" + ext).
    RUN ASIGNA_TECLAS.
    
    IF regdir <> ? THEN DO:
        FIND lineas NO-LOCK WHERE RECID(lineas) = regdir NO-ERROR.
        IF AVAILABLE lineas THEN
            DISPLAY 
                Lineas.Clalin @ v-linea
                Lineas.Deslin @ v-deslin
            WITH FRAME {&FRAME-NAME}.
        ELSE
            DISPLAY
                0   @ v-linea
                ""  @ v-deslin
            WITH FRAME {&FRAME-NAME}.
    END.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-cambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-cambio C-Win
ON CHOOSE OF b-cambio IN FRAME DEFAULT-FRAME /* Cambios */
DO:
    RUN VALIDA_CLAVE.
    IF v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> "" THEN DO: 
        RUN BOTONES_GRABAR.
        
        ASSIGN
            v-claart:READ-ONLY  = TRUE
            v-desart:READ-ONLY  = FALSE
            v-iva:READ-ONLY     = FALSE
            v-linea:READ-ONLY   = FALSE
            v-CTOPRO:READ-ONLY  = FALSE
            v-rango1:READ-ONLY  = FALSE
            v-rango2:READ-ONLY  = FALSE
            v-rango3:READ-ONLY  = FALSE
            v-rango4:READ-ONLY  = FALSE
            v-rango5:READ-ONLY  = FALSE
            v-rango6:READ-ONLY  = FALSE
            v-rango7:READ-ONLY  = FALSE
            v-rango8:READ-ONLY  = FALSE
            v-rango9:READ-ONLY  = FALSE
            v-rango10:READ-ONLY = FALSE
            v-codigo:READ-ONLY  = FALSE
            v-prec1:READ-ONLY   = FALSE
            v-prec2:READ-ONLY   = FALSE
            v-prec3:READ-ONLY   = FALSE
            v-prec4:READ-ONLY   = FALSE
            v-prec5:READ-ONLY   = FALSE.

        ENABLE
            b-agregar b-quitar b-grabar b-cancelar
            Btn_Done V-LISCOD B-BUSLIN
            v-desex v-unidad
        WITH FRAME {&FRAME-NAME}.  
        
        ASSIGN
            v-claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

        ASSIGN v-bandera = "modifica".
        APPLY "ENTRY" TO v-desart IN FRAME {&FRAME-NAME}.
    END.
    ELSE
    DO:
        MESSAGE "No hay nada que modificar..." VIEW-AS ALERT-BOX WARNING TITLE "Aviso".
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-cancelar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-cancelar C-Win
ON CHOOSE OF b-cancelar IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
    v-bandera = "limpia".
    RUN COMIENZA.     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-final
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-final C-Win
ON CHOOSE OF b-final IN FRAME DEFAULT-FRAME /* Final */
DO:
    FIND LAST articulos NO-LOCK USE-INDEX claart NO-ERROR.
    IF AVAILABLE articulos THEN DO:
        RUN DESPLIEGA.
        APPLY "ENTRY" TO v-claart.
    END.
    ELSE
    DO:
        MESSAGE "No hay información registrada..." VIEW-AS ALERT-BOX
        INFORMATION TITLE "Aviso".
        RETURN NO-APPLY.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-grabar C-Win
ON CHOOSE OF b-grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:
    IF  b-grabar:SENSITIVE = TRUE AND
    v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> "" THEN DO:
        MESSAGE "¿Datos correctos?" VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO TITLE "Confirme" UPDATE v-opcion.
        IF NOT v-opcion THEN
            UNDO,RETRY.
        ELSE
        DO:
            IF v-bandera = "nuevo" THEN DO:
                RUN VALIDA_EXCLAVE.
                IF v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> "0" THEN DO:
                    CREATE articulos.
                    UPDATE
                        articulos.claart    = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
                        articulos.Desart    = v-desart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
                        Articulos.iva       = DEC(v-iva:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        Articulos.Clalin    = DEC(v-linea:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[1]    = DEC(v-prec1:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[2]    = DEC(v-prec2:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[3]    = DEC(v-prec3:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[4]    = DEC(v-prec4:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[5]    = DEC(v-prec5:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.descuenta     = v-desex.    
                    
                    RUN GRABA_RANGOS.
                    RUN GRABA_CODIGOS.
                    RELEASE articulos.
                END.
            END.
            ELSE  /*se supone que la bandera fue modficar*/
            DO:
                FIND FIRST articulos EXCLUSIVE-LOCK
                WHERE claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
                USE-INDEX claart NO-ERROR.
                IF AVAILABLE articulos THEN DO:
                    UPDATE
                        articulos.Desart    = v-desart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
                        Articulos.iva       = DEC(v-iva:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        Articulos.Clalin    = DEC(v-linea:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.COSPRO   = DEC(v-CTOPRO:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[1]    = DEC(v-prec1:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[2]    = DEC(v-prec2:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[3]    = DEC(v-prec3:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[4]    = DEC(v-prec4:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.precios[5]    = DEC(v-prec5:SCREEN-VALUE IN FRAME {&FRAME-NAME})
                        articulos.descuenta     = v-desex.     
                    RUN GRABA_RANGOS.
                    RUN GRABA_CODIGOS.    
                    RELEASE articulos.
                END.
            END.
            ASSIGN v-bandera = "limpia".
            
            RUN COMIENZA.
        END. 
    END. 
    ELSE
        MESSAGE "Selección invalida al grabar" SKIP "favor de verificar"
        VIEW-AS ALERT-BOX WARNING TITLE "No valido".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-lista
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-lista C-Win
ON CHOOSE OF b-lista IN FRAME DEFAULT-FRAME /* Lista */
DO:
    RUN RESTAURA_TECLAS.
    RUN VALUE(programas + "manart" + EXT).
    RUN ASIGNA_TECLAS.
    IF REGDIR = ? THEN DO:
        DISPLAY "" @ v-claart WITH FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.
    
    IF REGDIR <> ? THEN DO:
        FIND articulos NO-LOCK WHERE RECID(articulos) = regdir NO-ERROR.
        IF NOT AVAILABLE articulos THEN DO:
            MESSAGE "No existe un registro con esa clave..." VIEW-AS
            ALERT-BOX INFORMATION TITLE "Aviso".
            RETURN NO-APPLY.
        END.
        ELSE
        DO:
            RUN DESPLIEGA.
            RUN VALIDA_DERECHOS.
        END.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-nuevo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-nuevo C-Win
ON CHOOSE OF b-nuevo IN FRAME DEFAULT-FRAME /* Nuevo */
DO:
    clear frame {&FRAME-NAME}.
    
    ASSIGN
        v-claart    = ""
        v-desart    = ""
        v-ctopro    = 0
        v-existencia    = 0
        v-iva       = 16
        v-linea     = 0
        v-liscod:LIST-ITEMS = ""
        v-prec1     = 0
        v-rango1    = 1
        v-prec2     = 0
        v-prec3     = 0
        v-prec4     = 0
        v-prec5     = 0
        v-rango10   = 0
        v-rango2    = 9999.00
        v-rango3    = 0
        v-rango4    = 0
        v-rango5    = 0
        v-rango6    = 0
        v-rango7    = 0
        v-rango8    = 0
        v-rango9    = 0
        
        v-desex     = TRUE.
        
        
    DISPLAY v-claart v-ctopro {&List-1} WITH FRAME {&FRAME-NAME}.
    RUN BOTONES_GRABAR.
    ASSIGN v-bandera = "nuevo".

    ASSIGN
        v-desart:READ-ONLY  = FALSE
        v-iva:READ-ONLY     = FALSE
        v-linea:READ-ONLY   = FALSE
        v-rango1:READ-ONLY  = FALSE
        v-rango2:READ-ONLY  = FALSE
        v-rango3:READ-ONLY  = FALSE
        v-rango4:READ-ONLY  = FALSE
        v-rango5:READ-ONLY  = FALSE
        v-rango6:READ-ONLY  = FALSE
        v-rango7:READ-ONLY  = FALSE
        v-rango8:READ-ONLY  = FALSE
        v-rango9:READ-ONLY  = FALSE
        v-rango10:READ-ONLY = FALSE
        v-codigo:READ-ONLY = FALSE
        v-prec1:READ-ONLY = FALSE
        v-prec2:READ-ONLY = FALSE
        v-prec3:READ-ONLY = FALSE
        v-prec4:READ-ONLY = FALSE
        v-prec5:READ-ONLY = FALSE.            


    ENABLE b-agregar b-quitar b-grabar b-cancelar Btn_Done v-desex V-UNIDAD
        V-LISCOD B-BUSLIN WITH FRAME {&FRAME-NAME}.
    APPLY "ENTRY" TO v-claart.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-principio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-principio C-Win
ON CHOOSE OF b-principio IN FRAME DEFAULT-FRAME /* Primero */
DO:
    FIND FIRST articulos NO-LOCK USE-INDEX claart NO-ERROR.
    IF AVAILABLE articulos THEN DO:
        RUN DESPLIEGA.
        APPLY "ENTRY" TO v-claart.
    END.
    ELSE
    DO:
        MESSAGE "No hay información registrada..." VIEW-AS ALERT-BOX
        INFORMATION TITLE "Aviso".
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-quitar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-quitar C-Win
ON CHOOSE OF b-quitar IN FRAME DEFAULT-FRAME /* <   Quitar */
DO:
    IF v-liscod:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ? THEN DO:
        ASSIGN v-codigo = v-liscod:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
        ASSIGN v-temporal = v-liscod:DELETE(v-liscod:SCREEN-VALUE IN FRAME {&FRAME-NAME}).
        DISPLAY v-codigo WITH FRAME {&FRAME-NAME}.
        APPLY "ENTRY" TO v-codigo.
    END. 
    ELSE
        MESSAGE "Seleccione un codigo de la lista" VIEW-AS
        ALERT-BOX INFORMATION TITLE "Aviso".
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-siguiente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-siguiente C-Win
ON CHOOSE OF b-siguiente IN FRAME DEFAULT-FRAME /* siguiente */
DO:
    IF AVAILABLE articulos THEN DO:
        FIND NEXT articulos NO-LOCK USE-INDEX claart NO-ERROR.
        IF AVAILABLE articulos THEN DO:
            RUN DESPLIEGA.
        END.
        ELSE
            FIND PREV articulos NO-LOCK USE-INDEX claart NO-ERROR.
    END.
    ELSE
    DO:
        APPLY "CHOOSE" TO b-principio.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done C-Win
ON CHOOSE OF Btn_Done IN FRAME DEFAULT-FRAME /* Salir */
DO:
    MESSAGE "¿Desea Salir del programa?" VIEW-AS ALERT-BOX
    QUESTION BUTTONS YES-NO TITLE "SALIDA" UPDATE v-opcion.
    IF v-opcion THEN DO:
        &IF DEFINED (adm-panel) <> 0 &THEN
            RUN dispatch IN THIS-PROCEDURE ('exit').
        &ELSE
            RUN RESTAURA_TECLAS.
            APPLY "CLOSE":U TO THIS-PROCEDURE.
        &ENDIF
    END.
    ELSE
        RETURN NO-APPLY.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-claart
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-claart C-Win
ON TAB OF v-claart IN FRAME DEFAULT-FRAME /* Clave */
DO:
    IF v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "0" AND
    v-bandera <> "limpia" THEN DO:
        MESSAGE "Campo en blanco no permitido" VIEW-AS ALERT-BOX INFORMATION
        TITLE "Aviso".
        RETURN NO-APPLY.
    END.
    
    IF v-bandera <> "nuevo" THEN DO:
        IF v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> "0" THEN DO:
            RUN REVISION_CODIGO.
            FIND FIRST rartcod NO-LOCK
            WHERE rartcod.codbar  = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
            USE-INDEX claart NO-ERROR.
            IF AVAILABLE rartcod THEN DO:
                FIND FIRST articulos NO-LOCK
                WHERE articulos.claart = rartcod.claart USE-INDEX claart NO-ERROR.
                IF AVAILABLE articulos THEN DO:
                    RUN DESPLIEGA.
                    RUN VALIDA_DERECHOS.
                END.    
                ELSE
                DO:
                    MESSAGE "No existe un Registro con esa clave ..." VIEW-AS ALERT-BOX
                    INFORMATION TITLE "Aviso".
                    SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
                    RETURN NO-APPLY.
                END.
            END.
            ELSE
            DO:
                FIND FIRST articulos NO-LOCK
                WHERE articulos.claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
                USE-INDEX claart NO-ERROR.
                IF NOT AVAILABLE articulos THEN DO:
                    MESSAGE "No existe un Registro con esa clave ..." VIEW-AS ALERT-BOX
                    INFORMATION TITLE "Aviso".
                    SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
                    RETURN NO-APPLY.
                END.
                ELSE
                DO: 
                    RUN DESPLIEGA.  
                    RUN VALIDA_DERECHOS.
                END.
            END.    
        END.
    END.
    
    IF v-bandera = "nuevo" THEN DO:
        RUN REVISION_CODIGO.
        FIND FIRST articulos NO-LOCK
        WHERE articulos.claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
        USE-INDEX claart NO-ERROR.
        IF AVAILABLE articulos THEN DO:
            MESSAGE "Ya existe un Registro con esa clave, por favor verifique..."
            VIEW-AS ALERT-BOX WARNING TITLE "Aviso".
            SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
            RETURN NO-APPLY.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-desex
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-desex C-Win
ON VALUE-CHANGED OF v-desex IN FRAME DEFAULT-FRAME /* Descuenta Existencia */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-linea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-linea C-Win
ON TAB OF v-linea IN FRAME DEFAULT-FRAME /* Linea */
DO:
    ASSIGN {&SELF-NAME}.
    
    IF {&SELF-NAME} = 0 THEN
        APPLY "CHOOSE" TO B-BUSLIN.
    ELSE
    DO:
        FIND FIRST lineas NO-LOCK WHERE Lineas.Clalin = {&SELF-NAME}
        USE-INDEX clalin NO-ERROR.
        IF AVAILABLE lineas THEN
            DISPLAY
                Lineas.Clalin @ v-linea
                Lineas.Deslin @ v-deslin
            WITH FRAME {&FRAME-NAME}.
        ELSE
            APPLY "CHOOSE" TO B-BUSLIN.    
    END.    
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-prec1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-prec1 C-Win
ON LEAVE OF v-prec1 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-prec2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-prec2 C-Win
ON LEAVE OF v-prec2 IN FRAME DEFAULT-FRAME
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-prec3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-prec3 C-Win
ON LEAVE OF v-prec3 IN FRAME DEFAULT-FRAME
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-prec4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-prec4 C-Win
ON LEAVE OF v-prec4 IN FRAME DEFAULT-FRAME
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-prec5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-prec5 C-Win
ON LEAVE OF v-prec5 IN FRAME DEFAULT-FRAME
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango1 C-Win
ON LEAVE OF v-rango1 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango10 C-Win
ON LEAVE OF v-rango10 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango2 C-Win
ON LEAVE OF v-rango2 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango3 C-Win
ON LEAVE OF v-rango3 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango4 C-Win
ON LEAVE OF v-rango4 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango5 C-Win
ON LEAVE OF v-rango5 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango6 C-Win
ON LEAVE OF v-rango6 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango7 C-Win
ON LEAVE OF v-rango7 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango8 C-Win
ON LEAVE OF v-rango8 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-rango9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-rango9 C-Win
ON LEAVE OF v-rango9 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN {&SELF-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME V-UNIDAD
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL V-UNIDAD C-Win
ON VALUE-CHANGED OF V-UNIDAD IN FRAME DEFAULT-FRAME /* Unidad */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  RUN ASIGNA_TECLAS.
  RUN INICIO.
  RUN COMIENZA.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ASIGNA_TECLAS C-Win 
PROCEDURE ASIGNA_TECLAS :
/*------------------------------------------------------------------------------
  Purpose: ASIGNAR LAS TECLAS DE CONTROL DE TECLADO
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
     ON CURSOR-UP  BACK-TAB.
     ON CURSOR-DOWN TAB.
     ON RETURN TAB.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BOTONES_GRABAR C-Win 
PROCEDURE BOTONES_GRABAR :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DISABLE
        b-anterior
        b-siguiente
        b-principio
        b-final
        b-nuevo
        b-cambio
        b-baja 
        b-lista
    WITH FRAME {&FRAME-NAME}.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE COMIENZA C-Win 
PROCEDURE COMIENZA :
/*------------------------------------------------------------------------------
  Purpose: INICIALIZAR LOS OBJETOS
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    ASSIGN
        v-claart    = ""
        v-desart    = ""
        V-UNIDAD    = 1
        v-ctopro    = 0
        v-existencia    = 0
        v-iva       = 0
        v-linea     = 0
        v-deslin    = ""
        v-rango1    = 0
        v-rango2    = 0
        v-rango3    = 0
        v-rango4    = 0
        v-rango5    = 0
        v-rango6    = 0
        v-rango7    = 0
        v-rango8    = 0
        v-rango9    = 0
        v-rango10   = 0
        v-existencia = 0
        v-fecultcom = ?
        v-fecultven = ?
        v-codigo = ""
        v-liscod:LIST-ITEMS IN FRAME {&FRAME-NAME} = ""
        v-prec1 = 0
        v-prec2 = 0
        v-prec3 = 0
        v-prec4 = 0
        v-prec5 = 0
        v-desex = FALSE.
    
    DISPLAY
        v-claart {&List-1} {&List-5} v-liscod
        v-existencia v-fecultcom v-fecultven  v-codigo WITH FRAME {&FRAME-NAME}.
    
 
    IF v-derechos = 1 THEN DO:
        ENABLE
            b-anterior
            b-final
            b-lista
            b-principio
            b-siguiente
            b-nuevo
            b-cancelar
            Btn_Done
        WITH FRAME {&FRAME-NAME}.
        
        DISABLE
            b-cambio
            b-grabar
            b-baja
            V-UNIDAD
        WITH FRAME {&FRAME-NAME}.
        
    END.
    
    ASSIGN
        v-claart:READ-ONLY = FALSE
        v-desart:READ-ONLY = TRUE
        v-ctopro:READ-ONLY = TRUE
        v-iva:READ-ONLY = TRUE
        v-linea:READ-ONLY = TRUE
        v-deslin:READ-ONLY = TRUE
        v-rango1:READ-ONLY = TRUE
        v-rango2:READ-ONLY = TRUE
        v-rango3:READ-ONLY = TRUE
        v-rango4:READ-ONLY = TRUE
        v-rango5:READ-ONLY = TRUE
        v-rango6:READ-ONLY = TRUE
        v-rango7:READ-ONLY = TRUE
        v-rango8:READ-ONLY = TRUE
        v-rango9:READ-ONLY = TRUE
        v-rango10:READ-ONLY = TRUE
        v-fecultcom:READ-ONLY = TRUE
        v-fecultven:READ-ONLY = TRUE
        v-codigo:READ-ONLY = TRUE
        v-prec1:READ-ONLY = TRUE
        v-prec2:READ-ONLY = TRUE
        v-prec3:READ-ONLY = TRUE
        v-prec4:READ-ONLY = TRUE
                    
        v-prec5:READ-ONLY = TRUE.            

    DISABLE b-agregar b-quitar B-BUSLIN V-LISCOD v-desex WITH FRAME {&FRAME-NAME}.

    APPLY "ENTRY" TO v-claart IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DESCRIPCIONES C-Win 
PROCEDURE DESCRIPCIONES :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
     
    FIND FIRST lineas NO-LOCK WHERE lineas.clalin = INT(v-linea:SCREEN-VALUE IN FRAME {&FRAME-NAME}) USE-INDEX clalin NO-ERROR.
    IF AVAILABLE lineas THEN
        DISPLAY Lineas.Deslin @ v-deslin WITH FRAME {&FRAME-NAME}.
    ELSE
        DISPLAY "" @ v-deslin WITH FRAME {&FRAME-NAME}.

    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DESPLIEGA C-Win 
PROCEDURE DESPLIEGA :
/*------------------------------------------------------------------------------
  Purpose: MUESTRA LOS DATOS DEL REGISTRO PREVIAMENTE SELECCIONADO    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    ASSIGN
        v-desex = articulos.descuenta.

      DISPLAY
        articulos.claart    @ v-claart
        articulos.desart    @ v-desart
        Articulos.Cospro @ v-ctopro
        Articulos.Ex        @ v-existencia
        Articulos.iva       @ v-iva
        Articulos.Clalin    @ v-linea
        articulos.precios[1] @ v-prec1
        articulos.precios[2] @ v-prec2
        articulos.precios[3] @ v-prec3
        articulos.precios[4] @ v-prec4
        articulos.precios[5] @ v-prec5 
        articulos.FecUltven @ v-fecultven
        articulos.fecultcom @ v-fecultcom
        v-desex
       WITH FRAME {&FRAME-NAME}.
    
    FIND FIRST rangoart NO-LOCK WHERE rangoart.claart = articulos.claart
    USE-INDEX claart NO-ERROR.
    IF AVAILABLE rangoart THEN
        ASSIGN
            v-rango1  = rangoart.ran1
            v-rango2  = rangoart.ran2
            v-rango3  = rangoart.ran3
            v-rango4  = rangoart.ran4
            v-rango5  = rangoart.ran5
            v-rango6  = rangoart.ran6
            v-rango7  = rangoart.ran7
            v-rango8  = rangoart.ran8
            v-rango9  = rangoart.ran9
            v-rango10 = rangoart.ran10.
    ELSE
        ASSIGN
            v-rango1  = 0
            v-rango2  = 0
            v-rango3  = 0
            v-rango4  = 0
            v-rango5  = 0
            v-rango6  = 0
            v-rango7  = 0
            v-rango8  = 0
            v-rango9  = 0
            v-rango10 = 0.

    DISPLAY {&List-3} WITH FRAME {&FRAME-NAME}.        

    
    RUN DESCRIPCIONES.
    RUN PON_RELACION.
    RUN VALIDA_DERECHOS.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
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
  DISPLAY v-claart v-desart V-UNIDAD v-linea v-iva v-desex v-prec1 v-rango1 
          v-rango2 v-prec2 v-rango3 v-rango4 v-prec3 v-rango5 v-rango6 v-prec4 
          v-rango7 v-rango8 v-prec5 v-rango9 v-rango10 v-codigo v-liscod 
          v-ctopro v-existencia v-fecultcom v-fecultven v-deslin 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE IMP-ART B-BUSLIN b-anterior b-baja b-cambio b-cancelar b-final 
         b-grabar b-lista b-nuevo b-principio b-siguiente Btn_Done v-claart 
         v-desart V-UNIDAD v-linea v-iva v-desex v-prec1 v-rango1 v-rango2 
         v-prec2 v-rango3 v-rango4 v-prec3 v-rango5 v-rango6 v-prec4 v-rango7 
         b-agregar v-rango8 v-prec5 v-rango9 v-rango10 v-codigo v-liscod 
         v-ctopro b-quitar v-existencia v-fecultcom v-fecultven v-deslin RECT-1 
         RECT-12 RECT-13 RECT-15 RECT-16 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE GRABA_CODIGOS C-Win 
PROCEDURE GRABA_CODIGOS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    FOR EACH rartcod EXCLUSIVE-LOCK
    WHERE rartcod.claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
    USE-INDEX claart:
        DELETE rartcod.
    END.
    
    RELEASE rartcod.
    
    DO i = 1 TO v-liscod:NUM-ITEMS IN FRAME {&FRAME-NAME} BY 1:
        CREATE rartcod.
        UPDATE
            rartcod.claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
            rartcod.codbar = v-liscod:ENTRY(i).
    END.
    
    RELEASE rartcod.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE GRABA_RANGOS C-Win 
PROCEDURE GRABA_RANGOS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    FIND FIRST rangoart EXCLUSIVE-LOCK WHERE rangoart.claart = articulos.claart
    USE-INDEX claart NO-ERROR.
    IF AVAILABLE rangoart THEN
        UPDATE
            rangoart.ran1   = DEC(v-rango1:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran2   = DEC(v-rango2:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran3   = DEC(v-rango3:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran4   = DEC(v-rango4:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran5   = DEC(v-rango5:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran6   = DEC(v-rango6:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran7   = DEC(v-rango7:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran8   = DEC(v-rango8:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran9   = DEC(v-rango9:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran10  = DEC(v-rango10:SCREEN-VALUE IN FRAME {&FRAME-NAME}).
    ELSE
    DO:
        CREATE rangoart.
        UPDATE
            rangoart.claart = articulos.claart
            rangoart.ran1   = DEC(v-rango1:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran2   = DEC(v-rango2:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran3   = DEC(v-rango3:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran4   = DEC(v-rango4:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran5   = DEC(v-rango5:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran6   = DEC(v-rango6:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran7   = DEC(v-rango7:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran8   = DEC(v-rango8:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran9   = DEC(v-rango9:SCREEN-VALUE IN FRAME {&FRAME-NAME})
            rangoart.ran10  = DEC(v-rango10:SCREEN-VALUE IN FRAME {&FRAME-NAME}).
    END.
    RELEASE rangoart.        
                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE INICIO C-Win 
PROCEDURE INICIO :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* IF v-derechos = 1 THEN
 *     MESSAGE "Usuario con control total".
 *  IF v-derechos = 2 THEN
 *     MESSAGE "Usuario con Acceso al sistema".
 *  IF v-derechos = 3 THEN
 *     MESSAGE "Usuario con acceso de solo consulta".*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PON_RELACION C-Win 
PROCEDURE PON_RELACION :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    ASSIGN v-lista = "".

    FOR EACH rartcod NO-LOCK
    WHERE rartcod.Claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}
    USE-INDEX claart:
        ASSIGN v-lista = v-lista + rartcod.codbar + ",".
    END.
    
    ASSIGN v-lista = SUBSTRING(v-lista,1, LENGTH(v-lista) - 1).
    
    ASSIGN v-liscod:LIST-ITEMS = v-lista.
    
    DISPLAY v-liscod WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE RESTAURA_TECLAS C-Win 
PROCEDURE RESTAURA_TECLAS :
/*------------------------------------------------------------------------------
  Purpose: RESTAURAR LOS VALORES DEL TECLADO
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
     ON TAB TAB.
     ON RETURN RETURN.
     ON CURSOR-UP CURSOR-UP.
     ON CURSOR-DOWN CURSOR-DOWN.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE REVISION_CODIGO C-Win 
PROCEDURE REVISION_CODIGO :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER t-artcod FOR rartcod.
DEF BUFFER t-articulos FOR articulos.

    FIND FIRST rartcod WHERE rartcod.codbar = V-CLAART:SCREEN-VALUE IN FRAME {&FRAME-NAME} USE-INDEX codbar NO-LOCK NO-ERROR.
    IF AVAILABLE rartcod THEN DO:
       FIND FIRST t-artcod WHERE t-artcod.codbar = rartcod.codbar 
                            AND  t-artcod.claart <> rartcod.claar USE-INDEX claart NO-LOCK NO-ERROR.
       IF AVAILABLE t-artcod THEN DO:
          FIND FIRST articulos WHERE articulos.claart = rartcod.claart USE-INDEX claart NO-LOCK NO-ERROR.
          FIND FIRST t-articulos WHERE t-articulos.claart = t-artcod.claart USE-INDEX claart NO-LOCK NO-ERROR.
          MESSAGE "Existe otro artículo con este código de barras." SKIP
              "   Clave: " articulos.claart SKIP
              "Artículo: " articulos.desart SKIP
              "------------------------------------------------------" SKIP
              "   Clave: " t-articulos.claart SKIP
              "Artículo: " t-articulos.desart VIEW-AS ALERT-BOX WARNING TITLE "Códigos".
       END.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE VALIDA_CLAVE C-Win 
PROCEDURE VALIDA_CLAVE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    APPLY "RETURN" TO v-claart IN FRAME {&FRAME-NAME}.
    IF v-claart:SCREEN-VALUE = "" THEN DO:
        ASSIGN
            v-desart = "".
        DISPLAY v-desart WITH FRAME {&FRAME-NAME}.
        RUN COMIENZA.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE VALIDA_DERECHOS C-Win 
PROCEDURE VALIDA_DERECHOS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    CASE v-Derechos:
        WHEN 1 THEN DO:
            ENABLE
                {&List-2}
                b-nuevo
                b-cambio
                b-baja
                b-cancelar
                Btn_Done
            WITH FRAME {&FRAME-NAME}.
            
            DISABLE b-grabar WITH FRAME {&FRAME-NAME}.
        
        END.
        
        WHEN 2 THEN DO:
            ENABLE
                {&List-2}
                b-cambio
                b-cancelar
                Btn_Done
            WITH FRAME {&FRAME-NAME}.
            
            DISABLE b-nuevo b-grabar b-baja WITH FRAME  {&FRAME-NAME}.
            
        END.
        
        WHEN 3 THEN DO:
            ENABLE
                {&List-2}
                b-cancelar
                Btn_Done
            WITH FRAME {&FRAME-NAME}.
            
            DISABLE
                b-nuevo
                b-grabar
                b-baja
                b-cambio
            WITH FRAME {&FRAME-NAME}.
        END.
    END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE VALIDA_EXCLAVE C-Win 
PROCEDURE VALIDA_EXCLAVE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    ASSIGN v-claart = v-claart:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
    
    FIND FIRST articulos WHERE articulos.claart = v-claart USE-INDEX claart NO-LOCK NO-ERROR.
    IF AVAILABLE articulos THEN DO:
        MESSAGE "Le ganaron el No. de la clave" SKIP
                "Debe volver a captura el registro con otra clave"
        VIEW-AS ALERT-BOX WARNING TITLE "Aviso".
        v-claart = "".
        DISPLAY v-claart WITH FRAME {&FRAME-NAME}.
     END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

