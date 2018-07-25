$PBExportHeader$w_batreplace_eng.srw
forward
global type w_batreplace_eng from window
end type
type cb_4 from commandbutton within w_batreplace_eng
end type
type st_2 from statictext within w_batreplace_eng
end type
type plb_1 from picturelistbox within w_batreplace_eng
end type
type cb_3 from commandbutton within w_batreplace_eng
end type
type st_6 from statictext within w_batreplace_eng
end type
type st_5 from statictext within w_batreplace_eng
end type
type sle_2 from singlelineedit within w_batreplace_eng
end type
type sle_1 from singlelineedit within w_batreplace_eng
end type
type rb_2 from radiobutton within w_batreplace_eng
end type
type rb_1 from radiobutton within w_batreplace_eng
end type
type cbx_3 from checkbox within w_batreplace_eng
end type
type cbx_2 from checkbox within w_batreplace_eng
end type
type cbx_1 from checkbox within w_batreplace_eng
end type
type st_4 from statictext within w_batreplace_eng
end type
type ddlb_1 from dropdownlistbox within w_batreplace_eng
end type
type cb_2 from commandbutton within w_batreplace_eng
end type
type st_3 from statictext within w_batreplace_eng
end type
type st_1 from statictext within w_batreplace_eng
end type
type cb_1 from commandbutton within w_batreplace_eng
end type
type gb_1 from groupbox within w_batreplace_eng
end type
type gb_2 from groupbox within w_batreplace_eng
end type
type st_7 from statictext within w_batreplace_eng
end type
type st_8 from statictext within w_batreplace_eng
end type
type ln_1 from line within w_batreplace_eng
end type
type ln_2 from line within w_batreplace_eng
end type
type st_9 from statictext within w_batreplace_eng
end type
end forward

global type w_batreplace_eng from window
integer width = 2254
integer height = 1948
boolean titlebar = true
string title = "Bat Replace Tools(Please backup before execute this tool)"
boolean controlmenu = true
long backcolor = 67108864
string icon = "Application5!"
boolean center = true
cb_4 cb_4
st_2 st_2
plb_1 plb_1
cb_3 cb_3
st_6 st_6
st_5 st_5
sle_2 sle_2
sle_1 sle_1
rb_2 rb_2
rb_1 rb_1
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
st_4 st_4
ddlb_1 ddlb_1
cb_2 cb_2
st_3 st_3
st_1 st_1
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
st_7 st_7
st_8 st_8
ln_1 ln_1
ln_2 ln_2
st_9 st_9
end type
global w_batreplace_eng w_batreplace_eng

type prototypes
FUNCTION INT LibraryEntryImport(STRING lpszDestLibName, STRING lpszEntryName, INT iEntryType, STRING lpszEntrySyntax, STRING lpszAppName) LIBRARY "pborca.dll"
FUNCTION INT LibraryEntryImportEx(STRING lpszLibraryList[], INT iNumberOfLibs, STRING lpszDestLibName, STRING lpszEntryName, INT iEntryType, STRING lpszEntrySyntax, STRING lpszAppName) LIBRARY "pborca.dll"
end prototypes

type variables
String	is_ProLog,is_LineLog
String	is_FailedObject[],is_SuccessObject[],is_ReplaceTimes[]
Integer	ii_ObjTotalCount,ii_WinTotal,ii_UOTotal,ii_DwTotal,ii_FailedCount,ii_SuccessCount
Integer    ii_AppCount, ii_MenuCount,ii_FunctionCount,ii_StructureCount
Integer	ii_OriWinHeight = 1140
Integer	ii_ExtendHeight = 1700

String is_dir
end variables

forward prototypes
public function string wf_hazilyreplace (string as_str, string as_scr, string as_des)
public function string wf_findfilename (string as_pathname)
public subroutine wf_processing (string as_libname, string as_objname)
public subroutine wf_proresult (integer ai_proval)
public subroutine wf_setenabled ()
public subroutine wf_stringreplace (string as_winscr, string as_windes, string as_uoscr, string as_uodes, string as_dwscr, string as_dwdes)
public function string wf_replace (string as_str, string as_scr, string as_des)
public function integer wf_write (string ls_name, ref string ls_content, string ls_postfix)
end prototypes

public function string wf_hazilyreplace (string as_str, string as_scr, string as_des);////////////////////////////////////////////////////////////////
//Function : wf_hazilyreplace
//Argument : string as_str,string as_scr,string as_des
//Designer : WuZhiJun
//Date     : 2005-06-21
////////////////////////////////////////////////////////////////

String 	ls_Temp,ls_ScrLeft,ls_ScrRight
Long 		li_FindPos1,li_FindPos2
integer	li_Times=0

li_FindPos1 = Pos(as_Scr,'*')

if li_FindPos1 <= 0 then
	return wf_replace(as_str,as_scr,as_des)
end if

ls_ScrLeft = left(as_Scr,li_FindPos1 - 1)
ls_ScrRight = Mid(as_Scr,li_FindPos1 + 1)

if ls_ScrRight = '' then
	ls_ScrRight = "~r~n"
	as_Des += "~r~n"
end if

li_FindPos2 = Pos(as_Des,ls_ScrRight,li_FindPos1)

as_Des = Mid(as_Des,li_FindPos1,li_FindPos2 - li_FindPos1)

li_FindPos1 = Pos(as_str,ls_ScrLeft,1)
li_FindPos2 = Pos(as_str,ls_ScrRight,li_FindPos1 + Len(ls_ScrLeft))

do while li_FindPos1 > 0 and li_FindPos2 > 0
	as_str = Replace(as_str,li_FindPos1 + Len(ls_ScrLeft),li_FindPos2 - li_FindPos1 - Len(ls_ScrLeft),as_Des)
	li_Times++
	li_FindPos1 = Pos(as_str,ls_ScrLeft,li_FindPos1 + Len(ls_ScrLeft) + Len(as_Des))
	li_FindPos2 = Pos(as_str,ls_ScrRight,li_FindPos1 + Len(ls_ScrLeft))
loop

if li_Times > 0 then
	is_ReplaceTimes[ii_FailedCount + ii_SuccessCount + 1] = String(li_Times)
end if

return as_str

end function

public function string wf_findfilename (string as_pathname);////////////////////////////////////////////////////////////////
//Function : wf_FindFileName
//Argument : string as_PathName
//Designer : WuZhiJun
//Date     : 2005-06-22
////////////////////////////////////////////////////////////////

String 	ls_FileName
Long		ll_Pos1,ll_Pos2

ll_Pos1 = Pos(as_PathName,"\")

if ll_Pos1 <= 0 then 
	return as_PathName
end if

do while ll_Pos1 > 0
	ll_Pos2 = ll_Pos1
	ll_Pos1 = Pos(as_PathName,"\",ll_Pos2 + 1)
loop

ls_FileName = Mid(as_PathName,ll_Pos2 + 1)

return ls_FileName

end function

public subroutine wf_processing (string as_libname, string as_objname);String	ls_Temp

ls_Temp = wf_FindFileName(as_LibName) + "-->" + as_ObjName

st_1.Text = ls_temp

is_LineLog = ls_Temp
is_ProLog += ls_temp + "~t~t"



end subroutine

public subroutine wf_proresult (integer ai_proval);String	ls_OutPut
Integer	li_Index

ii_ObjTotalCount++

if ai_ProVal <> 0 then
	ii_FailedCount++
	is_FailedObject[ii_FailedCount] = is_LineLog
	li_Index = plb_1.AddItem(is_LineLog,2)
else
	ii_SuccessCount++
	is_SuccessObject[ii_SuccessCount] = is_LineLog
	li_Index = plb_1.AddItem(is_LineLog,1)
end if

plb_1.SetTop(li_Index)
st_3.Text = "S:" + String(ii_ObjTotalCount - ii_FailedCount) + " <-> F:" + String(ii_FailedCount)

Choose Case ai_ProVal
	Case 0
		ls_OutPut = "Successful"
	Case -1
		ls_OutPut = "Invalid parameter list"
	Case -2
		ls_OutPut = "Duplicate operation"
	Case -3
		ls_OutPut = "Object not found"
	Case -4
		ls_OutPut = "Bad library name"
	Case -5
		ls_OutPut = "Library list not set"
	Case -6
		ls_OutPut = "Library not in lib list"
	Case -7
		ls_OutPut = "Library I/O error"
	Case -8
		ls_OutPut = "Object exists"
	Case -9
		ls_OutPut = "Invalid name"
	Case -10
		ls_OutPut = "Buffer size is too small"
	Case -11
		ls_OutPut = "Compile error"
	Case -12
		ls_OutPut = "Link error"
	Case -13
		ls_OutPut = "Current appl not set"
	Case -14
		ls_OutPut = "Object has no ancestors"
	Case -15
		ls_OutPut = "Object has no references"
	Case -16
		ls_OutPut = "Invalid # of PBD's"
	Case -17
		ls_OutPut = "PBD create error"
	Case -18
		ls_OutPut = "check out/in error"
End Choose

st_2.Text = ls_OutPut

is_ProLog += ls_OutPut + "~r~n"


end subroutine

public subroutine wf_setenabled ();ddlb_1.Enabled = rb_1.Checked
sle_1.Enabled = Not rb_1.Checked
sle_2.Enabled = Not rb_1.Checked

end subroutine

public subroutine wf_stringreplace (string as_winscr, string as_windes, string as_uoscr, string as_uodes, string as_dwscr, string as_dwdes);////////////////////////////////////////////////////////////////
//Function : wf_stringreplace
//Argument : Boolean  ab_execute
//Designer : WuZhiJun
//Date     : 2005-06-21
////////////////////////////////////////////////////////////////

String	ls_Temp,ls_Syntax1,ls_Syntax2,ls_AppName
String	ls_LibList[],ls_LibName
String	ls_WinList[],ls_WinName
String	ls_UserObjList[],ls_UserObjName
String	ls_DwList[],ls_DwName

Integer	li_Cycle01,li_Cycle02,li_ImportRtn
Integer	li_LibCount,li_WinCount,li_UserObjCount,li_DwCount
long		ll_ObjPos,ll_TabPos

//==========================================================================

is_ProLog = ""
ii_ObjTotalCount = 0
ii_WinTotal = 0
ii_UOTotal = 0
ii_DwTotal = 0
ii_FailedCount = 0
ls_AppName = GetApplication().ClassName()
//==========================================================================

ls_Temp = GetLibraryList()

ll_ObjPos = Pos(ls_Temp,",")
do while ll_ObjPos > 0
	li_LibCount++
	ls_LibList[li_LibCount] = Left(ls_Temp,ll_ObjPos - 1)
	ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
	ll_ObjPos = Pos(ls_Temp,",")
loop

li_LibCount++
ls_LibList[li_LibCount] = ls_Temp

//==========================================================================

for li_Cycle01 = 1 to li_LibCount
	
	ls_LibName = ls_LibList[li_Cycle01]
	
	if cbx_1.Checked then
		ls_Temp = LibraryDirectoryEx(ls_LibName,DirWindow!)
		
		li_WinCount = 0
		ll_ObjPos = Pos(ls_Temp,'~n')
		do while ll_ObjPos > 0
			li_WinCount++
			ll_TabPos = Pos(ls_Temp,'~t')
			ls_WinList[li_WinCount] = Left(ls_Temp,ll_TabPos - 1)
			if ls_WinList[li_WinCount] = This.ClassName() then li_WinCount --
			ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
			ll_ObjPos = Pos(ls_Temp,'~n')
		loop
		
		for li_Cycle02 = 1 to li_WinCount
			Yield()
			ii_WinTotal++
			wf_Processing(ls_LibName,ls_WinList[li_Cycle02])
			ls_Syntax1 = LibraryExport(ls_LibName,ls_WinList[li_Cycle02],ExportWindow!)
			ls_Syntax2 = wf_hazilyreplace(ls_Syntax1,as_WinScr,as_WinDes)
			if ls_Syntax1 <> ls_Syntax2 then
				li_ImportRtn = LibraryEntryImportEx(ls_LibList[],li_LibCount,ls_LibName,ls_WinList[li_Cycle02],7,ls_Syntax2,ls_AppName)
				wf_ProResult(li_ImportRtn)
			end if
		next
	end if
	
	//-------------------------Export and import all userobject-------------------------
	if cbx_2.Checked then
		ls_Temp = LibraryDirectoryEx(ls_LibName,DirUserObject!)
		
		li_UserObjCount = 0
		ll_ObjPos = Pos(ls_Temp,'~n')
		do while ll_ObjPos > 0
			li_UserObjCount++
			ll_TabPos = Pos(ls_Temp,'~t')
			ls_UserObjList[li_UserObjCount] = Left(ls_Temp,ll_TabPos - 1)
			ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
			ll_ObjPos = Pos(ls_Temp,'~n')
		loop
		
		for li_Cycle02 = 1 to li_UserObjCount
			Yield()
			ii_UOTotal++
			wf_Processing(ls_LibName,ls_UserObjList[li_Cycle02])
			ls_Syntax1 = LibraryExport(ls_LibName,ls_UserObjList[li_Cycle02],ExportUserObject!)
			ls_Syntax2 = wf_hazilyreplace(ls_Syntax1,as_UOScr,as_UODes)
			if ls_Syntax1 <> ls_Syntax2 then
				li_ImportRtn = LibraryEntryImportEx(ls_LibList[],li_LibCount,ls_LibName,ls_UserObjList[li_Cycle02],6,ls_Syntax2,ls_AppName)
				wf_ProResult(li_ImportRtn)
			end if
		next
	end if
	
	//-------------------------Export and import all Datawindow-------------------------
	if cbx_3.Checked then
		ls_Temp = LibraryDirectoryEx(ls_LibName,DirDataWindow!)
		
		li_DwCount = 0
		ll_ObjPos = Pos(ls_Temp,'~n')
		do while ll_ObjPos > 0
			li_DwCount++
			ll_TabPos = Pos(ls_Temp,'~t')
			ls_DwList[li_DwCount] = Left(ls_Temp,ll_TabPos - 1)
			ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
			ll_ObjPos = Pos(ls_Temp,'~n')
		loop
		
		for li_Cycle02 = 1 to li_DwCount
			Yield()
			ii_DwTotal++
			wf_Processing(ls_LibName,ls_DwList[li_Cycle02])
			ls_Syntax1 = LibraryExport(ls_LibName,ls_DwList[li_Cycle02],ExportDataWindow!)
			ls_Syntax2 = wf_hazilyreplace(ls_Syntax1,as_DwScr,as_DwDes)
			if ls_Syntax1 <> ls_Syntax2 then
				li_ImportRtn = LibraryImport (ls_LibName,ls_DwList[li_Cycle02],ImportDataWindow!, ls_Syntax2, ls_Syntax1)
				if li_ImportRtn = 1 then li_ImportRtn = 0
//				li_ImportRtn = LibraryEntryImportEx(ls_LibList[],li_LibCount,ls_LibName,ls_DwList[li_Cycle02],1,ls_Syntax2,ls_AppName)
				wf_ProResult(li_ImportRtn)
			end if
		next
	end if
next

//==========================================================================

st_1.Text = "Replace Completed"

st_2.Text = "Total:" + String(ii_ObjTotalCount) + " Objects"

if ii_FailedCount = 0 then
	st_3.Text = "All succeed!"
else
	st_3.Text = String(ii_FailedCount) + " failed!"
end if

end subroutine

public function string wf_replace (string as_str, string as_scr, string as_des);////////////////////////////////////////////////////////////////
//Function : wf_replace
//Argument : string as_str,string as_scr,string as_des
//Designer : WuZhiJun
//Date     : 2004-11-24
////////////////////////////////////////////////////////////////

Long 		li_FindPos
integer 	li_Times

if as_Scr = as_Des then
	return as_str
end if

li_FindPos = Pos(lower(as_str),lower(as_Scr),1)
Do While li_FindPos > 0
	li_Times++
	as_str = Replace(as_str,li_FindPos,Len(as_Scr),as_Des)
	li_FindPos = Pos(lower(as_str),lower(as_Scr),li_FindPos + len(as_Des))
Loop

if li_Times > 0 then
	is_ReplaceTimes[ii_FailedCount + ii_SuccessCount + 1] = String(li_Times)
end if

return as_str

end function

public function integer wf_write (string ls_name, ref string ls_content, string ls_postfix);integer li_FileNum

li_FileNum = FileOpen(is_dir + ls_name + ls_postfix, TextMode!, Write!, LockWrite!, Replace!)

ls_content = '$PBExportHeader$' + ls_name + ls_postfix + '~r~n' + ls_content
FileWriteEx(li_FileNum, ls_content)

FileClose(li_FileNum)

return 1
end function

on w_batreplace_eng.create
this.cb_4=create cb_4
this.st_2=create st_2
this.plb_1=create plb_1
this.cb_3=create cb_3
this.st_6=create st_6
this.st_5=create st_5
this.sle_2=create sle_2
this.sle_1=create sle_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.st_4=create st_4
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.st_3=create st_3
this.st_1=create st_1
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.st_7=create st_7
this.st_8=create st_8
this.ln_1=create ln_1
this.ln_2=create ln_2
this.st_9=create st_9
this.Control[]={this.cb_4,&
this.st_2,&
this.plb_1,&
this.cb_3,&
this.st_6,&
this.st_5,&
this.sle_2,&
this.sle_1,&
this.rb_2,&
this.rb_1,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.st_4,&
this.ddlb_1,&
this.cb_2,&
this.st_3,&
this.st_1,&
this.cb_1,&
this.gb_1,&
this.gb_2,&
this.st_7,&
this.st_8,&
this.ln_1,&
this.ln_2,&
this.st_9}
end on

on w_batreplace_eng.destroy
destroy(this.cb_4)
destroy(this.st_2)
destroy(this.plb_1)
destroy(this.cb_3)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.st_4)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.st_9)
end on

event open;//This.Height = ii_OriWinHeight

wf_setenabled()

end event

type cb_4 from commandbutton within w_batreplace_eng
integer x = 1710
integer y = 1392
integer width = 343
integer height = 104
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Export"
end type

event clicked;////////////////////////////////////////////////////////////////
//Function : wf_stringreplace
//Argument : Boolean  ab_execute
//Designer : WuZhiJun
//Date     : 2005-06-21
////////////////////////////////////////////////////////////////

String	ls_Temp,ls_Syntax1,ls_Syntax2,ls_AppName
String	ls_LibList[],ls_LibName
String	ls_WinList[],ls_WinName
String	ls_UserObjList[],ls_UserObjName
String	ls_DwList[],ls_DwName
String ls_StructureList[], ls_StructureName
String ls_AppList[], ls_applicationname
String ls_functionList[], ls_functionname
String ls_menuList[], ls_menuname



Integer	li_Cycle01,li_Cycle02,li_ImportRtn
Integer	li_LibCount,li_WinCount,li_UserObjCount,li_DwCount,li_StructureCount, li_MenuCount,li_AppCount,li_FunctionCount
long		ll_ObjPos,ll_TabPos

//==========================================================================

is_ProLog = ""
ii_ObjTotalCount = 0
ii_WinTotal = 0
ii_UOTotal = 0
ii_DwTotal = 0
ii_AppCount=0
ii_MenuCount=0
ii_StructureCount=0
ii_FunctionCount=0
ii_FailedCount = 0
ls_AppName = GetApplication().ClassName()
//==========================================================================

if getfolder('',is_dir) = 0 then
	Return
else
	is_dir = is_dir + '\'
end if

ls_Temp = GetLibraryList()

ll_ObjPos = Pos(ls_Temp,",")
do while ll_ObjPos > 0
	li_LibCount++
	ls_LibList[li_LibCount] = Left(ls_Temp,ll_ObjPos - 1)
	ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
	ll_ObjPos = Pos(ls_Temp,",")
loop

li_LibCount++
ls_LibList[li_LibCount] = ls_Temp

//==========================================================================

for li_Cycle01 = 1 to li_LibCount
	
	ls_LibName = ls_LibList[li_Cycle01]

	ls_Temp = LibraryDirectoryEx(ls_LibName,DirMenu!)
	
	li_MenuCount = 0
	ll_ObjPos = Pos(ls_Temp,'~n')
	do while ll_ObjPos > 0
		li_MenuCount++
		ll_TabPos = Pos(ls_Temp,'~t')
		ls_MenuList[li_MenuCount] = Left(ls_Temp,ll_TabPos - 1)
		if ls_MenuList[li_MenuCount] = This.ClassName() then li_MenuCount --
		ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
		ll_ObjPos = Pos(ls_Temp,'~n')
	loop
	
	for li_Cycle02 = 1 to li_MenuCount
		Yield()
		ii_menucount++
		ls_Syntax1 = LibraryExport(ls_LibName,ls_MenuList[li_Cycle02],ExportMenu!)
		wf_write(ls_MenuList[li_Cycle02], ls_syntax1, ".srm")
	next

	ls_Temp = LibraryDirectoryEx(ls_LibName,DirFunction!)
	
	li_FunctionCount = 0
	ll_ObjPos = Pos(ls_Temp,'~n')
	do while ll_ObjPos > 0
		li_FunctionCount++
		ll_TabPos = Pos(ls_Temp,'~t')
		ls_FunctionList[li_FunctionCount] = Left(ls_Temp,ll_TabPos - 1)
		if ls_FunctionList[li_FunctionCount] = This.ClassName() then li_FunctionCount --
		ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
		ll_ObjPos = Pos(ls_Temp,'~n')
	loop
	
	for li_Cycle02 = 1 to li_FunctionCount
		Yield()
		ii_functioncount++
		ls_Syntax1 = LibraryExport(ls_LibName,ls_FunctionList[li_Cycle02],ExportFunction!)
		wf_write(ls_FunctionList[li_Cycle02], ls_syntax1, ".srf")
	next

	ls_Temp = LibraryDirectoryEx(ls_LibName,DirApplication!)
	
	li_AppCount = 0
	ll_ObjPos = Pos(ls_Temp,'~n')
	do while ll_ObjPos > 0
		li_AppCount++
		ll_TabPos = Pos(ls_Temp,'~t')
		ls_AppList[li_AppCount] = Left(ls_Temp,ll_TabPos - 1)
		if ls_AppList[li_AppCount] = This.ClassName() then li_AppCount --
		ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
		ll_ObjPos = Pos(ls_Temp,'~n')
	loop
	
	for li_Cycle02 = 1 to li_AppCount
		Yield()
		ii_Appcount++
		ls_Syntax1 = LibraryExport(ls_LibName,ls_AppList[li_Cycle02],ExportApplication!)
		wf_write(ls_AppList[li_Cycle02], ls_syntax1, ".sra")
	next

	ls_Temp = LibraryDirectoryEx(ls_LibName,DirStructure!)
	
	li_StructureCount = 0
	ll_ObjPos = Pos(ls_Temp,'~n')
	do while ll_ObjPos > 0
		li_StructureCount++
		ll_TabPos = Pos(ls_Temp,'~t')
		ls_StructureList[li_StructureCount] = Left(ls_Temp,ll_TabPos - 1)
		if ls_StructureList[li_StructureCount] = This.ClassName() then li_StructureCount --
		ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
		ll_ObjPos = Pos(ls_Temp,'~n')
	loop
	
	for li_Cycle02 = 1 to li_StructureCount
		Yield()
		ii_StructureCount++
		ls_Syntax1 = LibraryExport(ls_LibName,ls_StructureList[li_Cycle02],ExportStructure!)
		wf_write(ls_StructureList[li_Cycle02], ls_syntax1, ".srs")
	next
	
	ls_Temp = LibraryDirectoryEx(ls_LibName,DirWindow!)
	
	li_WinCount = 0
	ll_ObjPos = Pos(ls_Temp,'~n')
	do while ll_ObjPos > 0
		li_WinCount++
		ll_TabPos = Pos(ls_Temp,'~t')
		ls_WinList[li_WinCount] = Left(ls_Temp,ll_TabPos - 1)
		if ls_WinList[li_WinCount] = This.ClassName() then li_WinCount --
		ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
		ll_ObjPos = Pos(ls_Temp,'~n')
	loop
	
	for li_Cycle02 = 1 to li_WinCount
		Yield()
		ii_WinTotal++
		ls_Syntax1 = LibraryExport(ls_LibName,ls_WinList[li_Cycle02],ExportWindow!)
		wf_write(ls_WinList[li_Cycle02], ls_syntax1, ".srw")
	next
	

	ls_Temp = LibraryDirectoryEx(ls_LibName,DirUserObject!)
	
	li_UserObjCount = 0
	ll_ObjPos = Pos(ls_Temp,'~n')
	do while ll_ObjPos > 0
		li_UserObjCount++
		ll_TabPos = Pos(ls_Temp,'~t')
		ls_UserObjList[li_UserObjCount] = Left(ls_Temp,ll_TabPos - 1)
		ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
		ll_ObjPos = Pos(ls_Temp,'~n')
	loop
	
	for li_Cycle02 = 1 to li_UserObjCount
		Yield()
		ii_UOTotal++
		ls_Syntax1 = LibraryExport(ls_LibName,ls_UserObjList[li_Cycle02],ExportUserObject!)
		wf_write(ls_UserObjList[li_Cycle02], ls_syntax1, ".sru")
	next
	
	ls_Temp = LibraryDirectoryEx(ls_LibName,DirDataWindow!)
	
	li_DwCount = 0
	ll_ObjPos = Pos(ls_Temp,'~n')
	do while ll_ObjPos > 0
		li_DwCount++
		ll_TabPos = Pos(ls_Temp,'~t')
		ls_DwList[li_DwCount] = Left(ls_Temp,ll_TabPos - 1)
		ls_Temp = Mid(ls_Temp,ll_ObjPos + 1)
		ll_ObjPos = Pos(ls_Temp,'~n')
	loop
	
	for li_Cycle02 = 1 to li_DwCount
		Yield()
		ii_DwTotal++
		ls_Syntax1 = LibraryExport(ls_LibName,ls_DwList[li_Cycle02],ExportDataWindow!)
		wf_write(ls_DwList[li_Cycle02], ls_syntax1, ".srd")
	next

next

MessageBox('Information','OK')
end event

type st_2 from statictext within w_batreplace_eng
integer x = 613
integer y = 952
integer width = 489
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event doubleclicked;String	ls_Temp
Integer	li_Cycle

for li_Cycle = 1 to ii_SuccessCount
	ls_Temp += is_SuccessObject[li_Cycle] + "~r~n"
next
ClipBoard(ls_Temp)
MessageBox('Successfully Objects',ls_Temp)


end event

type plb_1 from picturelistbox within w_batreplace_eng
integer x = 5
integer y = 1056
integer width = 1591
integer height = 696
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
string picturename[] = {"Custom038!","Custom009!",""}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 12632256
end type

type cb_3 from commandbutton within w_batreplace_eng
integer x = 1152
integer y = 788
integer width = 338
integer height = 104
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
string text = "E&xit"
end type

event clicked;Halt
end event

type st_6 from statictext within w_batreplace_eng
integer x = 855
integer y = 564
integer width = 430
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Replace With:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_batreplace_eng
integer x = 151
integer y = 564
integer width = 334
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Find What:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_batreplace_eng
integer x = 855
integer y = 632
integer width = 672
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 1090519039
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_batreplace_eng
integer x = 151
integer y = 632
integer width = 672
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 1090519039
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_batreplace_eng
integer x = 64
integer y = 472
integer width = 288
integer height = 64
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Others"
end type

event clicked;wf_setenabled()
end event

type rb_1 from radiobutton within w_batreplace_eng
integer x = 64
integer y = 284
integer width = 512
integer height = 64
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fonts Replace"
boolean checked = true
end type

event clicked;wf_setenabled()
end event

type cbx_3 from checkbox within w_batreplace_eng
integer x = 1015
integer y = 84
integer width = 416
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "DataWindow"
boolean checked = true
end type

type cbx_2 from checkbox within w_batreplace_eng
integer x = 480
integer y = 84
integer width = 416
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "UserObject"
boolean checked = true
end type

type cbx_1 from checkbox within w_batreplace_eng
integer x = 87
integer y = 84
integer width = 379
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Window"
boolean checked = true
end type

type st_4 from statictext within w_batreplace_eng
integer x = 151
integer y = 376
integer width = 430
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Replace With:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_batreplace_eng
integer x = 585
integer y = 364
integer width = 663
integer height = 940
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 1090519039
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"@Fixedsys","@system","@Teminal","Arial","Arial Black","Arial CE","Arial CYR","Arial Greek","Arial Narrow","Arial TUR","AvantGarde","Basemic","Courier","Courier New","Courier New CE","Courier New CYR","Fixedsys","Georgia","Terminal"}
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SelectItem(4)
end event

type cb_2 from commandbutton within w_batreplace_eng
integer x = 640
integer y = 788
integer width = 338
integer height = 104
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
string text = "Open Log"
end type

event clicked;if This.Text = 'Open Log' then
	This.Text = 'Close Log'
	//Parent.Height = ii_ExtendHeight
else
	This.Text = 'Open Log'
	//Parent.Height = ii_OriWinHeight
end if

end event

type st_3 from statictext within w_batreplace_eng
integer x = 1106
integer y = 952
integer width = 489
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event doubleclicked;String	ls_Temp
Integer	li_Cycle

if Pos(This.Text,'failed') > 0 then
	for li_Cycle = 1 to ii_FailedCount
		ls_Temp += is_FailedObject[li_Cycle] + "~r~n"
	next
	ClipBoard(ls_Temp)
	MessageBox('Fialed Objects',ls_Temp)	
end if

end event

type st_1 from statictext within w_batreplace_eng
integer x = 5
integer y = 952
integer width = 603
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_batreplace_eng
integer x = 128
integer y = 788
integer width = 338
integer height = 104
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Start"
end type

event clicked;String ls_WinScr,ls_WinDes,ls_UOScr,ls_UODes,ls_DwScr,ls_DwDes
String	ls_FaceName,ls_Scr,ls_Des

if rb_1.Checked then
	ls_FaceName = Trim(ddlb_1.Text)
	
	ls_WinScr = 'string facename = "*"'
	ls_WinDes = 'string facename = "' + ls_FaceName + '"'
	
	ls_UOScr = ls_WinScr
	ls_UODes = ls_WinDes
	
	ls_DwScr = 'font.face="*"'
	ls_DwDes = 'font.face="' + ls_FaceName + '"'
else
	ls_Scr = Trim(sle_1.Text)
	ls_Des = Trim(sle_2.Text)
	
	if ls_Scr = ls_Des then return
	
	ls_WinScr = ls_Scr
	ls_WinDes = ls_Des
	
	ls_UOScr = ls_Scr
	ls_UODes = ls_Des
	
	ls_DwScr = ls_Scr
	ls_DwDes = ls_Des
end if

This.Text = "Replacing"
This.Enabled = false
plb_1.Reset()
st_2.Alignment = Center!
wf_StringReplace(ls_WinScr,ls_WinDes,ls_UOScr,ls_UODes,ls_DwScr,ls_DwDes)
This.Text = "Start"
This.Enabled = true
st_2.Alignment = Left!

end event

type gb_1 from groupbox within w_batreplace_eng
integer x = 32
integer width = 1541
integer height = 196
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Replaced Objects"
end type

type gb_2 from groupbox within w_batreplace_eng
integer x = 32
integer y = 212
integer width = 1541
integer height = 544
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Replaced Contents"
end type

type st_7 from statictext within w_batreplace_eng
integer x = 119
integer y = 780
integer width = 352
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within w_batreplace_eng
integer x = 631
integer y = 780
integer width = 352
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ln_1 from line within w_batreplace_eng
long linecolor = 8421504
integer linethickness = 5
integer beginx = 32
integer beginy = 912
integer endx = 1577
integer endy = 912
end type

type ln_2 from line within w_batreplace_eng
long linecolor = 16777215
integer linethickness = 5
integer beginx = 32
integer beginy = 916
integer endx = 1577
integer endy = 916
end type

type st_9 from statictext within w_batreplace_eng
integer x = 1143
integer y = 780
integer width = 352
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

