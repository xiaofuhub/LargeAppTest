$PBExportHeader$w_company_info.srw
forward
global type w_company_info from window
end type
type cb_3 from commandbutton within w_company_info
end type
type dw_1 from datawindow within w_company_info
end type
type cb_2 from commandbutton within w_company_info
end type
type cb_1 from commandbutton within w_company_info
end type
end forward

global type w_company_info from window
integer x = 1056
integer y = 484
integer width = 2491
integer height = 920
boolean titlebar = true
string title = "Company Data"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_3 cb_3
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_company_info w_company_info

on w_company_info.create
this.cb_3=create cb_3
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_company_info.destroy
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;integer i

dw_1.settransobject(sqlca)
i = dw_1.retrieve()

if i = 0 then
	dw_1.insertrow(1)
	dw_1.setitem(1,"rec_id",1)
end if
end event

type cb_3 from commandbutton within w_company_info
boolean visible = false
integer x = 37
integer width = 151
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;open(w_dbconnect_info)
end event

type dw_1 from datawindow within w_company_info
integer x = 27
integer y = 136
integer width = 2418
integer height = 640
integer taborder = 30
string dataobject = "d_company_de"
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within w_company_info
integer x = 2162
integer y = 28
integer width = 279
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close (parent)
end event

type cb_1 from commandbutton within w_company_info
integer x = 1870
integer y = 28
integer width = 279
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_1.update()
commit using sqlca;
end event

