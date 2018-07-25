$PBExportHeader$n_cst_image_cp_ocr.sru
$PBExportComments$PFC String service~r~n(Appeon)Toney 06.05.2013 - V141 ISG-CLX
forward
global type n_cst_image_cp_ocr from nonvisualobject
end type
end forward

global type n_cst_image_cp_ocr from nonvisualobject
end type
global n_cst_image_cp_ocr n_cst_image_cp_ocr

type prototypes
function long GetDllDirectory(ref string as_Path) library "appeondll.dll" alias for "GetDllDirectory;Ansi"
end prototypes

type variables
String is_ocx_path 
Integer ii_ocr_mode = 2, ii_language = 0, ii_ocr_engine_pdf = 1
Boolean ib_stop = false
end variables

forward prototypes
public function integer of_download_dirc (integer ai_language)
public function integer of_get_dirc_file_list (integer ai_language, ref string as_file_list[])
public function integer of_check_dirc_files (integer ai_language)
public function string of_ocr (oleobject ole_image, integer ai_language)
public function string of_ocr (string as_file)
public subroutine of_stop_ocr ()
public subroutine of_get_default_ocr_settings ()
public function integer of_get_ocr_result (long al_doc_id, decimal adc_revision, ref string as_ocr_result, string as_from)
public subroutine of_set_ocr_settings (integer ai_language, integer ai_ocr_mode, integer ai_ocr_engine_pdf)
end prototypes

public function integer of_download_dirc (integer ai_language);string ls_file_list[]
long ll_count,ll_i,ll_ret
n_appeon_download lnv_download

String ls_downurl,ls_downurl_org


SELECT TOP 1 downloadurl INTO :ls_downurl FROM icred_settings;
If Len(ls_downurl) > 0 Then
	ls_downurl_org = ls_downurl
	ls_downurl = ls_downurl + '/dictfiles/'
Else
	// 03/08/12 Added By mark 
//	Messagebox('Failed','Failed to download the OCR dictionary files, please set the application download URL.')
	if gb_recordlog = true then 
		gs_errmsg = 'Failed ->Failed to download the OCR dictionary files, please set the application download URL.'
	else 
		Messagebox('Failed','Failed to download the OCR dictionary files, please set the application download URL.')
	end if 
	Return -1
End If

This.of_get_dirc_file_list( ai_language, ls_file_list[] ) 

openwithparm( w_appeon_gifofwait, "Downloading the OCR dictionary files from Server, Please stand by...")

ll_count = UpperBound(ls_file_list[])

for ll_i = 1 to ll_count
	ll_ret = lnv_download.of_downloadfile( ls_downurl,is_ocx_path + '\dictfiles\' + ls_file_list[ll_i])
	if ll_ret <> 0 then exit
next

if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

if ll_i <= ll_count then
	// 03/08/12 Added By mark 
//	MessageBox("Download infomation","Failed to download the OCR dictionary files, please call support.")
	if gb_recordlog = true then 
		gs_errmsg = "Download infomation ->Failed to download the OCR dictionary files, please call support."
	else
		MessageBox("Download infomation","Failed to download the OCR dictionary files, please call support.")	
	end if
	return -1
end if

////Added By Ken.Guo 2010-11-29. For Image CP 6.0.
//ll_ret = lnv_download.of_downloadfile( ls_downurl_org + '/tessdata/',is_ocx_path + '\tessdata\eng.traineddata' )
//If ll_ret <> 0 Then
//	MessageBox("Download infomation","Failed to download the OCR files 'eng.traineddata', please call support.")
//	return -1	
//End If



return 1
end function

public function integer of_get_dirc_file_list (integer ai_language, ref string as_file_list[]);Choose Case ai_language
	Case 0 // English 
		as_file_list[] = { &
		"eng.DangAmbigs", &
		"eng.freq-dawg", &
		"eng.inttemp", &
		"eng.normproto", &
		"eng.pffmtable", &
		"eng.unicharset", &
		"eng.user-words", &
		"eng.word-dawg" }
	Case 1 // German
		as_file_list[] = { &
		"deu.DangAmbigs", &
		"deu.freq-dawg", &
		"deu.inttemp", &
		"deu.normproto", &
		"deu.pffmtable", &
		"deu.unicharset", &
		"deu.user-words", &
		"deu.word-dawg" }
	Case 2 // Fraktur
		as_file_list[] = { &
		"deu-f.DangAmbigs", &
		"deu-f.freq-dawg", &
		"deu-f.inttemp", &
		"deu-f.normproto", &
		"deu-f.pffmtable", &
		"deu-f.unicharset", &
		"deu-f.user-words", &
		"deu-f.word-dawg", &
		"fra.DangAmbigs", &
		"fra.freq-dawg", &
		"fra.inttemp", &
		"fra.normproto", &
		"fra.pffmtable", &
		"fra.unicharset", &
		"fra.user-words", &
		"fra.word-dawg" }
	Case 3 // Italian
		as_file_list[] = { &
		"ita.DangAmbigs", &
		"ita.freq-dawg", &
		"ita.inttemp", &
		"ita.normproto", &
		"ita.pffmtable", &
		"ita.unicharset", &
		"ita.user-words", &
		"ita.word-dawg"	}	
	Case 4 // Dutch
		as_file_list[] = { &
		"nld.DangAmbigs", &
		"nld.freq-dawg", &
		"nld.inttemp", &
		"nld.normproto", &
		"nld.pffmtable", &
		"nld.unicharset", &
		"nld.user-words", &
		"nld.word-dawg"	}	
	Case 5 // Portuguese
		as_file_list[] = { &
		"por.DangAmbigs", &
		"por.freq-dawg", &
		"por.inttemp", &
		"por.normproto", &
		"por.pffmtable", &
		"por.unicharset", &
		"por.user-words", &
		"por.word-dawg"	}	
	Case 6 // Spanish
		as_file_list[] = { &
		"spa.DangAmbigs", &
		"spa.freq-dawg", &
		"spa.inttemp", &
		"spa.normproto", &
		"spa.pffmtable", &
		"spa.unicharset", &
		"spa.user-words", &
		"spa.word-dawg"	}	
End Choose

Return 1
end function

public function integer of_check_dirc_files (integer ai_language);String ls_file_list[]
integer i

This.of_get_dirc_file_list(ai_language ,ls_file_list[])

For i = 1 To UpperBound( ls_file_list[])
	If Not FileExists(is_ocx_path + '\dictfiles\' + ls_file_list[i]) Then
		Return -1
	End If
Next

////Added By Ken.Guo 2010-11-29. For Image CP 6.0.
//If Not FileExists(is_ocx_path + '\tessdata\eng.traineddata') Then
//	Return -1
//End If

Return 1

end function

public function string of_ocr (oleobject ole_image, integer ai_language);String ls_ocr_ret


//Set some defalut settings
ole_image.OCRRecognizeMode = ii_ocr_mode
ole_image.OCRSetRect( 0,0,0, 0)

//Set filter
If ai_language = 0 Then
ole_image.OCRCharFilter = 'abcdefghijklmnopqrstuvwxyz' + &
								  'ABCDEFGHIJKLMNOPQRSTUVWXYZ' + &
								  '1234567890`-=[]\;~',./~!@#$%^&*()_+{}|:"<>?'
End If

//Start OCR
w_dm_image_cp.of_reset_ocr()
ole_image.OCRStartScan(ai_language, "dictfiles")

//OCR...
Do While Not w_dm_image_cp.of_ocr_is_finished() //ole_image.OCRIsRecognizing()
	Yield()
	Sleep(10)  //Must sleep 10ms. Otherwise IE will show the 'Stop running' message.
	If ib_stop Then 
		w_dm_image_cp.ib_ocr_finished = True
		SetPointer(HourGlass!)
//		Sleep(5000) //Added By Ken.Guo 2011-01-30. Workaround Crash Bug
		ole_image.OCRStopScan()
		SetPointer(Arrow!)
		Return ''
	End If
	SetPointer(HourGlass!)
Loop

//return OCR result
//ls_ocr_ret = ole_image.OCRGetRecognizedText( )
ls_ocr_ret = w_dm_image_cp.of_get_last_ocr_text()

Return ls_ocr_ret
end function

public function string of_ocr (string as_file);long ll_page_cnt,i
long ll_step
String ls_ocr_ret,ls_ocr_temp
String ls_doc_ext
oleobject ole_image
String ls_temp_file
Boolean lb_singe_page_file = False
String ls_path

of_get_default_ocr_settings()

ls_path = gs_dir_path + gs_DefDirName + "\Agreement\Manager\"
gnv_appeondll.of_parsepath(ls_path)

//Check OCR dirc files
If of_check_dirc_files(ii_language) < 0 Then
	If This.of_download_dirc(ii_language) < 0 Then
		Return ''
	End If
End If

//Open OCR plugin
If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)
Open(w_dm_image_cp)
ole_image = w_dm_image_cp.ole_edit.object

If Not FileExists(as_file) Then 
	// 03/09/12 Added By mark 
//	Messagebox('OCR Failure', "The file '" + as_file + "' does not exist.")
	if gb_recordlog = true then 
		gs_errmsg =  "OCR Failure ->The file '" + as_file + "' does not exist."
	else 
		Messagebox('OCR Failure', "The file '" + as_file + "' does not exist.")
	end if 
	If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)
	Return ''
End If

ls_doc_ext = Mid(as_file, Lastpos(as_file,'.') + 1)
ls_temp_file = Mid(as_file, LastPos(as_file,'\') + 1, Len(as_file)) //Added By Ken.Guo 2010-05-28.
ls_temp_file = Left(ls_temp_file,Lastpos(ls_temp_file,'.') - 1 ) + '_temp.' + ls_doc_ext
ls_temp_file = ls_path + ls_temp_file //Added By Ken.Guo 2010-05-28.

If FileExists(ls_temp_file) Then
	If Not FileDelete(ls_temp_file) Then
		// 03/09/12 Added By mark 
//		Messagebox('OCR Failure','Failed to delete the temp file ' + ls_temp_file + '.')
		if gb_recordlog = true then 
			gs_errmsg = 'OCR Failure ->Failed to delete the temp file ' + ls_temp_file + '.'
		else 
			Messagebox('OCR Failure','Failed to delete the temp file ' + ls_temp_file + '.')
		end if 
		Return ''
	End If
End If
If FileCopy(as_file,ls_temp_file,True) <> 1 Then
	// 03/09/12 Added By mark 
//	Messagebox('OCR Failure','Failed to copy the source file, please call support.')
	if gb_recordlog = true then 
		gs_errmsg = 'OCR Failure ->Failed to copy the source file, please call support.'
	else 
		Messagebox('OCR Failure','Failed to copy the source file, please call support.')
	end if
	Return ''
End If

Choose Case Upper(ls_doc_ext) 
	Case	'PDF','TIF','TIFF'
		If ole_image.LoadMultiPage(ls_temp_file,1) = 0 Then
			// 03/09/12 Added By mark 
//			Messagebox('OCR Failure','Failed to load the file.')
			if gb_recordlog = true then 
				gs_errmsg = 'OCR Failure ->Failed to load the file.'
			else 
				Messagebox('OCR Failure','Failed to load the file.')
			end if
			If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)
			FileDelete(ls_temp_file)
			Return ''
		End If		
	Case Else 
		ole_image.filename = ls_temp_file
		lb_singe_page_file = True
End Choose

openwithparm( w_appeon_gifofwait, "OCRing...")
Timer(0,w_appeon_gifofwait)
w_appeon_gifofwait.of_enablecancel(True)

//Do OCR
If lb_singe_page_file Then
	ls_ocr_ret = of_ocr(ole_image,ii_language)
	If ls_ocr_ret <> '' Then
		ls_ocr_ret += '~r~n<<<<<<<<<<<<<<<<<<<<<<<< P A G E 1 >>>>>>>>>>>>>>>>>>>>>>>>~r~n~r~n'
	End If
	If ib_stop Then 
		//Stop OCR.
		If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)
		FileDelete(ls_temp_file)
		Return '' 
	End If	
Else
	ll_page_cnt = ole_image.GetTotalPage()
	ib_stop = False
	For i = 1 To ll_page_cnt

		w_appeon_gifofwait.BringToTop	= True
		w_appeon_gifofwait.of_settext("OCRing page " + String(i) + " of " + String(ll_page_cnt)+ ", please stand by ...")
		w_appeon_gifofwait.of_setposition(10 + i/ll_page_cnt * 80)
		If ole_image.LoadMultiPage(ls_temp_file,i) <> 1 Then
			// 03/09/12 Added By mark 
//			Messagebox('OCR Failure','Failed to load page ' + String(i) + '.') 
			if gb_recordlog = true then 
				gs_errmsg = 'OCR Failure ->Failed to load page ' + String(i) + '.'
			else 
				Messagebox('OCR Failure','Failed to load page ' + String(i) + '.') 
			end if 
			Continue
		End If
		ls_ocr_temp = of_ocr(ole_image,ii_language)
		ole_image.LoadMultiPage('',0)		
		If ls_ocr_temp <> '' Then		
			ls_ocr_ret += ls_ocr_temp
			ls_ocr_ret += '~r~n<<<<<<<<<<<<<<<<<<<<<<<< P A G E ' +String(i)+ ' >>>>>>>>>>>>>>>>>>>>>>>>~r~n~r~n'
		End If
		
		//Stop OCR If canceled by user press ESC key
		If Not isvalid(w_appeon_gifofwait) Then
			of_stop_ocr()
		End If	
		
		If ib_stop Then 
			//Stop OCR.
			If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
			If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)
			FileDelete(ls_temp_file)
			Return '' 
		End If
	Next
End If

w_appeon_gifofwait.of_setposition(100)
If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)

//Release image file. Otherwise, PB will lock the file.
If lb_singe_page_file Then
	ole_image.filename = ''
Else
	ole_image.LoadMultiPage('',0)
End If
If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)

FileDelete(ls_temp_file)

Return ls_ocr_ret
end function

public subroutine of_stop_ocr ();ib_stop = true

end subroutine

public subroutine of_get_default_ocr_settings ();
ii_language = Integer(gnv_data.of_getitem( 'icred_settings', 'ocr_language', False))
ii_ocr_mode = Integer(gnv_data.of_getitem( 'icred_settings', 'ocr_mode', False))
ii_ocr_engine_pdf = Integer(gnv_data.of_getitem( 'icred_settings', 'ocr_engine_pdf', False))
end subroutine

public function integer of_get_ocr_result (long al_doc_id, decimal adc_revision, ref string as_ocr_result, string as_from);//as_from: dm (document manager),dl (document library)


Integer li_counter, li_loops, li_MaxPosition, li_Position
Integer li_SetStep, li_NewStep, li_loopsR, li_rtn
Long ll_start, ll_data_length
String ls_title
Boolean lb_needrestore = FALSE
string ls_data, ls_all_data

SetPointer(HourGlass!) 

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	// Get file data from database	
	Choose Case lower(as_from)
		Case	'dm' //document manager
			SELECT Datalength(pdftext)
			INTO :ll_data_length
			FROM ctx_am_doc_image
			WHERE doc_id = :al_doc_id
			AND revision = :adc_revision;
		Case 'dl' //Document Library
			
			
	End Choose
	
	IF SQLCA.SQLCODE = -1 THEN 
		MessageBox( "OCR", "Download OCR Text failed! ~r~n" + SQLCA.SQLERRTEXT )
		RETURN -1 
	End If
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		RETURN 0
	END IF
	
	//Get length of the blob
	IF ll_data_length > 8000 THEN 
		 IF Mod(ll_data_length,8000) = 0 THEN 
			  li_loops = ll_data_length/8000 
		 ELSE 
			  li_loops = (ll_data_length/8000) + 1 
		 END IF 
	ELSE 
		 li_loops = 1 
	END IF 
	
	li_NewStep = 20
	IF li_loops > li_NewStep THEN
		IF Not IsValid(w_appeon_gifofwait) THEN 
			OpenwithParm(w_appeon_gifofwait,"Getting the data...")
		END IF
		//Set the new progress bar
		li_loopsR = li_loops / li_NewStep
		IF Mod(li_loops, li_NewStep) <> 0 THEN li_loopsR ++
		w_appeon_gifofwait.st_1.Text = "Getting the data..."
		w_appeon_gifofwait.hpb_1.MaxPosition = li_loopsR * li_NewStep
		w_appeon_gifofwait.hpb_1.Position = 0
		w_appeon_gifofwait.hpb_1.SetStep = li_loopsR		
	END IF
	
	//Get and store the blob
	li_rtn = 1
	FOR li_counter = 1 to li_loops
		ll_start = (li_counter - 1) * 8000 + 1
		Choose Case lower(as_from)
			Case	'dm' //document manager
				SELECT substring(pdftext,:ll_start,8000)
						INTO :ls_data
						FROM ctx_am_doc_image
						WHERE doc_id = :al_doc_id
						AND revision = :adc_revision;
			Case 'dl'
				
		End Choose
		
		IF SQLCA.SQLCODE = -1 THEN 
			li_rtn = -1
			EXIT
		END IF
		
		ls_all_data += ls_data
		
		//Change the progress bar
		IF IsValid(w_appeon_gifofwait) AND li_loops > li_NewStep THEN
			IF Mod(li_counter, li_loopsR) = 1 THEN w_appeon_gifofwait.hpb_1.StepIt() 
		ELSE
			IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
		END IF
	NEXT 

	IF IsValid(w_appeon_gifofwait)  THEN 
		Close(w_appeon_gifofwait)
	END IF
	
	//Store the blob
	as_ocr_result = ls_all_data
Else //WEB, JDBC Driver.
	
	Choose Case lower(as_from)
		Case	'dm' //document manager	
			SELECT pdftext
					INTO :ls_data
					FROM ctx_am_doc_image
					WHERE doc_id = :al_doc_id
					AND revision = :adc_revision;
		Case 'dl'
			
	End Choose
	
	IF SQLCA.SQLCODE = -1 THEN 
		MessageBox( "OCR", "Download OCR Text failed! ~r~n" + SQLCA.SQLERRTEXT )
		Return -1
	End If
	as_ocr_result = ls_data
END IF	

Return 1
end function

public subroutine of_set_ocr_settings (integer ai_language, integer ai_ocr_mode, integer ai_ocr_engine_pdf);//ii_language = ai_language
//ii_ocr_mode = ai_ocr_mode
//ii_ocr_engine_pdf = ai_ocr_engine_pdf
//
//
end subroutine

on n_cst_image_cp_ocr.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_image_cp_ocr.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;string ls_Path
String ls_reg_path,ls_Value
n_cst_AppeonDll	lnv_Appeon

//ls_reg_path = "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{E589DA78-AD4C-4FC5-B6B9-9E47B110679E}\InprocServer32"
ls_reg_path = "HKEY_CLASSES_ROOT\TypeLib\{C9460280-3EED-11D0-A647-00A0C91EF7B9}\1.0\0\win32"
lnv_Appeon.of_registryget(ls_reg_path,"", RegString!, ls_Value)

If ls_Value <> '' Then
//	is_ocx_path = Mid(ls_Value,1, lastpos(ls_Value,'\') )
	//Added By Mark Lee 05/30/12
	//Begin - Added By Mark Lee 05/30/12
	ls_reg_path ="HKEY_LOCAL_MACHINE\SOFTWARE\Classes\TypeLib\{C9460280-3EED-11D0-A647-00A0C91EF7B9}\1.0\0\win32"
	lnv_Appeon.of_registryget(ls_reg_path,"", RegString!, ls_Value)
	If ls_Value <> '' Then
		is_ocx_path = Mid(ls_Value,1, lastpos(ls_Value,'\') )
	Else
		//------Begin Added by (Bug 5177) Alfee 06.06.2016 -------------
		//<$Reason>For a non-Administrator user, the above registry path of local machine is not existed, the path below is like:
		//<$Reason> "C:\Users\appeon\AppData\Local\Microsoft\Internet Explorer\Downloaded Program Files\ImageViewer2.ocx"
		ls_reg_path = "HKEY_CLASSES_ROOT\TypeLib\{C9460280-3EED-11D0-A647-00A0C91EF7B9}\1.0\0\win32"
		lnv_Appeon.of_registryget(ls_reg_path,"", RegString!, ls_Value)
		If ls_Value <> '' Then
			is_ocx_path = Mid(ls_Value,1, lastpos(ls_Value,'\') )
		Else	
		//-------End Added ---------------------------------------------------
			ls_Path = Space(255)
			GetDllDirectory(ls_Path)
			ls_Path = Trim(ls_Path)
			is_ocx_path = ls_Path 
		End If //Bug 5177 - alfee 06.06.2016 
	End IF 
	//End - Added By Mark Lee 05/30/12
Else
	ls_Path = Space(255)
	GetDllDirectory(ls_Path)
	ls_Path = Trim(ls_Path)
	//Added By Mark Lee 05/30/12
//	is_ocx_path = ls_Path + '\plugin\'	
	is_ocx_path = ls_Path 
End If

of_get_default_ocr_settings()
end event

