$PBExportHeader$w_spiff.srw
$PBExportComments$addhoc.pbl - Opened by f_system_error_handler()
forward
global type w_spiff from window
end type
type cb_later from commandbutton within w_spiff
end type
type dw_error from u_dw within w_spiff
end type
type cb_mail from commandbutton within w_spiff
end type
type cb_continue from commandbutton within w_spiff
end type
type p_1 from picture within w_spiff
end type
end forward

global type w_spiff from window
integer x = 1659
integer y = 804
integer width = 3525
integer height = 2032
boolean titlebar = true
string title = "Reward Message"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 8388736
event ue_post_open ( )
cb_later cb_later
dw_error dw_error
cb_mail cb_mail
cb_continue cb_continue
p_1 p_1
end type
global w_spiff w_spiff

type prototypes
//FUNCTION ulong GetVersionExA( REF str_osversioninfo lpVersionInfo ) LIBRARY "kernel32.dll"
end prototypes

type variables
// Set at build time
string is_build_date_time
string is_message_text

end variables

forward prototypes
public subroutine wf_get_env ()
public function string of_create_text ()
public function integer of_setup_email (string as_subject, string as_notetext, string as_person[])
end prototypes

event ue_post_open();//
////setpointer(hourglass!)
//
//dw_error.insertrow( 0)
//
//if error.text = "" then error.text = 'Description unknown'
//
//dw_error.object.error_description[1]  = string(error.text)
//dw_error.object.object_event[1]       = string(error.objectevent)
//dw_error.object.line_no[1]            = string(error.line)
//dw_error.object.error_no[1]           = string(error.number)
//dw_error.object.object[1]             = string(error.object)
//dw_error.object.window_menu[1]        = string(error.windowmenu)
//
//// set the environment information
//
//wf_get_env()
//
//dw_error.object.dbms[1] =  sqlca.sqlreturndata
// 
////dw_error.object.logid[1] =  sqlca.logid 
//
//n_cst_platformwin32 lnvo
//lnvo = create  n_cst_platformwin32
//dw_error.object.computer_name[1] =  lnvo.of_getcomputername( )
//dw_error.object.user_id[1] =    lnvo.of_GetUserID ( )
//dw_error.object.mem_physical[1] = string(lnvo.of_GetPhysicalMemory ( )/1000000)
////dw_error.object.mem_physical[1] = string(lnvo.of_GetSystemDirectory ( ))
//dw_error.object.mem_virtual[1] = string(lnvo.of_GetFreeMemory ( )/1000000)
//dw_error.object.windows_dir[1] = lnvo.of_GetWindowsDirectory ( )
//
//dw_error.object.application_version[1] =   gnv_app.of_getversion( )
//
//dw_error.object.user_name[1] = gs_user_id
//dw_error.object.database[1] =  sqlca.dbparm
//
//if len(message.stringparm) > 0 then 
//     dw_error.object.error_description[1]  = message.stringparm
//	   dw_error.object.comments[1]  = message.stringparm 
//end if 
//
//
//of_create_text()
//
//if of_get_app_setting("set_12","I") =  1 then//Start Code Change ---- 04.13.2006 #390 maha
//	CONSTANT integer SUCCESS = 0
//	//CONSTANT integer ERROR = 1
//	CONSTANT integer WARNING = 2 
//	CONSTANT integer INFORMATION = 4
//	CONSTANT integer AUDIT_SUCCESS = 8
//	CONSTANT integer AUDIT_FAILURE = 16 
//	OLEObject    intellicred
//	intellicred = CREATE OLEObject
//	intellicred.ConnectToNewObject( "WScript.Shell" )
//	intellicred.LogEvent( 1, 'IntellIcred: '+ is_message_text )   
//	intellicred.DisconnectObject()
//	DESTROY intellicred
//end if
//
end event

public subroutine wf_get_env ();


string ls_temp
Environment lenv_app

if getEnvironment(lenv_app) = -1 then return 

CHOOSE CASE lenv_app.CPUtype
	CASE I386!
		ls_temp = 'Intel 386'
	CASE I486!
		ls_temp = 'Intel 486'
	CASE Pentium! 
		ls_temp = 'Intel Pentum'
	CASE else
		ls_temp = 'Other cpu'
END CHOOSE

dw_error.object.cpu[1] = ls_temp

// screen information
dw_error.object.screen_resolution[1] = string(lenv_app.screenwidth ) + " by " + string(lenv_app.screenheight )

ls_temp = ''

CHOOSE CASE lenv_app.osType
  CASE windows!
   CHOOSE CASE lenv_app.osMinorRevision
    CASE 0
     ls_temp += "95"
    CASE 10
     ls_temp += "98"
    CASE 90
    ls_temp += "Me"
   END CHOOSE

  CASE windowsNt!
   IF lenv_app.osMajorRevision = 4 THEN
     ls_temp += "NT4"
   ELSEIF lenv_app.osMinorRevision=0 THEN
     ls_temp += "2000"
   ELSEif lenv_app.osMinorRevision = 1 then
     ls_temp += "XP"
ELSE 
	ls_temp += "Unknown" 
   END IF
END CHOOSE

dw_error.object.windows_version[1] = ls_temp


if lenv_app.machinecode then
  ls_temp = 'Machine-Code'
else 
	ls_temp = 'Pseudo-Code'
end if

dw_error.object.pb_code[1] = ls_temp
dw_error.object.pb_type[1] = 'Professional'
dw_error.object.pb_version[1] =   string(lenv_app.pbmajorrevision) + '.' + string(lenv_app.pbminorrevision) + '.' + string(lenv_app.pbfixesrevision ) + " Build:" + string(lenv_app.pbbuildnumber)


end subroutine

public function string of_create_text ();/******************************************************************************************************************
**  [PUBLIC]   : of_create_text
**==================================================================================================================
**  Purpose   	: create the text for emailing 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


CONSTANT STRING NEW_LINE  			= '~r~n'
long   ll_i
string ls_column_name
String ls_col_header_name
string ls_col_value
string ls_address[]
string ls_message_text
is_message_text = ''
////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////
//invo_base.OF_SETRequestor( dw_error)

dw_error.accepttext( )

dw_error.inv_base.of_SetColumnDisplayNameStyle ( 2 )

for ll_i = 1 to long(dw_error.Object.DataWindow.Column.Count)
     	ls_column_name = 	dw_error.Describe("#" + string(ll_i) + ".Name")
		  
		if long(dw_error.Describe("#" + string(ll_i) + ".Visible ")) = 1 then 
			// get the text from the static text box 
			ls_col_header_name = dw_error.inv_base.OF_GETColumndisplayname(ls_column_name)
			// get the value from the column
			if ls_col_header_name  = "Database" then
			end if
			ls_col_value = dw_error.inv_base.of_getitem( 1, ls_column_name)
			// create the text for the message
			// get the length of ls_col_header_name
			long ll_col_header_name_len
			long ll_space_to_add
			ll_col_header_name_len = LenA(trim(ls_col_header_name))
			// add some spaces
			if ll_col_header_name_len > 0 then
				ll_space_to_add = 20 - ll_col_header_name_len
			else 
				ll_space_to_add = 20
			end if
			is_message_text = is_message_text + trim(ls_col_header_name) + space(ll_space_to_add)  + trim(ls_col_value)  + NEW_LINE
	end if 
		
next
return ""
end function

public function integer of_setup_email (string as_subject, string as_notetext, string as_person[]);/****************************************************************************************************************
** [PUBLIC] Function of_notify_error 
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**
**	[value] string as_subject      <Description>
**	[value] string as_notetext      <Description>
**--------------------------------------------------------------------------------------------------------------
** Returns:	(INTEGER) 
**--------------------------------------------------------------------------------------------------------------
** Author:	MSKINNER		
**--------------------------------------------------------------------------------------------------------------
** Modification Log:	
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
** 02 March 2006     mskinner 				moved the for loop to the top
**                                        added BOOLEAN LB_SHOW_MESSAGE
****************************************************************************************************************/

BOOLEAN LB_SHOW_MESSAGE = TRUE

String				ls_notesubject
String				ls_notetext
string 				ls_Recipient
string 				ls_userName
Integer				li_i
Integer				li_count
Integer				li_addresscount
Integer				li_rc
mailReturnCode		lmrc_mRet
mailMessage  		lmm_mMsg
mailSession  	ims_mSes		

// do not send message during development
//IF Handle(GetApplication()) = 0 THEN 
//	return success
//end if 


ims_mSes=  CREATE mailsession 
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.25.2006 By: LeiWei
//$<reason> 
lmrc_mRet = mailReturnSuccess!
//---------------------------- APPEON END ----------------------------

ims_mSes.mailLogon(mailNewSession!)
string ls_first_name,ls_first_nameA
string  ls_last_name

// start code change --- 10.31.2005 MSKINNER
//if FileExists ( word_2003_pth ) then 
//			IF LB_SHOW_MESSAGE THEN 
//			   Messagebox('IntelliCred','Please allow the following email to be sent to IntellisoftGroup. This will allow us to better serve you, thank you.')
//			   LB_SHOW_MESSAGE = FALSE
//		   END IF
//end if 
// end   code change --- 10.31.2005 MSKINNER


If IsNull(ims_mSes) Or Not IsValid(ims_mSes) Then
	Messagebox("Mail Error", "A Mail connection  could no be made")
	Return 0
End If

FOR  li_i = 1 TO UPPERBOUND(as_person)
//////////////////////////////////////////////////////////////////////////////
// Populate the Message Recipients
//////////////////////////////////////////////////////////////////////////////

 
	lmm_mMsg.Recipient[li_i].Name = as_person[li_i]
	
	string ls_notetext1
	ls_notetext1 = as_notetext
	
	// Populate the Message Subject.
	lmm_mMsg.Subject = as_subject
	
	// Populate the Message Text. 
	lmm_mMsg.NoteText = ls_notetext1
NEXT		
	
	// Send the mail.
	lmrc_mRet = ims_mSes.mailSend ( lmm_mMsg )
	
	// Check for a succesful Send Mail.
	If lmrc_mRet <> mailReturnSuccess! Then
		Messagebox("Mail Error", "The mail was not properly sent.")
		Return -1
	End If

destroy ims_mSes
Return 1
end function

on w_spiff.create
this.cb_later=create cb_later
this.dw_error=create dw_error
this.cb_mail=create cb_mail
this.cb_continue=create cb_continue
this.p_1=create p_1
this.Control[]={this.cb_later,&
this.dw_error,&
this.cb_mail,&
this.cb_continue,&
this.p_1}
end on

on w_spiff.destroy
destroy(this.cb_later)
destroy(this.dw_error)
destroy(this.cb_mail)
destroy(this.cb_continue)
destroy(this.p_1)
end on

event open;integer i
//  this.PostEvent( "ue_post_open" )

i = message.doubleparm

this.backcolor = rgb(200,200,250)
dw_error.Object.DataWindow.Color =  rgb(200,200,250)

dw_error.settransobject(sqlca)
dw_error.retrieve(i)




return

end event

type cb_later from commandbutton within w_spiff
integer x = 1527
integer y = 1792
integer width = 512
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ask me later Today"
end type

event clicked;



dw_error.accepttext( )
string ls_address[]
//skinner 02 March 2006 - begin
//Start Code Change ---- 10.31.2006 #1 maha added bob and stan
ls_address[1] =  'supportteam@intellisoftgroup.com' //Start Code Change ---- 11.12.2007 #V7 maha changed notification address
ls_address[2] =  'Intellisoftdev@intellisoftgroup.com' //Start Code Change ---- 06.09.2007 #V81 maha changed notification address
//ls_address[3] =  'support@contractlogix.com'  //Start Code Change ----11.21.2008 #V85 maha - removed 01.05.2009
//ls_address[2] =  'smurphy@intellisoftgroup.com'
//ls_address[3] =  'rgoemans@intellisoftgroup.com'
//ls_address[4] =  'bward@intellisoftgroup.com' //Start Code Change ---- 03.13.2007 #V7 maha
//skinner 02 March 2006 - end 

string ls_send_header
if LenA(message.stringparm) > 0 then 
	ls_send_header = 'Database Error Requires Your Attention'
  else 
	ls_send_header ='System Error Requires Your Attention'
end if

of_create_text()

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

type dw_error from u_dw within w_spiff
integer x = 379
integer y = 436
integer width = 2784
integer height = 940
integer taborder = 20
string dataobject = "d_spiff_display"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type cb_mail from commandbutton within w_spiff
integer x = 951
integer y = 1792
integer width = 512
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "EMail Entry"
end type

event clicked;



dw_error.accepttext( )
string ls_address[]
//skinner 02 March 2006 - begin
//Start Code Change ---- 10.31.2006 #1 maha added bob and stan
ls_address[1] =  'supportteam@intellisoftgroup.com' //Start Code Change ---- 11.12.2007 #V7 maha changed notification address
ls_address[2] =  'Intellisoftdev@intellisoftgroup.com' //Start Code Change ---- 06.09.2007 #V81 maha changed notification address
//ls_address[3] =  'support@contractlogix.com'  //Start Code Change ----11.21.2008 #V85 maha - removed 01.05.2009
//ls_address[2] =  'smurphy@intellisoftgroup.com'
//ls_address[3] =  'rgoemans@intellisoftgroup.com'
//ls_address[4] =  'bward@intellisoftgroup.com' //Start Code Change ---- 03.13.2007 #V7 maha
//skinner 02 March 2006 - end 

string ls_send_header

ls_send_header = 'IntelliSoft reward entry'

is_message_text = ""
//of_create_text()

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

type cb_continue from commandbutton within w_spiff
string tag = "Click this to close the error window and continue operating the application"
integer x = 2094
integer y = 1788
integer width = 512
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "No Thanks"
end type

event clicked;close( parent )
end event

type p_1 from picture within w_spiff
integer x = 137
integer y = 136
integer width = 3200
integer height = 1588
string picturename = "C:\ISGDev\ver9.2\autum color.bmp"
boolean focusrectangle = false
end type

