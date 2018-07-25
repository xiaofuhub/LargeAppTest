$PBExportHeader$w_ctx_doc_properties.srw
forward
global type w_ctx_doc_properties from w_response
end type
type dw_main from u_dw_contract within w_ctx_doc_properties
end type
type cb_scan from commandbutton within w_ctx_doc_properties
end type
type cb_cancel from commandbutton within w_ctx_doc_properties
end type
type cb_ok from commandbutton within w_ctx_doc_properties
end type
type gb_1 from groupbox within w_ctx_doc_properties
end type
end forward

global type w_ctx_doc_properties from w_response
integer width = 2313
integer height = 1516
string title = "Properties of document"
long backcolor = 33551856
dw_main dw_main
cb_scan cb_scan
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
end type
global w_ctx_doc_properties w_ctx_doc_properties

type variables
long il_doc_id = 0, il_copied_doc_id

//added by alfee 08.31.2007
long il_status_ori 
String is_operation
//

//begin added by alfee 01.07.2008
Long il_category_ori
String is_doctype_ori
//end added

n_cst_right inv_right 

//BEGIN---Add by Evan 08/19/2008
n_cst_dm_utils inv_utils
n_cst_pdf2text inv_cst_pdf2text
n_cst_ocr inv_cst_tif2text
//END---Add by Evan 08/19/2008
end variables

forward prototypes
public function integer of_filetodb ()
public function integer of_filecopytodb ()
public function integer of_check_required ()
protected function integer of_downloaddata (long al_doc_id, ref blob ablb_image_file, ref string as_image_text)
end prototypes

public function integer of_filetodb ();integer li_FileNum, loops, i
long flen, bytes_read, new_pos, ll_doc_id
blob b, tot_b
string ls_fullname

ls_fullname = dw_main.getitemstring( 1, "files" )
IF isnull( ls_fullname ) OR trim( ls_fullname ) = '' THEN return 0;

If not fileexists(ls_fullname) then
	Messagebox( "Save Document File to Database", ls_fullname + " can not be found!" )
	return -1
end if
openwithparm( w_appeon_gifofwait, "Uploading document to database..." )

SetPointer(HourGlass!)

IF inv_utils.of_readblob(ls_fullname, tot_b) < 0 THEN //Alfee 09.28.2008
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	Messagebox( "Read Document", "Failed to read document!" )
	Return -1
END IF
/*
flen = FileLength(ls_fullname)
li_FileNum = FileOpen(ls_fullname, StreamMode!, Read!, LockRead!)
IF flen > 32765 THEN
	IF Mod(flen, 32765) = 0 THEN
		loops = flen/32765
	ELSE
		loops = (flen/32765) + 1
	END IF
ELSE
	loops = 1
END IF
FOR i = 1 to loops
    bytes_read = FileRead(li_FileNum, b)
    tot_b = tot_b + b
NEXT
FileClose(li_FileNum)
*/

ll_doc_id = dw_main.getitemnumber( 1, "ctx_acp_document_id" )
UPDATEBLOB ctx_acp_document
SET image_file = :tot_b
WHERE ctx_acp_document_id = :ll_doc_id USING SQLCA; 
IF sqlca.sqlcode = 0 then
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	Messagebox( "Save Document File to Database", "Update failed!" )
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	Return -1;
END IF

IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)


// Upload image text to database
n_cst_image_cp_ocr lnv_ocr
lnv_ocr = Create n_cst_image_cp_ocr
string ls_doc_ext, ls_image_text
If gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1'  /*Global Search module is On*/ &
and gnv_data.of_getitem('icred_settings' ,'auto_ocr' , False ) = '1'  Then //Auto OCR is Yes
	ls_doc_ext = Upper(inv_utils.of_get_fileext(ls_FullName))
	choose case ls_doc_ext
		case "PDF"
			inv_cst_pdf2text.of_pdf2text(ls_FullName, ls_image_text)
			If ls_image_text = '' Then
				ls_image_text = lnv_ocr.of_ocr(ls_FullName)
			End If
		case 'BMP','TIF','TIFF','JPG','GIF'
			//inv_cst_tif2text.of_tif2text(ls_FullName, ls_image_text)
			ls_image_text = lnv_ocr.of_ocr(ls_FullName)
	end choose
	if Len(ls_image_text) > 0 then
		UPDATE ctx_acp_document
		SET image_text = :ls_image_text
		WHERE ctx_acp_document_id = :ll_doc_id;
	end if
End If

If isvalid(lnv_ocr) Then Destroy lnv_ocr

Return 1
end function

public function integer of_filecopytodb ();//BEGIN---Modify by Evan 09/19/2008
//Reason: Fix a bug that the following codes cannot copies large files.
/*
Long ll_length
Blob lb_data

SELECT DataLength( image_file )
INTO :ll_length
FROM ctx_acp_document
WHERE ctx_acp_document_id = :il_copied_doc_id;

IF ll_length > 0 THEN
	openwithparm( w_appeon_gifofwait, "Uploading document to database..." )

	SELECTBLOB image_file 
	INTO :lb_data 
	FROM ctx_acp_document
	WHERE ctx_acp_document_id = :il_copied_doc_id;	
	
	IF SQLCA.SQLCode = 0 THEN
		UPDATEBLOB ctx_acp_document
		SET image_file = :lb_data
		WHERE ctx_acp_document_id = :il_doc_id;
		IF SQLCA.SQLCode = 0 THEN
			COMMIT USING SQLCA;
			IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
			Return 1;
		ELSE
			ROLLBACK USING SQLCA;
		END IF
	END IF
ELSE
	Return 0;
END IF

IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
Messagebox( "Save Document File to Database", "Update failed!" )
Return -1;
*/
blob   lb_image_file
string ls_image_text

// Download data from database
OpenWithParm(w_appeon_gifofwait, "Uploading document to database...")
of_DownloadData(il_copied_doc_id, lb_image_file, ls_image_text)

// Upload data to database
if Len(lb_image_file) > 0 then
	UPDATEBLOB ctx_acp_document
	SET image_file = :lb_image_file
	WHERE ctx_acp_document_id = :il_doc_id;
	if SQLCA.SQLCode <> 0 then
		if Isvalid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)
		Messagebox("Save Document File to Database", "Update failed!")
		Return -1
	end if
	UPDATE ctx_acp_document
	SET image_text = :ls_image_text
	WHERE ctx_acp_document_id = :il_doc_id;
	if SQLCA.SQLCode <> 0 then
		if Isvalid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)
		Messagebox("Save Document Text to Database", "Update failed!")
		Return -1
	end if
else
	if Isvalid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)
	Return 0
end if

if Isvalid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)
Return 1
//END---Modify by Evan 09/19/2008
end function

public function integer of_check_required ();//////////////////////////////////////////////////////////////////////
// $<function>w_ctx_doc_properties.of_check_required()
// $<arguments>
// $<returns> integer
// $<description> Validation on some specifical columns
//////////////////////////////////////////////////////////////////////
// $<add> 09.03.2007 by Alfee (Contract Logix Document library Painter)
//////////////////////////////////////////////////////////////////////
Long ll_status, ll_row, ll_docid, ll_approved, ll_cnt

/*----------Commented by Alfee 11.13.2007-------------------
IF is_operation <> "changed" THEN RETURN 0

ll_row = dw_main.GetRow()
IF ll_row < 1 THEN RETURN 0

//Validation on review status 
ll_status = dw_main.GetItemNumber(ll_row, "reviewed_status")
ll_docid = dw_main.GetItemNumber(ll_row, "ctx_acp_document_id")
ll_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Document Review Status' and code = 'Approved'"))	
IF il_status_ori = ll_approved and ll_status <> ll_approved THEN
	Select count(*) Into :ll_cnt From ctx_am_document Where base_type = '2' and from_templete_id = :ll_docid ;
	IF ll_cnt > 0 THEN
		MessageBox("Alert Message","The Review Status field can't be changed until the document is removed from the affected file(s).")
		dw_main.SetFocus()
		dw_main.SetColumn("reviewed_status")
		Return -1
	END IF
END IF
------------End Commented --------------------------------*/


RETURN 1
end function

protected function integer of_downloaddata (long al_doc_id, ref blob ablb_image_file, ref string as_image_text);blob   lb_data
string ls_data
long ll_image_len
long ll_text_len
long ll_start
long ll_counter
long ll_loops

if gs_dbtype = "ASA" or appeongetclienttype() <> 'PB' then
	// Download image file
	SELECTBLOB image_file INTO :ablb_image_file
	FROM ctx_acp_document
	WHERE ctx_acp_document_id = :al_doc_id;
	
	// Download image text
	SELECT image_text INTO :as_image_text
	FROM ctx_acp_document
	WHERE ctx_acp_document_id = :al_doc_id;	
else
	// Get data length
	SELECT DataLength(image_file), DataLength(image_text) INTO :ll_image_len, :ll_text_len
	FROM ctx_acp_document
	WHERE ctx_acp_document_id = :al_doc_id;	
	if IsNull(ll_image_len) then ll_image_len = 0
	if IsNull(ll_text_len) then ll_text_len = 0
	
	// Download image file
	ll_loops = 0
	if ll_image_len > 8000 then 
		if Mod(ll_image_len,8000) = 0 then
			ll_loops = ll_image_len / 8000 
		else
			ll_loops = (ll_image_len / 8000) + 1
		end if 
	elseif ll_image_len > 0 then 
		ll_loops = 1
	end if	
	for ll_counter = 1 to ll_loops			
		ll_start = (ll_counter - 1) * 8000 + 1
		SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
		FROM ctx_acp_document
		WHERE ctx_acp_document_id = :al_doc_id;
		ablb_image_file += lb_data
	next
	
	// Download image text
	ll_loops = 0
	if ll_text_len > 8000 then 
		if Mod(ll_text_len,8000) = 0 then
			ll_loops = ll_text_len / 8000 
		else
			ll_loops = (ll_text_len / 8000) + 1
		end if 
	elseif ll_text_len > 0 then 
		ll_loops = 1
	end if	
	for ll_counter = 1 to ll_loops
		ll_start = (ll_counter - 1) * 8000 + 1
		SELECT substring(image_text,:ll_start,8000) INTO :ls_data
		FROM ctx_acp_document
		WHERE ctx_acp_document_id = :al_doc_id;
		as_image_text += ls_data
	next
end if

if IsNull(ablb_image_file) then ablb_image_file = blob('',EncodingAnsi!) //(Appeon)Eugene 06.13.2013 - V141 ISG-CLX
if IsNull(as_image_text) then as_image_text = ""

Return 1
end function

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-16 By: Rodger Wu (doc painter)
//$<reason> This window is designed by Rodger Wu for editing Contract Logix
//$<reason> Document Properties.
//---------------------------- APPEON END ----------------------------

string ls_parm, ls_type, ls_operation, ls_category, ls_id
Long ll_null, ll_reviewed_status, ll_find
Integer li_setting 
datetime ldt_null
DatawindowChild ldwc_child, ldwc_status

ls_parm = Message.stringparm
ib_disableclosequery = True
dw_main.settransobject( sqlca )
dw_main.of_SetDropDownCalendar(TRUE)

//Added for refresh the work flow DDDW -- 12.5.2006 Henry
dw_main.getchild( "wf_id", ldwc_child)
ldwc_child.settransobject(SQLCA)
ldwc_child.retrieve( '04') //'04' means that the work flow created for agreement manager
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.27.2007 By: Jervis
//$<reason> Set Filter trigger by <> 104-New Buy Side Document
ldwc_child.SetFilter("wf_triggered_by <> '104'")
ldwc_child.Filter( )
//---------------------------- APPEON END ----------------------------

ldwc_child.insertrow(1)
//

//"add" + "~t" + category + "~t" + document_type;
//"changed" + "~t" + document_id
//"copy" + "t" + document_id
//--------Begin Modified by Alfee 08.31.2007-------------
//ls_operation = f_get_token( ls_parm, "~t" )
//choose case ls_operation
is_operation = f_get_token( ls_parm, "~t" )
choose case is_operation
//--------End Modified ----------------------------------		
	case "add"
		ls_category = f_get_token( ls_parm, "~t" )
		ls_type = f_get_token( ls_parm, "~t" )
	
		This.Title = "New Document"
			
		dw_main.InsertRow( 0 )
		if ls_category <> "" then dw_main.setitem( 1, "category", long( ls_category ) )
		if ls_type <> "" then 
			dw_main.setitem( 1, "document_type", ls_type )
		else
			dw_main.setitem( 1, "document_type", 'DOC' ) //default type
		end if
		//-------Begin added by Alfee 05.24.2007-----------------
		//set default value of reviewed status
		if dw_main.getchild("reviewed_status",ldwc_status) = 1 then
			ll_find = ldwc_status.find("lower(code) = 'pending'",1,ldwc_status.rowcount())
			if ll_find > 0 then 
				ll_reviewed_status = ldwc_status.getitemnumber(ll_find,"lookup_code")
				dw_main.setitem(1,"reviewed_status",ll_reviewed_status)
				dw_main.setitem(1,'date_reviewed',today())
				dw_main.setitem(1,'reviewed_by',gs_user_id)	
			end if
		end if						
		//-------End added ----------------------------------
		if dw_main.modifiedcount() > 0 then dw_main.setitemstatus( 1, 0, Primary!, NotModified! )		
	case "changed"
		ls_id = f_get_token( ls_parm, "~t" )
		dw_main.retrieve( Long( ls_id ) )
		If dw_main.GetRow() > 0 Then //alfee 08.31.2007		
			il_status_ori = dw_main.getitemnumber(dw_main.getrow(),'reviewed_status')	
			//---------Begin Added by Alfee 01.07.2008---------
			il_category_ori = dw_main.getitemnumber(dw_main.getrow(),'category')	
			is_doctype_ori = dw_main.getitemString(dw_main.getrow(),'document_type')				
			//---------End Added -------------------------------
		End If		
	case "copy"
		ls_id = f_get_token( ls_parm, "~t" )
		il_copied_doc_id = Long( ls_id )
		dw_main.Retrieve( il_copied_doc_id )
		
		dw_main.rowscopy( 1, 1, Primary!, dw_main, 10, Primary! )
		
		dw_main.SetItem( 2, "document_name", "Copy of " + dw_main.GetItemString( 1, "document_name" ) )
		dw_main.Modify( "files.background.mode = '1' files.protect = '1' b_browsefile.visible = '0'" + &
							 " files.width= '1522'")
		
		setnull( ll_null )
		setnull( ldt_null )
		//-----Begin Commented by Alfee 03.12.2008---------
		//dw_main.SetItem( 2, "wf_id", ll_null )
		//dw_main.SetItem( 2, "description", '' )
		//-----End Commented ------------------------------
		dw_main.SetItem( 2, "reviewed_by", '' )
		dw_main.SetItem( 2, "date_reviewed", ldt_null )
		dw_main.SetItem( 2, "reviewed_status", ll_null )
		dw_main.SetItem( 2, "ctx_acp_document_id", ll_null )
		dw_main.SetItem( 2, "create_date", datetime( today(), now() ) )
		dw_main.SetItem( 2, "modify_date", ldt_null )
		//-------Begin added by Alfee 05.24.2007-----------------
		//set default value of reviewed status
		if dw_main.getchild("reviewed_status",ldwc_status) = 1 then
			ll_find = ldwc_status.find("lower(code) = 'pending'",1,ldwc_status.rowcount())
			if ll_find > 0 then 
				ll_reviewed_status = ldwc_status.getitemnumber(ll_find,"lookup_code")
				dw_main.setitem(2,"reviewed_status",ll_reviewed_status)
				dw_main.setitem(2,'date_reviewed',today())
				dw_main.setitem(2,'reviewed_by',gs_user_id)	
			end if
		end if						
		//-------End added ----------------------------------				
		dw_main.RowsMove( 1, 1, Primary!, dw_main, 1, Filter! )
		
		cb_scan.visible = False
		This.Title = "Copy of Document"
end choose

//-----------Appeon Begin-----------------------------
//Set work flow. By alfee 04.24.2007
li_setting = of_get_app_setting("set_47","I")
If li_setting = 0 Then
		dw_main.object.wf_id_t.visible = False
		dw_main.object.wf_id.visible = False
		dw_main.object.description_t.y = dw_main.object.wf_id_t.y
		dw_main.object.description.height = String(Integer(dw_main.object.description.height) + Integer(dw_main.object.description.y) - Integer(dw_main.object.wf_id.y))
		dw_main.object.description.y = dw_main.object.wf_id.y	
END IF
//-----------Appeon End-------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Jack
//$<reason> Fix a defect.
ls_type = dw_main.getitemstring(dw_main.getrow(),'document_type')
If ls_type = 'DOC' Or ls_type = 'XLS' Then
	cb_scan.visible = False
End If
//---------------------------- APPEON END ----------------------------

//--------Begin Added by alfee 09.20.2007 ----------------------------
If w_mdi.of_security_access(6802) < 2 Then
	dw_main.Enabled = False
	cb_scan.Enabled = False
	cb_ok.Enabled = False
End If
//--------End Added ---------------------------------------------------


end event

on w_ctx_doc_properties.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.cb_scan=create cb_scan
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.cb_scan
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.gb_1
end on

on w_ctx_doc_properties.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.cb_scan)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

event pfc_save;Long ll_category, ll_status, ll_maxid, flen
string ls_name, ls_file, ls_file_original
Boolean lb_uploadfile = False
Datetime ldt_lastmodify

IF dw_main.AcceptText() <> 1 THEN return -1;
IF dw_main.Modifiedcount() < 1 THEN return 0;

ll_category = dw_main.GetItemNumber( 1, "category" )
IF isnull( ll_category ) THEN
	//messagebox( "Incomplete Data", "Category field can not be empty." )
	messagebox( "IntelliSoftGroup", "Required value missing for Document Category on row 1. Please enter a value." )
	dw_main.setcolumn( "category" )
	dw_main.setfocus()
	return -1
END IF

ls_name = Trim( dw_main.GetItemString( 1, "document_name" ) )
IF isnull( ls_name ) or ls_name = '' THEN
	//messagebox( "Incomplete Data", "Document Name field can not be empty." )
	messagebox( "IntelliSoftGroup", "Required value missing for Document Name on row 1. Please enter a value." )	
	dw_main.setcolumn( "document_name" )
	dw_main.setfocus()
	return -1
END IF
//verify the document name - Alfee 10.14.2008
IF Not inv_utils.of_verify_filename(ls_name) THEN RETURN -1

ll_status = dw_main.GetItemNumber( 1, "reviewed_status" )
IF isnull( ll_status ) THEN
	//messagebox( "Incomplete Data", "Reviewed Status field can not be empty." )
	messagebox( "IntelliSoftGroup", "Required value missing for Review Status on row 1. Please enter a value." )		
	dw_main.setcolumn( "reviewed_status" )
	dw_main.setfocus()
	return -1
END IF

//Validation on special fiels - added by alfee 09.03.2007
IF of_check_required() = -1 THEN RETURN -1

ls_file = Trim( dw_main.GetItemString( 1, "files" ))
IF dw_main.getitemstatus( 1, 0, Primary! ) = NewModified! THEN
	
	IF il_copied_doc_id = 0 THEN
		IF ls_file <> '' THEN
			IF NOT fileexists( ls_file ) THEN
				messagebox( "File", "File not found." )
				return -1;
			ELSE
				flen = FileLength( ls_file )
				if flen <= 0 then
					Messagebox( "Caution", "The file size of " + ls_file + " can not be zero!" )
					return -1;
				end if
				
				lb_uploadfile = True
			END IF
		END IF
	ELSE
		lb_uploadfile = True
	END IF
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.17.2007 By: Jack
	//$<reason> 
	/*
	SELECT max( ctx_acp_document.ctx_acp_document_id ) INTO :ll_maxid FROM ctx_acp_document;
	*/
	ll_maxid = gnv_app.of_get_id("ctx_acp_document_id")	
	//---------------------------- APPEON END ----------------------------
	//---------Begin Modified by (Appeon)Harry 10.30.2015 for  Bug id 4811--------
	/*
	IF isnull( ll_maxid ) THEN ll_maxid = 0
	ll_maxid ++;
	*/
	//---------End Modfiied ------------------------------------------------------
	dw_main.SetItem( 1, "ctx_acp_document_id", ll_maxid )
ELSE
	ls_file_original = Trim( dw_main.GetItemString( 1, "files", Primary!, True ))
	IF ls_file <> ls_file_original THEN
		IF NOT fileexists( ls_file ) THEN
			messagebox( "File", "File not found." )
			return -1;
		ELSE
			flen = FileLength( ls_file )
			if flen <= 0 then
				Messagebox( "Caution", "The file size of " + ls_file + " can not be zero!" )
				return -1;
			end if

			lb_uploadfile = True
		END IF
	END IF
END If

IF lb_uploadfile THEN
	ldt_lastmodify = Datetime( Today(), Now() )
	dw_main.SetItem( 1, "modify_date", ldt_lastmodify )
END IF

IF dw_main.update( False, False ) = 1 THEN
	dw_main.ResetUpdate()
	Commit Using SQLCA;
	il_doc_id = dw_main.getitemnumber( 1, "ctx_acp_document_id" )
	
	IF lb_uploadfile THEN
		IF il_copied_doc_id = 0 THEN
			of_filetodb()
		ELSE
			of_filecopytodb()
		END IF
		
		//To refresh the current displayed document - Alfee 01.17.2008
		IF IsValid(w_sheet_ctx_doc_painter) THEN 
			IF il_doc_id = w_sheet_ctx_doc_painter.il_currentopened THEN
				w_sheet_ctx_doc_painter.il_currentopened = 0
				Try 
					w_sheet_ctx_doc_painter.tab_1.tabpage_document.ole_word.object.close() 
					//-------------Begin Modified by Alfee on 05.19.2008------
					IF gi_imageocx = 1 THEN 
						//w_sheet_ctx_doc_painter.tab_1.tabpage_document.uo_1.of_show_blankimage( )
					ELSE
						w_sheet_ctx_doc_painter.tab_1.tabpage_document.uo_2.of_show_blankimage( )
					END IF
					//w_sheet_ctx_doc_painter.tab_1.tabpage_document.ole_tif_edit.object.cleardisplay()
					//-------------End Modified ------------------------------
				Catch(Runtimeerror e)
					//nothing - if the Word/ image controls not installed
				End Try
			END IF
		END IF		
	END IF

	Return 1;
ELSE
	Rollback Using SQLCA;
	//messagebox( "IntelliSoft", "Update failed!" )
	messagebox( "Update Error", "Update failed!" )
	Return -1;
END IF
end event

event closequery;Integer li_return, li_save
string ls_tempfile

If dw_main.AcceptText() < 1 Then Return 1
If dw_main.Deletedcount() > 0 OR dw_main.Modifiedcount() > 0 Then
	//li_return = Messagebox( "Caution", "Data in this window has been changed, do you want to save it before exit?",Question!,YesNoCancel!,3 )
	li_return = Messagebox( "IntelliSoftGroup", "Do you want to save changes?",exclamation!,YesNoCancel!,1 )	
	Choose Case li_return
		Case 1
			li_save = This.Trigger Event pfc_save()
			If li_save < 0 Then Return 1
		Case 3
			Return 1
	End Choose
End If

IF dw_main.Describe( "files.tag" ) = "scanned" THEN
	ls_tempfile = Trim( dw_main.GetItemString( 1, "files" ))
	FileDelete( ls_tempfile )
END IF

Return 0
end event

event close;call super::close;Message.DoubleParm = il_doc_id
destroy inv_right 
end event

type dw_main from u_dw_contract within w_ctx_doc_properties
event ue_enter pbm_dwnprocessenter
event ue_tabout pbm_dwntabout
integer x = 101
integer y = 80
integer width = 1627
integer height = 1240
integer taborder = 10
string dataobject = "d_ctx_document_properties"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event ue_enter;if Not this.getcolumnname() = "description" then
	Send(Handle(this),256,9,Long(0,0))
	return 1
end if
end event

event ue_tabout;cb_ok.post setfocus()
end event

event constructor;call super::constructor;this.event ue_populatedddws()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04-04-2007 By: Ken.Guo
//$<reason> Filter category data when current user have no access right.
inv_right = Create n_cst_right
datawindowchild ldwc_category
dw_main.getchild('category',ldwc_category)
inv_right.of_filter_right( ldwc_category, 'code', 4)
//---------------------------- APPEON END ----------------------------
end event

event dberror;//
end event

event buttonclicked;call super::buttonclicked;if dwo.name <> "b_browsefile" then return;

Integer li_return
String ls_filename, ls_fullname
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.12.2007 By: Machongmin
//$<reason> Fix a defect.
/*
li_return = GetFileOpenName ( "Select File", ls_fullname, ls_filename, "DOC", &
   + "Doc Files (*.DOC),*.DOC,Tif Files (*.TIF),*.TIF," &
	+ "Excel Files (*.XLS),*.XLS,All Files (*.*), *.*", gs_dir_path + gs_DefDirName + "\Agreement", 18 )
*/
string ls_doctype
if row > 0 then
	ls_doctype = this.object.document_type[row]
end if

gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
choose case upper(ls_doctype)
	case 'DOC'
		//----------------Begin Modified by Alfee 10.31.2007---------------------
		//<$Reason>to support Word 2007
		Integer li_pos, li_len_ext
		li_return = GetFileOpenName ( "Select File", ls_fullname, ls_filename, "DOC", &
			+ "Doc Files (*.DOCX;*.DOC),*.DOCX;*.DOC," &
			+ "All Files (*.*), *.*" )		
		/*li_return = GetFileOpenName ( "Select File", ls_fullname, ls_filename, "DOC", &
			+ "Doc Files (*.DOC),*.DOC," &
			+ "All Files (*.*), *.*", gs_dir_path + gs_DefDirName + "\Agreement", 18 )
		*/			
		//----------------End Modified ------------------------------------------
	case 'TIF'
		li_return = GetFileOpenName ( "Select File", ls_fullname, ls_filename, "TIF", &
			+ "Tif Files (*.TIF),*.TIF," &
			+ "All Files (*.*), *.*" )
	case 'XLS'
		li_return = GetFileOpenName ( "Select File", ls_fullname, ls_filename, "XLS", &
			+ "Excel Files (*.XLS),*.XLS," &
			+ "All Files (*.*), *.*" )
	case else 
		li_return = GetFileOpenName ( "Select File", ls_fullname, ls_filename, "*.*", &
			+ "All Files (*.*), *.*" )
	end choose
//---------------------------- APPEON END ----------------------------
gf_save_dir_path(ls_fullname) //Added by Ken.Guo on 2009-03-10
//ChangeDirectory(gs_current_path) //Added by Alfee 05.14.2007
if li_return < 1 then Return li_return;

This.SetItem( row, "files", ls_fullname )
This.SetColumn( "files" )
//-------------Begin Modified Alfee 10.31.2007 ----------------------
//<$Reason>Must be misspelled
//This.Post Event itemchanged( row, This.object.files, ls_filename )
This.Post Event itemchanged( row, This.object.files, ls_fullname ) 
//-------------End Modified -----------------------------------------

return 1;

end event

event itemchanged;call super::itemchanged;string ls_dwoname, ls_reversed, ls_type, ls_user
Integer li_pos
Long ll_approved, ll_cnt, ll_docid //
datetime ldt_reviewed

ls_dwoname = dwo.Name
choose case ls_dwoname
	case "files"
		ls_reversed = Reverse( data )
		li_pos = POS( ls_reversed, "." )
		if li_pos > 0 and li_pos <= 5 then
			ls_type = Left( ls_reversed, li_pos - 1 )
			ls_type = Upper( Reverse( ls_type ) )
			IF Left(ls_type, 3) = 'DOC' THEN ls_type = 'DOC' // Added by Alfee 10.31.2007			
			This.Setitem( row, "document_type", ls_type )
		end if
		
	case "reviewed_status"
		/*----------Commented by Alfee 11.13.2007-------------------		
		//----------Begin Added by Alfee 08.31.2007--------------
		//<$Reason>Don't change the approved status if it used already
		If is_operation = "changed" Then
			ll_docid = This.GetItemNumber(getrow(), "ctx_acp_document_id")
			ll_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Document Review Status' and code = 'Approved'"))	
			If il_status_ori = ll_approved and Long(data) <> ll_approved Then
				Select count(*) Into :ll_cnt From ctx_am_document Where base_type = '2' and from_templete_id = :ll_docid ;
				If ll_cnt > 0 Then 
					MessageBox("Alert Message","This field can't be changed until the document is removed from the affected file(s).")
					This.SetItem(getrow(), "reviewed_status", il_status_ori)
					Return 1
				End If
			End If
		End If
		//-----------End Added -------------------------------------		
		-------------End Commented -------------------------------*/
		if Long( data ) > 0 then
			This.SetItem( row, "reviewed_by", gs_user_id )
			This.SetItem( row, "date_reviewed", datetime( Today()) )
		end if
	case else
end choose
end event

event rbuttondown;pfc_u_dw::event trigger rbuttondown( xpos, ypos, row, dwo )
end event

type cb_scan from commandbutton within w_ctx_doc_properties
integer x = 1847
integer y = 456
integer width = 425
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Scan Document"
end type

event clicked;string ls_scanned_file

//--Begin Modified by Alfee on 07.28.2008-----
IF gi_imageocx = 1 THEN
	Open( w_ctx_doc_scan )
ELSE 
	Open( w_ctx_doc_scan_cp )
END IF
//Open( w_ctx_doc_scan )
//--End Modified -----------------------------

ls_scanned_file = Message.stringparm
if ls_scanned_file = '' then return

dw_main.Setitem( 1, "files", ls_scanned_file )
dw_main.Post Event itemchanged( 1, dw_main.object.files, ls_scanned_file )
dw_main.Modify( "files.tag = 'scanned'" )
end event

event constructor;
//Alfee 05.19.2008

//IF gi_imageocx <> 1 THEN this.visible = FALSE
end event

type cb_cancel from commandbutton within w_ctx_doc_properties
integer x = 1847
integer y = 128
integer width = 425
integer height = 84
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

event clicked;Close( Parent )
end event

type cb_ok from commandbutton within w_ctx_doc_properties
integer x = 1847
integer y = 32
integer width = 425
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;integer li_return

li_return = parent.trigger event pfc_save()

//-----Begin Modified by Alfee 01.07.2008---------
//<Reason>To rebuild the treeview if the category or doc type changed
IF li_return >= 0 THEN
	IF is_operation = 'changed' THEN
		IF il_category_ori <> dw_main.getitemnumber(dw_main.getrow(),'category') OR &
			is_doctype_ori <> dw_main.getitemString(dw_main.getrow(),'document_type') THEN
			IF IsValid(w_sheet_ctx_doc_painter) THEN w_sheet_ctx_doc_painter.ib_refresh_treeview = TRUE
		END IF
	END IF	
	Close( parent )	
END IF
//if li_return >= 0 then close( parent )
//-----End Added ---------------------------------
end event

type gb_1 from groupbox within w_ctx_doc_properties
integer x = 23
integer y = 4
integer width = 1797
integer height = 1388
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

