$PBExportHeader$w_currentobject.srw
forward
global type w_currentobject from window
end type
end forward

global type w_currentobject from window
boolean visible = false
integer width = 1454
integer height = 788
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
end type
global w_currentobject w_currentobject

type variables
String	is_AppPath
String	is_PBTName = "app_filler.pbt"

end variables

on w_currentobject.create
end on

on w_currentobject.destroy
end on

event open;if AppeonGetClientType() = "PB" then
	Timer(10)
else
	Close(This)
end if

end event

event timer;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-03-05 By: Scofield
//$<Reason> Convenience the coder to open object

String				ls_Temp,ls_DaObj,ls_LibPath,ls_LibList,ls_LibFile,ls_DataInfo
String				ls_WinName,ls_MenuName,ls_UserObjInfo
Integer				li_Rtn
long					ll_Pos
Boolean				lb_IsUserObj = false
GraphicObject 		lgo_Obj,lgo_Temp,lgo_UserObj
ClassDefinition	lcd_Temp,lcd_ClassDef
DataWindow			ldw_Obj
Window 				lw_Win

String ls_PBTKey = "HKEY_CURRENT_USER\Software\Sybase\PowerBuilder\9.0\Target\"

lgo_Obj = GetFocus()
if Not IsValid(lgo_Obj) then
	MessageBox('Information','Current Object is not valid!')
	return
end if

Timer(0)

if Trim(is_AppPath) = "" then
	is_AppPath = Trim(Gs_Current_Directory)
	if RightA(is_AppPath,1) <> "\" then is_AppPath += "\"
	
	ll_Pos = PosA(is_AppPath,"\")
	do while ll_Pos > 0
		is_AppPath = ReplaceA(is_AppPath,ll_Pos,1,"$")
		ll_Pos = PosA(is_AppPath,"\")
	loop
	
	is_AppPath += is_PBTName
end if

////////////////////////////Find Parent Object/////////////////////////////////////
lgo_Temp = lgo_Obj

do while IsValid(lgo_Temp) and TypeOf(lgo_Temp) <> Window!
	if TypeOf(lgo_Temp) = userobject! and Not lb_IsUserObj then
		lb_IsUserObj = true
		lgo_UserObj = lgo_Temp
	end if
	
	if TypeOf(lgo_Temp) = datawindow! then
		ldw_Obj = lgo_Temp
		ls_DaObj = ldw_Obj.DataObject
		
		if Trim(ls_Temp) = "" then
			ls_Temp = lgo_Temp.ClassName() + "(" + ls_DaObj + ")"
		else
			ls_Temp = lgo_Temp.ClassName() + "(" + ls_DaObj + ")" + "." + ls_Temp
		end if
		
		ls_LibList = GetLibraryList() + ","
		ll_Pos = PosA(ls_LibList,",")
		do while ll_Pos > 0
			ls_LibFile = LeftA(ls_LibList,ll_Pos - 1)
			ls_LibList = MidA(ls_LibList,ll_Pos + 1)
			ll_Pos = PosA(ls_LibList,",")
			
			ls_DataInfo = "~n" + LibraryDirectory(ls_LibFile, DirDataWindow!)
			
			if PosA(ls_DataInfo,"~n" + ls_DaObj + "~t") > 0 then
				if PosA(ls_LibPath,ls_LibFile) <= 0 then
					ls_LibPath += ls_LibFile + ";"
				end if
				Exit
			end if
		loop
	else
		if Trim(ls_Temp) = "" then
			ls_Temp = lgo_Temp.ClassName()
		else
			ls_Temp = lgo_Temp.ClassName() + "." + ls_Temp
		end if
	end if
	
	lgo_Temp = lgo_Temp.GetParent()
loop

if Not IsValid(lgo_Temp) then
	MessageBox('Information',ls_Temp)
	return
end if

if TypeOf(lgo_Temp) = Window! then
	lw_Win = lgo_Temp
	ls_WinName = lw_Win.ClassName()
	lcd_ClassDef = FindClassDefinition(ls_WinName)
	
	if PosA(ls_LibPath,lcd_ClassDef.LibraryName) <= 0 then
		ls_LibPath += lcd_ClassDef.LibraryName + ";"
	end if
	
	if IsNull(lw_Win.MenuName) or Trim(lw_Win.MenuName) = "" then
		ls_MenuName = "MdiMenu: " + w_mdi.MenuName
	else
		ls_MenuName = "WinMenu: " + lw_Win.MenuName
	end if
	
	ls_Temp = ls_MenuName + "~n~n" + ls_WinName + "." + ls_Temp
end if

/////////////////////////////UserObject trace to//////////////////////////////////////

if lb_IsUserObj and IsValid(lgo_UserObj) then
	ls_UserObjInfo += "~n~n"
	lgo_Temp = lgo_UserObj
	
	ls_UserObjInfo += lgo_Temp.ClassName()
	
	lcd_Temp = lgo_Temp.ClassDefinition
	lcd_Temp = lcd_Temp.Ancestor
	
	do while IsValid(lcd_Temp) and lower(lcd_Temp.Name) <> 'userobject'
		ls_UserObjInfo += "---->" + lcd_Temp.Name
		
		if PosA(ls_LibPath,lcd_Temp.LibraryName) <= 0 then
			ls_LibPath += lcd_Temp.LibraryName + ";"
		end if
		
		lcd_Temp = lcd_Temp.Ancestor
	loop
	
	if PosA(ls_UserObjInfo,"---->") > 0 then ls_Temp += ls_UserObjInfo
end if
////////////////////////////////////////////////////////////////////////////

RegistrySet(ls_PBTKey + is_AppPath,"DefLibList",RegString!,ls_LibPath)

ls_Temp += "~n~nContinue ?"
li_Rtn = MessageBox('Object List',ls_Temp,Question!,YesNoCancel!,2)

if li_Rtn = 1 then
	Timer(5)
elseif li_Rtn = 2 then
	Close(this)
elseif li_Rtn = 3 then
	Halt Close
end if
//---------------------------- APPEON END ----------------------------

end event

