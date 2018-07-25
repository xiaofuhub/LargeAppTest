$PBExportHeader$n_cst_shell.sru
forward
global type n_cst_shell from nonvisualobject
end type
end forward

global type n_cst_shell from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_delete_recent (string as_filename, boolean ab_fullpath)
end prototypes

public function integer of_delete_recent (string as_filename, boolean ab_fullpath);//////////////////////////////////////////////////////////////////////
// Function: of_delete_recent()
// Arguments:
// 	value    string    as_filename
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-05-24
//--------------------------------------------------------------------
// Description: Delete the Windows Recent Document.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Integer li_ret,i
string ls_recent_path

oleobject lole_shell,lole_folder
lole_shell = Create oleobject
//lole_folder = Create oleobject

li_ret = lole_shell.connecttonewobject( "Wscript.Shell")

lole_folder = lole_shell.SpecialFolders
ls_recent_path = String(lole_folder.item(13)) //Recent

If isvalid(lole_shell) Then Destroy lole_shell
If isvalid(lole_folder) Then Destroy lole_folder

If ab_fullpath Then
	as_filename = Mid(as_filename,lastpos(as_filename,'\') + 1 ,Len(as_filename))
End If

If FileExists(ls_recent_path + '\' + as_filename + '.lnk') Then
	If FileDelete(ls_recent_path + '\' + as_filename + '.lnk') Then
		Return 1
	Else
		Return -1
	End If
Else
	Return -2 //Not Exists
End If

Return 1
end function

on n_cst_shell.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_shell.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

