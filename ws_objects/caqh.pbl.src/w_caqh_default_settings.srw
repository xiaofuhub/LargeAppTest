$PBExportHeader$w_caqh_default_settings.srw
forward
global type w_caqh_default_settings from window
end type
type dw_set from datawindow within w_caqh_default_settings
end type
type cb_2 from commandbutton within w_caqh_default_settings
end type
type cb_1 from commandbutton within w_caqh_default_settings
end type
end forward

global type w_caqh_default_settings from window
integer width = 2185
integer height = 752
boolean titlebar = true
string title = "CAQH Default Settings"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_set dw_set
cb_2 cb_2
cb_1 cb_1
end type
global w_caqh_default_settings w_caqh_default_settings

on w_caqh_default_settings.create
this.dw_set=create dw_set
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_set,&
this.cb_2,&
this.cb_1}
end on

on w_caqh_default_settings.destroy
destroy(this.dw_set)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;datawindowchild dwchild

dw_set.settransobject(sqlca)
//---------Begin Modified by (Appeon)Toney 11.20.2013 for V141 ISG-CLX--------
//$Reason:Fix history BugT082803,exchange the following two codes execution order 
dw_set.GetChild( "parent_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
dwchild.insertrow(1)

if dw_set.retrieve() = 0 then
	dw_set.insertrow(1)
	dw_set.setitem(1,"set_title",1)
	dw_set.setitem(1,"set_prov_id",1)
end if
//---------End Modfiied ------------------------------------------------------------------

dw_set.GetChild( "verify_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
dwchild.insertrow(1)

dw_set.GetChild( "template_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
dwchild.insertrow(1)

dw_set.GetChild( "affi_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
dwchild.insertrow(1)

if gs_cust_type = "I" then  //Start Code Change ----12.08.2010 #V10 maha _ change from IntelliApp
	dw_set.setitem(1,"parent_id",1)
	dw_set.setitem(1,"verify_id",1)
	dw_set.setitem(1,"template_id",1)
end if


end event

type dw_set from datawindow within w_caqh_default_settings
integer x = 55
integer y = 140
integer width = 2062
integer height = 416
integer taborder = 40
string title = "none"
string dataobject = "d_caqh_defaults"
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within w_caqh_default_settings
integer x = 1847
integer y = 32
integer width = 265
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

type cb_1 from commandbutton within w_caqh_default_settings
integer x = 1541
integer y = 32
integer width = 265
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_set.update()
end event

