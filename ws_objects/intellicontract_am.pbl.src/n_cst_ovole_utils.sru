$PBExportHeader$n_cst_ovole_utils.sru
$PBExportComments$Office Viewer OCX utils
forward
global type n_cst_ovole_utils from nonvisualobject
end type
end forward

global type n_cst_ovole_utils from nonvisualobject
end type
global n_cst_ovole_utils n_cst_ovole_utils

type variables
PUBLIC:
String is_agreement_path //for clauses 
String is_current_file //current opened file
String is_readonly_reason //reason for readonly document, by alfee at 03.08.2007
Integer ii_changes = 10 //The rows per page displayed in user changed text list //Added By Ken.Guo 2010-08-03.
DataStore ids_export //Alfee 10.28.2008

PRIVATE:
OLECustomControl   iole_parent //The visual OLEControl put in the window
OLEObject    iole_object //The inner object of the OLEControl:iole_parent.object
OLEObject    iole_document //The inner document object of the OLEControl
OLEObject    iole_workbook //Added By Ken.Guo 2009-09-07.
n_cst_dm_utils  inv_dm_utils //
n_cst_word_utility inv_word_util //by alfee at 03.27.2007

String is_doc_right //user rights on document
String is_clause_right //user rights on current clause
String is_clause_right_last //user rights on last clause
Boolean ib_Initialized = FALSE
Boolean ib_readonly = FALSE
Boolean ib_status_changed = TRUE //indicator of document status changed , by alfee 05.15.2007 from false to true
Boolean ib_undo_message = True //indicator of alert message while undo by alfee 04.10.2007 - obsolete
Boolean ib_statuschange_by_undo = FALSE //alfee 09.07.2007
Boolean ib_trackchange_by_sys = FALSE //Track changes by system - Alfee 10.30.2007
Boolean ib_readonly_alert = TRUE //Alert for readonly document - Alfee 01.08.2008
Boolean ib_merged = TRUE //Merged flag for current document - Alfee 09.18.2008

DataStore ids_category //user rights on all clauses
DataStore ids_changes //document change list 
DataStore ids_clausename //05.05.2007

//---by alfee at 03.23.2007-------
Long il_export_ctxid //last ctx id to export file 
Long il_export_id  //last export id to export file
String is_export_file //Current export file
//---End ------------------------

string is_chapter[] = {"##","@@"}
string is_paragraph = "#.0"
string is_section = "#.#"

/*--------For WordDocument------------*/
//DIALOG CONSTANT
CONSTANT Int DIALOG_NEW = 0
CONSTANT Int DIALOG_OPEN = 1
CONSTANT Int DIALOG_SAVE = 2
CONSTANT Int DIALOG_SAVEAS = 3
CONSTANT Int DIALOG_PRINT = 4
CONSTANT Int DIALOG_PRINT_SETUP = 5
CONSTANT Int DIALOG_FILE_PROERTY = 6

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
constant int wdPageView = 3				//Added By Mark Lee 06/19/2013 office 2007 default is 3
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

//WdReplace
Constant int wdReplaceAll = 2 
Constant int wdReplaceNone = 0 
Constant int wdReplaceOne = 1 

CONSTANT INTEGER wdActiveEndPageNumber = 3
CONSTANT INTEGER wdFirstCharacterLineNumber = 10
CONSTANT INTEGER wdFirstCharacterColumnNumber = 9

//WdMailMergeMainDocType
CONSTANT INTEGER 			wdNotAMergeDocument = -1
CONSTANT INTEGER        wdFormLetters = 0
CONSTANT INTEGER        wdMailingLabels = 1
CONSTANT INTEGER        wdEnvelopes = 2
CONSTANT INTEGER        wdCatalog = 3

CONSTANT INTEGER wdPropertyKeywords = 4 //by alfee at 03.09.2007

Constant long wdFieldKeyWord = 18 
Constant long wdFieldMergeField = 59 
Constant long wdFieldAutoTextList = 89
Constant long wdFieldExpression = 34
Constant long wdFieldRef = 3
Constant long wdFieldHyperlink  = 88

Constant Long wdColorBlack = 0
Constant Long wdNoProtection = -1 // 03.10.2008

//WdRevisionType - Alfee 07.17.2008
Constant int wdNoRevision = 0 
Constant int wdRevisionConflict = 7 
Constant int wdRevisionDelete = 2 
Constant int wdRevisionDisplayField = 5 
Constant int wdRevisionInsert = 1 
Constant int wdRevisionParagraphNumber = 4 
Constant int wdRevisionParagraphProperty = 10 
Constant int wdRevisionProperty = 3 
Constant int wdRevisionReconcile = 6 
Constant int wdRevisionReplace = 9 
Constant int wdRevisionSectionProperty = 12 
Constant int wdRevisionStyle = 8 
Constant int wdRevisionStyleDefinition = 13 
Constant int wdRevisionTableProperty = 11 
//---------Office2007 ---------------------
Constant int wdRevisionCellInsertion = 16 
Constant int wdRevisionCellMerge = 18  
Constant int wdRevisionMovedFrom = 14
Constant int wdRevisionMovedTo = 15
//-------------------------------------------
//Current ctx id
Long ii_ctx_id

n_cst_clause inv_clause  //Added By Ken.Guo 2010-01-18.


end variables

forward prototypes
public function integer of_close ()
public function integer of_new ()
public function integer of_showtoolbar (boolean ab_visible)
public function integer of_toggletoolbar ()
public function integer of_print ()
public function integer of_savedialog ()
public function integer of_opendialog ()
public function boolean of_ismodified ()
public function integer of_showmap (boolean ab_visible)
public function integer of_togglemap ()
public function integer of_acceptall ()
public function integer of_rejectall ()
public function integer of_insertfile (string as_filename)
public function integer of_insertfile ()
public function integer of_savetofile (string as_filename)
public function integer of_open (string as_filename, boolean ab_readonly)
public function integer of_setreadonly (boolean ab_readonly)
public function integer of_inserttext (string as_text)
public function boolean of_isreadonly ()
public function integer of_initial (olecustomcontrol aole_control)
public function integer of_getbookmarks (ref string as_bookmark[])
public function datastore of_getclauserights (string as_userid, integer ai_type, long al_clauseid[])
public function string of_get_clauseright (long al_doc_lastpos)
public function integer of_checkrights ()
public subroutine of_setdocumentstatus (string as_rights)
public function boolean of_isstatuschanged ()
public subroutine of_setstatuschanged (boolean ab_status)
public function integer of_displayfile (string as_file, boolean ab_readonly)
public function integer of_insertfield (string as_mergefield)
public function integer of_getclausestatus (long al_clauseid[], ref string as_rights[])
public function integer of_undo ()
public subroutine of_msgbox ()
public function integer of_trackchange (boolean ab_track, boolean ab_showmenu)
public function integer of_set_expinfo (long al_export_ctxid, long al_export_id, string as_export_file)
public function integer of_check_numbering ()
public function integer of_add_field (boolean ab_fieldexisted, string as_text, long al_fieldtype)
public function string of_convert_number (string as_char)
public function string of_parse_number (integer ai_num, string as_chapter)
public subroutine of_restore_numbering ()
public subroutine of_restore_numbering (long al_clause_start)
public function integer of_char2num (string as_char)
public function integer of_roman2num (string as_char)
public function integer of_acceptall (string as_filename)
public function boolean of_ismerged ()
public function integer of_setmergestatus (boolean ab_merged)
public function boolean of_ismerged (oleobject aole_word)
public function integer of_setmergestatus (oleobject aole_word, boolean ab_merged)
public function integer of_autonumbering (string as_file)
public function boolean of_istrackon ()
public function boolean of_isshowreviewmenu ()
public function integer of_trackchange_ini ()
public function integer of_acceptchanges (integer ai_index)
public function integer of_rejectchanges (integer ai_index)
public function boolean of_isselectedrevision (integer ai_index)
public function integer of_getbookmarkscount ()
public function boolean of_havemergefield (long al_clauseid[])
public function integer of_getnewclauseid (long al_clauseid[], ref long al_newclauseid[])
public subroutine of_getchanges ()
public function long of_getchanges (integer ai_revindex, ref integer ai_newpageno, ref integer ai_newpagecnt, ref datawindow adw_changes)
public function long of_getchanges (ref integer ai_newpageno, ref integer ai_newpagecnt, ref datawindow adw_changes)
public subroutine of_ini_expinfo ()
public function integer of_undoclear ()
public function boolean of_havemergefield (string as_right)
public function boolean of_refresh_clauses (datastore ads_clause_rule_results)
public function boolean of_refresh_clausemap (ref datawindow adw_clausemap)
public function integer of_setreviewstatus (boolean ab_allow_approve_reject)
public function integer of_setreviewstatus (string as_clause_right, boolean ab_allow_approve_reject)
public function integer of_unprotect_doc ()
public function integer of_setsaved (boolean ab_saved)
public function boolean of_getsaved ()
public function integer of_trackchange_restore (boolean ab_track, boolean ab_showmenu, boolean ab_track_by_sys)
public function integer of_accept_reject (string as_action, string as_criteria)
public function integer of_find_text (string as_searchtext[])
public function boolean of_getmergestatus ()
public function boolean of_is_newexp (long al_export_ctxid, long al_export_id, string as_export_file, ref datastore ads_export_data)
public function integer of_auto_numbering ()
public function integer of_mergedocinfo (oleobject aole_word, str_doc_info astr_docinfo, boolean ab_merge)
public function integer of_refresh_docinfo (oleobject aole_word, str_doc_info astr_docinfo, boolean ab_updatefield)
public function boolean of_isinitialized ()
public function integer of_displayfile_excel (string as_file, boolean ab_readonly)
public subroutine of_check_doc (long ai_ctx_id, long al_doc_id[], long ai_export_id[], string as_filename[])
public function string of_getdocumentrights (string as_userid, long ai_docid, long al_category)
public function integer of_mergedata (long ai_export_id, long ai_ctx_id, string as_open_file, string as_target_file, boolean ab_merged, str_doc_info astr_docinfo)
public function integer of_mergedata_auto (long ai_export_id, long ai_ctx_id, string as_open_file, string as_target_file, boolean ab_mergeornot, str_doc_info astr_docinfo)
public subroutine of_mergedata_auto_ori (long ai_export_id, long ai_ctx_id, string as_open_file, string as_target_file, boolean ab_mergeornot)
public function integer of_restore_clausenew (long ai_docid, decimal adec_revision, string as_docext, olecustomcontrol aole_1)
public function string of_runexport (long ai_export_id, long ai_ctx_id)
public function integer of_merge_to_db (long al_ctx_id, long al_doc_id, decimal adec_revision, string as_filename, string as_doc_ext)
public function integer of_getclausefile (long al_clauseid, decimal adec_revision, ref string as_filename)
public function integer of_mergefile (long al_clauseid[], string as_rights[], long al_pagebreak[], integer ai_appendparagraph[])
public function integer of_accept_reject_special_character (string as_action, string as_criteria, boolean ab_flag)
public function integer of_revision_count ()
public function integer of_initialdoc (oleobject aole_document)
public function integer of_unprotect_doc (boolean abln_msgbox)
end prototypes

public function integer of_close ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_close()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>Close current opened document
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized then return -1

this.iole_parent.object.close()
ib_Initialized=false
setnull(this.iole_document)


return 1
end function

public function integer of_new ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_new()
// $<arguments>(None)
// $<returns> integer
// $<description>Add new document to the OLE control
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////

try
	iole_object.createNew("Word.Document")
	iole_document = iole_object.ActiveDocument
	ib_Initialized=true
//	of_inserttext( "A new blank document.")
catch(Throwable th)
	Messagebox('Warning','Failed to create a new document in the OLE control due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try

return 1


end function

public function integer of_showtoolbar (boolean ab_visible);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_showtoolbar()
// $<arguments>
//		value	boolean	true:  Show the toolbar
//							false: Hide the toolbar
// $<returns> integer
// $<description>Show or hide the toolbar of the OCX.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized  then return -1

try
	iole_object.ToolBars=ab_visible
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to show toolbars due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_toggletoolbar ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_toggletoolbar()
// $<arguments>(None)
// $<returns> integer
// $<description>Show or hide toolbar.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////


if not ib_Initialized then return -1

try
	iole_object.ToolBars=not iole_object.ToolBars
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to show toolbars due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_print ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_print()
// $<arguments>(None)
// $<returns> integer
// $<description>Print current document.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////


if not ib_Initialized then return -1

try
//	iole_object.ShowDialog(dialog_print)
	iole_object.PrintOut(True) //by alfee 04.29.2007
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to print the document due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_savedialog ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_savedialog()
// $<arguments>(None)
// $<returns> integer
// $<description>Display the SaveFileDialog to save file
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

IF not ib_initialized THEN return -1

try
	iole_object.showdialog(DIALOG_SAVE)
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to save the document due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_opendialog ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_opendialog()
// $<arguments>(None)
// $<returns> integer
// $<description>Display the OpenFileDialog to open a new file
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

try
	iole_object.ShowDialog(DIALOG_OPEN)
	iole_document = iole_object.activeDocument()
	ib_Initialized=true
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to open the document due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function boolean of_ismodified ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_ismodified()
// $<arguments>(None)
// $<returns> boolean
// $<description>If the current ole content has been modified
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////


if not ib_Initialized then return false

try
	If iole_object.doctype = 2 Then
		//workaround slowly bug
		iole_object.FileSave = True
		iole_object.FileSave = False
	End If
	Return not iole_document.saved
catch(Throwable th)
	Messagebox('Warning','Failed to get modification status due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return false
end try


end function

public function integer of_showmap (boolean ab_visible);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_showmap()
// $<arguments>
//		value	boolean	true:  Show the Document Map
//							false: Hide the Document Map
// $<returns> integer
// $<description>Show or hide the Document Map.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized then return -1

try
	iole_document.ActiveWindow.DocumentMap = ab_visible
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to show Clause Map due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_togglemap ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_togglemap()
// $<arguments>
// $<returns> integer
// $<description>Show or hide the Document Map.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized  then return -1

try
	iole_document.ActiveWindow.DocumentMap = not iole_document.ActiveWindow.DocumentMap
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to show Clause Map due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_acceptall ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_acceptall()
// $<arguments>
// $<returns> integer
// $<description>Accept all changes.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized  then return -1

try
	
	IF iole_document.Revisions.Count >= 1 THEN
		 //iole_document.Revisions.AcceptAll()
		 iole_document.AcceptAllRevisions() //Alfee 07.15.2008
	END IF

	RETURN 1
	
catch(Throwable th)
	Messagebox('Warning','Failed to accept all changes due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_rejectall ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_acceptall()
// $<arguments>
// $<returns> integer
// $<description>Reject all changes.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized  then return -1

try
	
	If iole_document.Revisions.Count >= 1 Then 
//		 iole_document.Revisions.RejectAll()
		 iole_document.RejectAllRevisions //Alfee 07.15.2008
	END IF

	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to reject all changes due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_insertfile (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_rejectfile()
// $<arguments>
//    value string as_filename: The specified file name
// $<returns> integer
// $<description>Insert a specified file to current position of the document
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized then return -1

if not fileexists(as_filename) then
	Messagebox('Warning','The specified file '+as_filename+' does not exists.')
end if

try
	iole_document.ActiveWindow.Selection.InsertFile(as_filename)
	gnv_shell.of_delete_recent( as_filename, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.

	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to insert file '+as_filename+' due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_insertfile ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_rejectfile()
// $<arguments>
//    value string as_filename: The specified file name
// $<returns> integer
// $<description>Insert a specified file to current position of the document
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized  then return -1

string docpath, docname
integer  li_rtn
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
li_rtn = GetFileOpenName("Select File", docpath, docname, "DOC", &
 		"Doc Files (*.DOC),*.DOC" )
gf_save_dir_path(docpath) //Added by Ken.Guo on 2009-03-10
//ChangeDirectory(gs_current_path) //Added by Alfee 05.14.2007

if li_rtn< 1 then return -1

try
	iole_document.ActiveWindow.Selection.InsertFile(docpath)
	gnv_shell.of_delete_recent( docpath, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.

	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to insert file due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_savetofile (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_savetofile()
// $<arguments>
//		value	string	as_filename		
// $<returns> integer
// $<description>Save content of OCX to a local file
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-04 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized  then return -1

gnv_rights.of_check_dir_right(as_filename, true, 'Word Save')
try
	Choose Case iole_object.doctype 
		Case 1  //doc
			iole_object.SaveToLocal(as_filename,true)			
		Case 2 //xls
			If gs_ImageView_Version <> '4.0' Then iole_object.FileSave = True
			iole_document.SaveAs(as_filename)	
			If gs_ImageView_Version <> '4.0' Then iole_object.FileSave = False
	End Choose

	Return 1
catch(Throwable th)
	Messagebox('Warning','Failed to the save document to '+as_filename+' due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try

return 1

end function

public function integer of_open (string as_filename, boolean ab_readonly);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_open()
// $<arguments>(None)
// $<returns> integer
// $<description>Open the specified file.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////


try
	iole_object.OpenLocalFile(as_FileName,ab_readonly)
	gnv_word_utility.of_modify_word_property( iole_object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	gnv_shell.of_delete_recent( as_FileName, True)
	iole_document = iole_object.ActiveDocument
	If iole_object.doctype = 2 Then
		iole_workbook = iole_document.application.activeworkbook
		
		//workaround plugin bug.
		iole_document.application.CommandBars("Standard").Controls("New").Enabled = false
		iole_document.application.CommandBars("Standard").Controls("Open").Enabled = false
		iole_document.application.CommandBars("Standard").Controls("Save").Enabled = false
	End IF
	ib_Initialized=true
	//----Begin Commented by Alfee 09.21.2007----------
	//<$Reason>The readonly property set in of_setdocumentrighs() in of_previewdoc()
	//<$Reason>and Rowfocuschanged event in dw_browse   
	//of_setreadonly( ab_readonly) 
	//----End Commented --------------------------------
	return 1
catch(Throwable th)
	iole_object.close() //Alfee 09.23.2008
	Messagebox('Warning','Failed to open the document '+as_FileName+' due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try

return 1


end function

public function integer of_setreadonly (boolean ab_readonly);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_setreadonly()
// $<arguments>
//		value	boolean	ab_readonly		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-20 by Frank.Gui
//////////////////////////////////////////////////////////////////////



try
	ib_readonly = ab_readonly
	ib_readonly_alert = ab_readonly //Alert msg for readonly document - Alfee 01.08.2008	
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to set the document to ReadOnly due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_inserttext (string as_text);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_inserttext()
// $<arguments>
//		value	string	as_text		
// $<returns> integer
// $<description>Insert content at current place
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-20 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not ib_Initialized  then return -1


try
	iole_document.ActiveWindow.Selection.InsertAfter(as_text)
//	iole_document.ActiveWindow.Selection.InsertDateTime('mm/dd/yyyy',false)
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to insert the file due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function boolean of_isreadonly ();//////////////////////////////////////////////////////////////////////
// $<function>of_isreadonly()
// $<arguments>(None)
// $<returns> boolean
// $<description>Retuen if current document is ReadOnly
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-09 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return ib_readonly
end function

public function integer of_initial (olecustomcontrol aole_control);//////////////////////////////////////////////////////////////////////
// $<function>of_initial()
// $<arguments>
//		value	olecontrol	aole_control		
// $<returns> integer
// $<description>Initialize this userobject
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-01 by Frank.Gui
//////////////////////////////////////////////////////////////////////

this.iole_parent = aole_control
this.iole_object = aole_control.object

//if isvalid(iole_object) then
//	try
//		this.iole_document = iole_object.GetIDispatch()
//	catch(Exception ex)
//		setnull(this.iole_document)
//	end try
//end if

return 1
end function

public function integer of_getbookmarks (ref string as_bookmark[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_getbookmarks()
// $<arguments>
//		reference	string	as_bookmark[]		
// $<returns> integer
// $<description>Get bookmarks from word document
//////////////////////////////////////////////////////////////////////
// $<add> 01.22.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Integer i, j
String ls_bookmark

IF iole_object.doctype <> 1 THEN RETURN -1

Try

//-------Begin Modified by Alfee 05.30.2007-----------	
j = 1
FOR i = 1 TO iole_document.content.Bookmarks.Count
	ls_bookmark = iole_document.Content.Bookmarks.Item[i].Name
	IF lower(Left(ls_bookmark, 7)) = 'clause_' THEN
		as_bookmark[j] = ls_bookmark
		j ++
	END IF
NEXT
////Clear invalid bookmark(s)
//FOR i = 1 TO iole_document.Bookmarks.Count
//	ls_bookmark = iole_document.Bookmarks.Item[i].Name
//	IF Lower(Left(ls_bookmark,7)) <> "clause_" THEN
//		iole_document.bookmarks.item[i].Delete()
//		i --
//	END IF
//NEXT
//
////Get clause bookmark(s) name in order
//FOR i = 1 TO iole_document.Bookmarks.Count
//	as_bookmark[i] = iole_document.Content.Bookmarks.Item(i).Name
//NEXT
//------End Modified -------------------------------------

Catch(Throwable th)
	MessageBox("Alert Message","Get clause bookmark(s) failed!")
	IF Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
End Try


RETURN 1
end function

public function datastore of_getclauserights (string as_userid, integer ai_type, long al_clauseid[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_getclauserights()
// $<arguments>
//		value	string	as_userid  
//		value integer  ai_type
//		value	long  	al_clauseid[]
// $<returns> string
// $<description>Get user rights on clause level
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

/*1-Contract Management,2-Clause,3-Templates,4-Documents 
11-Full Access,12-Read Only,13-No Access;
21-Full Access,22-No Editing,23-Editing With Approval,24-No Adding,25-Adding With Approval;
31-Full Access,32-No Editing,33-Editing With Approval;
41-Full Access,42-No Editing,43-Editing With Approval*/

//Begin - Added By Mark Lee 08/02/12
//ids_category.Retrieve(as_userid,ai_type,al_clauseid)
If isnull(al_clauseid) Or UpperBound(al_clauseid) <= 0 Then
	ids_category.reset()
Else
	ids_category.Retrieve(as_userid,ai_type,al_clauseid)
End If 
//End - Added By Mark Lee 08/02/12


RETURN ids_category



end function

public function string of_get_clauseright (long al_doc_lastpos);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_get_clauseright()
// $<arguments>
//		value	integer		
// $<returns> string
// $<description>Get rights on current clause
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Integer i
Long ll_start, ll_end, ll_found, ll_cnt
String ls_bookmark, ls_find, ls_right

if not ib_Initialized then return ls_right //01.19.2008

//Get user rights on clause level
Try
ll_cnt = iole_document.Content.Bookmarks.Count 
FOR i = 1 TO ll_cnt
	//-----Begin Added by Alfee 05.30.2007 ---------------------
	ls_bookmark = iole_document.Content.Bookmarks.Item[i].name
	IF lower(left(ls_bookmark,7)) <> 'clause_' Then Continue
	//-----End Added -------------------------------------------
	ll_start = iole_document.Content.Bookmarks.Item[i].Start
	ll_end = iole_document.Content.Bookmarks.Item[i].END	
	IF al_doc_lastpos >= ll_start AND al_doc_lastpos < ll_end THEN
		//ls_bookmark = iole_document.Content.Bookmarks.Item(i).name //commented by alfee 05.30.2007
		ls_find = "ctx_acp_clause_id = " + Right(ls_bookmark, Len(ls_bookmark) - 7)
		ll_found = ids_category.Find(ls_find, 1, ids_category.RowCount())
		IF ll_found > 0 THEN 
			ls_right = ids_category.GetItemString(ll_found,"description")
		END IF
		EXIT
	END IF
NEXT
Catch(Throwable th)
	MessageBox("Alert Message","Get user rights on clauses failed!")
	IF Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
End Try

is_clause_right_last = is_clause_right 
is_clause_right = ls_right

//-----------Begin Added by Alfee 09.07.2007 ------------------------
//<$Reason>Clear undo list while the right on clause changed to 'no editing'
IF lower(is_clause_right_last) <> "no editing" AND lower(is_clause_right) = 'no editing' THEN
	of_undoclear()
END IF
//-----------End Added ----------------------------------------------

RETURN ls_right

end function

public function integer of_checkrights ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_checkrights()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>Check user edit rights both on document and clause level
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//------------Begin Modified by Alfee 09.21.2007---------
//Check user rights on document level
IF ib_readonly or lower(is_doc_right) = "no editing" or lower(is_doc_right) = "no access" THEN
	IF Len(Trim(is_readonly_reason)) < 1 THEN is_readonly_reason = 'document' 	
	Post of_msgbox() //Added By Ken.Guo 2009-04-29 Must use post
//Check user rights on clause level
ELSE
	IF lower(is_clause_right) = "no editing" THEN
		is_readonly_reason = 'clause' 
	Post of_msgbox()  //Must use post. //Added By Ken.Guo 2009-04-29
	END IF
END IF

/*IF NOT of_isstatuschanged() THEN RETURN -1

//----Begin Added by Alfee 09.07.2007---------
//<$Reason>Return if status changed caused by undo
IF ib_statuschange_by_undo THEN 
	ib_statuschange_by_undo = FALSE
	RETURN -1
END IF
//----End Added -------------------------------

IF ib_readonly THEN is_doc_right = "no editing"

//Check user rights on document level
IF lower(is_doc_right) = "no editing" THEN
	is_readonly_reason = 'document' //09.07.2007
	RETURN of_undo()

//Check user rights on clause level
ELSE
	IF lower(is_clause_right_last) = "no editing" THEN
		is_readonly_reason = 'clause' //09.07.2007
		RETURN of_undo() 
	END IF
END IF
*/
//---------------End Modified -------------------------------------

RETURN 1

end function

public subroutine of_setdocumentstatus (string as_rights);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_setdocumentstatus()
// $<arguments>
//		value	string	as_right		
// $<returns> 
// $<description>
// $<description>Set document readonly property by user rights 
//////////////////////////////////////////////////////////////////////
// $<add> 01.24.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////					

IF lower(as_rights) = "no editing" or lower(as_rights) = "no access"	THEN
	of_setreadonly(True)
END IF

end subroutine

public function boolean of_isstatuschanged ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_isstatuschanged()
// $<arguments>(None)
// $<returns> boolean
// $<description>
// $<description>Return document status for ole onstatuschange event
//////////////////////////////////////////////////////////////////////
// $<add> 01.24.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Return ib_status_changed

end function

public subroutine of_setstatuschanged (boolean ab_status);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_setstatuschanged()
// $<arguments>(None)
// $<returns> boolean
// $<description>
// $<description>Set document status for ole onstatuschange event
//////////////////////////////////////////////////////////////////////
// $<add> 01.24.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

ib_status_changed = ab_status

end subroutine

public function integer of_displayfile (string as_file, boolean ab_readonly);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_displayfile()
// $<arguments>
//		value	string 	as_file    		
//		value	boolean	ab_readonly		
// $<returns> integer
// $<description>Display the specified document
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.11.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Long i
Boolean lb_statuschanged_ori 
//SetPointer(HourGlass!)

TRY //03.10.2008
	
//Close original file
//iole_object.Close() - Commented by Alfee 09.23.2008
is_current_file =""

lb_statuschanged_ori = of_isstatuschanged()
of_setstatuschanged(False)

IF IsNull(as_file) OR Len(Trim(as_file)) < 1 OR NOT FileExists(as_file) THEN
	iole_object.Close() //- Added by Alfee 09.23.2008	
	RETURN -1
END IF

//Open new file
IF of_open(as_File,ab_readonly) > 0 THEN 
	IF iole_object.DocType = 0  THEN
		is_current_file =""
		of_setstatuschanged(lb_statuschanged_ori) 
		RETURN -1
	END IF
	is_current_file = as_file
ELSE
	RETURN -1 
END IF

//Restore the switch of document onstatuschanged event
of_setstatuschanged(lb_statuschanged_ori)

//Get and initialize the merge status - Alfee 09.18.2008
ib_merged = of_getmergestatus()

//Set zoom percentage
IF iole_object.DocType = 0  THEN //Added By Ken.Guo 2011-05-07. Added if statement.
	iole_document.ActiveWindow.View.Zoom.Percentage = 100
End If

//Set MS Word user info //added by alfee 08.11.2007
If gs_imageview_version = '5.0' Then //Added By Ken.Guo 2010-12-22. Added if statement.
	If isvalid(iole_object) Then
		iole_object.WebUserName = gs_user_id 
	End If
Else
	iole_document.application.username = gs_user_id 
End If

//Unprorect the document if protected - alfee 03.10.2008
//of_unprotect_doc()
//IF of_unprotect_doc() = -1 THEN RETURN -1 //Alfee 10.08.2008
IF of_unprotect_doc() = -1 THEN RETURN 0 //Modified By Ken.Guo 05/30/2013. Support display protected doc.

//-----------------Added By alfee 05.05.2007---------
//Set default color property for hyperlink field
//----------Begin Modified by Alfee on 07.09.2008----------------------
//<$Reason>For performance tuning
IF iole_object.DocType = 0  THEN //Added By Ken.Guo 2011-05-07. Added if statement.
	IF iole_document.Application.Language = 1033 THEN //us-en
		iole_document.Styles.Item("Hyperlink").Font.Color = wdColorBlack
		iole_document.Styles.Item("FollowedHyperlink").Font.Color = wdColorBlack
	END IF
End If
//Boolean ib_changed = FALSE //04.22.2008
//FOR i =  1 TO iole_document.Styles.Count
//	//--------Begin Modified by Alfee on 04.22.2008 ---------------------
//	IF iole_document.Styles.Item[i].NameLocal = "FollowedHyperlink" THEN
//		iole_document.Styles.Item[i].Font.Color = wdColorBlack
//		IF ib_changed THEN EXIT
//		ib_changed = TRUE
//	END IF
//	IF iole_document.Styles.Item[i].NameLocal = "Hyperlink" THEN
//		iole_document.Styles.Item[i].Font.Color = wdColorBlack
//		IF ib_changed THEN EXIT
//		ib_changed = TRUE
//	END IF		
//	/* IF iole_document.Styles.Item[i].NameLocal = "FollowedHyperlink" THEN
//		iole_document.Styles.Item[i].Font.Color = wdColorBlack
//		EXIT
//	END IF */
//	//--------End Modified ----------------------------------------------
//NEXT
//-----------End Modified ----------------------------------------------
//------------------End Added------------------------

Catch (Throwable th) //03.10.2008
	MessageBox("Display File", "Display file failed due to: " + th.text)
	RETURN -1 
End Try

RETURN 1
end function

public function integer of_insertfield (string as_mergefield);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_insertfield()
// $<arguments>
//		value	string	as_mergefield		
// $<returns> integer
// $<description>Insert filed for merge data later
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.30.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//Remark: This function is obsolete, which is already included in n_cst_word_utility.

iole_document.ActiveWindow.Selection.Fields.Add(iole_document.ActiveWindow.Selection.Range,-1,"MERGEFIELD  " + as_mergefield,True)

RETURN 1
end function

public function integer of_getclausestatus (long al_clauseid[], ref string as_rights[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_getclausestatus()
// $<arguments>
//		value    	long  	al_clauseid[]		
//		reference	string	as_rights[]  		
// $<returns> integer
// $<description>Get clauses' status according to revisions
// $<description>As the red/blue flags are displayed for approver not current user
// $<description>never set the flag by current user's right.
//////////////////////////////////////////////////////////////////////
// $<add> 01.30.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Long ll_cnt,ll_rev_cnt,i
String ls_bookmark

//Get user rights on clause level
If iole_object.DocType <> 1 Then Return -1

Try
ll_cnt = UpperBound(al_clauseid)
FOR i = 1 TO ll_cnt
	ls_bookmark = "clause_" + String(al_clauseid[i])
	IF iole_document.Bookmarks.Exists(ls_bookmark) Then 
		ll_rev_cnt = iole_document.Bookmarks.Item(ls_bookmark).Range.Revisions.Count
		CHOOSE CASE ll_rev_cnt 
			CASE IS < 1 
				as_rights[i] = "" 
		   CASE 1 
				IF iole_document.Bookmarks.Item(ls_bookmark).Range.Revisions.Item[1].Range.Start = &
					iole_document.Bookmarks.Item(ls_bookmark).Start And &
				   iole_document.Bookmarks.Item(ls_bookmark).Range.Revisions.Item[1].Range.End >= &
					iole_document.Bookmarks.Item(ls_bookmark).End - 1 THEN
					as_rights[i] = "adding with approval"
				ELSE
					as_rights[i] = "editing with approval"
				END IF
			CASE ELSE   
				as_rights[i] = "editing with approval"
		END CHOOSE	
	END IF
NEXT
Catch(Throwable th)
	MessageBox("Alert Message","Get clause status failed!")
	IF Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
End Try
	
RETURN 1
end function

public function integer of_undo ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_undo()
// $<arguments>
//		value
// $<returns> integer
// $<description>Undo in document
//////////////////////////////////////////////////////////////////////
// $<add> 03.08.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
any la_rtn 

la_rtn = iole_document.undo()
IF Lower(String(la_rtn)) = 'true' THEN 
	//----Begin Modified by Alfee 09.07.2007----------
	ib_statuschange_by_undo = TRUE 
	Post of_msgbox()  //Added By Ken.Guo 2009-04-29
	RETURN -1
	/*IF ib_undo_message THEN of_msgbox() 
	ib_undo_message = FALSE 
	RETURN -1
 ELSE
	ib_undo_message = TRUE */
ELSE	
	ib_statuschange_by_undo = FALSE 
	//-----End Modified ------------------------------
END IF

RETURN 1
end function

public subroutine of_msgbox ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_msgbox()
// $<arguments>
// $<returns> 
// $<description>Show message box for readonly document 
//////////////////////////////////////////////////////////////////////
// $<add> 03.08.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Choose Case lower(is_readonly_reason)
	Case 'history'
		//-------Begin Modified by Alfee 01.08.2008-----------------------
		//<$Reason>Alert only 1 time for each opened readonly document
		IF ib_readonly_alert	THEN
			MessageBox("Alert Message","This is a history document, no changes can be made.")
			ib_readonly_alert = NOT ib_readonly_alert
		END IF
		//MessageBox("Alert Message","This is a history document, no changes can be made.")		
		//-------End Modified ------------------------------------------------				
	Case 'checkout'
		//-------Begin Modified by Alfee 01.08.2008-----------------------
		//<$Reason>Alert only 1 time for each opened readonly document
		IF ib_readonly_alert	THEN
			MessageBox("Alert Message","The document is checked out, no changes can be made until it is checked back in.")	
			ib_readonly_alert = NOT ib_readonly_alert
		END IF
		//MessageBox("Alert Message","The document is checked out, no changes can be made until it is checked back in.")	
		//-------End Modified ------------------------------------------------				
	Case 'clause' //alfee 09.07.2007
		//MessageBox("Alert Message","You don't have editing right on the current clause.")
		MessageBox("Alert Message","You don't have editing rights on the current clause, and any changes to it will not be saved.")	//Alfee 09.21.2007
	Case Else
		//-------Begin Modified by Alfee 01.08.2008-----------------------
		//<$Reason>Alert only 1 time for each opened readonly document
		IF ib_readonly_alert	THEN
			MessageBox("Alert Message","You don't have editing rights on the current document, and any changes to it will not be saved.")	
			ib_readonly_alert = NOT ib_readonly_alert
		END IF
		//MessageBox("Alert Message","You don't have editing right on the current document, and any changes to it will not be saved.")	//Alfee 09.21.2007	
		//-------End Modified ------------------------------------------------						
End Choose

Return
end subroutine

public function integer of_trackchange (boolean ab_track, boolean ab_showmenu);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_trackchange()
// $<arguments>
//		boolean	ab_track	: Enable/Disable Track Revison Function
//		boolean	ab_showmenu	: Show/Hide Review toolbar & menu
// $<returns> integer
// $<description>Display review menu and keep toolbar & track changes
// $<description>status for user with full rights.
// $<description>Hide review menu and toolbar, Enable track changes switch 
// $<description>for user without full rights.
//////////////////////////////////////////////////////////////////////
// $<add> 03.13.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
long ll_cnt,i
Boolean lb_statuschanged_ori
Boolean lb_trackchange_by_sys_last //10.30.2007

IF not ib_Initialized  THEN RETURN -1

lb_statuschanged_ori = of_isstatuschanged() 
of_setstatuschanged(FALSE)
lb_trackchange_by_sys_last = ib_trackchange_by_sys //10.30.2007
gnv_word_utility.of_modify_word_property( iole_document)	//Added By Mark Lee 06/20/2013 change for office 2013.

Try
//Set reviewing menu & toolbar
IF Not ab_showmenu THEN 
	//Hide reviewing menu and toolbars
	iole_object.ShowCommandBar("Reviewing",ab_showmenu)
ELSE
	//Restore to display reviewing menu only if it hided by system last time
	//---Begin Modified by Alfee 10.30.2007 --------------------------------
	//iole_document.Application.CommandBars.Item("Reviewing").Visible = ab_showmenu	-- not supported in this ocx control
	IF ib_trackchange_by_sys THEN iole_object.ShowCommandBar("Reviewing",ab_showmenu)
	//---End Modified ------------------------------------------------------	
END IF

//Set the reviewing popup menu
iole_object.ShowCommandBar("Track Changes",ab_showmenu)
iole_object.ShowCommandBar("Track Changes Indicator",ab_showmenu)

//Set track revision switch
//-----Begin Modified by Alfee 10.30.2007------------------------
//IF ab_track THEN  iole_document.TrackRevisions = ab_track
IF ab_track THEN 
	//enable track revison
	iole_document.TrackRevisions = ab_track
	ib_trackchange_by_sys = TRUE 
ELSE 
	//Stop tracking changes only if it enabled by system (not user) last time
	IF lb_trackchange_by_sys_last THEN iole_document.TrackRevisions = ab_track
	ib_trackchange_by_sys = FALSE
END IF
//----End Modified ----------------------------------------------

Catch (Throwable th)
	MessageBox("Alert Message","Set Track Change failed!")
	of_setstatuschanged(lb_statuschanged_ori)	
	RETURN -1 
End Try

of_setstatuschanged(lb_statuschanged_ori)

RETURN 1

end function

public function integer of_set_expinfo (long al_export_ctxid, long al_export_id, string as_export_file);//added by alfee at 03.23.2007
il_export_ctxid = al_export_ctxid
il_export_id =  al_export_id
is_export_file = as_export_file

RETURN 1
end function

public function integer of_check_numbering ();//Check auto numbering in word document
//added by alfee at 03.27.2007

inv_word_util.of_preview(iole_document,True)

Return 1
end function

public function integer of_add_field (boolean ab_fieldexisted, string as_text, long al_fieldtype);//////////////////////////////////////////////////////////////////////
// $<function>of_add_field()
// $<arguments>
//		value	
// $<returns> integer
// $<description>Add fields for numbers
//////////////////////////////////////////////////////////////////////
// $<add> 04.03.2007 by Alfee
//////////////////////////////////////////////////////////////////////
//add field for number - Obsolete function
Long i
boolean lb_infield //whether the number includes in existed field

Try
IF not ab_fieldexisted THEN //if no any fields existed
	iole_document.Fields.Add(iole_document.ActiveWindow.Selection.Range, al_fieldtype, as_text, True)	
ELSE
	lb_infield = false
	For i = 1 to iole_document.Fields.count
		If iole_document.activewindow.selection.inrange(iole_document.Fields.Item[i].Result) THEN
			lb_infield = true
			Exit
		End If		
	NEXT
	If not lb_infield then iole_document.Fields.Add(iole_document.ActiveWindow.Selection.Range, al_fieldtype, as_text, True)
END IF				
Catch(Throwable th)
	IF Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
End Try

Return 1
end function

public function string of_convert_number (string as_char);//This function is obselete by alfee at 04.12.2007


Long i, ll_cnt
string ls_roman[]={"I","II","III","IV","V","VI","VII","VIII","IX", "X","XX","XXX","XL","L","LX","LXX","LXXX","XCC","C","CC","CCC","CD","D","DC","DCC","DCCC","CM"}  
string ls_char[] = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

ll_cnt = UpperBound(ls_roman)
FOR i = 1 to ll_cnt
	IF ls_roman[i] = as_char THEN
		RETURN 'r'
	END IF	
NEXT

ll_cnt = UpperBound(ls_char)
FOR i = 1 to ll_cnt
	IF ls_char[i] = as_char THEN
		RETURN 'c'
	END IF	
NEXT

RETURN ''
end function

public function string of_parse_number (integer ai_num, string as_chapter);
integer i,j, li_a, li_r[], li_max = 1000
string ls_a[], ls_rtn
string a[10,3]={"","I","II","III","IV","V","VI","VII","VIII","IX", "","X","XX","XXX","XL","L","LX","LXX","LXXX","XCC","","C","CC","CCC","CD","D","DC","DCC","DCCC","CM"}  
string as_char[] = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

choose case as_chapter
	case is_chapter[1]
		//handle 3 digits
		if ai_num >= li_max then 
			ls_rtn = string(ai_num)
		else
			li_a = ai_num
			for i = 3 to 1 step -1
			   li_max = li_max/10	
				j = int(li_a / li_max)
				ls_a[i] = a[j+1,i] 
				li_a = li_a - j * li_max
				ls_rtn +=ls_a[i]
			next
		end if
	case is_chapter[2]
		if ai_num > 26 or ai_num < 1 then 
			ls_rtn = string(ai_num)
		else
			ls_rtn = as_char[ai_num]		
		end if
	case else
		ls_rtn = string(ai_num)
end choose

return ls_rtn

//   1. Please enter number:863
//      863=DCCCLXIII
//   2. Please enter number: 256
//      256=CCLVI
//   3. Please enter number:355
//      355=CCCLV
//   4. Please enter number:522
//      522=DXXII
//   5. Please enter number:15
//      15=XV
//


end function

public subroutine of_restore_numbering ();//Commented by Alfee 05.30.2007 this function is not available now

Long ll_cnt, ll_cnt_bookmark, ll_type, ll_found, ll_pos, i, j, k
String ls_text, ls_begin, ls_rtn, ls_clauseid, ls_bookmark
Boolean lb_found_clause = false

ll_cnt_bookmark = iole_document.Content.Bookmarks.Count
ll_cnt = iole_document.Fields.Count

IF ll_cnt < 1 THEN RETURN

Try
//Convert the clause reference field firstly(<<|..|>>) 
//Locate the clause on whcih the clause reference field refers
FOR i = 1 to ll_cnt //clause reference field
	IF iole_document.Fields.Item[i].type = wdFieldKeyWord THEN 
		lb_found_clause = false
		ls_text = iole_document.Fields.Item[i].Result.Text
		IF IsNull(ls_text) or Len(Trim(ls_text)) < 1 Then Continue		
		ls_text = Trim(ls_text)
		
		FOR j = 1 to ll_cnt //clause section field	
			IF iole_document.Fields.Item[i].type = wdFieldAutoTextList THEN
				ls_begin = iole_document.Fields.Item[i].Result.Text
				IF IsNull(ls_begin) or Len(Trim(ls_begin)) < 1 Then Continue				
				IF ls_text = Trim(ls_begin) THEN //if find the reference clause					

					For k = 1 to ll_cnt_bookmark //locate in clause by the clause section field
						IF iole_document.Fields.Item[j].Result.InRange(iole_document.Content.Bookmarks.Item[k].Range) THEN
							//get clause id and name
							ls_bookmark = iole_document.Content.Bookmarks.Item[k].name
							ls_clauseid = mid(ls_bookmark, len('clause_') + 1)
							//Generate clause reference mark
							IF len(ls_clauseid) < 6 THEN 
								ls_clauseid = Fill('*', 6 - Len(ls_clauseid)) + ls_clauseid
							END IF								
							ls_text = "<<|"+ls_clauseid + "-|>>"
							//Restore the reference mark
							iole_document.Fields.Item[i].Result.Text = ls_text
							lb_found_clause = True
							Exit
						END IF					
					Next
					
				END IF
			END IF	
			IF lb_found_clause Then Exit
		NEXT		

	END IF	
NEXT

//Convert the clause section marks
For i = 1 to iole_document.Fields.Count
	ll_type = iole_document.Fields.Item[i].type
	IF ll_type = wdFieldAutoTextList THEN //if clause section field
		ls_text = iole_document.Fields.Item[i].Result.Text
		IF IsNull(ls_text) or Len(Trim(ls_text)) < 1 Then Continue

		IF IsNumber(trim(ls_text)) THEN 	//For #.#, #.0
			ll_pos = Pos(ls_text, ".") 					
			IF ll_pos >0 and mid(ls_text, ll_pos + 1, 1) <> '0' THEN
				ls_text = "#.#"	
			ELSE
				ls_text = "#.0"	
			END IF
		ELSE 	//For ##, @@
			ls_begin = Left(Trim(ls_text), 1)
			ls_rtn = of_convert_number(ls_begin)
			IF lower(ls_rtn) = 'r' THEN //roman 
				ls_text = "##"
			ELSEIF lower(ls_rtn) = 'c' THEN //character
				ls_text = "@@"
			ELSE
				ls_text = ""
			END IF
		END IF
		IF ls_text <> "" THEN
			iole_document.Fields.Item[i].Result.Text = ls_text								
		END IF
	END IF			
Next	
Catch (Throwable th)
	MessageBox("Alert Message","Restore numbering failed!")
	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
End Try

end subroutine

public subroutine of_restore_numbering (long al_clause_start);Long ll_cnt, ll_cnt_bookmark, ll_type, ll_found, ll_pos, i, j, k
String ls_text, ls_code, ls_begin, ls_rtn, ls_clauseid, ls_bookmark, ls_temp
Boolean lb_found_clause = false
Boolean lb_found_chapter = false

ll_cnt_bookmark = iole_document.Content.Bookmarks.Count
ll_cnt = iole_document.Fields.Count

IF ll_cnt < 1 THEN RETURN
IF al_clause_start < 1 Then al_clause_start = 1
IF al_clause_start > ll_cnt_bookmark THEN RETURN

Try
//Convert the clause reference field firstly(<<|..|>>) 
//Locate the clause on whcih the clause reference field refers
FOR i = 1 to ll_cnt //clause reference field
	IF iole_document.Fields.Item[i].type = wdFieldKeyWord THEN 
		IF iole_document.Fields.Item[i].Result.End <= iole_document.Content.Bookmarks.Item[al_clause_start].Range.Start Then 
			Continue	//Continue if the clause needn't restore numbering
		END IF			
		lb_found_clause = false
		ls_text = iole_document.Fields.Item[i].Result.Text
		IF IsNull(ls_text) or Len(Trim(ls_text)) < 1 Then Continue		
		ls_text = Trim(ls_text)
		
		FOR j = 1 to ll_cnt //clause section field	
			IF iole_document.Fields.Item[i].type = wdFieldAutoTextList THEN
				ls_begin = iole_document.Fields.Item[i].Result.Text
				IF IsNull(ls_begin) or Len(Trim(ls_begin)) < 1 Then Continue				
				IF ls_text = Trim(ls_begin) THEN //if find the reference clause					

					For k = 1 to ll_cnt_bookmark //locate in clause by the clause section field
						IF iole_document.Fields.Item[j].Result.InRange(iole_document.Content.Bookmarks.Item[k].Range) THEN
							//get clause id and name
							ls_bookmark = iole_document.Content.Bookmarks.Item[k].name
							ls_clauseid = mid(ls_bookmark, len('clause_') + 1)
							//Generate clause reference mark
							IF len(ls_clauseid) < 6 THEN 
								ls_clauseid = Fill('*', 6 - Len(ls_clauseid)) + ls_clauseid
							END IF								
							ls_text = "<<|"+ls_clauseid + "-|>>"
							//Restore the reference mark
							iole_document.Fields.Item[i].Result.Text = ls_text
							lb_found_clause = True
							Exit
						END IF					
					Next
					
				END IF
			END IF	
			IF lb_found_clause Then Exit
		NEXT		

	END IF	
NEXT

//Convert the clause section marks
For i = 1 to ll_cnt
	IF iole_document.Fields.Item[i].Result.End <= iole_document.Content.Bookmarks.Item[al_clause_start].Range.Start Then 
		Continue	//Contine if the clause needn't restore numbering
	END IF					
	ll_type = iole_document.Fields.Item[i].type
	IF ll_type = wdFieldAutoTextList THEN //For #.#, #.0
		ls_text = iole_document.Fields.Item[i].Result.Text
		IF IsNull(ls_text) or Len(Trim(ls_text)) < 1 Then Continue

		IF IsNumber(trim(ls_text)) THEN 	
			ll_pos = Pos(ls_text, ".") 					
			IF ll_pos >0 and mid(ls_text, ll_pos + 1, 1) <> '0' THEN
				ls_text = "#.#"	
			ELSE
				ls_text = "#.0"	
			END IF
		END IF
	ELSEIF ll_type = wdFieldExpression THEN //For ##, @@
		ls_code = iole_document.Fields.Item[i].Code.Text
		IF Pos(ls_code,'ROMAN') > 0 THEN
			ls_text = "##"
		ELSEIF Pos(ls_code,'ALPHABETIC') > 0 THEN
			ls_text = "@@"
		ELSE
			ls_text = ""
		END IF
		IF ls_text <> "" THEN
			iole_document.Fields.Item[i].Result.Text = ls_text								
		END IF
	END IF			
Next	
Catch (Throwable th)
	MessageBox("Alert Message","Restore numbering failed!")
	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
End Try

end subroutine

public function integer of_char2num (string as_char);Long i, ll_cnt
string ls_char[] = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

ll_cnt = UpperBound(ls_char)
FOR i = 1 to ll_cnt
	IF ls_char[i] = as_char THEN
		RETURN i
	END IF	
NEXT

RETURN -1
end function

public function integer of_roman2num (string as_char);//only support 1 t0 20

Long i, ll_cnt
string ls_roman[]={"I","II","III","IV","V","VI","VII","VIII","IX", "X","XX","XXX","XL","L","LX","LXX","LXXX","XCC","C","CC","CCC","CD","D","DC","DCC","DCCC","CM"}  

ll_cnt = UpperBound(ls_roman)
FOR i = 1 to ll_cnt
	IF ls_roman[i] = as_char THEN
		RETURN i
	END IF	
NEXT

RETURN -1
end function

public function integer of_acceptall (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>of_acceptall()
// $<arguments>
//		string	as_filename		
// $<returns> integer
// $<description> Accept all revisions for the Word file.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 04/24/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_temp_file
OLEObject lole_word

ls_temp_file = gs_dir_path + gs_DefDirName + "\Agreement\Manager\compare_temp_accept.doc"

//Setpointer(Hourglass!)
IF Len(Trim(as_filename)) < 1 THEN RETURN -1

filecopy(as_filename,ls_temp_file,true)

//Create a new Word object	and open the Word document.
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word //Alfee 01.17.2008
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN -1
END IF

TRY
	lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008	
	lole_word.Application.Documents.Open(ls_temp_file,false,true)
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	gnv_shell.of_delete_recent( ls_temp_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	lole_word.Visible = FALSE

	//Accept all revisions
	If lole_word.ActiveDocument.Revisions.Count >= 1 Then 
//		 lole_word.ActiveDocument.Revisions.AcceptAll()
		 lole_word.ActiveDocument.AcceptAllRevisions()
	END IF

	//Save to target file.
	gnv_rights.of_check_dir_right(as_filename, true, 'Word Save')
	lole_word.ActiveDocument.saveas(as_filename,0,false,'',false)
	gnv_shell.of_delete_recent( as_filename, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
	lole_word.Quit(wdDoNotSaveChanges)
	lole_word.DisconnectObject( )
	destroy lole_word


CATCH(Throwable th)
	MessageBox("Alert Message","Failed to accept all revisions!")
	if isvalid(lole_word) then
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject()
		destroy lole_word
		Return -1
	end if
END TRY
Return 1
end function

public function boolean of_ismerged ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_ismerged()
// $<arguments>(None)
// $<returns> boolean
// $<description>Whether the document has been merged
//////////////////////////////////////////////////////////////////////
// $<add> by Alfee 04.28.2007
//////////////////////////////////////////////////////////////////////

//--------- Modified by Alfee on 09.18.2008-----------------------
//<$Reason>Repeatedly accessing the document saved property may lead an 
//<$Reason>error while 2 or more windows with Office OCX controls opened.

RETURN ib_merged 

/*
Boolean lb_statuschanged_ori
Boolean lb_rtn

if not ib_Initialized then return false

IF iole_object.doctype <> 1 THEN RETURN false //added by Alfee 08.29.2007

try
	//---------Begin Modified by Alfee 05.15.2007---------------
	lb_statuschanged_ori	= of_isstatuschanged()
	of_setstatuschanged(FALSE) 
	//--------Begin Modified by alfee 03.28.2008-----------------------------
	//<$Reason>Accessing this property will change the saved property to false
	Boolean lb_saved 
	lb_saved = of_getsaved()
	lb_rtn = (String(iole_document.BuiltInDocumentProperties.item[wdPropertyKeywords].value) = 'merged')
	of_setsaved(lb_saved)	
	//lb_rtn = (String(iole_document.BuiltInDocumentProperties.item[wdPropertyKeywords].value) = 'merged')
	//--------End Modified ---------------------------------------------------
	of_setstatuschanged(lb_statuschanged_ori)
	return lb_rtn
	//return(String(iole_document.BuiltInDocumentProperties.item[wdPropertyKeywords].value) = 'merged')	
	//---------End Modified------------------------------------
catch(Throwable th)
	Messagebox('Warning','Failed to get merge status due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return false
end try
*/
//-----------------------End Modified ------------------------------------------------
end function

public function integer of_setmergestatus (boolean ab_merged);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_setmergestatus()
// $<arguments>(None)
// $<returns> boolean
// $<description>Set the document merge status
//////////////////////////////////////////////////////////////////////
// $<add> by Alfee 04.28.2007
//////////////////////////////////////////////////////////////////////
if not ib_Initialized then return -1
Boolean lb_statuschanged_ori 

try
	//----Begin Added by alfee 05.15.2007----------
	lb_statuschanged_ori = of_isstatuschanged()
	of_setstatuschanged(FALSE)
	//----End Added--------------------------------
	if ab_merged then
		iole_document.BuiltInDocumentProperties.item[wdPropertyKeywords].value = 'merged'
	else
		iole_document.BuiltInDocumentProperties.item[wdPropertyKeywords].value = ''
	end if
	ib_merged = ab_merged //Alfee 09.18.2008	
	//----Begin Added by alfee 05.15.2007----------
	of_setstatuschanged(lb_statuschanged_ori)
	//----End Added--------------------------------
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to get merge status due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function boolean of_ismerged (oleobject aole_word);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_ismerged()
// $<arguments>oleobject aole_word
// $<returns> boolean
// $<description>Whether the document has been merged
//////////////////////////////////////////////////////////////////////
// $<add> by Alfee 04.28.2007
//////////////////////////////////////////////////////////////////////
If Not IsValid(aole_word) Then Return false

try
	return(String(aole_word.BuiltInDocumentProperties.item[wdPropertyKeywords].value) = 'merged')
catch(Throwable th)
	Messagebox('Warning','Failed to get merge status due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return false
end try


end function

public function integer of_setmergestatus (oleobject aole_word, boolean ab_merged);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_setmergestatus()
// $<arguments>oleobject aloe_word; boolean ab_merged
// $<returns> boolean
// $<description>Set the document merge status
//////////////////////////////////////////////////////////////////////
// $<add> by Alfee 04.28.2007
//////////////////////////////////////////////////////////////////////

//if not ib_Initialized then return -1 //Commented By Ken.Guo 2010-07-01

try
	if ab_merged then
		aole_word.BuiltInDocumentProperties.item[wdPropertyKeywords].value = 'merged'
	else
		aole_word.BuiltInDocumentProperties.item[wdPropertyKeywords].value = ''
	end if
	return 1
catch(Throwable th)
	Messagebox('Warning','Failed to get merge status due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function integer of_autonumbering (string as_file);//////////////////////////////////////////////////////////////////////
// $<add> 04.28.2007 by Alfee check numbering
//////////////////////////////////////////////////////////////////////
OLEObject lole_word

//Setpointer(Hourglass!)
IF Not FileExists(as_file) THEN RETURN -1

//Create a new Word object	and open the Word document.
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word //Alfee 01.17.2008
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN -1
END IF

TRY
	lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
	lole_word.Application.Documents.Open(as_file,false,false)
	gnv_shell.of_delete_recent( as_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	lole_word.Visible = FALSE
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.

	//unprotect the document if needed - Alfee 03.14.2008
	//inv_word_util.of_unprotect_doc( lole_word.ActiveDocument)	
//	IF inv_word_util.of_unprotect_doc(lole_word.ActiveDocument) = -1 THEN //Alfee 10.08.2008
	IF inv_word_util.of_unprotect_doc(lole_word.ActiveDocument, False) = -1 THEN //Added By Mark Lee 05/28/2013 support to unprotect  the document.
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
		RETURN -1
	END IF		
	
	lole_word.ActiveDocument.TrackRevisions = false
	If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
	
	//Numbering
	inv_word_util.of_preview(lole_word.ActiveDocument, True)
	
	lole_word.ActiveDocument.saveas(as_file,0,false,'',false)
	gnv_shell.of_delete_recent( as_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
CATCH(Throwable th)
	MessageBox("Alert Message","Auto numbering in document failed!")
	if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	if isvalid(lole_word) then
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
	end if
END TRY
	
//Quit Word application
If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
lole_word.Quit(wdDoNotSaveChanges)
lole_word.DisconnectObject( )
destroy lole_word

Return 1
end function

public function boolean of_istrackon ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_istrackon()
// $<arguments>
//	$<returns> Boolean
// $<description>Is track changes on
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
IF not ib_Initialized  THEN RETURN FALSE

Try
	gnv_word_utility.of_modify_word_property( iole_document)	//Added By Mark Lee 06/20/2013 change for office 2013.
	RETURN iole_document.TrackRevisions
Catch(OLERuntimeError err1)
	RETURN FALSE
End Try

end function

public function boolean of_isshowreviewmenu ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_isshowreviewmenu()
// $<arguments>
//	$<returns> Boolean
// $<description>Is review menu enabled
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
IF not ib_Initialized  THEN RETURN FALSE

Try
	RETURN iole_object.IsShowToolMenu
Catch(OLERuntimeError err1)
	RETURN FALSE
End Try

end function

public function integer of_trackchange_ini ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_trackchange()_ini
// $<arguments>
// $<returns> integer
// $<description>
// $<description>Initilize the Track Changes opition.
//////////////////////////////////////////////////////////////////////
// $<add> 03.13.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
long ll_cnt,i
boolean lb_statuschanged_ori 

IF not ib_Initialized  THEN RETURN -1

lb_statuschanged_ori = of_isstatuschanged() 
of_setstatuschanged(FALSE)

Try
	gnv_word_utility.of_modify_word_property( iole_document)	//Added By Mark Lee 06/20/2013 change for office 2013.	
	//iole_object.IsShowToolMenu = TRUE //commented by Alfee 08.03.2007
	iole_document.TrackRevisions = FALSE
Catch (Throwable th)
	MessageBox("Alert Message","Initilize the Track Change opition failed!")
	of_setstatuschanged(lb_statuschanged_ori)	
	RETURN -1
End Try

of_setstatuschanged(lb_statuschanged_ori)

RETURN 1

end function

public function integer of_acceptchanges (integer ai_index);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_acceptchanges()
// $<arguments>integer ai_index
// $<returns> integer
// $<description>Accept changes in word document
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Long ll_revcount 

try
	//---------Begin Modified by Alfee 05.11.2007-----------------------
	ll_revcount = iole_document.Revisions.Count
	
	IF ll_revcount = 1 THEN  //for a VBA bug - Alfee 03.17.2008
		iole_document.AcceptAllRevisions() 
		RETURN 1
	END IF
	
	IF ai_index > ll_revcount THEN RETURN -1 //
	IF	iole_document.ActiveWindow.Selection.Range.Start = iole_document.ActiveWindow.Selection.Range.End THEN	
		IF ai_index > 0 THEN iole_document.Revisions.Item[ai_index].Accept()
	ELSE
		IF	iole_document.ActiveWindow.Selection.Range.Revisions.Count > 0 THEN
			iole_document.ActiveWindow.Selection.Range.Revisions.AcceptAll()
		END IF
	END IF
	IF ll_revcount <> iole_document.Revisions.Count + 1 THEN RETURN -1 //refresh map - 03.17.2008
	//IF ll_revcount = iole_document.Revisions.Count THEN RETURN -1
	//IF	iole_document.ActiveWindow.Selection.Range.Revisions.Count > 0 THEN
	//		iole_document.ActiveWindow.Selection.Range.Revisions.AcceptAll()
	//END IF
	RETURN 1
	//---------End Modified----------------------------------------------	
catch(Throwable th)
	Messagebox('Warning','Failed to accept changes due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	RETURN -1
end try
end function

public function integer of_rejectchanges (integer ai_index);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_rejectchanges()
// $<arguments>integer ai_index
// $<returns> integer
// $<description>Reject changes in word document
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Long ll_revcount

TRY
	ll_revcount = iole_document.Revisions.Count
	
	IF ll_revcount = 1 THEN  //for a VBA bug - Alfee 03.17.2008
		iole_document.RejectAllRevisions() 
		RETURN 1
	END IF
	
	IF ai_index > ll_revcount THEN RETURN -1 //
	//---------Begin Modified by Alfee 05.11.2007-----------------------
	IF	iole_document.ActiveWindow.Selection.Range.Start = iole_document.ActiveWindow.Selection.Range.End THEN	
		IF ai_index > 0 THEN iole_document.Revisions.Item[ai_index].Reject()
	ELSE
		IF	iole_document.ActiveWindow.Selection.Range.Revisions.Count > 0 THEN
		iole_document.ActiveWindow.Selection.Range.Revisions.RejectAll()
		END IF
	END IF
	//IF	iole_document.ActiveWindow.Selection.Range.Revisions.Count > 0 THEN
	//		iole_document.ActiveWindow.Selection.Range.Revisions.RejectAll()
	//END IF
	//IF ll_revcount = iole_document.Revisions.Count THEN RETURN -1
	IF ll_revcount <> iole_document.Revisions.Count + 1 THEN RETURN -1 //refresh map - 03.17.2008
	//---------End Modified----------------------------------------------		
	RETURN 1
catch(Throwable th)
	Messagebox('Warning','Failed to reject changes due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	RETURN -1
end try


end function

public function boolean of_isselectedrevision (integer ai_index);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_isselectedrevision()
// $<arguments>integer ai_index
// $<returns> integer
// $<description>Whether the selected area in document is for the specified revision 
//////////////////////////////////////////////////////////////////////
// $<add> 05.11.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Boolean lb_rtn = FALSE
TRY
	IF ai_index < 1 or ai_index > iole_document.Revisions.Count THEN RETURN FALSE

	IF	iole_document.Revisions.Item[ai_index].Range.InRange(iole_document.ActiveWindow.Selection.Range) AND & 
		iole_document.ActiveWindow.Selection.Range.Revisions.Count = 1 THEN	
		lb_rtn = TRUE
	ELSEIF iole_document.ActiveWindow.Selection.Range.InRange(iole_document.Revisions.Item[ai_index].Range) THEN
		lb_rtn = TRUE	
	ELSEIF iole_document.ActiveWindow.Selection.Range.Start = iole_document.ActiveWindow.Selection.Range.END OR &
  	 	iole_document.Revisions.Item[ai_index].Range.Start = iole_document.Revisions.Item[ai_index].Range.END THEN
		lb_rtn = TRUE	
	END IF
	
	RETURN lb_rtn
	
Catch (Throwable th)
	Messagebox('Warning','Failed to accept changes due to: '+th.text+'~r~n~r~nPlease check whether your Office Viewer OCX has been installed correctly.',exclamation!)
	RETURN FALSE
End TRY
end function

public function integer of_getbookmarkscount ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_getbookmarkscount()
// $<arguments>
// $<returns> integer
// $<description>Get bookmarks' count in document
//////////////////////////////////////////////////////////////////////
// $<add> 05.11.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
TRY
	RETURN iole_document.Content.Bookmarks.Count 
Catch (Throwable th)
	Messagebox('Warning','Failed to get bookmark count due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	RETURN -1
End TRY
end function

public function boolean of_havemergefield (long al_clauseid[]);//Added by Alfee 06.22.2007

Long ll_cnt, ll_fldcnt, i, j
String ls_bookmark
OLEObject lole_bookmarks, lole_fields

IF Not ib_Initialized  THEN RETURN FALSE

ll_cnt = UpperBound(al_clauseid)
IF ll_cnt < 1 THEN RETURN FALSE

lole_bookmarks = iole_document.bookmarks
IF lole_bookmarks.count < 1 THEN RETURN FALSE

FOR i = 1 TO ll_cnt
	ls_bookmark = "clause_" + String(al_clauseid[i])
	IF NOT lole_bookmarks.exists(ls_bookmark) THEN Continue
	lole_fields = iole_document.Bookmarks.Item(ls_bookmark).Range.Fields
	ll_fldcnt = lole_fields.Count 
	FOR j = 1 TO  ll_fldcnt
		IF lole_fields.Item[j].Type = wdFieldMergeField Then 
			RETURN TRUE
		END IF			
	NEXT	
NEXT

RETURN FALSE
end function

public function integer of_getnewclauseid (long al_clauseid[], ref long al_newclauseid[]);//Added by Alfee 06.22.2007
Long ll_cnt, i, j
String ls_bookmark

IF Not ib_Initialized  THEN RETURN -1

ll_cnt = UpperBound(al_clauseid)
IF ll_cnt < 1 THEN RETURN -1

IF iole_document.bookmarks.count < 1 THEN 
	al_newclauseid = al_clauseid
	RETURN 1
END IF

j = 1
FOR i = 1 TO ll_cnt
	ls_bookmark = "clause_" + String(al_clauseid[i])
	IF Not iole_document.bookmarks.Exists(ls_bookmark) THEN 
		al_newclauseid[j] = al_clauseid[i]
		j ++
	END IF
NEXT

RETURN 1
end function

public subroutine of_getchanges ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovle_utils.of_getchanges()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>Get change list for word document
//////////////////////////////////////////////////////////////////////
// $<add> 01.15.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
//Commented by Alfee 08.09.2007 This fun is obsolete for performance tuning purpose

//Integer i, li_count, li_page, li_line, li_col, li_charcount
//String ls_desc
//String ls_author //revision author
//ids_changes.Reset() //
//IF iole_object.DocType <> 1 THEN RETURN ids_changes
//
//li_count = iole_document.Revisions.Count
//IF li_count < 1 THEN
//	RETURN ids_changes;
//END IF
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 24-03-2007 By: Ken.Guo
////$<reason> Add progress bar when refresh changes.
//if Not isvalid( w_infodisp ) then open(w_infodisp)
//if isvalid(w_infodisp) then w_infodisp.title = 'Building modification list, Please stand by'
//if isvalid(w_infodisp) then w_infodisp.Center = TRUE
//if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
//if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
//if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
//if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Building modification list, Please stand by!'
//if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,li_count)
////---------------------------- APPEON END ----------------------------
////SetPointer( HourGlass! )
//TRY
//	oleobject lole_revisions,lole_range
//	lole_revisions = iole_document.Revisions
//	FOR i = 1 TO li_count	
//		//refresh rate of progress
//		if isvalid(w_infodisp) then 
//			w_infodisp.wf_step_pbar(1)
//			//w_infodisp.st_1.text = 'Building ' + string(i) + ' of ' + string(li_count)+' Please stand by!'
//		end if			
//		lole_range = lole_revisions.Item[i].Range
//		li_page = lole_range.Information[wdActiveEndPageNumber]
//		//--------Begin added by Alfee 05.25.2007--------------------------------------------
//		//<$Reason>In some cases, for the first time, running function of range.Information[...] 
//		//will cause the value of revisions.count changed, for example, while some time fields 
//		//existed in the document, it may be a Word VBA's bug.
//		If lole_revisions.Count <> li_count Then
//			li_count = lole_revisions.Count
//			i = 0
//			Continue
//		End If
//		//--------End Added -----------------------------------------------------------------
//		li_line = lole_range.Information[wdFirstCharacterLineNumber]	
//		li_col  = lole_range.Start	
//		ls_author = lole_revisions.Item[i].author
//		li_charcount = lole_range.End - lole_range.Start
//		ls_desc = ls_author+ ": Page " + string(li_page) + "->Line " + String(li_line) + "->" +String(li_charcount) + " Char(s)"	
//
//		ids_changes.InsertRow( 0 )	
//		ids_changes.SetItem(i, "page_no", li_page)
//		ids_changes.SetItem(i, "line_no", li_line)
//		ids_changes.SetItem(i, "col_no", li_col)
//		ids_changes.SetItem(i, "character_count",li_charcount)
//		ids_changes.SetItem(i, "description",ls_desc)	
//
//	NEXT
//CATCH(Throwable th)
//	MessageBox("Alert Message","Get change list on document failed!")
//	if isvalid(w_infodisp) then close(w_infodisp)
//END TRY
//if isvalid(w_infodisp) then close(w_infodisp)
//
////messagebox('cpu time:',cpu() - ll_cpu)
//RETURN ids_changes

end subroutine

public function long of_getchanges (integer ai_revindex, ref integer ai_newpageno, ref integer ai_newpagecnt, ref datawindow adw_changes);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovle_utils.of_getchanges()
// $<arguments>
//		value	integer	ai_revindex
//		Reference integer ai_newpageno, ai_newpagecnt
//		Reference datawindow adw_changes
// $<returns> DataStore
// $<description>Refresh change list by the specified index in Word document
//////////////////////////////////////////////////////////////////////
// $<add> 08.09.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Integer i, li_count, li_page, li_line, li_col, li_charcount, li_nextrev
Integer li_pagecnt, li_pageno
Long ll_row, ll_rowcnt
String ls_desc, ls_author, ls_text
Boolean lb_in_progress = FALSE
OleObject lole_revisions, lole_range

TRY
	
//Get & check revisions
IF iole_object.DocType <> 1 THEN RETURN -1
lole_revisions = iole_document.Revisions
li_count = lole_revisions.Count
IF li_count < 1 THEN 
	//If no revison, reset change list & page info
	adw_changes.Reset()
	ai_newpageno = 0
	ai_newpagecnt = 0
	RETURN 1
END IF

//Delete the specified change row
li_pageno = ai_newpageno
//IF IsValid(gw_contract) THEN ii_changes = gw_contract.ii_changes //Commented By Ken.Guo 2010-08-03. use this object's var
IF li_pageno < 1 or ai_revindex < 1 or ii_changes < 1 THEN RETURN -1

ll_row = Mod(ai_revindex, ii_changes) 
IF ll_row = 0 THEN ll_row = ii_changes

ll_rowcnt = adw_changes.rowcount()
IF ll_row > ll_rowcnt THEN RETURN -1
IF adw_changes.DeleteRow(ll_row) <> 1 THEN RETURN -1

//Add an additional change into the DW
ll_rowcnt = adw_changes.rowcount()
li_nextrev = ll_rowcnt + (li_pageno - 1) * ii_changes + 1
IF li_nextrev > li_count THEN 
	RETURN ll_rowcnt 	//If no more additional changes, return row count
END IF

lole_range = lole_revisions.Item[li_nextrev].Range
li_page = lole_range.Information[wdActiveEndPageNumber]
//--------Begin added by Alfee 05.25.2007--------------------------------------------
//<$Reason>In some cases, running function of range.Information[...] in first time 
//will cause the value of revisions.count changed, e.g. some time fields included in 
//the document, it may be a Word VBA's bug. 
IF lole_revisions.Count <> li_count THEN 
	li_count = lole_revisions.Count
	IF li_nextrev > li_count THEN 
		RETURN ll_rowcnt 	//If no more additional changes, return row count
	ELSE
		lole_range = lole_revisions.Item[li_nextrev].Range
		li_page = lole_range.Information[wdActiveEndPageNumber]
	END IF
END IF
//--------End Added -----------------------------------------------------------------

li_line = lole_range.Information[wdFirstCharacterLineNumber]	
li_col  = lole_range.Start	
ls_author = lole_revisions.Item[li_nextrev].author
li_charcount = lole_range.End - li_col
ls_desc = ls_author+ ": Page " + string(li_page) + "->Line " + String(li_line) + "->" +String(li_charcount) + " Char(s)"	

ll_row = adw_changes.InsertRow( 0 )	
adw_changes.SetItem(ll_row, "page_no", li_page)
adw_changes.SetItem(ll_row, "line_no", li_line)
adw_changes.SetItem(ll_row, "col_no", li_col)
adw_changes.SetItem(ll_row, "character_count",li_charcount)
adw_changes.SetItem(ll_row, "description",ls_desc)		

//Return the re-caculated current page no and count
li_pagecnt = li_count / ii_changes
IF Mod(li_count, ii_changes) <> 0 THEN li_pagecnt ++
ai_newpageno = li_pageno
ai_newpagecnt = li_pagecnt
	
CATCH(Throwable th)
	IF isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) 
	MessageBox("Alert Message","Get change list on document failed!")
END TRY

RETURN 1

end function

public function long of_getchanges (ref integer ai_newpageno, ref integer ai_newpagecnt, ref datawindow adw_changes);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovle_utils.of_getchanges()
// $<arguments>
//		Reference integer ai_newpageno, ai_newpagecnt
//		Reference datawindow adw_changes
// $<returns> DataStore
// $<description>Get current change list for word document
//////////////////////////////////////////////////////////////////////
// $<add> 07.23.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Integer i, li_count, li_page, li_line, li_col, li_charcount, li_pageno
Integer li_changes, li_change_start, li_change_end, li_pagecnt
Integer li_position, li_setstep, li_MaxPosition
Long ll_row
String ls_desc, ls_author, ls_text
Boolean lb_in_progress = FALSE

//Reset change list
adw_changes.Reset()

IF iole_object.DocType <> 1 THEN RETURN -1
//IF IsValid(gw_contract) THEN li_changes = gw_contract.ii_changes
li_changes = ii_changes
IF li_changes < 1 THEN RETURN -1

//Get revisons' count
li_count = iole_document.Revisions.Count
IF li_count < 1 THEN 
	ai_newpageno = 0
	ai_newpagecnt = 0
	RETURN 1
END IF

//Adjust the page info
li_pageno = ai_newpageno
IF li_pageno < 1 THEN li_pageno = 1 //default to the 1st page
li_pagecnt = li_count / li_changes
IF Mod(li_count, li_changes) <> 0 THEN li_pagecnt ++
IF li_pageno > li_pagecnt THEN li_pageno = li_pagecnt

//Get start & end no. in the current change page
li_change_start = (li_pageno - 1) * li_changes + 1
li_change_end = li_pageno * li_changes
IF li_change_end > li_count THEN li_change_end = li_count 

//Add progress bar when refresh changes.
//--------Begin Modified by Alfee 07.24.2007-----------------
/*IF Not isvalid( w_infodisp ) THEN open(w_infodisp)
IF isvalid(w_infodisp) THEN
	w_infodisp.title = 'Building modification list, Please stand by'
   w_infodisp.Center = TRUE
   w_infodisp.st_complete.visible = false
   w_infodisp.st_3.visible = false
   w_infodisp.st_information.visible = false
   w_infodisp.st_1.text = 'Building modification list, Please stand by!'
   w_infodisp.wf_set_min_max(1,li_changes)
END IF*/
IF IsValid(w_appeon_gifofwait) THEN
	lb_in_progress = TRUE
	ls_text = w_appeon_gifofwait.st_1.Text
	li_position = w_appeon_gifofwait.hpb_1.Position
	li_maxposition = w_appeon_gifofwait.hpb_1.MaxPosition 
ELSE
	Open(w_appeon_gifofwait)
END IF
IF isvalid(w_appeon_gifofwait) THEN 
	w_appeon_gifofwait.st_1.Text = 'Building Change List...'
//	IF isValid(gw_contract) THEN w_appeon_gifofwait.hpb_1.MaxPosition = gw_contract.ii_changes * 10
	w_appeon_gifofwait.hpb_1.MaxPosition = ii_changes * 10
	w_appeon_gifofwait.hpb_1.Position = 0	
END IF
//--------End Modified --------------------------------------

//Get and display the changes' info.
TRY
	Long ll_range_start //Alfee 01.09.2008
	OleObject lole_start_range	//Alfee 01.09.2008
	OleObject lole_revisions,lole_range 
	lole_revisions = iole_document.Revisions
	FOR i = li_change_start TO li_change_end
		//IF isvalid(w_infodisp) THEN w_infodisp.wf_step_pbar(1)//refresh rate of progress
		IF isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.Stepit() //Alfee 07.24.2007
		lole_range = lole_revisions.Item[i].Range
		//---------Begin Modified by Alfee 01.09.2008---------------
		ll_range_start = lole_range.Start
		IF ll_range_start >= 0 THEN 
			lole_start_range = iole_document.Range(ll_range_start,ll_range_start)
			li_page = lole_start_range.Information[wdActiveEndPageNumber]
		END IF	
		//li_page = lole_range.Information[wdActiveEndPageNumber]
		//---------End Modified ------------------------------------
		//--------Begin added by Alfee 05.25.2007--------------------------------------------
		//<$Reason>In some cases, running function of range.Information[...] in first time 
		//will cause the value of revisions.count changed, e.g. some time fields included in 
		//the document, it may be a Word VBA's bug.
		If lole_revisions.Count <> li_count Then
			li_count = lole_revisions.Count			
			IF li_change_start > li_count THEN RETURN -1
			IF li_change_end > li_count THEN li_change_end = li_count			
			i = li_change_start - 1
			Continue
		End If
		//--------End Added -----------------------------------------------------------------
		//---------Begin Modified by Alfee 01.09.2008---------------
		IF ll_range_start >= 0 THEN li_line = lole_start_range.Information[wdFirstCharacterLineNumber]	
		//li_line = lole_range.Information[wdFirstCharacterLineNumber]	
		//---------End Modified ------------------------------------		
		li_col  = lole_range.Start	
		ls_author = lole_revisions.Item[i].author
		li_charcount = lole_range.End - li_col
		ls_desc = ls_author+ ": Page " + string(li_page) + "->Line " + String(li_line) + "->" +String(li_charcount) + " Char(s)"	

		ll_row = adw_changes.InsertRow( 0 )	
		adw_changes.SetItem(ll_row, "page_no", li_page)
		adw_changes.SetItem(ll_row, "line_no", li_line)
		adw_changes.SetItem(ll_row, "col_no", li_col)
		adw_changes.SetItem(ll_row, "character_count",li_charcount)
		adw_changes.SetItem(ll_row, "description",ls_desc)	
	NEXT
	
	//Get and return the current page no and page count
	li_pagecnt = li_count / li_changes
	IF Mod(li_count, li_changes) <> 0 THEN li_pagecnt ++
	ai_newpageno = li_pageno
	ai_newpagecnt = li_pagecnt
	
CATCH(Throwable th)
	//IF IsValid(w_infodisp) THEN Close(w_infodisp)
	IF isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) //Alfee 07.24.2007
	MessageBox("Alert Message","Get change list on document failed!")
END TRY

//---------Begin Modified by Alfee 07.24.2007-----------
//IF IsValid(w_infodisp) THEN Close(w_infodisp)
IF isvalid(w_appeon_gifofwait) THEN
	IF lb_in_progress THEN  
		w_appeon_gifofwait.st_1.Text = ls_text
		w_appeon_gifofwait.hpb_1.MaxPosition = li_maxposition 		
		w_appeon_gifofwait.hpb_1.Position = li_position
	ELSE
		Close(w_appeon_gifofwait)
	END IF
END IF
//--------End Modified ----------------------------------

RETURN 1

end function

public subroutine of_ini_expinfo ();//Initilize the last export info - added by alfee 09.06.2007
il_export_ctxid = -1
il_export_id = -1
is_export_file = ""
end subroutine

public function integer of_undoclear ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_undoclear()
// $<arguments>
// $<returns> integer
// $<description>UndoClear in document
//////////////////////////////////////////////////////////////////////
// $<add> 09.07.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

iole_document.UndoClear()

RETURN 1
end function

public function boolean of_havemergefield (string as_right);//Whether merge fields are existed in clauses of document whcih are assigned to the special right.
//Added by Alfee 09.21.2007

Long ll_cnt, ll_found, i, ll_clauseid[]

//Return if current document not opened
If iole_object.DocType <> 1 THEN RETURN FALSE

//Return if no any meet clause
ll_cnt = ids_category.RowCount()
IF ll_cnt < 1 THEN RETURN FALSE
ll_found = ids_category.Find("Lower(Description) = '" + Lower(as_right) + "'", 1, ll_cnt)
IF ll_found < 0 THEN RETURN FALSE

//Get the meet clauses
i = 1
DO WHILE ll_found > 0
	ll_clauseid[i] = ids_category.GetItemNumber(ll_found, "ctx_acp_clause_id")
	i ++
	ll_found ++
	IF ll_found > ll_cnt THEN EXIT
	ll_found = ids_category.Find("Lower(Description) = '" + Lower(as_right) + "'", ll_found, ll_cnt)
LOOP	

//Determine merge fields included or not
RETURN of_havemergefield(ll_clauseid)

end function

public function boolean of_refresh_clauses (datastore ads_clause_rule_results);//Clear invalid clauses based on dynamic adding clause rules' results
//Added by Alfee 11.12.2007
Long i, j, ll_cnt, ll_clause_id
String ls_bookmark
Boolean lb_changed = FALSE

IF iole_object.doctype <> 1 THEN RETURN FALSE

ll_cnt = ads_clause_rule_results.RowCount()
IF ll_cnt < 1 THEN RETURN FALSE

TRY
	//Clear the invalid clauses
	FOR i = 1 TO ll_cnt
		//continue if rules' result is not zero
		IF ads_clause_rule_results.GetItemNumber(i, "rules_result") <> 0 THEN CONTINUE
		//clear invalid clauses according to the adding rules
		ll_clause_id = ads_clause_rule_results.GetItemNumber(i, "ctx_acp_clause_id")
		ls_bookmark = "clause_" + String(ll_clause_id)
		IF iole_document.content.bookmarks.Exists(ls_bookmark) THEN
			iole_document.content.bookmarks.Item(ls_bookmark).Range.Delete()
			IF iole_document.content.bookmarks.Exists(ls_bookmark) Then
				iole_document.content.bookmarks.Item(ls_bookmark).delete()
				lb_changed = TRUE
			End If
		END IF	
	NEXT

CATCH (Throwable th)
	RETURN FALSE
END TRY

RETURN lb_changed


end function

public function boolean of_refresh_clausemap (ref datawindow adw_clausemap);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_refresh_clausemap()
// $<arguments>datawindow adw_clausemap
// $<arguments>boolean ab_refresh_clauserights
// $<returns> boolean true - changed; false - not changed
// $<description>Refresh clause map dw according to the current document
//////////////////////////////////////////////////////////////////////
// $<add> 11.12.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Integer i,j, li_rtn
Long ll_doc_id, ll_clause_id, ll_cnt
Decimal ldec_revision
Boolean lb_found, lb_changed = FALSE
String ls_bookmark[]

//If no clause for new revision, then return
ll_cnt = adw_clausemap.RowCount()
IF ll_cnt < 1 THEN RETURN FALSE

//Get bookmarks from document
of_getbookmarks(ls_bookmark)

//update adw_clausemap according to bookmarks
For i = 1 to ll_cnt
	ll_clause_id = adw_clausemap.getitemnumber(i,"ctx_acp_clause_id")
	lb_found = False
	For j =  1 to Upperbound(ls_bookmark)
		IF ls_bookmark[j] = "clause_" + string(ll_clause_id) THEN
			lb_found = True
			EXIT				
		END IF
	Next
	IF not lb_found THEN
		adw_clausemap.DeleteRow(i)
		lb_changed = TRUE
		i = i - 1
		ll_cnt = ll_cnt -1
	END IF
NEXT

RETURN lb_changed

end function

public function integer of_setreviewstatus (boolean ab_allow_approve_reject);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_setreviewstatus()
// $<arguments>
//		value
// $<returns> integer
// $<description>Set review toolbar according to user rights on document level
// $<description>note:if readonly, the review toolbar need't set
//////////////////////////////////////////////////////////////////////
// $<add> 01.24.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//Set review menu & toolbar according to user rights on document level
CHOOSE CASE lower(is_doc_right)
	CASE "editing with approval"
		of_trackchange(TRUE, FALSE)
	CASE "full access","" //"", by alfee at 03.13.2007
		//---Begin Added by Alfee 11.22.2007---		
		IF NOT ab_allow_approve_reject THEN //Set in role painter
			//Set for disabling track changes forcibly
			ib_trackchange_by_sys = TRUE 
			//Hide review menu and disable track changes
			of_trackchange(FALSE, FALSE) 
			RETURN 1
		END IF
		//---End Added ------------------------
		of_trackchange(FALSE, TRUE)		
	CASE ELSE
		of_trackchange(FALSE, FALSE)
END CHOOSE

RETURN 1
end function

public function integer of_setreviewstatus (string as_clause_right, boolean ab_allow_approve_reject);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_setreviewstatus()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>Set review toolbar according to user rights on clause level
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

IF lower(is_doc_right) = "no editing" or lower(is_doc_right) = "no access" THEN RETURN -1 
IF ib_readonly THEN RETURN -1

//if editing with approval rights on document
IF lower(is_doc_right) = "editing with approval" THEN
	CHOOSE CASE lower(as_clause_right)
		CASE "editing with approval","no adding","adding with approval","full access"
			of_trackchange(TRUE, FALSE)
		CASE "no editing"
			of_trackchange(FALSE, FALSE)
		CASE ELSE
			of_trackchange(TRUE, FALSE) 
	END CHOOSE
//if full access rights or no rights setting on document
ELSEIF lower(is_doc_right) = "full access" or lower(is_doc_right) = ""THEN
	CHOOSE CASE lower(as_clause_right)
		CASE "editing with approval","no adding","adding with approval" 
			of_trackchange(TRUE, FALSE)
		CASE "no editing"
			of_trackchange(FALSE, FALSE)
		CASE ELSE //full access
			//---Begin Added by Alfee 11.22.2007---		
			IF NOT ab_allow_approve_reject THEN //Set in role painter
				//Set for disabling track changes forcibly
				ib_trackchange_by_sys = TRUE 
				//Hide review menu and disable track changes
				of_trackchange(FALSE, FALSE) 
				RETURN 1
			END IF
			//---End Added ------------------------
			of_trackchange(FALSE, TRUE)
	END CHOOSE
END IF

RETURN 1
end function

public function integer of_unprotect_doc ();//Unprorect the document if protected - Alfee 03.10.2008
Boolean lb_statuschanged_ori

IF Not ib_Initialized  THEN RETURN -1

TRY
	
If iole_object.DocType <> 1 Then Return 1 //Added By Ken.Guo 2009-09-07.  Only for word type
	
IF iole_document.ProtectionType <> wdNoProtection Then
//--------Begin Modified by Alfee on 10.08.2008----------------------
	//Added By Mark Lee 05/28/2013
//	MessageBox("Protected Document","It's unsupported for a document to be protected.")
	MessageBox(gnv_app.iapp_object.DisplayName,"The current document is restricted from formatting and editing with a password. ~r~nYou may not be able to edit or format all or part of this document.")
	RETURN -1	
//--------End Modified ----------------------------------------------
//	lb_statuschanged_ori = of_isstatuschanged() 
//	of_setstatuschanged(FALSE)	
//	
//	iole_document.Unprotect()  //Unprotect document
//	
//	of_setstatuschanged(lb_statuschanged_ori)	
//	
//	MessageBox("Protected Document","It's unsupported for a document to be protected. The program stops the protection for this document now.")
END IF

Catch (Throwable th)
//	of_setstatuschanged(lb_statuschanged_ori)	//10.08.2008
	RETURN -1 
End Try

RETURN 1
end function

public function integer of_setsaved (boolean ab_saved);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_setsaved()
// $<arguments> boolean ab_saved
// $<returns> integer 1 - Succeeded  -1 - Failed
// $<description>Set saved property of the current word document 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.28.2008 Alfee
//////////////////////////////////////////////////////////////////////

if not ib_Initialized then return -1

try
	iole_document.saved = ab_saved
	IF iole_document.saved = ab_saved THEN 
		RETURN 1
	ELSE
		RETURN -1
	END IF
catch(Throwable th)
	Messagebox('Warning','Failed to set Saved property of the document due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return -1
end try


end function

public function boolean of_getsaved ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_getsaved()
// $<arguments> 
// $<returns> boolean true / false
// $<description>Get saved property of the current word document 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.28.2008 Alfee
//////////////////////////////////////////////////////////////////////

if not ib_Initialized then return FALSE

try

	RETURN iole_document.saved 

catch(Throwable th)
	Messagebox('Warning','Failed to get Saved property of the document due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return false
end try


end function

public function integer of_trackchange_restore (boolean ab_track, boolean ab_showmenu, boolean ab_track_by_sys);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_trackchange_restore()
// $<arguments>
//		boolean	ab_track	: Enable/Disable Track Revison Function
//		boolean	ab_showmenu	: Show/Hide Review toolbar & menu
//		boolean	ab_track_by_sys: Whether the track last time is by system
// $<returns> integer
// $<description>Restore review menu, toolbars and the track from flag
//////////////////////////////////////////////////////////////////////
// $<add> 05.06.2008 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Integer li_rtn

li_rtn = of_trackchange(ab_track, ab_showmenu)
ib_trackchange_by_sys = ab_track_by_sys 

RETURN li_rtn

end function

public function integer of_accept_reject (string as_action, string as_criteria);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_accept_reject()
// $<arguments>
// $<returns> string as_action , as_criteria
// $<description>Accept or Reject changes according to the specified criteria
//////////////////////////////////////////////////////////////////////
// $<add> by Alfee on 07.17.2008
//////////////////////////////////////////////////////////////////////
Integer ll_current_page, li_next_page, li_revtype
Long ll_current_start, ll_current_end, ll_next_start, ll_revcnt, i
Oleobject lole_revisions, lole_item

IF not ib_Initialized  THEN RETURN -1

CHOOSE CASE lower(as_criteria)
	CASE 'all format' 		
		lole_revisions = iole_document.revisions	
		ll_revcnt = lole_revisions.count 
		//Set and open the progress window
		IF ll_revcnt > 5 THEN
			IF NOT IsValid(w_appeon_gifofwait) THEN Open(w_appeon_gifofwait)
			IF isvalid(w_appeon_gifofwait) THEN 
				IF Lower(as_action) = 'accept' THEN
					w_appeon_gifofwait.st_1.Text = 'Accepting Changes...'
				ELSE
					w_appeon_gifofwait.st_1.Text = 'Rejecting Changes...'
				END IF
				w_appeon_gifofwait.hpb_1.MaxPosition = ll_revcnt * 10
				w_appeon_gifofwait.hpb_1.Position = 0	
			END IF
		END IF
		//Accept or Reject changes
		FOR i = 1 to ll_revcnt 
			IF isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.Stepit()					
			//Get the revision type
			lole_item = lole_revisions.item[i]
			li_revtype = lole_item.Type
			//Accept or reject the revision with a format change
			IF li_revtype = 1 or li_revtype = 2 or li_revtype = 9 or li_revtype = 16 or & 
				li_revtype = 18 or li_revtype = 14 or li_revtype = 15 THEN //refer to wdrevisiontype
				CONTINUE
			ELSE
				IF Lower(as_action) = 'accept' THEN		
					lole_item.Accept()
				ELSE
					lole_item.Reject()
				END IF
				IF ll_revcnt > lole_revisions.count THEN i --			
			END IF
			ll_revcnt = lole_revisions.count 
		NEXT		
		IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	CASE 'current page' 
		//Get the range of current page
		ll_current_page = iole_document.activewindow.selection.Information[wdActiveEndPageNumber]
		iole_document.activewindow.selection.Goto(wdGoToPage, wdGoToNext)	//Locate in the next page	
		li_next_page = iole_document.activewindow.selection.Information[wdActiveEndPageNumber]
		IF ll_current_page < li_next_page THEN
			ll_current_end = Long(iole_document.activewindow.selection.start) - 1
			iole_document.activewindow.selection.Goto(wdGoToPage, wdGoToPrevious) //Back to current page	
		ELSE			
			ll_current_end = iole_document.content.end
		END IF
		ll_current_start = iole_document.activewindow.selection.start

		//Accpet or Reject changes in current page
		IF ll_current_start > ll_current_end THEN RETURN -1
		IF Lower(as_action) = 'accept' THEN
			iole_document.Range(ll_current_start, ll_current_end).Revisions.AcceptAll()
		ELSE
			iole_document.Range(ll_current_start, ll_current_end).Revisions.RejectAll()
		END IF						
	CASE 'all changes'
		IF Lower(as_action) = 'accept' THEN		
			of_acceptall() 
		ELSE
			of_rejectall() 
		END IF
END CHOOSE

RETURN 1
end function

public function integer of_find_text (string as_searchtext[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_find_text()
// $<arguments>
//		value	string as_searchtext[]
// $<returns> integer
// $<description>Find the text in document - For contract global search
//////////////////////////////////////////////////////////////////////
// $<add> 07.18.2008 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Long i
Boolean lb_found

if not ib_Initialized then return -1

//iole_document.Content.Select()
FOR i = 1 to UpperBound(as_searchtext)
	IF IsNull(as_searchtext[i]) OR Len(Trim(as_searchtext[i])) < 1 THEN CONTINUE
	
	iole_document.ActiveWindow.Selection.find.ClearFormatting()	
	//expression.Execute(FindText, MatchCase, MatchWholeWord, MatchWildcards, MatchSoundsLike, MatchAllWordForms, Forward, Wrap, Format, ReplaceWith, Replace, MatchKashida, MatchDiacritics, MatchAlefHamza, MatchControl)
	lb_found = iole_document.ActiveWindow.Selection.find.Execute(as_searchtext[i], FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, wdFindContinue, FALSE, "", wdReplaceNone)
	IF lb_found THEN EXIT
NEXT

RETURN 1
end function

public function boolean of_getmergestatus ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_getmergestatus()
// $<arguments>(None)
// $<returns> boolean
// $<description>Get merge status of the current document
//////////////////////////////////////////////////////////////////////
// $<add> by Alfee 09.18.2008
//////////////////////////////////////////////////////////////////////
Boolean lb_statuschanged_ori
Boolean lb_rtn
Boolean lb_saved 

if not ib_Initialized then return false
IF iole_object.doctype <> 1 THEN RETURN false 

try

	lb_statuschanged_ori	= of_isstatuschanged()
	of_setstatuschanged(FALSE) 

	//Accessing this property will change the saved property to false
	lb_saved = of_getsaved()
	lb_rtn = (String(iole_document.BuiltInDocumentProperties.item[wdPropertyKeywords].value) = 'merged')
	of_setsaved(lb_saved)	

	of_setstatuschanged(lb_statuschanged_ori)
	return lb_rtn

catch(Throwable th)
	Messagebox('Warning','Failed to get merge status due to: '+th.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	return false
end try

end function

public function boolean of_is_newexp (long al_export_ctxid, long al_export_id, string as_export_file, ref datastore ads_export_data);//added by alfee on 10.28.2008
Boolean lb_newexport = TRUE

//Check if it's a new export
IF al_export_ctxid = il_export_ctxid AND al_export_id = il_export_id AND & 
	FileExists(is_export_file) THEN
	IF Len(Trim(as_export_file)) > 0 THEN
		lb_newexport = (as_export_file <> is_export_file)			
	ELSE
		lb_newexport = FALSE
	END IF
ELSE
	lb_newexport = TRUE
END IF 

//Set data if not a new export
IF IsValid(ads_export_data) THEN	ads_export_data = ids_export

RETURN lb_newexport
end function

public function integer of_auto_numbering ();//--------Added by alfee 04.16.2007--------------
//Update fields for numbering
Long ll_cnt, ll_cnt_sub, i, j
String ls_text, ls_code, ls_bookmark, ls_clauseid, ls_clausename
Long ll_clause_cnt, ll_found
Boolean lb_retrieved = False
Boolean lb_statuschanged_ori
Boolean lb_track, lb_showreviewmenu, lb_trackbysys //05.06.2008

lb_statuschanged_ori = of_isstatuschanged() //Alfee 05.15.2007
of_setstatuschanged(FALSE) //alfee 04.23.2007

//Unprotect document if needed - Alfee 03.10.2008
//of_unprotect_doc() 
IF of_unprotect_doc() = -1 THEN RETURN -1 //Alfee 10.08.2008

//Update fields for numbering
If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
iole_document.ActiveWindow.View.ShowFieldCodes = False
//-----------Begin Modified by Alfee 08.10.2007--------------------
//<$Reason>Stop to track changes while auto numbering
lb_track = of_istrackon()
lb_showreviewmenu = of_isshowreviewmenu()
lb_trackbysys = ib_trackchange_by_sys //Alfee 05.06.2008 
of_trackchange_ini() //Stop to track changes

inv_word_util.of_update_field(iole_document, True)

//------Begin Modified by Alfee on 05.06.2008 -------------
//Restore the track status
of_trackchange_restore(lb_track, lb_showreviewmenu, lb_trackbysys) 
//of_trackchange(lb_track, lb_showreviewmenu) //Restore the track status
//------End Modified --------------------------------------
//inv_word_util.of_update_field(iole_document, True)
//-----------End Modified ------------------------------------------

//-----Begin Commented by Alfee 06.27.2007----------------------------------------
//<$Reason>Moved to of_update_field() function
/*//Find and update clause reference marks of "<<|...|>>" in all fields
If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
ll_cnt = iole_document.Fields.Count
FOR i =  1 to ll_cnt 
	//Get the referenced clause's bookmark
	IF iole_document.Fields.Item[i].type = wdFieldHyperlink THEN
		ls_code = iole_document.Fields.Item[i].Code.Text
		ls_code = Trim(Mid(Trim(ls_code), Len("HYPERLINK \l") + 1))
		IF Pos(ls_code,"\*") > 0 THEN	
			ls_bookmark = Trim(Left(ls_code, Pos(ls_code,"\*") - 1))
		END IF
		IF Pos(ls_bookmark, "clause_") < 1 THEN CONTINUE 	//added by alfee 05.05.2007

		IF iole_document.bookmarks.Exists(ls_bookmark) THEN
			//Find numbering in the found reference clause
			ll_cnt_sub = iole_document.Bookmarks.Item(ls_bookmark).Range.Fields.Count
			FOR j = 1 TO ll_cnt_sub
				ls_code = iole_document.Bookmarks.Item(ls_bookmark).Range.Fields.Item[j].Code.Text
				IF Pos(ls_code, "article") > 0 or Pos(ls_code, "schedule") > 0 THEN 
					//Update reference mark with the clause numbering
					ls_text= iole_document.Bookmarks.Item(ls_bookmark).Range.Fields.Item[j].Result.Text	
					iole_document.Fields.Item[i].Result.Text = ls_text
					EXIT
				END IF
			NEXT
		ELSE
			//Restore reference mark's text with the clause name
			//---------Added by Alfee 05.05.2007-----------------------------------------
			IF Not lb_retrieved THEN 
				ll_clause_cnt = ids_clausename.Retrieve()
				lb_retrieved = True
			END IF
			IF ll_clause_cnt > 0 Then
				ls_clauseid = Mid(ls_bookmark, Pos(ls_bookmark, "clause_") + 7)
				ll_found = ids_clausename.Find("ctx_acp_clause_id = " + ls_clauseid, 1, ll_clause_cnt)
				IF ll_found > 0 THEN 
					ls_clausename = ids_clausename.GetItemString(ll_found, "clause_name")
					iole_document.Fields.Item[i].Result.Text = "<<|" + ls_clausename + "|>>"
					Continue
				END IF
			END IF		
			//----------End Added -------------------------------------------------			
			iole_document.Fields.Item[i].Result.Text = ls_bookmark
		END IF
	END IF	
NEXT

iole_document.Range(0,0).select() */
//---------End Commented -----------------------------------------------------------------


//-----Begin modified by alfee 05.15.2007--------
of_setstatuschanged(lb_statuschanged_ori)
//of_setstatuschanged(TRUE) //alfee 04.23.2007
//-----End modified ---------------------------

RETURN 1

//CATCH(Throwable th)
//	iole_document.activewindow.visible = true
//	if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
//END TRY
end function

public function integer of_mergedocinfo (oleobject aole_word, str_doc_info astr_docinfo, boolean ab_merge);//Add function by jervis 02.24.2009
//Merge or unmerge document info
//ab_merge-true:Execute unmerge,false-Execute merge

//Add function by jervis 02.24.2009
//Merge or unmerge document info
integer li_count,li_index
string ls_name
OleObject	lole_Variable


//Update DocVariable value
li_count = aole_word.Variables.Count

for li_index = 1 to li_count
	lole_Variable = aole_word.Variables.Item(li_index)
	ls_name = lole_Variable.name
	if not ab_merge then
		choose case ls_name
			case '<<Version Number>>'
				lole_Variable.Value = string(astr_docinfo.ver_num)
			case '<<Version Date>>'
				lole_Variable.Value = string(astr_docinfo.ver_date)
			case '<<Document Name>>'
				lole_Variable.Value = astr_docinfo.doc_name
			case '<<Create By>>'
				lole_Variable.Value = astr_docinfo.Create_by
		end choose
	else
		if Match(ls_name,"\<\<.*\>\>") then
			lole_Variable.Value = ls_name
		end if
	end if
next

return 1
end function

public function integer of_refresh_docinfo (oleobject aole_word, str_doc_info astr_docinfo, boolean ab_updatefield);//Add function by jervis 02.24.2009
//Refresh version number data

integer li_count,li_index
string ls_name
OleObject	lole_Variable

If iole_object.doctype <> 1 Then Return 1 //Added By Ken.Guo 2009-09-07. only for word.

//Update DocVariable value
li_count = aole_word.Variables.Count

for li_index = 1 to li_count
	lole_Variable = aole_word.Variables.Item(li_index)
	ls_name = lole_Variable.name
	if ls_name = '<<Version Number>>' then	
		lole_Variable.Value = string(astr_docinfo.ver_num )
		exit
	end if
next

//Update Field
if ab_updatefield then
	inv_word_util.of_update_field( aole_word,false)
end if

return 1
end function

public function boolean of_isinitialized ();return ib_Initialized
end function

public function integer of_displayfile_excel (string as_file, boolean ab_readonly);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils::of_displayfile_excel()
// $<arguments>
//		value	string 	as_file    		
//		value	boolean	ab_readonly		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-09-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i
Boolean lb_statuschanged_ori 

TRY //03.10.2008
	is_current_file =""
	IF IsNull(as_file) OR Len(Trim(as_file)) < 1 OR NOT FileExists(as_file) THEN
		iole_object.Close() 
		RETURN -1
	END IF
	
	//Open new file
	IF of_open(as_File,ab_readonly) > 0 THEN 
		IF iole_object.DocType = 0  THEN
			is_current_file =""
			RETURN -1
		END IF
		is_current_file = as_file
	ELSE
		RETURN -1 
	END IF
	
Catch (Throwable th) 
	MessageBox("Display File", "Display file failed due to: " + th.text)
	RETURN -1 
End Try

RETURN 1


end function

public subroutine of_check_doc (long ai_ctx_id, long al_doc_id[], long ai_export_id[], string as_filename[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_check_doc()
// $<arguments> integer ai_ctx_id
// $<arguments> long al_doc_id[]
// $<arguments> integer ai_export_id[]
// $<arguments> string as_filename[]
// $<returns> (none)
// $<description>Check documents whether the auto numbering and merging 
// $<description>data need to be done, if yes then do it.
//////////////////////////////////////////////////////////////////////
// $<add> 03.20.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Long ll_cnt, i
String ls_source_file
OLEObject lole_word
n_cst_word_utility lnv_word

Setpointer(Hourglass!)

//Create a new Word object	and open the Word document.
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word //Alfee 01.17.2008
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN
END IF
lole_word.Visible = FALSE

Try
lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
ll_cnt = UpperBound(al_doc_id)
FOR i = 1 to ll_cnt
	lole_word.Application.Documents.Open(as_filename[i],false,false)
	gnv_shell.of_delete_recent( as_filename[i], true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.	
	//lole_word.Application.Documents.Open(as_filename[i],false,false,false,"","",True,"","",0,lole_word.Application.Options.DefaultTextEncoding,true,false,false,0)
	lole_word.ActiveDocument.TrackRevisions = false
	If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()

	//-------Appeon Begin Marked by alfee 04.26.2007--needn't numbering ----
	/*//Auto numbering for document
	lnv_word = create n_cst_word_utility
	lnv_word.of_preview(lole_word.ActiveDocument, True)
	destroy lnv_word
	If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()*/
	//-------Appeon End ---------------------------

	//Generate source file & merge data
   IF NOT isnull( ai_export_id[i] ) AND ai_export_id[i] <> 0 THEN 
  		 IF String(lole_word.ActiveDocument.BuiltInDocumentProperties.item[wdPropertyKeywords].value) <> 'merged' &
				AND lole_word.ActiveDocument.Fields.Count > 0 THEN
 		  	  IF il_export_ctxid = ai_ctx_id and il_export_id = ai_export_id[i] and Len(is_export_file) > 0 THEN
				  ls_source_file = is_export_file	
			  ELSE
				  ls_source_file = of_runexport(ai_export_id[i], ai_ctx_id)		
			  END IF			 	 

			  IF IsValid(w_export_progress) THEN CLOSE(w_export_progress)
			 
		  	  If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()

    			//---------Begin added by alfee 04.30.2007 fix a bug-------
				//0 -- not locked ; -1 -- all locked ; 99999 -- partly locked
			  If lole_word.ActiveDocument.Fields.Locked <> 0 Then
				  lole_word.ActiveDocument.Fields.Locked = 0
			  End If
				//---------End added by alfee 04.30.2007------------------
		  	  lole_word.ActiveDocument.MailMerge.MainDocumentType = wdFormLetters //added by alfee 06.29.2007
			  lole_word.ActiveDocument.MailMerge.OpenDataSource(ls_source_file)
			  gnv_shell.of_delete_recent( ls_source_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
			  lole_word.ActiveDocument.MailMerge.SuppressBlankLines = True
	        If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()        
			  lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = False
			  If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
			  //lole_word.ActiveDocument.BuiltInDocumentProperties.item[wdPropertyKeywords].value = 'merged'
			  of_setmergestatus(lole_word.ActiveDocument, True)			  

			  IF FileExists(ls_source_file) THEN //keep last export info
				  il_export_ctxid = ai_ctx_id
				  il_export_id = ai_export_id[i]
				  is_export_file = ls_source_file
			  END IF
			  
			  gnv_rights.of_check_dir_right(as_filename[i], true, 'Word Save')
			  lole_word.ActiveDocument.MailMerge.DataSource.Close()	
  			  lole_word.ActiveDocument.MailMerge.MainDocumentType = wdNotAMergeDocument //restore to normal document
			  lole_word.ActiveDocument.SaveAs(as_filename[i],0,false,'',false)
			  gnv_shell.of_delete_recent( as_filename[i], true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
			  If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
		  END IF
	END IF
   lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
NEXT
Catch(Throwable th)
	IF Isvalid(lole_word) Then
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
	END IF
	IF Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
	RETURN //05.14.2007 Alfee
End Try

//Quit Word application
lole_word.Quit(wdDoNotSaveChanges)
lole_word.DisconnectObject( )
destroy lole_word


end subroutine

public function string of_getdocumentrights (string as_userid, long ai_docid, long al_category);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovle_utils.of_getdocumentrights()
// $<arguments>
//		value	string 	al_userid  		
//		value	integer	ai_docid   		
//		value	long   	al_category		
// $<returns> string
// $<description>Get user rights on document level
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
/*1-Contract Management,2-Clause,3-Templates,4-Documents 
11-Full Access,12-Read Only,13-No Access;
21-Full Access,22-No Editing,23-Editing With Approval,24-No Adding,25-Adding With Approval;
31-Full Access,32-No Editing,33-Editing With Approval;
41-Full Access,42-No Editing,43-Editing With Approval*/

String ls_rights,ls_rtn

IF ib_readonly THEN 
	is_doc_right = 'no editing'
	RETURN is_doc_right
END IF

SELECT r.rights INTO :ls_rights
  FROM security_users u, ctx_acp_contract_management_right r
 WHERE u.role_id = r.role_id 
   AND u.user_id = :as_userid 
   AND r.category = :al_category
   AND r.types in (SELECT types = CASE base_type 
												WHEN '1' THEN '3' 
												WHEN '2' THEN '4'
												ELSE '0'
											  END
							FROM ctx_am_document
						  WHERE doc_id = :ai_docid) ;
												
CHOOSE CASE ls_rights
	CASE "31","41"
		ls_rtn = "Full Access"
	CASE "32","42"
		ls_rtn = "No Editing"		
	CASE "33","43"
		ls_rtn = "Editing With Approval"		
	CASE "34","44"		
		ls_rtn = "No Access"		
END CHOOSE		

is_doc_right = ls_rtn

RETURN ls_rtn
end function

public function integer of_mergedata (long ai_export_id, long ai_ctx_id, string as_open_file, string as_target_file, boolean ab_merged, str_doc_info astr_docinfo);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_mergedata()
// $<arguments>	
// str_doc_info astr_docinfo	//02.25.2009 By Jervis
// $<returns> (none)
// $<description>Merge or unmerge data with exported file manually
// $<description>This function needn't do auto numbering
//////////////////////////////////////////////////////////////////////
// $<add> 03.08.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
String ls_source_file
Boolean lb_need_merged
OLEObject lole_word
n_cst_word_utility lnv_word
String ls_error//(Appeon)Harry 03.07.2014 - for Bug # 3882

//Setpointer(Hourglass!)
IF Len(Trim(as_open_file)) < 1 or  Len(Trim(as_target_file)) < 1 THEN RETURN -1
IF Not ai_export_id > 0 THEN RETURN -1//added by alfee at 03.26.2007

//Open progress window and set progress bar
If not isvalid(w_export_progress) Then Openwithparm(w_export_progress, "Merging data in document..." )
w_export_progress.hpb_bar.position = 0
w_export_progress.st_merge.visible = true
w_export_progress.hpb_1.visible = true
//------Begin Modified by Alfee 06.25.2007---------
If Not ab_merged Then
	w_export_progress.st_progress.text = "Merging Data"	
	w_export_progress.st_6.text = "Progress of building data"
	w_export_progress.st_merge.text = "Progress of merging data"
Else
	w_export_progress.st_progress.text = "Unmerging Data"
	w_export_progress.st_6.text = "Progress of removing data"
	w_export_progress.st_merge.text = "Progress of replacing data with Merge Fields"	
End If
/*If ab_merge Then
	w_export_progress.st_progress.text = "Merging Data"
Else
	w_export_progress.st_progress.text = "Unmerging Data"
End If*/
//------End	Modified -------------------------------
w_export_progress.st_export.text = ""
w_export_progress.st_export1.text = ""

//Create a new Word object	and open the Word document which need to be merged.
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word //Alfee 01.17.2008
	IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN -1
END IF

TRY
	lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
	lole_word.Application.Documents.Open(as_open_file,false,true)
	gnv_shell.of_delete_recent( as_open_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	lole_word.Visible = FALSE
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.	
	//Unprotect document if needed - Alfee 03.10.2008
	//inv_word_util.of_unprotect_doc(lole_word.ActiveDocument) 
	IF inv_word_util.of_unprotect_doc(lole_word.ActiveDocument) = -1 THEN //Alfee 10.08.2008
		IF isvalid(w_export_progress) THEN CLOSE(w_export_progress)
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
		RETURN -1
	END IF		
	lole_word.ActiveDocument.TrackRevisions = false
	If isvalid(w_export_progress) Then w_export_progress.hpb_1.stepit( )

	//Check whether this document need to be merged
	IF lole_word.ActiveDocument.Fields.Count < 1 THEN
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
		IF isvalid(w_export_progress) THEN CLOSE(w_export_progress)
		RETURN -1 
	End If
	
	//Generate source file
	//--------Begin Modified by Alfee 07.19.2007 ---------------------------------
	//<$Reason>Do exporting data anyway
	/*IF il_export_ctxid = ai_ctx_id and il_export_id = ai_export_id and Len(is_export_file) > 0 THEN
		ls_source_file = is_export_file	
		IF isvalid( w_export_progress) THEN w_export_progress.hpb_bar.position = 100
	ELSE
		ls_source_file = of_runexport(ai_export_id, ai_ctx_id)			
	END IF*/
	ls_source_file = of_runexport(ai_export_id, ai_ctx_id)
	//---------End Modified -------------------------------------------------------
	
	IF FileExists(ls_source_file) THEN //keep last export info
		il_export_ctxid = ai_ctx_id
		il_export_id = ai_export_id
		is_export_file = ls_source_file				
		If isvalid(w_export_progress) Then w_export_progress.hpb_1.stepit( )
	ELSE
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
		IF isvalid(w_export_progress) THEN CLOSE(w_export_progress)
		RETURN -1
	END IF			

	//Open source file and merge data in the temporary file
	lole_word.ActiveDocument.MailMerge.MainDocumentType = wdFormLetters
	lole_word.ActiveDocument.MailMerge.OpenDataSource(ls_source_file)
	gnv_shell.of_delete_recent( ls_source_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	lole_word.ActiveDocument.MailMerge.SuppressBlankLines = True
	IF isvalid( w_export_progress) THEN w_export_progress.hpb_1.stepit( )

	//---------Begin added by alfee 04.30.2007 fix a bug-------
	//0 -- not locked ; -1 -- all locked ; 99999 -- partly locked
	If lole_word.ActiveDocument.Fields.Locked <> 0 Then
		lole_word.ActiveDocument.Fields.Locked = 0
	End If
	//---------End added by alfee 04.30.2007------------------

	//If lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = 65535 Then			
	//If of_ismerged(lole_word.ActiveDocument) Then //04.30.2007
	If ab_merged Then //The status may be different after saved as a new document - 04.15.2008
		lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = True
		of_setmergestatus(lole_word.ActiveDocument, False)
		//lole_word.ActiveDocument.BuiltInDocumentProperties.item[wdPropertyKeywords].value = 'merged'	
		inv_word_util.ib_restore_requirement = true  //(Appeon)Harry 03.07.2014 - for Bug # 3882
	Else
		lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = False
		of_setmergestatus(lole_word.ActiveDocument, True)
		//lole_word.ActiveDocument.BuiltInDocumentProperties.item[wdPropertyKeywords].value = ''	
		inv_word_util.ib_restore_requirement = false //(Appeon)Harry 03.07.2014 - for Bug # 3882
	End If	
	IF isvalid( w_export_progress) THEN w_export_progress.hpb_1.stepit( )	
	
	//Start code by jervis 02.25.2009
	//Merge DocVraiable fileds
	of_mergedocinfo(lole_word.ActiveDocument,astr_docinfo,ab_merged)
	//Update Fileds value
	inv_word_util.of_update_field( lole_word.ActiveDocument, false)
	//End code by jervis 02.25.2009
	
	inv_word_util.of_refresh_reqmnt_fields(lole_word,ai_ctx_id,ls_error)  //(Appeon)Harry 03.07.2014 - for Bug # 3882
	
	//Save as file and quit Word application
	gnv_rights.of_check_dir_right(as_target_file, true, 'Word Save')
	lole_word.ActiveDocument.MailMerge.DataSource.Close()
	lole_word.ActiveDocument.MailMerge.MainDocumentType = wdNotAMergeDocument //Alfee 06.28.2007
	lole_word.ActiveDocument.saveas(as_target_file,0,false,'',false)
	gnv_shell.of_delete_recent( as_target_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	IF isvalid(w_export_progress) Then w_export_progress.hpb_1.stepit( )
	lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
	lole_word.Quit(wdDoNotSaveChanges)
	lole_word.DisconnectObject( )
	destroy lole_word

CATCH(Throwable th)
//Added By Mark Lee 05/03/2013
//	MessageBox("Alert Message","Merge data in document failed!")
	//Added By Mark Lee 05/02/2013
	MessageBox("Alert Message","Merge data in document failed!~r~n of_mergedata(): "+ th.text  )
	gnv_debug.of_output(true, "Merge data in document failed!~r~n of_mergedata(): "+ th.text )
	if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	if lole_word.ActiveDocument.MailMerge.DataSource.Name <> '' then
		lole_word.ActiveDocument.MailMerge.DataSource.Close()
	end if
	if isvalid(lole_word) then
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
	end if
	Return -1
END TRY


IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)

Return 1

end function

public function integer of_mergedata_auto (long ai_export_id, long ai_ctx_id, string as_open_file, string as_target_file, boolean ab_mergeornot, str_doc_info astr_docinfo);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_mergedata_auto()
// $<arguments>	
//	str_doc_info	astr_docinfo	//02.25.2009 by jervis
// $<returns> integer
// $<description>Merge data with exported file
// $<description>This function is modified from of_mergedata_auto_ori
//////////////////////////////////////////////////////////////////////
// $<add> 03.08.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Integer i, li_cnt 
String ls_source_file
Boolean lb_need_merged
Boolean lb_rtn = FALSE
OLEObject lole_fields
OLEObject lole_word
n_cst_word_utility lnv_word
Boolean lb_ismerged
String ls_error //(Appeon)Harry 03.07.2014 - for Bug # 3882

//Setpointer(Hourglass!)
IF Len(Trim(as_open_file)) < 1 or  Len(Trim(as_target_file)) < 1 THEN RETURN -1

//Create a new Word object	and open the Word document.
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_fields //03.13.2008	
	Destroy lole_word //Alfee 01.17.2008
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN -1
END IF

TRY
	lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
	lole_word.Application.Documents.Open(as_open_file,false,true)
	gnv_shell.of_delete_recent( as_open_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	lole_word.Visible = FALSE
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.	
	//Unprotect document if needed - Alfee 03.10.2008
	//inv_word_util.of_unprotect_doc(lole_word.ActiveDocument) 
	IF inv_word_util.of_unprotect_doc(lole_word.ActiveDocument) = -1 THEN //Alfee 10.08.2008
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_fields 
		destroy lole_word
		RETURN -1
	END IF 
	lole_word.ActiveDocument.TrackRevisions = false
	If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
	
	inv_word_util.of_refresh_reqmnt_fields(lole_word,ai_ctx_id,ls_error)  //(Appeon)Harry 03.07.2014 - for Bug # 3882  

	//----------Begin Modified by Alfee 03.13.2008--------------------	
	lole_fields = lole_word.ActiveDocument.Fields
	li_cnt = lole_fields.count 
	For i = 1 to li_cnt
		If lole_fields.Item[i].Type = wdFieldMergeField Then Exit
	Next	
	
	gnv_rights.of_check_dir_right(as_target_file, true, 'Word Save')
	//If this document needn't to be merged
	
	//---------Begin Modified by (Appeon)Harry 03.06.2014 for Bug # 3932:--------
	lb_ismerged = of_ismerged(lole_word.ActiveDocument)
	//IF i > li_cnt OR (Not ai_export_id > 0) OR of_ismerged(lole_word.ActiveDocument) THEN	
	IF i > li_cnt OR (Not ai_export_id > 0) OR lb_ismerged THEN	
	//---------End Modfiied ------------------------------------------------------
	
	//IF lole_word.ActiveDocument.Fields.Count < 1 OR (Not ai_export_id > 0) OR &
	//	of_ismerged(lole_word.ActiveDocument) THEN
	//-----------End Modified --------------------------------------------
	//	lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = 0 Then //Modify by ken for BugA05 in 200704IIIWeeks.
		lole_word.ActiveDocument.saveas(as_target_file,0,false,'',false) //03.26.2007
		gnv_shell.of_delete_recent( as_target_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_fields //03.13.2008
		destroy lole_word
		//---------Begin Modified by (Appeon)Harry 03.06.2014 for Bug # 3932:--------
		//if li_cnt = 0 Then Return 1 //Added By Ken.Guo 11/08/2013. If No merge fields, it need return success.
		//RETURN -1
		if (Not ai_export_id > 0) OR lb_ismerged then
			return -1
		else
			return 1  //There aren't MergeField
		end if
		//---------End Modfiied ------------------------------------------------------
	End If

	//Generate source file
	IF il_export_ctxid = ai_ctx_id and il_export_id = ai_export_id and Len(is_export_file) > 0 THEN
		ls_source_file = is_export_file	
	ELSE
		ls_source_file = of_runexport(ai_export_id, ai_ctx_id)			
	END IF	
	IF FileExists(ls_source_file) THEN //keep last export info
		il_export_ctxid = ai_ctx_id
		il_export_id = ai_export_id
		is_export_file = ls_source_file				
		If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
	ELSE
		lole_word.ActiveDocument.saveas(as_target_file,0,false,'',false) //03.26.2007	
		gnv_shell.of_delete_recent( as_target_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_fields //03.13.2008		
		destroy lole_word
		RETURN -1
	END IF			
	if isvalid(w_export_progress) then	w_export_progress.hpb_1.stepit()

	//---------Begin added by alfee 04.30.2007 fix a bug-------
	//0 -- not locked ; -1 -- all locked ; 99999 -- partly locked
	If lole_word.ActiveDocument.Fields.Locked <> 0 Then
		lole_word.ActiveDocument.Fields.Locked = 0
	End If
	//---------End added by alfee 04.30.2007------------------

	//Open source file and merge data in the temporary file
	lole_word.ActiveDocument.MailMerge.MainDocumentType = wdFormLetters
	lole_word.ActiveDocument.MailMerge.OpenDataSource(ls_source_file)
	gnv_shell.of_delete_recent( ls_source_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	lole_word.ActiveDocument.MailMerge.SuppressBlankLines = True		
	lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = False
  	of_setmergestatus(lole_word.ActiveDocument, True) //Set document merge property  04.28.2007
	//lole_word.ActiveDocument.BuiltInDocumentProperties.item[wdPropertyKeywords].value = 'merged' //Set document merge property 

	If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
	if isvalid(w_export_progress) then w_export_progress.hpb_1.stepit()

	//Start code by jervis 02.25.2009
	//Merge DocVraiable fileds
	of_mergedocinfo(lole_word.ActiveDocument,astr_docinfo,ab_mergeornot)
	//End code by jervis 02.25.2009
	
	//Quit Word application - Move up to Catch statement 08.22.2007
	lole_word.ActiveDocument.MailMerge.DataSource.Close()
	lole_word.ActiveDocument.MailMerge.MainDocumentType = wdNotAMergeDocument //Alfee 06.28.2007
	lole_word.ActiveDocument.saveas(as_target_file,0,false,'',false)
	gnv_shell.of_delete_recent( as_target_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
	lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
	lole_word.Quit(wdDoNotSaveChanges)
	lole_word.DisconnectObject( )
	destroy lole_fields //03.13.2008	
	destroy lole_word
	if isvalid(w_export_progress) then	w_export_progress.hpb_1.position = 100

CATCH(Throwable th)
//Added By Mark Lee 05/03/2013
//	MessageBox("Alert Message","Merge data in document failed!")
	MessageBox("Alert Message","Merge data in document failed!~r~n of_mergedata_auto(): "+ th.text  )
	gnv_debug.of_output(true, "Merge data in document failed!~r~n of_mergedata_auto(): "+ th.text )
	if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	if isvalid(lole_word) then
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_fields //03.13.2008
		destroy lole_word
	end if
	Return -1 //
END TRY
	
Return 1
end function

public subroutine of_mergedata_auto_ori (long ai_export_id, long ai_ctx_id, string as_open_file, string as_target_file, boolean ab_mergeornot);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_mergedata_auto_ori()
// $<arguments>	
// $<returns> (none)
// $<description>Merge data with exported file
//////////////////////////////////////////////////////////////////////
// $<add> 02.26.2007 by Henry (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

String ls_source_file
OLEObject lole_word
Setpointer(Hourglass!)

IF Len(Trim(as_open_file)) < 1 or  Len(Trim(as_target_file)) < 1 THEN RETURN

//generate source file
If not ab_mergeornot Then 
	ls_source_file = is_export_file
Else
	If ii_ctx_id = ai_ctx_id Then
		ls_source_file = is_export_file
	Else
		ls_source_file = of_runexport(ai_export_id, ai_ctx_id)
		is_export_file = ls_source_file
		ii_ctx_id = ai_ctx_id
	End If
End If
IF Len(Trim(ls_source_file)) < 1 THEN RETURN

//
If not isvalid(w_export_progress) Then Openwithparm( w_export_progress, "Merging data in document..." )
w_export_progress.hpb_bar.position = 100

w_export_progress.st_merge.visible = true
w_export_progress.hpb_1.visible = true

If ab_mergeornot Then
	w_export_progress.st_progress.text = "Merging Data"
Else
	w_export_progress.st_progress.text = "Undo Merging Data"
End If
w_export_progress.st_export.text = ""
w_export_progress.st_export1.text = ""
w_export_progress.hpb_1.stepit( )

//Create a new word object	
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN
END IF

w_export_progress.hpb_1.stepit( )
//Open the Word document which need to be merged.
lole_word.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2008-07-22
lole_word.Application.Documents.Open(as_open_file,false,true)
gnv_shell.of_delete_recent( as_open_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
lole_word.Visible = FALSE
w_export_progress.hpb_1.stepit( )
gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
lole_word.ActiveDocument.TrackRevisions = false

//Auto numbering for document
n_cst_word_utility lnv_word
lnv_word = create n_cst_word_utility
lnv_word.of_preview(lole_word.ActiveDocument,True)
destroy lnv_word
//
w_export_progress.hpb_1.stepit( )

//Set the document format to Letter
lole_word.ActiveDocument.MailMerge.MainDocumentType = wdFormLetters
//IF lole_word.ActiveDocument.Fields.Count < 1 THEN 
//	RETURN
//End If

//If the document is merged then return
If lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = 0 Then
	lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
	lole_word.Quit(wdDoNotSaveChanges)//wdDoNotSaveChanges
	lole_word.DisconnectObject( )
	destroy lole_word
	IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
	Return
End If

//Open source file and merge data in the temporary file
lole_word.ActiveDocument.MailMerge.OpenDataSource(ls_source_file)
gnv_shell.of_delete_recent( ls_source_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
lole_word.ActiveDocument.MailMerge.SuppressBlankLines = True
w_export_progress.hpb_1.stepit( )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 20/04/2007 By: Ken.Guo
//$<reason> 
/*
lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = wdToggle
If not ab_mergeornot Then lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = wdToggle
*/
If ab_mergeornot Then
	lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = False
Else
	lole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = True	
End If
//---------------------------- APPEON END ----------------------------

w_export_progress.hpb_1.stepit( )
//Quit Word application
lole_word.ActiveDocument.MailMerge.DataSource.Close()
lole_word.ActiveDocument.saveas(as_target_file,0,false,'',false)
gnv_shell.of_delete_recent( as_target_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.

w_export_progress.hpb_1.stepit( )
lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
lole_word.Quit(wdDoNotSaveChanges)
lole_word.DisconnectObject( )
destroy lole_word

//IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
end subroutine

public function integer of_restore_clausenew (long ai_docid, decimal adec_revision, string as_docext, olecustomcontrol aole_1);//Restore clauses in document whcih are assigned to 'no editing' right.
//Added by Alfee 09.21.2007

Long ll_cnt, i, j, ll_found, ll_start_ori, ll_start_next, ll_len_ori, ll_len_new, ll_bmcnt
String ls_bookmark, ls_bookmark_next, ls_bktmp, ls_filename, ls_filename_tmp, ls_clausename
String ls_bm[]
Boolean lb_statuschanged_ori, lb_track, lb_showreviewmenu, lb_trackbysys //05.06.2008
OLEObject lole_object, lole_document

//Return if current document not opened
If iole_object.DocType <> 1 THEN RETURN 0

//Return if no any clause with 'no editing' right
ll_cnt = ids_category.RowCount()
IF ll_cnt < 1 THEN RETURN 0
ll_found = ids_category.Find("Lower(Description) = 'no editing'", 1, ll_cnt)
IF ll_found <= 0 THEN RETURN 0 // Alfee 05.09.2008
//IF ll_found < 0 THEN RETURN 0

//Get the copy of current document before modified
ls_filename = inv_dm_utils.of_generate_tempname(ai_docid, adec_revision, as_docext)
ls_filename_tmp = inv_dm_utils.of_generate_tempname_random(ai_docid, adec_revision, as_docext)
IF NOT FileExists(ls_filename) THEN 
	ls_filename = inv_dm_utils.of_download_file( ai_docid, adec_revision)
END IF
IF FileCopy(ls_filename, ls_filename_tmp, TRUE) <> 1 THEN RETURN -1

TRY
//Open the copied document in ole_1
lole_object = aole_1.Object
//lole_object.Close() - commented by Alfee 09.23.2008
lole_object.OpenLocalFile(ls_filename_tmp,TRUE) 
gnv_word_utility.of_modify_word_property( lole_object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
IF lole_object.DocType <> 1 THEN RETURN -1
lole_document = lole_object.ActiveDocument

CATCH(RunTimeError th1)
	IF FileExists(ls_filename_tmp) THEN FileDelete(ls_filename_tmp)
	Messagebox('Save Document','Failed to save document due to: '+th1.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	RETURN -2
END TRY

//Disable to call in status change event
lb_statuschanged_ori = of_isstatuschanged() 
of_setstatuschanged(FALSE)
lb_trackbysys = ib_trackchange_by_sys //Alfee 05.06.2008 

//Keep original track status
lb_track = of_istrackon()
lb_showreviewmenu = of_isshowreviewmenu()

TRY
//Get clauses' bookmark array	
FOR i = 1 TO iole_document.Content.Bookmarks.Count 
	ls_bookmark = iole_document.Content.Bookmarks.Item[i].Name
	IF Lower(Left(ls_bookmark,7)) = "clause_" THEN ls_bm[UpperBound(ls_bm) + 1] = ls_bookmark		
NEXT
ll_bmcnt = UpperBound(ls_bm)	
		
//Replace clauses with no editing right
DO WHILE ll_found > 0 
	ls_bookmark = 'clause_' + String(ids_category.GetItemNumber(ll_found, "ctx_acp_clause_id"))
	//The bookmark existed on both the original & current clause.
	IF iole_document.BookMarks.Exists(ls_bookmark) AND lole_document.BookMarks.Exists(ls_bookmark) THEN 
		//set track status 
		of_trackchange_ini()
		//Find next clause's bookmark
		ls_bookmark_next = ""
		FOR i = 1 TO ll_bmcnt
			IF ls_bm[i] = ls_bookmark AND i < ll_bmcnt THEN 
				ls_bookmark_next = ls_bm[i + 1]
				EXIT
			END IF	
		NEXT		
		//Keep the position of the next clause	if it existed			
		IF Len(Trim(ls_bookmark_next)) > 0 THEN
			ll_start_ori = iole_document.content.bookmarks.item(ls_bookmark).start
			ll_start_next = iole_document.content.bookmarks.item(ls_bookmark_next).start
			ll_len_ori = iole_document.content.bookmarks.item(ls_bookmark).end - ll_start_ori
		END IF			
		//Copy & Paste
		lole_document.content.bookmarks.item(ls_bookmark).Range.Copy()
		iole_document.content.bookmarks.item(ls_bookmark).Range.Paste()
		//Restore bookmarks if next clause existed			
		IF Len(Trim(ls_bookmark_next)) > 0 THEN
			ll_len_new = iole_document.content.bookmarks.item(ls_bookmark).end - iole_document.content.bookmarks.item(ls_bookmark).start
			ll_start_next = ll_start_next + ll_len_new - ll_len_ori
			For j = 1 to iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Count
				ls_bktmp = iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Item[j].Name
				If iole_document.Bookmarks.Item(ls_bktmp).End > ll_start_next Then	
					iole_document.Bookmarks.Item(ls_bktmp).Start = ll_start_next
					j --
				End If
			Next
		END IF
	//If the bookmark is missed, just alarm and deny to save it as the indefinite position in document
	ELSEIF NOT iole_document.BookMarks.Exists(ls_bookmark) AND lole_document.BookMarks.Exists(ls_bookmark) THEN 
		//------Begin Modified by Alfee on 05.06.2008 -------------
		//Restore the track status
		of_trackchange_restore(lb_track, lb_showreviewmenu, lb_trackbysys) 
		//of_trackchange(lb_track, lb_showreviewmenu) //Restore track status
		//------End Modified ---------------------------------------		
		of_setstatuschanged(lb_statuschanged_ori)	//Restore the status change flag
		IF FileExists(ls_filename_tmp) THEN FileDelete(ls_filename_tmp)		
		lole_object.close()	
		ls_clausename = ids_category.GetItemString(ll_found, "clause_name")
		MessageBox("Save Document","This document cannot be saved due to the clause of '" + ls_clausename + "' deleted!")
		RETURN -2
	END IF
	ll_found ++
	IF ll_found > ll_cnt THEN EXIT
	ll_found = ids_category.Find("Lower(Description) = 'no editing'", ll_found, ll_cnt)
LOOP

//Restore track status 
//------Begin Modified by Alfee on 05.06.2008 -------------
of_trackchange_restore(lb_track, lb_showreviewmenu, lb_trackbysys) 
//of_trackchange(lb_track, lb_showreviewmenu) 
//------End Modified ---------------------------------------

//Restore the status change flag
of_setstatuschanged(lb_statuschanged_ori)
//Delete the temporary file
IF FileExists(ls_filename_tmp) THEN FileDelete(ls_filename_tmp)

CATCH(RunTimeError th2)
	IF FileExists(ls_filename_tmp) THEN FileDelete(ls_filename_tmp)
	//------Begin Modified by Alfee on 05.06.2008 -------------
	//Restore the track status
	of_trackchange_restore(lb_track, lb_showreviewmenu, lb_trackbysys) 
	//	of_trackchange(lb_track, lb_showreviewmenu) 
	//------End Modified ---------------------------------------
	of_setstatuschanged(lb_statuschanged_ori)	
	lole_object.Close()
	Messagebox('Save Document','Failed to save document due to: '+th2.text+'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
	RETURN -2
END TRY

RETURN 1




end function

public function string of_runexport (long ai_export_id, long ai_ctx_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_runexport()
// $<arguments>
//		value	long	ai_export_id		
// $<returns> string
// $<description>Get exported text file
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

string ls_path, ls_return, ls_temp, ls_ctxid, ls_format
integer i, j, li_position, li_return, li_type
Long ll_ctx_id[], ll_current, ll_cnt
Boolean lb_existed = False
pfc_n_cst_ai_export_apb  n_export

IF isnull( ai_export_id ) OR ai_export_id = 0 THEN
       Messagebox( "Caution", "No export file selected." )
       return '';
END IF

SELECT save_path, export_type, export_format
	INTO :ls_path, :li_type, :ls_format
	FROM export_header WHERE export_id = :ai_export_id;

IF isnull( ls_path ) or Trim( ls_path ) = '' THEN
       Messagebox( "Caution", "No Save Path set for the current export file." )
       return '';
END IF

//IF li_type <> 3 and li_type <> 4 THEN
IF li_type <> 3 and li_type <> 4 and li_type <> 6 THEN //(Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
       Messagebox( "Caution", "The current export file is not prepared for Contract." )
       return '';
END IF

IF Left( ls_format, 1 ) <> '.' THEN ls_format = ''
ll_ctx_id[1] = ai_ctx_id
 
n_export = CREATE pfc_n_cst_ai_export_apb
n_export.is_called_type = '2' //Rodger wu set 2. 

li_return = n_export.of_export_data_with_text_ctx( ai_export_id, ll_ctx_id, ls_path, 0, "","","",2,"" )
//-----Begin Added by Alfee 10.28.2008 ----------------------
//<$Reason>for performance tuning, get data into ids_export
ids_export = n_export.ids_export_data
Destroy n_export
//-----End Added --------------------------------------------

IF li_return = 1 THEN	
	return ls_path
ELSE
   return '';
END IF

end function

public function integer of_merge_to_db (long al_ctx_id, long al_doc_id, decimal adec_revision, string as_filename, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_merge_to_db()
// $<arguments>
//		value	long   	al_ctx_id    		
//		value	long   	al_doc_id    		
//		value	decimal	adec_revision		
//		value	string 	as_filename  		
//		value	string 	as_doc_ext   		
// $<returns> integer
// $<description> Merge the doc from database, then upload to database.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-06-30 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_attach_type
String ls_filename, ls_path
String ls_SourceFile
String ls_merge_file
Integer li_rtn
Long	 ll_export_id
str_doc_info	lstr_docinfo	

n_cst_dm_utils lnv_dm_utils
n_cst_filesrvwin32  lnv_filesvr

//ls_path = gs_dir_path + gs_DefDirName + "\Agreement\Manager\" + gf_merge_file_name(as_filename,as_doc_ext,al_doc_id,adec_revision ) //Modified by Ken.Guo 2009-04-14
ls_path = lnv_dm_utils.of_generate_tempname(al_doc_id, adec_revision, as_doc_ext) 
ls_merge_file = gs_dir_path + gs_DefDirName + "\Agreement\" +"_"+ string(al_doc_id) + "_out.doc"		
		
SetPointer( HourGlass! )
Openwithparm(w_appeon_gifofwait, "Merging Document...")
li_rtn = lnv_dm_utils.of_download_file( al_doc_id, adec_revision, ls_path)
IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()

IF li_rtn = -1 or Not FileExists( ls_path ) THEN 
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) 
	RETURN -1
End IF

IF lower(as_doc_ext) <> 'doc' Then 
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) 
	Return 1
END IF

//Get Info	
gnv_appeondb.of_startqueue( )
Select ctx_acp_template.export_id Into :ll_export_id
 	From ctx_am_document,ctx_acp_template
	Where ctx_am_document.doc_id = :al_doc_id
    And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;

select create_by,create_date,doc_name
into :lstr_docinfo.create_by,:lstr_docinfo.ver_date,:lstr_docinfo.doc_name
from ctx_am_document
where doc_id = :al_doc_id;
gnv_appeondb.of_commitqueue( )

lstr_docinfo.ver_num = adec_revision

//Merge data		
IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()		
Filecopy(ls_path, ls_merge_file , true)
IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()		

If This.of_mergedata_auto(ll_export_id, al_ctx_id, ls_merge_file, ls_path, false,lstr_docinfo) < 0 Then
	FileDelete(ls_merge_file)
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) 
	Return -1
End If

//Auto numbering
This.of_autonumbering(ls_path)

//Upload to DB
Datetime ldt_modify_new
ldt_modify_new = Datetime(Today(),Now())
If lnv_dm_utils.of_update_document(al_doc_id, adec_revision, ls_path, ldt_modify_new) < 0 Then
	If Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) 
	Return -1
End If

//Update last modify date
Update ctx_am_doc_image set modify_date = :ldt_modify_new Where doc_id = :al_doc_id and  revision = :adec_revision ;

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) 
IF FileExists( ls_path ) THEN
	RETURN 1
ELSE
	RETURN -1
END IF

SetPointer( Arrow! )
Return 1
end function

public function integer of_getclausefile (long al_clauseid, decimal adec_revision, ref string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_getclausefile()
// $<arguments>
//		value	long    	al_clauseid   		
//		value	datetime	adt_lastupdate		
// $<returns> integer
// $<description>Get or Generate clause file from DB
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2007 by Alfee (Contract Logix Document Management)
//Modified By Ken.Guo 2010-08-03 Add adec_revision,as_filename
//////////////////////////////////////////////////////////////////////


//Begin - Modified By Ken.Guo 2010-01-18
Integer li_ret
n_cst_clause lnv_clause
lnv_clause = Create n_cst_clause
li_ret = lnv_clause.of_download_file(al_clauseid,adec_revision,as_filename)
Destroy lnv_clause
Return li_ret
/*
string ls_lastupdate,ls_regupdate,ls_filename
long ll_len,ll_currentpos,ll_length,ll_start
integer li_writes,li_filenum,li_cnt,li_loops
boolean lb_local //indicate whether local file is existed and updated
blob lblb_file,lblb_data

setpointer(HourGlass!)

lb_local = false
ls_filename = is_agreement_path + "clause_" + string(al_clauseid) + ".doc"
if not isnull(adt_lastupdate) then
	ls_lastupdate = string(adt_lastupdate, "mm/dd/yyyy hh:mm:ss")
end if

//Compare the updated date between local files and from db
if fileexists(ls_filename) then
	gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_" + string(al_clauseid), regstring!, ls_regupdate)	
	if ls_lastupdate = ls_regupdate then
		lb_local = true
	end if
end if

//If local file not existed or updated, generate new local file and update registry
if not lb_local then 
	if gs_dbtype = "SQL" and appeongetclienttype() = "PB" THEN //SQL
		SELECT datalength( image_file ) INTO :ll_length FROM ctx_acp_clause
		 WHERE ctx_acp_clause_id = :al_clauseid; 
		if ll_length > 8000 then
			li_loops = ( ll_length / 8000 ) + 1
			For li_cnt = 1 To li_loops				
				ll_start = (li_cnt - 1) * 8000 + 1			
				SELECTBLOB substring( image_file, :ll_start, 8000 ) INTO :lblb_data FROM ctx_acp_clause 
					  WHERE ctx_acp_clause_id = :al_clauseid; 			
				IF SQLCA.SQLCode <> 0 THEN
					Messagebox( "IntelliSoft", "Reading file data from database failed." )
					Return -1
				END IF
				lblb_file += lblb_data
			Next
		else
			selectblob image_file into :lblb_file from ctx_acp_clause
				  where ctx_acp_clause_id = :al_clauseid;		
		end if
	else //ASA
		selectblob image_file into :lblb_file from ctx_acp_clause
			  where ctx_acp_clause_id = :al_clauseid;	
	end if
	
	ll_len = len(lblb_file)
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
	
	li_filenum = fileopen(ls_filename , StreamMode!, Write!, LockWrite!,Replace!)
	if li_fileNum = -1 then return -1
	
	for li_cnt = 1 to li_writes
		 lblb_data = blobmid(lblb_file, ll_currentpos, 32765)
		 ll_currentpos += 32765
		 if filewrite(li_filenum, lblb_data) = -1 then
			 return -1
		 end If
	next
	
	fileclose(li_fileNum)
	
	//Save the latest update date of the current file in Registry
	gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_" + string(al_clauseid), regstring!, ls_lastupdate)	
end if

return 1
*/
//End - Modified By Ken.Guo 2010-01-18
end function

public function integer of_mergefile (long al_clauseid[], string as_rights[], long al_pagebreak[], integer ai_appendparagraph[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_mergefile()
// $<arguments>
//		value	long	al_clauseid[]		
//		value string as_rights[]
//		value long al_pagebreak[]
//		value long ai_appendparagraph[]
// $<returns> integer
// $<description>merge word files
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.12.2007 by Alfee (Contract Logix Document Management)
// $<modify> 05.30.2007 by Alfee(copied and modified from of_mergefile_0528)
//////////////////////////////////////////////////////////////////////
integer i, j, k, li_rtn
long ll_cnt, ll_bmcnt, ll_clauseid //11.29.2007
long ll_len_ori,ll_len_new,ll_start_ori,ll_end_ori,ll_start_numbering
string ls_filename, ls_bookmark, ls_bktmp
string ls_bm[], ls_tmp[]
boolean lb_numbering = False
boolean lb_track, lb_showreviewmenu, lb_trackbysys //05.06.2008
long ll_New_Clause[]

Try
	
//Unprotect document if needed - Alfee 03.10.2008
//of_unprotect_doc( ) 	
IF of_unprotect_doc( ) = -1 THEN RETURN -1 //Alfee 10.08.2008	

//Set bookmarks'default sort order
iole_document.bookmarks.DefaultSorting = wdSortByLocation

ll_cnt = upperbound(al_clauseid)
//setpointer(HourGlass!)	
	
//clear clause(s) and return if no selected caluses
if ll_cnt < 1 then 
	for i = 1 to iole_document.Content.bookmarks.count 
		ls_bookmark = iole_document.content.bookmarks.item[i].name
		if lower(left(ls_bookmark,7)) <> "clause_" then continue
		iole_document.content.bookmarks.item[i].select()
		iole_document.activewindow.selection.delete()
		If iole_document.content.bookmarks.Exists(ls_bookmark) Then
			iole_document.content.bookmarks.Item(ls_bookmark).delete()
		End If
		i --		
	next
	return 1
end if

//initilize clauses' bookmark array and clear invalid bookmark(s)
for i = 1 to iole_document.content.bookmarks.count 
	ls_bookmark = iole_document.content.bookmarks.item[i].name
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
			iole_document.content.bookmarks.item[i].select()
			iole_document.activewindow.selection.delete()
			If iole_document.content.bookmarks.Exists(ls_bookmark) Then
				iole_document.content.bookmarks.Item(ls_bookmark).delete()
			End If
			i --
			Continue		
		End If
		//Clear the bookmark if a empty clause - for a bug
		if iole_document.content.bookmarks.item[i].Start >= iole_document.content.bookmarks.item[i].End then	
			iole_document.content.bookmarks.item[i].delete()
			i --	
			Continue
		end if		
		//initilize clauses' bookmark array
		ls_bm[UpperBound(ls_bm) + 1] = ls_bookmark	
		/*
		ls_bm[UpperBound(ls_bm) + 1] = ls_bookmark		
		if iole_document.content.bookmarks.item[i].Start >= iole_document.content.bookmarks.item[i].End then	//for a bug
			iole_document.content.bookmarks.item[i].delete()
			i --			
		end if	*/	
		//--------End Modified ----------------------------------------		
	end if
next
ll_bmcnt = UpperBound(ls_bm)
if isvalid(w_appeon_gifofwait) then w_appeon_gifofwait.event timer()

//Keep original track status --Added by alfee 05.09.2007
lb_track = of_istrackon()
lb_showreviewmenu = of_isshowreviewmenu()
lb_trackbysys = ib_trackchange_by_sys //Alfee 05.06.2008 

//merge clause file(s)
for i = 1 to ll_cnt	
	iole_document.undoclear() //Added By Ken.Guo 2011-05-03.
	
	ls_bookmark = "clause_" +string(al_clauseid[i])	
	
	//ls_filename = lower(is_agreement_path + ls_bookmark + ".doc")//a Web bug, the insertfile function is case sensitive 
	ls_filename = inv_clause.of_generate_name(al_clauseid[i]) //Modified By Ken.Guo 2010-01-18
	
	if isvalid(w_appeon_gifofwait) then w_appeon_gifofwait.event timer()	
	
	//if existed, adjust the order of clause in file
	if iole_document.Content.bookmarks.exists(ls_bookmark) then 
		if iole_document.content.bookmarks.item(ls_bm[i]).name <> ls_bookmark then
			ll_start_ori = iole_document.content.bookmarks.item(ls_bm[i]).start
			ll_len_ori = iole_document.content.bookmarks.item(ls_bm[i]).end - ll_start_ori
			ll_len_new = iole_document.content.bookmarks.item(ls_bookmark).end - iole_document.content.bookmarks.item(ls_bookmark).start
			//set track status 05.09.2007
			of_trackchange_ini()
			//cut and paste file
			iole_document.Content.bookmarks.item(ls_bookmark).select()
			iole_document.activewindow.selection.cut()
			iole_document.content.bookmarks.item(ls_bm[i]).select()
			iole_document.activewindow.selection.collapse(wdCollapseStart)
			//--------Begin Modified by Alfee 12.06.2007-----------------------------
			//<$Reason>for the case of pasting content before an existed table
			IF iole_document.activewindow.selection.tables.count > 0 THEN 
				iole_document.activewindow.selection.InsertBreak(wdSectionBreakContinuous)	
				iole_document.activewindow.selection.Start = ll_start_ori
				iole_document.activewindow.selection.End = iole_document.content.bookmarks.item(ls_bm[i]).End
				iole_document.activewindow.selection.collapse(wdCollapseStart)			
			END IF			
			//--------End Modified --------------------------------------------------						
			iole_document.activewindow.selection.paste()
			iole_document.activewindow.selection.expand()			
			//restore bookmarks
			iole_document.Content.bookmarks.add(ls_bookmark,iole_document.range(ll_start_ori, ll_start_ori + ll_len_new))
			For j = 1 to iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Count
				ls_bktmp = iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Item[j].Name
				//-------------Begin Modified by Alfee 12.06.2007-----------------------
				//If iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Item(ls_bktmp).End > ll_start_ori + ll_len_new Then	
				//	iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Item(ls_bktmp).Start = ll_start_ori + ll_len_new
				If iole_document.Bookmarks.Item(ls_bktmp).End > ll_start_ori + ll_len_new Then	
					iole_document.Bookmarks.Item(ls_bktmp).Start = ll_start_ori + ll_len_new
				//-------------End Modified --------------------------------------------					
					j --
				End If
			Next
		else 
			continue
		end if
	//if not existed and as a last clause, append the clause to end of the file
	elseif i > ll_bmcnt then
   	if not fileexists(ls_filename) then return -1	
		
		//New Clause - jervis 1.6.2010
		ll_New_Clause[UpperBound(ll_New_Clause) + 1] = al_clauseid[i] 
		
		//set track status 05.09.2007
		//------Begin Modified by Alfee on 05.06.2008 -------------
		//Restore the track status
		of_trackchange_restore(lb_track, lb_showreviewmenu, lb_trackbysys) 
		//of_trackchange(lb_track, lb_showreviewmenu) //restore track status on document level
		//------End Modified ---------------------------------------		
		if as_rights[i] = '25' then of_trackchange(true, false) //adding with approval on clause level
  	   //append file
		if ll_bmcnt = 0 then 
			//-----Begin Modified by Alfee 10.07.2008 -----
			//ll_start_ori = 0
			iole_document.content.InsertParagraphAfter() 
			ll_start_ori = iole_document.content.end - 1 // Jervis 06.08.2009
			//-----End Modified ---------------------------
			iole_document.content.select()
		else
			ll_start_ori = iole_document.content.bookmarks.item(ls_bm[i - 1]).end
			iole_document.content.bookmarks.item(ls_bm[i - 1]).select()
		end if
		ll_end_ori = iole_document.content.end 
	   iole_document.activewindow.selection.collapse(wdCollapseEnd)
		if al_pagebreak[i]= 1 THEN iole_document.activewindow.selection.insertbreak(wdSectionBreakNextPage) //added by alfee 05.28.2007		
		If ai_appendparagraph[i] = 1 Then 
			iole_document.activewindow.selection.TypeParagraph() //Restored on 04.15.2008 
			//iole_document.activewindow.selection.InsertParagraphAfter() //Restored on 04.15.2008 
		End If
   	iole_document.activewindow.selection.insertfile(ls_filename)
		gnv_shell.of_delete_recent( ls_filename, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
   	iole_document.activewindow.selection.expand()
	   //add bookmark	  
		ll_len_new = iole_document.content.end - ll_end_ori
		iole_document.Content.bookmarks.add(ls_bookmark,iole_document.range(ll_start_ori, ll_start_ori + ll_len_new))
	//if not existed and as a middle clause, insert the clause to the file
	else
   	if not fileexists(ls_filename) then return -1	
		
		//New Clause - jervis 1.6.2010
		ll_New_Clause[UpperBound(ll_New_Clause) + 1] = al_clauseid[i] 
		
		ll_start_ori = iole_document.content.bookmarks.item(ls_bm[i]).start
		ll_end_ori = iole_document.content.end 
		//set track status 05.09.2007
		//set track status 05.09.2007
		//------Begin Modified by Alfee on 05.06.2008 -------------
		//Restore the track status on document level
		of_trackchange_restore(lb_track, lb_showreviewmenu, lb_trackbysys) 
		//of_trackchange(lb_track, lb_showreviewmenu) //restore track status on document level
		//------End Modified ---------------------------------------
		if as_rights[i] = '25' then of_trackchange(true, false) //adding with approval on clause level
		//insert file
		iole_document.content.bookmarks.item(ls_bm[i]).select()
		iole_document.activewindow.selection.collapse(wdCollapseStart)
		//--------Begin Modified by Alfee 12.06.2007-----------------------------
		//<$Reason>for the case of inserting content before an existed table
		IF iole_document.activewindow.selection.tables.count > 0 THEN 
			iole_document.activewindow.selection.InsertBreak(wdSectionBreakContinuous)	
			iole_document.activewindow.selection.Start = ll_start_ori
			iole_document.activewindow.selection.End = iole_document.content.bookmarks.item(ls_bm[i]).End
			iole_document.activewindow.selection.collapse(wdCollapseStart)			
		END IF			
		//--------End Modified --------------------------------------------------			
		if al_pagebreak[i]= 1 THEN iole_document.activewindow.selection.insertbreak(wdSectionBreakNextPage) //added by alfee 05.28.2007				
		If ai_appendparagraph[i] = 1 Then 
			iole_document.activewindow.selection.TypeParagraph()
			//iole_document.activewindow.selection.InsertParagraphAfter()
		End If
		iole_document.activewindow.selection.insertfile(ls_filename)
		gnv_shell.of_delete_recent( ls_filename, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		iole_document.activewindow.selection.expand()
		//add bookmark
		ll_len_new = iole_document.content.end - ll_end_ori
		if ll_len_new < 0 then ll_len_new = 0
		iole_document.Content.bookmarks.add(ls_bookmark,iole_document.range(ll_start_ori, ll_start_ori + ll_len_new ))
      //restore bookmarks
		For j = 1 to iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Count
			ls_bktmp = iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Item[j].Name
			//-------------Begin Modified by Alfee 12.06.2007-----------------------
			//If iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Item(ls_bktmp).End > ll_start_ori + ll_len_new Then	
			//	iole_document.Range(ll_start_ori, ll_start_ori).Bookmarks.Item(ls_bktmp).Start = ll_start_ori + ll_len_new
			If iole_document.Bookmarks.Item(ls_bktmp).End > ll_start_ori + ll_len_new Then	
				iole_document.Bookmarks.Item(ls_bktmp).Start = ll_start_ori + ll_len_new			
			//-------------End Modified --------------------------------------------									
				j --
			End If
		Next		
	end if
	//Reset array of ls_bm[]
	j = 1
	ls_bm = ls_tmp 
	for k = 1 to iole_document.content.bookmarks.count 
		ls_bookmark = iole_document.content.bookmarks.item[k].name
		if lower(left(ls_bookmark,7)) = "clause_" then 
			ls_bm[j] = ls_bookmark
			j ++
		end if
	next
	ll_bmcnt = UpperBound(ls_bm)
	if ll_bmcnt = 1 then 
		if IsNull(ls_bm[1]) or ls_bm[1] = '' then ll_bmcnt = 0
	end if
next

//Restore track status 05.09.2007
//------Begin Modified by Alfee on 05.06.2008 -------------
of_trackchange_restore(lb_track, lb_showreviewmenu, lb_trackbysys) 
//of_trackchange(lb_track, lb_showreviewmenu) 
//------End Modified ---------------------------------------

//delete invalid clause(s) in the file
if ll_cnt < 1 then
	iole_document.content.delete()
else
	for i = ll_cnt + 1 to ll_bmcnt
		if iole_document.content.bookmarks.Exists(ls_bm[i]) then
			iole_document.content.bookmarks.Item(ls_bm[i]).select()
			iole_document.activewindow.selection.delete()
			if iole_document.content.bookmarks.Exists(ls_bm[i]) Then
				iole_document.content.bookmarks.Item(ls_bm[i]).delete()
			end if
		end if
	next	
end if

//Dislay as Word Comment for Clause - jervis 01.06.2010
inv_word_util.of_Update_WordComment(iole_document,al_clauseid)

//Set the Clause Text Color base on Clause Status - jervis 01.06.2010
inv_word_util.of_Update_ClauseColor(iole_document,ll_New_Clause)

Catch (Throwable th)
	MessageBox("Alert Message","Merge file(s) failed!")
	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
End Try

return li_rtn

end function

public function integer of_accept_reject_special_character (string as_action, string as_criteria, boolean ab_flag);//====================================================================
// Function: of_accept_reject_special_character
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_action
//                as_criteria
//                ab_flag
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 04/10/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer ll_current_page, li_next_page, li_revtype
Long ll_current_start, ll_current_end, ll_next_start, ll_revcnt, i
Oleobject lole_revisions, lole_item
String			ls_text

IF not ib_Initialized  THEN RETURN -1

CHOOSE CASE lower(as_criteria)
	CASE 'all format' 		
		lole_revisions = iole_document.revisions	
		ll_revcnt = lole_revisions.count 
		//Set and open the progress window
		IF ll_revcnt > 5 THEN
			IF NOT IsValid(w_appeon_gifofwait) THEN Open(w_appeon_gifofwait)
			IF isvalid(w_appeon_gifofwait) THEN 
				IF Lower(as_action) = 'accept' THEN
					w_appeon_gifofwait.st_1.Text = 'Accepting Changes...'
				ELSE
					w_appeon_gifofwait.st_1.Text = 'Rejecting Changes...'
				END IF
				w_appeon_gifofwait.hpb_1.MaxPosition = ll_revcnt * 10
				w_appeon_gifofwait.hpb_1.Position = 0	
			END IF
		END IF
		//Accept or Reject changes
		FOR i = 1 to ll_revcnt 
			IF isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.Stepit()					
			//Get the revision type
			If i > lole_revisions.count  Then Continue //Added By Ken.Guo 04/16/2013
			lole_item = lole_revisions.item[i]
			li_revtype = lole_item.Type
			
			//Accept or reject the revision with a format change
			IF li_revtype = 1 or li_revtype = 2 or li_revtype = 9 or li_revtype = 16 or & 
				li_revtype = 18 or li_revtype = 14 or li_revtype = 15 THEN //refer to wdrevisiontype
				If ab_flag = True then 
					ls_text  = lole_item.range.text
					//After compare file, accept the enter character and the Page Break character change in the delete format 
					If  (li_revtype = 2 Or li_revtype = 1) and ( (ls_text = char(13) and len(ls_text) = 1 ) or (ls_text = char(13) + char(13) and len(ls_text) = 2) &
						Or (ls_text = char(12) and len(ls_text) = 1 ) or (ls_text = char(12) + char(13) and len(ls_text) = 2)  ) Then 
						lole_item.Accept()
						IF ll_revcnt > lole_revisions.count THEN i = 0 //Added By Ken.Guo 04/16/2013. Set i = 0 to accept all again. because the accept() maybe change the revision's order or count.
					Else
						Continue
					End If
				Else
					CONTINUE
				End If 
			ELSE
				IF Lower(as_action) = 'accept' THEN		
					lole_item.Accept()
				ELSE
					lole_item.Reject()
				END IF
				IF ll_revcnt > lole_revisions.count THEN i = 0	//Added By Mark Lee 04/22/2013
			END IF
			ll_revcnt = lole_revisions.count		//Added By Mark Lee 04/17/2013 Point: the count reduce is not one by one.
		NEXT		
		IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
END CHOOSE

RETURN 1
end function

public function integer of_revision_count ();//====================================================================
// Function: of_revision_count
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 04/10/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer 	li_return 

li_return =  0 
IF not ib_Initialized  THEN RETURN -1

li_return = Long(iole_document.revisions.count)
li_return += inv_dm_utils.of_get_sharps_revision_count(iole_document)

//li_return = Long(iw_ole_word.ole_1.object.ActiveDocument.Revisions.Count) 
//// Check revision for sharps object.
//li_return += inv_dm_utils.of_get_sharps_revision_count( iw_ole_word.ole_1.object.ActiveDocument )
		

Return li_return
end function

public function integer of_initialdoc (oleobject aole_document);//====================================================================
// Function: of_initialdoc
//--------------------------------------------------------------------
// Description:  Use OLE Object. Dot not use OLE Control.
//--------------------------------------------------------------------
// Arguments:
//                aole_document
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 04/19/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2013 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

iole_document = aole_document
ib_Initialized = True
Return 1
end function

public function integer of_unprotect_doc (boolean abln_msgbox);//Added By Mark Lee 05/28/2013
//Unprorect the document if protected 
Boolean lb_statuschanged_ori
IF abln_msgbox = True Then 
	Return of_unprotect_doc()
Else
	
	IF Not ib_Initialized  THEN RETURN -1
	
	TRY
	If iole_object.DocType <> 1 Then Return 1  
		
	IF Integer(iole_object.ActiveDocument.ProtectionType) <> wdNoProtection Then
			gnv_debug.of_output( True, "Protected Document:"+ string(iole_object.ActiveDocument.Name) )
		RETURN -2	
	END IF
	
	Catch (Throwable th)
		RETURN -1 
	End Try
End IF 
RETURN 1
end function

on n_cst_ovole_utils.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ovole_utils.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_category = create datastore
ids_category.dataobject = 'd_dm_clause_rights'
ids_category.settransobject(sqlca)

ids_changes = Create DataStore
ids_changes.DataObject = "d_dm_change_list"
ids_changes.settransobject(sqlca)

//------Added by Alfee 05.05.2007-------------
ids_clausename = Create datastore
ids_clausename.dataobject = 'd_clauses_all'
ids_clausename.SetTransObject(SQLCA)
//-------End Added--------------------

ids_export = Create DataStore //alfee 10.28.2008

inv_word_util = create n_cst_word_utility
is_agreement_path = gs_dir_path + gs_DefDirName + "\Agreement\" //added by alfee 04.27.2007

inv_clause = Create n_cst_clause 
end event

event destructor;destroy ids_category 
destroy ids_changes
Destroy ids_clausename //alfee 05.05.2007

Destroy inv_word_util
IF IsValid(ids_export) THEN Destroy ids_export //Alfee 10.28.2008

Destroy inv_clause 
end event

