$PBExportHeader$uo_dm_change_toollbar.sru
$PBExportComments$Toolbar buttons for uo_dm_image_view
forward
global type uo_dm_change_toollbar from userobject
end type
type st_count from statictext within uo_dm_change_toollbar
end type
type st_2 from statictext within uo_dm_change_toollbar
end type
type st_page from statictext within uo_dm_change_toollbar
end type
type cb_last from commandbutton within uo_dm_change_toollbar
end type
type cb_next from commandbutton within uo_dm_change_toollbar
end type
type cb_prior from commandbutton within uo_dm_change_toollbar
end type
type cb_first from commandbutton within uo_dm_change_toollbar
end type
type st_pages from statictext within uo_dm_change_toollbar
end type
end forward

global type uo_dm_change_toollbar from userobject
integer width = 1097
integer height = 76
long backcolor = 33551856
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
event ue_set_viewstyle ( string as_viewstyle )
event ue_zoom ( string as_action )
event ue_show_magnifier ( )
event ue_show_toolmenu ( )
event ue_set_mousetype ( string as_mousetype )
event ue_scroll ( string as_scrolltype )
event ue_page_modified ( )
st_count st_count
st_2 st_2
st_page st_page
cb_last cb_last
cb_next cb_next
cb_prior cb_prior
cb_first cb_first
st_pages st_pages
end type
global uo_dm_change_toollbar uo_dm_change_toollbar

type variables

end variables

on uo_dm_change_toollbar.create
this.st_count=create st_count
this.st_2=create st_2
this.st_page=create st_page
this.cb_last=create cb_last
this.cb_next=create cb_next
this.cb_prior=create cb_prior
this.cb_first=create cb_first
this.st_pages=create st_pages
this.Control[]={this.st_count,&
this.st_2,&
this.st_page,&
this.cb_last,&
this.cb_next,&
this.cb_prior,&
this.cb_first,&
this.st_pages}
end on

on uo_dm_change_toollbar.destroy
destroy(this.st_count)
destroy(this.st_2)
destroy(this.st_page)
destroy(this.cb_last)
destroy(this.cb_next)
destroy(this.cb_prior)
destroy(this.cb_first)
destroy(this.st_pages)
end on

type st_count from statictext within uo_dm_change_toollbar
integer x = 178
integer y = 12
integer width = 133
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
boolean focusrectangle = false
end type

type st_2 from statictext within uo_dm_change_toollbar
integer x = 110
integer y = 12
integer width = 64
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_page from statictext within uo_dm_change_toollbar
integer y = 12
integer width = 105
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_last from commandbutton within uo_dm_change_toollbar
integer x = 997
integer width = 101
integer height = 72
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">|"
end type

event clicked;parent.event ue_scroll ( 'last')
end event

type cb_next from commandbutton within uo_dm_change_toollbar
integer x = 901
integer width = 101
integer height = 72
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">"
end type

event clicked;parent.event ue_scroll( 'next')
end event

type cb_prior from commandbutton within uo_dm_change_toollbar
integer x = 805
integer width = 101
integer height = 72
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<"
end type

event clicked;parent.event ue_scroll( 'prior')
end event

type cb_first from commandbutton within uo_dm_change_toollbar
event ue_scroll ( string as_parm )
string tag = "first"
integer x = 709
integer width = 101
integer height = 72
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "|<"
end type

event ue_scroll(string as_parm);
Return
end event

event clicked;parent.event ue_scroll( 'first')
end event

type st_pages from statictext within uo_dm_change_toollbar
boolean visible = false
integer y = 12
integer width = 123
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Page"
long bordercolor = 16777215
boolean focusrectangle = false
end type

