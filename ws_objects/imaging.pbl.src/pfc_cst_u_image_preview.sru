$PBExportHeader$pfc_cst_u_image_preview.sru
$PBExportComments$SK Practitioner Folder - alfee 09.08.2010
forward
global type pfc_cst_u_image_preview from userobject
end type
type st_recs from statictext within pfc_cst_u_image_preview
end type
type st_zoom from statictext within pfc_cst_u_image_preview
end type
type ddlb_zoom from dropdownlistbox within pfc_cst_u_image_preview
end type
type cb_prior from commandbutton within pfc_cst_u_image_preview
end type
type st_page from statictext within pfc_cst_u_image_preview
end type
type cb_next from commandbutton within pfc_cst_u_image_preview
end type
type tab_view from tab within pfc_cst_u_image_preview
end type
type tabpage_browse from userobject within tab_view
end type
type dw_browse from u_dw within tabpage_browse
end type
type ole_admin from olecustomcontrol within tabpage_browse
end type
type tabpage_browse from userobject within tab_view
dw_browse dw_browse
ole_admin ole_admin
end type
type tabpage_image from userobject within tab_view
end type
type cb_print from commandbutton within tabpage_image
end type
type ole_scan_edit from olecustomcontrol within tabpage_image
end type
type cb_close from commandbutton within tabpage_image
end type
type st_1 from statictext within tabpage_image
end type
type st_2 from statictext within tabpage_image
end type
type cbx_1 from u_cbx within tabpage_image
end type
type cb_email from commandbutton within tabpage_image
end type
type cb_fax from commandbutton within tabpage_image
end type
type st_3 from statictext within tabpage_image
end type
type tabpage_image from userobject within tab_view
cb_print cb_print
ole_scan_edit ole_scan_edit
cb_close cb_close
st_1 st_1
st_2 st_2
cbx_1 cbx_1
cb_email cb_email
cb_fax cb_fax
st_3 st_3
end type
type tab_view from tab within pfc_cst_u_image_preview
tabpage_browse tabpage_browse
tabpage_image tabpage_image
end type
end forward

global type pfc_cst_u_image_preview from userobject
integer width = 3168
integer height = 2048
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_recs st_recs
st_zoom st_zoom
ddlb_zoom ddlb_zoom
cb_prior cb_prior
st_page st_page
cb_next cb_next
tab_view tab_view
end type
global pfc_cst_u_image_preview pfc_cst_u_image_preview

type variables
Integer ii_image_storage_type = 0
Integer ii_num_pages
Integer ii_start_page
Integer ii_current_page
Long il_current_row
Long il_dispaly_row
String is_image_path
String is_image_file_name
Boolean ib_no_dialog = true

Window iw_parent
pfc_cst_nv_image_functions  inv_image_functions
end variables

forward prototypes
public function integer of_display_doc (integer ai_from_page, integer ai_num_pages)
public function integer of_check_for_null_start (integer ai_start)
public function integer of_print_image (integer al_start_page, integer al_pagecount)
public function integer of_check_page_count (integer ai_start, integer ai_image, integer ai_num_pages)
public function integer of_check_for_image ()
public function integer of_next_page ()
public function integer of_prior_page ()
public function integer of_browse_select_row (integer ai_row, integer ai_param)
public subroutine of_doubleclicked (u_dw adw)
public function integer of_set_menu (integer ai_index)
public function integer of_email_image ()
public function integer of_fax_image ()
public function integer of_set_parent (window aw_parent)
public function integer of_set_status (integer ai_status)
public function integer of_email_outlook (str_email_general astr_email)
public function integer of_email_easymail (str_email_general astr_email)
public function integer of_security_filter (datawindow adw_data)
public function integer of_resize ()
public function integer of_retrieve (long al_prac, integer li_screen)
end prototypes

public function integer of_display_doc (integer ai_from_page, integer ai_num_pages);//Display the current image (SK Practitioner Folder - alfee 09.09.2010)

Integer li_pagecount
Integer li_facility_id
Integer li_screen_id
Integer li_cr
Integer c
Long ll_seq_no
Long ll_rec_id
Long ll_prac_id
Boolean bt
String ls_file

//Initialize status and variables
of_set_status(0)

li_cr = tab_view.tabpage_browse.dw_browse.GetRow( )
IF li_cr < 1 THEN RETURN -1

ii_start_page = ai_from_page
ii_current_page = 1
ii_num_pages = ai_num_pages
ll_prac_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_prac_id" )	

//Get the image file
IF ii_image_storage_type = 1 THEN //Database
	ll_rec_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_rec_id" )
	li_facility_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_facility_id" )	
	li_screen_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_screen_id" )		
	ll_seq_no = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "image_pk" )   //Start Code Change ----03.29.2011 #V11 maha - changed from seq no

	IF inv_image_functions.of_retrieve_image_from_db( ll_rec_id, ll_prac_id, li_facility_id, li_screen_id, ll_seq_no ) = -1 THEN
		RETURN -1
	END IF
 //Start Code Change ----03.29.2011 #V11 maha - changed file name
//	ls_file = gs_dir_path + "IntelliCred\images\" + String(ll_rec_id) + "_" + String(ll_prac_id) + "_" +&
//				String(li_facility_id) + "_" + String(li_screen_id) + "_" + String(ll_seq_no) + ".tif"			
	ls_file = gs_temp_path + "images\" + String(ll_prac_id) + "_" + String(ll_seq_no) + ".tif"		
	is_image_file_name = ls_file
	ii_start_page = 1
	
ELSE //Hard disk
	is_image_file_name = is_image_path + String( ll_prac_id ) + ".tif"
	c = of_check_for_null_start(ii_start_page) 
	if c = -1 then return -1
END IF

IF NOT FileExists( is_image_file_name ) THEN
	IF ii_image_storage_type = 1 THEN
		MessageBox("Image File", "The image file " + ls_file + " does not exist,  Check to make sure the path exists or if the database record has an image stored in the image field." )
	ELSE
		MessageBox("Image File", "The image file " + is_image_file_name + " does not exist,  please check your image path in your Image Painter." )
	END IF
	Return -1
END IF

Try
	
//Load the image & display the first page
IF tab_view.tabpage_image.ole_scan_edit.Object.Image <> is_image_file_name OR ii_image_storage_type = 1 THEN
	tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) 
	tab_view.tabpage_image.ole_scan_edit.Object.Image( is_image_file_name )
	//tab_view.tabpage_image.ole_scan_edit.Object.UndoLevels( 1 )
END IF

li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
IF ii_image_storage_type = 1 THEN
	ii_num_pages = li_pagecount
END IF
	
IF ii_image_storage_type <> 1 THEN //Hard disk
	if ai_from_page >  li_pagecount then 
		messagebox("Display Image error","Image page data does not match pagecount of image.  Unable to display selected image.")
		return -1
	end if
END IF

tab_view.tabpage_image.ole_scan_edit.Object.Page( ai_from_page )
tab_view.tabpage_image.ole_scan_edit.Object.FitTo(3)	//Actual Size
tab_view.tabpage_image.ole_scan_edit.Object.DisplayScaleAlgorithm = 4
tab_view.tabpage_image.ole_scan_edit.Object.Display()

Catch (throwable th1)
	//
End Try

//Set status info
of_set_status (1)

Return 0
end function

public function integer of_check_for_null_start (integer ai_start);//Check the start page for the current image (SK Practitioner Folder - alfee 09.09.2010)	
	
if isnull(ai_start) then 
	MessageBox("Start Page", "There is no start page for image.  Unable to display/print image")
	return -1
else
	return 1
end if
end function

public function integer of_print_image (integer al_start_page, integer al_pagecount);//Print the current image - SK Practitioner Folder - alfee 09.09.2010

integer li_numpages

try
	if of_check_for_image () = - 1 then return -1
	if tab_view.tabpage_image.ole_scan_edit.object.pagecount < 1 then return -1
	
	li_numpages = al_pagecount - al_start_page + 1
	if of_check_page_count( al_start_page, tab_view.tabpage_image.ole_scan_edit.object.pagecount, li_numpages) = -1 then return -1
catch (OleRuntimeError err)
	return -1
end try

try
	if ib_no_dialog then
		 tab_view.tabpage_image.ole_scan_edit.object.PrintImage(al_start_page,al_pagecount,3)
	else
		 tab_view.tabpage_browse.ole_admin.object.image = tab_view.tabpage_image.ole_scan_edit.object.image
		 inv_image_functions.of_print( tab_view.tabpage_browse.ole_admin,tab_view.tabpage_image.ole_scan_edit, Handle(this), '',al_start_page,al_pagecount)
	end if 
catch (Throwable e)
	messageBox("Imaging","There is a printer error, Please check the printer.")
end try

return  0
end function

public function integer of_check_page_count (integer ai_start, integer ai_image, integer ai_num_pages);//Validate the start and number of pages against the image pagecount. (SK Practitioner Folder - alfee 09.09.2010)

integer li_cnt

li_cnt = ai_start + ai_num_pages - 1

if ai_start > ai_image then //validate the start page
	messagebox("Image Page Counts out of Sync","The start page (" + string(ai_start) + ") is greater than the number of pages in the image (" + string(ai_image) + "). Cannot continue process.")
	return -1
elseif li_cnt > ai_image then //validate the num of pages
	messagebox("Image Page Counts out of Sync","The start page and number of pages (" + string(li_cnt) + ") is greater than the number of pages in the image (" + string(ai_image) + "). Cannot continue process.")
	return -1
else
	return 1
end if



end function

public function integer of_check_for_image ();//Check whether an image is currently being displayed (SK Practitioner Folder - alfee 09.09.2010)

IF tab_view.tabpage_image.ole_scan_edit.Object.Imagedisplayed = False THEN
	MessageBox("Information","There is no Image.")
	RETURN -1
ELSE
	RETURN 1
END IF
end function

public function integer of_next_page ();//Next page (SK Practitioner Folder - alfee 09.09.2010)

Integer li_pagecount

TRY

IF of_check_for_image() = -1 THEN RETURN -1 

IF ii_num_pages > ii_current_page THEN
	li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
	IF ii_start_page + ii_current_page >  li_pagecount THEN
		Messagebox("Display Image error","Image page data exceeds pagecount of image.  Unable to display selected image.")
		RETURN -1
	ELSE
		ii_current_page ++
		tab_view.tabpage_image.ole_scan_edit.Object.Page( ii_start_page + ii_current_page -1 )
		tab_view.tabpage_image.ole_scan_edit.Object.Display()
		cb_prior.Enabled = True
		IF ii_current_page = tab_view.tabpage_image.ole_scan_edit.Object.PageCount() THEN
			cb_next.Enabled = False
		END IF
		st_page.Text = "Page " + String( ii_current_page ) + " Of " + String( ii_num_pages )
	END IF
END IF

CATCH (RunTimeError RTE)
	//...
END TRY

RETURN 0




end function

public function integer of_prior_page ();//Previous page (SK Practitioner Folder - alfee 09.09.2010)

IF of_check_for_image() = -1 THEN RETURN -1 

IF ii_current_page > 1 THEN
	ii_current_page --
	tab_view.tabpage_image.ole_scan_edit.Object.Page( ii_start_page + ii_current_page -1 )
	tab_view.tabpage_image.ole_scan_edit.Object.Display()
	cb_next.Enabled = True
	IF ii_current_page = ii_start_page THEN
		cb_prior.Enabled = False
	ELSE
		cb_prior.enabled = True
	END IF
	st_page.Text = "Page " + String( ii_current_page ) + " Of " + String( ii_num_pages )
END IF


Return 0
end function

public function integer of_browse_select_row (integer ai_row, integer ai_param);//Set the proper dw_browse row either first or last (SK Practitioner Folder - alfee 09.09.2010)

integer r
datawindow ldw_b

ldw_b = tab_view.tabpage_browse.dw_browse

//if set go to the last row
if ai_param > 0 then 
	r = ldw_b.rowcount()
else
	r = ai_row
end if

ldw_b.SetRow( r )
ldw_b.SelectRow( 0, False )
ldw_b.SelectRow(r, True )
il_current_row = r
st_recs.Text = "Record " + String(r) + " of " + String( ldw_b.RowCount())

return 1

end function

public subroutine of_doubleclicked (u_dw adw);//Double clicked on image list (SK Practitioner Folder - alfee 09.09.2010)

integer li_start 
datawindow ldw_browse

ldw_browse = this.tab_view.tabpage_browse.dw_browse

il_current_row = this.tab_view.tabpage_browse.dw_browse.getrow( )
if il_current_row < 1 then return 

IF il_dispaly_row <> il_current_row THEN
	setredraw( false)
	if ii_image_storage_type = 1 then
		li_start = 1
	else
		li_start = ADW.GetItemNumber( il_current_row, "start_page" )
	end if

	of_display_doc( li_start, ADW.GetItemNumber( il_current_row, "num_pages" ) )
	
	//tab_view.tabpage_image.ole_scan_edit.Object.Annotationtype(11)	
	il_dispaly_row = il_current_row	
	setredraw(true)	
END IF
end subroutine

public function integer of_set_menu (integer ai_index);//Set the visible property for objects (SK Practitioner Folder - alfee 09.09.2010)

IF ai_index = 1  THEN
	cb_prior.Visible = False
	cb_next.Visible = False
	st_page.Visible = False
	st_zoom.Visible = False
	ddlb_zoom.Visible = False
	tab_view.tabpage_browse.dw_browse.SetFocus()
ELSEIF ai_index = 2 THEN
	cb_prior.Visible = True
	cb_next.Visible = True
	st_page.Visible = True	
	st_zoom.Visible = True
	ddlb_zoom.Visible = True
END IF

Return 1
end function

public function integer of_email_image ();//Send email with the current image document (SK Practitioner Folder - alfee 09.09.2010)

Integer li_pagecount, li_sub, li_rtn
String ls_image_path, mess, ls_Rtn, ls_email_address
String ls_subject, ls_notetext, ls_attach
str_email_general lstr_email

//Check if an image is displayed
if of_check_for_image () = -1 then return -1

//Open the email window & get email info
Open( w_get_email_address_message )

mess = Message.StringParm
IF mess = "Cancel" THEN Return -1
IF IsNull(mess) OR LenA(Trim(mess)) < 1 THEN Return -1 

ls_email_address = MidA( Mess, 1, PosA( Mess, "*" ) -1)
li_sub = PosA( Mess, "**" ) 
ls_notetext = MidA( Mess, PosA( Mess, "*" ) +1, li_sub - PosA( Mess, "*" ) - 1)	
ls_subject = MidA( Mess, li_sub +2) 

//Verify if the directory has write right for the current user.
ls_Rtn = f_ExaWriteRight(is_image_file_name)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

//Save the image file as an email attachment 
ls_attach = gs_temp_path + "email_attachment.tif"
ls_image_path = gnv_data.of_getitem("ids" , "imaging_path" , False)
li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()

FileDelete(ls_attach )
tab_view.tabpage_browse.ole_admin.object.Image(ls_attach)

IF ii_image_storage_type = 1 THEN
	tab_view.tabpage_browse.ole_admin.object.Append( is_image_file_name, 1 , li_pagecount  )
ELSE			
	if of_check_page_count(ii_start_page, li_pagecount, ii_num_pages)	= -1 then return -1	
	tab_view.tabpage_browse.ole_admin.object.Append( is_image_file_name, ii_start_page , ii_num_pages  )			
END IF

//Send email with the image document
lstr_email.as_email_address = ls_email_address
lstr_email.as_notetext = ls_notetext
lstr_email.as_subject = ls_subject
lstr_email.as_attach = ls_attach

if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
	li_rtn = of_email_outlook( lstr_email) //outlook
ELSE
	li_rtn = of_email_easymail(lstr_email ) //easymail
END IF

Return li_rtn

end function

public function integer of_fax_image ();//Send fax with the current image document (SK Practitioner Folder - alfee 09.09.2010)

Integer li_pagecount
String ls_attachments[], ls_company, ls_Fax, ls_recipient 
String ls_cover_page, ls_cover_message, ls_subject
String ls_image_path, ls_dir, ls_errtext, ls_rtn

gs_pass_ids  lg_pass_ids
pfc_cst_nv_fax lnv_fax

SetPointer( HourGlass! )

ls_dir = gs_temp_path + "Fax"
ls_attachments[1] = ls_dir + "\image_1.tif"
If Not DirectoryExists ( ls_dir  ) Then 	CreateDirectory(ls_dir )

//Check if the image is displayed
if of_check_for_image () = -1 then return -1

//Verify if the directory has write right for the current user.
ls_Rtn = f_ExaWriteRight(ls_dir)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

//Save the image to the fax document 
ls_image_path = gnv_data.of_getitem("ids" , "imaging_path" , False)
li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()

FileDelete( ls_attachments[1]  )
tab_view.tabpage_browse.ole_admin.object.Image( ls_attachments[1] )

IF ii_image_storage_type = 1 THEN
	tab_view.tabpage_browse.ole_admin.object.Append( is_image_file_name, 1 , li_pagecount  )
ELSE			
	if of_check_page_count(ii_start_page, li_pagecount, ii_num_pages)	= -1 then return -1	
	tab_view.tabpage_browse.ole_admin.object.Append( is_image_file_name, ii_start_page , ii_num_pages  )	
END IF

//Open the fax window and get the fax info
OpenWithParm( w_fax_win, "Image" )
IF Message.StringParm = "Cancel" THEN
	Return -1
END IF

lg_pass_ids = Message.PowerObjectParm

ls_cover_page = lg_pass_ids.s_fax_cover
ls_cover_message = lg_pass_ids.s_fax_message 
ls_subject = lg_pass_ids.s_fax_subject	
ls_recipient = lg_pass_ids.s_fax_recipient
ls_fax = lg_pass_ids.s_fax_fax_number
ls_company = lg_pass_ids.s_fax_company
IF IsNull( ls_company ) THEN ls_company = ""

//Fax the image 
lnv_fax = Create pfc_cst_nv_fax
IF lnv_fax.of_fax( ls_recipient, ls_company, ls_fax, ls_subject, ls_cover_message, ls_attachments, ls_cover_page, ls_errtext )	= -1 THEN
	Destroy lnv_fax
	Messagebox('Fax Send',ls_errtext)
	Return -1
END IF
Destroy lnv_fax	

Return 1
end function

public function integer of_set_parent (window aw_parent);//Set parent window (SK Practitioner Folder - alfee 09.09.2010)

iw_parent = aw_parent

RETURN 1
end function

public function integer of_set_status (integer ai_status);//Initialization for each preview (SK Practitioner Folder - alfee 09.10.2010)

long ll_row

if ai_status = 0 then //Initialize status
	tab_view.tabpage_image.st_1.text = ""
	tab_view.tabpage_image.st_2.text = ""
	tab_view.tabpage_image.st_3.text = ""
	
	st_page.text = "Page 0 of 0"
	
	cb_prior.Enabled = false
	cb_next.Enabled = false
	ddlb_zoom.Enabled = false
	
	tab_view.tabpage_image.ole_scan_edit.object.cleardisplay()
else //Set status
	ll_row = tab_view.tabpage_browse.dw_browse.getrow()
	if ll_row > 0 then
		tab_view.tabpage_image.st_1.text = tab_view.tabpage_browse.dw_browse.getitemstring(ll_row, 'full_name')
		tab_view.tabpage_image.st_2.text = tab_view.tabpage_browse.dw_browse.getitemstring(ll_row, 'image_type_description')		
		tab_view.tabpage_image.st_3.text = tab_view.tabpage_browse.dw_browse.getitemstring(ll_row, 'screen_name')
	end if
	
	if ii_num_pages > 0 then st_page.text = "Page 1 of " + string(ii_num_pages)
	
	if ii_num_pages > 1 then cb_next.Enabled = true	
	cb_prior.Enabled = false
	ddlb_zoom.Enabled = true
end if

return 1
end function

public function integer of_email_outlook (str_email_general astr_email);//Send email with outlook (SK Practitioner Folder - alfee 09.09.2010)

Integer i
String ls_email_address, ls_notetext, ls_subject, ls_attach, ls_recipient[]
n_cst_string lnv_string

mailSession mSes
mailReturnCode mRet
mailMessage mMsg
mailFileDescription nfile1
mailFileDescription nfile2
mailFileDescription nfile3

//Get the email info
ls_email_address = astr_email.as_email_address
ls_notetext = astr_email.as_notetext
ls_subject = astr_email.as_subject
ls_attach = astr_email.as_attach

//---------- APPEON BEGIN ----------
//$<modify> Evan 06.12.2012
//$<reason> V12.2-Email Logging
/*
//Create email session and logon
mSes = create mailSession
mRet = mailReturnSuccess!

mRet = mSes.mailLogon( mailNewSession!) 
IF mRet <> mailReturnSuccess! THEN
	MessageBox("Mail", 'Logon failed.  Check to make sure you have an email id setup in the user painter.')		
	Return -1
END IF

// Populate the attachment object
IF LenA( ls_attach ) > 0 THEN
	nfile1.FileType = MailAttach!
	nfile1.FileName = "email_attachment.tif"
	nfile1.PathName = ls_attach
	nfile1.position = 1
	mMsg.AttachmentFile[1] = nfile1	
END IF

mMsg.Subject = ls_subject
mMsg.NoteText = ls_notetext

//Parse the recipients
lnv_string.of_parsetoarray( ls_email_address, ';', ls_Recipient[])
FOR i = 1 To UpperBound(ls_Recipient[])
	mMsg.Recipient[i].Name = Trim(ls_Recipient[i])
NEXT

//Send the email
mRet = mSes.mailSend(mMsg)

IF mRet <> mailReturnSuccess! THEN
	MessageBox("Mail Send", 'Mail not sent')
	mSes.mailLogoff()
	DESTROY mSes
	Return -1
END IF

//Log off and destroy session
mSes.mailLogoff()
DESTROY mSes
*/
long ll_Return
n_cst_outlook lnv_Outlook

if lnv_Outlook.of_Logon() = -1 then
	MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
	Return -1
end if
ll_Return = lnv_Outlook.of_Send(ls_email_address, "", "", ls_subject, ls_notetext, ls_attach)
lnv_Outlook.of_Logoff()
if ll_Return <> 1 then
	MessageBox("Mail Send", "Mail not sent.")
	Return -1
end if
//---------- APPEON END ------------

Return -1
end function

public function integer of_email_easymail (str_email_general astr_email);//Send email with EasyMail (SK Practitioner Folder - alfee 09.09.2010)

Long	ll_Return
String ls_email_address, ls_subject, ls_notetext, ls_address_mailcc, ls_attach
n_cst_easymail_smtp	lnv_Mail

//Get the email info
ls_email_address = astr_email.as_email_address
ls_notetext = astr_email.as_notetext
ls_subject = astr_email.as_subject
ls_attach = astr_email.as_attach

//Send the email
if lnv_Mail.of_CreateObject() = -1 then
	f_show_message('create Email object','','','','')
	Return -1
end if

//--------Begin Modified by alfee 09.02.2011 ---------------------------------
//<$Reason>The email format had been changed from text to word for easymail 
//<$Reason>setting in w_get_email_address_message - BugE081901 
ll_Return = lnv_Mail.of_SendHtml(gs_user_id, ls_email_address, ls_address_mailcc, '', ls_subject, ls_notetext, ls_attach)
//ll_Return = lnv_Mail.of_SendText(gs_user_id, ls_email_address, ls_address_mailcc, '',ls_subject, ls_notetext, ls_attach)
//---------End Modified ---------------------------------------------------------

if ll_Return <> 0 then
	f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	lnv_Mail.of_DeleteObject()
	return -1
end if

lnv_Mail.of_DeleteObject()

Return 1

end function

public function integer of_security_filter (datawindow adw_data);//Start Code Change ----12.04.2012 #V12 maha

if of_get_app_setting("set_69","I") = 1 then
	adw_data.setfilter("view_rights = 1")
	adw_data.filter()
end if

return 1
end function

public function integer of_resize ();//Start Code Change ----12.02.2016 #V153 maha - added
tab_view.width = this.width -10
tab_view.height = this.height -10
tab_view.tabpage_browse.dw_browse.width = tab_view.width - 64
tab_view.tabpage_browse.dw_browse.height =tab_view.height -20 

tab_view.tabpage_image.cbx_1.y = tab_view.tabpage_image.height - 196
tab_view.tabpage_image.cb_email.y = tab_view.tabpage_image.cbx_1.y - 8
tab_view.tabpage_image.cb_close.y = tab_view.tabpage_image.cbx_1.y - 8
tab_view.tabpage_image.cb_fax.y = tab_view.tabpage_image.cbx_1.y - 8
tab_view.tabpage_image.cb_print.y = tab_view.tabpage_image.cbx_1.y - 8
tab_view.tabpage_image.st_1.y = tab_view.tabpage_image.cbx_1.y + 116
tab_view.tabpage_image.st_2.y = tab_view.tabpage_image.cbx_1.y + 116
tab_view.tabpage_image.st_3.y = tab_view.tabpage_image.cbx_1.y + 116
tab_view.tabpage_image.ole_scan_edit.height = tab_view.tabpage_image.cb_fax.y - 40
tab_view.tabpage_image.ole_scan_edit.width = tab_view.tabpage_image.width - 20

return 1
end function

public function integer of_retrieve (long al_prac, integer li_screen);//Start Code Change ----09.15.2017 #V154 maha

string ls_sql
string ls_where
integer t


ls_sql = tab_view.tabpage_browse.dw_browse.getsqlselect( )

t = of_get_app_setting("set_94","I")

if isnull(t ) then t = 0

choose case t
	case 1  //plus basic
		 ls_where = " AND ( image_type.link_to_screen in (" + string(li_screen) + " ,1  )) "
	case 2
		// no screen filter
	case else
		 ls_where =  " AND   ( image_type.link_to_screen = " + string(li_screen) + " ) "
end choose
debugbreak()
ls_sql+= ls_where

//t = tab_view.tabpage_browse.dw_browse.setsqlselect(ls_sql )

tab_view.tabpage_browse.dw_browse.Modify("DataWindow.Table.Select='"+ ls_sql +"'")
tab_view.tabpage_browse.dw_browse.settransobject(sqlca)
t = tab_view.tabpage_browse.dw_browse.retrieve(al_prac, gs_user_id)

return 1


end function

on pfc_cst_u_image_preview.create
this.st_recs=create st_recs
this.st_zoom=create st_zoom
this.ddlb_zoom=create ddlb_zoom
this.cb_prior=create cb_prior
this.st_page=create st_page
this.cb_next=create cb_next
this.tab_view=create tab_view
this.Control[]={this.st_recs,&
this.st_zoom,&
this.ddlb_zoom,&
this.cb_prior,&
this.st_page,&
this.cb_next,&
this.tab_view}
end on

on pfc_cst_u_image_preview.destroy
destroy(this.st_recs)
destroy(this.st_zoom)
destroy(this.ddlb_zoom)
destroy(this.cb_prior)
destroy(this.st_page)
destroy(this.cb_next)
destroy(this.tab_view)
end on

event constructor;//SK Practitioner Folder -  alfee 09.09.2010

Integer li_image_storage_type

ddlb_zoom.Text = "Actual Size"

li_image_storage_type = of_get_app_setting("image_storage_type","I")
IF li_image_storage_type = 1 THEN
	ii_image_storage_type = 1
	inv_image_functions = CREATE pfc_cst_nv_image_functions
ELSE
	ii_image_storage_type = 0	
END IF

IF appeongetclienttype() = "WEB" THEN //alfee 11.17.2010
	st_zoom.y = st_zoom.y - 15
	ddlb_zoom.y = ddlb_zoom.y - 15
	cb_prior.y = cb_prior.y - 15
	cb_next.y = cb_next.y - 15	
	st_page.y = st_page.y - 15
END IF
end event

event destructor;DESTROY inv_image_functions;
end event

type st_recs from statictext within pfc_cst_u_image_preview
boolean visible = false
integer x = 2578
integer y = 32
integer width = 562
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Record 1 of 1"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_zoom from statictext within pfc_cst_u_image_preview
integer x = 1280
integer y = 28
integer width = 178
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Zoom:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_zoom from dropdownlistbox within pfc_cst_u_image_preview
integer x = 1472
integer y = 16
integer width = 658
integer height = 484
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Best Fit","Fit To Width","Fit To Height","Actual Size"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE This.Text
	CASE "Best Fit"
		tab_view.tabpage_image.ole_scan_edit.Object.FitTo( 0 )
	CASE "Fit To Width"
		tab_view.tabpage_image.ole_scan_edit.Object.FitTo( 1 )		
	CASE "Fit To Height"
		tab_view.tabpage_image.ole_scan_edit.Object.FitTo( 2 )		
	CASE "Actual Size"		
		tab_view.tabpage_image.ole_scan_edit.Object.FitTo( 3 )		
END CHOOSE
end event

type cb_prior from commandbutton within pfc_cst_u_image_preview
integer x = 2327
integer y = 16
integer width = 114
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "<"
end type

event clicked;//Previous page

of_prior_page()
end event

type st_page from statictext within pfc_cst_u_image_preview
integer x = 2578
integer y = 28
integer width = 562
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Page 1 of 1 "
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_next from commandbutton within pfc_cst_u_image_preview
integer x = 2446
integer y = 16
integer width = 114
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">"
end type

event clicked;//next page

of_next_page ()
end event

type tab_view from tab within pfc_cst_u_image_preview
event create ( )
event destroy ( )
integer width = 3150
integer height = 2040
integer taborder = 20
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
tabpage_browse tabpage_browse
tabpage_image tabpage_image
end type

on tab_view.create
this.tabpage_browse=create tabpage_browse
this.tabpage_image=create tabpage_image
this.Control[]={this.tabpage_browse,&
this.tabpage_image}
end on

on tab_view.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_image)
end on

event selectionchanged;if oldindex = -1 or newindex = -1 then return

SetPointer(HourGlass!) 
SetRedraw(False) 

//Set the visible property for objects
of_set_menu( newindex )

//Display the current image
IF newindex = 2 THEN 
	of_doubleclicked(THIS.tabpage_browse.dw_browse)
end if

SetRedraw(TRUE) 


end event

type tabpage_browse from userobject within tab_view
integer x = 18
integer y = 112
integer width = 3113
integer height = 1912
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "Justify!"
long picturemaskcolor = 536870912
dw_browse dw_browse
ole_admin ole_admin
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.ole_admin=create ole_admin
this.Control[]={this.dw_browse,&
this.ole_admin}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
destroy(this.ole_admin)
end on

type dw_browse from u_dw within tabpage_browse
integer x = 14
integer y = 12
integer width = 3086
integer height = 1900
integer taborder = 11
string dataobject = "d_pd_image_list_scr"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//Start Code Change ----.2012 #V12 maha
//if of_get_app_setting("image_storage_type","I") = 1 then
//	this.object.start_page_t.text = "In~rDB"
//	this.object.start_page.color = rgb(255,255,255)
//end if
end event

event clicked;call super::clicked;Integer r

IF This.GetClickedRow() > 0 AND row > 0 THEN
	r = This.GetClickedRow()
	of_browse_select_row( r, -1)
END IF

end event

event doubleclicked;call super::doubleclicked;tab_view.SelectTab( 2 )
end event

event retrieveend;call super::retrieveend;
il_dispaly_row = 0

IF rowcount > 0 THEN
	of_browse_select_row( 1, -5)
	This.SetFocus()
END IF





end event

event rowfocuschanged;call super::rowfocuschanged;
st_recs.Text = "Record " + String(currentrow) + " of " + String(This.RowCount()) 

il_current_row = currentrow


end event

type ole_admin from olecustomcontrol within tabpage_browse
event filepropertiesclose ( )
integer x = -1106
integer y = -856
integer width = 155
integer height = 136
integer taborder = 10
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "pfc_cst_u_image_preview.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type tabpage_image from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3113
integer height = 1912
long backcolor = 33551856
string text = "Preview"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "picture5!"
long picturemaskcolor = 536870912
cb_print cb_print
ole_scan_edit ole_scan_edit
cb_close cb_close
st_1 st_1
st_2 st_2
cbx_1 cbx_1
cb_email cb_email
cb_fax cb_fax
st_3 st_3
end type

on tabpage_image.create
this.cb_print=create cb_print
this.ole_scan_edit=create ole_scan_edit
this.cb_close=create cb_close
this.st_1=create st_1
this.st_2=create st_2
this.cbx_1=create cbx_1
this.cb_email=create cb_email
this.cb_fax=create cb_fax
this.st_3=create st_3
this.Control[]={this.cb_print,&
this.ole_scan_edit,&
this.cb_close,&
this.st_1,&
this.st_2,&
this.cbx_1,&
this.cb_email,&
this.cb_fax,&
this.st_3}
end on

on tabpage_image.destroy
destroy(this.cb_print)
destroy(this.ole_scan_edit)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.cb_email)
destroy(this.cb_fax)
destroy(this.st_3)
end on

type cb_print from commandbutton within tabpage_image
integer x = 983
integer y = 1700
integer width = 347
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;//Print current image

of_print_image (ii_start_page, ii_num_pages)
end event

type ole_scan_edit from olecustomcontrol within tabpage_image
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
integer y = 4
integer width = 3109
integer height = 1676
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "pfc_cst_u_image_preview.udo"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_close from commandbutton within tabpage_image
integer x = 2770
integer y = 1700
integer width = 347
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;
Close(iw_parent)

end event

type st_1 from statictext within tabpage_image
integer x = 14
integer y = 1824
integer width = 1006
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_image
integer x = 1015
integer y = 1824
integer width = 969
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cbx_1 from u_cbx within tabpage_image
integer x = 14
integer y = 1708
integer width = 859
integer height = 76
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "Use Default/Previous Printer"
boolean checked = true
end type

event clicked;call super::clicked;//for printer selection dialog

if this.checked then 
	ib_no_dialog = true
else 
	ib_no_dialog = false
end if 
end event

type cb_email from commandbutton within tabpage_image
integer x = 1691
integer y = 1700
integer width = 347
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Email"
end type

event clicked;//Send Email with current image

of_email_image ()
end event

type cb_fax from commandbutton within tabpage_image
integer x = 1339
integer y = 1700
integer width = 347
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Fax"
end type

event clicked;//Send fax of current image

of_fax_image()
end event

type st_3 from statictext within tabpage_image
integer x = 1979
integer y = 1824
integer width = 1129
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
00pfc_cst_u_image_preview.bin 
2600000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000cf1b988001d32e2b00000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000cf1b988001d32e2bcf1b988001d32e2b000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
27ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020206009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000030002000003840000038400000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000cf1bbf9001d32e2b00000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000cf1bbf9001d32e2bcf1bbf9001d32e2b000000000000000000000000006f00430074006e006e006500730074
2700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc000000030002000500000003000046480000000300002b4e000000030000006000000002000000010000001e0000000945676d493274696400000000000000032ffffffe0000000b0000ffff000000020000b34c000000020000b34c000000030018b39c000000030018b39c0000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f697300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200050000464800002b4e0000006000010001000000006d490800696445670001327400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100b3e000001000b3e01000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10pfc_cst_u_image_preview.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
