$PBExportHeader$w_tab_order_by_position.srw
forward
global type w_tab_order_by_position from window
end type
type cb_run from commandbutton within w_tab_order_by_position
end type
type dw_dataviews from datawindow within w_tab_order_by_position
end type
type dw_fields from datawindow within w_tab_order_by_position
end type
type dw_screens from datawindow within w_tab_order_by_position
end type
type dw_1 from datawindow within w_tab_order_by_position
end type
type cb_4 from commandbutton within w_tab_order_by_position
end type
type cb_3 from commandbutton within w_tab_order_by_position
end type
type cb_1 from commandbutton within w_tab_order_by_position
end type
end forward

global type w_tab_order_by_position from window
integer x = 123
integer y = 112
integer width = 1733
integer height = 1460
boolean titlebar = true
string title = "Reset group ids"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_run cb_run
dw_dataviews dw_dataviews
dw_fields dw_fields
dw_screens dw_screens
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
end type
global w_tab_order_by_position w_tab_order_by_position

type variables
long il_openfor
end variables

on w_tab_order_by_position.create
this.cb_run=create cb_run
this.dw_dataviews=create dw_dataviews
this.dw_fields=create dw_fields
this.dw_screens=create dw_screens
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_run,&
this.dw_dataviews,&
this.dw_fields,&
this.dw_screens,&
this.dw_1,&
this.cb_4,&
this.cb_3,&
this.cb_1}
end on

on w_tab_order_by_position.destroy
destroy(this.cb_run)
destroy(this.dw_dataviews)
destroy(this.dw_fields)
destroy(this.dw_screens)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event open;long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows

if message.stringparm = "P" then  //from the intellicred program
	//skip login
	il_openfor = 0
else
	
	SQLCA.DBMS="ODBC"
	SQLCA.DbParm="ConnectString='DSN=Iapp;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"
	
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
		//MESSAGEBOX("","LOGIN OK")
	END IF
	il_openfor = 1
	
end if

//	dw_1.settransobject(sqlca)
//	dw_1.Retrieve()
end event

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type cb_run from commandbutton within w_tab_order_by_position
integer x = 869
integer y = 36
integer width = 503
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;integer res

integer v
integer vc
integer f
integer fc
integer s
integer sc
integer nr
integer nc
//integer res
long ll_commid
long ll_ord
long ll_was
integer li_screen
integer dvid
datetime ldt_date

//dw_dataviews.settransobject(sqlca)
dw_screens.settransobject(sqlca)
dw_fields.settransobject(sqlca)
sc = dw_screens.retrieve()
debugbreak()
	 
for s = 1 to sc
	dvid = dw_screens.getitemnumber(s,"data_view_id")
	li_screen = dw_screens.getitemnumber(s,"screen_id")
	fc = dw_fields.retrieve(dvid,li_screen) //fields sorted by visible, y pos, xpos
	for f = 1 to  fc
		ll_was = dw_fields.getitemnumber(f,"field_order")	
		ll_ord = f * 10
		//messagebox("ll_ord",ll_ord)
		dw_fields.setitem(f,"field_order",ll_ord)	
	next
	//messagebox("Done",li_screen)
	dw_fields.update()
	commit using sqlca;
next

			



messagebox("Done"," Update Completed")






end event

type dw_dataviews from datawindow within w_tab_order_by_position
boolean visible = false
integer x = 837
integer y = 1192
integer width = 265
integer height = 64
integer taborder = 10
string dataobject = "d_comm_of_facil"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fields from datawindow within w_tab_order_by_position
integer x = 55
integer y = 144
integer width = 1600
integer height = 988
integer taborder = 20
string dataobject = "d_utl_tab_set_fields"
boolean livescroll = true
end type

type dw_screens from datawindow within w_tab_order_by_position
boolean visible = false
integer x = 1129
integer y = 1196
integer width = 279
integer height = 60
integer taborder = 30
string dataobject = "d_utl_tab_set_screens"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_tab_order_by_position
boolean visible = false
integer x = 599
integer y = 1192
integer width = 215
integer height = 68
integer taborder = 80
string dataobject = "d_group_recids"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_tab_order_by_position
integer x = 2199
integer y = 108
integer width = 247
integer height = 108
integer taborder = 40
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

type cb_3 from commandbutton within w_tab_order_by_position
integer x = 1385
integer y = 36
integer width = 274
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_tab_order_by_position
boolean visible = false
integer x = 1381
integer y = 160
integer width = 265
integer height = 72
integer taborder = 70
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

