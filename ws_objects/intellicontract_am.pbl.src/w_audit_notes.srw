$PBExportHeader$w_audit_notes.srw
$PBExportComments$Create by Jack 1/17/2007
forward
global type w_audit_notes from w_response
end type
type cb_4 from commandbutton within w_audit_notes
end type
type cb_3 from commandbutton within w_audit_notes
end type
type mle_note from multilineedit within w_audit_notes
end type
type cb_2 from commandbutton within w_audit_notes
end type
type cb_1 from commandbutton within w_audit_notes
end type
type rte_1 from richtextedit within w_audit_notes
end type
end forward

global type w_audit_notes from w_response
integer width = 1426
integer height = 1736
string title = "Contract Audit Notes"
boolean controlmenu = false
long backcolor = 33551856
cb_4 cb_4
cb_3 cb_3
mle_note mle_note
cb_2 cb_2
cb_1 cb_1
rte_1 rte_1
end type
global w_audit_notes w_audit_notes

on w_audit_notes.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.mle_note=create mle_note
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rte_1=create rte_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.mle_note
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.rte_1
end on

on w_audit_notes.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.mle_note)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rte_1)
end on

event open;call super::open;string ls_notes
ls_notes = message.stringparm
mle_note.text = ls_notes

end event

type cb_4 from commandbutton within w_audit_notes
integer x = 494
integer y = 1532
integer width = 279
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;//maha app100505 modified
rte_1.SelectTextAll ( )

mle_note.selecttext(1,len(mle_note.text))
mle_note.Copy()
rte_1.Paste( )

rte_1.Print(1, "", FALSE, TRUE)

//
//rte_1.SelectTextAll ( )
//
//mle_note.Clear()
//
//mle_note.Copy()
//
//rte_1.Paste( )
//
//rte_1.Print(1, "", FALSE, TRUE)
end event

type cb_3 from commandbutton within w_audit_notes
integer x = 197
integer y = 1532
integer width = 279
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Time Stamp"
end type

event clicked;String ls_text
String ls_current_text
String ls_stamp

ls_stamp = String( Today() ) + " " + String( Now( ), "hh:mm")

ls_current_text = mle_note.Text
IF IsNull( ls_current_text ) THEN
	ls_current_text = ""
END IF

ls_text = ls_current_text + ls_stamp

mle_note.Text = ls_text

mle_note.SetFocus( )
end event

type mle_note from multilineedit within w_audit_notes
integer x = 27
integer y = 24
integer width = 1339
integer height = 1464
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_audit_notes
integer x = 1088
integer y = 1532
integer width = 279
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_1 from commandbutton within w_audit_notes
integer x = 791
integer y = 1532
integer width = 279
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;




CloseWithReturn( Parent, mle_note.Text )
end event

type rte_1 from richtextedit within w_audit_notes
boolean visible = false
integer x = 494
integer y = 1532
integer width = 215
integer height = 140
integer taborder = 40
borderstyle borderstyle = stylelowered!
end type

