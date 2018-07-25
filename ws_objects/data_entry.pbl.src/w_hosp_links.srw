$PBExportHeader$w_hosp_links.srw
forward
global type w_hosp_links from window
end type
type cb_1 from commandbutton within w_hosp_links
end type
type dw_1 from datawindow within w_hosp_links
end type
end forward

global type w_hosp_links from window
integer x = 1134
integer y = 740
integer width = 1733
integer height = 880
boolean titlebar = true
string title = "Set Hospital Links"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12639424
cb_1 cb_1
dw_1 dw_1
end type
global w_hosp_links w_hosp_links

on w_hosp_links.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_hosp_links.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;long li_hospid

li_hospid = message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve(li_hospid)
end event

type cb_1 from commandbutton within w_hosp_links
integer x = 667
integer y = 632
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;dw_1.update()
commit using sqlca;

close(parent)
end event

type dw_1 from datawindow within w_hosp_links
integer x = 123
integer y = 76
integer width = 1431
integer height = 528
integer taborder = 10
string dataobject = "d_hosp_facil_link_de"
boolean livescroll = true
end type

