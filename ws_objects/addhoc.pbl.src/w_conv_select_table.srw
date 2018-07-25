$PBExportHeader$w_conv_select_table.srw
forward
global type w_conv_select_table from window
end type
type st_1 from statictext within w_conv_select_table
end type
type cb_1 from commandbutton within w_conv_select_table
end type
type tv_1 from u_tvs_rpt within w_conv_select_table
end type
type cb_cancel from commandbutton within w_conv_select_table
end type
type cb_ok from commandbutton within w_conv_select_table
end type
end forward

global type w_conv_select_table from window
integer x = 901
integer y = 172
integer width = 1463
integer height = 1924
windowtype windowtype = response!
long backcolor = 33551856
st_1 st_1
cb_1 cb_1
tv_1 tv_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_conv_select_table w_conv_select_table

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-13 By: Andy
Long il_view_id

//$<add> 2007-12-20 By: Andy
Protected:
n_ds ids_tables
//---------------------------- APPEON END ----------------------------
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
		
	CASE 2
		aa_arg[1] = il_view_id
		aa_arg[2] = ltvi_Item.data
		
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

on w_conv_select_table.create
this.st_1=create st_1
this.cb_1=create cb_1
this.tv_1=create tv_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.st_1,&
this.cb_1,&
this.tv_1,&
this.cb_cancel,&
this.cb_ok}
end on

on w_conv_select_table.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.tv_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-13 By: Andy
Long ll_Root,ll_FistRoot
il_view_id = Message.DoubleParm

//tv_1.of_reset()
tv_1.event pfc_populate( 0)
//Expand All
ll_Root = tv_1.FindItem(RootTreeItem!, 0)
ll_FistRoot = ll_Root
DO WHILE (1=1)
	IF ll_Root < 1 THEN  EXIT	
	tv_1.ExpandAll(ll_Root)//expandItem
	ll_Root = tv_1.FindItem(NextTreeItem!, ll_Root)	
LOOP

if ll_FistRoot > 0 then 
	tv_1.selectitem( ll_FistRoot )
END IF
tv_1.setfocus( )

//$<add> 2007-12-20 By: Andy
ids_tables = Create n_ds 
ids_tables.dataobject = "d_view_names_select_all"
ids_tables.settransobject( SQLCA )
ids_tables.retrieve( il_view_id )

//---------------------------- APPEON END ----------------------------
end event

event close;//$<add> 2007-12-20 By: Andy
if IsValid(ids_tables) then destroy ids_tables
end event

type st_1 from statictext within w_conv_select_table
integer x = 393
integer y = 8
integer width = 581
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Table"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_conv_select_table
integer x = 434
integer y = 1808
integer width = 384
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Collapse All"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-17 By: Andy
of_expandcollapseall(this,tv_1)
//---------------------------- APPEON END ----------------------------
end event

type tv_1 from u_tvs_rpt within w_conv_select_table
integer y = 88
integer width = 1445
integer height = 1704
integer taborder = 40
long backcolor = 1073741824
borderstyle borderstyle = stylelowered!
boolean disabledragdrop = true
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-10 By: Andy
this.of_register( 1, "module", "name", ":al_view_id", "d_view_module_fields", SQLCA, "")
this.of_register( 2, "v_name", "v_alias", ":al_view_id,:al_module", "d_view_names_fields", SQLCA, "")
//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;cb_ok.event clicked()
end event

type cb_cancel from commandbutton within w_conv_select_table
integer x = 1143
integer y = 1808
integer width = 270
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_ok from commandbutton within w_conv_select_table
integer x = 846
integer y = 1808
integer width = 270
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
boolean default = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 02.22.2008 By: Andy
Long    ll_Handle,ll_Cnt,ll_Find
TreeViewItem ltvi
String  ls_v_name = ""
Integer li_level  
Long    ll_table_id = 0

ll_Handle = tv_1.Finditem( CurrentTreeItem!, 0)
if ll_Handle > 0 then
	if tv_1.getItem(ll_handle,ltvi) = 1 then
		tv_1.il_dragsource = 0
		ls_v_name = String(ltvi.data)
		li_level  = ltvi.level
		
		ll_Cnt = UPPERBOUND(tv_1.inv_attrib)
		if ll_Cnt = li_level then//>=
			ll_Find = ids_tables.Find("v_name='" + ls_v_name + "'",0,ids_tables.RowCount())
			if ll_Find > 0 then
				ll_table_id = ids_tables.GetItemNumber( ll_Find, "table_id" )
			end if
			CloseWithReturn( Parent, String( ll_table_id ) + "-" + ls_v_name )
		end if
	end if
end if

//---------------------------- APPEON END ----------------------------
end event

