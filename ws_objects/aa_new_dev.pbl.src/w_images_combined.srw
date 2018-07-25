$PBExportHeader$w_images_combined.srw
forward
global type w_images_combined from window
end type
type dw_images from datawindow within w_images_combined
end type
type cb_close from commandbutton within w_images_combined
end type
type cb_1 from commandbutton within w_images_combined
end type
end forward

global type w_images_combined from window
integer width = 4160
integer height = 2224
boolean titlebar = true
string title = "Combined Document and Verification Images"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_images dw_images
cb_close cb_close
cb_1 cb_1
end type
global w_images_combined w_images_combined

event open;long ll_prac


ll_prac = message.doubleparm
dw_images.settransobject(sqlca)
dw_images.retrieve(ll_prac)
end event

on w_images_combined.create
this.dw_images=create dw_images
this.cb_close=create cb_close
this.cb_1=create cb_1
this.Control[]={this.dw_images,&
this.cb_close,&
this.cb_1}
end on

on w_images_combined.destroy
destroy(this.dw_images)
destroy(this.cb_close)
destroy(this.cb_1)
end on

type dw_images from datawindow within w_images_combined
integer x = 32
integer y = 28
integer width = 3982
integer height = 1940
integer taborder = 10
string title = "none"
string dataobject = "d_images_for_prac_w_verifs"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;datawindowchild ldw_child
integer li_success


li_success = dw_images.getchild('pd_images_facility_id',ldw_child)
IF li_success = 1 THEN
      ldw_child.settransobject(SQLCA)
	 ldw_child.retrieve(gs_user_id) 
	 ldw_child.insertrow(1)
	 ldw_child.setitem(1,'facility_id',0)
	 ldw_child.setitem(1,'facility_name','ALL')
END IF
end event

type cb_close from commandbutton within w_images_combined
integer x = 1792
integer y = 2004
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

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_images_combined
integer x = 649
integer y = 1996
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

