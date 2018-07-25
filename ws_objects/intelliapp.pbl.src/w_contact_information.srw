$PBExportHeader$w_contact_information.srw
forward
global type w_contact_information from w_response
end type
type cb_update from commandbutton within w_contact_information
end type
type cb_1 from commandbutton within w_contact_information
end type
type gb_5 from groupbox within w_contact_information
end type
type cb_phone from commandbutton within w_contact_information
end type
type mle_note from multilineedit within w_contact_information
end type
type cb_user from commandbutton within w_contact_information
end type
type cb_email from commandbutton within w_contact_information
end type
type cb_other from commandbutton within w_contact_information
end type
type cb_fax from commandbutton within w_contact_information
end type
type cb_mailed from commandbutton within w_contact_information
end type
type dw_prac from u_dw within w_contact_information
end type
type dw_app_info from u_dw within w_contact_information
end type
type cb_add_note from commandbutton within w_contact_information
end type
type dw_app_addresses from u_dw within w_contact_information
end type
type dw_practice_addresses from u_dw within w_contact_information
end type
type gb_client from groupbox within w_contact_information
end type
type gb_payor from groupbox within w_contact_information
end type
type gb_1 from groupbox within w_contact_information
end type
type dw_facility from u_dw within w_contact_information
end type
type gb_2 from groupbox within w_contact_information
end type
type gb_3 from groupbox within w_contact_information
end type
type gb_4 from groupbox within w_contact_information
end type
end forward

global type w_contact_information from w_response
integer x = 425
integer y = 96
integer width = 3881
integer height = 2432
string title = "Contact Information"
long backcolor = 33551856
cb_update cb_update
cb_1 cb_1
gb_5 gb_5
cb_phone cb_phone
mle_note mle_note
cb_user cb_user
cb_email cb_email
cb_other cb_other
cb_fax cb_fax
cb_mailed cb_mailed
dw_prac dw_prac
dw_app_info dw_app_info
cb_add_note cb_add_note
dw_app_addresses dw_app_addresses
dw_practice_addresses dw_practice_addresses
gb_client gb_client
gb_payor gb_payor
gb_1 gb_1
dw_facility dw_facility
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_contact_information w_contact_information

type variables
string is_notes
boolean ib_top = false //maha 11.27.2012
boolean ib_added = false  //maha 11.27.2012
end variables

forward prototypes
public function integer of_add_stamp (string as_stamp)
end prototypes

public function integer of_add_stamp (string as_stamp);//Start Code Change ----08.23.2012 #V12 maha - copied from notes screen

String ls_text
String ls_current_text
String ls_stamp
string ls_lead  //maha 11.27.2012
integer li_len  //maha 11.27.2012
integer li_pos

ls_stamp = as_stamp
li_len = len(ls_stamp) //Start Code Change ----11.27.2012 #V12 maha 

ls_current_text = mle_note.text
IF IsNull( ls_current_text ) THEN
	ls_current_text = ""
END IF

//Start Code Change ----11.27.2012 #V12 maha - stamp at top
if ib_top then
	if isnumber(mid(ls_stamp,1,1)) then ib_added = false //if  date stamp then add return
	if ib_added = true then
		debugbreak()
		li_pos = mle_note.position( )
		mle_note.selecttext(1, li_pos)
		ls_lead = mle_note.selectedtext( )
		mle_note.selecttext(li_pos, 32000)
		ls_current_text = mle_note.selectedtext( )
		ls_text = ls_lead + ls_stamp + ls_current_text
		li_len = len(ls_lead) + len(ls_stamp) + 1
	else
		ls_text = ls_stamp + "~r~n" + ls_current_text
		ib_added = true
	end if
	mle_note.text = ls_text
	mle_note.selecttext(li_len, 0)
else
	ls_text = ls_current_text + ls_stamp
	mle_note.text = ls_text
	mle_note.selecttext(32000, 0)
end if

mle_note.SetFocus( )
//End Code Change ----11.27.2012



return 1
end function

on w_contact_information.create
int iCurrent
call super::create
this.cb_update=create cb_update
this.cb_1=create cb_1
this.gb_5=create gb_5
this.cb_phone=create cb_phone
this.mle_note=create mle_note
this.cb_user=create cb_user
this.cb_email=create cb_email
this.cb_other=create cb_other
this.cb_fax=create cb_fax
this.cb_mailed=create cb_mailed
this.dw_prac=create dw_prac
this.dw_app_info=create dw_app_info
this.cb_add_note=create cb_add_note
this.dw_app_addresses=create dw_app_addresses
this.dw_practice_addresses=create dw_practice_addresses
this.gb_client=create gb_client
this.gb_payor=create gb_payor
this.gb_1=create gb_1
this.dw_facility=create dw_facility
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_update
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_5
this.Control[iCurrent+4]=this.cb_phone
this.Control[iCurrent+5]=this.mle_note
this.Control[iCurrent+6]=this.cb_user
this.Control[iCurrent+7]=this.cb_email
this.Control[iCurrent+8]=this.cb_other
this.Control[iCurrent+9]=this.cb_fax
this.Control[iCurrent+10]=this.cb_mailed
this.Control[iCurrent+11]=this.dw_prac
this.Control[iCurrent+12]=this.dw_app_info
this.Control[iCurrent+13]=this.cb_add_note
this.Control[iCurrent+14]=this.dw_app_addresses
this.Control[iCurrent+15]=this.dw_practice_addresses
this.Control[iCurrent+16]=this.gb_client
this.Control[iCurrent+17]=this.gb_payor
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.dw_facility
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.gb_3
this.Control[iCurrent+22]=this.gb_4
end on

on w_contact_information.destroy
call super::destroy
destroy(this.cb_update)
destroy(this.cb_1)
destroy(this.gb_5)
destroy(this.cb_phone)
destroy(this.mle_note)
destroy(this.cb_user)
destroy(this.cb_email)
destroy(this.cb_other)
destroy(this.cb_fax)
destroy(this.cb_mailed)
destroy(this.dw_prac)
destroy(this.dw_app_info)
destroy(this.cb_add_note)
destroy(this.dw_app_addresses)
destroy(this.dw_practice_addresses)
destroy(this.gb_client)
destroy(this.gb_payor)
destroy(this.gb_1)
destroy(this.dw_facility)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;Integer li_retval
Long ll_prac_id
Long ll_app_facility_id
Long li_facility_id
Long ll_app_id

gs_pass_ids str_ids
str_ids = Message.PowerObjectParm

dw_app_addresses.of_SetTransObject( SQLCA )
dw_practice_addresses.of_SetTransObject( SQLCA )
dw_facility.of_SetTransObject( SQLCA )
dw_app_info.of_SetTransObject( SQLCA )  //Start Code Change ----07.17.2012 #V12 maha
dw_prac.of_SetTransObject( SQLCA )  //Start Code Change ----07.23.2012 #V12 maha

ll_prac_id = str_ids.prac_id
li_facility_id = str_ids.facility_id
ll_app_id = str_ids.l_app_id
is_notes = str_ids.s_stringval //Start Code Change ----08.22.2012 #V12 maha
mle_note.text = is_notes

//Start Code Change ----09.12.2012 #V12 maha - no edit functionality
if  w_mdi.of_security_access( 7360 ) = 0 then //add but no edit
	mle_note.enabled = false
	cb_add_note.visible = true
	cb_email.enabled = false
	cb_fax.enabled = false
	cb_mailed.enabled = false
	cb_other.enabled = false
	cb_phone.enabled = false
	cb_user.enabled = false
end if
//End Code Change ----09.12.2012

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 02.14.2016
//<$>reason: Add Action Items - Applications - View Rights , for V15.1 Applause Cycle 3 Bug #4992 - AI-Application Status: Can add a note to action item with read-only access
//Start Code Change ----02.11.2016 #V15 maha
//if  w_mdi.of_security_access( 1400 ) < 2 then //app tab readonly
If ( str_ids.ls_from_window <> "A" and w_mdi.of_security_access( 1400 ) < 2 ) or &
	( str_ids.ls_from_window = "A" and w_mdi.of_security_access( 5200 ) < 2 ) Then
	mle_note.enabled = false
	cb_add_note.visible = false
	cb_update.visible = false
	cb_email.enabled = false
	cb_fax.enabled = false
	cb_mailed.enabled = false
	cb_other.enabled = false
	cb_phone.enabled = false
	cb_user.enabled = false
end if
//End Code Change ----02.11.2016 

//------------------- APPEON END -------------------


//messagebox( "prac_id", ll_prac_id )
//messagebox( "facility" , li_facility_id )
//messagebox( "app",  ll_app_id )

SELECT facility_id
INTO :ll_app_facility_id
FROM app_hdr
WHERE app_id = :ll_app_id;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.16.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

dw_app_addresses.Retrieve( ll_app_facility_id )
dw_facility.Retrieve( li_facility_id )
dw_practice_addresses.Retrieve( ll_prac_id, li_facility_id )
dw_app_info.Retrieve( ll_app_id )   //Start Code Change ----07.17.2012 #V12 maha
dw_prac.Retrieve( ll_prac_id )   //Start Code Change ----07.23.2012 #V12 maha
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 02.16.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

gb_client.Text = str_ids.sl_label1 + " Contact Info"
gb_payor.Text = str_ids.sl_label2 + " Contact Info"
end event

event close;call super::close;if Message.StringParm <> mle_note.text then Message.StringParm = 'Cancel' //add by stephen 04.22.2013 -Bug 3494 : Notes Disappear under Applications Tab 
end event

type cb_update from commandbutton within w_contact_information
integer x = 2994
integer y = 68
integer width = 425
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update Notes"
end type

event clicked;Closewithreturn( Parent, mle_note.text)
end event

type cb_1 from commandbutton within w_contact_information
integer x = 3433
integer y = 68
integer width = 347
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean default = true
end type

event clicked;Closewithreturn( Parent, "Cancel" )
end event

type gb_5 from groupbox within w_contact_information
integer x = 2647
integer y = 236
integer width = 1125
integer height = 244
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

type cb_phone from commandbutton within w_contact_information
integer x = 2729
integer y = 308
integer width = 233
integer height = 68
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

type mle_note from multilineedit within w_contact_information
integer x = 2647
integer y = 492
integer width = 1115
integer height = 1744
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
end type

event losefocus;//st_len.text = string(len(mle_note.text ))
end event

type cb_user from commandbutton within w_contact_information
integer x = 2729
integer y = 380
integer width = 425
integer height = 68
integer taborder = 80
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

ls_current_text = mle_note.Text

if ib_top then  //Start Code Change ----11.27.2012 #V12 maha - stamp at top
	//leave as is
else
	if LenA(ls_current_text) >  0 then
		ls_stamp = "~r~n" + ls_stamp
	end if
end if
//End Code Change---10.06.2009

of_add_stamp( ls_stamp )

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

type cb_email from commandbutton within w_contact_information
integer x = 3218
integer y = 308
integer width = 233
integer height = 68
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

type cb_other from commandbutton within w_contact_information
integer x = 3470
integer y = 380
integer width = 233
integer height = 68
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

type cb_fax from commandbutton within w_contact_information
integer x = 2971
integer y = 308
integer width = 233
integer height = 68
integer taborder = 40
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

type cb_mailed from commandbutton within w_contact_information
integer x = 3470
integer y = 308
integer width = 233
integer height = 68
integer taborder = 40
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

type dw_prac from u_dw within w_contact_information
integer x = 105
integer y = 80
integer width = 2441
integer height = 92
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_contact_prac"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type dw_app_info from u_dw within w_contact_information
integer x = 1477
integer y = 1876
integer width = 1065
integer height = 360
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_contact_app"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;//Start Code Change ----02.03.2016 #V15 maha

if dwo.name = "p_note" then

	string ls_notes
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)
	
	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		This.SetItem( row, "notes", Message.StringParm )
	END IF
	this.update() 
end if
end event

type cb_add_note from commandbutton within w_contact_information
boolean visible = false
integer x = 2638
integer y = 68
integer width = 347
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Note"
end type

event clicked;string ls_note

openwithparm(w_ai_notes,"")

ls_note = message.stringparm

if ls_note = "Cancel" then
	return
else
	if ib_top then  //Start Code Change ----12.27.2012 #V12 maha
		mle_note. text = ls_note + "~r~n" + mle_note.text
	else
		mle_note. text = mle_note.text + "~r~n" + ls_note
	end if
end if
end event

type dw_app_addresses from u_dw within w_contact_information
integer x = 1477
integer y = 1020
integer width = 1065
integer height = 752
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_contact_application"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;//Start Code Change ----02.03.2016 #V15 maha

if dwo.name = "p_note" then

	string ls_notes
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)
	
	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		This.SetItem( row, "notes", Message.StringParm )
	END IF
	this.update() 
end if
end event

type dw_practice_addresses from u_dw within w_contact_information
integer x = 96
integer y = 308
integer width = 1230
integer height = 1932
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_contact_prac_address"
borderstyle borderstyle = stylebox!
end type

type gb_client from groupbox within w_contact_information
integer x = 1435
integer y = 236
integer width = 1157
integer height = 696
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Client/Facility Contact Information"
end type

type gb_payor from groupbox within w_contact_information
integer x = 1435
integer y = 956
integer width = 1157
integer height = 844
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Organization Contact Information"
end type

type gb_1 from groupbox within w_contact_information
integer x = 46
integer y = 236
integer width = 1326
integer height = 2044
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Practice Address Contact Information"
end type

type dw_facility from u_dw within w_contact_information
integer x = 1477
integer y = 304
integer width = 1065
integer height = 592
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_contact_facility"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type gb_2 from groupbox within w_contact_information
integer x = 41
integer y = 20
integer width = 2551
integer height = 180
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Provider Info"
end type

type gb_3 from groupbox within w_contact_information
integer x = 2624
integer y = 180
integer width = 1170
integer height = 2092
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Action Notes"
end type

type gb_4 from groupbox within w_contact_information
integer x = 1435
integer y = 1820
integer width = 1157
integer height = 452
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Payor/Application Contact Information"
end type

