$PBExportHeader$n_cst_datawindow.sru
forward
global type n_cst_datawindow from nonvisualobject
end type
end forward

global type n_cst_datawindow from nonvisualobject autoinstantiate
end type

type variables
boolean ib_excel = true  //maha 11.30.2016
end variables

forward prototypes
public function integer of_saveas (datawindow adw_data)
public function integer of_saveas (datawindow adw_data, string as_filename, saveastype ae_saveastype, boolean ab_colheading)
public function integer of_getsaveastype (saveastype ae_saveastype, boolean ab_colheading)
public function integer of_saveas (datawindow adw_data, string as_filename, integer ai_saveastype)
public function integer of_check_type (datawindow adw_data)
end prototypes

public function integer of_saveas (datawindow adw_data);//////////////////////////////////////////////////////////////////////
// $<function> of_saveas
// $<arguments>
//		datawindow	apo_data
// $<returns> integer
// $<description> Save datawindow data as specified file type
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.10.2010
//////////////////////////////////////////////////////////////////////

Return of_SaveAs(adw_Data, "", Text!, true)
end function

public function integer of_saveas (datawindow adw_data, string as_filename, saveastype ae_saveastype, boolean ab_colheading);//////////////////////////////////////////////////////////////////////
// $<function> of_saveas
// $<arguments>
//		datawindow	adw_data
//		string		as_filename
//		saveastype	ae_saveastype
//		boolean		ab_colheading
// $<returns> integer
// $<description> Save datawindow data as specified file type
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.10.2010
//////////////////////////////////////////////////////////////////////

string ls_File
string ls_Filter
integer i, li_Return
long ll_FilterIndex
n_cst_appeondll lnv_dlg
appeon_pdfservice lnv_pdf
//---------Begin Added by (Appeon)Harry 10.15.2014 for Save as Excel8-------
n_cst_excel lnv_excel
boolean	ab_Version
//---------End Added ------------------------------------------------------


// Check arguments
if IsNull(adw_Data) or IsNull(as_FileName) or IsNull(ae_SaveasType) or IsNull(ab_Colheading) then
	SetNull(li_Return)
	Return li_Return
end if
if not IsValid(adw_Data) then Return -1

of_check_type(adw_data)  //Start Code Change ----11.30.2016 #V153 maha

// Get file save name
ll_FilterIndex = of_GetSaveasType(ae_SaveasType, ab_Colheading)
if as_FileName = "" then	
	ls_Filter  = "CSV,*.csv,"
	ls_Filter += "CSV with headers,*.csv,"
	ls_Filter += "Dbase 2,*.dbf,"
	ls_Filter += "Dbase 3,*.dbf,"
	ls_Filter += "DIF,*.dif,"
	ls_Filter += "Excel,*.xlsx,"
	ls_Filter += "Excel with headers,*.xlsx,"
	ls_Filter += "Excel5,*.xls,"
	ls_Filter += "Excel5 with headers,*.xls,"
	ls_Filter += "Excel8 (97 / 2000 / XP / 2003),*.xls,"
	ls_Filter += "Excel8 (97 / 2000 / XP / 2003) with headers,*.xls,"
	ls_Filter += "HTML Table,*.html,"
	ls_Filter += "PDF,*.pdf,"
	ls_Filter += "Powersoft Report,*.psr,"
	ls_Filter += "SQL,*.sql,"
	ls_Filter += "SYLK,*.sylk,"
	ls_Filter += "SYLK with headers,*.sylk,"
	ls_Filter += "Text,*.txt,"
	ls_Filter += "Text with headers,*.txt,"
	ls_Filter += "WKS,*.wks,"
	ls_Filter += "WKS with headers,*.wks,"
	ls_Filter += "WK1,*.wk1,"
	ls_Filter += "WK1 with headers,*.wk1,"
	ls_Filter += "Windows Metafile,*.wmf,"
	ls_Filter += "XML,*.xml,"
	ls_Filter += "XSL-FO,*.fo"
	li_Return = lnv_dlg.of_GetFileSaveName("Save As", ls_File, ll_FilterIndex, ls_Filter, "")
	if li_Return <> 1 then Return -1
end if

//---------Begin Added by (Appeon)Harry 10.15.2014 for Save as Excel8-------
if ll_FilterIndex >= 6 and ll_FilterIndex <= 11 then
	lnv_excel = create n_cst_excel
	if Integer( gf_GetExcelVersion( ) ) >=12 then
		ab_Version = true
	end if
end if
//---------End Added ------------------------------------------------------

// Save as file
choose case ll_FilterIndex
	case 1  //CSV
		li_Return = adw_Data.SaveAs(ls_File, CSV!, false)
	case 2  //CSV with headers
		li_Return = adw_Data.SaveAs(ls_File, CSV!, true)
	case 3  //Dbase 2
		li_Return = adw_Data.SaveAs(ls_File, dBASE2!, true)
	case 4  //Dbase 3
		li_Return = adw_Data.SaveAs(ls_File, dBASE3!, true)
	case 5  //DIF
		li_Return = adw_Data.SaveAs(ls_File, DIF!, true)
		
//Start Code Change ----11.30.2016 #V153 maha - added option to save as excel for composite dw
	case 6  //Excel
		//li_Return = adw_Data.SaveAs(ls_File, Excel!, false) //Commented by (Appeon)Harry 10.15.2014
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, false, ab_Version ) //(Appeon)Harry 10.15.2014
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel!, false)
		end if		
	case 7  //Excel with headers
		//li_Return = adw_Data.SaveAs(ls_File, Excel!, true)  //Commented by (Appeon)Harry 10.15.2014
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, true, ab_Version ) //(Appeon)Harry 10.15.2014
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel!, true)
		end if			
	case 8  //Excel5
		//li_Return = adw_Data.SaveAs(ls_File, Excel5!, false) //Commented by (Appeon)Harry 10.15.2014
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, false, ab_Version ) //(Appeon)Harry 10.15.2014
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel5!, false)
		end if		
	case 9  //Excel5 with headers
		//li_Return = adw_Data.SaveAs(ls_File, Excel5!, true)  //Commented by (Appeon)Harry 10.15.2014
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, true, ab_Version ) //(Appeon)Harry 10.15.2014
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel5!, true)
		end if		
	case 10 //Excel8 (97 / 2000 / XP / 2003)
		//li_Return = adw_Data.SaveAs(ls_File, Excel8!, false) //Commented by (Appeon)Harry 10.15.2014
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, false, ab_Version ) //(Appeon)Harry 10.15.2014
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel8!, false)
		end if	
	case 11 //Excel8 (97 / 2000 / XP / 2003) with headers
		//li_Return = adw_Data.SaveAs(ls_File, Excel8!, true) //Commented by (Appeon)Harry 10.15.2014
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, true, ab_Version ) //(Appeon)Harry 10.15.2014
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel8!, true)
		end if	
	case 12 //HTML Table
		li_Return = adw_Data.SaveAs(ls_File, HTMLTable!, true)
	case 13 //PDF
		lnv_pdf = Create appeon_pdfservice
		li_Return = lnv_pdf.of_Print(adw_Data, ls_File)
		Destroy lnv_pdf
	case 14 //Powersoft Report
		li_Return = adw_Data.SaveAs(ls_File, PSReport!, true)
	case 15 //SQL
		li_Return = adw_Data.SaveAs(ls_File, SQLInsert!, true)
	case 16 //SYLK
		li_Return = adw_Data.SaveAs(ls_File, SYLK!, false)
	case 17  //SYLK with headers
		li_Return = adw_Data.SaveAs(ls_File, SYLK!, true)
	case 18 //Text
		li_Return = adw_Data.SaveAs(ls_File, Text!, false)
	case 19 //Text with headers
		li_Return = adw_Data.SaveAs(ls_File, Text!, true)
	case 20 //WKS
		li_Return = adw_Data.SaveAs(ls_File, WKS!, false)
	case 21 //WKS with headers
		li_Return = adw_Data.SaveAs(ls_File, WKS!, true)
	case 22 //WK1
		li_Return = adw_Data.SaveAs(ls_File, WK1!, false)
	case 23 //WK1 with headers
		li_Return = adw_Data.SaveAs(ls_File, WK1!, true)
	case 24 //WMF
		li_Return = adw_Data.SaveAs(ls_File, WMF!, true)
	case 25 //XML
		li_Return = adw_Data.SaveAs(ls_File, XML!, true)
	case 26 //XSL-FO
		li_Return = adw_Data.SaveAs(ls_File, XSLFO!, true)
	case else
		Return -1
end choose

if isvalid(lnv_excel) then destroy lnv_excel //(Appeon)Harry 10.15.2014 - for Save as Excel8
Return li_Return
end function

public function integer of_getsaveastype (saveastype ae_saveastype, boolean ab_colheading);//////////////////////////////////////////////////////////////////////
// $<function> of_getsaveastype
// $<arguments>
//		saveastype	ae_saveastype
//		boolean		ab_colheading
// $<returns> integer
// $<description> Get save as type
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.11.2010
//////////////////////////////////////////////////////////////////////

long ll_FilterIndex

if ae_SaveasType = CSV! and ab_Colheading = false then //CSV
	ll_FilterIndex = 1
elseif ae_SaveasType = CSV! and ab_Colheading = true then //CSV with headers
	ll_FilterIndex = 2
elseif ae_SaveasType = dBASE2! then //Dbase 2
	ll_FilterIndex = 3
elseif ae_SaveasType = dBASE3! then //Dbase 3
	ll_FilterIndex = 4
elseif ae_SaveasType = DIF! then //DIF
	ll_FilterIndex = 5
elseif ae_SaveasType = Excel! and ab_Colheading = false then //Excel
	ll_FilterIndex = 6
elseif ae_SaveasType = Excel! and ab_Colheading = true then  //Excel with headers
	ll_FilterIndex = 7
elseif ae_SaveasType = Excel5! and ab_Colheading = false then //Excel5
	ll_FilterIndex = 8
elseif ae_SaveasType = Excel5! and ab_Colheading = true then  //Excel5 with headers
	ll_FilterIndex = 9
elseif ae_SaveasType = Excel8! and ab_Colheading = false then //Excel8 (97 / 2000 / XP / 2003)
	ll_FilterIndex = 10
elseif ae_SaveasType = Excel8! and ab_Colheading = true then  //Excel8 (97 / 2000 / XP / 2003) with headers
	ll_FilterIndex = 11
elseif ae_SaveasType = HTMLTable! then //HTML Table
	ll_FilterIndex = 12
elseif ae_SaveasType = PDF! then //PDF
	ll_FilterIndex = 13
elseif ae_SaveasType = PSReport! then //Powersoft Report
	ll_FilterIndex = 14
elseif ae_SaveasType = SQLInsert! then //SQL
	ll_FilterIndex = 15
elseif ae_SaveasType = SYLK! and ab_Colheading = false then //SYLK
	ll_FilterIndex = 16
elseif ae_SaveasType = SYLK! and ab_Colheading = true then  //SYLK with headers
	ll_FilterIndex = 17
elseif ae_SaveasType = Text! and ab_Colheading = false then //Text
	ll_FilterIndex = 18
elseif ae_SaveasType = Text! and ab_Colheading = true then  //Text with headers
	ll_FilterIndex = 19
elseif ae_SaveasType = WKS! and ab_Colheading = false then //WKS
	ll_FilterIndex = 20
elseif ae_SaveasType = WKS! and ab_Colheading = true then  //WKS with headers
	ll_FilterIndex = 21
elseif ae_SaveasType = WK1! and ab_Colheading = false then //WK1
	ll_FilterIndex = 22
elseif ae_SaveasType = WK1! and ab_Colheading = true then  //WK1 with headers
	ll_FilterIndex = 23
elseif ae_SaveasType = WMF! then //WMF
	ll_FilterIndex = 24
elseif ae_SaveasType = XML! then //XML
	ll_FilterIndex = 25
elseif ae_SaveasType = XSLFO! then //XSL-FO
	ll_FilterIndex = 26
end if

Return ll_FilterIndex
end function

public function integer of_saveas (datawindow adw_data, string as_filename, integer ai_saveastype);//////////////////////////////////////////////////////////////////////
// $<function> of_saveas
// $<arguments>
//		datawindow	adw_data
//		string		as_filename
//		integer	ai_saveastype
// $<returns> integer
// $<description> Save datawindow data as specified file type
//////////////////////////////////////////////////////////////////////
// $<add> Stephen 05.15.2014
//////////////////////////////////////////////////////////////////////

string ls_File
string ls_Filter
integer i, li_Return
long ll_FilterIndex
n_cst_appeondll lnv_dlg
appeon_pdfservice lnv_pdf
//---------Begin Added by (Appeon)Stephen 07.13.2016 for Auto Save Case#65210--------
n_cst_excel lnv_excel
boolean	ab_Version
//---------End Added ------------------------------------------------------

// Check arguments
if IsNull(adw_Data) or IsNull(as_FileName) or IsNull(ai_SaveasType) then
	SetNull(li_Return)
	Return li_Return
end if
if not IsValid(adw_Data) then Return -1

of_check_type(adw_data)  //Start Code Change ----11.30.2016 #V153 maha

ll_FilterIndex = ai_saveastype
// Get file save name
if as_FileName = "" then	
	ls_Filter  = "CSV,*.csv,"
	ls_Filter += "CSV with headers,*.csv,"
	ls_Filter += "Dbase 2,*.dbf,"
	ls_Filter += "Dbase 3,*.dbf,"
	ls_Filter += "DIF,*.dif,"
	ls_Filter += "Excel,*.xlsx,"
	ls_Filter += "Excel with headers,*.xlsx,"
	ls_Filter += "Excel5,*.xls,"
	ls_Filter += "Excel5 with headers,*.xls,"
	ls_Filter += "Excel8 (97 / 2000 / XP / 2003),*.xls,"
	ls_Filter += "Excel8 (97 / 2000 / XP / 2003) with headers,*.xls,"
	ls_Filter += "HTML Table,*.html,"
	ls_Filter += "PDF,*.pdf,"
	ls_Filter += "Powersoft Report,*.psr,"
	ls_Filter += "SQL,*.sql,"
	ls_Filter += "SYLK,*.sylk,"
	ls_Filter += "SYLK with headers,*.sylk,"
	ls_Filter += "Text,*.txt,"
	ls_Filter += "Text with headers,*.txt,"
	ls_Filter += "WKS,*.wks,"
	ls_Filter += "WKS with headers,*.wks,"
	ls_Filter += "WK1,*.wk1,"
	ls_Filter += "WK1 with headers,*.wk1,"
	ls_Filter += "Windows Metafile,*.wmf,"
	ls_Filter += "XML,*.xml,"
	ls_Filter += "XSL-FO,*.fo"
	li_Return = lnv_dlg.of_GetFileSaveName("Save As", ls_File, ll_FilterIndex, ls_Filter, "")
	if li_Return <> 1 then Return -1
else
	ls_File = as_FileName
end if
//---------Begin Added by (Appeon)Stephen 07.13.2016 for Auto Save Case#65210--------
if ll_FilterIndex >= 6 and ll_FilterIndex <= 11 then
	lnv_excel = create n_cst_excel
	if Integer( gf_GetExcelVersion( ) ) >=12 then
		ab_Version = true
	end if
end if
//---------End Added ------------------------------------------------------

// Save as file
choose case ll_FilterIndex
	case 1  //CSV
		ls_File = ls_File +".csv"
		li_Return = adw_Data.SaveAs(ls_File, CSV!, false)
	case 2  //CSV with headers
		ls_File = ls_File +".csv"
		li_Return = adw_Data.SaveAs(ls_File, CSV!, true)
	case 3  //Dbase 2
		ls_File = ls_File +".dBASE2"
		li_Return = adw_Data.SaveAs(ls_File, dBASE2!, true)
	case 4  //Dbase 3
		ls_File = ls_File +".dBASE3"
		li_Return = adw_Data.SaveAs(ls_File, dBASE3!, true)
	case 5  //DIF
		ls_File = ls_File +".DIF"
		li_Return = adw_Data.SaveAs(ls_File, DIF!, true)
	//---------Begin Modified by (Appeon)Stephen 07.13.2016 for Auto Save Case#65210--------
	/*
	case 6  //Excel
		ls_File = ls_File +".xls"
		li_Return = adw_Data.SaveAs(ls_File, Excel!, false)
	case 7  //Excel with headers
		ls_File = ls_File +".xls"
		li_Return = adw_Data.SaveAs(ls_File, Excel!, true)
	case 8  //Excel5
		ls_File = ls_File +".xls"
		li_Return = adw_Data.SaveAs(ls_File, Excel5!, false)
	case 9  //Excel5 with headers
		ls_File = ls_File +".xls"
		li_Return = adw_Data.SaveAs(ls_File, Excel5!, true)
	case 10 //Excel8 (97 / 2000 / XP / 2003)
		ls_File = ls_File +".xls"
		li_Return = adw_Data.SaveAs(ls_File, Excel8!, false)
	case 11 //Excel8 (97 / 2000 / XP / 2003) with headers
		ls_File = ls_File +".xls"
		li_Return = adw_Data.SaveAs(ls_File, Excel8!, true)
	*/
	//Start Code Change ----11.30.2016 #V153 maha - modified so other formats can still be exported
	case 6  //Excel
		ls_File = ls_File +".xls"
		if ib_excel then
			if ab_Version Then ls_File=ls_File + "x"///Modified by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
			lnv_excel.of_saveas_excel( adw_Data, ls_File, false, ab_Version ) 
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel!, false)
		end if
	case 7  //Excel with headers
		ls_File = ls_File +".xls"
		if ib_excel then
			if ab_Version Then ls_File=ls_File + "x"///Modified by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
			lnv_excel.of_saveas_excel( adw_Data, ls_File, true, ab_Version ) 
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel!, true)
		end if
	case 8  //Excel5
		ls_File = ls_File +".xls"
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, false, ab_Version ) 
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel5!, false)
		end if
		lnv_excel.of_saveas_excel( adw_Data, ls_File, false, ab_Version ) 
	case 9  //Excel5 with headers
		ls_File = ls_File +".xls"
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, true, ab_Version ) 
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel5!, true)
		end if
	case 10 //Excel8 (97 / 2000 / XP / 2003)
		ls_File = ls_File +".xls"
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, false, ab_Version ) 
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel8!, false)
		end if
	case 11 //Excel8 (97 / 2000 / XP / 2003) with headers
		ls_File = ls_File +".xls"
		if ib_excel then
			lnv_excel.of_saveas_excel( adw_Data, ls_File, true, ab_Version ) 
		else
			li_Return = adw_Data.SaveAs(ls_File, Excel8!, true)
		end if
	//End Code Change ----11.30.2016
	//---------End Modfiied ------------------------------------------------------
	case 12 //HTML Table
		ls_File = ls_File +".htm"
		li_Return = adw_Data.SaveAs(ls_File, HTMLTable!, true)
	case 13 //PDF
		ls_File = ls_File +".pdf"
		lnv_pdf = Create appeon_pdfservice
		li_Return = lnv_pdf.of_Print(adw_Data, ls_File)
		Destroy lnv_pdf
	case 14 //Powersoft Report
		ls_File = ls_File +".PSReport"
		li_Return = adw_Data.SaveAs(ls_File, PSReport!, true)
	case 15 //SQL
		ls_File = ls_File +".sql"
		li_Return = adw_Data.SaveAs(ls_File, SQLInsert!, true)
	case 16 //SYLK
		ls_File = ls_File +".SYLK"
		li_Return = adw_Data.SaveAs(ls_File, SYLK!, false)
	case 17  //SYLK with headers
		ls_File = ls_File +".SYLK"
		li_Return = adw_Data.SaveAs(ls_File, SYLK!, true)
	case 18 //Text
		ls_File = ls_File +".txt"
		li_Return = adw_Data.SaveAs(ls_File, Text!, false)
	case 19 //Text with headers
		ls_File = ls_File +".txt"
		li_Return = adw_Data.SaveAs(ls_File, Text!, true)
	case 20 //WKS
		ls_File = ls_File +".wks"
		li_Return = adw_Data.SaveAs(ls_File, WKS!, false)
	case 21 //WKS with headers
		ls_File = ls_File +".wks"
		li_Return = adw_Data.SaveAs(ls_File, WKS!, true)
	case 22 //WK1
		ls_File = ls_File +".wk1"
		li_Return = adw_Data.SaveAs(ls_File, WK1!, false)
	case 23 //WK1 with headers
		ls_File = ls_File +".wk1"
		li_Return = adw_Data.SaveAs(ls_File, WK1!, true)
	case 24 //WMF
		ls_File = ls_File +".wmf"
		li_Return = adw_Data.SaveAs(ls_File, WMF!, true)
	case 25 //XML
		ls_File = ls_File +".xml"
		li_Return = adw_Data.SaveAs(ls_File, XML!, true)
	case 26 //XSL-FO
		ls_File = ls_File +".XSLFO"
		li_Return = adw_Data.SaveAs(ls_File, XSLFO!, true)
	case else
		Return -1
end choose

if isvalid(lnv_excel) then destroy lnv_excel//(Appeon)Stephen 07.13.2016 -Auto Save Case#65210
Return li_Return
end function

public function integer of_check_type (datawindow adw_data);//Start Code Change ----11.30.2016 #V153 maha - added 
integer li_DwType

li_DwType = integer(adw_data.describe("Datawindow.Processing"))

if li_DwType > 1 then ib_excel = false

return 1
end function

on n_cst_datawindow.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_datawindow.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

