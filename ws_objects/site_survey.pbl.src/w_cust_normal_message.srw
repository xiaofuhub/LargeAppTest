$PBExportHeader$w_cust_normal_message.srw
forward
global type w_cust_normal_message from w_cust_message
end type
type mle_message from multilineedit within w_cust_normal_message
end type
end forward

global type w_cust_normal_message from w_cust_message
mle_message mle_message
end type
global w_cust_normal_message w_cust_normal_message

forward prototypes
public subroutine f_show_message (string as_title, string as_text)
end prototypes

public subroutine f_show_message (string as_title, string as_text);this.title=as_title
mle_message.text=as_text

//---------Begin Added by (Appeon)Eugene 06.27.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 2009-10-13. show contract info in email error 
String ls_email_info,ls_wf_name
If gstr_email_info.ss_email_from <> '' Then
	If gstr_email_info.ss_email_from = 'Work Flow' Then
		ls_email_info += " Work Flow: "
		Select wf_name into :ls_wf_name From wf_workflow where wf_id = :gstr_email_info.sl_wf_id ;
		If Len(ls_wf_name) > 0 Then
			ls_email_info += ls_wf_name + ", "
		End If
	End If

	If gstr_email_info.sl_ctx_id > 0 Then
		ls_email_info += " Contract ID: " + String(gstr_email_info.sl_ctx_id) + ", "
	End If
	
	If gstr_email_info.ss_column_name <> '' Then
		If Upper(gstr_email_info.ss_email_from) = 'CTX_AM_ACTION_ITEM_ALARM' Then
			ls_email_info += " Field Name in DM Action Item: " + gstr_email_info.ss_column_name + ", "
		ElseIf Upper(gstr_email_info.ss_email_from) = 'CTX_ACTION_ITEM_ALARM' Then
			ls_email_info += " Field Name in Action Item: " + gstr_email_info.ss_column_name + ", "
		Else
			ls_email_info += " Field Name: " + gstr_email_info.ss_column_name + ", "
		End If		
	End If
	
	If gstr_email_info.sl_doc_id > 0 Then
		ls_email_info += " Document ID: " + String( gstr_email_info.sl_doc_id)
	End If
	 
	If len(ls_email_info) > 0 Then
		mle_message.text += " (" + Left(ls_email_info,Len(ls_email_info) - 2) + ". )"
	End If
End If
//---------End Added ------------------------------------------------------------------

end subroutine

on w_cust_normal_message.create
int iCurrent
call super::create
this.mle_message=create mle_message
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_message
end on

on w_cust_normal_message.destroy
call super::destroy
destroy(this.mle_message)
end on

event open;call super::open;f_show_message(iu_message.msgtitle,iu_message.msgtext )
end event

type p_3 from w_cust_message`p_3 within w_cust_normal_message
end type

type p_2 from w_cust_message`p_2 within w_cust_normal_message
string powertiptext = "Copy this error message to Clipboard."
end type

event p_2::clicked;call super::clicked;Clipboard (mle_message.text)
end event

type p_1 from w_cust_message`p_1 within w_cust_normal_message
string powertiptext = "Additional information regarding this error message."
end type

type ln_1 from w_cust_message`ln_1 within w_cust_normal_message
end type

type ln_2 from w_cust_message`ln_2 within w_cust_normal_message
end type

type mle_message from multilineedit within w_cust_normal_message
integer x = 357
integer y = 88
integer width = 2112
integer height = 356
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean border = false
boolean displayonly = true
end type

