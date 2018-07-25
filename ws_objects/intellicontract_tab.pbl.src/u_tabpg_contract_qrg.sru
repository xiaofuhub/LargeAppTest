$PBExportHeader$u_tabpg_contract_qrg.sru
$PBExportComments$[intellicontract_tab]  The contract locations Tab Page
forward
global type u_tabpg_contract_qrg from u_tabpg_contract_master
end type
type tab_1 from u_tab_qrg within u_tabpg_contract_qrg
end type
type tab_1 from u_tab_qrg within u_tabpg_contract_qrg
end type
type cb_1 from commandbutton within u_tabpg_contract_qrg
end type
end forward

global type u_tabpg_contract_qrg from u_tabpg_contract_master
integer width = 4027
integer height = 2268
string text = "QRG"
string powertiptext = "QRG"
event ue_set_tabpage_properties ( )
event ue_set_screen_properties ( )
tab_1 tab_1
cb_1 cb_1
end type
global u_tabpg_contract_qrg u_tabpg_contract_qrg

type variables
long		il_CurrView
end variables

forward prototypes
public function integer of_retrieve ()
public subroutine of_create_dw ()
end prototypes

event ue_set_tabpage_properties();long ll_FindRow
long ll_data_view_id

if not IsValid(gw_contract) then Return
ll_data_view_id = gw_contract.of_get_view_id()

// [Select Data] Set tabpage_selection property
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_qrg_select")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_selection, "selecttable!", "Select Data", "selecttable!")

// [Preview] Set tabpage_preview property
tab_1.tabpage_preview.backcolor = tab_1.tabpage_selection.backcolor
tab_1.tabpage_preview.tabbackcolor = tab_1.tabpage_selection.tabbackcolor
tab_1.tabpage_preview.cbx_1.backcolor = tab_1.tabpage_selection.backcolor
tab_1.tabpage_preview.st_1.backcolor = tab_1.tabpage_selection.backcolor
end event

event ue_set_screen_properties();// Set screen properties
tab_1.tabpage_selection.Event ue_set_screen_properties()
end event

public function integer of_retrieve ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  16 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



if not ib_retrieved then
	this.tab_1.tabpage_selection.of_retrieve( )
	 THIS.TAB_1.TABpage_selection.DW_requirements.event pfc_retrieve( )
	 
end if

ib_retrieved = true

RETURN SUCcess
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_qrgof_create_dw()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.28.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[]

ls_tab_name = 'tabpage_qrg'
ld_dw[1] = tab_1.tabpage_selection.dw_profile
ld_dw[2] = tab_1.tabpage_selection.dw_basic_info
ld_dw[3] = tab_1.tabpage_selection.dw_contact_info
ld_dw[4] = tab_1.tabpage_selection.dw_precert
ld_dw[5] = tab_1.tabpage_selection.dw_auth
ld_dw[6] = tab_1.tabpage_selection.dw_1
ld_dw[7] = tab_1.tabpage_selection.dw_2
ld_dw[8] = tab_1.tabpage_selection.dw_requirements
ls_dw_name[1] = 'dw_profile'
ls_dw_name[2] = 'dw_basic_info'
ls_dw_name[3] = 'dw_contact_info'
ls_dw_name[4] = 'dw_precert'
ls_dw_name[5] = 'dw_auth'
ls_dw_name[6] = 'dw_1'
ls_dw_name[7] = 'dw_2'
ls_dw_name[8] = 'dw_requirements'
ls_dataobject[1] = 'd_report_hdr'
ls_dataobject[2] = 'd_qrg_sys_fields'
ls_dataobject[3] = 'd_qrg_sys_fields'
ls_dataobject[4] = 'd_profile_codes'
ls_dataobject[5] = 'd_profile_codes'
ls_dataobject[6] = 'd_qrg_sys_fields'
ls_dataobject[7] = 'd_profile_codes'
ls_dataobject[8] = 'd_contract_profile_req_questions'
f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_qrg',true) 

this.event ue_set_screen_properties( )  //Jervis 08.17.2010
end subroutine

on u_tabpg_contract_qrg.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_1
end on

on u_tabpg_contract_qrg.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_1)
end on

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.28.2006 By: Liang QingShi
//$<reason>Contract module modification 
//of_create_dw()
//---------------------------- APPEON END ----------------------------

//this.event ue_set_screen_properties( )  //Jervis 08.17.2010
//this.event ue_set_tabpage_properties( )	//Jervis 08.17.2010
end event

event ue_set_security;call super::ue_set_security;//Add security control in child tab pages - by Alfee 09.30.2007
integer          li_index, li_count 
boolean lb_protect 
windowobject     lwo_temp[]
u_dw_contract    lst_temp

lwo_temp[1] = tab_1.tabpage_selection.dw_1
lwo_temp[2] = tab_1.tabpage_selection.dw_2
lwo_temp[3] = tab_1.tabpage_selection.dw_auth
lwo_temp[4] = tab_1.tabpage_selection.dw_basic_info
lwo_temp[5] = tab_1.tabpage_selection.dw_contact_info
lwo_temp[6] = tab_1.tabpage_selection.dw_precert
lwo_temp[7] = tab_1.tabpage_selection.dw_profile
lwo_temp[8] = tab_1.tabpage_selection.dw_requirements

//Get & set read only flag at tab page level
lb_protect = inv_contract_details.of_get_protect_tabpg()
			
//Set read only flag for each data window in the child tab page
li_count = UpperBound ( lwo_temp[] ) 
FOR li_index = 1 TO li_count 
   lst_temp = lwo_temp[li_index] 
	if lb_protect then
		lst_temp.of_disable_columns( ) 
	 else
		lst_temp.of_enable_columns( )
	end if 
NEXT

end event

event ue_initinstancevar;call super::ue_initinstancevar;il_CurrView = 0
end event

event ue_selectionchanged;call super::ue_selectionchanged;//Added By Alan on 2009-1-7 BugN101002
if IsValid(m_pfe_cst_mdi_menu_contract) then
	if tab_1.il_curindex = 3 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', False)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
	end if
end if
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_qrg
end type

type tab_1 from u_tab_qrg within u_tabpg_contract_qrg
integer width = 4027
integer height = 2264
integer taborder = 10
boolean bringtotop = true
end type

event selectionchanging;//


end event

type cb_1 from commandbutton within u_tabpg_contract_qrg
integer x = 329
integer y = 2352
integer width = 343
integer height = 92
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;open(w_qrg_painter)
end event

