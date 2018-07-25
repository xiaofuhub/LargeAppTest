$PBExportHeader$u_tabpg_contract_detail_linkprovider.sru
forward
global type u_tabpg_contract_detail_linkprovider from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_contract_detail_linkprovider
end type
end forward

global type u_tabpg_contract_detail_linkprovider from u_tabpg_contract_master
integer width = 2752
integer height = 564
dw_1 dw_1
end type
global u_tabpg_contract_detail_linkprovider u_tabpg_contract_detail_linkprovider

type variables
long il_ctx_id
Integer ii_accessright
end variables

on u_tabpg_contract_detail_linkprovider.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_contract_detail_linkprovider.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_set_security;call super::ue_set_security;IF ii_accessright = 1 THEN dw_1.of_disable_columns( ) //(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT101503,append readonly security control 


end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_detail_linkprovider
end type

type dw_1 from u_dw_contract within u_tabpg_contract_detail_linkprovider
integer x = 5
integer y = 8
integer width = 2743
integer height = 548
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_setupdateable( true)
this.of_setdropdowncalendar( true)
end event

event pfc_retrieve;call super::pfc_retrieve;
this.retrieve( il_ctx_id)

return success
end event

event pfc_addrow;//====================================================================
//$<Event>: pfc_addrow
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if ib_read_only then return success
long ll_row
long ic
long i
long li_prac_id
long li_find,li_nr

String ls_full_name

gs_search lstr_search
gs_batch_search ist_search

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF

ist_search = message.powerobjectparm


if not isvalid(message.powerobjectparm) then return 0

ic = upperbound(ist_search.li_prac_id[])

for i = 1 to ic
	
	li_prac_id = ist_search.li_prac_id[i] //maha 091605

	li_find = this.Find( "prac_id = " + String( li_prac_id ), 1, 1000 )
	
	IF li_find > 0 THEN
		continue
	END IF
	
	select full_name into :ls_full_name from v_full_name where prac_id = :li_prac_id;
	
	li_nr = this.InsertRow( 0 )
	
	this.SetItem( li_nr, "prac_id", li_prac_id )
	this.setitem( li_nr,'ctx_id',il_ctx_id)
	this.setitem( li_nr,'v_full_name_full_name',ls_full_name)
next

of_enable_save()
return SUCCESS
end event

event getfocus;call super::getfocus;//====================================================================
//$<Event>: getfocus
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.15.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if IsValid(m_pfe_cst_mdi_menu_contract) then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
end if

end event

event rbuttonup;if this.ib_read_only then return 

super::event rbuttonup(xpos,ypos,row,dwo)

return 1//Added by Appeon long.zhang 08.05.2014 (v14.2 BugH061601 add return 1)
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.24.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_i

for ll_i = 1 to this.rowcount( )
	if isnull(THIS.object.ctx_id[ll_i]) or THIS.object.ctx_id[ll_i] = 0 then
		this.object.ctx_id[ll_i] = gw_contract.tab_contract_details.tabpage_details.uo_1.DW_1.object.ctx_id[1]
	end if 
next

return success
end event

event doubleclicked;call super::doubleclicked;//Start Code Change ----07.19.2016 #V152 maha
long ll_prac

if row < 1 then return

ll_prac = this.getitemnumber(row,"prac_id")

of_open_prac_folder(ll_prac, 0)
end event

