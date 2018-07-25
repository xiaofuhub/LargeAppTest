$PBExportHeader$w_get_path.srw
forward
global type w_get_path from w_response
end type
type st_path from statictext within w_get_path
end type
type sle_path from singlelineedit within w_get_path
end type
type cb_ok from commandbutton within w_get_path
end type
type cb_cancel from commandbutton within w_get_path
end type
type cb_1 from commandbutton within w_get_path
end type
end forward

global type w_get_path from w_response
integer x = 814
integer y = 640
integer width = 2185
integer height = 488
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_path st_path
sle_path sle_path
cb_ok cb_ok
cb_cancel cb_cancel
cb_1 cb_1
end type
global w_get_path w_get_path

event open;call super::open;String ls_image_path

SELECT ids.intelliapp_app_path  
INTO :ls_image_path  
FROM ids 
USING w_train_app.tr_training_data;

IF w_train_app.tr_training_data.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
END IF

sle_path.Text = ls_image_path

end event

on w_get_path.create
int iCurrent
call super::create
this.st_path=create st_path
this.sle_path=create sle_path
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_path
this.Control[iCurrent+2]=this.sle_path
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_1
end on

on w_get_path.destroy
call super::destroy
destroy(this.st_path)
destroy(this.sle_path)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_1)
end on

type st_path from statictext within w_get_path
integer x = 50
integer y = 52
integer width = 1216
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Enter the path to use to store application images"
boolean focusrectangle = false
end type

type sle_path from singlelineedit within w_get_path
integer x = 50
integer y = 140
integer width = 1746
integer height = 92
integer taborder = 10
boolean bringtotop = true
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

type cb_ok from commandbutton within w_get_path
integer x = 800
integer y = 272
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;String ls_path

ls_path = sle_path.Text


//Start Code Change ---- 03.01.2006 #1 maha
//IF Right( ls_path, 1 ) <> "\" THEN
//	ls_path = ls_path + "\"
//END IF
ls_path = of_check_path(ls_path,1)
//End Code Change---03.01.2006

UPDATE ids  
SET intelliapp_app_path = :ls_path
USING w_train_app.tr_training_data;

COMMIT USING w_train_app.tr_training_data;

CloseWithReturn( Parent,  ls_path )

end event

type cb_cancel from commandbutton within w_get_path
integer x = 1061
integer y = 272
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_1 from commandbutton within w_get_path
integer x = 1815
integer y = 144
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse"
end type

event clicked;string docname, named, path

integer value

value = GetFilesaveName("Select Directory and enter 'Path' as file name",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value = 1 THEN
	path = MidA(docname,1,PosA(docname,named,1) - 1)
	sle_path.text = path
END IF
end event

