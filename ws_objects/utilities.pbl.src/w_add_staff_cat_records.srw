$PBExportHeader$w_add_staff_cat_records.srw
forward
global type w_add_staff_cat_records from window
end type
type dw_2 from datawindow within w_add_staff_cat_records
end type
type dw_1 from datawindow within w_add_staff_cat_records
end type
type cb_4 from commandbutton within w_add_staff_cat_records
end type
type cb_3 from commandbutton within w_add_staff_cat_records
end type
type cb_2 from commandbutton within w_add_staff_cat_records
end type
type cb_1 from commandbutton within w_add_staff_cat_records
end type
end forward

global type w_add_staff_cat_records from window
integer x = 123
integer y = 112
integer width = 2048
integer height = 800
boolean titlebar = true
string title = "Add Staff Category Records"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
dw_2 dw_2
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_add_staff_cat_records w_add_staff_cat_records

on w_add_staff_cat_records.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_2,&
this.dw_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_add_staff_cat_records.destroy
destroy(this.dw_2)
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

dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

event close;disCONNECT USING SQLCA;
end event

type dw_2 from datawindow within w_add_staff_cat_records
integer x = 731
integer y = 68
integer width = 494
integer height = 360
integer taborder = 50
string dataobject = "d_staff_cat_util"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_add_staff_cat_records
integer x = 91
integer y = 48
integer width = 494
integer height = 360
integer taborder = 50
string dataobject = "d_affil_stat_of_prac_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_add_staff_cat_records
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

type cb_3 from commandbutton within w_add_staff_cat_records
integer x = 1632
integer y = 72
integer width = 274
integer height = 108
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

type cb_2 from commandbutton within w_add_staff_cat_records
integer x = 1349
integer y = 72
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run"
end type

event clicked;integer i
integer ic
long prac
long fac
Long ll_seq_no
long rec
long nr

dw_2.settransobject(sqlca)

for i = 1 to dw_1.rowcount()
	rec = dw_1.getitemnumber(i,"rec_id")
	fac = dw_1.getitemnumber(i,"parent_facility_id")
	prac = dw_1.getitemnumber(i,"prac_id")
	ll_seq_no = dw_1.getitemnumber(i,"seq_no")
	nr = dw_2.insertrow(0)
	dw_2.setitem(nr,"rec_id", rec)
	dw_2.setitem(nr,"facility_id",fac)
	dw_2.setitem(nr,"prac_id",prac)
	dw_2.setitem(nr,"seq_no",ll_seq_no)
	dw_2.setitem(nr,"staff_category",645)
	dw_2.setitem(nr,"active_status",1)
	
next

dw_2.update()
commit using sqlca;
messagebox("","Done")
end event

type cb_1 from commandbutton within w_add_staff_cat_records
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

