$PBExportHeader$n_cst_pdf.sru
forward
global type n_cst_pdf from nonvisualobject
end type
end forward

global type n_cst_pdf from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION ulong GetCurrentDirectoryA(ulong BufferLen, ref string currentdir) LIBRARY "Kernel32.dll" alias for "GetCurrentDirectoryA;Ansi"
FUNCTION ulong GetEnvironmentVariableA( string szVarName,REF string lpValue, ulong dwSize ) LIBRARY "kernel32.dll" alias for "GetEnvironmentVariableA;Ansi" 
//Then, use SetEnvironmentVariable to change it: 
FUNCTION boolean SetEnvironmentVariableA( string szVarName, string szValue ) LIBRARY "kernel32.dll" alias for "SetEnvironmentVariableA;Ansi"
FUNCTION long ShellExecuteA (long hwnd, string lpOperation, string lpFile, string lpParameters,  string lpDirectory, integer nShowCmd ) LIBRARY "SHELL32" alias for "ShellExecuteA;Ansi"


function ulong RegOpenKeyEx( ulong hkey, string subkey, ulong uloptions, long samdesired, ref long result ) library "Advapi32.dll"  alias for "RegOpenKeyExW"
function long RegQueryValueEx( long hkey, string lpvaluename, long lpReserved, ref long lptype, ref string lpdata, ref long lpcbdata ) library "Advapi32.dll" alias for "RegQueryValueExW"
Function Long  RegCloseKey ( Long hkey )    Library "advapi32.dll" Alias for "RegCloseKey" 

end prototypes

type variables
CONSTANT STRING IS_PDF_PRINTER = 'Sybase DataWindow PS'  //'Intellisoft PDF Printer' - Changed by alfee 02.19.2014

String IS_ARCHITECTURE = '32-bit'  //alfee 02.19.2014
end variables

forward prototypes
public function integer of_add_pdf_printer ()
public function integer of_set_path ()
public function integer of_registryget (string as_subkey, string as_keyname, ref string as_value)
end prototypes

public function integer of_add_pdf_printer ();/******************************************************************************************************************
**  [PUBLIC]   : 
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
**   Changed By    Alfee    Change Date   02.19.2014    Reason: Reconstructed for Citrix using
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
integer li_FileNum
string ls_run
string PRINTER_PATH
string ls_printer_key
string ls_message[]

////////////////////////////////////////////////////////////////////////////
// check to see if diver exist
////////////////////////////////////////////////////////////////////////////
IF IS_ARCHITECTURE = "32-bit" THEN
	if not FileExists(gnv_app.is_application_path  + "\drivers\ghostpdf32.INF"  )   then ls_message[upperbound(ls_message) + 1] = 'The ghostpdf32.INF file is missing, PDF Printer Installiation cannot continue.'
ELSE //"64-bit"
	if not FileExists(gnv_app.is_application_path  + "\drivers\ghostpdf64.INF"  )   then ls_message[upperbound(ls_message) + 1] = 'The ghostpdf64.INF file is missing, PDF Printer Installiation cannot continue.'		
END IF

if upperbound(ls_message) > 0 then 
	f_system_error_handler ("There are files missing in the drivers directory. You will need to call intelisoft support.")
	return -1
end if 

////////////////////////////////////////////////////////////////////////////
// check to see if the printer is there
////////////////////////////////////////////////////////////////////////////
PRINTER_PATH = 'HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices'
RegistryGet(PRINTER_PATH, IS_PDF_PRINTER, regString!,ls_printer_key)
 
if not f_validstr(ls_printer_key) then
   messagebox('Installing Printers', 'The printer ' + IS_PDF_PRINTER + ' is missing. This printer is required for saving  datawindows in pdf format. IntelliSoft will now add it. If a dialog box comes up please click continue. This process may take a few minutes to complete')
	IF IS_ARCHITECTURE = "32-bit" THEN	
	   ls_run = " printui.dll,PrintUIEntry /if /b " + '"' +  IS_PDF_PRINTER + '"' + ' /f "' + gnv_app.is_application_path  + '\drivers\ghostpdf32.INF"' + " /r " + '"com4:"' +' /m' +  ' "GhostScript PDF"' 
	ELSE
	   ls_run = " printui.dll,PrintUIEntry /if /b " + '"' +  IS_PDF_PRINTER + '"' + ' /f "' + gnv_app.is_application_path  + '\drivers\ghostpdf64.INF"' + " /r " + '"com4:"' +' /m' +  ' "GhostScript PDF"' 		
	END IF
  	Run('rundll32.exe'  + ls_run)
end if 

long ll_start
ll_start = cpu()

DO UNTIL f_validstr(ls_printer_key)
	Yield()
	
	//Failed to install printer
	if cpu() - ll_start > 10000 then	
		//f_system_error_handler ("Failed to install printer. You will need to call intelisoft support.")
		return -1
	end if
   RegistryGet(PRINTER_PATH, IS_PDF_PRINTER, regString!,ls_printer_key)
LOOP

RETURN  0

//////////////////////////////////////////////////////////////////////////////
//// check to see if diver exist
//////////////////////////////////////////////////////////////////////////////
//
////Start Code Change ---- 04.26.2006 #416 maha changed variable
//if not FileExists(gnv_app.is_application_path  + "\drivers\ADIST5.INF"  )   then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
////$<comment> 03.13.2008 by Andy
////$Reason:It will failed to install the PDF print with PB9 drivers in Windows 2003,
////        it should use PB11 drivers.
////if not FileExists(gnv_app.is_application_path  + "\drivers\PSCRIPT.DRV"  )  then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
////if not FileExists(gnv_app.is_application_path  + "\drivers\PSCRPTUI.DLL"  ) then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
////if not FileExists(gnv_app.is_application_path  + "\drivers\PSCRIPT.DLL"  )  then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
////if not FileExists(gnv_app.is_application_path  + "\drivers\ADIST5K.PPD"  )  then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
////end of comment 03.13.2008
///*
//if not FileExists(gs_dir_path  + "intellicred\drivers\ADIST5.INF"  )   then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
//if not FileExists(gs_dir_path  + "intellicred\drivers\PSCRIPT.DRV"  )  then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
//if not FileExists(gs_dir_path  + "intellicred\drivers\PSCRPTUI.DLL"  ) then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
//if not FileExists(gs_dir_path  + "intellicred\drivers\PSCRIPT.DLL"  )  then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
//if not FileExists(gs_dir_path  + "intellicred\drivers\ADIST5K.PPD"  )  then ls_message[upperbound(ls_message) + 1] = 'The ADIST5.INF file is missing, PDF Printer Installiation cannot continue.'
//*/
////End Code Change---04.25.2006
//
//if upperbound(ls_message) > 0 then 
//	//Messagebox('PDF Printer Driver','There are files missing in the drivers directory. You will need to call intelisoft support.')
//	f_system_error_handler ("There are files missing in the drivers directory. You will need to call intelisoft support.")
//	return -1
//end if 
//
//////////////////////////////////////////////////////////////////////////////
//// check to see if the printer is there
//////////////////////////////////////////////////////////////////////////////
//
//PRINTER_PATH = 'HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices'
//RegistryGet(PRINTER_PATH, IS_PDF_PRINTER, regString!,ls_printer_key)
// 
//if not f_validstr(ls_printer_key) then
//	//$<modify> 03.13.2008 by Andy
//   messagebox('Installing Printers', 'The printer ' + IS_PDF_PRINTER + ' is missing. This printer is required for saving  datawindows in pdf format. IntelliSoft will now add it. If a dialog box comes up please click continue. This process may take a few minutes to complete')
//   ls_run = " printui.dll,PrintUIEntry /if /b " + '"' +  IS_PDF_PRINTER + '"' + ' /f "' + gnv_app.is_application_path  + '\drivers\ADIST5.INF"' + " /r " + '"com4:"' +' /m' +  ' "Acrobat Distiller CS"' 
//	//end of modify 03.13.2008
//  	run('rundll32.exe'  + ls_run)
//end if 
//long ll_start
//ll_start = cpu()
//
//DO UNTIL f_validstr(ls_printer_key)
//	Yield()
//	
//	//Failed to install printer
//	if cpu() - ll_start > 10000 then	
//		//f_system_error_handler ("Failed to install printer. You will need to call intelisoft support.")
//		return -1
//	end if
//   RegistryGet(PRINTER_PATH, IS_PDF_PRINTER, regString!,ls_printer_key)
//LOOP
//
//
//return 0
end function

public function integer of_set_path ();/******************************************************************************************************************
**  [PUBLIC]   : of_set_path
**==================================================================================================================
**  Purpose   	: Set the current "system path" for this session
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: -1 : Failure, 0 - Success
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 31 January 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
ulong lul_chars 
string ls_path, ls_var 
string ls_null
string bin_path
string ls_ARCHITECTURE 
string ls_prn_path, ls_printer_key, ls_gs_path  //alfee 03.27.2014 

setnull(ls_null)
ls_var = "PATH" 
ls_path = Space( 2048 )
lul_chars = GetEnvironmentVariableA( ls_var, ls_path, 2048 ) 

//---------Begin Added by (Appeon)Alfee 03.27.2014 for -----------------------------------
// Return if the printer is already installed
ls_prn_path = 'HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices'
RegistryGet(ls_prn_path, IS_PDF_PRINTER, regString!,ls_printer_key)
IF f_validstr(ls_printer_key) THEN RETURN 0

//Set the path of the ghostscript execute file
ls_gs_path = gs_dir_path + gs_DefDirName + "\ghostscript\"
IF appeongetclienttype() = "PB" THEN ls_gs_path = gs_current_path + "\Drivers\"
//---------End Added ----------------------------------------------------------------------------

IF IS_ARCHITECTURE = '32-bit' THEN
	RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\AFPL Ghostscript\8.53", "GS_DLL", RegString!, bin_path)
	if not f_validstr(bin_path) or not fileexists (bin_path) then  //if not f_validstr(bin_path) then - alfee 03.27.2014 
		RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\AFPL Ghostscript\8.54", "GS_DLL", RegString!, bin_path)
	end if
	
	if not f_validstr(bin_path) or not fileexists (bin_path) then  
		if messagebox('Missing Application', 'Ghostscript has not been installed on this machine. Would you like to install it?',question!,yesNO!,1) = 1 then 
			//if not fileexists(gs_dir_path + gs_DefDirName + "\ghostscript\gs853w32.exe") and  not fileexists(gs_dir_path + gs_DefDirName + "\ghostscript\gs854w32.exe") then
			if not fileexists(ls_gs_path + "gs853w32.exe") and  not fileexists(ls_gs_path + "gs854w32.exe") then //alfee 03.27.2014	
				if MessageBox('Ghostscript Missing', 'The Ghostscript install is missing from this machine. Do you want to install it from then web? Once it is downloaded please install it or this message will appear again.',Question!,YesNo!) = 1 then 
					 //ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', "http://downloads.sourceforge.net/ghostscript/gs854w32.exe?modtime=1148943324&big_mirror=1" , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
					 ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), "http://downloads.sourceforge.net/ghostscript/gs854w32.exe?modtime=1148943324&big_mirror=1" , ls_Null, 4)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
				 end if 
				return -1
			end if
			//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', gs_dir_path + gs_DefDirName + "\ghostscript\gs854w32.exe" , ls_Null, 4)
			//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_gs_path + "gs854w32.exe" , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
			ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_gs_path + "gs854w32.exe", ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		end if 
		return -1
	end if
ELSE //64-bit	
	//RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\GPL Ghostscript\8.71", "GS_DLL", RegString!, bin_path)
	of_RegistryGet( "SOFTWARE\GPL Ghostscript\8.71", "GS_DLL", ref bin_path )
	if not f_validstr(bin_path) or not fileexists (bin_path) then  
		if messagebox('Missing Application', 'Ghostscript has not been installed on this machine. Would you like to install it?',question!,yesNO!,1) = 1 then 
			//if not fileexists(gs_dir_path + gs_DefDirName + "\ghostscript\gs871w64.exe") then
			if not fileexists(ls_gs_path + "gs871w64.exe") then //alfee 03.27.2014	
				if MessageBox('Ghostscript Missing', 'The Ghostscript install is missing from this machine. Do you want to install it from then web? Once it is downloaded please install it or this message will appear again.',Question!,YesNo!) = 1 then 
					  //ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', "http://downloads.ghostscript.com/public/gs871w64.exe" , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
					ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), "http://downloads.ghostscript.com/public/gs871w64.exe", ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
				 end if 
				return -1
			end if
			//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', gs_dir_path + gs_DefDirName + "\ghostscript\gs871w64.exe" , ls_Null, 4)
			//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_gs_path + "gs871w64.exe" , ls_Null, 4) //alfee 03.27.2014   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
			ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_gs_path + "gs871w64.exe", ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		end if 
		return -1
	end if
END IF

/////////////////////////////////////////////////////////////////////////////////////
// do not set the path if it already exists
/////////////////////////////////////////////////////////////////////////////////////
if PosA(bin_path, '\bin') > 0 then 
	bin_path = MidA(bin_path,1, PosA(bin_path, '\bin') + 3)
end if 

if PosA ( ls_path, bin_path ) > 0 then return 0

IF lul_chars > 0 THEN 
 	ls_path += ( ";" +bin_path )
    IF NOT SetEnvironmentVariableA( ls_var, ls_path ) THEN 
    END IF 
END IF

Return 0
end function

public function integer of_registryget (string as_subkey, string as_keyname, ref string as_value);//added by gavins 20140218
Long hk_machine = 2147483650
string result 
result = space( 1024 )
long resultsize , handle
resultsize = 1024
long lptype 
lptype = 0
string     subkey
subkey = as_subkey// "SOFTWARE\AFPL Ghostscript\8.53"
string		keyname
keyname =  as_keyname//"GS_DLL"

RegOpenKeyEx( hk_machine, subkey, 0,257, ref  handle )

RegQueryValueEx( handle, keyname , 0, ref lptype,ref result , ref resultsize )

as_value = result

RegCloseKey( handle )






Return 0
end function

on n_cst_pdf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_pdf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;

n_cst_filesrvwin32 inv_filesrv
inv_filesrv = create n_cst_filesrvwin32

//Start Code Change ---- 04.26.2006 #417 maha
IF NOT inv_filesrv.of_DirectoryExists (gs_temp_path + 'Mail') THEN
       inv_filesrv.of_CreateDirectory (gs_temp_path + 'Mail')
END IF
//End Code Change---04.26.2006

//---------Begin Added by (Appeon)Alfee 07.03.2014 -------------------- -------------------
n_cst_systeminfo lnv_systeminfo
lnv_systeminfo = create n_cst_systeminfo
If lnv_systeminfo.of_get_envvar('ProgramW6432') <> '' or lnv_systeminfo.of_get_envvar('ProgramFiles(x86)')  <> '' Then 
	IS_ARCHITECTURE = '64-bit'
Else
	IS_ARCHITECTURE = '32-bit'
End If
Destroy lnv_systeminfo
//---------End Added ----------------------------------------------------------------------------
end event

