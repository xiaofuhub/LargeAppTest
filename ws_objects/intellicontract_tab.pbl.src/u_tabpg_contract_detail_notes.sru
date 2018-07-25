$PBExportHeader$u_tabpg_contract_detail_notes.sru
$PBExportComments$[intellicontract_tab] The contract detail notes page
forward
global type u_tabpg_contract_detail_notes from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_contract_detail_notes
end type
end forward

global type u_tabpg_contract_detail_notes from u_tabpg_contract_master
integer width = 2825
integer height = 556
long backcolor = 33551856
dw_1 dw_1
end type
global u_tabpg_contract_detail_notes u_tabpg_contract_detail_notes

forward prototypes
public subroutine of_resizedwobject ()
end prototypes

public subroutine of_resizedwobject ();//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-06-13 By: Scofield
//$<Reason> Adjust the b_insert button position.

long		ll_NoteX,ll_NoteY,ll_NoteWidth,ll_NoteHeight,ll_BWidth,ll_BHeight,ll_Zoom

CONSTANT LONG DWTITLEBARHEIGHT = 104

dw_1.SetRedraw(false)

ll_Zoom = long(dw_1.Describe("DataWindow.Zoom"))

ll_NoteX = long(dw_1.Describe("notes.x"))
ll_NoteY = long(dw_1.Describe("notes.y"))

ll_BWidth = long(dw_1.Describe("b_insert.Width"))
ll_BHeight = long(dw_1.Describe("b_insert.Height"))

ll_NoteWidth = (dw_1.Width - ll_NoteX - ll_BWidth - 150) * 100 / ll_Zoom

if dw_1.TitleBar then
	ll_NoteHeight = (dw_1.Height - ll_NoteY - 2 * ll_NoteY -20 - DWTITLEBARHEIGHT) * 100 / ll_Zoom
else
	ll_NoteHeight = (dw_1.Height - ll_NoteY - 2 * ll_NoteY - 20) * 100 / ll_Zoom
end if

dw_1.Modify("DataWindow.Detail.Height = " + String(dw_1.Height + 30))
dw_1.Modify("notes.Width = " + String(ll_NoteWidth))
dw_1.Modify("notes.Height = " + String(ll_NoteHeight))

dw_1.Modify("b_insert.X = " + String(ll_NoteX + ll_NoteWidth + 25))
dw_1.Modify("b_insert.Y = " + String(ll_NoteY + ll_NoteHeight - ll_BHeight))

dw_1.SetRedraw(true)
//---------------------------- APPEON END ----------------------------

end subroutine

on u_tabpg_contract_detail_notes.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_contract_detail_notes.destroy
call super::destroy
destroy(this.dw_1)
end on

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_detail_notes
end type

type dw_1 from u_dw_contract within u_tabpg_contract_detail_notes
string tag = "Notes"
integer y = 8
integer width = 2747
integer height = 520
integer taborder = 10
boolean bringtotop = true
string title = "Notes"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
string dataobject_original = "d_contract_det_notes"
end type

event constructor;//
end event

event pfc_deleterow;//Override

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.14.2006 By: LeiWei
//$<reason> Fix a defect.

return success

//---------------------------- APPEON END ----------------------------

end event

event pfc_postupdate;call super::pfc_postupdate;////Added for Work Flow trigger. 11.21.2006 Henry
//long	 ll_screen_id
//long	 ll_ctx_id
//
//ll_ctx_id = this.getitemnumber( this.GetRow(), "ctx_id")
//if not ll_ctx_id > 0 Then RETURN success
//
//ll_screen_id = long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_notes'"))
//If gb_workflow Then
//	n_cst_workflow_triggers lnv_workflow
//	lnv_workflow = create n_cst_workflow_triggers
//	lnv_workflow.of_data_value_comparision( ll_screen_id, ll_ctx_id, 0, '03', 'I')
//	Destroy lnv_workflow
//End If
////End added 11.21.2006
RETURN success
end event

event pfc_addrow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.23.2007 By: Jack
//$<reason> Fix a defect.
Return 1
//---------------------------- APPEON END ----------------------------

end event

event resize;call super::resize;//Post of_ResizeDWObject()		//Added by Scofield on 2008-06-13

end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-06-13 By: Scofield
//$<Reason> Insert user and date information in the notes area.

long		ll_Row
String	ls_Notes,ls_Append

if This.AcceptText() <> 1 then Return

if dwo.name = 'b_insert' then
	ll_Row = This.GetRow()
	
	if ll_Row > 0 and ll_Row <= This.RowCount() then
		ls_Append = String(Today(),"MM/DD/YYYY") + " - " + gs_User_id + '~r~n~r~n'
		
		/*
		ls_Notes = This.GetItemString(ll_Row,'notes')
		if IsNull(ls_Notes) then ls_Notes = ""
		if ls_Notes <> "" then ls_Notes += "~r~n"
		ls_Notes += ls_Append
		
		This.SetItem(ll_Row,'notes',ls_Notes)
		*/
		
		This.SelectText(1,0)
		This.ReplaceText(ls_Append)
		This.SelectText(Len(ls_Append) - 1,0)
		This.of_Enable_Save()
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event getfocus;call super::getfocus;//====================================================================
// Event: getfocus()
//--------------------------------------------------------------------
// Description: Set the add menu item disabled
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2008-11-14
//====================================================================

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)
end if

end event

