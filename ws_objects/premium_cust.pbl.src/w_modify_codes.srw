$PBExportHeader$w_modify_codes.srw
$PBExportComments$Window allows for the user to modify the user entered codes.
forward
global type w_modify_codes from window
end type
type cb_4 from commandbutton within w_modify_codes
end type
type cb_1 from commandbutton within w_modify_codes
end type
type cb_import from commandbutton within w_modify_codes
end type
type cb_2 from commandbutton within w_modify_codes
end type
type tab_1 from tab within w_modify_codes
end type
type tabpage_1 from userobject within tab_1
end type
type st_2 from statictext within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_2 from datawindow within tabpage_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_2 st_2
st_1 st_1
dw_2 dw_2
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type st_4 from statictext within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type dw_4 from datawindow within tabpage_2
end type
type dw_3 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_4 st_4
st_3 st_3
dw_4 dw_4
dw_3 dw_3
end type
type tab_1 from tab within w_modify_codes
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_5 from datawindow within w_modify_codes
end type
end forward

global type w_modify_codes from window
string tag = "Code Modification"
integer x = 105
integer y = 36
integer width = 3433
integer height = 2104
boolean titlebar = true
string title = "Practitioner Import"
boolean controlmenu = true
boolean minbox = true
long backcolor = 80269524
cb_4 cb_4
cb_1 cb_1
cb_import cb_import
cb_2 cb_2
tab_1 tab_1
dw_5 dw_5
end type
global w_modify_codes w_modify_codes

type variables
long il_address_lookup_index
long il_code_lookup_index
long il_current_dw_2_row
long il_set_prac_id[]
long il_org_prac_id[]
//n_cst_import invo_import
string is_title

datawindow idw_2
datawindow idw_1

datawindow idw_3
datawindow idw_4

long ll_count
long il_import_time,il_update_time,il_replace_codes_time

///////////////////////////////////////////////////////

CONSTANT LONG   SUCCESS 			= 0						// all is ok
CONSTANT LONG   FAILURE 			= -1						// function failed
CONSTANT STRING NEW_LINE = '~r~n'					// new line  	
CONSTANT STRING CODE_LOOK_UP = 'C'
CONSTANT STRING ADDRESS_LOOK_UP = 'A'
CONSTANT LONG   PRACTITIONER_DOES_NOT_EXIST  = 0		


n_cst_string       lnv_string

string is_docname, is_named
string is_file_names[]              /* the parsed file list*/
string is_table_name[]

n_ds ids_lookup_dws[] 	// look up datawindows with *
n_ds ids_lookup2_dws[] 	// look up datawindows no *
n_ds ids_CREDANTIAL_dws[] // THE CREDENTIAL DATASTORES
n_ds ids_look_up_codes
n_ds ids_address_codes
n_ds ids_sys_fields



long il_current_prac_id
long il_new_prac_id
long  il_current_ds_index  // current n_ds
//long il_address_lookup_index
//long il_code_lookup_index
long il_pd_basic_tabel
long  il_value

n_ds ids_pd_affil_stat

datawindow dw_1// datawindow in tab 1
datawindow dw_2// datawindow in tab 2

datawindow dw_lookup1// datawindow in tab 1
datawindow dw_lookup2// datawindow in tab 2

oleobject iole_word
boolean ib_use_vb_open
any ia_any[]

pfc_cst_nv_data_entry_functions inv_data_entry
end variables

forward prototypes
public subroutine wf_replace_codes ()
public subroutine wf_set_new_code (datawindow adw_top, datawindow adw_bottom, ref datastore ads_code_lookup)
public function integer of_start_import ()
public function integer of_create_datastores (string as_table_name)
public function integer of_set_prac_ids ()
public function integer of_set_rec_ids ()
public function integer of_check_prac_exists (long al_row)
public function integer of_set_code_datastores ()
public function integer of_share_data (datawindow adw_top, datawindow adw_bottom, long ai_index)
public function integer of_replace_codes (datastore ads_look_up_ds, string as_lookup_type)
public subroutine of_update ()
public function integer of_connect_to_word ()
public function integer of_disconnect_from_word ()
public function integer of_replacechar (ref string as_string, string as_from, string as_to)
public function integer of_splitdirfile (string as_path, ref string as_dir, ref string as_filespec)
public function integer of_fileopen (ref string as_text)
public function integer of_open_import_file (boolean ab_use_vb)
public function integer wf_get_prac_id ()
public function long wf_get_lookup_code ()
public function integer wf_set_founf_fl (string as_lookup_type, long al_old_replacement_code, datastore ads_look_up_ds, long al_index, long al_counter)
public function boolean wf_check_code (string as_lookup_type, long al_lookup_code)
public function integer wf_delete_rows_not_found (datastore ads_look_up_ds, string as_lookup_type, long ai_table_index)
public function integer wf_delete_rows_existing (datastore ads_look_up_ds, string as_lookup_type, long ai_table_index)
public function integer wf_update_pd_affil_stat (long al_basic_index)
public function integer of_field_audit (n_ds adw)
public function long of_add_address_link ()
public function long wf_add_address_link (long al_facility_id, long al_prac_id)
public function long wf_add_hosp_link (long ai_facility_id, long al_prac_id)
public function long wf_add_spec_link (long al_facil_id, long al_prac_id)
public function integer of_decrypt (string as_fpath)
public function string of_set_dw (string as_table)
end prototypes

public subroutine wf_replace_codes ();//maha 112105 in here we have to get new codes for any lookups that are being added

//setredraw(false)
long ll_start
ll_start = Cpu()
of_replace_codes(ids_look_up_codes,CODE_LOOK_UP)
of_replace_codes(ids_address_codes,ADDRESS_LOOK_UP)

// Set ll_used to the number of CPU seconds that were used (current CPU time - start).
il_replace_codes_time = Cpu() - ll_start
w_import_progress.of_set_replace_code_time(il_replace_codes_time)
yield()

of_update()




end subroutine

public subroutine wf_set_new_code (datawindow adw_top, datawindow adw_bottom, ref datastore ads_code_lookup);
debugbreak()
long ll_selected_row_adw_top,ll_selected_row_adw_bottom
long ll_rep_code
long r
string ls_code_to_replace
string ls_replacing_code,ll_selected_row
long ll_found_row

if adw_top.rowcount() < 1 then return
if adw_top.GetRow( ) < 1 then 
	messagebox(is_title,'Please select a row in the top grid')
	return 
end if

if adw_bottom.GetRow( ) < 1 then 
	messagebox(is_title,'Please select a row in the bottom grid')
	return 
end if

ll_selected_row_adw_top = adw_top.GetRow( )
ls_code_to_replace = adw_top.object.code[adw_top.GetRow()]
r = adw_bottom.GetRow()
ls_replacing_code =  adw_bottom.object.code[r]
ll_rep_code = adw_bottom.object.lookup_code[r]


if messagebox(is_title,'Are you sure you want to replace the existing code with the new one?',question!,yesno!,1) = 1 then
	adw_bottom.setredraw(false)
	adw_top.setredraw(false)
	// find the row in the datastore
	ll_found_row = ads_code_lookup.find('new_code =' + string(adw_top.object.lookup_code[ll_selected_row_adw_top]),1, ads_code_lookup.rowcount())
	// set the new code
	//messagebox('',string(ll_found_row))
	if ll_found_row > 0 then
		//messagebox('test',string(adw_bottom.object.lookup_code[adw_bottom.getrow()]))
		//in the cross table update the replacement code the the code from the existing lookup
		ads_code_lookup.object.replacement_code[ll_found_row] = ll_rep_code//adw_bottom.object.lookup_code[adw_bottom.getrow()]
		ads_code_lookup.object.found[ll_found_row]  = "1"
		adw_bottom.RowsMove ( r, r, PRIMARY!, adw_top, 1,	primary! )
		adw_top.deleterow(ll_selected_row_adw_top + 1)
		adw_top.setitemstatus(1,0,primary!,notmodified!)
		//adw_bottom.RowsMove ( r, r, PRIMARY!, adw_top, 1,	primary! ) maha moved up because of rfc event
	end if
	
	adw_bottom.sort()
	
	adw_bottom.setredraw(true)
	adw_top.setredraw(true)
	
end if
end subroutine

public function integer of_start_import ();/******************************************************************************************************************
**  [PUBLIC]   : of_start_import
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long ll_i
long ll_ret
long ll_start
integer li_dwcnt


if of_open_import_file(false) = success then
		// retrieve the needed datastores

		SetPointer(hourglass!)
//		SetCapture(Handle(this)) // keeps the hourglass solid
		ll_start = Cpu()
		
			FOR ll_i = 1  TO  upperbound(is_file_names)  //is_file_names created in lnv_string.of_parsetoarray
				IF PosA ( is_file_names[ll_i], 'Export' ) > 0 THEN CONTINUE
					IF PosA ( is_file_names[ll_i], 'dba.' ) > 0 THEN
						of_create_datastores(is_file_names[ll_i])
					ELSE
					li_dwcnt = upperbound(ids_CREDANTIAL_dws[])
					 // import the string into the current datastore
					 if li_dwcnt > 0 then //maha112805 trap for no ds
					 	ll_ret =  ids_CREDANTIAL_dws[il_current_ds_index].ImportString (is_file_names[ll_i])
//					   if il_current_ds_index = il_address_lookup_index then
//							messagebox("Addresses lookup", string(ids_CREDANTIAL_dws[il_current_ds_index].rowcount()) )
//						end if
					 	IF ll_ret < 0 THEN
							messagebox('Import Error',string(ll_ret) + '   '  + is_table_name[il_current_ds_index])
					 	END IF 
					end if
				end if
				
			NEXT
			
		if upperbound(ids_CREDANTIAL_dws[]) < 1 then //trap added maha 112105
			messagebox("Import Error","The import file has no data, or may not have decrypted properly.")
			return failure
		end if
		
	   il_import_time = Cpu() - ll_start
		w_import_progress.of_set_import_time(il_import_time)
		yield()
	/////////////////////////////////////////////////////////////////////////////	
	// populate the look_up and address datastores
	/////////////////////////////////////////////////////////////////////////////
   of_set_code_datastores()
	/////////////////////////////////////////////////////////////////////////////////////////
	// update the prac_id
	//////////////////////////////////////////////////////////////////////////////////////////
	debugbreak()
	if of_set_prac_ids() = failure then return failure
		//includes a failure if prac exists
	   of_set_rec_ids()
	   ids_sys_fields.retrieve(is_table_name)
	
		dw_1 = w_modify_codes.tab_1.tabpage_1.dw_2
		dw_2 = w_modify_codes.tab_1.tabpage_2.dw_4
		dw_lookup1 = w_modify_codes.tab_1.tabpage_1.dw_1   //lower datawindow in tab 1
		dw_lookup2 = w_modify_codes.tab_1.tabpage_2.dw_3     //lower datawindow in tab 2
		//messagebox("il_code_lookup_index",il_code_lookup_index)
			//	messagebox("il_address_lookup_index",string(dw_2.rowcount()))
		if il_code_lookup_index > 0 then //maha
			of_share_data(dw_1,dw_lookup1,il_code_lookup_index) //2 shares with 1
		end if
		if il_address_lookup_index > 0 then //maha
			of_share_data(dw_2,dw_lookup2,il_address_lookup_index)//4 shares with 3
		end if
else
//	ReleaseCapture()
	RETURN FAILURE	
end if 

//ReleaseCapture() // release the hourglass


return 1

end function

public function integer of_create_datastores (string as_table_name);/******************************************************************************************************************
**  [PUBLIC]   : of_create_datastores
**==================================================================================================================
**  Purpose   	: creates the dynamic datastores for credentials
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	  
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
STRING ls_sql
STRING ls_presentation_str
STRING ls_dwsyntax_str
STRING ERRORS
string ls_dw_name
long ll_i


	

//   ls_sql = "Select * from " + AS_TABLE_NAME ;
//	ls_presentation_str = "Style(Type=grid)" 
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str,ERRORS)
//		
//	IF Len(ERRORS) > 0 THEN //this will fail if the table has not been completed
//		if pos(ERRORS,"Table or view not found",1) > 0 then
//			messagebox ("Error in of_export_data_with_text","Export data data store not able to be created.~rCheck to make sure no export fields have any spaces, and that all have a width." )
//			return failure
//		else
//			MessageBox("Caution", "SyntaxFromSQL caused these errors: " + ERRORS)
//		   RETURN failure
//		end if
//		
//	ELSE

ls_dw_name =  of_set_dw(as_table_name)
if ls_dw_name  = "NONE" then
	MessageBox("Caution", "Unable to import data for the " + as_table_name + " Screen.")
else
		 ll_I = (UPPERBOUND(ids_CREDANTIAL_dws) + 1)
		 ids_CREDANTIAL_dws[ll_i] = CREATE n_ds
		 
		 ids_CREDANTIAL_dws[ll_i].dataobject = ls_dw_name
		 
		/// messagebox('',string('d_' + Mid ( AS_TABLE_NAME, 5 ,len(AS_TABLE_NAME) ) ))
//		 choose case AS_TABLE_NAME
//			case 'dba.address_lookup'
//					ids_CREDANTIAL_dws[ll_i].dataobject = "d_imp_address_lookup"
//			case 'dba.code_lookup'
//				  ids_CREDANTIAL_dws[ll_i].dataobject = "d_imp_code_lookup"
//		   case else
//				  ids_CREDANTIAL_dws[ll_i].Create( ls_dwsyntax_str, ERRORS)
//		end choose
		
		 //MESSAGEBOX('',STRING(ids_CREDANTIAL_dws[ll_i].Object.DataWindow.Syntax))
		 ids_CREDANTIAL_dws[ll_i].settransobject(sqlca)
		 il_current_ds_index  = ll_I
		 if AS_TABLE_NAME = 'dba.code_lookup'    then il_code_lookup_index =  ll_I		
		 if AS_TABLE_NAME = 'dba.address_lookup' then 
			il_address_lookup_index =  ll_I
			//MessageBox("Address lookups", "lookups index- " + string(ll_i))
		end if
		 if AS_TABLE_NAME = 'dba.pd_basic'       then il_pd_basic_tabel = ll_I
		 is_table_name[ll_i] = as_table_name // KEEP TRACK OF THE TABLES IN THE ARRAY
		 w_import_progress.wf_add_table(as_table_name)

END IF
		


	
RETURN SUCCESS
end function

public function integer of_set_prac_ids ();/******************************************************************************************************************
**  [PRIVATE]   : of_set_prac_ids
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [success -1 , failure - 0]   
**==================================================================================================================
**  Notes     	: 
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_i,ll_j,ll_column_count,ll_k
long ll_prac_id
LONG ll_org_prac_id
LONG ll_new_prac_id
long ll_z
//debugbreak()

if il_pd_basic_tabel < 1 or isnull(il_pd_basic_tabel) then
	Messagebox("File error","Unable to correctly process file.  Please recopy from email and try again.")
	return 0
end if

FOR ll_z = 1 TO ids_credantial_dws[il_pd_basic_tabel].rowcount()
	ll_org_prac_id = ids_credantial_dws[il_pd_basic_tabel].getitemnumber(ll_z,"prac_id")
	il_org_prac_id[ll_z] = ll_org_prac_id //maha
	//////////////////////////////////////////////////////////////////
	// check to see of the prac exists if not create a new record
	//////////////////////////////////////////////////////////////////
	LONG LL_RET 
	LL_RET = of_check_prac_exists(ll_z)
	
	CHOOSE CASE LL_RET
		CASE  0
           ll_new_prac_id = gnv_app.of_get_id("prac_id")  //wf_get_prac_id() //get new prac_id
		//CASE FAILURE
		//		 return FAILURE
		CASE ELSE // DOES EXIST USE THAT PRAC_ID
			IF MESSAGEBOX('','The practitioner already exists in the database. Do you want to add him/her again?',question!,yesno!) = 1 then
				 ll_new_prac_id = gnv_app.of_get_id("prac_id")  //wf_get_prac_id()
			else
				return failure
			end if
		
	END CHOOSE
	il_set_prac_id[ll_z] = ll_new_prac_id //maha
      FOR  ll_i = 1 TO upperbound(ids_credantial_dws) //for each ds
			//ll_column_count = long(ids_credantial_dws[ll_i].Object.DataWindow.Column.Count) //for each ds find the prac_id field
			//	FOR  ll_j =1 TO ll_column_count
					
			//			IF pos(lower(ids_credantial_dws[ll_i].Describe("#" + String(ll_j) + ".name")), 'prac_id') > 0 then
							// REPLACE ALL THE PRAC IDS WITH NEW ONE
				if ll_i <> il_address_lookup_index and ll_i <> il_code_lookup_index then			
						  FOR  ll_k = 1 to ids_credantial_dws[ll_i].rowcount() //update prac_id data for that pracs records
								if ids_credantial_dws[ll_i].getitemnumber(ll_k,"prac_id") = ll_org_prac_id then 
							    	ids_credantial_dws[ll_i].setItem(ll_k,"prac_id",ll_new_prac_id)
								end if
						 NEXT
						 FOR  ll_k = ids_credantial_dws[ll_i].rowcount() to 1 step -1 //if no pracid delete the record maha 111505
							if isnull(ids_credantial_dws[ll_i].getitemnumber(ll_k,"prac_id")) then
								ids_credantial_dws[ll_i].deleterow(ll_k)
							end if
						next
				end if
			//		   END IF 
			//	 NEXT
		
		NEXT
NEXT


return 1
end function

public function integer of_set_rec_ids ();/******************************************************************************************************************
**  [PRIVATE]   : of_set_rec_ids
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [success -1 , failure - 0]   
**==================================================================================================================
**  Notes     	: 
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/	
	
	
long ll_i,ll_column_count,ll_j
long ll_rec_ids_total_count,LL_REC_ID,LL_NEW_REC_ID
LONG LL_NEW ,LL_K


////////////////////////////////////////////////////////////////////////////////
// get a count of all of the rec_ids
////////////////////////////////////////////////////////////////////////////////


//FOR ll_i = 1 TO upperbound(ids_credantial_dws)
//	 ll_column_count = long(ids_credantial_dws[ll_i].Object.DataWindow.Column.Count)
//	 FOR ll_j =1 TO ll_column_count
//		IF pos(ids_credantial_dws[ll_i].Describe("#" + String(ll_j) + ".name"), 'rec_id') > 0 then
//		 	ll_rec_ids_total_count ++
//		END IF  
//	NEXT
//NEXT
//\/maha

FOR ll_i = 1 TO upperbound(ids_credantial_dws)
	if ll_i <> il_address_lookup_index and ll_i <> il_code_lookup_index then  //maha 072705	
		 ll_column_count = ids_credantial_dws[ll_i].rowCount()
		 ll_rec_ids_total_count  = ll_rec_ids_total_count + ll_column_count
	end if
NEXT


////////////////////////////////////////////////////////////////////////////////
// NOW GET THE NEXT REC ID AND UPDATE IT TO REC ID + ll_rec_ids_total_count + 1
////////////////////////////////////////////////////////////////////////////////
debugbreak()
SELECT RECORD_ID
INTO :LL_REC_ID
FROM DBA.IDS;

LL_NEW  = LL_REC_ID + ll_rec_ids_total_count + 1
UPDATE DBA.IDS
SET RECORD_ID = :LL_NEW ;

////////////////////////////////////////////////////////////////////////////////
// NOW SET THE REC_IDS
////////////////////////////////////////////////////////////////////////////////

//FOR ll_i = 1 TO upperbound(ids_credantial_dws)
//	 ll_column_count = long(ids_credantial_dws[ll_i].Object.DataWindow.Column.Count)
//	 FOR ll_j =1 TO ll_column_count
//		IF pos(ids_credantial_dws[ll_i].Describe("#" + String(ll_j) + ".name"), 'rec_id') > 0 then
//		   FOR LL_K = 1 TO ids_credantial_dws[ll_i].ROWCOUNT()
//				ids_credantial_dws[ll_i].setItem(ll_k,ll_j,LL_REC_ID)
//				LL_REC_ID ++
//				
//				
//			NEXT
//		END IF  
//	NEXT
//	w_import_progress.wf_update_prac_import(0,ll_i)
//	YIELD()
//NEXT


FOR ll_i = 1 TO upperbound(ids_credantial_dws)
	if ll_i <> il_address_lookup_index and ll_i <> il_code_lookup_index then //maha 072705	
		FOR LL_K = 1 TO ids_credantial_dws[ll_i].ROWCOUNT()
			ids_credantial_dws[ll_i].setItem(ll_k,"rec_id",LL_REC_ID)
			LL_REC_ID ++  
		NEXT
		w_import_progress.wf_update_prac_import(0,ll_i)
		YIELD()
	end if
NEXT



RETURN SUCCESS
end function

public function integer of_check_prac_exists (long al_row);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: see is the practitioner exist in the destination database
**==================================================================================================================
**  Arguments 	: [al_row] the row in the pb_basic datastore
**==================================================================================================================
**  Returns   	: [long]    prac_id
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_first_name
string ls_last_name
string ls_ssn
long ll_prac_id = 0

ls_first_name = ids_credantial_dws[il_pd_basic_tabel].object.first_name[al_row]
ls_last_name  = ids_credantial_dws[il_pd_basic_tabel].object.last_name[al_row]
ls_ssn        = ids_credantial_dws[il_pd_basic_tabel].object.ssn[al_row]

select prac_id
into :ll_prac_id
from dba.pd_basic
where first_name =:ls_first_name and last_name = :ls_last_name and ssn =:ls_ssn ;

//if len(sqlca.SQLErrText	) > 0 then Messagebox('Sql Failure of_check_prac_exists ', sqlca.SQLErrText)
if isnull(ll_prac_id) then ll_prac_id = 0

return ll_prac_id
end function

public function integer of_set_code_datastores ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i

if il_code_lookup_index < 1 then return success // trap maha 090705
if isnull(il_code_lookup_index) then
	messagebox("of set code datastore","il_code_lookup_index null")
	return success //maha
end if

if il_address_lookup_index < 1 or isnull(il_address_lookup_index) then return success //maha 090705

//for each of the imported lookups create a cross record 
if ids_CREDANTIAL_dws[il_code_lookup_index].rowcount() > 0 then
	for ll_i = 1 to  ids_CREDANTIAL_dws[il_code_lookup_index].rowcount()
	 ids_look_up_codes.insertrow(ll_i)
    ids_look_up_codes.object.new_code[ll_i] = ids_CREDANTIAL_dws[il_code_lookup_index].object.lookup_code[ll_i]
	 ids_look_up_codes.object.replacement_code[ll_i] = ids_CREDANTIAL_dws[il_code_lookup_index].object.lookup_code[ll_i]
	 ids_look_up_codes.object.found[ll_i] = "0"
  next

end if


//messagebox("of set code datastore addresses rowcount",string(ids_CREDANTIAL_dws[il_address_lookup_index].rowcount()))
if ids_CREDANTIAL_dws[il_address_lookup_index].rowcount() > 0 then
	for ll_i = 1 to  ids_CREDANTIAL_dws[il_address_lookup_index].rowcount()
		 ids_address_codes.insertrow(ll_i)
		 ids_address_codes.object.new_code[ll_i] = ids_CREDANTIAL_dws[il_address_lookup_index].object.lookup_code[ll_i]
		 ids_address_codes.object.replacement_code[ll_i] = ids_CREDANTIAL_dws[il_address_lookup_index].object.lookup_code[ll_i]
		 ids_address_codes.object.found[ll_i] = "0"
	next
	
end if

return SUCCESS
end function

public function integer of_share_data (datawindow adw_top, datawindow adw_bottom, long ai_index);

string ls_filter

if ids_CREDANTIAL_dws[ai_index].rowcount() > 0 then
   ids_CREDANTIAL_dws[ai_index].sharedata(adw_top)

//////////////////////////////////////////////////////////////////////////////////////////
// Select and filter the detail based on the firsr row selected.
//////////////////////////////////////////////////////////////////////////////////////////

if adw_top.rowcount() > 0  then
		adw_top.SelectRow(1, TRUE)
	  if  adw_top.rowcount() > 0 then
		   ls_filter = "lookup_name = '" + string(adw_top.object.lookup_name[1]+" '")
		   adw_bottom.setfilter(ls_filter)
         adw_bottom.filter()
	end if 
end if

end if



return 1
end function

public function integer of_replace_codes (datastore ads_look_up_ds, string as_lookup_type);/******************************************************************************************************************
**  [PUBLIC]   : of_replace_codes
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [datastore]  ads_look_up_ds
					  [string ]		as_lookup_type c= code,a address
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

///////////////////////////////////////////////////////////////////////
// first look at the replacement fields for code_lookup
///////////////////////////////////////////////////////////////////////

SETPOINTER(HOURGLASS!)
boolean lb_code_found
LONG    LL_B
LONG    LL_A
long    ll_i
long    ll_j
long    ll_column_count
long    ll_k
long    ll_h
long    ll_start, ll_used
long    ll_lookup_code
long    ll_old_replacement_code
long ll_found_row
long ll_found_lookup
long ll_col_data
string ls_filter
STRING LS_1
string ls_col_name
string ls_col_type
string ls_col_data

//messagebox("as_lookup_type",as_lookup_type)
//halt
///////////////////////////////////////////////////////////////////////////
// note the code may be used  but not used!!!!!!!!!!!!!!!!!!!!1
///////////////////////////////////////////////////////////////////////////

// need to go backwards in the loop -- because we may be deleteing rows in the ads_look_up_ds datastore
FOR ll_i = ads_look_up_ds.rowcount() TO 1 STEP -1
	lb_code_found = false
       //messagebox('the replacement codse',string(ads_look_up_ds.object.replacement_code[ll_i]))
	IF f_validstr(TRIM(STRING(ads_look_up_ds.object.replacement_code[ll_i]))) THEN
		ll_old_replacement_code = ads_look_up_ds.object.replacement_code[ll_i]
		// we need to get a new lookup_code
		// check to see if replacement_code is in the data base before assignin it a new code
		//**** this could be a problem if the same new number is loaded into the database.
		//**** for each lookup not pointed to an existing record a new lookup code must be generated
		//maha replaced with next line 112805     if not wf_check_code(as_lookup_type,ll_old_replacement_code)  then //check to see if the lookup code exists in the table
		if ads_look_up_ds.object.found[ll_i] = "0" then //a new lookup not having been replaced set new lookup_code 
			//maha for each NEW lookup get a new lookup code
			SELECT dba.ids.lookup_code_id INTO :ll_lookup_code FROM dba.ids ;
				ads_look_up_ds.object.replacement_code[ll_i] = (ll_lookup_code )
				if as_lookup_type = "C" then //maha 112805 update the lookup import value
					ll_found_lookup = dw_1.find("lookup_code = " + string(ll_old_replacement_code),1,10000)
					if ll_found_lookup > 0 then 
						dw_1.setitem(ll_found_lookup,"lookup_code",ll_lookup_code)
					end if
				elseif as_lookup_type = "A" then
					ll_found_lookup = dw_2.find("lookup_code = " + string(ll_old_replacement_code),1,10000)
					if ll_found_lookup > 0 then 
						dw_2.setitem(ll_found_lookup,"lookup_code",ll_lookup_code)
					end if
				end if
				//messagebox("new code",ll_lookup_code)
				ll_lookup_code++
				update dba.ids SET lookup_code_id = :ll_lookup_code;
				// update the replacement code with a new one
 		     // ads_look_up_ds.object.replacement_code[ll_i] = (ll_lookup_code - 1 )  maha moved up
		end if
		
	END IF
//update the import data with the new lookup values
	FOR LL_J = 1 TO upperbound(ids_credantial_dws)  //loop through the data windows
		w_import_progress.wf_set_code_modification(0,ll_j) //highlight the row in the update window
		yield()
		if ll_j  <> il_code_lookup_index OR ll_j  <> il_address_lookup_index then  //skip lookup dws
			ls_filter = " sys_tables_table_name  = '" + is_table_name[LL_J] + " '"  +" and sys_fields_lookup_type = '" + as_lookup_type + " '" 
			ids_sys_fields.setfilter(ls_filter)  //filter the sysfields for the table and compare field names to the data dw.  
			ids_sys_fields.filter()
			IF ids_sys_fields.ROWCOUNT() > 0 THEN //for each field in the table (only ones with a lookup table)
					// now loop through the sys_field ds , if the column is the same as the ids_credantial_dws[ll_j] column name
					ll_column_count = long(ids_credantial_dws[LL_J].Object.DataWindow.Column.Count)
					FOR ll_K = 1 TO long(ll_column_count) // IF THERE IS MORE THEN ONE ROW THERE MUST BE LOOK UPS
						//ll_a = sysfields count
						//ll_j = import data window column count
						//ll_h = import data window row count
						//ll_i = lookup datawindow
						//ll_k = import data window column loop counter
						for ll_a = 1 to ids_sys_fields.ROWCOUNT()
							if ids_sys_fields.OBJECT.sys_fields_field_name[ll_a] = ids_credantial_dws[ll_j].Describe("#" + String(ll_K) + ".name") then
								//if the sys column is the same as the data window column name...
								ls_col_name = ids_credantial_dws[ll_j].Describe("#" + String(ll_K) + ".name")
								ls_col_type = ids_credantial_dws[ll_j].Describe("#" + String(ll_K) + ".coltype")
								if isnull(ls_col_type) or ls_col_type = "" then messagebox(ls_col_name,"none")
								for ll_H = 1 to ids_credantial_dws[ll_j].rowcount() //...go through the import data window rows
									if lower(MidA(ls_col_type,1,4)) = "char" then //trap for character fields maha 082905
										ls_col_data = ids_credantial_dws[ll_j].Getitemstring(ll_H,ls_col_name)
										if not isnumber(ls_col_data) then
											continue
										else
											ll_col_data = long(ls_col_data)
										end if
									else
										//messagebox(ls_col_name,ls_col_type)
										ll_col_data = ids_credantial_dws[ll_j].GetitemNumber(ll_H,ls_col_name)
									end if
									if ads_look_up_ds.object.new_code[ll_i] =  ll_col_data then //if the lookup table new code matches the 
										// messagebox('Replacing Code in: ' + ls_col_name,string(ads_look_up_ds.object.replacement_code[ll_i]))
										ids_credantial_dws[ll_j].setItem(ll_H,ls_col_name,ads_look_up_ds.object.replacement_code[ll_i])
										lb_code_found = true 											 										
										if as_lookup_type = "C" then
											wf_set_founf_fl(as_lookup_type,ll_old_replacement_code,ads_look_up_ds,il_code_lookup_index,ll_i)
										else //address
											wf_set_founf_fl(as_lookup_type,ll_old_replacement_code,ads_look_up_ds,il_address_lookup_index,ll_i)
										end if	 
									END IF
								NEXT
							END IF
						NEXT
					NEXT
		 	END IF
	 	end if
	NEXT
//	  END IF

NEXT

////////////////////////////////////////////////////////////////////////////////////////////
// loop through the replacment codes, delete rows that where the lookup already exists
////////////////////////////////////////////////////////////////////////////////////////////

//maha removed 112205
choose case as_lookup_type
	case "C"
		wf_delete_rows_not_found(ads_look_up_ds,as_lookup_type,il_code_lookup_index)
		wf_delete_rows_existing(ads_look_up_ds,as_lookup_type,il_code_lookup_index)
	case "A"
		wf_delete_rows_not_found(ads_look_up_ds,as_lookup_type,il_address_lookup_index)
		wf_delete_rows_existing(ads_look_up_ds,as_lookup_type,il_address_lookup_index)
	case else
		// not found
end choose






return 1
												  

end function

public subroutine of_update (); /******************************************************************************************************************
**  [PUBLIC]   : of_update
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long ll_i
long ll_j
long ll_replacement_code
BOOLEAN LB_EXISTS
long ll_found
long ll_found_codes[]
long ll_K
boolean lb_rollback 
string ls_err_messages[]
long  ll_start
ll_start = Cpu()
integer li_ok
string gotoERROR
integer cnt
integer mes

debugbreak()
/////////////////////////////////////////////////////////////////////////////////////////////
// make sure share data is off for all
/////////////////////////////////////////////////////////////////////////////////////////////

FOR ll_i = 1 to  UPPERBOUND(ids_credantial_dws)
	if ids_credantial_dws[ll_i].UPDATE() = -1 then
		if ll_i <> il_address_lookup_index and ll_i <> il_code_lookup_index then
			messagebox("Update failure on the datastore number " + string(ll_i), string(ids_credantial_dws[ll_i].getitemnumber(1,"rec_id")) + " - rec; " + string(ids_credantial_dws[ll_i].getitemnumber(1,"prac_id")) + " -prac")
		elseif ll_i = il_address_lookup_index then
			messagebox("Update failure on the Address lookup datastore " ,"")
		elseif ll_i = il_code_lookup_index then
			messagebox("Update failure on the Code lookup datastore " ,"")	
		end if	
		lb_rollback = true  
		cnt++
		//goto gotoERROR
	end if
			
		
   if is_table_name[ll_i] = 'dba.pd_basic' then
	    if wf_update_pd_affil_stat(ll_i) = failure then
			 w_import_progress.OF_SET_UPDATE(FAILURE,ll_i)
			return 
		 end if			
	end if
	w_import_progress.OF_SET_UPDATE(SUCCESS,ll_i)
	YIELD()
NEXT


IF upperbound(ls_err_messages) < 1 then	
	FOR ll_i = 1 to  UPPERBOUND(ids_credantial_dws)
		if not lb_rollback then
			w_import_progress.st_header.text = 'Updating Audit fields'
			w_import_progress.wf_set_vis(ll_i)
			yield()
		   IF of_field_audit(ids_credantial_dws[ll_i]) = failure then 
				
			   lb_rollback = true
			   rollback;
				// return 
			else
				if ll_i = il_pd_basic_tabel then
					w_import_progress.st_header.text = 'Creating Links'
					yield()
//					if  of_add_address_link() = failure then //maha moved lower
//						  lb_rollback = true
//					end if
				 end if 
			end if
		end if
	next

//	gotoError:
	
	if lb_rollback then 
		
		mes = messagebox('Import Failure','Errors were generated importing data on ' + string(cnt) + ' Screens.  Do you wish to import the rest of the data?',question!,yesno!,2)
		if mes = 2 then
			rollback;
			return
		end if
	end if
			
	//else 
		app_filler.ids_address_dddw.Retrieve() //maha 120505 reretrieve the address lookups so data displays properly
		w_import_progress.st_header.text = 'Commiting Records'
		yield()
		commit using sqlca;
		if of_add_address_link() = failure then  //maha 080405
			w_import_progress.st_header.text = 'Unable to Add all links'
		end if	
		IF LenA(SQLCA.SQLErrText) < 1 THEN
			w_import_progress.ST_HEADER.TEXT = 'Process Completed'
		end if
	//end if
		
end if



// Set ll_used to the number of CPU seconds that were used (current CPU time - start).
w_import_progress.of_set_update_time(il_import_time)
il_update_time = Cpu() - ll_start
yield()


end subroutine

public function integer of_connect_to_word ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_connect_to_word
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


iole_word = CREATE oleobject
if iole_word.Connecttonewobject("word.application") <> 0 then
	messagebox('Client Error', 'This application could nbot connect to Microsoft Word. Please make sure it is properly installed.')
	return -1
end if 

iole_word.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2008-07-22

return 1

end function

public function integer of_disconnect_from_word ();IF ISVALID(iole_word) THEN
   iole_word.DisconnectObject ( )
END IF

return 1
end function

public function integer of_replacechar (ref string as_string, string as_from, string as_to);/******************************************************************************************************************
**  [PUBLIC]   : of_ReplaceChar
**==================================================================================================================
**  Purpose   	: Replace a String with a String. This function is inlined for speed but you could replace this with a call to your
**				     class library equivalent.
**==================================================================================================================
**  Arguments 	: [string] as_String: String to replace the characters in.
**					  [string] as_From: String of characters to replace		
**					  [string] as_To: String of characters to change to
**==================================================================================================================
**  Returns   	: [long]    SUCCESS OR FAILURE
**==================================================================================================================
**  Notes     	: For best effect only pass in the path to the default file, otherwise word will give unpredicatable
**				     results that will confuse your user!
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

Integer li_Pos, li_Width, li_Len, li_LenP1

li_Len = LenA( as_From )
li_LenP1 = li_Len + 1
li_Width = LenA( as_From ) - 1
li_Pos = PosA( as_String, as_From )
DO WHILE li_Pos > 0
	as_String = LeftA( as_String, li_Pos -1 ) + as_To + &
		RightA( as_String, LenA( as_String ) - li_Pos - li_Width )
	li_Pos = PosA( as_String, as_From, li_Pos + li_LenP1 )
LOOP

return 1

end function

public function integer of_splitdirfile (string as_path, ref string as_dir, ref string as_filespec);// PB6 Bug Fix
/********************************************************************
	SplitDirFile

	<DESC>	Split a Full filename and path into the dir and the file
				spec. For example C:\*.* would be split into C:\ and *.*
				</DESC>

	<RETURN> integer:
				<LI>1, processed ok
				<LI>-1, error spliting path</RETURN>

	<ACCESS> Protected

	<ARGS>	as_path: Full path to split out.
				as_dir: The Dir portion of the path.
				as_filespec: The Filespec of the path.</ARGS>

	<USAGE>	this.SplitDirFile( ls_Path, ls_Dir, ls_FN )</USAGE>

********************************************************************/
Long ll_Pos

IF LenA( as_path ) = 0 THEN RETURN -1

ll_Pos = PosA( as_path, '\' ) // lastpos
IF ll_Pos <= 0 THEN RETURN -1

as_Dir = LeftA( as_Path, ll_Pos )
IF ll_Pos = LenA( as_Path ) THEN
	as_FileSpec = '*.*'
ELSE
	as_FileSpec = MidA( as_Path, ll_Pos + 1 )
END IF

RETURN 1
end function

public function integer of_fileopen (ref string as_text);/******************************************************************************************************************
**  [PUBLIC]   : of_fileOpen
**==================================================================================================================
**  Purpose   	: This function uses the Word Dialog function to open the File Open dialog. The file choosen by the user replaces
**				     the default directory passed in.
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: For best effect only pass in the path to the default file, otherwise word will give unpredicatable
**				     results that will confuse your user!
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


OleObject  lole_Open, lole_Find
String ls_FN, ls_Path, ls_Spec, ls_Dir
Long ll_RC

SetPointer( HourGlass! )

iole_word.Application.Visible = False
iole_word.Application.WindowState = 2

////////////////////////////////////////////////////////////////////////////////////////////////
// If the developer has passed in a filename then we strip it out into path and file spec. 
//That way we can change the directory to the directory he wants and use the file spec for the dialog.
////////////////////////////////////////////////////////////////////////////////////////////////

this.of_SplitDirFile( as_Text, ls_Dir, ls_Spec )
iole_word.Application.ChangeFileOpenDirectory( ls_Dir )
lole_Open = iole_word.Application.Dialogs[80]
lole_Open.Name = ls_Spec

ll_RC = lole_Open.Display

IF ll_RC <> -1 THEN
	iole_word.Application.Quit
	iole_word.DisconnectObject()
	DESTROY iole_word
	DESTROY lole_Open
	DESTROY lole_Find
	RETURN  FAILURE
END IF

lole_Find = iole_word.Application.Dialogs[99]
ls_FN = lole_Open.Name
ls_Path = lole_Find.SearchPath
iole_word.Application.Quit
iole_word.DisconnectObject()
DESTROY iole_word
DESTROY lole_Open
DESTROY lole_Find

// Get rid of any quotes in the path or filename
of_ReplaceChar( ls_FN, '"', '' )
of_ReplaceChar( ls_Path, '"', '' )
IF RightA( ls_Path, 1 ) <> '\' THEN ls_Path += '\'
as_Text = ls_Path + ls_FN

RETURN 1

end function

public function integer of_open_import_file (boolean ab_use_vb);/******************************************************************************************************************
**  [PUBLIC]   : of_open_import_file
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long   ll_FileNum
long   ll_return 
blob   b_text_blob
string ls_file_dump
long c
//string ls_file_path

//debugbreak()
if ab_use_vb then
	of_connect_to_word()
	is_docname = 'c:\*.isg'
	IF of_FileOpen(is_docname) = FAILURE THEN 
		///IF GetFileOpenName("Select File For Import",  is_docname, is_named, "DOC", "IntelliSoftGroup Export Files (*.ISG),*.ISG," ) <> 1 THEN
			//RETURN FAILURE
		//END IF
	END IF
else
	debugbreak()
	if GetFileOpenName("Select File For Import",  is_docname, is_named, "CPT", "IntelliSoftGroup Export Files (*.CPT),*.CPT," ) = 1 then
		ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
		of_decrypt(is_docname)	
	//if GetFileOpenName("Select File For Import",  is_docname, is_named, "ISG", "IntelliSoftGroup Export Files (*.ISG),*.ISG," ) = 1 then
		open(w_import_progress)
	else
		ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
		return failure  
	end if 	
end if

//is_docname is changed in of_decrypt to strip the .cpt

for c = 1 to 30000 // wait for decrypt to finish
	if fileexists(is_docname) then continue	
next

if not fileexists(is_docname) then
	integer ta
	ta = messagebox("File error","Unable to find decrypted file " + is_docname + ".  Decryption may not be completed, or Check to see if encription software is installed. (in the encrypt folder of the IntelliCred folder).  Try again to find file?",Question!,yesno!,1 )
	if ta = 1 then
		if not fileexists(is_docname) then
			ta = messagebox("File error","Still Unable to find decrypted file " + is_docname + ". One more time?",Question!,yesno!,1 )
			if ta = 1 then
				if not fileexists(is_docname) then 
					messagebox("File error","Still Unable to find decrypted file. Check to see if encription software is installed.  Canceling import")
					return  ll_return
				end if
			end if
		end if
	end if
end if

if ll_return <> failure then 
	ll_FileNum = FileOpen(is_docname,StreamMode! )
	FileRead ( ll_FileNum , b_text_blob)
	ls_file_dump = string(b_text_blob)
	fileclose(ll_FileNum)
	lnv_string.of_parsetoarray(ls_file_dump, new_line, is_file_names)
	ll_return = success
end if 

if is_docname = 'c:\*.isg' then // nothing returened
	ll_return  =failure
end if 

return  ll_return
end function

public function integer wf_get_prac_id ();long ll_prac_id



select prac_id into :ll_prac_id from dba.ids;

ll_prac_id++

UPDATE dba.ids SET prac_id = ll_prac_id  ; 
commit;

return ll_prac_id
end function

public function long wf_get_lookup_code ();/******************************************************************************************************************
**  [PUBLIC]   : wf_get_lookup_code
**==================================================================================================================
**  Purpose   	: The get the next lookup code
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_lookup_code

select lookup_code_id
into :ll_lookup_code
from dba.ids;

debugbreak()
update dba.ids set lookup_code_id = ll_lookup_code + 1;


return ll_lookup_code



end function

public function integer wf_set_founf_fl (string as_lookup_type, long al_old_replacement_code, datastore ads_look_up_ds, long al_index, long al_counter);//(as_lookup_type,al_old_replacement_code,ads_look_up_ds,al_index,al_counter)

long ll_found_row


	ll_found_row = ids_credantial_dws[al_index].Find ( 'lookup_code = ' + string(al_old_replacement_code), 1, ids_credantial_dws[al_index].rowcount() )
	if ll_found_row > 0 then
		ids_credantial_dws[al_index].object.lookup_code[ll_found_row] = ads_look_up_ds.object.replacement_code[al_counter]
		ads_look_up_ds.object.found[al_counter] = "Y"
	end if 


return success
end function

public function boolean wf_check_code (string as_lookup_type, long al_lookup_code);/******************************************************************************************************************
**  [PUBLIC]   : wf_check_code
**==================================================================================================================
**  Purpose   	: Looks into the database to see if the code exists
**==================================================================================================================
**  Arguments 	: [string] as_lookup_type
**					  [long  ] al_lookup_code
**==================================================================================================================
**  Returns   	: [boolean]   True if the code exists, false if it does not
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


boolean lb_return
long ll_j

choose case as_lookup_type
	case "C"
		select count(*)
	   into : ll_j
	   from  dba.code_lookup
	   where lookup_code = :al_lookup_code;
					
	case "A"
		select count(*)
	   into : ll_j
	   from  dba.address_lookup
	   where lookup_code = :al_lookup_code;
				
	case else
		messagebox('wf_check_code', 'Lookup type not found')
		
end choose
		
if ll_j > 0 then
	 lb_return = true
end if		


return lb_return
end function

public function integer wf_delete_rows_not_found (datastore ads_look_up_ds, string as_lookup_type, long ai_table_index);
/******************************************************************************************************************
**  [PUBLIC]   : WF_DELETE_ROWS_NOT_FOUND
**==================================================================================================================
**  Purpose   	: Deletes the rows not found in the test file
**==================================================================================================================
**  Arguments 	: [datastore]  ads_look_up_ds external datastore
**             : [string]     as_lookup_type (c or a)
**					: [long]		   ai_table_index (code or address lookup tabel)
**==================================================================================================================
**  Returns   	: [long]   0 = SUCCESS, -1 FAILURE
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_found
long ll_i
long ll_lookup_code
long ll_found_row



FOR ll_i = ads_look_up_ds.rowcount() TO 1 STEP -1
   ll_lookup_code = ads_look_up_ds.OBJECT.new_code[ll_i]
	ll_found_row = ids_credantial_dws[ai_table_index].Find ( 'lookup_code = ' + string(ll_lookup_code), 1, ads_look_up_ds.rowcount() )
	ls_found = ads_look_up_ds.object.found[ll_i]
	
	if ll_found_row > 0 and ls_found <> "Y" then
		ids_credantial_dws[ai_table_index].deleterow(ll_found_row)
	end if
	
next

return SUCCESS
end function

public function integer wf_delete_rows_existing (datastore ads_look_up_ds, string as_lookup_type, long ai_table_index);
/******************************************************************************************************************
**  [PUBLIC]   : WF_DELETE_existing
**==================================================================================================================
**  Purpose   	: Deletes the rows not found in the database
**==================================================================================================================
**  Arguments 	: [datastore]  ads_look_up_ds external datastore
**             : [string]     as_lookup_type (c or a)
**					: [long]		   ai_table_index (code or address lookup tabel)
**==================================================================================================================
**  Returns   	: [long]   0 = SUCCESS, -1 FAILURE
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i,ll_j
long ll_lookup_code

if ai_table_index = 0 then return success
//messagebox("ai_table_index",ai_table_index)
FOR ll_i = ids_credantial_dws[ai_table_index].rowcount() TO 1 STEP -1

	ll_lookup_code = ids_credantial_dws[ai_table_index].OBJECT.lookup_code[ll_i]
	choose case as_lookup_type
		case "C"
			   select count(*)
			   into : ll_j
			   from  dba.code_lookup
			   where lookup_code = :ll_lookup_code;
		CASE "A"
				select count(*)
			   into : ll_j
			   from  dba.ADDRESS_LOOKUP
			   where lookup_code = :ll_lookup_code;
		case else
	end choose
		
	if ll_j > 0 then
		ids_credantial_dws[ai_table_index].deleterow(ll_i)
	end if 
NEXT



return SUCCESS
end function

public function integer wf_update_pd_affil_stat (long al_basic_index);




long ll_i 
long ll_return
long ll_row_count
long LL_REC_ID
long LL_NEW

///////////////////////////////////////////////////////////////////\
// Get the rowcount
///////////////////////////////////////////////////////////////////

ll_row_count = ids_credantial_dws[al_basic_index].rowcount() 

SELECT RECORD_ID
INTO :LL_REC_ID
FROM DBA.IDS;

LL_NEW  = LL_REC_ID + ll_row_count + 1
UPDATE DBA.IDS
SET RECORD_ID = :LL_NEW ;


for ll_i  = 1 to  ll_row_count
		ids_pd_affil_stat.insertrow(0)
		ids_pd_affil_stat.object.prac_id[ids_pd_affil_stat.rowcount()] = ids_credantial_dws[al_basic_index].object.prac_id[ll_i]
		ids_pd_affil_stat.object.rec_id[ids_pd_affil_stat.rowcount()] = LL_REC_ID
		ids_pd_affil_stat.setitem(ids_pd_affil_stat.rowcount(),"parent_facility_id",2 )
		ids_pd_affil_stat.setitem(ids_pd_affil_stat.rowcount(),"verifying_facility",2 )
		ids_pd_affil_stat.setitem(ids_pd_affil_stat.rowcount(),"application_audit_facility",2 )
		ids_pd_affil_stat.setitem(ids_pd_affil_stat.rowcount(),"prov_status",0 )
		ids_pd_affil_stat.setitem(ids_pd_affil_stat.rowcount(),"apptmnt_type","I" )
		ids_pd_affil_stat.setitem(ids_pd_affil_stat.rowcount(),"affiliation_status","M" )
		LL_REC_ID++
next
			
if ids_pd_affil_stat.update() < 1 then
	ll_return = failure
end if 


			
return ll_return	
		
end function

public function integer of_field_audit (n_ds adw);Integer i
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

lds_audit_fields = CREATE n_ds
lds_audit_fields.DataObject = "d_audit_fields"
lds_audit_fields.SetTransObject( SQLCA )
li_col_cnt = lds_audit_fields.Retrieve( ls_table_name )
//messagebox("audit fields",li_col_cnt)
IF li_col_cnt < 1 THEN
//	messagebox("audit fields",li_col_cnt)
	Return SUCCESS
END IF

lds_sys_audit = CREATE n_ds
lds_sys_audit.DataObject = "d_view_audit"
lds_sys_audit.SetTransObject( SQLCA )

lds_last_seq_no = CREATE n_ds
lds_last_seq_no.DataObject = "d_get_last_field_audit_seq_no"
lds_last_seq_no.SetTransObject( SQLCA )

li_rc = adw.RowCount()

li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )

select facility_specific into :li_fs from dba.sys_tables where table_id = :li_table_id;


FOR i = 1 TO li_rc
		ll_rec_id = adw.GetItemNumber( i, "rec_id" ) 
		if li_fs = 1 then
			if ls_table_name = "dba.pd_affil_stat" then
				ll_facility_id = adw.GetItemNumber( i, "parent_facility_id" )
			else
				ll_facility_id = adw.GetItemNumber( i, "facility_id" )
			end if
		end if

		ll_field_id = 1000 
	
		choose case ls_table_name
			case "dba.pd_affil_stat"
				ll_new_value = adw.GetItemnumber( i, "parent_facility_id" )
				select facility_name into :ls_value1 from dba.facility where facility_id = :ll_new_value;
				ls_value2 = adw.GetItemstring( i, "apptmnt_type" )
				ls_new_value = ls_value1 + "-" + ls_value2
			case "dba.pd_affil_dept"
				ll_new_value = adw.GetItemnumber( i, "department" )
				select description into :ls_value2 from dba.code_lookup where lookup_code = :ll_new_value;
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				select facility_name into :ls_value1 from dba.facility where facility_id = :ll_new_value;
				ls_new_value = ls_value1 + "-" + ls_value2
			case "dba.pd_affil_staff_cat"
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				select facility_name into :ls_value2 from dba.facility where facility_id = :ll_new_value;
				ll_new_value = adw.GetItemnumber( i, "staff_category" )
				select description into :ls_value1 from dba.code_lookup where lookup_code = :ll_new_value;
				ls_new_value = ls_value1 + "-" + ls_value2
			case "dba.pd_affil_staff_leave"
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				select facility_name into :ls_value2 from dba.facility where facility_id = :ll_new_value;
				ll_new_value = long(adw.GetItemstring( i, "leave_of_absence_reason" ))
				select description into :ls_value1 from dba.code_lookup where lookup_code = :ll_new_value;
				ls_new_value = ls_value1 + "-" + ls_value2
			case else //data entry screens
				//ls_new_value = of_get_reference_val(li_table_id)
				//get reference field 1
				select reference_field_1 into :ll_field_id1  from dba.data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
				//get reference field 2
				select reference_field_2 into :ll_field_id2  from dba.data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
				//get reference field name 1
				select field_name into :ls_fld_nm from dba.sys_fields where field_id = :ll_field_id1;
				if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				select field_name into :ls_fld_nm2 from dba.sys_fields where field_id = :ll_field_id2;
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
				
				//ref 1 data
				//datatype and lookup field
				select field_type into :ls_fld_type from dba.sys_fields where field_id = :ll_field_id1;
				select lookup_type into :ls_lookup_type from dba.sys_fields where field_id = :ll_field_id1;

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

				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value1) //convert to number
					select description into :ls_value1 from dba.code_lookup where lookup_code = :ll_new_value;
				elseif ls_lookup_type = "A" then

					ll_new_value = long(ls_value1)
					select entity_name into :ls_value1 from dba.address_lookup where lookup_code = :ll_new_value;
				
				end if
				
	
				//reference 2 info
				select field_type into :ls_fld_type from dba.sys_fields where field_id = :ll_field_id2;
				select lookup_type into :ls_lookup_type from dba.sys_fields where field_id = :ll_field_id2;

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
					select description into :ls_value2 from dba.code_lookup where lookup_code = :ll_new_value;
				elseif ls_lookup_type = "A" then
					ll_new_value = long(ls_value2)
					select entity_name into :ls_value2 from dba.address_lookup where lookup_code = :ll_new_value;
				end if
				//check for nulls
				if isnull(ls_value1) then ls_value1  = ""
				if isnull(ls_value2) then ls_value2  = ""
				ls_new_value = ls_value1 + "-" + ls_value2
				ls_new_value = MidA(ls_new_value,1,100)

		end choose
		
		ll_seq_rc = lds_last_seq_no.Retrieve( ll_rec_id, ll_field_id )
	
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

		li_nr = lds_sys_audit.InsertRow( 0 )
		lds_sys_audit.SetItem( li_nr, "rec_id", ll_rec_id )
		lds_sys_audit.SetItem( li_nr, "prac_id", adw.GetItemNumber( i, "prac_id" ) )					
		lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )										
		lds_sys_audit.SetItem( li_nr, "table_id", li_table_id )
		lds_sys_audit.SetItem( li_nr, "field_id", 1000 )
		lds_sys_audit.SetItem( li_nr, "new_value", ls_new_value )
//mbs		lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
     lds_sys_audit.SetItem( li_nr, "user_id", 'mbs') 
		lds_sys_audit.SetItem( li_nr, "audit_type", "I" )					
		lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Today(), Now() ) )
		lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )
		
		//lds_sys_audit.SetItem( li_nr, "facility_id", 1)
//		if li_fs = 1 then
//			lds_sys_audit.SetItem( li_nr, "facility_id", ll_facility_id )
//		else
//			lds_sys_audit.SetItem( li_nr, "facility_id", 0)
//		end if
//		
///************************DELETE code moved to separate function
	
	//END IF
END FOR


IF lds_sys_audit.Update() = -1 THEN
	MessageBox("", "Update to sys_audit table Failed!")
	Return -1
END IF


RETURN 1
end function

public function long of_add_address_link ();/******************************************************************************************************************
**  [PUBLIC]   : of_add_address_link
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [long] success = 0, failure = -1   
**==================================================================================================================
**  Notes     	: Facility id is always set to one 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i
long ll_prac_id
long ll_return
constant long FACILITY_ID =  2

if il_pd_basic_tabel < 1 or isnull(il_pd_basic_tabel) then //trap maha 090705
	messagebox("of_add_address_link","failure to find il_pd_basic_tabel value")
	return failure
end if


FOR LL_i = 1 TO ids_credantial_dws[il_pd_basic_tabel].rowcount()
	   if ll_return <> failure then
	     ll_prac_id  =  ids_credantial_dws[il_pd_basic_tabel].object.prac_id[ll_i]
		  if wf_add_address_link(FACILITY_ID,ll_prac_id) = FAILURE THEN RETURN FAILURE
		  if wf_add_hosp_link(FACILITY_ID,ll_prac_id) = FAILURE THEN RETURN FAILURE
		  if wf_add_spec_link(FACILITY_ID,ll_prac_id) = FAILURE THEN RETURN FAILURE
	   end if
NEXT	


return ll_return
end function

public function long wf_add_address_link (long al_facility_id, long al_prac_id);/******************************************************************************************************************
**  [PUBLIC]   : WF_ADD_ADDRESS_LINK
**==================================================================================================================
**  Purpose   	: Update the link tabels
**==================================================================================================================
**  Arguments 	: [long] AL_FACILITY_ID
**					  [long] AL_PRAC_ID
**==================================================================================================================
**  Returns   	: [long]   success = 0 ,failire = -1
**==================================================================================================================
**  Notes     	: 	Function copied from pfc_cst_nv_data_entry_functions , did not exist in the current object   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


Integer li_address_cnt
Integer i
Integer li_nr
Long ll_address_id
n_ds lds_address_link
n_ds lds_all_addresses

lds_address_link = CREATE n_ds
lds_address_link.DataObject = "d_address_link"
long ll_addr_id //maha 02-26-01
long ll_type
integer cnt

lds_address_link.SetTransObject( SQLCA )

lds_all_addresses = CREATE n_ds
lds_all_addresses.DataObject = "d_address_link_all_addresses"
lds_all_addresses.SetTransObject( SQLCA )
li_address_cnt = lds_all_addresses.Retrieve( al_prac_id )

//for each address put an entry in the address link table for the new facility being added
FOR i = 1 TO li_address_cnt
	//\/maha 02-26-01 check to see if link already exists 
	ll_addr_id = lds_all_addresses.GetItemNumber( i, "rec_id" )	
	ll_type = long(lds_all_addresses.GetItemstring( i, "cust_5" ))
	select count(*)
	into :cnt
	from dba.pd_address_link
	where prac_id = :al_prac_id and facility_id = :AL_FACILITY_ID and address_id = :ll_addr_id;
	if cnt > 0 then continue
	//\maha
	li_nr = lds_address_link.InsertRow( 0 )	
	lds_address_link.SetItem( li_nr, "prac_id", al_prac_id )
	lds_address_link.SetItem( li_nr, "address_id", ll_addr_id )
	lds_address_link.SetItem( li_nr, "facility_id", AL_FACILITY_ID )
	lds_address_link.SetItem( li_nr, "home_address", 0 )
	lds_address_link.SetItem( li_nr, "primary_office", 0 )
	lds_address_link.SetItem( li_nr, "additional_office", 0 )
	lds_address_link.SetItem( li_nr, "mailing", 0 )
	lds_address_link.SetItem( li_nr, "exp_letters", 0 )
	lds_address_link.SetItem( li_nr, "billing", 0 )
	lds_address_link.SetItem( li_nr, "include_in_directory", 0)
	choose case ll_type
		case 648 //home
			lds_address_link.SetItem( li_nr, "home_address", 1 )
		case 647 //prime
			lds_address_link.SetItem( li_nr, "primary_office", 1 )
			lds_address_link.SetItem( li_nr, "mailing", 1 )
			lds_address_link.SetItem( li_nr, "exp_letters", 1 )
		case 256 //additional 
			lds_address_link.SetItem( li_nr, "additional_office", 1 )
	end choose
END FOR

IF lds_address_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating address link table." )
	DESTROY lds_address_link
	DESTROY lds_all_addresses
	RETURN FAILURE
END IF


DESTROY lds_address_link
DESTROY lds_all_addresses

RETURN SUCCESS

end function

public function long wf_add_hosp_link (long ai_facility_id, long al_prac_id);/******************************************************************************************************************
**  [PUBLIC]   : wf_add_hosp_link
**==================================================================================================================
**  Purpose   	: Update the link tabels
**==================================================================================================================
**  Arguments 	: [long] AL_FACILITY_ID
**					  [long] AL_PRAC_ID
**==================================================================================================================
**  Returns   	: [long]   success = 0 ,failire = -1
**==================================================================================================================
**  Notes     	: 	Function copied from pfc_cst_nv_data_entry_functions , did not exist in the current object   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

Integer li_hosp_cnt
Integer i
Integer li_nr
Integer li_found
long ll_rec //maha 121702
Long ll_hosp_id
long ll_prim
n_ds lds_hosp_link
n_ds lds_all_hosp

lds_hosp_link = CREATE n_ds
lds_hosp_link.DataObject = "d_hf_link"
lds_hosp_link.SetTransObject( SQLCA )
lds_hosp_link.Retrieve( al_prac_id )

lds_all_hosp = CREATE n_ds
lds_all_hosp.DataObject = "d_hosp_affil_prac"
lds_all_hosp.SetTransObject( SQLCA )
li_hosp_cnt = lds_all_hosp.Retrieve( al_prac_id )

//for each hospital put an entry in the hospital link table for the new facility being added
FOR i = 1 TO li_hosp_cnt
	ll_rec = lds_all_hosp.GetItemNumber( i, "rec_id" )
	ll_prim = lds_all_hosp.GetItemNumber( i, "primary_hosp" )
	li_found = lds_hosp_link.Find( "facility_id = " + String( ai_facility_id ) + " and hosp_affil_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF
	li_nr = lds_hosp_link.InsertRow( 0 )	
	lds_hosp_link.SetItem( li_nr, "prac_id", al_prac_id )
	lds_hosp_link.SetItem( li_nr, "hosp_affil_id", ll_rec )
	lds_hosp_link.SetItem( li_nr, "facility_id", ai_facility_id )
	lds_hosp_link.SetItem( li_nr, "primary_hosp", ll_prim)
END FOR

IF lds_hosp_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating Hospital link table." )
	DESTROY lds_hosp_link
	DESTROY lds_all_hosp
	RETURN failure
END IF


DESTROY lds_hosp_link
DESTROY lds_all_hosp

RETURN success


end function

public function long wf_add_spec_link (long al_facil_id, long al_prac_id);/******************************************************************************************************************
**  [PUBLIC]   : ef_add_spec_link
**==================================================================================================================
**  Purpose   	: Update the link tabels
**==================================================================================================================
**  Arguments 	: [long] AL_FACILITY_ID
**					  [long] AL_PRAC_ID
**==================================================================================================================
**  Returns   	: [long]   success = 0 ,failire = -1
**==================================================================================================================
**  Notes     	: 	Function copied from pfc_cst_nv_data_entry_functions , did not exist in the current object   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
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
lds_spec_link.SetTransObject( SQLCA )
lds_spec_link.Retrieve( al_prac_id )

lds_all_spec = CREATE n_ds
lds_all_spec.DataObject = "d_spec_of_prac"
lds_all_spec.SetTransObject( SQLCA )
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
	lds_spec_link.SetItem( li_nr, "practicing", 581 )
next

IF lds_spec_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating specialty link table." )
	DESTROY lds_spec_link
	DESTROY lds_all_spec
	RETURN FAILURE
END IF


DESTROY lds_spec_link
DESTROY lds_all_spec

RETURN SUCCESS


end function

public function integer of_decrypt (string as_fpath);integer i
string runpath
string ls_loc

ls_loc = as_fpath
is_docname = MidA(as_fpath,1,LenA(as_fpath) - 4)
ls_loc = '"' + as_fpath + '"'
if not fileexists(as_fpath) then
	messagebox("Decription","Unable to find file " + as_fpath)
	return -1
end if
runpath = gs_dir_path + "intellicred\encrypt\ccrypt.exe --decrypt --key 70157 " + ls_loc 
//messagebox("",runpath)
i = run(runpath)


//messagebox("result",is_docname)

return i
end function

public function string of_set_dw (string as_table);string ret
 

choose case as_table
	case "dba.address_lookup"
		ret = "d_imp_address_lookup"
	case "dba.code_lookup"
		ret = "d_imp_code_lookup"
	case "dba.pd_basic"
		ret = "d_pexport_basic"
	case "dba.pd_address"
		ret = "d_pexport_address"
	case "dba.pd_insurance"
		ret = "d_pexport_insurance"
	case "dba.pd_education"
		ret = "d_pexport_education"
	case "dba.pd_ecfmg"
		ret = "d_pexport_ecfmg"
	case "dba.pd_training"
		ret = "d_pexport_training"
	case "dba.pdc_additional_ed_info"
		ret = "d_pexport_ed_add"
	case "dba.pd_hosp_affil"
		ret = "d_pexport_hosp"
	case "dba.pd_prof_experience"
		ret = "d_pexport_pro_exp"
	case "dba.pdc_practice_info"
		ret = "d_pexport_pract_info"
	case "dba.pd_license"
		ret = "d_pexport_license"
	case "dba.pd_dea_state_csr"
 		ret = "d_pexport_dea"
	case "dba.pd_board_specialty"
		ret = "d_pexport_spec"
	case "dba.pd_other_ids"
		ret = "d_pexport_otherids"
	case "dba.pdc_billing_info"
		ret = "d_pexport_billing_info"
	case "dba.pdc_cme_info"
		ret = "d_pexport_cme_info"
	case "dba.pd_postgrad_train"
		ret = "d_pexport_cme"
	case "dba.pd_prof_assoc"
		ret = "d_pexport_pro_assoc"
	case "dba.pd_other_affill" 
		ret = "d_pexport_other_affil"
	case "dba.pd_sanctions"
		ret = "d_pexport_sanctions"
	case "dba.pd_special_certs" 
		ret = "d_pexport_spe_certs"
	case "dba.pd_cpr_certifiation"
		ret = "d_pexport_cpr"
	case "dba.pdc_surgical_category"
		ret = "d_pexport_surg_cat"
	case "dba.pdc_medical_procd"
		ret = "d_pexport_med_prod"
	case "dba.pdc_procd_clar"
		ret = "d_pexport_prod_clar"
	case "dba.pdc_practice_clar"
		ret = "d_pexport_pract_clar"
	case "dba.pdc_employee_info"
		ret = "d_pexport_emp_info"
	case "dba.pdc_employees"
		ret = "d_pexport_emp_data"
	case "dba.pdc_owners_partners"
		ret = "d_pexport_owners"
	case "dba.pdc_practice_type"
		ret = "d_pexport_pract_type"
	case "dba.pdc_claims_addendum"
		ret = "d_pexport_claim_add"
	case "dba.pd_claims"
		ret = "d_pexport_claims"
	case "dba.pd_references"
		ret = "d_pexport_references"
	case else
		ret = "NONE"
end choose


return ret
end function

on w_modify_codes.create
this.cb_4=create cb_4
this.cb_1=create cb_1
this.cb_import=create cb_import
this.cb_2=create cb_2
this.tab_1=create tab_1
this.dw_5=create dw_5
this.Control[]={this.cb_4,&
this.cb_1,&
this.cb_import,&
this.cb_2,&
this.tab_1,&
this.dw_5}
end on

on w_modify_codes.destroy
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.cb_import)
destroy(this.cb_2)
destroy(this.tab_1)
destroy(this.dw_5)
end on

event open;////////////////////////////////////////////////////////////////////////////////
//of_start_import 
//	of_open_import_file ->
//		of_open_word 
//		of_decrypt
//		open(w_import_progress)
//		lnv_string.of_parsetoarray(ls_file_dump, new_line, is_file_names)
//	of_create_datastores
//	w_import_progress.of_set_import_time
//	of_set_code_datastores()
//	of_set_prac_ids
//	of_set_rec_idst
//
SQLCA.AutoCommit = false
//this.visible = false
setpointer(hourglass!)



//debugbreak()
IF of_start_import() <> FAILURE THEN
	  IF ISVALID(THIS) THEN
	// this.visible = true
	 is_title = this.title
	 idw_2 = w_modify_codes.tab_1.tabpage_1.dw_2
	 idw_1 = w_modify_codes.tab_1.tabpage_1.dw_1
	 idw_3 = w_modify_codes.tab_1.tabpage_2.dw_3
	 idw_4 = w_modify_codes.tab_1.tabpage_2.dw_4
	 setpointer(arrow!)
	END IF
	if idw_2.rowcount() = 0 and idw_4.rowcount() = 0 then //maha import automatically if there are no new lookup records
		cb_import.triggerevent(clicked!)
	else
		this.visible = true//maha
	end if
ELSE //fails
	IF ISVALID(w_import_progress) THEN
		w_import_progress.TriggerEvent ( 'ue_start_timer' )
	end if
   CLOSE(THIS)
END IF 




end event

event close;messagebox("Import","Import Process Completed")
if isvalid(w_import_progress) then
	 close(w_import_progress)
end if

of_disconnect_from_word()

SQLCA.AutoCommit = True
end event

type cb_4 from commandbutton within w_modify_codes
integer x = 2843
integer y = 2768
integer width = 247
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;//
//long ll_ret
//
//ll_ret = dw_5.update()
//
//if ll_ret  < 1 then 
//	
//	messagebox(string(ll_ret), sqlca.SQLErrText	) 
//	
//	
//end if
end event

type cb_1 from commandbutton within w_modify_codes
integer x = 2533
integer y = 2768
integer width = 247
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Next>>"
end type

event clicked;STRING ls_sql
STRING ls_presentation_str
STRING ls_dwsyntax_str
STRING ERRORS
long ll_i

//messagebox('',invo_import.ids_CREDANTIAL_dws[ll_count].dataobject)
//dw_2.dataobject = invo_import.ids_CREDANTIAL_dws[ll_count].dataobject 
//dw_2.settransobject(sqlca)
//dw_2.sharedata(invo_import.ids_CREDANTIAL_dws[ll_count])
//
//invo_import.ids_CREDANTIAL_dws[ll_count].sharedata(dw_2)
ll_count = ll_count + 1

if ll_count <  upperbound(ids_CREDANTIAL_dws) or ll_count =  upperbound(ids_CREDANTIAL_dws) then
	 
	 ls_sql = "Select * from " + is_table_name[ll_count];
ls_presentation_str = "style(type=grid)" 
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str,ERRORS)
dw_5.Create( ls_dwsyntax_str, ERRORS)
ids_CREDANTIAL_dws[ll_count].sharedata(dw_5)
	
end if


//if ll_count >  upperbound(invo_import.ids_CREDANTIAL_dws) or ll_count =  upperbound(invo_import.ids_CREDANTIAL_dws) then
//	 ll_count = ll_count - 1
//end if
//



end event

type cb_import from commandbutton within w_modify_codes
integer x = 2665
integer y = 1864
integer width = 347
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import Data"
end type

event clicked;


PARENT.Visible = FALSE



WF_REPLACE_CODES()



CLOSE(PARENT)



end event

type cb_2 from commandbutton within w_modify_codes
integer x = 3049
integer y = 1864
integer width = 347
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;long ll_i
long ll_null
setnull(ll_null)


if messagebox(title,'Are you sure you want to cancel the import?',question!,yesno!,2) = 2 then

else
	close(parent)
end if



end event

type tab_1 from tab within w_modify_codes
integer x = 5
integer width = 3424
integer height = 1848
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 80269524
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3387
integer height = 1720
long backcolor = 80269524
string text = "LookUp Codes"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
string picturename = "Custom090!"
long picturemaskcolor = 553648127
st_2 st_2
st_1 st_1
dw_2 dw_2
dw_1 dw_1
end type

on tabpage_1.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.st_1,&
this.dw_2,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type st_2 from statictext within tabpage_1
integer y = 16
integer width = 1047
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 128
long backcolor = 80269524
boolean enabled = false
string text = "New Item added by Import file."
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_1
integer y = 532
integer width = 1733
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 80269524
boolean enabled = false
string text = "Double Click on an Item Below to replace the highlighted item above."
boolean focusrectangle = false
end type

type dw_2 from datawindow within tabpage_1
integer y = 76
integer width = 3378
integer height = 432
integer taborder = 31
string dataobject = "d_imp_code_lookup"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer r

r = this.getclickedrow()
if r > 0 then
	This.SelectRow(0, FALSE)
   This.SelectRow(r, TRUE)
	this.setrow(r)
	il_current_dw_2_row = r
end if
end event

event constructor;ids_look_up_codes  = create  n_ds
ids_look_up_codes.dataobject = 'd_ext_lookupcode'

ids_address_codes  = create  n_ds
ids_address_codes.dataobject = 'd_ext_address_codes'

ids_sys_fields  = create  n_ds
ids_sys_fields.dataobject = 'd_imp_sys_fields'
ids_sys_fields.settransobject(sqlca)

ids_pd_affil_stat  = create  n_ds
ids_pd_affil_stat.dataobject = 'd_imp_pd_affil_stat'
ids_pd_affil_stat.settransobject(sqlca)

end event

event rowfocuschanged;string ls_table

ls_table = this.getitemstring(currentrow,"lookup_name")

dw_1.setfilter("lookup_name = '" + ls_table + "'")
dw_1.filter()
end event

type dw_1 from datawindow within tabpage_1
integer y = 616
integer width = 3378
integer height = 1092
integer taborder = 21
string dataobject = "d_imp_code_lookup"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
retrieve()



end event

event clicked;integer r

r = this.getclickedrow()
if r > 0 then
	This.SelectRow(0, FALSE)
   This.SelectRow(r, TRUE)
	this.setrow(r)
end if
end event

event doubleclicked;



wf_set_new_code(idw_2,idw_1,ids_look_up_codes)


end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3387
integer height = 1720
long backcolor = 80269524
string text = "Address Codes"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
string picturename = "Custom086!"
long picturemaskcolor = 553648127
st_4 st_4
st_3 st_3
dw_4 dw_4
dw_3 dw_3
end type

on tabpage_2.create
this.st_4=create st_4
this.st_3=create st_3
this.dw_4=create dw_4
this.dw_3=create dw_3
this.Control[]={this.st_4,&
this.st_3,&
this.dw_4,&
this.dw_3}
end on

on tabpage_2.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.dw_4)
destroy(this.dw_3)
end on

type st_4 from statictext within tabpage_2
integer x = 5
integer y = 556
integer width = 1824
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 80269524
boolean enabled = false
string text = "Double Click on an Item Below to replace the highlighted item above."
boolean focusrectangle = false
end type

event constructor;this.x      = w_modify_codes.tab_1.tabpage_1.st_1.x  
this.y      = w_modify_codes.tab_1.tabpage_1.st_1.y 
//this.width  = w_modify_codes.tab_1.tabpage_1.st_2.width  
this.height = w_modify_codes.tab_1.tabpage_1.st_1.height 
end event

type st_3 from statictext within tabpage_2
integer x = 5
integer y = 12
integer width = 850
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 80269524
boolean enabled = false
string text = "New Item added by Import File"
boolean focusrectangle = false
end type

event constructor;


this.x      = w_modify_codes.tab_1.tabpage_1.st_2.x  
this.y      = w_modify_codes.tab_1.tabpage_1.st_2.y 
//this.width  = w_modify_codes.tab_1.tabpage_1.st_2.width  
this.height = w_modify_codes.tab_1.tabpage_1.st_2.height 
end event

type dw_4 from datawindow within tabpage_2
integer x = 5
integer y = 80
integer width = 3328
integer height = 468
integer taborder = 41
string dataobject = "d_address_code_lookup"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer r

r = this.getclickedrow()
if r > 0 then
	This.SelectRow(0, FALSE)
   This.SelectRow(r, TRUE)
	this.setrow(r)
	il_current_dw_2_row = r
end if
end event

event constructor;

this.x      = w_modify_codes.tab_1.tabpage_1.dw_2.x  
this.y      = w_modify_codes.tab_1.tabpage_1.dw_2.y 
this.width  = w_modify_codes.tab_1.tabpage_1.dw_2.width  
this.height = w_modify_codes.tab_1.tabpage_1.dw_2.height 


end event

event rowfocuschanged;string ls_table

ls_table = this.getitemstring(currentrow,"lookup_name")

dw_3.setfilter("lookup_name = '" + ls_table + "'")
dw_3.filter()
end event

type dw_3 from datawindow within tabpage_2
integer x = 9
integer y = 632
integer width = 3337
integer height = 1064
integer taborder = 20
string dataobject = "d_address_code_lookup"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;



wf_set_new_code(idw_4,idw_3,ids_address_codes)


end event

event constructor;

settransobject(sqlca)
retrieve()


this.x      = w_modify_codes.tab_1.tabpage_1.dw_1.x  
this.y      = w_modify_codes.tab_1.tabpage_1.dw_1.y 
this.width  = w_modify_codes.tab_1.tabpage_1.dw_1.width  
this.height = w_modify_codes.tab_1.tabpage_1.dw_1.height 

end event

event clicked;integer r

r = this.getclickedrow()
if r > 0 then
	This.SelectRow(0, FALSE)
   This.SelectRow(r, TRUE)
	this.setrow(r)
end if
		

		

end event

type dw_5 from datawindow within w_modify_codes
boolean visible = false
integer x = 224
integer y = 1892
integer width = 137
integer height = 100
integer taborder = 40
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;


debugbreak()
messagebox('',sqlsyntax)
end event

