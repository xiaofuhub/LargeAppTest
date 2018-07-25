$PBExportHeader$w_set_user_facility_security.srw
forward
global type w_set_user_facility_security from window
end type
type dw_u from datawindow within w_set_user_facility_security
end type
type cb_ok from commandbutton within w_set_user_facility_security
end type
type cb_1 from commandbutton within w_set_user_facility_security
end type
type dw_sec from datawindow within w_set_user_facility_security
end type
type st_facility from statictext within w_set_user_facility_security
end type
type st_1 from statictext within w_set_user_facility_security
end type
end forward

global type w_set_user_facility_security from window
integer width = 837
integer height = 2732
boolean titlebar = true
string title = "Set User Security"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_u dw_u
cb_ok cb_ok
cb_1 cb_1
dw_sec dw_sec
st_facility st_facility
st_1 st_1
end type
global w_set_user_facility_security w_set_user_facility_security

type variables
long il_facil
end variables

on w_set_user_facility_security.create
this.dw_u=create dw_u
this.cb_ok=create cb_ok
this.cb_1=create cb_1
this.dw_sec=create dw_sec
this.st_facility=create st_facility
this.st_1=create st_1
this.Control[]={this.dw_u,&
this.cb_ok,&
this.cb_1,&
this.dw_sec,&
this.st_facility,&
this.st_1}
end on

on w_set_user_facility_security.destroy
destroy(this.dw_u)
destroy(this.cb_ok)
destroy(this.cb_1)
destroy(this.dw_sec)
destroy(this.st_facility)
destroy(this.st_1)
end on

event open;//Start Code Change ----03.29.2011 #V11 maha - window created
long r
long rc
long ll_id
string ls_name


dw_u.settransobject(sqlca)
rc = dw_u.retrieve()
dw_sec.settransobject(sqlca)

il_facil = message.doubleparm



ll_id = gnv_app.of_get_id( "user_facility_id" ,rc)	 - 1

for r = 1 to rc
	ll_id++
	dw_sec.insertrow(0)
	dw_sec.setitem(r ,"facility_id",il_facil)
	dw_sec.setitem(r ,"user_id",dw_u.getitemstring(r,"user_id"))
	dw_sec.setitem(r ,"access_rights",0)
	dw_sec.setitem(r ,"user_facility_id",ll_id)
next

end event

type dw_u from datawindow within w_set_user_facility_security
boolean visible = false
integer x = 37
integer y = 124
integer width = 155
integer height = 88
integer taborder = 20
string title = "none"
string dataobject = "d_list_of_users"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_ok from commandbutton within w_set_user_facility_security
integer x = 215
integer y = 2544
integer width = 315
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Ok"
end type

event clicked;dw_sec.update()

close(parent)
end event

type cb_1 from commandbutton within w_set_user_facility_security
integer x = 494
integer y = 144
integer width = 288
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;integer s
long r

if this.text = "Select All" then
	s = 1
	this.text = "Deselect All" 
else
	s = 0
	this.text = "Select All" 
end if

for r = 1 to dw_sec.rowcount()
	dw_sec.setitem(r,"access_rights",s)
next
end event

type dw_sec from datawindow within w_set_user_facility_security
integer x = 9
integer y = 228
integer width = 805
integer height = 2304
integer taborder = 10
string title = "none"
string dataobject = "d_security_user_facility_add"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_facility from statictext within w_set_user_facility_security
boolean visible = false
integer x = 9
integer y = 80
integer width = 910
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_1 from statictext within w_set_user_facility_security
boolean visible = false
integer x = 32
integer y = 4
integer width = 471
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "User security for :"
boolean focusrectangle = false
end type

