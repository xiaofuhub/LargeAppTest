$PBExportHeader$w_ai_notes_new.srw
forward
global type w_ai_notes_new from w_response
end type
type st_max from statictext within w_ai_notes_new
end type
type mle_add from multilineedit within w_ai_notes_new
end type
type mle_note from multilineedit within w_ai_notes_new
end type
type dw_add from datawindow within w_ai_notes_new
end type
type cb_mailed from commandbutton within w_ai_notes_new
end type
type cb_fax from commandbutton within w_ai_notes_new
end type
type cb_other from commandbutton within w_ai_notes_new
end type
type cb_email from commandbutton within w_ai_notes_new
end type
type cb_user from commandbutton within w_ai_notes_new
end type
type cb_ok from commandbutton within w_ai_notes_new
end type
type cb_close from commandbutton within w_ai_notes_new
end type
type cb_phone from commandbutton within w_ai_notes_new
end type
type cb_print from commandbutton within w_ai_notes_new
end type
type gb_1 from groupbox within w_ai_notes_new
end type
type st_len from statictext within w_ai_notes_new
end type
type dw_note from datawindow within w_ai_notes_new
end type
end forward

global type w_ai_notes_new from w_response
integer x = 946
integer y = 432
integer width = 3392
integer height = 2084
string title = "Expanded Notes"
boolean controlmenu = false
long backcolor = 33551856
st_max st_max
mle_add mle_add
mle_note mle_note
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
global w_ai_notes_new w_ai_notes_new

type variables
string is_from //maha 03.03.2011
boolean ib_top = false  //maha 11.27.2012
boolean ib_added
Long il_max = 200000  //maha 06.05.2014 //change all 'ii_max'  to 'il_max', Modified by Appeon long.zhang 04.17.2015 (Bug 4484 for Case # 00053251: Maximum Length on Application Note)

//V = verif
//A = Applications
//C = checklist

datawindow idw_curr
MultiLineEdit imle_curr

end variables

forward prototypes
public function integer of_add_stamp (string as_stamp)
public function integer of_set_no_edit ()
public function integer of_security_add ()
end prototypes

public function integer of_add_stamp (string as_stamp);String ls_text
String ls_current_text
String ls_stamp
string ls_lead  //maha 11.27.2012
integer li_len  //maha 11.27.2012
integer li_pos

//Start Code Change ----06.05.2014 #V14.2 maha - added length test
if len(mle_note.text) + len(as_stamp) > il_max then
	Messagebox("Add stamp","Adding this stamp would exceed the numbers of characters allowed for this note field. ( " + string(il_max) + " )")
	return -1
end if

ls_stamp = as_stamp	
li_len = len(ls_stamp) //Start Code Change ----11.27.2012 #V12 maha 

ls_current_text = imle_curr.text
IF IsNull( ls_current_text ) THEN
	ls_current_text = ""
END IF

//Start Code Change ----11.27.2012 #V12 maha - stamp at top
if ib_top then
	if isnumber(mid(ls_stamp,1,1)) then ib_added = false //if  date stamp then add return
	if ib_added = true then
		debugbreak()
		li_pos = imle_curr.position( )
		imle_curr.selecttext(1, li_pos)
		ls_lead = imle_curr.selectedtext( )
		imle_curr.selecttext(li_pos, 32000)
		ls_current_text =  imle_curr.selectedtext( )
		ls_text = ls_lead + ls_stamp + ls_current_text
		li_len = len(ls_lead) + len(ls_stamp) + 1
	else
		ls_text = ls_stamp + "~r~n" + ls_current_text
		ib_added = true
	end if
	imle_curr.text = ls_text
	imle_curr.selecttext(li_len, 0)
else
	ls_text = ls_current_text + ls_stamp
	imle_curr.text = ls_text
	imle_curr.selecttext(32000, 0)
end if

imle_curr.SetFocus( )  //Start Code Change ----12.21.2012 #V12 maha - changed from mle_note
//End Code Change ----11.27.2012



return 1
end function

public function integer of_set_no_edit ();
st_len.y = 2380
mle_note.displayonly = true
mle_note.backcolor = 15790320 
mle_note.y = 732
mle_add.visible = true
imle_curr = mle_add
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
mle_note.displayonly = true
mle_note.backcolor = 15790320 

return 1
end function

on w_ai_notes_new.create
int iCurrent
call super::create
this.st_max=create st_max
this.mle_add=create mle_add
this.mle_note=create mle_note
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
this.Control[iCurrent+1]=this.st_max
this.Control[iCurrent+2]=this.mle_add
this.Control[iCurrent+3]=this.mle_note
this.Control[iCurrent+4]=this.dw_add
this.Control[iCurrent+5]=this.cb_mailed
this.Control[iCurrent+6]=this.cb_fax
this.Control[iCurrent+7]=this.cb_other
this.Control[iCurrent+8]=this.cb_email
this.Control[iCurrent+9]=this.cb_user
this.Control[iCurrent+10]=this.cb_ok
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.cb_phone
this.Control[iCurrent+13]=this.cb_print
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.st_len
this.Control[iCurrent+16]=this.dw_note
end on

on w_ai_notes_new.destroy
call super::destroy
destroy(this.st_max)
destroy(this.mle_add)
destroy(this.mle_note)
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

event open;call super::open;//Add mle controls and reconstruct code for the Bug 3319 - Alfee 11.09.2012
string ls_note
integer p  //maha 06.05.2014
boolean ib_length = false //maha 06.05.2014

ls_note = message.stringparm
if isnull(ls_note) then ls_note = ""  //(Appeon)Harry 07.16.2014 - for the Bug 4115
debugbreak()
//Start Code Change ----06.05.2014 #V14.2 maha - redesigned with added parameter to trap for length of field.
if pos(ls_note, "#",1) = 2 then
	is_from = mid(ls_note,1,1)
	ls_note = mid(ls_note, 3)	
	ib_length = true
	choose case is_from
		case "A"
			il_max = 32000
		case "M"
			il_max = 255		
		case "N"
			il_max = 6000
		case "R"
			//li_max = 6000
			ib_length = false
		case "C"	 //recruit candidate actions
			il_max = 8000
		case "V"
			il_max = 7800
		case else   //Start Code Change ----04.16.2015 #V15 maha - added for text fields
			il_max = 200000
	end choose
end if
	
if pos(ls_note, "@#$",1) > 0 then
	p = pos(ls_note, "@#$",1)
	il_max = integer(mid(ls_note,1,p - 1))
	ls_note = mid(ls_note,p + 3)
	
	ib_length= true
elseif pos(ls_note, "#@#",1) > 0 then
	p = pos(ls_note, "#@#",1)
	il_max = integer(mid(ls_note,1,p - 1))
	ls_note = mid(ls_note,p + 3)
	ib_length= true
end if

if ib_length = true then
	st_max.text = "Maximum number of total characters allowed for this note field is " + string(il_max)
	st_max.visible = true
	mle_note.limit = il_max
else
	st_max.visible = false
end if


//is_from = mid(ls_note,1,2)	
//if is_from = "V" then 
//	mle_note.limit = 7800
//elseif is_from = 'N#'  then 
//	mle_note.limit = 6000 //(Appeon)Stephen 08.07.2013 - V141 Web Population Part 3 - view notes
//end if
//

imle_curr = mle_note

//Start Code Change ----10.10.2012 #V12 maha - added readonly security
if gi_user_readonly = 1 or gb_note_readonly  then //add gb_note_readonly, by Appeon long.zhang 02.15.2016 (V15.1 Applause Cycle 3 Bug #4992 - AI-Application Status: Can add a note to action item with read-only access)
	of_security_add()
	
	gb_note_readonly = False //Reset it at once after used.
else
	if w_mdi.of_security_access( 7360 ) = 0 then 
		of_set_no_edit()
	else
		if is_from = 'R'  then of_security_add() 
	end if
end if
//End Code Change ----10.10.2012

//IF mid(is_from,2,1) = "#" THEN  //if second character is # check security
//	ls_note = mid(ls_note,3)
//END IF
//
mle_note.text = ls_note

st_len.text = string(len(ls_note ))

ib_top = gb_notes_at_top

//if is_from = 'R'  then of_security_add() //(Appeon)Stephen 08.07.2013 - V141 Web Population Part 3 - view notes
//End Code Change ----06.05.2014


////Start Code Change ----09.12.2012 #V12 maha - this window was rebuilt using
//
////Start Code Change ----03.03.2011 #V11 maha  - added from functionality
//string ls_note
////Start code change by long.zhang 08.25.2011
//dw_note.insertrow(1)
//
//ls_note = message.stringparm
//is_from = mid(ls_note,1,2)	
//idw_curr = dw_note
//
////Start Code Change ----10.10.2012 #V12 maha - added readonly security
//if gi_user_readonly = 1 then
//	of_security_add()
//else
//	if w_mdi.of_security_access( 7360 ) = 0 then 
//		of_set_no_edit()
//	end if
//end if
////End Code Change ----10.10.2012
//
//
//IF mid(is_from,2,1) = "#" THEN  //if second character is # check security
//	ls_note = mid(ls_note,3)
//
////	mle_note.limit = 7800
//
//ELSE
////	mle_note.Text = Message.StringParm
//END IF
//
//dw_note.setitem(1,"note", ls_note)
//st_len.text = string(len(ls_note ))
//
//idw_curr.selecttext(32000, 0) 
//
//
////if is_from = "V" then mle_note.limit = 7800
////End code change by long.zhang 08.25.2011
//
//
//
end event

type st_max from statictext within w_ai_notes_new
integer x = 759
integer y = 1852
integer width = 2025
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Max Number allowed"
boolean focusrectangle = false
end type

type mle_add from multilineedit within w_ai_notes_new
boolean visible = false
integer x = 14
integer y = 196
integer width = 3328
integer height = 516
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type mle_note from multilineedit within w_ai_notes_new
integer x = 14
integer y = 196
integer width = 3328
integer height = 1612
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event losefocus;st_len.text = string(len(mle_note.text ))
end event

type dw_add from datawindow within w_ai_notes_new
boolean visible = false
integer x = 23
integer y = 232
integer width = 3323
integer height = 516
integer taborder = 80
string title = "none"
string dataobject = "d_ai_note_add"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_mailed from commandbutton within w_ai_notes_new
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

type cb_fax from commandbutton within w_ai_notes_new
integer x = 818
integer y = 68
integer width = 297
integer height = 84
integer taborder = 90
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

type cb_other from commandbutton within w_ai_notes_new
integer x = 1765
integer y = 68
integer width = 297
integer height = 84
integer taborder = 100
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

type cb_email from commandbutton within w_ai_notes_new
integer x = 1138
integer y = 68
integer width = 297
integer height = 84
integer taborder = 110
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

type cb_user from commandbutton within w_ai_notes_new
integer x = 64
integer y = 68
integer width = 425
integer height = 84
integer taborder = 120
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

ls_current_text = imle_curr.text

if ib_top then  //Start Code Change ----11.27.2012 #V12 maha - stamp at top
	//leave as is
else
	if LenA(ls_current_text) >  0 then
		ls_stamp = "~r~n" + ls_stamp
	end if
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

type cb_ok from commandbutton within w_ai_notes_new
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

if mle_add.visible then
	s = mle_note.text
	if isnull(s) then s = ""
	if ib_top then //Start Code Change ----12.12.2012 #V12 maha
		s = mle_add.text + s
	else
		s = s + "~r~n" + mle_add.text
	end if
else 
	s =  mle_note.text
end if

if len(s) > il_max then
	messagebox("Note is too long","The total length of your note (" + string(len(s)) + ") is longer than the max allowed for this field. ( " + string(il_max) + " )")
	return 1
end if

CloseWithReturn( Parent, s )
end event

type cb_close from commandbutton within w_ai_notes_new
integer x = 3049
integer y = 68
integer width = 279
integer height = 84
integer taborder = 130
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

type cb_phone from commandbutton within w_ai_notes_new
integer x = 503
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

type cb_print from commandbutton within w_ai_notes_new
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

event clicked;
if dw_note.rowcount() < 1 then 
	dw_note.insertrow(1)
end if

dw_note.setitem(1, "note", trim(mle_note.text))
dw_note.print()


//maha app100505 modified
//rte_1.SelectTextAll ( )
//
//mle_note.selecttext(1,LenA(mle_note.text))
//mle_note.Copy()
//rte_1.Paste( )
//
//rte_1.Print(1, "", FALSE, TRUE)
//dw_note.print()

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

type gb_1 from groupbox within w_ai_notes_new
integer x = 23
integer width = 2112
integer height = 176
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Contact Type"
end type

type st_len from statictext within w_ai_notes_new
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

type dw_note from datawindow within w_ai_notes_new
event pfc_cst_keydown pbm_dwnkey
boolean visible = false
integer x = 14
integer y = 196
integer width = 3328
integer height = 1612
integer taborder = 60
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

