$PBExportHeader$n_cst_pdf2text.sru
forward
global type n_cst_pdf2text from nonvisualobject
end type
end forward

global type n_cst_pdf2text from nonvisualobject autoinstantiate
end type

type prototypes
//Not use - jervis 11.16.2010
//function boolean InitializePDF() library "ConvertPDF.dll"
//function boolean UninitializePDF() library "ConvertPDF.dll"
function string PDF2StringA(string strFile, ref long lRet) library "appeondll.dll" alias for "PDF2StringA;Ansi" //"ConvertPDF.dll" //Modify by Evan 10/08/2008
end prototypes

forward prototypes
public function integer of_pdf2text (string as_filename, ref string as_pdftext)
public function integer of_pdf2text (string as_filename, ref string as_pdftext, boolean ab_force)
end prototypes

public function integer of_pdf2text (string as_filename, ref string as_pdftext);//Modified By Ken.Guo 05/19/2012
Return of_pdf2text(as_filename, as_pdftext, False )

//
////Begin - Modified By Ken.Guo 2010-02-01 .Add page info.
//
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 11.06.2006 By: Davis
////$<reason> Pick-up all characters(using a DLL) from PDF file.
//long ll_Ret
//
////Added By Ken.Guo 2010-10-20.
//If gnv_data.of_getitem( 'icred_settings', 'ocr_engine_pdf', false) <> '1' Then 
//	Return 1
//End If
//
//as_pdftext = PDF2StringA(as_filename, ll_Ret)
//
//RETURN 1
//
//
///*
//long i
//long ll_step
//oleobject ole_image
//String ls_pdftext,ls_filepage
//long ll_Ret,ll_pagecount
//
//ls_pdftext = PDF2StringA(as_filename, ll_Ret)
//If ls_pdftext = '' Then 
//	as_pdftext = ls_pdftext
//	Return 1
//Else
//	//Open OCR plugin
//	If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)
//	Open(w_dm_image_cp)
//	
//	ole_image = w_dm_image_cp.ole_edit.object
//	
//	If Not FileExists(as_filename) Then 
//		Messagebox('OCR', "The file '" + as_filename + "' does not exist.")
//		Return -1
//	End If
//	
//	If ole_image.LoadMultiPage(as_filename,1) = 0 Then
//		Messagebox('OCR','Failed to load the file.')
//		If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)
//		Return -1
//	End If	
//	
//	ll_pagecount = ole_image.GetTotalPage()
//
//	openwithparm( w_appeon_gifofwait, "OCRing...")
//	Timer(0,w_appeon_gifofwait)
//	
//	For i = 1 To ll_pagecount
//		w_appeon_gifofwait.BringToTop	= True
//		w_appeon_gifofwait.of_settext("OCRing page " + String(i) + " of " + String(ll_pagecount)+ ", please stand by ...")
//		w_appeon_gifofwait.of_setposition(10 + i/ll_pagecount * 80)		
//		ls_filepage = 'c:\test' + string(i)
//		ole_image.ExportTIF( as_filename ,ls_filepage, "pdf",1,24 )
//		as_pdftext += PDF2StringA(ls_filepage + '.pdf', ll_Ret)
//		as_pdftext += '~r~n<<<<<<<<<<<<<<<<<<<<<<<< P A G E ' +String(i)+ ' >>>>>>>>>>>>>>>>>>>>>>>>~r~n~r~n'
//	Next
//	w_appeon_gifofwait.of_setposition(100)
//	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)	
//	Return 1
//
//End If
////End - Modified By Ken.Guo 2010-02-01
//*/
end function

public function integer of_pdf2text (string as_filename, ref string as_pdftext, boolean ab_force);
//Begin - Modified By Ken.Guo 2010-02-01 .Add page info.


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.06.2006 By: Davis
//$<reason> Pick-up all characters(using a DLL) from PDF file.
long ll_Ret

//Added By Ken.Guo 05/19/2012. Add ab_force argument
If Not ab_force Then
	//Added By Ken.Guo 2010-10-20.
	If gnv_data.of_getitem( 'icred_settings', 'ocr_engine_pdf', false) <> '1' Then 
		Return 1
	End If
End If	

as_pdftext = PDF2StringA(as_filename, ll_Ret)

RETURN 1


/*
long i
long ll_step
oleobject ole_image
String ls_pdftext,ls_filepage
long ll_Ret,ll_pagecount

ls_pdftext = PDF2StringA(as_filename, ll_Ret)
If ls_pdftext = '' Then 
	as_pdftext = ls_pdftext
	Return 1
Else
	//Open OCR plugin
	If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)
	Open(w_dm_image_cp)
	
	ole_image = w_dm_image_cp.ole_edit.object
	
	If Not FileExists(as_filename) Then 
		Messagebox('OCR', "The file '" + as_filename + "' does not exist.")
		Return -1
	End If
	
	If ole_image.LoadMultiPage(as_filename,1) = 0 Then
		Messagebox('OCR','Failed to load the file.')
		If isvalid(w_dm_image_cp) Then Close(w_dm_image_cp)
		Return -1
	End If	
	
	ll_pagecount = ole_image.GetTotalPage()

	openwithparm( w_appeon_gifofwait, "OCRing...")
	Timer(0,w_appeon_gifofwait)
	
	For i = 1 To ll_pagecount
		w_appeon_gifofwait.BringToTop	= True
		w_appeon_gifofwait.of_settext("OCRing page " + String(i) + " of " + String(ll_pagecount)+ ", please stand by ...")
		w_appeon_gifofwait.of_setposition(10 + i/ll_pagecount * 80)		
		ls_filepage = 'c:\test' + string(i)
		ole_image.ExportTIF( as_filename ,ls_filepage, "pdf",1,24 )
		as_pdftext += PDF2StringA(ls_filepage + '.pdf', ll_Ret)
		as_pdftext += '~r~n<<<<<<<<<<<<<<<<<<<<<<<< P A G E ' +String(i)+ ' >>>>>>>>>>>>>>>>>>>>>>>>~r~n~r~n'
	Next
	w_appeon_gifofwait.of_setposition(100)
	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)	
	Return 1

End If
//End - Modified By Ken.Guo 2010-02-01
*/
end function

on n_cst_pdf2text.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_pdf2text.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//InitializePDF()


//Added for pdf to text 12/8/2006 Henry
changeDirectory(gs_current_path)
end event

event destructor;//UninitializePDF()
end event

