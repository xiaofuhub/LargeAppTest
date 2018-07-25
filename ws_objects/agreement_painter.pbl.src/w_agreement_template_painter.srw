$PBExportHeader$w_agreement_template_painter.srw
forward
global type w_agreement_template_painter from w_sheet
end type
type tab_1 from u_tab_agreement_template within w_agreement_template_painter
end type
type tab_1 from u_tab_agreement_template within w_agreement_template_painter
end type
end forward

global type w_agreement_template_painter from w_sheet
integer x = 0
integer y = 0
integer width = 4087
integer height = 2160
string title = "Agreement Template Painter"
windowstate windowstate = maximized!
event pfc_addrow ( )
event pfc_deleterow ( long as_row )
event pfc_copy ( )
event pfc_cst_properties ( )
event pfc_cst_user_rights ( )
event pfc_cst_add_clause ( )
event pfc_cst_insert_field ( )
event pfc_cst_map_onoff ( )
event ue_inidw ( )
event pfc_cst_locate_file ( )
event pfc_cst_select ( )
event pfc_cst_print_report ( )
event ue_show_add_clause ( )
event pfc_cst_merge_data ( )
event type integer pfc_cst_preview_template ( )
event ue_menu_add ( )
event ue_menu_collapse ( )
event ue_menu_delete ( )
event ue_menu_expand ( )
event ue_menu_properties ( )
event pfc_cst_autonum ( )
event pfc_cst_insert_requirement ( )
event pfc_cst_locate_clause ( )
event ue_doc_saveas ( )
event ue_doc_email ( )
tab_1 tab_1
end type
global w_agreement_template_painter w_agreement_template_painter

type variables
string is_agreement_path  //Agreement files' path
long il_template_id // current template id
long il_export_id //export id for add clause //alfee 04.19.2007
long il_category //03.12.2008

long	il_StartPos = -1
long	il_EndPos   = -1

string is_current_file //Current opened file
string is_properties 
string is_chapter_mark[] = {"#","@"}
string is_paragraph = "#.0"
string is_section_mark = "#.#"
//string is_sub_section = "#.#.#"
//string is_end_section = "#.#.#.#"

boolean ib_map = false //map on or off
boolean ib_needsave = false //for template file
boolean ib_locate = true //need of locate in file
boolean ib_close = false

oleobject iole_word //new word ole object
n_cst_word_utility inv_word // by alfee 04.20.2007

str_clause_filter	istr_ClauseFilter		//Added by Scofield on 2010-01-14

long il_clause_approved 

datastore ids_search_template_text
datastore ids_clause_approved //added by alfee 05.28.2007

//for VBA of word 
constant int wdSeekMainDocument = 0
constant int wdSeekPrimaryHeader = 1
constant int wdSeekFirstPageHeader = 2
constant int wdSeekEvenPagesHeader = 3
constant int wdSeekPrimaryFooter = 4
constant int wdSeekFirstPageFooter = 5
constant int wdSeekEvenPagesFooter = 6
constant int wdSeekFootnotes = 7
constant int wdSeekEndnotes = 8
constant int wdSeekCurrentPageHeader = 9
constant int wdSeekCurrentPageFooter = 10


// WdSaveOptions
constant int wdDoNotSaveChanges = 0
constant int wdPromptToSaveChanges = -2
constant int wdSaveChanges = -1

// WdConstants
Constant long wdAutoPosition = 0
Constant long wdFirst = 1
Constant long wdToggle = 9999998
Constant long wdUndefined = 9999999
Constant long wdForward = 1073741823
Constant long wdBackward = -1073741823
Constant long wdCreatorCode = 1297307460

// WdLanguageID
constant long wdSendToNewDocument = 0
Constant long wdDanish = 1030
Constant long wdGerman = 1031
Constant long wdGreek = 1032
Constant long wdEnglishUS = 1033
Constant long wdSpanish = 1034
Constant long wdFinnish = 1035
Constant long wdFrench = 1036
Constant long wdBelgianDutch = 2067
Constant long wdBelgianFrench = 2060
Constant long wdDutch = 1043
Constant long wdEnglishUK = 2057
Constant long wdItalian = 1040
Constant long wdNoProofing = 1024
Constant long wdPortuguese = 2070
Constant long wdSpanishModernSort = 3082
Constant long wdSwedish = 1053

// WdCountry
Constant long wdUS = 1
Constant long wdNetherlands = 31
Constant long wdFrance = 33
Constant long wdSpain = 34
Constant long wdItaly = 39
Constant long wdUK = 44
Constant long wdDenmark = 45
Constant long wdSweden = 46
Constant long wdGermany = 49
Constant long wdFinland = 358

// WdDictionaryType
Constant long wdSpelling = 0
Constant long wdGrammar = 1
Constant long wdThesaurus = 2
Constant long wdHyphenation = 3
Constant long wdSpellingComplete = 4
Constant long wdSpellingCustom = 5
Constant long wdSpellingLegal = 6
Constant long wdSpellingMedical = 7

// WdDocumentType
Constant long wdTypeDocument = 0
Constant long wdTypeTemplate = 1

// WdBuiltInProperty
Constant long wdPropertyTitle = 1
Constant long wdPropertySubjec = 2
Constant long wdPropertyAuthor = 3
Constant long wdPropertyConstants = 4
Constant long wdPropertyComments = 5
Constant long wdPropertyTemplate = 6
Constant long wdPropertyLastAuthor = 7
Constant long wdPropertyRevision = 8
Constant long wdPropertyAppName = 9
Constant long wdPropertyTimeLastPrinted = 10
Constant long wdPropertyTimeCreated = 11
Constant long wdPropertyTimeLastSaved = 12
Constant long wdPropertyVBATotalEdit = 13
Constant long wdPropertyPages = 14
Constant long wdPropertyWords = 15
Constant long wdPropertyCharacters = 16
Constant long wdPropertySecurity = 17
Constant long wdPropertyCategory = 18
Constant long wdPropertyFormat = 19
Constant long wdPropertyManager = 20
Constant long wdPropertyCompany = 21
Constant long wdPropertyBytes = 22
Constant long wdPropertyLines = 23
Constant long wdPropertyParas = 24
Constant long wdPropertySlides = 25
Constant long wdPropertyNotes = 26
Constant long wdPropertyHiddenSlides = 27
Constant long wdPropertyMMClips = 28
Constant long wdPropertyHyperlinkBase = 29
Constant long wdPropertyCharsWSpaces = 30

// WdAlertLevel
Constant long wdAlertsAll = -1
Constant long wdAlertsMessageBox = -2
Constant long wdAlertsNone = 0

// WdArrangeStyle
Constant long wdIcons = 1
Constant long wdTiled = 0

// WdBookmarkSortBy
Constant long wdSortByLocation = 1
Constant long wdSortByName = 0

// WdBreakType
Constant long wdSectionBreakNextPage = 2
Constant long wdSectionBreakContinuous = 3
Constant long wdSectionBreakEvenPage = 4
Constant long wdSectionBreakOddPage = 5
Constant long wdLineBreak = 6
Constant long wdPageBreak = 7
Constant long wdColumnBreak = 8

// WdBrowseTarget
Constant long wdBrowsePage = 1
Constant long wdBrowseSection = 2
Constant long wdBrowseComment = 3
Constant long wdBrowseFootnote = 4
Constant long wdBrowseEndnote = 5
Constant long wdBrowseField = 6
Constant long wdBrowseTable = 7
Constant long wdBrowseGraphic = 8
Constant long wdBrowseHeading = 9
Constant long wdBrowseEdit = 10
Constant long wdBrowseFind = 11
Constant long wdBrowseGoTo = 12

// WdCharacterCase
Constant long wdLowerCase = 0 
Constant long wdUpperCase = 1
Constant long wdTitleWord = 2
Constant long wdTitleSentence = 4
Constant long wdToggleCase = 5
Constant long wdNextCase = -1

// WdCollapseDirection
Constant long wdCollapseEnd = 0
Constant long wdCollapseStart = 1

// WdInternationalIndex
Constant long wdProductLanguageID = 26

// wdWindowState
constant int wdWindowStateNormal = 0
constant int wdWindowStateMaximize = 1
constant int wdWindowStateMinimize = 2

// wdGoToDirection
constant int wdGoToAbsolute = 1
constant int wdGoToFirst = 1
constant int wdGoToLast = -1
constant int wdGoToNext = 2
constant int wdGoToPrevious = 3
constant int wdGoToRelative = 2

// wdGoToItem
constant int wdGoToBookmark = -1
constant int wdGoToSection = 0
constant int wdGoToPage = 1
constant int wdGoToTable = 2
constant int wdGoToLine = 3
constant int wdGoToFootNote = 4
constant int wdGoToEndNote = 5
constant int wdGoToComment = 6
constant int wdGoToField = 7
constant int wdGoToGraphic = 8
constant int wdGoToObject = 9
constant int wdGoToEquation = 10
constant int wdGoToHeading = 11
constant int wdGoToPercent = 12
constant int wdGoToSpellingError = 13
constant int wdGoToGrammaticalError = 14
constant int wdGoToProofReadingError = 15

// wdMovementType
constant int wdMove = 0
constant int wdExtend = 1

// wdUnits
constant int wdCharacter = 1
constant int wdWord = 2
constant int wdSentence = 3
constant int wdLine = 5
constant int wdStory = 6
constant int wdColumn = 9
constant int wdRow = 10
constant int wdCell = 12

//wdViewType
constant int wdNormalView = 1
constant int wdOutlineView = 2
constant int wdPageView = 3
constant int wdPrintPreview = 4
constant int wdMasterView = 5
constant int wdOnlineView = 6
constant int wdReadingView = 7				//Added By Mark Lee 06/19/2013 office 2013 default is 7 

//WDOpenFormat
constant int wdOpenFormatAllWord = 6 
constant int wdOpenFormatAuto = 0 
constant int wdOpenFormatDocument = 1 
constant int wdOpenFormatEncodedText = 5 
constant int wdOpenFormatRTF = 3 
constant int wdOpenFormatTemplate = 2 
constant int wdOpenFormatText = 4 
constant int wdOpenFormatUnicodeText =  5 
constant int wdOpenFormatWebPages = 7 
constant int wdOpenFormatXML = 8 

//WdFindWrap
Constant int wdFindAsk = 2 
Constant int wdFindContinue = 1 
Constant int wdFindStop = 0 

Constant Long wdColorBlack = 0

//WdReplace
Constant int wdReplaceAll = 2 
Constant int wdReplaceNone = 0 
Constant int wdReplaceOne = 1 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (pop menu)
long il_handle_rightclicked = 0
//---------------------------- APPEON END ----------------------------

Constant long wdFormatDocument = 0 //Alfee 10.31.2007

Boolean ib_showed = False	//Added by Ken.Guo on 2008-11-06

n_cst_clause inv_clause //Added By Ken.Guo 2010-01-18.
Boolean ib_ole_ini = false 					//Added By Mark Lee 11/14/2012
end variables

forward prototypes
public function integer of_displayfile (string as_file)
public function integer of_menu_security (string as_screen)
public function boolean of_fileopened (string as_file)
public function integer of_fileclear (long al_templateid)
public function integer of_filter_clause (long al_template_id)
public function integer of_refresh_clause ()
public function integer of_savefile ()
public function integer of_put_template_file (long al_templateid, datetime adt_lastupdate)
public subroutine of_select ()
public function integer of_set_menu (boolean ab_flag)
public function integer of_preview_files (long al_clauseid[])
public function integer of_get_template_file (long al_templateid, datetime adt_lastupdate)
public function integer of_merge_files (long al_clauseid[])
public function integer of_changetitle ()
public function integer of_get_pagebreak (long al_clauseid[], ref long al_pagebreak[], ref long ai_appendparagraph[])
public function boolean of_issaved ()
end prototypes

event pfc_addrow();//////////////////////////////////////////////////////////////////////
// $<event>pfc_addroww_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Add a template
//////////////////////////////////////////////////////////////////////
// $<add> 12.6.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
//openwithparm(w_agreement_template_properties,"Add")
long ll_cnt, ll_row, ll_find
string ls_rtn  

//--------Begin Added by Alfee 03.12.2008 -------------------
ll_row = tab_1.tabpage_1.dw_browse.GetRow()
IF ll_row > 0 THEN
	il_category = tab_1.tabpage_1.dw_browse.GetItemNumber(ll_row,"category")
ELSE
	il_category = -1
END IF
//---------End Added ----------------------------------------
is_properties = "Add"
open(w_agreement_template_properties)

ls_rtn = message.stringparm
if isnull(ls_rtn) or len(trim(ls_rtn)) < 1 then return

SetRedraw(FALSE) //alfee 05.21.2007

if long(ls_rtn) > 0 then
	tab_1.tabpage_1.cb_go.event clicked()
	
	ll_cnt = tab_1.tabpage_1.dw_browse.rowcount()
//	if ll_cnt < 1 then return
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.12.2007 By: Machongmin
	//$<reason> Fix a defect.
	long ll_category
	long ll_h
	ll_find = tab_1.tabpage_1.dw_browse.find("ctx_acp_template_id = " +ls_rtn,1,ll_cnt)
	if ll_find > 0 then
		ll_category = tab_1.tabpage_1.dw_browse.object.category[ll_find]
		if ll_category > 0 then
			ll_h = tab_1.tabpage_1.of_find_tvitem(ll_category,0)
			if ll_h > 0 then
				tab_1.tabpage_1.tv_1.selectitem(ll_h)
				tab_1.tabpage_1.tv_1.expandall(ll_h)
				tab_1.tabpage_1.tv_1.setfocus()
			end if
		end if
	end if
	//---------------------------- APPEON END ----------------------------
	ll_find = tab_1.tabpage_1.dw_browse.find("ctx_acp_template_id = " +ls_rtn,1,ll_cnt)
	if ll_find > 0 then
		il_template_id = long(ls_rtn)
		tab_1.tabpage_1.dw_browse.scrolltorow(ll_find)
		tab_1.tabpage_1.dw_browse.selectrow(ll_find,true)
		if tab_1.SelectedTab = 1 then tab_1.SelectTab(2)		//Add by scofield 2007-05-06
	end if
	
	if tab_1.selectedtab = 2 then of_select() 
end if
	
SetRedraw(TRUE) //alfee 05.21.2007	

end event

event pfc_deleterow(long as_row);//////////////////////////////////////////////////////////////////////
// $<event>pfc_deleteroww_agreement_template_painter()
// $<arguments>
//		long	as_row		
// $<returns> (None)
// $<description>delete a template record
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_mes,ll_currentrow,ll_template_id
long ll_category, ll_find, ll_h, ll_cnt

ll_currentrow  = tab_1.tabpage_1.dw_browse.getrow()
if ll_currentrow < 1 then return

ll_mes = messagebox('Delete Template', 'Are you sure you want to delete this template?',question!,Yesno!,2)
if ll_mes = 2 then return

ll_template_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_currentrow,"ctx_acp_template_id")
ll_category = tab_1.tabpage_1.dw_browse.object.category[ll_currentrow]  //05.21.2007 alfee

//-----Begin Added by Alfee 08.04.2007----------------------------------
Select Count(*) Into :ll_cnt From ctx_am_document Where base_type = '1' and from_templete_id = :ll_template_id ;
If ll_cnt > 0 Then
	//MessageBox('Delete Template', 'The template is used in Document Manager, Cannot delete the template.')	
	MessageBox('Delete Template', 'Cannot delete the template, because the template is used in Document Manager, ') 
	Return		
End If
//-----End Added -------------------------------------------------------

gnv_appeondb.of_startqueue() //for web performance
delete from ctx_acp_template_clause where ctx_acp_template_id = :ll_template_id;
delete from ctx_acp_template where ctx_acp_template_id = :ll_template_id;
gnv_appeondb.of_commitqueue()//for web performance

if sqlca.sqlcode = 0 then
	tab_1.tabpage_1.dw_browse.deleterow(ll_currentrow) //delete the row in browse
	of_fileclear(ll_template_id) //close and delete the local file and registry. 			
end if

//-----------------Begin Modified by Alfee 05.21.2007---------------------------
/*tab_1.tabpage_1.cb_go.event clicked() //added by alfee at 04.09.2007

if tab_1.tabpage_1.dw_browse.rowcount() > 0 then 
	if tab_1.tabpage_1.dw_browse.rowcount() >= ll_currentrow then
		tab_1.tabpage_1.dw_browse.scrolltorow(ll_currentrow)
		tab_1.tabpage_1.dw_browse.selectrow(ll_currentrow,true)
	end if
	ll_currentrow = tab_1.tabpage_1.dw_browse.getrow()
	il_template_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_currentrow,"ctx_acp_template_id")
else
	setnull(il_template_id)
end if */

SetRedraw(FALSE)
//Rebuild treeview
tab_1.tabpage_1.cb_go.event clicked() 
//Locate category in treeview
if ll_category > 0 then 
	ll_h = tab_1.tabpage_1.of_find_tvitem(ll_category,0)
	if ll_h > 0 then
		tab_1.tabpage_1.tv_1.selectitem(ll_h)
		tab_1.tabpage_1.tv_1.expandall(ll_h)
		tab_1.tabpage_1.tv_1.setfocus()
	end if
end if
//Set current template id
if tab_1.tabpage_1.dw_browse.rowcount() > 0 then 
	ll_currentrow = tab_1.tabpage_1.dw_browse.getrow()
	il_template_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_currentrow,"ctx_acp_template_id")
else
	setnull(il_template_id)
end if 

SetRedraw(TRUE)
//---------------End Modified------------------------------

//-----Begin Modified by Alfee 05.21.2007---------
//<$Reason> Keep same with clause library painter
//if tab_1.selectedtab = 2 then of_select() 
if tab_1.selectedtab = 2 then 
	tab_1.tabpage_2.ole_1.object.Close()
	tab_1.SelectTab(1)
end if
//----End Modified------------------------------
	






end event

event pfc_copy();//////////////////////////////////////////////////////////////////////
// $<event>pfc_copyw_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Copy from a existing template file
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_cnt,ll_find
string ls_rtn

if tab_1.tabpage_1.dw_browse.getrow() < 1 then return

//openwithparm(w_agreement_template_properties,"Copy")

is_properties = "Copy"
open(w_agreement_template_properties)

ls_rtn = message.stringparm
if isnull(ls_rtn) or len(trim(ls_rtn)) < 1 then return

if long(ls_rtn) > 0 then
	tab_1.tabpage_1.cb_go.event clicked()
	
	ll_cnt = tab_1.tabpage_1.dw_browse.rowcount()
//	if ll_cnt < 1 then return

	ll_find = tab_1.tabpage_1.dw_browse.find("ctx_acp_template_id = " +ls_rtn,1,ll_cnt)
	if ll_find > 0 then 
		il_template_id = long(ls_rtn)
		tab_1.tabpage_1.dw_browse.scrolltorow(ll_find)
		tab_1.tabpage_1.dw_browse.selectrow(ll_find,true)
		tab_1.tabpage_2.dw_clause.SetRedraw(False)
		tab_1.tabpage_2.dw_clause.retrieve() //added by alfee 05.11.2007
	end if
	
	if tab_1.selectedtab = 2 then of_select() 
	tab_1.tabpage_2.dw_clause.SetRedraw(True)	
end if
end event

event pfc_cst_properties();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_propertiesw_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Template properties' operation
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
if tab_1.tabpage_1.dw_browse.getrow() < 1 then return

//openwithparm(w_agreement_template_properties,"Edit")

is_properties = "Edit"
open(w_agreement_template_properties)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.12.2007 By: Machongmin
//$<reason> Fix a defect.
long ll_category
long ll_h,ll_cnt,ll_find
string ls_rtn

ls_rtn = message.stringparm
if isnull(ls_rtn) or len(trim(ls_rtn)) < 1 then 
	tab_1.tabpage_1.dw_browse.selectrow(tab_1.tabpage_1.dw_browse.getrow(),true)
	return
end if

SetRedraw(FALSE) //alfee 05.21.2007

if long(ls_rtn) > 0 then
	tab_1.tabpage_1.cb_go.event clicked()
	
	ll_cnt = tab_1.tabpage_1.dw_browse.rowcount()
	ll_find = tab_1.tabpage_1.dw_browse.find("ctx_acp_template_id = " +ls_rtn,1,ll_cnt)
	if ll_find > 0 then
		ll_category = tab_1.tabpage_1.dw_browse.object.category[ll_find]
		if ll_category > 0 then
			ll_h = tab_1.tabpage_1.of_find_tvitem(ll_category,0)
			if ll_h > 0 then
				tab_1.tabpage_1.tv_1.selectitem(ll_h)
				tab_1.tabpage_1.tv_1.expandall(ll_h)
				tab_1.tabpage_1.tv_1.setfocus()
			end if
		end if
	end if
	ll_find = tab_1.tabpage_1.dw_browse.find("ctx_acp_template_id = " +ls_rtn,1,ll_cnt)
	if ll_find > 0 then 
		il_template_id = long(ls_rtn)
		tab_1.tabpage_1.dw_browse.scrolltorow(ll_find)
		tab_1.tabpage_1.dw_browse.selectrow(ll_find,true)
	end if
	
	if tab_1.selectedtab = 2 then of_select() 
end if
//---------------------------- APPEON END ----------------------------	
SetRedraw(TRUE) //alfee 05.21.2007

//added by alfee at 04.10.2007
tab_1.tabpage_1.dw_browse.selectrow(tab_1.tabpage_1.dw_browse.getrow(),true)
end event

event pfc_cst_user_rights();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_user_rightsw_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Link to user rights module
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
open(w_security_roles_painter)
end event

event pfc_cst_add_clause();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_add_clausew_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Add clauses to a template
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_template_id,ll_currentrow

ll_currentrow = tab_1.tabpage_1.dw_browse.getrow()
if ll_currentrow > 0 then
	//--------Appeon Begin --------------------------------------
	//<Reason> for add clause, by alfee 04.19.2007
	//	ll_template_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_currentrow,"ctx_acp_template_id")
	il_template_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_currentrow,"ctx_acp_template_id")
	il_export_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_currentrow,"export_id")
	//--------Appeon End ----------------------------------------
	this.event ue_show_add_clause()
end if
end event

event pfc_cst_insert_field();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_insert_fieldw_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert a selected field into a template file
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_export_id,ll_row
string ls_merge_field

ll_row = tab_1.tabpage_1.dw_browse.getrow()
if ll_row < 1 then return

If tab_1.tabpage_2.ole_1.object.DocType <> 1 Then return //no word document opened

ll_export_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_row,"export_id")
if isnull(ll_export_id) then 
	//messagebox("IntelliSoftGroup","There isn't a related export id found, please check it firstly!")
	messagebox("Export ID Not Found","No related export ID was found. Please verify first!")
	return
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 25/04/2007 By: Jervis
//$<reason> 
//openwithparm(w_agreement_template_merge_fields,ll_export_id)
str_pass lstr_pass
lstr_pass.s_long[1] = ll_export_id
lstr_pass.s_string = "TEMPLATE"
openwithparm(w_agreement_template_merge_fields,lstr_pass)
//---------------------------- APPEON END ----------------------------


//w_agreement_template_merge_fields.of_set_parent(this)
//w_agreement_template_merge_fields.of_set_object(tab_1.tabpage_2.ole_1.object.ActiveDocument) //commented by alfee 05.25.2007

/*
ls_merge_field = message.stringparm

If not len(ls_merge_field) > 0 Then 
	return
End If

//insert the field
//iole_word = tab_1.tabpage_2.ole_1.object.GetIDispatch()
//iole_word = tab_1.tabpage_2.ole_1.object.ActiveDocument
iole_word.ActiveWindow.Selection.Fields.Add(iole_word.ActiveWindow.Selection.Range,-1,"MERGEFIELD  " + ls_merge_field,true)

////save the template file
//tab_1.tabpage_2.ole_1.object.save(is_current_file)
*/

end event

event pfc_cst_map_onoff();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_map_onoffw_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>handling after map on or off
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
if ib_map then 
	ib_map = false
else
	ib_map = true
end if

tab_1.tabpage_2.of_maponoff(ib_map)
end event

event ue_inidw();//////////////////////////////////////////////////////////////////////
// $<event>ue_inidww_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Initialize datawindows
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
DataWindowChild dwc_template_name,dwc_reviewed_by

tab_1.tabpage_1.dw_filter.GetChild ("template", dwc_template_name)
tab_1.tabpage_1.dw_filter.GetChild ("reviewed_by", dwc_reviewed_by)

dwc_template_name.settransobject(sqlca)
dwc_reviewed_by.settransobject(sqlca)

gnv_appeondb.of_startqueue() //for web performance tuning
dwc_template_name.retrieve()
dwc_reviewed_by.retrieve()
tab_1.tabpage_1.ds_tree.retrieve() 
tab_1.tabpage_2.dw_clause.retrieve() 
gnv_appeondb.of_commitqueue() //for web performance tuning

tab_1.tabpage_1.dw_browse.setfilter("1=2")
tab_1.tabpage_1.dw_browse.filter() 

tab_1.tabpage_2.dw_clause.setfilter("1=2")
tab_1.tabpage_2.dw_clause.filter() 

dwc_template_name.insertrow(1)
dwc_template_name.setitem(1,"template_name","")

dwc_reviewed_by.insertrow(1)
dwc_reviewed_by.setitem(1,"user_id", "")

//for full text search
ids_search_template_text = Create datastore
ids_search_template_text.dataobject = 'd_search_template_text'
ids_search_template_text.settransobject(sqlca)

//-----Begin Added by Alfee 05.28.2007--------------
ids_clause_approved = Create DataStore
ids_clause_approved.DataObject = 'd_agreement_template_clause_approved'
ids_clause_approved.SetTransObject(SQLCA)
//-----End Added ------------------------------------



end event

event pfc_cst_locate_file();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_locate_filew_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>locate in opened template file according to the selected clause
//////////////////////////////////////////////////////////////////////
// $<add> 11.28.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

long ll_clause_id, ll_row ,ll_start
string ls_bookmark
Oleobject ole_range

if tab_1.selectedtab <> 2 or not ib_locate then return
ll_row = tab_1.tabpage_2.dw_clause.getrow()
if ll_row < 1 then return

ll_clause_id = tab_1.tabpage_2.dw_clause.getitemnumber(ll_row,"ctx_acp_clause_id")

//iole_word = tab_1.tabpage_2.ole_1.object.ActiveDocument
If tab_1.tabpage_2.ole_1.object.DocType <> 1 Then return //no word document opened

//----Begin Modified by Alfee 07.23.2007------------------------------
//<$Reason>locate clause at top of the document
ls_bookmark = "clause_" +string(ll_clause_id)
if iole_word.bookmarks.exists(ls_bookmark) then 
	//Goto EndLine and Select it
	ole_range = iole_word.GoTo(3, -1) 
	ole_range.select()
	//Select first line in bookmark.  
	ll_start = iole_word.bookmarks.item(ls_bookmark).start
	iole_word.range(ll_start, ll_start).Select()
	//Select bookmark. 
	iole_word.bookmarks.item(ls_bookmark).select()
end if
/*if iole_word.bookmarks.exists("clause_" +string(ll_clause_id)) then 
	iole_word.bookmarks.item("clause_" +string(ll_clause_id)).select()
end if*/
//----End Modified ---------------------------------------------------
end event

event pfc_cst_select();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_selectw_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Select operation
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
tab_1.selecttab(2)
end event

event pfc_cst_print_report();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_print_reportw_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Print the template file
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
integer li_rtn

if isnull(il_template_id) then 
	//messagebox( "IntelliSoftGroup","Please select a template firstly!")
	messagebox( "Select a Template","Please select a template first!")
	return
end if

//li_rtn = messagebox( "IntelliSoftGroup", "This template file is being sent to printer, continue?", Question!, YesNo!) 
li_rtn = messagebox( "Send Tempalte File", "This template file is being sent to printer, continue?", Question!, YesNo!) 
if li_rtn = 2 then return


if not isnull(is_current_file) then
	//check whether the file of current template id is opened
	if lower(is_current_file) = lower(is_agreement_path + "template_"+string(il_template_id) + ".doc") then
		//tab_1.tabpage_2.ole_1.object.print()
		tab_1.tabpage_2.ole_1.object.printout(True) 
		return
	end if
end if

SetPointer(HourGlass!)

this.event pfc_cst_select()
//tab_1.tabpage_2.ole_1.object.print()
tab_1.tabpage_2.ole_1.object.printout(True)




			
		
end event

event ue_show_add_clause();//show add clause window
if not isvalid(w_agreement_template_add_clause) then
	open(w_agreement_template_add_clause)
else
	w_agreement_template_add_clause.show()
	w_agreement_template_add_clause.of_open()
end if
w_agreement_template_painter.enabled = false
of_menu_security("others")

end event

event pfc_cst_merge_data();string ls_name , ls_path , ls_source_file
long ll_row
Long ll_ctx_id[] //Added By Ken.Guo 2009-07-06.
String ls_master_contract_name,ls_error //Added By Ken.Guo 2009-07-06.
integer li_export_id
oleobject lole_word

IF IsValid(w_agreement_template_merge_data) THEN Close(w_agreement_template_merge_data) //Alfee 09.19.2008

ll_row  = tab_1.tabpage_1.dw_browse.getrow()
if ll_row < 1 then return 
li_export_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_row,"export_id")

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2009-07-06 By: Ken.Guo
//$<reason> Must get CTX ID, and single selected CTX for Merge data. 
//ls_source_file = inv_word.of_run_export(li_export_id)
Openwithparm(w_mastert_contract_search,'ALL')
ls_master_contract_name = message.stringparm  
ll_ctx_id[1] = long(mid(ls_master_contract_name,1,pos(ls_master_contract_name,'-') - 1))  
If ll_ctx_id[1] <= 0 Then
	Return 
End If
ls_source_file = inv_word.of_run_export(li_export_id,ll_ctx_id[])
//---------------------------- APPEON END ----------------------------

if len(trim(ls_source_file)) < 1 then return

setpointer(HourGlass!)
IF Not isvalid( w_export_progress) Then Openwithparm( w_export_progress, "merging data in template..." )
w_export_progress.hpb_bar.position = 100
w_export_progress.st_progress.text = "Merging Data"
w_export_progress.st_export.text = ""
w_export_progress.st_export1.text = ""
w_export_progress.hpb_1.stepit( )

this.setredraw(false)

if FileExists(is_agreement_path + "tem_1.doc") then
	FileDelete(is_agreement_path + "tem_1.doc")
end if
if FileExists(is_agreement_path + "tem_1_merged.doc") then
	FileDelete(is_agreement_path + "tem_1_merged.doc")
end if
	
//Save current document and copy to a temporary file
tab_1.tabpage_2.ole_1.object.savetolocal(is_current_file, true)
FileCopy(is_current_file,is_agreement_path + "tem_1.doc",true)

//Added By Ken.Guo 2009-07-06. Dynamic add Clause by rules.
inv_word.of_apply_clause_rules(is_agreement_path + "tem_1.doc",il_template_id,ll_ctx_id[1])

w_export_progress.hpb_1.stepit( )

////tab_1.tabpage_2.ole_1.object.save(is_agreement_path + "tem_1.doc")
//tab_1.tabpage_2.ole_1.object.saveToLocal(is_agreement_path + "tem_1.doc" , true)
lole_word = create oleobject
if lole_word.Connecttonewobject("word.application") <> 0 then
	IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
	Destroy lole_word //Alfee 01.17.2008
	messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	return
end if 
w_export_progress.hpb_1.stepit( )

lole_word.visible = false
lole_word.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2008-07-22
lole_word.Application.Documents.Open(is_agreement_path + "tem_1.doc",false,true)
gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
gnv_shell.of_delete_recent( "tem_1.doc", false) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
w_export_progress.hpb_1.stepit( )
gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.

Try	
lole_word.visible = false

//Auto numbering -- //moved to the before of merging data by Alfee 05.28.2007
inv_word.of_preview(lole_word.ActiveDocument, True) //Update all fields
w_export_progress.hpb_1.stepit( )

inv_word.of_refresh_reqmnt_fields(lole_word,ll_ctx_id[1],ls_error) //Added By Ken.Guo 2009-07-06.

//Unprotect document if needed - Alfee 03.10.2008
//inv_word.of_unprotect_doc(lole_word.ActiveDocument) 
IF inv_word.of_unprotect_doc(lole_word.ActiveDocument) = -1 THEN //Alfee 10.08.2008
	this.setredraw(true)
	IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
	f_word_destroy(lole_word,"")	
	RETURN 
END IF

//Merging Data
lole_word.ActiveDocument.MailMerge.OpenDataSource(ls_source_file)
gnv_shell.of_delete_recent( ls_source_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
lole_word.ActiveDocument.MailMerge.DataSource.FirstRecord = 1
lole_word.ActiveDocument.MailMerge.DataSource.LastRecord = 100000
lole_word.ActiveDocument.Mailmerge.Destination = wdSendToNewDocument
lole_word.ActiveDocument.MailMerge.SuppressBlankLines = True
w_export_progress.hpb_1.stepit( )

//---------Begin Added by alfee 04.30.2007 fix a bug-------
//0 -- not locked ; -1 -- all locked ; 99999 -- partly locked
If lole_word.activedocument.fields.locked <> 0 then
	lole_word.activedocument.fields.locked = 0
end if
//---------Begin Modified by Alfee 05.28.2007 ---------------------
lole_word.ActiveDocument.Mailmerge.Execute //this sentence will cause the bookmarks.count set to 0
//lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = False
//---------End Modified by alfee 04.30.2007------------------
//---------End Added by alfee 04.30.2007------------------
w_export_progress.hpb_1.stepit( )

//Save the merged file
lole_word.ActiveDocument.SaveAs(is_agreement_path + "tem_1_merged.doc",0,false,'',false)
gnv_shell.of_delete_recent( "tem_1_merged.doc", False) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
w_export_progress.hpb_1.stepit( )

Catch (Throwable th)
	//-------Begin Modified by Alfee 01.17.2008-----
	f_word_destroy(lole_word,"")	
	/* lole_word.ActiveDocument.Close(wdDoNotSaveChanges) 
	lole_word.Quit(wdDoNotSaveChanges)
	lole_word.DisconnectObject( )
	destroy lole_word */
	//-------End Modified --------------------------
	this.setredraw(true)
	IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
	RETURN //Alfee 01.17.2008	
End Try

//Quit Word application
//lole_word.ActiveDocument.MailMerge.DataSource.Close() //commented by Alfee 05.28.2007
lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
lole_word.Quit(wdDoNotSaveChanges)
lole_word.DisconnectObject( )
destroy lole_word
w_export_progress.hpb_1.stepit( )

//if isvalid( w_appeon_gifofwait) then close(w_appeon_gifofwait)
this.setredraw(true)
setpointer(HourGlass!)
//Display the merged data
IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)

openwithparm(w_agreement_template_merge_data,is_agreement_path + "tem_1_merged.doc")



end event

event type integer pfc_cst_preview_template();string ls_filename

if tab_1.tabpage_2.ole_1.object.DocType < 1 then return -1

//create temporary file for perview
ls_filename = is_agreement_path + "tem_1.doc"
//if not fileexists(ls_filename) then
	if filecopy(is_current_file,ls_filename,true) <> 1 then
		messagebox("Client Error","Copy file '" + is_current_file + "' to '" + ls_filename + "' failed!")
		return -1		
	end if
//end if

//Copy content of current file
//iole_word = tab_1.tabpage_2.ole_1.object.ActiveDocument
//iole_word.content.copy()

//preview template file
//show add clause window
openwithparm(w_agreement_template_preview,ls_filename)

//--------Begin Commented by Alfee 05.28.2007---------------------
//<$Reason>Moved to the open event of the preview window
//w_agreement_template_painter.enabled = false
//of_menu_security("others")
//--------End Commented ------------------------------------------

return 1

end event

event ue_menu_add();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (pop menu)

This.TriggerEvent( "pfc_addrow" )

//---------------------------- APPEON END ----------------------------

end event

event ue_menu_collapse();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (pop menu)

if il_handle_rightclicked > 0 then
	tab_1.tabpage_1.tv_1.collapseitem( il_handle_rightclicked )
end if

//---------------------------- APPEON END ----------------------------

end event

event ue_menu_delete();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (pop menu)

if il_handle_rightclicked > 0 then
	tab_1.tabpage_1.tv_1.SelectItem( il_handle_rightclicked )
end if
This.TriggerEvent( "pfc_deleterow" )

//---------------------------- APPEON END ----------------------------

end event

event ue_menu_expand();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (pop menu)

if il_handle_rightclicked > 0 then
	tab_1.tabpage_1.tv_1.expandall( il_handle_rightclicked )
end if

//---------------------------- APPEON END ----------------------------

end event

event ue_menu_properties();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (pop menu)

if il_handle_rightclicked > 0 then
	tab_1.tabpage_1.tv_1.SelectItem( il_handle_rightclicked )
end if
This.TriggerEvent( "pfc_cst_properties" )

//---------------------------- APPEON END ----------------------------

end event

event pfc_cst_autonum();////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_autonum of w_agreement_template_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert a number field into the clause file
//////////////////////////////////////////////////////////////////////
// $<add> 04.20.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////

If tab_1.tabpage_2.ole_1.object.DocType <> 1 Then return //no word document opened

//--------Begin Modified by Alfee 05.25.2007---------------
//Open(w_clause_insnum)
////w_clause_insnum.of_set_parent(this)
//w_clause_insnum.of_set_object(tab_1.tabpage_2.ole_1.object.ActiveDocument)
OpenwithParm(w_clause_insnum, 'template')
//--------End Modified ---------------------------------------
end event

event pfc_cst_insert_requirement();//////////////////////////////////////////////////////////////////////
// $<event>w_agreement_template_painter::pfc_cst_insert_requirement()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-06-25 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long ll_export_id,ll_row
string ls_merge_field

ll_row = tab_1.tabpage_1.dw_browse.getrow()
if ll_row < 1 then return

If tab_1.tabpage_2.ole_1.object.DocType <> 1 Then return //no word document opened

str_ole_ctxid lstr_ole_ctxid
lstr_ole_ctxid.sole_word = tab_1.tabpage_2.ole_1
lstr_ole_ctxid.sl_ctx_id = -1//199//-1
Openwithparm(w_agreement_template_insert_requirement,lstr_ole_ctxid)

Return 
end event

event pfc_cst_locate_clause();//====================================================================
// Event: pfc_cst_locate_clause()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-28
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Clause_id,ll_Cycle,ll_BMCnts,ll_Handle
long		ll_Cursor_Pos,ll_BMStartPos,ll_BMEndPos
String	ls_BMName

CONSTANT STRING CLAUSE_MARK = "clause_"

if Tab_1.SelectedTab <> 2 then Return
if Not Tab_1.Tabpage_2.tv_Clause.Visible then Return

if Tab_1.Tabpage_2.ole_1.object.Activedocument.Application.PrintPreview = true then Return

ll_Cursor_Pos = Tab_1.Tabpage_2.ole_1.object.Activedocument.Activewindow.Selection.Start
if il_StartPos <= ll_Cursor_Pos and ll_Cursor_Pos < il_EndPos then Return

Try
	ll_BMCnts = Tab_1.Tabpage_2.ole_1.object.Activedocument.Content.Bookmarks.Count
	for ll_Cycle = 1 to ll_BMCnts
		ls_BMName = Tab_1.Tabpage_2.ole_1.object.Activedocument.Content.Bookmarks.Item[ll_Cycle].name
		if Lower(Left(ls_BMName,Len(CLAUSE_MARK))) <> CLAUSE_MARK Then Continue
		
		ll_BMStartPos = Tab_1.Tabpage_2.ole_1.object.Activedocument.Content.Bookmarks.Item[ll_Cycle].Start
		ll_BMEndPos   = Tab_1.Tabpage_2.ole_1.object.Activedocument.Content.Bookmarks.Item[ll_Cycle].END
		
		if ll_BMStartPos <= ll_Cursor_Pos and ll_Cursor_Pos < ll_BMEndPos then
			il_StartPos = ll_BMStartPos
			il_EndPos   = ll_BMEndPos
			
			ll_Clause_id = long(Mid(ls_BMName,Len(CLAUSE_MARK) + 1))
			
			ll_Handle = Tab_1.Tabpage_2.of_find_clause(0,ll_Clause_id)
			if ll_Handle > 0 then
				Tab_1.Tabpage_2.of_SetAutoLocatDoc(false)
				Tab_1.Tabpage_2.tv_Clause.ExpandItem(ll_Handle)
				Tab_1.Tabpage_2.tv_Clause.SelectItem(ll_Handle)
				//Tab_1.Tabpage_2.tv_Clause.SetFocus( )
				Tab_1.Tabpage_2.of_SetAutoLocatDoc(true)
			end if
			Exit
		end if
	next
Catch(Throwable th)

End Try

end event

event ue_doc_saveas();//====================================================================
// Event: ue_doc_saveas
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/15/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer li_rtn
str_add_doc lstr_add_doc

IF NOT of_issaved() THEN
	li_rtn = MessageBox("Save Document","The document has been modified, save it first?",Question!,YesNoCancel!) 
	IF li_rtn = 1 THEN 
		This.of_savefile()
	ELSEIF li_rtn = 3 THEN
		RETURN
	END IF
END IF		

lstr_add_doc.doc_ext = 'doc'
lstr_add_doc.doc_id = tab_1.tabpage_1.dw_browse.getitemnumber(tab_1.tabpage_1.dw_browse.GetRow(),"ctx_acp_template_id")
//lstr_add_doc.filename = is_agreement_path + "template_" + string(lstr_add_doc.doc_id) + ".doc"
lstr_add_doc.filename =  "template_" + string(lstr_add_doc.doc_id) 
lstr_add_doc.filepathname = is_agreement_path
lstr_add_doc.adt_lastupdate =  tab_1.tabpage_1.dw_browse.getitemdatetime(tab_1.tabpage_1.dw_browse.GetRow(),"modify_date")
openwithparm(w_agreement_template_saveto_document, lstr_add_doc)
	
SetPointer(Arrow!) //for refresh problem on new image ocx 

end event

event ue_doc_email();//====================================================================
// Event: ue_doc_email
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/15/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer li_rtn
String ls_download_file,ls_email_file,ls_ext,ls_file_shortname
Long ll_document_id
str_ctx_email lstr_ctx_email
Datetime			ldt_date

IF NOT of_issaved() THEN
	li_rtn = MessageBox("Save Document","The document has been modified, save it first?",Question!,YesNoCancel!) 
	IF li_rtn = 1 THEN 
		This.of_savefile()
	ELSEIF li_rtn = 3 THEN
		RETURN
	END IF
END IF		

ll_document_id = tab_1.tabpage_1.dw_browse.getitemnumber(tab_1.tabpage_1.dw_browse.GetRow(),"ctx_acp_template_id")
ldt_date = tab_1.tabpage_1.dw_browse.getitemdatetime(tab_1.tabpage_1.dw_browse.GetRow(),"modify_date")

//Get or Generate local template file 
of_get_template_file(ll_document_id,ldt_date)
ls_download_file = is_agreement_path + "template_" + string(ll_document_id) + ".doc"
If Not FileExists(ls_download_file) Then Return

//Email
ls_email_file = gs_dir_path + gs_DefDirName + "\Email\"
gnv_appeondll.of_parsepath(ls_email_file)
ls_email_file +=  "template_" + string(ll_document_id) + ".doc"
If FileCopy(ls_download_file,ls_email_file,True) <> 1 Then
	Messagebox('Email','Failed to generate the document file ' + ls_email_file + '.' )
	Return 
End If

lstr_ctx_email.doc_from = 'DOCUMENT_LIBRARY'
lstr_ctx_email.ctx_id = 0
lstr_ctx_email.doc_id = ll_document_id
lstr_ctx_email.revision = 0
lstr_ctx_email.doc_ext = "doc"
lstr_ctx_email.filename = "template_" + string(ll_document_id) 
lstr_ctx_email.as_batch_file[1]  = ls_email_file 

//Open email window 
OpenWithParm(w_dm_email_document_send, lstr_ctx_email)

SetPointer(Arrow!) //for refresh problem 
end event

public function integer of_displayfile (string as_file);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painter.of_displayfile()
// $<arguments>
//		string	as_file		
// $<returns> integer
// $<description> display the template document
//////////////////////////////////////////////////////////////////////
// $<add> 11.10.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
Long i
setpointer(HourGlass!)

////if the original opened file is dirty, prompt save or not.
//if is_current_file <> "" and tab_1.tabpage_2.ole_1.object.isdirty() then
//	if messagebox("IntelliSoftGroup","The current file opened has been changed,do you want to save it firstly?",Question!,YesNo!) = 1 then
//		if of_savefile() = -1 then return -1
//	end if
//end if	

//close original file
//tab_1.tabpage_2.ole_1.object.close() - commented by Alfee 09.23.2008
is_current_file =""

//--------Begin Modified by Alfee 09.06.2007---------------
//if isnull(as_file) or len(trim(as_file)) < 1  or not fileexists(as_file) then 
if isnull(as_file) or len(trim(as_file)) < 1 then 
//--------End Modified ------------------------------------	
	tab_1.tabpage_2.ole_1.object.close()
	return -1
end if

TRY
	//open new file
	//--------Begin Modified by Alfee 09.06.2007----------------------
	//<$Reason>use word format instead of text
	IF not FileExists(as_file) THEN
		tab_1.tabpage_2.ole_1.object.CreateNew("Word.Document")
		//----------Begin Modified by Alfee 10.31.2007------------------
		//<$Reason>to support Word 2007, save as word 2003 format, it's 
		//<$Reason>necessary that close and re-open the the document
		If FileExists(as_file) Then FileDelete(as_file)
		If gs_ImageView_Version <> '4.0' Then tab_1.tabpage_2.ole_1.object.filesave = True
		tab_1.tabpage_2.ole_1.object.ActiveDocument.SaveAs(as_file, wdFormatDocument,false,'',false) //Word 2003 format
		If gs_ImageView_Version <> '4.0' Then tab_1.tabpage_2.ole_1.object.filesave = False
		gnv_shell.of_delete_recent( as_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	
		//tab_1.tabpage_2.ole_1.object.Close() - commented by Alfee 09.23.2008
		tab_1.tabpage_2.ole_1.object.openLocalFile(as_file, false)				
		//tab_1.tabpage_2.ole_1.object.SavetoLocal(as_file, false)
		//----------End Modified ----------------------------------------	
	ELSE
		tab_1.tabpage_2.ole_1.object.openLocalFile(as_file, false) 
	END IF
	//tab_1.tabpage_2.ole_1.object.openLocalFile(as_file, false) 
	//---------End Modified ----------------------------------------
	ib_ole_ini = True 					//Added By Mark Lee 11/14/2012
	gnv_word_utility.of_modify_word_property( tab_1.tabpage_2.ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
CATCH (runtimeerror rte) //Alfee 09.23.2008
	tab_1.tabpage_2.ole_1.object.Close()
	MessageBox("Open Document","Failed to open document due to: ~r~n" + rte.text)
	RETURN -1
END TRY

is_current_file = as_file

//Added By Mark Lee 07/20/12		add sys_tracking_log record
gnv_tracking.of_tracking_doc(gnv_tracking.template_library_painter,string(il_template_id),'','','','add_doc_tracking',false)
	
tab_1.tabpage_2.ole_1.setfocus()

//iole_word = tab_1.tabpage_2.ole_1.object.GetIDispatch()
if tab_1.tabpage_2.ole_1.object.DocType <> 1  then 
	is_current_file =""
	return -1
end if	
	
//assign iole_word object variable
iole_word = tab_1.tabpage_2.ole_1.object.ActiveDocument

//set zoom percentage
iole_word.ActiveWindow.View.Zoom.Percentage = 100

//--------Added by alfee 04.16.2007-for numbering----
iole_word.ActiveWindow.View.ShowFieldCodes = False
inv_word.of_update_field(iole_word,False)//only update seq fields
//--------End Added ---------------------------------

//-----------------Added By alfee 05.05.2007---------
//Set default color property for hyperlink field
//----------Begin Modified by Alfee on 10.07.2008----------------------
//<$Reason>For performance tuning
IF iole_word.Application.Language = 1033 THEN //us-en
	iole_word.Styles.Item("Hyperlink").Font.Color = wdColorBlack
	iole_word.Styles.Item("FollowedHyperlink").Font.Color = wdColorBlack
END IF
/*
Boolean ib_changed = FALSE //04.22.2008
FOR i =  1 TO iole_word.Styles.Count
	//--------Begin Modified by Alfee on 04.22.2008 ---------------------
	IF iole_word.Styles.Item[i].NameLocal = "FollowedHyperlink" THEN
		iole_word.Styles.Item[i].Font.Color = wdColorBlack
		IF ib_changed THEN EXIT
		ib_changed = TRUE
	END IF
	IF iole_word.Styles.Item[i].NameLocal = "Hyperlink" THEN
		iole_word.Styles.Item[i].Font.Color = wdColorBlack
		IF ib_changed THEN EXIT
		ib_changed = TRUE
	END IF		
	/* IF iole_word.Styles.Item[i].NameLocal = "FollowedHyperlink" THEN
		iole_word.Styles.Item[i].Font.Color = wdColorBlack
		EXIT
	END IF */
	//--------End Modified ----------------------------------------------
NEXT
*/  
//--------End Modified ----------------------------------------------
//------------------End Added------------------------

return 1
end function

public function integer of_menu_security (string as_screen);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painterof_menu_security()
// $<arguments>
//		string	as_screen		
// $<returns> integer
// $<description>Set menu security
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

if not isvalid(m_pfe_cst_agreement_template) then return -1

gnv_app.of_set_ezmenu_refresh_state( TRUE )//added by gavins 20130325
gnv_app.post of_Refresh_EZMenu( )//added by gavins 20130325
choose case lower(as_screen)
	case "browse"
			m_pfe_cst_agreement_template.m_file.m_select.visible = true
//			m_pfe_cst_agreement_template.m_file.m_print.visible = true						//Added By Mark Lee 11/15/2012
			m_pfe_cst_agreement_template.m_file.m_print.visible = False
			
			m_pfe_cst_agreement_template.m_edit.m_insert.visible = true
			m_pfe_cst_agreement_template.m_edit.m_delete1.visible = true
			m_pfe_cst_agreement_template.m_file.m_properties.visible = true
			m_pfe_cst_agreement_template.m_edit.m_copy.visible	= true	
			m_pfe_cst_agreement_template.m_file.m_save.visible	= true	
			m_pfe_cst_agreement_template.m_file.m_close.visible = true		
			m_pfe_cst_agreement_template.m_file.m_addclause.visible = false
			m_pfe_cst_agreement_template.m_file.m_mailmerge.visible = false			
			m_pfe_cst_agreement_template.m_file.m_autonum.visible = false //
			m_pfe_cst_agreement_template.m_file.m_maponoff.visible = false
			m_pfe_cst_agreement_template.m_file.m_userrights.visible	= false
			m_pfe_cst_agreement_template.m_file.m_previewtemplate.visible	= false
						
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_select,'enabled', true)
//			m_pfe_cst_agreement_template.m_file.m_print.enabled = true					//Added By Mark Lee 11/15/2012	
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_print,'enabled', False)
			
			m_pfe_cst_agreement_template.m_edit.m_insert.enabled	 = true
			m_pfe_cst_agreement_template.m_edit.m_delete1.enabled	 = true
			m_pfe_cst_agreement_template.m_file.m_properties.enabled	 = true
			m_pfe_cst_agreement_template.m_edit.m_copy.enabled	 = true	
			m_pfe_cst_agreement_template.m_file.m_save.enabled	 = true	
			m_pfe_cst_agreement_template.m_file.m_close.enabled	 = true		
			m_pfe_cst_agreement_template.m_file.m_addclause.enabled	 = true
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge,'enabled', true)		
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_autonum,'enabled', true)	//	
			m_pfe_cst_agreement_template.m_file.m_maponoff.enabled	 = true
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertfield,'enabled', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_mergedata,'enabled', false)							
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertreqmnt,'enabled', false)		 //Added By Ken.Guo 2009-06-25.								
			
			m_pfe_cst_agreement_template.m_file.m_userrights.enabled	 = true
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_previewtemplate,'enabled', false)
			
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_select,'toolbaritemvisible', true)
//			m_pfe_cst_agreement_template.m_file.m_print.toolbaritemvisible = true					//Added By Mark Lee 11/14/2012
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_print,'toolbaritemvisible', False)
			
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_edit.m_insert,'toolbaritemvisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_edit.m_delete1,'toolbaritemvisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_properties,'toolbaritemvisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_edit.m_copy,'toolbaritemvisible', true)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_save,'toolbaritemvisible', true)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_close,'toolbaritemvisible', true)		
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_addclause,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertfield,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_mergedata,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertreqmnt,'toolbaritemvisible', false)		//Added By Ken.Guo 2009-06-25.								
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_autonum,'toolbaritemvisible', false) 
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_maponoff,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_userrights,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_previewtemplate,'toolbaritemvisible', false)

	case "detail"
			m_pfe_cst_agreement_template.m_file.m_select.visible = false
			m_pfe_cst_agreement_template.m_file.m_print.visible = false											//need it		
			m_pfe_cst_agreement_template.m_edit.m_insert.visible	 = true
			m_pfe_cst_agreement_template.m_edit.m_delete1.visible	 = true
			m_pfe_cst_agreement_template.m_file.m_properties.visible	 = true
			m_pfe_cst_agreement_template.m_edit.m_copy.visible	 = true	
			m_pfe_cst_agreement_template.m_file.m_save.visible	 = true	
			m_pfe_cst_agreement_template.m_file.m_close.visible	 = true		
			m_pfe_cst_agreement_template.m_file.m_addclause.visible	 = true
			m_pfe_cst_agreement_template.m_file.m_mailmerge.visible	 = true
			m_pfe_cst_agreement_template.m_file.m_autonum.visible	 = true
			m_pfe_cst_agreement_template.m_file.m_maponoff.visible	 = true
			m_pfe_cst_agreement_template.m_file.m_userrights.visible	 = true
			m_pfe_cst_agreement_template.m_file.m_previewtemplate.visible = true			
			
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_select,'enabled', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_print,'enabled', true)		
			m_pfe_cst_agreement_template.m_edit.m_insert.enabled	 = true
			m_pfe_cst_agreement_template.m_edit.m_delete1.enabled	 = true
			m_pfe_cst_agreement_template.m_file.m_properties.enabled	 = true
			m_pfe_cst_agreement_template.m_edit.m_copy.enabled	 = true	
			m_pfe_cst_agreement_template.m_file.m_save.enabled	 = true	
			m_pfe_cst_agreement_template.m_file.m_close.enabled	 = true		
			m_pfe_cst_agreement_template.m_file.m_addclause.enabled	 = true
			m_pfe_cst_agreement_template.m_file.m_mailmerge.enabled	 = true
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertfield,'enabled', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_mergedata,'enabled', true)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertreqmnt,'enabled', true)										
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_autonum,'enabled', true)	
			m_pfe_cst_agreement_template.m_file.m_maponoff.enabled	 = true
			m_pfe_cst_agreement_template.m_file.m_userrights.enabled	 = true
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_previewtemplate,'enabled', true)
			
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_select,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_print,'toolbaritemvisible', false)			
			m_pfe_cst_agreement_template.m_edit.m_insert.toolbaritemvisible	 = true
			m_pfe_cst_agreement_template.m_edit.m_delete1.toolbaritemvisible	 = true
			m_pfe_cst_agreement_template.m_file.m_properties.toolbaritemvisible	 = true
			m_pfe_cst_agreement_template.m_edit.m_copy.toolbaritemvisible	 = true	
			m_pfe_cst_agreement_template.m_file.m_save.toolbaritemvisible	 = true	
			m_pfe_cst_agreement_template.m_file.m_close.toolbaritemvisible	 = true		
			m_pfe_cst_agreement_template.m_file.m_addclause.toolbaritemvisible	 = true
			m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertfield.toolbaritemvisible	 = true
			m_pfe_cst_agreement_template.m_file.m_mailmerge.m_mergedata.toolbaritemvisible	 = true	
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertreqmnt,'toolbaritemvisible', true)													
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_autonum,'toolbaritemvisible', true) //			
			m_pfe_cst_agreement_template.m_file.m_maponoff.toolbaritemvisible	 = true
			m_pfe_cst_agreement_template.m_file.m_userrights.toolbaritemvisible	 = true
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_previewtemplate,'toolbaritemvisible', true)
			
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_maponoff,'toolbaritemdown', ib_map)
		
	case "others"
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_select,'enabled', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_print,'enabled', false)		
			m_pfe_cst_agreement_template.m_edit.m_insert.enabled	 = false
			m_pfe_cst_agreement_template.m_edit.m_delete1.enabled	 = false
			m_pfe_cst_agreement_template.m_file.m_properties.enabled	 = false
			m_pfe_cst_agreement_template.m_edit.m_copy.enabled	 = false	
			m_pfe_cst_agreement_template.m_file.m_save.enabled	 = false	
			m_pfe_cst_agreement_template.m_file.m_close.enabled	 = false		
			m_pfe_cst_agreement_template.m_file.m_addclause.enabled	 = false
			m_pfe_cst_agreement_template.m_file.m_mailmerge.enabled	 = false
			m_pfe_cst_agreement_template.m_file.m_autonum.enabled	 = false 
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertfield,'enabled', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_mergedata,'enabled', false)		
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertreqmnt,'enabled', false)													
			m_pfe_cst_agreement_template.m_file.m_maponoff.enabled	 = false
			m_pfe_cst_agreement_template.m_file.m_userrights.enabled	 = false
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_previewtemplate,'enabled', false)
end choose
		
//Added by Alfee 09.20.2007 for new requirement
IF w_mdi.of_security_access(6801) < 2 THEN

			m_pfe_cst_agreement_template.m_edit.m_insert.enabled	 = false
			m_pfe_cst_agreement_template.m_edit.m_delete1.enabled	 = false

			m_pfe_cst_agreement_template.m_edit.m_copy.enabled	 = false	
			m_pfe_cst_agreement_template.m_file.m_save.enabled	 = false	

			m_pfe_cst_agreement_template.m_file.m_addclause.enabled	 = false
			m_pfe_cst_agreement_template.m_file.m_mailmerge.enabled	 = false
			m_pfe_cst_agreement_template.m_file.m_autonum.enabled	 = false 
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertfield,'enabled', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_mergedata,'enabled', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_mailmerge.m_insertreqmnt,'enabled', false)													
			m_pfe_cst_agreement_template.m_file.m_maponoff.enabled	 = false
			m_pfe_cst_agreement_template.m_file.m_userrights.enabled	 = false

END IF	

//---------Begin Modified by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
//Hide user rights menu item and toolbar if prohibited to access - Alfee 04.14.2008
//if m_pfe_cst_agreement_template.m_system.m_painters.m_rolepainter.visible = false then
if m_pfe_cst_agreement_template.m_system.m_painters.m_security.m_rolepainter.visible = false then
//---------End Modfiied ------------------------------------------------------
	gnv_app.of_modify_menu_attr( m_pfe_cst_agreement_template.m_file.m_userrights,'toolbaritemvisible', false)
	m_pfe_cst_agreement_template.m_file.m_userrights.visible	 = false	
end if

		
return 1
end function

public function boolean of_fileopened (string as_file);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painterof_fileopened()
// $<arguments>
//		string	as_file		
// $<returns> boolean
// $<description>Check whether the file is opened
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

if lower(is_current_file) = lower(as_file) then //file already opened
	return true
end if

return false

end function

public function integer of_fileclear (long al_templateid);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painterof_fileclear()
// $<arguments>
//		long	al_templateid		
// $<returns> integer
// $<description>delete template file and clear the registry
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
string ls_filename

if isnull(al_templateid) then return -1

ls_filename="template_"+ string(al_templateid) + ".doc"

//Close the file if it's opened.
if of_fileopened(ls_filename) then 
	tab_1.tabpage_2.ole_1.object.close()
end if

//delete the local template fila
if fileexists(is_agreement_path + ls_filename) then
	filedelete(is_agreement_path + ls_filename)
end if
//Modified By Mark Lee 04/18/12
//Clear registry of this file
//gnv_appeondll.of_registrydelete("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "template_" + string(al_templateid))
gnv_appeondll.of_registrydelete("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", "template_" + string(al_templateid))

return 1
end function

public function integer of_filter_clause (long al_template_id);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painterof_filter_clause()
// $<arguments>
//		long	al_template_id		
// $<returns> integer
// $<description>filter clauses according to template iid
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

string ls_filter

if tab_1.selectedtab <> 2 then return -1

if isnull(al_template_id) then 
	ls_filter = "1=2"
else
	ls_filter ="ctx_acp_template_id = "+string(al_template_id)
end if
tab_1.tabpage_2.dw_clause.setfilter(ls_filter)

//filter clauses
ib_locate = false
tab_1.tabpage_2.dw_clause.filter()
ib_locate = true

//locate in template file
this.event pfc_cst_locate_file()

return 1
end function

public function integer of_refresh_clause ();//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painterof_refresh_clause()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>refresh clause list,usually after add clause operation
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
integer li_rtn

//don't locate in template file for each clause 
ib_locate = false

setpointer(HourGlass!)

//retrieve and filter clauses
tab_1.tabpage_2.dw_clause.setredraw(false)
tab_1.tabpage_2.dw_clause.retrieve()
li_rtn = of_filter_clause(il_template_id)
Tab_1.Tabpage_2.of_RefreshTreeView()		//Added by Scofield on 2010-02-02
Tab_1.Tabpage_2.of_RefreshClauseRules()	//Added by Scofield on 2010-02-02
tab_1.tabpage_2.dw_clause.setredraw(true)

//locate current clause in template file
ib_locate = true
this.event pfc_cst_locate_file()

return li_rtn


end function

public function integer of_savefile ();//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painterof_savefile()
// $<arguments>(None)
// $<returns> integer
// $<description>Save the specified template file
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
integer li_begin, li_end,i,j,li_rtn
long ll_template_id,ll_clause_id, ll_row 
datetime ldt_lastupdate
any la_rtn
//string ls_bookmark[]
String ls_bookmark //by alfee 05.29.2007
boolean lb_found
Boolean lb_clause_deleted = FALSE //Alfee 11.12.2007

//check whether a file is opened and dirty
if is_current_file ="" or tab_1.tabpage_2.ole_1.object.doctype <> 1 then return 1
//if not isvalid(iole_word) or isnull(iole_word) then 
//	iole_word = tab_1.tabpage_2.ole_1.object.ActiveDocument
//end if

//Unprotect the document if necessary - Alfee 03.10.2008
inv_word.of_unprotect_doc(iole_word) 

//save the word file
//la_rtn = tab_1.tabpage_2.ole_1.object.save(is_current_file)
la_rtn = tab_1.tabpage_2.ole_1.object.saveToLocal(is_current_file , true)
if not iole_word.saved then 
	//messagebox("IntelliSoftGroup","The current file save failed!")
	messagebox("Save File Error","Failed to save the current file!")
	return -1
end if

//parse the file name and get the template id
li_begin = pos(lower(is_current_file),"template_",1) + 9
li_end = pos(lower(is_current_file),".doc",1) 
ll_template_id = long(mid(is_current_file,li_begin,li_end - li_begin))
ldt_lastupdate = datetime(today(),now())

//update dw_clause according to bookmarks
if tab_1.tabpage_2.ole_1.object.doctype = 1 then
//--------Begin Modified by Alfee 05.29.2007--------------		
	for i =  1 to tab_1.tabpage_2.dw_clause.rowcount()
		ll_clause_id = tab_1.tabpage_2.dw_clause.object.ctx_acp_clause_id[i]
		ls_bookmark = "clause_" + string(ll_clause_id) 
		if not iole_word.bookmarks.Exists(ls_bookmark) then
			tab_1.tabpage_2.dw_clause.deleterow(i)
			i --
			lb_clause_deleted = TRUE //Added by Alfee 11.12.2007
		end if			
	next	
//	for i = 1 to iole_word.bookmarks.count
//		ls_bookmark[i] = iole_word.bookmarks.item(i).name
//	next
//	
//	//delete mapped clause(s) according to bookmarks
//	for i =  1 to tab_1.tabpage_2.dw_clause.rowcount()
//		ll_clause_id = tab_1.tabpage_2.dw_clause.object.ctx_acp_clause_id[i]
//		lb_found = false
//		for j =  1 to upperbound(ls_bookmark)
//			if ls_bookmark[j] = "clause_" + string(ll_clause_id) then 
//				lb_found = true
//				exit				
//			end if	
//		next
//		if not lb_found then 
//			tab_1.tabpage_2.dw_clause.deleterow(i)
//			i = i -1
//		end if
//	next
//--------End Modified ---------------------------------------
end if

//update db and registry it		
if of_put_template_file(ll_template_id,ldt_lastupdate) <> 1 then 
	//messagebox("IntelliSoftGroup","The current file save failed!")
	messagebox("Save File Error","Failed to save the current file!")
	return -1
end if
//Set modify date accordingly - alfee 10.07.2008
ll_row = tab_1.tabpage_1.dw_browse.GetRow()
IF ll_row > 0 THEN tab_1.tabpage_1.dw_browse.SetItem(ll_row, "modify_date", ldt_lastupdate)

inv_word.of_update_reqmnt_field(tab_1.tabpage_2.ole_1.object, ll_template_id,'T') //Added By Ken.Guo 2009-06-30.

//-------Begin Modified by Alfee 11.12.2007---------
//<$Reason>Synchronize the dynamic add clause rules' data
IF lb_clause_deleted THEN
	gnv_appeondb.of_startqueue()
	tab_1.tabpage_2.dw_clause.update()
	f_sync_addclause_rules(ll_template_id )
	gnv_appeondb.of_commitqueue()
END IF
IF SQLCA.SQLCode = 0 THEN 
	li_rtn = 1 
ELSE
	li_rtn = -1 
END IF
//li_rtn = tab_1.tabpage_2.dw_clause.update()
//-------End Modified ------------------------------

return li_rtn
end function

public function integer of_put_template_file (long al_templateid, datetime adt_lastupdate);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painter.of_put_template_file()
// $<arguments>
//		value	long    	al_templateid 		
//		value	datetime	adt_lastupdate		
// $<returns> integer
// $<description>Put local template file into DB
//////////////////////////////////////////////////////////////////////
// $<add> 11.14.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

string ls_lastupdate,ls_filename
long ll_len
integer li_writes,li_filenum,li_cnt,li_rtn
blob lblb_file,lblb_data

ls_filename = is_agreement_path + "template_" + string(al_templateid) + ".doc"
ls_lastupdate = string(adt_lastupdate, "mm/dd/yyyy hh:mm:ss")

if not fileexists(ls_filename) then return -1

// Determine how many times to call FileRead
ll_len = filelength(ls_filename)
if ll_len > 32765 then
	 if mod(ll_len, 32765) = 0 then
		 li_writes = ll_len / 32765
	 else
		 li_writes = (ll_len / 32765) + 1
	 end If
else
	 li_writes = 1
end if

//tab_1.tabpage_2.ole_1.object.close()

li_filenum = fileopen(ls_filename , StreamMode!, Read!, Shared!)
if li_filenum = -1 then return -1

//Read template file into blob variable
for li_cnt = 1 to li_writes
	 if fileread(li_filenum, lblb_data) = -1 then 
		fileclose(li_filenum)	
		return -1
 	 end if
	 lblb_file = lblb_file + lblb_data
next

fileclose(li_filenum)

//Update blob data of template file into DB
//gnv_appeondb.of_startqueue() //for web performance

//----Begin Added by alfee 07.23.2007-----------------
//<$Reason>Update a blob will be failed while its lengh is 0 
if IsNull(ll_len) or ll_len = 0 then return -1 
//----End Added --------------------------------------

updateblob ctx_acp_template set image_file = :lblb_file 
	  where ctx_acp_template_id = :al_templateid ;
	  
update ctx_acp_template set modify_date = :adt_lastupdate	
 where ctx_acp_template_id = :al_templateid ;
 
//gnv_appeondb.of_commitqueue()

if sqlca.sqlcode = 0 then
	//Added By Mark Lee 04/18/12
	//registet new key value of the template file
//	gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "template_" + string(al_templateid), regstring!, ls_lastupdate)	
	gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", "template_" + string(al_templateid), regstring!, ls_lastupdate)	
	ib_needsave = false
end if
//tab_1.tabpage_2.ole_1.object.openlocalfile(ls_filename, false) 
return 1
end function

public subroutine of_select ();//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painterof_select()
// $<arguments>(None)
// $<returns> (none)
// $<description>Handling after selecting a template and run select
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_row, ll_rtn, ll_template_id,ll_len,ll_currentpos
Integer li_writes,li_filenum,li_cnt
string ls_filename,ls_lastupdate,ls_regupdate
datetime ldt_modify_date
blob lblb_data,lblb_file
boolean lb_local = false //indicate whether local file existed and updated

ll_row = tab_1.tabpage_1.dw_browse.getrow()
if ll_row < 1 then 
	of_filter_clause(ll_template_id)
	of_displayfile(ls_filename)
	return
end if


ll_template_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_row,"ctx_acp_template_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.25.2007 By: Jervis
//$<reason> 
this.il_template_id = ll_template_id
//---------------------------- APPEON END ----------------------------

ldt_modify_date = tab_1.tabpage_1.dw_browse.getitemdatetime(ll_row,"modify_date")

//filter dw_clause in the tagpage of template detail
of_filter_clause(ll_template_id)

//Check whether this file is already opened in detail tabpage
ls_filename = is_agreement_path + "template_" + string(ll_template_id) + ".doc"
if of_fileopened(ls_filename) then return

openwithparm( w_appeon_gifofwait, "Opening selected document..." )

//Get or Generate local template file 
of_get_template_file(ll_template_id,ldt_modify_date)

//Open the file in the tabpage of template detail
of_displayfile(ls_filename)

if isvalid( w_appeon_gifofwait) then close(w_appeon_gifofwait)

end subroutine

public function integer of_set_menu (boolean ab_flag);if ab_flag then
//	m_pfe_cst_agreement_template
else
	
end if

return 1
end function

public function integer of_preview_files (long al_clauseid[]);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painter.of_preview_files()
// $<arguments>
//		value	long	al_clauseid[]		
// $<returns> integer
// $<description>
// $<description>Preview the merged template file
//////////////////////////////////////////////////////////////////////
// $<add> 12.20.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

if tab_1.tabpage_2.ole_1.object.DocType < 1 then return -1
//iole_word = tab_1.tabpage_2.ole_1.object.ActiveDocument

setpointer(HourGlass!)

//Copy to a temporary file
if FileCopy(is_current_file,is_agreement_path + "tem_1.doc",true) <> 1 then
	messagebox("Client Error","Copy " + is_current_file + " to " + is_agreement_path + "tem_1.doc failed!")
	this.setredraw(true)	
	return -1
end if

iole_word.content.copy()

Open(w_agreement_template_preview)

return 1

end function

public function integer of_get_template_file (long al_templateid, datetime adt_lastupdate);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painterof_get_template_file()
// $<arguments>
//		long    	al_templateid 		
//		datetime	adt_lastupdate		
// $<returns> integer
// $<description>Get or Generate template file from DB
//////////////////////////////////////////////////////////////////////
// $<add> 11.14.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

string ls_lastupdate,ls_regupdate,ls_filename
long ll_len,ll_currentpos,ll_length,ll_start
integer li_writes,li_filenum,li_cnt,li_loops
boolean lb_local //indicate whether local file is existed and updated
blob lblb_file,lblb_data

lb_local = false
ls_filename = is_agreement_path + "template_" + string(al_templateid) + ".doc"
if not isnull(adt_lastupdate) then
	ls_lastupdate = string(adt_lastupdate, "mm/dd/yyyy hh:mm:ss")
end if

//Compare the updated date between local files and from db
if fileexists(ls_filename) then
	//Modified By Mark Lee 04/18/12
//	gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "template_" + string(al_templateid), regstring!, ls_regupdate)	
	gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", "template_" + string(al_templateid), regstring!, ls_regupdate)	
	if ls_lastupdate = ls_regupdate and len(trim(ls_lastupdate)) > 0  then
		lb_local = true
	end if
end if

//If local file not existed or updated, generate new local file and update registry
if not lb_local then 
	if gs_dbtype = "SQL" and appeongetclienttype() = "PB" THEN //SQL
		SELECT datalength(image_file) INTO :ll_length FROM ctx_acp_template
		 WHERE ctx_acp_template_id = :al_templateid; 
		if ll_length > 8000  then
			li_loops = ( ll_length / 8000 ) + 1
			For li_cnt = 1 To li_loops				
				ll_start = (li_cnt - 1) * 8000 + 1			
				SELECTBLOB substring( image_file, :ll_start, 8000 ) INTO :lblb_data 
						FROM ctx_acp_template 
					  WHERE ctx_acp_template_id = :al_templateid; 			
				IF SQLCA.SQLCode <> 0 THEN
					//Messagebox( "IntelliSoft", "Read file data from database failed." )
   				Messagebox( "Read File Error", "Failed to read file data from database." )
					Return -1
				END IF
				lblb_file += lblb_data
			Next 
		else
			selectblob image_file into :lblb_file
					from ctx_acp_template
				  where ctx_acp_template_id = :al_templateid;
		end if
	else //ASA
		selectblob image_file into :lblb_file
			from ctx_acp_template
		  where ctx_acp_template_id = :al_templateid;
	end if
	
	ll_len = len(lblb_file)
//	if ll_len < 1 then return -1
	
	If ll_len > 32765 then
		 if mod(ll_len, 32765) = 0 then
			 li_writes = ll_len / 32765
		 else
			 li_writes = (ll_len / 32765) + 1
		 end If
	 else
		 li_writes = 1
	end if
	
	ll_currentpos = 1
	
	IF ll_len > 0  THEN	//use a word format instead of text - add if statement by alfee 09.06.2007	
		li_filenum = fileopen(ls_filename , StreamMode!, Write!, LockWrite!,Replace!)
		if li_fileNum = -1 then return -1
	
		for li_cnt = 1 to li_writes
			 lblb_data = blobmid(lblb_file, ll_currentpos, 32765)
			 ll_currentpos += 32765
			 if filewrite(li_filenum, lblb_data) = -1 then
				 fileclose(li_fileNum)
				 return -1
			 end If
		next
	
		fileclose(li_fileNum)
	//Modified By Mark Lee 04/18/12
		//Save the latest update date of the current file in Registry
//		gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "template_" + string(al_templateid), regstring!, ls_lastupdate)	
		gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement", "template_" + string(al_templateid), regstring!, ls_lastupdate)	
	END IF		
end if

return 1
end function

public function integer of_merge_files (long al_clauseid[]);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painter.of_merge_files()
// $<arguments>
//		value	long	al_clauseid[]		
// $<returns> integer
// $<description>
// $<description>merge word files
//////////////////////////////////////////////////////////////////////
// $<add> 12.14.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
// $<modify> 05.30.2007 by Alfee(copied and modified from of_merge_files_0528)
//////////////////////////////////////////////////////////////////////

integer i, j, k, li_rtn
long ll_cnt, ll_len_ori,ll_len_new,ll_start_ori,ll_end_ori, ll_Find
long ll_pagebreak[], ll_bmcnt, ll_clauseid //11.29.2007
string ls_filename,ls_bookmark, ls_bktmp
string ls_bm[], ls_tmp[]
long ll_New_Clause[]
Boolean lb_modified = False 
Long  ll_AppendParaGraph[] //Added By Ken.Guo 2010-10-22.
n_cst_string_appeon lnv_string_appeon //Added By Ken.Guo 2011-05-05.
OleObject			lole_BookMark, lole_Selection //added by gavins 20120730
DataStore			lds_Clause



if tab_1.tabpage_2.ole_1.object.doctype <> 1 then return -1

//Unprotect document if needed - Alfee 03.10.2008
//inv_word.of_unprotect_doc(iole_word) 
IF inv_word.of_unprotect_doc(iole_word) = -1 THEN RETURN -1 //Alfee 10.08.2008

//Added By Ken.Guo 2011-05-05.
if isvalid(w_appeon_gifofwait) then 
	w_appeon_gifofwait.event timer()	
	w_appeon_gifofwait.of_settext('Prepare merge the clause...') 
End If

lds_Clause = Create DataStore
lds_Clause.DataObject = 'd_clauses_all'
lds_Clause.SetTransObject( SQLCA )

lole_bookmark = iole_word.content.bookmarks
lole_Selection = iole_word.activewindow.selection

//Set bookmarks'default sort order
iole_word.bookmarks.DefaultSorting = wdSortByLocation

//Get clauses' pagebreak flags accordingly
ll_cnt = upperbound(al_clauseid)
of_get_pagebreak(al_clauseid, ll_pagebreak[],ll_AppendParaGraph[]) 

setpointer(HourGlass!)
this.setredraw(false)

//clear clause(s) and return if no selected caluses 
if ll_cnt < 1 then 
	for i = 1 to iole_word.bookmarks.count 
		ls_bookmark = lole_bookmark.item[i].name
		if lower(left(ls_bookmark,7)) <> "clause_" then continue 	
		lole_bookmark.item[i].select()
		lole_Selection.delete()
		If lole_bookmark.Exists(ls_bookmark) Then
			lole_bookmark.Item(ls_bookmark).delete()
		End If
		i --	
		lb_modified = True //08.29.2007
	next
	//--------Begin Added by Alfee 08.29.2007---------------------------------
	If lb_modified Then
		//save new template file
		tab_1.tabpage_2.ole_1.object.saveToLocal(is_current_file , true)
		//update template file into DB with modify date and registry modify date
		li_rtn = of_put_template_file(il_template_id,datetime(today(),now()))
	End If
	//---------End Added ------------------------------------------------------
	this.setredraw(true)
	return 1
end if

//Clear invalid bookmark(s) and initilize clauses' bookmark array
for i = 1 to lole_bookmark.count 
	ls_bookmark = lole_bookmark.item[i].name
	if lower(left(ls_bookmark,7)) = "clause_" then
		//--------Begin Modified by Alfee 11.29.2007 - for performance ---
		If Not IsNumber(Mid(ls_bookmark, 8)) Then Continue
		//Find whether the clause is still valid
		ll_clauseid = Long(Mid(ls_bookmark, 8))
		For j = 1 to ll_cnt
			If al_clauseid[j] = ll_clauseid Then Exit
		Next
		//Clear the invalid clause and bookmark
		If j > ll_cnt Then 
			lole_bookmark.item[i].select()
			lole_Selection.delete()
			If lole_bookmark.Exists(ls_bookmark) Then
				lole_bookmark.Item(ls_bookmark).delete()
			End If
			i --
			Continue		
		End If
		//Clear the bookmark if a empty clause - for a bug
		if lole_bookmark.item[i].Start >= lole_bookmark.item[i].End then	
			lole_bookmark.item[i].delete()
			i --	
			Continue
		end if		
		//initilize clauses' bookmark array
		ls_bm[UpperBound(ls_bm) + 1] = ls_bookmark	
		//--------End Modified ----------------------------------------		
	end if
next
ll_bmcnt = UpperBound(ls_bm)
String ls_org_text,ls_clausename
if isvalid(w_appeon_gifofwait) then 
	ls_org_text = w_appeon_gifofwait.st_1.text
	w_appeon_gifofwait.event timer()
End If

lds_Clause.Retrieve( )//added by gavins 20120730

//merge clause file(s)
for i = 1 to ll_cnt
	iole_word.undoclear() //Added By Ken.Guo 2011-05-03. Because Word maybe popup a tip message about undo.
	ls_bookmark = "clause_" +string(al_clauseid[i])
//	ls_filename = lower(is_agreement_path + ls_bookmark + ".doc") //a Web bug, the insertfile function is case sensitive 
	ll_Find = lds_Clause.Find( "ctx_acp_clause_id = " + String( al_clauseid[i] ) , 1, lds_Clause.RowCount( ) )
	If ll_Find > 0 Then
		ls_filename = inv_clause.of_generate_name(al_clauseid[i], lds_Clause.object.revision[ll_Find] )//modified by gavins 20120730
	Else
		ls_filename = inv_clause.of_generate_name(al_clauseid[i]) //Modified By Ken.Guo 2010-01-18
	End If
	
	
	//Added By Ken.Guo 2011-05-03.
	if isvalid(w_appeon_gifofwait) then 
		w_appeon_gifofwait.event timer()	
		ls_clausename = gnv_data.of_getitem( 'clause', 'clause_name', 'ctx_acp_clause_id = ' + String(al_clauseid[i])) 
		w_appeon_gifofwait.of_settext(String(i) + '/' + String(ll_cnt) + '  Merging the clause "' + ls_clausename + '" to template...') 
	End If
	
	//if existed, adjust order of the clause 
	if iole_word.bookmarks.exists(ls_bookmark) then 
		if lole_bookmark.item(ls_bm[i]).name <> ls_bookmark then
			ll_start_ori = lole_bookmark.item(ls_bm[i]).start
			ll_len_ori = lole_bookmark.item(ls_bm[i]).end - ll_start_ori
			ll_len_new = lole_bookmark.item(ls_bookmark).end - lole_bookmark.item(ls_bookmark).start
			//cut and paste file
			iole_word.bookmarks.item(ls_bookmark).select()
			lole_Selection.cut()
			lole_bookmark.item(ls_bm[i]).select()
			lole_Selection.collapse(wdCollapseStart)
			//--------Begin Modified by Alfee 12.06.2007-----------------------------
			//<$Reason>for the case of pasting content before an existed table
			IF lole_Selection.tables.count > 0 THEN 
				lole_Selection.InsertBreak(wdSectionBreakContinuous)	
				lole_Selection.Start = ll_start_ori
				lole_Selection.End = lole_bookmark.item(ls_bm[i]).End
				lole_Selection.collapse(wdCollapseStart)			
			END IF			
			//--------End Modified --------------------------------------------------			
			lole_Selection.paste()
			lole_Selection.expand()			
			//restore bookmarks
			iole_word.bookmarks.add(ls_bookmark,iole_word.range(ll_start_ori, ll_start_ori + ll_len_new))		
			For j = 1 to iole_word.Range(ll_start_ori, ll_start_ori).Bookmarks.Count
				ls_bktmp = iole_word.Range(ll_start_ori, ll_start_ori).Bookmarks.Item[j].Name
				//-------------Begin Modified by Alfee 12.06.2007-----------------------
				//If iole_word.Range(ll_start_ori, ll_start_ori).Bookmarks.Item(ls_bktmp).End > ll_start_ori + ll_len_new Then	
				//	iole_word.Range(ll_start_ori, ll_start_ori).Bookmarks.Item(ls_bktmp).Start = ll_start_ori + ll_len_new
				If iole_word.Bookmarks.Item(ls_bktmp).End > ll_start_ori + ll_len_new Then	
					iole_word.Bookmarks.Item(ls_bktmp).Start = ll_start_ori + ll_len_new					
				//-------------End Modified --------------------------------------------					
				j --
				End If
			Next
			lnv_string_appeon.of_insert_to_array(ls_bm[],i,ls_bookmark,true)
		else 
			continue
		end if
	//if not existed and as a last clause, append the clause to end of the file
	elseif i > ll_bmcnt then
   	if not fileexists(ls_filename) then return -1	
		
		//New Clause - jervis 1.4.2010
		ll_New_Clause[UpperBound(ll_New_Clause) + 1] = al_clauseid[i] 
		
  	   //append file
		if ll_bmcnt = 0 then 
			//-----Begin Modified by Alfee 10.07.2008 -----
			//ll_start_ori = 0
			iole_word.content.InsertParagraphAfter() 
			ll_start_ori = iole_word.content.end - 1 // Jervis 06.08.2009
			//-----End Modified ---------------------------
			iole_word.content.select()
		else
			ll_start_ori = lole_bookmark.item(ls_bm[i - 1]).end
			lole_bookmark.item(ls_bm[i - 1]).select()
		end if
		ll_end_ori = iole_word.content.end 
	   lole_Selection.collapse(wdCollapseEnd)
		if ll_pagebreak[i]= 1 THEN 
			lole_Selection.insertbreak(wdSectionBreakNextPage) //added by alfee 05.28.2007
		End If
		If ll_AppendParaGraph[i] = 1 Then 
			lole_Selection.TypeParagraph()
//			lole_Selection.InsertParagraphBefore() 
//			lole_Selection.TypeText(' ')
//			lole_Selection.InsertParagraphAfter()
		End If
   	lole_Selection.insertfile(ls_filename)
		gnv_shell.of_delete_recent( ls_filename, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
   	lole_Selection.expand()
	   //add bookmark	  
		ll_len_new = iole_word.content.end - ll_end_ori
		iole_word.bookmarks.add(ls_bookmark,iole_word.range(ll_start_ori, ll_start_ori + ll_len_new))
		
		lnv_string_appeon.of_insert_to_array(ls_bm[],Upperbound(ls_bm[]) + 1,ls_bookmark,true)
		
	//if not existed and as a middle clause, insert the clause to the file
	else
   	if not fileexists(ls_filename) then return -1	
		
		//New Clause - jervis 1.4.2010
		ll_New_Clause[UpperBound(ll_New_Clause) + 1] = al_clauseid[i] 
		
		ll_start_ori = lole_bookmark.item(ls_bm[i]).start
		ll_end_ori = iole_word.content.end 
		//insert file
		lole_bookmark.item(ls_bm[i]).select()
		lole_Selection.collapse(wdCollapseStart)
		//--------Begin Modified by Alfee 12.06.2007-----------------------------
		//<$Reason>for the case of inserting content before an existed table
		IF lole_Selection.tables.count > 0 THEN 
			lole_Selection.InsertBreak(wdSectionBreakContinuous)	
			lole_Selection.Start = ll_start_ori
			lole_Selection.End = lole_bookmark.item(ls_bm[i]).End
			lole_Selection.collapse(wdCollapseStart)			
		END IF			
		//--------End Modified --------------------------------------------------		
		if ll_pagebreak[i]= 1 THEN lole_Selection.insertbreak(wdSectionBreakNextPage) //added by alfee 05.28.2007
		If ll_AppendParaGraph[i] = 1 Then 
			lole_Selection.TypeParagraph()
//			lole_Selection.InsertParagraphAfter()
		End If
		lole_Selection.insertfile(ls_filename)
		gnv_shell.of_delete_recent( ls_filename, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		lole_Selection.expand()
		//add bookmark
		ll_len_new = iole_word.content.end - ll_end_ori
		if ll_len_new < 0 then ll_len_new = 0
		iole_word.bookmarks.add(ls_bookmark,iole_word.range(ll_start_ori, ll_start_ori + ll_len_new ))
     	//restore bookmarks
		For j = 1 to iole_word.Range(ll_start_ori, ll_start_ori).Bookmarks.Count
			ls_bktmp = iole_word.Range(ll_start_ori, ll_start_ori).Bookmarks.Item[j].Name
			//-------------Begin Modified by Alfee 12.06.2007-----------------------
			//If iole_word.Range(ll_start_ori, ll_start_ori).Bookmarks.Item(ls_bktmp).End > ll_start_ori + ll_len_new Then	
			//	iole_word.Range(ll_start_ori, ll_start_ori).Bookmarks.Item(ls_bktmp).Start = ll_start_ori + ll_len_new
			If iole_word.Bookmarks.Item(ls_bktmp).End > ll_start_ori + ll_len_new Then	
				iole_word.Bookmarks.Item(ls_bktmp).Start = ll_start_ori + ll_len_new		
			//-------------End Modified --------------------------------------------									
				j --
			End If
		Next	
		lnv_string_appeon.of_insert_to_array(ls_bm[],i,ls_bookmark,true) //Added By Ken.Guo 2011-05-05.
	end if

	//Commented By Ken.Guo 2011-05-05
	//Reset array of ls_bm[]
	//j = 1
	//ls_bm = ls_tmp 
	//	for k = 1 to lole_bookmark.count 
	//		ls_bookmark = lole_bookmark.item[k].name
	//		if lower(left(ls_bookmark,7)) = "clause_" then 
	//			ls_bm[j] = ls_bookmark
	//			j ++
	//		end if
	//	next
	
	ll_bmcnt = UpperBound(ls_bm)
	if ll_bmcnt = 1 then 
		if IsNull(ls_bm[1]) or ls_bm[1] = '' then ll_bmcnt = 0
	end if
next

//Check Bookmark
if isvalid(w_appeon_gifofwait) then w_appeon_gifofwait.event timer()
string ls_11,ls_22
for k = 1 to lole_bookmark.count 
	ls_bookmark = lole_bookmark.item[k].name
	if lower(left(ls_bookmark,7)) = "clause_" then 
		ls_11 += ',' + ls_bookmark
		j ++
	end if
next
lnv_string_appeon.of_arraytostring( ls_bm, ',', ls_22)	
If ls_11 <> ',' + ls_22 Then
	gnv_debug.of_output( True, 'Added Clauses to template '+String(il_template_id)+', but the clause order is incorrect:') 
	gnv_debug.of_output( True, '	Clause Order ls_bm[]   : ' + ls_22) 
	gnv_debug.of_output( True, '	Clause Order bookmark: ' + ls_11) 
	//Messagebox('Bookmark','Error')
End If


//delete invalid clause(s) in the file
if ll_cnt < 1 then
	iole_word.content.delete()
else
	for i = ll_cnt + 1 to ll_bmcnt
		if lole_bookmark.Exists(ls_bm[i]) then
			lole_bookmark.Item(ls_bm[i]).select()
			lole_Selection.delete()
			if lole_bookmark.Exists(ls_bm[i]) Then
				lole_bookmark.Item(ls_bm[i]).delete()
			end if
		end if
	next	
end if

if isvalid(w_appeon_gifofwait) then w_appeon_gifofwait.event timer()
//Dislay as Word Comment for Clause - jervis 12.30.2009
inv_word.of_Update_WordComment(iole_word,al_clauseid)

if isvalid(w_appeon_gifofwait) then w_appeon_gifofwait.event timer()
//Set the Clause Text Color base on Clause Status
inv_word.of_Update_ClauseColor(iole_word,ll_New_Clause)

//update numbering fields
inv_word.of_update_field(iole_word, False) 
if isvalid(w_appeon_gifofwait) then w_appeon_gifofwait.event timer()

//save new template file
tab_1.tabpage_2.ole_1.object.saveToLocal(is_current_file , true)

//update template file into DB with modify date and registry modify date
li_rtn = of_put_template_file(il_template_id,datetime(today(),now()))
if isvalid(w_appeon_gifofwait) then w_appeon_gifofwait.event timer()

this.setredraw(true)

If IsValid( lds_Clause ) Then Destroy ( lds_Clause )

return li_rtn

end function

public function integer of_changetitle ();Long ll_row
String ls_template_name

ll_row = tab_1.tabpage_1.dw_browse.GetRow()
IF ll_row > 0 THEN
	ls_template_name = tab_1.tabpage_1.dw_browse.GetItemString(ll_row, "template_name")
	this.title = "Agreement Template Painter" + " - " + ls_template_name
ELSE
	this.title = "Agreement Template Painter"	
END IF

RETURN 1
end function

public function integer of_get_pagebreak (long al_clauseid[], ref long al_pagebreak[], ref long ai_appendparagraph[]);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_painter.of_get_pagebreak()
// $<arguments>
//		Value long	al_clauseid[]
//		Reference Long al_pagebreak[]
//		Reference Integer ai_appendparagraph[]
// $<returns> integer
// $<description>Get clauses' pagebreak flags accordingly
// $<description>Get clauses' Append Paragraph flags accordingly
//////////////////////////////////////////////////////////////////////
// $<add> 05.28.2007 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
Long ll_clause_cnt, ll_cnt, ll_found, i

ll_clause_cnt = UpperBound(al_clauseid)
IF ll_clause_cnt < 1 THEN RETURN -1

//Get all clauses
ll_cnt = ids_clause_approved.RowCount()
IF ll_cnt < 1 THEN ll_cnt = ids_clause_approved.Retrieve()

//Assign clauses' pagebreak flag array accordingly
FOR i = 1 to ll_clause_cnt
	IF ll_cnt < 1 THEN 
		al_pagebreak[i] = 0
		Continue
	END IF
	ll_found = ids_clause_approved.find( "ctx_acp_clause_id = " + String(al_clauseid[i]), 1, ll_cnt)
	IF ll_found > 0 THEN 
		al_pagebreak[i] = ids_clause_approved.GetItemNumber( ll_found, "page_break")
		ai_appendparagraph[i] = ids_clause_approved.GetItemNumber( ll_found, "append_paragraph") //Added By Ken.Guo 2010-10-22.
	ELSE		
		al_pagebreak[i] = 0	
		ai_appendparagraph[i] = 0
	END IF	

NEXT

RETURN 1
end function

public function boolean of_issaved ();Boolean lb_modified = FALSE

if not ib_ole_ini then 
	Return True
End If

try
	lb_modified = Not tab_1.tabpage_2.ole_1.object.ActiveDocument.saved
catch(Throwable th)
	Messagebox('Warning','Failed to get modification status due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	lb_modified = false
end try
		
IF lb_modified Then
	RETURN FALSE	
END IF

RETURN TRUE
end function

on w_agreement_template_painter.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_agreement_template_painter.destroy
call super::destroy
destroy(this.tab_1)
end on

event close;call super::close;Timer(0)
gnv_tracking.of_tracking_doc_delete('Template Library Painter')	//Added By Mark Lee 07/20/12

tab_1.tabpage_2.ole_1.object.close()
ib_close = true
close(w_agreement_template_add_clause)

//
If isvalid(w_agreement_template_merge_fields) Then close(w_agreement_template_merge_fields)
//destroy iole_word

//open(w_blank)
//close(w_blank)

w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
w_mdi.of_menu_security( w_mdi.MenuName )

destroy inv_word  //added by alfee 04.20.2007
destroy iole_word //added by alfee 04.27.2007
destroy ids_search_template_text //added by alfee 05.28.2007
destroy ids_clause_approved //added by alfee 05.28.2007
If isvalid(inv_clause) Then Destroy inv_clause

end event

event open;call super::open;integer li_rtn

ib_disableclosequery = true

////initizlize menu
//w_mdi.ChangeMenu(m_pfe_cst_agreement_template)
//w_mdi.SetToolbarPos ( 2, 1, 200, False )
//ll_handle = handle(w_mdi)
//gnv_appeondll.of_settoolbarpos(ll_handle)
//w_mdi.of_menu_security( w_mdi.MenuName )

//initialize template path 
is_agreement_path = gs_dir_path + gs_DefDirName + "\Agreement\"
gnv_appeondll.of_parsepath(is_agreement_path)

//get approved code of clause
il_clause_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Clause Approval Status' and code = 'Approved'"))

//initialize document object
iole_word = create oleobject
iole_word = tab_1.tabpage_2.ole_1.object.ActiveDocument
//iole_word = tab_1.tabpage_2.ole_1.object.GetIDispatch()
inv_word = create n_cst_word_utility //added by alfee 04.20.2007

//initialize the datawindows
ib_locate = false //don't do locating in template
this.event ue_inidw()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-05-06 By: Wu ZhiJun
//$<reason> Fix a bug
tab_1.tabpage_1.dw_browse.SetSort("template_name A")
tab_1.tabpage_1.dw_browse.Sort()
//--------------------------- APPEON END -----------------------------

tab_1.tabpage_1.cb_go.post event clicked()
ib_locate = true //Restore locating in template

//for full-text search
if gs_dbtype = "SQL" and gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' then//Full Text Search;
	tab_1.tabpage_1.dw_filter.modify( "template_t.text='Full Text Search'" )
end if

inv_clause = Create n_cst_clause

Timer(0.2)

end event

event pfc_save;//override
return of_savefile()
end event

event closequery;call super::closequery;////if is_current_file <> "" and tab_1.tabpage_2.ole_1.object.isdirty() then
//if is_current_file <> "" and not iole_word.saved then
//	if messagebox("IntelliSoftGroup","The template file has been changed. Close without saving it?",&
//			Question!,YesNo!,2) = 2 then
//		return 1 //prevent closing
//	else
//		return 0  //continue closing
//	end if
//end if	
end event

event resize;//override - alfee 03.21.2008

SetRedraw(False)
call super::resize
SetRedraw(TRUE)

//restore the ocx scollbar while resizing to normal under Web environment
IF sizeType = 0 and appeongetclienttype() = 'WEB' THEN
	IF tab_1.tabpage_2.dw_clause.visible = TRUE THEN
		SetRedraw(False)
		tab_1.tabpage_2.of_maponoff(FALSE)
		tab_1.tabpage_2.of_maponoff(TRUE)
		SetRedraw(TRUE)
	END IF
END IF

end event

event pfc_preopen;call super::pfc_preopen;long ll_i
string ls_scale

This.of_SetResize(True)

This.inv_resize.of_SetOrigSize (This.workspacewidth(),This.workspaceheight())
ls_scale = this.inv_resize.scale

For ll_i =  1 To upperbound(This.CONTrol)
   This.inv_resize.of_Register (This.CONTrol[ll_i],ls_scale)
Next


end event

event activate;call super::activate;//initizlize menu
long ll_handle

If w_mdi.menuname <> 'm_pfe_cst_agreement_template' Then
	w_mdi.ChangeMenu(m_pfe_cst_agreement_template)
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
	ll_handle = handle(w_mdi)
	gnv_appeondll.of_settoolbarpos(ll_handle)
	w_mdi.of_menu_security( w_mdi.MenuName )
	
	choose case tab_1.selectedtab
	case 1 
			of_menu_security("browse")
	case 2
			of_menu_security("detail")
	case else
			of_menu_security("others")
	end choose
End If


//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(This.tab_1.tabpage_2.ole_1 ) Then
	This.tab_1.tabpage_2.ole_1.object.activate(true)
End If
end event

event timer;call super::timer;This.Event pfc_cst_locate_clause()

end event

event deactivate;call super::deactivate;//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(This.tab_1.tabpage_2.ole_1 ) Then
//	This.tab_1.tabpage_2.ole_1.object.activate(False)
//End If
end event

type tab_1 from u_tab_agreement_template within w_agreement_template_painter
integer width = 4059
integer height = 2156
integer taborder = 11
boolean boldselectedtext = false
end type

event selectionchanged;call super::selectionchanged;long		ll_Handle

Choose Case newindex
	Case 1
		of_menu_security("browse")
	Case 2
		If Not ib_showed Then
			gnv_reg_ocx.of_check_ocx( 1,'', True)		//1: office //Added by Ken.Guo on 2008-11-06
			ib_showed = True
		End If
		
		of_menu_security("detail")
		
		//Clear The Treeview
		ll_Handle = Tab_1.Tabpage_2.tv_Clause.FindItem(RootTreeItem!,0)
		do while ll_Handle > 0
			Tab_1.Tabpage_2.tv_Clause.DeleteItem(ll_Handle)
			ll_Handle = Tab_1.Tabpage_2.tv_Clause.FindItem(RootTreeItem!,0)
		loop
		
		of_select()
		
		Tab_1.Tabpage_2.of_RefreshTreeView()			//Added by Scofield on 2010-01-27
	Case else
		of_menu_security("others")
End Choose

end event

