$PBExportHeader$n_getfilename.sru
$PBExportComments$GetOpenFileName WinAPI call (with multi-select)
forward
global type n_getfilename from nonvisualobject
end type
type openfilename from structure within n_getfilename
end type
end forward

type openfilename from structure
	ulong		lStructSize
	ulong		hwndOwner
	ulong		hInstance
	ulong		lpstrFilter
	ulong		lpstrCustomFilter
	ulong		nMaxCustFilter
	ulong		nFilterIndex
	ulong		lpstrFile
	ulong		nMaxFile
	ulong		lpstrFileTitle
	ulong		nMaxFileTitle
	ulong		lpstrInitialDir
	ulong		lpstrTitle
	ulong		Flags
	integer		nFileOffset
	integer		nFileExtension
	ulong		lpstrDefExt
	ulong		lCustData
	ulong		lpfnHook
	ulong		lpTemplateName
end type

global type n_getfilename from nonvisualobject autoinstantiate
end type

type prototypes
Private:
Function long GetFileNames ( &
	long isOpenOrSave, long hwnd, string title, string filter, string extension,string initdir, string initialfile,long  flags,ref string returnFile,long multiFile &
	) Library "AppeonDLL.dll" 
	


end prototypes

type variables
Public:
string 		is_Null
Integer		il_hwnd
boolean		ib_showhelp
end variables

forward prototypes
private subroutine of_chartostring (boolean ab_multifile, character ac_char[], ref string as_string[])
private function integer of_getfilename (boolean ab_openfilename, boolean ab_multifile, unsignedlong aul_flags, string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter, string as_initdir, string as_initialfile)
public function string of_getfolderpath (long al_csidl)
private subroutine of_parse (string as_sep, string as_list, ref string as_array[])
private function long of_stringtochar (string as_string, ref character ac_char[])
public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename)
public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_initdir)
public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[])
public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter, string as_initdir)
public function integer of_getsavefilename (string as_title, ref string as_pathname, ref string as_filename)
public function integer of_getsavefilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_initdir)
public function unsignedlong of_sethelp (window aw_window)
public subroutine of_sethelpoff ()
public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter)
public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter)
public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename[], string as_extension, string as_filter)
public function integer of_getsavefilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter)
public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension)
public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, unsignedlong aul_flags)
public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_initdir, unsignedlong aul_flags)
public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter, string as_initdir, unsignedlong aul_flags)
public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter, unsignedlong aul_flags)
public subroutine of_sethandle (long al_handle)
end prototypes

private subroutine of_chartostring (boolean ab_multifile, character ac_char[], ref string as_string[]);// -----------------------------------------------------------------------------
// SCRIPT:     of_CharToString
//
// PURPOSE:    This function converts a character array into an array of
//					strings.  Each string is separated by a null entry.
//
// ARGUMENTS:  ab_multifile	-	True=Multiple files allowed, False=Single
//					ac_char[]		-	Character array
//					as_string[]		-	Output String array
//
// RETURN:     Long				-	The number of entries in the string array
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Long ll_char, ll_max, ll_array = 1
String ls_empty[]

as_string = ls_empty

ll_max = UpperBound(ac_char)
For ll_char = 1 To ll_max
	If ac_char[ll_char] = Char(0) Then
		If ab_multifile Then
			If ac_char[ll_char + 1] = Char(0) Then
				Exit
			Else
				ll_array = ll_array + 1
			End If
		Else
			Exit
		End If
	Else
		as_string[ll_array] += String(ac_char[ll_char])
	End If
Next

end subroutine

private function integer of_getfilename (boolean ab_openfilename, boolean ab_multifile, unsignedlong aul_flags, string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter, string as_initdir, string as_initialfile);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetFileName
//
// PURPOSE:    This function opens the GetOpenFileName or GetSaveFileName
//					dialog boxes.
//
// ARGUMENTS:  ab_openfilename	-	True=GetOpenFileName, False=GetSaveFileName
//					ab_multifile		-	True=Multiple files allowed, False=Single
//					aul_flags			-	Flag to set various options
//					as_title				-	Title for the dialog box
//					as_pathname[]		-	Array of returned full path filenames
//					as_filename[]		-	Array of returned filenames
//					as_extension		-	Default file extension
//					as_filter			-	Filter string (see PB Help for format)
//					as_initdir			-	Initial directory
//					as_initialfile		-	Initial file name
//
// RETURN:     Integer				-	 1 = File(s) were selected
//												 0 = User clicked cancel button
//												-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// -----------------------------------------------------------------------------

Integer li_rc, li_cnt, li_max, li_next, li_Return, li_Multi
Long ll_errcode, ll_length, ll_sizeof
Char lc_pathname[], lc_filter[]
String ls_filter[], ls_work[], ls_ReturnFiles, ls_filename, ls_path
Boolean lb_return
PowerObject   lpwo_Parent

If Upperbound( as_pathname ) > 0 Then ls_path = as_pathname[1]
If Upperbound( as_filename ) > 0 Then ls_filename = as_filename[1]

If Not ab_multifile Then
	If ab_openfilename Then
		If aul_flags > 0 Then
			li_Return = GetFileOpenName( as_title, ls_path,ls_filename, as_extension,as_filter, as_initdir, aul_flags )
		Else
			li_Return = GetFileOpenName( as_title, ls_path,ls_filename, as_extension,as_filter, as_initdir )
		End If
	Else
		If aul_flags > 0 Then
			li_Return = GetFileSaveName( as_title, ls_path,ls_filename, as_extension,as_filter, as_initdir, aul_flags )
		Else
			li_Return = GetFileSaveName( as_title, ls_path,ls_filename, as_extension,as_filter, as_initdir )
		End If
	End If
	as_filename[1] = ls_filename
	as_pathname[1] = ls_path
Else
	If ab_openfilename Then
		If aul_flags > 0 Then
			li_Return = GetFileOpenName( as_title, as_pathname[1],as_filename, as_extension,as_filter, as_initdir, aul_flags )
		Else
			li_Return = GetFileOpenName( as_title, as_pathname[1],as_filename, as_extension,as_filter, as_initdir )
		End If
	Else
		If aul_flags > 0 Then
			li_Return = GetFileSaveName( as_title, as_pathname[1],as_filename, as_extension,as_filter, as_initdir, aul_flags )
		Else
			li_Return = GetFileSaveName( as_title, as_pathname[1],as_filename, as_extension,as_filter, as_initdir )
		End If
	End If
End If
If li_Return <> 1 Then as_pathname = ls_Work

Return li_Return





end function

public function string of_getfolderpath (long al_csidl);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetFolderPath
//
// PURPOSE:    This function returns the path to a shell folder. The identifiers
//					are defined as public instance constants.
//
// ARGUMENTS:  al_CSIDL	- Shell folder identifier
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON

// -----------------------------------------------------------------------------

Constant Long SHGFP_TYPE_CURRENT = 0
String ls_path

ls_path = Space(256)



Return ls_path

end function

private subroutine of_parse (string as_sep, string as_list, ref string as_array[]);// -----------------------------------------------------------------------------
// SCRIPT:     of_Parse
//
// PURPOSE:    This function parses a string of comma separated values and
//					returns an array.
//
// ARGUMENTS:  as_sep		-	The separating value
//					as_list		-	String containing separated list
//					as_array[]	-	String array returned
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// -----------------------------------------------------------------------------

Long ll_pos, ll_cnt, ll_start
String ls_empty[], ls_list
Integer li_next

as_array = ls_empty
ls_list = Trim(as_list)
If Right(ls_list, 1) <> as_sep Then
	ls_list = ls_list + as_sep
End If

ll_start = 1
ll_pos = Pos(ls_list, as_sep, ll_start)
do while ll_pos > 1
	li_next = UpperBound(as_array) + 1
	as_array[li_next] = Mid(ls_list, ll_start, (ll_pos - ll_start))
	ll_start = ll_pos + 1
	ll_pos = Pos(ls_list, as_sep, ll_start)
loop

end subroutine

private function long of_stringtochar (string as_string, ref character ac_char[]);// -----------------------------------------------------------------------------
// SCRIPT:     of_StringToChar
//
// PURPOSE:    This function converts a string to an array of chars.  If this
//					function is called again, the string is added to the end of the
//					array.  Each string is separated by a single null and there are
//					two nulls at the end.
//
// ARGUMENTS:  as_string	-	String to convert
//					ac_char[]	-	String variable to search for
//
// RETURN:     Long			-	Number of entries in the array
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON


Long ll_len, ll_char, ll_into

// copy string to array
ll_len = Len(as_string)
FOR ll_char = 1 TO ll_len
	If ll_char = 1 Then
		ll_into = UpperBound(ac_char)
		If ll_into = 0 Then
			ll_into = 1
		End If
	Else
		ll_into = UpperBound(ac_char) + 1
	End If
	ac_char[ll_into] = Mid(as_string, ll_char, 1)
NEXT

// terminate with two nulls
SetNull(ac_char[ll_into + 1])
SetNull(ac_char[ll_into + 2])

Return UpperBound(ac_char)

end function

public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname		-	Returned full path filename
//					as_filename		-	Returned filename
//
// RETURN:     Integer			-	 1 = File was selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Return of_GetOpenFileName(as_title, as_pathname, as_filename, "", "All Files (*.*), *.*", "")

end function

public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_initdir);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname		-	Returned full path filename
//					as_filename		-	Returned filename
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File was selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------

long ll_flag

Return of_GetOpenFileName(as_title, as_pathname, as_filename, as_extension, as_filter, as_initdir,ll_flag  )
end function

public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[]);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname[]	-	Array of returned full path filenames
//					as_filename[]	-	Array of returned filenames
//
// RETURN:     Integer			-	 1 = File(s) were selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON

// -----------------------------------------------------------------------------

Return of_GetOpenFileName(as_title, as_pathname, as_filename, "", "All Files (*.*), *.*", "")

end function

public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter, string as_initdir);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname[]	-	Array of returned full path filenames
//					as_filename[]	-	Array of returned filenames
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File(s) were selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------

long ll_flag

Return of_GetOpenFileName(as_title, as_pathname, as_filename, as_extension,as_filter,as_initdir, ll_flag )

end function

public function integer of_getsavefilename (string as_title, ref string as_pathname, ref string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetSaveFileName
//
// PURPOSE:    This function opens the GetSaveFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname		-	Returned full path filename
//					as_filename		-	Returned filename
//
// RETURN:     Integer			-	 1 = File was selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON

// -----------------------------------------------------------------------------

Return of_GetSaveFileName(as_title, as_pathname, as_filename, "", "All Files (*.*), *.*", "")

end function

public function integer of_getsavefilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_initdir);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetSaveFileName
//
// PURPOSE:    This function opens the GetSaveFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname		-	Returned full path filename
//					as_filename		-	Returned filename
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File was selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Integer li_rc
ULong lul_flags
String ls_pathname[], ls_filename[]
string ls_inifile

//lul_flags = OFN_HIDEREADONLY + OFN_EXPLORER + OFN_OVERWRITEPROMPT

If Len( as_pathname ) > 0 Then 
	ls_inifile = Mid( as_PathName, LastPos( as_pathname, '\' ) + 1 )
Else
	ls_Inifile = as_filename 
End If
ls_pathname[1] = as_PathName
ls_filename[1] = as_filename
li_rc = of_GetFileName(False, False, lul_flags, as_title, ls_pathname, &
				ls_filename, as_extension, as_filter, as_initdir, ls_Inifile)

If UpperBound(ls_pathname) = 0 Then
	as_pathname = ""
	as_filename = ""
Else
	as_pathname = ls_pathname[1]
	as_filename = ls_filename[1]
End If

Return li_rc

end function

public function unsignedlong of_sethelp (window aw_window);// -----------------------------------------------------------------------------
// SCRIPT:     of_SetHelp
//
// PURPOSE:    This function activates the Help button on the getfilename
//					dialog window. It also registers an event on the passed window
//					that will be triggered when the Help button is clicked.
//
// ARGUMENTS:  aw_window	- The window displaying the dialog
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// -----------------------------------------------------------------------------

il_hwnd = Handle(aw_window)

ib_ShowHelp  = True

Return 0

end function

public subroutine of_sethelpoff ();// -----------------------------------------------------------------------------
// SCRIPT:     of_SetHelpOff
//
// PURPOSE:    This function turns off the Help button.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// -----------------------------------------------------------------------------

il_hwnd = 0

ib_ShowHelp  = False

end subroutine

public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname		-	Returned full path filename
//					as_filename		-	Returned filename
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File was selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Return of_GetOpenFileName(as_title, as_pathname, as_filename, as_extension, as_filter, "")
end function

public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname[]	-	Array of returned full path filenames
//					as_filename[]	-	Array of returned filenames
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File(s) were selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Return of_GetOpenFileName(as_title, as_pathname, as_filename, as_extension,as_filter, "")

end function

public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename[], string as_extension, string as_filter);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname[]	-	Array of returned full path filenames
//					as_filename[]	-	Array of returned filenames
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File(s) were selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------

long ll_Null
SetNull( ll_Null )
string ls_pathname[]
integer	li_return

li_return = of_GetOpenFileName(as_title, ls_pathname, as_filename, as_extension,as_filter,"", ll_Null )
If li_return = 1 and upperbound( ls_Pathname ) > 0 Then as_pathname =  ls_Pathname[1]
return li_return
end function

public function integer of_getsavefilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetSaveFileName
//
// PURPOSE:    This function opens the GetSaveFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname		-	Returned full path filename
//					as_filename		-	Returned filename
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File was selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Return of_GetSaveFileName(as_title, as_pathname, as_filename, as_extension, as_filter, "")

end function

public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname		-	Returned full path filename
//					as_filename		-	Returned filename
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File was selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Return of_GetOpenFileName(as_title, as_pathname, as_filename, as_extension, "All Files (*.*), *.*", "")


end function

public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, unsignedlong aul_flags);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname		-	Returned full path filename
//					as_filename		-	Returned filename
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File was selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Return of_GetOpenFileName(as_title, as_pathname, as_filename, as_extension, as_filter, "", aul_flags )

 

end function

public function integer of_getopenfilename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_initdir, unsignedlong aul_flags);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname		-	Returned full path filename
//					as_filename		-	Returned filename
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File was selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------

Integer li_rc
ULong lul_flags
String ls_pathname[], ls_filename[]

lul_flags =aul_flags

li_rc = of_GetFileName(True, False, lul_flags, as_title, ls_pathname, &
				ls_filename, as_extension, as_filter, as_initdir, as_filename)

If UpperBound(ls_pathname) = 0 Then
	as_pathname = ""
	as_filename = ""
Else
	as_pathname = ls_pathname[1]
	as_filename = ls_filename[1]
End If

Return li_rc
//Return of_GetOpenFileName(as_title, as_pathname, as_filename, as_extension, as_filter, as_initdir, aul_flags )
end function

public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter, string as_initdir, unsignedlong aul_flags);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname[]	-	Array of returned full path filenames
//					as_filename[]	-	Array of returned filenames
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File(s) were selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Integer li_rc
ULong lul_flags

lul_flags = aul_flags


li_rc = of_GetFileName(True, True, lul_flags, as_title, as_pathname, &
				as_filename, as_extension, as_filter, as_initdir, '')

Return li_rc


end function

public function integer of_getopenfilename (string as_title, ref string as_pathname[], ref string as_filename[], string as_extension, string as_filter, unsignedlong aul_flags);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetOpenFileName
//
// PURPOSE:    This function opens the GetOpenFileName dialog box.
//
// ARGUMENTS:  as_title			-	Title for the dialog box
//					as_pathname[]	-	Array of returned full path filenames
//					as_filename[]	-	Array of returned filenames
//					as_extension	-	Default file extension
//					as_filter		-	Filter string (see PB Help for format)
//					as_initdir		-	Initial directory
//
// RETURN:     Integer			-	 1 = File(s) were selected
//											 0 = User clicked cancel button
//											-1 = Some sort of error
//
// DATE        PROG/ID 		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------


Return of_GetOpenFileName(as_title, as_pathname, as_filename, as_extension,as_filter,"", aul_flags)
end function

public subroutine of_sethandle (long al_handle);il_hWnd = al_Handle
end subroutine

on n_getfilename.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_getfilename.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;SetNull( il_hWnd )

end event

