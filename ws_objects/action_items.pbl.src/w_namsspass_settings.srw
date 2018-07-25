$PBExportHeader$w_namsspass_settings.srw
forward
global type w_namsspass_settings from window
end type
type cb_add_l from commandbutton within w_namsspass_settings
end type
type cb_delete_l from commandbutton within w_namsspass_settings
end type
type cb_save from commandbutton within w_namsspass_settings
end type
type cb_add_u from commandbutton within w_namsspass_settings
end type
type dw_vendor from datawindow within w_namsspass_settings
end type
type dw_add from datawindow within w_namsspass_settings
end type
type dw_letter from datawindow within w_namsspass_settings
end type
type dw_user from datawindow within w_namsspass_settings
end type
type st_3 from statictext within w_namsspass_settings
end type
type st_2 from statictext within w_namsspass_settings
end type
type st_1 from statictext within w_namsspass_settings
end type
type cb_close from commandbutton within w_namsspass_settings
end type
end forward

global type w_namsspass_settings from window
integer width = 2807
integer height = 1816
boolean titlebar = true
string title = "NAMSS PASS Settings"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_add_l cb_add_l
cb_delete_l cb_delete_l
cb_save cb_save
cb_add_u cb_add_u
dw_vendor dw_vendor
dw_add dw_add
dw_letter dw_letter
dw_user dw_user
st_3 st_3
st_2 st_2
st_1 st_1
cb_close cb_close
end type
global w_namsspass_settings w_namsspass_settings

on w_namsspass_settings.create
this.cb_add_l=create cb_add_l
this.cb_delete_l=create cb_delete_l
this.cb_save=create cb_save
this.cb_add_u=create cb_add_u
this.dw_vendor=create dw_vendor
this.dw_add=create dw_add
this.dw_letter=create dw_letter
this.dw_user=create dw_user
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_close=create cb_close
this.Control[]={this.cb_add_l,&
this.cb_delete_l,&
this.cb_save,&
this.cb_add_u,&
this.dw_vendor,&
this.dw_add,&
this.dw_letter,&
this.dw_user,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_close}
end on

on w_namsspass_settings.destroy
destroy(this.cb_add_l)
destroy(this.cb_delete_l)
destroy(this.cb_save)
destroy(this.cb_add_u)
destroy(this.dw_vendor)
destroy(this.dw_add)
destroy(this.dw_letter)
destroy(this.dw_user)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_close)
end on

event open;//Start Code Change ----08.29.2013 #V14 maha - created

dw_vendor.settransobject(sqlca)
dw_letter.settransobject(sqlca)
dw_user.settransobject(sqlca)

dw_vendor.retrieve()
dw_letter.retrieve()
dw_user.retrieve()



end event

type cb_add_l from commandbutton within w_namsspass_settings
integer x = 1275
integer y = 816
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;dw_letter.insertrow(0)
end event

type cb_delete_l from commandbutton within w_namsspass_settings
integer x = 1627
integer y = 816
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Delete"
end type

type cb_save from commandbutton within w_namsspass_settings
integer x = 1952
integer y = 28
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_letter.update()

if dw_add.rowcount() > 0 then
	dw_add.update()
	dw_add.visible = false
	dw_user.retrieve()
end if
end event

type cb_add_u from commandbutton within w_namsspass_settings
integer x = 1275
integer y = 228
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;string ls_user

open(w_select_user)

ls_user = message.stringparm

if ls_user = "Cancel" then 
	return
else
	dw_add.visible = true
	dw_add.settransobject(sqlca)
	dw_add.retrieve(ls_user)
	dw_add.setfocus()
end if
end event

type dw_vendor from datawindow within w_namsspass_settings
integer x = 50
integer y = 88
integer width = 1211
integer height = 84
integer taborder = 20
string title = "none"
string dataobject = "d_namsspass_vendor"
boolean border = false
boolean livescroll = true
end type

type dw_add from datawindow within w_namsspass_settings
boolean visible = false
integer x = 50
integer y = 1456
integer width = 2592
integer height = 232
integer taborder = 40
string title = "none"
string dataobject = "d_namsspass_user_add"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_letter from datawindow within w_namsspass_settings
integer x = 50
integer y = 912
integer width = 2610
integer height = 448
integer taborder = 30
string title = "none"
string dataobject = "d_namsspass_letter_ids"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_user from datawindow within w_namsspass_settings
integer x = 50
integer y = 324
integer width = 2651
integer height = 432
integer taborder = 20
string title = "none"
string dataobject = "d_namsspass_users"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_namsspass_settings
integer x = 50
integer y = 828
integer width = 626
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "NAMSS PASS letter ids"
boolean focusrectangle = false
end type

type st_2 from statictext within w_namsspass_settings
integer x = 50
integer y = 20
integer width = 763
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "ISG NAMSS PASS Vendor Id"
boolean focusrectangle = false
end type

type st_1 from statictext within w_namsspass_settings
integer x = 50
integer y = 228
integer width = 599
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "NAMSS PASS user ids"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_namsspass_settings
integer x = 2359
integer y = 28
integer width = 343
integer height = 100
integer taborder = 10
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

