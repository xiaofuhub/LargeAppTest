$PBExportHeader$w_finddlg.srw
$PBExportComments$New Requirement: finddlg use in fee of contract
forward
global type w_finddlg from window
end type
type cb_close from commandbutton within w_finddlg
end type
type cb_find from commandbutton within w_finddlg
end type
type sle_rev_code from singlelineedit within w_finddlg
end type
type sle_drg_code from singlelineedit within w_finddlg
end type
type sle_cpt_code from singlelineedit within w_finddlg
end type
type st_rev_code from statictext within w_finddlg
end type
type st_drg_code from statictext within w_finddlg
end type
type st_cpt_code from statictext within w_finddlg
end type
end forward

global type w_finddlg from window
integer width = 1257
integer height = 972
boolean titlebar = true
string title = "Find"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_find cb_find
sle_rev_code sle_rev_code
sle_drg_code sle_drg_code
sle_cpt_code sle_cpt_code
st_rev_code st_rev_code
st_drg_code st_drg_code
st_cpt_code st_cpt_code
end type
global w_finddlg w_finddlg

type variables
datawindow idw_find
end variables

on w_finddlg.create
this.cb_close=create cb_close
this.cb_find=create cb_find
this.sle_rev_code=create sle_rev_code
this.sle_drg_code=create sle_drg_code
this.sle_cpt_code=create sle_cpt_code
this.st_rev_code=create st_rev_code
this.st_drg_code=create st_drg_code
this.st_cpt_code=create st_cpt_code
this.Control[]={this.cb_close,&
this.cb_find,&
this.sle_rev_code,&
this.sle_drg_code,&
this.sle_cpt_code,&
this.st_rev_code,&
this.st_drg_code,&
this.st_cpt_code}
end on

on w_finddlg.destroy
destroy(this.cb_close)
destroy(this.cb_find)
destroy(this.sle_rev_code)
destroy(this.sle_drg_code)
destroy(this.sle_cpt_code)
destroy(this.st_rev_code)
destroy(this.st_drg_code)
destroy(this.st_cpt_code)
end on

event open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-19 By: Liu HongXin
//$<reason> New Requirement.
idw_find = Message.PowerObjectParm
If Not IsValid(idw_find) Then Return
st_cpt_code.text = idw_find.Describe("cpt_code_t.Text")
st_drg_code.text = idw_find.Describe("drg_code_t.Text")
st_rev_code.text = idw_find.Describe("rev_code_t.Text")
//---------------------------- APPEON END ----------------------------

end event

event key;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-22 By: Liu Hongxin
//$<reason> 
IF keyflags = 0 THEN
   IF key = KeyEnter! THEN
		GraphicObject lg_control
		lg_control = GetFocus ( )
		IF IsValid(lg_control) THEN
			CHOOSE CASE Lower(lg_control.ClassName())
				CASE "sle_cpt_code"
					sle_drg_code.SetFocus()
				CASE "sle_drg_code"
					sle_rev_code.SetFocus()
				CASE "sle_rev_code"
					IF sle_cpt_code.Text = "" AND sle_drg_code.Text = "" AND sle_rev_code.Text = "" THEN
						cb_close.SetFocus()
					ELSE
						cb_find.SetFocus()
					END IF
				CASE "cb_find"
					cb_find.Event Clicked()
				CASE "cb_close"
					cb_close.Event Clicked()
			END CHOOSE
		END IF
   END IF
END IF
//---------------------------- APPEON END ----------------------------
end event

type cb_close from commandbutton within w_finddlg
integer x = 677
integer y = 744
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_find from commandbutton within w_finddlg
integer x = 123
integer y = 744
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-19 By: Liu HongXin
//$<reason> New Requirement.
Long ll_Row
String ls_Find
If Not IsValid(idw_find) Then Return

IF sle_cpt_code.Text <> "" THEN
	ls_Find = 'cpt_code = "' + sle_cpt_code.Text + '"'
END IF
IF sle_drg_code.Text <> "" THEN
	IF ls_Find = "" THEN
		ls_Find = 'drg_code = "' + sle_drg_code.Text + '"'
	ELSE
		ls_Find += ' AND drg_code = "' + sle_drg_code.Text + '"'
	END IF
END IF
IF sle_rev_code.Text <> "" THEN
	IF ls_Find = "" THEN
		ls_Find = 'rev_code = "' + sle_rev_code.Text + '"'
	ELSE
		ls_Find += ' AND rev_code = "' + sle_rev_code.Text + '"'
	END IF
END IF

IF ls_Find = "" THEN
	MessageBox("Find", "Input data first, Please.")
	Return
END IF
ll_Row = idw_find.Find(ls_Find, 1, idw_find.RowCount())

IF ll_Row > 0 THEN
	idw_find.SetRow(ll_Row)
	idw_find.SelectRow(0, FALSE)
	idw_find.SelectRow(ll_Row, TRUE)
ELSE
	MessageBox("Find", "No matching records found.")
END IF
CloseWithReturn(Parent, ls_Find)
//---------------------------- APPEON END ----------------------------

end event

type sle_rev_code from singlelineedit within w_finddlg
integer x = 128
integer y = 548
integer width = 553
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_drg_code from singlelineedit within w_finddlg
integer x = 133
integer y = 340
integer width = 553
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
end type

type sle_cpt_code from singlelineedit within w_finddlg
integer x = 133
integer y = 132
integer width = 553
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
end type

type st_rev_code from statictext within w_finddlg
integer x = 133
integer y = 484
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
string text = "Rev Code"
boolean focusrectangle = false
end type

type st_drg_code from statictext within w_finddlg
integer x = 133
integer y = 272
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
string text = "DRG Code"
boolean focusrectangle = false
end type

type st_cpt_code from statictext within w_finddlg
integer x = 133
integer y = 60
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
string text = "Code"
boolean focusrectangle = false
end type

