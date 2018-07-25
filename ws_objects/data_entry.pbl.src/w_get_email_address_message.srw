$PBExportHeader$w_get_email_address_message.srw
forward
global type w_get_email_address_message from w_email_subject
end type
type dw_email from datawindow within w_get_email_address_message
end type
type cb_add from commandbutton within w_get_email_address_message
end type
type cb_4 from commandbutton within w_get_email_address_message
end type
type sle_subject from singlelineedit within w_get_email_address_message
end type
type st_3 from statictext within w_get_email_address_message
end type
type mle_address from multilineedit within w_get_email_address_message
end type
type ole_message from u_email_edit within w_get_email_address_message
end type
end forward

global type w_get_email_address_message from w_email_subject
integer width = 2866
integer height = 2232
boolean center = true
dw_email dw_email
cb_add cb_add
cb_4 cb_4
sle_subject sle_subject
st_3 st_3
mle_address mle_address
ole_message ole_message
end type
global w_get_email_address_message w_get_email_address_message

type variables
long il_Flag
integer ii_set_56=0
int ii_SendToCommittee = 0 //add Michael 02.09.2012 V12.1 meeting
end variables

on w_get_email_address_message.create
int iCurrent
call super::create
this.dw_email=create dw_email
this.cb_add=create cb_add
this.cb_4=create cb_4
this.sle_subject=create sle_subject
this.st_3=create st_3
this.mle_address=create mle_address
this.ole_message=create ole_message
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_email
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.sle_subject
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.mle_address
this.Control[iCurrent+7]=this.ole_message
end on

on w_get_email_address_message.destroy
call super::destroy
destroy(this.dw_email)
destroy(this.cb_add)
destroy(this.cb_4)
destroy(this.sle_subject)
destroy(this.st_3)
destroy(this.mle_address)
destroy(this.ole_message)
end on

event open;call super::open;//------------------- APPEON BEGIN -------------------
//$<add> Michael 02.09.2012
//$<reason> V12.1 meeting
string ls_parm
string ls_email_address,ls_meeting_link

ls_parm  = message.stringparm
if len(ls_parm) > 0 then
	ii_SendToCommittee = 1
	ls_email_address = MidA( ls_parm, 1, PosA( ls_parm, "|" ) -1)
	ls_meeting_link = MidA( ls_parm, PosA( ls_parm, "|" ) + 1,len(ls_parm))
end if
//------------------- APPEON END ---------------------

//------------------- APPEON BEGIN -------------------
//$<Add> Michael Huang 02.09.2011
//$<reason> V11.2-EmailModification

//ii_set_56 = of_get_app_setting("set_56","I")
ii_set_56  =   gi_email_type //Start Code Change ----12.11.2012 #V12 maha

if ii_set_56 = 1 then
	ole_message.visible = false
	mle_1.visible = true	
	mle_1. setfocus()
else
	mle_1.visible = false
	
	Select flag Into :il_Flag From security_user_mailsetting Where user_id = :gs_user_id;
	
	if il_Flag = 1 then
	ole_Message.of_Open(gs_user_id)
	ole_Message.of_inserttextfirst('~r~n~r~n~r~n')
	else
	ole_Message.of_Open()
	end if
	
	try
	ole_message.object.ActiveDocument.ActiveWindow.Selection.GoTo(1, 1)
	catch(RuntimeError e)
	end try

end if
//------------------- APPEON END ---------------------

//------------------- APPEON BEGIN -------------------
//$<add> Michael 02.09.2012
//$<reason> V12.1 meeting
if ii_SendToCommittee = 1 then
	dw_email.visible =false
	mle_address.visible = true
	cb_add.visible = false
	mle_address.text = ls_email_address
	sle_subject.text = 'Web View email link'
	if ii_set_56 = 1 then
		mle_1.text = ls_meeting_link
	else
//ole_Message.of_open(ls_meeting_link,false)
		ole_Message.of_inserttextfirst(ls_meeting_link)
	end if
else
	dw_email.visible =true
	mle_address.visible = false
	cb_add.visible = true
end if
//------------------- APPEON END ---------------------
end event

event close;call super::close;ole_Message.of_Close()

end event

type cb_2 from w_email_subject`cb_2 within w_get_email_address_message
integer x = 2231
integer y = 2012
integer width = 293
integer height = 96
integer taborder = 50
string text = "&Cancel"
end type

type cb_1 from w_email_subject`cb_1 within w_get_email_address_message
integer x = 1934
integer y = 2012
integer width = 293
integer height = 96
integer taborder = 40
string text = "&Ok"
end type

event cb_1::clicked;//IF IsNull( mle_1.Text ) or mle_1.Text = "" THEN
//	MessageBox("No Message", "Please enter a message." )
//	Return -1
//END IF
//
//CloseWithReturn( Parent, dw_email.GetText() + "*" + mle_1.Text + "**" + sle_subject.text)



//------------------- APPEON START ---------------------
//$<Add> Michael Huang 02.11.2011
//$<reason> V11.2-EmailModification

Long 	 ll_Return
String	 ls_send_to,ls_HtmlFile

dw_email.accepttext( )

//------------------- APPEON BEGIN -------------------
//$<modify> Michael 02.09.2012
//$<reason> V12.1 meeting
/*
IF IsNull( dw_email.GetText() ) THEN
	MessageBox("Invalid Email", "Invalid Email Entered." )
	Return -1
END IF
ls_send_to = dw_email.getitemstring(1,'email')
*/
if ii_SendToCommittee = 1 then
	ls_send_to = mle_address.text
else
	ls_send_to = dw_email.getitemstring(1,'email')
end if
//------------------- APPEON END ---------------------



IF IsNull(ls_send_to) Or Trim(ls_send_to) = "" THEN
	MessageBox("Email Address required", "Email Address cannot be empty." )
	dw_email.SetFocus()
	RETURN -1
END IF

IF ii_set_56 = 1 THEN
	//------------------- APPEON BEGIN -------------------
	//$<add> Michael 08.15.2011
	//$<reason>bug#2564 Message length must be greater than 1
	if IsNull(mle_1.Text) or len(mle_1.Text) < 2 then
		messagebox("Email Message", "Message length must be greater than 1." )
		return -1
	end if
	//------------------- APPEON END ---------------------
	CloseWithReturn( Parent,  /*dw_email.GetText()*/ls_send_to + "*" + mle_1.Text + "**" + sle_subject.text)//modify Michael 02.09.2012
ELSE
   //ls_HtmlFile = ole_message.of_GetHtmlFile() //Modify by Michael 08.02.2011 --- Fixed a bug2540 - Easy Mail not logging.
	ls_HtmlFile = ole_message.of_GetHtmlFile(1)
   CloseWithReturn( Parent, ls_send_to + "*" + ls_HtmlFile + "**" + sle_subject.text)
END IF

//------------------- APPEON END ---------------------
end event

type st_2 from w_email_subject`st_2 within w_get_email_address_message
integer x = 37
integer height = 64
string text = "Message"
end type

type mle_1 from w_email_subject`mle_1 within w_get_email_address_message
integer x = 37
integer y = 376
integer width = 2779
integer height = 1584
end type

type st_1 from w_email_subject`st_1 within w_get_email_address_message
integer x = 37
integer y = 52
integer width = 229
integer height = 60
string text = "Send To"
end type

type sle_1 from w_email_subject`sle_1 within w_get_email_address_message
boolean visible = false
integer x = 78
integer y = 708
end type

type dw_email from datawindow within w_get_email_address_message
integer x = 279
integer y = 28
integer width = 2281
integer height = 88
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_get_email"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject( sqlca )
This.InsertRow( 1 )
end event

type cb_add from commandbutton within w_get_email_address_message
integer x = 2587
integer y = 28
integer width = 229
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
boolean cancel = true
end type

event clicked;string mes

Open( w_add_email_contact_info )
IF Message.StringParm = "Cancel" THEN
	Return 
ELSE
	mes = Message.StringParm
	//dw_email.retrieve()
	//dw_email.insertrow(1)
	
	if LenA(mes) > 0 THEN dw_email.SetItem( 1, "email", mes ) //alfee 05.19.2010
	//dw_email.SetItem( 1, "email", Message.StringParm )
END IF
end event

type cb_4 from commandbutton within w_get_email_address_message
integer x = 2528
integer y = 2012
integer width = 293
integer height = 96
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
boolean cancel = true
end type

event clicked;MessageBox("Help", "To Edit or Delete an email go to the Lookup Painter and Select the Email Contacts lookup type.")
end event

type sle_subject from singlelineedit within w_get_email_address_message
integer x = 279
integer y = 184
integer width = 2533
integer height = 92
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

type st_3 from statictext within w_get_email_address_message
integer x = 37
integer y = 200
integer width = 229
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
string text = "Subject"
boolean focusrectangle = false
end type

type mle_address from multilineedit within w_get_email_address_message
boolean visible = false
integer x = 279
integer y = 28
integer width = 2533
integer height = 140
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean border = false
boolean vscrollbar = true
boolean autovscroll = true
end type

type ole_message from u_email_edit within w_get_email_address_message
integer x = 37
integer y = 376
integer width = 2784
integer height = 1608
integer taborder = 30
boolean bringtotop = true
borderstyle borderstyle = stylebox!
string binarykey = "w_get_email_address_message.win"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Dw_get_email_address_message.bin 
2400000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000618db8b001d12ed300000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000618db8b001d12ed3618db8b001d12ed30000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00003ef10000298c00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00003ef10000298c00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Dw_get_email_address_message.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
