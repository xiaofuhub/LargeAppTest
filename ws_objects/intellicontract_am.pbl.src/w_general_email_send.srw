$PBExportHeader$w_general_email_send.srw
forward
global type w_general_email_send from w_main
end type
type ole_message from u_email_edit within w_general_email_send
end type
type cb_clrattach from commandbutton within w_general_email_send
end type
type sle_sendcc from singlelineedit within w_general_email_send
end type
type cb_close from commandbutton within w_general_email_send
end type
type cb_send from commandbutton within w_general_email_send
end type
type cb_attach from commandbutton within w_general_email_send
end type
type sle_attach from singlelineedit within w_general_email_send
end type
type sle_subject from singlelineedit within w_general_email_send
end type
type st_subject from statictext within w_general_email_send
end type
type sle_sendbcc from singlelineedit within w_general_email_send
end type
type sle_sendto from singlelineedit within w_general_email_send
end type
type cb_sendbcc from commandbutton within w_general_email_send
end type
type cb_sendcc from commandbutton within w_general_email_send
end type
type cb_sendto from commandbutton within w_general_email_send
end type
end forward

global type w_general_email_send from w_main
integer x = 0
integer y = 0
integer width = 3625
integer height = 2304
string title = "New Mail Message"
windowstate windowstate = maximized!
long backcolor = 33551856
boolean center = true
ole_message ole_message
cb_clrattach cb_clrattach
sle_sendcc sle_sendcc
cb_close cb_close
cb_send cb_send
cb_attach cb_attach
sle_attach sle_attach
sle_subject sle_subject
st_subject st_subject
sle_sendbcc sle_sendbcc
sle_sendto sle_sendto
cb_sendbcc cb_sendbcc
cb_sendcc cb_sendcc
cb_sendto cb_sendto
end type
global w_general_email_send w_general_email_send

type variables
String	is_attach_file
long		il_Flag

end variables

forward prototypes
public subroutine of_seloccontacts ()
end prototypes

public subroutine of_seloccontacts ();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 29.08.2008 By: Evan
//$<reason> Fixed display name bug.
/*
Long ll_Cycle

mailSession 	lmSes
mailMessage 	lmMsg
mailReturnCode lmRet

lmSes = Create mailSession

lmRet = lmSes.mailLogon(mailNewSession!)
if lmRet <> mailReturnSuccess! then
    MessageBox("Mail", 'Logging in failed.')
    Return
End if

lmRet = lmSes.mailAddress(lmMsg)
if lmRet = mailReturnSuccess! then
	for ll_Cycle = 1 to UpperBound(lmMsg.recipient)
		if lmMsg.recipient[ll_Cycle].RecipientType = mailto! then
			if sle_Sendto.Text <> "" then sle_Sendto.Text += ';'
			sle_Sendto.Text += lmMsg.recipient[ll_Cycle].name
		elseif lmMsg.recipient[ll_Cycle].RecipientType = mailcc! then
			if sle_sendcc.Text <> "" then sle_sendcc.Text += ';'
			sle_sendcc.Text += lmMsg.recipient[ll_Cycle].name
		elseif lmMsg.recipient[ll_Cycle].RecipientType = mailbcc! then
			if sle_sendbcc.Text <> "" then sle_sendbcc.Text += ';'
			sle_sendbcc.Text += lmMsg.recipient[ll_Cycle].name
		End if
	Next
End if

lmSes.mailLogoff()

Destroy lmSes
*/
n_cst_outlook lnv_Outlook

//lnv_Outlook.of_SelectContacts(sle_sendto, sle_sendcc, sle_sendbcc) //Delete by Evan 08.30.2011
lnv_Outlook.of_SelectXpContacts(sle_sendto, sle_sendcc, sle_sendbcc) //(Appeon)Harry 06.10.2013 - V141 ISG-CLX
//---------------------------- APPEON END ----------------------------

end subroutine

on w_general_email_send.create
int iCurrent
call super::create
this.ole_message=create ole_message
this.cb_clrattach=create cb_clrattach
this.sle_sendcc=create sle_sendcc
this.cb_close=create cb_close
this.cb_send=create cb_send
this.cb_attach=create cb_attach
this.sle_attach=create sle_attach
this.sle_subject=create sle_subject
this.st_subject=create st_subject
this.sle_sendbcc=create sle_sendbcc
this.sle_sendto=create sle_sendto
this.cb_sendbcc=create cb_sendbcc
this.cb_sendcc=create cb_sendcc
this.cb_sendto=create cb_sendto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_message
this.Control[iCurrent+2]=this.cb_clrattach
this.Control[iCurrent+3]=this.sle_sendcc
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_send
this.Control[iCurrent+6]=this.cb_attach
this.Control[iCurrent+7]=this.sle_attach
this.Control[iCurrent+8]=this.sle_subject
this.Control[iCurrent+9]=this.st_subject
this.Control[iCurrent+10]=this.sle_sendbcc
this.Control[iCurrent+11]=this.sle_sendto
this.Control[iCurrent+12]=this.cb_sendbcc
this.Control[iCurrent+13]=this.cb_sendcc
this.Control[iCurrent+14]=this.cb_sendto
end on

on w_general_email_send.destroy
call super::destroy
destroy(this.ole_message)
destroy(this.cb_clrattach)
destroy(this.sle_sendcc)
destroy(this.cb_close)
destroy(this.cb_send)
destroy(this.cb_attach)
destroy(this.sle_attach)
destroy(this.sle_subject)
destroy(this.st_subject)
destroy(this.sle_sendbcc)
destroy(this.sle_sendto)
destroy(this.cb_sendbcc)
destroy(this.cb_sendcc)
destroy(this.cb_sendto)
end on

event close;call super::close;ole_Message.of_Close()

end event

event open;call super::open;Select flag Into :il_Flag From security_user_mailsetting Where user_id = :gs_user_id;

if il_Flag = 1 then
	ole_Message.of_Open(gs_user_id)
	ole_Message.of_inserttextfirst('~r~n~r~n~r~n')
else
	ole_Message.of_Open()
end if

//BEGIN---Modify by Evan 09/26/2008
try
	ole_message.object.ActiveDocument.ActiveWindow.Selection.GoTo(1, 1)
	
//	ole_message.object.ActiveDocument.ActiveWindow.View.Type = 6 //wdWebView
//	ole_message.object.ActiveDocument.ActiveWindow.DocumentMap = False	
catch(RuntimeError e)
end try
//END---Modify by Evan 09/26/2008
end event

event pfc_preopen;call super::pfc_preopen;of_SetResize(TRUE)
inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())

inv_resize.of_register(sle_sendto,inv_resize.SCALERIGHT)
inv_resize.of_register(sle_sendcc,inv_resize.SCALERIGHT)
inv_resize.of_register(sle_sendbcc,inv_resize.SCALERIGHT)
inv_resize.of_register(sle_subject,inv_resize.SCALERIGHT)
inv_resize.of_register(sle_attach,inv_resize.SCALERIGHT)
inv_resize.of_register(cb_clrattach,inv_resize.FIXEDRIGHT)

inv_resize.of_register(ole_message,inv_resize.SCALERIGHTBOTTOM)

 //Start Code Change ----02.21.2017 #V153 maha - moved buttons and removed scale
//inv_resize.of_register(cb_send,inv_resize.FIXEDRIGHTBOTTOM)
//inv_resize.of_register(cb_close,inv_resize.FIXEDRIGHTBOTTOM)


end event

event key;call super::key;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2009-01-05 By: Scofield
//$<Reason> Add Ctrl+Enter ShortCuts to Send email.

if KeyDown(KeyControl!) and KeyDown(KeyEnter!) then
	cb_Send.TriggerEvent(Clicked!)
end if
//---------------------------- APPEON END ----------------------------

end event

event activate;call super::activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_message ) Then
	ole_message.object.activate(true)
End If
end event

type ole_message from u_email_edit within w_general_email_send
integer x = 9
integer y = 648
integer width = 3579
integer height = 1548
integer taborder = 130
string binarykey = "w_general_email_send.win"
end type

type cb_clrattach from commandbutton within w_general_email_send
integer x = 3246
integer y = 432
integer width = 320
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Attach"
end type

event clicked;long	ll_Rtn

ll_Rtn = MessageBox(gnv_app.iapp_object.DisplayName, "Are you sure you want to delete the attachment?", Question!, YesNo!)

if ll_Rtn = 1 and Len(Trim(is_attach_file)) > 0 then
	is_attach_file = ""
	sle_attach.Text = ""
end if

end event

type sle_sendcc from singlelineedit within w_general_email_send
integer x = 398
integer y = 136
integer width = 3168
integer height = 76
integer taborder = 40
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

type cb_close from commandbutton within w_general_email_send
integer x = 398
integer y = 536
integer width = 343
integer height = 92
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)

end event

type cb_send from commandbutton within w_general_email_send
integer x = 27
integer y = 536
integer width = 343
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Send"
end type

event clicked;Long 		ll_Return

n_cst_easymail_smtp 	lnv_Mail

IF IsNull(sle_sendto.Text) Or Trim(sle_sendto.Text) = "" THEN
	MessageBox("Email Address required", "Email Address cannot be empty." )
	sle_sendto.SetFocus()
	RETURN -1
END IF

IF lnv_Mail.of_CreateObject() = -1 THEN
	//Added by Nova.zhang on 2008-11-07
	f_show_message('create Email object','','','','')
	//MessageBox("Error", "Failed to create email object!",StopSign!)
	RETURN -1
END IF

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
ll_Return = lnv_Mail.of_SendHtml(ls_Addresser, sle_sendto.text, sle_sendcc.text, sle_sendbcc.text,sle_subject.text, ole_message, is_attach_file,false)
*/
lnv_Mail.ib_combine_mail = false //Commented by (Appeon)Harry 06.10.2013 - V141 ISG-CLX
ll_Return = lnv_Mail.of_SendHtml(gs_user_Id, sle_sendto.Text, sle_sendcc.Text, sle_sendbcc.Text,sle_subject.Text, ole_message, is_attach_file,False)
//END---Modify by Evan 2008-03-24

IF ll_Return <> 0 THEN
	//Added by Nova.zhang on 2008-11-07
	//---------Begin Modified by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
	//f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	If lnv_Mail.is_sendprotocol = 'SMTP' Then
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	Else
		f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
	End If

	//---------End Modfiied ------------------------------------------------------
	//MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	lnv_Mail.of_DeleteObject()
	RETURN -1
END IF

lnv_Mail.of_DeleteObject()

Close(Parent)


end event

type cb_attach from commandbutton within w_general_email_send
integer x = 27
integer y = 432
integer width = 338
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Attach..."
end type

event clicked;long		ll_Rtn,ll_Cycle
string 	ls_FilePath, ls_FileName[], ls_attachment

n_cst_string 		lnv_string

SetPointer( HourGlass! )

gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
ll_Rtn = GetFileOpenName("Select File", ls_FilePath, ls_FileName, "DOC", "All Files (*.*), *.*")	
gf_save_dir_path(ls_FilePath) //Added by Ken.Guo on 2009-03-10
//ChangeDirectory(gs_current_path)

IF ll_Rtn = 1 THEN
	lnv_string.of_ArrayToString(ls_FileName,",",false,ls_attachment)
	
	IF Len(Trim(sle_attach.text)) > 0 Then
		sle_attach.text += "," + ls_attachment
	ELSE
		sle_attach.text = ls_attachment		
	END IF
	
	IF Upperbound(ls_FileName) = 1 THEN ls_FilePath = Left(ls_FilePath, LastPos(ls_FilePath ,"\") -1)
	
	FOR ll_Cycle = 1 to upperbound(ls_FileName)
		IF Len(Trim(is_attach_file)) > 0 Then
			is_attach_file += "," + ls_FilePath + "\" + ls_FileName[ll_Cycle]
		ELSE
			is_attach_file = ls_FilePath + "\" + ls_FileName[ll_Cycle]
		END IF			
	NEXT
END IF

end event

type sle_attach from singlelineedit within w_general_email_send
integer x = 398
integer y = 436
integer width = 2825
integer height = 76
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_subject from singlelineedit within w_general_email_send
integer x = 398
integer y = 336
integer width = 3168
integer height = 76
integer taborder = 70
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

type st_subject from statictext within w_general_email_send
integer x = 27
integer y = 344
integer width = 338
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
string text = "Subject:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_sendbcc from singlelineedit within w_general_email_send
integer x = 398
integer y = 236
integer width = 3168
integer height = 76
integer taborder = 60
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

type sle_sendto from singlelineedit within w_general_email_send
integer x = 398
integer y = 36
integer width = 3168
integer height = 76
integer taborder = 20
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

type cb_sendbcc from commandbutton within w_general_email_send
integer x = 27
integer y = 232
integer width = 338
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Bcc..."
end type

event clicked;of_SelOCContacts()

end event

type cb_sendcc from commandbutton within w_general_email_send
integer x = 27
integer y = 132
integer width = 338
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cc..."
end type

event clicked;of_SelOCContacts()

end event

type cb_sendto from commandbutton within w_general_email_send
integer x = 27
integer y = 32
integer width = 338
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "To..."
end type

event clicked;of_SelOCContacts()

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Bw_general_email_send.bin 
2900000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000008f6bc94001d28c4a00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000008f6bc94001d28c4a8f6bc94001d28c4a0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
26ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000050ed000027ff00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000050ed000027ff00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Bw_general_email_send.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
