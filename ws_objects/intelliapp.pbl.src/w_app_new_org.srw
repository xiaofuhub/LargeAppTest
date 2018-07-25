$PBExportHeader$w_app_new_org.srw
forward
global type w_app_new_org from window
end type
type st_text from statictext within w_app_new_org
end type
type st_2 from statictext within w_app_new_org
end type
type st_1 from statictext within w_app_new_org
end type
type cb_2 from commandbutton within w_app_new_org
end type
type cb_1 from commandbutton within w_app_new_org
end type
type dw_2 from datawindow within w_app_new_org
end type
end forward

global type w_app_new_org from window
integer x = 645
integer y = 576
integer width = 1490
integer height = 676
boolean titlebar = true
string title = "Change Application~'s Facility"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
st_text st_text
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
end type
global w_app_new_org w_app_new_org

type variables
integer ii_facil
end variables

on w_app_new_org.create
this.st_text=create st_text
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.Control[]={this.st_text,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_2}
end on

on w_app_new_org.destroy
destroy(this.st_text)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
end on

event open;integer li_facility
string ls_facil_name

//dw_2.settransobject(sqlca)
//DataWindowChild dwchild
//dw_2.retrieve()
//dw_2.insertrow(1)
//dw_2.GetChild( "facility_name", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve()

li_facility = message.doubleparm
ii_facil = li_facility

select facility_name into 
:ls_facil_name
from app_facility
where facility_id = :li_facility;

st_text.text = ls_facil_name

dw_2.retrieve()
end event

type st_text from statictext within w_app_new_org
integer x = 64
integer y = 148
integer width = 1321
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Facility"
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_app_new_org
integer x = 64
integer y = 296
integer width = 622
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "Select New Organization:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_app_new_org
integer x = 59
integer y = 80
integer width = 544
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Current Organization:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_app_new_org
integer x = 791
integer y = 476
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,0)
end event

type cb_1 from commandbutton within w_app_new_org
integer x = 530
integer y = 476
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Ok"
end type

event clicked;integer li_facil

//ii_facil = dw_2.getitemnumber(dw_2.getrow(),"facility_id")

//messagebox("facility id",ii_facil)



CloseWithReturn( Parent, ii_facil )
end event

type dw_2 from datawindow within w_app_new_org
integer x = 64
integer y = 352
integer width = 1330
integer height = 80
integer taborder = 10
string dataobject = "d_dddw_app_facil_select"
boolean border = false
boolean livescroll = true
end type

event constructor;DataWindowChild dwchild

this.settransobject (sqlca)
this.retrieve()
this.insertrow(1)

This.GetChild( "facility_name", dwchild )
dwchild.insertrow(1)
dwchild.setitem(1,"facility_name","")
end event

event itemchanged;ii_facil = integer(data)
end event

