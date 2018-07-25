$PBExportHeader$w_sys_table_utility.srw
forward
global type w_sys_table_utility from window
end type
type dw_values from datawindow within w_sys_table_utility
end type
type dw_1 from datawindow within w_sys_table_utility
end type
type cb_4 from commandbutton within w_sys_table_utility
end type
type cb_3 from commandbutton within w_sys_table_utility
end type
end forward

global type w_sys_table_utility from window
integer x = 78
integer y = 64
integer width = 3557
integer height = 2120
boolean titlebar = true
string title = "sys field utility"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
dw_values dw_values
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
end type
global w_sys_table_utility w_sys_table_utility

type variables
string is_field1
string is_field2
string is_field3
string is_table
string is_where
end variables

on w_sys_table_utility.create
this.dw_values=create dw_values
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.Control[]={this.dw_values,&
this.dw_1,&
this.cb_4,&
this.cb_3}
end on

on w_sys_table_utility.destroy
destroy(this.dw_values)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	MESSAGEBOX("","LOGIN OK")
//END IF
//
dw_1.settransobject(sqlca)
dw_1.retrieve()


end event

event close;//disCONNECT USING SQLCA;
end event

type dw_values from datawindow within w_sys_table_utility
integer x = 32
integer y = 1620
integer width = 3419
integer height = 360
integer taborder = 40
string title = "none"
string dataobject = "d_sys_table_util_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_sys_table_utility
integer x = 41
integer y = 140
integer width = 3415
integer height = 1456
integer taborder = 30
string dataobject = "d_sys_table_util"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;integer li_table
integer r
integer t
string find
string ls_filt
datawindowchild dwchild

//messagebox("",ii_screen)

t = this.getitemnumber(currentrow,"sys_tables_table_id")
dw_values.settransobject(sqlca)
dw_values.retrieve(t)

//table = dw_table.getitemstring(r,"sys_tables_table_name")
//Start Code Change ---- 03.31.2006 #374 maha

//messagebox("",t)
ls_filt = "sys_fields_table_id = " + string(t)

r = dw_values.GetChild( "reference_field_1", dwchild )
r = dwchild.setfilter(ls_filt)
r = dwchild.filter()
dwchild.insertrow(1)  //Start Code Change ----03.15.2011 #V11 maha - added blank
r = dw_values.GetChild( "reference_field_2", dwchild )
r = dwchild.setfilter(ls_filt)
r = dwchild.filter()
dwchild.insertrow(1)




end event

event clicked;integer r

r = this.getclickedrow()
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

type cb_4 from commandbutton within w_sys_table_utility
integer x = 2898
integer y = 28
integer width = 247
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_values.update()
commit using sqlca;
end event

type cb_3 from commandbutton within w_sys_table_utility
integer x = 3186
integer y = 28
integer width = 274
integer height = 88
integer taborder = 20
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

