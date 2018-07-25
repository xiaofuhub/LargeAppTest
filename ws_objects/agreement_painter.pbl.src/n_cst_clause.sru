$PBExportHeader$n_cst_clause.sru
forward
global type n_cst_clause from nonvisualobject
end type
end forward

global type n_cst_clause from nonvisualobject
end type
global n_cst_clause n_cst_clause

type variables
n_cst_dm_utils inv_dm_utils

DataStore ids_Clause_attribute_value //added by gavins 20120723
end variables

forward prototypes
public function integer of_add_audit_trail (str_add_audit astr_add_audit)
public function integer of_download_file (long al_clause_id, decimal adec_revision, ref string as_file_name)
public function integer of_ini_data ()
public function integer of_upload_file (long al_clause_id, decimal adec_revision, string as_filename)
public function integer of_upload_file (long al_clause_id, decimal adec_revision, string as_filename, ref datetime adt_updatedate)
public function string of_generate_name (long al_clause_id, decimal adec_revision)
public function integer of_check_name (string as_clause_name)
public function integer of_download_file (long al_clause_id, ref string as_file_name)
public function integer of_upload_file (long al_clause_id, string as_file_name)
public function decimal of_get_revision (long al_clause_id)
public function String of_generate_name (long al_clause_id)
public function integer of_download_file (long al_clause_id)
public function integer of_registry_get (long al_clause_id, decimal adec_revision, ref string as_lastupdate)
public function integer of_registry_get (long al_clause_id, ref string as_lastupdate)
public function integer of_registry_set (integer al_clause_id, decimal adec_revision, string as_updatedate)
public function integer of_registry_set (long al_clause_id, decimal adec_revision, datetime adt_updatedate)
public subroutine of_create_clause_attribute (long al_clause_id, long al_clause_handle, treeview atv_clause)
public subroutine of_getattribvaluelist (long al_clause_id, ref string as_attarr[])
public subroutine of_create_clause_attribute (long al_clause_id, long al_clause_handle, treeview atv_clause, string as_ext_data)
public function string of_download_document (long al_document_id)
public function integer of_download_file (long al_clause_id, decimal adec_revision, datetime adt_lastmodify, ref string as_file_name)
public function integer of_download_file (long al_clause_id[], decimal adec_revision[], ref string as_file_name[])
public function long of_retrieve_attribute_value ()
public subroutine of_get_attribvalue_list (long al_clause_id, ref string as_attarr[])
public function integer of_update_document (str_clause astr_clause, integer ai_type)
end prototypes

public function integer of_add_audit_trail (str_add_audit astr_add_audit);//////////////////////////////////////////////////////////////////////
// Function: of_add_audit_trail()
// Arguments:
// 	value    str_add_audit    astr_add_audit
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-01-11
//--------------------------------------------------------------------
// Description: Add audit for clause.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Datastore lds_audit
lds_audit = Create DataStore
lds_audit.dataobject = "d_clauses_audit_all"
lds_audit.SetTransObject(SQLCA)

//Set data
lds_audit.InsertRow(0)
lds_audit.SetItem(1,'clause_id',astr_add_audit.doc_id )
lds_audit.SetItem(1,'revision', astr_add_audit.revision )
lds_audit.SetItem(1,'actions', astr_add_audit.action )
lds_audit.SetItem(1,'action_by', gs_user_id )
lds_audit.SetItem(1,'action_date',DateTime(Today(), Now()) )
lds_audit.SetItem(1,'notes',astr_add_audit.notes )

//Update
If lds_audit.Update() <> 1 Then
	MESSAGEBOX("Audit", "Add audit trail records failed due to "+ sqlca.sqlerrtext)
	RETURN -1	
End If

//Refresh audit


//Destroy
If isvalid(lds_audit) Then Destroy lds_audit

Return 1


end function

public function integer of_download_file (long al_clause_id, decimal adec_revision, ref string as_file_name);//////////////////////////////////////////////////////////////////////
// Function: of_download_file()
// Arguments:
// 	value        long       al_clause_id
// 	value        decimal    adec_revision
// 	reference    string     as_file_name
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-01-11
//--------------------------------------------------------------------
// Description: Download clause file with clause_id and revision.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Datetime ldt_modify_date
String ls_updatedate
Boolean lb_select
String ls_lastupdate
long ll_getupdate,ll_data_length,li_loops,li_counter,ll_start,ll_BlobLen
Long ll_CurrentPos,li_Cnt
Blob lb_all_data,lb_data,lblb_Data
Integer li_FileNum,li_Writes

Select modify_date into :ldt_modify_date 
From ctx_acp_clause_image
Where clause_id = :al_clause_id and revision = :adec_revision;

Return of_download_file(al_clause_id,adec_revision,ldt_modify_date,as_file_name)

/*
ls_updatedate = String(ldt_modify_date,'mm/dd/yyyy hh:mm:ss')

gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\")
//as_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clause_id) + '.' + String(adec_revision) +  ".doc"
as_file_name = of_generate_name(al_clause_id,adec_revision)
	//Get if the document existed and updated
	If Not fileexists(as_file_name) Then
		lb_select = True
	Else		
		//ll_getupdate = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_"+string(al_clause_id) + '.' + String(adec_revision) , regstring!, ls_lastupdate)	
		ll_getupdate = This.of_registry_get(al_clause_id, adec_revision, ls_lastupdate)
		If ll_getupdate <> 1 Then
			lb_select = True
		Else
			If ls_updatedate <> ls_lastupdate Then 
				lb_select = True
			End If		
		End If	
	End If
	
	//Gen the document if not existed or updated
	If lb_select = True Then
		lb_select = False	
		If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then		
			SELECTBLOB image_file INTO :lb_all_data
			  FROM ctx_acp_clause_image WHERE clause_id = :al_clause_id and revision = :adec_revision;
		Else			
			SELECT Datalength(image_file) INTO :ll_data_length
			  FROM ctx_acp_clause_image WHERE clause_id = :al_clause_id and revision = :adec_revision;
			
			If isnull(ll_data_length) Then ll_data_length = 0
			
			If ll_data_length > 8000 Then 
				If Mod(ll_data_length,8000) = 0 Then
					li_loops = ll_data_length/8000 
				Else
					li_loops = (ll_data_length/8000) + 1 
				End If 
			ElseIf ll_data_length > 0 Then 
				li_loops = 1 
			End If 
			
			For li_counter = 1 To li_loops				
				ll_start = (li_counter - 1) * 8000 + 1
				SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
				  FROM ctx_acp_clause_image WHERE clause_id = :al_clause_id and revision = :adec_revision;	
				lb_all_data += lb_data
			Next 
		End If
		If isnull(lb_all_data) Then lb_all_data = blob('')
		If Len(lb_all_data) < 1 Then 
			as_file_name = ''
			Return -1	 	
		End If
		
		li_FileNum = FileOpen(as_file_name , StreamMode! ,Write!,Shared!, Replace!)
		If li_FileNum = -1 Then 
			as_file_name = ''
			Return -1
		End If
			
		ll_BlobLen = Len(lb_all_data)
		If ll_BlobLen > 32765 Then
			If Mod(ll_BlobLen, 32765) = 0 Then
				li_Writes = ll_BlobLen / 32765
			Else
				li_Writes = (ll_BlobLen / 32765) + 1
			End If
		 Else
			li_Writes = 1
		End If
		
		ll_CurrentPos = 1
		
		For li_Cnt = 1 To li_Writes
			lblb_Data = BlobMid(lb_all_data, ll_CurrentPos, 32765)
			ll_CurrentPos += 32765
			If FileWrite(li_FileNum, lblb_Data) = -1 Then
				as_file_name = ''
				Return -1
			End If
		Next
		
		FileClose(li_FileNum)
		//gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(al_clause_id) + '.' + String(adec_revision), regstring!, ls_updatedate)			
		of_registry_set(al_clause_id,adec_revision,ls_updatedate)
	End If	
Return 1
*/
end function

public function integer of_ini_data ();//////////////////////////////////////////////////////////////////////
// Function: of_ini_data()
// Arguments:
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-01-11
//--------------------------------------------------------------------
// Description: initialize data for old clause. add image and audit.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long i,ll_row,ll_row_cnt
n_ds lds_need_audit, lds_need_image
n_ds lds_audit,lds_image

lds_need_audit = Create n_ds
lds_need_audit.dataobject = 'd_clauses_need_add_audit'
lds_need_audit.SetTransObject(SQLCA)

lds_need_image = Create n_ds
lds_need_image.dataobject = 'd_clauses_need_add_image'
lds_need_image.SetTransObject(SQLCA)

lds_audit = Create n_ds
lds_audit.dataobject = 'd_clauses_audit_all'
lds_audit.SetTransObject(SQLCA)

lds_image = Create n_ds
lds_image.dataobject = 'd_clauses_image'
lds_image.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	lds_need_audit.Retrieve()
	lds_need_image.Retrieve()
gnv_appeondb.of_commitqueue( )

//Ini Audit data
ll_row_cnt = lds_need_audit.RowCount()
If ll_row_cnt > 0 Then
	For i = 1 To ll_row_cnt
		ll_row = lds_audit.InsertRow(0)
		lds_audit.SetItem(ll_row,'clause_id',lds_need_audit.GetItemNumber(i,'ctx_acp_clause_id'))
		lds_audit.SetItem(ll_row,'revision',lds_need_audit.GetItemDecimal(i,'revision'))
		lds_audit.SetItem(ll_row,'action_date',lds_need_audit.GetItemDatetime(i,'create_date'))
		lds_audit.SetItem(ll_row,'action_by',lds_need_audit.GetItemString(i,'approved_by'))
		lds_audit.SetItem(ll_row,'actions','New - Existing')
	Next
	If lds_audit.update() = 1 Then
		Commit;
	Else
		IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('Insert clause audit data', Sqlca.SQLErrText,'n_cst_clause.of_ini_data()')		
		Rollback;
		gb_upgrade_failed = TRUE			
	End If
End If

//Ini image data
ll_row_cnt = lds_need_image.RowCount()
If ll_row_cnt > 0 Then
	//Insert image main record.
	For i = 1 To ll_row_cnt
		ll_row = lds_image.InsertRow(0)
		lds_image.SetItem(ll_row,'clause_id',lds_need_image.GetItemNumber(i,'ctx_acp_clause_id'))
		lds_image.SetItem(ll_row,'revision',lds_need_image.GetItemDecimal(i,'revision'))
		lds_image.SetItem(ll_row,'doc_type','doc')
		lds_image.SetItem(ll_row,'modify_date',lds_need_image.GetItemDatetime(i,'create_date'))
	Next
	If lds_image.update() = 1 Then
		Commit;
	Else
		IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('Insert history clause data', Sqlca.SQLErrText,'n_cst_clause.of_ini_data()')
		Rollback;
		gb_upgrade_failed = TRUE
		
		//Added By Mark Lee 07/11/12
		Destroy 	lds_need_audit
		Destroy	lds_need_image
		Destroy 	lds_audit
		Destroy	lds_image
		Return -1
	End If
	
	//Begin - Added By Mark Lee 07/11/12 it maybe some reason that is to commit unsuccess 
//	//update blob data.
//	Update ctx_acp_clause_image 
//	Set image_file = (Select image_file From ctx_acp_clause Where ctx_acp_clause.ctx_acp_clause_id = ctx_acp_clause_image.clause_id and ctx_acp_clause.revision = ctx_acp_clause_image.revision  )
//	Where ctx_acp_clause_image.image_file is null;
//
//	If sqlca.sqlcode <> 0 Then
//		IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('update history clause image data', Sqlca.SQLErrText,'n_cst_clause.of_ini_data()')
//		gb_upgrade_failed = TRUE
//		Return -1
//	End If
	//End - Added By Mark Lee 07/11/12
End If

//Begin - Added By Mark Lee 07/11/12
//Added By Mark Lee 07/30/12	update speed
////update blob data.
//Update ctx_acp_clause_image 
//Set image_file = (Select image_file From ctx_acp_clause Where ctx_acp_clause.ctx_acp_clause_id = ctx_acp_clause_image.clause_id and ctx_acp_clause.revision = ctx_acp_clause_image.revision  )
//Where ctx_acp_clause_image.image_file is null;
Update ctx_acp_clause_image 
Set image_file = ctx_acp_clause.image_file
From ctx_acp_clause_image , ctx_acp_clause
Where ctx_acp_clause.ctx_acp_clause_id = ctx_acp_clause_image.clause_id 
and ctx_acp_clause.revision = ctx_acp_clause_image.revision
and ctx_acp_clause_image.image_file is null
and ctx_acp_clause.image_file is not null ;

If sqlca.sqlcode < 0 Then
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('update history clause image data', Sqlca.SQLErrText,'n_cst_clause.of_ini_data()')
	gb_upgrade_failed = TRUE
	Destroy 	lds_need_audit
	Destroy	lds_need_image
	Destroy 	lds_audit
	Destroy	lds_image
	
	Return -1
End If
//End - Added By Mark Lee 07/11/12

//Added By Mark Lee 07/11/12
Destroy 	lds_need_audit
Destroy	lds_need_image
Destroy 	lds_audit
Destroy	lds_image

Return 1
	


end function

public function integer of_upload_file (long al_clause_id, decimal adec_revision, string as_filename);Datetime ldt_updatedate
Return of_upload_file(al_clause_id,adec_revision,as_filename,ldt_updatedate)






end function

public function integer of_upload_file (long al_clause_id, decimal adec_revision, string as_filename, ref datetime adt_updatedate);//////////////////////////////////////////////////////////////////////
// Function: of_upload_file()
// Arguments:
// 	value        long        al_clause_id
// 	value        decimal     adec_revision
// 	value        string      as_filename
// 	reference    datetime    adt_updatedate
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-01-11
//--------------------------------------------------------------------
// Description: Upload clause file to DB.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Blob lb_value
long li_count,li_count_all

if inv_dm_utils.of_readblob( as_filename, ref lb_value ) < 0 then
	messagebox('Error1','Failed to get document data')
	Return -1
end if

// Check doc exists in DB
SELECT count(1) into :li_count FROM ctx_acp_clause_image 
WHERE clause_id = :al_clause_id AND revision = :adec_revision;

IF li_count < 1 THEN
	INSERT INTO ctx_acp_clause_image (clause_id, revision, modify_date,doc_type)
	VALUES(:al_clause_id, :adec_revision, getdate(),'doc');
ELSE 
	UPDATE ctx_acp_clause_image SET modify_date = getdate()  
	 WHERE clause_id = :al_clause_id AND revision = :adec_revision;
END IF
If sqlca.sqlcode <> 0 Then
	Messagebox('Upload Error -3','Failed to upload the document to database, please call support.')
	Return -1
End If

UPDATEBLOB ctx_acp_clause_image SET image_file = :lb_value WHERE clause_id = :al_clause_id and revision = :adec_revision;
If sqlca.sqlcode <> 0 Then
	messagebox('Upload Error -4','Failed to save clause, please call support.~r~n' + sqlca.sqlerrtext )
	Return -1
End If

Select modify_date Into :adt_updatedate From ctx_acp_clause_image 
WHERE clause_id = :al_clause_id AND revision = :adec_revision;

UPDATE ctx_acp_clause SET modify_date = :adt_updatedate 
WHERE ctx_acp_clause_id = :al_clause_id;
If sqlca.sqlcode <> 0 Then
	messagebox('Upload Error -5','Failed to modify clause information, please call support.~r~n' + sqlca.sqlerrtext )
	Return -1
End If

//gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(al_clause_id) + '.' + String(adec_revision) , regstring!, String(adt_updatedate,"mm/dd/yyyy hh:mm:ss"))	
of_registry_set(al_clause_id,adec_revision,adt_updatedate)


Return 1
end function

public function string of_generate_name (long al_clause_id, decimal adec_revision);Return gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clause_id) + '.' + String(adec_revision) + ".doc"
end function

public function integer of_check_name (string as_clause_name);Integer i
String ls_unsupport_char[] = {'|','*','?','<',':','>'}

For i = 1 To UpperBound(ls_unsupport_char[])
	If Pos(as_clause_name,ls_unsupport_char[i],1) > 0 Then
		Messagebox('Verification',"There is unsupported character '"+ls_unsupport_char[i]+"' included in the clause name '"+as_clause_name+"', please modify the clause name.")
		Return -1
	End If
Next
Return 1

end function

public function integer of_download_file (long al_clause_id, ref string as_file_name);Decimal{1} ldec_revision

ldec_revision = of_get_revision(al_clause_id)

If isnull(ldec_revision) Then ldec_revision = 0.0
Return of_download_file(al_clause_id,ldec_revision,as_file_name)
end function

public function integer of_upload_file (long al_clause_id, string as_file_name);Decimal{1} ldec_revision

ldec_revision = of_get_revision(al_clause_id)

Return of_upload_file( al_clause_id, ldec_revision,as_file_name)
end function

public function decimal of_get_revision (long al_clause_id);Decimal{1} ldec_revision
Select revision into  :ldec_revision From ctx_acp_clause
Where ctx_acp_clause_id = :al_clause_id;

Return ldec_revision
end function

public function String of_generate_name (long al_clause_id);Decimal{1} ldec_revision

ldec_revision = of_get_revision(al_clause_id)
Return of_generate_name(al_clause_id,ldec_revision)
end function

public function integer of_download_file (long al_clause_id);String ls_filename

Return of_download_file(al_clause_id,ls_filename)
end function

public function integer of_registry_get (long al_clause_id, decimal adec_revision, ref string as_lastupdate);Integer li_ret
//Modified By Mark Lee 04/18/12
//li_ret = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_"+string(al_clause_id) + '.' + String(adec_revision) , regstring!, as_lastupdate)	
li_ret = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", "clause_"+string(al_clause_id) + '.' + String(adec_revision) , regstring!, as_lastupdate)	
Return li_ret
end function

public function integer of_registry_get (long al_clause_id, ref string as_lastupdate);Decimal{1} ldec_revision
ldec_revision = This.of_get_revision(al_clause_id)
Return of_registry_get(al_clause_id,ldec_revision,as_lastupdate)



end function

public function integer of_registry_set (integer al_clause_id, decimal adec_revision, string as_updatedate);//Modified By Mark Lee 04/18/12
//Return gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(al_clause_id) + '.' + String(adec_revision) , regstring!, as_updatedate)	
Return gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", 'clause_' + string(al_clause_id) + '.' + String(adec_revision) , regstring!, as_updatedate)	

end function

public function integer of_registry_set (long al_clause_id, decimal adec_revision, datetime adt_updatedate);Return of_registry_set(al_clause_id,adec_revision,String(adt_updatedate,"mm/dd/yyyy hh:mm:ss"))
end function

public subroutine of_create_clause_attribute (long al_clause_id, long al_clause_handle, treeview atv_clause);//////////////////////////////////////////////////////////////////////
// Function: of_create_clause_attribute()
// Arguments:
// 	value    long        al_clause_id
// 	value    long        al_clause_handle
// 	value    treeview    atv_clause
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-12-16
//--------------------------------------------------------------------
// Description: For improving Performance. 
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

of_create_clause_attribute(al_clause_id,al_clause_handle,atv_clause,'')

end subroutine

public subroutine of_getattribvaluelist (long al_clause_id, ref string as_attarr[]);//////////////////////////////////////////////////////////////////////
// Function: of_GetAttribValueList()
// Arguments:
// 	value        long      al_clause_id
// 	reference    string    as_attarr[]
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-12-16
//--------------------------------------------------------------------
// Description: for Improving performance
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
long		ll_CurRow,ll_RowCnts
long		ll_Attribute_id,ll_First_Attr_id
String	ls_Clause_Alias,ls_Value_Code,ll_AttrLine[],ll_AttrList

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("clause_attribute", FALSE)
//------------------------------------------------------------------------

//ids_AttriValue.Retrieve(al_clause_id)
gnv_data.ids_clause_attribute.SetFilter('ctx_acp_clause_id = ' + String(al_clause_id) ) 
gnv_data.ids_clause_attribute.Filter()

ll_RowCnts = gnv_data.ids_clause_attribute.RowCount()
if ll_RowCnts <= 0 then Return 

ll_CurRow++

ll_First_Attr_id = gnv_data.ids_clause_attribute.GetItemNumber(ll_CurRow,"clause_attribute_id")
ls_Clause_Alias  = gnv_data.ids_clause_attribute.GetItemString(ll_CurRow,"clause_attribute_alias")
ls_Value_Code    = gnv_data.ids_clause_attribute.GetItemString(ll_CurRow,"clause_attribute_value_code")

//ll_AttrList = ls_Clause_Alias + " = " + ls_Value_Code
as_attarr[1] = ls_Clause_Alias + " = " + ls_Value_Code

do while ll_CurRow < ll_RowCnts
	ll_CurRow++
	ll_Attribute_id = gnv_data.ids_clause_attribute.GetItemNumber(ll_CurRow,"clause_attribute_id")
	
	do while ll_First_Attr_id = ll_Attribute_id
		ls_Value_Code = gnv_data.ids_clause_attribute.GetItemString(ll_CurRow,"clause_attribute_value_code")
		//ll_AttrList += ", " + ls_Value_Code
		as_attarr[UpperBound(as_attarr[])] += ", " + ls_Value_Code
		
		ll_CurRow++
		if ll_CurRow > ll_RowCnts then Exit
		ll_Attribute_id = gnv_data.ids_clause_attribute.GetItemNumber(ll_CurRow,"clause_attribute_id")
	loop
	
	if ll_CurRow > ll_RowCnts then Exit

	ll_First_Attr_id = ll_Attribute_id
	ls_Clause_Alias  = gnv_data.ids_clause_attribute.GetItemString(ll_CurRow,"clause_attribute_alias")
	ls_Value_Code    = gnv_data.ids_clause_attribute.GetItemString(ll_CurRow,"clause_attribute_value_code")
	
	//ll_AttrList += ENTERCHAR + ls_Clause_Alias + " = " + ls_Value_Code
	as_attarr[UpperBound(as_attarr[]) + 1 ] = ls_Clause_Alias + " = " + ls_Value_Code
	
loop

Return 

end subroutine

public subroutine of_create_clause_attribute (long al_clause_id, long al_clause_handle, treeview atv_clause, string as_ext_data);//////////////////////////////////////////////////////////////////////
// Function: of_create_clause_attribute()
// Arguments:
// 	value    long        al_clause_id
// 	value    long        al_clause_handle
// 	value    treeview    atv_clause
// 	value    string 	   as_ext_data
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-12-16
//--------------------------------------------------------------------
// Description: For improving Performance. 
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

long		i
String 	ls_Attrarr[]
TreeViewItem	ltvi_Item

//of_GetAttribValueList(al_clause_id,ls_Attrarr[]) //modified by gavins 20120723
of_get_attribvalue_list( al_clause_id,ls_Attrarr[]) 
If UpperBound(ls_Attrarr[]) = 0 Then Return

For i = 1 To UpperBound(ls_Attrarr[])
	ltvi_Item.Label = ls_Attrarr[i]
	If as_ext_data = '' Then
		ltvi_Item.data = al_clause_id 
	Else
		ltvi_Item.data = String(al_clause_id) +  as_ext_data
	End If
	ltvi_Item.PictureIndex = 6
	ltvi_Item.SelectedPictureIndex = 6
	atv_clause.InsertItemLast(al_clause_handle, ltvi_Item)	
Next


end subroutine

public function string of_download_document (long al_document_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_clauseof_download_document()
// $<arguments>
//		value	long	al_document_id		
// $<returns> string
// $<description>
// $<description> Download the document from Documet Library.
//////////////////////////////////////////////////////////////////////
// $<add> 2011-01-25 by Ken.Guo
//////////////////////////////////////////////////////////////////////


Blob  lb_image_data
Integer li_counter, li_loops, li_MaxPosition, li_Position
Integer li_SetStep, li_NewStep, li_loopsR, li_rtn
Long ll_start, ll_data_length
String ls_title
Boolean lb_needrestore = FALSE
Blob lb_data, lb_all_data
String ls_filename_temp,ls_docname,ls_doc_ext


//Added By Ken.Guo 2011-01-25.
Select document_name,document_type into :ls_docname,:ls_doc_ext from ctx_acp_document WHERE ctx_acp_document_id = :al_document_id;

// Get file data from database
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
		
		SetPointer(HourGlass!) 
		
		// Get file data from database
		SELECT Datalength(image_file)
		INTO :ll_data_length
		FROM ctx_acp_document
		WHERE ctx_acp_document_id = :al_document_id;
		
		IF SQLCA.SQLCODE = -1 THEN RETURN '' 
		
		IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
			RETURN ''
		END IF
		
		//Get length of the blob
		IF ll_data_length > 8000 THEN 
			 IF Mod(ll_data_length,8000) = 0 THEN 
				  li_loops = ll_data_length/8000 
			 ELSE 
				  li_loops = (ll_data_length/8000) + 1 
			 END IF 
		ELSE 
			 li_loops = 1 
		END IF 
		
		//--------Begin Modified by Alfee 09.17.2007--------------------------------
		//<$Reason>Display progress bar for the large blob
		li_NewStep = 20
		IF li_loops > li_NewStep THEN
			IF IsValid(w_appeon_gifofwait) THEN 
				//Keep the original progress bar
				lb_needrestore = TRUE
				ls_title = w_appeon_gifofwait.st_1.Text
				li_MaxPosition = w_appeon_gifofwait.hpb_1.MaxPosition
				li_Position = w_appeon_gifofwait.hpb_1.Position
				li_SetStep = w_appeon_gifofwait.hpb_1.SetStep
			ELSE
				OpenwithParm(w_appeon_gifofwait,"Getting the data...")
			END IF
			//Set the new progress bar
			li_loopsR = li_loops / li_NewStep
			IF Mod(li_loops, li_NewStep) <> 0 THEN li_loopsR ++
			w_appeon_gifofwait.st_1.Text = "Getting the data..."
			w_appeon_gifofwait.hpb_1.MaxPosition = li_loopsR * li_NewStep
			w_appeon_gifofwait.hpb_1.Position = 0
			w_appeon_gifofwait.hpb_1.SetStep = li_loopsR		
		END IF
		
		//Get and store the blob
		li_rtn = 1
		FOR li_counter = 1 to li_loops
			ll_start = (li_counter - 1) * 8000 + 1
			SELECTBLOB substring(image_file,:ll_start,8000)
					INTO :lb_data
					FROM ctx_acp_document
					WHERE ctx_acp_document_id = :al_document_id;
			IF SQLCA.SQLCODE = -1 THEN 
				li_rtn = -1
				EXIT
			END IF
			
			lb_all_data += lb_data
			
			//Change the progress bar
			IF IsValid(w_appeon_gifofwait) AND li_loops > li_NewStep THEN
				IF Mod(li_counter, li_loopsR) = 1 THEN w_appeon_gifofwait.hpb_1.StepIt() 
			ELSE
				IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
			END IF
			
		NEXT 
		
		//Restore Progress Bar
		IF IsValid(w_appeon_gifofwait) and li_loops > li_NewStep THEN 
			IF lb_needrestore THEN
				w_appeon_gifofwait.st_1.Text = ls_title
				w_appeon_gifofwait.hpb_1.MaxPosition = li_MaxPosition
				w_appeon_gifofwait.hpb_1.Position = li_Position
				w_appeon_gifofwait.hpb_1.SetStep = li_SetStep
			ELSE
				Close(w_appeon_gifofwait)
			END IF
		END IF
		
		//Store the blob
		lb_image_data = lb_all_data
		
		If li_rtn < 0 Then
			MessageBox( "DownLoad File", "Download file failed!" )		
			RETURN ''			
		End If
ELSE
	SELECTBLOB image_file
	INTO :lb_image_data
	FROM ctx_acp_document
	WHERE ctx_acp_document_id = :al_document_id;
	
	//-------------Begin Added by Alfee 09.07.2007-------------------
	IF SQLCA.SQLCODE = -1 THEN 
		MessageBox( "DownLoad File", "Download file failed! ~r~n" + SQLCA.SQLERRTEXT )
		Return ''
	END IF
	//-------------End Added ----------------------------------------
END IF

// Save blob value to a local file.
//Return of_saveblob(as_filename, lb_image_data)
Long ll_writelength, ll_readlength
string ls_save_path

ls_filename_temp = gs_dir_path + gs_DefDirName + "\Agreement\Manager\doc_library_" + string(al_document_id) + "." + ls_doc_ext

if fileexists(ls_filename_temp) then 
	if not filedelete(ls_filename_temp) then
		return ''
	end if
end if

SetPointer(HourGlass!) 

ls_save_path = mid(ls_filename_temp,1,lastpos(ls_filename_temp,'\'))
gnv_appeondll.of_parsepath(ls_save_path)

ll_readlength = Len(lb_image_data)

ll_writelength = AppeonWriteFile(ls_filename_temp, lb_image_data, ll_readlength)
if ll_writelength < 0 then return ''

SetPointer(Arrow!)

Return ls_filename_temp

end function

public function integer of_download_file (long al_clause_id, decimal adec_revision, datetime adt_lastmodify, ref string as_file_name);//////////////////////////////////////////////////////////////////////
// Function: of_download_file()
// Arguments:
// 	value        long       al_clause_id
// 	value        decimal    adec_revision
//		value 		 datetime	adt_lastmodify
// 	reference    string     as_file_name
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Added By Ken.Guo 2011-05-03.
//--------------------------------------------------------------------
// Description: Download clause file with clause_id and revision.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Datetime ldt_modify_date
String ls_updatedate
Boolean lb_select
String ls_lastupdate
long ll_getupdate,ll_data_length,li_loops,li_counter,ll_start,ll_BlobLen
Long ll_CurrentPos,li_Cnt
Blob lb_all_data,lb_data,lblb_Data
Integer li_FileNum,li_Writes

//Select modify_date into :ldt_modify_date 
//From ctx_acp_clause_image
//Where clause_id = :al_clause_id and revision = :adec_revision;

ls_updatedate = String(adt_lastmodify,'mm/dd/yyyy hh:mm:ss')

gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\")
//as_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clause_id) + '.' + String(adec_revision) +  ".doc"
as_file_name = of_generate_name(al_clause_id,adec_revision)
	//Get if the document existed and updated
	If Not fileexists(as_file_name) Then
		lb_select = True
	Else		
		//ll_getupdate = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_"+string(al_clause_id) + '.' + String(adec_revision) , regstring!, ls_lastupdate)	
		//Get local file date
		ll_getupdate = This.of_registry_get(al_clause_id, adec_revision, ls_lastupdate)
		If ll_getupdate <> 1 Then
			lb_select = True
		Else
			If ls_updatedate <> ls_lastupdate Then 
				lb_select = True
			End If		
		End If	
	End If
	
	//Gen the document if not existed or updated
	If lb_select = True Then
		lb_select = False	
		If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then		
			SELECTBLOB image_file INTO :lb_all_data
			  FROM ctx_acp_clause_image WHERE clause_id = :al_clause_id and revision = :adec_revision;
		Else			
			SELECT Datalength(image_file) INTO :ll_data_length
			  FROM ctx_acp_clause_image WHERE clause_id = :al_clause_id and revision = :adec_revision;
			
			If isnull(ll_data_length) Then ll_data_length = 0
			
			If ll_data_length > 8000 Then 
				If Mod(ll_data_length,8000) = 0 Then
					li_loops = ll_data_length/8000 
				Else
					li_loops = (ll_data_length/8000) + 1 
				End If 
			ElseIf ll_data_length > 0 Then 
				li_loops = 1 
			End If 
			
			For li_counter = 1 To li_loops				
				ll_start = (li_counter - 1) * 8000 + 1
				SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
				  FROM ctx_acp_clause_image WHERE clause_id = :al_clause_id and revision = :adec_revision;	
				lb_all_data += lb_data
			Next 
		End If
		If isnull(lb_all_data) Then lb_all_data = blob('')
		If Len(lb_all_data) < 1 Then 
			as_file_name = ''
			Return -1	 	
		End If
		
		li_FileNum = FileOpen(as_file_name , StreamMode! ,Write!,Shared!, Replace!)
		If li_FileNum = -1 Then 
			as_file_name = ''
			Return -1
		End If
			
		ll_BlobLen = Len(lb_all_data)
		If ll_BlobLen > 32765 Then
			If Mod(ll_BlobLen, 32765) = 0 Then
				li_Writes = ll_BlobLen / 32765
			Else
				li_Writes = (ll_BlobLen / 32765) + 1
			End If
		 Else
			li_Writes = 1
		End If
		
		ll_CurrentPos = 1
		
		For li_Cnt = 1 To li_Writes
			lblb_Data = BlobMid(lb_all_data, ll_CurrentPos, 32765)
			ll_CurrentPos += 32765
			If FileWrite(li_FileNum, lblb_Data) = -1 Then
				as_file_name = ''
				Return -1
			End If
		Next
		
		FileClose(li_FileNum)
		//gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(al_clause_id) + '.' + String(adec_revision), regstring!, ls_updatedate)			
		of_registry_set(al_clause_id,adec_revision,ls_updatedate)
	End If	
Return 1
end function

public function integer of_download_file (long al_clause_id[], decimal adec_revision[], ref string as_file_name[]);//////////////////////////////////////////////////////////////////////
// Function: of_download_file()
// Arguments:
// 	value        long       al_clause_id
// 	value        decimal    adec_revision
// 	reference    string     as_file_name
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-01-11
//--------------------------------------------------------------------
// Description: Download clause file with clause_id and revision.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

Long i

For i = 1 To UpperBound(al_clause_id[])
	of_download_file(al_clause_id[i],adec_revision[i],as_file_name[i])
Next


Return 1

end function

public function long of_retrieve_attribute_value ();//====================================================================
// Function: of_Retrieve_attribute_value
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-07-23
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Return ids_Clause_attribute_value.Retrieve( )
end function

public subroutine of_get_attribvalue_list (long al_clause_id, ref string as_attarr[]);//of_Get_AttribValue_List


long		ll_CurRow,ll_RowCnts, ll_Find
long		ll_Attribute_id,ll_First_Attr_id
String	ls_Clause_Alias,ls_Value_Code,ll_AttrLine[],ll_AttrList

//ids_AttriValue.Retrieve(al_clause_id)
ll_Find  = ids_Clause_attribute_value.Find( "ctx_acp_clause_id = " + String(al_clause_id), 1, ids_Clause_attribute_value.RowCount( ) )


ll_RowCnts = ids_Clause_attribute_value.RowCount()
if ll_RowCnts <= 0 or ll_Find <=0  then Return 

For ll_CurRow = ll_Find To ll_RowCnts 
	ll_Attribute_id =  ids_Clause_attribute_value.GetItemNumber(ll_CurRow,"ctx_acp_clause_id")
	If ll_Attribute_id <> al_clause_id Then Exit
	ls_Value_Code = ids_Clause_attribute_value.GetItemString(ll_CurRow,"clause_attribute_value_code")
	
	as_attarr[UpperBound(as_attarr[]) + 1 ] = ls_Value_Code
Next









end subroutine

public function integer of_update_document (str_clause astr_clause, integer ai_type);//Add by jervis 01.30.2010
//ai_type:1-Clause Update, 2-Clause Status Change
long ll_num,ll_mes
Long ll_clause_arr[]
n_ds lds_clause_template_ref, lds_clause_document_ref

astr_clause.ai_type = ai_type

//set to array clauses.
If UpperBound(astr_clause.al_clause_id_arr[]) = 0 Then
	astr_clause.al_clause_id_arr[1] = astr_clause.al_clause_id
End If

//Check Template and Document if they used these clauses.
lds_clause_template_ref = Create n_ds
lds_clause_template_ref.Dataobject = 'd_acp_clause_template_ref'
lds_clause_template_ref.SetTransObject(SQLCA)

lds_clause_document_ref = Create n_ds
lds_clause_document_ref.Dataobject = 'd_acp_clause_document_ref'
lds_clause_document_ref.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	lds_clause_template_ref.Retrieve(astr_clause.al_clause_id_arr[])
	lds_clause_document_ref.Retrieve(astr_clause.al_clause_id_arr[])
gnv_appeondb.of_commitqueue( )	

//Update Template
If lds_clause_template_ref.RowCount() > 0 Then
	ll_mes = messagebox('Updating Existing Templates','Would you like to update the Template(s) that refer to this clause?',question!,YesNo!)
	If ll_mes = 1 Then
		openwithparm(w_clause_template,astr_clause)
	End If
End If

//Update Document 
If lds_clause_document_ref.RowCount() > 0 Then
	ll_mes = messagebox('Updating Existing Documents','Would you like to update the Document(s) in the Contract Folder-> Document Manager tab that refer to this clause?',question!,YesNo!)
	If ll_mes = 1 Then
//		Messagebox('Developing...','Not Complete. Please try it on next version.')
//		If Not FileExists(astr_clause.as_clause_file ) Then
//			If This.of_download_file(astr_clause.al_clause_id ) < 0 Then Return -1
//			astr_clause.as_clause_file = This.of_generate_name(astr_clause.al_clause_id)
//		End If
 		openwithparm(w_clause_document,astr_clause)
	End If
End If

If lds_clause_template_ref.RowCount()  + lds_clause_document_ref.RowCount() = 0 Then
	Return 0
End If

Return 1
end function

on n_cst_clause.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_clause.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////
// Event: constructor()
// Arguments:
//--------------------------------------------------------------------
// Return:  long
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-01-01
//--------------------------------------------------------------------
// Description: For New Clause Module. add NF for Clause Control Version.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
ids_Clause_attribute_value = Create DataStore//added by gavins 20120723
ids_Clause_attribute_value.DataObject = 'ds_dm_clause_attr_value'
ids_Clause_attribute_value.SetTransObject( sqlca )

end event

