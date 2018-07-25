$PBExportHeader$u_tabpg_contract_detail_group_access.sru
$PBExportComments$Create by Ken 02/10/2009
forward
global type u_tabpg_contract_detail_group_access from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_contract_detail_group_access
end type
end forward

global type u_tabpg_contract_detail_group_access from u_tabpg_contract_master
integer width = 2757
integer height = 564
long backcolor = 33551856
dw_1 dw_1
end type
global u_tabpg_contract_detail_group_access u_tabpg_contract_detail_group_access

type variables
long il_ctx_id
integer ii_accessright //(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT101503,append readonly security control 
end variables

forward prototypes
public subroutine of_refresh_group ()
end prototypes

public subroutine of_refresh_group ();DatawindowChild ldwc_group
If dw_1.GetChild("group_id",ldwc_group) = 1 Then
	ldwc_group.SetTransObject(SQLCA)
	ldwc_group.Retrieve()
End If

end subroutine

on u_tabpg_contract_detail_group_access.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_contract_detail_group_access.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_set_security;call super::ue_set_security;IF ii_accessright = 1 THEN dw_1.of_disable_columns( ) //(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT101503,append readonly security control 


end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_detail_group_access
end type

type dw_1 from u_dw_contract within u_tabpg_contract_detail_group_access
event ue_addgroupaccess ( )
string tag = "Linked Contracts"
integer y = 8
integer width = 2747
integer height = 520
integer taborder = 10
boolean bringtotop = true
string title = "Linked Contracts"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
string dataobject_original = "d_sp_contract_search"
boolean ib_use_row_selection = true
boolean ib_allow_filter = true
boolean ib_allow_sort = true
end type

event ue_addgroupaccess();// auto add group access
DataStore			lds_group
Integer				li_i, li_Row, li_Find

//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
If ib_read_only Then Return //Added By Ken.Guo 12/29/2012
//---------End Added ------------------------------------------------------

lds_group = Create DataStore

lds_Group.DataObject = 'ds_contract_group_access'
lds_Group.SetTransObject( sqlca )

lds_Group.Retrieve( gs_user_id )

OF_ENABLE_SAVE()

For li_i = 1 To lds_Group.RowCount( )
	
	li_Find =	dw_1.Find( "group_id=" + string(  lds_Group.object.id[ li_i ] ) , 1, dw_1.RowCount() ) 
	If li_Find = 0  Then
	
		li_Row = dw_1.InsertRow( 0 )
		dw_1.SetItem( li_Row, 'group_id', lds_Group.object.id[ li_i ] )
		If lds_Group.object.selected[ li_i ] = 1 Then
			dw_1.SetItem( li_Row, 'access', 'F' )	
		Else
			dw_1.SetItem( li_Row, 'access', 'N' )	
		End If
		dw_1.SetItem( li_Row, 'view_id', gw_contract.of_get_view_id( ) )
		dw_1.SetItem( li_Row, 'ctx_id', il_ctx_id  )
	End If
Next





end event

event pfc_retrieve;call super::pfc_retrieve;//////////////////////////////////////////////////////////////////////
// $<event>u_tabpg_contract_detail_group_accessControl List()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.10.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////


DatawindowChild ldwc_view,ldwc_group

This.GetChild('group_id',ldwc_group)
This.GetChild('view_id',ldwc_view)
ldwc_group.SetTransObject(SQLCA)
ldwc_view.SetTransObject(SQLCA)
ldwc_group.Retrieve()
ldwc_view.Retrieve()

//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//Added By Ken.Guo 04/17/2013
Long ll_find
ll_find = ldwc_view.Find('isnull(data_view_id)', 1, ldwc_view.RowCount())
If ll_find > 0 Then
	ldwc_view.SetItem(ll_find, 'data_view_name','*Current Category View*')
End If
//---------End Added ------------------------------------------------------

Retrieve(il_ctx_id)

return success
end event

event rbuttonup;m_dw lm_dw
window lw_parent

IF THIS.ib_read_only THEN Return//(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT101503,append readonly security control 

lm_dw = create m_dw
lm_dw.of_SetParent (this)

//this.of_GetParentWindow (lw_parent) //Commented by (Appeon)Harry 03.10.2014 - V142 ISG-CLX
// DataWindow property entries. (isolate calls to shared variable)
this.event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
this.event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
if IsValid (inv_RowSelect) then inv_RowSelect.event pfc_rbuttonup (xpos, ypos, row, dwo)

//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//lm_dw.m_table.m_addrow.enabled = True
//lm_dw.m_table.m_delete.enabled = True
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'enabled', True)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'enabled', True)
//---------End Modfiied ------------------------------------------------------
lm_dw.m_table.m_autobatchaddgroupaccess.Visible = True

lm_dw.m_table.m_copy.visible = False
lm_dw.m_table.m_cut.visible = False
lm_dw.m_table.m_paste.visible = False
lm_dw.m_table.m_selectall.visible = False
lm_dw.m_table.m_saveaspdf.visible = False
lm_dw.m_table.m_email.visible = False
lm_dw.m_table.m_insert.visible = False
lm_dw.m_table.m_mailaspdf.visible = False
lm_dw.m_table.m_dash11.visible = False

// Popup menu
//lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
gnv_app.of_popmenu(this,lm_dw.m_table)//(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix the position of pop-menu

end event

event pfc_postinsertrow;call super::pfc_postinsertrow;//////////////////////////////////////////////////////////////////////
// $<event>dw_1::pfc_postinsertrow()
// $<arguments>
//		long	al_row		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.10.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

OF_ENABLE_SAVE()
This.SetItem(al_row, 'ctx_id',il_ctx_id )
end event

event getfocus;call super::getfocus;if IsValid(m_pfe_cst_mdi_menu_contract) then
	//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
	//m_pfe_cst_mdi_menu_contract.m_edit.m_insert.enabled = true
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
	//---------End Added ------------------------------------------------------
end if

end event

event constructor;call super::constructor;This.of_setupdateable( True)
Parent.of_refresh_group( )
end event

event pfc_validation;//////////////////////////////////////////////////////////////////////
// $<event>dw_1::pfc_validation()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.10.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i,j
Long ll_group_id
String ls_access
Boolean lb_duplicate


This.AcceptText()
If This.Modifiedcount( ) + This.DeletedCount() = 0 Then Return 1
For i = 1 To This.RowCount()
	ll_group_id = This.GetItemNumber(i,'group_id')
	If Isnull(ll_group_id) Then 
		Messagebox('Group Access Validation','Required value missing for Group on row '+String(i)+'.  Please enter a value.')
		This.SetColumn('group_id')
		This.SetRow(i)
		Return -1
	End If
	ls_access = This.GetItemString(i,'access')
	If Isnull(ls_access) Then
		Messagebox('Group Access Validation','Required value missing for Access on row '+String(i)+'.  Please enter a value.')
		This.SetColumn('access')
		This.SetRow(i)
		Return -1
	End If
Next

For i = 1 To This.RowCount()
	For j = 1 To This.RowCount()
		If i = j Then Continue
		If This.GetItemNumber(i,'group_id') = This.GetItemNumber(j,'group_id') Then
			lb_duplicate = True
			Exit
		End If
	Next
	If lb_duplicate = True Then Exit
Next
If lb_duplicate = True Then
	Messagebox('Group Access Validation','The existence of duplicate group, please check it.')
	This.SetColumn('group_id')
	This.SetRow(i)
	This.SelectRow(0,False)
	This.SelectRow(i,True)
	This.SelectRow(j,True)
	Return -1
End If

Return 1


end event

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////
// $<event>dw_1::itemchanged()
// $<arguments>
//		long    	row 		
//		dwobject	dwo 		
//		string  	data		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.10.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_null
Integer i
Boolean lb_duplicate
SetNull(ll_null)
If data = '' Then Return 0
If dwo.name = 'group_id' Then
	For i = 1 To This.RowCount()
		If i = row Then Continue
		If This.GetItemNumber(i,'Group_id') = Long(data) Then
			lb_duplicate = True
			Exit
		End If
	Next
	If Not lb_duplicate Then Return 0
	Messagebox('Group Access','Duplicate group, please select again.')
	Post AcceptText()
	Return 2
End If
Return 0
end event

event updateend;call super::updateend;//////////////////////////////////////////////////////////////////////
// $<event>dw_1::updateend()
// $<arguments>
//		long	rowsinserted		
//		long	rowsupdated 		
//		long	rowsdeleted 		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.12.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If isvalid(gw_contract) Then
	gw_contract.tab_contract_details.tabpage_search.of_refresh_ctx_view()
	gw_contract.tab_contract_details.tabpage_details.uo_1.Post of_change_screen()
End If
end event

event pfc_preupdate;call super::pfc_preupdate;//Added by Ken.guo 2011-08-26
long ll_i

for ll_i = 1 to this.rowcount( )
	if isnull(THIS.object.ctx_id[ll_i]) or THIS.object.ctx_id[ll_i] = 0 then
		this.object.ctx_id[ll_i] = gw_contract.tab_contract_details.tabpage_details.uo_1.DW_1.object.ctx_id[1]
	end if 
next

return success
end event

