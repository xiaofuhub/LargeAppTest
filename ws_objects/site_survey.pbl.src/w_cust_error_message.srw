$PBExportHeader$w_cust_error_message.srw
forward
global type w_cust_error_message from w_cust_message
end type
type st_error from statictext within w_cust_error_message
end type
type st_add from statictext within w_cust_error_message
end type
type st_representation from statictext within w_cust_error_message
end type
type st_cause from statictext within w_cust_error_message
end type
type p_4 from picture within w_cust_error_message
end type
type p_5 from picture within w_cust_error_message
end type
end forward

global type w_cust_error_message from w_cust_message
integer height = 704
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_error st_error
st_add st_add
st_representation st_representation
st_cause st_cause
p_4 p_4
p_5 p_5
end type
global w_cust_error_message w_cust_error_message

forward prototypes
public subroutine f_showmessage (string as_title, string as_error, string as_representation, string as_cause)
end prototypes

public subroutine f_showmessage (string as_title, string as_error, string as_representation, string as_cause);this.title=as_title
//---------Begin Modified by (Appeon)Eugene 06.27.2013 for V141 ISG-CLX--------
  /*
	st_error.text=as_representation
	st_representation.text=as_cause
	
	st_cause.text=as_error      
  */
String ls_wf_name

if IsNull(gs_CurAddresser) or Trim(gs_CurAddresser) = "" then gs_CurAddresser = gs_user_id

This.title             = as_title + "(Addresser: " + gs_CurAddresser + ")"
st_error.text          = as_representation
st_representation.text = as_cause
st_cause.text          = as_error

gs_CurAddresser = ""

//Added By Ken.Guo 2009-10-13. show contract info in email error 
String ls_email_info
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
		st_error.text += " (" + Left(ls_email_info,Len(ls_email_info) - 2) + ". )"
	End If
End If
//---------End Modfiied ------------------------------------------------------------------




end subroutine

on w_cust_error_message.create
int iCurrent
call super::create
this.st_error=create st_error
this.st_add=create st_add
this.st_representation=create st_representation
this.st_cause=create st_cause
this.p_4=create p_4
this.p_5=create p_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_error
this.Control[iCurrent+2]=this.st_add
this.Control[iCurrent+3]=this.st_representation
this.Control[iCurrent+4]=this.st_cause
this.Control[iCurrent+5]=this.p_4
this.Control[iCurrent+6]=this.p_5
end on

on w_cust_error_message.destroy
call super::destroy
destroy(this.st_error)
destroy(this.st_add)
destroy(this.st_representation)
destroy(this.st_cause)
destroy(this.p_4)
destroy(this.p_5)
end on

event open;call super::open;//add picturename
p_4.picturename=gs_current_path+"\"+"downright.bmp"
p_5.picturename=gs_current_path+"\"+"downright.bmp"
f_showmessage(iu_message.msgtitle,iu_message.msgtext,iu_message.msgrepresentation,iu_message.msgcause )
end event

type p_3 from w_cust_message`p_3 within w_cust_error_message
integer x = 82
integer y = 76
end type

type p_2 from w_cust_message`p_2 within w_cust_error_message
string powertiptext = "Copy this error message to Clipboard."
end type

event p_2::clicked;call super::clicked;Clipboard (st_error.text+'~r~n'+'Addtional information: '+'~r~n'+st_representation.text+'~r~n'+st_cause.text+'~r~n')
end event

type p_1 from w_cust_message`p_1 within w_cust_error_message
string powertiptext = "Additional information regarding this error message."
end type

type ln_1 from w_cust_message`ln_1 within w_cust_error_message
end type

type ln_2 from w_cust_message`ln_2 within w_cust_error_message
end type

type st_error from statictext within w_cust_error_message
integer x = 279
integer y = 36
integer width = 2240
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_add from statictext within w_cust_error_message
integer x = 297
integer y = 104
integer width = 2222
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Additional information: "
boolean focusrectangle = false
end type

type st_representation from statictext within w_cust_error_message
integer x = 393
integer y = 160
integer width = 2130
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_cause from statictext within w_cust_error_message
integer x = 485
integer y = 260
integer width = 2048
integer height = 232
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type p_4 from picture within w_cust_error_message
integer x = 283
integer y = 156
integer width = 82
integer height = 56
boolean bringtotop = true
boolean focusrectangle = false
end type

type p_5 from picture within w_cust_error_message
integer x = 379
integer y = 268
integer width = 82
integer height = 56
boolean bringtotop = true
boolean focusrectangle = false
end type

