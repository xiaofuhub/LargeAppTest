$PBExportHeader$w_doc_saveto_document.srw
forward
global type w_doc_saveto_document from w_response
end type
type ole_1 from u_email_edit within w_doc_saveto_document
end type
type pb_1 from picturebutton within w_doc_saveto_document
end type
type cb_4 from commandbutton within w_doc_saveto_document
end type
type cb_3 from commandbutton within w_doc_saveto_document
end type
type dw_1 from u_dw within w_doc_saveto_document
end type
end forward

global type w_doc_saveto_document from w_response
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
global w_doc_saveto_document w_doc_saveto_document

type variables
Long il_doc_id
String is_doc_ext

str_add_doc lstr_add_doc 
n_cst_image_functions_cp inv_image_cp //Alfee 11.21.2008

n_cst_clause inv_clause
end variables

forward prototypes
public function string of_downloadfile (long al_doc_id)
end prototypes

public function string of_downloadfile (long al_doc_id);Return inv_clause.of_download_document(al_doc_id)

//Blob  lb_image_data
//
//Integer li_counter, li_loops, li_MaxPosition, li_Position
//Integer li_SetStep, li_NewStep, li_loopsR, li_rtn
//Long ll_start, ll_data_length
//String ls_title
//Boolean lb_needrestore = FALSE
//Blob lb_data, lb_all_data
//String ls_filename_temp
//
//// Get file data from database
//IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
//		
//		SetPointer(HourGlass!) 
//		
//		// Get file data from database
//		SELECT Datalength(image_file)
//		INTO :ll_data_length
//		FROM ctx_acp_document
//		WHERE ctx_acp_document_id = :al_doc_id;
//		
//		IF SQLCA.SQLCODE = -1 THEN RETURN '' 
//		
//		IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
//			RETURN ''
//		END IF
//		
//		//Get length of the blob
//		IF ll_data_length > 8000 THEN 
//			 IF Mod(ll_data_length,8000) = 0 THEN 
//				  li_loops = ll_data_length/8000 
//			 ELSE 
//				  li_loops = (ll_data_length/8000) + 1 
//			 END IF 
//		ELSE 
//			 li_loops = 1 
//		END IF 
//		
//		//--------Begin Modified by Alfee 09.17.2007--------------------------------
//		//<$Reason>Display progress bar for the large blob
//		li_NewStep = 20
//		IF li_loops > li_NewStep THEN
//			IF IsValid(w_appeon_gifofwait) THEN 
//				//Keep the original progress bar
//				lb_needrestore = TRUE
//				ls_title = w_appeon_gifofwait.st_1.Text
//				li_MaxPosition = w_appeon_gifofwait.hpb_1.MaxPosition
//				li_Position = w_appeon_gifofwait.hpb_1.Position
//				li_SetStep = w_appeon_gifofwait.hpb_1.SetStep
//			ELSE
//				OpenwithParm(w_appeon_gifofwait,"Getting the data...")
//			END IF
//			//Set the new progress bar
//			li_loopsR = li_loops / li_NewStep
//			IF Mod(li_loops, li_NewStep) <> 0 THEN li_loopsR ++
//			w_appeon_gifofwait.st_1.Text = "Getting the data..."
//			w_appeon_gifofwait.hpb_1.MaxPosition = li_loopsR * li_NewStep
//			w_appeon_gifofwait.hpb_1.Position = 0
//			w_appeon_gifofwait.hpb_1.SetStep = li_loopsR		
//		END IF
//		
//		//Get and store the blob
//		li_rtn = 1
//		FOR li_counter = 1 to li_loops
//			ll_start = (li_counter - 1) * 8000 + 1
//			SELECTBLOB substring(image_file,:ll_start,8000)
//					INTO :lb_data
//					FROM ctx_acp_document
//					WHERE ctx_acp_document_id = :al_doc_id;
//			IF SQLCA.SQLCODE = -1 THEN 
//				li_rtn = -1
//				EXIT
//			END IF
//			
//			lb_all_data += lb_data
//			
//			//Change the progress bar
//			IF IsValid(w_appeon_gifofwait) AND li_loops > li_NewStep THEN
//				IF Mod(li_counter, li_loopsR) = 1 THEN w_appeon_gifofwait.hpb_1.StepIt() 
//			ELSE
//				IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
//			END IF
//			
//		NEXT 
//		
//		//Restore Progress Bar
//		IF IsValid(w_appeon_gifofwait) and li_loops > li_NewStep THEN 
//			IF lb_needrestore THEN
//				w_appeon_gifofwait.st_1.Text = ls_title
//				w_appeon_gifofwait.hpb_1.MaxPosition = li_MaxPosition
//				w_appeon_gifofwait.hpb_1.Position = li_Position
//				w_appeon_gifofwait.hpb_1.SetStep = li_SetStep
//			ELSE
//				Close(w_appeon_gifofwait)
//			END IF
//		END IF
//		
//		//Store the blob
//		lb_image_data = lb_all_data
//		
//		If li_rtn < 0 Then
//			MessageBox( "DownLoad File", "Download file failed!" )		
//			RETURN ''			
//		End If
//ELSE
//	SELECTBLOB image_file
//	INTO :lb_image_data
//	FROM ctx_acp_document
//	WHERE ctx_acp_document_id = :al_doc_id;
//	
//	//-------------Begin Added by Alfee 09.07.2007-------------------
//	IF SQLCA.SQLCODE = -1 THEN 
//		MessageBox( "DownLoad File", "Download file failed! ~r~n" + SQLCA.SQLERRTEXT )
//		Return ''
//	END IF
//	//-------------End Added ----------------------------------------
//END IF
//
//// Save blob value to a local file.
////Return of_saveblob(as_filename, lb_image_data)
//Long ll_writelength, ll_readlength
//string ls_save_path
//
//ls_filename_temp = gs_dir_path + gs_DefDirName + "\Agreement\Manager\doc_library_" + string(lstr_add_doc.doc_id ) + "." + lstr_add_doc.doc_ext
//
//if fileexists(ls_filename_temp) then 
//	if not filedelete(ls_filename_temp) then
//		return ''
//	end if
//end if
//
//SetPointer(HourGlass!) 
//
//
//ls_save_path = mid(ls_filename_temp,1,lastpos(ls_filename_temp,'\'))
//gnv_appeondll.of_parsepath(ls_save_path)
//
//ll_readlength = Len(lb_image_data)
//
//
//ll_writelength = AppeonWriteFile(ls_filename_temp, lb_image_data, ll_readlength)
//if ll_writelength < 0 then return ''
//
//SetPointer(Arrow!)
//
//
//Return ls_filename_temp
//
end function

on w_doc_saveto_document.create
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

on w_doc_saveto_document.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.pb_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_1)
end on

event open;call super::open;inv_image_cp  = Create n_cst_image_functions_cp  //Alfee 11.21.2008

IF Isvalid(Message.Powerobjectparm) THEN
	lstr_add_doc = Message.Powerobjectparm

	il_doc_id = lstr_add_doc.doc_id
	is_doc_ext = lstr_add_doc.doc_ext
	
END IF

this.of_setupdateable( FALSE )

inv_clause = Create n_cst_clause 
end event

event close;call super::close;Destroy inv_image_cp //alfee 11.21.2008

If isvalid(inv_clause) Then Destroy inv_clause
end event

event activate;call super::activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_1 ) Then
	ole_1.object.activate(true)
End If
end event

type ole_1 from u_email_edit within w_doc_saveto_document
boolean visible = false
integer x = 41
integer y = 476
integer width = 773
integer height = 548
integer taborder = 60
string binarykey = "w_doc_saveto_document.win"
end type

type pb_1 from picturebutton within w_doc_saveto_document
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

event clicked;String ls_path
String ls_file
Integer li_result
String ls_save_type
integer li_pos

ls_save_type = dw_1.GetItemString(1, "attach_type")
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2009-04-14 By: Ken.Guo
//$<reason> Set default name
//ls_file = gf_merge_file_name(lstr_add_doc.filename,lstr_add_doc.doc_ext,lstr_add_doc.doc_id,lstr_add_doc.revision)
ls_path = GetCurrentDirectory()	+ '\' + lstr_add_doc.filename + '.' + lstr_add_doc.doc_ext
//---------------------------- APPEON END ----------------------------
CHOOSE CASE ls_save_type
	CASE "O"		// Save to original format
		li_result = GetFileSaveName ( "Save Document", ls_path, ls_file, is_doc_ext, &
			is_doc_ext + " Files (*." + is_doc_ext + "),*." + is_doc_ext)
	CASE "P"		// Save to PDF format
		ls_path = Left(ls_path,LastPos(ls_path,'.') - 1) + '.pdf'
		li_result = GetFileSaveName ( "Save Document", ls_path, ls_file, is_doc_ext, &
			"PDF Files (*.pdf),*.pdf")
END CHOOSE
gf_save_dir_path(ls_path) //Added by Ken.Guo on 2009-03-10
//ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF li_result = 1 THEN
	dw_1.SetItem(1, "directory", ls_path)
END IF

end event

type cb_4 from commandbutton within w_doc_saveto_document
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

type cb_3 from commandbutton within w_doc_saveto_document
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
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
Integer li_file
integer li_ret
String ls_save_type
String ls_path
String ls_filename
String ls_SourceFile
String ls_merge_file
String ls_prntrs,ls_DefPrinter
long	 ll_export_id,ll_Len
long   ll_cpu
boolean lb_msg = true

n_cst_filesrvwin32  lnv_filesvr

str_doc_info	lstr_docinfo	//02.25.2009 by jervis

IF il_doc_id = 0 THEN RETURN

IF NOT IsValid(w_sheet_ctx_doc_painter) THEN RETURN


//ls_merge_file = gs_dir_path + gs_DefDirName + "\Agreement\" +"_"+ string(il_doc_id) + "_out.doc"
ls_save_type = dw_1.GetItemString(1, "attach_type")
ls_path = dw_1.GetItemString(1, "directory")

IF NOT f_validstr ( ls_save_type ) THEN
	MessageBox("Save As","Please choose a Save As Type for the document first.")
	Return
END IF

IF NOT f_validstr ( ls_path ) THEN
	MessageBox("Save As", "Please choose a directory for the document first.")
	Return
END IF

IF Upper(is_doc_ext) = 'PDF' THEN ls_save_type = "O" //Alfee 03.14.2008
IF ls_save_type = 'P' THEN //Alfee 11.21.2008
	IF Lower(is_doc_ext) <> "doc" AND NOT inv_image_cp.of_is_image2pdf(is_doc_ext ) THEN
		MessageBox("Save As", "This document is unsupported to be saved as a PDF format.")
		Return
	ELSEIF Lower(is_doc_ext) <> "doc" THEN
		ls_save_type = "I2P" //Image to PDF
	END IF
END IF

Try
CHOOSE CASE ls_save_type
	CASE "O"		// Save to original format
		SetPointer( HourGlass! )
		Openwithparm(w_appeon_gifofwait, "Saving as document...")
		//-----------Begin Modified by Alfee 07.05.2007---------------------
		ls_filename = Parent.of_downloadfile(lstr_add_doc.doc_id )
		IF FileExists(ls_filename) THEN FileCopy(ls_filename, ls_path, TRUE)
		//-----------End Modified ------------------------------------------
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
		
		//-------Added by alfee 04.28.2007----------
		IF not FileExists(ls_path) THEN 
			MessageBox("Alert Message","Saving as document failed!")
			IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)			
			Return
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
			MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
			RETURN
		END IF
		//---Appeon End ----------
	
		IF Lower(is_doc_ext) <> "doc" THEN
			MessageBox("Save As", "Only Word documents are supported.")
			Return
		END IF
		
		SetPointer( HourGlass! )
		Openwithparm(w_appeon_gifofwait, "Saving as PDF...")
		
		// Delete temp pdf file
		//---------Begin Modified by (Appeon)Toney 07.29.2013 for V141 ISG-CLX--------
		//$Reason:Unit Test
		  /*
			ls_SourceFile = "C:\Program Files\PDFPrinter\temp\SampleOut.PDF"
			//ls_SourceFile = gs_dir_path + gs_DefDirName + "\PDFPrinter\temp\SampleOut.PDF" //Alfee 08.21.2007					
		  */
		 ls_SourceFile = gs_temp_pdf
		//---------End Modfiied ------------------------------------------------------------------
	
		//---------Begin Modified by Alfee 08.29.2007----------------------
		//FileDelete(ls_SourceFile)
		IF FileExists(ls_SourceFile) THEN 
			//---------Begin Modified by (Appeon)Stephen 02.13.2014 for PDF Printer Issues--------
			/*
			IF Not FileDelete(ls_SourceFile) THEN 
				MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")				
				RETURN -1
			END IF
			*/
			ll_cpu = cpu()
			li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
			do while li_ret = 1
				li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
				IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
			loop
			if li_ret = -1 then 	
				IF Isvalid(w_appeon_gifofwait) THEN close(w_appeon_gifofwait)
				return -1
			end if
			//---------End Modfiied ------------------------------------------------------			
		END IF		
		//---------End Modified -------------------------------------------

		// DownLoad source file
		ls_filename = Parent.of_downloadfile(lstr_add_doc.doc_id )
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()

		//-------Added by alfee 04.28.2007----------
		IF not FileExists(ls_filename) THEN 
			MessageBox("Alert Message","Saving as PDF failed!")
			IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)			
			Return
		END IF
		//------End Added----------------------------				
		
		gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06
		
		
		//Open Document with the OFFICE OCX
		ole_1.object.openlocalfile(ls_filename, True)
		//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
		gnv_word_utility.of_modify_word_property( ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		//---------End Added ------------------------------------------------------
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()			

		// Set PDF Printer and print to PDF format
		if f_PrinterSetup(2) >= 2 then return	//Added by Scofield on 2007-11-09
		ll_Len = 100
		ls_DefPrinter = SPACE(ll_Len)
		GetDefaultPrinter(ls_DefPrinter,ll_Len)	//Added by Scofield on 2008-07-30
		ole_1.object.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
		ole_1.object.ActiveDocument.Printout( 0 )
		ole_1.object.Close()			
		SetDefaultPrinter(ls_DefPrinter)				//Added by Scofield on 2008-07-30
		// Copy to pdf file
		If not isvalid(lnv_filesvr) Then lnv_filesvr = create n_cst_filesrvwin32
		Do 
			Yield()
			If FileExists(ls_sourcefile) Then 
				li_file = FileOpen(ls_sourcefile, StreamMode!, Write!)
			Else
				li_file = -1
			End If
		Loop While li_file = -1
		FileClose(li_file)
		//lnv_filesvr.of_filecopy(ls_sourcefile, ls_path )
		filecopy(ls_sourcefile, ls_path ,true) //APB Blob Bug - jervis 03.23.2010

	CASE 'I2P' //Image to PDF format - alfee 11.21.2008
		SetPointer( HourGlass! )
		Openwithparm(w_appeon_gifofwait, "Saving as PDF...")
		// DownLoad source file
		ls_filename = Parent.of_downloadfile(lstr_add_doc.doc_id )
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
		//convert to PDF		
		IF inv_image_cp.of_convert2pdf(ls_filename, ls_path) = -1 THEN
			IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
			MessageBox("Save As","Saving as a PDF format failed!")
		END IF
		IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
END CHOOSE

Catch(Throwable th)
	IF ole_1.object.doctype > 0 THEN ole_1.object.Close()	//alfee 04.30.2007
	IF Isvalid(lnv_filesvr) THEN Destroy lnv_filesvr
	IF FileExists( ls_merge_file ) THEN FileDelete(ls_merge_file)
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
End Try

//------Modified by alfee 04.28.2007----------
IF ole_1.object.doctype > 0 THEN ole_1.object.Close()	//alfee 04.30.2007
IF Isvalid(lnv_filesvr) THEN Destroy lnv_filesvr
IF FileExists( ls_merge_file ) THEN FileDelete(ls_merge_file)
IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
Post CloseWithReturn(Parent, 1) //for image2pdf, Alfee 11.21.2008 
//CloseWithReturn(Parent, 1)
//------End Modified--------------------------
end event

type dw_1 from u_dw within w_doc_saveto_document
integer width = 1595
integer height = 484
integer taborder = 10
string dataobject = "d_dm_saveto_settings"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;IF dwo.name = "attach_type" THEN
	THis.Setitem( row, "directory", "")
END IF
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
02w_doc_saveto_document.bin 
2C00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000006f8b8001d1312b00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000006f8b8001d1312b006f8b8001d1312b0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd0000117700000e2900dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd0000117700000e2900dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
12w_doc_saveto_document.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
