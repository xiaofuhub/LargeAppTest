$PBExportHeader$u_tab_agreement_template.sru
forward
global type u_tab_agreement_template from u_tab
end type
type tabpage_1 from u_tabpg_agreement_template_browse within u_tab_agreement_template
end type
type tabpage_1 from u_tabpg_agreement_template_browse within u_tab_agreement_template
end type
type tabpage_2 from u_tabpg_agreement_template_detail within u_tab_agreement_template
end type
type tabpage_2 from u_tabpg_agreement_template_detail within u_tab_agreement_template
end type
end forward

global type u_tab_agreement_template from u_tab
integer width = 2619
integer height = 2104
long backcolor = 33551856
boolean fixedwidth = false
boolean ib_isupdateable = false
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
global u_tab_agreement_template u_tab_agreement_template

on u_tab_agreement_template.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
end on

on u_tab_agreement_template.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event constructor;call super::constructor;long ll_i
FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (CONTrol[LL_I], inv_resize.scale	 )
NEXT

end event

type tabpage_1 from u_tabpg_agreement_template_browse within u_tab_agreement_template
integer x = 18
integer y = 112
integer width = 2583
integer height = 1976
long backcolor = 33551856
end type

type tabpage_2 from u_tabpg_agreement_template_detail within u_tab_agreement_template
integer x = 18
integer y = 112
integer width = 2583
integer height = 1976
string text = "Template"
string picturename = "DosEdit5!"
boolean ib_isupdateable = true
end type

