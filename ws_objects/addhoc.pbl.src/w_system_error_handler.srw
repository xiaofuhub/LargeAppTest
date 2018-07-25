$PBExportHeader$w_system_error_handler.srw
$PBExportComments$addhoc.pbl - Opened by f_system_error_handler()
forward
global type w_system_error_handler from window
end type
type dw_error from u_dw within w_system_error_handler
end type
type cb_mail from commandbutton within w_system_error_handler
end type
type cb_5 from commandbutton within w_system_error_handler
end type
type cb_print from commandbutton within w_system_error_handler
end type
type cb_clipboard from commandbutton within w_system_error_handler
end type
type cb_continue from commandbutton within w_system_error_handler
end type
type cb_halt_close from commandbutton within w_system_error_handler
end type
end forward

global type w_system_error_handler from window
integer x = 1659
integer y = 804
integer width = 3525
integer height = 1880
windowtype windowtype = response!
long backcolor = 33551856
event ue_post_open ( )
dw_error dw_error
cb_mail cb_mail
cb_5 cb_5
cb_print cb_print
cb_clipboard cb_clipboard
cb_continue cb_continue
cb_halt_close cb_halt_close
end type
global w_system_error_handler w_system_error_handler

type prototypes
//FUNCTION ulong GetVersionExA( REF str_osversioninfo lpVersionInfo ) LIBRARY "kernel32.dll"

//---------Begin Added by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
FUNCTION ulong GetVersion() LIBRARY "kernel32.dll"								//Added By Mark Lee 10/11/12
//---------End Added ------------------------------------------------------
end prototypes

type variables
// Set at build time
string is_build_date_time
string is_message_text

end variables

forward prototypes
public subroutine wf_get_env ()
public function string of_create_text ()
end prototypes

event ue_post_open();ulong ll_resource //maha 02.13.2014
ulong ll_totalmem //maha 02.13.2014

//setpointer(hourglass!)

dw_error.insertrow( 0)

if error.text = "" then error.text = 'Description unknown'

dw_error.object.error_description[1]  = string(error.text)
dw_error.object.object_event[1]       = string(error.objectevent)
dw_error.object.line_no[1]            = string(error.line)
dw_error.object.error_no[1]           = string(error.number)
dw_error.object.object[1]             = string(error.object)
dw_error.object.window_menu[1]        = string(error.windowmenu)

// set the environment information
//debugbreak()
wf_get_env()

dw_error.object.dbms[1] =  sqlca.sqlreturndata
 
//dw_error.object.logid[1] =  sqlca.logid 

n_cst_platformwin32 lnvo
lnvo = create  n_cst_platformwin32
dw_error.object.computer_name[1] =  lnvo.of_getcomputername( )
dw_error.object.user_id[1] =    lnvo.of_GetUserID ( )

//Start Code Change ----02.13.2014 #V14 maha
lnvo.of_getfreememory( ll_totalmem ,ll_resource)
dw_error.object.mem_physical[1] = string(ll_totalmem/1000) + " GB"
//dw_error.object.mem_physical[1] = string(lnvo.of_GetSystemDirectory ( ))
//dw_error.object.mem_virtual[1] = string(lnvo.of_GetFreeMemory ( ) /1000000)
dw_error.object.mem_virtual[1] = string(ll_resource/1000) + " GB"
//End Code Change ----02.13.2014
dw_error.object.windows_dir[1] = lnvo.of_GetWindowsDirectory ( )

dw_error.object.application_version[1] =   gnv_app.of_getversion( )

dw_error.object.user_name[1] = gs_user_id
dw_error.object.database[1] =  sqlca.dbparm

if LenA(message.stringparm) > 0 then 
     dw_error.object.error_description[1]  = message.stringparm
	   dw_error.object.comments[1]  = message.stringparm 
end if 


of_create_text()

if of_get_app_setting("set_12","I") =  1 then//Start Code Change ---- 04.13.2006 #390 maha
	CONSTANT integer SUCCESS = 0
	//CONSTANT integer ERROR = 1
	CONSTANT integer WARNING = 2 
	CONSTANT integer INFORMATION = 4
	CONSTANT integer AUDIT_SUCCESS = 8
	CONSTANT integer AUDIT_FAILURE = 16 
	OLEObject    intellicred
	intellicred = CREATE OLEObject
	intellicred.ConnectToNewObject( "WScript.Shell" )
	intellicred.LogEvent( 1, 'IntellIcred: '+ is_message_text )   
	intellicred.DisconnectObject()
	DESTROY intellicred
end if

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

//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
/*
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
*/
//Begin - Added By Mark Lee 10/11/12
long ll_ver
dec{2} ldc_winver
string ls_winver

ll_ver = GetVersion()
ldc_winver = mod(intlow(ll_ver),256) + Int(intlow(ll_ver)/256)/100
Choose Case ldc_winver
	case 3.10 
		 ls_temp += "Windows 3.x"
	case 4 
		 ls_temp += "Windows NT 4.0"
	case 4.10 
		 ls_temp += "Windows  98"
	case 5 
		 ls_temp += "Windows 2000"
	case 5.01 
		 ls_temp += "Windows XP"
	case 5.03 
		 ls_temp += "Windows 2003" 
	case 6
		 ls_temp += "Windows Vista"		 
	case 6.01 
		 ls_temp += "Windows 7"
    case 6.02 
		 ls_temp += "Windows 8"	
	Case else
		ls_temp += "Windows "+string(ldc_winver)
End Choose
//End - Added By Mark Lee 10/11/12
//---------End Modfiied ------------------------------------------------------

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

on w_system_error_handler.create
this.dw_error=create dw_error
this.cb_mail=create cb_mail
this.cb_5=create cb_5
this.cb_print=create cb_print
this.cb_clipboard=create cb_clipboard
this.cb_continue=create cb_continue
this.cb_halt_close=create cb_halt_close
this.Control[]={this.dw_error,&
this.cb_mail,&
this.cb_5,&
this.cb_print,&
this.cb_clipboard,&
this.cb_continue,&
this.cb_halt_close}
end on

on w_system_error_handler.destroy
destroy(this.dw_error)
destroy(this.cb_mail)
destroy(this.cb_5)
destroy(this.cb_print)
destroy(this.cb_clipboard)
destroy(this.cb_continue)
destroy(this.cb_halt_close)
end on

event open;//invo_dwsrv   = create n_cst_dwsrv	2007.07.12
//return

// So the window opens
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 01.17.2006 By: LiuHongXin
//$<reason> PostEvent(this, "ue_post_open") is currently unsupported.
//$<modification> Change the unsupported PostEvent(objectname, "ue_post_open" ) to objectname.PostEvent ( event, { word, long } ).
//PostEvent( this, "ue_post_open" )
  this.PostEvent( "ue_post_open" )
//---------------------------- APPEON END ----------------------------
return
end event

type dw_error from u_dw within w_system_error_handler
integer width = 3593
integer height = 1600
integer taborder = 20
string dataobject = "d_sys_error"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type cb_mail from commandbutton within w_system_error_handler
integer x = 2779
integer y = 1648
integer width = 512
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&EMail"
end type

event clicked;



dw_error.accepttext( )
string ls_address[]
//skinner 02 March 2006 - begin
//Start Code Change ---- 10.31.2006 #1 maha added bob and stan
ls_address[1] =  'support@intellisoftgroup.com' //Start Code Change ----08.07.2009 #V92 maha - from supportteam//Start Code Change ---- 11.12.2007 #V7 maha changed notification address
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

type cb_5 from commandbutton within w_system_error_handler
integer x = 2240
integer y = 1648
integer width = 512
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
end type

event clicked;string ls_msg

ls_msg += 'The System Error window helps you communicate to IntelliSoft the nature of program failures. Those failures may be due to problems with your data, may be programming errors, and so on. IntelliSoft will be able to diagnose and fix the problem more quickly, if you can pass along the System Error information to the IntelliSoft support team.'
ls_msg += ' ~r~n'
ls_msg += ' ~r~nThere are three ways for you to capture the System Error message:'
ls_msg += ' ~r~n'
ls_msg += ' ~r~n1) [Print] will print the information, so you can fax it to Intellisoft;'
ls_msg += ' ~r~n'
ls_msg += ' ~r~n2) [To ClipBoard] puts the information into the Windows clipboard, so you can paste it into a message that you e-mail to IntelliSoft.'
ls_msg += ' ~r~n'
ls_msg += ' ~r~n3) You can click any item on the System Error window (e.g. the fax number) and it will be placed into the ClipBoard for your use. The clipboard contents are shown in the System Error window title. '
ls_msg += ' ~r~n'
ls_msg += ' ~r~nOnce you have captured the System Error information, you can decide whether you want to halt the application. '
ls_msg += ' ~r~n'
ls_msg += ' ~r~nMost of the time you can simply click the [Continue] button to continue running the application. That way you can probably proceed without losing any data changes you have made since your last Save.'
ls_msg += ' ~r~n'
ls_msg += ' ~r~nSometimes you may encounter System Errors that are so serious that you do NOT want to continue. You may also find yourself in a loop where the System Error occurs over and over. In those cases, you can click [Halt Application] and the application will close.'

MessageBox( "System Error Help", ls_msg )
end event

type cb_print from commandbutton within w_system_error_handler
string tag = "This prints the error message"
integer x = 1701
integer y = 1648
integer width = 512
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;// Print the DW
dw_error.print()
end event

type cb_clipboard from commandbutton within w_system_error_handler
string tag = "Clicking this will put the error text into the clipboard so you can paste it into an e-mail (for example)"
integer x = 1161
integer y = 1648
integer width = 512
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&To Clipboard"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<modify> 01.13.2006 By: Rodger Wu
//$<reason> SaveAs( "", Clipboard!, false ) is unsupported.
//$<modification> Replace the unsupported SaveAs( "", Clipboard!, false ) with describe("datawindow.data").

//dw_error.SaveAs( "", Clipboard!, false )
//string ls_message
//ls_message = clipboard( "" ) // Gets it OUT of the clipboard
//ClipBoard( ls_message )

string ls_message
ls_message = dw_error.describe("datawindow.data")
ClipBoard( ls_message )
//---------------------------- APPEON END ----------------------------
end event

type cb_continue from commandbutton within w_system_error_handler
string tag = "Click this to close the error window and continue operating the application"
integer x = 622
integer y = 1648
integer width = 512
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Continue"
end type

event clicked;close( parent )
end event

type cb_halt_close from commandbutton within w_system_error_handler
string tag = "Clicking this will halt the application"
integer x = 146
integer y = 1648
integer width = 448
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Halt Application"
end type

event clicked;halt close
end event

