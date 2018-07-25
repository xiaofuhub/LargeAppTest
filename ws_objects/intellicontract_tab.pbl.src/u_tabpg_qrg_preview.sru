$PBExportHeader$u_tabpg_qrg_preview.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_qrg_preview from u_tabpg_contract_master
end type
type dw_rpt from u_dw_contract within u_tabpg_qrg_preview
end type
type cbx_1 from u_cbx within u_tabpg_qrg_preview
end type
end forward

global type u_tabpg_qrg_preview from u_tabpg_contract_master
integer width = 3995
integer height = 2152
dw_rpt dw_rpt
cbx_1 cbx_1
end type
global u_tabpg_qrg_preview u_tabpg_qrg_preview

type variables


n_cst_cxt_reports inv_ctx_reports

end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_set_details (n_cst_cxt_reports anv_userobject)
end prototypes

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
**  Created By	: Michael B. Skinner  23 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//if not ib_retrieved then
	
	

   dw_rpt.event pfc_retrieve( )
//end if

//ib_retrieved = true
 
 
 
 return success




end function

public function integer of_set_details (n_cst_cxt_reports anv_userobject);


anv_userobject = inv_ctx_reports


return success
end function

on u_tabpg_qrg_preview.create
int iCurrent
call super::create
this.dw_rpt=create dw_rpt
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rpt
this.Control[iCurrent+2]=this.cbx_1
end on

on u_tabpg_qrg_preview.destroy
call super::destroy
destroy(this.dw_rpt)
destroy(this.cbx_1)
end on

event resize;call super::resize;//dw_rpt.Object.DataWindow.Zoom = '100'
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 04.23.2007 By: Jack
////$<reason> 
//dw_rpt.width = this.width - 800
////dw_rpt.height = this.height - cbx_1.y - 20
////---------------------------- APPEON END ----------------------------
//
end event

event ue_selectionchanged;call super::ue_selectionchanged;
dw_rpt.setfocus()


THIS. OF_RETRIEVE( )


end event

event constructor;call super::constructor;inv_ctx_reports = create n_cst_cxt_reports 

if IsValid(inv_resize) then this.inv_resize.of_setdwzoom( false)	//11-21-2008 By Jervis

end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(inv_ctx_reports) then Destroy inv_ctx_reports
//---------------------------- APPEON END ----------------------------
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_qrg_preview
integer x = 50
integer y = 2028
integer width = 3890
integer height = 80
end type

type dw_rpt from u_dw_contract within u_tabpg_qrg_preview
string tag = "Preview"
integer x = 46
integer y = 40
integer width = 3904
integer height = 1836
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Preview"
string dataobject = "d_ctx_cmpst_rpt_1"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event pfc_retrieve;call super::pfc_retrieve;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.22.2006 By: Rodger Wu
//$<reason> Assign Contract ID to the instance variable of inv_ctx_reports userobject.

/* this.retrieve(inv_contract_details.of_get_ctx_id( )  ) */

Long ll_ctx_id

ll_ctx_id = inv_contract_details.of_get_ctx_id( )
inv_ctx_reports.of_set_ctx_id( ll_ctx_id )
this.retrieve( ll_ctx_id )

//---------------------------- APPEON END ----------------------------

return success

end event

event resize;//  OVERRIDE


dw_rpt.Object.DataWindow.Zoom = '100'
end event

event retrieveend;call super::retrieveend;
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
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if rowcount < 1 then return success 
SetPointer(HourGlass!)
this.setredraw( false)
inv_ctx_reports.of_start(this)
this.setredraw(true)  

RETURN SUCcess
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
boolean		lb_frame
boolean		lb_desired
boolean		lb_readonly
boolean		lb_editstyleattrib
integer		li_tabsequence
long			ll_getrow
string		ls_editstyle
string		ls_val
string		ls_protect
string		ls_colname
string		ls_currcolname
string		ls_type
string		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

// Determine if RMB popup menu should occur
if not ib_RMBmenu or IsNull (dwo) then	return 1

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
if ls_type = "ole" or ls_type = "tableblob" or ls_type = "graph" then return 1

// No RMB support for print preview mode
///if this.Object.DataWindow.Print.Preview = "yes" then return 1

// Determine parent window for PointerX, PointerY offset
this.of_GetParentWindow (lw_parent)
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		if lw_frame.windowtype = MDI! or lw_frame.windowtype = MDIHelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = Child! then
			lw_parent = lw_frame
		else
			lw_sheet = lw_frame.GetFirstSheet()
			if IsValid (lw_sheet) then
				do
					// Use frame reference for popup menu if the parentwindow is a sheet
					if lw_sheet = lw_parent then
						lw_parent = lw_frame
						exit
					end if
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
			end if
		end if
	else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		if lw_parent.windowtype = Child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		end if
	end if
else
	return 1
end if

// Create popup menu
lm_dw = create m_dw
lm_dw.of_SetParent (this)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = this.GetRow()

ls_val = this.Object.DataWindow.ReadOnly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

choose case ls_type
	case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"

		// Row operations based on readonly status
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', not lb_readonly)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', not lb_readonly)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', not lb_readonly)

		// Menu item enablement for current row
		if not lb_readonly then
			lb_desired = False
			if ll_getrow > 0 then lb_desired = true
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', false)
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', false)			
		end if
		
	case else
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', false)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', false)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', false)
end choose

// Get column properties
ls_currcolname = this.GetColumnName()
if ls_type = "column" then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	if not IsNumber(ls_protect) then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = this.Describe(ls_expression)
	end if
	ls_val = dwo.TabSequence
	if IsNumber (ls_val) then
		li_tabsequence = Integer (ls_val)
	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
lm_dw.m_table.m_copy.Visible = false
lm_dw.m_table.m_cut.Visible = false
lm_dw.m_table.m_paste.Visible = false
lm_dw.m_table.m_selectall.Visible = false
lm_dw.m_table.m_insert.Visible = false
lm_dw.m_table.m_delete.Visible = false
lm_dw.m_table.m_addrow.Visible = false
lm_dw.m_table.m_restorerow.Visible = false
lm_dw.m_table.m_dash11.Visible = false
// Get the column/editystyle specific editable flag.
if ls_type = "column" and not lb_readonly then
	choose case ls_editstyle
		case "edit"
			ls_val = dwo.Edit.DisplayOnly
		case "editmask"
			ls_val = dwo.EditMask.Readonly
		case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		case else
			ls_val = ""
	end choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	if IsNull(lb_editstyleattrib) then lb_editstyleattrib = false
end if

if ls_type = "column" and not lb_readonly then
	if dwo.BitmapName = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
		
		if Len (this.SelectedText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
			// Copy
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', true)

			// Cut
			if li_tabsequence > 0 and ls_protect = "0" then
				lb_desired = false
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', lb_desired)
			end if
		end if
			
		if li_tabsequence > 0 and ls_protect = "0" then
			// Paste
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.14.2006 By: LiuHongXin
			//$<reason> The ClipBoard function of DataWindow is currently unsupported.
			/*
			if Len (ClipBoard()) > 0 then
			*/
			if Len (gf_ClipBoard("", 0)) > 0 then
			//---------------------------- APPEON END ----------------------------
				lb_desired = false
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', lb_desired)
			end if

			// Select All
			if Len (this.GetText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
				choose case ls_editstyle
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib						
					case else
						lb_desired = true
				end choose
				gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', lb_desired)				
			end if
		end if

	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
//// Row Manager
//if IsValid (inv_RowManager) then
//	// Undelete capability
//	if inv_RowManager.of_IsRestoreRow() then
//		//lm_dw.m_table.m_restorerow.Visible = true
//		if this.DeletedCount() > 0 and not lb_readonly then
//			//lm_dw.m_table.m_restorerow.Enabled = true
//		else
//			//lm_dw.m_table.m_restorerow.Enabled = false
//		end if
//	end if
//else
//	lm_dw.m_table.m_restorerow.Visible = false
//	lm_dw.m_table.m_restorerow.Enabled = false
//end if

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = false
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', false)
lm_dw.m_table.m_values.Visible = false
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', false)
lm_dw.m_table.m_dash12.Visible = false

if IsValid (inv_QueryMode) then
	if inv_QueryMode.of_GetEnabled() then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = false
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', false)		

		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = true
		lm_dw.m_table.m_operators.Visible = true
		lm_dw.m_table.m_dash12.Visible = true

		if ls_type = "column" and not lb_readonly then
			if dwo.bitmapname = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
				if li_tabsequence > 0 and ls_protect = "0" then				
					lb_desired = false
					choose case ls_editstyle
						case "edit", "editmask"
							lb_desired = not lb_editstyleattrib
						case "ddlb", "dddw"
							lb_desired = lb_editstyleattrib
					end choose
					// Enablement based on column				
					gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', lb_desired)
					gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', lb_desired)
				end if
			end if
		end if
	end if
end if

// DataWindow property entries. (isolate calls to shared variable)
this.event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
this.event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
if IsValid (inv_RowSelect) then inv_RowSelect.event pfc_rbuttonup (xpos, ypos, row, dwo)

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

destroy lm_dw

return 1
end event

event constructor;call super::constructor;this.of_SetReport(TRUE)

end event

type cbx_1 from u_cbx within u_tabpg_qrg_preview
integer x = 46
integer y = 1892
integer width = 727
integer height = 68
boolean bringtotop = true
long backcolor = 33551856
string text = "Use Cover Page"
end type

event clicked;call super::clicked;


dw_rpt.setredraw(false)
     inv_ctx_reports.of_show_cover_sheet(this.checked)
dw_rpt.setredraw(true)
end event

