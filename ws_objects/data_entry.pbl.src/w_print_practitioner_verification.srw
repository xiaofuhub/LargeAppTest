$PBExportHeader$w_print_practitioner_verification.srw
$PBExportComments$Create by Jack 10/10/2006
forward
global type w_print_practitioner_verification from w_response
end type
type cb_2 from commandbutton within w_print_practitioner_verification
end type
type cb_1 from commandbutton within w_print_practitioner_verification
end type
type uo_1 from pfc_cst_u_profile within w_print_practitioner_verification
end type
end forward

global type w_print_practitioner_verification from w_response
integer width = 3570
integer height = 1924
string title = "Print Practitioner Profile"
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
uo_1 uo_1
end type
global w_print_practitioner_verification w_print_practitioner_verification

type variables
string is_type

end variables

on w_print_practitioner_verification.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_1
end on

on w_print_practitioner_verification.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;call super::open;str_prac_id lstr_prac_id
string ls_type

lstr_prac_id = message.powerobjectparm

uo_1.of_set_prac_id(lstr_prac_id.prac_id)
uo_1.of_set_facility_id(lstr_prac_id.facility_id)

uo_1.of_set_view_id(lstr_prac_id.view_id)//Added by Nova on 10.07.2008

ls_type = lstr_prac_id.types
is_type = ls_type

if ls_type = 'P' then
	this.title = 'Print Practitioner Profile'	
	uo_1.tab_report.tabpage_verification.visible = false
	uo_1.of_run_profile()
else
	this.title = 'Print Verification Profile'
	uo_1.tab_report.post SelectTab(2)
	uo_1.tab_report.tabpage_profile.visible = false
	uo_1.of_run_verification()	
end if

uo_1.st_1.Hide() //Add by Evan 12.13.2010
end event

type cb_2 from commandbutton within w_print_practitioner_verification
integer x = 3136
integer y = 1712
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

event clicked;close(parent)

end event

type cb_1 from commandbutton within w_print_practitioner_verification
integer x = 2793
integer y = 1712
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;IF is_type = 'P' THEN
	uo_1.tab_report.tabpage_profile.dw_profile.Print()
ELSE
	uo_1.tab_report.tabpage_verification.dw_verification.Print()	
END IF

end event

type uo_1 from pfc_cst_u_profile within w_print_practitioner_verification
integer taborder = 20
long backcolor = 33551856
end type

on uo_1.destroy
call pfc_cst_u_profile::destroy
end on

