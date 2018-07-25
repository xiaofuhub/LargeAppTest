$PBExportHeader$w_sheet_ctx_doc_painter.srw
forward
global type w_sheet_ctx_doc_painter from w_sheet
end type
type st_msg from statictext within w_sheet_ctx_doc_painter
end type
type tab_1 from tab within w_sheet_ctx_doc_painter
end type
type tabpage_browse from userobject within tab_1
end type
type st_split_bar from u_st_splitbar within tabpage_browse
end type
type dw_browse from u_dw_contract within tabpage_browse
end type
type gb_1 from groupbox within tabpage_browse
end type
type dw_search from u_dw_contract within tabpage_browse
end type
type pb_clear from picturebutton within tabpage_browse
end type
type pb_search from picturebutton within tabpage_browse
end type
type tv_category from treeview within tabpage_browse
end type
type cb_go from commandbutton within tabpage_browse
end type
type cb_clear from commandbutton within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
st_split_bar st_split_bar
dw_browse dw_browse
gb_1 gb_1
dw_search dw_search
pb_clear pb_clear
pb_search pb_search
tv_category tv_category
cb_go cb_go
cb_clear cb_clear
end type
type tabpage_document from userobject within tab_1
end type
type ole_word from u_email_edit within tabpage_document
end type
type uo_2 from uo_dm_image_view_cp within tabpage_document
end type
type tabpage_document from userobject within tab_1
ole_word ole_word
uo_2 uo_2
end type
type tab_1 from tab within w_sheet_ctx_doc_painter
tabpage_browse tabpage_browse
tabpage_document tabpage_document
end type
end forward

global type w_sheet_ctx_doc_painter from w_sheet
integer x = 214
integer y = 221
integer width = 4087
integer height = 2160
string title = "Document Library Painter"
windowstate windowstate = maximized!
long backcolor = 33551856
event pfc_addrow ( )
event pfc_deleterow ( )
event pfc_copy ( )
event type integer ue_doc_view ( )
event ue_doc_properties ( )
event ue_doc_update ( )
event type integer pfc_cst_print_report ( )
event ue_menu_add ( )
event ue_menu_delete ( )
event ue_menu_expand ( )
event ue_menu_collapse ( )
event ue_doc_saveas ( )
event ue_doc_email ( )
st_msg st_msg
tab_1 tab_1
end type
global w_sheet_ctx_doc_painter w_sheet_ctx_doc_painter

type variables
long il_currentopened = 0
long il_handle_rightclicked = 0 //$<add> 2007-02-15 By: Rodger Wu (popmenu)
string is_syntax //for dw_browse
string is_syntax_aftersearch //for dw_browse after search //added by Alfee 05.24.2007
string is_synatx_tree //for ids_tree //added by Alfee 05.24.2007
string is_doctype_support = "doc;docx;tif;xls;csv;tiff;jfk;bmp;jpc;jpe;jpeg;pcx;dcx;xif;gif;wif;ibk;pdf;" //Alfee 05.19.2008

boolean ib_stop_changed = False
boolean ib_stop_selection = False
boolean ib_refresh_treeview = False //Alfee 01.07.2008

DataStore ids_tree //Added by Alfee 05.24.2007
n_cst_right inv_right //$<add> 03-04-2007 By: Ken.Guo

//BEGIN---Add by Evan 08/19/2008
n_cst_dm_utils inv_utils
n_cst_pdf2text inv_cst_pdf2text
n_cst_ocr inv_cst_tif2text
//END---Add by Evan 08/19/2008

n_cst_clause inv_clause

n_cst_ovole_utils  inv_ole_utils_doc

Boolean ib_ole_ini = false //Added By Ken.Guo 2009-06-15.
end variables

forward prototypes
public function integer of_filetodb (long al_doc_id, string as_fullname)
public function string of_filegenerate ()
public function integer of_savefile ()
public subroutine of_build_tree_ori ()
public subroutine of_build_tree ()
public function integer of_find_tvitem (long al_category, string as_doctype)
public function integer of_changetitle ()
public function boolean of_set_preview_tabpage ()
public subroutine of_selectole (string as_doctype)
public function boolean of_issaved ()
end prototypes

event pfc_addrow();Long ll_parent, ll_current, ll_return, ll_rowcount, ll_row, ll_found, ll_category, ll_h
string ls_parm, ls_doctype
treeviewitem ltvi_current, ltvi_parent
DataWindowChild ldwc_doctype

ll_current = tab_1.tabpage_browse.tv_category.FindItem( CurrentTreeItem!, 0 )
if ll_current > 0 then
	tab_1.tabpage_browse.tv_category.GetItem( ll_current, ltvi_current )
	choose case ltvi_current.level
		Case 1
			ls_parm = "add"
			//------------Begin Added by Alfee 03.12.2008-----
			ll_row = tab_1.tabpage_browse.dw_browse.GetRow() 
			IF ll_row > 0 THEN ls_parm ='add~t' + string(tab_1.tabpage_browse.dw_browse.getitemnumber(ll_row, "category"))
			//------------End Added --------------------------
		case 2
			ls_parm = "add~t" + string( ltvi_current.data )
		case 3
			ll_parent = tab_1.tabpage_browse.tv_category.FindItem( parenttreeitem!, ll_current )
			if ll_parent > 0 then
				tab_1.tabpage_browse.tv_category.GetItem( ll_parent, ltvi_parent )
				ls_parm = "add~t" + string( ltvi_parent.data ) + "~t" + string( ltvi_current.data )
			else
				ls_parm = "add~t~t" + string( ltvi_current.data )
			end if
	end choose
//---Begin Added by Alfee 05.24.2007--------
else
	ls_parm = "add"
//---End Added -----------------------------
end if

openwithparm( w_ctx_doc_properties, ls_parm ) //"add" + "~t" + category + "~t" + document_type;
ll_return = message.doubleparm
if ll_return < 1 then return;

//Refresh dddw --Added by Alfee 08.22.2007
tab_1.tabpage_browse.dw_search.getchild('document_type',ldwc_doctype)
ldwc_doctype.SetTransObject(SQLCA)
ldwc_doctype.retrieve()	
ldwc_doctype.InsertRow(1)	

//---------Begin Modified by Alfee 05.24.2007-------------------------
SetRedraw(False) 
tab_1.tabpage_browse.cb_go.event clicked()
ll_rowcount = tab_1.tabpage_browse.dw_browse.rowcount()
ll_found = tab_1.tabpage_browse.dw_browse.Find( "ctx_acp_document_id = " + string( ll_return ), 1, ll_rowcount )

if ll_found > 0 then
	ll_category = tab_1.tabpage_browse.dw_browse.object.category[ll_found]
	ls_doctype = tab_1.tabpage_browse.dw_browse.object.document_type[ll_found]
	ll_h = of_find_tvitem(ll_category, ls_doctype)
	if ll_h > 0 then tab_1.tabpage_browse.tv_category.selectitem(ll_h)
end if
ll_rowcount = tab_1.tabpage_browse.dw_browse.rowcount()
//ll_rowcount = tab_1.tabpage_browse.dw_browse.retrieve() //Commented by alfee 05.24.2007
ll_found = tab_1.tabpage_browse.dw_browse.Find( "ctx_acp_document_id = " + string( ll_return ), 1, ll_rowcount )
if ll_found > 0 then
	tab_1.tabpage_browse.dw_browse.setrow( ll_found )
	tab_1.tabpage_browse.dw_browse.scrolltorow( ll_found )
	tab_1.tabpage_browse.dw_browse.trigger event rowfocuschanged( ll_found )
end if
SetRedraw(True) 
//---------End Modified ----------------------------------------------


end event

event pfc_deleterow();Long ll_selected, ll_rowcount
Long ll_document_id, ll_cnt

ll_selected = tab_1.tabpage_browse.dw_browse.GetSelectedRow( 0 )
if ll_selected < 1 then
	Messagebox( "Deletion", "Please select a document first." )
	tab_1.tabpage_browse.dw_browse.setfocus()
	return
end if

if Messagebox( "Caution", "Are you sure you want to delete the document '" + &
					tab_1.tabpage_browse.dw_browse.getitemstring( ll_selected, "document_name" ) + &
					"'?", Question!, YesNo!, 2 ) = 2 then return;

//-----Begin Added by Alfee 08.04.2007----------------------------------
ll_document_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_selected, 'ctx_acp_document_id')
Select Count(*) Into :ll_cnt From ctx_am_document Where base_type = '2' and from_templete_id = :ll_document_id ;
If ll_cnt > 0 Then
	str_pass lstr_pass
	lstr_pass.s_string = '2'
	lstr_pass.s_long[1] = ll_document_id
	MessageBox('Delete Document', 'Cannot delete the document, because the document is used in Document Manager!') 
	OpenWithParm(w_acp_document_doc_ref,lstr_pass)
	
	Return		
End If
//-----End Added -------------------------------------------------------

tab_1.tabpage_browse.dw_browse.DeleteRow( ll_selected )
if tab_1.tabpage_browse.dw_browse.update() = 1 then
	COMMIT USING SQLCA;
	ll_rowcount = tab_1.tabpage_browse.dw_browse.Rowcount()
	If ll_selected > ll_rowcount then ll_selected = ll_rowcount
	tab_1.tabpage_browse.dw_browse.Trigger Event Rowfocuschanged(ll_selected)
	//Messagebox( "IntelliSoft", "Deletion succeeded." )
else
	ROLLBACK USING SQLCA;
	//Messagebox( "IntelliSoft", "Deletion failed!" )
	Messagebox( "Deletion Error", "Deletion failed!" )
end if

end event

event pfc_copy();Long ll_selected, ll_return, ll_rowcount, ll_found
Long ll_category, ll_h
string ls_parm, ls_doctype

ll_selected = tab_1.tabpage_browse.dw_browse.GetSelectedRow( 0 )
if ll_selected < 1 then
	Messagebox( "Copy", "Please select a document first." )
	tab_1.tabpage_browse.dw_browse.setfocus()
	return
end if

ls_parm = "copy~t" + string( tab_1.tabpage_browse.dw_browse.getitemnumber( ll_selected, "ctx_acp_document_id" ) )
openwithparm( w_ctx_doc_properties, ls_parm ) //"copy" + "~t" + document_id
ll_return = message.doubleparm
if ll_return < 1 then return;

//---------Begin Modified by Alfee 08.21.2007-------------------------
SetRedraw(False) 
tab_1.tabpage_browse.cb_go.event clicked()
ll_rowcount = tab_1.tabpage_browse.dw_browse.rowcount()
ll_found = tab_1.tabpage_browse.dw_browse.Find( "ctx_acp_document_id = " + string( ll_return ), 1, ll_rowcount )
if ll_found > 0 then
	ll_category = tab_1.tabpage_browse.dw_browse.object.category[ll_found]
	ls_doctype = tab_1.tabpage_browse.dw_browse.object.document_type[ll_found]
	ll_h = of_find_tvitem(ll_category, ls_doctype)
	if ll_h > 0 then tab_1.tabpage_browse.tv_category.selectitem(ll_h)
end if
ll_rowcount = tab_1.tabpage_browse.dw_browse.rowcount()
//ll_rowcount = tab_1.tabpage_browse.dw_browse.retrieve()
//---------End Modified ----------------------------------------------
ll_found = tab_1.tabpage_browse.dw_browse.Find( "ctx_acp_document_id = " + string( ll_return ), 1, ll_rowcount )
if ll_found > 0 then
	tab_1.tabpage_browse.dw_browse.setrow( ll_found )
	tab_1.tabpage_browse.dw_browse.scrolltorow( ll_found )
	tab_1.tabpage_browse.dw_browse.trigger event rowfocuschanged( ll_found )
end if
SetRedraw(True) //

end event

event type integer ue_doc_view();Integer li_ret 
Long ll_selected, ll_doc_id
string ls_type, ls_file
String ls_null

if tab_1.selectedtab <> 1 then return -1;

ll_selected = tab_1.tabpage_browse.dw_browse.GetSelectedRow( 0 )
if ll_selected < 1 then
	Messagebox( "View", "Please select a document first." )
	tab_1.tabpage_browse.dw_browse.setfocus()
	return -1;
end if

ls_type = tab_1.tabpage_browse.dw_browse.GetItemString( ll_selected, "document_type" )
ll_doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber( ll_selected, "ctx_acp_document_id" )

of_selectole(ls_type) //Alfee 05.19.2008

choose case Lower(ls_type	)
	case 'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk' ,'pdf'
		if Lower(ls_type) <> 'pdf' or (Lower(ls_type) = 'pdf' and gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '1') Then  //Added By Ken.Guo 2011-05-06. for Open PDF Mode
			if ll_doc_id <> il_currentopened then
				openwithparm( w_appeon_gifofwait, "Opening selected document..." )
				
				ls_file = of_filegenerate()
				if ls_file = '' then
					IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
					return -1;
				end if
		
				Try
					tab_1.tabpage_document.uo_2.of_initialize(ll_doc_id, ls_type )
					li_ret = tab_1.tabpage_document.uo_2.of_open_localfile(ls_file)
					IF li_ret < 0 THEN 
						IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)				
						messagebox('Error','Failed to open file!') 
						return -1
					END IF			
				Catch(Throwable th) 
					IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
					messagebox('Error','Failed to open file due to '+th.text) //05.19.2008								
					Return -1;
				End Try 
					
				IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
				il_currentopened = ll_doc_id
			end if
			
			ib_stop_selection = True
			tab_1.SelectTab( 2 )
			ib_stop_selection = False
		Else
			If isvalid(m_ctx_doc_painter) Then m_ctx_doc_painter.m_file.m_save.toolbaritemvisible = false		
			IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
				setnull(ls_null)
				ls_file = of_filegenerate()
				IF FileExists(ls_file) THEN
					ShellExecuteA ( Handle( This ), "open", ls_file , ls_Null, ls_Null, 4)
				END IF		
				return -1;			
			End If
	//case "DOC", "XLS", "CSV"		
	case 'doc','xls','csv' //Alfee 05.19.2008
		If isvalid(m_ctx_doc_painter) Then m_ctx_doc_painter.m_file.m_save.toolbaritemvisible = True
		if ll_doc_id <> il_currentopened then
			openwithparm( w_appeon_gifofwait, "Opening selected document..." )
			
			ls_file = of_filegenerate()
			if ls_file = '' then
				IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
				return -1;
			end if
			
			//tab_1.tabpage_document.ole_tif_edit.visible = False - Alfee 05.19.2008
			
			Try
			//tab_1.tabpage_document.ole_word.object.toolbars( False )
			//tab_1.tabpage_document.ole_word.object.close() - commented by alfee 09.23.2008
			tab_1.tabpage_document.ole_word.object.openlocalfile( ls_file, false)
			//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
			gnv_word_utility.of_modify_word_property( tab_1.tabpage_document.ole_word.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
			//---------End Added ------------------------------------------------------
			ib_ole_ini = True
			oleobject lole_current
			If tab_1.tabpage_document.ole_word.object.DocType = 1 Then //Only word use.
				lole_current = create oleobject
				lole_current = tab_1.tabpage_document.ole_word.object.activedocument
				lole_current.ActiveWindow.ActivePane.View.Zoom.Percentage = 100
			End if

			tab_1.tabpage_document.ole_word.visible = True
			tab_1.tabpage_document.ole_word.SetFocus()

			Catch(Throwable th1)//alfee 08.21.2007
				tab_1.tabpage_document.ole_word.object.close() //alfee 09.23.2008
				IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
				MessageBox("Open Document","Failed to open document due to: ~r~n" + th1.text) //alfee 09.23.2008
				Return -1;
			End Try
				
			IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
			
			il_currentopened = ll_doc_id
		end if
		
		ib_stop_selection = True
		tab_1.SelectTab( 2 )
		ib_stop_selection = False
		
	case else //"TXT","HTM", "HTML"...
		If isvalid(m_ctx_doc_painter) Then m_ctx_doc_painter.m_file.m_save.toolbaritemvisible = false		
		IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
		setnull(ls_null)
		ls_file = of_filegenerate()
		IF FileExists(ls_file) THEN
			ShellExecuteA ( Handle( This ), "open", ls_file , ls_Null, ls_Null, 4)
		END IF		
		return -1;
end choose

Return 1;
end event

event ue_doc_properties();Long ll_selected, ll_return, ll_category, ll_reviewed_status
string ls_parm, ls_document_type, ls_reviewed_by, ls_document_name
datetime ldt_date_reviewed, ldt_modify_date

ll_selected = tab_1.tabpage_browse.dw_browse.GetSelectedRow( 0 )
if ll_selected < 1 then
	Messagebox( "Selection", "Please select a document first." )
	tab_1.tabpage_browse.dw_browse.setfocus()
	return
end if

ls_parm = "changed~t" + string( tab_1.tabpage_browse.dw_browse.getitemnumber( ll_selected, "ctx_acp_document_id" ) )
openwithparm( w_ctx_doc_properties, ls_parm ) //"changed" + "~t" + document_id
ll_return = message.doubleparm
if ll_return < 1 then return;

//-------Begin Added by Alfee 01.07.2008-----------------------
//<$Reason>Rebuild and locate in treeview if category or doc type changed 
Long ll_rowcount, ll_found, ll_docid, ll_h
String ls_doctype
Datawindowchild ldwc_doctype

IF ib_refresh_treeview THEN
	ib_refresh_treeview = Not ib_refresh_treeview
	SetRedraw(False)
	
	//Get new category and document type
	ll_docid = tab_1.tabpage_browse.dw_browse.object.ctx_acp_document_id[ll_selected]
	SELECT category, document_type INTO :ll_category, :ls_doctype FROM ctx_acp_document 
	 WHERE ctx_acp_document_id = :ll_docid; 
	IF sqlca.sqlcode <> 0 THEN return;
	
	//Rebuild the treeview
	tab_1.tabpage_browse.cb_go.event clicked()
	
	//Find and locate in treeview
	ll_h = of_find_tvitem(ll_category, ls_doctype)
	if ll_h > 0 then tab_1.tabpage_browse.tv_category.selectitem(ll_h)

	//Refresh and locate in Browse datawindow
	ll_rowcount = tab_1.tabpage_browse.dw_browse.rowcount()
	ll_found = tab_1.tabpage_browse.dw_browse.Find( "ctx_acp_document_id = " + string( ll_docid ), 1, ll_rowcount )
	if ll_found > 0 then
		tab_1.tabpage_browse.dw_browse.setrow( ll_found )
		tab_1.tabpage_browse.dw_browse.scrolltorow( ll_found )
		tab_1.tabpage_browse.dw_browse.trigger event rowfocuschanged( ll_found )
	end if
	
	//Refresh the dddw of document type
	tab_1.tabpage_browse.dw_search.getchild('document_type',ldwc_doctype)
	ldwc_doctype.SetTransObject(SQLCA)
	ldwc_doctype.retrieve()
	ldwc_doctype.InsertRow(1)
			
	SetRedraw(True)	
	RETURN	
END If
//-------End Added ---------------------------------------------

//Write the following script instead of ReselectRow() which is not supported by APB.
SELECT category, 
		document_name,
		document_type, 
		reviewed_by, 
		date_reviewed, 
		reviewed_status, 
		document_type, 
		modify_date
INTO :ll_category, 
		:ls_document_name, 
		:ls_document_type, 
		:ls_reviewed_by, 
		:ldt_date_reviewed, 
		:ll_reviewed_status, 
		:ls_document_type, 
		:ldt_modify_date
FROM ctx_acp_document 
WHERE ctx_acp_document_id = :ll_return; 
IF sqlca.sqlcode <> 0 THEN return;

tab_1.tabpage_browse.dw_browse.setitem( ll_selected, "category", ll_category )
tab_1.tabpage_browse.dw_browse.setitem( ll_selected, "document_name", ls_document_name )
tab_1.tabpage_browse.dw_browse.setitem( ll_selected, "document_type", ls_document_type )
tab_1.tabpage_browse.dw_browse.setitem( ll_selected, "reviewed_by", ls_reviewed_by )
tab_1.tabpage_browse.dw_browse.setitem( ll_selected, "date_reviewed", ldt_date_reviewed )
tab_1.tabpage_browse.dw_browse.setitem( ll_selected, "reviewed_status", ll_reviewed_status )
tab_1.tabpage_browse.dw_browse.setitem( ll_selected, "document_type", ls_document_type )
tab_1.tabpage_browse.dw_browse.setitem( ll_selected, "modify_date", ldt_modify_date )
tab_1.tabpage_browse.dw_browse.setitemstatus( ll_selected, 0, Primary!, NotModified! )
end event

event ue_doc_update();Long ll_selected, ll_doc_id, flen
Integer li_return, li_pos
String ls_filename, ls_fullname, ls_type, ls_reversed
String ls_type_ori //01.08.2008
datetime ldt_lastmodify

ll_selected = tab_1.tabpage_browse.dw_browse.GetSelectedRow( 0 )
if ll_selected < 1 then
	Messagebox( "Selection", "Please select a document first." )
	tab_1.tabpage_browse.dw_browse.setfocus()
	return
end if
ls_type_ori = tab_1.tabpage_browse.dw_browse.getitemstring(ll_selected, "document_type" ) //01.08.2008

//--------------Begin Modified by Alfee 01.08.2008-----------------------------
//<$Reason>Keep same with the browse operation in properties window
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
Choose Case upper(ls_type_ori)
	case 'DOC'
		li_return = GetFileOpenName ( "Select File", ls_fullname, ls_filename, "DOC", &
			+ "Doc Files (*.DOCX;*.DOC),*.DOCX;*.DOC," &
			+ "All Files (*.*), *.*" )		
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
			+ "All Files (*.*), *.*")
End Choose
/*
//<$Reason>Support Word 2007  Alfee 10.31.2007
li_return = GetFileOpenName ( "Select File", ls_fullname, ls_filename, "DOC", &
   + "Word Files (*.DOCX;*.DOC),*.DOCX;*.DOC,Tif Files (*.TIF),*.TIF," &
	+ "Excel Files (*.XLS),*.XLS,All Files (*.*), *.*", gs_dir_path + gs_DefDirName + "\Agreement", 18 ) 
*/
//--------------End Modified --------------------------------------------------
gf_save_dir_path(ls_fullname) //Added by Ken.Guo on 2009-03-10
//ChangeDirectory(gs_current_path) //Added by Alfee 05.14.2007	
if li_return < 1 then Return;

flen = FileLength(ls_fullname)
if flen <= 0 then
	Messagebox( "Caution", "The file size of " + ls_fullname + " can not be zero!" )
	Return;
end if

ll_doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber( ll_selected, "ctx_acp_document_id" )
if of_filetodb( ll_doc_id, ls_fullname ) > 0 then
	ldt_lastmodify = Datetime( Today(), Now() )

	ls_reversed = Reverse( ls_filename )
	li_pos = POS( ls_reversed, "." )
	if li_pos > 0 and li_pos <= 5 then
		ls_type = Left( ls_reversed, li_pos - 1 )
		ls_type = Upper( Reverse( ls_type ) )
		//--------Begin Added by Alfee 10.31.2007-------
		//Use 'doc' as the Word2007 document's extension name
		IF Len(ls_type) > 3 and Left(ls_type, 3) = 'DOC' THEN ls_type = 'DOC'
		//--------End Added ----------------------------		
		tab_1.tabpage_browse.dw_browse.Setitem( ll_selected, "document_type", ls_type )
	end if
		
	tab_1.tabpage_browse.dw_browse.SetItem( ll_selected, "files", ls_fullname )
	tab_1.tabpage_browse.dw_browse.SetItem( ll_selected, "modify_date", ldt_lastmodify )
	tab_1.tabpage_browse.dw_browse.SetItem( ll_selected, "document_type", ls_type )
	
	if tab_1.tabpage_browse.dw_browse.update() = 1 then
		COMMIT USING SQLCA;
		//-------Begin Added by Alfee 01.08.2008-----------------------
		//<$Reason>Rebuild and locate in treeview  
		Long ll_rowcount, ll_category, ll_found, ll_h
		Datawindowchild ldwc_doctype
		
		IF ls_type_ori	<> ls_type THEN
			SetRedraw(False)
			ll_category = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_selected, "category")
		
			//Rebuild the treeview
			tab_1.tabpage_browse.cb_go.event clicked()
	
			//Find and locate in treeview
			ll_h = of_find_tvitem(ll_category, ls_type)
			if ll_h > 0 then tab_1.tabpage_browse.tv_category.selectitem(ll_h)

			//Refresh and locate in Browse datawindow
			ll_rowcount = tab_1.tabpage_browse.dw_browse.rowcount()
			ll_found = tab_1.tabpage_browse.dw_browse.Find( "ctx_acp_document_id = " + string( ll_doc_id ), 1, ll_rowcount )
			if ll_found > 0 then
				tab_1.tabpage_browse.dw_browse.setrow( ll_found )
				tab_1.tabpage_browse.dw_browse.scrolltorow( ll_found )
				tab_1.tabpage_browse.dw_browse.trigger event rowfocuschanged( ll_found )
			end if
			
			//Refresh the dddw of document type
			tab_1.tabpage_browse.dw_search.getchild('document_type',ldwc_doctype)
			ldwc_doctype.SetTransObject(SQLCA)
			ldwc_doctype.retrieve()
			ldwc_doctype.InsertRow(1)			
			
			SetRedraw(True)	
		END IF

		il_currentopened = 0  //To refresh the document displayed
		//-------End Added ---------------------------------------------			
		Messagebox( "File", "File update succeeded." )
	else
		ROLLBACK USING SQLCA;
		//Messagebox( "File", "Though file is writed to database successfully, document record update failed." )
		Messagebox( "File", "Though file is written to database successfully, document record update failed." )
	end if
	
	//---Added by alfee 04.29.2007------------------
	Try //added try statement 08.30.2007
		tab_1.tabpage_document.ole_word.object.close() 
		//-------------Begin Modified by Alfee on 05.19.2008------
		IF gi_imageocx = 1 THEN 
			//tab_1.tabpage_document.uo_1.of_show_blankimage( )
		ELSE
			tab_1.tabpage_document.uo_2.of_show_blankimage( )
		END IF
		//tab_1.tabpage_document.ole_tif_edit.object.cleardisplay()
		//-------------End Modified ------------------------------
	Catch(Runtimeerror e)
		//nothing - if the Word/ image controls not installed
	End Try
	//---End Added-------------------------------
	
	il_currentopened = 0
end if
end event

event type integer pfc_cst_print_report();Long ll_selected, ll_doc_id
integer li_return, li_pagecount
string ls_type, ls_file

if tab_1.selectedtab = 1 then
	li_return = this.trigger event ue_doc_view()
	if li_return <> 1 then return -1;
end if

if messagebox( "Confirmation", "This document is being sent to Printer, continue?", Question!, YesNo! ) = 2 then return 0;

try	//Add By Jervis 03/15/2007
	if tab_1.tabpage_document.ole_word.visible then //Print office document.
		tab_1.tabpage_document.ole_word.object.printout(true)
	//-------------Begin Modified by Alfee 05.19.2008---------------------
	elseif tab_1.tabpage_document.uo_2.visible then //Print tif document.		
//		tab_1.tabpage_document.uo_1.event ue_print()	
//	else
		tab_1.tabpage_document.uo_2.event ue_print()			
	end if
	//elseif tab_1.tabpage_document.ole_tif_edit.visible then //Print tif document.
	//  li_pagecount = tab_1.tabpage_document.ole_tif_edit.object.pagecount()
	//	 tab_1.tabpage_document.ole_tif_edit.object.PrintImage( 1, li_pagecount )
	//end if
	//-------------End Modified -------------------------------------------
catch(throwable e)
	//MessageBox("Imaging","There is a printer error, Please check the printer.")
	MessageBox("Imaging","There is a printer error. Please check the printer.")
end try

Return 1;
end event

event ue_menu_add();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (popmenu)

if il_handle_rightclicked > 0 then
	tab_1.tabpage_browse.tv_category.SelectItem( il_handle_rightclicked )
end if
This.TriggerEvent( "pfc_addrow" )
//---------------------------- APPEON END ----------------------------
end event

event ue_menu_delete();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (popmenu)
long ll_rowcount

if il_handle_rightclicked < 1 then return;

tab_1.tabpage_browse.tv_category.SelectItem( il_handle_rightclicked )

ll_rowcount = tab_1.tabpage_browse.dw_browse.rowcount()
if ll_rowcount <= 0 then
	//Messagebox( "IntelliSoft", "There is no document to delete!" )
	Messagebox( "Deletion Error", "There is no document to delete!" )
	return;
end if

if Messagebox( "Caution", "Are you sure that you want to delete the " + &
					string( ll_rowcount ) + " document(s) in this folder ?", Question!, yesno!, 2 ) = 2 then return;
					
//---------Begin Added by (Appeon)Harry 11.21.2013 for V141 for BugH082302 of IntelliCredApp V14.1 History Issues--------
Long i
Long ll_document_id
Long ll_cnt
Boolean lb_docused = false
for i = 1 to ll_rowcount
	ll_document_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(i, 'ctx_acp_document_id')
	Select Count(*) Into :ll_cnt From ctx_am_document Where base_type = '2' and from_templete_id = :ll_document_id ;
	if ll_cnt > 0 then
		lb_docused = true
		exit
	end if
next 
if lb_docused then
	MessageBox('Delete Document', 'Cannot delete the document, because the documents are used in Document Manager!') 
	Return
end if
//---------End Added ------------------------------------------------------

tab_1.tabpage_browse.dw_browse.rowsmove( 1, ll_rowcount, primary!, tab_1.tabpage_browse.dw_browse, 1, Delete! )
if tab_1.tabpage_browse.dw_browse.update() = 1 then
	commit using sqlca;
else
	rollback using sqlca;
	//MessageBox( "IntelliSoft", "Delete failed." )
	MessageBox( "Deletion Error", "Delete failed." )
end if
//---------------------------- APPEON END ----------------------------
end event

event ue_menu_expand();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (popmenu)

if il_handle_rightclicked > 0 then
	tab_1.tabpage_browse.tv_category.expandall( il_handle_rightclicked )
end if

//---------------------------- APPEON END ----------------------------

end event

event ue_menu_collapse();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (popmenu)

if il_handle_rightclicked > 0 then
	tab_1.tabpage_browse.tv_category.collapseitem( il_handle_rightclicked )
end if

//---------------------------- APPEON END ----------------------------

end event

event ue_doc_saveas();
Integer li_rtn
str_add_doc lstr_add_doc
str_add_audit lstr_add_audit

IF NOT of_issaved() THEN
	li_rtn = MessageBox("Save Document","The document has been modified, save it first?",Question!,YesNoCancel!) 
	IF li_rtn = 1 THEN 
		This.of_savefile()
	ELSEIF li_rtn = 3 THEN
		RETURN
	END IF
END IF		

lstr_add_doc.doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(tab_1.tabpage_browse.dw_browse.GetRow(),'ctx_acp_document_id')
lstr_add_doc.doc_ext = tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.GetRow(),'document_type')
If tab_1.tabpage_browse.dw_browse.getrow() > 0 Then
	lstr_add_doc.filename = tab_1.tabpage_browse.dw_browse.object.document_name[tab_1.tabpage_browse.dw_browse.getrow()]					
End If

openwithparm(w_doc_saveto_document, lstr_add_doc)

SetPointer(Arrow!) //for refresh problem on new image ocx - Alfee 05.19.2008
end event

event ue_doc_email();
Integer li_rtn
//str_add_doc lstr_add_doc
//str_add_audit lstr_add_audit

IF NOT of_issaved() THEN
	li_rtn = MessageBox("Save Document","The document has been modified, save it first?",Question!,YesNoCancel!) 
	IF li_rtn = 1 THEN 
		This.of_savefile()
	ELSEIF li_rtn = 3 THEN
		RETURN
	END IF
END IF		

//lstr_add_doc.doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(tab_1.tabpage_browse.dw_browse.GetRow(),'ctx_acp_document_id')
//lstr_add_doc.doc_ext = tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.GetRow(),'document_type')
//If tab_1.tabpage_browse.dw_browse.getrow() > 0 Then
//	lstr_add_doc.filename = tab_1.tabpage_browse.dw_browse.object.document_name[tab_1.tabpage_browse.dw_browse.getrow()]					
//End If
//
//openwithparm(w_doc_saveto_document, lstr_add_doc)

//Download File
String ls_download_file,ls_email_file,ls_ext,ls_file_shortname
Long ll_document_id
ll_document_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(tab_1.tabpage_browse.dw_browse.GetRow(),'ctx_acp_document_id')
ls_file_shortname = tab_1.tabpage_browse.dw_browse.object.document_name[tab_1.tabpage_browse.dw_browse.getrow()]
ls_ext = tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.GetRow(),'document_type')

ls_download_file = inv_clause.of_download_document(ll_document_id)
If Not FileExists(ls_download_file) Then Return

//Email
ls_email_file = gs_dir_path + gs_DefDirName + "\Email\"
gnv_appeondll.of_parsepath(ls_email_file)
ls_email_file += ls_file_shortname + '.' + ls_ext
If FileCopy(ls_download_file,ls_email_file,True) <> 1 Then
	Messagebox('Email','Failed to generate the document file ' + ls_email_file + '.' )
	Return 
End If

str_ctx_email lstr_ctx_email
lstr_ctx_email.doc_from = 'Document_Library'
lstr_ctx_email.ctx_id = 0
lstr_ctx_email.doc_id = ll_document_id
lstr_ctx_email.revision = 0
lstr_ctx_email.doc_ext = ls_ext
lstr_ctx_email.filename = ls_file_shortname
lstr_ctx_email.as_batch_file[1]  = ls_email_file 

//Open email window 
OpenWithParm(w_dm_email_document_send, lstr_ctx_email)

SetPointer(Arrow!) //for refresh problem on new image ocx - Alfee 05.19.2008
end event

public function integer of_filetodb (long al_doc_id, string as_fullname);integer li_FileNum, loops, i
long flen, bytes_read, new_pos
blob b, tot_b

IF isnull( as_fullname ) OR trim( as_fullname ) = '' THEN return 0;

If not fileexists(as_fullname) then
	Messagebox( "Save Document File to Database", as_fullname + " can not be found!" )
	return -1
end if
openwithparm( w_appeon_gifofwait, "Opening selected document..." )

SetPointer(HourGlass!)

IF inv_utils.of_readblob(as_fullname, tot_b) < 0 THEN //Alfee 09.28.2008
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	Messagebox( "Read Document", "Failed to read document!" )
	Return -1
END IF
/*
flen = FileLength(as_fullname)
//---------Begin Modified by alfee 04.29.2009--------------
//li_FileNum = FileOpen(as_fullname, StreamMode!, Read!, LockRead!)
li_FileNum = FileOpen(as_fullname, StreamMode!, Read!, Shared!)
//---------End Modified------------------------------------
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

UPDATEBLOB ctx_acp_document
SET image_file = :tot_b
WHERE ctx_acp_document_id = :al_doc_id USING SQLCA; 
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
	ls_doc_ext = Upper(inv_utils.of_get_fileext(as_fullname))
	choose case ls_doc_ext
		case "PDF"
			inv_cst_pdf2text.of_pdf2text(as_fullname, ls_image_text)
			If ls_image_text = '' Then
				ls_image_text = lnv_ocr.of_ocr(as_fullname)
			End If
		case 'BMP','TIF','TIFF','JPG','GIF'
			//inv_cst_tif2text.of_tif2text(ls_FullName, ls_image_text)
			ls_image_text = lnv_ocr.of_ocr(as_fullname)
	end choose
	
	
	if Len(ls_image_text) > 0 then
		UPDATE ctx_acp_document
		SET image_text = :ls_image_text
		WHERE ctx_acp_document_id = :al_doc_id;
	end if
End If

Return 1
end function

public function string of_filegenerate ();Long ll_selected, ll_doc_id, ll_length, ll_start
string ls_type, ls_lastopen, ls_fullname, ls_to_open, ls_now
datetime ldt_lastmodify
integer li_FileNo, li_Writes, li_Cnt, li_return, li_loops
long ll_BlobLen, ll_CurrentPos
blob lblb_Data, lblb_doc

ll_selected = tab_1.tabpage_browse.dw_browse.GetSelectedRow( 0 )
ls_type = tab_1.tabpage_browse.dw_browse.GetItemString( ll_selected, "document_type" )
ll_doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber( ll_selected, "ctx_acp_document_id" )
ldt_lastmodify = tab_1.tabpage_browse.dw_browse.GetItemDatetime( ll_selected, "modify_date" )
//ls_now = String(Datetime(Today(), Now()), "mm/dd/yyyy hh:mm:ss") //commented by alfee 05.10.2007

//------Begin Modified by Alfee 05.28.2007----------
IF Not DirectoryExists( gs_dir_path + gs_DefDirName + "\Agreement\" ) THEN
	CreateDirectory( gs_dir_path + gs_DefDirName + "\Agreement\" )
END IF
ls_fullname = gs_dir_path + gs_DefDirName + "\Agreement\" + 'Document-' + string( ll_doc_id ) + "." + ls_type
//------End Modified --------------------------------
//Modified By Mark Lee 04/18/12
//li_return = gnv_appeondll.of_Registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'Document-' + string( ll_doc_id ), regstring!, ls_lastopen)
li_return = gnv_appeondll.of_Registryget("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", 'Document-' + string( ll_doc_id ), regstring!, ls_lastopen)

//-------Begin Modified by Alfee 05.10.2007---------------	
//IF li_return = -1 or ls_lastopen = "" THEN
//		gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'Document-'+string( ll_doc_id), regstring!, ls_now )
//ELSEIF string(ldt_lastmodify, "mm/dd/yyyy hh:mm:ss") <= ls_lastopen THEN
IF string(ldt_lastmodify, "mm/dd/yyyy hh:mm:ss") = ls_lastopen THEN	
//-------End Modified-------------------------------------		
	IF fileexists( ls_fullname ) THEN
		Return ls_fullname;
	END IF
ELSE
	//Modified By Mark Lee 04/18/12
	//-------Begin Modified by Alfee 05.10.2007---------------	
//	gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'Document-'+string( ll_doc_id), regstring!, string(ldt_lastmodify, "mm/dd/yyyy hh:mm:ss"))
	gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", 'Document-'+string( ll_doc_id), regstring!, string(ldt_lastmodify, "mm/dd/yyyy hh:mm:ss"))
	//gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'Document-'+string( ll_doc_id), regstring!, ls_now)	
	//-------End Modified-------------------------------------		
End If

SELECT DataLength( image_file )
INTO :ll_length
FROM ctx_acp_document
WHERE ctx_acp_document_id = :ll_doc_id;

IF ll_length > 0 THEN
	IF gs_dbtype = "SQL" and appeongetclienttype() = "PB" and ll_length > 8000 THEN
		li_loops = ( ll_length / 8000 ) + 1

		For li_Cnt = 1 To li_loops				
			ll_start = (li_Cnt - 1) * 8000 + 1
			
			SELECTBLOB substring( image_file, :ll_start, 8000 ) 
			INTO :lblb_data 
			FROM ctx_acp_document WHERE ctx_acp_document_id = :ll_doc_id; 
			
			IF SQLCA.SQLCode <> 0 THEN
				IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
				Messagebox( "IntelliSoft", "Read file data from database failed." )
				Return "";
			END IF
			lblb_doc += lblb_data
		Next 
	ELSE
		SELECTBLOB image_file 
		INTO :lblb_doc 
		FROM ctx_acp_document
		WHERE ctx_acp_document_id = :ll_doc_id;

		IF SQLCA.SQLCode <> 0 THEN
			IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
			Messagebox( "IntelliSoft", "Read file data from database failed." )
			Return "";
		END IF
	END IF
		
	IF fileexists( ls_fullname ) THEN
		FileDelete( ls_fullname );
	END IF
	
	li_FileNo = FileOpen( ls_fullname, StreamMode!, Write!, LockReadWrite!, Append!)
	If li_FileNo < 0 Then
		IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
		Messagebox( "IntelliSoft", "Create temporary file failed." )
		Return ""
	End If
	
	ll_BlobLen = Len(lblb_doc)
	
	If ll_BlobLen > 32765 Then
		If Mod(ll_BlobLen, 32765) = 0 Then
			li_Writes = ll_BlobLen / 32765
		Else
			li_Writes = (ll_BlobLen / 32765) + 1
		End if
	Else
		li_Writes = 1
	End if
	
	ll_CurrentPos = 1
	For li_Cnt = 1 To li_Writes
		lblb_Data = BlobMid(lblb_doc, ll_CurrentPos, 32765)
		ll_CurrentPos += 32765
		If FileWrite(li_FileNo, lblb_Data) = -1 Then
			IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
			Messagebox( "IntelliSoft", "Write temporary file failed." )
			Return "";
		End if
	Next
	
	FileClose(li_FileNo)
ELSE
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	Messagebox( "IntelliSoft", "Attached file not stored in database." )
	Return "";
END IF

IF Not FileExists(ls_fullname) THEN Return ""; //Alfee 08.21.2007

Return ls_fullname;
end function

public function integer of_savefile ();//////////////////////////////////////////////////////////////////////
// $<function>w_sheet_ctx_doc_painter.of_savefile()
// $<arguments>(None)
// $<returns> integer
// $<description>Save the specified file
//////////////////////////////////////////////////////////////////////
// $<add> 04.29.2007 by Alfee (Contract Logix Document Library Painter)
//////////////////////////////////////////////////////////////////////
Long ll_selected, ll_doc_id
Datetime ldt_lastmodify
String ls_fullname, ls_type,ls_Rtn

//Check whether a file is opened
if il_currentopened < 1 then return 0
ll_selected = tab_1.tabpage_browse.dw_browse.GetRow()
If ll_selected < 1 Then Return -1

IF Not Isvalid( w_appeon_gifofwait) THEN OpenwithParm( w_appeon_gifofwait, "Saving document...")

//Save the local file
ll_doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber( ll_selected, "ctx_acp_document_id" )
ls_type = tab_1.tabpage_browse.dw_browse.GetItemString( ll_selected, "document_type" )
ls_fullname = gs_dir_path + gs_DefDirName + "\Agreement\" + 'Document-' + string( ll_doc_id ) + "." + ls_type //By alfee 05.18.2007

//--------Begin Modified by Alfee 05.19.2008---------------------------------
/* choose case ls_type
	  case "TIF"
		  tab_1.tabpage_document.ole_tif_edit.object.save() 
  	  case "DOC", "XLS", "CSV" */
choose case Lower(ls_type)
	CASE 'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk','pdf'	
		IF gi_imageocx = 1 THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2008-07-14 By: Scofield
			//$<Reason> Verify if the directory has write right for the current user.		
			//ls_Rtn = f_ExaWriteRight(tab_1.tabpage_document.uo_1.ole_edit.object.Image)
			if Len(ls_Rtn) > 0 then
				MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
				if Isvalid( w_appeon_gifofwait) then Close( w_appeon_gifofwait)
				Return -1
			end if
			//---------------------------- APPEON END ----------------------------
			//tab_1.tabpage_document.uo_1.ole_edit.object.save()			
		ELSEIF gi_imageocx = 2 THEN //Alfee 07.28.2008
			IF Lower(ls_type) <> 'tif' OR NOT tab_1.tabpage_document.uo_2.of_ismodified( ) THEN 
				if Isvalid( w_appeon_gifofwait) then Close( w_appeon_gifofwait)
				RETURN 0
			END IF
			//The OLE control needn't save after a scan or delete page operation
		END IF
	case "doc", "xls", "csv"
//--------End Modified --------------------------------------		
		tab_1.tabpage_document.ole_word.object.saveToLocal(ls_fullname, true)
	case else //"TXT", "PDF", "HTM", "HTML"
		Messagebox( "Type", "Unsupported file type." )
		IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
		return -1;
end choose

//Update db and registry		
ldt_lastmodify = Datetime(Today(), Now())
if of_filetodb( ll_doc_id, ls_fullname ) > 0 then
	//set modify date	
	tab_1.tabpage_browse.dw_browse.SetItem( ll_selected, "modify_date", ldt_lastmodify )
	tab_1.tabpage_browse.dw_browse.AcceptText()
	if tab_1.tabpage_browse.dw_browse.update() = 1 Then
		//Modified By Mark Lee 04/18/12
		//registry new key value of the template file 
//		gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'Document-'+string( ll_doc_id), regstring!, string(ldt_lastmodify, "mm/dd/yyyy hh:mm:ss"))
		gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", 'Document-'+string( ll_doc_id), regstring!, string(ldt_lastmodify, "mm/dd/yyyy hh:mm:ss"))
	end if
	//Restore the modified flag for the new image OCX
	IF gi_imageocx = 2 and Lower(ls_type) = 'tif' THEN 
		tab_1.tabpage_document.uo_2.of_set_modified(FALSE)
	END IF
end if

IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

return 1
end function

public subroutine of_build_tree_ori ();datawindowchild ldwc_category
integer li_rows_cat, li_rows_type, li_found, li_inserted, i, j
Long ll_root, ll_level_2, ll_total
treeviewitem ltvi_data
datastore lds_doc_type
string ls_type, ls_temp

ltvi_data.label = "All Categories"
ltvi_data.data = "root"
ltvi_data.pictureindex = 1
ltvi_data.selectedpictureindex = 2
ll_root = tab_1.tabpage_browse.tv_category.InsertItemFirst ( 0, ltvi_data )

lds_doc_type = create datastore
lds_doc_type.dataobject = "ds_ctx_document_type"
lds_doc_type.settransobject( sqlca )
li_rows_type = lds_doc_type.retrieve()
li_found = lds_doc_type.find( "upper( document_type ) = 'DOC'", 1, li_rows_type )
if li_found < 1 then
	li_Inserted = lds_doc_type.insertrow( 0 )
	lds_doc_type.setitem( li_Inserted, "document_type", "DOC" )
end if
li_found = lds_doc_type.find( "upper( document_type ) = 'TIF'", 1, li_rows_type )
if li_found < 1 then
	li_Inserted = lds_doc_type.insertrow( 0 )
	lds_doc_type.setitem( li_Inserted, "document_type", "TIF" )
end if
li_found = lds_doc_type.find( "upper( document_type ) = 'XLS'", 1, li_rows_type )
if li_found < 1 then
	li_Inserted = lds_doc_type.insertrow( 0 )
	lds_doc_type.setitem( li_Inserted, "document_type", "XLS" )
end if
li_rows_type = lds_doc_type.rowcount()

tab_1.tabpage_browse.dw_search.GetChild( "category", ldwc_category )

li_rows_cat = ldwc_category.rowcount()
for i = 1 to li_rows_cat
	ls_temp = lower( ldwc_category.getitemstring( i, "lookup_name" ) )
	if isnull( ls_temp ) then ls_temp = ''
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.14.2007 By: Jervis
	//$<reason> 
	//if ls_temp <> "contract document category" then continue;
	if ls_temp <> "contract category" then continue;
	//---------------------------- APPEON END ----------------------------

	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2007-02-15 By: Rodger Wu (pop menu)
	ls_temp = ldwc_category.getitemstring( i,"code" )
	//---------------------------- APPEON END ----------------------------
	
	if ls_temp = "All" then continue;
	
	ltvi_data.label = ls_temp
	ltvi_data.data = ldwc_category.getitemnumber( i,"lookup_code" )
	ltvi_data.pictureindex = 1
	ltvi_data.selectedpictureindex = 2
	ll_level_2 = tab_1.tabpage_browse.tv_category.InsertItemLast ( ll_root, ltvi_data )
	
	for j = 1 to li_rows_type
		ls_type = lds_doc_type.getitemstring( j, "document_type" )
		ltvi_data.label = ls_type
		ltvi_data.data = ls_type
		ltvi_data.pictureindex = 3
		ltvi_data.selectedpictureindex = 3
		tab_1.tabpage_browse.tv_category.InsertItemLast ( ll_level_2, ltvi_data )
	next
next

tab_1.tabpage_browse.tv_category.expanditem( ll_root )

SELECT count( ctx_acp_document_id ) INTO :ll_total FROM ctx_acp_document;
if ll_total < 200 then
	tab_1.tabpage_browse.tv_category.selectitem( ll_root )
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_doc_type) then Destroy lds_doc_type
//---------------------------- APPEON END ----------------------------

end subroutine

public subroutine of_build_tree ();//////////////////////////////////////////////////////////////////////
// $<function>w_sheet_ctx_doc_painter.of_build_tree()
// $<arguments>(None)
// $<returns> integer
// $<description>Build the treeview(modified from of_build_tree_ori())
//////////////////////////////////////////////////////////////////////
// $<add> 05.24.2007 by Alfee (Contract Logix Document Library Painter)
//////////////////////////////////////////////////////////////////////
Long ll_root, ll_handle, ll_cnt, i, ll_total
Long ll_category_temp, ll_category
string ls_category_name, ls_doctype
treeviewitem ltvi_data

//Clear the treeview
ll_root =  tab_1.tabpage_browse.tv_category.finditem(roottreeitem!, 0)
do while ll_root > 0 
   tab_1.tabpage_browse.tv_category.deleteitem(ll_root)
	ll_root = tab_1.tabpage_browse.tv_category.finditem(roottreeitem!, 0)
loop

ll_cnt = ids_tree.Retrieve()
If ll_cnt < 1 Then 
	tab_1.tabpage_browse.dw_browse.retrieve()
	Return
END IF

//Insert root item
ltvi_data.label = "All Categories"
ltvi_data.data = "root"
ltvi_data.pictureindex = 1
ltvi_data.selectedpictureindex = 2
ll_root = tab_1.tabpage_browse.tv_category.InsertItemFirst ( 0, ltvi_data )

//Insert child items
for i = 1 to ll_cnt
	ll_category = ids_tree.getitemnumber(i,"category")
	ls_category_name = ids_tree.getitemstring(i,"category_name")
	ls_doctype = ids_tree.getitemString(i,"document_type")
	
	if ll_category <> ll_category_temp then 
		//build category item
		ltvi_data.label = ls_category_name
		ltvi_data.data = ll_category
		ltvi_data.pictureindex = 1
		ltvi_data.selectedpictureindex = 2	
		ll_handle = tab_1.tabpage_browse.tv_category.insertitemlast(ll_root,ltvi_data)
		ll_category_temp = ll_category				
	end if
	
	//build document type item
	if Len(Trim(ls_doctype)) > 0 then 
		ltvi_data.label = ls_doctype
		ltvi_data.data = ls_doctype
		ltvi_data.pictureindex = 3
		ltvi_data.selectedpictureindex = 3	
		tab_1.tabpage_browse.tv_category.insertitemlast(ll_handle,ltvi_data)		
	end if
next

tab_1.tabpage_browse.tv_category.expanditem( ll_root )

SELECT count( ctx_acp_document_id ) INTO :ll_total FROM ctx_acp_document;
if ll_total < 200 then
	tab_1.tabpage_browse.tv_category.selectitem( ll_root )
end if



end subroutine

public function integer of_find_tvitem (long al_category, string as_doctype);//Added by Alfee 05.24.2007
long ll_root, ll_category, ll_doctype
treeviewitem ltvi_category, ltvi_doctype

ll_root = tab_1.tabpage_browse.tv_category.finditem( RootTreeItem!,0)
if ll_root < 0 then return 0

ll_category = tab_1.tabpage_browse.tv_category.finditem( ChildTreeItem!, ll_root)
do while ll_category > 0 
	tab_1.tabpage_browse.tv_category.getitem(ll_category, ltvi_category)
	if ltvi_category.data = al_category then
		ll_doctype = tab_1.tabpage_browse.tv_category.finditem( ChildTreeItem!, ll_category)
		do while ll_doctype > 0 
			tab_1.tabpage_browse.tv_category.getitem(ll_doctype, ltvi_doctype)
			if ltvi_doctype.data = as_doctype then	return ll_doctype
			ll_doctype = tab_1.tabpage_browse.tv_category.finditem( NextTreeItem!,ll_doctype)
		loop
		return ll_category
	else
		ll_category = tab_1.tabpage_browse.tv_category.finditem( NextTreeItem!,ll_category)
	end if
loop

return 0


end function

public function integer of_changetitle ();Long ll_row
String ls_document_name

ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
IF ll_row > 0 THEN
	ls_document_name = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "document_name")
	this.title = "Document Library Painter" + " - " + ls_document_name
ELSE
	this.title = "Document Library Painter"	
END IF

RETURN 1
end function

public function boolean of_set_preview_tabpage ();//Set enable property of document tabpage - Added by Alfee 01.08.20008

Long ll_row
String ls_doctype
Boolean lb_enabled = FALSE

ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
IF ll_row > 0 THEN 
	ls_doctype = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "document_type")
	IF Len(Trim(ls_doctype)) > 0 THEN
		IF Pos(is_doctype_support, Lower(ls_doctype) + ";", 1) > 0 THEN lb_enabled = TRUE
	END IF
END IF

//Added By Ken.Guo 2011-05-06. for Open PDF Mode
If lower(ls_doctype) = 'pdf' and gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '2' Then
	lb_enabled = false
End If


tab_1.tabpage_document.Enabled = lb_enabled

RETURN lb_enabled
end function

public subroutine of_selectole (string as_doctype);//////////////////////////////////////////////////////////////////////
// $<function>of_selectole()
// $<arguments>
//		value	string	as_doctype		
// $<returns> (none)
// $<description>Choose ole control for different type of document
//////////////////////////////////////////////////////////////////////
// $<add> 05.19.2008 by Alfee 
//////////////////////////////////////////////////////////////////////

CHOOSE CASE Lower(as_doctype) 
	CASE 'doc','docx', 'xls'
		//tab_1.tabpage_document.uo_1.visible = false
		tab_1.tabpage_document.uo_2.visible = false
		tab_1.tabpage_document.ole_word.visible = TRUE
	CASE 'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk' ,'pdf'
		IF gi_imageocx = 1 THEN //imaging 360
			//tab_1.tabpage_document.uo_1.visible = TRUE
			tab_1.tabpage_document.uo_2.visible = FALSE			
		ELSE
			//tab_1.tabpage_document.uo_1.visible = FALSE
			tab_1.tabpage_document.uo_2.visible = TRUE			
		END IF
		tab_1.tabpage_document.ole_word.visible = FALSE		
END CHOOSE


end subroutine

public function boolean of_issaved ();Boolean lb_modified = FALSE

CHOOSE CASE Lower(Tab_1.tabpage_browse.dw_browse.GetItemString(Tab_1.tabpage_browse.dw_browse.GetRow(),"document_type"))
	CASE 'doc'
		if not ib_ole_ini then 
			Return True
		End If
		
		try
			lb_modified = Not tab_1.tabpage_document.ole_word.object.ActiveDocument.saved
		catch(Throwable th)
			Messagebox('Warning','Failed to get modification status due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
			lb_modified = false
		end try
		
	CASE 'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk','pdf'
		IF gi_imageocx = 1 THEN //Imaging 360
			//lb_modified = tab_1.tabpage_document.uo_1.of_ismodified( )
		ELSE	//new Image OCX
			lb_modified = FALSE
		END IF
END CHOOSE

IF lb_modified Then
	RETURN FALSE	
END IF

RETURN TRUE
end function

on w_sheet_ctx_doc_painter.create
int iCurrent
call super::create
this.st_msg=create st_msg
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_msg
this.Control[iCurrent+2]=this.tab_1
end on

on w_sheet_ctx_doc_painter.destroy
call super::destroy
destroy(this.st_msg)
destroy(this.tab_1)
end on

event close;call super::close;IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

Destroy ids_tree //Added by Alfee 05.24.2007
tab_1.tabpage_document.ole_word.object.close()
w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
w_mdi.of_menu_security( w_mdi.MenuName )


If isvalid(inv_clause) Then Destroy inv_clause
end event

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-16 By: Rodger Wu (doc painter)
//$<reason> This window is designed by Rodger Wu for Contract Logix
//$<reason> Document Painter.
//---------------------------- APPEON END ----------------------------
//--------Begin Added by Alfee 05.24.2007---------
ids_tree = Create DataStore
ids_tree.DataObject = 'd_ctx_document_tree'
ids_tree.SetTransObject(SQLCA)
is_synatx_tree = ids_tree.Describe( "datawindow.table.select" )
//--------End Added------------------------------

tab_1.tabpage_browse.dw_browse.settransobject( SQLCA )
is_syntax = tab_1.tabpage_browse.dw_browse.Describe( "datawindow.table.select" )
is_syntax_aftersearch = is_syntax //Added by Alfee 05.24.2007

//-------Begin Modified by Alfee 05.24.2007---------
//of_build_tree()
tab_1.tabpage_browse.cb_go.event clicked()
//-------End Modified ------------------------------

ib_disableclosequery = True

if gs_dbtype = "SQL" and gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' then//Full Text Search;
	tab_1.tabpage_browse.dw_search.modify( "document_name_t.text='Full Text Search'" )
end if

gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06

inv_clause = Create n_cst_clause 
end event

event resize;call super::resize;tab_1.x = 0
tab_1.y = 0
tab_1.width = newwidth
tab_1.height = newheight

tab_1.tabpage_browse.tv_category.height = newheight - tab_1.tabpage_browse.tv_category.y - 138
tab_1.tabpage_browse.gb_1.width = newwidth - tab_1.tabpage_browse.gb_1.x - 50

tab_1.tabpage_browse.st_split_bar.x = tab_1.tabpage_browse.tv_category.x + tab_1.tabpage_browse.tv_category.width
tab_1.tabpage_browse.st_split_bar.y = tab_1.tabpage_browse.tv_category.y
tab_1.tabpage_browse.st_split_bar.height = tab_1.tabpage_browse.tv_category.height

tab_1.tabpage_browse.dw_browse.x = tab_1.tabpage_browse.st_split_bar.x + tab_1.tabpage_browse.st_split_bar.width
tab_1.tabpage_browse.dw_browse.y = tab_1.tabpage_browse.tv_category.y
tab_1.tabpage_browse.dw_browse.width = tab_1.width - tab_1.tabpage_browse.dw_browse.x - 50
tab_1.tabpage_browse.dw_browse.height = tab_1.tabpage_browse.tv_category.height

tab_1.tabpage_document.ole_word.width = tab_1.width - 40
tab_1.tabpage_document.ole_word.height = newheight - 138

//-----------------Begin Modified by Alfee om 05.19.2008----------------------------
//tab_1.tabpage_document.uo_1.x = tab_1.tabpage_document.ole_word.x
//tab_1.tabpage_document.uo_1.y = tab_1.tabpage_document.ole_word.y
//tab_1.tabpage_document.uo_1.width = tab_1.tabpage_document.ole_word.width
//tab_1.tabpage_document.uo_1.height = tab_1.tabpage_document.ole_word.height
tab_1.tabpage_document.uo_2.x = tab_1.tabpage_document.ole_word.x
tab_1.tabpage_document.uo_2.y = tab_1.tabpage_document.ole_word.y
tab_1.tabpage_document.uo_2.width = tab_1.tabpage_document.ole_word.width
tab_1.tabpage_document.uo_2.height = tab_1.tabpage_document.ole_word.height
/* tab_1.tabpage_document.ole_tif_edit.x = tab_1.tabpage_document.ole_word.x
tab_1.tabpage_document.ole_tif_edit.y = tab_1.tabpage_document.ole_word.y
tab_1.tabpage_document.ole_tif_edit.width = tab_1.tabpage_document.ole_word.width
tab_1.tabpage_document.ole_tif_edit.height = tab_1.tabpage_document.ole_word.height */
//------------------End Modified ------------------------------------------------------


end event

event closequery;call super::closequery;
tab_1.tabpage_document.ole_word.object.close()
end event

event activate;call super::activate;long ll_handle

If w_mdi.menuname <> 'm_ctx_doc_painter' Then
	w_mdi.ChangeMenu( m_ctx_doc_painter )
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
	
	ll_handle = handle(w_mdi)
	//gnv_appeondll.of_settoolbarpos(ll_handle) //comment by Appeon long.zhang 04.01.2017 (BugL040102)
	
	w_mdi.of_menu_security( w_mdi.MenuName )
End if

if tab_1.selectedtab = 2 then
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_insert,'enabled', false)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_delete1,'enabled', false)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_update,'enabled', false)
	
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_doc_view,'enabled', false)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_doc_properties,'enabled', false)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_copy,'enabled', false)
	//-------------Appeon Begin -----by Derek at 03.13.2007---------
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_file.m_save,'enabled', True)
	//-------------Appeon End   ------------------------------------
else
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_insert,'enabled', true)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_delete1,'enabled', true)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_update,'enabled', true)
	
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_doc_view,'enabled', true)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_doc_properties,'enabled', true)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_copy,'enabled', true)
	
	//-------------Appeon Begin -----by Derek at 03.13.2007---------
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_file.m_save,'enabled', False)
	//-------------Appeon End   ------------------------------------
end if
	

//----------Begin Added by Alfee 09.20.2007----------
If w_mdi.of_security_access(6802) < 2 Then
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_insert,'enabled', False)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_delete1,'enabled', False)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_update,'enabled', False)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_copy,'enabled', False)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_file.m_save,'enabled', False)
End If
//---------End Added -------------------------------------

//adjust toolbar, Added by Appeon long.zhang 04.01.2017 (BugL040102)
gnv_appeondll.of_settoolbarpos(ll_handle)
	
//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(This.tab_1.tabpage_document.ole_word ) Then
	This.tab_1.tabpage_document.ole_word.object.activate(true)
End If
end event

event pfc_save;call super::pfc_save;//added by alfee 04.29.2007
Return of_savefile()
end event

event deactivate;call super::deactivate;//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(This.tab_1.tabpage_document.ole_word ) Then
//	This.tab_1.tabpage_document.ole_word.object.activate(false)
//End If
end event

type st_msg from statictext within w_sheet_ctx_doc_painter
boolean visible = false
integer x = 759
integer y = 28
integer width = 1563
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
string text = "Click Update menu bar to save modified document into database."
boolean focusrectangle = false
end type

type tab_1 from tab within w_sheet_ctx_doc_painter
integer width = 3982
integer height = 1944
integer taborder = 10
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
tabpage_document tabpage_document
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_document=create tabpage_document
this.Control[]={this.tabpage_browse,&
this.tabpage_document}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_document)
end on

event selectionchanging;integer li_return

//if oldindex <> newindex and newindex = 2 then st_msg.visible = true

if oldindex = newindex then return;
if oldindex < 0 then return;
if ib_stop_selection then return;

if oldindex = 1 and newindex = 2 then
	li_return = parent.trigger event ue_doc_view()
	if li_return < 0 then return 1;
end if
end event

event selectionchanged;if oldindex < 0 then return;
if oldindex = newindex then return;

if isvalid( m_ctx_doc_painter ) then
	if newindex = 2 then
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_insert,'enabled', false)
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_delete1,'enabled', false)
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_update,'enabled', false)
		
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_doc_view,'enabled', false)
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_doc_properties,'enabled', false)
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_copy,'enabled', false)
		//-------------Appeon Begin -----by Derek at 03.13.2007---------
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_file.m_save,'enabled', True)
		//-------------Appeon End   ------------------------------------
	else
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_insert,'enabled', true)
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_delete1,'enabled', true)
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_update,'enabled', true)
		
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_doc_view,'enabled', true)
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_doc_properties,'enabled', true)
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_copy,'enabled', true)
		
		//-------------Appeon Begin -----by Derek at 03.13.2007---------
		gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_file.m_save,'enabled', False)
		//-------------Appeon End   ------------------------------------
	end if
end if

//----------Begin Added by Alfee 09.20.2007----------
If w_mdi.of_security_access(6802) < 2 Then
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_insert,'enabled', False)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_delete1,'enabled', False)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_update,'enabled', False)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_edit.m_copy,'enabled', False)
	gnv_app.of_modify_menu_attr( m_ctx_doc_painter.m_file.m_save,'enabled', False)
End If
//---------End Added -------------------------------------
end event

type tabpage_browse from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3945
integer height = 1816
long backcolor = 33551856
string text = " Browse "
long tabtextcolor = 33554432
string picturename = "Browse!"
long picturemaskcolor = 12632256
st_split_bar st_split_bar
dw_browse dw_browse
gb_1 gb_1
dw_search dw_search
pb_clear pb_clear
pb_search pb_search
tv_category tv_category
cb_go cb_go
cb_clear cb_clear
end type

on tabpage_browse.create
this.st_split_bar=create st_split_bar
this.dw_browse=create dw_browse
this.gb_1=create gb_1
this.dw_search=create dw_search
this.pb_clear=create pb_clear
this.pb_search=create pb_search
this.tv_category=create tv_category
this.cb_go=create cb_go
this.cb_clear=create cb_clear
this.Control[]={this.st_split_bar,&
this.dw_browse,&
this.gb_1,&
this.dw_search,&
this.pb_clear,&
this.pb_search,&
this.tv_category,&
this.cb_go,&
this.cb_clear}
end on

on tabpage_browse.destroy
destroy(this.st_split_bar)
destroy(this.dw_browse)
destroy(this.gb_1)
destroy(this.dw_search)
destroy(this.pb_clear)
destroy(this.pb_search)
destroy(this.tv_category)
destroy(this.cb_go)
destroy(this.cb_clear)
end on

type st_split_bar from u_st_splitbar within tabpage_browse
integer x = 521
integer y = 288
integer width = 14
integer height = 1188
end type

event constructor;call super::constructor;This.of_Register( tv_category, LEFT )
This.of_Register( dw_browse, Right )
end event

type dw_browse from u_dw_contract within tabpage_browse
event ue_enter pbm_dwnprocessenter
integer x = 942
integer y = 284
integer width = 2802
integer height = 1248
integer taborder = 50
string dataobject = "d_ctx_document_browse"
boolean hscrollbar = true
end type

event ue_enter;Long ll_selected
window lw_sheet

ll_selected = This.getselectedrow( 0 )
if ll_selected > 0 then
	lw_sheet = tab_1.getparent()
	lw_sheet.postevent( "ue_doc_properties" )
end if

Return 1
end event

event constructor;call super::constructor;ib_rmbmenu	= False
this.of_setupdateable(false)

of_setsort(true)
inv_sort.of_setcolumnheader(true)
inv_sort.of_setusedisplay( True )
of_setrowselect(True)
end event

event getfocus;//Override this event.
end event

event losefocus;//Override this event.
end event

event doubleclicked;call super::doubleclicked;window lw_sheet
if row < 1 then
	return
else
	lw_sheet = tab_1.getparent()
	lw_sheet.postevent( "ue_doc_view" )
end if
end event

event rbuttondown;pfc_u_dw::event trigger rbuttondown( xpos, ypos, row, dwo )
end event

event rowfocuschanged;call super::rowfocuschanged;//added by alfee 08.24.2007
of_changetitle()

//Set enable property of document tabpage - added by Alfee 01.08.2008
of_set_preview_tabpage()
end event

event retrieveend;call super::retrieveend;//Set enable property of document tabpage - added by Alfee 01.08.2008
of_set_preview_tabpage()

Return 0

end event

type gb_1 from groupbox within tabpage_browse
integer x = 9
integer y = 4
integer width = 3845
integer height = 260
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filter Criteria"
end type

type dw_search from u_dw_contract within tabpage_browse
event ue_enter pbm_dwnprocessenter
integer x = 41
integer y = 52
integer width = 3186
integer height = 204
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_ctx_document_query"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event ue_enter;//Send(Handle(this),256,9,Long(0,0))
pb_search.postevent( clicked! )
return 1
end event

event constructor;call super::constructor;ib_rmbmenu	= False
this.of_setupdateable(false)

this.event ue_populatedddws()
this.setfocus()

this.of_SetDropDownCalendar(TRUE)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03-04-2007 By: Ken.Guo
//$<reason> Filter no access right data
inv_right = Create n_cst_right
datawindowchild ldwc_category
dw_search.getchild('category',ldwc_category)
inv_right.of_filter_right( ldwc_category, 'code', 4)
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05-14-2007 By: Alfee
//$<reason> Change ddlb to dddw in document type field
datawindowchild ldwc_doctype
dw_search.getchild('document_type',ldwc_doctype)
ldwc_doctype.SetTransObject(SQLCA)
ldwc_doctype.retrieve()
ldwc_doctype.InsertRow(1) //08.22.2007
//---------------------------- APPEON END ----------------------------

end event

event rbuttondown;pfc_u_dw::event trigger rbuttondown( xpos, ypos, row, dwo )
end event

event itemchanged;call super::itemchanged;//Commented By Ken.Guo 2010-12-20
//if lower(dwo.name) = "category" then
//	this.accepttext()
//	//---------Begin Modified by Alfee 01.08.2007---------
//	//<$Reason>Triggered in ue_postitemchanged() if -777
//	IF data <> '-777' THEN
//		cb_go.event clicked()
//	END If
//	//cb_go.event clicked()
//	//---------End Modified ------------------------------
//end if
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//Added by Alfee 01.08.2008
IF data = '-777' THEN 
	cb_go.Post Event Clicked()
END IF


end event

type pb_clear from picturebutton within tabpage_browse
boolean visible = false
integer x = 3323
integer y = 124
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean originalsize = true
string picturename = "Clear!"
alignment htextalign = left!
string powertiptext = "Clear All Criteria"
end type

event clicked;dw_search.setredraw( false )
dw_search.reset()
dw_search.insertrow( 0 )
dw_search.setcolumn( "category" )
dw_search.post setfocus()
dw_search.setredraw( true )
end event

type pb_search from picturebutton within tabpage_browse
boolean visible = false
integer x = 3241
integer y = 124
integer width = 101
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Find!"
alignment htextalign = left!
string powertiptext = "Go"
end type

event clicked;long ll_category, ll_status, ll_roothandle,li_fulltext
string ls_name, ls_type, ls_user, ls_date
string ls_sql

if dw_search.accepttext() <> 1 then return;

ll_category = dw_search.getitemnumber( 1, "category" )
if not isnull( ll_category ) then ls_sql += " AND ctx_acp_document.category = " + string( ll_category )

ll_status = dw_search.getitemnumber( 1, "reviewed_status" )
if not isnull( ll_status ) then ls_sql += " AND ctx_acp_document.reviewed_status = " + string( ll_status )

ls_name = Trim( dw_search.getitemstring( 1, "document_name" ) )
if not isnull( ls_name ) and ls_name <> '' then
	if gs_dbtype = "SQL" and gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' then//Full Text Search;
	
		//Added By Ken.Guo 2011-01-14. Check the FT first.
		Select  (
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_document'),'document_name','IsFulltextIndexed' ) 
		+ 
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_document'),'description','IsFulltextIndexed' ) 
		+ 
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_document'),'image_file','IsFulltextIndexed' ) 
		+ 
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_document'),'image_text','IsFulltextIndexed' ) 		
		) 
		Into :li_fulltext From ids;		
		
		If isnull(li_fulltext) Then li_fulltext = 0
		If li_fulltext <> 4 Then
			If Messagebox('Document Filter',"The Full-Text Catalog hasn't been created for the documents yet. Do you want to create it now?", Question!,YesNo!) = 1 Then
				IF Not Isvalid(gnv_logservice) THEN gnv_logservice = Create n_logservice
				//---------Begin Modified by (Appeon)Eugene 06.29.2013 for V141 ISG-CLX--------				
				  /*
					n_cst_update_sql lnv_sql
					lnv_sql = Create n_cst_update_sql		
				  */
				n_cst_update_sql_clx lnv_sql
				lnv_sql = Create n_cst_update_sql_clx
				//---------End Modfiied ------------------------------------------------------------------				
				lnv_sql.of_release_fulltext( )			
				Destroy lnv_sql
			End If
		End If		
	
		ls_sql += " AND ( ctx_acp_document.ctx_acp_document_id in " + &
					 "( SELECT ctx_acp_document.ctx_acp_document_id " + &
					   "FROM ctx_acp_document " + &
						"WHERE contains(document_name, '" + ls_name + "') " + &
						"OR contains(description, '" + ls_name + "') " + &
						"OR contains(image_file, '" + ls_name + "') " + &
						"OR contains(image_text, '" + ls_name + "') ) ) " //Modify by Evan 07/18/2008: Add image_text search field.
	else
		ls_sql += " AND ctx_acp_document.document_name like '" + ls_name + "%'"
	end if
end if

ls_type = Trim( dw_search.getitemstring( 1, "document_type" ) )
if not isnull( ls_type ) and ls_type <> '' then ls_sql += " AND ctx_acp_document.document_type = '" + ls_type + "'"

ls_user = Trim( dw_search.getitemstring( 1, "reviewed_by" ) )
if not isnull( ls_user ) and ls_user <> '' then ls_sql += " AND Upper(ctx_acp_document.reviewed_by) = '" + Upper(ls_user) + "'" //by alfee 08.30.2007
//if not isnull( ls_user ) and ls_user <> '' then ls_sql += " AND ctx_acp_document.reviewed_by = '" + ls_user + "'"

ls_date = string( dw_search.getitemdatetime( 1, "date_reviewed" ), "mm/dd/yyyy" )
if ls_date <> "01/01/1900" and ls_date <> '' then
	ls_sql += " AND ctx_acp_document.date_reviewed = '" + ls_date + "'"
end if

//-----Begin Modified by Alfee 05.24.2007---------------
ids_tree.modify( 'datawindow.table.select = "' + is_synatx_tree + ls_sql + '"' )
ls_sql = is_syntax + ls_sql
dw_browse.modify( 'datawindow.table.select = "' + ls_sql + '"' )

//Keep sql for dw_browse after search operation
is_syntax_aftersearch = ls_sql 

//Build treeview
of_build_tree()

//if ls_sql = "" then
//	ls_sql = is_syntax + " ORDER BY ctx_acp_document.document_name "
//else
//	ls_sql = Right( ls_sql, Len( ls_sql ) - 4 )
//	ls_sql = is_syntax + " WHERE " + ls_sql + " ORDER BY ctx_acp_document.document_name "
//end if
//dw_browse.modify( 'datawindow.table.select = "' + ls_sql + '"' )
//dw_browse.retrieve()
//
//ib_stop_changed = True
//ll_roothandle = tv_category.FindItem( roottreeitem!, 0 )
////tv_category.collapseitem( ll_roothandle )
//tv_category.SelectItem( ll_roothandle )
//
//ib_stop_changed = False
//-------End Modified -----------------------------------
end event

type tv_category from treeview within tabpage_browse
integer x = 9
integer y = 284
integer width = 901
integer height = 1244
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
boolean fullrowselect = true
grsorttype sorttype = ascending!
string picturename[] = {"Custom039!","Custom050!","CheckDiff!"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event selectionchanged;treeviewitem ltvi_current, ltvi_parent
string ls_sql, ls_filter, ls_filter_right
Long ll_parent

if ib_stop_changed then return;
if oldhandle = newhandle then return;
If newhandle < 0 Then return //

This.GetItem( newhandle, ltvi_current )
Choose Case ltvi_current.level
	Case 1
		//-------Begin Modified by Alfee 05.24.2007----------------		
		ls_sql = is_syntax_aftersearch
		//ls_sql = is_syntax + " ORDER BY ctx_acp_document.document_name "
		//-------End Modified -----------------------------------							
	Case 2
		//-------Begin Modified by Alfee 05.24.2007----------------		
		ls_sql = is_syntax_aftersearch + " AND ctx_acp_document.category = " + &
					string( ltvi_current.data )
		//ls_sql = is_syntax + " WHERE ctx_acp_document.category = " + &
		//			string( ltvi_current.data ) + &
		//			" ORDER BY ctx_acp_document.document_name "*/
		//-------End Modified -----------------------------------					
	Case 3
		ll_parent = This.FindItem( parenttreeitem!, newhandle )
		if ll_parent < 1 then return;
		This.GetItem( ll_parent, ltvi_parent )
		//ls_sql = is_syntax_aftersearch + " WHERE ctx_acp_document.category = " + &
		ls_sql = is_syntax_aftersearch + " AND ctx_acp_document.category = " + &		
					string( ltvi_parent.data ) + &
					" AND ctx_acp_document.document_type = '" + &
					string( ltvi_current.data )  + "'"				
End Choose
dw_browse.modify( 'datawindow.table.select = "' + ls_sql + '"' )
dw_browse.retrieve()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04-04-2007 By: Ken.Guo
//$<reason> Filter data that have no access right if select treeview root 
If ltvi_current.level = 1 Then
	ls_filter = inv_right.of_getfilter('Category',4)
	dw_browse.setfilter(ls_filter)	
	dw_browse.filter()
End If
//---------------------------- APPEON END ----------------------------

//-------Begin Added by Alfee 05.24.2007---------------		
if tab_1.tabpage_browse.dw_browse.RowCount() > 0 then
	tab_1.tabpage_browse.dw_browse.SelectRow(0, false) 
	tab_1.tabpage_browse.dw_browse.ScrollTorow( 1)
	tab_1.tabpage_browse.dw_browse.SelectRow(1, True)
end if
//-------End Added -----------------------------------	

of_changetitle() //added by alfee 08.24.2007

end event

event rightclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (popmenu)

m_ctx_tv_popmenu lm_pop
treeviewitem ltvi_current

if handle < 1 then
	il_handle_rightclicked = 0
	return;
end if
il_handle_rightclicked = handle

lm_pop = create m_ctx_tv_popmenu
lm_pop.m_add.text = "&Add Document"
lm_pop.m_delete.text = "&Delete Document(s)"
//lm_pop.m_properties.text = '&Properties' //Rodger Wu (pop menu)
gnv_app.of_modify_menu_attr( lm_pop.m_properties,'Enabled', False)

This.GetItem( handle, ltvi_current )

if ltvi_current.children then
	if ltvi_current.Expanded then
		gnv_app.of_modify_menu_attr( lm_pop.m_expand,'Enabled', False)
	else
		gnv_app.of_modify_menu_attr( lm_pop.m_collapse,'Enabled', False)
	end if
else
	gnv_app.of_modify_menu_attr( lm_pop.m_expand,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_pop.m_collapse,'Enabled', False)
end if

if ltvi_current.level = 1 then
	gnv_app.of_modify_menu_attr( lm_pop.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_pop.m_expand,'Enabled', True)
end if

//----------Begin Added by Alfee 09.20.2007----------
If w_mdi.of_security_access(6802) < 2 Then
	gnv_app.of_modify_menu_attr( lm_pop.m_add,'enabled', False)
	gnv_app.of_modify_menu_attr( lm_pop.m_delete,'Enabled', False)
End If
//---------End Added -------------------------------------

lm_pop.popmenu( w_mdi.PointerX(), w_mdi.PointerY() )

//---------------------------- APPEON END ----------------------------

end event

type cb_go from commandbutton within tabpage_browse
integer x = 3241
integer y = 120
integer width = 270
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;tab_1.tabpage_browse.pb_search.TriggerEvent( Clicked! )
end event

type cb_clear from commandbutton within tabpage_browse
integer x = 3511
integer y = 120
integer width = 270
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Clear"
end type

event clicked;tab_1.tabpage_browse.pb_clear.TriggerEvent( Clicked! )

//Commented By Ken.Guo 2010-12-20
//tab_1.tabpage_browse.cb_go.TriggerEvent( Clicked! ) //added by alfee 05.14.2007
end event

type tabpage_document from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3945
integer height = 1816
boolean border = true
long backcolor = 33551856
string text = " Document "
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DosEdit5!"
long picturemaskcolor = 12632256
ole_word ole_word
uo_2 uo_2
end type

on tabpage_document.create
this.ole_word=create ole_word
this.uo_2=create uo_2
this.Control[]={this.ole_word,&
this.uo_2}
end on

on tabpage_document.destroy
destroy(this.ole_word)
destroy(this.uo_2)
end on

type ole_word from u_email_edit within tabpage_document
integer x = 5
integer y = 12
integer width = 1317
integer height = 768
integer taborder = 120
string binarykey = "w_sheet_ctx_doc_painter.win"
end type

type uo_2 from uo_dm_image_view_cp within tabpage_document
integer x = 201
integer y = 32
integer taborder = 70
end type

on uo_2.destroy
call uo_dm_image_view_cp::destroy
end on

event constructor;call super::constructor;//Set module called from - Alfee 07.28.2008
this.of_set_module( "document library painter")
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Bw_sheet_ctx_doc_painter.bin 
2300000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000565c418001d2aaa800000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000565c418001d2aaa8565c418001d2aaa80000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
26ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00001dc4000013d800dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00001dc4000013d800dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Bw_sheet_ctx_doc_painter.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
