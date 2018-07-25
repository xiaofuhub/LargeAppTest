$PBExportHeader$w_utl_set_regedit_path.srw
forward
global type w_utl_set_regedit_path from window
end type
type st_1 from statictext within w_utl_set_regedit_path
end type
type sle_1 from singlelineedit within w_utl_set_regedit_path
end type
type cb_run from commandbutton within w_utl_set_regedit_path
end type
type cb_4 from commandbutton within w_utl_set_regedit_path
end type
type cb_3 from commandbutton within w_utl_set_regedit_path
end type
end forward

global type w_utl_set_regedit_path from window
integer x = 123
integer y = 112
integer width = 2139
integer height = 544
boolean titlebar = true
string title = "Set Registry Path"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
boolean center = true
st_1 st_1
sle_1 sle_1
cb_run cb_run
cb_4 cb_4
cb_3 cb_3
end type
global w_utl_set_regedit_path w_utl_set_regedit_path

type variables
long il_openfor
end variables

on w_utl_set_regedit_path.create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_run=create cb_run
this.cb_4=create cb_4
this.cb_3=create cb_3
this.Control[]={this.st_1,&
this.sle_1,&
this.cb_run,&
this.cb_4,&
this.cb_3}
end on

on w_utl_set_regedit_path.destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_run)
destroy(this.cb_4)
destroy(this.cb_3)
end on

event open;long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows

if message.stringparm = "P" then  //from the intellicred program
	//skip login
	il_openfor = 0
else

	il_openfor = 1
	
end if

end event

event close;//if il_openfor = 1 then
//	disCONNECT USING SQLCA;
//end if
end event

type st_1 from statictext within w_utl_set_regedit_path
integer x = 50
integer y = 56
integer width = 1362
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Enter Path IntelliCred folder is installed on like (C:\)"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_utl_set_regedit_path
integer x = 37
integer y = 156
integer width = 2011
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "C:\"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_run from commandbutton within w_utl_set_regedit_path
integer x = 690
integer y = 292
integer width = 1047
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Set IntelliCred/App Path Registry key "
end type

event clicked;string spath
integer res

spath = sle_1.text

if LenA(spath) < 1 then
	messagebox("","Enter Path")
	return
end if
if MidA(spath,LenA(spath),1) <> "\" then
		messagebox("","Path must end in a backslash (\)")
	return
end if

if not fileexists(spath + "intellicred\intellicred.exe") then
	res = messagebox(spath + "intellicred\intellicred.exe","The entered path is not valid for the IntelliCred/App program.  Do you wish to set  the key anyway?", Question!,yesno!,2)
	if res = 2 then
		return
	end if
	
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 04.13.2006 By: Cao YongWang
//$<reason> RegistrySet is currently unsupported.
//$<modification> Use Appeon defined function of_RegistrySet to provide the same functionality when IntelliCred
//$<modification> is running on the Web.
/*
RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\intellicred\", "installpath", RegString!, spath )
*/
If appeongetclienttype() = 'PB' Then
	RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\intellicred\", "installpath", RegString!, spath )
Else
	gnv_appeondll.of_RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\intellicred\", "installpath", RegString!, spath )
End If
//---------------------------- APPEON END ----------------------------

messagebox("Done"," Update Completed")






end event

type cb_4 from commandbutton within w_utl_set_regedit_path
integer x = 2199
integer y = 108
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;//if dw_1.rowcount() < 1 then
//	messagebox("","nothing to print")
//	return
//end if
//
//dw_1.print()
end event

type cb_3 from commandbutton within w_utl_set_regedit_path
integer x = 1765
integer y = 292
integer width = 274
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CLOSE(PARENT)
end event

