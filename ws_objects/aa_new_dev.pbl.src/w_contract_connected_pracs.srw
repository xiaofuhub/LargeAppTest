$PBExportHeader$w_contract_connected_pracs.srw
forward
global type w_contract_connected_pracs from window
end type
type ddlb_5 from dropdownlistbox within w_contract_connected_pracs
end type
type ddlb_4 from dropdownlistbox within w_contract_connected_pracs
end type
type ddlb_3 from dropdownlistbox within w_contract_connected_pracs
end type
type cbx_4 from checkbox within w_contract_connected_pracs
end type
type ddlb_2 from dropdownlistbox within w_contract_connected_pracs
end type
type ddlb_1 from dropdownlistbox within w_contract_connected_pracs
end type
type cbx_5 from checkbox within w_contract_connected_pracs
end type
type cbx_3 from checkbox within w_contract_connected_pracs
end type
type cbx_2 from checkbox within w_contract_connected_pracs
end type
type cbx_1 from checkbox within w_contract_connected_pracs
end type
type st_1 from statictext within w_contract_connected_pracs
end type
type cb_5 from commandbutton within w_contract_connected_pracs
end type
type dw_pracs from datawindow within w_contract_connected_pracs
end type
type cb_4 from commandbutton within w_contract_connected_pracs
end type
type cb_3 from commandbutton within w_contract_connected_pracs
end type
type cb_2 from commandbutton within w_contract_connected_pracs
end type
type cb_1 from commandbutton within w_contract_connected_pracs
end type
type mle_1 from multilineedit within w_contract_connected_pracs
end type
end forward

global type w_contract_connected_pracs from window
integer width = 2130
integer height = 2116
boolean titlebar = true
string title = "Connected Practitioners for contract id -"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ddlb_5 ddlb_5
ddlb_4 ddlb_4
ddlb_3 ddlb_3
cbx_4 cbx_4
ddlb_2 ddlb_2
ddlb_1 ddlb_1
cbx_5 cbx_5
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
st_1 st_1
cb_5 cb_5
dw_pracs dw_pracs
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
end type
global w_contract_connected_pracs w_contract_connected_pracs

on w_contract_connected_pracs.create
this.ddlb_5=create ddlb_5
this.ddlb_4=create ddlb_4
this.ddlb_3=create ddlb_3
this.cbx_4=create cbx_4
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.cbx_5=create cbx_5
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.st_1=create st_1
this.cb_5=create cb_5
this.dw_pracs=create dw_pracs
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
this.Control[]={this.ddlb_5,&
this.ddlb_4,&
this.ddlb_3,&
this.cbx_4,&
this.ddlb_2,&
this.ddlb_1,&
this.cbx_5,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.st_1,&
this.cb_5,&
this.dw_pracs,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.mle_1}
end on

on w_contract_connected_pracs.destroy
destroy(this.ddlb_5)
destroy(this.ddlb_4)
destroy(this.ddlb_3)
destroy(this.cbx_4)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.cbx_5)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.dw_pracs)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
end on

type ddlb_5 from dropdownlistbox within w_contract_connected_pracs
integer x = 1431
integer y = 388
integer width = 411
integer height = 324
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"05/28/2010"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_4 from dropdownlistbox within w_contract_connected_pracs
integer x = 1426
integer y = 544
integer width = 411
integer height = 324
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"05/30/2011"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_3 from dropdownlistbox within w_contract_connected_pracs
integer x = 1426
integer y = 1068
integer width = 411
integer height = 324
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"Individual"}
borderstyle borderstyle = stylelowered!
end type

type cbx_4 from checkbox within w_contract_connected_pracs
integer x = 1335
integer y = 992
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cap Type"
boolean checked = true
end type

type ddlb_2 from dropdownlistbox within w_contract_connected_pracs
integer x = 1426
integer y = 888
integer width = 411
integer height = 324
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"25"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_contract_connected_pracs
integer x = 1426
integer y = 708
integer width = 411
integer height = 324
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"Pending"}
borderstyle borderstyle = stylelowered!
end type

type cbx_5 from checkbox within w_contract_connected_pracs
integer x = 1335
integer y = 812
integer width = 411
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Contract Type"
boolean checked = true
end type

type cbx_3 from checkbox within w_contract_connected_pracs
integer x = 1335
integer y = 644
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Status"
boolean checked = true
end type

type cbx_2 from checkbox within w_contract_connected_pracs
integer x = 1335
integer y = 472
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "End Date"
boolean checked = true
end type

type cbx_1 from checkbox within w_contract_connected_pracs
integer x = 1335
integer y = 324
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start Date"
boolean checked = true
end type

type st_1 from statictext within w_contract_connected_pracs
integer x = 1344
integer y = 204
integer width = 471
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fields to Add/Update"
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_contract_connected_pracs
integer x = 55
integer y = 1904
integer width = 279
integer height = 68
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

type dw_pracs from datawindow within w_contract_connected_pracs
integer x = 55
integer y = 160
integer width = 1083
integer height = 1728
integer taborder = 40
string title = "none"
string dataobject = "d_contract_connect_prac"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cb_4 from commandbutton within w_contract_connected_pracs
integer x = 571
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_3 from commandbutton within w_contract_connected_pracs
integer x = 1659
integer y = 32
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

type cb_2 from commandbutton within w_contract_connected_pracs
integer x = 1294
integer y = 32
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

type cb_1 from commandbutton within w_contract_connected_pracs
integer x = 928
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type mle_1 from multilineedit within w_contract_connected_pracs
integer x = 1193
integer y = 160
integer width = 841
integer height = 1732
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

