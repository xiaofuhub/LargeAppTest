$PBExportHeader$w_document_view.srw
forward
global type w_document_view from w_sheet
end type
type uo_1 from u_tabpg_br_preview within w_document_view
end type
type cb_close from commandbutton within w_document_view
end type
end forward

global type w_document_view from w_sheet
integer width = 3835
integer height = 1972
string title = "Document Viewer"
long backcolor = 33551856
boolean center = true
event ue_preview ( long al_doc_id,  decimal adc_revision,  string as_doc_ext )
uo_1 uo_1
cb_close cb_close
end type
global w_document_view w_document_view

type variables
n_cst_dm_utils inv_dm_utils
n_cst_ovole_utils inv_ole_utils_doc

Long il_preview_doc_id
Decimal{1} idc_preview_revision
String is_opened_file

Integer ii_retrieve

str_add_doc istr_doc_info
end variables

forward prototypes
public subroutine of_previewimage (long al_doc_id, decimal adec_revision, string as_doc_ext)
public subroutine of_previewdoc (long al_doc_id, decimal adec_revision, string as_doc_ext)
public subroutine of_preview_excel (long al_doc_id, decimal adec_revision, string as_doc_ext)
public function integer of_check_track_viewing ()
end prototypes

event ue_preview(long al_doc_id, decimal adc_revision, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<event>ue_previewu_tabpg_dm_data_master_browse()
// $<arguments>
//		value	long   	al_doc_id    		Document ID
//		value	decimal	adc_revision		Document revision
//		value	string 	as_doc_ext   		Document extended name, such as doc,tif
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.06.2007 by Davis
//////////////////////////////////////////////////////////////////////

string ls_null
String ls_doc_nme
long	 ll_size
str_add_audit lstr_add_audit
		
CHOOSE CASE Lower(as_doc_ext)
	CASE 'bmp','tif','tiff','jpg','gif','pdf'//'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
		of_previewimage(al_doc_id,adc_revision,as_doc_ext)
	CASE 'doc'
		of_previewdoc(al_doc_id,adc_revision,as_doc_ext)
	Case 'xls','xlsx' //Added By Ken.Guo 2009-09-07.
		If gs_word_version = 'word2007' Then
			of_preview_excel(al_doc_id,adc_revision,as_doc_ext)
		Else
			If Lower(as_doc_ext) = 'xls' Then
				of_preview_excel(al_doc_id,adc_revision,as_doc_ext)
			Else
				//excel 2003 application open 2007 file.
				setnull(ls_null)
				ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
				IF FileExists(ls_doc_nme) THEN
					if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
						run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
					end if
				End If
				
				//Begin - Added By Mark Lee 11/05/2012
//				lstr_add_audit.doc_id = al_doc_id
//				lstr_add_audit.revision = adc_revision
//				lstr_add_audit.doc_ext = as_doc_ext
//				lstr_add_audit.action = "Viewed"
//				inv_dm_utils.of_add_audit_trail( lstr_add_audit )
				If of_check_track_viewing() = 1 then 
					lstr_add_audit.doc_id = al_doc_id
					lstr_add_audit.revision = adc_revision
					lstr_add_audit.doc_ext = as_doc_ext
					lstr_add_audit.action = "Viewed"
					inv_dm_utils.of_add_audit_trail( lstr_add_audit )
				End If
				//End - Added By Mark Lee 11/05/2012
			End If
		End If
	CASE 'htm','html'
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
	   	//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_doc_nme, ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_doc_nme, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		END IF
	//Begin - Added By Mark Lee 11/05/2012
		If of_check_track_viewing() = 1 then 
			lstr_add_audit.doc_id = al_doc_id
			lstr_add_audit.revision = adc_revision
			lstr_add_audit.doc_ext = as_doc_ext
			lstr_add_audit.action = "Viewed"
			inv_dm_utils.of_add_audit_trail( lstr_add_audit )		
		End If		
	//End - Added By Mark Lee 11/05/2012		
	CASE else
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
			if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
				run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
			end if
		END IF

		//Begin - Added By Mark Lee 11/05/2012
		If of_check_track_viewing() = 1 then 
			lstr_add_audit.doc_id = al_doc_id
			lstr_add_audit.revision = adc_revision
			lstr_add_audit.doc_ext = as_doc_ext
			lstr_add_audit.action = "Viewed"
			inv_dm_utils.of_add_audit_trail( lstr_add_audit )		
		End If		
		//End - Added By Mark Lee 11/05/2012					
END CHOOSE

end event

public subroutine of_previewimage (long al_doc_id, decimal adec_revision, string as_doc_ext);uo_1.uo_1.visible = True
uo_1.ole_word.visible = False
uo_1.uo_1.event ue_load_image2( al_doc_id, adec_revision,as_doc_ext) 
end subroutine

public subroutine of_previewdoc (long al_doc_id, decimal adec_revision, string as_doc_ext);long ll_row
integer li_rtn
string ls_doc_ext, ls_filename, ls_filename_tmp


uo_1.ole_word.visible = True
uo_1.uo_1.visible = False

if gb_IsDocMode then
	OpenWithParm(w_appeon_gifofwait, "Opening Document...")
else
	OpenWithParm(w_appeon_gifofwait, "Opening the selected document...")
end if

ls_filename = inv_dm_utils.of_download_file( al_doc_id, adec_revision)

//SetReDraw(FALSE)

IF FileExists(ls_filename) THEN
	li_rtn = inv_ole_utils_doc.of_displayfile(ls_filename, TRUE)
	is_opened_file = ls_filename
END IF

if isvalid(w_appeon_gifofwait) then
	if w_appeon_gifofwait.hpb_1.position < 80 then
		w_appeon_gifofwait.hpb_1.position = 80
	end if
end if

//SetReDraw(TRUE)
//Begin - Added By Mark Lee 11/05/2012
If of_check_track_viewing() = 1 then 	
	str_add_audit lstr_add_audit
	lstr_add_audit.doc_id = al_doc_id
	lstr_add_audit.revision = adec_revision
	lstr_add_audit.doc_ext = as_doc_ext
	lstr_add_audit.action = "Viewed"
	inv_dm_utils.of_add_audit_trail( lstr_add_audit )
End If
//End - Added By Mark Lee 11/05/2012

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)

end subroutine

public subroutine of_preview_excel (long al_doc_id, decimal adec_revision, string as_doc_ext);of_previewdoc(al_doc_id,adec_revision,as_doc_ext)


end subroutine

public function integer of_check_track_viewing ();//====================================================================
// Function: of_check_track_viewing
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/05/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 			ls_track_viewing

ls_track_viewing = gnv_data.of_getItem('icred_settings','track_viewing',false) 

If isnull(ls_track_viewing) or trim(ls_track_viewing) = '' or integer(ls_track_viewing) = 0 Then 
	return 0
Else
	return 1
End If 


end function

on w_document_view.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.cb_close
end on

on w_document_view.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.cb_close)
end on

event open;call super::open;
istr_doc_info = Message.powerobjectparm

uo_1.resize(This.width,This.Height)
uo_1.uo_1.visible = False
uo_1.ole_word.visible = False

inv_ole_utils_doc = Create n_cst_ovole_utils 
inv_ole_utils_doc.of_initial(uo_1.ole_word )


end event

event close;call super::close;
If isvalid(inv_ole_utils_doc) Then Destroy inv_ole_utils_doc



end event

event resize;call super::resize;uo_1.resize(newwidth - 20, newheight - 180 )
cb_close.move(newwidth - 388,newheight - 140)

end event

event pfc_postopen;call super::pfc_postopen;
If Isvalid(istr_doc_info) Then
	This.event Post ue_preview(istr_doc_info.doc_id , istr_doc_info.revision , istr_doc_info.doc_ext )
	This.title = 'Document Viewer - Contract ID: ' +String(istr_doc_info.ctx_id)+ ' Document Name: ' + istr_doc_info.filename + '.' + istr_doc_info.doc_ext 
End If

end event

type uo_1 from u_tabpg_br_preview within w_document_view
event destroy ( )
integer x = 9
integer y = 8
integer width = 3790
integer height = 1736
integer taborder = 130
end type

on uo_1.destroy
call u_tabpg_br_preview::destroy
end on

type cb_close from commandbutton within w_document_view
integer x = 2939
integer y = 1756
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

