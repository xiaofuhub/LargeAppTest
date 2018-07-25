$PBExportHeader$w_get_survey_name.srw
forward
global type w_get_survey_name from w_get_view_name
end type
end forward

global type w_get_survey_name from w_get_view_name
end type
global w_get_survey_name w_get_survey_name

on w_get_survey_name.create
call super::create
end on

on w_get_survey_name.destroy
call super::destroy
end on

type st_1 from w_get_view_name`st_1 within w_get_survey_name
string Text="Survey Name"
end type

