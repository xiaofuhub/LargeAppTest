$PBExportHeader$w_main_pix.srw
forward
global type w_main_pix from window
end type
type cb_8 from commandbutton within w_main_pix
end type
type cb_3 from commandbutton within w_main_pix
end type
type cb_1 from commandbutton within w_main_pix
end type
end forward

global type w_main_pix from window
integer x = 123
integer y = 112
integer width = 3419
integer height = 464
boolean titlebar = true
string title = "Intellicred Utilities"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
cb_8 cb_8
cb_3 cb_3
cb_1 cb_1
end type
global w_main_pix w_main_pix

type variables
integer ii_row
end variables

on w_main_pix.create
this.cb_8=create cb_8
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_8,&
this.cb_3,&
this.cb_1}
end on

on w_main_pix.destroy
destroy(this.cb_8)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event open;SQLCA.DBMS="ODBC"
SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"

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
	MessageBox("Not Logged In", "Login Failed!")
ELSE
	MESSAGEBOX("","LOGIN OK")
END IF


end event

event close;disCONNECT USING SQLCA;
end event

type cb_8 from commandbutton within w_main_pix
integer x = 183
integer y = 100
integer width = 1550
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Check verif exp cred flag w/2"
end type

event clicked;open(w_reset_exp_flag)
end event

type cb_3 from commandbutton within w_main_pix
integer x = 3022
integer y = 48
integer width = 274
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_main_pix
integer x = 3031
integer y = 176
integer width = 265
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Click a utility to run.")
end event

