$PBExportHeader$w_conv_select_fields.srw
forward
global type w_conv_select_fields from window
end type
type dw_fields from datawindow within w_conv_select_fields
end type
type cb_1 from commandbutton within w_conv_select_fields
end type
type tv_1 from u_tvs_rpt within w_conv_select_fields
end type
type cb_cancel from commandbutton within w_conv_select_fields
end type
type cb_ok from commandbutton within w_conv_select_fields
end type
end forward

global type w_conv_select_fields from window
integer x = 901
integer y = 148
integer width = 1289
integer height = 1996
boolean titlebar = true
string title = "Select Table and Column"
windowtype windowtype = response!
long backcolor = 33551856
dw_fields dw_fields
cb_1 cb_1
tv_1 tv_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_conv_select_fields w_conv_select_fields

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-13 By: Andy
Long   il_view_id
Long   il_data_view_id
String is_table_name
//---------------------------- APPEON END ----------------------------
Long  il_data_view_id_cont
string is_for
end variables

forward prototypes
public function integer of_getargs (u_tvs_rpt atv_args, long al_parent, integer ai_level, ref any aa_arg[20])
public subroutine of_expandcollapseall (commandbutton acb_args, u_tvs_rpt atv_args)
end prototypes

public function integer of_getargs (u_tvs_rpt atv_args, long al_parent, integer ai_level, ref any aa_arg[20]);//====================================================================
// Event: w_custom_report.of_getargs()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//    value       treeview atv_args
// 	value    	long   	al_parent 	
// 	value    	integer	ai_level  	
// 	reference	any    	aa_arg[20]	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 13,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//====================================================================
Integer				li_Index
TreeViewItem		ltvi_Item

// check arguments
If (al_parent < 0) or IsNull(al_parent) Then Return -1
If (ai_level < 1) or IsNull(ai_level) Then Return -1

// Determine level 
li_Index = UpperBound(atv_args.inv_attrib)
If ai_Level > li_Index Then
	Return -1
Else
	li_Index = ai_Level
End If

if al_Parent <> 0 then
	If atv_args.GetItem(al_Parent, ltvi_Item) = -1 Then Return -1
end if	

CHOOSE CASE ai_level
	CASE 1
		aa_arg[1] = il_view_id
		//<add> 12.20.2007 by: Andy
		aa_arg[2] = is_table_name
	CASE 2
		aa_arg[1] = il_view_id
		aa_arg[2] = ltvi_Item.data
		//<add> 12.14.2007 by: Andy
		aa_arg[3] = is_table_name
		
	CASE 3
		aa_arg[1] = ltvi_Item.data
		aa_arg[2] = il_data_view_id
		//$<add> 02.21.2008 by Andy
		aa_arg[3] = il_view_id
		//$<add> 04.03.2008 by Andy
		aa_arg[4] = 0
		aa_arg[5] = il_data_view_id_cont  //(Appeon)Stephen 06.26.2014 - IntelliReport Modifications 14.2
END CHOOSE

Return 1

end function

public subroutine of_expandcollapseall (commandbutton acb_args, u_tvs_rpt atv_args);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-17 By: Andy
Long   ll_Root,ll_FirstRoot
String ls_Type

if lower(acb_args.text) = 'expand all' then
	acb_args.text = 'Collapse All'
	ls_Type = 'expandall'
else
	acb_args.text = 'Expand All'
	ls_Type = 'collapseall'
end if

ll_Root = atv_args.FindItem(RootTreeItem!, 0)
ll_FirstRoot = ll_Root

DO WHILE (1=1)
	if ll_Root < 1 then exit
	
	if lower(ls_Type) = 'expandall' then
		atv_args.ExpandAll ( ll_Root )
	else
		atv_args.collapseItem ( ll_Root )
		//delete all child
		//atv_args.of_reset( ll_Root )
	end if
	
	ll_Root = atv_args.FindItem(NextTreeItem!, ll_Root)
LOOP 

atv_args.selectItem(ll_FirstRoot)
atv_args.setfocus()
//---------------------------- APPEON END ----------------------------
end subroutine

on w_conv_select_fields.create
this.dw_fields=create dw_fields
this.cb_1=create cb_1
this.tv_1=create tv_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.dw_fields,&
this.cb_1,&
this.tv_1,&
this.cb_cancel,&
this.cb_ok}
end on

on w_conv_select_fields.destroy
destroy(this.dw_fields)
destroy(this.cb_1)
destroy(this.tv_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;//Start Code Change ----02.17.2016 #V15 maha - rewrote to get both table and field at once
String ls_Parm
Long ll_Pos,ll_Pos2, ll_pos_last
Long ll_Root,ll_FistRoot
long ll_report

ls_Parm = Message.StringParm
ll_Pos = PosA(ls_Parm,'-')

il_view_id = Long(LeftA(ls_Parm,ll_Pos -1))
is_for = righta(ls_parm,len(ls_parm) - ll_pos )

//messagebox(ls_parm, string(il_view_id) + " ~r " + is_for)
//---------Begin Added by (Appeon)Stephen 03.31.2017 for Alpha id 5850 - Cannot manually change linking on the tables tab in IntelliReport. SaaS 03302017 and Client Server 15.304 Build Date 03072017-------
if gs_dbtype = 'ASA' then
	dw_fields.dataobject  = 'd_conv_link_select_table_field'
else
	dw_fields.dataobject  = 'd_conv_link_select_table_field_sql'
end if
//---------End Added ------------------------------------------------------
dw_fields.settransobject(sqlca)
dw_fields.retrieve( il_view_id)







//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-13 By: Andy

////---------Begin Modified by (Appeon)Stephen 06.26.2014 for IntelliReport Modifications 14.2--------
////il_data_view_id = Long(MidA(ls_Parm,ll_Pos + 1,ll_Pos2 - (ll_Pos + 1)))
//ll_pos_last = LastPos(ls_Parm, "-")
//il_data_view_id = Long(MidA(ls_Parm,ll_Pos + 1,ll_pos_last - (ll_Pos + 1)))
//il_data_view_id_cont = Long(MidA(ls_Parm,ll_pos_last + 1,ll_Pos2 - (ll_pos_last + 1)))
////---------End Modfiied ------------------------------------------------------
//is_table_name = MidA(ls_Parm,ll_Pos2 + 2)
//
////$<add> 2007-12-14 By: Andy
////tv_1.of_reset()
//tv_1.event pfc_populate( 0)
////Expand All
//ll_Root = tv_1.FindItem(RootTreeItem!, 0)
//ll_FistRoot = ll_Root
//DO WHILE (1=1)
//	IF ll_Root < 1 THEN  EXIT	
//	tv_1.ExpandAll(ll_Root)//expandItem
//	ll_Root = tv_1.FindItem(NextTreeItem!, ll_Root)	
//LOOP
//
//if ll_FistRoot > 0 then 
//	tv_1.selectitem( ll_FistRoot )
//END IF
//tv_1.setfocus( )

//---------------------------- APPEON END ----------------------------


end event

type dw_fields from datawindow within w_conv_select_fields
integer width = 1271
integer height = 1780
integer taborder = 50
string title = "none"
string dataobject = "d_conv_link_select_table_field"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
this.setrow(row)
end event

event doubleclicked;cb_ok.triggerevent(clicked!)
end event

type cb_1 from commandbutton within w_conv_select_fields
integer x = 41
integer y = 1808
integer width = 384
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Collapse All"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-17 By: Andy
of_expandcollapseall(this,tv_1)
//---------------------------- APPEON END ----------------------------
end event

type tv_1 from u_tvs_rpt within w_conv_select_fields
integer x = 1582
integer y = 124
integer width = 1166
integer height = 1680
integer taborder = 40
long backcolor = 1073741824
borderstyle borderstyle = stylelowered!
boolean disabledragdrop = true
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-14 By: Andy
this.of_register( 1, "module", "name", ":al_view_id,:as_v_name", "d_view_module_select", SQLCA, "")
this.of_register( 2, "v_name", "v_alias", ":al_view_id,:al_module,:as_v_name", "d_view_names_select", SQLCA, "")
if gs_DbType = 'SQL' THEN
	this.of_register( 3, "c_name", "c_alias", ":as_table,:al_data_view_id,:al_view_id,:al_onlyvisible, :al_data_view_id_cont", "d_view_fields_alias_sql", SQLCA, "")
ELSE
	this.of_register( 3, "c_name", "c_alias", ":as_table,:al_data_view_id,:al_view_id,:al_onlyvisible, :al_data_view_id_cont", "d_view_fields_alias_asa", SQLCA, "")
END IF
//---------------------------- APPEON END ----------------------------
end event

event doubleclicked;cb_ok.event clicked()
end event

type cb_cancel from commandbutton within w_conv_select_fields
integer x = 1006
integer y = 1808
integer width = 270
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_ok from commandbutton within w_conv_select_fields
integer x = 709
integer y = 1808
integer width = 270
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//Start Code Change ----02.17.2016 #V15 maha

str_link_fields str

//str.field_id = dw_fields.getitemnumber(dw_fields.getrow(),"field_id" )
//str.table_id = dw_fields.getitemnumber(dw_fields.getrow(),"table_id" )
str.field_name = dw_fields.getitemstring(dw_fields.getrow(),"c_name" )
str.table_name = dw_fields.getitemstring(dw_fields.getrow(),"table_name" )

CloseWithReturn( Parent, str )



//
//
//
//
//
////--------------------------- APPEON BEGIN ---------------------------
////$<Modify> 2007-12-14 By: Andy
//Long    ll_Handle,ll_Cnt,ll_Find
//TreeViewItem ltvi
//String  ls_c_name = ""
//Integer li_level  
//Long    ll_field_id = 0
//
//ll_Handle = tv_1.Finditem( CurrentTreeItem!, 0)
//if ll_Handle > 0 then
//	if tv_1.getItem(ll_handle,ltvi) = 1 then
//		tv_1.il_dragsource = 0
//		ls_c_name = String(ltvi.data)
//		li_level  = ltvi.level
//		
//		ll_Cnt = UPPERBOUND(tv_1.inv_attrib)
//		if ll_Cnt = li_level then//>=
//			ll_Find = tv_1.inv_attrib[li_level].ids_obj.Find("c_name='" + ls_c_name + "'",0,tv_1.inv_attrib[li_level].ids_obj.RowCount())
//			if ll_Find > 0 then
//				ll_field_id = tv_1.inv_attrib[li_level].ids_obj.GetItemNumber( ll_Find, "field_id" )
//			end if
//			CloseWithReturn( Parent, String( ll_field_id ) + "-" + ls_c_name )
//		end if
//	end if
//end if
//
////CloseWithReturn( Parent, String( dw_fields.GetItemNumber( dw_fields.GetRow(), "field_id" )) + "-" + dw_fields.GetItemString( dw_fields.GetRow(), "field_name" ) )
////---------------------------- APPEON END ----------------------------
//
//
end event

