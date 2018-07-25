$PBExportHeader$w_recruit_positionszzz.srw
forward
global type w_recruit_positionszzz from window
end type
type dw_stat_filt from datawindow within w_recruit_positionszzz
end type
type rb_6 from radiobutton within w_recruit_positionszzz
end type
type rb_5 from radiobutton within w_recruit_positionszzz
end type
type rb_3 from radiobutton within w_recruit_positionszzz
end type
type gb_3 from groupbox within w_recruit_positionszzz
end type
type cb_3 from commandbutton within w_recruit_positionszzz
end type
type cb_delete from commandbutton within w_recruit_positionszzz
end type
type gb_2 from groupbox within w_recruit_positionszzz
end type
type cb_close from commandbutton within w_recruit_positionszzz
end type
type cb_save from commandbutton within w_recruit_positionszzz
end type
type cb_add from commandbutton within w_recruit_positionszzz
end type
type cb_2 from commandbutton within w_recruit_positionszzz
end type
type cb_1 from commandbutton within w_recruit_positionszzz
end type
type dw_detail from u_dw within w_recruit_positionszzz
end type
type dw_browse from u_dw within w_recruit_positionszzz
end type
type gb_1 from groupbox within w_recruit_positionszzz
end type
type st_1 from statictext within w_recruit_positionszzz
end type
type sle_1 from singlelineedit within w_recruit_positionszzz
end type
type st_2 from statictext within w_recruit_positionszzz
end type
type sle_2 from singlelineedit within w_recruit_positionszzz
end type
end forward

global type w_recruit_positionszzz from window
integer width = 4325
integer height = 2656
boolean titlebar = true
string title = "Recruitment Positions"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
dw_stat_filt dw_stat_filt
rb_6 rb_6
rb_5 rb_5
rb_3 rb_3
gb_3 gb_3
cb_3 cb_3
cb_delete cb_delete
gb_2 gb_2
cb_close cb_close
cb_save cb_save
cb_add cb_add
cb_2 cb_2
cb_1 cb_1
dw_detail dw_detail
dw_browse dw_browse
gb_1 gb_1
st_1 st_1
sle_1 sle_1
st_2 st_2
sle_2 sle_2
end type
global w_recruit_positionszzz w_recruit_positionszzz

on w_recruit_positionszzz.create
this.dw_stat_filt=create dw_stat_filt
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_3=create rb_3
this.gb_3=create gb_3
this.cb_3=create cb_3
this.cb_delete=create cb_delete
this.gb_2=create gb_2
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.gb_1=create gb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.st_2=create st_2
this.sle_2=create sle_2
this.Control[]={this.dw_stat_filt,&
this.rb_6,&
this.rb_5,&
this.rb_3,&
this.gb_3,&
this.cb_3,&
this.cb_delete,&
this.gb_2,&
this.cb_close,&
this.cb_save,&
this.cb_add,&
this.cb_2,&
this.cb_1,&
this.dw_detail,&
this.dw_browse,&
this.gb_1,&
this.st_1,&
this.sle_1,&
this.st_2,&
this.sle_2}
end on

on w_recruit_positionszzz.destroy
destroy(this.dw_stat_filt)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_3)
destroy(this.gb_3)
destroy(this.cb_3)
destroy(this.cb_delete)
destroy(this.gb_2)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.sle_2)
end on

event open;long  lid
long rc

dw_browse.settransobject(sqlca)
rc = dw_browse.retrieve()

if rc < 1 then return



dw_detail.settransobject(sqlca)


end event

type dw_stat_filt from datawindow within w_recruit_positionszzz
integer x = 297
integer y = 304
integer width = 1079
integer height = 96
integer taborder = 20
string title = "none"
string dataobject = "d_req_pos_status"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type rb_6 from radiobutton within w_recruit_positionszzz
integer x = 256
integer y = 148
integer width = 274
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Opened"
boolean checked = true
end type

type rb_5 from radiobutton within w_recruit_positionszzz
integer x = 631
integer y = 148
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Closed"
end type

type rb_3 from radiobutton within w_recruit_positionszzz
integer x = 974
integer y = 144
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Filled"
end type

type gb_3 from groupbox within w_recruit_positionszzz
integer x = 160
integer y = 96
integer width = 2245
integer height = 124
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Dates"
end type

type cb_3 from commandbutton within w_recruit_positionszzz
integer x = 3291
integer y = 336
integer width = 407
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get WV Link"
end type

type cb_delete from commandbutton within w_recruit_positionszzz
integer x = 3397
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

type gb_2 from groupbox within w_recruit_positionszzz
integer x = 155
integer y = 252
integer width = 1257
integer height = 144
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Status"
end type

type cb_close from commandbutton within w_recruit_positionszzz
integer x = 3817
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
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

type cb_save from commandbutton within w_recruit_positionszzz
integer x = 2683
integer y = 36
integer width = 343
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

type cb_add from commandbutton within w_recruit_positionszzz
integer x = 3045
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

type cb_2 from commandbutton within w_recruit_positionszzz
integer x = 3739
integer y = 336
integer width = 407
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Candidates"
end type

type cb_1 from commandbutton within w_recruit_positionszzz
integer x = 2117
integer y = 296
integer width = 242
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

type dw_detail from u_dw within w_recruit_positionszzz
integer x = 105
integer y = 1056
integer width = 4037
integer height = 1476
integer taborder = 10
boolean titlebar = true
string title = "Detail"
string dataobject = "d_recruit_position_detail"
end type

type dw_browse from u_dw within w_recruit_positionszzz
integer x = 123
integer y = 448
integer width = 4037
integer height = 588
integer taborder = 10
boolean titlebar = true
string title = "Browse"
string dataobject = "d_recruit_position_browse"
end type

event rowfocuschanged;call super::rowfocuschanged;long pid

this.selectrow(0,false)
this.selectrow(currentrow,true)

pid = this.getitemnumber(currentrow, "pos_id")
dw_detail.retrieve(pid)

end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

type gb_1 from groupbox within w_recruit_positionszzz
integer x = 114
integer y = 32
integer width = 2318
integer height = 396
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32233416
string text = "Filters"
end type

type st_1 from statictext within w_recruit_positionszzz
integer x = 1422
integer y = 144
integer width = 128
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "From"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_recruit_positionszzz
integer x = 1559
integer y = 132
integer width = 343
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_recruit_positionszzz
integer x = 1952
integer y = 144
integer width = 96
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "To"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_recruit_positionszzz
integer x = 2062
integer y = 132
integer width = 343
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

