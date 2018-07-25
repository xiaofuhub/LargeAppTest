$PBExportHeader$w_dm_sell_document.srw
forward
global type w_dm_sell_document from w_response
end type
type cbx_preview from checkbox within w_dm_sell_document
end type
type st_process from statictext within w_dm_sell_document
end type
type cb_design from commandbutton within w_dm_sell_document
end type
type st_info from statictext within w_dm_sell_document
end type
type cb_preview from commandbutton within w_dm_sell_document
end type
type cb_weblink from commandbutton within w_dm_sell_document
end type
type cb_4 from commandbutton within w_dm_sell_document
end type
type cb_3 from commandbutton within w_dm_sell_document
end type
type cb_checkin from commandbutton within w_dm_sell_document
end type
type dw_1 from u_dw_contract within w_dm_sell_document
end type
type cb_pastefile from commandbutton within w_dm_sell_document
end type
type cb_scan from commandbutton within w_dm_sell_document
end type
end forward

global type w_dm_sell_document from w_response
integer width = 2743
integer height = 1596
string title = "Document Properties"
long backcolor = 33551856
cbx_preview cbx_preview
st_process st_process
cb_design cb_design
st_info st_info
cb_preview cb_preview
cb_weblink cb_weblink
cb_4 cb_4
cb_3 cb_3
cb_checkin cb_checkin
dw_1 dw_1
cb_pastefile cb_pastefile
cb_scan cb_scan
end type
global w_dm_sell_document w_dm_sell_document

type variables
Boolean ib_new
Long il_ctx_id
long il_template_approved, il_document_approved //added by alfee 08.31.2007
str_add_doc istr_add_doc
String is_old_status

DataStore ids_category_filtered

n_cst_right inv_right
n_cst_dm_utils inv_utils //note: auto instantiate variable. added by Alfee 05.08.2007 
n_cst_filesrv inv_filesrv //Alfee 09.18.2008

String 	is_scaned_file //Added By Ken.Guo 2009-05-31.
long		il_OriScreenID

//Added By Ken.Guo 2010-06-28.
Long il_batch_ctx_id[] 
Boolean ib_batch_new
str_batch_doc istr_batch_doc,istr_batch_doc_invalid,istr_batch_doc_empty
long il_doc_id
str_ctx_email istr_ctx_email
String is_ocr_result
Boolean ib_ocred
String 	is_operation		//Added By Mark Lee 06/13/2013

String is_doc_editable //Alfee 05.07.2012  //(Appeon)Harry 08.30.2013 - V141 ISG-CLX

String is_activewindow_name //Added By Jay Chen 04-17-2014 //(Appeon)Harry 05.06.2014 - V142 ISG-CLX
end variables

forward prototypes
public function integer of_filter_category (ref datawindowchild adwc_category, string as_basetype)
public subroutine of_refreshdocpath (string as_pathname)
public subroutine of_filter_template ()
public subroutine of_create_dw ()
end prototypes

public function integer of_filter_category (ref datawindowchild adwc_category, string as_basetype);//Filter category according to the user rights- Added by Alfee 07.26.2007
String ls_filter
Long ll_cnt, i
DatawindowChild ldwc_template

IF NOT IsValid(ids_category_filtered) THEN RETURN -1
IF dw_1.RowCount() < 1 THEN RETURN -1
IF Not IsNumber(as_basetype) THEN RETURN -1

If Not ib_new Then Return -1 //Added By Ken.Guo 2009-12-04. Only Add a new document need to filter.

////Added By Ken.Guo 2010-06-29. //Commented By Ken.Guo 2011-07-19
//If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '0' Then 
//	dw_1.GetChild('from_templete_id',ldwc_template)
//	ldwc_template.SetFilter("type = " + as_basetype)
//	ldwc_template.Filter()
//	Return 0
//End If

//Get the categories which is not allowed to access to the current user
String ls_filter_category
ls_filter_category = "Category_type = " + String(Integer(as_basetype) + 2) 
If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '1' Then 
	ls_filter_category = ls_filter_category +  " or Category_type = 1 "
End If
ids_category_filtered.SetFilter(ls_filter_category)
ids_category_filtered.Filter()

//Get the filter criteria and filter in the category dddw
ll_cnt = ids_category_filtered.RowCount()
FOR i = 1 to ll_cnt
	IF i = 1 THEN ls_filter	= "lookup_code not in ( "  
	ls_filter += String(ids_category_filtered.GetItemNumber(i, 'category_code')) 
	IF i < ll_cnt THEN 
		ls_filter += ", "
	ELSE
		ls_filter += " )"
	END IF
NEXT
IF Len(Trim(ls_filter)) < 1 THEN ls_filter = '1=1' 
adwc_category.SetFilter(ls_filter)
adwc_category.Filter( )		

adwc_category.rowsdiscard(1, adwc_category.FilteredCount(), Filter! ) //Added By Ken.Guo 02/22/2012. 

//Restore the data in category datastore
ids_category_filtered.SetFilter('1=1')
ids_category_filtered.Filter()

//Added By Ken.Guo 2010-01-09. show all template or document by access right.
dw_1.GetChild('from_templete_id',ldwc_template)
ll_cnt = adwc_category.RowCount()
ls_filter = ''
For i = 1 To ll_cnt
	If i = 1 Then ls_filter = 'category in ('
	ls_filter += String(adwc_category.GetItemNumber(i, 'lookup_code') )
	If i < ll_cnt Then
		ls_filter += ", "
	Else
		ls_filter += " )"
	End If
Next

//Added By Ken 08/29/2011. 
If gnv_data.of_getitem( 'icred_settings', 'filter_template', False) = '1' Then 
	ldwc_template.SetFilter('1 = 2')
	ldwc_template.Filter()		
Else
	If ls_filter <> '' Then
		ls_filter += 'and type = ' + as_basetype
		ldwc_template.SetFilter(ls_filter)
		ldwc_template.Filter()	
	Else
		ldwc_template.SetFilter('1 = 2')
		ldwc_template.Filter()	
	End If
End If
If ldwc_template.Rowcount( ) = 0 THEN ldwc_template.InsertRow( 1 )


RETURN 1

end function

public subroutine of_refreshdocpath (string as_pathname);//====================================================================
// Function: of_RefreshDocPath()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_PathName
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-10-19
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

dw_1.setredraw(False)
if dw_1.RowCount( ) > 0 then
	cb_Preview.Enabled = true
	istr_add_doc.filename = as_PathName
	//lstr_add_doc.notes = dw_1.GetItemstring( 1, "notes")
	
	dw_1.Setitem(1, "filename", as_PathName)
	
	//if Not f_validstr(Trim(dw_1.GetitemString(1, "doc_name"))) then
		as_PathName = inv_utils.of_get_filename(as_PathName)			
		dw_1.Setitem(1, "doc_name", as_PathName) 
	//end if
	
	if Not f_ValidStr(as_PathName) then 
		cb_3.Enabled = false
	else
		cb_3.Enabled = true
	end if
end if

dw_1.setredraw(True)
end subroutine

public subroutine of_filter_template ();return
end subroutine

public subroutine of_create_dw ();String	ls_TabName,ls_DWName[],ls_DOName[]

DataWindow	ldw_Name[]

ls_TabName = "tabpage_images"

ldw_Name[1]  = dw_1
ls_DWName[1] = "dw_1"
ls_DOName[1] = dw_1.DataObject
//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//Added By Jay Chen 04-17-2014
Window	lw_activewindow
lw_activewindow = w_mdi.GetActiveSheet( )
if isvalid(lw_activewindow) then
	is_activewindow_name = lw_activewindow.classname( )
end if
//---------End Added ------------------------------------------------------
//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
/*
Long ll_cnt
Select Count(1) Into :ll_cnt From ctx_screen Where data_view_id = :gi_contract_view_id And dataobject = :ls_DOName[1];
If ll_cnt > 0 Then //Added By Ken.Guo 2010-07-01. Added if Statement.
	f_create_contract_dw(gi_contract_view_id,ls_TabName,ldw_Name,ls_DWName,ls_DOName)		
End If
*/
//Added By Jay Chen 04-04-2014
long ll_view_id,ll_category,ll_ctx_id,ll_row,ll_cnt
if is_activewindow_name = "w_documents_browse" then
	ll_row = w_documents_browse.uo_1.tab_1.tabpage_browse.dw_browse.getrow()
	if ll_row > 0 then
		ll_category = w_documents_browse.uo_1.tab_1.tabpage_browse.dw_browse.object.category[ll_row]
		ll_ctx_id = w_documents_browse.uo_1.tab_1.tabpage_browse.dw_browse.object.ctx_id[ll_row]
		ll_view_id = w_documents_browse.of_get_ctx_view(ll_category,ll_ctx_id)
		Select Count(1) Into :ll_cnt From ctx_screen Where data_view_id = :ll_view_id And dataobject = :ls_DOName[1];
		If ll_cnt > 0 Then 
			f_create_contract_dw(ll_view_id,ls_TabName,ldw_Name,ls_DWName,ls_DOName)
			w_documents_browse.il_current_properties_view = ll_view_id
		End If
	end if
else
	Select Count(1) Into :ll_cnt From ctx_screen Where data_view_id = :gi_contract_view_id And dataobject = :ls_DOName[1];
	If ll_cnt > 0 Then //Added By Ken.Guo 2010-07-01. Added if Statement.
		f_create_contract_dw(gi_contract_view_id,ls_TabName,ldw_Name,ls_DWName,ls_DOName)		
	End If
end if
//---------End Modfiied ------------------------------------------------------
//gnv_win_backcolor.of_ChangeWindowBackColor(this) //Added By Ken.Guo 2011-07-08. //Commented By Ken.Guo 05/15/2012
end subroutine

on w_dm_sell_document.create
int iCurrent
call super::create
this.cbx_preview=create cbx_preview
this.st_process=create st_process
this.cb_design=create cb_design
this.st_info=create st_info
this.cb_preview=create cb_preview
this.cb_weblink=create cb_weblink
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_checkin=create cb_checkin
this.dw_1=create dw_1
this.cb_pastefile=create cb_pastefile
this.cb_scan=create cb_scan
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_preview
this.Control[iCurrent+2]=this.st_process
this.Control[iCurrent+3]=this.cb_design
this.Control[iCurrent+4]=this.st_info
this.Control[iCurrent+5]=this.cb_preview
this.Control[iCurrent+6]=this.cb_weblink
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_checkin
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.cb_pastefile
this.Control[iCurrent+12]=this.cb_scan
end on

on w_dm_sell_document.destroy
call super::destroy
destroy(this.cbx_preview)
destroy(this.st_process)
destroy(this.cb_design)
destroy(this.st_info)
destroy(this.cb_preview)
destroy(this.cb_weblink)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_checkin)
destroy(this.dw_1)
destroy(this.cb_pastefile)
destroy(this.cb_scan)
end on

event open;call super::open;/******************************************************************************************************************
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By   Alfee      Change Date  07.26.2007 Reason: Arrange the codes ...
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
str_add_doc lstr_add_doc
Integer li_setting
Long ll_doc_id
Long ll_doc_status
Long ll_doc_category
String ls_base_type, ls_doc_type, ls_filename, ls_preview

DatawindowChild ldwc_category, ldwc_template, ldwc_wf, ldwc_DocFromName,ldwc_ReceivedBy

//BEGIN---Modify by Scofield on 2010-04-20
if IsValid(gw_Contract) then il_OriScreenID = gw_Contract.of_GetCurrentScreenID()
of_create_dw()
dw_1.of_SetReqColumn(TRUE)
dw_1.Event ue_populatedddws()
if IsValid(gw_Contract) then gw_Contract.of_SetCurrentScreenID(dw_1.il_ScreenId)
//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//Added By Jay Chen 04-04-2014
if is_activewindow_name = "w_documents_browse" then
	w_documents_browse.il_current_properties_screen = dw_1.il_ScreenId
end if
//---------End Added ------------------------------------------------------
//END---Modify by Scofield on 2010-04-20

//Begin - Added By Mark Lee 05/07/2013
ls_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Document_Manager_Tab_Preview_in_Document_Manager_Checked" )					
If isnull(ls_preview) or trim(ls_preview) = '' or ls_preview = '1' Then
	cbx_preview.checked = True
Else
	cbx_preview.checked = False
End If 
//End - Added By Mark Lee 05/07/2013

//---------Begin Added by (Appeon)Harry 09.14.2015 for Bug # 4710--------
IF w_mdi.of_security_access( 5300 ) = 0 THEN
	cb_design.Visible = False
ELSE
	cb_design.Visible = True
END IF
//---------End Added ------------------------------------------------------

inv_filesrv = Create n_cst_filesrv //Alfee 09.18.2008
IF NOT IsvaLid(Message.PowerObjectParm) THEN RETURN

//get approved code of contract --- added by alfee 08.31.2007
il_template_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Template Review Status' and code = 'Approved'"))
il_document_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Document Review Status' and code = 'Approved'"))

lstr_add_doc = Message.PowerObjectParm
ib_new = lstr_add_doc.new
ll_doc_id = lstr_add_doc.doc_id
il_ctx_id = lstr_add_doc.ctx_id

//Added By Ken.Guo 2010-06-28.
ib_batch_new = lstr_add_doc.ab_batch_new
il_batch_ctx_id[] = lstr_add_doc.al_batch_ctx_id[] 

ids_category_filtered = Create DataStore
ids_category_filtered.DataObject = 'd_dm_category_filtered'
//--------Begin Added by Alfee 11.13.2007------------------
//<$Reason>if not a new document, display template ids with any status.
IF Not ib_new THEN dw_1.Modify("from_templete_id.dddw.name = 'dddw_document_baseondoc_list_all'")
//--------End Added ---------------------------------------
dw_1.Getchild( "from_templete_id", ldwc_template)
dw_1.Getchild( "wf_id", ldwc_wf)
dw_1.getchild( "category",ldwc_category)
dw_1.GetChild( "doc_from_name", ldwc_DocFromName)
dw_1.GetChild( "Received_By", ldwc_ReceivedBy)

ids_category_filtered.SetTransObject(SQLCA)
ldwc_template.Settransobject( SQLCA )
ldwc_wf.Settransobject( SQLCA )
ldwc_category.SettransObject( SQLCA )
ldwc_DocFromName.SetTransObject( SQLCA )
ldwc_ReceivedBy.SetTransObject( SQLCA )
dw_1.Settransobject( SQLCA )

gnv_appeondb.of_startqueue( )
ids_category_filtered.Retrieve(gs_user_id)
//ldwc_template.Retrieve() - by alfee 08.31.2007
//--------Begin Modifieded by Alfee 11.13.2007------------------
//<$Reason>if not a new document, display template ids with any status.
IF Not ib_new THEN 
	ldwc_template.Retrieve()
ELSE	
	ldwc_template.Retrieve(il_template_approved, il_document_approved)
END IF	
//ldwc_template.Retrieve(il_template_approved, il_document_approved)
//--------End Modified ---------------------------------------
ldwc_wf.Retrieve("04")
ldwc_category.Retrieve()
select category into :ll_doc_category from ctx_basic_info where ctx_id = :lstr_add_doc.ctx_id; //$<add> 02.14.2007 By: Jervis

ldwc_DocFromName.Retrieve(il_ctx_id)
ldwc_DocFromName.InsertRow(1)

ldwc_ReceivedBy.Retrieve(il_ctx_id)
ldwc_ReceivedBy.InsertRow(1)

gnv_appeondb.of_commitqueue( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.27.2007 By: Jervis
//$<reason> Set Filter trigger by <> 104-New Buy Side Document
if dw_1.dataobject = "d_dm_new_buy_document" then
	ldwc_wf.SetFilter("wf_triggered_by <> '001'")
	//ldwc_wf.SetFilter("wf_triggered_by = '104'") //alfee 03.14.2008
	ldwc_wf.Filter( )
else
	ldwc_wf.SetFilter("wf_triggered_by <> '104'")
	//ldwc_wf.SetFilter("wf_triggered_by = '001'") //alfee 03.14.2008
	ldwc_wf.Filter( )
end if
ldwc_wf.Insertrow(1)
//---------------------------- APPEON END ----------------------------

// Create a sell contract document
IF ib_new THEN
	dw_1.Insertrow(0)
	// Initialize datawindow 
	dw_1.setitem(1, "ctx_id", il_ctx_id)
	
	dw_1.Setitem(1, "create_by", gs_user_id)
	dw_1.setitem(1, 'create_date', Datetime(today()))
	
	dw_1.Setitem(1, "status_by", gs_user_id)	
	dw_1.setitem(1, 'status_date', Datetime(today()))
	
	// Set default document status is 'New'.
	ll_doc_status = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Document Status') and upper(code) = upper('New')"))
	IF ll_doc_status > 0 THEN dw_1.setitem(1, 'status', ll_doc_status)
	dw_1.Modify('status.protect = 1')
	dw_1.Modify("status.Background.Color='553648127'" )	
	// Set default as contract
	//--------Begin Modified by Alfee 07.25.2007----------------------------
	//Filter category according to the user rights
	ls_base_type = dw_1.GetItemString(1, "Base_type")
	IF ls_base_type = "1" OR ls_base_type = "2" THEN of_filter_category(ldwc_category, ls_base_type)
	IF ldwc_category.find('lookup_code = '+string(ll_doc_category),1,ldwc_category.rowcount()) > 0 THEN 
	//if ll_doc_category > 0 then 
	//--------End Modified -----------------------------------------------
		dw_1.setitem(1, 'category', ll_doc_category)
		//Added by Ken 2011-08-29
		If gnv_data.of_getitem( 'icred_settings', 'filter_template', False) = '1' Then 
			ldwc_template.Setfilter( "type = "+String(ls_base_type)+" and category = " + string(ll_doc_category) )
			ldwc_template.Filter()
			IF ldwc_template.Rowcount( ) = 0 THEN ldwc_template.InsertRow( 1 )
		End If
	END IF 
	IF dw_1.dataobject = "d_dm_new_buy_document" THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 02.14.2007 By: Jervis
		//$<reason> 
		//ll_doc_category = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Contract')"))
		//ll_doc_category = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Contract')"))
		//IF ll_doc_category > 0 THEN dw_1.setitem(1, 'category', ll_doc_category)
		//---------------------------- APPEON END ----------------------------
		//This.Title = "Add Buy Side Document"
		If ib_batch_new and UpperBound(il_batch_ctx_id[]) > 1 Then
			This.Title = "Batch Add Document"
		Else
			This.Title = "Add Document"
		End If
	ELSE
		//This.Title = "Add Sell Side Document"
		If ib_batch_new and UpperBound(il_batch_ctx_id[]) > 1 Then
			This.Title = "Batch Create New Document"
		Else
			This.Title = "Create New Document"
		End If
	END IF
	dw_1.SetitemStatus( 1, 0, Primary!, NotModified! )	
ELSE	// Retrieve old doc
	IF dw_1.Retrieve( ll_doc_id ) > 0 THEN
		ls_base_type = dw_1.GetItemString(1, "Base_type")
//Commented By Ken.Guo 2009-10-12. Category need be modified.
//		IF ls_base_type = "1" OR ls_base_type = "2" THEN
//			ldwc_template.Setfilter( "type = " + String(ls_base_type) + " and category = " + string(dw_1.GetItemNumber(1,"category") ))
//			ldwc_template.filter( )
//		END IF		
		is_old_status = dw_1.Describe("Evaluate( 'lookupdisplay(status)', 1 )")
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.25.2007 By: Jack
	//$<reason> Fix a defect.
//Commented By Ken.Guo 2009-10-12. Category need be modified.	
//	dw_1.Modify('category.protect = 1')
//	dw_1.Modify("category.Background.Color='553648127'" )	
	//---------------------------- APPEON END ----------------------------
	
	//Commented By Ken.Guo 2011-04-01
	//dw_1.Modify('doc_type.protect = 1')
	//dw_1.Modify("doc_type.Background.Color='553648127'" )
	
	dw_1.Modify('wf_id.protect = 1')
	dw_1.Modify('base_type.protect = 1')
	dw_1.Modify('from_templete_id.protect = 1')
	dw_1.Modify('revision.protect = 1')
	dw_1.Modify("wf_id.Background.Color='553648127'" )
	dw_1.Modify("base_type.Background.Color='553648127'" )
	dw_1.Modify("from_templete_id.Background.Color='553648127'" )
	dw_1.Modify("revision.Background.Color='553648127'" )
	
	//Added By Ken.Guo 2009-05-20.
	if dw_1.GetItemString(1,'checkout_status') > '1' then 
		cb_weblink.visible = True 
	end if
	
	cb_Scan.Enabled = false
	cb_CheckIn.Enabled = false
	cb_PasteFile.Enabled = false
	cb_Preview.Enabled = false
	//---------Begin Added by (Appeon)Harry 08.30.2013 --------
	//Reason:BugT082001
	Long ll_status //alfee 05.07.2012
	//----------Begin Added by alfee 05.07.2012 ------------------------
	//<$Reason>Contract Document Status
	IF dw_1.rowcount() > 0 THEN ll_status = dw_1.GetItemNumber(1, 'status')
	is_doc_editable = gnv_data.of_getitem("code_lookup","custom_1", "Lookup_name = 'Contract Document Status' and lookup_code=" + String(ll_status) )
	IF IsNull (is_doc_editable) THEN is_doc_editable = "0"	
	IF is_doc_editable <> "1" THEN
		dw_1.Modify('doc_name.protect = 1')
		dw_1.Modify('notes.protect = 1')		
		dw_1.Modify("doc_name.Background.Color='553648127'" )
		dw_1.Modify("notes.Background.Color='553648127'" )		
	END IF	
	//----------End Added --------------------------------------------------
	//---------End Added ------------------------------------------------------
end if

//-----------Appeon Begin-----------------------------
//Set work flow. By alfee 04.24.2007
li_setting = of_get_app_setting("set_47","I")
If li_setting = 0 Then
	dw_1.object.wf_id_t.visible = False
	dw_1.object.wf_id.visible = False
	IF dw_1.dataobject = "d_dm_new_sell_document" THEN
		dw_1.object.notes_t.y = dw_1.object.wf_id_t.y
		dw_1.object.notes.height = String(Integer(dw_1.object.notes.height) + Integer(dw_1.object.notes.y) - Integer(dw_1.object.wf_id.y))
		dw_1.object.notes.y = dw_1.object.wf_id.y
	elseif dw_1.DataObject = "d_dm_new_buy_document" THEN
		dw_1.object.notes_t.y = dw_1.object.status_t.y
		dw_1.object.notes.height = String(Integer(dw_1.object.notes.height) + Integer(dw_1.object.notes.y) - Integer(dw_1.object.status_t.y))
		dw_1.object.notes.y = dw_1.object.status.y
		
		dw_1.object.status_t.y = dw_1.object.wf_id_t.y
		dw_1.object.status.y = dw_1.object.wf_id.y
		
		dw_1.object.status_by_t.y = dw_1.object.wf_id_t.y
		dw_1.object.status_by.y = dw_1.object.wf_id.y
		
		dw_1.object.status_date_t.y = dw_1.object.wf_id_t.y
		dw_1.object.status_date.y = dw_1.object.wf_id.y
	ELSE
		dw_1.object.wf_id_t.Visible = false
		dw_1.object.wf_id.Visible = false
		
		/*
		dw_1.object.notes_t.y = dw_1.object.status_t.y
		dw_1.object.notes.height = String(Integer(dw_1.object.notes.height) + Integer(dw_1.object.category.y) - Integer(dw_1.object.wf_id.y))
		dw_1.object.notes.y = dw_1.object.status.y
		
		dw_1.object.status_t.y = dw_1.object.category_t.y
		dw_1.object.status.y = dw_1.object.category.y
		dw_1.object.status_by_t.y = dw_1.object.status_t.y
		dw_1.object.status_by.y = dw_1.object.status.y
		dw_1.object.status_date_t.y = dw_1.object.status_t.y
		dw_1.object.status_date.y = dw_1.object.status.y
		
		dw_1.object.category_t.y = dw_1.object.wf_id_t.y
		dw_1.object.category.y = dw_1.object.wf_id.y
		dw_1.object.create_by_t.y = dw_1.object.wf_id_t.y
		dw_1.object.create_by.y = dw_1.object.wf_id.y
		dw_1.object.create_date_t.y = dw_1.object.wf_id_t.y
		dw_1.object.create_date.y = dw_1.object.wf_id.y
		*/
		
	END IF
END IF
//-----------Appeon End-------------------------------

//-----------Begin Added By Alfee 09.30.2007----------
//Add readonly control to contract in properties window
//IF IsValid(gw_contract) THEN
IF IsValid(lstr_add_doc.au_tabpg_dm_data) THEN
	IF lstr_add_doc.au_tabpg_dm_data.of_check_read_only() THEN
		dw_1.Enabled = FALSE
		cb_3.Enabled = FALSE
	END IF
END If
//-----------End Added --------------------------------

//BEGIN---Modify by Scofield on 2010-04-19
long	ll_HDHeight,ll_DTHeight,ll_SMHeight,ll_FTHeight
long	ll_OriHeight,ll_IncHeight

ll_HDHeight = long(dw_1.Describe("DataWindow.Header.Height"))
ll_DTHeight = long(dw_1.Describe("DataWindow.Detail.Height"))
ll_SMHeight = long(dw_1.Describe("DataWindow.Summary.Height"))
ll_FTHeight = long(dw_1.Describe("DataWindow.Footer.Height"))

ll_OriHeight = dw_1.Height
ll_IncHeight = ll_HDHeight + ll_DTHeight + ll_SMHeight + ll_FTHeight - ll_OriHeight + 20
//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
ll_IncHeight = ll_IncHeight + 80 //Added By Jay Chen 03-07-2014
//---------End Added ------------------------------------------------------
This.Height += ll_IncHeight
dw_1.Height += ll_IncHeight

cb_4.Y = dw_1.Y + dw_1.Height - cb_4.Height
cb_3.Y = cb_4.Y - cb_4.Height - 16
cb_Design.Y = cb_3.Y - cb_Design.Height - 72
//END---Modify by Scofield on 2010-04-19

//-----------Begin Added By Alfee 05.09.2008----------
//Set OK button for buy/other document
//IF dw_1.RowCount() < 1 THEN RETURN
IF Not ib_new or dw_1.RowCount() < 1 THEN 
	RETURN //by alfee 08.17.2007
End If
ls_doc_type = dw_1.GetItemString(1, "doc_type")
IF Upper(ls_doc_type) = "Buy" or Upper(ls_doc_type) = "Other" THEN
	ls_filename	= dw_1.GetItemString(1, "filename")
	IF NOT f_validstr(ls_filename) THEN cb_3.Enabled = FALSE
END IF
//-----------End Added--------------------------------

////Only Set Preview
If  ib_batch_new and UpperBound(il_batch_ctx_id[])  = 1 Then
	cbx_preview.visible = True		
Else
//	cbx_preview.visible = False			//Added By Mark Lee 05/07/2013 set the default is invisible
	If ib_new and  not ib_batch_new  Then 
		cbx_preview.visible = True	
	Else
		cbx_preview.visible = False	
	End IF 
End If

//Begin - Added By Mark Lee 05/08/12	add default value for version (Workaround APB bug).  for ib_new = true
If dw_1.dataobject = "d_dm_new_sell_document" Then
	 If isnull(dw_1.GetItemDecimal(1, 'revision')) Then
		dw_1.SetItem(1, "revision", 0.0 )
	End If
ElseIf dw_1.dataobject = "d_dm_new_buy_document" Then
	If isnull(dw_1.GetItemDecimal(1, 'revision')) Then
		dw_1.SetItem(1, "revision", 1.0 )
	End If
End If 
//End - Added By Mark Lee 05/08/12

//Begin - Added By Mark Lee 06/11/2013
is_operation = lstr_add_doc.operation
IF 	lstr_add_doc.operation = 'add to document' Then 
	of_RefreshDocPath(lstr_add_doc.filepathname)
	st_info.text = 'Document successfully uploaded.'
	cb_checkin.visible = False
	cb_scan.visible = False
	cb_pastefile.visible = False
	cb_preview.visible = False
	cb_weblink.visible = False
	cb_design.visible = False
	cbx_preview.visible = False
//	dw_1.SetitemStatus( 1, 0, Primary!, NewModified! )	
End If
//End - Added By Mark Lee 06/11/2013

st_info.y = dw_1.y + dw_1.height + 4 //(Appeon)Harry 04.10.2015 - Bug # 4477
end event

event close;call super::close;Destroy ids_category_filtered
Destroy inv_right
IF IsValid(inv_filesrv) THEN Destroy inv_filesrv //Alfee 09.18.2008

if IsValid(gw_Contract) then gw_Contract.of_SetCurrentScreenID(il_OriScreenID)

end event

event closequery;//Copied and Overrided by Alfee 01.03.2007

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc
String	ls_msgparms[]
Powerobject lpo_updatearray[]

//-----Begin Added by Alfee 01.03.2008---------
IF ib_new and dw_1.GetitemStatus(1, 0, Primary!) = New! THEN 
	ib_disableclosequery = TRUE
END IF
//-----End Added ------------------------------

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If
	this.BringToTop = True

	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_failsvalidation", &
					gnv_app.iapp_object.DisplayName, &
					"The information entered does not pass validation and "  + &
					"must be corrected before changes can be saved.~r~n~r~n" + &
					"Close without saving changes?", &
					exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		Return ALLOW_CLOSE
	End If
Else
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If	
	this.BringToTop = True
	
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			//--------------Begin Modified by Alfee 03.14.2008 ------------------
			cb_3.Post Event Clicked()
			/*
			// YES - Update, If the update fails, prevent the window from closing
			If This.Event pfc_save() >= 1 Then
				// Successful update, allow the window to be closed
				ib_closestatus = False
				Return ALLOW_CLOSE
			End If */
			//--------------End Modified-----------------------------------------
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE

end event

event pfc_postopen;call super::pfc_postopen;dw_1.of_setdropdowncalendar(True) //Added By Ken.Guo 2009-10-27.
end event

type cbx_preview from checkbox within w_dm_sell_document
boolean visible = false
integer x = 1883
integer y = 664
integer width = 837
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Preview in Document Manager"
end type

type st_process from statictext within w_dm_sell_document
integer x = 1938
integer y = 772
integer width = 686
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_design from commandbutton within w_dm_sell_document
integer x = 1915
integer y = 964
integer width = 727
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Design"
end type

event clicked;//if IsValid(m_pfe_cst_mdi_menu_contract_am) then
////	SetPointer(HourGlass!) //modified by gavins 20130205
////	m_pfe_cst_mdi_menu_contract_am.m_system.m_painters.m_contractdatascreenpainter.Event Clicked()
////	SetPointer(Arrow!)
//	CloseWithReturn(Parent, 'design' ) //Added By Ken.Guo 2010-07-19. Because Add/Create document will occurs error from Screen Painter.
//ElseIf Isvalid(m_pfe_cst_mdi_menu_contract) Then
//	
//	CloseWithReturn(Parent, 'design' ) //Added By Ken.Guo 2010-07-19. Because Add/Create document will occurs error from Screen Painter.
//end if
//

CloseWithReturn(Parent, 'design' )
end event

type st_info from statictext within w_dm_sell_document
boolean visible = false
integer x = 32
integer y = 1412
integer width = 1458
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_preview from commandbutton within w_dm_sell_document
boolean visible = false
integer x = 1915
integer y = 348
integer width = 727
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Pre&view"
end type

event clicked;String ls_FileExtName,ls_Null

str_add_doc 		lstr_add_doc
n_cst_dm_utils 	lnvo_dm_utils

SetNull(ls_Null)

if FileExists(istr_add_doc.FileName) then
	// Get file extend name
	ls_FileExtName = Lower(lnvo_dm_utils.of_get_fileext(istr_add_doc.FileName))
	choose case ls_FileExtName
		case "doc"
			lstr_add_doc.filename = istr_add_doc.FileName
			
			OpenWithParm(w_dm_document_preview, lstr_add_doc)
		case "html","htm"
			//ShellExecuteA(Handle(This), "open", 'IEXPLORE', istr_add_doc.FileName, ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
			ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), istr_add_doc.FileName, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		case else
			if ShellExecuteA(Handle(This), "open", istr_add_doc.FileName, ls_Null, ls_Null, 4) <= 32 then
				Run("rundll32.exe shell32.dll,OpenAs_RunDLL " + istr_add_doc.FileName)
			end if
	end choose
end if

end event

type cb_weblink from commandbutton within w_dm_sell_document
boolean visible = false
integer x = 1915
integer y = 456
integer width = 727
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get &Web Link"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_weblink()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-05-20 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_doc_id
Decimal ldec_revision
String ls_weblink

ll_doc_id = dw_1.GetItemNumber(1,'doc_id')
ldec_revision = dw_1.GetItemNumber(1,'revision')

Select web_link_name Into :ls_weblink
From ctx_am_image_weblink 
Where doc_id = :ll_doc_id and revision = :ldec_revision;

If ls_weblink = '' or isnull(ls_weblink) Then
	Messagebox('Web Link','The web link is null.')
Else
	Clipboard(ls_weblink)
	Messagebox('Web Link','On clipboard.')
End If

end event

type cb_4 from commandbutton within w_dm_sell_document
integer x = 1915
integer y = 1304
integer width = 727
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_dm_sell_document
integer x = 1915
integer y = 1196
integer width = 727
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;/******************************************************************************************************************
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
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String ls_template, ls_docname
String ls_doc_type, ls_filename, ls_basetype //03.14.2008
LONG ll_from_templete_id
Integer li_ret
Long ll_doc_id
String			ls_primary_doc			//Added By Mark Lee 10/29/2012
Long		ll_ctx_id,	ll_Find, ll_rowcount

ib_ocred = False

// Check template document
IF dw_1.rowcount() < 1 THEN RETURN

//---------Added by Alfee 05.07.2007------------------------
//verify document name
dw_1.AcceptText()
ls_docname = dw_1.GetitemString( 1, "doc_name")
IF Not inv_utils.of_verify_filename(ls_docname) THEN RETURN
//---------End Added-----------------------------------------
ls_doc_type = dw_1.GetItemString(1, "doc_type")
ls_filename	= dw_1.GetItemString(1, "filename")
ls_basetype = dw_1.GetItemString(1, "base_type")

//BEGIN---Modify by Scofield on 2009-11-09
if IsNull(ls_doc_type) or Trim(ls_doc_type) = "" then
	MessageBox("Verification", "The document type is required! ")
	dw_1.SetColumn("doc_type")
	dw_1.SetFocus()
	Return
end if
//END---Modify by Scofield on 2009-11-09

If dw_1.event pfc_validation( ) < 0 Then Return //Added By Ken.Guo 2010-06-29.

IF ib_new THEN
	//--------Begin added by Alfee 03.14.2008----------------------
	//<$Reason>for call from closequery()
	IF Upper(ls_doc_type) = "Buy" or Upper(ls_doc_type) = "Other" or &
		( Upper(ls_doc_type) = "Sell" and ls_basetype ='3' ) THEN
		IF NOT f_validstr(ls_filename) THEN 
			MessageBox("Verification", "The document is required! ")
			RETURN
		END IF
	END IF
	//--------End Added -------------------------------------------
	ls_template = dw_1.GetitemString( 1, "base_type")
	IF ls_template = '1' OR ls_template = '2' THEN
		ll_from_templete_id = dw_1.GetitemNumber( 1, "from_templete_id")
		IF Isnull(ll_from_templete_id) OR ll_from_templete_id = 0 THEN
			IF ls_template = '1' THEN
				messagebox('Missing Data', 'The Template Name is required.' )
			ELSE
				messagebox('Missing Data', 'The Document Name is required.' )
			END IF
	
			dw_1.Setcolumn( 'from_templete_id')
			RETURN
		END IF
	ELSEIF ls_template = '3' THEN
		IF NOT f_validstr(istr_add_doc.filename) THEN
			Messagebox(Parent.title, 'Please check in/scan a document first.' )
			RETURN
		END IF
	END IF

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007-02-09 By: Rodger Wu
	//$<reason> Spec changed request.
	
	Long ll_category_id, ll_cnt
	Decimal{1} ldc_revision
	
	IF ls_template = '1' THEN

		Select category
		Into :ll_category_id
		From ctx_acp_template
		Where ctx_acp_template_id = :ll_from_templete_id;
		
		SELECT count( ctx_acp_contract_management_right.role_id )
		INTO :ll_cnt
		FROM ctx_acp_contract_management_right,   
			security_user_roles  
		WHERE ( ctx_acp_contract_management_right.role_id = security_user_roles.role_id ) and  
			( ( security_user_roles.user_id = :gs_user_id ) AND  
			( ctx_acp_contract_management_right.category = :ll_category_id ) AND  
			( ctx_acp_contract_management_right.types = 3 ) AND  
			( ctx_acp_contract_management_right.rights in ('32', '33') ) );    
		
		IF ll_cnt > 0 THEN
			ldc_revision = dw_1.GetItemNumber( 1, "revision" )
			IF ldc_revision < 1 THEN
				dw_1.SetItem( 1, "Revision", 1.0)
				dw_1.Setitem( 1, "revision_control",'1' )
			END IF
		END IF
		
	END IF
	//---------------------------- APPEON END ----------------------------	
END IF

//Added By Mark Lee 06/13/2013
IF 	not isnull(is_operation) and is_operation = 'add to document' Then 
	dw_1.SetitemStatus( 1, 0, Primary!, NewModified! )	
End If

//Begin - Modified By Ken.Guo 2010-06-29
//li_ret = parent.event pfc_save( )
//istr_batch_doc = istr_batch_doc_empty
istr_batch_doc_invalid = istr_batch_doc_empty
Long i,k
boolean ib_exists

//---------Begin Modified by (Appeon)Harry 04.17.2014 for V142 ISG-CLX--------
/*
//Begin - Added By Mark Lee 10/29/2012
ls_primary_doc = dw_1.getitemString( 1,"primary_doc")
ll_ctx_id = dw_1.getitemNumber( 1,"ctx_id")
ll_doc_id = dw_1.GetItemNumber(1, "doc_id")
If ib_new and ib_batch_new Then 
	If not isnull(ls_primary_doc) and trim(ls_primary_doc) = '1' Then
		Update ctx_am_document
		set  primary_doc = '0'
		From ctx_am_document
		Where ctx_id = :ll_ctx_id ;

	End If	
Else
	IF isnull(dw_1.getitemString( 1,"primary_doc",Primary!	,false)) Or (dw_1.getitemString( 1,"primary_doc",Primary!	,false) <> dw_1.getitemString( 1,"primary_doc",Primary!,true) ) Then
		If not isnull(ls_primary_doc) and trim(ls_primary_doc) = '1' Then
			Update ctx_am_document
			set  primary_doc = '0'
			From ctx_am_document
			Where ctx_id = :ll_ctx_id 
			and doc_id <> :ll_doc_id ;
		End If
	End If
End If
//End - Added By Mark Lee 10/29/2012
*/
String ls_primary_doc_old, ls_batch_ctx_id, ls_sql,ls_temp
ls_primary_doc = dw_1.getitemString( 1,"primary_doc")
ll_ctx_id = dw_1.getitemNumber( 1,"ctx_id")
ll_doc_id = dw_1.GetItemNumber(1, "doc_id")
If isnull(ls_primary_doc) or trim (ls_primary_doc) = "" Then ls_primary_doc = "0"
If ib_new or ib_batch_new Then 
	If trim(ls_primary_doc) = '1' Then
		If ib_batch_new Then
			gnv_string.of_arraytostring( il_batch_ctx_id, ",", ls_batch_ctx_id)
			ls_sql = " Update ctx_am_document set  primary_doc = '0' From ctx_am_document Where ctx_id in (" +ls_batch_ctx_id + ") ; "                                          
			gnv_string.of_exec_sql(ls_sql,ls_temp)
		Else
			Update ctx_am_document
			set  primary_doc = '0'
			From ctx_am_document
			Where ctx_id = :ll_ctx_id ;
		End If
	End If
Else
	ls_primary_doc_old = dw_1.getitemString( 1, "primary_doc", Primary!, true)
	If isnull(ls_primary_doc_old) or trim (ls_primary_doc_old) = "" Then ls_primary_doc_old = "0"
	If ls_primary_doc <> ls_primary_doc_old then
		If trim(ls_primary_doc) = '1' Then
			Update ctx_am_document
			set  primary_doc = '0'
			From ctx_am_document
			Where ctx_id = :ll_ctx_id 
			and doc_id <> :ll_doc_id ;
		End If
	End If
End If
//---------End Modfiied ------------------------------------------------------

st_info.visible = True
If ib_new and ib_batch_new Then 
	gnv_workflow_prompt.of_set_prompt_status(False)
	For i = 1 To UpperBound(il_batch_ctx_id[])
		If UpperBound(il_batch_ctx_id[]) <> 1 Then
			st_info.text = 'Batch Adding ' + String(i) + ' of ' + String(UpperBound(il_batch_ctx_id[]))
		End If
		
		//If exists then ignore. 
		ib_exists = False
		For k = 1 to UpperBound(istr_batch_doc.al_ctx_id[])
			If il_batch_ctx_id[i] = istr_batch_doc.al_ctx_id[k] Then 
				ib_exists = True
				Continue
			End If
		Next
		If ib_exists Then Continue
		
		dw_1.SetItemStatus(1,0,Primary!,NewModified!)
		dw_1.SetItem(1,'ctx_id',il_batch_ctx_id[i] )
		li_ret = parent.event pfc_save( )
		If li_ret > 0 Then
			istr_batch_doc.al_ctx_id[UpperBound(istr_batch_doc.al_ctx_id) + 1] = il_batch_ctx_id[i]
			istr_batch_doc.al_doc_id[UpperBound(istr_batch_doc.al_ctx_id)] = dw_1.GetItemNumber(1,'doc_id')
			istr_batch_doc.adec_revision[UpperBound(istr_batch_doc.al_ctx_id)] = dw_1.GetItemDecimal(1,'revision')
		Else
			istr_batch_doc_invalid.al_ctx_id[UpperBound(istr_batch_doc_invalid.al_ctx_id) + 1] = il_batch_ctx_id[i]
			istr_batch_doc_invalid.al_doc_id[UpperBound(istr_batch_doc_invalid.al_ctx_id)] = dw_1.GetItemNumber(1,'doc_id')
			istr_batch_doc_invalid.adec_revision[UpperBound(istr_batch_doc_invalid.al_ctx_id)] = dw_1.GetItemDecimal(1,'revision')
			//filename, errttext,notes
			gnv_workflow_prompt.of_set_prompt_status(True)
			//Need Show Error Text?
			Return -1
		End If
	Next
	gnv_workflow_prompt.of_set_prompt_status(True)
Else
	li_ret = parent.event pfc_save( )
End If
//End - Modified By Ken.Guo 2010-06-29

IF li_ret < 0 THEN RETURN

//COMMIT; commented by Alfee 09.17.2007

//Added By Ken 08/01/2011. 
If cbx_preview.visible  and cbx_preview.enabled and cbx_preview.checked Then
	If isvalid(gw_contract) Then
		gw_contract.tab_contract_details.tabpage_images.ib_retrieved = False		//Added By Mark Lee 05/07/2013
		gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_Add_Doc_ID = dw_1.GetItemNumber(1,'doc_id')
//		gw_contract.tab_contract_details.Selecttab(9) //Document Manager
//		gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.Post of_open_document( dw_1.GetItemNumber(1,'doc_id'))
	End If
Else
//Begin - Added By Mark Lee 05/07/2013
	If isvalid(gw_contract) Then
		If gw_contract.tab_contract_details.Selectedtab = 9 Then 
			gw_contract.tab_contract_details.tabpage_images.event ue_retrieve( )
			ll_doc_id = dw_1.GetItemNumber(1, "doc_id")
			ll_rowcount = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.rowcount()
			ll_Find = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.find('doc_id = ' + String(ll_doc_id),1, ll_rowcount)
			If ll_Find > 0 Then
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.SetRow(ll_Find)
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.ScrolltoRow(ll_Find)
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.SelectRow(0,False)
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.SelectRow(ll_Find,True)
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Post	event rowfocuschanged( ll_Find)	
			End IF 
		Else
			gw_contract.tab_contract_details.tabpage_images.ib_retrieved = False
		End If
	End If
	//End - Added By Mark Lee 05/07/2013
End If

//Begin - Added By Mark Lee 05/07/2013
If cbx_preview.visible = True Then 	//Added By Mark Lee 06/13/2013
	If cbx_preview.checked Then
		gnv_user_option.of_set_option_value(gs_user_id,"Contract_Document_Manager_Tab_Preview_in_Document_Manager_Checked", "1")
	Else
		gnv_user_option.of_set_option_value(gs_user_id,"Contract_Document_Manager_Tab_Preview_in_Document_Manager_Checked", "0")
	End If 
	gnv_user_option.of_save( )
End IF 
//End - Added By Mark Lee 05/07/2013

IF li_ret = 0 THEN
	CloseWithReturn(Parent, 0)
ELSEIF li_ret > 0 THEN
	IF ib_new THEN
		If ib_batch_new Then
			istr_ctx_email.ctx_id_list[] = istr_batch_doc.al_ctx_id[]
			istr_ctx_email.doc_id_list[] = istr_batch_doc.al_doc_id[]
			istr_ctx_email.revision_list[] = istr_batch_doc.adec_revision[]
			//If ls_filename <> '' Then
			If dw_1.dataobject = 'd_dm_new_buy_document' Then
				istr_ctx_email.as_batch_file[1] = ls_filename //For Buy
			Else
				istr_ctx_email.as_batch_file[1] = ls_docname + '.doc' //For Sell
			End If
			CloseWithReturn(Parent, istr_ctx_email)		
		Else
			ll_doc_id = dw_1.GetItemNumber(1, "doc_id")
			CloseWithReturn(Parent, ll_doc_id)				
		End If
	ELSE
		CloseWithReturn(Parent, 1)
	END IF
END IF
end event

type cb_checkin from commandbutton within w_dm_sell_document
boolean visible = false
integer x = 1915
integer y = 24
integer width = 727
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &Existing Document"
end type

event clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Check in exists document from hard disk/email.
**==================================================================================================================
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String 	ls_PathName,ls_FileName
long		ll_Rtn

dw_1.Accepttext( )

//BEGIN---Modify by Scofield on 2009-10-16

gf_load_dir_path()
//Added By Mark Lee 04/23/2013
//ll_Rtn = GetFileOpenName("Select File",&
//         + ls_PathName, ls_FileName, "DOC", &
//         + "Doc Files (*DOCX;*.DOC),*.DOCX;*.DOC,"&	
//         + "Xls Files (*XLSX;*.XLS),*.XLSX;*.XLS,"&			
//         + "Tif Files (*.TIF),*.TIF,"&
//         + "Pdf Files (*.PDF),*.PDF,"&
//         + "All Files (*.*), *.*" )
ll_Rtn = GetFileOpenName("Select File",&
         + ls_PathName, ls_FileName, "",&
		+ "All Files (*.*), *.*,"  &
         + "Doc Files (*DOCX;*.DOC),*.DOCX;*.DOC,"&	
         + "Xls Files (*XLSX;*.XLS),*.XLSX;*.XLS,"&			
         + "Tif Files (*.TIF),*.TIF,"&
         + "Pdf Files (*.PDF),*.PDF"         )
			
gf_save_dir_path(ls_PathName)

if ll_Rtn <> 1 then Return

of_RefreshDocPath(ls_PathName)
st_info.text = 'Document successfully uploaded.'
//END---Modify by Scofield on 2009-10-16

end event

type dw_1 from u_dw_contract within w_dm_sell_document
integer x = 32
integer y = 28
integer width = 1824
integer height = 1376
integer taborder = 10
string dataobject = "d_dm_new_sell_document"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;/******************************************************************************************************************
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
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
Long ll_from_templete_id, ll_cnt, ll_category, ll_wf_id, ll_export_id, ll_NULL
String ls_template, ls_dddw_name, ls_document_name, ls_description, ls_filename, ls_filter
DatawindowChild ldw_child, ldwc_category

SETNULL(ll_NULL)
IF rowcount() < 1 THEN RETURN

CHOOSE CASE Lower(dwo.name)
	CASE "base_type"
		ls_template = String(data)
		CHOOSE CASE ls_template
			CASE '1', '2'			//templete or Document
				//---------Begin Added by Alfee 07.26.2007 --------------------------
				//Filter the category dddw according to the user rights	
				This.Getchild( "category", ldwc_category)
				of_filter_category(ldwc_category, ls_template)
				//Set the category field
				ll_category = dw_1.GetItemNumber(row, 'category')
				IF ll_category > 0 AND Not ldwc_category.Find('lookup_code = '+string(ll_category),1,ldwc_category.rowcount()) > 0 THEN 
					dw_1.SetItem(row,'category', ll_NULL)
					SetNull(ll_category)
				END IF

				//Added by Ken.guo 2011-08-29.				
				This.Getchild( "from_templete_id", ldw_child)		
				IF IsNull(ll_category) THEN
					dw_1.SetItem(row, 'from_templete_id', ll_NULL)
					ls_filter = '1=2'
				ELSEIf gnv_data.of_getitem( 'icred_settings', 'filter_template', False) = '1' Then 	
					ls_filter = "type = " + String(ls_template) + " and category = " + string(this.GetItemNumber(1,"category"))
				Else
					ls_filter =  "type = " + String(ls_template)
				END IF
				ldw_child.Setfilter(ls_filter)
				ldw_child.filter( )
				

				cb_CheckIn.Visible = FALSE
				cb_Scan.Visible = FALSE
				cb_3.Enabled = TRUE	//Added by Alfee 05.09.2008			
				This.Setitem( 1, "from_templete_id", ll_null)
				This.SetItem( 1, "doc_name", "") //Alfee 08.23.2007
			CASE '3'		//Existing		
				//------Begin Added by Alfee 07.26.2007---------
				//<$Reason>Restore category dddw for base tpye of '3'
				/*
				This.Getchild( "category", ldwc_category)
				ldwc_category.SetFilter('1=1')
				ldwc_category.Filter( )		
				*/
				//Added By Ken.Guo 2009-12-04.
				This.Getchild( "category", ldwc_category)
				of_filter_category(ldwc_category, ls_template)
				//Set the category field
				ll_category = dw_1.GetItemNumber(row, 'category')
				IF ll_category > 0 AND Not ldwc_category.Find('lookup_code = '+string(ll_category),1,ldwc_category.rowcount()) > 0 THEN 
					dw_1.SetItem(row,'category', ll_NULL)
					SetNull(ll_category)
				END IF				
				//-------End Added ------------------------------
				cb_CheckIn.Visible = TRUE
				cb_Scan.Visible = TRUE				
				This.Setitem( 1, "from_templete_id", ll_null)
				This.Setitem( 1, "export_id", ll_null)
				This.SetItem( 1, "doc_name", "") //Alfee 08.23.2007
				//-----------Begin Added By Alfee 05.09.2008----------
				//Set OK button for document
				ls_filename = This.GetItemString(1, "filename")
				IF NOT f_validstr(ls_filename) THEN 
					cb_3.Enabled = FALSE
				ELSE
					cb_3.Enabled = TRUE
				END IF
				//-----------End Added--------------------------------		
		END CHOOSE

		IF String(data) = '3' THEN
			This.SetItem( 1, "Revision", 1.0)
		ELSE
			This.SetItem( 1, "Revision", 0.0)
		END IF
	CASE "from_templete_id"
		ls_template = This.GetitemString( 1, "base_type")
		ll_from_templete_id = Long(data)

		CHOOSE CASE ls_template
			CASE '1'		//templete
				Select category, template_name, wf_id, export_id, description
				Into :ll_category, :ls_document_name, :ll_wf_id, :ll_export_id, :ls_description
				From ctx_acp_template
				Where ctx_acp_template_id = :ll_from_templete_id;
			CASE '2'		//Document
				Select category, document_name, wf_id, description
				Into :ll_category, :ls_document_name, :ll_wf_id, :ls_description
				From ctx_acp_document
				Where ctx_acp_document_id = :ll_from_templete_id;
			CASE ELSE
				RETURN
		END CHOOSE
		
		//IF ll_category > 0 THEN This.Setitem( 1, "category", ll_category) //commented by alfee 07.26.2007
		IF f_validstr(ls_document_name) THEN This.Setitem( 1, "doc_name", ls_document_name)
		IF ll_wf_id > 0 THEN This.Setitem( 1, "wf_id", ll_wf_id)
		IF ll_export_id > 0 THEN This.Setitem( 1, "export_id", ll_export_id)
		IF f_validstr(ls_description) THEN This.Setitem( 1, "notes", ls_description)
	CASE "status"
		This.Setitem( 1, "status_by", gs_user_id)
		This.SetItem( 1, "status_date", DateTime(Today()))
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 02.14.2007 By: Jervis
	//$<reason> 
	case 'category'
		If Not ib_new Then Return //Added By Ken.Guo 2009-10-12.
		ls_template = this.GetItemString(row,"base_type")

		If gnv_data.of_getitem( 'icred_settings', 'filter_template', False) = '1' Then 
			This.Getchild( "from_templete_id", ldw_child)
			ldw_child.Setfilter( "type = " + String(ls_template) + " and category = " + data)
			ldw_child.filter( )	
			This.Setitem( 1, "from_templete_id", ll_null)
		End If

	//---------------------------- APPEON END ----------------------------
 Case "doc_from_name"
	if IsNumber(Data) then
		This.Setitem(1, "doc_from_type", "1" )		// Contract contacts
	else
		This.Setitem(1, "doc_from_type", "2" )		// System user
	end if
END CHOOSE

end event

event pfc_preupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.11.2007 By: Davis
//$<reason> Get max id for new document.

Long ll_doc_id
Decimal ldc_revision

IF rowcount( ) > 0 THEN
	// Set doc_id
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.27.2007 By: Machongmin
	//$<reason> Fix a defect.	
	/*
	IF NOT f_validstr(string( dw_1.object.doc_id[1] )) THEN
		SELECT max(doc_id)
		INTO :ll_doc_id
		FROM Ctx_am_document;
	
		IF Isnull(ll_doc_id) THEN
			ll_doc_id = 1
		ELSE
			ll_doc_id++
		END IF
	
		This.setitem( 1, "doc_id", ll_doc_id)
	END IF
	*/
	IF NOT f_validstr(string( dw_1.object.doc_id[1] )) or ib_batch_new THEN
		ll_doc_id = gnv_app.of_get_id("doc_id")
		This.setitem( 1, "doc_id", ll_doc_id)
	END IF
	//---------------------------- APPEON END ----------------------------
	
	// Set revision number
	ldc_revision = Double( dw_1.object.revision[1] )
	IF ldc_revision > 0 THEN
		This.setitem( 1, "revision_control", "1")
	END IF
END IF

Return SUCCESS

//---------------------------- APPEON END ----------------------------

end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.11.2007 By: Davis
//$<reason> Generate image file.
Decimal ldc_revision
Integer li_rtn
Long ll_doc_id
Long ll_from_template_id
Long ll_ctx_id
Long ll_wf_Id
Long i
String ls_base_type
String ls_filename_extend
String ls_filename, ls_filename_new
String ls_new_status
String ls_docname, ls_sql, ls_criteria, ls_clauseid[]
DateTime ldt_modify
DateTime ldt_modify_new
Boolean lb_rules_valid = FALSE
String ls_filename_tif //Added By Ken.Guo 2009-05-31.
String ls_shortname //Added By Ken.Guo 2010-06-30.

DataStore lds_clause_rules_result
n_cst_dm_utils lnv_dm_utils
str_add_audit lstr_add_audit
n_cst_word_utility lnv_word_utils
n_cst_ovole_utils lnv_word

lnv_word_utils = Create n_cst_word_utility
lds_clause_rules_result = Create DataStore
lnv_word = Create n_cst_ovole_utils 
lds_clause_rules_result.DataObject = 'd_dm_template_clause_rules_result'


IF NOT rowcount() > 0 THEN RETURN 0

//<add> 06/19/2007 by: Andy
n_cst_workflow_triggers lnv_workflow
lnv_workflow = create n_cst_workflow_triggers
//end of add

IF ib_new THEN
	ll_ctx_id = dw_1.object.ctx_id[1]
	ll_doc_id = dw_1.object.doc_id[1]
	ll_wf_Id = dw_1.object.wf_id[1]
	ldc_revision = dw_1.object.revision[1]
	ll_from_template_id = dw_1.object.from_templete_id[1]
	ls_base_type = dw_1.object.base_type[1]
	ls_filename_extend = "doc"
	ls_shortname = dw_1.object.doc_name[1] //Added By Ken.Guo 2010-06-30.
	///////////////////////////////////////////////////////////////////////
	//// Insert document record to the database
	///////////////////////////////////////////////////////////////////////

	CHOOSE CASE ls_base_type
		CASE "1"		//template
			//---------Begin Added by alfee 11.12.2007------------------------
			//<$Reason>For dynamic adding clauses based on defined rules in template
			//Get whether the dynamic adding clause rules is valid
			IF gnv_data.of_findrow('template_clause_rules', "ctx_acp_template_id = " + String(ll_from_template_id)) > 0 THEN
				//Get clause rules' result into datastore				
				lnv_dm_utils.of_get_clause_rule_reuslts(il_ctx_id, ll_from_template_id, lds_clause_rules_result)
				FOR i = 1 to lds_clause_rules_result.RowCount()								
					IF lds_clause_rules_result.GetItemNumber(i,"rules_result") = 0 THEN 
						lb_rules_valid = TRUE
						ls_clauseid[UpperBound(ls_clauseid) + 1] = String(lds_clause_rules_result.GetItemNumber(i, "ctx_acp_clause_id"))
					END IF
				NEXT
			END IF

			IF NOT lb_rules_valid THEN	
				//the dynamic adding clause rules is invalid	
			//---------End Added ---------------------------------------------
		//		gnv_appeondb.of_startqueue( )
				
				Insert Ctx_am_doc_image(Doc_id, Revision, image_file, doc_ext, modify_date,doc_ext_full)
				Select :ll_doc_id, :ldc_revision, image_file, 'doc', getdate(),'doc'
				From ctx_acp_template
				Where ctx_acp_template_id = :ll_from_template_id;

				//Added By Ken.Guo 2009-12-22.
				IF SQLCA.SQLCODE <> 0 THEN	
					Delete from ctx_am_doc_image Where doc_id = :ll_doc_id;
					Delete from ctx_am_document where doc_id = :ll_doc_id;
					MESSAGEBOX("Add Document", sqlca.sqlerrtext)
					if IsValid(lnv_workflow) then Destroy lnv_workflow
					IF IsValid(lds_clause_rules_result) THEN DESTROY lds_clause_rules_result 
					IF IsValid(lnv_word_utils) THEN Destroy lnv_word_utils					
					Return failure
				End If

				Update Ctx_am_document
				Set doc_ext = 'doc'
				Where doc_id = :ll_doc_id;

				Insert Ctx_am_document_clause(Doc_id, Revision, ctx_acp_clause_id, orders )
				Select :ll_doc_id, :ldc_revision, ctx_acp_clause_id, orders
				From ctx_acp_template_clause
				Where ctx_acp_template_id = :ll_from_template_id;

		//		gnv_appeondb.of_commitqueue( )	
			//---------Begin Added by alfee 11.12.2007------------------------			
			ELSE 	
				//the dynamic adding clause rules is valid
				//Get modify date and sql statement for clause map update
				ldt_modify_new = DateTime(Today(), Now())					

				lnv_string.of_arraytostring(ls_clauseid, ",", ls_criteria) 				
				ls_sql = "Insert ctx_am_document_clause(doc_id, revision, ctx_acp_clause_id, orders ) " + &
							" Select " + String(ll_doc_id) + ", " + String(ldc_revision) + ", ctx_acp_clause_id, orders" + &
							"  From ctx_acp_template_clause Where ctx_acp_template_id = " + String(ll_from_template_id)
				IF Len(ls_criteria) > 0 THEN ls_sql = ls_sql + " And ctx_acp_clause_id not in (" + ls_criteria + ")"	
				ls_sql += "; "

				//General update
				//gnv_appeondb.of_startqueue( )
				
				Insert Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date,doc_ext_full) 
					Values( :ll_doc_id, :ldc_revision, 'doc', :ldt_modify_new,'doc');

				//Added By Ken.Guo 2009-12-22.
				IF SQLCA.SQLCODE <> 0 THEN	
					Delete from ctx_am_doc_image Where doc_id = :ll_doc_id;
					Delete from ctx_am_document where doc_id = :ll_doc_id;
					MESSAGEBOX("Add Document", sqlca.sqlerrtext)
					if IsValid(lnv_workflow) then Destroy lnv_workflow
					IF IsValid(lds_clause_rules_result) THEN DESTROY lds_clause_rules_result 
					IF IsValid(lnv_word_utils) THEN Destroy lnv_word_utils					
					Return failure
				End If
				
				Update Ctx_am_document Set doc_ext = 'doc' Where doc_id = :ll_doc_id;
				
				EXECUTE IMMEDIATE :ls_sql; //update clause map

				//Get modify date for the template
				Select modify_date Into :ldt_modify From ctx_acp_template Where ctx_acp_template_id = :ll_from_template_id;
				
				//gnv_appeondb.of_commitqueue( )
				
				IF SQLCA.SQLCODE <> 0 THEN	
					MessageBox("Add Document", "Add document failed due to: " + sqlca.sqlerrtext)
					RETURN FAILURE
				END IF
				
				//Get the template file
				lnv_word_utils.of_get_template_file( ll_from_template_id, ldt_modify)
				
				//Clear invalid clauses based on rules, and generate the new document
				ls_filename = gs_dir_path + gs_DefDirName + "\Agreement\" + "template_" + string(ll_from_template_id) + ".doc"
				ls_docname = lnv_dm_utils.of_generate_tempname(ll_doc_id, ldc_revision, 'doc')			
				lnv_dm_utils.of_gen_document_on_rules(ls_filename, ls_docname, lds_clause_rules_result)
				
				//Upload document to DB, and update registry value. 
				lnv_dm_utils.of_update_document(ll_doc_id, ldc_revision, ls_docname, ldt_modify_new)
				
			END IF		
			//---------End Added ---------------------------------------------

			IF SQLCA.SQLCODE <> 0 THEN	
				Delete from ctx_am_doc_image Where doc_id = :ll_doc_id;
				Delete from ctx_am_document where doc_id = :ll_doc_id;
				MESSAGEBOX("Add Document", sqlca.sqlerrtext)
				if IsValid(lnv_workflow) then Destroy lnv_workflow
				IF IsValid(lds_clause_rules_result) THEN DESTROY lds_clause_rules_result 
				IF IsValid(lnv_word_utils) THEN Destroy lnv_word_utils	
				IF IsValid(lnv_word) THEN Destroy lnv_word	
				Return failure
			End If
			
			//Merge data from DB and upload to DB //Added By Ken.Guo 2010-06-30.
			If ib_batch_new Then
				If lnv_word.of_merge_to_db( ll_ctx_id, ll_doc_id, ldc_revision, ls_shortname, ls_filename_extend) < 0 Then
					if IsValid(lnv_workflow) then Destroy lnv_workflow
					IF IsValid(lds_clause_rules_result) THEN DESTROY lds_clause_rules_result 
					IF IsValid(lnv_word_utils) THEN Destroy lnv_word_utils	
					IF IsValid(lnv_word) THEN Destroy lnv_word						
					Return failure
				End If
			End If

		CASE "2"		//document
			gnv_appeondb.of_startqueue( )
			
			//Insert Ctx_am_doc_image(Doc_id, Revision, image_file, doc_ext, modify_date)
			//Select :ll_doc_id, :ldc_revision, image_file, document_type, getdate() //Alfee 09.19.2008
			Insert Ctx_am_doc_image(Doc_id, Revision, image_file, doc_ext, modify_date, pdftext,doc_ext_full)
			Select :ll_doc_id, :ldc_revision, image_file, document_type, getdate(), image_text,document_type
			  From ctx_acp_document
  			 Where ctx_acp_document_id = :ll_from_template_id;
			
			//Added By Mark Lee 05/07/2013
			If AppeonGetClientType() = 'PB' then	
				IF SQLCA.SQLCODE <> 0 THEN
					Delete from ctx_am_doc_image Where doc_id = :ll_doc_id;
					Delete from ctx_am_document where doc_id = :ll_doc_id;
					MESSAGEBOX("Add Document", sqlca.sqlerrtext)
					if IsValid(lnv_workflow) then Destroy lnv_workflow
					IF IsValid(lds_clause_rules_result) THEN DESTROY lds_clause_rules_result 
					IF IsValid(lnv_word_utils) THEN Destroy lnv_word_utils				
					Return Failure
				END IF
			End IF 
			
			Update Ctx_am_document
			Set Ctx_am_document.doc_ext = document_type
			From ctx_acp_document
			Where Ctx_am_document.doc_id = :ll_doc_id
				And ctx_acp_document_id = :ll_from_template_id;

			gnv_appeondb.of_commitqueue( )

			IF SQLCA.SQLCODE = 0 THEN
				//COMMIT; Commented by Alfee 09.17.2007
			ELSE
				Delete from ctx_am_doc_image Where doc_id = :ll_doc_id;
				Delete from ctx_am_document where doc_id = :ll_doc_id;
				MESSAGEBOX("Add Document", sqlca.sqlerrtext)
				if IsValid(lnv_workflow) then Destroy lnv_workflow
				IF IsValid(lds_clause_rules_result) THEN DESTROY lds_clause_rules_result 
				IF IsValid(lnv_word_utils) THEN Destroy lnv_word_utils				
				Return Failure
			END IF
		CASE "3"		//existing document
			ls_filename = istr_add_doc.filename
			
			//Get The OCR Result //Added By Ken.Guo 2010-07-08. for batch add document to contracts.
			If Not ib_ocred Then
				is_ocr_result = lnv_dm_utils.of_get_ocr_result(ls_filename)
				ib_ocred = True
			End If
			
			// Get file extend name
			ls_filename_extend = lnv_dm_utils.of_get_fileext( ls_filename )
			
			//--------Begin Commented by Alfee 09.14.2007-----------------------------
			//<$Reason>for performance tuning, the insert statement will be run in of_upload_file()
			/*gnv_appeondb.of_startqueue( )
			
			Insert Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date)
			Values( :ll_doc_id, :ldc_revision, :ls_filename_extend, getdate() );
			
			Update Ctx_am_document
			Set doc_ext = :ls_filename_extend
			Where doc_id = :ll_doc_id;
			 
			gnv_appeondb.of_commitqueue( )*/
			//--------End Commented --------------------------------------------------
			

			//----------Begin Modified by Alfee 09.14.2007-------------------------
			//<$Reason>For performance tuning
			IF lnv_dm_utils.of_upload_file( ll_doc_id, ldc_revision, ls_filename,is_ocr_result) < 0 THEN 
				Delete from ctx_am_doc_image Where doc_id = :ll_doc_id;
				Delete from ctx_am_document where doc_id = :ll_doc_id;	
				This.SetItemStatus(1,0, Primary!,NewModified!) //Added By Ken.Guo 08/08/2013
				if IsValid(lnv_workflow) then Destroy lnv_workflow
				IF IsValid(lds_clause_rules_result) THEN DESTROY lds_clause_rules_result 
				IF IsValid(lnv_word_utils) THEN Destroy lnv_word_utils				
				RETURN -1		
			End If
			
//			//Added By Ken.Guo 2009-05-31. update the PDF file's OCR by original tif file.
//			If is_scaned_file = ls_filename Then
//				ls_filename_tif = Mid(ls_filename, 1, Len(ls_filename) - 4) + ".tif"
//				If FileExists(ls_filename_tif) Then
//					lnv_dm_utils.of_update_tif_ocr(ll_doc_id,ldc_revision,ls_filename_tif)
//				End If
//			End If
			
			gnv_appeondb.of_startqueue( )	
			Select modify_date Into :ldt_modify From Ctx_am_doc_image Where doc_id = :ll_doc_id and revision = :ldc_revision ;
			Update Ctx_am_document Set doc_ext = :ls_filename_extend	Where doc_id = :ll_doc_id;			 
			gnv_appeondb.of_commitqueue( )
				
			//Generate local file & Update registry date
			IF Not IsNull(ldt_modify) THEN
				ls_filename_new = lnv_dm_utils.of_generate_tempname(ll_doc_id, ldc_revision, ls_filename_extend)
				//IF FileExists(ls_filename) THEN li_rtn = FileCopy(ls_filename, ls_filename_new, TRUE) 
				//IF FileExists(ls_filename) THEN li_rtn = inv_filesrv.of_FileCopy(ls_filename, ls_filename_new) //for readonly case - Alfee 09.18.2008
				IF FileExists(ls_filename) THEN li_rtn = FileCopy(ls_filename, ls_filename_new,true) //APB Blob Bug - jervis 03.23.2010
				IF li_rtn > 0 THEN lnv_dm_utils.of_updateregistry(ll_doc_id, ldc_revision, ls_filename_extend, ldt_modify)
			END IF
			
			/*lnv_dm_utils.of_upload_file( ll_doc_id, ldc_revision, ls_filename)
			
			IF SQLCA.SQLCODE = 0 THEN
				COMMIT;
			ELSE
				MESSAGEBOX("Add Document", sqlca.sqlerrtext)
			END IF*/
			//----------End Modified ---------------------------------------------
	END CHOOSE
	

	///////////////////////////////////////////////////////////////////////
	//// Trigger off work flow
	///////////////////////////////////////////////////////////////////////
	If gb_workflow AND ll_ctx_id > 0 AND ll_wf_id > 0 AND ll_doc_id > 0 Then
		//n_cst_workflow_triggers lnv_workflow //comment by: Andy 06/19/2007
		str_action_item lstr_action[]
		//lnv_workflow = create n_cst_workflow_triggers //comment by: Andy 06/19/2007
		
		lstr_action[1].ctx_id = ll_ctx_id
		lstr_action[1].doc_id = ll_doc_id
		lstr_action[1].wf_id = ll_wf_id
		
		lnv_workflow.of_workflow_triggers( lstr_action[] )
		//Destroy lnv_workflow //comment by: Andy 06/19/2007
	End If


	///////////////////////////////////////////////////////////////////////
	//// Trigger off audit trail
	///////////////////////////////////////////////////////////////////////
	lstr_add_audit.doc_id = ll_doc_id
	lstr_add_audit.revision = ldc_revision
	lstr_add_audit.filename = dw_1.object.filename[1]
	lstr_add_audit.doc_from_name = dw_1.object.doc_from_name[1]
	lstr_add_audit.doc_from_type = dw_1.object.doc_from_type[1]
	lstr_add_audit.notes = istr_add_doc.notes
	lstr_add_audit.doc_ext = ls_filename_extend
	
	CHOOSE CASE ls_base_type
		CASE "1"		//template
			lstr_add_audit.action = "New - Template"
		CASE "2"		//document
			lstr_add_audit.action = "New - Document"
		CASE "3"		//existing document
			lstr_add_audit.action = "New - Existing"
	END CHOOSE

	lnv_dm_utils.of_add_audit_trail( lstr_add_audit )
ELSE
	ls_new_status = dw_1.Describe("Evaluate( 'lookupdisplay(status)', 1 )")
	IF is_old_status <> ls_new_status THEN
		///////////////////////////////////////////////////////////////////////
		//// Trigger off audit trail
		///////////////////////////////////////////////////////////////////////
		lstr_add_audit.doc_id = dw_1.GetItemNumber( 1, "doc_id")
		lstr_add_audit.revision = dw_1.GetItemDecimal( 1, "revision")
		lstr_add_audit.doc_ext = dw_1.GetItemString( 1, "doc_ext")
		lstr_add_audit.action = "Status Change"
		lstr_add_audit.notes = "Changed Status from " + is_old_status + " to " + ls_new_status 
		lnv_dm_utils.of_add_audit_trail( lstr_add_audit )
	END IF
END IF

//$<add> 06/19/2007 By: Andy
//$<reason> Trigger work flow by Contract Logix folder data value comparision
long ll_screen_id[]
u_dw ldw
If gb_workflow Then 
	ll_ctx_id = dw_1.object.ctx_id[1]
	ll_doc_id = dw_1.object.doc_id[1]
	ll_screen_id[1] = -100

	lnv_workflow.of_data_value_comparision(gi_contract_view_id, ll_screen_id, ll_ctx_id, ll_doc_id, '04', 'I')
	//refresh UI
	if IsValid(w_contract) then
		ldw = w_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail
		ldw.event pfc_retrieve( )
	end if
End If


if IsValid(lnv_workflow) then Destroy lnv_workflow
IF IsValid(lds_clause_rules_result) THEN DESTROY lds_clause_rules_result 
IF IsValid(lnv_word_utils) THEN Destroy lnv_word_utils
If Isvalid(lnv_word) Then Destroy lnv_word
//--------End Added

RETURN SUCCESS
//---------------------------- APPEON END ----------------------------

end event

event ue_populatedddws;long		ll_Column_Count,ll_i,ll_null
string 	ls_dddw_name
string 	ls_colname
String 	ls_coltag
Integer 	li_value
Integer 	ll_lookup_code
string 	ls_lable

DataWindowChild dwchild
n_ds lnds_user

if ib_retrieve_drop_downs then return

ll_Column_Count = LONG(This.Describe("DataWindow.Column.Count"))
IF ll_Column_Count = 0 THEN RETURN

FOR ll_i = 1 TO ll_Column_Count
	IF Describe("#" +STRING(ll_i) + ".Edit.Style") = 'dddw' then
		ls_colname = Describe("#" +STRING(ll_i) + ".Name")
		ls_dddw_name = lower(Describe("#" +STRING(ll_i) + ".DDDW.Name"))

		IF ls_dddw_name = "d_dddw_code_lookup" OR ls_dddw_name = "d_dddw_code_lookup_action_type" or ls_dddw_name = "d_dddw_code_lookup_doc_type" THEN
			ls_coltag = Lower(Describe("#" +STRING(ll_i) + ".TAG"))
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
				
			IF li_value <> 1 THEN
				gnv_app.of_setcontraccache_code_lookup( ls_coltag )
				li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
			END IF
		ELSE
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user)
		END IF

		IF li_value = 1 THEN
			getchild( ls_colname, dwchild)
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 04.25.2007 By: Jack
			//$<reason> Fix a defect.
			/*
			If ls_coltag = 'contract category' Then
				dwchild.Reset()
				lnds_user.rowscopy(1, lnds_user.rowcount(),Primary!,dwchild, 1,Primary!)
			Else
				lnds_user.ShareData ( dwchild )	
			End If			
			*/
			lnds_user.ShareData ( dwchild )				
			//---------------------------- APPEON END ----------------------------
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03.27.2007 By: Jack 
			//$<reason> Fix a defect.
			long ll_find
			string ls_displaycolumn
			ls_displaycolumn = This.Describe(ls_colname + ".dddw.displaycolumn")
			ll_find = dwchild.find(ls_displaycolumn + " = '(NONE)'",1,dwchild.rowcount())
			If ll_find > 0 Then
				dwchild.setitem(ll_find,ls_displaycolumn,'')
			End If
			ll_find = dwchild.find(ls_displaycolumn + " = 'No value selected'",1,dwchild.rowcount())
			If ll_find > 0 Then
				dwchild.setitem(ll_find,ls_displaycolumn,'')
			End If
			//---------------------------- APPEON END ----------------------------
			
			//Start code by jervis 10.20.2009
			//dynamically change the words *Add lookup Code* to *Add Agreement Type* and 
			//replace the words lookup code with the field label
			if ls_dddw_name = "d_dddw_code_lookup" or ls_dddw_name = "d_dddw_code_lookup_action_type" or ls_dddw_name = "d_dddw_code_lookup_doc_type" then
				ll_find = dwchild.find("lookup_code = -777", 1, dwchild.rowcount())
				If ll_find > 0 Then 
					ls_lable = This.Describe(ls_colname + "_t.text")
					if ls_lable <> '!' and ls_lable <> '?' then
						dwchild.setitem(ll_find,"code","*Add " + ls_lable + "*")
						dwchild.setitem(ll_find,"description","")
						dwchild.setitem(ll_find,"large_description_1","")
						dwchild.setitem(ll_find,"large_description_2","")
					end if
				elseif ll_find = 0 then//added by gavins 20130412
					ls_lable = This.Describe(ls_colname + "_t.text")
					if ls_lable <> '!' and ls_lable <> '?' then
						if dwchild.rowcount( ) < 2 then
							ll_Find = 0
						Else
							ll_Find = 2
						End If
						ll_Find = dwchild.insertrow( ll_Find )
						dwchild.setitem(ll_find,"code","*Add " + ls_lable + "*")
						dwchild.setitem(ll_find,"description","")
						dwchild.setitem(ll_find,"large_description_1","")
						dwchild.setitem(ll_find,"large_description_2","")
						dwchild.setitem(ll_find,"lookup_code",-777)
						
					end if
				end if
			end if
			//End code by jervis 10.20.2009
			
			//---------Begin Added by Alfee 09.30.2007----------------------------
			//<$Reason>Add contract access control to add lookup data
			String ls_lookup_name
			If Not IsValid(iw_parent) Then of_getparentwindow(iw_parent)
			If IsValid(iw_parent) and (ls_dddw_name = "d_dddw_code_lookup") Then
				If ClassName(iw_parent) = 'w_contract' Then
					ll_find = 0
					ll_find = dwchild.find("lookup_code = -777", 1, dwchild.rowcount())
					If w_mdi.of_security_access(2075) = 0 Then //no access for Add LookUp Data
						If ll_find > 0 Then dwchild.DeleteRow(ll_find)
					End If
				End If
			End If
			//----------End Added ------------------------------------------------
		END IF
		//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
		//Added By Jay Chen 03-07-2014
		if li_value = -1 then
			if ls_dddw_name = 'd_dddw_company' or ls_dddw_name = 'd_dddw_company_list' then 
				ls_coltag = Lower(Describe("#" +STRING(ll_i) + ".TAG"))
				getchild( ls_colname, dwchild)
				SetNull(ll_null)
				dwchild.Settransobject( sqlca)
				dwchild.Retrieve( ls_coltag)
				dwchild.InsertRow(1)
				dwchild.SetItem(1,'facility_id',ll_null)
				dwchild.setitem(1,"facility_name",'')	
			end if
		end if
		//end add
		//---------End Added ------------------------------------------------------
	END IF
NEXT

ib_retrieve_drop_downs = True

Return
//---------------------------- APPEON END ----------------------------
end event

event ue_post_itemchanged;String	ls_ColName,ls_Code,ls_RetVal
long		ll_Rtn,ll_LookupCode
any		l_any
String	ls_value

n_cst_dwsrv lnv_dwsrv

DataWindowChild dwChild

if data = '-777' or Pos(data,"*Add ") > 0 then
	ls_ColName = GetColumnName()
   ll_Rtn = This.GetChild(ls_ColName,dwChild)
   if ll_Rtn > 0 then
		if dwChild.RowCount() > 2 then 
			is_lookup_search_column_table = dwChild.GetItemString(dwChild.RowCount(), "lookup_name")
		end if
   end if

	lnv_dwsrv = create n_cst_dwsrv
	lnv_dwsrv.of_setrequestor(this)
	
	OpenWithParm(w_lookup_search_dddw,'C' + "@" + is_lookup_search_column_table)
	
	if Message.StringParm = "Cancel" then
		ls_Value = lnv_dwsrv.of_GetItem(GetRow(), ls_ColName , Primary!,true)
		if String(ls_value) = "-777" or String(ls_value) = "-888" or Pos(ls_value,"*Add ") > 0 then
			SetNull(ls_value)
		end if
		
		if Not f_validstr(ls_value) then SetNull(ls_Value)
		lnv_dwsrv.of_SetItem(GetRow(), ls_ColName, ls_Value)
		
		if IsValid(lnv_dwsrv) then Destroy lnv_dwsrv
	
		Return
	else
		ll_LookupCode = long(Message.DoubleParm)
		gnv_app.of_SetContracCache_Code_Lookup(is_lookup_search_column_table)
		
		ib_Retrieve_Drop_Downs = false
		Event ue_PopulateDDDWs()
		
		SELECT code INTO :ls_Code FROM code_lookup WHERE lookup_code = :ll_LookupCode;
		
		lnv_dwsrv.of_SetItem(GetRow(), ls_ColName, ls_Code)
		This.AcceptText()
	end if
	
	if IsValid(lnv_dwsrv) then Destroy lnv_dwsrv	
end if 

end event

type cb_pastefile from commandbutton within w_dm_sell_document
boolean visible = false
integer x = 1915
integer y = 240
integer width = 727
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Paste File From Clipboard"
end type

event clicked;String ls_FilePath,ls_FileName,ls_PathName

n_cst_appeondll lnv_appeondll

ls_FilePath = gs_dir_path + gs_DefDirName + '\'//gs_dir_path //Modified By Ken.Guo 2010-06-21
ls_FileName = SPACE(256)

if lnv_appeondll.of_PasteFromClipboard(ls_FilePath,ls_FileName) > 0 then
	ls_PathName = ls_FilePath + ls_FileName
	of_RefreshDocPath(ls_PathName)
	st_info.text = 'Document successfully pasted.'
end if

end event

type cb_scan from commandbutton within w_dm_sell_document
boolean visible = false
integer x = 1915
integer y = 132
integer width = 727
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Scan Existing Document"
end type

event clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Create a document from scanner
**==================================================================================================================
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String ls_filename
Integer li_pos

//----Begin Modified by Alfee on 07.28.2008----
//Open( w_ctx_doc_scan )
IF gi_imageocx = 1 THEN //image 360
	Open( w_ctx_doc_scan ) 
ELSE
	Open( w_ctx_doc_scan_cp )
END IF
//----End Modified ----------------------------

IF f_validstr( Message.StringParm ) THEN
	IF FileExists( Message.stringparm ) THEN
		istr_add_doc.filename = Message.stringparm
		
		//Added By Ken.Guo 2009-05-31.
		If Right(Upper(istr_add_doc.filename),3) = 'PDF' Then
			is_scaned_file = istr_add_doc.filename
		End If
		
		IF dw_1.rowcount( ) > 0 THEN
			dw_1.AcceptText() 
			//-------------Begin Added by Alfee 03.26.2008-----------------------
			dw_1.Setitem(1, "filename", istr_add_doc.filename)			
			ls_filename = Lower(inv_utils.of_get_filename(istr_add_doc.filename)) 
			//-------------End Added --------------------------------------------
			IF NOT f_validstr( dw_1.GetitemString(1, "doc_name") ) THEN
				Parent.of_refreshdocpath(istr_add_doc.filename) //Added By Ken.Guo 2009-11-24.
				//----------Begin Modified -----------------------
				/*ls_filename = istr_add_doc.filename
				li_pos = LastPos(ls_filename,"\")
				IF li_pos > 0 THEN
					ls_filename = Lower(Mid(ls_filename, li_pos + 1))
					dw_1.Setitem(1, "doc_name", ls_filename) 
				END IF*/
				//---------Begin Commented by Alfee 03.26.2008---------------------------
				//ls_filename = Lower(inv_utils.of_get_filename(istr_add_doc.filename))
				//dw_1.Setitem(1, "filename", ls_filename) 
				//---------End Commented ------------------------------------------------
				//dw_1.Setitem(1, "doc_name", ls_filename) //Commented By Ken.Guo 2009-11-24
				//----------End Modified --------------------------
			END IF
			//-----------Begin Added By Alfee 05.09.2007----------
			//Set OK button for buy/other document
			IF NOT f_validstr(ls_filename) THEN 
				cb_3.Enabled = FALSE
			ELSE
				st_info.text = 'Document successfully scanned.'
				cb_3.Enabled = TRUE
			END IF
			//-----------End Added--------------------------------		
		END IF
	END IF
END IF

end event

event constructor;//Alfee 05.19.2008

//IF gi_imageocx <> 1 THEN this.visible = FALSE
end event

