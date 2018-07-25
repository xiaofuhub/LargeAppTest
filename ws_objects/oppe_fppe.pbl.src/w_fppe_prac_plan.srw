$PBExportHeader$w_fppe_prac_plan.srw
forward
global type w_fppe_prac_plan from w_master
end type
type uo_plan from uo_fppe_plan_setup_prac within w_fppe_prac_plan
end type
end forward

global type w_fppe_prac_plan from w_master
integer width = 4654
integer height = 2648
string title = "FPPE Plan for "
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
uo_plan uo_plan
end type
global w_fppe_prac_plan w_fppe_prac_plan

on w_fppe_prac_plan.create
int iCurrent
call super::create
this.uo_plan=create uo_plan
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_plan
end on

on w_fppe_prac_plan.destroy
call super::destroy
destroy(this.uo_plan)
end on

event open;call super::open;//Start Code Change ----11.22.2011 #V12 maha - created
string ls_pass
string ls_name
string ls_from
long ll_fppe
long p1
long p2

ls_pass = message.stringparm

p1 = pos(ls_pass, "@")
p2 = pos(ls_pass, "&")

ls_name = mid(ls_pass, 1, p1 -1)
ls_from = mid(ls_pass, p2 +1)
ll_fppe = long(mid(ls_pass, p1 +1, p2 - p1 -1 ))

if ls_from = "PRAC" then
	this.title = " FPPE plan for: " + ls_name
	uo_plan.of_get_hdr( ll_fppe)
else
	
end if

uo_plan.of_setup(ls_from)




end event

event closequery;return 0
end event

type uo_plan from uo_fppe_plan_setup_prac within w_fppe_prac_plan
integer x = 55
integer y = 44
integer taborder = 10
end type

on uo_plan.destroy
call uo_fppe_plan_setup_prac::destroy
end on

