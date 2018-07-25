$PBExportHeader$n_cst_imaging.sru
forward
global type n_cst_imaging from nonvisualobject
end type
end forward

global type n_cst_imaging from nonvisualobject autoinstantiate
end type

type prototypes
function long GetDllDirectory(ref string as_Path) library "appeondll.dll" alias for "GetDllDirectory;Ansi"
end prototypes

type variables
String LOCAL_PATH
String Is_ImagingFile = "ImagingInstall.exe" //(V12.3 Cab) alfee 02.08.2013

end variables

forward prototypes
public function boolean of_registry_imaging ()
public function boolean of_registry_ocx ()
public function boolean of_download_ocx ()
public function boolean of_isregistry_imaging ()
public function boolean of_isdownload_ocx ()
public function boolean of_get_flag ()
public function boolean of_unregistry_imaging ()
public function boolean of_check_windows_imaging ()
public subroutine of_get_imageocx ()
public function integer of_prompt_license ()
public function boolean of_isdownload_imaging ()
public function boolean of_download_imaging ()
public function integer of_install_imaging ()
public function boolean of_registry_ocx_plugin ()
end prototypes

public function boolean of_registry_imaging ();n_cst_appeondll lnv_appeondll
long ll_ret 

//jadge to registry
if of_isRegistry_imaging() then return true

//Download again, prevent someone modify this file in local.  Ken.Guo 2008-01-29
n_appeon_download lnv_download
lnv_download.of_downloadfile( "", LOCAL_PATH + "imaging.reg")	
	
//registry imaging infomation
//ll_ret = run("regedit -s " + LOCAL_PATH + "Imaging.reg")
ll_ret = run('regedit -s "' + LOCAL_PATH + 'Imaging.reg"') //Alfee 06.26.2008
Sleep(1) //Added By Ken.Guo 2008-01-26

//Flow.exe
lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\imaging.exe","Path",RegString!,LOCAL_PATH)


//if FileExists(LOCAL_PATH + "Imaging.reg") then post FileDelete(LOCAL_PATH + "Imaging.reg") //Commented for 'of_isdownload_ocx' by Ken.Guo 2008-01-26 

if ll_ret > 0 then
	return true
else
	return false
end if


/*
string ls_value

//registryGet("HKEY_LOCAL_MACHINE\SOFTWARE\eiStream\Imaging for Windows\OCR","Engines",RegMultiString!,ls_value)
//clipboard(ls_value)
ls_value = "ÿÿ"
//HKEY_LOCAL_MACHINE\SOFTWARE
lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\eiStream\Imaging for Windows","Version",RegString!,"2.80.0.5510w")
lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\eiStream\Imaging for Windows\OCR","Engines",RegMultiString!,ls_value)
lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\eiStream\Imaging for Windows\OCR","Engine - XIS",RegString!,"COI_ICR_XIS,Xerox TextBridge?")



//HKEY_CLASSES_ROOT
//lnv_appeondll.of_registrySet("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Options","a",ReguLong!,11142717742)
lnv_appeondll.of_registrySet("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","a",ReguLong!,1233887202)
lnv_appeondll.of_registrySet("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","b",ReguLong!,1183263569)
lnv_appeondll.of_registrySet("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","c",ReguLong!,3061080093)
lnv_appeondll.of_registrySet("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","d",ReguLong!,4143067311)
lnv_appeondll.of_registrySet("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Type","a",ReguLong!,54256582)

//HKEY_LOCAL_MACHINE\SOFTWARE\Classes
//lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Options","a",ReguLong!,204879616)
lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","a",ReguLong!,1233887202)
lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","b",ReguLong!,1183263569)
lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","c",ReguLong!,3061080093)
lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","d",ReguLong!,4143067311)
lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Type","a",ReguLong!,54256582)

*/




end function

public function boolean of_registry_ocx ();boolean lb_ret = true

if appeonGetClientType() = "PB" then return true

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02/04/2008 By: Ken.Guo
//$<reason> If Installed windows version imaging programe, then do nothing.
If of_check_windows_imaging() Then Return true
//---------------------------- APPEON END ----------------------------

//Window2000 is not register
if PosA(appeonGetOSType(),"5.0") > 0 then return true

//Skip downloading & registering (V12.1 Web Component) - Alfee 04.21.2012
If Not gb_AutoDwnReg Then
	gnv_reg_ocx.of_set_imaging_instance (False) //alfee 04.14.2013
	If gnv_reg_ocx.of_check_ocx( 3, '',False) <> '' Then 
		//Halt Close
		of_install_imaging () //(V12.3 Cab) Alfee 02.28.2013
	End If
	gnv_reg_ocx.of_set_imaging_instance (True) //alfee 04.14.2013
	Return True 
End If	

//Allow Register imaging ocx
if of_get_flag() then 
	
	if not of_isDownload_ocx() then
		lb_ret = of_download_ocx()
	end if
	
	if lb_ret then
		//lb_ret = of_registry_imaging() //Commented By Ken.Guo 2008-12-01
		of_registry_imaging() //Added By Ken.Guo 2008-12-01
	end if
	
	if lb_ret then
		
		//Check whether installed // Added By Ken.Guo 2008-12-01
		If gnv_reg_ocx.of_check_ocx( 3, '',False) = '' Then Return True
				
		//---------Begin Modified by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
		  /*
		/*
		run('regsvr32 -s "' + LOCAL_PATH + 'imgedit.ocx"')
		run('regsvr32 -s "' + LOCAL_PATH + 'imgscan.ocx"')
		run('regsvr32 -s "' + LOCAL_PATH + 'Imgadmin.ocx"')
		run('regsvr32 -s "' + LOCAL_PATH + 'Imgocr.ocx"')
		run('regsvr32 -s "' + LOCAL_PATH + 'Imgthumb.ocx"')		
		*/
		//BEGIN---Add by Evan 08/12/2008
		
		string ll_CurrDir
		//n_cst_reg_control lnv_reg
		/*
		//ll_CurrDir = GetCurrentDirectory()
		//ChangeDirectory(LOCAL_PATH)
		gnv_reg_ocx.of_Register("imgedit.ocx", true)
		gnv_reg_ocx.of_Register("imgscan.ocx", true)
		gnv_reg_ocx.of_Register("Imgadmin.ocx", true)
		gnv_reg_ocx.of_Register("Imgocr.ocx", true)
		gnv_reg_ocx.of_Register("Imgthumb.ocx", true)
		//ChangeDirectory(ll_CurrDir)
		*/
		//Begin -- Modified by Ken.Guo 2008-11-06
		String ls_Controls[],ls_KeyImg[],ls_valueImg[]
		String ls_value,ls_module_name,ls_error,ls_error_all
		Integer i
		
		ls_Controls[1] = "imgedit.ocx"
		ls_Controls[2] = "imgscan.ocx"
		ls_Controls[3] = "imgadmin.ocx"
		ls_Controls[4] = "imgocr.ocx"
		ls_Controls[5] = "imgthumb.ocx"
		ls_KeyImg[1]	= "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{6D940280-9F11-11CE-83FD-02608C3EC08A}\InprocServer32"
		ls_KeyImg[2] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{84926CA0-2941-101C-816F-0E6013114B7F}\InprocServer32"
		ls_KeyImg[3] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{009541A0-3B81-101C-92F3-040224009C02}\InprocServer32"
		ls_KeyImg[4] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{8FC248E3-D4D9-11CF-8727-0020AFA5DCA7}\InprocServer32"
		ls_KeyImg[5] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{E1A6B8A0-3603-101C-AC6E-040224009C02}\InprocServer32"		
				
		FOR i = 1 to UpperBound(ls_Controls)
			//lnv_Appeon.of_registryget(ls_KeyImg[i],"", RegString!, ls_Value)
			ls_error = gnv_reg_ocx.of_Register(ls_Controls[i], false)
			If ls_error <> '' Then
				If PosA(ls_module_name,gnv_reg_ocx.is_module_name[4],1) = 0 Then 
					ls_module_name += gnv_reg_ocx.is_module_name[4] + ' & '  //4: New Imaging module
				End If
				ls_error_all += ls_error + ', '
			End If		
		NEXT
		
		If ls_error_all <> '' Then
			ls_module_name = MidA(ls_module_name,1,LenA(ls_module_name) - 3)
			ls_error_all = MidA(ls_error_all,1,LenA(ls_error_all) - 2)
			gnv_reg_ocx.of_show_message( ls_module_name,ls_error_all)
		End If		
		//End-- modified by Ken.Guo	
		 */
		 //Regist OCX
		If Not of_registry_ocx_plugin() Then Return False
		//---------End Modfiied ------------------------------------------------------------------
	else
		return false
	end if
	return true
else
	return of_unregistry_imaging()
end if


end function

public function boolean of_download_ocx ();string ls_file_list[]
long ll_count,ll_i,ll_ret
n_appeon_download lnv_download

//openwithparm(w_download_popup,"Downloading the imaging file from Server, Please stand by...")
openwithparm( w_appeon_gifofwait, "Downloading the imaging file from Server, Please stand by...")

//01.31.2007 By Jervis
ll_ret = lnv_download.of_downloadfile( "", LOCAL_PATH + "imaging.reg")
if ll_ret <> 0 then
	MessageBox("Download infomation","Failed to download Imaging OCX file, Call support.")
	if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	return false
end if

ls_file_list = {"Imgedit.ocx","Imgscan.ocx","ChkExDt.dll","ekexpr.dll","imgcmn.dll","imgshl.dll","Icr32.dll","Xconv32.dll", &
					 "Jpeg1x32.dll","Jpeg2x32.dll","Oieng400.dll","Oiprt400.dll","Oislb400.dll","Oissq400.dll", &
					 "Oitwa400.dll","Oiui400.dll","MFC42.DLL","MSVCIRT.DLL","Msvcrt.dll","Coi_icr.dll","COI_ICR_XIS.DLL","Imgadmin.ocx","Imgocr.ocx","Imgthumb.ocx", &
					 "Icrsrv32.exe","English.lc","French.lc","German.lc","G610T32W.dll","G615T32W.dll","G502F32W.dll","G521F32W.dll","G521T32W.dll","G606T32W.dll","W001T32W.dll","W019T32W.dll","W048T32W.dll","W108T32W.dll"} // Modify by Evan on 09/28/2008
					 
ll_count = UpperBound(ls_file_list)

for ll_i = 1 to ll_count
	ll_ret = lnv_download.of_downloadfile("",LOCAL_PATH + ls_file_list[ll_i])
	if ll_ret <> 0 then exit
next

if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

if ll_i <= ll_count then
	MessageBox("Download infomation","Failed to download Imaging OCX file, Call support.")
	return false
end if

return true
end function

public function boolean of_isregistry_imaging ();n_cst_appeondll lnv_appeon
string ls_version,ls_path

//jadge imaging is registered
if lnv_appeon.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\eiStream\Imaging for Windows", "Version", RegString!, ls_version) = 1  and lnv_appeon.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\imaging.exe","Path",RegString!,ls_path)  = 1 then
	if ls_version = "2.80.0.5510w" and appeongetclienttype() = 'WEB'  and Not gb_AutoDwnReg then return true //(v12.1 web component) Alfee 10.08.2012 - Bug 3277 		
	if ls_version = "2.80.0.5510w" and lower(ls_path) = lower(LOCAL_PATH) then	
		return true
	else
		return false
	end if
else
	return false
end if

end function

public function boolean of_isdownload_ocx ();//Add 1 reg file and 18 dll files for checking. Ken.Guo 2008-01-26

if appeongetclienttype() = 'WEB'  and Not gb_AutoDwnReg then return true //(v12.1 web component) Alfee 10.08.2012 - Bug 3277 

if FileExists(LOCAL_PATH + "Imaging.reg")  and &   
	FileExists(LOCAL_PATH + "imgedit.ocx")  and &
	FileExists(LOCAL_PATH + "imgscan.ocx")  and &
	FileExists(LOCAL_PATH + "Imgthumb.ocx") and &
	FileExists(LOCAL_PATH + "Imgocr.ocx")   and &
	FileExists(LOCAL_PATH + "Imgadmin.ocx") and &
	FileExists(LOCAL_PATH + "ChkExDt.dll")  and &
	FileExists(LOCAL_PATH + "Coi_icr.dll")  and &
	FileExists(LOCAL_PATH + "COI_ICR_XIS.DLL") and &
	FileExists(LOCAL_PATH + "ekexpr.dll")   and &
	FileExists(LOCAL_PATH + "Icr32.dll")    and &
	FileExists(LOCAL_PATH + "imgcmn.dll")   and &
	FileExists(LOCAL_PATH + "imgshl.dll")   and &
	FileExists(LOCAL_PATH + "Jpeg1x32.dll") and &
	FileExists(LOCAL_PATH + "Jpeg2x32.dll") and &
	FileExists(LOCAL_PATH + "MFC42.DLL")    and &
	FileExists(LOCAL_PATH + "MSVCIRT.DLL")  and &
	FileExists(LOCAL_PATH + "Msvcrt.dll")   and &
	FileExists(LOCAL_PATH + "Oieng400.dll") and &
	FileExists(LOCAL_PATH + "Oiprt400.dll") and &
	FileExists(LOCAL_PATH + "Oislb400.dll") and &
	FileExists(LOCAL_PATH + "Oissq400.dll") and &
	FileExists(LOCAL_PATH + "Oitwa400.dll") and &
	FileExists(LOCAL_PATH + "Oiui400.dll")  and &
	FileExists(LOCAL_PATH + "Xconv32.dll")  and &
	FileExists(LOCAL_PATH + "Icrsrv32.exe") and &
	FileExists(LOCAL_PATH + "English.lc")   and &
	FileExists(LOCAL_PATH + "G610T32W.dll") then // Modify by Evan on 09/28/2008
	return true 
else
	return false
end if
end function

public function boolean of_get_flag ();return true //always allow to register imaging ocxs - alfee 01.20.2017

if appeongetclienttype() = 'WEB'  and Not gb_AutoDwnReg then return true //(v12.1 web component) Alfee 05.02.2012 
	
if gs_image_flag = '1' then return true
return false



end function

public function boolean of_unregistry_imaging ();n_cst_appeondll lnv_appeondll

//--------Begin Commented by Alfee 06.26.2008-------
//<$Reason>An incomplete register may cause the system crashed  
//<$Reason>if a window includes the OCXs(even not called). So 
//<$Reason>please unregister them anyway.
//if not of_isRegistry_imaging() then return true
//--------End Commented ----------------------------

//unregister imaging ocx
//----------Begin Modified by Alfee on 06.26.2008
/* run("regsvr32 -s -u " + LOCAL_PATH + "imgedit.ocx")
run("regsvr32 -s -u " + LOCAL_PATH + "imgscan.ocx")
run("regsvr32 -s -u" + LOCAL_PATH + "Imgadmin.ocx")
run("regsvr32 -s -u" + LOCAL_PATH + "Imgocr.ocx")
run("regsvr32 -s -u" + LOCAL_PATH + "Imgthumb.ocx")*/
run('regsvr32 -s -u "' + LOCAL_PATH + 'imgedit.ocx"')
run('regsvr32 -s -u "' + LOCAL_PATH + 'imgscan.ocx"')
run('regsvr32 -s -u "' + LOCAL_PATH + 'Imgadmin.ocx"')
run('regsvr32 -s -u "' + LOCAL_PATH + 'Imgocr.ocx"')
run('regsvr32 -s -u "' + LOCAL_PATH + 'Imgthumb.ocx"')
//----------End Modified ---------------------------------

//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 2009-08-03.
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\eiStream\Imaging for Windows","")
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\eiStream","")
//---------End Added ------------------------------------------------------------------


//delete register infomation
/*
//HKEY_LOCAL_MACHINE\SOFTWARE
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\eiStream\Imaging for Windows","")
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\eiStream","")

//HKEY_CLASSES_ROOT
lnv_appeondll.of_registryDelete("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Options","")
lnv_appeondll.of_registryDelete("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","")
lnv_appeondll.of_registryDelete("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Type","")
lnv_appeondll.of_registryDelete("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702","")
lnv_appeondll.of_registryDelete("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061","")
lnv_appeondll.of_registryDelete("HKEY_CLASSES_ROOT\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}","")

//HKEY_LOCAL_MACHINE\SOFTWARE\Classes
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Options","")
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Sequence","")
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702\Type","")
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061\17a702","")
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}\1226061","")
lnv_appeondll.of_registryDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{922764C0-D398-11d1-A2A1-0000C0B782CF}","")
*/
return true
end function

public function boolean of_check_windows_imaging ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_imaging.of_check_windows_imaging()
// $<arguments>(None)
// $<returns> boolean
// $<description> Checked whether Installed windows imaging programe
//////////////////////////////////////////////////////////////////////
// $<add> 02/04/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////
n_cst_appeondll lnv_appeondll
String ls_version
if lnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\KodakImgV1", "DisplayName", RegString!, ls_version) = 1 Then
	//If	Upper(ls_version) = Upper('Imaging for Windows OCXs') Then 
	If	PosA(Upper(ls_version),Upper('Imaging for Windows')) > 0 Then 
		//Installed windows imaging programe
		Return True
	End If
End If
Return False
end function

public subroutine of_get_imageocx ();//---------Begin Modified by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
  /*

//Select an Image OCX - Added by Alfee on 05.19.2008 
IF appeongetclienttype() = 'PB' THEN //For Window version
	IF of_check_windows_imaging() OR PosA(appeonGetOSType(),"5.0") > 0 THEN //06.10.2008	
   	gi_imageocx = 1 //Imaging 360
	ELSE   
		gi_imageocx = 2 //New image control
	END IF
ELSE 	//For Web version
	IF of_check_windows_imaging() OR PosA(appeonGetOSType(),"5.0") > 0 OR & 
		( of_get_flag() AND of_isdownload_ocx() AND of_isregistry_imaging() ) THEN //06.10.2008	
   	gi_imageocx = 1 //Imaging 360
	ELSE
   	gi_imageocx = 2 //New image control
	END If	
END IF	

      
//gi_imageocx = 2 //for test only
  */
 gi_imageocx = 2 
//---------End Modfiied ------------------------------------------------------------------

end subroutine

public function integer of_prompt_license ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_imaging.of_prompt_license()
// $<arguments>(None)
// $<returns> Integer 1 - Continue; -1 - Cancel;
// $<description> Prompt Global Imaging 360 License if needed
//////////////////////////////////////////////////////////////////////
// $<add> 07.14.2008 Alfee
//////////////////////////////////////////////////////////////////////

String ls_lic_img, ls_rtn 
Boolean lb_prompt = FALSE

//Get and return if the license agreement had been prompted to the user before
ls_lic_img = gnv_data.of_getItem("security_users", "lic_agr_img","Lower(user_id) = '" + Lower(gs_user_id) + "'")
IF ls_lic_img = '1' THEN RETURN 1

//Checking if it's needed to display license agreement
IF appeonGetClientType() = "PB" THEN 
//Window verison	
	IF of_check_windows_imaging() THEN 	
	//The Global 360 installed manually		
	
		IF gb_contract_module THEN 
		//Contract Module Enabled(InteliContract or IntelliCred/App System )
			IF gnv_data.of_getitem('icred_settings' ,'set_51' , False ) <> '0' THEN
			//Document Agreement Manager option enabled
				lb_prompt = TRUE
			END IF	
		END IF
		
		IF (Not lb_prompt) AND (NOT gb_contract_version) THEN
		//IntelliCred/App System 			
			IF gi_prod_setting = 1 OR gi_iapp_on = 1 OR gi_imaging = 1 THEN
			//IntelliApp or related modules enabled
				lb_prompt = TRUE
			END IF						
		END IF
	END IF
ELSE
//Web version	
	IF of_check_windows_imaging() OR of_get_flag() THEN 	
	//The Global 360 installed manually	or Install Imaging Program option enabled in user painter
		lb_prompt = TRUE	
	END IF	
END IF

//Prompt License Agreement
IF lb_prompt THEN 
	//Open the License Agreement window
	OpenwithParm(w_license_agreement, 'Global 360')
	ls_rtn = Message.StringParm
	IF ls_rtn = '-1' THEN 
		//Return -1 if user reject the license agreement
		RETURN -1	
	ELSE
		//Update the flag for the user
		Update security_users Set lic_agr_img = 1 Where user_id = :gs_user_id ;
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("IntelliSoftGroup","Update license flag of Image for Windows Failed!")
			RETURN 0
		END IF
	END IF
END IF

RETURN 1
end function

public function boolean of_isdownload_imaging ();//Check if the imaginginstall.exe is downloaded - alfee 02.28.2013 (V12.3 Cab)

if FileExists(LOCAL_PATH + Is_ImagingFile)  then
	return true 
else
	return false
end if
end function

public function boolean of_download_imaging ();// Download the imaginginstall.exe from the Templates folder in case the automatic download was failed somehow
//(V12.3 Cab) alfee 02.28.2013

long ll_ret
n_appeon_download lnv_download

openwithparm( w_appeon_gifofwait, "Downloading the Imaging file from Server, Please stand by...")

ll_ret = lnv_download.of_downloadfile("", LOCAL_PATH + Is_ImagingFile)
if ll_ret <> 0 then
	MessageBox("Download infomation","Failed to download the " + Is_ImagingFile + " file, Call support.")
	if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	return false
end if

if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

return true
end function

public function integer of_install_imaging ();//Install the Imaging files (V12.3 Cab) - alfee 02.28.2013

Integer li_rtn
Long ll_null
String ls_null

setnull(ls_null)
setnull(ll_null)

IF NOT of_isdownload_imaging () THEN	
	IF NOT of_download_imaging () THEN
		RETURN -1
	END IF	
END IF

IF NOT FileExists(LOCAL_PATH + Is_ImagingFile) THEN 
	RETURN -1
END IF

li_rtn = MessageBox("IntelliSoft Web Components", "The system will install the files of Imaging for Windows on your machine. Click OK to continue?", Question!, OKCancel!)
IF li_rtn = 1 THEN
	//Use the ShellExecuteA () to avoid the UAC limit
	ShellExecuteA (ll_null, "open", LOCAL_PATH + Is_ImagingFile, ls_Null, ls_Null, 4)	
	//Reset the check flag
	gnv_reg_ocx.of_reset_check_flag(3) //Alfee 03.20.2013
END IF

RETURN 1

end function

public function boolean of_registry_ocx_plugin ();//====================================================================
//$<Function>: of_registry_ocx_plugin
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: 
//$<Author>: (Appeon) Toney 06.06.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
String ls_Controls[],ls_KeyImg[],ls_valueImg[]
String ls_value,ls_module_name,ls_error,ls_error_all
//n_cst_appeondll lnv_appeondll//Commented by (Appeon)Toney 06.06.2013 - V141 ISG-CLX exclude this object

ls_Controls[1] = "imgedit.ocx"
ls_Controls[2] = "imgscan.ocx"
ls_Controls[3] = "imgadmin.ocx"
ls_Controls[4] = "imgocr.ocx"
ls_Controls[5] = "imgthumb.ocx"
ls_KeyImg[1]	= "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{6D940280-9F11-11CE-83FD-02608C3EC08A}\InprocServer32"
ls_KeyImg[2] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{84926CA0-2941-101C-816F-0E6013114B7F}\InprocServer32"
ls_KeyImg[3] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{009541A0-3B81-101C-92F3-040224009C02}\InprocServer32"
ls_KeyImg[4] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{8FC248E3-D4D9-11CF-8727-0020AFA5DCA7}\InprocServer32"
ls_KeyImg[5] = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{E1A6B8A0-3603-101C-AC6E-040224009C02}\InprocServer32"		

//Must set to the current path.//Added By Ken.Guo 2009-08-06.
//lnv_appeondll.of_registrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\imaging.exe","Path",RegString!,LOCAL_PATH)//Commented by (Appeon)Toney 06.06.2013 - V141 ISG-CLX exclude this object
FOR i = 1 to UpperBound(ls_Controls)
	//lnv_Appeon.of_registryget(ls_KeyImg[i],"", RegString!, ls_Value)
	ls_error = gnv_reg_ocx.of_Register(ls_Controls[i], false)
	If ls_error <> '' Then
		If Pos(ls_module_name,gnv_reg_ocx.is_module_name[4],1) = 0 Then 
			ls_module_name += gnv_reg_ocx.is_module_name[4] + ' & '  //4: New Imaging module
		End If
		ls_error_all += ls_error + ', '
	End If		
NEXT

If ls_error_all <> '' Then
	ls_module_name = Mid(ls_module_name,1,len(ls_module_name) - 3)
	ls_error_all = Mid(ls_error_all,1,len(ls_error_all) - 2)
	gnv_reg_ocx.of_show_message( ls_module_name,ls_error_all)
	Return False
End If		

//of_refresh_path_regedit()//Commented by (Appeon)Toney 06.06.2013 - V141 ISG-CLX exclude this object
Return True

end function

on n_cst_imaging.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_imaging.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11.03.2008 By: Ken.Guo
//$<reason> Use Appeon temp file directory. e.g. :
//$'C:\Documents and Settings\Administrator\Application Data\appeon\192.0.3.37_Dotnet_intellicontract8\plugin'

//LOCAL_PATH = gs_dir_path + "IntelliCred\Imaging\" 
string ls_Path
ls_Path = Space(255)
GetDllDirectory(ls_Path)
ls_Path = Trim(ls_Path)
LOCAL_PATH = ls_Path + '\'
//---------------------------- APPEON END ----------------------------

end event

