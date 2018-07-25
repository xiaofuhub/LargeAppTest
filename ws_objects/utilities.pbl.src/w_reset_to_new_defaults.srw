$PBExportHeader$w_reset_to_new_defaults.srw
forward
global type w_reset_to_new_defaults from window
end type
type dw_1 from datawindow within w_reset_to_new_defaults
end type
type cb_2 from commandbutton within w_reset_to_new_defaults
end type
type cb_1 from commandbutton within w_reset_to_new_defaults
end type
end forward

global type w_reset_to_new_defaults from window
integer width = 1440
integer height = 2720
boolean titlebar = true
string title = "Reset to New Settings"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_reset_to_new_defaults w_reset_to_new_defaults

on w_reset_to_new_defaults.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_reset_to_new_defaults.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_1 from datawindow within w_reset_to_new_defaults
integer x = 41
integer y = 180
integer width = 1312
integer height = 2352
integer taborder = 10
string title = "none"
string dataobject = "d_support_set"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cb_2 from commandbutton within w_reset_to_new_defaults
integer x = 594
integer y = 48
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset"
end type

event clicked;integer res
string s


res = messagebox("Setting reset","This utility will set program settings to new system defaults, including clearing the the license key.  Continue?",Question!,yesno!,2)

if res = 2 then return

setnull(s)
dw_1.setitem(1,"set_18", 91) //program version
dw_1.setitem(1,"set_product", 1)
dw_1.setitem(1,"set_9", 1) //intelliapp
dw_1.setitem(1,"image_storage_type", 1)
dw_1.setitem(1,"set_50", 1) //wrod storage
dw_1.setitem(1,"set_11", 0) //new screen painter
dw_1.setitem(1,"set_iapps", 0)
dw_1.setitem(1,"set_cont", 0)
dw_1.setitem(1,"set_51", 0) //cont doc create
dw_1.setitem(1,"set_48", 0) //cont global search
dw_1.setitem(1,"set_iauto", 0) //export
dw_1.setitem(1,"set_img", 0)
dw_1.setitem(1,"set_import", 0)
dw_1.setitem(1,"set_ireport", 0)
dw_1.setitem(1,"set_peer", 0)
dw_1.setitem(1,"set_priv", 0)
dw_1.setitem(1,"set_qa", 0)
dw_1.setitem(1,"set_site", 0)
dw_1.setitem(1,"web_crawl", 0)
dw_1.setitem(1,"set_web", 0)
dw_1.setitem(1,"set_47", 0) //workflow
dw_1.setitem(1,"set_dashb", 0)
dw_1.setitem(1,"license_info", s)

res = messagebox("Setting Reset","Complete changes?",Question!,yesno!,2)

if res = 2 then return

dw_1.update()
end event

type cb_1 from commandbutton within w_reset_to_new_defaults
integer x = 955
integer y = 48
integer width = 343
integer height = 92
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

