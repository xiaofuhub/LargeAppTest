$PBExportHeader$w_ref_field_update.srw
forward
global type w_ref_field_update from window
end type
type st_1 from statictext within w_ref_field_update
end type
type dw_values from datawindow within w_ref_field_update
end type
type dw_table from datawindow within w_ref_field_update
end type
type cb_4 from commandbutton within w_ref_field_update
end type
type cb_3 from commandbutton within w_ref_field_update
end type
type gb_3 from groupbox within w_ref_field_update
end type
end forward

global type w_ref_field_update from window
integer x = 5
integer y = 48
integer width = 3730
integer height = 1060
boolean titlebar = true
string title = "sys field utility"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
st_1 st_1
dw_values dw_values
dw_table dw_table
cb_4 cb_4
cb_3 cb_3
gb_3 gb_3
end type
global w_ref_field_update w_ref_field_update

type variables
string is_field1
string is_field2
string is_field3
string is_table
string is_where
integer ii_screen = 0
end variables

on w_ref_field_update.create
this.st_1=create st_1
this.dw_values=create dw_values
this.dw_table=create dw_table
this.cb_4=create cb_4
this.cb_3=create cb_3
this.gb_3=create gb_3
this.Control[]={this.st_1,&
this.dw_values,&
this.dw_table,&
this.cb_4,&
this.cb_3,&
this.gb_3}
end on

on w_ref_field_update.destroy
destroy(this.st_1)
destroy(this.dw_values)
destroy(this.dw_table)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.gb_3)
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

dw_table.settransobject(sqlca)
dw_table.retrieve()
dw_table.insertrow(1)
end event

event close;//disCONNECT USING SQLCA;
end event

type st_1 from statictext within w_ref_field_update
integer x = 1253
integer y = 84
integer width = 2290
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217857
long backcolor = 33551856
string text = "It is recommended that this utility not be used without IntelliSoft support assistance."
boolean focusrectangle = false
end type

type dw_values from datawindow within w_ref_field_update
integer x = 46
integer y = 224
integer width = 3557
integer height = 560
integer taborder = 20
string dataobject = "d_sys_list_users"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;DataWindowChild dwchild

This.GetChild( "reference_field_1", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)

This.GetChild( "reference_field_2", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)

This.GetChild( "reference_field_3", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)

This.GetChild( "exp_field", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)






end event

type dw_table from datawindow within w_ref_field_update
integer x = 73
integer y = 84
integer width = 1088
integer height = 100
integer taborder = 60
string dataobject = "d_table_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;
integer r
integer t
string find
string ls_filt
datawindowchild dwchild

ii_screen = integer(data)

//messagebox("",ii_screen)

dw_values.settransobject(sqlca)
dw_values.retrieve(ii_screen)
//
find = "screen_id = " + data
debugbreak()
//messagebox("",find)
r = dw_table.find(find,1,dw_table.rowcount())
//messagebox("r",r)
is_table = dw_table.getitemstring(r,"sys_tables_table_name")

t = dw_table.getitemnumber(r,"sys_tables_table_id")

ls_filt = "sys_fields_table_id = " + string(t)

r = dw_values.GetChild( "reference_field_1", dwchild )
r = dwchild.setfilter(ls_filt)
r = dwchild.filter()
r = dw_values.GetChild( "reference_field_2", dwchild )
r = dwchild.setfilter(ls_filt)
r = dwchild.filter()
dwchild.insertrow(1)  //Start Code Change ----03.15.2011 #V11 maha - added blank
r = dw_values.GetChild( "reference_field_3", dwchild )
r = dwchild.setfilter(ls_filt)
r = dwchild.filter()
dwchild.insertrow(1)  //Start Code Change ----03.15.2011 #V11 maha - added blank
r = dw_values.GetChild( "exp_field", dwchild )
r = dwchild.setfilter(ls_filt)
r = dwchild.filter()
dwchild.insertrow(1)  //Start Code Change ----03.15.2011 #V11 maha - added blank



end event

event doubleclicked;//integer is_screen
//integer r
//string find
//
//
//is_screen = this.getitemnumber(row,"data_view_screen_screen_id")
//messagebox("",is_screen)
//dw_crit1.settransobject(sqlca)
////messagebox("crit1",is_screen)
//dw_crit1.retrieve(is_screen)
//
//dw_crit2.settransobject(sqlca)
////messagebox("crit2",is_screen)
//dw_crit2.retrieve(is_screen)
//
//dw_crit_update.settransobject(sqlca)
////messagebox("crit3",is_screen)
//dw_crit_update.retrieve(is_screen)
//
//
//is_table = this.getitemstring(row,"sys_tables_table_name")
//
//messagebox("",is_table)
//
//cb_find.enabled = true
end event

type cb_4 from commandbutton within w_ref_field_update
integer x = 3067
integer y = 800
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;if ii_screen = 0 then return //Start Code Change ----03.26.2008 #V8 maha - trap
dw_values.update()
commit using sqlca;
end event

type cb_3 from commandbutton within w_ref_field_update
integer x = 3328
integer y = 800
integer width = 274
integer height = 84
integer taborder = 40
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

type gb_3 from groupbox within w_ref_field_update
integer x = 50
integer y = 28
integer width = 1138
integer height = 172
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Data Screen"
end type

