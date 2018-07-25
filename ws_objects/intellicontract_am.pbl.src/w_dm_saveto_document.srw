$PBExportHeader$w_dm_saveto_document.srw
forward
global type w_dm_saveto_document from w_response
end type
type ole_1 from u_email_edit within w_dm_saveto_document
end type
type pb_1 from picturebutton within w_dm_saveto_document
end type
type cb_4 from commandbutton within w_dm_saveto_document
end type
type cb_3 from commandbutton within w_dm_saveto_document
end type
type dw_1 from u_dw within w_dm_saveto_document
end type
end forward

global type w_dm_saveto_document from w_response
integer width = 1591
integer height = 720
string title = "Save As"
long backcolor = 33551856
ole_1 ole_1
pb_1 pb_1
cb_4 cb_4
cb_3 cb_3
dw_1 dw_1
end type
global w_dm_saveto_document w_dm_saveto_document

type variables

str_add_doc istr_add_doc[] 
n_cst_image_functions_cp inv_image_cp //Alfee 11.21.2008

boolean ib_multi = False
end variables

forward prototypes
public subroutine of_save_multi_files ()
end prototypes

public subroutine of_save_multi_files ();//////////////////////////////////////////////////////////////////////
// Function: of_save_multi_files()
// Arguments:
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-29.
//--------------------------------------------------------------------
// Description: Save multi files to local
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

Integer li_file
String ls_save_type
String ls_path
String ls_filename
String ls_SourceFile
String ls_prntrs,ls_DefPrinter
long	 ll_Len
n_cst_dm_utils lnv_dm_utils //auto instantiate
n_cst_filesrvwin32  lnv_filesvr
String ls_document_files[]
String ls_doc_ext,ls_newpathfilename
long ll_cnt


//Added By Ken.Guo 2009-12-31.
integer li_ret
n_cst_clause lnv_clause
Long ll_doc_id_arr[],i
long  ll_cpu
Decimal{1} ldec_revision_arr[]
boolean lb_msg = true

ls_path = dw_1.GetItemString(1, "directory")
If right(ls_path,1) <> '\' Then  ls_path = ls_path + '\'
	
IF NOT f_validstr ( ls_path ) THEN
	MessageBox("Save As", "Please choose a directory for the document first.")
	Return
END IF	
	
gnv_appeondll.of_parsepath(ls_path)
IF NOT DirectoryExists(ls_path) THEN 
	Messagebox('Error','Failed to create the directory '+ ls_path + '.')
	Return 
End If

For i = 1 To UpperBound(istr_add_doc[])
	ll_doc_id_arr[i] = istr_add_doc[i].doc_id
	ldec_revision_arr[i] = istr_add_doc[i].revision
Next


Choose Case Upper(istr_add_doc[1].doc_from)
	Case 'CLAUSE'
		lnv_clause = Create n_cst_clause
		lnv_clause.of_download_file( ll_doc_id_arr[], ldec_revision_arr[], ls_document_files[])
	Case 'DM'
		IF NOT IsValid(gw_contract) THEN 
			RETURN
		End If
		lnv_dm_utils.of_download_multi_files( ll_doc_id_arr[], ldec_revision_arr[], ls_document_files[])
	Case 'DM_BROWSE'
		IF NOT IsValid(w_documents_browse) THEN 
			RETURN
		End If	
		lnv_dm_utils.of_download_multi_files( ll_doc_id_arr[], ldec_revision_arr[], ls_document_files[])
End Choose

//Need Merge data for multi files?		
If Upper(istr_add_doc[1].doc_from) <> 'CLAUSE' Then
	
End If

//Convert to PDF
ls_save_type = dw_1.GetItemString(1, "attach_type")

Long ll_pos,ll_pos1
ll_cnt = UpperBound(ls_document_files[])
For i = 1 To ll_cnt
	ll_pos = LastPos(ls_document_files[i],'.')
	ll_pos1 = LastPos(ls_document_files[i],'\')
	IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	If ll_pos <= 0 Then Continue
	If ll_pos1 <= 0 Then Continue
	ls_doc_ext = Lower(Mid(ls_document_files[i],ll_pos + 1, Len(ls_document_files[i])))
	ls_filename = Mid(ls_document_files[i],ll_pos1 + 1, ll_pos - ll_pos1 - 1 )
	If ls_save_type = 'P' Then //Convert to PDF
		If ls_doc_ext = 'doc' Then //doc to PDF

				//Check PDF Printer
				if f_PrinterSetup(2) >= 2 then Continue	
				ls_prntrs = PrintGetPrinters( )
				IF NOT Pos(lower(ls_prntrs),lower("IntelliSoft PDF Writer")) > 0 THEN
					If isvalid(lnv_clause) Then Destroy lnv_clause
					MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
					Return
				END IF
	
				
				SetPointer( HourGlass! )
				
				Openwithparm(w_appeon_gifofwait, "Saving as PDF for "+ ls_filename + "...")
				
				//---------Begin Modified by (Appeon)Harry 07.29.2013 for V141 ISG-CLX--------
				// Delete temp pdf file
				//ls_SourceFile = "C:\Program Files\PDFPrinter\temp\SampleOut.PDF"
				ls_SourceFile = gs_temp_pdf
				//---------End Modfiied ------------------------------------------------------

				IF FileExists(ls_SourceFile) THEN 
					//---------Begin Modified by (Appeon)Stephen 02.13.2014 for PDF Printer Issues--------
					/*
					IF Not FileDelete(ls_SourceFile) THEN 
						If isvalid(lnv_filesvr) Then Destroy lnv_filesvr
						If isvalid(lnv_clause) Then Destroy lnv_clause						
						MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")				
						Return	
					END IF
					*/
					ll_cpu = cpu()
					li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
					do while li_ret = 1
						li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
					loop
					if li_ret = -1 then 
						If isvalid(lnv_filesvr) Then Destroy lnv_filesvr
						If isvalid(lnv_clause) Then Destroy lnv_clause	
						IF Isvalid(w_appeon_gifofwait) THEN close(w_appeon_gifofwait)
						return
					end if
					//---------End Modfiied ------------------------------------------------------					
				END IF		

				gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06
		
				//Open Document with the OFFICE OCX
				ole_1.object.openlocalfile(ls_document_files[i], True)
				//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
				gnv_word_utility.of_modify_word_property( ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
				//---------End Added ------------------------------------------------------
				IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()			
					
				// Set PDF Printer and print to PDF format
				if f_PrinterSetup(2) >= 2 then 
					If isvalid(lnv_filesvr) Then Destroy lnv_filesvr
					If isvalid(lnv_clause) Then Destroy lnv_clause		
					IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
					Return
				End If
				ll_Len = 100
				ls_DefPrinter = SPACE(ll_Len)
				GetDefaultPrinter(ls_DefPrinter,ll_Len)	//Added by Scofield on 2008-07-30
				ole_1.object.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
				ole_1.object.ActiveDocument.Printout( 0 )
				ole_1.object.Close()			
				SetDefaultPrinter(ls_DefPrinter)				//Added by Scofield on 2008-07-30
				// Copy to pdf file
				If not isvalid(lnv_filesvr) Then lnv_filesvr = create n_cst_filesrvwin32
				//--------Begin Modified by Alfee 08.29.2007---------------				
				Do 
					Yield()
					Sleep(10) //Added By Ken.Guo 2009-12-31.
					If FileExists(ls_sourcefile) Then 
						li_file = FileOpen(ls_sourcefile, StreamMode!, Write!)
					Else
						li_file = -1
					End If
				Loop While li_file = -1
				FileClose(li_file)
				ls_newpathfilename = ls_path + ls_filename + '.pdf' 
				If FileExists(ls_newpathfilename) Then 
					If Not FileDelete(ls_newpathfilename) Then
						If isvalid(lnv_filesvr) Then Destroy lnv_filesvr
						If isvalid(lnv_clause) Then Destroy lnv_clause	
						IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
						MessageBox("Printer Error", "Please delete the file of '" + ls_newpathfilename + "' first! ")	
						Return
					End If
				End If
				Filecopy(ls_sourcefile, ls_newpathfilename ,true) //APB Blob Bug - jervis 03.23.2010
		ElseIf inv_image_cp.of_is_image2pdf( ls_doc_ext) Then //Image to PDf
			SetPointer( HourGlass! )
			If not isvalid(w_appeon_gifofwait) Then Openwithparm(w_appeon_gifofwait, "Saving as PDF for "+ ls_filename + "...")
			ls_newpathfilename =  ls_path + ls_filename + '.pdf' 
			IF inv_image_cp.of_convert2pdf(ls_document_files[i], ls_newpathfilename) = -1 THEN
				IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
				If isvalid(lnv_filesvr) Then Destroy lnv_filesvr
				If isvalid(lnv_clause) Then Destroy lnv_clause				
				MessageBox("Save As","Saving as a PDF format failed!")
				Return 
			END IF
			IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
		Else //Org copy
			ls_newpathfilename = ls_path + ls_filename + '.' + ls_doc_ext
			If FileExists(ls_newpathfilename) Then 
				If Not FileDelete(ls_newpathfilename) Then
					If isvalid(lnv_filesvr) Then Destroy lnv_filesvr
					If isvalid(lnv_clause) Then Destroy lnv_clause
					IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
					MessageBox("Printer Error", "Please delete the file of '" + ls_newpathfilename + "' first! ")	
					Return
				End If
			End If
			Filecopy(ls_document_files[i], ls_newpathfilename ,true) 
		End If
	Else //Org Copy
		ls_newpathfilename = ls_path + ls_filename + '.' + ls_doc_ext
		If FileExists(ls_newpathfilename) Then 
			If Not FileDelete(ls_newpathfilename) Then
				If isvalid(lnv_filesvr) Then Destroy lnv_filesvr
				If isvalid(lnv_clause) Then Destroy lnv_clause
				IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
				MessageBox("Printer Error", "Please delete the file of '" + ls_newpathfilename + "' first! ")	
				Return
			End If
		End If
		Filecopy(ls_document_files[i], ls_newpathfilename ,true) 	
	End If
Next

If isvalid(lnv_filesvr) Then Destroy lnv_filesvr
If isvalid(lnv_clause) Then Destroy lnv_clause
IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)

//Open folder and select target file.
Run('explorer.exe /select,' + ls_newpathfilename)

Post CloseWithReturn(This,1)
Return

/*
ls_merge_file = gs_dir_path + gs_DefDirName + "\Agreement\" +"_"+ string(istr_add_doc[1].doc_id) + "_out.doc"
ls_save_type = dw_1.GetItemString(1, "attach_type")
ls_path = dw_1.GetItemString(1, "directory")

IF NOT f_validstr ( ls_save_type ) THEN
	If isvalid(lnv_clause) Then Destroy lnv_clause
	MessageBox("Save As","Please choose a Save As Type for the document first.")
	Return
END IF

IF NOT f_validstr ( ls_path ) THEN
	If isvalid(lnv_clause) Then Destroy lnv_clause
	MessageBox("Save As", "Please choose a directory for the document first.")
	Return
END IF

IF Upper(istr_add_doc[1].doc_ext) = 'PDF' THEN ls_save_type = "O" //Alfee 03.14.2008
IF ls_save_type = 'P' THEN //Alfee 11.21.2008
	IF Lower(istr_add_doc[1].doc_ext) <> "doc" AND NOT inv_image_cp.of_is_image2pdf(istr_add_doc[1].doc_ext ) THEN
		If isvalid(lnv_clause) Then Destroy lnv_clause
		MessageBox("Save As", "This document is unsupported to be saved as a PDF format.")
		Return
	ELSEIF Lower(istr_add_doc[1].doc_ext) <> "doc" THEN
		ls_save_type = "I2P" //Image to PDF
	END IF
END IF

If istr_add_doc[1].doc_from <> 'Clause' Then //Added By Ken.Guo 2009-12-31.
	//Start code by jervis 02.25.2009
	gnv_appeondb.of_startqueue( )
	//Get export id
	Select ctx_acp_template.export_id Into :ll_export_id
	From ctx_am_document,ctx_acp_template
	Where ctx_am_document.doc_id = :istr_add_doc[1].doc_id
	And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;
	
	select create_by,create_date,doc_name
	into :lstr_docinfo.create_by,:lstr_docinfo.ver_date,:lstr_docinfo.doc_name
	from ctx_am_document
	where ctx_am_document.doc_id = :istr_add_doc[1].doc_id;
	gnv_appeondb.of_commitqueue( )
End If

lstr_docinfo.ver_num = istr_add_doc[1].revision
//End code by jervis 02.25.2009

Try
CHOOSE CASE ls_save_type
	CASE "O"		// Save to original format
		SetPointer( HourGlass! )
		Openwithparm(w_appeon_gifofwait, "Saving as document...")
		
		//Added By Ken.Guo 2009-12-31.
		If istr_add_doc[1].doc_from = 'Clause' Then 
			li_ret = lnv_clause.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision,ls_filename)
			If li_ret < 0 or Not fileexists(ls_filename) Then
				Messagebox('Save','Failed to download the clause file.')
				If isvalid(lnv_clause) Then Destroy lnv_clause
//				Return -1
			End If
		Else
			ls_filename = lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision)
		End If
		
		//-----------Begin Modified by Alfee 07.05.2007---------------------
		//lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision, ls_path)
		//ls_filename = lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision) //Commented By Ken.Guo 2009-12-31
		IF FileExists(ls_filename) THEN FileCopy(ls_filename, ls_path, TRUE) 
		//-----------End Modified ------------------------------------------
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
		
		//-------Added by alfee 04.28.2007----------
		IF not FileExists(ls_path) THEN 
			MessageBox("Alert Message","Saving as document failed!")
			IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)			
			Return
		END IF
		//------End Added----------------------------
		
		IF Upper(istr_add_doc[1].doc_ext) = "DOC" and isvalid(lnv_word) THEN //Alfee 03.14.2008
			
			//Get export id
			//commented by jervis 02.25.2009
			/*
			Select ctx_acp_template.export_id Into :ll_export_id
	   	  From ctx_am_document,ctx_acp_template
	 	 	 Where ctx_am_document.doc_id = :istr_add_doc[1].doc_id
			   And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;
			*/
			IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()		

			//Merge Data(Note: of_mergedata_auto fun doesn't include auto numbering now)
			IF ll_export_id > 0 THEN 				
				Filecopy(ls_path, ls_merge_file, true)	
				IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()				
				//lnv_word.of_mergedata_auto(ll_export_id, istr_add_doc[1].ctx_id, ls_merge_file, ls_path, true)		
				lnv_word.of_mergedata_auto(ll_export_id, istr_add_doc[1].ctx_id, ls_merge_file, ls_path, false,lstr_docinfo)	//modify by jervis 02.25.2009		
				IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()					
			END IF	
		
			//Auto numbering
			lnv_word.of_autonumbering(ls_path) //alfee 04.30.2007
	
		END IF		
	
	CASE "P"		// Save to PDF format
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// save the word as a Pdf file
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//---Appeon Begin by alfee 04.11.2007-------
		//Check PDF Printer
		if f_PrinterSetup(2) >= 2 then return	//Added by Scofield on 2007-11-09
		ls_prntrs = PrintGetPrinters( )
		IF NOT Pos(lower(ls_prntrs),lower("IntelliSoft PDF Writer")) > 0 THEN
			If isvalid(lnv_clause) Then Destroy lnv_clause
			MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
			RETURN
		END IF
		//---Appeon End ----------
	
		IF Lower(istr_add_doc[1].doc_ext) <> "doc" THEN
			MessageBox("Save As", "Only Word documents are supported.")
			Return
		END IF
		
		SetPointer( HourGlass! )
		Openwithparm(w_appeon_gifofwait, "Saving as PDF...")
		
		// Delete temp pdf file
		ls_SourceFile = gs_temp_pdf
		//ls_SourceFile = gs_dir_path + gs_DefDirName + "\PDFPrinter\temp\SampleOut.PDF" //Alfee 08.21.2007		
		//---------Begin Modified by Alfee 08.29.2007----------------------
		//FileDelete(ls_SourceFile)
		IF FileExists(ls_SourceFile) THEN 
			IF Not FileDelete(ls_SourceFile) THEN 
				If isvalid(lnv_clause) Then Destroy lnv_clause
				MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")				
//				RETURN -1
			END IF
		END IF		
		//---------End Modified -------------------------------------------

		// DownLoad source file
		If istr_add_doc[1].doc_from = 'Clause' Then 
			lnv_clause.of_download_file(istr_add_doc[1].doc_id, istr_add_doc[1].revision,ls_filename) //Added By Ken.Guo 2009-12-31.
		Else
			ls_filename = lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision)
		End If
		
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()

		//-------Added by alfee 04.28.2007----------
		IF not FileExists(ls_filename) THEN 
			MessageBox("Alert Message","Saving as PDF failed!")
			If isvalid(lnv_clause) Then Destroy lnv_clause
			IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)			
			Return
		END IF
		//------End Added----------------------------				
		
		//commented by jervis 02.25.2009
		/*
		//Get export id and merge data
		Select ctx_acp_template.export_id Into :ll_export_id
   	From ctx_am_document,ctx_acp_template
	 	Where ctx_am_document.doc_id = :istr_add_doc[1].doc_id
		And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;
		*/
		
		//Add IF statement by Alfee 04.28.2007. 
		//note: of_mergedata_auto fun doesn't include auto numbering now
		IF ll_export_id > 0 and isvalid(lnv_word) THEN
			Filecopy(ls_filename, ls_merge_file , true)
			IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()		
			//lnv_word.of_mergedata_auto(ll_export_id, istr_add_doc[1].ctx_id, ls_merge_file, ls_filename, true)
			lnv_word.of_mergedata_auto(ll_export_id, istr_add_doc[1].ctx_id, ls_merge_file, ls_filename, false,lstr_docinfo)	//modify by jervis 02.25.2009
			IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
		END IF
		
		gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06
		
		//Auto numbering
		If isvalid(lnv_word) Then lnv_word.of_autonumbering(ls_filename) //alfee 04.30.2007
		
		//Open Document with the OFFICE OCX
		ole_1.object.openlocalfile(ls_filename, True)
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()			
			
		// Set PDF Printer and print to PDF format
		if f_PrinterSetup(2) >= 2 then 
			If isvalid(lnv_clause) Then Destroy lnv_clause
			return	//Added by Scofield on 2007-11-09
		End If
		ll_Len = 100
		ls_DefPrinter = SPACE(ll_Len)
		GetDefaultPrinter(ls_DefPrinter,ll_Len)	//Added by Scofield on 2008-07-30
		ole_1.object.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
		ole_1.object.ActiveDocument.Printout( 0 )
		ole_1.object.Close()			
		SetDefaultPrinter(ls_DefPrinter)				//Added by Scofield on 2008-07-30
		// Copy to pdf file
		If not isvalid(lnv_filesvr) Then lnv_filesvr = create n_cst_filesrvwin32
		//--------Begin Modified by Alfee 08.29.2007---------------				
		Do 
			Yield()
			Sleep(10) //Added By Ken.Guo 2009-12-31.
			If FileExists(ls_sourcefile) Then 
				li_file = FileOpen(ls_sourcefile, StreamMode!, Write!)
			Else
				li_file = -1
			End If
		Loop While li_file = -1
		FileClose(li_file)
		//lnv_filesvr.of_filecopy(ls_sourcefile, ls_path )
		filecopy(ls_sourcefile, ls_path ,true) //APB Blob Bug - jervis 03.23.2010
		/*		
		Do While NOT lnv_filesvr.of_filecopy( ls_sourcefile, ls_path ) = 1
			Yield()
		Loop*/
		//--------End Modified ---------------------------------------
	CASE 'I2P' //Image to PDF format - alfee 11.21.2008
		SetPointer( HourGlass! )
		Openwithparm(w_appeon_gifofwait, "Saving as PDF...")
		// DownLoad source file
		ls_filename = lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision)
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
		//convert to PDF		
		IF inv_image_cp.of_convert2pdf(ls_filename, ls_path) = -1 THEN
			IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
			MessageBox("Save As","Saving as a PDF format failed!")
		END IF
		IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
END CHOOSE

Catch(Throwable th)
	If isvalid(lnv_clause) Then Destroy lnv_clause
	IF ole_1.object.doctype > 0 THEN ole_1.object.Close()	//alfee 04.30.2007
	IF Isvalid(lnv_filesvr) THEN Destroy lnv_filesvr
	IF FileExists( ls_merge_file ) THEN FileDelete(ls_merge_file)
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
End Try

//------Modified by alfee 04.28.2007----------
IF ole_1.object.doctype > 0 THEN ole_1.object.Close()	//alfee 04.30.2007
IF Isvalid(lnv_filesvr) THEN Destroy lnv_filesvr
If isvalid(lnv_clause) Then Destroy lnv_clause
IF FileExists( ls_merge_file ) THEN FileDelete(ls_merge_file)
IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
//Post CloseWithReturn(Parent, 1) //for image2pdf, Alfee 11.21.2008 
//CloseWithReturn(Parent, 1)
//------End Modified--------------------------
*/
//Return 
end subroutine

on w_dm_saveto_document.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.pb_1=create pb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.dw_1
end on

on w_dm_saveto_document.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.pb_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_1)
end on

event open;call super::open;PowerObject lpo_message
str_add_doc_multi lstr_add_doc_multi

inv_image_cp  = Create n_cst_image_functions_cp  //Alfee 11.21.2008

//Modified By Ken.Guo 2011-06-29. Support multi documents.
IF Isvalid(Message.Powerobjectparm) THEN
	lpo_message = Message.Powerobjectparm
	Choose Case lpo_message.classname()
		Case 'str_add_doc'
			istr_add_doc[1] = lpo_message
		Case 'str_add_doc_multi'
			lstr_add_doc_multi = lpo_message 
			istr_add_doc[] = lstr_add_doc_multi.astr_add_doc[]
	End Choose
END IF
If UpperBound(istr_add_doc[]) > 1 Then
	ib_multi = True
End If


this.of_setupdateable( FALSE )

end event

event close;call super::close;Destroy inv_image_cp //alfee 11.21.2008
end event

event activate;call super::activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_1 ) Then
	ole_1.object.activate(true)
End If
end event

type ole_1 from u_email_edit within w_dm_saveto_document
boolean visible = false
integer x = 41
integer y = 476
integer width = 773
integer height = 548
integer taborder = 60
string binarykey = "w_dm_saveto_document.win"
end type

type pb_1 from picturebutton within w_dm_saveto_document
integer x = 1330
integer y = 288
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean originalsize = true
string picturename = "Search!"
alignment htextalign = left!
string powertiptext = "Display Save File dialog box"
end type

event clicked;String ls_path,ls_dir
String ls_file
Integer li_result
String ls_save_type
integer li_pos

ls_save_type = dw_1.GetItemString(1, "attach_type")

If ib_multi Then
	
	//Select the DIR path to save the files.
	ls_dir =  f_browseforfolder('Please select a directory' ,handle(parent))
	if f_validstr(ls_dir)  then
		if Right(ls_dir,1) <> "\" then
			ls_dir += "\"
		end if	
		dw_1.SetItem(1, "directory", ls_dir)
		gf_save_dir_path(ls_dir)
	end if
Else

	gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2009-04-14 By: Ken.Guo
	//$<reason> Set default name
	ls_file = gf_merge_file_name(istr_add_doc[1].filename,istr_add_doc[1].doc_ext,istr_add_doc[1].doc_id,istr_add_doc[1].revision)
	ls_path = GetCurrentDirectory()	+ '\' + ls_file
	//---------------------------- APPEON END ----------------------------
	CHOOSE CASE ls_save_type
		CASE "O"		// Save to original format
			li_result = GetFileSaveName ( "Save Document", ls_path, ls_file, istr_add_doc[1].doc_ext, &
				istr_add_doc[1].doc_ext + " Files (*." + istr_add_doc[1].doc_ext + "),*." + istr_add_doc[1].doc_ext)
			//Added By Ken.Guo 2009-12-31. because if ls_path include '/', it will not show save dialog.	
			If li_result = 0 Then
				ls_path = ''
				li_result = GetFileSaveName ( "Save Document", ls_path, ls_file, istr_add_doc[1].doc_ext, &
				istr_add_doc[1].doc_ext + " Files (*." + istr_add_doc[1].doc_ext + "),*." + istr_add_doc[1].doc_ext)			
			End If
		CASE "P"		// Save to PDF format
			ls_path = Left(ls_path,LastPos(ls_path,'.') - 1) + '.pdf'
			li_result = GetFileSaveName ( "Save Document", ls_path, ls_file, istr_add_doc[1].doc_ext, &
				"PDF Files (*.pdf),*.pdf")
			//Added By Ken.Guo 2009-12-31. because if ls_path include '/', it will not show save dialog.	
			If li_result = 0 Then
				ls_path = ''
				li_result = GetFileSaveName ( "Save Document", ls_path, ls_file, istr_add_doc[1].doc_ext, &
					"PDF Files (*.pdf),*.pdf")		
			End If			
	END CHOOSE
	gf_save_dir_path(ls_path) //Added by Ken.Guo on 2009-03-10
	//ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
	
	IF li_result = 1 THEN
		dw_1.SetItem(1, "directory", ls_path)
	END IF

End If

end event

type cb_4 from commandbutton within w_dm_saveto_document
integer x = 1207
integer y = 504
integer width = 315
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;close(parent)

end event

type cb_3 from commandbutton within w_dm_saveto_document
integer x = 859
integer y = 504
integer width = 315
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Output document to file/PDF
**==================================================================================================================
**  Created By	: Davis 01.18.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
		Ken.Guo 2009-12-31: add NF, open from clause painter.
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
Integer li_file
String ls_save_type
String ls_path
String ls_filename
String ls_SourceFile
String ls_merge_file
String ls_prntrs,ls_DefPrinter
long	 ll_export_id,ll_Len
long   ll_cpu
boolean lb_msg = true

n_cst_ovole_utils lnv_word
n_cst_dm_utils lnv_dm_utils //auto instantiate
n_cst_filesrvwin32  lnv_filesvr

If ib_multi Then
	Parent.of_save_multi_files()
	Return
End If

str_doc_info	lstr_docinfo	//02.25.2009 by jervis

//Added By Ken.Guo 2009-12-31.
integer li_ret
n_cst_clause lnv_clause
lnv_clause = Create n_cst_clause


IF istr_add_doc[1].doc_id = 0 THEN 
	If isvalid(lnv_clause) Then Destroy lnv_clause
	RETURN
End If

Choose Case Upper(istr_add_doc[1].doc_from)
	Case 'CLAUSE'
		//
	Case 'DM'
		IF NOT IsValid(gw_contract) THEN 
			If isvalid(lnv_clause) Then Destroy lnv_clause
			RETURN
		End If		
		lnv_word = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_ole_utils_doc //Fix a issue, for performance tuning on exporting file of mergeing data
	Case 'DM_BROWSE'
		IF NOT IsValid(w_documents_browse) THEN 
			If isvalid(lnv_clause) Then Destroy lnv_clause
			RETURN
		End If		
		lnv_word = w_documents_browse.uo_1.inv_ole_utils_doc		
End Choose


//If not isvalid(lnv_word) then lnv_word = create n_cst_ovole_utils
//---Appeon End ---------------

ls_merge_file = gs_dir_path + gs_DefDirName + "\Agreement\" +"_"+ string(istr_add_doc[1].doc_id) + "_out.doc"
ls_save_type = dw_1.GetItemString(1, "attach_type")
ls_path = dw_1.GetItemString(1, "directory")

IF NOT f_validstr ( ls_save_type ) THEN
	If isvalid(lnv_clause) Then Destroy lnv_clause
	MessageBox("Save As","Please choose a Save As Type for the document first.")
	Return
END IF

IF NOT f_validstr ( ls_path ) THEN
	If isvalid(lnv_clause) Then Destroy lnv_clause
	MessageBox("Save As", "Please choose a directory for the document first.")
	Return
END IF

IF Upper(istr_add_doc[1].doc_ext) = 'PDF' THEN ls_save_type = "O" //Alfee 03.14.2008
IF ls_save_type = 'P' THEN //Alfee 11.21.2008
	IF Lower(istr_add_doc[1].doc_ext) <> "doc" AND NOT inv_image_cp.of_is_image2pdf(istr_add_doc[1].doc_ext ) THEN
		If isvalid(lnv_clause) Then Destroy lnv_clause
		MessageBox("Save As", "This document is unsupported to be saved as a PDF format.")
		Return
	ELSEIF Lower(istr_add_doc[1].doc_ext) <> "doc" THEN
		ls_save_type = "I2P" //Image to PDF
	END IF
END IF

If istr_add_doc[1].doc_from <> 'Clause' Then //Added By Ken.Guo 2009-12-31.
	//Start code by jervis 02.25.2009
	gnv_appeondb.of_startqueue( )
	//Get export id
	Select ctx_acp_template.export_id Into :ll_export_id
	From ctx_am_document,ctx_acp_template
	Where ctx_am_document.doc_id = :istr_add_doc[1].doc_id
	And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;
	
	select create_by,create_date,doc_name
	into :lstr_docinfo.create_by,:lstr_docinfo.ver_date,:lstr_docinfo.doc_name
	from ctx_am_document
	where ctx_am_document.doc_id = :istr_add_doc[1].doc_id;
	gnv_appeondb.of_commitqueue( )
End If

lstr_docinfo.ver_num = istr_add_doc[1].revision
//End code by jervis 02.25.2009

Try
	CHOOSE CASE ls_save_type
		CASE "O"		// Save to original format
			SetPointer( HourGlass! )
			Openwithparm(w_appeon_gifofwait, "Saving as document...")
			
			//Added By Ken.Guo 2009-12-31.
			If istr_add_doc[1].doc_from = 'Clause' Then 
				li_ret = lnv_clause.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision,ls_filename)
				If li_ret < 0 or Not fileexists(ls_filename) Then
					Messagebox('Save','Failed to download the clause file.')
					If isvalid(lnv_clause) Then Destroy lnv_clause
					Return -1
				End If
			Else
				ls_filename = lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision)
			End If
			
			//-----------Begin Modified by Alfee 07.05.2007---------------------
			//lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision, ls_path)
			//ls_filename = lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision) //Commented By Ken.Guo 2009-12-31
			IF FileExists(ls_filename) THEN FileCopy(ls_filename, ls_path, TRUE) 
			//-----------End Modified ------------------------------------------
			IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
			
			//-------Added by alfee 04.28.2007----------
			IF not FileExists(ls_path) THEN 
				MessageBox("Alert Message","Saving as document failed!")
				IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)			
				Return
			END IF
			//------End Added----------------------------
			
			IF Upper(istr_add_doc[1].doc_ext) = "DOC" and isvalid(lnv_word) THEN //Alfee 03.14.2008
				
				//Get export id
				//commented by jervis 02.25.2009
				/*
				Select ctx_acp_template.export_id Into :ll_export_id
				  From ctx_am_document,ctx_acp_template
				 Where ctx_am_document.doc_id = :istr_add_doc[1].doc_id
					And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;
				*/
				IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()		
	
				//Merge Data(Note: of_mergedata_auto fun doesn't include auto numbering now)
				IF ll_export_id > 0 THEN 				
					Filecopy(ls_path, ls_merge_file, true)	
					IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()				
					//lnv_word.of_mergedata_auto(ll_export_id, istr_add_doc[1].ctx_id, ls_merge_file, ls_path, true)		
					lnv_word.of_mergedata_auto(ll_export_id, istr_add_doc[1].ctx_id, ls_merge_file, ls_path, false,lstr_docinfo)	//modify by jervis 02.25.2009		
					IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()					
				END IF	
			
				//Auto numbering
				lnv_word.of_autonumbering(ls_path) //alfee 04.30.2007
		
			END IF		
		
		CASE "P"		// Save to PDF format
			/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// save the word as a Pdf file
			/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//---Appeon Begin by alfee 04.11.2007-------
			//Check PDF Printer
			if f_PrinterSetup(2) >= 2 then return	//Added by Scofield on 2007-11-09
			ls_prntrs = PrintGetPrinters( )
			IF NOT Pos(lower(ls_prntrs),lower("IntelliSoft PDF Writer")) > 0 THEN
				If isvalid(lnv_clause) Then Destroy lnv_clause
				MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
				RETURN
			END IF
			//---Appeon End ----------
		
			IF Lower(istr_add_doc[1].doc_ext) <> "doc" THEN
				MessageBox("Save As", "Only Word documents are supported.")
				Return
			END IF
			
			SetPointer( HourGlass! )
			Openwithparm(w_appeon_gifofwait, "Saving as PDF...")
			
			//---------Begin Modified by (Appeon)Harry 07.29.2013 for V141 ISG-CLX--------
			// Delete temp pdf file
			//ls_SourceFile = "C:\Program Files\PDFPrinter\temp\SampleOut.PDF"
			ls_SourceFile = gs_temp_pdf
			//ls_SourceFile = gs_dir_path + gs_DefDirName + "\PDFPrinter\temp\SampleOut.PDF" //Alfee 08.21.2007		
			//---------End Modfiied ------------------------------------------------------
			
			//---------Begin Modified by Alfee 08.29.2007----------------------
			//FileDelete(ls_SourceFile)
			IF FileExists(ls_SourceFile) THEN 
				//---------Begin Modified by (Appeon)Stephen 02.13.2014 for PDF Printer Issues--------
				/*
				IF Not FileDelete(ls_SourceFile) THEN 
					If isvalid(lnv_clause) Then Destroy lnv_clause
					MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")				
					RETURN -1
				END IF
				*/
				ll_cpu = cpu()
				li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
				do while li_ret = 1
					li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
				loop
				if li_ret = -1 then 
					If isvalid(lnv_clause) Then Destroy lnv_clause	
					IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
					return -1
				end if
				//---------End Modfiied ------------------------------------------------------				
			END IF		
			//---------End Modified -------------------------------------------
	
			// DownLoad source file
			If istr_add_doc[1].doc_from = 'Clause' Then 
				lnv_clause.of_download_file(istr_add_doc[1].doc_id, istr_add_doc[1].revision,ls_filename) //Added By Ken.Guo 2009-12-31.
			Else
				ls_filename = lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision)
			End If
			
			IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
	
			//-------Added by alfee 04.28.2007----------
			IF not FileExists(ls_filename) THEN 
				MessageBox("Alert Message","Saving as PDF failed!")
				If isvalid(lnv_clause) Then Destroy lnv_clause
				IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)			
				Return
			END IF
			//------End Added----------------------------				
			
			//commented by jervis 02.25.2009
			/*
			//Get export id and merge data
			Select ctx_acp_template.export_id Into :ll_export_id
			From ctx_am_document,ctx_acp_template
			Where ctx_am_document.doc_id = :istr_add_doc[1].doc_id
			And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;
			*/
			
			//Add IF statement by Alfee 04.28.2007. 
			//note: of_mergedata_auto fun doesn't include auto numbering now
			IF ll_export_id > 0 and isvalid(lnv_word) THEN
				Filecopy(ls_filename, ls_merge_file , true)
				IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()		
				//lnv_word.of_mergedata_auto(ll_export_id, istr_add_doc[1].ctx_id, ls_merge_file, ls_filename, true)
				lnv_word.of_mergedata_auto(ll_export_id, istr_add_doc[1].ctx_id, ls_merge_file, ls_filename, false,lstr_docinfo)	//modify by jervis 02.25.2009
				IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
			END IF
			
			gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06
			
			//Auto numbering
			If isvalid(lnv_word) Then lnv_word.of_autonumbering(ls_filename) //alfee 04.30.2007
			
			//Open Document with the OFFICE OCX
			ole_1.object.openlocalfile(ls_filename, True)
			//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
			gnv_word_utility.of_modify_word_property( ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
			//---------End Added ------------------------------------------------------
			IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()			
				
			// Set PDF Printer and print to PDF format
			if f_PrinterSetup(2) >= 2 then 
				If isvalid(lnv_clause) Then Destroy lnv_clause
				If isvalid(lnv_clause) Then Destroy lnv_clause				
				return	//Added by Scofield on 2007-11-09
			End If
			ll_Len = 100
			ls_DefPrinter = SPACE(ll_Len)
			GetDefaultPrinter(ls_DefPrinter,ll_Len)	//Added by Scofield on 2008-07-30
			ole_1.object.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
			ole_1.object.ActiveDocument.Printout( 0 )
			ole_1.object.Close()			
			SetDefaultPrinter(ls_DefPrinter)				//Added by Scofield on 2008-07-30
			// Copy to pdf file
			If not isvalid(lnv_filesvr) Then lnv_filesvr = create n_cst_filesrvwin32
			//--------Begin Modified by Alfee 08.29.2007---------------				
			Do 
				Yield()
				Sleep(10) //Added By Ken.Guo 2009-12-31.
				If FileExists(ls_sourcefile) Then 
					li_file = FileOpen(ls_sourcefile, StreamMode!, Write!)
				Else
					li_file = -1
				End If
			Loop While li_file = -1
			FileClose(li_file)
			//lnv_filesvr.of_filecopy(ls_sourcefile, ls_path )
			filecopy(ls_sourcefile, ls_path ,true) //APB Blob Bug - jervis 03.23.2010
			/*		
			Do While NOT lnv_filesvr.of_filecopy( ls_sourcefile, ls_path ) = 1
				Yield()
			Loop*/
			//--------End Modified ---------------------------------------
		CASE 'I2P' //Image to PDF format - alfee 11.21.2008
			SetPointer( HourGlass! )
			Openwithparm(w_appeon_gifofwait, "Saving as PDF...")
			// DownLoad source file
			ls_filename = lnv_dm_utils.of_download_file( istr_add_doc[1].doc_id, istr_add_doc[1].revision)
			IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
			//convert to PDF		
			IF inv_image_cp.of_convert2pdf(ls_filename, ls_path) = -1 THEN
				IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
				MessageBox("Save As","Saving as a PDF format failed!")
				IF Isvalid(lnv_filesvr) THEN Destroy lnv_filesvr
				If isvalid(lnv_clause) Then Destroy lnv_clause			
				Return -1
			END IF
			IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	END CHOOSE

	//Added By Ken.Guo 07/27/2012
	String ls_Null
	SetNull(ls_null)
	If FileExists(ls_path) Then
		If Messagebox('Save As','The document is saved successfully. Do you want to open it now?', Question!, YesNo!) = 1 Then//modified by gavins 20120803
			ShellExecuteA ( Handle( This ), ls_Null, ls_path , ls_Null, ls_Null, 4)
		End If		
	End If

Catch(Throwable th)
	If isvalid(lnv_clause) Then Destroy lnv_clause
	IF ole_1.object.doctype > 0 THEN ole_1.object.Close()	//alfee 04.30.2007
	IF Isvalid(lnv_filesvr) THEN Destroy lnv_filesvr
	IF FileExists( ls_merge_file ) THEN FileDelete(ls_merge_file)
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
End Try

//------Modified by alfee 04.28.2007----------
IF ole_1.object.doctype > 0 THEN ole_1.object.Close()	//alfee 04.30.2007
IF Isvalid(lnv_filesvr) THEN Destroy lnv_filesvr
If isvalid(lnv_clause) Then Destroy lnv_clause
IF FileExists( ls_merge_file ) THEN FileDelete(ls_merge_file)
IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
Post CloseWithReturn(Parent, 1) //for image2pdf, Alfee 11.21.2008 
//CloseWithReturn(Parent, 1)
//------End Modified--------------------------
end event

type dw_1 from u_dw within w_dm_saveto_document
integer width = 1595
integer height = 484
integer taborder = 10
string dataobject = "d_dm_saveto_settings"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;Long i
String ls_doc_ext
Boolean ib_exists_converted, ib_exists_not_converted

IF dwo.name = "attach_type" THEN
	If Not ib_multi Then
		THis.Setitem( row, "directory", "")
	Else
		//Check PDF format for all documents.
		If data = 'O' Then Return
		For i = 1 To UpperBound(istr_add_doc[])
			If istr_add_doc[i].doc_ext = 'doc' or istr_add_doc[i].doc_ext = 'docx'  or inv_image_cp.of_is_image2pdf( istr_add_doc[i].doc_ext )	Then
				ib_exists_converted = True
			Else
				ib_exists_not_converted = True
			End If
		Next
		
		If ib_exists_not_converted Then
			If ib_exists_converted Then
				Messagebox('Save As','Some of the documents you selected cannot be converted to PDF format. ~r~nOnly the Word and Image files can be converted to PDF format.')
			Else
				Messagebox('Save As','None of the documents you selected can be converted to PDF format. ~r~nOnly the Word and Image files can be converted to PDF format.')
				This.Post Setitem(1,'attach_type','O')
			End If
		End If
	
	End If
End If
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Dw_dm_saveto_document.bin 
2B00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000002a715f9001d131c000000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000002a715f9001d131c02a715f9001d131c00000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd0000117700000e2900dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd0000117700000e2900dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Dw_dm_saveto_document.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
