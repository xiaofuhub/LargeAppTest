$PBExportHeader$u_tabpg_cpt_import.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_cpt_import from u_tabpg_contract_master
end type
type st_3 from statictext within u_tabpg_cpt_import
end type
type rb_2 from u_rb within u_tabpg_cpt_import
end type
type rb_1 from u_rb within u_tabpg_cpt_import
end type
type dw_2 from u_dw_contract within u_tabpg_cpt_import
end type
type dw_exist from datawindow within u_tabpg_cpt_import
end type
type cb_scrub from commandbutton within u_tabpg_cpt_import
end type
type st_click from statictext within u_tabpg_cpt_import
end type
type rb_ama from radiobutton within u_tabpg_cpt_import
end type
type rb_tab from radiobutton within u_tabpg_cpt_import
end type
type gb_1 from u_gb within u_tabpg_cpt_import
end type
type gb_2 from u_gb within u_tabpg_cpt_import
end type
type gb_3 from groupbox within u_tabpg_cpt_import
end type
type st_2 from statictext within u_tabpg_cpt_import
end type
type cb_close from u_cb within u_tabpg_cpt_import
end type
type cb_2 from u_cb within u_tabpg_cpt_import
end type
type cb_1 from u_cb within u_tabpg_cpt_import
end type
end forward

global type u_tabpg_cpt_import from u_tabpg_contract_master
integer width = 4101
integer height = 1980
string text = "Import Manager"
string picturename = "Import!"
string powertiptext = "Import Manager"
st_3 st_3
rb_2 rb_2
rb_1 rb_1
dw_2 dw_2
dw_exist dw_exist
cb_scrub cb_scrub
st_click st_click
rb_ama rb_ama
rb_tab rb_tab
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
st_2 st_2
cb_close cb_close
cb_2 cb_2
cb_1 cb_1
end type
global u_tabpg_cpt_import u_tabpg_cpt_import

type variables
string is_doc_path
nvo_commdlg invo_commdlg

boolean ib_add_new_codes_only
boolean ib_update_existing = true
end variables

forward prototypes
public function integer of_browse ()
public function integer of_database ()
public function integer of_open ()
public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[])
public function long of_get_maxcptcode ()
public function integer of_database_tab ()
public function integer of_open_tab ()
end prototypes

public function integer of_browse ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_path
string docname, named, path
integer value
string ls_Null
SetNull(ls_Null)


integer li_Files
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 03.22.2006 By: LiuHongXin
//$<reason> The invo_commdlg function is currently unsupported. 
//$<modification> Replace invo_commdlg with GetFileOpenName to provide the
//$<modification> same functionality.
/*
invo_commdlg.hWndParent	  = Handle(this)
invo_commdlg.Title			= "Open text file for import"
invo_commdlg.Filter        = "Text Files (*.txt)~t*.TXT"
invo_commdlg.FilterIndex	= 2

invo_commdlg.Flags			= invo_commdlg.OFN_FILEMUSTEXIST + invo_commdlg.OFN_LONGNAMES + invo_commdlg.OFN_EXPLORER // + invo_commdlg.ofn_allowmultiselect

If invo_commdlg.OpenDialog() Then
    is_doc_path = invo_commdlg.PathName + "\" + invo_commdlg.Files[1]
else 
	is_doc_path = ''
End If
*/
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
if GetFileOpenName("Open text file for import", ls_path, named, "txt", "Text Files (*.TXT),*.TXT") = 1 then
	is_doc_path = ls_path
else
	is_doc_path = ''
end if
//---------------------------- APPEON END ----------------------------
gf_save_dir_path(ls_path) //Added by Ken.Guo on 2009-03-10
//ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

return 0
end function

public function integer of_database ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  03 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



long integers

long ll_start, ll_used
string ls_null_array[]

ll_start = Cpu()

long  ll_pos
string ls_Null
SetNull(ls_Null)
blob lbl_temp

string is_docname,is_named
long   ll_FileNum
long   ll_return 
blob   empty_blob
blob lbl_data
blob   b_text_blob
string ls_file_dump
string is_file_names[]
long ll_i
string ls_mid_string_1
string ls_mid_string_2

long ll_imported_count
long ll_updated_count


CONSTANT STRING NEW_LINE = '~r~n'	
//string ls_file_path
n_cst_string       lnv_string

integer li_FileNum

////////////////////////////////////////////////////////////////////////////////////
// update the database 
////////////////////////////////////////////////////////////////////////////////////
string ls_sql_statments[]

long ll_rowcount 
ll_rowcount =  dw_2.rowcount()

dw_2.accepttext( )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1)Copy the SQLs from PT-03. It is integrated into Appeon Queue labels
//$<modification> with other SQLs to reduce client-server interactions.
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database.
String ls_mid_string_1_arr[]
Long ll_row

for ll_i = 1 to ll_rowcount
	ls_mid_string_1_arr[ll_i] = dw_2.getItemString(ll_i,'cpt_code')
end for

If ll_rowcount > 0 Then
	Datastore lds_ctx_cpt_codes
	lds_ctx_cpt_codes = Create Datastore
	lds_ctx_cpt_codes.dataobject = "d_ctx_cpt_codes_pt"
	lds_ctx_cpt_codes.Settransobject( SQLCA )
	lds_ctx_cpt_codes.Retrieve(ls_mid_string_1_arr[])
End If

Long ll_lookup_id
//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
//ll_lookup_id = gnv_app.of_get_id("LOOKUP", ll_rowcount) - 1
ll_lookup_id = of_get_maxcptcode()//long.zhang 05.03.2013
//---------End Modfiied ------------------------------------------------------

//---------------------------- APPEON END ----------------------------

for ll_i =1 to ll_rowcount
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-02
	//$<add> 03.28.2006 By: LeiWei
	//$<modification> Comment out the following script to reduce client-server interaction.
	//$<modification> refer to PT-01 and of_get_id for more information.
	ll_lookup_id ++
	//---------------------------- APPEON END ----------------------------

	 ls_mid_string_1 = dw_2.getItemString(ll_i,'cpt_code')
	 ls_mid_string_2 = dw_2.getItemString(ll_i,'cpt_code_desc')
	 
    string ls_search 
   	ls_search = ls_mid_string_2 
		ll_pos = pos(ls_search, "'",1) 
		if ll_pos > 0 then 
				  ls_mid_string_2 = mid(ls_search, 1, ll_pos -1 ) + "''" + mid(ls_search, ll_pos, len(ls_search)) 
		end if
	 // replace ' with ''
	 
	 
	 //lnv_string.of_globalreplace( ls_mid_string_2, "'", "''")
	 //lnv_string.of_globalreplace( ls_mid_string_2, "ADD'L", "ADD'L", true)
	 //lnv_string.of_globalreplace( ls_mid_string_2, "'S", "", true)
	 
	 long ll_cpt_count
    st_2.text = 'Creating SQL Statements ' + string(ll_i) + ' of '+ string(ll_rowcount)
    
	 ll_cpt_count =  0
	 
 	 //--------------------------- APPEON BEGIN ---------------------------
	 //$<ID> PT-03
	 //$<add> 03.16.2006 By: LeiWei
	 //$<reason> Performance tuning
	 //$<modification> Write script to retrieve data from a cache instead of from the database.
	 /*
    Select cpt_code_id into :ll_cpt_count from ctx_cpt_codes where cpt_code = :ls_mid_string_1;
	 */
	 Setnull(ll_cpt_count)
	 ll_row = lds_ctx_cpt_codes.Find("upper(cpt_code) = '" + Upper(ls_mid_string_1) + "'", 1, lds_ctx_cpt_codes.Rowcount() )
	 If ll_row > 0 Then ll_cpt_count = lds_ctx_cpt_codes.Getitemnumber(ll_row,"cpt_code_id")
	 //---------------------------- APPEON END ----------------------------
    	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-10-30 By: Rodger Wu
	//$<reason> Define a variable for updating Price.

	Dec{2} ld_price
	ld_price = dw_2.GetItemNumber( ll_i, "cpt_code_base_price" )
	if isnull( ld_price ) then ld_price = 0
	
	//---------------------------- APPEON END ----------------------------

	
	 if ib_add_new_codes_only and ll_cpt_count < 1 or isnull(ll_cpt_count) then 
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.28.2006 By: LeiWei
		//$<reason> Fix a defect.
		//ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "INSERT INTO CTX_CPT_CODES (cpt_code_id,cpt_code,cpt_code_description) VALUES (" + string(gnv_app.of_get_id("LOOKUP")) +",'" + trim(ls_mid_string_1) + "','" + trim(ls_mid_string_2)+ "'" + ")"
		
		if ld_price <> 0 then //Price needs to be updated also. 2006-10-30 By: Rodger Wu
			ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "INSERT INTO CTX_CPT_CODES (cpt_code_id,cpt_code,cpt_code_description, base_price ) VALUES (" + string(ll_lookup_id) +",'" + trim(ls_mid_string_1) + "','" + trim(ls_mid_string_2)+ "', " + string( ld_price ) + " )"
		else
			ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "INSERT INTO CTX_CPT_CODES (cpt_code_id,cpt_code,cpt_code_description) VALUES (" + string(ll_lookup_id) +",'" + trim(ls_mid_string_1) + "','" + trim(ls_mid_string_2)+ "'" + ")"
		end if
		
		//---------------------------- APPEON END ----------------------------
		ll_imported_count = ll_imported_count + 1
		continue
	 end if 
	 
	 if ib_update_existing then // and add new 
		if ll_cpt_count < 1 or isnull(ll_cpt_count) then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.28.2006 By: LeiWei
			//$<reason> Fix a defect.
			//ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "INSERT INTO CTX_CPT_CODES (cpt_code_id,cpt_code,cpt_code_description) VALUES (" + string(gnv_app.of_get_id("LOOKUP")) +",'" + trim(ls_mid_string_1) + "','" + trim(ls_mid_string_2)+ "'" + ")"

			if ld_price <> 0 then//Price needs to be updated also. 2006-10-30 By: Rodger Wu
				ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "INSERT INTO CTX_CPT_CODES (cpt_code_id,cpt_code,cpt_code_description, base_price) VALUES (" + string(ll_lookup_id) +",'" + trim(ls_mid_string_1) + "','" + trim(ls_mid_string_2)+ "', " + string( ld_price ) + " )"
			else
				ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "INSERT INTO CTX_CPT_CODES (cpt_code_id,cpt_code,cpt_code_description) VALUES (" + string(ll_lookup_id) +",'" + trim(ls_mid_string_1) + "','" + trim(ls_mid_string_2)+ "'" + ")"
			end if
			
			//---------------------------- APPEON END ----------------------------
			ll_imported_count = ll_imported_count + 1
		else 
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2006-10-30 By: Rodger Wu
			//$<reason> Price needs to be updated also.
			
			/* ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "update CTX_CPT_CODES set cpt_code = " + "'" + ls_mid_string_1 +"'" + ","	+ 'cpt_code_description = ' + "'"+ ls_mid_string_2 + "'" + "where cpt_code_id = " + string(ll_cpt_count) */
			
			if ld_price <> 0 then//2006-10-30 By: Rodger Wu
				ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "update CTX_CPT_CODES set cpt_code = " + "'" + ls_mid_string_1 +"'" + ","	+ 'cpt_code_description = ' + "'"+ ls_mid_string_2 + "', base_price = " + string( ld_price ) + " where cpt_code_id = " + string(ll_cpt_count) 
			else
		     	ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "update CTX_CPT_CODES set cpt_code = " + "'" + ls_mid_string_1 +"'" + ","	+ 'cpt_code_description = ' + "'"+ ls_mid_string_2 + "'" + "where cpt_code_id = " + string(ll_cpt_count) 
			end if
			//---------------------------- APPEON END ----------------------------
			
		  	ll_updated_count = ll_updated_count + 1
	   end if
	end if 
next 

IF UPPERBOUND(ls_sql_statments) > 0 THEN 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 03.30.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	/*
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "commit;"	 
	*/
	//---------------------------- APPEON END ----------------------------

		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-04
		//$<add> 03.16.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_startqueue( )
		//---------------------------- APPEON END ----------------------------

		FOR ll_i = 1 TO upperbound(ls_sql_statments)
			st_2.text = 'Modification/Update:' +string(ll_i) +' of '+ string(upperbound(ls_sql_statments)) +' Please stand by!'
				 EXECUTE IMMEDIATE :ls_sql_statments[LL_I] using sqlca;
				 IF len(sqlca.sqlerrtext) > 0 THEN
					messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(ls_sql_statments[LL_I]) + new_line + "Please contact software vendor."   )
					else
				 		
				END IF
		NEXT
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-05
		//$<add> 03.16.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_commitqueue( )
		//---------------------------- APPEON END ----------------------------

END IF

st_2.text = 'Modification Complete. ' + string(ll_updated_count)  + ' CPT codes updated,' + string(ll_imported_count) + ' CPT codes imported '



//
//li_FileNum = FileOpen("C:\cpt.sql",StreamMode!, Write!, LockWrite!, REPLACE!)
////this.text = 'writing file ' 	
//FileWrite ( li_FileNum, "string  ls_sql_statments []" + NEW_LINE)
//FileWrite ( li_FileNum, "long  ll_i" + NEW_LINE)
//
//string ls[]
//for LL_i = 1 to dw_2.rowcount()
//	ls[upperbound(ls) + 1] =  "'" +trim(dw_2.getitemstring(ll_i,'cpt_code')) + "','" + trim(dw_2.getitemstring(ll_i,'cpt_code_desc'))+ "'" 
//next 
//
//for ll_i = 1 to upperbound(ls)
//	 ///this.text = 'writing file ' + string(ll_i) +' of ' + string(upperbound(is_file_names))	
//	 FileWrite ( li_FileNum, 'ls_sql_statments[upperbound(ls_sql_statments) + 1] = "' + ls[ll_i]  + ' " '+ NEW_LINE)
//next
//
//
//
//FileClose ( li_FileNum )

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_ctx_cpt_codes) then Destroy lds_ctx_cpt_codes
//---------------------------- APPEON END ----------------------------

return 0

end function

public function integer of_open ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

Blob lbl_data
Blob lbl_temp
Blob   empty_blob
Blob   b_text_blob
Long ll_pos
Long ll_i
Long ll_FileNum
Long ll_j
Long ll_ret
Long ll_max_loops
String ls_null_array[]
String is_file_names[]
String ls_file_dump
String ls_write_string
String ls_no_code
String is_named
Long ll_first_char
Long ll_row
Constant String NEW_LINE = '~r~n'
String ls_mid_string_1
String ls_mid_string_2
//
SetPointer(HourGlass!)

of_browse( )

If Not f_validstr(is_doc_path) Then Return 0

DW_2.Reset()
DW_2.Object.b_1.Enabled = False
DW_2.Object.b_4.Enabled = False
DW_2.Object.b_filter.Enabled = False
DW_2.Object.b_sort.Enabled = False
////////////////////////////////////////////////////////////////////////////////////////////
// loop trought the file concatinate all of test for a given cpt code
////////////////////////////////////////////////////////////////////////////////////////////

n_cst_string       lnv_string



If Pos ( is_doc_path, 'LONGULF') > 0 Then
	
	ll_max_loops = 13
	ll_first_char = 8
	If MessageBox('Information', 'The file you selected is will take a LONG time. Do you want to continue?',information!,yesNo!) = 2 Then
		Return 0
	End If
Else
	ll_max_loops = 1
	ll_first_char = 7
End If

//Add By Jervis 12.19.2008
//OpenWithParm(w_appeon_gifofwait,"Import CTP code, This may take a few minutes. Please wait...")

For ll_j = 1 To ll_max_loops
	If ll_j = 1 Then
		ll_FileNum = FileOpen(is_doc_path,StreamMode! )
	Else
		ll_FileNum = FileOpen("C:\cpt.txt",StreamMode! )
	End If
	
	Do While FileRead ( ll_FileNum , lbl_temp) > 0
		lbl_data += lbl_temp
	Loop
	
	//Added By Mark Lee 10/23/12
//	ls_file_dump = String(lbl_data)
	ls_file_dump = String(lbl_data,EncodingANSI!)
			
	////////////////////////////////////
	// striip out the header stuff in the amd file
	//////////////////////////////////
	If ll_j =  1 Then
		ll_pos = Pos( ls_file_dump, '00100')
		
		If ll_pos > 0 Then
			ls_file_dump = Mid ( ls_file_dump, ll_pos )
		End If
	End If
	
	FileClose(ll_FileNum)
	// parse the file
	is_file_names = ls_null_array
	
	//lnv_string.of_parsetoarray(ls_file_dump, NEW_LINE, is_file_names)
	//Added by Alan on 2008-12-18
	of_parsetoarray(ls_file_dump, NEW_LINE, is_file_names)
	//
	ll_FileNum = FileOpen("C:\cpt.txt",StreamMode!, Write!, LockWrite!, Replace!)
	For ll_i = 1 To UpperBound(is_file_names)
		//if ll_i = 1 then 
		is_file_names[ll_i] = lnv_string.OF_REmovenonprint(is_file_names[ll_i])
		// REMOVE COMMA
		is_file_names[ll_i] = lnv_string.of_globalreplace(is_file_names[ll_i],","," ")
		// REMOVE APOSTOPHY
		
		is_file_names[ll_i] = lnv_string.of_globalreplace(is_file_names[ll_i],"'","")
		//					long li_pos
		//					li_pos = pos(is_file_names[ll_i],"~'") 
		//					do until li_pos = 0 
		//						is_file_names[ll_i] = left(is_file_names[ll_i],li_pos - 1) + "~'" + mid(is_file_names[ll_i],li_pos) 
		//						// is_file_names[ll_i] = left(is_file_names[ll_i],li_pos - 1) + "~~~'" + mid(is_file_names[ll_i],li_pos) 
		//						 li_pos = pos(is_file_names[ll_i],"~'",li_pos + 2) 
		//					loop
		
		
		
		
		//end if
		
		If ll_i > 1 Then
			
			// compare the left 6 chars in code to the provious ones
			If Left( is_file_names[ll_i], 5) = Left( is_file_names[ll_i -1 ], 5) Then
				//strip out the code 
				ls_no_code = Replace ( is_file_names[ll_i], 1, 8, '')
				is_file_names[ll_i -1 ] = Trim(is_file_names[ll_i -1 ]) + Trim(ls_no_code)
				//messagebox('','found')
				is_file_names[ll_i] = ''
			End If
		End If
		//Added by Alan on 2008-12-18
		Yield()
		SetPointer(HourGlass!)
	Next
	
	
	For ll_i = 1 To UpperBound(is_file_names)
		If f_validstr(is_file_names[ll_i]) Then
			ls_write_string = is_file_names[ll_i] + NEW_LINE //'ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO CTX_CPT_CODES (cpt_code_id,cpt_code,cpt_code_description,cpt_code_internal) VALUES (string(gnv_app.of_get_id("LOOKUP")) ' + ',' + 'cpt_code_table' + "'" + ls_mid_string_1 +"'" + ','  + "'" +ls_mid_string_2 + "'" +  ',Y' + ')"' + new_LINE
			ll_ret = FileWrite ( ll_FileNum, ls_write_string)
		End If
		//Added by Alan on 2008-12-18
		Yield()
		SetPointer(HourGlass!)
	Next
	
	ll_ret = FileClose(ll_FileNum)
	lbl_data = empty_blob
	lbl_temp = empty_blob
	
	st_2.Text = 'Interation' + String(ll_j) + ' of ' + String(ll_max_loops) + ' completed.'
Next

//Add By Jervis 12.19.2008
if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

///////////////////////////////////////////////////////////////////////////////////////
// inset into the display
///////////////////////////////////////////////////////////////////////////////////////

For ll_i = 1 To UpperBound(is_file_names)
	If f_validstr(is_file_names[ll_i]) Then
		ll_row = DW_2.InsertRow( 0)
		//				   dw_2.SelectRow(0, FALSE)
		//              dw_2.SelectRow(ll_i, TRUE)
		//				 dw_2.scrolltorow(ll_i)
		
		st_2.Text = 'Creating CPT code list ' + String(ll_i) +' of ' + String(UpperBound(is_file_names))
		DW_2.SetItem(ll_row,'cpt_code',Mid(is_file_names[ll_i] , 1 , 5 ))
		DW_2.SetItem(ll_row,'cpt_code_desc',Mid(is_file_names[ll_i] , ll_first_char , Len(Trim(is_file_names[ll_i]))) )
	End If
	//Added by Alan on 2008-12-18
	Yield()
	//SetPointer(HourGlass!)
Next

If UpperBound(is_file_names) > 0 Then
	DW_2.Object.b_1.Enabled = True
	DW_2.Object.b_4.Enabled = True
	DW_2.Object.b_filter.Enabled = True
	DW_2.Object.b_sort.Enabled = True
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-10-30 By: Rodger Wu
//$<reason> Make the message more exact.

/* st_2.text = string(upperbound(is_file_names)) + ' CPT codes imported.' */
st_2.Text = String(UpperBound(is_file_names)) + ' CPT codes to be imported.'

//---------------------------- APPEON END ----------------------------


SetPointer ( ARROW! )

Return 0



end function

public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ParseToArray
//
//	Access:  public
//
//	Arguments:
//	as_Source   The string to parse.
//	as_Delimiter   The delimeter string.
//	as_Array[]   The array to be filled with the parsed strings, passed by reference.
//
//	Returns:  long
//	The number of elements in the array.
//	If as_Source or as_Delimeter is NULL, function returns NULL.
//
//	Description:  Parse a string into array elements using a delimeter string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Fixed problem when delimiter is last character of string.

//	   Ref array and return code gave incorrect results.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
string 	ls_holder

//
SetPointer(HourGlass!)

//Check for NULL
IF IsNull(as_source) or IsNull(as_delimiter) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for at leat one entry
If Trim (as_source) = '' Then
	Return 0
End If

//Get the length of the delimeter
ll_DelLen = Len(as_Delimiter)

ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter))

//Only one entry was found
if ll_Pos = 0 then
	as_Array[1] = as_source
	return 1
end if

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
Do While ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = Mid (as_source, ll_start, ll_length)

	// Update array and counter
	ll_Count ++
	as_Array[ll_Count] = ls_holder
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen

	ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter), ll_Start)
	
	//Add By Jervis 02.04.2009
	st_2.Text = 'Opening CPT Code ' + String(ll_count) + ', Please wait...'
	
	//Added by Alan on 2008-12-18
	yield()
	SetPointer(HourGlass!)
Loop

//Set last entry
ls_holder = Mid (as_source, ll_start, Len (as_source))

// Update array and counter if necessary
if Len (ls_holder) > 0 then
	ll_count++
	as_Array[ll_Count] = ls_holder
end if

st_2.Text = ''

//Return the number of entries found
Return ll_Count

end function

public function long of_get_maxcptcode ();// (Appeon)Harry 06.07.2013 - V141 ISG-CLX
//added by long.zhang 05.03.2013
long ll_code

select max(cpt_code_id) into :ll_code From ctx_cpt_codes;

if isNUll(ll_code) then ll_code=0

return ll_code
end function

public function integer of_database_tab ();//Start Code Change ----04.01.2013 #V12 maha - added
long integers

long ll_start, ll_used
string ls_null_array[]

ll_start = Cpu()

long  ll_pos
string ls_Null
SetNull(ls_Null)
blob lbl_temp

string is_docname,is_named
long   ll_FileNum
long   ll_return 
blob   empty_blob
blob lbl_data
blob   b_text_blob
string ls_file_dump
string is_file_names[]
string ls_code
string ls_desc
string ls_codes[]
long ll_i
long ll_existing_count
long ll_updated_count
long ll_imported_count
Long ll_lookup_id
n_cst_string       lnv_string
    string ls_search 
integer li_FileNum
long ll_rowcount 
	Dec{2} ld_price

dw_2.accepttext( )

ll_rowcount =  dw_2.rowcount()
messagebox( "Import file records", string(ll_rowcount))

if ll_rowcount = 0 then return 0


for ll_i = 1 to ll_rowcount
	ls_codes[ll_i] = dw_2.getItemString(ll_i,'cpt_code')
end for

//ls_codes[1] = "12345"
//ls_codes[2] = "12344"
//ls_codes[3] = "56789"

//get existing records
If ll_rowcount > 0 Then
	dw_exist.Settransobject( SQLCA )
	ll_existing_count = dw_exist.Retrieve(ls_codes[])
End If


for ll_i = ll_rowcount to 1 step -1

	ls_code = dw_2.getItemString(ll_i,'cpt_code')
	ls_desc = dw_2.getItemString(ll_i,'cpt_code_description')
	if isnull(ls_desc ) then ls_desc = ""
	ld_price = dw_2.GetItemNumber( ll_i, "base_price" )	 
	 if isnull( ld_price ) then ld_price = 0

   	ls_search = "upper(cpt_code) =  '" + ls_code + "'"
	ll_pos = dw_exist.find(ls_search, 1, ll_existing_count)
	
	if ll_pos > 0 then 
		if ib_add_new_codes_only = false then
			if len(ls_desc) > 0 then
				dw_exist.setitem(ll_pos, "cpt_code_description", ls_desc)
			end if
		end if
		if ld_price > 0 then
			dw_exist.setitem(ll_pos, "base_price", ld_price )
		end if
		
		dw_2.deleterow(ll_i) //if found delete the matching import row
		ll_updated_count++
		
	else //if not found
		ll_imported_count = ll_imported_count + 1
	end if

next 

messagebox( "Import records not found", string(ll_rowcount))

ll_rowcount = dw_2.rowcount() //remaining new records
//ll_lookup_id = gnv_app.of_get_id("LOOKUP", ll_rowcount) - 1

 ll_lookup_id = of_get_maxcptcode()	//added by long.zhang 05.03.2013

for ll_i = 1 to ll_rowcount
	//ll_lookup_id+= ll_i
	ll_lookup_id++	//long.zhang 05.03.2013
	dw_2.setitem(ll_i, "cpt_code_id", ll_lookup_id)
next

dw_2.update()
dw_exist.update()

st_2.text = 'Modification Complete. ' + string(ll_updated_count)  + ' CPT codes updated,' + string(ll_imported_count) + ' CPT codes imported '



return 0


end function

public function integer of_open_tab ();//Start Code Change ----04.01.2013 #V12 maha

integer res

of_browse()

res = dw_2.importfile( is_doc_path )

if res < 0 then
	messagebox("CPT code import","Import Failed.  Check file formating.")
	return -1
end if

dw_2.sort()

return 1

end function

on u_tabpg_cpt_import.create
int iCurrent
call super::create
this.st_3=create st_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_2=create dw_2
this.dw_exist=create dw_exist
this.cb_scrub=create cb_scrub
this.st_click=create st_click
this.rb_ama=create rb_ama
this.rb_tab=create rb_tab
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.st_2=create st_2
this.cb_close=create cb_close
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_exist
this.Control[iCurrent+6]=this.cb_scrub
this.Control[iCurrent+7]=this.st_click
this.Control[iCurrent+8]=this.rb_ama
this.Control[iCurrent+9]=this.rb_tab
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.cb_1
end on

on u_tabpg_cpt_import.destroy
call super::destroy
destroy(this.st_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_2)
destroy(this.dw_exist)
destroy(this.cb_scrub)
destroy(this.st_click)
destroy(this.rb_ama)
destroy(this.rb_tab)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.st_2)
destroy(this.cb_close)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_cpt_import
integer x = 210
integer y = 2380
end type

type st_3 from statictext within u_tabpg_cpt_import
boolean visible = false
integer x = 3826
integer y = 140
integer width = 229
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 80263581
string text = "AMA Code Import"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_2 from u_rb within u_tabpg_cpt_import
string tag = "Leave existing Codes description in place, add new codes."
integer x = 1833
integer y = 356
integer width = 1399
integer height = 68
boolean bringtotop = true
long backcolor = 33551856
string text = "Leave existing Codes description in place, add new codes."
end type

event clicked;call super::clicked;


if this.checked then 
	ib_update_existing = false
   ib_add_new_codes_only = true
end if 
end event

type rb_1 from u_rb within u_tabpg_cpt_import
string tag = "Over-write existing codes with new description."
integer x = 635
integer y = 356
integer width = 1115
integer height = 68
boolean bringtotop = true
long backcolor = 33551856
string text = "Over-write existing codes with new description. "
boolean checked = true
end type

event clicked;call super::clicked;
if this.checked then 
	ib_update_existing = true
   ib_add_new_codes_only = false 
end if 
end event

type dw_2 from u_dw_contract within u_tabpg_cpt_import
integer x = 585
integer y = 544
integer width = 2651
integer height = 1372
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ext_cpt_code_preview"
boolean hsplitscroll = true
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;

choose case dwo.name
	case 'b_sort'
		event pfc_sortdlg( )
		
	case 'b_filter'
		event pfc_filterdlg( )
	case 'b_1'
		event pfc_deleterow( )
end choose
end event

event constructor;call super::constructor;this.of_SetSort(TRUE)


this.inv_sort.of_SetUseDisplay(TRUE)

this.inv_sort.of_SetColumnnameSource(this.inv_sort.HEADER)

this.inv_sort.of_SetStyle(this.inv_sort.DRAGDROP)

this.inv_sort.of_SetColumnHeader(TRUE)


this.of_SetFilter(TRUE)
this.inv_filter.of_SetColumnDisplayNameStyle(2)
this.inv_filter.of_SetStyle(2)
 


end event

type dw_exist from datawindow within u_tabpg_cpt_import
boolean visible = false
integer x = 3410
integer y = 564
integer width = 631
integer height = 1336
integer taborder = 31
boolean bringtotop = true
string title = "none"
string dataobject = "d_cpt_code_maint_tab_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_scrub from commandbutton within u_tabpg_cpt_import
boolean visible = false
integer x = 3538
integer y = 448
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Scrub"
end type

event clicked;long r
long rc
string s1
string s2
string s3

rc = dw_2.rowcount()

for r = 1 to rc
	s1 = dw_2.getitemstring(r, "cpt_code")
	s2 = dw_2.getitemstring(r, "cpt_code_description")
	if len(s2) > 0 then 
		s3 = mid( s1 + "-" + s2, 1, 10)
		dw_2.setitem(r, "cpt_code", s3 )
	end if
next

end event

type st_click from statictext within u_tabpg_cpt_import
integer x = 3301
integer y = 1836
integer width = 78
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;cb_scrub.visible = true
dw_exist.visible = true
end event

type rb_ama from radiobutton within u_tabpg_cpt_import
integer x = 622
integer y = 192
integer width = 736
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "AMA download file format"
boolean checked = true
end type

event clicked;//rb_1.text = "Over-write existing codes with new description. "
//rb_2.text = "Leave existing Codes description in place, add new codes."
dw_2.dataobject = "d_ext_cpt_code_preview"
dw_2.settransobject(sqlca)
end event

type rb_tab from radiobutton within u_tabpg_cpt_import
integer x = 1440
integer y = 188
integer width = 699
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Tab delimited text file"
end type

event clicked;dw_2.dataobject = "d_ext_cpt_code_tab_imp"
dw_2.settransobject(sqlca)
end event

type gb_1 from u_gb within u_tabpg_cpt_import
integer x = 553
integer y = 296
integer width = 2720
integer height = 148
integer taborder = 10
long backcolor = 33551856
string text = "Action"
end type

type gb_2 from u_gb within u_tabpg_cpt_import
integer x = 553
integer y = 464
integer width = 2720
integer height = 1456
integer taborder = 21
long backcolor = 33551856
string text = "Preview"
end type

type gb_3 from groupbox within u_tabpg_cpt_import
integer x = 562
integer y = 124
integer width = 2048
integer height = 152
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Import File Type"
end type

type st_2 from statictext within u_tabpg_cpt_import
integer x = 567
integer y = 8
integer width = 1559
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_close from u_cb within u_tabpg_cpt_import
string tag = "Close the window"
integer x = 3712
integer y = 4
integer taborder = 10
boolean bringtotop = true
string text = "&Close"
end type

event clicked;call super::clicked;iw_parent.triggerevent('pfc_close')
end event

type cb_2 from u_cb within u_tabpg_cpt_import
string tag = "Imports the CPT Codes after you have review them."
integer x = 2555
integer y = 4
integer width = 357
integer taborder = 10
boolean bringtotop = true
string text = "&Import Codes"
end type

event clicked;call super::clicked;//Start Code Change ----04.01.2013 #V12 maha
if rb_tab.checked then
	of_database_tab( )
else
	Of_database( )
end if
//End Code Change ----04.01.2013	
end event

type cb_1 from u_cb within u_tabpg_cpt_import
string tag = "Open a text file for import. This import function assumes that the text file has two columns. The first is the CPT Code. The second is the description."
integer x = 2176
integer y = 4
integer taborder = 10
boolean bringtotop = true
string text = "&Open File"
boolean default = true
end type

event clicked;call super::clicked;//Start Code Change ----04.01.2013 #V12 maha
if rb_tab.checked then
	of_open_tab()
else
	OF_open( )
end if
//End Code Change ----04.01.2013	

end event

