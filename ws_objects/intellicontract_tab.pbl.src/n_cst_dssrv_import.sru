$PBExportHeader$n_cst_dssrv_import.sru
forward
global type n_cst_dssrv_import from nonvisualobject
end type
end forward

global type n_cst_dssrv_import from nonvisualobject autoinstantiate
end type

type variables
DataStore	ids_requestor
DataStore ids_col_mapping
string is_object_name

end variables

forward prototypes
public subroutine of_setrequestor (datastore ads, string as_dataobject_name)
public function integer of_gen_mapping (datastore ads, string as_object_name)
public function string of_getitem (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value, string as_col_type, string as_format, string as_edit_style)
public function integer of_get_values (integer al_row, integer al_col, ref string as_new_value, ref string as_old_value, dwbuffer adw_buffer)
end prototypes

public subroutine of_setrequestor (datastore ads, string as_dataobject_name);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dssrv.of_setrequestor()
// $<arguments>
//		datastore	ads               		
//		string   	as_dataobject_name		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11/29/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

ids_requestor = ads
is_object_name = as_dataobject_name
of_gen_mapping(ids_requestor,is_object_name)
end subroutine

public function integer of_gen_mapping (datastore ads, string as_object_name);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dssrvof_gen_mapping()
// $<arguments>
//		value	datastore	ads           		
//		value	string   	as_object_name		
// $<returns> integer
// $<description> Generate col mapping
//////////////////////////////////////////////////////////////////////
// $<add> 11/28/2007 by Ken.Guo
//modified by gavins 20120313 grid
//////////////////////////////////////////////////////////////////////

Long ll_screen_id
Long i,j,ll_import_col_count,ll_screen_col_count,ll_row
String ls_sql
String ls_import_col_dbname,ls_screen_col_dbname
String ls_col_format,ls_col_mask,ls_string_format
long ll_pos
String ls_object_name, ls_Screen_Style 
Datastore lds_screen
//Use default view(1001) to get dw syntax
If as_object_name = 'd_contract_det_contact_internal' Then as_object_name = 'd_contract_det_contact_external'
//Added By Mark Lee 08/17/12
//Select top 1 screen_id , screen_style into :ll_screen_id, :ls_Screen_style from  ctx_screen where dataobject = :as_object_name and data_view_id = 1001;
Select top 1 screen_id , screen_style into :ll_screen_id, :ls_Screen_style from  ctx_screen where (dataobject = :as_object_name or grid_dataobject = :as_object_name ) and data_view_id = 1001;
If appeongetclienttype() = 'WEB' Then
	If ls_Screen_style = 'G' Then//added by gavins 20120313 grid
		SELECT grid_sql INTO :ls_sql FROM ctx_screen WHERE data_view_id = 1001 AND screen_id = :ll_screen_id;
	Else
		SELECT dw_sql INTO :ls_sql FROM ctx_screen WHERE data_view_id = 1001 AND screen_id = :ll_screen_id;
	End If
Else
	If ls_Screen_style = 'G' Then//added by gavins 20120313 grid
		ls_sql = f_get_screen_gridsql(1001,ll_screen_id,false)  //add false argu - jervis 10.11.2011
	Else
		ls_sql = f_get_screen_sql(1001,ll_screen_id,false)  //add false argu - jervis 10.11.2011
	End If
End If
lds_screen = Create DataStore
If lds_screen.Create(ls_sql) <> 1 Then Return -1

ll_import_col_count = Long(ads.Describe("DataWindow.Column.Count"))
ll_screen_col_count = Long(lds_screen.Describe("DataWindow.Column.Count"))

//Generate col mapping 
For i = 1 To ll_import_col_count
	ll_row = ids_col_mapping.InsertRow(0)
	ids_col_mapping.SetItem(ll_row,'import_ds_col',ads.Describe("#"+String(i) +".Name") )
	ls_import_col_dbname = ads.Describe("#"+String(i) +".dbName")
	For j = 1 To ll_screen_col_count
		ls_screen_col_dbname = lds_screen.Describe("#"+String(j) +".dbName")
		If ls_import_col_dbname = ls_screen_col_dbname Then
			//Set Colname and Edit.Style
			ids_col_mapping.SetItem(ll_row,'screen_ds_col',lower(lds_screen.Describe("#"+String(j) +".Name")))
			ids_col_mapping.SetItem(ll_row,'style',lower(lds_screen.Describe("#"+String(j)+".Edit.Style")))

			//Set Format	
			ls_col_format = lds_screen.Describe ( "#"+String(j) + ".format" )
			ls_col_mask   = lds_screen.Describe ( "#"+String(j) + ".editmask.mask") 
			IF ls_col_mask = "!" or ls_col_mask = "?" THEN
				ls_string_format = ls_col_format
			ELSE 
				ls_string_format = ls_col_mask
			END IF 
			IF ls_string_format = "!" or ls_string_format = "?" THEN 
				ls_string_format = ""
			ELSE
				ll_pos = Pos ( ls_string_format, "~t" ) 
				If ll_pos > 0 Then
					If Left ( ls_string_format, 1 ) = "~"" Then
						ls_string_format = Mid ( ls_string_format, 2, ll_pos - 2 ) 
					Else
						ls_string_format = Left ( ls_string_format, ll_pos - 1 ) 
					End If
				END IF
			END IF  
			ids_col_mapping.SetItem(ll_row,'format',ls_string_format)
			Exit
		End If
	Next
Next
Return 1


end function

public function string of_getitem (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value, string as_col_type, string as_format, string as_edit_style);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dssrvof_getitem()
// $<arguments>
//		long    	al_row       		
//		string  	as_column    		
//		dwbuffer	adw_buffer   		
//		boolean 	ab_orig_value		
//		string  	as_col_type  		
//		string  	as_format    		
//		string  	as_edit_style		
// $<returns> string
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11/29/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

string 	ls_col_format, ls_col_mask, ls_string_format, ls_string, ls_savestring
string	ls_coltype, ls_editstyle
string	ls_computeexp, ls_evaluateexp
string	edit_codetable, editmask_codetable
boolean 	lb_editmask_used=False
long 		ll_pos
n_cst_string	lnv_string

If as_edit_style = 'editmask' Then lb_editmask_used = True
CHOOSE CASE Left ( as_col_type , 5 )
		CASE "char(", "char"				//  CHARACTER DATATYPE
			IF lb_editmask_used = TRUE THEN 
				/*  Need to replace 'EditMask' characters with 'Format' characters */
				as_format = lnv_string.of_GlobalReplace ( as_format, "^", "@" ) //Lowercase
				as_format = lnv_string.of_GlobalReplace ( as_format, "!", "@")	//Uppercase
				as_format = lnv_string.of_GlobalReplace ( as_format, "#", "@" ) //Number
				as_format = lnv_string.of_GlobalReplace ( as_format, "a", "@" ) //Aplhanumeric
				as_format = lnv_string.of_GlobalReplace ( as_format, "x", "@" ) //Any Character
			END IF 
			ls_string = ids_requestor.GetItemString ( al_row, as_column, adw_buffer, ab_orig_value ) 
			ls_string = String ( ls_string, as_format ) 
		CASE "date"					//  DATE DATATYPE
			date ld_date
			ld_date = ids_requestor.GetItemDate ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (as_format) > 0 then
				ls_string = String ( ld_date, as_format ) 
			else
				ls_string = String (ld_date)
			end if
		CASE "datet"				//  DATETIME DATATYPE
			datetime ldtm_datetime
			ldtm_datetime = ids_requestor.GetItemDateTime ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (as_format) > 0 then
				ls_string = String ( ldtm_datetime, as_format ) 
			else
				ls_string = String (ldtm_datetime)
			end if
		CASE "decim"				//  DECIMAL DATATYPE
			decimal ldec_decimal
			ldec_decimal = ids_requestor.GetItemDecimal ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (as_format) > 0 then
				ls_string = String ( ldec_decimal, as_format ) 
			else
				ls_string = String (ldec_decimal)
			end if	
		CASE "numbe", "doubl", "real"		//  DOUBLE DATATYPE	
			double ldbl_double
			ldbl_double = ids_requestor.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (as_format) > 0 then
				ls_string = String ( ldbl_double, as_format ) 
			else
				ls_string = String (ldbl_double)
			end if
		CASE "long", "ulong", "int"				//  LONG DATATYPE	
			long ll_long
			ll_long = ids_requestor.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (as_format) > 0 then
				ls_string = String ( ll_long, as_format ) 
			else
				ls_string = String (ll_long)
			end if
		CASE "time", "times"		//  TIME DATATYPE
			time ltm_time
			ltm_time = ids_requestor.GetItemTime ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (as_format) > 0 then
				ls_string = String ( ltm_time, as_format ) 
			else
				ls_string = String (ltm_time)
			end if
END CHOOSE

Return ls_string

end function

public function integer of_get_values (integer al_row, integer al_col, ref string as_new_value, ref string as_old_value, dwbuffer adw_buffer);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dssrvof_get_values()
// $<arguments>
//				al_row    		
//				al_col    		
//			string    	as_new_value		
//			string    	as_old_value		
//				adw_buffer		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11/29/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i,ll_find,ll_old_value,ll_new_value
String ls_col_name
String ls_col_type,ls_edit_style,ls_format
ls_col_name = ids_requestor.Describe("#"+String(al_col) +".Name")
ls_col_type = ids_requestor.Describe("#"+String(al_col) +".Coltype")
ll_find = ids_col_mapping.Find("import_ds_col = '"+ ls_col_name+"'",1,ids_col_mapping.Rowcount())
If ll_find > 0 Then
	ls_edit_style = ids_col_mapping.GetItemString(ll_find,'style')
	ls_format = ids_col_mapping.GetItemString(ll_find,'format')
	If ls_edit_style = 'dddw' Then
		Choose Case lower(left(ls_col_type,4))
			Case 'char','date'
				as_old_value = of_getitem( al_row,ls_col_name, adw_buffer,True, ls_col_type, ls_format, ls_edit_style)
				as_new_value = of_getitem( al_row,ls_col_name, adw_buffer,False, ls_col_type, ls_format, ls_edit_style)				
			Case Else
				//Get From code_lookup
				ll_old_value = ids_requestor.getitemNumber(al_row,al_col,adw_buffer,true)
				ll_new_value = ids_requestor.getitemNumber(al_row,al_col,adw_buffer,false)
				
				if string(ids_requestor.describe("#" + string(al_col)+".name")) = "app_facility" and is_object_name = 'd_contract_det_master' then
					SELECT facility_name into :as_old_value FROM app_facility where facility_id = :ll_old_value;  
					If ll_old_value = ll_new_value Then
						as_new_value = as_old_value
					Else
						SELECT facility_name into :as_new_value FROM app_facility where facility_id = :ll_new_value;  						
					End If
				else
					as_old_value = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + String(ll_old_value))                                                      
					If ll_old_value = ll_new_value Then
						as_new_value = as_old_value
					Else
						as_new_value = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + String(ll_new_value))	
					End If
				end if
		End Choose
	Else
		as_old_value = of_getitem( al_row,ls_col_name, adw_buffer,True, ls_col_type, ls_format, ls_edit_style)
		as_new_value = of_getitem( al_row,ls_col_name, adw_buffer,False, ls_col_type, ls_format, ls_edit_style)						
	End If
Else
	as_old_value = of_getitem( al_row,ls_col_name, adw_buffer,True, ls_col_type, '', '')
	as_new_value = of_getitem( al_row,ls_col_name, adw_buffer,False, ls_col_type, '', '')
End If
Return 1
end function

on n_cst_dssrv_import.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dssrv_import.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_col_mapping = Create DataStore
ids_col_mapping.Dataobject = 'd_import_col_mapping'
end event

event destructor;If isvalid(ids_col_mapping) Then Destroy ids_col_mapping


end event

