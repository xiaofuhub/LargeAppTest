$PBExportHeader$w_select_highlight_color.srw
forward
global type w_select_highlight_color from window
end type
type st_1 from statictext within w_select_highlight_color
end type
type cb_1 from commandbutton within w_select_highlight_color
end type
type rb_b from radiobutton within w_select_highlight_color
end type
type rb_p from radiobutton within w_select_highlight_color
end type
type rb_o from radiobutton within w_select_highlight_color
end type
type rb_g from radiobutton within w_select_highlight_color
end type
type rb_k from radiobutton within w_select_highlight_color
end type
type rb_y from radiobutton within w_select_highlight_color
end type
type r_1 from rectangle within w_select_highlight_color
end type
end forward

global type w_select_highlight_color from window
integer width = 1184
integer height = 800
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_1 cb_1
rb_b rb_b
rb_p rb_p
rb_o rb_o
rb_g rb_g
rb_k rb_k
rb_y rb_y
r_1 r_1
end type
global w_select_highlight_color w_select_highlight_color

type variables

end variables

on w_select_highlight_color.create
this.st_1=create st_1
this.cb_1=create cb_1
this.rb_b=create rb_b
this.rb_p=create rb_p
this.rb_o=create rb_o
this.rb_g=create rb_g
this.rb_k=create rb_k
this.rb_y=create rb_y
this.r_1=create r_1
this.Control[]={this.st_1,&
this.cb_1,&
this.rb_b,&
this.rb_p,&
this.rb_o,&
this.rb_g,&
this.rb_k,&
this.rb_y,&
this.r_1}
end on

on w_select_highlight_color.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.rb_b)
destroy(this.rb_p)
destroy(this.rb_o)
destroy(this.rb_g)
destroy(this.rb_k)
destroy(this.rb_y)
destroy(this.r_1)
end on

event open;//Start Code Change ----06.12.2012 #V12 maha - window created 
end event

type st_1 from statictext within w_select_highlight_color
integer x = 274
integer y = 24
integer width = 759
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Highlight Color"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_select_highlight_color
integer x = 352
integer y = 656
integer width = 402
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;gs_pass_ids lgs_color

if rb_y.checked then
	lgs_color.l_app_id = 8257535
	lgs_color.ls_ref_value = "Yellow"
elseif rb_b.checked then
	lgs_color.l_app_id = 16773350
	lgs_color.ls_ref_value = "Blue"
elseif rb_p.checked then
	lgs_color.l_app_id = 16770800
	lgs_color.ls_ref_value = "Purple"
elseif rb_o.checked then
	lgs_color.l_app_id = 15134975
	lgs_color.ls_ref_value = "Orange"
elseif rb_g.checked then
	lgs_color.l_app_id = 15138800
	lgs_color.ls_ref_value = "Green"
elseif rb_k.checked then
	lgs_color.l_app_id = 15787775
	lgs_color.ls_ref_value = "Pink"
end if

closewithreturn(parent,lgs_color)



end event

type rb_b from radiobutton within w_select_highlight_color
integer x = 82
integer y = 316
integer width = 434
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Blue"
end type

event clicked;cb_1.triggerevent(clicked!)
end event

event constructor;this.backcolor = 16773350
end event

type rb_p from radiobutton within w_select_highlight_color
integer x = 82
integer y = 456
integer width = 434
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33546726
string text = "Purple"
end type

event constructor;this.backcolor = 16770800
end event

event clicked;cb_1.triggerevent(clicked!)
end event

type rb_o from radiobutton within w_select_highlight_color
integer x = 635
integer y = 168
integer width = 434
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 29935871
string text = "Orange"
end type

event constructor;this.backcolor = 15134975
end event

event clicked;cb_1.triggerevent(clicked!)
end event

type rb_g from radiobutton within w_select_highlight_color
integer x = 635
integer y = 312
integer width = 434
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 30602721
string text = "Green"
end type

event constructor;this.backcolor = 15138800
end event

event clicked;cb_1.triggerevent(clicked!)
end event

type rb_k from radiobutton within w_select_highlight_color
integer x = 635
integer y = 456
integer width = 434
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16711935
string text = "Pink"
end type

event constructor;this.backcolor = 15787775
end event

event clicked;cb_1.triggerevent(clicked!)
end event

type rb_y from radiobutton within w_select_highlight_color
integer x = 78
integer y = 172
integer width = 434
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 25231359
string text = "Yellow"
boolean checked = true
end type

event constructor;this.backcolor = 8257535
end event

event clicked;cb_1.triggerevent(clicked!)
end event

type r_1 from rectangle within w_select_highlight_color
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 16777215
integer x = 14
integer y = 120
integer width = 1134
integer height = 508
end type

