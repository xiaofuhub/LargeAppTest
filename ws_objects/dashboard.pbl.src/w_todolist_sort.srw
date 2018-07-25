$PBExportHeader$w_todolist_sort.srw
forward
global type w_todolist_sort from w_popup
end type
type rb_2 from radiobutton within w_todolist_sort
end type
type rb_1 from radiobutton within w_todolist_sort
end type
type rb_mod from radiobutton within w_todolist_sort
end type
type cb_save from commandbutton within w_todolist_sort
end type
type cb_sort from commandbutton within w_todolist_sort
end type
type cb_reorder from commandbutton within w_todolist_sort
end type
type cb_close from commandbutton within w_todolist_sort
end type
type dw_tdl from u_dw within w_todolist_sort
end type
type gb_1 from groupbox within w_todolist_sort
end type
end forward

global type w_todolist_sort from w_popup
integer width = 4219
integer height = 2188
long backcolor = 33551856
rb_2 rb_2
rb_1 rb_1
rb_mod rb_mod
cb_save cb_save
cb_sort cb_sort
cb_reorder cb_reorder
cb_close cb_close
dw_tdl dw_tdl
gb_1 gb_1
end type
global w_todolist_sort w_todolist_sort

forward prototypes
public function integer of_sort_val ()
end prototypes

public function integer of_sort_val ();integer r

for r = 1 to dw_tdl.rowcount( )
	dw_tdl.setitem(r, "sort_order", r * 10)
next

return 1

end function

event open;call super::open;//Start Code Change ----07.27.2017 #V154 maha - added utility

dw_tdl.settransobject(sqlca)
dw_tdl.retrieve()

end event

on w_todolist_sort.create
int iCurrent
call super::create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.rb_mod=create rb_mod
this.cb_save=create cb_save
this.cb_sort=create cb_sort
this.cb_reorder=create cb_reorder
this.cb_close=create cb_close
this.dw_tdl=create dw_tdl
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_mod
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_sort
this.Control[iCurrent+6]=this.cb_reorder
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.dw_tdl
this.Control[iCurrent+9]=this.gb_1
end on

on w_todolist_sort.destroy
call super::destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.rb_mod)
destroy(this.cb_save)
destroy(this.cb_sort)
destroy(this.cb_reorder)
destroy(this.cb_close)
destroy(this.dw_tdl)
destroy(this.gb_1)
end on

type rb_2 from radiobutton within w_todolist_sort
integer x = 1504
integer y = 60
integer width = 283
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Other"
end type

event clicked;cb_sort.triggerevent(clicked!)
end event

type rb_1 from radiobutton within w_todolist_sort
integer x = 1143
integer y = 60
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Sort Order"
boolean checked = true
end type

event clicked;dw_tdl.setsort("sort_order ASC")
dw_tdl.sort()
end event

type rb_mod from radiobutton within w_todolist_sort
integer x = 526
integer y = 60
integer width = 581
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Function, Sort  Order"
end type

event clicked;dw_tdl.setsort("functional_area ASC, sort_order ASC")
dw_tdl.sort()
end event

type cb_save from commandbutton within w_todolist_sort
integer x = 2427
integer y = 36
integer width = 306
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;rb_1.triggerevent(clicked!)
cb_reorder.triggerevent(clicked!)
dw_tdl.update()
end event

type cb_sort from commandbutton within w_todolist_sort
integer x = 1897
integer y = 36
integer width = 498
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set Sort Order"
end type

event clicked;//string null_str
//
//SetNull(null_str)
//dw_tdl.SetSort(null_str)
//dw_tdl.Sort()

dw_tdl.inv_sort.of_setstyle(dw_tdl.inv_sort.dragdrop  )

dw_tdl.Event pfc_SortDlg()
end event

type cb_reorder from commandbutton within w_todolist_sort
integer x = 41
integer y = 36
integer width = 306
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reorder"
end type

event clicked;//dw_tdl.sort()
dw_tdl.accepttext()
dw_tdl.setsort("sort_order ASC")
dw_tdl.sort()

of_sort_val()
end event

type cb_close from commandbutton within w_todolist_sort
integer x = 3790
integer y = 36
integer width = 352
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_tdl from u_dw within w_todolist_sort
integer x = 23
integer y = 160
integer width = 4146
integer height = 1920
integer taborder = 10
string dataobject = "d_tdl_sort_set"
end type

event constructor;call super::constructor;This.of_SetSort(True)
end event

type gb_1 from groupbox within w_todolist_sort
integer x = 443
integer width = 1371
integer height = 148
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Sort on:"
borderstyle borderstyle = stylebox!
end type

