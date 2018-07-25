$PBExportHeader$w_tabpg_contract_doc_mgr.srw
forward
global type w_tabpg_contract_doc_mgr from w_child
end type
type cbx_auto from checkbox within w_tabpg_contract_doc_mgr
end type
type pb_open_in_default from picturebutton within w_tabpg_contract_doc_mgr
end type
type dw_dddw from u_dw within w_tabpg_contract_doc_mgr
end type
type pb_email from picturebutton within w_tabpg_contract_doc_mgr
end type
type pb_save_as from picturebutton within w_tabpg_contract_doc_mgr
end type
type uo_2 from u_tabpg_br_preview within w_tabpg_contract_doc_mgr
end type
type ln_1 from line within w_tabpg_contract_doc_mgr
end type
type ln_2 from line within w_tabpg_contract_doc_mgr
end type
end forward

global type w_tabpg_contract_doc_mgr from w_child
integer width = 1522
integer height = 1780
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event ue_open_with_default_program ( )
event ue_output_email ( )
event ue_output_saveas ( )
cbx_auto cbx_auto
pb_open_in_default pb_open_in_default
dw_dddw dw_dddw
pb_email pb_email
pb_save_as pb_save_as
uo_2 uo_2
ln_1 ln_1
ln_2 ln_2
end type
global w_tabpg_contract_doc_mgr w_tabpg_contract_doc_mgr

type variables
//n_cst_dm_utils  	inv_dm_utils
Long					il_ctx_id_old  = 0
Long 					il_doc_id_old = 0
Boolean				ibn_refresh = false
Long					il_ctx_id,   il_doc_id
Dec{1} 				idc_revision
String 				is_doc_ext

//Added By Mark Lee 11/05/2012
n_cst_dm_utils inv_dm_utils
n_cst_ovole_utils inv_ole_utils_doc

Long il_preview_doc_id
Decimal{1} idc_preview_revision
String is_opened_file

Integer ii_retrieve

str_add_doc istr_doc_info
end variables

forward prototypes
public subroutine of_adjustsize ()
public subroutine of_refreshdata ()
public function integer of_preview (long al_doc_id, decimal adc_revision, string as_doc_ext)
public subroutine of_selectole (string as_doctype)
public subroutine of_preview_excel (long al_doc_id, decimal adc_revision, string as_doc_ext)
public subroutine of_previewdoc (long al_doc_id, decimal adc_revision, string as_doc_ext)
public subroutine of_previewimage (long al_doc_id, decimal adc_revision, string as_doc_ext)
public subroutine of_reset ()
public function integer of_set_bg_color (long al_color_value)
end prototypes

event ue_open_with_default_program();//====================================================================
// Event: ue_open_with_default_program
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/02/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 	ls_null,ls_doc_nme
Long 		ll_row
String		ls_filetempname
Integer 	i,li_pos1,li_pos2
w_document_view lw_1
Str_add_doc lstr_doc_info


setnull(ls_null)

ll_row = dw_dddw.GetRow()
If ll_row <= 0 or il_doc_id = 0  Then 
	Return
End If

//Show tips if need
If gb_openwith_showtips Then
	Open(w_openwith_tips)
End If

//Download orginal file
ls_doc_nme = inv_dm_utils.of_download_file( il_doc_id, idc_revision)

//Copy to temp file
Do while i <= 20
	li_pos1 = lastpos(ls_doc_nme,'\')
	li_pos2 = lastpos(ls_doc_nme,'.')
	If li_pos1 > li_pos2 Then
		ls_filetempname = ls_doc_nme + '_temp' + String(i) //means no EXT name
	Else
		ls_filetempname = Mid(ls_doc_nme,1,li_pos2 - 1 ) + '_temp' + String(i) + Mid(ls_doc_nme,li_pos2)
	End If
	If FileCopy(ls_doc_nme,ls_filetempname,True) = 1 Then	
		Exit
	End If
	i++
Loop

If i > 20 Then
	Messagebox('Error','Failed to create the temp file '+ls_filetempname+', please call support.')
	Return
End If

//Open file with default program
IF FileExists(ls_filetempname) THEN
	if ShellExecuteA ( Handle( This ), ls_null, ls_filetempname , ls_Null, ls_Null, 4) <= 32 then
		run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_filetempname)
	end if
End If


end event

event ue_output_email();//====================================================================
// Event: ue_output_email
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/02/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer li_rtn
str_ctx_email lstr_ctx_email
string ls_flag
Long ll_find_row

If dw_dddw.rowcount( ) <=0 Or 	il_doc_id = 0 Then
	Return 
End If

//Display Message - jervis 07.16.2009
ls_flag = ProfileString(gs_IniFilePathName, "setup", "dispaly-message", "0")
if ls_flag = "0" then
	OpenWithParm(w_custom_help,ls_flag)
	if Upper(Message.StringParm) = "CANCEL" then return
end if

//Set document info.
//if iw_parent.classname() = 'w_contract' Then
	lstr_ctx_email.doc_from = 'DM'
	lstr_ctx_email.ctx_id =il_ctx_id
//End If

lstr_ctx_email.ctx_id_list[1] = il_ctx_id
lstr_ctx_email.doc_id_list[1] = il_doc_id
lstr_ctx_email.revision_list[1] = idc_revision

//Open email window 
w_mdi.SetRedraw(False)
SetPointer(HourGlass!)
OpenWithParm(w_dm_email_document_send, lstr_ctx_email)
w_mdi.SetRedraw(True)
end event

event ue_output_saveas();//====================================================================
// Event: ue_output_saveas
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/02/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer 					li_rtn
str_add_doc 			lstr_add_doc
str_add_audit 			lstr_add_audit
Datawindowchild		ldwc_dddw

If dw_dddw.rowcount( ) <= 0 or il_doc_id = 0 Then 
	Return 
End If

dw_dddw.Getchild( "doc_id", ldwc_dddw)
If ldwc_dddw.rowcount() <= 0 Then 
	Return 
Else
	lstr_add_doc.filename  = ldwc_dddw.GetItemString(ldwc_dddw.Getrow(),'doc_name')
End If

lstr_add_doc.doc_id = il_doc_id
lstr_add_doc.revision = idc_revision
lstr_add_doc.doc_ext = is_doc_ext

//if iw_parent.classname() = 'w_contract' Then
	lstr_add_doc.ctx_id = il_ctx_id
//End If
	
openwithparm(w_dm_saveto_document, lstr_add_doc)

SetPointer(Arrow!) //for refresh problem on new image ocx
end event

public subroutine of_adjustsize ();//====================================================================
// Function: of_AdjustSize
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/26/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long	ll_XPos,ll_YPos,ll_Width,ll_Height, ll_width_browse, ll_x_browse, ll_move_x, ll_move_x_browse
DataWindow	ldw_Browse, ldw_search
Long 		ll_width_doc_id

if IsValid(gw_Contract) then

	ldw_Browse = gw_Contract.tab_contract_details.tabpage_search.dw_search_det1
	ldw_search = gw_Contract.tab_contract_details.tabpage_search.dw_search

	ll_XPos = gw_Contract.tab_contract_details.X + gw_Contract.tab_contract_details.tabpage_search.X + ldw_search.X
	ll_YPos = gw_Contract.tab_contract_details.Y + gw_Contract.tab_contract_details.tabpage_search.Y + ldw_Browse.Y

	ll_Height = ldw_Browse.height
	
	//Position Setting		// 1 : Document Preview left ; 					0 : Document Preview right;			
								// 1 : Contract Parent Child Tree right; 		0 : Contract Parent Child Tree Left;
	If Isnull(gw_Contract.tab_contract_details.tabpage_search.is_position_setting ) & 
		Or trim(gw_Contract.tab_contract_details.tabpage_search.is_position_setting) = '' &
		Or gw_Contract.tab_contract_details.tabpage_search.is_position_setting = '1' then
		ll_move_x = ll_XPos
//		ll_Width	= gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x - ll_XPos  //Added By Mark Lee 04/15/2013 bug
		ll_Width	= gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x - ll_XPos  + 10
		//Added By Mark Lee 04/07/2013
//		ll_x_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x + gw_Contract.tab_contract_details.tabpage_search.st_vbar2.width + 10
		ll_x_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x + gw_Contract.tab_contract_details.tabpage_search.st_vbar2.width 
		If gw_Contract.tab_contract_details.tabpage_search.st_vbar.visible = True	 Then
			ll_width_browse =  gw_Contract.tab_contract_details.tabpage_search.st_vbar.x - ll_x_browse
		Else
			//Added By Mark Lee 04/07/2013
//			ll_width_browse = ldw_search.width + ll_XPos  - ll_x_browse 
			ll_width_browse = ldw_search.width +  ldw_search.x   - ll_x_browse 
		End If
	Else 
//		ll_move_x = gw_Contract.tab_contract_details.tabpage_search.st_vbar.x + gw_Contract.tab_contract_details.tabpage_search.st_vbar.width + 10 + 8 +18
		ll_move_x =  gw_Contract.tab_contract_details.X + gw_Contract.tab_contract_details.tabpage_search.X + gw_Contract.tab_contract_details.tabpage_search.st_vbar.x + gw_Contract.tab_contract_details.tabpage_search.st_vbar.width + 10
		//Added By Mark Lee 04/07/2013
//		ll_Width  = ldw_search.x + ldw_search.width - ll_move_x + 18
		ll_Width  = ll_XPos + ldw_search.width - ll_move_x  

		If gw_Contract.tab_contract_details.tabpage_search.st_vbar2.visible = True	 Then
			//Added By Mark Lee 04/07/2013			
//			ll_x_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x  + gw_Contract.tab_contract_details.tabpage_search.st_vbar2.width + 10
			ll_x_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x  + gw_Contract.tab_contract_details.tabpage_search.st_vbar2.width + 10
			ll_width_browse =  gw_Contract.tab_contract_details.tabpage_search.st_vbar.x - ll_x_browse
		Else
			//Added By Mark Lee 04/07/2013
//			ll_x_browse = ll_XPos + 10
			ll_x_browse = ldw_search.x 
//			ll_width_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar.x - ll_XPos 
			ll_width_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar.x - ldw_search.x 
		End If
	End If
		
	This.Move(ll_move_x,ll_YPos)
	This.Resize(ll_Width,ll_Height) 

//	gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.move( ll_x_browse, ldw_Browse.Y)
//	gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.resize(ll_width_browse, ldw_Browse.height)
	gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.x =	ll_x_browse
	gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.width = ll_width_browse

	gw_Contract.tab_contract_details.tabpage_search.gb_document_view.move(ll_move_x, ll_YPos)			
	gw_Contract.tab_contract_details.tabpage_search.gb_document_view.resize( ll_Width, ll_Height)
end if

ll_Width = dw_dddw.width
ll_width_doc_id = Long(dw_dddw.describe( "doc_id.width"))
If  ll_width_doc_id + 20  <> ll_Width Then
	dw_dddw.modify("doc_id.width ="+string(ll_Width - 20))
End If


end subroutine

public subroutine of_refreshdata ();//====================================================================
// Function: of_refreshdata
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/26/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long		ll_find
DatawindowChild	ldwc_dddw

if IsValid(gw_Contract) then
	If gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.rowcount( ) > 0 then
		il_ctx_id = gw_Contract.tab_contract_details.tabpage_search.il_ctx_id
		If il_ctx_id_old <> il_ctx_id or ibn_refresh = True Then
			ibn_refresh = False
			dw_dddw.reset( )
			dw_dddw.Getchild( "doc_id", ldwc_dddw)
		
			il_ctx_id_old = il_ctx_id
			dw_dddw.insertrow(0)
			ldwc_dddw.settransobject(sqlca)
			ldwc_dddw.retrieve( )
//		ldwc_dddw.setfilter( "")
//		ldwc_dddw.filter( )
			ldwc_dddw.setfilter( " ctx_id = "+string(il_ctx_id)+" ")
			ldwc_dddw.filter( )
		
			ll_find = ldwc_dddw.find( " Primary_doc = '1' ",1, ldwc_dddw.rowcount())
			If ll_find > 0 then 
				ldwc_dddw.scrolltorow( ll_find)
				ldwc_dddw.setrow( ll_find)
				il_doc_id  = ldwc_dddw.GetItemDecimal( ll_find, "doc_id")
				idc_revision = ldwc_dddw.GetItemDecimal( ll_find, "revision")
				is_doc_ext = ldwc_dddw.GetItemString( ll_find, "doc_ext")
				dw_dddw.setitem( dw_dddw.getrow(), 'doc_id', il_doc_id)
				dw_dddw.accepttext( )
				il_doc_id_old = il_doc_id
				
				//Preview 
				If cbx_auto.checked = true Then 
					of_preview(il_doc_id,idc_revision,is_doc_ext)
				End If
			Else
				il_doc_id = 0 		//clear data
				uo_2.uo_1.SetPosition(ToBottom!)
				uo_2.ole_word.SetPosition(ToTop!)
				uo_2.uo_1.visible = false 
				uo_2.ole_word.visible = true

				uo_2.ole_word.object.close()
				uo_2.uo_1.of_show_blankimage( )
			End If
		End If
	End If 
end if



end subroutine

public function integer of_preview (long al_doc_id, decimal adc_revision, string as_doc_ext);//====================================================================
// Function: of_preview
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_doc_id
//                adc_revision
//                as_doc_ext
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/30/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
string ls_null
String ls_doc_nme
long	 ll_size
str_add_audit lstr_add_audit

CHOOSE CASE Lower(as_doc_ext)
	CASE 'bmp','tif','tiff','jpg','gif','pdf' 			//'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
		of_previewimage(al_doc_id,adc_revision,as_doc_ext)
//	CASE 'pdf' 
//		if gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '1' Then 
//			//Open with CL
//			of_previewimage(al_doc_id,as_doc_ext,adc_revision)			
//		Else
//			//Open with default windows program
//			setnull(ls_null)
//			ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
//			IF FileExists(ls_doc_nme) THEN
//				if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
//					run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
//				end if
//			END IF			
//		End If
	CASE 'doc'
		of_previewdoc(al_doc_id,adc_revision,as_doc_ext)
	Case 'xls','xlsx' 
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
			End If
		End If
	CASE 'htm','html'
		uo_2.uo_1.SetPosition(ToBottom!)
		uo_2.ole_word.SetPosition(ToTop!)
		uo_2.uo_1.visible = false 
		uo_2.ole_word.visible = true
		uo_2.ole_word.object.close()
		uo_2.uo_1.of_show_blankimage( )
		
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
			//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
		   	//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_doc_nme, ls_Null, 4)
			ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_doc_nme, ls_Null, 4)
			//---------End Modfiied ------------------------------------------------------
		End If
	CASE else
		uo_2.uo_1.SetPosition(ToBottom!)
		uo_2.ole_word.SetPosition(ToTop!)
		uo_2.uo_1.visible = false 
		uo_2.ole_word.visible = true
	 	uo_2.ole_word.object.close()
 		uo_2.uo_1.of_show_blankimage( )
	
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
			if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
				run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
			end if
		END IF
END CHOOSE

return 1 
end function

public subroutine of_selectole (string as_doctype);//====================================================================
// Function: of_selectole
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_doctype
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/31/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 			ll_x ,ll_width

IF lower(as_doctype) = 'doc' THEN
	uo_2.uo_1.SetPosition(ToBottom!)
	uo_2.ole_word.SetPosition(ToTop!)
	uo_2.uo_1.visible = false
	uo_2.ole_word.visible = true	

ELSEIf lower(as_doctype) = 'xls' or lower(as_doctype) = 'xlsx' Then 
	uo_2.uo_1.SetPosition(ToBottom!)
	uo_2.ole_word.SetPosition(ToTop!)
	uo_2.uo_1.visible = false 
	uo_2.ole_word.visible = true

Else	
	uo_2.ole_word.SetPosition(ToBottom!)
	uo_2.uo_1.SetPosition(ToTop!)
	uo_2.uo_1.visible = True	
	uo_2.ole_word.visible = false

	//move the position
	ll_x = uo_2.uo_1.uo_toolbar.pb_imagetools.x
	ll_width = uo_2.uo_1.uo_toolbar.pb_imagetools.width
	uo_2.uo_1.uo_toolbar.st_pages.x 	= ll_x +  ll_width
	uo_2.uo_1.uo_toolbar.cb_first.x = uo_2.uo_1.uo_toolbar.st_pages.x +uo_2.uo_1.uo_toolbar.st_pages.width
	uo_2.uo_1.uo_toolbar.cb_prior.x = uo_2.uo_1.uo_toolbar.cb_first.x + uo_2.uo_1.uo_toolbar.cb_first.width
	uo_2.uo_1.uo_toolbar.em_page.x 	= uo_2.uo_1.uo_toolbar.cb_prior.x + uo_2.uo_1.uo_toolbar.cb_prior.width
	uo_2.uo_1.uo_toolbar.cb_next.x 	= uo_2.uo_1.uo_toolbar.em_page.x + uo_2.uo_1.uo_toolbar.em_page.width
	uo_2.uo_1.uo_toolbar.cb_last.x 	= uo_2.uo_1.uo_toolbar.cb_next.x + uo_2.uo_1.uo_toolbar.cb_next.width
	
END IF




end subroutine

public subroutine of_preview_excel (long al_doc_id, decimal adc_revision, string as_doc_ext);of_previewdoc(al_doc_id,adc_revision,as_doc_ext)

end subroutine

public subroutine of_previewdoc (long al_doc_id, decimal adc_revision, string as_doc_ext);//====================================================================
// Function: of_previewdoc
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_doc_id
//                as_doc_ext
//                adc_revision
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/31/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long ll_row, ll_level
integer li_rtn
string ls_doc_ext, ls_filename, ls_filename_tmp

//Choose OLE control for different type of document
of_selectole(as_doc_ext)

OpenWithParm(w_appeon_gifofwait, "Opening the selected document...")

//do wait
if isvalid(w_appeon_gifofwait) then
	if w_appeon_gifofwait.hpb_1.position < 80 then
		w_appeon_gifofwait.hpb_1.position = 80
	end if
	 w_appeon_gifofwait.event timer()
end if	

//Get the file 
ls_filename = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
//SetReDraw(FALSE)				//Comment By Mark Lee 12/17/2012
IF FileExists(ls_filename) THEN
	li_rtn = inv_ole_utils_doc.of_displayfile(ls_filename, TRUE)
	is_opened_file = ls_filename
END IF

if isvalid(w_appeon_gifofwait) then
	if w_appeon_gifofwait.hpb_1.position < 80 then
		w_appeon_gifofwait.hpb_1.position = 80
	end if
end if
//SetReDraw(TRUE)			//Comment By Mark Lee 12/17/2012
If isvalid(w_appeon_gifofwait) Then
	Close(w_appeon_gifofwait)
End If

end subroutine

public subroutine of_previewimage (long al_doc_id, decimal adc_revision, string as_doc_ext);//====================================================================
// Function: of_previewimage
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_doc_id
//                as_doc_ext
//                adc_revision
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/31/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long ll_row, ll_doc_id
decimal ldc_revision
datetime ldt_modify_date
string ls_doc_ext, ls_filename
Integer li_rtn 

//Choose OLE control for different type of document
of_selectole(as_doc_ext)
SetReDraw(FALSE)
//Load image document
li_rtn = uo_2.uo_1.event ue_load_image2(al_doc_id,adc_revision,as_doc_ext)
SetReDraw(True)
//page
uo_2.uo_1.of_set_viewstyle( "page")

//readonly
uo_2.uo_1.event ue_set_security(False)


end subroutine

public subroutine of_reset ();//====================================================================
// Function: of_reset
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/03/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


dw_dddw.reset( )

il_ctx_id_old = 0 
il_doc_id = 0 		//clear data
uo_2.uo_1.SetPosition(ToBottom!)
uo_2.ole_word.SetPosition(ToTop!)
uo_2.uo_1.visible = false 
uo_2.ole_word.visible = true

uo_2.ole_word.object.close()
uo_2.uo_1.of_show_blankimage( )
end subroutine

public function integer of_set_bg_color (long al_color_value);//Added By Ken.Guo 04/10/2013
This.backcolor =  al_color_value
This.cbx_auto.backcolor =  al_color_value
Return 1
end function

on w_tabpg_contract_doc_mgr.create
int iCurrent
call super::create
this.cbx_auto=create cbx_auto
this.pb_open_in_default=create pb_open_in_default
this.dw_dddw=create dw_dddw
this.pb_email=create pb_email
this.pb_save_as=create pb_save_as
this.uo_2=create uo_2
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_auto
this.Control[iCurrent+2]=this.pb_open_in_default
this.Control[iCurrent+3]=this.dw_dddw
this.Control[iCurrent+4]=this.pb_email
this.Control[iCurrent+5]=this.pb_save_as
this.Control[iCurrent+6]=this.uo_2
this.Control[iCurrent+7]=this.ln_1
this.Control[iCurrent+8]=this.ln_2
end on

on w_tabpg_contract_doc_mgr.destroy
call super::destroy
destroy(this.cbx_auto)
destroy(this.pb_open_in_default)
destroy(this.dw_dddw)
destroy(this.pb_email)
destroy(this.pb_save_as)
destroy(this.uo_2)
destroy(this.ln_1)
destroy(this.ln_2)
end on

event pfc_preopen;call super::pfc_preopen;this.of_setresize(true)
this.inv_resize.of_setminsize( 800, 600 )
this.inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())

this.inv_resize.of_Register(dw_dddw, this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(cbx_auto, this.inv_resize.FIXEDRIGHT)

this.inv_resize.of_Register(ln_2,this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(ln_1,this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(uo_2,this.inv_resize.SCALERIGHTBOTTOM)



end event

event open;call super::open;String 		ls_auto_preview

//Begin - Added By Mark Lee 11/05/2012
inv_ole_utils_doc = Create n_cst_ovole_utils 
inv_ole_utils_doc.of_initial(uo_2.ole_word )
//End - Added By Mark Lee 11/05/2012

ls_auto_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Document_Preview_Auto" )
If isnull(ls_auto_preview) Or trim(ls_auto_preview) = '' Or ls_auto_preview = '1' Then 
	cbx_auto.checked = True
Else
	cbx_auto.checked = False
End If

If IsValid(gw_contract) Then
	this.backcolor =  Long(w_Contract.tab_contract_details.tabpage_search.dw_search_det1.describe("Datawindow.color"))
	this.cbx_auto.backcolor =  Long(w_Contract.tab_contract_details.tabpage_search.dw_search_det1.describe("Datawindow.color"))
//	gnv_win_backcolor.of_ChangeWindowBackColor(this)				//Modified By Mark Lee 12/06/2012
End If

//Added By Mark Lee 10/26/12
if IsValid(gw_Contract) then

	this.of_AdjustSize()	
	//refreshdata
//	this.of_refreshdata()
end if



end event

event resize;call super::resize;//if isvalid(inv_resize) then
//   this.inv_resize.of_resize( this.control[],handle(this)  )
//end if

////Added By Mark Lee 10/30/2012
//dw_dddw.of_resize( )
end event

event close;call super::close;//Added By Mark Lee 11/05/2012
If isvalid(inv_ole_utils_doc) Then Destroy inv_ole_utils_doc


end event

event rbuttondown;call super::rbuttondown;m_contract_search_document_preview	lm_Menu


If isnull(il_doc_id_old) or il_doc_id_old = 0 Then 
	Return 
End If

lm_Menu =  Create m_contract_search_document_preview

If w_mdi.of_security_access( 6905 ) = 0 Then
	m_contract_search_document_preview.m_email.visible = False
End If

If w_mdi.of_security_access( 6907 ) = 0 Then
	m_contract_search_document_preview.m_email.visible = False
End If

If w_mdi.of_security_access( 6909 ) = 0 Then
	m_contract_search_document_preview.m_saveas.visible = False
End If

lm_Menu.PopMenu(w_mdi.PointerX(),w_mdi.PointerY())

Destroy lm_Menu
end event

type cbx_auto from checkbox within w_tabpg_contract_doc_mgr
integer x = 1115
integer y = 156
integer width = 393
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Preview"
end type

event clicked;String 		ls_auto_preview, ls_checked
Long			ll_doc_id

ls_auto_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Document_Preview_Auto" )

If this.checked = True Then 
	ls_checked = '1'
Else
	ls_checked = '0'
End If

If isnull(ls_auto_preview) Or trim(ls_auto_preview) = '' then 
	gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_Display_Document_Preview_Auto",ls_checked )
	gnv_user_option.of_save( )	
ElseIf ls_auto_preview <> ls_checked Then 
	gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_Display_Document_Preview_Auto",ls_checked )
	gnv_user_option.of_save( )		
End If

If ls_checked = '1' Then 
	il_ctx_id = gw_Contract.tab_contract_details.tabpage_search.il_ctx_id
	IF dw_dddw.rowcount( ) > 0 Then 
		ll_doc_id = dw_dddw.getItemNumber( dw_dddw.GetRow(),"doc_id")
		If not isnull(ll_doc_id) and ll_doc_id > 0 then 
			//preview
			of_preview(ll_doc_id,idc_revision,is_doc_ext)
		End If
	End If		
Else
		uo_2.uo_1.SetPosition(ToBottom!)
		uo_2.ole_word.SetPosition(ToTop!)
		uo_2.uo_1.visible = false 
		uo_2.ole_word.visible = true
	 	uo_2.ole_word.object.close()
 		uo_2.uo_1.of_show_blankimage( )
End If
end event

type pb_open_in_default from picturebutton within w_tabpg_contract_doc_mgr
string tag = "Open in Default Program"
integer x = 238
integer y = 136
integer width = 110
integer height = 96
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "open_default_program.gif"
alignment htextalign = left!
string powertiptext = "Open in Default Program"
end type

event clicked;parent.postevent( "ue_open_with_default_program")
end event

type dw_dddw from u_dw within w_tabpg_contract_doc_mgr
integer y = 4
integer width = 1513
integer height = 104
integer taborder = 90
string dataobject = "d_dddw_tabpg_contract_doc_mgr"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;Long		 ll_find
DatawindowChild	ldwc_dddw


//Added By Mark Lee 11/01/2012
If row <= 0 Then 
	Return
End If

this.accepttext( )
Choose  case  dwo.name
	Case 'doc_id'
		if IsValid(gw_Contract) then
			If gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.rowcount( ) > 0 then
				il_ctx_id = gw_Contract.tab_contract_details.tabpage_search.il_ctx_id
		
				IF dw_dddw.rowcount( ) > 0 Then 
					dw_dddw.Getchild( "doc_id", ldwc_dddw)
					il_doc_id  = Long(data)
					If il_doc_id_old <> il_doc_id Then 
						idc_revision = ldwc_dddw.GetItemDecimal( ldwc_dddw.getrow(), "revision")
						is_doc_ext = ldwc_dddw.GetItemString( ldwc_dddw.getrow(), "doc_ext")
						il_doc_id_old = il_doc_id
						//preview
						IF cbx_auto.checked = True Then 
							of_preview(il_doc_id,idc_revision,is_doc_ext)
						End If
					End If
				Else
					il_doc_id = 0
					il_ctx_id = 0 
				End If 
			End If 
		end if
	Case Else
		//
	End Choose


end event

event clicked;call super::clicked;
If row > 0 Then
	this.setfocus( )
	setcolumn(1)
End  If
end event

event constructor;call super::constructor;This.of_setrowselect(False)

end event

type pb_email from picturebutton within w_tabpg_contract_doc_mgr
string tag = "Email"
integer x = 9
integer y = 136
integer width = 110
integer height = 96
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean originalsize = true
string picturename = "custom003!"
alignment htextalign = left!
string powertiptext = "Email"
end type

event clicked;parent.postevent( "ue_output_email")
end event

type pb_save_as from picturebutton within w_tabpg_contract_doc_mgr
string tag = "Save As"
integer x = 123
integer y = 136
integer width = 110
integer height = 96
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "SaveAs!"
alignment htextalign = left!
string powertiptext = "Save As"
end type

event clicked;parent.postevent( "ue_output_saveas")
end event

type uo_2 from u_tabpg_br_preview within w_tabpg_contract_doc_mgr
integer y = 248
integer width = 1513
integer height = 1532
integer taborder = 100
end type

on uo_2.destroy
call u_tabpg_br_preview::destroy
end on

event constructor;call super::constructor;//Added By Mark Lee 10/31/2012
this.ole_word.SetPosition(ToTop!)
end event

type ln_1 from line within w_tabpg_contract_doc_mgr
integer linethickness = 4
integer beginx = 5
integer beginy = 240
integer endx = 1518
integer endy = 240
end type

type ln_2 from line within w_tabpg_contract_doc_mgr
integer linethickness = 4
integer beginx = 5
integer beginy = 124
integer endx = 1518
integer endy = 124
end type

