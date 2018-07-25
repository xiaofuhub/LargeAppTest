$PBExportHeader$n_cst_kernel32.sru
$PBExportComments$kernel32 api calls
forward
global type n_cst_kernel32 from nonvisualobject
end type
end forward

global type n_cst_kernel32 from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION ulong GetCurrentDirectoryA(ulong BufferLen, ref string currentdir) LIBRARY "Kernel32.dll" alias for "GetCurrentDirectoryA;Ansi"
FUNCTION ulong GetEnvironmentVariableA(string szVarName, REF string lpValue, ulong dwSize) LIBRARY "kernel32.dll" alias for "GetEnvironmentVariableA;Ansi"
FUNCTION boolean SetEnvironmentVariableA(string szVarName, string szValue) LIBRARY "kernel32.dll" alias for "SetEnvironmentVariableA;Ansi"
end prototypes

forward prototypes
public function integer of_set_gs_path ()
end prototypes

public function integer of_set_gs_path ();/****************************************************************************************************************
** [PUBLIC] EVENT   selectionchanged :: UO_TAB_MEASUREMENTS
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[long] oldindex
**				   [long] newindex
**
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/
ulong    lul_chars
string    ls_path, ls_var
string ls_curdir
ulong l_buf

l_buf = 100

////////////////////////////////////////////////////////////////////////////////////////////////////
/// get the path
////////////////////////////////////////////////////////////////////////////////////////////////////

ls_var = "PATH"
ls_path = Space( 1024 )
lul_chars = GetEnvironmentVariableA( ls_var, ls_path, 1024 )

////////////////////////////////////////////////////////////////////////////////////////////////////
// get the current directory of the exe
////////////////////////////////////////////////////////////////////////////////////////////////////

ls_curdir = space(l_buf)
GetCurrentDirectoryA(l_buf, ls_curdir)

///////////////////////////////////////////////////////////////////////////////////////////////////
// modify the path to include the ghost script
////////////////////////////////////////////////////////////////////////////////////////////////////
long ll_pos
ll_pos  = PosA ("\gs\gs8.14\bin" ,lower(ls_path))
if  ll_pos < 1 then
	IF lul_chars > 0 THEN
		 ls_path = (  ls_curdir + "\gs\gs8.14\bin" )
		  string ls_titlefont
         RegistryGet( "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment", "Path", RegExpandString!, ls_titlefont)
         messagebox(ls_path ,ls_curdir)
//RegistrySet( "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment","Path", RegExpandString!, ls_titlefont+ls_path )
//		 IF NOT SetEnvironmentVariableA( ls_var, ls_path ) THEN
//			  // failure - handle it
//			  messagebox('','path set failed')
//		 END IF
	END IF
end if 

return 1
end function

on n_cst_kernel32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_kernel32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

