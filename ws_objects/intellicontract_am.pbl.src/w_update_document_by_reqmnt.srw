$PBExportHeader$w_update_document_by_reqmnt.srw
forward
global type w_update_document_by_reqmnt from w_response
end type
type st_status from statictext within w_update_document_by_reqmnt
end type
type cb_2 from commandbutton within w_update_document_by_reqmnt
end type
type cb_1 from commandbutton within w_update_document_by_reqmnt
end type
type dw_1 from u_dw_contract within w_update_document_by_reqmnt
end type
end forward

global type w_update_document_by_reqmnt from w_response
integer width = 2848
integer height = 1272
string title = "Update Document"
long backcolor = 33551856
st_status st_status
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_update_document_by_reqmnt w_update_document_by_reqmnt

type variables
n_cst_dm_utils inv_dm_utils
str_requirement_doc istr_reqmnt_doc
end variables

forward prototypes
public function decimal of_get_new_version (long al_row, long al_doc_id)
end prototypes

public function decimal of_get_new_version (long al_row, long al_doc_id);Boolean lb_revision_control
Integer li_version_increment
decimal ldec_max_revision,ldec_new_revision

lb_revision_control = (dw_1.GetItemString(al_row, "ctx_am_document_revision_control") = "1")
li_version_increment = of_get_app_setting("set_57",'I')	//Version Number Increment Option


Select Max(Revision) Into :ldec_max_revision From Ctx_am_doc_image	Where Doc_id = :al_doc_id ;   //Added By Ken.Guo 2009-05-15. Get newest revision.
		
IF (lb_revision_control and li_version_increment = 1) THEN 
	ldec_new_revision = inv_dm_utils.of_newversion( ldec_max_revision )   
ELSE
	ldec_new_revision = ldec_max_revision 
END IF

Return ldec_new_revision
end function

on w_update_document_by_reqmnt.create
int iCurrent
call super::create
this.st_status=create st_status
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_status
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_update_document_by_reqmnt.destroy
call super::destroy
destroy(this.st_status)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;
istr_reqmnt_doc = Message.powerobjectparm

dw_1.SetTransObject(SQLCA)

dw_1.Retrieve(istr_reqmnt_doc.sl_ctx_id,istr_reqmnt_doc.sl_element_id[])


end event

type st_status from statictext within w_update_document_by_reqmnt
integer x = 37
integer y = 1056
integer width = 1765
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Note: if the document is being checked out, then it CANNOT be updated."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_update_document_by_reqmnt
integer x = 2427
integer y = 1048
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_1 from commandbutton within w_update_document_by_reqmnt
integer x = 2071
integer y = 1048
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;Long i,ll_doc_id
Decimal{1} ldec_rev_id,ldec_rev_id_new
String ls_doc_name,ls_doc_status
String ls_file,ls_file_temp
String ls_error,ls_action,ls_notes
str_add_audit lstr_add_audit
n_cst_word_utility lnv_word_utility
boolean lb_parent_data0[],lb_parent_data1[]
Integer li_ret
lnv_word_utility = Create n_cst_word_utility

Boolean lb_existed
SetPointer(HourGlass!)

//initialize data
For i = 1 To UpperBound(istr_reqmnt_doc.sl_element_id[])
	lb_parent_data0[i] = False
	lb_parent_data1[i] = True
Next
ls_file_temp = gs_dir_path + gs_DefDirName + "\Agreement\Requirement_field.doc"

For i = 1 To dw_1.RowCount()
	If dw_1.GetItemNumber(i,'Selected') = 0 Then Continue
	
	dw_1.SetRow(i)
	dw_1.ScrolltoRow(i)
	dw_1.SelectRow(0,False)
	dw_1.SelectRow(i,True)	
	dw_1.SetItem(i,'update_result','Updating...')
	
	//Get document information
	ll_doc_id = dw_1.GetItemNumber(i,'ctx_am_document_doc_id')
	ldec_rev_id = dw_1.GetItemNumber(i,'ctx_am_document_revision')
	ls_doc_name = dw_1.GetItemString(i,'compute_1')
	ls_doc_status = dw_1.GetItemString(i,'ctx_am_document_checkout_status')
	If ls_doc_status <> '0' Then
		dw_1.SetItem(i,'update_result','Failure. The document is being checked out.')
		Continue		
	End If
	
	If Not isvalid(w_ole_word) Then Open(w_ole_word)
	
	//Download document file
	ls_file = inv_dm_utils.of_download_file( ll_doc_id, ldec_rev_id)
	IF Not FileExists(ls_file) THEN 
		dw_1.SetItem(i,'update_result','Failure. Failed to download document.')
		Continue
	End if
	
	//Refresh requirement fields in document.
	w_ole_word.ole_1.object.openlocalfile(ls_file,False)
	//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
	gnv_word_utility.of_modify_word_property( w_ole_word.ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.	
	//---------End Added ------------------------------------------------------
	If dw_1.GetItemNumber(i,'sub_contract') = 0 Then
		//Current Contract's documents
		li_ret = lnv_word_utility.of_refresh_reqmnt_fields( w_ole_word.ole_1.object,istr_reqmnt_doc.sl_reqmnt_id[], istr_reqmnt_doc.ss_element_name[],istr_reqmnt_doc.sl_element_id[] ,lb_parent_data0[],ls_error)
	Else
		//Sub-Contract's documents
		li_ret = lnv_word_utility.of_refresh_reqmnt_fields( w_ole_word.ole_1.object,istr_reqmnt_doc.sl_reqmnt_id[], istr_reqmnt_doc.ss_element_name[],istr_reqmnt_doc.sl_element_id[] ,lb_parent_data1[],ls_error)
	End If
	ls_action = 'Updated Requirement Fields'

	//Upload file to DB and write log.
	If li_ret > 0 Then
		w_ole_word.ole_1.object.savetolocal(ls_file_temp,True)
		ldec_rev_id_new = of_get_new_version(i,ll_doc_id)
		If inv_dm_utils.of_upload_file( ll_doc_id, ldec_rev_id_new, ls_file_temp) > 0 Then
			dw_1.SetItem(i,'update_result','Success.')
			lstr_add_audit.doc_id = ll_doc_id
			lstr_add_audit.revision = ldec_rev_id_new
			lstr_add_audit.doc_ext = dw_1.GetItemString(i,'ctx_am_document_doc_ext')
			lstr_add_audit.action = ls_action
			lstr_add_audit.notes = ''
			inv_dm_utils.of_add_audit_trail( lstr_add_audit )			
		Else
			dw_1.SetItem(i,'update_result','Failure. Failed to save file to DB.')			
		End If
	Else
		dw_1.SetItem(i,'update_result',ls_error)
	End If
	
	w_ole_word.ole_1.object.Close()
	lb_existed = True
Next

//Reset document manager flag. To reload document when select the tabpage.
IF lb_existed Then
//	If gw_contract.tab_contract_details.ib_select9 = True Then
		gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.selecttab(1)
		If gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_preview_doc_id > 0 Then
			gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.ole_doc.object.close()
			gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_preview_doc_id = -1
		End If
		gw_contract.tab_contract_details.ib_select9 = False
//	End If
	Messagebox('Update','Update Complete!')
End If
SetPointer(Arrow!)
If Isvalid(n_cst_word_utility) Then Destroy n_cst_word_utility

end event

type dw_1 from u_dw_contract within w_update_document_by_reqmnt
integer x = 23
integer y = 28
integer width = 2784
integer height = 972
integer taborder = 10
string title = "none"
string dataobject = "d_doc_ref_requirement"
boolean hscrollbar = true
end type

event constructor;call super::constructor;of_setrowselect( true)
this.inv_rowselect.of_setstyle( inv_rowselect.single)

this.of_setupdateable( false)
this.ib_rmbmenu=false

this.Event ue_populatedddws()
end event

