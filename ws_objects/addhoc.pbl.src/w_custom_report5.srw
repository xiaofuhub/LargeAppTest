$PBExportHeader$w_custom_report5.srw
forward
global type w_custom_report5 from pfc_w_main
end type
type tab_1 from tab within w_custom_report5
end type
type tabpage_browse from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_browse
end type
type cb_select from commandbutton within tabpage_browse
end type
type dw_report_list from u_dw within tabpage_browse
end type
type cb_next_1 from commandbutton within tabpage_browse
end type
type cb_delete from commandbutton within tabpage_browse
end type
type dw_detail from datawindow within tabpage_browse
end type
type cb_new from commandbutton within tabpage_browse
end type
type cb_copy from commandbutton within tabpage_browse
end type
type cb_6 from commandbutton within tabpage_browse
end type
type cbx_goto from checkbox within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
cb_1 cb_1
cb_select cb_select
dw_report_list dw_report_list
cb_next_1 cb_next_1
cb_delete cb_delete
dw_detail dw_detail
cb_new cb_new
cb_copy cb_copy
cb_6 cb_6
cbx_goto cbx_goto
end type
type tabpage_tables from userobject within tab_1
end type
type dw_select_table from datawindow within tabpage_tables
end type
type dw_view_links from datawindow within tabpage_tables
end type
type cb_view_add_tbl from commandbutton within tabpage_tables
end type
type cb_view_del_tbl from commandbutton within tabpage_tables
end type
type cb_next_2 from commandbutton within tabpage_tables
end type
type cb_view_del_link from commandbutton within tabpage_tables
end type
type cb_view_add_link from commandbutton within tabpage_tables
end type
type cb_9 from commandbutton within tabpage_tables
end type
type cb_5 from commandbutton within tabpage_tables
end type
type cbx_distinct from checkbox within tabpage_tables
end type
type dw_view_tables from datawindow within tabpage_tables
end type
type tabpage_tables from userobject within tab_1
dw_select_table dw_select_table
dw_view_links dw_view_links
cb_view_add_tbl cb_view_add_tbl
cb_view_del_tbl cb_view_del_tbl
cb_next_2 cb_next_2
cb_view_del_link cb_view_del_link
cb_view_add_link cb_view_add_link
cb_9 cb_9
cb_5 cb_5
cbx_distinct cbx_distinct
dw_view_tables dw_view_tables
end type
type tabpage_columns from userobject within tab_1
end type
type dw_fields_list from datawindow within tabpage_columns
end type
type dw_view_fields from datawindow within tabpage_columns
end type
type dw_all_fields from datawindow within tabpage_columns
end type
type cb_next_3 from commandbutton within tabpage_columns
end type
type cb_10 from commandbutton within tabpage_columns
end type
type cb_11 from commandbutton within tabpage_columns
end type
type cb_33 from commandbutton within tabpage_columns
end type
type cb_34 from commandbutton within tabpage_columns
end type
type st_8 from statictext within tabpage_columns
end type
type tabpage_columns from userobject within tab_1
dw_fields_list dw_fields_list
dw_view_fields dw_view_fields
dw_all_fields dw_all_fields
cb_next_3 cb_next_3
cb_10 cb_10
cb_11 cb_11
cb_33 cb_33
cb_34 cb_34
st_8 st_8
end type
type tabpage_filter from userobject within tab_1
end type
type dw_view_where from datawindow within tabpage_filter
end type
type cb_12 from commandbutton within tabpage_filter
end type
type cb_16 from commandbutton within tabpage_filter
end type
type cb_3 from commandbutton within tabpage_filter
end type
type cb_next_4 from commandbutton within tabpage_filter
end type
type st_fil from statictext within tabpage_filter
end type
type tabpage_filter from userobject within tab_1
dw_view_where dw_view_where
cb_12 cb_12
cb_16 cb_16
cb_3 cb_3
cb_next_4 cb_next_4
st_fil st_fil
end type
type tabpage_sort from userobject within tab_1
end type
type cb_next_5 from commandbutton within tabpage_sort
end type
type dw_fields_list_sort from datawindow within tabpage_sort
end type
type dw_view_sort from u_dw within tabpage_sort
end type
type tabpage_sort from userobject within tab_1
cb_next_5 cb_next_5
dw_fields_list_sort dw_fields_list_sort
dw_view_sort dw_view_sort
end type
type tabpage_preview from userobject within tab_1
end type
type cb_quick_preview from commandbutton within tabpage_preview
end type
type st_obj_name from statictext within tabpage_preview
end type
type cb_14 from commandbutton within tabpage_preview
end type
type gb_1 from groupbox within tabpage_preview
end type
type gb_2 from groupbox within tabpage_preview
end type
type rb_p from radiobutton within tabpage_preview
end type
type rb_l from radiobutton within tabpage_preview
end type
type em_font from editmask within tabpage_preview
end type
type st_2 from statictext within tabpage_preview
end type
type st_left from statictext within tabpage_preview
end type
type st_5 from statictext within tabpage_preview
end type
type st_center from statictext within tabpage_preview
end type
type st_right from statictext within tabpage_preview
end type
type st_f_right from statictext within tabpage_preview
end type
type st_f_center from statictext within tabpage_preview
end type
type st_f_left from statictext within tabpage_preview
end type
type st_6 from statictext within tabpage_preview
end type
type dw_label from datawindow within tabpage_preview
end type
type st_4 from statictext within tabpage_preview
end type
type cbx_move_all from checkbox within tabpage_preview
end type
type cb_2 from commandbutton within tabpage_preview
end type
type st_7 from statictext within tabpage_preview
end type
type st_bold from statictext within tabpage_preview
end type
type st_italic from statictext within tabpage_preview
end type
type st_underline from statictext within tabpage_preview
end type
type st_normal from statictext within tabpage_preview
end type
type dw_preview from u_dw within tabpage_preview
end type
type st_9 from statictext within tabpage_preview
end type
type st_10 from statictext within tabpage_preview
end type
type st_11 from statictext within tabpage_preview
end type
type st_12 from statictext within tabpage_preview
end type
type tabpage_preview from userobject within tab_1
cb_quick_preview cb_quick_preview
st_obj_name st_obj_name
cb_14 cb_14
gb_1 gb_1
gb_2 gb_2
rb_p rb_p
rb_l rb_l
em_font em_font
st_2 st_2
st_left st_left
st_5 st_5
st_center st_center
st_right st_right
st_f_right st_f_right
st_f_center st_f_center
st_f_left st_f_left
st_6 st_6
dw_label dw_label
st_4 st_4
cbx_move_all cbx_move_all
cb_2 cb_2
st_7 st_7
st_bold st_bold
st_italic st_italic
st_underline st_underline
st_normal st_normal
dw_preview dw_preview
st_9 st_9
st_10 st_10
st_11 st_11
st_12 st_12
end type
type tabpage_run from userobject within tab_1
end type
type dw_run from u_dw within tabpage_run
end type
type cb_next_run from commandbutton within tabpage_run
end type
type cb_saveas from commandbutton within tabpage_run
end type
type cb_print from commandbutton within tabpage_run
end type
type cb_filter from commandbutton within tabpage_run
end type
type cb_sort from commandbutton within tabpage_run
end type
type cb_17 from commandbutton within tabpage_run
end type
type st_step from statictext within tabpage_run
end type
type dw_save_sql from datawindow within tabpage_run
end type
type cb_sql from commandbutton within tabpage_run
end type
type cb_13 from commandbutton within tabpage_run
end type
type st_sql from statictext within tabpage_run
end type
type dw_wizard from u_dw within tabpage_run
end type
type cb_4 from commandbutton within tabpage_run
end type
type tabpage_run from userobject within tab_1
dw_run dw_run
cb_next_run cb_next_run
cb_saveas cb_saveas
cb_print cb_print
cb_filter cb_filter
cb_sort cb_sort
cb_17 cb_17
st_step st_step
dw_save_sql dw_save_sql
cb_sql cb_sql
cb_13 cb_13
st_sql st_sql
dw_wizard dw_wizard
cb_4 cb_4
end type
type tab_1 from tab within w_custom_report5
tabpage_browse tabpage_browse
tabpage_tables tabpage_tables
tabpage_columns tabpage_columns
tabpage_filter tabpage_filter
tabpage_sort tabpage_sort
tabpage_preview tabpage_preview
tabpage_run tabpage_run
end type
type cb_15 from commandbutton within w_custom_report5
end type
type cb_8 from commandbutton within w_custom_report5
end type
type cb_qhelp from commandbutton within w_custom_report5
end type
type str_intellireport from structure within w_custom_report5
end type
type istr_intellireport from structure within w_custom_report5
end type
end forward

type str_intellireport from structure
	string		s_column_name[]
	string		s_label_name[]
	integer		i_return
end type

type istr_intellireport from structure
	string		s_column_name[]
	string		s_label_name[]
	integer		i_return
end type

global type w_custom_report5 from pfc_w_main
integer x = 14
integer y = 4
integer width = 3666
integer height = 2428
string title = "Custom Report Painter"
tab_1 tab_1
cb_15 cb_15
cb_8 cb_8
cb_qhelp cb_qhelp
end type
global w_custom_report5 w_custom_report5

type variables
Long il_ancor_x 
Long il_ancor_y
Long il_v_scroll_position
Integer ii_obj_select_cnt = 0
Integer ii_with_data = 0
Integer ii_total_where_values
Integer ii_current_wizard_step = 1
Integer ii_total_wizard_steps = 0
integer ii_facil_security
Integer ii_dept_security_on = 0
Integer ii_field_id[ ]

Long il_last_object_x[ ]
Long il_last_object_y[ ]
Long il_last_object_width[ ]
Long il_last_object_height[ ]

Boolean ib_resize_height
Boolean ib_resize_width
Boolean ib_control_down
Boolean ib_mouse_down
Boolean ib_multi_select

String is_option = "Move"
String is_last_border[ ]
String is_last_object_width
String is_last_object_height
String is_object_list[ ]
String is_last_object[ ]
String is_report_type = "List"
String is_drag_object
String is_object_type
String is_wizard_lookup_name[]
String is_wizard_lookup_type[]
String is_wizard_field_name[]
String is_sql_where
String is_wizard_compare_field[]
string is_facility_name
string is_mod_user
string is_sort_synt
string is_address_types
string is_net_dev_types
string is_appl_name

Boolean ib_group_report = True
Boolean ib_retrieving = False
Boolean ib_preview = False

Integer ii_project_id = 99

Integer ii_nr

Integer ii_col_count

Integer ii_tag

Long il_view_id

Long il_next_table_id
Long il_next_link_id
Long il_next_where_id

Long il_next_field_id  
Long il_next_sort_id

String is_filter

String is_obj_name

String is_label_name[]
String is_column_name[]

string is_user

Boolean ib_new
Boolean ib_preview_built
end variables

forward prototypes
public function integer of_save ()
public function string of_build_view_sql ()
public function integer of_help (string selected_tab, string option)
public function integer of_wizard_setup ()
public function integer of_next_wizard ()
public function integer of_clean_up ()
public function integer of_retrieve_report (long al_view)
public function integer of_retrieve_detail (long al_view)
public function integer of_preview_old (datawindow adw_preview)
public function integer of_preview (datawindow adw_preview, datawindow adw_rpt_hdr)
protected function integer of_get_next_ids ()
end prototypes

public function integer of_save ();Integer li_rc
Integer li_found
Integer i
Integer l
Integer ll_cnt
String ls_tbl_nm
String ls_fld_nm
String ls_table_nm
String ls_table_ids[]
String ls_field
String ls_field_v_scroll_position
String ls_table_v_scroll_position
DataWindowChild dwchild

SetRedraw( False )

ls_field_v_scroll_position = tab_1.tabpage_columns.dw_fields_list.Describe("DataWindow.VerticalScrollPosition") 
ls_table_v_scroll_position = tab_1.tabpage_tables.dw_select_table.Describe("DataWindow.VerticalScrollPosition") 

tab_1.tabpage_tables.dw_view_tables.AcceptText( )

li_rc = tab_1.tabpage_tables.dw_view_tables.RowCount( )
FOR i = 1 TO li_rc
	IF IsNull( tab_1.tabpage_tables.dw_view_tables.GetItemNumber( i, "cust_table_name" ) ) THEN
		MessageBox("Missing Data", "You can not leave the table field blank." )
		tab_1.tabpage_tables.dw_view_tables.SetColumn( "cust_table_name" )
		tab_1.tabpage_tables.dw_view_tables.SetRow( i )
		tab_1.tabpage_tables.dw_view_tables.SetFocus( )		
		SetRedraw( True )
		Return -1
	END IF
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.08.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
tab_1.tabpage_tables.dw_view_tables.Update( )
tab_1.tabpage_tables.dw_view_links.Update( )
tab_1.tabpage_columns.dw_view_fields.Update( )
tab_1.tabpage_sort.dw_view_sort.Update( )
tab_1.tabpage_browse.dw_detail.Update( )
li_rc = tab_1.tabpage_filter.dw_view_where.RowCount( )
FOR i = 1 TO li_rc
	IF IsNull( tab_1.tabpage_filter.dw_view_where.GetItemString( i, "table_field_name" ) ) OR +&
  	   IsNull( tab_1.tabpage_filter.dw_view_where.GetItemString( i, "operator" ) ) OR +&
	   IsNull( tab_1.tabpage_filter.dw_view_where.GetItemString( i, "value" ) ) THEN
		MessageBox("Missing Data", "All fields must be completed." )
		tab_1.tabpage_filter.dw_view_where.SetColumn( "table_field_name" )
		tab_1.tabpage_filter.dw_view_where.SetRow( i )
		tab_1.tabpage_filter.dw_view_where.SetFocus( )		
		SetRedraw( True )
		Return -1
	END IF
END FOR
tab_1.tabpage_filter.dw_view_where.Update( )

tab_1.tabpage_tables.dw_view_tables.Retrieve( il_view_id )

li_rc = tab_1.tabpage_tables.dw_view_tables.RowCount()

FOR i = 1 TO li_rc
	ls_table_ids[i] = tab_1.tabpage_tables.dw_view_tables.GetItemString( i, "table_name" ) 
END FOR

IF li_rc > 0 THEN
	tab_1.tabpage_columns.dw_fields_list.Retrieve( ls_table_ids )
	tab_1.tabpage_columns.dw_all_fields.Retrieve(  ls_table_ids  )
END IF

li_rc = tab_1.tabpage_columns.dw_view_fields.RowCount()
FOR i = 1 TO li_rc
	ls_tbl_nm = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_name" )
	ls_fld_nm = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_name" )
	li_found = tab_1.tabpage_columns.dw_fields_list.Find( "table_name = '" + ls_tbl_nm + "' AND field_name ='" + ls_fld_nm + "'" , 1, 1000 )
	IF li_found > 0 THEN
		tab_1.tabpage_columns.dw_fields_list.DeleteRow( li_found )
	END IF	
END FOR

tab_1.tabpage_sort.dw_view_sort.Retrieve(  il_view_id  )	
tab_1.tabpage_sort.dw_fields_list_sort.Retrieve(  il_view_id  )	
li_rc = tab_1.tabpage_sort.dw_view_sort.RowCount()

FOR i = 1 TO li_rc
	ls_field = tab_1.tabpage_sort.dw_view_sort.GetItemString( i, "field_name" )
	li_found = tab_1.tabpage_sort.dw_fields_list_sort.Find( "field_name = '" + ls_field + "'", 1, 10000 )
	IF li_found > 0 THEN
		tab_1.tabpage_sort.dw_fields_list_sort.DeleteRow( li_found )
	END IF
END FOR

tab_1.tabpage_tables.dw_select_table.Retrieve(  il_view_id  )	
*/

li_rc = tab_1.tabpage_filter.dw_view_where.RowCount( )
FOR i = 1 TO li_rc
	IF IsNull( tab_1.tabpage_filter.dw_view_where.GetItemString( i, "table_field_name" ) ) OR +&
  	   IsNull( tab_1.tabpage_filter.dw_view_where.GetItemString( i, "operator" ) ) OR +&
	   IsNull( tab_1.tabpage_filter.dw_view_where.GetItemString( i, "value" ) ) THEN
		MessageBox("Missing Data", "All fields must be completed." )
		tab_1.tabpage_filter.dw_view_where.SetColumn( "table_field_name" )
		tab_1.tabpage_filter.dw_view_where.SetRow( i )
		tab_1.tabpage_filter.dw_view_where.SetFocus( )		
		SetRedraw( True )
		Return -1
	END IF
END FOR
gnv_appeondb.of_StartQueue()
tab_1.tabpage_filter.dw_view_where.Update( )
tab_1.tabpage_tables.dw_view_tables.Update( )
tab_1.tabpage_tables.dw_view_links.Update( )
tab_1.tabpage_columns.dw_view_fields.Update( )
tab_1.tabpage_sort.dw_view_sort.Update( )
tab_1.tabpage_browse.dw_detail.Update( )
tab_1.tabpage_tables.dw_view_tables.Retrieve( il_view_id )
gnv_appeondb.of_CommitQueue()

li_rc = tab_1.tabpage_tables.dw_view_tables.RowCount()

FOR i = 1 TO li_rc
	ls_table_ids[i] = tab_1.tabpage_tables.dw_view_tables.GetItemString( i, "table_name" ) 
END FOR

gnv_appeondb.of_StartQueue()
IF li_rc > 0 THEN
	tab_1.tabpage_columns.dw_fields_list.Retrieve( ls_table_ids )
	tab_1.tabpage_columns.dw_all_fields.Retrieve(  ls_table_ids  )
END IF
tab_1.tabpage_sort.dw_view_sort.Retrieve(  il_view_id  )	
tab_1.tabpage_sort.dw_fields_list_sort.Retrieve(  il_view_id  )	
tab_1.tabpage_tables.dw_select_table.Retrieve(  il_view_id  )
gnv_appeondb.of_CommitQueue()

li_rc = tab_1.tabpage_columns.dw_view_fields.RowCount()
FOR i = 1 TO li_rc
	ls_tbl_nm = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_name" )
	ls_fld_nm = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_name" )
	li_found = tab_1.tabpage_columns.dw_fields_list.Find( "table_name = '" + ls_tbl_nm + "' AND field_name ='" + ls_fld_nm + "'" , 1, 1000 )
	IF li_found > 0 THEN
		tab_1.tabpage_columns.dw_fields_list.DeleteRow( li_found )
	END IF	
END FOR

li_rc = tab_1.tabpage_sort.dw_view_sort.RowCount()
FOR i = 1 TO li_rc
	ls_field = tab_1.tabpage_sort.dw_view_sort.GetItemString( i, "field_name" )
	li_found = tab_1.tabpage_sort.dw_fields_list_sort.Find( "field_name = '" + ls_field + "'", 1, 10000 )
	IF li_found > 0 THEN
		tab_1.tabpage_sort.dw_fields_list_sort.DeleteRow( li_found )
	END IF
END FOR
//---------------------------- APPEON END ----------------------------
li_rc = tab_1.tabpage_tables.dw_view_tables.RowCount()
FOR i = 1 TO li_rc
	ls_tbl_nm = tab_1.tabpage_tables.dw_view_tables.GetItemString( i, "table_name" )
	li_found = tab_1.tabpage_tables.dw_select_table.Find( "table_name = '" + ls_tbl_nm + "'", 1, 1000 )
	IF li_found > 0 THEN
		tab_1.tabpage_tables.dw_select_table.DeleteRow( li_found )
	END IF
END FOR

tab_1.tabpage_columns.dw_fields_list.Modify("DataWindow.VerticalScrollPosition=" + ls_field_v_scroll_position ) 
tab_1.tabpage_tables.dw_select_table.Modify("DataWindow.VerticalScrollPosition = " + ls_table_v_scroll_position ) 

SetRedraw( True )
Return 0
end function

public function string of_build_view_sql ();Integer i
Integer li_add_rec_fld  
Integer li_distinct_sql
Integer li_rc
Integer li_remove_len = 5
String ls_sql
String ls_table_name
String ls_tname
String ls_table_field
string ls_dir //maha 111802
string ls_sort //maha 111802
Boolean 	lb_multi_table
integer p

lb_multi_table = False
is_sort_synt = ""
of_save()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 02.09.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Collect two SQL statements and merge them into one to reduce client-server
//$<modification> interactions. Refer to PT-03 for more information.

/*
SELECT conv_view.distinct_sql
INTO :li_distinct_sql  
FROM conv_view  
WHERE conv_view.view_id = :il_view_id   ;
*/
SELECT conv_view.distinct_sql, conv_view.add_rec_id_fld
INTO :li_distinct_sql, :li_add_rec_fld
FROM conv_view  
WHERE conv_view.view_id = :il_view_id   ;
//---------------------------- APPEON END ----------------------------

IF li_distinct_sql  = 1 THEN
	ls_sql = "SELECT DISTINCT"  + "~n"
ELSE
	ls_sql = "SELECT "  + "~n"
END IF

//build the select field 
li_rc = tab_1.tabpage_columns.dw_view_fields.RowCount()
//debugbreak()
FOR i = 1 TO li_rc
	ls_table_name =  tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_name" )
	IF PosA( tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "compute_name" ), "=" ) > 0 THEN //trap for computed fields
		ls_table_field = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_field" )
		ls_table_field = MidA( ls_table_field, PosA( ls_table_field, "=" ) + 1 , 1000 )
		ls_sql = ls_sql + "~t" + tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_alias" ) + " = " + ls_table_field + ",  " + "~n"
		//ls_sql = ls_sql + "~t" + tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_alias" ) + " = " + ls_table_name + "." + ls_table_field + ",  " + "~n"			
	ELSE
		ls_sql = ls_sql + "~t" + tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_alias" ) + " = " + ls_table_name + "." + tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_field" ) + ",  " + "~n"	
	END IF
END FOR

ls_sql = LeftA( ls_sql, LenA( ls_sql ) - 4 ) + "~n"
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<comment> 02.09.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Move the following script to PT-02. For more information, refer to PT-02.
/*
SELECT conv_view.add_rec_id_fld  
INTO :li_add_rec_fld  
FROM conv_view  
WHERE conv_view.view_id = :il_view_id   ;
*/
//---------------------------- APPEON END ----------------------------
IF li_add_rec_fld  = 1 THEN
	ls_sql = ls_sql + "~t, rec_id = 100000000~n"
END IF

//build from clause
ls_sql = ls_sql + "FROM " + "~n"
li_rc = tab_1.tabpage_tables.dw_view_tables.RowCount()

FOR i = 1 TO li_rc
	ls_sql = ls_sql + "~t" + "" + tab_1.tabpage_tables.dw_view_tables.GetItemString( i, "table_name" ) + ", "  + "~n"
END FOR

if ii_facil_security = 1 then
	ls_sql = ls_sql + "~t" + "security_user_facilities" + ", " + "~n"
end if

IF ii_dept_security_on = 1 then
	ls_sql = ls_sql + "~t" + "security_user_department" + "  " + "~n"		
END IF

ls_sql = LeftA( ls_sql, LenA( ls_sql ) - 3 ) + "~n"

//build where clause for joins
li_rc = tab_1.tabpage_tables.dw_view_links.RowCount()

IF li_rc > 0 THEN
	ls_sql = ls_sql + "WHERE " + "~n"	
	FOR i = 1 TO li_rc
		lb_multi_table = True
		ls_sql = ls_sql + "~t" + "(" + tab_1.tabpage_tables.dw_view_links.GetItemString( i, "from_table_field" ) 
		ls_sql = ls_sql + " " + tab_1.tabpage_tables.dw_view_links.GetItemString( i, "link_type" ) + " "
		ls_sql = ls_sql + tab_1.tabpage_tables.dw_view_links.GetItemString( i, "to_table_field" ) 	+ ") AND ~n"
	END FOR

	ls_sql = LeftA( ls_sql, LenA( ls_sql ) - 5 ) 
END IF

//build where filter
li_rc = tab_1.tabpage_filter.dw_view_where.RowCount()
IF li_rc > 0 THEN
	IF lb_multi_table = True THEN
		ls_sql = ls_sql + " AND ~n"
	ELSE
		ls_sql = ls_sql + " WHERE " + "~n"	
	END IF
	FOR i = 1 TO li_rc
		ls_tname = tab_1.tabpage_filter.dw_view_where.GetItemString( i, "table_field_name" )
		
		if PosA(ls_tname,"v_",1) > PosA(ls_tname,".",1) then //would designate a computed field //maha 020304
			ls_sql = ls_sql + "~t" + "(" + MidA(ls_tname,1,PosA(ls_tname,".",1) - 1) //get computed field name
		else //all other fields
			ls_sql = ls_sql + "~t" + "(" + ls_tname 
		end if
		ls_sql = ls_sql + " " + tab_1.tabpage_filter.dw_view_where.GetItemString( i, "operator" ) + " "
		IF tab_1.tabpage_filter.dw_view_where.GetItemString( i, "operator" ) = "In" THEN
			ls_sql = ls_sql + "(" + tab_1.tabpage_filter.dw_view_where.GetItemString( i, "value" ) + ")"
		else
			ls_sql = ls_sql + tab_1.tabpage_filter.dw_view_where.GetItemString( i, "value" )
		END IF	
			//li_remove_len = 6
		
		ls_sql = ls_sql +  ") AND ~n"	
	END FOR
	ls_sql = LeftA( ls_sql, LenA( ls_sql ) - 5 ) + "~n"	
END IF

//bring in wizard SQL
IF LenA( is_sql_where ) > 0 THEN 
	ls_sql = ls_sql + is_sql_where
END IF

//build order by clause
li_rc = tab_1.tabpage_sort.dw_view_sort.RowCount()
IF li_rc > 0 THEN
	
	IF RightA( ls_sql, 5 ) = " AND " THEN
		ls_sql = MidA( ls_sql, 1, LenA( ls_sql ) -5 )
	END IF
	
	ls_sql = ls_sql + "ORDER BY " + "~n"
	FOR i = 1 TO li_rc	
		//is_sort_synt maha modified 012704 to put sort fields into variable to be used after end of group by
//		ls_sql = ls_sql + "~t" + tab_1.tabpage_sort.dw_view_sort.GetItemString( i, "table_name" ) + "."
		ls_sql = ls_sql + tab_1.tabpage_sort.dw_view_sort.GetItemString( i, "field_name" ) + " "
		is_sort_synt = is_sort_synt + tab_1.tabpage_sort.dw_view_sort.GetItemString( i, "field_name" ) + " " //which is really the field alias maha 012704
		//ls_sql = ls_sql + tab_1.tabpage_sort.dw_view_sort.GetItemString( i, "field_alias" ) + " "
		
		ls_dir = tab_1.tabpage_sort.dw_view_sort.GetItemString( i, "sort_dir" )
		if ls_dir = "D" then
			ls_sort = "DESC"
		else
			ls_dir = "A"
			ls_sort = "ASC"
		end if
		ls_sql = ls_sql + ls_sort + ","
		is_sort_synt = is_sort_synt + ls_dir + ","
	END FOR
	ls_sql = LeftA(ls_sql, LenA( ls_sql ) - 1 ) + "~n"	//get rid of extra comma
	is_sort_synt = LeftA( is_sort_synt, LenA( is_sort_synt ) - 1 ) + "~n"	//get rid of extra comma
	//ls_sql = ls_sql + is_sort_synt
	
END IF
IF RightA( is_sql_where, 5 ) = " AND " THEN
	ls_sql = MidA( ls_sql, 1, LenA( ls_sql ) -5 )
END IF

tab_1.tabpage_run.st_sql.Text = ls_sql
ClipBoard( ls_sql )
tab_1.tabpage_run.st_sql.Visible = True

Return ls_sql
end function

public function integer of_help (string selected_tab, string option);//st_help_1.Visible = False
//st_help_2.Visible = False
//
//IF selected_tab = "browse" AND option = "" THEN
//	st_help_1.Visible = True
//	st_help_1.Text = "The browse tab displays all of the custom reports currently available and also allows you to create New custom reports.~n~r~n~r" +&
//			     "NEW            -  Create a new custom report.~n~r" +&
//				"DELETE       -  Delete a custom report.~n~r" +&
//				"SELECT       -  Select a custom report for edit or preview.  ( Double clicking the entry also selects the report.)"						
//END IF
//

Return 0
end function

public function integer of_wizard_setup ();Integer i
Integer li_cnt
Integer li_rc


li_rc = tab_1.tabpage_columns.dw_view_fields.RowCount()

FOR i = 1 TO li_rc
	IF LenA( tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_wizard_name" ) ) > 0 THEN
		li_cnt++		
		is_wizard_lookup_name[ li_cnt ] = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_wizard_name" )
		is_wizard_lookup_type[ li_cnt ] = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_wizard_type" )
		is_wizard_field_name[ li_cnt ] = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_name" )
		is_wizard_compare_field[ li_cnt ] = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_options" )		
	END IF
END FOR

is_facility_name = ""
ii_total_wizard_steps = li_cnt
ii_current_wizard_step = 0
ii_total_where_values = 0
is_sql_where = ""
is_address_types = ""
is_net_dev_types = ""

of_next_wizard()

//tab_1.tabpage_run.dw_wizard.SetTransObject( SQLCA )
//tab_1.tabpage_run.dw_wizard.Retrieve( is_wizard_lookup_name[ 1 ] )
//tab_1.tabpage_run.dw_wizard.Modify( "st_name.text = '" + is_wizard_lookup_name[ 1 ] + "'" )
//
Return 0
end function

public function integer of_next_wizard ();//creates wizard filter values calls of_preview if last step called from of_wizard_setup
string ddd
Integer li_rc
Integer i
Integer li_first_param
integer li_nd_cnt
String ls_from_date
String ls_to_date
string ls_facility_name
string ls_action_type
string ls_action_status
string ls_nd_actions
string ls_app_name

IF ii_current_wizard_step = 0 THEN //this is called before the next button has ever been clicked  
	//ii_total_where_values = 0  done in reset
	IF tab_1.tabpage_tables.dw_view_tables.RowCount() = 1 THEN		//if only 1 table  maha 092402 to fix single table queries
		if tab_1.tabpage_filter.dw_view_where.RowCount() < 1 then // if no filters
			is_sql_where = " WHERE "
		end if		
	ELSE //more than 1 table 
			is_sql_where = " AND "
	END IF
END IF

//Process current wizard step
//debugbreak()
IF ii_current_wizard_step > 0 THEN 
	IF RightA( is_sql_where, 5 ) = " AND " or RightA( is_sql_where, 7 ) = " WHERE " THEN //maha changed 101602
		//messagebox("","no add")
	else
		//messagebox("","and add")
		is_sql_where = is_sql_where + " AND "
	end if

	tab_1.tabpage_run.dw_wizard.AcceptText()
	li_first_param=0
	
	IF tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_date_range_custom" THEN
		ls_from_date = String( tab_1.tabpage_run.dw_wizard.GetItemDate( 1, "from_date" ), 'yyyy/mm/dd' )
		ls_to_date = String( tab_1.tabpage_run.dw_wizard.GetItemDate( 1, "to_date" ), 'yyyy/mm/dd' )		
		IF LenA( is_filter ) > 1 THEN
			is_filter = is_filter + " : "
		END IF
		is_filter = is_filter + "Date Range=" + ls_from_date + " - " + ls_to_date
		IF NOT IsNull( ls_from_date + ls_to_date ) AND ls_from_date + ls_to_date <> "" THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 21/05/2007 By: Jervis
			//$<reason> 
			/*
			is_sql_where = is_sql_where + "( Date( " + is_wizard_field_name[ ii_current_wizard_step ] + " )  >= Cast('" + ls_from_date + "' AS DATE ) AND " +&
				                           "Date( " + is_wizard_field_name[ ii_current_wizard_step ] + " )  <= Cast('" + ls_to_date + "' AS DATE ) )"		
			*/
			is_sql_where = is_sql_where + "( Convert(datetime, " + is_wizard_field_name[ ii_current_wizard_step ] + ",102 )  >= Convert(datetime,'" + ls_from_date + "',102) AND " +&
				                           "Convert(datetime, " + is_wizard_field_name[ ii_current_wizard_step ] + ",102 )  <= Convert(datetime,'" + ls_to_date + "' ,102 ) )"		
			//---------------------------- APPEON END ----------------------------

			ii_total_where_values++								
		END IF
	ELSEIF tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_single_date_custom" THEN
		IF LenA( is_filter ) > 1 THEN
			is_filter = is_filter + " : "
		END IF		
		is_filter = is_filter + "Date=" + String( tab_1.tabpage_run.dw_wizard.GetItemDate( 1, "from_date" ), 'mm/dd/yyyy' )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 12.01.2006 By: Davis
		//$<reason> Fix a defect.
		//is_sql_where = is_sql_where + "DateFormat( " + is_wizard_field_name[ ii_current_wizard_step ] + ", 'mm/dd/yyyy' ) = '" + String( tab_1.tabpage_run.dw_wizard.GetItemDate( 1, "from_date" ), 'mm/dd/yyyy' ) + "'"		
		is_sql_where = is_sql_where + "Convert(varchar(10), " + is_wizard_field_name[ ii_current_wizard_step ] + ", 101 ) = '" + String( tab_1.tabpage_run.dw_wizard.GetItemDate( 1, "from_date" ), 'mm/dd/yyyy' ) + "'"		
		//---------------------------- APPEON END ----------------------------
		ii_total_where_values++	
	elseif tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_address_type_ir" THEN //address type
		is_filter = is_filter + "  Address Type = " 
		is_address_types = "  ("
		IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "primary" ) = 1 THEN
			is_address_types = is_address_types + " v_address_link.primary_office = 1 OR "
			is_filter = is_filter + "Primary, "
		END IF
		IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "additional" ) = 1 THEN
			is_address_types = is_address_types + " v_address_link.additional_office = 1 OR "
			is_filter = is_filter + "Additional, "			
		END IF			
		IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "billing" ) = 1 THEN
			is_address_types = is_address_types + " v_address_link.billing = 1 OR "
			is_filter = is_filter + "Billing, "			
		END IF						
		IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "home" ) = 1 THEN
			is_address_types = is_address_types + " v_address_link.home_address = 1 OR "
			is_filter = is_filter + "Home, "			
		END IF
		IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "mailing" ) = 1 THEN
			is_address_types = is_address_types + " v_address_link.mailing = 1 OR "
			is_filter = is_filter + "Mailing, "			
		END IF
			is_address_types = MidA( is_address_types, 1, LenA( is_address_types ) -3 ) + ")"
			is_filter = MidA( is_filter, 1, LenA( is_filter ) -2 ) 
		IF is_address_types = ")" THEN
			MessageBox("Selection Error", "You must select at least one address Type. ")
			Return -1
		END IF
		is_sql_where = is_sql_where + is_address_types
	ELSEIF tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_net_dev_type_ir" then //maha 071604
			IF LenA( is_filter ) > 1 THEN
				is_filter = is_filter + " : "
			END IF		
		
			IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "selected" ) = 1 THEN
				is_filter = is_filter + " Net Dev Type = ALL"
				is_net_dev_types = ""
			ELSE

				is_net_dev_types = ""
				li_rc = tab_1.tabpage_run.dw_wizard.RowCount()
				
				is_filter = is_filter + " Net Dev Type = "
				
				FOR i = 1 TO li_rc
					IF tab_1.tabpage_run.dw_wizard.GetItemNumber( i, "selected" ) = 1 THEN
						li_nd_cnt++ //check to see if there will be ORs
						ls_action_status = tab_1.tabpage_run.dw_wizard.GetItemString( i, "custom_3" ) 
						is_filter = is_filter + ls_action_status
						IF ls_action_status = '' OR IsNull( ls_action_status ) THEN
							//MessageBox("Incomplete", "If you select an Action Type you must select and Action Status." )
     						MessageBox("Incomplete", "If you select an Action Type you must select an Action Status." )
							Return -1
						END IF
						ls_action_type =  tab_1.tabpage_run.dw_wizard.GetItemString( i, "code" )
						ls_nd_actions = "( v_net_dev_actions.action_type_code = '" + ls_action_type + "' AND v_net_dev_actions.action_status_code = '" + ls_action_status + "') OR"
						is_net_dev_types = is_net_dev_types + ls_nd_actions + " "
					END IF
				END FOR
	
				is_filter = MidA( is_filter, 1, LenA( is_filter ) -2 ) 
				is_net_dev_types = MidA( is_net_dev_types, 1, LenA( is_net_dev_types ) -3 )
				
				if li_nd_cnt > 1 then //surround the 'ORs'
					is_net_dev_types = " (" + is_net_dev_types + ") "
				end if
				
				IF LenA( is_net_dev_types ) < 4 THEN
					MessageBox("Selection Error", "You must check off at least one Action Type or select All." )
					Return -1
				END IF		
			END IF		
			is_sql_where = is_sql_where + is_net_dev_types
			//Messagebox("", is_net_dev_types )
//	ELSEIF tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_app_payor" then //maha 071604
//		if tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "selected" ) = 1 then
//			//skip
//		else
//			if tab_1.tabpage_run.dw_wizard.RowCount() > 1 then //trap
//				for i = 2 to tab_1.tabpage_run.dw_wizard.RowCount()
//					if tab_1.tabpage_run.dw_wizard.GetItemNumber( i, "selected" ) = 1 THEN
//						ls_app_name = tab_1.tabpage_run.dw_wizard.GetItemString( i, "application_name" )
//						is_sql_where = is_sql_where + " (" + ls_app_name + ") "
//						continue
//					end if
//				next
//			end if
//		end if
	ELSE
		IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "selected" ) = 0 THEN  //if all is not selected
			li_rc = tab_1.tabpage_run.dw_wizard.RowCount()	
			FOR i = 1 TO li_rc
				ii_total_where_values ++
				IF tab_1.tabpage_run.dw_wizard.GetItemNumber( i, "selected" ) = 1 THEN
					li_first_param++
					IF li_first_param = 1 THEN
						is_sql_where = is_sql_where + "("
					END IF
					IF PosA( is_filter, is_wizard_lookup_name[ ii_current_wizard_step ] ) = 0 THEN
						IF LenA( is_filter ) > 1 THEN
							is_filter = is_filter + " : "
						END IF
						is_filter = is_filter + is_wizard_lookup_name[ ii_current_wizard_step ] + " = "
					END IF
					is_sql_where = is_sql_where + is_wizard_field_name[ ii_current_wizard_step ] + " = '" 
					IF is_wizard_lookup_type[ ii_current_wizard_step ] = "C" THEN  //code lookup
						IF is_wizard_compare_field[ ii_current_wizard_step ] = "C" THEN //code field
							is_sql_where = is_sql_where + tab_1.tabpage_run.dw_wizard.GetItemString( i, "code" ) + "' OR " 
							is_filter = is_filter + " " + tab_1.tabpage_run.dw_wizard.GetItemString( i, "code" ) + ","
						ELSE //description
							is_sql_where = is_sql_where + tab_1.tabpage_run.dw_wizard.GetItemString( i, "description" ) + "' OR " 
							is_filter = is_filter + " " + tab_1.tabpage_run.dw_wizard.GetItemString( i, "description" ) + ","
						END IF
					ELSEIF is_wizard_lookup_type[ ii_current_wizard_step ] = "A" THEN //address_lookup
						IF is_wizard_compare_field[ ii_current_wizard_step ] = "C" THEN		//code				
							is_sql_where = is_sql_where + tab_1.tabpage_run.dw_wizard.GetItemString( i, "code" ) + "' OR " 		
							is_filter = is_filter + " " + tab_1.tabpage_run.dw_wizard.GetItemString( i, "code" ) + ","							
						ELSE //entity_name
							is_sql_where = is_sql_where + tab_1.tabpage_run.dw_wizard.GetItemString( i, "entity_name" ) + "' OR " 
							is_filter = is_filter + " " + tab_1.tabpage_run.dw_wizard.GetItemString( i, "entity_name" ) + ","														
						END IF
					ELSEIF  is_wizard_lookup_type[ ii_current_wizard_step ] = "F" THEN //facility
							ls_facility_name =  tab_1.tabpage_run.dw_wizard.GetItemString( i, "facility_name" )
							is_facility_name = is_facility_name + ", " + ls_facility_name //maha 101602
							is_sql_where = is_sql_where + ls_facility_name + "' OR " 
							is_filter = is_filter + " " + ls_facility_name + ","														
					ELSEIF  is_wizard_lookup_type[ ii_current_wizard_step ] = "P" THEN //facility
							ls_app_name =  tab_1.tabpage_run.dw_wizard.GetItemString( i, "application_name" )
							is_appl_name = is_appl_name + ", " + ls_app_name //maha 101602
							is_filter = is_filter + " " + ls_app_name + ","																					
							is_sql_where = is_sql_where + ls_app_name + "' OR " 		
					elseif is_wizard_lookup_type[ ii_current_wizard_step ] = "L" THEN //address type
						is_address_types = " And ("
						IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "primary" ) = 1 THEN
							is_address_types = is_address_types + " pd_address_link.primary_office = 1 OR "
							is_filter = is_filter + " Primary ,"														
						END IF
						IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "additional" ) = 1 THEN
							is_address_types = is_address_types + " pd_address_link.additional_office = 1 OR "
							is_filter = is_filter + " Additional ,"																					
						END IF			
						IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "billing" ) = 1 THEN
							is_address_types = is_address_types + " pd_address_link.billing = 1 OR "
							is_filter = is_filter + " Billing ,"																					
						END IF						
						IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "home" ) = 1 THEN
							is_address_types = is_address_types + " pd_address_link.home_address = 1 OR "
							is_filter = is_filter + " Home ,"																					
						END IF
						IF tab_1.tabpage_run.dw_wizard.GetItemNumber( 1, "mailing" ) = 1 THEN
							is_address_types = is_address_types + " pd_address_link.mailing = 1 OR "
							is_filter = is_filter + " Mailing ,"																					
						END IF
						is_address_types = MidA( is_address_types, 1, LenA( is_address_types ) -3 ) + ")"
			
						IF is_address_types = " And (" THEN
							MessageBox("Selection Error", "You must select at least one address Type. ")
							Return -1
						END IF
					elseif is_wizard_lookup_type[ ii_current_wizard_step ] = "N" THEN //action type	maha 071404
						//dw_wizard.DataObject = "d_crit_net_dev_type"
					END IF
				ELSE
					//is_filter = is_filter + " " + is_wizard_lookup_name[ ii_current_wizard_step ] + " All "
				END IF
			END FOR
			
			is_filter = MidA( is_filter, 1, LenA( is_filter ) -2 )
			
			is_address_types = MidA( is_address_types, 1, LenA( is_address_types ) -3 ) + ")"

			if is_wizard_lookup_type[ ii_current_wizard_step ] = "F" THEN //facility
				is_facility_name = MidA(	is_facility_name, 3)
			end if
			if is_wizard_lookup_type[ ii_current_wizard_step ] = "P" THEN //Application
				is_appl_name = MidA(	is_appl_name, 3)
			end if
			is_sql_where = MidA( is_sql_where, 1, LenA( is_sql_where ) -3 ) + ")"		//get rid of " or "
			IF li_first_param = 0 THEN
				is_sql_where = MidA( is_sql_where, 1, LenA( is_sql_where ) -2 )
			END IF
		ELSE 
			if is_wizard_lookup_type[ ii_current_wizard_step ] = "F" THEN //maha 101602
				is_facility_name = "All Facilities"
			end if
		END IF
	END IF
END IF

//MessageBox("", is_sql_where )

ii_current_wizard_step++
//Goto next wizard step or run report if its the last step
IF ii_current_wizard_step > ii_total_wizard_steps THEN 
	///*************run report********************
	//\/maha 112102 for user facility security
	if ii_facil_security = 1 then
		IF RightA( is_sql_where, 5 ) = " AND " or RightA( is_sql_where, 7 ) = " WHERE " THEN //maha changed 101602
		else
			is_sql_where = is_sql_where + " AND "
		end if		
		is_sql_where = is_sql_where + " security_user_facilities.facility_id = v_affil_stat.parent_facility_id and  security_user_facilities.access_rights = 1 and security_user_facilities.user_id = '" + gs_user_id + "'~r "
	end if
	
	//jad department security
	if ii_dept_security_on = 1 then
		IF RightA( is_sql_where, 5 ) = " AND " or RightA( is_sql_where, 7 ) = " WHERE " THEN //maha changed 101602
		else
			is_sql_where = is_sql_where + " AND "
		end if		
		is_sql_where = is_sql_where + " security_user_department.department_id = v_affil_dept.dept_id and  security_user_department.access_rights = 1 and security_user_department.user_id = '" + gs_user_id + "'~r "
	end if	
	
	//\maha
	IF RightA( is_sql_where, 5 ) = " AND " THEN
		is_sql_where = MidA( is_sql_where, 1, LenA( is_sql_where ) -5 )
	END IF			
	IF RightA( is_sql_where, 7 ) = " WHERE " THEN
		is_sql_where = MidA( is_sql_where, 1, LenA( is_sql_where ) -7 )
	END IF				
	//IF Len( is_sql_where ) = 5 THEN
	//	is_sql_where = ""
	//END IF
	of_preview( tab_1.tabpage_run.dw_run, tab_1.tabpage_browse.dw_detail )
	ii_current_wizard_step = 0
	tab_1.tabpage_run.dw_wizard.Reset()
	tab_1.tabpage_run.cb_next_run.Enabled = False
	tab_1.tabpage_run.cb_sql.Enabled = True
ELSE //create next wizard
	tab_1.tabpage_run.st_step.Text = "Step " + String( ii_current_wizard_step ) + " of " + String( ii_total_wizard_steps )
	IF is_wizard_lookup_type[ ii_current_wizard_step ] = "C" THEN
		tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_custom"		
	//if its a date range
	ELSEIF is_wizard_lookup_type[ ii_current_wizard_step ] = "R" THEN
		//tab_1.tabpage_run.dw_wizard.Reset()
		//tab_1.tabpage_run.dw_wizard.DataObject = "d_app_note"				
		//tab_1.tabpage_run.dw_wizard.of_setTransObject(sqlca)
		tab_1.tabpage_run.dw_wizard.Reset()		
		tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_date_range_custom"		
		//tab_1.tabpage_run.dw_wizard.of_settransobject(sqlca)
	ELSEIF is_wizard_lookup_type[ ii_current_wizard_step ] = "D" THEN		
		tab_1.tabpage_run.dw_wizard.Reset()		
		tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_single_date_custom"				
	ELSEIF is_wizard_lookup_type[ ii_current_wizard_step ] = "F" THEN		
		tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_facility"
	ELSEIF is_wizard_lookup_type[ ii_current_wizard_step ] = "L" THEN	
		//messagebox("","")
		tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_address_type_ir"		
	elseif is_wizard_lookup_type[ ii_current_wizard_step ] = "N" THEN	 //maha 071404
		tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_net_dev_type_ir"	
	elseif is_wizard_lookup_type[ ii_current_wizard_step ] = "P" THEN		//maha 071604
		tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_app_payor"	
	ELSE
		tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_custom_address"
	END IF
	tab_1.tabpage_run.dw_wizard.of_SetRowManager( TRUE )
	tab_1.tabpage_run.dw_wizard.of_SetReqColumn(True)

	tab_1.tabpage_run.dw_wizard.of_SetDropDownCalendar( TRUE )
	tab_1.tabpage_run.dw_wizard.iuo_calendar.of_Register(tab_1.tabpage_run.dw_wizard.iuo_calendar.DDLB)
	
	tab_1.tabpage_run.dw_wizard.SetTransObject( SQLCA )
	if tab_1.tabpage_run.dw_wizard.DataObject = "d_crit_facility" then
		tab_1.tabpage_run.dw_wizard.Retrieve( gs_user_id ) //maha 111902 lij
	else
		tab_1.tabpage_run.dw_wizard.Retrieve( is_wizard_lookup_name[ ii_current_wizard_step ] )
	end if
	tab_1.tabpage_run.dw_wizard.Modify( "st_name.text = '" + is_wizard_lookup_name[ ii_current_wizard_step ] + " for " + is_wizard_field_name[ ii_current_wizard_step ] + "'" )
END IF

//		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
//		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
//		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "All" )		
//		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include All Selections" )		
//		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
RETURN 0
end function

public function integer of_clean_up ();
tab_1.tabpage_tables.dw_view_tables.Reset()
tab_1.tabpage_tables.dw_view_links.Reset()
tab_1.tabpage_columns.dw_view_fields.Reset()
tab_1.tabpage_filter.dw_view_where.Reset()
tab_1.tabpage_sort.dw_view_sort.Reset()
is_facility_name = ""
ii_total_wizard_steps = 0
ii_current_wizard_step = 0
ii_total_where_values = 0
is_sql_where = ""
is_address_types = ""
is_net_dev_types = ""

Return 1
end function

public function integer of_retrieve_report (long al_view);//moved from doubleclicked event of report browse
Integer li_rc
Integer i
Integer li_found
Integer li_add_rec_fld
Integer li_distinct_sql
String ls_field
String ls_table_ids[]



ib_new = False

if upper(is_mod_user) = upper(gs_user_id) then //maha 111902
tab_1.tabpage_columns.Enabled = True
tab_1.tabpage_filter.Enabled = True
tab_1.tabpage_preview.Enabled = True
tab_1.tabpage_sort.Enabled = True
tab_1.tabpage_tables.Enabled = True
else
tab_1.tabpage_columns.Enabled = false
tab_1.tabpage_filter.Enabled = false
tab_1.tabpage_preview.Enabled = false
tab_1.tabpage_sort.Enabled = false
tab_1.tabpage_tables.Enabled = false	
end if

tab_1.tabpage_run.Enabled = True

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 2006-04-05 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
tab_1.tabpage_tables.dw_view_tables.Retrieve( al_view )
of_get_next_ids()
*/

gnv_appeondb.of_startqueue( )

tab_1.tabpage_tables.dw_view_tables.Retrieve( al_view )

SELECT Max( table_id )  
INTO :il_next_table_id  
FROM conv_view_table;

SELECT Max( link_id )  
INTO :il_next_link_id  
FROM conv_view_links;

SELECT Max( sort_id )  
INTO :il_next_sort_id  
FROM conv_view_sort;

SELECT Max( field_id )  
INTO :il_next_field_id  
FROM conv_view_fields;

SELECT Max( where_id )  
INTO :il_next_where_id  
FROM conv_view_where;

gnv_appeondb.of_commitqueue( )

IF IsNull( il_next_table_id ) THEN
	il_next_table_id = 1
END IF

IF IsNull( il_next_link_id ) THEN
	il_next_link_id = 1
END IF

IF IsNull( il_next_sort_id ) THEN
	il_next_sort_id = 1
END IF

IF IsNull( il_next_field_id ) THEN
	il_next_field_id = 1
END IF

IF IsNull( il_next_where_id ) THEN
	il_next_where_id = 1
END IF

//---------------------------- APPEON END ----------------------------

li_rc = tab_1.tabpage_tables.dw_view_tables.RowCount()
FOR i = 1 TO li_rc
	ls_table_ids[i] = tab_1.tabpage_tables.dw_view_tables.GetItemString( i, "table_name" ) 
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<modify> 2006-04-05 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
/*
IF li_rc > 0 THEN
	tab_1.tabpage_columns.dw_fields_list.Retrieve( ls_table_ids )
	tab_1.tabpage_columns.dw_all_fields.Retrieve( ls_table_ids )
END IF	

tab_1.tabpage_tables.dw_view_links.Retrieve( al_view )
tab_1.tabpage_columns.dw_view_fields.Retrieve( al_view )
tab_1.tabpage_filter.dw_view_where.Retrieve( al_view )



li_rc = tab_1.tabpage_columns.dw_view_fields.RowCount()
FOR i = 1 TO li_rc
	ls_field = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_field" )
	li_found = tab_1.tabpage_columns.dw_fields_list.Find( "table_field = '" + ls_field + "'", 1, 10000 )
	IF li_found > 0 THEN
		tab_1.tabpage_columns.dw_fields_list.DeleteRow( li_found )
	END IF
END FOR

SELECT conv_view.add_rec_id_fld  
INTO :li_add_rec_fld  
FROM conv_view  
WHERE conv_view.view_id = :al_view   ;

IF li_add_rec_fld  = 1 THEN
	//cbx_rec_id.Checked = True
ELSE
	//cbx_rec_id.Checked = False
END IF

SELECT conv_view.distinct_sql
INTO :li_distinct_sql  
FROM conv_view  
WHERE conv_view.view_id = :al_view   ;
*/

gnv_appeondb.of_startqueue( )

IF li_rc > 0 THEN
	tab_1.tabpage_columns.dw_fields_list.Retrieve( ls_table_ids )
	tab_1.tabpage_columns.dw_all_fields.Retrieve( ls_table_ids )
END IF	

tab_1.tabpage_tables.dw_view_links.Retrieve( al_view )
tab_1.tabpage_columns.dw_view_fields.Retrieve( al_view )
tab_1.tabpage_filter.dw_view_where.Retrieve( al_view )

SELECT conv_view.add_rec_id_fld  
INTO :li_add_rec_fld  
FROM conv_view  
WHERE conv_view.view_id = :al_view   ;

SELECT conv_view.distinct_sql
INTO :li_distinct_sql  
FROM conv_view  
WHERE conv_view.view_id = :al_view   ;

gnv_appeondb.of_commitqueue( )

li_rc = tab_1.tabpage_columns.dw_view_fields.RowCount()
FOR i = 1 TO li_rc
	ls_field = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_field" )
	li_found = tab_1.tabpage_columns.dw_fields_list.Find( "table_field = '" + ls_field + "'", 1, 10000 )
	IF li_found > 0 THEN
		tab_1.tabpage_columns.dw_fields_list.DeleteRow( li_found )
	END IF
END FOR

IF li_add_rec_fld  = 1 THEN
	//cbx_rec_id.Checked = True
ELSE
	//cbx_rec_id.Checked = False
END IF

//---------------------------- APPEON END ----------------------------
IF li_distinct_sql  = 1 THEN
	tab_1.tabpage_tables.cbx_distinct.Checked = True
ELSE
	tab_1.tabpage_tables.cbx_distinct.Checked = False
END IF


return 1
end function

public function integer of_retrieve_detail (long al_view);long ll_vid
string ls_name
	
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<comment> 02.07.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Move the following script into the Open event of w_custom_report5 due
//$<modification> to the usage of CreateOnDemand.
//tab_1.tabpage_browse.dw_detail.settransobject(sqlca)
//---------------------------- APPEON END ----------------------------
tab_1.tabpage_browse.dw_detail.retrieve(al_view)
il_view_id = al_view

is_mod_user = tab_1.tabpage_browse.dw_detail.getitemstring(1,"mod_user")
ls_name = tab_1.tabpage_browse.dw_detail.getitemstring(1,"view_name")
this.title = "IntelliReport ( " + ls_name + " )"  //maha 093004

if is_mod_user = "All" then is_mod_user = gs_user_id //if set that any user can modify set to the same as the global user
//messagebox("is_mod_user",is_mod_user)
//messagebox("gs_user_id",gs_user_id)
	tab_1.tabpage_columns.Enabled = false
	tab_1.tabpage_filter.Enabled = false
	tab_1.tabpage_preview.Enabled = false
	tab_1.tabpage_sort.Enabled = false
	tab_1.tabpage_tables.Enabled = false
	tab_1.tabpage_run.Enabled = false
	tab_1.tabpage_browse.cb_next_1.enabled = false

if upper(is_mod_user) <> upper(gs_user_id) then
	tab_1.tabpage_browse.cb_delete.enabled = false
	tab_1.tabpage_browse.dw_detail.enabled = false
	tab_1.tabpage_browse.cb_select.enabled = true	
	tab_1.tabpage_browse.dw_detail.object.category.background.color = 12632256 //grey
	tab_1.tabpage_browse.dw_detail.object.view_name.background.color = 12632256
	tab_1.tabpage_browse.dw_detail.object.mod_user.background.color = 12632256
else
	tab_1.tabpage_browse.cb_delete.enabled = true
	tab_1.tabpage_browse.dw_detail.enabled = true
	tab_1.tabpage_browse.cb_select.enabled = true
	tab_1.tabpage_browse.dw_detail.object.category.background.color = rgb(255,255,255) //white
	tab_1.tabpage_browse.dw_detail.object.view_name.background.color = rgb(255,255,255)
	tab_1.tabpage_browse.dw_detail.object.mod_user.background.color = rgb(255,255,255)
end if



return 1
end function

public function integer of_preview_old (datawindow adw_preview);////this builds the datawindow calls of_build_view_sql()
////messagebox("of_preview","")
//String ls_table_field
//String ls_group_syntax
//String ls_grey
//String ls_align
//String ls_white
//String ls_presentation_str
//String ls_dwsyntax_str
//String ls_sql
//String Errors
//String ls_font
//Integer z
//Integer li_cnt
//Integer li_return
//Integer i
//Integer li_FileNum
//Long ll_last_fld_width
//Long ll_start_position
//Long ll_longest_width
//Long ll_fld_x
//Long ll_last_fld_x
//Long ll_fld_id
//Long ll_fld_width
//String ls_db_nm
//String ls_imp_file_nm
//String ls_data_line
//String ls_data_all
//string ls_syntax //maha 111502
//
//SetPointer( HourGlass! )
//
////This.SetRedraw( False )
//
//ls_sql = of_build_view_sql()
////messagebox("", ls_sql)
////debugbreak()
//
//adw_preview.Reset()
//adw_preview.DataObject = ''
//
////"Style ( Type=value property=value ... )
////	DataWindow ( property=value ... )
////	Column ( property=value ... )
////	Group groupby_colnum1 Fby_colnum2 ... property ... )
////	Text property=value ... )
////	Title ( 'titlestring' )"
////
//
//
////new_syntax = SyntaxFromSQL("SELECT employee_id, salary FROM employee",
////"Style(Type=Group) Group(1)", Error)
//
//
//ls_group_syntax = ""
//
//ls_grey = String(rgb(192,192,192))
//ls_white = String(rgb(255,255,255))
////ls_presentation_str = "style( type=Group) Group(1) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
////IF adw_preview = tab_1.tabpage_preview.dw_preview THEN
//	ls_presentation_str = "style( type=Group) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
////ELSE
////	ls_presentation_str = "style( type=grid ) Group(1) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"	
////END IF
//
////ls_presentation_str = "style( type=grid ) Group(1) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
//
//
////messagebox("", ls_presentation_str)
//ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, &
//	ls_presentation_str, ERRORS)
//
//IF Len(ERRORS) > 0 THEN
//	MessageBox("Caution", &
//	"SyntaxFromSQL caused these errors: " + ERRORS)
//	RETURN -1
//END IF
//
////Open( w_preview_data )
//
//adw_preview.Create( ls_dwsyntax_str, ERRORS)
//
//IF Len(ERRORS) > 0 THEN
//	MessageBox("Caution", &
//	"Create cause these errors: " + ERRORS)
//	RETURN -1
//END IF
//
////ls_syntax = adw_preview.describe("DataWindow.Syntax")
////clipboard(ls_syntax)
////messagebox("",ls_syntax)
//
//
//
//
//
//Integer li_rc
//String ls_label
//String ls_column
//String ls_label_text
//String ls_title
//String ls_x
//String ls_field_allias
//Long ll_width
//
//adw_preview.SetTransObject( SQLCA )
//adw_preview.Modify("DataWindow.Header.Height='420'")
////adw_preview.Modify("DataWindow.Header.width='2857'")
////adw_preview.Modify("DataWindow.Detail.width='2857'")
////adw_preview.Modify("DataWindow.Detail.Height='500'")
//li_rc = tab_1.tabpage_columns.dw_view_fields.RowCount()
//
//ii_col_count = li_rc
//
//
//FOR i = 1 TO li_rc
//	ls_field_allias = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_alias" ) 
//	ls_label = ls_field_allias + "_t"
//	ls_column = ls_field_allias
//	
//	//ls_table_field = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_field" )
//	//ls_table_field = Mid( ls_table_field, POS( ls_table_field, "=" ) + 1 , 1000 )
//	//ls_label = ls_table_field + "_t"
//	//ls_label = Mid( ls_column, 1, POS( ls_column, "." ) -1 ) + "_" + Mid( ls_column, POS( ls_column, "." ) +1, 100 )
//	//messagebox("", ls_column)
//	
//	
////	IF tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "sel_field_id" ) > 0 THEN
////		IF tab_1.tabpage_tables.dw_view_tables.RowCount() > 1 THEN
////			ls_label = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_field" )
////			ls_column	= Mid( ls_label, 1, POS( ls_label, "." )-1 ) + "_" + Mid( ls_label, POS( ls_label, "." ) + 1 , 100 )		
////			ls_label = Mid( ls_label, 1, POS( ls_label, "." )-1 ) + "_" + Mid( ls_label, POS( ls_label, "." ) + 1 , 100 ) + "_t"					
////		ELSE
////			ls_label = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_name" )
////			ls_column  = ls_label			
////			ls_label = ls_label + "_t"
////		END IF
////	ELSE
////		ls_label = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_name" )
////		//ls_label = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "table_field" )
////		ls_column = ls_label
////		ls_label = ls_label + '_t'
////	END IF
////	
//	ls_column = Mid( ls_column, 1, 40 )
//	ls_label = Mid( ls_label, 1, 40 )
//	
//	string ls_return
//	//messagebox("column name 1", adw_preview.describe( "#1.name" ))
//	//messagebox("column name 2", adw_preview.describe( "#2.name" ))
//	//messagebox("column name 3", adw_preview.describe( "#3.name" ))	
//	//messagebox("label variable", ls_label )
//	ls_return = adw_preview.Modify( ls_label + ".y='260'")	
//	//messagebox("return value", ls_return)
//
//	//ls_label_text = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_alias" ) 
//	ls_label_text = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "label_text" ) 
//	adw_preview.Modify( ls_label + ".Text='" + ls_label_text + "'")	
//	
//	adw_preview.Modify( ls_label + ".height='120'")		
//
//	adw_preview.Modify( ls_label + ".Border='1'")		
//
//	is_label_name[i] = adw_preview.Describe( ls_label + ".name")			
//	is_column_name[i] = adw_preview.Describe( ls_column + ".name")			
//	adw_preview.Modify( ls_label + ".tag ='" + String( i ) + "'")			
//	adw_preview.Modify( ls_column + ".tag ='" + String( i ) + "'")			
//	
//	//adw_preview.Modify(ls_column + ".Border='2'")
//	
//	IF IsNull( tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_display_width" ) ) OR +&
//		tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_display_width" ) = ""  THEN		
//		ll_width = Long( adw_preview.Describe( ls_column + ".width") )
//		tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_display_width", String( ll_width ) )	
//	ELSE
//		ll_width = Long(tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_display_width" ))
//		//adw_preview.Modify( ls_label + ".width ='" + String( ll_width ) + "'")			
//		//adw_preview.Modify( ls_column + ".width ='" + String( ll_width ) + "'")			
//	END IF
//
//	IF tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_visible" ) = 0 THEN				
//		ll_width = 0
//	END IF
//	adw_preview.Modify( ls_label + ".width ='" + String( ll_width ) + "'")			
//	adw_preview.Modify( ls_column + ".width ='" + String( ll_width ) + "'")			
//
//
//
//		IF IsNull( tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ) ) OR +&
//			tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ) = 0  THEN
//			//Messagebox("", "field_x = 0")
//			IF NOT ib_new THEN
//				//MessageBox("", "not new" )
//				ll_last_fld_x = 0
//				FOR z = 1 TO li_rc
//					ll_fld_x = tab_1.tabpage_columns.dw_view_fields.GetItemNumber( z, "field_x" ) 

//					IF ll_fld_x > ll_last_fld_x THEN
//						ll_last_fld_x = ll_fld_x
//						ll_last_fld_width = Long( tab_1.tabpage_columns.dw_view_fields.GetItemString( z, "field_display_width" ) )
//					END IF
//				END FOR
//				ls_x = String( ll_last_fld_x + ll_last_fld_width + 20 )
//				tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_x", ll_last_fld_x + ll_last_fld_width + 20 )			
//				adw_preview.Modify( ls_label + ".x ='"  + ls_x  + "'")			
//				adw_preview.Modify( ls_column + ".x ='" + ls_x  + "'")										
//			ELSE	
//				ls_x = adw_preview.Describe( ls_column + ".x") 
//				tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_x", Long(ls_x)  )
//			END IF
//		ELSE
//			ls_x = String(tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ))
//			adw_preview.Modify( ls_label + ".x ='"  + ls_x  + "'")			
//			adw_preview.Modify( ls_column + ".x ='" + ls_x  + "'")					
//			tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_x", Long(ls_x)  )								
//		END IF	
//
//
//END FOR
//
//ls_title = tab_1.tabpage_browse.dw_report_list.GetItemString( tab_1.tabpage_browse.dw_report_list.GetRow(), "view_name" )
//
//IF tab_1.tabpage_browse.dw_report_list.GetItemString( tab_1.tabpage_browse.dw_report_list.GetRow(), "orientation" ) =  "P" THEN
//	adw_preview.Modify("DataWindow.Print.Orientation= '2'")
//	tab_1.tabpage_preview.rb_p.Checked = True
//	tab_1.tabpage_preview.rb_l.Checked = False	
//ELSE
//	adw_preview.Modify("DataWindow.Print.Orientation= '1'")	
//	tab_1.tabpage_preview.rb_p.Checked = False
//	tab_1.tabpage_preview.rb_l.Checked = True	
//END IF
//
//if len(is_facility_name) > 0 then
//	is_facility_name = " :  " + is_facility_name
//end if
//
//adw_preview.Modify("create text(band=header text='Report: " + ls_title + is_facility_name +"' border='0' color='0' x='10' y='10' height='60' width='2000'  font.face='MS Sans Serif' font.height='-11' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title1_t" )
//adw_preview.Modify("create text(band=header text='Date: " + String( Today() ) + "' border='0' color='0' x='10' y='80' height='60' width='1400'  font.face='MS Sans Serif' font.height='-11' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title2_t" )
//adw_preview.Modify("create text(band=header text='Filter: " + is_filter + "' border='0' color='0' x='10' y='150' height='60' width='1400'  font.face='MS Sans Serif' font.height='-11' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title3_t" )
//
//
//ls_syntax = adw_preview.describe("DataWindow.Syntax")
////clipboard(ls_syntax)
////messagebox("",ls_syntax)
//
//
//adw_preview.Create(ls_syntax)
//adw_preview.settransobject(sqlca)
//
//
//
//IF adw_preview = tab_1.tabpage_run.dw_run OR ii_with_data = 1 THEN
//	adw_preview.Retrieve()
//END IF
//
//
//tab_1.tabpage_preview.st_left.BorderStyle = StyleRaised!
//tab_1.tabpage_preview.st_center.BorderStyle = StyleRaised!
//tab_1.tabpage_preview.st_right.BorderStyle = StyleRaised!		
//tab_1.tabpage_preview.st_f_left.BorderStyle = StyleRaised!
//tab_1.tabpage_preview.st_f_center.BorderStyle = StyleRaised!
//tab_1.tabpage_preview.st_f_right.BorderStyle = StyleRaised!		
//
//IF IsNull( tab_1.tabpage_browse.dw_report_list.GetItemNumber( tab_1.tabpage_browse.dw_report_list.GetRow(), "font_size" ) ) THEN
//	ls_font = Mid( adw_preview.Describe( is_column_name[ 1 ] + ".Font.Height" ),2,100)	
//	tab_1.tabpage_preview.em_font.Text = ls_font
//ELSE
//	ls_font = String( tab_1.tabpage_browse.dw_report_list.GetItemNumber( tab_1.tabpage_browse.dw_report_list.GetRow(), "font_size" ))
//	tab_1.tabpage_preview.em_font.Text = ls_font
//END IF
//
//FOR i = 1 TO ii_col_count
//	adw_preview.Modify( is_column_name[ i ] + ".Font.Face='MS Sans Serif'")		
//	adw_preview.Modify( is_column_name[ i ] + ".Font.Height='-" + ls_font + "'")	
//	adw_preview.Modify( is_label_name[ i ] + ".Font.Height='-" + ls_font + "'")	
//	IF adw_preview.Describe( is_column_name[ i ] + ".coltype" ) = "datetime" THEN
//		adw_preview.SetFormat( is_column_name[ i ], "mm/dd/yyyy" )
//	END IF	
//	ls_align = String( tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_align" )	)
//	adw_preview.Modify( is_column_name[ i ] + ".alignment = '" + ls_align + "'" )		
//	ls_align = String( tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "label_align" )	)
//	adw_preview.Modify( is_label_name[ i ] + ".alignment = '" + ls_align + "'" )			
//END FOR
//
//
//IF adw_preview.Title = "" THEN
//	adw_preview.Modify("DataWindow.Print.Preview=No")
//ELSE
//	adw_preview.Modify("DataWindow.Print.Preview=Yes")
//END IF
//
////adw_preview.Modify("DataWindow.Print.Preview.Rulers=Yes")
//
////messagebox("", adw_preview.Describe("DataWindow.Syntax") )
//
//adw_preview.Modify("DataWindow.Grid.Lines='1'" )
//debugbreak()
////This.SetRedraw( True )
//
//
Return 0
//
//
end function

public function integer of_preview (datawindow adw_preview, datawindow adw_rpt_hdr);String ls_font

pfc_cst_u_reports nvo_report_obj

nvo_report_obj = CREATE pfc_cst_u_reports

istr_intellireport ls_data

is_report_type =  tab_1.tabpage_browse.dw_detail.GetItemString( tab_1.tabpage_browse.dw_detail.GetRow(), "report_type" ) 

IF ib_preview THEN
	nvo_report_obj.of_intellireport_preview( il_view_id, tab_1.tabpage_preview.dw_preview, ib_preview, ib_new, ii_with_data, is_facility_name, is_filter, is_sort_synt, ib_group_report, is_report_type,  ii_facil_security, ii_dept_security_on   )
ELSE
	nvo_report_obj.of_intellireport_preview( il_view_id, tab_1.tabpage_run.dw_run, ib_preview, ib_new, ii_with_data, is_facility_name, is_filter, is_sort_synt, ib_group_report, is_report_type,  ii_facil_security, ii_dept_security_on   )	
END IF
is_column_name[] = nvo_report_obj.is_column_name[]
is_label_name[] = nvo_report_obj.is_label_name[]
ii_col_count = nvo_report_obj.ii_col_count

tab_1.tabpage_preview.st_left.BorderStyle = StyleRaised!
tab_1.tabpage_preview.st_center.BorderStyle = StyleRaised!
tab_1.tabpage_preview.st_right.BorderStyle = StyleRaised!		
tab_1.tabpage_preview.st_f_left.BorderStyle = StyleRaised!
tab_1.tabpage_preview.st_f_center.BorderStyle = StyleRaised!
tab_1.tabpage_preview.st_f_right.BorderStyle = StyleRaised!		
tab_1.tabpage_preview.st_normal.BorderStyle = StyleRaised!
tab_1.tabpage_preview.st_bold.BorderStyle = StyleRaised!
tab_1.tabpage_preview.st_italic.BorderStyle = StyleRaised!
tab_1.tabpage_preview.st_underline.BorderStyle = StyleRaised!

IF tab_1.tabpage_browse.dw_detail.GetItemString( tab_1.tabpage_browse.dw_detail.GetRow(), "orientation" ) =  "P" THEN
	adw_preview.Modify("DataWindow.Print.Orientation= '2'")
	tab_1.tabpage_preview.rb_p.Checked = True
	tab_1.tabpage_preview.rb_l.Checked = False	
ELSE
	adw_preview.Modify("DataWindow.Print.Orientation= '1'")	
	tab_1.tabpage_preview.rb_p.Checked = False
	tab_1.tabpage_preview.rb_l.Checked = True	
END IF

IF IsNull( tab_1.tabpage_browse.dw_detail.GetItemNumber( tab_1.tabpage_browse.dw_detail.GetRow(), "font_size" ) ) THEN
	ls_font = MidA( tab_1.tabpage_browse.dw_detail.Describe( is_column_name[ 1 ] + ".Font.Height" ),2,100)	
	tab_1.tabpage_preview.em_font.Text = ls_font
ELSE
	ls_font = String( tab_1.tabpage_browse.dw_detail.GetItemNumber( tab_1.tabpage_browse.dw_detail.GetRow(), "font_size" ))
	tab_1.tabpage_preview.em_font.Text = ls_font
END IF


Return 1

DESTROY nvo_report_obj;

//////string ls_valid
//////ls_valid = dw_composite.Object.rpt_employee. Object.emp_id.Validation
////
//////dwsyntax = dw_1.Describe("DataWindow.Syntax")
//////rtncode = LibraryImport("c:\pb\dwTemp.pbl", &
//////"d_emp", ImportDataWindow!, &
//////dwsyntax, ErrorBuffer, &
//////"Employee DataWindow 1")
////
//////LibraryDelete("c:\pb\dwTemp.pbl", "d_emp", ImportDataWindow!)
////
//////this builds the datawindow calls of_build_view_sql()
//////messagebox("of_preview","")
////String ls_profile_title
////String ls_header_height
////String ls_detail_height
////String ls_fld_y
////String ls_y
////String ls_return
////String ls_font_style
////String ls_orientation
////String ls_width
////String ls_retval
////String ls_label
////String ls_column
////String ls_label_text
////String ls_title
////String ls_x
////String ls_field_allias
////String ls_table_field
////String ls_group_syntax
////String ls_grey
////String ls_align
////String ls_white
////String ls_presentation_str
////String ls_dwsyntax_str
////String ls_sql
////String Errors
////String ls_font
////String ls_agg_type[]
////String ls_agg_fld_nm[]
////String ls_aggregate
////String ls_agg_fld_num[ ]
////Integer f
////Integer li_agg_cnt[]
////Integer li_agg_sum[]
////Integer li_agg_avg[]
////Integer li_agg_cnt_1
////Integer li_agg_sum_1
////Integer li_agg_avg_1
////integer res
////Integer li_grp_agg
////Integer li_sum_agg
////Integer ls_agg_fld_x[]
////Integer li_rc
////Integer z
////Integer li_cnt
////Integer li_return
////Integer i
////Integer li_FileNum
////Integer li_aggregate_cnt
////Long ll_label_width
////Long ll_total_field_width
////Long ll_sum_agg_y
////Long ll_cnt_agg_y
////Long ll_avg_agg_y
////Long ll_width
////Long ll_last_fld_width
////Long ll_start_position
////Long ll_longest_width
////Long ll_fld_x
////Long ll_fld_y
////Long ll_label_y
////Long ll_last_fld_x
////Long ll_fld_id
////Long ll_fld_width
////String ls_agg_fld_width[ ]
////String ls_db_nm
////String ls_imp_file_nm
////String ls_data_line
////String ls_data_all
////string ls_syntax //maha 111502
////
////
////ib_group_report = False
////tab_1.tabpage_preview.st_normal.BorderStyle = StyleRaised!
////tab_1.tabpage_preview.st_bold.BorderStyle = StyleRaised!
////tab_1.tabpage_preview.st_italic.BorderStyle = StyleRaised!
////tab_1.tabpage_preview.st_underline.BorderStyle = StyleRaised!
////
////
////is_report_type = adw_rpt_hdr.GetItemString(1, "report_type" )
////
////IF IsNull( is_report_type ) OR is_report_type = "" THEN
////	is_report_type = "List"
////END IF
////
////
////SetPointer( HourGlass! )
////
////ls_sql = of_build_view_sql()
////
////adw_preview.Reset()
////adw_preview.DataObject = ''
////
////li_rc = tab_1.tabpage_columns.dw_view_fields.RowCount()
////ii_col_count = li_rc
////
////ls_group_syntax = "Group("
////FOR i = 1 TO li_rc
////	IF tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "group_by_field" ) = 1 THEN
////		ls_group_syntax = ls_group_syntax + String( i ) + ","
////		ib_group_report = True
////	END IF
////END FOR
////ls_group_syntax = Mid( ls_group_syntax, 1 ,Len( ls_group_syntax )-1)
////ls_group_syntax = ls_group_syntax + ")"
////
////FOR i = 1 TO li_rc
////	ls_aggregate = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "aggregate_type" ) 
////	IF NOT IsNull( ls_aggregate ) AND ls_aggregate <> "None" THEN
////		li_aggregate_cnt ++
////		ls_agg_fld_nm[ li_aggregate_cnt ] = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_name" ) 
////		ls_agg_fld_x[ li_aggregate_cnt ] = tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ) 		
////		ls_agg_type[li_aggregate_cnt ] = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "aggregate_type" )
////		ls_agg_fld_num[ li_aggregate_cnt ] = String( i )
////		IF tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "count_fld" ) > 0 THEN
////			li_agg_cnt[li_aggregate_cnt] = 1
////			li_agg_cnt_1 = 1
////		ELSE
////			li_agg_cnt[li_aggregate_cnt] = 0
////		END IF
////		IF tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "sum_fld" ) > 0 THEN
////			li_agg_sum[li_aggregate_cnt] = 1
////			li_agg_sum_1 = 1
////		ELSE
////			li_agg_sum[li_aggregate_cnt] = 0			
////		END IF		
////		IF tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "avg_fld" ) > 0 THEN
////			li_agg_avg[li_aggregate_cnt] = 1
////			li_agg_avg_1 = 1
////		ELSE
////			li_agg_avg[li_aggregate_cnt] = 0			
////		END IF		
////	END IF
////END FOR
////
//////Messagebox("", li_aggregate_cnt) 
////
////ls_grey = String(rgb(192,192,192))
////ls_white = String(rgb(255,255,255))
////IF is_report_type = "Profile" THEN
////	ls_presentation_str = "style( type=Form) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=0 Background.Color=" + ls_white + ")"	
////ELSEIF ib_group_report then
////	ls_presentation_str = "style( type=Group ) " + ls_group_syntax + " Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
////ELSE
////	ls_presentation_str = "style( type=Group) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"	
////END IF
////
////ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
////
////IF Len(ERRORS) > 0 THEN
////	MessageBox("Caution", "SyntaxFromSQL caused these errors: " + ERRORS)
////	RETURN -1
////END IF
////
////adw_preview.Create( ls_dwsyntax_str, ERRORS)
////
////IF Len(ERRORS) > 0 THEN
////	MessageBox("Caution", &
////	"Create cause these errors: " + ERRORS)
////	RETURN -1
////END IF
////
////adw_preview.SetTransObject( SQLCA )
////
////FOR i = 1 TO li_rc
////	ls_field_allias = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_alias" ) 
////	ls_label = ls_field_allias + "_t"
////	ls_column = ls_field_allias
////	
////
////	ls_column = Mid( ls_column, 1, 40 )
////	ls_label = Mid( ls_label, 1, 40 )
////	
////	ls_label_text = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "label_text" ) 	
////
////	adw_preview.Modify( ls_label + ".Text='" + ls_label_text + "'")	
////	
////	IF is_report_type <> "Profile" AND is_report_type <> "Form" THEN
////		ls_return = adw_preview.Modify( ls_label + ".y='260'")	
////		adw_preview.Modify( ls_label + ".height='120'")		
////		adw_preview.Modify( ls_label + ".Border='1'")		
////	END IF
////
////	is_label_name[i] = adw_preview.Describe( ls_label + ".name")			
////	is_column_name[i] = adw_preview.Describe( ls_column + ".name")			
////	adw_preview.Modify( ls_label + ".tag ='" + String( i ) + "'")			
////	adw_preview.Modify( ls_column + ".tag ='" + String( i ) + "'")			
////	
////	IF adw_preview = tab_1.tabpage_preview.dw_preview THEN	
////		adw_preview.Modify(ls_column + ".Border='2'")
////	END IF
////	
////	IF IsNull( tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_display_width" ) ) OR +&
////		tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_display_width" ) = ""  THEN		
////		ll_width = Long( adw_preview.Describe( ls_column + ".width") )
////		tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_display_width", String( ll_width ) )	
////	ELSE
////		ll_width = Long(tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_display_width" ))
////	END IF
////	
////	IF is_report_type = "Profile" OR is_report_type = "Form" THEN
////		IF IsNull( tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "label_width" ) ) OR +&
////			tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "label_width" ) = ""  THEN		
////			ll_label_width = Long( adw_preview.Describe( ls_label + ".width") )
////			tab_1.tabpage_columns.dw_view_fields.SetItem( i, "label_width", String( ll_label_width ) )	
////		ELSE
////			ll_label_width = Long(tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "label_width" ))
////		END IF	
////	END IF
////
////	IF tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_visible" ) = 0 THEN				
////		ll_width = 0
////	END IF
////	
////	IF is_report_type = "Profile" OR is_report_type = "Form" THEN
////		adw_preview.Modify( ls_label + ".width ='" + String( ll_label_width ) + "'")			
////		adw_preview.Modify( ls_column + ".width ='" + String( ll_width ) + "'")				
////	ELSE
////		adw_preview.Modify( ls_label + ".width ='" + String( ll_width ) + "'")			
////		adw_preview.Modify( ls_column + ".width ='" + String( ll_width ) + "'")			
////	END IF
////
////
////		IF is_report_type = "Profile" OR is_report_type = "Form" THEN
////
////			IF IsNull( tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "label_x" ) ) OR +&
////				tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "label_x" ) = 0  THEN
////				ls_x =  adw_preview.Describe( ls_label + ".x") 
////				tab_1.tabpage_columns.dw_view_fields.SetItem( i, "label_x", Long(ls_x)  )								
////			ELSE
////				ls_x = String(tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "label_x" ))
////				adw_preview.Modify( ls_label + ".x ='" + ls_x  + "'")					
////			END IF	
////
////			IF IsNull( tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ) ) OR +&
////				tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ) = 0  THEN
////				ls_x =  adw_preview.Describe( ls_column + ".x") 
////				tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_x", Long(ls_x)  )								
////			ELSE
////				ls_x = String(tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ))
////				adw_preview.Modify( ls_column + ".x ='" + ls_x  + "'")					
////			END IF	
////			
////			
////		ELSE
////			IF IsNull( tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ) ) OR +&
////				tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ) = 0  THEN
////				//Messagebox("", "field_x = 0")
////				IF NOT ib_new THEN
////					//MessageBox("", "not new" )
////					ll_last_fld_x = 0
////					FOR z = 1 TO li_rc
////						ll_fld_x = tab_1.tabpage_columns.dw_view_fields.GetItemNumber( z, "field_x" ) 
////						IF ll_fld_x > ll_last_fld_x THEN
////							ll_last_fld_x = ll_fld_x
////							ll_last_fld_width = Long( tab_1.tabpage_columns.dw_view_fields.GetItemString( z, "field_display_width" ) )
////						END IF
////					END FOR
////					ls_x = String( ll_last_fld_x + ll_last_fld_width + 20 )
////					tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_x", ll_last_fld_x + ll_last_fld_width + 20 )			
////					adw_preview.Modify( ls_label + ".x ='"  + ls_x  + "'")			
////					adw_preview.Modify( ls_column + ".x ='" + ls_x  + "'")										
////				ELSE	
////					ls_x = adw_preview.Describe( ls_column + ".x") 
////					tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_x", Long(ls_x)  )
////				END IF
////			ELSE
////				ls_x = String(tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_x" ))
////				adw_preview.Modify( ls_label + ".x ='"  + ls_x  + "'")			
////				adw_preview.Modify( ls_column + ".x ='" + ls_x  + "'")					
////				tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_x", Long(ls_x)  )								
////			END IF	
////			
////		END IF
////
////
////		
////		
////		//y coord
////		IF IsNull( tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_y" ) ) OR +&
////			tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_y" ) = 0  THEN
////				ls_fld_y = adw_preview.Describe( ls_column + ".y") 
////				tab_1.tabpage_columns.dw_view_fields.SetItem( i, "field_y", Long(ls_fld_y)  )
////				
////				ls_y = adw_preview.Describe( ls_label + ".y") 
////				tab_1.tabpage_columns.dw_view_fields.SetItem( i, "label_y", Long(ls_y)  )
////				
////		ELSE
////			ls_fld_y = String(tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_y" ))
////			adw_preview.Modify( ls_column + ".y ='" + ls_fld_y  + "'")					
////
////			
////			ls_y = String(tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "label_y" ))
////			adw_preview.Modify( ls_label + ".y ='"  + ls_y  + "'")						
////		END IF	
////		
////		
//////		debugbreak()
////		IF adw_preview = tab_1.tabpage_preview.dw_preview THEN	
////			IF tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "group_by_field" ) = 1 THEN
////				IF ii_with_data = 0 THEN
////					ls_retval = adw_preview.Modify('create text(band=Header.1 alignment="0" text="' + ls_column + '" border="0" color="0" x="' + ls_x + '" y="12" height="83" width="' + String( ll_width ) + '"  name=' + ls_column + '_label font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				END IF
////			ELSE
////				//IF is_report_type = "Profile" OR is_report_type = "Form" THEN
////				//	ll_width = ll_label_width
////				//END IF
////				IF ii_with_data = 0 THEN
////					ls_retval = adw_preview.Modify('create text(band=Detail alignment="0" text="' + ls_column + '" border="0" color="0" x="' + ls_x + '" y="' + ls_fld_y + '" height="83" width="' + String( ll_width ) + '"  name=' + ls_column + '_label font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field								
////				END IF
////			END IF
////			adw_preview.Modify( ls_column + "_label.tag ='" + String( i ) + "'")			
////		END IF
////		
////		ls_font_style = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "label_font_style" )
////		
////		IF Pos( ls_font_style,"B" ) > 0 THEN
////			adw_preview.Modify( ls_label + ".font.weight ='700'")			
////		END IF
////		
////		IF POS( ls_font_style,"I" ) > 0 THEN
////			adw_preview.Modify( ls_label + ".font.italic ='1'")			
////		END IF
////			
////		IF Pos( ls_font_style,"U" ) > 0 THEN
////			adw_preview.Modify( ls_label + ".font.underline ='1'")			
////		END IF	
////		
////		IF Pos( ls_font_style,"N" ) > 0 THEN
////			adw_preview.Modify( ls_label + ".font.weight ='400'")			
////		END IF	
////		
////		
////		ls_font_style = tab_1.tabpage_columns.dw_view_fields.GetItemString( i, "field_font_style" )
////		
////		IF Pos( ls_font_style,"B" ) > 0 THEN
////			adw_preview.Modify( ls_column + ".font.weight ='700'")							
////			adw_preview.Modify( ls_column + "_label.font.weight ='700'")										
////		END IF
////		
////		IF POS( ls_font_style,"I" ) > 0 THEN
////			adw_preview.Modify( ls_column + ".font.italic ='1'")									
////			adw_preview.Modify( ls_column + "_label.font.italic ='1'")												
////		END IF
////			
////		IF Pos( ls_font_style,"U" ) > 0 THEN
////			adw_preview.Modify( ls_column + ".font.underline ='1'")													
////			adw_preview.Modify( ls_column + "_label.font.underline ='1'")																
////		END IF	
////		
////		IF Pos( ls_font_style,"N" ) > 0 THEN
////			adw_preview.Modify( ls_column + ".font.weight ='400'")							
////			adw_preview.Modify( ls_column + "_label.font.weight ='400'")										
////		END IF	
////			
////		IF adw_preview = tab_1.tabpage_preview.dw_preview AND ii_with_data = 0 THEN			
////			adw_preview.Modify( ls_column + ".border ='2'")												
////		ELSEIF adw_preview = tab_1.tabpage_preview.dw_preview AND ii_with_data = 1 THEN						
////			adw_preview.Modify( ls_column + ".border ='0'")															
////		END IF
////
////
////END FOR
////
////ls_title = adw_rpt_hdr.GetItemString( adw_rpt_hdr.GetRow(), "view_name" )
////
////adw_rpt_hdr.AcceptText()
////
////IF adw_rpt_hdr.GetItemString( adw_rpt_hdr.GetRow(), "orientation" ) =  "P" THEN
////	adw_preview.Modify("DataWindow.Print.Orientation= '2'")
////	tab_1.tabpage_preview.rb_p.Checked = True
////	tab_1.tabpage_preview.rb_l.Checked = False	
////	//ll_total_field_width	 = 3500
////ELSE
////	adw_preview.Modify("DataWindow.Print.Orientation= '1'")	
////	tab_1.tabpage_preview.rb_p.Checked = False
////	tab_1.tabpage_preview.rb_l.Checked = True	
////	//ll_total_field_width	 = 4500	
////END IF
////
////if len(is_facility_name) > 0 then
////	is_facility_name = " :  " + is_facility_name
////end if
////
//////IF ib_group_report THEN
//////	adw_preview.Modify("create text(band=header text='Report: " + ls_title + is_facility_name +"' border='0' color='0' x='10' y='80' height='60' width='2000'  font.face='MS Sans Serif' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title1_t" )
//////	//adw_preview.Modify("create text(band=header text='Date: " + String( Today() ) + "' border='0' color='0' x='10' y='110' height='60' width='1400'  font.face='MS Sans Serif' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title2_t" )
//////	adw_preview.Modify("create text(band=header text='Filter: " + is_filter + "' border='0' color='0' x='10' y='145' height='60' width='1400'  font.face='MS Sans Serif' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title3_t" )
//////ELSE
////IF is_report_type = "Profile" THEN
////	ls_profile_title = String( adw_rpt_hdr.GetItemString( adw_rpt_hdr.GetRow(), "profile_title" ) )	
////	adw_preview.Modify("create text(band=header alignment='2' text='" + ls_profile_title + "' border='0' color='0' x='0' y='0' height='76' width='3333'  font.face='Times New Roman' font.height='-12' font.weight='700'  font.family='1' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name=profile_title" )	
////ELSE
////	adw_preview.Modify("create text(band=header text='Report: " + ls_title +"' border='0' color='0' x='10' y='10' height='60' width='2000'  font.face='MS Sans Serif' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title1_t" )
////	adw_preview.Modify("create text(band=header text='Date: " + String( Today() ) + "' border='0' color='0' x='10' y='80' height='60' width='1400'  font.face='MS Sans Serif' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title2_t" )
////	adw_preview.Modify("create text(band=header text='Filter: " + is_filter + "' border='0' color='0' x='10' y='150' height='130' width='4500'  font.face='MS Sans Serif' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title3_t" )
////END IF
////
////
////ls_syntax = adw_preview.describe("DataWindow.Syntax")
////
////Long ll_begin_pos
////Long ll_end_pos
////String ls_line
////String ls_first_part
////String ls_last_part
////
//////***** set up grouping *****************************
//////openwithparm(w_sql_msg,ls_syntax)
////IF ib_group_report THEN
////	//remove rectangles with no names from group report
////	ll_begin_pos = Pos( ls_syntax, "rectangle" ) -1
////	ls_first_part = Mid( ls_syntax, 1, ll_begin_pos )
////	ll_end_pos = Pos( ls_syntax, ")", ll_begin_pos )
////	ll_end_pos = ll_end_pos - ll_begin_pos +1
////	ls_last_part = Mid( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
////	ls_syntax = ls_first_part + ls_last_part
////
////	ll_begin_pos = Pos( ls_syntax, "rectangle" ) -1
////	ls_first_part = Mid( ls_syntax, 1, ll_begin_pos )
////	ll_end_pos = Pos( ls_syntax, ")", ll_begin_pos )
////	ll_end_pos = ll_end_pos - ll_begin_pos +1
////	ls_last_part = Mid( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
////	ls_syntax = ls_first_part + ls_last_part
////	
////	//remove default computed columns with no names from group report	
////	ll_begin_pos = Pos( ls_syntax, "compute(" ) -1
////	ls_first_part = Mid( ls_syntax, 1, ll_begin_pos )
////	ll_end_pos = Pos( ls_syntax, "no )", ll_begin_pos )+ 3
////	ll_end_pos = ll_end_pos - ll_begin_pos +1
////	ls_last_part = Mid( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
////	ls_syntax = ls_first_part + ls_last_part
////
////	ll_begin_pos = Pos( ls_syntax, "compute(" ) -1
////	ls_first_part = Mid( ls_syntax, 1, ll_begin_pos )
////	ll_end_pos = Pos( ls_syntax, "no )", ll_begin_pos ) + 3
////	ll_end_pos = ll_end_pos - ll_begin_pos +1
////	ls_last_part = Mid( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
////	ls_syntax = ls_first_part + ls_last_part	
////	
////	ll_begin_pos = Pos( ls_syntax, "compute(" ) -1
////	IF ll_begin_pos > 0 THEN
////		ls_first_part = Mid( ls_syntax, 1, ll_begin_pos )
////		ll_end_pos = Pos( ls_syntax, "no )", ll_begin_pos ) + 3
////		ll_end_pos = ll_end_pos - ll_begin_pos +1
////		ls_last_part = Mid( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
////		ls_syntax = ls_first_part + ls_last_part		
////	END IF
////
////	ll_begin_pos = Pos( ls_syntax, "compute(" ) -1
////	IF ll_begin_pos > 0 THEN	
////		ls_first_part = Mid( ls_syntax, 1, ll_begin_pos )
////		ll_end_pos = Pos( ls_syntax, "no )", ll_begin_pos ) + 3
////		ll_end_pos = ll_end_pos - ll_begin_pos +1
////		ls_last_part = Mid( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
////		ls_syntax = ls_first_part + ls_last_part			
////	END IF
////	
////END IF	
////	
////adw_preview.Create(ls_syntax)
////adw_preview.settransobject(sqlca)
////adw_preview.InsertRow( 0 )
////
////////get the width of all fields together
////FOR i = 1 TO 100
////	ls_width = adw_preview.Describe( "#" + String( i ) + ".width" )
////	IF IsNumber( ls_width ) THEN
////		ll_total_field_width = ll_total_field_width + Long( ls_width )
////	END IF
////	FOR f = 1 TO li_aggregate_cnt
////		IF ls_agg_fld_num[ f ] = String( i ) THEN
////			ls_agg_fld_width[ f ] = ls_width 
////		END IF
////	END FOR
////END FOR
////
////ll_total_field_width = ll_total_field_width + 100
////ls_orientation = adw_rpt_hdr.GetItemString( adw_rpt_hdr.GetRow(), "orientation" )
////IF ls_orientation = "P" and ll_total_field_width > 3500 THEN
////	ll_total_field_width = 3500
////ELSEIF ls_orientation = "L" and ll_total_field_width > 4500 then
////	ll_total_field_width = 4500
////END IF
////
////
////
////
//////debugbreak()
////IF li_aggregate_cnt > 0 THEN
////	FOR i = 1 TO li_aggregate_cnt
////		//if there is a count or sum funtion at the GROUP level then put in space for calc field
////		IF ls_agg_type[i] = "GL" or ls_agg_type[I] = "GLSL" THEN
////			li_grp_agg = 1
////			CHOOSE CASE li_agg_cnt_1 + li_agg_sum_1 + li_agg_avg_1
////				CASE 1
////					adw_preview.Modify("DataWindow.trailer.1.Height='100'")	
////				CASE 2
////					adw_preview.Modify("DataWindow.trailer.1.Height='200'")						
////				CASE 3					
////					adw_preview.Modify("DataWindow.trailer.1.Height='300'")						
////			END CHOOSE
////		END IF			
////		//if there is a count or sum funtion at the SUMMARY level then put in space for calc field
////		IF ls_agg_type[i] = "SL" or ls_agg_type[I] = "GLSL" THEN
////			li_sum_agg = 1
////			CHOOSE CASE li_agg_cnt_1 + li_agg_sum_1 + li_agg_avg_1
////				CASE 1
////					adw_preview.Modify("DataWindow.Summary.Height='100'")	
////				CASE 2
////					adw_preview.Modify("DataWindow.Summary.Height='200'")						
////				CASE 3					
////					adw_preview.Modify("DataWindow.Summary.Height='300'")						
////			END CHOOSE
////		END IF					
////	END FOR
////
////	IF li_grp_agg = 1 THEN
////		IF li_agg_sum_1 = 1 THEN
////			li_cnt++
////			IF li_cnt = 1 THEN
////				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Sum "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=group_sum_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
////				ll_sum_agg_y = 22				
////			ELSEIF li_cnt = 2 THEN
////				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Sum "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=group_sum_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_sum_agg_y = 108				
////			ELSE
////				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Sum "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=group_sum_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_sum_agg_y = 195								
////			END IF
////		END IF
////
////		IF li_agg_cnt_1 = 1 THEN
////			li_cnt++
////			IF li_cnt = 1 THEN
////				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Count "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=group_count_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
////				ll_cnt_agg_y = 22								
////			ELSEIF li_cnt = 2 THEN
////				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Count "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=group_count_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_cnt_agg_y = 108							
////			ELSE
////				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Count "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=group_count_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_cnt_agg_y = 195							
////			END IF
////		END IF		
////		
////		IF li_agg_avg_1 = 1 THEN
////			li_cnt++
////			IF li_cnt = 1 THEN
////				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Average "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=group_avg_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
////				ll_avg_agg_y = 22								
////			ELSEIF li_cnt = 2 THEN
////				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Average "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=group_avg_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_avg_agg_y = 108
////			ELSE
////				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Average "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=group_avg_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_avg_agg_y = 195							
////			END IF
////		END IF				
////	END IF
////	
////	li_cnt = 0
////	IF li_sum_agg = 1 THEN
////		IF li_agg_sum_1 = 1 THEN
////			li_cnt++
////			IF li_cnt = 1 THEN
////				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Sum "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_sum_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
////				ll_sum_agg_y = 22
////			ELSEIF li_cnt = 2 THEN
////				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Sum "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_sum_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_sum_agg_y = 108
////			ELSE
////				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Sum "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_sum_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_sum_agg_y = 195			
////			END IF
////		END IF
////
////		IF li_agg_cnt_1 = 1 THEN
////
////			li_cnt++
////			IF li_cnt = 1 THEN
////				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Count "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_count_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
////				ll_cnt_agg_y = 22
////			ELSEIF li_cnt = 2 THEN
////				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Count "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_count_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_cnt_agg_y = 108
////			ELSE
////				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Count "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_count_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_cnt_agg_y = 195
////			END IF
////		END IF		
////		
////		IF li_agg_avg_1 = 1 THEN
////			li_cnt++
////			IF li_cnt = 1 THEN
////				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Average "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_avg_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
////				ll_avg_agg_y = 22
////			ELSEIF li_cnt = 2 THEN
////				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Average "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_avg_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_avg_agg_y = 108
////			ELSE
////				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Average "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_avg_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
////				ll_avg_agg_y = 195
////			END IF
////		END IF				
////	END IF	
////	
//////	messagebox("agg count", li_aggregate_cnt )
////	FOR i = 1 TO li_aggregate_cnt
////		IF ls_agg_fld_x[i] < 100 THEN  // added ls_agg_fld_x[1] < 400, hope this doesnt screw up things.
////			ls_agg_fld_x[i] = ls_agg_fld_x[i] + 400
////		END IF
////		
////		//count
////		IF (ls_agg_type[i] = "GL" OR ls_agg_type[I] = "GLSL") AND li_agg_cnt[i] = 1 THEN
////			ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="count(#' + ls_agg_fld_num[i] + ' for group 1)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_cnt_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '" format="#,##0"  name=group_count  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
////		END IF
////		IF (ls_agg_type[i] = "SL" OR ls_agg_type[I] = "GLSL") AND li_agg_cnt[i] = 1 THEN
////			ls_retval = adw_preview.Modify('create compute(band=summary alignment="0" expression="Count(#' + ls_agg_fld_num[i] + ' for all )"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_cnt_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '" format="#,##0"  name=summary_count  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
////		END IF
////		
////		//sum
////		IF (ls_agg_type[i] = "GL" OR ls_agg_type[I] = "GLSL") AND li_agg_sum[i] = 1 THEN
////			ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="sum(#' + ls_agg_fld_num[i] + ' for group 1)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_sum_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '" format="#,##0"  name=group_sum  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
////		END IF
////		IF (ls_agg_type[i] = "SL" OR ls_agg_type[I] = "GLSL") AND li_agg_sum[i] = 1 THEN
////			ls_retval = adw_preview.Modify('create compute(band=Summary alignment="0" expression="sum(#' + ls_agg_fld_num[i] + ' for all)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_sum_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=summary_sum  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
////		END IF		
////		
////		//averge
////		IF (ls_agg_type[i] = "GL" OR ls_agg_type[I] = "GLSL") AND li_agg_avg[i] = 1 THEN
////			ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="Avg(#' + ls_agg_fld_num[i] + ' for group 1)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_avg_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=group_avg  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
////		END IF		
////		IF (ls_agg_type[i] = "SL" OR ls_agg_type[I] = "GLSL") AND li_agg_avg[i] = 1 THEN
////			ls_retval = adw_preview.Modify('create compute(band=Summary alignment="0" expression="Avg(#' + ls_agg_fld_num[i] + ' for all)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_avg_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=sumary_avg  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
////		END IF				
////	END FOR
////END IF
////
//////ls_grp_fld_nm
//////ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Calc 1 "border="0" color="0" x="25" y="30" height="166" width="1302"  name=group_1_header_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field
//////ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="count(#1 for group 1)"border="0" color="0" x="' + ls_agg_fld_width[i] + '"  y="11" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=summary_count_group_1  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )
//////ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Calc 2 "border="0" color="0" x="600" y="30" height="166" width="1302"  name=group_1_header_text  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field
//////ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="count(#2 for group 1 )"border="0" color="0" x="750" y="11" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=summary_count_group_1  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )
//////ls_retval = adw_preview.Modify('create compute(band=Summary alignment="0" expression="count(#1 for all)"border="1" color="0" x="500" y="8" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=summary_count_group_1  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )
////
//////******************  retrieve data ********************
////IF adw_preview = tab_1.tabpage_run.dw_run OR ii_with_data = 1 THEN
////	adw_preview.Retrieve()
////END IF
////IF ib_group_report THEN
////	res = adw_preview.setsort(is_sort_synt)
////	if res < 1 then messagebox("","Sort Error")
////	adw_preview.sort()
////	adw_preview.groupcalc()
////end if
////
////tab_1.tabpage_preview.st_left.BorderStyle = StyleRaised!
////tab_1.tabpage_preview.st_center.BorderStyle = StyleRaised!
////tab_1.tabpage_preview.st_right.BorderStyle = StyleRaised!		
////tab_1.tabpage_preview.st_f_left.BorderStyle = StyleRaised!
////tab_1.tabpage_preview.st_f_center.BorderStyle = StyleRaised!
////tab_1.tabpage_preview.st_f_right.BorderStyle = StyleRaised!		
////
////IF IsNull( adw_rpt_hdr.GetItemNumber( adw_rpt_hdr.GetRow(), "font_size" ) ) THEN
////	ls_font = Mid( adw_preview.Describe( is_column_name[ 1 ] + ".Font.Height" ),2,100)	
////	tab_1.tabpage_preview.em_font.Text = ls_font
////ELSE
////	ls_font = String( adw_rpt_hdr.GetItemNumber( adw_rpt_hdr.GetRow(), "font_size" ))
////	tab_1.tabpage_preview.em_font.Text = ls_font
////END IF
////
////FOR i = 1 TO ii_col_count
////	adw_preview.Modify( is_column_name[ i ] + ".Font.Face='MS Sans Serif'")		
////	adw_preview.Modify( is_column_name[ i ] + ".Font.Height='-" + ls_font + "'")	
////	adw_preview.Modify( is_label_name[ i ] + ".Font.Height='-" + ls_font + "'")	
////	IF adw_preview.Describe( is_column_name[ i ] + ".coltype" ) = "datetime" THEN
////		adw_preview.SetFormat( is_column_name[ i ], "mm/dd/yyyy" )
////	END IF	
////	ls_align = String( tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "field_align" )	)
////	adw_preview.Modify( is_column_name[ i ] + ".alignment = '" + ls_align + "'" )		
////	ls_align = String( tab_1.tabpage_columns.dw_view_fields.GetItemNumber( i, "label_align" )	)
////	adw_preview.Modify( is_label_name[ i ] + ".alignment = '" + ls_align + "'" )			
////END FOR
////
////
////IF adw_preview.Title = "" THEN
////	adw_preview.Modify("DataWindow.Print.Preview=No")
////ELSE
////	adw_preview.Modify("DataWindow.Print.Preview=Yes")
////END IF
////
////adw_preview.Modify("DataWindow.Grid.Lines='1'" )
////
////
////IF is_report_type = "Profile" OR is_report_type = "Form" THEN
////	IF ib_new THEN
////		adw_preview.Modify( "DataWindow.Header.Height='90'" )
////	   adw_rpt_hdr.SetItem( adw_rpt_hdr.GetRow(), "header_height", 90 ) 
////		IF adw_preview = tab_1.tabpage_preview.dw_preview THEN
////			ls_Return = adw_preview.Modify("create rectangle(band=header x='0' y='80' height='10' width='3500' brush.hatch='6' brush.color='0' pen.style='5' pen.width='10' pen.color='553648127'  background.mode='1' background.color='553648127' name=Header )")
////		END IF
////	ELSE
////		ls_header_height = String( adw_rpt_hdr.GetItemNumber( adw_rpt_hdr.GetRow(), "header_height" ) )
////		adw_preview.Modify("DataWindow.Header.Height='" + ls_header_height + "'")				
////		ls_header_height = String( Long( ls_header_height )-10 )	
////		IF adw_preview = tab_1.tabpage_preview.dw_preview THEN
////			ls_Return = adw_preview.Modify("create rectangle(band=header x='0' y='" + ls_header_height + "' height='10' width='3500' brush.hatch='6' brush.color='0' pen.style='5' pen.width='10' pen.color='553648127'  background.mode='1' background.color='553648127' name=Header )")		
////		ELSE
////			
////		END IF
////	END IF
////ELSE
////	adw_preview.Modify("DataWindow.Header.Height='400'")	
////END IF
////
////adw_preview.Modify("DataWindow.Detail.Height.AutoSize=Yes")
////
////IF ib_new THEN
////	ls_detail_height = adw_preview.Describe( "DataWindow.Detail.Height" )
////	adw_rpt_hdr.SetItem( adw_rpt_hdr.GetRow(), "detail_height", Long( ls_detail_height ) )		
////	ls_detail_height = String( Long( ls_detail_height )-10 )
////ELSE
////	ls_detail_height = String( adw_rpt_hdr.GetItemNumber( adw_rpt_hdr.GetRow(), "detail_height" ) )
////	adw_preview.Modify("Datawindow.Detail.Height='" + ls_detail_height + "'" )	
////	ls_detail_height = String( Long( ls_detail_height )-10 )	
////END IF
////
////IF adw_preview = tab_1.tabpage_preview.dw_preview THEN
////	ls_Return = adw_preview.Modify("create rectangle(band=detail x='0' y='" + ls_detail_height + "' height='10' width='3500' brush.hatch='6' brush.color='0' pen.style='5' pen.width='10' pen.color='553648127'  background.mode='1' background.color='553648127' name=Detail )")
////END IF
////
//
Return 0
//
//
end function

protected function integer of_get_next_ids ();SELECT Max( table_id )  
INTO :il_next_table_id  
FROM conv_view_table;

IF IsNull( il_next_table_id ) THEN
	il_next_table_id = 1
END IF

SELECT Max( link_id )  
INTO :il_next_link_id  
FROM conv_view_links;

IF IsNull( il_next_link_id ) THEN
	il_next_link_id = 1
END IF


SELECT Max( sort_id )  
INTO :il_next_sort_id  
FROM conv_view_sort;

IF IsNull( il_next_sort_id ) THEN
	il_next_sort_id = 1
END IF


SELECT Max( field_id )  
INTO :il_next_field_id  
FROM conv_view_fields;

IF IsNull( il_next_field_id ) THEN
	il_next_field_id = 1
END IF

SELECT Max( where_id )  
INTO :il_next_where_id  
FROM conv_view_where;

IF IsNull( il_next_where_id ) THEN
	il_next_where_id = 1
END IF

Return 0
end function

on w_custom_report5.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_15=create cb_15
this.cb_8=create cb_8
this.cb_qhelp=create cb_qhelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_15
this.Control[iCurrent+3]=this.cb_8
this.Control[iCurrent+4]=this.cb_qhelp
end on

on w_custom_report5.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_15)
destroy(this.cb_8)
destroy(this.cb_qhelp)
end on

event open;call super::open;long ll_view

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 02.07.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<reason> Collect Datawindow for retrieving data and integrate them into Appeon Queue Labels 
//$<reason> to reduce client-server interactions to improve runtime performance.
DataWindowChild dwchild

tab_1.tabpage_browse.dw_report_list.of_SetTransObject(SQLCA)
tab_1.tabpage_tables.dw_select_table.SetTransObject( SQLCA )
tab_1.tabpage_browse.dw_detail.SetTransObject( sqlca )
tab_1.tabpage_browse.dw_detail.GetChild( "mod_user", dwchild )
dwchild.settransobject(sqlca)

gnv_appeonDb.of_StartQueue()
tab_1.tabpage_browse.dw_report_list.Retrieve()
tab_1.tabpage_tables.dw_select_table.Retrieve()
dwchild.retrieve()
gnv_appeonDb.of_CommitQueue()

IF tab_1.tabpage_browse.dw_report_list.RowCount() > 0 THEN
	tab_1.tabpage_browse.dw_report_list.SetRow( 1 )
	tab_1.tabpage_browse.dw_report_list.SelectRow( 0, False )
	tab_1.tabpage_browse.dw_report_list.SelectRow( 1, True )
END IF

dwchild.insertrow(1)
dwchild.setitem(1,"user_id","All")
//---------------------------- APPEON END ----------------------------

IF tab_1.tabpage_browse.dw_report_list.RowCount() > 0 THEN
	ll_view = tab_1.tabpage_browse.dw_report_list.getitemnumber(1,"view_id")
	of_retrieve_detail(ll_view)//maha111902
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 02.07.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
//select set_17 into :ii_facil_security from icred_settings;
ii_facil_security = of_get_app_setting("set_17","I")

//department security
//SELECT set_37
//INTO :ii_dept_security_on
//FROM icred_settings;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("SQL Error", SQLCA.SQLERRTEXT )
//	RETURN 1
//END IF
ii_dept_security_on = of_get_app_setting("set_37","I")
*/
ii_facil_security = Integer( gnv_data.of_getitem( "icred_settings", "set_17", False ))
ii_dept_security_on = Integer( gnv_data.of_getitem( "icred_settings", "set_37", False ))

//Fix a defect of Web application. Rodger Wu on Sept. 6, 2006.
IF Upper( appeongetclienttype()) = "WEB" THEN
	This.Width = 3769
	cb_15.x = 2967
	cb_qhelp.x = 3223
	cb_8.x = 3479
END IF
//---------------------------- APPEON END ----------------------------
end event

event closequery;//nothing
end event

event close;call super::close;garbagecollect()
end event

type tab_1 from tab within w_custom_report5
event create ( )
event destroy ( )
integer x = 27
integer y = 36
integer width = 3534
integer height = 2228
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean fixedwidth = true
boolean raggedright = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_tables tabpage_tables
tabpage_columns tabpage_columns
tabpage_filter tabpage_filter
tabpage_sort tabpage_sort
tabpage_preview tabpage_preview
tabpage_run tabpage_run
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_tables=create tabpage_tables
this.tabpage_columns=create tabpage_columns
this.tabpage_filter=create tabpage_filter
this.tabpage_sort=create tabpage_sort
this.tabpage_preview=create tabpage_preview
this.tabpage_run=create tabpage_run
this.Control[]={this.tabpage_browse,&
this.tabpage_tables,&
this.tabpage_columns,&
this.tabpage_filter,&
this.tabpage_sort,&
this.tabpage_preview,&
this.tabpage_run}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_tables)
destroy(this.tabpage_columns)
destroy(this.tabpage_filter)
destroy(this.tabpage_sort)
destroy(this.tabpage_preview)
destroy(this.tabpage_run)
end on

event selectionchanging;ii_with_data = 0
ib_preview = False
IF newindex = 1 THEN
	//st_help_1.Visible = True
	//st_help_2.Visible = True	
	of_help( "browse", "" )
ELSEIF newindex = 6 THEN
	//of_preview( tab_1.tabpage_preview.dw_preview )
	ib_preview = True	
	ii_with_data = 0
	of_preview( tab_1.tabpage_preview.dw_preview, tab_1.tabpage_browse.dw_detail )	
	//ib_preview_built = True
ELSEIF newindex = 5 THEN     //maha changed from newindex = 5 092402
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-09
	//$<modify> 02.10.2006 By: Rodger Wu
	//$<reason> Performance tuning
	//$<modification> Add a condition to avoid redundant function call in order to
	//$<modification> reduce client-server interactions to improve runtime performance.
	/*	of_save() */
		If Not ( oldindex = 4 and tab_1.tabpage_filter.dw_view_where.Modifiedcount() = 0 ) Then
			of_save()
		End If
	//---------------------------- APPEON END ----------------------------
	//tab_1.tabpage_sort.dw_fields_list_sort.Retrieve( il_view_id )
ELSEIF newindex = 7 THEN
	//st_help_1.Visible = False
	//st_help_2.Visible = False
	tab_1.tabpage_run.st_sql.Text = ""
	tab_1.tabpage_run.st_sql.Visible = False	
	tab_1.tabpage_run.cb_next_run.Enabled = True
	ii_with_data = 1
	of_wizard_setup()
END IF

IF oldindex = 2 THEN
	IF tab_1.tabpage_tables.cbx_distinct.Checked THEN
		UPDATE conv_view
		SET distinct_sql = 1
		WHERE conv_view.view_id = :il_view_id ;
	ELSE
		UPDATE conv_view
		SET distinct_sql = 0
		WHERE conv_view.view_id = :il_view_id ;	
	END IF
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("DB Error", SQLCA.SQLERRTEXT )
	END IF
END IF
	
end event

type tabpage_browse from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3497
integer height = 2100
long backcolor = 79741120
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "PlaceColumn5!"
long picturemaskcolor = 12632256
cb_1 cb_1
cb_select cb_select
dw_report_list dw_report_list
cb_next_1 cb_next_1
cb_delete cb_delete
dw_detail dw_detail
cb_new cb_new
cb_copy cb_copy
cb_6 cb_6
cbx_goto cbx_goto
end type

on tabpage_browse.create
this.cb_1=create cb_1
this.cb_select=create cb_select
this.dw_report_list=create dw_report_list
this.cb_next_1=create cb_next_1
this.cb_delete=create cb_delete
this.dw_detail=create dw_detail
this.cb_new=create cb_new
this.cb_copy=create cb_copy
this.cb_6=create cb_6
this.cbx_goto=create cbx_goto
this.Control[]={this.cb_1,&
this.cb_select,&
this.dw_report_list,&
this.cb_next_1,&
this.cb_delete,&
this.dw_detail,&
this.cb_new,&
this.cb_copy,&
this.cb_6,&
this.cbx_goto}
end on

on tabpage_browse.destroy
destroy(this.cb_1)
destroy(this.cb_select)
destroy(this.dw_report_list)
destroy(this.cb_next_1)
destroy(this.cb_delete)
destroy(this.dw_detail)
destroy(this.cb_new)
destroy(this.cb_copy)
destroy(this.cb_6)
destroy(this.cbx_goto)
end on

type cb_1 from commandbutton within tabpage_browse
boolean visible = false
integer x = 1253
integer y = 1900
integer width = 247
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&New"
end type

event clicked;ib_new = True

of_get_next_ids()

cb_next_1.Enabled = True

Integer li_nr
Long ll_next_view_id  

li_nr = dw_report_list.InsertRow( 0 )

dw_report_list.ScrollToRow( li_nr )
dw_report_list.SetRow( li_nr )
dw_report_list.SetFocus()
dw_report_list.SelectRow( 0, False )
dw_report_list.SelectRow( li_nr, TRue )

cb_next_1.Enabled = True

SELECT Max( view_id )  
INTO :ll_next_view_id  
FROM conv_view  ;

IF IsNull( ll_next_view_id ) THEN
	ll_next_view_id = 1
ELSE
	ll_next_view_id ++
END IF

il_view_id = ll_next_view_id

dw_report_list.SetItem( li_nr, "view_id", ll_next_view_id  )
dw_report_list.SetItem( li_nr, "project_id", ii_project_id )

of_clean_up()

tab_1.tabpage_run.Enabled = False
tab_1.tabpage_preview.Enabled = False
tab_1.tabpage_filter.Enabled = False
tab_1.tabpage_sort.Enabled = False
tab_1.tabpage_columns.Enabled = False
tab_1.tabpage_tables.Enabled = False

tab_1.tabpage_columns.dw_view_fields.Retrieve( il_view_id )

tab_1.tabpage_tables.cbx_distinct.Checked = True
end event

type cb_select from commandbutton within tabpage_browse
integer x = 617
integer y = 1892
integer width = 270
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Select"
end type

event clicked;//dw_report_list.TriggerEvent( doubleClicked! )


Integer li_rc
Integer i
Integer li_found
Integer li_add_rec_fld
Integer li_distinct_sql
String ls_field
String ls_table_ids[]

ib_preview_built = False

ib_new = False

if upper(is_mod_user) = upper(gs_user_id) then //maha 111902
	tab_1.tabpage_columns.Enabled = True
	tab_1.tabpage_filter.Enabled = True
	tab_1.tabpage_preview.Enabled = True
	tab_1.tabpage_sort.Enabled = True
	tab_1.tabpage_tables.Enabled = True
else
	tab_1.tabpage_columns.Enabled = false
	tab_1.tabpage_filter.Enabled = false
	tab_1.tabpage_preview.Enabled = false
	tab_1.tabpage_sort.Enabled = false
	tab_1.tabpage_tables.Enabled = false	
end if

tab_1.tabpage_run.Enabled = True

IF dw_report_list.rowcount() > 0 THEN
	il_view_id = dw_report_list.GetItemNumber( dw_report_list.getrow(), "view_id" )
	
	of_retrieve_report(il_view_id) //code moved 112202 maha
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-10
	//$<modify> 02.09.2006 By: Rodger Wu
	//$<reason> Performance tuning
	//$<modification> Function of_save() has been called within tab_1.selectionchanging and 
	//$<modification> it is unnecessary to call it repeatedly after running tab_1.SelectTab(7).
	/*
	if cbx_goto.checked = true then
		tab_1.SelectTab( 7 )
	else
		tab_1.SelectTab( 2 )
	end if
	of_save() */
	
	if cbx_goto.checked = true then
		tab_1.SelectTab( 7 )
	else
		tab_1.SelectTab( 2 )
		of_save()
	end if
	//---------------------------- APPEON END ----------------------------
END IF
end event

type dw_report_list from u_dw within tabpage_browse
integer x = 55
integer y = 44
integer width = 1760
integer height = 1808
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Select Report"
string dataobject = "d_cust_report_list_w_cat"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<comment> 02.07.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Move the following script to the Open event of w_custom_report5 due to
//$<modification> the usage of CreateOnDemand.
//This.of_SetTransObject(SQLCA)
//This.Retrieve()
//
//IF dw_report_list.RowCount() > 0 THEN
//	dw_report_list.SetRow( 1 )
//	dw_report_list.SelectRow( 0, False )
//	dw_report_list.SelectRow( 1, True )
//
//END IF
//---------------------------- APPEON END ----------------------------
end event

event clicked;call super::clicked;long ll_vid

IF row > 0 THEN
	This.SetRow( row )
	This.SelectRow( 0 , False )
	This.SelectRow( row, True )
	This.ScrollToRow( row )
	
	ll_vid = this.getitemnumber(row,"view_id")
	
	of_retrieve_detail(ll_vid)
//	dw_detail.settransobject(sqlca)
//	dw_detail.retrieve(ll_vid)
//	il_view_id = ll_vid
	
END IF
end event

event doubleclicked;call super::doubleclicked;

Integer li_rc
Integer i
Integer li_found
Integer li_add_rec_fld
Integer li_distinct_sql
String ls_field
String ls_table_ids[]


ib_preview_built = False
ib_new = False

//if upper(is_mod_user) = upper(gs_user_id) then //maha 111902
//	tab_1.tabpage_columns.Enabled = True
//	tab_1.tabpage_filter.Enabled = True
//	tab_1.tabpage_preview.Enabled = True
//	tab_1.tabpage_sort.Enabled = True
//	tab_1.tabpage_tables.Enabled = True
//else
//	tab_1.tabpage_columns.Enabled = false
//	tab_1.tabpage_filter.Enabled = false
//	tab_1.tabpage_preview.Enabled = false
//	tab_1.tabpage_sort.Enabled = false
//	tab_1.tabpage_tables.Enabled = false	
//end if

tab_1.tabpage_run.Enabled = True
tab_1.tabpage_run.dw_run.Reset()

IF row > 0 THEN
	cb_select.TriggerEvent( Clicked! )
//	il_view_id = This.GetItemNumber( row, "view_id" )
//	
//	of_retrieve_report(il_view_id) //code moved 112202 maha
//	
//	tab_1.SelectTab( 7 )
//	
//	of_save()
//	
END IF




end event

event retrieveend;call super::retrieveend;//IF rowcount > 0 THEN
//	cb_select.Enabled = True
//	cb_delete.Enabled = True
//END IF


end event

type cb_next_1 from commandbutton within tabpage_browse
integer x = 3109
integer y = 1892
integer width = 334
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Next ->"
end type

event clicked;integer r
string f

dw_detail.AcceptText()
IF IsNull( dw_detail.GetItemString( 1, "view_name" )) THEN
	MessageBox("Missing Data", "The name of the report must be filled in." )
	dw_detail.SetFocus()
	Return 
END IF
//dw_report_list.Update()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<modify> 02.10.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
dw_detail.Update()
dw_report_list.retrieve()
*/
gnv_appeonDb.of_StartQueue()

dw_detail.Update()
dw_report_list.retrieve()

gnv_appeonDb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------



f = "view_id = " + string(il_view_id)
//messagebox("",f)

r = dw_report_list.find(f,1,dw_report_list.rowcount())
dw_report_list.ScrollToRow( r )
dw_report_list.SetRow( r )
dw_report_list.SelectRow( 0, False )
dw_report_list.SelectRow( r, TRue )


tab_1.tabpage_tables.Enabled = True
tab_1.SelectTab( 2 )
end event

type cb_delete from commandbutton within tabpage_browse
integer x = 334
integer y = 1892
integer width = 270
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Delete"
end type

event clicked;Integer li_view_id
integer res

res = messagebox("Delete Report","Are you sure you want to delete this report?",question!,yesno!,2)

if res = 2 then
	return
end if

IF dw_report_list.RowCount() = 0 THEN
	Return
END IF

li_view_id = dw_detail.GetItemNumber( 1, "view_id" )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<modify> 02.08.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
Delete 
From conv_view_where
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

Delete 
From conv_view_table
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

Delete 
From conv_view_fields
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

Delete 
From conv_view_links
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

Delete 
From conv_view_sort //maha 042202
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

Delete 
From conv_view
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

dw_report_list.Retrieve()
*/

gnv_appeondb.of_StartQueue()
Delete 
From conv_view_where
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	gnv_appeondb.of_CommitQueue()
	Return -1
END IF

Delete 
From conv_view_table
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	gnv_appeondb.of_CommitQueue()
	Return -1
END IF

Delete 
From conv_view_fields
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	gnv_appeondb.of_CommitQueue()
	Return -1
END IF

Delete 
From conv_view_links
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	gnv_appeondb.of_CommitQueue()
	Return -1
END IF

Delete 
From conv_view_sort //maha 042202
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	gnv_appeondb.of_CommitQueue()
	Return -1
END IF

Delete 
From conv_view
Where view_id = :li_view_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Error", SQLCA.SQLERRTEXT )
	gnv_appeondb.of_CommitQueue()
	Return -1
END IF

dw_report_list.Retrieve()
gnv_appeondb.of_CommitQueue()

//---------------------------- APPEON END ----------------------------

IF dw_report_list.RowCount() > 0 THEN
	dw_report_list.SetRow( 1 )
	dw_report_list.SelectRow( 0, False )
	dw_report_list.SelectRow( 1, True )
	li_view_id = dw_report_list.GetItemNumber( 1, "view_id" )
	
	of_retrieve_detail(li_view_id)
END IF
end event

type dw_detail from datawindow within tabpage_browse
integer x = 1833
integer y = 12
integer width = 1655
integer height = 1296
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_cust_report_detail5"
boolean border = false
boolean livescroll = true
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<comment> 02.07.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Move the following script to the Open event of w_custom_report5 due
//$<modification> to the usage of CreateOnDemand.
//DataWindowChild dwchild
//
//This.SetTransObject( sqlca )
//This.GetChild( "mod_user", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve()
//dwchild.insertrow(1)
//dwchild.setitem(1,"user_id","All")
//---------------------------- APPEON END ----------------------------
end event

type cb_new from commandbutton within tabpage_browse
integer x = 55
integer y = 1892
integer width = 270
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&New"
end type

event clicked;Integer li_nr
Long ll_next_view_id
integer i
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-15
//$<modify> 02.08.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<reason> Add a condition to avoid redundant function call in order to 
//$<reason> reduce client-server interactions to improve runtime performance.
/*
	if dw_detail.update() <> 1 then
		return
	end if
	commit using sqlca;
*/

If dw_detail.Modifiedcount() > 0 or dw_detail.DeletedCount() > 0 Then
	if dw_detail.update() <> 1 then
		return
	end if
	//commit using sqlca;
End If
//---------------------------- APPEON END ----------------------------

ib_new = True
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-16
//$<modify> 02.08.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<reason> Collect all SQL statements and integrate them into Appeon Queue Labels 
//$<reason> to Reduce client-server interactions to improve runtime performance.
/*
of_get_next_ids()


li_nr = dw_detail.InsertRow( 1 )

cb_select.Enabled = false
cb_copy.Enabled = false
cb_next_1.Enabled = True

SELECT Max( view_id )  
INTO :ll_next_view_id  
FROM conv_view  ;
*/
gnv_appeondb.of_StartQueue()
li_nr = dw_detail.InsertRow( 1 )

cb_select.Enabled = false
cb_copy.Enabled = false
cb_next_1.Enabled = True

SELECT Max( table_id )  
INTO :il_next_table_id  
FROM conv_view_table;

IF IsNull( il_next_table_id ) THEN
	il_next_table_id = 1
END IF

SELECT Max( link_id )  
INTO :il_next_link_id  
FROM conv_view_links;

IF IsNull( il_next_link_id ) THEN
	il_next_link_id = 1
END IF


SELECT Max( sort_id )  
INTO :il_next_sort_id  
FROM conv_view_sort;

IF IsNull( il_next_sort_id ) THEN
	il_next_sort_id = 1
END IF


SELECT Max( field_id )  
INTO :il_next_field_id  
FROM conv_view_fields;

IF IsNull( il_next_field_id ) THEN
	il_next_field_id = 1
END IF

SELECT Max( where_id )  
INTO :il_next_where_id  
FROM conv_view_where;

IF IsNull( il_next_where_id ) THEN
	il_next_where_id = 1
END IF

SELECT Max( view_id )  
INTO :ll_next_view_id  
FROM conv_view  ;
gnv_appeondb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------

IF IsNull( ll_next_view_id ) THEN
	ll_next_view_id = 1
ELSE
	ll_next_view_id ++
END IF

il_view_id = ll_next_view_id

dw_detail.SetItem( li_nr, "view_id", ll_next_view_id  )
dw_detail.SetItem( li_nr, "project_id", ii_project_id )
dw_detail.SetItem( li_nr, "create_date", datetime(today(),now()) )
dw_detail.SetItem( li_nr, "created_by", gs_user_id )
dw_detail.SetItem( li_nr, "mod_user", "All" )

of_clean_up()

tab_1.tabpage_run.Enabled = False
tab_1.tabpage_preview.Enabled = False
tab_1.tabpage_filter.Enabled = False
tab_1.tabpage_sort.Enabled = False
tab_1.tabpage_columns.Enabled = False
tab_1.tabpage_tables.Enabled = False
tab_1.tabpage_browse.dw_detail.enabled = true
dw_detail.object.category.background.color = rgb(255,255,255) //white
dw_detail.object.view_name.background.color = rgb(255,255,255)
dw_detail.object.mod_user.background.color = rgb(255,255,255)
//	tab_1.tabpage_columns.Enabled = True
//	tab_1.tabpage_filter.Enabled = True
//	tab_1.tabpage_preview.Enabled = True
//	tab_1.tabpage_sort.Enabled = True
//	tab_1.tabpage_tables.Enabled = True

tab_1.tabpage_columns.dw_view_fields.Retrieve( il_view_id )

tab_1.tabpage_tables.cbx_distinct.Checked = True

dw_detail.SetFocus( )
dw_detail.SetColumn( "view_name" )
dw_detail.SetRow( li_nr )
end event

type cb_copy from commandbutton within tabpage_browse
integer x = 901
integer y = 1892
integer width = 270
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Copy"
end type

event clicked;integer res
n_ds lds_view
n_ds lds_table
n_ds lds_link
n_ds lds_field
n_ds lds_filter
n_ds lds_sort
long ll_next_view_id
long ll_null
string ls_null
string ls_name
integer i
integer ic
integer ck = 0 

res = messagebox("Copy report","Are you sure you wish to copy this report?",question!,yesno!,1)

if res = 2 then 
	return
end if

IF dw_report_list.rowcount() > 0 THEN
	
	ls_name = dw_detail.getitemstring(1,"view_name")
	ls_name = "Copy of " + ls_name
	//$<modify> 05.14.2008 by Andy
	ls_name = MidA(ls_name,1,100)//30

	setnull(ll_null)
	setnull(ls_null)
	SELECT Max( view_id )  
	INTO :ll_next_view_id  
	FROM conv_view  ;

	of_retrieve_report(il_view_id)

	IF IsNull( ll_next_view_id ) THEN
		ll_next_view_id = 1
	ELSE
		ll_next_view_id ++
	END IF
	
	il_view_id = ll_next_view_id
	
	
 

	lds_view = CREATE n_ds
	//$<modify> 05.14.2008 by Andy							  
	lds_view.DataObject = "d_cust_report_detail5"//d_cust_report_detail
	lds_view.of_SetTransObject( SQLCA )
	
	lds_table = CREATE n_ds
	//$<modify> 05.14.2008 by Andy
	lds_table.DataObject = "d_conv_view_tables_report5"//d_conv_view_tables_report
	lds_table.of_SetTransObject( SQLCA )
	
	lds_link = CREATE n_ds
	lds_link.DataObject = "d_conv_view_links"
	lds_link.of_SetTransObject( SQLCA )
	
	lds_field = CREATE n_ds
	//$<modify> 05.14.2008 by Andy
	lds_field.DataObject = "d_view_selected_fields5"//d_view_selected_fields
	lds_field.of_SetTransObject( SQLCA )
	
	lds_filter = CREATE n_ds
	//$<modify> 05.14.2008 by Andy
	lds_filter.DataObject = "d_view_where5"//d_view_where
	lds_filter.of_SetTransObject( SQLCA )
	
	lds_sort = CREATE n_ds
	lds_sort.DataObject = "d_cust_report_sort"
	lds_sort.of_SetTransObject( SQLCA )
	
	//copy view
	tab_1.tabpage_browse.dw_detail.RowsCopy (1, 1, primary!, lds_view, 500, primary! )
	for i = 1 to lds_view.rowcount()
		lds_view.setitem(i,"view_id",il_view_id)
		lds_view.setitem(i,"view_name",ls_name)
		//lds_view.setitem(i,"category",ls_null)
		lds_view.setitem(i,"mod_user",gs_user_id)
		lds_view.setitem(i,"created_by",gs_user_id)
		lds_view.setitem(i,"create_date",datetime(today(),now()))
	next
	
	//copy tables
	tab_1.tabpage_tables.dw_view_tables.RowsCopy (1, tab_1.tabpage_tables.dw_view_tables.rowcount(), primary!, lds_table, 500, primary! )
	//ic = tab_1.tabpage_tables.dw_view_tables.rowcount()
	//messagebox("table",ic)
	//return

	for i = 1 to lds_table.rowcount()
		il_next_table_id++
		lds_table.setitem(i,"view_id",il_view_id)
		lds_table.setitem(i,"table_id",il_next_table_id)
	next
	
	//copy links
	tab_1.tabpage_tables.dw_view_links.RowsCopy (1, tab_1.tabpage_tables.dw_view_links.rowcount(), primary!, lds_link, 500, primary! )
	for i = 1 to lds_link.rowcount()
		il_next_link_id++
		lds_link.setitem(i,"view_id",il_view_id)
		lds_link.setitem(i,"link_id",il_next_link_id)
	next
	
	//copy fields
	tab_1.tabpage_columns.dw_view_fields.RowsCopy (1, tab_1.tabpage_columns.dw_view_fields.rowcount(), primary!, lds_field, 500, primary! )
	for i = 1 to lds_field.rowcount()
		il_next_field_id++
		lds_field.setitem(i,"view_id",il_view_id)
		lds_field.setitem(i,"field_id",il_next_field_id)
	next
	
		//copy filter
	tab_1.tabpage_filter.dw_view_where.RowsCopy (1, tab_1.tabpage_filter.dw_view_where.rowcount(), primary!, lds_filter, 500, primary! )
	for i = 1 to lds_filter.rowcount()
		il_next_where_id++
		lds_filter.setitem(i,"view_id",il_view_id)
		lds_filter.setitem(i,"where_id",il_next_where_id)
	next

		//copy sort
	tab_1.tabpage_sort.dw_view_sort.RowsCopy (1, tab_1.tabpage_sort.dw_view_sort.rowcount(), primary!, lds_sort, 500, primary! )
	for i = 1 to lds_sort.rowcount()
		il_next_sort_id++
		lds_sort.setitem(i,"view_id",il_view_id)
		lds_sort.setitem(i,"sort_id",il_next_sort_id)
	next

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-17
//$<modify> 02.09.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<reason> Use Appeon Datawindow Batch Update function and 
//$<modification> Add Appeon Update label to reduce client-server interactions to improve runtime performance.

/*
	if lds_table.update() = 1 then
		if	lds_link.update() = 1 then
			if lds_field.update() = 1 then
				if lds_filter.update() = 1 then
					if lds_sort.update() = 1 then
						if lds_view.update() = 1 then
							commit using sqlca;
							ck = 1
						else
							messagebox("Save error", "Error Saving VIEW.  Copy not saved.")
						end if
					else
						messagebox("Save error", "Error Saving SORT.  Copy not saved.")
					end if
				else
					messagebox("Save error", "Error Saving FILTER.  Copy not saved.")
				end if
			else
				messagebox("Save error", "Error Saving FIELDS.  Copy not saved.")
			end if
		else
			messagebox("Save error", "Error Saving LINKS.  Copy not saved.")
		end if
	else
		messagebox("Save error", "Error Saving TABLE.  Copy not saved.")
	end if
					
	if ck = 1 then
		of_retrieve_detail(il_view_id)
		of_retrieve_report(il_view_id)
		dw_report_list.retrieve()
*/
	Integer li_return
	li_return = gnv_appeonDb.of_Update( lds_table, lds_link, lds_field )
	If li_return = -101 Then
		messagebox("Save error", "Error Saving TABLE.  Copy not saved.")
	Elseif li_return = -102 Then
		messagebox("Save error", "Error Saving LINKS.  Copy not saved.")
	Elseif li_return = -103 Then
		messagebox("Save error", "Error Saving FIELDS.  Copy not saved.")
	Else
		li_return = gnv_appeonDb.of_Update( lds_filter, lds_sort, lds_view )
		If li_return = -101 Then
			messagebox("Save error", "Error Saving FILTER.  Copy not saved.")
		Elseif li_return = -102 Then
			messagebox("Save error", "Error Saving SORT.  Copy not saved.")
		Elseif li_return = -103 Then
			messagebox("Save error", "Error Saving VIEW.  Copy not saved.")
		Else
			ck = 1
		End If
	End If

	if ck = 1 then
		gnv_appeondb.of_StartQueue()
		dw_report_list.retrieve()
		of_retrieve_detail(il_view_id)
		gnv_appeondb.of_CommitQueue()
		
		of_retrieve_report(il_view_id)
//---------------------------- APPEON END ----------------------------		
		ic = dw_report_list.find("view_id = " + string(il_view_id),1 ,dw_report_list.rowcount())
		if ic > 0 then
			dw_report_list.scrolltorow(ic)
			dw_report_list.setrow(ic)
			dw_report_list.selectrow(0,false)
			dw_report_list.selectrow(ic,true)
		else
			messagebox("Find error","")
		end if
	end if
END IF
//messagebox("","This function not complete")
end event

type cb_6 from commandbutton within tabpage_browse
integer x = 1184
integer y = 1892
integer width = 270
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-18
//$<modify> 02.10.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
dw_detail.update()
commit using sqlca;
dw_report_list.retrieve()
*/
gnv_appeonDb.of_StartQueue()

dw_detail.update()
commit using sqlca;
dw_report_list.retrieve()

gnv_appeonDb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------
end event

type cbx_goto from checkbox within tabpage_browse
integer x = 1742
integer y = 1884
integer width = 434
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Preview Report"
boolean checked = true
end type

type tabpage_tables from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3497
integer height = 2100
boolean enabled = false
long backcolor = 79741120
string text = "Tables"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DataWindow!"
long picturemaskcolor = 12632256
dw_select_table dw_select_table
dw_view_links dw_view_links
cb_view_add_tbl cb_view_add_tbl
cb_view_del_tbl cb_view_del_tbl
cb_next_2 cb_next_2
cb_view_del_link cb_view_del_link
cb_view_add_link cb_view_add_link
cb_9 cb_9
cb_5 cb_5
cbx_distinct cbx_distinct
dw_view_tables dw_view_tables
end type

on tabpage_tables.create
this.dw_select_table=create dw_select_table
this.dw_view_links=create dw_view_links
this.cb_view_add_tbl=create cb_view_add_tbl
this.cb_view_del_tbl=create cb_view_del_tbl
this.cb_next_2=create cb_next_2
this.cb_view_del_link=create cb_view_del_link
this.cb_view_add_link=create cb_view_add_link
this.cb_9=create cb_9
this.cb_5=create cb_5
this.cbx_distinct=create cbx_distinct
this.dw_view_tables=create dw_view_tables
this.Control[]={this.dw_select_table,&
this.dw_view_links,&
this.cb_view_add_tbl,&
this.cb_view_del_tbl,&
this.cb_next_2,&
this.cb_view_del_link,&
this.cb_view_add_link,&
this.cb_9,&
this.cb_5,&
this.cbx_distinct,&
this.dw_view_tables}
end on

on tabpage_tables.destroy
destroy(this.dw_select_table)
destroy(this.dw_view_links)
destroy(this.cb_view_add_tbl)
destroy(this.cb_view_del_tbl)
destroy(this.cb_next_2)
destroy(this.cb_view_del_link)
destroy(this.cb_view_add_link)
destroy(this.cb_9)
destroy(this.cb_5)
destroy(this.cbx_distinct)
destroy(this.dw_view_tables)
end on

type dw_select_table from datawindow within tabpage_tables
integer x = 50
integer y = 44
integer width = 1221
integer height = 1164
integer taborder = 30
string dragicon = "AppRectangle!"
boolean titlebar = true
string title = "2. Select Tables To Use In View"
string dataobject = "d_table_names_report"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-19
//$<comment> 02.07.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Move the following script into the Open event of w_custom_report5 due
//$<modification> to the usage of CreateOnDemand.
//This.SetTransObject( SQLCA )
//This.Retrieve( )
//---------------------------- APPEON END ----------------------------
end event

event itemchanged;//Integer li_Rc
//Integer i
//String ls_table_ids[]
//String ls_table_name
//Long ll_table_id
//
//li_rc = dw_view_tables.RowCount()
//
//
//cb_view_save.PostEvent( Clicked! )
//
end event

event clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
	is_drag_object = "select table"	
	This.Drag(Begin! )	
END IF
end event

event doubleclicked;Integer li_nr
Integer li_row
Long ll_field_id
Long ll_max_x
Long ll_width

li_row = dw_select_table.GetRow( )

IF li_row > 0 THEN
	li_nr = dw_view_tables.Insertrow( 0 )

	il_next_table_id++
	dw_view_tables.SetItem( li_nr, "project_id", ii_project_id )
	dw_view_tables.SetItem( li_nr, "view_id", il_view_id )	
	dw_view_tables.SetItem( li_nr, "cust_table_name", dw_select_table.GetItemNumber( li_row, "table_id" ) )		
	dw_view_tables.SetItem( li_nr, "table_id", il_next_table_id )
	dw_view_tables.SetItem( li_nr, "table_real_name", dw_select_table.GetItemString( li_row, "table_name" ) )			
	dw_select_table.Deleterow( li_row )
	dw_view_tables.AcceptText()
	dw_view_tables.Update( )

END IF



end event

event dragdrop;if dw_view_tables.GetRow() > 0 AND is_drag_object = "deselect table" then
	dw_view_tables.DeleteRow( dw_view_tables.GetRow() )
	of_save()
end if
end event

type dw_view_links from datawindow within tabpage_tables
integer x = 46
integer y = 1240
integer width = 3401
integer height = 604
integer taborder = 40
boolean titlebar = true
string title = "3. Create View Table Links"
string dataobject = "d_conv_view_links"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event buttonclicked;String ls_name
String ls_table_name
String ls_obj_nm
Long ll_obj_id



ls_name = dwo.name

IF ls_name = "from_table" OR ls_name = "to_table" THEN
	OpenWithParm( w_conv_select_table, il_view_id )
	IF Message.StringParm = "Cancel" THEN
		Return
	END IF
	ls_obj_nm = MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1, 1000 )
	ll_obj_id = Long( MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" ) -1 ) )
	if isnull(ll_obj_id) or ll_obj_id = 0 then return //trap maha 061703
	IF ls_name = "from_table"  THEN
		dw_view_links.SetItem( row, "link_from_table_nm", ls_obj_nm )
		dw_view_links.SetItem( row, "link_from_table", ll_obj_id )	
	ELSE
		dw_view_links.SetItem( row, "link_to_table_nm", ls_obj_nm )
		dw_view_links.SetItem( row, "link_to_table", ll_obj_id )			
	END IF
ELSEIF ls_name = "from_field" OR ls_name = "to_field" THEN
	IF ls_name = "from_field"  THEN
		ls_table_name = This.GetItemString( row, "link_from_table_nm" )
		//ll_obj_id = This.GetItemNumber( row, "link_from_table" )
	ELSE
		ls_table_name = This.GetItemString( row, "link_to_table_nm" )		
		//ll_obj_id = This.GetItemNumber( row, "link_to_table" )		
	END IF
	OpenWithParm( w_conv_select_fields, ls_table_name )
	IF Message.StringParm = "Cancel" THEN
		Return
	END IF
	ls_obj_nm = MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1, 1000 )
	ll_obj_id = Long( MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" ) -1 ) )
	if isnull(ll_obj_id) or ll_obj_id = 0 then return //trap maha 061703
	IF ls_name = "from_field"  THEN
		dw_view_links.SetItem( row, "link_from_field_nm", ls_obj_nm )
		dw_view_links.SetItem( row, "link_from_field", ll_obj_id )	
	ELSE
		dw_view_links.SetItem( row, "link_to_field_nm", ls_obj_nm )
		dw_view_links.SetItem( row, "link_to_field", ll_obj_id )			
	END IF	
END IF
end event

event constructor;This.SetTransObject( SQLCA )
end event

event getfocus;DatawindowChild dwchild

//IF This.GetColumnName() = "link_from_table" OR This.GetColumnName() = "link_to_table" THEN
	This.GetChild( "link_from_table", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( il_view_id )

	This.GetChild( "link_to_table", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( il_view_id )	
//END IF
end event

event itemfocuschanged;//DatawindowChild dwchild
//Long li_table_id
//
//debugbreak()
//
////IF This.GetColumnName() = "link_from_field" OR This.GetColumnName() = "link_to_field" THEN
////	li_table_id = This.GetItemNumber( row, "link_from_table" )
////	This.GetChild( "link_from_field", dwchild )
////	dwchild.SetTransObject( SQLCA )
////	//dwchild.Retrieve( li_table_id )
////	IF Not IsNull( li_table_id ) THEN	
//		dwchild.SetFilter( "id = " + String( li_table_id ) )
//		dwchild.Filter( )
//	END IF
//
//	li_table_id = This.GetItemNumber( row, "link_to_table" )
//	This.GetChild( "link_to_field", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	//dwchild.Retrieve( li_table_id )
//	IF Not IsNull( li_table_id ) THEN
//		dwchild.SetFilter( "id = " + String( li_table_id ) )
//		dwchild.Filter( )
//	END IF
//END IF
end event

event clicked;integer i

i = this.getclickedrow()

if i > 0 then
	this.setrow(i)
end if
end event

type cb_view_add_tbl from commandbutton within tabpage_tables
boolean visible = false
integer x = 1349
integer y = 1136
integer width = 384
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Table"
end type

event clicked;Integer li_nr

li_nr = dw_view_tables.InsertRow( 0 )
dw_view_tables.SetRow( li_nr )
dw_view_tables.ScrollToRow( li_nr )

il_next_table_id++

dw_view_tables.SetItem( li_nr, "table_id", il_next_table_id )
dw_view_tables.SetItem( li_nr, "view_id", il_view_id )
dw_view_tables.SetItem( li_nr, "project_id", ii_project_id )

dw_view_tables.SetFocus( )


end event

type cb_view_del_tbl from commandbutton within tabpage_tables
boolean visible = false
integer x = 1760
integer y = 1140
integer width = 384
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete Table"
end type

event clicked;Long ll_table_id

ll_table_id = dw_view_tables.GetItemNumber( dw_view_tables.GetRow(), "cust_table_name" ) 

dw_view_tables.DeleteRow( 0 )

DELETE FROM conv_view_links  
WHERE ( conv_view_links.link_from_table = :ll_table_id  OR  
       conv_view_links.link_to_table = :ll_table_id ) AND  
      ( conv_view_links.view_id = :il_view_id )   ;
	 
	 
of_save()



end event

type cb_next_2 from commandbutton within tabpage_tables
integer x = 3109
integer y = 1888
integer width = 334
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Next ->"
end type

event clicked;integer i
string ls_def
integer p
integer a = 0
long t
string ls_tname


IF dw_view_tables.RowCount() = 0 THEN
	MessageBox( "Tables", "You must select at least one table to report on." )
	Return 
END IF

IF dw_view_tables.RowCount() > 1 AND dw_view_links.RowCount() = 0  THEN
	MessageBox( "Links", "You have more than 1 table selected but no links.  Please link the tables in the Create View Table Links Box." )
	Return 
END IF

IF dw_view_tables.RowCount() - 1   > dw_view_links.RowCount()  THEN //maha 111902
	MessageBox( "Linking Error", "You do not have enough links for the number of tables selected.  Please verify all tables are linked." )
	Return 
END IF


IF of_save() = -1 THEN
	Return -1
END IF


if ii_facil_security = 1 then
	for i = 1 to dw_view_tables.RowCount()
		ls_tname = dw_view_tables.getitemstring(i,"table_name")
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2005-11-11 By: owen chen
		//$<reason> add database option for sql excution
		choose case gs_dbtype
			case 'ASA'
				select view_def into :ls_def from systable where table_name = :ls_tname;
			case 'SQL'
				select view_def into :ls_def from v_systable where table_name = :ls_tname;
		end choose
		//---------------------------- APPEON END ----------------------------
		
		if  PosA(ls_def,"pd_affil_stat",1) > 0 then
			a = 1
		end if
	next
	
	if a = 0 then 
		messagebox("Table Select error","Facility Security is turned on so the v_affil_stat must be used in all reports.")
		return -1
	end if
end if

a=0

//if department security is turned on then do this.
if ii_dept_security_on = 1 then
	for i = 1 to dw_view_tables.RowCount()
		ls_tname = dw_view_tables.getitemstring(i,"table_name")
		//messagebox("", ls_tname)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2005-11-11 By: owen chen
		//$<reason> add database option for sql excution
		choose case gs_dbtype
			case 'ASA'
				select view_def into :ls_def from systable where table_name = :ls_tname;
			case 'SQL'
				select view_def into :ls_def from v_systable where table_name = :ls_tname;
		end choose
		//---------------------------- APPEON END ----------------------------
		
		if  PosA(ls_def,"pd_affil_dept",1) > 0 then
			a = 1
		end if
	next
	
	if a = 0 then 
		messagebox("Table Select error","Department Security is turned on so the v_affil_dept must be used in all reports.")
		return -1
	end if
end if


//dw_view_tables.Update()
//dw_view_links.Update()

tab_1.tabpage_columns.Enabled = True


tab_1.SelectTab( 3 )



end event

type cb_view_del_link from commandbutton within tabpage_tables
integer x = 841
integer y = 1892
integer width = 384
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete Link"
end type

event clicked;dw_view_links.DeleteRow( 0 )
end event

type cb_view_add_link from commandbutton within tabpage_tables
integer x = 443
integer y = 1892
integer width = 384
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Link"
end type

event clicked;Integer li_nr

dw_view_tables.Update()

li_nr = dw_view_links.InsertRow( 0 )
dw_view_links.SetRow( li_nr )
dw_view_links.ScrollToRow( li_nr )

il_next_link_id++

dw_view_links.SetItem( li_nr, "link_id", il_next_link_id )
dw_view_links.SetItem( li_nr, "view_id", il_view_id )
dw_view_links.SetItem( li_nr, "project_id", ii_project_id )

ii_nr = li_nr

dw_view_links.SetFocus( )


end event

type cb_9 from commandbutton within tabpage_tables
integer x = 46
integer y = 1892
integer width = 384
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Auto Link"
end type

event clicked;Integer li_nr
Integer li_ans
Integer li_rc
Integer i
Integer li_link_row
Integer li_prac_link_cnt = 0
Long ll_tid
Integer li_table_id
String ls_table_name
String ls_first_table_name
string ls_view
Boolean lb_affil_stat_allready_linked = False
Boolean lb_affil_stat
Boolean lb_dept
Boolean lb_staff_cat
Boolean lb_basic
Boolean lb_address
Boolean lb_address_link

dw_view_tables.AcceptText()
dw_view_tables.Update()
dw_view_tables.Retrieve( il_view_id )

li_rc = dw_view_links.RowCount()
IF li_rc > 0 THEN
	li_ans = MessageBox("Links", "This option will delete any links that currently exist.  Continue?", Question!, YesNo!, 1 )
	IF li_ans = 2 THEN
		Return
	END IF
	FOR i = 1 TO li_rc
		dw_view_links.DeleteRow( 0 )
	END FOR
	dw_view_links.Update( )
END IF

li_rc = dw_view_tables.RowCount()
IF li_rc = 1 THEN
	MessageBox( "Link Failure", "You need to select at least 2 tables to use the Auto Link Function." )
	Return
END IF

ls_first_table_name = dw_view_tables.GetItemString( 1, "table_name" )


//analyze the tables that are selected
FOR i = 1 TO li_rc
	ls_table_name = dw_view_tables.GetItemString( i, "table_name" )
	IF ls_table_name = "v_dept" OR ls_table_name = "v_staff_cat" OR ls_table_name = "v_staff_leave"  OR ls_table_name = "v_committee_review" OR +&
		ls_table_name = "v_net_dev_actions" OR ls_table_name = "v_net_dev_ids" OR ls_table_name = "v_net_dev_notes"  OR ls_table_name = "v_action_items" THEN
		IF dw_view_tables.Find( "table_name = 'v_affil_stat'", 1, 1000 ) = 0 THEN
			IF ls_table_name = "v_action_items" THEN
				li_ans = MessageBox( "Table Selection", "Will you be using the v_action_items table to report on data for a specific facility? If so you must have the v_affil_stat table selected also so you can link to the parent OR verifying facility field.  Would you like to add this now?", StopSign!, YesNo!, 1 )				
			ELSE
				li_ans = MessageBox( "Table Selection", "To use the " + Upper( ls_table_name ) + " table you must have the v_affil_stat table selected also.  Would you like to add this now?", StopSign!, YesNo!, 1 )
			END IF
			IF li_ans = 1 THEN
				lb_affil_stat	= True
				li_nr = dw_view_tables.InsertRow( 0 )			
				SELECT id
				INTO :ll_tid
				FROM dbo.sysobjects
				WHERE name = 'v_affil_stat' ;
				dw_view_tables.SetItem( li_nr, "table_name", "v_affil_stat" )				
				dw_view_tables.SetItem( li_nr, "cust_table_name", ll_tid )
				dw_view_tables.SetItem( li_nr, "view_id", il_view_id )
				dw_view_tables.SetItem( li_nr, "project_id", ii_project_id )
				il_next_table_id++				
				dw_view_tables.SetItem( li_nr, "table_id", il_next_table_id )				
			ELSE
				Return
			END IF
		ELSE
			lb_affil_stat	= True
		END IF
		CONTINUE
	END IF
	IF ls_table_name = "v_address" OR ls_table_name = "v_mailing_address" THEN
		IF dw_view_tables.Find( "table_name = 'v_address_link'", 1, 1000 ) = 0 THEN		
			li_ans = MessageBox( "Table Selection", "You have selected the " + ls_table_name + " table.  If you want to query addresses by ADDRESS TYPE (Primary, Additional, Billing etc.) then you should include the v_address_link table.  Would you like to add this table now?", StopSign!, YesNo!, 1 )
			IF li_ans = 1 THEN
				lb_address_link = True
				li_nr = dw_view_tables.InsertRow( 0 )			
				SELECT id
				INTO :ll_tid
				FROM dbo.sysobjects
				WHERE name = 'v_address_link' ;
				dw_view_tables.SetItem( li_nr, "table_name", "v_address_link" )				
				dw_view_tables.SetItem( li_nr, "cust_table_name", ll_tid )
				dw_view_tables.SetItem( li_nr, "view_id", il_view_id )
				dw_view_tables.SetItem( li_nr, "project_id", ii_project_id )
				il_next_table_id++				
				dw_view_tables.SetItem( li_nr, "table_id", il_next_table_id )				
			END IF
		ELSE
				lb_address_link = True
		END IF
		
		CONTINUE
	END IF
END FOR

li_rc = dw_view_tables.RowCount()

FOR i = 2 TO li_rc
	ls_table_name = dw_view_tables.GetItemString( i, "table_name" )
	IF ls_table_name = "v_dept" OR ls_table_name = "v_staff_cat" OR ls_table_name = "v_staff_leave"  OR ls_table_name = "v_committee_review" OR +&
		 ls_table_name = "v_affil_stat" OR ls_table_name = "v_net_dev_actions" OR ls_table_name = "v_net_dev_ids" OR ls_table_name = "v_net_dev_notes" OR +&
		 ls_table_name = "v_action_items" OR ls_table_name = "v_address_link" OR ( (ls_table_name = "v_address" OR ls_table_name = "v_mailing_address") and lb_address_link = True) THEN
		CONTINUE
	END IF
	//debugbreak()
	cb_view_add_link.TriggerEvent( Clicked! )
	dw_view_links.SetItem( ii_nr, "link_type", "=" )				
	dw_view_links.SetItem( ii_nr, "link_from_table_nm", ls_first_table_name )				
	dw_view_links.SetItem( ii_nr, "link_from_field_nm", "prac_id" )			
	dw_view_links.SetItem( ii_nr, "link_to_table_nm", ls_table_name )				
	dw_view_links.SetItem( ii_nr, "link_to_field_nm", "prac_id" )				
	li_prac_link_cnt++
	//messagebox("1", "clicked")
END FOR

IF li_prac_link_cnt = 0 THEN
	IF lb_affil_stat THEN
		cb_view_add_link.TriggerEvent( Clicked! )		
		li_rc = dw_view_links.RowCount( )
		dw_view_links.SetItem( li_rc, "link_type", "=" )				
		dw_view_links.SetItem( li_rc, "link_from_table_nm", ls_first_table_name )				
		dw_view_links.SetItem( li_rc, "link_from_field_nm", "prac_id" )			
		dw_view_links.SetItem( li_rc, "link_to_table_nm", "v_affil_stat" )				
		dw_view_links.SetItem( li_rc, "link_to_field_nm", "prac_id" )		
		lb_affil_stat_allready_linked = True
		//messagebox("2", "clicked")		
	ELSEIF lb_address_link THEN
		cb_view_add_link.TriggerEvent( Clicked! )		
		li_rc = dw_view_links.RowCount( )
		dw_view_links.SetItem( li_rc, "link_type", "=" )				
		dw_view_links.SetItem( li_rc, "link_from_table_nm", ls_first_table_name )				
		dw_view_links.SetItem( li_rc, "link_from_field_nm", "prac_id" )			
		dw_view_links.SetItem( li_rc, "link_to_table_nm", "v_address" )				
		dw_view_links.SetItem( li_rc, "link_to_field_nm", "prac_id" )		
		//messagebox("3", "clicked")		
	END IF
END IF

li_rc = dw_view_tables.RowCount()

FOR i = 1 TO li_rc
	ls_table_name = dw_view_tables.GetItemString( i, "table_name" )	
	CHOOSE CASE ls_table_name
		CASE "v_affil_stat"
			IF NOT lb_affil_stat_allready_linked THEN
				cb_view_add_link.TriggerEvent( Clicked! )
				li_link_row = dw_view_links.RowCount( )
				dw_view_links.SetItem( li_link_row, "link_type", "=" )			
				IF dw_view_tables.Find( "table_name = 'v_basic'", 1, 1000 ) > 0 THEN				
					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_basic" )				
				ELSEIF dw_view_tables.Find( "table_name = 'v_basic_info'", 1, 1000 ) > 0 THEN			
					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_basic_info" )								
				ELSEIF dw_view_tables.Find( "table_name = 'v_full_name'", 1, 1000 ) > 0 THEN			
					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_full_name" )	
				ELSE
					dw_view_links.DeleteRow( li_link_row )
				END IF			
				dw_view_links.SetItem( li_link_row, "link_from_field_nm", "prac_id" )			
				dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "prac_id" )		
				lb_affil_stat_allready_linked = True
				//messagebox("", "clicked")				
			END IF
		CASE "v_dept"
			cb_view_add_link.TriggerEvent( Clicked! )
			li_link_row = dw_view_links.RowCount( )
			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_dept" )				
			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "rec_id" )					

		CASE "v_staff_cat"
			cb_view_add_link.TriggerEvent( Clicked! )
			li_link_row = dw_view_links.RowCount( )
			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_staff_cat" )				
			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "rec_id" )					

		CASE "v_committee_review"
			cb_view_add_link.TriggerEvent( Clicked! )
			li_link_row = dw_view_links.RowCount( )
			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_committee_review" )				
			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "rec_id" )					

		CASE "v_staff_leave"
			cb_view_add_link.TriggerEvent( Clicked! )
			li_link_row = dw_view_links.RowCount( )
			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_committee_review" )				
			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "rec_id" )					

		CASE "v_net_dev_actions","v_net_dev_ids"
			cb_view_add_link.TriggerEvent( Clicked! )
			li_link_row = dw_view_links.RowCount( )
			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "prac_id" )			
			dw_view_links.SetItem( li_link_row, "link_to_table_nm", ls_table_name )				
			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "prac_id" )					

			cb_view_add_link.TriggerEvent( Clicked! )
			li_link_row = dw_view_links.RowCount( )
			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "parent_facility_id" )			
			dw_view_links.SetItem( li_link_row, "link_to_table_nm", ls_table_name )				
			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "facility_id" )					

		CASE "v_address", "v_mailing_address"
			IF lb_address_link THEN
				cb_view_add_link.TriggerEvent( Clicked! )
				li_link_row = dw_view_links.RowCount( )
				dw_view_links.SetItem( li_link_row, "link_type", "=" )				
				dw_view_links.SetItem( li_link_row, "link_from_table_nm", ls_table_name )				
				dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
				dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_address_link" )				
				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "address_id" )
				
				cb_view_add_link.TriggerEvent( Clicked! ) //naha 101104
				li_link_row = dw_view_links.RowCount( )
				dw_view_links.SetItem( li_link_row, "link_type", "=" )				
				dw_view_links.SetItem( li_link_row, "link_from_table_nm", ls_first_table_name )				
				dw_view_links.SetItem( li_link_row, "link_from_field_nm", "prac_id" )			
				dw_view_links.SetItem( li_link_row, "link_to_table_nm", ls_table_name )				
				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "prac_id" )
			END IF
			
			//if the affil_stat table is in the list then link to address_link
			IF dw_view_tables.Find( "table_name = 'v_affil_stat'", 1, 1000 ) > 0 THEN
				IF NOT lb_affil_stat_allready_linked THEN				
					cb_view_add_link.TriggerEvent( Clicked! )
					li_link_row = dw_view_links.RowCount( )
					dw_view_links.SetItem( li_link_row, "link_type", "=" )				
					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_address_link" )				
					dw_view_links.SetItem( li_link_row, "link_from_field_nm", "prac_id" )			
					dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
					dw_view_links.SetItem( li_link_row, "link_to_field_nm", "prac_id" )					
					lb_affil_stat_allready_linked = True
				END IF
				
				//IF NOT lb_affil_stat_allready_linked THEN
					cb_view_add_link.TriggerEvent( Clicked! )
					li_link_row = dw_view_links.RowCount( )
					dw_view_links.SetItem( li_link_row, "link_type", "=" )				
					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_address_link" )				
					dw_view_links.SetItem( li_link_row, "link_from_field_nm", "facility_id" )			
					dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
					dw_view_links.SetItem( li_link_row, "link_to_field_nm", "parent_facility_id" )						
				//END IF
			END IF
		CASE "v_action_items","v_net_dev_actions"			
			IF dw_view_tables.Find( "table_name = 'v_affil_stat'", 1, 1000 ) > 0 THEN
				cb_view_add_link.TriggerEvent( Clicked! )
				li_link_row = dw_view_links.RowCount( )
				dw_view_links.SetItem( li_link_row, "link_type", "=" )
				dw_view_links.SetItem( li_link_row, "link_from_table_nm", ls_table_name )				
				dw_view_links.SetItem( li_link_row, "link_from_field_nm", "prac_id" )			
				dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "prac_id" )					
				lb_affil_stat_allready_linked = True
			END IF			
			Open( w_link_question )
			cb_view_add_link.TriggerEvent( Clicked! )
			li_link_row = dw_view_links.RowCount( )
			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_action_items" )				
			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "facility_id" )			
			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
			IF Message.StringParm = "Parent" THEN			
				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "parent_facility_id" )					
			ELSE
				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "verifying_facility" )					
			END IF
			lb_affil_stat_allready_linked = True			
	END CHOOSE
END FOR
//\/ link the net dev app ids  maha 101104
IF dw_view_tables.Find( "table_name = 'v_net_dev_actions'", 1, 1000 ) > 0  and dw_view_tables.Find( "table_name = 'v_net_dev_ids'", 1, 1000 ) > 0 THEN
	cb_view_add_link.TriggerEvent( Clicked! )
	li_link_row = dw_view_links.RowCount( )
	dw_view_links.SetItem( li_link_row, "link_type", "=" )
	dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_net_dev_actions" )				
	dw_view_links.SetItem( li_link_row, "link_from_field_nm", "app_id" )			
	dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_net_dev_ids" )				
	dw_view_links.SetItem( li_link_row, "link_to_field_nm", "app_id" )	
end if

dw_view_links.Update()
dw_view_links.Retrieve( il_view_id )

//maha 012704 replaced below with above from ver 3 which works better
//Integer li_nr
//Integer li_ans
//Integer li_rc
//Integer i
//Integer li_link_row
//Integer li_prac_link_cnt = 0
//Long ll_tid
//Integer li_table_id
//String ls_table_name
//String ls_first_table_name
//Boolean lb_affil_stat_allready_linked = False
//Boolean lb_affil_stat
//Boolean lb_dept
//Boolean lb_staff_cat
//Boolean lb_basic
//Boolean lb_address
//Boolean lb_address_link
//
//dw_view_tables.AcceptText()
//dw_view_tables.Update()
//dw_view_tables.Retrieve( il_view_id )
//
//li_rc = dw_view_links.RowCount()
//IF li_rc > 0 THEN
//	li_ans = MessageBox("Links", "This option will delete any links that currently exist.  Continue?", Question!, YesNo!, 1 )
//	IF li_ans = 2 THEN
//		Return
//	END IF
//	FOR i = 1 TO li_rc
//		dw_view_links.DeleteRow( 0 )
//	END FOR
//	dw_view_links.Update( )
//END IF
//
//li_rc = dw_view_tables.RowCount()
//IF li_rc < 2 THEN
//	MessageBox( "Link Failure", "You need to select at least 2 tables to use the Auto Link Function." )
//	Return
//END IF
//
//ls_first_table_name = dw_view_tables.GetItemString( 1, "table_name" )
//
//
////analyze the tables that are selected
//FOR i = 1 TO li_rc
//	ls_table_name = dw_view_tables.GetItemString( i, "table_name" )
//	IF ls_table_name = "v_dept" OR ls_table_name = "v_staff_cat" OR ls_table_name = "v_staff_leave"  OR ls_table_name = "v_committee_review" OR +&
//		ls_table_name = "v_net_dev_actions" OR ls_table_name = "v_net_dev_ids" OR ls_table_name = "v_net_dev_notes"  OR ls_table_name = "v_action_items" THEN
//		IF dw_view_tables.Find( "table_name = 'v_affil_stat'", 1, 1000 ) = 0 THEN
//			IF ls_table_name = "v_action_items" THEN
//				li_ans = MessageBox( "Table Selection", "Will you be using the v_action_items table to report on data for a specific facility? If so you must have the v_affil_stat table selected also so you can link to the parent OR verifying facility field.  Would you like to add this now?", StopSign!, YesNo!, 1 )				
//			ELSE
//				li_ans = MessageBox( "Table Selection", "To use the " + Upper( ls_table_name ) + " table you must have the v_affil_stat table selected also.  Would you like to add this now?", StopSign!, YesNo!, 1 )
//			END IF
//			IF li_ans = 1 THEN
//				lb_affil_stat	= True
//				li_nr = dw_view_tables.InsertRow( 0 )			
//				SELECT id
//				INTO :ll_tid
//				FROM dbo.sysobjects
//				WHERE name = 'v_affil_stat' ;
//				dw_view_tables.SetItem( li_nr, "table_name", "v_affil_stat" )				
//				dw_view_tables.SetItem( li_nr, "cust_table_name", ll_tid )
//				dw_view_tables.SetItem( li_nr, "view_id", il_view_id )
//				dw_view_tables.SetItem( li_nr, "project_id", ii_project_id )
//				il_next_table_id++				
//				dw_view_tables.SetItem( li_nr, "table_id", il_next_table_id )				
//			ELSE
//				Return
//			END IF
//		ELSE
//			lb_affil_stat	= True
//		END IF
//		CONTINUE
//	END IF
//	IF ls_table_name = "v_address" OR ls_table_name = "v_mailing_address" THEN
//		IF dw_view_tables.Find( "table_name = 'v_address_link'", 1, 1000 ) = 0 THEN		
//			li_ans = MessageBox( "Table Selection", "You have selected the " + ls_table_name + " table.  If you want to query addresses by ADDRESS TYPE (Primary, Additional, Billing etc.) then you should include the v_address_link table.  Would you like to add this table now?", StopSign!, YesNo!, 1 )
//			IF li_ans = 1 THEN
//				lb_address_link = True
//				li_nr = dw_view_tables.InsertRow( 0 )			
//				SELECT id
//				INTO :ll_tid
//				FROM dbo.sysobjects
//				WHERE name = 'v_address_link' ;
//				dw_view_tables.SetItem( li_nr, "table_name", "v_address_link" )				
//				dw_view_tables.SetItem( li_nr, "cust_table_name", ll_tid )
//				dw_view_tables.SetItem( li_nr, "view_id", il_view_id )
//				dw_view_tables.SetItem( li_nr, "project_id", ii_project_id )
//				il_next_table_id++				
//				dw_view_tables.SetItem( li_nr, "table_id", il_next_table_id )				
//			END IF
//		ELSE
//				lb_address_link = True
//		END IF
//		
//		CONTINUE
//	END IF
//END FOR
//
//li_rc = dw_view_tables.RowCount()
//
//FOR i = 2 TO li_rc
//	ls_table_name = dw_view_tables.GetItemString( i, "table_name" )
//	IF ls_table_name = "v_dept" OR ls_table_name = "v_staff_cat" OR ls_table_name = "v_staff_leave"  OR ls_table_name = "v_committee_review" OR +&
//		 ls_table_name = "v_affil_stat" OR ls_table_name = "v_net_dev_actions" OR ls_table_name = "v_net_dev_ids" OR ls_table_name = "v_net_dev_notes" OR +&
//		 ls_table_name = "v_action_items" OR ls_table_name = "v_address_link" OR ( (ls_table_name = "v_address" OR ls_table_name = "v_mailing_address") and lb_address_link = True) THEN
//		CONTINUE
//	END IF
//	//debugbreak()
//	cb_view_add_link.TriggerEvent( Clicked! )
//	dw_view_links.SetItem( ii_nr, "link_type", "=" )				
//	dw_view_links.SetItem( ii_nr, "link_from_table_nm", ls_first_table_name )				
//	dw_view_links.SetItem( ii_nr, "link_from_field_nm", "prac_id" )			
//	dw_view_links.SetItem( ii_nr, "link_to_table_nm", ls_table_name )				
//	dw_view_links.SetItem( ii_nr, "link_to_field_nm", "prac_id" )				
//	li_prac_link_cnt++
//	//messagebox("1", "clicked")
//END FOR
//
//IF li_prac_link_cnt = 0 THEN
//	IF lb_affil_stat THEN
//		cb_view_add_link.TriggerEvent( Clicked! )		
//		li_rc = dw_view_links.RowCount( )
//		dw_view_links.SetItem( li_rc, "link_type", "=" )				
//		dw_view_links.SetItem( li_rc, "link_from_table_nm", ls_first_table_name )				
//		dw_view_links.SetItem( li_rc, "link_from_field_nm", "prac_id" )			
//		dw_view_links.SetItem( li_rc, "link_to_table_nm", "v_affil_stat" )				
//		dw_view_links.SetItem( li_rc, "link_to_field_nm", "prac_id" )		
//		lb_affil_stat_allready_linked = True
//		//messagebox("2", "clicked")		
//	ELSEIF lb_address_link THEN
//		cb_view_add_link.TriggerEvent( Clicked! )		
//		li_rc = dw_view_links.RowCount( )
//		dw_view_links.SetItem( li_rc, "link_type", "=" )				
//		dw_view_links.SetItem( li_rc, "link_from_table_nm", ls_first_table_name )				
//		dw_view_links.SetItem( li_rc, "link_from_field_nm", "prac_id" )			
//		dw_view_links.SetItem( li_rc, "link_to_table_nm", "v_address" )				
//		dw_view_links.SetItem( li_rc, "link_to_field_nm", "prac_id" )		
//		//messagebox("3", "clicked")		
//	END IF
//END IF
//
//li_rc = dw_view_tables.RowCount()
//
//FOR i = 2 TO li_rc
//	ls_table_name = dw_view_tables.GetItemString( i, "table_name" )	
//	CHOOSE CASE ls_table_name
//		CASE "v_affil_stat"
//			IF NOT lb_affil_stat_allready_linked THEN
//				cb_view_add_link.TriggerEvent( Clicked! )
//				li_link_row = dw_view_links.RowCount( )
//				dw_view_links.SetItem( li_link_row, "link_type", "=" )			
//				IF dw_view_tables.Find( "table_name = 'v_basic'", 1, 1000 ) > 0 THEN				
//					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_basic" )				
//				ELSEIF dw_view_tables.Find( "table_name = 'v_basic_info'", 1, 1000 ) > 0 THEN			
//					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_basic_info" )								
//				ELSEIF dw_view_tables.Find( "table_name = 'v_full_name'", 1, 1000 ) > 0 THEN			
//					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_full_name" )	
//				ELSE
//					dw_view_links.DeleteRow( li_link_row )
//				END IF			
//				dw_view_links.SetItem( li_link_row, "link_from_field_nm", "prac_id" )			
//				dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
//				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "prac_id" )		
//				lb_affil_stat_allready_linked = True
//				//messagebox("", "clicked")				
//			END IF
//		CASE "v_dept"
//			cb_view_add_link.TriggerEvent( Clicked! )
//			li_link_row = dw_view_links.RowCount( )
//			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
//			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
//			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_dept" )				
//			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "rec_id" )					
//
//		CASE "v_staff_cat"
//			cb_view_add_link.TriggerEvent( Clicked! )
//			li_link_row = dw_view_links.RowCount( )
//			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
//			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
//			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_staff_cat" )				
//			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "rec_id" )					
//
//		CASE "v_committee_review"
//			cb_view_add_link.TriggerEvent( Clicked! )
//			li_link_row = dw_view_links.RowCount( )
//			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
//			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
//			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_committee_review" )				
//			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "rec_id" )					
//
//		CASE "v_staff_leave"
//			cb_view_add_link.TriggerEvent( Clicked! )
//			li_link_row = dw_view_links.RowCount( )
//			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
//			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
//			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_committee_review" )				
//			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "rec_id" )					
//
//		CASE "v_net_dev_actions"
//			cb_view_add_link.TriggerEvent( Clicked! )
//			li_link_row = dw_view_links.RowCount( )
//			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
//			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "prac_id" )			
//			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_net_dev_actions" )				
//			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "prac_id" )					
//
//			cb_view_add_link.TriggerEvent( Clicked! )
//			li_link_row = dw_view_links.RowCount( )
//			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_affil_stat" )				
//			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "parent_facility_id" )			
//			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_net_dev_actions" )				
//			dw_view_links.SetItem( li_link_row, "link_to_field_nm", "facility_id" )					
//
//		CASE "v_address", "v_mailing_address"
//			IF lb_address_link THEN
//				cb_view_add_link.TriggerEvent( Clicked! )
//				li_link_row = dw_view_links.RowCount( )
//				dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//				dw_view_links.SetItem( li_link_row, "link_from_table_nm", ls_table_name )				
//				dw_view_links.SetItem( li_link_row, "link_from_field_nm", "rec_id" )			
//				dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_address_link" )				
//				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "address_id" )					
//			END IF
//			
//			//if the affil_stat table is in the list then link to address_link
//			IF dw_view_tables.Find( "table_name = 'v_affil_stat'", 1, 1000 ) > 0 THEN
//				IF NOT lb_affil_stat_allready_linked THEN				
//					cb_view_add_link.TriggerEvent( Clicked! )
//					li_link_row = dw_view_links.RowCount( )
//					dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_address_link" )				
//					dw_view_links.SetItem( li_link_row, "link_from_field_nm", "prac_id" )			
//					dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
//					dw_view_links.SetItem( li_link_row, "link_to_field_nm", "prac_id" )					
//					lb_affil_stat_allready_linked = True
//				END IF
//				
//				//IF NOT lb_affil_stat_allready_linked THEN
//					cb_view_add_link.TriggerEvent( Clicked! )
//					li_link_row = dw_view_links.RowCount( )
//					dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//					dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_address_link" )				
//					dw_view_links.SetItem( li_link_row, "link_from_field_nm", "facility_id" )			
//					dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
//					dw_view_links.SetItem( li_link_row, "link_to_field_nm", "parent_facility_id" )						
//				//END IF
//			END IF
//		CASE "v_action_items"			
//			IF dw_view_tables.Find( "table_name = 'v_affil_stat'", 1, 1000 ) > 0 THEN
//				cb_view_add_link.TriggerEvent( Clicked! )
//				li_link_row = dw_view_links.RowCount( )
//				dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//				dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_action_items" )				
//				dw_view_links.SetItem( li_link_row, "link_from_field_nm", "prac_id" )			
//				dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
//				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "prac_id" )					
//				lb_affil_stat_allready_linked = True
//			END IF			
//			Open( w_link_question )
//			cb_view_add_link.TriggerEvent( Clicked! )
//			li_link_row = dw_view_links.RowCount( )
//			dw_view_links.SetItem( li_link_row, "link_type", "=" )				
//			dw_view_links.SetItem( li_link_row, "link_from_table_nm", "v_action_items" )				
//			dw_view_links.SetItem( li_link_row, "link_from_field_nm", "facility_id" )			
//			dw_view_links.SetItem( li_link_row, "link_to_table_nm", "v_affil_stat" )				
//			IF Message.StringParm = "Parent" THEN			
//				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "parent_facility_id" )					
//			ELSE
//				dw_view_links.SetItem( li_link_row, "link_to_field_nm", "verifying_facility" )					
//			END IF
//			lb_affil_stat_allready_linked = True			
//	END CHOOSE
//END FOR
//
//
//dw_view_links.Update()
//dw_view_links.Retrieve( il_view_id )
end event

type cb_5 from commandbutton within tabpage_tables
integer x = 1243
integer y = 1892
integer width = 384
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Query Help"
end type

event clicked;Open( w_query_hints )
end event

type cbx_distinct from checkbox within tabpage_tables
integer x = 2633
integer y = 56
integer width = 791
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80269524
string text = "Select Distinct Values Only"
boolean checked = true
end type

event clicked;
IF This.Checked THEN
	UPDATE conv_view
	SET distinct_sql = 1
	WHERE conv_view.view_id = :il_view_id ;
ELSE
	UPDATE conv_view
	SET distinct_sql = 0
	WHERE conv_view.view_id = :il_view_id ;	
END IF
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("DB Error", SQLCA.SQLERRTEXT )
END IF
end event

type dw_view_tables from datawindow within tabpage_tables
integer x = 1330
integer y = 40
integer width = 1221
integer height = 1168
integer taborder = 60
string dragicon = "Error!"
boolean titlebar = true
string title = "Selected Tables"
string dataobject = "d_conv_view_tables_report5"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;This.SetTransObject( SQLCA )
end event

event dragdrop;Integer li_nr
Integer li_row
Long ll_field_id
Long ll_max_x
Long ll_width

li_row = dw_select_table.GetRow( )

IF li_row > 0 and is_drag_object = "select table" THEN
	li_nr = dw_view_tables.Insertrow( 0 )

	il_next_table_id++
	dw_view_tables.SetItem( li_nr, "project_id", ii_project_id )
	dw_view_tables.SetItem( li_nr, "view_id", il_view_id )	
	
	dw_view_tables.SetItem( li_nr, "cust_table_name", dw_select_table.GetItemNumber( li_row, "table_id" ) )	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.24.2006 By: LiuHongXin
	//$<reason> Fix a defect.
	dw_view_tables.SetItem( li_nr, "table_real_name", dw_select_table.GetItemString( li_row, "table_name" ) )
	//---------------------------- APPEON END ----------------------------
	dw_view_tables.SetItem( li_nr, "table_id", il_next_table_id )
	dw_select_table.Deleterow( li_row )
	dw_view_tables.AcceptText()
	dw_view_tables.Update( )

END IF
end event

event clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
	is_drag_object = "deselect table"	
	This.Drag(Begin! )	
END IF
end event

event doubleclicked;if row > 0 then
	This.DeleteRow( row )
	of_save()
end if
end event

type tabpage_columns from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3497
integer height = 2100
boolean enabled = false
long backcolor = 79741120
string text = "Columns"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "SingleLineEdit5!"
long picturemaskcolor = 12632256
dw_fields_list dw_fields_list
dw_view_fields dw_view_fields
dw_all_fields dw_all_fields
cb_next_3 cb_next_3
cb_10 cb_10
cb_11 cb_11
cb_33 cb_33
cb_34 cb_34
st_8 st_8
end type

on tabpage_columns.create
this.dw_fields_list=create dw_fields_list
this.dw_view_fields=create dw_view_fields
this.dw_all_fields=create dw_all_fields
this.cb_next_3=create cb_next_3
this.cb_10=create cb_10
this.cb_11=create cb_11
this.cb_33=create cb_33
this.cb_34=create cb_34
this.st_8=create st_8
this.Control[]={this.dw_fields_list,&
this.dw_view_fields,&
this.dw_all_fields,&
this.cb_next_3,&
this.cb_10,&
this.cb_11,&
this.cb_33,&
this.cb_34,&
this.st_8}
end on

on tabpage_columns.destroy
destroy(this.dw_fields_list)
destroy(this.dw_view_fields)
destroy(this.dw_all_fields)
destroy(this.cb_next_3)
destroy(this.cb_10)
destroy(this.cb_11)
destroy(this.cb_33)
destroy(this.cb_34)
destroy(this.st_8)
end on

type dw_fields_list from datawindow within tabpage_columns
integer x = 50
integer y = 44
integer width = 1221
integer height = 1808
integer taborder = 50
string dragicon = "Rectangle!"
boolean titlebar = true
string title = "4. Select Fields To Use In View"
string dataobject = "d_conv_view_fields"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
	is_drag_object = "select field"	
	This.Drag(Begin! )	
END IF
end event

event constructor;This.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-11 By: owen chen
//$<reason> add database option for sql excution

string ls_sqlsyntax

choose case gs_dbtype
	case 'ASA'
		ls_sqlsyntax =   "  SELECT distinct systable.table_name, "+&  
									"systable.table_id, "+&
									"sys.syscolumns.cname, "+&  
									"sys.syscolumns.colno, "+&  
									"sys.syscolumns.coltype, "+&  
									"sys.syscolumns.length "+& 
								 "FROM sys.syscolumns, "+&  
										"systable "+& 
									"WHERE ( sys.syscolumns.tname = systable.table_name ) and "+&  
										  " ( ( sys.syscolumns.tname in ( :table_name ) ) ) "  
	case 'SQL'
		ls_sqlsyntax =  "  SELECT distinct v_systable.table_name, "+&  
										"v_systable.table_id, "+&
										"v_syscolumns.cname, "+&  
										"v_syscolumns.colno, "+&  
										"v_syscolumns.coltype, "+&  
										"v_syscolumns.length "+& 
								 "FROM v_syscolumns, "+&  
										"v_systable "+& 
								"WHERE ( v_syscolumns.tname = v_systable.table_name ) and "+&  
									  " ( ( v_syscolumns.tname in ( :table_name ) ) ) " 
end choose
this.modify("DataWindow.Table.Select='"+ls_sqlsyntax+"'")

//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;Integer li_nr
Long ll_field_id
Long ll_max_x
Long ll_width


if row > 0  then //maha 042202
li_nr = dw_view_fields.InsertRow( 0 )

il_next_field_id++
dw_view_fields.SetItem( li_nr, "field_id", il_next_field_id )
dw_view_fields.SetItem( li_nr, "project_id", ii_project_id )
dw_view_fields.SetItem( li_nr, "view_id", il_view_id )

dw_view_fields.SetItem( li_nr, "sel_field_id", This.GetItemNumber( row, "field_id" ) )
dw_view_fields.SetItem( li_nr, "sel_table_id", This.GetItemNumber( row, "table_id" ) )

dw_view_fields.SetItem( li_nr, "field_name", This.GetItemString( row, "field_name" ) )
dw_view_fields.SetItem( li_nr, "field_alias", MidA( This.GetItemString( row, "field_name" ),1, 38) )
dw_view_fields.SetItem( li_nr, "label_text", MidA( This.GetItemString( row, "field_name" ),1, 38) )
dw_view_fields.SetItem( li_nr, "table_name", This.GetItemString( row, "table_name" ) )

dw_view_fields.SetItem( li_nr, "field_display_width", This.GetItemNumber( row, "syscolumns_length" ))

dw_view_fields.SetItem( li_nr, "field_order",li_nr * 10 )
dw_view_fields.SetItem( li_nr, "field_x", 0 )

IF tab_1.tabpage_browse.dw_Detail.GetItemString(1, "report_type" ) = "Profile" OR tab_1.tabpage_browse.dw_Detail.GetItemString(1, "report_type" ) = "Form" THEN
	dw_view_fields.SetItem( li_nr, "field_align", 0 )
	dw_view_fields.SetItem( li_nr, "label_align", 0 )
ELSE
	dw_view_fields.SetItem( li_nr, "field_align", 0 )
	dw_view_fields.SetItem( li_nr, "label_align", 2 )
END IF

This.DeleteRow( row )

dw_view_fields.AcceptText()

dw_view_fields.Update( )

end if



end event

event dragdrop;Integer li_row

li_row = dw_view_fields.GetRow( )

IF li_row > 0 AND is_drag_object = "deselect field" then
	dw_view_fields.DeleteRow( li_row )
	of_save()
END IF
end event

type dw_view_fields from datawindow within tabpage_columns
integer x = 1312
integer y = 128
integer width = 2135
integer height = 1724
integer taborder = 60
string dragicon = "Error!"
string dataobject = "d_view_selected_fields5"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
	IF This.GetClickedColumn() = 0 THEN
		is_drag_object = "deselect field"	
		This.Drag(Begin! )			
	END IF
END IF
end event

event constructor;This.SetTransObject( SQLCA )
This.Modify("DataWindow.HorizontalScrollSplit=930")
This.Modify("DataWindow.HorizontalScrollPosition2=933")

end event

event doubleclicked;if row > 0 then
	This.DeleteRow( row )

	of_save()
end if
end event

event itemchanged;IF This.GetColumnName() = "field_wizard_name" THEN
	DataWindowChild dwchild
	Integer li_found
	This.GetChild( "field_wizard_name", dwchild )
	li_found = dwchild.Find( "lookup_name = '" + data + "'", 1, dwchild.GetRow() )
	IF li_found > 0 THEN
		This.SetItem( row, "field_wizard_type", dwchild.GetItemString( li_found, "type" ) )
	END IF
	//messagebox("data",data)
	if data = "" or isnull(data) then 
		this.setitem(this.getrow(),"field_options"," ") //maha 012704  clear this field
		This.SetItem( row, "field_wizard_type", "")
	end if
	if data = "Facility" or data = "Application / Payor" or data = "Action Status" or data = "Address Type" then
		this.setitem(this.getrow(),"field_options","D") //maha 071604  set this field
		
	end if
ELSEIF This.GetColumnName() = "field_visible" THEN
	IF data = "0" THEN
		This.SetItem( row, "field_x", -1 )
	ELSE
		This.SetItem( row, "field_x", 0 )		
	END IF
END IF
end event

event retrieveend;DataWindowChild dwchild
Integer i

This.GetChild( "field_wizard_name", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_name", "Single Date Comparison" )
dwchild.SetItem( 1, "type", "D" )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_name", "Date Range Comparison" )
dwchild.SetItem( 1, "type", "R" )


dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_name", "Facility" )
dwchild.SetItem( 1, "type", "F" )

//i = dwchild.find("lookup_name")
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_name", "Address Type" )
dwchild.SetItem( 1, "type", "L" )

dwchild.InsertRow( 1 ) //maha 071404
dwchild.SetItem( 1, "lookup_name", "Action/Status" )
dwchild.SetItem( 1, "type", "N" )

dwchild.InsertRow( 1 ) //maha 071404
dwchild.SetItem( 1, "lookup_name", "Application / Payor" )
dwchild.SetItem( 1, "type", "P" )


dwchild.InsertRow( 1 ) //blankrow to clear wizard


FOR i = 1 TO rowcount
	IF Long( This.GetItemNumber( i, "field_x" ) ) > 0 THEN
		This.SetItem( i, "field_visible", 1 )
	ELSE
		This.SetItem( i, "field_visible", 0 )
	END IF
END FOR


//Integer i
//Integer li_found
//String ls_tbl_nm
//String ls_fld_nm
//
//FOR i = 1 TO rowcount
//	ls_tbl_nm = This.GetItemString( i, "table_name" )
//	ls_fld_nm = This.GetItemString( i, "field_name" )
//	li_found = dw_fields_list.Find( "table_name = '" + ls_tbl_nm + "' AND field_name ='" + ls_fld_nm + "'" , 1, 1000 )
//	IF li_found > 0 THEN
//		dw_fields_list.DeleteRow( li_found )
//	END IF
//END FOR
end event

event dragdrop;Integer li_nr
Integer li_row

li_row  = dw_fields_list.GetRow( )

IF li_row > 0 AND is_drag_object = "select field" THEN

	li_nr = dw_view_fields.InsertRow( 0 )

	il_next_field_id++
	dw_view_fields.SetItem( li_nr, "field_id", il_next_field_id )
	dw_view_fields.SetItem( li_nr, "project_id", ii_project_id )
	dw_view_fields.SetItem( li_nr, "view_id", il_view_id )

	dw_view_fields.SetItem( li_nr, "sel_field_id", dw_fields_list.GetItemNumber( li_row, "field_id" ) )
	dw_view_fields.SetItem( li_nr, "sel_table_id", dw_fields_list.GetItemNumber( li_row, "table_id" ) )

	dw_view_fields.SetItem( li_nr, "field_name", dw_fields_list.GetItemString( li_row, "field_name" ) )
	dw_view_fields.SetItem( li_nr, "field_alias", MidA( dw_fields_list.GetItemString( li_row, "field_name" ),1, 38) )
	dw_view_fields.SetItem( li_nr, "label_text", MidA( dw_fields_list.GetItemString( li_row, "field_name" ),1, 38) )
	dw_view_fields.SetItem( li_nr, "table_name", dw_fields_list.GetItemString( li_row, "table_name" ) )
	
	dw_view_fields.SetItem( li_nr, "field_display_width", dw_fields_list.GetItemNumber( li_row, "syscolumns_length" ))

	dw_view_fields.SetItem( li_nr, "field_order",li_nr * 10 )
	dw_view_fields.SetItem( li_nr, "field_x", 0 )

	dw_view_fields.SetItem( li_nr, "field_align", 0 )
	dw_view_fields.SetItem( li_nr, "label_align", 2 )

	dw_fields_list.Deleterow( li_row )

	dw_view_fields.AcceptText()

	dw_view_fields.Update( )
END IF


end event

type dw_all_fields from datawindow within tabpage_columns
boolean visible = false
integer x = 325
integer y = 912
integer width = 603
integer height = 352
integer taborder = 50
boolean titlebar = true
string title = "4. Select Fields To Use In View"
string dataobject = "d_conv_view_fields"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject( sqlca )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-11 By: owen chen
//$<reason> add database option for sql excution

string ls_sqlsyntax

choose case gs_dbtype
	case 'ASA'
		ls_sqlsyntax =   "  SELECT distinct systable.table_name, "+&  
									"systable.table_id, "+&
									"sys.syscolumns.cname, "+&  
									"sys.syscolumns.colno, "+&  
									"sys.syscolumns.coltype, "+&  
									"sys.syscolumns.length "+& 
								 "FROM sys.syscolumns, "+&  
										"systable "+& 
									"WHERE ( sys.syscolumns.tname = systable.table_name ) and "+&  
										  " ( ( sys.syscolumns.tname in ( :table_name ) ) ) "  
	case 'SQL'
		ls_sqlsyntax =  "  SELECT distinct v_systable.table_name, "+&  
										"v_systable.table_id, "+&
										"v_syscolumns.cname, "+&  
										"v_syscolumns.colno, "+&  
										"v_syscolumns.coltype, "+&  
										"v_syscolumns.length "+& 
								 "FROM v_syscolumns, "+&  
										"v_systable "+& 
								"WHERE ( v_syscolumns.tname = v_systable.table_name ) and "+&  
									  " ( ( v_syscolumns.tname in ( :table_name ) ) ) " 
end choose
this.modify("DataWindow.Table.Select='"+ls_sqlsyntax+"'")

//---------------------------- APPEON END ----------------------------

end event

type cb_next_3 from commandbutton within tabpage_columns
integer x = 3109
integer y = 1888
integer width = 334
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Next ->"
end type

event clicked;Integer li_rc
Integer i
integer c
Integer li_total_agg
string ls_alias

IF dw_view_fields.RowCount() = 0 THEN
	MessageBox( "Fields", "You must select at least one field to report on." )
	Return 
END IF

li_rc = dw_view_fields.RowCount()

dw_view_fields.AcceptText()

FOR i = 1 TO li_rc
	IF Not IsNull( dw_view_fields.GetItemString( i, "field_wizard_name" ) ) THEN
		IF IsNull( dw_view_fields.GetItemString( i, "field_options" ) ) OR dw_view_fields.GetItemString( i, "field_options" )  = '' THEN
			//MessageBox("", "You need to fill in the Compare To column." )
 			MessageBox("Missing Data", "You need to fill in the Compare To column." )
			dw_view_fields.SetRow( i )
			dw_view_fields.ScrollToRow( i )
			dw_view_fields.SetColumn( "field_options" )
			Return
		END IF
		
		IF IsNull( dw_view_fields.GetItemString( i, "field_alias" ) ) OR dw_view_fields.GetItemString( i, "field_alias" )  = '' THEN
			//MessageBox("", "You need to fill in the Field Alias column." )
 			MessageBox("Missing Data", "You need to fill in the Field Alias column." )
			dw_view_fields.SetRow( i )
			dw_view_fields.ScrollToRow( i )
			dw_view_fields.SetColumn( "field_alias" )
			Return
		END IF		
	END IF
	
	//MESSAGEBOX("", "I" + dw_view_fields.GetItemString( i, "aggregate_type" ) +"I" )
	
	IF IsNull(dw_view_fields.GetItemString( i, "aggregate_type" ) ) OR +&
				 dw_view_fields.GetItemString( i, "aggregate_type" ) = "" OR +&
				 dw_view_fields.GetItemString( i, "aggregate_type" ) = " " THEN
		li_total_agg = dw_view_fields.GetItemNumber( i, "count_fld" ) + dw_view_fields.GetItemNumber( i, "sum_fld" ) + dw_view_fields.GetItemNumber( i, "avg_fld" ) 
		IF li_total_agg > 0 THEN
			//MessageBox( "Aggregate Field Setup Error", "You have selected an aggregate calculation but not an aggregate type.  Please correct." )
 			MessageBox( "Aggregate Field Setup Error", "You have selected an aggregate calculation but no aggregate type.  Please correct." )
			dw_view_fields.SetRow( i )
			dw_view_fields.ScrollToRow( i )
			dw_view_fields.SetColumn( "aggregate_type" )
			Return			
		END IF
	END IF
	
	IF LenA( dw_view_fields.GetItemString( i, "aggregate_type" ) ) > 1 THEN
		li_total_agg = dw_view_fields.GetItemNumber( i, "count_fld" ) + dw_view_fields.GetItemNumber( i, "sum_fld" ) + dw_view_fields.GetItemNumber( i, "avg_fld" ) 
		IF li_total_agg = 0 THEN
			MessageBox( "Aggregate Field Setup Error", "You have selected an aggregate type but no aggregate function ( ex. Sum, Count, Average).  Please correct." )
			dw_view_fields.SetRow( i )
			dw_view_fields.ScrollToRow( i )
			dw_view_fields.SetColumn( "aggregate_type" )
			Return			
		END IF
	END IF
END FOR

FOR i = 1 TO li_rc - 1 //duplicate alias check maha 020304
	ls_alias = dw_view_fields.GetItemString( i, "field_alias" )
	for c = i + 1 TO li_rc 
		if ls_alias = dw_view_fields.GetItemString( c, "field_alias" )then 
			//messagebox("Duplicate Fields", ls_alias + " on row " + string(c) + " has a duplicate field alias ( to row " + string(i) + ").  Modify one to continue.")
 			messagebox("Duplicate Fields", ls_alias + " on row " + string(c) + " has a duplicate field alias ( with row " + string(i) + ").  Modify one to continue.")
			return
		end if
	next
next
of_save( )

tab_1.tabpage_filter.Enabled = True

tab_1.SelectTab( 4 )
end event

type cb_10 from commandbutton within tabpage_columns
integer x = 1312
integer y = 1892
integer width = 192
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Up"
end type

event clicked;Integer li_order
Integer i
Integer li_cr
Integer li_rc

li_cr = dw_view_fields.GetRow( )

IF li_cr = 1 THEN
	Return
END IF

li_cr --

li_order = dw_view_fields.GetItemNumber( dw_view_fields.GetRow(), "field_order" )

dw_view_fields.SetItem( dw_view_fields.GetRow(), "field_order", li_order -11 )

dw_view_fields.SetSort( "field_order a" )
dw_view_fields.Sort()

li_rc = dw_view_fields.RowCount()

FOR i = 1 TO li_rc
	dw_view_fields.SetItem( i, "field_order", i * 10 )
END FOR

dw_view_fields.SetSort( "field_order a" )
dw_view_fields.Sort()

dw_view_fields.SetFocus()

dw_view_fields.SelectRow( 0, False )
dw_view_fields.SelectRow( li_cr, True )
dw_view_fields.SetRow( li_cr )
end event

type cb_11 from commandbutton within tabpage_columns
integer x = 1518
integer y = 1892
integer width = 178
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Down"
end type

event clicked;Integer li_order
Integer i
Integer li_rc
Integer li_cr

li_cr = dw_view_fields.GetRow( )

IF li_cr = dw_view_fields.RowCount( ) THEN
	Return
END IF

li_cr ++

li_order = dw_view_fields.GetItemNumber( dw_view_fields.GetRow(), "field_order" )

dw_view_fields.SetItem( dw_view_fields.GetRow(), "field_order", li_order +11 )

dw_view_fields.SetSort( "field_order a" )
dw_view_fields.Sort()

li_rc = dw_view_fields.RowCount()

FOR i = 1 TO li_rc
	dw_view_fields.SetItem( i, "field_order", i * 10 )
END FOR

dw_view_fields.SetSort( "field_order a" )
dw_view_fields.Sort()

dw_view_fields.SetFocus()

dw_view_fields.SelectRow( 0, False )
dw_view_fields.SelectRow( li_cr, True )
dw_view_fields.SetRow( li_cr )
end event

type cb_33 from commandbutton within tabpage_columns
integer x = 1710
integer y = 1892
integer width = 361
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Computed"
end type

event clicked;Integer li_nr
String ls_formula
String ls_field

OpenWithParm( w_calc_field_report, "New" )

IF Message.StringParm = "Cancel" THEN
	Return
END IF

ls_field = MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" )-1 )
ls_formula = MidA( Message.StringParm, PosA( Message.StringParm, "-" )+1, 1000 )

li_nr = dw_view_fields.InsertRow( 0 )

il_next_field_id++
dw_view_fields.SetItem( li_nr, "field_id", il_next_field_id )
dw_view_fields.SetItem( li_nr, "project_id", ii_project_id )
dw_view_fields.SetItem( li_nr, "view_id", il_view_id )
dw_view_fields.SetItem( li_nr, "field_alias", ls_field )

dw_view_fields.SetItem( li_nr, "sel_field_id", 0 )
dw_view_fields.SetItem( li_nr, "sel_table_id", 0 )

dw_view_fields.SetItem( li_nr, "field_name", ls_formula )
dw_view_fields.SetItem( li_nr, "table_name", ls_field )

dw_view_fields.SetItem( li_nr, "field_order",li_nr * 10 )

dw_view_fields.SetItem( li_nr, "label_text", MidA(ls_field,1, 38) )
//This.DeleteRow( row )

dw_view_fields.Update( )



end event

type cb_34 from commandbutton within tabpage_columns
integer x = 2085
integer y = 1892
integer width = 411
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Edit Computed"
end type

event clicked;Integer li_nr
String ls_formula
String ls_field

li_nr = dw_view_fields.GetRow()

ls_formula = dw_view_fields.GetItemString( li_nr , "field_name" )
ls_field = dw_view_fields.GetItemString( li_nr, "table_name" )

OpenWithParm( w_calc_field_report, ls_field + "-" + ls_formula )

IF Message.StringParm = "Cancel" THEN
	Return
END IF

ls_field = MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" )-1 )
ls_formula = MidA( Message.StringParm, PosA( Message.StringParm, "-" )+1, 1000 )

//li_nr = dw_view_fields.InsertRow( 0 )

//il_next_field_id++
//dw_view_fields.SetItem( li_nr, "field_id", il_next_field_id )
dw_view_fields.SetItem( li_nr, "project_id", ii_project_id )
dw_view_fields.SetItem( li_nr, "view_id", il_view_id )

dw_view_fields.SetItem( li_nr, "sel_field_id", 0 )
dw_view_fields.SetItem( li_nr, "sel_table_id", 0 )

dw_view_fields.SetItem( li_nr, "field_name", ls_formula )
dw_view_fields.SetItem( li_nr, "table_name", ls_field )

dw_view_fields.SetItem( li_nr, "field_order",li_nr * 10 )

//This.DeleteRow( row )

dw_view_fields.Update( )



end event

type st_8 from statictext within tabpage_columns
integer x = 1312
integer y = 44
integer width = 2135
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 10789024
boolean enabled = false
string text = " Selected Fields"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type tabpage_filter from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3497
integer height = 2100
boolean enabled = false
long backcolor = 79741120
string text = "Filter"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Query!"
long picturemaskcolor = 12632256
dw_view_where dw_view_where
cb_12 cb_12
cb_16 cb_16
cb_3 cb_3
cb_next_4 cb_next_4
st_fil st_fil
end type

on tabpage_filter.create
this.dw_view_where=create dw_view_where
this.cb_12=create cb_12
this.cb_16=create cb_16
this.cb_3=create cb_3
this.cb_next_4=create cb_next_4
this.st_fil=create st_fil
this.Control[]={this.dw_view_where,&
this.cb_12,&
this.cb_16,&
this.cb_3,&
this.cb_next_4,&
this.st_fil}
end on

on tabpage_filter.destroy
destroy(this.dw_view_where)
destroy(this.cb_12)
destroy(this.cb_16)
destroy(this.cb_3)
destroy(this.cb_next_4)
destroy(this.st_fil)
end on

type dw_view_where from datawindow within tabpage_filter
integer x = 50
integer y = 128
integer width = 2107
integer height = 1740
integer taborder = 50
string dataobject = "d_view_where5"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event constructor;This.SetTransObject( SQLCA )
end event

type cb_12 from commandbutton within tabpage_filter
integer x = 64
integer y = 1892
integer width = 384
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Filter"
end type

event clicked;Integer li_nr
DataWindowChild dwchild

dw_view_where.GetChild( "table_field_name", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( il_view_id )

li_nr = dw_view_where.InsertRow( 0 )
dw_view_where.SetRow( li_nr )
dw_view_where.ScrollToRow( li_nr )

il_next_where_id++

dw_view_where.SetItem( li_nr, "where_id", il_next_where_id )
dw_view_where.SetItem( li_nr, "view_id", il_view_id )
dw_view_where.SetItem( li_nr, "project_id", ii_project_id )

dw_view_where.SetFocus( )


end event

type cb_16 from commandbutton within tabpage_filter
integer x = 466
integer y = 1892
integer width = 384
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete Filter"
end type

event clicked;Long ll_table_id

dw_view_where.DeleteRow( 0 )
	 
of_save()



end event

type cb_3 from commandbutton within tabpage_filter
integer x = 869
integer y = 1892
integer width = 384
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Preview SQL"
end type

event clicked;//MessageBox(" SQL  ", of_build_view_sql() )

openwithparm(w_sql_msg,of_build_view_sql() )
end event

type cb_next_4 from commandbutton within tabpage_filter
integer x = 3109
integer y = 1892
integer width = 334
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Next ->"
end type

event clicked;IF dw_view_where.AcceptText() = -1 THEN
	Return -1
END IF

IF of_save( ) = -1 THEN
	Return
END IF

//of_preview( tab_1.tabpage_preview.dw_preview )

tab_1.tabpage_sort.Enabled = True

tab_1.SelectTab( 5 )
end event

type st_fil from statictext within tabpage_filter
integer x = 50
integer y = 40
integer width = 2107
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 10789024
boolean enabled = false
string text = " 5. Filter"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type tabpage_sort from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3497
integer height = 2100
boolean enabled = false
long backcolor = 79741120
string text = "Sort"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Sort!"
long picturemaskcolor = 12632256
cb_next_5 cb_next_5
dw_fields_list_sort dw_fields_list_sort
dw_view_sort dw_view_sort
end type

on tabpage_sort.create
this.cb_next_5=create cb_next_5
this.dw_fields_list_sort=create dw_fields_list_sort
this.dw_view_sort=create dw_view_sort
this.Control[]={this.cb_next_5,&
this.dw_fields_list_sort,&
this.dw_view_sort}
end on

on tabpage_sort.destroy
destroy(this.cb_next_5)
destroy(this.dw_fields_list_sort)
destroy(this.dw_view_sort)
end on

type cb_next_5 from commandbutton within tabpage_sort
integer x = 3104
integer y = 1888
integer width = 334
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Next ->"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-20
//$<comment> 02.10.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<reason> Function of_save() will be called in subsequent function within tab_1.selectionchanging and 
//$<reason> it is unnecessary to call it before running tab_1.SelectTab( 6 ).

/*of_save( )*/
//---------------------------- APPEON END ----------------------------

//of_preview( tab_1.tabpage_preview.dw_preview )
//ib_new = False

tab_1.tabpage_preview.Enabled = True
tab_1.tabpage_run.Enabled = True

tab_1.SelectTab( 6 )
end event

type dw_fields_list_sort from datawindow within tabpage_sort
integer x = 50
integer y = 44
integer width = 1211
integer height = 1808
integer taborder = 20
string dragicon = "Rectangle!"
boolean titlebar = true
string title = "6. Select Fields To Sort By"
string dataobject = "d_view_selected_sort_fields"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
	is_drag_object = "select sort"	
	This.Drag(Begin! )
END IF
end event

event constructor;This.SetTransObject( SQLCA )
end event

event doubleclicked;Integer li_nr
Long ll_field_id
Long ll_max_x

if row > 0 then
li_nr = dw_view_sort.InsertRow( 0 )

dw_view_sort.SetItem( li_nr, "project_id", ii_project_id )
dw_view_sort.SetItem( li_nr, "view_id", il_view_id )

il_next_sort_id ++
dw_view_sort.SetItem( li_nr, "sort_id", il_next_sort_id )

//dw_view_sort.SetItem( li_nr, "field_name", This.GetItemString( row, "field_name" ) )
dw_view_sort.SetItem( li_nr, "field_name", This.GetItemString( row, "field_alias" ) )
dw_view_sort.SetItem( li_nr, "table_name", This.GetItemString( row, "table_name" ) )
//$<add> 04.21.2008 by Andy
tab_1.tabpage_sort.dw_view_sort.SetItem( li_nr, "dbname", This.GetItemString( row, "table_name" ) + '.' + This.GetItemString( row, "field_alias" ) )
//end add 04.21.2008
dw_view_sort.SetItem( li_nr, "sort_dir", "D" )

This.DeleteRow( row )

dw_view_sort.AcceptText()

dw_view_sort.Update( )

end if



end event

event dragdrop;IF dw_view_sort.GetRow() > 0 	AND is_drag_object = "deselect sort" THEN
	dw_view_sort.DeleteRow( dw_view_sort.GetRow() )
	of_save()
END IF
end event

type dw_view_sort from u_dw within tabpage_sort
integer x = 1312
integer y = 40
integer width = 2135
integer height = 1808
integer taborder = 11
string dragicon = "Error!"
boolean bringtotop = true
boolean titlebar = true
string title = "Selected Sort Fields"
string dataobject = "d_cust_report_sort"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
end event

event doubleclicked;call super::doubleclicked;if row > 0 then

	This.DeleteRow( row )

	of_save()

end if
end event

event clicked;call super::clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.SetRow( row )
	IF This.GetClickedColumn() = 0 THEN
		is_drag_object = "deselect sort"	
		This.Drag(Begin! )			
	END IF
END IF
end event

event dragdrop;call super::dragdrop;
Integer li_row
Integer li_nr
Long ll_field_id
Long ll_max_x

li_row = dw_fields_list_sort.GetRow( )

IF li_row > 0 AND is_drag_object = "select sort" THEN
	li_nr = dw_view_sort.Insertrow( 0 )

	dw_view_sort.SetItem( li_nr, "project_id", ii_project_id )
	dw_view_sort.SetItem( li_nr, "view_id", il_view_id )

	il_next_sort_id ++
	dw_view_sort.SetItem( li_nr, "sort_id", il_next_sort_id )

	dw_view_sort.SetItem( li_nr, "field_name", dw_fields_list_sort.GetItemString( li_row, "field_name" ) )

	dw_view_sort.SetItem( li_nr, "table_name", dw_fields_list_sort.GetItemString( li_row, "table_name" ) )
	//$<add> 04.21.2008 by Andy
	tab_1.tabpage_sort.dw_view_sort.SetItem( li_nr, "dbname", dw_fields_list_sort.GetItemString( li_row, "table_name" ) + '.' + dw_fields_list_sort.GetItemString( li_row, "field_name" ) )
	//end add 04.21.2008
	dw_view_sort.SetItem( li_nr, "sort_dir", "D" )

	dw_fields_list_sort.Deleterow( li_row )

	dw_view_sort.AcceptText()

	dw_view_sort.Update( )

END IF



end event

type tabpage_preview from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3497
integer height = 2100
boolean enabled = false
long backcolor = 79741120
string text = "Design"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom032!"
long picturemaskcolor = 12632256
cb_quick_preview cb_quick_preview
st_obj_name st_obj_name
cb_14 cb_14
gb_1 gb_1
gb_2 gb_2
rb_p rb_p
rb_l rb_l
em_font em_font
st_2 st_2
st_left st_left
st_5 st_5
st_center st_center
st_right st_right
st_f_right st_f_right
st_f_center st_f_center
st_f_left st_f_left
st_6 st_6
dw_label dw_label
st_4 st_4
cbx_move_all cbx_move_all
cb_2 cb_2
st_7 st_7
st_bold st_bold
st_italic st_italic
st_underline st_underline
st_normal st_normal
dw_preview dw_preview
st_9 st_9
st_10 st_10
st_11 st_11
st_12 st_12
end type

on tabpage_preview.create
this.cb_quick_preview=create cb_quick_preview
this.st_obj_name=create st_obj_name
this.cb_14=create cb_14
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rb_p=create rb_p
this.rb_l=create rb_l
this.em_font=create em_font
this.st_2=create st_2
this.st_left=create st_left
this.st_5=create st_5
this.st_center=create st_center
this.st_right=create st_right
this.st_f_right=create st_f_right
this.st_f_center=create st_f_center
this.st_f_left=create st_f_left
this.st_6=create st_6
this.dw_label=create dw_label
this.st_4=create st_4
this.cbx_move_all=create cbx_move_all
this.cb_2=create cb_2
this.st_7=create st_7
this.st_bold=create st_bold
this.st_italic=create st_italic
this.st_underline=create st_underline
this.st_normal=create st_normal
this.dw_preview=create dw_preview
this.st_9=create st_9
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.Control[]={this.cb_quick_preview,&
this.st_obj_name,&
this.cb_14,&
this.gb_1,&
this.gb_2,&
this.rb_p,&
this.rb_l,&
this.em_font,&
this.st_2,&
this.st_left,&
this.st_5,&
this.st_center,&
this.st_right,&
this.st_f_right,&
this.st_f_center,&
this.st_f_left,&
this.st_6,&
this.dw_label,&
this.st_4,&
this.cbx_move_all,&
this.cb_2,&
this.st_7,&
this.st_bold,&
this.st_italic,&
this.st_underline,&
this.st_normal,&
this.dw_preview,&
this.st_9,&
this.st_10,&
this.st_11,&
this.st_12}
end on

on tabpage_preview.destroy
destroy(this.cb_quick_preview)
destroy(this.st_obj_name)
destroy(this.cb_14)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rb_p)
destroy(this.rb_l)
destroy(this.em_font)
destroy(this.st_2)
destroy(this.st_left)
destroy(this.st_5)
destroy(this.st_center)
destroy(this.st_right)
destroy(this.st_f_right)
destroy(this.st_f_center)
destroy(this.st_f_left)
destroy(this.st_6)
destroy(this.dw_label)
destroy(this.st_4)
destroy(this.cbx_move_all)
destroy(this.cb_2)
destroy(this.st_7)
destroy(this.st_bold)
destroy(this.st_italic)
destroy(this.st_underline)
destroy(this.st_normal)
destroy(this.dw_preview)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
end on

type cb_quick_preview from commandbutton within tabpage_preview
integer x = 453
integer y = 1944
integer width = 370
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Quick Preview"
end type

event clicked;IF This.Text = "Remove Data" THEN
	This.Text = "Quick Preview"
	ii_with_data = 0
	of_preview( dw_preview, tab_1.tabpage_browse.dw_detail )
ELSE
	This.Text = "Remove Data"	
	ii_with_data = 1
	of_preview( dw_preview, tab_1.tabpage_browse.dw_detail )
END IF

ii_with_data = 0
end event

type st_obj_name from statictext within tabpage_preview
integer x = 882
integer y = 1944
integer width = 2523
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "None"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_14 from commandbutton within tabpage_preview
integer x = 64
integer y = 1944
integer width = 370
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
end type

event clicked;of_save()

ib_new = False
end event

type gb_1 from groupbox within tabpage_preview
integer x = 59
integer y = 8
integer width = 2583
integer height = 388
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Column Properties"
end type

type gb_2 from groupbox within tabpage_preview
integer x = 2674
integer y = 8
integer width = 722
integer height = 388
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Report Properties"
end type

type rb_p from radiobutton within tabpage_preview
integer x = 2738
integer y = 88
integer width = 352
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Portrait"
boolean checked = true
end type

event clicked;tab_1.tabpage_browse.dw_detail.SetItem( tab_1.tabpage_browse.dw_detail.GetRow(), "orientation", "P" )
tab_1.tabpage_browse.dw_detail.AcceptText()
dw_preview.Modify("DataWindow.Print.Orientation= '2'")

end event

type rb_l from radiobutton within tabpage_preview
integer x = 2738
integer y = 164
integer width = 352
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Landscape "
end type

event clicked;tab_1.tabpage_browse.dw_detail.SetItem( tab_1.tabpage_browse.dw_detail.GetRow(), "orientation", "L" )
tab_1.tabpage_browse.dw_detail.AcceptText()
dw_preview.Modify("DataWindow.Print.Orientation= '1'")
end event

type em_font from editmask within tabpage_preview
integer x = 3109
integer y = 132
integer width = 247
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Font Size"
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean spin = true
string minmax = "6~~14"
end type

event modified;Integer i


FOR i = 1 TO ii_col_count
	dw_preview.Modify( is_column_name[ i ] + ".Font.Face='MS Sans Serif'")		
	dw_preview.Modify( is_column_name[ i ] + ".Font.Height='-" + This.Text + "'")	
	dw_preview.Modify( is_column_name[ i ] + "_label.Font.Height='-" + This.Text + "'")		
	dw_preview.Modify( is_label_name[ i ] + ".Font.Height='-" + This.Text + "'")		
END FOR

tab_1.tabpage_browse.dw_detail.SetItem( 1, "font_size" , Integer(This.Text )) 

end event

event other;//Integer i
//
//
//FOR i = 1 TO ii_col_count
//	dw_preview.Modify( is_column_name[ i ] + ".Font.Face='MS Sans Serif'")		
//	dw_preview.Modify( is_column_name[ i ] + ".Font.Height='-" + This.Text + "'")	
//	dw_preview.Modify( is_label_name[ i ] + ".Font.Height='-" + This.Text + "'")		
//END FOR
//
////messagebox("",  is_label_name[ 1 ] + ".Font.Height='-" + This.Text + "'" )
//
end event

type st_2 from statictext within tabpage_preview
integer x = 3086
integer y = 72
integer width = 247
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Font Size"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_left from statictext within tabpage_preview
integer x = 2226
integer y = 128
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "L"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF

Integer i

This.BorderStyle = StyleLowered!
st_center.BorderStyle = StyleRaised!
st_right.BorderStyle = StyleRaised!

//w_prac_data_design.tab_1.tabpage_design.uo_design.idw_detail.Modify( w_prac_data_design.tab_1.tabpage_design.uo_design.is_last_object[i] + ".alignment = '0'")
tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".alignment = '0'")		
tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_align", 0  )	
	


end event

type st_5 from statictext within tabpage_preview
integer x = 2226
integer y = 68
integer width = 352
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Label Alignment"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_center from statictext within tabpage_preview
integer x = 2354
integer y = 128
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF

Integer i

This.BorderStyle = StyleLowered!
st_left.BorderStyle = StyleRaised!
st_right.BorderStyle = StyleRaised!

tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".alignment = '2'")		
tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_align", 2  )	


end event

type st_right from statictext within tabpage_preview
integer x = 2482
integer y = 128
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "R"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF

Integer i

This.BorderStyle = StyleLowered!
st_center.BorderStyle = StyleRaised!
st_left.BorderStyle = StyleRaised!

tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".alignment = '1'")		
tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_align", 1  )	

end event

type st_f_right from statictext within tabpage_preview
integer x = 2482
integer y = 284
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "R"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF

Integer i

This.BorderStyle = StyleLowered!
st_f_center.BorderStyle = StyleRaised!
st_f_left.BorderStyle = StyleRaised!

tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".alignment = '1'")		
tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_align", 1  )	

end event

type st_f_center from statictext within tabpage_preview
integer x = 2354
integer y = 284
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF

Integer i

This.BorderStyle = StyleLowered!
st_f_left.BorderStyle = StyleRaised!
st_f_right.BorderStyle = StyleRaised!

tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".alignment = '2'")		
tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_align", 2  )	


end event

type st_f_left from statictext within tabpage_preview
integer x = 2226
integer y = 284
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "L"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF

Integer i

This.BorderStyle = StyleLowered!
st_f_center.BorderStyle = StyleRaised!
st_f_right.BorderStyle = StyleRaised!

//w_prac_data_design.tab_1.tabpage_design.uo_design.idw_detail.Modify( w_prac_data_design.tab_1.tabpage_design.uo_design.is_last_object[i] + ".alignment = '0'")
tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".alignment = '0'")		
tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_align", 0  )	
	


end event

type st_6 from statictext within tabpage_preview
integer x = 2222
integer y = 224
integer width = 334
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Field Alignment"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_label from datawindow within tabpage_preview
integer x = 82
integer y = 264
integer width = 901
integer height = 108
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_design_label_editor"
boolean border = false
boolean livescroll = true
end type

event editchanged;
IF is_obj_name = "profile_title" THEN
	tab_1.tabpage_preview.dw_preview.Modify( "profile_title.text='" + data + "'" )
   tab_1.tabpage_browse.dw_detail.SetItem( tab_1.tabpage_browse.dw_detail.GetRow( ) , "profile_title", data )	
ELSE
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.20.2006 By: LeiWei
	//$<reason> Fix a defect
	/*
	tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".text='" + data + "'" )
	tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_text", data )
	*/

	IF ii_tag > 0 THEN
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".text='" + data + "'" )
		tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_text", data )
	END IF	
	//---------------------------- APPEON END ----------------------------

END IF
end event

event constructor;This.InsertRow( 0 )
end event

type st_4 from statictext within tabpage_preview
integer x = 87
integer y = 212
integer width = 283
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Modify Label"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_move_all from checkbox within tabpage_preview
boolean visible = false
integer x = 91
integer y = 64
integer width = 347
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Move All "
end type

type cb_2 from commandbutton within tabpage_preview
integer x = 2747
integer y = 272
integer width = 247
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ruler"
end type

event clicked;dw_preview.Modify("DataWindow.Print.Preview=Yes")
dw_preview.Modify("DataWindow.Print.Preview.Rulers=Yes")

end event

type st_7 from statictext within tabpage_preview
integer x = 1669
integer y = 64
integer width = 352
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Font Style"
boolean focusrectangle = false
end type

type st_bold from statictext within tabpage_preview
integer x = 1797
integer y = 128
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "B"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF

Integer i
String ls_font_style

IF This.BorderStyle = StyleLowered! THEN
	st_normal.BorderStyle = StyleLowered!
	st_normal.PostEvent( Clicked! )		
	This.BorderStyle = StyleRaised!
ELSE
	This.BorderStyle = StyleLowered!
	st_normal.BorderStyle = StyleRaised!	
END IF

IF st_normal.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "N"
END IF

IF st_italic.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "I"
END IF
		
IF st_underline.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "U"
END IF

IF st_bold.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "B"
END IF

IF is_object_type = "text" THEN
	tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_font_style", ls_font_style  )	
	tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.italic ='0'")			
	tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.underline ='0'")			
ELSEIF is_object_type = "column" THEN
	tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_font_style", ls_font_style  )		
	tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.italic ='0'")			
	tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.underline ='0'")			
END IF


IF PosA( ls_font_style,"B" ) > 0 THEN
	IF is_object_type = "text" THEN
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.weight ='700'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.weight ='700'")			
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.weight ='700'")					
	END IF
END IF
		
IF PosA( ls_font_style,"I" ) > 0 THEN
	IF is_object_type = "text" THEN	
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.italic ='1'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.italic ='1'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.italic ='1'")							
	END IF
END IF
			
IF PosA( ls_font_style,"U" ) > 0 THEN
	IF is_object_type = "text" THEN		
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.underline ='1'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.underline ='1'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.underline ='1'")							
	END IF
END IF	
		
IF PosA( ls_font_style,"N" ) > 0 THEN
	IF is_object_type = "text" THEN		
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.weight ='400'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.weight ='400'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.weight ='400'")							
	END IF
END IF	





end event

type st_italic from statictext within tabpage_preview
integer x = 1925
integer y = 128
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "I"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF


Integer i
String ls_font_style

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
ELSE
	This.BorderStyle = StyleLowered!
END IF

IF st_normal.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "N"
END IF

IF st_italic.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "I"
END IF
		
IF st_underline.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "U"
END IF

IF st_bold.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "B"
END IF

IF is_object_type = "text" THEN
	tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_font_style", ls_font_style  )	
	tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.italic ='0'")			
	tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.underline ='0'")			
ELSEIF is_object_type = "column" THEN
	tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_font_style", ls_font_style  )		
	tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.italic ='0'")			
	tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.underline ='0'")			
END IF


IF PosA( ls_font_style,"B" ) > 0 THEN
	IF is_object_type = "text" THEN
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.weight ='700'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.weight ='700'")			
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.weight ='700'")					
	END IF
END IF
		
IF PosA( ls_font_style,"I" ) > 0 THEN
	IF is_object_type = "text" THEN	
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.italic ='1'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.italic ='1'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.italic ='1'")							
	END IF
END IF
			
IF PosA( ls_font_style,"U" ) > 0 THEN
	IF is_object_type = "text" THEN		
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.underline ='1'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.underline ='1'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.underline ='1'")							
	END IF
END IF	
		
IF PosA( ls_font_style,"N" ) > 0 THEN
	IF is_object_type = "text" THEN		
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.weight ='400'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.weight ='400'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.weight ='400'")							
	END IF
END IF	





end event

type st_underline from statictext within tabpage_preview
integer x = 2053
integer y = 128
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 33554432
long backcolor = 67108864
string text = "U"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF

Integer i
String ls_font_style

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
ELSE
	This.BorderStyle = StyleLowered!
END IF

IF st_normal.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "N"
END IF

IF st_italic.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "I"
END IF
		
IF st_underline.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "U"
END IF

IF st_bold.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "B"
END IF

IF is_object_type = "text" THEN
	tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_font_style", ls_font_style  )	
	tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.italic ='0'")			
	tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.underline ='0'")			
ELSEIF is_object_type = "column" THEN
	tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_font_style", ls_font_style  )		
	tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.italic ='0'")			
	tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.underline ='0'")			
END IF

IF PosA( ls_font_style,"B" ) > 0 THEN
	IF is_object_type = "text" THEN
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.weight ='700'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.weight ='700'")			
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.weight ='700'")					
	END IF
END IF
		
IF PosA( ls_font_style,"I" ) > 0 THEN
	IF is_object_type = "text" THEN	
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.italic ='1'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.italic ='1'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.italic ='1'")							
	END IF
END IF
			
IF PosA( ls_font_style,"U" ) > 0 THEN
	IF is_object_type = "text" THEN		
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.underline ='1'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.underline ='1'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.underline ='1'")							
	END IF
END IF	
		
IF PosA( ls_font_style,"N" ) > 0 THEN
	IF is_object_type = "text" THEN		
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.weight ='400'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.weight ='400'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.weight ='400'")							
	END IF
END IF	





end event

type st_normal from statictext within tabpage_preview
integer x = 1669
integer y = 128
integer width = 119
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "N"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF ii_tag = 0 THEN
	MessageBox("Object", "No object selected." )
	Return
END IF

Integer i
String ls_font_style

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
ELSE
	This.BorderStyle = StyleLowered!
END IF

st_bold.BorderStyle = StyleRaised!

IF st_normal.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "N"
END IF

IF st_italic.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "I"
END IF
		
IF st_underline.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "U"
END IF

IF st_bold.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "B"
END IF

//tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.italic ='0'")			
//tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.underline ='0'")			
//tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.italic ='0'")			
//tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.underline ='0'")			

IF is_object_type = "text" THEN
	tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_font_style", ls_font_style  )	
ELSEIF is_object_type = "column" THEN
	tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_font_style", ls_font_style  )		
END IF

IF PosA( ls_font_style,"B" ) > 0 THEN
	IF is_object_type = "text" THEN
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.weight ='700'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.weight ='700'")			
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.weight ='700'")					
	END IF
END IF
		
IF PosA( ls_font_style,"I" ) > 0 THEN
	IF is_object_type = "text" THEN	
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.italic ='1'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.italic ='1'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.italic ='1'")							
	END IF
END IF
			
IF PosA( ls_font_style,"U" ) > 0 THEN
	IF is_object_type = "text" THEN		
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.underline ='1'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.underline ='1'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.underline ='1'")							
	END IF
END IF	
		
IF PosA( ls_font_style,"N" ) > 0 THEN
	IF is_object_type = "text" THEN		
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".font.weight ='400'")			
	ELSE
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + ".font.weight ='400'")					
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.font.weight ='400'")							
	END IF
END IF	





end event

type dw_preview from u_dw within tabpage_preview
event ue_down_key pbm_dwnkey
event ue_mouse_move pbm_dwnmousemove
integer x = 59
integer y = 428
integer width = 3337
integer height = 1484
integer taborder = 11
boolean hscrollbar = true
boolean livescroll = false
end type

event ue_down_key;Integer li_y_pos
Integer li_x_pos
Integer li_x1_pos
Integer li_x2_pos
Integer li_y1_pos
Integer li_y2_pos
Integer li_obj_x1_pos
Integer li_obj_x2_pos
Integer li_obj_y1_pos
Integer li_obj_y2_pos
Integer li_pixels = 4
Integer i
Integer li_cnt
Integer li_obj_cnt
String ls_col_name
String ls_section_height


IF KeyDown( KeyEnter! ) OR KeyDown( KeyTab!) THEN
	Return -1
END IF

IF keyflags = 2 THEN
	IF KeyDown( KeyDownArrow! ) OR KeyDown( KeyUpArrow! )THEN
		li_x1_pos = Integer( This.Describe( is_last_object[1] + ".x" )) -25
		li_x2_pos = li_x1_pos + Integer( This.Describe( is_last_object[1] + ".width" ) ) + 25

		li_y1_pos = Integer( This.Describe( is_last_object[1] + ".y" )) 
		
		//il_ancor_x = Integer( This.Describe( is_last_object[1] + ".x" ))
		//il_ancor_y = Integer( This.Describe( is_last_object[1] + ".y"))
		li_obj_cnt = Integer( This.Object.DataWindow.Column.Count ) * 2
		FOR i = 1 TO li_obj_cnt
			IF is_last_object[1] = is_object_list[i] THEN
				CONTINUE
			END IF
			li_obj_x1_pos = Integer( This.Describe( is_object_list[i] + ".x" ) )
			li_obj_x2_pos = li_obj_x1_pos + Integer( This.Describe( is_object_list[i] + ".width" ) )

			li_obj_y1_pos = Integer( This.Describe( is_object_list[i] + ".y" ) )
			li_obj_y2_pos = li_obj_x1_pos + Integer( This.Describe( is_object_list[i] + ".height" ) )
			
			IF (li_obj_x1_pos >= li_x1_pos AND li_obj_x1_pos <= li_x2_pos) OR (li_obj_x2_pos <= li_x1_pos AND li_obj_x2_pos >= li_x1_pos) THEN
			   IF key = KeyDownArrow! AND (li_obj_y1_pos < li_y1_pos) THEN
					CONTINUE
				END IF
			   IF key = KeyUpArrow! AND (li_obj_y1_pos > li_y1_pos) THEN
					CONTINUE
				END IF		
				ii_obj_select_cnt ++
				is_last_object[ii_obj_select_cnt] = is_object_list[i]
				il_last_object_x[ii_obj_select_cnt] = li_obj_x1_pos
				il_last_object_y[ii_obj_select_cnt] = li_obj_y1_pos				
				This.Modify( is_last_object[ii_obj_select_cnt] + ".border = '2'" )				
				IF ii_obj_select_cnt > 1 THEN
					ib_multi_select = True
				END IF
			END IF
		END FOR
	ELSEIF KeyDown( KeyRightArrow! ) OR KeyDown( KeyLeftArrow! ) THEN		
		
		li_x1_pos = Integer( This.Describe( is_last_object[1] + ".x" )) 
		li_y1_pos = Integer( This.Describe( is_last_object[1] + ".y" ) ) - 20
		li_y2_pos = li_y1_pos + Integer( This.Describe( is_last_object[1] + ".height" ) ) + 20		
		li_obj_cnt = Integer( This.Object.DataWindow.Column.Count ) * 2
		
		FOR i = 1 TO li_obj_cnt
			IF is_last_object[1] = is_object_list[i] THEN
				CONTINUE
			END IF
			li_obj_x1_pos = Integer( This.Describe( is_object_list[i] + ".x" ) )
			li_obj_x2_pos = li_obj_x1_pos + Integer( This.Describe( is_object_list[i] + ".width" ) )

			li_obj_y1_pos = Integer( This.Describe( is_object_list[i] + ".y" ) )
			li_obj_y2_pos = li_obj_y1_pos + Integer( This.Describe( is_object_list[i] + ".height" ) )
			
			IF (li_obj_y1_pos >= li_y1_pos AND li_obj_y1_pos <= li_y2_pos) OR (li_obj_y2_pos <= li_y1_pos AND li_obj_y2_pos >= li_y1_pos) THEN
			   IF key = KeyRightArrow! AND (li_obj_x1_pos < li_x1_pos) THEN
					CONTINUE
				END IF
			   IF key = KeyLeftArrow! AND (li_obj_x1_pos > li_x1_pos) THEN
					CONTINUE
				END IF		
				ii_obj_select_cnt ++
				il_last_object_x[ii_obj_select_cnt] = li_obj_x1_pos
				il_last_object_y[ii_obj_select_cnt] = li_obj_y1_pos								
				is_last_object[ii_obj_select_cnt] = is_object_list[i]
				This.Modify( is_last_object[ii_obj_select_cnt] + ".border = '2'" )				
				IF ii_obj_select_cnt > 1 THEN
					ib_multi_select = True
				END IF
			END IF
		END FOR				
	END IF
END IF

IF PosA(is_option, "Move") > 0 THEN
	FOR i = 1 TO ii_obj_select_cnt
		
		IF is_object_type = "column" THEN
			ls_col_name = MidA( is_last_object[i], 1, LenA( is_last_object[i] ) -6)
		END IF
				
		ib_mouse_down = False
		IF KeyDown( KeyUpArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".y" ) )
			li_y_pos = li_y_pos - li_pixels
			This.Modify( is_last_object[i] + ".y = '" + String( li_y_pos ) + "'" )
			IF lower(is_obj_name) = "header" or lower(is_obj_name) = "detail" THEN
				This.Modify("DataWindow." + is_obj_name + ".Height='" + String( li_y_pos + 10 ) + "'")				
  			   tab_1.tabpage_browse.dw_detail.SetItem( tab_1.tabpage_browse.dw_detail.GetRow( ), is_obj_name + "_height", li_y_pos )				
			ELSE
				IF is_object_type = "column" THEN
					This.Modify( ls_col_name + ".y = '" + String( li_y_pos ) + "'" )
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_y", li_y_pos  )												
				ELSE
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_y", li_y_pos  )								
				END IF
			END IF
			
		ELSEIF KeyDown( KeyDownArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".y" ) )
			li_y_pos = li_y_pos + li_pixels
			This.Modify( is_last_object[i] + ".y = '" + String( li_y_pos ) + "'" )
			IF Lower(is_obj_name) = "header" or Lower(is_obj_name) = "detail" THEN
				This.Modify("DataWindow." + is_obj_name + ".Height='" + String( li_y_pos +10) + "'")				
  			   tab_1.tabpage_browse.dw_detail.SetItem( tab_1.tabpage_browse.dw_detail.GetRow( ), is_obj_name + "_height", li_y_pos )				
			ELSE
				IF is_object_type = "column" THEN
					This.Modify( ls_col_name + ".y = '" + String( li_y_pos ) + "'" )
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_y", li_y_pos  )							
				ELSE
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_y", li_y_pos  )							
				END IF
			END IF
			//dw_properties.SetItem(1, "data_view_fields_field_y", li_y_pos )		
		ELSEIF KeyDown( KeyRightArrow! ) AND is_last_object[1] <> "detail_band" THEN
			li_x_pos = Integer (This.Describe( is_last_object[i] + ".x" ) )
			li_x_pos = li_x_pos + li_pixels

			//If its a LIST report then move both the label and column
  			IF is_report_type <> "Profile" AND is_report_type <> "Form" THEN
				IF is_object_type = "column" THEN
					This.Modify( ls_col_name + "_label.x = '" + String( li_x_pos ) + "'" )										
					This.Modify( ls_col_name + "_t.x = '" + String( li_x_pos ) + "'" )					
					This.Modify( ls_col_name + ".x = '" + String( li_x_pos ) + "'" )
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_x", li_x_pos  )												
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_x", li_x_pos  )																	
				ELSE
					Return
				END IF				
  		   ELSE
				This.Modify( is_last_object[i] + ".x = '" + String( li_x_pos ) + "'" )
				IF is_object_type = "column" THEN
					This.Modify( ls_col_name + ".x = '" + String( li_x_pos ) + "'" )
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_x", li_x_pos  )												
				ELSE
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_x", li_x_pos  )												
				END IF
			END IF
			
			//dw_properties.SetItem(1, "data_view_fields_field_x", li_x_pos )
		ELSEIF KeyDown( KeyLeftArrow! ) AND is_last_object[1] <> "detail_band" THEN
			li_x_pos = Integer (This.Describe( is_last_object[i] + ".x" ) )
			li_x_pos = li_x_pos - li_pixels
  			IF is_report_type <> "Profile" AND is_report_type <> "Form" THEN
				IF is_object_type = "column" THEN
					This.Modify( ls_col_name + "_label.x = '" + String( li_x_pos ) + "'" )										
					This.Modify( ls_col_name + "_t.x = '" + String( li_x_pos ) + "'" )					
					This.Modify( ls_col_name + ".x = '" + String( li_x_pos ) + "'" )
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_x", li_x_pos  )												
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_x", li_x_pos  )																	
				ELSE
					Return
				END IF				
  		   ELSE
				This.Modify( is_last_object[i] + ".x = '" + String( li_x_pos ) + "'" )
				IF is_object_type = "column" THEN
					This.Modify( ls_col_name + ".x = '" + String( li_x_pos ) + "'" )
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_x", li_x_pos  )												
				ELSE
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_x", li_x_pos  )												
				END IF
			END IF
		END IF
	END FOR

ELSEIF is_option = "Size" THEN
	FOR i = 1 TO ii_obj_select_cnt
		IF KeyDown( KeyLeftArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".width" ) )
			li_y_pos = li_y_pos - 10
			This.Modify( is_last_object[i] + ".width = '" + String( li_y_pos ) + "'" )
		ELSEIF KeyDown( KeyRightArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".width" ) )
			li_y_pos = li_y_pos + 10
			This.Modify( is_last_object[i] + ".width = '" + String( li_y_pos ) + "'" )
		ELSEIF KeyDown( KeyUpArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".height" ) )
			li_y_pos = li_y_pos - 10
			This.Modify( is_last_object[i] + ".height = '" + String( li_y_pos ) + "'" )
		ELSEIF KeyDown( KeyDownArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".height" ) )
			li_y_pos = li_y_pos + 10
			This.Modify( is_last_object[i] + ".height = '" + String( li_y_pos ) + "'" )
		END IF	
		
		//dw_properties.SetItem(1, "data_view_fields_field_width", li_y_pos )
	END FOR
END IF

//w_design_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
//									"  Y:" + String(il_last_object_y[1]) +&
//									"  Width:" + String(il_last_object_width[1]) +&
//									"  Height:" + String(il_last_object_height[1])

end event

event ue_mouse_move;Integer i
String ls_field_id
Long ll_x
Long ll_new_width
Long ll_y
Long ll_orig_x
Long ll_orig_y
Long ll_y_diff
Long ll_x_diff
Long ll_new_height
Long ll_curr_scroll_pos
String ls_col_name


IF ii_obj_select_cnt = 0 THEN
	RETURN
END IF


IF NOT ib_resize_height AND NOT ib_resize_width AND ib_mouse_down AND LenA(is_last_object[ii_obj_select_cnt]) > 0 AND is_last_object[ii_obj_select_cnt] <> "dw" AND is_option = "Move" AND	ib_control_down = False THEN		

	SetPointer(Cross!)
	
	ll_y_diff = (This.Pointery() - il_last_object_y[1] ) + (il_last_object_y[1] - il_ancor_y )
	ll_x_diff = (This.Pointerx() - il_last_object_x[1] ) + (il_last_object_x[1] - il_ancor_x )

	FOR i = 1 TO ii_obj_select_cnt
		ll_y = il_last_object_y[i] + ll_y_diff 
		ll_x = il_last_object_x[i] + ll_x_diff

		IF is_object_type = "column" THEN
			ls_col_name = MidA( is_last_object[i], 1, LenA( is_last_object[i] ) -6)
		END IF		

		//ADDED HERE
		IF is_report_type = "Profile" OR is_report_type = "Form" THEN
			IF Lower(is_obj_name) = "header" or Lower(is_obj_name) = "detail" THEN
				This.Modify("DataWindow." + is_obj_name + ".Height='" + String( ll_y) + "'")				
  			   tab_1.tabpage_browse.dw_detail.SetItem( tab_1.tabpage_browse.dw_detail.GetRow( ), is_obj_name + "_height", ll_y )				
				This.Modify( is_last_object[i] + ".y = '" + String( ll_y -10 ) + "'" )			  
			ELSE
				This.Modify( is_last_object[i] + ".y = '" + String( ll_y ) + "'" )		
				IF is_object_type = "column" THEN
					This.Modify( ls_col_name + ".y = '" + String( ll_y ) + "'" )
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_y", ll_y  )												
				ELSE
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_y", ll_y  )												
				END IF						
			END IF
		END IF		
		
		IF is_last_object[1] <> "detail_band"  AND is_object_type <> "band" THEN			
			//if LIST report then move both the column and the label
   		IF is_report_type <> "Profile" AND is_report_type <> "Form" THEN
				IF is_object_type = "column" THEN
					//messagebox("", ls_col_name )
					This.Modify( ls_col_name + ".x = '" + String( ll_x ) + "'" )
					This.Modify( ls_col_name + "_t.x = '" + String( ll_x ) + "'" )						
					This.Modify( ls_col_name + "_label.x = '" + String( ll_x ) + "'" )												
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_x", ll_x  )												
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_x", ll_x  )												
				END IF								
			ELSE
				This.Modify( is_last_object[i] + ".x = '" + String( ll_x ) + "'" )
				IF is_object_type = "column" THEN
					This.Modify( ls_col_name + ".x = '" + String( ll_x ) + "'" )
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_x", ll_x  )												
				ELSE
					tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_x", ll_x  )												
				END IF								
			END IF
		END IF
		
	END FOR
	
ELSEIF (This.Pointerx() > il_last_object_x[1] + il_last_object_width[1] - 20) AND (This.Pointerx() < il_last_object_x[1] + il_last_object_width[1]-2) THEN
	Ib_resize_width = True
	SetPointer(SizeWE!)
ELSEIF (This.Pointery() > il_last_object_y[1] + il_last_object_height[1] - 15) AND (This.PointerY() < il_last_object_y[1] + il_last_object_height[1]-2) THEN
	Ib_resize_height = True
	SetPointer(SizeNS!)
ELSEIF ib_resize_width AND ib_mouse_down THEN
	IF is_report_type <> "Profile" AND is_report_type <> "Form" THEN
		IF is_object_type <> "column" THEN
			Return
		ELSE
			ls_col_name = MidA( is_last_object[1], 1, LenA( is_last_object[1] ) -6)
		END IF				
	END IF	
	SetPointer(SizeWE!)
	ll_x_diff = Pointerx() - (il_last_object_x[1] + il_last_object_width[1])
	ll_new_width = il_last_object_width[1] + ll_x_diff
	il_last_object_width[1] = ll_new_width

	//if LIST report then move both the column widths the same
	IF is_report_type <> "Profile" AND is_report_type <> "Form" THEN
		IF is_object_type = "column" THEN
			This.Modify( ls_col_name + ".width = '" + String( ll_new_width ) + "'" )
			This.Modify( ls_col_name + "_t.width = '" + String( ll_new_width ) + "'" )						
			This.Modify( ls_col_name + "_label.width = '" + String( ll_new_width ) + "'" )												
			tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_display_width", String( ll_new_width )  )														
			tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_width", String( ll_new_width )  )												
		END IF
	ELSE
		This.Modify( is_last_object[1] + ".width = '" + String( ll_new_width ) + "'" )
		
		IF is_object_type = "column" THEN
			This.Modify( ls_col_name + ".width = '" + String( ll_new_width ) + "'" )
			tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_display_width", String( ll_new_width )  )														
		ELSE
			tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_width", String( ll_new_width )  )												
		END IF								
	END IF

ELSEIF ib_resize_height AND ib_mouse_down THEN
	SetPointer(SizeNS!)
	ll_y_diff = Pointery() - (il_last_object_y[1] + il_last_object_height[1])
	ll_new_height = il_last_object_height[1] + ll_y_diff
	il_last_object_height[1] = ll_new_height
	IF is_object_type = "column" THEN
		ls_col_name = MidA( is_last_object[1], 1, LenA( is_last_object[1] ) -6)	
		This.Modify( ls_col_name + ".height = '" + String( ll_new_height ) + "'" )		
		This.Modify( ls_col_name + "_label.height = '" + String( ll_new_height ) + "'" )		
		tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "field_height", ll_new_height )																
	ELSEIF is_object_type = "text" THEN
		This.Modify( is_last_object[1] + ".height = '" + String( ll_new_height ) + "'" )				
		tab_1.tabpage_columns.dw_view_fields.SetItem( ii_tag, "label_height", ll_new_height )														
	END IF			
ELSE
	Ib_resize_width = False
	Ib_resize_height = False
END IF

st_obj_name.Text = Upper(is_obj_name) + "   X:" + String(il_last_object_x[1]) +&
   												 "  Y:" + String(il_last_object_y[1]) +&
	   										  	 "  Width:" + String(il_last_object_width[1]) +&
		   										 "  Height:" + String(il_last_object_height[1])
									
									


end event

event clicked;call super::clicked;String ls_font_style
String ls_type
Integer li_align
Integer i
String ls_weight
String ls_italic
String ls_underline
String ls_selected_object
String ls_alignment
String ls_text
String ls_selected_object_name
String ls_field_id
String ls_last_field_temp[]
Integer li_field_id[]


dw_label.SetItem( 1, "label", "" )

ls_type = dwo.type
is_object_type = ls_type
is_obj_name =  dwo.name


//messagebox(is_object_type, is_obj_name )

//IF ls_type = "text" AND (is_report_type <> "Profile" AND is_report_type <> "Form") THEN
	//Return
//END IF



//IF ls_type = "column" OR ( ls_type = "text" AND  ( is_report_type = "Profile" OR is_report_type = "Form")) THEN
IF ls_type = "column" OR ls_type = "text" THEN
	//is_obj_name =  dwo.name
	IF PosA( is_obj_name, "_label" ) > 0 THEN
		//is_obj_name = Mid( is_obj_name, 1, Len( is_obj_name )-6 ) + "_t"
		ls_type = "column"
		is_object_type = ls_type
	ELSEIF is_obj_name = "profile_title" THEN
		dw_label.SetItem( 1, "label", dwo.Text )		
		Return 1
	END IF

	ii_tag = Integer( dwo.tag )
	st_obj_name.Text = is_obj_name
	FOR i = 1 TO ii_col_count
		tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ i ] + ".color='0'")		
		tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ i ] + "_label.color='0'")				
	END FOR	
	IF ii_tag > 0 THEN
		IF ls_type = "column" THEN
			tab_1.tabpage_preview.dw_preview.Modify( is_column_name[ ii_tag ] + "_label.color='16711808'")				
		ELSE
			tab_1.tabpage_preview.dw_preview.Modify( is_label_name[ ii_tag ] + ".color='16711808'")				
		END IF
	END IF
ELSEIF is_obj_name = "header" OR is_obj_name = "footer" OR is_obj_name = "detail" OR is_obj_name = "summary" THEN
	is_object_type = "band"
	st_obj_name.Text = "To adjust the report " + is_obj_name + " use our Up and Down arrow keys." 
ELSE
	st_obj_name.Text = "None"
END IF

IF ls_type = "text"  And PosA( is_obj_name, "title" ) = 0 THEN
	dw_label.SetItem( 1, "label", dwo.Text )
END IF

IF ii_tag > 0 THEN
	
	//font
	IF ls_type = "text" THEN
		ls_font_style = tab_1.tabpage_columns.dw_view_fields.GetItemString( ii_tag, "label_font_style" )
	ELSE
		ls_font_style = tab_1.tabpage_columns.dw_view_fields.GetItemString( ii_tag, "field_font_style" )
	END IF
	
	tab_1.tabpage_preview.st_normal.BorderStyle = StyleRaised!
	tab_1.tabpage_preview.st_bold.BorderStyle = StyleRaised!
	tab_1.tabpage_preview.st_italic.BorderStyle = StyleRaised!
	tab_1.tabpage_preview.st_underline.BorderStyle = StyleRaised!

	IF PosA( ls_font_style, "N" ) > 0 THEN
		tab_1.tabpage_preview.st_normal.BorderStyle = StyleLowered!
	END IF
	IF PosA( ls_font_style, "B" ) > 0 THEN
		tab_1.tabpage_preview.st_bold.BorderStyle = StyleLowered!
	END IF
	IF PosA( ls_font_style, "I" ) > 0 THEN
		tab_1.tabpage_preview.st_italic.BorderStyle = StyleLowered!
	END IF
	IF PosA( ls_font_style, "U" ) > 0 THEN
		tab_1.tabpage_preview.st_underline.BorderStyle = StyleLowered!
	END IF
	
	//allign label
	li_align = tab_1.tabpage_columns.dw_view_fields.GetItemNumber( ii_tag, "label_align" )
	IF li_align = 0 THEN
		tab_1.tabpage_preview.st_left.BorderStyle = StyleLowered!
		tab_1.tabpage_preview.st_center.BorderStyle = StyleRaised!
		tab_1.tabpage_preview.st_right.BorderStyle = StyleRaised!		
	ELSEIF li_align = 2 THEN
		tab_1.tabpage_preview.st_left.BorderStyle = StyleRaised!
		tab_1.tabpage_preview.st_center.BorderStyle = StyleLowered!
		tab_1.tabpage_preview.st_right.BorderStyle = StyleRaised!				
	ELSEIF li_align = 1 THEN
		tab_1.tabpage_preview.st_left.BorderStyle = StyleRaised!
		tab_1.tabpage_preview.st_center.BorderStyle = StyleRaised!						
		tab_1.tabpage_preview.st_right.BorderStyle = StyleLowered!
	END IF

	//allign field
	li_align = tab_1.tabpage_columns.dw_view_fields.GetItemNumber( ii_tag, "field_align" )
	IF li_align = 0 THEN
		tab_1.tabpage_preview.st_f_left.BorderStyle = StyleLowered!
		tab_1.tabpage_preview.st_f_center.BorderStyle = StyleRaised!
		tab_1.tabpage_preview.st_f_right.BorderStyle = StyleRaised!		
	ELSEIF li_align = 2 THEN
		tab_1.tabpage_preview.st_f_left.BorderStyle = StyleRaised!
		tab_1.tabpage_preview.st_f_center.BorderStyle = StyleLowered!
		tab_1.tabpage_preview.st_f_right.BorderStyle = StyleRaised!				
	ELSEIF li_align = 1 THEN
		tab_1.tabpage_preview.st_f_left.BorderStyle = StyleRaised!
		tab_1.tabpage_preview.st_f_center.BorderStyle = StyleRaised!						
		tab_1.tabpage_preview.st_f_right.BorderStyle = StyleLowered!
	END IF	
END IF

ls_selected_object = This.GetObjectAtPointer()
ls_selected_object_name = MidA(ls_selected_object, 1, PosA(ls_selected_object, "	" ) -1 )

IF NOT ib_multi_select THEN
	FOR i = 1 TO ii_obj_select_cnt
		IF RightA(is_last_object[i], 2) = "_t" THEN
			//This.Modify( is_last_object[i] + ".border = '0'" )
		ELSE
			//This.Modify( is_last_object[i] + ".border = '5'" )
		END IF
	END FOR
END IF

IF ii_obj_select_cnt = 1 THEN
	IF ls_selected_object_name <> is_last_object[1] THEN
		ib_resize_height = False
		ib_resize_width = False
	END IF
END IF

IF ( ls_selected_object_name = "" AND ii_obj_select_cnt = 0 ) THEN
	ii_field_id[] = li_field_id[]
	RETURN
END IF
	
IF (ls_selected_object_name = "" AND ii_obj_select_cnt > 0) THEN
	ib_multi_select = False
	FOR i = 1 TO ii_obj_select_cnt
		IF RightA(is_last_object[i], 2) = "_t" THEN
			//This.Modify( is_last_object[i] + ".border = '0'" )
		ELSE
			//This.Modify( is_last_object[i] + ".border = '5'" )
		END IF
	END FOR
	is_last_object[] = ls_last_field_temp[]
	ii_field_id[] = li_field_id[]
	il_ancor_x = 0
	il_ancor_y = 0	
	ii_obj_select_cnt = 0
	RETURN 0
END IF

IF ib_multi_select THEN
	ii_obj_select_cnt ++
ELSE
	ii_obj_select_cnt = 1
END IF

is_last_border[ii_obj_select_cnt] = This.Describe( ls_selected_object_name + ".border" )

IF ii_obj_select_cnt = 1 THEN
	il_ancor_x = Pointerx()
	il_ancor_y = Pointery()
   is_last_object_width = This.Describe( ls_selected_object_name + ".width" )
   is_last_object_height = This.Describe( ls_selected_object_name + ".height" )
END IF

is_last_object[ii_obj_select_cnt] = ls_selected_object_name

ii_field_id[ii_obj_select_cnt] = Integer( This.Describe( is_last_object[ii_obj_select_cnt] + ".tag" ) )

il_last_object_y[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".y") )
il_last_object_x[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".x") )
il_last_object_width[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".width") )
il_last_object_height[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".height"))

//w_design_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
//									"  Y:" + String(il_last_object_y[1]) +&
//									"  Width:" + String(il_last_object_width[1]) +&
//									"  Height:" + String(il_last_object_height[1])
//														
//
//w_design_menu.st_object_name.Text = is_last_object[1]

//This.Modify( ls_selected_object_name + ".border = '2'" )

//mod this
ls_field_id = This.Describe( is_last_object[1] + ".tag" )

//IF Pos( is_last_object[1], "obj" ) = 0 AND ls_selected_object_name <> "detail_band" THEN
//	dw_properties.SetFilter("data_view_fields_field_id = " + ls_field_id )
//	dw_properties.Filter()
//END IF

ls_text = This.Describe( ls_selected_object_name + ".text" )

IF ls_text <> "?" AND ls_text <> "!" THEN
	//w_design_menu.dw_1.SetText( ls_text )
END IF

ls_alignment = This.Describe(is_last_object[ii_obj_select_cnt] + ".alignment")

//w_design_menu.st_left.BorderStyle = StyleRaised!
//w_design_menu.st_right.BorderStyle = StyleRaised!
//w_design_menu.st_center.BorderStyle = StyleRaised!

IF ls_alignment = "0" THEN
	//w_design_menu.st_left.BorderStyle = StyleLowered!
ELSEIF ls_alignment = "1" THEN
	//w_design_menu.st_right.BorderStyle = StyleLowered!
ELSE
	//w_design_menu.st_center.BorderStyle = StyleLowered!
END IF

ls_weight = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.weight")
IF ls_weight = "400" THEN
	//w_design_menu.st_bold.BorderStyle = StyleRaised!
ELSE
	//w_design_menu.st_bold.BorderStyle = StyleLowered!
END IF

ls_italic = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.italic")
IF ls_italic = "0" THEN
	//w_design_menu.st_italic.BorderStyle = StyleRaised!
ELSE
	//w_design_menu.st_italic.BorderStyle = StyleLowered!
END IF

ls_underline = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.underline")
IF ls_underline = "0" THEN
	//w_design_menu.st_underline.BorderStyle = StyleRaised!
ELSE
	//w_design_menu.st_underline.Style = StyleLowered!
END IF
end event

event lbuttondown;call super::lbuttondown;ib_mouse_down = True
Integer i
Integer li_found = 0
String ls_selected_object

IF flags <> 9 AND ib_multi_select THEN
	ls_selected_object = This.GetObjectAtPointer()
	ls_selected_object = MidA(ls_selected_object, 1, PosA(ls_selected_object, "	" ) -1 )
	FOR i = 1 TO ii_obj_select_cnt 
		IF is_last_object[i] = ls_selected_object THEN
			li_found = 1
		END IF
	END FOR
	IF li_found = 0 THEN
		ib_multi_select = False
	ELSE
	   il_ancor_x = Pointerx()
		il_ancor_y = Pointery()
	END IF
END IF

IF flags = 9 THEN
	ib_control_down = True
	ib_multi_select = True
ELSE
	ib_control_down = False
	IF ib_multi_select THEN
		FOR i = 1 TO ii_obj_select_cnt	
			il_last_object_y[i] = Long( This.Describe( is_last_object[i] + ".y") )
			il_last_object_x[i] = Long( This.Describe( is_last_object[i] + ".x") )
		END FOR
	ELSE
		//il_ancor_x = Pointerx()
		//il_ancor_y = Pointery()
		//w_prac_data_design.title = String(il_ancor_y)		
	END IF
	
	//FOR i = 1 TO ii_obj_select_cnt	
	//
END IF
end event

event lbuttonup;call super::lbuttonup;ib_mouse_down = False

ib_resize_height = False
ib_resize_width = False
end event

type st_9 from statictext within tabpage_preview
integer x = 1673
integer y = 224
integer width = 352
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Border Style"
boolean focusrectangle = false
end type

type st_10 from statictext within tabpage_preview
integer x = 1669
integer y = 284
integer width = 155
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Box"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;messagebox("", is_report_type )
end event

type st_11 from statictext within tabpage_preview
integer x = 1829
integer y = 284
integer width = 178
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "line"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_12 from statictext within tabpage_preview
integer x = 2016
integer y = 284
integer width = 151
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "None"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type tabpage_run from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3497
integer height = 2100
boolean enabled = false
long backcolor = 79741120
string text = "Run Report"
long tabbackcolor = 79741120
string picturename = "Run!"
long picturemaskcolor = 12632256
dw_run dw_run
cb_next_run cb_next_run
cb_saveas cb_saveas
cb_print cb_print
cb_filter cb_filter
cb_sort cb_sort
cb_17 cb_17
st_step st_step
dw_save_sql dw_save_sql
cb_sql cb_sql
cb_13 cb_13
st_sql st_sql
dw_wizard dw_wizard
cb_4 cb_4
end type

on tabpage_run.create
this.dw_run=create dw_run
this.cb_next_run=create cb_next_run
this.cb_saveas=create cb_saveas
this.cb_print=create cb_print
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.cb_17=create cb_17
this.st_step=create st_step
this.dw_save_sql=create dw_save_sql
this.cb_sql=create cb_sql
this.cb_13=create cb_13
this.st_sql=create st_sql
this.dw_wizard=create dw_wizard
this.cb_4=create cb_4
this.Control[]={this.dw_run,&
this.cb_next_run,&
this.cb_saveas,&
this.cb_print,&
this.cb_filter,&
this.cb_sort,&
this.cb_17,&
this.st_step,&
this.dw_save_sql,&
this.cb_sql,&
this.cb_13,&
this.st_sql,&
this.dw_wizard,&
this.cb_4}
end on

on tabpage_run.destroy
destroy(this.dw_run)
destroy(this.cb_next_run)
destroy(this.cb_saveas)
destroy(this.cb_print)
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.cb_17)
destroy(this.st_step)
destroy(this.dw_save_sql)
destroy(this.cb_sql)
destroy(this.cb_13)
destroy(this.st_sql)
destroy(this.dw_wizard)
destroy(this.cb_4)
end on

type dw_run from u_dw within tabpage_run
integer x = 1358
integer y = 40
integer width = 2098
integer height = 1816
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Report Preview"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
end event

event retrieveend;call super::retrieveend;tab_1.tabpage_run.st_step.Text = "Report Returned " + String( rowcount ) + " Rows"
end event

event resize;call super::resize;cb_print.BringToTop = True
cb_filter.BringToTop = True
cb_saveas.BringToTop = True
cb_sort.BringToTop = True

end event

event clicked;call super::clicked;//messagebox("", dw_run.GetClickedColumn ( ))
end event

type cb_next_run from commandbutton within tabpage_run
integer x = 293
integer y = 1892
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Next-->"
end type

event clicked;//debugbreak()
of_next_wizard()

//dw_run.Describe("<Reportname>.Name")
//dw_run.Modify("Width='<the width of the object in the units specified for the DataWindow>'")

//dw_run.Modify("DataWindow.Print.Paper.Size='1'")
//IF tab_1.tabpage_browse.dw_report_list.GetItemString( tab_1.tabpage_browse.dw_report_list.GetRow(), "orientation" ) =  "P" THEN
//	dw_run.Modify("DataWindow.Print.Orientation= '2'")
//ELSE
//	dw_run.Modify("DataWindow.Print.Orientation= '1'")	
//END IF
//

//of_preview( dw_run )
end event

type cb_saveas from commandbutton within tabpage_run
integer x = 2546
integer y = 1892
integer width = 256
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save As.."
end type

event clicked;gnv_dw.of_SaveAs(dw_run)//.SaveAs() Modify by Evan 05.11.2010
end event

type cb_print from commandbutton within tabpage_run
integer x = 2272
integer y = 1892
integer width = 256
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print"
end type

event clicked;dw_run.Print()
end event

type cb_filter from commandbutton within tabpage_run
integer x = 2007
integer y = 1892
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Filter.."
end type

event clicked;String ls_null
Long ll_row_count

SetNull( ls_null )

dw_run.SetFilter( ls_null )
dw_run.Filter()

ll_row_count = dw_run.RowCount( )

tab_1.tabpage_run.st_step.Text = "Report Returned " + String( ll_row_count ) + " Rows"
end event

type cb_sort from commandbutton within tabpage_run
integer x = 1742
integer y = 1892
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sort.."
end type

event clicked;String ls_null

SetNull( ls_null )

dw_run.SetSort( ls_null )
dw_run.Sort()
dw_run.groupcalc()
end event

type cb_17 from commandbutton within tabpage_run
integer x = 27
integer y = 1892
integer width = 247
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Reset"
end type

event clicked;is_filter = ""
of_wizard_setup()
tab_1.tabpage_run.st_sql.Text = ""
tab_1.tabpage_run.st_sql.Visible = False
tab_1.tabpage_run.cb_next_run.Enabled = True

end event

type st_step from statictext within tabpage_run
integer x = 2834
integer y = 1872
integer width = 645
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type dw_save_sql from datawindow within tabpage_run
boolean visible = false
integer x = 805
integer y = 1884
integer width = 142
integer height = 72
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_print_space"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_sql from commandbutton within tabpage_run
integer x = 558
integer y = 1892
integer width = 270
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Save SQL"
end type

event clicked;string ls_sql


ls_sql = tab_1.tabpage_run.st_sql.Text
clipboard(ls_sql)

messagebox("Saved","On Clipboard")



end event

type cb_13 from commandbutton within tabpage_run
integer x = 1358
integer y = 1892
integer width = 366
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Collapse Detail"
end type

event clicked;IF This.Text = "Collapse Detail" THEN
	dw_run.Modify("DataWindow.detail.Height='0'")	
	This.Text = "Show Detail"
ELSE
	dw_run.Modify("DataWindow.detail.Height='75'")	
	This.Text = "Collapse Detail"	
END IF
end event

type st_sql from statictext within tabpage_run
integer x = 37
integer y = 44
integer width = 1303
integer height = 1804
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_wizard from u_dw within tabpage_run
integer x = 37
integer y = 44
integer width = 1307
integer height = 1808
integer taborder = 11
string dragicon = "Rectangle!"
string dataobject = "d_crit_custom"
boolean hscrollbar = true
end type

event retrieveend;call super::retrieveend;This.InsertRow( 1 )
IF This.DataObject <> "d_crit_date_range_custom" AND This.DataObject <> "d_crit_single_date_custom" AND This.DataObject <> "d_crit_facility" AND This.DataObject <> "d_crit_address_type_ir" AND This.DataObject <> "d_crit_net_dev_type_ir" AND This.DataObject <> "d_crit_app_payor" THEN
	This.SetItem( 1, "selected", 1 )
	This.SetItem( 1, "lookup_code", 0 )
	This.SetItem( 1, "code", "All" )
	IF is_wizard_lookup_type[ ii_current_wizard_step ] = "C" THEN
		This.SetItem( 1, "description", "Include All selections" )		
	ELSE
		This.SetItem( 1, "entity_name", "Include All selections" )			
	END IF
ELSEIF This.DataObject = "d_crit_facility"  THEN
	This.SetItem( 1, "selected", 1 )
	This.SetItem( 1, "facility_id", 0 )
	This.SetItem( 1, "facility_name", "All" )	
ELSEIF This.DataObject = "d_crit_net_dev_type_ir"  THEN
	This.SetItem( 1, "selected", 1 )
	//This.SetItem( 1, "facility_id", 0 )
	This.SetItem( 1, "code", "All" )	
ELSEIF This.DataObject = "d_crit_app_payor"  THEN
	This.SetItem( 1, "selected", 1 )
	//This.SetItem( 1, "facility_id", 0 )
	This.SetItem( 1, "application_name", "All" )	
END IF
end event

event constructor;call super::constructor;//This.SetUpdatAble( False )

end event

event itemchanged;call super::itemchanged;IF data = "1" AND row = 1 THEN
	Integer li_rc
	Integer i
	li_rc = This.RowCount()
	FOR i = 2 TO li_rc
		This.SetItem( i, "selected", 0 )
	END FOR
ELSEIF data = "1" AND row <> 1 THEN
	This.SetItem( 1, "selected", 0 )
END IF
end event

type cb_4 from commandbutton within tabpage_run
integer x = 2866
integer y = 1892
integer width = 256
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Test"
end type

event clicked;//string ls_valid
//ls_valid = dw_composite.Object.rpt_employee. Object.emp_id.Validation

//String dwsyntax
//dwsyntax = dw_run.Describe("DataWindow.Syntax")
//rtncode = LibraryImport("c:\pb\dwTemp.pbl", "d_emp", ImportDataWindow!, dwsyntax, ErrorBuffer, "Employee DataWindow 1")
//
//LibraryDelete("c:\pb\dwTemp.pbl", "d_emp", ImportDataWindow!)

//this builds the datawindow calls of_build_view_sql()
//messagebox("of_preview","")
end event

type cb_15 from commandbutton within w_custom_report5
integer x = 2816
integer y = 44
integer width = 247
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "About"
end type

event clicked;Messagebox("IntelliReport","Version 4.5 ~r  10-2004")
end event

type cb_8 from commandbutton within w_custom_report5
integer x = 3319
integer y = 44
integer width = 247
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;garbagecollect()
Close(parent)
end event

type cb_qhelp from commandbutton within w_custom_report5
integer x = 3067
integer y = 44
integer width = 247
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Help"
end type

event clicked;Openwithparm( w_help_window,2)
end event

