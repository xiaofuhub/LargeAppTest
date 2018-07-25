$PBExportHeader$w_delete_pages.srw
forward
global type w_delete_pages from window
end type
type em_end from editmask within w_delete_pages
end type
type rb_current from radiobutton within w_delete_pages
end type
type rb_specified from radiobutton within w_delete_pages
end type
type em_start from editmask within w_delete_pages
end type
type st_1 from statictext within w_delete_pages
end type
type cb_cancel from commandbutton within w_delete_pages
end type
type cb_ok from commandbutton within w_delete_pages
end type
type gb_1 from groupbox within w_delete_pages
end type
end forward

global type w_delete_pages from window
integer width = 1403
integer height = 804
boolean titlebar = true
string title = "Delete Pages"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
em_end em_end
rb_current rb_current
rb_specified rb_specified
em_start em_start
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
end type
global w_delete_pages w_delete_pages

on w_delete_pages.create
this.em_end=create em_end
this.rb_current=create rb_current
this.rb_specified=create rb_specified
this.em_start=create em_start
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.Control[]={this.em_end,&
this.rb_current,&
this.rb_specified,&
this.em_start,&
this.st_1,&
this.cb_cancel,&
this.cb_ok,&
this.gb_1}
end on

on w_delete_pages.destroy
destroy(this.em_end)
destroy(this.rb_current)
destroy(this.rb_specified)
destroy(this.em_start)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

type em_end from editmask within w_delete_pages
integer x = 896
integer y = 296
integer width = 215
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
string text = "1"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "1~~"
end type

event losefocus;IF Long(Trim(This.Text)) <= 0 THEN
	MessageBox("Warning","This Value must be greater than Zero. ")
	This.SetFocus()
	This.SelectText(1, LenA(This.Text))
END IF

end event

type rb_current from radiobutton within w_delete_pages
integer x = 238
integer y = 184
integer width = 709
integer height = 64
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Current Page"
boolean checked = true
end type

event clicked;IF This.Checked THEN
	em_start.Enabled = FALSE
	em_end.Enabled = FALSE
END IF

end event

type rb_specified from radiobutton within w_delete_pages
integer x = 238
integer y = 308
integer width = 347
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Pages from"
end type

event clicked;IF This.Checked THEN
	em_start.Enabled = TRUE
	em_end.Enabled = TRUE
END IF

end event

type em_start from editmask within w_delete_pages
integer x = 585
integer y = 296
integer width = 215
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
string text = "1"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "1~~"
end type

event losefocus;IF Long(Trim(This.Text)) <= 0 THEN
	MessageBox("Warning","This Value must be greater than Zero. ")
	This.SetFocus()
	This.SelectText(1, LenA(This.Text))
END IF

end event

type st_1 from statictext within w_delete_pages
integer x = 795
integer y = 312
integer width = 96
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "to"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_delete_pages
integer x = 672
integer y = 548
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_ok from commandbutton within w_delete_pages
integer x = 329
integer y = 548
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;IF rb_specified.Checked THEN
	IF Long(em_start.Text) > Long(em_end.Text) THEN
		MessageBox("Warning","The start page should not be greater than the end page! ")
		RETURN 1
	END IF
	CloseWithReturn( Parent, em_start.Text + "-" + em_end.Text )
ELSEIF rb_current.Checked THEN
	CloseWithReturn( Parent, "0-0")
END IF








end event

type gb_1 from groupbox within w_delete_pages
integer x = 183
integer y = 100
integer width = 992
integer height = 332
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Range"
end type

