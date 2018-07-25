$PBExportHeader$u_call_log_my_stuff.sru
forward
global type u_call_log_my_stuff from userobject
end type
type cb_3 from commandbutton within u_call_log_my_stuff
end type
type cb_2 from commandbutton within u_call_log_my_stuff
end type
type rb_all from radiobutton within u_call_log_my_stuff
end type
type rb_mine from radiobutton within u_call_log_my_stuff
end type
type dw_browse from datawindow within u_call_log_my_stuff
end type
type gb_1 from groupbox within u_call_log_my_stuff
end type
end forward

global type u_call_log_my_stuff from userobject
integer width = 4471
integer height = 2268
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_3 cb_3
cb_2 cb_2
rb_all rb_all
rb_mine rb_mine
dw_browse dw_browse
gb_1 gb_1
end type
global u_call_log_my_stuff u_call_log_my_stuff

forward prototypes
public function integer of_view_detail (integer ai_row)
public function integer of_open ()
public function integer of_refresh_data ()
end prototypes

public function integer of_view_detail (integer ai_row);long ll_id

if ai_row > 0 then
	ll_id = dw_browse.getitemnumber(ai_row, "record_id")
	openwithparm(w_call_log, ll_id)
end if

//dw_browse.retrieve(gs_user_id)  //Start Code Change ----11.18.2013 #V14 maha - refresh data commented by long.zhang 11.22.2013 w_call_log is not response window replace with of_refresh_data() BugL111303 

return 1
end function

public function integer of_open ();dw_browse.settransobject( sqlca)
dw_browse.retrieve(gs_user_id)

if w_mdi.of_security_access( 7681 ) = 0 THEN
	rb_all.visible = false
	rb_mine.visible = false
	gb_1.visible = false
end if

return 1
end function

public function integer of_refresh_data ();//====================================================================
//$<Function>: of_refresh_data
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Refresh data Fixed  BugL111303 called from w_call_log.close event
//$<Author>: (Appeon) long.zhang 11.22.2013 ()
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row

ll_row = dw_browse.getrow( )

if ll_row <= 0 then return 0

dw_browse.retrieve( gs_user_id )

if ll_row > 0 then
	dw_browse.scrolltorow(ll_row)	
	dw_browse.selectrow( 0,false)
	dw_browse.selectrow( ll_row,true)
end if

return 1
end function

on u_call_log_my_stuff.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.rb_all=create rb_all
this.rb_mine=create rb_mine
this.dw_browse=create dw_browse
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.rb_all,&
this.rb_mine,&
this.dw_browse,&
this.gb_1}
end on

on u_call_log_my_stuff.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.rb_all)
destroy(this.rb_mine)
destroy(this.dw_browse)
destroy(this.gb_1)
end on

type cb_3 from commandbutton within u_call_log_my_stuff
integer x = 3698
integer y = 36
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_browse.SetSort(null_str)

dw_browse.Sort( )
end event

type cb_2 from commandbutton within u_call_log_my_stuff
integer x = 3323
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Detail"
end type

event clicked;of_view_detail(dw_browse.getrow())
end event

type rb_all from radiobutton within u_call_log_my_stuff
integer x = 585
integer y = 52
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "All Open Calls"
end type

event clicked;dw_browse.dataobject = "d_call_log_search_all_open"
dw_browse.settransobject(sqlca)
dw_browse.retrieve()
end event

type rb_mine from radiobutton within u_call_log_my_stuff
integer x = 105
integer y = 56
integer width = 430
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "My Open Calls"
boolean checked = true
end type

event clicked;dw_browse.dataobject = "d_call_log_search_my_open"
dw_browse.settransobject(sqlca)
dw_browse.retrieve(gs_user_id)
end event

type dw_browse from datawindow within u_call_log_my_stuff
integer y = 168
integer width = 4475
integer height = 2104
integer taborder = 10
string title = "none"
string dataobject = "d_call_log_search_my_open"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long r

r = this.getclickedrow( )
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

event doubleclicked;of_view_detail(row)

end event

type gb_1 from groupbox within u_call_log_my_stuff
integer x = 37
integer width = 1102
integer height = 140
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "View"
end type

