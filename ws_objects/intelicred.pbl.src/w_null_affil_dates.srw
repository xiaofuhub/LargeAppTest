$PBExportHeader$w_null_affil_dates.srw
forward
global type w_null_affil_dates from window
end type
type cb_2 from commandbutton within w_null_affil_dates
end type
type cb_1 from commandbutton within w_null_affil_dates
end type
type dw_1 from datawindow within w_null_affil_dates
end type
end forward

global type w_null_affil_dates from window
integer x = 407
integer y = 452
integer width = 2811
integer height = 1176
boolean titlebar = true
string title = "Null Affiliation Date"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_null_affil_dates w_null_affil_dates

on w_null_affil_dates.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_null_affil_dates.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)

long prac
long rec
integer facil
Long ll_seq_no
string daparm
integer p1
integer p2
integer p3


daparm = message.stringparm

p1 = PosA(daparm,",",1)
p2 = PosA(daparm,",",p1 + 1)

rec = long(MidA(daparm,1,p1 - 1))
prac = long(MidA(daparm,p1 + 1,p2 - p1 ))
facil = integer(MidA(daparm,p2 + 1))


dw_1.retrieve(rec,prac,facil)





end event

type cb_2 from commandbutton within w_null_affil_dates
integer x = 1193
integer y = 948
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;dw_1.update()
commit using sqlca;


closewithreturn(parent,1)
end event

type cb_1 from commandbutton within w_null_affil_dates
integer x = 2313
integer y = 948
integer width = 247
integer height = 108
integer taborder = 20
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

type dw_1 from datawindow within w_null_affil_dates
integer x = 18
integer y = 32
integer width = 2743
integer height = 868
integer taborder = 10
string dataobject = "d_pd_affil_status_dates"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

