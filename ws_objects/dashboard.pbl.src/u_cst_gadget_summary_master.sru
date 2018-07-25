$PBExportHeader$u_cst_gadget_summary_master.sru
forward
global type u_cst_gadget_summary_master from u_cst_gadget
end type
end forward

global type u_cst_gadget_summary_master from u_cst_gadget
integer width = 1253
integer height = 716
event ue_retrieve_dotolist ( )
end type
global u_cst_gadget_summary_master u_cst_gadget_summary_master

type variables
Integer ii_summary_id,ii_report_id
Integer ii_isgraph
Integer ii_graph_type
String  is_report_name,is_tdl_name
Long il_tdl_right
Long il_tdl_id
String is_tdl_user,is_other_user

Long il_tdl_id_arr[],il_tdli_id_arr[],il_tdli_cnt_arr[]
end variables

forward prototypes
public function integer of_set_report_dataobject ()
public function integer of_settings ()
public function integer of_set_report_dataobject (integer ai_report_id, integer ai_isgraph, integer ai_graph_type, string as_report_name)
public function integer of_swich_type ()
end prototypes

event ue_retrieve_dotolist();//////////////////////////////////////////////////////////////////////
// $<event>ue_retrieve_dotolistu_cst_gadget_summary_master()
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.26.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_where[],ls_filter[]
String ls_sql,ls_module[]
Datetime ldt_where_due_date
String ls_error_syntaxfromSQL, ls_error_create
String ls_syntax
Long ll_count,ll_ret = 1,i,ll_row,ll_find_row,ll_exist_tdl_id
Long ll_empty[]
DataStore lds_tdl_name
DataStore lds_tdl_cnt
DataStore lds_dashb_todolist
n_cst_tdl_function lnv_tdl_function

SetNull(ldt_where_due_date)

//Reset Arrary
il_tdl_id_arr[] = ll_empty[]
il_tdli_id_arr[] =ll_empty[]
il_tdli_cnt_arr[] = ll_empty[]

//Retrieve To Do List Access Data
gnv_appeondb.of_startqueue( )
SELECT tdl_rights,tdl_other_user into :il_tdl_right,:is_other_user from security_users where user_id = :gs_user_id;
Select tdl_basic_info.tdl_id Into :ll_exist_tdl_id from tdl_basic_info,tdl_security_roles_rights,security_users
WHERE ( tdl_basic_info.tdl_id = tdl_security_roles_rights.tdl_id ) AND 
		( tdl_security_roles_rights.role_id = security_users.role_id )  AND
		( tdl_security_roles_rights.access_rights = 1 ) AND
		( security_users.user_id = :gs_user_id )   and 
		( tdl_basic_info.tdl_id = :il_tdl_id );
gnv_appeondb.of_commitqueue( )

If il_tdl_right <> 2 and is_tdl_user <> gs_user_id Then 
	is_tdl_user = gs_user_id
End If
If is_tdl_user = '-ALL-' Then
	il_tdl_right = 2
	is_other_user = ''
End If

//Change to ALL TO DO LIST, If No access for current tdl_id for current user.
If il_tdl_right <> 2 And il_tdl_id <> 0 and (isnull(ll_exist_tdl_id) or ll_exist_tdl_id = 0) Then
	il_tdl_id = 0 
End If
If il_tdl_id = 0 Then is_tdl_name = '-ALL-'

//Modify Report Title
is_report_name = 'To Do List Summary (' + is_tdl_user + ',' + is_tdl_name + ') '
of_set_title(is_report_name)
If ii_isgraph = 1 Then 
	dw_content.Modify('gr_1.title = "'+ is_report_name+'"') 
End If

//Retrieve To do list item
ls_module = {"03","04"}//lnv_tdl_function.of_get_module(ls_module[])//(Appeon)Toney 10.14.2013 - V141 ISG-CLX  Fix Reintegration BugH101101, only support contract biz(03, 04)
lds_tdl_name = Create DataStore
lds_tdl_name.Dataobject = 'd_tdl_painter_detail_list'
lds_tdl_name.SetTransObject(SQLCA)
If is_tdl_user = '-ALL-' Then
	lds_tdl_name.Retrieve('%',ls_module[])
Else
	lds_tdl_name.Retrieve(is_tdl_user,ls_module[])
End If

//Calculates count for each to do list item.
ls_sql = lnv_tdl_function.of_gen_tdl_sql(is_tdl_user, lds_tdl_name, ls_where[], ls_filter[], ldt_where_due_date, il_tdl_right, is_other_user)//(Appeon)Toney 10.14.2013 - V141 ISG-CLX  Fix Reintegration BugH101101,re-call the original method
//ls_sql = lnv_tdl_function.of_gen_tdl_sql(is_tdl_user, lds_tdl_name, ls_where[], ls_filter[], ldt_where_due_date, il_tdl_right, is_other_user, 0) //(Appeon)Eugene 06.13.2013 - V141 ISG-CLX
																																													  //(Appeon)Toney 10.14.2013 - V141 ISG-CLX  Fix Reintegration BugH101101,re-call the original method

If ls_sql <> '' Then
	lds_tdl_cnt = Create DataStore 
	ls_syntax = SQLCA.SyntaxFromSQL(ls_sql, 'Style(Type=Grid)', ls_error_syntaxfromSQL)
	IF Len(ls_error_syntaxfromSQL) > 0 THEN
		Messagebox('Syntax Error',ls_error_syntaxfromSQL)
		ll_ret = -1
	ELSE
		lds_tdl_cnt.Create(ls_syntax, ls_error_create)
		IF Len(ls_error_create) > 0 THEN
			Messagebox('Create Error',ls_error_create)
			ll_ret = -1
		END IF
	END IF
	If ll_ret = 1 Then
		lds_tdl_cnt.SetTransObject(SQLCA)
		lds_tdl_cnt.Retrieve()
		If il_tdl_id > 0 Then 
			lds_tdl_cnt.SetFilter('#1 =' + String(il_tdl_id))
			lds_tdl_cnt.Filter()
		Else
			lds_tdl_cnt.SetFilter('1 = 1')
			lds_tdl_cnt.Filter()				
		End If
		ll_count = lds_tdl_cnt.RowCount()
		If ll_count > 0 Then		
			il_tdl_id_arr[] = lds_tdl_cnt.object.#1[1,ll_count]
			il_tdli_id_arr[] = lds_tdl_cnt.object.#2[1,ll_count]
			il_tdli_cnt_arr[] = lds_tdl_cnt.object.#3[1,ll_count]
		End If
	End If
End If

//Write data to report DW.
dw_content.SetRedraw(False)
dw_content.Reset()
For i = 1 To UpperBound(il_tdl_id_arr[])
	ll_find_row = lds_tdl_name.Find('tdl_id = ' + String(il_tdl_id_arr[i]) + ' And tdli_id = ' + String(il_tdli_id_arr[i]) + ' And use_graph = 1 ' , 1 , lds_tdl_name.RowCount() )
	If ll_find_row > 0 Then
		ll_row = dw_content.InsertRow(0)	
		dw_content.SetItem(ll_row,'tdl_id',il_tdl_id_arr[i])
		dw_content.SetItem(ll_row,'tdli_id',il_tdli_id_arr[i])
		dw_content.SetItem(ll_row,'tdli_cnt',il_tdli_cnt_arr[i])
		dw_content.SetItem(ll_row,'tdl_name',lds_tdl_name.GetItemString(ll_find_row,'tdl_basic_info_tdl_name'))
		dw_content.SetItem(ll_row,'tdli_graph_category',lds_tdl_name.GetItemString(ll_find_row,'graph_category'))
	End If
Next
dw_content.SetSort('tdli_graph_category A')
dw_content.Sort()
dw_content.SetRedraw(True)

If isvalid(lds_tdl_name) Then Destroy lds_tdl_name
If isvalid(lds_tdl_cnt) Then Destroy lds_tdl_cnt



end event

public function integer of_set_report_dataobject ();long ll_row
Integer li_isgraph
Long ll_tdl_name

If ii_summary_id = 0 Then Return -1

n_ds nds_reports
 
nds_reports = w_dashboard.inv_dashboard.ids_dashboard_reports

ll_row = nds_reports.Find('user_id = "'+gs_user_id +'" And tab_id = '+String(iuo_tabpge_gadget.istr_current_tab.sl_tab_id) + ' And summary_id = '+ String(ii_summary_id) ,1,nds_reports.RowCount()) 
If ll_row > 0 Then
	ii_report_id = nds_reports.GetItemNumber(ll_row,'report_id')
	ii_isgraph = nds_reports.GetItemNumber(ll_row,'is_graph')
	ii_graph_type = nds_reports.GetItemNumber(ll_row,'graph_type')
	If isnull(ii_graph_type) or ii_graph_type = 0 Then ii_graph_type = 2
	is_report_name = nds_reports.GetItemString(ll_row,'report_name')
	
	//To Do List Summary
	If ii_report_id = 7 Then
		il_tdl_id = nds_reports.GetItemNumber(ll_row,'tdl_id')
		is_tdl_user = nds_reports.GetItemString(ll_row,'tdl_user')
		If isnull(is_tdl_user) or is_tdl_user = '' Then 
			is_tdl_user = gs_user_id
		ElseIf is_tdl_user = '-ALL-' Then
			//is_tdl_user = '%'
		End If
		If il_tdl_id = 0 or Isnull(il_tdl_id) Then
			is_report_name = 'To Do List'
			il_tdl_id = 0
		Else
			is_tdl_name = nds_reports.GetItemString(ll_row,'tdl_name')
			is_report_name = 'To Do List - ' +  is_tdl_name
		End If
	End If
	
	of_set_report_dataobject(ii_report_id,ii_isgraph,ii_graph_type,is_report_name)
End If


Return 1
end function

public function integer of_settings ();OpenwithParm(w_dashboard_gadget_summary_config,This)
If Message.stringparm = 'OK' Then
	Event ue_retrieve()
	of_set_properties() //Refresh UI
End If


Return 1
end function

public function integer of_set_report_dataobject (integer ai_report_id, integer ai_isgraph, integer ai_graph_type, string as_report_name);Integer li_graph_type

If isnull(as_report_name) Then as_report_name = ''

//Access Right Check For Contract
If m_pfe_cst_master_menu.m_file.m_contract.Visible = False Then
	If ai_report_id >= 1 and ai_report_id <= 6 Then 
		dw_content.dataobject = ''
		Return 1
	End If
End If

//Access Right Check For ToDoList
If m_pfe_cst_master_menu.m_file.m_todolist.Visible = False Then
	If ai_report_id = 7 Then 
		dw_content.dataobject = ''
		Return 1
	End If
End If

//Access Right Check For Other
//...



Choose Case ai_report_id
	Case 1	//Contracts Category
		If ai_isgraph = 1 Then
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_category_gh'
		Else
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_category'			
		End If
	Case 2	//Contracts Status
		If ai_isgraph = 1 Then
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_status_gh'
		Else
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_status'			
		End If		
	Case 3	//My Owner Contracts Category
		If ai_isgraph = 1 Then
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_own_cate_gh'
		Else
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_own_cate'			
		End If		
	Case 4	//My Owner Contracts Status
		If ai_isgraph = 1 Then
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_own_stat_gh'
		Else
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_own_stat'			
		End If		
	Case 5	//Expired Contracts Category
		If ai_isgraph = 1 Then
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_expir_gh'
		Else
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_expir'			
		End If		
	Case 6	//Contracts Amounts
		If ai_isgraph = 1 Then
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_amount_gh'
		Else
			dw_content.dataobject = 'd_dashb_gadget_summary_ctx_amount'			
		End If	
	Case 7
		If ai_isgraph = 1 Then
			dw_content.dataobject = 'd_dashb_gadget_summary_todolist_gh'
		Else
			dw_content.dataobject = 'd_dashb_gadget_summary_todolist'			
		End If			
	Case else
		dw_content.dataobject = ''	
End Choose

dw_content.SetTransObject(SQLCA)
If ai_isgraph = 1 Then
	dw_content.Modify('gr_1.graphtype = '+String(ai_graph_type)) 
	dw_content.Modify('gr_1.title = "'+ as_report_name+' Summary"') 
Else
	of_set_property(CONST_BG_COLOR,iuo_tabpge_gadget.istr_current_tab.sl_gadget_bg_color)
End If
//of_set_title('Summary '+String(ii_summary_id)+':'+as_report_name) //ContractLogix Group suggestion: No need 'Summary 1/2/3/4/5'
of_set_title(as_report_name)
Return 1
end function

public function integer of_swich_type ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget_summary_master::of_swich_type()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 09.16.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

n_ds nds_reports 
nds_reports = w_dashboard.inv_dashboard.ids_dashboard_reports
Long ll_row

//Swich Type
If ii_isgraph = 1 Then
	ii_isgraph = 0
Else
	ii_isgraph = 1
End If

//Find and modify data
ll_row = nds_reports.Find('user_id = "'+gs_user_id +'" And tab_id = '+&
	String(This.iuo_tabpge_gadget.istr_current_tab.sl_tab_id) +&
	' And summary_id = '+ String(ii_summary_id) ,1,nds_reports.RowCount()) 
If ll_row <= 0 Then Return -1	
If ll_row > 0 Then
	nds_reports.SetItem(ll_row,'is_graph',ii_isgraph)
End If

//Save data
gnv_appeondb.of_autocommitrollback( )
If nds_reports.update() = 1 Then
	Commit;
Else
	Rollback;
	Messagebox('Save Error','Failed to save the changes, please call support.')
End If

//Change dataobject
of_set_report_dataobject()

//Retrieve data
Event ue_retrieve()

Return 1

end function

on u_cst_gadget_summary_master.create
call super::create
end on

on u_cst_gadget_summary_master.destroy
call super::destroy
end on

event ue_retrieve;//Override Ancestor Script
of_set_report_dataobject()

If ii_report_id < 7 Then
	//For CTX Summary
	Super::Event ue_retrieve()
ElseIf ii_report_id = 7 Then
	//For To Do List Summary. Jump Outer APB Queue with Post Event. Ken.Guo
	Post Event ue_retrieve_dotolist()
End If
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event>constructoru_cst_gadget_summary_master()
// $<arguments>(None)
// $<returns> long
// $<description> If you want to drag this type gadget to tabpg,
// $<description> you need set ii_summary_id value in u_gadget_*::constructor event.
//////////////////////////////////////////////////////////////////////
// $<add> 09.09.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Set Edit toolbar to visible
of_edit_visible(1)

end event

event ue_run;call super::ue_run;If dw_content.dataobject <> '' Then
	of_swich_type()
End If
Return 1
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_summary_master
event ue_set_row ( string as_category )
integer x = 0
integer y = 84
integer width = 1253
integer height = 620
end type

event dw_content::ue_set_row(string as_category);Long ll_Row
If ii_isgraph = 0 and as_category <> '' Then
	If Len(This.Describe("code_lookup_category_name.Attributes")) > 1 Then
		ll_Row = This.Find('code_lookup_category_name = "'+as_category+'"',1,This.Rowcount())
	End If
	If Len(This.Describe("code_lookup_status_name.Attributes")) > 1 Then
		ll_Row = This.Find('code_lookup_status_name = "'+as_category+'"',1,This.Rowcount())
	End If
	If Len(This.Describe("tdli_graph_category.Attributes")) > 1 Then
		ll_Row = This.Find('tdli_graph_category = "'+as_category+'"',1,This.Rowcount())
	End If	
	If ll_Row > 0 Then
		This.SelectRow(0,False)
		This.SelectRow(ll_Row,True)
		This.ScrolltoRow(ll_Row)
	Else
		This.SelectRow(0,False)		
	End If
End If
end event

event dw_content::doubleclicked;//Override Ancestor Script

Integer li_serr,li_num
Long ll_Row
String ls_category
grobjecttype object_type

If ii_isgraph = 1 Then
	This.ObjectAtPointer('gr_1',li_serr,li_num)
	ls_category = This.CategoryName('gr_1',li_num)
End If
	
Parent.Event ue_run(1)

This.Post Event ue_set_row(ls_category)


end event

event dw_content::clicked;//Override Ancestor Script
end event

event dw_content::constructor;call super::constructor;dw_content.of_setupdateable(False)
end event

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_summary_master
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_summary_master
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_summary_master
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_summary_master
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_summary_master
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_summary_master
end type

