$PBExportHeader$uo_user_assignments.sru
forward
global type uo_user_assignments from userobject
end type
type cbx_appl from checkbox within uo_user_assignments
end type
type cbx_wf from checkbox within uo_user_assignments
end type
type cbx_track from checkbox within uo_user_assignments
end type
type cbx_verif from checkbox within uo_user_assignments
end type
type cbx_appt from checkbox within uo_user_assignments
end type
type dw_wf from datawindow within uo_user_assignments
end type
type dw_tracking from datawindow within uo_user_assignments
end type
type st_1 from statictext within uo_user_assignments
end type
type cb_save from commandbutton within uo_user_assignments
end type
type dw_user from datawindow within uo_user_assignments
end type
type dw_verif from datawindow within uo_user_assignments
end type
type dw_appt from datawindow within uo_user_assignments
end type
type dw_appl from datawindow within uo_user_assignments
end type
end forward

global type uo_user_assignments from userobject
integer width = 4187
integer height = 2444
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cbx_appl cbx_appl
cbx_wf cbx_wf
cbx_track cbx_track
cbx_verif cbx_verif
cbx_appt cbx_appt
dw_wf dw_wf
dw_tracking dw_tracking
st_1 st_1
cb_save cb_save
dw_user dw_user
dw_verif dw_verif
dw_appt dw_appt
dw_appl dw_appl
end type
global uo_user_assignments uo_user_assignments

type variables
integer il_w
integer il_h
end variables

forward prototypes
public function integer resize (integer w, integer h)
public function integer of_dw_vis (string as_type)
public function integer of_resize (integer al_w, integer al_h)
public function integer of_retrieve_data ()
end prototypes

public function integer resize (integer w, integer h);//Start Code Change ----06.12.2017 #V154 maha
integer li_w
integer li_h
integer li_edge
integer li_split
integer li_top = 188

this.width = w
this.height = h

il_w = this.width
il_h = this.height

of_resize(il_w, il_h)


return 1


//
//li_edge = 600 + 20
//
//if rb_all.checked then
//	li_split = (h - 188)  / 3  - 10
//else
//	li_split = h - 188 -10
//end if
//
//li_h = li_split
//
////appt
//if dw_appt.visible = true then
//	dw_appt.x = li_edge
//	dw_appt.width = w - li_edge
//
//	dw_appt.height = li_h
//	dw_user.height = li_h
//end if
//
////verif
//if dw_verif.visible = true then	
//	if rb_all.checked then
//		li_edge = 5
//		li_top =  (h - 188) / 3 + 188 + 10
//		li_w = w / 2 - 10
//		li_split = li_h * 2
//	else
//		li_split = li_h
//		li_h = li_h * 2
//		li_w = w - li_edge
//	end if
//	dw_verif.x = li_edge
//	dw_verif.width = li_w
//	
//	dw_verif.y = li_top 
//	dw_verif.height = li_split
//	dw_user.height = li_h
//end if
//
////appl
//if dw_appl.visible = true then	
//	if rb_all.checked then
//		li_edge = w / 2 + 10
//		li_top =  (h - 188) / 3 + 188 + 10  
//		li_w = w / 2 - 10
//		li_split = li_h * 2
//	else
//		li_split = li_h
//		li_w = w - li_edge
//	end if
//	dw_appl.x = li_edge
//	dw_appl.width = li_w
//	
//	dw_appl.y = li_top  
//	dw_appl.height = li_split 
//	dw_user.height = li_h
//end if
//
//
//
//
//
//return 1
//
//
//
//
end function

public function integer of_dw_vis (string as_type);//Start Code Change ----06.12.2017 #V154 maha

//choose case as_type
//	case "ALL"
//		dw_appt.visible = true
//		dw_appl.visible = true
//		dw_verif.visible = true
//	case "APPL"
//		dw_appt.visible = false
//		dw_appl.visible = true
//		dw_verif.visible = false		
//	case "APPT"
//		dw_appt.visible = true
//		dw_appl.visible = false
//		dw_verif.visible = false
//	case "VER"
//		dw_appt.visible = false
//		dw_appl.visible = false
//		dw_verif.visible = true
//		
//end choose
//
//resize(width , height)

return 1
end function

public function integer of_resize (integer al_w, integer al_h);//Start Code Change ----06.12.2017 #V154 maha
integer li_w
integer li_h
integer li_edge
integer li_split
integer li_top = 188
integer cnt
integer r
datawindow ldw_type[]

this.width = al_w
this.height = al_h

li_edge = 600 + 20
li_w = al_w - li_edge

if cbx_appt.checked then 
	cnt++
	ldw_type[cnt] = dw_appt
else
	dw_appt.visible = false
end if

if cbx_verif.checked then 
	cnt++
	ldw_type[cnt] = dw_verif
else
	dw_verif.visible = false
end if

if cbx_wf.checked then 
	cnt++
	ldw_type[cnt] = dw_wf
else
	dw_wf.visible = false
end if

if cbx_track.checked then 
	cnt++
	ldw_type[cnt] = dw_tracking
else
	dw_tracking.visible = false
end if

if cbx_appl.checked then 
	cnt++
	ldw_type[cnt] = dw_appl
else
	dw_appl.visible = false
end if

if cnt = 0 then return 1

li_split  = (al_h - li_top ) / cnt - 10

dw_user.height = al_h - li_top



for r = 1 to cnt
	ldw_type[r].visible = true
	ldw_type[r].y = li_top
	ldw_type[r].width = li_w
	ldw_type[r].height = li_split
	li_top = li_split + li_top + 10
next












//
//
//
//
//
//
//
//if rb_all.checked then
//	li_split = (al_h - 188)  / 3  - 10
//else
//	li_split = al_h - 188 -10
//end if
//
//li_h = li_split
//
////appt
//if dw_appt.visible = true then
//	dw_appt.x = li_edge
//	dw_appt.width = al_w - li_edge
//
//	dw_appt.height = li_h
//	dw_user.height = li_h
//end if
//
////verif
//if dw_verif.visible = true then	
//	if rb_all.checked then
//		li_edge = 5
//		li_top =  (al_h - 188) / 3 + 188 + 10
//		li_w = al_w / 2 - 10
//		li_split = li_h * 2
//	else
//		li_split = li_h
//		li_h = li_h * 2
//		li_w = al_w - li_edge
//	end if
//	dw_verif.x = li_edge
//	dw_verif.width = li_w
//	
//	dw_verif.y = li_top 
//	dw_verif.height = li_split
//	dw_user.height = li_h
//end if
//
////appl
//if dw_appl.visible = true then	
//	if rb_all.checked then
//		li_edge = al_w / 2 + 10
//		li_top =  (al_h - 188) / 3 + 188 + 10  
//		li_w = al_w / 2 - 10
//		li_split = li_h * 2
//	else
//		li_split = li_h
//		li_w = al_w - li_edge
//	end if
//	dw_appl.x = li_edge
//	dw_appl.width = li_w
//	
//	dw_appl.y = li_top  
//	dw_appl.height = li_split 
//	dw_user.height = li_h
//end if

return 1
end function

public function integer of_retrieve_data ();
dw_appl.retrieve()
dw_appt.retrieve()
dw_wf.retrieve()
dw_verif.retrieve()
dw_tracking.retrieve()

return 1
end function

on uo_user_assignments.create
this.cbx_appl=create cbx_appl
this.cbx_wf=create cbx_wf
this.cbx_track=create cbx_track
this.cbx_verif=create cbx_verif
this.cbx_appt=create cbx_appt
this.dw_wf=create dw_wf
this.dw_tracking=create dw_tracking
this.st_1=create st_1
this.cb_save=create cb_save
this.dw_user=create dw_user
this.dw_verif=create dw_verif
this.dw_appt=create dw_appt
this.dw_appl=create dw_appl
this.Control[]={this.cbx_appl,&
this.cbx_wf,&
this.cbx_track,&
this.cbx_verif,&
this.cbx_appt,&
this.dw_wf,&
this.dw_tracking,&
this.st_1,&
this.cb_save,&
this.dw_user,&
this.dw_verif,&
this.dw_appt,&
this.dw_appl}
end on

on uo_user_assignments.destroy
destroy(this.cbx_appl)
destroy(this.cbx_wf)
destroy(this.cbx_track)
destroy(this.cbx_verif)
destroy(this.cbx_appt)
destroy(this.dw_wf)
destroy(this.dw_tracking)
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.dw_user)
destroy(this.dw_verif)
destroy(this.dw_appt)
destroy(this.dw_appl)
end on

type cbx_appl from checkbox within uo_user_assignments
integer x = 2734
integer y = 56
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Applications"
boolean checked = true
end type

event clicked;of_resize(il_w, il_h)
end event

type cbx_wf from checkbox within uo_user_assignments
integer x = 1883
integer y = 56
integer width = 338
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Workflow"
boolean checked = true
end type

event clicked;of_resize(il_w, il_h)
end event

type cbx_track from checkbox within uo_user_assignments
integer x = 2267
integer y = 56
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Appl Tracking"
boolean checked = true
end type

event clicked;of_resize(il_w, il_h)
end event

type cbx_verif from checkbox within uo_user_assignments
integer x = 1422
integer y = 56
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Verifications"
boolean checked = true
end type

event clicked;of_resize(il_w, il_h)
end event

type cbx_appt from checkbox within uo_user_assignments
integer x = 974
integer y = 56
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Appointments"
boolean checked = true
end type

event clicked;of_resize(il_w, il_h)

end event

type dw_wf from datawindow within uo_user_assignments
integer x = 617
integer y = 1084
integer width = 3557
integer height = 444
integer taborder = 30
boolean titlebar = true
string title = "Workflow"
string dataobject = "d_user_wf_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_tracking from datawindow within uo_user_assignments
integer x = 617
integer y = 1536
integer width = 3557
integer height = 444
integer taborder = 30
boolean titlebar = true
string title = "Appl Tracking"
string dataobject = "d_user_tracking_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type st_1 from statictext within uo_user_assignments
boolean visible = false
integer x = 3813
integer y = 68
integer width = 334
integer height = 92
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 255
string text = "Close"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_save from commandbutton within uo_user_assignments
integer x = 3383
integer y = 68
integer width = 334
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

type dw_user from datawindow within uo_user_assignments
integer x = 5
integer y = 188
integer width = 599
integer height = 2248
integer taborder = 10
boolean titlebar = true
string title = "Users"
string dataobject = "d_user_list_cred_w_inactive"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

event rowfocuschanged;this.selectrow(0, false)
this.selectrow(currentrow, true)
end event

event clicked;integer r

r = this.getclickedrow()

this.setrow(r)
end event

type dw_verif from datawindow within uo_user_assignments
integer x = 617
integer y = 636
integer width = 3557
integer height = 444
integer taborder = 20
boolean titlebar = true
string title = "Verifications"
string dataobject = "d_user_verif_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_appt from datawindow within uo_user_assignments
integer x = 617
integer y = 188
integer width = 3557
integer height = 444
integer taborder = 10
boolean titlebar = true
string title = "Appointments"
string dataobject = "d_user_appt_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_appl from datawindow within uo_user_assignments
integer x = 617
integer y = 1988
integer width = 3557
integer height = 444
integer taborder = 10
boolean titlebar = true
string title = "Application Actions"
string dataobject = "d_user_appl_actions_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

