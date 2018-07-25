$PBExportHeader$n_cst_msword.sru
$PBExportComments$This object contains methods that manipulte microsoft word
forward
global type n_cst_msword from nonvisualobject
end type
end forward

global type n_cst_msword from nonvisualobject
end type
global n_cst_msword n_cst_msword

type prototypes
FUNCTION ulong FindWindowA(ulong classname,string windowname) LIBRARY "User32.dll" alias for "FindWindowA;Ansi"
//Function long  SetFocus  (Long hWnd ) LIBRARY "User32.dll" ALIAS FOR "SetAppFocus"
SUBROUTINE SetFocus(long objhandle) LIBRARY "User32.dll"
end prototypes

type variables
n_cst_filesrvwin32 inv_filesrv
n_cst_string inv_string 
oleobject iole_word

string  is_directory
STRING is_letter_path
STRING is_letters_created[]


//wdSeekView Type

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


end variables

forward prototypes
public function integer of_connect_to_word ()
public subroutine of_dissconnect_from_word ()
public function integer of_file_copy (string as_from, string as_to)
public subroutine of_set_focus ()
public function integer of_open_word_document (string as_doc_path, string as_no_fax)
public function integer of_open_word_document (string as_doc_path, string as_merge, string as_from)
public function integer of_set_bookmark (oleobject al_ole, string as_bookmark_name, string as_value)
public function integer of_setup ()
public function integer of_delete_fax_documents ()
public function integer of_createdatasource (powerobject apo_data, string as_path)
public function integer of_delete_file (string as_path)
end prototypes

public function integer of_connect_to_word ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_connect_to_word
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


of_dissconnect_from_word( )

iole_word = CREATE oleobject
if iole_word.Connecttonewobject("word.application") <> 0 then
	messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	return -1
end if 
iole_word.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 04.09.2008. Don't save normal template when quit word to forbid saving dialog. 
return 1


end function

public subroutine of_dissconnect_from_word ();




// disconnect from word

IF ISVALID(iole_word) THEN
   iole_word.DisconnectObject ( )
	Destroy iole_word //Add by Evan on 03.25.2008 
END IF
end subroutine

public function integer of_file_copy (string as_from, string as_to);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_file_copy
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [string]  as_from
//					  [string] as_to
//==================================================================================================================
//  Returns   	: [long]      
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



long ll_retuen 

ll_retuen = FileCopy (as_from, as_to , true)

choose case ll_retuen
	case -1 // opening sourcefile
		messagebox('Error Source file', 'The file: ' + as_to +' Could not be written. Please make sure the path exists and you have FULL permissions to it' )
		
	case  -2 //writing targetfile
		messagebox('Error Targret file', 'The Fax directory : ' + is_directory +' Could not be opened. Please make sure the path exists and you have FULL permissions to it' )
		
	case else
		ll_retuen =  1
end choose 


return  ll_retuen
end function

public subroutine of_set_focus ();
TRY
	iole_word.ActiveWindow.SetFocus
   iole_word.Application.Activate
CATCH (RunTimeError rte)
  // do nothing
END TRY

end subroutine

public function integer of_open_word_document (string as_doc_path, string as_no_fax);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_open_word_document
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [string] as_doc_path (the path of the document to open)
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: The function overloads of_open_word_document(as_doc_path). The only diferance is this function
//					  will disconnect from word once the docuument os opened. This is needd because if the we are not
//					  diconnected from word there will be a sharing error
//==================================================================================================================
//  Created By	: Michael Skinner  23 dec 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

of_open_word_document(as_doc_path,'','')

of_dissconnect_from_word( )

return 1
end function

public function integer of_open_word_document (string as_doc_path, string as_merge, string as_from);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_open_word_document
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [string] as_doc_path (the path of the document to open)
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
// mskinner                22 dec 2004                          we need to copy the word doc to fax directory because if we 
//																					 we do not the orignal will be coppied over (the one in the )
//																					 letter directory)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//window lw_infodisp
string   ls_array[ ]
string ls_single
String  ls_delimiter = "\"
n_cst_appeondll lnv_appeondll

//Start Code Change ---- 03.27.2006 #349 maha
//Start Code Change ---- 10.04.2006 #682 maha correct the mid arguments
if MidA(as_doc_path,LenA(as_doc_path) , 1) = "\" then 
	messagebox('Missing Document name','The letter path has no document.')
	return -1
end if
if MidA(as_merge,LenA(as_merge) , 1) = "\" then  
	messagebox('Missing Document name','The merge path has no file name.')
	return -1
end if
//End Code Change---10.04.2006
//if not f_validstr(as_doc_path) then
if not fileexists(as_doc_path) then
	messagebox('Missing Path','Unable to find the Word document "' + as_doc_path + '".') //Start Code Change ---- 07.17.2007 #V7 maha clarified message
	return -1
end if 

//if not f_validstr(as_merge) then
if not fileexists(as_merge) then
	messagebox('Missing File','Unable to find the merge document "' + as_merge + '".') //Start Code Change ---- 07.17.2007 #V7 maha clarified message
	return -1
end if 
//End Code Change---03.27.2006

if not f_validstr(as_from) then
	
end if 


try


openwithparm( w_appeon_gifofwait, "Opening document..." )

// get the name of the doc from as_doc_path
inv_string.of_ParseToArray ( as_doc_path, ls_delimiter, ls_array )

// make sure we are connected to word
if of_connect_to_word( ) < 0 then 
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	return -1
end if

// make sure the file exists

if fileexists(as_doc_path) then
	// copy done elseware
//    if of_file_copy(as_doc_path,  is_directory + ls_array[upperbound(ls_array)]) <> 1 then
//		close(w_infodisp_50)
//		return -1 
//	 end if 
else 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.10.2007 By: Davis
	/*
		close(w_infodisp_50)
	*/
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	//---------------------------- APPEON END ----------------------------
	//messagebox('Error', 'The word document:' +ls_array[upperbound(ls_array)]+ 'does not exist or you do not have FULL permissins to the file/directory.') 
	messagebox("Open letter failure","Could not find " +  as_from + " document: '" + as_doc_path + "'")
	
	return -1
end if 

lnv_appeondll.of_BringTopMergeFieldDlg(1) //Added by Evan 06.12.2012

//iole_word.Application.Documents.Open(is_directory + ls_array[upperbound(ls_array)])
iole_word.Application.Documents.Open(as_doc_path)
//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
gnv_shell.of_delete_recent( as_doc_path, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
//---------End Added ------------------------------------------------------------------

//---------Begin Added by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
gnv_word_utility.of_modify_word_property( iole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
//---------End Added ------------------------------------------------------

iole_word.ActiveDocument.MailMerge.OpenDataSource(as_merge)//,0,false,false,false,false,"","",false) 
//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
gnv_shell.of_delete_recent( as_merge, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
//---------End Added ------------------------------------------------------------------

iole_word.ActiveDocument.MailMerge.SuppressBlankLines = True
iole_word.ActiveDocument.MailMerge.ViewMailMergeFieldCodes = False //Alfee 11.14.2008
iole_word.Visible = True // let us see the document
//iole_word.execute()

lnv_appeondll.of_BringTopMergeFieldDlg(0) //Added by Evan 06.12.2012

is_letter_path =  as_doc_path //is_directory + ls_array[upperbound(ls_array)]
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.10.2007 By: Davis
	/*
		close(w_infodisp_50)
	*/
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	//---------------------------- APPEON END ----------------------------

catch (runtimeerror rte)
	of_dissconnect_from_word( )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.10.2007 By: Davis
	/*
		close(w_infodisp_50)
	*/
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	//---------------------------- APPEON END ----------------------------
	lnv_appeondll.of_BringTopMergeFieldDlg(0) //Added by Evan 06.12.2012
	return -1
end try

return 1
end function

public function integer of_set_bookmark (oleobject al_ole, string as_bookmark_name, string as_value);/******************************************************************************************************************
**  [PUBLIC]   : of_set_bookmark
**==================================================================================================================
**  Purpose   	: Sets the value to the bookmark
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 31 October 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


IF NOT ISVALID(al_ole) OR NOT F_VALIDSTR(as_bookmark_name) OR NOT F_VALIDSTR(as_value) THEN  RETURN -1

al_ole.ActiveDocument.bookmarks.item(as_bookmark_name).range.text = as_value




return 0
end function

public function integer of_setup ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : n_cst_fax :: of_setup
//==================================================================================================================
//  Purpose   	: Creates the fax documents
//==================================================================================================================
//  Arguments 	: [none]
//==================================================================================================================
//  Returns   	: [none]     
//==================================================================================================================
//  Notes     	: 	At this point we already have the handle to the document that needs to merged   
//==================================================================================================================
//  Created By	: Michael B. Skinner  Wednesday 17 December 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// start code change --- 11.08.2005 MSKINNER

long li_top_margin 
long li_left_margin 
long li_right_margin 
long li_bottom_margin
long ll_i
long li_merge_doc_pages
string ls_null[]


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// delete all of the letters in the fax directory
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//of_delete_fax_documents()

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// if word ole object is not valid then get out
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

IF NOT ISVALID(iole_word ) THEN
    // start code change --- 11.09.2005 MSKINNER
	messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN  -1
	// end code change --- 11.09.2005 MSKINNER
END IF 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.19.2006 By: LeiWei
//$<reason> Fix a defect.
IF appeongetclienttype() = 'WEB' THEN
	Boolean lb_ole_visible
	lb_ole_visible = iole_word.Visible
	IF Isnull(lb_ole_visible) OR NOT lb_ole_visible THEN
      messagebox("Information",'The word document is no longer active. Please reopen the document and keep it open until the processing has completed.' )
		return -1
	END IF
END IF
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  Sets the folder in which Word searches for documents. The specified folder's 
//  contents are listed the next time the Open dialog box (File menu) is displayed
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// progress window
open(w_infodisp_50)
w_infodisp_50.st_complete.visible = false
w_infodisp_50.st_3.visible = false
w_infodisp_50.st_information.visible = false
w_infodisp_50.st_1.text = 'Creating MicroSoft Word document. Please stand by'  //dodument->document (alfee 11.10.2016)

// if we get a runtime error here it is bcause the doc is closed
 //Start Code Change ----07.09.2013 #V14 maha - slightly modified message
TRY
	   iole_word.ChangeFileOpenDirectory(is_directory)
CATCH (RunTimeError rte)
      messagebox("Information",'The word document is no longer active. Please reopen the document and keep it open until the processing has completed.' )
		close(w_infodisp_50)
		return -1
END TRY


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10/17/2007 By: Ken.Guo
//$<reason> Get Merge DataSource's Rowcount by datasource file.
//          ComputeStatistics(2) will get incorrect rowcount,So replace it.
/*
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// do the merge (so we can get the total page count
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

iole_word.ActiveDocument.MailMerge.DataSource.FirstRecord = 1
iole_word.ActiveDocument.MailMerge.DataSource.LastRecord = 100000
iole_word.ActiveDocument.Mailmerge.Destination = wdSendToNewDocument
iole_word.ActiveDocument.MailMerge.SuppressBlankLines = True
iole_word.ActiveDocument.Mailmerge.Execute
iole_word.Visible = false
////////////////////////////////////////////////////////////////////////////////////////////////
//   'get the number of pages in the mergedoc
/////////////////////////////////////////////////////////////////////////////////////////////////
try 
li_merge_doc_pages =  iole_word.ActiveDocument.Content.ComputeStatistics(2) 
CATCH (RunTimeError rte1)
      messagebox("iole_word.ActiveDocument.Content.ComputeStatistics(2)",'OLE problem please try again.' )
		close(w_infodisp_50)
		return -1
end try
*/

String ls_datasource_filename,ls_filename
String ls_filetext,ls_file_piece[]
Int i
long ll_pos ,ll_rowcount,ll_filelen
ls_datasource_filename = iole_word.ActiveDocument.MailMerge.DataSource.name

//Start Code Change ----02.15.2010 #V10 maha - corrected to variable that actually brings in a path
ls_filename = gs_temp_path +'merge_temp.txt'
FileCopy ( ls_datasource_filename, ls_filename ,true )
//FileCopy ( ls_datasource_filename, gs_application_path +'\merge_temp.txt' ,true )
//ls_filename = gs_application_path +'\merge_temp.txt'
//End Code Change---02.15.2010

inv_filesrv.of_fileread( ls_filename,ls_file_piece[])
For i = 1 to UpperBound(ls_file_piece[])
	ls_filetext += ls_file_piece[i]  //Only support file size < 2147483647
Next
ll_filelen = LenA(ls_filetext)
filedelete(ls_filename)
Do 
	ll_pos = PosA(ls_filetext,'~r~n',ll_pos + 1)
	If ll_pos > 0 and ll_pos <> ll_filelen - 1  Then ll_rowcount++
Loop while ll_pos > 0
li_merge_doc_pages = ll_rowcount
//---------------------------- APPEON END ----------------------------


/////////////////////////////////////////////////////////////////////////////////////////////////
// make  the fax docs
/////////////////////////////////////////////////////////////////////////////////////////////////

//Used to set criteria for moving through the document by page. 
iole_word.Application.Browser.Target = wdBrowsePage 
w_infodisp_50.wf_set_min_max(1,li_merge_doc_pages)


/////////////////////////////////////////////////////////////////////////////////////////////////
// USE THE NAME OF THE WORD DOCUMENT NOT FAX_
/////////////////////////////////////////////////////////////////////////////////////////////////
STRING LS_PARSE_ARRAY[]
STRING LS_DOC_NAME
inv_string.OF_PArsetoarray(is_letter_path , '\', LS_PARSE_ARRAY)
LS_DOC_NAME =  LS_PARSE_ARRAY[UPPERBOUND(LS_PARSE_ARRAY)]
// NOW REMOVE THE THE .DOC PART
STRING LS_PARSE_ARRAY1[]
inv_string.OF_PArsetoarray(LS_DOC_NAME , '.', LS_PARSE_ARRAY1)
LS_DOC_NAME =  LS_PARSE_ARRAY1[1]
//---------Begin Modified by (Appeon)Stephen 03.17.2014 for V141 Import Modifications for Facility and Group--------
//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
//gnv_rights.of_check_dir_right(LS_DOC_NAME, true, 'Fax Document Save')	
//---------End Added ------------------------------------------------------------------
gnv_rights.of_check_dir_right(is_directory, true, 'Fax Document Save')	
//---------End Modfiied ------------------------------------------------------

For ll_i = 1 To li_merge_doc_pages
		w_infodisp_50.st_1.text = 'Creating MicroSoft Word fax document '+ string(ll_i) + ' of '+ string(li_merge_doc_pages) +' Please stand by'
	    iole_word.Documents.Open(is_letter_path)
		//---------Begin Added by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
		gnv_word_utility.of_modify_word_property( iole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		//---------End Added ------------------------------------------------------
		//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
		gnv_shell.of_delete_recent( is_letter_path, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		//---------End Added ------------------------------------------------------------------

		iole_word.Visible = false
	    iole_word.ActiveDocument.MailMerge.DataSource.FirstRecord = ll_i
		iole_word.ActiveDocument.MailMerge.DataSource.LastRecord =  ll_i
		iole_word.ActiveDocument.Mailmerge.Destination = wdSendToNewDocument
		iole_word.ActiveDocument.MailMerge.SuppressBlankLines = True
		iole_word.ActiveDocument.Mailmerge.Execute
		is_letters_created[upperbound(is_letters_created) + 1] = LS_DOC_NAME + '_' +string(ll_i) + '.doc'
		//iole_word.ActiveDocument.SaveAs( LS_DOC_NAME + '_' +string(ll_i) + '.doc')
		iole_word.ActiveDocument.SaveAs( LS_DOC_NAME + '_' +string(ll_i) + '.doc', 0) //Word 2003 format - alfee 03.07.2013
		//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
		gnv_shell.of_delete_recent( LS_DOC_NAME + '_' +string(ll_i) + '.doc', true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		//---------End Added ------------------------------------------------------------------
		iole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		w_infodisp_50.wf_step_pbar(1)
Next 

w_infodisp_50.st_1.text = 'Fax Documuments completed'
w_infodisp_50.wf_step_pbar(1)

iole_word.ActiveDocument.Close(wdDoNotSaveChanges)
iole_word.Quit(wdDoNotSaveChanges)

of_dissconnect_from_word( )

close(w_infodisp_50)
// end code change --- 11.08.2005 MSKINNER
return 1
end function

public function integer of_delete_fax_documents ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_documents
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [string]  as_search
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


Integer li_cnt, li_entries
String ls_import
String ls_currdir
long ll_i

//n_cst_filesrvwin32 inv_filesrv
//inv_filesrv = create n_cst_filesrvwin32
n_cst_dirattrib lnv_dirlist[]
SetPointer(HourGlass!)

//---------Begin Added by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
//ls_currdir = gs_dir_path + "IntelliCred\Fax\*.*"
ls_currdir = gs_temp_path + "Fax\*.*"
//---------End Added ------------------------------------------------------
li_entries = inv_filesrv.of_DirList(ls_currdir, 0, lnv_dirlist)

for ll_i = 1 to upperbound(lnv_dirlist)
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 11.20.2012
	//$<reason> 
	/* Bug 3316 -Issues with Faxing combine
	FileDelete ( gs_dir_path + "IntelliCred\Fax\" + lnv_dirlist[ll_i].is_filename )
	*/
    if FileDelete ( gs_temp_path + "Fax\" + lnv_dirlist[ll_i].is_filename ) <>  true then 
		messagebox("File Delete Error","The temporary file "+ gs_temp_path + "Fax\" + lnv_dirlist[ll_i].is_filename  +" cannot be deleted, please clear it out manually and re-run the program.")
		SetPointer(arrow! )
		return -1
	end if
	//------------------- APPEON END -------------------
next

SetPointer(arrow! )

return 0



end function

public function integer of_createdatasource (powerobject apo_data, string as_path);//====================================================================
// $<function> of_createdatasource()
// $<arguments>
// 	value	powerobject	apo_data
// 	value	string		as_path
// $<returns> integer
// $<description> Create mail merge data source
// $<add> (Appeon) evan 09.16.2011
//====================================================================

datastore lds_ds
datastore lds_data
datawindow ldw_dw
long ll_FindRow, ll_RowCount
long ll_Column, ll_ColumnCount
long ll_Pos1, ll_Pos2, ll_Len
string ls_Name, ls_ColType, ls_Value
n_cst_string lnv_string
integer li_rc

// Create datastore object
lds_data = Create datastore
if apo_data.TypeOf() = DataWindow! then
	ldw_dw = apo_data
	lds_data.DataObject = ldw_dw.DataObject
	ldw_dw.RowsCopy(1, ldw_dw.RowCount(), Primary!, lds_data, 1, Primary!)
else
	lds_ds = apo_data
	lds_data.DataObject = lds_ds.DataObject
	lds_ds.RowsCopy(1, lds_ds.RowCount(), Primary!, lds_data, 1, Primary!)
end if
ll_RowCount = lds_data.RowCount()
if ll_RowCount < 1 then Return 1

// Replace double quote process
ll_ColumnCount = Long(lds_data.Describe("datawindow.column.count"))
for ll_Column = 1 to ll_ColumnCount
	// Determine the column if character type
	ls_Name = lds_data.Describe("#" + String(ll_Column) + ".Name")
	ls_ColType = lds_data.Describe(ls_Name + ".ColType")
	if Pos(lower(ls_ColType), "char") < 1 then Continue
	ll_Pos1 = Pos(ls_ColType, "(")
	ll_Pos2 = Pos(ls_ColType, ")")
	ll_Len = Long(Mid(ls_ColType, ll_Pos1 + 1, ll_Pos2 - ll_Pos1 - 1))
	
	// Replace double quote in data
	ll_FindRow = 0
	do
		ll_FindRow = lds_data.Find(ls_Name + " like '%~"%'", ll_FindRow + 1, ll_RowCount)
		if ll_FindRow > 0 then
			ls_Value = lds_data.GetItemString(ll_FindRow, ls_Name)
			if Len(ls_Value) = ll_Len then
				ls_Value = lnv_string.of_GlobalReplace(ls_Value, '"', '')
				lds_data.SetItem(ll_FindRow, ls_Name, ls_Value)
			elseif AppeonGetClientType() = "PB" then
				if Left(ls_Value, 1) <> '"' then
					ls_Value = lnv_string.of_GlobalReplace(ls_Value, '"', '""')
					lds_data.SetItem(ll_FindRow, ls_Name, ls_Value)
				end if
			else
				ls_Value = lnv_string.of_GlobalReplace(ls_Value, '"', '""')
				lds_data.SetItem(ll_FindRow, ls_Name, ls_Value)
			end if
		end if
	loop until (ll_FindRow < 1 or ll_FindRow = ll_RowCount)
next

// Create mail merge data source
li_rc = lds_data.SaveAs(as_Path, Text!, true)
Destroy lds_data

Return li_rc
end function

public function integer of_delete_file (string as_path);//====================================================================
//$<Function>: of_delete_file
//$<Arguments>:as_path
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-09-06 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_cnt, li_entries
String ls_import
String ls_currdir
long ll_i

n_cst_dirattrib lnv_dirlist[]
SetPointer(HourGlass!)


ls_currdir = as_path + "*.*"
li_entries = inv_filesrv.of_DirList(ls_currdir, 0, lnv_dirlist)

for ll_i = 1 to upperbound(lnv_dirlist)
    if FileDelete ( as_path + lnv_dirlist[ll_i].is_filename ) <>  true then 
		messagebox("File Delete Error","The temporary file "+ as_path + lnv_dirlist[ll_i].is_filename  +" cannot be deleted, please clear it out manually and re-run the program.")
		SetPointer(arrow! )
		return -1
	end if
next

SetPointer(arrow! )

return 0



end function

on n_cst_msword.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_msword.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_directory = gs_temp_path + "fax\"

inv_filesrv = create n_cst_filesrvwin32

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// check to see the directory exists if it does not then create it
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

IF NOT inv_filesrv.of_DirectoryExists (is_directory) THEN
       inv_filesrv.of_CreateDirectory (is_directory)
END IF

// start code change --- 11.09.2005 MSKINNER
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// the followinf will remove the "Opening this will run the following SQL command" message
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string ls_PROGRAMDIR
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.18.2006 By: Cao YongWang
//$<reason> The RegistryGet and Registryset function are not supported directly. 
//$<reason> Using DLL function to rewrite these function in web application.
/*

RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options", "PROGRAMDIR", regstring!, ls_PROGRAMDIR)

if f_validstr( ls_PROGRAMDIR) then 
	Registryset("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options", "SQLSecurityCheck", ReguLong!, 00000000)
end if 

RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Options", "PROGRAMDIR", regstring!, ls_PROGRAMDIR)

if f_validstr( ls_PROGRAMDIR) then 
	Registryset("HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Options", "SQLSecurityCheck", ReguLong!, 00000000)
end if 
*/
If appeongetclienttype() = 'PB' Then
	
	RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options", "PROGRAMDIR", regstring!, ls_PROGRAMDIR)
	
	if f_validstr( ls_PROGRAMDIR) then 
		Registryset("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options", "SQLSecurityCheck", ReguLong!, 00000000)
	end if 
	
	RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Options", "PROGRAMDIR", regstring!, ls_PROGRAMDIR)
	
	if f_validstr( ls_PROGRAMDIR) then 
		Registryset("HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Options", "SQLSecurityCheck", ReguLong!, 00000000)
	end if 
Else
	
	gnv_appeondll.of_RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options", "PROGRAMDIR", regstring!, ls_PROGRAMDIR)
	
	if f_validstr( ls_PROGRAMDIR) then 
		gnv_appeondll.of_Registryset("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options", "SQLSecurityCheck", ReguLong!, 00000000)
	end if 
	
	gnv_appeondll.of_RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Options", "PROGRAMDIR", regstring!, ls_PROGRAMDIR)
	
	if f_validstr( ls_PROGRAMDIR) then 
		gnv_appeondll.of_Registryset("HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Options", "SQLSecurityCheck", ReguLong!, 00000000)
	end if 
End If
//---------------------------- APPEON END ----------------------------

// end code change --- 11.09.2005 MSKINNER


	




end event

event destructor;


if isvalid(w_infodisp) then
  close(w_infodisp)
end if

of_dissconnect_from_word( )

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(inv_filesrv) then Destroy inv_filesrv
//---------------------------- APPEON END ----------------------------
end event

