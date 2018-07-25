$PBExportHeader$u_cst_gadget_contract_detail_detail.sru
forward
global type u_cst_gadget_contract_detail_detail from u_cst_gadget_contract
end type
type tab_1 from tab within u_cst_gadget_contract_detail_detail
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tab_1 from tab within u_cst_gadget_contract_detail_detail
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
end forward

global type u_cst_gadget_contract_detail_detail from u_cst_gadget_contract
string tag = "u_gadget_detail_contract_"
integer width = 2857
integer height = 588
tab_1 tab_1
end type
global u_cst_gadget_contract_detail_detail u_cst_gadget_contract_detail_detail

on u_cst_gadget_contract_detail_detail.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on u_cst_gadget_contract_detail_detail.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_resize_ini;call super::ue_resize_ini;

tab_1.x =  st_title.x
tab_1.y =  st_title.y
//tab_1.resize( dw_content.width, st_bottom.y - tab_1.y)

tab_1.width = dw_content.width
tab_1.height = st_bottom.y - tab_1.y
end event

event resize;call super::resize;
If ib_from_bottom = True then
	tab_1.height = st_bottom.y - tab_1.y
	tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height - 10
End If

end event

type st_bottom from u_cst_gadget_contract`st_bottom within u_cst_gadget_contract_detail_detail
end type

type dw_content from u_cst_gadget_contract`dw_content within u_cst_gadget_contract_detail_detail
boolean visible = false
end type

type st_1 from u_cst_gadget_contract`st_1 within u_cst_gadget_contract_detail_detail
end type

type st_title from u_cst_gadget_contract`st_title within u_cst_gadget_contract_detail_detail
end type

type pb_close from u_cst_gadget_contract`pb_close within u_cst_gadget_contract_detail_detail
end type

type pb_max from u_cst_gadget_contract`pb_max within u_cst_gadget_contract_detail_detail
end type

type pb_edit from u_cst_gadget_contract`pb_edit within u_cst_gadget_contract_detail_detail
end type

type cb_bg from u_cst_gadget_contract`cb_bg within u_cst_gadget_contract_detail_detail
end type

type ln_split from u_cst_gadget_contract`ln_split within u_cst_gadget_contract_detail_detail
end type

type tab_1 from tab within u_cst_gadget_contract_detail_detail
event resize pbm_size
integer x = 27
integer y = 24
integer width = 2807
integer height = 528
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 134217738
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

event resize;////Added By Mark Lee 01/17/2013
//tab_1.tabpage_1.dw_1.y = 0
//tab_1.tabpage_1.dw_1.x = 0
//tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height - 10
//tab_1.tabpage_1.dw_1.width = tab_1.tabpage_1.width - 10
end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2770
integer height = 412
long backcolor = 134217738
string text = "Custom Data "
long tabtextcolor = 33554432
long tabbackcolor = 134217738
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within tabpage_1
integer width = 2766
integer height = 408
integer taborder = 11
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2770
integer height = 412
long backcolor = 134217738
string text = "Custom Data2 "
long tabtextcolor = 33554432
long tabbackcolor = 134217738
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2770
integer height = 412
long backcolor = 134217738
string text = "Notes "
long tabtextcolor = 33554432
long tabbackcolor = 134217738
long picturemaskcolor = 536870912
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2770
integer height = 412
long backcolor = 134217738
string text = "Linked Contracts "
long tabtextcolor = 33554432
long tabbackcolor = 134217738
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2770
integer height = 412
long backcolor = 134217738
string text = "Group Access "
long tabtextcolor = 33554432
long tabbackcolor = 134217738
long picturemaskcolor = 536870912
end type

