$PBExportHeader$w_export_progress_appeon.srw
forward
global type w_export_progress_appeon from window
end type
type hpb_bar from hprogressbar within w_export_progress_appeon
end type
type hpb_1 from hprogressbar within w_export_progress_appeon
end type
type st_merge from statictext within w_export_progress_appeon
end type
type st_6 from statictext within w_export_progress_appeon
end type
type st_export1 from statictext within w_export_progress_appeon
end type
type cb_send from u_cb within w_export_progress_appeon
end type
type st_export from statictext within w_export_progress_appeon
end type
type st_progress from statictext within w_export_progress_appeon
end type
type r_bar from rectangle within w_export_progress_appeon
end type
end forward

global type w_export_progress_appeon from window
integer x = 1056
integer y = 484
integer width = 1646
integer height = 880
boolean enabled = false
windowtype windowtype = popup!
long backcolor = 33551856
hpb_bar hpb_bar
hpb_1 hpb_1
st_merge st_merge
st_6 st_6
st_export1 st_export1
cb_send cb_send
st_export st_export
st_progress st_progress
r_bar r_bar
end type
global w_export_progress_appeon w_export_progress_appeon

on w_export_progress_appeon.create
this.hpb_bar=create hpb_bar
this.hpb_1=create hpb_1
this.st_merge=create st_merge
this.st_6=create st_6
this.st_export1=create st_export1
this.cb_send=create cb_send
this.st_export=create st_export
this.st_progress=create st_progress
this.r_bar=create r_bar
this.Control[]={this.hpb_bar,&
this.hpb_1,&
this.st_merge,&
this.st_6,&
this.st_export1,&
this.cb_send,&
this.st_export,&
this.st_progress,&
this.r_bar}
end on

on w_export_progress_appeon.destroy
destroy(this.hpb_bar)
destroy(this.hpb_1)
destroy(this.st_merge)
destroy(this.st_6)
destroy(this.st_export1)
destroy(this.cb_send)
destroy(this.st_export)
destroy(this.st_progress)
destroy(this.r_bar)
end on

type hpb_bar from hprogressbar within w_export_progress_appeon
integer x = 78
integer y = 640
integer width = 1413
integer height = 64
unsignedinteger maxposition = 100
integer setstep = 10
boolean smoothscroll = true
end type

type hpb_1 from hprogressbar within w_export_progress_appeon
boolean visible = false
integer x = 78
integer y = 780
integer width = 1413
integer height = 64
unsignedinteger maxposition = 100
integer setstep = 10
boolean smoothscroll = true
end type

type st_merge from statictext within w_export_progress_appeon
boolean visible = false
integer x = 82
integer y = 716
integer width = 722
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Progress of merging data"
boolean focusrectangle = false
end type

type st_6 from statictext within w_export_progress_appeon
integer x = 82
integer y = 576
integer width = 722
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Progress"
boolean focusrectangle = false
end type

type st_export1 from statictext within w_export_progress_appeon
integer x = 105
integer y = 360
integer width = 1317
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type cb_send from u_cb within w_export_progress_appeon
integer x = 398
integer y = 1076
integer width = 471
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
string text = "Send To Committee"
boolean default = true
end type

event clicked;//
//Integer li_bar_ticks
//
//
//ldt_todaysDate = DateTime( Today() )
//
//
//
//r_bar.Width = 1
//
//li_bar_ticks = 1000 / li_prac_cnt
//
//
//r_bar.Width = r_bar.Width + li_bar_ticks
//







end event

type st_export from statictext within w_export_progress_appeon
integer x = 105
integer y = 236
integer width = 1353
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type st_progress from statictext within w_export_progress_appeon
integer x = 105
integer y = 84
integer width = 1376
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type r_bar from rectangle within w_export_progress_appeon
boolean visible = false
integer linethickness = 4
long fillcolor = 12639424
integer x = 1541
integer y = 740
integer width = 59
integer height = 92
end type

