$PBExportHeader$n_cst_reg_control.sru
forward
global type n_cst_reg_control from nonvisualobject
end type
end forward

global type n_cst_reg_control from nonvisualobject autoinstantiate
end type

type prototypes

end prototypes

type variables
String is_check_result[]

//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
//String is_module_name[] = {'Office','Email','Imaging 360','New Imaging','POP3','POP3 Message','Sertifi Electronic Signature','Email SSL'}
//Boolean ib_ocx_checked[] = {False,False,False,False,False,False,False,False}
String is_module_name[] = {'Office','Email','Imaging 360','New Imaging','POP3','POP3 Message','Sertifi Electronic Signature','Email SSL', 'IMAP4','EAGetMailObj','EASendMailObj', 'FTP','HTTP' } // 'FTP','HTTP', Added by Appeon long.zhang 07.23.2015 (v15.1 CAQH Roster Automation)
Boolean ib_ocx_checked[] = {False,False,False,False,False,False,False,False, False, False, False, False, False}
//---------End Modfiied ------------------------------------------------------------------

//V12.1 Web component - alfee 04.21.2012
String LOCAL_PATH 
String is_ocx_files[]  

//V12.3 Cab - alfee 04.14.2013
String Is_WebComponents = "webcomponents_v153.exe" //alfee 11.18.2015 //Stephen 10.09.2017 modified 'webcomponents_v151.exe' to 'webcomponents_v153.exe'
Boolean ib_imaging_instance = True 



end variables

forward prototypes
public function string of_geterrormessage (long al_errorno)
public function string of_register (string as_control, boolean ab_displayerror)
public function boolean of_check_instance_ocx (string as_prog_id)
public function string of_check_all_ocxs (boolean ab_show_error)
public subroutine of_show_message (string as_module_name, string as_error_info)
public subroutine of_reset_check_flag (integer ai_ocx_num)
public function boolean of_isdownload_ocx ()
public function boolean of_download_ocx ()
public subroutine of_reset_check_result (integer ai_ocx_num)
public function integer of_upgrade_ocxs ()
public function boolean of_isdownload_webcomponent ()
public function boolean of_download_webcomponent ()
public function integer of_set_imaging_instance (boolean ab_check)
public function integer of_filecopy_exists (string as_source, string as_target, boolean abln_replace)
public function string of_check_ocx (integer ai_control, string as_ocx_name, boolean ab_show_error, ref string as_filepath)
public function string of_check_ocx (integer ai_control, string as_ocx_name, boolean ab_show_error)
public function string of_check_ocx_extra (integer ai_control)
end prototypes

public function string of_geterrormessage (long al_errorno);string ls_Error

choose case al_ErrorNo
	case -1
		ls_Error = "Exception happened when invoking the DllRegisterServer function."
	case else		
		ls_Error = "Your Windows login account may not have proper rights or unknown errors occurred."
end choose

Return ls_Error
end function

public function string of_register (string as_control, boolean ab_displayerror);string ls_Error,ls_ocxs
long ll_Result
Integer li_module_num

//Change instance variables to local variables for n_cst_reg_xxx - workaround PB's bug - alfee 07.16.2013
// Register controls
choose case Lower(as_Control)
	case "officecontrol.ocx"
		li_module_num = 1
		n_cst_reg_officecontrol lnv_officecontrol
		ll_Result = lnv_officecontrol.of_Register()
	case "emsmtp.dll"
		li_module_num = 2
		n_cst_reg_emsmtp lnv_emsmtp
		ll_Result = lnv_emsmtp.of_Register()
	case "imageviewer2.ocx"
		li_module_num = 4
		n_cst_reg_imageviewer2 lnv_imageviewer2
		ll_Result = lnv_imageviewer2.of_Register()
	case "imagethumbnailcp.ocx"
		li_module_num = 4
		n_cst_reg_imagethumbnailcp lnv_imagethumbnailcp
		ll_Result = lnv_imagethumbnailcp.of_Register()
	case "scanner.ocx"
		li_module_num = 4
		n_cst_reg_scanner lnv_scanner
		ll_Result = lnv_scanner.of_Register()
	//	
	case "imgedit.ocx"
		li_module_num = 3		
		n_cst_reg_imgedit lnv_imgedit
		ll_Result = lnv_imgedit.of_Register()
	case "imgscan.ocx"
		li_module_num = 3
		n_cst_reg_imgscan lnv_imgscan		
		ll_Result = lnv_imgscan.of_Register()
	case "imgadmin.ocx"
		li_module_num = 3
		n_cst_reg_Imgadmin lnv_imgadmin
		ll_Result = lnv_Imgadmin.of_Register()
	case "imgocr.ocx"
		li_module_num = 3
		n_cst_reg_Imgocr lnv_imgocr
		ll_Result = lnv_imgocr.of_Register()
	case "imgthumb.ocx"
		li_module_num = 3
		n_cst_reg_Imgthumb lnv_imgthumb
		ll_Result = lnv_imgthumb.of_Register()
	//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
	case "empop3.dll"	
		li_module_num = 5
		n_cst_reg_empop3 lnv_empop3	
		ll_Result = lnv_empop3.of_Register()		
	case "emmsg.dll"	
		li_module_num = 6
		n_cst_reg_emmsg lnv_emmsg	
		ll_Result = lnv_emmsg.of_Register()	
	case 'emssl.dll'		
		li_module_num = 8
		n_cst_reg_emssl lnv_emssl
		ll_Result = lnv_emssl.of_Register()
	//---------End Added ------------------------------------------------------------------
	//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
	case 'emimap4.dll'		
		li_module_num = 9
		n_cst_reg_emimap4 lnv_emimap4  
		ll_Result = lnv_emimap4.of_Register()	
	//---------End Added ------------------------------------------------------
	
	//---------Begin Added by alfee 05.13.2016 -----------------------------
	case 'eagetmailobj.dll'	
		li_module_num = 10
		n_cst_reg_eagetmailobj lnv_eagetmailobj
		ll_Result = lnv_eagetmailobj.of_Register()	
	case 'easendmailobj.dll'
		li_module_num = 11
		n_cst_reg_easendmailobj lnv_easendmailobj
		ll_Result = lnv_easendmailobj.of_Register()	
	//----------End Added -------------------------------------------------------	

	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 07.23.2015
	//<$>reason:v15.1 CAQH Roster Automation	
	//case 'wodFtpDLX.dlll'		
	case 'wodftpdlx.dll'	//alfee 05.13.2016	
		li_module_num = 12
		n_cst_reg_ftp lnv_ftp 
		ll_Result = lnv_ftp.of_Register()	
	//case 'wodHttp.ocx'		
	case 'wodhttp.ocx'	 //alfee 05.13.2016
		li_module_num = 13
		n_cst_reg_http lnv_http
		ll_Result = lnv_http.of_Register()	
	//------------------- APPEON END -------------------	
end choose


// Prompt error if error occur
If AppeonGetClientType() = 'PB' Then
	if ll_Result <> 0 then
		of_reset_check_flag(li_module_num)
		If This.of_check_ocx(li_module_num,Lower(as_Control), false) = '' Then 
			//Failed to Register, but it is usable. because administrator has registered it.
			ls_error = '' 
		Else
			//messagebox("ff","")
			ls_Error = "Failed to register '" + as_Control + "', error code = " + String(ll_Result) +'. '+ of_GetErrorMessage(ll_Result)
			ls_ocxs = as_Control
			if ab_DisplayError then
				ls_Error += of_GetErrorMessage(ll_Result) + ". Please contact the system administrator."
				
				//MessageBox("Register Error (Error Code = " + String(ll_Result) + ")", ls_Error, StopSign!)
			end if
			//messagebox(ls_Error,"end")
		End If
	end if
Else
	of_reset_check_flag(li_module_num)
	If This.of_check_ocx(li_module_num,Lower(as_Control), ab_displayerror) <> '' Then
		ls_ocxs = as_Control
	End If
End If


//Return ls_Error
Return ls_ocxs

end function

public function boolean of_check_instance_ocx (string as_prog_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_reg_control::of_check_instance_ocx()
// $<arguments>
//		value	string	as_prog_id	//OCX's Prog ID.	
// $<returns> boolean
// $<description> Check OCX whether usable By instance it.
//////////////////////////////////////////////////////////////////////
// $<add> 11.05.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_rc
oleobject lole_check

lole_check = CREATE oleobject
li_rc = lole_check.ConnectToNewObject(as_prog_id)
If isvalid(lole_check) Then Destroy lole_check

IF li_rc <> 0 THEN
   Return False
Else
	Return True
END IF

Return True

end function

public function string of_check_all_ocxs (boolean ab_show_error);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_reg_control::of_check_all_ocxs()
// $<arguments>(None)
// $<returns> string
// $<description> Check All OCXs.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.04.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
String ls_return,ls_error
Integer li_cnt
String ls_module_names
//---------Begin Modified by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
//   li_cnt = 4   
//
//	For i = 1 to li_cnt
//		If i = 3 Then //Imaging 360
//			If gi_imageocx <> 1 Then Continue
//		End If
//		
//		/*  Comment it. always need check New Image OCX
//		If i = 4 Then //New Image.
//			If gi_imageocx <> 2 Then Continue
//		End If
//		*/
//		
//		ls_return = of_check_ocx(i,'',False)
//		If ls_return <> '' Then
//			ls_error += ls_return + ', '
//			If i < UpperBound(is_module_name[]) Then Continue
//			ls_module_names += is_module_name[i] + ' & '
//		End If
//		is_check_result[i] = MidA(ls_error,1,LenA(ls_error) - 2)
//	Next

//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
//  li_cnt = 8   
li_cnt =  11 		//Added By Mark Lee 07/08/2013
//---------End Modfiied ------------------------------------------------------

	For i = 1 to li_cnt
		If i = 3 Then //Imaging 360
			If gb_contract_version Then Continue
		End If
		
		//Added By Ken.Guo 08/13/2012.  User should install SOAPSDK.exe
		If i = 7 Then
			Continue
		End If
		
		ls_return = of_check_ocx(i,'',False)
		If ls_return <> '' Then
			ls_error += ls_return + ', '
			If i < UpperBound(is_module_name[]) Then Continue
			ls_module_names += is_module_name[i] + ' & '
		End If
		is_check_result[i] = MidA(ls_error,1,LenA(ls_error) - 2)
	Next
//---------End Modfiied ------------------------------------------------------------------

ls_module_names = MidA(ls_module_names,1,LenA(ls_module_names) - 3)
ls_error = MidA(ls_error,1,LenA(ls_error) - 2)
If ls_error <> '' and ab_show_error Then
	
	of_show_message(ls_module_names, ls_error)
	
End If

Return ls_error
end function

public subroutine of_show_message (string as_module_name, string as_error_info);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_reg_control::of_show_message()
// $<arguments>
//		value	string	as_module		
//		value	string 	as_error_info		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.05.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////
//messagebox("",as_module_name)

//If as_error_info = '' Then Return 
//If Pos(as_module_name,'&',1) > 0 Then //Multi modules
//	Messagebox(as_module_name +' functions are unusable',as_error_info,Exclamation!)
//Else
//	Messagebox(as_module_name +' function is unusable',as_error_info,Exclamation!)
//End If

f_show_message('OCX Issue','%1S%',as_error_info,'','')
end subroutine

public subroutine of_reset_check_flag (integer ai_ocx_num);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_reg_controlof_reset_check_flag()
// $<arguments>
//		value	integer	ai_ocx_num	0: all OCXs.	
// $<returns> (none)
// $<description>
// $<description> Reset All OCX's check status
//////////////////////////////////////////////////////////////////////
// $<add> 11.07.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
If ai_ocx_num = 0 Then
	For i = 1 To UpperBound(ib_ocx_checked[])
		ib_ocx_checked[i] = False
	Next
Else
	ib_ocx_checked[ai_ocx_num] = False
End If
end subroutine

public function boolean of_isdownload_ocx ();//Determine if the OCX and DLL files are downloaded except the files of Imaging for Windows
//(V12.1 Web Component) - alfee 04.21.2012

Integer i 

For i = 1 to UpperBound(is_ocx_files)
	If Not FileExists(LOCAL_PATH + is_ocx_files[i]) Then Return False
Next

Return True
end function

public function boolean of_download_ocx ();//Download all OCX and DLL files except the files of Imaging for Windows
//(V12.1 Web Component) - alfee 04.21.2012

string ls_file_list[]
long ll_count,ll_i,ll_ret
n_appeon_download lnv_download

openwithparm( w_appeon_gifofwait, "Downloading the DLL/OCX files from Server, Please stand by...")
					 
ll_count = UpperBound(is_ocx_files)

for ll_i = 1 to ll_count
	ll_ret = lnv_download.of_downloadfile("",LOCAL_PATH + is_ocx_files[ll_i])
	if ll_ret <> 0 then exit
next

if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

if ll_i <= ll_count then
	MessageBox("Download infomation","Failed to download the DLL/OCX files, Call support.")
	return false
end if

return true
end function

public subroutine of_reset_check_result (integer ai_ocx_num);// $<function>n_cst_reg_control.of_reset_check_result()
// $<arguments>
//		value	integer	ai_ocx_num	0: all OCXs.	
// $<returns> (none)
// $<description>
// $<description> Reset All OCX's check result
//////////////////////////////////////////////////////////////////////
// $<add> 03.20.2013 by Alfee 
//////////////////////////////////////////////////////////////////////

Integer i

If ai_ocx_num = 0 Then
	For i = 1 To UpperBound(is_check_result[])
		is_check_result[i] = ""
	Next
Else
	is_check_result[ai_ocx_num] = ""
End If
end subroutine

public function integer of_upgrade_ocxs ();//////////////////////////////////////////////////////////////////////////////////////
// $<function>n_cst_reg_control::of_upgrade_ocxs()
// $<arguments>
// $<returns> integer 1 - failed; 0 - not upgraded ; 1 - upgraded
// $<description>Check and upgrade OCXs if necessary
// $<Reason>The new version OCX files in the Cab cannot be automatically 
// $<Reason>installed to the %appdata% folder by IE as a security limit. 
//////////////////////////////////////////////////////////////////////////////////////
// $<add> 04.14.2013 by Alfee (for V12.3 Cab)
//////////////////////////////////////////////////////////////////////////////////////

IF appeongetclienttype() <> 'WEB' THEN RETURN 0

Integer li_rtn
Long i, ll_file_size[], ll_file_sign_size[], ll_length[], ll_null
String ls_Key_OCX[], ls_value[], ls_key_path, ls_null
Boolean lb_upgraded = TRUE
n_cst_AppeonDll lnv_Appeon

//Initialization for imageviewer2.ocx
ls_key_path = "\IntelliSoft Group LLC\Web Components\"
//---------Begin Added by (Appeon)Stephen 11.28.2017 for imageview cp upgrade--------
if not DirectoryExists(LOCAL_PATH+"dictfiles") then
	if fileexists(LOCAL_PATH+"dictfiles.zip") then
		ChangeDirectory(LOCAL_PATH) 
		run("7z x dictfiles.zip" , Minimized!)	
		sleep(1000)
		yield()
		ChangeDirectory(gs_current_path)
	end if	
end if
//---------End Added ------------------------------------------------------

//---------Begin Modified by (Appeon)Stephen 09.06.2017 for imageview cp upgrade--------
//ll_file_size[1] = 2629632 //7.5 
ll_file_size[1] = 2693080 //10.5  //(Appeon)Stephen 11.24.2017 for imageview cp upgrade
//---------End Modfiied ------------------------------------------------------
ll_file_sign_size[1] = 2635736 //2635792 //V7.5 signed  - alfee 02.24.2016
ls_Key_OCX[1] = "HKEY_CLASSES_ROOT\TypeLib\{C9460280-3EED-11D0-A647-00A0C91EF7B9}\1.0\0\win32"

//Check OCXs
FOR i = 1 to UpperBound(ls_Key_OCX)
	//Get the registry path and return if not registered yet
	lnv_Appeon.of_registryget(ls_Key_OCX[i],"", RegString!, ls_value[i])
	IF ls_value[i] = "" or IsNull(ls_value[i]) THEN RETURN 0 
	
	//Determine if it's an older version ocx file under the %appdata% folder
	IF Pos(Lower(ls_value[i]), Lower(ls_key_path)) > 0 THEN 
		ll_length[i] = FileLength(ls_value[i])
		IF ll_length[i] <> ll_file_size[i] and ll_length[i] <> ll_file_sign_size[i] THEN 
			lb_upgraded = FALSE
			EXIT
		End If				
	END IF
NEXT

//Upgrade OCXs
IF NOT lb_upgraded THEN
	IF NOT of_isdownload_webcomponent () THEN	
		IF NOT of_download_webcomponent () THEN
			RETURN -1
		END IF	
	END IF
	
	IF NOT FileExists(LOCAL_PATH + Is_WebComponents) THEN 
		RETURN -1
	END IF
	
	li_rtn = MessageBox("IntelliSoft Web Components", "The system will upgrade IntelliSoft Web Components on your machine. Click OK to continue?", Question!, OKCancel!)
	IF li_rtn = 1 THEN
		setnull(ls_null)
		setnull(ll_null)
		//Use the ShellExecuteA () to avoid the UAC limit
		ShellExecuteA (ll_null, "open", LOCAL_PATH + Is_WebComponents, ls_Null, ls_Null, 4)	
		//Reset the check flag
		//of_reset_check_flag(4) 
	END IF	
END IF

RETURN 1
end function

public function boolean of_isdownload_webcomponent ();//Check if the Setup file for Web Components is downloaded - alfee 04.14.2013 (V12.3 Cab)

if FileExists(LOCAL_PATH + Is_WebComponents)  then
	return true 
else
	return false
end if
end function

public function boolean of_download_webcomponent ();//Download the setup file for Web Components from the Templates folder 
//in case the automatic download was failed somehow
//(V12.3 Cab) alfee 04.14.2013

long ll_ret
n_appeon_download lnv_download

openwithparm( w_appeon_gifofwait, "Downloading the setup file for Web Components from Server, Please stand by...")

ll_ret = lnv_download.of_downloadfile("", LOCAL_PATH + Is_WebComponents)
if ll_ret <> 0 then
	MessageBox("Download infomation","Failed to download the " + Is_WebComponents + " file, Call support.")
	if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	return false
end if

if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

return true
end function

public function integer of_set_imaging_instance (boolean ab_check);//Set the flag to check the Imaging 360 instance - alfee 04.14.2013 (V12.3 Cab)

ib_imaging_instance = ab_check

RETURN 1
end function

public function integer of_filecopy_exists (string as_source, string as_target, boolean abln_replace);//====================================================================
// Function: of_filecopy_exists
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_source
//                as_target
//                abln_replace
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 05/28/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//(Appeon)Toney 06.06.2013 - V141 ISG-CLX
//====================================================================
Integer	li_FileNum

IF FileExists(as_source) = True Then
//	IF Not(FileExists(as_target) = True ) Then
		li_FileNum = FileCopy (as_source,  as_target, abln_replace)
		IF li_FileNum = 1 Then 
			return 1
		ElseIf  li_FileNum = -1 Then 
			//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
			//messagebox('Error Source file', 'The file: ' + as_source +' Could not be written. Please make sure the path exists and you have FULL permissions to it' )
			messagebox('Error Source file', 'Failed to copy the file ' +as_source + ' to '+as_target+'. Please make sure the path exists and you have FULL permissions to it' )
			//---------End Modfiied ------------------------------------------------------
			return - 1
		ElseIf  li_FileNum = -2 Then 
			//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
			//messagebox('Error Targret file', 'The Fax directory : ' + as_target +' Could not be opened. Please make sure the path exists and you have FULL permissions to it' )
			messagebox('Error Targret file', 'Failed to copy the file ' +as_source + ' to '+as_target+'. Please make sure the path exists and you have FULL permissions to it' )
			//---------End Modfiied ------------------------------------------------------
			return - 2
		End If
//	End If
End If
					

end function

public function string of_check_ocx (integer ai_control, string as_ocx_name, boolean ab_show_error, ref string as_filepath);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_reg_control::of_check_ocx()
// $<arguments>
//		value	integer	as_control	
//							1: Office OCX; 
//							2: Email OCX;
//							3: New Image OCXs; 
//							4: Imaging360 OCXs	
//							5: empop3 OCX;
//							6: emmsg OCX;
//							7: Sertifi Electronic Signature;
//							8: Email SSL
//		value string 	as_ocx_name . if it is '', check all OCXs of this type control.
//		value boolean	ab_show_error
//		ref string as_filepath  
// $<returns> string
// $<description> Check OCX. If it is unusable, then return error string.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.04.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i, li_rtn, li_num
Long ll_file_size[], ll_file_sign_size[] //alfee 03.19.2013
Long ll_length
Long ll_cur_file_size
Long ll_dll_size[], ll_dll_sign_size[]
String ls_module_name
String ls_key
String ls_Value
String ls_ocx_names[]  //For multi-OCXs
String ls_Key_OCXs[]   //For multi-OCXs
String ls_Key_OCXs_urp[] //For imagecp upgrade
String ls_return
String ls_prod_id[] 
String ls_null, ls_url, ls_url_rtn //alfee 04.21.2012
String ls_copydll[], ls_plugindir, ls_path, ls_file_version[]
n_cst_AppeonDll	lnv_Appeon
n_cst_filesrv lnv_filesrv 

lnv_filesrv = Create n_cst_filesrv
ls_plugindir = LOCAL_PATH //(Appeon)Alfee 07.19.2013 - V141 ISG-CLX

If ib_ocx_checked[ai_control] Then 
		ls_return = is_check_result[ai_control]
Else
	//Check OCX
	choose case ai_control
		case 1 //"officecontrol.ocx"
			ls_key	 = "HKEY_CLASSES_ROOT\CLSID\{C9BC4E0F-4248-4a3c-8A49-63A7D317F404}\InprocServer32" //alfee 11.12.2013						
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)
			ll_cur_file_size = 1584264  //5.0.2.4 signed- Alfee 11.12.2013
			If ls_value = '' or (Not FileExists(ls_value)) or (Not This.of_check_instance_ocx('NTKO.OfficeControlPB')) Then //alfee 11.12.2013						
				ls_return = "officecontrol.ocx"
			End If			
			If FileLength(ls_value) <> ll_cur_file_size Then
				ls_return = "officecontrol.ocx"
			End If
			ib_ocx_checked[ai_control] = True
		case 2 //"emsmtp.dll"
			ls_Key = "HKEY_CLASSES_ROOT\CLSID\{DAFA4BF6-C807-463c-8745-C9E0C90CF84F}\InprocServer32" 
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)
			If ls_value = '' or Not This.of_check_instance_ocx('EasyMail.SMTP.6.5') Then
				ls_return = "emsmtp.dll"
			End If		
			ib_ocx_checked[ai_control] = True
		case 3 //Imaging 360 OCXs
			//If gi_imageocx <> 1 Then 	
			If gb_contract_version Then //(Appeon)Toney 06.07.2013 for V141 ISG-CLX
				ls_return = ''			
			Else
				ls_ocx_names[1] = "imgedit.ocx"
				ls_ocx_names[2] = "imgscan.ocx"
				ls_ocx_names[3] = "imgadmin.ocx"
				ls_ocx_names[4] = "imgocr.ocx"
				ls_ocx_names[5] = "imgthumb.ocx"
				ls_Key_OCXs[1] = "HKEY_CLASSES_ROOT\CLSID\{6D940280-9F11-11CE-83FD-02608C3EC08A}\InprocServer32"
				ls_Key_OCXs[2] = "HKEY_CLASSES_ROOT\CLSID\{84926CA0-2941-101C-816F-0E6013114B7F}\InprocServer32"
				ls_Key_OCXs[3] = "HKEY_CLASSES_ROOT\CLSID\{009541A0-3B81-101C-92F3-040224009C02}\InprocServer32"
				ls_Key_OCXs[4] = "HKEY_CLASSES_ROOT\CLSID\{8FC248E3-D4D9-11CF-8727-0020AFA5DCA7}\InprocServer32"
				ls_Key_OCXs[5] = "HKEY_CLASSES_ROOT\CLSID\{E1A6B8A0-3603-101C-AC6E-040224009C02}\InprocServer32"		
				ls_prod_id[1] = "Imaging.EditCtrl.1"
				ls_prod_id[2] = "Imaging.ScanCtrl.1"
				ls_prod_id[3] = "Imaging.AdminCtrl.1"
				ls_prod_id[4] = "Imaging.OcrCtrl.1"
				ls_prod_id[5] = "Imaging.ThumbnailCtrl.1"
				
				For i = 1 To Upperbound(ls_Key_OCXs[])	
					If as_ocx_name <> '' and lower(as_ocx_name) <> lower(ls_ocx_names[i]) Then Continue //Only check special OCX					
					ls_Value = ''	
					lnv_Appeon.of_registryget(ls_Key_OCXs[i],"", RegString!, ls_Value)					
					//-------------Begin Modified by alfee 04.14.2013(V12.3 Cab) ----------------------------------
					//<$Reason>Skip checking instance while opening the mdi window as Checking instances 
					//<$Reason>for Imaging OCXs will cause files in Cab failed to download. 
					If Not ib_imaging_instance Then
						If ls_value = '' or Not FileExists(ls_value) Then ls_return += ls_ocx_names[i]+', '
					ElseIf ls_value = '' or Not This.of_check_instance_ocx(ls_prod_id[i]) Then	
					//If ls_value = '' or Not This.of_check_instance_ocx(ls_prod_id[i]) Then	
					//--------------End Modified -----------------------------------------------------------------------
						ls_return += ls_ocx_names[i]+', '
					End If		
				Next
				ls_return = MidA(ls_return,1,LenA(ls_return) - 2)
				If as_ocx_name = ls_ocx_names[Upperbound(ls_ocx_names)] or as_ocx_name = '' Then 
					ib_ocx_checked[ai_control] = True
				End If
			End If
		case 4 //Image Viewer CP OCXs
			ls_ocx_names[1] = "imageviewer2.ocx"
			ls_ocx_names[2] = "imagethumbnailcp.ocx"
			ls_ocx_names[3] = "scanner.ocx"
			ls_Key_OCXs[1] = "HKEY_CLASSES_ROOT\TypeLib\{C9460280-3EED-11D0-A647-00A0C91EF7B9}\1.0\0\win32"
			ls_Key_OCXs[2] = "HKEY_CLASSES_ROOT\TypeLib\{C08027D6-71EE-4936-AC1F-3F188E8889A3}\1.0\0\win32"		
			ls_Key_OCXs[3] = "HKEY_CLASSES_ROOT\CLSID\{20666F83-3F1D-4211-9DBF-2FF783A18E18}\InprocServer32"
			//---------Begin Added by (Appeon)Stephen 09.11.2017 for imageview cp upgrade--------
			ls_Key_OCXs_urp[1] = ""
			ls_Key_OCXs_urp[2] = "HKEY_CLASSES_ROOT\TypeLib\{51F37CDE-2D78-495D-8B30-D57ABDA60369}\1.0\0\win32"		
			ls_Key_OCXs_urp[3] = ""
			//---------End Added ------------------------------------------------------
			ls_prod_id[1] = "SCRIBBLE.ScribbleCtrl.1"
			ls_prod_id[2] = "IMAGETHUMBNAILCP.ImageThumbnailCPCtrl.1"
			ls_prod_id[3] = "SCANNER.ScannerCtrl.1"

			//---------Begin Modified by (Appeon)Stephen 09.06.2017 for imageview cp upgrade--------
			//ll_file_size[1] = 2629632 //7.5 
			//ll_file_size[3] = 180224	//3.8			
			ll_file_size[2] = 1804272 //4.6	--5.5	
			ll_file_size[1] = 2693080 //10.5  //(Appeon)Stephen 11.24.2017 for imageview cp upgrade
			ll_file_size[3] = 931800	//7.0.0.1
			//---------End Modfiied ------------------------------------------------------
			ll_file_sign_size[1] = 2636904 //7.5
			ll_file_sign_size[4] = 2635736 //7.5.0.5 Singed - alfee 02.24.2016
			ll_file_sign_size[5] = 2635792 //7.5.0.4 Singed - alfee 01.25.2017	
			//ll_file_sign_size[4] = 2635792 //for Cab - alfee 09.25.2013
			//----------Begin Added by (Appeon)Alfee 07.19.2013 - V141 ISG-CLX -------------------------
			ll_file_sign_size[2] = 1805416 
			ll_file_sign_size[3] = 187496			
			//----------End Added -------------------------------------------------------------------------------

			For i = 1 To Upperbound(ls_Key_OCXs[])	
				If as_ocx_name <> '' and lower(as_ocx_name) <> lower(ls_ocx_names[i]) Then Continue //Only check special OCX

				ls_Value = ''	
				lnv_Appeon.of_registryget(ls_Key_OCXs[i],"", RegString!, ls_Value)
				//---------Begin Added by (Appeon)Stephen 09.11.2017 for V15.4-WebView Reporting Functionality--------
				if isnull(ls_Value) or ls_Value = '' or not fileexists(ls_Value) then
					lnv_Appeon.of_registryget(ls_Key_OCXs_urp[i],"", RegString!, ls_Value)
				end if
				//---------End Added ------------------------------------------------------
				
				ll_length = FileLength(ls_value)
				//If ls_value = '' or (i = 1 and FileLength(ls_value) <> ll_file_size[1] and FileLength(ls_value) <> ll_file_sign_size[1]) THEN 
				If ls_value = '' or (FileLength(ls_value) <> ll_file_size[i] and FileLength(ls_value) <> ll_file_sign_size[i]) THEN // (Appeon)Alfee 07.19.2013 - V141 ISG-CLX
					//If i <> 1 Or  (i = 1 And FileLength(ls_value) <> ll_file_sign_size[4]) Then //Add if statement - Alfee 09.25.2013
					If i <> 1 Or  (i = 1 And FileLength(ls_value) <> ll_file_sign_size[4] And FileLength(ls_value) <> ll_file_sign_size[5]) Then //alfee 01.25.2017
						ls_return += ls_ocx_names[i]+', '
					End If
				End If		
				
				//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------					
				//Move the same directory if don't exists in current directory
				//IF i = 1 and ( isnull(ls_return ) or trim(ls_return) = '' ) Then
				If appeongetclienttype () = "WEB" And i = 1 And ( isnull(ls_return ) Or trim(ls_return) = '' ) Then //(Appeon)Alfee 07.19.2013 - V141 ISG-CLX		
					ls_path =  left(ls_value,LastPos(ls_value,'\'))
					ls_copydll[1] =  'viscomocr.dll' 
					ls_copydll[2] =  'viscompsd.dll' 
					ls_copydll[3] =  'TIFF2PDF.dll' 
					ls_copydll[4] =  'viscomdocx.dll' 
					//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
					//ls_copydll[5] =  'msvcrt.dll' 
					//ls_copydll[6] =  'viscompdf.dll' 
					ls_copydll[5] =  'viscompdf.dll' 
					//---------End Modfiied ------------------------------------------------------
					
					//---------Begin Modified by (Appeon)Stephen 09.07.2017 for imageview cp upgrade--------
					/*
					ll_dll_size[1]	=	1105920
					ll_dll_size[2]	= 282624
					ll_dll_size[3]	= 1314816
					ll_dll_size[4]	= 792064 
					//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
					//ll_dll_size[5]	= 290869
					//ll_dll_size[6]	=  520192
					ll_dll_size[5]	=  520192
					//---------End Modfiied ------------------------------------------------------
					*/
					ll_dll_size[1]	=	2927576//2921472  //10.5  //(Appeon)Stephen 11.24.2017 -  for imageview cp upgrade
					ll_dll_size[2]	= 288728
					ll_dll_size[3]	= 1886680
					ll_dll_size[4]	= 798168 
					ll_dll_size[5]	=  693208
					//---------End Modfiied ------------------------------------------------------

					ll_dll_sign_size[1] = 1113192
					ll_dll_sign_size[2] = 289896 
					ll_dll_sign_size[3] = 1322088
					ll_dll_sign_size[4] = 799336 
					//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
					//ll_dll_sign_size[5] = 298144
					//ll_dll_sign_size[6] = 527464
					ll_dll_sign_size[5] = 527464
					//---------End Modfiied ------------------------------------------------------
					For li_num = 1 to Upperbound(ls_copydll)
						IF ( Not FileExists(ls_path+ls_copydll[li_num]) ) Or (FileLength(ls_path+ls_copydll[li_num]) <> ll_dll_size[li_num] and FileLength(ls_path+ls_copydll[li_num]) <> ll_dll_sign_size[li_num]  ) Then
							of_filecopy_exists(ls_PluginDir+ls_copydll[li_num] , ls_path +ls_copydll[li_num], True)							
						End If
					Next			
				//ElseIF i = 3  and ( isnull(ls_return ) or trim(ls_return) = '' ) Then
				ElseIf appeongetclienttype () = "WEB" And i = 3  And ( isnull(ls_return ) Or trim(ls_return) = '' ) Then //(Appeon)Alfee 07.19.2013 - V141 ISG-CLX
					ls_path =  left(ls_value,LastPos(ls_value,'\'))
					ls_copydll[1] =  'viscompdf.dll' 
					ll_dll_size[1]	=  693208
					ll_dll_sign_size[1] = 527464
					IF ( Not FileExists(ls_path+ls_copydll[1]) ) Or (FileLength(ls_path+ls_copydll[1]) <> ll_dll_size[1] and FileLength(ls_path+ls_copydll[1]) <> ll_dll_sign_size[1]  ) Then
						of_filecopy_exists(ls_PluginDir+ls_copydll[li_num] , ls_path +ls_copydll[li_num], True)							
					End If
				End If 
				//---------End Added ------------------------------------------------------------------
			Next
			
			ls_return = MidA(ls_return,1,LenA(ls_return) - 2)
			If as_ocx_name = ls_ocx_names[Upperbound(ls_ocx_names)] or as_ocx_name = '' Then 
				ib_ocx_checked[ai_control] = True
			End If						
		case 5 //"empop3.dll"
			ls_Key = "HKEY_CLASSES_ROOT\CLSID\{10696DE0-CF47-4ad4-B1AE-CC1F4021D65B}\InprocServer32"
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)

			If isnull(ls_Value) or trim(ls_Value) = '' Then
				ls_Key = "HKEY_CLASSES_ROOT\CLSID\{66CD7327-BA02-4152-9C9B-1AA876B5293A}\InprocServer32"
				lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)
			End If 
			
			ll_file_size[1] = 155734  
			ll_file_sign_size[1] = 163008 
			ls_file_version[1] = '6, 5, 0, 6'  
			If ls_value = '' or (Not FileExists(ls_value)) Then
				ls_return =  "empop3.dll"
			End If			
			If (FileLength(ls_value) <> ll_file_size[1] and FileLength(ls_value) <> ll_file_sign_size[1] ) or (lnv_filesrv.of_getfileversion( ls_value ) <> ls_file_version[1]) Then
				ls_return =   "empop3.dll"
			End If
			If ls_value = '' or Not This.of_check_instance_ocx('EasyMail.POP3') Then
				ls_return = "empop3.dll"
			End If		
			ib_ocx_checked[ai_control] = True			
		case 6 //"emmsg.dll"
			ls_Key = "HKEY_CLASSES_ROOT\CLSID\{0064776F-D7AB-43ed-A93B-4DFF1B8D5DEA}\InprocServer32"
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)
			
			If ls_value = '' Then
				ls_return = "emmsg.dll"
			End If		
			ib_ocx_checked[ai_control] = True	
		Case 8 //Email SSL emssl.dll 
			ls_Key = "HKEY_CLASSES_ROOT\CLSID\{54F83BAD-2B71-4578-80D2-7C40ED3D47FE}\InprocServer32"
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)

			ll_file_size[1] = 86091 
			ll_file_sign_size[1] = 93368 
			
			ls_file_version[1] = '6, 5, 0, 4' 
			If ls_value = '' or (Not FileExists(ls_value)) Then
				ls_return = "emssl.dll"
			End If

			If ( FileLength(ls_value) <> ll_file_size[1] and FileLength(ls_value) <> ll_file_sign_size[1] ) or lnv_filesrv.of_getfileversion( ls_value ) <> ls_file_version[1] Then
				ls_return =  "emssl.dll"
			End If
			ib_ocx_checked[ai_control] = True				
		//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
		Case 9	//imap4  
			ls_Key = "HKEY_CLASSES_ROOT\CLSID\{001A0031-1C07-4f03-9C9E-6E78DEC830F7}\InprocServer32"
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)

			ll_file_size[1] = 294993 
			ll_file_sign_size[1] =302792		
			
			ls_file_version[1] = '6, 5, 0, 6' 
			If ls_value = '' or (Not FileExists(ls_value)) Then
				ls_return = "emimap4.dll"
			End If

			If ( FileLength(ls_value) <> ll_file_size[1] and FileLength(ls_value) <> ll_file_sign_size[1] ) or lnv_filesrv.of_getfileversion( ls_value ) <> ls_file_version[1] Then
				ls_return =  "emimap4.dll"
			End If
			ib_ocx_checked[ai_control] = True				
		Case 10 //EAGetMailObj.dll		
			ls_Key = "HKEY_CLASSES_ROOT\CLSID\{029033B3-0CFF-452E-8832-8101FDE8D0B4}\InprocServer32"
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)
			
			ll_file_size[1] = 670208					
			ll_file_sign_size[1] =	676368			
			
			ls_file_version[1] = '4.0.0.9' 				
			If ls_value = '' or (Not FileExists(ls_value)) Then
				ls_return = "EAGetMailObj.dll"
			End If

			If ( FileLength(ls_value) <> ll_file_size[1] and FileLength(ls_value) <> ll_file_sign_size[1] ) or lnv_filesrv.of_getfileversion( ls_value ) <> ls_file_version[1] Then
				If ( FileLength(ls_value) <> 623616 and FileLength(ls_value) <> 629776 ) or lnv_filesrv.of_getfileversion( ls_value ) <>  '4.0.0.5'  Then
					ls_return =  "EAGetMailObj.dll"
				end if 
			End If
			ib_ocx_checked[ai_control] = True	
		Case 11 //EASendMailObj.dll		
			ls_Key = "HKEY_CLASSES_ROOT\CLSID\{036C2F8C-8D3C-4F4B-9B36-3B6F1D29C0B4}\InprocServer32"
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)
			
			ll_file_size[1] = 504320 
			ll_file_sign_size[1] =510480		
			
			ls_file_version[1] = '6.0.0.1' 
			If ls_value = '' or (Not FileExists(ls_value)) Then
				ls_return = "EASendMailObj.dll"
			End If

			If ( FileLength(ls_value) <> ll_file_size[1] and FileLength(ls_value) <> ll_file_sign_size[1] ) or lnv_filesrv.of_getfileversion( ls_value ) <> ls_file_version[1] Then
				ls_return =  "EASendMailObj.dll"
			End If
			ib_ocx_checked[ai_control] = True	
		//---------End Added ------------------------------------------------------
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 07.23.2015
		//<$>reason:v15.1 CAQH Roster Automation
		Case 12 //FTP wodFtpDLX.dll
			ls_Key = "HKEY_CLASSES_ROOT\CLSID\{FE5B9A96-B1A7-4E8B-9713-115F51088981}\InprocServer32"
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)

			ll_file_size[1] = 1855784 
			ll_file_sign_size[1] = 1855784 //Need to change for cab 
			
			ls_file_version[1] = '3, 4, 2, 721' 
			If ls_value = '' or (Not FileExists(ls_value)) Then
				ls_return = "wodFtpDLX.dll"
			End If

			If ( FileLength(ls_value) <> ll_file_size[1] and FileLength(ls_value) <> ll_file_sign_size[1] ) or lnv_filesrv.of_getfileversion( ls_value ) <> ls_file_version[1] Then
				ls_return =  "wodFtpDLX.dll"
			End If
			ib_ocx_checked[ai_control] = True	
		Case 13 //HTTP wodHttp.ocx
			ls_Key = "HKEY_CLASSES_ROOT\CLSID\{A353B0AB-3DFD-44AD-AE21-0ADF6FAB1557}\InprocServer32"
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)

			ll_file_size[1] = 1490592
			ll_file_sign_size[1] = 1490592 //Need to change for cab 
			
			ls_file_version[1] = '1, 9, 0, 223' 
			If ls_value = '' or (Not FileExists(ls_value)) Then
				ls_return = "wodHttp.ocx"
			End If

			If ( FileLength(ls_value) <> ll_file_size[1] and FileLength(ls_value) <> ll_file_sign_size[1] ) or lnv_filesrv.of_getfileversion( ls_value ) <> ls_file_version[1] Then
				ls_return =  "wodHttp.ocx"
			End If
			ib_ocx_checked[ai_control] = True	
		//------------------- APPEON END -------------------	
		
		Case Else
			ls_return = ''
	end choose
End If

If ab_show_error and ls_return <> '' Then 
	of_show_message(is_module_name[ai_control],ls_return)
	If ai_control = 3 And appeongetclienttype() = "WEB" Then //Install imaging OCXs - alfee 04.14.2013 (V12.3 Cab)
		n_cst_imaging lnv_imaging
		li_rtn= lnv_imaging.of_install_imaging ()
	End If
End If

is_check_result[ai_control] = ls_return
If isvalid(lnv_filesrv) Then Destroy lnv_filesrv
as_filepath = ls_value 

Return ls_return

end function

public function string of_check_ocx (integer ai_control, string as_ocx_name, boolean ab_show_error);//====================================================================
//$<Function>: of_check_ocx
//$<Arguments>:
// 	value    integer    ai_control
// 	value    string     as_ocx_name
// 	value    boolean    ab_show_error
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Toney 06.07.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_filepath

Return This.of_check_ocx(ai_control, as_ocx_name, ab_show_error, ls_filepath)
end function

public function string of_check_ocx_extra (integer ai_control);//====================================================================
//$<Function>: of_check_ocx_extra()
//$<Arguments>:
// 	value    integer    ai_control
//$<Return>:  String
//$<Description>: Extra checking for OCX files - Workaround the issue of dllregister().  The dllregister ()
//$<Description>: functionality won't really register if a different version of Office OCX registered before.
//$<Author>: (Appeon) Alfee 07.17.2013 (V141 ISG-CLX)
//-----------------------------------------------------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_rtn
Long ll_cur_file_size, ll_file_sign_size []
String ls_ocx, ls_key, ls_value, ls_full_path
String ls_return
n_cst_AppeonDll lnv_Appeon

IF appeongetclienttype () = "WEB" THEN RETURN ls_return

CHOOSE CASE ai_control
	CASE 1 //"officecontrol.ocx"
			ls_ocx =  "officecontrol.ocx"	
			//ll_cur_file_size = 1569416 //5.0.2.4	- already signed - alfee 09.16.2013
			ll_cur_file_size = 1584264 //alfee 11.12.2013
			//ll_file_sign_size[1] = 582248	
			ls_full_path = LOCAL_PATH + ls_ocx			
			//ls_key	 = "HKEY_CLASSES_ROOT\CLSID\{D267E82F-8649-41ee-9121-050130B1715F}\InprocServer32" 						
			ls_key	 = "HKEY_CLASSES_ROOT\CLSID\{C9BC4E0F-4248-4a3c-8A49-63A7D317F404}\InprocServer32" //alfee 11.12.2013						
			lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)
			IF ls_value = '' OR NOT FileExists(ls_value) THEN RETURN ls_ocx
			
			//Run the register command for different versions
			IF FileLength(ls_value) <> ll_cur_file_size THEN
				IF NOT FileExists (ls_full_path)	THEN RETURN ls_ocx		
				
				li_rtn = Run ('Regsvr32 -s "' + ls_full_path + '"')

				lnv_Appeon.of_registryget(ls_Key,"", RegString!, ls_Value)	
				IF FileLength(ls_value) <> ll_cur_file_size THEN
					RETURN ls_ocx		
				END IF				
			End If		
END CHOOSE		
	
RETURN ls_return
end function

on n_cst_reg_control.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_reg_control.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//V12.1 web component - Alfee 04.21.2012

//Get path for Appeon plugin; E.g. 'C:\Documents and Settings\Administrator\Application Data\appeon\192.0.3.37_Dotnet_intellicontract8\plugin'
string ls_Path
ls_Path = Space(255)
GetDllDirectory(ls_Path)
ls_Path = Trim(ls_Path)
LOCAL_PATH = ls_Path + '\'

//Set array for ocx & dll files
is_ocx_files[1] ="OfficeControl.ocx"
is_ocx_files[2] ="emsmtp.dll"
is_ocx_files[3] ="ImageViewer2.ocx"
is_ocx_files[4] ="ImageThumbnailCP.ocx"
is_ocx_files[5] ="Scanner.ocx"
is_ocx_files[6] ="viscompdf.dll"
is_ocx_files[7] ="viscomgifenc.dll"
is_ocx_files[8] ="TIFF2PDF.dll"
is_ocx_files[9] ="msvcrt.dll"
is_ocx_files[10] ="gdiplus.dll"
//is_ocx_files[11] ="ConvertPDF.dll" 
//is_ocx_files[12] ="mfc42.dll" - downloaded with appeondll.dll
//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
is_ocx_files[11] = "emmsg.dll"
is_ocx_files[12] = "empop3.dll"
is_ocx_files[13] = "emssl.dll"
is_ocx_files[14] = "ntkoHtPkcs11.dll" //alfee 09.25.2013
is_ocx_files[15] = "ntkocmnres.dll" //alfee 09.25.2013
//---------End Added ------------------------------------------------------------------



end event

