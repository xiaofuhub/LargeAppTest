$PBExportHeader$w_environment_check.srw
forward
global type w_environment_check from w_popup
end type
type cb_clean_register from commandbutton within w_environment_check
end type
type cb_refresh from commandbutton within w_environment_check
end type
type cb_register from commandbutton within w_environment_check
end type
type gb_1 from groupbox within w_environment_check
end type
type shl_sertifi from statichyperlink within w_environment_check
end type
type dw_ocx from u_dw within w_environment_check
end type
type cb_close from commandbutton within w_environment_check
end type
type gb_2 from groupbox within w_environment_check
end type
type dw_export from u_dw within w_environment_check
end type
type gb_3 from groupbox within w_environment_check
end type
type dw_general from u_dw within w_environment_check
end type
end forward

global type w_environment_check from w_popup
integer width = 3858
integer height = 2508
string title = "Environment Check"
long backcolor = 33551856
boolean center = true
cb_clean_register cb_clean_register
cb_refresh cb_refresh
cb_register cb_register
gb_1 gb_1
shl_sertifi shl_sertifi
dw_ocx dw_ocx
cb_close cb_close
gb_2 gb_2
dw_export dw_export
gb_3 gb_3
dw_general dw_general
end type
global w_environment_check w_environment_check

forward prototypes
public function integer of_check ()
public function integer of_check_ocx ()
public function integer wf_create_cmdfile (string as_text)
end prototypes

public function integer of_check ();String ls_domainname, ls_ARCHITECTURE
n_cst_systeminfo lnv_systeminfo
n_cst_rights lnv_right
n_cst_filesrv lnv_file
n_cst_string lnv_string
n_cst_platform 	inv_platform

SetPointer(HourGlass!)
lnv_systeminfo = Create n_cst_systeminfo
lnv_right = Create n_cst_rights
lnv_file = Create  n_cst_filesrv
inv_platform = Create n_cst_platform

dw_general.setredraw(False)
dw_export.setredraw(False)
dw_ocx.setredraw(False)

//Check version
dw_general.InsertRow(0)
If lnv_systeminfo.of_get_envvar('ProgramW6432') <> '' or lnv_systeminfo.of_get_envvar('ProgramFiles(x86)')  <> '' Then //Modified By Ken.Guo 03/22/2013
	ls_ARCHITECTURE = '64-bit'
Else
	ls_ARCHITECTURE = '32-bit'
End If
String ls_os
Choose Case Left(lnv_systeminfo.of_get_os_version( ),3)
	Case '5.1'
		ls_os ='XP, '
	Case '5.2'
		ls_os = '2003, '
	Case '6.0'
		ls_os = 'Vista, '
	Case '6.1'	
		ls_os = 'Win 7, '  //or Win 2008
	Case '6.2'	
		ls_os = 'Win 8, '
	Case ''
End Choose

dw_general.SetItem(1,'os_version', ls_os + lnv_systeminfo.of_get_os_version( )  + ' (' + ls_ARCHITECTURE + ')')
dw_general.SetItem(1,'win_user_name',  lnv_systeminfo.of_get_username( ) )
If lnv_systeminfo.of_get_domainname( ) =  lnv_systeminfo.of_get_computername( ) Then
	dw_general.SetItem(1,'domain_name',  'N/A')
Else
	dw_general.SetItem(1,'domain_name', lnv_systeminfo.of_get_domainname( ) )
End If
If lnv_systeminfo.of_isadmin( ) Then
	dw_general.SetItem(1,'is_admin',  'Yes')
Else
	dw_general.SetItem(1,'is_admin',  'No')
End If
If Left(lnv_systeminfo.of_get_os_version( ), 3) <> '6.0' Then 
	dw_general.SetItem(1,'UAC',  'N/A')
Else
	If lnv_systeminfo.of_get_uac( ) = 1 Then
		dw_general.SetItem(1,'UAC',  'On')
	//	dw_general.Modify("UAC.color = '255' ")
	Else
		dw_general.SetItem(1,'UAC',  'Off')
	End If
End If

dw_general.SetItem(1,'run_type',  AppeonGetClientType())

If AppeonGetClientType() = 'WEB' Then
	dw_general.SetItem(1,'web_url', AppeonGetIEURL()  )
Else
	dw_general.SetItem(1,'web_url', 'N/A' )
End If
 
//Added By Ken.Guo 01/15/2013. Check IE Trusted Site.
String ls_url
if AppeonGetClientType() = 'WEB' then
	ls_url = 	appeongetieurl()
	If gf_trusted_sites(ls_url) = False Then
		dw_general.SetItem(1, 'trusted_site', 'No')
	Else
		dw_general.SetItem(1, 'trusted_site', 'Yes')
	End If
Else
	dw_general.SetItem(1, 'trusted_site', 'N/A')
End If



String ls_dbinfo, ls_patch
integer li_version
Select @@version,set_18, set_patch_ver into :ls_dbinfo,:li_version,:ls_patch  from icred_settings;
dw_general.SetItem(1,'database_info',  ls_dbinfo)

If Pos(gs_user_version,'Build') > 1 Then
	dw_general.SetItem(1,'app_version', Mid(gs_user_version, 1,Pos(gs_user_version,'Build') - 1 )) 
Else
	dw_general.SetItem(1,'app_version', gs_user_version) 
End If
If  (gs_current_version + '.' + gs_current_version_patch ) = ( String(li_version) + '.' + ls_patch ) Then
	dw_general.SetItem(1,'db_version',  String(li_version) + '.' + ls_patch )
Else
	dw_general.SetItem(1,'db_version',  String(li_version) + '.' + ls_patch  + '  Not Match')
End If

dw_general.SetItem(1,'license',String(gnv_session.is_license_key,'@@@ @@@@ @@@@@@@ @@@@@@@@'))

UnsignedLong ll_totalmem,ll_resource
inv_platform.of_getfreememory( ll_totalmem ,ll_resource)
If ll_resource <> -1 and ll_resource <> 0 Then
	dw_general.SetItem(1,'ava_memory',   string(ll_resource,"#####.0")+ " MB")
End If

//Check Screen Resolution
Long li_screenheight,li_screenwidth
environment	 lenv_obj
If GetEnvironment (lenv_obj) = 1 Then
	dw_general.SetItem(1,'resolution',  String(lenv_obj.screenwidth) + '*' + String(lenv_obj.screenheight))
//	dw_general.SetItem(1,'language',String(lenv_obj.language ))
End If


//Check Register
String ls_test,ls_test2
ls_test = String(now(),'HHMMSS')
//Modified By Mark Lee 04/18/12
//gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group",'test', regstring!, ls_test) 
//gnv_appeondll.of_registryget( "HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group",'test', ls_test2)
//gnv_appeondll.of_registrydelete( "HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group",'test')
gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName,'test', regstring!, ls_test) 
gnv_appeondll.of_registryget( "HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName,'test', ls_test2)
gnv_appeondll.of_registrydelete( "HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName,'test')
If ls_test = ls_test2 Then
	dw_general.SetItem(1,'register_right',  'Full Control')
Else
	dw_general.SetItem(1,'register_right',  'No Access')	
	dw_general.Modify("register_right.color = '255' ")
End If

//---------Begin Added by (Appeon)Harry 11.04.2015 for Environmental settings AHN--------
String ls_temp_dir
if gs_dir_path = "C:\" then
	ls_temp_dir = gs_temp_path
else
	ls_temp_dir = gs_dir_path
end if
//---------End Added ------------------------------------------------------
//Check CL Temp Dir right
dw_general.SetItem(1,'cl_temp_dir',  ls_temp_dir)	//(Appeon)Harry 11.04.2015 - modify gs_dir_path to ls_temp_dir
//If lnv_right.of_check_tempdir_right( ) > 0 Then
If lnv_right.of_check_dir_right( ls_temp_dir, False, '') > 0 Then //(Appeon)Harry 11.04.2015 - modify gs_dir_path to ls_temp_dir
	dw_general.SetItem(1,'cl_temp_dir_right',  'Full Control')	
Else
	dw_general.SetItem(1,'cl_temp_dir_right',  'No Access')	
	dw_general.Modify("cl_temp_dir_right.color = '255' ")
End If

//Check Web dir
String ls_webdir
If AppeonGetClientType() = 'WEB' Then
	ls_webdir = AppeonGetCacheDir()
	dw_general.SetItem(1,'apb_temp_dir',  ls_webdir)	
	If lnv_right.of_check_dir_right( ls_webdir, False, '') > 0 Then
		dw_general.SetItem(1,'apb_temp_dir_right',  'Full Control')	
	Else
		dw_general.SetItem(1,'apb_temp_dir_right',  'No Access')	
		dw_general.Modify("apb_temp_dir_right.color = '255' ")
	End If
Else
	dw_general.SetItem(1,'apb_temp_dir',  'N/A')	
	dw_general.SetItem(1,'apb_temp_dir_right',  'N/A')	
End If

//Check Word Application
String ls_msword
oleobject lole_word
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word 
	dw_general.SetItem(1,'word_version',  'N/A')	
	dw_general.Modify("word_version.color = '255' ")
Else
	lole_word.Visible = FALSE	
	Choose Case Left(String(lole_word.Application.Version),2)
		Case '11'
			ls_msword = '2003, '
		Case '12'
			ls_msword = '2007, '
		Case '13'
			//ls_msword = 'Word 2008, ' //Maybe 2008?
		Case '14'
			ls_msword = '2010, '
		Case '15'
			ls_msword = '2013, '
	End Choose
	dw_general.SetItem(1,'word_version', ls_msword + String(lole_word.Application.Version))	
	lole_word.quit()//(Appeon)Toney 11.29.2013 - V141 ISG-CLX Fix history BugT101101,append code to quit word process before disconnect 
	lole_word.disconnectobject( )
	Destroy lole_word 
END IF

//Check IE version
String ls_ie1, ls_ie2, ls_ie3, ls_ie4, ls_ie
String ls_var,	ls_ie_path
ulong lul_chars 

//Begin - Added By Mark Lee 04/30/2013 
gnv_appeondll.of_registryget( 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer','svcVersion', ls_ie1)
gnv_appeondll.of_registryget( 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer','version', ls_ie2)
gnv_appeondll.of_registryget( 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer','svcVersion', ls_ie3)
gnv_appeondll.of_registryget( 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer','Version', ls_ie4)
If ls_ie1 <> '' and ls_ie = '' Then ls_ie = ls_ie1
If ls_ie2 <> '' and ls_ie = '' Then ls_ie = ls_ie2
If ls_ie3 <> '' and ls_ie = '' Then ls_ie = ls_ie3
If ls_ie4 <> '' and ls_ie = '' Then ls_ie = ls_ie4
If isnull(ls_ie) or trim(ls_ie ) = '' Then 
	dw_general.SetItem(1,'ie_version',   'Failed to get')		
	dw_general.Modify("ie_version.color = '255' ")
Else
	dw_general.SetItem(1,'ie_version',   ls_ie)		
End If

//---------Begin Added by (Appeon)Harry 12.15.2014 for Preliminary testing on Appeon 2015 - issue1--------
String ls_browser, ls_browsertype
Long ll_pos
if AppeonGetClientType() = 'WEB' then
	ls_browser = appeongetbrowserversion()
	if Pos(Upper(ls_browser), 'IE') > 0 then
	else
		ll_pos = Pos(Lower(ls_browser), '/')
		if ll_pos > 0 then
			ls_browsertype = Mid(Lower(ls_browser), 1, ll_pos - 1)
			ls_ie = Mid(Lower(ls_browser), ll_pos + 1)
			dw_general.Modify("ie_version_t.text = '" + Upper(Mid(ls_browsertype,1,1)) + Mid(ls_browsertype,2) + " Version:'")  
			dw_general.SetItem(1,'ie_version',   ls_ie)		
		end if
	end if
end if
//---------End Added ------------------------------------------------------

//If ls_ARCHITECTURE = '64-bit' Then 
//	gnv_appeondll.of_registryget( 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer','svcVersion', ls_ie)
//////	gnv_debug.of_output( True, ls_ie)
////	If Pos(ls_ie, "%ProgramFiles%") > 0 Then 
////		ls_var = "ProgramFiles"
////		ls_ie_path = Space( 1024 )
////		lul_chars = GetEnvironmentVariableA( ls_var, ls_ie_path, 1024 )
//////		gnv_debug.of_output( True, "ProgramFiles "+ls_ie_path)
////		ls_ie = lnv_string.of_globalreplace( ls_ie,"%ProgramFiles%",ls_ie_path,true)
////	End IF 
//	If isnull(ls_ie) or trim(ls_ie ) = '' Then 
//		gnv_appeondll.of_registryget( 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer','svcVersion', ls_ie)
//		If isnull(ls_ie) or trim(ls_ie ) = '' Then 
//			dw_general.SetItem(1,'ie_version',   'Failed to get')		
//			dw_general.Modify("ie_version.color = '255' ")
//		Else
//			dw_general.SetItem(1,'ie_version',   ls_ie)		
//		End If
//	Else
//		dw_general.SetItem(1,'ie_version',   ls_ie)		
//	End IF 
//Else
//	gnv_appeondll.of_registryget( 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer','version', ls_ie)	
//	If isnull(ls_ie) or trim(ls_ie ) = '' Then 
//		dw_general.SetItem(1,'ie_version',   'Failed to get')		
//		dw_general.Modify("ie_version.color = '255' ")
//	Else
//		dw_general.SetItem(1,'ie_version',   ls_ie)		
//	End If
//End If
//End - Added By Mark Lee 04/30/2013
//gnv_appeondll.of_registryget( 'HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{0002DF01-0000-0000-C000-000000000046}\LocalServer32','', ls_ie)	
//ls_ie = lnv_string.of_globalreplace(ls_ie,'"', '')
//If FileExists(ls_ie) Then
//	dw_general.SetItem(1,'ie_version',   lnv_file.of_getfileversion(ls_ie))		
//Else
//	dw_general.SetItem(1,'ie_version',   'Failed to get')		
//	dw_general.Modify("ie_version.color = '255' ")
//End If

//Check Export Path
Long i
String ls_path
datastore lds_export_list
lds_export_list = Create datastore
lds_export_list.Dataobject = 'd_export_check_path'
lds_export_list.SetTransObject(SQLCA)
lds_export_list.Retrieve()
For i = 1 To lds_export_list.Rowcount()
	dw_export.InsertRow(1)
	dw_export.SetItem(1,'Export_name',lds_export_list.GetItemString(i,'export_name'))
	ls_path = lds_export_list.GetItemString(i,'save_path')
	dw_export.SetItem(1,'Export_dir',ls_path)
	If isnull(ls_path) or ls_path = '' Then Continue
	If lnv_right.of_check_dir_right( ls_path, False, '') > 0 Then
		dw_export.SetItem(1,'dir_permissions','Full Control')
	Else
		dw_export.SetItem(1,'dir_permissions','No Access')		
	End If
Next
dw_export.SetSort('dir_permissions DESC')
dw_export.Sort()


//Check OCX
of_check_ocx()

//Check Email

dw_general.setredraw(True)
dw_export.setredraw(True)
dw_ocx.setredraw(True)

If  isvalid(lnv_systeminfo) Then Destroy lnv_systeminfo
If isvalid(lnv_right) Then Destroy lnv_right
If isvalid(inv_platform) Then Destroy inv_platform
If isvalid(lds_export_list) Then Destroy lds_export_list

SetPointer(Arrow!)

Return 1


end function

public function integer of_check_ocx ();Integer i,li_row
String ls_filepath,ls_error,ls_fileversion
str_ocx  lstr_ocx[]
n_cst_reg_control lnv_reg_control
n_cst_filesrv lnv_filesrv

lnv_filesrv = Create n_cst_filesrv

//Begin - Added By Mark Lee 05/28/12

lstr_ocx[1].ocx_type = 4
lstr_ocx[1].ocx_name = "imageviewer2.ocx"

//lstr_ocx[2].ocx_type = 7
//lstr_ocx[2].ocx_name = "msxml4.dll"
lstr_ocx[2].ocx_type = 8
lstr_ocx[2].ocx_name = "emssl.dll"

lstr_ocx[3].ocx_type = 1
lstr_ocx[3].ocx_name = "officecontrol.ocx"

lstr_ocx[4].ocx_type = 2
lstr_ocx[4].ocx_name = "emsmtp.dll"

lstr_ocx[5].ocx_type = 4
lstr_ocx[5].ocx_name = "imagethumbnailcp.ocx"

lstr_ocx[6].ocx_type = 4
lstr_ocx[6].ocx_name = "scanner.ocx"

lstr_ocx[7].ocx_type = 5
lstr_ocx[7].ocx_name = "empop3.dll"

lstr_ocx[8].ocx_type = 6
lstr_ocx[8].ocx_name = "emmsg.dll "

//lstr_ocx[9].ocx_type = 7
//lstr_ocx[9].ocx_name = "MSSOAP30.dll"
//
//lstr_ocx[10].ocx_type = 7
//lstr_ocx[10].ocx_name = "WHSC30.dll"
//
//lstr_ocx[11].ocx_type = 7
//lstr_ocx[11].ocx_name = "WINHTTP5.dll"
//
//lstr_ocx[12].ocx_type = 7
//lstr_ocx[12].ocx_name = "WISC30.dll"
//
//lstr_ocx[13].ocx_type = 8
//lstr_ocx[13].ocx_name = "emssl.dll"

lstr_ocx[9].ocx_type = 9   //added by gavins 20121128
lstr_ocx[9].ocx_name = "emimap4.dll"

//Added By Mark Lee 07/08/2013
lstr_ocx[10].ocx_type = 10
lstr_ocx[10].ocx_name = "EAGetMailObj.dll "

lstr_ocx[11].ocx_type = 11
lstr_ocx[11].ocx_name = "EASendMailObj.dll "
//End - Added By Mark Lee 05/28/12

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 07.23.2015
//<$>reason:v15.1 CAQH Roster Automation
lstr_ocx[12].ocx_type = 12
lstr_ocx[12].ocx_name = "wodFtpDLX.dll"

lstr_ocx[13].ocx_type = 13
lstr_ocx[13].ocx_name = "wodHttp.ocx"
//------------------- APPEON END -------------------

For i = 1 To UpperBound(lstr_ocx[])
	ls_filepath = ''
	ls_error = lnv_reg_control.of_check_ocx( lstr_ocx[i].ocx_type , lstr_ocx[i].ocx_name, False, ls_filepath)
	li_row = dw_ocx.InsertRow(0)
	dw_ocx.SetItem(li_row, 'ocx_name',lstr_ocx[i].ocx_name )
	dw_ocx.SetItem(li_row, 'ocx_dir',ls_filepath )
	dw_ocx.SetItem(li_row, 'ocx_version_now',ls_filepath )
	If ls_error = '' Then
		dw_ocx.SetItem(li_row, 'ocx_result','Success' )
	Else
		dw_ocx.SetItem(li_row, 'ocx_result','Failure' )	
	End if
	If FileExists(ls_filepath) then
		ls_fileversion = lnv_filesrv.of_getfileversion( ls_filepath)
		dw_ocx.SetItem(li_row, 'ocx_version_now',ls_fileversion )
	Else
		dw_ocx.SetItem(li_row, 'ocx_version_now','File does not exist' )
	End If
Next

dw_ocx.SetSort('ocx_result Asc')
dw_ocx.Sort()

If isvalid(lnv_filesrv) Then Destroy lnv_filesrv


/*
String ls_control[],ls_key[]
ls_control[1] = "officecontrol.ocx"
ls_key[1] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{D267E82F-8649-41ee-9121-050130B1715F}\InprocServer32"
 
ls_control[2] = "emsmtp.dll"
ls_key[2] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\TypeLib\{68AC0D5D-0424-11D5-822F-00C04F6BA8D9}\6.5\0\win32"
  
ls_control[3] = "imageviewer2.ocx"
ls_key[3] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{E589DA78-AD4C-4FC5-B6B9-9E47B110679E}\InprocServer32"
 
ls_control[4] =  "imagethumbnailcp.ocx"
ls_key[4] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{797D023E-E647-45DD-8B81-2F574238FE8F}\InprocServer32"

ls_control[5] = "scanner.ocx"
ls_key[5] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{20666F83-3F1D-4211-9DBF-2FF783A18E18}\InprocServer32"
  
ls_control[6] = "empop3.dll"
ls_key[6] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{10696DE0-CF47-4ad4-B1AE-CC1F4021D65B}\InprocServer32"
  
ls_control[7] = "emmsg.dll"
ls_key[7] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{038DF64C-4207-4a93-B1A6-8967F440E462}\InprocServer32"

ls_control[8] =  "MSSOAP30.dll"
ls_key[8] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{05AE7FB3-C4E9-4F79-A5C3-DAB525E31F2C}\InprocServer32"

ls_control[9] =  "msxml4.dll"
ls_key[9] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{7c6e29bc-8b8b-4c3d-859e-af6cd158be0f}\InProcServer32"

ls_control[10] = "WHSC30.dll"
ls_key[10] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{0AF40C55-9257-11D5-87EA-00B0D0BE6479}\InprocServer32"

ls_control[11] =  "WINHTTP5.dll" 
ls_key[11] =  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{91e2ead3-ab7e-4d5c-88de-f7fa382172bc}\InProcServer32"

ls_control[12] =  "WISC30.dll" 
ls_key[12] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{0AF40C54-9257-11D5-87EA-00B0D0BE6479}\InprocServer32"
	
ls_control[13] = "emssl.dll"
ls_key[13] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{54F83BAD-2B71-4578-80D2-7C40ED3D47FE}\InprocServer32"
*/	
Return 1

end function

public function integer wf_create_cmdfile (string as_text);//====================================================================
// Function: wf_create_file
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_text
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 06/07/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String		ls_file
Integer 	li_FileNum

IF Not isnull(as_text) and Trim(as_text) <> '' Then
	ls_file = gs_dir_path + gs_DefDirName + '\delete_register.bat'
	If FileExists(ls_file) Then
		If Not FileDelete(ls_file) Then
			Messagebox('Delete','Failed to delete the temp file ' + ls_file + ', please log off and then try again.')
			Return 0
		End If
	End If
		li_FileNum = FileOpen(ls_file, LineMode!, Write!, LockWrite!, Replace!)
//		ls_PluginDir = AppeonGetCacheDir() + '\PlugIn\'
	//	For i = 1 To UpperBound(ls_OCXList[])
	//		FileWrite(li_FileNum, 'Regsvr32 "' + ls_PluginDir + ls_OCXList[i] + '"')
	//	Next	
	FileWrite(li_FileNum,as_text)
	FileClose(li_FileNum)
	//Run(ls_file)
	Return 1 
End IF

Return 0
end function

on w_environment_check.create
int iCurrent
call super::create
this.cb_clean_register=create cb_clean_register
this.cb_refresh=create cb_refresh
this.cb_register=create cb_register
this.gb_1=create gb_1
this.shl_sertifi=create shl_sertifi
this.dw_ocx=create dw_ocx
this.cb_close=create cb_close
this.gb_2=create gb_2
this.dw_export=create dw_export
this.gb_3=create gb_3
this.dw_general=create dw_general
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_clean_register
this.Control[iCurrent+2]=this.cb_refresh
this.Control[iCurrent+3]=this.cb_register
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.shl_sertifi
this.Control[iCurrent+6]=this.dw_ocx
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.dw_export
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.dw_general
end on

on w_environment_check.destroy
call super::destroy
destroy(this.cb_clean_register)
destroy(this.cb_refresh)
destroy(this.cb_register)
destroy(this.gb_1)
destroy(this.shl_sertifi)
destroy(this.dw_ocx)
destroy(this.cb_close)
destroy(this.gb_2)
destroy(this.dw_export)
destroy(this.gb_3)
destroy(this.dw_general)
end on

event open;call super::open;This.post of_check()
end event

type cb_clean_register from commandbutton within w_environment_check
integer x = 2085
integer y = 2280
integer width = 489
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clean Register"
end type

event clicked;
long				ll_Rtn, ll_rowcount, ll_row 
String				ls_TempDir,ls_LastClrDate, ls_ocx_name	,	 ls_path
//n_cst_filesrv 	inv_filesrv
Boolean			lbn_rtn = True , lb_exist, lbn_delete = True
String 			ls_DllName[], ls_tmp[]
Long 				ll_UpperBound,	k
String				ls_register, ls_err, ls_register_bat = '@echo off~r~n'
ll_rowcount = dw_ocx.rowcount( ) 
IF ll_rowcount <= 0 Then
	Return
End IF

ll_Rtn = MessageBox('Confirm Files Clean Register','Are you sure you want to clean the Register files?',Question!,YesNo!)
if ll_Rtn <> 1 then return

//Delete Files and Dir
//f_SetFileSrv(inv_filesrv,TRUE)
ls_err = ''
For ll_row  = 1 to ll_rowcount
	ls_TempDir = dw_ocx.GetItemString(ll_row,'ocx_dir')
	IF isnull(ls_TempDir) or trim(ls_TempDir) = '' Then 
		continue
	End IF 
	ls_DllName	=	ls_tmp 
	lb_exist = FileExists(ls_TempDir)
	If lb_exist = true Then
		ls_path = left(ls_TempDir,LastPos(ls_TempDir,'\'))
		lbn_rtn	=	FileDelete(ls_TempDir)
		IF  lbn_rtn = False or isnull(lbn_rtn) Then
			lbn_delete = False
			ls_err	+=	" Failed to delete file: " +ls_TempDir + "~r~n"
			ls_register_bat +='if exist "'+ls_TempDir+'" (~r~n del "'+ ls_TempDir + '"~r~n) else (~r~n echo "Does not exist file: '+ ls_TempDir + '"~r~n)~r~n'
//			messagebox('delete faile ',ls_TempDir)
		End IF
		ls_ocx_name 	 = lower(dw_ocx.GetItemString(ll_row,'ocx_name'))

			CHOOSE CASE ls_ocx_name
				CASE 'imageviewer2.ocx'
					ls_DllName[1] = 'viscomocr.dll'
					ls_DllName[2] = 'viscompsd.dll'					
					ls_DllName[3] = 'TIFF2PDF.dll'
					ls_DllName[4] = 'viscomdocx.dll'
					ls_DllName[5] = 'msvcrt.dll'					
					ls_DllName[6] = 'mfc42.dll'										
					ls_DllName[7] = 'viscompdf.dll'							
				CASE 'scanner.ocx'
					ls_DllName[1] = 'viscompdf.dll'		
//Commented By Ken.Guo 08/13/2012. User should install SAOPSDK.exe
//				CASE 'msxml4.dll'	
//					ls_DllName[1] = 'msxml4r.dll'		
//				CASE 'mssoap30.dll'	
//					ls_DllName[1] = 'MSSOAPR3.dll'	
//				CASE 'wisc30.dll'
//					ls_DllName[1] = 'MSSOAPR3.dll'	
//				CASE 'whsc30.dll'
//					ls_DllName[1] = 'MSSOAPR3.dll'	
				CASE 'officecontrol.ocx'		
					//Added By Mark Lee 12/23/2013
					ls_DllName[1] = 'ntkocmnres.dll'		
					ls_DllName[2] = 'ntkoHtPkcs11.dll'		
				CASE 'emsmtp.dll'						
					ls_DllName[1] = 'emsmtp.dll'		
				CASE 'emmsg.dll'											
					ls_DllName[1] = 'emmsg.dll'	
				CASE 'emimap4.dll'	//added by gavins 20121128										
					ls_DllName[1] = 'emimap4.dll'		
				CASE 'EAGetMailObj.dll'						
					ls_DllName[1] = 'EAGetMailObj.dll'			//Added By Mark Lee 07/08/2013
				CASE 'EASendMailObj.dll'						
					ls_DllName[1] = 'EASendMailObj.dll'		//Added By Mark Lee 07/08/2013
				CASE 'wodFtpDLX.dll'											
					ls_DllName[1] = 'wodFtpDLX.dll'	//Added by Appeon long.zhang 07.23.2015 (v15.1 CAQH Roster Automation)
				CASE 'wodHttp.ocx'											
					ls_DllName[1] = 'wodHttp.ocx'	//Added by Appeon long.zhang 07.23.2015 (v15.1 CAQH Roster Automation)
				CASE ELSE

			END CHOOSE 
			ll_UpperBound = UpperBound(ls_DllName)
			If ll_UpperBound > 0 Then
				For k = 1 to ll_UpperBound
					lb_exist = FileExists(ls_path+ls_DllName[k])
					If lb_exist = true Then
						If FileDelete(ls_path+ls_DllName[k]) = False THen
							If Pos(ls_err,ls_DllName[k]) = 0  then
		//						messagebox('delete faile 2  ',ls_DllName[k])
								ls_err	+=	" Failed to delete file: " +ls_path+ls_DllName[k] + "~r~n"
								ls_register_bat +='if exist "'+ls_path+ls_DllName[k]+'" (~r~n del "'+ ls_path+ls_DllName[k] + '"~r~n ) else (~r~n echo "Does not exist file: '+ ls_path+ls_DllName[k] + '"~r~n)~r~n'
		//						ls_register_bat +='if exist "'+ls_path+ls_DllName[k] +'" del "'+ ls_path+ls_DllName[k]  + '"~r~n '
							End If
						End If
					End If
				Next
			End If
	End If
//	ll_Rtn = inv_filesrv.of_deltree(ls_TempDir, False)
//	If ll_Rtn < 0 Then
//		lbn_rtn = False
//	End If
		ls_register =	"Regsvr32 /s /U "+"~'"+ls_TempDir+"~'"
		ll_Rtn	=	Run(ls_register)
//		messagebox('run = '+string(ll_Rtn),'@@ '+ls_TempDir)
Next 
//Destroy inv_filesrv
//Check the result.
If  lbn_delete = False or isnull(lbn_delete) Then
	ls_register_bat += 'pause'
	wf_create_cmdfile(ls_register_bat)
	OpenWithParm(w_environment_check_msg ,ls_err)
//	MessageBox(gnv_app.iapp_object.DisplayName,"Failed to delete some files because they are being used right now. ~r~n~r~nWe suggest that you close this IE and then remove the  Register files manually.",Exclamation!)
else
	MessageBox(gnv_app.iapp_object.DisplayName,"The Register files were cleaned successfully! ~r~nWe suggest that you exit IntelliSoft and then run again.")
end if
end event

type cb_refresh from commandbutton within w_environment_check
integer x = 3090
integer y = 2280
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
boolean default = true
end type

event clicked;dw_general.reset( )
dw_export.reset( )
dw_ocx.reset()

Parent.of_check()
end event

type cb_register from commandbutton within w_environment_check
integer x = 2587
integer y = 2280
integer width = 489
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Register OCX (CMD)"
end type

event clicked;of_reg_dllocx_cmd()
end event

type gb_1 from groupbox within w_environment_check
integer x = 37
integer y = 8
integer width = 3744
integer height = 912
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "General Check"
end type

type shl_sertifi from statichyperlink within w_environment_check
integer x = 32
integer y = 2280
integer width = 919
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 33551856
string text = "Download SoapToolkit for Sertifi Function"
boolean focusrectangle = false
string url = "http://web.intellisoftgroup.com/templates/soapsdk.exe"
end type

event clicked;//String ls_url,ls_null
//ls_url = 'http://download.microsoft.com/download/2/e/0/2e068a11-9ef7-45f5-820f-89573d7c4939/soapsdk.exe'
//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url, ls_Null, 4)
end event

event constructor;//alfee 11.08.2016

String ls_url

ls_url = Trim(gnv_data.of_getitem( "icred_settings", "downloadurl", false)) 
If Len(ls_url) > 0 Then 
	If Right(ls_url, 1) <> "/" And Right(ls_url, 1) <> "\" Then ls_url = ls_url + "/"
	ls_url  = ls_url + "soapsdk.exe"
	This.URL = ls_url	
End If

end event

type dw_ocx from u_dw within w_environment_check
integer x = 78
integer y = 1440
integer width = 3685
integer height = 800
integer taborder = 20
string dataobject = "d_env_check_ocx"
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(False)
end event

type cb_close from commandbutton within w_environment_check
integer x = 3447
integer y = 2280
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type gb_2 from groupbox within w_environment_check
integer x = 37
integer y = 1372
integer width = 3744
integer height = 884
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "DLL && OCX Check"
end type

type dw_export from u_dw within w_environment_check
integer x = 82
integer y = 996
integer width = 3685
integer height = 340
integer taborder = 20
string dataobject = "d_env_check_export"
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(False)
end event

type gb_3 from groupbox within w_environment_check
integer x = 37
integer y = 932
integer width = 3744
integer height = 432
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Export Function Check"
end type

type dw_general from u_dw within w_environment_check
integer x = 59
integer y = 76
integer width = 3685
integer height = 820
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_env_check_generate"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(False)
end event

