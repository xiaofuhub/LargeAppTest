$PBExportHeader$u_tabpg_contract_detail_audit_bak.sru
$PBExportComments$[intellicontract_tab] The contract detail notes page
forward
global type u_tabpg_contract_detail_audit_bak from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_contract_detail_audit_bak
end type
type rb_1 from radiobutton within u_tabpg_contract_detail_audit_bak
end type
type rb_2 from radiobutton within u_tabpg_contract_detail_audit_bak
end type
type rb_3 from radiobutton within u_tabpg_contract_detail_audit_bak
end type
type rb_4 from radiobutton within u_tabpg_contract_detail_audit_bak
end type
type cb_refresh from commandbutton within u_tabpg_contract_detail_audit_bak
end type
end forward

global type u_tabpg_contract_detail_audit_bak from u_tabpg_contract_master
integer width = 2757
integer height = 564
string text = "Audit Trail"
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
cb_refresh cb_refresh
end type
global u_tabpg_contract_detail_audit_bak u_tabpg_contract_detail_audit_bak

type variables
string ls_original_sql
long il_ctx_id
end variables

on u_tabpg_contract_detail_audit_bak.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.cb_refresh=create cb_refresh
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.cb_refresh
end on

on u_tabpg_contract_detail_audit_bak.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.cb_refresh)
end on

event resize;call super::resize;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.26.2007 By: Jack
//$<reason> Fix a defect.

rb_1.width = 343
rb_2.width = 343
rb_3.width = 343
rb_4.width = 343

rb_1.height = 64
rb_2.height = 64
rb_3.height = 64
rb_4.height = 64

cb_refresh.width = 256
cb_refresh.height = 72

//---------------------------- APPEON END ----------------------------

end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_detail_audit_bak
end type

type dw_1 from u_dw_contract within u_tabpg_contract_detail_audit_bak
string tag = "Audit Trail"
integer y = 96
integer width = 2747
integer height = 432
integer taborder = 10
boolean bringtotop = true
string title = "Audit Trail"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
string dataobject_original = "d_view_audit2_ctx"
boolean ib_use_row_selection = true
boolean ib_allow_filter = true
boolean ib_allow_sort = true
end type

event constructor;call super::constructor;

ls_original_sql = this.Object.DataWindow.Table.Select


end event

event pfc_retrieve;call super::pfc_retrieve;
string  ls_sql

ls_sql = ls_original_sql


ls_sql = ls_sql + " AND  sys_audit.prac_id = '" + string(il_ctx_id) + "'"

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.28.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason>Fix a defect.
/*
SetSQLSelect ( ls_sql )
*/
dw_1.Modify('DataWindow.Table.Select ="' + ls_sql + '"')
//---------------------------- APPEON END ----------------------------
SetTransObject( SQLCA )
Retrieve()


return success
end event

event pfc_prermbmenuproperty;call super::pfc_prermbmenuproperty;

am_dw.m_table.m_cut.Visible = false
am_dw.m_table.m_copy.Visible = false
am_dw.m_table.m_paste.Visible = false
am_dw.m_table.m_dash11.Visible = false
am_dw.m_table.m_insert.Visible = false
am_dw.m_table.m_addrow.Visible = false

am_dw.m_table.m_delete.Visible = false
am_dw.m_table.m_selectall.Visible = false
am_dw.m_table.m_restorerow.Visible = false


end event

event pfc_addrow;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.23.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason>Fix a defect.
//
return success
//---------------------------- APPEON END ----------------------------

end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.23.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason>Fix a defect.
//
return success
//---------------------------- APPEON END ----------------------------

end event

event rbuttonup;//
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
	m_pfe_cst_mdi_menu_contract.m_edit.m_insert.enabled = false
end if

end event

type rb_1 from radiobutton within u_tabpg_contract_detail_audit_bak
integer x = 576
integer y = 12
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Deleted"
end type

event clicked;

dw_1.setfilter("audit_type = 'D'")
dw_1.filter()
 
end event

type rb_2 from radiobutton within u_tabpg_contract_detail_audit_bak
integer x = 955
integer y = 12
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Edit"
end type

event clicked;dw_1.setfilter("audit_type = 'E'")
dw_1.filter()
 
end event

type rb_3 from radiobutton within u_tabpg_contract_detail_audit_bak
integer x = 1335
integer y = 12
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Insert"
end type

event clicked;dw_1.setfilter("audit_type = 'I'")
dw_1.filter()
 
end event

type rb_4 from radiobutton within u_tabpg_contract_detail_audit_bak
integer x = 197
integer y = 12
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "All"
boolean checked = true
end type

event clicked;dw_1.setfilter("")
dw_1.filter()
 
end event

type cb_refresh from commandbutton within u_tabpg_contract_detail_audit_bak
integer x = 2469
integer y = 8
integer width = 256
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.12.2007 By: Jack
//$<reason> Fix a defect.
/*
dw_1.retrieve()
*/
dw_1.event pfc_retrieve()
//---------------------------- APPEON END ----------------------------

end event

