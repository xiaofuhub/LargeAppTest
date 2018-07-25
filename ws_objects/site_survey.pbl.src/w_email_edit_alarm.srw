$PBExportHeader$w_email_edit_alarm.srw
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type w_email_edit_alarm from window
end type
type ole_word from u_word_edit within w_email_edit_alarm
end type
end forward

global type w_email_edit_alarm from window
boolean visible = false
integer width = 1243
integer height = 876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
ole_word ole_word
end type
global w_email_edit_alarm w_email_edit_alarm

type variables
OleObject				iole_Word
String 					is_filepath
String 					is_fkeyword = "$$<|" , is_lkeyword = "|>$$" 
String						is_findkey = '$$\<|*|\>$$'
end variables

forward prototypes
public function integer of_readfile (string as_file, ref blob ablb_data)
public function integer of_openword (blob ab_word)
public function integer of_writefile (string as_filename, ref blob ablb_data)
public function integer of_get_keyword (ref string as_ctx_id, ref string as_doc_id, ref string as_ai_id)
public function integer of_add_keyword (string as_ctx_id, string as_doc_id, string as_ai_id)
public function integer of_close ()
public function string of_getemaildir ()
public function string of_gettempfile ()
public function string of_gethtmlfile ()
public function integer of_insertfilefirst (string as_filename)
public function integer of_insertfilefirst (ref blob ablb_data)
public function integer of_insertfilelast (string as_filename, boolean ab_insertbreak)
public function integer of_insertfilelast (string as_filename)
public function integer of_insertfilelast (ref blob ablb_data)
public function integer of_inserttextlast (string as_text, boolean ab_insertbreak)
public function integer of_inserttextlast (string as_text)
public function integer of_inserttextfirst (string as_text)
public function integer of_open (string as_text, boolean ab_isfile)
public function integer of_open (string as_userid)
public function integer of_open (ref blob ablb_data)
public function integer of_open ()
public function integer of_open_buffer (ref blob ablb_data)
public function integer of_getblob (ref blob ablb_data)
public function boolean of_checkreplace ()
public function string of_gettxtfile ()
public function string of_gettempfile (string as_filename, string as_fileext)
end prototypes

public function integer of_readfile (string as_file, ref blob ablb_data);//Modified By Ken.Guo 2010-05-12
n_cst_dm_utils lnv_dm_utils
Return lnv_dm_utils.of_readblob( as_file, ablb_data)

/*
long ll_Byte
integer li_FileNum
blob lblb_Buf

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
*/
Return 1
end function

public function integer of_openword (blob ab_word);Integer			ConnectErr, li_i
String				ls_File

If Not isvalid( iole_Word ) Then

	iole_Word=Create   OLEObject 
	ConnectErr=iole_Word.ConnectToNewObject   ( "word.application") 
	iole_Word.visible=false 
	
	if   isnull(iole_Word)   then   return   -1   
	if   ConnectErr   <0   then 
	  choose   case   ConnectErr 
		 case   -1 
			messagebox( 'Tips ', 'Invalid Call. ') 
		 case   -2 
			messagebox( 'Tips ', 'Class name not found. ') 
		 case   -3 
			messagebox( 'Tips ', 'Object could not be created. ') 
		 case   -4 
			messagebox( 'Tips ', 'Could not connect to object. ') 
		 case   -5 
			messagebox( 'Tips ', 'It can not connect to current object. ') 
		 case   -6 
			messagebox( 'Tips ', 'Invalid file. ') 
		 case   -7 
			messagebox( "Tips ", "File is not exists or opened ") 
		 case   -8 
			messagebox( "Tips ", "Server can not load file. ") 
		 case   -9 
			messagebox( "Tips ", "Other error. ") 
		 case else
			messagebox( "Tips ", "Other error. ") 
	  end   choose 
	  return   -1 
	end   if 
	iole_Word.Application.DisplayAlerts   =   False 
End If
ls_File = of_gettempfile( )

if of_WriteFile(ls_File, ab_word) = -1 then Return -22
For li_i = 1 to iole_Word.Documents.Count
	 iole_Word.Documents[li_i].close( )
Next

If FileExists( ls_File ) Then iole_Word.Documents.add( ls_File )

Return 1
end function

public function integer of_writefile (string as_filename, ref blob ablb_data);//Modified By Ken.Guo 2010-05-12
n_cst_dm_utils lnv_dm_utils
Return lnv_dm_utils.of_saveblob( as_filename, ablb_data)

/*
blob lblb_Buf
long ll_BlobLen
long ll_CurrentPos
long l, ll_Writes
integer li_FileNum

//Parse path
gnv_appeondll.of_parsepath(as_FileName) //jervis 07.22.2009

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

public function integer of_get_keyword (ref string as_ctx_id, ref string as_doc_id, ref string as_ai_id);Boolean lb_find
String ls_text   
//'$$<|CTX_ID = ###, DOC_ID = ###, AI_ID = ###|>$$'
//'$$<|CTX_ID = ###,### & DOC_ID = ###,### & AI_ID = ###|>$$'
Long ll_pos1,ll_pos2,ll_pos3
Long ll_pos11,ll_pos22,ll_pos33
oleobject		lole_object


lole_object = iole_Word.ActiveDocument
If Not isValid( lole_object ) Then
	MessageBox( 'Tips', 'Invalid active document.' )
	Return -1
End If

lole_object.Content.Select()
lb_find = lole_object.Activewindow.Selection.Find.Execute(is_findkey,True,False,True,False,False,True)
If Not lb_find Then Return -1

Do While lb_find
	ls_text = String(lole_object.Activewindow.Selection.Text)
	lb_find = lole_object.Activewindow.Selection.Find.Execute(is_findkey,True,False,True,False,False,True)
Loop

lole_object.Activewindow.Selection.End = lole_object.Activewindow.Selection.Start
lole_object.Activewindow.Selection.Goto(1,1)
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

public function integer of_add_keyword (string as_ctx_id, string as_doc_id, string as_ai_id);//'$$<|CTX_ID = ###,### & DOC_ID = ###,### & AI_ID = ###|>$$'
String ls_filename
String ls_keyword
String ls_ctx_id,ls_doc_id,ls_ai_id
oleobject			lole_Object


//Check Key Word Exists or Not
If of_get_keyword(ls_ctx_id,ls_doc_id,ls_ai_id) > 0 Then Return 1
lole_Object = iole_Word.ActiveDocument


If isnull(as_ctx_id) Then as_ctx_id = ''
If isnull(as_doc_id) Then as_doc_id = ''
If isnull(as_ai_id) Then as_ai_id = ''

//Add Key Word
ls_keyword = '~r~n$$<|CTX_ID = '+as_ctx_id+' & DOC_ID = '+as_doc_id+' & AI_ID = '+String(as_ai_id)+'|>$$ - Do Not Delete'
lole_Object.Content.Select()
lole_Object.ActiveWindow.Selection.Start = lole_Object.ActiveWindow.Selection.End

lole_Object.ActiveWindow.Selection.Collapse(0) //wdCollapseEnd 
lole_Object.ActiveWindow.Selection.InsertAfter(ls_keyword)
lole_Object.ActiveWindow.Selection.Expand()
lole_Object.ActiveWindow.Selection.Font.Size = 1
lole_Object.ActiveWindow.Selection.Font.Color = 16777215// 16777215.White   0.Blank
lole_Object.ActiveWindow.Selection.Font.Bold = False

lole_Object.ActiveWindow.Selection.Start = lole_Object.ActiveWindow.Selection.End
lole_Object.ActiveWindow.Selection.Goto(1,1)

Return 1

end function

public function integer of_close ();////Restore to dispaly horizontal scrollbar - Alfee 11.27.2007
//If this.object.DocType = 1 THEN 
//	this.object.ActiveDocument.ActiveWindow.DisplayHorizontalScrollBar = TRUE
//End If
iole_Word.quit( )
iole_Word.disconnectobject( )

Return 1
end function

public function string of_getemaildir ();string ls_OldDirectory
string ls_EmailDirectory
string ls_ContractDirectory

//-------------Begin Modified by Alfee 03.27.2008----------
/*
ls_ContractDirectory = gs_dir_path + gs_DefDirName
ls_EmailDirectory = ls_ContractDirectory + "\Email"
ls_OldDirectory = GetCurrentDirectory()

if DirectoryExists(ls_ContractDirectory) = false then	
	ChangeDirectory(gs_dir_path)
	if CreateDirectory(gs_DefDirName) = -1 then Return ""
end if

if DirectoryExists(ls_EmailDirectory) = false then		
	ChangeDirectory(ls_ContractDirectory)
	if CreateDirectory("Email") = -1 then Return ""
end if

ChangeDirectory(ls_OldDirectory)
*/
ls_EmailDirectory = gs_dir_path + gs_DefDirName + "\Email"
gnv_appeondll.of_parsepath(ls_EmailDirectory)
IF NOT DirectoryExists(ls_EmailDirectory) THEN RETURN ""
//-------------End Modified ----------------------------------

Return ls_EmailDirectory
end function

public function string of_gettempfile ();//Modified By Ken.Guo 12/11/2013
Return of_gettempfile('Temp','doc')

////////////////////////////////////////////////////////////////////////
//// $<function>u_email_editof_gettempfile()
//// $<arguments>(None)
//// $<returns> string
//// $<description> Get the new temp file.
//// $<description>
////////////////////////////////////////////////////////////////////////
//// $<add> 2010-10-11 by Ken.Guo
////////////////////////////////////////////////////////////////////////
//
//String ls_FileName,ls_FileName1
//Long i,ll_max
//
//ll_max = 1000 //max try times.
//is_filepath = of_GetEmailDir() 
//
//For i = 1 To ll_max
//	ls_FileName = of_GetEmailDir() + "\Temp" + String(i) + ".doc"
//	If FileExists(ls_filename) Then
//		If Not FileDelete(ls_filename) Then
//			If i = ll_max Then
//				Messagebox('Delete Temporary File','Failed to delete the temporary file "Temp*.doc". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
//				Return ''
//			End If
//			Continue
//		End If
//	End If
//	
//	ls_FileName1 = of_GetEmailDir() + "\~~$Temp" + String(i) + ".doc"	
//	If FileExists(ls_filename1) Then
//		If Not FileDelete(ls_filename1) Then
//			If i = ll_max Then
//				Messagebox('Delete Temporary File','Failed to delete the temporary file "Temp*.doc". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
//				Return ''
//			End If
//			Continue
//		End If
//	End If
//	
//	Return ls_FileName
//	
//Next
//
//Return ''
end function

public function string of_gethtmlfile ();string ls_FileName

//Begin - Modified By Ken.Guo 12/12/2013
//// Save as HTML file
//ls_FileName = of_GetEmailDir() + "\Email.htm"
////ls_FileName = is_filepath + "\Email.htm"
////Added By Ken.Guo 2010-01-07.
//If FileExists(ls_filename) Then
//	If Not FileDelete(ls_filename) Then
//		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
//		Return ''
//	End If
//End If
ls_FileName = This.of_gettempfile( 'Email', 'htm')
If ls_filename = '' Then Return ''
//End - Modified By Ken.Guo 12/12/2013

iole_Word.ActiveDocument.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2010-01-07.

iole_Word.ActiveDocument.SaveAs(ls_FileName, 10,false,'',false)

gnv_shell.of_delete_recent( ls_FileName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
Return ls_FileName
end function

public function integer of_insertfilefirst (string as_filename);blob lblb_Data
string ls_FileName
OLEObject lole_Selection

// Insert file first
lole_Selection = iole_Word.ActiveDocument.ActiveWindow.Selection
lole_Selection.GoTo(1, 1)
lole_Selection.InsertFile(as_FileName)
gnv_shell.of_delete_recent( as_FileName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
lole_Selection.InsertParagraphBefore()

Return 1
end function

public function integer of_insertfilefirst (ref blob ablb_data);string ls_FileName

/*
// Create a local file
ls_FileName = of_GetEmailDir() + "\Temp2.doc"

//Added By Ken.Guo 2010-01-07.
If FileExists(ls_filename) Then
	If Not FileDelete(ls_filename) Then
		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		Return -1
	End If
End If
String ls_FileName1
ls_FileName1 = of_GetEmailDir() + "\~~$Temp2.doc"
If FileExists(ls_FileName1) Then
	FileDelete(ls_FileName1)
End If
*/
ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -1

if of_WriteFile(ls_FileName, ablb_Data) = -1 then Return -1

// Insert file first
Return of_InsertFileFirst(ls_FileName)
end function

public function integer of_insertfilelast (string as_filename, boolean ab_insertbreak);//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2010-04-13 By: Ken.Guo
//$<reason> Add ab_insertbreak Parm
//---------------------------- APPEON END ----------------------------

blob 			lblb_Data
string 		ls_FileName
OLEObject 	lole_Selection

//--------Begin Modified by Alfee 01.26.2008----------------------
Constant Long wdCollapseEnd = 0
Constant long wdSectionBreakContinuous = 3

If  Not IsValid( iole_Word ) THEN RETURN -1
If Not FileExists(as_filename) THEN RETURN -1

TRY

iole_Word.ActiveDocument.Content.Select()
lole_Selection = iole_Word.ActiveDocument.Activewindow.Selection
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

public function integer of_insertfilelast (string as_filename);Return of_insertfilelast(as_filename,true)
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

end function

public function integer of_insertfilelast (ref blob ablb_data);string ls_FileName

/*
// Create a local file
ls_FileName = of_GetEmailDir() + "\Temp3.doc"

//Added By Ken.Guo 2010-01-07.
If FileExists(ls_filename) Then
	If Not FileDelete(ls_filename) Then
		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		Return -1
	End If
End If
String ls_FileName1
ls_FileName1 = of_GetEmailDir() + "\~~$Temp3.doc"
If FileExists(ls_FileName1) Then
	FileDelete(ls_FileName1)
End If
*/
ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -1

if of_WriteFile(ls_FileName, ablb_Data) = -1 then Return -1

// Insert file last
Return of_InsertFileLast(ls_FileName)

end function

public function integer of_inserttextlast (string as_text, boolean ab_insertbreak);//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2010-04-13 By: Ken.Guo
//$<reason> Add ab_insertbreak parm
//---------------------------- APPEON END ----------------------------

blob 			lblb_Data
string		ls_FileName
OLEObject 	lole_Selection

// Write text to a word document
//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
//lblb_Data = Blob(as_Text)
lblb_Data = Blob(as_Text, EncodingAnsi!) //Encoding – Harry 11.15.2013
//---------End Modfiied ------------------------------------------------------

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

public function integer of_inserttextlast (string as_text);Return of_inserttextlast(as_text,True)
/*
blob 			lblb_Data
string		ls_FileName
OLEObject 	lole_Selection

// Write text to a word document
lblb_Data = Blob(as_Text)
ls_FileName = of_GetEmailDir() + "\Temp4.doc"

//Added By Ken.Guo 2010-01-07.
If FileExists(ls_filename) Then
	If Not FileDelete(ls_filename) Then
		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		Return -1
	End If
End If

if of_WriteFile(ls_FileName, lblb_Data) = -1 then Return -1

// Insert file last
Return of_InsertFileLast(ls_FileName)
*/

end function

public function integer of_inserttextfirst (string as_text);//----------Begin Modified by Alfee 03.27.2008-------------------------
//Insert text at the begining of the document
IF  Not IsValid( iole_Word ) THEN RETURN -1
IF IsNull(as_text) or Len(as_text) < 1 THEN RETURN 1

iole_Word.ActiveDocument.Range(0,0).InsertBefore(as_text + '~r~n')

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

public function integer of_open (string as_text, boolean ab_isfile);blob lblb_Data
string ls_FileName 
OLEObject lole_Window
integer		li_i

// Create a word document
TRY //alfee 12.11.2008

//this.object.Close()	//jervis 07.22.2009

if ab_IsFile then
	IF Not FileExists(as_text) THEN RETURN -1 //Alfee 03.27.2008
//	This.object.ActiveDocument.ActiveWindow.Application.Documents.Open(as_Text) 
//	this.object.OpenLocalFile(as_Text, true)
	for li_i = 1 to iole_Word.documents.count 
		 iole_Word.documents[li_i].close( )
	next
	
	iole_Word.documents.ADD( as_Text  )
	is_filepath = Mid(as_text,1,lastpos(as_Text,'\') - 1 )
else
	if Len(as_Text) > 0 then
		//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		//lblb_Data = Blob(as_Text)
		lblb_Data = Blob(as_Text, EncodingAnsi!) //Encoding – Harry 11.15.2013
		//---------End Modfiied ------------------------------------------------------
		/*
		ls_FileName = of_GetEmailDir() + "\Temp5.doc"
		is_filepath = of_GetEmailDir()
		//Added By Ken.Guo 2010-01-07.
		If FileExists(ls_filename) Then
			If Not FileDelete(ls_filename) Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
				Return -1
			End If
		End If		
		String ls_FileName1
		ls_FileName1 = of_GetEmailDir() + "\~~$Temp5.doc"
		If FileExists(ls_FileName1) Then
			FileDelete(ls_FileName1)
		End If
		*/
		ls_FileName = of_gettempfile()
		If ls_filename = '' Then Return -21
	
		if of_WriteFile(ls_FileName, lblb_Data) = -1 then Return -22
		
		//this.object.OpenLocalFile(ls_FileName, false) //Modified By Ken.Guo 2010-01-07
//		this.object.OpenLocalFile(ls_FileName, true) 
		for li_i = 1 to iole_Word.documents.count 
			 iole_Word.documents[li_i].close( )
		next
		iole_Word.documents.ADD( as_Text  )
	else
		//this.object.CreateNew("Word.Document") //Alfee 08.20.2008
		//----------Begin Added by Alfee 11.26.2007------------------
		//<$Reason>to support Word 2007, save as word 2003 format, it's 
		//<$Reason>necessary that close and re-open the the document
		IF gs_word_version = 'word2007' THEN
			//--------------Begin Modified by Alfee 08.20.2008-----------
			ls_FileName = of_GetEmailDir() + "\Empty.doc"				
			IF NOT FileExists(ls_FileName) THEN
//				this.object.CreateNew("Word.Document")
				iole_Word.documents.add( )
				iole_Word.ActiveDocument.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2010-01-07.
//				If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = True
				iole_Word.ActiveDocument.SaveAs(ls_FileName, 0,false,'',false) //Word 2003 format
//				If gs_ImageView_Version <> '4.0' Then This.Object.FileSave = False
				gnv_shell.of_delete_recent( ls_FileName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
				for li_i = 1 to iole_Word.documents.count 
					 iole_Word.documents[li_i].close( )
				next
				Do 
					Yield()
					IF FileExists(ls_FileName) THEN  	iole_Word.documents.ADD( ls_FileName  )						
				Loop While iole_Word.Documents.Count > 0
			ELSE
//				this.object.openLocalFile(ls_FileName, true)	
				for li_i = 1 to iole_Word.documents.count 
					 iole_Word.documents[li_i].close( )
				next
				iole_Word.documents.ADD( ls_FileName  )
			END IF	
			/* ls_FileName = of_GetEmailDir() + "\Temp.doc"	
			If FileExists(ls_FileName) Then FileDelete(ls_FileName)
			this.object.ActiveDocument.SaveAs(ls_FileName, 0) //Word 2003 format
			this.object.Close() 
			IF Not FileExists(ls_FileName) THEN RETURN -1 //Alfee 03.27.2008			
			this.object.openLocalFile(ls_FileName, true) //Evan 06.18.2008, Change false to true.
			*/
		ELSE 
//			this.object.CreateNew("Word.Document")
			iole_Word.documents.add( )
			//--------------End Modified ---------------------------------			
		END IF			
		//----------End Added ----------------------------------------						
	end if
end if

CATCH (Throwable th1) //Alfee 12.11.2008
	RETURN -23
END TRY


TRY //Alfee 03.27.2008

// Get window object
lole_Window =iole_Word.ActiveDocument.ActiveWindow

iole_Word.ActiveDocument.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2010-01-07.

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
IF iole_Word.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[2].ID = 1732 AND &
	iole_Word.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[2].Visible THEN
	iole_Word.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[2].Visible = FALSE
END IF
IF iole_Word.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[1].ID = 5757 AND &
	iole_Word.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[1].Visible THEN
	iole_Word.ActiveDocument.CommandBars.Item("Formatting").Controls.Item[1].Visible = FALSE
END IF

CATCH (Throwable th) //Alfee 03.27.2008
	Destroy lole_window	
	Return 24
END TRY

Return 1
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
if Len(lblb_Signature) > 0 then
	ll_Rtn = of_Open(lblb_Signature)
else
	ll_Rtn = of_Open()
end if

Return ll_Rtn

end function

public function integer of_open (ref blob ablb_data);string ls_FileName 

/*
// Create a local file
ls_FileName = of_GetEmailDir() + "\Temp8.doc"

is_filepath = of_GetEmailDir() 

//Added By Ken.Guo 2010-01-07.
If FileExists(ls_filename) Then
	If Not FileDelete(ls_filename) Then
		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		Return -1
	End If
End If

String ls_FileName1
ls_FileName1 = of_GetEmailDir() + "\~~$Temp8.doc"
If FileExists(ls_FileName1) Then
	FileDelete(ls_FileName1)
End If
*/

//Added By Ken.Guo 2011-07-06. 
If len(ablb_Data) = 0 or isnull(ablb_Data) Then 
	This.of_open()
End If

ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -1

if of_WriteFile(ls_FileName, ablb_Data) = -1 then Return -1

// Open file
Return of_Open(ls_FileName, true)
end function

public function integer of_open ();Return of_Open("", false)
end function

public function integer of_open_buffer (ref blob ablb_data);//For the case of opening documents continuously, e.g. email notification, 
//it needs a buffer time. - Added by Alfee on 07.08.2008

string ls_FileName 

/*
// Create a local file
ls_FileName = of_GetEmailDir() + "\Temp6.doc"

is_filepath = of_GetEmailDir()

//Added By Ken.Guo 2010-01-07.
If FileExists(ls_filename) Then
	If Not FileDelete(ls_filename) Then
		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		Return -1
	End If
End If
String ls_FileName1
ls_FileName1 = of_GetEmailDir() + "\~~$Temp6.doc"
If FileExists(ls_FileName1) Then
	FileDelete(ls_FileName1)
End If
*/
ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -11

If Not isnull(ablb_Data) Then
	if of_WriteFile(ls_FileName, ablb_Data) = -1 then Return -12
Else
	Return of_Open('')
End If

DO While Not FileExists(ls_FileName)
	Yield( )
LOOP
Yield( )

// Open file
Return of_Open(ls_FileName, true)
end function

public function integer of_getblob (ref blob ablb_data);string ls_FileName
Blob lb_ini   //Added By Ken.Guo 2009-05-14

/*
// Create a local file
ls_FileName = of_GetEmailDir() + "\Temp7.doc"

//Added By Ken.Guo 2010-01-07.
If FileExists(ls_filename) Then
	If Not FileDelete(ls_filename) Then
		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_filename+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		Return -1
	End If
End If
String ls_FileName1
ls_FileName1 = of_GetEmailDir() + "\~~$Temp7.doc"
If FileExists(ls_FileName1) Then
	FileDelete(ls_FileName1)
End If
*/
ls_FileName = of_gettempfile()
If ls_filename = '' Then Return -1

//this.object.SaveToLocal(ls_FileName, true) //This statement will lock file
iole_Word.ActiveDocument.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2010-01-07.

iole_Word.ActiveDocument.SaveAs(ls_FileName, 0,false,'',false) //Word 2003 format

gnv_shell.of_delete_recent( ls_FileName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
//END---Modify by Evan on 06/18/2008

ablb_Data = lb_ini //Added By Ken.Guo 2009-05-14. Must reset blob value.
Return of_ReadFile(ls_FileName, ablb_Data)
end function

public function boolean of_checkreplace ();string			ls_matchwildcards

If  isvalid( iole_Word ) Then
	ls_matchwildcards = "\$\<*\>\$" // means: "$<...>$"
	iole_Word.Activedocument.Content.Select()
	IF iole_Word.ActiveWindow.Selection.Find.Execute(ls_matchwildcards, false, true, true, false, false, true, 0, false, "", 0 ) Then
		Return true
	Else
	End If
	
Else
	Return true
	
End If



Return false
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
//
//====================================================================
string 		ls_FileName
integer 		li_FileNum
string 		ls_Emp_Input = '' , ls_readtxt
long 			ll_FLength,  ll_readnum

//Begin - Modified By Ken.Guo 12/12/2013
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
//End - Modified By Ken.Guo 12/12/2013

ole_word.object.ActiveDocument.Application.NormalTemplate.Saved = TRUE 
If gs_ImageView_Version <> '4.0' Then ole_word.Object.FileSave = True
ole_word.object.ActiveDocument.SaveAs(ls_FileName, 3,false,'',false)
If gs_ImageView_Version <> '4.0' Then ole_word.Object.FileSave = False
gnv_shell.of_delete_recent( ls_FileName, true) 
//Return ls_FileName

ll_FLength = FileLength64(ls_FileName)
li_FileNum = FileOpen(ls_FileName, TextMode!)

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
//
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

on w_email_edit_alarm.create
this.ole_word=create ole_word
this.Control[]={this.ole_word}
end on

on w_email_edit_alarm.destroy
destroy(this.ole_word)
end on

event close;If IsValid( iole_Word ) Then 
	iole_Word.quit(0)
	iole_Word.disconnectobject( )
	Destroy( iole_Word )
End If
	
end event

type ole_word from u_word_edit within w_email_edit_alarm
integer y = 8
integer taborder = 10
borderstyle borderstyle = stylebox!
string binarykey = "w_email_edit_alarm.win"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
06w_email_edit_alarm.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
16w_email_edit_alarm.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
