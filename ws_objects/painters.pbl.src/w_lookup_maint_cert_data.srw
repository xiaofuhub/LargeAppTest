$PBExportHeader$w_lookup_maint_cert_data.srw
forward
global type w_lookup_maint_cert_data from w_response
end type
type st_entity from statictext within w_lookup_maint_cert_data
end type
type cb_close from commandbutton within w_lookup_maint_cert_data
end type
type cb_ok from commandbutton within w_lookup_maint_cert_data
end type
type dw_1 from u_dw within w_lookup_maint_cert_data
end type
end forward

global type w_lookup_maint_cert_data from w_response
integer x = 214
integer y = 221
integer width = 4009
integer height = 1400
boolean titlebar = false
boolean controlmenu = false
boolean resizable = true
long backcolor = 33551856
st_entity st_entity
cb_close cb_close
cb_ok cb_ok
dw_1 dw_1
end type
global w_lookup_maint_cert_data w_lookup_maint_cert_data

type variables
long il_lu
end variables
on w_lookup_maint_cert_data.create
int iCurrent
call super::create
this.st_entity=create st_entity
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_entity
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_1
end on

on w_lookup_maint_cert_data.destroy
call super::destroy
destroy(this.st_entity)
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;gs_pass_ids lst_ids

lst_ids = message.powerobjectparm     

st_entity.text = lst_ids.ls_ref_value
il_lu = lst_ids.l_app_id

dw_1.settransobject(sqlca)
dw_1.retrieve(il_lu)

end event

type st_entity from statictext within w_lookup_maint_cert_data
integer x = 32
integer y = 24
integer width = 2665
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Entity"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_lookup_maint_cert_data
integer x = 3630
integer y = 28
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_lookup_maint_cert_data
integer x = 3291
integer y = 28
integer width = 320
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;dw_1.update()
close(parent)
end event

type dw_1 from u_dw within w_lookup_maint_cert_data
integer x = 5
integer y = 144
integer width = 3954
integer height = 1208
integer taborder = 10
string dataobject = "d_address_lookup_cert_period_sets"
end type

