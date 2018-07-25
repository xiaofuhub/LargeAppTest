$PBExportHeader$w_pill_email.srw
forward
global type w_pill_email from window
end type
type st_1 from statictext within w_pill_email
end type
type dw_error from u_dw within w_pill_email
end type
type cb_mail from commandbutton within w_pill_email
end type
type mle_1 from multilineedit within w_pill_email
end type
type cb_ok from commandbutton within w_pill_email
end type
end forward

global type w_pill_email from window
integer width = 2501
integer height = 1232
boolean titlebar = true
string title = "Expiration Alert"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
dw_error dw_error
cb_mail cb_mail
mle_1 mle_1
cb_ok cb_ok
end type
global w_pill_email w_pill_email

type variables
string is_message_text
string is_error_message
boolean ib_sub = false  //maha 04.21.2017
end variables

event open;is_error_message = message.stringparm

mle_1.text = gs_current_version + "~r~n~r~n" +  is_error_message

if pos(is_error_message, "Subscription",1) > 0 then ib_sub = true   //Start Code Change ----04.21.2017 #V154 maha
	

end event

on w_pill_email.create
this.st_1=create st_1
this.dw_error=create dw_error
this.cb_mail=create cb_mail
this.mle_1=create mle_1
this.cb_ok=create cb_ok
this.Control[]={this.st_1,&
this.dw_error,&
this.cb_mail,&
this.mle_1,&
this.cb_ok}
end on

on w_pill_email.destroy
destroy(this.st_1)
destroy(this.dw_error)
destroy(this.cb_mail)
destroy(this.mle_1)
destroy(this.cb_ok)
end on

type st_1 from statictext within w_pill_email
integer x = 64
integer y = 784
integer width = 2277
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Contact Support  at :support@intellisoftgroup.com  or  888-634-4464 Option 2"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_error from u_dw within w_pill_email
boolean visible = false
integer x = 2720
integer y = 1000
integer width = 293
integer height = 280
integer taborder = 20
end type

type cb_mail from commandbutton within w_pill_email
integer x = 105
integer y = 896
integer width = 512
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&EMail ISG Support"
end type

event clicked;//Start Code Change ----09.09.2009 #V92 maha - for Poison pill

string ls_address[]
string ls_send_header
string ls_text


dw_error.accepttext( )



ls_address[1] =  'support@intellisoftgroup.com' 
//ls_address[1] =  'maha@intellisoftgroup.com'

 //Start Code Change ----04.21.2017 #V154 maha - modified for subscription
if ib_sub then
	ls_send_header ='SUBSCRIPTION Expiration request for ' + gs_current_version
else
	ls_send_header ='Version Expiration request for ' + gs_current_version
end if
 //End Code Change ----04.21.2017 

ls_text = "This customer has received the following message regarding the above version:~r~r"


is_message_text = gnv_app.of_GetVersionLabel() + "~r~r" + ls_text + is_error_message
messagebox("",is_message_text )

dw_error.of_notify_error(ls_send_header, is_message_text, ls_address)


CONSTANT integer SUCCESS = 0
//CONSTANT integer ERROR = 1
CONSTANT integer WARNING = 2 
CONSTANT integer INFORMATION = 4
CONSTANT integer AUDIT_SUCCESS = 8
CONSTANT integer AUDIT_FAILURE = 16 
OLEObject    intellicred
intellicred = CREATE OLEObject
intellicred.ConnectToNewObject( "WScript.Shell" )
intellicred.LogEvent( 4, 'INTELLICRED ::: EMail sent by user' )   
intellicred.DisconnectObject()
DESTROY intellicred

return 0


PARENT.DW_error.event ue_save_pdf_for_mailing( )
PARENT.DW_error.event ue_mail('System Error','')
end event

type mle_1 from multilineedit within w_pill_email
integer x = 101
integer y = 64
integer width = 2258
integer height = 696
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Message"
alignment alignment = center!
end type

type cb_ok from commandbutton within w_pill_email
integer x = 1019
integer y = 900
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Continue"
end type

event clicked;close(parent)
end event

