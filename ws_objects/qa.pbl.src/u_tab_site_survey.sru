$PBExportHeader$u_tab_site_survey.sru
forward
global type u_tab_site_survey from u_tabpg
end type
type uo_1 from pfc_cst_u_site_survey_collect_dat within u_tab_site_survey
end type
end forward

global type u_tab_site_survey from u_tabpg
integer width = 3835
integer height = 1888
long backcolor = 16777215
string text = "Site Survey"
string picturename = "NestedReturn!"
uo_1 uo_1
end type
global u_tab_site_survey u_tab_site_survey

type variables

CONSTANT STRING IS_TITLE = 'Site Survey'

protected:

long il_prac_id
long il_zoom
end variables

forward prototypes
public subroutine of_set_prac_id (long al_prac_id)
end prototypes

public subroutine of_set_prac_id (long al_prac_id);


il_prac_id = al_prac_id
end subroutine

on u_tab_site_survey.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tab_site_survey.destroy
call super::destroy
destroy(this.uo_1)
end on

event constructor;call super::constructor;of_setresize( true)
end event

event resize;call super::resize;if isvalid(iw_parent) then
il_zoom  =  iw_parent.dynamic of_get_zoom_value()
this.uo_1.of_set_zoom(il_zoom)

end if 



end event

type uo_1 from pfc_cst_u_site_survey_collect_dat within u_tab_site_survey
integer width = 3744
integer height = 1868
integer taborder = 21
boolean border = false
end type

on uo_1.destroy
call pfc_cst_u_site_survey_collect_dat::destroy
end on

