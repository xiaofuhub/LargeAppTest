$PBExportHeader$w_profile_report.srw
forward
global type w_profile_report from w_sheet
end type
type uo_profile from u_tabpg_contract_qrg within w_profile_report
end type
end forward

global type w_profile_report from w_sheet
integer width = 4087
integer height = 2376
string title = "Profile Report For Contract"
windowstate windowstate = maximized!
long backcolor = 33551856
uo_profile uo_profile
end type
global w_profile_report w_profile_report

on w_profile_report.create
int iCurrent
call super::create
this.uo_profile=create uo_profile
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_profile
end on

on w_profile_report.destroy
call super::destroy
destroy(this.uo_profile)
end on

event pfc_preopen;call super::pfc_preopen;long ll_i

this.of_SetResize( true)
this.inv_resize.of_setminsize( this.workspacewidth( ) ,this.workspaceheight( ) )
this.inv_resize.of_setorigsize(  this.workspacewidth( ) ,this.workspaceheight( ) )


FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (this.CONTrol[LL_I]  , this.inv_resize.scale	 )
NEXT
end event

event open;call super::open;//Set current contract id  when contract folder have been opened -- jervis 03.31.2011
long ll_ctx_id
if isvalid(gw_contract) then
	ll_ctx_id = gw_contract.tab_contract_details.tabpage_details.inv_contract_details.of_get_ctx_id( )
	if ll_ctx_id > 0 then
		this.uo_profile.tab_1.tabpage_preview.inv_contract_details.of_set_ctx_id( ll_ctx_id)
		
		this.uo_profile.of_retrieve( )
	end if
end if
end event

event activate;call super::activate;//Switch MDI menu while to do list window get the focus. - jervis 05.09.2011
if w_mdi.MenuName <> "m_pfe_cst_contract_profile" then
	w_mdi.ChangeMenu(m_pfe_cst_contract_profile)
	w_mdi.of_menu_security(w_mdi.MenuName)
end if


//Refresh contract id -- jervis 03.31.2011
long ll_ctx_id
if isvalid(gw_contract) then
	ll_ctx_id = gw_contract.tab_contract_details.tabpage_details.inv_contract_details.of_get_ctx_id( )
	if ll_ctx_id > 0 and ll_ctx_id <> this.uo_profile.tab_1.tabpage_preview.inv_contract_details.of_Get_Ctx_id( ) then
		this.uo_profile.tab_1.tabpage_preview.inv_contract_details.of_set_ctx_id( ll_ctx_id)
		this.uo_profile.tab_1.selectedtab = 1
	end if
end if

end event

event pfc_save;call super::pfc_save;//jervis 09.27.2011
If AncestorReturnValue >= 0 Then
	If isvalid(m_pfe_cst_contract_profile) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_profile.m_file.m_save,'enabled', false)
	End If	
End If

Return AncestorReturnValue


end event

type uo_profile from u_tabpg_contract_qrg within w_profile_report
integer x = 14
integer width = 4032
integer taborder = 100
end type

on uo_profile.destroy
call u_tabpg_contract_qrg::destroy
end on

