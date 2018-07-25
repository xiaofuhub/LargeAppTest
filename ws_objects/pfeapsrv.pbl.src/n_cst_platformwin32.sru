$PBExportHeader$n_cst_platformwin32.sru
$PBExportComments$Extension Win32 Cross Platform service
forward
global type n_cst_platformwin32 from pfc_n_cst_platformwin32
end type
end forward

global type n_cst_platformwin32 from pfc_n_cst_platformwin32
end type
global n_cst_platformwin32 n_cst_platformwin32

forward prototypes
public function boolean of_iscurrentietab ()
end prototypes

public function boolean of_iscurrentietab ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_platformwin32.of_iscurrentietab()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description> Only For Web Version.
// $<description> Check the current IE tab whether is CL application.
// $<description> If get error, need return TRUE
//////////////////////////////////////////////////////////////////////
// $<add> 2011-02-22 by Ken.Guo
//$<Modify History>:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

Long ll_handle
String ls_IETitle,ls_mdiTitle
n_cst_string ln_string	//long.zhang 03.19.2014 Bug_id #3975 

If AppeonGetClientType() <> "WEB" Then Return True

ll_handle = appeongetiehandle()
If ll_handle <= 0 Then Return True

ls_IETitle = of_GetWindowText(ll_Handle)
If isnull(ls_IETitle) or ls_IETitle = '' Then
	Return True
Else
	ls_mdiTitle = w_mdi.title 
	
	//-------------appeon begin----------------------
	//<$>added:long.zhang 03.19.2014
	//<$>reason:bug 3975
	ls_IETitle = ln_string.of_globalreplace(ls_IETitle, '-','')
	ls_mdiTitle = ln_string.of_globalreplace(ls_mdiTitle, '-','')
	ls_IETitle = ln_string.of_globalreplace(ls_IETitle, '\','')
	ls_mdiTitle = ln_string.of_globalreplace(ls_mdiTitle, '\','')
		ls_IETitle = ln_string.of_globalreplace(ls_IETitle, ' ','')
	ls_mdiTitle = ln_string.of_globalreplace(ls_mdiTitle, ' ','')
	ls_IETitle = trim(ls_IETitle)
	ls_mdiTitle = trim(ls_mdiTitle)
//-------------appeon End------------------------
	
	If Pos( Lower(ls_IETitle), Lower(ls_mdiTitle)) > 0 Then
		Return True
	Else
		gnv_debug.of_Output(False, 'IE Title:' + ls_IETitle)
		gnv_debug.of_Output(False, 'MDI Title:' + ls_MdiTitle)
		Return False
	End If
End If

Return True
	
	
	
end function

on n_cst_platformwin32.create
call super::create
end on

on n_cst_platformwin32.destroy
call super::destroy
end on

