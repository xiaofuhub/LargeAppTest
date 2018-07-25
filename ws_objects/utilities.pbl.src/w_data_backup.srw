$PBExportHeader$w_data_backup.srw
forward
global type w_data_backup from window
end type
type st_5 from statictext within w_data_backup
end type
type cbx_1 from checkbox within w_data_backup
end type
type st_4 from statictext within w_data_backup
end type
type st_3 from statictext within w_data_backup
end type
type st_2 from statictext within w_data_backup
end type
type cb_3 from commandbutton within w_data_backup
end type
type cb_2 from commandbutton within w_data_backup
end type
type st_1 from statictext within w_data_backup
end type
type sle_1 from singlelineedit within w_data_backup
end type
type cb_1 from commandbutton within w_data_backup
end type
type gb_1 from groupbox within w_data_backup
end type
end forward

global type w_data_backup from window
integer x = 823
integer y = 360
integer width = 2510
integer height = 1036
boolean titlebar = true
string title = "Sybase Database Backup Utility"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
st_5 st_5
cbx_1 cbx_1
st_4 st_4
st_3 st_3
st_2 st_2
cb_3 cb_3
cb_2 cb_2
st_1 st_1
sle_1 sle_1
cb_1 cb_1
gb_1 gb_1
end type
global w_data_backup w_data_backup

on w_data_backup.create
this.st_5=create st_5
this.cbx_1=create cbx_1
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={this.st_5,&
this.cbx_1,&
this.st_4,&
this.st_3,&
this.st_2,&
this.cb_3,&
this.cb_2,&
this.st_1,&
this.sle_1,&
this.cb_1,&
this.gb_1}
end on

on w_data_backup.destroy
destroy(this.st_5)
destroy(this.cbx_1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.gb_1)
end on

type st_5 from statictext within w_data_backup
integer x = 46
integer y = 756
integer width = 2354
integer height = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "You can set the program to automatically backup at the first login of the day from Utilities Application settings."
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_data_backup
integer x = 41
integer y = 236
integer width = 782
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Save as new default path"
end type

type st_4 from statictext within w_data_backup
integer x = 55
integer y = 376
integer width = 2309
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
string text = "When entering the path, all backslashes (\) must be doubled as in F:\\data\\backup."
boolean focusrectangle = false
end type

type st_3 from statictext within w_data_backup
integer x = 55
integer y = 640
integer width = 2322
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Network users: check with your network administrator as to where to store the backup."
boolean focusrectangle = false
end type

type st_2 from statictext within w_data_backup
integer x = 55
integer y = 472
integer width = 2373
integer height = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "The backup path mapping is RELATIVE TO THE COMPUTER ON WHICH THE DATABASE IS RUNNING, not necessarily the user~'s machine.  If the specified directory does not exist, it will be created."
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_data_backup
integer x = 1929
integer y = 36
integer width = 521
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_data_backup
integer x = 1381
integer y = 36
integer width = 521
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Use Default Path"
end type

event clicked;string path

select database_backup_path into :path from ids;

if isnull(path) then
	sle_1.text = gs_dir_path + "\intellicred\\databasebackup"
else
	sle_1.text = path
end if







end event

type st_1 from statictext within w_data_backup
integer x = 41
integer y = 64
integer width = 375
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Backup Path:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_data_backup
integer x = 41
integer y = 136
integer width = 2409
integer height = 92
integer taborder = 40
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

type cb_1 from commandbutton within w_data_backup
integer x = 832
integer y = 36
integer width = 526
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Backup Database"
end type

event clicked;//This will backup the database and log file to the specified SERVER directory and create the directory if it doesn't exist

string ls_path
string ls_state

ls_path = sle_1.text

if isnull(ls_path) or ls_path = "" then 
	messagebox("","Please enter backup path.")
	return
end if

ls_state = "BACKUP DATABASE DIRECTORY " + "'" + ls_path + "'" + ";"

//messagebox("",ls_state)
execute immediate :ls_state using sqlca;

IF SQLCA.SQLCode = -1 THEN //maha app102405  trap for invalid path
        MessageBox("SQL error", SQLCA.SQLErrText)
END IF

if cbx_1.checked = true then
	update ids set database_backup_path = :ls_path;
end if


messagebox("","Backup completed")
end event

type gb_1 from groupbox within w_data_backup
integer x = 27
integer y = 320
integer width = 2427
integer height = 584
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
borderstyle borderstyle = styleraised!
end type

