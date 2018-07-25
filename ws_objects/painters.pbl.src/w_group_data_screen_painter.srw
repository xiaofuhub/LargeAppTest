$PBExportHeader$w_group_data_screen_painter.srw
forward
global type w_group_data_screen_painter from window
end type
type cb_about from commandbutton within w_group_data_screen_painter
end type
type dw_table from datawindow within w_group_data_screen_painter
end type
type cb_close from commandbutton within w_group_data_screen_painter
end type
type cb_save from commandbutton within w_group_data_screen_painter
end type
type dw_fields from datawindow within w_group_data_screen_painter
end type
type gb_3 from groupbox within w_group_data_screen_painter
end type
end forward

global type w_group_data_screen_painter from window
integer x = 1189
integer y = 556
integer width = 2194
integer height = 2416
boolean titlebar = true
string title = "Group Data Label Setup"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_about cb_about
dw_table dw_table
cb_close cb_close
cb_save cb_save
dw_fields dw_fields
gb_3 gb_3
end type
global w_group_data_screen_painter w_group_data_screen_painter

event open;dw_table.settransobject(sqlca)
dw_table.retrieve()
dw_table.insertrow(1)

dw_fields.settransobject(sqlca)
end event

on w_group_data_screen_painter.create
this.cb_about=create cb_about
this.dw_table=create dw_table
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_fields=create dw_fields
this.gb_3=create gb_3
this.Control[]={this.cb_about,&
this.dw_table,&
this.cb_close,&
this.cb_save,&
this.dw_fields,&
this.gb_3}
end on

on w_group_data_screen_painter.destroy
destroy(this.cb_about)
destroy(this.dw_table)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_fields)
destroy(this.gb_3)
end on

type cb_about from commandbutton within w_group_data_screen_painter
integer x = 1650
integer y = 36
integer width = 247
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked; messagebox("About","This utility is a painter for the Group Location Data screen detail field labels.  Visiblility can also be set on those fields. ")
end event

type dw_table from datawindow within w_group_data_screen_painter
integer x = 59
integer y = 72
integer width = 1074
integer height = 80
integer taborder = 40
string dataobject = "d_group_table_list"
boolean border = false
boolean livescroll = true
end type

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

event itemchanged;integer li_table
integer r
integer t
string find
string ls_filt
datawindowchild dwchild

li_table = integer(data)

dw_fields.retrieve(li_table)



end event

type cb_close from commandbutton within w_group_data_screen_painter
integer x = 1920
integer y = 36
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_group_data_screen_painter
integer x = 1390
integer y = 36
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_fields.update()
end event

type dw_fields from datawindow within w_group_data_screen_painter
integer y = 200
integer width = 2171
integer height = 2124
integer taborder = 10
string dataobject = "d_group_data_painter"
boolean vscrollbar = true
end type

type gb_3 from groupbox within w_group_data_screen_painter
integer x = 27
integer y = 4
integer width = 1138
integer height = 172
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Data Screen"
end type

