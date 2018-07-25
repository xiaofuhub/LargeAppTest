$PBExportHeader$w_import_oig.srw
forward
global type w_import_oig from window
end type
type cb_2 from commandbutton within w_import_oig
end type
type cb_5 from commandbutton within w_import_oig
end type
type st_5 from statictext within w_import_oig
end type
type st_4 from statictext within w_import_oig
end type
type st_3 from statictext within w_import_oig
end type
type st_2 from statictext within w_import_oig
end type
type st_1 from statictext within w_import_oig
end type
type st_progress from statictext within w_import_oig
end type
type cb_stst from commandbutton within w_import_oig
end type
type cb_13 from commandbutton within w_import_oig
end type
type dw_table from datawindow within w_import_oig
end type
type cb_10 from commandbutton within w_import_oig
end type
type cb_3 from commandbutton within w_import_oig
end type
type sle_1 from singlelineedit within w_import_oig
end type
type cb_1 from commandbutton within w_import_oig
end type
type dw_copy from datawindow within w_import_oig
end type
end forward

global type w_import_oig from window
integer x = 297
integer y = 304
integer width = 3099
integer height = 1904
boolean titlebar = true
string title = "OIG Data update"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_2 cb_2
cb_5 cb_5
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_progress st_progress
cb_stst cb_stst
cb_13 cb_13
dw_table dw_table
cb_10 cb_10
cb_3 cb_3
sle_1 sle_1
cb_1 cb_1
dw_copy dw_copy
end type
global w_import_oig w_import_oig

type variables
string is_dwname
end variables

forward prototypes
public function integer of_csv2txt (string as_csvfile, string as_txtfile)
public function integer of_convert_csv (string as_source_file, string as_target_file)
end prototypes

public function integer of_csv2txt (string as_csvfile, string as_txtfile);//for Web version issue - alfee 02.02.2016

Long ll_pos
Long xlText = -4158 // xlText
OleObject lole_excel

IF NOT FileExists(as_csvfile) THEN RETURN -1
IF Right (as_csvfile, 4) <> '.csv' THEN RETURN -1

IF FileExists (as_txtfile) THEN
	IF Not FileDelete (as_txtfile) THEN
		MessageBox("Delete","Please manually delete the file '" + as_txtfile + "' first!" )
		RETURN -1
	END IF			
END IF	

//Generate excel document
TRY 
	
lole_excel = Create oleobject
IF lole_excel.Connecttonewobject("excel.application") <> 0 THEN
		Destroy lole_excel 
		Messagebox('Client Error', 'Could not connect to Microsoft Excel. Please make sure it is properly installed.')
		RETURN -1
END IF

lole_excel.Visible = FALSE
lole_excel.Application.Workbooks.Open (as_csvfile)
lole_excel.ActiveWorkbook.ActiveSheet.Columns("I:I").Select () //DOB
lole_excel.Application.Selection.NumberFormatLocal = "m/d/yy;@"
//lole_excel.ActiveWorkbook.ActiveSheet.Columns("A:A").Select () //Last Name
//lole_excel.Application.Selection.Replace (",", "%%") //
//lole_excel.ActiveWorkbook.Save () 
lole_excel.ActiveWorkbook.SaveAs (as_txtfile, xlText) 

lole_excel.ActiveWorkbook.Close(False)		
lole_excel.Quit()
lole_excel.DisconnectObject( )	
IF isvalid(lole_excel) THEN Destroy lole_excel

CATCH (Throwable th1)
	lole_excel.ActiveWorkbook.Close(False)		
	lole_excel.Quit()
	lole_excel.DisconnectObject( )	
	IF isvalid(lole_excel) THEN Destroy lole_excel	
	RETURN -1
END TRY

RETURN 1



end function

public function integer of_convert_csv (string as_source_file, string as_target_file);//for Web version issue - alfee 03.03.2016

Long ll_pos
Long xlCSV = 6 // xlCSV
OleObject lole_excel

IF NOT FileExists(as_source_file) THEN RETURN -1
IF Right (as_source_file, 4) <> '.csv' THEN RETURN -1

IF FileExists (as_target_file) THEN
	IF Not FileDelete (as_target_file) THEN
		MessageBox("Delete","Please manually delete the file '" + as_target_file + "' first!" )
		RETURN -1
	END IF			
END IF	

//Open the excel application
TRY 
	
lole_excel = Create oleobject
IF lole_excel.Connecttonewobject("excel.application") <> 0 THEN
		Destroy lole_excel 
		Messagebox('Client Error', 'Could not connect to Microsoft Excel. Please make sure it is properly installed.')
		RETURN -1
END IF

//Convert the data and save as the file
lole_excel.Visible = FALSE
lole_excel.Application.Workbooks.Open (as_source_file)
//lole_excel.ActiveWorkbook.ActiveSheet.Columns("I:I").Select () //DOB //Comment by Appeon long.zhang 08.17.2016 (OIG Import error Case#65853)
//lole_excel.Application.Selection.NumberFormatLocal = "m/d/yy;@" //Comment by Appeon long.zhang 08.17.2016 (OIG Import error Case#65853)
lole_excel.ActiveWorkbook.ActiveSheet.Columns("A:A").Select () //Last Name
lole_excel.Application.Selection.Replace (",", "%%") 
lole_excel.ActiveWorkbook.SaveAs (as_target_file, xlCSV) 

//Close and quit excel application
lole_excel.ActiveWorkbook.Close(False)		
lole_excel.Quit()
lole_excel.DisconnectObject( )	
IF isvalid(lole_excel) THEN Destroy lole_excel

CATCH (Throwable th1)
	lole_excel.ActiveWorkbook.Close(False)		
	lole_excel.Quit()
	lole_excel.DisconnectObject( )	
	IF isvalid(lole_excel) THEN Destroy lole_excel	
	RETURN -1
END TRY

RETURN 1



end function

on w_import_oig.create
this.cb_2=create cb_2
this.cb_5=create cb_5
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_progress=create st_progress
this.cb_stst=create cb_stst
this.cb_13=create cb_13
this.dw_table=create dw_table
this.cb_10=create cb_10
this.cb_3=create cb_3
this.sle_1=create sle_1
this.cb_1=create cb_1
this.dw_copy=create dw_copy
this.Control[]={this.cb_2,&
this.cb_5,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_progress,&
this.cb_stst,&
this.cb_13,&
this.dw_table,&
this.cb_10,&
this.cb_3,&
this.sle_1,&
this.cb_1,&
this.dw_copy}
end on

on w_import_oig.destroy
destroy(this.cb_2)
destroy(this.cb_5)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_progress)
destroy(this.cb_stst)
destroy(this.cb_13)
destroy(this.dw_table)
destroy(this.cb_10)
destroy(this.cb_3)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.dw_copy)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	//MESSAGEBOX("","LOGIN OK")
//END IF
//
// is_dwname = "None"
end event

event close;//disCONNECT USING SQLCA;
end event

type cb_2 from commandbutton within w_import_oig
integer x = 73
integer y = 532
integer width = 1445
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Optional: Filter out records that you will never search on."
end type

event clicked;open(w_oig_category_delete)
end event

type cb_5 from commandbutton within w_import_oig
boolean visible = false
integer x = 1577
integer y = 52
integer width = 137
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "3) Extract the dbf file to that folder."
end type

event clicked;//Access the default Internet browser to navigate to the OIG home site 
// to download the monthly OIG LEIE update zip file
integer r
String sle_url

//run("explorer.exe /n,/e,C:\intellicred\oig\")

//------Begin Modified by Alfee 12.31.2009 ------------
//<$Reason>Fix the wrong path of updated.dbf
//run(gs_dir_path + "intellicred\oig\updatedleie.exe")
string ls_current_dir

ls_current_dir = GetCurrentDirectory( )
ChangeDirectory(gs_temp_path + "oig")

//---------Begin Modified by (Appeon)Stephen 04.30.2015 for V14.2 Bug # 4498 - OIG import step 3 is not working - Run the download.exe file to unzip the update--------
//r = run(gs_temp_path + "oig\updatedleie.exe")
if fileexists(gs_temp_path + "oig\updatedleie.exe") then
	r = run(gs_temp_path + "oig\updatedleie.exe")
elseif fileexists(gs_temp_path + "oig\updatedleie.zip") then
	ChangeDirectory(gs_dllocx_path) 
	r = run("7z e " + gs_temp_path + "oig\updatedleie.zip -o" +gs_temp_path + "oig\"  , Minimized!)	
else
	r = -1
end if	
//---------End Modfiied ------------------------------------------------------

if r = -1 then 
	messagebox("Unzip failed","Unable to run the unzip function.  May be a permission issue.  Please run manually.")
	run("explorer.exe /n,/e," + gs_temp_path + "oig\")
end if

ChangeDirectory(ls_current_dir)
//------End Modified -----------------------------------

end event

type st_5 from statictext within w_import_oig
integer x = 3214
integer y = 524
integer width = 1591
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "5) Click Import to delete existing records and import update"
boolean focusrectangle = false
end type

type st_4 from statictext within w_import_oig
integer x = 3145
integer y = 356
integer width = 1147
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "4) Browse to unzipped update.dbf file."
boolean focusrectangle = false
end type

type st_3 from statictext within w_import_oig
integer x = 3246
integer y = 452
integer width = 1385
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "3) Run the downloaded .exe file to unzip the update."
boolean focusrectangle = false
end type

type st_2 from statictext within w_import_oig
integer x = 69
integer y = 136
integer width = 1102
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "2) SAVE file in your Intellicred\OIG folder."
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_import_oig
integer x = 3401
integer y = 276
integer width = 1175
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "1) Click retrieve to get file from OIG website."
boolean focusrectangle = false
end type

type st_progress from statictext within w_import_oig
integer x = 55
integer y = 660
integer width = 2944
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Import Status"
boolean focusrectangle = false
end type

type cb_stst from commandbutton within w_import_oig
integer x = 55
integer y = 40
integer width = 1083
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "1) Click retrieve to get file from OIG website."
end type

event clicked;//Access the default Internet browser to navigate to the OIG home site 
// to download the monthly OIG LEIE update zip file

//Start Code Change ----06.25.2013 #V14 maha - rewrote code - changed link.
String sle_url
String ls_url,ls_null
inet iinet_base

ls_url = "http://www.intellisoftgroup.com/oignew.html"  //Start Code Change ----.08.022016 #V152 maha - readded link
//ls_url = "http:/go.usa.gov/cn5nj"
//ls_url = "http://oig.hhs.gov/exclusions/downloadables/updatedleie.csv"  //current file as of 01.25.2016
//ls_url = "http://oig.hhs.gov/exclusions/downloadables/updated.csv"  //current file as of 08.01.2016
//= http:/go.usa.gov/cn5nj CSV file
//  http:/go.usa.gov/cn5Rw dbf zip file - gone in 2-2016
//ls_url = "http://www.intellisoftgroup.com/oig.html"  //will redirect to the oig link 
//ls_url = "http://oig.hhs.gov/exclusions/downloadables/updatednpiwai.zip" 

if gi_citrix = 1 then //maha 040805
	//of_open_web("http://www.oig.hhs.gov/fraud/exclusions/downloadables/updatedleie.exe")
	of_open_web(ls_url)  //Start Code Change ----05.24.2011 #V11 maha
else
	setnull(ls_null)
	//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
	ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
end if

//---------Begin Modified by (Appeon)Stephen 02.19.2014 for modify  temporary file paths--------
//gnv_appeondll.of_parsepath( gs_dir_path + "intellicred\oig\" )
//run("explorer.exe /n,/e," + gs_dir_path + "intellicred\oig\")
gnv_appeondll.of_parsepath( gs_temp_path + "oig\" )
run("explorer.exe /n,/e," + gs_temp_path + "oig\")
//---------End Modfiied ------------------------------------------------------


//old code
////Access the default Internet browser to navigate to the OIG home site 
//// to download the monthly OIG LEIE update zip file
//
//String sle_url
//inet iinet_base
//
//if gi_citrix = 1 then //maha 040805
//	//of_open_web("http://www.oig.hhs.gov/fraud/exclusions/downloadables/updatedleie.exe")
//	//of_open_web("http://www.intellisoftgroup.com/oig.html")  //Start Code Change ----05.24.2011 #V11 maha
//	of_open_web("http://www.intellisoftgroup.com/oignew.html")	//long.zhang 03.04.2014  Bug # 3961
//else
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 06.23.2006 By: Liang QingShi
//	//$<reason>  GetContextService is currently unsupported. 
//	//$<modification> Replace GetContextService with ShellExecuteA to provide the
//	//$<modification> same functionality.
//	/*
//	GetContextService("Internet", iinet_base)
//	iinet_base.HyperlinkToURL("http://www.oig.hhs.gov/fraud/exclusions/downloadables/updatedleie.exe")	
//	*/
//	String ls_url,ls_null
//	setnull(ls_null)
//	 //Start Code Change ----05.24.2011 #V11 maha - correction for modified link
//	//ls_url = "http://www.oig.hhs.gov/fraud/exclusions/downloadables/updatedleie.exe"
//	//ls_url = "http://www.oig.hhs.gov/exclusions/downloadables/updatedleie.exe"
////	ls_url = "http://www.intellisoftgroup.com/oig.html" //will redirect to the link above
//	//End Code Change ----05.24.2011
//	ls_url = "http://www.intellisoftgroup.com/oignew.html"	//long.zhang 03.04.2014  Bug # 3961
//	ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
//
//	//---------------------------- APPEON END ----------------------------
//end if
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 07.20.2006 By: Rodger Wu
////$<reason> Fix a defect.
////$<reason> Create the path if it does not exist.
//
//gnv_appeondll.of_parsepath( gs_temp_path + "oig\" )
////---------------------------- APPEON END ----------------------------
//
//run("explorer.exe /n,/e," + gs_temp_path + "oig\")
////End of routine


end event

type cb_13 from commandbutton within w_import_oig
integer x = 64
integer y = 324
integer width = 1449
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "4) Click Import to delete existing records and import update"
end type

event clicked;string object
string file
string fileapp
string mes
string ls_string
String ls_dob
long ll_code
long ll_appid
long ll_facid
long ll_fldid
long ll_app_org
long i
integer a
long rc
long ac
long c


pointer oldpointer // Declares a pointer variable
oldpointer = SetPointer(HourGlass!)

//Step 1 before importing verify if the file actually exists

IF not FileExists(sle_1.text)  THEN 
	//messagebox("","Unable to find file! Please use the Retrieve button to select a valid file name!")
	messagebox("File Not Found","Unable to find file! Please use the Retrieve button to select a valid file name!")
	return
end if 

dw_copy.settransobject(sqlca)
dw_copy.reset()
dw_table.settransobject(sqlca)
dw_table.reset()

file = sle_1.text
//fileapp = sle_app.text

//Step 2 delete the old OIG records and display a message  
// erase all data from present oig_data table before proceeding with import

st_progress.text = " Deleting all the old OIG records,(may take a few minutes)  Please wait."
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 04.14.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_autocommit( )
//---------------------------- APPEON END ----------------------------

		DELETE FROM OIG_DATA;
		commit using sqlca;

//Step 3 start importing the new OIG records and display a message
//dwcontrol.ImportFile ( filename {, startrow {, endrow {, startcolumn {, endcolumn {, dwstartcolumn } } } } } )

st_progress.text = " Importing the new OIG records,  Please wait!"

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 11.13.2011
//$<reason> The readdbf.dll cannot convert data
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 04.14.2006 By: Cao YongWang
//$<reason> Import data from a DBF file is unsupportted by Appeon. 
//$<modification> Call Appeon DLL function to export the DBF file data to
//$<modification>  a TXT file. Then, import data from the TXT file on web application.
If appeongetclienttype() <> 'PB' Then
	string ls_datafile
	long	 ll_rtn
	//If the 'gs_dir_path + "intellicred\oig\"' directory is not exsits, Then create it.
	gnv_appeondll.of_parsepath(gs_temp_path + "oig\")
	ls_datafile = gs_temp_path + "oig\update.txt"
	ll_rtn = gnv_appeondll.of_output(file , ls_datafile , 'updated')
	If ll_rtn <> 1 Then 
		return
	End If
	file = ls_datafile
End If
//---------------------------- APPEON END ----------------------------
*/
//if AppeonGetClientType() <> "PB" then
if AppeonGetClientType() <> "PB" and lower(right(file,3)) = "dbf" then  //(Appeon)Harry 01.27.2016 - Bug # 4947 - Getting a Microsoft Access DB engine error when importing the new OIG database .csv file
	string ls_datafile
	long	 ll_rtn
	gnv_appeondll.of_parsepath(gs_temp_path + "oig\")
	ls_datafile = gs_temp_path + "oig\update.txt"
	ll_rtn = gnv_appeondll.of_ConvertDbf2Txt(file, ls_datafile)
	if ll_rtn > 0 then
		file = ls_datafile
	else
		Return
	end if
end if
//------------------- APPEON END ---------------------

//---------Begin Added by alfee 02.02.2016 ----------------------------
if AppeonGetClientType() <> "PB" and lower(right(file,4)) = ".csv" then
	gnv_appeondll.of_parsepath(gs_temp_path + "oig\")
	//------Begin Modified by alfee 03.03.2016 for Bug 5015----------
	//ls_datafile = gs_temp_path + "oig\update.txt"
	//ll_rtn = of_csv2txt(file, ls_datafile)
	ls_datafile = gs_temp_path + "oig\updatedleie_tmp.csv"
	ll_rtn = of_convert_csv(file, ls_datafile)	
	//------End Modified ---------------------------------------------------
	if ll_rtn > 0 then
		file = ls_datafile
	else
		Return
	end if
end if
//----------End Added -------------------------------------------------------

rc = dw_table.ImportFile(file,2)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12/12/2007 By: Ken.Guo
//$<reason> For Performance
/*
for i = 1 to rc
		ll_fldid++
		dw_table.setitem(i,"rec_id",ll_fldid)
next
//Step 4 start updating the database with the new OIG records and display a message
st_progress.text = (" Updating database with new OIG records,(may take a few minutes)  Please wait! ")
c = 0
for i = 1 to rc
	dw_table.rowscopy(i,i,primary!,dw_copy,1000000,primary!)
	c++
	ac++
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 07.20.2006 By: Rodger Wu
	//$<reason> Fix a defect.
	/*
	if c = 500 then
	*/
	if c = 500 or i = rc then
	//---------------------------- APPEON END ----------------------------
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-02
		//$<add> 04.14.2006 By: Cao YongWang
		//$<reason> Performance tuning.
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_autocommit( )
		//---------------------------- APPEON END ----------------------------
		dw_copy.update()
		commit using sqlca;
		c = 0
		dw_copy.reset()
		st_progress.text = " Updating database with new OIG records,(may take a few minutes)  Please wait! " + string (ac)
	end if
next
*/
Long ll_fldid_arr[]

If rc <=0 Then Return

For i = 1 To rc
		ll_fldid_arr[i] = i
Next
dw_table.object.rec_id[1,rc] = ll_fldid_arr[]

//-------------Begin Added by alfee 03.03.2016 for Bug 5015 ----------------------
//Restored the conversion in the first column (lastname)
IF AppeonGetClientType() <> "PB" AND lower(right(file,4)) = ".csv" THEN
    Long ll_start_pos
	String ll_old_str, ll_new_str, ls_lastname	
	ll_old_str = "%%"
	ll_new_str = ","

	dw_table.SetRedraw(FALSE)
	FOR i = 1 TO rc		
		ll_start_pos=1		
		ls_lastname = dw_table.object.lastname[i]	
		IF IsNull(ls_lastname) THEN CONTINUE				
		ll_start_pos = Pos(ls_lastname, ll_old_str, ll_start_pos)
		IF IsNull(ll_start_pos) OR ll_start_pos < 1 THEN CONTINUE

		DO WHILE ll_start_pos > 0
			 ls_lastname = Replace(ls_lastname, ll_start_pos, Len(ll_old_str), ll_new_str)	
			 ll_start_pos = Pos(ls_lastname, ll_old_str,  ll_start_pos+Len(ll_new_str))	
		LOOP
		dw_table.object.lastname[i]	 = ls_lastname		
	NEXT		
	dw_table.SetRedraw(TRUE)
END IF
//------------End Added -------------------------------------------------------------------

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 08.17.2016
//<$>reason:Convert DOB format (YYYYMMDD -> MM/DD/YY) For OIG Import error Case#65853
IF lower(right(file,4)) = ".csv" THEN
	dw_table.SetRedraw(FALSE)
	FOR i = 1 TO rc			
		ls_dob = dw_table.object.dob[i]
		//YYYYMMDD -> MM/DD/YY
		If IsNull(ls_dob) Then
			Continue
		ElseIf LenA(Trim(ls_dob)) > 0  Then
			ls_dob = String(Date(MidA(ls_dob,1,4) + '-' + MidA(ls_dob,5,2)  + '-' + MidA(ls_dob,7,2) ), 'MM/DD/YY')
			dw_table.object.dob[i] = ls_dob
		End If
	NEXT		
	dw_table.SetRedraw(TRUE)
End If
//------------------- APPEON END -------------------

//Step 4 start updating the database with the new OIG records and display a message
st_progress.text = " Updating database with new OIG records,(may take a few minutes)  Please wait! "
Long ll_times
Long ll_base = 500
ll_times = Ceiling(rc/ll_base)
for i = 1 to ll_times
	Yield() //alfee 02.03.2016
	dw_table.rowscopy((i - 1)*ll_base+1,i*ll_base,primary!,dw_copy,1,primary!)
	gnv_appeondb.of_autocommit()
	dw_copy.update()
	commit using sqlca;
	dw_copy.reset()
	If i*ll_base > rc Then 
		ac = rc
	Else
		ac = i*ll_base
	End If
	st_progress.text = " Updating database with new OIG records,(may take a few minutes)  Please wait! 	" + String (ac)+'/'+String(rc)
next
//---------------------------- APPEON END ----------------------------	
	
	
	
//if dw_table.update() < 1 then
//	st_progress.text = "Save failure.  Unable to update OIG records."
//	
//else
//	commit using sqlca;	
	//Step 5 display the number of records imported
	ls_string = string(rc)	
	st_progress.text = "Import complete. Total number of new OIG records imported = " + ls_string 
	
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.20.2006 By: Rodger Wu
//$<reason> fix a defect.
/* update ids set last_oig_update = today(); */

if gs_dbtype = "ASA" then
	update ids set last_oig_update = getdate();
else
	update ids set last_oig_update = getdate();
end if

//---------------------------- APPEON END ----------------------------
//end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<add> 04.14.2006 By: Cao YongWang
//$<reason> Delete the file after inporting data.
//$<modification> Add FileDelete(file) to delete the file.
//FileDelete(file)
FileDelete(ls_datafile)  //Modified by Ken.Guo 12/13/2007. Need delete temp file, Not Original data file.
//---------------------------- APPEON END ----------------------------


SetPointer(oldpointer)
end event

type dw_table from datawindow within w_import_oig
integer x = 37
integer y = 748
integer width = 2999
integer height = 1012
integer taborder = 40
string dataobject = "d_data_view_oig"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_10 from commandbutton within w_import_oig
integer x = 64
integer y = 224
integer width = 736
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "3) Browse to UPDATED.csv file."
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "addr_new"

string dbfname, named

integer value

//Start Code Change ----01.12.2016 #V15 maha - modifed for new file format
value = GetFileOpenName("Select File", dbfname, named, "CVS", 	+ "csv Files (*.CSV),*.csv",gs_temp_path + "oig")  //Start Code Change ----05.03.2011 #V11 maha - modified to point to appropriate path
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value = 1 THEN
	sle_1.text = dbfname
END IF
end event

type cb_3 from commandbutton within w_import_oig
integer x = 2638
integer y = 16
integer width = 402
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CLOSE(PARENT)
end event

type sle_1 from singlelineedit within w_import_oig
integer x = 805
integer y = 224
integer width = 1902
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_import_oig
integer x = 2638
integer y = 120
integer width = 402
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&About"
end type

event clicked;string s

s = "In February 2016 the OIG changed the available file format for the LEIE data.~rThe program has been modified to import the new format.  Unzipping the downloaded file is no longer necessary."
s += "~r~r"
s += "Use the Browse to Updated.cvs file button to browse to and select the OIG file to import.~r"
s += "Clicking on Import will erase the existing OIG records before importing and updating the new records to the database."


messagebox("About Importing", s)
end event

type dw_copy from datawindow within w_import_oig
integer x = 311
integer y = 332
integer width = 311
integer height = 60
integer taborder = 30
string dataobject = "d_data_view_oig"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

