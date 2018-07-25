$PBExportHeader$w_file_read.srw
forward
global type w_file_read from window
end type
type sle_2 from singlelineedit within w_file_read
end type
type st_2 from statictext within w_file_read
end type
type st_1 from statictext within w_file_read
end type
type sle_end from singlelineedit within w_file_read
end type
type sle_start from singlelineedit within w_file_read
end type
type cb_2 from commandbutton within w_file_read
end type
type sle_1 from singlelineedit within w_file_read
end type
type cb_1 from commandbutton within w_file_read
end type
end forward

global type w_file_read from window
integer width = 2793
integer height = 2012
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
sle_2 sle_2
st_2 st_2
st_1 st_1
sle_end sle_end
sle_start sle_start
cb_2 cb_2
sle_1 sle_1
cb_1 cb_1
end type
global w_file_read w_file_read

on w_file_read.create
this.sle_2=create sle_2
this.st_2=create st_2
this.st_1=create st_1
this.sle_end=create sle_end
this.sle_start=create sle_start
this.cb_2=create cb_2
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.sle_2,&
this.st_2,&
this.st_1,&
this.sle_end,&
this.sle_start,&
this.cb_2,&
this.sle_1,&
this.cb_1}
end on

on w_file_read.destroy
destroy(this.sle_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_end)
destroy(this.sle_start)
destroy(this.cb_2)
destroy(this.sle_1)
destroy(this.cb_1)
end on

type sle_2 from singlelineedit within w_file_read
integer x = 197
integer y = 208
integer width = 1861
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "C:\Users\maha\Desktop\up_expiring_appointments write.sql"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_file_read
integer x = 1051
integer y = 332
integer width = 288
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Add at end"
boolean focusrectangle = false
end type

type st_1 from statictext within w_file_read
integer x = 64
integer y = 332
integer width = 293
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Add before:"
boolean focusrectangle = false
end type

type sle_end from singlelineedit within w_file_read
integer x = 1367
integer y = 332
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = " ~" + &"
borderstyle borderstyle = stylelowered!
end type

type sle_start from singlelineedit within w_file_read
integer x = 471
integer y = 332
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "~""
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_file_read
integer x = 978
integer y = 524
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run "
end type

event clicked;
string ls_text
String	ls_file
String	ls_file2
string ls_start
string ls_end
integer li_read
Integer li_FileNum
Integer li_FileNum2
integer i

ls_start = sle_start.text
ls_end = sle_end.text

ls_file = sle_1.text
ls_file2 = sle_2.text

li_FileNum = FileOpen(ls_file, LineMode!, READ!, LockRead!, Replace!)
li_FileNum2 = FileOpen(ls_file2, LineMode!, Write!, LockWrite!, Append!)

For i = 1 to 50000 //this is an arbitrary number to assure all the lines have been read
	if FileRead (li_FileNum, ls_text) = -100 then exit //end of file
	ls_text = ls_start + ls_text + ls_end
	FileWrite(li_FileNum2,ls_text)
Next	

FileClose(li_FileNum)
FileClose(li_FileNum2)
messagebox("","Done")



/////////////////////////
//
//string dbfname, named
//
//integer value
//
//value = GetFileOpenName("Select File",&
//+ dbfname, named, "TXT", &
//	+ "text Files (*.txt),*.txt")
//ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
//
//IF value = 1 THEN
//	sle_1.text = dbfname
//END IF
end event

type sle_1 from singlelineedit within w_file_read
integer x = 201
integer y = 108
integer width = 1856
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "C:\Users\maha\Desktop\up_expiring_appointments.sql"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_file_read
integer x = 2167
integer y = 112
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "get file"
end type

event clicked;
string dbfname, named

integer value

value = GetFileOpenName("Select File",  dbfname, named, "All", "All Files (*.*), *.*") 
//ChangeDirectory(gs_current_path) 

IF value = 1 THEN
	sle_1.text = dbfname
END IF
end event

