$PBExportHeader$w_survey_painter.srw
forward
global type w_survey_painter from w_response
end type
type uo_survey from pfc_cst_u_site_survey within w_survey_painter
end type
end forward

global type w_survey_painter from w_response
integer x = 14
integer y = 32
integer width = 3698
integer height = 2680
string title = "Survey Design"
long backcolor = 33551856
uo_survey uo_survey
end type
global w_survey_painter w_survey_painter

on w_survey_painter.create
int iCurrent
call super::create
this.uo_survey=create uo_survey
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_survey
end on

on w_survey_painter.destroy
call super::destroy
destroy(this.uo_survey)
end on

event open;call super::open;uo_survey.of_set_parent_window ( This )
end event

type uo_survey from pfc_cst_u_site_survey within w_survey_painter
integer y = 8
integer width = 3648
integer height = 2540
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_survey.destroy
call pfc_cst_u_site_survey::destroy
end on

