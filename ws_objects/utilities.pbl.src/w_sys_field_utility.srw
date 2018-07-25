$PBExportHeader$w_sys_field_utility.srw
forward
global type w_sys_field_utility from window
end type
type st_2 from statictext within w_sys_field_utility
end type
type st_1 from statictext within w_sys_field_utility
end type
type cb_2 from commandbutton within w_sys_field_utility
end type
type dw_values from datawindow within w_sys_field_utility
end type
type dw_crit1 from datawindow within w_sys_field_utility
end type
type dw_table from datawindow within w_sys_field_utility
end type
type cb_4 from commandbutton within w_sys_field_utility
end type
type cb_3 from commandbutton within w_sys_field_utility
end type
type cb_1 from commandbutton within w_sys_field_utility
end type
type gb_3 from groupbox within w_sys_field_utility
end type
end forward

global type w_sys_field_utility from window
integer x = 5
integer y = 48
integer width = 3685
integer height = 2240
boolean titlebar = true
string title = "Data view field - sys field utility"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
st_2 st_2
st_1 st_1
cb_2 cb_2
dw_values dw_values
dw_crit1 dw_crit1
dw_table dw_table
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
gb_3 gb_3
end type
global w_sys_field_utility w_sys_field_utility

type variables
string is_field1
string is_field2
string is_field3
string is_table
string is_where
end variables

on w_sys_field_utility.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.dw_values=create dw_values
this.dw_crit1=create dw_crit1
this.dw_table=create dw_table
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.gb_3=create gb_3
this.Control[]={this.st_2,&
this.st_1,&
this.cb_2,&
this.dw_values,&
this.dw_crit1,&
this.dw_table,&
this.cb_4,&
this.cb_3,&
this.cb_1,&
this.gb_3}
end on

on w_sys_field_utility.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.dw_values)
destroy(this.dw_crit1)
destroy(this.dw_table)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
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

type st_2 from statictext within w_sys_field_utility
integer x = 50
integer y = 888
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Sys fields"
boolean focusrectangle = false
end type

type st_1 from statictext within w_sys_field_utility
integer x = 78
integer y = 228
integer width = 398
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Data View Fields"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_sys_field_utility
integer x = 2066
integer y = 72
integer width = 667
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update a Dataview field"
end type

event clicked;open(w_dataview_field_update)
end event

type dw_values from datawindow within w_sys_field_utility
integer x = 46
integer y = 296
integer width = 3557
integer height = 560
integer taborder = 20
string dataobject = "d_sys_list"
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

type dw_crit1 from datawindow within w_sys_field_utility
integer x = 46
integer y = 952
integer width = 3557
integer height = 1076
integer taborder = 10
string dataobject = "d_sys_field_list"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;integer r

r = this.getclickedrow()
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

event rowfocuschanged;//if this.getitemstring(currentrow,"lookup_field") = "Y" then
//	dw_v1.visible = true
//	sle_value1.visible = false
//	if this.getitemstring(currentrow,"lookup_type") = "C" then
//		dw_v1.dataobject = "d_code_lookup"
//		dw_v1.settransobject(sqlca)
//		dw_v1.retrieve(this.getitemstring(currentrow,"lookup_code"))
//	end if
//else
//	dw_v1.visible = false
//	sle_value1.visible = true
//end if
end event

type dw_table from datawindow within w_sys_field_utility
integer x = 73
integer y = 84
integer width = 1088
integer height = 100
integer taborder = 60
string dataobject = "d_table_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;integer ii_screen
integer r
integer t
string find
string ls_filt
datawindowchild dwchild

ii_screen = integer(data)

//messagebox("",ii_screen)
dw_crit1.settransobject(sqlca)
dw_crit1.retrieve(ii_screen)
dw_values.settransobject(sqlca)
dw_values.retrieve(ii_screen)
//
find = "screen_id = " + data
debugbreak()
//messagebox("",find)
r = dw_table.find(find,1,dw_table.rowcount())
//messagebox("r",r)
is_table = dw_table.getitemstring(r,"sys_tables_table_name")
//Start Code Change ---- 03.31.2006 #374 maha
t = dw_table.getitemnumber(r,"sys_tables_table_id")
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
r = dw_values.GetChild( "reference_field_3", dwchild )
r = dwchild.setfilter(ls_filt)
r = dwchild.filter()
dwchild.insertrow(1)
r = dw_values.GetChild( "exp_field", dwchild )
r = dwchild.setfilter(ls_filt)
r = dwchild.filter()
dwchild.insertrow(1)
//End Code Change---03.31.2006



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

type cb_4 from commandbutton within w_sys_field_utility
integer x = 2761
integer y = 72
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

event clicked;dw_crit1.update()
dw_values.update()
commit using sqlca;
end event

type cb_3 from commandbutton within w_sys_field_utility
integer x = 3319
integer y = 72
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

type cb_1 from commandbutton within w_sys_field_utility
integer x = 3031
integer y = 72
integer width = 265
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Select a Screen. Adjust field type")
end event

type gb_3 from groupbox within w_sys_field_utility
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

