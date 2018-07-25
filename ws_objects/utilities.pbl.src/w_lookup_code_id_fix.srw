$PBExportHeader$w_lookup_code_id_fix.srw
forward
global type w_lookup_code_id_fix from window
end type
type dw_1 from datawindow within w_lookup_code_id_fix
end type
type cb_4 from commandbutton within w_lookup_code_id_fix
end type
type cb_3 from commandbutton within w_lookup_code_id_fix
end type
type cb_2 from commandbutton within w_lookup_code_id_fix
end type
type cb_1 from commandbutton within w_lookup_code_id_fix
end type
end forward

global type w_lookup_code_id_fix from window
integer x = 123
integer y = 112
integer width = 914
integer height = 632
boolean titlebar = true
string title = "Reset group ids"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 80269524
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_lookup_code_id_fix w_lookup_code_id_fix

on w_lookup_code_id_fix.create
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_lookup_code_id_fix.destroy
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
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

type dw_1 from datawindow within w_lookup_code_id_fix
integer x = 1687
integer y = 308
integer width = 233
integer height = 160
integer taborder = 50
string dataobject = "d_group_recids"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_lookup_code_id_fix
integer x = 2199
integer y = 108
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;//if dw_1.rowcount() < 1 then
//	messagebox("","nothing to print")
//	return
//end if
//
//dw_1.print()
end event

type cb_3 from commandbutton within w_lookup_code_id_fix
integer x = 1093
integer y = 76
integer width = 274
integer height = 84
integer taborder = 30
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

type cb_2 from commandbutton within w_lookup_code_id_fix
integer x = 114
integer y = 148
integer width = 503
integer height = 144
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run"
end type

event clicked;long cid
long aid
long lcid

Select max(lookup_code) into :aid from address_lookup;
Select max(lookup_code) into :cid from code_lookup;
Select lookup_code_id into :lcid from ids;

if aid + 1 > lcid then
	lcid = aid + 1
	messagebox("","Reset for address_lookup")
	update ids set lookup_code_id = :lcid;
end if

if cid + 1 > lcid then
	lcid = cid + 1
	messagebox("","Reset for code_lookup")
	update ids set lookup_code_id = :lcid;
end if


	





messagebox("","Complete") //,question!,yesnocancel!,1)

close(parent)
end event

type cb_1 from commandbutton within w_lookup_code_id_fix
integer x = 1641
integer y = 200
integer width = 265
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Select a record type. Click run.  You will get a list of expiring records from 30 days in the future for active records.")
end event

