$PBExportHeader$w_letter_combine.srw
forward
global type w_letter_combine from window
end type
type ole_edit from olecustomcontrol within w_letter_combine
end type
type ole_word from olecustomcontrol within w_letter_combine
end type
type ole_page from olecustomcontrol within w_letter_combine
end type
type ole_admin from olecustomcontrol within w_letter_combine
end type
type st_1 from statictext within w_letter_combine
end type
type p_1 from picture within w_letter_combine
end type
end forward

global type w_letter_combine from window
integer width = 1458
integer height = 824
boolean titlebar = true
string title = "Combine file"
boolean controlmenu = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ole_edit ole_edit
ole_word ole_word
ole_page ole_page
ole_admin ole_admin
st_1 st_1
p_1 p_1
end type
global w_letter_combine w_letter_combine

type variables
string is_type
boolean ib_wordbuild
end variables

forward prototypes
public function integer of_combine_word (string as_word[], ref string as_out)
public function integer of_combine_file (string as_infile[], ref string as_outfile)
public function integer of_combine_tif (string as_tif_name[], ref string as_out_file)
public function integer of_convert_tif (string as_doc_name[], ref string as_tif_name[])
public function integer of_get_wordbuild ()
public function string of_modify_path (string as_file_path, string as_file_type, integer ai_att)
public function integer of_combine_new (string as_infile[], ref string as_outfile)
end prototypes

public function integer of_combine_word (string as_word[], ref string as_out);//////////////////////////////////////////////////////////////////////
// $<function> of_combine_word
// $<arguments>
// $<returns> integer
// $<description>combine word files into a single PDF file (V12.1 Fax modification)
//////////////////////////////////////////////////////////////////////
// $<add> 11.24.2011 by Stephen
//////////////////////////////////////////////////////////////////////

Oleobject lole_word, lole_new
integer li_cnt, li_return
integer li_ret
long  ll_len, ll_cpu
string  ls_DefPrinter
n_cst_filesrvwin32 lnv_filesvr
integer li_pos, li_file
string ls_sourcefile, ls_tif
boolean lb_catch = false
boolean lb_msg = true
OLEObject lole_Selection

// Open file first
//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 11.30.2012
//$<reason> The order of the combined attachments
/*
ole_word.object.openlocalfile(as_word[1], true)
*/
li_cnt = upperbound(as_word)
ole_word.object.openlocalfile(as_word[li_cnt], true)
//------------------- APPEON END -------------------

ole_word.Object.ActiveDocument.Content.Select()

lole_Selection = ole_word.object.ActiveDocument.ActiveWindow.Selection
lole_Selection.GoTo(1, 1)
	
//for li_cnt = 2 to upperbound(as_word)-- delete by stephen 11.30.2012  The order of the combined attachments
for li_cnt = upperbound(as_word) - 1 to 1 step -1 	//add by stephen 11.30.2012  The order of the combined attachments
	lole_Selection.InsertFile(as_word[li_cnt])
	lole_Selection.InsertParagraphBefore()
next

if is_type <> 'email' then
	as_out = of_modify_path(as_word[1], 'attachment.doc', 1)
	ole_word.object.ActiveDocument.SaveAs(as_out,0) //Word 2003 format

else
	IF ib_wordbuild = true THEN  //Word 2007 SP2
		try
			as_out = of_modify_path(as_word[1], 'attachment.pdf', 1)
			ole_word.object.ActiveDocument.SaveAs(as_out,17) //PDF format
		Catch(Throwable th2) 
				lb_catch = true
		end try
	end if
	
	if ib_wordbuild = false or lb_catch then
		//---------Begin Added by (Appeon)Stephen 02.17.2014 for citrix user pdf print--------
		if gi_citrix = 1 then
			if isvalid(lole_Selection) then destroy lole_Selection
			ole_word.object.FileClose(true)  
			ole_word.object.Close()	
			return -1
		end if
		//---------End Added ------------------------------------------------------	
		
		ls_SourceFile = gs_temp_pdf
		//---------Begin Modified by (Appeon)Stephen 02.13.2014 for PDF Printer Issues--------
		//IF FileExists(ls_SourceFile) THEN FileDelete(ls_SourceFile)
		ll_cpu = cpu()
		li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
		do while li_ret = 1
			li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
		loop
		if li_ret = -1 then 
			if isvalid(lole_Selection) then destroy lole_Selection
			ole_word.object.FileClose(true)  
			ole_word.object.Close()		
			return -1
		end if
		//---------End Modfiied ------------------------------------------------------	
		
		Try
			if f_PrinterSetup(2) >= 2 then 
				if isvalid(lole_Selection) then destroy lole_Selection
				ole_word.object.FileClose(true)  //add by stephen 11.20.2012 
				ole_word.object.Close()		
				return	 -1	
			end if
			
			ll_Len = 100
			ls_DefPrinter = SPACE(ll_Len)
			GetDefaultPrinter(ls_DefPrinter,ll_Len)	
		
			ole_word.object.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
			ole_word.object.ActiveDocument.Printout( 0 )
			
			SetDefaultPrinter(ls_DefPrinter)			
		Catch(Throwable th1) 
			if isvalid(lole_Selection) then destroy lole_Selection
			ole_word.object.FileClose(true)
			ole_word.object.Close()	
			RETURN -1
		End Try
		
		as_out = of_modify_path(as_word[1], 'attachment.pdf', 1)
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
		lnv_filesvr.of_filecopy(ls_sourcefile, as_out )
		
		if isvalid(lnv_filesvr) then destroy lnv_filesvr
	end if

end if
	
if isvalid(lole_Selection) then destroy lole_Selection
ole_word.object.FileClose(true)
ole_word.object.Close()			

for li_cnt = 1 to upperbound(as_word)
	FileDelete(as_word[li_cnt])
next
return 1
end function

public function integer of_combine_file (string as_infile[], ref string as_outfile);//////////////////////////////////////////////////////////////////////
// $<function> of_combine_file
// $<arguments>
// $<returns> integer
// $<description>combine the files into a single PDF file (V12.1 Fax modification)
//////////////////////////////////////////////////////////////////////
// $<add> 11.24.2011 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_cnt
string ls_ext, ls_out
string ls_tif[]
boolean lb_word , lb_combine

lb_word = true
lb_combine = true

if upperbound(as_infile) < 1 then return -1
for li_cnt = 1 to upperbound(as_infile)
	ls_ext = MidA(as_infile[li_cnt], LastPos(as_infile[li_cnt], ".") + 1)
	if (upper(ls_ext) <> 'DOC' and upper(ls_ext) <> 'DOCX') then
		lb_word = false
	end if
	
	//if pos(',DOC,JPG,BMP,TIF,DOCX', ","+upper(ls_ext)) < 1 or upper(ls_ext) = 'PDF'  then
	if pos(',DOC,JPG,BMP,TIF,DOCX,PDF', ","+upper(ls_ext)) < 1  then  //Modified by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
		lb_combine = false
		exit
	end if
next

if lb_combine = false then return -1

of_get_wordbuild()  //get word version and build

if lb_word then
	if of_combine_word(as_infile, as_outfile) < 1 then return -1
else
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 04.26.2013
	//$<reason> the fax is very poor -Bug 3472
    /*
	if of_convert_tif(as_infile, ls_tif) < 1 then return -1
	if of_combine_tif(ls_tif, ls_out) < 1 then return -1
	as_outfile = ls_out
	*/
	if of_combine_new(as_infile, as_outfile) < 1 then return -1	
	//------------------- APPEON END -------------------
end if

return 1
end function

public function integer of_combine_tif (string as_tif_name[], ref string as_out_file);//////////////////////////////////////////////////////////////////////
// $<function> of_combine_tif
// $<arguments>
// $<returns> integer
// $<description>combine the files into a single PDF file (V12.1 Fax modification)
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2011 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_cnt,  li_return
string   ls_pdf, ls_outfile2
n_cst_image_functions_cp  lnv_image_func

as_out_file = of_modify_path(as_tif_name[1], 'attachments(2).tif', 1)

lnv_image_func = create n_cst_image_functions_cp

li_return = lnv_image_func.of_tifmerge(as_tif_name[1],as_tif_name[2], as_out_file)

if li_return < 1 then 
	destroy lnv_image_func
	return -1
end if

for li_cnt = 3 to upperbound(as_tif_name)
	ls_outfile2 = of_modify_path(as_tif_name[1], 'attachments('+ string(li_cnt) +').tif', 1)
	li_return = lnv_image_func.of_tifmerge(as_out_file,as_tif_name[li_cnt], ls_outfile2)
	FileDelete(as_out_file)
	if li_return < 1 then 
		destroy lnv_image_func
		return -1
	end if
	as_out_file = ls_outfile2

next

if is_type = 'email' then
	ls_pdf = LeftA(as_out_file, LastPos(as_out_file,".") - 1) + '.pdf'
	li_return = lnv_image_func.of_convert2pdf( as_out_file, ls_pdf)
	FileDelete(as_out_file)
	if li_return < 1 then
		destroy lnv_image_func
		return -1		
	end if
	as_out_file = ls_pdf
end if

if isvalid(lnv_image_func) then destroy lnv_image_func
for li_cnt = 1 to upperbound(as_tif_name)
	FileDelete(as_tif_name[li_cnt])
next

return 1
end function

public function integer of_convert_tif (string as_doc_name[], ref string as_tif_name[]);//////////////////////////////////////////////////////////////////////
// $<function> of_convert_tif
// $<arguments>
// $<returns> integer
// $<description>Convert image or Word Document to TIF file (V12.1 Fax modification)
//////////////////////////////////////////////////////////////////////
// $<add> 11.08.2011 by Stephen
//$<modify> //(Appeon)Stephen 02.13.2017 - use lole_word replace ole_word
//////////////////////////////////////////////////////////////////////

string ls_ext, ls_SourceFile
long ll_Len
string  ls_DefPrinter
string  ls_outfile
n_cst_filesrvwin32 lnv_filesvr
n_cst_image_functions_cp  lnv_image_func
integer li_file, li_return, li_cnt, li_pos
integer li_ret
string  ls_pdf_name[]
oleobject lole_word

IF gnv_reg_ocx.of_check_ocx(4,'',False) <> '' THEN return -1
lnv_image_func = Create n_cst_image_functions_cp 
for li_cnt = 1 to upperbound(as_doc_name)
	IF LenA(trim(as_doc_name[li_cnt])) < 1 THEN 
		Destroy lnv_image_func
		If isvalid(lnv_filesvr) Then Destroy lnv_filesvr
		return -1
	end if
	ls_ext = MidA(as_doc_name[li_cnt], LastPos(as_doc_name[li_cnt], ".") + 1)
	
	if (ls_ext <>'tif') and (ls_ext<>'pdf') then
		IF lower(ls_ext) = 'doc' or lower(ls_ext) = 'docx' THEN			
			
			IF ib_wordbuild THEN //Word 2007 SP2
			
				ls_pdf_name[li_cnt] = of_modify_path(as_doc_name[li_cnt], "pdf", 0)				
				lole_word = create oleobject
				li_ret = lole_word.connecttonewobject("Word.Application")
				lole_word.documents.open(as_doc_name[li_cnt])
				lole_word.ActiveDocument.SaveAs(ls_pdf_name[li_cnt],17) //PDF format
				lole_word.quit(0)
				lole_word.disconnectobject()
				destroy lole_word
			else
	
				//Delete temporary pdf file  
				ls_SourceFile = gs_temp_pdf
				IF FileExists(ls_SourceFile) THEN FileDelete(ls_SourceFile)
				
				//Set pdf Printer and print to PDF format
				Try
					if f_PrinterSetup(2) >= 2 then 
						Destroy lnv_image_func
						If isvalid(lnv_filesvr) Then Destroy lnv_filesvr							
						return	 -1	
					end if
					
					ll_Len = 100
					ls_DefPrinter = SPACE(ll_Len)
					GetDefaultPrinter(ls_DefPrinter,ll_Len)	
					lole_word = create oleobject
					li_ret = lole_word.connecttonewobject("Word.Application")
					lole_word.documents.open(as_doc_name[li_cnt])
					lole_word.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
					lole_word.ActiveDocument.Printout( 0 )
					
					SetDefaultPrinter(ls_DefPrinter)			
				Catch(Throwable th1) 				   		
					Destroy lnv_image_func
					If isvalid(lnv_filesvr) Then Destroy lnv_filesvr	
					lole_word.quit(0)
					lole_word.disconnectobject()
					destroy lole_word		
					RETURN -1
				End Try	
				
				lole_word.quit(0)
				lole_word.disconnectobject()
				destroy lole_word							
				ls_pdf_name[li_cnt] = of_modify_path(as_doc_name[li_cnt], "pdf", 0)
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
				lnv_filesvr.of_filecopy(ls_sourcefile, ls_pdf_name[li_cnt] )
			end if
		else	
			ls_pdf_name[li_cnt] = of_modify_path(as_doc_name[li_cnt], "pdf", 0)
			li_return = lnv_image_func.of_convert2pdf( as_doc_name[li_cnt], ls_pdf_name[li_cnt])
			
			IF li_return < 1 THEN
				Destroy lnv_image_func
				If isvalid(lnv_filesvr) Then Destroy lnv_filesvr				
				RETURN -1
			END IF
			
		end if
	else
		ls_pdf_name[li_cnt] = as_doc_name[li_cnt]
	end if
	
	if ls_ext <>'tif' then
		as_tif_name[li_cnt] = of_modify_path(ls_pdf_name[li_cnt], "tif", 0) 
		li_return = lnv_image_func.of_pdf2tif( ls_pdf_name[li_cnt], as_tif_name[li_cnt])
		FileDelete(ls_pdf_name[li_cnt])
		
		IF li_return < 1 THEN
			Destroy lnv_image_func			
			If isvalid(lnv_filesvr) Then Destroy lnv_filesvr	
			RETURN -1
		END IF
		
	else
		as_tif_name[li_cnt] = ls_pdf_name[li_cnt]
	end if
	
next

Destroy lnv_image_func
if isvalid(lnv_filesvr) then destroy lnv_filesvr

return 1
end function

public function integer of_get_wordbuild ();//////////////////////////////////////////////////////////////////////
// $<function> of_get_wordbuild
// $<arguments>
// $<returns> integer
// $<description>Convert image or Word Document to TIF file (V12.1 Fax modification)
//////////////////////////////////////////////////////////////////////
// $<add> 12.02.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_build
OLEObject myoleobject

if gs_word_version <> 'word2007' then
	ib_wordbuild = false
	return 1
end if

ib_wordbuild = false
myoleobject = Create oleobject
IF myoleobject.Connecttonewobject("word.application") = 0 THEN 
	myoleobject.Application.NormalTemplate.Saved = TRUE

	ls_build = String(myoleobject.Application.build)
	
    myoleobject.Quit(0) 
    myoleobject.DisconnectObject()	
    destroy myoleobject
	
	if dec(left(ls_build, 2)) > 12 or dec(right(ls_build, 4)) > 6212 then
		ib_wordbuild = true
	end if
else
	ib_wordbuild = false
	if isvalid(myoleobject) then destroy myoleobject
	return -1
END IF


return 1
end function

public function string of_modify_path (string as_file_path, string as_file_type, integer ai_att);//////////////////////////////////////////////////////////////////////
// $<function> of_combine_file
// $<arguments>
// $<returns> integer
// $<description>combine the files into a single PDF file (V12.1 Fax modification)
//////////////////////////////////////////////////////////////////////
// $<add> 02.10.2012 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_new_path, ls_file, ls_old_file

ls_new_path = left(as_file_path, lastpos(as_file_path, '\') - 1)
ls_new_path = left(ls_new_path, lastpos(ls_new_path, '\')) + 'faxcombine'
if not DirectoryExists(ls_new_path) then CreateDirectory(ls_new_path)

if ai_att = 0 then
	ls_old_file = mid(as_file_path, lastpos(as_file_path, '\') + 1)
	ls_old_file = left(ls_old_file, pos(ls_old_file, '.'))
else
	ls_old_file = ''
end if

ls_file = ls_new_path + '\' + ls_old_file + as_file_type
if FileExists(ls_file) then FileDelete(ls_file)
return ls_file
end function

public function integer of_combine_new (string as_infile[], ref string as_outfile);//////////////////////////////////////////////////////////////////////
// $<function> of_combine_new
// $<arguments>
// $<returns> integer
// $<description>the fax is very poor  -Bug 3472
//////////////////////////////////////////////////////////////////////
// $<add> 04.26.2013 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_cnt
integer li_ret
integer  li_file
integer li_image_count, li_page
integer li_wordcount
long ll_WriteLength
blob lb_data
long ll_len
long ll_cpu
string   ls_ext
string    ls_SourceFile
string ls_DefPrinter
string   ls_image_file_name
boolean lb_catch, lb_first
boolean lb_msg = true
oleobject lole_word
n_cst_filesrvwin32 lnv_filesvr
OLEObject lole_Selection
integer li_pdf_cnt //Added by (APPEON) Harry 11.17.2017 (V161 Storage of Documents as PDFs)
Boolean lb_blankpage = False //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)


//---------Begin Added by (Appeon)Stephen 09.25.2013 for Issue with printing letters verus Fax and Email--------
li_wordcount = 0
for li_cnt = 1  to  upperbound(as_infile) 
	ls_ext = MidA(as_infile[li_cnt], LastPos(as_infile[li_cnt], ".") + 1)
	if (upper(ls_ext) = 'DOC' or upper(ls_ext) = 'DOCX') then
		li_wordcount +=1
	end if
next
//---------End Added ------------------------------------------------------

if li_wordcount = 0 then //(Appeon)Stephen 09.25.2013 - Issue with printing letters verus Fax and Email
	as_outfile = of_modify_path(as_infile[1], 'attachment.doc', 1)
	
	//lb_data = blob("")
	lb_data = blob("", EncodingAnsi!) //Encoding – Harry 11.15.2013
	ll_WriteLength = AppeonWriteFile(as_outfile, lb_data, Lena(lb_data)) //(Appeon)Stephen 11.07.2013 - BugT103102
	if ll_WriteLength < 0 then Return -1
end if

lole_word = create oleobject
try
	if li_wordcount =0 then  //(Appeon)Stephen 09.25.2013 - Issue with printing letters verus Fax and Email
		li_ret = lole_word.connecttonewobject("Word.Application")
		lole_word.documents.open(as_outfile)
		
		lole_word.ActiveDocument.Content.Select()
		
		lole_Selection = lole_word.ActiveDocument.ActiveWindow.Selection
		lole_Selection.GoTo(1, 1)
	end if
	
	lb_first = true
	for li_cnt = 1 to upperbound(as_infile)
		ls_ext = MidA(as_infile[li_cnt], LastPos(as_infile[li_cnt], ".") + 1)
		if (upper(ls_ext) <> 'DOC' and upper(ls_ext) <> 'DOCX') then
			continue
		end if
		
		//---------Begin Modified by (Appeon)Stephen 09.25.2013 for V141 Email/Fax Applications to Payors--------
		/*
		lole_Selection.InsertFile(as_infile[li_cnt])
		lole_Selection.InsertParagraphafter()
		*/
		if lb_first then
			as_outfile = as_infile[li_cnt]
			li_ret = lole_word.connecttonewobject("Word.Application")
			lole_word.documents.open(as_outfile)
			
			lole_word.ActiveDocument.Content.Select()
			
			lole_Selection = lole_word.ActiveDocument.ActiveWindow.Selection			
			//---------Begin Modified by (Appeon)Stephen 11.11.2013 for BugT103102--------
			//lole_Selection.GoTo(0, -1)	
			lole_Selection.endkey(6)
			lole_Selection.InsertBreak(2)  
			lb_blankpage = True //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
			lb_first = false
			//---------End Modfiied ------------------------------------------------------	
		else
			lole_Selection.InsertFile(as_infile[li_cnt])
			lole_Selection.InsertParagraphafter()
			lole_Selection.endkey(6)
			lole_Selection.InsertBreak(2)
			lb_blankpage = True //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
		end if
		//---------End Modfiied ------------------------------------------------------
		
	next
	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 05.27.2013
	//$<reason> Error calling external object function
	//lole_word.WordBasic.PageSetupMargins(0,0,"0","0","0","0","0","21","29.7",0,0,0,0,1)
	lole_Selection.PageSetup.TopMargin = 0
	lole_Selection.PageSetup.LeftMargin = 0
	lole_Selection.PageSetup.RightMargin = 0
	lole_Selection.PageSetup.BottomMargin = 0
	//(Appeon)Stephen 09.25.2013 - Issue with printing letters verus Fax and Email
	lole_Selection.PageSetup.DifferentFirstPageHeaderFooter = true
	lole_Selection.PageSetup.HeaderDistance = 0
	lole_Selection.PageSetup.FooterDistance = 0
	//------------------- APPEON End -------------------
catch(throwable th3)  //add try...catch by stephen 05.27.2013  --Error calling external object function
	if isvalid(lole_Selection) then destroy lole_Selection
	lole_word.quit(0)
	lole_word.disconnectobject()
	destroy lole_word
	return	 -1	
end try

for li_cnt = 1 to upperbound(as_infile)
	ls_ext = MidA(as_infile[li_cnt], LastPos(as_infile[li_cnt], ".") + 1)
	if (upper(ls_ext) = 'DOC' or upper(ls_ext) = 'DOCX') then
		continue
	end if
	
	try
		if upper(ls_ext) = 'TIF' then
			ole_admin.object.Image(as_infile[li_cnt])
			li_image_count = ole_admin.object.pagecount()
			if li_image_count = 1 then
				//Convert tif compressiontype from JPEG to LWZ for office 2010
				If Integer(gs_word_version_num) >= 14 And ole_admin.object.CompressionType = 6 Then //JPEG
					ole_edit.object.Image( as_infile[li_cnt] )
					ole_edit.object.display()
					ole_edit.object.SaveAs(as_infile[li_cnt],1,6,9,8,false)
				End If
				
				lole_Selection.InlineShapes.AddPicture(as_infile[li_cnt], false,true)
			else
				For li_page=1 to li_image_count
					FileDelete( gs_temp_path + "temp.tif" )
					
					//set the image file name to temp.tif
					ls_image_file_name = gs_temp_path + "temp.tif"
					ole_page.object.Image( ls_image_file_name )
					ole_page.object.Append( as_infile[li_cnt], li_page , 1 )	
					
					//Convert tif compressiontype from JPEG to LWZ for office 2010
					If Integer(gs_word_version_num) >= 14 And ole_page.object.CompressionType = 6 Then //JPEG
						ole_edit.object.Image( ls_image_file_name )
						ole_edit.object.display()
						ole_edit.object.SaveAs(ls_image_file_name,1,6,9,8,false)
					End If
					
					lole_Selection.InlineShapes.AddPicture(ls_image_file_name, false,true)
					//---------Begin Added by (Appeon)Stephen 09.18.2014 for  Androscoggin Valley Hospital Personal Reference Request--------
					if not(li_page = li_image_count and li_cnt =upperbound(as_infile))  then
						lole_Selection.endkey(6)
						lole_Selection.InsertBreak(2)
						lb_blankpage = True //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
					else
						lb_blankpage = False //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
					end if
					lole_Selection.PageSetup.DifferentFirstPageHeaderFooter = true
					lole_Selection.PageSetup.HeaderDistance = 0
					lole_Selection.PageSetup.FooterDistance = 0
					//---------End Added ------------------------------------------------------
				End for
	
			end if
		elseif upper(ls_ext) = 'PDF' then  //Added by (APPEON) Harry 11.17.2017 (V161 Storage of Documents as PDFs)
			IF li_pdf_cnt = 0 THEN
				FileDelete( gs_temp_path + "temp.pdf" )
			END IF
			IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
			w_dm_image_cp.Dynamic of_pdfeditmerge(gs_temp_path + "temp.pdf", as_infile[li_cnt])
			li_pdf_cnt ++
		else
			lole_Selection.InlineShapes.AddPicture(as_infile[li_cnt], false,true)
		end if
	catch(throwable th4)//add try...catch by stephen 05.27.2013  --Error calling external object function
		if isvalid(lole_Selection) then destroy lole_Selection
		lole_word.quit(0)
		lole_word.disconnectobject()
		destroy lole_word
		IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
		return	 -1	
	end try
next
IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)

if is_type <> 'email' then 
	IF li_pdf_cnt > 0 THEN //Added by (APPEON) Harry 11.17.2017 (V161 Storage of Documents as PDFs)
		lole_word.ActiveDocument.SaveAs(as_outfile,17) //PDF format
		IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
		IF lb_blankpage THEN //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
			w_dm_image_cp.Dynamic of_delete_page_pdf(as_outfile, w_dm_image_cp.of_gettotalpage(as_outfile), 1)
		END IF
		w_dm_image_cp.Dynamic of_pdfeditmerge(as_outfile, gs_temp_path + "temp.pdf")
		IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
	ELSE
		lole_word.ActiveDocument.saveas(as_outfile,0)
	END IF
else
	IF ib_wordbuild = true THEN  //Word 2007 SP2
		try
			as_outfile = of_modify_path(as_infile[1], 'attachment.pdf', 1)
			lole_word.ActiveDocument.SaveAs(as_outfile,17) //PDF format
			IF li_pdf_cnt > 0 THEN //Added by (APPEON) Harry 11.17.2017 (V161 Storage of Documents as PDFs)
				IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
				IF lb_blankpage THEN //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs) 
					w_dm_image_cp.Dynamic of_delete_page_pdf(as_outfile, w_dm_image_cp.of_gettotalpage(as_outfile), 1)
				END IF
				w_dm_image_cp.Dynamic of_pdfeditmerge(as_outfile, gs_temp_path + "temp.pdf")
				IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
			END IF
		Catch(Throwable th2) 
				lb_catch = true
		end try
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 06.25.2015
		//<$>Walk around it for WEB version in temporary, for Case #00055255 Issue with Emailing/Faxing Letters 
		If Not FileExists(as_outfile) And Not lb_catch Then
			if isvalid(lole_Selection) then destroy lole_Selection
			lole_word.quit(0)
			lole_word.disconnectobject()
			destroy lole_word		
			return -1
		End If
		//------------------- APPEON END -------------------
	end if
	
	if ib_wordbuild = false or lb_catch then
		//---------Begin Added by (Appeon)Stephen 02.17.2014 for citrix user pdf print--------
		if gi_citrix = 1 then
			if isvalid(lole_Selection) then destroy lole_Selection
			lole_word.quit(0)
			lole_word.disconnectobject()
			destroy lole_word
			return -1
		end if
		//---------End Added ------------------------------------------------------	
		
		ls_SourceFile = gs_temp_pdf
		//---------Begin Modified by (Appeon)Stephen 02.13.2014 for PDF Printer Issues--------
		//IF FileExists(ls_SourceFile) THEN FileDelete(ls_SourceFile)
		ll_cpu = cpu()
		li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
		do while li_ret = 1
			li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
		loop
		if li_ret = -1 then 
			if isvalid(lole_Selection) then destroy lole_Selection
			lole_word.quit(0)
			lole_word.disconnectobject()
			destroy lole_word		
			return -1
		end if
		//---------End Modfiied ------------------------------------------------------	
		
		Try
			if f_PrinterSetup(2) >= 2 then 
				if isvalid(lole_Selection) then destroy lole_Selection
				lole_word.quit(0)
				lole_word.disconnectobject()
				destroy lole_word
				return	 -1	
			end if
			ll_Len = 100
			ls_DefPrinter = SPACE(ll_Len)
			GetDefaultPrinter(ls_DefPrinter,ll_Len)	
		
			lole_word.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
			lole_word.ActiveDocument.Printout( 0 )
			
			SetDefaultPrinter(ls_DefPrinter)			
		Catch(Throwable th1) 
			if isvalid(lole_Selection) then destroy lole_Selection
			lole_word.quit(0)
			lole_word.disconnectobject()
			destroy lole_word
			
			RETURN -1
		End Try
		
		as_outfile = of_modify_path(as_infile[1], 'attachment.pdf', 1)
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
		lnv_filesvr.of_filecopy(ls_sourcefile, as_outfile )
		
		IF li_pdf_cnt > 0 THEN //Added by (APPEON) Harry 11.17.2017 (V161 Storage of Documents as PDFs)
			IF Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
			IF lb_blankpage THEN //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs) 
				w_dm_image_cp.Dynamic of_delete_page_pdf(as_outfile, w_dm_image_cp.of_gettotalpage(as_outfile), 1)
			END IF
			w_dm_image_cp.Dynamic of_pdfeditmerge(as_outfile, gs_temp_path + "temp.pdf")
			IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
		END IF
		if isvalid(lnv_filesvr) then destroy lnv_filesvr
	end if
end if


if isvalid(lole_Selection) then destroy lole_Selection
lole_word.quit(0)
lole_word.disconnectobject()
destroy lole_word

return 1
end function

on w_letter_combine.create
this.ole_edit=create ole_edit
this.ole_word=create ole_word
this.ole_page=create ole_page
this.ole_admin=create ole_admin
this.st_1=create st_1
this.p_1=create p_1
this.Control[]={this.ole_edit,&
this.ole_word,&
this.ole_page,&
this.ole_admin,&
this.st_1,&
this.p_1}
end on

on w_letter_combine.destroy
destroy(this.ole_edit)
destroy(this.ole_word)
destroy(this.ole_page)
destroy(this.ole_admin)
destroy(this.st_1)
destroy(this.p_1)
end on

type ole_edit from olecustomcontrol within w_letter_combine
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
integer x = 1934
integer y = 504
integer width = 457
integer height = 200
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_letter_combine.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_word from olecustomcontrol within w_letter_combine
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
boolean visible = false
integer x = 1157
integer y = 488
integer width = 416
integer height = 800
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_letter_combine.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event constructor;//Replace the old_word with new Office Control  - (Appeon)Alfee 11.12.2013 - V141 ISG-CLX

IF gs_word_version = 'word2007' THEN
	IF gnv_reg_ocx.of_check_ocx(1,'',False) <> '' THEN return -1

	//Set the primary key
	this.object.MakerCaption="IntelliSoft Group Inc."
	this.object.MakerKey="B6DE7E7AC5ECB2246623312AFA9289F069F21D6E"
	//Set the title key
	this.object.ProductCaption="IntelliSoft Group Inc."
	this.object.ProductKey="D2FA8177167CF61E789F322B794D4DD12E86EC68"
END IF
end event

type ole_page from olecustomcontrol within w_letter_combine
event filepropertiesclose ( )
boolean visible = false
integer x = 590
integer y = 704
integer width = 407
integer height = 292
integer taborder = 70
borderstyle borderstyle = stylelowered!
string binarykey = "w_letter_combine.win"
integer binaryindex = 2
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_admin from olecustomcontrol within w_letter_combine
event filepropertiesclose ( )
boolean visible = false
integer x = 119
integer y = 720
integer width = 210
integer height = 188
integer taborder = 60
borderstyle borderstyle = stylelowered!
string binarykey = "w_letter_combine.win"
integer binaryindex = 3
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type st_1 from statictext within w_letter_combine
integer x = 123
integer y = 84
integer width = 1061
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "File is combining , Please stand by"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_letter_combine
integer x = 96
integer y = 304
integer width = 1189
integer height = 160
string picturename = "infodisp.gif"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
09w_letter_combine.bin 
2600000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000bcaa04e001d367ef00000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000bca9ddd001d367efbcaa04e001d367ef000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
21ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc00000003000200050000000300000a56000000030000052b000000030000006000000002000000010000001e0000000945676d493274696400000000000000032ffffffe0000000b0000ffff000000020000b430000000020000b43000000003001db48000000003001db4800000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500000a560000052b0000006000010001000000006d490800696445670001327400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff00000000ee000100b4d000001000b4d0100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000bcaa04e001d367ef00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000bcaa04e001d367efbcaa04e001d367ef0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00000968000014ac00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00000968000014ac00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f007200700075000000500034004300430035
2E00300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000bcaa04e001d367ef00000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000
24000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000bcaa04e001d367efbcaa04e001d367ef000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f000000007000001000000004000000101000000480000010200000050000001030000005800000104000000600000010500000068000000000000007000000003000300020000000300000933000000030000078b0000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000030002000009330000078b00000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
27ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000bcaa04e001d367ef00000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000bcaa04e001d367efbcaa04e001d367ef000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f0000000070000010000000040000001010000004800000102000000500000010300000058000001040000006000000105000000680000000000000070000000030003000200000003000004c100000003000004dc0000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000030002000004c1000004dc00000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19w_letter_combine.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
