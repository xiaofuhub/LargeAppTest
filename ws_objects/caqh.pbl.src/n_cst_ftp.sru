$PBExportHeader$n_cst_ftp.sru
forward
global type n_cst_ftp from nonvisualobject
end type
end forward

global type n_cst_ftp from nonvisualobject
end type
global n_cst_ftp n_cst_ftp

type variables
Public:
datastore ids_dirlist
OLEObject iole_ftp

Private:
PowerObject ipo_info
Hprogressbar ihp_info
TreeView itv_dir

Constant Int STATE_DISCONNECTED = 0
Constant Int STATE_CONNECTED = 4
Constant Int WAIT_SECONDS = 600 //

Long il_filesize //current remote file size




end variables

forward prototypes
public function integer of_createobject ()
public subroutine of_display (string as_info)
public function integer of_connect (string as_hostname, string as_port, integer ai_protocol, string as_login, string as_password, boolean ab_passive)
public function integer of_disconnect ()
public function integer of_connect ()
public function integer of_listdir (string as_rpath)
public function integer of_get_state (ref string as_state_text)
public function boolean of_is_error ()
public function integer of_listnames (string as_rpath)
public function integer of_makedir (string as_rpath)
public subroutine of_set_tip_object (powerobject apo_text)
public function integer of_removedir (string as_rpath)
public function long of_get_error (ref string as_error)
public function integer of_deletefile (string as_rpath)
public function integer of_getfile (string as_lpath, string as_rpath)
public function boolean of_check_state (long al_state)
public function integer of_putfile (string as_lpath, string as_rpath)
public subroutine of_show_transinfo ()
public function integer of_get_state ()
public function integer of_abort ()
public subroutine of_set_blocking (boolean ab_block)
public function integer of_check_result (string as_method)
public function Boolean of_is_processing ()
public subroutine of_set_progressbar (hprogressbar ahp)
public subroutine of_progressbar_move (integer ai_position)
public subroutine of_set_treeview (treeview atv_dir)
public function integer of_display_treeview ()
public function integer of_listdir (string as_rpath, integer ai_level, string as_name)
public function integer of_check_result ()
public function integer of_connect (str_ftp_parms astr_parms)
public function long of_getsize (string as_path, boolean ab_local)
public function Integer of_wait ()
end prototypes

public function integer of_createobject ();//====================================================================
//$<Function>: of_createobject
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Create iole_ftp
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================


long ll_Result

// Create object
if Not IsValid(iole_ftp) then
	iole_ftp = Create OLEObject	
end if

ll_Result = iole_ftp.ConnectToNewObject("WeOnlyDo.wodFtpDLXCom.1")
//Set license key
if ll_Result = 0 then
	iole_ftp.LicenseKey = '3C9L-6MNG-K95C-MYA6'
else
	messagebox("Error","Connect to wodFtpDLXCom failed. Error " + String(ll_Result) +'.~r~nPlease check it in Help - Environment Check.')
	Destroy iole_ftp	
	Return -1
end if


Return 1

end function

public subroutine of_display (string as_info);//====================================================================
//$<Function>: of_display
//$<Arguments>:
// 	value    string    as_info
//$<Return>:  (None)
//$<Description>: Display Info to an assigned object (of_set_tip_object).
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

StaticText lst_temp
Multilineedit lmle_temp

If Not IsValid(ipo_info) Then Return

Choose case TypeOf(ipo_info)
	case StaticText!
		lst_temp = ipo_info
		lst_temp.Text = as_info
	Case Multilineedit!
		lmle_temp = ipo_info
		If lmle_temp.LineCount()>0 Then	
			lmle_temp.Text += '~r~n' + as_info
			lmle_temp.Scroll(lmle_temp.LineCount())	
		Else
			lmle_temp.Text =  as_info
		End If
End Choose
end subroutine

public function integer of_connect (string as_hostname, string as_port, integer ai_protocol, string as_login, string as_password, boolean ab_passive);//====================================================================
//$<Function>: of_connect
//$<Arguments>:
// 	value    string     as_hostname
// 	value    string     as_port
// 	value    integer    ai_protocol
// 	value    string     as_login
// 	value    string     as_password
// 	value    boolean    ab_passive
//$<Return>:  integer 1: success/ -1:connect fail/ -2:listdir fail/ -3:Disconnect fail / -4:Create iole_ftp failed
//$<Description>: Connect to FTP server with parms.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i = 0

//Create iole_ftp failed
If Not IsValid(iole_ftp) Then
	Return -4
End If

//Can't set HostName when connnected.
If Not of_check_state(STATE_DISCONNECTED) Then 
	i = of_disconnect()
	If i < 0 Then Return -3
end If

iole_ftp.HostName = as_hostname
iole_ftp.Port = Integer(as_port)
iole_ftp.Protocol = ai_protocol
iole_ftp.Login = as_login
iole_ftp.Password = as_password

//Determines encryption algorithm to be used. 0:Anything suitable, selected by wodFtpDLX component.
iole_ftp.Encryption = 0

//Waits until method completes
iole_ftp.Blocking = True

//When set to true file transfer will resume.
iole_ftp.Resume = False

//Determines if data connection is opened in passive mode
iole_ftp.Passive = ab_passive

//file listing type on the server
iole_ftp.DirFormat = 0 //CfmtAuto

//Specifies number of seconds before user will be disconnected.
iole_ftp.Timeout = 0

//Connect
i = of_connect()

Return i

end function

public function integer of_disconnect ();//====================================================================
//$<Function>: of_disconnect
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Disconnect iole_ftp
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Try
	iole_ftp.Disconnect
Catch(runtimeerror ret)
	//ll_last_err = iole_ftp.LastError
END TRY 

Return of_check_result('Disconnect')
end function

public function integer of_connect ();//====================================================================
//$<Function>: of_connect
//$<Arguments>:
//$<Return>:  integer -1:connect fail/ -2:listdir fail/ 1 success
//$<Description>: connect to FTP server.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err
Int i

of_display("Connecting...")

//Connect
Try
	iole_ftp.Connect
Catch(runtimeerror ret)
END TRY 

i = of_check_result('Connect')
If i >0 Then
	i = of_listdir('')
	If i < 0 Then //List Dir error
		i = -2
	Else //Sucess
		i = 1
	End If
Else //Connect fail
	i = -1
End If

Return i
end function

public function integer of_listdir (string as_rpath);//====================================================================
//$<Function>: of_listdir
//$<Arguments>:
// 	value    string    as_rpath (remotepath)
//$<Return>:  integer
//$<Description>: Lists contents of a directory on the server. iole_ftp.ListItem.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int i

ids_dirlist.reset()
//Store info to ids_dirlist,Recursive function
i = of_listdir(as_rpath, 1, 'Root')
If i > 0 Then
	of_display_treeview()
Else
	of_display('List Dir Error.')
	Return -1
End If

of_display('List Dir Done.')

Return 1

end function

public function integer of_get_state (ref string as_state_text);//====================================================================
//$<Function>: of_get_state
//$<Arguments>:
// 	reference    string    as_state_text
//$<Return>:  integer
//$<Description>: Get ole State code and State_text
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Disconnected 0 Disconnected from server. 
//Connecting 1 Connecting to server. 
//Encrypting 2 Initializing secure connection. 
//LogonInProgress 3 Sending authentication data. 
//Connected 4 Connected to server - idle. 
//GettingDataChannel 5 Getting data channel. 
//ConnectingDataChannel 6 Connecting data channel. 
//ChangingDirectory 7 Changing current directory. 
//CheckRemoteSize 8 Checking remote file size. 
//SettingRestPosition 9 Checking remote file size. 
//MakingDirectory 10 Creating directory on the server. 
//RemovingFile 11 Creating directory on the server. 
//RenamingFile 12 Renaming file on the server. 
//SettingTransferMode 13 Setting transfer mode. 
//ListingDirectory 14 Downloading directory list from the server. 
//Receiving 15 Receiving data from server. 
//Sending 16 Sending data to server. 
//Executing 17 Executing command on server. 
//ProxyConnecting 18 Trying to establish connection on proxy server. 
//Disconnecting 19 Disconnecting from the server. 
//SettingDataChannel 20 Setting data channel security. 
//ClearingCommandChannel 21 Setting data channel security. 
//SettingCompression 22 Setting data channel security. 
//CalculatingRemoteCRC 23 Calculating remote CRC. 
//CheckRemoteDir 24 Checking if directory exists 
//GettingAttributes 25 Checking file or folder attributes. 
//SettingAttributes 26 Setting file or folder attributes. 

Long ll_state
String ls_state_text
ll_state = iole_ftp.State
ls_state_text = iole_ftp.StateText(ll_state)

as_state_text = ls_state_text

Return ll_state
end function

public function boolean of_is_error ();//====================================================================
//$<Function>: of_is_error
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: Check if last ole method generate error.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err

ll_last_err = iole_ftp.LastError
If ll_last_err <> 0 Then
	Return true
End If

Return false
end function

public function integer of_listnames (string as_rpath);//====================================================================
//$<Function>: of_listnames
//$<Arguments>:
// 	value    string    as_rpath
//$<Return>:  integer
//$<Description>: Lists names in the directory on the server.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err
Int i

Try
	 iole_ftp.ListNames(as_rpath)
Catch(runtimeerror ret)
END TRY 

//ErrorCode
ll_last_err = of_get_error(ls_err)
If ll_last_err <> 0 Then
	of_display("ListNames Error. "+ ls_err)
	Return -1
End If

//Check error
i = of_check_result('List Directory')
If i >0 Then
	of_display(string(iole_ftp.ListItem))
Else
	Return -1
End If

Return 1

end function

public function integer of_makedir (string as_rpath);//====================================================================
//$<Function>: of_makedir
//$<Arguments>:
// 	value    string    as_rpath
//$<Return>:  integer
//$<Description>: Create a directory on remote FTP server.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err

If IsNull(as_rpath) or as_rpath = '' Then 
	of_display("MakeDir Error. No RemotePath.")
	return 0
End If

Try
	 iole_ftp.makedir(as_rpath)
Catch(runtimeerror ret)
END TRY 

Return of_check_result('Make Directory')
end function

public subroutine of_set_tip_object (powerobject apo_text);//====================================================================
//$<Function>: of_set_tip_object
//$<Arguments>:
// 	value    powerobject    apo_text
//$<Return>:  (None)
//$<Description>: Set apo_text to ipo_info for displaying infomation.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ipo_info = apo_text

end subroutine

public function integer of_removedir (string as_rpath);//====================================================================
//$<Function>: of_removedir
//$<Arguments>:
// 	value    string    as_rpath
//$<Return>:  integer
//$<Description>: Remove a directory on remote FTP server.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err

If IsNull(as_rpath) or as_rpath = '' Then 
	of_display("RemoveDir Error. No RemotePath.")
	return 0
End If

Try
	 iole_ftp.removedir(as_rpath)
Catch(runtimeerror ret)
END TRY 

Return of_check_result('Remove Directory')
end function

public function long of_get_error (ref string as_error);//====================================================================
//$<Function>: of_get_error
//$<Arguments>:
// 	reference    string    as_error
//$<Return>:  long
//$<Description>: return ole error code and error text
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err

ll_last_err = iole_ftp.LastError
If ll_last_err <> 0 Then
	ls_err = iole_ftp.ErrorText(ll_last_err)
End If

as_error = ls_err

Return ll_last_err
end function

public function integer of_deletefile (string as_rpath);//====================================================================
//$<Function>: of_deletefile
//$<Arguments>:
// 	value    string    as_rpath
//$<Return>:  integer
//$<Description>: Deletes file on the server.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err

If IsNull(as_rpath) or as_rpath = '' Then 
	of_display("Delete File Error. No RemotePath.")
	return 0
End If

Try
	 iole_ftp.DeleteFile(as_rpath)
Catch(runtimeerror ret)
END TRY 

Return of_check_result('Delete File')
end function

public function integer of_getfile (string as_lpath, string as_rpath);//====================================================================
//$<Function>: of_getfile
//$<Arguments>:
// 	value    string    as_lpath
// 	value    string    as_rpath
//$<Return>:  integer 1:success/ else: fail
//$<Description>: GetFile method will initiate copying of file residing on remote server to the local computer. 
//						This method can be initiated only when State property is set to Connected. You cannot receive file if wodFtpDLX is busy doing something else. 
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err
String ls_state_text
Int i

If IsNull(as_lpath) or as_lpath = '' Then 
	of_display("Get File Error. No LocalPath.")
	return -1
End If

If IsNull(as_rpath) or as_rpath = '' Then 
	of_display("Get File Error. No RemotePath.")
	return -2
End If

If Not of_check_state(STATE_CONNECTED) Then 
	of_display("Get File Error. State is not connected.")
	return -3
end If

il_filesize = of_getsize(as_rpath, false) //Remote file
If il_filesize < 0 Then
	of_display("Put File Error. Can not get romote file size. Error " + String(il_filesize) +'.')
	return -4
end If

//Blocking Model to for 'Cancel' and 'Show Speed'
of_set_blocking(False)

Try
	 iole_ftp.GetFile(as_lpath, as_rpath)
Catch(runtimeerror ret)
END TRY 

//Wait GetFile method
i = of_wait()

of_set_blocking(True)

//Timeout
If i = -1 Then return -6

i = of_check_result('Get File')
If i < 0 Then return -5
	
Return 1
end function

public function boolean of_check_state (long al_state);//====================================================================
//$<Function>: of_check_state
//$<Arguments>:
// 	value    string    as_state
//$<Return>:  boolean True:same/ False:not same
//$<Description>: Check as_state with ole state.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_state_text
Long ll_state

ll_state = of_get_state(ls_state_text)

If ll_state <> al_state Then
	Return False
End If

Return True

end function

public function integer of_putfile (string as_lpath, string as_rpath);//====================================================================
//$<Function>: of_putfile
//$<Arguments>:
// 	value    string    as_lpath
// 	value    string    as_rpath
//$<Return>:  integer 1:success/else: fail
//$<Description>: Sends file to the server.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_err
Int i

If IsNull(as_lpath) or as_lpath = '' Then 
	of_display("Put File Error. No LocalPath.")
	return -1
End If

If IsNull(as_rpath) or as_rpath = '' Then 
	of_display("Put File Error. No RemotePath.")
	return -2
End If

If Not of_check_state(STATE_CONNECTED) Then 
	of_display("Put File Error. State is not connected.")
	return -3
end If

il_filesize = of_getsize(as_lpath, true) //local file
If il_filesize < 0 Then
	of_display("Put File Error. Can not get local file size.")
	return -4
end If

//Blocking Model to for 'Cancel' and 'Show Speed'
of_set_blocking(False)

Try
	 iole_ftp.PutFile(as_lpath, as_rpath)
Catch(runtimeerror ret)
END TRY 

//Wait PutFile method
i = of_wait()

of_set_blocking(True)

//Timeout
If i = -1 Then return -6

i = of_check_result('Put File')
If i < 0 Then Return -5

Return 1
end function

public subroutine of_show_transinfo ();//====================================================================
//$<Function>: of_show_transinfo
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: show transfer info when puting file or geting file.
//$<Author>: (Appeon) long.zhang 06.18.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Dec{2} lde_transferrate
String ls_process_rate
String ls_unit
String ls_speed
Long li_transfertime
Int li_position


//TransferRate, A Long value. Specifies average speed, in bytes/sec.
lde_transferrate = iole_ftp.TransferRate

//TransferTime.
li_transfertime = iole_ftp.TransferTime

//Process Rate
li_position = Integer(((li_transfertime * lde_transferrate)/il_filesize) * 100)
If li_position> 100 Then li_position = 100

ls_process_rate = String(li_position) + '%'

ls_unit = 'bytes'

If lde_transferrate > 1048576 Then
	ls_unit = 'MB'
	lde_transferrate = lde_transferrate/1048576
ElseIf  lde_transferrate > 1024 Then
	ls_unit = 'KB'
	lde_transferrate = lde_transferrate/1024
End If
ls_speed = 'Speed: '+ String(lde_transferrate) + ls_unit +'/sec '

//Display
of_display(ls_speed + ' ' +ls_process_rate)

//Progressbar
of_progressbar_move(li_position)


end subroutine

public function integer of_get_state ();//====================================================================
//$<Function>: of_get_state
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Get ole State code and State_text
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Disconnected 0 Disconnected from server. 
//Connecting 1 Connecting to server. 
//Encrypting 2 Initializing secure connection. 
//LogonInProgress 3 Sending authentication data. 
//Connected 4 Connected to server - idle. 
//GettingDataChannel 5 Getting data channel. 
//ConnectingDataChannel 6 Connecting data channel. 
//ChangingDirectory 7 Changing current directory. 
//CheckRemoteSize 8 Checking remote file size. 
//SettingRestPosition 9 Checking remote file size. 
//MakingDirectory 10 Creating directory on the server. 
//RemovingFile 11 Creating directory on the server. 
//RenamingFile 12 Renaming file on the server. 
//SettingTransferMode 13 Setting transfer mode. 
//ListingDirectory 14 Downloading directory list from the server. 
//Receiving 15 Receiving data from server. 
//Sending 16 Sending data to server. 
//Executing 17 Executing command on server. 
//ProxyConnecting 18 Trying to establish connection on proxy server. 
//Disconnecting 19 Disconnecting from the server. 
//SettingDataChannel 20 Setting data channel security. 
//ClearingCommandChannel 21 Setting data channel security. 
//SettingCompression 22 Setting data channel security. 
//CalculatingRemoteCRC 23 Calculating remote CRC. 
//CheckRemoteDir 24 Checking if directory exists 
//GettingAttributes 25 Checking file or folder attributes. 
//SettingAttributes 26 Setting file or folder attributes. 

Long ll_state

ll_state = iole_ftp.State

Return ll_state
end function

public function integer of_abort ();//====================================================================
//$<Function>: of_abort
//$<Arguments>:
//$<Return>:  integer
//$<Description>: This method aborts method that is currently executing. 
//						This includes file and folder listings, such as ListDir, ListNames, GetFile, PutFile etc.. 
//$<Author>: (Appeon) long.zhang 06.12.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

iole_ftp.abort

Do While Not(of_get_state() = STATE_CONNECTED)
	yield()
Loop

Return 1
end function

public subroutine of_set_blocking (boolean ab_block);//====================================================================
//$<Function>: of_set_blocking
//$<Arguments>:
// 	value    boolean    ab_block
//$<Return>:  (None)
//$<Description>: When set to True forces wodFtpDLX to execute methods in blocking manner - waits until method completes
//$<Author>: (Appeon) long.zhang 06.12.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

iole_ftp.blocking = ab_block
end subroutine

public function integer of_check_result (string as_method);//====================================================================
//$<Function>: of_check_result
//$<Arguments>:
// 	value    string    as_method
//$<Return>:  int
//$<Description>: Check OLE method process result
//$<Author>: (Appeon) long.zhang 06.12.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err

//ErrorCode
ll_last_err = of_get_error(ls_err)
If ll_last_err <> 0 Then
	If as_method <> '' Then of_display(as_method +" Error. "+ ls_err)
	Return -1
End If

If as_method <> '' Then of_display(as_method + ' Done.')

Return 1
end function

public function Boolean of_is_processing ();//====================================================================
//$<Function>: of_is_processing
//$<Arguments>:
//$<Return>:  Boolean 
//$<Description>: Is OLE Processing a method?
//$<Author>: (Appeon) long.zhang 06.12.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int li_state

li_state = of_get_state()

If li_state = STATE_CONNECTED or li_state = STATE_DISCONNECTED Then Return False

Return True
	
 
 
end function

public subroutine of_set_progressbar (hprogressbar ahp);//====================================================================
//$<Function>: of_set_progressbar
//$<Arguments>:
// 	value    hprogressbar    ahp
//$<Return>:  (None)
//$<Description>: Set ahp to ihp_info for Showing ProgressBar.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ihp_info = ahp
ihp_info.position = 0

end subroutine

public subroutine of_progressbar_move (integer ai_position);If Isvalid(ihp_info) Then
	ihp_info.Position = ai_position
End If
end subroutine

public subroutine of_set_treeview (treeview atv_dir);//====================================================================
//$<Function>: of_set_treeview
//$<Arguments>:
// 	value    treeview    atv_dir
//$<Return>:  (None)
//$<Description>: Set atv_dir to itv_dir for displaying Remote Directory.
//$<Author>: (Appeon) long.zhang 06.16.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

itv_dir = atv_dir

end subroutine

public function integer of_display_treeview ();//====================================================================
//$<Function>: of_display_treeview
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Show directory tree in treeview
//$<Author>: (Appeon) long.zhang 06.18.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

int i, j
Long ll_item_handle
Long ll_parent_handle
Long ll_find
TreeViewItem ltvi_item
String ls_parent_name

If Not IsValid(itv_dir) Then Return 0

//Reset TreeView
ll_find = itv_dir.FindItem(RootTreeItem!, 0 )
Do While ll_find > 0
	itv_dir.DeleteItem(ll_find)
	ll_find = itv_dir.FindItem(RootTreeItem!, 0 )
Loop 

j =ids_dirlist.rowcount()
If j = 0 Then
	Return 0
End If

Int li_level
Int li_level_parent
For i = 1 to j
	ltvi_item.data  = ids_dirlist.GetItemString(i, 'item_path')
	ltvi_item.label = ids_dirlist.GetItemString(i, 'item_name')
	li_level =  ids_dirlist.GetItemNumber(i, 'level')
	ls_parent_name =  ids_dirlist.GetItemString(i, 'parent_name')
	
	If  ids_dirlist.getitemstring(i, 'item_type') = 'Directory' Then
		ltvi_item.PictureIndex = 1
		ltvi_item.SelectedPictureIndex = 2	
	Else
		ltvi_item.PictureIndex = 0
		ltvi_item.SelectedPictureIndex = 0
	End If

	//Find parent node
	If li_level = 1 Then
		ll_parent_handle = 0
	Else
		li_level_parent = li_level - 1
		ll_find = ids_dirlist.Find('level = ' + String(li_level_parent) + " and item_type = 'Directory' and item_name ='"+ ls_parent_name +"'", 1, ids_dirlist.rowcount() )
		If ll_find < 1 Then 
			of_display('Dispaly TreeView. Can not find ' + ls_parent_name + ".")
			Return -1
		Else
			ll_parent_handle = ids_dirlist.GetItemNumber(ll_find, 'item_handle')
		End If
	End If
	
	ll_item_handle = itv_dir.InsertItemLast ( ll_parent_handle, ltvi_item )
	ids_dirlist.SetItem(i, 'item_handle', ll_item_handle)
Next

Return 1
end function

public function integer of_listdir (string as_rpath, integer ai_level, string as_name);//====================================================================
//$<Function>: of_listdir
//$<Arguments>:
// 	value    string    as_rpath (remotepath)
//$<Return>:  integer
//$<Description>: Lists contents of a directory on the server. iole_ftp.ListItem.
//$<Author>: (Appeon) long.zhang 06.11.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_last_err
String ls_err
Int i
Int j
Int li_type
Int li_level
Int li_rtn = 1
Long ll_item_handle
Long ll_parent_handle
Long ll_row
Long ll_start = 0
Long ll_end
Long ll_find
String ls_name
String ls_fullpath
String ls_type
String ls_parent_name
Datetime ldt_modifytime
TreeView ltv_temp

If RightA(as_rpath, 1) <> '\' Then as_rpath = as_rpath + '\'
iole_ftp.RemotePath = as_rpath
	
Try
	 iole_ftp.ListDir
Catch(runtimeerror ret)
END TRY 

//Check error
i = of_check_result()
If i < 0 Then Return -1	
	
j = iole_ftp.DirItems.count

//Store info to ids_dirlist
For i	= 1 to j	
	ls_name = string( iole_ftp.DirItems.item(i - 1).name)
	If ls_name = '.' or ls_name = '..' Then Continue
	
	li_type = iole_ftp.DirItems.item(i - 1).Type
	Choose case li_type
		case 0
			ls_type = 'Directory'
		case 1
			ls_type = 'Symlink'
		case 2
			ls_type = 'File'
		case 3
			ls_type = 'Temporary'
		case 4
			ls_type = 'Unknown'
	End choose
	
	ldt_modifytime =  iole_ftp.DirItems.item(i - 1).ModificationTime
	ls_fullpath = as_rpath + ls_name
	
	ll_row = ids_dirlist.insertrow(0)
	If ll_start = 0 Then ll_start = ll_row //ids_dirlist start row
	ids_dirlist.setitem(ll_row,'parent_name', as_name)
	ids_dirlist.setitem(ll_row,'level', ai_level)
	ids_dirlist.setitem(ll_row,'item_name', ls_name)
	ids_dirlist.setitem(ll_row,'item_type', ls_type)
	ids_dirlist.setitem(ll_row,'item_modify_time', ldt_modifytime)
	ids_dirlist.setitem(ll_row,'item_path', ls_fullpath)
Next
ll_end = ll_row

//Open Next level Directory
li_level = ai_level + 1
ll_find = ids_dirlist.Find('level = '+ string(ai_level) + " and item_type ='Directory'", ll_start, ll_end)
Do while (ll_find > 0 and (li_rtn = 1))
	ls_fullpath = ids_dirlist.GetItemString(ll_find, 'item_path')
	ls_name= ids_dirlist.GetItemString(ll_find, 'item_name')
	
	li_rtn = of_listdir(ls_fullpath, li_level, ls_name)
	
	ll_start = ll_find + 1
	If ll_start > ll_end Then Exit
	ll_find = ids_dirlist.Find('level = '+ string(ai_level) + " and item_type ='Directory'", ll_start, ll_end)
Loop

Return li_rtn

end function

public function integer of_check_result ();//====================================================================
//$<Function>: of_check_result
//$<Arguments>:
//$<Return>:  int
//$<Description>: Check OLE method process result
//$<Author>: (Appeon) long.zhang 06.12.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return of_check_result('')
end function

public function integer of_connect (str_ftp_parms astr_parms);//====================================================================
//$<Function>: of_connect
//$<Arguments>:
// 	value    str_ftp_parms    astr_parms
//$<Return>:  integer 1: success/ -1:connect fail/ -2:listdir fail/ -3:Disconnect fail
//$<Description>: Connect to ftp server by astr_parms argument.
//$<Author>: (Appeon) long.zhang 07.01.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_hostname
String ls_port
Int li_protocol
String ls_login
String ls_password
boolean lb_passive = true

ls_hostname = Trim(astr_parms.hostname)
ls_port = Trim(astr_parms.port)
ls_login = Trim(astr_parms.login)
ls_password = Trim(astr_parms.password)
li_protocol = astr_parms.protocol
Choose Case li_protocol
	  	Case 4// 'FTPSimplicit' //FTPSimplicit 4 FTP+SSL implicit on port 990. 
			lb_passive = False
		Case Else
			lb_passive = True
 End Choose

Return this.of_connect(ls_hostname, ls_port, li_protocol, ls_login, ls_password, lb_passive )

end function

public function long of_getsize (string as_path, boolean ab_local);//====================================================================
//$<Function>: of_getsize
//$<Arguments>:
// 	value    string    as_path
//$<Return>:  long 	-1:no path/ -2:getsize fail/ -3:remote file is too large
//										/-4:local file not exists or larger then 2G
//										/else:the byte size 
//$<Description>: Get remote file size
//$<Author>: (Appeon) long.zhang 07.01.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long i, j

If ab_local = False Then//Remoth path
	If IsNull(as_path) or as_path = '' Then 
		of_display("Get File Error. No RemotePath.")
		return -1
	End If
	
	Try
		i = iole_ftp.GetSize(as_path)
	Catch(runtimeerror ret)
	END TRY 
	
	j = of_check_result('Get Size')
	If j < 0 Then
		Return -2
	End If
	
	//larger then 2G
	If i <0 Then
		Return -3
	End If
Else//local path
	i = FileLength(as_path) //bytes
	//File not exists or larger then 2G
	If i <0 Then 
		Return -4
	End If	
End If
	
Return i
end function

public function Integer of_wait ();//====================================================================
//$<Function>: of_wait
//$<Arguments>:
//$<Return>:  1:success / -1: timeout and aborted.
//$<Description>: Wait it when transfering files in no blocking model.
//$<Author>: (Appeon) long.zhang 06.12.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_start
Long ll_now
Long i
Long ll_size
String ls_rpath

ll_start = Cpu ()
Do While (i < WAIT_SECONDS)	
	Yield()
	ll_now = Cpu ()
	If (ll_now - ll_start) > i*1000 Then //Fresh it each second
		If this.of_get_state() <> STATE_CONNECTED Then		
			ll_now = Cpu ()
			If (ll_now - ll_start) > i*1000 Then 
				i++	
				of_show_transinfo()
			End If
		Else
			//Done, Stop Processing
			of_display('100%')
			of_progressbar_move(100)
			Exit
		End If
	End If
Loop

If i = WAIT_SECONDS Then 
	of_abort()
	Return -1
End If

Return 1
end function

on n_cst_ftp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ftp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if IsValid(iole_ftp) then
	iole_ftp.Disconnect()
	iole_ftp.DisconnectObject()
	Destroy iole_ftp
end if

Destroy ids_dirlist
end event

event constructor;of_createobject()

//Store current dir list
ids_dirlist = create datastore
ids_dirlist.dataobject = 'd_ftp_dirlist'


end event

