$PBExportHeader$pfc_cst_u_preview_app.sru
forward
global type pfc_cst_u_preview_app from pfc_cst_u_create_app2
end type
type cb_ok from commandbutton within pfc_cst_u_preview_app
end type
type cb_cancel from commandbutton within pfc_cst_u_preview_app
end type
type cb_add from commandbutton within pfc_cst_u_preview_app
end type
type cb_remove from commandbutton within pfc_cst_u_preview_app
end type
type st_zoom from statictext within pfc_cst_u_preview_app
end type
type ddlb_zoom from dropdownlistbox within pfc_cst_u_preview_app
end type
type st_3 from statictext within pfc_cst_u_preview_app
end type
type cb_check from commandbutton within pfc_cst_u_preview_app
end type
end forward

global type pfc_cst_u_preview_app from pfc_cst_u_create_app2
integer width = 3826
integer height = 2356
cb_ok cb_ok
cb_cancel cb_cancel
cb_add cb_add
cb_remove cb_remove
st_zoom st_zoom
ddlb_zoom ddlb_zoom
st_3 st_3
cb_check cb_check
end type
global pfc_cst_u_preview_app pfc_cst_u_preview_app

type variables
window iw_parent //
boolean ib_reload = false  //maha 05.19.2016
boolean ib_save_msg = true //maha 06.17.2016
long il_rec_id   //maha 05.19.2016
long il_prac_id   //maha 05.19.2016
long il_app_id //maha 05.19.2016
long il_facility_id //maha 05.19.2016
string is_image_file  //maha 05.19.2016
datastore ids_facility
datastore ids_pd_address
end variables

forward prototypes
public function integer of_check_image ()
public function integer of_clean_up ()
public function integer of_initialize ()
public function integer of_set_parent (window aw_parent)
public function integer of_load_app (string as_parms[])
public function integer of_hide_buttons ()
public function integer of_upload_to_db (string as_filename)
public function integer of_email_fax (string as_process)
public function integer of_cleanup_ds ()
end prototypes

public function integer of_check_image ();//Check image  - alfee 06.29.2010
Boolean lb_nodisplayed //Added by (APPEON) Harry 11.14.2017

//Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
IF is_ext = 'PDF' THEN
	IF ole_edit_pdf.ole_edit.Object.filename = '' THEN
		lb_nodisplayed = TRUE
	ELSE
		lb_nodisplayed = FALSE
	END IF
ELSE
	IF ole_edit.Object.Imagedisplayed = False THEN
		lb_nodisplayed = TRUE
	ELSE
		lb_nodisplayed = FALSE
	END IF
END IF

//IF ole_edit.Object.Imagedisplayed = False THEN
IF lb_nodisplayed THEN  //Modified by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
	MessageBox("Information","There is no image displayed.")
	RETURN -1
END IF

RETURN 1
end function

public function integer of_clean_up ();//Clean up if no image displayed - alfee 06.29.2010

TRY
	
st_1.text = ""
st_name.text = ""	
st_page_num.text = "Page 0 of 0"
cb_next.Enabled = FALSE
cb_add.Enabled = FALSE
cb_remove.Enabled = FALSE
ddlb_zoom.Enabled = FALSE

IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
	ole_edit_pdf.ole_edit.Object.filename = ''
ELSE
	ole_edit.object.cleardisplay()
END IF

CATCH (RuntimeError rte)
	//
END Try

RETURN 1
end function

public function integer of_initialize ();//initialize for each preview - alfee 06.29.2010

TRY

st_1.text = ""
st_name.text = ""	
st_page_num.text = "Page 0 of 0"
cb_prior.Enabled = FALSE
cb_next.Enabled = TRUE
cb_add.Enabled = TRUE
cb_remove.Enabled = TRUE
ddlb_zoom.Enabled = TRUE

IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
	ole_edit_pdf.ole_edit.Object.filename = ''
ELSE
	ole_edit.object.cleardisplay()
END IF

CATCH (RuntimeError rte)
	//
END Try

RETURN 1
end function

public function integer of_set_parent (window aw_parent);//Set parent window - alfee 06.29.2010

iw_parent = aw_parent

RETURN 1
end function

public function integer of_load_app (string as_parms[]);//Load a populated application - alfee 06.29.2010
Integer i, li_pos
String ls_image_file, ls_prac_nm, ls_facility_nm, ls_app_nm

Try

//Get parmeters and initialize
//ls_app_image_name + "||" + ls_prac_nm + "||" + ls_facility_nm +  "||" + ls_app_nm
FOR i = 1 to UpperBound(as_parms)
//Start Code Change ----05.19.2016 #V152 maha - changed to case
//	IF i = 1 THEN ls_image_file = as_parms[1]
//	IF i = 2 THEN ls_prac_nm = as_parms[2]
//	IF i = 3 THEN ls_facility_nm = as_parms[3]
//	IF i = 4 THEN ls_app_nm = as_parms[4]	
	choose case i		
		case 1
			is_image_file = as_parms[1]
			ls_image_file = is_image_file
		case 2 
			ls_prac_nm = as_parms[2]
		case 3  
			ls_facility_nm = as_parms[3]			
		case 4 
			ls_app_nm = as_parms[4]
		case 5
			il_prac_id = long(as_parms[5] )
		case 6
			il_rec_id = long(as_parms[6] )
		case 7
			il_app_id = long(as_parms[7] )
		case 8
			il_facility_id = long(as_parms[8] )
	end choose
NEXT

if il_rec_id > 0 then ib_reload = true

if ls_prac_nm = "" and il_prac_id > 0 then 
	select full_name into :ls_prac_nm from v_full_name where prac_id = :il_prac_id;
end if

if ls_app_nm = "" and il_app_id > 0 then 
	select application_name into :ls_app_nm from app_hdr where app_id = :il_app_id;
end if

if ls_facility_nm = "" and il_facility_id > 0 then 
	select facility_name into :ls_facility_nm from facility where facility_id = :il_facility_id;
end if
//End Code Change ----05.19.2016

IF IsNull(ls_image_file) or  Not FileExists(ls_image_file) THEN 
	of_clean_up()
	RETURN -1	
END IF

//Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
of_set_image_ext( Upper(Right(Trim(ls_image_file), 3)) )
IF is_ext = 'PDF' THEN
	of_set_visible_pdf(True)
ELSE
	of_set_visible_pdf(False)
END IF

of_initialize()

IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
	This.SetRedraw(FALSE)	
	ole_edit_pdf.ole_edit.Object.LoadMultiPage (ls_image_file ,1)
	ole_edit_pdf.ole_edit.Object.View = 8
	ole_edit_pdf.ole_edit.Object.VScroll(0)
	ole_edit_pdf.ole_edit.Object.HScroll(0)
	This.SetRedraw( TRUE )
ELSE
	//load image
	ole_edit.Object.Image( ls_image_file )	
	
	This.SetRedraw(FALSE)	
	ole_edit.Object.Page(1)
	ole_edit.Object.FitTo(3)
	ole_edit.Object.DisplayScaleAlgorithm = 4 
	ole_edit.Object.ImageResolutionx( 300 )
	ole_edit.Object.ImageResolutionY( 300 )
	ole_edit.Object.Annotationtype(11)	
	ole_edit.Object.ScrollBars( True )
	//ole_edit.Object.HideAnnotationGroup()
	
	ole_edit.Object.Display()
	This.SetRedraw( TRUE )
END IF

IF of_check_image() = -1 THEN 
	of_clean_up()
	RETURN -1
END IF

//Set info
li_pos = LastPos(ls_image_file,"\")
IF li_pos > 0 THEN st_1.Text = Mid(ls_image_file, li_pos + 1)
st_name.text = ls_prac_nm
st_2.text = ls_facility_nm
st_3.text = ls_app_nm
IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
	st_page_num.Text = "Page 1 of " + String( ole_edit_pdf.ole_edit.Object.GetTotalPage() )
	IF ole_edit_pdf.ole_edit.Object.GetTotalPage() = 1 THEN cb_next.Enabled = FALSE
ELSE
	st_page_num.Text = "Page 1 of " + String( ole_edit.Object.PageCount() )
	IF ole_edit.Object.PageCount() = 1 THEN cb_next.Enabled = FALSE
END IF

	
Catch (RunTimeError rte)
	of_clean_up()
	MessageBox("Invalid Application", "The application file "  + ls_image_file + " is missing or the path is incorrect." )
	This.SetRedraw( TRUE )		
	RETURN -1
End Try


RETURN 1
end function

public function integer of_hide_buttons ();//Start Code Change ----07.15.2011 #V11 maha created for call to view image
cb_cancel.text = "Close"
cb_add.visible = false
cb_remove.visible = false
cb_check.visible = false
cb_ok.visible = false

return 1
end function

public function integer of_upload_to_db (string as_filename);//Start Code Change ----05.19.2016 #V152 maha - added
String		ls_ImagePath
long			ll_Cnts,ll_FileNo,ll_ReadCnts
Blob			lblb_ImageData,lblb_Buffer
DateTime		ldt_SaveTime
n_cst_dm_utils lnv_utils
long ll_ImgType = 5

ldt_SaveTime = f_get_server_dtm()

SELECT Count(*) INTO :ll_Cnts FROM net_dev_action_images WHERE rec_id = :il_rec_id ; 
if ll_Cnts <= 0 then
	INSERT INTO net_dev_action_images(rec_id,prac_id,app_id,image_type,save_date, file_name)
		  VALUES (:il_rec_id,:il_prac_id,:il_app_id,:ll_ImgType,:ldt_SaveTime, :as_filename) ;
else
	UPDATE net_dev_action_images
	   SET save_date = :ldt_SaveTime,
		     app_id = :il_app_id,
		     file_name = :as_filename
	 WHERE rec_id = :il_rec_id ;
end if
debugbreak()

//if lnv_utils.of_ReadBlob(as_filename, lblb_ImageData) = -1 then 
//	Return -1
//End If

ll_FileNo = FileOpen(as_filename,StreamMode!,Read!)
if ll_FileNo <= 0 then Return 1

ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
do while ll_ReadCnts > 0
	lblb_ImageData += lblb_Buffer
	ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
loop

FileClose(ll_FileNo)


UPDATEBLOB net_dev_action_images
       SET image_data = :lblb_ImageData
		WHERE rec_id = :il_rec_id ; 

COMMIT USING SQLCA ;

Messagebox("Upload Application File","The Upload is Completed!")

return 1

end function

public function integer of_email_fax (string as_process);//Start Code Change ----06.17.2016 #V152 maha
Integer f
Integer li_cnt
Integer li_rc
Integer i
integer li_email_choice
integer li_export_id 
long ll_app_list[] 
long ll_prac_list[] 
Long  ll_Return
long ll_StAppImgInDB			
DateTime ldt_today
String ls_facility_name[]
String ls_attachments[]
String ls_cover_page
String ls_cover_message
String ls_subject
String ls_fax[]
String ls_emp_mail_login
String ls_app_image_name
String ls_email_address
String ls_notetext
string ls_Attach
String ls_errtext,ls_Rtn
string  ls_emailcc   
String ls_null[]   

DataWindowChild dwchild
gs_pass_ids  lg_pass_ids
datawindow ldw_defaults
pfc_cst_nv_fax nv_emailfax 

ldt_today = DateTime( Today(), Now( ))

gnv_appeondb.of_startqueue( )

ll_StAppImgInDB = of_get_app_setting("set_StAppImgInDB","I")

long ll_rowcount1,ll_rowcount2,ll_find
ids_facility = create datastore
ids_pd_address = create datastore
ids_facility.dataobject = 'd_g_facility'
ids_pd_address.dataobject = 'd_pd_address_pd_address_link'
ids_facility.settransobject(sqlca)
ll_rowcount1 = ids_facility.retrieve()
ids_pd_address.settransobject(sqlca)
ll_rowcount2 = ids_pd_address.retrieve()

gnv_appeondb.of_commitqueue( )

ll_rowcount1 = ids_facility.rowcount()
ll_rowcount2 = ids_pd_address.rowcount()


//EMAIL CODE
IF as_process = "E" THEN
	li_email_choice = gi_email_type  //Sttart Code Change ----10.06.2008 #V85 maha
	ls_emp_mail_login= gnv_data.of_getitem("security_users","email_id","upper(user_id) = " + "'" + upper(gs_user_id) + "'")

	IF ls_emp_mail_login = "" OR IsNull( ls_emp_mail_login ) THEN
		MessageBox("", "You must setup an email login in Setup User Administration for user: " + gs_user_id )
		of_cleanup_ds()
		gi_burn_annos	= 0
		Return -1
	END IF
		
	ll_find = ids_facility.find("facility_id = " + string(il_facility_id),1,ll_rowcount1)
	IF ll_find > 0 then
		ls_facility_name[1] = ids_facility.getitemstring(ll_find,'facility_name')
	else
		MessageBox("Database Error", 'Facility Name not found' )
		of_cleanup_ds()
		Return 1
	END IF
		
		ll_find = ids_pd_address.find("pd_address_link_prac_id = " + string(il_prac_id) + " and pd_address_link_facility_id = " + string(il_facility_id),1,ll_rowcount2)
		if ll_find > 0 then
			ls_email_address = ids_pd_address.getitemstring(ll_find,'pd_address_e_mail_address')
			IF ls_email_address = "" OR IsNull( ls_email_address ) THEN
				MessageBox( "No Email Address", "To send an EMAIL to " + st_name.Text + " there must be an EMAIL address entered in the office address record that is marked as a MAILING address for the " + ls_facility_name[1] + " facility." )						
				Return -1
			END IF
		else
			MessageBox( "No Mailing Address", "To send an EMAIL to " + st_name.Text + " there must be a MAILING address entered in the address screen of the Practitioner Folder for the " + ls_facility_name[1] + " Facility." )
			gi_burn_annos	= 0
			Return -1
		END IF	

	
	OpenWithParm( w_fax_win, "Apps" + "-" + "Email")
	IF Message.StringParm = "Cancel" THEN
		of_cleanup_ds()		
		Return -1
	END IF
	lg_pass_ids = Message.PowerObjectParm

	//is_cover_page = lg_pass_ids.s_fax_cover
	ls_notetext = lg_pass_ids.s_fax_message 
	ls_subject = lg_pass_ids.s_fax_subject	
	select export_id into :li_export_id  from wf_email where email_id = :lg_pass_ids.email_id; //(Appeon)Stephen 02.24.2014 - Bug 3951

	ls_emailcc = lg_pass_ids.s_stringval

	
//FAX CODE
ELSEIF as_process = "F" THEN
	i = 1 //(Appeon)Stephen 07.20.2016 - BugS062301
	//delete any left over faxes
	FOR f = 1 TO 10000
		li_cnt = 0
		IF FileExists( gs_temp_path + "\Fax\fax_" + String( f )+ ".doc" ) THEN
			li_cnt++
		   FileDelete( gs_temp_path + "\Fax\fax_" + String( f )+ ".doc" )
		END IF
		IF FileExists( gs_temp_path + "\Fax\fax_a_" + String( f )+ ".tif" ) THEN
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\fax_a_" + String( f )+ ".tif" )			
		END IF
		IF FileExists( gs_temp_path + "\Fax\app_" + String( f )+ ".tif" ) THEN
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\app_" + String( f )+ ".tif" )			
		END IF
		IF FileExists( gs_temp_path + "\Fax\image_" + String( f )+ ".tif" ) THEN		
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\image_" + String( f )+ ".tif" )					
		END IF
		//Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
		IF FileExists( gs_temp_path + "\Fax\fax_a_" + String( f )+ ".pdf" ) THEN
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\fax_a_" + String( f )+ ".pdf" )			
		END IF
		IF FileExists( gs_temp_path + "\Fax\app_" + String( f )+ ".pdf" ) THEN
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\app_" + String( f )+ ".pdf" )			
		END IF
		IF FileExists( gs_temp_path + "\Fax\image_" + String( f )+ ".pdf" ) THEN		
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\image_" + String( f )+ ".pdf" )					
		END IF
		IF li_cnt = 0 THEN
			Exit
		END IF
	END FOR



		ll_find = ids_facility.find("facility_id = " + string(il_facility_id),1,ll_rowcount1)
		if ll_find > 0 then
			ls_facility_name[1] = ids_facility.getitemstring(ll_find,'facility_name')
		else
			MessageBox("Database Error", 'No Find facility name' )
			of_clean_up()
			Return 1
		END IF

		ll_find =ids_pd_address.find("pd_address_link_prac_id = " + string(il_prac_id) + " and pd_address_link_facility_id = " + string(il_facility_id),1,ll_rowcount2)
		if ll_find > 0 then
			ls_fax[i] = ids_pd_address.getitemstring(ll_find,'pd_address_fax')
			IF IsNull( ls_fax[i] ) OR ls_fax[i] = ""  THEN
				MessageBox( "No Fax Number", "To send a FAX to " + st_name.Text + " there must be a FAX number entered in the office address record that is marked as a MAILING address for the " + ls_facility_name[i] + " facility." )			
				of_cleanup_ds()
				Return -1
			END IF	
		else
			MessageBox( "No Mailing Address", "To send a FAX to " + st_name.Text + " there must be a MAILING address entered in the address screen of the Practitioner Folder for the " + ls_facility_name[i] + " Facility." )
			of_cleanup_ds()
			Return -1
		END IF	

		
	pfc_cst_nv_fax nv_fax
	nv_fax = CREATE pfc_cst_nv_fax;

	OpenWithParm( w_fax_win, "Apps" )
	IF Message.StringParm = "Cancel" THEN
		of_cleanup_ds()
		Return -1
	END IF

	lg_pass_ids = Message.PowerObjectParm

	ls_cover_page = lg_pass_ids.s_fax_cover
	ls_cover_message = lg_pass_ids.s_fax_message 
	ls_subject = lg_pass_ids.s_fax_subject	
	
END IF //if email or fax

gi_burn_annos	= 1

ll_app_list[1] = il_app_id
ll_prac_list[1] = il_prac_id

IF is_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
	ole_edit_pdf.ole_edit.Object.save( mid( ole_edit_pdf.ole_edit.Object.FileName, 1, lastpos( ole_edit_pdf.ole_edit.Object.FileName,'.') - 1 ) , 'pdf')
	ls_app_image_name = ole_edit_pdf.ole_edit.Object.FileName
ELSE
	for f = 1 to ole_edit.Object.PageCount()
		IF gi_burn_annos = 1 THEN
			ole_edit.Object.Page( f )
			ole_edit.Object.Display()				
				try
					ole_edit.Object.BurnInAnnotations( 1, 2 )//long.zhang 06.10.2013
					Catch(Throwable th1) 
					ole_edit.Object.BurnInAnnotations( 1, 2 )
				end try
					//------------------- APPEON END -------------------				
			ole_edit.Object.save()
		END IF
	next
	
	ls_app_image_name = ole_edit.Object.Image()	
			
	
	ole_admin.object.Image( ls_app_image_name )
END IF


IF as_process = "F" THEN
			String ls_recipient
			String ls_company
			
			ls_attachments[1] = ls_app_image_name
			ls_company = ""

			IF nv_fax.of_fax( ls_recipient, ls_company,  ls_fax[i], ls_subject, ls_cover_message, ls_attachments, ls_cover_page , ls_errtext)	= -1 THEN	
				Return -1
			END IF
		
ELSEIF as_process = "E" THEN
		IF li_email_choice = 1 then
			debugbreak()
//				ll_find = ids_pd_address.find("pd_address_link_prac_id = " + string(ii_prac_id) + " and pd_address_link_facility_id = " + string(il_facility_id),1,ll_rowcount2)
//				if ll_find > 0 then
//					ls_email_address = ids_pd_address.getitemstring(ll_find,'pd_address_e_mail_address')
//				else
//					MessageBox( "Database Error", "NO find email address. ")
//					of_clean_up()				
//					Return 1
//				end if
				n_cst_outlook lnv_Outlook
				if lnv_Outlook.of_Logon() = -1 then
					MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
					of_clean_up()
					Return 1
				end if
				ls_attach = ls_app_image_name
				//---------Begin Modified by (Appeon)Stephen 02.24.2014 for Bug 3951 When emailing an application, the body of the email is empty--------
				//ll_Return = lnv_Outlook.of_Send(ls_email_address, ls_emailcc, "", ls_subject, ls_notetext, ls_attach) //modify by stephen 05.08.2013 -V12.3 Modification estimate
				ls_attachments = ls_null
				ls_attachments[1] = ls_attach
				nv_emailfax = Create pfc_cst_nv_fax	
				ll_Return = nv_emailfax.of_email_new( "" , "" , ls_email_address , ls_subject, lg_pass_ids.s_fax_message, ls_attachments, lg_pass_ids.s_fax_cover, lg_pass_ids.email_id,ii_prac_id, lg_pass_ids.b_attach , lg_pass_ids.s_stringval) 
				//---------End Modified ------------------------------------------------------
									
				lnv_Outlook.of_Logoff()
				if ll_Return <> 1 then
					MessageBox("Mail Send", "Mail not sent.")
					destroy nv_emailfax
					Return 1
				end if
				destroy nv_emailfax
				//---------- APPEON END ------------
		ELSE
				n_cst_easymail_smtp lnv_mail
				// Get email address and attachment
				if LenA(ls_app_image_name) > 0 then ls_Attach = ls_app_image_name
//				ll_Find = ids_pd_address.Find("pd_address_link_prac_id = " + string(ii_prac_id) + " and pd_address_link_facility_id = " + string(il_facility_id),1,ll_rowcount2)
//				if ll_Find > 0 then
//					ls_email_address = ids_pd_address.GetItemString(ll_Find,'pd_address_e_mail_address')
//				else
//					MessageBox( "Database Error", "NO find email address. ")
//					of_cleanup_ds()				
//					Return 1
//				end if
				
				// Create Email object
				if lnv_mail.of_CreateObject() = -1 then
					f_show_message('create Email object','','','','')
					of_cleanup_ds()
					Return 1
				end if
				
				//---------Begin Modified by (Appeon)Stephen 02.24.2014 for Bug 3951 When emailing an application, the body of the email is empty--------
				//ll_Return = lnv_mail.of_SendText(gs_user_id, ls_email_address, ls_emailcc, "", ls_Subject, ls_NoteText, ls_Attach)  //modify by stephen 05.08.2013 -V12.3 Modification estimate
				//if ll_Return <> 0 then
				ls_attachments = ls_null
				ls_attachments[1] = ls_attach
				nv_emailfax = Create pfc_cst_nv_fax	
				ll_Return = nv_emailfax.of_email_new( "" , "" , ls_email_address , ls_subject, lg_pass_ids.s_fax_message, ls_attachments, lg_pass_ids.s_fax_cover, lg_pass_ids.email_id,ii_prac_id, lg_pass_ids.b_attach , lg_pass_ids.s_stringval) 
				if ll_Return <> 1 then
				//---------End Modified ------------------------------------------------------	
					f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
					lnv_mail.of_DeleteObject()
					of_clean_up()
					destroy nv_emailfax
					of_cleanup_ds()
					Return 1
				end if
				lnv_mail.of_DeleteObject()
				destroy nv_emailfax

		END IF
	END IF


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<add> 02.08.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Destroy the datastores to release the memory.
destroy ids_facility
destroy ids_pd_address
//---------------------------- APPEON END ----------------------------

//of_clean_up()

of_ImagingWarning()			//Added by Scofield on 2007-09-21



Return 1




end function

public function integer of_cleanup_ds ();if isvalid( ids_facility) then destroy ids_facility
if isvalid( ids_pd_address) then destroy ids_pd_address

return 1
end function

on pfc_cst_u_preview_app.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_add=create cb_add
this.cb_remove=create cb_remove
this.st_zoom=create st_zoom
this.ddlb_zoom=create ddlb_zoom
this.st_3=create st_3
this.cb_check=create cb_check
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_remove
this.Control[iCurrent+5]=this.st_zoom
this.Control[iCurrent+6]=this.ddlb_zoom
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_check
end on

on pfc_cst_u_preview_app.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_add)
destroy(this.cb_remove)
destroy(this.st_zoom)
destroy(this.ddlb_zoom)
destroy(this.st_3)
destroy(this.cb_check)
end on

type ole_edit_pdf from pfc_cst_u_create_app2`ole_edit_pdf within pfc_cst_u_preview_app
integer x = 0
integer y = 244
integer width = 3808
integer height = 2080
end type

type cb_repopulate from pfc_cst_u_create_app2`cb_repopulate within pfc_cst_u_preview_app
string facename = "Segoe UI"
end type

type dw_exceptions from pfc_cst_u_create_app2`dw_exceptions within pfc_cst_u_preview_app
end type

type ole_admin from pfc_cst_u_create_app2`ole_admin within pfc_cst_u_preview_app
end type

type st_rec from pfc_cst_u_create_app2`st_rec within pfc_cst_u_preview_app
end type

type st_page_num from pfc_cst_u_create_app2`st_page_num within pfc_cst_u_preview_app
integer x = 2496
integer y = 40
integer width = 416
integer height = 72
long backcolor = 33551856
alignment alignment = right!
end type

type st_name from pfc_cst_u_create_app2`st_name within pfc_cst_u_preview_app
integer x = 617
integer y = 140
integer width = 1051
integer height = 72
integer weight = 400
long textcolor = 128
long backcolor = 33551856
alignment alignment = center!
end type

type cb_next from pfc_cst_u_create_app2`cb_next within pfc_cst_u_preview_app
boolean visible = true
integer x = 2368
integer y = 24
string facename = "Segoe UI"
end type

type cb_prior from pfc_cst_u_create_app2`cb_prior within pfc_cst_u_preview_app
boolean visible = true
integer x = 2254
integer y = 24
string facename = "Segoe UI"
end type

type cb_2 from pfc_cst_u_create_app2`cb_2 within pfc_cst_u_preview_app
string facename = "Segoe UI"
end type

type cb_1 from pfc_cst_u_create_app2`cb_1 within pfc_cst_u_preview_app
string facename = "Segoe UI"
end type

type st_1 from pfc_cst_u_create_app2`st_1 within pfc_cst_u_preview_app
integer x = 27
integer y = 140
integer width = 590
integer height = 72
integer weight = 400
long textcolor = 128
long backcolor = 33551856
alignment alignment = center!
end type

type st_2 from pfc_cst_u_create_app2`st_2 within pfc_cst_u_preview_app
integer x = 1669
integer y = 140
integer width = 1051
integer height = 72
integer weight = 400
long textcolor = 128
long backcolor = 33551856
alignment alignment = center!
end type

type ole_edit from pfc_cst_u_create_app2`ole_edit within pfc_cst_u_preview_app
integer x = 0
integer y = 244
integer width = 3808
integer height = 2080
boolean border = false
end type

type cb_ok from commandbutton within pfc_cst_u_preview_app
integer x = 3122
integer y = 16
integer width = 338
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;IF ole_edit.object.ImageDisplayed THEN
	IF ole_edit.object.ImageModified THEN 	
		ole_edit.object.Save()
	END IF
	
	//Start Code Change ----05.19.2016 #V152 maha
	if ib_reload then
		of_upload_to_db( is_image_file)
	end if
	//End Code Change ----05.19.2016
END IF

Close(iw_parent)
end event

type cb_cancel from commandbutton within pfc_cst_u_preview_app
integer x = 3470
integer y = 16
integer width = 338
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;
Close(iw_parent)

end event

type cb_add from commandbutton within pfc_cst_u_preview_app
integer x = 18
integer y = 16
integer width = 352
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add Edit"
end type

event clicked;//Open the  get label window - alfee 06.29.2010

OpenwithParm(w_get_label, 'preview')

RETURN 1
end event

type cb_remove from commandbutton within pfc_cst_u_preview_app
integer x = 709
integer y = 16
integer width = 425
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Remove Object"
end type

event clicked;//remove annotation - alfee 06.29.2010

of_remove_object()
end event

type st_zoom from statictext within pfc_cst_u_preview_app
integer x = 1166
integer y = 36
integer width = 151
integer height = 72
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
string text = "Fit:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_zoom from dropdownlistbox within pfc_cst_u_preview_app
integer x = 1330
integer y = 24
integer width = 462
integer height = 484
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean vscrollbar = true
string item[] = {"Best Fit","Fit To Width","Fit To Height","Actual Size"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE This.Text
	CASE "Best Fit"
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
			ole_edit_pdf.ole_edit.Object.View = 9
		ELSE
			ole_edit.Object.FitTo( 0 )
		END IF
	CASE "Fit To Width"
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
			ole_edit_pdf.ole_edit.Object.View = 10
		ELSE
			ole_edit.Object.FitTo( 1 )		
		END IF
	CASE "Fit To Height"
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
			ole_edit_pdf.ole_edit.Object.View = 11
		ELSE
			ole_edit.Object.FitTo( 2 )		
		END IF
	CASE "Actual Size"	
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
			ole_edit_pdf.ole_edit.Object.View = 8
		ELSE
			ole_edit.Object.FitTo( 3 )		
		END IF
END CHOOSE

end event

type st_3 from statictext within pfc_cst_u_preview_app
integer x = 2720
integer y = 140
integer width = 1111
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_check from commandbutton within pfc_cst_u_preview_app
integer x = 379
integer y = 16
integer width = 320
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Chec&kmark"
end type

event clicked;
//Start Code Change ----08.05.2010 #V10 maha
of_create_text("LABEL-" + "X", 2, 0 )

RETURN 1
end event

