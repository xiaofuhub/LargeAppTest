$PBExportHeader$u_tab_cpt.sru
$PBExportComments$[intellicontract_tab]  The action Items Tab on the action items window
forward
global type u_tab_cpt from u_tab
end type
type tabpage_2 from u_tabpg_cpt_import within u_tab_cpt
end type
type tabpage_2 from u_tabpg_cpt_import within u_tab_cpt
end type
type tabpage_1 from u_tabpg_cpt_maint within u_tab_cpt
end type
type tabpage_1 from u_tabpg_cpt_maint within u_tab_cpt
end type
type tabpage_3 from u_tabpg_cpt_template within u_tab_cpt
end type
type tabpage_3 from u_tabpg_cpt_template within u_tab_cpt
end type
end forward

global type u_tab_cpt from u_tab
integer width = 4128
integer height = 2064
long backcolor = 33551856
tabpage_2 tabpage_2
tabpage_1 tabpage_1
tabpage_3 tabpage_3
end type
global u_tab_cpt u_tab_cpt

on u_tab_cpt.create
this.tabpage_2=create tabpage_2
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_1
this.Control[iCurrent+3]=this.tabpage_3
end on

on u_tab_cpt.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_1)
destroy(this.tabpage_3)
end on

type tabpage_2 from u_tabpg_cpt_import within u_tab_cpt
integer x = 18
integer y = 112
integer width = 4091
integer height = 1936
long backcolor = 33551856
end type

type tabpage_1 from u_tabpg_cpt_maint within u_tab_cpt
integer x = 18
integer y = 112
integer width = 4091
integer height = 1936
long backcolor = 33551856
end type

type tabpage_3 from u_tabpg_cpt_template within u_tab_cpt
integer x = 18
integer y = 112
integer width = 4091
string text = "Fee Templates"
end type

