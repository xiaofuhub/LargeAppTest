$PBExportHeader$u_tabpg_contract_multi_detail.sru
$PBExportComments$[intellicontract_tab] The non medical fee schedule tab
forward
global type u_tabpg_contract_multi_detail from u_tabpg_contract_master
end type
type dw_browse from u_dw_contract within u_tabpg_contract_multi_detail
end type
type dw_detail from u_dw_contract within u_tabpg_contract_multi_detail
end type
end forward

global type u_tabpg_contract_multi_detail from u_tabpg_contract_master
integer width = 3922
integer height = 2032
string text = "Detail"
string powertiptext = "Custom multi detail"
event ue_open_work ( )
event ue_sort ( )
event ue_set_screen_properties ( )
dw_browse dw_browse
dw_detail dw_detail
end type
global u_tabpg_contract_multi_detail u_tabpg_contract_multi_detail

type variables

end variables

forward prototypes
public function integer of_retrieve ()
public function long of_get_next_hdr_id ()
public function long of_get_next_detail_id (integer ai_count)
public subroutine of_set_flag (u_dw adw_alm)
end prototypes

event ue_open_work();

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 

str_pass istr_pass 
istr_pass.s_po[1] = inv_contract_details
istr_pass.w_parent_window = iw_parent
istr_pass.s_string = 'contract'

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.19.2006 By: Liang QingShi
//$<reason> Fix a defect.
If appeongetclienttype() <> 'PB' Then
	istr_pass.s_u_dw = dw_detail
end if

//---------------------------- APPEON END ----------------------------

//OpenSheetWithParm ( w_req_work, istr_pass , w_mdi  )
openwithparm(w_req_work,istr_pass)
end event

event ue_sort();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.16.2007 By: Jack 
//$<reason> Fix a defect.
dw_detail.setsort( "ctx_req_tmplt_element_ctx_req_profile_id A,ctx_req_tmplt_element_ctx_rqmnt_category_id A,element_sort A")
dw_detail.sort()
//---------------------------- APPEON END ----------------------------

end event

event ue_set_screen_properties();// Set screen properties
dw_browse.of_set_properties(dw_browse.il_ViewID, dw_browse.il_ScreenID, "Y")
dw_detail.of_set_properties(dw_detail.il_ViewID, dw_detail.il_ScreenID, "Y")
end event

public function integer of_retrieve ();

/******************************************************************************************************************
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
	dw_browse.event pfc_retrieve( )
   dw_detail.event pfc_retrieve( )
end if

ib_retrieved = true





return success
end function

public function long of_get_next_hdr_id ();//of_get_next_hdr_id

long ll_hdr_id

return gnv_app.of_get_id('multi_ID')


end function

public function long of_get_next_detail_id (integer ai_count);return gnv_app.of_get_id('multi_ID',ai_count)

end function

public subroutine of_set_flag (u_dw adw_alm);long	ll_hdr_id,ll_detail_id
long	ll_ctx_id
string ls_customscreen[]
long ll_i,ll_count
long ll_k,ll_colcount

if dw_browse.getrow( ) < 1 then return
ll_hdr_id = dw_browse.GetitemNumber( dw_browse.Getrow(), 'hdr_id')
ll_ctx_id = inv_contract_details.of_get_ctx_id( )


ll_count = adw_alm.rowcount()
	
//Refresh ctx_custom_mulit_hdr alarm flag -- jervis 07.04.2011
ls_customscreen = {'custom_date1','custom_date2','custom_date3','custom_date4','custom_date5'}

ll_colcount = UpperBound(ls_customscreen)
FOR ll_i = 1 to ll_count
	ll_detail_id = adw_alm.GetItemNumber( ll_i,'detail_id')
	for ll_k = 1 to ll_colCount
		adw_alm.SetItem( ll_i, ls_customscreen[ll_k] + "_flag", f_set_ai_flag('ctx_custom_multi_detail', ls_customscreen[ll_k],ll_ctx_id,0, ll_hdr_id ,ll_detail_id))
	next
	adw_alm.SetItemStatus(ll_i, 0, Primary!, NotModified!)	
NEXT

adw_alm.Post setredraw(true) //for PB refresh bug - 03.11.2008 


end subroutine

on u_tabpg_contract_multi_detail.create
int iCurrent
call super::create
this.dw_browse=create dw_browse
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_browse
this.Control[iCurrent+2]=this.dw_detail
end on

on u_tabpg_contract_multi_detail.destroy
call super::destroy
destroy(this.dw_browse)
destroy(this.dw_detail)
end on

event ue_selectionchanged;call super::ue_selectionchanged;//dw_detail.setfocus( )	//Commented by Scofield on 2010-03-22

if dw_browse.RowCount() <= 0 then
	dw_browse.Post SetFocus()
else
	dw_detail.Post SetFocus()
end if

end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_multi_detail
integer x = 416
integer y = 1912
integer width = 3369
integer height = 64
end type

event st_1::constructor;call super::constructor;

text = ''
end event

type dw_browse from u_dw_contract within u_tabpg_contract_multi_detail
string tag = "Custom multi header"
integer width = 3858
integer height = 620
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Custom multi header"
boolean hscrollbar = true
boolean livescroll = false
string dataobject_original = "d_profile_header"
end type

event pfc_retrieve;call super::pfc_retrieve;/******************************************************************************************************************
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


this.retrieve(inv_contract_details.of_get_ctx_id( ) )

//if this.rowcount() < 1 then
//	event pfc_insertrow( )
//	event ue_populatedddws( )
//	return 0         // Add by Jack 04.30.2007
//end if

return success

end event

event constructor;call super::constructor;this.ib_rmbmenu = false	//04/25/2007 By Jervis
this.of_setupdateable( false)
//this.of_setlinkage( true)
//this.of_SetRowManager(TRUE)

end event

event pfc_deleterow;long ll_Cycle,ll_CurRow,ll_RtnVal

ll_CurRow = dw_browse.GetRow()
If ll_CurRow = 0 Then Return 1

If of_check_read_only( ) Then Return failure  //Add by Jack 07.17.2007

ll_RtnVal = MessageBox('Delete', 'Are you sure you want to delete the record?',question!,Yesno!,2)

If ll_RtnVal  = 1 then
	For ll_Cycle = dw_detail.RowCount() to 1 step -1
		dw_detail.deleterow(ll_Cycle)
	Next
	
	dw_browse.deleterow(ll_CurRow)
	gnv_appeondb.of_startqueue( )	
	dw_detail.update()
	dw_browse.update()
	gnv_appeondb.of_commitqueue( )

	If dw_browse.RowCount() < 1 Then
	else
		if dw_browse.GetRow() = ll_CurRow then
			dw_browse.Event RowFocusChanged(ll_CurRow)
		end if
	End If
Else
	Return -1
End If

Return 1

end event

event rowfocuschanged;call super::rowfocuschanged;long ll_hdr_id
if CurrentRow > 0 and CurrentRow <= This.RowCount() then
	ll_hdr_id = this.GetItemNumber( currentrow, 'hdr_id')
	This.SelectRow(0,false)
	This.SelectRow(CurrentRow,true)
	dw_detail.Event pfc_Retrieve()
	if isvalid(m_pfe_cst_mdi_menu_contract) then
		if ll_hdr_id >=0 then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)
		end if
	end if
else
	dw_detail.Reset() //Added by Ken.Guo 2009-07-24
	if isvalid(m_pfe_cst_mdi_menu_contract) then m_pfe_cst_mdi_menu_contract.m_edit.m_insert.enabled = false
end if

end event

event getfocus;call super::getfocus;//if IsValid(m_pfe_cst_mdi_menu_contract) then
//	//m_pfe_cst_mdi_menu_contract.m_edit.m_insert.enabled = True
//	
//	if This.RowCount() > 0 then
//		m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.enabled = true
//	else
//		m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.enabled = false
//	end if
//	
//	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.visible = True //Added By Ken.Guo 2009-07-21.
//	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.visible = True
//	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.toolbaritemvisible = True //Added By Ken.Guo 2009-07-21.
//	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.toolbaritemvisible = True	
//end if
//
end event

event losefocus;call super::losefocus;//if IsValid(m_pfe_cst_mdi_menu_contract) then
//	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.enabled = false
//	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.enabled = false
//	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.visible = false //Modified By Ken.Guo 2009-07-21
//	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.visible = false
//	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.toolbaritemvisible = false //Modified By Ken.Guo 2009-07-21
//	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.toolbaritemvisible = false	
//end if

end event

event rowfocuschanging;call super::rowfocuschanging;long		ll_Cycle,ll_Count,ll_Row,ll_Rtn
Boolean	lb_ModiFlag

window	lw_Parent

DWItemStatus	ldw_Status

dw_detail.AcceptText()


ll_Count = dw_browse.RowCount()
if ll_Count <= 0 then Return 0


//Check the dw_detail if had modified
ll_Count = dw_detail.RowCount()
for ll_Cycle = 1 to ll_Count
	ldw_Status = dw_detail.GetItemStatus(ll_Cycle,0,Primary!)
	if ldw_Status = newmodified! or ldw_Status = datamodified! then
		lb_ModiFlag = true
		exit
	end if
next


if lb_ModiFlag then
	ll_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,"Do you want to save changes?", exclamation!, YesNoCancel!,1)
	if ll_Rtn = 1 then
		of_GetParentWindow(lw_Parent)
		if IsValid(lw_Parent) then
			if lw_Parent.Dynamic Event pfc_save() < 0 then
				Return 1
			end if
		end if
	elseif ll_Rtn = 2 then
		if isvalid(m_pfe_cst_mdi_menu_contract) then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', false)
		end if
	elseif ll_Rtn = 3 then
		return 1
	end if
end if

end event

event pfc_addrow;//BEGIN---Modify by Scofield on 2010-03-22
dw_detail.Event pfc_AddRow()

Return Success
//END---Modify by Scofield on 2010-03-22
end event

event clicked;call super::clicked;//Added By Ken.Guo 06/19/2012
If Row> 0 and row <> GetRow() Then
	This.SetRow(Row)
	This.ScrollToRow(Row)
End If


end event

type dw_detail from u_dw_contract within u_tabpg_contract_multi_detail
string tag = "Custom multi detail"
integer y = 632
integer width = 3858
integer height = 1288
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Custom multi detail"
boolean hscrollbar = true
boolean livescroll = false
string dataobject_original = "d_contract_profile_req2"
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(TRUE)
//this.iuo_calendar.of_Register("date_value", this.iuo_calendar.DDLB_WITHARROW	)

//Added By Mark Lee 06/01/12 open menu function
//this.ib_rmbmenu = false	//04/25/2007 By Jervis

of_enable_alarm(TRUE)
end event

event pfc_retrieve;call super::pfc_retrieve;//Retrieve detail data - jervis 05.31.2011

If dw_browse.RowCount() < 1 then 
	dw_detail.Reset() //Added by Ken.Guo 2009-07-24
	return success
End If

long	ll_hdr_id,ll_detail_id
long	ll_ctx_id
string ls_customscreen[]
long ll_i,ll_count
long ll_k,ll_colcount

ll_hdr_id = dw_browse.GetitemNumber( dw_browse.Getrow(), 'hdr_id')
ll_ctx_id = inv_contract_details.of_get_ctx_id( )


ll_count = This.Retrieve(inv_contract_details.of_get_ctx_id( ),ll_hdr_id)
	
//Refresh ctx_custom_mulit_hdr alarm flag -- jervis 07.04.2011
of_set_flag(this)
return ll_count

end event

event pfc_preupdate;call super::pfc_preupdate;//Set detail ID - jervis 05.31.2011
long ll_Cycle
long ll_count
long ll_detail_id
long ll_hdr_id

ll_count = this.rowcount( )
if ll_count < 1 then Return SUCCESS
If dw_browse.RowCount() < 1 Then Return SUCCESS

ll_hdr_id = dw_browse.GetItemNumber( dw_browse.GetRow(),"hdr_id")
ll_detail_id = of_get_next_detail_id(ll_count)

for ll_Cycle = 1 to This.RowCount()
	if this.GetItemStatus( ll_cycle,0,primary!) = NewModified! then
		this.SetItem( ll_cycle, 'ctx_id', inv_contract_details.Of_get_ctx_id( ))
		this.SetItem(ll_cycle,'hdr_id',ll_hdr_id)
		this.SetItem( ll_cycle,'detail_id',ll_detail_id)
		ll_detail_id = ll_detail_id + 1
	end if
next

Return SUCCESS

end event

event losefocus;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.24.2007 By: Jack
//$<reason> Fix a defect.
this.title = this.tag
//---------------------------- APPEON END ----------------------------

end event

event getfocus;call super::getfocus;////Added By Ken.Guo 2009-07-24.
//if IsValid(m_pfe_cst_mdi_menu_contract) then
//	//m_pfe_cst_mdi_menu_contract.m_edit.m_insert.enabled = true
//	
//	if dw_browse.RowCount() > 0 then
//		m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.enabled = true
//	else
//		m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.enabled = false
//	end if
//	
//	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.visible = true
//	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.visible = true
//	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.toolbaritemvisible = true
//	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.toolbaritemvisible = true
//end if
//
end event

event buttonclicked;call super::buttonclicked;//Add ability to put alarms on all custom date fields -- jervis 06.27.2011
if of_check_read_only( ) then return success 
this.SetRow( row)
inv_contract_details.of_set_alarm( this,'ctx_custom_multi_detail', dwo)

//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
of_set_flag( this  )//added by gavins 20121217
//---------End Added ------------------------------------------------------
end event

event rbuttondown;call super::rbuttondown;inv_contract_details.of_reset_alarm( this,'ctx_custom_multi_detail',dwo) //jervis 07.04.2011
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//Added By Ken.Guo 05/08/2012. Check & Reset Date Alarm Status.
Long ll_ctx_id,ll_level_id1,ll_level_id2
n_cst_date_alarm lnv_date_alarm
If row <= 0 Then Return 
If dwoname = '' Then Return
If getrow() <= 0 Then Return  //(Appeon)Harry 12.20.2013 - V141 for BugH112901 of IntelliContract History Issues
ll_ctx_id = inv_contract_details.of_get_ctx_id()

ll_level_id1 = getitemnumber(getrow(),'hdr_id')
ll_level_id2 = getitemnumber(getrow(),'detail_id')

If Describe(dwoname + '.ColType') = 'datetime' Then
	If This.GetItemDateTime(row, dwoname, Primary!, True) = This.GetItemDateTime(row, dwoname, Primary!, False)  Then
		//Do nothing
	Else
		lnv_date_alarm.of_reset_alart_status( 'ctx_custom_multi_detail', dwoname,ll_ctx_id, 0,ll_level_id1,ll_level_id2)
	End If
End If

end event

event pfc_postinsertrow;call super::pfc_postinsertrow;gnv_data.of_insert_main_data( dw_browse,dw_detail,'ctx_custom_multi_hdr',dw_browse.GetRow(),al_row)			//Added By Mark Lee 11/27/2012
end event

event pfc_addrow;//---------Begin Modified by (Appeon)Harry 11.29.2013 V141 for BugH082202 of IntelliContract History Issues--------
//Cancel Extend 
long ll_hdr_id

if dw_browse.getrow( ) <= 0 then 
	messagebox('Prompt', 'Please firstly add the records and then save in the Header tab page.')
	return 0
end if
ll_hdr_id = dw_browse.GetItemNumber(dw_browse.getrow( ), 'hdr_id')
if isnull(ll_hdr_id) then ll_hdr_id = 0
if ll_hdr_id <= 0 then return 0

super :: event pfc_addrow( )
//---------End Modfiied ------------------------------------------------------
end event

