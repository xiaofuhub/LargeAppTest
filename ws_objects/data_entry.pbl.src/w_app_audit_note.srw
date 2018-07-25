$PBExportHeader$w_app_audit_note.srw
forward
global type w_app_audit_note from window
end type
type cb_2 from commandbutton within w_app_audit_note
end type
type cb_1 from commandbutton within w_app_audit_note
end type
type dw_1 from datawindow within w_app_audit_note
end type
end forward

global type w_app_audit_note from window
integer width = 3227
integer height = 1188
boolean titlebar = true
string title = "Expanded Notes"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12639424
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_app_audit_note w_app_audit_note

on w_app_audit_note.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_app_audit_note.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;//Start Code Change ---- 10.03.2006 #623 maha
// window created 10.03.06 maha
long ll_rec

ll_rec = message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_rec)
end event

type cb_2 from commandbutton within w_app_audit_note
integer x = 2839
integer y = 900
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_1 from commandbutton within w_app_audit_note
integer x = 2464
integer y = 900
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;dw_1.update()

closewithreturn(parent,"OK")
end event

type dw_1 from datawindow within w_app_audit_note
integer x = 27
integer y = 20
integer width = 3159
integer height = 836
integer taborder = 10
string title = "none"
string dataobject = "d_pd_app_audit_note"
boolean livescroll = true
end type

