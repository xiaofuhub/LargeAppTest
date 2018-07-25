$PBExportHeader$w_cpt_painter.srw
$PBExportComments$[IntelliContract_w]
forward
global type w_cpt_painter from w_response
end type
type p_1 from picture within w_cpt_painter
end type
type tab_1 from u_tab_cpt within w_cpt_painter
end type
type tab_1 from u_tab_cpt within w_cpt_painter
end type
end forward

global type w_cpt_painter from w_response
integer width = 4206
integer height = 2188
string title = "CPT Code Management"
long backcolor = 33551856
event ue_open_for_selection ( )
p_1 p_1
tab_1 tab_1
end type
global w_cpt_painter w_cpt_painter

type variables
string is_doc_path
nvo_commdlg invo_commdlg

boolean ib_add_new_codes_only
boolean ib_update_existing = true

end variables

event ue_open_for_selection();/******************************************************************************************************************
**  [PUBLIC]   : event ue_open_for_selection( )
**==================================================================================================================
**  Purpose   	: Sets unneeded tabs to invisable
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 27 Febuary 2006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


THIS.TAB_1.SELecttab('tabpage_3')
THIS.TAB_1.TABpage_1.Visible = FALSE
THIS.TAB_1.TABpage_2.Visible = FALSE
THIS.TAB_1.TABpage_3.dw_master.SETfocus( )
this.tab_1.tabpage_3.event ue_prep_selection( )

end event

on w_cpt_painter.create
int iCurrent
call super::create
this.p_1=create p_1
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.tab_1
end on

on w_cpt_painter.destroy
call super::destroy
destroy(this.p_1)
destroy(this.tab_1)
end on

event pfc_postopen;call super::pfc_postopen;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 27 Febuary 2006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
** MSKINNER                 13 nmARCH 2006  ADDED - this.tab_1.tabpage_3.inv_contract_details = LSTR_PASS.S_po[1]
********************************************************************************************************************/
STR_PASS LSTR_PASS 



if not isnull(message.powerobjectparm)  then 
	
	LSTR_PASS = message.powerobjectparm
	
	IF NOT ISVALID(LSTR_PASS) THEN RETURN 
	this.tab_1.tabpage_3.idw_fee_schedule = LSTR_PASS.s_u_dw
	this.tab_1.tabpage_3.inv_contract_details = LSTR_PASS.S_po[1]
	IF LSTR_PASS.s_u_dw.dataobject = 'd_ctx_schedule_fee_detail' THEN
	 //this.tab_1.tabpage_3.idw_fee_schedule = message.powerobjectparm
	 
	 event ue_open_for_selection( )
	
    END IF 
end if
end event

type p_1 from picture within w_cpt_painter
integer x = 4082
integer y = 8
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Help!"
boolean focusrectangle = false
end type

event clicked;openwithparm(w_ctx_help,'cpt_help')
end event

type tab_1 from u_tab_cpt within w_cpt_painter
integer x = 23
integer y = 12
integer width = 4133
integer height = 2060
integer taborder = 11
end type

