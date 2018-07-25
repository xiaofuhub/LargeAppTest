$PBExportHeader$w_add_clause.srw
$PBExportComments$Create by Jack 03/06/2007
forward
global type w_add_clause from w_response
end type
type tab_attribute from tab within w_add_clause
end type
type tabpage_general from userobject within tab_attribute
end type
type dw_addclause from u_dw_contract within tabpage_general
end type
type tabpage_general from userobject within tab_attribute
dw_addclause dw_addclause
end type
type tabpage_attribute from userobject within tab_attribute
end type
type dw_attributes_detail from u_dw within tabpage_attribute
end type
type cb_customize from commandbutton within tabpage_attribute
end type
type dw_clause_attributes from u_dw within tabpage_attribute
end type
type st_clauseattributes from statictext within tabpage_attribute
end type
type tabpage_attribute from userobject within tab_attribute
dw_attributes_detail dw_attributes_detail
cb_customize cb_customize
dw_clause_attributes dw_clause_attributes
st_clauseattributes st_clauseattributes
end type
type tab_attribute from tab within w_add_clause
tabpage_general tabpage_general
tabpage_attribute tabpage_attribute
end type
type cb_cancel from commandbutton within w_add_clause
end type
type cb_ok from commandbutton within w_add_clause
end type
end forward

global type w_add_clause from w_response
integer width = 2377
integer height = 1812
string title = "Clause Properties"
boolean controlmenu = false
long backcolor = 33551856
boolean ib_closestatus = true
tab_attribute tab_attribute
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_add_clause w_add_clause

type variables
string is_parm,is_clause_name
long il_category,il_ctx_acp_folder_id
long il_ctx_acp_clause_id
Decimal idec_revision //Added By Ken.Guo 2010-01-11.
datawindowchild idw_child

Long iy,ih //for information message field
Long il_exportid_ori //store orginal export id //04.19.2007 alfee
Long il_approvalstatus_ori //store original approval status //05.15.2007 alfee
Long il_category_ori //store original category //05.23.2007 alfee

// WdSaveOptions
constant int wdDoNotSaveChanges = 0
constant int wdPromptToSaveChanges = -2
constant int wdSaveChanges = -1

long il_close  // Add by Jack 05/22/2007

Boolean ib_ImportCaluse = false	//Jervis 12.24.2009
string is_ImportFileName			//Jervis 12.24.2009

//Added By Ken.Guo 2010-01-11.
n_cst_clause inv_clause 
Decimal idec_copy_revision
end variables

forward prototypes
public function long of_check_revisions (long al_clauseid)
public subroutine of_get_infomsg_size ()
public subroutine of_resize (boolean ab_resize)
public function string of_get_clausefile (long al_clauseid)
public function integer of_check_required ()
public subroutine of_updateclauseattribute ()
end prototypes

public function long of_check_revisions (long al_clauseid);Integer li_rtn
//Long ll_clause_approved
String ls_filename
//OLEObject lole_word

Setpointer(Hourglass!)

//----------Begin Modified by Alfee 05.16.2007--------------
//Open the clause file under background if not currently opened
IF NOT IsValid(w_clause_painter) THEN RETURN -1
li_rtn = w_clause_painter.tab_1.of_open_wordfile_background()
IF li_rtn < 1 THEN RETURN -1
IF w_clause_painter.tab_1.tabpage_clause.ole_1.object.doctype <> 1 THEN RETURN -1
//Check revisions
IF w_clause_painter.tab_1.tabpage_clause.ole_1.object.ActiveDocument.Revisions.Count > 0 THEN 
	RETURN 0
END IF

RETURN 1

////Create a new Word object	and open the Word document.
//lole_word = Create oleobject
//IF lole_word.Connecttonewobject("word.application") <> 0 THEN
//	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
//	RETURN -1
//END IF
//
//TRY
//	lole_word.Application.Documents.Open(ls_filename,false,true)
//	lole_word.Visible = FALSE
//	
//	If lole_word.ActiveDocument.Revisions.Count > 0 Then
//		MessageBox("Check Revisions","This document can't be approved due to some revisions included!",Exclamation!)
//		li_rtn = -1
//	End If
//CATCH (RunTimeError rte)
//	lole_word.Quit(wdDoNotSaveChanges)
//	lole_word.DisconnectObject( )
//	Destroy lole_word
//	FileDelete(ls_filename)
//	Return -1
//END TRY
//
////Quit Word application
//lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
//lole_word.Quit(wdDoNotSaveChanges)
//lole_word.DisconnectObject( )
//destroy lole_word
//FileDelete(ls_filename)
//
//Return li_rtn
//----------End Modified------------------------------------
end function

public subroutine of_get_infomsg_size ();
iy = Long(tab_Attribute.tabpage_General.dw_AddClause.Object.information_message.y)
ih = Long(tab_Attribute.tabpage_General.dw_AddClause.Object.information_message.height)



end subroutine

public subroutine of_resize (boolean ab_resize);long i, ll_cnt
tab_Attribute.tabpage_General.dw_AddClause.setredraw(false)
IF ab_resize THEN
	tab_Attribute.tabpage_General.dw_AddClause.object.b_resize.y = 0
	tab_Attribute.tabpage_General.dw_AddClause.object.information_message.y = 36
	tab_Attribute.tabpage_General.dw_AddClause.object.information_message.height = tab_Attribute.tabpage_General.dw_AddClause.height - 36
	tab_Attribute.tabpage_General.dw_AddClause.object.approval_status.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.approval_status_t.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.approved_by.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.approved_by_t.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.category_t.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.category.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.clause_name.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.clause_name_t.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.ctx_acp_folder_id_t.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.ctx_acp_folder_id.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.date_approved.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.date_approved_t.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.description.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.description_t.visible = FALSE
	tab_Attribute.tabpage_General.dw_AddClause.object.information_disp.visible = FALSE
ELSE
	tab_Attribute.tabpage_General.dw_AddClause.object.information_message.y = iy
	tab_Attribute.tabpage_General.dw_AddClause.object.information_message.height = ih
	tab_Attribute.tabpage_General.dw_AddClause.object.b_resize.y = iy - 36
	tab_Attribute.tabpage_General.dw_AddClause.object.approval_status.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.approval_status_t.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.approved_by.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.approved_by_t.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.category_t.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.category.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.clause_name.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.clause_name_t.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.ctx_acp_folder_id_t.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.ctx_acp_folder_id.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.date_approved.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.date_approved_t.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.description.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.description_t.visible = TRUE
	tab_Attribute.tabpage_General.dw_AddClause.object.information_disp.visible = TRUE		
END IF

tab_Attribute.tabpage_General.dw_AddClause.setredraw(true)
end subroutine

public function string of_get_clausefile (long al_clauseid);//Get the clause temp file for checking revision

//---------Begin Modified by Alfee 05.16.2007--------------------
Integer li_rtn
String ls_filename //, ls_filename_tmp

IF NOT IsValid(w_clause_painter) THEN RETURN ""

//ls_filename = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clauseid) + ".doc"
ls_filename = inv_clause.of_generate_name(al_clauseid)

//ls_filename_tmp = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clauseid) + "_tmp.doc"	

//Get the clause file from DB if not currently opened
IF al_clauseid <> w_clause_painter.tab_1.il_old_clause_id THEN 	
	li_rtn = w_clause_painter.tab_1.of_create_word_file(al_clauseid, ls_filename) 
	IF li_rtn <> 1 THEN RETURN	""
END IF

IF NOT FileExists(ls_filename) THEN RETURN ""
//IF NOT FileCopy(ls_filename, ls_filename_tmp, TRUE) < 1 THEN RETURN ""

RETURN ls_filename
//RETURN ls_filename_tmp

////Added by alfee at 03.09.2007

//string ls_file_name, ls_file_tmpname
//boolean lb_select = True
//string ls_lastupdate,ls_updatedate
//long	 ll_getupdate
//
//Long ll_data_length
//Integer li_counter
//Integer li_loops
//Blob lb_data
//Blob lb_all_data
//Long ll_start
//
//Long ll_BlobLen,ll_CurrentPos
//Integer li_Writes,li_FileNum,li_Cnt
//blob lblb_Data
//
//setpointer(HourGlass!)
//
//ls_file_tmpname = as_file_tmpname
//
////If IsValid(w_clause_painter) Then
////	ls_updatedate = string(w_clause_painter.tab_1.tabpage_browse.dw_browse.getitemdatetime(tabpage_browse.dw_browse.getrow(),'modify_date'))
////End If	
////
////gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\")
////ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(al_clause_id) + ".doc"
////ls_file_tmpname = as_file_tmpname
////
////If fileexists(ls_file_name) Then
////	ll_getupdate = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_"+string(al_clause_id), regstring!, ls_lastupdate)
////	If ll_getupdate = 1 and ls_updatedate = ls_lastupdate Then 
////		lb_select = False 
////		If FileCopy(ls_file_name, ls_file_tmpname, True) > 0 Then
////			Return ls_file_tmpname
////		Else
////			lb_select = True
////		End If
////	End If
////End If
//	
//If lb_select = True Then
//	lb_select = False	
//	If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then		
//		SELECTBLOB image_file INTO :lb_all_data
//		  FROM ctx_acp_clause WHERE ctx_acp_clause_id = :al_clause_id;
//	Else			
//		SELECT Datalength(image_file) INTO :ll_data_length
//		  FROM ctx_acp_clause WHERE ctx_acp_clause_id = :al_clause_id;
//		
//		If isnull(ll_data_length) Then ll_data_length = 0
//		
//		If ll_data_length > 8000 Then 
//			If Mod(ll_data_length,8000) = 0 Then
//				li_loops = ll_data_length/8000 
//			Else
//				li_loops = (ll_data_length/8000) + 1 
//			End If 
//		ElseIf ll_data_length > 0 Then 
//			li_loops = 1 
//		End If 
//		
//		For li_counter = 1 To li_loops				
//			ll_start = (li_counter - 1) * 8000 + 1
//			SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
//			  FROM ctx_acp_clause WHERE ctx_acp_clause_id = :al_clause_id;			
//			lb_all_data += lb_data
//		Next 
//	End If
//	If isnull(lb_all_data) Then lb_all_data = blob('')
//		
//	li_FileNum = FileOpen(ls_file_tmpname , StreamMode! ,Write!,Shared!, Replace!)
//	If li_FileNum = -1 Then Return ""
//		
//	ll_BlobLen = Len(lb_all_data)
//	If ll_BlobLen > 32765 Then
//		If Mod(ll_BlobLen, 32765) = 0 Then
//			li_Writes = ll_BlobLen / 32765
//		Else
//			li_Writes = (ll_BlobLen / 32765) + 1
//		End If
//	 Else
//		li_Writes = 1
//	End If
//	
//	ll_CurrentPos = 1
//	
//	For li_Cnt = 1 To li_Writes
//		lblb_Data = BlobMid(lb_all_data, ll_CurrentPos, 32765)
//		ll_CurrentPos += 32765
//		If FileWrite(li_FileNum, lblb_Data) = -1 Then
//			Return ""
//		End If
//	Next
//	
//	FileClose(li_FileNum)
//	
//End If			
//
//Return ls_file_tmpname
//---------End Modified--------------------------------------------
end function

public function integer of_check_required ();//////////////////////////////////////////////////////////////////////
// $<function>w_add_clause.of_check_required()
// $<arguments>
// $<returns> integer
// $<description> Validation on some specifical columns
//////////////////////////////////////////////////////////////////////
// $<add> 09.03.2007 by Alfee (Contract Logix Clause library Painter)
//////////////////////////////////////////////////////////////////////
Long ll_row, ll_cnt1, ll_cnt2
Long ll_approval_status, ll_clause_approved, ll_clauseid, ll_category
long ll_cur_access,ll_ori_access

IF lower(is_parm) <> 'update' THEN RETURN 0

ll_row = tab_Attribute.tabpage_General.dw_AddClause.getrow()
IF ll_row < 1 THEN RETURN 0
ll_clauseid = tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber(ll_row, "ctx_acp_clause_id")

//Check category field - it's necessary while add lookup code fun called by user
ll_category = tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber(ll_row, "category")
IF il_category_ori <> ll_category THEN
	Select count(*) Into :ll_cnt1 From ctx_acp_clause_rely Where ctx_acp_clause_id = :ll_clauseid or ctx_acp_clause_rely_id = :ll_clauseid ;
	IF ll_cnt1 > 0 THEN
		MessageBox("Alert Message","The Category field can't be changed until the rule of dependence on the clause is removed.")
		tab_Attribute.tabpage_General.dw_AddClause.SetFocus()
		tab_Attribute.tabpage_General.dw_AddClause.SetColumn("category")		
		RETURN -1
	END IF
END IF

//Check approval status - it's necessary while add lookup code fun called by user
ll_approval_status = tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber(ll_row, "approval_status")	

//Modify by jervis - 02.09.2010
//adjusting Access at Template or Access at Doc Manager property in Clause Approval Status lookup code
////ll_clause_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Clause Approval Status' and code = 'Approved'"))	
ll_cur_access = long(gnv_data.of_getitem('code_lookup','custom_2',"lookup_name = 'Clause Approval Status' and lookup_code = " + string(ll_approval_status)))	
ll_ori_access = long(gnv_data.of_getitem('code_lookup','custom_2',"lookup_name = 'Clause Approval Status' and lookup_code = " + string(il_approvalstatus_ori)))	

//IF il_approvalstatus_ori = ll_clause_approved and il_approvalstatus_ori <> ll_approval_status THEN 
if ll_ori_access = 1 and ll_cur_access = 0 and il_approvalstatus_ori <> ll_approval_status THEN 
	gnv_appeondb.of_startqueue()
		Select count(*) Into :ll_cnt1 From ctx_acp_template_clause Where ctx_acp_clause_id = :ll_clauseid;
		Select count(*) Into :ll_cnt2 From ctx_am_document_clause Where ctx_acp_clause_id = :ll_clauseid;
	gnv_appeondb.of_commitqueue()
	IF ll_cnt1 > 0 or ll_cnt2 > 0 THEN
		MessageBox("Alert Message","The Review Status field can't be changed until the clause is removed from the affected file(s).")
		tab_Attribute.tabpage_General.dw_AddClause.SetFocus()
		tab_Attribute.tabpage_General.dw_AddClause.SetColumn("approval_status")
		RETURN -1
	END IF
END IF	

RETURN 1
end function

public subroutine of_updateclauseattribute ();//====================================================================
// Function: of_UpdateClauseAttribute()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-06
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

DataWindow		ldw_Clause,ldw_Attributes,ldw_AttriValue

DWItemStatus	ldw_ItemStatus

long		ll_Cycle,ll_RowCnts,ll_TotalCnts,ll_Row,ll_Checked
long		ll_clause_id,ll_attribute_id,ll_Value_id
String	ls_Alias

ldw_Clause     = Tab_Attribute.Tabpage_General.dw_AddClause
ldw_Attributes = Tab_Attribute.Tabpage_Attribute.dw_clause_attributes
ldw_AttriValue = Tab_Attribute.Tabpage_Attribute.dw_attributes_detail

ldw_Attributes.AcceptText()
ldw_AttriValue.AcceptText()

ll_Row = ldw_Clause.GetRow()
ll_clause_id = ldw_Clause.GetItemNumber(ll_Row,"ctx_acp_clause_id")

if is_Parm = "Copy" then
	INSERT INTO ctx_acp_clause_attribute
		  SELECT :ll_clause_id,clause_attribute_id,clause_attribute_alias 
			 FROM ctx_acp_clause_attribute 
			WHERE ctx_acp_clause_id = :il_ctx_acp_clause_id;

	INSERT INTO ctx_acp_clause_attr_value
		  SELECT :ll_clause_id,clause_attribute_id,clause_attribute_value_id 
			 FROM ctx_acp_clause_attr_value 
			WHERE ctx_acp_clause_id = :il_ctx_acp_clause_id;
end if

ll_RowCnts = ldw_Attributes.RowCount()
for ll_Cycle = 1 to ll_RowCnts
	ldw_ItemStatus = ldw_Attributes.GetItemStatus(ll_Cycle,"Alias_Name",Primary!)
	if ldw_ItemStatus = DataModified! then
		ll_attribute_id = ldw_Attributes.GetItemNumber(ll_Cycle,"lookup_code")
		ls_Alias        = ldw_Attributes.GetItemString(ll_Cycle,"Alias_Name")
		
		SELECT Count(*)
		  INTO :ll_TotalCnts
		  FROM ctx_acp_clause_attribute
		 WHERE ctx_acp_clause_id = :ll_clause_id AND clause_attribute_id = :ll_attribute_id;
		 
		if ll_TotalCnts <= 0 then
			INSERT INTO ctx_acp_clause_attribute(ctx_acp_clause_id,clause_attribute_id)
			     VALUES (:ll_clause_id,:ll_attribute_id);
		end if
		
		UPDATE B
			SET B.lookup_name = :ls_Alias
		  FROM code_lookup A,code_lookup B
		 WHERE A.lookup_name = 'Clause Attributes' AND
		       A.lookup_code = :ll_attribute_id AND
				 A.description = B.lookup_name;
		
		UPDATE code_lookup
		   SET description = :ls_Alias
		 WHERE lookup_code = :ll_attribute_id;
	end if
next

ldw_AttriValue.SetFilter("")
ldw_AttriValue.Filter()

ll_RowCnts = ldw_AttriValue.RowCount()
for ll_Cycle = 1 to ll_RowCnts
	ldw_ItemStatus = ldw_AttriValue.GetItemStatus(ll_Cycle,"IsChecked",Primary!)
	if ldw_ItemStatus = DataModified! then
		ll_Checked      = ldw_AttriValue.GetItemNumber(ll_Cycle,"IsChecked")
		ll_attribute_id = ldw_AttriValue.GetItemNumber(ll_Cycle,"lookup_attribute_id")
		ll_Value_id     = ldw_AttriValue.GetItemNumber(ll_Cycle,"lookup_value_id")
		
		SELECT Count(*)
		  INTO :ll_TotalCnts
		  FROM ctx_acp_clause_attr_value 
		 WHERE ctx_acp_clause_id = :ll_clause_id AND clause_attribute_id = :ll_attribute_id AND clause_attribute_value_id = :ll_Value_id;
		 
		if ll_TotalCnts <= 0 then
			if ll_Checked = 1 then
				SELECT Count(*)
				  INTO :ll_TotalCnts
				  FROM ctx_acp_clause_attribute 
				 WHERE ctx_acp_clause_id = :ll_clause_id AND clause_attribute_id = :ll_attribute_id;
				 
				if ll_TotalCnts <= 0 then
					SetNull(ls_Alias)
					
					INSERT INTO ctx_acp_clause_attribute(ctx_acp_clause_id,clause_attribute_id,clause_attribute_alias)
						  VALUES (:ll_clause_id,:ll_attribute_id,:ls_Alias);
				end if
				
				INSERT INTO ctx_acp_clause_attr_value(ctx_acp_clause_id,clause_attribute_id,clause_attribute_value_id)
					  VALUES (:ll_clause_id,:ll_attribute_id,:ll_Value_id);
			end if
		else
			if ll_Checked = 0 then
				DELETE FROM ctx_acp_clause_attr_value WHERE ctx_acp_clause_id = :ll_clause_id AND clause_attribute_id = :ll_attribute_id AND clause_attribute_value_id = :ll_Value_id;
			end if
		end if
	end if
next

gnv_data.of_Retrieve("code_lookup")			//Refresh code lookup cache

end subroutine

on w_add_clause.create
int iCurrent
call super::create
this.tab_attribute=create tab_attribute
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_attribute
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
end on

on w_add_clause.destroy
call super::destroy
destroy(this.tab_attribute)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;call super::open;long ll_row,ll_ctx_acp_folder_id = 0,ll_ctx_acp_clause_id,ll_category
long ll_find,ll_grade,ll_approval_status
long ll_folder[], ll_cnt, ll_exportid,ll_null
Integer li_version_increment
str_folder lstr_folder
datawindowchild child, dwc_export
inv_clause = Create n_cst_clause

tab_Attribute.tabpage_General.dw_AddClause.of_SetTransObject( SQLCA )

lstr_folder = message.powerobjectparm
is_parm = lstr_folder.as_type
ll_category = lstr_folder.al_category
ll_ctx_acp_folder_id = lstr_folder.al_folder_id
ll_ctx_acp_clause_id = lstr_folder.al_clause_id
idec_copy_revision = lstr_folder.adec_revision //Added By Ken.Guo 2010-01-11.
ll_approval_status = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Clause Approval Status' and code = 'Pending'"))
il_ctx_acp_folder_id = ll_ctx_acp_folder_id
il_ctx_acp_clause_id = ll_ctx_acp_clause_id

li_version_increment = of_get_app_setting("set_57",'I') //Added By Ken.Guo 2010-01-11.

If is_parm = 'Add' Then	
	This.title = This.title + ' - Add'
	ll_row = tab_Attribute.tabpage_General.dw_AddClause.InsertRow( 0 )
	tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'category',ll_category)			
	tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'ctx_acp_folder_id',ll_ctx_acp_folder_id)	
	tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'approval_status',ll_approval_status)
	tab_Attribute.tabpage_General.dw_AddClause.setitem(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'date_approved',today())
	tab_Attribute.tabpage_General.dw_AddClause.setitem(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'approved_by',gs_user_id)	
	tab_Attribute.tabpage_General.dw_AddClause.Modify("b_browse.enabled = Yes b_paste.enabled = Yes")
	
	//Added By Ken.Guo 2010-01-11.
	If li_version_increment > 0 Then
		tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'revision_control','1')
		tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'revision',1.0)
	Else
		tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'revision_control','0')
		tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'revision',0.0)		
	End If

Elseif is_parm = 'Update' then
	This.title = This.title + ' - Edit'
	tab_Attribute.tabpage_General.dw_AddClause.retrieve(ll_ctx_acp_clause_id)	
	If tab_Attribute.tabpage_General.dw_AddClause.rowcount() > 0 Then
		is_clause_name = tab_Attribute.tabpage_General.dw_AddClause.getitemstring(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'clause_name')
		il_ctx_acp_folder_id = tab_Attribute.tabpage_General.dw_AddClause.getitemnumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'ctx_acp_folder_id')
		il_exportid_ori = tab_Attribute.tabpage_General.dw_AddClause.getitemnumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'export_id')	//alfee 04.19.2007
		il_approvalstatus_ori = tab_Attribute.tabpage_General.dw_AddClause.getitemnumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'approval_status')	//alfee 05.15.2007
		il_category_ori = tab_Attribute.tabpage_General.dw_AddClause.getitemnumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'category')	//alfee 05.23.2007
	End If
elseif is_parm = 'Copy' then	//10.09.2009 by jervis-add copy function
	This.title = This.title + ' - Copy'
	tab_Attribute.tabpage_General.dw_AddClause.retrieve(ll_ctx_acp_clause_id)	
	If tab_Attribute.tabpage_General.dw_AddClause.rowcount() > 0 Then
		SetNull(ll_null)
		ll_row = tab_Attribute.tabpage_General.dw_AddClause.GetRow( )
		tab_Attribute.tabpage_General.dw_AddClause.SetItemStatus(ll_row,0,primary!,NewModified!)
		tab_Attribute.tabpage_General.dw_AddClause.SetItem(ll_row,'ctx_acp_clause_id',ll_null)
		tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'date_approved',today())
		tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'approved_by',gs_user_id)	
		//tab_Attribute.tabpage_General.dw_AddClause.setitem(ll_row,'revision_control','1')
	End If
End If

tab_Attribute.tabpage_General.dw_AddClause.getchild('ctx_acp_folder_id',child)
child.settransobject(sqlca)
//-------Modified by alfee 04.18.2007----------
//child.retrieve(ll_category)
tab_Attribute.tabpage_General.dw_AddClause.getchild('export_id',dwc_export)
dwc_export.settransobject(sqlca)
gnv_appeondb.of_startqueue() 
	child.retrieve(ll_category)
	dwc_export.retrieve(ll_category)
gnv_appeondb.of_commitqueue()
dwc_export.insertrow(1)
//-------End Modified---------------------------
tab_Attribute.tabpage_General.dw_AddClause.setfocus()
tab_Attribute.tabpage_General.dw_AddClause.setcolumn('clause_name')

of_get_infomsg_size()

//-------Begin Added by Alfee 09.20.2007--------
//Set readonly to the property window
If w_mdi.of_security_access(6800) < 2 Then
	tab_Attribute.tabpage_General.dw_AddClause.Enabled = False
	cb_ok.Enabled = False
End If
//-------End Added------------------------------

end event

event pfc_save;treeviewitem ltvi_item
long ll_Handle,ll_ParentHandle,ll_ctx_acp_folder_id,ll_ctx_acp_clause_id,ll_category
string ls_data,ls_clause_name
datetime ldt_updatedate
string ls_updatedate

//Added By Ken.Guo 2010-01-11.
String ls_revision_control
Decimal ldec_revision
String ls_clause_file
str_add_audit lstr_add_audit
long ll_ori_Status
str_clause lstr_clause

tab_Attribute.tabpage_General.dw_AddClause.accepttext()

//Validation on special fields
If of_check_required() = -1 Then Return -1 //Added by Alfee 09.03.2007
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.22.2007 By: Jack
//$<reason> Fxi a defect.

ll_ori_Status = tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber( 1, "approval_status",Primary!,true)  //Add by jervis 01.30.2010
tab_Attribute.tabpage_General.dw_AddClause.event pfc_preupdate()
gnv_appeondb.of_startqueue( )
tab_Attribute.tabpage_General.dw_AddClause.update()
w_clause_painter.tab_1.ids_folder.retrieve()
w_clause_painter.tab_1.ids_clause.retrieve()
w_clause_painter.tab_1.tabpage_browse.dw_browse.retrieve()
gnv_appeondb.of_commitqueue( )
		
ll_category = tab_Attribute.tabpage_General.dw_AddClause.getitemnumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'category')
ls_clause_name = tab_Attribute.tabpage_General.dw_AddClause.getitemstring(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'clause_name')
ll_ctx_acp_clause_id = tab_Attribute.tabpage_General.dw_AddClause.getitemnumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'ctx_acp_clause_id')
ll_ctx_acp_folder_id = tab_Attribute.tabpage_General.dw_AddClause.getitemnumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'ctx_acp_folder_id')
ls_data = string(ll_ctx_acp_clause_id) + '-' + 'C'

//add by jervis 10.09.2009
if is_parm = 'Copy' then
	
	//Added By Ken.Guo 2010-01-11.
	Select getdate(),revision_control 
	Into :ldt_updatedate,:ls_revision_control
	From ctx_acp_clause Where ctx_acp_clause_id = :il_ctx_acp_clause_id;
	
	If ls_revision_control <> '1' Then 
		ls_revision_control = '0'
		ldec_revision = 0.0
	Else
		ldec_revision = 1.0
	End If
	
   //Select top 1 getdate() into :ldt_updatedate from icred_settings;
	ls_updatedate = string(ldt_updatedate, "mm/dd/yyyy hh:mm:ss")
	
	/*
	//gnv_appeondb.of_startqueue( )
	//Update clause
	update ctx_acp_clause set 
	ctx_acp_clause.image_file = t2.image_file,
	modify_date = :ldt_updatedate
	from (select * from ctx_acp_clause_i where ctx_acp_clause_id = :il_ctx_acp_clause_id) t2
	where ctx_acp_clause.ctx_acp_clause_id = :ll_ctx_acp_clause_id;
	*/
	
	gnv_appeondb.of_startqueue( )
	//Update clause main record.
	update ctx_acp_clause set 
	modify_date = :ldt_updatedate,
	revision = :ldec_revision,
	revision_control = :ls_revision_control
	where ctx_acp_clause.ctx_acp_clause_id = :ll_ctx_acp_clause_id;
	
	//Insert Clause Image record.
	Insert Into ctx_acp_clause_image(clause_id,revision,image_file,modify_date,doc_type)
	Select :ll_ctx_acp_clause_id,:ldec_revision,(Select top 1 image_file from ctx_acp_clause_image where clause_id = :il_ctx_acp_clause_id and revision = :idec_copy_revision ),:ldt_updatedate,'doc';
	
	//Update reqmnt field
	insert ctx_ref_requirement(doc_or_template_id,reqmnt_element_id,reqmnt_type,get_parent_data)
	select :ll_ctx_acp_clause_id,t2.reqmnt_element_id,t2.reqmnt_type,t2.get_parent_data
	from ctx_ref_requirement t2 
	where t2.doc_or_template_id = :il_ctx_acp_clause_id;
	gnv_appeondb.of_commitqueue( )

	
	lstr_add_audit.doc_id = ll_ctx_acp_clause_id
	lstr_add_audit.revision = ldec_revision
	lstr_add_audit.doc_ext = 'doc'
	lstr_add_audit.action = 'New - Copy'
	inv_clause.of_add_audit_trail( lstr_add_audit)
//	
	
	//gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(il_ctx_acp_clause_id), regstring!, ls_updatedate)	
	inv_clause.of_registry_set( il_ctx_acp_clause_id,ldec_revision , ls_updatedate)
	//inv_word_utility.of_update_reqmnt_field(tabpage_clause.ole_1.object, il_ctx_acp_clause_id,'C') //Added By Ken.Guo 2009-07-13.
end if

If is_parm = 'Add' or is_parm = 'Copy' Or ll_ctx_acp_folder_id <> il_ctx_acp_folder_id Then	//jervis 10.09.2009 -- Add 'Copy'
	w_clause_painter.SetRedraw(false)  
	w_clause_painter.tab_1.tabpage_browse.cb_clear.triggerevent(clicked!)
	w_clause_painter.tab_1.tabpage_browse.cb_go.triggerevent(clicked!)
	ll_Handle = w_clause_painter.tab_1.of_getHandle(ls_data,1)
	w_clause_painter.tab_1.tabpage_browse.tv_clause.selectitem(ll_Handle)	
	w_clause_painter.tab_1.tabpage_browse.tv_clause.Event clicked(ll_Handle)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007-03-13 By: Wu ZhiJun
	//$<reason> When user Clicks Add Clause and fills out properties then clicks ok bring them directly to the Clause tab 
	w_clause_painter.tab_1.is_types = 'Add'
	If w_clause_painter.tab_1.tabpage_browse.dw_browse.rowcount() > 0 and (is_parm = 'Add' or is_parm = 'Copy') Then	// jervis 10.09.2009 - Add 'Copy'
		If is_parm = 'Copy' Then //Added By Ken.Guo 2010-01-11. Add if statement. 
			w_clause_painter.tab_1.is_types = 'Update'//Added By Ken.Guo 2010-01-11.
			w_clause_painter.tab_1.selecttab(2)  //Added By Ken.Guo 2010-01-11.
		Else
			If w_clause_painter.tab_1.of_open_word_file(is_ImportFileName) = 1 Then
				w_clause_painter.tab_1.selecttab(2)
	//			if is_ImportFileName <> "" then 
					Try 
						w_clause_painter.tab_1.tabpage_clause.ole_1.object.ActiveDocument.saved = false
					Catch (RunTimeError rte)
					End Try
					w_clause_painter.tab_1.of_save() //Auto Save - jervis 12.24.2009
					w_clause_painter.tab_1.of_refresh_clause(ll_ctx_acp_clause_id) //Added By Ken.Guo 2010-01-11.
	//			end if
			End If
		End If
	End If

	w_clause_painter.SetRedraw(true)
	//--------------------------- APPEON END -----------------------------
ElseIf is_parm = 'Update' Then
	If isnull(is_clause_name) Then is_clause_name = ''
	If isnull(ls_clause_name) Then ls_clause_name = ''		
	If is_clause_name <> ls_clause_name Then
		ll_Handle = w_clause_painter.tab_1.of_getHandle( ls_data,1 )	
		w_clause_painter.tab_1.tabpage_browse.tv_clause.getitem(ll_handle,ltvi_item)
		ltvi_item.label = ls_clause_name
		w_clause_painter.tab_1.tabpage_browse.tv_clause.setitem(ll_handle,ltvi_item)
	End If
	//---------Begin Added by Alfee 01.07.2008-------------------------
	//<$Reason> Refresh the pagebreak flags in agreement template window
	IF IsValid(w_agreement_template_painter) THEN 
		w_agreement_template_painter.ids_clause_approved.Reset()
	END IF
	
	w_clause_painter.tab_1.Event ue_locate_clause(il_ctx_acp_clause_id) //Added By Ken.Guo 2010-01-12.
//	w_clause_painter.tab_1.Post of_set_menu(w_clause_painter.tab_1.selectedtab )
	//---------End Added ----------------------------------------------
	
	//Update Template and Document when Clause Status Changed -- jervis 01.30.2010
	if ll_ori_Status <> tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber( 1, "approval_status") then
		lstr_clause.al_clause_id = il_ctx_acp_clause_id
		inv_clause.of_update_document(lstr_clause,2)	//1-Clause Update,2-Clause Status Changed
	end if
End If
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.22.2007 By: Jack
//$<reason> Fix a defect.
/*
If isnull(ll_category) = False And ll_category <> 0 then
	Closewithreturn(w_add_clause,1)
End If
*/
If isnull(ll_category) Or ll_category = 0 then
	Return 0
End If
//---------------------------- APPEON END ----------------------------
Return 1

end event

event closequery;string ls_clause_name
tab_Attribute.tabpage_General.dw_AddClause.accepttext()
ls_clause_name = tab_Attribute.tabpage_General.dw_AddClause.getitemstring(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'clause_name')
If isnull(ls_clause_name) Then ls_clause_name = ''
If ls_clause_name = '' Then
	ib_closestatus = False
	Return 0
Else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.22.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	Super::Event closequery()
	*/
	il_close = Super::Event closequery()
	Return il_close
	//---------------------------- APPEON END ----------------------------
End If

end event

event close;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.22.2007 By: Jack
//$<reason> Fix a defect.
If il_close = 1 Then
	ib_closestatus = False
	Return 0
Else
	Super::Event close()
End If
//---------------------------- APPEON END ----------------------------


If isvalid(inv_clause) Then Destroy inv_clause //Added By Ken.Guo 2010-01-11.
end event

type tab_attribute from tab within w_add_clause
integer x = 23
integer y = 20
integer width = 2322
integer height = 1560
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_attribute tabpage_attribute
end type

on tab_attribute.create
this.tabpage_general=create tabpage_general
this.tabpage_attribute=create tabpage_attribute
this.Control[]={this.tabpage_general,&
this.tabpage_attribute}
end on

on tab_attribute.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_attribute)
end on

type tabpage_general from userobject within tab_attribute
integer x = 18
integer y = 100
integer width = 2286
integer height = 1444
long backcolor = 33551856
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_addclause dw_addclause
end type

on tabpage_general.create
this.dw_addclause=create dw_addclause
this.Control[]={this.dw_addclause}
end on

on tabpage_general.destroy
destroy(this.dw_addclause)
end on

type dw_addclause from u_dw_contract within tabpage_general
integer x = 14
integer y = 12
integer width = 2263
integer height = 1416
integer taborder = 40
string dataobject = "d_clauses_painter_properties"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;long ll_category,ll_row,ll_ctx_acp_folder_id
Long ll_clauseid, ll_cnt1, ll_cnt2, ll_approval_status, ll_clause_approved //04.19.2007
string ls_category_name
long ll_ori_access,ll_cur_access

tab_Attribute.tabpage_General.dw_AddClause.accepttext()
If isvalid(m_pfe_cst_clause_painter) Then
	//m_pfe_cst_clause_painter.m_file.m_save.enabled = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', True)
End If

//--------Begin Added by alfee 05.15.2007---------------
//<$Reason>Check approval status & export id
IF lower(is_parm) = 'update' and (lower(dwo.name) = "export_id" or lower(dwo.name) = "approval_status" ) THEN
	IF lower(dwo.name) = "approval_status"  THEN
		ll_approval_status = tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(), "approval_status")	
		//Modify by jervis - 02.09.2010
		//adjusting Access at Template or Access at Doc Manager property in Clause Approval Status lookup code
		//ll_clause_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Clause Approval Status' and code = 'Approved'"))	
		//IF il_approvalstatus_ori <> ll_clause_approved or il_approvalstatus_ori = ll_approval_status THEN RETURN		
		ll_cur_access = long(gnv_data.of_getitem('code_lookup','custom_2',"lookup_name = 'Clause Approval Status' and lookup_code = " + string(ll_approval_status)))	
		ll_ori_access = long(gnv_data.of_getitem('code_lookup','custom_2',"lookup_name = 'Clause Approval Status' and lookup_code = " + string(il_approvalstatus_ori)))	
		IF ll_cur_access = 1 or ll_ori_access = 0 or il_approvalstatus_ori = ll_approval_status THEN RETURN		
	END IF
	
	ll_clauseid = tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(), "ctx_acp_clause_id")	
	gnv_appeondb.of_startqueue()
	Select count(*) Into :ll_cnt1 From ctx_acp_template_clause Where ctx_acp_clause_id = :ll_clauseid;
	Select count(*) Into :ll_cnt2 From ctx_am_document_clause Where ctx_acp_clause_id = :ll_clauseid;
	gnv_appeondb.of_commitqueue()
	If ll_cnt1 > 0 or ll_cnt2 > 0 Then 
		//MessageBox("Alert Message","This field can't be changed until the clause removed from the affected file(s).")
		MessageBox("Alert Message","This field can't be changed until the clause is removed from the affected file(s).")
		If lower(dwo.name) = "export_id" Then
			tab_Attribute.tabpage_General.dw_AddClause.SetItem(tab_Attribute.tabpage_General.dw_AddClause.getrow(), "export_id", il_exportid_ori)	
		Else
			tab_Attribute.tabpage_General.dw_AddClause.SetItem(tab_Attribute.tabpage_General.dw_AddClause.getrow(), "approval_status", il_approvalstatus_ori)	
		END IF		
		Return 1
	End If
END IF	
//-------End Added---------------------------------	

//-------Begin Added by alfee 05.23.2007----------
//<$Reason>Check category field
IF lower(is_parm) = 'update' and lower(dwo.name) = "category" THEN
	IF data = String(il_category_ori) THEN RETURN // Added by Alfee 09.03.2007
	ll_clauseid = tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(), "ctx_acp_clause_id")	
	Select count(*) Into :ll_cnt1 From ctx_acp_clause_rely Where ctx_acp_clause_id = :ll_clauseid or ctx_acp_clause_rely_id = :ll_clauseid ;
	If ll_cnt1 > 0 Then 
		//MessageBox("Alert Message","This field can't be changed until the rule of dependence on the clause removed.")
		MessageBox("Alert Message","This field can't be changed until the rule of dependence on the clause is removed.")
		tab_Attribute.tabpage_General.dw_AddClause.SetItem(tab_Attribute.tabpage_General.dw_AddClause.getrow(), "category", il_category_ori)	
		Return 1
	End If
END IF	
//-------End Added---------------------------------	

end event

event constructor;call super::constructor;datawindowchild child
long ll_find

This.Event ue_populatedddws()
This.getchild('ctx_acp_folder_id',idw_child)
idw_child.settransobject(sqlca)

//This.getchild('category',child)
//child.settransobject(sqlca)
//child.retrieve()
//child.insertrow(1)
//child.setitem(1,'lookup_code',-777)
//child.setitem(1,'code','*Add lookup Code*')

This.getchild('approval_status',child)
ll_find = child.find("code = '(NONE)'",1,child.rowcount())
If ll_find > 0 Then
	child.deleterow(ll_find)
End If

end event

event getfocus;//
end event

event losefocus;//
end event

event pfc_preupdate;datetime ldt_updatedate
long ll_ctx_acp_clause_id

ldt_updatedate = datetime(today())
If is_parm = 'Add' or is_parm = 'Copy'  Then	//10.09.2009 by jervis - add 'Copy'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.17.2007 By: Jack
	//$<reason> 
	/*
	SELECT max(ctx_acp_clause_id) INTO :ll_ctx_acp_clause_id FROM ctx_acp_clause;
	*/
	ll_ctx_acp_clause_id = gnv_app.of_get_id("ctx_acp_clause_id")
	//---------------------------- APPEON END ----------------------------
	//---------Begin Modified by (Appeon)Harry 10.30.2015 for  Bug id 4811--------
	/*
	If isnull(ll_ctx_acp_clause_id) Then ll_ctx_acp_clause_id = 0
	If ll_ctx_acp_clause_id = 0 Then
		ll_ctx_acp_clause_id = 1
	Else
		ll_ctx_acp_clause_id = ll_ctx_acp_clause_id + 1
	End If
	*/
	//---------End Modfiied ------------------------------------------------------
	
	tab_Attribute.tabpage_General.dw_AddClause.setitem(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'ctx_acp_clause_id',ll_ctx_acp_clause_id)	
	tab_Attribute.tabpage_General.dw_AddClause.setitem(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'create_date',ldt_updatedate)
	tab_Attribute.tabpage_General.dw_AddClause.setitem(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'modify_date',ldt_updatedate)
End If	
Return 1
end event

event clicked;call super::clicked;String ls_msg
Long ll_row

IF Lower(dwo.name) <> 'b_resize' THEN RETURN 
ll_row = tab_Attribute.tabpage_General.dw_AddClause.getrow()
IF ll_row < 1 THEN RETURN

tab_Attribute.tabpage_General.dw_AddClause.AcceptText()
ls_msg = tab_Attribute.tabpage_General.dw_AddClause.GetItemString(ll_row, "information_message")
OpenwithParm(w_clause_infomsg, ls_msg)

ls_msg = Message.StringParm
IF Not IsNull(ls_msg) and Lower(ls_msg) <> 'cancel' THEN
	tab_Attribute.tabpage_General.dw_AddClause.SetItem(ll_row, "information_message",ls_msg)
END IF


end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//////////////////////////////////////////////////////////////////////
// $<event>ue_post_itemchangeddw_addclause()
// $<arguments>
//		string	data		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 04.17.2007 by Jack
//////////////////////////////////////////////////////////////////////
long ll_category,ll_row,ll_ctx_acp_folder_id,ll_approval_status,ll_approval_status1
string ls_category_name
If this.getcolumnname() = 'category' Then
	ll_category = This.getitemnumber(This.getrow(),'category')
	ls_category_name = This.Describe("Evaluate('LookupDisplay(category)'," + string(this.getrow()) + ")")	
	ll_row = idw_child.retrieve(ll_category)
	If ll_category <> il_category Then
		setnull(ll_ctx_acp_folder_id)
		This.setitem(This.getrow(),'ctx_acp_folder_id',ll_ctx_acp_folder_id)
		il_category = ll_category
	End If
	If ll_row < 1 then
		messagebox('Error','There is no folder with the category ' + ls_category_name + '.  Please add a folder first.')
		Return
	End If
End If
If this.getcolumnname() = 'approval_status' Then
	ll_approval_status = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Clause Approval Status' and code = 'Approved'"))
	ll_approval_status1 = tab_Attribute.tabpage_General.dw_AddClause.getitemnumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'approval_status')
	If ll_approval_status1 = ll_approval_status Then
		tab_Attribute.tabpage_General.dw_AddClause.setitem(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'date_approved',today())
	End If
End If

end event

event buttonclicked;call super::buttonclicked;//Add code by jervis - 12 24.2009
//browse to a Word file that you want to pull in as a Clause 
//or if you perform a right click / Copy in Microsoft File Explorer 
//you can click the Paste button and the system will copy the word documents contents as bases for new Clause
string ls_FilePath,ls_FileName
Integer li_rtn

choose case dwo.name
	case 'b_browse'
		gf_load_dir_path()
		li_rtn = GetFileOpenName("Select File", ls_FilePath,ls_FileName,"DOC","Doc Files (*.DOC),*.DOC,Docx Files (*.DOCX),*.DOCX")
		gf_Save_dir_path(ls_FilePath)
		if li_rtn = 1 then
			this.SetItem( row, "clause_name",Mid(ls_FileName,1,Lastpos(ls_FileName,".") -1))
			ib_ImportCaluse = true
			is_ImportFileName = ls_FilePath
		end if
	case 'b_paste'
		ls_FileName = SPACE(256)
		ls_FilePath = gs_dir_path + gs_DefDirName + "\Agreement\Temp\"
		gnv_appeondll.of_parsepath( ls_FilePath)
		if gnv_appeondll.of_PasteFromClipboard(ls_FilePath,ls_FileName) > 0 then
			this.SetItem( row,"Clause_name",Mid(ls_FileName,1,Lastpos(ls_FileName,".") - 1))
			is_ImportFileName = ls_FilePath + ls_FileName
			ib_ImportCaluse = true
		end if
end choose

end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
// Event: rowfocuschanged()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    CurrentRow
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-05
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_clause_id,ll_Row

if CurrentRow > 0 and CurrentRow <= This.RowCount() then
	ll_clause_id = This.GetItemNumber(CurrentRow,"ctx_acp_clause_id")
end if

Tab_Attribute.Tabpage_Attribute.dw_clause_attributes.SetTransObject(SQLCA)
Tab_Attribute.Tabpage_Attribute.dw_clause_attributes.Retrieve(ll_clause_id)

Tab_Attribute.Tabpage_Attribute.dw_Attributes_Detail.SetTransObject(SQLCA)
Tab_Attribute.Tabpage_Attribute.dw_Attributes_Detail.Retrieve(ll_clause_id)

end event

type tabpage_attribute from userobject within tab_attribute
integer x = 18
integer y = 100
integer width = 2286
integer height = 1444
long backcolor = 33551856
string text = "Attribute"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_attributes_detail dw_attributes_detail
cb_customize cb_customize
dw_clause_attributes dw_clause_attributes
st_clauseattributes st_clauseattributes
end type

on tabpage_attribute.create
this.dw_attributes_detail=create dw_attributes_detail
this.cb_customize=create cb_customize
this.dw_clause_attributes=create dw_clause_attributes
this.st_clauseattributes=create st_clauseattributes
this.Control[]={this.dw_attributes_detail,&
this.cb_customize,&
this.dw_clause_attributes,&
this.st_clauseattributes}
end on

on tabpage_attribute.destroy
destroy(this.dw_attributes_detail)
destroy(this.cb_customize)
destroy(this.dw_clause_attributes)
destroy(this.st_clauseattributes)
end on

type dw_attributes_detail from u_dw within tabpage_attribute
integer x = 1006
integer y = 100
integer width = 1266
integer height = 1176
integer taborder = 21
string dataobject = "d_attributes_detail"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateable(false)

This.SetTransObject(SQLCA)

end event

event clicked;call super::clicked;long	ll_Selected

if Row > 0 and Row <= This.RowCount() then
	This.SetRow(Row)
	ll_Selected = This.GetItemNumber(Row,"IsChecked")
	This.SetItem(Row,"IsChecked",1 - ll_Selected)
end if

end event

event doubleclicked;call super::doubleclicked;This.Trigger Event Clicked(XPos,YPos,Row,dwo)

end event

type cb_customize from commandbutton within tabpage_attribute
integer x = 9
integer y = 1320
integer width = 334
integer height = 92
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Customize..."
end type

event clicked;String	ls_Alias
long		ll_Row

ll_Row = dw_clause_attributes.GetRow()
ls_Alias = dw_clause_attributes.GetItemString(ll_Row,"alias_name")

OpenWithParm(w_ModifyAttributeAlias,dw_clause_attributes)

ls_Alias = Message.StringParm

if Not IsNull(ls_Alias) and Trim(ls_Alias) <> "" then
	dw_clause_attributes.SetItem(ll_Row,"alias_name",ls_Alias)
	dw_attributes_detail.Modify("code_t.Text = '" + ls_Alias + " (Check one or more)'")
end if

end event

type dw_clause_attributes from u_dw within tabpage_attribute
integer x = 9
integer y = 100
integer width = 974
integer height = 1176
integer taborder = 11
string dataobject = "d_clause_attributes"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;String	ls_Alias,ls_LookupName

if CurrentRow <= 0 or CurrentRow > This.RowCount() then Return

ls_Alias = This.GetItemString(CurrentRow,"alias_name")
dw_attributes_detail.Modify("code_t.Text = '" + ls_Alias + " (Check one or more)'")

ls_LookupName = This.GetItemString(CurrentRow,"Origi_Name")
dw_Attributes_Detail.SetFilter("lookup_name = '" + ls_LookupName + "'")
dw_Attributes_Detail.Filter()

end event

event constructor;call super::constructor;This.of_SetUpdateable(false)

end event

event doubleclicked;call super::doubleclicked;cb_Customize.Event Clicked()

end event

type st_clauseattributes from statictext within tabpage_attribute
integer x = 27
integer y = 20
integer width = 416
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clause Attributes"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_add_clause
integer x = 2011
integer y = 1612
integer width = 334
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Closewithreturn(w_add_clause,0)


end event

type cb_ok from commandbutton within w_add_clause
integer x = 1641
integer y = 1612
integer width = 334
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;Integer li_rtn
Long ll_exportid, ll_folderid
string ls_clause_name
integer li_count
str_clause lstr_clause
datawindow ldw_clause
Boolean lb_update_documents = false

tab_Attribute.tabpage_General.dw_AddClause.accepttext()
ls_clause_name = tab_Attribute.tabpage_General.dw_AddClause.getitemstring(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'clause_name')
If isnull(ls_clause_name) or ls_clause_name = '' Then
	messagebox('IntelliSoftGroup','Required value missing for Clause Name on row 1. Please enter a value.')
	tab_Attribute.tabpage_General.dw_AddClause.setfocus()
	tab_Attribute.tabpage_General.dw_AddClause.setcolumn('clause_name')
	Return
End If

//-----Begin Add- By alfee at 05.08.2007--------
ll_folderid = tab_Attribute.tabpage_General.dw_AddClause.getitemNumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'ctx_acp_folder_id')
If isnull(ll_folderid) or ll_folderid < 0 Then
	messagebox('IntelliSoftGroup','Required value missing for Folder Name on row 1. Please enter a value.')
	tab_Attribute.tabpage_General.dw_AddClause.setfocus()
	tab_Attribute.tabpage_General.dw_AddClause.setcolumn('ctx_acp_folder_id')
	Return
End If
//-----End Add------------------------------------

If inv_clause.of_check_name(ls_clause_name) < 0 Then Return //Added By Ken.Guo 2010-01-13.

//Add by jervis - 03.06.2010
If is_parm = 'Add' or is_parm = 'Copy'  Then	
	select 1 into :li_count FROM ctx_acp_clause  WHERE clause_name = :ls_clause_name;
	if li_count = 1 then
		if messagebox('IntelliSoftGroup','The name of the Clause already exists, do you want to continue?' ,Question!,YesNo!) = 2 then
			tab_Attribute.tabpage_General.dw_AddClause.setfocus()
			tab_Attribute.tabpage_General.dw_AddClause.setcolumn('clause_name')
			Return
		end if
	end if
end if

//-----Begin Add- By alfee at 04.18.2007--------
//ll_exportid = tab_Attribute.tabpage_General.dw_AddClause.getitemNumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'export_id')
//If isnull(ll_exportid) or ll_exportid < 0 Then
//	messagebox('IntelliSoftGroup','Required value missing for Export ID on row 1.  Please enter a value.')
//	tab_Attribute.tabpage_General.dw_AddClause.setfocus()
//	tab_Attribute.tabpage_General.dw_AddClause.setcolumn('export_id')
//	Return
//End If
//-----End Add ----------------------------------		

If tab_Attribute.tabpage_General.dw_AddClause.modIfiedcount() > 0 Then
	//-----Begin Add- By alfee at 03.09.2007--------
	//Check revisions if approved
	long ll_clause_approved, ll_clauseid
	ll_clause_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Clause Approval Status' and code = 'Approved'"))
	ll_clauseid = tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'ctx_acp_clause_id') 
   If ll_clauseid > 0 Then
	   If tab_Attribute.tabpage_General.dw_AddClause.GetItemNumber(tab_Attribute.tabpage_General.dw_AddClause.getrow(),'approval_status') = ll_clause_approved Then
			//-----Begin Modified by Alfee 05.16.2007-------------
			//If of_check_revisions(ll_clauseid) < 0 Then Return
			li_rtn = of_check_revisions(ll_clauseid)
			If li_rtn = 0 Then
				MessageBox("Check Revisions","This document can't be approved due to some revisions included! Please approve or reject the changes with the reviewing menu items first.")
			ELSEIF li_rtn < 0 Then
				MessageBox("Check Revisions","This document can't be approved due to checking revisions failed!",Exclamation!)		
			END IF
			IF li_rtn < 1 THEN 
				tab_Attribute.tabpage_General.dw_AddClause.setfocus()				
				tab_Attribute.tabpage_General.dw_AddClause.SetColumn("approval_status")
				RETURN
			END IF
			//-----End Modified-------------------------------------		
		End If
	End If
	//-----End Add ----------------------------------		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.22.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	Parent.Event pfc_save()
	*/
	//Added By Ken.Guo 2010-10-25.
	ldw_clause = tab_Attribute.tabpage_General.dw_AddClause
	If lower(is_parm) = 'update' and &
		(ldw_clause.GetItemNumber(ldw_clause.getrow(),'append_paragraph',Primary!,False) <> ldw_clause.GetItemNumber(ldw_clause.getrow(),'append_paragraph',Primary!,True) or &
		 ldw_clause.GetItemNumber(ldw_clause.getrow(),'page_break',Primary!,False) <> ldw_clause.GetItemNumber(ldw_clause.getrow(),'page_break',Primary!,True) ) Then
		 	lb_update_documents = True
	End If
	
	If Parent.Event pfc_save() = 1 then
		of_UpdateClauseAttribute()				//Added by Scofield on 2010-01-06
		
		//Added By Ken.Guo 2010-10-25. Update Ref template and document.
		lstr_clause.al_clause_id = il_ctx_acp_clause_id
		lstr_clause.as_clause_name = ls_clause_name
		If lb_update_documents Then
			inv_clause.of_update_document(lstr_clause, 1)
		End If
		
		Closewithreturn(w_add_clause,1)
	End If	
	//---------------------------- APPEON END ----------------------------
Else
	of_UpdateClauseAttribute()					//Added by Scofield on 2010-01-06
	Closewithreturn(w_add_clause,0)
End If

end event

