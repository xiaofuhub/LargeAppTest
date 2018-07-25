$PBExportHeader$n_cst_update_support_doc.sru
forward
global type n_cst_update_support_doc from nonvisualobject
end type
end forward

global type n_cst_update_support_doc from nonvisualobject
end type
global n_cst_update_support_doc n_cst_update_support_doc

type variables
datastore  ids_code_lookup
end variables

forward prototypes
public function long of_get_image_file (long al_image_id, long al_ctx_id, long al_version, long al_doc_id, decimal adc_version_new)
public function long of_update_support_doc ()
end prototypes

public function long of_get_image_file (long al_image_id, long al_ctx_id, long al_version, long al_doc_id, decimal adc_version_new);//////////////////////////////////////////////////////////////////////
// $<function>    of_get_image_file()
// $<arguments>
//		value	long	al_image_id		
//		value	long	al_ctx_id  		
//		value	long	al_version 		
//		value	long	al_doc_id  		
// $<returns> long
// $<description> come from n_cst_contract_sql.of_get_image_file()
// $<description>
//////////////////////////////////////////////////////////////////////

Blob  lb_image_data,lb_data,lb_all_data
long ll_data_length,ll_start
int li_loops,li_counter
String ls_Error

//appeongetclienttype() = 'PB' AND 
IF gs_dbtype = 'SQL' THEN
	SELECT Datalength(image_file) INTO :ll_data_length FROM CTX_IMAGE
	  WHERE image_id = :al_image_id AND ctx_id = :al_ctx_id AND image_version = :al_version;
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		RETURN 0
	END IF
	
	IF ll_data_length > 8000 THEN 
		 IF Mod(ll_data_length,8000) = 0 THEN 
			  li_loops = ll_data_length/8000 
		 ELSE 
			  li_loops = (ll_data_length/8000) + 1 
		 END IF 
	ELSE 
		 li_loops = 1 
	END IF 
	
	FOR li_counter = 1 to li_loops
		ll_start = (li_counter - 1) * 8000 + 1
		
		SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
		  FROM CTX_IMAGE WHERE image_id = :al_image_id AND ctx_id = :al_ctx_id AND image_version = :al_version;
	
		lb_all_data += lb_data
	NEXT 
	
	lb_image_data = lb_all_data
ELSE
	SELECTBLOB image_file INTO :lb_image_data
	  FROM CTX_IMAGE WHERE image_id = :al_image_id AND ctx_id = :al_ctx_id AND image_version = :al_version;
END IF

IF Isnull(lb_image_data) THEN
	RETURN 0
END IF

UPDATEBLOB ctx_am_doc_image SET image_file = :lb_image_data 
  WHERE doc_id = :al_doc_id AND revision = :adc_version_new;
  
//<add> 09/18/2007 by: Andy
IF SQLCA.SQLCODE = -1 THEN 
	//----------Begin Modified by Alfee 01.30.2008--------------------------------
	ls_Error= "n_cst_update_support_doc.of_get_image_file()"
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(ls_Error, Sqlca.SQLErrText,"of_get_image_file()")
	gb_upgrade_failed = TRUE
	/*
	ls_Error = '~r~n' + "==================================================="
	ls_Error+= "~r~nError:n_cst_update_support_doc.of_get_image_file()~r~nInformation: " + SQLCA.SQLErrtext 	
	filewrite(gl_logfilehandle,ls_Error)
	gb_Flag = true */
	//----------End Modified ----------------------------------------------------	
end if
//end of add

Return 1
end function

public function long of_update_support_doc ();//////////////////////////////////////////////////////////////////////
// function   : of_update_supportdoc 		
// return     : Long
// description: Move data from supporting documents to documents Manager
//              come from n_cst_contract_sql.of_appeon5_changes()
//////////////////////////////////////////////////////////////////////

long ll_category_temp, ll_cnt //Add by alfee 07.19.2007 
long ll_doc_id,ll_doc_id1,ll_doc_id2,ll_audit_id
long i,j,k,ll_row
long ll_ctx_id,ll_category,ll_doc_status,ll_image_id,ll_revision
string ls_file_name,ls_doc_name,ls_doc_ext,ls_Error
datetime ldt_updated_at_date_time,ldt_update_date
decimal ldc_version


n_cst_datastore lds_ctx_id
n_cst_datastore lds_file_name
n_cst_datastore lds_images
n_cst_datastore lds_d_ctx_am_document
n_cst_datastore lds_d_ctx_am_doc_audit
n_cst_datastore lds_d_ctx_am_doc_image

//Update code_lookup set custom_1 = code Where lookup_name = 'Contract Action Type' and custom_1 is null;  // Add by Jack 21/08/2007
//----Begin Added by alfee 07.19.2007--------------------------------------------
//If migrated before then return
ldt_update_date = datetime(date('2007-05-30'),time('00:00:01'))
Select top 1 updated_at_date_time into :ldt_updated_at_date_time from CTX_IMAGE;
If ldt_updated_at_date_time = ldt_update_date Then Return 0
//----End Added------------------------------------------------------------------

//Initilize the datastores
lds_ctx_id = Create n_cst_datastore
lds_file_name = Create n_cst_datastore
lds_images = Create n_cst_datastore
lds_d_ctx_am_document = Create n_cst_datastore
lds_d_ctx_am_doc_audit = Create n_cst_datastore
lds_d_ctx_am_doc_image = Create n_cst_datastore

lds_ctx_id.dataobject = 'd_migrate_ctx_id'
lds_file_name.dataobject = 'd_migrate_images_file_name'
lds_images.dataobject = 'd_cntx_images_migrate'
lds_d_ctx_am_document.dataobject = 'd_ctx_am_document_migrate'
lds_d_ctx_am_doc_audit.dataobject = 'd_ctx_am_doc_audit_migrate'
lds_d_ctx_am_doc_image.dataobject = 'd_ctx_am_doc_image_migrate'

lds_ctx_id.settransobject(sqlca)
lds_file_name.settransobject(sqlca)
lds_images.settransobject(sqlca)
lds_d_ctx_am_document.settransobject(sqlca)
lds_d_ctx_am_doc_audit.settransobject(sqlca)
lds_d_ctx_am_doc_image.settransobject(sqlca)

//Get supporting documents & initilize the document id
//gnv_appeondb.of_startqueue( )
lds_ctx_id.retrieve()
lds_file_name.retrieve()
lds_images.retrieve()
Select doc_id into :ll_doc_id1 from ids;
Select max(doc_id) into :ll_doc_id2 from Ctx_am_document;
//-----Begin Modified by alfee 07.19.2007 ----------------------------------
Select Min(lookup_code) Into :ll_category_temp From code_lookup Where lookup_name = 'Contract Category'; //for unknown categroy
/*Select top 1 updated_at_date_time into :ldt_updated_at_date_time from CTX_IMAGE;
ldt_update_date = datetime(date('2007-05-30'),time('00:00:01'))
Delete from ctx_am_doc_image where modify_date = :ldt_update_date;
Delete from ctx_am_doc_audit where action_date = :ldt_update_date;
Delete from ctx_am_document where create_date  = :ldt_update_date;*/
//------End Modified ------------------------------------------------------
//gnv_appeondb.of_commitqueue( )

//------Begin Commented by alfee 07.19.2007--------------------------------
/*ldt_update_date = datetime(date('2007-06-30'),time('00:00:01'))
If ldt_updated_at_date_time = ldt_update_date Then 	
	Destroy lds_ctx_id
	Destroy lds_file_name
	Destroy lds_images
	Destroy lds_d_ctx_am_document
	Destroy lds_d_ctx_am_doc_audit
	Destroy lds_d_ctx_am_doc_image
	Return 0
End If*/
//-------End Commented -----------------------------------------------------

If isnull(ll_doc_id1) Then ll_doc_id1 = 0
If isnull(ll_doc_id2) Then ll_doc_id2 = 0
If ll_doc_id1 >= ll_doc_id2 Then
	If ll_doc_id1 = 0 Then 
		ll_doc_id = 1
	Else
	   ll_doc_id = ll_doc_id1
	End If
Else
	ll_doc_id = ll_doc_id2 + 1
End If

select lookup_code into :ll_doc_status from code_lookup where upper(lookup_name) = upper('Contract Document Status') and upper(code) = 'APPROVED';

//lnv_data.of_retrieve('code_lookup')
//ll_doc_status = Long(lnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Document Status') and upper(code) = 'APPROVED'"))

//Put supporting documents
For i = 1 To lds_ctx_id.rowcount()
	ll_ctx_id = lds_ctx_id.getitemnumber(i,'ctx_id')
	ll_category = lds_ctx_id.getitemnumber(i,'category')
	//--------Begin Modified by alfee 07.19.2007-----------------------------------
	//If isnull(ll_category) or ll_category = 0 Then ll_category = 115009
	If isnull(ll_category) or ll_category = 0 Then ll_category = ll_category_temp 
	//--------End Modified --------------------------------------------------------
	
	lds_file_name.setfilter("ctx_id = " + string(ll_ctx_id))
	lds_file_name.filter()
	
	For j = 1 To lds_file_name.rowcount()
		ls_file_name = lds_file_name.getitemstring(j,'file_name')
		lds_images.setfilter("ctx_id = " + string(ll_ctx_id) + " and file_name = '" + ls_file_name + "'")
		lds_images.filter()
		ls_doc_name = mid(ls_file_name,1,lastpos(ls_file_name,'.') - 1)
		ls_doc_ext = mid(ls_file_name,lastpos(ls_file_name,'.') + 1,3)
		
		ll_audit_id = 1
		ldc_version = 1.0
		For k = 1 To lds_images.rowcount()
		  Yield()
			ll_row = lds_d_ctx_am_doc_audit.insertrow(0)
			lds_d_ctx_am_doc_audit.setitem(ll_row,'doc_id',ll_doc_id)
			lds_d_ctx_am_doc_audit.setitem(ll_row,'audit_id',ll_audit_id)
			//lds_d_ctx_am_doc_audit.setitem(ll_row,'revision',lds_images.getitemnumber(k,'image_version'))
			lds_d_ctx_am_doc_audit.setitem(ll_row,'revision',ldc_version)
			lds_d_ctx_am_doc_audit.setitem(ll_row,'doc_ext',ls_doc_ext)
			If k = 1 Then
				lds_d_ctx_am_doc_audit.setitem(ll_row,'action','New-Existing')
			Else
				lds_d_ctx_am_doc_audit.setitem(ll_row,'action','Modified')
			End If				
			lds_d_ctx_am_doc_audit.setitem(ll_row,'action_by',lds_images.getitemstring(k,'ctx_image_inserted_by_user'))				
			//lds_d_ctx_am_doc_audit.setitem(ll_row,'action_date',ldt_update_date)
			lds_d_ctx_am_doc_audit.setitem(ll_row,'action_date',lds_images.getitemdatetime(k,'ctx_image_updated_at_date_time'))
			lds_d_ctx_am_doc_audit.setitem(ll_row,'notes','Imported from Support Document')
			ll_audit_id++
			
			ll_row = lds_d_ctx_am_doc_image.insertrow(0)
			lds_d_ctx_am_doc_image.setitem(ll_row,'doc_id',ll_doc_id)
			//lds_d_ctx_am_doc_image.setitem(ll_row,'revision',lds_images.getitemnumber(k,'image_version'))
			lds_d_ctx_am_doc_image.setitem(ll_row,'revision',ldc_version)
			
			lds_d_ctx_am_doc_image.setitem(ll_row,'image_version',lds_images.getitemnumber(k,'image_version')) //Add by Jack 07.17.2007
			//lds_d_ctx_am_doc_image.setitem(ll_row,'modify_date',ldt_update_date)
			lds_d_ctx_am_doc_image.setitem(ll_row,'modify_date',lds_images.getitemdatetime(k,'ctx_image_updated_at_date_time'))
			lds_d_ctx_am_doc_image.setitem(ll_row,'doc_ext',ls_doc_ext)
			lds_d_ctx_am_doc_image.setitem(ll_row,'image_id',lds_images.getitemnumber(k,'image_id'))
			lds_d_ctx_am_doc_image.setitem(ll_row,'ctx_id',ll_ctx_id)
						
			If k = lds_images.rowcount() Then
				ll_row = lds_d_ctx_am_document.insertrow(0)
				lds_d_ctx_am_document.setitem(ll_row,'doc_id',ll_doc_id)
				lds_d_ctx_am_document.setitem(ll_row,'ctx_id',ll_ctx_id)
				//lds_d_ctx_am_document.setitem(ll_row,'doc_name',ls_file_name) //by alfee 08.22.2007
				lds_d_ctx_am_document.setitem(ll_row,'doc_name',ls_doc_name)
				//lds_d_ctx_am_document.setitem(ll_row,'revision',lds_images.getitemnumber(k,'image_version'))
				lds_d_ctx_am_document.setitem(ll_row,'revision',ldc_version)
				lds_d_ctx_am_document.setitem(ll_row,'doc_ext',ls_doc_ext)
				lds_d_ctx_am_document.setitem(ll_row,'doc_type',"Buy")
				lds_d_ctx_am_document.setitem(ll_row,'category',ll_category)
				lds_d_ctx_am_document.setitem(ll_row,'base_type','3')
				lds_d_ctx_am_document.setitem(ll_row,'create_by',lds_images.getitemstring(k,'ctx_image_inserted_by_user'))				
				//lds_d_ctx_am_document.setitem(ll_row,'create_date',ldt_update_date)
				lds_d_ctx_am_document.setitem(ll_row,'create_date',lds_images.getitemdatetime(k,'ctx_image_inserted_at_date_time'))
				lds_d_ctx_am_document.setitem(ll_row,'status',ll_doc_status)
				lds_d_ctx_am_document.setitem(ll_row,'status_by',lds_images.getitemstring(k,'ctx_image_inserted_by_user'))				
				//lds_d_ctx_am_document.setitem(ll_row,'status_date',ldt_update_date)
				lds_d_ctx_am_document.setitem(ll_row,'status_date',lds_images.getitemdatetime(k,'ctx_image_updated_at_date_time'))
				lds_d_ctx_am_document.setitem(ll_row,'notes',lds_images.getitemstring(k,'page_description'))
				lds_d_ctx_am_document.setitem(ll_row,'checkout_status','0')
				//lds_d_ctx_am_document.setitem(ll_row,'revision_control','0')
				lds_d_ctx_am_document.setitem(ll_row,'revision_control','1')
				ll_doc_id++
			End If
			ldc_version = ldc_version + 0.1		
		Next		
	Next		
Next
If lds_d_ctx_am_document.update() <> 1 Then 
	//<add> 09/18/2007 by: Andy
	//----------Begin Modified by Alfee 01.30.2008--------------------------------
	ls_Error= "lds_d_ctx_am_document.update() of n_cst_update_support_doc.of_update_support_doc()"
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(ls_Error, Sqlca.SQLErrText,'of_update_support_doc()')
	gb_upgrade_failed = TRUE
	/*
	ls_Error = '~r~n' + "==================================================="
	ls_Error+= "~r~nError:lds_d_ctx_am_document.update() of n_cst_update_support_doc.of_update_support_doc()~r~nInformation: " + SQLCA.SQLErrtext 
	
	filewrite(gl_logfilehandle,ls_Error)
	gb_Flag = true */
	//----------End Modified ----------------------------------------------------
	//end of add

	Destroy lds_ctx_id
	Destroy lds_file_name
	Destroy lds_images
	Destroy lds_d_ctx_am_document
	Destroy lds_d_ctx_am_doc_audit
	Destroy lds_d_ctx_am_doc_image	
	Return 0
End If

//<modify> 09/18/2007 by: Andy
//gnv_appeondb.of_startqueue( )
if lds_d_ctx_am_doc_audit.update() <> 1 then	
	//----------Begin Modified by Alfee 01.30.2008--------------------------------
	ls_Error= "lds_d_ctx_am_doc_audit.update() of n_cst_update_support_doc.of_update_support_doc()"
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(ls_Error, Sqlca.SQLErrText,'of_update_support_doc()')
	gb_upgrade_failed = TRUE
	/*	
	ls_Error = '~r~n' + "==================================================="
	ls_Error+= "~r~nError:lds_d_ctx_am_doc_audit.update() of n_cst_update_support_doc.of_update_support_doc()~r~nInformation: " + SQLCA.SQLErrtext 
	
	filewrite(gl_logfilehandle,ls_Error)
	gb_Flag = true	*/
	//----------End Modified ----------------------------------------------------	
end if

if lds_d_ctx_am_doc_image.update() <> 1 then
	//----------Begin Modified by Alfee 01.30.2008--------------------------------
	ls_Error= "lds_d_ctx_am_doc_image.update() of n_cst_update_support_doc.of_update_support_doc()"
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(ls_Error, Sqlca.SQLErrText,'of_update_support_doc()')
	gb_upgrade_failed = TRUE
	/*		
	ls_Error = '~r~n' + "==================================================="
	ls_Error+= "~r~nError:lds_d_ctx_am_doc_image.update() of n_cst_update_support_doc.of_update_support_doc()~r~nInformation: " + SQLCA.SQLErrtext 
	
	filewrite(gl_logfilehandle,ls_Error)
	gb_Flag = true */
	//----------End Modified ----------------------------------------------------
end if

Update ids set doc_id = :ll_doc_id;
if SQLCA.SQLCODE <> 0 THEN 
	//----------Begin Modified by Alfee 01.30.2008--------------------------------
	ls_Error= "n_cst_update_support_doc.of_update_support_doc() - Update ids set doc_id = " + string(ll_doc_id) 
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(ls_Error, Sqlca.SQLErrText,'of_update_support_doc()')
	gb_upgrade_failed = TRUE
	/*			
	ls_Error = '~r~n' + "==================================================="
	ls_Error+= "~r~nError:n_cst_update_support_doc.of_update_support_doc()~r~nInformation: " + SQLCA.SQLErrtext + &
				  "~r~n~nUpdate ids set doc_id = " + string(ll_doc_id) 
	
	filewrite(gl_logfilehandle,ls_Error)
	gb_Flag = true	*/
	//----------End Modified ----------------------------------------------------	
END IF

Update CTX_IMAGE set updated_at_date_time = :ldt_update_date;
if SQLCA.SQLCODE <> 0 THEN 
	//----------Begin Modified by Alfee 01.30.2008--------------------------------
	ls_Error= "n_cst_update_support_doc.of_update_support_doc() - Update CTX_IMAGE set updated_at_date_time = " + string(ldt_update_date)
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(ls_Error, Sqlca.SQLErrText,'of_update_support_doc()')
	gb_upgrade_failed = TRUE
	/*			
	ls_Error = '~r~n' + "==================================================="
	ls_Error+= "~r~nError:n_cst_update_support_doc.of_update_support_doc()~r~nInformation: " + SQLCA.SQLErrtext + & 
				  "~r~n~nUpdate CTX_IMAGE set updated_at_date_time = " + string(ldt_update_date)
	filewrite(gl_logfilehandle,ls_Error) 	
	gb_Flag = true */
	//----------End Modified ----------------------------------------------------
END IF
//gnv_appeondb.of_commitqueue( )
//end of modify

//Put document images
//----------Begin Modified by alfee 07.19.2007--------------------------------
ll_cnt = lds_d_ctx_am_doc_image.rowcount()
If Not isvalid( w_infodisp ) Then Open(w_infodisp)
If isvalid(w_infodisp) Then 
	w_infodisp.title = 'Migrate supporting documents'
	w_infodisp.Center = TRUE
	w_infodisp.st_complete.visible = false
	w_infodisp.st_3.visible = false
	w_infodisp.st_information.visible = false
	w_infodisp.st_1.text = 'Migrate supporting documents, Please stand by!'
	w_infodisp.wf_set_min_max(1,ll_cnt)
End if

For i = 1 To ll_cnt
	If isvalid(w_infodisp) Then 
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.text = 'Modification ' + string(i) + ' of ' + string(ll_cnt)+', Please stand by!'
	End If
//For i = 1 To lds_d_ctx_am_doc_image.rowcount()
//---------End Modified -------------------------------------------------------	
	ll_ctx_id = lds_d_ctx_am_doc_image.getitemnumber(i,'ctx_id')
	ll_image_id = lds_d_ctx_am_doc_image.getitemnumber(i,'image_id')
	//ll_revision = lds_d_ctx_am_doc_image.getitemnumber(i,'revision')	
	//---------Begin Modified by Alfee 08.27.2007-------------------------
	//ldc_version = lds_d_ctx_am_doc_image.getitemnumber(i,'revision')//Add by Jack 07.17.2007
	ldc_version = lds_d_ctx_am_doc_image.getitemdecimal(i,'revision')
	//---------End Modified -----------------------------------------------
	ll_revision = lds_d_ctx_am_doc_image.getitemnumber(i,'image_version')//Add by Jack 07.17.2007
	ll_doc_id = lds_d_ctx_am_doc_image.getitemnumber(i,'doc_id')
	of_get_image_file(ll_image_id,ll_ctx_id,ll_revision,ll_doc_id,ldc_version)
Next	

//If isvalid( w_infodisp ) Then Close(w_infodisp) //Added by alfee 07.19.2007

Destroy lds_ctx_id
Destroy lds_file_name
Destroy lds_images
Destroy lds_d_ctx_am_document
Destroy lds_d_ctx_am_doc_audit
Destroy lds_d_ctx_am_doc_image

Return 1
end function

on n_cst_update_support_doc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_support_doc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

