$PBExportHeader$w_get_profile_view_name.srw
forward
global type w_get_profile_view_name from window
end type
type cb_ok from commandbutton within w_get_profile_view_name
end type
type cb_cancel from commandbutton within w_get_profile_view_name
end type
type st_1 from statictext within w_get_profile_view_name
end type
type sle_1 from singlelineedit within w_get_profile_view_name
end type
end forward

global type w_get_profile_view_name from window
integer width = 1751
integer height = 280
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_ok cb_ok
cb_cancel cb_cancel
st_1 st_1
sle_1 sle_1
end type
global w_get_profile_view_name w_get_profile_view_name

on w_get_profile_view_name.create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.cb_ok,&
this.cb_cancel,&
this.st_1,&
this.sle_1}
end on

on w_get_profile_view_name.destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.sle_1)
end on

type cb_ok from commandbutton within w_get_profile_view_name
integer x = 978
integer y = 92
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//Start Code Change ----03.24.2008 #V8 maha - overwrite ancestor code as it test wrong table.

String ls_retval
string ls_dataview

ls_retval = trim(sle_1.Text)

IF ls_retval='' THEN
	messagebox('Profile Name','Please enter a Profile name, or cancel.')
	return
END IF

select profile_view_name 
into :ls_dataview
from profile_view
where profile_view_name = :ls_retval ;
	
if LenA (ls_dataview) > 0 THEN 
	MESSAGEBOX(PARENT.TITLE, 'A Profile with this name exists. Please create a new one.')
else
	CloseWithReturn(Parent, sle_1.Text )
END IF 
end event

type cb_cancel from commandbutton within w_get_profile_view_name
integer x = 1349
integer y = 92
integer width = 343
integer height = 84
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

event clicked;CloseWithReturn(Parent, "Cancel" )
end event

type st_1 from statictext within w_get_profile_view_name
integer x = 32
integer y = 20
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
string text = "Profile Name"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_get_profile_view_name
integer x = 32
integer y = 92
integer width = 919
integer height = 88
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

