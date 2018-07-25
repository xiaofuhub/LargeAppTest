$PBExportHeader$w_app_sertifi_request.srw
forward
global type w_app_sertifi_request from w_response
end type
type ole_edit from olecustomcontrol within w_app_sertifi_request
end type
type ole_message from u_email_edit within w_app_sertifi_request
end type
type cb_custom from commandbutton within w_app_sertifi_request
end type
type cb_cancel from commandbutton within w_app_sertifi_request
end type
type dw_doc from u_dw within w_app_sertifi_request
end type
type dw_1 from u_dw within w_app_sertifi_request
end type
type cb_send from commandbutton within w_app_sertifi_request
end type
end forward

global type w_app_sertifi_request from w_response
integer width = 2921
integer height = 1860
string title = "Send For Electronic Signature"
long backcolor = 33551856
ole_edit ole_edit
ole_message ole_message
cb_custom cb_custom
cb_cancel cb_cancel
dw_doc dw_doc
dw_1 dw_1
cb_send cb_send
end type
global w_app_sertifi_request w_app_sertifi_request

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
end variables

forward prototypes
public function integer of_download_doc ()
public subroutine of_set_documents ()
public function integer of_set_sertifi ()
public function integer of_check_data ()
public function integer of_set_message (long al_email_id)
protected subroutine of_update_email_list (string as_column_name, string as_old_email_list, string as_new_email_list)
end prototypes

public function integer of_download_doc ();//Download Documents from table of net_dev_action_images
Long i, f
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
	If UpperBound(ls_pathfile[]) > 0 Then
		If Not FileExists(ls_pathfile[i]) Then
			Messagebox('Check Document','Failed to download the document (rec_id = '+String(istr_app_email.rec_id_list[i])+', prac_id = '+String(istr_app_email.prac_id_list[i])+')')
			Return -1
		End If
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

public function integer of_set_sertifi ();String ls_filename
string ls_this
long ll_next
Int li_days
date ld_due_date

If Not gnv_sertifi.of_check_sertifi( ) Then Return -1  

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
dw_1.SetItem(1, 'mail_from', gnv_sertifi.is_emailaddress )
//dw_1.SetItem(1, 'due_date', ld_due_date )
dw_1.SetItem(1, 'filename',  ls_filename )

Return 1

end function

public function integer of_check_data ();String ls_filename,ls_signer,ls_myemail,ls_sec_signer

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

//Check First Signer
ls_signer = dw_1.GetItemString(1,'first_signer')
If ls_signer = '' or isnull(ls_signer) Then
	Messagebox('First Signer','Please input the First Signer Email Address.')
	dw_1.SetColumn('first_signer')
	dw_1.SetFocus()
	Return -4
End If

//Check Mail From
ls_myemail = dw_1.GetItemString(1,'mail_from')
If ls_myemail = '' or isnull(ls_myemail) Then
	Messagebox('Mail From','The Mail From can not be empty.')
	dw_1.SetColumn('mail_from')
	dw_1.SetFocus()
	Return -5
End If

//Check only non-signers can be added as CC
String ls_first_signer_arr[],ls_second_signer_arr[],ls_cc_arr[],ls_cc
Long i,j,k
ls_sec_signer = dw_1.GetItemString(1,'second_signer')
ls_cc = dw_1.GetItemString(1,'cc')
inv_string.of_parsetoarray(ls_signer , ';', ls_first_signer_arr[])
inv_string.of_parsetoarray(ls_sec_signer , ';', ls_second_signer_arr[])
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
	
	For j = 1 To UpperBound(ls_second_signer_arr[])
		If Lower(Trim(ls_cc_arr[i])) = Lower(Trim(ls_second_signer_arr[j])) Then
			Messagebox('CC',ls_cc_arr[i] + ' is already a signer, only non-signers can be added as CC for the request.')
			dw_1.SetColumn('cc')
			dw_1.SetFocus()			
			Return -7
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

//Check 2nd
If Not inv_string.of_check_name(ls_sec_signer,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	dw_1.SetColumn('second_signer')
	dw_1.SetFocus()
	Return -9
End If


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

protected subroutine of_update_email_list (string as_column_name, string as_old_email_list, string as_new_email_list);Long i,j
String ls_arr_old[],ls_arr_new[],ls_new_userlist,ls_mailto
String ls_new_email_list



If isnull(as_old_email_list) Then as_old_email_list = ''
If isnull(as_new_email_list) Then 
	ls_new_email_list = ''
Else
	ls_new_email_list = as_new_email_list
End If

If ls_new_email_list = '' Then Return

inv_string.of_parsetoarray( as_old_email_list, ';', ls_arr_old[] ) 
inv_string.of_parsetoarray( ls_new_email_list, ';', ls_arr_new[] )

ls_mailto = as_old_email_list


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
NEXT
//Add them to current user list	
IF Len(ls_new_userlist) > 0 THEN 
	IF Len(Trim(ls_mailto)) > 0 And	Right(Trim(ls_mailto),1) <> ';' THEN ls_mailto = Righttrim(ls_mailto) + ';'
	ls_mailto = ls_mailto + ls_new_userlist
	dw_1.SetItem(1, as_column_name, ls_mailto)
END IF


Return 
end subroutine

on w_app_sertifi_request.create
int iCurrent
call super::create
this.ole_edit=create ole_edit
this.ole_message=create ole_message
this.cb_custom=create cb_custom
this.cb_cancel=create cb_cancel
this.dw_doc=create dw_doc
this.dw_1=create dw_1
this.cb_send=create cb_send
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_edit
this.Control[iCurrent+2]=this.ole_message
this.Control[iCurrent+3]=this.cb_custom
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.dw_doc
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cb_send
end on

on w_app_sertifi_request.destroy
call super::destroy
destroy(this.ole_edit)
destroy(this.ole_message)
destroy(this.cb_custom)
destroy(this.cb_cancel)
destroy(this.dw_doc)
destroy(this.dw_1)
destroy(this.cb_send)
end on

event pfc_preopen;call super::pfc_preopen;inv_filesrv = n_cst_filesrvwin32 

istr_app_email = Message.Powerobjectparm
dw_1.InsertRow(0)
If of_download_doc() < 0 Then Close(This)
end event

event open;call super::open;gs_email_address lst_email
string ls_email
String ls_send

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

//Start Code Change ----07.12.2017 #V154 maha - get prac email addresses
lst_email = of_get_prac_email(il_prac_id, "M", il_facility)
ls_email = lst_email.s_email[1]

if len(ls_email) > 0 then
	dw_1.SetItem(1,'first_signer',ls_email)
end if
//End Code Change ----07.12.2017


gnv_appeondb.of_startqueue( )
	idwc_email_template.Retrieve()
	ldwc_user.Retrieve()
gnv_appeondb.of_commitqueue( )

//Set Sender Display Name
ls_send = gs_user_id

dw_1.SetItem(1,'sender',ls_send)


inv_filesrv = Create n_cst_filesrvwin32
end event

event close;call super::close;If isvalid(ids_export) Then Destroy ids_export
If isvalid(inv_filesrv) Then Destroy inv_filesrv
end event

type ole_edit from olecustomcontrol within w_app_sertifi_request
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
integer x = 1353
integer y = 1664
integer width = 123
integer height = 88
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_app_sertifi_request.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_message from u_email_edit within w_app_sertifi_request
boolean visible = false
integer x = 969
integer y = 2900
integer width = 101
integer height = 100
integer taborder = 30
string binarykey = "w_app_sertifi_request.win"
integer binaryindex = 1
end type

type cb_custom from commandbutton within w_app_sertifi_request
integer x = 41
integer y = 1652
integer width = 411
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
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

type cb_cancel from commandbutton within w_app_sertifi_request
integer x = 2519
integer y = 1652
integer width = 343
integer height = 92
integer taborder = 20
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

type dw_doc from u_dw within w_app_sertifi_request
integer x = 791
integer y = 156
integer width = 1984
integer height = 168
integer taborder = 20
string title = "none"
string dataobject = "d_app_sertifi_doc_request"
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

type dw_1 from u_dw within w_app_sertifi_request
integer x = 32
integer y = 24
integer width = 2848
integer height = 1588
integer taborder = 10
string title = "none"
string dataobject = "d_app_sertifi_request"
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

end event

event buttonclicked;call super::buttonclicked;String ls_columnname, ls_email_list,ls_email_list_temp,ls_email_column
n_cst_string lnv_string

ls_columnname = dwo.name

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
		IF LenA(Trim(ls_email_list_temp)) > 0 THEN 
			of_update_email_list(ls_email_column,ls_email_list,ls_email_list_temp)
		end if		
End Choose

end event

type cb_send from commandbutton within w_app_sertifi_request
integer x = 2158
integer y = 1652
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

event clicked;Long i,li_create_ai
String ls_fileID,ls_docid,ls_ret,ls_1stsigner[], ls_2ndsigner[],ls_ccarray[]
Blob lb_file,lb_download,lb_null
Boolean lb_result = True
String ls_filename,ls_emailfrom,ls_first_signer,ls_second_signer,ls_cc,ls_message,ls_sign_type
String ls_custom_1,ls_custom_2,ls_custom_3,ls_sender
Datetime ldt_duedate
w_appeon_gifofwait lw_appeon_gifofwait
Long	ll_Return, li_send_result, ll_email_template_id
String	ls_xml
tns__referencedocumentpermission ltns__referencedocumentpermission[]

dw_1.AcceptText()
dw_doc.AcceptText()

SetPointer(HourGlass!)

//Check Data
If of_check_data() < 0 Then Return

ls_filename = dw_1.getitemString(1,'filename')
ls_emailfrom = dw_1.getitemString(1,'mail_from')
ls_first_signer = dw_1.getitemString(1,'first_signer')
ls_second_signer = dw_1.getitemString(1,'second_signer')
ls_cc = dw_1.getitemString(1,'cc') 



//Get Sign info
ls_message = dw_1.getitemString(1,'email_message') 
ls_sign_type = dw_1.getitemString(1,'sign_type') 
ls_custom_1 = dw_1.getitemString(1,'custom_1') 
ls_custom_2 = dw_1.getitemString(1,'custom_2') 
ls_custom_3 = dw_1.getitemString(1,'custom_3') 
//istr_app_email.ai_create_ai = dw_1.getitemnumber(1,'create_action_item')
istr_app_email.adt_duedate = dw_1.getitemdatetime(1,'due_date')
ls_sender = dw_1.getitemString(1,'sender')

ll_email_template_id = dw_1.GetItemNumber(1,'Email_Template')

//ldt_duedate = istr_app_email.adt_duedate

If isnull(ls_second_signer) Then ls_second_signer = ''
If isnull(ls_cc) Then ls_cc = ''
If isnull(ls_message) Then ls_message = ''
If isnull(ls_sign_type) Then ls_sign_type = ''
If isnull(ls_custom_1) Then ls_custom_1 = ''
If isnull(ls_custom_2) Then ls_custom_2 = ''
If isnull(ls_custom_3) Then ls_custom_3 = ''
If isnull(ls_sender) Then ls_sender = ''

istr_app_email.as_mail_from = ls_emailfrom
istr_app_email.as_sender = ls_sender

// Convert email list format. user single quote, replaced doule quote.
inv_string.of_parsetoarray( ls_first_signer, ';', ls_1stsigner[] )
inv_string.of_arraytostring(ls_1stsigner[], ',', ls_first_signer)

inv_string.of_parsetoarray( ls_second_signer, ';', ls_2ndsigner[] )
inv_string.of_arraytostring(ls_2ndsigner[], ',', ls_second_signer)

inv_string.of_parsetoarray( ls_cc, ';', ls_ccarray[] )
inv_string.of_arraytostring(ls_ccarray[], ',', ls_cc)


If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Sending the signature request...")		

Try
	//Create Request 
	istr_app_email.as_sertifi_fileid = gnv_sertifi.isoap_sertifi.createsignaturerequest( &
		gnv_sertifi.is_apicode ,ls_emailfrom, ls_sender, ls_filename, &
		ls_first_signer, ls_second_signer, ls_cc, 'false',ls_sign_type,'', ls_custom_1, ls_custom_2, ls_custom_3,'', ls_message)

	If Pos(Lower(istr_app_email.as_sertifi_fileid), 'error') > 0 or Trim(istr_app_email.as_sertifi_fileid) = '' Then
		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
		Messagebox('Error','Failed to create sertifi electronic signature request. ~r~n' + istr_app_email.as_sertifi_fileid )
		Return -1 
	End If
	
	//Upload Document 
	For i = 1 To UpperBound(istr_app_email.rec_id_list[])
		lb_file = lb_null
		If inv_filesrv.of_fileread( istr_app_email.pathfilename_list[i] , lb_file) < 0 Then 
			gnv_sertifi.isoap_sertifi.removesignaturerequest(gnv_sertifi.is_apicode, istr_app_email.as_sertifi_fileid)
			If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
			Messagebox('Error','Failed to open the document ' + istr_app_email.pathfilename_list[i] + '.')
			Return -1
		End If

		If dw_doc.GetItemNumber(i,'need_signed') = 1 Then
			ls_xml = ''
			istr_app_email.as_sertifi_docid[i] = gnv_sertifi.isoap_sertifi.adddocumenttorequest( gnv_sertifi.is_apicode,istr_app_email.as_sertifi_fileid, lb_file,istr_app_email.fullfilename_list[i] , istr_app_email.fullfilename_list[i] ,ls_xml)
			If Pos(Lower(istr_app_email.as_sertifi_docid[i]), 'error' ) > 0 or istr_app_email.as_sertifi_docid[i] = '' Then
				gnv_sertifi.isoap_sertifi.removesignaturerequest(gnv_sertifi.is_apicode, istr_app_email.as_sertifi_fileid)
				If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
				Messagebox('Error','Failed to upload the document '+istr_app_email.fullfilename_list[i]+' to sertifi server. ~r~n' + istr_app_email.as_sertifi_docid[i])
				Return -1 
			End If
			gnv_debug.of_output(false, 'adddocumenttorequest: ' + ls_xml)
		Else
			ls_ret = ''
			ls_xml = ''
			ls_ret = gnv_sertifi.isoap_sertifi.AddReferenceDocumentToRequest( gnv_sertifi.is_apicode,istr_app_email.as_sertifi_fileid, lb_file,istr_app_email.fullfilename_list[i] , istr_app_email.fullfilename_list[i],false,ltns__referencedocumentpermission[], ls_xml  )
			If Pos(Lower(ls_ret), 'error' ) > 0 or ls_ret = '' Then
				gnv_sertifi.isoap_sertifi.removesignaturerequest(gnv_sertifi.is_apicode, istr_app_email.as_sertifi_fileid)
				If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
				Messagebox('Error','Failed to upload the document '+istr_app_email.fullfilename_list[i]+' to sertifi server. ~r~n' + ls_ret)
				Return -1  
			End If
			gnv_debug.of_output(false,'AddReferenceDocumentToRequest: ' + ls_xml)
		End If
	Next

	//Invite now
	//gnv_sertifi.isoap_sertifi.invitesigners(gnv_sertifi.is_apicode, istr_ctx_email.as_sertifi_fileid, '')
	
	//Get link
	istr_app_email.as_sertifi_link = gnv_sertifi.isoap_sertifi.getsigninglink(gnv_sertifi.is_apicode, istr_app_email.as_sertifi_fileid,ls_emailfrom)
	//istr_app_email.as_sertifi_link = gnv_sertifi.isoap_sertifi.getmaintenancelink(gnv_sertifi.is_apicode, istr_app_email.as_sertifi_fileid)
	
Catch (RuntimeError  e1) 
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	Messagebox('Error',e1.Text)
	Return -1
End Try

SetPointer(Arrow!)
If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
//Close

CloseWithReturn(Parent,istr_app_email)



end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Bw_app_sertifi_request.bin 
2F00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000009c2d9ae001d2fb2200000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c000000009c2d9ae001d2fb229c2d9ae001d2fb22000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc000000030002000500000003000002ca0000000300000246000000030000006000000002000000010000001e0000000945676d493274696400000000000000032ffffffe0000000b0000ffff000000020000bb1c000000020000bb1c000000030018bb6c000000030018bb6c0000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f69730000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020005000002ca000002460000006000010001000000006d490800696445670001327400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100bbb000001000bbb0100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000009c2d9ae001d2fb2200000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000009c2d9ae001d2fb229c2d9ae001d2fb220000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000002460000029500dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000002460000029500dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f007200700075000000500034004300430035
2500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b40000000100000000000000000000000000000000000000000000000100000000000000000000000100000000008000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Bw_app_sertifi_request.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
