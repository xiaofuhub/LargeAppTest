$PBExportHeader$w_recred_help.srw
forward
global type w_recred_help from window
end type
type uo_2 from uo_dm_image_view_cp_help within w_recred_help
end type
type rb_4 from radiobutton within w_recred_help
end type
type cb_1 from commandbutton within w_recred_help
end type
type rb_3 from radiobutton within w_recred_help
end type
type rb_2 from radiobutton within w_recred_help
end type
type rb_1 from radiobutton within w_recred_help
end type
type gb_1 from groupbox within w_recred_help
end type
end forward

global type w_recred_help from window
integer width = 4923
integer height = 2388
boolean titlebar = true
string title = "Recredentialing Help"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
uo_2 uo_2
rb_4 rb_4
cb_1 cb_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
end type
global w_recred_help w_recred_help

type variables
string is_path
end variables

forward prototypes
public function integer of_go (string as_file)
end prototypes

public function integer of_go (string as_file);String ls_open = ''
String ls_file_name = ''

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.07.2016
//<$>reason:Download help document for Web version, BugL120401.
ls_open = as_file

//Download help files for web version
If not fileexists(ls_open) then //look for a default file on the intellicred root
	if AppeonGetClientType() = "WEB" then
		n_appeon_download lnv_appeon

		if lnv_appeon.of_downloadpdfhelp(ls_open) = -1 then
			MessageBox("Download Data Source", "Failed to download '" + ls_open + "' file. Please contact the system administrator.")
			Return -1
		end if
	Else //PB developer	
		ls_file_name = MidA(ls_open, LastPos(as_file, '\') + 1)
		ls_open = Gs_Current_Directory + "\Help\" + 	ls_file_name
	end if
end if

if not fileexists(ls_open) then
	messagebox(ls_open , "This help file does not exist; unable to display")
else
	//ole_browser.object.navigate(ls_open)
	uo_2.of_initialize(ls_open,'pdf')
	uo_2.SetRedraw(False)
	
	uo_2.event ue_load_image(ls_open)
	uo_2.of_set_zoom(100)
	
	uo_2.of_set_readonly(true) 
	uo_2.SetRedraw(True)	
end if
//------------------- APPEON END -------------------

return 1
end function

on w_recred_help.create
this.uo_2=create uo_2
this.rb_4=create rb_4
this.cb_1=create cb_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.Control[]={this.uo_2,&
this.rb_4,&
this.cb_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.gb_1}
end on

on w_recred_help.destroy
destroy(this.uo_2)
destroy(this.rb_4)
destroy(this.cb_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
end on

event open;string ls_path

//is_path = gs_dir_path + "Help\"
is_path = gs_temp_path + "Help\"//Modified by Appeon long.zhang 12.22.2015 (BugL120401)


//ls_path = is_path + "Reappointment help general.htm"
ls_path = is_path + "Reappointment help general.pdf" //Modified by Appeon long.zhang 01.07.2016 (BugL120401)

of_go(ls_path)
end event

event resize;//Added by Appeon long.zhang 01.07.2016 (BugL120401)
uo_2.width = this.width - 140
uo_2.height = this.height - 270

uo_2.uo_toolbar.st_status.visible = False
end event

type uo_2 from uo_dm_image_view_cp_help within w_recred_help
integer x = 69
integer y = 200
integer width = 4795
integer height = 2060
integer taborder = 80
end type

on uo_2.destroy
call uo_dm_image_view_cp_help::destroy
end on

type rb_4 from radiobutton within w_recred_help
integer x = 1184
integer y = 96
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Workflow"
end type

event clicked;string ls_path

//ls_path = is_path + "Reappointment help workflow.htm"
ls_path = is_path + "Reappointment help workflow.pdf"//Modified by Appeon long.zhang 01.07.2016 (BugL120401)

of_go(ls_path)
end event

type cb_1 from commandbutton within w_recred_help
integer x = 4503
integer y = 68
integer width = 343
integer height = 92
integer taborder = 20
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

type rb_3 from radiobutton within w_recred_help
integer x = 850
integer y = 96
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Initiate"
end type

event clicked;string ls_path

//ls_path = is_path + "Reappointment help initiate.htm"
ls_path = is_path + "Reappointment help initiate.pdf" //Modified by Appeon long.zhang 01.07.2016 (BugL120401)

of_go(ls_path)
end event

type rb_2 from radiobutton within w_recred_help
integer x = 485
integer y = 92
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Setup"
end type

event clicked;string ls_path

//ls_path = is_path + "Reappointment help settings.htm"
ls_path = is_path + "Reappointment help settings.pdf" //Modified by Appeon long.zhang 01.07.2016 (BugL120401)

//messagebox("",ls_path)
of_go(ls_path)
end event

type rb_1 from radiobutton within w_recred_help
integer x = 133
integer y = 92
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "General"
boolean checked = true
end type

event clicked;string ls_path

//ls_path = is_path + "Reappointment help general.htm" 
ls_path = is_path + "Reappointment help general.pdf"  //Modified by Appeon long.zhang 01.07.2016 (BugL120401)

of_go(ls_path)
end event

type gb_1 from groupbox within w_recred_help
integer x = 46
integer y = 24
integer width = 1545
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Recred Help"
end type

