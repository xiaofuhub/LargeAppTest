$PBExportHeader$w_dbconnect_info.srw
forward
global type w_dbconnect_info from window
end type
type st_path from statictext within w_dbconnect_info
end type
type cb_find from commandbutton within w_dbconnect_info
end type
type st_2 from statictext within w_dbconnect_info
end type
type st_1 from statictext within w_dbconnect_info
end type
type em_pw from editmask within w_dbconnect_info
end type
type em_log from editmask within w_dbconnect_info
end type
type cb_quit from commandbutton within w_dbconnect_info
end type
type cb_ok from commandbutton within w_dbconnect_info
end type
end forward

global type w_dbconnect_info from window
integer width = 1157
integer height = 960
boolean titlebar = true
string title = "Database Connection Info for SQL Server"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_path st_path
cb_find cb_find
st_2 st_2
st_1 st_1
em_pw em_pw
em_log em_log
cb_quit cb_quit
cb_ok cb_ok
end type
global w_dbconnect_info w_dbconnect_info

type variables
string is_path
n_cst_encrypt invo_encrypt 


end variables

on w_dbconnect_info.create
this.st_path=create st_path
this.cb_find=create cb_find
this.st_2=create st_2
this.st_1=create st_1
this.em_pw=create em_pw
this.em_log=create em_log
this.cb_quit=create cb_quit
this.cb_ok=create cb_ok
this.Control[]={this.st_path,&
this.cb_find,&
this.st_2,&
this.st_1,&
this.em_pw,&
this.em_log,&
this.cb_quit,&
this.cb_ok}
end on

on w_dbconnect_info.destroy
destroy(this.st_path)
destroy(this.cb_find)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_pw)
destroy(this.em_log)
destroy(this.cb_quit)
destroy(this.cb_ok)
end on

event open;//is_path = "C:\intellicred\intellicred.ini"
is_path = gs_IniFilePathName		//Modified by scofield on 2007-08-06

if not fileexists(is_path ) then
	cb_find.visible = true
end if

end event

type st_path from statictext within w_dbconnect_info
integer x = 55
integer y = 556
integer width = 1001
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_find from commandbutton within w_dbconnect_info
boolean visible = false
integer x = 146
integer y = 40
integer width = 805
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find location of IntelliCred folder"
end type

event clicked;string docpath, docname[]

integer i, li_cnt, li_rtn, li_filenum

 

li_rtn = GetFileOpenName("Select Location of intellicred.ini file",    docpath, docname[], "INI",  + "Config Files (*.INI),*.INI",    "C:\", 18)
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
is_path = docpath

st_path.text = is_path
end event

type st_2 from statictext within w_dbconnect_info
integer x = 197
integer y = 364
integer width = 320
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Password"
boolean focusrectangle = false
end type

type st_1 from statictext within w_dbconnect_info
integer x = 192
integer y = 156
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "User Login"
boolean focusrectangle = false
end type

type em_pw from editmask within w_dbconnect_info
integer x = 201
integer y = 432
integer width = 713
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type em_log from editmask within w_dbconnect_info
integer x = 197
integer y = 220
integer width = 713
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type cb_quit from commandbutton within w_dbconnect_info
integer x = 571
integer y = 668
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_dbconnect_info
integer x = 201
integer y = 668
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;integer i
//string ls_path
string ls_data[]

debugbreak()
ls_data[1] = "isoft"
ls_data[2] = em_log.text 
ls_data[3] = "!!!"
ls_data[4] = em_pw.text

ls_data[2]  = invo_encrypt.of_encrypt(ls_data[1] + "@@@" + ls_data[2]  )
ls_data[4]  = invo_encrypt.of_encrypt(ls_data[1] + "@@@" + ls_data[4]  )		

ls_data[5] = ls_data[1] + ls_data[2] + ls_data[3] + ls_data[4]

//messagebox("",ls_data[5])
 i = SetProfileString(is_path , "Setup", "dbconndata", ls_data[5])

close(parent)











end event

