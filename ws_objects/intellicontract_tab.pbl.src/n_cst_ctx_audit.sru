$PBExportHeader$n_cst_ctx_audit.sru
$PBExportComments$Contract audit object
forward
global type n_cst_ctx_audit from nonvisualobject
end type
end forward

global type n_cst_ctx_audit from nonvisualobject autoinstantiate
end type

type variables
n_ds lds_sys_audit // update
n_ds lds_ctx_sys_audit // casch
n_ds ids_ctx_sys_fields

LONG il_prac_id

//d_ctx_sys_audit
N_CST_DWSRV INV_DWSRV

n_cst_string inv_string

n_ds ids_ctx_sys_audit_max_seq_no

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11/26/2007--12/01/007 By: Ken.Guo
Long il_table_id 
String is_import_table_name 
Boolean ib_from_import
String is_table_name 
DataStore ids_screen
//---------------------------- APPEON END ----------------------------


end variables

forward prototypes
public function integer of_audit_fields (u_dw adw)
public function integer of_set_prac_id (long al_prac_id)
public function integer of_get_values (u_dw adw, long al_rows, long al_column, ref string as_new_value, ref string as_old_value)
protected function integer of_insert_sys_audit_old (u_dw adw, long al_current_row, string as_old_value, string as_new_value, string as_audit_type, datetime adt_server_dtm, long al_column)
public function string of_get_err_info (integer ai_err_no)
public function integer of_update_sys_audit ()
public function integer of_audit_fields (u_dw adw, datastore ads, string as_import_table_name)
public function integer of_audit_fields (datastore ads, string as_import_table_name)
public subroutine of_get_ctx_id (datastore ads, long al_row, dwbuffer adw_buffer)
public function integer of_get_table_id (datastore ads, long al_row, dwbuffer adw_buffer)
public function integer of_insert_sys_audit (datastore ads, long al_current_row, string as_old_value, string as_new_value, string as_audit_type, datetime adt_server_dtm, long al_column)
public function integer of_get_values (datastore ads, integer al_row, integer al_col, ref string as_new_value, ref string as_old_value)
public function string of_getitem (datastore ads, long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value)
public function integer of_audit_fields (long al_ctx_id, long al_table_id, long al_column_id, long al_record_id, string as_old_value, string as_new_value, string as_audit_type)
end prototypes

public function integer of_audit_fields (u_dw adw);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11/26/2007 By: Ken.Guo
//$<reason> Over Load This Function For Import Painter using Audit Function
Datastore lds_empty
Return of_audit_fields(adw,lds_empty,'')


/*  
datetime ldt_server_dtm
long ll_Rows
long ll_column_count
long ll_column
string ls_old_value
string ls_new_value

// NOTIFY THE DATAWINDOW SERVICE OF THE DATAWINDOW WE ARE USING
inv_dwsrv.OF_SETrequestor( ADW)

////////////////////////////////////////////////////////////////////////////////////////////
// first was this datawindow modified
////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<comment> 03.27.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> The following scripts moved to of_update_sys_audit function 
//$<modification> to reduce client-server interactions.
/*
ldt_server_dtm = f_get_server_dtm()
*/
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////
// Go throught the primary buffer of every column
////////////////////////////////////////////////////////////////////////////////////////////
ll_column_count = long(adw.Describe("DataWindow.Column.Count"))


FOR ll_Rows =  1 to adw.rowcount()

		CHOOSE CASE adw.GetItemStatus( ll_Rows, 0 , Primary!)
			CASE newmodified!
				of_insert_sys_audit(adw,ll_Rows,ls_old_value,'INSERT','I',ldt_server_dtm,ll_column)		
			CASE Datamodified! // EDIT
				 FOR  ll_column = 1 TO  ll_column_count
		           of_get_values( adw, ll_Rows, ll_column, ls_new_value, ls_old_value)	
				   IF trim(ls_new_value) <> trim(ls_old_value) THEN 
					  of_insert_sys_audit(adw,ll_Rows,ls_old_value,ls_new_value,"E",ldt_server_dtm,ll_column)						
				   END IF  
				NEXT 
		END CHOOSE 
		
NEXT

/////////////////////////////////////////////////////////////////////////////////////////////
// Go throught the delete buffer of every column
////////////////////////////////////////////////////////////////////////////////////////////

if  adw.deletedcount() > 0 then 
	of_insert_sys_audit(adw,ll_Rows,ls_old_value,'DELETED','D',ldt_server_dtm,ll_column)
end if 

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.27.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Trigger of_update_sys_audit function, which is a complementation of of_audit_fields
THIS.POST of_update_sys_audit()
//---------------------------- APPEON END ----------------------------

return 0
*/

//---------------------------- APPEON END ----------------------------

end function

public function integer of_set_prac_id (long al_prac_id);

il_prac_id = al_prac_id

RETURN 0
end function

public function integer of_get_values (u_dw adw, long al_rows, long al_column, ref string as_new_value, ref string as_old_value);/******************************************************************************************************************
**  [PUBLIC]   : of_get_values( /*u_dw adw*/, /*long al_rows*/, /*long al_column*/, /*ref string as_new_value*/, /*ref string as_old_value */)
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 25 October 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

DATE   LD_DATE
LONG   LL_new_value
LONG   LL_OLD_VALUE, ll_pos, ll_pos2
STRING ls_column_name
STRING ls_editstyle
STRING edit_codetable
STRING editmask_codetable, ls_values
// SET THE OLD AND NEW TO NULL
SETNULL(as_new_value)
SETNULL(as_OLD_value)
// DO NOT PROCESS THE COLUMN IF IT CANNOT BE CHANGED BY THE USER
//IF long(ADW.Describe("#" + string(al_column) + ".TabSequence")) = 0 THEN  return 0 		//Commented by Scofield on 2007-11-02
// DO NOT PROCESS THE COLUMN IF IT HAS NOT BEEN CHANGED
if adw.GetItemStatus( al_rows,al_column , Primary!) = notmodified! THEN  return 0 				
					
ls_column_name = "#" + string(al_column)
ls_editstyle = Lower(adw.Describe(ls_column_name+".Edit.Style"))
edit_codetable = Lower(adw.Describe ( ls_column_name + ".Edit.CodeTable" ))
editmask_codetable = Lower(adw.Describe ( ls_column_name + ".EditMask.CodeTable"))
				
If ls_editstyle='dddw' or ls_editstyle='ddlb' or ls_editstyle='radiobuttons' or edit_codetable = "yes" OR editmask_codetable = "yes" or ls_editstyle = 'checkbox'		then 
				CHOOSE CASE upper(left(adw.Describe(ls_column_name +".COLType"),4))
						CASE 'CHAR','DATE'
							//LL_new_VALUE = SETNULL(LL_new_VALUE)
							as_old_value = inv_dwsrv.of_getitem( al_rows, al_column, primary!, true)
				              as_new_value = inv_dwsrv.of_getitem( al_rows, al_column, primary!, false)
						CASE ELSE  
							LL_OLD_VALUE = adw.getitemNumber(al_rows,al_column,PRIMARY!,true)

							 if string(adw.describe("#" + string(al_column)+".name")) = "app_facility" and adw.dataobject = "d_contract_det_master" then
							 	SELECT facility_name into :as_old_value FROM app_facility where facility_id = :LL_OLD_VALUE;  
							 else
							 	as_old_value = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + String(LL_OLD_VALUE))                                                      
							 end if
					      as_new_value = inv_dwsrv.of_getitem( al_rows, al_column, primary!, false)
							If  ls_editstyle='ddlb' Then	 //added by gavins 20120816
							ls_Values = adw.describe( ls_column_name+ ".values" )
							If Len( ls_Values ) > 2 Then
								ll_pos = Pos( ls_Values, string( LL_OLD_VALUE ) ) - len( string( ll_old_value ) )
								If ll_pos > 0 then
									ll_pos2 = LastPos( ls_Values, '/' , ll_Pos ) + 1
									as_old_value = mid( ls_values, ll_pos2 , ll_Pos - ll_pos2  )
								End If
							End If
						End If
				END CHOOSE 
	ELSE
			 as_old_value = inv_dwsrv.of_getitem( al_rows, al_column, primary!, true)
			 as_new_value = inv_dwsrv.of_getitem( al_rows, al_column, primary!, false)
END IF

return 0
end function

protected function integer of_insert_sys_audit_old (u_dw adw, long al_current_row, string as_old_value, string as_new_value, string as_audit_type, datetime adt_server_dtm, long al_column);///******************************************************************************************************************
//**  [PUBLIC]   : of_insert_sys_audit
//**==================================================================================================================
//**  Purpose   	: Inserts a record into the audit datastore
//**==================================================================================================================
//**  Arguments 	: [none] 
//**==================================================================================================================
//**  Returns   	: [none]   
//**==================================================================================================================
//**  Notes     	: 	   
//**==================================================================================================================
//**  Created By	: Michael B. Skinner xx September 2005  © Intellisoftgroup, Inc
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//********************************************************************************************************************/
//long li_nr
//string ls_editstyle,edit_codetable,editmask_codetable
//long ll_field_id
//long ll_found
//long ll_seq_no
//long ll_deleted_count,ll_i
//
//// CHECK FOR NULLS
//IF ISNULL(ADW) OR  ISNULL(al_current_row) OR  ISNULL(al_column) OR  ISNULL(as_old_value)OR  ISNULL(as_new_value) OR  ISNULL(as_audit_type) OR &
//		ISNULL(adt_server_dtm) OR 	ISNULL(al_column) THEN 
//		RETURN 0
//END IF 
//
// // mskinner 07 march 2006 -- begin
//li_nr = lds_sys_audit.InsertRow( 0 )
// // mskinner 07 march 2006 -- end 
//
//choose case as_new_value
//	case 'DELETED'
//	 
//		 ll_deleted_count = adw.deletedcount()
//	
//		 for ll_i = 1 to ll_deleted_count 
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<modify> 03.24.2006 By: Liang QingShi
//					//$<reason> Fix a defect.
//					/*
//				 	lds_sys_audit.SetItem( li_nr, "rec_id", adw.GetItemNumber( ll_i, "record_id" , Delete!,FALSE) )
//					*/
//					long ll_record_id
//					ll_record_id = adw.GetItemNumber( ll_i, "record_id" , Delete!,FALSE)
//					if isnull(ll_record_id) then ll_record_id = 0
//			 		lds_sys_audit.SetItem( li_nr, "rec_id", ll_record_id )
//
//					//---------------------------- APPEON END ----------------------------
//					
//					lds_sys_audit.SetItem( li_nr, "field_id", 1001 )
//					
//					string ls_table_name 
//					long ll_table_id
//					ls_table_name = adw.DATAOBJECT
//					
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<ID> PT-03
//					//$<modify> 03.16.2006 By: LeiWei
//					//$<reason> Performance tuning
//					//$<modification> Write script to retrieve data from a cache instead of from the database.
//
//					/*
//					select table_id 
//					into :ll_table_id
//					from sys_tables
//					where table_name =  :ls_table_name;
//					*/
//					ll_table_id = Long(gnv_data.of_getitem( "sys_tables", "table_id", "lower(table_name) = '" + lower(ls_table_name) + "'"))
//					//---------------------------- APPEON END ----------------------------
//					
//					lds_sys_audit.SetItem( li_nr, "table_id",ll_table_id)  
//		
//
//					
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<ID> PT-04
//					//$<comment> 03.27.2006 By: LeiWei
//					//$<reason> Performance tuning
//					//$<modification> The following scripts moved to of_update_sys_audit function
//					//$<modification> to reduce client-server interactions.
//
//					/*
//					select max(seq_no) 
//					into :ll_seq_no
//					from sys_audit where field_id = 1001  ;
//					
//					if isnull(ll_seq_no) then 
//						ll_seq_no = 1
//					else 
//						ll_seq_no =  ll_seq_no +1 
//					end if 
//			
//					lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )
//					*/
//					//---------------------------- APPEON END ----------------------------
//		next 
//	
//  CASE 'INSERT'
//	            long ll
//	            ll = adw.GetItemNumber( al_current_row, "record_id" ) 
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<modify> 04.05.2006 By: LeiWei
//					//$<reason> Fix a defect.
//					//lds_sys_audit.SetItem( li_nr, "rec_id", adw.GetItemNumber( al_current_row, "record_id" ) )
//
//					if isnull(ll) then ll = 0
//			 		lds_sys_audit.SetItem( li_nr, "rec_id", ll )
//
//					//---------------------------- APPEON END ----------------------------
//
//				   lds_sys_audit.SetItem( li_nr, "field_id", 1001 )
//									
//					//ls_table_name = adw.DATAOBJECT
//					
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<ID> PT-05
//					//$<modify> 03.16.2006 By: LeiWei
//					//$<reason> Performance tuning
//					//$<modification> Write script to retrieve data from a cache instead of from the database.
//
//					/*
//					select table_id 
//					into :ll_table_id
//					from sys_tables
//					where table_name =  :ls_table_name;
//					*/
//					ll_table_id = Long(gnv_data.of_getitem( "sys_tables", "table_id", "lower(table_name) = '" + lower(ls_table_name) + "'"))
//					//---------------------------- APPEON END ----------------------------
//			
//			
//					lds_sys_audit.SetItem( li_nr, "table_id",ll_table_id)
//					
//					
//									
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<ID> PT-06
//					//$<comment> 03.27.2006 By: LeiWei
//					//$<reason> Performance tuning
//					//$<modification> The following scripts moved to of_update_sys_audit function
//					//$<modification> to reduce client-server interactions.
//					/*
//					select max(seq_no) 
//					into :ll_seq_no
//					from sys_audit where field_id = 1001  ;
//					
//					if isnull(ll_seq_no) then 
//						ll_seq_no = 1
//					else 
//						ll_seq_no =  ll_seq_no +1 
//					end if 
//			
//					lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )
//					*/
//					//---------------------------- APPEON END ----------------------------
//		
//		
//	CASE ELSE
//			//messagebox('',string(adw.GetItemNumber( al_current_row, "record_id" ))   )
//		
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<modify> 03.24.2006 By: Liang QingShi
//			//$<reason> Fix a defect.
//			/*
//			lds_sys_audit.SetItem( li_nr, "rec_id", adw.GetItemNumber( al_current_row, "record_id" ) )
//			*/
//			long ll_id2
//			ll_id2 = adw.GetItemNumber( al_current_row, "record_id" )
//			if isnull(ll_id2) then ll_id2 = 0
//			lds_sys_audit.SetItem( li_nr, "rec_id", ll_id2 )
//	
//			//---------------------------- APPEON END ----------------------------
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 04.10.2006 By: Liang QingShi
//			//$<reason> Fix a defect.
//			if isvalid(ids_ctx_sys_fields) = False then
//				ids_ctx_sys_fields = CREATE n_ds
//				ids_ctx_sys_fields.DataObject = "d_ctx_sys_fields"
//				
//				gnv_app.inv_dwcache.of_GetRegistered ('d_ctx_sys_fields',ids_ctx_sys_fields)
//			end if
//			//---------------------------- APPEON END ----------------------------
//
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<modify> 04.01.2006 By: LeiWei
//			//$<reason> Fix a defect.
//			/*
//			// mskinner 07 march 2006 -- begin
//			// crash is happing here not sure why
//			try
//			  ll_found = ids_ctx_sys_fields.Find("field_name = '" + string(ADW.Describe("#" + string(al_column) + ".Name")) + "'" , 1, ids_ctx_sys_fields.RowCount())
//		   catch (runtimeerror rte)
//			  lds_sys_audit.DELETEROW(li_nr)
//	      end try
//     	   // mskinner 07 march 2006 -- end 
//			*/
//			ll_found = ids_ctx_sys_fields.Find("lower(field_name) = '" + lower(string(ADW.Describe("#" + string(al_column) + ".Name"))) + "'" , 1, ids_ctx_sys_fields.RowCount())
//			//---------------------------- APPEON END ----------------------------
//
//			if ll_found > 0 then
//				ll_field_id = ids_ctx_sys_fields.getitemNumber(ll_found,'field_id'  )
//				lds_sys_audit.SetItem( li_nr, "table_id", ids_ctx_sys_fields.getitemNumber(ll_found,'table_id'  ))
//				lds_sys_audit.SetItem( li_nr, "field_id", ll_field_id )
//				
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-07
//				//$<comment> 03.27.2006 By: LeiWei
//				//$<reason> Performance tuning
//				//$<modification> The following scripts moved to of_update_sys_audit function
//				//$<modification> to reduce client-server interactions.
//				/*
//				select max(seq_no) 
//				into :ll_seq_no
//				from sys_audit where field_id = :ll_field_id ;
//				
//				if isnull(ll_seq_no) then 
//					ll_seq_no = 1
//				else 
//					ll_seq_no =  ll_seq_no +1 
//				end if 
//					
//				lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )
//				*/
//				//---------------------------- APPEON END ----------------------------
//			else 
//				 //messagebox('Missing Audit Data','Please contact IntelliSoftGroup support 1-888-634-4464 ' + string(ADW.Describe("#" + string(al_column) + ".Name")))
//				 lds_sys_audit.DELETEROW(li_nr)
//				RETURN 0 
//			end if 
//
//END CHOOSE 
//lds_sys_audit.SetItem( li_nr, "prac_id", il_prac_id)
//lds_sys_audit.SetItem( li_nr, "old_value", mid(as_old_value,1,100) )
//lds_sys_audit.SetItem( li_nr, "new_value", mid(as_new_value,1,100 ))
//lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
//lds_sys_audit.SetItem( li_nr, "audit_type", as_audit_type )					
//lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-08
////$<comment> 03.27.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> The following scripts moved to of_update_sys_audit function
////$<modification> to reduce client-server interactions.
///*
//lds_sys_audit.SetItem( li_nr, "date_time_modified", adt_server_dtm )
//lds_sys_audit.update( )
//*/
////---------------------------- APPEON END ----------------------------
//		
return 0
end function

public function string of_get_err_info (integer ai_err_no);Choose Case ai_err_no
	Case  0 ,1
		Return 'Save data Successfully.'
	Case	-10
		Return 'No ctx_id field in dataobject.'
	Case -1
		Return 'Failed to save data.'
	Case -2
		Return 'Current table is not registered.'		
	Case Else
		Return 'Failed to audit.'
End Choose
end function

public function integer of_update_sys_audit ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ctx_auditof_update_sys_audit()
// $<arguments>(None)
// $<returns> (none)
// $<description> Performance tuning
// $<description> Commit the lds_sys_audit object
//////////////////////////////////////////////////////////////////////
// $<add> 03.27.2006 by LeiWei
//////////////////////////////////////////////////////////////////////

long ll_rowcount,ll_rows
Long ll_seq_no = 0
Datetime ldtServerDate

IF lds_sys_audit.modifiedcount( ) + lds_sys_audit.Deletedcount( ) <=0 Then Return 1

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.20.2006 By: Davis
//$<reason> Fix a defect.

LONG ll_field_id_array[]
Long ll_field_id
Long ll_row
//---------Begin Modified by (Appeon)Stephen 2013-08-14 for V141 Email/Fax Applications to Payors--------
//Integer i,j,k
long i,j,k
long ll_start, ll_next
long ll_null[]
n_ds lds_temp
//---------End Modfiied ------------------------------------------------------

IF NOT Isvalid( ids_ctx_sys_audit_max_seq_no ) THEN
	ids_ctx_sys_audit_max_seq_no = Create n_ds
	ids_ctx_sys_audit_max_seq_no.DataObject = 'd_max_seq_no_sys_audit_pt'
	ids_ctx_sys_audit_max_seq_no.SetTransObject( SQLCA )
END IF

//---------Begin Modified by (Appeon)Stephen 2013-08-14 for Array boundary exceeded--------
/*
FOR ll_Rows =  1 to lds_sys_audit.rowcount()
	IF lds_sys_audit.GetItemStatus( ll_Rows, 0 , Primary!) = newmodified! THEN
		i++
		ll_field_id = lds_sys_audit.GetItemNumber(ll_rows, "field_id")
		ll_field_id_array[i] = ll_field_id
	END IF
END FOR
*/
if lds_sys_audit.modifiedcount() > 5000 then
	lds_temp = Create n_ds
	lds_temp.DataObject = 'd_max_seq_no_sys_audit_pt'
	lds_temp.SetTransObject( SQLCA )
	ll_start = 1
	do while ll_start < lds_sys_audit.rowcount()
		ll_next = ll_start + 4999
		if ll_next >  lds_sys_audit.rowcount() then  ll_next = lds_sys_audit.rowcount()
		i = 0	
		FOR ll_Rows =  ll_start to ll_next
			IF lds_sys_audit.GetItemStatus( ll_Rows, 0 , Primary!) = newmodified! THEN
				i++
				ll_field_id = lds_sys_audit.GetItemNumber(ll_rows, "field_id")
				ll_field_id_array[i] = ll_field_id
			END IF
		END FOR 
		if upperbound(ll_field_id_array) > 0 then
			lds_temp.Retrieve( ll_field_id_array )
			lds_temp.rowscopy(1, lds_temp.rowcount(), primary!,ids_ctx_sys_audit_max_seq_no, ids_ctx_sys_audit_max_seq_no.rowcount()+1, primary!)
		end if
		lds_temp.reset()
		ll_start = ll_next + 1
		ll_field_id_array = ll_null
	loop
else
	i = 0
	FOR ll_Rows =  1 to lds_sys_audit.rowcount()
		IF lds_sys_audit.GetItemStatus( ll_Rows, 0 , Primary!) = newmodified! THEN
			i++
			ll_field_id = lds_sys_audit.GetItemNumber(ll_rows, "field_id")
			ll_field_id_array[i] = ll_field_id
		END IF
	END FOR
	ids_ctx_sys_audit_max_seq_no.Retrieve( ll_field_id_array )
end if
//---------End Modfiied ------------------------------------------------------

gnv_appeondb.of_startqueue( )

//ids_ctx_sys_audit_max_seq_no.Retrieve( ll_field_id_array )   //Commented by (Appeon)Stephen 2013-08-14 - Array boundary exceeded 

Choose Case gs_dbType
	Case 'ASA'
		select getdate() 
		into :ldtServerDate
		from dummy
		using SQLCA;
	Case 'SQL'
		select getdate() 
		into :ldtServerDate
		from ids
		using SQLCA;
End Choose
			
gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

FOR ll_Rows =  1 to lds_sys_audit.rowcount()
	If lds_sys_audit.GetItemStatus( ll_Rows, 0 , Primary!) = newmodified! Then
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 12.20.2006 By: Davis
		//$<reason> Fix a defect.
		j++
		ll_field_id = lds_sys_audit.GetItemNumber(ll_rows, "field_id")
		ll_row = ids_ctx_sys_audit_max_seq_no.Find("field_id = " + String(ll_field_id), 1, ids_ctx_sys_audit_max_seq_no.Rowcount())
		
		IF ll_row > 0 THEN
			ll_seq_no = ids_ctx_sys_audit_max_seq_no.GetItemNumber( ll_row, "seq_no")
			
			If ll_seq_no <= 0 OR isnull(ll_seq_no) Then
				ll_seq_no = 1
			Else
				ll_seq_no++

				FOR k = 1 to j - 1
					//---------Begin Modified by (Appeon)Stephen 2013-08-14 for Array boundary exceeded--------
					//IF ll_field_id = ll_field_id_array[k] THEN
					IF ll_field_id = lds_sys_audit.GetItemNumber(k, "field_id") then
					//---------End Modfiied ------------------------------------------------------
						ll_seq_no++
					END IF
				NEXT
			End if
		ELSE
			//added by gavins 20120815
			  select MIN(seq_no) into:ll_seq_no  from sys_audit ;
			if isnull( ll_seq_no ) then
				ll_seq_no = 1
			else
				ll_seq_no = ll_seq_no - 1
			end if
		END IF
			
		//---------------------------- APPEON END ----------------------------
		
		lds_sys_audit.SetItem( ll_Rows, "seq_no", ll_seq_no )
		lds_sys_audit.SetItem( ll_Rows, "date_time_modified", ldtServerDate )
	End If
NEXT

gnv_appeondb.of_autocommitrollback()
If lds_sys_audit.update() = 1 Then
	commit;
Else
	Rollback;
	Return -1
End If

Return 1

end function

public function integer of_audit_fields (u_dw adw, datastore ads, string as_import_table_name);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


/*************************************************************************
//$<add> 11/26/2007 By: Ken.Guo
//Argument: as_import_table_name-->Physical table name that need import data.
//All script in this function was cut from of_audit_fields(adw)
//For over loading this function for import painter using audit function.
**************************************************************************/


datetime ldt_server_dtm
long ll_Rows
long ll_column_count
long ll_column
string ls_old_value
string ls_new_value
string ls_dataobject_name,ls_find_cond
Int li_ret 
String ls_err
n_cst_dssrv_import lnv_dssrv
is_import_table_name = as_import_table_name

// NOTIFY THE DATAWINDOW SERVICE OF THE DATAWINDOW WE ARE USING
If Not ib_from_import Then	
	inv_dwsrv.OF_SETrequestor( ADW)
	ads = Create DataStore
	ads.DataObject = ADW.DataObject
	ads.Create( adw.Describe( "datawindow.syntax" ), ls_err )//added by gavins 20120815
	adw.sharedata(ads)
End If

If ads.rowcount() = 0 and ads.deletedcount() = 0 Then Return 0

ll_column_count = long(ads.Describe("DataWindow.Column.Count"))

//Get table_id and table_name
If ads.rowcount() > 0 Then 
	li_ret = of_get_table_id(ads,1,Primary!)
	If li_ret < 0 Then Return li_ret
ElseIf ads.deletedcount() > 0 Then
	li_ret = of_get_table_id(ads,1,Delete!)
	If li_ret < 0 Then Return li_ret
End If

//Register ads If call from Import Painter
If ib_from_import Then
	lnv_dssrv.of_setrequestor(ads,is_table_name)
End If

//For Primary data
FOR ll_Rows =  1 to ads.rowcount()
		If lower(is_import_table_name) = 'ctx_contract_contacts' or ads.dataobject = 'd_contract_det_contact_external' or ads.dataobject = 'd_contract_det_contact_internal' Then
			of_get_table_id(ads,ll_Rows,Primary!)
		End If
		of_get_ctx_id(ads,ll_rows,Primary! )
		CHOOSE CASE ads.GetItemStatus( ll_Rows, 0 , Primary!)
			CASE newmodified!
				of_insert_sys_audit(ads,ll_Rows,ls_old_value,'INSERT','I',ldt_server_dtm,ll_column)		
			CASE Datamodified! // EDIT
				FOR  ll_column = 1 TO  ll_column_count
					If ads.GetItemStatus(ll_rows,ll_column,Primary!) = NotModified! Then Continue
					If ib_from_import Then 
						lnv_dssrv.of_get_values(ll_rows,ll_column, ls_new_value,ls_old_value, Primary!)
					Else
						of_get_values( adw, ll_Rows, ll_column, ls_new_value, ls_old_value)	
					End If
				If isnull( ls_old_value  ) then ls_old_value = '' 
				If isnull( ls_new_value  ) then ls_new_value = '' 	
				IF trim(ls_new_value) <> trim(ls_old_value) THEN 
				  of_insert_sys_audit(ads,ll_Rows,ls_old_value,ls_new_value,"E",ldt_server_dtm,ll_column)						
				END IF  
				NEXT 
		END CHOOSE 
NEXT

/////////////////////////////////////////////////////////////////////////////////////////////
// Go throught the delete buffer of every column
////////////////////////////////////////////////////////////////////////////////////////////

//For Delete data
if ads.deletedcount() > 0 then 
	of_insert_sys_audit(ads,ll_Rows,ls_old_value,'DELETED','D',ldt_server_dtm,ll_column)
end if 

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.27.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Trigger of_update_sys_audit function, which is a complementation of of_audit_fields
//THIS.POST of_update_sys_audit() //Comment by Ken.Guo 11/26/2007
Return of_update_sys_audit() //Added by Ken.Guo 11/26/2007
//---------------------------- APPEON END ----------------------------

//Return 0  //Comment by Ken.Guo 11/26/2007

end function

public function integer of_audit_fields (datastore ads, string as_import_table_name);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ctx_auditof_audit_fields()
// $<arguments>
//		value	datastore	ads                 		
//		value	string   	as_import_table_name		
// $<returns> integer
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11/28/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

u_dw ldw_empty
ib_from_import = True
Return of_audit_fields(ldw_empty,ads,as_import_table_name)
end function

public subroutine of_get_ctx_id (datastore ads, long al_row, dwbuffer adw_buffer);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ctx_auditof_get_ctx_id()
// $<arguments>
//		value	u_dw    	adw       		
//		value	long    	al_row    		
//		value	dwbuffer	adw_buffer		
// $<returns> integer
// $<description>Get ctx_id from import datawindow
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11/27/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Notes:of_get_table_id() have checked ctx_id field whether exists
If Len(is_import_table_name) > 0 Then  //From import painter
		il_prac_id = ads.GetItemNumber(al_row,'ctx_id',adw_buffer,False)
End If

end subroutine

public function integer of_get_table_id (datastore ads, long al_row, dwbuffer adw_buffer);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ctx_auditof_get_table_id()
// $<arguments>
//		datastore ads
//		value	long    	al_row    		
//		value	dwbuffer	adw_buffer		
// $<returns> integer
// $<description>
// $<description> Get table_id and ctx_id and set it to instance var
//////////////////////////////////////////////////////////////////////
// $<add> 11/27/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////
String ls_find_cond,ls_dataobject_name
If ib_from_import Then  //From import painter
	If Len(ads.Describe('ctx_id.coltype')) > 1 Then
		ls_find_cond = "lower(import_table_name) = '" + lower(is_import_table_name) + "'"
		//'ctx_contract_contacts' mapped two table_name.need distinguish.
		If lower(is_import_table_name) = 'ctx_contract_contacts' Then
			If Len(ads.Describe('ic_area.coltype')) > 1 Then
				If ads.getitemstring(al_row,'ic_area',adw_buffer,False) = 'I' Then 
					ls_find_cond = "lower(import_table_name) = '" + lower(is_import_table_name) + "'" + " and Pos(lower(table_name_allias),'our company contact info') > 0 "
				Else
					ls_find_cond = "lower(import_table_name) = '" + lower(is_import_table_name) + "'" + " and Pos(lower(table_name_allias),'contracted company contact info') > 0 "
				End If
			End If
		End If
		il_table_id = Long(gnv_data.of_getitem( "sys_tables", "table_id", ls_find_cond))
		is_table_name = gnv_data.of_getitem( "sys_tables", "table_name", ls_find_cond)
		If isnull(il_table_id) or il_table_id = 0 Then
			Return -2 //Not register
		End If
	Else
		Return -10 //Not ctx_id field in dataobject
	End If
Else //From w_contract 
	ls_dataobject_name = ads.dataobject
	ls_find_cond = "lower(table_name) = '" + lower(ls_dataobject_name) + "'"
	//'d_contract_det_contact_external' mapped two DW. need distinguish.
	If Lower(ls_dataobject_name) = 'd_contract_det_contact_external' Then 
		If ads.getitemstring(al_row,'ic_area',adw_buffer,False) = 'I' Then 
			ls_find_cond = "Pos(lower(table_name),'d_contract_det_contact_') > 0 " + " and Pos(lower(table_name_allias),'our company contact info') > 0 "
		Else
			ls_find_cond = "Pos(lower(table_name),'d_contract_det_contact_') > 0 " + " and Pos(lower(table_name_allias),'contracted company contact info') > 0 "
		End If
	End If
	il_table_id = Long(gnv_data.of_getitem( "sys_tables", "table_id", ls_find_cond))
	If isnull(il_table_id) or il_table_id = 0 Then
		Return -2 //Not register
	End If
End If
Return 1
end function

public function integer of_insert_sys_audit (datastore ads, long al_current_row, string as_old_value, string as_new_value, string as_audit_type, datetime adt_server_dtm, long al_column);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ctx_auditof_insert_sys_audit()
// $<arguments>
//		value	datastore ads      		
//		value	long    	al_current_row		
//		value	string  	as_old_value  		
//		value	string  	as_new_value  		
//		value	string  	as_audit_type 		
//		value	datetime	adt_server_dtm		
//		value	long    	al_column     		
// $<returns> integer
// $<description> Copy all old script to of_insert_sys_audit_old()
// $<description> Modify this function to support import painter.
//////////////////////////////////////////////////////////////////////
// $<add> 11/27/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long li_nr
string ls_editstyle,edit_codetable,editmask_codetable
long ll_field_id,ll_found,ll_deleted_count,ll_i,ll_seq_no
long ll_record_id,ll,ll_id2
boolean lb_rec_exist
boolean lb_ctx_action
boolean lb_ctx_am_action
String ls_dataobject_name,ls_find_cond,ls_Name, ls_Text, ls_visible
Int li_ret
n_cst_string			ln_string//added by gavins 20120815

// CHECK FOR NULLS
IF ISNULL(ads) OR  ISNULL(al_current_row) OR  ISNULL(al_column) OR  ISNULL(as_old_value)OR  ISNULL(as_new_value) OR  ISNULL(as_audit_type) OR &
		ISNULL(adt_server_dtm) OR 	ISNULL(al_column) THEN 
		RETURN 0
END IF 

//li_nr = lds_sys_audit.InsertRow( 0 )

//For ctx_action_items - jervis 11.05.2010
if Len(ads.Describe('ctx_action_item_id.coltype')) > 1 then
	lb_ctx_action = true
//For ctx_am_action_items - jervis 11.10.2010
elseif Len(ads.Describe('seq_id.coltype')) > 1 and Len(ads.Describe('doc_id.coltype')) > 1 then  
	lb_ctx_am_action = true
//Check record_id whether exists
elseIf Len(ads.Describe('record_id.coltype')) > 1 Then 
	lb_rec_exist = True
End If



Choose Case as_new_value
	CASE 'DELETED'
		ll_deleted_count = ads.deletedcount()
		for ll_i = 1 to ll_deleted_count
			li_nr = lds_sys_audit.InsertRow( 0 )
			If lb_rec_exist Then
				ll_record_id = ads.GetItemNumber( ll_i, "record_id" , Delete!,True)
				if isnull(ll_record_id) then ll_record_id = 0
			elseif lb_ctx_action then	//For ctx_action_items - jervis 11.05.2010
				ll_record_id = ads.GetItemNumber( ll_i, "ctx_action_item_id",Delete!,true )
				if isnull(ll_record_id) then ll_record_id = 0
			elseif lb_ctx_am_action then	//For ctx_am_action_items - jervis 11.10.2010
				ll_record_id = ads.GetItemNumber( ll_i, "seq_id",Delete!,true )
				if isnull(ll_record_id) then ll_record_id = 0
			Else
				ll_record_id = 0
			End If
			If lower(is_import_table_name) = 'ctx_contract_contacts' or ads.dataobject = 'd_contract_det_contact_external' or ads.dataobject = 'd_contract_det_contact_internal' Then
				of_get_table_id(ads,ll_i,Delete!)
			End If			
			of_get_ctx_id(ads,ll_i,Delete!)
			lds_sys_audit.SetItem( li_nr, "rec_id", ll_record_id )
			lds_sys_audit.SetItem( li_nr, "field_id", 1001 )
			lds_sys_audit.SetItem( li_nr, "table_id",il_table_id)  
			
			lds_sys_audit.SetItem( li_nr, "prac_id", il_prac_id)
			lds_sys_audit.SetItem( li_nr, "old_value", mid(as_old_value,1,100) )
			lds_sys_audit.SetItem( li_nr, "new_value", mid(as_new_value,1,100 ))
			lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
			lds_sys_audit.SetItem( li_nr, "audit_type", as_audit_type )					
			lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )	
			
			//Get Doc ID - jervis 11.10.2010
			if lb_ctx_am_action then
				lds_sys_audit.SetItem( li_nr, "facility_id", ads.GetItemNumber( ll_i, "doc_id",Delete!,true ) )	
			end if
		next 
	CASE 'INSERT'
		li_nr = lds_sys_audit.InsertRow( 0 )
		If lb_rec_exist Then
			ll = ads.GetItemNumber( al_current_row, "record_id" )
			if isnull(ll) then ll = 0
		elseif lb_ctx_action then	//For ctx_action_items - jervis 11.05.2010
			ll = ads.GetItemNumber( al_current_row, "ctx_action_item_id" )
			if isnull(ll) then ll = 0
		elseif lb_ctx_am_action then	//For ctx_am_action_items - jervis 11.10.2010
			ll = ads.GetItemNumber( al_current_row, "seq_id" )
			if isnull(ll) then ll = 0
		Else
			ll = 0
		End If
		lds_sys_audit.SetItem( li_nr, "rec_id", ll )
		lds_sys_audit.SetItem( li_nr, "field_id", 1001 )
		lds_sys_audit.SetItem( li_nr, "table_id",il_table_id)
		//Get Doc ID - jervis 11.10.2010
		if lb_ctx_am_action then
			lds_sys_audit.SetItem( li_nr, "facility_id", ads.GetItemNumber( al_current_row, "doc_id" ) )	
		end if
	CASE ELSE //'EDIT'
		li_nr = lds_sys_audit.InsertRow( 0 )
		If lb_rec_exist Then
			ll_id2 = ads.GetItemNumber( al_current_row, "record_id" )
			if isnull(ll_id2) then ll_id2 = 0
		elseif lb_ctx_action then	//For ctx_action_items - jervis 11.05.2010
			ll_id2 = ads.GetItemNumber( al_current_row, "ctx_action_item_id" )
			if isnull(ll) then ll = 0
		elseif lb_ctx_am_action then	//For ctx_am_action_items - jervis 11.10.2010
			ll_id2 = ads.GetItemNumber( al_current_row, "seq_id" )
			if isnull(ll) then ll = 0
		Else
			ll_id2 = 0
		End If		
		if isnull(ll_id2) then ll_id2 = 0
		lds_sys_audit.SetItem( li_nr, "rec_id", ll_id2 )
		//Get Doc ID - jervis 11.10.2010
		if lb_ctx_am_action then
			lds_sys_audit.SetItem( li_nr, "facility_id", ads.GetItemNumber( al_current_row, "doc_id" ) )	
		end if
		
		if isvalid(ids_ctx_sys_fields) = False then
			//ids_ctx_sys_fields = CREATE n_ds  //Commented By Ken.Guo 2008-01-18, Ref object, Need not Create.
			//ids_ctx_sys_fields.DataObject = "d_ctx_sys_fields"  //Commented By Ken.Guo 2008-01-18, Ref object, Need not Create.
			gnv_app.inv_dwcache.of_GetRegistered ('d_ctx_sys_fields',ids_ctx_sys_fields)
		end if
		ls_Name = string(ads.Describe("#" + string(al_column) + ".Name")) //added by gavins 20120815
		ls_Text = ads.Describe(ls_Name + "_t.Text")
		
		If ads.dataobject = 'd_contract_det_master' Then
			ls_Visible = ads.Describe("#" + string(al_column) + ".Visible") 
			If IsValid( w_contract ) And  not ( ls_Visible = '1' or ls_Visible = '-1' ) Then//dw_contract_dates
				datawindow ldw_temp
				 ldw_temp = w_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1
				 If IsValid( ldw_temp ) Then
					If ldw_temp.describe( "#" + string(al_column) + ".Visible") = '1' Or  ldw_temp.describe( "#" + string(al_column) + ".Visible")  = '-1' Then
						ls_Name = string(ldw_temp.Describe("#" + string(al_column) + ".Name")) //added by gavins 20120815
						ls_Text = ldw_temp.Describe(ls_Name + "_t.Text")
					End If
				End If	
				 ldw_temp = w_contract.tab_contract_details.tabpage_details.uo_1.dw_contract_dates
				  If IsValid( ldw_temp ) Then
					If ldw_temp.describe( "#" + string(al_column) + ".Visible") = '1' Or  ldw_temp.describe( "#" + string(al_column) + ".Visible")  = '-1' Then
						ls_Name = string(ldw_temp.Describe("#" + string(al_column) + ".Name")) //added by gavins 20120815
						ls_Text = ldw_temp.Describe(ls_Name + "_t.Text")
					End If
				End If				
			End If
		End If
		
		
		If isnull(ls_Text ) or trim( ls_Text ) = '' or ls_Text = '!' or ls_Text = '?' then ls_Text = ls_Name
		ll_found = ids_ctx_sys_fields.Find("table_id = "+String(il_table_id) + " and lower(field_name) = '" + lower(ls_Name) + "'" , 1, ids_ctx_sys_fields.RowCount())
		if ll_found > 0 then
			ll_field_id = ids_ctx_sys_fields.getitemNumber(ll_found,'field_id'  )
			lds_sys_audit.SetItem( li_nr, "table_id", il_table_id)
			lds_sys_audit.SetItem( li_nr, "field_id", ll_field_id )
		else 
			lds_sys_audit.SetItem( li_nr, "table_id", il_table_id)	
		
			lds_sys_audit.SetItem( li_nr, "field_id", -9999 )
//			lds_sys_audit.DELETEROW(li_nr) //modified by gavins 20120815
//			RETURN 0
		end if 
		lds_sys_audit.SetItem( li_nr, "tfield_name",  lower(ls_Name))
		ls_Text = ln_string.of_globalreplace( ls_Text, '_', ' ' )
		lds_sys_audit.SetItem( li_nr, "tfield_name_allias", ls_Text )	
		
END CHOOSE 

If as_new_value <> 'DELETED' Then
	lds_sys_audit.SetItem( li_nr, "prac_id", il_prac_id)
	lds_sys_audit.SetItem( li_nr, "old_value", mid(as_old_value,1,100) )
	//---------Begin Modified by (Appeon)Harry 06.19.2015 for Bug #4560--------
	//lds_sys_audit.SetItem( li_nr, "new_value", mid(as_new_value,1,100 ))
	if ads.dataobject = "d_ctx_schedule_fee_detail" and as_new_value = 'INSERT' then
		string ls_new_value
		ls_Name =  'fee'
		ls_new_value = string(ads.getitemnumber(al_current_row, ls_Name))
		if isnull(ls_new_value) or ls_new_value = "" then ls_new_value = 'INSERT'
		lds_sys_audit.SetItem( li_nr, "new_value", mid(ls_new_value,1,100 ))
		ls_Text = ads.Describe(ls_Name + "_t.Text")
		lds_sys_audit.SetItem( li_nr, "tfield_name",  ls_Text)
		ls_Text = ln_string.of_globalreplace( ls_Text, '_', ' ' )
		lds_sys_audit.SetItem( li_nr, "tfield_name_allias", ls_Text )	
	else
		lds_sys_audit.SetItem( li_nr, "new_value", mid(as_new_value,1,100 ))
	end if
	//---------End Modfiied ------------------------------------------------------
	lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
	lds_sys_audit.SetItem( li_nr, "audit_type", as_audit_type )					
	lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )
End If

Return 0
end function

public function integer of_get_values (datastore ads, integer al_row, integer al_col, ref string as_new_value, ref string as_old_value);If Isvalid(ids_screen) Then
	
End If

Return 1
end function

public function string of_getitem (datastore ads, long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value);string 	ls_col_format, ls_col_mask, ls_string_format, ls_string, ls_savestring
string	ls_coltype, ls_editstyle
string	ls_computeexp, ls_evaluateexp
string	edit_codetable, editmask_codetable
boolean 	lb_editmask_used=False
long 		ll_pos
n_cst_string	lnv_string

ls_col_format = ads.Describe ( as_column + ".format" )
ls_col_mask   = ads.Describe ( as_column + ".editmask.mask") 

IF ls_col_mask = "!" or ls_col_mask = "?" THEN
	ls_string_format = ls_col_format
ELSE 
	ls_string_format = ls_col_mask
	lb_editmask_used = TRUE
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

/*  Determine the datatype of the column and then call the appropriate 
	 GetItemxxx function and format the returned value */
ls_coltype = Lower(ads.Describe ( as_column + ".ColType" ))
CHOOSE CASE Left ( ls_coltype , 5 )

		CASE "char(", "char"				//  CHARACTER DATATYPE
			IF lb_editmask_used = TRUE THEN 
				/*  Need to replace 'EditMask' characters with 'Format' characters */
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "^", "@" ) //Lowercase
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "!", "@")	//Uppercase
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "#", "@" ) //Number
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "a", "@" ) //Aplhanumeric
				ls_string_format = lnv_string.of_GlobalReplace ( ls_string_format, "x", "@" ) //Any Character
			END IF 
			ls_string = ads.GetItemString ( al_row, as_column, adw_buffer, ab_orig_value ) 
			ls_string = String ( ls_string, ls_string_format ) 
	
		CASE "date"					//  DATE DATATYPE
			date ld_date
			ld_date = ads.GetItemDate ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ld_date, ls_string_format ) 
			else
				ls_string = String (ld_date)
			end if

		CASE "datet"				//  DATETIME DATATYPE
			datetime ldtm_datetime
			ldtm_datetime = ads.GetItemDateTime ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ldtm_datetime, ls_string_format ) 
			else
				ls_string = String (ldtm_datetime)
			end if

		CASE "decim"				//  DECIMAL DATATYPE
			decimal ldec_decimal
			ldec_decimal = ads.GetItemDecimal ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ldec_decimal, ls_string_format ) 
			else
				ls_string = String (ldec_decimal)
			end if	
	
		CASE "numbe", "doubl", "real"		//  DOUBLE DATATYPE	
			double ldbl_double
			ldbl_double = ads.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ldbl_double, ls_string_format ) 
			else
				ls_string = String (ldbl_double)
			end if
	
		CASE "long", "ulong", "int"				//  LONG DATATYPE	
			long ll_long
			ll_long = ads.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ll_long, ls_string_format ) 
			else
				ls_string = String (ll_long)
			end if
	
		CASE "time", "times"		//  TIME DATATYPE
			time ltm_time
			ltm_time = ads.GetItemTime ( al_row, as_column, adw_buffer, ab_orig_value ) 
			if Len (ls_string_format) > 0 then
				ls_string = String ( ltm_time, ls_string_format ) 
			else
				ls_string = String (ltm_time)
			end if
END CHOOSE
Return ls_string
end function

public function integer of_audit_fields (long al_ctx_id, long al_table_id, long al_column_id, long al_record_id, string as_old_value, string as_new_value, string as_audit_type);//====================================================================
// Function: of_audit_fields
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_ctx_id
//                al_table_id
//                al_column_id
//                al_record_id
//                as_old_value
//                as_new_value
//                as_audit_type
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 03/06/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

			
Long li_nr
li_nr = lds_sys_audit.InsertRow( 0 )
lds_sys_audit.SetItem( li_nr, "prac_id", al_ctx_id)
lds_sys_audit.SetItem( li_nr, "table_id",al_table_id) 
lds_sys_audit.SetItem( li_nr, "field_id", al_column_id )
lds_sys_audit.SetItem( li_nr, "rec_id", al_record_id )
lds_sys_audit.SetItem( li_nr, "old_value", as_old_value )
lds_sys_audit.SetItem( li_nr, "new_value", as_new_value)
lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
lds_sys_audit.SetItem( li_nr, "audit_type", as_audit_type )					
lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )	
This.of_update_sys_audit( )

Return 1


end function

on n_cst_ctx_audit.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ctx_audit.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//f_create_ctx_database()

lds_sys_audit = CREATE n_ds
lds_sys_audit.DataObject ="ds_view_audit_save"// "d_view_audit" modified by gavins 201208015
lds_sys_audit.of_SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01/18/2008 By: Ken.Guo
//$<reason> Comment it, Because lds_ctx_sys_audit will ref to inv_dwcache.datastore
/*
lds_ctx_sys_audit = CREATE n_ds
lds_ctx_sys_audit.DataObject = "d_ctx_sys_audit"
*/
//lds_ctx_sys_audit.of_SetTransObject( SQLCA )
//lds_ctx_sys_audit.retrieve( )
//---------------------------- APPEON END ----------------------------
gnv_app.inv_dwcache.of_GetRegistered ('d_ctx_sys_audit',lds_ctx_sys_audit)
   
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01/18/2008 By: Ken.Guo
//$<reason>  Comment it, Because ids_ctx_sys_fields will ref to inv_dwcache.datastore
/*
ids_ctx_sys_fields = CREATE n_ds
ids_ctx_sys_fields.DataObject = "d_ctx_sys_fields"
*/
//ids_ctx_sys_fields.of_SetTransObject( SQLCA )
//ids_ctx_sys_fields.retrieve( )
//---------------------------- APPEON END ----------------------------

gnv_app.inv_dwcache.of_GetRegistered ('d_ctx_sys_fields',ids_ctx_sys_fields)
   

INV_DWSRV = CREATE N_CST_DWSRV
end event

event destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
//if IsValid(ids_ctx_sys_fields) then Destroy ids_ctx_sys_fields //Comment by Ken.Guo 2008-01-18. It's Ref object, Don't be destroyed.
if IsValid(INV_DWSRV) then Destroy INV_DWSRV
//---------------------------- APPEON END ----------------------------
end event

