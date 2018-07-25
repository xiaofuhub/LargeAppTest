$PBExportHeader$n_cst_ctx_letter_bak0119.sru
$PBExportComments$User object for creating letters
forward
global type n_cst_ctx_letter_bak0119 from nonvisualobject
end type
end forward

global type n_cst_ctx_letter_bak0119 from nonvisualobject
end type
global n_cst_ctx_letter_bak0119 n_cst_ctx_letter_bak0119

type variables
//

constant LONG INVALID_LETTER_SUBMITTED = -999
constant LONG SUCCESS = 0
constant LONG FAILURE = -1

n_cst_dssrv invo_dwsrv
n_cst_string inv_string
PRIVATE: 
string is_merge_path /* hold the path and name of the merge datasource*/
STRING IS_OPEN_MERGE
string is_doc
string is_syntax
long il_ctx_id[]
long il_action_items[]
n_ds ids_letter_export
n_ds ids_ext_ctx_documents
n_ds ids_contract_action_items

str_pass istr_pass

//Added instance variable:  integer runfromdb 09.08.2006
integer runfromdb
end variables

forward prototypes
private function integer of_export_letter ()
public function integer of_check_run_path (ref string as_run_path, ref string as_facility_name, ref string ls_open_merge, string as_doc)
public function integer of_run_word (string as_doc_path, string as_open_merge)
public function integer of_start_export (string as_letter, string as_merge_path, long al_ctx_id[])
public function string of_start (str_pass astr_pass)
public function integer of_dynamicalsyntax ()
public function integer of_create_external_dw (n_ds ads[])
public function integer of_setitem (n_ds an_ds, string as_value, long al_column, string ls_colname, long al_current_row)
public function string of_getitem (n_ds an_ds, long al_row, ref string ls_colname, long al_column)
end prototypes

private function integer of_export_letter ();/******************************************************************************************************************
**  [PUBLIC]   : of_export_letter
**==================================================================================================================
**  Purpose   	: Generates a text file for the letter to merge to
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long   ll_i,ll_j,ll_w
long   ll_current_row /* the current external row */
STRING LS_COLUMN_NAME,LS_COL_NAME
STRING ls_value
STRING ls_header_text
STRING ls_col_number
string ls_colname
STRING ls_col_NAME_EXT
long ll_a
long ll_k

string ls_dynamiccols
datastore lds[]

lds[1] = ids_letter_export
lds[2] = ids_contract_action_items
of_create_external_dw(lds)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

IF upperbound(istr_pass.contact_id) > 0 THEN
	gnv_appeondb.of_startqueue( )
	
	ids_letter_export.retrieve(istr_pass.contact_id[1],istr_pass.action_items[1] )
	ids_contract_action_items.retrieve(istr_pass.contact_id[1],istr_pass.action_items[1])
	
	gnv_appeondb.of_commitqueue( )
END IF
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.28.2006 By: LeiWei
//$<reason> Fix a defect.
/*
FOR ll_a =  1 to upperbound(istr_pass.contact_id)
	
		invo_dwsrv.of_setrequestor( ids_letter_export)
		
		IF ids_letter_export.retrieve(istr_pass.contact_id[ll_a],istr_pass.action_items[ll_a] ) > 0 THEN
			FOR ll_w = 1 to ids_letter_export.rowcount()
				ll_current_row = ids_ext_ctx_documents.insertrow(0)
				FOR ll_k = 1 TO long(ids_letter_export.Object.DataWindow.Column.Count)
					ls_value = of_getitem(ids_letter_export,ll_k,ls_colname)
					of_setitem(ids_ext_ctx_documents,ls_value,ll_k,ls_colname,ll_current_row )
				next
			NEXT
			
			invo_dwsrv.of_setrequestor( ids_contract_action_items)
			IF ids_contract_action_items.retrieve(istr_pass.contact_id[ll_a],istr_pass.action_items[ll_a]) > 0 THEN
				FOR ll_w = 1 to ids_contract_action_items.rowcount()
					FOR ll_k = 1 TO long(ids_letter_export.Object.DataWindow.Column.Count)
						ls_value = of_getitem(ids_contract_action_items,ll_k,ls_colname)
						of_setitem(ids_ext_ctx_documents,ls_value,ll_k,ls_colname,ll_current_row )
					next
				NEXT
			END IF
				
		END IF
NEXT
*/

invo_dwsrv.of_setrequestor( ids_contract_action_items)
FOR ll_w = 1 to ids_contract_action_items.rowcount()
	
	ll_current_row = ids_ext_ctx_documents.insertrow(0)
	
	FOR ll_k = 1 TO long(ids_contract_action_items.Object.DataWindow.Column.Count)
		ls_value = of_getitem(ids_contract_action_items,ll_w,ls_colname,ll_k)
		of_setitem(ids_ext_ctx_documents,ls_value,ll_k,ls_colname,ll_current_row )
	NEXT
NEXT

invo_dwsrv.of_setrequestor( ids_letter_export)
FOR ll_w = 1 to ids_ext_ctx_documents.rowcount()
	FOR ll_k = 1 TO long(ids_letter_export.Object.DataWindow.Column.Count)
		ls_value = of_getitem(ids_letter_export,1,ls_colname,ll_k)
		of_setitem(ids_ext_ctx_documents,ls_value,ll_k,ls_colname,ll_w )
	NEXT
NEXT
//---------------------------- APPEON END ----------------------------

ids_ext_ctx_documents.accepttext( )
ids_ext_ctx_documents.SaveAs( is_open_merge, Text!, TRUE )

RETURN  SUCCESS
end function

public function integer of_check_run_path (ref string as_run_path, ref string as_facility_name, ref string ls_open_merge, string as_doc);/******************************************************************************************************************
**  [PUBLIC]   : of_check_run_path( /*ref string as_run_path*/, /*ref string as_facility_name*/, /*string ls_open_merge */)
**==================================================================================================================
**  Purpose   	: set the run path so that word can run and merge the document
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
 
//Start Code Change ----10.04 .2006 #678 maha
if gi_citrix = 1 then 
		as_run_path = gs_dir_path + gs_DefDirName + "\letters\standard\" + gs_user_id + "\"
		CreateDirectoryA(as_run_path, 0)
		ls_open_merge = as_run_path
	elseif runfromdb = 1 then //from db
		as_run_path = gs_dir_path + gs_DefDirName + "\letters\standard\" 
	else
		select letter_path,facility_name 
		into :as_run_path,:as_facility_name
		from facility
		where facility_id = 1;
end if 
//End Code Change---09.07.2006
    // the merge path
	 
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.28.2006 By: LeiWei
//$<reason> The name should always be ctx_general_ltr.txt and it should 
//$<reason> always be saved under the \ContractLogix\letters\data directory.
/*
ls_open_merge = inv_string.of_globalreplace( as_run_path, 'Standard', 'Data') + inv_string.of_globalreplace( as_doc, '.doc', '.txt')
*/
ls_open_merge = gs_dir_path + gs_DefDirName + "\letters\data\" + "ctx_general_ltr.txt"

n_appeon_download lnv_downlaod
lnv_downlaod.of_parsepath( gs_dir_path + gs_DefDirName + "\Letters\data\")

//---------------------------- APPEON END ----------------------------
    IS_OPEN_MERGE = ls_open_merge
 

return 0

end function

public function integer of_run_word (string as_doc_path, string as_open_merge);



gnv_app.gnvlo_msword.of_open_word_document( as_doc_path, as_open_merge, 'Contract')


return success
end function

public function integer of_start_export (string as_letter, string as_merge_path, long al_ctx_id[]);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [string] as_letter 		the letter are exporting
**             : [string] as_merge_path   The path of the merges letter data source
**             : [long  ] al_ctx_id       The contract ID 
==================================================================================================================
**  Returns   	: [long]   Return code
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 21 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


is_merge_path = as_merge_path
il_ctx_id     = al_ctx_id

choose case as_letter
	case 'contract_EffDtLtr.doc', +&
        'contract_RevDtLtr.doc', +&
        'contract_ExpDtLtr.doc', +&
        'contract_CusDtLtr.doc', +&
        'contract_Cus2DtLtr.doc', +&
        'contract_TermDtLtr.doc' 
		  OF_EXPORT_LETTER()
	case else 
		//Start Code Change ---- 10.04.2006 #679 maha set to a default value
		as_letter = 'contract_CusDtLtr.doc'
		OF_EXPORT_LETTER()
		//return INVALID_LETTER_SUBMITTED
		//End Code Change---09.07.2006
end choose 


RETURN SUCCESS


end function

public function string of_start (str_pass astr_pass);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 03 November 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

	
string ls_run_path
string ls_facility_name
string ls_open_merge
string ls_doc_path
string as_doc
long al_ctx_id[]

istr_pass = astr_pass 
as_doc = istr_pass.s_string
al_ctx_id = istr_pass.contact_id
il_action_items = istr_pass.action_items
debugbreak()

if not f_validstr(as_doc) then 
   return 'The letter missing.'
end if 	

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.04.2006 By: LeiWei
//$<reason> Download the file from database.

//Start Code Change ---- 10.04.2006 #680 maha
runfromdb = 0
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
   Upper( appeongetclienttype() ) = 'WEB' Then
	runfromdb = 1
END IF

//---------------------------- APPEON END ----------------------------

of_check_run_path( ls_run_path, ls_facility_name, ls_open_merge,as_doc)

if not f_validstr(ls_run_path) then 
	return 'The letter path is missing for ' +upper(ls_facility_name) + '. Please enter one before continuing.'
end if 	 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.10.2006 By: LeiWei
//$<reason> Download the file from database.

IF runfromdb = 1 THEN
	n_appeon_storage_area lnv_storage_area

	//$<add> 01.10.2007 By: Davis
	lnv_storage_area.ib_open_process_window = FALSE
	openwithparm( w_appeon_gifofwait, "Opening document..." )
	//$<add> 01.10.2007 By: Davis

	IF lnv_storage_area.of_retrieve_doc_from_db( 1, as_doc, ls_run_path) < 0 THEN
	   RETURN 'The MSWord document '+ 		as_doc  +'  does not exist in the database.'  
	END IF
END IF

//---------------------------- APPEON END ----------------------------

ls_doc_path = ls_run_path + as_doc

if not FileExists ( ls_doc_path )then 
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait) //$<add> 01.10.2007 By: Davis
   return 'The MSWord document '+ 		as_doc  +' is missing please put into the directory. ' + ls_run_path
end if
	 
if of_start_export( as_doc, ls_open_merge, al_ctx_id) = -999 then //maha added failure trap 090706
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait) //$<add> 01.10.2007 By: Davis
	return "Program not setup as for this type of letter"
end if
if not FileExists ( ls_open_merge )then 
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait) //$<add> 01.10.2007 By: Davis
	return "The merge document '" + ls_open_merge  +"'does not exist at: " + ls_run_path + ".  The process cannot continue."   //Start Code Change ----10.04.2006 #681 maha
end if
//End Code Change---09.07.06.2006	
of_run_word( ls_doc_path, ls_open_merge)

// open the 'Did it go ok window'

IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait) //$<add> 01.10.2007 By: Davis



return 'success'

end function

public function integer of_dynamicalsyntax ();

string ls_column,ls_syntax,ls_syntaxstart,ls_syntaxend,ls_errors 
string ls_colname,ls_datatype,ls_len,structuredefinition
long ll_pos,ll_ID 

// syntaxdefinition : columns separated by ; 
// for each column: name,datatype[,length] 
// e.g.  "ID,number;name,char,100;born,date" 
ls_syntaxstart = "release 9;~r~n"+& 
 'datawindow(units=0 timer_interval=0 color=16777215 processing=1 '+& 
 'print.documentname="" print.orientation = 0 print.margin.left = 110 '+& 
 'print.margin.right = 110 print.margin.top = 97 print.margin.bottom = 97 '+& 
 'print.paper.source = 0 print.paper.size = 0 print.prompt=no )~r~n'+& 
 'header(height=77 color="536870912" )~r~n'+& 
 'summary(height=1 color="536870912" )~r~n'+& 
 'footer(height=1 color="536870912" )~r~n'+& 
 'detail(height=89 color="536870912" )~r~n'+& 
 'table(' 

structuredefinition = is_syntax
DO WHILE len(structuredefinition) > 0 
 ll_ID ++ 
 ll_pos = pos(structuredefinition,";") 
 if ll_pos = 0 then 
  ll_pos = len(structuredefinition) + 1 
 end if 
 ls_column = left(structuredefinition,ll_pos - 1) 
 structuredefinition = mid(structuredefinition,ll_pos + 1) 


 ll_pos = pos(ls_column,",") 
 if ll_pos = 0 then 
  ll_pos = len(ls_column) + 1 
 end if 
 ls_colname = trim(left(ls_column,ll_pos - 1)) 
 ls_column = mid(ls_column,ll_pos + 1) 


 ll_pos = pos(ls_column,",") 
 if ll_pos = 0 then 
  ll_pos = len(ls_column) + 1 
 end if 
 ls_datatype = lower(trim(left(ls_column,ll_pos - 1))) 
 ls_column = mid(ls_column,ll_pos + 1) 
 if ls_datatype = "" then 
  ls_datatype = "char(255)"  //default 
 end if 
 if not isnumber(ls_column) then 
  ls_column = "" 
 end if 
 if (ls_datatype = 'char' or ls_datatype = 'decimal') then 
  if ls_column = "" then 
   if ls_datatype = "char" then 
    ls_column = "40" 
   else 
    ls_column = "4" 
   end if 
  end if 
  ls_datatype = ls_datatype + "("+ls_column+")" 
 end if 
 ls_column = 'column=(type='+ls_datatype+' name='+ls_colname+' dbname="'+ls_colname+'" )  ~r~n' 
 ls_syntaxstart =  ls_syntaxstart + ls_column 
 ls_column = 'column(band=detail id='+string(ll_ID)+' x="5" y="'+string(100*ll_ID)+'" height="77" width="668"  name='+ls_colname+') ~r~n' 
 ls_syntaxend = ls_syntaxend+ls_column 
LOOP 
ls_syntax = ls_syntaxstart+")~r~n"+ls_syntaxend

ids_ext_ctx_documents.create(ls_syntax,ls_errors)



return 1
end function

public function integer of_create_external_dw (n_ds ads[]);

long ll_i,ll_j
string ls_dynamiccols




for ll_i = 1 to upperbound(ads)
	invo_dwsrv.of_setrequestor( ads[ll_i])
	FOR ll_j = 1 TO long(ads[ll_i].Object.DataWindow.Column.Count)
		 if long(ads[ll_i].Describe("#" + STRING(ll_j) + ".Visible")) =  1 then 
		    ls_dynamiccols = ls_dynamiccols + ads[ll_i].Describe("#" + STRING(ll_j) + ".Name")+",,255;"  
	    end if 
	NEXT

next


is_syntax = ls_dynamiccols
of_dynamicalsyntax( )   



return 1
end function

public function integer of_setitem (n_ds an_ds, string as_value, long al_column, string ls_colname, long al_current_row);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 29 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long ll_j
string LS_COLUMN_NAME
string ls_col_name_ext

///////////////////////////////////////////////////////////////////////
// get the curent column name
///////////////////////////////////////////////////////////////////////

//ls_col_name_ext = "#" + STRING(al_column)
//LS_COLUMN_NAME = an_ds.Describe(ls_col_NAME_EXT + ".Name")

FOR ll_j = 1 TO long(ids_ext_ctx_documents.Object.DataWindow.Column.Count)
   IF ls_colname = ids_ext_ctx_documents.Describe("#" + STRING(ll_j) + ".Name") then
	   ids_ext_ctx_documents.setitem(al_current_row, ls_colname, as_value)
		//messagebox('setitem',ls_colname  +'   ' + as_value+'  ' +  string(ids_ext_ctx_documents.getrow()))
		return success
	END IF 
NEXT

	
				
				
			
return success
end function

public function string of_getitem (n_ds an_ds, long al_row, ref string ls_colname, long al_column);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 29 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


string ls_col_number
string LS_COLUMN_NAME
string ls_value

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.28.2006 By: LeiWei
//$<reason> Fix a defect.
/*
ls_col_number = "#" + STRING(al_row)
*/

ls_col_number = "#" + STRING(al_column)

//---------------------------- APPEON END ----------------------------

ls_colname = an_ds.Describe(ls_col_number + ".Name")
					
IF LONG(an_ds.Describe( ls_col_number +".Visible")) = 1 THEN 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 09.28.2006 By: LeiWei
	//$<reason> Fix a defect.
	/*
	ls_value = invo_dwsrv.of_GetItem (an_ds.getrow(),ls_colname)
	*/
	
	ls_value = invo_dwsrv.of_GetItem (al_row, ls_colname)
	
	//---------------------------- APPEON END ----------------------------

	//messagebox('getitem',LS_COLUMN_NAME  +'   ' + ls_value +' ' +string(al_row) )
END IF 
				

return ls_value
end function

on n_cst_ctx_letter_bak0119.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ctx_letter_bak0119.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
ids_letter_export = create n_ds
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 03.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Replace dataobject d_letter_contract_details with d_letter_contract_details_pt.
/*
ids_letter_export.dataobject = 'd_letter_contract_details'
*/
ids_letter_export.dataobject = 'd_letter_contract_details_pt'
//---------------------------- APPEON END ----------------------------
ids_letter_export.settransobject(sqlca)

ids_ext_ctx_documents = create  n_ds
//ids_ext_ctx_documents.dataobject = 'd_ext_ctx_documents'



ids_contract_action_items = create n_ds 
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<modify> 03.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Replace dataobject d_letter_contract_action_items with d_letter_contract_action_items_pt.
/*
ids_contract_action_items.dataobject = 'd_letter_contract_action_items'
*/
ids_contract_action_items.dataobject = 'd_letter_contract_action_items_pt'
//---------------------------- APPEON END ----------------------------


ids_contract_action_items.settransobject( sqlca)





invo_dwsrv = create n_cst_dssrv 





end event

event destructor;

gnv_app.gnvlo_msword.of_dissconnect_from_word( )

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(invo_dwsrv) then Destroy invo_dwsrv
//---------------------------- APPEON END ----------------------------

end event

