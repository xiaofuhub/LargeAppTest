$PBExportHeader$w_contract_globalsearch.srw
forward
global type w_contract_globalsearch from w_popup
end type
type st_tip from statictext within w_contract_globalsearch
end type
type cb_4 from u_cb within w_contract_globalsearch
end type
type dw_results from u_dw within w_contract_globalsearch
end type
type st_1 from statictext within w_contract_globalsearch
end type
type cb_3 from u_cb within w_contract_globalsearch
end type
type cb_2 from u_cb within w_contract_globalsearch
end type
type cb_1 from u_cb within w_contract_globalsearch
end type
type cb_select from u_cb within w_contract_globalsearch
end type
type tv_results from u_tv within w_contract_globalsearch
end type
type dw_term from u_dw within w_contract_globalsearch
end type
end forward

global type w_contract_globalsearch from w_popup
integer width = 2839
integer height = 2224
string title = "Full Text Search"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
event ue_search_tab_1 ( )
event ue_search_tab_2 ( )
event ue_search_tab_3 ( )
event ue_search_tab_4 ( )
event ue_search_tab_5 ( )
event ue_search_tab_6 ( )
event ue_search_tab_7 ( )
event ue_search_tab_8 ( )
event ue_criteria_contract ( )
event ue_auto_search ( )
event ue_search_tab_9 ( )
event ue_search_tab_10 ( )
st_tip st_tip
cb_4 cb_4
dw_results dw_results
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_select cb_select
tv_results tv_results
dw_term dw_term
end type
global w_contract_globalsearch w_contract_globalsearch

type prototypes
//BEGIN---Modify by Jervis 12.02.2008
Function long SendMessage(long hWnd, ulong Msg, long wParam, long lParam) Library "user32.dll" Alias For "SendMessageA"

end prototypes

type variables
Constant Integer ii_tabcount = 10	// Max num of seach in tab

str_global_search istr_global_search //Added by Ken.Guo 2008-08-04

Boolean ib_ctx_retrieve = false //(Appeon)Harry 02.24.2014 - for Bug # 3867 -3

Private:
String is_searchtext
String is_resultsnum
String is_contracts
String is_sql
long il_contract_array[]
//Long il_ctx_id // Delete by Evan 01.31.2008
w_contract iw_contract

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.11.2007 By: Machongmin
//$<reason> Fix a defect.
long il_resultsnum,il_count
//---------------------------- APPEON END ----------------------------

n_ds in_filter //long.zhang 04.19.2013  //(Appeon)Harry 06.28.2013 - V141 ISG-CLX
end variables

forward prototypes
public function integer of_start_search ()
public function integer of_fill_treeview ()
public function long of_get_ctx_id ()
public function integer of_filter_results ()
public function integer of_set_contractarray (long al_contract[])
public function integer of_checked ()
public function string of_get_ctx_whereclause ()
end prototypes

event ue_search_tab_1();//////////////////////////////////////////////////////////////////////
// $<event> ue_search_tab_1
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Generate SQL syntax for search according to Serach In tab
// $<description> TAB 1 - Support Document
//////////////////////////////////////////////////////////////////////
// $<add> 11.02.2006 by Davis
//////////////////////////////////////////////////////////////////////

String ls_sql
String ls_select
//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, 'Document Manager', "
/*
ls_sql += ls_select + "'Description' from ctx_images "+&
		"where contains(page_description, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'File Name' from ctx_images "+&
		"where contains(file_name, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Insert By User' from ctx_image "+&
		"where contains(inserted_by_user, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Update By User' from ctx_image "+&
		"where contains(updated_by_user, '" + is_searchtext + "')" + is_contracts

ls_sql += "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), image_id, 'Document Manager', " +&
		"'Document -> ' + file_name from ctx_images "+&
		"where exists(select 1 from ctx_image where ctx_images.image_id = ctx_image.image_id and "+&
		"( contains(image_file, '" + is_searchtext + "') or contains(pdftext, '" + is_searchtext + "') )) " + is_contracts
*/

ls_sql += ls_select + "'Description' from ctx_am_document "+&
		"where contains(notes, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Document Name' from ctx_am_document "+&
		"where contains(doc_name, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Create By User' from ctx_am_document "+&
		"where contains(create_by, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Document Audit' from ctx_am_document "+&
		"where exists(select 1 from ctx_am_doc_audit where ctx_am_document.doc_id = ctx_am_doc_audit.doc_id and "+&
		"( contains(action, '" + is_searchtext + "') or contains(filename, '" + is_searchtext + "') or contains(notes, '" + is_searchtext + "') )) " + is_contracts

ls_sql += "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), doc_id, 'Document Manager', " +&
		"'Document -> ' + doc_name from ctx_am_document "+&
		"where exists(select 1 from ctx_am_doc_image where ctx_am_document.doc_id = ctx_am_doc_image.doc_id and "+&
		"( contains(image_file, '" + is_searchtext + "') or contains(pdftext, '" + is_searchtext + "') )) " + is_contracts
*/

ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, 'Document Manager' as c, "
/*
ls_sql += ls_select + "'Description' from ctx_images "+&
		"where contains(page_description, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'File Name' from ctx_images "+&
		"where contains(file_name, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Insert By User' from ctx_image "+&
		"where contains(inserted_by_user, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Update By User' from ctx_image "+&
		"where contains(updated_by_user, '" + is_searchtext + "')" + is_contracts

ls_sql += "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), image_id, 'Document Manager', " +&
		"'Document -> ' + file_name from ctx_images "+&
		"where exists(select 1 from ctx_image where ctx_images.image_id = ctx_image.image_id and "+&
		"( contains(image_file, '" + is_searchtext + "') or contains(pdftext, '" + is_searchtext + "') )) " + is_contracts
*/

ls_sql += ls_select + "'Description' as d from ctx_am_document "+&
		"where contains(notes, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Document Name' as d from ctx_am_document "+&
		"where contains(doc_name, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Create By User' as d from ctx_am_document "+&
		"where contains(create_by, '" + is_searchtext + "')" + is_contracts

//---------Begin Commented by (Appeon)Harry  09.01.2014 for BugH062401 of V14.2 Issues of Integration--------
/*
ls_sql += ls_select + "'Document Audit' as d from ctx_am_document "+&
		"where exists(select 1 from ctx_am_doc_audit where ctx_am_document.doc_id = ctx_am_doc_audit.doc_id and "+&
		"( contains(action, '" + is_searchtext + "') or contains(filename, '" + is_searchtext + "') or contains(notes, '" + is_searchtext + "') )) " + is_contracts
*/
//---------End Commented ------------------------------------------------------

ls_sql += "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, doc_id as b, 'Document Manager' as c, " +&
		"'Document -> ' + doc_name as d from ctx_am_document "+&
		"where exists(select 1 from ctx_am_doc_image where ctx_am_document.doc_id = ctx_am_doc_image.doc_id and "+&
		"( contains(image_file, '" + is_searchtext + "') or contains(pdftext, '" + is_searchtext + "') )) " + is_contracts
//---------End Modfiied ------------------------------------------------------

is_sql += ls_sql
end event

event ue_search_tab_2();//////////////////////////////////////////////////////////////////////
// $<event> ue_search_tab_2
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Generate SQL syntax for search according to Serach In tab
// $<description> TAB 2 - Detail
//////////////////////////////////////////////////////////////////////
// $<add> 11.02.2006 by Davis
//////////////////////////////////////////////////////////////////////

String ls_sql
String ls_select
//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, 'Detail', "

ls_sql += ls_select + "'File location' from ctx_basic_info "+&
		"where contains(file_location, '" + is_searchtext + "')" + is_contracts
ls_sql += ls_select + "'Notes' from ctx_basic_info "+&
		"where contains(notes, '" + is_searchtext + "')" + is_contracts
ls_sql += ls_select + "'Custom 1' from ctx_basic_info "+&
		"where (contains(Custom_1, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_1 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 2' from ctx_basic_info "+&
		"where (contains(Custom_2, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_2 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 3' from ctx_basic_info "+&
		"where (contains(Custom_3, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_3 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 4' from ctx_basic_info "+&
		"where (contains(Custom_4, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_4 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 5' from ctx_basic_info "+&
		"where (contains(Custom_5, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_5 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 6' from ctx_basic_info "+&
		"where (contains(Custom_6, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_6 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 7' from ctx_basic_info "+&
		"where (contains(Custom_7, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_7 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 8' from ctx_basic_info "+&
		"where (contains(Custom_8, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_8 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 9' from ctx_basic_info "+&
		"where (contains(Custom_9, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_9 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 10' from ctx_basic_info "+&
		"where (contains(Custom_10, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_10 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Custom 11' from ctx_basic_info "+&
		"where (contains(Custom_11, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_11 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 12' from ctx_basic_info "+&
		"where (contains(Custom_12, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_12 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 13' from ctx_basic_info "+&
		"where (contains(Custom_13, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_13 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 14' from ctx_basic_info "+&
		"where (contains(Custom_14, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_14 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 15' from ctx_basic_info "+&
		"where (contains(Custom_15, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_15 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 16' from ctx_basic_info "+&
		"where (contains(Custom_16, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_16 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 17' from ctx_basic_info "+&
		"where (contains(Custom_17, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_17 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 18' from ctx_basic_info "+&
		"where (contains(Custom_18, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_18 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 19' from ctx_basic_info "+&
		"where (contains(Custom_19, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_19 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 20' from ctx_basic_info "+&
		"where (contains(Custom_20, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_20 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Category' from ctx_basic_info "+&
		"where exists(select 1 from code_lookup where category = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Company Name' from ctx_basic_info "+&
		"where exists(select 1 from app_facility where app_facility = facility_id and contains(facility_name, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Contract Type' from ctx_basic_info "+&
		"where exists(select 1 from code_lookup where Contract_type = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Division' from ctx_basic_info "+&
		"where exists(select 1 from code_lookup where dvision = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Product Type' from ctx_products "+&
		"where exists(select 1 from code_lookup where product_type = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Product Name' from ctx_products "+&
		"where exists(select 1 from code_lookup where product_id = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts

//Added By Ken.Guo 05/29/2012. Add for Ctx_custom Table
ls_sql += ls_select + "'Custom Data 2 -> Custom 1' from ctx_custom "+&
		"where (contains(Custom_1, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_1 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 2' from ctx_custom "+&
		"where (contains(Custom_2, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_2 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 3' from ctx_custom "+&
		"where (contains(Custom_3, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_3 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 4' from ctx_custom "+&
		"where (contains(Custom_4, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_4 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 5' from ctx_custom "+&
		"where (contains(Custom_5, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_5 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 6' from ctx_custom "+&
		"where (contains(Custom_6, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_6 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 7' from ctx_custom "+&
		"where (contains(Custom_7, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_7 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 8' from ctx_custom "+&
		"where (contains(Custom_8, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_8 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 9' from ctx_custom "+&
		"where (contains(Custom_9, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_9 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 10' from ctx_custom "+&
		"where (contains(Custom_10, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_10 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 11' from ctx_custom "+&
		"where (contains(Custom_11, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_11 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 12' from ctx_custom "+&
		"where (contains(Custom_12, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_12 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 13' from ctx_custom "+&
		"where (contains(Custom_13, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_13 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 14' from ctx_custom "+&
		"where (contains(Custom_14, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_14 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 15' from ctx_custom "+&
		"where (contains(Custom_15, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_15 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 16' from ctx_custom "+&
		"where (contains(Custom_16, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_16 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 17' from ctx_custom "+&
		"where (contains(Custom_17, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_17 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 18' from ctx_custom "+&
		"where (contains(Custom_18, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_18 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 19' from ctx_custom "+&
		"where (contains(Custom_19, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_19 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 20' from ctx_custom "+&
		"where (contains(Custom_20, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_20 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_1' from ctx_custom "+&
		"where (contains(custom_notes_1, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_1 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_2' from ctx_custom "+&
		"where (contains(custom_notes_2, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_2 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_3' from ctx_custom "+&
		"where (contains(custom_notes_3, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_3 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_4' from ctx_custom "+&
		"where (contains(custom_notes_4, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_4 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_5' from ctx_custom "+&
		"where (contains(custom_notes_5, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_5 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
*/

ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, 'Detail' as c, "

ls_sql += ls_select + "'File location' as d from ctx_basic_info "+&
		"where contains(file_location, '" + is_searchtext + "')" + is_contracts
ls_sql += ls_select + "'Notes' as d from ctx_basic_info "+&
		"where contains(notes, '" + is_searchtext + "')" + is_contracts
ls_sql += ls_select + "'Custom 1' as d from ctx_basic_info "+&
		"where (contains(Custom_1, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_1 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 2' as d from ctx_basic_info "+&
		"where (contains(Custom_2, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_2 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 3' as d from ctx_basic_info "+&
		"where (contains(Custom_3, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_3 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 4' as d from ctx_basic_info "+&
		"where (contains(Custom_4, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_4 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 5' as d from ctx_basic_info "+&
		"where (contains(Custom_5, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_5 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 6' as d from ctx_basic_info "+&
		"where (contains(Custom_6, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_6 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 7' as d from ctx_basic_info "+&
		"where (contains(Custom_7, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_7 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 8' as d from ctx_basic_info "+&
		"where (contains(Custom_8, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_8 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 9' as d from ctx_basic_info "+&
		"where (contains(Custom_9, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_9 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 10' as d from ctx_basic_info "+&
		"where (contains(Custom_10, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_10 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Custom 11' as d from ctx_basic_info "+&
		"where (contains(Custom_11, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_11 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 12' as d from ctx_basic_info "+&
		"where (contains(Custom_12, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_12 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 13' as d from ctx_basic_info "+&
		"where (contains(Custom_13, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_13 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 14' as d from ctx_basic_info "+&
		"where (contains(Custom_14, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_14 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 15' as d from ctx_basic_info "+&
		"where (contains(Custom_15, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_15 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 16' as d from ctx_basic_info "+&
		"where (contains(Custom_16, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_16 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 17' as d from ctx_basic_info "+&
		"where (contains(Custom_17, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_17 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 18' as d from ctx_basic_info "+&
		"where (contains(Custom_18, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_18 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 19' as d from ctx_basic_info "+&
		"where (contains(Custom_19, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_19 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom 20' as d from ctx_basic_info "+&
		"where (contains(Custom_20, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.Custom_20 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts

//---------Begin Added by (Appeon)Harry 04.14.2016 for Bug_id#5102--------
ls_sql += ls_select + "'Custom Notes_1' as d from ctx_basic_info "+&
		"where (contains(custom_notes_1, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.custom_notes_1 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Notes_2' as d from ctx_basic_info "+&
		"where (contains(custom_notes_2, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.custom_notes_2 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Notes_3' as d from ctx_basic_info "+&
		"where (contains(custom_notes_3, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.custom_notes_3 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Notes_4' as d from ctx_basic_info "+&
		"where (contains(custom_notes_4, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.custom_notes_4 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Notes_5' as d from ctx_basic_info "+&
		"where (contains(custom_notes_5, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_basic_info.custom_notes_5 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
//---------End Added ------------------------------------------------------

ls_sql += ls_select + "'Category' as d from ctx_basic_info "+&
		"where exists(select 1 from code_lookup where category = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Company Name' as d from ctx_basic_info "+&
		"where exists(select 1 from app_facility where app_facility = facility_id and contains(facility_name, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Contract Type' as d from ctx_basic_info "+&
		"where exists(select 1 from code_lookup where Contract_type = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Division' as d from ctx_basic_info "+&
		"where exists(select 1 from code_lookup where dvision = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Product Type' as d from ctx_products "+&
		"where exists(select 1 from code_lookup where product_type = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Product Name' as d from ctx_products "+&
		"where exists(select 1 from code_lookup where product_id = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts

//Added By Ken.Guo 05/29/2012. Add for Ctx_custom Table
ls_sql += ls_select + "'Custom Data 2 -> Custom 1' as d from ctx_custom "+&
		"where (contains(Custom_1, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_1 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 2' as d from ctx_custom "+&
		"where (contains(Custom_2, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_2 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 3' as d from ctx_custom "+&
		"where (contains(Custom_3, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_3 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 4' as d from ctx_custom "+&
		"where (contains(Custom_4, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_4 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 5' as d from ctx_custom "+&
		"where (contains(Custom_5, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_5 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 6' as d from ctx_custom "+&
		"where (contains(Custom_6, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_6 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 7' as d from ctx_custom "+&
		"where (contains(Custom_7, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_7 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 8' as d from ctx_custom "+&
		"where (contains(Custom_8, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_8 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 9' as d from ctx_custom "+&
		"where (contains(Custom_9, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_9 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 10' as d from ctx_custom "+&
		"where (contains(Custom_10, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_10 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 11' as d from ctx_custom "+&
		"where (contains(Custom_11, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_11 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 12' as d from ctx_custom "+&
		"where (contains(Custom_12, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_12 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 13' as d from ctx_custom "+&
		"where (contains(Custom_13, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_13 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 14' as d from ctx_custom "+&
		"where (contains(Custom_14, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_14 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 15' as d from ctx_custom "+&
		"where (contains(Custom_15, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_15 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 16' as d from ctx_custom "+&
		"where (contains(Custom_16, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_16 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 17' as d from ctx_custom "+&
		"where (contains(Custom_17, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_17 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 18' as d from ctx_custom "+&
		"where (contains(Custom_18, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_18 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 19' as d from ctx_custom "+&
		"where (contains(Custom_19, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_19 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom 20' as d from ctx_custom "+&
		"where (contains(Custom_20, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.Custom_20 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_1' as d from ctx_custom "+&
		"where (contains(custom_notes_1, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_1 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_2' as d from ctx_custom "+&
		"where (contains(custom_notes_2, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_2 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_3' as d from ctx_custom "+&
		"where (contains(custom_notes_3, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_3 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_4' as d from ctx_custom "+&
		"where (contains(custom_notes_4, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_4 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Data 2 -> Custom Notes_5' as d from ctx_custom "+&
		"where (contains(custom_notes_5, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_custom.custom_notes_5 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
//---------End Modfiied ------------------------------------------------------

//-------------appeon begin----------------------
//<$>added:long.zhang 04.18.2014
ls_sql += ls_select + "'Linked Providers -> Custom 1' as d from ctx_prac_link "+&
		"where (contains(custom_1, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Linked Providers -> Custom 2' as d from ctx_prac_link "+&
		"where (contains(custom_2, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Linked Providers -> Custom 3' as d from ctx_prac_link "+&
		"where (contains(custom_3, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Linked Providers -> Custom 4' as d from ctx_prac_link "+&
		"where (contains(custom_4, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Linked Providers -> Custom 5' as d from ctx_prac_link "+&
		"where (contains(custom_5, '" + is_searchtext + "'))" + is_contracts		
//<$>reason:v14.2 Provider-Contract direct linking
//-------------appeon End------------------------
is_sql += ls_sql
end event

event ue_search_tab_3();//////////////////////////////////////////////////////////////////////
// $<event> ue_search_tab_3
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Generate SQL syntax for search according to Serach In tab
// $<description> TAB 3 - Requirements
//////////////////////////////////////////////////////////////////////
// $<add> 11.02.2006 by Davis
//////////////////////////////////////////////////////////////////////

String ls_sql
String ls_select
//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, 'Requirements', "

ls_sql += ls_select + "'Requirements Name' from ctx_req_profile_hdr "+&
		"where exists(select 1 from ctx_req_profile where ctx_req_profile_hdr.ctx_req_profile_id = ctx_req_profile.ctx_req_profile_id "+&
		"and contains(rqmnt_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Requirements Description' from ctx_req_profile_hdr "+&
		"where exists(select 1 from ctx_req_profile where ctx_req_profile_hdr.ctx_req_profile_id = ctx_req_profile.ctx_req_profile_id "+&
		"and contains(rqmnt_description, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Clause' from ctx_req_profile_hdr "+&
		"where exists(select 1 from ctx_elements where ctx_elements.ctx_req_profile_hdr_id = ctx_req_profile_hdr.ctx_req_profile_hdr_id "+&
		"and contains(clause, '" + is_searchtext + "'))" + is_contracts
*/

ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, 'Requirements' as c, "

ls_sql += ls_select + "'Requirements Name' as d from ctx_req_profile_hdr "+&
		"where exists(select 1 from ctx_req_profile where ctx_req_profile_hdr.ctx_req_profile_id = ctx_req_profile.ctx_req_profile_id "+&
		"and contains(rqmnt_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Requirements Description' as d from ctx_req_profile_hdr "+&
		"where exists(select 1 from ctx_req_profile where ctx_req_profile_hdr.ctx_req_profile_id = ctx_req_profile.ctx_req_profile_id "+&
		"and contains(rqmnt_description, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Clause' as d from ctx_req_profile_hdr "+&
		"where exists(select 1 from ctx_elements where ctx_elements.ctx_req_profile_hdr_id = ctx_req_profile_hdr.ctx_req_profile_hdr_id "+&
		"and contains(clause, '" + is_searchtext + "'))" + is_contracts
//---------End Modfiied ------------------------------------------------------		

is_sql += ls_sql
end event

event ue_search_tab_4();//////////////////////////////////////////////////////////////////////
// $<event> ue_search_tab_4
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Generate SQL syntax for search according to Serach In tab
// $<description> TAB 4 - Contacts
//////////////////////////////////////////////////////////////////////
// $<add> 11.02.2006 by Davis
//////////////////////////////////////////////////////////////////////

// case ctx_contract_contacts.ic_area
// 'C' -> contacts
// 'E' -> Contracted Company Contact Info
// 'I' -> Our Company Contact Info

String ls_sql
String ls_select
//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, "

//Modified By Ken.Guo 06/11/2012 Workaround  SQL Server Bug. Replace Or with Union
//ls_sql += ls_select + "case ctx_contract_contacts.ic_area when 'C' then 'Contacts' else 'Detail' end, case ctx_contract_contacts.ic_area "+&
//		"when 'E' then 'Contracted Company Contact -> ' when 'I' then 'Our Company Contact -> ' else '' end + "+&
//		"ctx_contacts.last_name + ' , ' + ctx_contacts.first_name "+&
//		"from ctx_contract_contacts, ctx_contacts "+&
//		"where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ("+&
//		"exists(select 1 from  CONTAINSTABLE(ctx_contacts, *, '" + is_searchtext + "') as KEY_TBL "+&
//		"where ctx_contract_contacts.contact_id = KEY_TBL.[KEY])"+&
//		"or exists(select 1 from ctx_contacts_numbers, CONTAINSTABLE(ctx_contacts_numbers, *, '" + is_searchtext + "') as KEY_TBL "+&
//		"where ctx_contacts_numbers.contact_id = ctx_contract_contacts.contact_id and ctx_contacts_numbers.contact_num_id = KEY_TBL.[KEY])"+&
//		"or contains(ctx_contract_contacts.notes, '" + is_searchtext + "'))"+ is_contracts

//-------------appeon begin----------------------
//<$>Modified:long.zhang 07.23.2013
//<$>reason:Bug 3606 search issue

//ls_sql += ls_select + &
//"case ctx_contract_contacts.ic_area when 'C' then 'Contacts' else 'Detail' end, " + &
//"case ctx_contract_contacts.ic_area when 'E' then 'Contracted Company Contact -> ' when 'I' then 'Our Company Contact -> ' else '' end  " + &
//"					+ ctx_contacts.last_name + ' , ' + ctx_contacts.first_name " + &
//"from ctx_contract_contacts, ctx_contacts " + &
//"where ctx_contract_contacts.contact_id = ctx_contacts.contact_id " + &
//"and " + &
//"( " + &
//"exists " + &
//"	( " + &
//"	(select 1 from  CONTAINSTABLE(ctx_contacts, *, '"+ is_searchtext +"') as KEY_TBL  " + &
//"	where ctx_contract_contacts.contact_id = KEY_TBL.[KEY])   " + &
//"      union " + &
//"	(select 1 from ctx_contacts_numbers, CONTAINSTABLE(ctx_contacts_numbers, *, '"+ is_searchtext +"') as KEY_TBL2 " + &
//"	where ctx_contacts_numbers.contact_id = ctx_contract_contacts.contact_id and ctx_contacts_numbers.contact_num_id = KEY_TBL2.[KEY]) " + &
//"      union  " + &
//"	(select 1 from ctx_contract_contacts a Where ctx_contract_contacts.contact_id = a.contact_id  and Contains(a.notes, '"+ is_searchtext +"') ) " + &
//"	) " + &
//") "  + is_contracts

ls_sql += ls_select + "case ctx_contract_contacts.ic_area when 'C' then 'Contacts' else 'Detail' end, case ctx_contract_contacts.ic_area "+&
		"when 'E' then 'Contracted Company Contact -> ' when 'I' then 'Our Company Contact -> ' else '' end + "+&
		"ctx_contacts.last_name + ' , ' + ctx_contacts.first_name "+&
		"from ctx_contract_contacts, ctx_contacts "+&
		"where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ("+&
		"(select count(1) from  CONTAINSTABLE(ctx_contacts, *, '" + is_searchtext + "') as KEY_TBL "+&
		"where ctx_contract_contacts.contact_id = KEY_TBL.[KEY])"+&
		"+(select count(1) from ctx_contacts_numbers, CONTAINSTABLE(ctx_contacts_numbers, *, '" + is_searchtext + "') as KEY_TBL "+&
		"where ctx_contacts_numbers.contact_id = ctx_contract_contacts.contact_id and ctx_contacts_numbers.contact_num_id = KEY_TBL.[KEY])"+&
		"+(select count(1) from CONTAINSTABLE(ctx_contract_contacts,notes, '" + is_searchtext + "') as KEY_TBL "+&
		"where ctx_contract_contacts.id_forcatalog = KEY_TBL.[KEY])" +&
		")>0"+ is_contracts

//-------------appeon End------------------------
*/
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, "

//Modified By Ken.Guo 06/11/2012 Workaround  SQL Server Bug. Replace Or with Union
//ls_sql += ls_select + "case ctx_contract_contacts.ic_area when 'C' then 'Contacts' else 'Detail' end, case ctx_contract_contacts.ic_area "+&
//		"when 'E' then 'Contracted Company Contact -> ' when 'I' then 'Our Company Contact -> ' else '' end + "+&
//		"ctx_contacts.last_name + ' , ' + ctx_contacts.first_name "+&
//		"from ctx_contract_contacts, ctx_contacts "+&
//		"where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ("+&
//		"exists(select 1 from  CONTAINSTABLE(ctx_contacts, *, '" + is_searchtext + "') as KEY_TBL "+&
//		"where ctx_contract_contacts.contact_id = KEY_TBL.[KEY])"+&
//		"or exists(select 1 from ctx_contacts_numbers, CONTAINSTABLE(ctx_contacts_numbers, *, '" + is_searchtext + "') as KEY_TBL "+&
//		"where ctx_contacts_numbers.contact_id = ctx_contract_contacts.contact_id and ctx_contacts_numbers.contact_num_id = KEY_TBL.[KEY])"+&
//		"or contains(ctx_contract_contacts.notes, '" + is_searchtext + "'))"+ is_contracts

//-------------appeon begin----------------------
//<$>Modified:long.zhang 07.23.2013
//<$>reason:Bug 3606 search issue

//ls_sql += ls_select + &
//"case ctx_contract_contacts.ic_area when 'C' then 'Contacts' else 'Detail' end, " + &
//"case ctx_contract_contacts.ic_area when 'E' then 'Contracted Company Contact -> ' when 'I' then 'Our Company Contact -> ' else '' end  " + &
//"					+ ctx_contacts.last_name + ' , ' + ctx_contacts.first_name " + &
//"from ctx_contract_contacts, ctx_contacts " + &
//"where ctx_contract_contacts.contact_id = ctx_contacts.contact_id " + &
//"and " + &
//"( " + &
//"exists " + &
//"	( " + &
//"	(select 1 from  CONTAINSTABLE(ctx_contacts, *, '"+ is_searchtext +"') as KEY_TBL  " + &
//"	where ctx_contract_contacts.contact_id = KEY_TBL.[KEY])   " + &
//"      union " + &
//"	(select 1 from ctx_contacts_numbers, CONTAINSTABLE(ctx_contacts_numbers, *, '"+ is_searchtext +"') as KEY_TBL2 " + &
//"	where ctx_contacts_numbers.contact_id = ctx_contract_contacts.contact_id and ctx_contacts_numbers.contact_num_id = KEY_TBL2.[KEY]) " + &
//"      union  " + &
//"	(select 1 from ctx_contract_contacts a Where ctx_contract_contacts.contact_id = a.contact_id  and Contains(a.notes, '"+ is_searchtext +"') ) " + &
//"	) " + &
//") "  + is_contracts

ls_sql += ls_select + "case ctx_contract_contacts.ic_area when 'C' then 'Contacts' else 'Detail' end as c, case ctx_contract_contacts.ic_area "+&
		"when 'E' then 'Contracted Company Contact -> ' when 'I' then 'Our Company Contact -> ' else '' end + "+&
		"ctx_contacts.last_name + ' , ' + ctx_contacts.first_name "+&
		" as d from ctx_contract_contacts, ctx_contacts "+&
		"where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ("+&
		"(select count(1) from  CONTAINSTABLE(ctx_contacts, *, '" + is_searchtext + "') as KEY_TBL "+&
		"where ctx_contract_contacts.contact_id = KEY_TBL.[KEY])"+&
		"+(select count(1) from ctx_contacts_numbers, CONTAINSTABLE(ctx_contacts_numbers, *, '" + is_searchtext + "') as KEY_TBL "+&
		"where ctx_contacts_numbers.contact_id = ctx_contract_contacts.contact_id and ctx_contacts_numbers.contact_num_id = KEY_TBL.[KEY])"+&
		"+(select count(1) from CONTAINSTABLE(ctx_contract_contacts,notes, '" + is_searchtext + "') as KEY_TBL "+&
		"where ctx_contract_contacts.id_forcatalog = KEY_TBL.[KEY])" +&
		")>0"+ is_contracts

//-------------appeon End------------------------
//---------End Modfiied ------------------------------------------------------
is_sql += ls_sql
end event

event ue_search_tab_5();//////////////////////////////////////////////////////////////////////
// $<event> ue_search_tab_5
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Generate SQL syntax for search according to Serach In tab
// $<description> TAB 5 - Locations
//////////////////////////////////////////////////////////////////////
// $<add> 11.02.2006 by Davis
//////////////////////////////////////////////////////////////////////

String ls_sql
String ls_select
//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, 'Locations', "

ls_sql += ls_select + "'Parent Organization -> Group Name' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(gp_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Address' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and (contains(street1, '" + is_searchtext + "') or contains(street2, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> City' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(city, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> State' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(state, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> ZIP' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(zip, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Phone' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(phone, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Contact Name' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(contact_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Tax Id' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info1, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 1' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info2, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 2' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info3, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 3' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info4, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 4' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info5, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 5' from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info6, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> Street' from ctx_loc "+&
		"where exists(select 1 from group_practice where group_practice.rec_id = ctx_loc.loc_id "+&
		"and (contains(street, '" + is_searchtext + "') or contains(street_2, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> City' from ctx_loc "+&
		"where exists(select 1 from group_practice where group_practice.rec_id = ctx_loc.loc_id "+&
		"and contains(city, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> ZIP' from ctx_loc "+&
		"where exists(select 1 from group_practice where group_practice.rec_id = ctx_loc.loc_id "+&
		"and contains(zip, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> Tax Id' from ctx_loc "+&
		"where exists(select 1 from group_practice where group_practice.rec_id = ctx_loc.loc_id "+&
		"and contains(tax_id, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> Group Number' from ctx_loc "+&
		"where contains(group_number, '" + is_searchtext + "')" + is_contracts
		
ls_sql += ls_select + "'Group / Locations -> Custom 1' from ctx_loc "+&
		"where contains(custom_1, '" + is_searchtext + "')" + is_contracts
		
ls_sql += ls_select + "'Group / Locations -> Custom 2' from ctx_loc "+&
		"where contains(custom_2, '" + is_searchtext + "')" + is_contracts
*/
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, 'Locations' as c, "

ls_sql += ls_select + "'Parent Organization -> Group Name' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(gp_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Address' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and (contains(street1, '" + is_searchtext + "') or contains(street2, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> City' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(city, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> State' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(state, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> ZIP' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(zip, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Phone' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(phone, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Contact Name' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(contact_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Tax Id' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info1, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 1' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info2, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 2' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info3, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 3' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info4, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 4' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info5, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Parent Organization -> Custom 5' as d from ctx_loc "+&
		"where exists(select 1 from group_multi_loc where group_multi_loc.rec_id = ctx_loc.parent_comp_id "+&
		"and contains(info6, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> Street' as d from ctx_loc "+&
		"where exists(select 1 from group_practice where group_practice.rec_id = ctx_loc.loc_id "+&
		"and (contains(street, '" + is_searchtext + "') or contains(street_2, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> City' as d from ctx_loc "+&
		"where exists(select 1 from group_practice where group_practice.rec_id = ctx_loc.loc_id "+&
		"and contains(city, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> ZIP' as d from ctx_loc "+&
		"where exists(select 1 from group_practice where group_practice.rec_id = ctx_loc.loc_id "+&
		"and contains(zip, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> Tax Id' as d from ctx_loc "+&
		"where exists(select 1 from group_practice where group_practice.rec_id = ctx_loc.loc_id "+&
		"and contains(tax_id, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Group / Locations -> Group Number' as d from ctx_loc "+&
		"where contains(group_number, '" + is_searchtext + "')" + is_contracts
		
ls_sql += ls_select + "'Group / Locations -> Custom 1' as d from ctx_loc "+&
		"where contains(custom_1, '" + is_searchtext + "')" + is_contracts
		
ls_sql += ls_select + "'Group / Locations -> Custom 2' as d from ctx_loc "+&
		"where contains(custom_2, '" + is_searchtext + "')" + is_contracts
//---------End Modfiied ------------------------------------------------------

is_sql += ls_sql
end event

event ue_search_tab_6();//////////////////////////////////////////////////////////////////////
// $<event> ue_search_tab_6
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Generate SQL syntax for search according to Serach In tab
// $<description> TAB 6 - Organization
//////////////////////////////////////////////////////////////////////
// $<add> 11.02.2006 by Davis
//////////////////////////////////////////////////////////////////////

String ls_sql
String ls_select
//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, 'Organizations', "

ls_sql += ls_select + "'Address -> Organization Name' from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and contains(org_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Address -> Street' from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and (contains(street_1, '" + is_searchtext + "') or contains(street_2, '" + is_searchtext + "') or contains(street_3, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Address -> City' from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and contains(city, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Address -> ZIP' from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and contains(zip, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Address -> Directions' from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and contains(drections, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Notes' from ctx_orgs_contact "+&
		"where contains(notes, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Organization Contacts -> Contact Name' from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_org_contact where ctx_org_contact.org_id = ctx_orgs_contact.org_id "+&
		"and contains(contact_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Organization Contacts -> Department' from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_org_contact where ctx_org_contact.org_id = ctx_orgs_contact.org_id "+&
		"and contains(Department, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Organization Contacts -> Phone' from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_org_contact where ctx_org_contact.org_id = ctx_orgs_contact.org_id "+&
		"and contains(phone, '" + is_searchtext + "'))" + is_contracts
		
ls_sql += ls_select + "'Organization Contacts -> Contact Email' from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_org_contact where ctx_org_contact.org_id = ctx_orgs_contact.org_id "+&
		"and contains(org_cnt_email, '" + is_searchtext + "'))" + is_contracts
*/
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, 'Organizations' as c, "

ls_sql += ls_select + "'Address -> Organization Name' as d from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and contains(org_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Address -> Street' as d from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and (contains(street_1, '" + is_searchtext + "') or contains(street_2, '" + is_searchtext + "') or contains(street_3, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Address -> City' as d from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and contains(city, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Address -> ZIP' as d from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and contains(zip, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Address -> Directions' as d from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_orgs where ctx_orgs.org_id = ctx_orgs_contact.org_id "+&
		"and contains(drections, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Notes' as d from ctx_orgs_contact "+&
		"where contains(notes, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Organization Contacts -> Contact Name' as d from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_org_contact where ctx_org_contact.org_id = ctx_orgs_contact.org_id "+&
		"and contains(contact_name, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Organization Contacts -> Department' as d from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_org_contact where ctx_org_contact.org_id = ctx_orgs_contact.org_id "+&
		"and contains(Department, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Organization Contacts -> Phone' as d from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_org_contact where ctx_org_contact.org_id = ctx_orgs_contact.org_id "+&
		"and contains(phone, '" + is_searchtext + "'))" + is_contracts
		
ls_sql += ls_select + "'Organization Contacts -> Contact Email' as d from ctx_orgs_contact "+&
		"where exists(select 1 from ctx_org_contact where ctx_org_contact.org_id = ctx_orgs_contact.org_id "+&
		"and contains(org_cnt_email, '" + is_searchtext + "'))" + is_contracts
//---------End Modfiied ------------------------------------------------------

is_sql += ls_sql
end event

event ue_search_tab_7();//////////////////////////////////////////////////////////////////////
// $<event> ue_search_tab_7
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Generate SQL syntax for search according to Serach In tab
// $<description> TAB 7 - Fee Schedule
//////////////////////////////////////////////////////////////////////
// $<add> 11.02.2006 by Davis
//////////////////////////////////////////////////////////////////////

String ls_sql
String ls_select
//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, 'Fee Schedule', "

ls_sql += ls_select + "'Fee Schedules -> Custom 1' from ctx_fee_sched_hdr "+&
		"where contains(custom_1, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Fee Schedules -> Custom 2' from ctx_fee_sched_hdr "+&
		"where contains(custom_2, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Fees -> Custom 1' from ctx_fee_sched_hdr "+&
		"where exists(select 1 from ctx_fee_sched_locations where ctx_fee_sched_locations.fee_sched_id = ctx_fee_sched_hdr.fee_sched_id "+&
		"and exists(select 1 from ctx_fee_sched_data where ctx_fee_sched_data.fee_sched_location_id = ctx_fee_sched_locations.fee_sched_location_id "+&
		"and contains(custom_1, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Fees -> Custom 2' from ctx_fee_sched_hdr "+&
		"where exists(select 1 from ctx_fee_sched_locations where ctx_fee_sched_locations.fee_sched_id = ctx_fee_sched_hdr.fee_sched_id "+&
		"and exists(select 1 from ctx_fee_sched_data where ctx_fee_sched_data.fee_sched_location_id = ctx_fee_sched_locations.fee_sched_location_id "+&
		"and contains(custom_2, '" + is_searchtext + "')))" + is_contracts
*/
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, 'Fee Schedule' as c, "

ls_sql += ls_select + "'Fee Schedules -> Custom 1' as d from ctx_fee_sched_hdr "+&
		"where contains(custom_1, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Fee Schedules -> Custom 2' as d from ctx_fee_sched_hdr "+&
		"where contains(custom_2, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Fees -> Custom 1' as d from ctx_fee_sched_hdr "+&
		"where exists(select 1 from ctx_fee_sched_locations where ctx_fee_sched_locations.fee_sched_id = ctx_fee_sched_hdr.fee_sched_id "+&
		"and exists(select 1 from ctx_fee_sched_data where ctx_fee_sched_data.fee_sched_location_id = ctx_fee_sched_locations.fee_sched_location_id "+&
		"and contains(custom_1, '" + is_searchtext + "')))" + is_contracts

ls_sql += ls_select + "'Fees -> Custom 2' as d from ctx_fee_sched_hdr "+&
		"where exists(select 1 from ctx_fee_sched_locations where ctx_fee_sched_locations.fee_sched_id = ctx_fee_sched_hdr.fee_sched_id "+&
		"and exists(select 1 from ctx_fee_sched_data where ctx_fee_sched_data.fee_sched_location_id = ctx_fee_sched_locations.fee_sched_location_id "+&
		"and contains(custom_2, '" + is_searchtext + "')))" + is_contracts
//---------End Modfiied ------------------------------------------------------

is_sql += ls_sql
end event

event ue_search_tab_8();//////////////////////////////////////////////////////////////////////
// $<event> ue_search_tab_8
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Generate SQL syntax for search according to Serach In tab
// $<description> TAB 8 - Action Items
//////////////////////////////////////////////////////////////////////
// $<add> 11.02.2006 by Davis
//////////////////////////////////////////////////////////////////////

String ls_sql
String ls_select
//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, 'Action Items', "

ls_sql += ls_select + "'Action User' from ctx_action_items "+&
		"where contains(action_user, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Notes' from ctx_action_items "+&
		"where contains(notes, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Action Type' from ctx_action_items "+&
		"where exists(select 1 from code_lookup where ctx_action_items.action_type = code_lookup.lookup_code "+&
		"and contains(*, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Action Status' from ctx_action_items "+&
		"where exists(select 1 from code_lookup where ctx_action_items.action_status = code_lookup.lookup_code "+&
		"and contains(*, '" + is_searchtext + "'))" + is_contracts
*/
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, 'Action Items' as c, "

ls_sql += ls_select + "'Action User' as d from ctx_action_items "+&
		"where contains(action_user, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Notes' as d from ctx_action_items "+&
		"where contains(notes, '" + is_searchtext + "')" + is_contracts

ls_sql += ls_select + "'Action Type' as d from ctx_action_items "+&
		"where exists(select 1 from code_lookup where ctx_action_items.action_type = code_lookup.lookup_code "+&
		"and contains(*, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Action Status' as d from ctx_action_items "+&
		"where exists(select 1 from code_lookup where ctx_action_items.action_status = code_lookup.lookup_code "+&
		"and contains(*, '" + is_searchtext + "'))" + is_contracts
//---------End Modfiied ------------------------------------------------------
		
is_sql += ls_sql
end event

event ue_criteria_contract();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.10.2006 By: Davis
//$<reason> IF user have not access rights to specific tab then that element will be grayed an disabled.

String ls_criteria_contract
ls_criteria_contract = dw_term.getitemstring(1, "criteria_contract" )

IF ls_criteria_contract = "2" THEN
	IF iw_contract.tab_contract_details.tabpage_images.visible THEN
		dw_term.Modify("searchin_1.Color = 33554432")
		dw_term.Modify("searchin_1.Protect = 0")
	ELSE
		dw_term.Modify("searchin_1.Color = 268435456")
		dw_term.Modify("searchin_1.Protect = 1")
		dw_term.Setitem(1, "searchin_1", "0")
	END IF

	IF iw_contract.tab_contract_details.tabpage_details.visible THEN
		dw_term.Modify("searchin_2.Color = 33554432")
		dw_term.Modify("searchin_2.Protect = 0")
	ELSE
		dw_term.Modify("searchin_2.Color = 268435456")
		dw_term.Modify("searchin_2.Protect = 1")
		dw_term.Setitem(1, "searchin_2", "0")
	END IF

	IF iw_contract.tab_contract_details.tabpage_requirements.visible THEN
		dw_term.Modify("searchin_3.Color = 33554432")
		dw_term.Modify("searchin_3.Protect = 0")
	ELSE
		dw_term.Modify("searchin_3.Color = 268435456")
		dw_term.Modify("searchin_3.Protect = 1")
		dw_term.Setitem(1, "searchin_3", "0")
	END IF

	IF iw_contract.tab_contract_details.tabpage_contacts.visible THEN
		dw_term.Modify("searchin_4.Color = 33554432")
		dw_term.Modify("searchin_4.Protect = 0")
	ELSE
		dw_term.Modify("searchin_4.Color = 268435456")
		dw_term.Modify("searchin_4.Protect = 1")
		dw_term.Setitem(1, "searchin_4", "0")
	END IF

	IF iw_contract.tab_contract_details.tabpage_locations.visible THEN
		dw_term.Modify("searchin_5.Color = 33554432")
		dw_term.Modify("searchin_5.Protect = 0")
	ELSE
		dw_term.Modify("searchin_5.Color = 268435456")
		dw_term.Modify("searchin_5.Protect = 1")
		dw_term.Setitem(1, "searchin_5", "0")
	END IF

	IF iw_contract.tab_contract_details.tabpage_orgabizations.visible THEN
		dw_term.Modify("searchin_6.Color = 33554432")
		dw_term.Modify("searchin_6.Protect = 0")
	ELSE
		dw_term.Modify("searchin_6.Color = 268435456")
		dw_term.Modify("searchin_6.Protect = 1")
		dw_term.Setitem(1, "searchin_6", "0")
	END IF

	IF iw_contract.tab_contract_details.tabpage_fee_schedules.visible THEN
		dw_term.Modify("searchin_7.Color = 33554432")
		dw_term.Modify("searchin_7.Protect = 0")
	ELSE
		dw_term.Modify("searchin_7.Color = 268435456")
		dw_term.Modify("searchin_7.Protect = 1")
		dw_term.Setitem(1, "searchin_7", "0")
	END IF

	IF iw_contract.tab_contract_details.tabpage_action_items.visible THEN
		dw_term.Modify("searchin_8.Color = 33554432")
		dw_term.Modify("searchin_8.Protect = 0")
	ELSE
		dw_term.Modify("searchin_8.Color = 268435456")
		dw_term.Modify("searchin_8.Protect = 1")
		dw_term.Setitem(1, "searchin_8", "0")
	END IF
	
	IF iw_contract.tab_contract_details.tabpage_fee_sched2.visible THEN
		dw_term.Modify("searchin_9.Color = 33554432")
		dw_term.Modify("searchin_9.Protect = 0")
	ELSE
		dw_term.Modify("searchin_9.Color = 268435456")
		dw_term.Modify("searchin_9.Protect = 1")
		dw_term.Setitem(1, "searchin_9", "0")
	END IF	
ELSE
	dw_term.Modify("searchin_1.Color = 33554432")
	dw_term.Modify("searchin_2.Color = 33554432")
	dw_term.Modify("searchin_3.Color = 33554432")
	dw_term.Modify("searchin_4.Color = 33554432")
	dw_term.Modify("searchin_5.Color = 33554432")
	dw_term.Modify("searchin_6.Color = 33554432")
	dw_term.Modify("searchin_7.Color = 33554432")
	dw_term.Modify("searchin_8.Color = 33554432")
	dw_term.Modify("searchin_9.Color = 33554432")

	dw_term.Modify("searchin_1.Protect = 0")
	dw_term.Modify("searchin_2.Protect = 0")
	dw_term.Modify("searchin_3.Protect = 0")
	dw_term.Modify("searchin_4.Protect = 0")
	dw_term.Modify("searchin_5.Protect = 0")
	dw_term.Modify("searchin_6.Protect = 0")
	dw_term.Modify("searchin_7.Protect = 0")
	dw_term.Modify("searchin_8.Protect = 0")
	dw_term.Modify("searchin_9.Protect = 0")
END IF

//---------------------------- APPEON END ----------------------------

end event

event ue_auto_search();//////////////////////////////////////////////////////////////////////
// $<event>w_contract_globalsearch::ue_auto_search()
// $<arguments>(None)
// $<returns> 
// $<description> Auto-Search, for Dashboard.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-05 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If istr_global_search.as_search_content <> '' Then
	dw_term.SetItem(1,'searchtext',istr_global_search.as_search_content) 
	dw_term.AcceptText()
	This.SetRedraw(True)
	If This.windowstate = Minimized! Then
		This.windowstate = Normal!
	End If
	dw_term.Post Event Buttonclicked(1,0,dw_term.object.b_search)
End If
end event

event ue_search_tab_9();//////////////////////////////////////////////////////////////////////
// $<event> ue_search_tab_9
// $<returns> 
// $<description> Generate SQL syntax for Fee Schedule(NM) tab
// $<description> TAB 9 -Fee Schedule(NM) tab
//////////////////////////////////////////////////////////////////////
// $Added By Ken.Guo 2010-06-03.
//////////////////////////////////////////////////////////////////////

String ls_sql
String ls_select
//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, 'Fee Schedule (NM)', "

ls_sql += ls_select + "'Description' from ctx_fee_sched_nm "+&
		"where contains(description, '" + is_searchtext + "')" + is_contracts
ls_sql += ls_select + "'Category' from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where category = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Service Item' from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where service_item = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Status' from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where item_status = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Service Name' from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where service_name = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Custom 1' from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n1 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Custom 2' from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n2 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Custom 3' from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n3 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Custom 4' from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n4 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Custom 5' from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n5 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Custom Text 1' from ctx_fee_sched_nm "+&
		"where (contains(custom_text1, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text1 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 2' from ctx_fee_sched_nm "+&
		"where (contains(custom_text2, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text2 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 3' from ctx_fee_sched_nm "+&
		"where (contains(custom_text3, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text3 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 4' from ctx_fee_sched_nm "+&
		"where (contains(custom_text4, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text4 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 5' from ctx_fee_sched_nm "+&
		"where (contains(custom_text5, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text5 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 6' from ctx_fee_sched_nm "+&
		"where (contains(custom_text6, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text6 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 7' from ctx_fee_sched_nm "+&
		"where (contains(custom_text7, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text7 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 8' from ctx_fee_sched_nm "+&
		"where (contains(custom_text8, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text8 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
*/
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, 'Fee Schedule (NM)' as c, "

ls_sql += ls_select + "'Description' as d from ctx_fee_sched_nm "+&
		"where contains(description, '" + is_searchtext + "')" + is_contracts
ls_sql += ls_select + "'Category' as d from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where category = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Service Item' as d from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where service_item = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Status' as d from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where item_status = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Service Name' as d from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where service_name = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Custom 1' as d from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n1 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Custom 2' as d from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n2 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Custom 3' as d from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n3 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Custom 4' as d from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n4 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts
ls_sql += ls_select + "'Custom 5' as d from ctx_fee_sched_nm "+&
		"where exists(select 1 from code_lookup where custom_n5 = lookup_code and contains(code, '" + is_searchtext + "'))" + is_contracts

ls_sql += ls_select + "'Custom Text 1' as d from ctx_fee_sched_nm "+&
		"where (contains(custom_text1, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text1 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 2' as d from ctx_fee_sched_nm "+&
		"where (contains(custom_text2, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text2 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 3' as d from ctx_fee_sched_nm "+&
		"where (contains(custom_text3, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text3 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 4' as d from ctx_fee_sched_nm "+&
		"where (contains(custom_text4, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text4 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 5' as d from ctx_fee_sched_nm "+&
		"where (contains(custom_text5, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text5 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 6' as d from ctx_fee_sched_nm "+&
		"where (contains(custom_text6, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text6 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 7' as d from ctx_fee_sched_nm "+&
		"where (contains(custom_text7, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text7 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts
ls_sql += ls_select + "'Custom Text 8' as d from ctx_fee_sched_nm "+&
		"where (contains(custom_text8, '" + is_searchtext + "') Or Exists(select 1 from code_lookup where convert(varchar(100),code_lookup.lookup_code) = ctx_fee_sched_nm.custom_text8 and contains(code_lookup.code, '" + is_searchtext + "')))" + is_contracts

//---------End Modfiied ------------------------------------------------------

is_sql += ls_sql
end event

event ue_search_tab_10();//====================================================================
// Event: ue_search_tab_10
//--------------------------------------------------------------------
// Description: Search For Custom Multi
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 05/29/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_sql
String ls_select

//---------Begin Modified by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
/*
//For Header
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id, dbo.fn_ctx(ctx_id), 0, 'Custom Multi', "
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 1' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_1 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_1, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 2' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_2 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_2, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 3' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_3 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_3, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 4' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_4 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_4, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 5' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_5 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_5, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 6' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_6 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_6, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 7' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_7 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_7, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 8' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_8 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_8, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 9' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_9 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_9, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 10' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_10 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_10, '"+is_searchtext+"') )" + is_contracts

ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom Notes_1' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_notes_1 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_notes_1, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom Notes_2' from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_notes_2 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_notes_2, '"+is_searchtext+"') )" + is_contracts

//For Detail
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 1' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_1 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_1, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 2' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_2 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_2, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 3' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_3 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_3, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 4' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_4 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_4, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 5' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_5 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_5, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 6' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_6 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_6, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 7' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_7 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_7, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 8' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_8 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_8, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 9' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_9 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_9, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 10' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_10 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_10, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom Notes_1' from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_notes_1 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_notes_1, '"+is_searchtext+"') )" + is_contracts
*/

//For Header
ls_select = "~r~n union Select " + is_resultsnum + "ctx_id as ctx_id, dbo.fn_ctx(ctx_id) as a, 0 as b, 'Custom Multi' as c, "
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 1' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_1 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_1, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 2' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_2 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_2, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 3' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_3 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_3, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 4' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_4 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_4, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 5' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_5 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_5, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 6' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_6 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_6, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 7' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_7 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_7, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 8' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_8 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_8, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 9' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_9 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_9, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom 10' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_10 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_10, '"+is_searchtext+"') )" + is_contracts

ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom Notes_1' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_notes_1 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_notes_1, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Header ('+convert(varchar(100),ctx_custom_multi_hdr.hdr_id)+') -> Custom Notes_2' as d from ctx_custom_multi_hdr "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_hdr.custom_notes_2 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_hdr.custom_notes_2, '"+is_searchtext+"') )" + is_contracts

//For Detail
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 1' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_1 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_1, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 2' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_2 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_2, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 3' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_3 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_3, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 4' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_4 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_4, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 5' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_5 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_5, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 6' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_6 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_6, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 7' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_7 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_7, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 8' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_8 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_8, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 9' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_9 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_9, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom 10' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_10 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_10, '"+is_searchtext+"') )" + is_contracts
ls_sql += ls_select + "'Detail ('+ convert(varchar(100),ctx_custom_multi_detail.hdr_id) +','+convert(varchar(100),ctx_custom_multi_detail.detail_id) +') -> Custom Notes_1' as d from ctx_custom_multi_detail "+&
		"where exists(select 1 from code_lookup where ctx_custom_multi_detail.custom_notes_1 = convert(varchar(100),code_lookup.lookup_code) and contains(code_lookup.code, '" + is_searchtext + "') or contains(ctx_custom_multi_detail.custom_notes_1, '"+is_searchtext+"') )" + is_contracts
//---------End Modfiied ------------------------------------------------------
is_sql += ls_sql

Return

end event

public function integer of_start_search ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.31.2006 By: Davis
//$<reason> Implement new Requirement.
String ls_searchtext
Long ll_resultsnum,ll_ret
String ls_criteria_results
String ls_criteria_contract
String ls_checked
string ls_contract_array
//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
//Integer i
long i	//long.zhang 04.19.2013 ArrayBound exceed error
//---------End Modfiied ------------------------------------------------------
n_cst_string  lnv_string

SetPointer( HourGlass! )

// Team initialization
IF dw_term.Rowcount() = 0 THEN RETURN 0
dw_term.Accepttext( )
ls_searchtext = Trim(dw_term.GetItemString(1, "searchtext"	))
IF Isnull(ls_searchtext) OR LEN(TRIM(ls_searchtext)) = 0 THEN
	Messagebox(Title,"Required value missing for Search.  Please enter a value.")
	RETURN 0
END IF

if len(ls_searchtext) <= 1 then
	MessageBox("Information","There must be at least two query characters. Single character cannot be searched.")
	return 0
end if

ll_resultsnum = dw_term.GetItemNumber(1, "resultsnum"	)
ls_criteria_results = dw_term.GetItemString(1, "criteria_results"	)
ls_criteria_contract = dw_term.GetItemString(1, "criteria_contract"	)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.11.2007 By: Machongmin
//$<reason> Fix a defect.
il_resultsnum = 0
il_count = 0
//---------------------------- APPEON END ----------------------------
// Number of Results to display
IF ll_resultsnum > 0 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.11.2007 By: Machongmin
	//$<reason> Fix a defect.
	/*
		is_resultsnum = ' TOP ' + String(ll_resultsnum) + ' '
	*/
	il_resultsnum = ll_resultsnum
	//---------------------------- APPEON END ----------------------------

END IF


//Added By Ken.Guo 2011-03-28. ignore double quotation marks.
If Pos(ls_searchtext,'"') > 0 Then
	Messagebox('Search','The double quotation mark (") is not supported, the system will ignore it.')
	ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, '"', '') 
End If

// Correct search text error
//ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, " and ", " ") //Commented By Ken.Guo 2011-03-28
//ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, " or ", " ")  //Commented By Ken.Guo 2011-03-28
ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, "'", "''")			//Added by wuzhijun on 2007-05-22

DO WHILE POS(ls_searchtext,"  ") > 0
	ls_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, "  ", " ")
LOOP

//<add> 08/21/2007 by: Andy
Long    ll_Pos,ll_start = 1,ll_pos2
String  ls_Temp
boolean lb_flag = false

ls_searchtext = ls_searchtext + " "
DO WHILE (1=1)
	ll_Pos = Pos(ls_searchtext," ",ll_start)
	if ll_Pos < 1 then exit
	
	ls_Temp = Mid(ls_searchtext,ll_start,ll_Pos - ll_start)
	if Len(ls_Temp) < 2 then 
		lb_flag = true; exit
	end if
	
	ll_pos2 = Pos(ls_Temp,"*")
	//--------Begin Modified by Alfee 03.25.2008 ------
	//if ll_pos2 > 0 then
	if ll_pos2 > 0 or Pos(ls_Temp,",") > 0 then 
	//--------End Modified ----------------------------	
		ls_searchtext = Replace ( ls_searchtext, ll_start, Len(ls_Temp), '"' + ls_Temp + '"' )
		ll_start = ll_Pos + 3
	else
		ll_start = ll_Pos + 1
	end if
	
LOOP

if lb_flag then
	MessageBox("Information","Each searched word must contain at least two characters.")
	return 0
end if
ls_searchtext = Left(ls_searchtext,len(ls_searchtext) - 1)
//end of add

// Search Criteria - Word Match
Choose Case ls_criteria_results
	Case '1'	//	With all of the words
		// Use ' and ' instead of ALL ' '.
		is_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, ' ', '" and "')
	Case '2'	//	With the Exact Phrase
		//<Modify> 08/21/2007 by: Andy
		//is_searchtext = '~~"' + ls_searchtext + '~~"'		
		is_searchtext = ls_searchtext //replace NEAR with Exact
		//is_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, ' ', '" NEAR "')
		//end of Modify
	Case '3'	//	With at least of the words
		is_searchtext = lnv_string.of_GlobalReplace(ls_searchtext, ' ', '" or "')
End Choose

is_searchtext = '"' + is_searchtext + '"' //Added By Ken.Guo 2011-03-28.

// Search Criteria - Contract Match
Choose Case ls_criteria_contract
	Case '1'	//	Search All Contracts
		is_contracts  = ""
		//is_contracts = " and (ctx_id in (" + is_contract_array + ")) "
	Case '2'	//	Just in selected Contracts
		//is_contracts = " and (ctx_id = " + String( il_ctx_id ) + ") " // Delete by Evan 01.31.2008
		is_contracts = " and (ctx_id = " + String(of_get_ctx_id()) + ") " // Add by Evan 01.31.2008
	Case '3'	//Added By Ken.Guo 09/28/2012. Support Search Just in Search Browse Contracts 
		//Use Filter() to do it.
End Choose

SetPointer( HourGlass! )// add by gavins 20120202

// Generate SQL syntax for search according to Serach In tab
is_sql = ""
//---------Begin Added by (Appeon)Harry 02.24.2014 for Bug # 3867 -3--------
string ls_sql1, ls_sql2
String ls_sql_temp
if ls_criteria_contract = '1' and not ib_ctx_retrieve then
	ls_sql_temp = of_get_ctx_whereclause()
end if
//---------End Added ------------------------------------------------------
FOR i = 1 TO ii_tabcount
	ls_checked = dw_term.GetItemString(1, "searchin_" + String( i ) )
	IF ls_checked = "1" THEN
		This.TriggerEvent("ue_search_tab_" + String( i ) )
	END IF
	//---------Begin Added by (Appeon)Harry 02.24.2014 for Bug # 3867 -3--------
	if ls_criteria_contract = '1'  and not ib_ctx_retrieve then
		if i = 5 and  LEN( is_sql ) > 0 then
			ls_sql1 = is_sql
			//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
			//Begin - Added By Mark Lee 07/12/12 specialty charactor bug
			If Pos(ls_sql1,'""') > 0 Then
				ls_sql1 = lnv_string.of_GlobalReplace(ls_sql1, '""', '"')			
			End If
			//---------End Added ------------------------------------------------------
			ls_sql1 = Mid(ls_sql1, 10)  
			ls_sql1 = lnv_string.of_GlobalReplace(ls_sql1, "~"", "~~~"")
			//ls_sql1 = "Select t.ctx_id, t.a, t.b, t.c, t.d from ( " + ls_sql1 + ") t where t.ctx_id in (select distinct x.ctx_id from ( " + ls_sql_temp + ") x)"
			ls_sql1 = "Select t.ctx_id, t.a, t.b, t.c, t.d from ( " + ls_sql1 + ") t , ( " + ls_sql_temp + ") x where t.ctx_id = x.ctx_id"
			is_sql = ""
		end if
	end if
	//---------End Added ------------------------------------------------------
END FOR

//---------Begin Added by (Appeon)Harry 02.24.2014 for Bug # 3867 -3--------
if ls_criteria_contract = '1'  and not ib_ctx_retrieve then 
	if LEN( is_sql ) > 0 then
		ls_sql2 = is_sql
		//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
		//Begin - Added By Mark Lee 07/12/12 specialty charactor bug
		If Pos(ls_sql2,'""') > 0 Then
			ls_sql2 = lnv_string.of_GlobalReplace(ls_sql2, '""', '"')			
		End If
		//---------End Added ------------------------------------------------------
		ls_sql2 = Mid(ls_sql2, 10)  
		ls_sql2 = lnv_string.of_GlobalReplace(ls_sql2, "~"", "~~~"")
		//ls_sql2 = "Select m.ctx_id, m.a, m.b, m.c, m.d from ( " + ls_sql2 + ") m where m.ctx_id in (select distinct n.ctx_id from ( " + ls_sql_temp + ") n)"
		ls_sql2 = "Select t.ctx_id, t.a, t.b, t.c, t.d from ( " + ls_sql2 + ") t , ( " + ls_sql_temp + ") x where t.ctx_id = x.ctx_id"
	end if
	is_sql = ""
	if len(ls_sql1) > 0 and len(ls_sql2) > 0 then
		is_sql = ls_sql1 + "~r~n Union ~r~n" + ls_sql2
	elseif len(ls_sql1) > 0 then
		is_sql = ls_sql1 
	elseif len(ls_sql2) > 0 then
		is_sql = ls_sql2
	else
		is_sql = ""
	end if
end if
//---------End Added ------------------------------------------------------

// None tab be selected
IF LEN( is_sql ) = 0 THEN
	//Messagebox(Title,"None of search in tab be select.")
	Messagebox(Title,"None of search in tab is selected.")
	dw_results.Reset()
	This.of_fill_treeview( )
	RETURN 0
END IF

//---------Begin Commented by (Appeon)Harry  02.21.2014 for Bug # 3867 -3--------
//is_sql = Mid(is_sql, 10)  
//is_sql = lnv_string.of_GlobalReplace(is_sql, "~"", "~~~"")							//Added by wuzhijun on 2007-05-22
if ls_criteria_contract = '1'  and not ib_ctx_retrieve then 
else
	//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
	//Begin - Added By Mark Lee 07/12/12 specialty charactor bug
	If Pos(is_sql,'""') > 0 Then
		is_sql = lnv_string.of_GlobalReplace(is_sql, '""', '"')			
	End If
	//End - Added By Mark Lee 07/12/12
	//---------End Added ------------------------------------------------------
	is_sql = Mid(is_sql, 10)  
	is_sql = lnv_string.of_GlobalReplace(is_sql, "~"", "~~~"")							//Added by wuzhijun on 2007-05-22
end if
//---------End Commented ------------------------------------------------------

dw_results.Modify('datawindow.table.select = "' + is_sql + '"')

// Search begin
This.Setredraw( False )

//Added By Ken.Guo 09/28/2012. Support Search Just in Search Browse Contracts 
Long ll_contract_array[]
If ls_criteria_contract = '3' Then
	IF Isvalid(gw_contract) THEN
		If gw_contract.tab_contract_details.tabpage_search.dw_search_det1.RowCount()	> 0 Then
			If gw_contract.tab_contract_details.tabpage_search.dw_search_det1.RowCount() > 20000 Then  //Added By Ken.Guo 04/10/2013. for Web. IE will crash if the filter Conditions is too long.
				dw_results.SetFilter(" ctx_id > 0 ")
			Else
				ll_contract_array = gw_contract.tab_contract_details.tabpage_search.dw_search_det1.Object.ctx_id[1,gw_contract.tab_contract_details.tabpage_search.dw_search_det1.RowCount()] 	
				for i = 1 to upperbound(ll_contract_array)
					ls_contract_array = ls_contract_array + string(ll_contract_array[i]) + ","
				next
				ls_contract_array = left(ls_contract_array,len(ls_contract_array) - 1)
				if isnull(ls_contract_array) or ls_contract_array = '' then ls_contract_array = '0'
				dw_results.SetFilter("ctx_id in (" + ls_contract_array + ")")			
			End If
		End If
	End If
	ll_ret = dw_results.Retrieve( ) //(Appeon)Harry 02.24.2014 - for Bug # 3867 -3
//---------Begin Added by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
ElseIf ls_criteria_contract = '1' and not ib_ctx_retrieve Then
	dw_results.Retrieve( )
//---------End Added ------------------------------------------------------
Else
	//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
//	If UpperBound(il_contract_array) > 20000 Then //Added By Ken.Guo 04/10/2013. for Web. IE will crash if the filter Conditions is too long.
//		dw_results.SetFilter(" ctx_id > 0 ")
//	Else
//		//Start Code 11-22-2007 By Jervis
//		//Filter contract that the user has access to
//		for i = 1 to upperbound(il_contract_array)
//			ls_contract_array = ls_contract_array + string(il_contract_array[i]) + ","
//		next
//		ls_contract_array = left(ls_contract_array,len(ls_contract_array) - 1)
//		if isnull(ls_contract_array) or ls_contract_array = '' then ls_contract_array = '0'
//		dw_results.SetFilter("ctx_id in (" + ls_contract_array + ")")
//		//End Code 11-22-2007	
//	End If
	if  upperbound(il_contract_array) <= 20000 then	//added if condition by long.zhang appeon 04.19.2013 IE creashed when ls_contract_array was too long
		//Start Code 11-22-2007 By Jervis
		//Filter contract that the user has access to
		for i = 1 to upperbound(il_contract_array)
			ls_contract_array = ls_contract_array + string(il_contract_array[i]) + ","
		next
		ls_contract_array = LeftA(ls_contract_array,LenA(ls_contract_array) - 1)
		if isnull(ls_contract_array) or ls_contract_array = '' then ls_contract_array = '0'
		dw_results.SetFilter("ctx_id in (" + ls_contract_array + ")")
		dw_results.Retrieve( )
		//End Code 11-22-2007
	else
		dw_results.Retrieve( )
		if of_filter_results() = -1 then
			 ls_contract_array = '0'
			dw_results.SetFilter("ctx_id in (" + ls_contract_array + ")")
			dw_results.filter( )
		end if
	end if
	//---------End Modfiied ------------------------------------------------------
End If



//ll_ret = dw_results.Retrieve( )  //Commented by (Appeon)Harry 02.24.2014 - for Bug # 3867

This.of_fill_treeview( )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.11.2007 By: Machongmin
//$<reason> Fix a defect.
/*
st_1.text = "Search Results (" + String(dw_results.Rowcount()) + ")"
*/
st_1.text = "Search Results (" + String(il_count) + ")"
//---------------------------- APPEON END ----------------------------
This.Setredraw( True )

//Added By Ken.Guo 2011-03-28.
If ll_ret >= 0 and il_count = 0 Then
	Messagebox('Search','The search item was not found.')
End If

Return 1

//---------------------------- APPEON END ----------------------------

end function

public function integer of_fill_treeview ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.31.2006 By: Davis
//$<reason> Implement new Requirement.

Long ll_row
Long  ll_lev1, ll_lev2
TreeviewItem ltv_item
Long ll_ctx_id, ll_ctx_id_previous
String ls_tabname, ls_colname, ls_title

SetPointer( HourGlass! )// add by gavins 20120202

// Delete all items in the TreeView.
DO UNTIL tv_results.FindItem(RootTreeItem!, 0) = -1
    tv_results.DeleteItem( 0 )
LOOP
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.11.2007 By: Machongmin
//$<reason> Fix a defect.
/*
// Fill the treeview with results of datawindow.
FOR ll_row = 1 TO dw_results.Rowcount()
*/

long ll_rowcount

ll_rowcount = dw_results.Rowcount()
if il_resultsnum > 0 and il_resultsnum < ll_rowcount then
	ll_rowcount = il_resultsnum
end if

il_count = ll_rowcount

FOR ll_row = 1 TO ll_rowcount
//---------------------------- APPEON END ----------------------------	
	ll_ctx_id = dw_results.GetitemNumber(ll_row, "ctx_id")
	ls_title = dw_results.GetitemString(ll_row, "title")
	ls_tabname = dw_results.GetitemString(ll_row, "tabname")
	ls_colname = dw_results.GetitemString(ll_row, "colname")
	
	IF Isnull(ll_ctx_id) THEN Continue
	IF Isnull(ls_title) THEN ls_title = ""
	IF Isnull(ls_tabname) THEN ls_tabname = ""
	IF Isnull(ls_colname) THEN ls_colname = ""

	IF ll_ctx_id <> ll_ctx_id_previous THEN
		ll_ctx_id_previous = ll_ctx_id

		ltv_item.label = String(ll_ctx_id,"(#)  ") + ls_title
		ltv_item.data = ll_row
		ll_lev1 = tv_results.InsertItemLast(0, ltv_item)
	END IF
	
	ltv_item.label = ls_tabname + ' -> ' + ls_colname
	ltv_item.data = ll_row
	ll_lev2 = tv_results.InsertItemLast(ll_lev1, ltv_item)
END FOR

// Get the treeview item that was the current selection.
ll_lev1 = tv_results.FindItem(RootTreeItem!, 0)
IF ll_lev1 > 0 THEN tv_results.ExpandItem( ll_lev1 )


Return 1

//---------------------------- APPEON END ----------------------------

end function

public function long of_get_ctx_id ();long ll_ctx_id

if IsValid(iw_contract) then
	ll_ctx_id = iw_contract.tab_contract_details.tabpage_search.INV_contract_details.of_get_ctx_id()
	if IsNull(ll_ctx_id) then ll_ctx_id = 0
end if

Return ll_ctx_id
end function

public function integer of_filter_results ();// (Appeon)Harry 06.28.2013 - V141 ISG-CLX
//$<add> 04.19.2013 By:long.zhang
//$<reason>crash IE when setfilter parameter was too long
//this function called from of_start_search()
//$ return type Integer

long ll_row
long ll_find_row
long ll_ctx_id

if  UpperBound(il_contract_array[]) = 0 then return -1

if in_filter.rowcount( ) = 0 and UpperBound(il_contract_array[]) > 0 then
	in_filter.object.ctx_id.current = il_contract_array
	in_filter.setSort("#1 A")
	in_filter.sort()
end if
	
for ll_row = 1 to dw_results.rowcount( )
	ll_ctx_id = dw_results.getitemnumber( ll_row,'ctx_id')
	ll_find_row = in_filter.find('ctx_id='+String(ll_ctx_id),1, in_filter.rowcount())
	
	if ll_find_row  = 0 then	//No access Rights
		//	dw_results.deleterow( ll_row)
		if dw_results.rowsdiscard(ll_row,ll_row,primary!) = 1 then//long.zhang 04.22.2013
			ll_row -= 1
		end if
	end if
end for
	
return 1

end function

public function integer of_set_contractarray (long al_contract[]);// (Appeon)Harry 06.28.2013 - V141 ISG-CLX
//$<add> 04.19.2013 By:long.zhang
//$<reason>crash IE when setfilter parameter was too long
//this function called from u_tabpg_contract_search.of_retrieve()
//$ return type Integer

il_contract_array[] = al_contract[]
if UpperBound(il_contract_array) > 0 then
	in_filter.object.ctx_id.current = il_contract_array
	in_filter.setSort("#1 A")
	in_filter.sort()
else
	in_filter.reset( )
end if

return 1
end function

public function integer of_checked ();//---------Begin Added by (Appeon)Harry 02.13.2014 for Bug # 3867--------
String ls_criteria_contract
if dw_term.rowcount( ) < 1 then return 0
ls_criteria_contract = dw_term.GetItemString(1, "criteria_contract")
if ls_criteria_contract = '1' then
	//---------Begin Commented by (Appeon)Harry  02.21.2014 for Bug # 3867 -3--------
	/*
	if isValid(iw_contract) then
		if UpperBound(il_contract_array) = 0 then
			iw_contract.tab_contract_details.tabpage_search.CB_1.event clicked()	
		end if	
	end if	
	*/
	if UpperBound(il_contract_array) > 0 then 
		ib_ctx_retrieve = true
	end if
	//---------End Commented ------------------------------------------------------
else
	if isValid(iw_contract) then
		if iw_contract.tab_contract_details.tabpage_search.dw_search_det1.rowcount( ) <= 0 then
			messagebox('IntelliContract','Please filter the Intellicontract records you want to query.')
			return 0
		end if
	end if
end if

return 1
//---------End Added ------------------------------------------------------
end function

public function string of_get_ctx_whereclause ();//(Appeon)Harry 02.21.2014 - for Bug # 3867 -3
String ls_syntax
ls_syntax = ''
if gb_IsDocMode then
	//the where clause comes from d_user_ctx_search
	ls_syntax += " select distinct ctx_basic_info.ctx_id "
	ls_syntax += " FROM  ctx_basic_info  "
	ls_syntax += " LEFT OUTER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id  "
	ls_syntax += " LEFT OUTER JOIN code_lookup ON ctx_products.product_id = code_lookup.lookup_code  "
	ls_syntax += " LEFT OUTER JOIN code_lookup code_lookup1 ON ctx_products.product_type = code_lookup1.lookup_code "
	ls_syntax += " LEFT OUTER JOIN ctx_custom ON ctx_basic_info.ctx_id = ctx_custom.ctx_id  "
	ls_syntax += " LEFT OUTER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id "
	ls_syntax += "  LEFT OUTER JOIN ( select count(1) has_docs, ctx_id from  ctx_am_document group by ctx_id ) ctx_am_documents ON ctx_basic_info.ctx_id = ctx_am_documents.ctx_id, ( "
	ls_syntax += " SELECT DISTINCT TOP 100 Percent  ctx_id = ctx_contract_contacts.ctx_id, user_id = ctx_contacts.user_d, access = (CASE ctx_contract_contacts.owner WHEN 'Y' THEN 'F' ELSE ctx_contract_contacts.access END) "
	ls_syntax += " FROM ctx_contract_contacts Left Outer Join ( "
	ls_syntax += " Select ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d "
	ls_syntax += " From ctx_contract_contacts ctx_contract_contacts1 ,ctx_contacts ctx_contacts1 "
	ls_syntax += " Where ctx_contract_contacts1.contact_id = ctx_contacts1.contact_id And ctx_contacts1.user_d = '"  + Upper(gs_user_id) + "' "
	ls_syntax += " Group By ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d "
	ls_syntax += " Having Count(ctx_contract_contacts1.ctx_id) > 1) ccc "
	ls_syntax += " On ctx_contract_contacts.ctx_id = ccc.ctx_id "
	ls_syntax += " ,ctx_contacts "
	ls_syntax += " WHERE ctx_contacts.user_d = '"  + Upper(gs_user_id) + "' "
	ls_syntax += " 	AND (ccc.ctx_id is null or ctx_contract_contacts.access = 'F' ) "
	ls_syntax += " 	AND ctx_contract_contacts.contact_id = ctx_contacts.contact_id "
	ls_syntax += " 	AND ( ctx_contract_contacts.access IN ('F','R') "
	ls_syntax += " 	OR ctx_contract_contacts.owner = 'Y' ) "
	ls_syntax += " 	AND ctx_contract_contacts.ic_area = 'I' "
	ls_syntax += " UNION "
	ls_syntax += " SELECT DISTINCT TOP 100 Percent ctx_id = ctx_group_access.ctx_id,user_id = security_group_users.user_id, access =  ctx_group_access.access "
	ls_syntax += " FROM "
	ls_syntax += " ctx_group_access , "
	ls_syntax += " security_group_users, "
	ls_syntax += " icred_settings "
	ls_syntax += " WHERE	security_group_users.user_id = '"  + Upper(gs_user_id) + "' "
	ls_syntax += " 	AND ctx_group_access.group_id = security_group_users.group_id "
	ls_syntax += " 	AND ctx_group_access.access = "
	ls_syntax += " 		(Case When Exists (Select u1.user_id,a1.ctx_id,a1.access "
	ls_syntax += " 		From ctx_group_access a1,security_group_users u1 "
	ls_syntax += " 		Where a1.group_id = u1.group_id "
	ls_syntax += " 		And a1.ctx_id = ctx_group_access.ctx_id "
	ls_syntax += " 		And u1.user_id = security_group_users.user_id	"
	ls_syntax += " 		And a1.access = 'F') Then 'F' Else 'R' End) "
	ls_syntax += " 	AND icred_settings.group_access = 1 "
	ls_syntax += " 	AND ctx_group_access.access in ('F','R') "
	ls_syntax += " 	AND NOT EXISTS	(SELECT 1 FROM ctx_contract_contacts, ctx_contacts  "
	ls_syntax += " 			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) "
	ls_syntax += " 			AND ( ctx_contacts.user_d = security_group_users.user_id ) "
	ls_syntax += " 			AND ( ctx_contract_contacts.ic_area = 'I' ) "
	ls_syntax += " 			AND ( ctx_contract_contacts.ctx_id = ctx_group_access.ctx_id )			) "
	ls_syntax += " UNION "
	ls_syntax += " SELECT DISTINCT TOP 100 Percent ctx_id = ctx_basic_info.ctx_id, user_id = security_users.user_id, access = (CASE ctx_acp_contract_management_right.rights WHEN '11' THEN 'F' WHEN '12' THEN 'R' ELSE 'N' END) "
	ls_syntax += " FROM ctx_acp_contract_management_right, security_users, ctx_basic_info "
	ls_syntax += " WHERE security_users.user_id = '"  + Upper(gs_user_id) + "' "
	ls_syntax += " 	AND ctx_acp_contract_management_right.types = 1 "
	ls_syntax += " 	AND ctx_acp_contract_management_right.role_id = security_users.role_id "
	ls_syntax += " 	AND ctx_acp_contract_management_right.category = ctx_basic_info.category "
	ls_syntax += " 	AND ctx_acp_contract_management_right.rights In ('11','12') "
	ls_syntax += " 	AND NOT EXISTS (SELECT 1 FROM ctx_contract_contacts, ctx_contacts  "
	ls_syntax += " 			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) "
	ls_syntax += " 			AND ( ctx_contacts.user_d = security_users.user_id AND ctx_contract_contacts.ic_area = 'I') "
	ls_syntax += " 			AND ( ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) "
	ls_syntax += " 			UNION "
	ls_syntax += " 			SELECT 1 FROM ctx_group_access,security_group_users,icred_settings "
	ls_syntax += " 			WHERE icred_settings.group_access = 1 "
	ls_syntax += " 			AND (ctx_group_access.group_id = security_group_users.group_id ) "
	ls_syntax += " 			AND ( security_group_users.user_id = security_users.user_id )	 "
	ls_syntax += " 			AND ( ctx_group_access.ctx_id = ctx_basic_info.ctx_id )		)	) AA "
	ls_syntax += " WHERE ctx_basic_info.ctx_id = AA.ctx_id AND ctx_basic_info.ctx_id = '"  + Upper(gs_user_id) + "' "
	ls_syntax += " and ctx_basic_info.is_template = 0 "
	
else
	//the where clause comes from PROCEDURE [dbo].[sp_contract_search]
	ls_syntax += "	select distinct ctx_basic_info.ctx_id "
	ls_syntax += " FROM  ctx_basic_info   "
	ls_syntax += " LEFT OUTER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id   "
	ls_syntax += " LEFT OUTER JOIN code_lookup ON ctx_products.product_id = code_lookup.lookup_code  " 
	ls_syntax += " LEFT OUTER JOIN code_lookup code_lookup1 ON ctx_products.product_type = code_lookup1.lookup_code "
	ls_syntax += " LEFT OUTER JOIN code_lookup code_lookup2 ON ctx_basic_info.status = code_lookup2.lookup_code "
	ls_syntax += " LEFT OUTER JOIN code_lookup code_lookup3 ON ctx_basic_info.category = code_lookup3.lookup_code "
	ls_syntax += " LEFT OUTER JOIN code_lookup code_lookup4 ON ctx_basic_info.contract_type = code_lookup4.lookup_code "
	ls_syntax += " LEFT OUTER JOIN code_lookup code_lookup5 ON ctx_basic_info.dvision = code_lookup5.lookup_code "
	ls_syntax += " LEFT OUTER JOIN ctx_custom ON ctx_basic_info.ctx_id = ctx_custom.ctx_id   "
	ls_syntax += " LEFT OUTER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id  "
	ls_syntax += " LEFT OUTER JOIN ( select count(1) has_docs, ctx_id from  ctx_am_document group by ctx_id ) ctx_am_documents ON ctx_basic_info.ctx_id = ctx_am_documents.ctx_id,   "
	ls_syntax += " ( 	 SELECT DISTINCT TOP 100 Percent  ctx_id = ctx_contract_contacts.ctx_id, user_id = ctx_contacts.user_d, access = (CASE ctx_contract_contacts.owner WHEN 'Y' THEN 'F' ELSE ctx_contract_contacts.access END) "
	ls_syntax += " FROM ctx_contract_contacts Left Outer Join ( "
	ls_syntax += " Select ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d  "
	ls_syntax += " From ctx_contract_contacts ctx_contract_contacts1 ,ctx_contacts ctx_contacts1 "
	ls_syntax += " Where ctx_contract_contacts1.contact_id = ctx_contacts1.contact_id And ctx_contacts1.user_d = '"  + Upper(gs_user_id) + "' "
	ls_syntax += " Group By ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d "
	ls_syntax += " Having Count(ctx_contract_contacts1.ctx_id) > 1  ) ccc "
	ls_syntax += " On ctx_contract_contacts.ctx_id = ccc.ctx_id "
	ls_syntax += "  ,ctx_contacts "
	ls_syntax += "  WHERE ctx_contacts.user_d = '"  + Upper(gs_user_id) + "' "
	ls_syntax += "	AND (ccc.ctx_id is null or ctx_contract_contacts.access = 'F' ) "
	ls_syntax += "	AND ctx_contract_contacts.contact_id = ctx_contacts.contact_id  "
	ls_syntax += "	AND ( ctx_contract_contacts.access IN ('F','R')  "
	ls_syntax += "	OR ctx_contract_contacts.owner = 'Y' ) "
	ls_syntax += "	AND ctx_contract_contacts.ic_area = 'I' "
	ls_syntax += " UNION  "
	ls_syntax += " SELECT DISTINCT TOP 100 Percent ctx_id = ctx_group_access.ctx_id,user_id = security_group_users.user_id, access =  ctx_group_access.access "
	ls_syntax += " FROM  "
	ls_syntax += " ctx_group_access , "
	ls_syntax += " security_group_users, "
	ls_syntax += " icred_settings "
	ls_syntax += " WHERE	security_group_users.user_id = '"  + Upper(gs_user_id) + "' "
	ls_syntax += "	AND ctx_group_access.group_id = security_group_users.group_id "
	ls_syntax += "	AND ctx_group_access.access =  "
	ls_syntax += "		(Case When Exists (Select u1.user_id,a1.ctx_id,a1.access  "
	ls_syntax += "		From ctx_group_access a1,security_group_users u1 "
	ls_syntax += "		Where a1.group_id = u1.group_id  "
	ls_syntax += "		And a1.ctx_id = ctx_group_access.ctx_id "
	ls_syntax += "		And u1.user_id = security_group_users.user_id	 "
	ls_syntax += "		And a1.access = 'F') Then 'F' Else 'R' End)  "
	ls_syntax += "	AND icred_settings.group_access = 1 "
	ls_syntax += "	AND ctx_group_access.access in ('F','R') "
	ls_syntax += "	AND NOT EXISTS	(SELECT 1 FROM ctx_contract_contacts, ctx_contacts   "
	ls_syntax += "			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id )  "
	ls_syntax += "			AND ( ctx_contacts.user_d = security_group_users.user_id ) "
	ls_syntax += "			AND ( ctx_contract_contacts.ic_area = 'I' ) "
	ls_syntax += "			AND ( ctx_contract_contacts.ctx_id = ctx_group_access.ctx_id ) ) "
	ls_syntax += " UNION "
	ls_syntax += " SELECT DISTINCT TOP 100 Percent ctx_id = ctx_basic_info.ctx_id, user_id = security_users.user_id, access = (CASE ctx_acp_contract_management_right.rights WHEN '11' THEN 'F' WHEN '12' THEN 'R' ELSE 'N' END) "
	ls_syntax += " FROM ctx_acp_contract_management_right, security_users, ctx_basic_info "
	ls_syntax += " WHERE security_users.user_id = '"  + Upper(gs_user_id) + "' "
	ls_syntax += "	AND ctx_acp_contract_management_right.types = 1 "
	ls_syntax += "	AND ctx_acp_contract_management_right.role_id = security_users.role_id "
	ls_syntax += "	AND ctx_acp_contract_management_right.category = ctx_basic_info.category "
	ls_syntax += "	And ctx_basic_info.is_template = 0  "
	ls_syntax += "	AND ctx_acp_contract_management_right.rights In ('11','12') "
	ls_syntax += "	AND NOT EXISTS (SELECT 1 FROM ctx_contract_contacts, ctx_contacts   "
	ls_syntax += "			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id )  "
	ls_syntax += "			AND ( ctx_contacts.user_d = security_users.user_id AND ctx_contract_contacts.ic_area = 'I')  "
	ls_syntax += "			AND ( ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id )  "
	ls_syntax += "			UNION "
	ls_syntax += "			SELECT 1 FROM ctx_group_access,security_group_users,icred_settings "
	ls_syntax += "			WHERE icred_settings.group_access = 1 "
	ls_syntax += "			AND (ctx_group_access.group_id = security_group_users.group_id ) "
	ls_syntax += "			AND ( security_group_users.user_id = security_users.user_id )	 "
	ls_syntax += "			AND ( ctx_group_access.ctx_id = ctx_basic_info.ctx_id ) )  ) AA  "
	 ls_syntax += "WHERE ctx_basic_info.ctx_id = AA.ctx_id and ctx_basic_info.is_template = 0  "
end if

return ls_syntax
end function

on w_contract_globalsearch.create
int iCurrent
call super::create
this.st_tip=create st_tip
this.cb_4=create cb_4
this.dw_results=create dw_results
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_select=create cb_select
this.tv_results=create tv_results
this.dw_term=create dw_term
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_tip
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.dw_results
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_select
this.Control[iCurrent+9]=this.tv_results
this.Control[iCurrent+10]=this.dw_term
end on

on w_contract_globalsearch.destroy
call super::destroy
destroy(this.st_tip)
destroy(this.cb_4)
destroy(this.dw_results)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_select)
destroy(this.tv_results)
destroy(this.dw_term)
end on

event open;call super::open;
//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
//-------------appeon begin------------
//<$>added:long.zhang 04.19.2013
//<$>reason:IE crashed when setfilter condition was too long Ticket # 00040627
in_filter = create n_ds //long.zhang 04.19.2013
in_filter.dataobject = 'd_contract_dw_4_filter'
//---------End Modfiied ------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.03.2006 By: Davis
//$<reason> Implement new requirement.

IF Isvalid(gw_contract) THEN
	iw_contract = gw_contract
	//Added By Alan on 2009-1-21
	//if iw_contract.tab_contract_details.tabpage_search.ib_retriev_detail then iw_contract.tab_contract_details.tabpage_search.CB_1.event clicked()	//Commented by (Appeon)Harry 02.13.2014 - for Bug # 3867

	// Get all contract array that the user has access to
	il_contract_array = iw_contract.tab_contract_details.tabpage_search.il_contract_array
	//is_contract_array = iw_contract.tab_contract_details.tabpage_search.is_contract_array
	//IF NOT f_validstr(is_contract_array) THEN is_contract_array = "0"
	
	// Get currently contract id
	//il_ctx_id = iw_contract.tab_contract_details.tabpage_search.INV_contract_details.of_get_ctx_id( ) // Delete by Evan 01.31.2008
	//IF Isnull(il_ctx_id) THEN il_ctx_id = 0 // Delete by Evan 01.31.2008
END IF

//---------------------------- APPEON END ----------------------------

//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
if UpperBound(il_contract_array) > 0 then
	in_filter.object.ctx_id.current = il_contract_array
	in_filter.setSort("#1 A")
	in_filter.sort()
end if
//---------End Modfiied ------------------------------------------------------
end event

event pfc_preopen;call super::pfc_preopen;//////////////////////////////////////////////////////////////////////
// $<event>w_contract_globalsearch::pfc_preopen()
// $<arguments>
//		None		
// $<returns> (None)
// $<description> Get PowerObjectParm, it from Dashboard.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-05 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If isvalid(Message.Powerobjectparm) Then
	istr_global_search = Message.Powerobjectparm
End If

end event

event pfc_postopen;call super::pfc_postopen;//---------Begin Commented by (Appeon)Harry 02.13.2014 for Bug # 3867---------
/*
//-------------appeon begin----------------------
//<$>added:long.zhang 08.01.2013
//<$>reason:need  to retrieve first from browse datawindow Bug3606
if isValid(iw_contract) then
	if iw_contract.tab_contract_details.tabpage_search.ib_retrieve = false and UpperBound(il_contract_array) = 0 then
		iw_contract.tab_contract_details.tabpage_search.CB_1.event clicked()	
	end if	
end if	
//-------------appeon End------------------------
*/
//---------End Commented ------------------------------------------------------

Post Event ue_auto_search() //Added by Ken.Guo 2008-08-04
end event

event close;call super::close;if isvalid(in_filter) then destroy in_filter//long.zhang 04.19.2013  //(Appeon)Harry 06.28.2013 - V141 ISG-CLX
end event

type st_tip from statictext within w_contract_globalsearch
integer x = 50
integer y = 2032
integer width = 750
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Search in process, please wait..."
boolean focusrectangle = false
end type

event constructor;visible = false
end event

type cb_4 from u_cb within w_contract_globalsearch
integer x = 1682
integer y = 2024
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "E&xport..."
end type

event clicked;call super::clicked;//Modify by jervis --06.30.2011
gf_load_dir_path() 
String ls_file,ls_null
Setnull(ls_null)
ls_file = ''
If dw_results.SaveAs(ls_file,Excel5!,True) = 1 Then
	If FileExists(ls_file) Then
		ShellExecuteA(Handle(This),'open',ls_file,ls_null,ls_null,4)
	End If
End If
gf_save_dir_path(' ') 
end event

type dw_results from u_dw within w_contract_globalsearch
boolean visible = false
integer x = 1266
integer y = 812
integer width = 1454
integer height = 1072
integer taborder = 20
string title = "none"
string dataobject = "d_globalsearch_results"
end type

event constructor;this.of_setupdateable( false)
This.SettransObject(Sqlca)

end event

event dberror;//-------------Appeon Begin -----by Derek at 03.09.2007---------
//// DEBUGER INFO

//IF handle(getapplication()) = 0 THEN
//	RETURN 0
//ELSE
//	RETURN 1
//END IF

string ls_message

ls_message = "The input query strings causes the database retrieval error. Please input the query strings again.~r~n" &
              + sqlerrtext

If Pos(sqlerrtext, 'not full-text') > 0 Then
	//Added By Ken.Guo 2011-01-14.
	If Messagebox('Search',"The Full-Text Catalog hasn't been created for the contracts yet, please create it at first then try the Global Search again. ~r~n~r~nDo you want to create the Full-Text Catalog now?", Question!, YesNo!) = 1 Then
		IF Not Isvalid(gnv_logservice) THEN gnv_logservice = Create n_logservice
		n_cst_update_sql_clx lnv_sql
		lnv_sql = Create n_cst_update_sql_clx  //(Appeon)Harry 06.28.2013 - V141 ISG-CLX
		lnv_sql.of_release_fulltext( )			
		Destroy lnv_sql
	End If
Else
	MessageBox ("Alert Message", ls_message, StopSign!, Ok!, 1)
End If

			
return -1
//-------------Appeon End -----------------------
end event

type st_1 from statictext within w_contract_globalsearch
integer x = 59
integer y = 944
integer width = 718
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Search Results"
boolean focusrectangle = false
end type

type cb_3 from u_cb within w_contract_globalsearch
integer x = 2405
integer y = 2024
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;call super::clicked;Close( Parent )
end event

type cb_2 from u_cb within w_contract_globalsearch
integer x = 2043
integer y = 2024
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.02.2006 By: Davis
//$<reason> Implement new requirement.

dwItemStatus l_status
Datawindowchild ldwc_child
String ls_searchtext
Long ll_row

dw_term.Accepttext( )
ls_searchtext = dw_term.GetItemString(1, "searchtext"	)
IF Isnull(ls_searchtext) OR LEN(TRIM(ls_searchtext)) = 0 THEN
	Messagebox(Parent.Title,"Required value missing for Search.  Please enter a value.")
	RETURN	
END IF

gnv_appeondb.of_startqueue( )

dw_term.Update()
Commit;

dw_term.GetChild("searchtext", ldwc_child)
ldwc_child.SettransObject(SQLCA)
ldwc_child.Retrieve()
gnv_appeondb.of_commitqueue( )

ll_row = ldwc_child.Insertrow( 1 )
ldwc_child.Setitem( ll_row, "searchtext", "(New Search)")

ll_row = ldwc_child.Insertrow( 1 )
ldwc_child.Setitem( ll_row, "searchtext", "(Clear)")

//--------------------------- APPEON BEGIN ---------------------------
end event

type cb_1 from u_cb within w_contract_globalsearch
integer x = 1216
integer y = 2024
integer width = 457
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Out&Put Options"
end type

event clicked;call super::clicked;//Modify by jervis --06.30.2011
m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(dw_results)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
NewMenu.m_options.PopMenu(Parent.pointerx(),Parent.pointerY())
end event

type cb_select from u_cb within w_contract_globalsearch
integer x = 855
integer y = 2024
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "S&elect"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.01.2006 By: Davis
//$<reason> Implement new requirement.

treeviewitem ltvi_item
Long ll_tvi
Long ll_row
Long ll_image_id
String ls_tabname
String ls_colname
Long ll_ctx_id
Long ll_findrow
Long ll_coly
long ll_Handle
Long ll_hdr_id, ll_detail_id
String ls_multi_id, ls_multi_col
CONSTANT long WM_SYSCOMMAND = 274
CONSTANT long SC_RESTORE    = 61728
String ls_doc_ext //Added By Ken.Guo 2009-11-06.

u_dw_contract ldw_data

PowerObject lpo_NullParm

// Get the treeview item that was the current selection.
ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
IF ll_tvi <=0 THEN RETURN

tv_results.GetItem(ll_tvi, ltvi_item)
IF ltvi_item.level <> 2 THEN RETURN

//--------------------------- APPEON BEGIN ---------------------------
//$<Modified> 2007-05-23 By: Wu ZhiJun
//$<reason> if haven't open contract folder, Open it.
IF Not Isvalid(iw_contract) THEN
	gf_OpenContractFolder(lpo_NullParm)
	Parent.Post event open( )
	cb_select.Post event clicked( )
	return
END IF
//--------------------------- APPEON END -----------------------------

//Start code by jervis 12.02.2008
//Restore window size when window state is minmized.
if isvalid(iw_contract) then
	if iw_contract.windowstate = Minimized!  then
		ll_Handle = Handle(iw_contract)
		SendMessage(ll_Handle, WM_SYSCOMMAND, SC_RESTORE, 0)
	end if
end if
//End code By Jervis 12.02.2008


ll_row = Long(ltvi_item.Data)
IF ll_row = 0 THEN RETURN

ls_tabname = Lower( dw_results.GetItemString( ll_row, "tabname") )
ls_colname = Lower( dw_results.GetItemString( ll_row, "colname") )
ll_ctx_id = dw_results.GetItemNumber( ll_row, "ctx_id")
IF Isnull(ll_ctx_id) OR ll_ctx_id = 0 THEN RETURN

// Get category
Long ll_category
String ls_company
SELECT category,(select top 1 facility_name from app_facility where app_facility.facility_id = ctx_basic_info.app_facility)
INTO :ll_category, :ls_company
FROM ctx_basic_info
WHERE ctx_id = :ll_ctx_id;

// Set tab visible
Integer li_view_id
li_view_id = integer(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(ll_category)))
If li_view_id <> gi_contract_view_id Then
	gi_contract_view_id = li_view_id
	iw_contract.function dynamic wf_tab_visible(li_view_id) 
	iw_contract.function dynamic wf_set_select('All',false) 
End If

// Juage access
Boolean lb_tab_visible
Choose Case lower(ls_tabname)
	Case "document manager"
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_images.visible
	Case "detail"
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_details.visible
	Case "requirements"
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_requirements.visible
	Case "contacts"
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_contacts.visible
	Case "locations"
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_locations.visible
	Case "organizations"
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_orgabizations.visible
	Case "fee schedule"
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_fee_schedules.visible
	Case "action items"
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_action_items.visible
	Case "fee schedule (nm)" //Added By Ken.Guo 2010-06-03.
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_fee_sched2.visible		
	Case "custom multi" //Added By Ken.Guo 05/29/2012
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_multi.visible
End Choose

IF NOT lb_tab_visible THEN
	Messagebox(Parent.title, "Access denied for contract " + ls_tabname + " tab.")
	iw_contract.tab_contract_details.Selecttab( 1 )
	Return
END IF

// reset the retived flag to false
iw_contract.function dynamic wf_reset_retrieved()
iw_contract.function dynamic of_select_details_tab_retrieved(false)
iw_contract.tab_contract_details.tabpage_search.inv_contract_details.is_mode = iw_contract.tab_contract_details.tabpage_search.inv_contract_details.edit
iw_contract.tab_contract_details.tabpage_images.inv_contract_details.of_set_ctx_id( ll_ctx_id )

//---------Begin Added by (Appeon)Harry 02.26.2014 Bug # 3909--------
Boolean lb_readonly_current = False
datastore lds_temp
u_tabpg_contract_search uo_temp
lds_temp = Create datastore
uo_temp = iw_contract.tab_contract_details.tabpage_search
lds_temp.dataobject = 'd_sp_contract_search_temp'
lds_temp.settransobject(sqlca)
lds_temp.retrieve(upper(gs_user_id), ll_ctx_id)
if lds_temp.rowcount( ) > 0 then
	if  lds_temp.GetItemString(1,'access') = 'F' Then
		lb_readonly_current = False
	else
		lb_readonly_current = True
	end if
	uo_temp.ib_readonly_current = lb_readonly_current
end if
if isvalid (lds_temp) then destroy lds_temp
//---------End Added ------------------------------------------------------
//---------Begin Added by (Appeon)Harry 02.21.2014 for Bug # 3867 -3--------
iw_contract.tab_contract_details.tabpage_search.inv_contract_details.of_set_tab_change( true)
iw_contract.Dynamic Function wf_set_tab_enabled(True)
//---------End Added ------------------------------------------------------

// Go to the appropriate tab, filed or document.
Choose Case lower(ls_tabname)
	Case "document manager"
		ll_image_id = dw_results.GetItemNumber( ll_row, "imageid" )
		iw_contract.tab_contract_details.Selecttab( 9 )

		IF ll_image_id > 0 THEN
			//Added By Mark Lee 05/21/2013
//			ll_findrow = iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Find( "doc_id = " + String(ll_image_id), 1, 1000)
			ll_findrow = iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Find( "doc_id = " + String(ll_image_id), & 
			1, iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.rowcount())
			IF ll_findrow > 0 THEN
			   iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.is_search_text = is_searchtext //Alfee 07.18.2008				
				iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.post scrolltorow( ll_findrow )
				iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.Post Selecttab( 2 )
				
				//Added By Ken.Guo 2009-11-06. locate page.
				ls_doc_ext = iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.GetItemString(ll_findrow,'doc_ext')
				Choose Case Upper(ls_doc_ext)
					Case 'TIF','TIFF','BMP','JPG','GIF'
						iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.uo_2.Post event ue_ocr_post_find(Trim(dw_term.GetItemString(1, "searchtext"	)))
					Case 'PDF'
						if gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '1' Then 
							iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.uo_2.Post event ue_ocr_post_find(Trim(dw_term.GetItemString(1, "searchtext"	)))
						End If
						
				End Choose
				
			END IF
		END IF
	Case "detail"
		iw_contract.tab_contract_details.Selecttab( 2 )

		Choose Case ls_colname
			Case Lower('File location')
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setfocus( )
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setcolumn( "file_location" )
			Case Lower('Category')
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setfocus( )
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setcolumn( "Category" )
			Case Lower('Notes')
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 05.05.2007 By: Jack
				//$<reason> Fix a defect.
				/*
				iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.Post SelectTab(1)
				*/
				iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.Post SelectTab(2)				
				//---------------------------- APPEON END ----------------------------
				iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_notes.dw_1.Post Setfocus( )
			Case Lower('Company Name')
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setfocus( )
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setcolumn( "app_facility" )
			Case Lower('Contract Type')
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setfocus( )
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setcolumn( "contract_type" )
			Case Lower('Division')
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setfocus( )
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setcolumn( "dvision" )
			Case Lower('Product Type')
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_products.Post Setfocus( )
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_products.Post Setcolumn( "product_type" )
			Case Lower('Product Name')
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_products.Post Setfocus( )
				iw_contract.tab_contract_details.tabpage_details.uo_1.dw_products.Post Setcolumn( "product_id" )
		End Choose

		IF Left(ls_colname, 24) = 'custom data 2 -> custom ' THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 05.05.2007 By: Jack
			//$<reason> Fix a defect.
			/*
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.Post SelectTab(2)
			*/
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.Post SelectTab(2)			
			//---------------------------- APPEON END ----------------------------
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.dw_1.Post Setfocus( )

			ls_colname = 'custom_' + mid(ls_colname, 25)

			ll_coly = Long(iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.dw_1.Describe(ls_colname + ".y" ))
			IF ll_coly > 200 THEN
				ll_coly = ll_coly - 200
				iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Modify("DataWindow.VerticalScrollPosition = " + String(ll_coly))
			END IF
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.dw_1.Post Setfocus( )
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.dw_1.Post Setcolumn( ls_colname )
		ElseIF Left(ls_colname, 7) = 'custom ' THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 05.05.2007 By: Jack
			//$<reason> Fix a defect.
			/*
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.Post SelectTab(2)
			*/
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.Post SelectTab(1)			
			//---------------------------- APPEON END ----------------------------
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Post Setfocus( )

			ls_colname = 'custom_' + mid(ls_colname, 8)

			ll_coly = Long(iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Describe(ls_colname + ".y" ))
			IF ll_coly > 200 THEN
				ll_coly = ll_coly - 200
				iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Modify("DataWindow.VerticalScrollPosition = " + String(ll_coly))
			END IF
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Post Setfocus( )
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Post Setcolumn( ls_colname )
		//ELSEIF Left(ls_colname, 16) = 'Linked Providers' THEN	//Added by Appeon long.zhang 04.22.2014 (v14.2 Provider-Contract direct linking)
		ELSEIF Left(ls_colname, 16) = 'linked providers' THEN	//Added by Appeon long.zhang 08.05.2014 (v14.2 BugH062401 'Linked Providers'=> 'linked providers' )
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.post SelectTab(6)
			iw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_linkprovider.dw_1.Post setfocus( )
		END IF		
		
		
	Case "requirements"
		iw_contract.tab_contract_details.Selecttab( 3 )
		
		Choose Case ls_colname
			Case Lower('Requirements Name'),Lower('Requirements Description')
				iw_contract.tab_contract_details.tabpage_requirements.dw_2.Setfocus( )
				iw_contract.tab_contract_details.tabpage_requirements.dw_2.Setcolumn( "rqmnt_name" )
			Case Lower('Clause')
				iw_contract.tab_contract_details.tabpage_requirements.dw_req_det.Setfocus( )
				iw_contract.tab_contract_details.tabpage_requirements.dw_req_det.Setcolumn( "Clause" )
		End Choose
	
	Case "contacts"
		iw_contract.tab_contract_details.Selecttab( 4 )

	Case "locations"
		iw_contract.tab_contract_details.Selecttab( 5 )

		Choose Case ls_colname
			Case Lower('Parent Organization -> Group Name')
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setcolumn( "gp_name" )
			Case Lower('Parent Organization -> Street')
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setcolumn( "Street1" )
			Case Lower('Parent Organization -> City')
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setcolumn( "city" )
			Case Lower('Parent Organization -> State')
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setcolumn( "State" )
			Case Lower('Parent Organization -> ZIP')
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_locations.dw_main.Setcolumn( "zip" )
			Case Lower('Phone')
			Case Lower('Group / Locations -> Tax Id')
				iw_contract.tab_contract_details.tabpage_locations.dw_detail.Setfocus( )
				iw_contract.tab_contract_details.tabpage_locations.dw_detail.Setcolumn( "tax_id" )
			Case Lower('Group / Locations -> Group Number')
				iw_contract.tab_contract_details.tabpage_locations.dw_detail.Setfocus( )
				iw_contract.tab_contract_details.tabpage_locations.dw_detail.Setcolumn( "group_number" )
			Case Lower('Group / Locations -> Custom 1')
				iw_contract.tab_contract_details.tabpage_locations.dw_detail.Setfocus( )
				iw_contract.tab_contract_details.tabpage_locations.dw_detail.Setcolumn( "custom_1" )
			Case Lower('Group / Locations -> Custom 2')
				iw_contract.tab_contract_details.tabpage_locations.dw_detail.Setfocus( )
				iw_contract.tab_contract_details.tabpage_locations.dw_detail.Setcolumn( "custom_2" )
		End Choose

	Case "organizations"
		iw_contract.tab_contract_details.Selecttab( 6 )
		
		Choose Case ls_colname
			Case Lower('Address -> Organization Name')
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setcolumn( "org_name" )
			Case Lower('Address -> Street')
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setcolumn( "street_1" )
			Case Lower('Address -> City')
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setcolumn( "city" )
			Case Lower('Address -> ZIP')
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setcolumn( "zip" )
			Case Lower('Address -> Directions')
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setcolumn( "drections" )
			Case Lower('Notes')
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_notes.Setfocus( )
			Case Lower('Organization Contacts -> Contact Name')
				//modified by Appeon long.zhang 08.08.2014 (v14.2 dw_main =>dw_contacts , BugL080801 of IntelliCred/App/Contract Issues of Integration)
				//iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setfocus( )
				//iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setcolumn( "contact_name" )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_contacts.Setfocus( )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_contacts.Setcolumn( "contact_name" )
			Case Lower('Organization Contacts -> Department')
				//modified by Appeon long.zhang 08.08.2014 (v14.2 dw_main =>dw_contacts , BugL080801 of IntelliCred/App/Contract Issues of Integration)
				//iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setfocus( )
				//iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setcolumn( "department" )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_contacts.Setfocus( )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_contacts.Setcolumn( "department" )
			Case Lower('Organization Contacts -> Phone')
				//modified by Appeon long.zhang 08.08.2014 (v14.2 dw_main =>dw_contacts , BugL080801 of IntelliCred/App/Contract Issues of Integration)
				//iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setfocus( )
				//iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setcolumn( "Phone" )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_contacts.Setfocus( )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_contacts.Setcolumn( "Phone" )
			Case Lower('Organization Contacts -> Contact Email')
				//modified by Appeon long.zhang 08.08.2014 (v14.2 dw_main =>dw_contacts , BugL080801 of IntelliCred/App/Contract Issues of Integration)
				//iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setfocus( )
				//iw_contract.tab_contract_details.tabpage_orgabizations.dw_main.Setcolumn( "org_cnt_email" )	
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_contacts.Setfocus( )
				iw_contract.tab_contract_details.tabpage_orgabizations.dw_contacts.Setcolumn( "org_cnt_email" )
		End Choose

	Case "fee schedule"
		iw_contract.tab_contract_details.Selecttab( 7 )

		Choose Case ls_colname
			Case Lower('Fee Schedules -> Custom 1')
				iw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_main.Setcolumn( "custom_1" )
			Case Lower('Fee Schedules -> Custom 2')
				iw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_main.Setfocus( )
				iw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_main.Setcolumn( "custom_2" )
			Case Lower('Fees -> Custom 1')
				iw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_fee_schedule.Setfocus( )
				iw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_fee_schedule.Setcolumn( "custom_1" )
			Case Lower('Fees -> Custom 2')
				iw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_fee_schedule.Setfocus( )
				iw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_fee_schedule.Setcolumn( "custom_2" )
		End Choose

	Case "action items"
		iw_contract.tab_contract_details.Selecttab( 10 )

		Choose Case ls_colname
			Case Lower('Action User')
				iw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.SetFocus()
				iw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.Setcolumn( "action_user" )
			Case Lower('Notes')
				iw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.SetFocus()
				iw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.Setcolumn( "notes" )
			Case Lower('Action Type')
				iw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.SetFocus()
				iw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.Setcolumn( "action_type" )
			Case Lower('Action Status')
				iw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.SetFocus()
				iw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.Setcolumn( "action_status" )
		End Choose
	Case "fee schedule (nm)"	//Added By Ken.Guo 2010-06-03.
		iw_contract.tab_contract_details.Selecttab( 8 )
	Case "custom multi"    //Added By Ken.Guo 05/29/2012 //column format:Header (1) or Detail (1,1) -> Custom 1
		iw_contract.tab_contract_details.Selecttab( 11 )
		//Get Field Name
		ls_multi_col = Trim(Mid (ls_colname, LastPos(ls_colname, '->') + 2 ))
		ls_multi_col = gnv_string.of_globalreplace( ls_multi_col,' ', '_')
		
		//Get Row ID
		If Pos(ls_colname, 'header (') > 0 Then
			ll_hdr_id = Long(Trim(Mid (ls_colname, Pos(ls_colname, '(') + 1, Pos(ls_colname, ')') - Pos(ls_colname, '(') - 1 )))
			If ll_hdr_id > 0 Then
				iw_contract.tab_contract_details.tabpage_multi.tab_multi.selecttab(1)
				ldw_data = iw_contract.tab_contract_details.tabpage_multi.tab_multi.tabpage_header.dw_header
				ll_findrow = ldw_data.Find('hdr_id = ' + String(ll_hdr_id),1,ldw_data.RowCount())
				If ll_findrow > 0 Then
					ldw_data.SetFocus()
					ldw_data.ScrollToRow(ll_findrow)
					ldw_data.SetRow(ll_findrow)
					If Len(ldw_data.describe(ls_multi_col + '.type')) > 1 Then
						ldw_data.SetColumn(ls_multi_col)
					End If
				End If
			End If
		ElseIf Pos(ls_colname, 'detail (') > 0 Then
			ls_multi_id = Trim(Mid (ls_colname, Pos(ls_colname, '(') + 1, Pos(ls_colname, ')') - Pos(ls_colname, '(') - 1 ))
			ll_hdr_id = Long(Left( ls_multi_id, Pos(ls_multi_id, ',') - 1 ))
			ll_detail_id = Long(Mid(ls_multi_id,  Pos(ls_multi_id, ',') + 1))
			//iw_contract.tab_contract_details.tabpage_multi.Post ue_locate_data( ll_hdr_id, ll_detail_id, ls_multi_col) //Commented by (Appeon)Harry 04.29.2014 - V142 ISG-CLX
			iw_contract.tab_contract_details.tabpage_multi.Post of_locate_data( ll_hdr_id, ll_detail_id, ls_multi_col) //(Appeon)Harry 04.29.2014 - V142 ISG-CLX
//			If ll_hdr_id > 0 Then
//				iw_contract.tab_contract_details.tabpage_multi.tab_multi.selecttab(2)
//				ldw_data = iw_contract.tab_contract_details.tabpage_multi.tab_multi.tabpage_detail.dw_browse
//				ll_findrow = ldw_data.Find('hdr_id = ' + String(ll_hdr_id),1,ldw_data.RowCount())
//				If ll_findrow > 0 Then
//					ldw_data.Post SetFocus()
//					ldw_data.ScrollToRow(ll_findrow)
//					ldw_data.SetRow(ll_findrow)
//					ldw_data = iw_contract.tab_contract_details.tabpage_multi.tab_multi.tabpage_detail.dw_detail
//					If ll_detail_id > 0 Then
//						ll_findrow = ldw_data.Find('detail_id = ' + String(ll_detail_id),1,ldw_data.RowCount())
//						If ll_findrow > 0 Then
//							ldw_data.Post SetFocus()
//							ldw_data.ScrollToRow(ll_findrow)
//							ldw_data.SetRow(ll_findrow)							
//							If Len(ldw_data.describe(ls_multi_col + '.type')) > 1 Then
//								ldw_data.SetColumn(ls_multi_col)
//							End If
//						End If
//					End If
//				End If
//			End If			
	
		End If
End Choose

// Set title
IF ls_tabname <> "detail" THEN
	IF f_validstr(ls_company) THEN ls_company = ' Company: ' + ls_company ELSE ls_company = ""
	iw_contract.title = 'IntelliContract ' + ls_company + '        Contract ID: ' + String(ll_ctx_id)
END IF

//---------------------------- APPEON END ----------------------------

end event

type tv_results from u_tv within w_contract_globalsearch
integer x = 50
integer y = 1008
integer width = 2702
integer height = 988
integer taborder = 30
boolean haslines = false
boolean linesatroot = true
end type

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.01.2006 By: Davis
//$<reason> Implement new requirement.

Cb_select.Postevent(Clicked!)

//---------------------------- APPEON END ----------------------------

end event

type dw_term from u_dw within w_contract_globalsearch
event ue_keydown pbm_dwnkey
integer x = 27
integer width = 2789
integer height = 928
integer taborder = 10
string title = "Search"
string dataobject = "d_globalsearch_term"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event ue_keydown;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.2.2006 By: Davis
//$<reason> Implement new requirement.
IF Keydown(Keyenter!) THEN
	IF getcolumnname() = "searchtext" THEN
		Parent.of_start_search( )
	END IF
END IF
//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.01.2006 By: Davis
//$<reason> Implement new requirement.
this.of_setupdateable( false)

Long ll_row

Datawindowchild ldwc_child
This.GetChild("searchtext", ldwc_child)
ldwc_child.SettransObject(SQLCA)
ldwc_child.Retrieve()

ll_row = ldwc_child.Insertrow( 1 )
ldwc_child.Setitem( ll_row, "searchtext", "(New Search)")

ll_row = ldwc_child.Insertrow( 1 )
ldwc_child.Setitem( ll_row, "searchtext", "(Clear)")

This.Settransobject( sqlca )
This.Insertrow( 0 )

//---------------------------- APPEON END ----------------------------

end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-05-18 By: Wu ZhiJun
//$<reason> Fix a bug
long		ll_Enabled
integer	li_Rtn
String 	ls_sql

IF dwo.name = 'b_search' THEN
	if of_checked() <> 1 then return //(Appeon)Harry 02.13.2014 -  for Bug # 3867
	
	SELECT DATABASEPROPERTY(db_name(),'IsFulltextEnabled') into :ll_Enabled from ids;
	
	if ll_Enabled = 0 then
		li_Rtn = Messagebox("Global Search", "Would you like to turn Full Text search ON?", Question!, YesNo!, 1)
		if li_Rtn = 1 then
//			ls_sql = "exec sp_fulltext_database 'enable'"
//			
//			EXECUTE IMMEDIATE :ls_sql using sqlca;
//			IF len(sqlca.sqlerrtext) > 0 THEN
//				IF handle(getapplication()) = 0 THEN
//					messagebox("Enable Full-Text", string(sqlca.sqlerrtext) )
//					return
//				END IF
//			ELSE
//				COMMIT;
//			END IF
         IF Not Isvalid(gnv_logservice) THEN gnv_logservice = Create n_logservice
	
         n_cst_update_sql lnv_sql
			lnv_sql = Create n_cst_update_sql

		   lnv_sql.of_enable_fulltext()
	      Destroy lnv_sql
			destroy gnv_logservice
		else
			return
		end if
	end if
	
	try
	    st_tip.Visible = true
		Parent.of_start_search( )
		//Added By mark 04/13/12 APB DO NOT SUPPORT FINALLY FUNCTION
		If appeongetclienttype() = 'WEB'  Then
			SetPointer( arrow! )
			st_tip.Visible = false
		End If			
	
	catch( exception e )
	finally
		SetPointer( arrow! )
		st_tip.Visible = false
	end try	
END IF
//--------------------------- APPEON END -----------------------------

end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.02.2006 By: Davis
//$<reason> Implement new requirement.

Datawindowchild dwchild
Long ll_found
Long ll_id
Long ll_row //04.24.2008

IF LEN(data) = 0 THEN RETURN

Choose Case Lower(dwo.name)
	Case "searchtext"
		IF Lower(data) = Lower("(New Search)") THEN
			This.Reset( )
			This.Insertrow( 0 )
			this.Post SetItem(1, "searchtext", "")	// Add bye Evan 01.31.2008
		ELSEIF Lower(data) = Lower("(Clear)") THEN
			IF Messagebox(Parent.title, "Are you sure you want to clear all search text?", Question!, OkCancel!, 1) = 1 THEN
				Delete From ctx_globalsearch_term;
				Commit;
				
				//---------Begin Added by Alfee on 04.24.2008-----------
				//<$Reason>Initilize the DDDW
				This.GetChild("searchtext", dwchild)
				dwchild.Reset()
				ll_row = dwchild.Insertrow( 0 )
				dwchild.Setitem( ll_row, "searchtext", "(Clear)")	
				ll_row = dwchild.Insertrow( 0 )
				dwchild.Setitem( ll_row, "searchtext", "(New Search)")
				//---------End Added -----------------------------------
				
				This.Reset()
				//This.event constructor( ) // Delete bye Evan 01.31.2008
				this.Insertrow(0) // Add bye Evan 01.31.2008
				this.Post SetItem(1, "searchtext", "")	// Add bye Evan 01.31.2008	
			ELSE
				//This.Setitem(1, "searchtext", "") // Delete bye Evan 01.31.2008
				this.Post SetItem(1, "searchtext", "") // Add bye Evan 01.31.2008
			END IF
		ELSE
			This.GetChild("searchtext", dwchild)
			ll_found = dwchild.Find("searchtext = '" + data + "'", 1, 1000)
			IF ll_found > 0 THEN
				ll_id = dwchild.GetItemNumber(ll_found, "id")
				IF ll_id > 0 THEN
					This.Retrieve( ll_id )
					IF This.RowCount() < 1 THEN This.InsertRow(0) //Alfee 04.24.2008
				END IF
			END IF
		END IF

		Parent.Postevent( "ue_criteria_contract")
	Case "criteria_contract"
		Parent.Postevent( "ue_criteria_contract")
End Choose

//--------------------------- APPEON BEGIN ---------------------------
end event

