$PBExportHeader$w_update_files.srw
forward
global type w_update_files from window
end type
type st_3 from statictext within w_update_files
end type
type st_2 from statictext within w_update_files
end type
type cb_3 from commandbutton within w_update_files
end type
type st_1 from statictext within w_update_files
end type
type sle_path from singlelineedit within w_update_files
end type
type cb_2 from commandbutton within w_update_files
end type
end forward

global type w_update_files from window
integer x = 617
integer y = 576
integer width = 2418
integer height = 1468
boolean titlebar = true
string title = "IntelliCred Update"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_3 st_3
st_2 st_2
cb_3 cb_3
st_1 st_1
sle_path sle_path
cb_2 cb_2
end type
global w_update_files w_update_files

on w_update_files.create
this.st_3=create st_3
this.st_2=create st_2
this.cb_3=create cb_3
this.st_1=create st_1
this.sle_path=create sle_path
this.cb_2=create cb_2
this.Control[]={this.st_3,&
this.st_2,&
this.cb_3,&
this.st_1,&
this.sle_path,&
this.cb_2}
end on

on w_update_files.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.sle_path)
destroy(this.cb_2)
end on

event open;String ls_path

ls_path = ProfileString (gs_IniFilePathName , "setup", "updatepath", "None" )

sle_path.Text = ls_path
end event

type st_3 from statictext within w_update_files
integer x = 119
integer y = 544
integer width = 2057
integer height = 128
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "To copy the update files from the network to your PC click on the Update IntelliCred Button"
boolean focusrectangle = false
end type

type st_2 from statictext within w_update_files
integer x = 110
integer y = 224
integer width = 247
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Path:"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_update_files
integer x = 1883
integer y = 288
integer width = 361
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Browse . . ."
end type

event clicked;string docname, named
integer value
Integer li_cnt

value = GetFileOpenName("Select File",&
+ docname, named, "EXE", &
	+ "All Files (*.*), *.*")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

li_cnt=0
DO WHILE TRUE
	li_cnt++
	IF MidA( docname, LenA( docname ), 1) = "\" THEN
		EXIT
	ELSE
		docname = MidA( docname, 1, LenA( docname ) -1) 
	END IF
LOOP

IF value = 1 THEN
	docname = docname
	sle_path.Text = docname
END IF



IF RightA( sle_path.Text, 1 ) <> "\" THEN
	sle_path.Text = sle_path.Text + "\"
END IF
SetProfileString (gs_IniFilePathName, "setup", "updatepath", sle_path.Text )


MessageBox("Update Path", "The path has been updated.")
end event

type st_1 from statictext within w_update_files
integer x = 105
integer y = 48
integer width = 2066
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "To set the path on the network where the update files are located, click the Browse button and navigate to the directory where the files reside and select one of the update files."
boolean focusrectangle = false
end type

type sle_path from singlelineedit within w_update_files
integer x = 105
integer y = 292
integer width = 1751
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_update_files
integer x = 105
integer y = 692
integer width = 2107
integer height = 532
integer taborder = 30
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update IntelliCred"
end type

event clicked;String ls_path
Integer li_file_num

ls_path = ProfileString (gs_IniFilePathName , "setup", "updatepath", "None" )
IF ls_path = "None" THEN
	MessageBox("Invalid Path", "The update path is not set.   To set the path type the path where the update files reside into the edit box and click the Set Update Path button.")
	Return
END IF

//li_file_num = FileOpen( "c:\copyfiles.bat", LineMode!, Write!, LockWrite!,Replace! )
//FileWrite( li_file_num, "del c:\intellicred\intellicred.exe"  )
//FileWrite( li_file_num, "del c:\intellicred\*.pbd" )
//FileWrite( li_file_num, "copy source " + ls_path + " *.exe destination c:\intellicred\" )
//FileWrite( li_file_num, "copy " + ls_path + "*.pbd to c:\intellicred\" )
//FileClose( li_file_num )

//li_file_num = FileOpen( "c:\copyfiles.bat", LineMode!, Write!, LockWrite!,Replace! )
//FileWrite( li_file_num, "del c:\intellicred\intellicred.exe"  )
//FileWrite( li_file_num, "del c:\intellicred\*.pbd" )
//FileWrite( li_file_num, "copy " + ls_path + "*.* c:\intellicred\" )
//FileWrite( li_file_num, "copy " + ls_path + "*.* c:\intellicred\" )
//FileClose( li_file_num )

Run( "xcopy " + ls_path + "intellicred.exe " + gs_dir_path + "IntelliCred\", Maximized! )

//Run( "c:\copyfiles.bat" )


MessageBox("Update", " Update complete" )

Close( Parent )
end event

