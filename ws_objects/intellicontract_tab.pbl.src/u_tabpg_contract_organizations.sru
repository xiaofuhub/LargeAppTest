$PBExportHeader$u_tabpg_contract_organizations.sru
$PBExportComments$[intellicontract_tab] The contract locations Tab Page
forward
global type u_tabpg_contract_organizations from u_tabpg_contract_master
end type
type dw_search from u_dw_contract within u_tabpg_contract_organizations
end type
type dw_main from u_dw_contract within u_tabpg_contract_organizations
end type
type dw_notes from u_dw_contract within u_tabpg_contract_organizations
end type
type dw_contacts from u_dw_contract within u_tabpg_contract_organizations
end type
type st_5 from u_st_splitbar within u_tabpg_contract_organizations
end type
type st_4 from u_st_splitbar within u_tabpg_contract_organizations
end type
type st_2 from u_st_splitbar within u_tabpg_contract_organizations
end type
end forward

global type u_tabpg_contract_organizations from u_tabpg_contract_master
integer width = 4046
integer height = 2036
string text = "Organizations"
string powertiptext = "Participating Organizations"
event ue_add_existing ( )
event ue_set_screen_properties ( )
dw_search dw_search
dw_main dw_main
dw_notes dw_notes
dw_contacts dw_contacts
st_5 st_5
st_4 st_4
st_2 st_2
end type
global u_tabpg_contract_organizations u_tabpg_contract_organizations

type variables

end variables

forward prototypes
public function integer of_retrieve ()
public subroutine of_create_dw ()
end prototypes

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
str_pass 		lstr_pass
Long			ll_ctx_id	= 0				//Added By Mark Lee 04/26/12
string 		ls_err, ls_choose
Integer		li_return = 0 

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 

//Added By Mark Lee 04/26/12
ll_ctx_id = INV_contract_details.of_get_ctx_id( )
//if isnull(INV_contract_details.of_get_ctx_id( )) or INV_contract_details.of_get_ctx_id( ) = 0 then 
if isnull(ll_ctx_id) or ll_ctx_id = 0 then 
	//Added By Mark Lee 04/26/12
	ls_choose = "ll_ctx_id is null "
	iw_parent.setredraw( false)
	iw_parent.event dynamic ue_save()
	iw_parent.post function dynamic of_select_contact_tab()
	iw_parent.setredraw(true)
	lstr_pass.s_string = 'ORG'
	lstr_pass.s_long[1] =  INV_contract_details.of_get_ctx_id( )
	lstr_pass.s_u_dw   = dw_main
	OpenWithParm ( w_ctx_org_painter, lstr_pass)
	iw_parent.setredraw( false)
	dw_search.event pfc_retrieve( )
	iw_parent.setredraw(true)
	//Added By Mark Lee 04/26/12
	ll_ctx_id = INV_contract_details.of_get_ctx_id( )
//	if isnull(INV_contract_details.of_get_ctx_id( )) then
	if isnull(ll_ctx_id) then
		messagebox(iw_parent.title ,'The contract must be saved prior to adding existing contacts.')
		Return
	end if
else
	//Added By Mark Lee 04/26/12
	ls_choose = " ll_ctx_id is not null "
	lstr_pass.s_string = 'ORG'
	//Added By Mark Lee 04/26/12
//	lstr_pass.s_long[1] =  INV_contract_details.of_get_ctx_id( )
	lstr_pass.s_long[1] =  ll_ctx_id
	lstr_pass.s_u_dw   = dw_search
	lstr_pass.w_parent_window = iw_parent
	//event ue_new( )
	//DW_Search.reset( )
	OpenWithParm (w_ctx_org_painter, lstr_pass)
	//ib_retrieved = false
	SetRedraw(FALSE)
	//iw_parent.event dynamic ue_save()
	//Added By Mark Lee 04/26/12
//	This.of_update( true, true)
	li_return = 	This.of_update( true, true)
	dw_Search.RESET( )
	dw_Search.Event pfc_retrieve( )
	SetRedraw(TRUE)
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.22.2007 By: Jack
//$<reason> Fix a defect.
long ll_org_id,ll_find
ll_org_id = message.doubleparm

//Added By Mark Lee 04/26/12 add this log for reproduce bug 
If dw_Search.rowcount() <= 0 Or isnull(dw_Search.rowcount()) Then
	gnv_debug.of_output( True, 'ue_add_existing() event')
	gnv_debug.of_output( True, 'choose way = '+ls_choose)
	gnv_debug.of_output( True, 'of_update event return value = '+string(li_return))
	gnv_debug.of_output( True, 'OpenWithParm return value = '+string(ll_org_id))
End If

ll_find = DW_Search.find('org_id = ' + string(ll_org_id),1,DW_Search.rowcount())
If ll_find > 0 Then
	dw_Search.SelectRow(0, False)
	dw_Search.scrolltorow(ll_find)
	dw_Search.SelectRow(ll_find, True)
End If
//---------------------------- APPEON END ----------------------------

end event

event ue_set_screen_properties();// Set screen properties
dw_search.of_set_properties(dw_search.il_ViewID, dw_search.il_ScreenID, "Y")
dw_main.of_set_properties(dw_main.il_ViewID, dw_main.il_ScreenID, "Y")
dw_notes.of_set_properties(dw_notes.il_ViewID, dw_notes.il_ScreenID, "Y")
dw_contacts.of_set_properties(dw_contacts.il_ViewID, dw_contacts.il_ScreenID, "Y")

// Set splitbar back color
st_1.backcolor = this.backcolor
st_2.backcolor = this.backcolor
st_4.backcolor = this.backcolor
st_5.backcolor = this.backcolor
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
	dw_search.event pfc_retrieve( )
	 
end if

ib_retrieved = true

RETURN SUCcess
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_organizationsof_create_dw()
// $<arguments>
//		value	integer		
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

ls_tab_name = 'tabpage_orgabizations'
ld_dw[1] = dw_search
ld_dw[2] = dw_main
ld_dw[3] = dw_notes
ld_dw[4] = dw_contacts
ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_main'
ls_dw_name[3] = 'dw_notes'
ls_dw_name[4] = 'dw_contacts'
ls_dataobject[1] = 'd_org_search2'
ls_dataobject[2] = 'd_org_tabpg'
ls_dataobject[3] = 'd_org_notes'
ls_dataobject[4] = 'd_org_contacts'
f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_orgabizations',true) 

this.event ue_set_screen_properties( )  //Jervis 08.17.2010
end subroutine

on u_tabpg_contract_organizations.create
int iCurrent
call super::create
this.dw_search=create dw_search
this.dw_main=create dw_main
this.dw_notes=create dw_notes
this.dw_contacts=create dw_contacts
this.st_5=create st_5
this.st_4=create st_4
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_search
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.dw_notes
this.Control[iCurrent+4]=this.dw_contacts
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_2
end on

on u_tabpg_contract_organizations.destroy
call super::destroy
destroy(this.dw_search)
destroy(this.dw_main)
destroy(this.dw_notes)
destroy(this.dw_contacts)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_2)
end on

event dragdrop;call super::dragdrop;//
end event

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
//  Created By	: Michael Skinner  Thursday  
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
dw_main.of_SetLinkage(true)
dw_notes.of_SetLinkage(true)
dw_contacts.of_SetLinkage(true)


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the linkage stuff
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_main.inv_linkage.of_SetMaster(dw_search)
dw_main.inv_linkage.of_Register("org_id", "org_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01 
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//dw_main.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
n_cst_dwsrv_linkage lnv_cst_dwsrv_linkage
lnv_cst_dwsrv_linkage = Create n_cst_dwsrv_linkage
dw_main.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
//---------------------------- APPEON END ----------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_notes.inv_linkage.of_SetMaster(dw_search )
dw_notes.inv_linkage.of_Register("ctx_id", "ctx_id")
dw_notes.inv_linkage.of_Register("org_id", "org_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01 
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//dw_notes.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
dw_notes.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
//---------------------------- APPEON END ----------------------------

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_contacts.inv_linkage.of_SetMaster(dw_search)
dw_contacts.inv_linkage.of_Register("org_id", "org_id") 
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01 
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//dw_contacts.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
dw_contacts.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
Destroy lnv_cst_dwsrv_linkage
//---------------------------- APPEON END ----------------------------
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// set the update properties for the datawindows
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_notes.inv_linkage.of_SetUpdateOnRowChange(TRUE)
dw_notes.inv_linkage.of_SetConfirmOnRowChange(TRUE)

dw_contacts.inv_linkage.of_SetUpdateOnRowChange(TRUE)
dw_contacts.inv_linkage.of_SetConfirmOnRowChange(TRUE)

dw_main.inv_linkage.of_SetUpdateOnRowChange(TRUE)
dw_main.inv_linkage.of_SetConfirmOnRowChange(TRUE)


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete delete style
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//dw_profile.inv_linkage.of_SetDeleteStyle(dw_profile.inv_linkage.DELETE_ROWS)
//dw_measurement_group.inv_linkage.of_SetDeleteStyle(dw_measurement_group.inv_linkage.bottomup  )
//dw_measurements.inv_linkage.of_SetDeleteStyle(dw_measurements.inv_linkage.bottomup  )
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete properties for the datawindows
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_main.inv_linkage.of_SetConfirmOnDelete ( true )
dw_contacts.inv_linkage.of_SetConfirmOnDelete ( true )
dw_notes.inv_linkage.of_SetConfirmOnDelete ( true )


dw_main.inv_linkage.of_SetDeleteStyle ( 1 )
dw_contacts.inv_linkage.of_SetDeleteStyle ( 1 )
dw_notes.inv_linkage.of_SetDeleteStyle ( 1 )



dw_search.inv_linkage.of_SetTransObject(SQLCA)

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
	//Added By Mark Lee 05/07/12
	this.of_setresize( true)
	this.inv_resize.of_register( dw_search,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_main,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_notes,inv_resize.scalerightbottom)
	this.inv_resize.of_register( dw_contacts,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_1,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_2,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_4,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_5,inv_resize.scalerightbottom)
	this.inv_resize.of_setminsize( 800, 600 )
end if
end event

event ue_new;
//iw_parent.event dynamic ue_save()
//
//DW_contacts.RESET()
//DW_contacts.INSERTROW(0)
//DW_main.reset()
//dw_main.insertrow(0)
//dw_notes.reset()
//dw_notes.insertrow( 0)
//




end event

event ue_selectionchanged;call super::ue_selectionchanged;

dw_search.setfocus( )
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_organizations
integer x = 14
integer y = 2104
integer width = 3840
integer height = 176
long textcolor = 0
long backcolor = 67108864
end type

type dw_search from u_dw_contract within u_tabpg_contract_organizations
string tag = "Organization List"
integer x = 9
integer y = 16
integer width = 795
integer height = 1992
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Organization List"
boolean hscrollbar = true
string dataobject_original = "d_org_search2"
end type

event constructor;call super::constructor;this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )





end event

event pfc_addrow;


parent.event ue_add_existing()

return success
end event

event pfc_retrieve;call super::pfc_retrieve;
long ll_i
retrieve( inv_contract_details.of_get_ctx_id( ) )

//for ll_i =1 to dw_main.rowcount()
//	  dw_main.object.ctx_id[ll_i] = inv_contract_details.Of_get_ctx_id( )
// 
//next 
//
//for ll_i =1 to dw_contacts.rowcount()
//	
//   dw_contacts.object.ctx_id[ll_i] = inv_contract_details.Of_get_ctx_id( )
//
//next 


RETURN SUCcess
end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.05.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
integer li_selected

if dw_search.rowcount() <= 0 then return success
if of_check_read_only( ) then return success
if MessageBox('Confirm Delete', 'Are you sure you want to delete this row?',Question!,Yesno!,2) = 1 then				//Modified by Scofield on 2008-03-11
	if dw_search.rowcount() > 0 then
		li_selected = dw_search.getrow() //Rodger Wu added.
		dw_search.deleterow( li_selected )
		//OF_ENABLE_SAVE( )//Rodger Wu added.
		dw_search.trigger event pfc_update( true, true )//Rodger Wu added.
		This.SelectRow(0, False)  //Add by Jack 22.08.2007
		IF dw_search.ROWcount( ) > 0 then 
			if li_selected <> 1 then
				dw_search.setrow( 1 )//Rodger Wu added.
				dw_search.SelectRow(1, true)
			else//Rodger Wu added.
				dw_search.trigger event rowfocuschanged( 1 )
			end if
		else//Rodger Wu added.
			dw_main.reset()
			dw_notes.reset()
			dw_contacts.reset()
		end if 
	end if
//	OF_ENABLE_SAVE( )//Rodger Wu commented.
end if

Return Success
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

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-03-11 By: Scofield
//$<Reason> Don't display the insert menu item
lm_dw.m_table.m_insert.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1


end event

event getfocus;call super::getfocus;//BEGIN---Modify by Scofield on 2010-02-24
if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
end if
//END---Modify by Scofield on 2010-02-24

end event

event retrieveend;call super::retrieveend;// (Appeon)Harry 06.07.2013 - V141 ISG-CLX
if getrow() > 0 then post event rowfocuschanged(getrow()) //alfee 03.19.2010
end event

type dw_main from u_dw_contract within u_tabpg_contract_organizations
string tag = "Address"
integer x = 827
integer y = 16
integer width = 3031
integer height = 1048
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Address"
boolean vscrollbar = false
boolean livescroll = false
string dataobject_original = "d_org_tabpg"
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
**  Created By	: Michael B. Skinner  11 July 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_max
long il_org_id

if this.rowcount( ) < 1 then return success

if isnull(this.object.org_id[1]) then
	select max(org_id) 
	into :il_org_id
	from ctx_orgs;
	
	if isnull(il_org_id) then
		il_org_id = 1 
	else 
		il_org_id = 1 + il_org_id
	end if 
	
	This.object.org_id[1] = il_org_id
end if 

///////////////////////////////////////////////////////////////////////
// need to fire the pfc_preupdate
///////////////////////////////////////////////////////////////////////

dw_notes.Event pfc_preupdate( )

Return Success

end event

event pfc_validation;call super::pfc_validation;

if this.rowcount( ) < 1 then return success

if isnull(this.object.org_type[1]) then
	//messagebox(iw_parent.title,'Organization type is a requred item')
	of_set_message( 'Organization type is a required item.')
	return failure
end if 



return success
end event

event pfc_addrow;

dw_search.event pfc_addrow( )

return success
end event

event pfc_deleterow;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.05.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.

dw_search.event pfc_deleterow()
return success
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

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-03-11 By: Scofield
//$<Reason> Don't display the insert menu item
lm_dw.m_table.m_insert.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1


end event

event getfocus;call super::getfocus;//BEGIN---Modify by Scofield on 2010-02-24
if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
end if
//END---Modify by Scofield on 2010-02-24

end event

type dw_notes from u_dw_contract within u_tabpg_contract_organizations
string tag = "Notes"
integer x = 827
integer y = 1084
integer width = 3031
integer height = 396
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Notes"
boolean vscrollbar = false
boolean livescroll = false
string dataobject_original = "d_org_notes"
end type

event pfc_preupdate;call super::pfc_preupdate;


long ll_max
long il_org_id


if dw_main.rowcount( ) < 1 then return success
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.10.2006 By: Liang QingShi
//$<reason> Fix a defect.
if this.rowcount() < 1 then return success
//---------------------------- APPEON END ----------------------------

if isnull(this.object.org_id[1]) then
	this.object.org_id[1] = dw_main.object.org_id[1]
	
end if

return success
end event

event pfc_addrow;if dw_Main.RowCount( ) < 1 then 
	Return Failure
else 
	Super::Event pfc_AddRow()
end if 

Return Success

end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.05.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.

dw_search.event pfc_deleterow()
return success
//---------------------------- APPEON END ----------------------------

end event

event rbuttonup;//
end event

event getfocus;call super::getfocus;//BEGIN---Modify by Scofield on 2010-02-24
if IsValid(m_pfe_cst_mdi_menu_contract) then
//	if dw_Main.RowCount() > 0 then
//		m_pfe_cst_mdi_menu_contract.m_edit.m_insert.enabled = true
//	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)
//	end if
end if
//END---Modify by Scofield on 2010-02-24

end event

type dw_contacts from u_dw_contract within u_tabpg_contract_organizations
string tag = "Organization Contacts"
integer x = 827
integer y = 1500
integer width = 3031
integer height = 508
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Organization Contacts"
boolean hscrollbar = true
string dataobject_original = "d_org_contacts"
boolean ib_allow_sort = true
end type

event pfc_preupdate;call super::pfc_preupdate;long ll_i
for ll_i = 1 to this.rowcount()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.26.2007 By: Jack
	//$<reason> Fix a defect.
	/*
		if isnull(this.object.org_id[1]) then
			this.object.org_id[1] = dw_main.object.org_id[1]
		end if
	*/
	if isnull(this.object.org_id[ll_i]) then
		this.object.org_id[ll_i] = dw_main.getitemnumber(dw_main.getrow(),'org_id')
	end if

	//---------------------------- APPEON END ----------------------------
next
return success
end event

event constructor;call super::constructor;this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

end event

event pfc_addrow;If of_check_read_only( ) Then Return failure  //Add by Jack 07.13.2007

if dw_main.rowcount( ) < 1 then 
	return failure
else 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.26.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	Super::EVENT pfc_addrow()
	*/
	this.insertrow(0)
	
	//---------------------------- APPEON END ----------------------------
end if 


return success
end event

event updateend;call super::updateend;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.05.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
//long ll_org_id
//if dw_search.rowcount() <= 0 then return
//ll_org_id = dw_search.getitemnumber(dw_search.getrow(),'org_id')
//this.retrieve(ll_org_id)
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-11 By: Scofield
//$<Reason> Refresh this datawindow
long	ll_CurRow

ll_CurRow = dw_search.GetRow()
if ll_CurRow > 0 and ll_CurRow <= dw_search.RowCount() then
	dw_search.Trigger Event RowFocusChanged(ll_CurRow)
end if

//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanging;//
end event

event clicked;//
end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
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

event getfocus;call super::getfocus;//BEGIN---Modify by Scofield on 2010-02-24
if IsValid(m_pfe_cst_mdi_menu_contract) then
	if dw_Main.RowCount() > 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)
	end if
end if
//END---Modify by Scofield on 2010-02-24

end event

type st_5 from u_st_splitbar within u_tabpg_contract_organizations
integer x = 814
integer y = 16
integer width = 9
integer height = 1992
boolean bringtotop = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;//this.of_SetResize(TRUE)


this.of_Register(dw_search , LEFT)
this.of_Register(dw_contacts , RIGHT)
this.of_Register(dw_main,  RIGHT)
this.of_Register(dw_notes , RIGHT)



//this.of_Register(gb_1 , RIGHT)
//this.of_Register(gb_2 , RIGHT)
//this.of_Register(gb_3 , RIGHT)
this.of_Register(st_1 , RIGHT)
//this.of_Register(st_2 , RIGHT)
//this.of_SetBarColor(rgb(128,0,0))

this.backcolor = parent.backcolor //Add by Evan 10/14/2008
end event

event lbuttonup;call super::lbuttonup;this.backcolor = parent.backcolor //Add by Evan 10/14/2008

st_2.BringToTop = false		//Added by Scofield on 2009-01-05
st_4.BringToTop = false		//Added by Scofield on 2009-01-05

end event

type st_4 from u_st_splitbar within u_tabpg_contract_organizations
integer x = 827
integer y = 1068
integer width = 3031
integer height = 12
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;

this.of_Register(dw_main , ABOVE)
//this.of_Register(gb_1 , ABOVE)
this.of_Register(dw_notes,  BELOW)
//this.of_Register(gb_2 , BELOW)

this.backcolor = parent.backcolor //Add by Evan 10/14/2008
end event

event lbuttonup;call super::lbuttonup;this.backcolor = parent.backcolor //Add by Evan 10/14/2008

This.BringToTop = false		//Added by Scofield on 2009-01-05

end event

type st_2 from u_st_splitbar within u_tabpg_contract_organizations
integer x = 827
integer y = 1488
integer width = 3031
integer height = 12
boolean bringtotop = true
end type

event constructor;call super::constructor;//this.of_Register(dw_mAIN , ABOVE)
this.of_Register(dw_notes , ABOVE)
//this.of_Register(gb_1 , ABOVE)
//this.of_Register(gb_2 , ABOVE)
//this.of_Register(st_4 , ABOVE)


this.of_Register(dw_contacts , BELOW)
//this.of_Register(gb_3 , BELOW)

this.backcolor = parent.backcolor //Add by Evan 10/14/2008
end event

event lbuttonup;call super::lbuttonup;this.backcolor = parent.backcolor //Add by Evan 10/14/2008

This.BringToTop = false		//Added by Scofield on 2009-01-05

end event

