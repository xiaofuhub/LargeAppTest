$PBExportHeader$w_ai_notes_new_bk.srw
forward
global type w_ai_notes_new_bk from w_response
end type
type dw_add from datawindow within w_ai_notes_new_bk
end type
type cb_mailed from commandbutton within w_ai_notes_new_bk
end type
type cb_fax from commandbutton within w_ai_notes_new_bk
end type
type cb_other from commandbutton within w_ai_notes_new_bk
end type
type cb_email from commandbutton within w_ai_notes_new_bk
end type
type cb_user from commandbutton within w_ai_notes_new_bk
end type
type cb_ok from commandbutton within w_ai_notes_new_bk
end type
type cb_close from commandbutton within w_ai_notes_new_bk
end type
type cb_phone from commandbutton within w_ai_notes_new_bk
end type
type cb_print from commandbutton within w_ai_notes_new_bk
end type
type gb_1 from groupbox within w_ai_notes_new_bk
end type
type st_len from statictext within w_ai_notes_new_bk
end type
type dw_note from datawindow within w_ai_notes_new_bk
end type
end forward

global type w_ai_notes_new_bk from w_response
integer x = 946
integer y = 432
integer width = 3392
integer height = 2084
string title = "Expanded Notes"
boolean controlmenu = false
long backcolor = 33551856
dw_add dw_add
cb_mailed cb_mailed
cb_fax cb_fax
cb_other cb_other
cb_email cb_email
cb_user cb_user
cb_ok cb_ok
cb_close cb_close
cb_phone cb_phone
cb_print cb_print
gb_1 gb_1
st_len st_len
dw_note dw_note
end type
global w_ai_notes_new_bk w_ai_notes_new_bk

type variables
string is_from //maha 03.03.2011

//V = verif
//A = Applications
//C = checklist

datawindow idw_curr

end variables

forward prototypes
public function integer of_add_stamp (string as_stamp)
public function integer of_set_no_edit ()
public function integer of_security_add ()
end prototypes

public function integer of_add_stamp (string as_stamp);String ls_text
String ls_current_text
String ls_stamp

ls_stamp = as_stamp
idw_curr.accepttext( )
ls_current_text = idw_curr.getitemstring(1,"note")
IF IsNull( ls_current_text ) THEN
	ls_current_text = ""
END IF

ls_text = ls_current_text + ls_stamp

idw_curr.setitem(1,"note", ls_text) 

idw_curr.SetFocus( )
idw_curr.Setcolumn( 1)
idw_curr.selecttext(32000, 0) 

//imle_note.SelectText (  ) //Start Code Change ----10.28.2010 #V10 maha - move to end of text

return 1
end function

public function integer of_set_no_edit ();

st_len.y = 2380
dw_note.enabled = false
dw_note.y = 732
//dw_note.Modify( "notes.Background.Color='553648127'" ) //this does not work
dw_note.setitem(1, "facility_id" , 1)  //to set the background color
dw_add.visible = true
dw_add.insertrow(1)
idw_curr = dw_add
w_ai_notes_new.height = 2616







return 1
end function

public function integer of_security_add ();cb_email.enabled = false
cb_fax.enabled = false
cb_mailed.enabled = false
cb_ok.enabled = false
cb_other.enabled = false
cb_phone.enabled = false
cb_user.enabled = false
dw_note.enabled = false

return 1
end function

on w_ai_notes_new_bk.create
int iCurrent
call super::create
this.dw_add=create dw_add
this.cb_mailed=create cb_mailed
this.cb_fax=create cb_fax
this.cb_other=create cb_other
this.cb_email=create cb_email
this.cb_user=create cb_user
this.cb_ok=create cb_ok
this.cb_close=create cb_close
this.cb_phone=create cb_phone
this.cb_print=create cb_print
this.gb_1=create gb_1
this.st_len=create st_len
this.dw_note=create dw_note
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_add
this.Control[iCurrent+2]=this.cb_mailed
this.Control[iCurrent+3]=this.cb_fax
this.Control[iCurrent+4]=this.cb_other
this.Control[iCurrent+5]=this.cb_email
this.Control[iCurrent+6]=this.cb_user
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_phone
this.Control[iCurrent+10]=this.cb_print
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.st_len
this.Control[iCurrent+13]=this.dw_note
end on

on w_ai_notes_new_bk.destroy
call super::destroy
destroy(this.dw_add)
destroy(this.cb_mailed)
destroy(this.cb_fax)
destroy(this.cb_other)
destroy(this.cb_email)
destroy(this.cb_user)
destroy(this.cb_ok)
destroy(this.cb_close)
destroy(this.cb_phone)
destroy(this.cb_print)
destroy(this.gb_1)
destroy(this.st_len)
destroy(this.dw_note)
end on

event open;call super::open;//Start Code Change ----09.12.2012 #V12 maha - this window was rebuilt using

//Start Code Change ----03.03.2011 #V11 maha  - added from functionality
string ls_note
//Start code change by long.zhang 08.25.2011
dw_note.insertrow(1)

ls_note = message.stringparm
is_from = mid(ls_note,1,2)	
idw_curr = dw_note

//Start Code Change ----10.10.2012 #V12 maha - added readonly security
if gi_user_readonly = 1 then
	of_security_add()
else
	if w_mdi.of_security_access( 7360 ) = 0 then 
		of_set_no_edit()
	end if
end if
//End Code Change ----10.10.2012


IF mid(is_from,2,1) = "#" THEN  //if second character is # check security
	ls_note = mid(ls_note,3)

//	mle_note.limit = 7800

ELSE
//	mle_note.Text = Message.StringParm
END IF

dw_note.setitem(1,"note", ls_note)
st_len.text = string(len(ls_note ))

idw_curr.selecttext(32000, 0) 


//if is_from = "V" then mle_note.limit = 7800
//End code change by long.zhang 08.25.2011



end event

type dw_add from datawindow within w_ai_notes_new_bk
boolean visible = false
integer x = 46
integer y = 232
integer width = 3323
integer height = 516
integer taborder = 50
string title = "none"
string dataobject = "d_ai_note_add"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_mailed from commandbutton within w_ai_notes_new_bk
integer x = 1454
integer y = 68
integer width = 297
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Mailed"
end type

event clicked;//Start Code Change ----07.07.2011 #V11 maha- added
of_add_stamp(" Mailed ")
end event

type cb_fax from commandbutton within w_ai_notes_new_bk
integer x = 818
integer y = 68
integer width = 297
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
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

type cb_other from commandbutton within w_ai_notes_new_bk
integer x = 1765
integer y = 68
integer width = 297
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
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

type cb_email from commandbutton within w_ai_notes_new_bk
integer x = 1138
integer y = 68
integer width = 297
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
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

type cb_user from commandbutton within w_ai_notes_new_bk
integer x = 64
integer y = 68
integer width = 425
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Date/User Stamp"
end type

event clicked;String ls_text
String ls_current_text
String ls_stamp


//Start Code Change ----10.06.2009 #V10 maha - added code to not add return for first entry
ls_stamp = String( Today() ) + " (" + gs_user_id + ") "  //Start Code Change ----08.07.2009 #V92 maha - changed stamp

ls_current_text = idw_curr.getitemstring(1,"note")

if LenA(ls_current_text) >  0 then
	ls_stamp = "~r~n" + ls_stamp
end if
//End Code Change---10.06.2009

of_add_stamp( ls_stamp) //Start Code Change ----09.11.2012 #V12 maha - changed to use the function

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

type cb_ok from commandbutton within w_ai_notes_new_bk
integer x = 2752
integer y = 68
integer width = 279
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;string s

//Start Code Change ----09.11.2012 #V12 maha - modified to use the no edit functionality


if dw_add.visible then
	dw_add.accepttext( )
	s = dw_note.getitemstring(1,"note")
	if isnull(s) then s = ""
	s = s + "~r~n" + dw_add.getitemstring(1,"note")
else 
	dw_note.accepttext( )
	s =  dw_note.getitemstring(1,"note")
end if



CloseWithReturn( Parent, s )
end event

type cb_close from commandbutton within w_ai_notes_new_bk
integer x = 3049
integer y = 68
integer width = 279
integer height = 84
integer taborder = 50
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

type cb_phone from commandbutton within w_ai_notes_new_bk
integer x = 503
integer y = 68
integer width = 297
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
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

type cb_print from commandbutton within w_ai_notes_new_bk
integer x = 2455
integer y = 68
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
//rte_1.SelectTextAll ( )
//
//mle_note.selecttext(1,LenA(mle_note.text))
//mle_note.Copy()
//rte_1.Paste( )
//
//rte_1.Print(1, "", FALSE, TRUE)
dw_note.print()

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

type gb_1 from groupbox within w_ai_notes_new_bk
integer x = 23
integer width = 2112
integer height = 176
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Contact Type"
end type

type st_len from statictext within w_ai_notes_new_bk
integer x = 41
integer y = 1848
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type dw_note from datawindow within w_ai_notes_new_bk
event pfc_cst_keydown pbm_dwnkey
integer x = 14
integer y = 196
integer width = 3328
integer height = 1612
integer taborder = 40
string title = "none"
string dataobject = "d_ai_note"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event pfc_cst_keydown;//added by long.zhang appeon 11.08.2012 Bug 3319
//sccroll function unsupport on web

if key = keyhome! and keyflags = 2 then
	this.scroll( -10000 )
elseif  key = keyend! and keyflags = 2 then
	this.scroll( 10000 )
end if

return 0
end event

