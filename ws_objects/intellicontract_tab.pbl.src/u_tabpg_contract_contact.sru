$PBExportHeader$u_tabpg_contract_contact.sru
$PBExportComments$[intellicontract_tab]  The contract contacts Tab Page
forward
global type u_tabpg_contract_contact from u_tabpg_contract_master
end type
type dw_search from u_dw_contract within u_tabpg_contract_contact
end type
type st_2 from u_st_splitbar within u_tabpg_contract_contact
end type
type st_3 from u_st_splitbar within u_tabpg_contract_contact
end type
type dw_detail from u_dw_contract within u_tabpg_contract_contact
end type
type dw_notes from u_dw_contract within u_tabpg_contract_contact
end type
type dw_phone from u_dw_contract within u_tabpg_contract_contact
end type
type st_4 from u_st_splitbar within u_tabpg_contract_contact
end type
end forward

global type u_tabpg_contract_contact from u_tabpg_contract_master
integer width = 3881
integer height = 2028
long backcolor = 33551856
string text = "Contacts"
string powertiptext = "Contacts"
event ue_new_contact ( )
event ue_add ( )
event ue_add_existing ( )
event ue_remove_contact ( )
event ue_set_screen_properties ( )
dw_search dw_search
st_2 st_2
st_3 st_3
dw_detail dw_detail
dw_notes dw_notes
dw_phone dw_phone
st_4 st_4
end type
global u_tabpg_contract_contact u_tabpg_contract_contact

type variables
long il_contact_id
end variables

forward prototypes
public function integer of_retrieve ()
public function long of_get_next_sequence_number ()
public subroutine of_create_dw ()
end prototypes

event ue_new_contact();

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 

dw_detail.reset()
dw_notes.reset()
dw_phone.reset()
dw_detail.insertrow(0)
dw_notes.insertrow(0)
dw_phone.insertrow(0)
end event

event ue_add();//messagebox('ctx_id',string(inv_contract_details.of_get_ctx_id( )))

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 

of_accepttext( true)

if of_validation( ) = failure then return

if of_updatespending( ) = 1 then
	if messagebox(iw_parent.title,'Do you want to save changes',Question!,yesno!,1) = 1 then
		
			if f_validstr(string(inv_contract_details.of_get_ctx_id( ))) then
					 setredraw( false)
					 of_update( true, true)
					 event ue_new_contact( )
					 setredraw(true)
					 
			else // need to save the whole thing
					 setredraw( false)
					 iw_parent.event dynamic ue_save()
					
					 event ue_new_contact( )
					 setredraw(true)
		 end if
	end if
	
else
   event ue_new_contact( )
end if


dw_search.event pfc_retrieve( )
end event

event ue_add_existing();/******************************************************************************************************************
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
// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 

long ll_contact_id,ll_find  //Add 04.27.2007 By: Jack

str_pass lstr_pass
if isnull(INV_contract_details.of_get_ctx_id( )) or INV_contract_details.of_get_ctx_id( ) = 0 then 
	iw_parent.setredraw( false)
	iw_parent.event dynamic ue_save()
	iw_parent.post function dynamic of_select_contact_tab()
	lstr_pass.s_string = 'CONTACT'
		lstr_pass.s_long[1] =  INV_contract_details.of_get_ctx_id( )
		lstr_pass.s_u_dw   = dw_search
		OpenWithParm ( w_contract_contact, lstr_pass)
		ll_contact_id = message.doubleparm  //Add 04.27.2007 By: Jack
		dw_search.event pfc_retrieve( )
	iw_parent.setredraw(true)
	if isnull(INV_contract_details.of_get_ctx_id( )) then
		messagebox(iw_parent.title ,'The contract must be saves prior to adding existing contacts.')
		return 
		
	end if
	
else 
	   lstr_pass.s_string = 'CONTACT'
		lstr_pass.s_long[1] =  INV_contract_details.of_get_ctx_id( )
		lstr_pass.s_u_dw   = dw_search
		OpenWithParm ( w_contract_contact, lstr_pass)
		ll_contact_id = message.doubleparm  //Add 04.27.2007 By: Jack
		IF Not IsNull(ll_contact_id) and ll_contact_id > 0 THEN //Alfee 04.18.2008
			dw_search.RESET( )
			dw_search.event pfc_retrieve( )
		ENd IF
	
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Jack
//$<reason> Fix a defect.
ll_find = dw_search.find("contact_id = " + string(ll_contact_id),1,dw_search.rowcount())
If ll_find > 0 Then
	dw_search.ScrollToRow( ll_find )
	dw_search.SetRow( ll_find )
End If
//---------------------------- APPEON END ----------------------------




end event

event ue_remove_contact();
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
// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 


if dw_search.rowcount() > 0 then
	dw_search.deleterow( dw_search.getrow())
	IF dw_search.ROWcount( ) > 0 then 
	dw_search.SelectRow(1, true)
end if 

end if
end event

event ue_set_screen_properties();// Set screen properties
dw_search.of_set_properties(dw_search.il_ViewID, dw_search.il_ScreenID, "Y")
dw_detail.of_set_properties(dw_detail.il_ViewID, dw_detail.il_ScreenID, "Y")
dw_phone.of_set_properties(dw_phone.il_ViewID, dw_phone.il_ScreenID, "Y")
dw_notes.of_set_properties(dw_notes.il_ViewID, dw_notes.il_ScreenID, "Y")

// Set splitbar back color
st_2.backcolor = this.backcolor
st_3.backcolor = this.backcolor
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
**  Created By	: Michael B. Skinner  23 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if not ib_retrieved then
	 dw_search.event pfc_retrieve( )
end if

ib_retrieved = true
 
 
 
 return success
end function

public function long of_get_next_sequence_number ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_next_sequence_number
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_seq_no

select max(contact_id)
into :ll_seq_no
from  ctx_contacts
using sqlca;

if not f_validstr(string(ll_seq_no)) then
	ll_seq_no  = 1
else
	ll_seq_no =  ll_seq_no + 1
end if 

return ll_seq_no
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_contactof_create_dw()
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

ls_tab_name = 'tabpage_contacts'
ld_dw[1] = dw_search
ld_dw[2] = dw_detail
ld_dw[3] = dw_phone
ld_dw[4] = dw_notes
ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_detail'
ls_dw_name[3] = 'dw_phone'
ls_dw_name[4] = 'dw_notes'
ls_dataobject[1] = 'd_contract_det_contact_contact'
ls_dataobject[2] = 'd_contract_det_contact_contact_det'
ls_dataobject[3] = 'd_contract_det_contact_contact_phone'
ls_dataobject[4] = 'd_contract_det_contact_contact_notes'
f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_contacts',true) 

this.event ue_set_screen_properties( )  //Jervis 08.17.2010
end subroutine

on u_tabpg_contract_contact.create
int iCurrent
call super::create
this.dw_search=create dw_search
this.st_2=create st_2
this.st_3=create st_3
this.dw_detail=create dw_detail
this.dw_notes=create dw_notes
this.dw_phone=create dw_phone
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_search
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.dw_notes
this.Control[iCurrent+6]=this.dw_phone
this.Control[iCurrent+7]=this.st_4
end on

on u_tabpg_contract_contact.destroy
call super::destroy
destroy(this.dw_search)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_detail)
destroy(this.dw_notes)
destroy(this.dw_phone)
destroy(this.st_4)
end on

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : 
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	  
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Liang QingShi
//$<reason> Contract module modification
of_create_dw()
//---------------------------- APPEON END ----------------------------

dw_search.of_SetLinkage(true) // master datawindow
dw_detail.of_SetLinkage(true)
dw_notes.of_SetLinkage(true)
dw_phone.of_SetLinkage(true)


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the linkage stuff
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_detail.inv_linkage.of_SetMaster(dw_search)
dw_detail.inv_linkage.of_Register("ctx_id", "ctx_id") 
dw_detail.inv_linkage.of_Register("ic_area", "ic_area")
dw_detail.inv_linkage.of_Register("contact_id", "contact_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//dw_detail.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve) 
n_cst_dwsrv_linkage lnv_cst_dwsrv_linkage
lnv_cst_dwsrv_linkage = Create n_cst_dwsrv_linkage
dw_detail.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve) 
//---------------------------- APPEON END ----------------------------


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_phone.inv_linkage.of_SetMaster(dw_search ) 
dw_phone.inv_linkage.of_Register("contact_id", "contact_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//dw_phone.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
dw_phone.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
//---------------------------- APPEON END ----------------------------
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_notes.inv_linkage.of_SetMaster(dw_search)
dw_notes.inv_linkage.of_Register("ctx_id", "ctx_id") 
dw_notes.inv_linkage.of_Register("ic_area", "ic_area")
dw_notes.inv_linkage.of_Register("contact_id", "contact_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-03 
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//dw_notes.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
dw_notes.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
Destroy lnv_cst_dwsrv_linkage
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// set the update properties for the datawindows
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_detail.inv_linkage.of_SetUpdateOnRowChange(TRUE)  //
//dw_detail.inv_linkage.of_SetConfirmOnRowChange(TRUE)

dw_phone.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//dw_phone.inv_linkage.of_SetConfirmOnRowChange(TRUE)

dw_notes.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//dw_notes.inv_linkage.of_SetConfirmOnRowChange(TRUE)
//
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// set the delete delete style
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//dw_profile.inv_linkage.of_SetDeleteStyle(dw_profile.inv_linkage.DELETE_ROWS)
//dw_measurement_group.inv_linkage.of_SetDeleteStyle(dw_measurement_group.inv_linkage.bottomup  )
//dw_measurements.inv_linkage.of_SetDeleteStyle(dw_measurements.inv_linkage.bottomup  )
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete properties for the datawindows
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_phone.inv_linkage.of_SetConfirmOnDelete ( true )
dw_detail.inv_linkage.of_SetConfirmOnDelete ( true )
dw_notes.inv_linkage.of_SetConfirmOnDelete ( true )


dw_phone.inv_linkage.of_SetDeleteStyle ( 1 )
dw_detail.inv_linkage.of_SetDeleteStyle ( 1 )
dw_notes.inv_linkage.of_SetDeleteStyle ( 1 )



dw_search.inv_linkage.of_SetTransObject(SQLCA)

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
	//Added By Mark Lee 05/07/12
	this.of_setresize( true)
	this.inv_resize.of_register( dw_search,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_detail,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_notes,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_phone,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_1,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_2,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_3,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_4,inv_resize.scalerightbottom)
	this.inv_resize.of_setminsize( 800, 600 )
end if
end event

event ue_open_contact;call super::ue_open_contact;/******************************************************************************************************************
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

//str_pass lstr_pass
//lstr_pass.s_u_dw = dw_detail
//lstr_pass.s_string = 'CONTACT'
//lstr_pass.w_parent_window = iw_parent
//messagebox('',classname(lstr_pass.w_parent_window))
//OpenWithParm ( w_contract_contact, lstr_pass)

end event

event ue_selectionchanged;call super::ue_selectionchanged;this.dw_search.setfocus( )
end event

event ue_initinstancevar;call super::ue_initinstancevar;il_contact_id = 0
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_contact
integer x = 2889
integer y = 2080
integer width = 1719
end type

type dw_search from u_dw_contract within u_tabpg_contract_contact
string tag = "Contacts List"
integer x = 9
integer y = 16
integer width = 1189
integer height = 1992
integer taborder = 10
boolean titlebar = true
string title = "Contacts List"
string dataobject_original = "d_contract_det_contact_contact"
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
**  Created By	: Michael B. Skinner  23 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_Cycle,ll_RowCnts,ll_Ctx_ID

ll_Ctx_ID = inv_contract_details.of_get_ctx_id()
This.Retrieve(ll_Ctx_ID,'C')

ll_RowCnts = dw_phone.RowCount()
for ll_Cycle =1 to ll_RowCnts
	dw_phone.SetItem(ll_Cycle,"ctx_id",ll_Ctx_ID)
	dw_phone.SetItemStatus(ll_Cycle,"ctx_id",Primary!,NotModified!)		//Added by Scofield on 2009-04-22
next

This.SetFocus()

Return Success

end event

event constructor;call super::constructor;

this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

end event

event pfc_addrow;event ue_add_existing( )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.30.2007 By: Jack
//$<reason> Fix a defect.
this.setfocus()
//---------------------------- APPEON END ----------------------------

return success
end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007-05-09 By: Wu ZhiJun
//$<reason> Fix a bug
Integer	li_Rtn

If of_check_read_only( ) Then Return failure  //Add by Jack 07.13.2007

if This.RowCount() <= 0 then Return success

li_Rtn = MessageBox('Question','Are you sure to delete this contact?',Question!,YesNo!)

if li_Rtn <> 1 then return success
//--------------------------- APPEON END -----------------------------

event ue_remove_contact( )
OF_ENABLE_SAVE( )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.30.2007 By: Jack
//$<reason> Fixed a defect.
dw_search.ScrollToRow(1)
dw_search.SetRow(1)
this.event rowfocuschanged(1)
this.setfocus()
//---------------------------- APPEON END ----------------------------
return success

end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.30.2007 By: Jack
//$<reason> Fix a defect.
this.setfocus()
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
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow
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

// Determine if RMB popup menu should occur
If Not ib_RMBmenu Or IsNull (dwo) Then	Return 1

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

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-05-09 By: Wu ZhiJun
//$<reason> Fix a bug
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//--------------------------- APPEON END -----------------------------

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1


end event

type st_2 from u_st_splitbar within u_tabpg_contract_contact
integer x = 1207
integer y = 16
integer width = 9
integer height = 1992
long backcolor = 128
long bordercolor = 128
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;//this.of_SetResize(TRUE)

this.of_Register(dw_search , LEFT)

this.of_Register(dw_detail , RIGHT)
this.of_Register(dw_notes , RIGHT)
this.of_Register(dw_phone , RIGHT)
this.of_Register(st_4,RIGHT)
this.of_Register(st_3,RIGHT)

this.backcolor = parent.backcolor //Add by Evan 10/14/2008

end event

event lbuttonup;call super::lbuttonup;this.backcolor = parent.backcolor //Add by Evan 10/14/2008

st_3.BringToTop = false		//Added by Scofield on 2009-01-05
st_4.BringToTop = false		//Added by Scofield on 2009-01-05

end event

type st_3 from u_st_splitbar within u_tabpg_contract_contact
integer x = 1221
integer y = 1500
integer width = 2638
fontcharset fontcharset = ansi!
long backcolor = 128
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;this.of_Register(dw_phone, ABOVE)
this.of_Register(dw_notes, BELOW)

This.BackColor = Parent.BackColor //Add by Evan 10/14/2008

end event

event lbuttonup;call super::lbuttonup;this.backcolor = parent.backcolor //Add by Evan 10/14/2008

This.BringToTop = false		//Added by Scofield on 2009-01-05

end event

type dw_detail from u_dw_contract within u_tabpg_contract_contact
string tag = "Contact Details"
integer x = 1221
integer y = 16
integer width = 2638
integer height = 864
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Contact Details"
boolean vscrollbar = false
boolean livescroll = false
string dataobject_original = "d_contract_det_contact_contact_det"
end type

event buttonclicked;call super::buttonclicked;/******************************************************************************************************************
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

str_pass lstr_pass
lstr_pass.s_u_dw = this
lstr_pass.s_string = 'EXTERNAL'
OpenWithParm ( w_contract_contact, lstr_pass)
end event

event pfc_retrieve;call super::pfc_retrieve;



//if dw_search.rowcount() < 1 then return success
//
//
//return this.retrieve(dw_search.object.ctx_id[dw_search.getrow()], &
//							dw_search.object.ic_area[dw_search.getrow()], &
//							dw_search.object.contact_id[dw_search.getrow()])



return success
end event

event doubleclicked;call super::doubleclicked;


PARENT.event ue_open_contact( )



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
**  Created By	: Michael B. Skinner  24 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


if this.rowcount() < 1 THEN RETURN SUCcess

///////////////////////////////////////////////////////////////////////////
////
///////////////////////////////////////////////////////////////////////////



//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.24.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
if not f_validstr(string(this.object.contact_id[this.getrow()] )) then
	parent.il_contact_id = of_get_next_sequence_number() 
	this.object.contact_id[this.getrow()] =  parent.il_contact_id
	this.object.ctx_id[this.getrow()]     =  inv_contract_details.of_get_ctx_id( )
	this.object.ic_area[this.getrow()]    =  'C'
end if
dw_search.object.ctx_contacts_contact_type[dw_search.getrow()] = this.object.ctx_contacts_contact_type[this.getrow()]
*/
if this.getrow() > 0 then
	if not f_validstr(string(this.object.contact_id[this.getrow()] )) then
		parent.il_contact_id = of_get_next_sequence_number() 
		this.object.contact_id[this.getrow()] =  parent.il_contact_id
		this.object.ctx_id[this.getrow()]     =  inv_contract_details.of_get_ctx_id( )
		this.object.ic_area[this.getrow()]    =  'C'
	end if
	dw_search.object.ctx_contacts_contact_type[dw_search.getrow()] = this.object.ctx_contacts_contact_type[this.getrow()]
end if
//---------------------------- APPEON END ----------------------------
//ctx_contacts_contact_type


return success
end event

event pfc_addrow;
// override
dw_search.event pfc_addrow( )

return success
end event

event pfc_deleterow;

dw_search.event pfc_deleterow()


return success

end event

event retrieveend;call super::retrieveend;

if rowcount > 0 then 
	
	setcolumn('ctx_contacts_street_1')
	setfocus()
	
end if
end event

event getfocus;call super::getfocus;this.SetColumn('first_name')
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
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow
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

// Determine if RMB popup menu should occur
If Not ib_RMBmenu Or IsNull (dwo) Then	Return 1

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

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-05-09 By: Wu ZhiJun
//$<reason> Fix a bug
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//--------------------------- APPEON END -----------------------------

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1


end event

type dw_notes from u_dw_contract within u_tabpg_contract_contact
string tag = "Notes"
integer x = 1221
integer y = 1520
integer width = 2638
integer height = 488
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Notes"
boolean vscrollbar = false
string dataobject_original = "d_contract_det_contact_contact_notes"
end type

event pfc_retrieve;call super::pfc_retrieve;


//if dw_search.rowcount( ) < 1 then return success
//
//return this.retrieve(dw_search.object.ctx_id[dw_search.getrow()], &
//							dw_search.object.ic_area[dw_search.getrow()], &
//							dw_search.object.contact_id[dw_search.getrow()])

return success
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
**  Created By	: Michael B. Skinner  24 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if rowcount( ) < 1 then return success

if not f_validstr(string(this.object.contact_id[this.getrow()] )) then
			this.object.contact_id[this.getrow()] =  parent.il_contact_id
			this.object.ctx_id[this.getrow()]     =  inv_contract_details.of_get_ctx_id( )
			this.object.ic_area[this.getrow()]    =  'C'
end if 


return success
end event

event pfc_deleterow;



dw_search.event pfc_deleterow()


return success
end event

event pfc_addrow;



dw_search.event pfc_addrow( )

return success
end event

event rbuttonup;//
end event

type dw_phone from u_dw_contract within u_tabpg_contract_contact
string tag = "Contact Information"
integer x = 1221
integer y = 900
integer width = 2638
integer height = 600
integer taborder = 11
boolean titlebar = true
string title = "Contact Information"
borderstyle borderstyle = stylebox!
string dataobject_original = "d_contract_det_contact_contact_phone"
boolean ib_allow_sort = true
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
**  Created By	: Michael B. Skinner  23 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



//// retrieve the contact info
//if dw_detail.rowcount( ) > 0 THEN
//		retrieve( dw_search.object.contact_id[1] )
//END IF
//
RETURN SUCcess
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
**  Created By	: Michael B. Skinner  24 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/





long ll_row

for ll_row = 1 to rowcount()
   //note	contact_num_id is auto increment
	if not f_validstr(string(this.object.contact_id[ll_row])) then
	      this.object.contact_id[ll_row] =  parent.il_contact_id
   end if
next


return success

end event

event constructor;call super::constructor;
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
**  Created By	: Michael B. Skinner  24 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
//
//powerobject lpo[]
//
//lpo[1] = dw_detail
//lpo[2] = dw_phone
//lpo[3] = dw_notes
//
//
//of_setupdateobjects( lpo)


this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )


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


f_open_lookup_maint(GetColumnName(),this)

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-15 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_RetParm
if of_check_read_only( ) then return success //Added by Ken.Guo on 2009-01-05
This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
			Of_Enable_Save()
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event updateend;call super::updateend;

if rowsinserted > 0 then 

if dw_search.rowcount( ) < 1 then return success
  this.retrieve(dw_search.object.contact_id[dw_search.getrow()]   )
end if 
end event

event retrieveend;call super::retrieveend;
if rowcount > 0 then 
	
	setcolumn('contact_email')
	setfocus()
	
end if
end event

event pfc_addrow;

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return failure
// mskinner 05 april 2006 -- END


if dw_search.RowCount( ) < 1 then return success

super :: event pfc_addrow( )

RETURN SUCCESS
// mskinner 05 april 2006 -- end 
end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-12-06 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_RetParm
if of_check_read_only( ) then return success //Added by Ken.Guo on 2009-01-05
This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
			Of_Enable_Save()
		end if
		This.SetColumn('phone')
	end if
end if
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
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow
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

// Determine if RMB popup menu should occur
If Not ib_RMBmenu Or IsNull (dwo) Then	Return 1

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

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-05-09 By: Wu ZhiJun
//$<reason> Fix a bug
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//--------------------------- APPEON END -----------------------------

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

type st_4 from u_st_splitbar within u_tabpg_contract_contact
integer x = 1221
integer y = 884
integer width = 2638
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 128
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;this.of_Register(dw_detail , ABOVE)
this.of_Register(dw_phone , BELOW)

this.backcolor = parent.backcolor

end event

event lbuttonup;call super::lbuttonup;this.backcolor = parent.backcolor

This.BringToTop = false		//Added by Scofield on 2009-01-05

end event

