$PBExportHeader$w_scan_for_tifs.srw
forward
global type w_scan_for_tifs from window
end type
type rb_int from radiobutton within w_scan_for_tifs
end type
type rb_1 from radiobutton within w_scan_for_tifs
end type
type cb_del_sel from commandbutton within w_scan_for_tifs
end type
type cb_del_all from commandbutton within w_scan_for_tifs
end type
type cb_1 from commandbutton within w_scan_for_tifs
end type
type lb_1 from listbox within w_scan_for_tifs
end type
type gb_1 from groupbox within w_scan_for_tifs
end type
end forward

global type w_scan_for_tifs from window
boolean visible = false
integer x = 1056
integer y = 484
integer width = 1248
integer height = 1480
boolean titlebar = true
string title = "Delete tif files "
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
rb_int rb_int
rb_1 rb_1
cb_del_sel cb_del_sel
cb_del_all cb_del_all
cb_1 cb_1
lb_1 lb_1
gb_1 gb_1
end type
global w_scan_for_tifs w_scan_for_tifs

on w_scan_for_tifs.create
this.rb_int=create rb_int
this.rb_1=create rb_1
this.cb_del_sel=create cb_del_sel
this.cb_del_all=create cb_del_all
this.cb_1=create cb_1
this.lb_1=create lb_1
this.gb_1=create gb_1
this.Control[]={this.rb_int,&
this.rb_1,&
this.cb_del_sel,&
this.cb_del_all,&
this.cb_1,&
this.lb_1,&
this.gb_1}
end on

on w_scan_for_tifs.destroy
destroy(this.rb_int)
destroy(this.rb_1)
destroy(this.cb_del_sel)
destroy(this.cb_del_all)
destroy(this.cb_1)
destroy(this.lb_1)
destroy(this.gb_1)
end on

event open;long f
integer res

lb_1.DirList ( gs_temp_path + "*-*.tif",0)

f = lb_1.TotalItems()

//if f > 1 then
//	res = messagebox("Files Found","There are " + string(f) + ".tif files saved on your " + gs_dir_path + " drive.~r~rDo you wish to delete them? (Click NO if you wish to view them.)",question!,yesno!,2)
//	if res = 1 then
//		cb_del_all.triggerevent(clicked!)
//		close(this)
//	else
//		res = messagebox("Open Window?","Do you wish to view existing files?",question!,yesno!,2)
//		if res = 1 then
			this.visible = true
//		else
//			close(this)
//		end if
//	end if
//else
//	//close(this)
//			
//end if

ChangeDirectory(gs_current_path) //Add by Evan 11/10/2010
end event

type rb_int from radiobutton within w_scan_for_tifs
integer x = 745
integer y = 268
integer width = 480
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "IntelliCred folder"
boolean checked = true
end type

event clicked;long f
integer res

lb_1.DirList ( gs_temp_path + "*-*.tif",0)
end event

type rb_1 from radiobutton within w_scan_for_tifs
integer x = 759
integer y = 196
integer width = 443
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Root Drive (C:\)"
end type

event clicked;long f
integer res

lb_1.DirList ( gs_dir_path + "*-*.tif",0)
end event

type cb_del_sel from commandbutton within w_scan_for_tifs
integer x = 786
integer y = 424
integer width = 407
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Selected"
end type

event clicked;string filename
integer i
integer ic

for i = 1 to lb_1.TotalItems()
	//lb_1.DeleteItem ( 1 )
	//modified 022504 maha
	IF lb_1.State(i) = 1 THEN 
		filename = lb_1.text(i)
		if rb_1.checked then
			filename = gs_dir_path  + filename
		else
			filename = gs_temp_path + filename
		end if
		//MessageBox("Selected Item", 		lb_1.text(i))
		filedelete(filename)
	end if
next

if rb_1.checked then
	lb_1.DirList ( gs_dir_path + "*-*.tif",0)
else
	lb_1.DirList ( gs_temp_path + "*-*.tif",0)
end if






end event

type cb_del_all from commandbutton within w_scan_for_tifs
integer x = 786
integer y = 540
integer width = 407
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete All"
end type

event clicked;string filename
integer i
integer ic

for i = 1 to lb_1.TotalItems()
	filename = lb_1.text(i)
	if rb_1.checked then
		filename = gs_dir_path + filename
	else
		filename = gs_temp_path + filename
	end if
	filedelete(filename)
next

lb_1.DirList ( gs_dir_path + "*-*.tif",0)
end event

type cb_1 from commandbutton within w_scan_for_tifs
integer x = 786
integer y = 36
integer width = 407
integer height = 84
integer taborder = 40
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

type lb_1 from listbox within w_scan_for_tifs
integer width = 713
integer height = 1396
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean multiselect = true
borderstyle borderstyle = stylelowered!
boolean extendedselect = true
end type

type gb_1 from groupbox within w_scan_for_tifs
integer x = 731
integer y = 136
integer width = 498
integer height = 232
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Files on:"
end type

