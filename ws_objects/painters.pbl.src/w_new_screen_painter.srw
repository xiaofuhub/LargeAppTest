$PBExportHeader$w_new_screen_painter.srw
forward
global type w_new_screen_painter from window
end type
type cb_close from commandbutton within w_new_screen_painter
end type
type tab_1 from tab within w_new_screen_painter
end type
type tabpage_table from userobject within tab_1
end type
type st_10 from statictext within tabpage_table
end type
type st_9 from statictext within tabpage_table
end type
type st_6 from statictext within tabpage_table
end type
type st_5 from statictext within tabpage_table
end type
type rb_mod from radiobutton within tabpage_table
end type
type rb_new_table from radiobutton within tabpage_table
end type
type cb_4 from commandbutton within tabpage_table
end type
type cb_sys_save from commandbutton within tabpage_table
end type
type st_4 from statictext within tabpage_table
end type
type dw_detail from datawindow within tabpage_table
end type
type dw_browse from datawindow within tabpage_table
end type
type dw_table_exists from datawindow within tabpage_table
end type
type cb_sys_add from commandbutton within tabpage_table
end type
type cb_view from commandbutton within tabpage_table
end type
type cbx_facility from checkbox within tabpage_table
end type
type st_3 from statictext within tabpage_table
end type
type sle_table_name from singlelineedit within tabpage_table
end type
type cb_create from commandbutton within tabpage_table
end type
type cb_delete from commandbutton within tabpage_table
end type
type cb_add from commandbutton within tabpage_table
end type
type dw_table_struct from datawindow within tabpage_table
end type
type gb_2 from groupbox within tabpage_table
end type
type gb_3 from groupbox within tabpage_table
end type
type gb_4 from groupbox within tabpage_table
end type
type cb_sys_del from commandbutton within tabpage_table
end type
type tabpage_table from userobject within tab_1
st_10 st_10
st_9 st_9
st_6 st_6
st_5 st_5
rb_mod rb_mod
rb_new_table rb_new_table
cb_4 cb_4
cb_sys_save cb_sys_save
st_4 st_4
dw_detail dw_detail
dw_browse dw_browse
dw_table_exists dw_table_exists
cb_sys_add cb_sys_add
cb_view cb_view
cbx_facility cbx_facility
st_3 st_3
sle_table_name sle_table_name
cb_create cb_create
cb_delete cb_delete
cb_add cb_add
dw_table_struct dw_table_struct
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
cb_sys_del cb_sys_del
end type
type tabpage_screen from userobject within tab_1
end type
type st_11 from statictext within tabpage_screen
end type
type st_8 from statictext within tabpage_screen
end type
type st_7 from statictext within tabpage_screen
end type
type cb_save_dv from commandbutton within tabpage_screen
end type
type cb_7 from commandbutton within tabpage_screen
end type
type cb_6 from commandbutton within tabpage_screen
end type
type cb_1 from commandbutton within tabpage_screen
end type
type cb_2 from commandbutton within tabpage_screen
end type
type dw_data_view_screen from datawindow within tabpage_screen
end type
type dw_data_views from datawindow within tabpage_screen
end type
type cb_3 from commandbutton within tabpage_screen
end type
type st_1 from statictext within tabpage_screen
end type
type dw_screen from u_dw within tabpage_screen
end type
type rb_append from radiobutton within tabpage_screen
end type
type rb_new from radiobutton within tabpage_screen
end type
type st_2 from statictext within tabpage_screen
end type
type dw_table from datawindow within tabpage_screen
end type
type dw_sys_fields from datawindow within tabpage_screen
end type
type gb_1 from groupbox within tabpage_screen
end type
type dw_sys_fields_add from datawindow within tabpage_screen
end type
type dw_data_view_field from datawindow within tabpage_screen
end type
type dw_ver_ltr from datawindow within tabpage_screen
end type
type tabpage_screen from userobject within tab_1
st_11 st_11
st_8 st_8
st_7 st_7
cb_save_dv cb_save_dv
cb_7 cb_7
cb_6 cb_6
cb_1 cb_1
cb_2 cb_2
dw_data_view_screen dw_data_view_screen
dw_data_views dw_data_views
cb_3 cb_3
st_1 st_1
dw_screen dw_screen
rb_append rb_append
rb_new rb_new
st_2 st_2
dw_table dw_table
dw_sys_fields dw_sys_fields
gb_1 gb_1
dw_sys_fields_add dw_sys_fields_add
dw_data_view_field dw_data_view_field
dw_ver_ltr dw_ver_ltr
end type
type tab_1 from tab within w_new_screen_painter
tabpage_table tabpage_table
tabpage_screen tabpage_screen
end type
end forward

global type w_new_screen_painter from window
integer x = 5
integer y = 48
integer width = 3648
integer height = 2216
boolean titlebar = true
string title = "New Screen Painter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_close cb_close
tab_1 tab_1
end type
global w_new_screen_painter w_new_screen_painter

type variables
integer ii_table
boolean ib_new = false
string is_table
end variables

forward prototypes
public function integer of_create_screen ()
public function string of_table_syntax ()
public function integer of_verif_letter_sql ()
public function string of_test_column (string as_col, string as_tc)
public function integer of_table_alter (integer ai_row)
public function integer of_create_view ()
public function string of_get_table_name ()
public function integer of_verif_rules (integer ai_screen)
public function integer of_add_single_dv_field (integer ai_row)
end prototypes

public function integer of_create_screen ();Datawindowchild dwchild

Boolean lb_facility_level

Long ll_next_dv_id
Long ll_label_y = 100
Long ll_field_y = 164
Long ll_label_x = 100
Long ll_field_x = 100
Long ll_next_field_id
Integer li_retval
Integer li_code_lookup_cnt
Integer li_address_lookup_cnt
Integer li_facility_id
Integer li_found
Integer li_append_to_screen_id
Integer li_next_screen_id  
Integer li_next_screen_order  
Integer loop_cnt
Integer li_nr
Integer li_rc
Integer li_dv_cnt = 1
Integer d
Integer i
Integer li_table_id
integer res
String ls_field_orig
String ls_view_where_sql
String ls_view_field_sql
String ls_view_from_sql

String ls_ltr_where_sql
String ls_ltr_field_sql
String ls_ltr_from_sql
String ls_group_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_stripped_field
String ls_sql
String ls_field
String ls_ver_ltr_sql
String ls_from_sql
String ls_where_sql
String ls_ver_ltr_doc
String ls_field_sql
String ls_exp_doc_name
String  ls_coltype
String ls_table
String ls_screen_name
String ls_alpha[10]

ls_alpha[1] = 'A'
ls_alpha[2] = 'B'
ls_alpha[3] = 'C'
ls_alpha[4] = 'D'
ls_alpha[5] = 'E'
ls_alpha[6] = 'F'
ls_alpha[7] = 'G'
ls_alpha[8] = 'H'
ls_alpha[9] = 'I'
ls_alpha[10] = 'J'


ls_screen_name = of_get_table_name()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 03.18.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Collect SQL statements and integrate them into Appeon Queue labels
//$<modification> to reduce client-server interactions. Refer to PT-04/5/6 for more information.

/*
select screen_id into :d from data_view_screen where table_id = :ii_table;
*/
gnv_appeondb.of_startqueue()
select screen_id into :d from data_view_screen where table_id = :ii_table;
SELECT Max( screen_id )  INTO :li_next_screen_id  FROM data_view_screen  ;
SELECT Max( screen_order ) INTO :li_next_screen_order FROM data_view_screen WHERE data_view_screen.data_view_id = 1;
SELECT Max( data_view_field_id )  INTO :ll_next_dv_id FROM data_view_fields  ;
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

if d > 1 then
	res = messagebox(" Screen", ls_screen_name + " screen already exists; Do you want to delete and recreate?",question!,yesno!,2)
	if res = 1 then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-02
		//$<add> 03.18.2006 By: Cao YongWang
		//$<reason> Performance tuning.
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_startqueue()
		//---------------------------- APPEON END ----------------------------

		delete from data_view_fields where screen_id = :d;
		delete from data_view_screen where screen_id = :d;
		delete from facility_ver_rules where screen_id = :d;
		commit using sqlca;
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-03
		//$<add> 03.18.2006 By: Cao YongWang
		//$<reason> Performance tuning.
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_commitqueue()
		//---------------------------- APPEON END ----------------------------
	else
		return 1
	end if
end if
	
	
li_rc = tab_1.tabpage_screen.dw_sys_fields.RowCount()

li_table_id  = ii_table 

tab_1.tabpage_screen.dw_data_view_screen.SetTransObject( sqlca )
tab_1.tabpage_screen.dw_data_view_field.SetTransObject( sqlca )


//add the new screen to data view 1.   
tab_1.tabpage_screen.dw_data_view_screen.Reset()
tab_1.tabpage_screen.dw_data_view_screen.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<comment> 03.18.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Move the following script to PT-01. It is integrated into
//$<modification> Appeon Queue labels to reduce client-server interactions.
/*
SELECT Max( screen_id )  INTO :li_next_screen_id  FROM data_view_screen  ;
*/
//---------------------------- APPEON END ----------------------------

if li_next_screen_id < 100 then li_next_screen_id = 100

li_next_screen_id  ++
//create screen record
tab_1.tabpage_screen.dw_data_view_screen.InsertRow( 0 )
tab_1.tabpage_screen.dw_data_view_screen.SetItem( 1, "data_view_id", 1 )
tab_1.tabpage_screen.dw_data_view_screen.SetItem( 1, "screen_id", li_next_screen_id )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<comment> 03.18.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Move the following script to PT-01. It is integrated into
//$<modification> Appeon Queue labels to reduce client-server interactions.
/*
SELECT Max( screen_order ) INTO :li_next_screen_order FROM data_view_screen WHERE data_view_screen.data_view_id = 1;
*/
//---------------------------- APPEON END ----------------------------

li_next_screen_order  ++
tab_1.tabpage_screen.dw_data_view_screen.SetItem( 1, "screen_order", li_next_screen_order )
tab_1.tabpage_screen.dw_data_view_screen.SetItem( 1, "screen_name", ls_screen_name )
tab_1.tabpage_screen.dw_data_view_screen.SetItem( 1, "screen_alias", ls_screen_name )
tab_1.tabpage_screen.dw_data_view_screen.SetItem( 1, "multi_record", 'Y'  )
tab_1.tabpage_screen.dw_data_view_screen.SetItem( 1, "table_id", li_table_id )

//IF tab_1.tabpage_screen.rb_append.Checked THEN//for making detail 2 of another screen.
//	tab_1.tabpage_screen.dw_screen.AcceptText()
//	li_append_to_screen_id = tab_1.tabpage_screen.dw_screen.GetItemNumber( 1, "screen_id"  )
//	tab_1.tabpage_screen.dw_data_view_screen.SetItem( 1, "table_id", li_table_id )
//	tab_1.tabpage_screen.dw_data_view_screen.SetItem( 1, "detail_2", 3 )			
//	UPDATE data_view_screen
//	SET table_id_2 = : li_next_screen_id
//	WHERE screen_id = :li_append_to_screen_id;
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox( "Sql Error", SQLCA.SQLERRTEXT )
//		Return -1
//	END IF
//end if




//loop through and add sys_field info into data_view_field
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<comment> 03.18.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Move the following script to PT-01. It is integrated into
//$<modification> Appeon Queue labels to reduce client-server interactions.
/*
SELECT Max( data_view_field_id )  INTO :ll_next_dv_id FROM data_view_fields  ;
*/
//---------------------------- APPEON END ----------------------------

//li_rc = tab_1.tabpage_screen.dw_sys_fields_add.RowCount()

loop_cnt  = 0 //used for determining position

FOR i = 1 TO li_rc

	ls_field = tab_1.tabpage_screen.dw_sys_fields.GetItemString( i, "field_name_allias" )
	IF ls_field = "facility_id" THEN
		lb_facility_level = True
	END IF
	//don't make for rec,prac,or facility
	
	IF ls_field = "rec_id" OR ls_field = "prac_id" Or ls_field = "facility_id" THEN
	   CONTINUE
	END IF

	loop_cnt ++	
	li_nr = tab_1.tabpage_screen.dw_data_view_field.InsertRow( 0 )
	tab_1.tabpage_screen.dw_data_view_field.SetRow( li_nr )
	tab_1.tabpage_screen.dw_data_view_field.ScrollToRow( li_nr )
	tab_1.tabpage_screen.dw_data_view_field.SetFocus()
	ll_next_dv_id++
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "data_view_id", 1)
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "data_view_field_id", ll_next_dv_id )	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "screen_id", li_next_screen_id )	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_id", tab_1.tabpage_screen.dw_sys_fields.GetItemNumber( i, "field_id" ) )	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_label", tab_1.tabpage_screen.dw_sys_fields.GetItemString( i, "field_name_allias" ) )	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_order", tab_1.tabpage_screen.dw_sys_fields.GetItemNumber( i, "field_order" ) )		
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "required", "N" )		
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_width", 500 ) 
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_label_width", 500 ) 	//30 per character
	//set field positions
	if loop_cnt = 1 then //set the first field at x/100 - y/100 additional fields 3 across and down y/150 and back to x/100
		ll_field_x = 100 //y is also 100
	elseif ll_field_x > 1400 then //x should be 100, 800 or 1500 if a 1500 reset x to 100
		ll_field_x = 100
		ll_label_y = ll_label_y + 150
		ll_field_y = ll_field_y + 150
	else
		ll_field_x = ll_field_x + 700
	end if
	
	ll_label_x = ll_field_x //label and field on the same vertical
	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_x", ll_field_x )		
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_label_x", ll_label_x )		
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_label_y", ll_label_y )					
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_y", ll_field_y )			
	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "display_only", 'N' )				
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_height", 64 )				
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "edit_field_type", "E" )	
	
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 03.18.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------
tab_1.tabpage_screen.dw_data_view_screen.Update( )
tab_1.tabpage_screen.dw_data_view_field.Update( )
tab_1.tabpage_screen.dw_sys_fields.Update()
COMMIT USING SQLCA;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<add> 03.18.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

//create  facility rules
of_verif_rules(li_next_screen_id)

//CREATE SQL FOR LETTER QUERY
//of_ver_letter_sql()

////CREATE VIEW SQL

//MessageBox("Complete", "Finished creating screen.~n~rTo create a verification letter you must name a word document as " + ls_ver_ltr_doc + " and place it in your letters directory.  Also make sure you use the " + "C:\intellicred\Letters\data\" + ls_screen_name + ".txt as the merge data file."  )
MessageBox("Complete", "Finished creating screen."  )

Return 1

end function

public function string of_table_syntax ();String ls_sql
String ls_col_name
Integer i
Integer li_rc
Integer li_table_id
Integer li_col_size
Integer li_facility_specific
integer c
string ls_test
String ls_table_name
String ls_col_type
String ls_data_type
String ls_index_sql

ls_table_name = tab_1.tabpage_table.sle_table_name.Text
IF LeftA( ls_table_name, 4 ) <> "pdc_" THEN
	MessageBox( "Table Name", "The table name must start with the prefix pdc_" )
	Return "Fail"
elseif ls_table_name = "pdc_" THEN
	MessageBox( "Table Name", "The table name must be longer than just pdc_" )
END IF

tab_1.tabpage_table.dw_table_struct.AcceptText( )

IF tab_1.tabpage_table.cbx_facility.Checked THEN
	li_facility_specific = 1 
ELSE
	li_facility_specific = 0 
END IF

ls_test = of_test_column(ls_table_name,"T") //check for valid chars in table name

if ls_test = "OK" then
	//not a problem
else
	Return "Fail"
end if

//test to see if table exists
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.18.2006 By: Cao YongWang
//$<reason> The sys.systable table not exists in SQL Server,
//$<reason> Replace it with v_systable if the appliation running in SQL Server.
/*
select count(table_id) into :c from sys.systable where table_name = :ls_table_name;
*/
Choose Case gs_dbType
	Case 'ASA'
		select count(table_id) into :c from sys.systable where table_name = :ls_table_name;
	Case 'SQL'
		select count(table_id) into :c from v_systable where table_name = :ls_table_name;
End Choose
//---------------------------- APPEON END ----------------------------

if c > 0 then
	//MessageBox( "Table Name", "Table already exists.")
	Return "EXISTS"
end if

// mskinner 07 April 2006 -- begin
ls_table_name = ls_table_name
//ls_table_name = "dba." + ls_table_name
// mskinner 07 April 2006 -- end 

ls_sql = "CREATE TABLE " + ls_table_name + " ( "

li_rc = tab_1.tabpage_table.dw_table_struct.RowCount( )

IF li_rc = 0 THEN
	MessageBox("No Fields", "You must create at least one field before creating a table." )
	Return "Fail"
END IF

FOR i = 1 TO li_rc //check and add columns 
	
	ls_col_name = tab_1.tabpage_table.dw_table_struct.GetItemString( i, "field_name" )
	ls_col_type = tab_1.tabpage_table.dw_table_struct.GetItemString( i, "field_type" )
	li_col_size = tab_1.tabpage_table.dw_table_struct.GetItemNumber( i, "field_len" )
	
	ls_test = of_test_column(ls_col_name,"C")
	if ls_test = "OK" then
		//not a problem
	else
		Return "Fail"
	end if
		
	IF IsNull( ls_col_name ) OR ls_col_name = "" THEN
		MessageBox( "Column Name", "Invalid Column Name" )
		tab_1.tabpage_table.dw_table_struct.SetColumn( "field_name" )		
		tab_1.tabpage_table.dw_table_struct.SetFocus( )
		tab_1.tabpage_table.dw_table_struct.SetRow( i )
		tab_1.tabpage_table.dw_table_struct.ScrollToRow( i )
		Return "Fail"
	END IF
	
	IF IsNull( ls_col_type ) OR ls_col_type = "" THEN
		MessageBox( "Column Type", "You need to select a Column Type." )
		tab_1.tabpage_table.dw_table_struct.SetColumn( "field_type" )
		tab_1.tabpage_table.dw_table_struct.SetFocus( )
		tab_1.tabpage_table.dw_table_struct.SetRow( i )
		tab_1.tabpage_table.dw_table_struct.ScrollToRow( i )
		Return "Fail"
	END IF
	
	IF ls_col_type = "N" AND ls_col_type = "C"  THEN
		IF IsNull( li_col_size ) OR li_col_size = 0 THEN
			MessageBox("Column Size", "The column size for " + ls_col_name + " must be greater than 0." )
			tab_1.tabpage_table.dw_table_struct.SetColumn( i )
			tab_1.tabpage_table.dw_table_struct.SetFocus( )
			Return "Fail"
		END IF
		//ls_sql = ls_sql + " (" + String( tab_1.tabpage_table.dw_table_struct.GetItemNumber( i, "col_size" ) ) 
	END IF
	
	ls_sql = ls_sql + " " + ls_col_name
	
	choose case ls_col_type
		case "N"
			ls_data_type = "NUMERIC"
			ls_sql = ls_sql + " " + ls_data_type + "(" + string(li_col_size)  + ",0)"
		case "I"
			ls_data_type = "INTEGER"
			ls_sql = ls_sql + " " + ls_data_type 
		case "D"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.18.2006 By: Cao YongWang
			//$<reason> 'TIMESTAMP' data type not exists in SQL Server.Change it to 'DATETIME' data type
			/*
			ls_data_type = "TIMESTAMP"
			*/
			ls_data_type = "DATETIME"
			//---------------------------- APPEON END ----------------------------
			ls_sql = ls_sql + " " + ls_data_type
		case "C"
			ls_data_type = "VARCHAR"
			ls_sql = ls_sql + " " + ls_data_type + "(" + string(li_col_size)  + ")"
		case "L"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.18.2006 By: Cao YongWang
			//$<reason> "LONG VARCHAR" data type is not exists in SQL Server. Replace it with TEXT data type in SQL Server
			/*
			ls_data_type = "LONG VARCHAR"
			*/
			Choose Case gs_dbType
				Case 'ASA'
					ls_data_type = "LONG VARCHAR"
				Case 'SQL'
					ls_data_type = "TEXT"
			End Choose
			//---------------------------- APPEON END ----------------------------
			ls_sql = ls_sql + " " + ls_data_type
	end choose
	

	IF  ls_col_name = "rec_id" or ls_col_name = "prac_id" THEN
		ls_sql = ls_sql + " NOT NULL ," + "~n~r"	
	ELSE
		ls_sql = ls_sql + " NULL ,~n~r"		
	END IF
	
END FOR

ls_sql = MidA( ls_sql, 1, LenA( ls_sql )-3 )

ls_sql = ls_sql + " );"

return ls_sql
end function

public function integer of_verif_letter_sql ();Datawindowchild dwchild


Long ll_next_field_id
Integer li_retval
Integer li_code_lookup_cnt
Integer li_address_lookup_cnt
Integer li_facility_id
Integer li_found
Integer li_append_to_screen_id
Integer li_next_screen_id  
Integer li_next_screen_order  
Integer loop_cnt
Integer li_nr
Integer li_rc
Integer li_dv_cnt
Integer d
Integer i
Integer li_table_id

String ls_field_orig

String ls_ltr_where_sql
String ls_ltr_field_sql
String ls_ltr_from_sql
String ls_group_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_stripped_field
String ls_sql
String ls_field
String ls_ver_ltr_sql
String ls_from_sql
String ls_where_sql
String ls_ver_ltr_doc
String ls_field_sql
String ls_exp_doc_name
String  ls_coltype
String ls_table
String ls_screen_name
string ls_alpha[10]
string ls_tab2

ls_alpha[1] = 'A'
ls_alpha[2] = 'B'
ls_alpha[3] = 'C'
ls_alpha[4] = 'D'
ls_alpha[5] = 'E'
ls_alpha[6] = 'F'
ls_alpha[7] = 'G'
ls_alpha[8] = 'H'
ls_alpha[9] = 'I'
ls_alpha[10] = 'J'

//CREATE SQL FOR LETTER QUERY
ls_ltr_field_sql = "SELECT verif_info.rec_id,~n~r" +&
         "verif_info.facility_id,~n~r" +&   
         "verif_info.first_sent,~n~r" +&      
         "verif_info.last_sent,~n~r" +&      
         "verif_info.doc_id,~n~r" +&      
         "v_full_name.prac_id,~n~r" +&      
         "v_full_name.full_name,~n~r" +&      
         "v_full_name.date_of_birth,~n~r" +&      
         "v_full_name.ssn,~n~r" +&      
         "v_full_name.title,~n~r" +&      
         "v_full_name.first_name,~n~r" +&      
         "v_full_name.middle_name,~n~r" +&      
         "v_full_name.last_name,~n~r" +&      
         "v_full_name.prof_suffix,~n~r" +&      
         "facility.return_facility_name,~n~r" +&      
         "facility.return_street,~n~r" +&      
         "facility.return_street_2,~n~r" +&      
         "facility.return_city,~n~r" +&      
         "facility.return_state,~n~r" +&      
         "facility.return_phone,~n~r" +&      
         "facility.return_ext,~n~r" +&      
         "facility.return_fax,~n~r" +&      
         "facility.return_zip,~n~r" +&      
         "facility.credentialing_contact_name,~n~r" +&      
         "facility.credentialing_contact_title,~n~r" +&      
         "parent_facility_name = '',~n~r" +&      
         "number_sent = verif_info.number_sent + 1,~n~r"
	
ls_ltr_from_sql = "FROM v_full_name, ~n~r" +&     
			       		  "verif_info,~n~r" +&      
			       	     "facility,~n~r" 

ls_ltr_from_sql = ls_ltr_from_sql + "" + ls_table + ",~n~r" 

ls_ltr_where_sql = "WHERE ( verif_info.facility_id = facility.facility_id ) AND~n~r" +&     
        					 "( v_full_name.prac_id = verif_info.prac_id ) AND~n~r" +&     
				          "( verif_info.active_status = 1 ) AND~n~r" +&     
				          "( verif_info.exp_credential_flag <> 1 ) AND~n~r" +&
							 "( v_full_name.prac_id = " + ls_table + ".prac_id ) AND ~n~r"
						
//						debugbreak()
FOR i = 1 TO li_rc	
	ls_field_orig = tab_1.tabpage_screen.dw_sys_fields.GetItemString( i, "field_name_orig" )
	ls_field = "" + ls_table + "." + ls_field_orig
	ls_stripped_field = tab_1.tabpage_screen.dw_sys_fields.GetItemString( i,"field_name_orig" )
	IF tab_1.tabpage_screen.dw_sys_fields.GetItemString( i, "lookup_field" )  = "N" THEN
		ls_field_sql = ls_field_sql + ls_field + ","
	ELSE
		IF tab_1.tabpage_screen.dw_sys_fields.GetItemString( i,"lookup_type" ) = "C" THEN
			li_code_lookup_cnt++	
						
			ls_field_sql = ls_field_sql + ls_stripped_field + "_code = code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".code,~n~r"
			ls_field_sql = ls_field_sql + ls_stripped_field + "_descr = code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".description,~n~r"	
			
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 06.20.2012
			//$<reason>  V12.2 SQL Server 2008 Support
			/*
			ls_from_sql = ls_from_sql + "code_lookup code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ",~n~r"
			ls_where_sql = ls_where_sql + "( code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".lookup_code =* " + ls_field + ") AND~n~r "
			*/
			ls_tab2 = ls_table + " " + ls_table +"_"+string(i)         
			ls_field =  ls_table +"_"+string(i) + "." + ls_field_orig 
			ls_from_sql = ls_from_sql + "code_lookup code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + " right outer join " +ls_tab2
			ls_from_sql = ls_from_sql + " on "+ "( code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".lookup_code = " +  ls_field  + "),~n~r"
			//------------------- APPEON END -------------------
		ELSEIF tab_1.tabpage_screen.dw_sys_fields.GetItemString( i, "lookup_type" ) = "A" THEN			
			li_address_lookup_cnt++	
						
			ls_field_sql = ls_field_sql + ls_stripped_field + "_code = address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".code,~n~r"
			ls_field_sql = ls_field_sql + ls_stripped_field + "_name = address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".entity_name,~n~r"		
			
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 06.20.2012
			//$<reason>  V12.2 SQL Server 2008 Support
			/*
			ls_where_sql = ls_where_sql + "( address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".lookup_code =* " + ls_field + ") AND~n~r"
			ls_from_sql = ls_from_sql + "address_lookup address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ",~n~r"	
			*/
			ls_tab2 = ls_table + " " + ls_table +"_"+string(i)        
			ls_field =  ls_table +"_"+string(i) + "." + ls_field_orig 
			ls_from_sql = ls_from_sql + "address_lookup address_lookup_" + ls_alpha[ li_address_lookup_cnt ] +" right outer join " +ls_tab2
			ls_from_sql = ls_from_sql + " on "+ "( address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".lookup_code = " + ls_field  +  "),~n~r"	
			//------------------- APPEON END -------------------
		ELSE
			ls_field_sql = ls_field_sql + ls_field + ",~n~r"
		END IF
	END IF	
END FOR

//ls_field_sql = ls_ltr_field_sql + ls_field_sql
//ls_from_sql = ls_ltr_from_sql +  ls_from_sql
//ls_where_sql = ls_ltr_where_sql + ls_where_sql

ls_ltr_field_sql = MidA( ls_ltr_field_sql + ls_field_sql, 1, LenA( ls_ltr_field_sql + ls_field_sql )-3 )
ls_ltr_from_sql =  MidA( ls_ltr_from_sql +  ls_from_sql, 1, LenA( ls_ltr_from_sql +  ls_from_sql )-3 )
ls_ltr_where_sql = MidA( ls_ltr_where_sql + ls_where_sql, 1, LenA( ls_ltr_where_sql + ls_where_sql )-6 )

ls_sql =  ls_ltr_field_sql + " " + ls_ltr_from_sql + " " + ls_ltr_where_sql
  
//ClipBoard( ls_sql )  
    
UPDATE sys_tables
SET ver_ltr_sql = :ls_sql
WHERE table_id = :li_table_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Sql Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

ls_group_syntax = ""
ls_grey = String(rgb(192,192,192))
ls_white = String(rgb(255,255,255))
ls_presentation_str = "style( type=Group) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF

//Open( w_preview_data )

tab_1.tabpage_screen.dw_ver_ltr.Create( ls_dwsyntax_str, ERRORS)


IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN -1
END IF

tab_1.tabpage_screen.dw_ver_ltr.SetTransObject( SQLCA )
tab_1.tabpage_screen.dw_ver_ltr.InsertRow( 0 )
FOR i = 1 TO 3
	tab_1.tabpage_screen.dw_ver_ltr.SetItem( 1, 1, 12 )
END FOR

li_retval = tab_1.tabpage_screen.dw_ver_ltr.SaveAs( gs_temp_path + "Letters\data\" + ls_screen_name + ".txt", Text!, True)

return 1
end function

public function string of_test_column (string as_col, string as_tc);string ls_column
integer li_loop
integer i
string s
string res = "OK"
integer p
string ls_errtype

if as_tc = "T" then
	ls_errtype = "Table"
elseif as_tc = "C" then
	ls_errtype = "Column Name"
end if


ls_column = as_col

//trap for number as first char
s = MidA(ls_column,1,1)
if isnumber(s) then
	res = "100"
else
	for i = 1 to 13
		choose case i
			case 1
				s = " "
			case 2
				s = "!"
			case 3
				s = "@"
			case 4
				s = "$"
			case 5
				s = "%"
			case 6
				s = "#"
			case 7
				s = "*"
			case 8
				s = "&"
			case 9
				s = "?"
			case 10
				s = "+"
			case 11
				s = "/"
			case 12
				s = ">"
			case 13
				s = "-"
		end choose
		p = PosA(ls_column,s,1)
		if p > 0 then
			res = s
			exit
		end if
	next
end if
	

if res = "OK" then
	return "OK"	
elseif res = "100" then
	MessageBox( "Column Name", "Invalid Character used in " + ls_errtype + " " + ls_column + ".  First character cannot be a number.")
	Return "Fail"
else
	MessageBox( "Column Name", "Invalid Character " + res + " used in " + ls_errtype + " " + ls_column )
	Return "Fail"
end if
	
	
		
end function

public function integer of_table_alter (integer ai_row);string ls_table
string ls_sql
string ls_col
string ls_type
string ls_len
string ls_con

// mskinner 07 april 2006 -- begin
/// remove dba
select table_name into :ls_table from sys_tables where table_id = :ii_table;
// mskinner 07 april 2006 -- end

ls_col = tab_1.tabpage_table.dw_detail.getitemstring(ai_row,"field_name")
ls_type = tab_1.tabpage_table.dw_detail.getitemstring(ai_row,"field_type")
ls_len = string(tab_1.tabpage_table.dw_detail.getitemnumber(ai_row,"field_len"))

choose case ls_type
	case "D"
		ls_con = "Timestamp"
	case "I"
		ls_con = "Integer"
	case "N"
		ls_con = "Numeric(" + ls_len + ",0)"
	case "L"
		ls_con = "long Varchar"
	Case "C"
		ls_con = "Varchar(" + ls_len + ")"
end choose

ls_sql = "Alter table " + ls_table + " add " + ls_col + " " + ls_con + " null"

//messagebox("",ls_sql)

EXECUTE IMMEDIATE :ls_sql;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Alter", "Failed table alter." )
	messagebox("SQL",ls_sql)
	ClipBoard( ls_sql ) 
else
	MessageBox("Alter", "Alter completed." )
END IF




return 1
end function

public function integer of_create_view ();string ls_view_field_sql

Datawindowchild dwchild


Long ll_next_field_id
Integer li_retval
Integer li_code_lookup_cnt
Integer li_address_lookup_cnt
Integer li_facility_id
Integer li_found
Integer li_append_to_screen_id
Integer li_next_screen_id  
Integer li_next_screen_order  
Integer loop_cnt
Integer li_nr
Integer li_rc
Integer li_dv_cnt
Integer d
Integer i
Integer li_table_id
integer vido
integer vidn

String ls_field_orig
String ls_drop_sql
String ls_ltr_where_sql
String ls_ltr_field_sql
String ls_ltr_from_sql
String ls_group_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_stripped_field
String ls_sql
String ls_field
String ls_ver_ltr_sql
String ls_from_sql
String ls_where_sql
String ls_ver_ltr_doc
String ls_field_sql
String ls_exp_doc_name
String  ls_coltype
String ls_table
String ls_screen_name
string ls_alpha[]
string ls_tab2	

ls_alpha[1] = 'A'
ls_alpha[2] = 'B'
ls_alpha[3] = 'C'
ls_alpha[4] = 'D'
ls_alpha[5] = 'E'
ls_alpha[6] = 'F'
ls_alpha[7] = 'G'
ls_alpha[8] = 'H'
ls_alpha[9] = 'I'
ls_alpha[10] = 'J'
ls_alpha[11] = 'K'
ls_alpha[12] = 'L'
ls_alpha[13] = 'M'
ls_alpha[14] = 'N'
ls_alpha[15] = 'O'
ls_alpha[16] = 'P'
ls_alpha[17] = 'Q'
ls_alpha[18] = 'R'
integer cnt
string ls_table_test

li_rc = tab_1.tabpage_screen.dw_sys_fields.RowCount()

ls_table = of_get_table_name()
ls_table_test = "v_"  + MidA(ls_table,5)
//messagebox("",ls_table_test)
select count(name) into :cnt from sysobjects where name = :ls_table_test; 

//CREATE SQL FOR LETTER QUERY
// mskinner 07 april 2006 -- begin
// remove dba
ls_drop_sql = "drop VIEW v_"  + MidA(ls_table,5) + ";"

ls_ltr_field_sql = "CREATE VIEW v_"  + MidA(ls_table,5) + " AS SELECT ~n~r" 
// mskinner 07 april 2006 -- begin
//ls_ltr_from_sql =  "FROM " + ls_table + ",~n~r" 
ls_ltr_from_sql =  "FROM " + ls_table + " ~n~r" 	//long.zhang 09.07.2012 BugL072501

ls_ltr_where_sql = "WHERE "
						
//						debugbreak()
FOR i = 1 TO li_rc	
	ls_field_orig = tab_1.tabpage_screen.dw_sys_fields.GetItemString( i, "field_name" )
	ls_stripped_field = ls_field_orig
	ls_field =  ls_table + "." + ls_field_orig
	
	IF tab_1.tabpage_screen.dw_sys_fields.GetItemString( i, "lookup_field" )  = "Y" THEN
		IF tab_1.tabpage_screen.dw_sys_fields.GetItemString( i,"lookup_type" ) = "C" THEN
			li_code_lookup_cnt++	
			ls_field_sql = ls_field_sql + ls_stripped_field + "_code = code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".code,~n~r"
			ls_field_sql = ls_field_sql + ls_stripped_field + "_descr = code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".description,~n~r"	
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 06.20.2012
			//$<reason>  V12.2 SQL Server 2008 Support
			/*
			ls_from_sql = ls_from_sql + "code_lookup code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ",~n~r"
			ls_where_sql = ls_where_sql + "( code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".lookup_code =* " + ls_field + ") AND~n~r "
			*/	
			//-------------------appeon begin----------------------
			//<$>Modified: long.zhang 09.07.2012
			//<$>reason:Fix  BugL072501
//			ls_tab2 = ls_table + " " + ls_table +"_"+string(i)          
//			ls_field =  ls_table +"_"+string(i) + "." + ls_field_orig   
//			ls_from_sql = ls_from_sql + "code_lookup code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + " right outer join " +ls_tab2
//			ls_from_sql = ls_from_sql + " on "+ "( code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".lookup_code = " +  ls_field  + "),~n~r"

			ls_from_sql += "left outer join code_lookup code_lookup_" + ls_alpha[ li_code_lookup_cnt ]
			ls_from_sql += " on ( code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".lookup_code = " +  ls_field  + ") ~n~r"
			
			//-------------------appeon end------------------------
			//------------------- APPEON END -------------------
		ELSEIF tab_1.tabpage_screen.dw_sys_fields.GetItemString( i, "lookup_type" ) = "A" THEN			
			li_address_lookup_cnt++	
			ls_field_sql = ls_field_sql + ls_stripped_field + "_code = address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".code,~n~r"
			ls_field_sql = ls_field_sql + ls_stripped_field + "_name = address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".entity_name,~n~r"	
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 06.20.2012
			//$<reason>  V12.2 SQL Server 2008 Support
			/*
			ls_where_sql = ls_where_sql + "( address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".lookup_code =* " + ls_field + ") AND~n~r"
			ls_from_sql = ls_from_sql + "address_lookup address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ",~n~r"		
			*/
			//-------------------appeon begin----------------------
			//<$>Modified: long.zhang 09.07.2012
			//<$>reason:Fix  BugL072501
			
//			ls_tab2 = ls_table + " " + ls_table +"_"+string(i)          
//			ls_field =  ls_table +"_"+string(i) + "." + ls_field_orig   
//			ls_from_sql = ls_from_sql + "address_lookup address_lookup_" + ls_alpha[ li_address_lookup_cnt ] +" right outer join " +ls_tab2
//			ls_from_sql = ls_from_sql + " on "+ "( address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".lookup_code = " + ls_field  +  "),~n~r"

			//Modified by (APPEON) Harry 12.20.2017 (Custom Screen Issues)
			/*
			ls_from_sql += "left outer join address_lookup address_lookup_" + ls_alpha[ li_code_lookup_cnt ]
			ls_from_sql += " on ( address_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".lookup_code = " +  ls_field  + ") ~n~r"
			*/
			ls_from_sql += "left outer join address_lookup address_lookup_" + ls_alpha[ li_address_lookup_cnt ]
			ls_from_sql += " on ( address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".lookup_code = " +  ls_field  + ") ~n~r"
			
			//-------------------appeon end------------------------
			//------------------- APPEON END -------------------
		ELSE
			ls_field_sql = ls_field_sql + ls_field + ",~n~r"
		END IF
	else
		ls_field_sql = ls_field_sql + ls_field + ",~n~r"
	END IF	
END FOR

//ls_field_sql = ls_ltr_field_sql + ls_field_sql
//ls_from_sql = ls_ltr_from_sql +  ls_from_sql
//ls_where_sql = ls_ltr_where_sql + ls_where_sql

ls_ltr_field_sql = MidA( ls_ltr_field_sql + ls_field_sql, 1, LenA( ls_ltr_field_sql + ls_field_sql )-3 )
ls_ltr_from_sql =  MidA( ls_ltr_from_sql +  ls_from_sql, 1, LenA( ls_ltr_from_sql +  ls_from_sql )-3 )
ls_ltr_where_sql = MidA( ls_ltr_where_sql + ls_where_sql, 1, LenA( ls_ltr_where_sql + ls_where_sql )-6 )


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.10.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
ls_sql =  ls_ltr_field_sql + " " + ls_ltr_from_sql + " " + ls_ltr_where_sql + ";"
*/
ls_sql =  ls_ltr_field_sql + " " + ls_ltr_from_sql + " " + ls_ltr_where_sql
//---------------------------- APPEON END ----------------------------
  
if LenA(ls_sql) < 10 then messagebox("SQL","View SQL did not generate properly")
//ClipBoard( ls_sql )  
//return 1
if cnt > 0 then
	//get id for update
	select id into :vido from sysobjects where name = :ls_table_test;
end if

EXECUTE IMMEDIATE :ls_drop_sql;

EXECUTE IMMEDIATE :ls_sql;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("View", "Failed creating View." )
	messagebox("SQL",ls_sql)
	ClipBoard( ls_sql ) 
else
	//update intellireport tables
	select id into :vidn from sysobjects where name = :ls_table_test;
	update conv_view_tables set cust_table_name = :vidn where cust_table_name = vido;
	commit using sqlca;
	MessageBox("View", "View created." )
END IF

return 1
end function

public function string of_get_table_name ();string lst

select table_name into :lst from sys_tables where table_id = :ii_table;

return lst
end function

public function integer of_verif_rules (integer ai_screen);string ls_ver_ltr_doc
string ls_exp_doc_name
string ls_screen_name
integer li_next_screen_id
integer li_facility_id


//create  facility rules
//SELECT screen_name
//INTO :ls_screen_name
//FROM dba.data_view_screen
//WHERE screen_id = :li_next_screen_id AND
//      data_view_id = 1;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox( "Sql Error", SQLCA.SQLERRTEXT )
//	Return -1
//END IF

ls_screen_name = of_get_table_name()
li_next_screen_id = ai_screen
ls_ver_ltr_doc = "ind_" + ls_screen_name + ".doc"
ls_exp_doc_name = "ind_expiring_" + ls_screen_name + ".doc"
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<modify> 05.10.2006 By: Liang QingShi
//$<reason> Performance tuning.
//$<modification> Use datastores to retrieve data from database instead of using
//$<modification> cursor.

/*
DECLARE c_facility_id CURSOR FOR  
SELECT DISTINCT facility.facility_id  
FROM facility  ;

OPEN c_facility_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Sql Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

FETCH c_facility_id INTO :li_facility_id;
//insert verif rule for screen for each facility
DO WHILE SQLCA.SQLCODE = 0
	INSERT INTO facility_ver_rules  
         ( facility_id,   
           screen_id,   
           verify_data,   
           required,   
           send_exp_reminder,   
           exp_cred_que_letters_days,   
           init_veif_letter_doc_nm,   
           exp_cred_letter_doc_nm,   
           ver_letter_resend_days,   
           ver_letter_max_sends,   
           default_verif_means,
			  exp_reminder_doc,
			  ver_ltr_doc)  
	VALUES ( :li_facility_id,   
         :li_next_screen_id,   
         'N',   
         'N',   
         'N',   
         30,   
         :ls_ver_ltr_doc,   
         :ls_exp_doc_name,   
         30,   
         3,   
         15,
			'',
			'');
	IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "Sql Error", SQLCA.SQLERRTEXT )
			Return -1
	END IF

	FETCH c_facility_id INTO :li_facility_id;
	
LOOP

CLOSE c_facility_id;
*/

datastore lds_facility,lds_facility_ver_rules
long ll_rowcount,ll_i,ll_row
lds_facility = Create datastore
lds_facility.dataobject = 'd_facility_appeon'
lds_facility_ver_rules = Create datastore
lds_facility_ver_rules.dataobject = 'd_facility_ver_rules_appeon'

lds_facility.settransobject(sqlca)
ll_rowcount = lds_facility.retrieve()
lds_facility_ver_rules.settransobject(sqlca)

For ll_i = 1 to ll_rowcount
	 li_facility_id = lds_facility.getitemnumber(ll_i,'facility_id')
	 if Not isnull(li_facility_id) and Not isnull(li_next_screen_id) then
		 ll_row = lds_facility_ver_rules.insertrow(0)
		 lds_facility_ver_rules.setitem(ll_row,'facility_id',li_facility_id)
		 lds_facility_ver_rules.setitem(ll_row,'screen_id',li_next_screen_id)
		 lds_facility_ver_rules.setitem(ll_row,'verify_data','N')
		 lds_facility_ver_rules.setitem(ll_row,'required','N')
		 lds_facility_ver_rules.setitem(ll_row,'send_exp_reminder','N')
		 lds_facility_ver_rules.setitem(ll_row,'exp_cred_que_letters_days',30)
		 lds_facility_ver_rules.setitem(ll_row,'init_veif_letter_doc_nm',ls_ver_ltr_doc)
		 lds_facility_ver_rules.setitem(ll_row,'exp_cred_letter_doc_nm',ls_exp_doc_name)
		 lds_facility_ver_rules.setitem(ll_row,'ver_letter_resend_days',30)
		 lds_facility_ver_rules.setitem(ll_row,'ver_letter_max_sends',3)
		 lds_facility_ver_rules.setitem(ll_row,'default_verif_means',15)
		 lds_facility_ver_rules.setitem(ll_row,'exp_reminder_doc','')
		 lds_facility_ver_rules.setitem(ll_row,'ver_ltr_doc','')
	end if
next
lds_facility_ver_rules.update()
commit using sqlca;
Destroy lds_facility
Destroy lds_facility_ver_rules
//---------------------------- APPEON END ----------------------------

return 1

end function

public function integer of_add_single_dv_field (integer ai_row);long ll_next_dv_id
long ll_field_x = 100
long ll_field_y
long ll_label_x= 100
long ll_label_y
integer li_nr
long ll_screenid
integer i

i = ai_row

tab_1.tabpage_screen.dw_data_view_field.settransobject(sqlca)
tab_1.tabpage_screen.dw_data_view_field.reset()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

SELECT Max( data_view_field_id )  INTO :ll_next_dv_id FROM data_view_fields;
select screen_id into :ll_screenid from data_view_screen where table_id = :ii_table;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

	li_nr = tab_1.tabpage_screen.dw_data_view_field.InsertRow( 0 )
	tab_1.tabpage_screen.dw_data_view_field.SetRow( li_nr )
	tab_1.tabpage_screen.dw_data_view_field.ScrollToRow( li_nr )
	tab_1.tabpage_screen.dw_data_view_field.SetFocus()
	ll_next_dv_id++
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "data_view_id", 1)
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "data_view_field_id", ll_next_dv_id )	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "screen_id", ll_screenid )	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_id", tab_1.tabpage_table.dw_detail.GetItemNumber( i, "field_id" ) )	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_label", tab_1.tabpage_table.dw_detail.GetItemString( i, "field_name_allias" ) )	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_order", tab_1.tabpage_table.dw_detail.GetItemNumber( i, "field_order" ) )		
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "required", "N" )		
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_width", 500 ) 
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_label_width", 500 ) 	//30 per character
	//set field positions
	
	select max(field_y) into :ll_label_y from data_view_fields where data_view_id = 1 and screen_id = :ll_screenid    ;
	ll_label_y = ll_label_y + 100
	ll_field_y = ll_label_y + 64

	
	ll_label_x = ll_field_x //label and field on the same vertical
	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_x", ll_field_x )		
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_label_x", ll_label_x )		
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_label_y", ll_label_y )					
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_y", ll_field_y )			
	
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "display_only", 'N' )				
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "field_height", 64 )				
	tab_1.tabpage_screen.dw_data_view_field.SetItem( li_nr, "edit_field_type", "E" )	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-12
	//$<add> 03.18.2006 By: Cao YongWang
	//$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_autocommit()
	//---------------------------- APPEON END ----------------------------

	tab_1.tabpage_screen.dw_data_view_field.update()
	commit using sqlca;
	
return 1
end function

on w_new_screen_painter.create
this.cb_close=create cb_close
this.tab_1=create tab_1
this.Control[]={this.cb_close,&
this.tab_1}
end on

on w_new_screen_painter.destroy
destroy(this.cb_close)
destroy(this.tab_1)
end on

event open;

tab_1.tabpage_screen.dw_table.SetTransObject( sqlca )
tab_1.tabpage_screen.dw_table.InsertRow( 0 )
tab_1.tabpage_screen.dw_sys_fields.SetTransObject( sqlca )






end event

type cb_close from commandbutton within w_new_screen_painter
integer x = 3351
integer y = 16
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type tab_1 from tab within w_new_screen_painter
event create ( )
event destroy ( )
integer x = 18
integer y = 20
integer width = 3584
integer height = 2092
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
integer selectedtab = 1
tabpage_table tabpage_table
tabpage_screen tabpage_screen
end type

on tab_1.create
this.tabpage_table=create tabpage_table
this.tabpage_screen=create tabpage_screen
this.Control[]={this.tabpage_table,&
this.tabpage_screen}
end on

on tab_1.destroy
destroy(this.tabpage_table)
destroy(this.tabpage_screen)
end on

event selectionchanged;DataWindowChild dwchild
tab_1.tabpage_screen.dw_table.SetTransObject( SQLCA )
tab_1.tabpage_screen.dw_table.Reset( )
tab_1.tabpage_screen.dw_table.InsertRow( 0 )

tab_1.tabpage_screen.dw_table.GetChild( "table_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( )

tab_1.tabpage_screen.dw_sys_fields.SetTransObject( SQLCA )
tab_1.tabpage_screen.dw_sys_fields.retrieve(ii_table)


end event

type tabpage_table from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3547
integer height = 1976
long backcolor = 33551856
string text = "Create Table"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_10 st_10
st_9 st_9
st_6 st_6
st_5 st_5
rb_mod rb_mod
rb_new_table rb_new_table
cb_4 cb_4
cb_sys_save cb_sys_save
st_4 st_4
dw_detail dw_detail
dw_browse dw_browse
dw_table_exists dw_table_exists
cb_sys_add cb_sys_add
cb_view cb_view
cbx_facility cbx_facility
st_3 st_3
sle_table_name sle_table_name
cb_create cb_create
cb_delete cb_delete
cb_add cb_add
dw_table_struct dw_table_struct
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
cb_sys_del cb_sys_del
end type

on tabpage_table.create
this.st_10=create st_10
this.st_9=create st_9
this.st_6=create st_6
this.st_5=create st_5
this.rb_mod=create rb_mod
this.rb_new_table=create rb_new_table
this.cb_4=create cb_4
this.cb_sys_save=create cb_sys_save
this.st_4=create st_4
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.dw_table_exists=create dw_table_exists
this.cb_sys_add=create cb_sys_add
this.cb_view=create cb_view
this.cbx_facility=create cbx_facility
this.st_3=create st_3
this.sle_table_name=create sle_table_name
this.cb_create=create cb_create
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_table_struct=create dw_table_struct
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.cb_sys_del=create cb_sys_del
this.Control[]={this.st_10,&
this.st_9,&
this.st_6,&
this.st_5,&
this.rb_mod,&
this.rb_new_table,&
this.cb_4,&
this.cb_sys_save,&
this.st_4,&
this.dw_detail,&
this.dw_browse,&
this.dw_table_exists,&
this.cb_sys_add,&
this.cb_view,&
this.cbx_facility,&
this.st_3,&
this.sle_table_name,&
this.cb_create,&
this.cb_delete,&
this.cb_add,&
this.dw_table_struct,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.cb_sys_del}
end on

on tabpage_table.destroy
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.rb_mod)
destroy(this.rb_new_table)
destroy(this.cb_4)
destroy(this.cb_sys_save)
destroy(this.st_4)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.dw_table_exists)
destroy(this.cb_sys_add)
destroy(this.cb_view)
destroy(this.cbx_facility)
destroy(this.st_3)
destroy(this.sle_table_name)
destroy(this.cb_create)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_table_struct)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.cb_sys_del)
end on

type st_10 from statictext within tabpage_table
integer x = 1595
integer y = 992
integer width = 197
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Step 2"
boolean focusrectangle = false
end type

type st_9 from statictext within tabpage_table
integer x = 2610
integer y = 48
integer width = 247
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Step 1"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_table
integer x = 1591
integer y = 580
integer width = 233
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Step 2"
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_table
integer x = 384
integer y = 48
integer width = 219
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Step 1"
boolean focusrectangle = false
end type

type rb_mod from radiobutton within tabpage_table
integer x = 1477
integer y = 120
integer width = 617
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Modify existing screen"
end type

event clicked;tab_1.tabpage_table.dw_table_exists.settransobject(sqlca)
tab_1.tabpage_table.dw_table_exists.retrieve()

tab_1.tabpage_table.cb_sys_add.enabled = true
tab_1.tabpage_table.cb_sys_save.enabled = true
tab_1.tabpage_table.cb_sys_del.enabled = true
tab_1.tabpage_table.dw_table_exists.enabled = true

tab_1.tabpage_table.cb_add.enabled = false
tab_1.tabpage_table.cb_delete.enabled = false
tab_1.tabpage_table.cb_view.enabled = false
tab_1.tabpage_table.cb_create.enabled = false
tab_1.tabpage_table.sle_table_name.enabled = false
//tab_1.tabpage_screen.visible = false
end event

type rb_new_table from radiobutton within tabpage_table
integer x = 1477
integer y = 56
integer width = 439
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add new table"
boolean checked = true
end type

event clicked;tab_1.tabpage_table.cb_sys_add.enabled = false
tab_1.tabpage_table.cb_sys_save.enabled = false
tab_1.tabpage_table.cb_sys_del.enabled = false
tab_1.tabpage_table.dw_table_exists.enabled = false

tab_1.tabpage_table.cb_add.enabled = true
tab_1.tabpage_table.cb_delete.enabled = true
tab_1.tabpage_table.cb_view.enabled = true
tab_1.tabpage_table.cb_create.enabled = true
tab_1.tabpage_table.sle_table_name.enabled = true

tab_1.tabpage_screen.visible = true
end event

type cb_4 from commandbutton within tabpage_table
integer x = 3250
integer y = 108
integer width = 219
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;string ls_table
integer res
string ls_sql

res = messagebox("Delete","Delete all setup and practitioner data from the database and delete the table?",question!,yesno!,2)
if res = 2 then return

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<modify> 05.10.2006 By: Rodger Wu
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/* select table_name into :ls_table from sys_tables where table_id = :ii_table; */
Long ll_screen_id
gnv_appeondb.of_startQueue()
SELECT table_name INTO :ls_table FROM sys_tables WHERE table_id = :ii_table;
SELECT TOP 1 screen_id INTO :ll_screen_id FROM data_view_screen WHERE table_id = :ii_table;
gnv_appeondb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

delete from data_view_screen where table_id = :ii_table;

Delete from sys_tables where table_id = :ii_table;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.10.2006 By: Rodger Wu
//$<reason> Fix a defect.

datawindowchild ldwc_tableid
string ls_dropview

DELETE FROM sys_fields WHERE table_id = :ii_table;
DELETE FROM data_view_fields WHERE screen_id = :ll_screen_id;
DELETE FROM facility_ver_rules WHERE screen_id = :ll_screen_id;

ls_dropview = "DROP VIEW v_"  + MidA(ls_table,5) + ";"
EXECUTE IMMEDIATE :ls_dropview; 
//---------------------------- APPEON END ----------------------------

ls_sql = "drop table " + ls_table + ";"
execute immediate :ls_sql;


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-15
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()

tab_1.tabpage_table.dw_table_exists.GetChild( "table_id", ldwc_tableid )
ldwc_tableid.SetTransObject( SQLCA )
ldwc_tableid.Retrieve()

tab_1.tabpage_table.dw_table_exists.Reset()
tab_1.tabpage_table.dw_table_exists.InsertRow( 0 )
tab_1.tabpage_table.dw_browse.Reset()
//---------------------------- APPEON END ----------------------------

end event

type cb_sys_save from commandbutton within tabpage_table
integer x = 1513
integer y = 1060
integer width = 357
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Save ->"
end type

event clicked;string ls_field
string res
string ls_field_type
long ll_tid
long ll_fid
integer u


debugbreak()
if dw_detail.rowcount() < 1 then return
dw_detail.accepttext()

if ib_new = true then
		//validate data
	ls_field = dw_detail.getitemstring(1,"field_name") 
	if isnull(ls_field) or ls_field  = "" then
		messagebox("Required Data","The database table name field is required.  Please enter")
		return
	end if
	ls_field_type = dw_detail.getitemstring(1,"field_type")
	if isnull(ls_field_type) or ls_field_type = "" then
		messagebox("Required Data","The field type is required.  Please enter")
		return
	end if
	if isnull(dw_detail.getitemnumber(1,"field_len")) or dw_detail.getitemnumber(1,"field_len") < 1 then
		if ls_field_type = "C" or ls_field_type = "N" then 
			messagebox("Required Data","The field kength is required.  Please enter")
			return
		end if
	end if
	if isnull(dw_detail.getitemstring(1,"field_name_allias")) or dw_detail.getitemstring(1,"field_name_allias") = "" then
		messagebox("Required Data","The Field Alias is required.  Please enter")
		return
	end if
	
	res = of_test_column(ls_field,"C")
	if res <> "OK" then
//		choose case res
//			case "1","2","3","4","5","6","7","8","9"
//				messagebox("Column naming error","The first character of the column cannot be a number.  Correct And try again")
//			case " " 
//				messagebox("Column naming error","The column name cannot contain a space.  Correct And try again")
//			case else
//				messagebox("Column naming error","The column name cannot contain the character " + res + ".  Correct And try again")
//		end choose
				
		return
	end if	
	u = dw_detail.update()
	if u <> 1 then
		return
	else
		of_table_alter(dw_detail.getrow())
		of_add_single_dv_field(dw_detail.getrow())
	end if	
else
	dw_detail.update()
	commit using sqlca;
end if
end event

type st_4 from statictext within tabpage_table
integer x = 2158
integer y = 44
integer width = 315
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Table"
boolean focusrectangle = false
end type

type dw_detail from datawindow within tabpage_table
integer x = 1915
integer y = 840
integer width = 1563
integer height = 1136
integer taborder = 130
string dataobject = "d_sys_fields_list_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;IF This.GetColumnName() = "field_type" then
	if data = "N" THEN
		this.setitem(this.getrow(),"field_len",12)
	elseif data = "C" THEN
		this.setitem(this.getrow(),"field_len",25)
	else
		this.setitem(this.getrow(),"field_len",0)
	end if
end if
end event

type dw_browse from datawindow within tabpage_table
integer x = 1915
integer y = 228
integer width = 1559
integer height = 528
integer taborder = 110
string dataobject = "d_sys_fields_by_table_id"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer i
long ll_field_id



i = this.getclickedrow()
if i < 1 then return
ll_field_id = this.getitemnumber(i,"field_id")
this.selectrow(0,false)
this.selectrow(i,true)

dw_detail.settransobject(sqlca)
dw_detail.retrieve(ll_field_id)
end event

type dw_table_exists from datawindow within tabpage_table
integer x = 2144
integer y = 112
integer width = 1070
integer height = 88
integer taborder = 60
boolean enabled = false
string dataobject = "d_sys_table_select_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_table = integer(data)

dw_browse.settransobject(sqlca)
dw_browse.retrieve(ii_table)
end event

type cb_sys_add from commandbutton within tabpage_table
integer x = 1513
integer y = 892
integer width = 357
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "A&dd ->"
end type

event clicked;long ll_fid
long ll_ord
datawindowchild dwchild

dw_detail.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-16
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//--------------------------- APPEON END ---------------------------
select max(field_id) into :ll_fid from sys_fields;
select max(field_order) into:ll_ord from sys_fields where table_id = :ii_table;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-17
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()
//--------------------------- APPEON END ---------------------------
ll_fid++
ll_ord = ll_ord + 10
dw_detail.insertrow(1)


dw_detail.GetChild( "lookup_field_name", dwchild )
dwchild.InsertRow( 0 )
dwchild.SetItem( 1, "field_name", "Description" )
dw_detail.GetChild( "lookup_code", dwchild )
dwchild.SetTransObject( sqlca )
dwchild.Retrieve()

dw_detail.setitem(1,"table_id",ii_table)
dw_detail.setitem(1,"field_id",ll_fid)
dw_detail.setitem(1,"field_order",ll_ord)
dw_detail.SetItem( 1, "app_fill_field_len" ,20)
dw_detail.Setfocus()

ib_new = true
end event

type cb_view from commandbutton within tabpage_table
integer x = 1486
integer y = 460
integer width = 393
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<- &View SQL"
end type

event clicked;String ls_sql
debugbreak()
ls_sql = of_table_syntax()
if isnull(ls_sql) then
	MessageBox( "Table Syntax", "Failed - Null")
elseif ls_sql = "Failed" then
	//MessageBox( "Table Syntax", "Failed")
else
	MessageBox( "Table Syntax", ls_sql)
end if
//String ls_col_name
//Integer i
//Integer li_rc
//Integer li_table_id
//Integer li_col_size
//Integer li_facility_specific
//String ls_table_name
//String ls_col_type
//String ls_index_sql
//
//IF Left( sle_table_name.Text, 4 ) <> "pdc_" THEN
//	MessageBox( "Table Name", "The table name must start with the prefix pdc_" )
//	Return -1
//END IF
//
//dw_table_struct.AcceptText( )
//
//IF cbx_facility.Checked THEN
//	li_facility_specific = 1 
//ELSE
//	li_facility_specific = 0 
//END IF
//
//ls_table_name = "dba." + sle_table_name.Text
//
//ls_sql = "CREATE TABLE dba." + sle_table_name.Text + " ( "
//
//li_rc = dw_table_struct.RowCount( )
//
//IF li_rc = 0 THEN
//	MessageBox("No Fields", "You must create at least one field before creating a table." )
//	Return
//END IF
//
//FOR i = 1 TO li_rc
//	
//	ls_col_name = dw_table_struct.GetItemString( i, "col_name" )
//	
//	IF IsNull( ls_col_name ) OR ls_col_name = "" THEN
//		MessageBox( "Column Name", "Invalid Column Name" )
//		dw_table_struct.SetColumn( "col_name" )		
//		dw_table_struct.SetFocus( )
//		dw_table_struct.SetRow( i )
//		dw_table_struct.ScrollToRow( i )
//		Return
//	END IF
//	
//	ls_sql = ls_sql + " " + ls_col_name
//	ls_sql = ls_sql + " " + dw_table_struct.GetItemString( i, "col_type" ) 
//	li_col_size = dw_table_struct.GetItemNumber( i, "col_size" )
//	ls_col_type = dw_table_struct.GetItemString( i, "col_type" )
//	
//	IF IsNull( ls_col_type ) OR ls_col_type = "" THEN
//		MessageBox( "Column Type", "You need to select a Column Type." )
//		dw_table_struct.SetColumn( "col_type" )
//		dw_table_struct.SetFocus( )
//		dw_table_struct.SetRow( i )
//		dw_table_struct.ScrollToRow( i )
//		Return
//	END IF
//	
//	IF Upper( dw_table_struct.GetItemString( i, "col_type" )) <> "I" AND Upper( dw_table_struct.GetItemString( i, "col_type" )) <> "D" THEN
//		IF IsNull( li_col_size ) OR li_col_size = 0 THEN
//			MessageBox("Column Size", "The column size for " + ls_col_name + " must be greater than 0." )
//			dw_table_struct.SetColumn( i )
//			dw_table_struct.SetFocus( )
//			Return
//		END IF
//		ls_sql = ls_sql + " (" + String( dw_table_struct.GetItemNumber( i, "col_size" ) ) 
//	END IF
//	
//	IF Upper( dw_table_struct.GetItemString( i, "col_type" ) ) = "D" THEN
//		ls_sql = ls_sql + ",0"
//	END IF
//	
//	IF Upper( dw_table_struct.GetItemString( i, "col_type" ) ) <> "I" AND Upper( dw_table_struct.GetItemString( i, "col_type" )) <> "D"  THEN
//		ls_sql = ls_sql + ") "	
//	END IF
//	
//	IF  ls_col_name <> "rec_id" AND ls_col_name <> "prac_id" THEN
//		ls_sql = ls_sql + " NULL ," + "~n~r"	
//	ELSE
//		ls_sql = ls_sql + ",~n~r"		
//	END IF
//	
//END FOR
//
//ls_sql = Mid( ls_sql, 1, Len( ls_sql )-3 )
//
//ls_sql = ls_sql + " )"
//
////Execute Immediate: ls_sql;
//
//MessageBox("SQL", ls_Sql )
//
////SELECT Max( table_id ) 
////INTO :li_table_id
////FROM dba.sys_tables ;
////
////if li_table_id < 100 then li_table_id = 100 //maha 081202 to leave room for standard system tables.
////
////IF SQLCA.SQLCODE = -1 THEN
////	MessageBox( "DB Error", SQLCA.SQLERRTEXT )
////	Return -1
////END IF
////li_table_id ++
////
////IF SQLCA.SQLCODE = -1 THEN
////	MessageBox( "DB Error", SQLCA.SQLERRTEXT )
////	Return -1
////END IF
////
////ls_index_sql = "CREATE UNIQUE INDEX " + "idx_" + Mid( ls_table_name,5,100 ) + "_rec_id ON dba." + ls_table_name + "( rec_id ASC )"
////clipboard( ls_index_sql )
////Execute Immediate: ls_index_sql;
//
////ls_index_sql = "CREATE INDEX " + "idx_" + Mid( ls_table_name,5,100 ) + "_prac_id ON dba." + ls_table_name + "( prac_id ASC )"
//
////Execute Immediate: ls_index_sql;
//
////MessageBox("Complete", "Finished creating table." )
//
//
////CREATE UNIQUE INDEX "idx_pd_address_2" ON "DBA"."pd_address_2"( "rec_id" ASC ) 
end event

type cbx_facility from checkbox within tabpage_table
integer x = 699
integer y = 40
integer width = 626
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Facility Specific Data"
end type

type st_3 from statictext within tabpage_table
integer x = 41
integer y = 44
integer width = 274
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "New Name"
boolean focusrectangle = false
end type

type sle_table_name from singlelineedit within tabpage_table
integer x = 41
integer y = 120
integer width = 1298
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "pdc_"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_create from commandbutton within tabpage_table
integer x = 1486
integer y = 640
integer width = 393
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<- &Create Table"
end type

event clicked;String ls_sql
String ls_col_name
string s
Integer li_found
Integer i
integer d
Integer li_rc
Integer li_table_id
Integer li_col_size
Integer li_facility_specific
integer tid
long ll_field_id
string ck
String ls_table_name
String ls_col_type
String ls_index_sql
string ls_type
string ls_field

ls_sql = of_table_syntax()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.10.2006 By: Rodger Wu
//$<reason> Fix a defect.
/*
if ls_sql = "FAILS" then
	return -1
end if
*/
if Upper( ls_sql ) = "FAIL" then	return -1;
//---------------------------- APPEON END ----------------------------

if ls_sql = "EXISTS" then
	i = messagebox("Table exists","Delete existing?",question!,yesno!,1)
	if i = 1 then
		ls_table_name = "" + sle_table_name.text
		s = "drop table " + ls_table_name + ";"
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-18
		//$<add> 03.18.2006 By: Cao YongWang
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_startqueue()
		//---------------------------- APPEON END ----------------------------

		Execute Immediate :s;
		select table_id into :tid from sys_tables where table_name = :ls_table_name;
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-19
		//$<add> 03.18.2006 By: Cao YongWang
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
		gnv_appeondb.of_commitqueue()
		//---------------------------- APPEON END ----------------------------
		if tid > 0 then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-20
			//$<add> 03.18.2006 By: Cao YongWang
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
			gnv_appeondb.of_startqueue()
			//---------------------------- APPEON END ----------------------------
			select screen_id into :d from data_view_screen where table_id = :tid;
			delete from sys_fields where table_id = :tid;
			delete from sys_fields where table_id = :tid;
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-21
			//$<add> 03.18.2006 By: Cao YongWang
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
			gnv_appeondb.of_commitqueue()
			//---------------------------- APPEON END ----------------------------
			if d > 1 then
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-22
				//$<add> 03.18.2006 By: Cao YongWang
				//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
				gnv_appeondb.of_startqueue()
				//---------------------------- APPEON END ----------------------------
				delete from data_view_fields where screen_id = :d;
				delete from data_view_screen where screen_id = :d;
				delete from facility_ver_rules where screen_id = :d;
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-23
				//$<add> 03.18.2006 By: Cao YongWang
				//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
				gnv_appeondb.of_commitqueue()
				//---------------------------- APPEON END ----------------------------
			end if
		end if
		commit using sqlca;	
	
		
		messagebox("Table","Click Create Table again.")
	end if
	return -1
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-24
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------
Execute Immediate:ls_sql;

//ClipBoard( ls_Sql )

//Start Code Change ---- 06.16.2006 #549 maha contract tables are 1000 +
SELECT Max( table_id ) INTO :li_table_id FROM sys_tables where table_id < 1000;  
//End Code Change---06.16.2006

SELECT Max( field_id ) INTO :ll_field_id FROM sys_fields ;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-25
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------
if li_table_id < 100 then li_table_id = 100 //maha 081202 to leave room for standard system tables.

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "DB Error", SQLCA.SQLERRTEXT )
	Return -1
END IF
li_table_id ++
ll_field_id++

ls_table_name = "" + tab_1.tabpage_table.sle_table_name.Text
IF tab_1.tabpage_table.cbx_facility.Checked THEN
	li_facility_specific = 1 
ELSE
	li_facility_specific = 0 
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-26
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------
INSERT INTO sys_tables  
       ( table_id,   
	      table_name,   
         table_name_allias,   
         facility_specific )  
VALUES ( :li_table_id,   
         :ls_table_name,   
         :ls_table_name,   
         :li_facility_specific );
			
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "DB Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

ii_table = li_table_id
ls_index_sql = "CREATE UNIQUE INDEX " + "idx_" + MidA( ls_table_name,5,100 ) + "_rec_id ON " + ls_table_name + "( rec_id ASC )"

i = messagebox("SQL","Save create sql?",question!,yesno!,1)
if i = 1 then
	clipboard( ls_index_sql )
	messagebox("SQL","On Clipboard")
end if
Execute Immediate :ls_index_sql;

ls_index_sql = "CREATE INDEX " + "idx_" + MidA( ls_table_name,5,100 ) + "_prac_id ON " + ls_table_name + "( prac_id ASC )"

Execute Immediate:ls_index_sql;

li_rc = tab_1.tabpage_table.dw_table_struct.RowCount( )
for i = 1 to li_rc
	ll_field_id++
	dw_table_struct.setitem(i,"table_id",li_table_id)
	dw_table_struct.setitem(i,"field_id",ll_field_id)
	ls_field = dw_table_struct.getitemstring(i,"field_name")
	choose case ls_field
		case "prac_id","facility_id","rec_id"
			dw_table_struct.setitem(i,"field_order",0)
		case else
			dw_table_struct.setitem(i,"field_order",i * 10)
	end choose
	dw_table_struct.setitem(i,"field_name_allias",ls_field)
	dw_table_struct.setitem(i,"app_fill_field_len",dw_table_struct.getitemnumber(i,"field_len"))
	dw_table_struct.setitem(i,"audit_fld","Y")
	
next

dw_table_struct.settransobject(sqlca)	
dw_table_struct.update()
commit using sqlca;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-27
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------
MessageBox("Complete", "Finished creating table." )

tab_1.selecttab(2)

tab_1.tabpage_table.cb_add.enabled = false
tab_1.tabpage_table.cb_delete.enabled = false
tab_1.tabpage_table.cb_view.enabled = false


end event

type cb_delete from commandbutton within tabpage_table
integer x = 1486
integer y = 364
integer width = 393
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<- De&lete"
end type

event clicked;dw_table_struct.DeleteRow( 0 )
dw_table_struct.SetFocus( )

IF dw_table_struct.RowCount() > 0 THEN
	dw_table_struct.SetRow( 1 )
END IF


end event

type cb_add from commandbutton within tabpage_table
integer x = 1486
integer y = 272
integer width = 393
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<- &Add "
end type

event clicked;Integer li_nr


IF dw_table_struct.RowCount( ) = 0 THEN
	li_nr = dw_table_struct.InsertRow( 1 )
	dw_table_struct.SetItem( li_nr, "field_name", "prac_id" )
	dw_table_struct.SetItem( li_nr, "field_type", "N" )
	dw_table_struct.SetItem( li_nr, "field_len", 8 )	
	
	li_nr = dw_table_struct.InsertRow( 1 )
	dw_table_struct.SetItem( li_nr, "field_name", "rec_id" )
	dw_table_struct.SetItem( li_nr, "field_type", "N" )
	dw_table_struct.SetItem( li_nr, "field_len", 12 )

	IF cbx_facility.Checked THEN
		li_nr = dw_table_struct.InsertRow( 0 )
		dw_table_struct.SetItem( li_nr, "field_name", "facility_id" )
		dw_table_struct.SetItem( li_nr, "field_type", "I" )
	END IF
END IF

li_nr = dw_table_struct.InsertRow( 0 )
dw_table_struct.SetFocus()
dw_table_struct.SetColumn( 1 )
dw_table_struct.SetRow( li_nr )

cbx_facility.Enabled = False
end event

type dw_table_struct from datawindow within tabpage_table
integer y = 232
integer width = 1440
integer height = 1740
integer taborder = 90
string dataobject = "d_new_screen_columns_sys"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;Integer li_found = 0


IF This.GetColumnName() = "field_type" then
	if data = "N" THEN
		this.setitem(this.getrow(),"field_len",12)
	elseif data = "C" THEN
		this.setitem(this.getrow(),"field_len",25)
	else
		this.setitem(this.getrow(),"field_len",0)
	end if
end if
//IF This.GetColumnName() = "col_name" AND IsNumber(Left(data, 1 )) THEN
//	MessageBox("Invalid Column Name", "Column names can't begin with numbers." )
//	Return 1
//END IF



end event

type gb_2 from groupbox within tabpage_table
integer x = 1408
integer y = 8
integer width = 695
integer height = 192
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Function"
end type

type gb_3 from groupbox within tabpage_table
integer x = 1481
integer y = 820
integer width = 421
integer height = 352
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Existing"
end type

type gb_4 from groupbox within tabpage_table
integer x = 1472
integer y = 208
integer width = 430
integer height = 548
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "New"
end type

type cb_sys_del from commandbutton within tabpage_table
integer x = 3154
integer y = 936
integer width = 357
integer height = 84
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Dele&te->"
end type

type tabpage_screen from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3547
integer height = 1976
long backcolor = 33551856
string text = "Create Screen"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_11 st_11
st_8 st_8
st_7 st_7
cb_save_dv cb_save_dv
cb_7 cb_7
cb_6 cb_6
cb_1 cb_1
cb_2 cb_2
dw_data_view_screen dw_data_view_screen
dw_data_views dw_data_views
cb_3 cb_3
st_1 st_1
dw_screen dw_screen
rb_append rb_append
rb_new rb_new
st_2 st_2
dw_table dw_table
dw_sys_fields dw_sys_fields
gb_1 gb_1
dw_sys_fields_add dw_sys_fields_add
dw_data_view_field dw_data_view_field
dw_ver_ltr dw_ver_ltr
end type

on tabpage_screen.create
this.st_11=create st_11
this.st_8=create st_8
this.st_7=create st_7
this.cb_save_dv=create cb_save_dv
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_data_view_screen=create dw_data_view_screen
this.dw_data_views=create dw_data_views
this.cb_3=create cb_3
this.st_1=create st_1
this.dw_screen=create dw_screen
this.rb_append=create rb_append
this.rb_new=create rb_new
this.st_2=create st_2
this.dw_table=create dw_table
this.dw_sys_fields=create dw_sys_fields
this.gb_1=create gb_1
this.dw_sys_fields_add=create dw_sys_fields_add
this.dw_data_view_field=create dw_data_view_field
this.dw_ver_ltr=create dw_ver_ltr
this.Control[]={this.st_11,&
this.st_8,&
this.st_7,&
this.cb_save_dv,&
this.cb_7,&
this.cb_6,&
this.cb_1,&
this.cb_2,&
this.dw_data_view_screen,&
this.dw_data_views,&
this.cb_3,&
this.st_1,&
this.dw_screen,&
this.rb_append,&
this.rb_new,&
this.st_2,&
this.dw_table,&
this.dw_sys_fields,&
this.gb_1,&
this.dw_sys_fields_add,&
this.dw_data_view_field,&
this.dw_ver_ltr}
end on

on tabpage_screen.destroy
destroy(this.st_11)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.cb_save_dv)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_data_view_screen)
destroy(this.dw_data_views)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.dw_screen)
destroy(this.rb_append)
destroy(this.rb_new)
destroy(this.st_2)
destroy(this.dw_table)
destroy(this.dw_sys_fields)
destroy(this.gb_1)
destroy(this.dw_sys_fields_add)
destroy(this.dw_data_view_field)
destroy(this.dw_ver_ltr)
end on

type st_11 from statictext within tabpage_screen
integer x = 1605
integer y = 72
integer width = 201
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean enabled = false
string text = "Step 3"
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_screen
integer x = 1842
integer y = 72
integer width = 251
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Step 4"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_screen
integer x = 1189
integer y = 72
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Step 3"
boolean focusrectangle = false
end type

type cb_save_dv from commandbutton within tabpage_screen
integer x = 2126
integer y = 136
integer width = 558
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_sys_fields.update()
end event

type cb_7 from commandbutton within tabpage_screen
integer x = 2702
integer y = 136
integer width = 558
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Delete table"
end type

type cb_6 from commandbutton within tabpage_screen
integer x = 1550
integer y = 136
integer width = 558
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create iReport View"
end type

event clicked;of_create_view()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-28
//$<add> 03.18.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_StartQueue()

gnv_data.of_retrieve( "sys_tables" )
gnv_data.of_retrieve( "sys_fields" )
app_filler.ids_screen_fields_cache.retrieve()
UPDATE ids SET screen_obj_cache = getdate();

gnv_appeondb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------
end event

type cb_1 from commandbutton within tabpage_screen
boolean visible = false
integer x = 1554
integer y = 1428
integer width = 654
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Sys_Fields Records"
end type

event clicked;Long ll_next_field_id
Integer li_nr
Integer li_rc
Integer i
Integer li_table_id
String  ls_coltype
String ls_table

dw_sys_fields_add.SetTransObject( sqlca )

li_rc = dw_sys_fields.RowCount()

ls_table = dw_table.GetItemString( 1, "table_id" )

// mskinner 07 april 2006 -- begin
// remove dba.
SELECT sys_tables.table_id  
INTO :li_table_id  
FROM sys_tables  
WHERE sys_tables.table_name = :ls_table;
// mskinner 07 april 2006 -- end

SELECT max(field_id)  
INTO :ll_next_field_id  
FROM sys_fields  ;


FOR i = 1 TO li_rc

	li_nr = dw_sys_fields_add.InsertRow( 0 )
	dw_sys_fields_add.SetRow( li_nr )
	dw_sys_fields_add.ScrollToRow( li_nr )
	dw_sys_fields_add.SetFocus()


	datawindowchild dwchild

//	dw_sys_fields_add.GetChild( "lookup_field_name", dwchild )
//	dwchild.InsertRow( 0 )
//	dwchild.SetItem( 1, "field_name", "Description" )
//
//	dw_sys_fields_add.GetChild( "lookup_code", dwchild )
//	dwchild.SetTransObject( sqlca )
//	dwchild.Retrieve()

	ll_next_field_id++
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "field_id", ll_next_field_id )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "table_id", li_table_id )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "field_order", i * 10 )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "field_name", dw_sys_fields.GetItemString( i, "field_name" ) )	
	ls_coltype =  dw_sys_fields.GetItemString( i, "coltype" )

	CHOOSE CASE ls_coltype
		CASE 'numeric', 'integer'
			ls_coltype = 'N'
		CASE 'char', 'varchar'
			ls_coltype = 'C'
		CASE ELSE
			ls_coltype = 'D'	
	END CHOOSE

	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "field_type", ls_coltype )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "field_len", dw_sys_fields.GetItemNumber( i, "field_len" ) )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "field_name_allias", dw_sys_fields.GetItemString( i, "field_name_allias" ) )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "lookup_field", dw_sys_fields.GetItemString( i, "lookup_field" ) )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "lookup_type", dw_sys_fields.GetItemString( i, "lookup_type" ) )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "lookup_code", dw_sys_fields.GetItemString( i, "lookup_code" ) )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "lookup_field_name", dw_sys_fields.GetItemString( i, "lookup_field_name" ) )
	dw_sys_fields_add.SetItem( dw_sys_fields_add.GetRow(), "audit_fld", "Y" )			

END FOR


end event

type cb_2 from commandbutton within tabpage_screen
boolean visible = false
integer x = 864
integer y = 1424
integer width = 654
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add To Default Data View"
end type

event clicked;Long ll_next_dv_id
Integer li_nr
Integer li_next_screen_id  
Integer li_next_screen_order  
Integer li_table_id
Integer li_rc
Integer i
Integer loop_cnt
Long ll_label_y = 50
Long ll_field_y = 114
String ls_table

dw_data_view_screen.SetTransObject( sqlca )
dw_data_view_field.SetTransObject( sqlca )

ls_table = MidA( dw_table.GetText(), 5, 100 ) 

SELECT sys_tables.table_id  
INTO :li_table_id  
FROM sys_tables  
WHERE sys_tables.table_name = :ls_table;

//add to data view screen field.   (default data view)
dw_data_view_screen.Reset()
dw_data_view_screen.SetTransObject( SQLCA )
dw_data_view_screen.InsertRow( 0 )

dw_data_view_screen.SetItem( 1, "data_view_id", 1 )

SELECT Max( screen_id )  
INTO :li_next_screen_id  
FROM data_view_screen  
WHERE data_view_screen.data_view_id = 1;

li_next_screen_id  ++

dw_data_view_screen.SetItem( 1, "screen_id", li_next_screen_id )

SELECT Max( screen_order )  
INTO :li_next_screen_order  
FROM data_view_screen  
WHERE data_view_screen.data_view_id = 1;

li_next_screen_order  ++

dw_data_view_screen.SetItem( 1, "screen_order", li_next_screen_order )

dw_data_view_screen.SetItem( 1, "screen_name", ls_table )

dw_data_view_screen.SetItem( 1, "multi_record", 'Y'  )

dw_data_view_screen.SetItem( 1, "table_id", li_table_id  )



//loop through and add sys_field info into data_view_vield

SELECT Max( data_view_field_id )  
INTO :ll_next_dv_id
FROM data_view_fields  ;


li_rc = dw_sys_fields_add.RowCount()

loop_cnt  = 0

FOR i = 1 TO li_rc
	
	IF dw_sys_fields_add.GetItemString( i, "field_name_allias" ) = "rec_id" OR +&
	   dw_sys_fields_add.GetItemString( i, "field_name_allias" ) = "prac_id" THEN
	   CONTINUE
	END IF
	
	loop_cnt ++
	
	li_nr = dw_data_view_field.InsertRow( 0 )
	dw_data_view_field.SetRow( li_nr )
	dw_data_view_field.ScrollToRow( li_nr )
	dw_data_view_field.SetFocus()

	ll_next_dv_id++
	
	dw_data_view_field.SetItem( li_nr, "data_view_id", 1 )
	dw_data_view_field.SetItem( li_nr, "data_view_field_id", ll_next_dv_id )	
	dw_data_view_field.SetItem( li_nr, "screen_id", li_next_screen_id )	
	dw_data_view_field.SetItem( li_nr, "field_id", dw_sys_fields_add.GetItemNumber( i, "field_id" ) )	
	dw_data_view_field.SetItem( li_nr, "field_label", dw_sys_fields_add.GetItemString( i, "field_name_allias" ) )	
	dw_data_view_field.SetItem( li_nr, "field_order", dw_sys_fields_add.GetItemNumber( i, "field_order" ) )		
	dw_data_view_field.SetItem( li_nr, "required", "Y" )		
	dw_data_view_field.SetItem( li_nr, "field_width", 500 ) 
	dw_data_view_field.SetItem( li_nr, "field_label_width", 500 ) 	

	dw_data_view_field.SetItem( li_nr, "field_x", 50 )		
	dw_data_view_field.SetItem( li_nr, "field_label_x", 50 )		
	dw_data_view_field.SetItem( li_nr, "field_label_y", ll_label_y )					
	dw_data_view_field.SetItem( li_nr, "field_y", ll_field_y )			
	
	dw_data_view_field.SetItem( li_nr, "display_only", 'N' )				
	dw_data_view_field.SetItem( li_nr, "field_height", 64 )				
	dw_data_view_field.SetItem( li_nr, "edit_field_type", "E" )					
	ll_label_y = ll_label_y + 150
	ll_field_y = ll_field_y + 150
END FOR

dw_data_view_screen.Update( )
dw_data_view_field.Update( )
dw_sys_fields_add.Update()

end event

type dw_data_view_screen from datawindow within tabpage_screen
boolean visible = false
integer x = 87
integer y = 744
integer width = 3319
integer height = 496
integer taborder = 20
string dataobject = "d_create_cust_screen_data_view_screen"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_data_views from datawindow within tabpage_screen
boolean visible = false
integer x = 389
integer y = 1392
integer width = 2784
integer height = 256
integer taborder = 70
string dataobject = "d_data_view_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within tabpage_screen
integer x = 983
integer y = 136
integer width = 558
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Screen"
end type

event clicked;of_create_screen()
end event

type st_1 from statictext within tabpage_screen
boolean visible = false
integer x = 2446
integer y = 172
integer width = 192
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Screen."
boolean focusrectangle = false
end type

type dw_screen from u_dw within tabpage_screen
boolean visible = false
integer x = 1646
integer y = 144
integer width = 777
integer height = 100
integer taborder = 60
string dataobject = "d_select_screen_to_append_to"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
This.InsertRow( 0 )
end event

event itemchanged;call super::itemchanged;rb_append.Checked = True
rb_new.Checked = False
end event

type rb_append from radiobutton within tabpage_screen
boolean visible = false
integer x = 1038
integer y = 172
integer width = 759
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add to Detail 2 page of"
end type

type rb_new from radiobutton within tabpage_screen
boolean visible = false
integer x = 1038
integer y = 88
integer width = 750
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Create As Separate Screen"
boolean checked = true
end type

type st_2 from statictext within tabpage_screen
integer x = 64
integer y = 72
integer width = 494
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Custom Table"
boolean focusrectangle = false
end type

type dw_table from datawindow within tabpage_screen
integer x = 69
integer y = 136
integer width = 882
integer height = 80
integer taborder = 50
string dataobject = "d_sys_table_select_list_cust"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_table = integer(data)


tab_1.tabpage_screen.dw_sys_fields.SetTransObject( SQLCA )
tab_1.tabpage_screen.dw_sys_fields.retrieve(ii_table)
end event

type dw_sys_fields from datawindow within tabpage_screen
integer x = 27
integer y = 312
integer width = 3497
integer height = 1508
integer taborder = 70
string dataobject = "d_sys_fields_for_new_screen"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;IF This.GetColumnName() = "lookup_type" THEN
	This.SetItem( row, "lookup_field", "Y" )
END IF
end event

type gb_1 from groupbox within tabpage_screen
integer x = 27
integer y = 16
integer width = 3493
integer height = 264
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type dw_sys_fields_add from datawindow within tabpage_screen
integer x = 50
integer y = 316
integer width = 1687
integer height = 1412
integer taborder = 80
string dataobject = "d_sys_fields_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_data_view_field from datawindow within tabpage_screen
integer x = 1897
integer y = 312
integer width = 1573
integer height = 1312
integer taborder = 80
string dataobject = "d_data_view_fields_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ver_ltr from datawindow within tabpage_screen
boolean visible = false
integer x = 274
integer y = 676
integer width = 3109
integer height = 1044
integer taborder = 30
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

