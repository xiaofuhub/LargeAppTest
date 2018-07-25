$PBExportHeader$pfc_n_cst_ai_export_apb.sru
forward
global type pfc_n_cst_ai_export_apb from nonvisualobject
end type
end forward

global type pfc_n_cst_ai_export_apb from nonvisualobject
end type
global pfc_n_cst_ai_export_apb pfc_n_cst_ai_export_apb

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-29 By: Rodger Wu
//$<reason> Added for fix a APB bug.
string is_select_syntax = ""
string is_select_syntax_drop = "" //add by stephen 03.26.2013
//---------------------------- APPEON END ----------------------------

//Added for Merge data in Document Manager. 2.6.2007 Henry
// '2'- for merging data in document manager and agreement template
//	'3'- for replacing fields in e-mail template //by Alfee 05.25.2007
// '4'- Export format set to .txt	//08.29.2007 
String is_called_type = '0' 

Boolean ib_gen_rec_id = FALSE //Gen rec id - Alfee 06.11.2008
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.11.2007 By: Jack
//$<reason> 
boolean ib_header = False
datastore ids_export_data 
datastore ids_export_data_drop //add by stephen 03.26.2013
//---------------------------- APPEON END ----------------------------

boolean ib_nyp_fte = false  //Start Code Change ---- 09.27.2007 #V7 maha

//Start Code Change ----10.22.2008 #V85 maha
n_ds ids_export_flds
n_ds ids_export_hdr
n_ds ids_export_retrieve
n_ds ids_address_lookup
n_ds ids_code_lookup
n_ds ids_dept_chair
n_ds ids_field
n_ds ids_export_dataTemp
n_ds ids_export_equiv_code
n_ds ids_tablepk
//End Code Change---10.23.2008
n_ds ids_billing//For optimize export Added by  Nova 03.26.2010

datastore ids_cred_export_data //Evan 01.20.2010 (V10.1 - Notification Alert)
datastore ids_ctx_export_data //---------Added by (Appeon)long.zhang 05.24.2014 (v14.2 Provider-Contract direct linking)

boolean ib_flag=false//For optimize export Added by  Nova 03.26.2010

n_cst_message inv_message //scheduler - alfee 02.06.2010
Boolean ib_schedule = false //scheduler - alfee 02.25.2010

n_cst_string_appeon inv_string //alfee 04.02.2010

string is_billing_sql  //maha 08.29.2014
string is_billing_fields[]  //maha 08.29.2014
string is_text_delimiter = ''
string is_header_rebuild
string is_field_headers[]
//---------Begin Added by (Appeon)Toney 06.19.2013 for V141 ISG-CLX--------
Boolean ib_writefile	
n_cst_array_db inv_arr_db	
n_cst_rights invo_rights	
string is_client_id[]	
//---------End Added ------------------------------------------------------------------
string is_savetablename//(Appeon)Toney 11.28.2013 - V141 ISG-CLX,Fix BugT112602

//---------Begin Added by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
n_ds ids_dataobject    
datastore ids_linkto
String is_tablelist[]
String is_billsynList[]
String is_fieldlist[]
String is_selectfieldlist[]
String is_lu_selectfieldlist[] //stephen 09.05.2014
String is_lu_typelist[] //stephen 09.05.2014
String is_formatList[]
String is_dcfieldList[] 
String is_defvalList[]
String is_textList[]
String is_lu_fieldList[] 
String is_lu_type[] //maha 09.02.2014
String is_typelist[]
String is_flddelimList[]
String is_table[]
String is_tablepks[]
String is_sortpk[]
Long ii_recdnoList[]
Long il_exportcodeList[]
Long il_intcredfieldList[]
Long ii_substartList[]
Long ii_widthList[]
Long ii_udList[]
Long ii_facil_idList[]
Long ii_act_formatList[]
Long ii_billingList[] 
String is_lookup[] //(Appeon)Harry 02.27.2015 
//---------End Added ------------------------------------------------------
Boolean ib_export_test = false //(Appeon)Harry 09.01.2014 - for BugH070801 in V14.2 Issues of Integration.doc
string is_user_name = "@name"  //maha 11.03.2016
string is_user_email = "@email"  //maha 11.03.2016
string is_user_street = "@street"  //maha 11.03.2016
string is_user_street2 = "@street2"  //maha 11.03.2016
string is_user_city = "@city"  //maha 11.03.2016
string is_user_state = "@state"  //maha 11.03.2016
string is_user_zip = "@zip"  //maha 11.03.2016
string is_user_phone = "@phone"  //maha 11.03.2016
string is_user_fax = "@fax"  //maha 11.03.2016

private:
str_action_item istr_action_item //(Appeon)Harry 04.10.2014 - for Bug 3998
end variables

forward prototypes
public function string of_date_format (string as_format, datetime as_datetime)
public function string of_get_billing (long al_id, string as_type, string as_field, string as_field_format, string as_syntax)
public function string of_prompt_populate (string as_type, string as_value)
public function string of_prompt_syntax (string as_sql, string as_parm1, string as_parm2, string as_parm3)
public function integer of_export_data (integer ai_export_id, long al_prac_ids[])
public function integer of_get_export_data (long al_export_id, long al_data_id, ref datastore ads_data)
public function string of_custom_name (integer ai_custom, string as_table, datetime adt_date)
public function integer of_create_export_table (integer ai_exp_id, integer ai_save)
public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase)
public subroutine of_bubblesort (ref long al_prac_ids[])
public subroutine of_export_calculatedfield (n_ds ads_export_datatemp, n_ds ads_export_data, string as_format)
public function string of_get_dbtype ()
public subroutine of_replacespecchar (ref string as_string)
public function long of_export_processdefault (n_ds ads_export_hdr, n_ds ads_export_flds, n_ds ads_export_datatemp, n_ds lds_export_data)
public subroutine of_data_format (string as_format, string as_type, ref string as_data)
public function integer of_multi_row (n_ds ads_export, string as_table, integer ai_table, integer ai_col_num[], n_ds ads_exp_fields, long al_prac_ids[], string as_where)
public function integer of_nyp_fte_rows (n_ds ads_rows)
public function string of_strip_char_not_used (string as_strip, string as_string, string as_replace)
public subroutine of_get_sortsel (ref string as_sortsel, string as_delstr)
public function integer of_get_export_data (long al_export_id, long al_data_id[], ref datastore ads_data)
public function integer of_cleanup_ds ()
public function integer of_open_export_pogress ()
public function string of_get_sched_msg ()
public function integer of_get_sched_cnt ()
public function integer of_set_sched_flag (boolean ab_flag)
public function integer of_copy_expdata (datastore ads_export_data, string as_format, boolean ab_header, string as_path, boolean ab_save)
public function string of_get_coltype (datastore ads_object, string as_name)
public function integer of_set_str_action_item (str_action_item astr_action_item)
public function integer of_create_ds ()
public function integer of_cleanup_array ()
public function string of_getsql_from_export_temp (string as_sql, long al_spid, ref boolean ab_mulsel, string as_value)
public function integer of_gensql_ctx (integer ai_type, ref long ll_fieldseqid, string as_param1, string as_param2, string as_param3, ref string as_sny_retrieve, str_gensql_param astr_gensql_param)
public function integer of_gensql_prac (integer ai_type, ref long ll_fieldseqid, string as_param1, string as_param2, string as_param3, ref string as_sny_retrieve, str_gensql_param astr_gensql_param)
public function integer of_create_export_ds (string as_unionsql, string as_tabletemp, string as_rowno, long al_maxwidth, string as_type)
public function integer of_cleanup_ds (boolean ab_flag)
public function integer of_export_data_with_text_backup (integer ai_export_id, long al_prac_ids[], ref string as_path, integer ai_save_data, string as_param1, string as_param2, string as_param3, integer ai_type, string as_sql)
public function integer of_export_data_with_text (integer ai_export_id, long al_prac_ids[], ref string as_path, integer ai_save_data, string as_param1, string as_param2, string as_param3, integer ai_type, string as_sql)
public function integer of_export_data_with_text_ctx_backup (integer ai_export_id, long al_prac_ids[], ref string as_path, integer ai_save_data, string as_param1, string as_param2, string as_param3, integer ai_type, string as_sql)
public function integer of_export_data_with_text_ctx (integer ai_export_id, long al_prac_ids[], ref string as_path, integer ai_save_data, string as_param1, string as_param2, string as_param3, integer ai_type, string as_sql)
public function integer of_create_billing_data (string as_pracs)
public function string of_get_billing_new (long al_rec, string as_field, string as_type, string as_field_format)
public function integer of_multi_query_filter (string as_bill_link, string as_table, integer ai_use_link, string as_sql, string as_query_filter, string as_field_name, string as_value, long al_rec_id, integer ai_table_id, integer ai_facility_id, integer ai_faci_filter)
public function integer of_multi_row_new (n_ds ads_export, string as_table, integer ai_table, integer ai_col_num[], n_ds ads_exp_fields, long al_prac_ids[], string as_where, string as_prac_sql)
public function string of_getsql_from_export_temp (long al_prac_ids[], long al_spid, ref boolean lb_mulsel, string as_value)
end prototypes

public function string of_date_format (string as_format, datetime as_datetime);//Start Code Change ---- 07.10.2007 #V7 maha  Copied from version 5 as it was never updated in the new object
string ls_value
datetime ldt_date
string ls_month
string ls_year
string ls_day
string ls_hour
string ls_minute
string ls_second

ldt_date = as_datetime
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 25/04/2007 By: Jervis
//$<reason> 
if isnull(as_datetime) then return ""
//---------------------------- APPEON END ----------------------------

ls_month = string(month(date(ldt_date)))
ls_year = string(year(date(ldt_date)))
if LenA(ls_month) = 1 then ls_month = "0" + ls_month
ls_day  = string(day(date(ldt_date)))
if LenA(ls_day) = 1 then ls_day = "0" + ls_day
ls_hour = string(hour(time(ldt_date)))
if LenA(ls_hour) = 1 then ls_hour = "0" + ls_hour
ls_minute = string(minute(time(ldt_date)))
if LenA(ls_minute) = 1 then ls_minute = "0" + ls_minute
ls_second = string(second(time(ldt_date))) //maha 121505
if LenA(ls_second) = 1 then ls_second = "0" + ls_second
	//messagebox("ls_field_format",ls_field_format)
choose case as_format		
	case "yyyymmddhhmm"
		ls_value = ls_year + ls_month + ls_day + ls_hour + ls_minute
	case "yyyy-mm-dd"
		ls_value = ls_year + "-" + ls_month + "-" + ls_day
	case "mm-dd-yyyy"
		ls_value = ls_month + "-" + ls_day  + "-" + ls_year
	case "mm/dd/yyyy"
		ls_value = ls_month + "/" + ls_day  + "/" + ls_year
	case "mm-dd-yy"
		ls_year = MidA(ls_year,3,2)
		ls_value = ls_month + "-" + ls_day  + "-" + ls_year
	case "yyyymmdd" //maha 070605
		ls_value = ls_year + ls_month + ls_day		
	case "mm/dd/yy"
		ls_year = MidA(ls_year,3,2)
		ls_value = ls_month + "/" + ls_day  + "/" + ls_year
//Start Code Change ---- 11.03.2005 #23 maha
	case "yyyy"
		ls_value = ls_year
//End Code Change---11.03.2005 
	case "yyyymmddhhmmss" //maha 121505
		ls_value = ls_year + ls_month + ls_day + ls_hour + ls_minute + ls_second
	case "yyyy_mm_dd_hh_mm"   //Start Code Change ----03.05.2015 #V15 maha - for CAQH format
		ls_value = ls_year + "_" + ls_month + "_" + ls_day + "_" +ls_hour + "_" +ls_minute
	case else
		ls_value = ls_year + "-" +ls_month + "-" +ls_day + " " +ls_hour + ":" +ls_minute
		
	end choose

			
if isnull(ls_value) then ls_value = ""

return ls_value
end function

public function string of_get_billing (long al_id, string as_type, string as_field, string as_field_format, string as_syntax);//of_get_billing created maha app080205 to get billing add link data 

string ls_val
string ls_sql_syntax
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_field
integer r
datetime ldt_value
//n_ds lds_billing //For optimize export  commented by  Nova 03.26.2010
Long ll_pos //Added by  Nova 03.26.2010
Long ll_pos_last //Added by  Nova 03.26.2010

//Start Code Change ---- 01.01.2007 #V7 maha
if upper(MidA(as_field,1,4)) = 'CODE'  then  //maha 010107
	ls_field = as_field
else
	ls_field =  "pd_address_" + as_field
end if

if isnull(al_id)  then return "" //(Appeon)Stephen 12.18.2013 - IntelliExport Billing Address Link problem

//End Code Change---01.01.2007
//--------Begin Modified by  Nova 03.26.2010------------------------
//ls_sql_syntax = as_syntax + " rec_id = " + string(al_id) + ";"
ll_pos = PosA(as_syntax,' and ',1)
ll_pos_last = ll_pos
DO WHILE ll_pos > 0
	ll_pos = PosA(as_syntax,' and ',ll_pos+1)
	IF ll_pos > 0 THEN ll_pos_last = ll_pos
LOOP
ls_sql_syntax = MidA(as_syntax,1,ll_pos_last -1)
//--------End Modified --------------------------------------------
//IF ib_flag THEN //delete by stephen 04.18.2013 - Bug 3487:System Error when running export
IF ib_flag or not isvalid(ids_billing) THEN // add by stephen 04.18.2013 - Bug 3487:System Error when running export
	ls_presentation_str = "style(type=form)" 
	//MessageBox("address id",al_id)
	//MessageBox("Caution",ls_sql_syntax)
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
		if PosA(ERRORS,"Table or view not found",1) > 0 then
	//		messagebox ("Billing address data store not able to be created", ls_sql_syntax)
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox ("Billing address data store not able to be created", ls_sql_syntax,true)	
			close(w_export_progress)
			return ""
			
		else
	//		MessageBox("Caution", &
	//		"SyntaxFromSQL caused these errors: " + ERRORS)
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox("Caution","SyntaxFromSQL caused these errors: " + ERRORS,true)	
			close(w_export_progress)
			RETURN ""
		end if
	END IF
	ids_billing = Create n_ds
	ids_billing.Create( ls_dwsyntax_str, ERRORS)
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 04.18.2013
	//$<reason>Bug 3487:System Error when running export
	if LenA(ERRORS) > 0 then
		inv_message.of_MessageBox("Caution","Failed to dynamically create datawindow.", true)	
		close(w_export_progress)
		RETURN ""
	end if
	//------------------- APPEON END -------------------
	ids_billing.SetTransObject( SQLCA )
	ids_billing.Retrieve()
END IF

//---------Begin Added by (Appeon)Stephen 12.18.2013 for IntelliExport Billing Address Link problem--------
ids_billing.SetFilter( "1=1")
ids_billing.Filter()
//---------End Added ------------------------------------------------------

//--------Begin Modified by  Nova 03.26.2010------------------------
ids_billing.SetFilter( "address_id = " + String(al_id))
ids_billing.Filter()
r = ids_billing.RowCount()
//--------End Modified --------------------------------------------

if r > 0 then
		choose case upper(MidA(as_type,1,1))
			case "N","I"  //number
				ls_val = string(ids_billing.getitemnumber(1, ls_field ))
			case "C","V","L"	//character
//				messagebox(string(al_id) + "-" + string(r),ls_field)
				ls_val = ids_billing.getitemString( 1, ls_field )
			case "T"	//datetime
				ldt_value = ids_billing.getitemdatetime(1, ls_field )
				//format the date
				ls_val = of_date_format(as_field_format,ldt_value) //maha 070705
				//messagebox("date value",ls_val)
			case else
				//messagebox("datatype not anticipated",as_type)
  				//messagebox("Datatype Not Anticipated",as_type)
				  //Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
 					inv_message.of_MessageBox("Datatype Not Anticipated",as_type,true)	
				ls_val = ""
		end choose
end if



//destroy lds_billing//For optimize export  commented by  Nova 03.26.2010

return ls_val







end function

public function string of_prompt_populate (string as_type, string as_value);
//Start Code Change ---- 11.03.2005 #22 maha
string ls_return

if as_type = "D" then
	//strip date format
	ls_return = MidA(as_value,7,10)
elseif as_type = "C" then
	//strip quotes
	ls_return = MidA(as_value,2,LenA(as_value) - 2)
else
	ls_return = as_value
end if
	

return ls_return

//End Code Change---11.03.2005 

end function

public function string of_prompt_syntax (string as_sql, string as_parm1, string as_parm2, string as_parm3);//Start Code Change ---- 11.03.2005  maha
integer li_start
integer li_end
integer li_pos = 1
string ls_sql

ls_sql = as_sql
li_start = PosA(Upper(ls_sql),"PROMPT1",li_pos)		//Modify by Scofield on 2007-06-26       	as_sql--->ls_sql
do while li_start > 0
	ls_sql = MidA(ls_sql,li_pos,li_start - 1) + as_parm1 + MidA(ls_sql,li_start + 7 )
	li_start = PosA(Upper(ls_sql),"PROMPT1",li_start)
loop
//Start Code Change ---- 12.01.2006 #V7 maha
li_start = PosA(Upper(ls_sql),"PROMPT2",1)				//Modify by Scofield on 2007-06-26       	as_sql--->ls_sql
do while li_start > 0
	ls_sql = MidA(ls_sql,1,li_start - 1) + as_parm2 +MidA(ls_sql,li_start + 7 )				//Modify by Scofield on 2007-06-26       as_parm1--->as_parm2
	li_start = PosA(Upper(ls_sql),"PROMPT2",li_start)
loop

li_start = PosA(Upper(ls_sql),"PROMPT3",1)				//Modify by Scofield on 2007-06-26       	as_sql--->ls_sql
do while li_start > 0
	ls_sql = MidA(ls_sql,1,li_start - 1) + as_parm3 +MidA(ls_sql,li_start + 7 )				//Modify by Scofield on 2007-06-26       as_parm1--->as_parm3
	li_start = PosA(Upper(ls_sql),"PROMPT3",li_start)
loop
//End Code Change---12.01.2006

return ls_sql

end function

public function integer of_export_data (integer ai_export_id, long al_prac_ids[]);
////old version; not being used
//
//SetPointer( HourGlass! )
//
//Boolean lb_table_found
//Long ll_fld_val
//Integer i
//Integer li_found_rec
//Integer li_field_width
//Integer p
//Integer li_rec_no
//Integer li_file_num
//Integer li_array_index
//Integer li_search_from_row
//Integer li_prac_id_cnt
//Integer li_table_cnt
//Integer t
//Integer e
//Integer g
//Integer li_data_rc
//Integer li_found_row
//Integer li_fld_cnt
//Integer li_fld_type //maha
//String ls_trail_val
//String ls_lookup_type
//String ls_lookup_code
//String ls_trail_record
//String ls_fixed_width
//String ls_hdr_val
//String ls_hdr_record
//String Errors
//String ls_export_record
//String ls_fld_type
//String ls_fld_delim
//String ls_fld_val
//String ls_lead_trail_char
//String ls_format
//String ls_table_name
//String ls_table_names[]
//String ls_sql_syntax
//String ls_field_name
//String ls_grey
//String ls_presentation_str
//String ls_dwsyntax_str
//String ls_value
//String ls_prac_ids
//n_ds lds_export_hdr
//n_ds lds_export_flds
//n_ds lds_export_data[]
//n_ds lds_code_lookup
//n_ds lds_address_lookup
//
//
//li_prac_id_cnt = UpperBound( al_prac_ids[] )
//
//FOR i = 1 TO li_prac_id_cnt
//	ls_prac_ids = ls_prac_ids + String( al_prac_ids[i] ) + ","
//END FOR
//
//ls_prac_ids = Left( ls_prac_ids, Len( ls_prac_ids ) -1 )
//
//lds_code_lookup = CREATE n_ds
//lds_code_lookup.DataObject = "d_code_lookup"
//lds_code_lookup.of_SetTransObject( SQLCA )
//
//lds_address_lookup = CREATE n_ds
//lds_address_lookup.DataObject = "d_address_lookup"
//lds_address_lookup.of_SetTransObject( SQLCA )
//
//lds_export_hdr = CREATE n_ds
//lds_export_hdr.DataObject = "d_export_hdr"
//lds_export_hdr.of_SetTransObject( SQLCA )
//
//lds_export_flds = CREATE n_ds
//lds_export_flds.DataObject = "d_export_flds_list"
//lds_export_flds.of_SetTransObject( SQLCA )
//
//
//lds_export_hdr.Retrieve( ai_export_id )
//
//li_fld_cnt = lds_export_flds.Retrieve( ai_export_id )
//
//lds_export_flds.SetSort( "export_order" )
//lds_export_flds.Sort(  )
//
//IF lds_export_hdr.GetItemString( 1, "field_labels_as_header" ) = "Y" THEN
//	FOR i = 1 TO li_fld_cnt
//		ls_field_name = Trim( lds_export_flds.GetItemString( i, "export_field_name" ) )
//		ls_hdr_record = ls_hdr_record + ls_field_name + "	"
//	END FOR
//	ls_hdr_record = Left( ls_hdr_record, Len(ls_hdr_record) -1 )	
//ELSE
//	FOR i = 1 TO 4
//		ls_hdr_val = lds_export_hdr.GetItemString( 1, "header" + String( i ) )
//		IF IsNull( ls_hdr_val ) THEN
//			ls_hdr_val = ""
//		END IF
//		ls_hdr_record = ls_hdr_record + ls_hdr_val
//	END FOR
//END IF
//
//FOR i = 1 TO 4
//	ls_trail_val = lds_export_hdr.GetItemString( 1, "footer" + String( i ) )
//	IF IsNull( ls_trail_val ) THEN
//		ls_trail_val = ""
//	END IF
//	ls_trail_record = ls_trail_record + ls_trail_val
//END FOR
//
//li_file_num = FileOpen("C:\intellicred\export_test.txt", LineMode!, Write!, LockWrite!, Replace!)
//
//FileWrite ( li_file_num, ls_hdr_record )
//
////FIND ALL THE TABLES
//FOR i = 1 TO li_fld_cnt
//	ls_table_name = Trim( lds_export_flds.GetItemString( i, "db_table_name" ) )
//	lb_table_found = False
//	FOR t = 1 TO li_table_cnt
//		IF ls_table_names[t] = ls_table_name THEN
//			lb_table_found = True
//		   EXIT
//		END IF
//	END FOR
//	IF NOT lb_table_found THEN
//		li_table_cnt ++
//		ls_table_names[ li_table_cnt ] = ls_table_name
//	END IF
//END FOR
//
////BUILD SELECT 
//
//FOR p = 1 TO li_prac_id_cnt
//	li_found_row = 1
//	li_search_from_row = 1
//	FOR i = 1 TO li_table_cnt
//		ls_sql_syntax = "SELECT "
//		DO 
//			li_found_row = lds_export_flds.Find( "db_table_name = '" + ls_table_names[i] + "'", li_search_from_row, li_fld_cnt )
//			IF li_found_row > 0 THEN
//				ls_field_name = Trim( lds_export_flds.GetItemString( li_found_row, "db_field_name" ) )
//				ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + "." + ls_field_name + ", "
//				li_search_from_row = li_found_row + 1
//			ELSE
//				EXIT
//			END IF
//		LOOP UNTIL li_found_row <= 0 OR li_search_from_row > li_fld_cnt
//	
//		ls_sql_syntax = Left( ls_sql_syntax, Len(ls_sql_syntax) -2 )
//
//
//		//BUILD FROM CLAUSE
//		ls_sql_syntax = ls_sql_syntax + " FROM " + ls_table_names[i]
//
//		//ADD WHERE CLAUSE
//		ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[i] + ".prac_id  = " + String(al_prac_ids[p])  
//
//		//CREATE SYNTAX FOR DETAIL DW
//		ls_presentation_str = "style(type=form)" 
//
//		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, ls_presentation_str, ERRORS)
//
//		IF Len(ERRORS) > 0 THEN
//			MessageBox("Caution", &
//			"SyntaxFromSQL caused these errors: " + ERRORS)
//			RETURN -1
//		END IF
//
//		lds_export_data[i] = CREATE n_ds
//		lds_export_data[i].Create( ls_dwsyntax_str, ERRORS)
//		lds_export_data[i].SetTransObject( SQLCA )
//		li_data_rc = lds_export_data[i].Retrieve( )
//	END FOR
//	
//	ls_export_record = ""
//
//	FOR e = 1 TO li_fld_cnt
//		ls_table_name = Trim( lds_export_flds.GetItemString( e, "db_table_name" ) )
//		ls_field_name = Trim( lds_export_flds.GetItemString( e, "db_field_name" ) )
//		li_field_width = lds_export_flds.GetItemNumber( e, "export_field_length" )
//		ls_fld_type = lds_export_flds.GetItemString( e, "db_field_type" )
//		ls_lookup_type = lds_export_flds.GetItemString( e, "db_lookup_type" )
//		ls_lookup_code = lds_export_flds.GetItemString( e, "db_lookup_code" )		
//		ls_lead_trail_char = lds_export_flds.GetItemString( e, "trailing_leading_characters" )		
//		ls_format = lds_export_flds.GetItemString( e, "export_format" )		
//		li_rec_no = lds_export_flds.GetItemNumber( e, "intcred_record_number" )
//		ls_fixed_width = lds_export_flds.GetItemString( e, "export_fixed" )		
//		ls_fld_delim = lds_export_hdr.GetItemString( 1, "field_delimiter" )
//		ls_fld_val = "" 
//		
//		CHOOSE CASE ls_fld_delim
//			CASE "C"
//				ls_fld_delim = ","
//			CASE "T"
//				ls_fld_delim = "	"
//		END CHOOSE
//			
//		FOR g = 1 TO li_table_cnt
//			IF ls_table_name = ls_table_names[g] THEN
//				li_array_index = g
//				EXIT
//			END IF
//		END FOR
//		//messagebox("li_rec_no",li_rec_no)
//		//messagebox("ls_field_name",ls_field_name)
//		IF lds_export_data[ li_array_index ].RowCount() >= li_rec_no THEN
//			CHOOSE CASE Upper( ls_fld_type )
//				CASE "I", "N"
//					ll_fld_val = lds_export_data[ li_array_index ].GetItemNumber( li_rec_no, ls_field_name ) 
//					IF ls_lookup_type = "C" THEN
//						lds_code_lookup.Retrieve( ls_lookup_code )
//						li_found_rec = lds_code_lookup.Find( "lookup_code = " + String( ll_fld_val ), 1, 100000 )
//						IF li_found_rec < 1 THEN
//							ls_fld_val = "Error"
//						ELSE
//							ls_fld_val = lds_code_lookup.GetItemString( li_found_rec, "code" )						
//						END IF
//					ELSEIF ls_lookup_type = "A" THEN
//						lds_address_lookup.Retrieve( ls_lookup_code )
//						li_found_rec = lds_address_lookup.Find( "lookup_code = " + String( ll_fld_val ), 1, 100000 )
//						IF li_found_rec < 1 THEN
//							ls_fld_val = "Error"
//						ELSE
//							ls_fld_val = lds_address_lookup.GetItemString( li_found_rec, "entity_name" )					
//						END IF
//					ELSE	
//						ls_fld_val = String( lds_export_data[ li_array_index ].GetItemNumber( li_rec_no, ls_field_name ) )
//					END IF
//				CASE "C"
//					ls_fld_val = lds_export_data[ li_array_index ].GetItemString( li_rec_no, ls_field_name )
//				CASE "D"				
//					ls_fld_val = String( lds_export_data[ li_array_index ].GetItemDateTime( li_rec_no, ls_field_name ), ls_format )
//			END CHOOSE
//		END IF
//				
//		IF IsNull( ls_fld_val ) THEN
//			ls_fld_val = ""
//		END IF
//
//		CHOOSE CASE ls_format
//			CASE "Trailing Padding"
//				ls_fld_val = ls_fld_val + Fill( ls_lead_trail_char , li_field_width - Len( ls_fld_val ) ) + ls_fld_delim
//			CASE "Leading Padding"
//				ls_fld_val = Fill( ls_lead_trail_char , li_field_width - Len( ls_fld_val ) ) + ls_fld_val + ls_fld_delim
//			CASE ELSE
//				ls_fld_val = ls_fld_val + ls_fld_delim
//		END CHOOSE
//
//		ls_export_record = ls_export_record + ls_fld_val
//		
//	END FOR
//
//	FileWrite ( li_file_num, ls_export_record )
//
//	
//END FOR
//
//FileWrite ( li_file_num, ls_trail_record )
//
//FileClose( li_file_num )
//
//
RETURN 0
end function

public function integer of_get_export_data (long al_export_id, long al_data_id, ref datastore ads_data);//////////////////////////////////////////////////////////////////////
// $<function>w_sheet_ctx_doc_painter/of_get_export_data()
// $<arguments>
//		value    	long     	al_export_id		
//		value    	long     	al_data_id  		ctx_id or prac_id
//		reference	datastore	ads_data    		
// $<returns> integer	1-Successful  0-No export found  -1-Failed
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-15 by Rodger Wu
//////////////////////////////////////////////////////////////////////
//Overloaded by Alfee on 06.11.2008

Integer li_rtn
Long ll_data_id[]

ll_data_id[1] = al_data_id
li_rtn = of_get_export_data(al_export_id, ll_data_id, ads_data)

RETURN li_rtn


end function

public function string of_custom_name (integer ai_custom, string as_table, datetime adt_date);datetime ldt_now
string ls_ret
string ls_date

ldt_now = adt_date

choose case ai_custom
	case 1 //nyp pems cornell
		ls_date = of_date_format( "yyyymmddhhmmss", adt_date)
		ls_ret = "20200" + "_" + ls_date //Start Code Change ---- 07.26.2006 #609 maha
	case 2 //nyp pems columbia
		ls_date = of_date_format( "yyyymmddhhmmss", adt_date)
		ls_ret = "30200" + "_" + ls_date
	case 3 //file name plus date
		ls_date = of_date_format( "yyyy-mm-dd", adt_date)
		ls_ret = as_table + "-" + ls_date
	case 4 //Valence format      //Start Code Change ----08.18.2014 #V14.2 maha
		ls_date = of_date_format( "yyyymmdd", adt_date)
		ls_ret = as_table + "_PROVIDER_" + ls_date	+ "_01"
	case 6  //CAQH Roster   //Start Code Change ----03.05.2015 #V15 maha
		ls_date = of_date_format( "yyyy_mm_dd_hh_mm", adt_date)
		ls_ret = as_table + "_ProviderRoster_" + ls_date
		
		
	case else
		ls_ret = "UNKNOWN"
		
end choose


return ls_ret  	
end function

public function integer of_create_export_table (integer ai_exp_id, integer ai_save);//created 061302  maha

SetPointer( HourGlass! )


Integer i
Integer p
Integer t
Integer e
Integer g
Integer li_found_row
Integer li_fld_cnt
Integer li_fld_len //maha
String ls_table_name
String ls_table_new
String ls_sql_syntax
//String ls_value
String ls_select_field //maha
String ls_select_table //maha
String ls_ft //maha
integer li_drop_col  //add by stephen 03.26.2013
//n_cst_string lnvo_string//<add> 07/23/2007 by: Andy

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.21.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

n_ds lds_export_hdr
n_ds lds_export_flds
//comment 08/31/2007 by: Andy
//n_ds lds_export_text
//datawindow lds_export_data
//n_ds lds_code_lookup
//n_ds lds_address_lookup

lds_export_hdr = Create n_ds
lds_export_hdr.DataObject = "d_export_hdr"
lds_export_hdr.of_SetTransObject( SQLCA )

lds_export_flds = Create n_ds
lds_export_flds.DataObject = "d_export_flds_list_exp"
lds_export_flds.of_SetTransObject( SQLCA )

//comment 08/31/2007 by: Andy
//lds_export_text = CREATE n_ds
//lds_export_text.DataObject = "d_export_flds_list_exp"
//lds_export_text.of_SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( )

lds_export_hdr.Retrieve( ai_exp_id )
li_fld_cnt = lds_export_flds.Retrieve( ai_exp_id )

gnv_appeondb.of_commitqueue( )

t = lds_export_hdr.RowCount()
li_fld_cnt = lds_export_flds.RowCount()

IF t < 1 THEN
	//MessageBox("Problem in of_create_export_table","No return on export header.")
   //Added by Nova 01.25.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Problem in of_create_export_table","No return on export header.",true)	
	//<add> 08/31/2007 by: Andy
	//---------Begin Added by (Appeon)Toney 06.19.2013 for V141 ISG-CLX--------
	gnv_debug.of_output(true, 'Alarm  Export: Problem in of_create_export_table","No return on export header.' )//added by gavins 20120912	
	//---------End Added ------------------------------------------------------------------
	Destroy lds_export_hdr
	Destroy lds_export_flds
	RETURN -2
END IF
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.23.2007 By: Jack
//$<reason> Fix a defect.
IF li_fld_cnt < 1 THEN
		//MessageBox("Problem in of_create_export_table","No Export Column.")
	//---------Begin Added by (Appeon)Toney 06.19.2013 for V141 ISG-CLX--------
	gnv_debug.of_output(true, 'Alarm  Export: "Problem in of_create_export_table","No Export Column."' )//added by gavins 20120912	
	//---------End Added ------------------------------------------------------------------	
	//<add> 08/31/2007 by: Andy
	Destroy lds_export_hdr
	Destroy lds_export_flds
	RETURN -1
END IF
//---------------------------- APPEON END ----------------------------

//modify 08/31/2007 by: Andy	
//1:save / 3:save & preview
IF ai_save = 1 Or ai_save = 3 THEN
	ls_table_name = lds_export_hdr.GetItemString(1,"export_name")
	//Modify 07/23/2007 by: Andy
		/*
		ls_table_new = ls_table_name
		li_fld_len = len(ls_table_name)
		
		//remove spaces from export name to make table name
		g = pos(ls_table_name," ")
		do while g <> 0
			ls_table_new = mid(ls_table_new,1,g - 1) + "_" + mid(ls_table_name,g + 1)	
		//	messagebox("ls_table_new",ls_table_new)
			g = pos(ls_table_new," ")
		loop
	*/
	//<add> 08/24/2007 by: Andy
	of_replacespecchar(ls_table_name)
	
	//ls_table_name = "exp_" + ls_table_new
	ls_table_name = "exp_" + ls_table_name
	//end of modify
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-02
	//$<add> 02.08.2006 By: Liang QingShi
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------
	
	//drop table
	ls_sql_syntax = "drop TABLE " +ls_table_name + ";"
	EXECUTE Immediate :ls_sql_syntax Using SQLCA;
	COMMIT Using SQLCA;
	
	//<add> 08/24/2007 by: Andy
	gnv_appeondb.of_commitqueue( )
	
	//build table
	ls_sql_syntax = "CREATE TABLE " +ls_table_name + " ( "
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-12-29 By: Rodger Wu
	//$<reason> Added for fix a APB bug.
	is_select_syntax = "select "
	//---------------------------- APPEON END ----------------------------
	//add 08/31/2007 by: Andy	
ELSE
	is_select_syntax = "Select top 1 "
END IF
is_select_syntax_drop = is_select_syntax //add by stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
//end of add

FOR p = 1 To li_fld_cnt
	
	li_fld_len = lds_export_flds.GetItemNumber(p,"export_field_length")
	
	if is_text_delimiter = "Q" then li_fld_len = li_fld_len  + 2 //Start Code Change ----09.18.2014 #V14.2 maha - for text delimiters
	
	ls_select_field = lds_export_flds.GetItemString(p,"export_field_name")
	
	li_drop_col =  lds_export_flds.GetItemNumber(p,"drop_column")
	if isnull(li_drop_col) then li_drop_col = 0 //add by stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	
	//<add> 08/24/2007 by: Andy
	of_replacespecchar(ls_select_field)
	
	
	//modify 08/31/2007 by: Andy
	IF ai_save = 1 Or ai_save = 3 THEN
		ls_sql_syntax = ls_sql_syntax + ls_select_field + " VARCHAR(" +  String(li_fld_len) + ")"
		/*comment 07/12/2007 by: Andy
				if len(ls_value) > 0 then
					ls_sql_syntax = ls_sql_syntax + " DEFAULT '" + ls_value + "'"
				end if
		*/
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.22.2006 By: LeiWei
		//$<reason> Fix a defect.
		//$<reason> Due to the default ALLOW_NULLS_BY_DEFAULT option is OFF for JDBC connections
		//ls_sql_syntax = ls_sql_syntax + ", "
		ls_sql_syntax = ls_sql_syntax + " NULL, "
		is_select_syntax += ls_select_field + ", " //rodger wu added.
		//---------------------------- APPEON END ----------------------------
		//add 08/31/2007 by: Andy
		
		if li_drop_col <> 1 then is_select_syntax_drop += ls_select_field + ", " //add by stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	ELSE
		is_select_syntax += "cast('' as varchar(" + String(li_fld_len) + ")) " + ls_select_field + ", "
		if li_drop_col <> 1 then is_select_syntax_drop += "cast('' as varchar(" + String(li_fld_len) + ")) " + ls_select_field + ", " //add by stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	END IF
	//end of add
NEXT

//modify 08/31/2007 by: Andy
IF ai_save = 1 Or ai_save = 3 THEN
	ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
	
	ls_sql_syntax = ls_sql_syntax + ", rec_id numeric(8,0), constraint PK_" + ls_table_name + " primary key(rec_id) "
	is_select_syntax += "rec_id" //rodger wu added.
	is_select_syntax += " from " + ls_table_name //rodger wu added.
	
	is_select_syntax_drop += "rec_id" //add by stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	is_select_syntax_drop += " from " + ls_table_name //add by stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	
	ls_sql_syntax = ls_sql_syntax + ");"
	
	//messagebox("ls_sql_syntax",ls_sql_syntax)
	
	EXECUTE Immediate :ls_sql_syntax Using SQLCA;
	//<ADD> 08/24/2007 BY: Andy
	IF SQLCA.SQLCode <> 0 THEN
	//			MessageBox(gnv_app.iapp_object.DisplayName,"Create table failed.~r~n~n" + SQLCA.SQLErrText)
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
 		inv_message.of_MessageBox(gnv_app.iapp_object.DisplayName,"Create table failed.~r~n~n" + SQLCA.SQLErrText,true)	
		//<add> 08/31/2007 by: Andy
		//---------Begin Added by (Appeon)Toney 06.19.2013 for V141 ISG-CLX--------
		gnv_debug.of_output(true, 'Alarm  Export: ' + gnv_app.iapp_object.DisplayName + " Create table failed.~r~n~n" + SQLCA.SQLErrText  )//added by gavins 20120912		
		//---------End Added ------------------------------------------------------------------
		Destroy lds_export_hdr
		Destroy lds_export_flds
		RETURN -3
	END IF
	
	COMMIT Using SQLCA;
	//add 08/31/2007 by: Andy
ELSE
	//modify 10.10.2007 by: Andy
	//is_select_syntax += "0 rec_id from ids"
	is_select_syntax = LeftA( is_select_syntax, LenA(is_select_syntax) -2 )
	is_select_syntax_drop = LeftA( is_select_syntax_drop, LenA(is_select_syntax_drop) -2 ) //add by stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	//----Begin Modified by Alfeee on 06.11.2008------
	//<$Reason>For performance tuning in date alarm
	//is_select_syntax += " from ids"
	IF ib_gen_rec_id THEN
		is_select_syntax += ", 0 rec_id from ids"
		is_select_syntax_drop += ", 0 rec_id from ids" //add by stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	ELSE
		is_select_syntax += " from ids"
		is_select_syntax_drop += " from ids" //add by stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	END IF
	//----End Modified -------------------------------
	//end of modify
END IF
//end of add


//	if gi_test_mode = 1 then
//		messagebox("table syntax", ls_sql_syntax)	
//	end if
//

//<add> 08/31/2007 by: Andy
Destroy lds_export_hdr
Destroy lds_export_flds

is_savetablename = ls_table_name//(Appeon)Toney 11.28.2013 - V141 ISG-CLX,Fix BugT112602

RETURN 0

end function

public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GlobalReplace
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string.
// ab_IgnoreCase	A boolean stating to ignore case sensitivity.
//
//	Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Replace all occurrences of one string inside another with
//						a new string.
//
//////////////////////////////////////////////////////////////////////////////
//
//<add> 07/17/2007 by: Andy
//
//////////////////////////////////////////////////////////////////////////////
Long	ll_Start
Long	ll_OldLen
Long	ll_NewLen
String ls_Source
String  ls_Temps,ls_Tempe

//Check parameters
If IsNull(as_source) or IsNull(as_old) or IsNull(as_new) or IsNull(ab_ignorecase) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Get the string lenghts
ll_OldLen = LenA(as_Old)
ll_NewLen = LenA(as_New)

//Should function respect case.
If ab_ignorecase Then
	as_old = Lower(as_old)
	ls_source = Lower(as_source)
Else
	ls_source = as_source
End If

//Search for the first occurrence of as_Old
ll_Start = PosA(ls_Source, as_Old)

Do While ll_Start > 0
	ls_Temps = MidA(as_Source,ll_Start - 1,1)
	ls_Tempe = MidA(as_Source,ll_Start + ll_OldLen,1)
	//---------Begin Modified by (Appeon)Toney 06.19.2013 for V141 ISG-CLX--------
	//$Reason:
	  /*
	if (ll_Start = 1  or ls_Temps = ' ' or ls_Temps = ')' or ls_Temps = '(' or ls_Temps = '+' or ls_Temps = '-' or ls_Temps = '*' or ls_Temps = '/') and &
		(ls_Tempe = '' or ls_Tempe = ' ' or ls_Tempe = ')' or ls_Tempe = '(' or ls_Tempe = '+' or ls_Tempe = '-' or ls_Tempe = '*' or ls_Tempe = '/') then			
	  */
	if (ll_Start = 1  or ls_Temps = ' ' or ls_Temps = ')' or ls_Temps = '(' or ls_Temps = '+' or ls_Temps = '-' or ls_Temps = '*' or ls_Temps = '/' or ls_temps = ',') and &
		(ls_Tempe = '' or ls_Tempe = ' ' or ls_Tempe = ')' or ls_Tempe = '(' or ls_Tempe = '+' or ls_Tempe = '-' or ls_Tempe = '*' or ls_Tempe = '/' or ls_tempe = ',') then	
	//---------End Modfiied ------------------------------------------------------------------
		// replace as_Old with as_New
		as_Source = ReplaceA(as_Source, ll_Start, ll_OldLen, as_New)
	end if
	
	//Should function respect case.
	If ab_ignorecase Then 
		ls_source = Lower(as_source)
	Else
		ls_source = as_source
	End If
	
	// find the next occurrence of as_Old
	ll_Start = PosA(ls_Source, as_Old, (ll_Start + ll_NewLen))
Loop

Return as_Source

end function

public subroutine of_bubblesort (ref long al_prac_ids[]);//////////////////////////////////////////////////////////////
//Function :of_bubblesort(long al_prac_ids[]) returns none
//arguments:long al_prac_ids[]
//describe :bubble sort the al_prac_ids array
//developer:Andy 
//date     :08/14/2007
/////////////////////////////////////////////////////////////
long    ll_i,ll_j,ll_n,ll_temp
boolean lb_flag

ll_n = UpperBound(al_prac_ids)
for ll_i = 1 to ll_n - 1
	lb_flag = false
	for ll_j = ll_n - 1 to ll_i step -1 
		if al_prac_ids[ll_j + 1] < al_prac_ids[ll_j] then
			ll_temp = al_prac_ids[ll_j + 1]
			al_prac_ids[ll_j + 1] = al_prac_ids[ll_j]
			al_prac_ids[ll_j] = ll_temp
			lb_flag = true
		end if
	next
	if Not lb_flag then
		exit
	end if
next
//end of BubbleSort
end subroutine

public subroutine of_export_calculatedfield (n_ds ads_export_datatemp, n_ds ads_export_data, string as_format);//////////////////////////////////////////////////////////////////////
//function :of_export_CalculatedField
//arguments:ads_export_dataTemp <n_ds>
//          ads_export_data     <n_ds>
//return   :None
//describe :
//move from of_export_data_with_text_ctx by: Andy 08/22/2007 
//set Calculated field value and format into ads_export_data 
//with the relative computer column in ads_export_dataTemp
//////////////////////////////////////////////////////////////////////

Long   ll_Cnt,ll_Tab,li_width,ll_pos1,ll_pos2,ll_pos3,ll_Num,ll_Start = 1
Long   w,a,li_dif
String ls_Objects,ls_objname,ls_ObjType,ls_ColType,ls_Field,ls_tag
String ls_field_format,ls_ComputerDataType,ls_fld_delim,ls_data_value
String ls_pad,ls_text

if Not isValid(ads_export_dataTemp) or Not isValid(ads_export_data) then return

//<add> 08/22/2007 by: Andy Reason:use PFC function
ads_export_dataTemp.of_setbase(true) 

ll_Cnt = ads_export_dataTemp.RowCount()
ls_Objects=ads_export_dataTemp.describe("DataWindow.Objects") + '~t'

ll_Tab =  PosA(ls_Objects, "~t", ll_Start)
DO WHILE ll_Tab > 0
	ls_objname  = MidA(ls_Objects, ll_Start, (ll_Tab - ll_Start))
	ls_ObjType  = ads_export_dataTemp.Describe(ls_objname + ".type")
	ls_ColType  = ads_export_dataTemp.Describe(ls_objname + ".ColType")
   
	if lower(ls_ObjType) = 'compute' then
		//relative column
		ls_Field = LeftA(ls_objname,LenA(ls_objname) - 2)
		//<add> 08/23/2007
		if IsValid(w_export_progress) then
			w_export_progress.st_export.text  = ls_Field
			w_export_progress.st_export1.text = ls_Field  
		end if
		
		//get format,data type,width and delim
		ls_tag   = ''
		ls_tag   = ads_export_dataTemp.Describe(ls_objname + ".tag")
		if isnull(ls_tag) then ls_tag = ''

		ls_field_format = ''
		ls_ComputerDataType = ''
		li_width = 0
		ls_fld_delim = ''
		
		ll_pos1             = PosA(ls_tag,'@^@')
		ll_pos2             = PosA(ls_tag,'@^@',ll_pos1 + 3)
		ll_pos3             = PosA(ls_tag,'@^@',ll_pos2 + 3)
		
		ls_field_format     = LeftA (ls_tag,ll_pos1 - 1)
		ls_ComputerDataType = MidA(ls_tag,ll_pos1 + 3,ll_pos2 - (ll_pos1 + 3))
		li_width            = Long(MidA(ls_tag,ll_pos2 + 3,ll_pos3 - (ll_pos2 + 3)))
 		ls_fld_delim        = RightA(ls_tag,LenA(ls_tag) - ll_pos3 - 3)
		
		//<add> 06.13.2007 by: Andy Reason:fixed a bug		
		Choose Case LeftA ( ls_ColType , 5 )
			Case "char(", "char"
				ls_ComputerDataType = "S"
			Case "date"	,"datet"	,"time", "times"
				ls_ComputerDataType = "D"
			Case "decim","numbe", "doubl", "real","long", "ulong", "int"
				ls_ComputerDataType = "N"
		End Choose	
		//end of add
		
		//data transfer
		for ll_Num = 1 to ll_Cnt
			//get data
			//<add> 08/22/2007 by: Andy Reason:use PFC function
			ls_data_value = ads_export_dataTemp.inv_base.of_getitem(ll_Num,ls_objname)
			if is_text_delimiter = "Q" then 
				//ls_data_value = of_strip_char( '"', ls_data_value, "")  //Start Code Change ----09.18.2014 #V14.2 maha
				If Not IsNull(ls_data_value) Then ls_data_value = of_strip_char( '"', ls_data_value, "")  //Add isnull, by Appeon long.zhang 12.13.2016 (V15.2 Bug # 5445 - CSV Export with quote delimiters showing "null")
			End If
			
			//comment 08.31.2007 by: Andy
			/*
			if upper(ls_ComputerDataType) = 'N' then 
				if long(ls_data_value) = 0 then setnull(ls_data_value)
			end if
			*/
			//<add> andy 2007.06.01 set value into the relative computer column 
			ads_export_dataTemp.SetItem(ll_Num,ls_Field,ls_data_value)
			//end of add
			
			//deal with format
			If as_format = "export" Then
				If IsNull(ls_data_value) Then ls_data_value = ""
			End If
			
			//<add> 08/28/2007 by: Andy
			of_data_format(ls_field_format,ls_ComputerDataType,ls_data_value)
			//end of add
			
			/*comment 08/28/2007 by:Andy Reson:use of_data_format function
			If ls_field_format = "(xxx)xxx-xxxx" Then
				w = Len(ls_data_value)
				If w > 0 Then 
					For a = w To 1 Step - 1 
						If Not IsNumber(Mid(ls_data_value,a,1)) Then
							ls_data_value = Mid(ls_data_value,1,a - 1 ) + Mid(ls_data_value,a + 1 )
						End If
					Next
					ls_data_value = "(" + Mid(ls_data_value,1,3 ) + ")" + Mid(ls_data_value,4,3 ) + "-" + Mid(ls_data_value,7,4 )
				End If
			End If
	
			If ls_field_format = "$##,###" Then
				If isnumber(ls_data_value) Then
					//<add> 06/22/2007 by: Andy fixed bug5(IntelliContract/IntelliContract_Issues_6-21-07.doc)
					//Because if value equal to 0,it will display "$".
					if long(ls_data_value) = 0 then setnull(ls_data_value)
					If isnumber(ls_data_value) Then
						ls_data_value = string(Round( double(ls_data_value), 0 ),"$##,###")
					end if
					//end of add
					//comment 06/22/2007 by: Andy
					//ls_data_value = string(long(ls_data_value),"$##,###")
				End If
			ElseIf ls_field_format = "$##,###.##" Then
				If isnumber(ls_data_value) Then
					//<add> 06/22/2007 by: Andy fixed bug5(IntelliContract/IntelliContract_Issues_6-21-07.doc)
					//Because if value equal to 0,it will display "$.".
					if double(ls_data_value) = 0 then setnull(ls_data_value)
					If isnumber(ls_data_value) Then
						ls_data_value = string(Round( double(ls_data_value), 0 ),"$##,###.##")
					end if
					//end of add
					//comment 06/22/2007 by: Andy
					//ls_data_value = string(double(ls_data_value),"$##,###.##")
				End If
			//<add> 06/20/2007 by: Andy
			elseif ls_field_format = "$##,###.00" Then
				If isnumber(ls_data_value) Then
					//<add> 06/22/2007 by: Andy fixed bug5(IntelliContract/IntelliContract_Issues_6-21-07.doc)
					//Because if value equal to 0,it will display "$.00".	
					if double(ls_data_value) = 0 then setnull(ls_data_value)
					If isnumber(ls_data_value) Then
						ls_data_value = string(Round( double(ls_data_value), 0 ),"$##,###.00")
					end if
					//end of add
					//comment 06/22/2007 by: Andy
					//ls_data_value = string(double(ls_data_value),"$##,###.00")
				End If
			//end of add
			End If			
			*/
			
			ls_data_value = MidA(ls_data_value,1,li_width) //shrink the length to size 
			If ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" Then
				If li_width - LenA(ls_data_value) > 0 Then
					li_dif = li_width - LenA(ls_data_value)
					ls_pad = "" //reset
					ls_pad = FillA ( ls_fld_delim, li_dif )
					If ls_field_format = "Leading Padding" Then
						ls_data_value = ls_pad + ls_data_value
					Else
						ls_data_value = ls_data_value + ls_pad
					End If
				End If
			ElseIf ls_field_format = "use text" Then //allows a set value if data is found
				If LenA(ls_data_value) > 0 Then
					ls_data_value = ls_text//if export type equal 3 ,field_value is always null
				End If
			End If
			
			//set value into the relative field of ads_export_data
			if is_text_delimiter = "Q" then 				
				//ls_data_value = '"' + ls_data_value + '"'   //Start Code Change ----09.18.2014 #V14.2 maha
				If Not IsNull(ls_data_value) Then ls_data_value = '"' + ls_data_value + '"' //Add isnull, by Appeon long.zhang 12.13.2016 (V15.2 Bug # 5445 - CSV Export with quote delimiters showing "null")
			End If
			
			ads_export_data.SetItem(ll_Num,ls_Field,ls_data_value)
		next		
	end if
	
	//---------Begin Added by (Appeon)Stephen 11.02.2015 for Quality Care Partners Export - OPPOC2015--------
	if lower(ls_ObjType) = 'column' and is_text_delimiter = "Q" then
		for ll_Num = 1 to ll_Cnt
			//---------Begin Modified by (Appeon)Stephen 12.07.2015 for Export data column issues--------
			//ls_data_value = ads_export_dataTemp.inv_base.of_getitem(ll_Num,ls_objname)
			ls_data_value = ads_export_data.getitemstring(ll_Num,ls_objname)
			//---------End Modfiied ------------------------------------------------------
			
			//ls_data_value = '"' + ls_data_value + '"' 
			If Not IsNull(ls_data_value) Then ls_data_value = '"' + ls_data_value + '"'  //Add isnull, by Appeon long.zhang 12.13.2016 (V15.2 Bug # 5445 - CSV Export with quote delimiters showing "null")
			
			ads_export_data.SetItem(ll_Num,ls_objname,ls_data_value)
		next
	end if
	//---------End Added ------------------------------------------------------
	
	ll_Start = ll_Tab + 1
	ll_Tab =  PosA(ls_Objects, "~t", ll_Start)
LOOP

end subroutine

public function string of_get_dbtype ();///////////////////////////////////////////////// //
//function: of_get_dbtype 
//return  : <string> return the db type
//author  : Andy 08/23/2007
//////////////////////////////////////////////////
String ls_temp,ls_dbtype
Long   ll_Pos
Long ll_last_pos1,ll_last_pos2 //Added by  Nova 03.03.2010
String ls_asa_temp //Added by  Nova 03.03.2010

SELECT Top 1 @@version Into :ls_temp From ids;

IF PosA(Upper(ls_temp) , 'SQL SERVER') > 0 THEN
	IF PosA(Upper(ls_temp) , 'SQL SERVER 2005') > 0 THEN
		ls_dbtype = 'SQL2005'
	ELSEIF PosA(Upper(ls_temp) , 'SQL SERVER  2000') > 0 THEN
		ls_dbtype = 'SQL2000'
	ELSE
		ls_dbtype = 'SQL2005'
	END IF
ELSE
	ls_asa_temp = ls_temp //Added by  Nova 03.03.2010
	//modify 08/24/2007 by: Andy
	ll_Pos  = PosA(ls_temp,'.')
	ls_temp = LeftA(ls_temp,ll_Pos - 1)
	//if long(left(ls_temp,1)) >= 9 then 
	
	//--------Begin Added by Nova 03.03.2010------------------------
	//get Major version 
	ll_last_pos1 = lastpos(ls_asa_temp,'.')
	ls_asa_temp = LeftA(ls_asa_temp,ll_last_pos1 -1)
	//get Small Version 
	ll_last_pos2 = lastpos(ls_asa_temp,'.')
	ls_asa_temp = MidA(ls_asa_temp,ll_last_pos2 +1 )
	//--------End Added --------------------------------------------
	
	IF Long(ls_temp) >= 9 THEN
		//--------Begin Modified by  Nova 03.03.2010------------------------
		//ls_dbtype = 'ASA9'
		IF Long(ls_asa_temp) > 0  THEN //ROW_NUMBER function is asa 9.0.1 new features Added by  Nova 03.03.2010
			ls_dbtype = 'ASA9'
		ELSE
			ls_dbtype = 'ASA7'
		END IF
		//--------End Modified --------------------------------------------
	ELSE
		ls_dbtype = 'ASA7'
	END IF
END IF

RETURN ls_dbtype

end function

public subroutine of_replacespecchar (ref string as_string);//////////////////////////////////////////////////////////
//function : of_replacespecchar
//arguments: as_string <string> 
//describe : replace special character such as %, ;~"'[]{}/-.+=*\^&!|?()
//Andy 08/24/2007 by: Andy
n_cst_string lnvo_string

if PosA(as_string," ") > 0 then as_string  = lnvo_string.of_globalreplace( as_string, " ", "_")
if PosA(as_string,"-") > 0 then as_string  = lnvo_string.of_globalreplace( as_string, "-", "_")
if PosA(as_string,"/") > 0 then as_string  = lnvo_string.of_globalreplace( as_string, "/", "_")
if PosA(as_string,"'") > 0 then as_string  = lnvo_string.of_globalreplace( as_string, "'", "_")
if PosA(as_string,'"') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '"', "_")
if PosA(as_string,'(') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '(', "_")
if PosA(as_string,')') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, ')', "_")
if PosA(as_string,'%') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '%', "_")
if PosA(as_string,',') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, ',', "_")
if PosA(as_string,';') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, ';', "_")

if PosA(as_string,'*') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '*', "_")
if PosA(as_string,'\') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '\', "_")
if PosA(as_string,'^') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '^', "_")
if PosA(as_string,'&') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '&', "_")
if PosA(as_string,'!') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '!', "_")
if PosA(as_string,'?') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '?', "_")
if PosA(as_string,'[') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '[', "_")
if PosA(as_string,']') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, ']', "_")
if PosA(as_string,'{') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '{', "_")
if PosA(as_string,'}') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '}', "_")
if PosA(as_string,'.') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '.', "_")
if PosA(as_string,'+') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '+', "_")
if PosA(as_string,'=') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '=', "_")
if PosA(as_string,'|') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '|', "_")
if PosA(as_string,'#') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '#', "_")

if PosA(as_string,'~~') > 0 then as_string  = lnvo_string.of_globalreplace( as_string, '~~', "_")


end subroutine

public function long of_export_processdefault (n_ds ads_export_hdr, n_ds ads_export_flds, n_ds ads_export_datatemp, n_ds lds_export_data);////////////////////////////////////////////////////////////
//function : of_export_processdefault
//describe : process default value
//developer: Andy 08/27/2007
///////////////////////////////////////////////////////////
Long   ll_ColCnt,ll_i,ll_ud,ll_sub_start,ll_Col,ll_width,ll_fld_cnt,ll_Row
Long   ll_R,ll_dataCnt,ll_dif
String ls_def_val,ls_data_value,ls_strip_char,ls_field_format,ls_export_field
String ls_pad,ls_text,ls_fld_delim

if Not IsValid(ads_export_hdr) then return -1
if Not IsValid(ads_export_flds) then return -1
if Not IsValid(ads_export_dataTemp) then return -1
if Not IsValid(lds_export_data) then return -1

ll_fld_cnt = ads_export_flds.RowCount()
ads_export_flds.setfilter("export_type = 1 and use_default in (1,2,3)")
ads_export_flds.filter()
ll_ColCnt = ads_export_flds.RowCount()
//No field use defualt
if ll_ColCnt < 1 then 
	ads_export_flds.setfilter("")
	ads_export_flds.filter()
	return 1
end if

ll_dataCnt = lds_export_data.RowCount()
ls_strip_char = ads_export_hdr.getitemstring(1,"strip_char")
if isnull(ls_strip_char) or LenA(ls_strip_char) < 1 then ls_strip_char = "NONE"

FOR ll_i = 1 to ll_ColCnt
	ls_export_field = ads_export_flds.getitemstring(ll_i,"export_field_name")
	of_replacespecchar(ls_export_field)
	
	ls_text = ads_export_flds.getitemstring(ll_i,"field_value")
	ls_fld_delim = ads_export_flds.GetItemString( ll_i, "trailing_leading_characters")
	ll_width = ads_export_flds.getitemnumber(ll_i,"export_field_length")
	if is_text_delimiter = "Q" then ll_width = ll_width  + 2 //Start Code Change ----09.18.2014 #V14.2 maha - for text delimiters
	ls_field_format = ads_export_flds.getitemstring(ll_i,"export_format")
	ll_sub_start = ads_export_flds.getitemnumber(ll_i,"export_fields_substring_start")
	ll_ud = ads_export_flds.GetItemnumber( ll_i, "use_default" )
	if ll_ud = 1 or ll_ud = 3 then
		ls_def_val = ads_export_flds.GetItemString( ll_i, "default_value" )
	ELSEif ll_ud = 2 then
		ll_col = Long(ads_export_flds.GetItemString( ll_i, "default_value" ))
	else
		ls_def_val = ""
	end if
	
	ll_R = 0
	DO WHILE (1=1)
		ll_R = lds_export_data.find("IsNull("+ls_export_field+") OR trim(" + ls_export_field + ") = ''",ll_R,ll_dataCnt)
		if ll_R < 1 then exit		  
		//modify 10/12/2007 by: Andy
		//ls_data_value = ""
		setnull(ls_data_value)
		/*commit 10/12/2007 by:Andy 
		if ls_strip_char <> "NONE" then
			ls_data_value = of_strip_char( ls_strip_char ,ls_data_value, "")
		end if
		
		if ll_sub_start > 1 then ls_data_value = mid(ls_data_value,ll_sub_start,ll_width)
		
		ls_data_value = mid(ls_data_value,1,ll_width) //shrink the length to size 
		if ls_field_format = "Leading Padding" or ls_field_format = "Trailing Padding" then 
			if ll_width - len(ls_data_value) > 0 then
				ll_dif = ll_width - len(ls_data_value)
				ls_pad = "" //reset
				ls_pad = Fill ( ls_fld_delim, ll_dif )
				if ls_field_format = "Leading Padding" then
					ls_data_value = ls_pad + ls_data_value 
				else
					ls_data_value = ls_data_value + ls_pad
				end if
			end if
		elseif ls_field_format = "use text" then //allows a set value if data is found
			if len(ls_data_value) > 0 then
				ls_data_value = ls_text
			end if
		end if*/	

		if ll_ud = 3 then
			ls_data_value = ls_def_val + ls_data_value
		end if
		
		if isnull(ls_data_value) then ls_data_value = ""
		if ls_data_value = "" then
			if ll_ud = 1 then
				ls_data_value = ls_def_val
			elseif ll_ud = 2 then //if set to column get the value out of that column
				if ll_col < 1 or ll_col > ll_fld_cnt then //setting trap
					//---------Begin Added by (Appeon)Toney 06.19.2013 for V141 ISG-CLX--------
					gnv_debug.of_output(true, 'Alarm  Export: ' + "You are using a column default for column " + ls_export_field + " , but your default value is not a valid column number.~rThe default column number must be less than this column.")//added by gavins 20120912					
					//---------End Added ------------------------------------------------------------------					
					//messagebox("Invalid setting","You are using a column default for column " + ls_export_field + " , but your default value is not a valid column number.~rThe default column number must be less than this column.")
					//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
 					inv_message.of_MessageBox("Invalid setting","You are using a column default for column " + ls_export_field + " , but your default value is not a valid column number.~rThe default column number must be less than this column.",true)	
					ads_export_flds.setfilter("")
					ads_export_flds.filter()
					return -1
				end if
				ls_data_value = lds_export_data.getitemstring(ll_R,ll_col)
			end if
		end if
		
		if lower(lds_export_data.describe(ls_export_field + ".name")) = lower(ls_export_field) then
			lds_export_data.setitem(ll_R,ls_export_field,ls_data_value)
			ads_export_dataTemp.setitem(ll_R,ls_export_field,ls_data_value)
		end if

		ll_R ++
		if ll_R > ll_dataCnt then exit
	loop 	
next

ads_export_flds.setfilter("")
ads_export_flds.filter()

return 1
end function

public subroutine of_data_format (string as_format, string as_type, ref string as_data);////////////////////////////////////////////////////////
//Function : of_data_format
//arguments: as_format <string>   data format
//           as_type <string>     data type
//           as_data <ref string> data 
//developer: Andy 08/28/2007 
//Re-write some details to increase speed in Web Version, for Case 67116 - Export Erring after an hour, SaaS v15.1 10132016
///////////////////////////////////////////////////////

Long     ll_dec = 0 ,ll_pos
String   ls_Temp
string ls_value //maha 08.23.2012
String ls_format_low
String as_type_up
datetime ldt_value

if ISNULL(as_type) OR TRIM(as_type) = '' THEN RETURN
if ISNULL(as_data) OR TRIM(as_data) = '' THEN RETURN

ls_format_low = lower(as_format)
as_type = as_type

If as_type = 'D' then 
	if ISNULL(as_format) OR ls_format_low = 'none' then as_format = "yyyy-mm-dd hh:mm"
ElseIf as_type = 'T' THEN 
	if ISNULL(as_format) OR ls_format_low = 'none' then as_format = "hh:mm"
END IF

if ISNULL(as_format) OR ls_format_low = 'none' or ls_format_low = 'leading padding' OR ls_format_low = 'trailing padding' OR &
	ls_format_low = 'use text'  THEN RETURN

CHOOSE CASE as_type
	CASE 'N'
		if ls_format_low = 'numbers' then return //alfee 04.02.2010
		if as_format = "(xxx)xxx-xxxx" then as_format = "(###)###-####"
		if long(as_data) = 0 then setnull(as_data)

		If isnumber(as_data) Then
			as_data = string(double(as_data),as_format)
		end if	
	CASE 'D','T'
		if ls_format_low = 'numbers' then return //alfee 04.02.2010		
		ldt_value = datetime(date(LeftA(as_data,10)),time(RightA(as_data,5)))
		as_data   = string(ldt_value,as_format)
	CASE 'C','S'
		if as_format = "(xxx)xxx-xxxx" then as_format = "(@@@)@@@-@@@@"
		if as_format = "###-##-1234" then  //maha 11.19.2012 for SSN
			as_data = "###-##-" + right(as_data,4)
			
		//is number
		elseif isnumber(as_data) and (PosA(as_format,"#") > 0 or PosA(as_format,"0") > 0) then
			//<add> 08/31/2007 by: Andy
			if long(as_data) = 0 then setnull(as_data)
			
			if isnumber(as_data) then 
				as_data = string(double(as_data),as_format)
			end if
		//is datetime
		elseif LenA(as_data) = 16 and  isdate(LeftA(as_data,10)) and istime(RightA(as_data,5)) and &
			(PosA(ls_format_low,'y') > 0 or PosA(ls_format_low,'m') > 0 or PosA(ls_format_low,'d') > 0 or PosA(ls_format_low,'h') > 0) then
			ldt_value = datetime(date(LeftA(as_data,10)),time(RightA(as_data,5)))
			as_data   = string(ldt_value,as_format)
		//is date	
		elseif isdate(as_data) and &
			(PosA(ls_format_low,'y') > 0 or PosA(ls_format_low,'m') > 0 or PosA(ls_format_low,'d') > 0 or PosA(ls_format_low,'h') > 0) then
			as_data   = string(datetime(date(as_data)),as_format)
		//is char
		elseif PosA(as_format,"@") > 0 then	//modify 08/31/2007 by: Andy
		//----Begin Modified by Alfee 04.02.2010--------------	
			//as_data = string(as_data, as_format)
			as_data = inv_string.of_format_phonenumber(as_data) 
		elseif ls_format_low = 'numbers' then //strip to numbers 
			as_data = of_strip_char("", as_data, "@NUM@")
		//----End Modified -----------------------------------
		end if		
	CASE ELSE 
		//DO NOTHING	
END CHOOSE

//Comment by Appeon long.zhang 11.07.2016
//Long     ll_dec = 0 ,ll_pos
//String   ls_Temp
//string ls_value //maha 08.23.2012
//datetime ldt_value
//
//if ISNULL(as_type) OR TRIM(as_type) = '' THEN RETURN
//if ISNULL(as_data) OR TRIM(as_data) = '' THEN RETURN
//if upper(as_type) = 'D' then 
//	if ISNULL(as_format) OR UPPER(as_format) = 'NONE' then as_format = "yyyy-mm-dd hh:mm"
//end if
//IF upper(as_type) = 'T' THEN 
//	if ISNULL(as_format) OR UPPER(as_format) = 'NONE' then as_format = "hh:mm"
//END IF
//if ISNULL(as_format) OR UPPER(as_format) = 'NONE' THEN RETURN
////Add 10/12/2007 by: Andy
//if lower(as_format) = 'leading padding' OR lower(as_format) = 'trailing padding' OR &
//	lower(as_format) = 'use text' then RETURN //alfee 04.02.2010
//	//lower(as_format) = 'use text' OR lower(as_format) = 'numbers' then RETURN
////end of add
//
//CHOOSE CASE upper(as_type)
//		
//	CASE 'N'
//		if lower(as_format) = 'numbers' then return //alfee 04.02.2010
//		if as_format = "(xxx)xxx-xxxx" then as_format = "(###)###-####"
//		if long(as_data) = 0 then setnull(as_data)
//		/*
//		ll_pos = pos(as_format,'.') 
//		if ll_pos > 0 then
//			ls_Temp = mid(as_format,ll_pos + 1)
//			ll_dec = len(ls_Temp)
//			if isnull(ll_dec) then ll_dec = 0 
//		end if
//		*/
//		If isnumber(as_data) Then
//			//as_data = string(Round( double(as_data), ll_dec ),as_format)
//			as_data = string(double(as_data),as_format)
//		end if
//		
//	CASE 'D','T'
//		if lower(as_format) = 'numbers' then return //alfee 04.02.2010		
//		ldt_value = datetime(date(LeftA(as_data,10)),time(RightA(as_data,5)))
//		as_data   = string(ldt_value,as_format)
//		
//	CASE 'C','S'
//		
//		if as_format = "(xxx)xxx-xxxx" then as_format = "(@@@)@@@-@@@@"
//		if as_format = "###-##-1234" then  //maha 11.19.2012 for SSN
//			as_data = "###-##-" + right(as_data,4)
//			
//		//is number
//		elseif isnumber(as_data) and (PosA(as_format,"#") > 0 or PosA(as_format,"0") > 0) then
//			//<add> 08/31/2007 by: Andy
//			if long(as_data) = 0 then setnull(as_data)
//			
//			if isnumber(as_data) then 
//				as_data = string(double(as_data),as_format)
//			end if
//		//is datetime
//		elseif LenA(as_data) = 16 and  isdate(LeftA(as_data,10)) and istime(RightA(as_data,5)) and &
//			(PosA(lower(as_format),'y') > 0 or PosA(lower(as_format),'m') > 0 or PosA(lower(as_format),'d') > 0 or PosA(lower(as_format),'h') > 0) then
//			ldt_value = datetime(date(LeftA(as_data,10)),time(RightA(as_data,5)))
//			as_data   = string(ldt_value,as_format)
//		//is date	
//		elseif isdate(as_data) and &
//			(PosA(lower(as_format),'y') > 0 or PosA(lower(as_format),'m') > 0 or PosA(lower(as_format),'d') > 0 or PosA(lower(as_format),'h') > 0) then
//			as_data   = string(datetime(date(as_data)),as_format)
//		//is char
//		elseif PosA(as_format,"@") > 0 then	//modify 08/31/2007 by: Andy
//		//----Begin Modified by Alfee 04.02.2010--------------	
//			//as_data = string(as_data, as_format)
//			as_data = inv_string.of_format_phonenumber(as_data) 
//		elseif lower(as_format) = 'numbers' then //strip to numbers 
//			as_data = of_strip_char("", as_data, "@NUM@")
//		//----End Modified -----------------------------------
//		
//		
//		end if
//		
//	CASE ELSE 
//		//DO NOTHING
//		
//END CHOOSE
end subroutine

public function integer of_multi_row (n_ds ads_export, string as_table, integer ai_table, integer ai_col_num[], n_ds ads_exp_fields, long al_prac_ids[], string as_where);//maha created 121505 to create multiple data rows for each practitoner

w_export_progress.st_progress.text = "Adding multiple records"
w_export_progress.r_bar.Width = 300

long r
long rc
long org_cnt
long d
long dc
long ll_prac
long p
long pc
long ll_find
long alu
long clu
long row_cnt
integer a
integer ac
integer w
integer li_bar_ticks
integer li_sub_start
integer li_len
integer p1 //Start Code Change ---- 10.01.2007 #V7 maha
integer res
long ll_row_loc[]
long ll_dummy[]
datetime ldt_data
//string ls_datatype
string ls_syntax
string ls_fields
string ls_table
string ls_table_org  //maha 09.02.2014
string ls_value
string ls_lu_type
string ls_lu_field
string ls_datatype[]
string ls_sny_retrieve
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_type[]
string ls_where  //Start Code Change ---- 10.01.2007 #V7 maha
string ls_fname  //Start Code Change ---- 10.01.2007 #V7 maha
string ls_find  //maha 09.02.2014
string ls_field_value // 11.03.2014
datastore lds_addr_lu //n_ds->datastore - alfee 04.15.2010
datastore lds_code_lu //n_ds->datastore - alfee 04.15.2010
n_ds lds_getdata
n_ds lds_priv_clinical_area//Added by  Nova 10.30.2009
n_ds lds_priv_core			//Added by  Nova 10.30.2009
n_ds lds_priv_core_procd	//Added by  Nova 10.30.2009
string ls_db_field_name    //Added by  Nova 10.30.2009
string ls_db_table_name    //Added by  Nova 10.30.2009
long dlu							//Added by  Nova 10.30.2009
long slu							//Added by  Nova 10.30.2009
long plu							//Added by  Nova 10.30.2009
n_import_ds   lds_field_type  //add by stephen 01.13.2012
string             ls_field_type
boolean  lb_address_link      //add by stephen 03.25.2013
//---------Begin Added by (Appeon)Stephen 08.26.2014 for Bug 4157 - Export multirows and billing addresses--------
integer   li_colold, li_billing
integer   li_use_link, li_ret, li_facility_id, li_faci_filter
long       ll_table_id_arr[] = {2,9,16,20,29,32,43,44,45,46,47,48,49,50,51,52,53,61,62,65,70,71}  
long       ll_billing_id, ll_rec_id
string     ls_field_format, ls_select_field, ls_dbtype
string     ls_def_val
string     ls_query_filter
boolean  lb_bill, lb_link
boolean  lb_faci, lb_faci_filter
//---------End Added ------------------------------------------------------

org_cnt = ads_export.rowcount()

li_bar_ticks = 1000 / org_cnt
if org_cnt = 0 then //redundant trap
	//messagebox("No Data","Ending of_multi_row")
	inv_message.of_messagebox("No Data","Ending of_multi_row", TRUE) //scheduler - alfee 03.05.2010
	return -1
end if

//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
gnv_data.of_retrieveIfNecessary("address_lookup", FALSE)
gnv_data.of_retrieveIfNecessary("code_lookup", FALSE)
//------------------------------------------------------------------------------------------------------

//--Begin Modified by alfee 04.15.2010 ---
lds_addr_lu = gnv_data.ids_address_lookup
lds_code_lu = gnv_data.ids_code_lookup

//lds_addr_lu = create n_ds
//lds_code_lu = create n_ds
//lds_addr_lu.dataobject = "d_dddw_address_lookup_all"
//lds_code_lu.dataobject = "d_dddw_code_lookup_all"
//lds_addr_lu.settransobject(sqlca)
//lds_code_lu.settransobject(sqlca)
//--End Modified ------------------------

//--------Begin Added by Nova 10.30.2009------------------------
lds_priv_clinical_area = create n_ds
lds_priv_core = create n_ds
lds_priv_core_procd = create n_ds

lds_priv_clinical_area.dataobject = "d_dddw_priv_clinical_area"
lds_priv_core.dataobject="d_dddw_priv_core"
lds_priv_core_procd.dataobject="d_dddw_priv_core_procd"

lds_priv_clinical_area.settransobject(sqlca)
lds_priv_core.settransobject(sqlca)
lds_priv_core_procd.settransobject(sqlca)
//--------End Added --------------------------------------------

//create dynamic ds to retrieve each practitioners' data for the extra table
res = ads_exp_fields.setfilter("intcred_table = " + string(ai_table) )
//if res < 0 then messagebox("","filter failed")
if res < 0 then inv_message.of_messagebox("","filter failed", TRUE) //scheduler - alfee 03.05.2010
ads_exp_fields.filter()
ac = ads_exp_fields.rowcount()

if ac = 0 then return 0	//Fix a bug By Jervis 07.05.2007

//ls_table = ads_exp_fields.getitemstring(1,"db_table_name")  //Commented by (Appeon)Harry 08.12.2014
ls_table = ads_exp_fields.getitemstring(1,"db_table_name_intellicred")  //(Appeon)Harry 08.12.2014 - BugS072401
ls_table_org = ls_table  //Start Code Change ----09.02.2014 #V14.2 maha

if ac <> upperbound(ai_col_num[]) then
	//messagebox("Error","Count mismatch.")
	inv_message.of_messagebox("Error","Count mismatch.", TRUE) //scheduler - alfee 03.05.2010	
	return 0
end if

for a = 1 to ac
	//ls_fields = ls_fields + ads_exp_fields.getitemstring(a,"db_field_name") + ","   //delete by stephen 03.25.2013 --add table_name
	//ls_fields = ls_fields + ls_table + "." + ads_exp_fields.getitemstring(a,"db_field_name") + ","   //add by stephen 03.25.2013 --add table_name 
	ls_fields = ls_fields + ls_table + "." + ads_exp_fields.getitemstring(a,"db_field_name_intellicred") + ","  //(Appeon)Harry 08.12.2014 - BugS072401
	ls_type[a] = ads_exp_fields.getitemstring(a,"db_field_type")
	//messagebox("dtype",ls_fields + "  " + ls_type[a])
next

//---------Begin Added by (Appeon)Stephen 12.01.2014 for add facility filter for multi-record format--------
lb_faci = false
for a = 1 to upperbound(ll_table_id_arr)
	if ai_table = ll_table_id_arr[a] then
		lb_faci = true
		exit
	end if
next
//---------End Added ------------------------------------------------------

//---------Begin Added by (Appeon)Stephen 11.28.2014 for Allegheny - Help with an export--------
lb_link = true
choose case ai_table
	case 53
		ls_fields = ls_fields + ls_table + "." + "address_id, " + ls_table + ".facility_id,"
	case 61
		ls_fields = ls_fields + ls_table + "." + "hosp_affil_id, " + ls_table + ".facility_id,"
	case 62
		ls_fields = ls_fields + ls_table + "." + "specialty_id," + ls_table +".facility_id,"
	case else
		ls_fields = ls_fields + ls_table + "." + "rec_id,"
		lb_link = false
end choose
//---------End Added ------------------------------------------------------
ls_fields = MidA(ls_fields, 1,LenA(ls_fields) - 1)  //drop last comma

lds_getdata = CREATE n_ds
//for each row of practitioner data in the table copy the export row for that practitoner to the end of the export

pc = upperbound(al_prac_ids[])

row_cnt = 1
lds_field_type = create n_import_ds  //add by stephen 01.13.2012 DataWindow column type does not match GetItem type 

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 03.25.2013
//$<reason> V12.3 Modify the Multi-record functionality
lb_address_link = false
if ai_table = 20 then
	if pos(lower(as_where),"pd_address_link.") > 0 then
		lb_address_link = true
		ls_table = ls_table + ", pd_address_link"
	end if
end if
//------------------- APPEON END -------------------

lb_bill = false
for r = 1 to pc //for the list of passed pracids
	//messagebox("",ads_export.rowcount())
	ll_row_loc = ll_dummy
	ll_prac = al_prac_ids[r]
	//ads_export.getitemnumber(r,ads_export.describe("#1.name"))
	ll_row_loc[1] = row_cnt

	//Start Code Change ---- 10.01.2007 #V7 maha
	//If ib_nyp_fte = true then //added for NYP FTE report
	//	ls_syntax = "SELECT * from " + ls_table //assumed to be their custom screen grad staff
//	else

	//---------Begin Modified by (Appeon)Stephen 10.09.2014 for Oregon export error--------
	//if ai_table = 20 then  ls_fields = ls_table_org + ".billing_address_id," + ls_fields  //Start Code Change ----09.02.2014 #V14.2 maha
	if ai_table = 20 and lb_bill = false then  
		lb_bill = true
		ls_fields = ls_fields + ", " + ls_table_org + ".billing_address_id "  	
	end if
	//---------End Modfiied ------------------------------------------------------

	ls_syntax = "SELECT " + ls_fields + " from " + ls_table
		
//End Code Change ----09.02.2014
//	end if
	ls_where = as_where
	//Start Code Change ----05.27.2009 #V92 maha
	if isnull(ls_where) then ls_where = ""
	//traps for AND and WHERE
	p1 = PosA(upper(ls_where) , "AND" ,1)
	if p1  < 4 and p1 > 0 then //strip and if it exists
		ls_where = MidA(as_where, p1 + 3)
	end if
	p1 = PosA(upper(ls_where) , "WHERE" ,1)
	if p1  < 4 and p1 > 0  then //strip and if it exists
		ls_where = MidA(as_where, p1 + 5)
	end if
	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 03.25.2013
	//$<reason> V12.3 Modify the Multi-record functionality
	/*
	if LenA(ls_where) > 0 then
		ls_where = " where prac_id = " + string(ll_prac)  + " and " + ls_where
	else
		ls_where = " where prac_id = " + string(ll_prac)  + " " + ls_where
	end if
	*/
	if lb_address_link then
		if LenA(ls_where) > 0 then
			ls_where = " where pd_address.prac_id = " + string(ll_prac)  + " and " + ls_where +" and pd_address.rec_id = pd_address_link.address_id "
		else
			ls_where = " where pd_address.prac_id = " + string(ll_prac)  + " " + ls_where+" and pd_address.rec_id = pd_address_link.address_id "
		end if
		
		ls_where = ls_where + " group by " + ls_fields
	else
		if LenA(ls_where) > 0 then
			ls_where = " where " + ls_table_org + ".prac_id = " + string(ll_prac)  + " and " + ls_where
		else
			ls_where = " where " + ls_table_org + ".prac_id = " + string(ll_prac)  + " " + ls_where
		end if
	end if
	//------------------- APPEON END -------------------
	//End Code Change---05.27.2009
	
	ls_syntax = ls_syntax + ls_where 
	//need to write traps if the correct table is not selected back in the main function
	If ib_nyp_fte = true then //added for NYP FTE report
		//ls_syntax = "SELECT " + ls_fields + " from " + ls_table + " where prac_id = " + string(ll_prac)  + " order by end_date ASC; "
		ls_syntax +=  " order by end_date ASC"
	end if
	
	ls_syntax += ";"
	//End Code Change---10.01.2007
	//messagebox("lds getdata sql", ls_syntax)
	//create ds
		ls_presentation_str = "style(type=grid)"		

		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_syntax, ls_presentation_str, ERRORS)
		IF LenA(ERRORS) > 0 THEN
			//MessageBox("Caution on export field " ,  "SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_syntax)
			inv_message.of_messagebox("Caution on export field ", "SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_syntax, TRUE) //scheduler - alfee 03.05.2010	
			close(w_export_progress)
			RETURN -1
		END IF
		
		w = lds_getdata.Create( ls_dwsyntax_str, ERRORS)
		if w < 1 then
			//messagebox("Error creating table for multi row function",errors)
			inv_message.of_messagebox("Error creating table for multi row function",errors, TRUE)//scheduler - alfee 03.05.2010
			return 0
		end if
		lds_getdata.SetTransObject( SQLCA )
		
		lds_field_type.create( ls_dwsyntax_str, ERRORS)
		lds_field_type.settransobject(sqlca)  //add by stephen 01.13.2012 DataWindow column type does not match GetItem type 
		
		//Start Code Change ---- 10.01.2007 #V7 maha
	//dc = lds_getdata.retrieve()
	lds_getdata.retrieve()
//for each field in the m table that exists in the export get the data from the appropriate record and modify the the new export rows	
	If ib_nyp_fte = true then //added for NYP FTE report  - record filter and modification
		of_nyp_fte_rows(lds_getdata)
	end if
	dc = lds_getdata.rowcount()
	if dc > 1 then
		//copy and update as needed
		for d = 2 to dc  //Start Code Change ----05.28.2009 #V92 maha - changed from 1 to 2 ; was duplicating the first row.
			ads_export.rowscopy(row_cnt,row_cnt,primary!,ads_export,row_cnt + 1,primary!)
			//ads_export.rowscopy(row_cnt,row_cnt,primary!,ads_export,100,primary!)
			ids_export_dataTemp.rowscopy(row_cnt,row_cnt,primary!,ids_export_dataTemp,row_cnt + 1,primary!) //(Appeon)Stephen 09.12.2014 - bug Id 4216 Export multi-row and calculated fields
			row_cnt++
			//rc = ads_export.rowcount()
			ll_row_loc[d] = row_cnt
		next
		for d = 1 to dc
			for a = 1 to upperbound(ai_col_num[])
				ls_fname = ads_exp_fields.getitemstring(a,"export_field_name")
				//---------Begin Added by (Appeon)Stephen 11.27.2014 for Allegheny - Help with an export--------
				ls_def_val = ads_exp_fields.getitemstring(a,"default_value")
				ls_query_filter = ads_exp_fields.getitemstring(a,"filter_query")
				li_use_link = ads_exp_fields.getitemnumber(a,"use_link") 	
				if lb_faci = true then li_faci_filter = ads_exp_fields.getitemnumber(a,"facility_id") 	
				//---------End Added ------------------------------------------------------
				
				ls_lu_field = ads_exp_fields.getitemstring(a,"lu_field_name")
				ls_lu_type = ads_exp_fields.getitemstring(a,"db_lookup_type") //maha 010305
				//--------Begin Added by Nova 10.30.2009------------------------
				//---------Begin Modified by (Appeon)Harry 08.12.2014 for BugS072401--------
				//ls_db_field_name=ads_exp_fields.getitemstring(a,"db_field_name")
				//ls_db_table_name=ads_exp_fields.getitemstring(a,"db_table_name")
				ls_db_field_name=ads_exp_fields.getitemstring(a,"db_field_name_intellicred")
				ls_db_table_name=ads_exp_fields.getitemstring(a,"db_table_name_intellicred")
				//---------End Modfiied ------------------------------------------------------
				//--------End Added --------------------------------------------
				
				//---------Begin Added by (Appeon)Stephen 08.26.2014 for Bug 4157 - Export multirows and billing addresses--------

//				if ai_col_num[a] <= upperbound(ii_billingList) then
//					li_billing = ii_billingList[ai_col_num[a]]   //is it a billing address field
//					ls_field_format = is_formatList[ai_col_num[a]]
//					ls_select_field = is_selectfieldlist[ai_col_num[a]]
//					ls_dbtype = is_typelist[ai_col_num[a]] 
						//---------Begin Added by (Appeon)Stephen 09.02.2014 for Bug 4157 - Export multirows and billing addresses--------
//						if ll_prac_row > 0 then
//							ls_value = ids_export_retrieve.GetItemstring(ll_prac_row, "field_value" )
//Start Code Change ----09.02.2014 #V14.2 maha							
							//ll_billing_id   = ids_export_retrieve.GetItemNumber(ll_prac_row, "billing_address_id" )
							
//							ll_prac_row_first = ll_prac_row + li_cnt -1
//							if ll_prac_row_first > ids_export_retrieve.rowcount() then ll_prac_row_first = ids_export_retrieve.rowcount()
//							for ll_i = ll_prac_row to ll_prac_row_first
//								if ls_value <> ids_export_retrieve.GetItemstring(ll_i, "field_value" ) or ll_billing_id <> ids_export_retrieve.GetItemNumber(ll_i, "billing_address_id" ) then									
//									exit
//								end if
//							next
//							if  ll_i >= ll_prac_row_first then
//								ll_prac_row = ll_prac_row_first
//							else
//								ll_prac_row = ll_i	
//							end if							
//						end if
//						//---------End Added ------------------------------------------------------

					//---------Begin Added by (Appeon)Stephen 09.04.2014 for Export multirows and billing addresses--------
					li_billing = ads_exp_fields.GetItemNumber(a,"billing_link")   //is it a billing address field
					ls_field_format = ads_exp_fields.GetItemString(a,"export_format")
					ls_field_value = ads_exp_fields.GetItemString(a,"field_value")  //Start Code Change ----11.03.2014 #V14.2 maha
					
					ls_select_field = ls_db_field_name
					ls_dbtype = trim(ads_exp_fields.GetItemString(a,"db_field_type"))
					//---------End Added ------------------------------------------------------

					//---------Begin Added by (Appeon)Stephen 12.01.2014 for add facility filter for multi-record format--------
					if lb_faci = true and not(isnull(li_faci_filter) or li_faci_filter = 0) then
						lb_faci_filter = true
					else
						lb_faci_filter = false
					end if
					//---------End Added ------------------------------------------------------

					IF li_billing = 1 and PosA(ls_table, "pd_address",1) > 0 then //Start Code Change ----03.14.2013 #V12 maha - trap for billing link on non- address table
						if lb_link = false then
							ll_billing_id = lds_getdata.getitemnumber(d, ac+2 )
						else
							ll_billing_id = lds_getdata.getitemnumber(d, ac+3 )
						end if
						if isnull(ll_billing_id) then  //Start Code Change ----09.02.2014 #V14.2 maha - trap for no billing id
							ls_value = ""
						else
							//---------Begin Added by (Appeon)Stephen 09.03.2014--------
							/* //Commented by (Appeon)Stephen 09.05.2014 - 
							if ls_lu_type = 'A' OR ls_lu_type = 'C' then
								ls_field_type = lds_field_type.of_getcoltype(lds_getdata.describe("#"+string(a)+".name"))
								choose case ls_field_type 
									case "C","L"   
										ls_value = lds_getdata.getitemstring(d,a)
									case "I","N"
										ls_value = string(lds_getdata.getitemnumber(d,a))						
									case "D","T" 
										ls_value = of_date_format(ads_exp_fields.getitemstring(a,"export_format"),lds_getdata.getitemdatetime(d,a))
								end choose	
							else*/
							
							ls_value = of_get_billing_new(ll_billing_id, ls_select_field, ls_dbtype,ls_field_format) //Start Code Change ----08.29.2014 #V14.2 maha							
							//---------End Added ------------------------------------------------------
							//---------Begin Added by (Appeon)Stephen 11.27.2014 for Allegheny - Help with an export--------							
							if  lb_faci_filter = true or not(isnull(ls_query_filter) or ls_query_filter = "") then
								ll_rec_id = lds_getdata.getitemnumber(d,ac+1)
								if lb_link = true then
									li_facility_id = lds_getdata.getitemnumber(d,ac+2)
								end if
								
								li_ret = of_multi_query_filter('Y', ls_table_org, li_use_link, ls_syntax, ls_query_filter, ls_db_field_name, ls_value, ll_rec_id, ai_table, li_facility_id, li_faci_filter)
								if li_ret = 0 then setnull(ls_value)
							end if		
							//---------End Added ------------------------------------------------------
				
							choose case ls_lu_type
								case "A"
									ls_value =  gnv_data.of_getitem( "address_lookup", ls_lu_field, "lookup_code = " + ls_value)
								case "C"
									ls_value = gnv_data.of_getitem( "code_lookup", ls_lu_field, "lookup_code = " + ls_value)
								end choose
						end if
//End Code Change ----09.02.2014							
						if isnull(ls_value) then ls_value = ""
						if not isvalid(w_export_progress) then return -1 
						
						//---------Begin Added by (Appeon)Stephen 11.27.2014 for Allegheny - Help with an export--------
						if ls_field_format = "use text"  then
							if  (isnull(ls_value) or ls_value = '') then
								ls_value = ls_def_val
							else
								ls_value = ls_field_value
							end if
						end if
						//---------End Added ------------------------------------------------------
						//if is_text_delimiter = "Q" then ls_value = '"' + ls_value + '"'   //Start Code Change ----09.18.2014 #V14.2 maha - text delimiters
						
						ads_export.setitem(ll_row_loc[d], ai_col_num[a], ls_value )
						ids_export_dataTemp.setitem(ll_row_loc[d], ai_col_num[a], ls_value ) //(Appeon)Stephen 09.12.2014 - bug Id 4216 Export multi-row and calculated fields
						continue
					END IF
				//---------End Added ------------------------------------------------------
				
				ls_field_type = lds_field_type.of_getcoltype(lds_getdata.describe("#"+string(a)+".name"))
				choose case ls_field_type /*ads_exp_fields.getitemstring(a,"db_field_type")*/ // modify by stephen 01.13.2012 -DataWindow column type does not match GetItem type 
					case "C","L"   //char, long varchar, Text
						ls_value = lds_getdata.getitemstring(d,a)
					case "I","N"
						ls_value = string(lds_getdata.getitemnumber(d,a))						
					case "D","T" //date ,timestamp
						//debugbreak()
						ls_value = of_date_format(ads_exp_fields.getitemstring(a,"export_format"),lds_getdata.getitemdatetime(d,a))
				end choose
				
				//---------Begin Added by (Appeon)Stephen 11.27.2014 for Allegheny - Help with an export--------
				if lb_faci_filter = true or not(isnull(ls_query_filter) or ls_query_filter = "") then
					ll_rec_id = lds_getdata.getitemnumber(d,ac+1)
					if lb_link = true then
						li_facility_id = lds_getdata.getitemnumber(d,ac+2)
					end if
					li_ret = of_multi_query_filter('N', ls_table_org, li_use_link, ls_syntax, ls_query_filter, ls_db_field_name, ls_value, ll_rec_id, ai_table, li_facility_id, li_faci_filter)
					if li_ret = 0 then setnull(ls_value)
				end if		
				//---------End Added ------------------------------------------------------
				
				//--------Begin Added by Nova 10.30.2009------------------------
				 if ls_db_field_name='active_status' and ls_db_table_name="pd_priv_list"  then
					choose case ls_value
						case '1'
							ls_value='Active'
						case '0'
							ls_value='History'
					end choose		
				 end if
				//--------End Added --------------------------------------------
		
				choose case ls_lu_type
					case "A"
						//--Begin Modified by alfee 04.15.2010 ---
						if lds_addr_lu.rowcount() < 1 then gnv_data.of_retrieve("address_lookup")
						alu = lds_addr_lu.rowcount()
						//if alu < 1 then alu = lds_addr_lu.retrieve()
						//--End Modified --------------------------
						ll_find = lds_addr_lu.find("lookup_code = " + ls_value,1,alu)
						if ll_find > 0 then 
							//--Begin Modified by alfee 05.07.2010 ---
							//choose case ls_lu_field
							//		case "lookup_code","zip"
							choose case lower(ls_lu_field)
									//--------Begin Modified by  Nova 05.31.2010------------------------
									//case "lookup_code", "zip", "custom_1", "custom_2"
									case "lookup_code","custom_1", "custom_2"
									//--------End Modified --------------------------------------------
							//--End Modified -------------------------		
									ls_value = string(lds_addr_lu.getitemnumber(ll_find,ads_exp_fields.getitemstring(a,"lu_field_name")))
								case else
									ls_value = lds_addr_lu.getitemstring(ll_find,ads_exp_fields.getitemstring(a,"lu_field_name"))
							end choose
						else 
							//messagebox("","not found")
						end if							
						
					case "C"
						//--Begin Modified by alfee 04.15.2010 ---
						//if clu < 1 then clu = lds_code_lu.retrieve()
						clu = lds_code_lu.rowcount()
						//--End Modified --------------------------							
						ll_find = lds_code_lu.find("lookup_code = " + ls_value,1,clu)
						if ll_find > 0 then 
							//choose case ls_lu_field
							choose case lower(ls_lu_field) //alfee 05.07.2010									
								case "lookup_code"
									ls_value = string(lds_code_lu.getitemnumber(ll_find,ads_exp_fields.getitemstring(a,"lu_field_name")))
								case else
									ls_value = lds_code_lu.getitemstring(ll_find,ads_exp_fields.getitemstring(a,"lu_field_name"))
							end choose
						end if
					 //--------Begin Added by Nova 10.30.2009------------------------
					 case "D"	//dddw lookup - modified by alfee 01.26.2010
						if lower(ls_db_table_name) = "pd_priv_list" then
							if lower(ls_db_field_name) ='clinical_area_id' then 					
								if Dlu < 1 then dlu = lds_priv_clinical_area.retrieve()
								ll_find = lds_priv_clinical_area.find("clinical_area_id = " + ls_value,1,dlu)
								if ll_find > 0 then 
									choose case ls_lu_field
										case "Dept Code"
											ls_value =lds_priv_clinical_area.getitemstring(ll_find,"clinical_area_code")
										case else
											ls_value = lds_priv_clinical_area.getitemstring(ll_find,"clinical_area_description")
									end choose
								end if 
							elseif lower(ls_db_field_name)='priv_core_id' then 
								if slu < 1 then slu = lds_priv_core.retrieve()
								ll_find = lds_priv_core.find("priv_core_id = " + ls_value,1,slu)
								if ll_find > 0 then 
									choose case ls_lu_field
										case "Section"
											ls_value =lds_priv_core.getitemstring(ll_find,"priv_core_description")
									end choose
								end if 
							elseif lower(ls_db_field_name)='procd_id' then 								
								if plu < 1 then plu = lds_priv_core_procd.retrieve()
								ll_find = lds_priv_core_procd.find("procd_id = " + ls_value,1,plu)
								if ll_find > 0 then 
									choose case ls_lu_field
										case "Procedure Code"
											ls_value =lds_priv_core_procd.getitemstring(ll_find,"procd_name")
										case else
											ls_value = lds_priv_core_procd.getitemstring(ll_find,"core_procd_description")
									end choose
								end if 	
							end if
						end if
					 //--------End Added --------------------------------------------	
				end choose	
				
				of_data_format(ls_field_format,ls_field_type,ls_value)  //Start Code Change ----09.18.2014 #V14.2 maha
				
				//---------Begin Modified by (Appeon)Stephen 11.27.2014 for Allegheny - Help with an export--------
				/*
				 //Start Code Change ----11.03.2014 #V14.2 maha
				if ls_field_format = "use text" then
					ls_value = ls_field_value
				end if
				 //End Code Change ----11.03.2014 
				 */
				 if ls_field_format = "use text"  then
					if  (isnull(ls_value) or ls_value = '') then
						ls_value = ls_def_val
					else
						ls_value = ls_field_value
					end if
				end if
				 //---------End Added ------------------------------------------------------

				
				li_len = ads_exp_fields.getitemnumber(a,"export_field_length")
				li_sub_start = ads_exp_fields.getitemnumber(a,"export_fields_substring_start")
				if li_sub_start < 2 or isnull(li_sub_start) then li_sub_start = 1 //maha 010405
				ls_value = MidA(ls_value,li_sub_start,li_len)
				
				if isnull(ls_value) then ls_value = ""   //Start Code Change ----11.05.2014 #V14.2 maha
				//if is_text_delimiter = "Q" then ls_value = '"' + ls_value + '"'   //Start Code Change ----09.18.2014 #V14.2 maha - text delimiters
				
				ads_export.setitem(ll_row_loc[d], ai_col_num[a], ls_value )	
				ids_export_dataTemp.setitem(ll_row_loc[d], ai_col_num[a], ls_value ) //(Appeon)Stephen 09.12.2014 - bug Id 4216 Export multi-row and calculated fields
			next
		next
	end if
	row_cnt++
	w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + li_bar_ticks
next
//resort the data
//ads_export.setsort("prac_id")
//ads_export.sort()
//messagebox("multi row",ads_export.rowcount())

//clean up
ads_exp_fields.setfilter("" )
ads_exp_fields.filter()
ads_exp_fields.sort()

destroy lds_getdata
destroy lds_field_type
//destroy lds_addr_lu - commented by alfee 04.15.2010
//destroy lds_code_lu - commented by alfee 04.15.2010
//--------Begin Added by Nova 10.30.2009------------------------
destroy lds_priv_clinical_area
destroy lds_priv_core
destroy lds_priv_core_procd
//--------End Added --------------------------------------------

//possible future development issues: wanting to 'identify' the records eg. address type; wanting to sort the multi records eg. date from.
return 1
end function

public function integer of_nyp_fte_rows (n_ds ads_rows);//Start Code Change ---- .2007 #V7 maha
//of_nyp_fte_rows function created 10.01.2007 maha for formatting rows for NYP customization  called from of_multi_row

integer r
integer rc
integer li_year
integer nr
string ls_pgyyear
date ld_end

rc = ads_rows.rowcount()

for r = rc to 1 step -1 //drop any rows where the pgy year is not a number (like XX)
	if not isnumber( ads_rows.getitemstring(r,"pgy_year")) then
		ads_rows.rowsdiscard(r,r,primary!)
	end if
next

rc = ads_rows.rowcount()
//loop through again and check for end date over the 06.30 date
//if found add additional row setting the original to 06.30 and the copied row start to 07.01
for r = 1 to rc
	ld_end = date(ads_rows.getitemdatetime(r,"end_date"))
	li_year = year(ld_end)
	if ld_end > date(string(li_year) +"/06/30") then
		ads_rows.rowscopy( r,r, primary!, ads_rows,1000, primary!)
		ads_rows.setitem(r, "end_date",datetime(date(string(li_year) +"/06/30"),time("00:00:00:")))
		ads_rows.setitem(ads_rows.rowcount(), "begin_date",datetime(date(string(li_year) +"/07/01"),time("00:00:00:")))
	end if
next

r = ads_rows.setsort("end_date asc")
//if r < 1 then messagebox("Sort Failed","in function of_nyp_fte_rows")
if r < 1 then inv_message.of_messagebox("Sort Failed","in function of_nyp_fte_rows", TRUE) //scheduler - alfee 03.05.2010
ads_rows.sort()
		

return 1 

end function

public function string of_strip_char_not_used (string as_strip, string as_string, string as_replace);//maha created 120905 to strip/replace characters
//Start Code Change ----04.21.2008 #V8 maha - renames as should not be used (but did not yet want to delete)
//this function had 'disappeared' at some point and was recreated as a separate function (intellicred.pbl).  Should be using the application function.

string ls_ret
string ls_string
integer i
integer ic
integer li_pos
integer p1
integer li_len

li_len = LenA(as_strip)
ls_string = as_string
if isnull(as_replace) then as_replace = ""

if PosA(ls_string,as_strip) > 0 then
	p1 = PosA(ls_string,as_strip)
	do while p1 > 0
		//ls_string = mid(ls_string,1,p1 - 1) + mid(ls_string,p1 + li_len)
ls_string = MidA(ls_string,1,p1 - 1) + as_replace + MidA(ls_string,p1 + li_len)
		p1 = PosA(ls_string,as_strip,p1)
	loop
	ls_ret = ls_string	
else
	ls_ret = as_string
end if


return ls_ret

end function

public subroutine of_get_sortsel (ref string as_sortsel, string as_delstr);//====================================================================
// Event: pfc_n_cst_ai_export_apb.of_get_sortsel()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference	string	as_sortsel	
// 	value    	string	as_delstr 	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Andy		05.13.2008
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long   ll_Pos1,ll_Pos2
String ls_Left,ls_Right
n_cst_string lnvo_string

if PosA(lower(as_sortsel),' desc') > 0 then
	as_sortsel = lnvo_string.of_globalreplace( as_sortsel, ' desc', '')
end if
if PosA(lower(as_sortsel),' asc') > 0 then
	as_sortsel = lnvo_string.of_globalreplace( as_sortsel, ' asc', '')
end if
as_sortsel = "," + as_sortsel + ","

DO WHILE (1=1)
	ll_Pos1 = PosA(lower(as_sortsel),lower(as_delstr))
	if ll_Pos1 < 1 then exit
	
	ls_Left = LeftA(as_sortsel,ll_Pos1 + LenA(as_delstr) - 1)
	ls_Right = MidA(as_sortsel,ll_Pos1 + LenA(as_delstr))
	
	ll_Pos2 = lastpos(ls_Left,',')
	if ll_Pos2 > 0 then
		ls_Left = LeftA(ls_Left,ll_Pos2 - 1)
	end if
	
	as_sortsel = ls_Left + ls_Right
LOOP

if as_sortsel = "," then as_sortsel = ""
//del first ","
if LenA(as_sortsel) > 0 then as_sortsel = MidA(as_sortsel,2)

end subroutine

public function integer of_get_export_data (long al_export_id, long al_data_id[], ref datastore ads_data);//////////////////////////////////////////////////////////////////////
// $<function>w_sheet_ctx_doc_painter/of_get_export_data()
// $<arguments>
//		value    	long     	al_export_id		
//		value    	long     	al_data_id  		ctx_id or prac_id
//		reference	datastore	ads_data    		
// $<returns> integer	1-Successful  0-No export found  -1-Failed
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-15 by Rodger Wu
//////////////////////////////////////////////////////////////////////
integer li_return, li_type
long ll_ctx_id[]
string ls_path, ls_export_name, ls_dwsyntax_str

IF isnull( al_export_id ) OR al_export_id = 0 THEN
	//Messagebox( "Caution", "No export file selected!" )
	inv_message.of_Messagebox( "Caution", "No export file selected!", TRUE) //scheduler - alfee 03.05.2010
	return 0;
END IF

SELECT save_path, export_type, export_name
INTO :ls_path, :li_type, :ls_export_name
FROM export_header WHERE export_id = :al_export_id;

IF isnull( ls_path ) or Trim( ls_path ) = '' THEN
	//Messagebox( "Caution", "No Save Path set for current export file!" )
	inv_message.of_Messagebox( "Caution", "No Save Path set for current export file!", TRUE) //scheduler - alfee 03.05.2010	
	return 0;
END IF

ll_ctx_id = al_data_id

//IF li_type = 3 or li_type = 4 THEN
IF li_type = 3 or li_type = 4 or li_type = 6 THEN //(Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
	li_return = of_export_data_with_text_ctx( al_export_id, ll_ctx_id, ls_path, 0, "","","",2,"" )
	//---------Begin Added by (Appeon)Harry 07.23.2014 for V142 ISG-CLX--------
	/*
	//---------Begin Modified by (Appeon)long.zhang 05.24.2014 (v14.2 Provider-Contract direct linking)
	//ads_data = ids_export_data //Evan 01.20.2010 (V10.1 - Notification Alert)
	ls_dwsyntax_str = ids_ctx_export_data.Describe("datawindow.syntax")
	ads_data.Create(ls_dwsyntax_str)
	ids_ctx_export_data.RowsCopy(1, ids_ctx_export_data.RowCount(), Primary!, ads_data, 1, Primary!)
	//---------End Modfiied ------------------------------------------------------
	*/
	ads_data = ids_export_data
	//---------End Added ------------------------------------------------------
ELSE
	li_return = of_export_data_with_text( al_export_id, ll_ctx_id, ls_path, 0, "","","",2,"" )
	//------------------- APPEON BEGIN -------------------
	//$<modify> Evan 01.20.2010
	//$<reason> V10.1 - Notification Alert
	ls_dwsyntax_str = ids_cred_export_data.Describe("datawindow.syntax")
	ads_data.Create(ls_dwsyntax_str)
	ids_cred_export_data.RowsCopy(1, ids_cred_export_data.RowCount(), Primary!, ads_data, 1, Primary!)
	//------------------- APPEON END ---------------------
END IF
//---------Begin Modified by (Appeon)Toney 06.19.2013 for V141 ISG-CLX--------
  /*
   IF li_return <> 1 THEN return -1;   
  */
IF li_return <> 1 and Not ib_writefile THEN return -1;  //modified by gavins 20121011
//---------End Modfiied ------------------------------------------------------------------

//ads_data = ids_export_data //Evan 01.20.2010 (V10.1 - Notification Alert)
li_return = ads_data.rowcount()

IF li_return > 0 THEN
	return 1;
ELSE
	return li_return;
END IF
end function

public function integer of_cleanup_ds ();//---------Begin Modified by (Appeon)Harry 07.23.2014 for BugH072301--------
/*
//Start Code Change ----04.17.2009 #V92 maha - completed
if IsValid(ids_export_flds) then destroy ids_export_flds
if IsValid(ids_export_hdr) then destroy ids_export_hdr
if IsValid(ids_address_lookup) then destroy ids_address_lookup
if IsValid(ids_code_lookup) then destroy ids_code_lookup
if IsValid(ids_export_data) then destroy ids_export_data
if IsValid(ids_dept_chair) then destroy ids_dept_chair
if IsValid(ids_field) then Destroy ids_field
if IsValid(ids_export_dataTemp) then Destroy ids_export_dataTemp
if IsValid(ids_export_equiv_code) then Destroy ids_export_equiv_code
if IsValid(ids_tablepk) then Destroy ids_tablepk

//---------Begin Added by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
if IsValid(ids_dataobject) then Destroy ids_dataobject
if IsValid(ids_linkto) then Destroy ids_linkto
//---------End Added ------------------------------------------------------
*/
of_cleanup_ds(True)
//---------End Modfiied ------------------------------------------------------
return 1


end function

public function integer of_open_export_pogress ();//moved here temporarily - alfee 02.06.2010
Open(w_export_progress)

If is_called_type = '1' Then
	w_export_progress.title = 'Merge Data Process'
	is_called_type = '0'
Elseif is_called_type = '2' Then // Rodger wu Added.
	w_export_progress.title = 'Merge Data Process'
	w_export_progress.st_6.text = "Progress of building data"
	w_export_progress.st_merge.visible = True
	w_export_progress.hpb_1.visible = True
End If

w_export_progress.st_progress.Text = "Creating export table"

Return 1
end function

public function string of_get_sched_msg ();//Get messages of the schedule - alfee 02.06.2010

return inv_message.of_get_message()
end function

public function integer of_get_sched_cnt ();//Get processed count of the schedule - alfee 02.06.2010

return inv_message.of_get_proc_cnt( )
end function

public function integer of_set_sched_flag (boolean ab_flag);//Set the schedule flag - Scheduler - alfee 02.06.2010

ib_schedule = ab_flag

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function integer of_copy_expdata (datastore ads_export_data, string as_format, boolean ab_header, string as_path, boolean ab_save);//////////////////////////////////////////////////////////////////////
// $<function> of_copy_expdata
// $<arguments>
//               datastore ads_export_data
// $<returns> (Integer)
// $<description> V12.3 -Add ‘Drop Column Before Saving File’
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 03.26.2013
//////////////////////////////////////////////////////////////////////
String ls_sql_syntax
String ls_presentation_str
String ls_dwsyntax_str
String Errors
string ls_colnam
string ls_coltype
long   ll_cnt, ll_col, ll_cols
long   ll_row
integer li_return

//CREATE SYNTAX FOR export DW
ls_sql_syntax = is_select_syntax_drop
ls_presentation_str = "style(type=form)"

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, ls_presentation_str, Errors)
IF LenA(Errors) > 0 THEN //this will fail if the table creation has not been completed
	IF PosA(Errors,"Table or view not found",1) > 0 THEN
	   inv_message.of_MessageBox ("Error in of_export_data_with_text","Export data data store not able to be created.~rCheck the following:~rMake sure export field names have no spaces and contain only letters, numbers and underscores, and that all fields have a width.~rYou cannot have duplicate field names~rField names cannot start with a number.",true )

		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -4 
		
	ELSE
	   inv_message.of_MessageBox("Caution","SyntaxFromSQL caused these errors: " + Errors,true)
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1
	END IF
END IF
ids_export_data_drop = Create datastore
ids_export_data_drop.Create( ls_dwsyntax_str, Errors)
ids_export_data_drop.SetTransObject( SQLCA )
ll_cols = integer(ids_export_data_drop.describe("datawindow.column.count"))

for ll_cnt = 1 to ads_export_data.rowcount()
	ll_row = ids_export_data_drop.insertrow(0)
	for ll_col = 1 to ll_cols
		ls_colnam = ids_export_data_drop.describe("#"+string(ll_col)+".name")
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 05.30.2013
		//$<reason> Bug 3551 : Issues with Emailing Letters 
		//ids_export_data_drop.setitem(ll_row, ls_colnam, ads_export_data.getitemstring(ll_cnt, ls_colnam))
		if lower(ls_colnam) = 'rec_id' or  lower(ls_colnam) ='ctx_id' then
			//-------------appeon begin---------------
			//<$>Modify:long.zhang 06.26.2013
			//<$>reason:column type does not match bug 3583
			//ids_export_data_drop.setitem(ll_row, ls_colnam, ads_export_data.getitemnumber(ll_cnt, ls_colnam))
			ls_coltype = ads_export_data.describe(ls_colnam + ".ColType")
			if Lower ( LeftA (ls_coltype, 5 ) ) = "char(" then
				ids_export_data_drop.setitem(ll_row, ls_colnam, ads_export_data.getitemstring(ll_cnt, ls_colnam))
			else
				ids_export_data_drop.setitem(ll_row, ls_colnam, ads_export_data.getitemnumber(ll_cnt, ls_colnam))
			end if
			//-------------appeon end-----------------
			
		else
			ids_export_data_drop.setitem(ll_row, ls_colnam, ads_export_data.getitemstring(ll_cnt, ls_colnam))
		end if
		//------------------- APPEON END -------------------
		
	next
next

li_return = 1
if ab_save then
	CHOOSE CASE as_format
		CASE ".txt" //tab delimited
			li_return = ids_export_data_drop.SaveAs(as_path,Text!,ab_header)
			
		CASE ".xls" //excel
			li_return = ids_export_data_drop.SaveAs(as_path,excel8!,ab_header)  //Start Code Change ----08.29.2013 #V14 maha - changed from excel!
		CASE ".xlsx" //excel 2007 and 2010...//Added by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
			n_cst_excel lnv_excel
			lnv_excel = create n_cst_excel
			lnv_excel.of_saveas_excel( ids_export_data_drop,as_path,ab_header, true )
			destroy lnv_excel
		CASE ".csv" //excel
			li_return = ids_export_data_drop.SaveAs(as_path,csv!,ab_header)
			
	END CHOOSE
end if
	

return li_return
end function

public function string of_get_coltype (datastore ads_object, string as_name);//====================================================================
//$<Function>: of_get_coltype
//$<Arguments>:
// 	value    datastore    ads_object
// 	value    string       as_name
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Toney 06.19.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Add function by Jervis 03.17.2009

string ls_datatype

//Get Column Type
ls_datatype = ads_object.Describe( as_name + ".coltype")
Choose Case Left ( ls_datatype , 5 )
	Case "char(", "char"
		ls_datatype = "C"
	Case "date"	,"datet"	,"time", "times"
		ls_datatype = "D"
	Case "decim","numbe", "doubl", "real","long", "ulong", "int"
		ls_datatype = "N"
End Choose
return ls_datatype
end function

public function integer of_set_str_action_item (str_action_item astr_action_item);//(Appeon)Harry 04.10.2014 -  for Bug 3998
istr_action_item = astr_action_item
return 1
end function

public function integer of_create_ds ();//////////////////////////////////////////////////////////////////////
// $<function>of_create_ds()
// $<arguments>
//		None
// $<returns> integer
// $<description> Create DataStore.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
//////////////////////////////////////////////////////////////////////
string ls_dbtype
ls_dbtype = of_get_dbtype()
ids_tablepk = Create n_ds 
IF LeftA(Upper(ls_dbtype),3) = 'ASA' THEN
	ids_tablepk.DataObject = "d_export_tablepk_asa_ctx"
	//ls_top = ""
ELSE
	ids_tablepk.DataObject = "d_export_tablepk_sql_ctx"
END IF
ids_tablepk.SetTransObject( SQLCA )
ids_field = Create n_ds
ids_field.DataObject = "d_export_fields"
ids_field.of_SetTransObject( SQLCA )
//ids_field.Retrieve( ai_export_id )

ids_code_lookup = Create n_ds
ids_code_lookup.DataObject = "d_code_lookup"
ids_code_lookup.of_SetTransObject( SQLCA )

ids_address_lookup = Create n_ds
ids_address_lookup.DataObject = "d_address_lookup"
ids_address_lookup.of_SetTransObject( SQLCA )

ids_export_hdr = Create n_ds
ids_export_hdr.DataObject = "d_export_hdr"
ids_export_hdr.of_SetTransObject( SQLCA )

ids_export_flds = Create n_ds
//ids_export_flds.DataObject = "d_export_flds_list_exp"
ids_export_flds.DataObject = "d_export_flds_list_exp_ctx"
ids_export_flds.of_SetTransObject( SQLCA )

ids_dept_chair = Create n_ds //maha 010704
ids_dept_chair.DataObject = "d_dept_chair_exp_all"
ids_dept_chair.of_SetTransObject( SQLCA )

ids_export_retrieve = Create n_ds
//ids_export_hdr.Retrieve( ai_export_id )

ids_export_equiv_code = Create n_ds
ids_export_equiv_code.DataObject = "d_export_equiv_code_lds"
ids_export_equiv_code.SetTransObject( SQLCA )
//ll_equivcodeCnt = ids_export_equiv_code.Retrieve()

ids_export_data = Create n_ds
ids_export_dataTemp = Create n_ds

ids_dataobject = Create n_ds
ids_linkto = create datastore


return 1
end function

public function integer of_cleanup_array ();//////////////////////////////////////////////////////////////////////
// $<function>of_cleanup_array
// $<arguments>
//		None
// $<returns> integer
// $<description> Cleanup array.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
//////////////////////////////////////////////////////////////////////

String ls_temp[]
Long ll_temp[]
is_tablelist[] = ls_temp[]
is_billsynList[] = ls_temp[]
is_fieldlist[] = ls_temp[]
is_selectfieldlist[] = ls_temp[]
is_formatList[] = ls_temp[]
is_dcfieldList[]  = ls_temp[]
is_defvalList[] = ls_temp[]
is_textList[] = ls_temp[]
is_lu_fieldList[]  = ls_temp[]
is_typelist[] = ls_temp[]
is_flddelimList[] = ls_temp[]
is_table[] = ls_temp[]
is_tablepks[] = ls_temp[]
is_sortpk[] = ls_temp[]
ii_recdnoList[] = ll_temp[]
il_exportcodeList[] = ll_temp[]
il_intcredfieldList[] = ll_temp[]
ii_substartList[] = ll_temp[]
ii_widthList[] = ll_temp[]
ii_udList[] = ll_temp[]
ii_facil_idList[] = ll_temp[]
ii_act_formatList[] = ll_temp[]
ii_billingList[]  = ll_temp[]

return 1
end function

public function string of_getsql_from_export_temp (string as_sql, long al_spid, ref boolean ab_mulsel, string as_value);//////////////////////////////////////////////////////////////////////
// $<function>of_create_ds()
// $<arguments>
//		value	string	as_sql
//		value	long	al_SpID
//		reference boolean ab_mulsel
//		value	string 	as_value  
// $<returns> string
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
//////////////////////////////////////////////////////////////////////
String ls_dbtype
String ls_prac_sql
String ls_Mysql
String ls_prac_sql_temp
String ls_prac_sql_temp2
String ls_top = "top 2147483647"


Long ll_SpID
Long ll_pos
Long ll_len
Long ll_Cnt

ls_dbtype = of_get_dbtype()

IF LeftA(upper(ls_dbType),3) = 'ASA' THEN 
	ls_top = ""
END IF

ll_SpID = al_SpID

//specify SQL
ls_prac_sql  = trim(as_sql)
if isnull(ls_prac_sql) then ls_prac_sql = ''
if ls_prac_sql <> '' then 
	ll_pos = PosA(ls_prac_sql,";")
	if ll_pos > 0 then 
		ls_prac_sql  = ReplaceA(ls_prac_sql,ll_pos,1,'')
	end if
	ll_len = LenA(ls_prac_sql)
	ls_prac_sql_temp = trim(MidA(ls_prac_sql,7,ll_len))
	if lower(LeftA(ls_prac_sql_temp,8)) = 'distinct' then
		ls_prac_sql_temp2 = trim(MidA(ls_prac_sql_temp,9,ll_len))
		if lower(LeftA(ls_prac_sql_temp2,3)) <> 'top' then 
			ls_prac_sql = 'select distinct ' + ls_top + ' ' + ls_prac_sql_temp2
		end if
	elseif lower(LeftA(ls_prac_sql_temp,3)) <> 'top' then
		ls_prac_sql = 'select ' + ls_top + ' ' + ls_prac_sql_temp
	end if
	
	//del order by statement. Reason:if ORDER BY items isn't in the select list,then it will get error.
	//ORDER BY items must appear in the select list if the statement contains a UNION operator.
	ll_pos = PosA(lower(ls_prac_sql)," order ")
	if ll_pos > 0 then
		ls_prac_sql = LeftA(ls_prac_sql,ll_pos - 1)
	end if
	//if select more than one field,then add a select statement outside the ls_prac_sql and
	//INSERT the result INTO a table.
	ll_pos = PosA(lower(ls_prac_sql)," from ")
	ls_prac_sql_temp = LeftA(ls_prac_sql,ll_pos - 1)
	ll_pos = PosA(ls_prac_sql,",")
	if ll_pos > 0 then
		ab_mulsel = true
		//ls_prac_sql = "select distinct ctx_id," + String(ll_spid) + " from (" + ls_prac_sql + ") cc order by ctx_id"
		ls_prac_sql = "select distinct " + as_value + "," + String(ll_spid) + " from (" + ls_prac_sql + ") cc order by " + as_value
		select top 1 1 into :ll_Cnt from sysobjects where name = 'export_temp' and type = 'U';
		if ll_Cnt = 1 then
			ls_Mysql = "DELETE FROM export_temp WHERE SpID = " + String(ll_spid) + ";"
		else
			ls_MySQL = "CREATE TABLE export_temp (prac_id int null,SpID int null)"
		end if
		EXECUTE IMMEDIATE :ls_Mysql;
		ls_MySQL = "INSERT INTO export_temp " + ls_prac_sql + ";"
		EXECUTE IMMEDIATE :ls_Mysql;
		//ls_prac_sql = "select distinct prac_id as ctx_id from export_temp where SpID = " + String(ll_spid)
		ls_prac_sql = "select distinct prac_id as " + as_value + " from export_temp where SpID = " + String(ll_spid)
	end if
end if
debugbreak()


return ls_prac_sql
end function

public function integer of_gensql_ctx (integer ai_type, ref long ll_fieldseqid, string as_param1, string as_param2, string as_param3, ref string as_sny_retrieve, str_gensql_param astr_gensql_param);//////////////////////////////////////////////////////////////////////
// $<function>of_gensql_ctx()
// $<arguments>
//		value	integer	ai_type 	 (1: specify SQL/2: specify array/3: between...and)	
//		reference	long   	ll_fieldseqid	 
//		value	string 	as_param1    		
//		value	string 	as_param2    		
//		value	string 	as_param3
//    	reference string  as_sny_retrieve     
//    	value str_gensql_param   astr_gensql_param
// $<returns> integer
// $<description> Generate syntax of Contract Data.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
//////////////////////////////////////////////////////////////////////
String ls_dbtype
String ls_sny_retrieve
String ls_ic_area
String ls_export_field
String ls_select_field_ctx
String ls_tempstr
String ls_select_table
String ls_select_field
String ls_otherfilter
String ls_fld_delim
String ls_dc_field
String ls_lu_field
String ls_aggre
String ls_sort
String ls_Sortsel
String ls_text
String ls_use_link_sql
String ls_use_link_sql2
String ls_select_table_trim
String ls_filter
String ls_linkfromcol
String ls_linktocol
String ls_linktotable
String ls_ic_link_area
String ls_datatype
String ls_field_format
String ls_def_val
String ls_usetable = ""
String ls_ctx_table
String ls_syn_parent
String ls_tablepk
String ls_RowNoSyn = ""
String ls_dddwdata
String ls_bill_syn
String ls_db_lookup_type
String ls_top = "top 2147483647"
String ls_dddwname
String ls_dddwtable
String ls_dddw_column_dbname
String ls_link_table
String ls_link_table_on
String ls_no_link_on
String ls_other_where 
String ls_select_table_on
String ls_use_link_sqlsyn
String ls_lu_codename
String ls_field_value
String ls_datatype_ctx
String ls_Mysql
String ls_synprefix
String ls_tabletemp
String ls_prac_sql
String ls_prac_ids
String ls_client_id
String ls_rowno
String ls_parent_firstcolumn
String ls_firstcolumn


Long ll_ctx_scrn_id
Long li_use_link
Long li_recd_no
Long ll_export_code
Long ll_intcred_field
Long li_facil_id
Long li_act_format
Long li_sub_start
Long li_billing
Long li_pos1
Long ll_ctx_link_scrn_id
Long li_width
Long li_widthtemp
Long ud
Long ll_pkcnt
Long ll_n
Long ll_Rcnt
Long p

Integer li_link

Boolean lb_usingdb
Boolean lb_doc_action
Boolean lb_get_parent
Boolean lb_flagpk
Boolean lb_ASA7 = false
Boolean lb_true = false
datawindowchild ldwc_dddw

p = astr_gensql_param.ll_rowno
ls_synprefix = astr_gensql_param.ls_synprefix
ls_tabletemp = astr_gensql_param.ls_tabletemp
li_link =  astr_gensql_param.li_link
ls_prac_sql = astr_gensql_param.ls_prac_sql
ls_prac_ids = astr_gensql_param.ls_prac_ids
lb_usingdb = astr_gensql_param.lb_usingdb
ls_client_id = astr_gensql_param.ls_client_id
ls_rowno = astr_gensql_param.ls_rowno

ls_sny_retrieve = as_sny_retrieve

ls_dbtype = of_get_dbtype()
if upper(ls_dbtype) = 'SQL2005' OR upper(ls_dbtype) = 'ASA9' THEN
	//ls_RowNo = ",Row_No"
	lb_true = true
elseif upper(ls_dbtype) = 'ASA7' then
	lb_ASA7 = true
end if

IF LeftA(upper(ls_dbType),3) = 'ASA' THEN 
	ls_top = ""
END IF
ids_dataobject.dataobject = ids_export_flds.GetItemString( p, "export_fields_ctx_scrn_dataobject" )
ls_field_format = ids_export_flds.GetItemString(p,"export_format")
li_width = ids_export_flds.GetItemNumber(p,"export_field_length")
ls_dc_field = "none"
li_sub_start=  0
lb_get_parent = false
ls_syn_parent = ""
ls_dddwtable = ""
ls_no_link_on = ""
ls_other_where = ""
ls_select_table_on = ""
ls_lu_codename = ""
ls_field_value = ""

ud = ids_export_flds.GetItemNumber( p, "use_default" )
If ud = 1 Or ud = 2 Then
	ls_def_val = ids_export_flds.GetItemString( p, "default_value" )
Else
	ls_def_val = ""
End If

//Get Parent Level Data
if ids_export_flds.GetItemString( p,"record_level") = 'P' then lb_get_parent = true

if lb_get_parent then
	ls_syn_parent = "ctx_basic_info table_1 left join ctx_basic_info table_2 on (table_1.master_contract_id = table_2.ctx_id ) left join "
end if
//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
ll_ctx_scrn_id = ids_export_flds.GetItemNumber(p,"export_fields_ctx_scrn_id") //Add by Jack 06/05/2007
If ll_ctx_scrn_id = 6 Then
	ls_ic_area = "E"
ElseIf ll_ctx_scrn_id = 7 Then
	ls_ic_area = "I"
elseif ll_ctx_scrn_id = 14 or ll_ctx_scrn_id = 17 then //add other contact -- jervis 03.28.2011
	ls_ic_area = "C"
End If		
//---------End Added ------------------------------------------------------------------

//CREATE SYNTAX FOR each retrieve DW
ls_export_field = ids_export_flds.GetItemString(p,"export_field_name")
of_replacespecchar(ls_export_field)
ls_select_field_ctx = Trim( ids_export_flds.GetItemString( p, "db_field_name" ) )
Choose Case ls_select_field_ctx
	Case "app_facility" 
		ls_tempstr = 'ctx_basic_info.app_facility'
		ls_select_table = f_get_token( ls_tempstr, "." )
		ls_select_field = ls_tempstr		
	Case "compute_1"
		ls_select_table = 'ctx_contract_contacts'
		ls_select_field = "compute_1"		
	Case "contact_phone" 
		ls_select_table = 'ctx_contract_contacts'
		ls_select_field = 'contact_phone'	
	Case "contact_email"
		if ll_ctx_scrn_id <> 2002 then //jervis 03.28.2011
			ls_select_table = 'ctx_contract_contacts'
			ls_select_field = 'contact_email'
		else
			ls_select_table = 'ctx_contacts_numbers'
			ls_select_field = 'contact_email'
		end if
	Case Else
		ls_tempstr = ids_dataobject.Describe( ls_select_field_ctx + ".dbname" )
		if pos(ls_tempstr,".") > 0 then	//IF Exists Table Selection - jervis 03.17.2009
			ls_select_table = f_get_token( ls_tempstr, "." )
		else
			ls_select_table = ""
		end if 
		ls_select_field = ls_tempstr
		
		if ll_ctx_scrn_id = 12 then //Export Requirement Profile Detail-- jervis 03.17.2009
			ls_select_table = 'ctx_elements'
		elseif ll_ctx_scrn_id = 2004 then
			ls_select_table = 'sys_statusaudit'	//Export Contract Status tract - jervis 03.20.2009
		elseif (ll_ctx_scrn_id = 6 or ll_ctx_scrn_id = 7) and ls_select_field = "facility_id" then
			ls_select_table = 'ctx_contract_contacts'  //Export comany info with contact - jervis 01.30.2011
		ElseIf ll_ctx_scrn_id = 22 Then
			ls_select_table = 'ctx_orgs_contact'//added by gavins 20130314	
		end if	
		//---------End Modfiied ------------------------------------------------------------------			
End Choose

//---------Begin Added by (Appeon)Harry 04.10.2014 for Bug 3998--------
ls_otherfilter = ""
lb_doc_action = false
if istr_action_item.module = '04' then
	if ls_select_table = 'ctx_am_action_item' or ls_select_table = 'ctx_am_document' then
		if not isnull(istr_action_item.doc_id) and istr_action_item.doc_id > 0 then
			ls_otherfilter += " and " + ls_select_table + ".doc_id = " + string(istr_action_item.doc_id)
			lb_doc_action = true
		end if
		if ls_select_table = 'ctx_am_action_item' then 
			if not isnull(istr_action_item.seq_no) and istr_action_item.seq_no > 0 then
				ls_otherfilter += " and " + ls_select_table + ".seq_id = " + string(istr_action_item.seq_no)
				lb_doc_action = true
			end if
		end if
	end if
end if
//---------End Added ------------------------------------------------------

li_use_link = ids_export_flds.GetItemNumber(p,"export_fields_ctx_uselink")
if isnull( li_use_link ) then li_use_link = 0

ll_ctx_scrn_id = ids_export_flds.GetItemNumber(p,"export_fields_ctx_scrn_id")  //Add by Jack 06/05/2007
If ll_ctx_scrn_id = 6 Then 
	ls_ic_area = "E" 
ElseIf ll_ctx_scrn_id = 7 Then 
	ls_ic_area = "I" 
end if

ls_fld_delim = ids_export_flds.GetItemString( p, "trailing_leading_characters")
li_recd_no = ids_export_flds.GetItemNumber(p,"intcred_record_number")		
if lb_doc_action and li_recd_no > 1 then li_recd_no = 1 //(Appeon)Harry 04.10.2014 for Bug 3998

ll_FieldSeqID ++
ll_export_code = ids_export_flds.GetItemnumber( p, "export_code" )
ls_dc_field = ids_export_flds.GetItemstring( p, "dept_sect_field" )
if isnull(ls_dc_field) or trim(ls_dc_field) = '' then ls_dc_field = "none"
ll_intcred_field = ids_export_flds.getitemnumber(p,"intcred_field")
li_facil_id = ids_export_flds.GetItemNumber(p,"facility_id")
ls_lu_field = ids_export_flds.GetItemString( p, "lu_field_name" )
ls_aggre = ids_export_flds.GetItemString( p, "aggre_function" )
ls_sort = ids_export_flds.GetItemString( p, "sort_by" )
ls_Sortsel = ls_sort
if isnull(ls_Sortsel) then ls_Sortsel = ''
//---------Begin Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
//if LenA(trim(ls_Sortsel)) > 0 then of_get_sortsel(ls_Sortsel,'ctx_id')
if LenA(trim(ls_Sortsel)) > 0 then 
	if li_link = 0 then
		of_get_sortsel(ls_Sortsel,'ctx_id')
	else
		of_get_sortsel(ls_Sortsel,'prac_id')
	end if
end if
//---------End Modfiied ------------------------------------------------------

li_act_format = ids_export_flds.GetItemNumber(p,"export_fields_active_yesno")
ls_text = ids_export_flds.GetItemString(p,"field_value") //maha 091305
If Upper(ls_lu_field) = "LOOKUP CODE" Then ls_lu_field = "lookup_code"
If IsNull(ls_lu_field) Then ls_lu_field = "code"
ls_use_link_sql = ""
ls_use_link_sql2 = ""

li_sub_start = ids_export_flds.getitemnumber(p,"export_fields_substring_start")
if PosA(ls_select_table,"dba.",1) > 0 then //maha 122005 
	ls_select_table_trim = MidA(ls_select_table,5) //dropping dba.
	ls_select_table = ls_select_table_trim  //maha 012306
else
	ls_select_table_trim = ls_select_table
end if
ls_filter = ids_export_flds.GetItemString(p,"filter_query")
li_billing = ids_export_flds.GetItemNumber(p,"billing_link") //maha app080205
If IsNull(li_facil_id) Then li_facil_id = 0

If IsNull(ls_filter) Or Trim(ls_filter) = "" Then
	ls_filter = ""
Else
	ls_filter = " and  ( " + ls_filter + " )"		
	li_pos1 = PosA(Upper(ls_filter),"PROMPT1",1)
	If li_pos1 > 0 Then
		ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param1 + MidA(ls_filter,li_pos1 + 7)
	End If
	li_pos1 = PosA(Upper(ls_filter),"PROMPT2",1)
	If li_pos1 > 0 Then
		ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param2 + MidA(ls_filter,li_pos1 + 7)
	End If
	li_pos1 = PosA(Upper(ls_filter),"PROMPT3",1)
	If li_pos1 > 0 Then
		ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param3 + MidA(ls_filter,li_pos1 + 7)
	End If
End If

//export_fields_use_link  sql
If li_use_link = 1 Then
	ls_linkfromcol = Trim( ids_export_flds.GetItemString( p, "export_fields_ctx_linkfromcolumn" ))
	ls_tempstr = ids_dataobject.Describe( ls_linkfromcol + ".dbname" )
	f_get_token( ls_tempstr, "." )
	ls_linkfromcol = ls_tempstr
	
	ids_linkto.dataobject = Trim( ids_export_flds.GetItemString( p, "export_fields_ctx_linktoscrndw" ))
	ls_linktocol = Trim( ids_export_flds.GetItemString( p, "export_fields_ctx_linktocolumn" ))
	ls_tempstr = ids_linkto.Describe( ls_linktocol + ".dbname" )
	ls_linktotable = f_get_token( ls_tempstr, "." )
	ls_linktocol = ls_tempstr
	//---------Begin Modified by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
	//ls_use_link_sql = ", " + ls_linktotable	
	//Contacted contact or our company contact - jervis 01.27.2011
	ll_ctx_link_scrn_id = ids_export_flds.GetItemNumber(p,"export_fields_ctx_linktoscrnid") 
	If ll_ctx_link_scrn_id = 6 Then
		ls_ic_link_area = "E"
	ElseIf ll_ctx_link_scrn_id = 7 Then
		ls_ic_link_area = "I"
	elseif ll_ctx_link_scrn_id = 14 or ll_ctx_link_scrn_id = 17 then  //add other contact -- jervis 03.28.2011
		ls_ic_link_area = "C"
	End If			  
	//---------End Modfiied ------------------------------------------------------------------			
End If

is_tablelist[ll_FieldSeqID] = ls_select_table
is_fieldlist[ll_FieldSeqID] = ls_export_field
ii_recdnoList[ll_FieldSeqID] = li_recd_no
is_selectfieldlist[ll_FieldSeqID] = ls_select_field
//is_typelist[ll_FieldSeqID] = ls_datatype //Alfee 11.13.2008		
ii_billingList[ll_FieldSeqID] = li_billing //Alfee 11.13.2008	
is_formatList[ll_FieldSeqID] = ls_field_format
il_exportcodeList[ll_FieldSeqID] = ll_export_code
is_dcfieldList[ll_FieldSeqID] = ls_dc_field
il_intcredfieldList[ll_FieldSeqID] = ll_intcred_field
ii_substartList[ll_FieldSeqID] = li_sub_start
ii_widthList[ll_FieldSeqID] = li_width
li_widthtemp = li_width
//---------Begin Modified by (Appeon)Stephen 12.07.2015 for Export data column issues--------
//if li_widthtemp < 30 then li_widthtemp = 30
if li_widthtemp < 1 then li_widthtemp = 30
//---------End Modfiied ------------------------------------------------------
is_flddelimList[ll_FieldSeqID] = ls_fld_delim
ii_udList[ll_FieldSeqID] = ud
is_defvalList[ll_FieldSeqID] = ls_def_val
is_textList[ll_FieldSeqID] = ls_text
is_lu_fieldList[ll_FieldSeqID] = ls_lu_field
ii_facil_idList[ll_FieldSeqID] = li_facil_id
ii_act_formatList[ll_FieldSeqID] = li_act_format

if (ll_ctx_scrn_id = 6 or ll_ctx_scrn_id = 7) and ls_select_field = 'facility_id' then
	ls_usetable = "ctx_contract_contacts"
elseIf ls_select_table <> 'app_facility' Then
	If li_use_link = 1 Then
		ls_usetable = Lower(ls_linktotable)
	Else
		ls_usetable = Lower(ls_select_table)
	End If
Else
	ls_usetable = "ctx_basic_info"
End If

if lb_get_parent then
	ls_ctx_table = "table_1"
else
	ls_ctx_table = ls_usetable
end if

ls_tablepk= ""
if ISNULL(ls_sort) OR trim(ls_sort) = "" then
	ls_sort = ""
	lb_flagpk = true
	ll_pkcnt = upperbound(is_table)
	FOR ll_n = 1 to ll_pkcnt
		if lower(ls_usetable) = lower(is_table[ll_n]) then
			ls_tablepk = is_tablepks[ll_n]
			ls_sort = is_sortpk[ll_n]
			lb_flagpk = false
		end if
	next
	if lb_flagpk then
		ll_Rcnt = ids_tablepk.retrieve( ls_usetable)
		ls_sort = ls_usetable + '.ctx_id, '
		for ll_n = 1 to ll_Rcnt
			if lower(ids_tablepk.getitemstring( ll_n, "column_name")) = 'ctx_id' then continue
			ls_tablepk += ls_usetable + '.' + ids_tablepk.getitemstring( ll_n, "column_name") + ", "
		next
		ls_sort = ls_sort + ls_tablepk
		ls_sort  = LeftA(ls_sort,LenA(ls_sort) - 2)
		is_sortpk[ll_pkcnt + 1] = ls_sort
		is_table[ll_pkcnt+1] = ls_usetable
		is_tablepks[ll_pkcnt+1] = ls_tablepk
	end if
else
	if PosA(lower(ls_sort),'ctx_id') < 1 then ls_sort = ls_usetable + '.ctx_id, ' + ls_sort	
end if

if lb_ASA7 THEN 
	ls_tablepk = ""
	ls_Sortsel = ""//<add> 08/27/2007 by: Andy
end if

if LenA(ls_aggre) > 0 then ls_sort = ls_sort + " , field_value"
if LenA(ls_sort) > 0 then ls_sort = "order by " + ls_sort

if lb_true THEN ls_RowNoSyn = ",row_number() over(" + ls_sort+") Row_No" //SQL2005 and ASA9
		
ls_bill_syn     = "Select " + lower(ls_usetable) + ".ctx_id, "
//(Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
if li_link = 0 then 
	//ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " " + ls_usetable + ".ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, "	
	ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " " + ls_ctx_table + ".ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, " //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
else  //li_link = 3
	ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_prac_link.prac_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, "
end if

ls_sny_retrieve = ls_sny_retrieve + " 0 billing_address_id, " //(Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
ls_db_lookup_type = ids_export_flds.GetItemString( p, "export_fields_ctx_lookup_type" )
If ls_select_table = 'app_facility' And ls_select_field_ctx = 'state' Then
	ls_dddwdata = ''
Else
	ls_dddwdata = lower( ids_dataobject.Describe( ls_select_field_ctx + ".dddw.datacolumn" ) )
End If

if ls_dddwdata <> '?' and ls_dddwdata <> '!' and ls_dddwdata <> '' then
	ls_tempstr = lower( ids_dataobject.Describe( ls_select_field_ctx + ".dddw.displaycolumn" ) )
	//the edit style has been dynamic change for lookup or company dddw -- jervis 09.22.2011
	ls_dddwname =  Lower( ids_dataobject.Describe( ls_select_field_ctx + ".dddw.name" ) )
	if ls_dddwname = 'd_dddw_code_lookup' or ls_dddwname = 'd_dddw_company'  then  
		ls_dddwdata = ''
	else
		If ls_tempstr <> '?' And ls_tempstr <> '!' And ls_tempstr <> '' Then
			
			If IsNull( ls_db_lookup_type ) Then
				ls_db_lookup_type = "X"
				ls_lu_field = ls_tempstr
				
				ids_dataobject.GetChild( ls_select_field_ctx, ldwc_dddw )
				ls_tempstr = ldwc_dddw.Describe( ls_lu_field + ".dbname" )
				ls_dddwtable = f_get_token( ls_tempstr, "." )
				ls_dddw_column_dbname = ls_tempstr
			End If
		End If
	end if			  
end if

//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
If li_use_link = 1 Then
	if lb_get_parent then
		ls_link_table = ls_linktotable
		ls_link_table_on = " on( table_2.ctx_id = " + ls_linktotable + ".ctx_id) left join "
		if ls_select_table <> "app_facility" then
			ls_no_link_on = " on (table_2.ctx_id = " + Lower(ls_select_table) + ".ctx_id) "
		else
			ls_no_link_on = " on (table_2.ctx_id = " + Lower(ls_usetable) + ".ctx_id) "
		end if
	else
		ls_link_table = ls_linktotable + " left join "
		ls_link_table_on = " "
	end if
	
	ls_select_table_on = " on  (" + ls_linktotable + "." + ls_linktocol + " = " + ls_select_table + "." + ls_linkfromcol + ") "
	
	//Contracted contact or our company contact - jervis 01.27.2011
	//add other contact - jervis 03.28.2011
	If ll_ctx_link_scrn_id = 6 or ll_ctx_link_scrn_id = 7 or ll_ctx_link_scrn_id = 14 or ll_ctx_link_scrn_id = 17 Then
		ls_other_where = " and " + ls_linktotable + ".ic_area ='" + ls_ic_link_area + "' "
	end if
else
	ls_link_table = " "
	ls_link_table_on = " "
	//Get select table on clause		-- jervis 03.04.2009
	if lb_get_parent then
		if ls_select_table <> "app_facility" then
			ls_select_table_on = " on (table_2.ctx_id = " + Lower(ls_select_table) + ".ctx_id) "
		else
			ls_select_table_on = " on (table_2.ctx_id = " + Lower(ls_usetable) + ".ctx_id) "
		end if
	end if
	ls_no_link_on = ls_select_table_on
	//Get link table on clause		-jervis 03.04.2009
End If
//---------End Added ------------------------------------------------------------------

If ls_select_field = "affiliation_status" Then // setting lookup field and where
	ls_datatype = "C"
	ls_bill_syn     =     ls_bill_syn + " code_lookup."+ ls_lu_field + " from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and "
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and "			

	ls_select_field  = "code_lookup_" + ls_lu_field			
ElseIf ls_select_field = 'app_facility' And Upper(ls_db_lookup_type)  = "C" Then
	ls_datatype = "C"
	ls_bill_syn     = ls_bill_syn + " app_facility."+ ls_lu_field + " from app_facility," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(" + lower(ls_select_table) + "." + ls_select_field + " = app_facility.facility_id) and "
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),app_facility."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join app_facility on("+ Lower(ls_select_table) + "." + ls_select_field + " = app_facility.facility_id) " //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
	ls_select_field  = "app_facility_" + ls_lu_field			
//Export location data 
//Export company info whit contracted conatct or our company contact -- jervis 01.30.2011
elseif (ll_ctx_scrn_id = 6 or ll_ctx_scrn_id = 7 or ll_ctx_link_scrn_id = 14 or ll_ctx_link_scrn_id = 17) and ls_select_field = 'facility_id' then
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),app_facility."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id) left join app_facility on(ctx_contacts.facility_id = app_facility.facility_id) "
	ls_select_field  = "app_facility_" + ls_lu_field
	ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
elseif ls_select_field = 'loc_id' and upper(ls_db_lookup_type) = "L" then //Location
	ls_datatype = "C"
	if ls_lu_field = "state"  or ls_lu_field = "country" or ls_lu_field = "mailing_address" then
		//Use code_lookup.code display value -- jervis 08.04.2009
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup.code) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_practice on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_practice.rec_id) " + &
							"left join code_lookup on ( group_practice." + ls_lu_field + " = code_lookup.lookup_code) " 
	elseif  ls_lu_field = "county"  then
		//Use code_lookup.describe display value -- jervis 08.04.2009
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup.description) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_practice on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_practice.rec_id) " + &
							"left join code_lookup on ( group_practice." + ls_lu_field + " = code_lookup.lookup_code) " 
	elseif ls_lu_field = "mailing_address_desc" then		//Export Description - jervis 08.07.2009
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup.description) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_practice on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_practice.rec_id) " + &					
							"left join code_lookup on ( group_practice.mailing_address = code_lookup.lookup_code) " 
	else
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),group_practice."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_practice on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_practice.rec_id) "
	end if
	ls_select_field = "group_practice_" + ls_lu_field	
elseif ls_select_field = 'parent_comp_id' and Upper(ls_db_lookup_type) = "M" then	//Parent Organization -- jervis 06.23.2009			
	ls_datatype = "C"
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),group_multi_loc."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_multi_loc on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_multi_loc.rec_id) "
	ls_select_field = "group_multi_loc_" + ls_lu_field

//---------Start code by jervis 03.17.2009-------------
//Export Requiments data
elseif ls_select_field = 'ctx_req_profile_id' and Upper(ls_db_lookup_type) = "R"	 then //Requiren profile dddw-jervis 03.17.2009
	ls_Datatype = 'C'
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),ctx_req_profile."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join ctx_req_profile on("+ Lower(ls_select_table) + "." + ls_select_field + " = ctx_req_profile.ctx_req_profile_id) "
	ls_select_field = "ctx_req_profile_" + ls_lu_field
	
	
ElseIf ll_ctx_scrn_id = 22 Then
	ls_datatype = of_get_coltype(ids_dataobject,ls_select_field_ctx) 
	//ls_select_table = 'ctx_orgs_contact'//added by gavins 20130314
	If ls_select_field = 'org_type' then
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " inner join ctx_orgs on " + Lower(ls_select_table) + ".org_id"  +" = ctx_orgs.org_id  left join code_lookup on (ctx_orgs." + ls_select_field + " = code_lookup.lookup_code) "
	Else
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),ctx_orgs."+ ls_select_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " inner join ctx_orgs on " + Lower(ls_select_table) + ".org_id"  +" = ctx_orgs.org_id  "
	End if
	ls_select_field  = "ctx_orgs_" + ls_select_field				
elseif ll_ctx_scrn_id = 12 then	//Export Requirements Profile Detail Data - jervis 03.17.2009
	ls_datatype = of_get_coltype(ids_dataobject,ls_select_field_ctx)
	choose case ls_select_field
		case 'data_value'
			ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + "),(Case ctx_req_tmplt_element.value_type when 1 then convert(varchar," + ls_select_table + ".date_value ,101) when 2 then " + ls_select_table+ ".field_value when 3 then " + ls_select_table + ".char_value when 4 then cast(" +ls_select_table+".integer_value as varchar) when 6 then cast(" +ls_select_table+".money_value as varchar) when 5 then " +ls_select_table +" .field_value end)) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " 
									//ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
									//"left join ctx_req_tmplt_element on (" + ls_select_table + ".ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id)"
			ls_select_field = ls_select_table + "_"+ls_select_field
		case 'element_sort'	//in process....
		case 'requirement'	
			ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + "),ctx_req_tmplt_element.element_name) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " //+ &
									//ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
									//"left join ctx_req_tmplt_element  on (" + ls_select_table + ".ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id)"
			ls_select_field =  "ctx_req_tmplt_element_"+ls_select_field
		case 'ctx_rqmnt_category_id'	//in process....
		case 'ctx_req_profile_id'	//in process
		case 'category_name'
			ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + "),ctx_rqmnt_category.category_name) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " //+ &
									//ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
									//"left join ctx_req_tmplt_element on (" + ls_select_table + ".ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id) " + &
									//"left join ctx_rqmnt_category  on (ctx_req_tmplt_element.ctx_rqmnt_category_id = ctx_rqmnt_category.ctx_rqmnt_category_id and " + ls_linktotable + ".ctx_req_profile_id = ctx_rqmnt_category.ctx_req_profile_id)"
			ls_select_field = "ctx_rqmnt_category_"+ls_select_field

		case else		//case 'clause'
			ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + ")," + ls_select_table + "."+ ls_select_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " //+ &
									//ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on 
									
			ls_select_field = ls_select_table + "_"+ls_select_field
	end choose
	ls_sny_retrieve =  ls_sny_retrieve + ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
							" left join ctx_req_tmplt_element on (" + ls_select_table + ".ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id) " + &
							" left join ctx_rqmnt_category  on (ctx_req_tmplt_element.ctx_rqmnt_category_id = ctx_rqmnt_category.ctx_rqmnt_category_id and " + ls_linktotable + ".ctx_req_profile_id = ctx_rqmnt_category.ctx_req_profile_id)"
//---------End code by jervis 03.17.2009-------------	

//Export the Processing Setting for Contract status tract
elseif ll_ctx_scrn_id = 2004 and ls_select_field = "processing_setting"	 then
	ls_datatype = 'C'
	ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + "),case code_lookup.custom_2 when 'On' then 'In Process' when 'Off' then 'On Hold' when 'Complete' then 'Executed' when 'NA' then 'N/A' else custom_2 end ) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
							" left join code_lookup on (" + ls_select_table+ ".status = code_lookup.lookup_code)" // and code_lookup.lookup_name = 'Contract Status')" -- comment by jervis -- 04.26.2011
ElseIf ls_select_field = 'contact_id' and ll_ctx_scrn_id <> 2001 Then  //Add ll_ctx_scrn_id <> 2001 -- jervis 01.28.2011
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 06.05.2007 By: Jack
	//$<reason> Fix a defect.
	If ls_lu_field = 'contact_department' Or ls_lu_field = 'contact_type' Or ls_lu_field = 'contact_id' Then
		ls_datatype = "N"
	Else
		ls_datatype = "C"
	End If
	
	If ls_lu_field = 'phone' or ls_lu_field = "ext" or ls_lu_field = "contact_email" Then
		if ls_lu_field = "contact_email" then
			ls_lu_codename = "Email"
		else
			ls_lu_codename = "Phone"
		end if
		//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),(select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and a.via = (select lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null)) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contract_contacts,ctx_contacts " + ", (" + ls_prac_sql + ") bb " + " where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "' and "
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),(select top 1 A." + ls_lu_field+ " from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and lower(code) = '" + lower(ls_lu_codename) + "' ) and a." + ls_lu_field + " is not null)) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id )"
		ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "

	Else
		//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),ctx_contacts."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contacts," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(" + Lower(ls_select_table) + "." + ls_select_field + " = ctx_contacts.contact_id) and "
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),ctx_contacts."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent +  ls_link_table + ls_link_table_on +  lower(ls_select_table) + ls_select_table_on + " left join ctx_contacts on(" + Lower(ls_select_table) + "." + ls_select_field + " = ctx_contacts.contact_id) "
		//Add other contact - jervis 03.28.2011
		if (ll_ctx_scrn_id = 6 or ll_ctx_scrn_id = 7 or ll_ctx_scrn_id = 14 or ll_ctx_scrn_id = 17) and lower(ls_select_table) = "ctx_contract_contacts" Then
			ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
		end if
	End If
	//---------------------------- APPEON END ----------------------------
	
	ls_select_field  = "ctx_contacts_" + ls_lu_field
	
elseif ll_ctx_scrn_id = 2002 and (ls_select_field = 'phone' or ls_select_field = "ext" or ls_select_field = "contact_email") then  //Add by jervis 03.28.2011
	ls_datatype = "C" 
	//,(select top 1 A." + ls_lu_field+ " from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and lower(code) = '" + lower(ls_lu_codename) + "' ) and a." + ls_lu_field + " is not null))
	ls_field_value = " convert(varchar(" + String(li_widthtemp) + "),"+ ls_select_table + "." +ls_select_field + ") "
	
	if ls_select_field = "contact_email" then
		ls_lu_codename = "Email"
	else
		ls_lu_codename = "Phone"
	end if
		
	ls_sny_retrieve = ls_sny_retrieve + ls_field_value + " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent +ls_link_table + ls_link_table_on +   Lower(ls_select_table) + ls_select_table_on
	//overwrite link other where condition
	if li_use_link = 1 and (ll_ctx_link_scrn_id = 6 or ll_ctx_link_scrn_id = 7 or ll_ctx_link_scrn_id = 14 or ll_ctx_link_scrn_id = 17) Then
		ls_other_where = " and ("+ ls_select_table + ".via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and lower(code) = '" + lower(ls_lu_codename) + "' and " + ls_select_table +  "." + ls_select_field + " is not null) and ctx_contract_contacts.ic_area = '" +ls_ic_link_area + "' ) "
	end if
ElseIf ls_select_field = 'compute_1' Then
	ls_datatype = "C"
	//---------Begin Modified by (Appeon)Harry 08.04.2014 for V142 ISG-CLX--------
	/*	
	//ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  isnull(ctx_contacts.last_name,'') + ','  + isnull(ctx_contacts.first_name,'') + case when isnull(ctx_contacts.middle_name,'') <> '' THEN ', ' + isnull(ctx_contacts.middle_name,'') else '' END field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contract_contacts,ctx_contacts " + ", (" + ls_prac_sql + ") bb " + " where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "' and "
	if lb_get_parent then
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " table_1.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id,  isnull(ctx_contacts.last_name,'') + ','  + isnull(ctx_contacts.first_name,'') + case when isnull(ctx_contacts.middle_name,'') <> '' THEN ', ' + isnull(ctx_contacts.middle_name,'') else '' END field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "')"
	ELSE
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  0 billing_address_id, isnull(ctx_contacts.last_name,'') + ','  + isnull(ctx_contacts.first_name,'') + case when isnull(ctx_contacts.middle_name,'') <> '' THEN ', ' + isnull(ctx_contacts.middle_name,'') else '' END field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								 " ctx_contract_contacts " +  " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "')"
	END IF
	*/
	if li_link = 0 then 
		ls_parent_firstcolumn = " table_1.ctx_id, "
		ls_firstcolumn = " ctx_contract_contacts.ctx_id, "
	else
		ls_parent_firstcolumn =  " ctx_prac_link.prac_id, "
		ls_firstcolumn = " ctx_prac_link.prac_id, "
	end if
	if lb_get_parent then
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + ls_parent_firstcolumn + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id,  isnull(ctx_contacts.last_name,'') + ','  + isnull(ctx_contacts.first_name,'') + case when isnull(ctx_contacts.middle_name,'') <> '' THEN ', ' + isnull(ctx_contacts.middle_name,'') else '' END field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "')"
	ELSE
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + ls_firstcolumn + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  0 billing_address_id, isnull(ctx_contacts.last_name,'') + ','  + isnull(ctx_contacts.first_name,'') + case when isnull(ctx_contacts.middle_name,'') <> '' THEN ', ' + isnull(ctx_contacts.middle_name,'') else '' END field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								 " ctx_contract_contacts " +  " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "')"
	END IF
	//---------End Modfiied ------------------------------------------------------
	ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
	ls_select_field  = "compute_1"
ElseIf ls_select_field = 'contact_phone' Then
	ls_datatype = "C"
	//---------Begin Modified by (Appeon)Harry 08.04.2014 for V142 ISG-CLX--------
	/*	
	//ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  (select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contract_contacts,ctx_contacts where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "' and "
	if lb_get_parent then
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " table_1.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id,  (select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
	else
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id, (select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								" ctx_contract_contacts  left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
	end if
	*/
	if li_link = 0 then 
		ls_parent_firstcolumn =  " table_1.ctx_id, "
		ls_firstcolumn = " ctx_contract_contacts.ctx_id, "
	else
		ls_parent_firstcolumn =  " ctx_prac_link.prac_id, "
		ls_firstcolumn = " ctx_prac_link.prac_id, "
	end if
	if lb_get_parent then
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + ls_parent_firstcolumn + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id,  (select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
	else
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + ls_firstcolumn + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id, (select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								" ctx_contract_contacts  left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
	end if
	//---------End Modfiied ------------------------------------------------------
	ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
ElseIf ls_select_field = 'contact_email' Then
	ls_datatype = "C"
	//---------Begin Modified by (Appeon)Harry 08.04.2014 for V142 ISG-CLX--------
	/*	
	If lb_get_parent Then
		//ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  (select top 1 A.contact_email from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and a.via = (select lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email' ) and a.contact_email is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contract_contacts,ctx_contacts " + ", (" + ls_prac_sql + ") bb " + " where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "' and "
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " table_1.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id,  (select top 1 A.contact_email from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email' ) and a.contact_email is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
	Else
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id,  (select top 1 A.contact_email from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email' ) and a.contact_email is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								" ctx_contract_contacts  left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
	End If
	*/
	if li_link = 0 then 
		ls_parent_firstcolumn =  " table_1.ctx_id, "
		ls_firstcolumn = " ctx_contract_contacts.ctx_id, "
	else
		ls_parent_firstcolumn =  " ctx_prac_link.prac_id, "
		ls_firstcolumn = " ctx_prac_link.prac_id, "
	end if
	If lb_get_parent Then
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + ls_parent_firstcolumn + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id,  (select top 1 A.contact_email from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email' ) and a.contact_email is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
	Else
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + ls_firstcolumn + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, 0 billing_address_id,  (select top 1 A.contact_email from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email' ) and a.contact_email is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								" ctx_contract_contacts  left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
	End If
	//---------End Modfiied ------------------------------------------------------
	ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "	
ElseIf Upper(ls_db_lookup_type)  = "C" Then //code lookup table

	ls_datatype_ctx = of_get_coltype(ids_dataobject,ls_select_field_ctx) //03.25.2011 by jervis			
	If Upper(ls_lu_field) = "LOOKUP_CODE" Then
		ls_datatype = "N"
	Else
		ls_datatype = "C"
	End If
	
	if ls_datatype_ctx = 'N' then //Non't convert - jervis 03.25.2011
		If ls_select_table <> 'app_facility' Then
			//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join code_lookup on (" + Lower(ls_select_table) + "." + ls_select_field + " = code_lookup.lookup_code) "
		Else
			//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_basic_info,code_lookup," + lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "			
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  " ctx_basic_info " + ls_select_table_on + " left join app_facility on(ctx_basic_info.app_facility = app_facility.facility_id) left join code_lookup on (" + lower(ls_select_table) + "." + ls_select_field + " = code_lookup.lookup_code) "			
		End If
	else
		If ls_select_table <> 'app_facility' Then
			//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join code_lookup on (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) "
		Else
			//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_basic_info,code_lookup," + lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "			
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  " ctx_basic_info " + ls_select_table_on + " left join app_facility on(ctx_basic_info.app_facility = app_facility.facility_id) left join code_lookup on (convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) "			
		End If
	end if
	ls_select_field  = "code_lookup_" + ls_lu_field
elseif Upper(ls_db_lookup_type) = "P" then
	ls_datatype_ctx = of_get_coltype(ids_dataobject,ls_select_field_ctx) //03.25.2011 by jervis
	//Company dddw process--jervis 12.9.2009
	ls_datatype = "C"
	if ls_datatype_ctx = 'N' then //Jervis 03.25.2011
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),app_facility."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join app_facility on(" + Lower(ls_select_table) + "." + ls_select_field + " = app_facility.facility_id) "
	else
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),app_facility."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
							ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join app_facility on(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,app_facility.facility_id)) "
	end if
	ls_select_field  = "app_facility_" + ls_lu_field
ElseIf Upper(ls_db_lookup_type)  = "A" Then //address lookup table		
	If ls_lu_field = "description"  Then
		gnv_debug.of_output(true, 'Alarm  Export:' +  "The address lookup field set for export field '" + ls_select_field + "' is improperly set" ) //added by gaivns 20120912				
		inv_message.of_MessageBox("Data Error on field " + ls_export_field,"The address lookup field set for export field '" + ls_select_field + "' is improperly set.  You cannot use description, try entity_name.  Please correct.",true)	
		Close(w_export_progress)

		if lb_ASA7 then
			ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
			EXECUTE IMMEDIATE :ls_Mysql;
		end if

		of_cleanup_ds( )
		Return 0			
	Else
		If Upper(ls_lu_field) = "LOOKUP_CODE" Then
			ls_datatype = "N"
		ElseIf Upper(ls_lu_field) = "CUSTOM_1" Or Upper(ls_lu_field) = "CUSTOM_2" Then //maha 050704 
			ls_datatype = "N"
		Else
			ls_datatype = "C"
		End If
		
		ls_bill_syn     =     ls_bill_syn + " address_lookup." + ls_lu_field + " from address_lookup," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and "
		//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),address_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from address_lookup," + lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and "				
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),address_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent +  ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join address_lookup on (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) " //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
		ls_select_field  = "address_lookup_" + ls_lu_field
	End If
Elseif ls_db_lookup_type = "X" Then//ToDo:
	
	ls_datatype = ldwc_dddw.Describe( ls_lu_field + ".coltype")
	Choose Case LeftA ( ls_datatype , 5 )
		Case "char(", "char"
			ls_datatype = "C"
		Case "date"	,"datet"	,"time", "times"
			ls_datatype = "D"
		Case "decim","numbe", "doubl", "real","long", "ulong", "int"
			ls_datatype = "N"
	End Choose
	
	//---------Begin Added by (Appeon)Harry 08.06.2015 for Bug #4649--------
	if ll_ctx_scrn_id = 51 and ( lower(ls_select_field) = 'received_by' or lower(ls_select_field) = 'doc_from_name' ) then 
		ls_field_value = " convert(varchar(" + String(li_widthtemp) + ")," + & 
									" case when "+ls_select_field+" is null then null when isnumeric("+ls_select_field+") = 1 then (SELECT top 1 " + &
									" name = last_name + ',' + first_name + (CASE WHEN middle_name IS NULL or rtrim(middle_name) = '' THEN '' ELSE ','+middle_name END) " + &
    									" FROM ctx_contacts WHERE ctx_contacts.contact_id = convert(int,"+ls_select_table+"."+ls_select_field+" ) )  else "+ls_select_field+" end " + &
										 ")"
		ls_sny_retrieve = ls_sny_retrieve + ls_field_value+ " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on 						
	elseif  ll_ctx_scrn_id = 52 and  lower(ls_select_field) = 'from_templete_id' then
		ls_field_value = " convert(varchar(" + String(li_widthtemp) + ")," + &
							 " (SELECT name FROM (" + &
							 " SELECT type = 1,id = ctx_acp_template.ctx_acp_template_id, name = ctx_acp_template.template_name  FROM ctx_acp_template " + &
							" UNION ALL " + &
							" SELECT type = 2, id = ctx_acp_document.ctx_acp_document_id,  name = ctx_acp_document.document_name  FROM ctx_acp_document ) x " + &
							" WHERE x.type = " +ls_select_table+".base_type AND x.id = " +ls_select_table+"."+ls_select_field+ &
							 "))"
		ls_sny_retrieve = ls_sny_retrieve + ls_field_value+ " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on 
	else
	//---------End Added ------------------------------------------------------
		ls_bill_syn     = ls_bill_syn + " " + ls_dddwtable + "."+ ls_dddw_column_dbname + " from " + ls_dddwtable + "," + &
								Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(" + Lower(ls_select_table) + "." + &
								ls_select_field + " = " + ls_dddwtable + "." + ls_dddwdata + ") and "
		If Upper(ls_datatype) = 'D' Then
			ls_field_value = " convert(varchar(16)," + ls_dddwtable + "."+ ls_dddw_column_dbname + ",120)"
		else
			ls_field_value = " convert(varchar(" + String(li_widthtemp) + ")," + ls_dddwtable + "."+ ls_dddw_column_dbname + ")"
		end if			
		ls_sny_retrieve = ls_sny_retrieve + ls_field_value+ " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + &
								" left join " +ls_dddwtable + " on(" + Lower(ls_select_table) + "." +	ls_select_field + " = " + ls_dddwtable + "." + ls_dddwdata + ") "
		ls_select_field  = ls_dddwtable + "_" + ls_dddw_column_dbname		
	end if
Else // NON LOOKUP FIELDS
	ls_datatype = of_get_coltype(ids_dataobject,ls_select_field_ctx) //03.17.2009 by jervis
				
	If IsNull(ls_datatype) Then MessageBox("Datatype Not Anticipated","Retrieved null datatype")
	
	If Len(ls_aggre) > 0 Then //maha 012703 for aggregate functions
		//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + ")," + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ")) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + ")," + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ")) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
								ls_syn_parent + Lower(ls_select_table) + ls_select_table_on
	Else
		if Upper(ls_datatype) = "D" then
			ls_field_value = " convert(varchar(16),"+ ls_select_table + "." +ls_select_field + ",120) "
		else
			ls_field_value = " convert(varchar(" + String(li_widthtemp) + "),"+ ls_select_table + "." +ls_select_field + ") "
		end if
		If ls_select_table <> 'app_facility' Then
			//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(16),"+ ls_select_table + "." +ls_select_field + ",120) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
			ls_sny_retrieve = ls_sny_retrieve + ls_field_value + " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent +ls_link_table + ls_link_table_on +   Lower(ls_select_table) + ls_select_table_on
		Else
			//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(16),"+ ls_select_table + "." +ls_select_field + ",120) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_basic_info," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
			ls_sny_retrieve = ls_sny_retrieve + ls_field_value + " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  " ctx_basic_info " + ls_select_table_on + " left join " + Lower(ls_select_table) + " on(ctx_basic_info.app_facility = app_facility.facility_id)"
		End If
	End If			
End If

//export_fields_use_link  sql
If li_use_link = 1 Then
	ls_use_link_sql2 = " (" + ls_linktotable + "." + ls_linktocol + " = " + ls_select_table + "." + ls_linkfromcol + ") and "
	//If Upper(ls_db_lookup_type) = "A" Or Upper(ls_db_lookup_type) = "C" Then	
	If Upper(ls_db_lookup_type) = "A" Or Upper(ls_db_lookup_type) = "C" or Upper(ls_db_lookup_type) = "X" or Upper(ls_db_lookup_type)  = 'R' Then //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
	Else
		ls_select_field = ls_select_table_trim + "_" + ls_select_field
	End If
End If

ls_bill_syn     = ls_bill_syn + ls_use_link_sql2
//ls_sny_retrieve = ls_sny_retrieve + ls_use_link_sql2//(Appeon)Toney 07.12.2013 - V141 ISG-CLX cause the sql syntax error


//---------Begin Commented by (Appeon)Harry  08.04.2014  BugS073001 in V14.2 Issues of New Features-------
/*
//add facility where
If li_facil_id > 0 Then
	Choose Case ls_select_table
		Case "pd_address"
			ls_sny_retrieve = ls_sny_retrieve + "(pd_address_link.facility_id = " + String(li_facil_id) + ") and "
		Case "pd_hosp_affil"
			ls_sny_retrieve = ls_sny_retrieve + "(pd_hosp_facility_link.facility_id = " + String(li_facil_id) + ") and "
		Case "pd_board_specialty"
			ls_sny_retrieve = ls_sny_retrieve + "(pd_spec_facility_link.facility_id = " + String(li_facil_id) + ") and "
		Case "pd_affil_stat"
			ls_sny_retrieve = ls_sny_retrieve + "(pd_affil_stat.parent_facility_id = " + String(li_facil_id) + ") and "
		Case Else
			ls_sny_retrieve = ls_sny_retrieve +  + "(" + ls_select_table + ".facility_id = " + String(li_facil_id) + ") and "
			
			
	End Choose
End If
*/
//---------End Commented ------------------------------------------------------

is_typelist[ll_FieldSeqID] = ls_datatype
is_billsynList[ll_FieldSeqID] = ls_bill_syn

If li_link = 0 Then //(Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
	If ai_type = 1 Then
		//ls_sny_retrieve = ls_sny_retrieve + ls_usetable + ".ctx_id  = bb.ctx_id "  + ls_filter
		ls_sny_retrieve = ls_sny_retrieve + ", (" + ls_prac_sql + ") bb where " + ls_ctx_table + ".ctx_id  = bb.ctx_id and bb.ctx_id > 0 "  + ls_other_where + ls_filter	//jervis 08.26.2009 add bb.ctx_id > 0
	ElseIf ai_type = 3 Then
		//ls_sny_retrieve = ls_sny_retrieve + ls_usetable + ".ctx_id " + ls_prac_ids + ls_filter
		ls_sny_retrieve = ls_sny_retrieve + " where " + ls_ctx_table + ".ctx_id " + ls_prac_ids + ls_other_where + ls_filter
	ElseIf ai_type = 2 Then
		If lb_usingdb Then
			ls_sny_retrieve = ls_sny_retrieve + " Inner Join ic_client_data on (" + ls_ctx_table + ".ctx_id = ic_client_data.data_int and ic_client_data.client_id = '"+ls_client_id+"' ) where 1 = 1 "  + ls_other_where + ls_filter
		Else
			ls_sny_retrieve = ls_sny_retrieve + " where " + ls_ctx_table + ".ctx_id  in (" + ls_prac_ids  + ")"  + ls_other_where + ls_filter
		End If
	End If
Else  //li_link = 3
	If ai_type = 1 Then
		//ls_sny_retrieve = ls_sny_retrieve + ", (" + ls_prac_sql + ") bb where " + ls_ctx_table + ".ctx_id  = bb.ctx_id and bb.ctx_id > 0 "  + ls_other_where + ls_filter	//jervis 08.26.2009 add bb.ctx_id > 0
		ls_sny_retrieve = ls_sny_retrieve + ", (" + ls_prac_sql + ") bb, ctx_prac_link where bb.prac_id = ctx_prac_link.prac_id and ctx_prac_link.ctx_id = " + ls_ctx_table + ".ctx_id and ctx_prac_link.ctx_id > 0 "  + ls_other_where + ls_filter
	ElseIf ai_type = 3 Then
		//ls_sny_retrieve = ls_sny_retrieve + " where " + ls_ctx_table + ".ctx_id " + ls_prac_ids + ls_other_where + ls_filter
		ls_sny_retrieve = ls_sny_retrieve + ", ctx_prac_link where " + ls_ctx_table + ".ctx_id = ctx_prac_link.ctx_id and ctx_prac_link.prac_id " + ls_prac_ids + ls_other_where + ls_filter
	ElseIf ai_type = 2 Then
		If lb_usingdb Then
			//ls_sny_retrieve = ls_sny_retrieve + " Inner Join ic_client_data on (" + ls_ctx_table + ".ctx_id = ic_client_data.data_int and ic_client_data.client_id = '"+ls_client_id+"' ) where 1 = 1 "  + ls_other_where + ls_filter
		Else
			//ls_sny_retrieve = ls_sny_retrieve + " where " + ls_ctx_table + ".ctx_id  in (" + ls_prac_ids  + ")"  + ls_other_where + ls_filter
			ls_sny_retrieve = ls_sny_retrieve + ", ctx_prac_link where " + ls_ctx_table + ".ctx_id = ctx_prac_link.ctx_id and ctx_prac_link.prac_id in (" + ls_prac_ids  + ")"  + ls_other_where + ls_filter
		End If
	End If
End If

//---------Begin Added by (Appeon)Harry 04.10.2014 for Bug 3998--------
if Len(ls_otherfilter) > 0 then
	ls_sny_retrieve = ls_sny_retrieve + ls_otherfilter
end if
//---------End Added ------------------------------------------------------
	
//2nd last add  - prac where
If Len(ls_aggre) > 0 Then //maha 012703 for aggregate functions
	//modify 08/15/2007 by: Andy
	//ls_sny_retrieve = ls_sny_retrieve + " Group by " + ls_ctx_table + ".ctx_id , FieldSeqID ,  field_data_type" + ls_RowNo
	If li_link = 0 Then
		ls_sny_retrieve = ls_sny_retrieve + " Group by " + ls_ctx_table + ".ctx_id , FieldSeqID , billing_address_id ,  field_data_type" + ls_RowNo
	Else
		ls_sny_retrieve = ls_sny_retrieve + " Group by " + "ctx_prac_link.prac_id , FieldSeqID, billing_address_id ,  field_data_type" + ls_RowNo
	End If
End If	

if LenA(ls_sort) > 0 and Not lb_true then//SQL2000 only 
	//ls_sny_retrieve = ls_sny_retrieve + "~r~n order by " + ls_sort 
	ls_sny_retrieve = ls_sny_retrieve + "~r~n " + ls_sort
end if

if Not lb_ASA7 then 
	ls_sny_retrieve = ls_sny_retrieve + " ) t" + String(ll_FieldSeqID)
ELSE
	ls_MySQL = "INSERT INTO " + ls_tabletemp + " ~r~n(prac_id,FieldSeqID, billing_address_id, field_value, field_data_type) ~r~n " + ls_sny_retrieve + " ;"	
	// ls_MySQL = "INSERT INTO " + ls_tabletemp + " ~r~n(prac_id,FieldSeqID, field_value, field_data_type) ~r~n " + ls_sny_retrieve + " ;" //(Appeon)Toney 07.04.2013 for V141 ISG-CLX
	EXECUTE IMMEDIATE :ls_Mysql;
	IF SQLCA.SQLCode <> 0 THEN
		inv_message.of_MessageBox("Caution on export field " + ls_export_field, SQLCA.SQLERRTEXT,TRUE)	
		close(w_export_progress)
		if lb_ASA7 then
			ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
			EXECUTE IMMEDIATE :ls_Mysql;
		end if
		of_cleanup_ds( )
		RETURN -1
	END IF
END IF
//end of add
if isnull(ls_sny_retrieve) then ls_sny_retrieve = ""

as_sny_retrieve = ls_sny_retrieve
return 1
end function

public function integer of_gensql_prac (integer ai_type, ref long ll_fieldseqid, string as_param1, string as_param2, string as_param3, ref string as_sny_retrieve, str_gensql_param astr_gensql_param);//////////////////////////////////////////////////////////////////////
// $<function>of_gensql_ctx()
// $<arguments>
//		value	integer	ai_type 	 (1: specify SQL/2: specify array/3: between...and)	
//		reference	long   	ll_fieldseqid	 
//		value	string 	as_param1    		
//		value	string 	as_param2    		
//		value	string 	as_param3
//    	reference string  as_sny_retrieve     
//    	value str_gensql_param   astr_gensql_param
// $<returns> integer
// $<description> Generate syntax of Contract Data.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
//////////////////////////////////////////////////////////////////////
String ls_dbtype
String ls_sny_retrieve
String ls_export_field
String ls_select_field
String ls_select_table
String ls_dc_field
String ls_lu_field
String ls_aggre
String ls_sort
String ls_Sortsel
String ls_text
String ls_use_link_sql
String ls_use_link_sql2
String ls_select_table_trim
String ls_field_format
String ls_filter
String ls_fld_delim
String ls_def_val
String ls_datatype
String ls_synprefix
String ls_tabletemp
String ls_prac_sql
String ls_prac_ids
String ls_rowno
String ls_use_link_sqlsyn
String ls_tablepk
String ls_top = "top 2147483647"
String ls_RowNoSyn = ""
String ls_bill_syn
String ls_db_lookup_type
String ls_Mysql

Long p
Long li_use_link
Long li_recd_no
Long ll_export_code
Long ll_intcred_field
Long li_facil_id
Long li_act_format
Long li_sub_start
Long li_billing
Long li_pos1
Long li_width
Long li_widthtemp
Long ud
Long ll_pkcnt
Long ll_n
Long ll_Rcnt

Integer li_link

Boolean lb_flagpk
Boolean lb_ASA7 = false
Boolean lb_true = false

p = astr_gensql_param.ll_rowno
ls_synprefix = astr_gensql_param.ls_synprefix
ls_tabletemp = astr_gensql_param.ls_tabletemp
li_link =  astr_gensql_param.li_link
ls_prac_sql = astr_gensql_param.ls_prac_sql
ls_prac_ids = astr_gensql_param.ls_prac_ids
ls_rowno = astr_gensql_param.ls_rowno

ls_sny_retrieve = as_sny_retrieve

ls_dbtype = of_get_dbtype()
if upper(ls_dbtype) = 'SQL2005' OR upper(ls_dbtype) = 'ASA9' THEN
	//ls_RowNo = ",Row_No"
	lb_true = true
elseif upper(ls_dbtype) = 'ASA7' then
	lb_ASA7 = true
end if

IF LeftA(upper(ls_dbType),3) = 'ASA' THEN 
	ls_top = ""
END IF

li_width = ids_export_flds.GetItemNumber(p,"export_field_length")
ls_field_format = ids_export_flds.GetItemString(p,"export_format")
ud = ids_export_flds.GetItemNumber( p, "use_default" )
IF ud = 1 Or ud = 3 Or ud = 2 THEN
	ls_def_val = ids_export_flds.GetItemString( p, "default_value" )
ELSE
	ls_def_val = ""
END IF
	
ls_export_field = ids_export_flds.GetItemString(p,"export_field_name")
is_field_headers[p] =  ls_export_field	//Start Code Change ----04.08.2013 #V12 maha
of_replacespecchar(ls_export_field)
//ls_select_field = Trim( ids_export_flds.GetItemString( p, "db_field_name" ) )
ls_select_field = Trim( ids_export_flds.GetItemString( p, "db_field_name_intellicred" ) )
ls_datatype = Trim( ids_export_flds.GetItemString(p,"db_field_type") ) //Alfee 11.13.2008		
//ls_select_table = Trim( ids_export_flds.GetItemString( p, "db_table_name" ) )
ls_select_table = Trim( ids_export_flds.GetItemString( p, "db_table_name_intellicred" ) )
li_use_link = ids_export_flds.GetItemNumber(p,"use_link")
ls_fld_delim = ids_export_flds.GetItemString( p, "trailing_leading_characters")
li_recd_no = ids_export_flds.GetItemNumber(p,"intcred_record_number")

ll_FieldSeqID ++
ll_export_code = ids_export_flds.GetItemNumber( p, "export_code" )
ls_dc_field = ids_export_flds.GetItemString( p, "dept_sect_field" )
IF IsNull(ls_dc_field) Or Trim(ls_dc_field) = '' THEN ls_dc_field = "none"
ll_intcred_field = ids_export_flds.GetItemNumber(p,"intcred_field")
li_facil_id = ids_export_flds.GetItemNumber(p,"facility_id")
ls_lu_field = ids_export_flds.GetItemString( p, "lu_field_name" )
ls_db_lookup_type = ids_export_flds.GetItemString( p, "db_lookup_type" )  //Start Code Change ----09.02.2014 #V14.2 maha - moved from below
ls_aggre = ids_export_flds.GetItemString( p, "aggre_function" )
ls_sort = ids_export_flds.GetItemString( p, "sort_by" )
ls_Sortsel = ls_sort
IF IsNull(ls_Sortsel) THEN ls_Sortsel = ''

IF LenA(Trim(ls_Sortsel)) > 0 THEN
	If li_link = 0 Then //(Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
		of_get_sortsel(ls_Sortsel,'prac_id')
	Else
		of_get_sortsel(ls_Sortsel,'ctx_id')
	End If
END IF

li_act_format = ids_export_flds.GetItemNumber(p,"export_fields_active_yesno")
ls_text = ids_export_flds.GetItemString(p,"field_value") //maha 091305
IF Upper(ls_lu_field) = "LOOKUP CODE" THEN ls_lu_field = "lookup_code"
IF IsNull(ls_lu_field) THEN ls_lu_field = "code"
ls_use_link_sql = ""
ls_use_link_sql2 = ""		
		
li_sub_start = ids_export_flds.GetItemNumber(p,"export_fields_substring_start") //maha 010306
IF PosA(ls_select_table,"dba.",1) > 0 THEN //maha 122005 
	ls_select_table_trim = MidA(ls_select_table,5) //dropping dba.
	ls_select_table = ls_select_table_trim //maha 012306
ELSE
	ls_select_table_trim = ls_select_table
END IF
ls_filter = ids_export_flds.GetItemString(p,"filter_query")
li_billing = ids_export_flds.GetItemNumber(p,"billing_link") //maha app080205
//Start Code Change ----08.29.2014 #V14.2 maha = create billing address fields
if li_billing = 1 then
	is_billing_fields[upperbound(is_billing_fields) + 1] = ls_select_field
	end if
//End Code Change ----08.29.2014

IF IsNull(li_facil_id) THEN li_facil_id = 0
IF IsNull(ls_filter) Or ls_filter = "" THEN
	ls_filter = ""
ELSE
	ls_filter = " and  ( " + ls_filter + " )"
	//Long li_pos1
	li_pos1 = PosA(Upper(ls_filter),"PROMPT1",1)
	IF li_pos1 > 0 THEN
		ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param1 + MidA(ls_filter,li_pos1 + 7)
	END IF
	li_pos1 = PosA(Upper(ls_filter),"PROMPT2",1)
	IF li_pos1 > 0 THEN
		ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param2 + MidA(ls_filter,li_pos1 + 7)
	END IF
	li_pos1 = PosA(Upper(ls_filter),"PROMPT3",1)
	IF li_pos1 > 0 THEN
		ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param3 + MidA(ls_filter,li_pos1 + 7)
	END IF
END IF		

/*
//set record delimiter/pad maha 060105
CHOOSE CASE ls_rec_delim
	CASE "R" //return
		ls_rec_delim = "~r"
	CASE "T" //tab
		ls_rec_delim = "	"
	CASE "D" //double return
		ls_rec_delim = "~r~n"
	CASE "S" // space
		ls_rec_delim = " "
	CASE "E" //empty string
		ls_rec_delim = ""
END CHOOSE
IF ls_format = ".csv" THEN ls_rec_delim = "," 	//maha 121205 //overwrite field delim if is a CSV file
*/

//export_fields_use_link  sql
IF li_use_link = 1 THEN
	CHOOSE CASE ls_select_table
		CASE "pd_address"
			ls_use_link_sql = ",pd_address_link"
		CASE "pd_hosp_affil"
			ls_use_link_sql = ",pd_hosp_facility_link"
		CASE "pd_board_specialty"
			ls_use_link_sql = ",pd_spec_facility_link"
		CASE ELSE
			ls_use_link_sql = ""
	END CHOOSE
END IF

is_tablelist[ll_FieldSeqID] = ls_select_table
is_fieldlist[ll_FieldSeqID] = ls_export_field
ii_recdnoList[ll_FieldSeqID] = li_recd_no
is_selectfieldlist[ll_FieldSeqID] = ls_select_field
is_lu_selectfieldlist[ll_FieldSeqID] = ls_select_field  //(Appeon)Stephen 09.05.2014 
is_lu_typelist[ll_FieldSeqID] = ls_datatype  //(Appeon)Stephen 09.05.2014 
is_typelist[ll_FieldSeqID] = ls_datatype //Alfee 11.13.2008		
ii_billingList[ll_FieldSeqID] = li_billing //Alfee 11.13.2008		
is_formatList[ll_FieldSeqID] = ls_field_format
il_exportcodeList[ll_FieldSeqID] = ll_export_code
is_dcfieldList[ll_FieldSeqID] = ls_dc_field
il_intcredfieldList[ll_FieldSeqID] = ll_intcred_field
ii_substartList[ll_FieldSeqID] = li_sub_start
ii_widthList[ll_FieldSeqID] = li_width
li_widthtemp = li_width
//---------Begin Modified by (Appeon)Stephen 12.07.2015 for Export data column issues--------
//if li_widthtemp < 30 then li_widthtemp = 30
if li_widthtemp < 1 then li_widthtemp = 30
//---------End Modfiied ------------------------------------------------------
is_flddelimList[ll_FieldSeqID] = ls_fld_delim
ii_udList[ll_FieldSeqID] = ud
is_defvalList[ll_FieldSeqID] = ls_def_val
is_textList[ll_FieldSeqID] = ls_text
is_lu_fieldList[ll_FieldSeqID] = ls_lu_field //(Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
is_lu_type[ll_FieldSeqID] = ls_db_lookup_type  //Start Code Change ----09.02.2014 #V14.2 maha
ii_facil_idList[ll_FieldSeqID] = li_facil_id
ii_act_formatList[ll_FieldSeqID] = li_act_format
//---------Begin Added by (Appeon)Harry 02.27.2015 for Bug # 4430--------
String ls_islookup
if pos(",A,C,F,D,G,", "," + ls_db_lookup_type + ",") > 0 then
	ls_islookup = 'Y'
else
	ls_islookup = 'N'
end if
is_lookup[ll_FieldSeqID] = ls_islookup
//---------End Added ------------------------------------------------------

ls_use_link_sqlsyn = ls_use_link_sql
IF ai_type = 1 THEN
	ls_use_link_sql = ls_use_link_sql + ", (" + ls_prac_sql + ") bb "
END IF

ls_tablepk = ""
IF IsNull(ls_sort) Or Trim(ls_sort) = "" THEN
	ls_sort = ""
	lb_flagpk = True
	ll_pkcnt = UpperBound(is_table)
	FOR ll_n = 1 To ll_pkcnt
		IF Lower(ls_select_table) = Lower(is_table[ll_n]) THEN
			ls_tablepk = is_tablepks[ll_n]
			ls_sort = is_sortpk[ll_n]
			lb_flagpk = False
		END IF
	NEXT
	IF lb_flagpk THEN
		ll_Rcnt = ids_tablepk.Retrieve( ls_select_table)
		ls_sort = ls_select_table + '.prac_id, '
		FOR ll_n = 1 To ll_Rcnt
			IF Lower(ids_tablepk.GetItemString( ll_n, "column_name")) = 'prac_id' THEN
				CONTINUE
			END IF
			ls_tablepk += ls_select_table + '.' + ids_tablepk.GetItemString( ll_n, "column_name") + ", "
		NEXT
		ls_sort = ls_sort + ls_tablepk
		ls_sort  = LeftA(ls_sort,LenA(ls_sort) - 2)
		is_sortpk[ll_pkcnt + 1] = ls_sort
		is_table[ll_pkcnt+1] = ls_select_table
		is_tablepks[ll_pkcnt+1] = ls_tablepk
	END IF
ELSE
	IF PosA(Lower(ls_sort),'prac_id') < 1 THEN ls_sort = ls_select_table + '.prac_id, ' + ls_sort
END IF

IF lb_ASA7 THEN
	ls_tablepk = ""
	ls_Sortsel = "" 
END IF

IF LenA(ls_aggre) > 0 THEN
	ls_sort = ls_sort + " , field_value"
END IF
IF LenA(ls_sort) > 0 THEN ls_sort = "order by " + ls_sort

IF lb_true THEN //SQL2005 and ASA9
	ls_RowNoSyn = ",row_number() over(" + ls_sort+") Row_No"
END IF

ls_bill_syn     = "Select " + Lower(ls_select_table) + ".prac_id, "

If li_link = 0 Then //(Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
	ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " " + Lower(ls_select_table) + ".prac_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, "
Else
	ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_prac_link.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, "	
End If
IF ls_select_table = "pd_address" And li_billing = 1 THEN //maha app080205
	ls_bill_syn     = ls_bill_syn + " billing_address_id, "
	ls_sny_retrieve = ls_sny_retrieve + " billing_address_id, "
ELSE
	ls_sny_retrieve = ls_sny_retrieve + " 0 billing_address_id, "
END IF

//ls_db_lookup_type = ids_export_flds.GetItemString( p, "db_lookup_type" )  //Start Code Change ----09.02.2014 #V14.2 maha - moved up

if li_link = 1 then ls_use_link_sql = ls_use_link_sql + ", ctx_prac_link"

IF ls_select_field = "affiliation_status" THEN // setting lookup field and where
	ls_datatype = "C"
	//ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + " from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and "
	//---------Begin Modified by (Appeon)Harry 07.07.2016 for  Export filter/sort/record# inaccuracy when using code lookup fields--------
	/*
	ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + ",address_id =address_id from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and " //Nova 03.26.2010
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and "
	*/
	ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + ",address_id =address_id from code_lookup  right outer join " + lower(ls_select_table) +  " on (convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' "  +  ls_use_link_sqlsyn + " WHERE 1=1 and " //Nova 03.26.2010
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup right outer join " + Lower(ls_select_table) +  " on (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' " +  ls_use_link_sql + " WHERE 1=1 and "
	//---------End Modfiied ------------------------------------------------------
	ls_select_field  = "code_lookup_" + ls_lu_field
ELSEIF Upper(ls_db_lookup_type)  = "C" THEN //code lookup table
	IF Upper(ls_lu_field) = "LOOKUP_CODE" THEN
		ls_datatype = "N"
	ELSE
		ls_datatype = "C"
	END IF
	//ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + " from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "
	//---------Begin Modified by (Appeon)Harry 07.07.2016 for  Export filter/sort/record# inaccuracy when using code lookup fields--------
	/*
	ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + ",address_id =address_id from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and " //Nova 03.26.2010			
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "
	*/
	ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + ",address_id =address_id from code_lookup right outer join " + lower(ls_select_table) + " on (convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) " +  ls_use_link_sqlsyn + " WHERE 1=1 and " //Nova 03.26.2010			
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup right outer join " + Lower(ls_select_table) + " on (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code))" +  ls_use_link_sql + " WHERE 1=1 and "
	//---------End Modfiied ------------------------------------------------------
	ls_select_field  = "code_lookup_" + ls_lu_field
ELSEIF Upper(ls_db_lookup_type)  = "A" THEN //address lookup table
	IF ls_lu_field = "description"  THEN
		inv_message.of_MessageBox("Data Error on field " + ls_export_field,"The address lookup field set for export field '" + ls_select_field + "' is improperly set.  You cannot use description, try entity_name.  Please correct.",true)	
		Close(w_export_progress)
		IF lb_ASA7 THEN
			ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
			EXECUTE Immediate :ls_MySQL;
		END IF
		of_cleanup_ds( )
		RETURN 0
	ELSE
		IF Upper(ls_lu_field) = "LOOKUP_CODE" THEN
			ls_datatype = "N"
		ELSEIF Upper(ls_lu_field) = "CUSTOM_1" Or Upper(ls_lu_field) = "CUSTOM_2" THEN //maha 050704 
			ls_datatype = "N"
		ELSE
			ls_datatype = "C"
		END IF
		//ls_bill_syn     = ls_bill_syn + " address_lookup." + ls_lu_field + " from address_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and "
		
		//---------Begin Modified by (Appeon)Harry 07.07.2016 for  Export filter/sort/record# inaccuracy when using code lookup fields--------
		/*
		ls_bill_syn     = ls_bill_syn + " address_lookup." + ls_lu_field + ",address_id =address_id from address_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and " //Nova 03.26.2010
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),address_lookup." + ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from address_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and "
		*/
		ls_bill_syn     = ls_bill_syn + " address_lookup." + ls_lu_field + ",address_id =address_id from address_lookup  right outer join " + lower(ls_select_table) + " on (convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) " +  ls_use_link_sqlsyn + " WHERE 1=1 and " //Nova 03.26.2010
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),address_lookup." + ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from address_lookup  right outer join " + Lower(ls_select_table) + " on (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) " +  ls_use_link_sql + " WHERE 1=1 and "
		//---------End Modfiied ------------------------------------------------------
		ls_select_field  = "address_lookup_" + ls_lu_field
	END IF
ELSEIF Upper(ls_db_lookup_type)  = "F" THEN //facility table
	IF Upper(ls_lu_field) = "FACILITY_ID" Or Upper(ls_lu_field) = "RETURN_ZIP" THEN
		ls_datatype = "N"
	ELSE
		ls_datatype = "C"
	END IF
	//ls_bill_syn     = ls_bill_syn + " facility." + ls_lu_field + " from facility," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,facility.facility_id)) and "
	ls_bill_syn     = ls_bill_syn + " facility." + ls_lu_field + ",address_id =address_id from facility," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,facility.facility_id)) and " //Nova 03.26.2010
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),facility." + ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from facility," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,facility.facility_id)) and "
	ls_select_field  = "facility_" + ls_lu_field
//--------Begin Added by Nova 10.30.2009------------------------
//Privilege export functionality - modified by alfee 01.26.2010
ELSEIF Upper(ls_db_lookup_type)  = "D" THEN //DDDW lookup type
	IF lower(ls_select_table) = 'pd_priv_list' AND lower(ls_select_field) = "clinical_area_id" THEN
		ls_datatype = "C"
		IF ls_lu_field = "Dept Code" THEN						
			ls_bill_syn     = ls_bill_syn + " priv_clinical_area." + "clinical_area_code" + " from priv_clinical_area," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_clinical_area.clinical_area_id)) and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_clinical_area." + "clinical_area_code" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_clinical_area," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_clinical_area.clinical_area_id)) and "
			ls_select_field  = "priv_clinical_area_" + "clinical_area_code"
		ELSE
			ls_bill_syn     = ls_bill_syn + " priv_clinical_area." + "clinical_area_description" + " from priv_clinical_area," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_clinical_area.clinical_area_id)) and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_clinical_area." + "clinical_area_description" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_clinical_area," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_clinical_area.clinical_area_id)) and "
			ls_select_field  = "priv_clinical_area_" + "clinical_area_description"
		END IF
	ELSEIF lower(ls_select_table) = 'pd_priv_list' AND lower(ls_select_field) = "priv_core_id" THEN			
		ls_datatype = "C"
		IF ls_lu_field = "Section" THEN
			ls_bill_syn     = ls_bill_syn + " priv_core." + "priv_core_description" + " from priv_core," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core.priv_core_id)) and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_core." + "priv_core_description" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_core," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core.priv_core_id)) and "
			ls_select_field  = "priv_core_" + "priv_core_description"
		END IF					
	ELSEIF lower(ls_select_table) = 'pd_priv_list' AND lower(ls_select_field) = "procd_id" THEN						
		ls_datatype = "C"
		IF ls_lu_field = "Procedure Code" THEN						
			ls_bill_syn     = ls_bill_syn + " priv_core_procd." + "procd_name" + " from priv_core_procd," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core_procd.procd_id)) and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_core_procd." + "procd_name" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_core_procd," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core_procd.procd_id)) and "
			ls_select_field  = "priv_core_procd_" + "procd_name"
		ELSE
			ls_bill_syn     = ls_bill_syn + " priv_core_procd." + "core_procd_description" + " from priv_core_procd," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core_procd.procd_id)) and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_core_procd." + "core_procd_description" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_core_procd," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core_procd.procd_id)) and "
			ls_select_field  = "priv_core_procd_" + "core_procd_description"
		END IF	
	ELSEIF lower(ls_select_table) = 'pd_comm_review' AND lower(ls_select_field) = "meeting_id"  THEN	//added by long.zhang 01.21.2013 
		ls_datatype = "C"
		IF ls_lu_field = "Meeting Subject" THEN
			ls_bill_syn     = ls_bill_syn + " meetings." + "subject" + " from meetings right outer join " + Lower(ls_select_table) +" on  (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,meetings.meeting_id))" +  ls_use_link_sqlsyn+" where 1=1 and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),meetings." + "subject" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from meetings right outer join " + Lower(ls_select_table) +   " on " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,meetings.meeting_id)) "+ls_use_link_sql + " WHERE 1=1 and "
			ls_select_field  = "meetings_" + "subject"
		else
			ls_datatype = "N"
			ls_bill_syn     = ls_bill_syn + " meetings." + "meeting_id" + " from meetings right outer join " + Lower(ls_select_table) +" on  (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,meetings.meeting_id))" +  ls_use_link_sqlsyn+" where 1=1 and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),meetings." + "meeting_id" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from meetings right outer join " + Lower(ls_select_table) +   " on " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,meetings.meeting_id)) "+ls_use_link_sql + " WHERE 1=1 and "
			ls_select_field  = "meetings_" + "meeting_id"
		END IF
	ELSEIF lower(ls_select_table) = 'pd_comm_review' AND lower(ls_select_field) = "committee_id"  THEN	//added by long.zhang 01.21.2013 
		ls_datatype = "C"
		IF ls_lu_field = "Committee Name" THEN
			ls_bill_syn     = ls_bill_syn + " committee_lookup." + "committee_name" + " from committee_lookup right outer join " + Lower(ls_select_table) +" on  (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,committee_lookup.committee_id))" +  ls_use_link_sqlsyn+" where 1=1 and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),committee_lookup." + "committee_name" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from committee_lookup right outer join " + Lower(ls_select_table) +   " on " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,committee_lookup.committee_id)) "+ls_use_link_sql + " WHERE 1=1 and "
			ls_select_field  = "committee_lookup_" + "committee_name"
		else
			ls_datatype = "N"
			ls_bill_syn     = ls_bill_syn + " committee_lookup." + "committee_id" + " from committee_lookup right outer join " + Lower(ls_select_table) +" on  (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,committee_lookup.committee_id))" +  ls_use_link_sqlsyn+" where 1=1 and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),committee_lookup." + "committee_id" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from committee_lookup right outer join " + Lower(ls_select_table) +   " on " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,committee_lookup.committee_id)) "+ls_use_link_sql + " WHERE 1=1 and "
			ls_select_field  = "committee_lookup_" + "committee_id"
		END IF	
	END IF
//--------End Added --------------------------------------------
//Start Code Change ----08.20.2012 #V12 maha added support for the standing lookup table
ELSEIF Upper(ls_db_lookup_type)  = "G" THEN //standing lookup for flags

	IF Upper(ls_lu_field) = "DISPLAY_VALUE" THEN
		ls_datatype = "C"
	ELSE
		ls_datatype = "N"
	END IF
	//ls_bill_syn     = ls_bill_syn + " standing_lookup." + ls_lu_field + ", lu_id =lu_id from standing_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,standing_lookup.lu_id) and "
	//---------Begin Modified by (Appeon)Harry 07.07.2016 for  Export filter/sort/record# inaccuracy when using code lookup fields--------
	//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),standing_lookup." + ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from standing_lookup," + Lower(ls_select_table) +  ls_use_link_sql +  " WHERE " + " convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar, standing_lookup.lu_id) and "
	ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),standing_lookup." + ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from standing_lookup right outer join " + Lower(ls_select_table) + " on convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar, standing_lookup.lu_id) " +  ls_use_link_sql +  " WHERE 1=1 and "
	//---------End Modfiied ------------------------------------------------------
	ls_select_field  = "standing_lookup_" + ls_lu_field
	
//End Code Change ----08.20.2012 
ELSE // NON LOOKUP FIELDS
	ls_datatype = ids_export_flds.GetItemString(p,"db_field_type")
	IF LenA(ls_aggre) > 0 THEN //maha 012703 for aggregate functions still not being used as of 12-05 
		//ls_bill_syn     = ls_bill_syn + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ") a" + ls_aggre + " from " + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " 
		ls_bill_syn     = ls_bill_syn + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ") a" + ls_aggre + ",address_id =address_id from " + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE "  //Nova 03.26.2010				
		ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + ")," + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ")) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
	ELSE
		//ls_bill_syn     = ls_bill_syn + ls_select_table + "." +ls_select_field + " from " + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " 	
		ls_bill_syn     = ls_bill_syn + ls_select_table + "." +ls_select_field + ",address_id =address_id from " + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " //Nova 03.26.2010	
		IF Upper(ls_datatype) = 'D' THEN
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(16)," + ls_select_table + "." +ls_select_field + ",120) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
		ELSE
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + ")," + ls_select_table + "." +ls_select_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
		END IF
	END IF
END IF
is_selectfieldlist[ll_FieldSeqID] = ls_select_field //Alfee 11.13.2008
is_typelist[ll_FieldSeqID] = ls_datatype //Alfee 11.13.200

//export_fields_use_link  sql
IF li_use_link = 1 THEN
	CHOOSE CASE ls_select_table
		CASE "pd_address"
			ls_use_link_sql2 = " (pd_address.rec_id = pd_address_link.address_id) and "
		CASE "pd_hosp_affil"
			ls_use_link_sql2 = " (pd_hosp_Affil.rec_id = pd_hosp_facility_link.hosp_affil_id) and "
		CASE "pd_board_specialty"
			ls_use_link_sql2 = " (pd_board_specialty.rec_id = pd_spec_facility_link.specialty_id) and "
		CASE ELSE
			ls_use_link_sql2 = ""
	END CHOOSE
END IF

ls_bill_syn     = ls_bill_syn + ls_use_link_sql2
ls_sny_retrieve = ls_sny_retrieve + ls_use_link_sql2

//add facility where
IF li_facil_id > 0 THEN
	CHOOSE CASE ls_select_table
		CASE "pd_address"
			IF li_use_link = 1 THEN //<add> 07/16/2007 by: Andy Reason:BugG062904
				ls_bill_syn     = ls_bill_syn + "(pd_address_link.facility_id = " + String(li_facil_id) + ") and "
				ls_sny_retrieve = ls_sny_retrieve + "(pd_address_link.facility_id = " + String(li_facil_id) + ") and "
			END IF
		CASE "pd_hosp_affil"
			IF li_use_link = 1 THEN //<add> 07/16/2007 by: Andy Reason:BugG062904
				ls_bill_syn     = ls_bill_syn + "(pd_hosp_facility_link.facility_id = " + String(li_facil_id) + ") and "
				ls_sny_retrieve = ls_sny_retrieve + "(pd_hosp_facility_link.facility_id = " + String(li_facil_id) + ") and "
			END IF
		CASE "pd_board_specialty"
			IF li_use_link = 1 THEN //<add> 07/16/2007 by: Andy Reason:BugG062904
				ls_bill_syn     = ls_bill_syn + "(pd_spec_facility_link.facility_id = " + String(li_facil_id) + ") and "
				ls_sny_retrieve = ls_sny_retrieve + "(pd_spec_facility_link.facility_id = " + String(li_facil_id) + ") and "
			END IF
		CASE "pd_affil_stat"
			ls_bill_syn     = ls_bill_syn + "(pd_affil_stat.parent_facility_id = " + String(li_facil_id) + ") and "
			ls_sny_retrieve = ls_sny_retrieve + "(pd_affil_stat.parent_facility_id = " + String(li_facil_id) + ") and "
		CASE ELSE
			ls_bill_syn     = ls_bill_syn +  + "(" + ls_select_table + ".facility_id = " + String(li_facil_id) + ") and "
			ls_sny_retrieve = ls_sny_retrieve +  + "(" + ls_select_table + ".facility_id = " + String(li_facil_id) + ") and "
			
	END CHOOSE
END IF		

//3rd last add  - prac where
//ls_bill_syn = ls_sny_retrieve //maha app080205
is_billsynList[ll_FieldSeqID] = ls_bill_syn
If li_link = 0 Then
	IF ai_type = 1 THEN
		ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id  = bb.prac_id "  + ls_filter
	ELSEIF ai_type = 3 THEN
		ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id " + ls_prac_ids + ls_filter
	ELSEIF ai_type = 2 THEN
		ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id  in (" + ls_prac_ids  + ")"  + ls_filter			
	END IF
Else
	IF ai_type = 1 THEN
		//ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id  = bb.prac_id "  + ls_filter
		ls_sny_retrieve = ls_sny_retrieve + "bb.ctx_id = ctx_prac_link.ctx_id and ctx_prac_link.prac_id = " +  Lower(ls_select_table) + ".prac_id " + ls_filter
	ELSEIF ai_type = 3 THEN
		//ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id " + ls_prac_ids + ls_filter
		ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id = ctx_prac_link.prac_id and ctx_prac_link.ctx_id " + ls_prac_ids + ls_filter
	ELSEIF ai_type = 2 THEN
		//ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id  in (" + ls_prac_ids  + ")"  + ls_filter			
		ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id = ctx_prac_link.prac_id and ctx_prac_link.ctx_id in (" + ls_prac_ids  + ")"  + ls_filter			
	END IF
End If
		
IF LenA(ls_aggre) > 0 THEN //maha 012703 for aggregate functions
	IF li_link = 0 THEN  //(Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
		ls_sny_retrieve = ls_sny_retrieve + " Group by " + Lower(ls_select_table) + ".prac_id, FieldSeqID, billing_address_id, field_data_type" + ls_RowNo
	ELSE
		ls_sny_retrieve = ls_sny_retrieve + " Group by " +  "ctx_prac_link.ctx_id, FieldSeqID, billing_address_id, field_data_type" + ls_RowNo
	END IF
END IF
IF LenA(ls_sort) > 0 And Not lb_true THEN //SQL2000 only  
	ls_sny_retrieve = ls_sny_retrieve + "~r~n " + ls_sort
END IF

IF Not lb_ASA7 THEN
	ls_sny_retrieve = ls_sny_retrieve + " ) t" + String(ll_FieldSeqID)
ELSE
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	ls_MySQL = "INSERT INTO " + ls_tabletemp + " ~r~n(prac_id,FieldSeqID, billing_address_id, field_value, field_data_type) ~r~n " + ls_sny_retrieve + " ;"
	EXECUTE Immediate :ls_MySQL;
	IF SQLCA.SQLCode <> 0 THEN
		inv_message.of_MessageBox("Caution on export field (insert) " + ls_export_field, SQLCA.SQLErrText,true)	
		Close(w_export_progress)
		IF lb_ASA7 THEN
			ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
			EXECUTE Immediate :ls_MySQL;
		END IF
		of_cleanup_ds( )
		RETURN -1
	END IF
END IF

if isnull(ls_sny_retrieve) then ls_sny_retrieve = ""

as_sny_retrieve = ls_sny_retrieve
Return 1
end function

public function integer of_create_export_ds (string as_unionsql, string as_tabletemp, string as_rowno, long al_maxwidth, string as_type);//////////////////////////////////////////////////////////////////////
// $<function>of_create_export_ds()
// $<arguments>
//		value	string		as_UnionSQL 		
//		value	string   	as_tabletemp		
//		value	string 	as_RowNo      		 
//    	value long	  	al_maxwidth
//		value	string 	as_type (ctx_id/prac_id)    		
// $<returns> integer
// $<description> Create datastore ids_export_retrieve.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
//////////////////////////////////////////////////////////////////////
String ls_UnionSQL
String ls_tabletemp
String ls_RowNo
String ls_Mysql
String ls_dbtype
String ls_presentation_str 
String Errors
String ls_dwsyntax_str
String ls_SqlSelect
String ls_UnionSQL_trail = '' //Added by Appeon long.zhang 09.26.2016
String ls_SQLs[]
String ls_SQL_execute

Long ll_maxwidth
Long w
Long ll_ret_cnt
Long ll_sql_cnt
Long i

Boolean lb_true = false
Boolean lb_ASA7 = false

n_cst_string lnv_string
n_ds lds_export_retrieve_tmp


CONSTANT INT MAXCOLS = 40
	
if Len(as_UnionSQL) <= 0 then RETURN 1

ls_UnionSQL = as_UnionSQL
ls_tabletemp = as_tabletemp
ls_RowNo = as_RowNo
ll_maxwidth = al_maxwidth
ls_presentation_str = "style(type=grid)"

ls_dbtype = of_get_dbtype()
if upper(ls_dbtype) = 'SQL2005' OR upper(ls_dbtype) = 'ASA9' THEN
	lb_true = true
elseif upper(ls_dbtype) = 'ASA7' then
	lb_ASA7 = true
end if

if lb_true THEN//SQL2005 and ASA9

	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 09.26.2016
	//<$>reason:Split to shorted SQLs. (at most 40 columns in a SQL )  For Bug id 5309 - Auto Scheduler is returning an error SaaS V14.2 Build date 05022016.
	
	//	//ls_UnionSQL = ls_UnionSQL + "~r~n order by " + "FieldSeqID, ctx_id , Row_No"
	//	ls_UnionSQL = ls_UnionSQL + "~r~n order by " + "FieldSeqID, " + as_type + " , Row_No"
	//	if as_type = "prac_id" and of_get_app_setting("set_31","I") = 100 then //Start Code Change ----05.26.2010 #V10 maha - Inova sql v2000 option
	//		ls_UnionSQL = ls_UnionSQL + " option(maxdop 1) "
	//	end if

	ls_UnionSQL_trail =  "~r~n order by " + "FieldSeqID, " + as_type + " , Row_No"
	if as_type = "prac_id" and of_get_app_setting("set_31","I") = 100 then
		ls_UnionSQL_trail = ls_UnionSQL_trail + " option(maxdop 1) "
	end if
	//------------------- APPEON END -------------------	

end if

if lb_true then ls_RowNo = ", 0 Row_No"//SQL2005 AND ASA9
if lb_ASA7 then
	ls_SqlSelect = "Select prac_id,FieldSeqID,billing_address_id,field_value,field_data_type from " + ls_tabletemp
else
	ls_SqlSelect = "Select top 1 0 prac_id, 1 FieldSeqID, 0 billing_address_id,  cast('' as varchar(" + String(ll_maxwidth) + ")) field_value,  ' ' field_data_type" + ls_RowNo + " from pd_basic"
end if			


ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_SqlSelect, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN
	gnv_debug.of_output(true, 'Alarm  Export:' +  "SyntaxFromSQL caused these errors: " + Errors + "~r~r" + ls_SqlSelect  ) //added by gaivns 20120912		

	inv_message.of_MessageBox("Caution on export field ","SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_SqlSelect,TRUE)	
	close(w_export_progress)
	if lb_ASA7 then
		ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
		EXECUTE IMMEDIATE :ls_Mysql;
	end if
	of_cleanup_ds( )
	RETURN -1
END IF

w = ids_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
if w < 1 then
	gnv_debug.of_output(true, 'Alarm  Export:' +  "lds_export_retrieve create  errors: " + Errors  + '~r' + ls_SqlSelect   ) //added by gaivns 20120912		
	inv_message.of_MessageBox("Error on Create",errors,TRUE)	
	close(w_export_progress)
	if lb_ASA7 then
		ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
		EXECUTE IMMEDIATE :ls_Mysql;
	end if
	of_cleanup_ds( )
	return -1
end if

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 09.26.2016
//<$>reason:Split a long SQL to shorted SQLs. (at most 40 columns in a SQL )  For Bug id 5309 - Auto Scheduler is returning an error SaaS V14.2 Build date 05022016.

//if Not lb_ASA7 then ids_export_retrieve.Modify('DataWindow.Table.Select="' + ls_UnionSQL + '"')
//	ids_export_retrieve.SetTransObject( SQLCA )
//	ll_ret_cnt = ids_export_retrieve.retrieve()
if Not lb_ASA7 then //Retrieve multi-times
	ll_sql_cnt = lnv_string.of_parsetoarray( ls_UnionSQL, ' union all ', ls_SQLs[])
	
	yield()
	
	If ll_sql_cnt <= MAXCOLS Then
		ls_UnionSQL += ls_UnionSQL_trail
		ids_export_retrieve.Modify('DataWindow.Table.Select="' + ls_UnionSQL + '"')
		ids_export_retrieve.SetTransObject( SQLCA )
		ll_ret_cnt = ids_export_retrieve.retrieve()
	Else // >40 columns
		//Append rows on this datastore
		lds_export_retrieve_tmp = Create n_ds
		lds_export_retrieve_tmp.Create( ls_dwsyntax_str, ERRORS)
		
		For i = 1 to ll_sql_cnt			
			//Create new sql
			If Mod(i, MAXCOLS) = 0 or (i = ll_sql_cnt) Then //every 40 sqls or the last sql.
				ls_SQL_execute += ls_SQLs[i] + ls_UnionSQL_trail
							
				lds_export_retrieve_tmp.Modify('DataWindow.Table.Select="' + ls_SQL_execute + '"')
				lds_export_retrieve_tmp.SetTransObject( SQLCA )
				ll_ret_cnt = lds_export_retrieve_tmp.retrieve()	
				if ll_Ret_Cnt < 0 then	
					Destroy lds_export_retrieve_tmp
					Exit
				End If
				
				//Copy data to ids_export_retrieve
				lds_export_retrieve_tmp.RowsCopy ( 1, lds_export_retrieve_tmp.rowcount() , Primary!,&
					ids_export_retrieve , ids_export_retrieve.RowCount() + 1, Primary! )

				ls_SQL_execute = ''
			Else
				ls_SQL_execute += ls_SQLs[i] + ' union all '	
			End If
		Next
		
		Destroy lds_export_retrieve_tmp
		ls_UnionSQL = ls_SQL_execute
	End If
Else
	ids_export_retrieve.SetTransObject( SQLCA )
	ll_ret_cnt = ids_export_retrieve.retrieve()
End If
//------------------- APPEON END -------------------


if ll_Ret_Cnt < 0 then		
	gnv_debug.of_output(true, 'Alarm  Export:' +  "lds_export_retrieve retrieve<0 " + '~r' + ls_UnionSQL  ) //added by gaivns 20120912
	//Reason:check syntax
	ls_presentation_str = "style(type=grid)"
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_UnionSQL, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		gnv_debug.of_output(true,"Caution on export:" + "SyntaxFromSQL caused these errors: " + Errors)			//Added By Mark Lee 02/01/2013			
		 inv_message.of_MessageBox("Caution on export" , "SyntaxFromSQL caused these errors: " + ERRORS + '~r~nSQL~r~n' + ls_UnionSQL,true)	
	Else
		inv_message.of_MessageBox("Caution on export","lds_export_retrieve retrieve<0 " + '~r' + ls_UnionSQL,true) //Added by Appeon long.zhang 09.28.2016 (Bug id 5309 - Auto Scheduler is returning an error SaaS V14.2 Build date 05022016)
	END IF //Moved here for Alleghany export issue - alfee 04.17.2015			
	
		close(w_export_progress)

		if lb_ASA7 then
			ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
			EXECUTE IMMEDIATE :ls_Mysql;
		end if

		of_cleanup_ds( )
		RETURN -1
	//END IF	- Commented by alfee 04.17.2015	
end if
	
RETURN 1
end function

public function integer of_cleanup_ds (boolean ab_flag);//(Appeon)Harry 07.23.2014 - for BugH072301

//Start Code Change ----04.17.2009 #V92 maha - completed
if IsValid(ids_export_flds) then destroy ids_export_flds
if IsValid(ids_export_hdr) then destroy ids_export_hdr
if IsValid(ids_address_lookup) then destroy ids_address_lookup
if IsValid(ids_code_lookup) then destroy ids_code_lookup

if ab_flag then
	if IsValid(ids_export_data) then destroy ids_export_data
end if

if IsValid(ids_dept_chair) then destroy ids_dept_chair
if IsValid(ids_field) then Destroy ids_field
if IsValid(ids_export_dataTemp) then Destroy ids_export_dataTemp
if IsValid(ids_export_equiv_code) then Destroy ids_export_equiv_code
if IsValid(ids_tablepk) then Destroy ids_tablepk

//---------Begin Added by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
if IsValid(ids_dataobject) then Destroy ids_dataobject
if IsValid(ids_linkto) then Destroy ids_linkto
//---------End Added ------------------------------------------------------

if IsValid(ids_billing) then Destroy ids_billing  //Start Code Change ----08.29.2014 #V14.2 maha

return 1
end function

public function integer of_export_data_with_text_backup (integer ai_export_id, long al_prac_ids[], ref string as_path, integer ai_save_data, string as_param1, string as_param2, string as_param3, integer ai_type, string as_sql);//function built by maha 07-2002
//<optimization> by Andy 07/05/2007 - 07/11/2007
// $<arguments>
//value integer  ai_save_data (0:Nothing / 1:save / 2:preview / 3:save & preview)
//value integer  ai_type      (1: specify SQL/2: specify array/3: between...and)
//value string   as_sql       (the specified SQL)


SetPointer( HourGlass! )
IF IsNull(as_path) Or as_path = "" THEN
	inv_message.of_MessageBox("of_export_data_with_text", "There is no save path for this file. Unable to continue this function.",true)
	RETURN 0
END IF
IF ai_export_id < 1 THEN
	inv_message.of_MessageBox("Data Error", "No export selected.  Unable to proceed.",true)
	RETURN 0
END IF

Open(w_export_progress)
w_export_progress.st_progress.Text = "Creating export table"

IF of_create_export_table( ai_export_id,ai_save_data ) < 0 THEN
	Close(w_export_progress)
	RETURN 0
END IF

Long ll_fld_val
Long i //practitioner
Long li_found_rec
Long li_field_width
Long p // rows in field list as well as column number
Long li_rec_no
Long li_file_num
Long li_array_index
Long li_search_from_row
Long li_prac_id_cnt
Long li_table_cnt
Long t
Long e
Long g
Long a
Long w
Long sd
Long li_data_rc
Long li_found_row
Long li_fld_cnt
Long li_filter_cnt
Long li_text_cnt
Long li_fld_type //maha
Long ll_find_no //maha
Long li_use_link //maha
Long li_recd_no //maha
Long li_width //maha
Long f //maha
Long li_dif //maha
Long li_facil_id //maha
Long ud //maha 080103
Long col //maha 080103
Long li_act_format //maha 083105
Long li_multi_table
Long li_custom_save //maha 121205
Long li_multi_field[] //maha121905
Long li_sub_start //maha010306
Long li_fail_count //Start Code Change ---- 06.12.2006 #537 maha
Long li_exp_type //maha
Long li_bar_ticks //maha
Long li_billing //maha 080205
Long ll_prac_row //maha
Long ll_ret_cnt
Long ll_billing_id //maha app080205
Long ll_Cnt,ll_Num
Long ll_Tab,ll_Start = 1,ll_pos1,ll_pos2,ll_pos3
Long ll_FieldSeqID = 0,ll_FieldCnt
Long ll_export_code
Long ll_intcred_field
Long ll_equivcode
Long ll_pracid
Long ll_FieldSeqIDold = -1
Long ll_R = 0
Long ll_Rorig = 0
Long ll_i = 1
Long ll_j
Long ll_k
Long li_billingList[] //Alfee 11.13.2008
Long li_recdnoList[]
Long ll_exportcodeList[]
Long ll_intcredfieldList[]
Long li_substartList[]
Long li_widthList[]
Long li_udList[]
Long ll_pos
Long li_facil_idList[]
Long li_act_formatList[]
Long li_widthtemp
Long ll_len
Long ll_maxwidth
Long ll_n,ll_pkcnt,ll_Rcnt,ll_SpID,ll_lastpos
Long ll_equivcodeCnt
integer li_drop_col  //add by stephen 03.26.2013

String ls_trail_val
String ls_lookup_type
String ls_db_lookup_type
String ls_lookup_code
String ls_trail_record
String ls_pad
String ls_fixed_width
String ls_hdr_val
String ls_hdr_record
String Errors
String ls_export_record
String ls_export_field
String ls_fld_type
String ls_fld_delim
String ls_fld_val
String ls_lead_trail_char
String ls_format
String ls_table_name
String ls_table_names[]
String ls_sql_syntax
String ls_field_name
String ls_grey
String ls_presentation_str
String ls_dwsyntax_str
String ls_value
String ls_data_value
String ls_field_format //maha
String ls_sql //maha
String ls_month //maha
String ls_year //maha
String ls_day //maha
String ls_hour //maha
String ls_minute //maha
String ls_save_format //maha
String ls_path //maha
String ls_header //maha
String ls_filter //maha
String ls_lookup //maha
String ls_datatype //maha
String ls_prac_ids = ""
String ls_select_field //maha
String ls_prac_field //maha
String ls_select_table_trim //maha
String ls_select_table //maha
String ls_sny_retrieve //maha
String ls_find //maha
String ls_delim_value //maha
String ls_rec_delim //maha
String ls_lu_field //maha
String ls_use_link_sql //maha
String ls_use_link_sql2 //maha
String ls_export_text_file = "" //maha
String ls_lookup_val //maha
String ls_save_path //maha
String stax
String s //maha
String ls_aggre //maha 012703
String ls_sort //maha 012703
String ls_dc_field //maha010704
String ls_bill_syn //maha app080205
String ls_text //maha 120905
String ls_strip_char //maha 120905
String ls_save_name //maha 121205
String ls_def_val
String ls_ComputerDataType,ls_Expresstion,ls_Field,ls_FieldDataType
String ls_Modify,ls_Err,ls_tag
String ls_Objects,ls_objname,ls_ObjType,ls_ColType
String ls_UnionSQL = "",ls_SqlSelect
String ls_OrderBy
String ls_billsynList[]
String ls_tablelist[]
String ls_fieldlist[]
String ls_selectfieldlist[]
String ls_formatList[]
String ls_dcfieldList[]
String ls_typelist[] //Alfee 11.13.2008
String ls_flddelimList[]
String ls_defvalList[]
String ls_textList[]
String ls_prac_sql
String ls_use_link_sqlsyn
String ls_prac_sql_temp
String ls_prac_sql_temp2
String ls_Sortsel
String ls_top = "top 2147483647"
String ls_tablepks[],ls_table[],ls_tablepk,ls_sortpk[],ls_dbtype
String ls_RowNo = "",ls_RowNoSyn = "",ls_MySQL,ls_tabletemp
String ls_synprefix = ""
String ls_multi_where //Start Code Change ---- 10.01.2007 #V7 maha
string ls_post_sort  //Start Code Change ---- 03.03.2010 #V10 maha

DateTime ldt_date, ldt_value 
Boolean lb_table_found, lb_export, lb_flagpk
Boolean lb_true = False, lb_ASA7 = False, lb_mulsel = False, lb_flag = True

str_pass lstr_pass
n_cst_string lnvo_string

ldt_date = DateTime(Today(),Now()) 
ls_dbtype = of_get_dbtype()
IF Upper(ls_dbtype) = 'SQL2005' Or Upper(ls_dbtype) = 'ASA9' THEN
	ls_RowNo = ",Row_No"
	lb_true = True
ELSEIF Upper(ls_dbtype) = 'ASA7' THEN
	lb_ASA7 = True
END IF
IF Not lb_ASA7 THEN
	ls_synprefix = "select prac_id,FieldSeqID,billing_address_id,field_value,field_data_type" + ls_RowNo + " from ("
END IF

IF ai_type = 2 THEN of_bubblesort(al_prac_ids) //Bubble sort the al_prac_ids array.
li_prac_id_cnt = UpperBound( al_prac_ids[] )

ids_tablepk = Create n_ds 
IF LeftA(Upper(ls_dbtype),3) = 'ASA' THEN
	ids_tablepk.DataObject = "d_export_tablepk_asa_ctx"
	ls_top = ""
ELSE
	ids_tablepk.DataObject = "d_export_tablepk_sql_ctx"
END IF
ids_tablepk.SetTransObject( SQLCA )

ids_field = Create n_ds
ids_field.DataObject = "d_export_fields"
ids_field.of_SetTransObject( SQLCA )
ids_field.Retrieve( ai_export_id )

ids_code_lookup = Create n_ds
ids_code_lookup.DataObject = "d_code_lookup"
ids_code_lookup.of_SetTransObject( SQLCA )

ids_address_lookup = Create n_ds
ids_address_lookup.DataObject = "d_address_lookup"
ids_address_lookup.of_SetTransObject( SQLCA )

ids_export_hdr = Create n_ds
ids_export_hdr.DataObject = "d_export_hdr"
ids_export_hdr.of_SetTransObject( SQLCA )

ids_export_flds = Create n_ds
ids_export_flds.DataObject = "d_export_flds_list_exp"
ids_export_flds.of_SetTransObject( SQLCA )

ids_dept_chair = Create n_ds //maha 010704
ids_dept_chair.DataObject = "d_dept_chair_exp"
ids_dept_chair.of_SetTransObject( SQLCA )

ids_export_retrieve = Create n_ds
ids_export_hdr.Retrieve( ai_export_id )

ids_export_equiv_code = Create n_ds
ids_export_equiv_code.DataObject = "d_export_equiv_code_lds"
ids_export_equiv_code.SetTransObject( SQLCA )
ll_equivcodeCnt = ids_export_equiv_code.Retrieve()

IF ids_export_hdr.RowCount() < 1 THEN
	Close(w_export_progress)
	of_cleanup_ds( )
	RETURN -1
END IF

//HEADER INFO
ls_table_name = ids_export_hdr.GetItemString(1,"export_name")
ls_header = ids_export_hdr.GetItemString(1,"field_labels_as_header") //Y or N
ls_format = ids_export_hdr.GetItemString(1,"export_format")
ls_post_sort = ids_export_hdr.GetItemString(1,"sort_fields") //Start Code Change ----03.02.2010 #V10 maha - added
IF ls_format = "export"  THEN //maha 121205
	lb_export = True
	ls_format = ".txt"	
	
	//Start Code Change ----10.19.2010 #V10 maha - readded code for header/footer
	//add header values
	FOR i = 1 TO 4
		ls_hdr_val = ids_export_hdr.GetItemString( 1, "header" + String( i ) )
		IF IsNull( ls_hdr_val ) THEN
			ls_hdr_val = ""
		END IF
		ls_hdr_record = ls_hdr_record + ls_hdr_val
	END FOR
	//	get footer values
	FOR i = 1 TO 4
		ls_trail_val = ids_export_hdr.GetItemString( 1, "footer" + String( i ) )
		IF IsNull( ls_trail_val ) THEN
			ls_trail_val = ""
		END IF
		ls_trail_record = ls_trail_record + ls_trail_val
	END FOR	
	//End Code Change ----10.19.2010 #V10 maha
	
ELSEIF ls_format = ".csv" THEN
	IF Upper( appeongetclienttype() ) = "WEB" THEN
	   inv_message.of_MessageBox("User Error", "No export selected.  Unable to proceed.",true)
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1
	END IF
	lb_export = False
ELSE //txt and xls files  files
	lb_export = False
END IF

IF is_called_type = '4' THEN //print letters call - Andy 08.29.2007
	ls_format = ".txt"
	ls_header = '1'
END IF

li_exp_type = ids_export_hdr.GetItemNumber(1,"export_type")
ls_rec_delim = ids_export_hdr.GetItemString(1,"record_delimiter")
ls_save_path = ids_export_hdr.GetItemString(1,"save_path")
ls_multi_where = ids_export_hdr.GetItemString(1,"multi_screen_filter") 

SELECT Top 1 @@spid Into :ll_SpID From ids;

//specify SQL
IF ai_type = 1 THEN
	ls_prac_sql  = Trim(as_sql) 
	IF IsNull(ls_prac_sql) THEN ls_prac_sql = ''
	IF ls_prac_sql <> '' THEN
		ll_pos = PosA(ls_prac_sql,";")
		IF ll_pos > 0 THEN
			ls_prac_sql  = ReplaceA(ls_prac_sql,ll_pos,1,'')
		END IF
		ll_len = LenA(ls_prac_sql)
		ls_prac_sql_temp = Trim(MidA(ls_prac_sql,7,ll_len))
		IF Lower(LeftA(ls_prac_sql_temp,8)) = 'distinct' THEN
			ls_prac_sql_temp2 = Trim(MidA(ls_prac_sql_temp,9,ll_len))
			IF Lower(LeftA(ls_prac_sql_temp2,3)) <> 'top' THEN
				ls_prac_sql = 'select distinct ' + ls_top + ' ' + ls_prac_sql_temp2
			END IF
		ELSEIF Lower(LeftA(ls_prac_sql_temp,3)) <> 'top' THEN
			ls_prac_sql = 'select ' + ls_top + ' ' + ls_prac_sql_temp
		END IF
		
		//$<add> 05.06.2008 by Andy
		//del order by statement. Reason:if ORDER BY items isn't in the select list,then it will get error.
		//ORDER BY items must appear in the select list if the statement contains a UNION operator.
		ll_pos = PosA(Lower(ls_prac_sql)," order ")
		IF ll_pos > 0 THEN
			ls_prac_sql = LeftA(ls_prac_sql,ll_pos - 1)
		END IF
		//if select more than one field,then add a select statement outside the ls_prac_sql and
		//INSERT the result INTO a table.
		ll_pos = PosA(Lower(ls_prac_sql)," from ")
		ls_prac_sql_temp = LeftA(ls_prac_sql,ll_pos - 1)
		ll_pos = PosA(ls_prac_sql,",")
		IF ll_pos > 0 THEN
			lb_mulsel = True
			ls_prac_sql = "select distinct prac_id," + String(ll_SpID) + " from (" + ls_prac_sql + ") cc order by prac_id"
			SELECT Top 1 1 Into :ll_Cnt From sysobjects Where Name = 'export_temp' And Type = 'U';
			IF ll_Cnt = 1 THEN
				ls_MySQL = "DELETE FROM export_temp WHERE SpID = " + String(ll_SpID) + ";"
			ELSE
				ls_MySQL = "CREATE TABLE export_temp (prac_id int null,SpID int null)"
			END IF
			EXECUTE Immediate :ls_MySQL;
			ls_MySQL = "INSERT INTO export_temp " + ls_prac_sql + ";"
			EXECUTE Immediate :ls_MySQL;
			ls_prac_sql = "select distinct prac_id from export_temp where SpID = " + String(ll_SpID)
		END IF
		//end add 05.06.2008
	END IF
END IF

li_multi_table = ids_export_hdr.GetItemNumber(1,"multi_row_table")
ls_strip_char = ids_export_hdr.GetItemString(1,"strip_char")
IF IsNull(ls_strip_char) Or LenA(ls_strip_char) < 1 THEN ls_strip_char = "NONE"
IF ls_format = ".csv" THEN ls_strip_char = "," //maha 122005
li_custom_save = ids_export_hdr.GetItemNumber(1,"custom_save_name")
IF li_custom_save = 5 THEN ib_nyp_fte = True 
IF IsNull(li_custom_save) THEN li_custom_save = 0

//set record delimiter
CHOOSE CASE ls_rec_delim
	CASE "C"
		ls_rec_delim = ","
	CASE "R"
		ls_rec_delim = "~r"
	CASE "T"
		ls_rec_delim = "	"
	CASE "D"
		ls_rec_delim = "~r~r"
	CASE "U"
	CASE ELSE
		ls_rec_delim = ""
END CHOOSE
IF IsNull(ls_rec_delim) THEN ls_rec_delim = ""
IF ls_format = ".csv" THEN ls_rec_delim = "~r"
li_fld_cnt = ids_export_flds.Retrieve( ai_export_id )
ll_maxwidth = Long(ids_export_flds.Describe("evaluate('max(export_field_length)',0)"))
IF ll_maxwidth < 30 THEN ll_maxwidth = 30

//CREATE SYNTAX FOR export DW
ls_sql_syntax = is_select_syntax
ls_presentation_str = "style(type=form)"

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, ls_presentation_str, Errors)
IF LenA(Errors) > 0 THEN //this will fail if the table creation has not been completed
	IF PosA(Errors,"Table or view not found",1) > 0 THEN
	   inv_message.of_MessageBox ("Error in of_export_data_with_text","Export data data store not able to be created.~rCheck the following:~rMake sure export field names have no spaces and contain only letters, numbers and underscores, and that all fields have a width.~rYou cannot have duplicate field names~rField names cannot start with a number.",true )
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -4 		
	ELSE
	   inv_message.of_MessageBox("Caution","SyntaxFromSQL caused these errors: " + Errors,true)
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1
	END IF
END IF
ids_export_data = Create n_ds
ids_export_data.Create( ls_dwsyntax_str, Errors)
ids_export_data.SetTransObject( SQLCA )

//---------Begin Added by (Appeon)Toney 11.28.2013 for V141 ISG-CLX--------
//$Reason:Fix BugT112602
n_cst_dw_update_prop  ln_dwprop
IF Upper(AppeonGetClientType())="WEB" THEN
	IF ai_save_data = 1 OR ai_save_data = 3 THEN
		ln_dwprop.of_modifyupdateproperty(ids_export_data, is_savetablename,false)
	END IF
END IF
//---------End Added ------------------------------------------------------------------

//<add> andy 07.05.2007
//save the original data that it's not format,in order to deal with the computer fields
ids_export_dataTemp = Create n_ds
ids_export_dataTemp.Create( ls_dwsyntax_str, Errors )
ids_export_dataTemp.SetTransObject( SQLCA )
//end of add

w_export_progress.r_bar.Width = 300
w_export_progress.st_progress.Text = "Populating Data for " + String(li_prac_id_cnt) + " Practitioners"

//creates string of prac_ids for querys, between...and... - Andy 07/09/2007
IF ai_type = 3 THEN
	IF li_prac_id_cnt > 0 THEN
		ls_prac_ids = "between " + String(al_prac_ids[1]) + " and " + String(al_prac_ids[li_prac_id_cnt])
	END IF
END IF

//create rows for all practitioner data
FOR i = 1 To li_prac_id_cnt
	//specify array
	IF ai_type = 2 THEN
		ls_prac_ids = ls_prac_ids + String( al_prac_ids[i] ) + ","
	END IF
	g = ids_export_data.InsertRow(0)
NEXT

IF ai_save_data = 1 Or ai_save_data = 3  Or ib_gen_rec_id THEN //Evan 01.20.2010 (V10.1 - Notification Alert)
	ids_export_data.Object.rec_id.Primary[] = al_prac_ids[]
END IF
ids_export_data.RowsCopy( 1, ids_export_data.RowCount(), Primary!, ids_export_dataTemp, 1, Primary! )

//specify array
IF ai_type = 2 THEN
	ls_prac_ids = LeftA( ls_prac_ids, LenA( ls_prac_ids ) -1 ) //remove last comma
END IF

w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + 50
w_export_progress.st_export.Text = "Form SQL Statement"

IF lb_ASA7 THEN
	ls_tabletemp = "t_export" + String(ll_SpID)
	//ls_MySQL = "CREATE TABLE " + ls_tabletemp + " (prac_id int null,FieldSeqID int null, billing_address_id int null, field_value varchar( " + String(ll_maxwidth) + ") null, field_data_type CHAR(1))"
	ls_MySQL = "if exists (select 1 from sysobjects where name = '"+ls_tabletemp +"' and type = 'U') " + " drop table " + ls_tabletemp //export error in v12 - Michael 02.17.2012
	ls_MySQL = ls_MySQL +" CREATE TABLE " + ls_tabletemp + " (prac_id int null,FieldSeqID int null, billing_address_id int null, field_value varchar( " + String(ll_maxwidth) + ") null, field_data_type CHAR(1))"
	EXECUTE Immediate :ls_MySQL;
	IF SQLCA.SQLCode <> 0 THEN
 		inv_message.of_MessageBox(gnv_app.iapp_object.DisplayName,SQLCA.SQLErrText,true)	
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1
	END IF
END IF

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
FOR p = 1 To li_fld_cnt
	//messagebox("li_fld_cnt",li_fld_cnt)
	li_width = ids_export_flds.GetItemNumber(p,"export_field_length")
	ls_field_format = ids_export_flds.GetItemString(p,"export_format")
	//	is_field_headers[p] =  ids_export_flds.GetItemString(p,"export_field_name") 	//Start Code Change ----04.08.2013 #V12 maha
	ls_data_value = ""
	ls_value = ""
	ls_lookup_val = ""
	ls_dc_field = "none"
	li_sub_start =  0 
	ud = ids_export_flds.GetItemNumber( p, "use_default" )
	IF ud = 1 Or ud = 3 Or ud = 2 THEN
		ls_def_val = ids_export_flds.GetItemString( p, "default_value" )
	ELSE
		ls_def_val = ""
	END IF
	//****fixed text
	IF ids_export_flds.GetItemNumber(p,"export_type") = 2 THEN //set data for text fields
		ls_select_field = ids_export_flds.GetItemString(p,"export_field_name")
		is_field_headers[p] =  ls_select_field	//Start Code Change ----04.08.2013 #V12 maha
		ls_value = ids_export_flds.GetItemString(p,"field_value")
		
		IF IsNull(ls_value) THEN ls_value = ""
		
		IF ls_value = "&TODAY&" THEN			
			//ls_value = of_date_format(ls_field_format,ldt_date) //maha 070705 factored
			ls_value = String(ldt_date,"yyyy-mm-dd hh:mm") //<modify> 08/28/2007 by: Andy Reason:Support user-defined format.
			of_data_format(ls_field_format,'D',ls_value)
		END IF
		
		//Start Code Change ----01.26.2012 #V12 maha - modifed to allow getting the user name or id
		IF ls_value = "&USERID&" THEN
			ls_value = gs_user_id
		end if
		
		IF ls_value = "&USERNAME&" THEN
			select user_name into :ls_value from security_users where user_id = :gs_user_id;
		end if		
		//End Code Change ----01.26.2012

		String ls_ptype
		ls_ptype = "" //maha 120905
		CHOOSE CASE Upper(ls_value)
			CASE "&PROMPT1&"
				ls_ptype = ids_export_hdr.GetItemString(1,"prompt_type1")
				ls_value = of_prompt_populate( ls_ptype, as_param1)
			CASE "&PROMPT2&"
				ls_ptype = ids_export_hdr.GetItemString(1,"prompt_type2")
				ls_value = of_prompt_populate( ls_ptype, as_param2)
			CASE "&PROMPT3&"
				ls_ptype = ids_export_hdr.GetItemString(1,"prompt_type3")
				ls_value = of_prompt_populate( ls_ptype, as_param3)
		END CHOOSE
		//if the prompt type is date and it is a fixed text, get today() for the value 
		IF	ls_ptype = 'D' THEN
			ldt_date = DateTime(Date(ls_value),Now())
			ls_value = String(ldt_date,"yyyy-mm-dd hh:mm")
			of_data_format(ls_field_format,'D',ls_value)
		END IF

		li_sub_start = ids_export_flds.GetItemNumber(p,"export_fields_substring_start")
		IF li_sub_start > 1 THEN ls_value = MidA(ls_value,li_sub_start,li_width)
		ls_value = MidA(ls_value,1,li_width) //shrink the length to size 
		
		FOR i = 1 To li_prac_id_cnt
			ids_export_data.SetItem(i,p,ls_value)
			ids_export_dataTemp.SetItem(i,p,ls_value) //<add> andy 07.05.2007
		NEXT
		
		//*******getting values from data
	ELSEIF ids_export_flds.GetItemNumber(p,"export_type") = 1 THEN //get FIELDS DATA
		//CREATE SYNTAX FOR each retrieve DW
		ls_export_field = ids_export_flds.GetItemString(p,"export_field_name")
		is_field_headers[p] =  ls_export_field	//Start Code Change ----04.08.2013 #V12 maha
		of_replacespecchar(ls_export_field)
		ls_select_field = Trim( ids_export_flds.GetItemString( p, "db_field_name" ) )
		ls_datatype = Trim( ids_export_flds.GetItemString(p,"db_field_type") ) //Alfee 11.13.2008		
		ls_select_table = Trim( ids_export_flds.GetItemString( p, "db_table_name" ) )
		li_use_link = ids_export_flds.GetItemNumber(p,"use_link")
		ls_fld_delim = ids_export_flds.GetItemString( p, "trailing_leading_characters")
		li_recd_no = ids_export_flds.GetItemNumber(p,"intcred_record_number")
		ll_FieldSeqID ++
		ll_export_code = ids_export_flds.GetItemNumber( p, "export_code" )
		ls_dc_field = ids_export_flds.GetItemString( p, "dept_sect_field" )
		IF IsNull(ls_dc_field) Or Trim(ls_dc_field) = '' THEN ls_dc_field = "none"
		ll_intcred_field = ids_export_flds.GetItemNumber(p,"intcred_field")
		li_facil_id = ids_export_flds.GetItemNumber(p,"facility_id")
		ls_lu_field = ids_export_flds.GetItemString( p, "lu_field_name" )
		ls_aggre = ids_export_flds.GetItemString( p, "aggre_function" )
		ls_sort = ids_export_flds.GetItemString( p, "sort_by" )
		ls_Sortsel = ls_sort
		IF IsNull(ls_Sortsel) THEN ls_Sortsel = ''
		IF LenA(Trim(ls_Sortsel)) > 0 THEN
			of_get_sortsel(ls_Sortsel,'prac_id')
		END IF
		li_act_format = ids_export_flds.GetItemNumber(p,"export_fields_active_yesno")
		ls_text = ids_export_flds.GetItemString(p,"field_value") //maha 091305
		IF Upper(ls_lu_field) = "LOOKUP CODE" THEN ls_lu_field = "lookup_code"
		IF IsNull(ls_lu_field) THEN ls_lu_field = "code"
		ls_use_link_sql = ""
		ls_use_link_sql2 = ""
		li_sub_start = ids_export_flds.GetItemNumber(p,"export_fields_substring_start") //maha 010306
		IF PosA(ls_select_table,"dba.",1) > 0 THEN //maha 122005 
			ls_select_table_trim = MidA(ls_select_table,5) //dropping dba.
			ls_select_table = ls_select_table_trim //maha 012306
		ELSE
			ls_select_table_trim = ls_select_table
		END IF
		ls_filter = ids_export_flds.GetItemString(p,"filter_query")
		li_billing = ids_export_flds.GetItemNumber(p,"billing_link") //maha app080205
		IF IsNull(li_facil_id) THEN li_facil_id = 0
		IF IsNull(ls_filter) Or ls_filter = "" THEN
			ls_filter = ""
		ELSE
			ls_filter = " and  ( " + ls_filter + " )"
			Long li_pos1
			li_pos1 = PosA(Upper(ls_filter),"PROMPT1",1)
			IF li_pos1 > 0 THEN
				ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param1 + MidA(ls_filter,li_pos1 + 7)
			END IF
			li_pos1 = PosA(Upper(ls_filter),"PROMPT2",1)
			IF li_pos1 > 0 THEN
				ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param2 + MidA(ls_filter,li_pos1 + 7)
			END IF
			li_pos1 = PosA(Upper(ls_filter),"PROMPT3",1)
			IF li_pos1 > 0 THEN
				ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param3 + MidA(ls_filter,li_pos1 + 7)
			END IF
		END IF

		//set record delimiter/pad maha 060105
		CHOOSE CASE ls_rec_delim
			CASE "R" //return
				ls_rec_delim = "~r"
			CASE "T" //tab
				ls_rec_delim = "	"
			CASE "D" //double return
				ls_rec_delim = "~r~n"
			CASE "S" // space
				ls_rec_delim = " "
			CASE "E" //empty string
				ls_rec_delim = ""
		END CHOOSE
		IF ls_format = ".csv" THEN ls_rec_delim = "," 	//maha 121205 //overwrite field delim if is a CSV file
		
		//export_fields_use_link  sql
		IF li_use_link = 1 THEN
			CHOOSE CASE ls_select_table
				CASE "pd_address"
					ls_use_link_sql = ",pd_address_link"
				CASE "pd_hosp_affil"
					ls_use_link_sql = ",pd_hosp_facility_link"
				CASE "pd_board_specialty"
					ls_use_link_sql = ",pd_spec_facility_link"
				CASE ELSE
					ls_use_link_sql = ""
			END CHOOSE
		END IF
		
		ls_tablelist[ll_FieldSeqID] = ls_select_table
		ls_fieldlist[ll_FieldSeqID] = ls_export_field
		li_recdnoList[ll_FieldSeqID] = li_recd_no
		ls_selectfieldlist[ll_FieldSeqID] = ls_select_field
		ls_typelist[ll_FieldSeqID] = ls_datatype //Alfee 11.13.2008		
		li_billingList[ll_FieldSeqID] = li_billing //Alfee 11.13.2008		
		ls_formatList[ll_FieldSeqID] = ls_field_format
		ll_exportcodeList[ll_FieldSeqID] = ll_export_code
		ls_dcfieldList[ll_FieldSeqID] = ls_dc_field
		ll_intcredfieldList[ll_FieldSeqID] = ll_intcred_field
		li_substartList[ll_FieldSeqID] = li_sub_start
		li_widthList[ll_FieldSeqID] = li_width
		li_widthtemp = li_width
		IF li_widthtemp < 30 THEN li_widthtemp = 30
		ls_flddelimList[ll_FieldSeqID] = ls_fld_delim
		li_udList[ll_FieldSeqID] = ud
		ls_defvalList[ll_FieldSeqID] = ls_def_val
		ls_textList[ll_FieldSeqID] = ls_text
		li_facil_idList[ll_FieldSeqID] = li_facil_id
		li_act_formatList[ll_FieldSeqID] = li_act_format
		
		ls_use_link_sqlsyn = ls_use_link_sql
		IF ai_type = 1 THEN
			ls_use_link_sql = ls_use_link_sql + ", (" + ls_prac_sql + ") bb "
		END IF
	
		ls_tablepk = ""
		IF IsNull(ls_sort) Or Trim(ls_sort) = "" THEN
			ls_sort = ""
			lb_flagpk = True
			ll_pkcnt = UpperBound(ls_table)
			FOR ll_n = 1 To ll_pkcnt
				IF Lower(ls_select_table) = Lower(ls_table[ll_n]) THEN
					ls_tablepk = ls_tablepks[ll_n]
					ls_sort = ls_sortpk[ll_n]
					lb_flagpk = False
				END IF
			NEXT
			IF lb_flagpk THEN
				ll_Rcnt = ids_tablepk.Retrieve( ls_select_table)
				ls_sort = ls_select_table + '.prac_id, '
				FOR ll_n = 1 To ll_Rcnt
					IF Lower(ids_tablepk.GetItemString( ll_n, "column_name")) = 'prac_id' THEN
						CONTINUE
					END IF
					ls_tablepk += ls_select_table + '.' + ids_tablepk.GetItemString( ll_n, "column_name") + ", "
				NEXT
				ls_sort = ls_sort + ls_tablepk
				ls_sort  = LeftA(ls_sort,LenA(ls_sort) - 2)
				ls_sortpk[ll_pkcnt + 1] = ls_sort
				ls_table[ll_pkcnt+1] = ls_select_table
				ls_tablepks[ll_pkcnt+1] = ls_tablepk
			END IF
		ELSE
			IF PosA(Lower(ls_sort),'prac_id') < 1 THEN ls_sort = ls_select_table + '.prac_id, ' + ls_sort
		END IF
		IF lb_ASA7 THEN
			ls_tablepk = ""
			ls_Sortsel = "" 
		END IF
		
		IF LenA(ls_aggre) > 0 THEN
			ls_sort = ls_sort + " , field_value"
		END IF
		IF LenA(ls_sort) > 0 THEN ls_sort = "order by " + ls_sort

		IF lb_true THEN //SQL2005 and ASA9
			ls_RowNoSyn = ",row_number() over(" + ls_sort+") Row_No"
		END IF
		
		ls_bill_syn     = "Select " + Lower(ls_select_table) + ".prac_id, "
		ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " " + Lower(ls_select_table) + ".prac_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, "
		IF ls_select_table = "pd_address" And li_billing = 1 THEN //maha app080205
			ls_bill_syn     = ls_bill_syn + " billing_address_id, "
			ls_sny_retrieve = ls_sny_retrieve + " billing_address_id, "
		ELSE
			ls_sny_retrieve = ls_sny_retrieve + " 0 billing_address_id, "
		END IF
		
		ls_db_lookup_type = ids_export_flds.GetItemString( p, "db_lookup_type" )
		IF ls_select_field = "affiliation_status" THEN // setting lookup field and where
			ls_datatype = "C"
			//ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + " from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and "
			ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + ",address_id =address_id from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and " //Nova 03.26.2010
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and "
			ls_select_field  = "code_lookup_" + ls_lu_field
		ELSEIF Upper(ls_db_lookup_type)  = "C" THEN //code lookup table
			IF Upper(ls_lu_field) = "LOOKUP_CODE" THEN
				ls_datatype = "N"
			ELSE
				ls_datatype = "C"
			END IF
			//ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + " from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "
			ls_bill_syn     = ls_bill_syn + " code_lookup."+ ls_lu_field + ",address_id =address_id from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and " //Nova 03.26.2010			
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "
			ls_select_field  = "code_lookup_" + ls_lu_field
		ELSEIF Upper(ls_db_lookup_type)  = "A" THEN //address lookup table
			IF ls_lu_field = "description"  THEN
 				inv_message.of_MessageBox("Data Error on field " + ls_export_field,"The address lookup field set for export field '" + ls_select_field + "' is improperly set.  You cannot use description, try entity_name.  Please correct.",true)	
				Close(w_export_progress)
				IF lb_ASA7 THEN
					ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
					EXECUTE Immediate :ls_MySQL;
				END IF
				of_cleanup_ds( )
				RETURN 0
			ELSE
				IF Upper(ls_lu_field) = "LOOKUP_CODE" THEN
					ls_datatype = "N"
				ELSEIF Upper(ls_lu_field) = "CUSTOM_1" Or Upper(ls_lu_field) = "CUSTOM_2" THEN //maha 050704 
					ls_datatype = "N"
				ELSE
					ls_datatype = "C"
				END IF
				//ls_bill_syn     = ls_bill_syn + " address_lookup." + ls_lu_field + " from address_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and "
				ls_bill_syn     = ls_bill_syn + " address_lookup." + ls_lu_field + ",address_id =address_id from address_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and " //Nova 03.26.2010
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),address_lookup." + ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from address_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and "
				ls_select_field  = "address_lookup_" + ls_lu_field
			END IF
		ELSEIF Upper(ls_db_lookup_type)  = "F" THEN //facility table
			IF Upper(ls_lu_field) = "FACILITY_ID" Or Upper(ls_lu_field) = "RETURN_ZIP" THEN
				ls_datatype = "N"
			ELSE
				ls_datatype = "C"
			END IF
			//ls_bill_syn     = ls_bill_syn + " facility." + ls_lu_field + " from facility," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,facility.facility_id)) and "
			ls_bill_syn     = ls_bill_syn + " facility." + ls_lu_field + ",address_id =address_id from facility," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,facility.facility_id)) and " //Nova 03.26.2010
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),facility." + ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from facility," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,facility.facility_id)) and "
			ls_select_field  = "facility_" + ls_lu_field
		//--------Begin Added by Nova 10.30.2009------------------------
		//Privilege export functionality - modified by alfee 01.26.2010
		ELSEIF Upper(ls_db_lookup_type)  = "D" THEN //DDDW lookup type
			IF lower(ls_select_table) = 'pd_priv_list' AND lower(ls_select_field) = "clinical_area_id" THEN
				ls_datatype = "C"
				IF ls_lu_field = "Dept Code" THEN						
					ls_bill_syn     = ls_bill_syn + " priv_clinical_area." + "clinical_area_code" + " from priv_clinical_area," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_clinical_area.clinical_area_id)) and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_clinical_area." + "clinical_area_code" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_clinical_area," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_clinical_area.clinical_area_id)) and "
					ls_select_field  = "priv_clinical_area_" + "clinical_area_code"
				ELSE
					ls_bill_syn     = ls_bill_syn + " priv_clinical_area." + "clinical_area_description" + " from priv_clinical_area," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_clinical_area.clinical_area_id)) and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_clinical_area." + "clinical_area_description" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_clinical_area," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_clinical_area.clinical_area_id)) and "
					ls_select_field  = "priv_clinical_area_" + "clinical_area_description"
				END IF
			ELSEIF lower(ls_select_table) = 'pd_priv_list' AND lower(ls_select_field) = "priv_core_id" THEN			
				ls_datatype = "C"
				IF ls_lu_field = "Section" THEN
					ls_bill_syn     = ls_bill_syn + " priv_core." + "priv_core_description" + " from priv_core," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core.priv_core_id)) and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_core." + "priv_core_description" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_core," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core.priv_core_id)) and "
					ls_select_field  = "priv_core_" + "priv_core_description"
				END IF					
			ELSEIF lower(ls_select_table) = 'pd_priv_list' AND lower(ls_select_field) = "procd_id" THEN						
				ls_datatype = "C"
				IF ls_lu_field = "Procedure Code" THEN						
					ls_bill_syn     = ls_bill_syn + " priv_core_procd." + "procd_name" + " from priv_core_procd," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core_procd.procd_id)) and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_core_procd." + "procd_name" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_core_procd," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core_procd.procd_id)) and "
					ls_select_field  = "priv_core_procd_" + "procd_name"
				ELSE
					ls_bill_syn     = ls_bill_syn + " priv_core_procd." + "core_procd_description" + " from priv_core_procd," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core_procd.procd_id)) and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),priv_core_procd." + "core_procd_description" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from priv_core_procd," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,priv_core_procd.procd_id)) and "
					ls_select_field  = "priv_core_procd_" + "core_procd_description"
				END IF	
			ELSEIF lower(ls_select_table) = 'pd_comm_review' AND lower(ls_select_field) = "meeting_id"  THEN	//added by long.zhang 01.21.2013 
				ls_datatype = "C"
				IF ls_lu_field = "Meeting Subject" THEN
					ls_bill_syn     = ls_bill_syn + " meetings." + "subject" + " from meetings right outer join " + Lower(ls_select_table) +" on  (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,meetings.meeting_id))" +  ls_use_link_sqlsyn+" where 1=1 and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),meetings." + "subject" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from meetings right outer join " + Lower(ls_select_table) +   " on " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,meetings.meeting_id)) "+ls_use_link_sql + " WHERE 1=1 and "
					ls_select_field  = "meetings_" + "subject"
				else
					ls_datatype = "N"
					ls_bill_syn     = ls_bill_syn + " meetings." + "meeting_id" + " from meetings right outer join " + Lower(ls_select_table) +" on  (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,meetings.meeting_id))" +  ls_use_link_sqlsyn+" where 1=1 and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),meetings." + "meeting_id" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from meetings right outer join " + Lower(ls_select_table) +   " on " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,meetings.meeting_id)) "+ls_use_link_sql + " WHERE 1=1 and "
					ls_select_field  = "meetings_" + "meeting_id"
				END IF
			ELSEIF lower(ls_select_table) = 'pd_comm_review' AND lower(ls_select_field) = "committee_id"  THEN	//added by long.zhang 01.21.2013 
				ls_datatype = "C"
				IF ls_lu_field = "Committee Name" THEN
					ls_bill_syn     = ls_bill_syn + " committee_lookup." + "committee_name" + " from committee_lookup right outer join " + Lower(ls_select_table) +" on  (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,committee_lookup.committee_id))" +  ls_use_link_sqlsyn+" where 1=1 and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),committee_lookup." + "committee_name" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from committee_lookup right outer join " + Lower(ls_select_table) +   " on " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,committee_lookup.committee_id)) "+ls_use_link_sql + " WHERE 1=1 and "
					ls_select_field  = "committee_lookup_" + "committee_name"
				else
					ls_datatype = "N"
					ls_bill_syn     = ls_bill_syn + " committee_lookup." + "committee_id" + " from committee_lookup right outer join " + Lower(ls_select_table) +" on  (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,committee_lookup.committee_id))" +  ls_use_link_sqlsyn+" where 1=1 and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),committee_lookup." + "committee_id" + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from committee_lookup right outer join " + Lower(ls_select_table) +   " on " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,committee_lookup.committee_id)) "+ls_use_link_sql + " WHERE 1=1 and "
					ls_select_field  = "committee_lookup_" + "committee_id"
				END IF	
			END IF
		//--------End Added --------------------------------------------
		//Start Code Change ----08.20.2012 #V12 maha added support for the standing lookup table
		ELSEIF Upper(ls_db_lookup_type)  = "G" THEN //standing lookup for flags

			IF Upper(ls_lu_field) = "DISPLAY_VALUE" THEN
				ls_datatype = "C"
			ELSE
				ls_datatype = "N"
			END IF
			//ls_bill_syn     = ls_bill_syn + " standing_lookup." + ls_lu_field + ", lu_id =lu_id from standing_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,standing_lookup.lu_id) and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),standing_lookup." + ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from standing_lookup," + Lower(ls_select_table) +  ls_use_link_sql +  " WHERE " + " convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar, standing_lookup.lu_id) and "
			ls_select_field  = "standing_lookup_" + ls_lu_field
			
		//End Code Change ----08.20.2012 
		ELSE // NON LOOKUP FIELDS
			ls_datatype = ids_export_flds.GetItemString(p,"db_field_type")
			IF LenA(ls_aggre) > 0 THEN //maha 012703 for aggregate functions still not being used as of 12-05 
				//ls_bill_syn     = ls_bill_syn + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ") a" + ls_aggre + " from " + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " 
				ls_bill_syn     = ls_bill_syn + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ") a" + ls_aggre + ",address_id =address_id from " + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE "  //Nova 03.26.2010				
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + ")," + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ")) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
			ELSE
				//ls_bill_syn     = ls_bill_syn + ls_select_table + "." +ls_select_field + " from " + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " 	
				ls_bill_syn     = ls_bill_syn + ls_select_table + "." +ls_select_field + ",address_id =address_id from " + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " //Nova 03.26.2010	
				IF Upper(ls_datatype) = 'D' THEN
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(16)," + ls_select_table + "." +ls_select_field + ",120) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
				ELSE
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + ")," + ls_select_table + "." +ls_select_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
				END IF
			END IF
		END IF
		ls_selectfieldlist[ll_FieldSeqID] = ls_select_field //Alfee 11.13.2008
		ls_typelist[ll_FieldSeqID] = ls_datatype //Alfee 11.13.200			
		
		//export_fields_use_link  sql
		IF li_use_link = 1 THEN
			CHOOSE CASE ls_select_table
				CASE "pd_address"
					ls_use_link_sql2 = " (pd_address.rec_id = pd_address_link.address_id) and "
				CASE "pd_hosp_affil"
					ls_use_link_sql2 = " (pd_hosp_Affil.rec_id = pd_hosp_facility_link.hosp_affil_id) and "
				CASE "pd_board_specialty"
					ls_use_link_sql2 = " (pd_board_specialty.rec_id = pd_spec_facility_link.specialty_id) and "
				CASE ELSE
					ls_use_link_sql2 = ""
			END CHOOSE
		END IF
		
		ls_bill_syn     = ls_bill_syn + ls_use_link_sql2
		ls_sny_retrieve = ls_sny_retrieve + ls_use_link_sql2
		
		//add facility where
		IF li_facil_id > 0 THEN
			CHOOSE CASE ls_select_table
				CASE "pd_address"
					IF li_use_link = 1 THEN //<add> 07/16/2007 by: Andy Reason:BugG062904
						ls_bill_syn     = ls_bill_syn + "(pd_address_link.facility_id = " + String(li_facil_id) + ") and "
						ls_sny_retrieve = ls_sny_retrieve + "(pd_address_link.facility_id = " + String(li_facil_id) + ") and "
					END IF
				CASE "pd_hosp_affil"
					IF li_use_link = 1 THEN //<add> 07/16/2007 by: Andy Reason:BugG062904
						ls_bill_syn     = ls_bill_syn + "(pd_hosp_facility_link.facility_id = " + String(li_facil_id) + ") and "
						ls_sny_retrieve = ls_sny_retrieve + "(pd_hosp_facility_link.facility_id = " + String(li_facil_id) + ") and "
					END IF
				CASE "pd_board_specialty"
					IF li_use_link = 1 THEN //<add> 07/16/2007 by: Andy Reason:BugG062904
						ls_bill_syn     = ls_bill_syn + "(pd_spec_facility_link.facility_id = " + String(li_facil_id) + ") and "
						ls_sny_retrieve = ls_sny_retrieve + "(pd_spec_facility_link.facility_id = " + String(li_facil_id) + ") and "
					END IF
				CASE "pd_affil_stat"
					ls_bill_syn     = ls_bill_syn + "(pd_affil_stat.parent_facility_id = " + String(li_facil_id) + ") and "
					ls_sny_retrieve = ls_sny_retrieve + "(pd_affil_stat.parent_facility_id = " + String(li_facil_id) + ") and "
				CASE ELSE
					ls_bill_syn     = ls_bill_syn +  + "(" + ls_select_table + ".facility_id = " + String(li_facil_id) + ") and "
					ls_sny_retrieve = ls_sny_retrieve +  + "(" + ls_select_table + ".facility_id = " + String(li_facil_id) + ") and "
					
			END CHOOSE
		END IF
		
		//3rd last add  - prac where
		//ls_bill_syn = ls_sny_retrieve //maha app080205
		ls_billsynList[ll_FieldSeqID] = ls_bill_syn
		IF ai_type = 1 THEN
			ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id  = bb.prac_id "  + ls_filter
		ELSEIF ai_type = 3 THEN
			ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id " + ls_prac_ids + ls_filter
		ELSEIF ai_type = 2 THEN
			ls_sny_retrieve = ls_sny_retrieve + Lower(ls_select_table) + ".prac_id  in (" + ls_prac_ids  + ")"  + ls_filter			
		END IF
		
		//2nd last add  - prac where 
		IF LenA(ls_aggre) > 0 THEN //maha 012703 for aggregate functions
			ls_sny_retrieve = ls_sny_retrieve + " Group by " + Lower(ls_select_table) + ".prac_id, FieldSeqID, billing_address_id, field_data_type" + ls_RowNo
		END IF
		IF LenA(ls_sort) > 0 And Not lb_true THEN //SQL2000 only  
			ls_sny_retrieve = ls_sny_retrieve + "~r~n " + ls_sort
		END IF
		
		IF Not lb_ASA7 THEN
			ls_sny_retrieve = ls_sny_retrieve + " ) t" + String(ll_FieldSeqID)
		ELSE
			//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
			ls_MySQL = "INSERT INTO " + ls_tabletemp + " ~r~n(prac_id,FieldSeqID, billing_address_id, field_value, field_data_type) ~r~n " + ls_sny_retrieve + " ;"
			EXECUTE Immediate :ls_MySQL;
			IF SQLCA.SQLCode <> 0 THEN
 				inv_message.of_MessageBox("Caution on export field (insert) " + ls_export_field, SQLCA.SQLErrText,true)	
				Close(w_export_progress)
				IF lb_ASA7 THEN
					ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
					EXECUTE Immediate :ls_MySQL;
				END IF
				of_cleanup_ds( )
				RETURN -1
			END IF
		END IF
		
		IF IsNull(ls_sny_retrieve) THEN ls_sny_retrieve = ""
		IF LenA(ls_sny_retrieve) > 0 THEN
			IF ls_UnionSQL = "" THEN
				ls_UnionSQL = ls_sny_retrieve
			ELSE
				ls_UnionSQL = ls_UnionSQL + "~r~n union all ~r~n" + ls_sny_retrieve
			END IF
		END IF
		
	ELSE //computed fields
		//Dynamic create computed columns in order to Calculate its value
		/*1.deal with Expression**************/
		ls_export_field     = ids_export_flds.GetItemString(p,"export_field_name")
		of_replacespecchar(ls_export_field)
		ls_Expresstion      = Trim( ids_export_flds.GetItemString( p, "export_fields_expression" ) ) //db_field_name
		ls_ComputerDataType = ids_export_flds.GetItemString(p,"ctx_column_datatype")
		IF IsNull(ls_export_field) THEN ls_export_field = ''
		IF IsNull(ls_Expresstion) THEN ls_Expresstion = ''
		IF IsNull(ls_ComputerDataType) THEN ls_ComputerDataType = ''
		IF IsNull(ls_field_format) THEN ls_field_format = ''
		IF IsNull(ls_fld_delim) THEN ls_fld_delim = ''
		ll_Cnt = ids_field.RowCount()
		
		//If the computer field is numeric,add the function number(  ) in to the Expresstion.
		//Replace symbol ' with "
		FOR ll_Num = 1 To ll_Cnt
			ls_Field         = ids_field.GetItemString(ll_Num,"export_field_name")
			ls_FieldDataType = ids_field.GetItemString(ll_Num,"ctx_column_datatype")
			IF IsNull(ls_Field) THEN ls_Field = ''
			IF IsNull(ls_FieldDataType) THEN ls_FieldDataType = ''
			//<add> 07/27/2007 by: Andy 
			//Reason:The Expresstion of a computed field can't contain itself.
			IF Lower(ls_export_field) = Lower(ls_Field) THEN CONTINUE
			//end of add

			//If the field used in then computed field and is number, 
			//add the function number(  ) in to the Expresstion 
			IF PosA(Lower(ls_Expresstion),Lower(ls_Field)) > 0 THEN
				IF Upper(ls_FieldDataType) = 'N' THEN
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),0,number( " + ls_Field + " ))",True)
				ELSEIF Upper(ls_FieldDataType) = 'S' THEN
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),''," + ls_Field + " )",True)
				ELSEIF Upper(ls_FieldDataType) = 'D' THEN
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),'1900-01-01'," + ls_Field + " )",True)
				END IF
			END IF
		NEXT
		//end if
		
		//replace symbol ' with "
		ls_Expresstion  = lnvo_string.of_globalreplace( ls_Expresstion, '~~', '~~~~')
		ls_Expresstion  = lnvo_string.of_globalreplace( ls_Expresstion, '"', '~~"') //'"'
		/*end of 1***************************/
		
		ls_tag = ls_field_format + '@^@' + ls_ComputerDataType + '@^@' + String(li_width) + '@^@' + ls_fld_delim
		//2.Dynamic create computer columns,the name equal ls_Field + '_c'
		ls_Modify = "create compute(band=detail alignment='0' expression=~""+ls_Expresstion+"~" border='0' color='33554432' x='1157'" + &
			" y='4' height='64' width='242' format='[GENERAL]' html.valueishtml='0'  name=" + ls_export_field + "_c visible='0'" + &
			" font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0'" + &
			" background.mode='1' background.color='536870912' tag='" + ls_tag + "' )"
		ls_Err    = ids_export_dataTemp.Modify(ls_Modify)
		//end of 2		
	END IF
NEXT

w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + 50
w_export_progress.st_export.Text = "Retrieve Data"

ll_FieldCnt = ll_FieldSeqID
IF ls_UnionSQL <> "" THEN
	IF lb_true THEN //SQL2005 and ASA9
		ls_UnionSQL = ls_UnionSQL + "~r~n order by " + "FieldSeqID, prac_id , Row_No"
		if of_get_app_setting("set_31","I") = 100 then //Start Code Change ----05.26.2010 #V10 maha - Inova sql v2000 option
			ls_UnionSQL = ls_UnionSQL + " option(maxdop 1) "
		end if
	END IF
	
	IF lb_true THEN ls_RowNo = ", 0 Row_No" //SQL2005 AND ASA9
	IF lb_ASA7 THEN
		ls_SqlSelect = "Select prac_id,FieldSeqID,billing_address_id,field_value,field_data_type from " + ls_tabletemp
	ELSE
		ls_SqlSelect = "Select top 1 0 prac_id, 1 FieldSeqID, 0 billing_address_id,  cast('' as varchar(" + String(ll_maxwidth) + ")) field_value,  ' ' field_data_type" + ls_RowNo + " from pd_basic"
	END IF
	ls_presentation_str = "style(type=grid)"
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_SqlSelect, ls_presentation_str, Errors)
	IF LenA(Errors) > 0 THEN
	   inv_message.of_MessageBox("Caution on export field ","SyntaxFromSQL caused these errors: " + Errors + "~r~r" + ls_SqlSelect,true)	
		Close(w_export_progress)
		IF lb_ASA7 THEN
			ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
			EXECUTE Immediate :ls_MySQL;
		END IF
		of_cleanup_ds( )
		RETURN -1
	END IF
	
	ids_export_retrieve = Create n_ds
	w = ids_export_retrieve.Create( ls_dwsyntax_str, Errors)
	IF w < 1 THEN
		inv_message.of_MessageBox("Error on Create",Errors,true)		
		Close(w_export_progress)
		IF lb_ASA7 THEN
			ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
			EXECUTE Immediate :ls_MySQL;
		END IF
		of_cleanup_ds( )
		RETURN -1
	END IF
	
	IF Not lb_ASA7 THEN
		ids_export_retrieve.Modify('DataWindow.Table.Select="' + ls_UnionSQL + '"')
	END IF
	
	ids_export_retrieve.SetTransObject( SQLCA )
	ll_ret_cnt = ids_export_retrieve.Retrieve()

	IF ll_ret_cnt < 0 THEN
		//Reason:check syntax
		ls_presentation_str = "style(type=grid)"
		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_UnionSQL, ls_presentation_str, Errors)
		IF LenA(Errors) > 0 THEN
 			inv_message.of_MessageBox("Caution on export" ,"SyntaxFromSQL caused these errors: " + Errors ,true)	
			Close(w_export_progress)
			
			IF lb_ASA7 THEN
				ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
				EXECUTE Immediate :ls_MySQL;
			END IF
			of_cleanup_ds( )
			RETURN -3 // //Start Code Change ----.2009 #V10 maha - changed return value
		END IF
	END IF

END IF

w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + 60
li_bar_ticks = (1000 - 500) / li_fld_cnt

//%%%%%%%%%%%%%%%%%%%%%%%%%%%% end of create syntax

ls_prac_field = ids_export_retrieve.Describe("#1.name")
DO While (ll_i <= ll_ret_cnt)
	ll_j = 0
	ls_data_value = ""
	ls_value = ""
	ls_lookup_val = ""
	ldt_value = DateTime(Date("0000-00-00"),Time("00:00:00"))
	
	ll_pracid       = ids_export_retrieve.GetItemNumber(ll_i,ls_prac_field)
	ll_FieldSeqID   = ids_export_retrieve.GetItemNumber(ll_i,"FieldSeqID")
	li_recd_no      = li_recdnoList[ll_FieldSeqID]
	ls_select_table = ls_tablelist[ll_FieldSeqID]
	ls_select_field = ls_selectfieldlist[ll_FieldSeqID]
	ls_datatype 	 = ls_typelist[ll_FieldSeqID] //Alfee 11.13.200		
	li_billing 		 = li_billingList[ll_FieldSeqID] //Alfee 11.13.200		
	ls_export_field = ls_fieldlist[ll_FieldSeqID]
	ls_field_format = ls_formatList[ll_FieldSeqID]
	ll_export_code  = ll_exportcodeList[ll_FieldSeqID]
	li_sub_start    = li_substartList[ll_FieldSeqID]
	li_width        = li_widthList[ll_FieldSeqID]
	ls_fld_delim    = ls_flddelimList[ll_FieldSeqID]
	ls_text         = ls_textList[ll_FieldSeqID]
	li_facil_id     = li_facil_idList[ll_FieldSeqID]
	li_act_format   = li_act_formatList[ll_FieldSeqID]
	
	ud = li_udList[ll_FieldSeqID]
	IF ud = 1 Or ud = 3 THEN
		ls_def_val = ls_defvalList[ll_FieldSeqID]
	ELSEIF ud = 2 THEN //column default
		col = Long(ls_defvalList[ll_FieldSeqID])
	ELSE
		ls_def_val = ""
	END IF
	
	IF ll_FieldSeqIDold <> ll_FieldSeqID THEN
		ll_R = 0
		ib_flag=true//For optimize export  Added by  Nova 03.26.2010
		ll_FieldSeqIDold = ll_FieldSeqID
		w_export_progress.st_export.Text  = ls_select_table + "_" + ls_select_field //string(ll_FieldSeqID) + "   " + 
		w_export_progress.st_export1.Text = ls_select_field
		w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + li_bar_ticks //* (ll_R - ll_Rorig)
		if isvalid(ids_billing) then destroy ids_billing //add by stephen 04.18.2013 -Bug 3487:System Error when running export
	else
		ib_flag=false//For optimize export  Added by  Nova 03.26.2010	
	end if
	
	FOR ll_R = ll_R + 1 To li_prac_id_cnt
		IF al_prac_ids[ll_R] = ll_pracid THEN EXIT
	NEXT
	ls_find = "(" + ls_prac_field + " > " + String(ll_pracid) + " AND FieldSeqID = " + String(ll_FieldSeqID) + &
		") OR ( FieldSeqID  > " + String(ll_FieldSeqID) + ")"
	ll_j    = ids_export_retrieve.Find ( ls_find, ll_i + 1, ll_ret_cnt )
	IF ll_j > 0 THEN
		//The max row of the current FieldSeqID
		ll_j = ll_j - 1
	END IF
	
	//Perhaps it is the last ll_pracid and it is the max FieldSeqID,
	//then set ll_j = ll_ret_cnt(max row in the ds)
	IF ll_j = 0 THEN
		ll_j = ll_ret_cnt
	END IF
	
	//max - min + 1 = total(current FieldSeqID)
	IF ll_j - ll_i + 1 >= li_recd_no THEN 		//find out
		ll_prac_row = ll_i + li_recd_no - 1
	ELSE 		//Not 
		ll_prac_row = 0
	END IF
	
	//process data
	IF ll_prac_row > 0 THEN
		//IF li_billing = 1 THEN //maha app080205 to get billing address data 
		IF li_billing = 1 and PosA(ls_select_table, "pd_address",1) > 0 then //Start Code Change ----03.14.2013 #V12 maha - trap for billing link on non- address table
			ll_billing_id   = ids_export_retrieve.GetItemNumber(ll_prac_row, "billing_address_id" )
			ls_data_value = of_get_billing(ll_billing_id,ls_datatype,ls_select_field,ls_field_format,ls_billsynList[ll_FieldSeqID]) //ls_bill_syn
			if not isvalid(w_export_progress) then return -1 //add by stephen 04.18.2013 -Bug 3487:System Error when running export
		ELSE
			ls_data_value = ids_export_retrieve.GetItemString(ll_prac_row, "field_value")
		END IF
	ELSE
		//do nothing
	END IF
	
	IF Lower(ids_export_dataTemp.Describe(ls_export_field + ".name")) = Lower(ls_export_field) THEN
		//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
		//Begin - Added By Mark Lee 09/29/12 its cannot use double quote to merge data values in  the MS word.
		If Pos(ls_data_value,'"') > 0 Then 
			gnv_debug.of_output(true, 'Alarm  Export: Its used the double quote Replace the blank data in merged data value on the column ['+ls_export_field+'], and this current data value is the ['+ls_data_value+'].' )
			ls_data_value  = lnvo_string.of_globalreplace( ls_data_value, '"', ' ')
		End If
		//End - Added By Mark Lee 09/29/12
		//---------End Added ------------------------------------------------------------------
		ids_export_dataTemp.SetItem(ll_R,ls_export_field,ls_data_value)
	END IF
	IF ls_format = "export" THEN
		IF IsNull(ls_data_value) THEN ls_data_value = ""
	END IF
	of_data_format(ls_field_format,ls_datatype,ls_data_value)
	

	//*****GET EXPORT CODES
	IF ll_export_code  = 1 THEN //get export code if required
		ls_lookup_val = ls_data_value //ids_export_data.getitemstring(i,p) //changed 100102
		//use datastore
		IF IsNull(ls_lookup_val) THEN ls_lookup_val = ''
		ll_equivcode = ids_export_equiv_code.Find( "export_id = " + String(ai_export_id) + " and lookup_code= " + ls_lookup_val, 0, ll_equivcodeCnt)
		IF ll_equivcode > 0 THEN
			ls_value = ids_export_equiv_code.GetItemString(ll_equivcode,"equiv_code")
		END IF
		IF Not IsNull(ls_value) And Trim(ls_value) <> '' THEN ls_data_value = ls_value //if no export code use org value
		IF IsNull(ls_data_value) THEN ls_data_value = ""
	END IF
	
	//****Dept Chair data  maha 010704
	ls_dc_field = ls_dcfieldList[ll_FieldSeqID]
	IF ls_dc_field = 'none' Or IsNull(ls_dc_field) THEN
		//skip
	ELSE //if set to a field name get the data
		IF IsNumber(ls_data_value) THEN
			IF ids_dept_chair.Retrieve(li_facil_id,Long(ls_data_value)) > 0 THEN
				ls_data_value = ids_dept_chair.GetItemString(1,ls_dc_field)
			ELSE
				ls_data_value = ""
			END IF
		END IF
	END IF
	//Active Status format for affil stat maha 083105
	//if ids_export_flds.getitemnumber(p,"intcred_field") = 100000 then
	ll_intcred_field = ll_intcredfieldList[ll_FieldSeqID]
	IF ll_intcred_field = 100000 THEN
		IF li_act_format = 1 THEN
			IF ls_data_value = "1" THEN
				ls_data_value = "Y"
			ELSE
				ls_data_value = "N"
			END IF
		ELSEIF li_act_format = 2 THEN
			CHOOSE CASE ls_data_value
				CASE "1"
					ls_data_value = "Active"
				CASE "2"
					ls_data_value = "Purge"
				CASE "3"
					ls_data_value = "Inactive"
				CASE "4"
					ls_data_value = "Pending"
				CASE "0"
					ls_data_value = "History"
			END CHOOSE
		END IF
	END IF
	//--------Begin Added by Nova 10.30.2009------------------------
	IF ls_select_field = 'active_status' And ls_select_table = "pd_priv_list"  THEN
		CHOOSE CASE ls_data_value
			CASE '1'
				ls_data_value = 'Active'
			CASE '0'
				ls_data_value = 'History'
		END CHOOSE
	END IF
	//--------End Added --------------------------------------------
	IF ls_strip_char <> "NONE" THEN
		ls_data_value = of_strip_char( ls_strip_char ,ls_data_value, "")
	END IF
	IF li_sub_start > 1 THEN ls_data_value = MidA(ls_data_value,li_sub_start,li_width)
	
	//***padding //note if avoid using return, double return, empty string or tab when padding
	ls_data_value = MidA(ls_data_value,1,li_width) //shrink the length to size 
	IF ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" THEN
		IF li_width - LenA(ls_data_value) > 0 THEN
			li_dif = li_width - LenA(ls_data_value)
			ls_pad = "" //reset
			ls_pad = FillA ( ls_fld_delim, li_dif )
			IF ls_field_format = "Leading Padding" THEN
				ls_data_value = ls_pad + ls_data_value
			ELSE
				ls_data_value = ls_data_value + ls_pad
			END IF
		END IF
	ELSEIF ls_field_format = "use text" THEN //allows a set value if data is found
		IF LenA(ls_data_value) > 0 THEN
			ls_data_value = ls_text
		END IF
	ELSEIF ls_field_format = "Numbers" THEN //Start Code Change ----04.21.2008 #V8 maha - added for strip to numbers
		ls_data_value = of_strip_char( "#", ls_data_value ,  "@NUM@")
	END IF
	
	//****set default moved here 091305
	IF ud > 0 THEN
		IF ud = 3 THEN
			ls_data_value = ls_def_val + ls_data_value
		END IF
		IF IsNull(ls_data_value) THEN ls_data_value = ""
		IF ls_data_value = "" THEN
			IF ud = 1 THEN
				ls_data_value = ls_def_val
			ELSEIF ud = 2 THEN //if set to column get the value out of that column
				IF col < 1 Or col > li_fld_cnt THEN //setting trap
 					inv_message.of_MessageBox("Invalid setting","You are using a column default for column " + ls_export_field + " , but your default value is not a valid column number.~rThe default column number must be less than this column.",true)	
					Close(w_export_progress)
					IF lb_ASA7 THEN
						ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
						EXECUTE Immediate :ls_MySQL;
					END IF
					of_cleanup_ds( )
					RETURN 0
				END IF
				ls_data_value = ids_export_data.GetItemString(ll_R,col)
			END IF
		END IF
	END IF
	
	//*********value set**********
	IF Lower(ids_export_data.Describe(ls_export_field + ".name")) = Lower(ls_export_field) THEN
		ids_export_data.SetItem(ll_R,ls_export_field,ls_data_value)
	END IF
	
	//processing the next field(fieldseqid)
	ll_i = ll_j + 1
LOOP
if isvalid(ids_billing) then destroy ids_billing//For optimize export  Added by  Nova 03.26.2010
//process default value
IF of_export_processdefault(ids_export_hdr,ids_export_flds,ids_export_dataTemp,ids_export_data) = -1 THEN
	Close(w_export_progress)
	IF lb_ASA7 THEN
		ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
		EXECUTE Immediate :ls_MySQL;
	END IF
	of_cleanup_ds( )
	RETURN 0
END IF

//set Calculated field value and format into lds_export_data 
//with the relative computer column in lds_export_dataTemp
of_export_calculatedfield(ids_export_dataTemp,ids_export_data,ls_format)
w_export_progress.r_bar.Width = 1000

//@@@@@@@@@@@@@@@@@@@multi row function @@@@@@@@@@@@@@@@

IF li_multi_table > 0 THEN
	w = 1
	FOR a = 1 To li_fld_cnt //get list of fields
		IF ids_export_flds.GetItemNumber(a,"intcred_table") = li_multi_table THEN
			li_multi_field[w] = a
			w++
		END IF
	NEXT
	//Start Code Change ---- 10.01.2007 #V7 maha added code for the multi table where and modified function call
	li_pos1 = PosA(Upper(ls_multi_where),"PROMPT1",1)
	IF li_pos1 > 0 THEN
		ls_multi_where = MidA(ls_multi_where,1,li_pos1 - 1) + as_param1 + MidA(ls_multi_where,li_pos1 + 7)
	END IF
	li_pos1 = PosA(Upper(ls_multi_where),"PROMPT2",1)
	IF li_pos1 > 0 THEN
		ls_multi_where = MidA(ls_multi_where,1,li_pos1 - 1) + as_param2 + MidA(ls_multi_where,li_pos1 + 7)
	END IF
	li_pos1 = PosA(Upper(ls_multi_where),"PROMPT3",1)
	IF li_pos1 > 0 THEN
		ls_multi_where = MidA(ls_multi_where,1,li_pos1 - 1) + as_param3 + MidA(ls_multi_where,li_pos1 + 7)
	END IF
	
	of_multi_row(ids_export_data,"not used",li_multi_table,li_multi_field[],ids_export_flds,al_prac_ids[],ls_multi_where)
	//End Code Change---10.01.2007
END IF

//end multi row
//1:save / 3:save & preview
IF ai_save_data = 1 Or ai_save_data = 3 THEN
	w_export_progress.st_progress.Text = "Saving File"
	w_export_progress.r_bar.Width = 500
	sd = ids_export_data.Update()
	IF sd < 1 THEN
	 	inv_message.of_MessageBox("Save error","Unable to save data to table",true)			
	END IF
	COMMIT Using SQLCA;
END IF

w_export_progress.r_bar.Width = 1000

//******************************* CREATE FILE
//\/maha 121205 moved out of first portion of if statement below; rebuilt file naming
w_export_progress.st_progress.Text = "Creating File"
w_export_progress.r_bar.Width = 300

li_bar_ticks = 1000 / li_fld_cnt
ls_save_path = as_path

IF RightA(ls_save_path,1) = ':' THEN ls_save_path = ls_save_path + "\"
ll_lastpos = LastPos(ls_save_path,'.')
IF ll_lastpos > 0 THEN
	IF LenA(ls_save_path) - ll_pos < 5 THEN //Start Code Change ----07.30.2009 #V92 maha - trap for development where the path may include a dot
		ls_save_path = LeftA(ls_save_path,ll_lastpos - 1)
	END IF
END IF

//create name of file
IF MidA(ls_save_path,LenA(ls_save_path),1) <> "\" THEN //maha app 102405 if a file name is indicated do not tack on the table name
	ls_path = ls_save_path + ls_format
ELSE
	CHOOSE CASE li_custom_save
		CASE 1,2,3
			ls_save_name = of_custom_name(li_custom_save,ls_table_name,ldt_date)
		CASE ELSE //0,509.27
			ls_save_name = ls_table_name
	END CHOOSE
	ls_path = ls_save_path + ls_save_name + ls_format
END IF

as_path = ls_path
ls_save_path = MidA(ls_path,1,lastpos(ls_path,'\'))
gnv_appeondll.of_parsepath(ls_save_path)

//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 2011-01-11.
If invo_rights.of_check_dir_right(ls_save_path,true,"Export") <> 1 Then
	//Messagebox('','')
	ls_save_path = gs_temp_path + "ExportData\"
	gnv_appeondll.of_parsepath(ls_save_path)	
End If
//---------End Added ------------------------------------------------------------------

//Start Code Change ----03.02.2010 #V10 maha
if LenA(ls_post_sort) > 0 then
	ids_export_data.setsort(ls_post_sort)
	ids_export_data.sort()
end if
//End Code Change---03.02.2010

IF lb_export = False THEN //if the auto export path is blank use the export path, if blank use the hard coded path
    //------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 03.26.2013
	//$<reason>  V12.3	Add ‘Drop Column Before Saving File’
	/* 	CHOOSE CASE ls_format
		CASE ".txt" //tab delimited
			IF ls_header = "1" THEN
				g = ids_export_data.SaveAs(ls_path,Text!,True)
			ELSE
				g = ids_export_data.SaveAs(ls_path,Text!,False)
			END IF
		CASE ".xls" //excel
			IF ls_header = "1" THEN
				g = ids_export_data_drop.SaveAs(ls_path,excel!,True)
			ELSE
				g = ids_export_data_drop.SaveAs(ls_path,excel!,False)
			END IF
		CASE ".csv" //excel
			IF ls_header = "1" THEN
				g = ids_export_data.SaveAs(ls_path,csv!,True)
			ELSE
				g = ids_export_data.SaveAs(ls_path,csv!,False)
			END IF
	END CHOOSE */
	//Start Code Change ----04.08.2013 #V12 maha - for nammspass export
	if is_header_rebuild = "NP" then
		string field_name
		string efc
		ids_export_data.insertrow(1)
		for i = 1 to upperbound(is_field_headers[] )
			field_name = upper(is_field_headers[i])
			if field_name = "FIRST_" then field_name = "FIRST"
			ids_export_data.setitem(1, i, field_name )
		next
	end if
	//Start Code Change ----08.08.2013
	
	 if ls_header = "1" then
		g = of_copy_expdata(ids_export_data, ls_format, true, ls_path, true)
		if g <> 1 then return 0 
	else
		g = of_copy_expdata(ids_export_data, ls_format, false, ls_path, true)
		if g <> 1 then return 0 
	end if
	//------------------- APPEON END -------------------
	
	w_export_progress.r_bar.Width = 1000
	IF g = -1 THEN 
 	inv_message.of_MessageBox("saveas -1","Unable to save file.  Check path (" + ls_path + ") and make sure a copy of the file is not open.",true)	
	end if	
ELSE //export and csv files
	//build export text file
	li_file_num = FileOpen(ls_path, lineMode!, Write!, LockWrite!, Replace!) //maha changed to line mode 091002
	
	//Start Code Change ----10.19.2010 #V10 maha
	if len(ls_hdr_record ) > 0 then
		FileWrite ( li_file_num, ls_hdr_record )
	end if
	//End Code Change---10.19.2010
	
	if of_copy_expdata(ids_export_data, '', false, '', false) <> 1 then return 0 //add by Stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	
	FOR i = 1 To li_prac_id_cnt
		w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + li_bar_ticks		
		ls_export_text_file = ""		
		FOR p = 1 To li_fld_cnt
			ls_data_value = ids_export_data.GetItemString(i,p)
			ls_fld_delim = ids_export_flds.GetItemString( p, "trailing_leading_characters")
			ls_field_format = ids_export_flds.GetItemString(p,"export_format")
			
			//------------------- APPEON BEGIN -------------------
			//$<add> stephen  03.26.2013
			//$<reason> V12.3	Add ‘Drop Column Before Saving File’
			li_drop_col = ids_export_flds.GetItemNumber(p,"drop_column")
			if isnull(li_drop_col) then li_drop_col = 0
			if  li_drop_col = 1 then continue 
			//------------------- APPEON END -------------------
			
			IF IsNull(ls_data_value) THEN ls_data_value = "" //maha 012306 added trap
			//maha 121205 in a csv file force all field delimiters to comma
			IF ls_format = ".csv" THEN
				ls_fld_delim = ","
				ls_rec_delim = ""
			END IF
			ls_field_format = ids_export_flds.GetItemString(p,"export_format")
			CHOOSE CASE ls_fld_delim
				CASE "E" //empty String
					ls_delim_value = ""
				CASE "S" // space
					ls_delim_value = " "
				CASE "T" //tab
					ls_delim_value = "	"
				CASE "R" //return
					ls_delim_value = "~r"
				CASE "D" //return
					ls_delim_value = "~r~n"
				CASE ELSE
					ls_delim_value = ls_fld_delim
			END CHOOSE
			IF IsNull(ls_delim_value) THEN ls_delim_value = ""
			IF ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" THEN //don't add delimit value
				ls_export_text_file = ls_export_text_file + ls_data_value
			ELSE
				IF ls_format = ".csv"  And p = li_fld_cnt THEN
				ELSE
					ls_export_text_file = ls_export_text_file + ls_data_value + ls_delim_value
				END IF
			END IF			
		NEXT
		
		ls_export_text_file = ls_export_text_file + ls_rec_delim
		p = 1
		//following for line mode //set 091002
		g = FileWrite ( li_file_num, ls_export_text_file)
		IF g = -1 THEN
 			inv_message.of_MessageBox("File write error record # " + String(i) ,"Unable to write to file " + ls_path + " .",true)	
			li_fail_count++
		END IF		
		IF li_fail_count = 3 THEN
 			inv_message.of_MessageBox("File write error" ,"Repeted fail to write to file " + ls_path + " .  Aborting export write.  Check directory/file permissions.",true)	
			EXIT
		END IF
	NEXT
	
	//Start Code Change ----10.19.2010 #V10 maha
	if len(ls_trail_record ) > 0 then
		FileWrite ( li_file_num, ls_trail_record )
	end if
	//End Code Change---10.19.2010	
	FileClose(li_file_num)
END IF

Close(w_export_progress)
ids_export_data = ids_export_data //When IntelliCred Email call it,Merge field failed,so add it. <add> 06.06.2008 by Andy
inv_message.of_set_proc_cnt(ids_export_data.rowcount()) 

//2:preview / 3:save & rpeview
IF ai_save_data = 2 Or ai_save_data = 3 THEN
	//------------------- APPEON BEGIN -------------------
	//$<modify> V12.3 Add ‘Drop Column Before Saving File’ - stephen 03.26.2013
   	lstr_pass.s_string = is_select_syntax_drop  //	lstr_pass.s_string = is_select_syntax
	lstr_pass.s_dw = ids_export_data_drop //	lstr_pass.s_dw = ids_export_data  
	//------------------- APPEON END -------------------
	lstr_pass.s_string_array[1] = ls_UnionSQL //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
	OpenWithParm( w_export_previewdata, lstr_pass )
END IF

IF lb_ASA7 THEN
	ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
	EXECUTE Immediate :ls_MySQL;
END IF

IF lb_mulsel THEN
	ls_MySQL = "DELETE FROM export_temp WHERE SpID = " + String(ll_SpID) + ";"
	EXECUTE Immediate :ls_MySQL;
END IF

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 01.20.2010
//$<reason> V10.1 - Notification Alert
ls_dwsyntax_str = ids_export_data.Describe("datawindow.syntax")
ids_cred_export_data.Create(ls_dwsyntax_str)
ids_export_data.RowsCopy(1, ids_export_data.RowCount(), Primary!, ids_cred_export_data, 1, Primary!)
//------------------- APPEON END ---------------------

of_cleanup_ds( )

RETURN 1


end function

public function integer of_export_data_with_text (integer ai_export_id, long al_prac_ids[], ref string as_path, integer ai_save_data, string as_param1, string as_param2, string as_param3, integer ai_type, string as_sql);//////////////////////////////////////////////////////////////////////
// $<function>of_export_data_with_text_ctx_new()
// $<arguments>
//		value	integer	ai_export_id 		
//		value	long   	al_prac_ids[]		
//		value	string 	as_path      		 
//    value integer  ai_save_data (0:Nothing / 1:save / 2:preview / 3:save & preview)
//		value	string 	as_param1    		
//		value	string 	as_param2    		
//		value	string 	as_param3
//    value integer  ai_type      (1: specify SQL/2: specify array/3: between...and)
//    value string   as_sql       (the specified SQL)
// $<returns> integer
// $<description> Used for export IntelliContract data.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
//////////////////////////////////////////////////////////////////////

SetPointer( HourGlass! )

IF IsNull(as_path) Or as_path = "" THEN
	inv_message.of_MessageBox("of_export_data_with_text", "There is no save path for this file. Unable to continue this function.",true)
	RETURN 0
END IF
IF ai_export_id < 1 THEN
	inv_message.of_MessageBox("Data Error", "No export selected.  Unable to proceed.",true)
	RETURN 0
END IF

Open(w_export_progress)
w_export_progress.st_progress.Text = "Creating export table"

IF of_create_export_table( ai_export_id,ai_save_data ) < 0 THEN
	Close(w_export_progress)
	RETURN 0
END IF

String ls_dbtype
String ls_RowNo = ""
String ls_synprefix
String ls_table_name
String ls_header
String ls_format
String ls_post_sort
String ls_strip_char
String ls_rec_delim
String ls_save_path
String ls_prac_sql
String ls_Mysql
String ls_sql_syntax
String ls_presentation_str
String Errors
String ls_dwsyntax_str
String ls_prac_ids = ""
String ls_tabletemp
String ls_select_field
String ls_lu_select_field  //(Appeon)Stephen 09.05.2014
String ls_lu_data_type  //(Appeon)Stephen 09.05.2014
String ls_value
String ls_field_format
String ls_ptype
String ls_pad
String ls_fld_delim
String ls_export_field
String ls_Expresstion
String ls_ComputerDataType
String ls_Field
String ls_FieldDataType
String ls_tag
String ls_modify
String ls_Err
String ls_sny_retrieve = ""
String ls_UnionSQL = ""
String ls_SqlSelect
String ls_prac_field
String ls_data_value
String ls_lookup_val
String ls_select_table
String ls_text
String ls_lu_field
String ls_find
String ls_find2
String ls_def_val
String ls_datatype
String ls_lookup_code
String ls_dc_field
String ls_path
String ls_save_name
String ls_export_text_file = ""
String ls_delim_value
String ls_hdr_val
String ls_hdr_record
String ls_trail_val
String ls_trail_record
String ls_multi_where //Start Code Change ---- 10.01.2007 #V7 maha
String ls_lu_type
String ls_sql
String ls_col_prac
String ls_sql_prac
String ls_header_string  //maha 03.05.2015
String ls_fld_delim_array[]//Added by Appeon long.zhang 11.08.2016 
String ls_field_format_array[]//Added by Appeon long.zhang 11.08.2016 
String ls_delim_value_array[]//Added by Appeon long.zhang 11.08.2016 
Long ll_FieldSeqID = 0
Long li_custom_save
Long li_prac_id_cnt
Long ll_rowcount
Long li_exp_type
Long ll_SpID
Long ll_pos
Long ll_Cnt
Long li_fld_cnt
Long ll_maxwidth
Long i
Long k //Added by Appeon long.zhang 09.27.2016
Long g
Long n
Long p
Long li_sub_start
Long li_width
Long li_dif
Long ll_Num
Long ll_FieldCnt
Long ll_row_fieldseq_end = 0  //Find the end of current FieldSeqId, Added by Appeon long.zhang 09.27.2016
Long w
Long ll_ret_cnt
Long li_bar_ticks
Long ll_i = 1
Long ll_j
Long ll_pracid
Long li_recd_no
Long ll_export_code
Long li_facil_id
Long li_act_format
Long ud
Long ll_FieldSeqIDold = -1
Long ll_R = 0
Long ll_prac_row
Long col
Long li_billing
Long ll_billing_id
Long ll_find
Long ll_intcred_field
Long sd
Long ll_lastpos
Long li_file_num
Long ll_equivcodeCnt
Long li_multi_table
Long ll_equivcode
Long a
Long li_multi_field[] //maha121905
Long li_pos1
Long li_fail_count //Start Code Change ---- 06.12.2006 #537 maha
//long ll_total_data_len //maha 04.15.2015//Comment by Appeon long.zhang 11.07.2016
long   ll_R_old
boolean lb_find
Boolean lb_total_data_len = False//Added by Appeon long.zhang 11.07.2016
Integer li_drop_col
Integer li_module_type
Int	li_drop_col_array[]//Added by Appeon long.zhang 11.08.2016 

DateTime ldt_date
DateTime ldt_value 

Boolean lb_true = false,lb_ASA7 = false
Boolean lb_export
Boolean lb_mulsel = false
Boolean lb_pading[] //Added by Appeon long.zhang 11.08.2016 
String ls_islookup //(Appeon)Harry 02.27.2015
Boolean lb_ai_type2 = false //(Appeon)Harry 05.06.2015
Boolean lb_export_field_checked = false//Added by Appeon long.zhang 09.28.2016

n_cst_string lnvo_string
str_gensql_param lstr_gensql_param
str_pass lstr_pass

ldt_date = DateTime(Today(),Now()) 
ls_dbtype = of_get_dbtype()
IF Upper(ls_dbtype) = 'SQL2005' Or Upper(ls_dbtype) = 'ASA9' THEN
	ls_RowNo = ",Row_No"
	lb_true = True
ELSEIF Upper(ls_dbtype) = 'ASA7' THEN
	lb_ASA7 = True
END IF
IF Not lb_ASA7 THEN
	ls_synprefix = "select prac_id,FieldSeqID,billing_address_id,field_value,field_data_type" + ls_RowNo + " from ("
END IF

of_cleanup_array() //(Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)

IF ai_type = 2 THEN of_bubblesort(al_prac_ids) //Bubble sort the al_prac_ids array.
li_prac_id_cnt = UpperBound( al_prac_ids[] )
//---------Begin Added by (Appeon)Stephen 05.08.2015 for Notifications questions related to case #00054429 --------
if not isvalid(ids_dept_chair) then 
	of_create_ds()
end if
//---------End Added ------------------------------------------------------

gnv_appeondb.of_startqueue( )

ids_dept_chair.Retrieve()
ids_export_flds.Retrieve( ai_export_id )
ids_export_equiv_code.Retrieve()
ids_export_hdr.Retrieve( ai_export_id )
ids_field.Retrieve( ai_export_id )

gnv_appeondb.of_commitqueue( )

ll_rowcount = ids_dept_chair.RowCount()
ll_equivcodeCnt = ids_export_equiv_code.RowCount()

IF ids_export_hdr.RowCount() < 1 THEN
	Close(w_export_progress)
	of_cleanup_ds( )
	RETURN -1
END IF

//HEADER INFO
ls_table_name = ids_export_hdr.GetItemString(1,"export_name")
ls_header = ids_export_hdr.GetItemString(1,"field_labels_as_header") //Y or N
ls_format = ids_export_hdr.GetItemString(1,"export_format")
ls_post_sort = ids_export_hdr.GetItemString(1,"sort_fields") //Start Code Change ----03.02.2010 #V10 maha - added

IF ls_format = "export"  THEN //maha 121205
	lb_export = True
	ls_format = ".txt"	
	
	//Start Code Change ----10.19.2010 #V10 maha - readded code for header/footer
	//add header values
	FOR i = 1 TO 4
		ls_hdr_val = ids_export_hdr.GetItemString( 1, "header" + String( i ) )
		IF IsNull( ls_hdr_val ) THEN
			ls_hdr_val = ""
		END IF
		ls_hdr_record = ls_hdr_record + ls_hdr_val
	END FOR
	//	get footer values
	FOR i = 1 TO 4
		ls_trail_val = ids_export_hdr.GetItemString( 1, "footer" + String( i ) )
		IF IsNull( ls_trail_val ) THEN
			ls_trail_val = ""
		END IF
		ls_trail_record = ls_trail_record + ls_trail_val
	END FOR	
	//End Code Change ----10.19.2010 #V10 maha
	
ELSEIF ls_format = "form_csv"  THEN //Start Code Change ----08.18.2014 #V14.2 maha
	lb_export = True
	
	//add header values
	ls_hdr_val = ids_export_hdr.GetItemString( 1, "header1" )
	IF IsNull( ls_hdr_val ) THEN 	ls_hdr_val = ""

	ls_hdr_record = ls_hdr_record + ls_hdr_val
	 //End Code Change ----08.18.2014
ELSEIF ls_format = ".csv" THEN
	//---------Begin Commented by (Appeon)Stephen 11.09.2016 for Import with CSV file--------
	/*
	IF Upper( appeongetclienttype() ) = "WEB" THEN
		//---------Begin Modified by (Appeon)Harry 06.05.2014 for for (No Export selected- Unable to proceed Bug#4061)---------
	   // inv_message.of_MessageBox("User Error", "No export selected.  Unable to proceed.",true)
		inv_message.of_MessageBox("IntelliSoft",  "The file type of CSV is unsupported on WEB.~r~nPlease go to Export Setup to modify settings.",true)
		//---------End Modfiied ------------------------------------------------------
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1
	END IF
	*/
	//---------End Commented ------------------------------------------------------
	lb_export = False
ELSE //txt and xls files  files
	lb_export = False
END IF

IF is_called_type = '4' THEN //print letters call - Andy 08.29.2007
	ls_format = ".txt"
	ls_header = '1'
END IF

li_exp_type = ids_export_hdr.GetItemNumber(1,"export_type")
ls_rec_delim = ids_export_hdr.GetItemString(1,"record_delimiter")
ls_save_path = ids_export_hdr.GetItemString(1,"save_path")
ls_multi_where = ids_export_hdr.GetItemString(1,"multi_screen_filter") 

SELECT Top 1 @@spid Into :ll_SpID From ids;

//specify SQL
IF ai_type = 1 THEN
	ls_prac_sql = of_getsql_from_export_temp (as_sql, ll_SpID, lb_mulsel, "prac_id")
//---------Begin Added by (Appeon)Harry 05.06.2015 for Issues running a custom correspondence letter against an IntelliBatch--------
ELSEIF ai_type = 2 and li_prac_id_cnt >=10  THEN 
	ls_prac_sql = of_getsql_from_export_temp (al_prac_ids, ll_SpID, lb_mulsel, "prac_id")
	lb_ai_type2 = true
//---------End Added ------------------------------------------------------
END IF

li_multi_table = ids_export_hdr.GetItemNumber(1,"multi_row_table")
ls_strip_char = ids_export_hdr.GetItemString(1,"strip_char")
IF IsNull(ls_strip_char) Or LenA(ls_strip_char) < 1 THEN ls_strip_char = "NONE"
IF ls_format = ".csv" THEN ls_strip_char = "," //maha 122005
li_custom_save = ids_export_hdr.GetItemNumber(1,"custom_save_name")
IF li_custom_save = 5 THEN ib_nyp_fte = True 
IF IsNull(li_custom_save) THEN li_custom_save = 0

//Start Code Change ----09.18.2014 #V14.2 maha
is_text_delimiter = ids_export_hdr.GetItemstring(1,"field_delimiter")
if isnull(is_text_delimiter) then is_text_delimiter = ""
//End Code Change ----09.18.2014

//set record delimiter
CHOOSE CASE ls_rec_delim
	CASE "C"
		ls_rec_delim = ","
	CASE "R"
		ls_rec_delim = "~r"
	CASE "T"
		ls_rec_delim = "	"
	CASE "D"
		ls_rec_delim = "~r~r"
	CASE "U"
	CASE "L" //line feed   //Start Code Change ----03.05.2015 #V15 maha
			ls_delim_value = "~n~r"
	CASE ELSE
		ls_rec_delim = ""
END CHOOSE
IF IsNull(ls_rec_delim) THEN ls_rec_delim = ""
IF ls_format = ".csv" THEN ls_rec_delim = "~r"
//li_fld_cnt = ids_export_flds.Retrieve( ai_export_id )
li_fld_cnt = ids_export_flds.RowCount()
ll_maxwidth = Long(ids_export_flds.Describe("evaluate('max(export_field_length)',0)"))
IF ll_maxwidth < 30 THEN ll_maxwidth = 30

//CREATE SYNTAX FOR export DW
ls_sql_syntax = is_select_syntax
ls_presentation_str = "style(type=form)"

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, ls_presentation_str, Errors)
IF LenA(Errors) > 0 THEN //this will fail if the table creation has not been completed
	IF PosA(Errors,"Table or view not found",1) > 0 THEN
	   inv_message.of_MessageBox ("Error in of_export_data_with_text","Export data data store not able to be created.~rCheck the following:~rMake sure export field names have no spaces and contain only letters, numbers and underscores, and that all fields have a width.~rYou cannot have duplicate field names~rField names cannot start with a number.",true )
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -4 		
	ELSE
	   inv_message.of_MessageBox("Caution","SyntaxFromSQL caused these errors: " + Errors,true)
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1
	END IF
END IF

ids_export_data.Create( ls_dwsyntax_str, Errors)
ids_export_data.SetTransObject( SQLCA )

//---------Begin Added by (Appeon)Toney 11.28.2013 for V141 ISG-CLX--------
//$Reason:Fix BugT112602
n_cst_dw_update_prop  ln_dwprop
IF Upper(AppeonGetClientType())="WEB" THEN
	IF ai_save_data = 1 OR ai_save_data = 3 THEN
		ln_dwprop.of_modifyupdateproperty(ids_export_data, is_savetablename,false)
	END IF
END IF
//---------End Added ------------------------------------------------------------------

//<add> andy 07.05.2007
//save the original data that it's not format,in order to deal with the computer fields
//ids_export_dataTemp = Create n_ds
ids_export_dataTemp.Create( ls_dwsyntax_str, Errors )
ids_export_dataTemp.SetTransObject( SQLCA )
//end of add

w_export_progress.r_bar.Width = 300
w_export_progress.st_progress.Text = "Populating Data for " + String(li_prac_id_cnt) + " Practitioners"

//creates string of prac_ids for querys, between...and... - Andy 07/09/2007
IF ai_type = 3 THEN
	IF li_prac_id_cnt > 0 THEN
		ls_prac_ids = "between " + String(al_prac_ids[1]) + " and " + String(al_prac_ids[li_prac_id_cnt])
	END IF
END IF

//create rows for all practitioner data
FOR i = 1 To li_prac_id_cnt
	//specify array
	IF ai_type = 2 THEN
		ls_prac_ids = ls_prac_ids + String( al_prac_ids[i] ) + ","
	END IF
	g = ids_export_data.InsertRow(0)
NEXT

IF ai_save_data = 1 Or ai_save_data = 3  Or ib_gen_rec_id THEN //Evan 01.20.2010 (V10.1 - Notification Alert)
	ids_export_data.Object.rec_id.Primary[] = al_prac_ids[]
END IF
ids_export_data.RowsCopy( 1, ids_export_data.RowCount(), Primary!, ids_export_dataTemp, 1, Primary! )

//specify array
IF ai_type = 2 THEN
	ls_prac_ids = LeftA( ls_prac_ids, LenA( ls_prac_ids ) -1 ) //remove last comma
END IF

w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + 50
w_export_progress.st_export.Text = "Form SQL Statement"

IF lb_ASA7 THEN
	ls_tabletemp = "t_export" + String(ll_SpID)
	//ls_MySQL = "CREATE TABLE " + ls_tabletemp + " (prac_id int null,FieldSeqID int null, billing_address_id int null, field_value varchar( " + String(ll_maxwidth) + ") null, field_data_type CHAR(1))"
	ls_MySQL = "if exists (select 1 from sysobjects where name = '"+ls_tabletemp +"' and type = 'U') " + " drop table " + ls_tabletemp //export error in v12 - Michael 02.17.2012
	ls_MySQL = ls_MySQL +" CREATE TABLE " + ls_tabletemp + " (prac_id int null,FieldSeqID int null, billing_address_id int null, field_value varchar( " + String(ll_maxwidth) + ") null, field_data_type CHAR(1))"
	EXECUTE Immediate :ls_MySQL;
	IF SQLCA.SQLCode <> 0 THEN
 		inv_message.of_MessageBox(gnv_app.iapp_object.DisplayName,SQLCA.SQLErrText,true)	
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1
	END IF
END IF

if lb_ai_type2 then ai_type = 1 //(Appeon)Harry 05.06.2015 
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
FOR p = 1 To li_fld_cnt
	li_width = ids_export_flds.GetItemNumber(p,"export_field_length")
	ls_field_format = ids_export_flds.GetItemString(p,"export_format")
	ls_data_value = ""
	ls_value = ""
	ls_lookup_val = ""
	li_sub_start=  0
	
	//****fixed text
	IF ids_export_flds.GetItemNumber(p,"export_type") = 2 THEN //set data for text fields
		ls_select_field = ids_export_flds.GetItemString(p,"export_field_name")
		is_field_headers[p] =  ls_select_field	//Start Code Change ----04.08.2013 #V12 maha
		ls_value = ids_export_flds.GetItemString(p,"field_value")
	
		
		IF IsNull(ls_value) THEN ls_value = ""
		
		IF ls_value = "&TODAY&" THEN			
			//ls_value = of_date_format(ls_field_format,ldt_date) //maha 070705 factored
			ls_value = String(ldt_date,"yyyy-mm-dd hh:mm") //<modify> 08/28/2007 by: Andy Reason:Support user-defined format.
			of_data_format(ls_field_format,'D',ls_value)
		END IF
		
		//Start Code Change ----01.26.2012 #V12 maha - modifed to allow getting the user name or id
		IF ls_value = "&USERID&" THEN
			ls_value = gs_user_id
		end if
		
//Start Code Change ----11.03.2016 #V153 maha	 - Additional user fields
		IF ls_value = "&USERNAME&" THEN	
			if is_user_name = "@name" then
				select user_name into :is_user_name from security_users where user_id = :gs_user_id;
			end if
			ls_value = is_user_name
		End if
		
		IF ls_value = "&USEREMAIL&" THEN	
			if is_user_email  = "@email" then
				select email_id into :is_user_email from security_users where user_id = :gs_user_id;
			end if
			ls_value = is_user_email	
		End if

		IF ls_value = "&USERSTREET1&" THEN
			if  is_user_street = "@street" then
				select user_street1 into :is_user_street from security_users where user_id = :gs_user_id;
			end if
			ls_value = is_user_street
		End if
		
		IF ls_value = "&USERSTREET2&" THEN
			if is_user_street2 = "@street2" then
				select user_street2 into :is_user_street2 from security_users where user_id = :gs_user_id;
			end if
			ls_value = is_user_street2
		End If
			
		IF ls_value = "&USERCITY&" THEN	
			if is_user_city = "@city"  then
				select user_city into :is_user_city from security_users where user_id = :gs_user_id;
			end if
			ls_value = is_user_city
		End if
			
		IF ls_value = "&USERSTATE&" THEN	
			if is_user_state = "@state" then
				select user_state into :is_user_state from security_users where user_id = :gs_user_id;
			end if
			ls_value = is_user_state
		End if
		
		IF ls_value = "&USERZIP&" THEN		
			if is_user_zip = "@zip"	then	
				select user_zip into :is_user_zip from security_users where user_id = :gs_user_id;
			end if
			ls_value = is_user_zip
		End if
			
		IF ls_value = "&USERPHONE&" THEN	
			if is_user_phone = "@phone" 	then	
				select user_phone into :is_user_phone from security_users where user_id = :gs_user_id;
			end if
			ls_value = is_user_phone
		End if
		
		IF ls_value = "&USERFAX&" THEN
			if is_user_fax = "@fax" then
				select user_fax into :is_user_fax from security_users where user_id = :gs_user_id;
			end if
			ls_value = is_user_fax
		End if
		
//End Code Change ----11.03.2016


		ls_ptype = "" //maha 120905
		CHOOSE CASE Upper(ls_value)
			CASE "&PROMPT1&"
				ls_ptype = ids_export_hdr.GetItemString(1,"prompt_type1")
				ls_value = of_prompt_populate( ls_ptype, as_param1)
			CASE "&PROMPT2&"
				ls_ptype = ids_export_hdr.GetItemString(1,"prompt_type2")
				ls_value = of_prompt_populate( ls_ptype, as_param2)
			CASE "&PROMPT3&"
				ls_ptype = ids_export_hdr.GetItemString(1,"prompt_type3")
				ls_value = of_prompt_populate( ls_ptype, as_param3)
		END CHOOSE
		//if the prompt type is date and it is a fixed text, get today() for the value 
		IF	ls_ptype = 'D' THEN
			ldt_date = DateTime(Date(ls_value),Now())
			ls_value = String(ldt_date,"yyyy-mm-dd hh:mm")
			of_data_format(ls_field_format,'D',ls_value)
		END IF

		li_sub_start = ids_export_flds.GetItemNumber(p,"export_fields_substring_start")
		IF li_sub_start > 1 THEN ls_value = MidA(ls_value,li_sub_start,li_width)
		ls_value = MidA(ls_value,1,li_width) //shrink the length to size 
		
		//if is_text_delimiter = "Q" then ls_value = '"' + ls_value + '"'  //Commented by (Appeon)Stephen 11.02.2015 - Quality Care Partners Export - OPPOC2015 //Start Code Change ----09.18.2014 #V14.2 maha
		
		FOR i = 1 To li_prac_id_cnt
			ids_export_data.SetItem(i,p,ls_value)
			ids_export_dataTemp.SetItem(i,p,ls_value) //<add> andy 07.05.2007
		NEXT
		
		//*******getting values from data
	ELSEIF ids_export_flds.GetItemNumber(p,"export_type") = 1 THEN //get FIELDS DATA
		li_module_type = ids_export_flds.getitemnumber(p, 'export_fields_module_type')
		If Isnull(li_module_type) or li_module_type = 0 Then li_module_type = 1
		lstr_gensql_param.ll_rowno = p 
		lstr_gensql_param.ls_synprefix = ls_synprefix 
		lstr_gensql_param.ls_tabletemp = ls_tabletemp
		lstr_gensql_param.ls_prac_sql = ls_prac_sql 
		lstr_gensql_param.ls_prac_ids = ls_prac_ids 
		lstr_gensql_param.ls_rowno = ls_rowno 
		If li_exp_type = 5 and li_module_type = 3 Then
			lstr_gensql_param.li_link = 3
			if of_gensql_ctx(ai_type, ll_fieldseqid, as_param1, as_param2, as_param3, ls_sny_retrieve, lstr_gensql_param) <> 1 then 
				 inv_message.of_MessageBox("Caution","SyntaxFromSQL caused these errors: " + ls_sny_retrieve,true) //(Appeon)Stephen 12.02.2015 - Bug id 4858 - Scheduler Not Responding
				return -1
			end if
		Else
			lstr_gensql_param.li_link = 0
			if of_gensql_prac(ai_type, ll_fieldseqid, as_param1, as_param2, as_param3, ls_sny_retrieve, lstr_gensql_param) <> 1 then 
				 inv_message.of_MessageBox("Caution","SyntaxFromSQL caused these errors: " + ls_sny_retrieve,true) //(Appeon)Stephen 12.02.2015 - Bug id 4858 - Scheduler Not Responding
				return -1
			end if
		End If
		if LenA(ls_sny_retrieve) > 0 then 
			if ls_UnionSQL = "" then 
				ls_UnionSQL = ls_sny_retrieve
			else 
				ls_UnionSQL = ls_UnionSQL + "~r~n union all ~r~n" + ls_sny_retrieve
			end if
		end if
	ELSE //computed fields
		//Dynamic create computed columns in order to Calculate its value
		/*1.deal with Expression**************/
		ls_export_field     = ids_export_flds.GetItemString(p,"export_field_name")
		of_replacespecchar(ls_export_field)
		ls_Expresstion      = Trim( ids_export_flds.GetItemString( p, "export_fields_expression" ) ) //db_field_name
		ls_ComputerDataType = ids_export_flds.GetItemString(p,"ctx_column_datatype")
		IF IsNull(ls_export_field) THEN ls_export_field = ''
		IF IsNull(ls_Expresstion) THEN ls_Expresstion = ''
		IF IsNull(ls_ComputerDataType) THEN ls_ComputerDataType = ''
		IF IsNull(ls_field_format) THEN ls_field_format = ''
		IF IsNull(ls_fld_delim) THEN ls_fld_delim = ''
		ll_Cnt = ids_field.RowCount()
		
		//If the computer field is numeric,add the function number(  ) in to the Expresstion.
		//Replace symbol ' with "
		FOR ll_Num = 1 To ll_Cnt
			ls_Field         = ids_field.GetItemString(ll_Num,"export_field_name")
			ls_FieldDataType = ids_field.GetItemString(ll_Num,"ctx_column_datatype")
			IF IsNull(ls_Field) THEN ls_Field = ''
			IF IsNull(ls_FieldDataType) THEN ls_FieldDataType = ''
			//<add> 07/27/2007 by: Andy 
			//Reason:The Expresstion of a computed field can't contain itself.
			IF Lower(ls_export_field) = Lower(ls_Field) THEN CONTINUE
			//end of add

			//If the field used in then computed field and is number, 
			//add the function number(  ) in to the Expresstion 
			IF PosA(Lower(ls_Expresstion),Lower(ls_Field)) > 0 THEN
				IF Upper(ls_FieldDataType) = 'N' THEN
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),0,number( " + ls_Field + " ))",True)
				ELSEIF Upper(ls_FieldDataType) = 'S' THEN
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),''," + ls_Field + " )",True)
				ELSEIF Upper(ls_FieldDataType) = 'D' THEN
					//---------Begin Modified by (Appeon)Stephen 01.27.2015 for age computation--------
					//ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),'1900-01-01'," + ls_Field + " )",True)
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "date(datetime(if( isNull( "+ls_Field+" ),'1900-01-01'," + ls_Field + " )))",True)
					//---------End Modfiied ------------------------------------------------------
				END IF
			END IF
		NEXT
		//end if
		
		//replace symbol ' with "
		ls_Expresstion  = lnvo_string.of_globalreplace( ls_Expresstion, '~~', '~~~~')
		ls_Expresstion  = lnvo_string.of_globalreplace( ls_Expresstion, '"', '~~"') //'"'
		/*end of 1***************************/
		
		ls_tag = ls_field_format + '@^@' + ls_ComputerDataType + '@^@' + String(li_width) + '@^@' + ls_fld_delim
		//2.Dynamic create computer columns,the name equal ls_Field + '_c'
		ls_Modify = "create compute(band=detail alignment='0' expression=~""+ls_Expresstion+"~" border='0' color='33554432' x='1157'" + &
			" y='4' height='64' width='242' format='[GENERAL]' html.valueishtml='0'  name=" + ls_export_field + "_c visible='0'" + &
			" font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0'" + &
			" background.mode='1' background.color='536870912' tag='" + ls_tag + "' )"
		ls_Err    = ids_export_dataTemp.Modify(ls_Modify)
		//end of 2		
	END IF
Next

//Start Code Change ----08.29.2014 #V14.2 maha
//is_billing_fields created in of_gensql_prac
//Start Code Change ----11.12.2014 #V14.2 maha - added type 
//---------Begin Modified by (Appeon)Stephen 11.17.2014 for Requesting new V14.1 web package & MSI installer for Allegheny--------
/*
IF upperbound( is_billing_fields ) > 0 then
	choose case ai_type 
		case 1
			of_create_billing_data( as_sql )
		case 2, 3	
			of_create_billing_data( ls_prac_ids )
	end choose
end if
*/

if lb_ai_type2 then ai_type = 2 //(Appeon)Harry 05.06.2015 
IF upperbound( is_billing_fields ) > 0 then
	choose case ai_type 
		case 1
			ls_sql = mid(as_sql, pos(lower(as_sql), 'from'))
			ls_sql = trim(ls_sql)
			ls_col_prac = mid(as_sql, 7, pos(lower(as_sql), "prac_id"))
			ls_sql = 'select ' + ls_col_prac +' ' + ls_sql
			of_create_billing_data( ls_sql )
		case 2
			of_create_billing_data( ls_prac_ids )
		case 3
			ls_sql = 'select prac_id from pd_basic where prac_id ' + ls_prac_ids
			of_create_billing_data( ls_sql )
	end choose
end if
//---------End Modfiied ------------------------------------------------------

//End Code Change ----11.12.2014 
//End Code Change ----08.29.2014

w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + 50
w_export_progress.st_export.Text = "Retrieve Data"

ll_FieldCnt = ll_FieldSeqID

//IF ls_UnionSQL <> "" THEN
//	IF lb_true THEN //SQL2005 and ASA9
//		ls_UnionSQL = ls_UnionSQL + "~r~n order by " + "FieldSeqID, prac_id , Row_No"
//		if of_get_app_setting("set_31","I") = 100 then //Start Code Change ----05.26.2010 #V10 maha - Inova sql v2000 option
//			ls_UnionSQL = ls_UnionSQL + " option(maxdop 1) "
//		end if
//	END IF
//	
//	IF lb_true THEN ls_RowNo = ", 0 Row_No" //SQL2005 AND ASA9
//	IF lb_ASA7 THEN
//		ls_SqlSelect = "Select prac_id,FieldSeqID,billing_address_id,field_value,field_data_type from " + ls_tabletemp
//	ELSE
//		ls_SqlSelect = "Select top 1 0 prac_id, 1 FieldSeqID, 0 billing_address_id,  cast('' as varchar(" + String(ll_maxwidth) + ")) field_value,  ' ' field_data_type" + ls_RowNo + " from pd_basic"
//	END IF
//	ls_presentation_str = "style(type=grid)"
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_SqlSelect, ls_presentation_str, Errors)
//	IF LenA(Errors) > 0 THEN
//	   inv_message.of_MessageBox("Caution on export field ","SyntaxFromSQL caused these errors: " + Errors + "~r~r" + ls_SqlSelect,true)	
//		Close(w_export_progress)
//		IF lb_ASA7 THEN
//			ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
//			EXECUTE Immediate :ls_MySQL;
//		END IF
//		of_cleanup_ds( )
//		RETURN -1
//	END IF
//
//	w = ids_export_retrieve.Create( ls_dwsyntax_str, Errors)
//	IF w < 1 THEN
//		inv_message.of_MessageBox("Error on Create",Errors,true)		
//		Close(w_export_progress)
//		IF lb_ASA7 THEN
//			ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
//			EXECUTE Immediate :ls_MySQL;
//		END IF
//		of_cleanup_ds( )
//		RETURN -1
//	END IF
//	
//	IF Not lb_ASA7 THEN
//		ids_export_retrieve.Modify('DataWindow.Table.Select="' + ls_UnionSQL + '"')
//	END IF
//	
//	ids_export_retrieve.SetTransObject( SQLCA )
//	ll_ret_cnt = ids_export_retrieve.Retrieve()
//
//	IF ll_ret_cnt < 0 THEN
//		//Reason:check syntax
//		ls_presentation_str = "style(type=grid)"
//		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_UnionSQL, ls_presentation_str, Errors)
//		IF LenA(Errors) > 0 THEN
// 			inv_message.of_MessageBox("Caution on export" ,"SyntaxFromSQL caused these errors: " + Errors ,true)	
//			Close(w_export_progress)
//			
//			IF lb_ASA7 THEN
//				ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
//				EXECUTE Immediate :ls_MySQL;
//			END IF
//			of_cleanup_ds( )
//			RETURN -3 // //Start Code Change ----.2009 #V10 maha - changed return value
//		END IF
//	END IF
//END IF

if of_create_export_ds(ls_UnionSQL, ls_tabletemp, ls_RowNo, ll_maxwidth, "prac_id") < 0 then 
	return -1
end if
ll_ret_cnt = ids_export_retrieve.rowcount( )
//messagebox("ids_export_retrieve.rowcount( )",ids_export_retrieve.rowcount( ))
w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + 60
li_bar_ticks = (1000 - 500) / li_fld_cnt

//%%%%%%%%%%%%%%%%%%%%%%%%%%%% end of create syntax

ls_prac_field = ids_export_retrieve.Describe("#1.name")

DO While (ll_i <= ll_ret_cnt)
	ll_j = 0
	ls_data_value = ""
	ls_value = ""
	ls_lookup_val = ""
	//ldt_value = DateTime(Date("0000-00-00"),Time("00:00:00"))//Comment by Appeon long.zhang 09.27.2016
	
	ll_pracid       = ids_export_retrieve.GetItemNumber(ll_i,ls_prac_field)
	ll_FieldSeqID   = ids_export_retrieve.GetItemNumber(ll_i,"FieldSeqID")
	li_recd_no      = ii_recdnoList[ll_FieldSeqID]
	ls_select_table = is_tablelist[ll_FieldSeqID]
	ls_select_field = is_selectfieldlist[ll_FieldSeqID]
	ls_datatype 	 = is_typelist[ll_FieldSeqID] //Alfee 11.13.200		
	li_billing 		 = ii_billingList[ll_FieldSeqID] //Alfee 11.13.200		
	ls_export_field = is_fieldlist[ll_FieldSeqID]
	ls_field_format = is_formatList[ll_FieldSeqID]
	ll_export_code  = il_exportcodeList[ll_FieldSeqID]
//	if ll_export_code > 0 then debugbreak()   // messagebox("export code", ll_export_code)
	li_sub_start    = ii_substartList[ll_FieldSeqID]
	li_width        = ii_widthList[ll_FieldSeqID]
	ls_fld_delim    = is_flddelimList[ll_FieldSeqID]
	ls_text         = is_textList[ll_FieldSeqID]
	ls_lu_field     = is_lu_fieldList[ll_FieldSeqID]
	li_facil_id     = ii_facil_idList[ll_FieldSeqID]
	li_act_format   = ii_act_formatList[ll_FieldSeqID]
	ls_islookup = is_lookup[ll_FieldSeqID] //(Appeon)Harry 02.27.2015 - for Bug # 4430
	
	ud = ii_udList[ll_FieldSeqID]
	IF ud = 1 Or ud = 3 THEN
		ls_def_val = is_defvalList[ll_FieldSeqID]
	ELSEIF ud = 2 THEN //column default
		col = Long(is_defvalList[ll_FieldSeqID])
	ELSE
		ls_def_val = ""
	END IF
	
	IF ll_FieldSeqIDold <> ll_FieldSeqID THEN
		Yield() //Added by Appeon long.zhang 09.27.2016
		
		ll_R = 0
		ib_flag=true//For optimize export  Added by  Nova 03.26.2010
		ll_FieldSeqIDold = ll_FieldSeqID
		w_export_progress.st_export.Text  = ls_select_table + "_" + ls_select_field //string(ll_FieldSeqID) + "   " + 
		w_export_progress.st_export1.Text = ls_select_field
		w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + li_bar_ticks //* (ll_R - ll_Rorig)
//		if isvalid(ids_billing) then destroy ids_billing //add by stephen 04.18.2013 -Bug 3487:System Error when running export

		//Find the end of current FieldSeqId , Added by Appeon long.zhang 09.27.2016 (for Bug id 5309 - Auto Scheduler is returning an error SaaS V14.2 Build date 05022016)
		ls_find = "( FieldSeqID  > " + String(ll_FieldSeqID) + ")"
		ll_row_fieldseq_end   = ids_export_retrieve.Find ( ls_find, ll_i + 1, ll_ret_cnt )
		
		//Check column name
		IF Lower(ids_export_data.Describe(ls_export_field + ".name")) = Lower(ls_export_field) THEN
			lb_export_field_checked = True
		Else
			lb_export_field_checked = False
		End If
	else
		ib_flag=false//For optimize export  Added by  Nova 03.26.2010	
	end if
	
	//---------Begin Added by (Appeon)Stephen 12.11.2014 for 00051163 / Export Does Not Show Providers Licenses--------
	ll_R_old = ll_R
	lb_find = false
	//---------End Added ------------------------------------------------------
	
	FOR ll_R = ll_R + 1 To li_prac_id_cnt
		//---------Begin Modified by (Appeon)Stephen 12.11.2014 for 00051163 / Export Does Not Show Providers Licenses--------
		//IF al_prac_ids[ll_R] = ll_pracid THEN EXIT
		IF al_prac_ids[ll_R] = ll_pracid THEN 
			lb_find = true
			EXIT
		end if
		//---------End Modfiied ------------------------------------------------------
		
	NEXT

	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 09.27.2016
	//<$>reason:Don't use find , it costs too much. For Bug id 5309 - Auto Scheduler is returning an error SaaS V14.2 Build date 05022016.
//	ls_find = "(" + ls_prac_field + " > " + String(ll_pracid) + " AND FieldSeqID = " + String(ll_FieldSeqID) + &
//		") OR ( FieldSeqID  > " + String(ll_FieldSeqID) + ")"
//	ll_j    = ids_export_retrieve.Find ( ls_find, ll_i + 1, ll_ret_cnt )

	If ll_row_fieldseq_end = 0 Then
		ll_j = 0
		For k = ll_i + 1 to ll_ret_cnt
			If ids_export_retrieve.GetItemNumber(k, ls_prac_field) > ll_pracid Then
				ll_j = k
				Exit
			End If
		Next	
	Else
		ll_j = 0
		For k = ll_i + 1 to (ll_row_fieldseq_end - 1)
			If ids_export_retrieve.GetItemNumber(k, ls_prac_field) > ll_pracid Then
				ll_j = k
				Exit
			End If
		Next
		
		If ll_j = 0 Then ll_j = ll_row_fieldseq_end
	End If
	//------------------- APPEON END -------------------
	
	IF ll_j > 0 THEN
		//The max row of the current FieldSeqID
		ll_j = ll_j - 1
	END IF
	
	//Perhaps it is the last ll_pracid and it is the max FieldSeqID,
	//then set ll_j = ll_ret_cnt(max row in the ds)
	IF ll_j = 0 THEN
		ll_j = ll_ret_cnt
	END IF
	
	//---------Begin Added by (Appeon)Stephen 12.11.2014 for 00051163 / Export Does Not Show Providers Licenses--------
	if lb_find = false then
		ll_R = ll_R_old
		ll_i = ll_j + 1
		continue
	end if
	//---------End Added ------------------------------------------------------
	
	//max - min + 1 = total(current FieldSeqID)
	IF ll_j - ll_i + 1 >= li_recd_no THEN 		//find out
		ll_prac_row = ll_i + li_recd_no - 1
	ELSE 		//Not 
		ll_prac_row = 0
	END IF
	
	//process data
	IF ll_prac_row > 0 THEN
		//IF li_billing = 1 THEN //maha app080205 to get billing address data 
		IF li_billing = 1 and PosA(ls_select_table, "pd_address",1) > 0 then //Start Code Change ----03.14.2013 #V12 maha - trap for billing link on non- address table
			ll_billing_id   = ids_export_retrieve.GetItemNumber(ll_prac_row, "billing_address_id" )
			//---------Begin Added by (Appeon)Stephen 09.03.2014 for Bug 4157 - Export multirows and billing addresses--------
			/* //modified by (Appeon)Stephen 09.05.2014 - 
			ls_lu_type = ids_export_flds.getitemstring(ll_FieldSeqID,"db_lookup_type") 		
			if ls_lu_type = "A" or ls_lu_type = "C" then
				ls_data_value = ids_export_retrieve.GetItemString(ll_prac_row, "field_value")
			else
			end if
			*/
			ls_lu_type = is_lu_type[ll_FieldSeqID]
			ls_lu_select_field = is_lu_selectfieldlist[ll_FieldSeqID]
			ls_lu_data_type 	 = is_lu_typelist[ll_FieldSeqID]
			//ls_data_value = of_get_billing(ll_billing_id,ls_datatype,ls_select_field,ls_field_format,is_billsynList[ll_FieldSeqID])
			ls_data_value = of_get_billing_new(ll_billing_id,ls_lu_select_field,ls_lu_data_type,ls_field_format) //Start Code Change ----08.29.2014 #V14.2 maha			
			
			choose case ls_lu_type
				case "A"					
					ls_data_value =  gnv_data.of_getitem( "address_lookup", ls_lu_field, "lookup_code = " + ls_data_value)
				case "C"
					ls_data_value = gnv_data.of_getitem( "code_lookup", ls_lu_field, "lookup_code = " + ls_data_value)
			end choose
			//---------End Added ------------------------------------------------------
				
			if not isvalid(w_export_progress) then //add by stephen 04.18.2013 -Bug 3487:System Error when running export
				 inv_message.of_MessageBox("Caution","System Error " ,true) //(Appeon)Stephen 12.02.2015 - Bug id 4858 - Scheduler Not Responding
				return -1 
			end if
		ELSE
			ls_data_value = ids_export_retrieve.GetItemString(ll_prac_row, "field_value")
		END IF
	ELSE
		//do nothing
	END IF
	
	//IF Lower(ids_export_dataTemp.Describe(ls_export_field + ".name")) = Lower(ls_export_field) THEN
	If lb_export_field_checked Then //Don't use describe for every row,ids_export_data and ids_export_dataTemp has same columns except compute fields, Added by Appeon long.zhang 09.28.2016 (For Bug id 5309 - Auto Scheduler is returning an error SaaS V14.2 Build date 05022016)
		//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
		//Begin - Added By Mark Lee 09/29/12 its cannot use double quote to merge data values in  the MS word.
		If Pos(ls_data_value,'"') > 0 Then 
			gnv_debug.of_output(false, 'Alarm  Export: Its used the double quote Replace the blank data in merged data value on the column ['+ls_export_field+'], and this current data value is the ['+ls_data_value+'].' ) //true->false alfee 04.29.2015
			ls_data_value  = lnvo_string.of_globalreplace( ls_data_value, '"', ' ')
		End If
		//End - Added By Mark Lee 09/29/12
		//---------End Added ------------------------------------------------------------------
		ids_export_dataTemp.SetItem(ll_R,ls_export_field,ls_data_value)
	END IF
	IF ls_format = "export" THEN
		IF IsNull(ls_data_value) THEN ls_data_value = ""
	END IF
	of_data_format(ls_field_format,ls_datatype,ls_data_value)
	

	//*****GET EXPORT CODES
	IF ll_export_code  = 1 THEN //get export code if required

		ls_lookup_val = ls_data_value //ids_export_data.getitemstring(i,p) //changed 100102
		//use datastore
		IF IsNull(ls_lookup_val) THEN ls_lookup_val = ''
//Start Code Change ----11.05.2014 #V14.2 maha - corrected for code values
		//if upper(ls_lu_field) = "LOOKUP_CODE" then //Commented by (Appeon)Harry 02.27.2015 
		ls_find2 = ""  //(Appeon)Harry 04.07.2015 - for Allegheny export issue
		if upper(ls_lu_field) = "LOOKUP_CODE" or ls_islookup = 'N' then //(Appeon)Harry 02.27.2015 - for Bug # 4430
			if len(ls_lookup_val) <=0 then ls_lookup_val = '0'
			ls_find2 = "export_id = " + String(ai_export_id) + " and lookup_code = " + ls_lookup_val
		elseif upper( ls_lu_field) = "CODE" then
			ls_find2 = "export_id = " + String(ai_export_id) + " and code = '" + ls_lookup_val + "'"
		end if
//End Code Change ----11.05.2014
		ll_equivcode = ids_export_equiv_code.Find( ls_find2, 0, ll_equivcodeCnt)
//		if ll_equivcode < 0 then
//			messagebox( "Failure with export code find", ls_find2 )
//		end if
		IF ll_equivcode > 0 THEN
			ls_value = ids_export_equiv_code.GetItemString(ll_equivcode,"equiv_code")
		END IF
		IF Not IsNull(ls_value) And Trim(ls_value) <> '' THEN ls_data_value = ls_value //if no export code use org value
		IF IsNull(ls_data_value) THEN ls_data_value = ""
	END IF
	
	//****Dept Chair data  maha 010704
	ls_dc_field = is_dcfieldList[ll_FieldSeqID]
	IF ls_dc_field = 'none' Or IsNull(ls_dc_field) THEN
		//skip
	ELSE //if set to a field name get the data
		IF IsNumber(ls_data_value) THEN
			//---------Begin Modified by (Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
			/*
			IF ids_dept_chair.Retrieve(li_facil_id,Long(ls_data_value)) > 0 THEN
				ls_data_value = ids_dept_chair.GetItemString(1,ls_dc_field)
			ELSE
				ls_data_value = ""
			END IF
			*/
//			ll_find = ids_dept_chair.Find("facility_id = " +  String(li_facil_id) + " and department_code = " + "'" + ls_data_value + "'",1,ll_rowcount)
			ll_find = ids_dept_chair.Find("facility_id = " +  String(li_facil_id) + " and department_code = " + ls_data_value, 1, ll_rowcount) //Delete quoters around ls_data_value, modified by Appeon long.zhang 05.15.2017 (Dept Chair link field in Export not working (Bug #5642))
			If ll_find > 0 Then
				ls_data_value = ids_dept_chair.GetItemString(ll_find,ls_dc_field)
			Else
				ls_data_value = ""
			End If
			//---------End Modfiied ------------------------------------------------------
		END IF
	END IF
	//Active Status format for affil stat maha 083105
	//if ids_export_flds.getitemnumber(p,"intcred_field") = 100000 then
	ll_intcred_field = il_intcredfieldList[ll_FieldSeqID]
	IF ll_intcred_field = 100000 THEN
		IF li_act_format = 1 THEN
			IF ls_data_value = "1" THEN
				ls_data_value = "Y"
			ELSE
				ls_data_value = "N"
			END IF
		ELSEIF li_act_format = 2 THEN
			CHOOSE CASE ls_data_value
				CASE "1"
					ls_data_value = "Active"
				CASE "2"
					ls_data_value = "Purge"
				CASE "3"
					ls_data_value = "Inactive"
				CASE "4"
					ls_data_value = "Pending"
				CASE "0"
					ls_data_value = "History"
				CASE "6"  //Start Code Change ----10.10.2014 #V14.2 maha
					ls_data_value = "Mid-cycle"
			END CHOOSE
		END IF
	END IF
	//--------Begin Added by Nova 10.30.2009------------------------
	IF ls_select_field = 'active_status' And ls_select_table = "pd_priv_list"  THEN
		CHOOSE CASE ls_data_value
			CASE '1'
				ls_data_value = 'Active'
			CASE '0'
				ls_data_value = 'History'
		END CHOOSE
	END IF
	//--------End Added --------------------------------------------
	IF ls_strip_char <> "NONE" THEN
		ls_data_value = of_strip_char( ls_strip_char ,ls_data_value, "")
	END IF
	IF li_sub_start > 1 THEN ls_data_value = MidA(ls_data_value,li_sub_start,li_width)
	
	//***padding //note if avoid using return, double return, empty string or tab when padding
	ls_data_value = MidA(ls_data_value,1,li_width) //shrink the length to size 
	IF ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" THEN
		IF li_width - LenA(ls_data_value) > 0 THEN
			li_dif = li_width - LenA(ls_data_value)
			ls_pad = "" //reset
			ls_pad = FillA ( ls_fld_delim, li_dif )
			IF ls_field_format = "Leading Padding" THEN
				ls_data_value = ls_pad + ls_data_value
			ELSE
				ls_data_value = ls_data_value + ls_pad
			END IF
		END IF
	ELSEIF ls_field_format = "use text" THEN //allows a set value if data is found
		IF LenA(ls_data_value) > 0 THEN
			ls_data_value = ls_text
		END IF
	ELSEIF ls_field_format = "Numbers" THEN //Start Code Change ----04.21.2008 #V8 maha - added for strip to numbers
		ls_data_value = of_strip_char( "#", ls_data_value ,  "@NUM@")
	END IF
	
	//****set default moved here 091305
	IF ud > 0 THEN
		IF ud = 3 THEN
			ls_data_value = ls_def_val + ls_data_value
		END IF
		IF IsNull(ls_data_value) THEN ls_data_value = ""
		IF ls_data_value = "" THEN
			IF ud = 1 THEN
				ls_data_value = ls_def_val
			ELSEIF ud = 2 THEN //if set to column get the value out of that column
				IF col < 1 Or col > li_fld_cnt THEN //setting trap
 					inv_message.of_MessageBox("Invalid setting","You are using a column default for column " + ls_export_field + " , but your default value is not a valid column number.~rThe default column number must be less than this column.",true)	
					Close(w_export_progress)
					IF lb_ASA7 THEN
						ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
						EXECUTE Immediate :ls_MySQL;
					END IF
					of_cleanup_ds( )
					RETURN 0
				END IF
				ls_data_value = ids_export_data.GetItemString(ll_R,col)
			END IF
		END IF
	END IF
	
	//Start Code Change ----09.18.2014 #V14.2 maha
	//---------Begin Commented by (Appeon)Stephen 05.31.2013 for Quality Care Partners Export - OPPOC2015--------
	/*
	if is_text_delimiter = "Q" then
		ls_data_value = '"' + ls_data_value + '"'
	end if
	*/
	//End Code Change ----09.18.2014
	//---------End Commented ------------------------------------------------------
	
	//*********value set**********
	//IF Lower(ids_export_data.Describe(ls_export_field + ".name")) = Lower(ls_export_field) THEN
	If lb_export_field_checked Then //Don't use describe for every row, Added by Appeon long.zhang 09.28.2016 (For Bug id 5309 - Auto Scheduler is returning an error SaaS V14.2 Build date 05022016)
		ids_export_data.SetItem(ll_R,ls_export_field,ls_data_value)
	END IF
	
	//processing the next field(fieldseqid)
	ll_i = ll_j + 1
LOOP

//if isvalid(ids_billing) then destroy ids_billing//For optimize export  Added by  Nova 03.26.2010
//process default value
IF of_export_processdefault(ids_export_hdr,ids_export_flds,ids_export_dataTemp,ids_export_data) = -1 THEN
	Close(w_export_progress)
	IF lb_ASA7 THEN
		ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
		EXECUTE Immediate :ls_MySQL;
	END IF
	 inv_message.of_MessageBox("Caution","process default value Error" ,true) //(Appeon)Stephen 12.02.2015 - Bug id 4858 - Scheduler Not Responding
	of_cleanup_ds( )
	RETURN 0
END IF

//set Calculated field value and format into lds_export_data 
//with the relative computer column in lds_export_dataTemp
//---------Begin moved by (Appeon)Stephen 09.12.2014 for bug Id 4216 Export multi-row and calculated fields--------
/*
of_export_calculatedfield(ids_export_dataTemp,ids_export_data,ls_format)
w_export_progress.r_bar.Width = 1000
*/
//---------End Modfiied ------------------------------------------------------
//@@@@@@@@@@@@@@@@@@@multi row function @@@@@@@@@@@@@@@@
IF li_multi_table > 0 THEN
	w = 1
	FOR a = 1 To li_fld_cnt //get list of fields
		IF ids_export_flds.GetItemNumber(a,"intcred_table") = li_multi_table THEN
			li_multi_field[w] = a
			w++
		END IF
	NEXT
//	debugbreak()
	//Start Code Change ---- 10.01.2007 #V7 maha added code for the multi table where and modified function call
	li_pos1 = PosA(Upper(ls_multi_where),"PROMPT1",1)
	IF li_pos1 > 0 THEN
		ls_multi_where = MidA(ls_multi_where,1,li_pos1 - 1) + as_param1 + MidA(ls_multi_where,li_pos1 + 7)
	END IF
	li_pos1 = PosA(Upper(ls_multi_where),"PROMPT2",1)
	IF li_pos1 > 0 THEN
		ls_multi_where = MidA(ls_multi_where,1,li_pos1 - 1) + as_param2 + MidA(ls_multi_where,li_pos1 + 7)
	END IF
	li_pos1 = PosA(Upper(ls_multi_where),"PROMPT3",1)
	IF li_pos1 > 0 THEN
		ls_multi_where = MidA(ls_multi_where,1,li_pos1 - 1) + as_param3 + MidA(ls_multi_where,li_pos1 + 7)
	END IF
	
	//---------Begin Added by (Appeon)Stephen 12.26.2014 for  Bug # 4365 - Export hangs up or Errors out when it is working on a large number of records--------
	//of_multi_row(ids_export_data,"not used",li_multi_table,li_multi_field[],ids_export_flds,al_prac_ids[],ls_multi_where)
		choose case ai_type 
		case 1
			ls_sql_prac = mid(as_sql, pos(lower(as_sql), ' from '))
			ls_sql_prac = trim(ls_sql_prac)
			ls_col_prac = mid(as_sql, 7, pos(lower(as_sql), "prac_id"))
			ls_sql_prac = 'select ' + ls_col_prac +' ' + ls_sql_prac
		case 2
			ls_sql_prac = ls_prac_ids
		case 3
			ls_sql_prac = "select prac_id from pd_basic where prac_id " + ls_prac_ids 
	end choose
	if right(ls_sql_prac,1) = "," or right(ls_sql_prac,1)=";" then ls_sql_prac = midA(ls_sql_prac, 1, len(ls_sql_prac) -1)
	of_multi_row_new(ids_export_data,"not used",li_multi_table,li_multi_field[],ids_export_flds,al_prac_ids[],ls_multi_where, ls_sql_prac)
	//---------End Added ------------------------------------------------------
	
	li_prac_id_cnt = ids_export_data.rowcount() 
	//End Code Change---10.01.2007
END IF

//---------Begin Added by (Appeon)Stephen 07.11.2016 for Export computed field issue--------
ids_export_dataTemp.reset()
ids_export_data.RowsCopy( 1, ids_export_data.RowCount(), Primary!, ids_export_dataTemp, 1, Primary! )
//---------End Added ------------------------------------------------------
of_export_calculatedfield(ids_export_dataTemp,ids_export_data,ls_format) //(Appeon)Stephen 09.12.2014 - bug Id 4216 Export multi-row and calculated fields
//end multi row


//1:save / 3:save & preview
IF ai_save_data = 1 Or ai_save_data = 3 THEN
	w_export_progress.st_progress.Text = "Saving File"
	w_export_progress.r_bar.Width = 500
	sd = ids_export_data.Update()
	IF sd < 1 THEN
	 	inv_message.of_MessageBox("Save error","Unable to save data to table",true)			
	END IF
	COMMIT Using SQLCA;
END IF

w_export_progress.r_bar.Width = 1000

//******************************* CREATE FILE
//\/maha 121205 moved out of first portion of if statement below; rebuilt file naming
w_export_progress.st_progress.Text = "Creating File"
w_export_progress.r_bar.Width = 300

li_bar_ticks = 1000 / li_fld_cnt
ls_save_path = as_path

IF RightA(ls_save_path,1) = ':' THEN ls_save_path = ls_save_path + "\"
ll_lastpos = LastPos(ls_save_path,'.')

IF ll_lastpos > 0 THEN
	IF LenA(ls_save_path) - ll_pos < 5 THEN //Start Code Change ----07.30.2009 #V92 maha - trap for development where the path may include a dot
		ls_save_path = LeftA(ls_save_path,ll_lastpos - 1)
	END IF
END IF

//create name of file
IF MidA(ls_save_path,LenA(ls_save_path),1) <> "\" THEN //maha app 102405 if a file name is indicated do not tack on the table name
	ls_path = ls_save_path + ls_format
ELSE
	CHOOSE CASE li_custom_save
		CASE 1,2,3,4,6   //Start Code Change ----08.18.2014 #V14.2 maha - added 4 ; maha 03.05.2015  - added 6
			ls_save_name = of_custom_name(li_custom_save,ls_table_name,ldt_date)
		CASE ELSE //0,509.27
			ls_save_name = ls_table_name
	END CHOOSE
	
	//Start Code Change ----08.28.2014 #V14.2 maha - added option for form_csv
	if ls_format = "form_csv" then
		ls_path = ls_save_path + ls_save_name + ".csv"
	else
		ls_path = ls_save_path + ls_save_name + ls_format
	end if
	//Start Code Change ----08.28.2014 
END IF

as_path = ls_path
ls_save_path = MidA(ls_path,1,lastpos(ls_path,'\'))
gnv_appeondll.of_parsepath(ls_save_path)

//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 2011-01-11.
If invo_rights.of_check_dir_right(ls_save_path,true,"Export") <> 1 Then
	//Messagebox('','')
	ls_save_path = gs_temp_path + "ExportData\"
	gnv_appeondll.of_parsepath(ls_save_path)	
End If
//---------End Added ------------------------------------------------------------------

//Start Code Change ----03.02.2010 #V10 maha
if LenA(ls_post_sort) > 0 and ai_type <>2 then  //(Appeon)Stephen 02.03.2015 - add 'ai_type <>2'-- Right Letter But Wrong Data Sent to Multiple Providers
	ids_export_data.setsort(ls_post_sort)
	ids_export_data.sort()
end if
//End Code Change---03.02.2010

gl_export_rows_count  = ids_export_data.rowcount()  //maha 05.06.2015 - used for trapping count mismatches when used as a letter datasource.

IF lb_export = False THEN //if the auto export path is blank use the export path, if blank use the hard coded path
    //------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 03.26.2013
	//$<reason>  V12.3	Add ‘Drop Column Before Saving File’
	/* 	CHOOSE CASE ls_format
		CASE ".txt" //tab delimited
			IF ls_header = "1" THEN
				g = ids_export_data.SaveAs(ls_path,Text!,True)
			ELSE
				g = ids_export_data.SaveAs(ls_path,Text!,False)
			END IF
		CASE ".xls" //excel
			IF ls_header = "1" THEN
				g = ids_export_data_drop.SaveAs(ls_path,excel!,True)
			ELSE
				g = ids_export_data_drop.SaveAs(ls_path,excel!,False)
			END IF
		CASE ".csv" //excel
			IF ls_header = "1" THEN
				g = ids_export_data.SaveAs(ls_path,csv!,True)
			ELSE
				g = ids_export_data.SaveAs(ls_path,csv!,False)
			END IF
	END CHOOSE */
	//Start Code Change ----04.08.2013 #V12 maha - for nammspass export
	if is_header_rebuild = "NP" then
		string field_name
		string efc
		ids_export_data.insertrow(1)
		for i = 1 to upperbound(is_field_headers[] )
			field_name = upper(is_field_headers[i])
			if field_name = "FIRST_" then field_name = "FIRST"
			ids_export_data.setitem(1, i, field_name )
		next
	end if
	//Start Code Change ----08.08.2013
	
	 if ls_header = "1" then
		g = of_copy_expdata(ids_export_data, ls_format, true, ls_path, true)
		if g <> 1 then return 0 
	else
		g = of_copy_expdata(ids_export_data, ls_format, false, ls_path, true)
		if g <> 1 then return 0 
	end if
	//------------------- APPEON END -------------------
	
	w_export_progress.r_bar.Width = 1000
	IF g = -1 THEN 
 	inv_message.of_MessageBox("saveas -1","Unable to save file.  Check path (" + ls_path + ") and make sure a copy of the file is not open.",true)	
	end if	
ELSE //export and csv files
	//build export text file
	li_file_num = FileOpen(ls_path, lineMode!, Write!, LockWrite!, Replace!) //maha changed to line mode 091002
	
	//Start Code Change ----10.19.2010 #V10 maha
	if len(ls_hdr_record ) > 0 then
		FileWrite ( li_file_num, ls_hdr_record )
	end if
	//End Code Change---10.19.2010
	
	if of_copy_expdata(ids_export_data, '', false, '', false) <> 1 then return 0 //add by Stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	
	

	 //Start Code Change ----03.05.2015 #V15 maha - Added for CAQH roster format including headers
	if lb_export and ls_header = "1" then
		FOR p = 1 To li_fld_cnt
			ls_fld_delim = ids_export_flds.GetItemString( p, "trailing_leading_characters")
			
			li_drop_col = ids_export_flds.GetItemNumber(p,"drop_column")
			if isnull(li_drop_col) then li_drop_col = 0
			if  li_drop_col = 1 then continue 
			
			CHOOSE CASE ls_fld_delim
				CASE "E" //empty String
					ls_delim_value = ""
				CASE "S" // space
					ls_delim_value = " "
				CASE "T" //tab
					ls_delim_value = "	"
				CASE "R" //return
					ls_delim_value = "~r"
				CASE "D" //double return
					ls_delim_value = "~r~r"

				CASE ELSE
					ls_delim_value = ls_fld_delim
			END CHOOSE
			IF IsNull(ls_delim_value) THEN ls_delim_value = ""
			
			ls_header_string = ls_header_string + is_field_headers[p] + ls_delim_value
			
		next
		//add record delimiter
	//	ls_header_string = ls_header_string + ls_rec_delim
//		ls_header_string = ls_header_string + "~r~n"
		g = FileWrite ( li_file_num,ls_header_string)
	end if
	 //End Code Change ----03.05.2015
	

	//Initiate arrays by ids_export_flds settings to increase speed, Added by Appeon long.zhang 11.08.2016 
	FOR p = 1 To li_fld_cnt
		ls_fld_delim_array[p] = ids_export_flds.GetItemString( p, "trailing_leading_characters")
		ls_field_format_array[p]  = ids_export_flds.GetItemString(p,"export_format")
		li_drop_col_array[p]  = ids_export_flds.GetItemNumber(p,"drop_column")
		if isnull(li_drop_col_array[p] ) then li_drop_col_array[p]  = 0
	
		//in a csv file force all field delimiters to comma
		IF ls_format = ".csv" THEN
			ls_fld_delim_array[p]  = ","	
			ls_rec_delim = ""
		ElseIf ls_format = "form_csv" THEN
			ls_rec_delim = "" //the filewrite will add CR and LF so delimiter is not required
		END IF

		CHOOSE CASE ls_fld_delim_array[p]
			CASE "E" //empty String
				ls_delim_value_array[p]  = ""
			CASE "S" // space
				ls_delim_value_array[p]  = " "
			CASE "T" //tab
				ls_delim_value_array[p]  = "	"
			CASE "R" //return
				ls_delim_value_array[p]  = "~r"
			CASE "D" //double return
				ls_delim_value_array[p]  = "~r~r"
			CASE "L" //line feed
				ls_delim_value_array[p]  = "~r~n"
			CASE ELSE
				ls_delim_value_array[p]  = ls_fld_delim_array[p] 
		END CHOOSE
		IF IsNull(ls_delim_value_array[p] ) THEN ls_delim_value_array[p]  = "" 
		
		If ls_field_format_array[p] = "Leading Padding" Or ls_field_format_array[p] = "Trailing Padding" Then//don't add delimit value
			lb_pading[p]  = True
			ls_delim_value_array[p] = ''
		Else
			lb_pading[p] = False
		End If
	Next	
	
	
	FOR i = 1 To  ids_export_data.rowcount()  //li_prac_id_cnt //Start Code Change ----09.11.2014 #V14.2 maha - changed for multi-rows
		
		//w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + li_bar_ticks	//Wrong code, Comment by Appeon long.zhang 11.07.2016
		ls_export_text_file = ""	
		
		
		FOR p = 1 To li_fld_cnt
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 11.07.2016
			//<$>reason:Increase speed, for Case 67116 - Export Erring after an hour, SaaS v15.1 10132016
	
//			ls_data_value = ids_export_data.GetItemString(i,p)
//			ls_fld_delim = ids_export_flds.GetItemString( p, "trailing_leading_characters")
//			ls_field_format = ids_export_flds.GetItemString(p,"export_format")
//			
//			//------------------- APPEON BEGIN -------------------
//			//$<add> stephen  03.26.2013
//			//$<reason> V12.3	Add ‘Drop Column Before Saving File’
//			li_drop_col = ids_export_flds.GetItemNumber(p,"drop_column")
//			if isnull(li_drop_col) then li_drop_col = 0
//			if  li_drop_col = 1 then continue 
//			//------------------- APPEON END -------------------
//		
//			IF IsNull(ls_data_value) THEN ls_data_value = "" //maha 012306 added trap
//			ll_total_data_len = ll_total_data_len + len(ls_data_value)   //Start Code Change ----04.15.2015 #V15 maha - trap for no returned data
//			//maha 121205 in a csv file force all field delimiters to comma
//			IF ls_format = ".csv" THEN
//				ls_fld_delim = ","
//				ls_rec_delim = ""
//			END IF
//			ls_field_format = ids_export_flds.GetItemString(p,"export_format")
//			CHOOSE CASE ls_fld_delim
//				CASE "E" //empty String
//					ls_delim_value = ""
//				CASE "S" // space
//					ls_delim_value = " "
//				CASE "T" //tab
//					ls_delim_value = "	"
//				CASE "R" //return
//					ls_delim_value = "~r"
//				CASE "D" //double return
//					ls_delim_value = "~r~r"
//				CASE "L" //line feed
//					ls_delim_value = "~r~n"
//				CASE ELSE
//					ls_delim_value = ls_fld_delim
//			END CHOOSE
//			IF IsNull(ls_delim_value) THEN ls_delim_value = ""

			ls_data_value = ids_export_data.GetItemString(i,p)
			IF IsNull(ls_data_value) THEN ls_data_value = ""
			
			//ls_field_format = ls_field_format_array[p]
			
			//Add ‘Drop Column Before Saving File’
			//li_drop_col = li_drop_col_array[p]
			//if  li_drop_col = 1 then continue 
			if  li_drop_col_array[p] = 1 then continue 
		
			//ll_total_data_len = ll_total_data_len + len(ls_data_value)   //Start Code Change ----04.15.2015 #V15 maha - trap for no returned data
			//ls_delim_value = ls_delim_value_array[p]
			If Not lb_total_data_len Then lb_total_data_len = (len(ls_data_value) > 0)			
						
//			IF ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" THEN //don't add delimit value
//				ls_export_text_file = ls_export_text_file + ls_data_value
//			ELSE
//				IF ls_format = ".csv"  And p = li_fld_cnt THEN
//				elseif ls_format = "form_csv" then
//					 ls_rec_delim = ""  //Start Code Change ----09.22.2014 #V14.2 maha - the filewrite will add CR and LF so delimiter is not required
//					 ls_export_text_file = ls_export_text_file + ls_data_value  + ls_delim_value
//				ELSE
//					ls_export_text_file = ls_export_text_file + ls_data_value + ls_delim_value
//				END IF
//			END IF

			IF ls_format = ".csv"  And p = li_fld_cnt And Not lb_pading[p] THEN
			ELSE
				ls_export_text_file = ls_export_text_file + ls_data_value + ls_delim_value_array[p]
			END IF		
			//------------------- APPEON END -------------------	
		
		NEXT
		
		
		ls_export_text_file = ls_export_text_file + ls_rec_delim
		p = 1
		//following for line mode //set 091002
		g = FileWrite ( li_file_num, ls_export_text_file)
		IF g = -1 THEN
 			inv_message.of_MessageBox("File write error record # " + String(i) ,"Unable to write to file " + ls_path + " .",true)	
			li_fail_count++
		END IF		
		IF li_fail_count = 3 THEN
 			inv_message.of_MessageBox("File write error" ,"Repeted fail to write to file " + ls_path + " .  Aborting export write.  Check directory/file permissions.",true)	
			EXIT
		END IF
		
		
	NEXT
	
	//Start Code Change ----10.19.2010 #V10 maha
	if len(ls_trail_record ) > 0 then
		FileWrite ( li_file_num, ls_trail_record )
	end if
	//End Code Change---10.19.2010	
	FileClose(li_file_num)

	//Start Code Change ----04.15.2015 #V15 maha - trap for no returned data
	//if ll_total_data_len = 0 then  
	if Not lb_total_data_len then //Increase speed, modified by Appeon long.zhang 11.07.2016
		inv_message.of_MessageBox("Export data error " ,"No data appears to have been retieved from the database",true)
		of_cleanup_ds( )
		Close(w_export_progress)
		return -1
	end if
	//End Code Change ----04.15.2015
END IF

Close(w_export_progress)
ids_export_data = ids_export_data //When IntelliCred Email call it,Merge field failed,so add it. <add> 06.06.2008 by Andy
inv_message.of_set_proc_cnt(ids_export_data.rowcount()) 

//2:preview / 3:save & rpeview
IF ai_save_data = 2 Or ai_save_data = 3 THEN
	//------------------- APPEON BEGIN -------------------
	//$<modify> V12.3 Add ‘Drop Column Before Saving File’ - stephen 03.26.2013
   	lstr_pass.s_string = is_select_syntax_drop  //	lstr_pass.s_string = is_select_syntax
	lstr_pass.s_dw = ids_export_data_drop //	lstr_pass.s_dw = ids_export_data  
	//------------------- APPEON END -------------------
	lstr_pass.s_string_array[1] = ls_UnionSQL //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
	OpenWithParm( w_export_previewdata, lstr_pass )
END IF

IF lb_ASA7 THEN
	ls_MySQL = "DROP TABLE " + ls_tabletemp + ";"
	EXECUTE Immediate :ls_MySQL;
END IF

IF lb_mulsel THEN
	ls_MySQL = "DELETE FROM export_temp WHERE SpID = " + String(ll_SpID) + ";"
	EXECUTE Immediate :ls_MySQL;
END IF

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 01.20.2010
//$<reason> V10.1 - Notification Alert
ls_dwsyntax_str = ids_export_data.Describe("datawindow.syntax")
ids_cred_export_data.Create(ls_dwsyntax_str)
ids_export_data.RowsCopy(1, ids_export_data.RowCount(), Primary!, ids_cred_export_data, 1, Primary!)
//------------------- APPEON END ---------------------

of_cleanup_ds( )

RETURN 1

end function

public function integer of_export_data_with_text_ctx_backup (integer ai_export_id, long al_prac_ids[], ref string as_path, integer ai_save_data, string as_param1, string as_param2, string as_param3, integer ai_type, string as_sql);//////////////////////////////////////////////////////////////////////
// $<function>pfc_n_cst_ai_export_apb/of_export_data_with_text_ctx()
// $<arguments>
//		value	integer	ai_export_id 		
//		value	long   	al_prac_ids[]		
//		value	string 	as_path      		 
//    value integer  ai_save_data (0:Nothing / 1:save / 2:preview / 3:save & preview)
//		value	string 	as_param1    		
//		value	string 	as_param2    		
//		value	string 	as_param3
//    value integer  ai_type      (1: specify SQL/2: specify array/3: between...and)
//    value string   as_sql       (the specified SQL)
// $<returns> integer
// $<description> Used for export IntelliContract data.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-11-28 by Rodger Wu (doc painter) //<optimization> by Andy 07/12/2007
//////////////////////////////////////////////////////////////////////


SetPointer( HourGlass! )
ib_writefile = false //(Appeon)Toney 06.24.2013 for V141 ISG-CLX

If IsNull(as_path) Or as_path = "" Then
 	inv_message.of_MessageBox("Data Error", "There is no save path for this file. Unable to continue this function.",true)	
	Return 0
End If
If ai_export_id < 1 Then
 	inv_message.of_MessageBox("User Error", "No export selected.  Unable to proceed.",true)	
	Return 0
End If

//open export progress window - alfee 02.06.2010
of_open_export_pogress() 

IF of_create_export_table( ai_export_id,ai_save_data ) < 0 THEN
	gnv_debug.of_output(true, 'Alarm Replace Export:of_create_export_table<0' + ' ai_export_id=' + string( ai_export_id ) + ' ai_save_data=' + string( ai_save_data ) ) //(Appeon)Toney 06.24.2013 for V141 ISG-CLX	
	close(w_export_progress)
	return 0
END IF

Integer li_drop_col  //add by stephen 03.26.2013
Long li_array_index, li_search_from_row, li_prac_id_cnt, li_table_cnt, t, e, g, a, w, sd,i,n,p
Long ll_find_no, ll_rowcount, ll_rowcount2, ll_find,li_rec_no, li_file_num,li_fld_cnt,li_act_format
Long li_fld_len, li_use_link, li_recd_no, li_width, f, li_dif, li_facil_id, li_save_data = 0, ud, col
Long li_exp_type, li_billing
Long ll_prac_row, ll_ret_cnt, ll_billing_id //maha app080205
Long ll_Cnt,ll_Num,ll_Tab,ll_Start = 1,ll_pos1,ll_pos2,ll_pos3,ll_SpID
Long ll_FieldSeqID = 0,ll_FieldCnt,ll_export_code,ll_intcred_field,ll_equivcode,ll_pracid,ll_LastPos    
Long ll_FieldSeqIDold = -1,ll_R = 0,ll_i = 1,ll_j,ll_k,ll_n,ll_pkcnt,ll_Rcnt,li_sub_start,li_custom_save
Long li_recdnoList[],ll_exportcodeList[],ll_intcredfieldList[],li_substartList[],li_widthList[],ll_ctx_scrn_id 
Long li_udList[],ll_pos,li_facil_idList[],li_act_formatList[],li_bar_ticks,li_widthtemp,ll_maxwidth,ll_len
Long ll_ctx_link_scrn_id, ll_currow, ll_doc_id, ll_seq_id, li_pos1
Long ll_arr_temp[]

String ls_lookup_type, ls_db_lookup_type, ls_lookup_code, ls_pad, ls_fixed_width//ls_trail_val, ls_trail_record, 
String Errors, ls_export_record, ls_export_field, ls_fld_type, ls_fld_delim//ls_hdr_val, ls_hdr_record, 
String ls_fld_val, ls_lead_trail_char, ls_format, ls_table_name//, ls_table_new, ls_table_names[]
String ls_sql_syntax, ls_field_name, ls_grey, ls_presentation_str, ls_dwsyntax_str, ls_value, ls_data_value
String ls_field_format, ls_sql, ls_save_format, ls_path//ls_month, ls_year, ls_day, ls_hour, ls_minute, 
String ls_header, ls_filter, ls_lookup, ls_datatype, ls_prac_ids = "", ls_select_field, ls_prac_field
String ls_select_table_trim, ls_select_table, ls_sny_retrieve, ls_find, ls_delim_value, ls_rec_delim, ls_lu_field
String ls_use_link_sql, ls_use_link_sql2, ls_export_text_file = "", ls_lookup_val, ls_save_path, stax, s //maha
String ls_aggre, ls_sort, ls_dc_field, ls_bill_syn, ls_text, ls_def_val
String ls_tempstr, ls_dddwdata, ls_dddwtable, ls_select_field_ctx, ls_dddw_column_dbname//ls_dataobject, 
String ls_linkfromcol, ls_linktotable, ls_linktocol
String ls_ComputerDataType,ls_Expresstion,ls_Field,ls_FieldDataType,ls_Modify,ls_Err,ls_tag    
String ls_Objects,ls_objname,ls_ObjType,ls_ColType,ls_OrderBy,ls_UnionSQL = "",ls_SqlSelect,ls_flddelimList[]
String ls_tablelist[],ls_billsynList[],ls_fieldlist[],ls_selectfieldlist[],ls_formatList[],ls_dcfieldList[] 
String ls_defvalList[],ls_textList[],ls_prac_sql,ls_use_link_sqlsyn,ls_ic_area,ls_lu_fieldList[] 
String ls_prac_sql_temp,ls_Sortsel,ls_prac_sql_temp2,ls_top = "top 2147483647",ls_usetable = "" // 08/08/2007 by: Andy
String ls_tablepks[],ls_table[],ls_tablepk,ls_sortpk[],ls_save_name,ls_strip_char,ls_dbtype
String ls_RowNo = "",ls_RowNoSyn = "",ls_tabletemp,ls_synprefix = "",ls_MySQL
String ls_syn_parent, ls_select_table_on, ls_lu_codename, ls_field_value, ls_other_where
String ls_ctx_table, ls_link_table, ls_link_table_on, ls_no_link_on, ls_ic_link_area, ls_dddwname, ls_datatype_ctx
String ls_otherfilter, ls_post_sort, ls_client_id, ls_ptype, ls_path1

Boolean lb_flagpk,lb_true = false,lb_ASA7 = false,lb_mulsel = false//lb_flag = true,
Boolean lb_export // Andy 03202008
Boolean lb_get_parent
Boolean lb_doc_action
Boolean lb_usingdb = False

DateTime ldt_date, ldt_value //maha
n_cst_string lnvo_string, lnv_string
str_pass lstr_pass
n_ds lds_export_hdr, lds_export_flds, lds_export_retrieve, lds_export_data, lds_code_lookup, lds_address_lookup
n_ds lds_dept_chair, lds_billing_address, lds_dataobject, lds_field, lds_export_dataTemp
datastore lds_linkto, lds_tablepk
datawindowchild ldwc_dddw

ldt_date = DateTime(Today(),Now()) //maha
//<add> 08/23/2007 by: Andy
ls_dbtype = of_get_dbtype()
if upper(ls_dbtype) = 'SQL2005' OR upper(ls_dbtype) = 'ASA9' THEN
	ls_RowNo = ",Row_No"
	lb_true = true
elseif upper(ls_dbtype) = 'ASA7' then
	lb_ASA7 = true
end if

if Not lb_ASA7 THEN
	//ls_synprefix = "select ctx_id,FieldSeqID,billing_address_id,field_value,field_data_type" + ls_RowNo + " from ("	
	 ls_synprefix = "select ctx_id,FieldSeqID,field_value,field_data_type" + ls_RowNo + " from (" //remove the billing_address_id field -  (Appeon)Toney 07.04.2013 for V141 ISG-CLX
end if

//Bubble sort the al_prac_ids array.
if ai_type = 2 then of_bubblesort(al_prac_ids)
li_prac_id_cnt = UpperBound( al_prac_ids[] )

lds_tablepk = create datastore
IF LeftA(upper(ls_dbType),3) = 'ASA' THEN 
	lds_tablepk.DataObject = "d_export_tablepk_asa_ctx"
	ls_top = ""
ELSE
	lds_tablepk.DataObject = "d_export_tablepk_sql_ctx"
END IF
lds_tablepk.SetTransObject( SQLCA )

lds_field = Create n_ds
lds_field.DataObject = "d_export_fields"
lds_field.of_SetTransObject( SQLCA )

lds_code_lookup = Create n_ds
lds_code_lookup.DataObject = "d_code_lookup"
lds_code_lookup.of_SetTransObject( SQLCA )

lds_address_lookup = Create n_ds
lds_address_lookup.DataObject = "d_address_lookup"
lds_address_lookup.of_SetTransObject( SQLCA )

lds_export_hdr = Create n_ds
lds_export_hdr.DataObject = "d_export_hdr"
lds_export_hdr.of_SetTransObject( SQLCA )

lds_export_flds = Create n_ds
lds_export_flds.DataObject = "d_export_flds_list_exp_ctx"
lds_export_flds.of_SetTransObject( SQLCA )

lds_dept_chair = Create n_ds //maha 010704
lds_dept_chair.DataObject = "d_dept_chair_exp_all"
lds_dept_chair.of_SetTransObject( SQLCA )

n_ds lds_export_equiv_code
lds_export_equiv_code = Create n_ds
lds_export_equiv_code.DataObject = "d_export_equiv_code_lds"
lds_export_equiv_code.of_SetTransObject( SQLCA )

lds_export_retrieve = Create n_ds
lds_dataobject = Create n_ds
lds_linkto = create datastore

gnv_appeondb.of_startqueue( )

lds_dept_chair.Retrieve()
lds_export_flds.Retrieve( ai_export_id )
lds_export_equiv_code.Retrieve()
lds_export_hdr.Retrieve( ai_export_id )
lds_field.Retrieve( ai_export_id )

gnv_appeondb.of_commitqueue( )

ll_rowcount = lds_dept_chair.RowCount()
ll_rowcount2 = lds_export_equiv_code.RowCount()

//HEADER INFO
ls_table_name = lds_export_hdr.GetItemString(1,"export_name")
ls_header = lds_export_hdr.GetItemString(1,"field_labels_as_header") //Y or N
ls_format = lds_export_hdr.GetItemString(1,"export_format")
ls_post_sort = lds_export_hdr.GetItemString(1,"sort_fields") //(Appeon)Harry 03.26.2014

ls_strip_char = lds_export_hdr.getitemstring(1,"strip_char")
if isnull(ls_strip_char) or LenA(ls_strip_char) < 1 then ls_strip_char = "NONE"
if ls_format = ".csv" then ls_strip_char = "," 

li_custom_save = lds_export_hdr.getitemnumber(1,"custom_save_name") 
if isnull(li_custom_save) then li_custom_save = 0

//Use text with header format for merging data in document manager, agreement template or for email template. It's also for performance tunning.
If is_called_type = "2" Or is_called_type = '3' or is_called_type = '4' Then 
	ls_format = ".txt" 
	ls_header = '1'
END IF

if ls_format = "export"  then
	lb_export = true
	ls_format = ".txt" 
else //txt and xls files  files
	lb_export = false
end if

//---------Begin Commented by (Appeon)Stephen 11.09.2016 for Import with CSV file--------
/*
if ls_format = ".csv" then
	if upper( appeongetclienttype() ) = "WEB" then		
 		inv_message.of_MessageBox( "IntelliSoft", "The file type of CSV is unsupported on WEB.~r~nPlease go to Export painter to modify settings.",true)	
		gnv_debug.of_output(true, 'Alarm  Export:' +"The file type of CSV is unsupported on WEB.~r~nPlease go to Export painter to modify settings." ) //(Appeon)Toney 06.24.2013 for V141 ISG-CLX
		Close(w_export_progress)
		Destroy lds_export_flds
		Destroy lds_export_hdr
		Destroy lds_address_lookup
		Destroy lds_code_lookup
		Destroy lds_dept_chair
		Destroy lds_export_equiv_code
		Destroy lds_dataobject
		Destroy lds_linkto
		Destroy lds_field
		Destroy lds_tablepk
		//Destroy lds_export_dataTemp
		Return -1
	end if
end if
*/
//------------------- APPEON END -------------------

li_exp_type = lds_export_hdr.GetItemNumber(1,"export_type")
ls_rec_delim = lds_export_hdr.GetItemString(1,"record_delimiter")
ls_save_path = lds_export_hdr.GetItemString(1,"save_path")

select top 1 @@spid into :ll_SpID from ids;

//specify SQL
if ai_type = 1 then
	ls_prac_sql  = trim(as_sql)//trim(lds_export_hdr.getitemstring(1,"prac_sql"))
	if isnull(ls_prac_sql) then ls_prac_sql = ''
	if ls_prac_sql <> '' then 
		ll_pos = PosA(ls_prac_sql,";")
		if ll_pos > 0 then 
			ls_prac_sql  = ReplaceA(ls_prac_sql,ll_pos,1,'')
		end if
		ll_len = LenA(ls_prac_sql)
		ls_prac_sql_temp = trim(MidA(ls_prac_sql,7,ll_len))
		if lower(LeftA(ls_prac_sql_temp,8)) = 'distinct' then
			ls_prac_sql_temp2 = trim(MidA(ls_prac_sql_temp,9,ll_len))
			if lower(LeftA(ls_prac_sql_temp2,3)) <> 'top' then 
				ls_prac_sql = 'select distinct ' + ls_top + ' ' + ls_prac_sql_temp2
			end if
		elseif lower(LeftA(ls_prac_sql_temp,3)) <> 'top' then
			ls_prac_sql = 'select ' + ls_top + ' ' + ls_prac_sql_temp
		end if
		
		//del order by statement. Reason:if ORDER BY items isn't in the select list,then it will get error.
		//ORDER BY items must appear in the select list if the statement contains a UNION operator.
		ll_pos = PosA(lower(ls_prac_sql)," order ")
		if ll_pos > 0 then
			ls_prac_sql = LeftA(ls_prac_sql,ll_pos - 1)
		end if
		//if select more than one field,then add a select statement outside the ls_prac_sql and
		//INSERT the result INTO a table.
		ll_pos = PosA(lower(ls_prac_sql)," from ")
		ls_prac_sql_temp = LeftA(ls_prac_sql,ll_pos - 1)
		ll_pos = PosA(ls_prac_sql,",")
		if ll_pos > 0 then
			lb_mulsel = true
			ls_prac_sql = "select distinct ctx_id," + String(ll_spid) + " from (" + ls_prac_sql + ") cc order by ctx_id"
			select top 1 1 into :ll_Cnt from sysobjects where name = 'export_temp' and type = 'U';
			if ll_Cnt = 1 then
				ls_Mysql = "DELETE FROM export_temp WHERE SpID = " + String(ll_spid) + ";"
			else
				ls_MySQL = "CREATE TABLE export_temp (prac_id int null,SpID int null)"
			end if
			EXECUTE IMMEDIATE :ls_Mysql;
			ls_MySQL = "INSERT INTO export_temp " + ls_prac_sql + ";"
			EXECUTE IMMEDIATE :ls_Mysql;
			ls_prac_sql = "select distinct prac_id as ctx_id from export_temp where SpID = " + String(ll_spid)
		end if
	end if
end if

//set record delimiter
Choose Case ls_rec_delim
	Case "C"
		ls_rec_delim = ","
	Case "R"
		ls_rec_delim = "~r"
	Case "T"
		ls_rec_delim = "	"
	Case "D"
		ls_rec_delim = "~r~r"
	Case "U"
	Case Else
		ls_rec_delim = ""
End Choose
If IsNull(ls_rec_delim) Then ls_rec_delim = ""

li_fld_cnt = lds_export_flds.RowCount()
ll_maxwidth = Long(lds_export_flds.describe("evaluate('max(export_field_length)',0)"))
if ll_maxwidth < 30 then ll_maxwidth = 30

//CREATE SYNTAX FOR export DW
ls_sql_syntax = is_select_syntax
ls_presentation_str = "style(type=grid)" //modify 08/15/2007 by: Andy
//ls_presentation_str = "style(type=form)"

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, ls_presentation_str, Errors)
If LenA(Errors) > 0 Then //this will fail if the table has not been completed
	If PosA(Errors,"Table or view not found",1) > 0 Then
	     inv_message.of_MessageBox ("Error in of_export_data_with_text","Export data data store not able to be created.~rCheck to make sure no export fields have any spaces, and that all have a width.  You cannot have duplicate field names, and fields cannot start with a number.",true )	
		Close(w_export_progress)
		Destroy lds_export_flds
		Destroy lds_export_hdr
		Destroy lds_address_lookup
		Destroy lds_code_lookup
		Destroy lds_dept_chair
		Destroy lds_export_equiv_code
		Destroy lds_dataobject
		Destroy lds_linkto
		Destroy lds_field
		Destroy lds_tablepk
		//Destroy lds_export_dataTemp
		Return -1		
	Else
		gnv_debug.of_output(true,"Caution :" + "SyntaxFromSQL caused these errors: " + Errors)	//(Appeon)Toney 06.24.2013 for V141 ISG-CLX
		inv_message.of_MessageBox("Caution","SyntaxFromSQL caused these errors: " + Errors,true)	
		Close(w_export_progress)
		Destroy lds_export_flds
		Destroy lds_export_hdr
		Destroy lds_address_lookup
		Destroy lds_code_lookup
		Destroy lds_dept_chair
		Destroy lds_export_equiv_code
		Destroy lds_dataobject
		Destroy lds_linkto
		Destroy lds_field
		Destroy lds_tablepk
		//Destroy lds_export_dataTemp
		Return -1
	End If
	gnv_debug.of_output(true, 'Alarm  Export:SyntaxFromSQL errors:' +  Errors ) //(Appeon)Toney 06.24.2013 for V141 ISG-CLX
End If
lds_export_data = Create n_ds
lds_export_data.Create( ls_dwsyntax_str, Errors)
If len( errors ) > 0 Then
	gnv_debug.of_output(true, 'Alarm  Export:lds_export_data create errors:' +  Errors ) //(Appeon)Toney 06.24.2013 for V141 ISG-CLX
End If
lds_export_data.SetTransObject( SQLCA )

//---------Begin Added by (Appeon)Toney 11.28.2013 for V141 ISG-CLX--------
//$Reason:Fix BugT112602
n_cst_dw_update_prop  ln_dwprop
IF Upper(AppeonGetClientType())="WEB" THEN
	IF ai_save_data = 1 OR ai_save_data = 3 THEN
		ln_dwprop.of_modifyupdateproperty(lds_export_data, is_savetablename,false)
	END IF
END IF
//---------End Added ------------------------------------------------------------------

//save the original data that it's not format,in order to deal with the computer fields
lds_export_dataTemp = create n_ds
lds_export_dataTemp.create( ls_dwsyntax_str, Errors )
lds_export_dataTemp.SetTransObject( SQLCA )

//w_export_progress.r_bar.Width = 300
w_export_progress.hpb_bar.position = 10
w_export_progress.st_progress.Text = "Populating Data for " + String(li_prac_id_cnt) + " Contract(s)"

//creates string of prac_ids for querys
//between...and...
if ai_type = 3 then
	if li_prac_id_cnt > 0 then ls_prac_ids = "between " + string(al_prac_ids[1]) + " and " + string(al_prac_ids[li_prac_id_cnt])
end if

//create rows for all practitioner data
FOR i = 1 TO li_prac_id_cnt
	//specify array
	if ai_type = 2 then ls_prac_ids = ls_prac_ids + String( al_prac_ids[i] ) + ","
	g = lds_export_data.insertrow(0)
next

//---------Begin Added by (Appeon)Toney 06.24.2013 for V141 ISG-CLX--------
If li_prac_id_cnt >= 100 Then
	lb_usingdb = True
	If inv_arr_db.of_array_to_db( al_prac_ids[],ls_client_id ) < 0 Then
		is_client_id[UpperBound(is_client_id[]) + 1 ] = ls_client_id
		if isvalid(w_export_progress) then close(w_export_progress)
		of_cleanup_ds( )	
		lb_usingdb = False
		gnv_debug.of_output( True, 'Export data with text error, Failed to insert array to DB.')
		Messagebox('Export Error','Failed to insert array data to DB.')
	End If
End If
//---------End Added ------------------------------------------------------------------

//if ai_save_data = 1 or ai_save_data = 3 then
if ai_save_data = 1 or ai_save_data = 3  or ib_gen_rec_id then //for Date Alarm - Alfee 06.11.2008
	lds_export_data.object.rec_id.Primary[] = al_prac_ids[]
end if
lds_export_data.Rowscopy( 1, lds_export_data.rowcount(), Primary!, lds_export_dataTemp, 1, Primary! )

//specify array
if ai_type = 2 then ls_prac_ids = LeftA( ls_prac_ids, LenA( ls_prac_ids ) -1 ) //remove last comma

//w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + 50
w_export_progress.hpb_bar.position = 11
w_export_progress.st_export.text = "Form SQL Statement"

n = int(li_fld_cnt/80) + 1

if lb_ASA7 then 
	ls_tabletemp = "t_export" + String(ll_SpID)
	 //ls_MySQL = "CREATE TABLE " + ls_tabletemp + " (prac_id int null,FieldSeqID int null, billing_address_id int null, field_value varchar( " + String(ll_maxwidth) + ") null, field_data_type CHAR(1))"		
	 ls_MySQL = "CREATE TABLE " + ls_tabletemp + " (prac_id int null,FieldSeqID int null, field_value varchar( " + String(ll_maxwidth) + ") null, field_data_type CHAR(1))" //(Appeon)Toney 07.04.2013 for V141 ISG-CLX
	
	EXECUTE IMMEDIATE :ls_Mysql;
	if SQLCA.SQLCode <> 0 then
 		inv_message.of_MessageBox(gnv_app.iapp_object.DisplayName,sqlca.sqlerrtext,true)	
		close(w_export_progress)
		if IsValid(lds_export_flds) then destroy lds_export_flds
		if IsValid(lds_export_hdr) then destroy lds_export_hdr
		if IsValid(lds_address_lookup) then destroy lds_address_lookup
		if IsValid(lds_code_lookup) then destroy lds_code_lookup
		if IsValid(lds_export_data) then destroy lds_export_data
		if IsValid(lds_dept_chair) then destroy lds_dept_chair
		if IsValid(lds_field) then Destroy lds_field
		if IsValid(lds_export_dataTemp) then Destroy lds_export_dataTemp
		if IsValid(lds_export_equiv_code) then Destroy lds_export_equiv_code
		Destroy lds_tablepk
		RETURN -1
	END IF
END IF

For p = 1 To li_fld_cnt
	IF p = li_fld_cnt THEN
		DebugBreak()
	END IF
	lds_dataobject.dataobject = lds_export_flds.GetItemString( p, "export_fields_ctx_scrn_dataobject" )
	
	li_width = lds_export_flds.GetItemNumber(p,"export_field_length")
	ls_field_format = lds_export_flds.GetItemString(p,"export_format")
	ls_data_value = ""
	ls_value = ""
	ls_lookup_val = ""
	ls_dc_field = "none"
	li_sub_start=  0
	ls_dddwtable = ""

	//---------Begin Modified by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------	
  	/*ud = lds_export_flds.GetItemNumber( p, "use_default" )
		ls_def_val = ""
		if ud = 1 OR ud = 2 then ls_def_val = lds_export_flds.GetItemString( p, "default_value" )  */
	lb_get_parent = false
	ls_syn_parent = ""
	ls_select_table_on = ""
	ls_lu_codename = ""
	ls_field_value = ""
	ls_other_where = ""
	ls_no_link_on = ""

	ud = lds_export_flds.GetItemNumber( p, "use_default" )
	If ud = 1 Or ud = 2 Then
		ls_def_val = lds_export_flds.GetItemString( p, "default_value" )
	Else
		ls_def_val = ""
	End If
	
	//Get Parent Level Data
	if lds_export_flds.GetItemString( p,"record_level") = 'P' then lb_get_parent = true
	
	if lb_get_parent then
		ls_syn_parent = "ctx_basic_info table_1 left join ctx_basic_info table_2 on (table_1.master_contract_id = table_2.ctx_id ) left join "
	end if
	
	//Leading Padding or Trailing Padding Process
	ls_fld_delim = lds_export_flds.GetItemString( p, "trailing_leading_characters")
	Choose Case ls_fld_delim
		Case "R" //return
			ls_fld_delim = "~r"
		Case "T" //tab
			ls_fld_delim = "	"
		Case "D" //double return
			ls_fld_delim = "~r~r"
		Case "S" // space
			ls_fld_delim = " "
		Case "E" //empty string
			ls_fld_delim = ""
	End Choose	 
	//---------End Modfiied ------------------------------------------------------------------
	
	//hard coded text
	If lds_export_flds.GetItemNumber(p,"export_type") = 2 Then //set data for text fields
		ls_select_field = lds_export_flds.GetItemString(p,"export_field_name")
		ls_value = lds_export_flds.GetItemString(p,"field_value")
		If IsNull(ls_value) Then ls_value = ""
		If ls_value = "&TODAY&" Then
			ls_value = String(ldt_date,"yyyy-mm-dd hh:mm")
			of_data_format(ls_field_format,'D',ls_value)
		End If

		Choose Case Upper(ls_value)
			Case "&PROMPT1&"
				ls_ptype = lds_export_hdr.GetItemString(1,"prompt_type1")
				ls_value = of_prompt_populate( ls_ptype, as_param1)
			Case "&PROMPT2&"
				ls_ptype = lds_export_hdr.GetItemString(1,"prompt_type2")
				ls_value = of_prompt_populate( ls_ptype, as_param2)
			Case "&PROMPT3&"
				ls_ptype = lds_export_hdr.GetItemString(1,"prompt_type3")
				ls_value = of_prompt_populate( ls_ptype, as_param3)
		End Choose
		If	ls_ptype = 'D' Then
			ldt_date = DateTime(Date(ls_value),Now())
			ls_value = String(ldt_date,"yyyy-mm-dd hh:mm")
			of_data_format(ls_field_format,'D',ls_value)
		End If

		li_sub_start = lds_export_flds.getitemnumber(p,"export_fields_substring_start")
		if li_sub_start > 1 then ls_value = MidA(ls_value,li_sub_start,li_width)		
		ls_value = MidA(ls_value,1,li_width) //shrink the length to size 

		//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
		If ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" Then
			If li_width - Len(ls_value) > 0 Then
				li_dif = li_width - Len(ls_value)
				ls_pad = "" //reset
				ls_pad = Fill ( ls_fld_delim, li_dif )
				If ls_field_format = "Leading Padding" Then
					ls_value = ls_pad + ls_value
				Else
					ls_value = ls_value + ls_pad
				End If
			End If
		End If				
		//---------End Added ------------------------------------------------------------------

		For i = 1 To li_prac_id_cnt
			lds_export_data.SetItem(i,p,ls_value)
			lds_export_dataTemp.SetItem(i,p,ls_value)//<add> andy 2007.05.25 
		Next

	ElseIf lds_export_flds.GetItemNumber(p,"export_type") = 1 Then //get FIELDS DATA
		//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
		ll_ctx_scrn_id = lds_export_flds.GetItemNumber(p,"export_fields_ctx_scrn_id") //Add by Jack 06/05/2007
		If ll_ctx_scrn_id = 6 Then
			ls_ic_area = "E"
		ElseIf ll_ctx_scrn_id = 7 Then
			ls_ic_area = "I"
		elseif ll_ctx_scrn_id = 14 or ll_ctx_scrn_id = 17 then //add other contact -- jervis 03.28.2011
			ls_ic_area = "C"
		End If		
		//---------End Added ------------------------------------------------------------------

		//CREATE SYNTAX FOR each retrieve DW
		ls_export_field = lds_export_flds.GetItemString(p,"export_field_name")
		of_replacespecchar(ls_export_field)
		ls_select_field_ctx = Trim( lds_export_flds.GetItemString( p, "db_field_name" ) )
		Choose Case ls_select_field_ctx
			Case "app_facility" 
				ls_tempstr = 'ctx_basic_info.app_facility'
				ls_select_table = f_get_token( ls_tempstr, "." )
				ls_select_field = ls_tempstr		
			Case "compute_1"
				ls_select_table = 'ctx_contract_contacts'
				ls_select_field = "compute_1"		
			Case "contact_phone" 
				ls_select_table = 'ctx_contract_contacts'
				ls_select_field = 'contact_phone'	
			//---------Begin Modified by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
			 /*
			Case "contact_email" 
				ls_select_table = 'ctx_contract_contacts'
				ls_select_field = 'contact_email'		
			Case Else
				ls_tempstr = lds_dataobject.Describe( ls_select_field_ctx + ".dbname" )
				ls_select_table = f_get_token( ls_tempstr, "." )
				ls_select_field = ls_tempstr	      
			  */
			Case "contact_email"
				if ll_ctx_scrn_id <> 2002 then //jervis 03.28.2011
					ls_select_table = 'ctx_contract_contacts'
					ls_select_field = 'contact_email'
				else
					ls_select_table = 'ctx_contacts_numbers'
					ls_select_field = 'contact_email'
				end if
			Case Else
				ls_tempstr = lds_dataobject.Describe( ls_select_field_ctx + ".dbname" )
				if pos(ls_tempstr,".") > 0 then	//IF Exists Table Selection - jervis 03.17.2009
					ls_select_table = f_get_token( ls_tempstr, "." )
				else
					ls_select_table = ""
				end if 
				ls_select_field = ls_tempstr
				
				if ll_ctx_scrn_id = 12 then //Export Requirement Profile Detail-- jervis 03.17.2009
					ls_select_table = 'ctx_elements'
				elseif ll_ctx_scrn_id = 2004 then
					ls_select_table = 'sys_statusaudit'	//Export Contract Status tract - jervis 03.20.2009
				elseif (ll_ctx_scrn_id = 6 or ll_ctx_scrn_id = 7) and ls_select_field = "facility_id" then
					ls_select_table = 'ctx_contract_contacts'  //Export comany info with contact - jervis 01.30.2011
				ElseIf ll_ctx_scrn_id = 22 Then
					ls_select_table = 'ctx_orgs_contact'//added by gavins 20130314	
				end if	
				//---------End Modfiied ------------------------------------------------------------------			
		End Choose		
		
		//---------Begin Added by (Appeon)Harry 04.10.2014 for Bug 3998--------
		ls_otherfilter = ""
		lb_doc_action = false
		if istr_action_item.module = '04' then
			if ls_select_table = 'ctx_am_action_item' or ls_select_table = 'ctx_am_document' then
				if not isnull(istr_action_item.doc_id) and istr_action_item.doc_id > 0 then
					ls_otherfilter += " and " + ls_select_table + ".doc_id = " + string(istr_action_item.doc_id)
					lb_doc_action = true
				end if
				if ls_select_table = 'ctx_am_action_item' then 
					if not isnull(istr_action_item.seq_no) and istr_action_item.seq_no > 0 then
						ls_otherfilter += " and " + ls_select_table + ".seq_id = " + string(istr_action_item.seq_no)
						lb_doc_action = true
					end if
				end if
			end if
		end if
		//---------End Added ------------------------------------------------------
		
		li_use_link = lds_export_flds.GetItemNumber(p,"export_fields_ctx_uselink")
		if isnull( li_use_link ) then li_use_link = 0
		
		ll_ctx_scrn_id = lds_export_flds.GetItemNumber(p,"export_fields_ctx_scrn_id")  //Add by Jack 06/05/2007
		If ll_ctx_scrn_id = 6 Then 
			ls_ic_area = "E" 
		ElseIf ll_ctx_scrn_id = 7 Then 
			ls_ic_area = "I" 
		end if

		ls_fld_delim = lds_export_flds.GetItemString( p, "trailing_leading_characters")
		li_recd_no = lds_export_flds.GetItemNumber(p,"intcred_record_number")		
		if lb_doc_action and li_recd_no > 1 then li_recd_no = 1 //(Appeon)Harry 04.10.2014 for Bug 3998
		
		ll_FieldSeqID ++
		ll_export_code = lds_export_flds.GetItemnumber( p, "export_code" )
		ls_dc_field = lds_export_flds.GetItemstring( p, "dept_sect_field" )
		if isnull(ls_dc_field) or trim(ls_dc_field) = '' then ls_dc_field = "none"
		ll_intcred_field = lds_export_flds.getitemnumber(p,"intcred_field")
		li_facil_id = lds_export_flds.GetItemNumber(p,"facility_id")
		ls_lu_field = lds_export_flds.GetItemString( p, "lu_field_name" )
		ls_aggre = lds_export_flds.GetItemString( p, "aggre_function" )
		ls_sort = lds_export_flds.GetItemString( p, "sort_by" )
		ls_Sortsel = ls_sort
		if isnull(ls_Sortsel) then ls_Sortsel = ''
		
		if LenA(trim(ls_Sortsel)) > 0 then of_get_sortsel(ls_Sortsel,'ctx_id')

		li_act_format = lds_export_flds.GetItemNumber(p,"export_fields_active_yesno")
		ls_text = lds_export_flds.GetItemString(p,"field_value") //maha 091305
		If Upper(ls_lu_field) = "LOOKUP CODE" Then ls_lu_field = "lookup_code"
		If IsNull(ls_lu_field) Then ls_lu_field = "code"
		ls_use_link_sql = ""
		ls_use_link_sql2 = ""

		li_sub_start = lds_export_flds.getitemnumber(p,"export_fields_substring_start")
		if PosA(ls_select_table,"dba.",1) > 0 then //maha 122005 
			ls_select_table_trim = MidA(ls_select_table,5) //dropping dba.
			ls_select_table = ls_select_table_trim  //maha 012306
		else
			ls_select_table_trim = ls_select_table
		end if
		ls_filter = lds_export_flds.GetItemString(p,"filter_query")
		li_billing = lds_export_flds.GetItemNumber(p,"billing_link") //maha app080205
		If IsNull(li_facil_id) Then li_facil_id = 0

		If IsNull(ls_filter) Or Trim(ls_filter) = "" Then
			ls_filter = ""
		Else
			ls_filter = " and  ( " + ls_filter + " )"		
			li_pos1 = PosA(Upper(ls_filter),"PROMPT1",1)
			If li_pos1 > 0 Then
				ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param1 + MidA(ls_filter,li_pos1 + 7)
			End If
			li_pos1 = PosA(Upper(ls_filter),"PROMPT2",1)
			If li_pos1 > 0 Then
				ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param2 + MidA(ls_filter,li_pos1 + 7)
			End If
			li_pos1 = PosA(Upper(ls_filter),"PROMPT3",1)
			If li_pos1 > 0 Then
				ls_filter = MidA(ls_filter,1,li_pos1 - 1) + as_param3 + MidA(ls_filter,li_pos1 + 7)
			End If
		End If

		//export_fields_use_link  sql
		If li_use_link = 1 Then
			ls_linkfromcol = Trim( lds_export_flds.GetItemString( p, "export_fields_ctx_linkfromcolumn" ))
			ls_tempstr = lds_dataobject.Describe( ls_linkfromcol + ".dbname" )
			f_get_token( ls_tempstr, "." )
			ls_linkfromcol = ls_tempstr
			
			lds_linkto.dataobject = Trim( lds_export_flds.GetItemString( p, "export_fields_ctx_linktoscrndw" ))
			ls_linktocol = Trim( lds_export_flds.GetItemString( p, "export_fields_ctx_linktocolumn" ))
			ls_tempstr = lds_linkto.Describe( ls_linktocol + ".dbname" )
			ls_linktotable = f_get_token( ls_tempstr, "." )
			ls_linktocol = ls_tempstr
			//---------Begin Modified by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
			//ls_use_link_sql = ", " + ls_linktotable	
			//Contacted contact or our company contact - jervis 01.27.2011
			ll_ctx_link_scrn_id = lds_export_flds.GetItemNumber(p,"export_fields_ctx_linktoscrnid") 
			If ll_ctx_link_scrn_id = 6 Then
				ls_ic_link_area = "E"
			ElseIf ll_ctx_link_scrn_id = 7 Then
				ls_ic_link_area = "I"
			elseif ll_ctx_link_scrn_id = 14 or ll_ctx_link_scrn_id = 17 then  //add other contact -- jervis 03.28.2011
				ls_ic_link_area = "C"
			End If			  
			//---------End Modfiied ------------------------------------------------------------------			
		End If

		ls_tablelist[ll_FieldSeqID] = ls_select_table
		ls_fieldlist[ll_FieldSeqID] = ls_export_field
		li_recdnoList[ll_FieldSeqID] = li_recd_no
		ls_selectfieldlist[ll_FieldSeqID] = ls_select_field
		ls_formatList[ll_FieldSeqID] = ls_field_format
		ll_exportcodeList[ll_FieldSeqID] = ll_export_code
		ls_dcfieldList[ll_FieldSeqID] = ls_dc_field
		ll_intcredfieldList[ll_FieldSeqID] = ll_intcred_field
		li_substartList[ll_FieldSeqID] = li_sub_start
		li_widthList[ll_FieldSeqID] = li_width
		li_widthtemp = li_width
		if li_widthtemp < 30 then li_widthtemp = 30
		ls_flddelimList[ll_FieldSeqID] = ls_fld_delim
		li_udList[ll_FieldSeqID] = ud
		ls_defvalList[ll_FieldSeqID] = ls_def_val
		ls_textList[ll_FieldSeqID] = ls_text
		ls_lu_fieldList[ll_FieldSeqID] = ls_lu_field
		li_facil_idList[ll_FieldSeqID] = li_facil_id
		li_act_formatList[ll_FieldSeqID] = li_act_format

		if (ll_ctx_scrn_id = 6 or ll_ctx_scrn_id = 7) and ls_select_field = 'facility_id' then
			ls_usetable = "ctx_contract_contacts"
		elseIf ls_select_table <> 'app_facility' Then
			If li_use_link = 1 Then
				ls_usetable = Lower(ls_linktotable)
			Else
				ls_usetable = Lower(ls_select_table)
			End If
		Else
			ls_usetable = "ctx_basic_info"
		End If
		
		if lb_get_parent then
			ls_ctx_table = "table_1"
		else
			ls_ctx_table = ls_usetable
		end if

		ls_tablepk= ""
		if ISNULL(ls_sort) OR trim(ls_sort) = "" then
			ls_sort = ""
			lb_flagpk = true
			ll_pkcnt = upperbound(ls_table)
			FOR ll_n = 1 to ll_pkcnt
				if lower(ls_usetable) = lower(ls_table[ll_n]) then
					ls_tablepk = ls_tablepks[ll_n]
					ls_sort = ls_sortpk[ll_n]
					lb_flagpk = false
				end if
			next
			if lb_flagpk then
				ll_Rcnt = lds_tablepk.retrieve( ls_usetable)
				ls_sort = ls_usetable + '.ctx_id, '
				for ll_n = 1 to ll_Rcnt
					if lower(lds_tablepk.getitemstring( ll_n, "column_name")) = 'ctx_id' then continue
					ls_tablepk += ls_usetable + '.' + lds_tablepk.getitemstring( ll_n, "column_name") + ", "
				next
				ls_sort = ls_sort + ls_tablepk
				ls_sort  = LeftA(ls_sort,LenA(ls_sort) - 2)
				ls_sortpk[ll_pkcnt + 1] = ls_sort
				ls_table[ll_pkcnt+1] = ls_usetable
				ls_tablepks[ll_pkcnt+1] = ls_tablepk
			end if
		else
			if PosA(lower(ls_sort),'ctx_id') < 1 then ls_sort = ls_usetable + '.ctx_id, ' + ls_sort	
		end if

 		if lb_ASA7 THEN 
			ls_tablepk = ""
			ls_Sortsel = ""//<add> 08/27/2007 by: Andy
		end if
		
		if LenA(ls_aggre) > 0 then ls_sort = ls_sort + " , field_value"
		if LenA(ls_sort) > 0 then ls_sort = "order by " + ls_sort
	
		if lb_true THEN ls_RowNoSyn = ",row_number() over(" + ls_sort+") Row_No" //SQL2005 and ASA9
		
		ls_bill_syn     = "Select " + lower(ls_usetable) + ".ctx_id, "
		//ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " " + ls_usetable + ".ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, "	
		 ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " " + ls_ctx_table + ".ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID, " //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
		
		ls_db_lookup_type = lds_export_flds.GetItemString( p, "export_fields_ctx_lookup_type" )
		If ls_select_table = 'app_facility' And ls_select_field_ctx = 'state' Then
			ls_dddwdata = ''
		Else
			ls_dddwdata = lower( lds_dataobject.Describe( ls_select_field_ctx + ".dddw.datacolumn" ) )
		End If
		
		if ls_dddwdata <> '?' and ls_dddwdata <> '!' and ls_dddwdata <> '' then
			ls_tempstr = lower( lds_dataobject.Describe( ls_select_field_ctx + ".dddw.displaycolumn" ) )
			//the edit style has been dynamic change for lookup or company dddw -- jervis 09.22.2011
			ls_dddwname =  Lower( lds_dataobject.Describe( ls_select_field_ctx + ".dddw.name" ) )
			if ls_dddwname = 'd_dddw_code_lookup' or ls_dddwname = 'd_dddw_company'  then  
				ls_dddwdata = ''
			else
				If ls_tempstr <> '?' And ls_tempstr <> '!' And ls_tempstr <> '' Then
					
					If IsNull( ls_db_lookup_type ) Then
						ls_db_lookup_type = "X"
						ls_lu_field = ls_tempstr
						
						lds_dataobject.GetChild( ls_select_field_ctx, ldwc_dddw )
						ls_tempstr = ldwc_dddw.Describe( ls_lu_field + ".dbname" )
						ls_dddwtable = f_get_token( ls_tempstr, "." )
						ls_dddw_column_dbname = ls_tempstr
					End If
				End If
			end if			  
		end if

		//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
		If li_use_link = 1 Then
			if lb_get_parent then
				ls_link_table = ls_linktotable
				ls_link_table_on = " on( table_2.ctx_id = " + ls_linktotable + ".ctx_id) left join "
				if ls_select_table <> "app_facility" then
					ls_no_link_on = " on (table_2.ctx_id = " + Lower(ls_select_table) + ".ctx_id) "
				else
					ls_no_link_on = " on (table_2.ctx_id = " + Lower(ls_usetable) + ".ctx_id) "
				end if
			else
				ls_link_table = ls_linktotable + " left join "
				ls_link_table_on = " "
			end if
			
			ls_select_table_on = " on  (" + ls_linktotable + "." + ls_linktocol + " = " + ls_select_table + "." + ls_linkfromcol + ") "
			
			//Contracted contact or our company contact - jervis 01.27.2011
			//add other contact - jervis 03.28.2011
			If ll_ctx_link_scrn_id = 6 or ll_ctx_link_scrn_id = 7 or ll_ctx_link_scrn_id = 14 or ll_ctx_link_scrn_id = 17 Then
				ls_other_where = " and " + ls_linktotable + ".ic_area ='" + ls_ic_link_area + "' "
			end if
		else
			ls_link_table = " "
			ls_link_table_on = " "
			//Get select table on clause		-- jervis 03.04.2009
			if lb_get_parent then
				if ls_select_table <> "app_facility" then
					ls_select_table_on = " on (table_2.ctx_id = " + Lower(ls_select_table) + ".ctx_id) "
				else
					ls_select_table_on = " on (table_2.ctx_id = " + Lower(ls_usetable) + ".ctx_id) "
				end if
			end if
			ls_no_link_on = ls_select_table_on
			//Get link table on clause		-jervis 03.04.2009
		End If
		//---------End Added ------------------------------------------------------------------
	
		If ls_select_field = "affiliation_status" Then // setting lookup field and where
			ls_datatype = "C"
			ls_bill_syn     =     ls_bill_syn + " code_lookup."+ ls_lu_field + " from code_lookup," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and "
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.code)) and code_lookup.lookup_name = 'Affiliation Status' and "			
			//ls_prac_field = ls_select_table_trim + "_ctx_id"
			ls_select_field  = "code_lookup_" + ls_lu_field			
		ElseIf ls_select_field = 'app_facility' And Upper(ls_db_lookup_type)  = "C" Then
			ls_datatype = "C"
			ls_bill_syn     = ls_bill_syn + " app_facility."+ ls_lu_field + " from app_facility," + lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(" + lower(ls_select_table) + "." + ls_select_field + " = app_facility.facility_id) and "
			//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),app_facility."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from app_facility," + lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(" + lower(ls_select_table) + "." + ls_select_field + " = app_facility.facility_id) and "			
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),app_facility."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join app_facility on("+ Lower(ls_select_table) + "." + ls_select_field + " = app_facility.facility_id) " //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
			ls_select_field  = "app_facility_" + ls_lu_field			
		//Export location data 
		//Export company info whit contracted conatct or our company contact -- jervis 01.30.2011
		elseif (ll_ctx_scrn_id = 6 or ll_ctx_scrn_id = 7 or ll_ctx_link_scrn_id = 14 or ll_ctx_link_scrn_id = 17) and ls_select_field = 'facility_id' then
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),app_facility."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id) left join app_facility on(ctx_contacts.facility_id = app_facility.facility_id) "
			ls_select_field  = "app_facility_" + ls_lu_field
			ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
		elseif ls_select_field = 'loc_id' and upper(ls_db_lookup_type) = "L" then //Location
			ls_datatype = "C"
			if ls_lu_field = "state"  or ls_lu_field = "country" or ls_lu_field = "mailing_address" then
				//Use code_lookup.code display value -- jervis 08.04.2009
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup.code) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_practice on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_practice.rec_id) " + &
									"left join code_lookup on ( group_practice." + ls_lu_field + " = code_lookup.lookup_code) " 
			elseif  ls_lu_field = "county"  then
				//Use code_lookup.describe display value -- jervis 08.04.2009
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup.description) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_practice on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_practice.rec_id) " + &
									"left join code_lookup on ( group_practice." + ls_lu_field + " = code_lookup.lookup_code) " 
			elseif ls_lu_field = "mailing_address_desc" then		//Export Description - jervis 08.07.2009
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup.description) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_practice on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_practice.rec_id) " + &					
									"left join code_lookup on ( group_practice.mailing_address = code_lookup.lookup_code) " 
			else
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),group_practice."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_practice on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_practice.rec_id) "
			end if
			ls_select_field = "group_practice_" + ls_lu_field
		elseif ls_select_field = 'parent_comp_id' and Upper(ls_db_lookup_type) = "M" then	//Parent Organization -- jervis 06.23.2009			
			ls_datatype = "C"
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),group_multi_loc."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join group_multi_loc on("+ Lower(ls_select_table) + "." + ls_select_field + " = group_multi_loc.rec_id) "
			ls_select_field = "group_multi_loc_" + ls_lu_field

		//---------Start code by jervis 03.17.2009-------------
		//Export Requiments data
		elseif ls_select_field = 'ctx_req_profile_id' and Upper(ls_db_lookup_type) = "R"	 then //Requiren profile dddw-jervis 03.17.2009
			ls_Datatype = 'C'
			ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),ctx_req_profile."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join ctx_req_profile on("+ Lower(ls_select_table) + "." + ls_select_field + " = ctx_req_profile.ctx_req_profile_id) "
			ls_select_field = "ctx_req_profile_" + ls_lu_field
		ElseIf ll_ctx_scrn_id = 22 Then
			ls_datatype = of_get_coltype(lds_dataobject,ls_select_field_ctx) 
			//ls_select_table = 'ctx_orgs_contact'//added by gavins 20130314
			If ls_select_field = 'org_type' then
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
											ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " inner join ctx_orgs on " + Lower(ls_select_table) + ".org_id"  +" = ctx_orgs.org_id  left join code_lookup on (ctx_orgs." + ls_select_field + " = code_lookup.lookup_code) "
			Else
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),ctx_orgs."+ ls_select_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " inner join ctx_orgs on " + Lower(ls_select_table) + ".org_id"  +" = ctx_orgs.org_id  "
			End if
			ls_select_field  = "ctx_orgs_" + ls_select_field				
		elseif ll_ctx_scrn_id = 12 then	//Export Requirements Profile Detail Data - jervis 03.17.2009
			ls_datatype = of_get_coltype(lds_dataobject,ls_select_field_ctx)
			choose case ls_select_field
				case 'data_value'
					ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + "),(Case ctx_req_tmplt_element.value_type when 1 then convert(varchar," + ls_select_table + ".date_value ,101) when 2 then " + ls_select_table+ ".field_value when 3 then " + ls_select_table + ".char_value when 4 then cast(" +ls_select_table+".integer_value as varchar) when 6 then cast(" +ls_select_table+".money_value as varchar) when 5 then " +ls_select_table +" .field_value end)) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " 
											//ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
											//"left join ctx_req_tmplt_element on (" + ls_select_table + ".ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id)"
					ls_select_field = ls_select_table + "_"+ls_select_field
				case 'element_sort'	//in process....
				case 'requirement'	
					ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + "),ctx_req_tmplt_element.element_name) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " //+ &
											//ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
											//"left join ctx_req_tmplt_element  on (" + ls_select_table + ".ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id)"
					ls_select_field =  "ctx_req_tmplt_element_"+ls_select_field
				case 'ctx_rqmnt_category_id'	//in process....
				case 'ctx_req_profile_id'	//in process
				case 'category_name'
					ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + "),ctx_rqmnt_category.category_name) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " //+ &
											//ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
											//"left join ctx_req_tmplt_element on (" + ls_select_table + ".ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id) " + &
											//"left join ctx_rqmnt_category  on (ctx_req_tmplt_element.ctx_rqmnt_category_id = ctx_rqmnt_category.ctx_rqmnt_category_id and " + ls_linktotable + ".ctx_req_profile_id = ctx_rqmnt_category.ctx_req_profile_id)"
					ls_select_field = "ctx_rqmnt_category_"+ls_select_field

				case else		//case 'clause'
					ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + ")," + ls_select_table + "."+ ls_select_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " //+ &
											//ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on 
											
					ls_select_field = ls_select_table + "_"+ls_select_field
			end choose
			ls_sny_retrieve =  ls_sny_retrieve + ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
									" left join ctx_req_tmplt_element on (" + ls_select_table + ".ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id) " + &
									" left join ctx_rqmnt_category  on (ctx_req_tmplt_element.ctx_rqmnt_category_id = ctx_rqmnt_category.ctx_rqmnt_category_id and " + ls_linktotable + ".ctx_req_profile_id = ctx_rqmnt_category.ctx_req_profile_id)"
		//---------End code by jervis 03.17.2009-------------	

		//Export the Processing Setting for Contract status tract
		elseif ll_ctx_scrn_id = 2004 and ls_select_field = "processing_setting"	 then
			ls_datatype = 'C'
			ls_sny_retrieve = ls_sny_retrieve +  " convert(varchar(" + String(li_widthtemp) + "),case code_lookup.custom_2 when 'On' then 'In Process' when 'Off' then 'On Hold' when 'Complete' then 'Executed' when 'NA' then 'N/A' else custom_2 end ) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on + ls_select_table + ls_select_table_on + &
									" left join code_lookup on (" + ls_select_table+ ".status = code_lookup.lookup_code)" // and code_lookup.lookup_name = 'Contract Status')" -- comment by jervis -- 04.26.2011
		ElseIf ls_select_field = 'contact_id' and ll_ctx_scrn_id <> 2001 Then  //Add ll_ctx_scrn_id <> 2001 -- jervis 01.28.2011
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 06.05.2007 By: Jack
			//$<reason> Fix a defect.
			If ls_lu_field = 'contact_department' Or ls_lu_field = 'contact_type' Or ls_lu_field = 'contact_id' Then
				ls_datatype = "N"
			Else
				ls_datatype = "C"
			End If
			
			If ls_lu_field = 'phone' or ls_lu_field = "ext" or ls_lu_field = "contact_email" Then
				if ls_lu_field = "contact_email" then
					ls_lu_codename = "Email"
				else
					ls_lu_codename = "Phone"
				end if
				//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),(select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and a.via = (select lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null)) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contract_contacts,ctx_contacts " + ", (" + ls_prac_sql + ") bb " + " where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "' and "
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),(select top 1 A." + ls_lu_field+ " from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and lower(code) = '" + lower(ls_lu_codename) + "' ) and a." + ls_lu_field + " is not null)) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id )"
				ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
	
			Else
				//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),ctx_contacts."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contacts," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(" + Lower(ls_select_table) + "." + ls_select_field + " = ctx_contacts.contact_id) and "
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),ctx_contacts."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										ls_syn_parent +  ls_link_table + ls_link_table_on +  lower(ls_select_table) + ls_select_table_on + " left join ctx_contacts on(" + Lower(ls_select_table) + "." + ls_select_field + " = ctx_contacts.contact_id) "
				//Add other contact - jervis 03.28.2011
				if (ll_ctx_scrn_id = 6 or ll_ctx_scrn_id = 7 or ll_ctx_scrn_id = 14 or ll_ctx_scrn_id = 17) and lower(ls_select_table) = "ctx_contract_contacts" Then
					ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
				end if
			End If
			//---------------------------- APPEON END ----------------------------
			
			ls_select_field  = "ctx_contacts_" + ls_lu_field
		elseif ll_ctx_scrn_id = 2002 and (ls_select_field = 'phone' or ls_select_field = "ext" or ls_select_field = "contact_email") then  //Add by jervis 03.28.2011
			ls_datatype = "C" 
			//,(select top 1 A." + ls_lu_field+ " from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and lower(code) = '" + lower(ls_lu_codename) + "' ) and a." + ls_lu_field + " is not null))
			ls_field_value = " convert(varchar(" + String(li_widthtemp) + "),"+ ls_select_table + "." +ls_select_field + ") "
			
			if ls_select_field = "contact_email" then
				ls_lu_codename = "Email"
			else
				ls_lu_codename = "Phone"
			end if
				
			ls_sny_retrieve = ls_sny_retrieve + ls_field_value + " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
											ls_syn_parent +ls_link_table + ls_link_table_on +   Lower(ls_select_table) + ls_select_table_on
			//overwrite link other where condition
			if li_use_link = 1 and (ll_ctx_link_scrn_id = 6 or ll_ctx_link_scrn_id = 7 or ll_ctx_link_scrn_id = 14 or ll_ctx_link_scrn_id = 17) Then
				ls_other_where = " and ("+ ls_select_table + ".via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and lower(code) = '" + lower(ls_lu_codename) + "' and " + ls_select_table +  "." + ls_select_field + " is not null) and ctx_contract_contacts.ic_area = '" +ls_ic_link_area + "' ) "
			end if
		ElseIf ls_select_field = 'compute_1' Then
			ls_datatype = "C"
				
			//ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  isnull(ctx_contacts.last_name,'') + ','  + isnull(ctx_contacts.first_name,'') + case when isnull(ctx_contacts.middle_name,'') <> '' THEN ', ' + isnull(ctx_contacts.middle_name,'') else '' END field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contract_contacts,ctx_contacts " + ", (" + ls_prac_sql + ") bb " + " where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "' and "
			if lb_get_parent then
				ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " table_1.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  isnull(ctx_contacts.last_name,'') + ','  + isnull(ctx_contacts.first_name,'') + case when isnull(ctx_contacts.middle_name,'') <> '' THEN ', ' + isnull(ctx_contacts.middle_name,'') else '' END field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "')"
			ELSE
				ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  isnull(ctx_contacts.last_name,'') + ','  + isnull(ctx_contacts.first_name,'') + case when isnull(ctx_contacts.middle_name,'') <> '' THEN ', ' + isnull(ctx_contacts.middle_name,'') else '' END field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										 " ctx_contract_contacts " +  " left join ctx_contacts on (ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "')"
			END IF
			ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
			ls_select_field  = "compute_1"
		ElseIf ls_select_field = 'contact_phone' Then
			ls_datatype = "C"
			//ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  (select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contract_contacts,ctx_contacts where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "' and "
			if lb_get_parent then
				ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " table_1.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  (select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
			else
				ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  (select top 1 A.phone from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone' ) and a.phone is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										" ctx_contract_contacts  left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
			end if
			ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
		ElseIf ls_select_field = 'contact_email' Then
			ls_datatype = "C"
			If lb_get_parent Then
				//ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  (select top 1 A.contact_email from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and a.via = (select lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email' ) and a.contact_email is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_contract_contacts,ctx_contacts " + ", (" + ls_prac_sql + ") bb " + " where ctx_contract_contacts.contact_id = ctx_contacts.contact_id and ctx_contract_contacts.ic_area = '" + ls_ic_area + "' and "
				ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " table_1.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  (select top 1 A.contact_email from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email' ) and a.contact_email is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										ls_syn_parent + " ctx_contract_contacts " + ls_no_link_on + " left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
			Else
				ls_sny_retrieve = ls_synprefix + "Select " + ls_top + " ctx_contract_contacts.ctx_id, " + ls_tablepk + ls_Sortsel + String(ll_FieldSeqID) + " FieldSeqID,  (select top 1 A.contact_email from ctx_contacts_numbers A where A.contact_id = ctx_contract_contacts.contact_id and	a.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email' ) and a.contact_email is not null) field_value, '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										" ctx_contract_contacts  left join ctx_contacts on(ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) "
			End If
			ls_other_where = " and ctx_contract_contacts.ic_area = '" +ls_ic_area + "' "
		ElseIf Upper(ls_db_lookup_type)  = "C" Then //code lookup table
		
			ls_datatype_ctx = of_get_coltype(lds_dataobject,ls_select_field_ctx) //03.25.2011 by jervis			
			If Upper(ls_lu_field) = "LOOKUP_CODE" Then
				ls_datatype = "N"
			Else
				ls_datatype = "C"
			End If
			
			if ls_datatype_ctx = 'N' then //Non't convert - jervis 03.25.2011
				If ls_select_table <> 'app_facility' Then
					//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
											ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join code_lookup on (" + Lower(ls_select_table) + "." + ls_select_field + " = code_lookup.lookup_code) "
				Else
					//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_basic_info,code_lookup," + lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "			
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
											ls_syn_parent + ls_link_table + ls_link_table_on +  " ctx_basic_info " + ls_select_table_on + " left join app_facility on(ctx_basic_info.app_facility = app_facility.facility_id) left join code_lookup on (" + lower(ls_select_table) + "." + ls_select_field + " = code_lookup.lookup_code) "			
				End If
			else
				If ls_select_table <> 'app_facility' Then
					//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from code_lookup," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
											ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join code_lookup on (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) "
				Else
					//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_basic_info,code_lookup," + lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) and "			
					ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),code_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
											ls_syn_parent + ls_link_table + ls_link_table_on +  " ctx_basic_info " + ls_select_table_on + " left join app_facility on(ctx_basic_info.app_facility = app_facility.facility_id) left join code_lookup on (convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,code_lookup.lookup_code)) "			
				End If
			end if
			ls_select_field  = "code_lookup_" + ls_lu_field
		elseif Upper(ls_db_lookup_type) = "P" then
			ls_datatype_ctx = of_get_coltype(lds_dataobject,ls_select_field_ctx) //03.25.2011 by jervis
			//Company dddw process--jervis 12.9.2009
			ls_datatype = "C"
			if ls_datatype_ctx = 'N' then //Jervis 03.25.2011
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),app_facility."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join app_facility on(" + Lower(ls_select_table) + "." + ls_select_field + " = app_facility.facility_id) "
			else
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),app_facility."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join app_facility on(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,app_facility.facility_id)) "
			end if
			ls_select_field  = "app_facility_" + ls_lu_field
		ElseIf Upper(ls_db_lookup_type)  = "A" Then //address lookup table		
			If ls_lu_field = "description"  Then
				gnv_debug.of_output(true, 'Alarm  Export:' +  "The address lookup field set for export field '" + ls_select_field + "' is improperly set" ) //added by gaivns 20120912				
 				inv_message.of_MessageBox("Data Error on field " + ls_export_field,"The address lookup field set for export field '" + ls_select_field + "' is improperly set.  You cannot use description, try entity_name.  Please correct.",true)	
				Close(w_export_progress)

				if lb_ASA7 then
					ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
					EXECUTE IMMEDIATE :ls_Mysql;
				end if

				Destroy lds_export_flds
				Destroy lds_export_hdr
				Destroy lds_address_lookup
				Destroy lds_code_lookup
				Destroy lds_dept_chair
				Destroy lds_export_equiv_code
				Destroy lds_dataobject
				Destroy lds_linkto
				Destroy lds_field
				Destroy lds_export_dataTemp
				Destroy lds_tablepk
				Destroy lds_export_data
				Return 0			
			Else
				If Upper(ls_lu_field) = "LOOKUP_CODE" Then
					ls_datatype = "N"
				ElseIf Upper(ls_lu_field) = "CUSTOM_1" Or Upper(ls_lu_field) = "CUSTOM_2" Then //maha 050704 
					ls_datatype = "N"
				Else
					ls_datatype = "C"
				End If
				
				ls_bill_syn     =     ls_bill_syn + " address_lookup." + ls_lu_field + " from address_lookup," + Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and "
				//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),address_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from address_lookup," + lower(ls_select_table) +  ls_use_link_sql + " WHERE " + "(convert(varchar," + lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) and "				
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + "),address_lookup."+ ls_lu_field + ") field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										ls_syn_parent +  ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + " left join address_lookup on (convert(varchar," + Lower(ls_select_table) + "." + ls_select_field + ") = convert(varchar,address_lookup.lookup_code)) " //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
				ls_select_field  = "address_lookup_" + ls_lu_field
			End If
		Elseif ls_db_lookup_type = "X" Then//ToDo:
			
			ls_datatype = ldwc_dddw.Describe( ls_lu_field + ".coltype")
			Choose Case LeftA ( ls_datatype , 5 )
				Case "char(", "char"
					ls_datatype = "C"
				Case "date"	,"datet"	,"time", "times"
					ls_datatype = "D"
				Case "decim","numbe", "doubl", "real","long", "ulong", "int"
					ls_datatype = "N"
			End Choose
			
			ls_bill_syn     = ls_bill_syn + " " + ls_dddwtable + "."+ ls_dddw_column_dbname + " from " + ls_dddwtable + "," + &
									Lower(ls_select_table) +  ls_use_link_sqlsyn + " WHERE " + "(" + Lower(ls_select_table) + "." + &
									ls_select_field + " = " + ls_dddwtable + "." + ls_dddwdata + ") and "
			If Upper(ls_datatype) = 'D' Then
				ls_field_value = " convert(varchar(16)," + ls_dddwtable + "."+ ls_dddw_column_dbname + ",120)"
			else
				ls_field_value = " convert(varchar(" + String(li_widthtemp) + ")," + ls_dddwtable + "."+ ls_dddw_column_dbname + ")"
			end if			
			ls_sny_retrieve = ls_sny_retrieve + ls_field_value+ " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
									ls_syn_parent + ls_link_table + ls_link_table_on +  Lower(ls_select_table) + ls_select_table_on + &
									" left join " +ls_dddwtable + " on(" + Lower(ls_select_table) + "." +	ls_select_field + " = " + ls_dddwtable + "." + ls_dddwdata + ") "
			ls_select_field  = ls_dddwtable + "_" + ls_dddw_column_dbname
		Else // NON LOOKUP FIELDS
			ls_datatype = of_get_coltype(lds_dataobject,ls_select_field_ctx) //03.17.2009 by jervis
						
			If IsNull(ls_datatype) Then MessageBox("Datatype Not Anticipated","Retrieved null datatype")
			
			If Len(ls_aggre) > 0 Then //maha 012703 for aggregate functions
				//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + ")," + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ")) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
				ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(" + String(li_widthtemp) + ")," + ls_aggre + "("	+ ls_select_table + "." + ls_select_field + ")) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
										ls_syn_parent + Lower(ls_select_table) + ls_select_table_on
			Else
				if Upper(ls_datatype) = "D" then
					ls_field_value = " convert(varchar(16),"+ ls_select_table + "." +ls_select_field + ",120) "
				else
					ls_field_value = " convert(varchar(" + String(li_widthtemp) + "),"+ ls_select_table + "." +ls_select_field + ") "
				end if
				If ls_select_table <> 'app_facility' Then
					//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(16),"+ ls_select_table + "." +ls_select_field + ",120) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
					ls_sny_retrieve = ls_sny_retrieve + ls_field_value + " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
											ls_syn_parent +ls_link_table + ls_link_table_on +   Lower(ls_select_table) + ls_select_table_on
				Else
					//ls_sny_retrieve = ls_sny_retrieve + " convert(varchar(16),"+ ls_select_table + "." +ls_select_field + ",120) field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from ctx_basic_info," + Lower(ls_select_table) +  ls_use_link_sql + " WHERE "
					ls_sny_retrieve = ls_sny_retrieve + ls_field_value + " field_value,  '" + ls_datatype + "' field_data_type" + ls_RowNoSyn + " from " + &
											ls_syn_parent + ls_link_table + ls_link_table_on +  " ctx_basic_info " + ls_select_table_on + " left join " + Lower(ls_select_table) + " on(ctx_basic_info.app_facility = app_facility.facility_id)"
				End If
			End If			
		End If
		
		//export_fields_use_link  sql
		If li_use_link = 1 Then
			ls_use_link_sql2 = " (" + ls_linktotable + "." + ls_linktocol + " = " + ls_select_table + "." + ls_linkfromcol + ") and "
			//If Upper(ls_db_lookup_type) = "A" Or Upper(ls_db_lookup_type) = "C" Then	
			If Upper(ls_db_lookup_type) = "A" Or Upper(ls_db_lookup_type) = "C" or Upper(ls_db_lookup_type) = "X" or Upper(ls_db_lookup_type)  = 'R' Then //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
			Else
				ls_select_field = ls_select_table_trim + "_" + ls_select_field
			End If
		End If
		
		ls_bill_syn     = ls_bill_syn + ls_use_link_sql2
		//ls_sny_retrieve = ls_sny_retrieve + ls_use_link_sql2//(Appeon)Toney 07.12.2013 - V141 ISG-CLX cause the sql syntax error
		
		//add facility where
		If li_facil_id > 0 Then
			Choose Case ls_select_table
				Case "pd_address"
					ls_sny_retrieve = ls_sny_retrieve + "(pd_address_link.facility_id = " + String(li_facil_id) + ") and "
				Case "pd_hosp_affil"
					ls_sny_retrieve = ls_sny_retrieve + "(pd_hosp_facility_link.facility_id = " + String(li_facil_id) + ") and "
				Case "pd_board_specialty"
					ls_sny_retrieve = ls_sny_retrieve + "(pd_spec_facility_link.facility_id = " + String(li_facil_id) + ") and "
				Case "pd_affil_stat"
					ls_sny_retrieve = ls_sny_retrieve + "(pd_affil_stat.parent_facility_id = " + String(li_facil_id) + ") and "
				Case Else
					ls_sny_retrieve = ls_sny_retrieve +  + "(" + ls_select_table + ".facility_id = " + String(li_facil_id) + ") and "
					
					
			End Choose
		End If
		
		ls_billsynList[ll_FieldSeqID] = ls_bill_syn
			If ai_type = 1 Then
				//ls_sny_retrieve = ls_sny_retrieve + ls_usetable + ".ctx_id  = bb.ctx_id "  + ls_filter
				ls_sny_retrieve = ls_sny_retrieve + ", (" + ls_prac_sql + ") bb where " + ls_ctx_table + ".ctx_id  = bb.ctx_id and bb.ctx_id > 0 "  + ls_other_where + ls_filter	//jervis 08.26.2009 add bb.ctx_id > 0
			ElseIf ai_type = 3 Then
				//ls_sny_retrieve = ls_sny_retrieve + ls_usetable + ".ctx_id " + ls_prac_ids + ls_filter
				ls_sny_retrieve = ls_sny_retrieve + " where " + ls_ctx_table + ".ctx_id " + ls_prac_ids + ls_other_where + ls_filter
			ElseIf ai_type = 2 Then
				If lb_usingdb Then
					ls_sny_retrieve = ls_sny_retrieve + " Inner Join ic_client_data on (" + ls_ctx_table + ".ctx_id = ic_client_data.data_int and ic_client_data.client_id = '"+ls_client_id+"' ) where 1 = 1 "  + ls_other_where + ls_filter
				Else
					ls_sny_retrieve = ls_sny_retrieve + " where " + ls_ctx_table + ".ctx_id  in (" + ls_prac_ids  + ")"  + ls_other_where + ls_filter
				End If
				
			End If
			
			//---------Begin Added by (Appeon)Harry 04.10.2014 for Bug 3998--------
			if Len(ls_otherfilter) > 0 then
				ls_sny_retrieve = ls_sny_retrieve + ls_otherfilter
			end if
			//---------End Added ------------------------------------------------------
			
		//2nd last add  - prac where
		If Len(ls_aggre) > 0 Then //maha 012703 for aggregate functions
			//modify 08/15/2007 by: Andy
			ls_sny_retrieve = ls_sny_retrieve + " Group by " + ls_ctx_table + ".ctx_id , FieldSeqID ,  field_data_type" + ls_RowNo
		End If	

		if LenA(ls_sort) > 0 and Not lb_true then//SQL2000 only 
			//ls_sny_retrieve = ls_sny_retrieve + "~r~n order by " + ls_sort 
			ls_sny_retrieve = ls_sny_retrieve + "~r~n " + ls_sort
		end if
		
		if Not lb_ASA7 then 
			ls_sny_retrieve = ls_sny_retrieve + " ) t" + String(ll_FieldSeqID)
		ELSE
			//ls_MySQL = "INSERT INTO " + ls_tabletemp + " ~r~n(prac_id,FieldSeqID, billing_address_id, field_value, field_data_type) ~r~n " + ls_sny_retrieve + " ;"	
			 ls_MySQL = "INSERT INTO " + ls_tabletemp + " ~r~n(prac_id,FieldSeqID, field_value, field_data_type) ~r~n " + ls_sny_retrieve + " ;" //(Appeon)Toney 07.04.2013 for V141 ISG-CLX
			EXECUTE IMMEDIATE :ls_Mysql;
			IF SQLCA.SQLCode <> 0 THEN
 				inv_message.of_MessageBox("Caution on export field " + ls_export_field, SQLCA.SQLERRTEXT,TRUE)	
				close(w_export_progress)
				if lb_ASA7 then
					ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
					EXECUTE IMMEDIATE :ls_Mysql;
				end if
				if IsValid(lds_export_flds) then destroy lds_export_flds
				if IsValid(lds_export_hdr) then destroy lds_export_hdr
				if IsValid(lds_address_lookup) then destroy lds_address_lookup
				if IsValid(lds_code_lookup) then destroy lds_code_lookup
				if IsValid(lds_export_data) then destroy lds_export_data
				if IsValid(lds_dept_chair) then destroy lds_dept_chair
				if IsValid(lds_field) then Destroy lds_field
				if IsValid(lds_export_dataTemp) then Destroy lds_export_dataTemp
				if IsValid(lds_export_equiv_code) then Destroy lds_export_equiv_code
				Destroy lds_tablepk
				RETURN -1
			END IF
		END IF
		//end of add
		if isnull(ls_sny_retrieve) then ls_sny_retrieve = ""
		if LenA(ls_sny_retrieve) > 0 then 
			if ls_UnionSQL = "" then 
				ls_UnionSQL = ls_sny_retrieve
			else 
				ls_UnionSQL = ls_UnionSQL + "~r~n union all ~r~n" + ls_sny_retrieve
			end if
		end if

	else //computer fields
		//Dynamic create computer columns in order to Calculate its value
		/*1.deal with Expression**************/
		ls_export_field     = lds_export_flds.GetItemString(p,"export_field_name")
		of_replacespecchar(ls_export_field)
		ls_Expresstion      = Trim( lds_export_flds.GetItemString( p, "export_fields_expression" ) )//db_field_name
		ls_ComputerDataType = lds_export_flds.GetItemString(p,"ctx_column_datatype")
		if isnull(ls_export_field) then ls_export_field = ''
		if isnull(ls_Expresstion) then ls_Expresstion = ''
		if isnull(ls_ComputerDataType) then ls_ComputerDataType = ''
		if isnull(ls_field_format) then ls_field_format = ''
		if isnull(ls_fld_delim) then ls_fld_delim = ''
		ll_Cnt = lds_field.RowCount()
		
		//If the computer field is numeric,add the function number(  ) in to the Expresstion.
		//Replace symbol ' with "
		for ll_Num = 1 to ll_Cnt
			ls_Field         = lds_field.GetItemString(ll_Num,"export_field_name")
			ls_FieldDataType = lds_field.GetItemString(ll_Num,"ctx_column_datatype")
			if isnull(ls_Field) then ls_Field = ''
			if isnull(ls_FieldDataType) then ls_FieldDataType = ''
			//Reason:The Expresstion of a computer field cann't contain itself.
			if lower(ls_export_field) = lower(ls_Field) then continue
			
			//If the field used in then computer field and is number, 
			//add the function number(  ) in to the Expresstion 
			if PosA(lower(ls_Expresstion),lower(ls_Field)) > 0 then
				if upper(ls_FieldDataType) = 'N' then
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),0,number( " + ls_Field + " ))",true)
				elseif upper(ls_FieldDataType) = 'S' then
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),''," + ls_Field + " )",true)
				ELSEIF upper(ls_FieldDataType) = 'D' then
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),'1900-01-01'," + ls_Field + " )",true)
				end if
			end if
		next
		
		//replace symbol ' with "
		ls_Expresstion  = lnvo_string.of_globalreplace( ls_Expresstion, '~~', '~~~~')
		ls_Expresstion  = lnvo_string.of_globalreplace( ls_Expresstion, '"', '~~"')//'"'
		ls_tag = ls_field_format + '@^@' + ls_ComputerDataType + '@^@' + String(li_width) + '@^@'
		If ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" Then
			ls_tag += ls_fld_delim
		end if

		//2.Dynamic create computer columns,the name equal ls_Field + '_c'
		ls_modify = "create compute(band=detail alignment='0' expression=~""+ls_Expresstion+"~" border='0' color='33554432' x='1157'" + &
		            " y='4' height='64' width='242' format='[GENERAL]' html.valueishtml='0'  name=" + ls_export_field + "_c visible='0'" + &
						" font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0'" + &
						" background.mode='1' background.color='536870912' tag='" + ls_tag + "' )"
		ls_Err    = lds_export_dataTemp.Modify(ls_modify)
	End If
Next

w_export_progress.hpb_bar.position = 15
w_export_progress.st_export.text = "Retrieve Data"

ll_FieldCnt = ll_FieldSeqID
if ls_UnionSQL <> "" then
	if lb_true THEN//SQL2005 and ASA9
		//ls_UnionSQL = ls_UnionSQL + "~r~n order by " + "ctx_id , FieldSeqID "//ls_OrderBy
		ls_UnionSQL = ls_UnionSQL + "~r~n order by " + "FieldSeqID, ctx_id , Row_No"
	end if

	if lb_true then ls_RowNo = ", 0 Row_No"//SQL2005 AND ASA9
	if lb_ASA7 then
		ls_SqlSelect = "Select prac_id,FieldSeqID,field_value,field_data_type from " + ls_tabletemp
	else
		ls_SqlSelect = "Select top 1 0 prac_id, 1 FieldSeqID, cast('' as varchar(" + String(ll_maxwidth) + ")) field_value,  ' ' field_data_type" + ls_RowNo + " from pd_basic"
	end if			
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_SqlSelect, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		gnv_debug.of_output(true, 'Alarm  Export:' +  "SyntaxFromSQL caused these errors: " + Errors + "~r~r" + ls_SqlSelect  ) //added by gaivns 20120912		

 		inv_message.of_MessageBox("Caution on export field ","SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_SqlSelect,TRUE)	
		close(w_export_progress)
		if lb_ASA7 then
			ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
			EXECUTE IMMEDIATE :ls_Mysql;
		end if
		Destroy lds_export_flds
		Destroy lds_export_hdr
		Destroy lds_address_lookup
		Destroy lds_code_lookup
		Destroy lds_dept_chair
		Destroy lds_export_equiv_code
		Destroy lds_dataobject
		Destroy lds_linkto
		Destroy lds_field
		Destroy lds_export_dataTemp
		Destroy lds_tablepk
		Destroy lds_export_data
		RETURN -1
	END IF

	lds_export_retrieve = CREATE n_ds
	w = lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
	if w < 1 then
		gnv_debug.of_output(true, 'Alarm  Export:' +  "lds_export_retrieve create  errors: " + Errors  + '~r' + ls_SqlSelect   ) //added by gaivns 20120912		
 		inv_message.of_MessageBox("Error on Create",errors,TRUE)	
		close(w_export_progress)
		if lb_ASA7 then
			ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
			EXECUTE IMMEDIATE :ls_Mysql;
		end if
		Destroy lds_export_flds
		Destroy lds_export_hdr
		Destroy lds_address_lookup
		Destroy lds_code_lookup
		Destroy lds_dept_chair
		Destroy lds_export_equiv_code
		Destroy lds_dataobject
		Destroy lds_linkto
		Destroy lds_field
		Destroy lds_export_dataTemp
		Destroy lds_tablepk
		Destroy lds_export_data
		return -1
	end if

	if Not lb_ASA7 then lds_export_retrieve.Modify('DataWindow.Table.Select="' + ls_UnionSQL + '"')
	
	lds_export_retrieve.SetTransObject( SQLCA )
	ll_ret_cnt = lds_export_retrieve.retrieve()
	
	if ll_Ret_Cnt < 0 then		
		gnv_debug.of_output(true, 'Alarm  Export:' +  "lds_export_retrieve retrieve<0 " + '~r' + ls_UnionSQL  ) //added by gaivns 20120912
		//Reason:check syntax
		ls_presentation_str = "style(type=grid)"
		
		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_UnionSQL, ls_presentation_str, ERRORS)
		IF LenA(ERRORS) > 0 THEN
			gnv_debug.of_output(true,"Caution on export:" + "SyntaxFromSQL caused these errors: " + Errors)			//Added By Mark Lee 02/01/2013			
			 inv_message.of_MessageBox("Caution on export" , "SyntaxFromSQL caused these errors: " + ERRORS,true)	
			close(w_export_progress)

			if lb_ASA7 then
				ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
				EXECUTE IMMEDIATE :ls_Mysql;
			end if

			if IsValid(lds_export_flds) then destroy lds_export_flds
			if IsValid(lds_export_hdr) then destroy lds_export_hdr
			if IsValid(lds_address_lookup) then destroy lds_address_lookup
			if IsValid(lds_code_lookup) then destroy lds_code_lookup
			if IsValid(lds_export_data) then destroy lds_export_data
			if IsValid(lds_dept_chair) then destroy lds_dept_chair
			if IsValid(lds_field) then Destroy lds_field
			if IsValid(lds_export_dataTemp) then Destroy lds_export_dataTemp
			if IsValid(lds_export_equiv_code) then Destroy lds_export_equiv_code
			Destroy lds_tablepk
			RETURN -1
		END IF		
	end if
end if

w_export_progress.hpb_bar.position = 20
li_bar_ticks = 70 / li_fld_cnt

//%%%%%%%%%%%%%%%%%%%%%%%%%%%% end of create syntax

ls_prac_field = lds_export_retrieve.describe("#1.name")

DO WHILE (ll_i <= ll_ret_cnt)
	ll_j = 0
	ls_data_value = ""
	ls_value = ""
	ls_lookup_val = ""
	ldt_value = datetime(date("0000-00-00"),time("00:00:00"))
	
	ll_pracid       = lds_export_retrieve.GetitemNumber(ll_i,ls_prac_field)
	ll_FieldSeqID   = lds_export_retrieve.GetitemNumber(ll_i,"FieldSeqID")
	li_recd_no      = li_recdnoList[ll_FieldSeqID]
	ls_select_table = ls_tablelist[ll_FieldSeqID]
	ls_select_field = ls_selectfieldlist[ll_FieldSeqID]
	ls_export_field = ls_fieldlist[ll_FieldSeqID]			
	ls_field_format = ls_formatList[ll_FieldSeqID]		
	ll_export_code  = ll_exportcodeList[ll_FieldSeqID]
	li_sub_start    = li_substartList[ll_FieldSeqID]
	li_width        = li_widthList[ll_FieldSeqID]
	ls_fld_delim    = ls_flddelimList[ll_FieldSeqID]			
	ls_text         = ls_textList[ll_FieldSeqID]
	ls_lu_field     = ls_lu_fieldList[ll_FieldSeqID]
	li_facil_id     = li_facil_idList[ll_FieldSeqID]
	li_act_format   = li_act_formatList[ll_FieldSeqID]
	
	ud = li_udList[ll_FieldSeqID]
	if ud = 1 then
		ls_def_val = ls_defvalList[ll_FieldSeqID]
	elseif ud = 2 then //column default
		col = Long(ls_defvalList[ll_FieldSeqID])
	else
		ls_def_val = ""
	end if
		
	if ll_FieldSeqIDold <> ll_FieldSeqID then
		ll_R = 0 
		ll_FieldSeqIDold = ll_FieldSeqID
		w_export_progress.st_export.text  = ls_select_table + "_" + ls_select_field    //string(ll_FieldSeqID) + "   " + 
		w_export_progress.st_export1.text = ls_select_field   
		
		if mod(ll_FieldSeqID,n) = 0 then w_export_progress.hpb_bar.position = w_export_progress.hpb_bar.position + 1
	end if
	
	FOR ll_R = ll_R + 1 to li_prac_id_cnt
		IF al_prac_ids[ll_R] = ll_pracid THEN EXIT
	NEXT
	
	//Find the max row of the current ll_pracid
	ls_find = "(" + ls_prac_field + " > " + String(ll_pracid) + " AND FieldSeqID = " + String(ll_FieldSeqID) + &
				 ") OR ( FieldSeqID  > " + String(ll_FieldSeqID) + ")"
	ll_j    = lds_export_retrieve.Find ( ls_find, ll_i + 1, ll_ret_cnt )
	if ll_j > 0 then ll_j = ll_j - 1 		//The max row of the current FieldSeqID

	//Perhaps it is the last ll_pracid and it is the max FieldSeqID, then set ll_j = ll_ret_cnt(max row in the ds)
	if ll_j = 0 then ll_j = ll_ret_cnt
	if ll_j - ll_i + 1 >= li_recd_no then 		//find out
		ll_prac_row = ll_i + li_recd_no - 1 
	else 		//Not 
		ll_prac_row = 0
	end if
	
	//process data
	if ll_prac_row > 0 then
		ls_datatype     = lds_export_retrieve.getitemString(ll_prac_row, "field_data_type" )	
	
		if li_billing = 1 then //maha app080205 to get billing address data 
			ll_billing_id   = lds_export_retrieve.getitemnumber(ll_prac_row, "billing_address_id" )
			ls_data_value = of_get_billing(ll_billing_id,ls_datatype,ls_select_field,ls_field_format,ls_billsynList[ll_FieldSeqID])//ls_bill_syn
		else
			ls_data_value = lds_export_retrieve.getitemString(ll_prac_row, "field_value")
		end if
	else
		//do nothing
	end if
	
	//save original values
	if lower(lds_export_dataTemp.describe(ls_export_field + ".name")) = lower(ls_export_field) then
		lds_export_dataTemp.SetItem(ll_R,ls_export_field,ls_data_value)
	end if
		
	if ls_format = "export" then
		if isnull(ls_data_value) then ls_data_value = ""
	end if

	//$<reason> Fix a defect.
	If ls_lu_field = 'contact_department' or ls_lu_field = 'contact_title' or ls_lu_field = 'contact_type' Then
		//modify 09/05/2007 by: Andy Reason:get description
		//ls_data_value = gnv_data.of_getitem('code_lookup', 'code', "lookup_code = " + ls_data_value)
		ls_data_value = gnv_data.of_getitem('code_lookup', 'description', "lookup_code = " + ls_data_value)
	End If

	//*****GET EXPORT CODES
	//if lds_export_flds.GetItemnumber( p, "export_code" )  = 1 then //get export code if required
	if ll_export_code  = 1 then //get export code if required
		ls_lookup_val = ls_data_value    //lds_export_data.getitemstring(i,p) //changed 100102
		if isnull(ls_lookup_val) then ls_lookup_val = ''
		//Convert data type - jervis 03.25.2011
		if isnumber(ls_lookup_val) then 
			ls_lookup_code = string(long(ls_lookup_val))
		else
			ls_lookup_code = ls_lookup_val
		end if		
		ll_find = lds_export_equiv_code.Find( "export_id = " + String(ai_export_id) + " and (string(lookup_code) = '" + ls_lookup_code + "' or code = '" + string(ls_lookup_val) + "')", 1, ll_rowcount2 ) //Add code -- jervis 03.25.2011
			
		If ll_find > 0 Then
			ls_value = lds_export_equiv_code.GetItemString(ll_find,'equiv_code')
		End If
		
		if not isnull(ls_value) and trim(ls_value) <> '' then ls_data_value = ls_value //if no export code use org value
		if isnull(ls_data_value) then ls_data_value = ""
	end if				
			
	ls_dc_field = ls_dcfieldList[ll_FieldSeqID]	
	if ls_dc_field = 'none' or isnull(ls_dc_field) then 
		//skip
	else  //if set to a field name get the data
		If IsNumber(ls_data_value) Then
			
			ll_find = lds_dept_chair.Find("facility_id = " +  String(li_facil_id) + " and department_code = " + "'" + ls_data_value + "'",1,ll_rowcount)
			If ll_find > 0 Then
				ls_data_value = lds_dept_chair.GetItemString(ll_find,ls_dc_field)
			Else
				ls_data_value = ""
			End If
		End If
	end if
	//Active Status format for affil stat maha 083105
	ll_intcred_field = ll_intcredfieldList[ll_FieldSeqID]
	if ll_intcred_field = 100000 then
		If li_act_format = 1 Then
			If ls_data_value = "1" Then
				ls_data_value = "Y"
			Else
				ls_data_value = "N"
			End If
		ElseIf li_act_format = 2 Then
			Choose Case ls_data_value
				Case "1"
					ls_data_value = "Active"
				Case "2"
					ls_data_value = "Purge"
				Case "3"
					ls_data_value = "Inactive"
				Case "4"
					ls_data_value = "Pending"
				Case "0"
					ls_data_value = "History"
			End Choose
		End If
	end if
	
	if ls_strip_char <> "NONE" then
		ls_data_value = of_strip_char( ls_strip_char ,ls_data_value, "")
	end if
	
	//*** substring function***************************8
	//create datafield for substring_start
	if li_sub_start > 1 then ls_data_value = MidA(ls_data_value,li_sub_start,li_width)
	//***padding //note if avoid using return, double return, empty string or tab when padding
	ls_data_value = MidA(ls_data_value,1,li_width) //shrink the length to size 
	if ls_field_format = "Leading Padding" or ls_field_format = "Trailing Padding" then 
		if li_width - LenA(ls_data_value) > 0 then
			li_dif = li_width - LenA(ls_data_value)
			ls_pad = "" //reset
			ls_pad = FillA ( ls_fld_delim, li_dif )
			if ls_field_format = "Leading Padding" then
				ls_data_value = ls_pad + ls_data_value 
			else
				ls_data_value = ls_data_value + ls_pad
			end if
		end if
	elseif ls_field_format = "use text" then //allows a set value if data is found
		if LenA(ls_data_value) > 0 then
			ls_data_value = ls_text
		end if
	end if	

	//****set default moved here 091305
	if ud > 0 then
		if isnull(ls_data_value) then ls_data_value = ""
		
		if ls_data_value = "" then
			if ud = 1 then
				ls_data_value = ls_def_val
			elseif ud = 2 then //if set to column get the value out of that column
				if col < 1 or col > li_fld_cnt then //setting trap
					gnv_debug.of_output(true, 'Alarm  Export:' +  "You are using a column default for column " + ls_export_field + " , but your default value is not a valid column number.~rThe default column number must be less than this column." ) //added by gaivns 20120912					
 					inv_message.of_MessageBox("Invalid setting","You are using a column default for column " + ls_export_field + " , but your default value is not a valid column number.~rThe default column number must be less than this column.",true)	
					close(w_export_progress)
					if lb_ASA7 then
						ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
						EXECUTE IMMEDIATE :ls_Mysql;
					end if
					Destroy lds_export_flds
					Destroy lds_export_hdr
					Destroy lds_address_lookup
					Destroy lds_code_lookup
					Destroy lds_dept_chair
					Destroy lds_export_equiv_code
					Destroy lds_dataobject
					Destroy lds_linkto
					Destroy lds_field
					Destroy lds_export_dataTemp
					Destroy lds_tablepk
					Destroy lds_export_data
					return 0
				end if
				ls_data_value = lds_export_data.getitemstring(ll_R,col)
			end if
		end if
	end if
	
	//*********value set**********	
	if li_fld_cnt = 1 then ls_data_value = ls_data_value + CharA(9)	
	if lower(lds_export_data.describe(ls_export_field + ".name")) = lower(ls_export_field) then
		//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//Begin - Added By Mark Lee 09/29/12 its cannot use double quote to merge data values in  the MS word.
		If Pos(ls_data_value,'"') > 0 Then 
			gnv_debug.of_output(true, 'Alarm  Export: Its used the double quote Replace the blank data in merged data value on the column ['+ls_export_field+'], and this current data value is the ['+ls_data_value+'].' )
			ls_data_value  = lnvo_string.of_globalreplace( ls_data_value, '"', ' ')
		End If
		//End - Added By Mark Lee 09/29/12
		//---------End Added ------------------------------------------------------
		lds_export_data.setitem(ll_R,ls_export_field,ls_data_value)
	end if
	
	//processing the next field(fieldseqid)
	ll_i = ll_j + 1	
LOOP 

//process default value
if of_export_processdefault(lds_export_hdr,lds_export_flds,lds_export_datatemp,lds_export_data) = -1 then 
	gnv_debug.of_output(true, 'Alarm  Export: of_export_processdefault=-1 ' )//added by gavins 20120912	

	close(w_export_progress)
	if lb_ASA7 then
		ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
		EXECUTE IMMEDIATE :ls_Mysql;
	end if
	Destroy lds_export_flds
	Destroy lds_export_hdr
	Destroy lds_address_lookup
	Destroy lds_code_lookup
	Destroy lds_dept_chair
	Destroy lds_export_equiv_code
	Destroy lds_dataobject
	Destroy lds_linkto
	Destroy lds_field
	Destroy lds_export_dataTemp
	Destroy lds_tablepk
	Destroy lds_export_data
	return 0	
end if

//Set Calculated field value and format into lds_export_data with the relative computer column in lds_export_dataTemp
of_export_calculatedfield(lds_export_dataTemp,lds_export_data,ls_format)
w_export_progress.hpb_bar.position = 94

//1:save / 3:save & preview
if ai_save_data = 1 or ai_save_data = 3 then
	w_export_progress.st_progress.Text = "Saving File"
	sd = lds_export_data.Update()
	Commit Using SQLCA;
	
	If sd < 1 Then 		
		gnv_debug.of_output(true, 'Alarm  Export: lds_export_data update failed ' )//added by gavins 20120912		
 		inv_message.of_MessageBox("Save error","Unable to save data to table",true)	
	End If
End If
//---------Begin Added by (Appeon)Toney 06.24.2013 for V141 ISG-CLX--------
ids_export_data = lds_export_data
If ids_export_data.Rowcount( ) = 0 Then
	gnv_debug.of_output(true, 'Alarm  Export: lds_export_data rowcount()=0 '  )//added by gavins 20120912
Else
	ib_writefile = true //added by gavins 20121011
End If
//---------End Added ------------------------------------------------------------------

w_export_progress.st_progress.Text = "Creating File"
w_export_progress.hpb_bar.position = 100
li_bar_ticks = 75 / li_prac_id_cnt
n = int(li_fld_cnt/80) + 1
//******************************* CREATE FILE

ls_save_path = as_path
if RightA(ls_save_path,1) = ':' then ls_save_path = ls_save_path + "\"
ll_lastpos = LastPos(ls_save_path,'.') 
if ll_lastpos > 0 then 	ls_save_path = LeftA(ls_save_path,ll_lastpos - 1)

//If the directory is not exists Then create it 
If MidA(ls_save_path,LenA(ls_save_path),1) = "\" Then
	ls_path1 = ls_save_path
Else
	ls_path1 = MidA(ls_save_path,1,lastpos(ls_save_path,'\'))
End If
//Add By Jervis 11-19-2008
if ls_path1 = "" then
	IF AppeonGetClientType() = 'WEB' THEN
		ls_path1 = gs_temp_path + "ExportData\"
		ls_save_path = ls_path1 + ls_save_path
	else
		ls_path1 = Gs_Current_Directory + "\ExportData\"
		ls_save_path = ls_path1 + ls_save_path
	end if
Else
	//Added By Ken.Guo 2011-01-11.
	If invo_rights.of_check_dir_right(ls_path1, True,'Export') <> 1 Then
		gnv_debug.of_output(true, 'Alarm  Export: check dir right failed '  + ls_path1 )//added by gavins 20120912
		If isvalid(lds_export_flds) Then Destroy lds_export_flds;
		If isvalid(lds_export_hdr) Then Destroy lds_export_hdr;
		If isvalid(lds_address_lookup) Then Destroy lds_address_lookup;
		If isvalid(lds_code_lookup) Then Destroy lds_code_lookup
		If isvalid(lds_export_equiv_code) Then Destroy lds_export_equiv_code;
		If isvalid(lds_dataobject) Then Destroy lds_dataobject
		If isvalid(lds_linkto) Then Destroy lds_linkto;
		If isvalid(lds_field) Then Destroy lds_field
		If isvalid(lds_export_dataTemp) Then Destroy lds_export_dataTemp
		If isvalid(lds_tablepk) Then Destroy lds_tablepk
		If isvalid(w_export_progress) Then Close(w_export_progress)		
		Return 0
	End If
end if
//End By Jervis 
gnv_appeondll.of_parsepath(ls_path1)


If MidA(ls_save_path,LenA(ls_save_path),1) <> "\" Then //maha app 102405 if a file name is indicated do not tack on the table name
	ls_path = ls_save_path +  ls_format
Else
	if li_custom_save > 0 then  //maha new 121205 for custom naming of file
		ls_save_name = of_custom_name(li_custom_save,ls_table_name,ldt_date)
	else
		ls_save_name = ls_table_name
	end if
	ls_path = ls_save_path + ls_save_name + ls_format
End If

as_path = ls_path


//---------Begin Added by (Appeon)Harry 03.26.2014--------
if LenA(ls_post_sort) > 0 then
	lds_export_data.setsort(ls_post_sort)
	lds_export_data.sort()
end if
//---------End Added ------------------------------------------------------

if lb_export = false then
	gnv_rights.of_check_dir_right( ls_path, true, 'Export') //(Appeon)Toney 06.25.2013 for V141 ISG-CLX 
    //------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 03.26.2013
	//$<reason>  V12.3	Add ‘Drop Column Before Saving File’
	/*  Choose Case ls_format
		Case ".txt"
			If ls_header = "1" Then
				g = lds_export_data.SaveAs(ls_path,Text!,True)
			Else
				g = lds_export_data.SaveAs(ls_path,Text!,False)
			End If
		Case ".xls"
			If ls_header = "1" Then
				g = lds_export_data.SaveAs(ls_path,excel!,True)
			Else
				g = lds_export_data.SaveAs(ls_path,excel!,False)
			End If
		case ".csv"
			if ls_header = "1" then 
				g = lds_export_data.saveas(ls_path,csv!,true)
			else
				g = lds_export_data.saveas(ls_path,csv!,false)
			end if
	End Choose	*/
	if ls_header = "1" then
		g = of_copy_expdata(lds_export_data, ls_format, true, ls_path, true)
		if g <> 1 then return 0 
	else
		g = of_copy_expdata(lds_export_data, ls_format, false, ls_path, true)
		if g <> 1 then return 0 
	end if
	//------------------- APPEON END -------------------
 	If g = -1 Then inv_message.of_MessageBox("saveas -1","Unable to save file.  Check path (" + ls_path + ") and make sure a copy of the file is not open.",true)
Else
	//build export text file
	li_file_num = FileOpen(ls_path, lineMode!, Write!, LockWrite!, Replace!)//maha changed to line mode 091002

	w_export_progress.hpb_bar.position = 10
	if of_copy_expdata(lds_export_data, '', false, '', false) <> 1 then return 0 //add by Stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	
	For i = 1 To li_prac_id_cnt
		if mod(i,n) = 0 then
			w_export_progress.hpb_bar.position = w_export_progress.hpb_bar.position + 1
		end if
		For p = 1 To li_fld_cnt
			ls_data_value = lds_export_data.GetItemString(i,p)
			ls_fld_delim = lds_export_flds.GetItemString( p, "trailing_leading_characters")
			ls_field_format = lds_export_flds.GetItemString(p,"export_format")
			//------------------- APPEON BEGIN -------------------
			//$<add> stephen  03.26.2013
			//$<reason> V12.3	Add ‘Drop Column Before Saving File’
			li_drop_col = lds_export_flds.GetItemNumber(p,"drop_column")
			if isnull(li_drop_col) then li_drop_col = 0
			if  li_drop_col = 1 then continue 
			//------------------- APPEON END -------------------
			
			Choose Case ls_fld_delim
				Case "E" //empty String
					ls_delim_value = ""
				Case "S" // space
					ls_delim_value = " "
				Case "T" //tab
					ls_delim_value = "	"
				Case "R" //return
					ls_delim_value = "~r"
				Case "D" //return
					ls_delim_value = "~r~r"
				Case Else
					ls_delim_value = ls_fld_delim
			End Choose
			If IsNull(ls_delim_value) Then ls_delim_value = ""
			If ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" Then //don't add delimit value
				ls_export_text_file = ls_export_text_file + ls_data_value
			Else
				ls_export_text_file = ls_export_text_file + ls_data_value + ls_delim_value
			End If
			
		Next
		ls_export_text_file = ls_export_text_file + ls_rec_delim
		p = 1
		FileWrite ( li_file_num, ls_export_text_file)
		ls_export_text_file = ""
	Next
	FileClose(li_file_num)
End If

ids_export_data = lds_export_data //Fix a defect.

if is_called_type <> "2" and isvalid(w_export_progress) then
	w_export_progress.hpb_bar.position = 100
	Close(w_export_progress)
end if

//2:preview / 3:save & rpeview
if ai_save_data = 2 or ai_save_data = 3 then
	//------------------- APPEON BEGIN -------------------
	//$<modify> stephen 03.26.2013
	//$<reason> V12.3	Add ‘Drop Column Before Saving File’
    /* 	lstr_pass.s_string = is_select_syntax
	lstr_pass.s_dw = lds_export_data  */
	lstr_pass.s_string = is_select_syntax_drop
	lstr_pass.s_dw = ids_export_data_drop
	//------------------- APPEON END -------------------
	lstr_pass.s_string_array[1] = ls_UnionSQL //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
	openwithparm( w_export_previewdata, lstr_pass )
end if

if lb_ASA7 then
	ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
	EXECUTE IMMEDIATE :ls_Mysql;
end if

if lb_mulsel then
	ls_Mysql = "DELETE FROM export_temp WHERE SpID = " + String(ll_spid) + ";"
	EXECUTE IMMEDIATE :ls_Mysql;
end if

Destroy lds_export_flds; 
Destroy lds_export_hdr; 
Destroy lds_address_lookup; 
Destroy lds_code_lookup
Destroy lds_dept_chair; 
Destroy lds_export_equiv_code; 
Destroy lds_dataobject
Destroy lds_linkto;
Destroy lds_field
If isvalid(lds_export_dataTemp) Then Destroy lds_export_dataTemp //(Appeon)Toney 06.25.2013 - V141 ISG-CLX
Destroy lds_export_dataTemp
Destroy lds_tablepk

Return 1

end function

public function integer of_export_data_with_text_ctx (integer ai_export_id, long al_prac_ids[], ref string as_path, integer ai_save_data, string as_param1, string as_param2, string as_param3, integer ai_type, string as_sql);//////////////////////////////////////////////////////////////////////
// $<function>of_export_data_with_text_ctx_new()
// $<arguments>
//		value	integer	ai_export_id 		
//		value	long   	al_prac_ids[]		
//		value	string 	as_path      		 
//    value integer  ai_save_data (0:Nothing / 1:save / 2:preview / 3:save & preview)
//		value	string 	as_param1    		
//		value	string 	as_param2    		
//		value	string 	as_param3
//    value integer  ai_type      (1: specify SQL/2: specify array/3: between...and)
//    value string   as_sql       (the specified SQL)
// $<returns> integer
// $<description> Used for export IntelliContract data.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
//////////////////////////////////////////////////////////////////////

SetPointer( HourGlass! )
ib_writefile = false //(Appeon)Toney 06.24.2013 for V141 ISG-CLX

If IsNull(as_path) Or as_path = "" Then
 	inv_message.of_MessageBox("Data Error", "There is no save path for this file. Unable to continue this function.",true)	
	Return 0
End If
If ai_export_id < 1 Then
 	inv_message.of_MessageBox("User Error", "No export selected.  Unable to proceed.",true)	
	Return 0
End If

//open export progress window - alfee 02.06.2010
of_open_export_pogress() 
//---------Begin Added by (Appeon)Harry 09.01.2014 for BugH070801in V14.2 Issues of Integration.doc--------
If Not ib_export_test Then
		ib_gen_rec_id = True
End If
//---------End Added ------------------------------------------------------
IF of_create_export_table( ai_export_id,ai_save_data ) < 0 THEN
	gnv_debug.of_output(true, 'Alarm Replace Export:of_create_export_table<0' + ' ai_export_id=' + string( ai_export_id ) + ' ai_save_data=' + string( ai_save_data ) ) //(Appeon)Toney 06.24.2013 for V141 ISG-CLX	
	close(w_export_progress)
	return 0
END IF

String ls_dbtype
String ls_RowNo = ""
String ls_synprefix
String ls_table_name
String ls_header
String ls_format
String ls_post_sort
String ls_strip_char
String ls_rec_delim
String ls_save_path
String ls_prac_sql
String ls_Mysql
//String ls_prac_sql_temp
//String ls_prac_sql_temp2
//String ls_top = "top 2147483647"
String ls_sql_syntax
String ls_presentation_str
String Errors
String ls_dwsyntax_str
String ls_prac_ids = ""
String ls_client_id
String ls_tabletemp
String ls_select_field
String ls_value
String ls_field_format
String ls_ptype
String ls_pad
String ls_fld_delim
String ls_export_field
String ls_Expresstion
String ls_ComputerDataType
String ls_Field
String ls_FieldDataType
String ls_tag
String ls_modify
String ls_Err
String ls_sny_retrieve = ""
String ls_UnionSQL = ""
String ls_SqlSelect
String ls_prac_field
String ls_data_value
String ls_lookup_val
String ls_select_table
String ls_text
String ls_lu_field
String ls_find
String ls_def_val
String ls_datatype
String ls_lookup_code
String ls_dc_field
String ls_path1
String ls_path
String ls_save_name
String ls_export_text_file = ""
String ls_delim_value
String ls_sql
String ls_col_prac

Long ll_FieldSeqID = 0
Long li_custom_save
Long li_prac_id_cnt
Long ll_rowcount
Long ll_rowcount2
Long li_exp_type
Long ll_SpID
Long ll_pos
Long ll_len
Long ll_Cnt
Long li_fld_cnt
Long ll_maxwidth
Long i
Long g
Long n
Long p
Long li_sub_start
Long li_width
Long li_dif
Long ll_Num
Long ll_FieldCnt
Long w
Long ll_ret_cnt
Long li_bar_ticks
Long ll_i = 1
Long ll_j
Long ll_pracid
Long li_recd_no
Long ll_export_code
Long li_facil_id
Long li_act_format
Long ud
Long ll_FieldSeqIDold = -1
Long ll_R = 0
Long ll_prac_row
Long col
Long li_billing
Long ll_billing_id
Long ll_find
Long ll_intcred_field
Long sd
Long ll_lastpos
Long li_file_num

Integer li_drop_col
Integer li_module_type

DateTime ldt_date
DateTime ldt_value 

Boolean lb_true = false,lb_ASA7 = false
Boolean lb_export
Boolean lb_mulsel = false
Boolean lb_usingdb = False
n_cst_string lnvo_string
str_gensql_param lstr_gensql_param
str_pass lstr_pass

ldt_date = DateTime(Today(),Now()) //maha
ls_dbtype = of_get_dbtype()
if upper(ls_dbtype) = 'SQL2005' OR upper(ls_dbtype) = 'ASA9' THEN
	ls_RowNo = ",Row_No"
	lb_true = true
elseif upper(ls_dbtype) = 'ASA7' then
	lb_ASA7 = true
end if

if Not lb_ASA7 THEN 
	ls_synprefix = "select ctx_id,FieldSeqID,billing_address_id,field_value,field_data_type" + ls_RowNo + " from ("	
	//ls_synprefix = "select ctx_id,FieldSeqID,field_value,field_data_type" + ls_RowNo + " from (" //remove the billing_address_id field -  (Appeon)Toney 07.04.2013 for V141 ISG-CLX
end if

of_cleanup_array()

//Bubble sort the al_prac_ids array.
if ai_type = 2 then of_bubblesort(al_prac_ids)
li_prac_id_cnt = UpperBound( al_prac_ids[] )

//ids_export_flds.DataObject = "d_export_flds_list_exp_ctx"
//ids_export_flds.of_SetTransObject( SQLCA )
//---------Begin Added by (Appeon)Stephen 05.08.2015 for Notifications questions related to case #00054429 --------
if not isvalid(ids_dept_chair) then 
	of_create_ds()
end if
//---------End Added ------------------------------------------------------

gnv_appeondb.of_startqueue( )

ids_dept_chair.Retrieve()
ids_export_flds.Retrieve( ai_export_id )
ids_export_equiv_code.Retrieve()
ids_export_hdr.Retrieve( ai_export_id )
ids_field.Retrieve( ai_export_id )

gnv_appeondb.of_commitqueue( )

ll_rowcount = ids_dept_chair.RowCount()
ll_rowcount2 = ids_export_equiv_code.RowCount()

ls_table_name = ids_export_hdr.GetItemString(1,"export_name")
ls_header = ids_export_hdr.GetItemString(1,"field_labels_as_header")
ls_format = ids_export_hdr.GetItemString(1,"export_format")
ls_post_sort = ids_export_hdr.GetItemString(1,"sort_fields")

ls_strip_char = ids_export_hdr.getitemstring(1,"strip_char")
if isnull(ls_strip_char) or LenA(ls_strip_char) < 1 then ls_strip_char = "NONE"
if ls_format = ".csv" then ls_strip_char = "," 

li_custom_save = ids_export_hdr.getitemnumber(1,"custom_save_name") 
if isnull(li_custom_save) then li_custom_save = 0

//Use text with header format for merging data in document manager, agreement template or for email template. It's also for performance tunning.
If is_called_type = "2" Or is_called_type = '3' or is_called_type = '4' Then 
	ls_format = ".txt" 
	ls_header = '1'
END IF

if ls_format = "export"  then
	lb_export = true
	ls_format = ".txt" 
else //txt and xls files  files
	lb_export = false
end if

//---------Begin Commented by (Appeon)Stephen 11.09.2016 for Import with CSV file--------
/*
if ls_format = ".csv" then
	if upper( appeongetclienttype() ) = "WEB" then		
 		inv_message.of_MessageBox( "IntelliSoft", "The file type of CSV is unsupported on WEB.~r~nPlease go to Export Setup to modify settings.",true)	
		gnv_debug.of_output(true, 'Alarm  Export:' +"The file type of CSV is unsupported on WEB.~r~nPlease go to Export Setup to modify settings." ) //(Appeon)Toney 06.24.2013 for V141 ISG-CLX
		Close(w_export_progress)
		of_cleanup_ds()
		Return -1
	end if
end if
*/
//------------------- APPEON END ------------------

li_exp_type = ids_export_hdr.GetItemNumber(1,"export_type")
ls_rec_delim = ids_export_hdr.GetItemString(1,"record_delimiter")
ls_save_path = ids_export_hdr.GetItemString(1,"save_path")

select top 1 @@spid into :ll_SpID from ids;

//specify SQL
if ai_type = 1 then
	ls_prac_sql = of_getsql_from_export_temp (as_sql, ll_SpID, lb_mulsel, "ctx_id")
end if

//set record delimiter
Choose Case ls_rec_delim
	Case "C"
		ls_rec_delim = ","
	Case "R"
		ls_rec_delim = "~r"
	Case "T"
		ls_rec_delim = "	"
	Case "D"
		ls_rec_delim = "~r~r"
	Case "U"
	Case Else
		ls_rec_delim = ""
End Choose
If IsNull(ls_rec_delim) Then ls_rec_delim = ""


li_fld_cnt = ids_export_flds.RowCount()
ll_maxwidth = Long(ids_export_flds.describe("evaluate('max(export_field_length)',0)"))
if ll_maxwidth < 30 then ll_maxwidth = 30

//CREATE SYNTAX FOR export DW
ls_sql_syntax = is_select_syntax
ls_presentation_str = "style(type=grid)" //modify 08/15/2007 by: Andy
//ls_presentation_str = "style(type=form)"


ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, ls_presentation_str, Errors)
If LenA(Errors) > 0 Then //this will fail if the table has not been completed
	If PosA(Errors,"Table or view not found",1) > 0 Then
	     inv_message.of_MessageBox ("Error in of_export_data_with_text","Export data data store not able to be created.~rCheck to make sure no export fields have any spaces, and that all have a width.  You cannot have duplicate field names, and fields cannot start with a number.",true )	
		Close(w_export_progress)
		of_cleanup_ds( )
		Return -1		
	Else
		gnv_debug.of_output(true,"Caution :" + "SyntaxFromSQL caused these errors: " + Errors)	//(Appeon)Toney 06.24.2013 for V141 ISG-CLX
		inv_message.of_MessageBox("Caution","SyntaxFromSQL caused these errors: " + Errors,true)	
		Close(w_export_progress)
		of_cleanup_ds( )
		Return -1
	End If
	gnv_debug.of_output(true, 'Alarm  Export:SyntaxFromSQL errors:' +  Errors ) //(Appeon)Toney 06.24.2013 for V141 ISG-CLX
End If


ids_export_data.Create( ls_dwsyntax_str, Errors)
If len( errors ) > 0 Then
	gnv_debug.of_output(true, 'Alarm  Export:lds_export_data create errors:' +  Errors ) //(Appeon)Toney 06.24.2013 for V141 ISG-CLX
End If
ids_export_data.SetTransObject( SQLCA )

//---------Begin Added by (Appeon)Toney 11.28.2013 for V141 ISG-CLX--------
//$Reason:Fix BugT112602
n_cst_dw_update_prop  ln_dwprop
IF Upper(AppeonGetClientType())="WEB" THEN
	IF ai_save_data = 1 OR ai_save_data = 3 THEN
		ln_dwprop.of_modifyupdateproperty(ids_export_data, is_savetablename,false)
	END IF
END IF
//---------End Added ------------------------------------------------------------------

//save the original data that it's not format,in order to deal with the computer fields
ids_export_dataTemp.create( ls_dwsyntax_str, Errors )
ids_export_dataTemp.SetTransObject( SQLCA )

//w_export_progress.r_bar.Width = 300
w_export_progress.hpb_bar.position = 10
w_export_progress.st_progress.Text = "Populating Data for " + String(li_prac_id_cnt) + " Contract(s)"

//creates string of prac_ids for querys
//between...and...
if ai_type = 3 then
	if li_prac_id_cnt > 0 then ls_prac_ids = "between " + string(al_prac_ids[1]) + " and " + string(al_prac_ids[li_prac_id_cnt])
end if

//create rows for all practitioner data
FOR i = 1 TO li_prac_id_cnt
	//specify array
	if ai_type = 2 then ls_prac_ids = ls_prac_ids + String( al_prac_ids[i] ) + ","
	g = ids_export_data.insertrow(0)
next

//---------Begin Added by (Appeon)Toney 06.24.2013 for V141 ISG-CLX--------
If li_prac_id_cnt >= 100 Then
	lb_usingdb = True
	If inv_arr_db.of_array_to_db( al_prac_ids[],ls_client_id ) < 0 Then
		is_client_id[UpperBound(is_client_id[]) + 1 ] = ls_client_id
		if isvalid(w_export_progress) then close(w_export_progress)
		of_cleanup_ds( )	
		lb_usingdb = False
		gnv_debug.of_output( True, 'Export data with text error, Failed to insert array to DB.')
		Messagebox('Export Error','Failed to insert array data to DB.')
	End If
End If
//---------End Added ------------------------------------------------------------------

//if ai_save_data = 1 or ai_save_data = 3 then
if ai_save_data = 1 or ai_save_data = 3  or ib_gen_rec_id then //for Date Alarm - Alfee 06.11.2008
	ids_export_data.object.rec_id.Primary[] = al_prac_ids[]
end if
ids_export_data.Rowscopy( 1, ids_export_data.rowcount(), Primary!, ids_export_dataTemp, 1, Primary! )

//specify array
if ai_type = 2 then ls_prac_ids = LeftA( ls_prac_ids, LenA( ls_prac_ids ) -1 ) //remove last comma

//w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + 50
w_export_progress.hpb_bar.position = 11
w_export_progress.st_export.text = "Form SQL Statement"

n = int(li_fld_cnt/80) + 1

if lb_ASA7 then 
	ls_tabletemp = "t_export" + String(ll_SpID)
	ls_MySQL = "CREATE TABLE " + ls_tabletemp + " (prac_id int null,FieldSeqID int null, billing_address_id int null, field_value varchar( " + String(ll_maxwidth) + ") null, field_data_type CHAR(1))"		
	//ls_MySQL = "CREATE TABLE " + ls_tabletemp + " (prac_id int null,FieldSeqID int null, field_value varchar( " + String(ll_maxwidth) + ") null, field_data_type CHAR(1))" //(Appeon)Toney 07.04.2013 for V141 ISG-CLX
	
	EXECUTE IMMEDIATE :ls_Mysql;
	if SQLCA.SQLCode <> 0 then
 		inv_message.of_MessageBox(gnv_app.iapp_object.DisplayName,sqlca.sqlerrtext,true)	
		close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1
	END IF
END IF

For p = 1 To li_fld_cnt
	li_width = ids_export_flds.GetItemNumber(p,"export_field_length")
	ls_field_format = ids_export_flds.GetItemString(p,"export_format")
	ls_data_value = ""
	ls_value = ""
	ls_lookup_val = ""
	li_sub_start=  0
	
	//Leading Padding or Trailing Padding Process
	ls_fld_delim = ids_export_flds.GetItemString( p, "trailing_leading_characters")
	Choose Case ls_fld_delim
		Case "R" //return
			ls_fld_delim = "~r"
		Case "T" //tab
			ls_fld_delim = "	"
		Case "D" //double return
			ls_fld_delim = "~r~r"
		Case "S" // space
			ls_fld_delim = " "
		Case "E" //empty string
			ls_fld_delim = ""
	End Choose	 
	//---------End Modfiied ------------------------------------------------------------------
	
	//hard coded text
	If ids_export_flds.GetItemNumber(p,"export_type") = 2 Then //set data for text fields
		ls_select_field = ids_export_flds.GetItemString(p,"export_field_name")
		ls_value = ids_export_flds.GetItemString(p,"field_value")
		If IsNull(ls_value) Then ls_value = ""
		If ls_value = "&TODAY&" Then
			ls_value = String(ldt_date,"yyyy-mm-dd hh:mm")
			of_data_format(ls_field_format,'D',ls_value)
		End If
		//---------Begin Added by (Appeon)Harry 05.23.2014 for V142 ISG-CLX--------
		IF ls_value = "&USERID&" THEN
			ls_value = gs_user_id
		end if
		
		IF ls_value = "&USERNAME&" THEN
			select user_name into :ls_value from security_users where user_id = :gs_user_id;
		end if		
		//---------End Added ------------------------------------------------------
		Choose Case Upper(ls_value)
			Case "&PROMPT1&"
				ls_ptype = ids_export_hdr.GetItemString(1,"prompt_type1")
				ls_value = of_prompt_populate( ls_ptype, as_param1)
			Case "&PROMPT2&"
				ls_ptype = ids_export_hdr.GetItemString(1,"prompt_type2")
				ls_value = of_prompt_populate( ls_ptype, as_param2)
			Case "&PROMPT3&"
				ls_ptype = ids_export_hdr.GetItemString(1,"prompt_type3")
				ls_value = of_prompt_populate( ls_ptype, as_param3)
		End Choose
		If	ls_ptype = 'D' Then
			ldt_date = DateTime(Date(ls_value),Now())
			ls_value = String(ldt_date,"yyyy-mm-dd hh:mm")
			of_data_format(ls_field_format,'D',ls_value)
		End If

		li_sub_start = ids_export_flds.getitemnumber(p,"export_fields_substring_start")
		if li_sub_start > 1 then ls_value = MidA(ls_value,li_sub_start,li_width)		
		ls_value = MidA(ls_value,1,li_width) //shrink the length to size 

		//---------Begin Added by (Appeon)Toney 06.25.2013 for V141 ISG-CLX--------
		If ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" Then
			If li_width - Len(ls_value) > 0 Then
				li_dif = li_width - Len(ls_value)
				ls_pad = "" //reset
				ls_pad = Fill ( ls_fld_delim, li_dif )
				If ls_field_format = "Leading Padding" Then
					ls_value = ls_pad + ls_value
				Else
					ls_value = ls_value + ls_pad
				End If
			End If
		End If				
		//---------End Added ------------------------------------------------------------------

		For i = 1 To li_prac_id_cnt
			ids_export_data.SetItem(i,p,ls_value)
			ids_export_dataTemp.SetItem(i,p,ls_value)//<add> andy 2007.05.25 
		Next
	ElseIf ids_export_flds.GetItemNumber(p,"export_type") = 1 Then //get FIELDS DATA
		li_module_type = ids_export_flds.getitemnumber(p, 'export_fields_module_type')
		If Isnull(li_module_type) or li_module_type = 0 Then li_module_type = 3
		lstr_gensql_param.ll_rowno = p 
		lstr_gensql_param.ls_synprefix = ls_synprefix 
		lstr_gensql_param.ls_tabletemp = ls_tabletemp
		lstr_gensql_param.ls_prac_sql = ls_prac_sql 
		lstr_gensql_param.ls_prac_ids = ls_prac_ids 
		lstr_gensql_param.lb_usingdb = lb_usingdb 
		lstr_gensql_param.ls_client_id = ls_client_id 
		lstr_gensql_param.ls_rowno = ls_rowno 
		If li_exp_type = 6 and li_module_type = 1 Then
			lstr_gensql_param.li_link = 1
			if of_gensql_prac(ai_type, ll_fieldseqid, as_param1, as_param2, as_param3, ls_sny_retrieve, lstr_gensql_param) <> 1 then return -1
		Else
			lstr_gensql_param.li_link = 0
			if of_gensql_ctx(ai_type, ll_fieldseqid, as_param1, as_param2, as_param3, ls_sny_retrieve, lstr_gensql_param) <> 1 then return -1
		End If
		if LenA(ls_sny_retrieve) > 0 then 
			if ls_UnionSQL = "" then 
				ls_UnionSQL = ls_sny_retrieve
			else 
				ls_UnionSQL = ls_UnionSQL + "~r~n union all ~r~n" + ls_sny_retrieve
			end if
		end if
		
	else //computer fields
		//Dynamic create computer columns in order to Calculate its value
		/*1.deal with Expression**************/
		ls_export_field     = ids_export_flds.GetItemString(p,"export_field_name")
		of_replacespecchar(ls_export_field)
		ls_Expresstion      = Trim( ids_export_flds.GetItemString( p, "export_fields_expression" ) )//db_field_name
		ls_ComputerDataType = ids_export_flds.GetItemString(p,"ctx_column_datatype")
		if isnull(ls_export_field) then ls_export_field = ''
		if isnull(ls_Expresstion) then ls_Expresstion = ''
		if isnull(ls_ComputerDataType) then ls_ComputerDataType = ''
		if isnull(ls_field_format) then ls_field_format = ''
		if isnull(ls_fld_delim) then ls_fld_delim = ''
		ll_Cnt = ids_field.RowCount()
		
		//If the computer field is numeric,add the function number(  ) in to the Expresstion.
		//Replace symbol ' with "
		for ll_Num = 1 to ll_Cnt
			ls_Field         = ids_field.GetItemString(ll_Num,"export_field_name")
			ls_FieldDataType = ids_field.GetItemString(ll_Num,"ctx_column_datatype")
			if isnull(ls_Field) then ls_Field = ''
			if isnull(ls_FieldDataType) then ls_FieldDataType = ''
			//Reason:The Expresstion of a computer field cann't contain itself.
			if lower(ls_export_field) = lower(ls_Field) then continue
			
			//If the field used in then computer field and is number, 
			//add the function number(  ) in to the Expresstion 
			if PosA(lower(ls_Expresstion),lower(ls_Field)) > 0 then
				if upper(ls_FieldDataType) = 'N' then
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),0,number( " + ls_Field + " ))",true)
				elseif upper(ls_FieldDataType) = 'S' then
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),''," + ls_Field + " )",true)
				ELSEIF upper(ls_FieldDataType) = 'D' then
					ls_Expresstion  = of_globalreplace( ls_Expresstion, ls_Field, "if( isNull( "+ls_Field+" ),'1900-01-01'," + ls_Field + " )",true)
				end if
			end if
		next
		
		//replace symbol ' with "
		ls_Expresstion  = lnvo_string.of_globalreplace( ls_Expresstion, '~~', '~~~~')
		ls_Expresstion  = lnvo_string.of_globalreplace( ls_Expresstion, '"', '~~"')//'"'
		ls_tag = ls_field_format + '@^@' + ls_ComputerDataType + '@^@' + String(li_width) + '@^@'
		If ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" Then
			ls_tag += ls_fld_delim
		end if

		//2.Dynamic create computer columns,the name equal ls_Field + '_c'
		ls_modify = "create compute(band=detail alignment='0' expression=~""+ls_Expresstion+"~" border='0' color='33554432' x='1157'" + &
		            " y='4' height='64' width='242' format='[GENERAL]' html.valueishtml='0'  name=" + ls_export_field + "_c visible='0'" + &
						" font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0'" + &
						" background.mode='1' background.color='536870912' tag='" + ls_tag + "' )"
		ls_Err    = ids_export_dataTemp.Modify(ls_modify)
	End If
Next

//---------Begin Added by (Appeon)Stephen 11.17.2014 for Requesting new V14.1 web package & MSI installer for Allegheny--------
IF upperbound( is_billing_fields ) > 0 then
	choose case ai_type 
		case 1
			ls_sql = mid(as_sql, pos(lower(as_sql), 'from'))
			ls_sql = trim(ls_sql)
			if right(ls_sql, 1) = "," or right(ls_sql, 1) = ";" then ls_sql = mid(ls_sql, 1, len(ls_sql) - 1)
			ls_col_prac = mid(as_sql, 7, pos(lower(as_sql), "ctx_id") - 1)			
			ls_sql = '(select ' +ls_col_prac + ' ' + ls_sql +")"
			ls_sql = 'select prac_id from ctx_prac_link where ctx_id in' + ls_sql
			of_create_billing_data( ls_sql )
		case 2
			if right(ls_prac_ids, 1) = "," or right(ls_prac_ids, 1) = ";" then ls_prac_ids = mid(ls_prac_ids, 1, len(ls_prac_ids) - 1)
			ls_sql = 'select prac_id from ctx_prac_link where ctx_id in (' + ls_prac_ids + ")"
			of_create_billing_data( ls_sql )
		case 3
			ls_sql = 'select prac_id from ctx_prac_link where ctx_id ' + ls_prac_ids
			of_create_billing_data( ls_sql )
	end choose
end if
//---------End Added ------------------------------------------------------

w_export_progress.hpb_bar.position = 15
w_export_progress.st_export.text = "Retrieve Data"

ll_FieldCnt = ll_FieldSeqID
//if ls_UnionSQL <> "" then
//	if lb_true THEN//SQL2005 and ASA9
//		//ls_UnionSQL = ls_UnionSQL + "~r~n order by " + "ctx_id , FieldSeqID "//ls_OrderBy
//		ls_UnionSQL = ls_UnionSQL + "~r~n order by " + "FieldSeqID, ctx_id , Row_No"
//	end if
//
//	if lb_true then ls_RowNo = ", 0 Row_No"//SQL2005 AND ASA9
//	if lb_ASA7 then
//		//ls_SqlSelect = "Select prac_id,FieldSeqID,field_value,field_data_type from " + ls_tabletemp
//		ls_SqlSelect = "Select prac_id,FieldSeqID,billing_address_id,field_value,field_data_type from " + ls_tabletemp
//	else
//		//ls_SqlSelect = "Select top 1 0 prac_id, 1 FieldSeqID, cast('' as varchar(" + String(ll_maxwidth) + ")) field_value,  ' ' field_data_type" + ls_RowNo + " from pd_basic"
//		ls_SqlSelect = "Select top 1 0 prac_id, 1 FieldSeqID, 0 billing_address_id,  cast('' as varchar(" + String(ll_maxwidth) + ")) field_value,  ' ' field_data_type" + ls_RowNo + " from pd_basic"
//	end if			
//	
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_SqlSelect, ls_presentation_str, ERRORS)
//	IF LenA(ERRORS) > 0 THEN
//		gnv_debug.of_output(true, 'Alarm  Export:' +  "SyntaxFromSQL caused these errors: " + Errors + "~r~r" + ls_SqlSelect  ) //added by gaivns 20120912		
//
// 		inv_message.of_MessageBox("Caution on export field ","SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_SqlSelect,TRUE)	
//		close(w_export_progress)
//		if lb_ASA7 then
//			ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
//			EXECUTE IMMEDIATE :ls_Mysql;
//		end if
//		of_cleanup_ds( )
//		RETURN -1
//	END IF
//
//	w = ids_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
//	if w < 1 then
//		gnv_debug.of_output(true, 'Alarm  Export:' +  "lds_export_retrieve create  errors: " + Errors  + '~r' + ls_SqlSelect   ) //added by gaivns 20120912		
// 		inv_message.of_MessageBox("Error on Create",errors,TRUE)	
//		close(w_export_progress)
//		if lb_ASA7 then
//			ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
//			EXECUTE IMMEDIATE :ls_Mysql;
//		end if
//		of_cleanup_ds( )
//		return -1
//	end if
//
//	if Not lb_ASA7 then ids_export_retrieve.Modify('DataWindow.Table.Select="' + ls_UnionSQL + '"')
//	
//	ids_export_retrieve.SetTransObject( SQLCA )
//	ll_ret_cnt = ids_export_retrieve.retrieve()
//	
//	if ll_Ret_Cnt < 0 then		
//		gnv_debug.of_output(true, 'Alarm  Export:' +  "lds_export_retrieve retrieve<0 " + '~r' + ls_UnionSQL  ) //added by gaivns 20120912
//		//Reason:check syntax
//		ls_presentation_str = "style(type=grid)"
//		
//		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_UnionSQL, ls_presentation_str, ERRORS)
//		IF LenA(ERRORS) > 0 THEN
//			gnv_debug.of_output(true,"Caution on export:" + "SyntaxFromSQL caused these errors: " + Errors)			//Added By Mark Lee 02/01/2013			
//			 inv_message.of_MessageBox("Caution on export" , "SyntaxFromSQL caused these errors: " + ERRORS,true)	
//			close(w_export_progress)
//
//			if lb_ASA7 then
//				ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
//				EXECUTE IMMEDIATE :ls_Mysql;
//			end if
//
//			of_cleanup_ds( )
//			RETURN -1
//		END IF		
//	end if
//end if
if of_create_export_ds(ls_UnionSQL, ls_tabletemp, ls_RowNo, ll_maxwidth, "ctx_id") < 0 then return -1
ll_ret_cnt = ids_export_retrieve.rowcount( )

w_export_progress.hpb_bar.position = 20
li_bar_ticks = 70 / li_fld_cnt

//%%%%%%%%%%%%%%%%%%%%%%%%%%%% end of create syntax

ls_prac_field = ids_export_retrieve.describe("#1.name")

DO WHILE (ll_i <= ll_ret_cnt)
	ll_j = 0
	ls_data_value = ""
	ls_value = ""
	ls_lookup_val = ""
	ldt_value = datetime(date("0000-00-00"),time("00:00:00"))
	
	ll_pracid       = ids_export_retrieve.GetitemNumber(ll_i,ls_prac_field)
	ll_FieldSeqID   = ids_export_retrieve.GetitemNumber(ll_i,"FieldSeqID")
	li_recd_no      = ii_recdnoList[ll_FieldSeqID]
	ls_select_table = is_tablelist[ll_FieldSeqID]
	ls_select_field = is_selectfieldlist[ll_FieldSeqID]
	ls_datatype 	 = is_typelist[ll_FieldSeqID] //Alfee 11.13.200		
	li_billing 		 = ii_billingList[ll_FieldSeqID] //Alfee 11.13.200
	ls_export_field = is_fieldlist[ll_FieldSeqID]			
	ls_field_format = is_formatList[ll_FieldSeqID]		
	ll_export_code  = il_exportcodeList[ll_FieldSeqID]
	li_sub_start    = ii_substartList[ll_FieldSeqID]
	li_width        = ii_widthList[ll_FieldSeqID]
	ls_fld_delim    = is_flddelimList[ll_FieldSeqID]			
	ls_text         = is_textList[ll_FieldSeqID]
	ls_lu_field     = is_lu_fieldList[ll_FieldSeqID]
	li_facil_id     = ii_facil_idList[ll_FieldSeqID]
	li_act_format   = ii_act_formatList[ll_FieldSeqID]
	
	ud = ii_udList[ll_FieldSeqID]
	if ud = 1 then
		ls_def_val = is_defvalList[ll_FieldSeqID]
	elseif ud = 2 then //column default
		col = Long(is_defvalList[ll_FieldSeqID])
	else
		ls_def_val = ""
	end if
		
	if ll_FieldSeqIDold <> ll_FieldSeqID then
		ll_R = 0 
		ll_FieldSeqIDold = ll_FieldSeqID
		w_export_progress.st_export.text  = ls_select_table + "_" + ls_select_field    //string(ll_FieldSeqID) + "   " + 
		w_export_progress.st_export1.text = ls_select_field   
		
		if mod(ll_FieldSeqID,n) = 0 then w_export_progress.hpb_bar.position = w_export_progress.hpb_bar.position + 1
	end if
	
	FOR ll_R = ll_R + 1 to li_prac_id_cnt
		IF al_prac_ids[ll_R] = ll_pracid THEN EXIT
	NEXT
	
	//Find the max row of the current ll_pracid
	ls_find = "(" + ls_prac_field + " > " + String(ll_pracid) + " AND FieldSeqID = " + String(ll_FieldSeqID) + &
				 ") OR ( FieldSeqID  > " + String(ll_FieldSeqID) + ")"
	ll_j    = ids_export_retrieve.Find ( ls_find, ll_i + 1, ll_ret_cnt )
	if ll_j > 0 then ll_j = ll_j - 1 		//The max row of the current FieldSeqID

	//Perhaps it is the last ll_pracid and it is the max FieldSeqID, then set ll_j = ll_ret_cnt(max row in the ds)
	if ll_j = 0 then ll_j = ll_ret_cnt
	if ll_j - ll_i + 1 >= li_recd_no then 		//find out
		ll_prac_row = ll_i + li_recd_no - 1 
	else 		//Not 
		ll_prac_row = 0
	end if
	
	//process data
	if ll_prac_row > 0 then
		ls_datatype     = ids_export_retrieve.getitemString(ll_prac_row, "field_data_type" )	
	
		if li_billing = 1 then //maha app080205 to get billing address data 
			ll_billing_id   = ids_export_retrieve.getitemnumber(ll_prac_row, "billing_address_id" )
			//ls_data_value = of_get_billing(ll_billing_id,ls_datatype,ls_select_field,ls_field_format,is_billsynList[ll_FieldSeqID])
			ls_data_value = of_get_billing_new(ll_billing_id,ls_select_field,ls_datatype,ls_field_format) //Start Code Change ----08.29.2014 #V14.2 maha
		else
			ls_data_value = ids_export_retrieve.getitemString(ll_prac_row, "field_value")
		end if
	else
		//do nothing
	end if
	
	//save original values
	if lower(ids_export_dataTemp.describe(ls_export_field + ".name")) = lower(ls_export_field) then
		ids_export_dataTemp.SetItem(ll_R,ls_export_field,ls_data_value)
	end if
		
	if ls_format = "export" then
		if isnull(ls_data_value) then ls_data_value = ""
	end if

	//$<reason> Fix a defect.
	If ls_lu_field = 'contact_department' or ls_lu_field = 'contact_title' or ls_lu_field = 'contact_type' Then
		//modify 09/05/2007 by: Andy Reason:get description
		//ls_data_value = gnv_data.of_getitem('code_lookup', 'code', "lookup_code = " + ls_data_value)
		ls_data_value = gnv_data.of_getitem('code_lookup', 'description', "lookup_code = " + ls_data_value)
	End If

	//*****GET EXPORT CODES
	//if lds_export_flds.GetItemnumber( p, "export_code" )  = 1 then //get export code if required
	if ll_export_code  = 1 then //get export code if required
		ls_lookup_val = ls_data_value    //lds_export_data.getitemstring(i,p) //changed 100102
		if isnull(ls_lookup_val) then ls_lookup_val = ''
		//Convert data type - jervis 03.25.2011
		if isnumber(ls_lookup_val) then 
			ls_lookup_code = string(long(ls_lookup_val))
		else
			ls_lookup_code = ls_lookup_val
		end if		
		ll_find = ids_export_equiv_code.Find( "export_id = " + String(ai_export_id) + " and (string(lookup_code) = '" + ls_lookup_code + "' or code = '" + string(ls_lookup_val) + "')", 1, ll_rowcount2 ) //Add code -- jervis 03.25.2011
			
		If ll_find > 0 Then
			ls_value = ids_export_equiv_code.GetItemString(ll_find,'equiv_code')
		End If
		
		if not isnull(ls_value) and trim(ls_value) <> '' then ls_data_value = ls_value //if no export code use org value
		if isnull(ls_data_value) then ls_data_value = ""
	end if				
			
	ls_dc_field = is_dcfieldList[ll_FieldSeqID]	
	if ls_dc_field = 'none' or isnull(ls_dc_field) then 
		//skip
	else  //if set to a field name get the data
		If IsNumber(ls_data_value) Then
			
			ll_find = ids_dept_chair.Find("facility_id = " +  String(li_facil_id) + " and department_code = " + "'" + ls_data_value + "'",1,ll_rowcount)
			If ll_find > 0 Then
				ls_data_value = ids_dept_chair.GetItemString(ll_find,ls_dc_field)
			Else
				ls_data_value = ""
			End If
		End If
	end if
	//Active Status format for affil stat maha 083105
	ll_intcred_field = il_intcredfieldList[ll_FieldSeqID]
	if ll_intcred_field = 100000 then
		If li_act_format = 1 Then
			If ls_data_value = "1" Then
				ls_data_value = "Y"
			Else
				ls_data_value = "N"
			End If
		ElseIf li_act_format = 2 Then
			Choose Case ls_data_value
				Case "1"
					ls_data_value = "Active"
				Case "2"
					ls_data_value = "Purge"
				Case "3"
					ls_data_value = "Inactive"
				Case "4"
					ls_data_value = "Pending"
				Case "0"
					ls_data_value = "History"
				CASE "6"  //Start Code Change ----10.10.2014 #V14.2 maha
					ls_data_value = "Mid-cycle"
			End Choose
		End If
	end if
	
	if ls_strip_char <> "NONE" then
		ls_data_value = of_strip_char( ls_strip_char ,ls_data_value, "")
	end if
	
	//*** substring function***************************8
	//create datafield for substring_start
	if li_sub_start > 1 then ls_data_value = MidA(ls_data_value,li_sub_start,li_width)
	//***padding //note if avoid using return, double return, empty string or tab when padding
	ls_data_value = MidA(ls_data_value,1,li_width) //shrink the length to size 
	if ls_field_format = "Leading Padding" or ls_field_format = "Trailing Padding" then 
		if li_width - LenA(ls_data_value) > 0 then
			li_dif = li_width - LenA(ls_data_value)
			ls_pad = "" //reset
			ls_pad = FillA ( ls_fld_delim, li_dif )
			if ls_field_format = "Leading Padding" then
				ls_data_value = ls_pad + ls_data_value 
			else
				ls_data_value = ls_data_value + ls_pad
			end if
		end if
	elseif ls_field_format = "use text" then //allows a set value if data is found
		if LenA(ls_data_value) > 0 then
			ls_data_value = ls_text
		end if
	end if	

	//****set default moved here 091305
	if ud > 0 then
		if isnull(ls_data_value) then ls_data_value = ""
		
		if ls_data_value = "" then
			if ud = 1 then
				ls_data_value = ls_def_val
			elseif ud = 2 then //if set to column get the value out of that column
				if col < 1 or col > li_fld_cnt then //setting trap
					gnv_debug.of_output(true, 'Alarm  Export:' +  "You are using a column default for column " + ls_export_field + " , but your default value is not a valid column number.~rThe default column number must be less than this column." ) //added by gaivns 20120912					
 					inv_message.of_MessageBox("Invalid setting","You are using a column default for column " + ls_export_field + " , but your default value is not a valid column number.~rThe default column number must be less than this column.",true)	
					close(w_export_progress)
					if lb_ASA7 then
						ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
						EXECUTE IMMEDIATE :ls_Mysql;
					end if
					of_cleanup_ds( )
					return 0
				end if
				ls_data_value = ids_export_data.getitemstring(ll_R,col)
			end if
		end if
	end if
	
	of_data_format(ls_field_format,ls_datatype,ls_data_value) //(Appeon)Stephen 09.14.2015 - Bug_id#4716  EXPORT String formula
		
	//*********value set**********	
	if li_fld_cnt = 1 then ls_data_value = ls_data_value + CharA(9)	
	if lower(ids_export_data.describe(ls_export_field + ".name")) = lower(ls_export_field) then
		//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//Begin - Added By Mark Lee 09/29/12 its cannot use double quote to merge data values in  the MS word.
		If Pos(ls_data_value,'"') > 0 Then 
			gnv_debug.of_output(true, 'Alarm  Export: Its used the double quote Replace the blank data in merged data value on the column ['+ls_export_field+'], and this current data value is the ['+ls_data_value+'].' )
			ls_data_value  = lnvo_string.of_globalreplace( ls_data_value, '"', ' ')
		End If
		//End - Added By Mark Lee 09/29/12
		//---------End Added ------------------------------------------------------
		ids_export_data.setitem(ll_R,ls_export_field,ls_data_value)
	end if
	
	//processing the next field(fieldseqid)
	ll_i = ll_j + 1	
LOOP 

//process default value
if of_export_processdefault(ids_export_hdr,ids_export_flds,ids_export_datatemp,ids_export_data) = -1 then 
	gnv_debug.of_output(true, 'Alarm  Export: of_export_processdefault=-1 ' )//added by gavins 20120912	

	close(w_export_progress)
	if lb_ASA7 then
		ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
		EXECUTE IMMEDIATE :ls_Mysql;
	end if
	of_cleanup_ds( )
	return 0	
end if

//---------Begin Added by (Appeon)Stephen 07.11.2016 for Export computed field issue--------
ids_export_dataTemp.reset()
ids_export_data.RowsCopy( 1, ids_export_data.RowCount(), Primary!, ids_export_dataTemp, 1, Primary! )
//---------End Added ------------------------------------------------------

//Set Calculated field value and format into lds_export_data with the relative computer column in lds_export_dataTemp
of_export_calculatedfield(ids_export_dataTemp,ids_export_data,ls_format)
w_export_progress.hpb_bar.position = 94

//1:save / 3:save & preview
if ai_save_data = 1 or ai_save_data = 3 then
	w_export_progress.st_progress.Text = "Saving File"
	sd = ids_export_data.Update()
	Commit Using SQLCA;
	
	If sd < 1 Then 		
		gnv_debug.of_output(true, 'Alarm  Export: lds_export_data update failed ' )//added by gavins 20120912		
 		inv_message.of_MessageBox("Save error","Unable to save data to table",true)	
	End If
End If


//---------Begin Added by (Appeon)Toney 06.24.2013 for V141 ISG-CLX--------
//ids_export_data = lds_export_data
If ids_export_data.Rowcount( ) = 0 Then
	gnv_debug.of_output(true, 'Alarm  Export: lds_export_data rowcount()=0 '  )//added by gavins 20120912
Else
	ib_writefile = true //added by gavins 20121011
End If
//---------End Added ------------------------------------------------------------------


w_export_progress.st_progress.Text = "Creating File"
w_export_progress.hpb_bar.position = 100
li_bar_ticks = 75 / li_prac_id_cnt
n = int(li_fld_cnt/80) + 1
//******************************* CREATE FILE

ls_save_path = as_path
if RightA(ls_save_path,1) = ':' then ls_save_path = ls_save_path + "\"
ll_lastpos = LastPos(ls_save_path,'.') 
if ll_lastpos > 0 then 	ls_save_path = LeftA(ls_save_path,ll_lastpos - 1)

//If the directory is not exists Then create it 
If MidA(ls_save_path,LenA(ls_save_path),1) = "\" Then
	ls_path1 = ls_save_path
Else
	ls_path1 = MidA(ls_save_path,1,lastpos(ls_save_path,'\'))
End If

//Add By Jervis 11-19-2008
if ls_path1 = "" then
	IF AppeonGetClientType() = 'WEB' THEN
		ls_path1 = gs_temp_path + "ExportData\"
		ls_save_path = ls_path1 + ls_save_path
	else
		ls_path1 = Gs_Current_Directory + "\ExportData\"
		ls_save_path = ls_path1 + ls_save_path
	end if
Else
	//Added By Ken.Guo 2011-01-11.
	If invo_rights.of_check_dir_right(ls_path1, True,'Export') <> 1 Then
		gnv_debug.of_output(true, 'Alarm  Export: check dir right failed '  + ls_path1 )//added by gavins 20120912
		of_cleanup_ds()
		Return 0
	End If
end if
//End By Jervis 
gnv_appeondll.of_parsepath(ls_path1)

If MidA(ls_save_path,LenA(ls_save_path),1) <> "\" Then //maha app 102405 if a file name is indicated do not tack on the table name
	ls_path = ls_save_path +  ls_format
Else
	if li_custom_save > 0 then  //maha new 121205 for custom naming of file
		ls_save_name = of_custom_name(li_custom_save,ls_table_name,ldt_date)
	else
		ls_save_name = ls_table_name
	end if
	ls_path = ls_save_path + ls_save_name + ls_format
End If

as_path = ls_path


//---------Begin Added by (Appeon)Harry 03.26.2014--------
if LenA(ls_post_sort) > 0 then
	ids_export_data.setsort(ls_post_sort)
	ids_export_data.sort()
end if
//---------End Added ------------------------------------------------------

if lb_export = false then
	gnv_rights.of_check_dir_right( ls_path, true, 'Export') //(Appeon)Toney 06.25.2013 for V141 ISG-CLX 
    //------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 03.26.2013
	//$<reason>  V12.3	Add ‘Drop Column Before Saving File’
	/*  Choose Case ls_format
		Case ".txt"
			If ls_header = "1" Then
				g = lds_export_data.SaveAs(ls_path,Text!,True)
			Else
				g = lds_export_data.SaveAs(ls_path,Text!,False)
			End If
		Case ".xls"
			If ls_header = "1" Then
				g = lds_export_data.SaveAs(ls_path,excel!,True)
			Else
				g = lds_export_data.SaveAs(ls_path,excel!,False)
			End If
		case ".csv"
			if ls_header = "1" then 
				g = lds_export_data.saveas(ls_path,csv!,true)
			else
				g = lds_export_data.saveas(ls_path,csv!,false)
			end if
	End Choose	*/
	if ls_header = "1" then
		g = of_copy_expdata(ids_export_data, ls_format, true, ls_path, true)
		if g <> 1 then return 0 
	else
		g = of_copy_expdata(ids_export_data, ls_format, false, ls_path, true)
		if g <> 1 then return 0 
	end if
	//------------------- APPEON END -------------------
 	If g = -1 Then inv_message.of_MessageBox("saveas -1","Unable to save file.  Check path (" + ls_path + ") and make sure a copy of the file is not open.",true)
Else
	//build export text file
	li_file_num = FileOpen(ls_path, lineMode!, Write!, LockWrite!, Replace!)//maha changed to line mode 091002

	w_export_progress.hpb_bar.position = 10
	if of_copy_expdata(ids_export_data, '', false, '', false) <> 1 then return 0 //add by Stephen 03.26.2013 -V12.3	Add ‘Drop Column Before Saving File’
	
	For i = 1 To li_prac_id_cnt
		if mod(i,n) = 0 then
			w_export_progress.hpb_bar.position = w_export_progress.hpb_bar.position + 1
		end if
		For p = 1 To li_fld_cnt
			ls_data_value = ids_export_data.GetItemString(i,p)
			ls_fld_delim = ids_export_flds.GetItemString( p, "trailing_leading_characters")
			ls_field_format = ids_export_flds.GetItemString(p,"export_format")
			//------------------- APPEON BEGIN -------------------
			//$<add> stephen  03.26.2013
			//$<reason> V12.3	Add ‘Drop Column Before Saving File’
			li_drop_col = ids_export_flds.GetItemNumber(p,"drop_column")
			if isnull(li_drop_col) then li_drop_col = 0
			if  li_drop_col = 1 then continue 
			//------------------- APPEON END -------------------
			
			Choose Case ls_fld_delim
				Case "E" //empty String
					ls_delim_value = ""
				Case "S" // space
					ls_delim_value = " "
				Case "T" //tab
					ls_delim_value = "	"
				Case "R" //return
					ls_delim_value = "~r"
				Case "D" //return
					ls_delim_value = "~r~r"
				Case Else
					ls_delim_value = ls_fld_delim
			End Choose
			If IsNull(ls_delim_value) Then ls_delim_value = ""
			If ls_field_format = "Leading Padding" Or ls_field_format = "Trailing Padding" Then //don't add delimit value
				ls_export_text_file = ls_export_text_file + ls_data_value
			Else
				ls_export_text_file = ls_export_text_file + ls_data_value + ls_delim_value
			End If
			
		Next
		ls_export_text_file = ls_export_text_file + ls_rec_delim
		p = 1
		FileWrite ( li_file_num, ls_export_text_file)
		ls_export_text_file = ""
	Next
	FileClose(li_file_num)
End If

//---------Begin Commented by (Appeon)Harry  07.23.2014 for BugH072301--------
/*
//---------Begin Modified by (Appeon)long.zhang 05.24.2014 (v14.2 Provider-Contract direct linking)
//ids_export_data = ids_export_data //Fix a defect.
ls_dwsyntax_str = ids_export_data.Describe("datawindow.syntax")
ids_ctx_export_data.Create(ls_dwsyntax_str)
ids_export_data.RowsCopy(1, ids_export_data.RowCount(), Primary!, ids_ctx_export_data, 1, Primary!)
//---------End Modfiied ------------------------------------------------------
*/
//---------End Commented ------------------------------------------------------

if is_called_type <> "2" and isvalid(w_export_progress) then
	w_export_progress.hpb_bar.position = 100
	Close(w_export_progress)
end if

//2:preview / 3:save & rpeview
if ai_save_data = 2 or ai_save_data = 3 then
	//------------------- APPEON BEGIN -------------------
	//$<modify> stephen 03.26.2013
	//$<reason> V12.3	Add ‘Drop Column Before Saving File’
    /* 	lstr_pass.s_string = is_select_syntax
	lstr_pass.s_dw = lds_export_data  */
	lstr_pass.s_string = is_select_syntax_drop
	lstr_pass.s_dw = ids_export_data_drop
	//------------------- APPEON END -------------------
	lstr_pass.s_string_array[1] = ls_UnionSQL //(Appeon)Toney 06.25.2013 for V141 ISG-CLX
	openwithparm( w_export_previewdata, lstr_pass )
end if

if lb_ASA7 then
	ls_Mysql = "DROP TABLE " + ls_tabletemp + ";"
	EXECUTE IMMEDIATE :ls_Mysql;
end if

if lb_mulsel then
	ls_Mysql = "DELETE FROM export_temp WHERE SpID = " + String(ll_spid) + ";"
	EXECUTE IMMEDIATE :ls_Mysql;
end if

//---------Begin Modified by (Appeon)Harry 07.23.2014 for BugH072301--------
//of_cleanup_ds( )
of_cleanup_ds (False)
//---------End Modfiied ------------------------------------------------------

Return 1
end function

public function integer of_create_billing_data (string as_pracs);//Start Code Change ----08.29.2014 #V14.2 maha - added to get data one time for all
integer p
long rc
string ls_prac_sql
String ls_sql_syntax
String ls_presentation_str
String Errors
String ls_dwsyntax_str

//ls_sql_syntax = is_billing_sql
//---------Begin Modified by (Appeon)Stephen 11.17.2014 for Requesting new V14.1 web package & MSI installer for Allegheny--------
//ls_prac_sql = midA(as_pracs, 1, len(as_pracs) -1)  //strip final ;
if right(as_pracs,1) = "," or right(as_pracs,1)=";" then as_pracs = midA(as_pracs, 1, len(as_pracs) -1)
ls_prac_sql = as_pracs
//---------End Modfiied ------------------------------------------------------

ls_sql_syntax = "Select Distinct pd_address.rec_id, pd_address.prac_id"

for p = 1 to upperbound(is_billing_fields)
	ls_sql_syntax+= ", pd_address."	+ is_billing_fields[p]
next

ls_sql_syntax+= " FROM pd_address, pd_address_link "
ls_sql_syntax+= " WHERE pd_address.rec_id = pd_address_link.address_id "
ls_sql_syntax+= " AND pd_address_link.billing = 1 "
ls_sql_syntax+= " AND pd_address.prac_id in ( " +  ls_prac_sql + " ) "
ls_sql_syntax+= ";"
//messagebox("",ls_sql_syntax)

ls_presentation_str = "style(type=form)"

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, ls_presentation_str, Errors)
IF LenA(Errors) > 0 THEN //this will fail if the table creation has not been completed
	IF PosA(Errors,"Table or view not found",1) > 0 THEN
	   inv_message.of_MessageBox ("Error in of_export_data_with_text","Billing data data store not able to be created.~rCheck the following:~rMake sure export field names have no spaces and contain only letters, numbers and underscores, and that all fields have a width.~rYou cannot have duplicate field names~rField names cannot start with a number.",true )
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1 		
	ELSE
	   inv_message.of_MessageBox("Caution","SyntaxFromSQL caused these errors: " + Errors,true)
		Close(w_export_progress)
		of_cleanup_ds( )
		RETURN -1
	END IF
END IF

ids_billing = create n_ds
ids_billing.Create( ls_dwsyntax_str, Errors)
ids_billing.SetTransObject( SQLCA )
rc = ids_billing.retrieve()


return 1
end function

public function string of_get_billing_new (long al_rec, string as_field, string as_type, string as_field_format);//Start Code Change ----08.29.2014 #V14.2 maha - added

string ls_val
string ls_filter
string ls_field
datetime ldt_value
long f

if al_rec < 1 or isnull(al_rec) then return ''

ls_filter = "pd_address_rec_id = " + string(al_rec)

//---------Begin Modified by (Appeon)Stephen 09.03.2014 for Bug 4157 - Export multirows and billing addresses--------
//if as_field = "code_lookup_code" then
if upper(MidA(as_field,1,11)) = "CODE_LOOKUP" OR upper(MidA(as_field,1,14)) = "ADDRESS_LOOKUP" then	
	 return ""
//---------End Modfiied ------------------------------------------------------
else
	ls_field = "pd_address_" + as_field
end if
	
f = ids_billing.find(ls_filter,1, ids_billing.rowcount())
//messagebox("get billing new",ids_billing.rowcount())
if f < 0 then
	messagebox("of get billing new ERROR","Filter failed. (" + ls_filter + ")")
elseif f = 0 then
	//messagebox("of_get_billing_new  No did find.", al_rec)
	ls_val = ""
else
	choose case upper(MidA(as_type,1,1))
		case "N","I"  //number
			ls_val = string(ids_billing.getitemnumber(f, ls_field ))
			of_data_format(as_field_format, as_type, ls_val) //(Appeon)Stephen 10.28.2014 - Export miltirow data formatting
		case "C","V","L"	//character
			//messagebox( string(f),ls_field)
			ls_val = ids_billing.getitemString( f, ls_field )
			of_data_format(as_field_format, as_type, ls_val) //(Appeon)Stephen 10.28.2014 - Export miltirow data formatting
		case "T", "D"	//datetime
			ldt_value = ids_billing.getitemdatetime(f, ls_field )
			//format the date
			ls_val = of_date_format(as_field_format,ldt_value) //maha 070705
			//messagebox("date value",ls_val)
		case else
			inv_message.of_MessageBox("Datatype Not Anticipated",as_type,true)	
			ls_val = ""
	end choose
end if

//debugbreak()

return ls_val

end function

public function integer of_multi_query_filter (string as_bill_link, string as_table, integer ai_use_link, string as_sql, string as_query_filter, string as_field_name, string as_value, long al_rec_id, integer ai_table_id, integer ai_facility_id, integer ai_faci_filter);//====================================================================
//$<Function>: of_multi_query_filter
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 11.27.2014 (Allegheny - Help with an export)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_pos, li_cnt
string   ls_link_table
string   ls_use_link_sql2
string   ls_select_sql
string   ls_where, ls_rec_sql

if isnull(as_value) or as_value = "" then return 0
IF ai_use_link = 1 THEN
	CHOOSE CASE as_table
		CASE "pd_address"
			ls_use_link_sql2 = " (pd_address.rec_id = pd_address_link.address_id) and "
			ls_link_table = "pd_address_link"
			if pos(as_sql, "pd_address_link") > 0 then ls_link_table = ""
		CASE "pd_hosp_affil"
			ls_use_link_sql2 = " (pd_hosp_Affil.rec_id = pd_hosp_facility_link.hosp_affil_id) and "
			ls_link_table = "pd_hosp_facility_link"
			if pos(as_sql, "pd_hosp_facility_link") > 0 then ls_link_table = ""
		CASE "pd_board_specialty"
			ls_use_link_sql2 = " (pd_board_specialty.rec_id = pd_spec_facility_link.specialty_id) and "
			ls_link_table = "pd_spec_facility_link"
			if pos(as_sql, "pd_spec_facility_link") > 0 then ls_link_table = ""
		CASE ELSE
			ls_use_link_sql2 = ""
			ls_link_table = ""
	END CHOOSE
END IF

li_pos = pos(lower(as_sql), ' from ')
if ai_use_link = 1 and not(isnull(ls_link_table) or ls_link_table = "") then
	ls_select_sql = "select " + as_table + "." + as_field_name + "  from " + ls_link_table + ", " + mid(as_sql, li_pos + 6)
else
	ls_select_sql = "select  " +as_table + "." + as_field_name + " "+  mid(as_sql, li_pos)
end if

choose case ai_table_id
	case 53
		ls_rec_sql = " and " +  as_table +".address_id = " +string(al_rec_id) +" and " +as_table + ".facility_id = " + string(ai_facility_id)
	case 61
		ls_rec_sql = " and " +  as_table +".hosp_affil_id = " +string(al_rec_id) +" and " +as_table + ".facility_id = " + string(ai_facility_id) 
	case 62
		ls_rec_sql = " and " +  as_table +".specialty_id = " +string(al_rec_id) +" and " +as_table + ".facility_id = " + string(ai_facility_id) 
	case else
		ls_rec_sql = " and " +  as_table +".rec_id = " +string(al_rec_id)
end choose

if isnull(as_query_filter) or as_query_filter = "" then as_query_filter = " (1=1) "
li_pos = pos(lower(ls_select_sql), ' where ')
if li_pos > 0 then
	ls_select_sql = left(ls_select_sql, li_pos + 6) + ls_use_link_sql2 + as_query_filter + ls_rec_sql + " and " + mid(ls_select_sql, li_pos + 6)
else
	ls_select_sql = ls_select_sql + " where " + ls_use_link_sql2 + as_query_filter + ls_rec_sql
end if

//---------Begin Added by (Appeon)Stephen 12.01.2014 for add facility filter for multi-record format --------
IF ai_faci_filter > 0 THEN
	li_pos = pos(lower(ls_select_sql), ' where ')
	CHOOSE CASE as_table
		CASE "pd_address"
			IF ai_use_link = 1 THEN 
				ls_select_sql     = left(ls_select_sql, li_pos + 6) + " (pd_address_link.facility_id = " + String(ai_faci_filter) + ") and " + mid(ls_select_sql, li_pos + 6)
			END IF
		CASE "pd_hosp_affil"
			IF ai_use_link = 1 THEN 
				ls_select_sql     = left(ls_select_sql, li_pos + 6) + " (pd_hosp_facility_link.facility_id = " + String(ai_faci_filter) + ") and " + mid(ls_select_sql, li_pos + 6)
			END IF
		CASE "pd_board_specialty"
			IF ai_use_link = 1 THEN 
				ls_select_sql     = left(ls_select_sql, li_pos + 6) + " (pd_spec_facility_link.facility_id = " + String(ai_faci_filter) + ") and " + mid(ls_select_sql, li_pos + 6)
			END IF
		CASE "pd_affil_stat"
			ls_select_sql     = left(ls_select_sql, li_pos + 6) + " (pd_affil_stat.parent_facility_id = " + String(ai_faci_filter) + ") and " + mid(ls_select_sql, li_pos + 6)
		CASE ELSE
			ls_select_sql     = left(ls_select_sql, li_pos + 6) +  + " (" + as_table + ".facility_id = " + String(ai_faci_filter) + ") and " + mid(ls_select_sql, li_pos + 6)	 		
	END CHOOSE
END IF	
//---------End Added ------------------------------------------------------


EXECUTE Immediate :ls_select_sql Using Sqlca; 
if sqlca.sqlnrows < 1 or sqlca.sqlcode <> 0 then return 0
return 1
end function

public function integer of_multi_row_new (n_ds ads_export, string as_table, integer ai_table, integer ai_col_num[], n_ds ads_exp_fields, long al_prac_ids[], string as_where, string as_prac_sql);//$<Function>: of_multi_row_new
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 12.26.2014 (Bug # 4365 - Export hangs up or Errors out when it is working on a large number of records)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

w_export_progress.st_progress.text = "Adding multiple records for " + String(Upperbound(al_prac_ids[])) + " Practitioners" //Modified by Appeon long.zhang 11.07.2016
w_export_progress.r_bar.Width = 300
w_export_progress.st_export1.Text = ''//Added by Appeon long.zhang 11.07.2016

long r
long rc
long org_cnt
long d
long dc
long ll_prac
long p
long pc
long ll_find
long alu
long clu
long row_cnt
integer a
integer ac
integer w
integer li_bar_ticks
integer li_sub_start
integer li_len
integer p1 //Start Code Change ---- 10.01.2007 #V7 maha
integer res
long ll_row_loc[]
long ll_dummy[]
datetime ldt_data
//string ls_datatype
string ls_syntax
string ls_fields
string ls_table
string ls_value
string ls_lu_type
string ls_lu_field
string ls_datatype[]
string ls_sny_retrieve
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_type[]
string ls_where  //Start Code Change ---- 10.01.2007 #V7 maha
string ls_fname  //Start Code Change ---- 10.01.2007 #V7 maha
string ls_table_org  //maha 09.02.2014
string ls_field_value // 11.03.2014
datastore lds_addr_lu //n_ds->datastore - alfee 04.15.2010
datastore lds_code_lu //n_ds->datastore - alfee 04.15.2010
n_ds lds_getdata
n_ds lds_priv_clinical_area//Added by  Nova 10.30.2009
n_ds lds_priv_core			//Added by  Nova 10.30.2009
n_ds lds_priv_core_procd	//Added by  Nova 10.30.2009
string ls_db_field_name    //Added by  Nova 10.30.2009
string ls_db_table_name    //Added by  Nova 10.30.2009
long dlu							//Added by  Nova 10.30.2009
long slu							//Added by  Nova 10.30.2009
long plu							//Added by  Nova 10.30.2009
n_import_ds   lds_field_type  //add by stephen 01.13.2012
string             ls_field_type
string             ls_filter
string             ls_colname
string             ls_field_where
string             ls_field_where_sql
string             ls_table_link
boolean  lb_address_link      //add by stephen 03.25.2013
//---------Begin Added by (Appeon)Stephen 08.26.2014 for Bug 4157 - Export multirows and billing addresses--------
integer   li_colold, li_billing, li_find
integer   li_use_link, li_ret, li_facility_id, li_faci_filter
long       ll_table_id_arr[] = {2,9,16,20,29,32,43,44,45,46,47,48,49,50,51,52,53,61,62,65,70,71}  
long       ll_billing_id, ll_rec_id
string     ls_field_format, ls_select_field, ls_dbtype
string     ls_def_val
string     ls_query_filter
string     ls_filter_null
boolean  lb_bill, lb_link
boolean  lb_faci, lb_faci_filter
boolean  lb_null
//---------End Added ------------------------------------------------------

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.08.2016
//<$>Increase speed, Case 67116 - Export Erring after an hour, SaaS v15.1 10132016
Long i, ll_start, ll_end,ll_data_cnt
Long ll_row_loc_num
String ls_prac_id_col
boolean lb_find
String ls_def_val_array[]
String ls_lu_field_array[]
String ls_lu_type_array[]
String ls_db_field_name_array[]
String ls_db_table_name_array[]
String ls_field_format_array[]
String ls_field_value_array[]
String ls_dbtype_array[]
String ls_field_type_array[]
Int li_billing_array[]
Int li_len_array[]
Int li_sub_start_array[]
//------------------- APPEON END -------------------

org_cnt = ads_export.rowcount()
if org_cnt = 0 then //redundant trap
	inv_message.of_messagebox("No Data","Ending of_multi_row", TRUE) //scheduler - alfee 03.05.2010
	return -1
end if
li_bar_ticks = 1000 / org_cnt

//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
gnv_data.of_retrieveIfNecessary("address_lookup", FALSE)
gnv_data.of_retrieveIfNecessary("code_lookup", FALSE)
//------------------------------------------------------------------------------------------------------

//--Begin Modified by alfee 04.15.2010 ---
lds_addr_lu = gnv_data.ids_address_lookup
lds_code_lu = gnv_data.ids_code_lookup

//--------Begin Added by Nova 10.30.2009------------------------
lds_priv_clinical_area = create n_ds
lds_priv_core = create n_ds
lds_priv_core_procd = create n_ds

lds_priv_clinical_area.dataobject = "d_dddw_priv_clinical_area"
lds_priv_core.dataobject="d_dddw_priv_core"
lds_priv_core_procd.dataobject="d_dddw_priv_core_procd"

lds_priv_clinical_area.settransobject(sqlca)
lds_priv_core.settransobject(sqlca)
lds_priv_core_procd.settransobject(sqlca)
//--------End Added --------------------------------------------

res = ads_exp_fields.setfilter("intcred_table = " + string(ai_table) )
if res < 0 then inv_message.of_messagebox("","filter failed", TRUE) //scheduler - alfee 03.05.2010
ads_exp_fields.filter()
ac = ads_exp_fields.rowcount()

if ac = 0 then return 0	//Fix a bug By Jervis 07.05.2007

ls_table = ads_exp_fields.getitemstring(1,"db_table_name_intellicred")
ls_table_org = ls_table  //Start Code Change ----09.02.2014 #V14.2 maha
ls_table_link = ls_table

if ac <> upperbound(ai_col_num[]) then
	inv_message.of_messagebox("Error","Count mismatch.", TRUE) //scheduler - alfee 03.05.2010	
	return 0
end if

//---------Begin Added by (Appeon)Stephen 12.01.2014 for add facility filter for multi-record format--------
lb_faci = false
for a = 1 to upperbound(ll_table_id_arr)
	if ai_table = ll_table_id_arr[a] then
		lb_faci = true
		exit
	end if
next
//---------End Added ------------------------------------------------------

ls_where = as_where
if isnull(ls_where) or ls_where = '' then ls_where = " WHERE 1=1 "
p1 = PosA(upper(ls_where) , " AND " ,1)
if p1  < 4 and p1 > 0 then 
	ls_where = MidA(as_where, p1 + 4)
end if
p1 = PosA(upper(ls_where) , " WHERE " ,1)
if p1  < 1  then
	ls_where = " Where " + ls_where
end if

lb_link = true
choose case ai_table
	case 53
		ls_table = "pd_address, "+ ls_table
		ls_where = ls_where +" and pd_address.rec_id = pd_address_link.address_id "
	case 20
		ls_table = "pd_address_link, " + ls_table
		ls_where = ls_where +" and pd_address.rec_id = pd_address_link.address_id "
		ls_table_link = "pd_address_link"
	case 61
		ls_table = "pd_hosp_affil, " + ls_table
		ls_where = ls_where +" and pd_hosp_Affil.rec_id = pd_hosp_facility_link.hosp_affil_id "
	case 9
		ls_table = "pd_hosp_facility_link, " + ls_table
		ls_where = ls_where +" and pd_hosp_Affil.rec_id = pd_hosp_facility_link.hosp_affil_id "
		ls_table_link = "pd_hosp_facility_link"
	case 62
		ls_table = "pd_board_specialty, " + ls_table
		ls_where = ls_where +" and pd_board_specialty.rec_id = pd_spec_facility_link.specialty_id "
	case 2
		ls_table = "pd_spec_facility_link, " + ls_table
		ls_where = ls_where +" and pd_board_specialty.rec_id = pd_spec_facility_link.specialty_id "
		ls_table_link = "pd_spec_facility_link"
	case else
		lb_link = false
end choose

ls_fields = ""
for a = 1 to upperbound(ai_col_num[])
	ls_db_field_name=ads_exp_fields.getitemstring(a,"db_field_name_intellicred")
	ls_fname = ads_exp_fields.getitemstring(a,"export_field_name")
	ls_query_filter = ads_exp_fields.getitemstring(a,"filter_query")
	if lb_faci = true then li_faci_filter = ads_exp_fields.getitemnumber(a,"facility_id") 	

 //Start Code Change ----07.09.2015 #V15 maha - removed commented code as the column level filters do not apply in multi-row
//	ls_field_where_sql = ""
//	if  not(isnull(ls_query_filter) or ls_query_filter = "") then
//		ls_field_where_sql = ls_query_filter
//	end if
//	if lb_faci = true and li_faci_filter > 0 then
//		if not(isnull(ls_field_where_sql) or ls_field_where_sql = "") then
//			ls_field_where_sql = ls_field_where_sql + " and " +ls_table_link+".facility_id = " + string(li_faci_filter)
//		else
//			//---------Begin Modified by (Appeon)Stephen 01.08.2015 for Critical Allegeheny issue - Invalid column error on EPSI export--------
//			//ls_field_where_sql = ls_table_link+".facility_id = " + string(li_faci_filter)
//			if ai_table = 43 then
//				ls_field_where_sql = ls_table_link+".parent_facility_id = " + string(li_faci_filter)
//			else				
//				ls_field_where_sql = ls_table_link+".facility_id = " + string(li_faci_filter)
//			end if
//			//---------End Modfiied ------------------------------------------------------			
//		end if
//	end if
//	if not(isnull(ls_field_where_sql) or ls_field_where_sql = "") then
//		ls_fields = ls_fields + ls_fname +"= case when ("+ls_field_where_sql +") then " + ls_table_org+"." + ls_db_field_name +" else null end,"
//	else
		ls_fields = ls_fields + ls_fname +"="+ ls_table_org+"." + ls_db_field_name +"," 
//	end if
 //End Code Change ----07.09.2015 
	
next

ls_where = ls_where + " and " + ls_table_org + ".prac_id in (" + as_prac_sql +")"

ls_fields = ls_fields + ls_table_org + ".prac_id "
if ai_table = 20  then  
	ls_fields = ls_fields + "," + ls_table_org + ".billing_address_id "  	
end if

lds_getdata = CREATE n_ds
lds_field_type = CREATE n_import_ds
ls_syntax = "SELECT distinct " + ls_fields + " FROM " + ls_table + ls_where 

If ib_nyp_fte = true then //added for NYP FTE report
	ls_syntax +=  " ORDER BY end_date ASC"
end if

ls_syntax += ";"
ls_presentation_str = "style(type=grid)"		

//messagebox("ls_syntax in of_multi_row_new",ls_syntax)

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_syntax, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN
	inv_message.of_messagebox("Caution on export field ", "SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_syntax, TRUE) //scheduler - alfee 03.05.2010	
	close(w_export_progress)
	RETURN -1
END IF

w = lds_getdata.Create( ls_dwsyntax_str, ERRORS)
if w < 1 then
	inv_message.of_messagebox("Error creating table for multi row function",errors, TRUE)//scheduler - alfee 03.05.2010
	return 0
end if
lds_getdata.SetTransObject( SQLCA )
lds_getdata.retrieve()

If ib_nyp_fte = true then //added for NYP FTE report  - record filter and modification
	of_nyp_fte_rows(lds_getdata)
end if
ls_colname = ""
for a= 1 to integer(lds_getdata.Object.DataWindow.Column.Count)
	if lds_getdata.describe("#"+string(a)+".name") = ls_table_org + "_prac_id" then
		ls_colname = ls_table_org+"_"
		exit
	end if
next

ac = upperbound(ai_col_num[])
ls_fields = ""
for a = 1 to ac
	ls_fields = ls_fields + ls_table_org + "." + ads_exp_fields.getitemstring(a,"db_field_name_intellicred") + ","   //add by stephen 03.25.2013 --add table_name
	ls_type[a] = ads_exp_fields.getitemstring(a,"db_field_type")
next
ls_fields = mid(ls_fields, 1, len(ls_fields) - 1) 
ls_syntax = "select " + ls_fields + " from " + ls_table_org
ls_syntax += ";"
ls_presentation_str = "style(type=grid)"		

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_syntax, ls_presentation_str, ERRORS)
lds_field_type.create( ls_dwsyntax_str, ERRORS)
lds_field_type.settransobject(sqlca)   

//////////////////////////////////////////////////////////////////////////////////
if lb_link = true then
	for d= lds_getdata.rowcount() to 1 step -1
		lb_null = false
		ls_filter_null = ""
		for a= 1 to ac
			ls_field_type = ls_type[a]	
			ls_fname = ads_exp_fields.getitemstring(a,"export_field_name")
			ls_value = ""
			choose case ls_field_type 
				case "C","L"   				
					ls_value = lds_getdata.getitemstring(d, a)
				case "I","N"
					ls_value = string(lds_getdata.getitemnumber(d,a))						
				case "D","T" 
					ls_value = string(lds_getdata.getitemdatetime(d,a))
			end choose
			if isnull(ls_value) or ls_value = '' then
				lb_null = true
			else
				if not(ls_value = 'I' or ls_value = 'N') then ls_value = "'" + ls_value + "'"
				ls_filter_null = ls_filter_null + ls_fname + " = " + ls_value + " and "
			end if
		next
		ls_value = string(lds_getdata.getitemnumber(d,ac+1))	
		ls_filter_null = ls_filter_null + ls_colname + "prac_id = " + ls_value
		if lb_null then
			if ls_filter_null = "" then 
				lds_getdata.deleterow(d)
				continue
			end if
			li_find = lds_getdata.find(ls_filter_null, 1, d -1)
			if li_find = 0 and d < lds_getdata.rowcount() then
				li_find = lds_getdata.find(ls_filter_null, d+1, lds_getdata.rowcount())
			end if
			if li_find > 0 then
				lds_getdata.deleterow(d)
			end if
		end if
	next
end if
////////////////////////////////////////////////////////////////////

pc = upperbound(al_prac_ids[])

row_cnt = 1
lds_field_type = create n_import_ds  //add by stephen 01.13.2012 DataWindow column type does not match GetItem type 

lb_bill = false

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.04.2016
//<$>reason:Optimize to increse speed (Try not to use filter, describe and so on), Added by Appeon long.zhang 11.04.2016 (Case 67116 - Export Erring after an hour, SaaS v15.1 10132016)	
ls_prac_id_col = ls_colname + "prac_id"
lds_getdata.SetSort( ls_prac_id_col+" Asc")
lds_getdata.Sort()
ll_end = 0
ll_data_cnt = lds_getdata.RowCount()

//Prepare array to increase speed for Web Version 
For a = 1 to upperbound(ai_col_num[])	
	ls_def_val_array[a]  = ads_exp_fields.getitemstring(a,"default_value")	
	
	ls_lu_field_array[a] = ads_exp_fields.getitemstring(a,"lu_field_name")
	ls_lu_type_array[a] = ads_exp_fields.getitemstring(a,"db_lookup_type") 

	ls_db_field_name_array[a]=ads_exp_fields.getitemstring(a,"db_field_name_intellicred")
	ls_db_table_name_array[a]=ads_exp_fields.getitemstring(a,"db_table_name_intellicred")

	li_billing_array[a] = ads_exp_fields.GetItemNumber(a,"billing_link")  
	ls_field_format_array[a] = ads_exp_fields.GetItemString(a,"export_format")
	ls_field_value_array[a] = ads_exp_fields.GetItemString(a,"field_value")  
	ls_dbtype_array[a] = trim(ads_exp_fields.GetItemString(a,"db_field_type"))

	ls_field_type_array[a] = ls_type[a]

	li_len_array[a] = ads_exp_fields.getitemnumber(a,"export_field_length")
	li_sub_start_array[a] = ads_exp_fields.getitemnumber(a,"export_fields_substring_start")
	if li_sub_start_array[a] < 2 or isnull(li_sub_start_array[a]) then li_sub_start_array[a] = 1
Next

for r = 1 to pc //for the list of passed pracids
	ll_row_loc = ll_dummy
	ll_prac = al_prac_ids[r]
	ll_row_loc[1] = row_cnt	
	
	//show progress
	If Mod(r,200) = 0 Then
		yield()
		Debugbreak()
		w_export_progress.st_export.Text = '('+String(r) + "/" + String(pc)+')'
	End If
	

//   ls_filter = ls_colname + "prac_id = " +string(ll_prac)
//    lds_getdata.setfilter(ls_filter)
//    lds_getdata.filter()
	
	//For New loop
	lb_find = False
	ll_start = ll_end + 1
	dc = 0
	
	//Find all records about current prac_id
	For i = ll_start to ll_data_cnt
		If lds_getdata.GetItemNumber(i, ls_prac_id_col) = ll_prac Then
			lb_find = True
			dc ++
		Else
			Exit
		End If
	Next
	
	If lb_find Then
		ll_end = ll_start+ dc - 1
	End If
	
	//dc = lds_getdata.rowcount()
	if dc > 0 then  //(Appeon)Stephen 01.12.2015 - changed from 1 to 0 --Critical Allegheny EPSI export issue
		
		for d = 2 to dc  //Start Code Change ----05.28.2009 #V92 maha - changed from 1 to 2 ; was duplicating the first row.
			ads_export.rowscopy(row_cnt,row_cnt,primary!,ads_export,row_cnt + 1,primary!)
			//ids_export_dataTemp.rowscopy(row_cnt,row_cnt,primary!,ids_export_dataTemp,row_cnt + 1,primary!) //(Appeon)Stephen 09.12.2014 - bug Id 4216 Export multi-row and calculated fields//Comment by Appeon long.zhang 11.08.2016 
			row_cnt++
			ll_row_loc[d] = row_cnt
		next
	
		//for d = 1 to dc
		for d = ll_start to ll_end //Added by Appeon long.zhang 11.04.2016 (Case 67116 - Export Erring after an hour, SaaS v15.1 10132016)
			ll_row_loc_num = ll_row_loc[d - ll_start + 1] //Added by Appeon long.zhang 11.04.2016 (Case 67116 - Export Erring after an hour, SaaS v15.1 10132016)
			for a = 1 to upperbound(ai_col_num[])
		
//				ls_fname = ads_exp_fields.getitemstring(a,"export_field_name")
//				//---------Begin Added by (Appeon)Stephen 11.27.2014 for Allegheny - Help with an export--------
//				ls_def_val = ads_exp_fields.getitemstring(a,"default_value")
//				ls_query_filter = ads_exp_fields.getitemstring(a,"filter_query")
//				li_use_link = ads_exp_fields.getitemnumber(a,"use_link") 		
//				if lb_faci = true then li_faci_filter = ads_exp_fields.getitemnumber(a,"facility_id") 	
//				//---------End Added ------------------------------------------------------
//				
//				ls_lu_field = ads_exp_fields.getitemstring(a,"lu_field_name")
//				ls_lu_type = ads_exp_fields.getitemstring(a,"db_lookup_type") //maha 010305
//				//--------Begin Added by Nova 10.30.2009------------------------
//				ls_db_field_name=ads_exp_fields.getitemstring(a,"db_field_name_intellicred")
//				ls_db_table_name=ads_exp_fields.getitemstring(a,"db_table_name_intellicred")
//				//--------End Added --------------------------------------------
//	
//				//---------Begin Added by (Appeon)Stephen 09.09.2014 for Export multirows and billing addresses--------
//				li_billing = ads_exp_fields.GetItemNumber(a,"billing_link")   //is it a billing address field
//				ls_field_format = ads_exp_fields.GetItemString(a,"export_format")
//				ls_field_value = ads_exp_fields.GetItemString(a,"field_value")  //Start Code Change ----11.03.2014 #V14.2 maha
//				ls_select_field = ls_db_field_name
//				ls_dbtype = trim(ads_exp_fields.GetItemString(a,"db_field_type"))
//				//---------End Added ------------------------------------------------------
		
				////is it a billing address field
				IF li_billing_array[a] = 1 and PosA(ls_table, "pd_address",1) > 0 then 
					ll_billing_id = lds_getdata.getitemnumber(d, ac+2)

					if isnull(ll_billing_id) then  //Start Code Change ----09.02.2014 #V14.2 maha - trap for no billing id
						ls_value = ""
					else
						//ls_value = of_get_billing_new(ll_billing_id, ls_select_field, ls_dbtype,ls_field_format) //Start Code Change ----08.29.2014 #V14.2 maha
						ls_value = of_get_billing_new(ll_billing_id, ls_db_field_name_array[a], ls_dbtype_array[a],ls_field_format_array[a]) //Modified by Appeon long.zhang 11.04.2016
						
						choose case ls_lu_type_array[a]
							case "A"
								ls_value =  gnv_data.of_getitem( "address_lookup", ls_lu_field_array[a], "lookup_code = " + ls_value)
							case "C"
								ls_value = gnv_data.of_getitem( "code_lookup", ls_lu_field_array[a], "lookup_code = " + ls_value)
						end choose
					end if
					if isnull(ls_value) then ls_value = ""
					if not isvalid(w_export_progress) then return -1 
					
					//---------Begin Added by (Appeon)Stephen 11.27.2014 for Allegheny - Help with an export--------
					if ls_field_format_array[a] = "use text"  then
						if  (isnull(ls_value) or ls_value = '') then
							ls_value = ls_def_val_array[a]
						else
							ls_value = ls_field_value_array[a] 
						end if
					end if
					//---------End Added ------------------------------------------------------
					
					//if is_text_delimiter = "Q" then ls_value = '"' + ls_value + '"'   //Commented by (Appeon)Stephen 11.02.2015 - Quality Care Partners Export - OPPOC2015 //Start Code Change ----09.18.2014 #V14.2 maha - text delimiters
					
					//------------------- APPEON BEGIN -------------------
					//<$>added:long.zhang 11.04.2016
					//<$>reason:Case 67116 - Export Erring after an hour, SaaS v15.1 10132016				
//					ads_export.setitem(ll_row_loc[d], ai_col_num[a], ls_value ) 
//					ids_export_dataTemp.setitem(ll_row_loc[d], ai_col_num[a], ls_value ) //(Appeon)Stephen 09.12.2014 - bug Id 4216 Export multi-row and calculated fields
					ads_export.setitem(ll_row_loc_num, ai_col_num[a], ls_value ) 
					//------------------- APPEON END -------------------
					
					continue
				END IF
			//---------End Added ------------------------------------------------------
				
//				ls_field_type = lds_field_type.of_getcoltype(lds_getdata.describe("#"+string(a)+".name"))
//				if ls_field_type = '!' or ls_field_type='?' or isnull(ls_field_type) or ls_field_type = '' then
//					ls_field_type = ls_type[a]
//				end if				
				ls_field_type = ls_field_type_array[a] //Modified by Appeon long.zhang 11.04.2016
				
				choose case ls_field_type /*ads_exp_fields.getitemstring(a,"db_field_type")*/ // modify by stephen 01.13.2012 -DataWindow column type does not match GetItem type 
					case "C","L"   //char, long varchar, Text						
						ls_value = lds_getdata.getitemstring(d, a)
					case "I","N"
						ls_value = string(lds_getdata.getitemnumber(d,a))						
					case "D","T" //date ,timestamp
						//ls_value = of_date_format(ads_exp_fields.getitemstring(a,"export_format"),lds_getdata.getitemdatetime(d,a))
						ls_value = of_date_format(ls_field_format_array[a] ,lds_getdata.getitemdatetime(d,a))  //Modified by Appeon long.zhang 11.04.2016					
				end choose
				
				//--------Begin Added by Nova 10.30.2009------------------------
				 if ls_db_field_name_array[a]='active_status' and ls_db_table_name_array[a]="pd_priv_list"  then
					choose case ls_value
						case '1'
							ls_value='Active'
						case '0'
							ls_value='History'
					end choose		
				 end if
				//--------End Added --------------------------------------------
		
				choose case ls_lu_type_array[a]
					case "A"
						//--Begin Modified by alfee 04.15.2010 ---
						if lds_addr_lu.rowcount() < 1 then gnv_data.of_retrieve("address_lookup")
						alu = lds_addr_lu.rowcount()
						//--End Modified --------------------------
						ll_find = lds_addr_lu.find("lookup_code = " + ls_value,1,alu)
						if ll_find > 0 then 
							//--Begin Modified by alfee 05.07.2010 ---
							choose case lower(ls_lu_field_array[a])
									//--------Begin Modified by  Nova 05.31.2010------------------------
									//case "lookup_code", "zip", "custom_1", "custom_2"
									case "lookup_code","custom_1", "custom_2"
									//--------End Modified --------------------------------------------
							//--End Modified -------------------------		
									//ls_value = string(lds_addr_lu.getitemnumber(ll_find,ads_exp_fields.getitemstring(a,"lu_field_name")))
									ls_value = string(lds_addr_lu.getitemnumber(ll_find,ls_lu_field_array[a]))  //Modified by Appeon long.zhang 11.04.2016
								case else
									//ls_value = lds_addr_lu.getitemstring(ll_find,ads_exp_fields.getitemstring(a,"lu_field_name"))
									ls_value = lds_addr_lu.getitemstring(ll_find, ls_lu_field_array[a]) //Modified by Appeon long.zhang 11.04.2016
							end choose
						else 
							//messagebox("","not found")
						end if							
						
					case "C"
						//--Begin Modified by alfee 04.15.2010 ---
						clu = lds_code_lu.rowcount()
						//--End Modified --------------------------							
						ll_find = lds_code_lu.find("lookup_code = " + ls_value,1,clu)
						if ll_find > 0 then 
							//choose case ls_lu_field
							choose case lower(ls_lu_field_array[a]) //alfee 05.07.2010									
								case "lookup_code"
									//ls_value = string(lds_code_lu.getitemnumber(ll_find,ads_exp_fields.getitemstring(a,"lu_field_name")))
									ls_value = string(lds_code_lu.getitemnumber(ll_find, ls_lu_field_array[a])) //Modified by Appeon long.zhang 11.04.2016
								case else
									//ls_value = lds_code_lu.getitemstring(ll_find,ads_exp_fields.getitemstring(a,"lu_field_name"))
									ls_value = lds_code_lu.getitemstring(ll_find,ls_lu_field_array[a]) //Modified by Appeon long.zhang 11.04.2016
									
							end choose
						end if
					 //--------Begin Added by Nova 10.30.2009------------------------
					 case "D"	//dddw lookup - modified by alfee 01.26.2010
						if lower(ls_db_table_name_array[a]) = "pd_priv_list" then
							if lower(ls_db_field_name_array[a]) ='clinical_area_id' then 					
								if Dlu < 1 then dlu = lds_priv_clinical_area.retrieve()
								ll_find = lds_priv_clinical_area.find("clinical_area_id = " + ls_value,1,dlu)
								if ll_find > 0 then 
									choose case ls_lu_field_array[a]
										case "Dept Code"
											ls_value =lds_priv_clinical_area.getitemstring(ll_find,"clinical_area_code")
										case else
											ls_value = lds_priv_clinical_area.getitemstring(ll_find,"clinical_area_description")
									end choose
								end if 
							elseif lower(ls_db_field_name_array[a])='priv_core_id' then 
								if slu < 1 then slu = lds_priv_core.retrieve()
								ll_find = lds_priv_core.find("priv_core_id = " + ls_value,1,slu)
								if ll_find > 0 then 
									choose case ls_lu_field_array[a]
										case "Section"
											ls_value =lds_priv_core.getitemstring(ll_find,"priv_core_description")
									end choose
								end if 
							elseif lower(ls_db_field_name_array[a])='procd_id' then 								
								if plu < 1 then plu = lds_priv_core_procd.retrieve()
								ll_find = lds_priv_core_procd.find("procd_id = " + ls_value,1,plu)
								if ll_find > 0 then 
									choose case ls_lu_field_array[a]
										case "Procedure Code"
											ls_value =lds_priv_core_procd.getitemstring(ll_find,"procd_name")
										case else
											ls_value = lds_priv_core_procd.getitemstring(ll_find,"core_procd_description")
									end choose
								end if 	
							end if
						end if
					 //--------End Added --------------------------------------------	
				end choose
				
				//Start Code Change ----09.18.2014 #V14.2 maha
				of_data_format(ls_field_format_array[a],ls_field_type,ls_value)

				//End Code Change ----09.18.2014
				
				 //---------Begin Modified by (Appeon)Stephen 11.27.2014 for Allegheny - Help with an export--------
				/*
				 //Start Code Change ----11.03.2014 #V14.2 maha
				if ls_field_format = "use text" then
					ls_value = ls_field_value
				end if
				 //End Code Change ----11.03.2014 
				 */
				 if ls_field_format_array[a] = "use text"  then
					if  (isnull(ls_value) or ls_value = '') then
						ls_value = ls_def_val_array[a]
					else
						ls_value = ls_field_value_array[a] 
					end if
				end if
				 //---------End Added ------------------------------------------------------
				

//				li_len = ads_exp_fields.getitemnumber(a,"export_field_length")
//				li_sub_start = ads_exp_fields.getitemnumber(a,"export_fields_substring_start")
//				if li_sub_start < 2 or isnull(li_sub_start) then li_sub_start = 1 //maha 010405
//				ls_value = MidA(ls_value,li_sub_start,li_len)
				ls_value = MidA(ls_value,li_sub_start_array[a],li_len_array[a])			
				
				if isnull(ls_value) then ls_value = ""   //Start Code Change ----11.05.2014 #V14.2 maha
				//if is_text_delimiter = "Q" then ls_value = '"' + ls_value + '"'   //Commented by (Appeon)Stephen 11.02.2015 - Quality Care Partners Export - OPPOC2015 //Start Code Change ----09.18.2014 #V14.2 maha - text delimiters
				
//				ads_export.setitem(ll_row_loc[d], ai_col_num[a], ls_value )
//				ids_export_dataTemp.setitem(ll_row_loc[d], ai_col_num[a], ls_value ) //(Appeon)Stephen 09.12.2014 - bug Id 4216 Export multi-row and calculated fields
				ads_export.setitem(ll_row_loc_num, ai_col_num[a], ls_value )
			next
		next
	end if
	row_cnt++
	
	//w_export_progress.r_bar.Width = w_export_progress.r_bar.Width + li_bar_ticks //Comment by Appeon long.zhang 11.04.2016 (Case 67116 - Export Erring after an hour, SaaS v15.1 10132016)
next
//------------------- APPEON BEGIN -------------------		

ads_exp_fields.setfilter("" )
ads_exp_fields.filter()
ads_exp_fields.sort()

//Added by Appeon long.zhang 11.07.2016
w_export_progress.st_export.Text = ''
Yield() 

destroy lds_getdata
destroy lds_field_type
destroy lds_priv_clinical_area
destroy lds_priv_core
destroy lds_priv_core_procd

return 1
end function

public function string of_getsql_from_export_temp (long al_prac_ids[], long al_spid, ref boolean lb_mulsel, string as_value);//////////////////////////////////////////////////////////////////////
// $<function>of_getsql_from_export_temp()
// $<arguments>
//		value	long	al_prac_ids[]
//		value	long	al_SpID
//		reference boolean ab_mulsel
//		value	string 	as_value  
// $<returns> string
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> Harry 05.06.2015 
// $ for issue: Issues running a custom correspondence letter against an IntelliBatch
//////////////////////////////////////////////////////////////////////
Long i
String ls_ids
String ls_tables
String ls_dbtype
String ls_prac_sql
String ls_Mysql
Long ll_SpID
Long ll_Cnt


ll_SpID = al_SpID


ls_ids = ""
for i = 1 to UpperBound (al_prac_ids[]) 
	ls_ids += string(al_prac_ids[i]) + ','
next
ls_ids = left(ls_ids, len(ls_ids) - 1)
choose case lower(as_value)
	case 'prac_id'
		ls_tables = 'pd_basic'
	case 'ctx_id'
		ls_tables = 'ctx_basic_info'
end choose

lb_mulsel = true

ls_prac_sql = "select distinct "  + as_value + "," + String(ll_spid) + " from " + ls_tables + " where " + as_value + " in ( " + ls_ids +" )"

select top 1 1 into :ll_Cnt from sysobjects where name = 'export_temp' and type = 'U';
if ll_Cnt = 1 then
	ls_MySQL = "DELETE FROM export_temp WHERE SpID = " + String(ll_spid) + ";"
else
	ls_MySQL = "CREATE TABLE export_temp (prac_id int null,SpID int null)"
end if
EXECUTE IMMEDIATE :ls_Mysql;

ls_MySQL = "INSERT INTO export_temp " + ls_prac_sql + ";"
EXECUTE IMMEDIATE :ls_Mysql;

ls_prac_sql = "select distinct prac_id as " + as_value + " from export_temp where SpID = " + String(ll_spid)
		
return ls_prac_sql
end function

on pfc_n_cst_ai_export_apb.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_ai_export_apb.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if IsValid(ids_cred_export_data) then Destroy ids_cred_export_data //Evan 01.20.2010 (V10.1 - Notification Alert)
if IsValid(ids_ctx_export_data) then Destroy ids_ctx_export_data //---------Added by (Appeon)long.zhang 05.24.2014 (v14.2 Provider-Contract direct linking)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.18.2007 By: Jack
//$<reason> Fix a defect.
If isvalid(ids_export_data) Then
	//----Begin Modified by Alfee 05.25.2007-------------
	//<$Reason> if not called from replacing fields in email template, then...
	//If is_called_type <> '3' Then destroy ids_export_data
	If is_called_type <> '3' and is_called_type <> '2' Then destroy ids_export_data //alfee 10.28.2008
	//destroy ids_export_data
	//----End Modified ----------------------------------
End If
//---------------------------- APPEON END ----------------------------
//---------Begin Added by (Appeon)Toney 06.19.2013 for V141 ISG-CLX--------
If isvalid(invo_rights) Then Destroy invo_rights

If isvalid(inv_arr_db) Then 
	inv_arr_db.of_delete_temp_data(is_client_id[])
	Destroy inv_arr_db
End If
//---------End Added ------------------------------------------------------------------

of_cleanup_ds()  //(Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
end event

event constructor;ids_cred_export_data = Create datastore //Evan 01.20.2010 (V10.1 - Notification Alert)
ids_ctx_export_data = Create datastore//---------Added by (Appeon)long.zhang 05.24.2014 (v14.2 Provider-Contract direct linking)
//---------Begin Added by (Appeon)Toney 06.19.2013 for V141 ISG-CLX--------
invo_rights = Create n_cst_rights
inv_arr_db = Create n_cst_array_db 
//---------End Added ------------------------------------------------------------------

of_create_ds() //(Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
end event

