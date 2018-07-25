$PBExportHeader$n_cst_update_helpmessage.sru
forward
global type n_cst_update_helpmessage from nonvisualobject
end type
end forward

global type n_cst_update_helpmessage from nonvisualobject
end type
global n_cst_update_helpmessage n_cst_update_helpmessage

forward prototypes
public function long of_update_message ()
public subroutine of_create_message_file (string as_filename)
end prototypes

public function long of_update_message ();String ls_message_path, ls_Error

n_appeon_download lnv_download

if AppeonGetClientType() = 'WEB' THEN
	ls_message_path = gs_dir_path + gs_DefDirName + "\messages.txt"
	lnv_download.of_downloadfile("", ls_message_path)
	
	if Not FileExists(ls_message_path) then
		of_Create_Message_File(ls_message_path)
		if Not FileExists(ls_message_path) then
			ls_Error = "n_cst_update_helpmessage.of_update_message() Information: Failed to download " + ls_message_path + ", call support."
			if IsValid(gnv_logservice)THEN
				gnv_logservice.of_setloglevel(2) //warning level
				gnv_logservice.of_log_warning(ls_Error)
				gb_upgrade_failed = True
			end if
		end if
	end if
end if

Return 1

end function

public subroutine of_create_message_file (string as_filename);//====================================================================
// Function: of_Create_Message_File()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_FileName
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-05-31
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FileNo
String	ls_FileData

ll_FileNo = FileOpen (as_FileName,StreamMode!,Write!,Shared!,Replace!)
if ll_FileNo <= 0 then Return

ls_FileData = &
"create Email object	create Email object	Information	Email Send Test is failed!	Failed to create Email object!	There was an error while creating Email object.	OK	1~r~n" + &
"error_code_1 	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	An exception has occurred.	OK	1~r~n" + &
"error_code_3	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	The process has run out of memory.	OK	1~r~n" + &
"error_code_4	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	An error has occurred due to a problem with the message body or attachments.	OK	1~r~n" + &
"error_code_5	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	There was a problem initiating the conversation with the mail server. Ensure the setting of the Domain property is correct.	OK	1~r~n" + &
"error_code_7 	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	The from address was not formatted correctly or was rejected by the SMTP mail server.	OK	1~r~n" + &
"error_code_8	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	An error was reported in response to a recipient address. The SMTP server may refuse to handle mail for unknown recipients.	OK	1~r~n" + &
"error_code_9 	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	There was an error connecting to the SMTP mail server.	OK	1~r~n" + &
"error_code_10	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	There was an error opening a file. If you have specified file attachments, ensure that they exist and that you have access to them.	OK	1~r~n" + &
"error_code_11	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	There was an error reading a file. If you have specified file attachments, ensure that they exist and the you have access to them.	OK	1~r~n" + &
"error_code_15	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	No mail server specified. 	OK	1~r~n" + &
"error_code_16	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	There was a problem with the connection and a socket error occurred.	OK	1~r~n" + &
"error_code_17	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	Could not resolve host.	OK	1~r~n" + &
"error_code_18	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	Connected but the server sent back bad response.	OK	1~r~n" + &
"error_code_20	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	Cancelled as a result of calling the Cancel() method.	OK	1~r~n" + &
"error_code_21	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	The operation timed out while the host was being resolved.	OK	1~r~n" + &
"error_code_22	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	The operation timed out while connecting.	OK	1~r~n" + &
"error_code_24 	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	ESMTP Authentication failed.	OK	1~r~n" + &
"error_code_25	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	The selected ESMTP Authentication mode is not supported by the server.	OK	1~r~n" + &
"error_code_26	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	ESMTP Authentication protocol error.	OK	1~r~n" + &
"error_code_27	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	Socket Timeout Error.	OK	1~r~n" + &
"error_code_105	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	Invalid license key.	OK	1~r~n" + &
"error_code_-1	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	The EMail account of addresser has not config.	OK	1~r~n" + &
"error_code_-11	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	Email Account cannot be null.	OK	1~r~n" + &
"error_code_-12	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	Email Password cannot be null.	OK	1~r~n" + &
"error_code_-13	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	Email Address cannot be null.	OK	1~r~n" + &
"error_code_-14	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	SMTP Server address cannot be null.	OK	1~r~n" + &
"error_code_-15	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	SMTP Server port cannot be null.	OK	1~r~n" + &
"error_code_-16	Email Send 	Information	Email Send Test is failed!	There was an error while connecting to the SMTP mail server(Error code:'%1S%').	SMTP Server Secure Password Authentication cannot be null.	OK	1~r~n" + &
"OCX Issue	OCX Registration 	Information	Failed to register OCX!	Error: '%1S%' cannot be registered. Please click the Help icon to view the possible cause and solution.	Exception occurred when invoking the dllregisterserver function.	OK	1~r~n" + &
""

FileWrite(ll_FileNo,ls_FileData)
FileClose(ll_FileNo)

end subroutine

on n_cst_update_helpmessage.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_helpmessage.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

