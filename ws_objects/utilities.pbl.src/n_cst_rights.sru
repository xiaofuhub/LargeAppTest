$PBExportHeader$n_cst_rights.sru
$PBExportComments$[untilities] Used to determine if the access rights are valid for the paths for this user.
forward
global type n_cst_rights from nonvisualobject
end type
end forward

global type n_cst_rights from nonvisualobject
end type
global n_cst_rights n_cst_rights

type prototypes
FUNCTION boolean CloseWindow(ulong w_handle) LIBRARY "User32.dll"
FUNCTION boolean CloseHandle(ulong w_handle) LIBRARY "Kernel32.dll"
end prototypes

type variables
n_ds ids_paths
n_cst_filesrvwin32 inv_filesrv 

n_cst_datetime inv_datetime

INTEGER ii_send
integer ii_let
integer ii_image
integer ii_app
STRING iS_MESSAGES[]
STRING iS_paths[]
STRING is_check_path
string ls_return_message
string INTELLI_TEST_FILE 
CONSTANT STRING NEW_LINE  = '~r~n'	
end variables

forward prototypes
public function string of_start ()
private function integer of_create_message ()
private function integer of_check_file_write ()
private function integer of_check_path_exists ()
private function integer of_create_path_list ()
private function integer of_file_delete ()
private function integer of_check_file_execute ()
public function integer of_check_dir_right (string as_dir, boolean ab_showmessage, string as_title)
public function integer of_check_dir_right (string as_dir)
public function integer of_check_tempdir_right ()
end prototypes

public function string of_start ();/******************************************************************************************************************
**  [PUBLIC]   : OF_START
**==================================================================================================================
**  Purpose   	: The oponing function to the path cheking
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

iS_MESSAGES[1] = "IF THIS IS A NEW INSTALLATION, PLEASE IGNORE THIS MESSAGE UNTIL TRAINING SETUP HAS BEEN COMPLETED"
iS_MESSAGES[2] = " "
iS_MESSAGES[3] = "IntelliCred/App is having trouble accessing some of the file paths defined in your system. "
iS_MESSAGES[4] = " "
iS_MESSAGES[5] = "This may have occurred because the file path is not configured correctly in the program, the folder and/or drive letter does not exist or is not connected, or because you do not have full permissions to the folder.  Please contact your IS department to correct the problem."
iS_MESSAGES[6] = " "
iS_MESSAGES[7] = "Until this problem has been resolved, some program functions may not work correctly."
iS_MESSAGES[8] = " "



of_create_path_list()

of_check_path_exists()

//OF_check_file_write( )
//
//OF_CHECK_FILE_EXECUTE()
//
//of_file_delete( )

of_create_message()


IF NOT F_VALIDSTR(ls_return_message) THEN
	SETNULL(ls_return_message)
END IF 

IF ii_send = 1 THEN
	return  ls_return_message
ELSE
	RETURN "OK"
end if
	
end function

private function integer of_create_message ();
/******************************************************************************************************************
**  [PRIVATE]   : of_create_message
**==================================================================================================================
**  Purpose   	: create the retuurn message
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

long ll_i 

for ll_i = 1 to upperbound(is_messages )
	ls_return_message = ls_return_message +  is_messages[ll_i] + "~r~n"//new_line
	
next
return 0
end function

private function integer of_check_file_write ();/******************************************************************************************************************
**  [PRIVATE]   : of_check_file_write
**==================================================================================================================
**  Purpose   	: check to see if we can write files to a directory
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner   © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_i
integer li_FileNum
//for ll_i = 1 to upperbound(is_paths)
	li_FileNum = FileOpen( is_check_path + INTELLI_TEST_FILE ,LineMode!, Write!, LockWrite!, Append!)
	
	IF li_FileNum < 0 OR ISNULL(li_FileNum) THEN 
		IS_messages[UPPERBOUND(is_messages )+1] = 'The application could not create a file in the directory ' + is_check_path + ' please contact your IS department. You need to have full permissions to this directory.'
	END IF 
	
   IF FileWrite(li_FileNum, "Test") < 0 THEN 
	  IS_messages[UPPERBOUND(is_messages )+1] = 'The application could not write to a file in the directory ' + is_check_path + ' please contact your IS department. You need to have full permissions to this directory.'
	end if
	
	FileClose ( li_FileNum )
//next

return 0
end function

private function integer of_check_path_exists ();/******************************************************************************************************************
**  [PRIVATE]   : of_check_path_exists( )
**==================================================================================================================
**  Purpose   	: check to see if the paths exist
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner   © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.08.2006 By: Rodger Wu
//$<reason> Create path automatically for downloading files from database.
/*
for ll_i = 1 to upperbound(is_paths)
	IF NOT inv_filesrv.of_DirectoryExists (is_paths[ll_i]) THEN
		IS_messages[UPPERBOUND(IS_messages) + 1 ] =  'The Path ' + upper(is_paths[ll_i]) + ' does not exist'
		ii_send = 1
	else
	//end if
		is_check_path = is_paths[ll_i]
		OF_check_file_write( )
//messagebox("",is_check_path)
		//OF_CHECK_FILE_EXECUTE()

		of_file_delete( )
	END IF
	
next
*/
n_appeon_download lnv_download
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
   Upper( appeongetclienttype() ) = 'WEB' Then
	for ll_i = 1 to upperbound(is_paths)
		if not inv_filesrv.of_DirectoryExists (is_paths[ll_i]) then
			if IsNumber( is_paths[ll_i] ) then Continue;
			lnv_download.of_parsepath( is_paths[ll_i] )
		end if

		is_check_path = is_paths[ll_i]
		OF_check_file_write( )
		of_file_delete( )
	next
Else
	for ll_i = 1 to upperbound(is_paths)
		IF NOT inv_filesrv.of_DirectoryExists (is_paths[ll_i]) THEN
			IS_messages[UPPERBOUND(IS_messages) + 1 ] =  'The Path ' + upper(is_paths[ll_i]) + ' does not exist'
			ii_send = 1
		else
			is_check_path = is_paths[ll_i]
			OF_check_file_write( )
			of_file_delete( )
		END IF
	next
End If
//---------------------------- APPEON END ----------------------------

return 0
end function

private function integer of_create_path_list ();/******************************************************************************************************************
**  [PRIVATE]   : of_create_path_list
**==================================================================================================================
**  Purpose   	: Craete a list of all the current paths
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [long]   0 = success, -1 failure 
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
BOOLEAN LB_EXISTS
long ll_i,ll_j,LL_K
for ll_i = 1 to ids_paths.rowcount( )
	for ll_j = 1 to LONG(ids_paths.Describe("DataWindow.Column.Count"))
		if f_validstr( ids_paths.getItemString(ll_i, ll_j)) then
			// MAKE SURE THE FILE DOES NOT EXIST ALREADT
			FOR  LL_K = 1 TO UPPERBOUND(iS_paths) 
				IF ids_paths.getItemString(ll_i, ll_j) = iS_paths[LL_K] THEN 
					LB_EXISTS =  TRUE 
					CONTINUE
				END IF 
			NEXT
			
			IF NOT LB_EXISTS THEN  
				iS_paths[upperbound(iS_paths) + 1]  = ids_paths.getItemString(ll_i, ll_j)
		   ELSE 
				LB_EXISTS = FALSE
			end if 
		END IF
next
	
next


if upperbound(iS_paths) < 1 then 
	iS_MESSAGES[upperbound(iS_MESSAGES) + 1 ] = 'No Paths set for Intellicred'
	return -1
end if

////////////////////////////////////////////////////////////////////////////////////////////////////////
// add in the data directory
////////////////////////////////////////////////////////////////////////////////////////////////////////
//iS_paths[upperbound(iS_paths) + 1] = gnv_app.is_application_path + '\'
iS_paths[upperbound(iS_paths) + 1] = gs_dir_path + 'intellicred\' //Start Code Change ---- 04.26.2006 #423 maha

return 0
end function

private function integer of_file_delete ();/******************************************************************************************************************
**  [PRIVATE]   : of_file_delete
**==================================================================================================================
**  Purpose   	: delete file test
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner   © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i 
//for ll_i = 1 to upperbound(is_paths)
		if not filedelete( is_check_path + INTELLI_TEST_FILE ) then 
			is_messages[upperbound(is_messages) + 1] = 'The application could not delete a file in the directory ' + is_check_path  + '. Contact your IS department. You must have full permisions to the directory.' 
			ii_send = 1
	  end if 
//next

return 0
end function

private function integer of_check_file_execute ();/******************************************************************************************************************
**  [PRIVATE]   : 
**==================================================================================================================
**  Purpose   	: 
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

STRING LS_NULL
LONG value
SETNULL(LS_NULL)
LONG LL_I
STRING LS_EXECUTE
//FOR LL_I = 1 TO UPPERBOUND(is_paths) 
	    LS_EXECUTE = is_check_path + INTELLI_TEST_FILE

		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-01
		//$<modify> 03.24.2006 By: Liang QingShi
		//$<reason> Performance tuning
		//$<modification> This original script opens a new page in the same IE, which is incorrect.
		//$<modification> Modify the script to open a new IE instead of open a new page in the same IE.
		/*
		 value = ShellExecuteA ( Handle( This ), "open",  LS_EXECUTE, ls_Null, ls_Null, 0)
		*/
		 // value = ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', LS_EXECUTE, ls_Null, 0)  //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		  value = ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), LS_EXECUTE, ls_Null, 0)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		//---------------------------- APPEON END ----------------------------   
		
		choose case value
			CASE 0 
				is_messages[upperbound(is_messages) + 1 ] = 'The operating system is out of memory or resources.' + is_check_path
         CASE 2 
				is_messages[upperbound(is_messages) + 1 ] = 'The test file was not found in directory:.' + is_check_path
			CASE 3  
				is_messages[upperbound(is_messages) + 1 ] = 'The specified path was not found.' + is_check_path
			CASE 11 
				is_messages[upperbound(is_messages) + 1 ] = 'The .exe file is invalid (non-Win32® .exe or error in .exe image).' + is_check_path
			CASE 5 
				is_messages[upperbound(is_messages) + 1 ] = 'The operating system denied access to the specified file. '  + is_check_path
			CASE 27 
				is_messages[upperbound(is_messages) + 1 ] = 'The file name association is incomplete or invalid. ' + is_check_path
			CASE 30 
				is_messages[upperbound(is_messages) + 1 ] = 'The DDE transaction could not be completed because other DDE transactions were being processed. ' + is_check_path
			CASE 29 
				is_messages[upperbound(is_messages) + 1 ] = 'The DDE transaction failed. ' + is_check_path
			CASE 28 
				is_messages[upperbound(is_messages) + 1 ] = 'The DDE transaction could not be completed because the request timed out. ' + is_check_path
			CASE 32 
				is_messages[upperbound(is_messages) + 1 ] = 'The specified dynamic-link library was not found. ' + is_check_path
			CASE 31 
				is_messages[upperbound(is_messages) + 1 ] = 'There is no application associated with the given file name extension. This error will also be returned if you attempt to print a file that is not printable.' + LS_EXECUTE
			CASE 8 
				is_messages[upperbound(is_messages) + 1 ] = 'There was not enough memory to complete the operation. ' + is_check_path
			CASE 26 
				is_messages[upperbound(is_messages) + 1 ] = 'A sharing violation occurred' + is_check_path
		end choose
//	next
	
inv_datetime.of_Wait(1)




RETURN 0
end function

public function integer of_check_dir_right (string as_dir, boolean ab_showmessage, string as_title);// (Appeon)Harry 06.07.2013 - V141 ISG-CLX
Integer li_err_type = 1,li_FileNum
String ls_test_file
integer li_pos_dot, li_pos_line

If as_dir = '' or isnull(as_dir) Then Return 0
 
//get dir from filepath name
li_pos_dot = lastpos(as_dir,'.')
li_pos_line = lastpos(as_dir,'\')
If li_pos_dot > li_pos_line Then
	as_dir = Mid(as_dir , 1 , li_pos_line - 1)
End If

//check dir right
gnv_appeondll.of_parsepath(as_dir)
If Not DirectoryExists(as_dir) Then
	li_err_type = -1
Else
	ls_test_file = as_dir + '\' + INTELLI_TEST_FILE
	li_FileNum = FileOpen( ls_test_file ,LineMode!, Write!, LockWrite!, Append!)
	IF li_FileNum < 0 OR ISNULL(li_FileNum) THEN 
		li_err_type = -2
	ElseIF FileWrite(li_FileNum, "Test") < 0 THEN 
		li_err_type = -3
	End If
	FileClose ( li_FileNum )
	FileDelete(ls_test_file)
End If

If li_err_type < 0 and ab_showmessage Then
	Messagebox(as_title+ ' Error','The IntelliSoft system could not write to a file in the directory "' +as_dir+ '".  This is typically due to a Windows OS permissions issue.  Your IT department may have not given you the appropriate rights to write to file under the "' + as_dir + '" directory and this is required to setup the IntelliSoft system appropriately.'  ,Exclamation!)
End If

Return li_err_type

end function

public function integer of_check_dir_right (string as_dir);// (Appeon)Harry 06.07.2013 - V141 ISG-CLX
Return of_check_dir_right(as_dir,false,'')
end function

public function integer of_check_tempdir_right ();// (Appeon)Harry 06.07.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////
// Function: of_check_tempdir_right()
// Arguments:
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-02-23
//--------------------------------------------------------------------
// Description: Check the write right for the temp directory of the contractlogix application.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Integer i,li_FileNum
Integer li_err_type //-1, create dir err; -2, create file err; -3, write file err
String ls_parent_dir,ls_test_file
String ls_dir_list[]

//If Not Match(left(trim(gs_dir_path),2),'^[A-Za-z]:') Then
//	Messagebox('Error','The temp dir setting is error, please correct it.')
//End If

ls_dir_list[1] = gs_dir_path + gs_DefDirName
ls_dir_list[2] = gs_dir_path + gs_DefDirName + "\Agreement"
ls_dir_list[3] = gs_dir_path + gs_DefDirName + "\Agreement\Manager"
ls_dir_list[4] = gs_dir_path + gs_DefDirName + "\Email"
ls_dir_list[5] = gs_dir_path + gs_DefDirName + "\Email\CleanDoc"
ls_dir_list[6] = gs_dir_path + gs_DefDirName + "\Email\CleanDoc\attachment"
ls_dir_list[7] = gs_dir_path + gs_DefDirName + "\DWSyntax"
ls_dir_list[8] = gs_dir_path + gs_DefDirName + "\Scan"
//---------Begin Added by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
ls_dir_list[9] = gs_dir_path + gs_DefDirName + "\Negotiated"					//Added By Mark Lee 03/26/2013
//---------End Added ------------------------------------------------------

For i = 1 To UpperBound(ls_dir_list[])
	li_err_type = of_check_dir_right(ls_dir_list[i])
	If li_err_type < 0 Then 
		Exit
	End If
Next

If i > UpperBound(ls_dir_list[]) Then Return 1

ls_dir_list[i] = Trim(ls_dir_list[i])
If Right(ls_dir_list[i],1) = '\' Then
	ls_dir_list[i] = Mid(ls_dir_list[i],1,Len(ls_dir_list[i]) - 1)
End If

If LastPos(ls_dir_list[i],'\') > 0 Then
	ls_parent_dir = Mid(ls_dir_list[i],1, LastPos(ls_dir_list[i],'\') - 1 )
Else
	ls_parent_dir = ls_dir_list[i]
End If

//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
// Description:modify Contract Logix to IntelliSoft
Choose Case li_err_type
	Case -1
		Messagebox('Error','The IntelliSoft system could not create the REQUIRED temporary working directory ' + ls_dir_list[i] + '.  This is typically due to a Windows OS permissions issue.  Your IT department may have not given you the appropriate rights to create directories under the ' + ls_parent_dir + ' directory and this is required to setup the IntelliSoft system appropriately.' + &
			'~r~n~r~nSolution 1: Contact your IT department to make sure you have the appropriate Windows OS rights to create a directory under the ' + ls_parent_dir + '.' +&
			'~r~n~r~nSolution 2:  If you have the appropriate Windows OS permissions to create directories under a different folder location other than ' + ls_parent_dir + ' and you would like to configure the system to use that directory then follow these steps:' + &
			'~r~nOpen menu System -> Personal Settings -> Temporary Files Settings, and then click the Browse button, select a directory that you have full permissions, and then click the Save button.',Exclamation!)
	Case -2
		Messagebox('Error','The IntelliSoft system could not create the REQUIRED temporary file in the temporary directory ' + ls_dir_list[i] + '.  This is typically due to a Windows OS permissions issue.  Your IT department may have not given you the appropriate rights to create file under the ' + ls_dir_list[i] + ' directory and this is required to setup the IntelliSoft system appropriately.' + &
			'~r~n~r~nSolution 1: Contact your IT department to make sure you have the appropriate Windows OS rights to create a file under the ' + ls_dir_list[i] + '.' +&
			'~r~n~r~nSolution 2:  If you have the appropriate Windows OS permissions to create directories under a different folder location other than ' + gs_dir_path + ' and you would like to configure the system to use that directory then follow these steps:' + &
			'~r~nOpen menu System -> Personal Settings -> Temporary Files Settings, and then click the Browse button, select a directory that you have full permissions, and then click the Save button.',Exclamation!)
	Case -3
		Messagebox('Error','The IntelliSoft system could not write to a file in the temporary directory ' + ls_dir_list[i] + '.  This is typically due to a Windows OS permissions issue.  Your IT department may have not given you the appropriate rights to write to file under the ' + ls_dir_list[i] + ' directory and this is required to setup the IntelliSoft system appropriately.' + &
			'~r~n~r~nSolution 1: Contact your IT department to make sure you have the appropriate Windows OS rights to write to a file under the ' + ls_dir_list[i] + '.' +&
			'~r~n~r~nSolution 2:  If you have the appropriate Windows OS permissions to create directories under a different folder location other than ' + gs_dir_path + ' and you would like to configure the system to use that directory then follow these steps:' + &
			'~r~nOpen menu System -> Personal Settings -> Temporary Files Settings, and then click the Browse button, select a directory that you have full permissions, and then click the Save button.',Exclamation!)
End Choose
//---------End Modfiied ------------------------------------------------------

Return -1


end function

on n_cst_rights.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_rights.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_paths = create N_ds
ids_paths.dataobject = 'ds_paths'
ids_paths.of_settransobject(SQLCA)
ids_paths.RETRIEVE()
inv_filesrv = create n_cst_filesrvwin32

intelli_test_file  = gs_user_id +'_intellitest.TXT'
end event

event destructor;
boolean rtn
ulong l_handle
string ls_wname

ls_wname = gs_user_id+ '_intellitest.TXT - Notepad'

DO 
		l_handle = FindWindowA(0, ls_wname) // Be sure to use the exact title of the window you are targeting.
		CONSTANT uint WM_CLOSE = 16 
		Post( l_handle, WM_CLOSE, 0, Long( 0, 0 ) )
		
		If appeongetclienttype() = 'WEB' Then Return
		
LOOP WHILE l_handle <> 0

end event

