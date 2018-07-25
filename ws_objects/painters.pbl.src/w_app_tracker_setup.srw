$PBExportHeader$w_app_tracker_setup.srw
forward
global type w_app_tracker_setup from window
end type
type cb_lookup from commandbutton within w_app_tracker_setup
end type
type cb_2 from commandbutton within w_app_tracker_setup
end type
type cb_save from commandbutton within w_app_tracker_setup
end type
type dw_track from u_dw within w_app_tracker_setup
end type
end forward

global type w_app_tracker_setup from window
integer width = 3822
integer height = 840
boolean titlebar = true
string title = "Application Tracking Setup"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_lookup cb_lookup
cb_2 cb_2
cb_save cb_save
dw_track dw_track
end type
global w_app_tracker_setup w_app_tracker_setup

type variables
integer ii_tracker = 1
end variables

forward prototypes
public function integer of_reset_lookup ()
end prototypes

public function integer of_reset_lookup ();//Start Code Change ----10.25.2016 #V153 maha
integer r
string ls_field
datawindowchild dwchild

for r = 1 to 10
	dw_track.getchild("step_" + string(r) + "_type", dwchild)
	dwchild.settransobject(sqlca)
	dwchild.retrieve()
next

return 1
end function

on w_app_tracker_setup.create
this.cb_lookup=create cb_lookup
this.cb_2=create cb_2
this.cb_save=create cb_save
this.dw_track=create dw_track
this.Control[]={this.cb_lookup,&
this.cb_2,&
this.cb_save,&
this.dw_track}
end on

on w_app_tracker_setup.destroy
destroy(this.cb_lookup)
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.dw_track)
end on

event open;//Start Code Change ----10.25.2016 #V153 maha - security for added button
if w_mdi.of_security_access(560) < 2 then
	cb_lookup.visible = false
end if
end event

type cb_lookup from commandbutton within w_app_tracker_setup
integer x = 55
integer y = 32
integer width = 347
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Action Types"
end type

event clicked;//Start Code Change ----10.25.2016 #V153 maha - added to access lookup list

cb_save.triggerevent(clicked!)
openwithparm(w_lookup_maint, "Action Type")
//after close re-retrieve
of_reset_lookup()
end event

type cb_2 from commandbutton within w_app_tracker_setup
integer x = 3406
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

type cb_save from commandbutton within w_app_tracker_setup
integer x = 3035
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

event clicked;dw_track.update()

gnv_data.of_retrieve('app_steps')  //Start Code Change ----05.04.2011 #V11 maha - reretrieve step data
end event

type dw_track from u_dw within w_app_tracker_setup
integer y = 160
integer width = 3771
integer height = 568
integer taborder = 10
string dataobject = "d_app_tracker_setup"
boolean hscrollbar = true
boolean vscrollbar = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.retrieve(1)
end event

