$PBExportHeader$w_blob.srw
forward
global type w_blob from window
end type
type cb_1 from commandbutton within w_blob
end type
end forward

global type w_blob from window
integer x = 1056
integer y = 484
integer width = 2569
integer height = 1516
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_1 cb_1
end type
global w_blob w_blob

on w_blob.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_blob.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_blob
integer x = 370
integer y = 332
integer width = 1385
integer height = 548
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;SQLCA.DBMS="ODBC"
SQLCA.DBParm = "ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL',DelimitIdentifier='Yes'"

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-14 By: Scofield
//$<Reason> Set the connection cache dynamically on Web
if AppeonGetClientType() = 'WEB' then
	SQLCA.DBMS = gs_CacheType
	SQLCA.DBParm = gs_CacheSet
end if
//---------------------------- APPEON END ----------------------------

CONNECT USING SQLCA;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Login", "Inital Login Failed!  Check your ODBC configuration")
	Return -1
END IF

Return 1
end event

