$PBExportHeader$w_export_clause_type_choose.srw
forward
global type w_export_clause_type_choose from w_response
end type
type cb_cancel from commandbutton within w_export_clause_type_choose
end type
type cb_ok from commandbutton within w_export_clause_type_choose
end type
type rb_2 from radiobutton within w_export_clause_type_choose
end type
type rb_1 from radiobutton within w_export_clause_type_choose
end type
type gb_1 from groupbox within w_export_clause_type_choose
end type
end forward

global type w_export_clause_type_choose from w_response
integer width = 1376
integer height = 552
string title = "Export Clause"
long backcolor = 33551856
event ue_syssommand pbm_syscommand
cb_cancel cb_cancel
cb_ok cb_ok
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
end type
global w_export_clause_type_choose w_export_clause_type_choose

event ue_syssommand;If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

on w_export_clause_type_choose.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_export_clause_type_choose.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
end on

type cb_cancel from commandbutton within w_export_clause_type_choose
integer x = 960
integer y = 332
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
end type

event clicked;CloseWithReturn(Parent,0)
end event

type cb_ok from commandbutton within w_export_clause_type_choose
integer x = 603
integer y = 332
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

event clicked;Long ll_value

If rb_1.checked Then
	ll_value = 1
End If

If rb_2.checked Then
	ll_value = 2	
End If

CloseWithReturn(Parent,ll_value)
end event

type rb_2 from radiobutton within w_export_clause_type_choose
integer x = 169
integer y = 192
integer width = 846
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Export Clause as Combined File   "
end type

type rb_1 from radiobutton within w_export_clause_type_choose
integer x = 165
integer y = 112
integer width = 837
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Export Clause as Seperate File  "
boolean checked = true
end type

type gb_1 from groupbox within w_export_clause_type_choose
integer x = 50
integer y = 20
integer width = 1257
integer height = 272
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Export Type"
end type

