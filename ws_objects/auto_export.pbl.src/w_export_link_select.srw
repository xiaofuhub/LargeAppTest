$PBExportHeader$w_export_link_select.srw
forward
global type w_export_link_select from window
end type
type st_1 from statictext within w_export_link_select
end type
type ddlb_1 from dropdownlistbox within w_export_link_select
end type
type cb_2 from commandbutton within w_export_link_select
end type
type cb_1 from commandbutton within w_export_link_select
end type
end forward

global type w_export_link_select from window
integer x = 1056
integer y = 484
integer width = 1477
integer height = 692
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
st_1 st_1
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
end type
global w_export_link_select w_export_link_select

type variables
string is_mes = ""
end variables

on w_export_link_select.create
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.ddlb_1,&
this.cb_2,&
this.cb_1}
end on

on w_export_link_select.destroy
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> New feature for App Mapping Addition Filters
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.14.2009
//////////////////////////////////////////////////////////////////////

if Message.StringParm = "APPLICATION" then
	ddlb_1.Reset()
	ddlb_1.AddItem("pd_address_link_primary_office = 1")
	ddlb_1.AddItem("pd_address_link_additional_office = 1")
	ddlb_1.AddItem("pd_address_link_home_address = 1")
	ddlb_1.AddItem("pd_address_link_mailing = 1")
	ddlb_1.AddItem("pd_address_link_billing = 1")
	ddlb_1.AddItem("pd_hosp_facility_link_primary_hosp = 581")
	ddlb_1.AddItem("pd_spec_facility_link_practicing = 581")
end if
end event

type st_1 from statictext within w_export_link_select
integer x = 251
integer y = 12
integer width = 859
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select link field"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_export_link_select
integer x = 50
integer y = 96
integer width = 1358
integer height = 548
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"pd_address_link.primary_office = 1","pd_address_link.additional_office = 1","pd_address_link.home_address = 1","pd_address_link.mailing = 1","pd_address_link.billing = 1","pd_address_link.include_in_directory = 1","pd_hosp_facility_link.primary_hosp = 581","pd_spec_facility_link.practicing = 581"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;is_mes = this.text
cb_1.enabled = is_mes<>''
end event

type cb_2 from commandbutton within w_export_link_select
integer x = 1166
integer y = 556
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;closewithreturn(parent,"cancel")
end event

type cb_1 from commandbutton within w_export_link_select
integer x = 887
integer y = 556
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&OK"
end type

event clicked;closewithreturn(parent,is_mes)
end event

