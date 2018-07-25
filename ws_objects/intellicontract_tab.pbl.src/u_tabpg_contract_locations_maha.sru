$PBExportHeader$u_tabpg_contract_locations_maha.sru
$PBExportComments$[intellicontract_tab]  The contract locations Tab Page
forward
global type u_tabpg_contract_locations_maha from u_tabpg_contract_master
end type
type dw_main from u_dw_contract within u_tabpg_contract_locations_maha
end type
type cb_1 from commandbutton within u_tabpg_contract_locations_maha
end type
type cb_3 from commandbutton within u_tabpg_contract_locations_maha
end type
type cb_4 from commandbutton within u_tabpg_contract_locations_maha
end type
type cb_5 from commandbutton within u_tabpg_contract_locations_maha
end type
type gb_4 from u_gb within u_tabpg_contract_locations_maha
end type
type dw_doctors from u_dw_contract within u_tabpg_contract_locations_maha
end type
type dw_spec from u_dw_contract within u_tabpg_contract_locations_maha
end type
type dw_detail from u_dw_contract within u_tabpg_contract_locations_maha
end type
type dw_linked_providers from u_dw_contract within u_tabpg_contract_locations_maha
end type
end forward

global type u_tabpg_contract_locations_maha from u_tabpg_contract_master
integer width = 3845
integer height = 2212
long backcolor = 33551856
string text = "Locations"
boolean ib_alwaysvalidate = false
event ue_add ( )
event ue_delete ( )
event ue_set_screen_properties ( )
dw_main dw_main
cb_1 cb_1
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
gb_4 gb_4
dw_doctors dw_doctors
dw_spec dw_spec
dw_detail dw_detail
dw_linked_providers dw_linked_providers
end type
global u_tabpg_contract_locations_maha u_tabpg_contract_locations_maha

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-20 By: Liu Hongxin
//$<reason> Performance tuning: Control row changx event.
Boolean ib_RowChange = True
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_set_multitab ()
public subroutine of_create_dw ()
end prototypes

event ue_add();// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 

//dw_main.of_SetLinkage(false) // master datawindow
//dw_detail.of_SetLinkage(false)
//dw_doctors.of_SetLinkage(false)
//dw_spec.of_SetLinkage(false)

openwithparm(w_contract_grp_add, this)


//dw_main.of_SetLinkage(true) // master datawindow
//dw_detail.of_SetLinkage(true)
//dw_doctors.of_SetLinkage(true)
//dw_spec.of_SetLinkage(true)
end event

event ue_delete();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  05 july 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

datawindow ldw
dragobject which_control
which_control = GetFocus()

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 

CHOOSE CASE TypeOf(which_control)

CASE datawindow!
	ldw =which_control
	ldw.event dynamic pfc_delete()
 
END CHOOSE
dw_doctors.reset( )
end event

event ue_set_screen_properties();// Set screen properties
dw_main.of_set_properties(dw_main.il_ViewID, dw_main.il_ScreenID, "Y")
dw_detail.of_set_properties(dw_detail.il_ViewID, dw_detail.il_ScreenID, "Y")
dw_doctors.of_set_properties(dw_doctors.il_ViewID, dw_doctors.il_ScreenID, "Y")
dw_spec.of_set_properties(dw_spec.il_ViewID, dw_spec.il_ScreenID, "Y")
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

this.setredraw(false)

if not ib_retrieved then
	dw_main.reset( )
	dw_doctors.reset()
	dw_detail.reset( )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.11.2006 By: LeiWei
	//$<reason> Fix a defect.
	/*
	dw_main.title = 'Parent Organization'
	dw_detail.title = ' Group / Locations '
	*/
	//---------------------------- APPEON END ----------------------------
	dw_doctors.title = 'Associated Physicians for Selected Facility'
	dw_spec.title  =  'Specialties for Selected Facility'
	
	dw_main.event pfc_retrieve( )	 
end if

if inv_contract_details.of_get_is_ctx_medial( ) then 
   dw_detail.height = dw_doctors.Y - 20 - dw_detail.Y
	dw_doctors.visible = true
	dw_spec.visible = true
else 
	dw_detail.height = dw_doctors.Y + dw_doctors.Height - dw_detail.Y
	dw_doctors.visible = false
	dw_spec.visible = false		
end if

ib_retrieved = true
 
this.setredraw(true) 
 
 return success
end function

public function integer of_set_multitab ();

//dw_detail.of_SetMultiTable(TRUE)
//String  ls_group_practice[ ] = {"tax_id"}
//String  ls_ctx_loc[ ] =  {"group_number", "local", "custom_1","custom_2"}
//
//dw_detail.inv_multitable.of_Register("group_practice", ls_group_practice)
//dw_detail.inv_multitable.of_Register("ctx_loc", ls_ctx_loc)

return success
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_locationsof_create_dw()
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

ls_tab_name = 'tabpage_locations'
ld_dw[1] = dw_main
ld_dw[2] = dw_detail
ld_dw[3] = dw_doctors
ld_dw[4] = dw_spec
ls_dw_name[1] = 'dw_main'
ls_dw_name[2] = 'dw_detail'
ls_dw_name[3] = 'dw_doctors'
ls_dw_name[4] = 'dw_spec'
ls_dataobject[1] = 'd_contract_multi_group_browse'
ls_dataobject[2] = 'd_contract_group_linked_locations'
ls_dataobject[3] = 'd_contract_group_practitioners_existing'
ls_dataobject[4] = 'd_cntx_location_spec'
f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_locations',true) 

this.event ue_set_screen_properties( )  //Jervis 08.17.2010

end subroutine

on u_tabpg_contract_locations_maha.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.gb_4=create gb_4
this.dw_doctors=create dw_doctors
this.dw_spec=create dw_spec
this.dw_detail=create dw_detail
this.dw_linked_providers=create dw_linked_providers
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.dw_doctors
this.Control[iCurrent+8]=this.dw_spec
this.Control[iCurrent+9]=this.dw_detail
this.Control[iCurrent+10]=this.dw_linked_providers
end on

on u_tabpg_contract_locations_maha.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.gb_4)
destroy(this.dw_doctors)
destroy(this.dw_spec)
destroy(this.dw_detail)
destroy(this.dw_linked_providers)
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
**  Created By	: Michael B. Skinner  01 July 2005
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
dw_main.of_SetLinkage(true) // master datawindow
dw_detail.of_SetLinkage(true)
dw_doctors.of_SetLinkage(true)
dw_spec.of_SetLinkage(true)


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the linkage stuff
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.13.2006 By: LeiWei
//$<reason> The variable without declaration is unsupported

//dw_detail.inv_linkage.of_SetMaster(dw_main)
//dw_detail.inv_linkage.of_Register("ctx_id", "ctx_id") 
//dw_detail.inv_linkage.of_Register("parent_comp_id", "parent_comp_id")
//dw_detail.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve) 
//
////dw_doctors.inv_linkage.of_SetMaster(dw_detail)
////dw_doctors.inv_linkage.of_Register("rec_id", "rec_id") 
////dw_doctors.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve) 

//dw_spec.inv_linkage.of_SetMaster(dw_detail)
//dw_spec.inv_linkage.of_Register("loc_id", "loc_id") 
//dw_spec.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve) 


dw_detail.inv_linkage.of_SetMaster(dw_main)
dw_detail.inv_linkage.of_Register("ctx_id", "ctx_id") 
dw_detail.inv_linkage.of_Register("parent_comp_id", "parent_comp_id")
dw_detail.inv_linkage.of_SetStyle(dw_detail.inv_linkage.retrieve) 

dw_spec.inv_linkage.of_SetMaster(dw_detail)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.22.2007 By: Jack
//$<reason> Fix a defect.
dw_spec.inv_linkage.of_Register("ctx_id", "ctx_id") 
//---------------------------- APPEON END ----------------------------
dw_spec.inv_linkage.of_Register("loc_id", "loc_id") 
dw_spec.inv_linkage.of_SetStyle(dw_spec.inv_linkage.retrieve) 

//---------------------------- APPEON END ----------------------------


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the update properties for the datawindows
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// update
dw_doctors.inv_linkage.of_SetUpdateOnRowChange(TRUE)
dw_main.inv_linkage.of_SetUpdateOnRowChange(TRUE)
dw_detail.inv_linkage.of_SetUpdateOnRowChange(TRUE)
dw_spec.inv_linkage.of_SetUpdateOnRowChange(TRUE)
// confirm
dw_main.inv_linkage.of_SetConfirmOnRowChange(FALSE)
dw_detail.inv_linkage.of_SetConfirmOnRowChange(FALSE)
dw_doctors.inv_linkage.of_SetConfirmOnRowChange(FALSE)
dw_spec.inv_linkage.of_SetConfirmOnRowChange(FALSE)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete delete style
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_detail.inv_linkage.of_SetDeleteStyle(dw_detail.inv_linkage.DELETE_ROWS)
dw_main.inv_linkage.of_SetDeleteStyle(dw_main.inv_linkage.DELETE_ROWS)
dw_spec.inv_linkage.of_SetDeleteStyle(dw_main.inv_linkage.DELETE_ROWS)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete properties for the datawindows
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_detail.inv_linkage.of_SetConfirmOnDelete ( true )
dw_main.inv_linkage.of_SetConfirmOnDelete ( true )
dw_spec.inv_linkage.of_SetDeleteStyle(dw_main.inv_linkage.DELETE_ROWS)
//dw_detail.inv_linkage.of_SetDeleteStyle ( 1 )

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// multitabel update
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_main.inv_linkage.of_SetTransObject(SQLCA)

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
	//Added By Mark Lee 05/07/12
	this.of_setresize( true)
	this.inv_resize.of_register( dw_main,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_detail,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_doctors,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_spec,inv_resize.scalerightbottom)
	this.inv_resize.of_register( gb_4,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_1,inv_resize.scalerightbottom)
	this.inv_resize.of_register( cb_1,inv_resize.FIXEDBOTTOM)
	this.inv_resize.of_register( cb_3,inv_resize.FIXEDBOTTOM)
	this.inv_resize.of_register( cb_4,inv_resize.FIXEDBOTTOM)
	this.inv_resize.of_register( cb_5,inv_resize.FIXEDBOTTOM)
	this.inv_resize.of_setminsize( 800, 600 )
end if
end event

event ue_selectionchanged;call super::ue_selectionchanged;


dw_main.setfocus( )
end event

event ue_initinstancevar;call super::ue_initinstancevar;ib_RowChange = true
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_locations_maha
integer x = 18
integer y = 2052
integer width = 3694
integer height = 92
integer textsize = 0
integer weight = 0
long backcolor = 33551856
alignment alignment = left!
end type

type dw_main from u_dw_contract within u_tabpg_contract_locations_maha
string tag = "Parent Organization"
integer x = 14
integer width = 1833
integer height = 2044
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Parent Organization"
boolean maxbox = true
boolean hscrollbar = true
boolean ib_rmbmenu = false
string dataobject_original = "d_contract_multi_group_browse"
end type

event pfc_preupdate;call super::pfc_preupdate;




long ll_i

for ll_i = 1 to this.rowcount( )
	if isnull(this.object.ctx_id[ll_i]) then
	  this.object.ctx_id[ll_i] = inv_contract_details.of_get_ctx_id( )
   end if
next


return success
end event

event pfc_retrieve;call super::pfc_retrieve;




retrieve(inv_contract_details.of_get_ctx_id( ) )
return success
end event

event constructor;call super::constructor;this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )
//ib_rmbmenu	= true



end event

event pfc_deleterow;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //set the update properties for the datawindows
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//dw_doctors.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//dw_doctors.inv_linkage.of_SetConfirmOnRowChange(TRUE)
dw_detail.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//dw_detail.inv_linkage.of_SetConfirmOnRowChange(TRUE)
//dw_doctors.reset( )
//dw_detail.reset( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.04.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.

//----Begin Modified by Alfee 09.30.2007--------
//<$Reason>Use the same interface at tabpage level
//if dw_main.ib_read_only then return success
if of_check_read_only( ) then return success
//----End Modified------------------------------

if this.rowcount() <= 0 then return success
if MessageBox('Confirm Delete', 'Are you sure you want to delete this row?',Question!,Yesno!,2) = 1 then		//Modified by Scofield on 2008-03-11
	long ll_ctx_id 
	long ll_parent_comp_id
	if this.getrow() > 0 then
		ll_ctx_id = this.getitemnumber(this.getrow(),'ctx_id')
		ll_parent_comp_id = this.getitemnumber(this.getrow(),'parent_comp_id')
	else
		return success
	end if
	if gs_dbtype <> "ASA" then
		
		gnv_appeondb.of_startqueue( )	
		DELETE FROM  CTX_LOCATION_PRACS WHERE ctx_id = :ll_ctx_id AND parent_comp_id = :ll_parent_comp_id AND loc_id IN (SELECT a.rec_id FROM group_practice a,ctx_loc b WHERE a.rec_id = b.loc_id and b.ctx_id = :ll_ctx_id AND b.parent_comp_id = :ll_parent_comp_id AND b.loc_id <> 0);  
		DELETE FROM  CTX_LOCATION_SPECIALTY WHERE ctx_id = :ll_ctx_id AND loc_id IN (SELECT a.loc_id FROM ctx_loc a,group_practice b WHERE a.loc_id = b.rec_id and a.ctx_id = :ll_ctx_id AND a.parent_comp_id = :ll_parent_comp_id AND a.loc_id <> 0);    
		DELETE FROM  CTX_LOCATION_CONTACTS WHERE ctx_id = :ll_ctx_id AND parent_comp_id = :ll_parent_comp_id AND loc_id <> 0;
		DELETE FROM  CTX_LOC WHERE ctx_id = :ll_ctx_id AND parent_comp_id = :ll_parent_comp_id AND loc_id IN (SELECT a.loc_id FROM ctx_loc a,group_practice b WHERE a.loc_id = b.rec_id AND a.loc_id <> 0);
		commit;
		gnv_appeondb.of_commitqueue( )

		dw_detail.reset()//Rodger Wu added.
		dw_doctors.reset()//Rodger Wu added.
		dw_spec.reset( )//Rodger Wu added.
	end if
	this.deleterow(getrow())
	dw_detail.reset()
	dw_doctors.reset()
	dw_spec.reset( )
	parent.of_update( true, true)
	this.event rowfocuschanged(1)
	IF this.ROWcount( ) > 0 then 
		this.SelectRow(1, true)
	end if 
end if
//---------------------------- APPEON END ----------------------------


return success
end event

event pfc_addrow;
parent.event ue_add( )

RETURN SUCcess
end event

event rowfocuschanging;call super::rowfocuschanging;dw_detail.reset( )
end event

event retrieveend;call super::retrieveend;

this.title =  'Contracted Entity (' + string(rowcount)  +')'
end event

event updateend;call super::updateend;

//long ll_ctx_id
//ll_ctx_id = inv_contract_details.of_get_ctx_id( )
//dw_detail.of_isupdateable( )
//if rowsdeleted > 0 then 
//	delete from ctx_loc where ctx_id = :ll_ctx_id and parent_comp_id = :il_parent_comp_id
//	commit;
//end if
end event

event pfc_predeleterow;call super::pfc_predeleterow;



///////////////////////////////////////////////////
// delete the detail rows
/////////////////////////////////////////////////

long ll_count


dw_detail.RowsMove(1, dw_detail.RowCount(), Primary!,dw_detail, 1, Delete!)
dw_doctors.reset( )

return success
end event

event rowfocuschanged;call super::rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.18.2006 By: Liang QingShi
//$<reason> Fix a defect.
long i,ll_loc_id,ll_num,ll_rowcount,ll_find,ll_count
ll_rowcount = dw_detail.rowcount()
if ll_rowcount <= 0 then return
datastore lds_contact
lds_contact = create datastore
lds_contact.dataobject = 'd_cntx_location_contact_all'
lds_contact.settransobject(sqlca)
ll_count = lds_contact.retrieve()

for i = 1 to ll_rowcount
	ll_loc_id = long(dw_detail.getitemnumber(i,'loc_id'))
	ll_find = lds_contact.find("loc_id = " + string(ll_loc_id),1,ll_count)
	if ll_find > 0 then
		dw_detail.setitem(i,'selected',1)
	end if		
next
destroy lds_contact

//---------------------------- APPEON END ----------------------------

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
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
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

ll_Right = w_mdi.of_security_access(2120)				//Access Rights
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
	lm_dw.m_table.m_insert.Enabled = Not lb_readonly
	lm_dw.m_table.m_addrow.Enabled = Not lb_readonly
	lm_dw.m_table.m_delete.Enabled = Not lb_readonly
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		lm_dw.m_table.m_delete.Enabled = lb_desired
		lm_dw.m_table.m_insert.Enabled = lb_desired
	End If
	
Case Else
	lm_dw.m_table.m_insert.Enabled = False
	lm_dw.m_table.m_delete.Enabled = False
	lm_dw.m_table.m_addrow.Enabled = False
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
lm_dw.m_table.m_copy.Enabled = False
lm_dw.m_table.m_cut.Enabled = False
lm_dw.m_table.m_paste.Enabled = False
lm_dw.m_table.m_selectall.Enabled = False

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

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			lm_dw.m_table.m_restorerow.Enabled = True
		Else
			lm_dw.m_table.m_restorerow.Enabled = False
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	lm_dw.m_table.m_restorerow.Enabled = False
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
lm_dw.m_table.m_operators.Enabled = False
lm_dw.m_table.m_values.Visible = False
lm_dw.m_table.m_values.Enabled = False
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		lm_dw.m_table.m_restorerow.Enabled = False
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
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
lm_dw.m_table.m_insert.Enabled = False
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

type cb_1 from commandbutton within u_tabpg_contract_locations_maha
event ue_add ( )
boolean visible = false
integer x = 1024
integer y = 2828
integer width = 859
integer height = 112
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Multi Location group"
end type

event ue_add();openwithparm(w_contract_grp_add, parent)
end event

event clicked;
parent.event ue_add( )

end event

type cb_3 from commandbutton within u_tabpg_contract_locations_maha
boolean visible = false
integer x = 2747
integer y = 2824
integer width = 645
integer height = 112
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Contacts (type L)"
end type

type cb_4 from commandbutton within u_tabpg_contract_locations_maha
boolean visible = false
integer x = 2080
integer y = 2840
integer width = 517
integer height = 112
integer taborder = 51
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "delete detail"
end type

event clicked;

dw_detail.deleterow(dw_detail.getrow())
end event

type cb_5 from commandbutton within u_tabpg_contract_locations_maha
boolean visible = false
integer x = 315
integer y = 2816
integer width = 457
integer height = 112
integer taborder = 61
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;
dw_main.setfocus( )
parent.event ue_delete( )
end event

type gb_4 from u_gb within u_tabpg_contract_locations_maha
boolean visible = false
integer x = 87
integer y = 44
integer width = 3543
integer height = 180
integer taborder = 11
integer weight = 400
string text = "Contracted Entity"
end type

type dw_doctors from u_dw_contract within u_tabpg_contract_locations_maha
event ue_retrievstart ( )
string tag = "Associated Physicians for Selected Facility"
integer x = 1888
integer width = 1938
integer height = 660
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Associated Providers for Selected Facility"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean ib_rmbmenu = false
string dataobject_original = "d_contract_group_practitioners_existing"
boolean ib_allow_sort = true
end type

event ue_retrievstart();

long ll_count
LONG LL_REC_ID
long ll_ctx_id
long ll_parent_comp_id

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-22 By: Liu Hongxin
//$<reason> Move this line above.
if dw_detail.rowcount( ) < 1 then return 
//---------------------------- APPEON END ----------------------------

n_ds lds_location_pracs
lds_location_pracs = create N_ds
lds_location_pracs.dataobject = 'ds_location_pracs'
lds_location_pracs.settransobject(sqlca)

n_ds lds_location_pracs_existing
lds_location_pracs_existing = create N_ds
lds_location_pracs_existing.dataobject = 'd_contract_group_practitioners_existing'
lds_location_pracs_existing.settransobject(sqlca)

n_ds ids_pracs
ids_pracs = create n_ds
ids_pracs.dataobject=  'd_ctx_group_practitioners'//'dS_contract_group_practitioners'
ids_pracs.settransobject(sqlca)


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.05.2006 By: Liang QingShi
//$<reason> 
/*
if dw_detail.rowcount( ) < 1 then return 

try
	LL_REC_ID = dw_detail.OBJECT.loc_id[dw_detail.GETROW()] // dw_detail.OBJECT.rec_id[dw_detail.GETROW()]

	ll_ctx_id = inv_contract_details.of_get_ctx_id( )
	// make sure we do =retieve it again!!!
	
   //////////////////////////////////////////////////////////////////
	// get all of the pracs for this group practice asssoc with this contract
	/////////////////////////////////////////////////////////////////
	long ll_existing_count
	ll_existing_count = lds_location_pracs_existing.retrieve(dw_detail.OBJECT.rec_id[dw_detail.GETROW()], ll_ctx_id, dw_detail.OBJECT.parent_comp_id[dw_detail.GETROW()] )
	
	//////////////////////////////////////////////////////////////////
	// get all of the pracs for that are existing for this location
	/////////////////////////////////////////////////////////////////
	long ll_pracs_for_loc_cnt
	ll_pracs_for_loc_cnt = ids_pracs.retrieve(dw_detail.object.rec_id[dw_detail.getRow()])
//	messagebox('ll_pracs_for_loc_cnt',ll_pracs_for_loc_cnt)
	//////////////////////////////////////////////////////////////////
	// add all that do not exist and update
	/////////////////////////////////////////////////////////////////
	long ll_found_row
	long ll_i
	long ll_current_row
	if ll_existing_count < ll_pracs_for_loc_cnt     then 
		if ll_existing_count = 0 then 
			for ll_i = 1 to ll_pracs_for_loc_cnt
			
				   ll_current_row = lds_location_pracs.insertrow(0)
				   lds_location_pracs.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
					lds_location_pracs.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[dw_main.getrow()] )
					lds_location_pracs.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[dw_detail.GETROW()]  )
					lds_location_pracs.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[dw_detail.GETROW()] )
					lds_location_pracs.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
					lds_location_pracs.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())
			
			
		next
		lds_location_pracs.of_update(true,true)
	else 
		
		for ll_i = 1 to ll_pracs_for_loc_cnt
			// check to see if the prac_id exists already
			ll_found_row = lds_location_pracs_existing.find("prac_id = " + string(ids_pracs.object.prac_id[ll_i])  , 1, ids_pracs.rowcount())
			if ll_found_row < 1 then
				   ll_current_row = lds_location_pracs.insertrow(0)
				//	messagebox('ll_pracs_for_loc_cnt','insert row')
				   lds_location_pracs.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
					lds_location_pracs.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[dw_main.getrow()] )
					lds_location_pracs.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[dw_detail.GETROW()]  )
					lds_location_pracs.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[dw_detail.GETROW()] )
					lds_location_pracs.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
					lds_location_pracs.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())
				
			end  if
			
		next
		lds_location_pracs.of_update(true,true)
	end if 
	
	end if
	
//	if ll_count > 0 then 
//		   this.dataobject	= 'd_contract_group_practitioners_existing'
//	else 
//		 this.dataobject	=  'd_contract_group_practitioners'
//	end  if 
//	
//	settransobject(sqlca)
//	
	this.retrieve(dw_detail.OBJECT.rec_id[dw_detail.GETROW()], ll_ctx_id, dw_detail.OBJECT.parent_comp_id[dw_detail.GETROW()] )
	
	//---------------------------- APPEON END ----------------------------
	
	event ue_populatedddws( )
	
catch (runtimeerror rte)
	
FINALLY
	//this.reset( )
END TRY
*/
	long ll_row,ll_dw_main_row
	long ll_existing_count,ll_prac_id
	long ll_pracs_for_loc_cnt
	long ll_found_row
	long ll_i
	long ll_current_row
	
	ll_row = dw_detail.GETROW()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.26.2007 By: Frank.Gui
	//$<reason> If all rows have been deleted, an error may occurs withou the following row.
	IF ll_row < 1 then return	
	//---------------------------- APPEON END ----------------------------

	ll_dw_main_row = dw_main.getrow()
	
	ll_ctx_id = inv_contract_details.of_get_ctx_id( )
	ll_rec_id = dw_detail.getitemnumber(ll_row,'rec_id')
	ll_parent_comp_id = dw_detail.getitemnumber(ll_row,'parent_comp_id')	
	
	gnv_appeondb.of_StartQueue()
	ll_existing_count = lds_location_pracs_existing.retrieve(ll_rec_id, ll_ctx_id, ll_parent_comp_id )	
	ll_pracs_for_loc_cnt = ids_pracs.retrieve(ll_rec_id)
	gnv_appeondb.of_CommitQueue()
	ll_existing_count = lds_location_pracs_existing.RowCount()
	ll_pracs_for_loc_cnt = ids_pracs.RowCount()

	//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
	//Start Code Change ----07.06.2011 #V11 maha - recoded to remove no longer connected links - bug correction
	//lds_location_pracs_existing = prac records connected to the contract location
	//ids_pracs = the pracs connected to the group
	
	for ll_i =  ll_existing_count to 1 step - 1
		ll_prac_id = lds_location_pracs_existing.getitemnumber(ll_i,"prac_id")
		ll_found_row = ids_pracs.find( "prac_id = " + string(ll_prac_id), 1, ll_pracs_for_loc_cnt )
		if ll_found_row = 0 then
			lds_location_pracs_existing.deleterow(ll_i)
		end if
	next
	
	for ll_i = 1 to ll_pracs_for_loc_cnt
		ll_prac_id = ids_pracs.object.prac_id[ll_i]
		ll_found_row = lds_location_pracs_existing.find("prac_id = " + string(ll_prac_id)  , 1, ids_pracs.rowcount())
		if ll_found_row = 0 then
			ll_current_row = lds_location_pracs_existing.insertrow(0)
			lds_location_pracs_existing.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
			lds_location_pracs_existing.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[ll_dw_main_row] )
			lds_location_pracs_existing.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[ll_row]  )
			//lds_location_pracs_existing.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[ll_row] )
			lds_location_pracs_existing.setItem(ll_current_row,'pracs_gp_rec_id'     ,dw_detail.OBJECT.rec_id[ll_row] )
			lds_location_pracs_existing.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
			lds_location_pracs_existing.setItem(ll_current_row,'ctx_location_pracs_status'        ,inv_contract_details.of_get_par_unknown())		
			//lds_location_pracs_existing.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())
		end  if	
	next
	
//	if ll_existing_count < ll_pracs_for_loc_cnt then 
//		if ll_existing_count = 0 then 
//			for ll_i = 1 to ll_pracs_for_loc_cnt			
//				ll_current_row = lds_location_pracs.insertrow(0)
//				lds_location_pracs.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
//				lds_location_pracs.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[ll_dw_main_row] )
//				lds_location_pracs.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[ll_row]  )
//				lds_location_pracs.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[ll_row] )
//				lds_location_pracs.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
//				lds_location_pracs.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())						
//			next
//			//lds_location_pracs.of_update(true,true)
//		else 		
//			for ll_i = 1 to ll_pracs_for_loc_cnt
//				// check to see if the prac_id exists already
//				ll_prac_id = ids_pracs.object.prac_id[ll_i]
//				ll_found_row = lds_location_pracs_existing.find("prac_id = " + string(ll_prac_id)  , 1, ids_pracs.rowcount())
//				if ll_found_row < 1 then
//					ll_current_row = lds_location_pracs.insertrow(0)
//					lds_location_pracs.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
//					lds_location_pracs.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[ll_dw_main_row] )
//					lds_location_pracs.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[ll_row]  )
//					lds_location_pracs.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[ll_row] )
//					lds_location_pracs.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
//					lds_location_pracs.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())					
//				end  if				
//			next
//			//lds_location_pracs.of_update(true,true)
//		end if 	
//	end if
	
	gnv_appeondb.of_StartQueue()
	lds_location_pracs_existing.update()
	//lds_location_pracs.update()
	this.retrieve(ll_rec_id, ll_ctx_id, ll_parent_comp_id )
	gnv_appeondb.of_CommitQueue()
	event ue_populatedddws( )
//End Code Change ----07.06.2011 #V11 maha	
//---------------------------- APPEON END ----------------------------

end event

event pfc_addrow;


// OVERRIDE 

DW_MAin.event pfc_addrow( )


return success
end event

event pfc_preupdate;
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
**  Created By	: Michael B. Skinner 28 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//long ll_i,ll_count
//dwItemStatus l_status
//long ll_status
// SELECT code_lookup.lookup_code  
// into :ll_status   
// FROM code_lookup  
// WHERE code_lookup.lookup_name = 'Contract Practitioner Contract Stat'  
//	    and code_lookup.code = 'Par. Unknown.';
//
//
//for ll_i = 1 to rowcount()
//	IF NOT F_VALIDSTR(STRING(object.ctx_id[ll_i] )) THEN 
//		
//	  object.loc_id[ll_i] 			 = dw_detail.object.loc_id[dw_detail.getrow()] 
//	  object.ctx_id[ll_i] 			 = INV_contract_details.OF_get_ctx_id( )
//	  object.parent_comp_id[ll_i]  = dw_detail.object.parent_comp_id[dw_detail.GETROW()]
//	  object.pracs_gp_rec_id[ll_i] = dw_detail.object.rec_id[dw_detail.GETROW()] 
//	  object.ctx_location_pracs_status[ll_i] = ll_status
//	  object.ctx_location_pracs_prac_id[ll_i] =  object.prac_id[ll_i]
//	  
//     l_status = GetItemStatus(ll_i,0 , Primary!)
//	  
//	  long ll_loc_id, ll_parent_comp_id,ll_gp_rec_id,ll_prac_id,ll_ctx_id
//	  
//	  select count(*)
//	  into :ll_count
//	  from ctx_location_pracs 
//	  where ctx_id         = :ll_ctx_id and
//	  		  parent_comp_id = :ll_parent_comp_id and 
//			  loc_id         = :ll_loc_id and 
//			  gp_rec_id      = :ll_gp_rec_id and 
//			  prac_id         =:ll_prac_id ;
//			  
//			  
//	if ll_count > 0 then 
//		// update
//		SetItemStatus(ll_i, 0, Primary!, datamodified!)
//	else 
//		// 
//		//insert
//		SetItemStatus(ll_i, 0, Primary!, NewModified!)
//	end if 
//			  
//end if
//next
//
return success

end event

event retrieveend;call super::retrieveend;
this.title =  'Associated Physicians for Selected Facility (' + string(rowcount)  +')'
end event

event updateend;call super::updateend;// (Appeon)Harry 06.07.2013 - V141 ISG-CLX
//Retore to Extend Ancestor Script - alfee 03.23.2009
//// override for now
//
//
//commit;
end event

event constructor;call super::constructor;
this.of_SetDropDownCalendar(TRUE)
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.06.2006 By: LeiWei
//$<reason> Performance tuning.
/*
this.iuo_calendar.of_Register("start_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("end_date", this.iuo_calendar.DDLB_WITHARROW	)
*/
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanged;//Override Ancestor's Script
end event

event rowfocuschanging;//Override Ancestor's Script
end event

type dw_spec from u_dw_contract within u_tabpg_contract_locations_maha
string tag = "Specialties for Selected Facility"
integer x = 1883
integer y = 680
integer width = 1970
integer height = 660
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Specialties for Selected Facility"
string dataobject = "d_cntx_location_spec"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
string is_updatesallowed = "IU"
string dataobject_original = "d_cntx_location_spec"
boolean ib_allow_sort = true
end type

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
**  Created By	: Michael B. Skinner 28 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i,ll_prac_specialty


for ll_i = 1 to rowcount()
	ll_prac_specialty = this.getitemnumber(ll_i,'prac_specialty')
	dw_detail.object.loc_id[dw_detail.getrow()] = object.loc_id[ll_i]
	THIS.object.ctx_id[ll_i] = INV_contract_details.OF_get_ctx_id( )
	THIS.object.parent_comp_id[ll_i] = dw_detail.object.parent_comp_id[dw_detail.GETROW()] 
next

return success
end event

event itemchanged;
/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	 override  
**==================================================================================================================
**  Created By	: Michael B. Skinner xx August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
datawindowchild child
long ll_found


this.getchild( 'prac_specialty', child)

ll_found = dw_spec.Find("prac_specialty = " + string(child.getItemNumber(child.getrow(),'lookup_code')), 0, this.RowCount())

if ll_found > 0 then 
	 messagebox(iw_parent.title, 'This specialty already exists, please select another.' )
	 this.deleterow( row)
end if 

super::event itemchanged(row,dwo,data )

return 0
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;



long ll_i


// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return failure
// mskinner 05 april 2006 -- END


for ll_i = 1 to rowcount()
     IF of_show_missing_msg('prac_specialty', THIS, 'number', ll_i)	=  failure THEN
	    RETURN Failure
	END IF
	
next


return success
end event

event retrieveend;call super::retrieveend;

this.title =  'Specialties for Selected Facility (' + string(rowcount)  +')'
end event

event pfc_validation;call super::pfc_validation;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.25.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.

long ll_i
for ll_i = 1 to this.rowcount()

	if not f_validstr(string(this.object.prac_specialty[ll_i])) then 
		messagebox('Missing Data', 'The specialty is a required column' )
		return failure
	end if
	
next

return success
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanging;//Override Ancestor's Script
end event

event rowfocuschanged;//Override Ancestor's Script
end event

event pfc_addrow;if dw_detail.rowcount( ) < 1 then 
   return DW_MAin.event pfc_addrow( )
END IF

return super::event pfc_addrow()
end event

event retrievestart;call super::retrievestart;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.19.2007 By: Jack
//$<reason> Fix a defect.
//long ll_ctx_id
//ll_ctx_id = inv_contract_details.of_get_ctx_id( )
//this.setfilter("ctx_id = " + string(ll_ctx_id))
//this.filter()
//---------------------------- APPEON END ----------------------------

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
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
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
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

ll_Right = w_mdi.of_security_access(2120)				//Access Rights
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
	lm_dw.m_table.m_insert.Enabled = Not lb_readonly
	lm_dw.m_table.m_addrow.Enabled = Not lb_readonly
	lm_dw.m_table.m_delete.Enabled = Not lb_readonly
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		lm_dw.m_table.m_delete.Enabled = lb_desired
		lm_dw.m_table.m_insert.Enabled = lb_desired
	End If
	
Case Else
	lm_dw.m_table.m_insert.Enabled = False
	lm_dw.m_table.m_delete.Enabled = False
	lm_dw.m_table.m_addrow.Enabled = False
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
lm_dw.m_table.m_copy.Enabled = False
lm_dw.m_table.m_cut.Enabled = False
lm_dw.m_table.m_paste.Enabled = False
lm_dw.m_table.m_selectall.Enabled = False

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

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			lm_dw.m_table.m_restorerow.Enabled = True
		Else
			lm_dw.m_table.m_restorerow.Enabled = False
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	lm_dw.m_table.m_restorerow.Enabled = False
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
lm_dw.m_table.m_operators.Enabled = False
lm_dw.m_table.m_values.Visible = False
lm_dw.m_table.m_values.Enabled = False
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		lm_dw.m_table.m_restorerow.Enabled = False
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
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
lm_dw.m_table.m_insert.Enabled = False
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

type dw_detail from u_dw_contract within u_tabpg_contract_locations_maha
string tag = " Group / Locations"
integer x = 128
integer y = 8
integer width = 192
integer height = 168
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Group / Locations"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean ib_rmbmenu = false
string dataobject_original = "d_contract_group_linked_locations"
end type

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

dwItemStatus l_status

long ll_i

for ll_i = 1 to this.rowcount( )
	IF ISNULL(this.object.ctx_id[ll_i] ) THEN
	 this.object.ctx_id[ll_i] = inv_contract_details.of_get_ctx_id( )
	 this.object.parent_comp_id[ll_i] = dw_main.object.parent_comp_id[dw_main.getrow()]
END IF
	
next

////////////////////////////////////////////////////////////////////////////////////
// turn on multitabel update if appropraite
////////////////////////////////////////////////////////////////////////////////////

THIS.of_SetMultiTable(FALSE)

for ll_i = 1 to this.rowcount( )
		l_status = this.GetItemStatus(ll_i, 0, PRIMARY!)
		if l_status = datamodified! then
			of_set_multitab( )
			return success
		end if
		
next




return success
end event

event constructor;this.of_settransobject( sqlca)


this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

ib_rmbmenu	= true

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: Liang QingShi
//$<reason> Fix a defect.
of_allow_sort()

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-07-13 By: Scofield
//$<Reason> Cancel the ControlMenu display
This.maxbox = False
This.Minbox = False
//---------------------------- APPEON END ----------------------------

end event

event retrieveend;call super::retrieveend;


dw_detail.of_SetMultiTable(TRUE)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10.11.2006 By: LeiWei
//$<reason> Fix a defect.
//this.title =  'Facilities (' + string(rowcount)  +')'
this.title =  'Group / Locations (' + string(rowcount)  +')'
//---------------------------- APPEON END ----------------------------

end event

event editchanged;call super::editchanged;


dw_main.inv_linkage.of_SetUpdateOnRowChange(TRUE)
dw_detail.inv_linkage.of_SetUpdateOnRowChange(TRUE)
end event

event pfc_deleterow;


long ll_selected_row
ll_selected_row = getselectedrow(0)
If of_check_read_only( ) Then Return failure  //Add by Jack 07.13.2007

if ll_selected_row < 1 then 
	messagebox(iw_parent.title, 'Please select a row.' )
else 
	if MessageBox('Confirm Delete', 'Are you sure you want to delete this row?',Question!,yesno!,1) = 1 then   //Modified by Scofield on 2008-03-11
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 09.04.2006 By: Liang QingShi
		//$<reason> Contract module modification
		//$<reason> Fix a defect.
			
		long ll_ctx_id 
		long ll_parent_comp_id,ll_loc_id,ll_rec_id
		if this.getrow() > 0 then
			ll_ctx_id = this.getitemnumber(this.getrow(),'ctx_id')
			ll_parent_comp_id = this.getitemnumber(this.getrow(),'parent_comp_id')	
			ll_loc_id = this.getitemnumber(this.getrow(),'loc_id')	
			ll_rec_id = this.getitemnumber(this.getrow(),'rec_id')
		else
			return success
		end if
		if gs_dbtype <> "ASA" then
			
			gnv_appeondb.of_startqueue( )	
			DELETE FROM  CTX_LOCATION_PRACS WHERE ctx_id = :ll_ctx_id and parent_comp_id = :ll_parent_comp_id and loc_id = :ll_rec_id;
			DELETE FROM  CTX_LOCATION_SPECIALTY WHERE ctx_id = :ll_ctx_id and loc_id = :ll_loc_id;		
			DELETE FROM  CTX_LOCATION_CONTACTS WHERE ctx_id = :ll_ctx_id and parent_comp_id = :ll_parent_comp_id and loc_id = :ll_loc_id;
			commit;
			gnv_appeondb.of_commitqueue( )
		end if
		//---------------------------- APPEON END ----------------------------
		deleterow(getrow())
		dw_doctors.reset()
		dw_spec.reset( )
		parent.of_update( true, true)
		this.event rowfocuschanged(1)
		IF this.ROWcount( ) > 0 then 
			this.SelectRow(1, true)
		end if 
   end if
end if 

return success
end event

event pfc_addrow;// OVERRIDE 

DW_MAin.event pfc_addrow( )


return success
end event

event doubleclicked;call super::doubleclicked;
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
**  Created By	: Michael B. Skinner 28 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

str_pass lstr_pass


// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return failure
// mskinner 05 april 2006 -- END


choose case dwo.name
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 09.19.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	/*
	case 'p_contact_info'
	*/
	case 'p_contact_info','p_contact_info_1'	
	//---------------------------- APPEON END ----------------------------
		   lstr_pass.s_long[1] = long(this.object.loc_id[row])
			//mskinner 13 april 2006 -- begin
			lstr_pass.s_long[2] = inv_contract_details.of_get_ctx_id( )
			lstr_pass.s_long[3] = long(this.object.parent_comp_id[row]) 
			//mskinner 13 april 2006 -- end
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 09.27.2006 By: Liang QingShi
			//$<reason> Fix a defect.
			lstr_pass.s_u_dw = dw_detail
			//---------------------------- APPEON END ----------------------------
			
			openwithparm(w_contract_contact_cnt_info, lstr_pass )
		
	case else
end choose

end event

event rowfocuschanged;call super::rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-20 By: Liu Hongxin
//$<reason> Performance tuning: Control row changx event.
IF this.RowCount() < 1 THEN RETURN
//---------------------------- APPEON END ----------------------------

dw_doctors.event ue_retrievstart( )
end event

event rowfocuschanging;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-22 By: Liu Hongxin
//$<reason> Performance tuning: override ancestral script.
//---------------------------- APPEON END ----------------------------

end event

type dw_linked_providers from u_dw_contract within u_tabpg_contract_locations_maha
event ue_retrievstart ( )
string tag = "Directly Linked Providers"
integer x = 1893
integer y = 1372
integer width = 1938
integer height = 660
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Directly Linked Providers"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean ib_rmbmenu = false
string dataobject_original = "d_contract_group_practitioners_existing"
boolean ib_allow_sort = true
end type

event ue_retrievstart();

long ll_count
LONG LL_REC_ID
long ll_ctx_id
long ll_parent_comp_id

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-22 By: Liu Hongxin
//$<reason> Move this line above.
if dw_detail.rowcount( ) < 1 then return 
//---------------------------- APPEON END ----------------------------

n_ds lds_location_pracs
lds_location_pracs = create N_ds
lds_location_pracs.dataobject = 'ds_location_pracs'
lds_location_pracs.settransobject(sqlca)

n_ds lds_location_pracs_existing
lds_location_pracs_existing = create N_ds
lds_location_pracs_existing.dataobject = 'd_contract_group_practitioners_existing'
lds_location_pracs_existing.settransobject(sqlca)

n_ds ids_pracs
ids_pracs = create n_ds
ids_pracs.dataobject=  'd_ctx_group_practitioners'//'dS_contract_group_practitioners'
ids_pracs.settransobject(sqlca)


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.05.2006 By: Liang QingShi
//$<reason> 
/*
if dw_detail.rowcount( ) < 1 then return 

try
	LL_REC_ID = dw_detail.OBJECT.loc_id[dw_detail.GETROW()] // dw_detail.OBJECT.rec_id[dw_detail.GETROW()]

	ll_ctx_id = inv_contract_details.of_get_ctx_id( )
	// make sure we do =retieve it again!!!
	
   //////////////////////////////////////////////////////////////////
	// get all of the pracs for this group practice asssoc with this contract
	/////////////////////////////////////////////////////////////////
	long ll_existing_count
	ll_existing_count = lds_location_pracs_existing.retrieve(dw_detail.OBJECT.rec_id[dw_detail.GETROW()], ll_ctx_id, dw_detail.OBJECT.parent_comp_id[dw_detail.GETROW()] )
	
	//////////////////////////////////////////////////////////////////
	// get all of the pracs for that are existing for this location
	/////////////////////////////////////////////////////////////////
	long ll_pracs_for_loc_cnt
	ll_pracs_for_loc_cnt = ids_pracs.retrieve(dw_detail.object.rec_id[dw_detail.getRow()])
//	messagebox('ll_pracs_for_loc_cnt',ll_pracs_for_loc_cnt)
	//////////////////////////////////////////////////////////////////
	// add all that do not exist and update
	/////////////////////////////////////////////////////////////////
	long ll_found_row
	long ll_i
	long ll_current_row
	if ll_existing_count < ll_pracs_for_loc_cnt     then 
		if ll_existing_count = 0 then 
			for ll_i = 1 to ll_pracs_for_loc_cnt
			
				   ll_current_row = lds_location_pracs.insertrow(0)
				   lds_location_pracs.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
					lds_location_pracs.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[dw_main.getrow()] )
					lds_location_pracs.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[dw_detail.GETROW()]  )
					lds_location_pracs.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[dw_detail.GETROW()] )
					lds_location_pracs.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
					lds_location_pracs.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())
			
			
		next
		lds_location_pracs.of_update(true,true)
	else 
		
		for ll_i = 1 to ll_pracs_for_loc_cnt
			// check to see if the prac_id exists already
			ll_found_row = lds_location_pracs_existing.find("prac_id = " + string(ids_pracs.object.prac_id[ll_i])  , 1, ids_pracs.rowcount())
			if ll_found_row < 1 then
				   ll_current_row = lds_location_pracs.insertrow(0)
				//	messagebox('ll_pracs_for_loc_cnt','insert row')
				   lds_location_pracs.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
					lds_location_pracs.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[dw_main.getrow()] )
					lds_location_pracs.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[dw_detail.GETROW()]  )
					lds_location_pracs.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[dw_detail.GETROW()] )
					lds_location_pracs.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
					lds_location_pracs.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())
				
			end  if
			
		next
		lds_location_pracs.of_update(true,true)
	end if 
	
	end if
	
//	if ll_count > 0 then 
//		   this.dataobject	= 'd_contract_group_practitioners_existing'
//	else 
//		 this.dataobject	=  'd_contract_group_practitioners'
//	end  if 
//	
//	settransobject(sqlca)
//	
	this.retrieve(dw_detail.OBJECT.rec_id[dw_detail.GETROW()], ll_ctx_id, dw_detail.OBJECT.parent_comp_id[dw_detail.GETROW()] )
	
	//---------------------------- APPEON END ----------------------------
	
	event ue_populatedddws( )
	
catch (runtimeerror rte)
	
FINALLY
	//this.reset( )
END TRY
*/
	long ll_row,ll_dw_main_row
	long ll_existing_count,ll_prac_id
	long ll_pracs_for_loc_cnt
	long ll_found_row
	long ll_i
	long ll_current_row
	
	ll_row = dw_detail.GETROW()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.26.2007 By: Frank.Gui
	//$<reason> If all rows have been deleted, an error may occurs withou the following row.
	IF ll_row < 1 then return	
	//---------------------------- APPEON END ----------------------------

	ll_dw_main_row = dw_main.getrow()
	
	ll_ctx_id = inv_contract_details.of_get_ctx_id( )
	ll_rec_id = dw_detail.getitemnumber(ll_row,'rec_id')
	ll_parent_comp_id = dw_detail.getitemnumber(ll_row,'parent_comp_id')	
	
	gnv_appeondb.of_StartQueue()
	ll_existing_count = lds_location_pracs_existing.retrieve(ll_rec_id, ll_ctx_id, ll_parent_comp_id )	
	ll_pracs_for_loc_cnt = ids_pracs.retrieve(ll_rec_id)
	gnv_appeondb.of_CommitQueue()
	ll_existing_count = lds_location_pracs_existing.RowCount()
	ll_pracs_for_loc_cnt = ids_pracs.RowCount()

	//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
	//Start Code Change ----07.06.2011 #V11 maha - recoded to remove no longer connected links - bug correction
	//lds_location_pracs_existing = prac records connected to the contract location
	//ids_pracs = the pracs connected to the group
	
	for ll_i =  ll_existing_count to 1 step - 1
		ll_prac_id = lds_location_pracs_existing.getitemnumber(ll_i,"prac_id")
		ll_found_row = ids_pracs.find( "prac_id = " + string(ll_prac_id), 1, ll_pracs_for_loc_cnt )
		if ll_found_row = 0 then
			lds_location_pracs_existing.deleterow(ll_i)
		end if
	next
	
	for ll_i = 1 to ll_pracs_for_loc_cnt
		ll_prac_id = ids_pracs.object.prac_id[ll_i]
		ll_found_row = lds_location_pracs_existing.find("prac_id = " + string(ll_prac_id)  , 1, ids_pracs.rowcount())
		if ll_found_row = 0 then
			ll_current_row = lds_location_pracs_existing.insertrow(0)
			lds_location_pracs_existing.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
			lds_location_pracs_existing.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[ll_dw_main_row] )
			lds_location_pracs_existing.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[ll_row]  )
			//lds_location_pracs_existing.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[ll_row] )
			lds_location_pracs_existing.setItem(ll_current_row,'pracs_gp_rec_id'     ,dw_detail.OBJECT.rec_id[ll_row] )
			lds_location_pracs_existing.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
			lds_location_pracs_existing.setItem(ll_current_row,'ctx_location_pracs_status'        ,inv_contract_details.of_get_par_unknown())		
			//lds_location_pracs_existing.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())
		end  if	
	next
	
//	if ll_existing_count < ll_pracs_for_loc_cnt then 
//		if ll_existing_count = 0 then 
//			for ll_i = 1 to ll_pracs_for_loc_cnt			
//				ll_current_row = lds_location_pracs.insertrow(0)
//				lds_location_pracs.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
//				lds_location_pracs.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[ll_dw_main_row] )
//				lds_location_pracs.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[ll_row]  )
//				lds_location_pracs.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[ll_row] )
//				lds_location_pracs.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
//				lds_location_pracs.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())						
//			next
//			//lds_location_pracs.of_update(true,true)
//		else 		
//			for ll_i = 1 to ll_pracs_for_loc_cnt
//				// check to see if the prac_id exists already
//				ll_prac_id = ids_pracs.object.prac_id[ll_i]
//				ll_found_row = lds_location_pracs_existing.find("prac_id = " + string(ll_prac_id)  , 1, ids_pracs.rowcount())
//				if ll_found_row < 1 then
//					ll_current_row = lds_location_pracs.insertrow(0)
//					lds_location_pracs.setItem(ll_current_row,'ctx_id',       inv_contract_details.of_get_ctx_id( ) )
//					lds_location_pracs.setItem(ll_current_row,'parent_comp_id',dw_main.object.parent_comp_id[ll_dw_main_row] )
//					lds_location_pracs.setItem(ll_current_row,'loc_id'  ,dw_detail.OBJECT.loc_id[ll_row]  )
//					lds_location_pracs.setItem(ll_current_row,'gp_rec_id'     ,dw_detail.OBJECT.rec_id[ll_row] )
//					lds_location_pracs.setItem(ll_current_row,'prac_id'       ,ids_pracs.GetItemNumber(ll_i,'prac_id'))
//					lds_location_pracs.setItem(ll_current_row,'status'        ,inv_contract_details.of_get_par_unknown())					
//				end  if				
//			next
//			//lds_location_pracs.of_update(true,true)
//		end if 	
//	end if
	
	gnv_appeondb.of_StartQueue()
	lds_location_pracs_existing.update()
	//lds_location_pracs.update()
	this.retrieve(ll_rec_id, ll_ctx_id, ll_parent_comp_id )
	gnv_appeondb.of_CommitQueue()
	event ue_populatedddws( )
//End Code Change ----07.06.2011 #V11 maha	
//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;
this.of_SetDropDownCalendar(TRUE)
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.06.2006 By: LeiWei
//$<reason> Performance tuning.
/*
this.iuo_calendar.of_Register("start_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("end_date", this.iuo_calendar.DDLB_WITHARROW	)
*/
//---------------------------- APPEON END ----------------------------

end event

event retrieveend;call super::retrieveend;
this.title =  'Associated Physicians for Selected Facility (' + string(rowcount)  +')'
end event

event rowfocuschanged;//Override Ancestor's Script
end event

event rowfocuschanging;//Override Ancestor's Script
end event

event updateend;call super::updateend;// (Appeon)Harry 06.07.2013 - V141 ISG-CLX
//Retore to Extend Ancestor Script - alfee 03.23.2009
//// override for now
//
//
//commit;
end event

event pfc_addrow;


// OVERRIDE 

DW_MAin.event pfc_addrow( )


return success
end event

event pfc_preupdate;
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
**  Created By	: Michael B. Skinner 28 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//long ll_i,ll_count
//dwItemStatus l_status
//long ll_status
// SELECT code_lookup.lookup_code  
// into :ll_status   
// FROM code_lookup  
// WHERE code_lookup.lookup_name = 'Contract Practitioner Contract Stat'  
//	    and code_lookup.code = 'Par. Unknown.';
//
//
//for ll_i = 1 to rowcount()
//	IF NOT F_VALIDSTR(STRING(object.ctx_id[ll_i] )) THEN 
//		
//	  object.loc_id[ll_i] 			 = dw_detail.object.loc_id[dw_detail.getrow()] 
//	  object.ctx_id[ll_i] 			 = INV_contract_details.OF_get_ctx_id( )
//	  object.parent_comp_id[ll_i]  = dw_detail.object.parent_comp_id[dw_detail.GETROW()]
//	  object.pracs_gp_rec_id[ll_i] = dw_detail.object.rec_id[dw_detail.GETROW()] 
//	  object.ctx_location_pracs_status[ll_i] = ll_status
//	  object.ctx_location_pracs_prac_id[ll_i] =  object.prac_id[ll_i]
//	  
//     l_status = GetItemStatus(ll_i,0 , Primary!)
//	  
//	  long ll_loc_id, ll_parent_comp_id,ll_gp_rec_id,ll_prac_id,ll_ctx_id
//	  
//	  select count(*)
//	  into :ll_count
//	  from ctx_location_pracs 
//	  where ctx_id         = :ll_ctx_id and
//	  		  parent_comp_id = :ll_parent_comp_id and 
//			  loc_id         = :ll_loc_id and 
//			  gp_rec_id      = :ll_gp_rec_id and 
//			  prac_id         =:ll_prac_id ;
//			  
//			  
//	if ll_count > 0 then 
//		// update
//		SetItemStatus(ll_i, 0, Primary!, datamodified!)
//	else 
//		// 
//		//insert
//		SetItemStatus(ll_i, 0, Primary!, NewModified!)
//	end if 
//			  
//end if
//next
//
return success

end event

