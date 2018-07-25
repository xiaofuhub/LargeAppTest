$PBExportHeader$w_set_required_screens.srw
forward
global type w_set_required_screens from window
end type
type cb_close from commandbutton within w_set_required_screens
end type
type cb_save from commandbutton within w_set_required_screens
end type
type st_1 from statictext within w_set_required_screens
end type
type dw_views from datawindow within w_set_required_screens
end type
type dw_select from u_dw within w_set_required_screens
end type
end forward

global type w_set_required_screens from window
integer width = 1435
integer height = 2108
boolean titlebar = true
string title = "Set Required Webview Screens"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_save cb_save
st_1 st_1
dw_views dw_views
dw_select dw_select
end type
global w_set_required_screens w_set_required_screens

type variables
integer  ii_data_view_id
end variables

on w_set_required_screens.create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.st_1=create st_1
this.dw_views=create dw_views
this.dw_select=create dw_select
this.Control[]={this.cb_close,&
this.cb_save,&
this.st_1,&
this.dw_views,&
this.dw_select}
end on

on w_set_required_screens.destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.st_1)
destroy(this.dw_views)
destroy(this.dw_select)
end on

event open;long i
integer li_view
string s
DataWindowChild dwchild


dwchild.retrieve()
dwchild.insertrow(1)
//debugbreak()
li_view = message.doubleparm

dw_select.setitem(1,"data_view_id",li_view)
dw_views.retrieve(li_view)
end event

type cb_close from commandbutton within w_set_required_screens
integer x = 878
integer y = 1904
integer width = 343
integer height = 92
integer taborder = 30
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

type cb_save from commandbutton within w_set_required_screens
integer x = 517
integer y = 1904
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;integer i

for i = 1 to dw_views.rowcount()
	if isnull(dw_views.getitemnumber(i,"is_required")) then
		dw_views.setitem(i,"is_required",0)
	end if
	if dw_views.getitemnumber(i, "screen_id") = 1 then
		dw_views.setitem(i,"is_required",1)
	end if
next

dw_views.update()


end event

type st_1 from statictext within w_set_required_screens
integer x = 64
integer y = 12
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select View"
boolean focusrectangle = false
end type

type dw_views from datawindow within w_set_required_screens
integer x = 18
integer y = 220
integer width = 1394
integer height = 1668
integer taborder = 20
string title = "none"
string dataobject = "d_required_screens_selection"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event retrieveend;integer i

for i = 1 to rowcount
	if this.getitemnumber(i, "screen_id") = 1 then
		this.setitem(i,"is_required",1)
	end if
next
end event

type dw_select from u_dw within w_set_required_screens
integer x = 50
integer y = 80
integer width = 965
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.InsertRow( 0 )
This.SetItem( 1, "data_view_id", 1 )
This.SetRow( 1 )
This.ScrollToRow( 1 )

end event

event itemchanged;call super::itemchanged; ii_data_view_id = integer(data)

//of_retrieve_data_view( data )
dw_views.Retrieve( ii_data_view_id )
end event

