$PBExportHeader$w_documents_browse_old.srw
forward
global type w_documents_browse_old from w_sheet
end type
type cbx_retrieve from checkbox within w_documents_browse_old
end type
type st_docinfo from statictext within w_documents_browse_old
end type
type cb_close from commandbutton within w_documents_browse_old
end type
type cb_retrieve from commandbutton within w_documents_browse_old
end type
type tab_1 from tab within w_documents_browse_old
end type
type tabpage_browse from u_tabpg_br_browse within tab_1
end type
type tabpage_browse from u_tabpg_br_browse within tab_1
end type
type tabpage_preview from u_tabpg_br_preview within tab_1
end type
type tabpage_preview from u_tabpg_br_preview within tab_1
end type
type tab_1 from tab within w_documents_browse_old
tabpage_browse tabpage_browse
tabpage_preview tabpage_preview
end type
end forward

global type w_documents_browse_old from w_sheet
integer width = 3771
integer height = 1980
string title = "Documents Browse"
windowstate windowstate = maximized!
event ue_preview ( long al_doc_id,  decimal adc_revision,  string as_doc_ext )
event ue_openinnewwindow ( )
cbx_retrieve cbx_retrieve
st_docinfo st_docinfo
cb_close cb_close
cb_retrieve cb_retrieve
tab_1 tab_1
end type
global w_documents_browse_old w_documents_browse_old

type variables
n_cst_dm_utils inv_dm_utils
n_cst_ovole_utils inv_ole_utils_doc

Long il_preview_doc_id
Decimal{1} idc_preview_revision
String is_opened_file

Integer ii_retrieve
end variables

forward prototypes
public subroutine of_previewimage (long al_doc_id, decimal adec_revision, string as_doc_ext)
public subroutine of_previewdoc (long al_doc_id, decimal adec_revision, string as_doc_ext)
public subroutine of_preview_excel (long al_doc_id, decimal adec_revision, string as_doc_ext)
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
	CASE 'bmp','tif','tiff','jpg','gif'//'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
		of_previewimage(al_doc_id,adc_revision,as_doc_ext)
		If tab_1.selectedtab = 1 Then
			tab_1.post selecttab(2)
		End If		
	CASE 'doc'
		of_previewdoc(al_doc_id,adc_revision,as_doc_ext)
		If tab_1.selectedtab = 1 Then
			tab_1.post selecttab(2)
		End If
	Case 'xls','xlsx' //Added By Ken.Guo 2009-09-07.
		If gs_word_version = 'word2007' Then
			of_preview_excel(al_doc_id,adc_revision,as_doc_ext)
			If tab_1.selectedtab = 1 Then
				tab_1.post selecttab(2)
			End If		
		Else
			If Lower(as_doc_ext) = 'xls' Then
				of_preview_excel(al_doc_id,adc_revision,as_doc_ext)
				If tab_1.selectedtab = 1 Then
					tab_1.post selecttab(2)
				End If				
			Else
				//excel 2003 application open 2007 file.
				IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
				setnull(ls_null)
				ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
				IF FileExists(ls_doc_nme) THEN
					if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
						run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
					end if
				End If
				lstr_add_audit.doc_id = al_doc_id
				lstr_add_audit.revision = adc_revision
				lstr_add_audit.doc_ext = as_doc_ext
				lstr_add_audit.action = "Viewed"
				inv_dm_utils.of_add_audit_trail( lstr_add_audit )
			End If
		End If
	CASE 'htm','html'
		IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
		//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_doc_nme, ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_doc_nme, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		END IF

		lstr_add_audit.doc_id = al_doc_id
		lstr_add_audit.revision = adc_revision
		lstr_add_audit.doc_ext = as_doc_ext
		lstr_add_audit.action = "Viewed"
		inv_dm_utils.of_add_audit_trail( lstr_add_audit )		
	CASE else
		IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
			if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
				run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
			end if
		END IF

		lstr_add_audit.doc_id = al_doc_id
		lstr_add_audit.revision = adc_revision
		lstr_add_audit.doc_ext = as_doc_ext
		lstr_add_audit.action = "Viewed"
		inv_dm_utils.of_add_audit_trail( lstr_add_audit )		
				
END CHOOSE

end event

event ue_openinnewwindow();datawindow ldw_browse
Long ll_row
String ls_doc_ext
str_add_doc lstr_doc_info
w_document_view lw_1

ldw_browse = Tab_1.tabpage_browse.dw_browse
ll_row = ldw_browse.GetRow()
If ll_row <= 0 Then Return

ls_doc_ext = Lower(ldw_browse.getitemstring(ll_row,'ctx_am_document_doc_ext'))
CHOOSE CASE Lower(ls_doc_ext)
	CASE 'bmp','tif','tiff','jpg','gif', 'doc','xls','xlsx','pdf'
		lstr_doc_info.ctx_id = ldw_browse.GetItemNumber(ll_row,"ctx_id")
		lstr_doc_info.doc_id = ldw_browse.GetItemNumber(ll_row,"ctx_am_document_doc_id")
		lstr_doc_info.revision = ldw_browse.GetItemDecimal(ll_row,'ctx_am_document_revision')
		lstr_doc_info.filename = ldw_browse.GetItemString(ll_row,'compute_doc_name')
		lstr_doc_info.doc_ext = ls_doc_ext
		OpenWithParm(lw_1, lstr_doc_info )
End Choose

Return 
end event

public subroutine of_previewimage (long al_doc_id, decimal adec_revision, string as_doc_ext);Tab_1.tabpage_preview.uo_1.visible = True
Tab_1.tabpage_preview.ole_word.visible = False
Tab_1.tabpage_preview.uo_1.event ue_load_image2( al_doc_id, adec_revision,as_doc_ext) 
end subroutine

public subroutine of_previewdoc (long al_doc_id, decimal adec_revision, string as_doc_ext);long ll_row
integer li_rtn
string ls_doc_ext, ls_filename, ls_filename_tmp

tab_1.tabpage_preview.uo_1.visible = False
tab_1.tabpage_preview.ole_word.visible = True

ll_row  = tab_1.tabpage_browse.dw_browse.getrow()
IF ll_row < 1 THEN
	inv_ole_utils_doc.of_displayfile(ls_filename,TRUE)
	RETURN
END IF

st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,"compute_doc_name") 

IF al_doc_id = il_preview_doc_id AND adec_revision = idc_preview_revision THEN 
	RETURN 
END IF

if gb_IsDocMode then
	OpenWithParm(w_appeon_gifofwait, "Opening Document...")
else
	OpenWithParm(w_appeon_gifofwait, "Opening the selected document...")
end if

ls_filename = inv_dm_utils.of_download_file( al_doc_id, adec_revision)

SetReDraw(FALSE)

IF FileExists(ls_filename) THEN
	li_rtn = inv_ole_utils_doc.of_displayfile(ls_filename, TRUE)
	is_opened_file = ls_filename
END IF

if isvalid(w_appeon_gifofwait) then
	if w_appeon_gifofwait.hpb_1.position < 80 then
		w_appeon_gifofwait.hpb_1.position = 80
	end if
end if

IF li_rtn < 1 THEN
	il_preview_doc_id = -1
	idc_preview_revision = 0
ELSE
	il_preview_doc_id = al_doc_id
	idc_preview_revision = adec_revision
END IF
SetReDraw(TRUE)


str_add_audit lstr_add_audit
lstr_add_audit.doc_id = al_doc_id
lstr_add_audit.revision = adec_revision
lstr_add_audit.doc_ext = as_doc_ext
lstr_add_audit.action = "Viewed"
inv_dm_utils.of_add_audit_trail( lstr_add_audit )

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)

end subroutine

public subroutine of_preview_excel (long al_doc_id, decimal adec_revision, string as_doc_ext);of_previewdoc(al_doc_id,adec_revision,as_doc_ext)


end subroutine

on w_documents_browse_old.create
int iCurrent
call super::create
this.cbx_retrieve=create cbx_retrieve
this.st_docinfo=create st_docinfo
this.cb_close=create cb_close
this.cb_retrieve=create cb_retrieve
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_retrieve
this.Control[iCurrent+2]=this.st_docinfo
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_retrieve
this.Control[iCurrent+5]=this.tab_1
end on

on w_documents_browse_old.destroy
call super::destroy
destroy(this.cbx_retrieve)
destroy(this.st_docinfo)
destroy(this.cb_close)
destroy(this.cb_retrieve)
destroy(this.tab_1)
end on

event open;call super::open;
inv_ole_utils_doc = Create n_cst_ovole_utils 
inv_ole_utils_doc.of_initial(tab_1.tabpage_preview.ole_word )

Select doc_auto_retrieve Into :ii_retrieve From security_users where user_id = :gs_user_id ;

If ii_retrieve = 1 Then
	cbx_retrieve.checked = True
End If

end event

event close;call super::close;Integer li_retrieve
If cbx_retrieve.checked Then
	li_retrieve = 1
Else
	li_retrieve = 0
End If

If li_retrieve <> ii_retrieve Then
	Update security_users Set doc_auto_retrieve = :li_retrieve Where User_id = :gs_user_id;
End If

If isvalid(inv_ole_utils_doc) Then Destroy inv_ole_utils_doc



end event

event activate;call super::activate;if w_mdi.MenuName <> "m_pfe_cst_mdi_menu" then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
end if
end event

event resize;call super::resize;tab_1.resize(newwidth - 20, newheight - 180 )

st_docinfo.width = newwidth - 850
st_docinfo.move(newwidth - st_docinfo.width - 15, tab_1.y + tab_1.height - 60 )

cb_retrieve.move(newwidth - 740,newheight - 140)
cb_close.move(newwidth - 388,newheight - 140)

cbx_retrieve.y = cb_close.y + 20
end event

event pfc_postopen;call super::pfc_postopen;If cbx_retrieve.checked Then
	cb_retrieve.event clicked( )
End If
end event

type cbx_retrieve from checkbox within w_documents_browse_old
integer x = 27
integer y = 1768
integer width = 567
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Auto Retrieve Data"
end type

type st_docinfo from statictext within w_documents_browse_old
boolean visible = false
integer x = 1193
integer y = 1664
integer width = 2501
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_documents_browse_old
integer x = 3351
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

type cb_retrieve from commandbutton within w_documents_browse_old
integer x = 2999
integer y = 1756
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Retrieve"
end type

event clicked;tab_1.tabpage_browse.event ue_retrieve( )
end event

type tab_1 from tab within w_documents_browse_old
integer x = 9
integer y = 12
integer width = 3703
integer height = 1732
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
tabposition tabposition = tabsonbottom!
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_preview tabpage_preview
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_preview=create tabpage_preview
this.Control[]={this.tabpage_browse,&
this.tabpage_preview}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_preview)
end on

event selectionchanged;Long ll_doc_id,ll_row
decimal{1} ldec_revision
string ls_doc_ext
Datawindow ldw_browse

ldw_browse = tab_1.tabpage_browse.dw_browse
ll_row = ldw_browse.GetRow()
If ll_row > 0 Then
	If newindex = 2 Then
		st_docinfo.visible = True
		ll_doc_id = ldw_browse.GetItemNumber(ll_row,'ctx_am_document_doc_id')
		ldec_revision = ldw_browse.GetItemDecimal(ll_row,'ctx_am_document_revision')
		ls_doc_ext = ldw_browse.GetItemString(ll_row,'ctx_am_document_doc_ext')
		Parent.event ue_preview(ll_doc_id,ldec_revision,ls_doc_ext)
	Else
		st_docinfo.visible = False
	End If
End If
end event

type tabpage_browse from u_tabpg_br_browse within tab_1
integer x = 18
integer y = 16
integer height = 1604
string text = "Browse"
string picturename = "custom065!"
string powertiptext = "Browse"
end type

event ue_preview;call super::ue_preview;w_documents_browse_old.Event ue_preview(al_doc_id,adec_revision,as_doc_ext)
Return 1
end event

event ue_set_preview;call super::ue_set_preview;If ab_value Then
	tabpage_preview.enabled = True
Else
	tabpage_preview.enabled = False
End If
end event

event ue_set_doc_info;call super::ue_set_doc_info;st_docinfo.text = as_doc_name
end event

event ue_retrieve;call super::ue_retrieve;If This.dw_browse.rowcount( ) <= 0 Then 
	This.event ue_set_preview(False)
End If
end event

type tabpage_preview from u_tabpg_br_preview within tab_1
integer x = 18
integer y = 16
integer width = 3666
integer height = 1604
string text = "Preview"
string picturename = "custom090!"
string powertiptext = "Preview"
end type

