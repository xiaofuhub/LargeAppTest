$PBExportHeader$w_saveas_action_type.srw
forward
global type w_saveas_action_type from w_response
end type
type mle_saveas from multilineedit within w_saveas_action_type
end type
type mle_convert from multilineedit within w_saveas_action_type
end type
type rb_convert from radiobutton within w_saveas_action_type
end type
type rb_saveas from radiobutton within w_saveas_action_type
end type
type cb_2 from commandbutton within w_saveas_action_type
end type
type cb_1 from commandbutton within w_saveas_action_type
end type
type gb_1 from groupbox within w_saveas_action_type
end type
end forward

global type w_saveas_action_type from w_response
integer width = 1595
integer height = 648
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
mle_saveas mle_saveas
mle_convert mle_convert
rb_convert rb_convert
rb_saveas rb_saveas
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_saveas_action_type w_saveas_action_type

type variables

end variables

on w_saveas_action_type.create
int iCurrent
call super::create
this.mle_saveas=create mle_saveas
this.mle_convert=create mle_convert
this.rb_convert=create rb_convert
this.rb_saveas=create rb_saveas
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_saveas
this.Control[iCurrent+2]=this.mle_convert
this.Control[iCurrent+3]=this.rb_convert
this.Control[iCurrent+4]=this.rb_saveas
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_1
end on

on w_saveas_action_type.destroy
call super::destroy
destroy(this.mle_saveas)
destroy(this.mle_convert)
destroy(this.rb_convert)
destroy(this.rb_saveas)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;call super::open;Long ll_parm

ll_parm = Message.doubleparm

If ll_parm = 2 Then
	rb_convert.enabled = False
	mle_convert.enabled = False
End If

end event

event pfc_postopen;call super::pfc_postopen;mle_saveas.backcolor = This.backcolor
mle_convert.backcolor = This.backcolor
end event

type mle_saveas from multilineedit within w_saveas_action_type
integer x = 174
integer y = 176
integer width = 1307
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "Arrow!"
long textcolor = 33554432
long backcolor = 33551856
string text = "Save the current image file as PDF format in local directory. "
boolean border = false
end type

type mle_convert from multilineedit within w_saveas_action_type
integer x = 174
integer y = 328
integer width = 1321
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "Arrow!"
long textcolor = 33554432
long backcolor = 33551856
string text = "Convert the current image file to PDF format, this process is irreversible."
boolean border = false
end type

type rb_convert from radiobutton within w_saveas_action_type
integer x = 91
integer y = 264
integer width = 526
integer height = 56
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Convert to PDF "
end type

type rb_saveas from radiobutton within w_saveas_action_type
integer x = 91
integer y = 104
integer width = 526
integer height = 52
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Save as PDF "
boolean checked = true
end type

type cb_2 from commandbutton within w_saveas_action_type
integer x = 805
integer y = 504
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;If rb_saveas.checked Then
	CloseWithReturn(Parent,1)
ElseIf rb_convert.checked Then
	CloseWithReturn(Parent,2)
Else
	CloseWithReturn(Parent,0)
End If
end event

type cb_1 from commandbutton within w_saveas_action_type
integer x = 1157
integer y = 504
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent,0)
end event

type gb_1 from groupbox within w_saveas_action_type
integer x = 41
integer y = 24
integer width = 1463
integer height = 452
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Action Type"
end type

