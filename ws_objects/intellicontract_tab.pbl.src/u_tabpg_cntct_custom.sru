$PBExportHeader$u_tabpg_cntct_custom.sru
forward
global type u_tabpg_cntct_custom from u_tabpg
end type
type dw_2 from u_dw_contract within u_tabpg_cntct_custom
end type
end forward

global type u_tabpg_cntct_custom from u_tabpg
integer width = 3899
integer height = 1936
long backcolor = 33551856
dw_2 dw_2
end type
global u_tabpg_cntct_custom u_tabpg_cntct_custom

type variables

end variables

on u_tabpg_cntct_custom.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on u_tabpg_cntct_custom.destroy
call super::destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw_contract within u_tabpg_cntct_custom
string tag = "User Defined Data"
integer x = 9
integer y = 16
integer width = 3867
integer height = 1900
integer taborder = 10
boolean titlebar = true
string title = "User Defined Data"
string dataobject = "d_cntx_custom"
boolean border = false
end type

event clicked;call super::clicked;
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.08.2007 By: Jack 
//$<reason> Fix a defect.
/*
This.SelectRow(0, FALSE)
This.SelectRow(row, TRUE)
*/
//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;gnv_win_backcolor.of_SetObjectBackColor(this) //Add by Evan 11/24/2008

ib_rmbmenu = false

if w_contract_contact.tab_1.Tabpage_details.ib_IsValid then
	w_contract_contact.tab_1.Tabpage_details.dw_2 = w_contract_contact.tab_1.Tabpage_details.dw_2
	w_contract_contact.tab_1.Tabpage_details.dw_master.ShareData(w_contract_contact.tab_1.Tabpage_details.dw_2)
end if

This.of_setupdateable(false)

end event

event getfocus;call super::getfocus;this.border = true

end event

event pfc_preupdate;call super::pfc_preupdate;///******************************************************************************************************************
//**  [PUBLIC]   : 
//**==================================================================================================================
//**  Purpose   	: 
//**==================================================================================================================
//**  Arguments 	: [none] 
//**==================================================================================================================
//**  Returns   	: [none]   
//**==================================================================================================================
//**  Notes     	: 	   
//**==================================================================================================================
//**  Created By	: Michael B. Skinner  
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//********************************************************************************************************************/
//
//
//LONG LL_I
//
//if dw_MASTER.ROWCOUNT() < 1 THEN RETURN SUCcess
//
//
//FOR LL_I = 1 TO ROWCOUNT( )
//   THIS.OBJECT.contact_id[LL_I] = dw_MASTER.OBJECT.contact_id[1] 
//NEXT

//

RETURN SUCcess
end event

event pfc_predeleterow;call super::pfc_predeleterow;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if GetSelectedRow(0) < 1 then 
	Messagebox('Select Row', 'Please select a row.')
	return 0
end if

if Messagebox('Confirm Delete','Are you sure you want to delete this row ?',question!,YesNo!,2) = 1 then 
	return continue_action
else
   return 0	
	
end if

end event

event pfc_addrow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_add.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event pfc_deleterow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_delete.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

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

ll_Right = w_mdi.of_security_access(6930)				//Access Rights
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
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

