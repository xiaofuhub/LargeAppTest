$PBExportHeader$w_prac_data_mini_cred.srw
forward
global type w_prac_data_mini_cred from w_main
end type
type tab_2 from tab within w_prac_data_mini_cred
end type
type tabpage_4 from userobject within tab_2
end type
type tabpage_4 from userobject within tab_2
end type
type tabpage_5 from userobject within tab_2
end type
type tabpage_5 from userobject within tab_2
end type
type tabpage_6 from userobject within tab_2
end type
type tabpage_6 from userobject within tab_2
end type
type tabpage_7 from userobject within tab_2
end type
type tabpage_7 from userobject within tab_2
end type
type tab_2 from tab within w_prac_data_mini_cred
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type
end forward

global type w_prac_data_mini_cred from w_main
integer x = 9
integer y = 12
integer width = 3643
integer height = 2372
long backcolor = 12639424
tab_2 tab_2
end type
global w_prac_data_mini_cred w_prac_data_mini_cred

on w_prac_data_mini_cred.create
int iCurrent
call super::create
this.tab_2=create tab_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_2
end on

on w_prac_data_mini_cred.destroy
call super::destroy
destroy(this.tab_2)
end on

type tab_2 from tab within w_prac_data_mini_cred
integer x = 18
integer y = 20
integer width = 3470
integer height = 2040
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_2.create
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7}
end on

on tab_2.destroy
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

type tabpage_4 from userobject within tab_2
integer x = 18
integer y = 112
integer width = 3433
integer height = 1912
long backcolor = 79741120
string text = "Search"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_2
integer x = 18
integer y = 112
integer width = 3433
integer height = 1912
long backcolor = 79741120
string text = "Credentialing Data"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_6 from userobject within tab_2
integer x = 18
integer y = 112
integer width = 3433
integer height = 1912
long backcolor = 79741120
string text = "Verification Status"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_7 from userobject within tab_2
integer x = 18
integer y = 112
integer width = 3433
integer height = 1912
long backcolor = 79741120
string text = "Appointment Status"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

