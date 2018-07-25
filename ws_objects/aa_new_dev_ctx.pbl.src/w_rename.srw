$PBExportHeader$w_rename.srw
forward
global type w_rename from w_response
end type
type cb_cancel from commandbutton within w_rename
end type
type cb_ok from commandbutton within w_rename
end type
type sle_newname from singlelineedit within w_rename
end type
type st_newname from statictext within w_rename
end type
end forward

global type w_rename from w_response
integer x = 214
integer y = 221
integer width = 1568
integer height = 432
string title = "Rename"
cb_cancel cb_cancel
cb_ok cb_ok
sle_newname sle_newname
st_newname st_newname
end type
global w_rename w_rename

on w_rename.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_newname=create sle_newname
this.st_newname=create st_newname
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.sle_newname
this.Control[iCurrent+4]=this.st_newname
end on

on w_rename.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_newname)
destroy(this.st_newname)
end on

event open;call super::open;String	ls_OldName

ls_OldName = Message.StringParm

sle_NewName.Text = ls_OldName
sle_NewName.SelectText(1,Len(sle_NewName.Text))

end event

type cb_cancel from commandbutton within w_rename
integer x = 1166
integer y = 216
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

event clicked;CloseWithReturn(Parent,"")

end event

type cb_ok from commandbutton within w_rename
integer x = 795
integer y = 216
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&OK"
boolean default = true
end type

event clicked;String	ls_NewName

ls_NewName = sle_NewName.Text

CloseWithReturn(Parent,ls_NewName)

end event

type sle_newname from singlelineedit within w_rename
event ue_enchange pbm_enchange
integer x = 384
integer y = 44
integer width = 1120
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_enchange;if This.Text = "" then
	cb_OK.Enabled = false
else
	cb_OK.Enabled = true
end if

end event

type st_newname from statictext within w_rename
integer x = 50
integer y = 60
integer width = 302
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "&New name:"
boolean focusrectangle = false
end type

