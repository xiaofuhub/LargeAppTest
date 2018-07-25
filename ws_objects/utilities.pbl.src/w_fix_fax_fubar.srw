$PBExportHeader$w_fix_fax_fubar.srw
forward
global type w_fix_fax_fubar from window
end type
type rb_num from radiobutton within w_fix_fax_fubar
end type
type rb_form from radiobutton within w_fix_fax_fubar
end type
type dw_1 from datawindow within w_fix_fax_fubar
end type
type cb_2 from commandbutton within w_fix_fax_fubar
end type
type cb_run from commandbutton within w_fix_fax_fubar
end type
type gb_1 from groupbox within w_fix_fax_fubar
end type
end forward

global type w_fix_fax_fubar from window
integer width = 1312
integer height = 2348
boolean titlebar = true
string title = "Fax number Format"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_num rb_num
rb_form rb_form
dw_1 dw_1
cb_2 cb_2
cb_run cb_run
gb_1 gb_1
end type
global w_fix_fax_fubar w_fix_fax_fubar

on w_fix_fax_fubar.create
this.rb_num=create rb_num
this.rb_form=create rb_form
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_run=create cb_run
this.gb_1=create gb_1
this.Control[]={this.rb_num,&
this.rb_form,&
this.dw_1,&
this.cb_2,&
this.cb_run,&
this.gb_1}
end on

on w_fix_fax_fubar.destroy
destroy(this.rb_num)
destroy(this.rb_form)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_run)
destroy(this.gb_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type rb_num from radiobutton within w_fix_fax_fubar
integer x = 786
integer y = 180
integer width = 370
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "All numbers"
end type

type rb_form from radiobutton within w_fix_fax_fubar
integer x = 251
integer y = 180
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "(123) 456-7890"
boolean checked = true
end type

type dw_1 from datawindow within w_fix_fax_fubar
integer x = 114
integer y = 280
integer width = 1033
integer height = 1884
integer taborder = 10
string title = "none"
string dataobject = "d_fix_fax_fubar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_fix_fax_fubar
integer x = 896
integer y = 40
integer width = 343
integer height = 88
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

type cb_run from commandbutton within w_fix_fax_fubar
integer x = 475
integer y = 40
integer width = 343
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;integer res
long i
integer skip
long ic
string sf
string ls_fax 


 res = 	messagebox("About","This utility will standardize All existing Group practice fax numbers to the selected format.~r~rDo you wish to continue?",Question!,yesno!,1)
if res = 2 then return

ic = dw_1.rowcount()

for i = 1 to ic
	skip = 0
	ls_fax = dw_1.getitemstring(i,"fax")
	sf = ls_fax
	sf =  of_strip_char("", sf,"@NUM@")
	if rb_form.checked then
		if LenA(sf ) = 10 then
			sf = "(" + MidA(sf,1,3) + ") " + MidA(sf,4,3) + "-" + MidA(sf,7) 
		elseif LenA(sf) = 7 then
			sf = MidA(sf,1,3) + "-" + MidA(sf,4) 
		else
			if LenA( ls_fax) < 14 then
				skip = 1
			else
				skip = 0
			end if
		end if
	end if
	
	if skip = 0 then dw_1.setitem(i,"fax",sf)
next

dw_1.update()

messagebox("Completed","Done")




end event

type gb_1 from groupbox within w_fix_fax_fubar
integer x = 23
integer y = 144
integer width = 1211
integer height = 116
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Format"
end type

