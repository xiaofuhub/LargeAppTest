$PBExportHeader$w_ai_notes.srw
forward
global type w_ai_notes from w_response
end type
type cb_mailed from commandbutton within w_ai_notes
end type
type st_len from statictext within w_ai_notes
end type
type cb_fax from commandbutton within w_ai_notes
end type
type cb_6 from commandbutton within w_ai_notes
end type
type cb_email from commandbutton within w_ai_notes
end type
type cb_5 from commandbutton within w_ai_notes
end type
type cb_1 from commandbutton within w_ai_notes
end type
type cb_2 from commandbutton within w_ai_notes
end type
type mle_note from multilineedit within w_ai_notes
end type
type cb_phone from commandbutton within w_ai_notes
end type
type cb_4 from commandbutton within w_ai_notes
end type
type gb_1 from groupbox within w_ai_notes
end type
end forward

global type w_ai_notes from w_response
integer x = 946
integer y = 432
integer width = 2670
integer height = 2592
string title = "Expanded Notes"
boolean controlmenu = false
long backcolor = 33551856
cb_mailed cb_mailed
st_len st_len
cb_fax cb_fax
cb_6 cb_6
cb_email cb_email
cb_5 cb_5
cb_1 cb_1
cb_2 cb_2
mle_note mle_note
cb_phone cb_phone
cb_4 cb_4
gb_1 gb_1
end type
global w_ai_notes w_ai_notes

type variables
string is_from //maha 03.03.2011

//V = verif
//A = Applications
//C = checklist

end variables

forward prototypes
public function integer of_add_stamp (string as_stamp)
end prototypes

public function integer of_add_stamp (string as_stamp);String ls_text
String ls_current_text
String ls_stamp

ls_stamp = as_stamp

ls_current_text = mle_note.Text
IF IsNull( ls_current_text ) THEN
	ls_current_text = ""
END IF

ls_text = ls_current_text + ls_stamp

mle_note.Text = ls_text

mle_note.SetFocus( )
mle_note.SelectText ( 32000, 0 ) //Start Code Change ----10.28.2010 #V10 maha - move to end of text

return 1
end function

on w_ai_notes.create
int iCurrent
call super::create
this.cb_mailed=create cb_mailed
this.st_len=create st_len
this.cb_fax=create cb_fax
this.cb_6=create cb_6
this.cb_email=create cb_email
this.cb_5=create cb_5
this.cb_1=create cb_1
this.cb_2=create cb_2
this.mle_note=create mle_note
this.cb_phone=create cb_phone
this.cb_4=create cb_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_mailed
this.Control[iCurrent+2]=this.st_len
this.Control[iCurrent+3]=this.cb_fax
this.Control[iCurrent+4]=this.cb_6
this.Control[iCurrent+5]=this.cb_email
this.Control[iCurrent+6]=this.cb_5
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.mle_note
this.Control[iCurrent+10]=this.cb_phone
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.gb_1
end on

on w_ai_notes.destroy
call super::destroy
destroy(this.cb_mailed)
destroy(this.st_len)
destroy(this.cb_fax)
destroy(this.cb_6)
destroy(this.cb_email)
destroy(this.cb_5)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.mle_note)
destroy(this.cb_phone)
destroy(this.cb_4)
destroy(this.gb_1)
end on

event open;call super::open;//Start Code Change ----03.03.2011 #V11 maha  - added from functionality

//Start code change by long.zhang 08.25.2011

//is_from = mid(Message.StringParm,1,1)
is_from = mid(Message.StringParm,1,2)	
//mle_note.Text =  mid(Message.StringParm,2)
IF is_from = "V#" THEN
	mle_note.Text =  mid(Message.StringParm,3)
	mle_note.limit = 7800
ELSE
	mle_note.Text = Message.StringParm
END IF
st_len.text = string(len(mle_note.text ))

//if is_from = "V" then mle_note.limit = 7800
//End code change by long.zhang 08.25.2011



end event

type cb_mailed from commandbutton within w_ai_notes
integer x = 992
integer y = 76
integer width = 297
integer height = 68
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Mailed"
end type

event clicked;//Start Code Change ----07.07.2011 #V11 maha- added
of_add_stamp(" Mailed ")
end event

type st_len from statictext within w_ai_notes
integer x = 27
integer y = 2404
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_fax from commandbutton within w_ai_notes
integer x = 357
integer y = 76
integer width = 297
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Fax"
end type

event clicked;//Start Code Change ----10.28.2010 #V10 maha - modified to function
of_add_stamp(" FAX ")

//String ls_text
//String ls_current_text
//String ls_stamp
//
//ls_stamp = " Fax "
//
//ls_current_text = mle_note.Text
//IF IsNull( ls_current_text ) THEN
//	ls_current_text = ""
//END IF
//
//ls_text = ls_current_text + ls_stamp
//
//mle_note.Text = ls_text
//
//mle_note.SetFocus( )
//mle_note.SelectText ( 32000, 0 ) //Start Code Change ----10.28.2010 #V10 maha - move to end of text
end event

type cb_6 from commandbutton within w_ai_notes
integer x = 1303
integer y = 76
integer width = 297
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Other"
end type

event clicked;//Start Code Change ----10.28.2010 #V10 maha - modified to function
of_add_stamp(" Other ")

//String ls_text
//String ls_current_text
//String ls_stamp
//
//ls_stamp = " Other "
//
//ls_current_text = mle_note.Text
//IF IsNull( ls_current_text ) THEN
//	ls_current_text = ""
//END IF
//
//ls_text = ls_current_text + ls_stamp
//
//mle_note.Text = ls_text
//
//mle_note.SetFocus( )
//mle_note.SelectText ( 32000, 0 ) //Start Code Change ----10.28.2010 #V10 maha - move to end of text

end event

type cb_email from commandbutton within w_ai_notes
integer x = 677
integer y = 76
integer width = 297
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "E-mail"
end type

event clicked;//Start Code Change ----10.28.2010 #V10 maha - modified to function
of_add_stamp(" Email ")

//String ls_text
//String ls_current_text
//String ls_stamp
//
//ls_stamp = " Email "
//
//ls_current_text = mle_note.Text
//IF IsNull( ls_current_text ) THEN
//	ls_current_text = ""
//END IF
//
//ls_text = ls_current_text + ls_stamp
//
//mle_note.Text = ls_text
//
//mle_note.SetFocus( )
//mle_note.SelectText ( 32000, 0 ) //Start Code Change ----10.28.2010 #V10 maha - move to end of text
//
end event

type cb_5 from commandbutton within w_ai_notes
integer x = 46
integer y = 148
integer width = 425
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Date/User Stamp"
end type

event clicked;String ls_text
String ls_current_text
String ls_stamp


//Start Code Change ----10.06.2009 #V10 maha - added code to not add return for first entry
ls_stamp = String( Today() ) + " (" + gs_user_id + ")"  //Start Code Change ----08.07.2009 #V92 maha - changed stamp

ls_current_text = mle_note.Text

if LenA(ls_current_text) >  0 then
	ls_stamp = "~r~n" + ls_stamp
end if
//End Code Change---10.06.2009

IF IsNull( ls_current_text ) THEN
	ls_current_text = ""
END IF

ls_text = ls_current_text + ls_stamp

mle_note.Text = ls_text

mle_note.SetFocus( )
mle_note.SelectText ( 32000, 0 ) //Start Code Change ----10.28.2010 #V10 maha - move to end of text
end event

type cb_1 from commandbutton within w_ai_notes
integer x = 2011
integer y = 80
integer width = 279
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
end type

event clicked;




CloseWithReturn( Parent, mle_note.Text )
end event

type cb_2 from commandbutton within w_ai_notes
integer x = 2309
integer y = 80
integer width = 279
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type mle_note from multilineedit within w_ai_notes
integer x = 23
integer y = 272
integer width = 2569
integer height = 2116
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

event losefocus;st_len.text = string(len(mle_note.text ))
end event

type cb_phone from commandbutton within w_ai_notes
integer x = 41
integer y = 76
integer width = 297
integer height = 68
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Phone"
end type

event clicked;//Start Code Change ----10.28.2010 #V10 maha - modified to function
of_add_stamp(" Phone ")

//String ls_text
//String ls_current_text
//String ls_stamp
//
//ls_stamp = " Phone "
//
//ls_current_text = mle_note.Text
//IF IsNull( ls_current_text ) THEN
//	ls_current_text = ""
//END IF
//
//ls_text = ls_current_text + ls_stamp
//
//mle_note.Text = ls_text
//
//mle_note.SetFocus( )

end event

type cb_4 from commandbutton within w_ai_notes
boolean visible = false
integer x = 1714
integer y = 80
integer width = 279
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Print"
end type

event clicked;//maha app100505 modified
//rte_1.SelectTextAll ( )
//
//mle_note.selecttext(1,LenA(mle_note.text))
//mle_note.Copy()
//rte_1.Paste( )
//
//rte_1.Print(1, "", FALSE, TRUE)

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

type gb_1 from groupbox within w_ai_notes
integer y = 16
integer width = 1637
integer height = 224
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 33551856
string text = "Contact Type"
end type

