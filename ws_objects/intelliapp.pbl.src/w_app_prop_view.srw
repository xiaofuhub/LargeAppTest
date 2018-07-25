$PBExportHeader$w_app_prop_view.srw
forward
global type w_app_prop_view from window
end type
type dw_prop from datawindow within w_app_prop_view
end type
type cb_close from commandbutton within w_app_prop_view
end type
end forward

global type w_app_prop_view from window
integer width = 1714
integer height = 2664
boolean titlebar = true
string title = "View Field Properties"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_prop dw_prop
cb_close cb_close
end type
global w_app_prop_view w_app_prop_view

on w_app_prop_view.create
this.dw_prop=create dw_prop
this.cb_close=create cb_close
this.Control[]={this.dw_prop,&
this.cb_close}
end on

on w_app_prop_view.destroy
destroy(this.dw_prop)
destroy(this.cb_close)
end on

event open;long ll_afp_id

ll_afp_id = message.doubleparm

dw_prop.settransobject(sqlca)
dw_prop.retrieve(ll_afp_id )
dw_prop.Modify("datawindow.readonly=yes") //Add by Evan 04.14.2009

//BEGIN---Add by Evan 12/09/2008
long ll_Row
long ll_table_id
DataWindowChild ldwc_child
ll_Row = dw_prop.GetRow()
if ll_Row > 0 then	
	ll_table_id = dw_prop.object.table_id[ll_Row]
	if not IsNull(ll_table_id) then
		dw_prop.GetChild("field_id", ldwc_child)
		ldwc_child.SetTransObject(SQLCA)
		ldwc_child.Retrieve(ll_table_id)
	end if
end if
//END---Add by Evan 12/09/2008
end event

type dw_prop from datawindow within w_app_prop_view
integer y = 136
integer width = 1687
integer height = 2436
integer taborder = 20
string title = "none"
string dataobject = "d_app_field_properties_view"
boolean livescroll = true
end type

type cb_close from commandbutton within w_app_prop_view
integer x = 1339
integer y = 24
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

