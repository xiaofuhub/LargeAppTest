$PBExportHeader$w_client_setting.srw
forward
global type w_client_setting from window
end type
type cb_help from commandbutton within w_client_setting
end type
type cb_clean from commandbutton within w_client_setting
end type
type cb_close from commandbutton within w_client_setting
end type
type cb_save from commandbutton within w_client_setting
end type
type st_dirpath from statictext within w_client_setting
end type
type sle_dirpath from singlelineedit within w_client_setting
end type
type cb_dirpath from commandbutton within w_client_setting
end type
type st_1 from statictext within w_client_setting
end type
type st_2 from statictext within w_client_setting
end type
type em_days from editmask within w_client_setting
end type
type em_lastclrdate from editmask within w_client_setting
end type
type st_3 from statictext within w_client_setting
end type
type gb_1 from groupbox within w_client_setting
end type
type gb_2 from groupbox within w_client_setting
end type
end forward

global type w_client_setting from window
integer width = 2258
integer height = 724
boolean titlebar = true
string title = "Temporary Files Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_help cb_help
cb_clean cb_clean
cb_close cb_close
cb_save cb_save
st_dirpath st_dirpath
sle_dirpath sle_dirpath
cb_dirpath cb_dirpath
st_1 st_1
st_2 st_2
em_days em_days
em_lastclrdate em_lastclrdate
st_3 st_3
gb_1 gb_1
gb_2 gb_2
end type
global w_client_setting w_client_setting

on w_client_setting.create
this.cb_help=create cb_help
this.cb_clean=create cb_clean
this.cb_close=create cb_close
this.cb_save=create cb_save
this.st_dirpath=create st_dirpath
this.sle_dirpath=create sle_dirpath
this.cb_dirpath=create cb_dirpath
this.st_1=create st_1
this.st_2=create st_2
this.em_days=create em_days
this.em_lastclrdate=create em_lastclrdate
this.st_3=create st_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_help,&
this.cb_clean,&
this.cb_close,&
this.cb_save,&
this.st_dirpath,&
this.sle_dirpath,&
this.cb_dirpath,&
this.st_1,&
this.st_2,&
this.em_days,&
this.em_lastclrdate,&
this.st_3,&
this.gb_1,&
this.gb_2}
end on

on w_client_setting.destroy
destroy(this.cb_help)
destroy(this.cb_clean)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.st_dirpath)
destroy(this.sle_dirpath)
destroy(this.cb_dirpath)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_days)
destroy(this.em_lastclrdate)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-06 By: Scofield
//$<Reason> Add the directory path set.
Integer	li_IntervalDays
String	ls_LastClrDate,ls_TempDir

ls_TempDir = ProfileString(gs_IniFilePathName,"Paths","Directory_Path","C:\")
//---------Begin Added by (Appeon)Alfee 03.14.2014  ---------------------------------------
//Support the customized temporary path set during installation for Citrix
if gi_citrix = 1 then 
	sle_dirpath.Enabled = False
	cb_dirpath.Enabled = False
	ls_TempDir = ProfileString(gs_IniFilePathName, "Paths", "Directory_Path_Citrix", "")
end if
//---------End Added ----------------------------------------------------------------------------

if IsNull(ls_TempDir) or Trim(ls_TempDir) = '' then ls_TempDir = "C:\"

sle_DirPath.Text = ls_TempDir
sle_DirPath.SelectText(LenA(ls_TempDir) + 1,0)

li_IntervalDays = ProfileInt(gs_IniFilePathName,"Setup","Interval_Days",30)
em_days.Text = String(li_IntervalDays)

ls_LastClrDate = ProfileString(gs_IniFilePathName,"Setup","Last_Clear_Date",String(Today(),"YYYY/MM/DD"))
em_lastclrdate.text = ls_LastClrDate
//---------------------------- APPEON END ----------------------------

end event

type cb_help from commandbutton within w_client_setting
integer x = 1819
integer y = 508
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
end type

event clicked;String	ls_Help

ls_Help  = 'Temporary Directory:~r~nThis option enables users to select any Windows folder as the location of temporary files.  The program will automatically create a sub-folder called "IntelliCred" under that folder.~r~nFor example, if the user inputs "C:\Temp\" here, then the actual location of temporary files is "C:\Temp\IntelliCred\".~r~nThe program must be re-started in order for the change to take effect.~r~n~r~nClean up the temporary files every ## Days:~r~nTo prevent that the temporary files pile up and take up too much disk space, the user can set an interval and the program will automatically clean up the temporary files (not all files, but only those under the Agreement sub-folder) according to that interval. 0 indicates the program never automatically cleans up any files.~r~n~r~nClean at Once:~r~nThis button allows users to remove the temporary files, but currently it only cleans up the files under the Agreement sub-folder, because the program may be affected if all temporary files are removed at once.~r~n'

MessageBox(gnv_app.iapp_object.DisplayName,ls_Help)

end event

type cb_clean from commandbutton within w_client_setting
integer x = 1829
integer y = 336
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clean &Now"
end type

event clicked;long		ll_Rtn
String	ls_TempDir,ls_LastClrDate

n_cst_filesrv inv_filesrv

ll_Rtn = MessageBox('Confirm Files Clean','Are you sure you want to clean the temporary files?',Question!,YesNo!)
if ll_Rtn <> 1 then return

f_SetFileSrv(inv_filesrv,TRUE)

ls_TempDir = gs_dir_path + "intellicred\Agreement"
inv_filesrv.of_deltree(ls_TempDir)

Destroy inv_filesrv

if DirectoryExists(ls_TempDir) then
	MessageBox(gnv_app.iapp_object.DisplayName,"Failed to clean temporary files!",Exclamation!)
else
	ls_LastClrDate = String(Today(),"YYYY/MM/DD")
	SetProfileString(gs_IniFilePathName,"Setup","Last_Clear_Date",ls_LastClrDate)
	em_lastclrdate.Text = ls_LastClrDate
	
	MessageBox(gnv_app.iapp_object.DisplayName,"Temporary files were cleaned successfully!")
end if

end event

type cb_close from commandbutton within w_client_setting
integer x = 1449
integer y = 508
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)

end event

type cb_save from commandbutton within w_client_setting
integer x = 1079
integer y = 508
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;String	ls_TempDir
String	ls_IntervalDays,ls_LastClrDate

//Verify the directory if exists
ls_TempDir = Trim(sle_DirPath.Text)
//---------Begin Modified by (Appeon)Harry 02.14.2014 for Bug # 3863--------
/*
if Not DirectoryExists(ls_TempDir) then
	MessageBox(gnv_app.iapp_object.DisplayName, "'" + ls_TempDir + "' does not exist.  Please select an existing directory.",Exclamation!)
	return
end if
*/
//Support %APPDATA" - jervis 09.15.2010
if Pos(Upper(ls_TempDir),"%APPDATA%") > 0 then
	ulong lul_chars 
	string ls_var ,ls_path
	n_cst_string lnv_string
	
	ls_var = "APPDATA"
	ls_path = Space( 1024 )
	lul_chars = GetEnvironmentVariableA( ls_var, ls_path, 1024 )
	ls_TempDir = lnv_string.of_globalreplace( ls_TempDir,"%APPDATA%",ls_path,true)
end if

if Not DirectoryExists(ls_TempDir) then
	MessageBox(gnv_app.iapp_object.DisplayName, "'" + ls_TempDir + "' is not exist,Please select an existing directory.",Exclamation!)
	return
else //User original path - jervis 09.15.2010
	ls_TempDir = Trim(sle_DirPath.Text)
end if
//---------End Modfiied ------------------------------------------------------

//Set the temporary directory
SetProfileString(gs_IniFilePathName,"Paths","Directory_Path",ls_TempDir)
if gi_citrix = 1 then SetProfileString(gs_IniFilePathName,"Paths","Directory_Path_Citrix",ls_TempDir) //Alfee 03.14.2014

//Set the Interval Days
ls_IntervalDays = em_days.Text
SetProfileString(gs_IniFilePathName,"Setup","Interval_Days",ls_IntervalDays)

//Set the Last Clear Date
ls_LastClrDate = em_lastclrdate.text
SetProfileString(gs_IniFilePathName,"Setup","Last_Clear_Date",ls_LastClrDate)

end event

type st_dirpath from statictext within w_client_setting
integer x = 50
integer y = 112
integer width = 489
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Temporary Directory:"
boolean focusrectangle = false
end type

type sle_dirpath from singlelineedit within w_client_setting
integer x = 549
integer y = 100
integer width = 1253
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_dirpath from commandbutton within w_client_setting
integer x = 1819
integer y = 96
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Browse"
end type

event clicked;/******************************************************************************************************************
**  [PUBLIC]   : event CLICKED!
**==================================================================================================================
**  Purpose   	: Gets the directory path from the ini file,sets the directory path
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Scofield
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_path 

ls_path =  f_browseforfolder('Please select a directory' ,handle(parent))

if f_validstr(ls_path)  then
	if RightA(ls_path,1) <> "\" then
		ls_path += "\"
	end if	
	sle_dirpath.text = ls_path
end if

end event

type st_1 from statictext within w_client_setting
integer x = 997
integer y = 352
integer width = 151
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Days."
boolean focusrectangle = false
end type

type st_2 from statictext within w_client_setting
integer x = 50
integer y = 352
integer width = 809
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Clean up the temporary files every"
boolean focusrectangle = false
end type

type em_days from editmask within w_client_setting
integer x = 859
integer y = 336
integer width = 137
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#####"
double increment = 1
string minmax = "0~~99999"
end type

type em_lastclrdate from editmask within w_client_setting
integer x = 1536
integer y = 352
integer width = 293
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean border = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYY/MM/DD"
end type

type st_3 from statictext within w_client_setting
integer x = 1152
integer y = 352
integer width = 384
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Last Clean Date:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_client_setting
integer x = 37
integer y = 24
integer width = 2171
integer height = 212
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type gb_2 from groupbox within w_client_setting
integer x = 37
integer y = 256
integer width = 2171
integer height = 212
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

