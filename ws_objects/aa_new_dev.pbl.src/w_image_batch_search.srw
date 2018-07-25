$PBExportHeader$w_image_batch_search.srw
forward
global type w_image_batch_search from window
end type
type st_3 from statictext within w_image_batch_search
end type
type dw_table from datawindow within w_image_batch_search
end type
type st_2 from statictext within w_image_batch_search
end type
type dw_date_range from u_dw within w_image_batch_search
end type
type st_1 from statictext within w_image_batch_search
end type
type cb_go from commandbutton within w_image_batch_search
end type
type cb_close from commandbutton within w_image_batch_search
end type
type dw_type from datawindow within w_image_batch_search
end type
type dw_results from datawindow within w_image_batch_search
end type
type dw_facility from datawindow within w_image_batch_search
end type
end forward

global type w_image_batch_search from window
integer width = 3753
integer height = 2676
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_3 st_3
dw_table dw_table
st_2 st_2
dw_date_range dw_date_range
st_1 st_1
cb_go cb_go
cb_close cb_close
dw_type dw_type
dw_results dw_results
dw_facility dw_facility
end type
global w_image_batch_search w_image_batch_search

type variables
integer ii_screen
datetime idt_from
datetime idt_to
end variables

on w_image_batch_search.create
this.st_3=create st_3
this.dw_table=create dw_table
this.st_2=create st_2
this.dw_date_range=create dw_date_range
this.st_1=create st_1
this.cb_go=create cb_go
this.cb_close=create cb_close
this.dw_type=create dw_type
this.dw_results=create dw_results
this.dw_facility=create dw_facility
this.Control[]={this.st_3,&
this.dw_table,&
this.st_2,&
this.dw_date_range,&
this.st_1,&
this.cb_go,&
this.cb_close,&
this.dw_type,&
this.dw_results,&
this.dw_facility}
end on

on w_image_batch_search.destroy
destroy(this.st_3)
destroy(this.dw_table)
destroy(this.st_2)
destroy(this.dw_date_range)
destroy(this.st_1)
destroy(this.cb_go)
destroy(this.cb_close)
destroy(this.dw_type)
destroy(this.dw_results)
destroy(this.dw_facility)
end on

type st_3 from statictext within w_image_batch_search
integer x = 55
integer y = 112
integer width = 352
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Screen"
boolean focusrectangle = false
end type

type dw_table from datawindow within w_image_batch_search
integer x = 498
integer y = 116
integer width = 1088
integer height = 92
integer taborder = 40
string dataobject = "d_table_list"
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

event itemchanged;
integer r
string find
datawindowchild dwchild

ii_screen = integer(data)

end event

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type st_2 from statictext within w_image_batch_search
integer x = 55
integer y = 200
integer width = 416
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Facility"
boolean focusrectangle = false
end type

type dw_date_range from u_dw within w_image_batch_search
integer x = 1705
integer y = 28
integer width = 960
integer height = 172
integer taborder = 10
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

event itemchanged;call super::itemchanged;
if dwo.name = "from_date" then
	idt_from = datetime(date(data), time("00:00:00"))
elseif dwo.name = "to_date" then
	idt_to = datetime(date(data), time("23:59:59"))
end if
end event

type st_1 from statictext within w_image_batch_search
integer x = 55
integer y = 20
integer width = 416
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Image Type"
boolean focusrectangle = false
end type

type cb_go from commandbutton within w_image_batch_search
integer x = 3017
integer y = 76
integer width = 265
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go"
end type

type cb_close from commandbutton within w_image_batch_search
integer x = 3351
integer y = 80
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type dw_type from datawindow within w_image_batch_search
integer x = 498
integer y = 20
integer width = 901
integer height = 80
integer taborder = 30
string title = "none"
string dataobject = "d_image_type_for_dddw"
boolean border = false
boolean livescroll = true
end type

type dw_results from datawindow within w_image_batch_search
integer x = 78
integer y = 296
integer width = 3575
integer height = 2224
integer taborder = 20
string title = "none"
string dataobject = "d_image_list_search_results"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_facility from datawindow within w_image_batch_search
integer x = 498
integer y = 208
integer width = 1006
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_facility_select"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve(gs_user_id)
end event

