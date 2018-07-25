$PBExportHeader$w_fax_win.srw
forward
global type w_fax_win from w_response
end type
type ole_mail from u_email_edit within w_fax_win
end type
type sle_2 from singlelineedit within w_fax_win
end type
type sle_1 from singlelineedit within w_fax_win
end type
type cb_cc from commandbutton within w_fax_win
end type
type sle_cover from singlelineedit within w_fax_win
end type
type st_cover from statictext within w_fax_win
end type
type sle_subject from singlelineedit within w_fax_win
end type
type st_text from statictext within w_fax_win
end type
type cb_fax from commandbutton within w_fax_win
end type
type cb_cancel from commandbutton within w_fax_win
end type
type cb_browse from commandbutton within w_fax_win
end type
type gb_1 from groupbox within w_fax_win
end type
type dw_select_template from u_dw within w_fax_win
end type
type dw_user_facility_list from datawindow within w_fax_win
end type
type sle_company from singlelineedit within w_fax_win
end type
type sle_recipient from singlelineedit within w_fax_win
end type
type st_company from statictext within w_fax_win
end type
type st_recipient from statictext within w_fax_win
end type
type st_fax from statictext within w_fax_win
end type
type em_fax from editmask within w_fax_win
end type
type dw_template from u_dw within w_fax_win
end type
type st_sub from statictext within w_fax_win
end type
type mle_cover_text from multilineedit within w_fax_win
end type
type st_cc from statictext within w_fax_win
end type
type sle_cc from singlelineedit within w_fax_win
end type
end forward

global type w_fax_win from w_response
integer x = 850
integer y = 416
integer width = 2953
integer height = 2780
string title = "Fax"
boolean controlmenu = false
long backcolor = 33551856
ole_mail ole_mail
sle_2 sle_2
sle_1 sle_1
cb_cc cb_cc
sle_cover sle_cover
st_cover st_cover
sle_subject sle_subject
st_text st_text
cb_fax cb_fax
cb_cancel cb_cancel
cb_browse cb_browse
gb_1 gb_1
dw_select_template dw_select_template
dw_user_facility_list dw_user_facility_list
sle_company sle_company
sle_recipient sle_recipient
st_company st_company
st_recipient st_recipient
st_fax st_fax
em_fax em_fax
dw_template dw_template
st_sub st_sub
mle_cover_text mle_cover_text
st_cc st_cc
sle_cc sle_cc
end type
global w_fax_win w_fax_win

type variables
Integer ii_fax_type //1:WinFax,2:MSFax
String is_output_type //Added By Ken.Guo 04.28.2008
string is_EmailType = "Easymail!" //Added by  Nova 11.25.2010
end variables

forward prototypes
public subroutine of_getemailmessage (integer al_email_id, ref blob ablb_message)
end prototypes

public subroutine of_getemailmessage (integer al_email_id, ref blob ablb_message);long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000

SELECT Datalength(wf_email.Email_Message)
  INTO :ll_DataLen
  FROM wf_email
 WHERE wf_email.email_id = :al_EMail_Id;

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(Email_Message,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM wf_email
		     WHERE wf_email.email_id = :al_EMail_Id;
		
		ablb_Message += lb_Temp
	next
else
	SELECTBLOB Email_Message
	      INTO :ablb_Message
	      FROM wf_email
	     WHERE wf_email.email_id = :al_EMail_Id;
end if

//long al_email_id
//blob ablb_message
end subroutine

on w_fax_win.create
int iCurrent
call super::create
this.ole_mail=create ole_mail
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_cc=create cb_cc
this.sle_cover=create sle_cover
this.st_cover=create st_cover
this.sle_subject=create sle_subject
this.st_text=create st_text
this.cb_fax=create cb_fax
this.cb_cancel=create cb_cancel
this.cb_browse=create cb_browse
this.gb_1=create gb_1
this.dw_select_template=create dw_select_template
this.dw_user_facility_list=create dw_user_facility_list
this.sle_company=create sle_company
this.sle_recipient=create sle_recipient
this.st_company=create st_company
this.st_recipient=create st_recipient
this.st_fax=create st_fax
this.em_fax=create em_fax
this.dw_template=create dw_template
this.st_sub=create st_sub
this.mle_cover_text=create mle_cover_text
this.st_cc=create st_cc
this.sle_cc=create sle_cc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_mail
this.Control[iCurrent+2]=this.sle_2
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.cb_cc
this.Control[iCurrent+5]=this.sle_cover
this.Control[iCurrent+6]=this.st_cover
this.Control[iCurrent+7]=this.sle_subject
this.Control[iCurrent+8]=this.st_text
this.Control[iCurrent+9]=this.cb_fax
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.cb_browse
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.dw_select_template
this.Control[iCurrent+14]=this.dw_user_facility_list
this.Control[iCurrent+15]=this.sle_company
this.Control[iCurrent+16]=this.sle_recipient
this.Control[iCurrent+17]=this.st_company
this.Control[iCurrent+18]=this.st_recipient
this.Control[iCurrent+19]=this.st_fax
this.Control[iCurrent+20]=this.em_fax
this.Control[iCurrent+21]=this.dw_template
this.Control[iCurrent+22]=this.st_sub
this.Control[iCurrent+23]=this.mle_cover_text
this.Control[iCurrent+24]=this.st_cc
this.Control[iCurrent+25]=this.sle_cc
end on

on w_fax_win.destroy
call super::destroy
destroy(this.ole_mail)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_cc)
destroy(this.sle_cover)
destroy(this.st_cover)
destroy(this.sle_subject)
destroy(this.st_text)
destroy(this.cb_fax)
destroy(this.cb_cancel)
destroy(this.cb_browse)
destroy(this.gb_1)
destroy(this.dw_select_template)
destroy(this.dw_user_facility_list)
destroy(this.sle_company)
destroy(this.sle_recipient)
destroy(this.st_company)
destroy(this.st_recipient)
destroy(this.st_fax)
destroy(this.em_fax)
destroy(this.dw_template)
destroy(this.st_sub)
destroy(this.mle_cover_text)
destroy(this.st_cc)
destroy(this.sle_cc)
end on

event open;call super::open;DataWindowChild dwchild
String ls_open_from
//String ls_output_type
Integer li_found
Integer i
Integer li_rc
Integer li_template_id
Integer li_facility_access[]
string ls_template //maha 07.13.2011
String ls_accept_reject //Added by Appeon long.zhang 07.04.2017 (v15.4 WebView Email Notifications)

//sle_cc.Visible = False
//st_cc.Visible = False

ls_open_from = Message.StringParm


IF PosA( ls_open_from, "-" ) > 0 THEN
	is_output_type = "Email"
	ls_open_from = MidA( ls_open_from, 1, PosA( ls_open_from, "-")-1 )
	This.Title = "Email"
	cb_fax.Text = "Email"
	
	cb_browse.Visible = False
	//--------Begin Added by Nova 11.25.2010------------------------
	if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
		is_EmailType = "Outlook!"
		ole_mail.Hide()
		mle_cover_text.Show()
		st_text.Text = "Email Text (Ctrl Enter for new line)"
	ELSE
		is_EmailType = "Easymail!"
		ole_mail.Show()
		mle_cover_text.Hide()
		ole_mail.of_Open()
		ole_mail.SetFocus()
		st_text.Text = "Email"
	END IF
	//--------End Added --------------------------------------------
	sle_cover.Visible = False
	st_cover.Visible = False
	
	//sle_cover.Text = False
	//st_cover.Text = "Email Address" 
	
	cb_cancel.Y = cb_cancel.Y - 125
	cb_fax.Y = cb_fax.Y - 125
	cb_browse.Y = cb_browse.Y - 125
	
	st_sub.Y = dw_select_template.y + 110	 
	sle_subject.Y = st_sub.Y + 72
	
	st_cc.Y = sle_subject.Y + 110	 
	sle_cc.Y = st_cc.Y + 72
	cb_cc.Y = sle_cc.Y //(Appeon)Stephen 07.02.2013 - Feature Request 3483
	
//	st_sub.Y = st_sub.Y - 192
//	sle_subject.Y = sle_subject.Y - 192
	
	st_text.Y = st_text.Y - 125
	mle_cover_text.Y = mle_cover_text.Y - 125
	
	This.Height = This.Height - 100 //170 //192//modified by  Nova 11.25.2010
	//--------Begin Added by Nova 11.25.2010------------------------
	ole_mail.Y = ole_mail.Y - 125
	dw_template.DataObject = "d_email_temp_by_id"
	//--------End Added --------------------------------------------
	
	//-------------appeon begin----------------------
//<$>added:long.zhang 01.22.2014
//<$>reason:Bug # 3849 Email text label is truncated
	if is_EmailType = "Outlook!" then
		sle_cc.y -= 15
		cb_cc.y -= 15
		st_text.y += 35
	end if	
	//-------------appeon End------------------------
	
ELSE
	is_output_type = "Fax"
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05/29/2007 By: Ken.Guo
	//$<reason> 
	ii_fax_type = gds_settings.GetItemNumber(1,'set_52')
	IF ii_fax_type = 1 THEN
		This.Title = 'WinFax'
	ELSE
		This.Title = 'MSFax'
	END IF
	//---------------------------- APPEON END ----------------------------
	
END IF

dw_template.SetTransObject( SQLCA )
//--------Begin Added by Nova 11.25.2010------------------------
IF is_output_type = "Email" THEN 
	dw_select_template.Modify("template_id.DDDW.Name='d_dddw_email_temp'")
	dw_select_template.Modify("template_id.DDDW.DataColumn='email_id'")
	dw_select_template.Modify("template_id.DDDW.DisplayColumn='email_name'")
ELSE
//--------End Added --------------------------------------------
	dw_user_facility_list.SetTransObject( SQLCA )
	dw_user_facility_list.Retrieve( gs_user_id )
	
	li_rc = dw_user_facility_list.RowCount( )
	FOR i = 1 To li_rc
		li_facility_access[ i ] = dw_user_facility_list.GetItemNumber( i, "user_facility_id" )
	NEXT
END IF

dw_select_template.of_SetTransObject( SQLCA )
dw_select_template.InsertRow( 0 )
dw_select_template.GetChild( "template_id", dwchild )
//retrieve templates associated with facility that user has rights to.
dwchild.SetTransObject( SQLCA )
//--------Begin Added by Nova 11.25.2010------------------------
IF is_output_type = "Email" THEN 
	dwchild.Retrieve(  )
	
	//Filter templates by accept of reject, Added by Appeon long.zhang 07.03.2017 (v15.4 WebView Email Notifications)
	If ls_open_from = 'WV_AUDIT_EMAIL' Then 
		ls_accept_reject = MidA(Message.StringParm, PosA( Message.StringParm, "-") + 1, 1)
		If ls_accept_reject = 'A' Then
			dwchild.SetFilter('merge_type = 4')
		ElseIf ls_accept_reject = 'R' Then
			dwchild.SetFilter('merge_type = 5')
		Else
			Messagebox('w_fax_win', 'Unsupported Accept Reject Flag:' + String(ls_accept_reject) + '.')
			Return
		End If
		dwchild.Filter()
	End If
	
ELSE
//--------End Added --------------------------------------------	
	dwchild.Retrieve( li_facility_access )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04/28/2008 By: Ken.Guo
//$<reason> Filter template data with different fax type.
IF is_output_type = 'Fax'	THEN//Begin Added by Nova 11.25.2010
	sle_cc.Visible = False  //Start Code Change ----06.27.2013 #V14 maha
	st_cc.Visible = False
	cb_cc.visible = false //(Appeon)Stephen 07.02.2013 - Feature Request 3483
	dwchild.SetFilter('fax_type = ' + String(ii_fax_type))
	dwchild.Filter()
	CHOOSE CASE ls_open_from
		CASE 'Corro'
			li_found = dwchild.Find( "default_for_corro = 1", 1, 1000 )
		CASE 'Verif'
			li_found = dwchild.Find( "default_for_verif = 1", 1, 1000 )
		CASE 'Apps'
			li_found = dwchild.Find( "default_for_apps = 1", 1, 1000 )
		CASE 'Image'
			li_found = dwchild.Find( "default_for_imaging = 1", 1, 1000 )
			
			//------------------- APPEON BEGIN -------------------
			//$<delete> Michael 26.07.2011
			//$<reason> Bug 2529 trying to fax SaaS & Windows
			//This.Height =2184+400// 2184 modified by nova 11.29.2010			
			//cb_cancel.Y = cb_cancel.Y + 540
			//	cb_fax.Y = cb_fax.Y + 540
			//------------------- APPEON end -------------------
			cb_browse.Y = cb_browse.Y + 540
			
			st_cover.Y = st_cover.Y + 540
			sle_cover.Y = sle_cover.Y + 540
			
			st_sub.Y = st_sub.Y + 540
			sle_subject.Y = sle_subject.Y + 540
			
			st_text.Y = st_text.Y + 540
			mle_cover_text.Y = mle_cover_text.Y + 540
	

			//------------------- APPEON BEGIN -------------------
			//$<add> Michael 26.07.2011
			//$<reason> Bug 2529 trying to fax SaaS & Windows
			ole_mail.height = ole_mail.height - 540
			mle_cover_text.height = mle_cover_text.height - 540
			//------------------- APPEON end -------------------
			
			sle_company.Visible = True
			st_company.Visible = True
			
			sle_recipient.Visible = True
			st_recipient.Visible = True
			
			em_fax.Visible = True
			st_fax.Visible = True
			
			
		CASE 'MissInfo'
			li_found = dwchild.Find( "default_for_miss_ltr = 1", 1, 1000 )
		CASE 'ExpAppt'
			li_found = dwchild.Find( "default_for_exp_appt = 1", 1, 1000 )
		CASE 'ExpLtr'
			li_found = dwchild.Find( "default_for_exp_ltrs = 1", 1, 1000 )
		CASE 'None'
	END CHOOSE
	
	IF ls_open_from <> "None" And li_found > 0 THEN
		li_template_id = dwchild.GetItemNumber( li_found, "fax_temp_id" )
		dw_select_template.SetText( String( li_template_id ) )
		dw_select_template.AcceptText()
	END IF
ELSE //--------Begin Added by Nova 11.25.2010------------------------
	debugbreak()
	IF dwchild.RowCount() > 0 THEN
		li_template_id = dwchild.GetItemNumber( 1, "email_id" )
		dw_select_template.SetText( String( li_template_id ) )
		dw_select_template.AcceptText()
	END IF
	//--------Begin Added by Nova 11.25.2010------------------------
	//Start Code Change ----07.13.2011 #V11 maha 
	if left(ls_open_from,4) = "OPPE" then
		ls_template  = mid(ls_open_from,5)
		li_found = dwchild.Find( "email_id = " + ls_template , 1, 1000 )
		if li_found > 0 then
			dw_select_template.SetText(  ls_template  )
			dw_select_template.AcceptText()
			//dw_select_template.setitem(1,"template_id",integer(ls_template))
		end if
	end if
		//End Code Change ----07.13.2011
END IF
//---------------------------- APPEON END ----------------------------






end event

event close;call super::close;ole_mail.of_close( )//Added by  Nova 11.25.2010
end event

type ole_mail from u_email_edit within w_fax_win
boolean visible = false
integer x = 73
integer y = 720
integer width = 2789
integer height = 1860
integer taborder = 100
string binarykey = "w_fax_win.win"
end type

type sle_2 from singlelineedit within w_fax_win
boolean visible = false
integer x = 2267
integer y = 232
integer width = 96
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_fax_win
boolean visible = false
integer x = 2258
integer y = 116
integer width = 101
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_cc from commandbutton within w_fax_win
integer x = 2171
integer y = 420
integer width = 110
integer height = 88
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "..."
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.02.2013 (Feature Request 3483)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
n_cst_outlook lnv_Outlook
string  ls_cc

lnv_Outlook.of_SelectXPContacts(sle_1, sle_cc, sle_2)
ls_cc = trim(sle_cc.text)

end event

type sle_cover from singlelineedit within w_fax_win
integer x = 489
integer y = 308
integer width = 1403
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_cover from statictext within w_fax_win
integer x = 498
integer y = 244
integer width = 517
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
boolean enabled = false
string text = "Cover Page Template"
boolean focusrectangle = false
end type

type sle_subject from singlelineedit within w_fax_win
integer x = 489
integer y = 496
integer width = 1673
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_text from statictext within w_fax_win
integer x = 64
integer y = 620
integer width = 974
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
boolean enabled = false
string text = "Cover Page Text (Ctrl Enter for new line)"
boolean focusrectangle = false
end type

type cb_fax from commandbutton within w_fax_win
integer x = 1243
integer y = 2584
integer width = 251
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Send Fax"
end type

event clicked;gs_pass_ids  lg_pass_ids

IF (sle_cover.Text = "" OR IsNull( sle_cover.Text )) AND This.Text <> 'Email' THEN
	MessageBox("Required Data Missing", "You must fill in the name of the cover page you want to use." )
	sle_cover.setfocus()
	Return -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10/15/2007 By: Ken.Guo
//$<reason> Check cover page file for Fax.
If Not FileExists (sle_cover.Text ) and This.Text <> 'Email'  Then
	Messagebox('Required Data Missing','Cover page file does not exist. Please select another cover page file.')
	Return -1
End If
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10/15/2007 By: Ken.Guo
//$<reason> Email and Fax need show difference message.
/*
IF mle_cover_text.Text = "" OR IsNull( mle_cover_text.Text ) THEN
	MessageBox("Required Data Missing", "You must fill in the cover page message." )
	mle_cover_text.setfocus()
	Return -1
END IF
*/
//--------Begin Modified by  Nova 11.25.2010------------------------
//IF (mle_cover_text.Text = "" OR IsNull( mle_cover_text.Text ) THEN
IF (mle_cover_text.Text = "" OR IsNull( mle_cover_text.Text )) and is_EmailType = "Outlook!" THEN
//--------End Modified --------------------------------------------
	If This.Text = 'Email'  Then
		MessageBox("Required Data Missing", "You must fill in the Email message." )
	Else
		MessageBox("Required Data Missing", "You must fill in the cover page message." )
	End If
	mle_cover_text.setfocus()
	Return -1
END IF
//---------------------------- APPEON END ----------------------------



IF sle_subject.Text = "" OR IsNull( sle_subject.Text ) THEN
	MessageBox("Required Data Missing", "You must fill in the subject text." )
	sle_subject.setfocus()
	Return -1
END IF

IF em_fax.Visible THEN
	IF sle_recipient.Text = "" OR IsNull( sle_recipient.Text ) THEN
		MessageBox("Required Data Missing", "You must fill in the Recipient text." )
		sle_recipient.setfocus()
		Return -1
	END IF

	IF em_fax.Text = "" OR IsNull( em_fax.Text ) THEN
		MessageBox("Required Data Missing", "You must have a fax number." )
		em_fax.setfocus()
		Return -1
	END IF
END IF

//Check contracts for Outlook, Added by Appeon long.zhang 12.19.2016 (IC - Email Issue)
If Trim(sle_cc.Text) <> ''  and gi_email_type = 1 and is_output_type = "Email" Then
	n_cst_outlook lnv_outlook
	If Not lnv_outlook.of_refreshcontracts(sle_1, sle_cc, sle_2) Then
		Return -1
	END IF
End If

lg_pass_ids.s_fax_cover = sle_cover.Text
lg_pass_ids.s_fax_message = mle_cover_text.Text
lg_pass_ids.s_fax_subject = sle_subject.Text
lg_pass_ids.s_fax_fax_number = em_fax.Text
lg_pass_ids.s_fax_recipient = sle_recipient.Text
lg_pass_ids.s_fax_company = sle_company.Text
lg_pass_ids.s_stringval = sle_cc.Text  //Start Code Change ----06.27.2013 #V14 maha

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 09.27.2011
//$<reason> Editing Fax Template while in process - Bug id 2668
blob lb_mess
if is_EmailType = 'Easymail!' and  is_output_type = "Email" then
	ole_mail.of_GetBlob(lb_mess)
	lg_pass_ids.b_attach = lb_mess
else
	setnull(lg_pass_ids.b_attach)
end if
//------------------- APPEON END -------------------

//--------Begin Added by Nova 11.25.2010------------------------
if dw_template.rowcount( )>0 AND is_output_type = "Email" then
	lg_pass_ids.email_id=dw_template.object.email_id[1]
end if
//--------End Added --------------------------------------------
CloseWithReturn( Parent, lg_pass_ids )
end event

type cb_cancel from commandbutton within w_fax_win
integer x = 1509
integer y = 2584
integer width = 251
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_browse from commandbutton within w_fax_win
integer x = 1920
integer y = 312
integer width = 242
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse.."
boolean cancel = true
end type

event clicked;string is_path
string docname, named
integer value


If ii_fax_type = 1 Then
	//WinFax
	value = GetFileOpenName("Select File", docname, named, "CVP", "Cover Page Files (*.CVP),*.CVP")
Else
	//MSFax //Added By Ken.Guo 04.28.2008
	value = GetFileOpenName("Select File", docname, named, "COV", "Cover Page Files (*.COV),*.COV")
End If
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
IF value > 0 THEN
	sle_cover.Text = docname 
END IF


end event

type gb_1 from groupbox within w_fax_win
integer x = 457
integer y = 20
integer width = 1449
integer height = 184
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Template"
end type

type dw_select_template from u_dw within w_fax_win
integer x = 489
integer y = 84
integer width = 1381
integer height = 84
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_select_fax_template"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;This.of_SetUpdateable( False )
end event

event itemchanged;call super::itemchanged;dw_template.Retrieve( Long( Data ) )
//--------Begin Added by Nova 11.25.2010------------------------
IF is_output_type = "Email" THEN 
	Blob lblb_Message
	IF is_EmailType = "Easymail!" THEN 
		of_GetEMailMessage(Long( Data ),lblb_Message)
		ole_mail.setredraw( false)
		ole_mail.of_Open(lblb_Message)
		ole_mail.setredraw( true)
	ELSE
		mle_cover_text.Text = dw_template.GetItemString( 1, "email_msg" )
	END IF
	sle_subject.Text = dw_template.GetItemString( 1, "subject" )
	sle_cc.text = dw_template.GetItemString( 1, "cc_recip" )
ELSE
//--------End Added --------------------------------------------	
	sle_subject.Text = dw_template.GetItemString( 1, "subject_text" )
	//sle_cover.Text = dw_template.GetItemString( 1, "cover_sheet" )
	mle_cover_text.Text = dw_template.GetItemString( 1, "cover_message" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05/29/2007 By: Ken.Guo
	//$<reason> Auto generate the cover page from DB to local
	Long ll_temp_id
	String ls_image_path,ls_pathname,ls_filename
	Blob lblob_coverfile
	Integer li_ret,li_pos
	
	//Email painter, need not cover page file.
	IF cb_fax.Text = "Email" THEN RETURN
	
	n_cst_filesrvwin32 nvo_file
	nvo_file = Create n_cst_filesrvwin32
	
	ll_temp_id = dw_template.GetItemNumber(1,'fax_temp_id')
	
	ls_image_path = gnv_data.of_getitem("ids" , "imaging_path" , False)
	IF ls_image_path = '' Or IsNull(ls_image_path) THEN ls_image_path = 'C:'
	IF Not DirectoryExists ( ls_image_path ) THEN
		CreateDirectory ( ls_image_path )
	END IF
	//Begin get file name ,For old data, That data have full path name.
	ls_filename = dw_template.GetItemString( 1, "cover_sheet" )
	li_pos = PosA(ls_filename,'\',1)
	DO WHILE li_pos > 0
		ls_filename = RightA(ls_filename,LenA(ls_filename) - li_pos)
		li_pos = PosA(ls_filename,'\',1)
	LOOP
	
	IF RightA(ls_image_path,1) = '\' THEN
		ls_pathname = ls_image_path + ls_filename
	ELSE
		ls_pathname = ls_image_path + '\' + ls_filename
	END IF
	
	
	SelectBlob cover_file Into :lblob_coverfile From sys_fax_template Where fax_temp_id = :ll_temp_id;
	IF LenA(lblob_coverfile) = 0 Or IsNull(lblob_coverfile) THEN
		//Messagebox('Fax','This template have no cover page,Please add it in Fax Template Painter.')
		MessageBox('Fax','This template has no cover page. Please add it in Fax Template Painter.')
		sle_cover.Text = ''
		RETURN
	END IF
	li_ret = nvo_file.of_filewrite( ls_pathname, lblob_coverfile, False)
	IF li_ret <> 1 THEN
		MessageBox('Cover Page','Failed to generate cover page.',Exclamation!)
		sle_cover.Text = ''
		RETURN
	END IF
	sle_cover.Text = ls_pathname
	
	Destroy nvo_file
END IF//Added by Nova 11.25.2010
//---------------------------- APPEON END ----------------------------
end event

type dw_user_facility_list from datawindow within w_fax_win
boolean visible = false
integer x = 1586
integer y = 72
integer width = 160
integer height = 100
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_user_facility_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_company from singlelineedit within w_fax_win
boolean visible = false
integer x = 489
integer y = 296
integer width = 1413
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_recipient from singlelineedit within w_fax_win
boolean visible = false
integer x = 489
integer y = 472
integer width = 1413
integer height = 96
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_company from statictext within w_fax_win
boolean visible = false
integer x = 494
integer y = 224
integer width = 480
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
boolean enabled = false
string text = "Company"
boolean focusrectangle = false
end type

type st_recipient from statictext within w_fax_win
boolean visible = false
integer x = 498
integer y = 416
integer width = 480
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Recipient"
boolean focusrectangle = false
end type

type st_fax from statictext within w_fax_win
boolean visible = false
integer x = 498
integer y = 604
integer width = 480
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Fax Number"
boolean focusrectangle = false
end type

type em_fax from editmask within w_fax_win
boolean visible = false
integer x = 494
integer y = 668
integer width = 581
integer height = 96
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxxxxxxx"
end type

type dw_template from u_dw within w_fax_win
boolean visible = false
integer x = 2510
integer y = 152
integer width = 133
integer height = 912
integer taborder = 20
string dataobject = "d_fax_template"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;string is_path
string docname, named
integer value


value = GetFileOpenName("Select File", docname, named, "CVO", "Cover Page Files (*.CVP),*.CVP")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value > 0 THEN
	dw_template.SetItem( dw_template.GetRow( ), "cover_sheet", docname  )
END IF


end event

type st_sub from statictext within w_fax_win
integer x = 498
integer y = 432
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Subject"
boolean focusrectangle = false
end type

type mle_cover_text from multilineedit within w_fax_win
integer x = 64
integer y = 712
integer width = 2798
integer height = 1840
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_cc from statictext within w_fax_win
integer x = 489
integer y = 328
integer width = 480
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
boolean enabled = false
string text = "CC"
boolean focusrectangle = false
end type

type sle_cc from singlelineedit within w_fax_win
integer x = 489
integer y = 420
integer width = 1673
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = " "
borderstyle borderstyle = stylelowered!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
09w_fax_win.bin 
2300000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000081121d2001d2f49800000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000081121d2001d2f49881121d2001d2f4980000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00003f0c0000300f00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00003f0c0000300f00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19w_fax_win.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
