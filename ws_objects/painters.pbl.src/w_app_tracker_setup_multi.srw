$PBExportHeader$w_app_tracker_setup_multi.srw
forward
global type w_app_tracker_setup_multi from window
end type
type cb_copy from commandbutton within w_app_tracker_setup_multi
end type
type cb_add from commandbutton within w_app_tracker_setup_multi
end type
type st_1 from statictext within w_app_tracker_setup_multi
end type
type dw_list from datawindow within w_app_tracker_setup_multi
end type
type cb_close from commandbutton within w_app_tracker_setup_multi
end type
type cb_save from commandbutton within w_app_tracker_setup_multi
end type
type dw_track from u_dw within w_app_tracker_setup_multi
end type
end forward

global type w_app_tracker_setup_multi from window
integer width = 3506
integer height = 940
boolean titlebar = true
string title = "Application Tracking Setup"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_copy cb_copy
cb_add cb_add
st_1 st_1
dw_list dw_list
cb_close cb_close
cb_save cb_save
dw_track dw_track
end type
global w_app_tracker_setup_multi w_app_tracker_setup_multi

type variables
long il_tracker
end variables

on w_app_tracker_setup_multi.create
this.cb_copy=create cb_copy
this.cb_add=create cb_add
this.st_1=create st_1
this.dw_list=create dw_list
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_track=create dw_track
this.Control[]={this.cb_copy,&
this.cb_add,&
this.st_1,&
this.dw_list,&
this.cb_close,&
this.cb_save,&
this.dw_track}
end on

on w_app_tracker_setup_multi.destroy
destroy(this.cb_copy)
destroy(this.cb_add)
destroy(this.st_1)
destroy(this.dw_list)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_track)
end on

event open;dw_track.retrieve(1)

dw_list.settransobject(sqlca)
dw_list.retrieve()

il_tracker = 1
end event

type cb_copy from commandbutton within w_app_tracker_setup_multi
integer x = 2720
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
string text = "Copy"
end type

event clicked;string s
long ll_null

s = dw_track.getitemstring(1,"tracker_name")

dw_track.rowscopy( 1, 1, primary!, dw_track, 1,primary!)
setnull(ll_null)
dw_track.setitem(1,"tracker_name", "Copy of " + s)
dw_track.setitem(1,"tracker_id", ll_null)

end event

type cb_add from commandbutton within w_app_tracker_setup_multi
integer x = 2368
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
string text = "Add"
end type

event clicked;dw_track.update()
dw_track.reset()
dw_track.insertrow(1)



end event

type st_1 from statictext within w_app_tracker_setup_multi
integer x = 14
integer y = 52
integer width = 466
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Tracker:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_list from datawindow within w_app_tracker_setup_multi
integer x = 480
integer y = 32
integer width = 1019
integer height = 92
integer taborder = 30
string title = "none"
string dataobject = "d_appl_tracker_names"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_tracker = long(data)
dw_track.retrieve(il_tracker)
end event

type cb_close from commandbutton within w_app_tracker_setup_multi
integer x = 3081
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
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_app_tracker_setup_multi
integer x = 2007
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;

if isnull(dw_track.getitemnumber(1,"tracker_id")) then
	select max(tracker_id) into:il_tracker from sys_appl_tracker;
	il_tracker++
	dw_track.setitem(1,"tracker_id",il_tracker)
end if

dw_track.update()

gnv_data.of_retrieve('app_steps')  //Start Code Change ----05.04.2011 #V11 maha - reretrieve step data
end event

type dw_track from u_dw within w_app_tracker_setup_multi
integer y = 148
integer width = 3456
integer height = 680
integer taborder = 10
string dataobject = "d_app_tracker_setup_15"
boolean hscrollbar = true
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.settransobject(sqlca)

end event

