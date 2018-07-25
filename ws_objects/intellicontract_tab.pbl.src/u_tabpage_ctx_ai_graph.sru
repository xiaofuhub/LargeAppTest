$PBExportHeader$u_tabpage_ctx_ai_graph.sru
$PBExportComments$[intellicontract_tab]  Contract Contact Tab Page
forward
global type u_tabpage_ctx_ai_graph from u_tabpg
end type
type dw_1 from u_dw within u_tabpage_ctx_ai_graph
end type
end forward

global type u_tabpage_ctx_ai_graph from u_tabpg
integer width = 3543
integer height = 1816
long backcolor = 33551856
string text = "Letter Status"
event ue_constructor ( )
dw_1 dw_1
end type
global u_tabpage_ctx_ai_graph u_tabpage_ctx_ai_graph

type variables
grObjectType MouseHit

integer SeriesNbr, ItemNbr


end variables

on u_tabpage_ctx_ai_graph.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpage_ctx_ai_graph.destroy
call super::destroy
destroy(this.dw_1)
end on

event constructor;call super::constructor;//grObjectType MouseHit

//integer SeriesNbr, ItemNbr

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-12-02 By: Zhang lingping
//$<reason> The parameter has declare in parent object u_tabpg. comment out local declare.
// tab i_parent_tab
//--------------------------- APPEON END ---------------------------

end event

type dw_1 from u_dw within u_tabpage_ctx_ai_graph
integer width = 3465
integer height = 1628
integer taborder = 10
boolean ib_isupdateable = false
end type

event pfc_retrieve;call super::pfc_retrieve;
dataobject = 'd_ctx_letter_status'
SETTRANSOBJECT(sqlca)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.29.2006 By: LeiWei
//$<reason> Fix a defect.
This.SetFilter("upper(ctx_action_items_action_user) = '" + upper(gs_user_id) + "' OR (isnull(ctx_action_items_action_user) and  isnull( print_flag ))")
//---------------------------- APPEON END ----------------------------

this.retrieve( )


return success
end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-12-02 By: Zhang lingping
//$<reason> The parameter has declare in instance variables.need change name.

//Integer SeriesNbr
//Integer ItemNbr
//--------------------------- APPEON END ---------------------------

Long ll_ver_method
String ls_series_name
String ls_category_name
String ls_where, ls_sql
String ls_from, ls_to

double data_value

choose case MouseHit
	case typedata!
			data_value = This.GetData("GRAPH_1", parent.SeriesNbr, parent.ItemNbr)
	      ls_series_name = This.SeriesName("GRAPH_1", parent.SeriesNbr) // needs/awaiting
	      ls_category_name = This.CategoryName("GRAPH_1", parent.ItemNbr) //type of letter

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 08.29.2006 By: LeiWei
			//$<reason> Fix a defect.
			ls_series_name = Trim(ls_series_name)
			ls_category_name = Trim(ls_category_name)
			//---------------------------- APPEON END ----------------------------
			
			I_parent_tab.FUNCTION DYNAMIC of_retrieve_data(ls_series_name,ls_category_name)
			I_parent_tab.FUNCTION DYNAMIC of_select_tab_details()
			
end choose 


end event

event clicked;call super::clicked;
mouseHit =  This.ObjectAtPointer("GRAPH_1", SeriesNbr, ItemNbr)
end event

