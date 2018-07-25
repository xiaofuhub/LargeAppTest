$PBExportHeader$w_environment_check_msg.srw
forward
global type w_environment_check_msg from w_popup
end type
type mle_note from multilineedit within w_environment_check_msg
end type
type cb_copy_result from commandbutton within w_environment_check_msg
end type
type cb_close from commandbutton within w_environment_check_msg
end type
type st_1 from statictext within w_environment_check_msg
end type
type mle_1 from multilineedit within w_environment_check_msg
end type
end forward

global type w_environment_check_msg from w_popup
integer width = 2747
integer height = 2172
string title = "Delete File Result"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
mle_note mle_note
cb_copy_result cb_copy_result
cb_close cb_close
st_1 st_1
mle_1 mle_1
end type
global w_environment_check_msg w_environment_check_msg

on w_environment_check_msg.create
int iCurrent
call super::create
this.mle_note=create mle_note
this.cb_copy_result=create cb_copy_result
this.cb_close=create cb_close
this.st_1=create st_1
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_note
this.Control[iCurrent+2]=this.cb_copy_result
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.mle_1
end on

on w_environment_check_msg.destroy
call super::destroy
destroy(this.mle_note)
destroy(this.cb_copy_result)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.mle_1)
end on

event open;call super::open;String 	ls_msg



ls_msg = Message.StringParm	

mle_1.text = ls_msg

mle_note.text = 'Suggestion: Close the IE and then run the delete_register.bat batch file to delete files in~r~n' + gs_dir_path + gs_DefDirName
end event

type mle_note from multilineedit within w_environment_check_msg
integer x = 14
integer y = 1764
integer width = 2702
integer height = 212
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
string text = "NOTE:"
borderstyle borderstyle = stylelowered!
end type

type cb_copy_result from commandbutton within w_environment_check_msg
integer x = 1691
integer y = 1988
integer width = 681
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Show Batch File in Folder"
boolean default = true
end type

event clicked;////Clipboard(mle_1.text)
//Clipboard( gs_dir_path + gs_DefDirName )
String ls_null

SetNull(ls_null)
ShellExecuteA ( Handle( This ), "open", gs_dir_path + gs_DefDirName , ls_Null, ls_Null, 4)

end event

type cb_close from commandbutton within w_environment_check_msg
integer x = 2377
integer y = 1988
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_environment_check_msg
integer x = 14
integer y = 24
integer width = 1029
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
string text = "The following files cannot be deleted :"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_environment_check_msg
integer x = 14
integer y = 96
integer width = 2702
integer height = 1656
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

