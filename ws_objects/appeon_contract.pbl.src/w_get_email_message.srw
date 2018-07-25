$PBExportHeader$w_get_email_message.srw
forward
global type w_get_email_message from w_email_subject
end type
type sle_subject from singlelineedit within w_get_email_message
end type
type st_3 from statictext within w_get_email_message
end type
type st_4 from statictext within w_get_email_message
end type
type cb_attach from commandbutton within w_get_email_message
end type
type sle_sendto from singlelineedit within w_get_email_message
end type
type sle_attach from singlelineedit within w_get_email_message
end type
type cb_ic from commandbutton within w_get_email_message
end type
type cb_outlook from commandbutton within w_get_email_message
end type
type st_5 from statictext within w_get_email_message
end type
type cb_3 from commandbutton within w_get_email_message
end type
type cbx_create_action_item from checkbox within w_get_email_message
end type
end forward

global type w_get_email_message from w_email_subject
integer x = 0
integer y = 0
integer width = 2304
integer height = 1792
boolean center = true
sle_subject sle_subject
st_3 st_3
st_4 st_4
cb_attach cb_attach
sle_sendto sle_sendto
sle_attach sle_attach
cb_ic cb_ic
cb_outlook cb_outlook
st_5 st_5
cb_3 cb_3
cbx_create_action_item cbx_create_action_item
end type
global w_get_email_message w_get_email_message

type variables
Long il_ctx_id			//use for Attach parameter
String is_Sendtocc	//Set Mail Address at to/cc

//store file inforation for download.
Long il_image_id
Long il_Version
String is_FileName

//mailFileDescription nfile[]	//Store the Attachment
mailSession mSes
mailReturnCode mRet
mailMessage mMsg
mailFileDescription nfile[]

//the datawindow to send email of contract detail
datawindow idw_send

long il_contact_id

end variables

forward prototypes
public function integer of_change_addr ()
end prototypes

public function integer of_change_addr ();//Long i, ll_Pos, ll_Start
//Long j

//String ls_Attach
//String ls_email, ls_addr

////j = UpperBound(mMsg.recipient)
////Get Email address
//i = 1
//j = 0
//ll_Pos = 1
//ll_Start = 1
//ls_email = sle_sendto.text
//IF Len(ls_email) > 0 THEN
//	ls_email += ";"
//	ll_Pos = Pos(ls_email, ";", ll_Start)
//	Do
//		ls_addr = Mid(ls_email, ll_Start, ll_Pos - ll_Start)
//		
//		IF Len( ls_addr ) > 0 THEN
//			j++
//			IF is_Sendtocc = "TO" THEN
//				mMsg.recipient[j].RecipientType = mailto!
//			ELSE
//				mMsg.recipient[j].RecipientType = mailcc!
//			END IF
//			mMsg.recipient[j].name = ls_addr
//		END IF
//		ll_Start = ll_Pos + 1
//		ll_Pos = Pos(ls_email, ";", ll_Start)
//	Loop  While ll_Pos > 0
//END IF
//Send eMail
//ls_Attach = dw_attach.GetItemString(1, "Attach")
//ls_Attach = sle_attach.text
//IF IsNull(ls_Attach) THEN ls_Attach = ""
//CloseWithReturn( Parent, sle_sendto.Text + "*" + mle_1.Text + "**" + sle_subject.text + "***" + ls_Attach)
return 0
end function

on w_get_email_message.create
int iCurrent
call super::create
this.sle_subject=create sle_subject
this.st_3=create st_3
this.st_4=create st_4
this.cb_attach=create cb_attach
this.sle_sendto=create sle_sendto
this.sle_attach=create sle_attach
this.cb_ic=create cb_ic
this.cb_outlook=create cb_outlook
this.st_5=create st_5
this.cb_3=create cb_3
this.cbx_create_action_item=create cbx_create_action_item
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_subject
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.cb_attach
this.Control[iCurrent+5]=this.sle_sendto
this.Control[iCurrent+6]=this.sle_attach
this.Control[iCurrent+7]=this.cb_ic
this.Control[iCurrent+8]=this.cb_outlook
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.cb_3
this.Control[iCurrent+11]=this.cbx_create_action_item
end on

on w_get_email_message.destroy
call super::destroy
destroy(this.sle_subject)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_attach)
destroy(this.sle_sendto)
destroy(this.sle_attach)
destroy(this.cb_ic)
destroy(this.cb_outlook)
destroy(this.st_5)
destroy(this.cb_3)
destroy(this.cbx_create_action_item)
end on

event open;/*
Long	ll_pos
String ls_Sendto

ls_Sendto = Message.StringParm
ll_pos = Pos(ls_Sendto, "*")
il_ctx_id = Long(Mid(ls_Sendto, ll_pos + 1))
sle_sendto.Text = Trim(Left(ls_Sendto, ll_pos - 1))
*/
IF isvalid(Message.PowerobjectParm) THEN
	idw_send = Message.PowerobjectParm
	il_ctx_id = idw_send.GetItemNumber(idw_send.GetRow(), "ctx_id")

	// Added Davis 11.08.2006
	il_contact_id = idw_send.GetItemNumber(idw_send.GetRow(), "contact_id")
	IF il_contact_id = 0 THEN Setnull(il_contact_id)
	// Added Davis 11.08.2006
	
	IF gs_dbtype <> "" THEN
		sle_sendto.Text = gs_dbtype
		
		mMsg.recipient[1].RecipientType = mailto!
		mMsg.recipient[1].name = gs_dbtype
	END IF
	
	sle_sendto.SetFocus()
Else
	IF Message.Doubleparm > 0 THEN
		il_ctx_id = Message.Doubleparm
		cb_ic.enabled = False
	END IF
END IF
end event

type cb_2 from w_email_subject`cb_2 within w_get_email_message
integer x = 1920
integer y = 1568
integer height = 84
integer taborder = 100
string text = "&Cancel"
end type

type cb_1 from w_email_subject`cb_1 within w_get_email_message
integer x = 1605
integer y = 1568
integer height = 84
integer taborder = 90
end type

event cb_1::clicked;IF IsNull(sle_sendto.Text) Or sle_sendto.Text = "" THEN
	MessageBox("Invalid Email", "Invalid Email Entered." )
	sle_sendto.SetFocus()
	RETURN -1
END IF
//IF IsNull( mle_1.Text ) or mle_1.Text = "" THEN
//	MessageBox("No Message", "Please enter a message." )
//	Return -1
//END IF

//DownLoad file from database according to the attach.

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10.19.2006 By: Davis
//$<reason> Fix a defect.
/*
mSes = create mailSession
mRet = mailReturnSuccess!
mRet = mSes.mailLogon( mailNewSession!) //maha modifed 042005
IF mRet <> mailReturnSuccess! THEN
	MessageBox("Mail", 'Logon failed.  Check to make sure you have an email id setup in the user painter.')		
	Return -3
END IF

mMsg.Subject = sle_subject.Text
mMsg.NoteText = mle_1.Text

mRet = mSes.mailSend(mMsg)

IF mRet <> mailReturnSuccess! THEN
	MessageBox("Mail Send", 'Mail not sent')
	mSes.mailLogoff()
	DESTROY mSes
	Return -4
END IF

mSes.mailLogoff()
DESTROY mSes
*/

Integer i

//For i = 1 TO UpperBound(mMsg.recipient[])
//	ls_address[i] = mMsg.recipient[i].name
//Next

n_cst_string lnv_string
String ls_MailTo,ls_MailCC
String ls_mailto_arry[],ls_mailcc_arry[]
String ls_address_mailto[],ls_address_mailcc[]
String ls_attachment
ls_MailTo = sle_sendto.Text //+ ";" + sle_1.text

lnv_string.of_parsetoarray( ls_MailTo, ";", ls_mailto_arry[])
lnv_string.of_parsetoarray( sle_1.Text, ";", ls_mailcc_arry[])

FOR i = 1 To UpperBound(ls_mailto_arry[])
	IF LenA(Trim(ls_mailto_arry[i])) > 0 THEN
		ls_address_mailto[UpperBound(ls_address_mailto) + 1] = ls_mailto_arry[i]
	END IF
NEXT

FOR i = 1 To UpperBound(ls_mailcc_arry[])
	IF LenA(Trim(ls_mailcc_arry[i])) > 0 THEN
		ls_address_mailcc[UpperBound(ls_address_mailcc) + 1] = ls_mailcc_arry[i]
	END IF
NEXT

FOR i = 1 To UpperBound(mMsg.AttachmentFile)
	IF i = 1 THEN
		ls_attachment = mMsg.AttachmentFile[i].Pathname
	ELSE
		ls_attachment += "," + mMsg.AttachmentFile[i].Pathname
	END IF
NEXT

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-21 By: Scofield
//$<Reason> Change the interface of send mail

Long		ll_Return,ll_Cycle

n_cst_easymail_smtp 	lnv_Mail

IF lnv_Mail.of_CreateObject() = -1 THEN
	//--------Begin Added by Nova 11.07.2008------------------------
	//MessageBox("Error", "Failed to create email object!",StopSign!)
	f_show_message('create Email object','','','','')
	//--------End Added --------------------------------------------
	RETURN -1
END IF

ls_MailTo = ""
ls_MailCC = ""

FOR ll_Cycle = 1 To UpperBound(ls_address_mailto)
	ls_MailTo += ls_address_mailto[ll_Cycle] + ";"
NEXT

FOR ll_Cycle = 1 To UpperBound(ls_address_mailcc)
	ls_MailCC += ls_address_mailcc[ll_Cycle] + ";"
NEXT

//START---Modify by Evan 2008-03-24 (Reasion:Send email with current user account)
/*
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-02-22 By: Scofield
//$<Reason> Get the Addresser's user id.

String	ls_Addresser

select top 1 set_addresser into :ls_Addresser from icred_settings;

if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
	ls_Addresser = gs_User_Id
end if
//---------------------------- APPEON END ----------------------------

//Send EMail
ll_Return = lnv_Mail.of_SendText(ls_Addresser, ls_MailTo, ls_MailCC, '', sle_subject.Text, mle_1.Text, ls_attachment)
*/
lnv_Mail.ib_combine_mail = false // add by Stephen 11.23.2011  V12.1-Fax modification
ll_Return = lnv_Mail.of_SendText(gs_user_id, ls_MailTo, ls_MailCC, '', sle_subject.Text, mle_1.Text, ls_attachment)
//END---Modify by Evan 2008-03-24

IF ll_Return = 0 THEN
	//IF inv_redemption_mail.of_start_email( ls_address_mailto,ls_address_mailcc, mle_1.Text, sle_subject.Text, ls_attachment) >=0 THEN
	//$<reason> 10.30.2006 By: Davis Begin
	//$<reason> System will create an action item with type: Email
	IF cbx_create_action_item.Checked THEN
		Long ll_ctx_id,ll_ctx_action_item_id,ll_action_type,ll_no_attempts,ll_action_status
		ll_ctx_id = il_ctx_id
		
		IF ll_ctx_id > 0 THEN
			ll_action_status = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('Complete')"))
			ll_action_type = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Action Type') and upper(code) = upper('Email')"))
			
			IF ll_action_status = 0 THEN SetNull(ll_action_status)
			IF ll_action_type = 0 THEN SetNull(ll_action_type)
			
			SELECT ctx_action_item_id, no_attempts
				INTO :ll_ctx_action_item_id, :ll_no_attempts
				FROM ctx_action_items
				Where ctx_id = :ll_ctx_id And action_user = :gs_user_id And action_type = :ll_action_type;
				
			IF IsNull(ll_ctx_action_item_id) Or ll_ctx_action_item_id = 0 THEN
				gnv_appeondb.of_autocommit( )
				INSERT INTO ctx_action_items(ctx_id,action_type,action_user,letter_flag,first_attempt,last_attempt,no_attempts,due_date,action_date,action_status,letter_to)
					Values(:ll_ctx_id,:ll_action_type,:gs_user_id,'N',getdate(),getdate(),1,getdate(),getdate(),:ll_action_status,:il_contact_id);
				COMMIT;
			ELSE
				IF IsNull(ll_no_attempts) THEN ll_no_attempts = 0
				ll_no_attempts ++
				
				gnv_appeondb.of_autocommit( )
				UPDATE ctx_action_items
					SET no_attempts = :ll_no_attempts, last_attempt = getdate(), letter_to = :il_contact_id
					Where ctx_id = :ll_ctx_id And action_user = :gs_user_id And action_type = :ll_action_type And ctx_action_item_id = :ll_ctx_action_item_id;
				COMMIT;
			END IF
		END IF
	END IF
	//$<reason> 10.30.2006 By: Davis End
ELSE
	//---------Begin Modified by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
	/*
	//--------Begin Added by Nova 11.07.2008------------------------
	//MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	f_show_message('error_code_'+String(ll_Return),'%1S%',String(ll_Return),'','')
	//--------End Added --------------------------------------------
	*/
	If lnv_Mail.is_sendprotocol = 'SMTP' Then
	   f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	Else
		f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
	End If
	//---------End Modfiied ------------------------------------------------------
	lnv_Mail.of_DeleteObject()
	RETURN -1
END IF

lnv_Mail.of_DeleteObject()
//---------------------------- APPEON END ----------------------------

//---------------------------- APPEON END ----------------------------

Close(Parent)

end event

type st_2 from w_email_subject`st_2 within w_get_email_message
integer y = 636
integer width = 311
integer height = 56
string text = "Message"
end type

type mle_1 from w_email_subject`mle_1 within w_get_email_message
integer y = 696
integer width = 2144
integer height = 844
integer taborder = 60
end type

type st_1 from w_email_subject`st_1 within w_get_email_message
integer x = 64
integer y = 12
integer width = 311
integer height = 56
string text = "To"
end type

type sle_1 from w_email_subject`sle_1 within w_get_email_message
integer x = 64
integer y = 228
integer width = 1810
integer taborder = 20
end type

event sle_1::getfocus;call super::getfocus;is_Sendtocc = "CC"
end event

type sle_subject from singlelineedit within w_get_email_message
integer x = 64
integer y = 384
integer width = 1810
integer height = 92
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

type st_3 from statictext within w_get_email_message
integer x = 64
integer y = 324
integer width = 311
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
string text = "Subject"
boolean focusrectangle = false
end type

type st_4 from statictext within w_get_email_message
integer x = 64
integer y = 480
integer width = 311
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
string text = "Attach"
boolean focusrectangle = false
end type

type cb_attach from commandbutton within w_get_email_message
integer x = 1893
integer y = 544
integer width = 315
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add Attach"
boolean cancel = true
end type

event clicked;OpenWithParm(w_get_attach, il_ctx_id)

Long i, j
mailMessage lmMsg

IF Message.StringParm = "Close" THEN RETURN

sle_attach.Text = ""
lmMsg = Message.PowerobjectParm

IF UpperBound(lmMsg.AttachmentFile) > 0 THEN
	mMsg.AttachmentFile = lmMsg.AttachmentFile

	j = UpperBound(mMsg.AttachmentFile)
	FOR i = 1 TO j
		sle_attach.Text += mMsg.AttachmentFile[i].FileName + ","
	NEXT
	
	sle_attach.Text = LeftA(sle_attach.Text, LenA(sle_attach.Text) - 1)
END IF
end event

type sle_sendto from singlelineedit within w_get_email_message
integer x = 64
integer y = 72
integer width = 1810
integer height = 92
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

event getfocus;is_Sendtocc = "TO"
end event

type sle_attach from singlelineedit within w_get_email_message
integer x = 64
integer y = 540
integer width = 1810
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_ic from commandbutton within w_get_email_message
integer x = 800
integer y = 1568
integer width = 343
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&IC Contacts "
end type

event clicked;String ls_email, ls_addr
str_pass lstr_pass
lstr_pass.s_u_dw = idw_send

IF Lower(ClassName(idw_send)) = 'dw_ccc' THEN
	lstr_pass.s_string = "EXTERNAL"
ELSE
	lstr_pass.s_string = "INTERNAL"
END IF

lstr_pass.l_facility_id = -999	//a sign

OpenWithParm ( w_contract_contact, lstr_pass)

ls_email = Message.StringParm
IF LenA(ls_email) < 1 THEN RETURN

IF is_Sendtocc = "TO" THEN
	IF sle_sendto.Text <> "" THEN sle_sendto.Text += ";"	
	sle_sendto.Text += ls_email
ELSE
	IF sle_1.Text <> "" THEN sle_1.Text += ";"	
	sle_1.Text += ls_email
END IF

Long i, ll_Pos, ll_Start
Long j

j = UpperBound(mMsg.recipient)

i = 1
ll_Pos = 1
ll_Start = 1
IF LenA(ls_email) > 0 THEN
	ls_email += ";"
	ll_Pos = PosA(ls_email, ";", ll_Start)
	Do
		ls_addr = MidA(ls_email, ll_Start, ll_Pos - ll_Start)
		
		IF LenA( ls_addr ) > 0 THEN
			j++
			IF is_Sendtocc = "TO" THEN
				mMsg.recipient[j].RecipientType = mailto!
			ELSE
				mMsg.recipient[j].RecipientType = mailcc!
			END IF
			mMsg.recipient[j].name = ls_addr
		END IF
		ll_Start = ll_Pos + 1
		ll_Pos = PosA(ls_email, ";", ll_Start)
	Loop  While ll_Pos > 0
END IF
end event

type cb_outlook from commandbutton within w_get_email_message
integer x = 1152
integer y = 1568
integer width = 443
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Outlook Contacts"
end type

event clicked;mailSession lmSes
mailReturnCode lmRet
mailMessage lmMsg

Long i, j

// Create a mail session
lmSes = CREATE mailSession

// Log on to the session
lmRet = lmSes.mailLogon(mailNewSession!)
IF lmRet <> mailReturnSuccess! THEN
    MessageBox("Mail", 'Logon failed.')
    RETURN
END IF

j = UpperBound(mMsg.recipient)

lmRet = lmSes.mailAddress(lmMsg)
IF lmRet = mailReturnSuccess! THEN
	For i = 1 To UpperBound(lmMsg.recipient)
		j++
		mMsg.recipient[j].RecipientType = lmMsg.recipient[i].RecipientType
		mMsg.recipient[j].name = lmMsg.recipient[i].name
		
		IF lmMsg.recipient[i].RecipientType = mailto! THEN
			IF sle_sendto.Text = "" THEN
				sle_sendto.Text = lmMsg.recipient[i].name
			ELSE
				sle_sendto.Text += ";" + lmMsg.recipient[i].name
			END IF
		ELSE
			IF sle_1.Text = "" THEN
				sle_1.Text = lmMsg.recipient[i].name
			ELSE
				sle_1.Text += ";" + lmMsg.recipient[i].name
			END IF
		END IF
	Next
END IF

lmSes.mailLogoff()

DESTROY lmSes
end event

type st_5 from statictext within w_get_email_message
integer x = 64
integer y = 168
integer width = 311
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
string text = "CC"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_get_email_message
integer x = 1893
integer y = 72
integer width = 315
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;mailMessage lmMsg
mMsg.recipient = lmMsg.recipient

sle_1.text = ""
sle_sendto.text = ""
end event

type cbx_create_action_item from checkbox within w_get_email_message
integer x = 64
integer y = 1576
integer width = 521
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Create Action Item:"
boolean lefttext = true
end type

