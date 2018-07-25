$PBExportHeader$w_ctx_contact_cleanup.srw
forward
global type w_ctx_contact_cleanup from window
end type
type st_cnt from statictext within w_ctx_contact_cleanup
end type
type st_1 from statictext within w_ctx_contact_cleanup
end type
type dw_cont from datawindow within w_ctx_contact_cleanup
end type
type dw_facil from datawindow within w_ctx_contact_cleanup
end type
type cb_2 from commandbutton within w_ctx_contact_cleanup
end type
type cb_1 from commandbutton within w_ctx_contact_cleanup
end type
end forward

global type w_ctx_contact_cleanup from window
integer width = 946
integer height = 416
boolean titlebar = true
string title = "Add Contacts"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_cnt st_cnt
st_1 st_1
dw_cont dw_cont
dw_facil dw_facil
cb_2 cb_2
cb_1 cb_1
end type
global w_ctx_contact_cleanup w_ctx_contact_cleanup

on w_ctx_contact_cleanup.create
this.st_cnt=create st_cnt
this.st_1=create st_1
this.dw_cont=create dw_cont
this.dw_facil=create dw_facil
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_cnt,&
this.st_1,&
this.dw_cont,&
this.dw_facil,&
this.cb_2,&
this.cb_1}
end on

on w_ctx_contact_cleanup.destroy
destroy(this.st_cnt)
destroy(this.st_1)
destroy(this.dw_cont)
destroy(this.dw_facil)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type st_cnt from statictext within w_ctx_contact_cleanup
integer x = 453
integer y = 168
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ctx_contact_cleanup
integer x = 55
integer y = 168
integer width = 389
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contacts added:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_cont from datawindow within w_ctx_contact_cleanup
integer x = 233
integer y = 44
integer width = 87
integer height = 52
integer taborder = 30
string title = "none"
string dataobject = "d_ctx_contacts_4_company"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_facil from datawindow within w_ctx_contact_cleanup
integer x = 137
integer y = 44
integer width = 78
integer height = 64
integer taborder = 20
string title = "none"
string dataobject = "d_app_facil_name"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_ctx_contact_cleanup
integer x = 466
integer y = 24
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

event clicked;close( parent)
end event

type cb_1 from commandbutton within w_ctx_contact_cleanup
integer x = 82
integer y = 24
integer width = 343
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;long f
long fc
long i
long ic
long ll_facid
long id
long cnt
string ls_name

dw_facil.settransobject( sqlca)
dw_cont.settransobject( sqlca)
fc = dw_facil.retrieve()
select max(contact_id) into :id from ctx_contacts;

for f = 1 to fc
	ll_facid = dw_facil.getitemnumber(f,"facility_id")
	ic = dw_cont.retrieve(ll_facid )
	if ic = 0 then
		dw_cont.reset()
		i = dw_cont.insertrow(0)
		ls_name = dw_facil.getitemstring(f,"facility_name")
		id++
		dw_cont.setitem(i,"contact_id",id )
		dw_cont.setitem(i,"last_name",ls_name)
		dw_cont.setitem(i,"first_name","")
		dw_cont.setitem(i,"facility_id",ll_facid)
		dw_cont.update()
		cnt++
		st_cnt.text = string(cnt)
	end if
	
next
	
messagebox("Completed","Done")
end event

