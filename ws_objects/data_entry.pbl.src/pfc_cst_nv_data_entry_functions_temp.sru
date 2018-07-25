$PBExportHeader$pfc_cst_nv_data_entry_functions_temp.sru
forward
global type pfc_cst_nv_data_entry_functions_temp from nonvisualobject
end type
end forward

global type pfc_cst_nv_data_entry_functions_temp from nonvisualobject
end type
global pfc_cst_nv_data_entry_functions_temp pfc_cst_nv_data_entry_functions_temp

type variables
Integer ii_column_cnt

String is_sort_syntax
String is_column_names[]
String is_column_default[]
String is_rec_id_col_nm
String is_first_column 
String is_table_name

n_ds ids_lookup_code
n_ds ids_lookup_address
n_ds ids_screen_fields
n_ds ids_screen_objects

Boolean ib_vscroll = False


end variables

forward prototypes
public function string of_get_first_column ()
public function integer of_set_defaults (u_dw a_dw, integer ai_row)
public function integer of_setup_cache ()
public function integer of_itemchanged (u_dw a_dw, string as_data)
public function integer of_field_audit (u_dw adw)
public function integer of_record_validation (u_dw a_dw)
public function integer of_update_dddw (u_dw a_dw_detail, u_dw a_dw_browse)
public function integer of_create_dynamic_dw_browse (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_browse)
public function integer of_create_dynamic_ds_old (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, n_ds adw_detail)
public function string of_create_dynamic_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id)
public function integer of_create_dynamic_ds (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, n_ds adw_detail, integer ai_facility_id, n_tr atr_sqlca)
public function integer of_refresh_cache ()
public function integer of_get_next_seq_no (string as_dw, long al_rec_id)
public function integer of_add_address_link (long al_prac_id, integer ai_facility_id)
public function string of_create_dynamic_profile_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id)
public function integer of_get_facil_specific (integer ai_table)
public function integer of_add_hosp_link (long ai_facility_id, long al_prac_id)
public function integer of_add_spec_link (integer al_facil_id, long al_prac_id)
public function string of_get_reference_val (long al_table)
end prototypes

public function string of_get_first_column ();Return is_first_column
end function

public function integer of_set_defaults (u_dw a_dw, integer ai_row);Integer li_fld_cnt
Integer i

li_fld_cnt = UpperBound( is_column_names[] )

FOR i = 1 TO li_fld_cnt
	IF Not IsNull(is_column_names[ i ]) AND Not IsNull( is_column_default[i]) THEN
		a_dw.SetColumn( is_column_names[ i ] )
		a_dw.SetText( is_column_default[ i ] )
	END IF
END FOR

a_dw.AcceptText()

RETURN 0
end function

public function integer of_setup_cache ();if gi_cache_set = 0 then //maha 092701

ids_screen_fields = CREATE n_ds
ids_screen_fields.DataObject = "d_screen_fields"
ids_screen_fields.of_SetTransObject( SQLCA )

ids_screen_objects = CREATE n_ds
ids_screen_objects.DataObject = "d_screen_objects"
ids_screen_objects.of_SetTransObject( SQLCA )
end if
return 0

//IF gnv_app.of_get_field_object_cache()  THEN
//	ids_screen_fields.DataObject = "d_screen_fields_all"
//	ids_screen_fields.of_SetTransObject( SQLCA )
//	gnv_app.inv_dwcache.of_GetRegistered("SCREEN_FIELDS", ids_screen_fields)
//
//	ids_screen_objects.DataObject = "d_screen_objects_all"
//	ids_screen_objects.of_SetTransObject( SQLCA )
//	gnv_app.inv_dwcache.of_GetRegistered("SCREEN_OBJECTS", ids_screen_objects)
//END IF
//
//Return 0
//
end function

public function integer of_itemchanged (u_dw a_dw, string as_data);

CHOOSE CASE is_table_name
	CASE "pd_basic"
		IF a_dw.GetColumnName() = "middle_name" AND LenA(as_data) = 1 THEN
			as_data = as_data + "."
			a_dw.SetItem( a_dw.GetRow(), "middle_name", as_data )
			Return 1
		END IF

END CHOOSE


RETURN 0
end function

public function integer of_field_audit (u_dw adw);Integer i
Integer c
Integer li_rc
Integer li_lu_rc
Long ll_seq_rc
Long ll_seq_no
Integer li_nr
Integer li_col_cnt
Integer li_table_id
integer li_fs //maha 111502
Long ll_rec_id
Long ll_field_id
Long ll_field_id2
Long ll_field_id1
Long ll_old_value
Long ll_new_value
long ll_facility_id //maha111802
String ls_lookup_type
String ls_is_lookup
String ls_lookup_field_name
String ls_retval
String ls_old_value
String ls_new_value
String ls_value1
String ls_value2
String ls_table_name
String ls_fld_nm
String ls_fld_nm2
String ls_fld_type
n_ds lds_audit_fields
n_ds lds_lookup_code
n_ds lds_lookup_address
n_ds lds_sys_audit
n_ds lds_last_seq_no

ls_table_name = adw.Object.DataWindow.Table.UpdateTable
//MessageBox("of audit trail", ls_table_name)
lds_sys_audit = CREATE n_ds
lds_sys_audit.DataObject = "d_view_audit"
lds_sys_audit.of_SetTransObject( SQLCA )

lds_last_seq_no = CREATE n_ds
lds_last_seq_no.DataObject = "d_get_last_field_audit_seq_no"
lds_last_seq_no.of_SetTransObject( SQLCA )

lds_lookup_code = CREATE n_ds
lds_lookup_code.DataObject = "d_lookup_code_search"
lds_lookup_code.of_SetTransObject( SQLCA )

lds_lookup_address = CREATE n_ds
lds_lookup_address.DataObject = "d_lookup_address_search"
lds_lookup_address.of_SetTransObject( SQLCA )

lds_audit_fields = CREATE n_ds
lds_audit_fields.DataObject = "d_audit_fields"
lds_audit_fields.of_SetTransObject( SQLCA )
li_col_cnt = lds_audit_fields.Retrieve( ls_table_name )
//messagebox("audit fields",li_col_cnt)
IF li_col_cnt < 1 THEN
//	messagebox("audit fields",li_col_cnt)
	Return -1
END IF

li_rc = adw.RowCount()
//messagebox("adw count",li_rc)
li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
li_fs = of_get_facil_specific(li_table_id)
FOR i = 1 TO li_rc
		ll_rec_id = adw.GetItemNumber( i, "rec_id" ) 
		if li_fs = 1 then
			if ls_table_name = "pd_affil_stat" then
				ll_facility_id = adw.GetItemNumber( i, "parent_facility_id" )
			else
				ll_facility_id = adw.GetItemNumber( i, "facility_id" )
			end if
		end if
	IF adw.GetItemStatus( i, 0, Primary! ) = DataModified! THEN
		//li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
		//messagebox("audit fields","data modified")
		FOR c = 1 TO li_col_cnt
			
			ll_field_id = lds_audit_fields.GetItemNumber( c, "field_id" )
			ls_fld_nm = lds_audit_fields.GetItemString( c, "field_name" )
			ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
			//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
			
			IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
				ls_fld_type = "C"
			ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
				ls_fld_type = "D"
			ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 OR PosA( ls_fld_type, "REAL" ) > 0 THEN
				ls_fld_type = "N"
			ELSEIF ls_fld_type = "!" THEN
				//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
				CONTINUE
			ELSE				
				MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
				Return -1
			END IF
			//ls_fld_type = lds_audit_fields.GetItemString( c, "field_type" )
			IF adw.GetItemStatus( i, ls_fld_nm, Primary! ) = DataModified! THEN
				ls_lookup_field_name = UPPER( lds_audit_fields.GetItemString( c, "lookup_field_name" ) )
				ls_is_lookup = lds_audit_fields.GetItemString( c, "lookup_field" )
				ls_lookup_type = lds_audit_fields.GetItemString( c, "lookup_type" )								
				IF ls_fld_type = "C" THEN
					ls_old_value = adw.GetItemString( i, ls_fld_nm, Primary!, True )
					ls_new_value = adw.GetItemString( i, ls_fld_nm )
				ELSEIF ls_fld_type = "N" THEN
					ll_old_value = adw.GetItemNumber( i, ls_fld_nm, Primary!, True ) 
					ll_new_value = adw.GetItemNumber( i, ls_fld_nm ) 												
					IF ls_is_lookup = "Y" THEN
						IF ls_lookup_type = "C" THEN
							//get the old value
							li_lu_rc = lds_lookup_code.Retrieve( ll_old_value )
							IF li_lu_rc = 0 THEN
								ls_old_value = ""
							ELSEIF ls_lookup_field_name = "CODE" THEN
								ls_old_value = lds_lookup_code.GetItemString( 1, "code" )									
							ELSE
								ls_old_value = lds_lookup_code.GetItemString( 1, "description" )								
							END IF
							//get the new value
							li_lu_rc = lds_lookup_code.Retrieve( ll_new_value )
							IF li_lu_rc = 0 THEN
								ls_new_value = ""
							ELSEIF ls_lookup_field_name = "CODE" THEN
								ls_new_value = lds_lookup_code.GetItemString( 1, "code" )									
							ELSE
								ls_new_value = lds_lookup_code.GetItemString( 1, "description" )								
							END IF								
						ELSE
							//get the old value
							li_lu_rc = lds_lookup_address.Retrieve( ll_old_value )
							IF li_lu_rc = 0 THEN
								ls_old_value = ""
							ELSEIF ls_lookup_field_name = "CODE" THEN
								ls_old_value = lds_lookup_address.GetItemString( 1, "code" )									
							ELSE
								ls_old_value = lds_lookup_address.GetItemString( 1, "entity_name" )								
							END IF
							//get the new value
							li_lu_rc = lds_lookup_address.Retrieve( ll_new_value )
							IF li_lu_rc = 0 THEN
								ls_new_value = ""
							ELSEIF ls_lookup_field_name = "CODE" THEN
								ls_new_value = lds_lookup_address.GetItemString( 1, "code" )									
							ELSE
								ls_new_value = lds_lookup_address.GetItemString( 1, "entity_name" )																
							END IF
						END IF
					ELSE
						ls_old_value = String( adw.GetItemNumber( i, ls_fld_nm, Primary!, True ) )
						ls_new_value = String( adw.GetItemNumber( i, ls_fld_nm ) )						
					END IF
				ELSE
					ls_old_value = String( Date( adw.GetItemDateTime( i, ls_fld_nm, Primary!, True ) ) )
					ls_new_value = String( Date( adw.GetItemDateTime( i, ls_fld_nm ) ) )												
				END IF
				ll_seq_rc = lds_last_seq_no.Retrieve( ll_rec_id, ll_field_id )
				IF ll_seq_rc > 0 THEN
					ll_seq_no = lds_last_seq_no.GetItemNumber(1, "last_seq_no" ) 
				END IF
				IF ll_seq_no = 0 OR IsNull( ll_seq_no ) THEN
					ll_seq_no = 1
				ELSE
					ll_seq_no++
				END IF
				li_nr = lds_sys_audit.InsertRow( 0 )
				lds_sys_audit.SetItem( li_nr, "rec_id", ll_rec_id )
				lds_sys_audit.SetItem( li_nr, "prac_id", adw.GetItemNumber( i, "prac_id" ) )					
				lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )										
				lds_sys_audit.SetItem( li_nr, "table_id", li_table_id )
				lds_sys_audit.SetItem( li_nr, "field_id", ll_field_id )
				lds_sys_audit.SetItem( li_nr, "old_value", MidA(ls_old_value,1,100) )
				lds_sys_audit.SetItem( li_nr, "new_value", MidA(ls_new_value,1 ,100 ))
				lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
				lds_sys_audit.SetItem( li_nr, "audit_type", "E" )					
				lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Today(), Now() ) )
				lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )
				if li_fs = 1 then
					lds_sys_audit.SetItem( li_nr, "facility_id", ll_facility_id )
				else
					lds_sys_audit.SetItem( li_nr, "facility_id", 0 )
				end if
			END IF
		END FOR
////***********************************INSERT \/		
	elseif adw.GetItemStatus( i, 0, Primary! ) = NewModified! THEN //maha 070902 for INSERTS
		//li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
		ll_field_id = 1000 
		//messagebox("li_table_id",li_table_id)

		//messagebox("of_audit","in insert code")
		choose case ls_table_name
			case "pd_affil_stat"
				ll_new_value = adw.GetItemnumber( i, "parent_facility_id" )
				select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
				ls_value2 = adw.GetItemstring( i, "apptmnt_type" )
				ls_new_value = ls_value1 + "-" + ls_value2
			case "pd_affil_dept"
				ll_new_value = adw.GetItemnumber( i, "department" )
				select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
				ls_new_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_cat"
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
				ll_new_value = adw.GetItemnumber( i, "staff_category" )
				select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				ls_new_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_leave"
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
				ll_new_value = long(adw.GetItemstring( i, "leave_of_absence_reason" ))
				select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				ls_new_value = ls_value1 + "-" + ls_value2
			case else //data entry screens
				//ls_new_value = of_get_reference_val(li_table_id)
				//get reference field 1
				select reference_field_1 into :ll_field_id1  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
				//get reference field 2
				select reference_field_2 into :ll_field_id2  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
				//get reference field name 1
				select field_name into :ls_fld_nm from sys_fields where field_id = :ll_field_id1;
				if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				select field_name into :ls_fld_nm2 from sys_fields where field_id = :ll_field_id2;
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
				
				//ref 1 data
				//datatype and lookup field
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id1;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id1;

				ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
					ls_fld_type = "C"
				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
					ls_fld_type = "D"
				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
					ls_fld_type = "N"
				ELSEIF ls_fld_type = "!" THEN
					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
					CONTINUE
				ELSE				
					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
					Return -1
				END IF
				//data value
				choose case ls_fld_type
					case "C","V"
						ls_value1 = adw.GetItemString( i, ls_fld_nm )
					case "N", "I"
						ls_value1 = string(adw.GetItemnumber( i, ls_fld_nm ))
					case "D"
						ls_value1 = string(adw.GetItemdatetime( i, ls_fld_nm ))
					case else
						ls_value1 = ""
				end choose
				//if lookup get lookup value
//					MessageBox("ls_lookup_type 1", ls_lookup_type)
//					messagebox("ls_fld_nm",ls_fld_nm)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value1) //convert to number
					select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				elseif ls_lookup_type = "A" then
//					messagebox("in","addr lookup")
//					MessageBox("ls_value1 a", ls_value1)
					ll_new_value = long(ls_value1)
					select entity_name into :ls_value1 from address_lookup where lookup_code = :ll_new_value;
					//MessageBox("ls_value1 after lookup", ls_value1)
				end if
				
	
				//reference 2 info
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id2;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id2;

				ls_fld_type = Upper( adw.Describe( ls_fld_nm2 + ".ColType" ) )
				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
					ls_fld_type = "C"
				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
					ls_fld_type = "D"
				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
					ls_fld_type = "N"
				ELSEIF ls_fld_type = "!" THEN
					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
					CONTINUE
				ELSE				
					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
					Return -1
				END IF
				
				choose case ls_fld_type
					case "C","V"
						ls_value2 = adw.GetItemString( i, ls_fld_nm2 )
					case "N", "I"
						ls_value2 = string(adw.GetItemnumber( i, ls_fld_nm2 ))
					case "D"
						ls_value2 = string(adw.GetItemdatetime( i, ls_fld_nm2 ))
					case else
						ls_value2 = ""
				end choose		
				//MessageBox("ls_lookup_type 2", ls_lookup_type)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value2)
					select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
				elseif ls_lookup_type = "A" then
					ll_new_value = long(ls_value2)
					select entity_name into :ls_value2 from address_lookup where lookup_code = :ll_new_value;
				end if
				//check for nulls
				if isnull(ls_value1) then ls_value1  = ""
				if isnull(ls_value2) then ls_value2  = ""
				ls_new_value = ls_value1 + "-" + ls_value2
				ls_new_value = MidA(ls_new_value,1,100)
////				MessageBox("ls_value1",ls_value1)
////				MessageBox("ls_value2",ls_value2)
		end choose
		
		//ls_new_value = ls_value1 + "-" + ls_value2
		ll_seq_rc = lds_last_seq_no.Retrieve( ll_rec_id, ll_field_id )
	//	messagebox("ls_new_value",ls_new_value)
		IF ll_seq_rc > 0 THEN
			ll_seq_no = lds_last_seq_no.GetItemNumber(1, "last_seq_no" ) 
		elseif ll_seq_rc < 0 THEN
		//	messagebox("seq", "fucked up")
		END IF
		IF ll_seq_no = 0 OR IsNull( ll_seq_no ) THEN
			ll_seq_no = 1
		ELSE
			ll_seq_no++
		END IF
//		messagebox("rec_id", ll_rec_id )
//		messagebox("ll_field_id", ll_field_id )
//		messagebox("ll_seq_no",ll_seq_no)
		li_nr = lds_sys_audit.InsertRow( 0 )
		lds_sys_audit.SetItem( li_nr, "rec_id", ll_rec_id )
		lds_sys_audit.SetItem( li_nr, "prac_id", adw.GetItemNumber( i, "prac_id" ) )					
		lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )										
		lds_sys_audit.SetItem( li_nr, "table_id", li_table_id )
		lds_sys_audit.SetItem( li_nr, "field_id", 1000 )
		//lds_sys_audit.SetItem( li_nr, "old_value", "INSERT" )
		lds_sys_audit.SetItem( li_nr, "new_value", ls_new_value )
		lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
		lds_sys_audit.SetItem( li_nr, "audit_type", "I" )					
		lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Today(), Now() ) )
		lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )
		if li_fs = 1 then
			lds_sys_audit.SetItem( li_nr, "facility_id", ll_facility_id )
		else
			lds_sys_audit.SetItem( li_nr, "facility_id", 0)
		end if
		
///************************DELETE	
	elseif adw.GetItemStatus( i, 0, Delete! ) = DataModified! or adw.GetItemStatus( i, 0, Delete! ) = NotModified! THEN //maha 070902 
 		
		li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
		//ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
		ll_rec_id = adw.GetItemNumber( i, "rec_id" ) 		
		li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
		ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
		ll_field_id = lds_audit_fields.GetItemNumber( 1, "field_id" )
		select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id;

		ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
		IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
			ls_fld_type = "C"
		ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
			ls_fld_type = "D"
		ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
			ls_fld_type = "N"
		ELSEIF ls_fld_type = "!" THEN
			//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
			CONTINUE
		ELSE				
			MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
			Return -1
		END IF
		
		choose case ls_table_name
			case "pd_affil_stat"
				ll_new_value = adw.GetItemnumber( i, "parent_facility_id" )
				select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
				ls_value2 = adw.GetItemstring( i, "apptmnt_type" )
				ls_old_value = ls_value1 + "-" + ls_value2
			case "pd_affil_dept"
				ll_new_value = adw.GetItemnumber( i, "department" )
				select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
				ls_old_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_cat"
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
				ll_new_value = adw.GetItemnumber( i, "staff_category" )
				select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				ls_old_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_leave"
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
				ll_new_value = long(adw.GetItemstring( i, "leave_of_absence_reason" ))
				select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				ls_old_value = ls_value1 + "-" + ls_value2
			case else //data entry screens
								//ls_new_value = of_get_reference_val(li_table_id)
				//get reference field 1
				select reference_field_1 into :ll_field_id1  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
				//get reference field 2
				select reference_field_2 into :ll_field_id2  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
				//get reference field name 1
				select field_name into :ls_fld_nm from sys_fields where field_id = :ll_field_id1;
				if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				select field_name into :ls_fld_nm2 from sys_fields where field_id = :ll_field_id2;
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
				
				//ref 1 data
				//datatype and lookup field
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id1;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id1;

				ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
					ls_fld_type = "C"
				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
					ls_fld_type = "D"
				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
					ls_fld_type = "N"
				ELSEIF ls_fld_type = "!" THEN
					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
					CONTINUE
				ELSE				
					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
					Return -1
				END IF
				//data value
				choose case ls_fld_type
					case "C","V"
						ls_value1 = adw.GetItemString( i, ls_fld_nm )
					case "N", "I"
						ls_value1 = string(adw.GetItemnumber( i, ls_fld_nm ))
					case "D"
						ls_value1 = string(adw.GetItemdatetime( i, ls_fld_nm ))
					case else
						ls_value1 = ""
				end choose
				//if lookup get lookup value
//					MessageBox("ls_lookup_type 1", ls_lookup_type)
//					messagebox("ls_fld_nm",ls_fld_nm)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value1) //convert to number
					select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				elseif ls_lookup_type = "A" then
//					messagebox("in","addr lookup")
//					MessageBox("ls_value1 a", ls_value1)
					ll_new_value = long(ls_value1)
					select entity_name into :ls_value1 from address_lookup where lookup_code = :ll_new_value;
					//MessageBox("ls_value1 after lookup", ls_value1)
				end if
				
	
				//reference 2 info
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id2;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id2;

				ls_fld_type = Upper( adw.Describe( ls_fld_nm2 + ".ColType" ) )
				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
					ls_fld_type = "C"
				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
					ls_fld_type = "D"
				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
					ls_fld_type = "N"
				ELSEIF ls_fld_type = "!" THEN
					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
					CONTINUE
				ELSE				
					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
					Return -1
				END IF
				
				choose case ls_fld_type
					case "C","V"
						ls_value2 = adw.GetItemString( i, ls_fld_nm2 )
					case "N", "I"
						ls_value2 = string(adw.GetItemnumber( i, ls_fld_nm2 ))
					case "D"
						ls_value2 = string(adw.GetItemdatetime( i, ls_fld_nm2 ))
					case else
						ls_value2 = ""
				end choose		
				//MessageBox("ls_lookup_type 2", ls_lookup_type)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value2)
					select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
				elseif ls_lookup_type = "A" then
					ll_new_value = long(ls_value2)
					select entity_name into :ls_value2 from address_lookup where lookup_code = :ll_new_value;
				end if
				//check for nulls
				if isnull(ls_value1) then ls_value1  = ""
				if isnull(ls_value2) then ls_value2  = ""
				ls_new_value = ls_value1 + "-" + ls_value2
				ls_new_value = MidA(ls_new_value,1,100)
				ls_old_value = ls_new_value
		end choose
		
		ll_seq_rc = lds_last_seq_no.Retrieve( ll_rec_id, ll_field_id )
	//	messagebox("ls_new_value",ls_new_value)
		IF ll_seq_rc > 0 THEN
			ll_seq_no = lds_last_seq_no.GetItemNumber(1, "last_seq_no" ) 
		elseif ll_seq_rc < 0 THEN
		//	messagebox("seq", "fucked up")
		END IF
		IF ll_seq_no = 0 OR IsNull( ll_seq_no ) THEN
			ll_seq_no = 1
		ELSE
			ll_seq_no++
		END IF
//		choose case ls_fld_type
//			case "C","V"
//				ls_old_value = adw.GetItemString( i, ls_fld_nm ,delete!,true)
//			case "N", "I"
//				ls_old_value = string(adw.GetItemnumber( i, ls_fld_nm ,delete!,true))
//			case "D"
//				ls_old_value = string(adw.GetItemdatetime( i, ls_fld_nm ,delete!,true))
//			case else
//				ls_old_value = ""
//		end choose
		li_nr = lds_sys_audit.InsertRow( 0 )
		lds_sys_audit.SetItem( li_nr, "rec_id", ll_rec_id )
		lds_sys_audit.SetItem( li_nr, "prac_id", adw.GetItemNumber( i, "prac_id" ) )					
		lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )										
		lds_sys_audit.SetItem( li_nr, "table_id", li_table_id )
		lds_sys_audit.SetItem( li_nr, "field_id", 1001 )
		lds_sys_audit.SetItem( li_nr, "old_value", ls_old_value )
		lds_sys_audit.SetItem( li_nr, "new_value", "Deleted" )
		lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
		lds_sys_audit.SetItem( li_nr, "audit_type", "D" )					
		lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Today(), Now() ) )
		lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 0 )
//	else
//		 if isnull(adw.GetItemStatus( i, 0, Primary! )) then
//		 //	messagebox("of_audit field","null status")
//		elseif adw.GetItemStatus( i, 0, Primary! ) = notmodified! then
//			//messagebox("of_audit field","not mod - row#" + string(i))
//		end if
	END IF
END FOR

//if lds_sys_audit.rowcount() > 1 then maha 102003 trap not completed for multiple staff cat records
//	for i = 1 to ds_sys_audit.rowcount()
//		lds_sys_audit.getItemnumber( i ,"rec_id" )
//end if

IF lds_sys_audit.Update() = -1 THEN
	//MessageBox("", "Update to sys_audit table Failed!")
	MessageBox("of_field_audit", "Failed to update sys_audit table!")
	Return -1
END IF

COMMIT USING SQLCA;

RETURN 1
end function

public function integer of_record_validation (u_dw a_dw);Integer i
Integer li_rc
Integer li_last_row
Integer li_year_from
Integer li_year_thru
Integer li_found
Integer li_cnt
Long ll_val
Long ll_linkval
String ls_val
DataWindowChild dwchild

a_dw.AcceptText()
li_rc = a_dw.RowCount()
li_last_row = a_dw.GetRow()
CHOOSE CASE is_table_name
	CASE "pd_training"
		FOR i = 1 TO li_rc
			li_year_from = a_dw.GetItemNumber( i, "year_from" )
			li_year_thru = a_dw.GetItemNumber( i, "year_thru" )
			IF IsNull( li_year_from ) AND IsNull( li_year_thru ) THEN
				a_dw.SetRow( i )
				a_dw.ScrollToRow( i )
				a_dw.SetColumn( "year_from" )
				MessageBox("Validation Error", "Both the Year From and Year Thru fields are blank. At least one must be filled.  Please Correct!" )
				Return -1				
			END IF
		END FOR					

	CASE "pd_other_affill"
		FOR i = 1 TO li_rc
			li_year_from = a_dw.GetItemNumber( i, "year_from" )
			li_year_thru = a_dw.GetItemNumber( i, "year_thru" )
			IF IsNull( li_year_from ) AND IsNull( li_year_thru ) THEN
				a_dw.SetRow( i )
				a_dw.ScrollToRow( i )
				a_dw.SetColumn( "year_from" )
				MessageBox("Validation Error", "Both the Year From and Year Thru fields are blank. At least one must be filled.  Please Correct!" )
				Return -1				
			END IF
		END FOR			
	CASE "pd_acedemic_appointments"
		FOR i = 1 TO li_rc		
			li_year_from = a_dw.GetItemNumber( i, "year_from" )
			li_year_thru = a_dw.GetItemNumber( i, "year_thru" )
			IF IsNull( li_year_from ) AND IsNull( li_year_thru ) THEN
				a_dw.SetRow( i )
				a_dw.ScrollToRow( i )
				a_dw.SetColumn( "year_from" )
				MessageBox("Validation Error", "Both the Year From and Year Thru fields are blank. At least one must be filled.  Please Correct!" )
				Return -1				
			END IF			
		END FOR			
	CASE "pd_hosp_affil"
		//\/maha 010301 code removed per pix request
//		FOR i = 1 TO li_rc		
//			li_year_from = a_dw.GetItemNumber( i, "year_from" )
//			li_year_thru = a_dw.GetItemNumber( i, "year_thru" )
//			IF IsNull( li_year_from ) AND IsNull( li_year_thru ) THEN
//				a_dw.SetRow( i )
//				a_dw.ScrollToRow( i )
//				a_dw.SetColumn( "year_from" )
//				MessageBox("Validation Error", "Both the Year From and Year Thru fields are blank. At least one must be filled.  Please Correct!" )
//				Return -1				
//			END IF	
//			END FOR					
		//maha changed to look for hosp/facility link 011701
//		FOR i = 1 TO li_rc
//			ll_val = a_dw.GetItemNumber( i, "rec_id" )
//			select count(facility_id)
//			into :ll_linkval
//			from pd_hosp_facility_link
//			where hosp_affil_id = :ll_val and primary_hosp = 1;
//			//messagebox(":ll_linkval",ll_linkval)
//
//		IF ll_linkval < 1 THEN
//			MessageBox("Validation Error", "No hospital is setup as a primary hospital for a facility.  Please Correct!" )
//			Return -1
//		END IF		
//		IF ll_linkval > 1 THEN
//			MessageBox("Validation Error", "You have more than one hospital setup as a primary hospital for a facility.  Please Correct!" )
//			Return -1
//		END IF
//		END FOR	
//		CASE "pd_hosp_facility_link"
//			messagebox("","pd_hosp_facility_link")
END CHOOSE
		//\maha
RETURN 1
end function

public function integer of_update_dddw (u_dw a_dw_detail, u_dw a_dw_browse);n_ds lds_lookup_fields
Integer li_col_cnt
Integer i
String ls_table_name
String ls_fld_nm
String ls_lookup_code
DataWindowChild dwchild

ls_table_name = a_dw_detail.Object.DataWindow.Table.UpdateTable

lds_lookup_fields = CREATE n_ds
lds_lookup_fields.DataObject = "d_lookup_fields"
lds_lookup_fields.of_SetTransObject( SQLCA )
li_col_cnt = lds_lookup_fields.Retrieve( ls_table_name )

FOR i = 1 TO li_col_cnt
	//ls_fld_nm = Mid( ls_table_name, 5, 100) + "_" + lds_lookup_fields.GetItemString( i, "field_name" )	
	ls_fld_nm = lds_lookup_fields.GetItemString( i, "field_name" )
	ls_lookup_code = lds_lookup_fields.GetItemString( i, "lookup_code" )
	//detail dw
	IF a_dw_detail.GetChild( ls_fld_nm, dwchild ) = 1 THEN
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( ls_lookup_code )
	END IF
	//browse dw
	IF a_dw_browse.GetChild( ls_fld_nm, dwchild ) = 1 THEN
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( ls_lookup_code )
	END IF
END FOR

RETURN 1
end function

public function integer of_create_dynamic_dw_browse (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_browse);SetPointer(HourGlass!)

Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
Long ll_detail_height
DataWindowChild dwchild
DataWindowChild dwchild_browse

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

of_setup_cache()

IF gnv_app.of_get_field_object_cache()  THEN
	ids_screen_fields.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
								     " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.Filter()
	li_row_cnt = ids_screen_fields.RowCount()


	ids_screen_objects.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
									     " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_objects.Filter()								
	li_obj_cnt = ids_screen_objects.RowCount()
ELSE
	ids_screen_fields.DataObject = "d_screen_fields"
	ids_screen_fields.of_SetTransObject( SQLCA )
	li_row_cnt = ids_screen_fields.Retrieve( ai_data_view_id, ai_screen_id )

	ids_screen_objects.DataObject = "d_screen_objects"
	ids_screen_objects.of_SetTransObject( SQLCA )
	li_obj_cnt = ids_screen_objects.Retrieve( ai_data_view_id, ai_screen_id )
END IF


ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0


//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	is_table_name = ls_table_name
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
	li_key_cnt ++
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "prac_id"
	END IF

	li_key_cnt ++
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	END IF
END FOR

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )


//CREATE SYNTAX FOR BROWSE DW
ls_grey = String(rgb(192,192,192))
ls_white = String(rgb(255,255,255))
ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_grey + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF

adw_browse.SetRedraw(False)

adw_browse.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	adw_browse.SetRedraw(True)
	RETURN -1
END IF
	

adw_browse.of_SetTransObject( SQLCA )
li_prac_row_cnt = adw_browse.Retrieve()


//adw_browse.Object.DataWindow.Detail.Height= 5000
//adw_browse.Modify("active_status.Initial='1'")

FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	//visible
//	IF ab_screen_painter THEN
//		IF ids_screen_fields.GetItemString(i, "") = "N" THEN
//			adw_browse.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
//			adw_browse.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
//			adw_browse.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
//		ELSE
//			adw_browse.Modify(ls_dw_field_names[i] + ".color = '0'") 
//			adw_browse.Modify(ls_dw_field_names[i] + "_t.color = '0'")
//			adw_browse.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 		
//		END IF
//	END IF

//	IF ab_screen_painter THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
//		adw_browse.Modify( ls_dw_field_names[i] + ".dbname = '" + String( i * 10) + "'" )
//	ELSE
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		//adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )		
//	END IF
	adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )

	adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	//bold or not?
	adw_browse.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	

	adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	//adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	//adw_browse.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	//adw_browse.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	//IF li_fld_width < li_fld_label_width THEN
	//	adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
	//ELSE
	//	adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
	//END IF

	
//	IF ls_field_x[i] = "0" THEN
//		adw_browse.Modify( ls_dw_field_names[i] + ".x = 750")
//		adw_browse.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )
//
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.x = 100")
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
//	ELSE
//		adw_browse.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
//		adw_browse.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )
//
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
//	END IF
//
//	//tag value set to field id
	//adw_browse.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	//adw_browse.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	//adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	//adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	//adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	//adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_browse.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
	END IF
	
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
		adw_browse.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_browse.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_browse.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_browse.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
			END IF
		END IF
		
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_browse.GetChild( ls_dw_field_names[i] , dwchild )
		adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )

		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve(ls_lookup_code)
		dwchild.InsertRow(1)
		dwchild.ShareData( dwchild_browse )
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_browse.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_browse.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			adw_browse.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_browse.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			adw_browse.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_browse.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_browse.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_browse.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_browse.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")								
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_browse.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_browse.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_browse.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_browse.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
			END IF
		END IF	
	END IF
END FOR

adw_browse.Modify( "rec_id.visible = '0'")
adw_browse.Modify( "prac_id.visible = '0'")

adw_browse.SetRedraw(True)

//adw_browse.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band"  )


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
//FOR i = 1 TO li_obj_cnt
//	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
//	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
//	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
//	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
//	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
//	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
//	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
//	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
//	CHOOSE CASE ls_obj_type
//		CASE "B"
//			adw_browse.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name )
//		CASE "T"
//			adw_browse.Modify("create text(band=detail text='" + ls_text + "' border='0' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + "_t" )
//	END CHOOSE
//END FOR
//

IF li_prac_row_cnt > 0 THEN 
	adw_browse.SetRow( 1 )
	adw_browse.SelectRow( 1, True )
	adw_browse.SetFocus()
END IF



RETURN 0
end function

public function integer of_create_dynamic_ds_old (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, n_ds adw_detail);SetPointer(HourGlass!)

//This.of_Setup_Cache()
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
Long ll_detail_height
DataWindowChild dwchild

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]


IF gnv_app.of_get_field_object_cache()  THEN
	ids_screen_fields.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
								     " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.Filter()
	li_row_cnt = ids_screen_fields.RowCount()


	ids_screen_objects.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
									     " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_objects.Filter()								
	li_obj_cnt = ids_screen_objects.RowCount()
ELSE
	ids_screen_fields.DataObject = "d_screen_fields"
	ids_screen_fields.of_SetTransObject( SQLCA )
	li_row_cnt = ids_screen_fields.Retrieve( ai_data_view_id, ai_screen_id )

	ids_screen_objects.DataObject = "d_screen_objects"
	ids_screen_objects.of_SetTransObject( SQLCA )
	li_obj_cnt = ids_screen_objects.Retrieve( ai_data_view_id, ai_screen_id )
END IF


ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

//adw_detail.SetRedraw(False)

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	is_table_name = ls_table_name
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
	li_key_cnt ++
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "prac_id"
	END IF

	li_key_cnt ++
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	END IF
END FOR

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

//CREATE SORT ORDER
ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR
//ADD GROUP BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
END IF
ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.Sort()

//CREATE SYNTAX FOR DETAIL DW
ls_grey = String(rgb(192,192,192))
ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"  

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN -1
END IF



adw_detail.of_SetTransObject( SQLCA )
li_prac_row_cnt = adw_detail.Retrieve()

IF li_prac_row_cnt = 0 THEN 
	adw_detail.InsertRow(0)
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF


IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	FOR i = 1 TO li_row_cnt
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
		END IF
	END FOR
END IF

adw_detail.Object.DataWindow.Detail.Height= 5000
adw_detail.Modify("active_status.Initial='1'")

FOR i = 1 TO li_row_cnt
	
	//visible
	IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
		adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
		adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
	ELSE
		adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
		adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
		adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 		
	END IF


	IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
		lb_first_field = False
		is_first_column = ls_dw_field_names[i]
	END IF
	adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )		


	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	


	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
	END IF
	
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
			END IF
		END IF
		
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve(ls_lookup_code)
		dwchild.InsertRow(1)
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")								
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
			END IF
		END IF	
	END IF
END FOR


FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
END FOR

ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//adw_detail.SetRedraw(True)

adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band)"  )


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")")
		CASE "T"
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + "_t)" )
	END CHOOSE
END FOR

IF ls_table_name = "pd_address" THEN
	adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1875' y='300' height='104' width='475' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
END IF


//This.SetRedraw(True)
//Messagebox('', ls_dw_field_names[1])
//adw_detail.SetColumn( ls_dw_field_names[1] )

RETURN 0
end function

public function string of_create_dynamic_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id);SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
integer res //maha110602
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string des
Long ll_detail_height
string widt
DataWindowChild dwchild
DataWindowChild dwchild_browse

ib_create_browse = True

IF adw_detail = adw_browse THEN
	ib_create_browse = False
END IF

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

//UNREGISTER ALL CALENDAR FIELDS
IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_UnRegister()		
END IF

//IF gnv_app.of_get_field_object_cache()  THEN
//	ids_screen_fields.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
//								     " AND screen_id = " + String( ai_screen_id ) )
//	ids_screen_fields.Filter()
//	li_row_cnt = ids_screen_fields.RowCount()
//
//
//	ids_screen_objects.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
//									     " AND screen_id = " + String( ai_screen_id ) )
//	ids_screen_objects.Filter()								
//	li_obj_cnt = ids_screen_objects.RowCount()
//ELSE

	//ids_screen_fields = CREATE n_ds
	//ids_screen_objects = CREATE n_ds
	//ids_screen_fields.DataObject = "d_screen_fields"
	//ids_screen_fields.of_SetTransObject( SQLCA )
	app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
//messagebox("", "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.Filter( )	
	li_row_cnt = ids_screen_fields.RowCount()	
//	ids_screen_fields.DataObject = "d_screen_fields"
//	ids_screen_fields.of_SetTransObject( SQLCA )
//	li_row_cnt = ids_screen_fields.Retrieve( ai_data_view_id, ai_screen_id )
	//ids_screen_objects.DataObject = "d_screen_objects"
	//ids_screen_objects.of_SetTransObject( SQLCA )
	app_filler.ids_screen_objects_cache.ShareData( ids_screen_objects )
	ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_objects.Filter( )
	li_obj_cnt = ids_screen_objects.RowCount()
	
//	ids_screen_objects.DataObject = "d_screen_objects"
//	ids_screen_objects.of_SetTransObject( SQLCA )
//	li_obj_cnt = ids_screen_objects.Retrieve( ai_data_view_id, ai_screen_id )

////END IF


ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

adw_detail.SetRedraw(False)

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	//if i < 2 then messagebox(ls_field_names[i],ls_field_label_height[i])
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )
	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
//li_test = pos(ls_sql_syntax,"prac_id",1)
	//messagebox("pos",li_test)
	//---------Begin Modified by (Appeon)Stephen 08.08.2014 for BugL073101--------
	//if PosA(ls_sql_syntax,"prac_id",1) = 0 then //maha 051503 for lehigh to allow making prac_id visible
	if f_get_pos(ls_sql_syntax, "prac_id", true) < 1 then
	//---------End Modfiied ------------------------------------------------------		
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
		li_key_cnt ++
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "prac_id"
		END IF
	end if
	
	li_key_cnt ++
	if PosA(ls_sql_syntax,"rec_id",1) = 0 then  //maha 051503 to allow making prac_id visible
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		END IF
	end if
	
	IF ids_screen_fields.GetItemNumber(i, "facility_specific" ) = 1 THEN
		li_facility_specific = 1
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".facility_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".facility_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		END IF	
	END IF
	
	//added for tables with seq_no fields   JAD-6/06/02
	IF ai_screen_id = 61 THEN
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".seq_no, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".seq_no"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		END IF	
	END IF	
		
END FOR

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//IF ls_table_name = "pd_address" THEN  // instead of following run 2.0 update group Practice button.
//	ls_sql_syntax = ls_sql_syntax + ", gp_id"
//END IF
//messagebox("", ls_sql_syntax)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
ls_return_syntax = ls_sql_syntax
//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

IF li_facility_specific = 1 THEN
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
END IF

//CREATE SORT ORDER
ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR
//ADD GROUP BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
END IF
ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.Sort()

//CREATE SYNTAX FOR DETAIL DW
ls_grey = "80269524"//String(rgb(192,192,192))
ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"  
//openwithparm( w_sql_msg, ls_sql_syntax )
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN "-1"
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN "-1"
END IF


//CREATE SYNTAX FOR BROWSE DW
IF ib_create_browse THEN
	//ls_grey = String(rgb(192,192,192))
	ls_white = String(rgb(255,255,255))
	ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_grey + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"


	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
		ls_presentation_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN "-1"
	END IF

	adw_browse.Create( ls_dwsyntax_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN "-1"
	END IF
END IF
	

IF NOT ab_screen_painter THEN
	adw_detail.of_SetTransObject( SQLCA )
	li_prac_row_cnt = adw_detail.Retrieve()
END IF

IF li_prac_row_cnt = 0 THEN 
	adw_detail.InsertRow(0)
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
	END IF
ELSE
	IF IsValid( m_pfe_cst_data_entry ) THEN
	//	m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True  maha removed 082503
	END IF
	//of_set_defaults( adw_detail, 1 )
	//adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF


IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	FOR i = 1 TO li_row_cnt		
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.DisplayOnly=Yes")
		END IF
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" then //maha 041404 to allow single fields to be read only
			//adw_detail.Modify(ls_dw_field_names[i] + ".TabSequence = '0'" ) //set below
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'")
		end if
	END FOR
END IF

IF ib_create_browse THEN
	adw_detail.ShareData(adw_browse)
END IF
//messagebox("",  Long( adw_detail.Object.DataWindow.Detail.Height) )
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > 1800 THEN
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > ( adw_detail.Height + 50 ) THEN
adw_detail.Object.DataWindow.Detail.Height= 5000
adw_detail.Modify("active_status.Initial='1'")

FOR i = 1 TO li_row_cnt
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	//visible
	IF ab_screen_painter THEN
		IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
		ELSE
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 		
		END IF
	END IF

	IF ab_screen_painter THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dbname = '" + String( i * 10) + "'" )
	ELSE
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" then //maha 041404
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		else
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )
		end if
			
	END IF
	
	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")	
	END IF
	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	

	if integer(ls_field_label_height[i]) > 120 then //maha added to allow multi line fields to wrap 011504
		//messagebox(ls_dw_field_names[i],ls_field_label_height[i])
		adw_detail.Modify( ls_dw_field_names[i] + ".edit.AutoHScroll = No")
	end if

	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	IF ib_create_browse THEN
		IF li_fld_width < li_fld_label_width THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
		ELSE
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
		END IF
	END IF

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
		adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	END IF
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")						

		IF ib_create_browse THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			adw_browse.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
		END IF
	END IF
		IF UPPER(ls_lookup_field) = "ENTITY_NAME" THEN

		END IF
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")	
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
				END IF
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		

			IF ib_create_browse = True THEN				
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
			END IF
		END IF
		
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		//IF ib_create_browse = True THEN						
			adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )
			dwchild.SetTransObject( SQLCA )
		//END IF

		IF ls_lookup_type = "A" THEN
			app_filler.ids_address_dddw.ShareData( dwchild )
			dwchild.SetFilter( "lookup_name = '" + ls_lookup_code + "'" )
			dwchild.Filter()	
		ELSE
			dwchild.Retrieve(ls_lookup_code)
		END IF		
		dwchild.InsertRow(1)
		dwchild.ShareData( dwchild_browse )
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
			ELSEIF ls_mask[i] = "#####-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				END IF
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				END IF
			END IF
		END IF	
	END IF
END FOR


FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	IF ib_create_browse = True THEN					
		adw_browse.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
		adw_browse.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	END IF
END FOR

IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_Register(adw_detail.iuo_calendar.DDLB)		
	adw_detail.of_SetReqColumn(TRUE)
END IF

ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//messagebox("ls_detail_band_height",ls_detail_band_height)

adw_detail.SetRedraw(True)

adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band)"  )

//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name +")")
		CASE "T"
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + "_t)" )
	END CHOOSE
END FOR

IF ls_table_name = "pd_address" THEN
	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
	
	//address drop down
	
	adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
	
	integer set1
	select set_1
	into :set1
	from icred_settings;
	
	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
		adw_detail.Modify( "street.dddw.useasborder = Yes")			
		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
		//adw_detail.Modify( "street.dddw.Lines= 15")
		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
	end if
	
	//add drop down for billing address
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.Required = No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
	res  = adw_detail.GetChild( "billing_address_id", dwchild )
	if res = 1 then
		IF LenA( ls_retval ) = 0 THEN
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( al_prac_id )
		END IF
//		des = dwchild.Describe("DataWindow.Objects")
//			openwithparm(w_sql_msg,des)
		dwchild.InsertRow( 1 )
	
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
	end if
	
END IF

//\/maha 062701
IF ls_table_name = "pd_references" THEN
	select set_5 into :li_set from icred_settings;
	if li_set = 0 then
		adw_detail.Modify("create button(band=detail text='Select Peer' filename=''action='0' border='1' color='128' x='1102' y='1285' height='85' width='400' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")
	end if
end if
//\maha

IF li_prac_row_cnt = 0 THEN 
	of_set_defaults( adw_detail, 1 )
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

//adw_detail.Object.DataWindow.Detail.Height.AutoSize  //maha 092702 playing with size
//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height))
//messagebox("ls_detail_band_height",ls_detail_band_height)

RETURN ls_return_syntax

end function

public function integer of_create_dynamic_ds (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, n_ds adw_detail, integer ai_facility_id, n_tr atr_sqlca);
SetPointer(HourGlass!)

//This.of_Setup_Cache()
Integer li_retval
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
string ls_sqlsyn
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string ls_sort_fields //maha 032204
string ls_dir //maha 032204
Long ll_detail_height
DataWindowChild dwchild

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]


of_setup_cache()

ids_screen_fields.DataObject = "d_screen_fields"
ids_screen_fields.of_SetTransObject( ATR_SQLCA )
li_row_cnt = ids_screen_fields.Retrieve( ai_data_view_id, ai_screen_id )




ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	//IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
	//	CONTINUE
	//END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	is_table_name = ls_table_name
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

IF ai_screen_id = 2 THEN
	ls_sql_syntax = ls_sql_syntax + ", pd_address_link.home_address, pd_address_link.primary_office, pd_address_link.additional_office, " +&
	"pd_address_link.billing, pd_address_link.mailing, pd_address.rec_id"
ELSEIF ai_screen_id = 31 THEN
	ls_sql_syntax = ls_sql_syntax + ", pd_address_link.home_address, pd_address_link.primary_office, pd_address_link.additional_office, " +&
	"pd_address_link.billing, pd_address_link.mailing, pd_address_2.rec_id"
END IF
//\/maha 100702 for primary hosp link
IF ai_screen_id = 10 THEN
	ls_sql_syntax = ls_sql_syntax + ", pd_hosp_facility_link.primary_hosp, pd_hosp_facility_link.hosp_affil_id"
END IF
//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
	li_key_cnt ++
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "prac_id"
	END IF

	li_key_cnt ++
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	END IF		
END FOR

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)


//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	FOR i = 1 TO li_row_cnt
		IF ai_screen_id = 2 OR ai_screen_id = 31  or ai_screen_id = 10 THEN
			ls_dw_field_names[i] = ls_table_field_names[i]			
			IF Upper( gs_user_id ) <> 'MASTER' THEN
				ls_dw_field_names[i] = ls_field_names[i]							
			END IF
		ELSE
			ls_dw_field_names[i] = ls_field_names[i]
		END IF
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

IF ai_screen_id = 2 OR ai_screen_id = 31 THEN
	ls_sql_syntax = ls_sql_syntax + ", pd_address_link"
END IF

IF ai_screen_id = 10 then
	ls_sql_syntax = ls_sql_syntax + ", pd_hosp_facility_link"
END IF

//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

IF ls_table_name = "pd_affil_staff_cat" OR ls_table_name = "pd_affil_dept"  OR ls_table_name = "pd_affil_staff_leave" OR ls_table_name = "pd_affil_stat" THEN //pd_affil_stat  added maha 120202
	ls_sql_syntax = ls_sql_syntax + " AND active_status = 1 "
//	messagebox("syntax",ls_sql_syntax)
//	clipboard(ls_sql_syntax)
END IF

IF ids_screen_fields.GetItemNumber(1, "facility_specific" ) = 1  and ai_screen_id <> 43 THEN //exception added for affil stat maha050403
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
ELSEIF ai_screen_id = 2  OR ai_screen_id = 31 THEN
	ls_sql_syntax = ls_sql_syntax + " AND pd_address_link.facility_id = " + String( ai_facility_id )
ELSEIF ai_screen_id = 10 THEN
	ls_sql_syntax = ls_sql_syntax + " AND pd_hosp_facility_link.facility_id = " + String( ai_facility_id )
END IF

IF ai_screen_id = 2 THEN
	ls_sql_syntax = ls_sql_syntax + " AND pd_address_link.address_id = pd_address.rec_id "	

ELSEIF ai_screen_id = 31 THEN
	ls_sql_syntax = ls_sql_syntax + " AND pd_address_link.address_id = pd_address_2.rec_id "
END IF

IF ai_screen_id = 10 THEN
	ls_sql_syntax = ls_sql_syntax + " AND pd_hosp_facility_link.hosp_affil_id = pd_hosp_affil.rec_id "	
END IF

//CREATE SORT ORDER
ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			IF ai_screen_id = 2 THEN
				ls_sort_syntax = ls_sort_syntax + "pd_address." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"
			ELSEIF ai_screen_id = 10 THEN
				ls_sort_syntax = ls_sort_syntax + "pd_hosp_affil." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"
			ELSE
				ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"
			END IF
		ELSE
			IF ai_screen_id = 2 THEN
				ls_sort_syntax = ls_sort_syntax + "pd_address." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"
			ELSEIF ai_screen_id = 10 THEN
				ls_sort_syntax = ls_sort_syntax + "pd_hosp_affil." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"
			ELSE
				ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"
			END IF		
		END IF
		li_sort_data_cnt ++
	END IF
END FOR

//ADD order BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
ELSE //if no sort fields sort on rec_id
	IF ai_screen_id = 2  OR ai_screen_id = 31 THEN //maha added 032204
		ls_sql_syntax = ls_sql_syntax + " ORDER BY pd_address.rec_id "	
	ELSEIF ai_screen_id = 10 THEN
		ls_sql_syntax = ls_sql_syntax + " ORDER BY pd_hosp_affil.rec_id"
	else
		ls_sql_syntax = ls_sql_syntax + " ORDER BY rec_id"
	end if
END IF


//messagebox("syntax",ls_sql_syntax)
//	clipboard(ls_sql_syntax)
//CREATE SYNTAX FOR DETAIL DW
ls_grey = String(rgb(192,192,192))
ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"  

ls_dwsyntax_str = ATR_SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN -1
END IF

//ls_sqlsyn = adw_detail.describe("datawindow.Objects")
//	openwithparm(w_sql_msg,ls_sqlsyn)
//messagebox("", ls_Sql_syntax)

adw_detail.of_SetTransObject( ATR_SQLCA )
li_prac_row_cnt = adw_detail.Retrieve()

//messagebox("li_prac_row_cnt", li_prac_row_cnt)
//messagebox("", adw_detail.GetsqlSelect())

//IF li_prac_row_cnt = 0 THEN 
//	adw_detail.InsertRow(0)
////	of_set_defaults( adw_detail, 1 )
//	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
//END IF
//

//adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
//adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
//adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
//FOR i = 1 TO li_row_cnt
//	adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
//	IF Pos( ls_dw_field_names[i], "prac_id" ) > 0  OR Pos( ls_dw_field_names[i], "rec_id" ) > 0 THEN
//		adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
//	END IF
//END FOR

adw_detail.Object.DataWindow.Detail.Height= 5000
//adw_detail.Modify("active_status.Initial='1'")

FOR i = 1 TO li_row_cnt

	//visible
//	IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
//		adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
//		adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
//		adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
//	ELSE
//		adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
//		adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
//		adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 		
//	END IF
//

//	IF Len(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
//		lb_first_field = False
//		is_first_column = ls_dw_field_names[i]
//	END IF
//	adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )		
//
//
//	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")
//
//	//bold or not?
//	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	
//

//	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
//	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
//	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
//	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
//	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	
//	IF ls_field_x[i] = "0" THEN
//		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
//		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )
//
//		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
//		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
//	ELSE
//		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
//		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )
//
//		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
//		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
//	END IF
//
	//tag value set to field id
	//adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	//adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	//adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	//adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	IF ls_dw_field_names[i] = "active_status" THEN
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		//adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
	END IF
	
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")			
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		//adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		//IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
		//	adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
		//	adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
		//END IF	

		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup_for_lookup_code'")			
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
			END IF
		END IF
		
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		

		//messagebox("", ls_dw_field_names[i] )
		//debugbreak()
		//MESSAGEBOX("", ADW_DETAIL.describe(ls_dw_field_names[i] + ".color" ) )

		li_retval = adw_detail.GetChild( ls_dw_field_names[i] , dwchild )
		IF li_retval = -1 THEN
			MessageBox( ls_dw_field_names[i], "dwchild error in of_create_dynamic_ds function." )
		END IF
	
		dwchild.SetTransObject( ATR_SQLCA )
		//messagebox("", ls_lookup_code )
		IF ls_lookup_type = "C" THEN
			dwchild.Retrieve(ls_lookup_code)	
		END IF
		
//	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
//		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
//		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
//			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
//			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
//		END IF	
//		IF ls_mask[i] <> "" THEN
//			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
//			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
//			adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
//			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
//			IF ls_mask[i] = "##" THEN
//				FOR m = 1 TO 12
//					ls_month = String(m)
//					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
//				END FOR
//				m1 = 0
//				FOR m = 13 TO 21
//					m1++
//					ls_month = "0" + String(m1)
//					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
//				END FOR
//				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
//				
//			ELSEIF ls_mask[i] = "(###)###-####" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )
//			ELSEIF ls_mask[i] = "###-##-####" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")								
//			ELSEIF ls_mask[i] = "####" THEN
//				li_index = 0
//				FOR m = 1880 TO 2050
//					li_index++
//					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
//				END FOR
//				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
//				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
//			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
//				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
//				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
//			ELSEIF ls_mask[i] = "#,##0.00" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
//			END IF
//		END IF	
	END IF
END FOR


//CREATE SORT ORDER //maha remodified this code 032204 for resetting the sort in application printing
ids_screen_fields.SetSort( "sort_field A" )
ids_screen_fields.Sort()
ls_sort_fields = ""
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN //set direction
			ls_dir = " D,"
		else
			ls_dir = " A,"
		end if
		IF ai_screen_id = 2 or ai_screen_id = 31 THEN
			if upper(gs_user_id) = "MASTER" then
				ls_sort_fields = ls_sort_fields + "pd_address_" + ids_screen_fields.GetItemString( i, "db_field_name" ) + ls_dir
			else
				ls_sort_fields = ls_sort_fields + ids_screen_fields.GetItemString( i, "db_field_name" ) + ls_dir
			end if
		elseif ai_screen_id = 10 THEN
			if upper(gs_user_id) = "MASTER" then
				ls_sort_fields = ls_sort_fields + "pd_hosp_affil_" + ids_screen_fields.GetItemString( i, "db_field_name" ) + ls_dir	
			else
				ls_sort_fields = ls_sort_fields + ids_screen_fields.GetItemString( i, "db_field_name" ) + ls_dir
			end if
		ELSE
			ls_sort_fields = ls_sort_fields + ids_screen_fields.GetItemString( i, "db_field_name" ) + ls_dir							
		END IF
		
		li_sort_data_cnt ++
	END IF
END FOR


IF li_sort_data_cnt > 0 THEN
	ls_sort_fields = MidA( ls_sort_fields, 1, LenA( ls_sort_fields )-1 ) //take out the last comma
ELSE
	ls_sort_fields = "rec_id A" //set to recid then overwrite for exceptions
	IF ai_screen_id = 2 or ai_screen_id = 31 THEN
		if upper(gs_user_id) = "MASTER" then
			ls_sort_fields = "pd_address_rec_id A"
		end if
	ELSEIF ai_screen_id = 10 THEN
		if upper(gs_user_id) = "MASTER" then
			ls_sort_fields = "pd_hosp_affil.rec_id A"
		end if
	END IF
END IF

adw_detail.SetSort( ls_sort_fields)

//MessageBox("", ls_sort_fields )
is_sort_syntax = ls_sort_fields
adw_detail.Sort()

//Integer li_rc
//li_rc = adw_detail.RowCount()
//for i = 1 TO li_rc
//	MessageBox(String( i ), adw_detail.GetItemNumber( i, "pd_address_rec_id" ))
//END FOR
//
//


//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)


RETURN 0
end function

public function integer of_refresh_cache ();DateTime ldt_lookup_cache
DateTime ldt_screen_cache
DateTime ldt_screen_obj_cache

if gi_cache_set = 0 then //maha 092701
Select lookup_cache INTO :ldt_lookup_cache FROM ids;
Select screen_cache INTO :ldt_screen_cache FROM ids;
Select screen_obj_cache INTO :ldt_screen_obj_cache FROM ids;

IF ldt_lookup_cache <> gdt_lookup_cache THEN
	app_filler.ids_address_dddw.Retrieve()
END IF

IF ldt_screen_cache <> gdt_screen_cache THEN
		//MessageBox("", "Screen Cache Refreshed")
	app_filler.ids_screen_fields_cache.Retrieve()
END IF


IF ldt_screen_obj_cache <> gdt_screen_obj_cache THEN
	app_filler.ids_screen_objects_cache.Retrieve()
END IF
end if

Return 1
end function

public function integer of_get_next_seq_no (string as_dw, long al_rec_id);Integer li_row_cnt
Long ll_seq_no
n_ds l_ds

l_ds = CREATE n_ds

CHOOSE CASE as_dw
	CASE "department"
		l_ds.DataObject = "d_last_affill_dept_seq_no"
	CASE "staff cat"
		l_ds.DataObject = "d_last_affill_last_cat_seq_no"		
	CASE "comm review"
		l_ds.DataObject = "d_last_affill_comm_review_seq_no"			
	CASE "leave"
		l_ds.DataObject = "d_last_affill_leave"			
END CHOOSE


l_ds.SetTransObject( SQLCA )
li_row_cnt = l_ds.Retrieve( al_rec_id )
IF li_row_cnt > 0 THEN
	ll_seq_no = l_ds.GetItemNumber( 1, "last_seq_no" )
ELSE
	ll_seq_no = 0
END IF

IF IsNull( ll_seq_no ) THEN
	ll_seq_no = 1 
END IF

DESTROY l_ds


RETURN ll_seq_no

end function

public function integer of_add_address_link (long al_prac_id, integer ai_facility_id);//called from net dev of_add_multi

Integer li_address_cnt
Integer i
Integer li_nr
Long ll_address_id
n_ds lds_address_link
n_ds lds_all_addresses

lds_address_link = CREATE n_ds
lds_address_link.DataObject = "d_address_link"
long ll_addr_id //maha 02-26-01
integer cnt

lds_address_link.of_SetTransObject( SQLCA )

lds_all_addresses = CREATE n_ds
lds_all_addresses.DataObject = "d_address_link_all_addresses"
lds_all_addresses.of_SetTransObject( SQLCA )
li_address_cnt = lds_all_addresses.Retrieve( al_prac_id )

//for each address put an entry in the address link table for the new facility being added
FOR i = 1 TO li_address_cnt
	//\/maha 02-26-01 check to see if link already exists 
	ll_addr_id = lds_all_addresses.GetItemNumber( i, "rec_id" )	
	select count(*)
	into :cnt
	from pd_address_link
	where prac_id = :al_prac_id and facility_id = :ai_facility_id and address_id = :ll_addr_id;
	if cnt > 0 then continue
	//\maha
	li_nr = lds_address_link.InsertRow( 0 )	
	lds_address_link.SetItem( li_nr, "prac_id", al_prac_id )
	lds_address_link.SetItem( li_nr, "address_id", ll_addr_id )
	lds_address_link.SetItem( li_nr, "facility_id", ai_facility_id )
END FOR

IF lds_address_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating address link table." )
	DESTROY lds_address_link
	DESTROY lds_all_addresses
	RETURN -1
END IF


DESTROY lds_address_link
DESTROY lds_all_addresses

RETURN 1


end function

public function string of_create_dynamic_profile_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id);SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_italic
String ls_weight
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_label_font_weight[]
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_field_underline[]
String ls_field_label_underline[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
Long ll_detail_height
string widt
DataWindowChild dwchild
DataWindowChild dwchild_browse

ib_create_browse = True

IF adw_detail = adw_browse THEN
	ib_create_browse = False
END IF

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

//UNREGISTER ALL CALENDAR FIELDS

//IF gnv_app.of_get_field_object_cache()  THEN
//	ids_screen_fields.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
//								     " AND screen_id = " + String( ai_screen_id ) )
//	ids_screen_fields.Filter()
//	li_row_cnt = ids_screen_fields.RowCount()
//
//
//	ids_screen_objects.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
//									     " AND screen_id = " + String( ai_screen_id ) )
//	ids_screen_objects.Filter()								
//	li_obj_cnt = ids_screen_objects.RowCount()
//ELSE

	app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
	ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.Filter( )	
	li_row_cnt = ids_screen_fields.RowCount()	

	app_filler.ids_screen_objects_cache.ShareData( ids_screen_objects )
	ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_objects.Filter( )
	li_obj_cnt = ids_screen_objects.RowCount()
	
//	ids_screen_objects.DataObject = "d_screen_objects"
//	ids_screen_objects.of_SetTransObject( SQLCA )
//	li_obj_cnt = ids_screen_objects.Retrieve( ai_data_view_id, ai_screen_id )

////END IF


ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

adw_detail.SetRedraw(False)


//messagebox("", li_row_cnt )
//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_underline[i] = ids_screen_fields.GetItemString( i, "data_view_fields_field_underline" ) 
	ls_field_label_underline[i] = ids_screen_fields.GetItemString( i, "data_view_fields_label_underline" ) 	
	ls_label_font_weight[i] = String( ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) 	 )
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
	li_key_cnt ++
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "prac_id"
	END IF

	li_key_cnt ++
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	END IF
	
	IF ids_screen_fields.GetItemNumber(i, "facility_specific" ) = 1 THEN
		li_facility_specific = 1
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".facility_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".facility_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		END IF	
	END IF
	
	//added for tables with seq_no fields   JAD-6/06/02
	IF ai_screen_id = 61 THEN
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".seq_no, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".seq_no"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		END IF	
	END IF	
		
END FOR

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//IF ls_table_name = "pd_address" THEN  // instead of following run 2.0 update group Practice button.
//	ls_sql_syntax = ls_sql_syntax + ", gp_id"
//END IF
//messagebox("", ls_sql_syntax)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
ls_return_syntax = ls_sql_syntax
//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

IF li_facility_specific = 1 THEN
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
END IF

//CREATE SORT ORDER
ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR
//ADD GROUP BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
END IF
ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.Sort()

//CREATE SYNTAX FOR DETAIL DW

ls_grey = "80269524"//String(rgb(192,192,192))
ls_presentation_str = "style(type=form)" + " Column(Border=2 ) Datawindow(Color=16777215 )" + "Text(Background.Color=16777215)"  
//openwithparm( w_sql_msg, ls_sql_syntax )
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN "-1"
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN "-1"
END IF




//CREATE SYNTAX FOR BROWSE DW
ib_create_browse = False
IF ib_create_browse THEN
	//ls_grey = String(rgb(192,192,192))
	ls_white = String(rgb(255,255,255))
	ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_grey + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"


	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
		ls_presentation_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN "-1"
	END IF

	adw_browse.Create( ls_dwsyntax_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN "-1"
	END IF
END IF
	

IF NOT ab_screen_painter THEN
	adw_detail.of_SetTransObject( SQLCA )
	li_prac_row_cnt = adw_detail.Retrieve()
END IF

IF li_prac_row_cnt = 0 THEN 
	adw_detail.InsertRow(0)
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'Enabled', False)
		//---------End Modfiied ------------------------------------------------------
	END IF
ELSE
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'Enabled', True)
		//---------End Modfiied ------------------------------------------------------
	END IF
	//of_set_defaults( adw_detail, 1 )
	//adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF


IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	FOR i = 1 TO li_row_cnt		
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
		END IF
	END FOR
END IF

IF ib_create_browse THEN
	adw_detail.ShareData(adw_browse)
END IF
//messagebox("",  Long( adw_detail.Object.DataWindow.Detail.Height) )
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > 1800 THEN
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > ( adw_detail.Height + 50 ) THEN
//adw_detail.Object.DataWindow.Detail.Height= 5000
adw_detail.Modify("active_status.Initial='1'")

FOR i = 1 TO li_row_cnt
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	//visible
	IF ab_screen_painter THEN
		IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
		ELSE
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 		
		END IF
	END IF

	IF ab_screen_painter THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dbname = '" + String( i * 10) + "'" )
	ELSE
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )		
	END IF
	
	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")	
	END IF
	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.Underline = '" + ls_field_label_underline[i] + "'") 
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.Underline = '" + ls_field_underline[i] + "'") 	
	
	IF adw_detail.tag = "Preview" THEN
		adw_detail.Modify( ls_dw_field_names[i] + "_t.Border = '0'")
		adw_detail.Modify( ls_dw_field_names[i] + ".Border = '0'")
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + "_t.Border = '2'")
		adw_detail.Modify( ls_dw_field_names[i] + ".Border = '2'")		
	END IF

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + String(ls_label_font_weight[i]) + "'")	

	//adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	


	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	IF ib_create_browse THEN
		IF li_fld_width < li_fld_label_width THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
		ELSE
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
		END IF
	END IF

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
		adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	END IF
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = No")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")						

		IF ib_create_browse THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			adw_browse.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Required = No")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
		END IF
	END IF
		IF UPPER(ls_lookup_field) = "ENTITY_NAME" THEN

		END IF
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = No")
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")	
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
				END IF
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		

			IF ib_create_browse = True THEN				
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
			END IF
		END IF
		
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		//IF ib_create_browse = True THEN						
			adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )
			dwchild.SetTransObject( SQLCA )
		//END IF

		IF ls_lookup_type = "A" THEN
			app_filler.ids_address_dddw.ShareData( dwchild )
			dwchild.SetFilter( "lookup_name = '" + ls_lookup_code + "'" )
			dwchild.Filter()	
		ELSE
			dwchild.Retrieve(ls_lookup_code)
		END IF		
		dwchild.InsertRow(1)
		dwchild.ShareData( dwchild_browse )
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
			ELSEIF ls_mask[i] = "#####-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				END IF
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				END IF
			END IF
		END IF	
	END IF
END FOR


FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	IF ib_create_browse = True THEN					
		adw_browse.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
		adw_browse.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	END IF
END FOR


//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//messagebox("ls_detail_band_height",ls_detail_band_height)

adw_detail.SetRedraw(True)

//adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band"  )


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_weight =  String( ids_screen_objects.GetItemNumber(i, "object_bold")  )
	ls_italic =  String( ids_screen_objects.GetItemNumber(i, "object_italic")  )	
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name +")")
		CASE "T"
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + "_t)" )
			adw_detail.Modify( ls_obj_name + "_t.alignment='"  + ls_justification + "'" )
			adw_detail.Modify( ls_obj_name + "_t.font.weight='"  + ls_weight + "'" )			
			adw_detail.Modify( ls_obj_name + "_t.font.italic='"  + ls_italic + "'" )						
	END CHOOSE
END FOR

IF ls_table_name = "pd_address" THEN
	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
	
	//address drop down
	
	//adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
	
	integer set1
	select set_1
	into :set1
	from icred_settings;
	
	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
		adw_detail.Modify( "street.dddw.useasborder = Yes")			
		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
		//adw_detail.Modify( "street.dddw.Lines= 15")
		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
	end if
	
	//add drop down for billing address
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.Required = No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
	adw_detail.GetChild( "billing_address_id", dwchild )
	IF LenA( ls_retval ) = 0 THEN
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( al_prac_id )
	END IF
	
//	dwchild.InsertRow( 1 )
//	dwchild.SetItem( 1, "pd_address_street", "N/A" )	
//	dwchild.SetItem( 1, "pd_address_city", "" )
//	dwchild.SetItem( 1, "code_lookup_code", "" )
//	dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
//	dwchild.InsertRow( 1 )
//	dwchild.SetItem( 1, "pd_address_street", "Same" )	
//	dwchild.SetItem( 1, "pd_address_city", "" )
//	dwchild.SetItem( 1, "code_lookup_code", "" )
//	dwchild.SetItem( 1, "pd_address_rec_id", 0 )
//	dwchild.InsertRow( 1 )
//	dwchild.SetItem( 1, "pd_address_street", "" )	
//	dwchild.SetItem( 1, "pd_address_city", "" )
//	dwchild.SetItem( 1, "code_lookup_code", "" )

	
END IF

//\/maha 062701
IF li_prac_row_cnt = 0 THEN 
	of_set_defaults( adw_detail, 1 )
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

//adw_detail.Object.DataWindow.Detail.Height.AutoSize  //maha 092702 playing with size
//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height))
//messagebox("ls_detail_band_height",ls_detail_band_height)

//adw_detail.Modify("DataWindow.Print.Margin.Bottom='1'")
//adw_detail.Modify("DataWindow.Print.Margin.Top='1'")
//adw_detail.Modify("DataWindow.Print.Margin.Left='1'")
//adw_detail.Modify("DataWindow.Print.Margin.Right='1'")

IF adw_detail.tag = "Preview" THEN
	adw_detail.Modify("DataWindow.Print.Preview=Yes")
	adw_detail.Modify("DataWindow.Print.Preview.Rulers=Yes")
END IF


RETURN ls_return_syntax
end function

public function integer of_get_facil_specific (integer ai_table);//this is for checking if a table is facility specific mmaha 111502

integer li_fs

select facility_specific into :li_fs from sys_tables where table_id = :ai_table;

return li_fs
end function

public function integer of_add_hosp_link (long ai_facility_id, long al_prac_id);//called from net dev of_add_multi  maha 011003

Integer li_hosp_cnt
Integer i
Integer li_nr
Integer li_found
long ll_rec //maha 121702
Long ll_hosp_id
n_ds lds_hosp_link
n_ds lds_all_hosp

lds_hosp_link = CREATE n_ds
lds_hosp_link.DataObject = "d_hf_link"
lds_hosp_link.of_SetTransObject( SQLCA )
lds_hosp_link.Retrieve( al_prac_id )

lds_all_hosp = CREATE n_ds
lds_all_hosp.DataObject = "d_hosp_affil_prac"
lds_all_hosp.of_SetTransObject( SQLCA )
li_hosp_cnt = lds_all_hosp.Retrieve( al_prac_id )

//for each hospital put an entry in the hospital link table for the new facility being added
FOR i = 1 TO li_hosp_cnt
	ll_rec = lds_all_hosp.GetItemNumber( i, "rec_id" )
	debugbreak()
	li_found = lds_hosp_link.Find( "facility_id = " + String( ai_facility_id ) + " and hosp_affil_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF
	li_nr = lds_hosp_link.InsertRow( 0 )	
	lds_hosp_link.SetItem( li_nr, "prac_id", al_prac_id )
	lds_hosp_link.SetItem( li_nr, "hosp_affil_id", ll_rec )
	lds_hosp_link.SetItem( li_nr, "facility_id", ai_facility_id )
END FOR

IF lds_hosp_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating Hospital link table." )
	DESTROY lds_hosp_link
	DESTROY lds_all_hosp
	RETURN -1
END IF


DESTROY lds_hosp_link
DESTROY lds_all_hosp

RETURN 1


end function

public function integer of_add_spec_link (integer al_facil_id, long al_prac_id);//called from net dev of_add_multi maha 011003

Integer li_spec_cnt
Integer i
Integer li_nr
Integer li_found
Long ll_spec_id
long ll_rec
n_ds lds_spec_link
n_ds lds_all_spec

lds_spec_link = CREATE n_ds
lds_spec_link.DataObject = "d_sf_link"
lds_spec_link.of_SetTransObject( SQLCA )
lds_spec_link.Retrieve( al_prac_id )

lds_all_spec = CREATE n_ds
lds_all_spec.DataObject = "d_spec_of_prac"
lds_all_spec.of_SetTransObject( SQLCA )
li_spec_cnt = lds_all_spec.Retrieve( al_prac_id )

//for each specialty put an entry in the specialty link table for the new facility being added
FOR i = 1 TO li_spec_cnt
	ll_rec = lds_all_spec.GetItemNumber( i, "rec_id" ) //maha 121702
	li_found = lds_spec_link.Find( "facility_id = " + String( al_facil_id ) + " and specialty_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF	
	li_nr = lds_spec_link.InsertRow( 0 )	
	lds_spec_link.SetItem( li_nr, "prac_id", al_prac_id )
	lds_spec_link.SetItem( li_nr, "specialty_id", ll_rec )
	lds_spec_link.SetItem( li_nr, "facility_id", al_facil_id )
	lds_spec_link.SetItem( li_nr, "practicing", 582 )
next

IF lds_spec_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating specialty link table." )
	DESTROY lds_spec_link
	DESTROY lds_all_spec
	RETURN -1
END IF


DESTROY lds_spec_link
DESTROY lds_all_spec

RETURN 1


end function

public function string of_get_reference_val (long al_table);string ls_new_value
string ls_value1
string ls_value2
string ls_fld_nm1
string ls_fld_nm2
string ls_fld_type
string ls_fld_type1
string ls_lookup_type
datawindow adw
long ll_field_id1
long ll_field_id2
long ll_new_value
integer i
				
				
				
				
				//get reference field 1
				select reference_field_1 into :ll_field_id1 from data_view_screen where table_id = :al_table and data_view_id = 1;
				if isnull(ll_field_id1) or ll_field_id1 < 1 then ll_field_id1 = 0//lds_audit_fields.GetItemNumber( 1, "field_id" )
				//get reference field 2
				select reference_field_2 into :ll_field_id2  from data_view_screen where table_id = :al_table and data_view_id = 1;
				if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = 0//lds_audit_fields.GetItemNumber( 2, "field_id" )
				//get reference field name 1
				select field_name into :ls_fld_nm1 from sys_fields where field_id = :ll_field_id1;
				if isnull(ls_fld_nm1) or ls_fld_nm1 = "" then ls_fld_nm1 = "" //lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				select field_name into :ls_fld_nm2 from sys_fields where field_id = :ll_field_id2;
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then ls_fld_nm2 = "" //lds_audit_fields.GetItemString( 2, "field_name" )
				
				//ref 1 data
				//datatype and lookup field
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id1;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id1;

				//ls_fld_type = Upper( adw.Describe( ls_fld_nm1 + ".ColType" ) )
//				IF Pos( ls_fld_type, "CHAR" ) > 0 THEN
//					ls_fld_type = "C"
//				ELSEIF Pos( ls_fld_type, "DATE" ) > 0 THEN
//					ls_fld_type = "D"
//				ELSEIF Pos( ls_fld_type, "LONG" ) > 0 OR Pos( ls_fld_type, "DECIMAL" ) > 0 THEN
//					ls_fld_type = "N"
//				ELSEIF ls_fld_type = "!" THEN
//					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
//					//CONTINUE
//				ELSE				
//					MessageBox("", "Unknown data type " + ls_fld_type1 + " for field " + ls_fld_nm1 )
//					Return ""
//				END IF
				//data value
				if ls_fld_nm1 = "" then
					ls_value1 = ""
				else
					choose case ls_fld_type
						case "C","V"
							ls_value1 = adw.GetItemString( i, ls_fld_nm1 )
						case "N", "I"
							ls_value1 = string(adw.GetItemnumber( i, ls_fld_nm1 ))
						case "D"
							ls_value1 = string(adw.GetItemdatetime( i, ls_fld_nm1 ))
						case else
							ls_value1 = ""
					end choose
				end if
					
				//if lookup get lookup value
//					MessageBox("ls_lookup_type 1", ls_lookup_type)
//					messagebox("ls_fld_nm",ls_fld_nm)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value1) //convert to number
					select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				elseif ls_lookup_type = "A" then
//					messagebox("in","addr lookup")
//					MessageBox("ls_value1 a", ls_value1)
					ll_new_value = long(ls_value1)
					select entity_name into :ls_value1 from address_lookup where lookup_code = :ll_new_value;
					//MessageBox("ls_value1 after lookup", ls_value1)
				end if
				
	
				//reference 2 info
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id2;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id2;

//				ls_fld_type = Upper( adw.Describe( ls_fld_nm2 + ".ColType" ) )
//				IF Pos( ls_fld_type, "CHAR" ) > 0 THEN
//					ls_fld_type = "C"
//				ELSEIF Pos( ls_fld_type, "DATE" ) > 0 THEN
//					ls_fld_type = "D"
//				ELSEIF Pos( ls_fld_type, "LONG" ) > 0 OR Pos( ls_fld_type, "DECIMAL" ) > 0 THEN
//					ls_fld_type = "N"
//				ELSEIF ls_fld_type = "!" THEN
//					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
////					CONTINUE
//				ELSE				
//					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm1 )
//					Return ""
//				END IF
				if ls_fld_nm2 = "" then
					ls_value2 = ""
				else
					choose case ls_fld_type
						case "C","V"
							ls_value2 = adw.GetItemString( i, ls_fld_nm2 )
						case "N", "I"
							ls_value2 = string(adw.GetItemnumber( i, ls_fld_nm2 ))
						case "D"
							ls_value2 = string(adw.GetItemdatetime( i, ls_fld_nm2 ))
						case else
							ls_value2 = ""
					end choose
				end if
				//MessageBox("ls_lookup_type 2", ls_lookup_type)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value2)
					select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
				elseif ls_lookup_type = "A" then
					ll_new_value = long(ls_value2)
					select entity_name into :ls_value2 from address_lookup where lookup_code = :ll_new_value;
				end if
				//check for nulls
				if isnull(ls_value1) then ls_value1  = ""
				if isnull(ls_value2) then ls_value2  = ""
//				MessageBox("ls_value1",ls_value1)
//				MessageBox("ls_value2",ls_value2)

		
				ls_new_value = ls_value1 + "-" + ls_value2
				
				
	return ls_new_value
end function

on pfc_cst_nv_data_entry_functions_temp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_nv_data_entry_functions_temp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

