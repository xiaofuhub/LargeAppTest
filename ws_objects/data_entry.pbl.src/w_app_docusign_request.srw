$PBExportHeader$w_app_docusign_request.srw
forward
global type w_app_docusign_request from w_response
end type
type ole_edit from olecustomcontrol within w_app_docusign_request
end type
type ole_message from u_email_edit within w_app_docusign_request
end type
type cb_custom from commandbutton within w_app_docusign_request
end type
type cb_cancel from commandbutton within w_app_docusign_request
end type
type dw_doc from u_dw within w_app_docusign_request
end type
type cb_send from commandbutton within w_app_docusign_request
end type
type dw_2 from u_dw within w_app_docusign_request
end type
type dw_1 from u_dw within w_app_docusign_request
end type
end forward

global type w_app_docusign_request from w_response
integer x = 214
integer y = 221
integer width = 2921
integer height = 1988
string title = "Send For Docusign Signature"
long backcolor = 33551856
ole_edit ole_edit
ole_message ole_message
cb_custom cb_custom
cb_cancel cb_cancel
dw_doc dw_doc
cb_send cb_send
dw_2 dw_2
dw_1 dw_1
end type
global w_app_docusign_request w_app_docusign_request

type variables
//str_ctx_email istr_ctx_email
str_app_email istr_app_email
n_cst_dm_utils inv_dm_utils
Datawindowchild idwc_email_template
Long il_last_export_id
DataStore ids_export
n_cst_filesrvwin32 inv_filesrv
n_cst_string inv_string

long il_prac_id  //maha 07.12.2017
long il_facility  //maha 07.12.2017

boolean ib_open = false //Added By Jay Chen 10-15-2013
string is_order_x,is_role_x,is_email_x
end variables

forward prototypes
public function integer of_download_doc ()
public subroutine of_set_documents ()
public function integer of_set_sertifi ()
public function integer of_check_data ()
public function integer of_set_message (long al_email_id)
public function integer of_readblob (string as_filename, ref blob ab_value)
public function boolean of_modify_field_font_color (string as_pathname)
protected subroutine of_update_email_list (string as_column_name, string as_old_email_list, string as_new_email_list)
end prototypes

public function integer of_download_doc ();Long i, f
String ls_pathfile[]
String ls_fullfilename[]
String ls_filename
String ls_path
Long ll_app_id
long ll_pos

//Download Documents
If Not isvalid(w_appeon_gifofwait) Then OpenwithParm(w_appeon_gifofwait,"Downloading the document(s)...")
For i = 1 to  UpperBound(istr_app_email.rec_id_list[])
	SELECT  file_name
	  INTO  :ls_filename
	  FROM net_dev_action_images
	 WHERE rec_id = :istr_app_email.rec_id_list[i] AND prac_id = :istr_app_email.prac_id_list[i];

	if IsNull(ls_filename) or Len(Trim(ls_filename))  < 1 then
		ls_filename = String(istr_app_email.rec_id_list[i]) + "_" + String(istr_app_email.prac_id_list[i]) + "_"  + String(istr_app_email.app_id_list[i]) + ".tif"
	else
		ll_pos = pos(ls_filename, '.')
		ls_filename = String(istr_app_email.rec_id_list[i]) + "_" + String(istr_app_email.prac_id_list[i]) + "_"  + String(istr_app_email.app_id_list[i]) + Mid(ls_filename, ll_pos)
	end if
	
	ls_path = gs_temp_path + "Images\"+ ls_filename
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 01.03.2017
	//<$>reason:Use gw_prac_data for IntelliApp, for issue :Seeking explanation of Database error code: 515.

//	if isvalid(w_prac_data_1.tab_1.tabpage_net.uo_net) then
//		if w_prac_data_1.tab_1.tabpage_net.uo_net.of_down_image(istr_app_email.rec_id_list[i], istr_app_email.prac_id_list[i], istr_app_email.app_id_list[i], ls_path) = 1 then
	if isvalid(gw_prac_data) then
		if gw_prac_data.tab_1.tabpage_net.uo_net.of_down_image(istr_app_email.rec_id_list[i], istr_app_email.prac_id_list[i], istr_app_email.app_id_list[i], ls_path) = 1 then
	//------------------- APPEON END -------------------
			//---------Begin Added by (Appeon)Harry 07.27.2016 - BugL072603
			if Lower(right(ls_filename,4)) = ".tif" or  Lower(right(ls_filename,5)) = ".tiff" then  //tif or tiff 
				//load image
				ole_edit.Object.Image( ls_path )	
				
				for f = 1 to ole_edit.Object.PageCount()
					ole_edit.Object.Page( f )
					ole_edit.Object.Display()				
					try
						ole_edit.Object.BurnInAnnotations( 1, 2 )
					Catch(Throwable th1) 
						ole_edit.Object.BurnInAnnotations( 1, 2 )
					end try
					ole_edit.Object.save()
				next
			end if
			//---------End Added ------------------------------------------------------
			ls_fullfilename[UpperBound(ls_fullfilename[]) + 1] = ls_filename
			ls_pathfile[UpperBound(ls_pathfile[]) + 1] = ls_path
		end if
	end if
Next
If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)

//Check document
For i = 1 To UpperBound(istr_app_email.rec_id_list[])
	if UpperBound(ls_pathfile[]) <= 0 then //Added By Jay Chen 10-11-2013
		Messagebox('Check Document','Failed to download the document (rec_id = '+String(istr_app_email.rec_id_list[i])+', prac_id = '+String(istr_app_email.prac_id_list[i])+')')
		return -1
	end if
	If Not FileExists(ls_pathfile[i]) Then
		Messagebox('Check Document','Failed to download the document (rec_id = '+String(istr_app_email.rec_id_list[i])+', prac_id = '+String(istr_app_email.prac_id_list[i])+')')
		Return -1
	End If
Next

istr_app_email.fullfilename_list[] = ls_fullfilename[]
istr_app_email.pathfilename_list[] = ls_pathfile[]

Return 1

end function

public subroutine of_set_documents ();Long i,ll_row
For i = 1 To UpperBound(istr_app_email.rec_id_list[])
	ll_row = dw_doc.InsertRow(0)
	dw_doc.SetItem(ll_row,'need_signed',1)
	dw_doc.SetItem(ll_row,'docname',istr_app_email.fullfilename_list[i])
	dw_doc.SetItem(ll_row,'prac_id',istr_app_email.prac_id_list[i])
	dw_doc.SetItem(ll_row,'rec_id',istr_app_email.rec_id_list[i])
Next


end subroutine

public function integer of_set_sertifi ();String ls_companyname,ls_filename
string ls_this
long ll_next
Int li_days
date ld_due_date

//Added By Jay Chen 09-04-2014
string ls_mode

ls_mode = gnv_user_option.of_get_option_value(gs_user_id, "docusign_license_mode" )
if isnull(ls_mode) or ls_mode = '' then ls_mode = "global_license"
if ls_mode = "global_license" then
	gnv_docusign.is_es_license_user_id = 'global_license_user'
	If Not gnv_docusign.of_check_sertifi( ) Then Return -1  
else
	If Not gnv_docusign.of_check_sertifi(false,'','','',true) Then Return -1 
end if
//end add

if isvalid(istr_app_email) then
	ls_filename = String(istr_app_email.rec_id_list[1]) + "-" + String(istr_app_email.prac_id_list[1]) + "-"  + String(istr_app_email.app_id_list[1]) + "-" + String(istr_app_email.faci_id_list[1])
end if


//Start Code Change ----07.12.2017 #V154 maha
il_prac_id = istr_app_email.prac_id_list[1]  
il_facility = istr_app_email.faci_id_list[1] 
 //End Code Change ----07.12.2017
////Get Due Date
//ls_this = gnv_data.of_getitem("app_steps","find step", istr_app_email.action_type ) //finds this step number
//ll_next = long(gnv_data.of_getitem("app_steps","next step",ls_this)) //gets the next step number
//li_days = integer(gnv_data.of_getitem("app_steps","next days","lookup_code = " + string(ll_next))) 
//if li_days = 0 or isnull(li_days) then li_days = 30
//ld_due_date = RelativeDate(date( Today()), li_days )

dw_1.SetItem(1, 'assign_to', gs_user_id)
dw_1.SetItem(1, 'mail_from', gnv_docusign.is_emailaddress )
//dw_1.SetItem(1, 'due_date',  ld_due_date )
dw_1.SetItem(1, 'filename',  ls_filename )

Return 1

end function

public function integer of_check_data ();String ls_filename,ls_signer,ls_myemail,ls_sec_signer,ls_signtype,ls_message,ls_subject
long ll_row,ll_order,ll_check_order
string ls_role,ls_email,ls_signer_list,ls_cc_list,ls_signer_tmp,ls_cc_tmp

//Added By Jay Chen 04-10-2014 check signer and cc
ll_check_order = dw_1.getitemnumber(1,"check_order")
for ll_row = 1 to dw_2.rowcount()
	ll_order = dw_2.getitemnumber(ll_row,"order")
	ls_role = dw_2.getitemstring(ll_row,"role")
	ls_email = trim(dw_2.getitemstring(ll_row,"email"))
	if isnull(ls_role) then ls_role = ''
	if isnull(ls_email) then ls_email = ''
	if isnull(ll_order) then ll_order = 0
	if ls_role = '' then
		Messagebox('Check','Please input the Role.')
		dw_2.scrolltorow(ll_row)
		dw_2.setrow(ll_row)
		dw_2.Setcolumn('role')
		dw_2.SetFocus()
		Return -1
	end if
	if ls_email = '' then
		Messagebox('Check','Please input the Email.')
		dw_2.scrolltorow(ll_row)
		dw_2.setrow(ll_row)
		dw_2.Setcolumn('email')
		dw_2.SetFocus()
		Return -1
	end if
	if ll_check_order = 1 then
		if ll_order < 1 then
			Messagebox('Check','Order must be greater than zero.')
			dw_2.scrolltorow(ll_row)
			dw_2.setrow(ll_row)
			dw_2.Setcolumn('order')
			dw_2.SetFocus()
			Return -1
		end if
	end if
	//signer and cc mail list
	if not IsNull(ls_email) and Len(Trim(ls_email)) > 0 THEN
		if ll_check_order = 1 then ls_email = ls_email + '[' + string(ll_order) + ']'
		if ls_role = 'signer' then
			if Len(ls_signer_list) < 1 then 
				ls_signer_list = ls_email 
			else
				ls_signer_list += "; " + ls_email
			end if
		else
			if Len(ls_cc_list) < 1 then 
				ls_cc_list = ls_email 
			else
				ls_cc_list += "; " + ls_email
			end if
		end if
	end if
next

dw_1.setitem(1,"first_signer",ls_signer_list)
dw_1.setitem(1,"cc",ls_cc_list)

//Check File Name
ls_filename = dw_1.GetItemString(1,'filename')
If ls_filename = '' or isnull(ls_filename) Then
	Messagebox('Check','Please input the file name.')
	dw_1.Setcolumn('filename')
	dw_1.SetFocus()
	Return -1
End If

//Check Document
If dw_doc.rowcount() <= 0 Then
	Messagebox('Document','The document list is empty, please select a document and then check out again.')
	Return -2
End If
If dw_doc.GetItemNumber(dw_doc.rowcount(),'compute_sum') <= 0 Then
	Messagebox('Document','You must at least select one document for signature.')
	dw_doc.SetFocus()
	Return -3
End If
//Added By Jay Chen 04-30-2014
If dw_doc.GetItemNumber(dw_doc.rowcount(),'compute_sum') > 6 Then
	Messagebox('Document','You can at most select six documents for signature.')
	dw_doc.SetFocus()
	Return -3
End If

//Check To Signer
ls_signer = dw_1.GetItemString(1,'first_signer')
If ls_signer = '' or isnull(ls_signer) Then
	Messagebox('To Signer','Please input the To Signer Email Address.')
	dw_1.SetColumn('first_signer')
	dw_1.SetFocus()
	Return -4
End If

//Check Subject
ls_subject = dw_1.GetItemString(1,'email_subject')
If ls_subject = '' or isnull(ls_subject) Then
	Messagebox('Subject','The Suject can not be empty.')
	dw_1.SetColumn('email_subject')
	dw_1.SetFocus()
	Return -5
End If

//Check only non-signers can be added as CC
String ls_first_signer_arr[],ls_second_signer_arr[],ls_cc_arr[],ls_cc
Long i,j,k
ls_cc = dw_1.GetItemString(1,'cc')
inv_string.of_parsetoarray(ls_signer , ';', ls_first_signer_arr[])
inv_string.of_parsetoarray(ls_cc , ';', ls_cc_arr[])
For i = 1 To UpperBound(ls_cc_arr[])
	For j = 1 To UpperBound(ls_first_signer_arr[])
		If Lower(Trim(ls_cc_arr[i])) = Lower(Trim(ls_first_signer_arr[j])) Then
			Messagebox('CC',ls_cc_arr[i] + ' is already a signer, only non-signers can be added as CC for the request.')
			dw_1.SetColumn('cc')
			dw_1.SetFocus()				
			Return -6
		End If
	Next
Next

//Check 1st 
If Not inv_string.of_check_name(ls_signer,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	dw_1.SetColumn('first_signer')
	dw_1.SetFocus()
	Return -8
End If


////Check email message
//ls_message = dw_1.GetItemString(1,'email_message')
//If ls_message = '' or isnull(ls_message) Then
//	Messagebox('Message','Please input the message.')
//	dw_1.SetColumn('email_message')
//	dw_1.SetFocus()
//	Return -10
//End If
Return 1
end function

public function integer of_set_message (long al_email_id);Long ll_found,ll_rtn
String ls_attach_name,ls_autosign,ls_subject
n_cst_ctx_mail lnv_mail
Blob lblb_Message
long ll_export_id
n_cst_word_utility lnv_word
Boolean lb_new_export
DataStore lds_temp

IF al_email_id < 0 THEN RETURN 1

SetPointer(HourGlass!)

//Set attachment from email template
ll_found = idwc_email_template.Find('email_id = ' + String(al_email_id), 1, idwc_email_template.RowCount())
If ll_found <= 0 Then Return 1
ls_subject = idwc_email_template.GetItemString(ll_found, 'subject')
//dw_1.SetItem(1,'email_subject',ls_subject)  //Modified By Jay Chen 05-05-2014

//Get and open message from email template
lnv_mail.of_get_mail_template(al_email_id, lblb_Message)
ole_message.of_open(lblb_Message)	

//Merge field
ll_export_id = idwc_email_template.GetItemNumber(ll_found,'export_id')
If ll_export_id > 0 Then
	lnv_word = Create n_cst_word_utility
	lds_temp = Create DataStore
	If Not isvalid(ids_export) Then ids_export = Create DataStore
	If il_last_export_id <> ll_export_id Then
		il_last_export_id = ll_export_id
		lb_new_export = True
	Else
		lb_new_export = False
		lds_temp = ids_export
	End If
	ll_rtn = lnv_word.of_replace_export_word(ole_Message.Object.ActiveDocument, ls_subject,istr_app_email.prac_id_list[1] , ll_export_id, lds_temp, lb_new_export)
	If ll_rtn > 0 Then
		ids_export = lds_temp
	Else
		il_last_export_id = -1
	End If
End If
	
//Copy the message to datawindow
ole_Message.Object.ActiveDocument.Content.Select()
ole_Message.Object.ActiveDocument.ActiveWindow.Selection.Copy()
Dw_1.SetFocus()
dw_1.SetItem(1,'email_subject',ls_subject) //Added By Jay Chen 05-05-2014
dw_1.SetItem(1,'email_message','')
dw_1.Setcolumn('email_message')
dw_1.paste()
dw_1.AcceptText()
ole_Message.of_close()
dw_1.Setcolumn('email_message')
Clipboard ('')

If Not isvalid(ids_export) and isvalid(lds_temp) Then Destroy lds_temp //Don't destroy it always. because ids_export = lds_temp
Return 1




end function

public function integer of_readblob (string as_filename, ref blob ab_value);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_readblob()
// $<arguments>
//		value    	string	as_filename		:The specified file name.
//		reference	blob  	ab_value   		:The content of the specified file.
// $<returns> integer: 1 - Success;  -1 - Failure
// $<description>Read blob value of a specified file.
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 09.28.2008
//////////////////////////////////////////////////////////////////////
Long ll_FileLength, ll_readlength

if not fileexists(as_filename) then return -1

SetPointer(HourGlass!) 

//initilize variables
ll_FileLength = filelength(as_filename)
ab_value = Blob(Space(ll_FileLength),EncodingANSI!) //Modified By Ken.Guo 03/28/2012. EncodingANSI

//Read file to blob
//ll_readlength = AppeonReadFile(as_filename, ab_value, ll_FileLength)

int li_fnum,ll_bytes
li_fnum = FileOpen(as_filename, StreamMode!)
ll_bytes = FileReadEx(li_fnum, ab_value)
fileclose( li_fnum )

if ll_readlength < 0 then return -1

return 1

end function

public function boolean of_modify_field_font_color (string as_pathname);//====================================================================
// Function: of_modify_field_font_color
//--------------------------------------------------------------------
// Description: modify the {ds_ } field font color
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_pathname
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 06-29-2015
//--------------------------------------------------------------------
//	Copyright (c) 2008-2014 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

string ls_matchwildcards,ls_text,ls_new_pathname,ls_doc_ext
oleobject lole_word
boolean lb_found,lb_copy
long ll_begin,ll_end,ll_pos,ll_color
		
ls_matchwildcards = "\{ds_*\}" // means: "{ds_...}"   
lole_word = Create oleobject
//app_filler.of_set_word_safemode(false, 1) //Added By Ken.Guo 2015-07-30
if lole_word.Connecttonewobject("word.application") <> 0 then 
	//app_filler.of_set_word_safemode(false, 0) //Added By Ken.Guo 2015-07-30
	Destroy lole_word 
	return false
end if
//app_filler.of_set_word_safemode(false, 0) //Added By Ken.Guo 2015-07-30
	
lole_word.Visible = false
lole_word.Application.NormalTemplate.Saved = TRUE
lole_word.Application.Documents.Open(as_pathname,False,True)
gnv_word_utility.of_modify_word_property(lole_word.Activedocument)
lole_word.ActiveDocument.Content.Select()
if lole_word.ActiveWindow.Selection.Find.Execute(ls_matchwildcards, false, true, true ) then
	DO
		ls_text = lole_word.ActiveWindow.Selection.Text 
		ll_color = lole_word.ActiveDocument.Background.Fill.BackColor.RGB
		if isnull(ll_color) or ll_color = 0 then ll_color = 16777215
		lole_word.ActiveWindow.Selection.font.color = ll_color
//		ll_begin = lole_word.ActiveWindow.Selection.End
//		ll_end = lole_word.ActiveDocument.Content.End
//		IF ll_end > ll_begin THEN
//			lole_word.ActiveDocument.Range(ll_begin, ll_end).Select()			
			lb_found = lole_word.ActiveWindow.Selection.Find.Execute(ls_matchwildcards, false, true, true )			
//		ELSE
//			lb_found = FALSE
//		END IF
	LOOP WHILE( lb_found )
	lb_copy = true
end if	

if lb_copy then
	ll_pos = lastpos(as_pathname,'.')
	ls_doc_ext = right(as_pathname,len(as_pathname) - ll_pos)
	ls_new_pathname = left(as_pathname,ll_pos - 1) + '-docusign.' + ls_doc_ext
	gnv_rights.of_check_dir_right(ls_new_pathname, true, 'Word Save') //Added By Jay Chen 07-08-2015
	if FileExists(ls_new_pathname) then FileDelete(ls_new_pathname)
	lole_word.ActiveDocument.SaveAS(ls_new_pathname,0,false,'',false)
	//Added By Jay Chen 07-08-2015
	if not FileExists(ls_new_pathname) then
		gnv_debug.of_output(true, 'lole_word.ActiveDocument.saveas failed.' + ls_new_pathname )
		messagebox('Error','lole_word.ActiveDocument.saveas failed!')
	end if
	//end
end if

lole_word.ActiveDocument.Close(0)		
lole_word.Quit(0)
lole_word.DisconnectObject( )
If isvalid(lole_word) Then Destroy lole_word

if lb_copy then 
	return true
else
	return false
end if


end function

protected subroutine of_update_email_list (string as_column_name, string as_old_email_list, string as_new_email_list);Long i,j,ll_row,ll_find
String ls_arr_old[],ls_arr_new[],ls_new_userlist,ls_mailto
String ls_new_email_list
String ls_email



If isnull(as_old_email_list) Then as_old_email_list = ''
If isnull(as_new_email_list ) Then 
	ls_new_email_list = ''
Else
	ls_new_email_list = as_new_email_list
End If

inv_string.of_parsetoarray( as_old_email_list, ';', ls_arr_old[] ) 
inv_string.of_parsetoarray( ls_new_email_list, ';', ls_arr_new[] )

ls_mailto = as_old_email_list

If ls_new_email_list = '' Then Return

FOR i = 1 to UpperBound(ls_arr_new[]) 
	FOR j = 1 to UpperBound(ls_arr_old[])
		IF Upper(Trim(ls_arr_new[i])) = Upper(Trim(ls_arr_old[j])) THEN EXIT	
	NEXT
	//Skip the duplicated user
	IF j <= UpperBound(ls_arr_old) THEN CONTINUE
	//Keep the user in new user list
	IF Len(ls_new_userlist) < 1 THEN
		ls_new_userlist = ls_arr_new[i]
	ELSE
		ls_new_userlist += ';' + ls_arr_new[i]
	END IF
	//Added By Jay Chen 04-10-2014
	ls_email = ls_arr_new[i]
	ll_find = dw_2.find("email = '"+ ls_email +"'",1, dw_2.rowcount())
	if isnull(ll_find) then ll_find = 0
	if ll_find = 0 then
		ll_row = dw_2.insertrow(0)
		dw_2.setitem(ll_row,"order", 1)
		dw_2.setitem(ll_row,"email", ls_email)
		if as_column_name = "cc" then
			dw_2.setitem(ll_row,"role", "cc")
		else
			dw_2.setitem(ll_row,"role", "signer")
		end if
	end if
	//end add
NEXT
//Add them to current user list	
IF Len(ls_new_userlist) > 0 THEN 
	IF Len(Trim(ls_mailto)) > 0 And	Right(Trim(ls_mailto),1) <> ';' THEN ls_mailto = Righttrim(ls_mailto) + ';'
	ls_mailto = ls_mailto + ls_new_userlist
	dw_1.SetItem(1, as_column_name, ls_mailto)
END IF
/*
dw_1.SetItem(1, as_column_name + '_createlist', astr_alarm_user.s_create_list )

If lower(as_column_name) + '_createlist' <> 'cc_createlist' Then
	ls_appointment = dw_1.GetItemString( 1, 'alm_appointment' )//added by gavins 20121024
	//added by gavins 20121024
	If lower(as_column_name) + '_createlist' = 'first_signer_createlist' Then
		dw_1.SetItem(1, 'alm_appointment1', lower(astr_alarm_user.s_appointment   ))
	Else
		dw_1.SetItem(1, 'alm_appointment2', lower(astr_alarm_user.s_appointment   ))
	End If
	If Len(dw_1.getItemString( 1, 'alm_appointment1' ) ) > 1 And  Len( dw_1.getItemString( 1, 'alm_appointment2' )  ) > 1 Then
		dw_1.SetItem(1, 'alm_appointment', dw_1.getItemString( 1, 'alm_appointment1' ) + ';' + dw_1.getItemString( 1, 'alm_appointment2' ) )
	ElseIf Len(dw_1.getItemString( 1, 'alm_appointment1' ) ) > 1 Then
		dw_1.SetItem(1, 'alm_appointment', dw_1.getItemString( 1, 'alm_appointment1' ) )
	ElseIf Len(dw_1.getItemString( 1, 'alm_appointment2' ) ) > 1 Then
		dw_1.SetItem(1, 'alm_appointment', dw_1.getItemString( 1, 'alm_appointment2' ) )		
	End If
End If
*/
Return 
end subroutine

on w_app_docusign_request.create
int iCurrent
call super::create
this.ole_edit=create ole_edit
this.ole_message=create ole_message
this.cb_custom=create cb_custom
this.cb_cancel=create cb_cancel
this.dw_doc=create dw_doc
this.cb_send=create cb_send
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_edit
this.Control[iCurrent+2]=this.ole_message
this.Control[iCurrent+3]=this.cb_custom
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.dw_doc
this.Control[iCurrent+6]=this.cb_send
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_1
end on

on w_app_docusign_request.destroy
call super::destroy
destroy(this.ole_edit)
destroy(this.ole_message)
destroy(this.cb_custom)
destroy(this.cb_cancel)
destroy(this.dw_doc)
destroy(this.cb_send)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event pfc_preopen;call super::pfc_preopen;inv_filesrv = n_cst_filesrvwin32 

istr_app_email = Message.Powerobjectparm
dw_1.InsertRow(0)
If of_download_doc() < 0 Then 
	//Close(This)
	ib_open = false
else
	ib_open = true
END IF
end event

event open;call super::open;gs_email_address lst_email
string ls_email
String ls_send

//Added By Jay Chen 10-15-2013
if not ib_open then
	CloseWithReturn(This, 0)
	Return
End If

//Set Sertifi data  
If of_set_sertifi() < 1 Then 
	CloseWithReturn(This, 0)
	Return
End If

//Set document list
of_set_documents()

//Retrieve the email templates
dw_1.getchild('email_template',idwc_email_template)
idwc_email_template.SetTransObject(SQLCA)

//Retrieve User
datawindowchild ldwc_user
dw_1.getchild('assign_to',ldwc_user)
ldwc_user.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	idwc_email_template.Retrieve()
	ldwc_user.Retrieve()
gnv_appeondb.of_commitqueue( )

//Start Code Change ----07.12.2017 #V154 maha - get prac email addresses
lst_email = of_get_prac_email(il_prac_id, "M", il_facility)
ls_email = lst_email.s_email[1]

if len(ls_email) > 0 then
	dw_2.insertrow(1)
	dw_2.SetItem(1,'email',ls_email)
	dw_2.SetItem(1,'order', 1)
	dw_2.SetItem(1,'role','signer')
end if
//End Code Change ----07.12.2017

//Set Sender Display Name
ls_send = gs_user_id

dw_1.SetItem(1,'sender',ls_send)


inv_filesrv = Create n_cst_filesrvwin32

dw_doc.modify("need_signed_t.visible = false")
dw_doc.modify("need_signed.visible = false")

is_order_x = dw_2.describe("order.x")
is_role_x = dw_2.describe("role.x")
is_email_x = dw_2.describe("email.x")
end event

event close;call super::close;If isvalid(ids_export) Then Destroy ids_export
If isvalid(inv_filesrv) Then Destroy inv_filesrv
end event

type ole_edit from olecustomcontrol within w_app_docusign_request
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
boolean visible = false
integer x = 1111
integer y = 1756
integer width = 114
integer height = 132
integer taborder = 70
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_app_docusign_request.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_message from u_email_edit within w_app_docusign_request
boolean visible = false
integer x = 974
integer y = 2372
integer width = 151
integer height = 116
integer taborder = 40
string binarykey = "w_app_docusign_request.win"
integer binaryindex = 1
end type

type cb_custom from commandbutton within w_app_docusign_request
boolean visible = false
integer x = 41
integer y = 2500
integer width = 411
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Custom &Fields..."
end type

event clicked;
str_parm lstr_parm,lstr_parm_new

dw_1.AcceptText()

lstr_parm.s_array[1] = dw_1.GetItemString(1, 'custom_1')
lstr_parm.s_array[2] = dw_1.GetItemString(1, 'custom_2')
lstr_parm.s_array[3] = dw_1.GetItemString(1, 'custom_3')

OpenWithParm(w_dm_sertifi_custom_fields,lstr_parm)

If Isvalid(Message.powerobjectparm) Then
	lstr_parm_new = Message.powerobjectparm
	dw_1.SetItem(1,'custom_1',lstr_parm_new.s_array[1])
	dw_1.SetItem(1,'custom_2',lstr_parm_new.s_array[2])
	dw_1.SetItem(1,'custom_3',lstr_parm_new.s_array[3])
End If







end event

type cb_cancel from commandbutton within w_app_docusign_request
integer x = 2519
integer y = 1776
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type dw_doc from u_dw within w_app_docusign_request
integer x = 777
integer y = 156
integer width = 1984
integer height = 180
integer taborder = 40
string title = "none"
string dataobject = "d_app_docusign_doc_request"
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

type cb_send from commandbutton within w_app_docusign_request
integer x = 2158
integer y = 1776
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Send"
end type

event clicked;Long i,li_create_ai,ll_pos
String ls_fileID,ls_docid,ls_ret,ls_1stsigner[], ls_2ndsigner[],ls_ccarray[]
Blob lb_file,lb_download,lb_null,lb_file1,lb_file2,lb_file3,lb_file4,lb_file5,lb_file6
Boolean lb_result = True
String ls_filename,ls_emailfrom,ls_first_signer,ls_second_signer,ls_cc,ls_message
String ls_custom_1,ls_custom_2,ls_custom_3,ls_sender
Datetime ldt_duedate
w_appeon_gifofwait lw_appeon_gifofwait
String ls_1st_createlist,ls_2nd_createlist, ls_cc_createlist, ls_createlist, ls_ai_array[]
String							ls_AppointmentList, ls_to_AppointmentList[]
String							ls_errtext, ls_email_type, ls_computer_info, ls_ctxidlist, ls_docidlist, ls_xml
n_cst_easymail_smtp 	lnv_Mail
Long							ll_Return, li_send_result, ll_email_template_id
Long							ll_ctx_id_list[]
tns__referencedocumentpermission ltns__referencedocumentpermission[]
tns__docusignfile ltns_files
string ls_docname,ls_dockeys,ls_dockeystemp,ls_error,ls_subject,ls_docext,ls_template_id
long ll_rtn,ll_use_template
tns__status ltns__status
tns__docusigneddocument ltns__docusigneddocument
boolean lb_fail = false,lb_modify_color = false
string ls_new_pathname
long ll_fileread_rtn
string ls_hide_tag

dw_1.AcceptText()
dw_doc.AcceptText()
dw_2.accepttext()

SetPointer(HourGlass!)

//Check Data
If of_check_data() < 0 Then Return

ls_filename = dw_1.getitemString(1,'filename')
ls_emailfrom = dw_1.getitemString(1,'mail_from')
ls_first_signer = dw_1.getitemString(1,'first_signer')
ls_cc = dw_1.getitemString(1,'cc') 
ls_hide_tag = gnv_user_option.of_Get_option_value( gs_user_id, "hide_docusign_tag" ) //Added By Jay Chen 07-09-2015
if isnull(ls_hide_tag) or ls_hide_tag = '' then ls_hide_tag = '0'

//Added By Jay Chen 06-12-2015
ll_use_template = dw_1.getitemnumber(1, "use_template")
if isnull(ll_use_template) then ll_use_template = 0
if ll_use_template = 1 then 
	ls_template_id = dw_1.getitemstring(1, "template_id")
	if isnull(ls_template_id) then ls_template_id = ''
	if ls_template_id = '' then
		Messagebox('Information','Please choose the Location Template.')
		dw_1.SetFocus()
		dw_1.Setcolumn('template_id')
		Return 
	end if
end if
//end 

//Get Create List for Signer
ls_1st_createlist = dw_1.getitemString(1,'first_signer_createlist')
ls_cc_createlist = dw_1.getitemString(1,'cc_createlist')
If Len( ls_1st_createlist  ) > 0 Then
	ls_createlist = ls_1st_createlist
End If
If Len( ls_cc_createlist  ) > 0 Then
	If ls_createlist <> '' Then
		ls_createlist = ls_createlist + ';' +  ls_cc_createlist
	Else
		ls_createlist = ls_cc_createlist
	End If
End If
inv_string.of_parsetoarray( ls_createlist, ';', ls_ai_array[])
inv_string.of_delete_duplicate( ls_ai_array[])
istr_app_email.as_user_arr[] = ls_ai_array[]

//Get Sign info
ls_message = dw_1.getitemString(1,'email_message') 
ls_subject = dw_1.getitemString(1,'email_subject')
istr_app_email.ai_create_ai = dw_1.getitemnumber(1,'create_action_item')
istr_app_email.adt_duedate = dw_1.getitemdatetime(1,'due_date')
ls_sender = dw_1.getitemString(1,'sender')

ll_email_template_id = dw_1.GetItemNumber(1,'Email_Template')
ls_AppointmentList = dw_1.GetItemString(1,'alm_appointment')
ldt_duedate = istr_app_email.adt_duedate

If isnull(ls_cc) Then ls_cc = ''
If isnull(ls_message) Then ls_message = ''
If isnull(ls_sender) Then ls_sender = ''

istr_app_email.as_mail_from = ls_emailfrom
istr_app_email.as_sender = ls_sender

//Added By Ken.Guo 12/09/2011. Convert email list format. user single quote, replaced doule quote.
inv_string.of_parsetoarray( ls_first_signer, ';', ls_1stsigner[] )
inv_string.of_arraytostring(ls_1stsigner[], ',', ls_first_signer)

inv_string.of_parsetoarray( ls_cc, ';', ls_ccarray[] )
inv_string.of_arraytostring(ls_ccarray[], ',', ls_cc)

//Added By Jay Chen 04-30-2014 Remark: support sign multi document once
For i = 1 to dw_doc.rowcount()
	ls_docname =  dw_doc.getitemstring(i,"docname")
	ll_pos = lastpos(ls_docname,'.')
	ls_docext = right(ls_docname,len(ls_docname) - ll_pos)
	//Added By Jay Chen 06-29-2015
	if lower(ls_docext) = 'doc' or lower(ls_docext) = 'docx' then 
		if ls_hide_tag = '1' then
			lb_modify_color = of_modify_field_font_color(istr_app_email.pathfilename_list[i]) 
		else
			lb_modify_color = false
		end if
	else
		lb_modify_color = false
	end if
	ls_new_pathname = left(istr_app_email.pathfilename_list[i],lastpos(istr_app_email.pathfilename_list[i],'.') - 1) + '-docusign.' + ls_docext
	//Added By Jay Chen 07-08-2015
	if lb_modify_color then
		if not FileExists (ls_new_pathname) then
			Messagebox('Error','Failed to generate the temp docusign file for ' + istr_app_email.pathfilename_list[i] + '.')
			gnv_debug.of_output(true, 'Failed to generate the temp docusign file for ' + istr_app_email.pathfilename_list[i] + '.')
			return -1
		end if
	end if
	//end
	if AppeonGetClientType() = 'PB' then
		lb_file = lb_null
		//Added By Jay Chen 06-29-2015
		if lb_modify_color then
			ll_fileread_rtn = inv_filesrv.of_fileread(ls_new_pathname , lb_file)
		else
			ll_fileread_rtn = inv_filesrv.of_fileread( istr_app_email.pathfilename_list[i] , lb_file)
		end if
		//end 
		If ll_fileread_rtn < 0 Then 
			If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
			Messagebox('Error','Failed to open the document ' + istr_app_email.pathfilename_list[i] + '.')
			Return -1
		End If
	else
		choose case i
			case 1
//				ll_rtn = inv_filesrv.of_fileread( istr_ctx_email.pathfilename_list[i] , lb_file1) 
				//Added By Jay Chen 06-29-2015
				if lb_modify_color then
					ll_rtn = inv_filesrv.of_fileread( ls_new_pathname , lb_file1) 
				else
					ll_rtn = inv_filesrv.of_fileread( istr_app_email.pathfilename_list[i] , lb_file1) 
				end if
				//end 
			case 2
//				ll_rtn = inv_filesrv.of_fileread( istr_ctx_email.pathfilename_list[i] , lb_file2) 
				//Added By Jay Chen 06-29-2015
				if lb_modify_color then
					ll_rtn = inv_filesrv.of_fileread( ls_new_pathname , lb_file2) 
				else
					ll_rtn = inv_filesrv.of_fileread( istr_app_email.pathfilename_list[i] , lb_file2) 
				end if
				//end 
			case 3
//				ll_rtn = inv_filesrv.of_fileread( istr_ctx_email.pathfilename_list[i] , lb_file3) 
				//Added By Jay Chen 06-29-2015
				if lb_modify_color then
					ll_rtn = inv_filesrv.of_fileread( ls_new_pathname , lb_file3) 
				else
					ll_rtn = inv_filesrv.of_fileread( istr_app_email.pathfilename_list[i] , lb_file3) 
				end if
				//end 
			case 4
//				ll_rtn = inv_filesrv.of_fileread( istr_ctx_email.pathfilename_list[i] , lb_file4) 
				//Added By Jay Chen 06-29-2015
				if lb_modify_color then
					ll_rtn = inv_filesrv.of_fileread( ls_new_pathname , lb_file4) 
				else
					ll_rtn = inv_filesrv.of_fileread( istr_app_email.pathfilename_list[i] , lb_file4) 
				end if
				//end 
			case 5
//				ll_rtn = inv_filesrv.of_fileread( istr_ctx_email.pathfilename_list[i] , lb_file5) 
				//Added By Jay Chen 06-29-2015
				if lb_modify_color then
					ll_rtn = inv_filesrv.of_fileread( ls_new_pathname , lb_file5) 
				else
					ll_rtn = inv_filesrv.of_fileread( istr_app_email.pathfilename_list[i] , lb_file5) 
				end if
				//end 
			case 6
//				ll_rtn = inv_filesrv.of_fileread( istr_ctx_email.pathfilename_list[i] , lb_file6) 
				//Added By Jay Chen 06-29-2015
				if lb_modify_color then
					ll_rtn = inv_filesrv.of_fileread( ls_new_pathname , lb_file6) 
				else
					ll_rtn = inv_filesrv.of_fileread( istr_app_email.pathfilename_list[i] , lb_file6) 
				end if
				//end 
		end choose
		If ll_rtn < 0 Then 
			If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
			Messagebox('Error','Failed to open the document ' + istr_app_email.pathfilename_list[i] + '.')
			Return -1
		End If
	end if
	ltns_files.filename[i] = ls_docname
	ltns_files.fileextension[i] = ls_docext
	istr_app_email.as_sertifi_docid[upperbound(istr_app_email.as_sertifi_docid) + 1] = string(i)   
	if AppeonGetClientType() = 'PB' then	
		ltns_files.ltbtfile[i] = lb_file
		ltns_files.filecount = 0
	else
		choose case i
			case 1
				ltns_files.ltbtfile0 = lb_file1
			case 2
				ltns_files.ltbtfile1 = lb_file2
			case 3
				ltns_files.ltbtfile2 = lb_file3
			case 4
				ltns_files.ltbtfile3 = lb_file4
			case 5
				ltns_files.ltbtfile4 = lb_file5
			case 6
				ltns_files.ltbtfile5 = lb_file6
		end choose
		ltns_files.filecount = i
	end if
next
//end add


//Files
//For i = 1 to dw_doc.rowcount()
//	ls_docname =  dw_doc.getitemstring(i,"docname")
//	ll_pos = lastpos(ls_docname,'.')
//	ls_docext = right(ls_docname,len(ls_docname) - ll_pos)
//	lb_file = lb_null
//	If inv_filesrv.of_fileread( istr_ctx_email.pathfilename_list[i] , lb_file) < 0 Then 
//		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
//		Messagebox('Error','Failed to open the document ' + istr_ctx_email.pathfilename_list[i] + '.')
//		Return -1
//	End If

	If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Sending the signature request...")		
	Try
		//Create Request 
//		ls_dockeystemp = gnv_docusign.isoap_docusign.createandsendenvelope(gnv_docusign.is_username,gnv_docusign.is_password, gnv_docusign.is_apicode,gnv_docusign.is_userid,gnv_docusign.is_acctid,ls_subject,ls_message,ls_first_signer,ls_cc,ls_docname,ls_docext,lb_file) //Added By Jay Chen 04-09-2014
		if ll_use_template = 1 then //Added By Jay Chen 06-15-2015
			ltns__status = gnv_docusign.isoap_docusign.createenvelopefromtemplates(gnv_docusign.is_username,gnv_docusign.is_password, gnv_docusign.is_apicode,gnv_docusign.is_acctid,ls_template_id,ls_subject,ls_message, ls_first_signer,ls_cc, true, ltns_files)
			ls_dockeystemp = ltns__status.envelopeid
			if len(ltns__status.errortext) > 0 then
				lb_fail = true
			end if
		else
			ls_dockeystemp = gnv_docusign.isoap_docusign.createandsendenvelope(gnv_docusign.is_username,gnv_docusign.is_password, gnv_docusign.is_apicode,gnv_docusign.is_userid,gnv_docusign.is_acctid,ls_subject,ls_message,ls_first_signer,ls_cc,ltns_files)
		end if
		If lower(Left(ls_dockeystemp,5)) = 'error'  or ls_dockeystemp = '-1' or lb_fail Then
			if lb_fail then
				ls_error = ltns__status.errortext
			else
				ls_error = ls_dockeystemp
			end if
			if len(ls_error) > 197 then ls_error = left(ls_error,197) + '...' //Added By Jay Chen 11-07-2013
			If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
			gnv_debug.of_output(true, 'send document: [' + ls_docname +'] error:'+ ls_dockeystemp)
			if len(ls_error) > 197 then //Modified By Jay Chen 11-14-2013
				Messagebox('Error','Failed to send the documents request, please see the error log.~r~n'+ls_error+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
			else
				Messagebox('Error','Failed to send the documents request.~r~n'+ls_error+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
			end if
			Return 
		End If
		ls_dockeys = ls_dockeys + ls_dockeystemp
	Catch (RuntimeError  e1) 
		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
		gnv_debug.of_output(true, 'send document: [' + ls_docname +'] error:'+ e1.Text)
		Messagebox('Error',e1.Text+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
		Return -1
	End Try
//Next

//Get link
str_sertifi_doc lstr_sertifi_doc
lstr_sertifi_doc.as_es_docid = istr_app_email.as_sertifi_docid[1]
lstr_sertifi_doc.as_es_fileid = ls_dockeystemp
lstr_sertifi_doc.as_es_apicode = gnv_docusign.is_apicode
istr_app_email.as_sertifi_link =  gnv_docusign.of_get_doc_maintance_link(lstr_sertifi_doc)

if trim(ls_dockeys) = "-1"  Then
	ls_error = ls_dockeystemp
	if len(ls_error) > 197 then ls_error = left(ls_error,197) + '...' //Added By Jay Chen 11-07-2013
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	gnv_debug.of_output(true, 'send document: [' + ls_docname +'] error:'+ ls_dockeystemp)
	if len(ls_error) > 197 then //Modified By Jay Chen 11-14-2013
		Messagebox('Error','Failed to send the documents request, please see the error log.~r~n'+ls_error+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	else
		Messagebox('Error','Failed to send the documents request.~r~n'+ls_error+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	end if
	Return 
end if


	
SetPointer(Arrow!)
If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
//Close

//istr_ctx_email.as_sertifi_fileid = ls_filename //Added By Jay Chen 10-12-2013
istr_app_email.as_sertifi_fileid = ls_dockeystemp  //Modified By Jay Chen 04-30-2014
CloseWithReturn(Parent,istr_app_email)
end event

type dw_2 from u_dw within w_app_docusign_request
integer x = 777
integer y = 356
integer width = 1984
integer height = 628
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_am_docusign_email"
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

type dw_1 from u_dw within w_app_docusign_request
integer x = 32
integer y = 24
integer width = 2848
integer height = 1716
integer taborder = 20
string title = "none"
string dataobject = "d_app_docusign_request"
boolean vscrollbar = false
end type

event constructor;call super::constructor;This.of_setupdateable(false)
This.Post of_setdropdowncalendar(True)

end event

event itemchanged;call super::itemchanged;If dwo.name = 'email_template' Then
	If isnumber(data) Then
		Parent.of_set_message( Long(data))
	End If
End If


if dwo.name = "check_order" then
	If long(data) = 1 Then
		dw_2.Modify("order_t.visible = true")
		dw_2.Modify("order.visible = true")
		dw_2.Modify("order_t.x = '"+ is_order_x +"'")
		dw_2.Modify("order.x = '"+ is_order_x +"'")
		dw_2.Modify("role_t.x = '"+ is_role_x +"'")
		dw_2.Modify("role.x = '"+ is_role_x +"'")
		dw_2.Modify("email_t.x = '"+ is_email_x +"'")
		dw_2.Modify("email.x = '"+ is_email_x +"'")
	Else
		dw_2.Modify("order_t.visible = false")
		dw_2.Modify("order.visible = false")
		dw_2.Modify("role_t.x = '"+ is_order_x +"'")
		dw_2.Modify("role.x = '"+ is_order_x +"'")
		dw_2.Modify("email_t.x = '"+ is_role_x +"'")
		dw_2.Modify("email.x = '"+ is_role_x +"'")
	End If
end if

//Added By Jay Chen 06-15-2015 get all templates list of current user
long ll_row,ll_cnt
string ls_template_name,ls_template_id,ls_error
datawindowchild ldwc_template
tns__docusigntemplates ltns__docusigntemplates

if dwo.name = "use_template" and long(data) = 1 then
	ltns__docusigntemplates = gnv_docusign.isoap_docusign.requesttemplates(gnv_docusign.is_username,gnv_docusign.is_password,gnv_docusign.is_apicode,gnv_docusign.is_acctid,true)
	ls_error = ltns__docusigntemplates.errortext
	If len(ls_error) > 0 Then
		Messagebox('Error','Failed to request the docusign template information.~r~n' + ls_error)
		return -1
	end if
	dw_1.getchild('template_id',ldwc_template)
	ldwc_template.reset()
	for ll_cnt = 1 to UpperBound(ltns__docusigntemplates.templateid[])
		ls_template_id = ltns__docusigntemplates.templateid[ll_cnt]
		ls_template_name = ltns__docusigntemplates.templatename[ll_cnt]
		ll_row = ldwc_template.insertrow(0)
		ldwc_template.setitem(ll_row, "template_id", ls_template_id)
		ldwc_template.setitem(ll_row, "template_name", ls_template_name)
	next
	ldwc_template.setsort("template_name")
	ldwc_template.sort()
end if
end event

event buttonclicked;call super::buttonclicked;str_alarm_user	lstr_alarm
String ls_columnname, ls_email_list,ls_email_list_temp,ls_email_arr[],ls_email_column
n_cst_string lnv_string
long ll_row

ls_columnname = dwo.name
dw_1.AcceptText()

Choose Case ls_columnname
	Case 'b_first'
		ls_email_column = 'first_signer'
	Case 'b_second'
		ls_email_column = 'second_signer'
	Case 'b_cc'
		ls_email_column = 'cc'
End Choose


Choose Case ls_columnname
	Case 'b_first','b_second','b_cc'
		
		ls_email_list = This.GetItemString(row,ls_email_column)
		
		OpenWithParm(w_alarm_users, "NotSelectIC!")

		ls_email_list_temp = Message.StringParm
		if LenA(Trim(ls_email_list_temp)) > 0  then
			of_update_email_list(ls_email_column,ls_email_list,ls_email_list_temp)
		end if		
End Choose

//Added By Jay Chen 04-10-2014
if dwo.name = 'b_add' then
	ll_row = dw_2.insertrow(0)
	dw_2.setitem(ll_row,"order",1)
	dw_2.setitem(ll_row,"role","signer") //Added By Jay Chen 05-28-2014
	dw_2.scrolltorow(ll_row)
	dw_2.setrow(ll_row)
	dw_2.setfocus()
	dw_2.setcolumn("email")
end if
if  dwo.name = 'b_delete' then
	ll_row = dw_2.getrow()
	dw_2.deleterow(ll_row)
end if


end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
01w_app_docusign_request.bin 
2B00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000057a70ba001d2fb2600000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c0000000057a70ba001d2fb2657a70ba001d2fb26000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc000000030002000500000003000002950000000300000369000000030000006000000002000000010000001e0000000945676d493174696400000000000000032ffffffe0000000b0000ffff000000020000bb1c000000020000bb1c000000030018bb6c000000030018bb6c0000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500000295000003690000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100bbb000001000bbb0100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000057a70ba001d2fb2600000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000057a70ba001d2fb2657a70ba001d2fb260000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00000369000002ff00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00000369000002ff00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f007200700075000000500034004300430035
2500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b40000000100000000000000000000000000000000000000000000000100000000000000000000000100000000008000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11w_app_docusign_request.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
