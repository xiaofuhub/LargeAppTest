$PBExportHeader$u_tabpg_contract_requirements.sru
$PBExportComments$[intellicontract_tab]  The contract Requirements Tab Page
forward
global type u_tabpg_contract_requirements from u_tabpg_contract_master
end type
type dw_2 from u_dw_contract within u_tabpg_contract_requirements
end type
type dw_req_det from u_dw_contract within u_tabpg_contract_requirements
end type
type cb_1 from u_cb within u_tabpg_contract_requirements
end type
type cb_2 from commandbutton within u_tabpg_contract_requirements
end type
end forward

global type u_tabpg_contract_requirements from u_tabpg_contract_master
integer width = 3931
integer height = 2084
string text = "Requirements"
string powertiptext = "Requirements"
event ue_open_work ( )
event ue_sort ( )
event ue_set_screen_properties ( )
dw_2 dw_2
dw_req_det dw_req_det
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_contract_requirements u_tabpg_contract_requirements

type variables
n_ds ids_profile
long ll_orig_band_hight
long il_profile_id
boolean ib_new
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Jack 
//$<reason> 
boolean ib_plus
boolean ib_Collapse //jervis 09.22.2011
long il_row = 1
//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 2009-07-01.
Long il_deleted_elements_id[],il_empty[]
Long il_deleted_reqmnt_id[]
String il_deleted_filed_name[]
end variables

forward prototypes
public function integer of_retrieve ()
public function long of_get_next_prf_hdr_id ()
public function integer of_add_missing ()
public function integer of_refresh_dropdown ()
public subroutine of_create_dw ()
public function integer of_lookup_search (string as_lookup_search_column_table)
public function long of_get_next_element_id ()
public subroutine of_change_status (string as_status)
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
	istr_pass.s_u_dw = dw_req_det
end if

//---------------------------- APPEON END ----------------------------

//OpenSheetWithParm ( w_req_work, istr_pass , w_mdi  )
openwithparm(w_req_work,istr_pass)
end event

event ue_sort();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.16.2007 By: Jack 
//$<reason> Fix a defect.
dw_req_det.setsort( "ctx_req_tmplt_element_ctx_req_profile_id A,ctx_req_tmplt_element_ctx_rqmnt_category_id A,element_sort A")
dw_req_det.sort()
//---------------------------- APPEON END ----------------------------

end event

event ue_set_screen_properties();// Set screen properties
dw_2.of_set_properties(dw_2.il_ViewID, dw_2.il_ScreenID, "Y")
dw_req_det.of_set_properties(dw_req_det.il_ViewID, dw_req_det.il_ScreenID, "Y")
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
	dw_2.event pfc_retrieve( )
   dw_req_det.event pfc_retrieve( )
end if

ib_retrieved = true





return success
end function

public function long of_get_next_prf_hdr_id ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_next_prf_hdr_id
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
long ll_hdr_id

select max(CTX_REQ_PROFILE_HDR_ID)
into :ll_hdr_id
from CTX_REQ_PROFILE_HDR;

if not f_validstr(string(ll_hdr_id)) then
	ll_hdr_id = 1 
else 
	ll_hdr_id =  ll_hdr_id + 1
end if

return ll_hdr_id
end function

public function integer of_add_missing ();/******************************************************************************************************************
**  [PUBLIC]   : of_add_missing
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  10 May 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long 		ll_i,ll_j
long 		ll_new_row,li_measuremtent_id,ll_next_element_id,ll_templ_element_id
long 		ll_templ_element_id_existing	/* already in the current datawindow*/

long		ll_New_element_sort,ll_Old_element_sort
long		ll_New_value_type,ll_Old_value_type
long 		ll_find,ll_ctx_req_profile_id,ll_ctx_rqmnt_category_id
Integer 	li_new_show_ico,li_old_show_ico

String	ls_New_Element_Name,ls_Old_Element_Name
String	ls_New_dddw_name,ls_Old_dddw_name
String	ls_New_category_name,ls_Old_category_name
String 	ls_find

Boolean	lb_found,lb_NeedSave,lb_DispTip

dw_2.AcceptText()
if dw_2.RowCount( ) < 1 then Return success

dw_req_det.SetreDraw(false)

//////////////////////////////////////////////////////////////////////////////////////
// get the next element id
//////////////////////////////////////////////////////////////////////////////////////

ll_next_element_id = of_get_next_element_id()
ll_next_element_id = ll_next_element_id - 1

//////////////////////////////////////////////////////////////////////////////////////
// get the profile and loop through it
//////////////////////////////////////////////////////////////////////////////////////

ids_profile.Retrieve(dw_2.getItemNumber(dw_2.GetRow(),'ctx_req_profile_id'))

for ll_i = 1 to ids_profile.RowCount()
	lb_found = false
	
	ll_templ_element_id = ids_profile.getitemnumber(ll_i,'ctx_req_tmplt_element_id')
	ll_ctx_req_profile_id = ids_profile.getitemnumber(ll_i,'ctx_req_profile_id')
	ll_ctx_rqmnt_category_id = ids_profile.getitemnumber(ll_i,'ctx_rqmnt_category_id')
	ls_find = "ctx_req_tmplt_element_id = " + string(ll_templ_element_id) + " and ctx_req_tmplt_element_ctx_req_profile_id = " + string(ll_ctx_req_profile_id) + " and ctx_req_tmplt_element_ctx_rqmnt_category_id = " + string(ll_ctx_rqmnt_category_id)
	ll_find = dw_req_det.find(ls_find,1,dw_req_det.RowCount())
	
	if ll_find > 0 then
		ls_New_Element_Name = ids_profile.GetItemString(ll_i,"element_name")
		ls_Old_Element_Name = dw_req_det.GetItemString(ll_find,"element_name")
		if ls_New_Element_Name <> ls_Old_Element_Name then
			dw_req_det.SetItem(ll_find, "element_name",ls_New_Element_Name)
			lb_NeedSave = true
		end if
		
		ll_New_element_sort = ids_profile.GetItemNumber(ll_i,"element_sort")
		ll_Old_element_sort = dw_req_det.GetItemNumber(ll_find,"element_sort")
		if ll_New_element_sort <> ll_Old_element_sort then
			dw_req_det.SetItem(ll_find,"element_sort",ll_New_element_sort)
			lb_NeedSave = true
		end if
		
		ll_New_value_type = ids_profile.GetItemNumber(ll_i,"value_type")
		ll_Old_value_type = dw_req_det.GetItemNumber(ll_find,"value_type")
		if ll_New_value_type <> ll_Old_value_type then
			dw_req_det.SetItem(ll_find,"value_type",ll_New_value_type)
			lb_NeedSave = true
		end if
		
		ls_New_dddw_name = ids_profile.GetItemString(ll_i,"dddw_name")
		ls_Old_dddw_name = dw_req_det.GetItemString(ll_find,"dddw_name")
		if ls_New_dddw_name <> ls_Old_dddw_name then
			dw_req_det.SetItem(ll_find,"dddw_name",ls_New_dddw_name)
			lb_NeedSave = true
		end if
		
		ls_New_category_name = ids_profile.GetItemString(ll_i,"category_name")
		ls_Old_category_name = dw_req_det.GetItemString(ll_find,"category_name")
		if ls_New_dddw_name <> ls_Old_dddw_name then
			dw_req_det.SetItem(ll_find,"category_name",ls_New_category_name)
			lb_NeedSave = true
		end if
		
		//Added By Ken.Guo 2011-01-05.
		li_New_show_ico = ids_profile.GetItemNumber(ll_i,"show_word_ico")
		li_Old_show_ico = dw_req_det.GetItemNumber(ll_find,"ctx_req_tmplt_element_show_word_ico")		
		if li_New_show_ico <> li_Old_show_ico then
			dw_req_det.SetItem(ll_find,"show_word_ico",li_New_show_ico)
			lb_NeedSave = true
		end if
		
		lb_found = true
	 end if 
	
	if not lb_found then
		lb_DispTip = true
		ll_new_row = dw_req_det.insertrow(0)		
	   ll_next_element_id = ll_next_element_id + 1
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 01.18.2007 By: Jack (Document Manager)
		//$<reason> Fix a defect.
		/*
		dw_req_det.OBJECT.elements_id[ll_new_row] =  ll_next_element_id
		dw_req_det.OBJECT.ctx_req_profile_hdr_id[ll_new_row] = DW_2.OBJECT.ctx_req_profile_hdr_id[1]
		*/
		dw_req_det.setitem(ll_new_row,'elements_id',ll_next_element_id)
		dw_req_det.setitem(ll_new_row,'ctx_req_profile_hdr_id',DW_2.getitemnumber(dw_2.GetRow(),'ctx_req_profile_hdr_id'))
		
		//---------------------------- APPEON END ----------------------------
		
		dw_req_det.SetItem( ll_new_row, "ctx_req_tmplt_element_id", ids_profile.GetItemNumber( ll_i, "ctx_req_tmplt_element_id" ) )
		dw_req_det.SetItem( ll_new_row, "ctx_req_tmplt_element_ctx_req_profile_id", ids_profile.GetItemNumber( ll_i, "ctx_req_profile_id" ) )
		dw_req_det.SetItem( ll_new_row, "ctx_req_tmplt_element_ctx_rqmnt_category_id", ids_profile.GetItemNumber( ll_i, "ctx_rqmnt_category_id" ) )
		dw_req_det.SetItem( ll_new_row, "element_name", ids_profile.GetItemString( ll_i, "element_name" ) )
		dw_req_det.SetItem( ll_new_row, "element_sort",  ids_profile.GetItemNumber( ll_i, "element_sort" ) )
		dw_req_det.SetItem( ll_new_row, "value_type",  ids_profile.GetItemNumber( ll_i, "value_type" ) )
	   dw_req_det.SetItem( ll_new_row, "dddw_name", ids_profile.GetItemString( ll_i, "dddw_name" ) )
	   dw_req_det.SetItem( ll_new_row, "category_name", ids_profile.GetItemString( ll_i, "category_name" ) )
		
		//Added By Ken.Guo 2011-01-05.
		dw_req_det.SetItem( ll_new_row, "ctx_req_tmplt_element_show_word_ico",  ids_profile.GetItemNumber( ll_i, "show_word_ico" ) ) 
		dw_req_det.SetItem( ll_new_row, "Image_Length", 0)
		lb_NeedSave = true
	end if
			
	ll_j = 1
	lb_found = false
	
next //for ll_i = 1 to ids_profile.RowCount()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.09.2007 By: Jack 
//$<reason> Fix a defect.
If ids_profile.RowCount() > 0 Then
	for ll_j = dw_req_det.RowCount() to 1 step -1
	   ll_templ_element_id = dw_req_det.getitemnumber(ll_j,'ctx_req_tmplt_element_id')
		ll_ctx_req_profile_id = dw_req_det.getitemnumber(ll_j,'ctx_req_tmplt_element_ctx_req_profile_id')
		ll_ctx_rqmnt_category_id = dw_req_det.getitemnumber(ll_j,'ctx_req_tmplt_element_ctx_rqmnt_category_id')
		ls_find = "ctx_req_tmplt_element_id = " + string(ll_templ_element_id) + " and ctx_req_profile_id = " + string(ll_ctx_req_profile_id) + " and ctx_rqmnt_category_id = " + string(ll_ctx_rqmnt_category_id)
	   ll_find = ids_profile.find(ls_find,1,ids_profile.RowCount())
	   If ll_find < 1 Then
		   dw_req_det.deleterow(ll_j)
		End If
		If ll_j > dw_req_det.RowCount() Then ll_j = dw_req_det.RowCount()
	next
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.30.2007 By: Jack
//$<reason> Fix a defect.
Else
	If dw_2.event pfc_retrieve( ) < 1 Then
   	dw_req_det.reset()
	End If
	//Add by Jack 22.08.2007
	for ll_j = dw_req_det.RowCount() to 1 step -1
		 dw_req_det.deleterow(ll_j)
	next	
//---------------------------- APPEON END ----------------------------
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.30.2007 By: Jack
DatawindowChild child
dw_2.getchild('rqmnt_name',child)
child.settransobject(sqlca)
child.retrieve()

//---------------------------- APPEON END ----------------------------

dw_req_det.groupcalc( )

ll_i = 1 
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.16.2007 By: Jack 
//$<reason> Fix a defect.
event ue_sort()			
//-----Begin Modified by Alfee 09.30.2007--------

If Not of_check_read_only() and lb_NeedSave Then
	of_Update(true,true)				//Added by Scofield on 2009-07-24
	//dw_req_det.of_Enable_Save()
end if
//-----End Modified -----------------------------
//---------------------------- APPEON END ----------------------------

if lb_DispTip then
	st_1.text = "New Items have been added for this profile."
else
	st_1.text = ""
end if

dw_req_det.SetreDraw(true)

Return 0

end function

public function integer of_refresh_dropdown ();/******************************************************************************************************************
**  [PUBLIC]   : of_refresh_dropdown
**==================================================================================================================
**  Purpose   	: Refresh the drop down. Called from the painter
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  28 July 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

datawindowchild ldw_child

dw_2.GetChild ('rqmnt_name', ldw_child ) 
ldw_child.settransobject(sqlca)
ldw_child.retrieve( )


return success
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_requirementsof_create_dw()
// $<arguments>(None)
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.27.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[]

ls_tab_name = 'tabpage_requirements'
ld_dw[1] = dw_2
ls_dw_name[1] = 'dw_2'
ls_dataobject[1] = 'd_profile_header'
ld_dw[2] = dw_req_det
ls_dw_name[2] = 'dw_req_det'
ls_dataobject[2] = 'd_contract_profile_req2'

f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_requirements',true) 

if dw_2.Describe("b_add.Visible") <> "0" then dw_2.Modify("b_add.Visible = 0")

this.event ue_set_screen_properties( )  //Jervis 08.17.2010
end subroutine

public function integer of_lookup_search (string as_lookup_search_column_table);/******************************************************************************************************************
**  [PUBLIC]   : of_lookup_search( /*string as_type */)
**==================================================================================================================
**  Purpose   	: Set the vales from the search window or back to the original value
**==================================================================================================================
**  Arguments 	: [string] as_lookup_search_column_table
**==================================================================================================================
**  Returns   	: Integer 
**==================================================================================================================
**  Create By 	: Jervis on 10-30-2008
********************************************************************************************************************/
any l_any
string ls_code


OpenWithParm( w_lookup_search_dddw,'C' + "@" + as_lookup_search_column_table )

IF Message.StringParm = "Cancel" THEN
	RETURN -1
else
	l_any = Message.DoubleParm
	ls_code = gnv_data.of_getitem( "code_lookup","code", "lookup_code =" + string(l_any))
	dw_req_det.setitem( dw_req_det.GetRow(), "field_value", ls_code)
	//OF_ENABLE_SAVE( )
	return 1
end if


	
		
end function

public function long of_get_next_element_id ();/******************************************************************************************************************
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

long ll_element_id

SELECT max(ctx_elements_id) INTO :ll_element_id FROM ctx_elements;

if Not f_validstr(string(ll_element_id)) then
	ll_element_id = 1
else 
	ll_element_id = ll_element_id + 1
end if

Return ll_element_id

end function

public subroutine of_change_status (string as_status);//Modify by jervis 09.22.2011
choose case as_status
	case 'Collapse Details'
		ll_orig_band_hight = long (dw_req_det.Describe("DataWindow.Detail.Height"))

		cb_2.text = 'Expand Details'
		dw_req_det.Modify("DataWindow.Detail.Height=118")
		dw_req_det.Modify("DataWindow.Detail.Height.AutoSize=No")
		//Begin - Added By Mark Lee 07/16/12
//		dw_req_det.object.clause.visible = false
//		
//		//Display [+] button -- jervis 01.07.2011
//		//dw_req_det.object.b_1.visible = false 
//		dw_req_det.object.b_1.text = '+'
		dw_req_det.Modify("clause.Visible= 0")
		dw_req_det.Modify("b_1.text= '+' ")
		//End - Added By Mark Lee 07/16/12
		ib_plus = false
		
	case 'Expand Details'
		cb_2.text = 'Collapse Details'
		dw_req_det.Modify("DataWindow.Detail.Height = 380")
		dw_req_det.Modify("DataWindow.Detail.Height.AutoSize=No")
		//Begin - Added By Mark Lee 07/16/12
//		dw_req_det.object.clause.visible = true
//		dw_req_det.object.b_1.visible = true
//		dw_req_det.object.b_1.text = '+'
//		
//		if dw_req_det.dataobject = 'd_contract_profile_req_existing' then
//			dw_req_det.object.clause.height = 220
//		else
//			dw_req_det.object.clause.height = 272
//		end if
		dw_req_det.Modify("clause.Visible= 1")
		dw_req_det.Modify("b_1.Visible= 1")
		dw_req_det.Modify("b_1.text= '+' ")
		
		if dw_req_det.dataobject = 'd_contract_profile_req_existing' then
		dw_req_det.Modify("clause.height= 220 ")
		else
		dw_req_det.Modify("clause.height= 272")
		end if
		//End - Added By Mark Lee 07/16/12
end choose 

end subroutine

on u_tabpg_contract_requirements.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_req_det=create dw_req_det
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_req_det
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on u_tabpg_contract_requirements.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_req_det)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event constructor;call super::constructor;/******************************************************************************************************************
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
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Liang QingShi
//$<reason> Contract module modification
of_create_dw()
//---------------------------- APPEON END ----------------------------

ids_profile = create n_ds
ids_profile.dataobject = 'ds_profile'
ids_profile.of_settransObject(sqlca)

/////////////////////////////////////////////////////////////
// make sure the the IUD order is correct
/////////////////////////////////////////////////////////////

powerobject lpo[]
lpo[1] = dw_2
lpo[2] = dw_req_det
of_setupdateobjects(lpo)

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
	//Added By Mark Lee 05/07/12
	this.of_setresize( true)
	this.inv_resize.of_register( dw_2,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_req_det,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_1,inv_resize.scalerightbottom)
	this.inv_resize.of_register( cb_1,inv_resize.FIXEDBOTTOM)
	this.inv_resize.of_register( cb_2,inv_resize.FIXEDBOTTOM)
	this.inv_resize.of_setminsize( 800, 600 )
end if
end event

event ue_selectionchanged;call super::ue_selectionchanged;//dw_req_det.setfocus( )	//Commented by Scofield on 2010-03-22

if dw_2.RowCount() <= 0 then
	dw_2.Post SetFocus()
else
	dw_req_det.Post SetFocus()
end if

end event

event ue_initinstancevar;call super::ue_initinstancevar;ll_orig_band_hight = 0
il_profile_id = 0
ib_new = false
ib_plus = false
il_row = 1
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_requirements
integer x = 416
integer y = 1912
integer width = 3369
integer height = 64
end type

event st_1::constructor;call super::constructor;

text = ''
end event

type dw_2 from u_dw_contract within u_tabpg_contract_requirements
event ue_set_rqmnt_name ( string as_rqmnt_name )
string tag = "Profile Selection "
integer x = 9
integer y = 16
integer width = 3849
integer height = 460
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Profile Selection "
boolean hscrollbar = true
boolean livescroll = false
string dataobject_original = "d_profile_header"
end type

event ue_set_rqmnt_name(string as_rqmnt_name);//////////////////////////////////////////////////////////////////////
// $<event>ue_set_rqmnt_namedw_2()
// $<arguments>
//		value	string	as_rqmnt_name		
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 04.23.2007 by Jack
//////////////////////////////////////////////////////////////////////
this.setitem(this.getrow(),'rqmnt_name',as_rqmnt_name)


end event

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

event constructor;call super::constructor;
this.ib_rmbmenu = false	//04/25/2007 By Jervis

//this.of_setlinkage( true)
//this.of_SetRowManager(TRUE)

end event

event itemchanged;call super::itemchanged;/******************************************************************************************************************
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
long ll_i,ll_Row
long ll_new_row
dwItemStatus l_status
datawindowchild child
ib_new = TRUE

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 

//---------Begin Added by (Appeon)Harry 10.10.2015 for Bug_id 4759 workaround--------
if Upper(appeongetclienttype()) = 'WEB' then
	  l_status = this.GetItemStatus(Row, 0, primary!)
	  if l_status = NotModified!	or l_status = New!	then Return
end if 
//---------End Added ------------------------------------------------------

choose case dwo.name
	case 'rqmnt_name'
		     //Add by Jack 08.29.2007
			  getchild( 'rqmnt_name', child)
			  il_profile_id = child.getitemnumber( child.getrow(), 'ctx_req_profile_id') 
		     //End add by Jack 08.29.2007
			  
			  l_status = dw_req_det.GetItemStatus(Row, 0, primary!)
			  if l_status = NotModified!	or l_status = DataModified!	then // the record is existing
				  if MessageBox(iw_parent.title,'Do you want to delete the currrent profile being used? All data will be lost!',StopSign!,yesno!,1 ) = 1 then 
							long i
							For i = dw_req_det.rowcount() to 1 step -1
								dw_req_det.deleterow(i)
							Next
							
							gnv_appeondb.of_startqueue( )
							dw_req_det.update()
							gnv_appeondb.of_commitqueue( )
							
							//---------------------------- APPEON END ----------------------------
							
							//this.update()
							//this.event pfc_update(true, true) // Comment by Jack 04.20.2007
							dw_req_det.reset( )
							//dw_2.reset( )
							//this.event pfc_insertrow( )

							//--------------------------- APPEON BEGIN ---------------------------
							//$<add> 11.01.2006 By: Davis
							//$<reason> Fix a defect.
							THIS.Setitem( row,'rqmnt_name',data)
							THIS.event Itemchanged(row,dwo,data)
							THIS.accepttext( )
							//---------------------------- APPEON END ----------------------------
							  
					   //end if // Comment by Jack 04.20.2007
					//--------------------------- APPEON BEGIN ---------------------------
					//$<add> 04.23.2007 By: Jack
					//$<reason> Fix a defect.					
					else
						ib_new  = false
						post event ue_set_rqmnt_name(this.getitemstring(this.getrow(),'rqmnt_name'))
						return
				   end if
					//---------------------------- APPEON END ----------------------------
					  
			   else  /// this is a new record  
					//if  dw_req_det.dataobject <> 'd_contract_profile_req2' then
						//--------------------------- APPEON BEGIN ---------------------------
						//$<modify> 07.25.2006 By: Liang QingShi
						//$<reason> Contract module modification
						/*
							dw_req_det.dataobject = 'd_contract_profile_req2'
						*/
			
						string ls_tab_name
						string ls_dw_name[]
						string ls_dataobject[]
						integer li_view_id
						datawindow ld_dw[]
						
						ls_tab_name = 'tabpage_requirements'
						ld_dw[1] = dw_req_det
						ls_dw_name[1] = 'dw_req_det'
						ls_dataobject[1] = 'd_contract_profile_req2'
						
						f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
						iw_parent.function dynamic wf_set_select('tabpage_requirements',true) 
						//---------------------------- APPEON END ----------------------------
						dw_req_det.iuo_calendar.of_UnRegister("date_value")
						dw_req_det.iuo_calendar.of_Register("date_value", dw_req_det.iuo_calendar.DDLB_WITHARROW	)
 					   dw_req_det.settransobject(sqlca)
					//end if 
					
					//Comment by Jack 08.29.2007
					//getchild( 'rqmnt_name', child)
					//il_profile_id = child.getitemnumber( child.getrow(), 'ctx_req_profile_id') 
					//End comment by Jack 08.29.2007
					
					ids_profile.retrieve(il_profile_id)
					
					dw_req_det.SetRedraw(False)
					for ll_i = 1 to ids_profile.rowcount()
						 //--------------------------- APPEON BEGIN ---------------------------
					    //$<comment> 08.18.2006 By: Liang QingShi
						 //$<reason> Contract module modification
						 //$<reason>Fix a defect.
					    /*
						 ll_new_row = dw_req_det.event pfc_insertrow( )	
						 */
						 ll_new_row = dw_req_det.insertrow(0)							
					
						 //---------------------------- APPEON END ----------------------------
					    dw_req_det.SetItem( ll_new_row, "ctx_req_tmplt_element_ctx_req_profile_id", ids_profile.GetItemNumber( ll_i, "ctx_req_profile_id" ) )
						 //--------------------------- APPEON BEGIN ---------------------------
						 //$<add> 01.16.2007 By: Jack 
						 //$<reason> Fix a defect.
					 	 dw_req_det.SetItem( ll_new_row, "ctx_req_tmplt_element_ctx_rqmnt_category_id", ids_profile.GetItemNumber( ll_i, "ctx_rqmnt_category_id" ) )					
						 //---------------------------- APPEON END ----------------------------
						 dw_req_det.SetItem( ll_new_row, "element_name", ids_profile.GetItemString( ll_i, "element_name" ) )
						 dw_req_det.SetItem(ll_new_row, "element_sort", ids_profile.GetItemNumber(ll_i, "element_sort" ) )
						 dw_req_det.SetItem( ll_new_row, "value_type", ids_profile.GetItemNumber(ll_i, "value_type" ) )
						 dw_req_det.SetItem(ll_new_row, "dddw_name", ids_profile.GetItemString( ll_i, "dddw_name" ) )
						 dw_req_det.SetItem( ll_new_row, "category_name", ids_profile.GetItemString( ll_i, "category_name" ) )
						 dw_req_det.SetItem( ll_new_row, "ctx_req_tmplt_element_id", ids_profile.GetItemNumber( ll_i, 'ctx_req_tmplt_element_id' ) )
						 
						 //Start code by jervis 08.20.2009
						 //Set Default Value
						 dw_req_det.SetItem(ll_new_row, "char_value", ids_profile.GetItemString( ll_i, "char_value" ) )
						 dw_req_det.SetItem(ll_new_row, "integer_value", ids_profile.GetItemNumber( ll_i, "integer_value" ) )
						 dw_req_det.SetItem(ll_new_row, "money_value", ids_profile.GetItemNumber( ll_i, "money_value" ) )
						 dw_req_det.SetItem(ll_new_row, "date_value", ids_profile.GetItemDatetime( ll_i, "date_value" ) )
						 dw_req_det.SetItem(ll_new_row, "field_value", ids_profile.GetItemString( ll_i, "field_value" ) )
						 
						 //Added By Ken.Guo 2011-01-05.
 						 dw_req_det.SetItem( ll_new_row, "ctx_req_tmplt_element_show_word_ico",  ids_profile.GetItemNumber( ll_i, "show_word_ico" ) ) 
						 dw_req_det.SetItem( ll_new_row, "Image_Length", 0)
						 
						 //End code by jervis 08.20.2009
					 next
					dw_req_det.groupcalc( )
					dw_req_det.SetRedraw(True)
					//--------------------------- APPEON BEGIN ---------------------------
					//$<add> 01.16.2007 By: Jack 
					//$<reason> Fix a defect.
					 parent.event post ue_sort()			
					//---------------------------- APPEON END ----------------------------
			 end if
		    //Add by Jack 08.29.2007
			 this.setitem(row,'ctx_req_profile_id',il_profile_id)
		    //End add by Jack 08.29.2007
	case else 
end choose

ib_new  = false
cb_2.Text = "Collapse Details" //Add by Evan 01.30.2008

end event

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
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

long	ll_Cycle,ll_RowCnts,ll_profile_id,ll_hdr_id,ll_ctx_id,ll_max_hdr

DatawindowChild child

ll_RowCnts = This.RowCount()
if ll_RowCnts < 1 then Return SUCCESS

ll_ctx_id = inv_contract_details.of_get_ctx_id()
if Not f_ValidStr(String(ll_ctx_id)) then Return FAILURE

ll_max_hdr = of_get_next_prf_hdr_id() - 1

for ll_Cycle = 1 to ll_RowCnts
	ll_hdr_id = This.GetItemNumber(ll_Cycle,'ctx_req_profile_hdr_id')
	if Not f_ValidStr(String(ll_hdr_id)) then
		ll_max_hdr++
		This.SetItem(ll_Cycle,'ctx_req_profile_hdr_id',ll_max_hdr)
	end if
	
	ll_profile_id = This.GetItemNumber(ll_Cycle,'ctx_req_profile_id')
	if Not f_ValidStr(String(ll_profile_id)) then
		This.GetChild('rqmnt_name',child)
		if child.RowCount() < 1 then Return SUCCESS
		ll_profile_id = child.GetItemNumber(child.GetRow(),'ctx_req_profile_id')
		This.SetItem(ll_Cycle,'ctx_req_profile_id',ll_profile_id)
	end if
	
	This.SetItem(ll_Cycle,'ctx_id',ll_ctx_id)
next


Return SUCCESS

end event

event dropdown;call super::dropdown;event ue_populatedddws( )
end event

event buttonclicked;call super::buttonclicked;long ll_id
if of_check_read_only( ) then return success  //Add by Jack 08.30.2007
choose case dwo.name
	case 'b_add'
		if row > 0 then 
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 04.28.2007 By: Jack
			//$<reason> Fix a defect.
			/*
			ll_id = this.object.ctx_req_profile_id[row]
			*/
			ll_id = this.getitemnumber(row,'ctx_req_profile_id')			
			//---------------------------- APPEON END ----------------------------
			openwithparm(w_contract_req_painter, ll_id)
		else 
			open(w_contract_req_painter)

		end if
		of_add_missing( )
		
end choose 
end event

event pfc_deleterow;long ll_Cycle,ll_CurRow,ll_RtnVal
long ll_element_id[],ll_reqmnt_id[]
String ls_field_name[]
DataStore lds_doc
ll_CurRow = dw_2.GetRow()
If ll_CurRow = 0 Then Return 1

If of_check_read_only( ) Then Return failure  //Add by Jack 07.17.2007

ll_RtnVal = MessageBox('Delete Profile', 'Are you sure you want to delete the Profile?',question!,Yesno!,2)

If ll_RtnVal  = 1 then
	//Get deleted element id. //Added By Ken.Guo 2009-07-01.
	long ll_profile_ctx_id
	DataStore lds_element
	lds_element = Create DataStore
	lds_element.Dataobject = 'd_contract_profile_req_existing'
	lds_element.SetTransObject(SQLCA)
	
	lds_doc = Create Datastore
	lds_doc.DataObject = 'd_doc_ref_requirement'
	lds_doc.SetTransObject(SQLCA)	
	
	ll_profile_ctx_id = This.GetItemNumber(ll_CurRow,'ctx_req_profile_hdr_id')
	lds_element.Retrieve(ll_profile_ctx_id)
	If lds_element.RowCount() > 0 Then
		ll_element_id[] = lds_element.object.ctx_req_tmplt_element_ctx_req_tmplt_element_id[1,lds_element.RowCount()]
		For ll_Cycle = 1 To UpperBound(ll_element_id[])
			ll_reqmnt_id[ll_Cycle] = -100
			ls_field_name[ll_Cycle] = ''
		Next
	End If
	
	For ll_Cycle = dw_req_det.RowCount() to 1 step -1
		dw_req_det.deleterow(ll_Cycle)
	Next
	
	dw_2.deleterow(ll_CurRow)
	
	gnv_appeondb.of_startqueue( )	
	dw_req_det.update()
	dw_2.update()
	gnv_appeondb.of_commitqueue( )
	
	
	//Added By Ken.Guo 2009-07-02. update document.
	str_requirement_doc lstr_reqmnt_doc
	If UpperBound(ll_element_id[]) > 0 Then
		lstr_reqmnt_doc.sl_ctx_id = inv_contract_details.of_get_ctx_id( )
		lstr_reqmnt_doc.sl_reqmnt_id[] = ll_reqmnt_id[]
		lstr_reqmnt_doc.sl_element_id[] = ll_element_id[]
		lstr_reqmnt_doc.ss_element_name[] = ls_field_name[]
		lds_doc.Retrieve(lstr_reqmnt_doc.sl_ctx_id,lstr_reqmnt_doc.sl_element_id[])
		If lds_doc.RowCount() > 0 Then
			If Messagebox('Updating existing documents','Would you like to update all the Documents that refer to this requirement?',Question!,YesNo!) = 1 Then
				Openwithparm(w_update_document_by_reqmnt,lstr_reqmnt_doc)
			End If
		End If
		il_deleted_elements_id[] = il_empty[]
	End If
		

	If dw_2.RowCount() < 1 Then
	else
		if dw_2.GetRow() = ll_CurRow then
			dw_2.Event RowFocusChanged(ll_CurRow)
		end if
	End If
Else
	Return -1
End If

If isvalid(lds_element) Then Destroy lds_element
If isvalid(lds_doc) Then Destroy lds_doc
Return 1

end event

event rowfocuschanged;call super::rowfocuschanged;if CurrentRow > 0 and CurrentRow <= This.RowCount() then
	This.SelectRow(0,false)
	This.SelectRow(CurrentRow,true)
	dw_req_det.Event pfc_Retrieve()
else
	dw_req_det.Reset() //Added by Ken.Guo 2009-07-24
end if

end event

event pfc_addrow;long		ll_Profile_id,ll_Row,ll_Found
String	ls_RqmntName

Window	lw_Parent
DataWindowChild	ldwc_Child

if of_check_read_only( ) then return success //Added By Ken.Guo 2009-07-21.

of_GetParentWindow(lw_Parent)
if IsValid(lw_Parent) then
	if lw_Parent.Dynamic Event pfc_save() < 0 then
		Return FAILURE
	end if
end if

OpenWithParm(w_contract_req_painter,1)

ll_Profile_id = Message.DoubleParm

if ll_Profile_id > 0 then
	ll_Found = This.Find("ctx_req_profile_id=" + String(ll_Profile_id),1,This.RowCount())
	if ll_Found > 0 then
		This.ScrollToRow(ll_Found)
		This.SetRow(ll_Found)
		Return SUCCESS
	end if
	
	SUPER::Event pfc_addrow()
	ll_Row = This.GetRow()
	
	This.SetItem(ll_Row,'ctx_req_profile_id',ll_Profile_id)
	
	This.GetChild('rqmnt_name',ldwc_Child)
	ll_Found = ldwc_Child.Find("ctx_req_profile_id=" + String(ll_Profile_id),1,ldwc_Child.RowCount())
	if ll_Found > 0 then
		ldwc_Child.SetRow(ll_Found)
		ls_RqmntName = ldwc_Child.GetItemString(ll_Found,'rqmnt_name')
		This.SetItem(ll_Row,"rqmnt_name",ls_RqmntName)
		This.Event ItemChanged(ll_Row,This.Object.rqmnt_name,ls_RqmntName)
	end if
ElseIf ll_Profile_id = -9 Then 
	//Means Modified Painter and Save //Added By Ken.Guo 2010-12-07.
	If This.GetRow() > 0 Then
		This.event rowfocuschanged(This.GetRow())
	End If
	
end if

Return SUCCESS

end event

event getfocus;call super::getfocus;if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', True)
	
	if This.RowCount() > 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', true)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', false)
	end if
	
	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.visible = True //Added By Ken.Guo 2009-07-21.
	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.visible = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', True) //Added By Ken.Guo 2009-07-21.
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', True)	
end if

end event

event losefocus;call super::losefocus;if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', false)
	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.visible = false //Modified By Ken.Guo 2009-07-21
	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.visible = false
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', false) //Modified By Ken.Guo 2009-07-21
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', false)	
end if

end event

event rowfocuschanging;call super::rowfocuschanging;long		ll_Cycle,ll_Count,ll_Row,ll_Rtn
Boolean	lb_ModiFlag

window	lw_Parent

DWItemStatus	ldw_Status

dw_2.AcceptText()
dw_req_det.AcceptText()

//Check the dw_2 if had modified
ll_Count = dw_2.RowCount()
if ll_Count <= 0 then Return 0

for ll_Cycle = 1 to ll_Count
	ldw_Status = dw_2.GetItemStatus(ll_Cycle,0,Primary!)
	if ldw_Status = newmodified! or ldw_Status = datamodified! then
		lb_ModiFlag = true
		exit
	end if
next

if Not lb_ModiFlag then
	//Check the dw_req_det if had modified
	ll_Count = dw_req_det.RowCount()
	for ll_Cycle = 1 to ll_Count
		ldw_Status = dw_req_det.GetItemStatus(ll_Cycle,0,Primary!)
		if ldw_Status = newmodified! or ldw_Status = datamodified! then
			lb_ModiFlag = true
			exit
		end if
	next
end if

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

event rbuttonup;call super::rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow,ll_Right
String		ls_editstyle
String		ls_val
String		ls_protect
String		ls_colname
String		ls_currcolname
String		ls_type
String		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(2100)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
If ls_type = "ole" Or ls_type = "tableblob" Or ls_type = "graph" Then Return 1

// No RMB support for print preview mode
If This.Object.DataWindow.Print.Preview = "yes" Then Return 1

// Determine parent window for PointerX, PointerY offset
This.of_GetParentWindow (lw_parent)
If IsValid (lw_parent) Then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	Do While IsValid (lw_frame)
		If lw_frame.WindowType = MDI! Or lw_frame.WindowType = MDIHelp! Then
			lb_frame = True
			Exit
		Else
			lw_frame = lw_frame.ParentWindow()
		End If
	Loop
	
	If lb_frame Then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		If lw_parent.WindowType = Child! Then
			lw_parent = lw_frame
		Else
			lw_sheet = lw_frame.GetFirstSheet()
			If IsValid (lw_sheet) Then
				Do
					// Use frame reference for popup menu if the parentwindow is a sheet
					If lw_sheet = lw_parent Then
						lw_parent = lw_frame
						Exit
					End If
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				Loop Until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
			End If
		End If
	Else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		If lw_parent.WindowType = Child! Then
			lw_childparent = lw_parent.ParentWindow()
			If IsValid (lw_childparent) Then
				lw_parent = lw_childparent
			End If
		End If
	End If
Else
	Return 1
End If

// Create popup menu
lm_dw = Create m_dw
lm_dw.of_SetParent (This)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = This.GetRow()

ls_val = This.Object.DataWindow.Readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

Choose Case ls_type
	Case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"
	
	// Row operations based on readonly status
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', Not lb_readonly)
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', lb_desired)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', lb_desired)
	End If
	
Case Else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', False)
End Choose

// Get column properties
ls_currcolname = This.GetColumnName()
If ls_type = "column" Then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	If Not IsNumber(ls_protect) Then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = This.Describe(ls_expression)
	End If
	ls_val = dwo.TabSequence
	If IsNumber (ls_val) Then
		li_tabsequence = Integer (ls_val)
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', False)

// Get the column/editystyle specific editable flag.
If ls_type = "column" And Not lb_readonly Then
	Choose Case ls_editstyle
		Case "edit"
			ls_val = dwo.Edit.DisplayOnly
		Case "editmask"
			ls_val = dwo.EditMask.Readonly
		Case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		Case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		Case Else
			ls_val = ""
	End Choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	If IsNull(lb_editstyleattrib) Then lb_editstyleattrib = False
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2005-09-01 By: Liang QingShi
//$<reason> The BitmapName property of the DataWindow column  is unsupported.

//if ls_type = "column" and not lb_readonly then
//	if dwo.BitmapName = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
//		
//		if Len (this.SelectedText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
//			// Copy
//			lm_dw.m_table.m_copy.Enabled = true
//
//			// Cut
//			if li_tabsequence > 0 and ls_protect = "0" then
//				lb_desired = false
//				choose case ls_editstyle
//					case "edit", "editmask"
//						lb_desired = not lb_editstyleattrib
//					case "ddlb", "dddw"
//						lb_desired = lb_editstyleattrib
//				end choose
//				lm_dw.m_table.m_cut.Enabled = lb_desired
//			end if
//		end if
//			
//		if li_tabsequence > 0 and ls_protect = "0" then
//			// Paste
//			if Len (ClipBoard()) > 0 then
//				lb_desired = false
//				choose case ls_editstyle
//					case "edit", "editmask"
//						lb_desired = not lb_editstyleattrib
//					case "ddlb", "dddw"
//						lb_desired = lb_editstyleattrib
//				end choose
//				lm_dw.m_table.m_paste.Enabled = lb_desired
//			end if
//
//			// Select All
//			if Len (this.GetText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
//				choose case ls_editstyle
//					case "ddlb", "dddw"
//						lb_desired = lb_editstyleattrib						
//					case else
//						lb_desired = true
//				end choose
//				lm_dw.m_table.m_selectall.Enabled = lb_desired				
//			end if
//		end if
//
//	end if
//end if

//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', True)
		Else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', False)
lm_dw.m_table.m_values.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', False)
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<comment> 2005-09-01 By: Liang QingShi
		//$<reason> The BitmapName property of the DataWindow column  is unsupported.
		
		//		If ls_type = "column" And Not lb_readonly Then
		//			If dwo.bitmapname = "no" And ls_editstyle <> "checkbox" And ls_editstyle <> "radiobuttons" Then
		//				If li_tabsequence > 0 And ls_protect = "0" Then
		//					lb_desired = False
		//					Choose Case ls_editstyle
		//						Case "edit", "editmask"
		//							lb_desired = Not lb_editstyleattrib
		//						Case "ddlb", "dddw"
		//							lb_desired = lb_editstyleattrib
		//					End Choose
		//					// Enablement based on column				
		//					lm_dw.m_table.m_values.Enabled = lb_desired
		//					lm_dw.m_table.m_operators.Enabled = lb_desired
		//				End If
		//			End If
		//		End If
		
		//---------------------------- APPEON END ----------------------------
	End If
End If

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-18 By: Scofield
//$<Reason> Don't display the mailaspdf and saveaspdf menu item
lm_dw.m_table.m_insert.Visible = False
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1


end event

type dw_req_det from u_dw_contract within u_tabpg_contract_requirements
string tag = "Profile Detail"
integer x = 9
integer y = 496
integer width = 3849
integer height = 1376
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Profile Detail"
string dataobject_original = "d_contract_profile_req2"
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_Register("date_value", this.iuo_calendar.DDLB_WITHARROW	)


//Object.DataWindow.Print.Preview='Yes'

this.ib_rmbmenu = false	//04/25/2007 By Jervis
end event

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

If dw_2.RowCount() < 1 then 
	dw_req_det.Reset() //Added by Ken.Guo 2009-07-24
	return success
End If

long	ll_hdr_id

DatawindowChild child

dw_2.getchild('rqmnt_name', child)

if child.RowCount() < 1 then return success

il_profile_id = child.getitemnumber( child.getrow(), 'ctx_req_profile_id')

This.SetRedraw(False)
Parent.SetRedraw(False)
This.reset()

if Not ib_new then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.28.2007 By: Jack
	//$<reason> Fix a defect.
	/*
		if dw_2.object.ctx_req_profile_hdr_id[1] > 0 and dw_2.object.ctx_id[1] > 0 then
	*/
	if dw_2.getitemnumber(dw_2.getrow(),'ctx_req_profile_hdr_id') > 0 and dw_2.getitemnumber(dw_2.getrow(),'ctx_id') > 0 then	
	//---------------------------- APPEON END ----------------------------
	
		string ls_tab_name
		string ls_dw_name[]
		string ls_dataobject[]
		integer li_view_id
		datawindow ld_dw[]
		
		ls_tab_name = 'tabpage_requirements'
		ld_dw[1] = dw_req_det
		ls_dw_name[1] = 'dw_req_det'
		ls_dataobject[1] = 'd_contract_profile_req_existing'
		
		f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
		
		IF NOT Isvalid(iw_parent) THEN This.of_getparentwindow( iw_parent)
		iw_parent.function dynamic wf_set_select('tabpage_requirements',true) 
		
		This.iuo_calendar.of_UnRegister("date_value")
		This.iuo_calendar.of_Register("date_value", This.iuo_calendar.DDLB_WITHARROW	)
		This.settransobject(sqlca)
		
		ll_hdr_id = dw_2.GetItemNumber(dw_2.GetRow(),'ctx_req_profile_hdr_id')
		
		This.Retrieve(ll_hdr_id)
	else 
		
	end if
END IF

//Added By Ken.Guo 2010-12-06.
String ls_status
If not ib_retrieved Then
	//Set status by settings
	ls_status = gnv_data.of_getitem( 'security_users', 'req_expand_status', 'user_id = "' + gs_user_id + '"')
	If ls_status <> '' and not isnull(ls_status) Then
		of_change_status(ls_status)
	End If
Else
	//Use Current Status
	If cb_2.Text = "Expand Details" Then
		of_change_status('Collapse Details')
	Else
		of_change_status('Expand Details')
	End If	
End If

This.SetRedraw(True)
Parent.SetRedraw(True)


Return success

end event

event retrieveend;call super::retrieveend;/******************************************************************************************************************
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
LONG LL_I 

/////////////////////////////////////////////////////////////////////////////
// SET THE POINTER TO SIZE! IF WE ARE A RESP WINDOW TO POPULATE THE VALUES
/////////////////////////////////////////////////////////////////////////////

of_add_missing( )

end event

event doubleclicked;call super::doubleclicked;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


window lw

str_pass lstr_pass

if of_check_read_only( ) then return success //Added by Ken.Guo on 2009-01-05

if row < 1 then return 

 if  dwo.name = 'field_value' and object.value_type[row] = 5  then 
	//Start Code By Jervis 10-30-2008
	/*
	lstr_pass.s_u_dw = dw_req_det
	//of_set_message( string(dw_req_det.object.dddw_name[dw_req_det.getrow()]))
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.28.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	lstr_pass.s_string = dw_req_det.object.dddw_name[dw_req_det.getrow()]
	*/
	lstr_pass.s_string = dw_req_det.getitemstring(dw_req_det.getrow(),'dddw_name')	
	//---------------------------- APPEON END ----------------------------
	
	OpenWithParm(w_code_add_resp, lstr_pass)
	*/
	of_lookup_search(dw_req_det.getitemstring(dw_req_det.getrow(),'dddw_name'))
	//End Code By Jervis 10-30-2008
	
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.18.2006 By: Rodger Wu Bryan
	//$<reason> Original code bug fixing
	if dw_req_det.ModifiedCount() > 0 then
		dw_req_det.of_enable_save()
	end if
	//---------------------------- APPEON END ----------------------------
end if
 
end event

event pfc_preupdate;call super::pfc_preupdate;
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
 
long ll_Cycle
long ll_next_element_id

if This.RowCount( ) < 1 then Return SUCCESS
If dw_2.RowCount() < 1 Then Return SUCCESS

ll_next_element_id = of_get_next_element_id()
ll_next_element_id = ll_next_element_id - 1

for ll_Cycle = 1 to This.RowCount()
	if Not f_validstr(STRING(this.GetItemNumber(ll_Cycle,'elements_id'))) then
		ll_next_element_id = ll_next_element_id + 1
		this.SetItem(ll_Cycle,'elements_id',ll_next_element_id)
		this.SetItem(ll_Cycle,'ctx_req_profile_hdr_id',dw_2.GetItemNumber(dw_2.getrow(),'ctx_req_profile_hdr_id'))
		this.SetItemstatus( ll_Cycle, 0, Primary!, NewModified!)
	end if
	
	if Not f_validstr(STRING(this.GetItemNumber(ll_Cycle,'image_length'))) then
		This.SetItem(ll_Cycle,'image_length',0)
	end if
next

//Get deleted elements id //Added By Ken.Guo 2009-07-01.
Integer i
il_deleted_elements_id[] = il_empty[]
For i = 1 To This.Deletedcount( )
	il_deleted_elements_id[i] = This.GetItemNumber(1,'ctx_req_tmplt_element_ctx_req_tmplt_element_id',Delete!,False)
	il_deleted_reqmnt_id[i] = -100
	il_deleted_filed_name[i] = ''
Next

Return SUCCESS

end event

event pfc_preinsertrow;call super::pfc_preinsertrow;


if not  ib_new then
  return failure
else 
	return success
end if 
end event

event pfc_deleterow;////--------------------------- APPEON BEGIN ---------------------------
////$<add> 09.08.2006 By: Liang QingShi
////$<reason> Fix a defect.
//
//OF_ENABLE_SAVE( )
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 01.16.2007 By: Jack 
////$<reason> Fix a defect.
//event post ue_sort()			
////---------------------------- APPEON END ----------------------------
//return success
////---------------------------- APPEON END ----------------------------

//BEGIN---Modify by Scofield on 2010-03-22
dw_2.Event pfc_DeleteRow()

Return Success
//END---Modify by Scofield on 2010-03-22

end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event>buttonclickeddw_req_det()
// $<arguments>
//		long    	row             		
//		long    	actionreturncode		
//		dwobject	dwo             		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.30.2006 by Jack
//////////////////////////////////////////////////////////////////////
//if of_check_read_only( ) then return success  //Commented by Alfee 09.30.2007

long	ll_elements_id,ll_Length,ll_ImageLen,ll_Cnts

//Modify by jervis 09.22.2011
if dwo.name = 'b_1' then
	This.Accepttext( )
	il_row = row		
	if ib_plus = false then
		this.object.clause.height = 1200
		this.modify("DataWindow.detail.height = 1200")
		this.object.b_1.text = '-'
		ib_plus = true
		if cb_2.text = 'Collapse Details' then 
			ib_Collapse = true
		else
			ib_Collapse = false
			cb_2.text = 'Collapse Details' 
		end if
		dw_req_det.object.clause.visible = true
	else
		if this.dataobject = 'd_contract_profile_req_existing' then
			this.object.clause.height = 220
		else
			this.object.clause.height = 270
		end if
		if ib_Collapse then
			this.Modify("DataWindow.Detail.Height = 380")
			this.object.clause.visible = true
		else
			this.modify("DataWindow.detail.height = 118")
			this.object.clause.visible = false
			cb_2.text = 'Expand Details'
		end if
		this.object.b_1.text = '+'
		ib_plus = false
		this.Modify("DataWindow.Detail.Height.AutoSize=No")
	end if
	this.ScrollToRow( il_row )
	this.SetRow( il_row )		
elseif dwo.name = 'b_editword_isempty' or dwo.name = 'b_editword_notempty' then
	ll_elements_id = This.GetItemNumber(row,"elements_id")
	
	SELECT COUNT(*) INTO :ll_Cnts FROM ctx_elements WHERE ctx_elements_id = :ll_elements_id;
	if ll_Cnts <= 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,"The Word attachment cannot be edited until after the record is saved.")
		Return
	end if
	
	OpenWithParm(w_requirement_element_doc,ll_elements_id)
	
	SELECT IsNull(Datalength(ctx_elements.image_file),0)
	  INTO :ll_Length
	  FROM ctx_elements
	 WHERE ctx_elements_id = :ll_elements_id;
	
	ll_ImageLen = This.GetItemNumber(row,"image_length")
	if IsNull(ll_ImageLen) or ll_Length <> ll_ImageLen then
		This.SetItem(Row,"image_length",ll_Length)
		This.SetItemStatus(Row,"image_length",Primary!,NotModified!)
	end if
end if

end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.01.2007 By: Davis
//$<reason> If there is lookup data associated with the field then 
//$<reason> show a little lookup icon next to field that can be clicked 
//$<reason> to bring up lookup
if of_check_read_only( ) then return success  //Add by Jack 08.30.2007

IF dwo.name = "p_1" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.24.2007 By: Jack
	//$<reason> Fix a defect.
	
	il_row = row
	this.ScrollToRow( il_row )
	this.SetRow( il_row )		
	this.setcolumn('field_value')
	//---------------------------- APPEON END ----------------------------
	
	//Start Code By Jervis 10-30-2008
	/*str_pass lstr_pass
	lstr_pass.s_u_dw = dw_req_det
	lstr_pass.s_string = dw_req_det.getitemstring(dw_req_det.getrow(),'dddw_name')
	OpenWithParm(w_code_add_resp, lstr_pass)
	*/
	of_lookup_search(dw_req_det.getitemstring(dw_req_det.getrow(),'dddw_name'))
	//End Code By Jervis 10-30-2008
	
	OF_ENABLE_SAVE( )	
END IF

//---------------------------- APPEON END ----------------------------


end event

event dropdown;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: Override the ancestor script. PFC calaender does not work with datawindow with title bar
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 28 July 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


Long  ll_rtn 
Boolean lb_titlebar 


lb_titlebar = TitleBar 
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 03.16.2006 By: LeiWei
//$<reason> Fix a defect.
//If lb_titlebar Then TitleBar = FALSE 
//---------------------------- APPEON END ----------------------------
//SetRedraw ( FALSE ) 
ll_rtn = Super::Event dropdown() 
If lb_titlebar Then TitleBar = TRUE 
//SetRedraw ( TRUE ) 
Return ll_rtn
end event

event rowfocuschanging;call super::rowfocuschanging;dwitemstatus l_status


l_status = this.getitemstatus( currentrow,0, primary!)

choose case l_status
	case datamodified!
	case newmodified!
	case new!
	case notmodified!
end choose



end event

event losefocus;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.24.2007 By: Jack
//$<reason> Fix a defect.
this.title = this.tag
//---------------------------- APPEON END ----------------------------

end event

event pfc_postupdate;call super::pfc_postupdate;
DataStore lds_doc
lds_doc = Create Datastore
lds_doc.DataObject = 'd_doc_ref_requirement'
lds_doc.SetTransObject(SQLCA)

//BEGIN---Add by Evan 12/11/2008
this.SetRedraw(false)
this.GroupCalc()
this.SetRedraw(true)
//END---Add by Evan 12/11/2008


//Added By Ken.Guo 2009-07-02.
str_requirement_doc lstr_reqmnt_doc
If UpperBound(il_deleted_elements_id[]) > 0 Then
	lstr_reqmnt_doc.sl_ctx_id = inv_contract_details.of_get_ctx_id( )
	lstr_reqmnt_doc.sl_element_id[] = il_deleted_elements_id[]
	lstr_reqmnt_doc.sl_reqmnt_id[] = il_deleted_reqmnt_id[]
	lstr_reqmnt_doc.ss_element_name[] = il_deleted_filed_name[]
	lds_doc.Retrieve(lstr_reqmnt_doc.sl_ctx_id,lstr_reqmnt_doc.sl_element_id[])
	If lds_doc.RowCount() > 0 Then
		If Messagebox('Updating existing documents','Would you like to update all the Documents that refer to this requirement?',Question!,YesNo!) = 1 Then
			Openwithparm(w_update_document_by_reqmnt,lstr_reqmnt_doc)
		End If
	End If
	il_deleted_elements_id[] = il_empty[]
End If

If isvalid(lds_doc) Then Destroy lds_doc
Return 1


end event

event getfocus;call super::getfocus;//Added By Ken.Guo 2009-07-24.
if IsValid(m_pfe_cst_mdi_menu_contract) then
	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.visible = true
	m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.visible = true
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', true)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', true)
	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
	
	if dw_2.RowCount() > 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', true)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', false)
	end if
	
	
end if

end event

event pfc_addrow;//BEGIN---Modify by Scofield on 2010-03-22
dw_2.Event pfc_AddRow()

Return Success
//END---Modify by Scofield on 2010-03-22

end event

type cb_1 from u_cb within u_tabpg_contract_requirements
boolean visible = false
integer x = 430
integer y = 1900
integer taborder = 40
boolean bringtotop = true
string text = "Image"
end type

event clicked;call super::clicked;
// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return 0
// mskinner 05 april 2006 -- end 

if inv_contract_details.of_get_ctx_id( ) = 0 or NOT f_validstr(string(inv_contract_details.of_get_ctx_id( ))) then 
   iw_parent.event dynamic ue_save()
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.20.2006 By: Liang QingShi
//$<reason> Fix a defect.
dw_req_det.accepttext()
If dw_req_det.modifiedcount( ) > 0 Then
	iw_parent.event dynamic ue_save()
End If
//---------------------------- APPEON END ----------------------------

event ue_open_work()
end event

type cb_2 from commandbutton within u_tabpg_contract_requirements
integer x = 9
integer y = 1900
integer width = 389
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Expand Details"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.18.2006 By: LeiWei
//$<reason> Fix a defect.
/*
ll_orig_band_hight = long (dw_req_det.Describe("DataWindow.Detail.Height"))

string ll_ret

choose case this.text
	case 'Collapse Details'
		this.text = 'Expand Details'
		ll_ret = dw_req_det.Modify("DataWindow.Detail.Height=76")
		dw_req_det.Modify("DataWindow.Detail.Height.AutoSize=No")
		
	case 'Expand Details'
		this.text = 'Collapse Details'
		ll_ret = dw_req_det.Modify("DataWindow.Detail.Height=" + string(ll_orig_band_hight))
		dw_req_det.Modify("DataWindow.Detail.Height.AutoSize=Yes")
end choose 
*/

string ll_ret
String ls_status

IF dw_req_det.AcceptText() <> 1 THEN RETURN

il_row = dw_req_det.GetRow( )  //Added By Jervis 2010-08-11. from Ken

ls_status = this.text

of_change_status(ls_status) //Modified By Ken.Guo 2010-12-06
/*
choose case ls_status
	case 'Collapse Details'
		ll_orig_band_hight = long (dw_req_det.Describe("DataWindow.Detail.Height"))

		this.text = 'Expand Details'
		ll_ret = dw_req_det.Modify("DataWindow.Detail.Height=118")
		dw_req_det.Modify("DataWindow.Detail.Height.AutoSize=No")
		
		dw_req_det.object.clause.visible = false
		dw_req_det.object.b_1.visible = false
	case 'Expand Details'
		this.text = 'Collapse Details'
		ll_ret = dw_req_det.Modify("DataWindow.Detail.Height = 380")
		dw_req_det.Modify("DataWindow.Detail.Height.AutoSize=No")
		
		if dw_req_det.dataobject = 'd_contract_profile_req_existing' then
			dw_req_det.object.clause.visible = true
			dw_req_det.object.b_1.visible = true
			if ib_plus = true then
				dw_req_det.object.clause.height = 1200
				dw_req_det.modify("DataWindow.detail.height = 1200")
				dw_req_det.object.b_1.text = '-'
			else
				dw_req_det.object.clause.height = 220
				dw_req_det.modify("DataWindow.detail.height = 380")
				dw_req_det.object.b_1.text = '+'
			end if
			//dw_req_det.setfocus()
			//dw_req_det.ScrollToRow( il_row )
			//dw_req_det.SetRow( il_row )	
		else
			dw_req_det.object.clause.visible = true
			dw_req_det.object.b_1.visible = true
			if ib_plus = true then
				dw_req_det.object.clause.height = 1200
				dw_req_det.modify("DataWindow.detail.height = 1200")
				dw_req_det.object.b_1.text = '-'
			else
				dw_req_det.object.clause.height = 272
				dw_req_det.modify("DataWindow.detail.height = 380")
				dw_req_det.object.b_1.text = '+'
			end if
			//Added By Jervis 2010-08-11. from Ken
			//dw_req_det.setfocus()
			//dw_req_det.ScrollToRow( il_row )
			//dw_req_det.SetRow( il_row )	
		end if
end choose 
*/
//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 2010-12-06.
gnv_appeondb.of_startqueue( )
	Update Security_Users Set req_expand_status = :ls_status Where user_id = :gs_user_id;
	gnv_data.of_retrieve('security_users')
gnv_appeondb.of_commitqueue( )


dw_req_det.setfocus()
dw_req_det.ScrollToRow( il_row )
dw_req_det.SetRow( il_row )	
end event

