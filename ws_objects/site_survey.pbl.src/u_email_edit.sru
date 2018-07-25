$PBExportHeader$u_email_edit.sru
$PBExportComments$(Appeon)Eugene 06.28.2013 - V141 ISG-CLX
forward
global type u_email_edit from olecustomcontrol
end type
end forward

global type u_email_edit from olecustomcontrol
integer width = 1623
integer height = 976
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "u_email_edit.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
event onfilecommand ( integer item,  ref boolean iscancel )
event ondocumentopened ( string file,  oleobject document )
event ondocumentclosed ( )
event afterpreviewclosed ( )
event onstatuschange ( string statustext,  long statuscode )
event onwebgetfinished ( string retdata )
event onwebexecutefinished ( string retdata )
event oncustommenucmd ( long menuindex,  string menucaption,  long mymenuid )
event oncustomfilemenucmd ( long menuindex,  string menucaption,  long mymenuid )
event afterhandsignordraw ( long draworsign,  boolean iscanceled )
event afterchecksign ( )
event onsignselect ( boolean isvalidsign,  string signinfo )
event onsheetselectionchange ( string sheetname,  long row,  long col,  oleobject selectionrange )
event onsheetbeforedoubleclick ( string sheetname,  long row,  long col,  ref boolean iscancel )
event onsheetbeforerightclick ( string sheetname,  long row,  long col,  ref boolean iscancel )
event onwordwpsselchange ( oleobject selection )
event onsheetchange ( string sheetname,  long row,  long col )
event oncustommenucmd2 ( long menupos,  long submenupos,  long subsubmenupos,  string menucaption,  long mymenuid )
event afteropenfromurl ( oleobject document,  long statuscode )
event beforeoriginalmenucommand ( string menutitle,  ref boolean iscancel )
event beforeaddsign ( string signname,  string signuser,  ref boolean iscancel )
event ondocactivated ( boolean isactivated )
event onprintprnfromurlevent ( long statuscode,  string url,  string docname,  string moreinfo )
event onwordbeforerightclick ( oleobject selection,  ref boolean iscancel )
event onpptbeforerightclick ( oleobject selection,  ref boolean iscancel )
event beforedocuploaded ( oleobject controlfiledata )
event onbeforedosecsign ( string username,  string signname,  string signuser,  string signsn,  ref boolean iscancel )
event onbeforedosecsignfromekey ( string username,  string signname,  string signuser,  string signsn,  string ekeysn,  ref boolean iscancel )
event afterpublishaspdftourl ( string retdata,  long errorcode )
event onpptslideshowbegin ( )
event onpptslideshowend ( )
event onpptslideshownextslide ( )
event onsecsignsetinfo ( string username,  long signtype,  oleobject secsignobject )
event onwordbeforedoubleclick ( oleobject selection,  ref boolean iscancel )
event oncustombuttononmenucmd ( long btnpos,  string btncaption,  long btnid )
event onscreenmodechanged ( boolean isfullscreenmode )
event onsecsigndeleted ( string username,  string signname,  string signuser,  string signsn,  string ekeysn,  string userdata )
event afterfilecommand ( integer item )
event afterpublishasntkftourl ( string retdata,  long errorcode )
event aftersaveasntkftolocal ( string fname,  long errorcode )
event oncustomtoolbarcommand ( long buttonindex )
event onsheetfollowhyperlink ( oleobject sheet,  oleobject linktarget )
event onsecsignfinished ( boolean bisok,  oleobject secsignobject )
event onurloperationcompleted ( long uloperationtype,  long ulstatcode,  string bstrretdata )
event onbeginopenfromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddtemplatefromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddpicfromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddsignfromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddsecsignfromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onisurlsignpassok ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddncotemplatefromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event ondoproofreadurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event ondowebget ( long lfunctype,  long lstatcode,  string bstrretdata )
event ondowebexecute ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsavetourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsavehandsigntourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsaveasgiffilestourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onpublishashtmltourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsaveasotherformattourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsaveasprnfiletourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onpublishaspdftourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onpublishasntkftourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsavencotourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onopenncofromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event ondowebexecute2 ( long lfunctype,  long lstatcode,  string bstrretdata )
event aftersaveaspdffile ( long errorcode )
event onclickhyperlink ( string bstrname,  ref boolean iscancel )
event onclickcustomcontextmenu ( long menuindex )
event onbeforeleftclick ( )
event aftersavetolocal ( string bstrpath )
event aftersavetourl ( string bstrurl )
event beforetoolbarsign ( )
event aftertoolbarsign ( boolean bisok )
end type
global u_email_edit u_email_edit

type variables
//---------Begin Added by (Appeon)Toney 06.26.2013 for V141 ISG-CLX--------
String is_filepath
String is_fkeyword = "$$<|" , is_lkeyword = "|>$$" 
String is_findkey = '$$\<|*|\>$$'
//---------End Added ------------------------------------------------------------------

Boolean ib_fullscreen = false //(Appeon)Harry 08.04.2014 Bug 4093
end variables

forward prototypes
public function integer of_add_keyword (string as_ctx_id, string as_doc_id, string as_ai_id)
public function boolean of_checkreplace ()
public function integer of_close ()
public function integer of_readfile (string as_file, ref blob ablb_data)
public function integer of_writefile (string as_filename, ref blob ablb_data)
public function string of_getemaildir ()
public function string of_gethtmlfile ()
public function string of_gethtmlfile (integer ai_word)
public function string of_gettempfile ()
public function integer of_getblob (ref blob ablb_data)
public function integer of_insertfilefirst (string as_filename)
public function integer of_insertfilefirst (ref blob ablb_data)
public function integer of_insertfilelast (string as_filename, boolean ab_insertbreak)
public function integer of_insertfilelast (string as_filename)
public function integer of_insertfilelast (ref blob ablb_data)
public function integer of_inserttextfirst (string as_text)
public function integer of_inserttextlast (string as_text, boolean ab_insertbreak)
public function integer of_inserttextlast (string as_text)
public function integer of_open (string as_text, boolean ab_isfile)
public function integer of_open ()
public function integer of_open (ref blob ablb_data)
public function integer of_open (string as_userid)
public function integer of_open_buffer (ref blob ablb_data)
public function string of_gettxtfile ()
public function string of_gettempfile (string as_filename, string as_fileext)
public function integer of_get_keyword (ref string as_ctx_id, ref string as_doc_id, ref string as_ai_id)
end prototypes

event onscreenmodechanged(boolean isfullscreenmode);//---------Begin Added by (Appeon)Harry 08.04.2014 for Bug 4093
if AppeonGetClientType() = "WEB"  and isfullscreenmode then
	if this.getparent( ).classname( ) = "w_dm_comparison_wizard" then 
		if ib_fullscreen then return

		ib_fullscreen = true
		this.object.FullScreenMode = false
		this.object.FullScreenMode = true
	end if
end if
//---------End Added ------------------------------------------------------
end event

public function integer of_add_keyword (string as_ctx_id, string as_doc_id, string as_ai_id);//====================================================================
//$<Function>: of_add_keyword
//$<Arguments>:
// 	value    string    as_ctx_id
// 	value    string    as_doc_id
// 	value    string    as_ai_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Toney 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//'$$<|CTX_ID = ###,### & DOC_ID = ###,### & AI_ID = ###|>$$'
String ls_filename
String ls_keyword
String ls_ctx_id,ls_doc_id,ls_ai_id

//Check Key Word Exists or Not
If of_get_keyword(ls_ctx_id,ls_doc_id,ls_ai_id) > 0 Then Return 1

If isnull(as_ctx_id) Then as_ctx_id = ''
If isnull(as_doc_id) Then as_doc_id = ''
If isnull(as_ai_id) Then as_ai_id = ''

//Add Key Word
ls_keyword = '~r~n$$<|CTX_ID = '+as_ctx_id+' & DOC_ID = '+as_doc_id+' & AI_ID = '+String(as_ai_id)+'|>$$ - Do Not Delete'
This.object.ActiveDocument.Content.Select()
This.object.ActiveDocument.ActiveWindow.Selection.Start = This.object.ActiveDocument.ActiveWindow.Selection.End

This.object.ActiveDocument.ActiveWindow.Selection.Collapse(0) //wdCollapseEnd 
This.object.ActiveDocument.ActiveWindow.Selection.InsertAfter(ls_keyword)
This.object.ActiveDocument.ActiveWindow.Selection.Expand()
This.object.ActiveDocument.ActiveWindow.Selection.Font.Size = 1
This.object.ActiveDocument.ActiveWindow.Selection.Font.Color = 16777215// 16777215.White   0.Blank
This.object.ActiveDocument.ActiveWindow.Selection.Font.Bold = False

This.object.ActiveDocument.ActiveWindow.Selection.Start = This.object.ActiveDocument.ActiveWindow.Selection.End
This.object.ActiveDocument.ActiveWindow.Selection.Goto(1,1)

Return 1

end function

public function boolean of_checkreplace ();//====================================================================
//$<Function>: of_checkreplace
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: 
//$<Author>: (Appeon) Eugene 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string			ls_matchwildcards

If  isvalid( This ) Then
	ls_matchwildcards = "\$\<*\>\$" // means: "$<...>$"
	this.object.ActiveDocument.Content.Select()
	IF This.Object.ActiveDocument.Activewindow.Selection.Find.Execute(ls_matchwildcards, false, true, true, false, false, true, 0, false, "", 0 ) Then
		Return true
	Else
	End If
	
Else
	Return true
	
End If



Return false
end function

public function integer of_close ();////Restore to dispaly horizontal scrollbar - Alfee 11.27.2007
//If this.object.DocType = 1 THEN 
//	this.object.ActiveDocument.ActiveWindow.DisplayHorizontalScrollBar = TRUE
//End If

this.object.Close()

Return 1
end function

public function integer of_readfile (string as_file, ref blob ablb_data);//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
	long ll_Byte
	integer li_FileNum
	blob lblb_Buf
	long ll_ReadLength
	long ll_FileLength
	
	if not FileExists(as_File) then Return -1
	
	ll_FileLength = FileLength(as_File)
	ablb_Data = Blob(Space(ll_FileLength),EncodingAnsi!) //Encoding – Nova 11.16.2010
	
	ll_ReadLength = AppeonReadFile(as_File, ablb_Data, ll_FileLength)
	if ll_ReadLength < 0 then
		ablb_Data = Blob("",EncodingAnsi!) //Encoding – Nova 11.16.2010
		Return -1
	end if      
  */
//Modified By Ken.Guo 2010-05-12
n_cst_dm_utils lnv_dm_utils
Return lnv_dm_utils.of_readblob( as_file, ablb_data)  
//---------End Modfiied ------------------------------------------------------------------



Return 1


/* Delete by Evan on 01.25.2010 (V10.1 - Notification Alert)
li_FileNum = FileOpen(as_File, StreamMode!, Read!, Shared!)
if li_FileNum = -1 then 
	SetNull(ablb_Data)
	Return -1
end if

do
	ll_Byte = FileRead(li_FileNum, lblb_Buf)
	if ll_Byte > 0 then
		ablb_Data += lblb_Buf
	else
		Exit
	end if
loop while true
FileClose(li_FileNum)

Return 1
*/
end function

public function integer of_writefile (string as_filename, ref blob ablb_data);//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
	blob lblb_Buf
	long ll_BlobLen
	long ll_CurrentPos
	long l, ll_Writes
	integer li_FileNum
	long ll_WriteLength
	
	if FileExists(as_FileName) then
		if not FileDelete(as_FileName) then
			Return -1
		end if
	end if
	
	ll_BlobLen = LenA(ablb_Data)
	ll_WriteLength = AppeonWriteFile(as_FileName, ablb_Data, ll_BlobLen)
	if ll_WriteLength < 0 then Return -1
	
	Return 1      
  */
//Modified By Ken.Guo 2010-05-12
n_cst_dm_utils lnv_dm_utils
Return lnv_dm_utils.of_saveblob( as_filename, ablb_data)  
//---------End Modfiied ------------------------------------------------------------------


/* Delete by Evan on 01.25.2010 (V10.1 - Notification Alert)
// Create a local file
//---------Begin Modified by Alfee 03.27.2008------------------------------------
li_FileNum = FileOpen(as_FileName, StreamMode!, Write!, LockWrite!, Replace!)
if IsNull(li_FileNum) or li_FileNum < 0 then Return -1
//li_FileNum = FileOpen(as_FileName, StreamMode!, Write!, LockReadWrite!, Replace!)
//if li_FileNum < 0 then Return -1
//---------End Modified ---------------------------------------------------------

ll_BlobLen = Len(ablb_Data)

// Write data
if ll_BlobLen > 0 then
	if ll_BlobLen > 32765 then
		 if Mod(ll_BlobLen, 32765) = 0 then
			 ll_Writes = ll_BlobLen / 32765
		 else
			 ll_Writes = (ll_BlobLen / 32765) + 1
		 end if
	else
		ll_Writes = 1
	end if
	ll_CurrentPos = 1
	
	For l = 1 To ll_Writes
		lblb_Buf = BlobMid(ablb_Data, ll_CurrentPos, 32765)
		ll_CurrentPos += 32765
		if FileWrite(li_FileNum, lblb_Buf) = -1 then
			FileClose(li_FileNum) //Alfee 03.27.2008
			Return -1
		end if
	Next
end if

// Close file
FileClose(li_FileNum)

Return 1
*/
end function

public function string of_getemaildir ();string ls_OldDirectory
string ls_EmailDirectory
string ls_IntelliCredDirectory

//-------------Begin Modified by Alfee 03.27.2008----------
/*
ls_IntelliCredDirectory = gs_dir_path + "IntelliCred"
ls_EmailDirectory = ls_IntelliCredDirectory + "\Email"
ls_OldDirectory = GetCurrentDirectory()

if DirectoryExists(ls_IntelliCredDirectory) = false then	
	ChangeDirectory(gs_dir_path)
	if CreateDirectory("IntelliCred") = -1 then Return ""
end if

if DirectoryExists(ls_EmailDirectory) = false then		
	ChangeDirectory(ls_IntelliCredDirectory)
	if CreateDirectory("Email") = -1 then Return ""
end if

ChangeDirectory(ls_OldDirectory)
*/
ls_EmailDirectory = gs_temp_path + "Email"
gnv_appeondll.of_parsepath(ls_EmailDirectory)
IF NOT DirectoryExists(ls_EmailDirectory) THEN RETURN ""
//-------------End Modified ----------------------------------

Return ls_EmailDirectory
end function

public function string of_gethtmlfile ();string ls_FileName

//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
/*
// Save as HTML file
ls_FileName = of_GetEmailDir() + "\Email.htm"
//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
   this.object.ActiveDocument.SaveAs(ls_FileName, 8)   
  */
//Added By Ken.Guo 2010-01-07.
If FileExists(ls_filename) Then
	If Not FileDelete(ls_filename) Then
		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		Return ''
	End If
End If
*/
ls_FileName = This.of_gettempfile( 'Email', 'htm')
If ls_filename = '' Then Return ''
//---------End Modfiied Harry 01.22.2014------------------------------------------------------

this.object.ActiveDocument.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2010-01-07.
If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = True
this.object.ActiveDocument.SaveAs(ls_FileName, 10,false,'',false)
If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = False
gnv_shell.of_delete_recent( ls_FileName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
//---------End Modfiied ------------------------------------------------------------------

Return ls_FileName
end function

public function string of_gethtmlfile (integer ai_word);//////////////////////////////////////////////////////////////////////
// $<event> of_gethtmlfile
// $<arguments>ai_word a flag:1 create word file
// $<returns>string :HTML file name
// $<description> Fixed a bug2540 - Easy Mail not logging
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 08.02.2011
//////////////////////////////////////////////////////////////////////
string ls_FileName

If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = True //BugT092701 - Alfee 10.11.2013

// Save as word file
ls_FileName = of_GetEmailDir() + "\Email.doc"
this.object.ActiveDocument.SaveAs(ls_FileName, 0)

// Save as HTML file
ls_FileName = of_GetEmailDir() + "\Email.htm"
this.object.ActiveDocument.SaveAs(ls_FileName, 8)

If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = False  //BugT092701 - Alfee 10.11.2013

Return ls_FileName
end function

public function string of_gettempfile ();
//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
//Modified By Ken.Guo 12/11/2013
Return of_gettempfile('Temp','doc')
/*
//////////////////////////////////////////////////////////////////////
// $<function>u_email_editof_gettempfile()
// $<arguments>(None)
// $<returns> string
// $<description> Get the new temp file.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-10-11 by Ken.Guo
//(Appeon)Eugene 06.26.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

String ls_FileName,ls_FileName1
Long i,ll_max

ll_max = 1000 //max try times.
is_filepath = of_GetEmailDir() 

For i = 1 To ll_max
	ls_FileName = of_GetEmailDir() + "\Temp" + String(i) + ".doc"
	If FileExists(ls_filename) Then
		If Not FileDelete(ls_filename) Then
			If i = ll_max Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "Temp*.doc". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
				Return ''
			End If
			Continue
		End If
	End If
	
	ls_FileName1 = of_GetEmailDir() + "\~~$Temp" + String(i) + ".doc"	
	If FileExists(ls_filename1) Then
		If Not FileDelete(ls_filename1) Then
			If i = ll_max Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "Temp*.doc". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
				Return ''
			End If
			Continue
		End If
	End If
	
	Return ls_FileName
	
Next

Return ''
*/
//---------End Modfiied ------------------------------------------------------
end function

public function integer of_getblob (ref blob ablb_data);string ls_FileName
//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
	// Create a local file
	ls_FileName = of_GetEmailDir() + "\Temp.doc"
	//BEGIN---Modify by Evan on 06/18/2008
	//this.object.SaveToLocal(ls_FileName, true) //This statement will lock file
	this.object.ActiveDocument.SaveAs(ls_FileName, 0) //Word 2003 format
	//END---Modify by Evan on 06/18/2008      
  */
Blob lb_ini   //Added By Ken.Guo 2009-05-14
ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -1

//this.object.SaveToLocal(ls_FileName, true) //This statement will lock file
this.object.ActiveDocument.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2010-01-07.
If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = True
this.object.ActiveDocument.SaveAs(ls_FileName, 0,false,'',false) //Word 2003 format
If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = False
gnv_shell.of_delete_recent( ls_FileName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
//END---Modify by Evan on 06/18/2008

ablb_Data = lb_ini //Added By Ken.Guo 2009-05-14. Must reset blob value.
//---------End Modfiied ------------------------------------------------------------------



Return of_ReadFile(ls_FileName, ablb_Data)
end function

public function integer of_insertfilefirst (string as_filename);blob lblb_Data
string ls_FileName
OLEObject lole_Selection

// Insert file first
lole_Selection = this.object.ActiveDocument.ActiveWindow.Selection
lole_Selection.GoTo(1, 1)
lole_Selection.InsertFile(as_FileName)
//---------Begin Added by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
gnv_shell.of_delete_recent( as_FileName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
//---------End Added ------------------------------------------------------------------
lole_Selection.InsertParagraphBefore()

Return 1
end function

public function integer of_insertfilefirst (ref blob ablb_data);string ls_FileName

// Create a local file
//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
   ls_FileName = of_GetEmailDir() + "\Temp.doc"   
  */
ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -1
//---------End Modfiied ------------------------------------------------------------------


if of_WriteFile(ls_FileName, ablb_Data) = -1 then Return -1

// Insert file first
Return of_InsertFileFirst(ls_FileName)
end function

public function integer of_insertfilelast (string as_filename, boolean ab_insertbreak);//====================================================================
//$<Function>: of_insertfilelast
//$<Arguments>:
// 	value    string     as_filename
// 	value    boolean    ab_insertbreak
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Eugene 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2010-04-13 By: Ken.Guo
//$<reason> Add ab_insertbreak Parm
//---------------------------- APPEON END ----------------------------

blob 			lblb_Data
string 		ls_FileName
OLEObject 	lole_Selection

//--------Begin Modified by Alfee 01.26.2008----------------------
Constant Long wdCollapseEnd = 0
Constant long wdSectionBreakContinuous = 3

If This.Object.DocType <> 1 THEN RETURN -1
If Not FileExists(as_filename) THEN RETURN -1

TRY

This.Object.ActiveDocument.Content.Select()
lole_Selection = This.Object.ActiveDocument.Activewindow.Selection
//Insert the specified file at the end
lole_Selection.Collapse(wdCollapseEnd)
If ab_insertbreak Then
	lole_Selection.InsertBreak(wdSectionBreakContinuous)	
	lole_Selection.InsertParagraphAfter()
End If
lole_Selection.InsertFile(as_filename)
gnv_shell.of_delete_recent( as_filename, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
lole_Selection.Expand()

CATCH(Throwable th)
	RETURN -1	
END TRY
/* lole_Selection = this.object.ActiveDocument.ActiveWindow.Selection
lole_Selection.GoTo(3, -1)
lole_Selection.InsertParagraphAfter()
lole_Selection.InsertFile(as_FileName)  */
//--------End Modified ------------------------------------------

Return 1

end function

public function integer of_insertfilelast (string as_filename);//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
	blob 			lblb_Data
	string 		ls_FileName
	OLEObject 	lole_Selection
	
	//--------Begin Modified by Alfee 01.26.2008----------------------
	Constant Long wdCollapseEnd = 0
	Constant long wdSectionBreakContinuous = 3
	
	If This.Object.DocType <> 1 THEN RETURN -1
	If Not FileExists(as_filename) THEN RETURN -1
	
	TRY
	
	This.Object.ActiveDocument.Content.Select()
	lole_Selection = This.Object.ActiveDocument.Activewindow.Selection
	//Insert the specified file at the end
	lole_Selection.Collapse(wdCollapseEnd)
	lole_Selection.InsertBreak(wdSectionBreakContinuous)	
	lole_Selection.InsertParagraphAfter()
	lole_Selection.InsertFile(as_filename)
	lole_Selection.Expand()
	
	CATCH(Throwable th)
		RETURN -1	
	END TRY
	/* lole_Selection = this.object.ActiveDocument.ActiveWindow.Selection
	lole_Selection.GoTo(3, -1)
	lole_Selection.InsertParagraphAfter()
	lole_Selection.InsertFile(as_FileName)  */
	//--------End Modified ------------------------------------------
	
	Return 1
  */
Return of_insertfilelast(as_filename,true)
//---------End Modfiied ------------------------------------------------------------------

end function

public function integer of_insertfilelast (ref blob ablb_data);string ls_FileName

// Create a local file
//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
 ls_FileName = of_GetEmailDir() + "\Temp.doc"     
  */
ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -1
//---------End Modfiied ------------------------------------------------------------------

if of_WriteFile(ls_FileName, ablb_Data) = -1 then Return -1

// Insert file last
Return of_InsertFileLast(ls_FileName)

end function

public function integer of_inserttextfirst (string as_text);//----------Begin Modified by Alfee 03.27.2008-------------------------
//Insert text at the begining of the document
IF This.Object.DocType <> 1 THEN RETURN -1
IF IsNull(as_text) or LenA(as_text) < 1 THEN RETURN 1

This.Object.ActiveDocument.Range(0,0).InsertBefore(as_text + '~r~n')

Return 1
/*
blob lblb_Data
string ls_FileName
OLEObject lole_Selection

// Write text to a word document
lblb_Data = Blob(as_Text)
ls_FileName = of_GetEmailDir() + "\Temp.doc"
if of_WriteFile(ls_FileName, lblb_Data) = -1 then Return -1

// Insert file first
Return of_InsertFileFirst(ls_FileName)
*/
//-------------End Modified -------------------------------------------
end function

public function integer of_inserttextlast (string as_text, boolean ab_insertbreak);//====================================================================
//$<Function>: of_inserttextlast
//$<Arguments>:
// 	value    string     as_text
// 	value    boolean    ab_insertbreak
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Eugene 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2010-04-13 By: Ken.Guo
//$<reason> Add ab_insertbreak parm
//---------------------------- APPEON END ----------------------------

blob 			lblb_Data
string		ls_FileName
OLEObject 	lole_Selection

// Write text to a word document
lblb_Data = Blob(as_Text,EncodingAnsi!)

/*
ls_FileName = of_GetEmailDir() + "\Temp4.doc"

//Added By Ken.Guo 2010-01-07.
If FileExists(ls_filename) Then
	If Not FileDelete(ls_filename) Then
		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		Return -1
	End If
End If
String ls_FileName1
ls_FileName1 = of_GetEmailDir() + "\~~$Temp4.doc"
If FileExists(ls_FileName1) Then
	FileDelete(ls_FileName1)
End If
*/
ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -1

if of_WriteFile(ls_FileName, lblb_Data) = -1 then Return -1

// Insert file last
Return of_InsertFileLast(ls_FileName,ab_insertbreak)

end function

public function integer of_inserttextlast (string as_text);//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
	blob 			lblb_Data
	string		ls_FileName
	OLEObject 	lole_Selection
	
	// Write text to a word document
	lblb_Data = Blob(as_Text,EncodingAnsi!) //Encoding – Nova 11.16.2010
	ls_FileName = of_GetEmailDir() + "\Temp.doc"
	if of_WriteFile(ls_FileName, lblb_Data) = -1 then Return -1
	
	// Insert file last
	Return of_InsertFileLast(ls_FileName)
  */
Return of_inserttextlast(as_text,True)
//---------End Modfiied ------------------------------------------------------------------

end function

public function integer of_open (string as_text, boolean ab_isfile);//====================================================================
//$<Function>: of_open()
//$<Arguments>:
// 	value    string     as_text
// 	value    boolean    ab_isfile
//$<Return>:  integer
//$<Description>: Open document 
//$<Author>: (Appeon) Eugene 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: From CLX; Add modifications in IC for BugA090402 - Alfee 09.24.2013
//====================================================================

blob lblb_Data
string ls_FileName 
OLEObject lole_Window
String ls_Emp_Input

// Create a word document
TRY //alfee 12.11.2008

gnv_debug.of_output( false, 'before open document')
if ab_IsFile then
	IF Not FileExists(as_text) THEN RETURN -1 //Alfee 03.27.2008
	If Lower(Right(as_Text,4)) = '.txt' Then 
		//Write text to word control		
		of_readfile(as_text,lblb_Data)
		//ls_Emp_Input = String(lblb_Data)
		ls_Emp_Input = String(lblb_Data, EncodingAnsi!) //Encoding – Harry 11.15.2013
		of_open()
		This.of_inserttextfirst( ls_Emp_Input)
	Else
		this.object.OpenLocalFile(as_Text, true)
		//---------Begin Added by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		gnv_word_utility.of_modify_word_property( this.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		//---------End Added ------------------------------------------------------
		is_filepath = Mid(as_text,1,lastpos(as_Text,'\') - 1 )
	End If
	gnv_debug.of_output( false, 'After opened document. ab_isfile = True. ')
else
	if Len(as_Text) > 0 then
		//lblb_Data = Blob(as_Text)
		lblb_Data = Blob(as_Text,EncodingAnsi!) //Encoding – Nova 11.16.2010
		ls_FileName = of_gettempfile()
		If ls_filename = '' Then Return -21
		
		if of_WriteFile(ls_FileName, lblb_Data) = -1 then Return -22
		IF Not FileExists(as_text) THEN RETURN -22 //Alfee 03.27.2008
		
		this.object.OpenLocalFile(ls_FileName, true) 
		//---------Begin Added by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		gnv_word_utility.of_modify_word_property( this.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.		
		//---------End Added ------------------------------------------------------
		gnv_debug.of_output( false, 'After opened document. ab_isfile = false, Len(as_text) > 0. ')	
	else
		//this.object.CreateNew("Word.Document") //Alfee 08.20.2008
		//----------Begin Added by Alfee 11.26.2007------------------
		//<$Reason>to support Word 2007, save as word 2003 format, it's 
		//<$Reason>necessary that close and re-open the the document
		IF gs_word_version = 'word2007' THEN
			//--------------Begin Modified by Alfee 08.20.2008-----------
			ls_FileName = of_GetEmailDir() + "\Empty.doc"
			
			IF FileExists(ls_FileName) AND FileLength(ls_FileName) < 1 THEN 
				IF Not FileDelete(ls_FileName) THEN RETURN -1	 //Delete the zero-byte's document - Alfee 08.23.2012				
			END IF 
			
			IF NOT FileExists(ls_FileName) THEN
				this.object.CreateNew("Word.Document")
				gnv_debug.of_output( false, 'Created Word Document. ')
				this.object.ActiveDocument.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2010-01-07.
				If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = True
				this.object.ActiveDocument.SaveAs(ls_FileName, 0,false,'',false) //Word 2003 format
				gnv_debug.of_output( false, 'After saveas document. ')	
				If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = False
				gnv_shell.of_delete_recent( ls_FileName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
				this.object.Close()
				Do 
					Yield()
					IF FileExists(ls_FileName) THEN this.object.openLocalFile(ls_FileName, true)								
				Loop While this.object.doctype <> 1
				gnv_debug.of_output( false, 'opened 2007 document. ')	
			ELSE
				this.object.openLocalFile(ls_FileName, true)	
				gnv_debug.of_output( false, 'After opened existed empty document. ')	
			END IF	
			/* ls_FileName = of_GetEmailDir() + "\Temp.doc"	
			If FileExists(ls_FileName) Then FileDelete(ls_FileName)
			this.object.ActiveDocument.SaveAs(ls_FileName, 0) //Word 2003 format
			this.object.Close() 
			IF Not FileExists(ls_FileName) THEN RETURN -1 //Alfee 03.27.2008			
			this.object.openLocalFile(ls_FileName, true) //Evan 06.18.2008, Change false to true.
			*/
			//---------Begin Added by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
			gnv_word_utility.of_modify_word_property( this.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.				
			//---------End Added ------------------------------------------------------
		ELSE 
			this.object.CreateNew("Word.Document")
			gnv_debug.of_output( false, 'After opened new document. ab_isfile = false. ')	
			//--------------End Modified ---------------------------------			
		END IF			
		//----------End Added ----------------------------------------						
	end if
end if

CATCH (Throwable th1) //Alfee 12.11.2008
	gnv_debug.of_output( true, 'opened new document. error=' + th1.text + ', doc type =' +  string( this.object.doctype ) + ', doc size =' +  string( this.object.DocSize ))
	RETURN -23
END TRY


TRY //Alfee 03.27.2008
gnv_debug.of_output( false, 'before set document properties. ')	
// Get window object
lole_Window = this.object.ActiveDocument.ActiveWindow

this.object.ActiveDocument.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2010-01-07.

//-----Begin Modified by Alfee 11.30.2007---
//Set view type as Normal View(Not WebView) 
//lole_Window.View.Type = 6
lole_Window.View.Type = 1 //wdNormalView
//-----End Modified ------------------------

// Hide rulers
lole_Window.DisplayRulers = false

//Hide paragraphs - Alfee 01.09.2008
lole_Window.ActivePane.View.ShowParagraphs = FALSE

////Hide horizontal scrollbar - Alfee 11.27.2007
//lole_Window.DisplayHorizontalScrollBar = FALSE

//Hide Document Map - Jervis 04.21.2009
lole_window.DocumentMap = False

//Added By Ken.Guo 10/11/2011. 
lole_window.View.Zoom.Percentage = 100

//Hide styles' commandbars for current document - Alfee 11.27.2007
IF this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[2].ID = 1732 AND &
	this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[2].Visible THEN
	this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[2].Visible = FALSE
END IF
IF this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[1].ID = 5757 AND &
	this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[1].Visible THEN
	this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[1].Visible = FALSE
END IF

gnv_debug.of_output( false, 'After set document properties. ')	

CATCH (Throwable th) //Alfee 03.27.2008
	Destroy lole_window	
	gnv_debug.of_output( true, 'opening new document. error=' + th.text   )	
	Return 24
END TRY

Return 1


//	blob lblb_Data
//	string ls_FileName 
//	OLEObject lole_Window
//	
//	// Create a word document
//	TRY //alfee 12.11.2008
//	
//	if ab_IsFile then
//		IF Not FileExists(as_text) THEN RETURN -1 //Alfee 03.27.2008
//		IF FileLength(as_text) < 1 THEN RETURN of_Open()	//Open a empty Word document (22kb) - Alfee 08.23.2012		
//		this.object.OpenLocalFile(as_Text, true)
//	else
//		if LenA(as_Text) > 0 then
//			lblb_Data = Blob(as_Text,EncodingAnsi!) //Encoding – Nova 11.16.2010
//			ls_FileName = of_GetEmailDir() + "\Temp.doc"		
//			if of_WriteFile(ls_FileName, lblb_Data) = -1 then Return -1
//			
//			IF Not FileExists(as_text) THEN RETURN -1 //Alfee 03.27.2008
//			this.object.OpenLocalFile(ls_FileName, true)
//		else
//			//this.object.CreateNew("Word.Document") //Alfee 08.20.2008
//			//----------Begin Added by Alfee 11.26.2007------------------
//			//<$Reason>to support Word 2007, save as word 2003 format, it's 
//			//<$Reason>necessary that close and re-open the the document
//			IF gs_word_version = 'word2007' THEN
//				//--------------Begin Modified by Alfee 08.20.2008-----------
//				ls_FileName = of_GetEmailDir() + "\Empty.doc"
//				
//				IF FileExists(ls_FileName) AND FileLength(ls_FileName) < 1 THEN 
//					IF Not FileDelete(ls_FileName) THEN RETURN -1	 //Delete the zero-byte's document - Alfee 08.23.2012				
//				END IF 
//						
//				IF NOT FileExists(ls_FileName) THEN
//					this.object.CreateNew("Word.Document")
//					this.object.ActiveDocument.SaveAs(ls_FileName, 0) //Word 2003 format
//					this.object.Close()
//					Do 
//						Yield()
//						IF FileExists(ls_FileName) THEN this.object.openLocalFile(ls_FileName, true)								
//					Loop While this.object.doctype <> 1
//				ELSE
//					this.object.openLocalFile(ls_FileName, true)							
//				END IF	
//				/* ls_FileName = of_GetEmailDir() + "\Temp.doc"	
//				If FileExists(ls_FileName) Then FileDelete(ls_FileName)
//				this.object.ActiveDocument.SaveAs(ls_FileName, 0) //Word 2003 format
//				this.object.Close() 
//				IF Not FileExists(ls_FileName) THEN RETURN -1 //Alfee 03.27.2008			
//				this.object.openLocalFile(ls_FileName, true) //Evan 06.18.2008, Change false to true.
//				*/
//			ELSE 
//				this.object.CreateNew("Word.Document")
//				//--------------End Modified ---------------------------------			
//			END IF			
//			//----------End Added ----------------------------------------						
//		end if
//	end if
//	
//	CATCH (Throwable th1) //Alfee 12.11.2008
//		RETURN -1
//	END TRY
//	
//	
//	TRY //Alfee 03.27.2008
//	
//	// Get window object
//	lole_Window = this.object.ActiveDocument.ActiveWindow
//	
//	//-----Begin Modified by Alfee 11.30.2007---
//	//Set view type as Normal View(Not WebView) 
//	//lole_Window.View.Type = 6
//	lole_Window.View.Type = 1 //wdNormalView
//	//-----End Modified ------------------------
//	
//	// Hide rulers
//	lole_Window.DisplayRulers = false
//	
//	//Hide paragraphs - Alfee 01.09.2008
//	lole_Window.ActivePane.View.ShowParagraphs = FALSE
//	
//	////Hide horizontal scrollbar - Alfee 11.27.2007
//	//lole_Window.DisplayHorizontalScrollBar = FALSE
//	
//	//Hide styles' commandbars for current document - Alfee 11.27.2007
//	IF this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[2].ID = 1732 AND &
//		this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[2].Visible THEN
//		this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[2].Visible = FALSE
//	END IF
//	IF this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[1].ID = 5757 AND &
//		this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[1].Visible THEN
//		this.object.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[1].Visible = FALSE
//	END IF
//	
//	CATCH (Throwable th) //Alfee 03.27.2008
//		Destroy lole_window	
//	END TRY
//	
//	Return 1


end function

public function integer of_open ();Return of_Open("", false)
end function

public function integer of_open (ref blob ablb_data);string ls_FileName 
long   ll_cpu  //(Appeon)Stephen 09.01.2017

//Open an empty docuemnt if no data - Alfee 08.23.2012
if IsNull(ablb_data) or lenA(ablb_data) < 1 then
	Return of_Open()	 
end if

// Create a local file
//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
    ls_FileName = of_GetEmailDir() + "\Temp.doc"  
  */
 ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -1
//---------End Modfiied ------------------------------------------------------------------

if of_WriteFile(ls_FileName, ablb_Data) = -1 then Return -1

//---------Begin Added by (Appeon)Stephen 09.01.2017 for URGENT-Healthronics- IntelliApp Scheduler/Notifications have stop running after upgrade Case#72761--------
ll_cpu = cpu()
do while not fileexists(ls_FileName)
	if cpu() - ll_cpu > 5000 then exit
loop
//---------End Added ------------------------------------------------------

// Open file
Return of_Open(ls_FileName, true)
end function

public function integer of_open (string as_userid);long	ll_EMail_Id,ll_DataLen,ll_Cycle,ll_Count,ll_Start,ll_Rtn
Blob	lblb_Signature,lb_Temp

long 	READ_ONE_LENGTH = 8000

SELECT Datalength(security_user_mailsetting.signature)
  INTO :ll_DataLen
  FROM security_user_mailsetting
 WHERE security_user_mailsetting.user_id = :as_UserID;

// Get signature from user ID
if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(signature,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM security_user_mailsetting
		     WHERE security_user_mailsetting.user_id = :as_UserID;
		
		lblb_Signature += lb_Temp
	next
else
	SELECTBLOB signature
	      INTO :lblb_Signature
	      FROM security_user_mailsetting
	     WHERE security_user_mailsetting.user_id = :as_UserID;
end if

// Open file
if LenA(lblb_Signature) > 0 then
	ll_Rtn = of_Open(lblb_Signature)
else
	ll_Rtn = of_Open()
end if

Return ll_Rtn

end function

public function integer of_open_buffer (ref blob ablb_data);//For the case of opening documents continuously, e.g. email notification, 
//it needs a buffer time. - Added by Alfee on 07.08.2008

string ls_FileName 

// Create a local file
//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
	ls_FileName = of_GetEmailDir() + "\Temp.doc"
	if of_WriteFile(ls_FileName, ablb_Data) = -1 then Return -1      
  */
ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -11

If Not isnull(ablb_Data) Then
	if of_WriteFile(ls_FileName, ablb_Data) = -1 then Return -12
Else
	Return of_Open('')
End If
//---------End Modfiied ------------------------------------------------------------------


DO While Not FileExists(ls_FileName)
	Yield( )
LOOP
Yield( )

// Open file
Return of_Open(ls_FileName, true)
end function

public function string of_gettxtfile ();//====================================================================
// Function: of_gettxtfile
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/15/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.22.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================
string 		ls_FileName
integer 		li_FileNum
string 		ls_Emp_Input = '' , ls_readtxt
long 			ll_FLength,  ll_readnum

//Begin - Modified By Ken.Guo 12/11/2013
//// Save as TXT file
//ls_FileName = of_GetEmailDir() + "\Email1.txt"
//If FileExists(ls_filename) Then
//	If Not FileDelete(ls_filename) Then
//		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
//		Return ''
//	End If
//End If

ls_FileName = This.of_gettempfile( 'Email', 'txt')
If ls_filename = '' Then Return ''
//End - Modified By Ken.Guo 12/11/2013

this.object.ActiveDocument.Application.NormalTemplate.Saved = TRUE 
If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = True
this.object.ActiveDocument.SaveAs(ls_FileName, 3,false,'',false)
If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = False
gnv_shell.of_delete_recent( ls_FileName, true) 
//Return ls_FileName

ll_FLength = FileLength64(ls_FileName)
li_FileNum = FileOpen(ls_FileName, TextMode!, Read!, shared! )

Do
	ll_readnum ++
     FileReadEx(li_FileNum, ls_readtxt)
	ls_Emp_Input = ls_Emp_Input +ls_readtxt 
Loop UNTIL ll_readnum * 32765 >= ll_FLength

FileClose(li_FileNum)

return ls_Emp_Input
end function

public function string of_gettempfile (string as_filename, string as_fileext);//====================================================================
// Function: of_gettempfile
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_filename
//                as_fileext
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/11/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2013 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.22.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================


//Added By Ken.Guo 12/11/2013
String ls_FileName,ls_FileName1
Long i,ll_max

ll_max = 1000 //max try times.
is_filepath = of_GetEmailDir() 

For i = 1 To ll_max
	ls_FileName = of_GetEmailDir() + "\" + as_filename + + String(i) + "." + as_fileext
	If FileExists(ls_filename) Then
		If Not FileDelete(ls_filename) Then
			If i = ll_max Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "'+is_filepath + '\'+as_filename+'*.'+as_fileext+'". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
				Return ''
			End If
			Continue
		End If
	End If
	
	ls_FileName1 = of_GetEmailDir() + "\~~$" + as_filename + String(i) + "." + as_fileext	 
	If FileExists(ls_filename1) Then
		If Not FileDelete(ls_filename1) Then
			If i = ll_max Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "'+is_filepath + '\'+as_filename+'*.'+as_fileext+'". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
				Return ''
			End If
			Continue
		End If
	End If
	
	If i <> 1 Then gnv_debug.of_output(True, 'Failed to delete the ' + is_filepath + '\' + as_filename + "*." + as_fileext + ' file. Now using ' + as_filename + String(i) +  "." + as_fileext + '.')
	Return ls_FileName
	
Next

Return ''
end function

public function integer of_get_keyword (ref string as_ctx_id, ref string as_doc_id, ref string as_ai_id);//====================================================================
//$<Function>: of_get_keyword
//$<Arguments>:
// 	value    string    as_ctx_id
// 	value    string    as_doc_id
// 	value    string    as_ai_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Toney 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//(Appeon)Harry 01.22.2014 - V142 ISG-CLX  Modify Pass by from value to reference
//====================================================================
Boolean lb_find
String ls_text   
//'$$<|CTX_ID = ###, DOC_ID = ###, AI_ID = ###|>$$'
//'$$<|CTX_ID = ###,### & DOC_ID = ###,### & AI_ID = ###|>$$'
Long ll_pos1,ll_pos2,ll_pos3
Long ll_pos11,ll_pos22,ll_pos33


This.object.ActiveDocument.Content.Select()
lb_find = This.object.ActiveDocument.Activewindow.Selection.Find.Execute(is_findkey,True,False,True,False,False,True)
If Not lb_find Then Return -1

Do While lb_find
	ls_text = String(This.object.ActiveDocument.Activewindow.Selection.Text)
	lb_find = This.object.ActiveDocument.Activewindow.Selection.Find.Execute(is_findkey,True,False,True,False,False,True)
Loop

This.object.ActiveDocument.Activewindow.Selection.End = This.object.ActiveDocument.Activewindow.Selection.Start
This.object.ActiveDocument.Activewindow.Selection.Goto(1,1)
ll_pos1 = Pos(ls_text,'=')
If ll_pos1 <= 0 Then Return -1
ll_pos2 = Pos(ls_text,'=',ll_pos1 + 1)
If ll_pos2 <= 0 Then Return -1
ll_pos3 = Pos(ls_text,'=',ll_pos2 + 1)
If ll_pos3 <= 0 Then Return -1

ll_pos11 = Pos(ls_text,'&') 
If ll_pos11 <= 0 Then Return -1
ll_pos22 = Pos(ls_text,'&',ll_pos11 + 1) 
If ll_pos22 <= 0 Then Return -1
ll_pos33 = Pos(ls_text,'|>$$',ll_pos22 + 1)

as_ctx_id = Trim(Mid(ls_text,ll_pos1 + 1, (ll_pos11 - ll_pos1 - 1)))
as_doc_id = Trim(Mid(ls_text,ll_pos2 + 1, (ll_pos22 - ll_pos2 - 1)))
as_ai_id  = Trim(Mid(ls_text,ll_pos3 + 1, (ll_pos33 - ll_pos3 - 1)))

//Messagebox('', String(al_ctx_id) +' ' + String(al_doc_id) + ' ' + String(al_ai_id))

Return 1

end function

event constructor;//Recreated by alfee 11.12.2013
this.object.IsResetToolbarsOnOpen = true//Alfee 11.26.2007
//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
	this.object.menubar(false)
	this.object.titlebar(false)
	this.object.statusbar(false)
	this.object.filenew = false
	this.object.fileopen = false
	this.object.filesave = false
	this.object.filesaveas = false
  */
this.object.titlebar(false)
this.object.statusbar(false)
this.object.filenew = false
this.object.fileopen = false
this.object.filesave = false
this.object.filesaveas = false
this.object.fileclose = false
this.object.fileproperties = false
//---------End Modfiied ------------------------------------------------------------------

//Set the primary key
this.object.MakerCaption="IntelliSoft Group Inc."
this.object.MakerKey="B6DE7E7AC5ECB2246623312AFA9289F069F21D6E"
//Set the title key
this.object.ProductCaption="IntelliSoft Group Inc."
this.object.ProductKey="D2FA8177167CF61E789F322B794D4DD12E86EC68"
		



end event

on u_email_edit.create
end on

on u_email_edit.destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
08u_email_edit.bin 
2F00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000080e4d62001d322fc00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000080e4d62001d322fc80e4d62001d322fc0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000024b10000193800dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000024b10000193800dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18u_email_edit.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
