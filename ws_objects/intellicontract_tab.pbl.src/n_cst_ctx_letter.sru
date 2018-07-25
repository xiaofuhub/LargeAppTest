$PBExportHeader$n_cst_ctx_letter.sru
$PBExportComments$User object for creating letters
forward
global type n_cst_ctx_letter from nonvisualobject
end type
end forward

global type n_cst_ctx_letter from nonvisualobject
end type
global n_cst_ctx_letter n_cst_ctx_letter

type variables
//
constant integer CONTRACT_ACTION = 1
constant integer DOCUMENT_ACTION = 2

//constant LONG INVALID_LETTER_SUBMITTED = -999
constant LONG SUCCESS = 1
constant LONG FAILURE = -1

PRIVATE: 
n_ds ids_letter_export
n_ds ids_product_export
n_ds ids_contract_action_items
n_ds ids_document_action_items
n_ds ids_export_data

n_cst_dssrv   inv_dssrv

integer runfromdb
end variables

forward prototypes
public function integer of_check_run_path (ref string as_run_path, ref string as_facility_name, ref string ls_open_merge, string as_doc)
public function integer of_run_word (string as_doc_path, string as_open_merge)
public function string of_start (str_pass astr_pass)
private function integer of_export_data (integer ai_export_type, string as_merge_path)
public function string of_get_document (string as_doc, long al_ctx_id, ref string as_doc_path, ref string as_merge_path)
public function integer of_export_letter (string as_doc, integer ai_datasource, long al_ctx_id, long al_doc_id, long al_action_item_id)
public function string of_create_dwsyntax (datastore ads_source[])
public function integer of_export_letter (string as_doc, integer ai_datasource, long al_ctx_id[], long al_doc_id[], long al_action_item_id[])
end prototypes

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
//IS_OPEN_MERGE = ls_open_merge
 

return SUCCESS

end function

public function integer of_run_word (string as_doc_path, string as_open_merge);if not FileExists ( as_open_merge )then 
	MessageBox("Letter Error","The merge document '" + as_open_merge  +"'does not exist.  The process cannot continue.")   //Start Code Change ----10.04.2006 #681 maha
	return -1
end if

gnv_app.gnvlo_msword.of_open_word_document( as_doc_path, as_open_merge, 'Contract')

return 1
end function

public function string of_start (str_pass astr_pass);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: Obsolete. Use of_export_letter instead.
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
long al_ctx_id[]
str_pass lstr_pass

lstr_pass = astr_pass 

if UpperBound(astr_pass.s_long) > 1 and astr_pass.s_long[1] = 1 then	//Use Export in letter
	of_export_letter(lstr_pass.s_string,0,lstr_pass.contact_id[1],0,astr_pass.s_long[2])
else
	of_export_letter(lstr_pass.s_string,1,lstr_pass.contact_id[1],0,lstr_pass.action_items[1])
end if



return 'success'

end function

private function integer of_export_data (integer ai_export_type, string as_merge_path);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_export_data
//
//	Arguments: 
//		ai_export_type-
//		as_merge_path-
//	Returns:  none
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
datastore lds_source[]
string ls_syntax,ls_error
long ll_i,ll_j,ll_k,ll_rowcount,ll_colcount
long ll_ctx_id,ll_row
string ls_colname,ls_value

//Get datawindow syntax
if ai_export_type = CONTRACT_ACTION then
	lds_source[1] = ids_contract_action_items
else
	lds_source[1] = ids_document_action_items
end if
lds_source[2] = ids_letter_export
lds_source[3] = ids_product_export

ls_syntax = of_create_dwsyntax(lds_source)

//Dynamic Create DataWindow
if ids_export_data.create(ls_syntax,ls_error) <> 1 then
	MessageBox("Create error",ls_error)
	return FAILURE
end if

//Export data
for ll_i = 1 to UpperBound(lds_source)
	inv_dssrv.of_setrequestor( lds_source[ll_i])
	ll_colcount = long(lds_source[ll_i].Describe("datawindow.column.count"))
	if ll_i = 1 then		//Export Action Item Data
		ll_rowcount = lds_source[ll_i].Rowcount( )
		for ll_k = 1 to ll_rowcount
			ids_export_data.InsertRow(0)
			for ll_j = 1 to ll_colcount
				if lds_source[ll_i].Describe("#" + string(ll_j) + ".visible") = "1" then
					ls_colname = lds_source[ll_i].Describe("#" + string(ll_j) + ".name")
					ls_value =  inv_dssrv.of_getitem(ll_k,ls_colname)
					ids_export_data.setItem(ll_k,ls_colname,ls_value)
				end if
			next
		next
	else		//Export other data
		for ll_k = 1 to ll_rowcount
			ll_ctx_id = long(ids_export_data.GetItemString(ll_k,"ctx_id"))
			ll_row = lds_source[ll_i].Find("ctx_id =" + string(ll_ctx_id),1,lds_source[ll_i].RowCount())
			if ll_row > 0 then
				for ll_j = 1 to ll_colcount
					if lds_source[ll_i].Describe("#" + string(ll_j) + ".visible") = "1" then
						ls_colname = lds_source[ll_i].Describe("#" + string(ll_j) + ".name")
						ls_value =  inv_dssrv.of_getitem(ll_row,ls_colname)
						ids_export_data.setItem(ll_k,ls_colname,ls_value)
					end if
				next
			end if
		next
	end if
next

gnv_rights.of_check_dir_right(as_merge_path, true, 'Export Data Save')
return ids_export_data.saveas(as_merge_path,text!,true)
end function

public function string of_get_document (string as_doc, long al_ctx_id, ref string as_doc_path, ref string as_merge_path);/******************************************************************************************************************
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




if not f_validstr(as_doc) then 
   return 'The letter missing.'
end if 	

runfromdb = 0
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
   Upper( appeongetclienttype() ) = 'WEB' Then
	runfromdb = 1
END IF

//Get document Path
of_check_run_path( ls_run_path, ls_facility_name, as_merge_path,as_doc)

if not f_validstr(ls_run_path) then 
	return 'The letter path is missing for ' +upper(ls_facility_name) + '. Please enter one before continuing.'
end if 	 

//Download the file from database.
IF runfromdb = 1 THEN
	n_appeon_storage_area lnv_storage_area
	IF lnv_storage_area.of_retrieve_doc_from_db( 0, as_doc, ls_run_path) < 0 THEN//(Appeon)Toney 10.12.2013 - V141 ISG-CLX Fixed Reintegration BugT100902 Changed first parameter's value from 1 to 0
	   RETURN 'The MSWord document '+ 		as_doc  +'  does not exist in the database.'  
	END IF
END IF

as_doc_path = ls_run_path + as_doc

if not FileExists ( as_doc_path )then 
   return 'The MSWord document '+ 		as_doc  +' is missing please put into the directory. ' + ls_run_path
end if
	 
//if not FileExists ( as_merge_path )then 
//	return "The merge document '" + as_merge_path  +"'does not exist at: " + ls_run_path + ".  The process cannot continue."   //Start Code Change ----10.04.2006 #681 maha
//end if

return ''

end function

public function integer of_export_letter (string as_doc, integer ai_datasource, long al_ctx_id, long al_doc_id, long al_action_item_id);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_export_ctx
//
//	Arguments:
//		as_doc-
//		ai_datasource-	0:Export Painter,1-Contract Data,2-Document Data
//		al_ctx_id-
//		al_action_item-id:Store the Export_id when ai_datasource is 0,else store the Action Item id
//
//	Returns:  integer,Returns 1 if it succeeds and -1 if an error occurs
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version By Jervis
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
string ls_doc_path
string ls_merge_path
string ls_return
long ll_ctx_id[],ll_doc_id[],ll_action_item_id[]

//Convert to array
ll_ctx_id[1] = al_ctx_id
ll_doc_id[1] = al_doc_id
ll_action_item_id[1] = al_action_item_id


//Get the document
ls_return = of_get_document(as_doc,al_ctx_id,ls_doc_path,ls_merge_path)
if ls_return <> '' then
	messageBox("Letter error",ls_return)
	return FAILURE
end if


//Export the data
if ai_datasource = 0 then		//Export Painter 
	//Export data by Export Painter
	pfc_n_cst_ai_export_apb  n_export
	n_export = CREATE pfc_n_cst_ai_export_apb
	//Store export_id in al_action_item_id
	n_export.is_called_type = '4' //08.29.2007 Export format set to .txt
	if n_export.of_export_data_with_text_ctx(al_action_item_id, ll_ctx_id,ls_merge_path,0,'','','',2,"") < 0 then
		destroy n_export
		return FAILURE
	end if
	destroy n_export
else	//Contract Data
	IF al_ctx_id > 0 THEN
		gnv_appeondb.of_startqueue( )
		ids_letter_export.retrieve(ll_ctx_id,ll_action_item_id)
		ids_product_export.retrieve(ll_ctx_id)
		if ai_datasource = CONTRACT_ACTION then
			ids_contract_action_items.retrieve(ll_ctx_id,ll_action_item_id)
		elseif ai_datasource = DOCUMENT_ACTION then
			ids_document_action_items.retrieve(ll_doc_id,ll_action_item_id)
		end if
		gnv_appeondb.of_commitqueue( )
	end if
	if of_export_data(ai_datasource,ls_merge_path) < 0 then 
		return FAILURE
	end if
END IF

//Print the document
of_run_word(ls_doc_path,ls_merge_path)

return SUCCESS
end function

public function string of_create_dwsyntax (datastore ads_source[]);long ll_i,ll_j,ll_count,ll_ID,ll_ColCount
string ls_colname,ls_datatype
string ls_tab_syntax,ls_column_syntax
string ls_syntax

ls_datatype = "char(255)"
ll_count = UpperBound(ads_source)
for ll_j = 1 to ll_count
	ll_colCount = long(ads_source[ll_j].Describe("datawindow.column.count"))
	for ll_I = 1 to ll_colCount
		if ads_source[ll_j].describe("#" + string(ll_i) + ".visible") = "1" then
			ll_id++
			ls_colname = ads_source[ll_j].describe( "#" + string(ll_I) + ".name")
			ls_tab_syntax += 'column=(type='+ls_datatype+' name='+ls_colname+' dbname="'+ls_colname+'" )  ~r~n'
			ls_column_syntax += 'column(band=detail id='+string(ll_ID)+' x="5" y="'+string(2*ll_ID)+'" height="68" width="68"  name='+ls_colname+') ~r~n' 
		end if
	next
next


ls_syntax = "release 9;~r~n"+& 
 'datawindow(units=0 timer_interval=0 color=16777215 processing=1 '+& 
 'print.documentname="" print.orientation = 0 print.margin.left = 110 '+& 
 'print.margin.right = 110 print.margin.top = 97 print.margin.bottom = 97 '+& 
 'print.paper.source = 0 print.paper.size = 0 print.prompt=no )~r~n'+& 
 'header(height=77 color="536870912" )~r~n'+& 
 'summary(height=1 color="536870912" )~r~n'+& 
 'footer(height=1 color="536870912" )~r~n'+& 
 'detail(height=89 color="536870912" )~r~n'+& 
 'table(' 

ls_syntax = ls_syntax+ ls_tab_syntax +")~r~n"+ ls_column_syntax

return ls_syntax




end function

public function integer of_export_letter (string as_doc, integer ai_datasource, long al_ctx_id[], long al_doc_id[], long al_action_item_id[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_export_letter
//
//	Arguments:
//		as_doc-
//		ai_datasource-	0:Export Painter,1-Contract Data,2-Document Data
//		al_ctx_id-
//		al_action_item-id:Store the Export_id when ai_datasource is 0,else store the Action Item id
//
//	Returns:  integer,Returns 1 if it succeeds and -1 if an error occurs
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version By Jervis
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
string ls_doc_path
string ls_merge_path
string ls_return



//Get the document from any ctx_id
ls_return = of_get_document(as_doc,al_ctx_id[1],ls_doc_path,ls_merge_path)
if ls_return <> '' then
	messageBox("Letter error",ls_return)
	return FAILURE
end if


//Export the data
if ai_datasource = 0 then		//Export Painter 
	//Export data by Export Painter
	pfc_n_cst_ai_export_apb  n_export
	n_export = CREATE pfc_n_cst_ai_export_apb
	n_export.is_called_type = '4' //08.29.2007 Export format set to .txt
	if n_export.of_export_data_with_text_ctx(al_action_item_id[1], al_ctx_id,ls_merge_path,0,'','','',2,"") < 0 then
		destroy n_export
		return FAILURE
	end if
	destroy n_export
else	//Contract Data
	IF upperbound(al_ctx_id) > 0 THEN
		gnv_appeondb.of_startqueue( )
		ids_letter_export.retrieve(al_ctx_id,al_action_item_id)
		ids_product_export.retrieve(al_ctx_id)
		if ai_datasource = CONTRACT_ACTION then
			ids_contract_action_items.retrieve(al_ctx_id,al_action_item_id)
		elseif ai_datasource = DOCUMENT_ACTION then
			ids_document_action_items.retrieve(al_doc_id,al_action_item_id)
		end if
		gnv_appeondb.of_commitqueue( )
	end if
	if of_export_data(ai_datasource,ls_merge_path) < 0 then 
		return FAILURE
	end if
END IF

//Print the document
of_run_word(ls_doc_path,ls_merge_path)

return SUCCESS
end function

on n_cst_ctx_letter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ctx_letter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// For Contract Data Export
ids_letter_export = create n_ds
ids_letter_export.dataobject = 'd_letter_contract_details_pt'
ids_letter_export.settransobject(sqlca)


ids_contract_action_items = create n_ds 
ids_contract_action_items.dataobject = 'd_letter_contract_action_items_pt'
ids_contract_action_items.settransobject( sqlca)


//For Document Data Export
ids_document_action_items = create n_ds
ids_document_action_items.dataobject = 'd_letter_document_action_items_pt'
ids_document_action_items.settransobject(sqlca)


//For Product Data Export

ids_product_export = create n_ds
ids_product_export.dataobject = 'd_letter_contract_product_pt'
ids_product_export.settransobject(sqlca)

//Foe Export Data
ids_export_data = create n_ds
ids_export_data.SetTransObject(sqlca)

inv_dssrv = create n_cst_dssrv





end event

event destructor;gnv_app.gnvlo_msword.of_dissconnect_from_word( )

//Destory object
if isvalid(ids_letter_export) then destroy ids_letter_export
if isvalid(ids_contract_action_items) then destroy ids_contract_action_items
if isvalid(ids_document_action_items) then destroy ids_document_action_items
if isvalid(ids_product_export) then destroy ids_product_export
if isvalid(ids_export_data) then destroy ids_export_data


if isvalid(inv_dssrv) then destroy inv_dssrv


end event

