$PBExportHeader$u_tab_agreement_template_clause.sru
forward
global type u_tab_agreement_template_clause from u_tab
end type
type tabpage_1 from u_tabpg_agreement_template_clause_lib within u_tab_agreement_template_clause
end type
type tabpage_1 from u_tabpg_agreement_template_clause_lib within u_tab_agreement_template_clause
end type
type tabpage_2 from u_tabpg_agreement_template_clause_dtl within u_tab_agreement_template_clause
end type
type tabpage_2 from u_tabpg_agreement_template_clause_dtl within u_tab_agreement_template_clause
end type
end forward

global type u_tab_agreement_template_clause from u_tab
integer width = 1605
integer height = 2160
long backcolor = 33551856
boolean fixedwidth = false
boolean ib_isupdateable = false
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
global u_tab_agreement_template_clause u_tab_agreement_template_clause

on u_tab_agreement_template_clause.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
end on

on u_tab_agreement_template_clause.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from u_tabpg_agreement_template_clause_lib within u_tab_agreement_template_clause
integer x = 18
integer y = 112
integer width = 1568
integer height = 2032
long backcolor = 33551856
string text = "Clause Library"
string picturename = "Browse!"
end type

type tabpage_2 from u_tabpg_agreement_template_clause_dtl within u_tab_agreement_template_clause
integer x = 18
integer y = 112
integer height = 2032
long backcolor = 33551856
string text = "Clause Properties"
string picturename = "DosEdit5!"
end type

