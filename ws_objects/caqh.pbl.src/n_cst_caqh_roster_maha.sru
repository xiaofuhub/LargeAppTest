$PBExportHeader$n_cst_caqh_roster_maha.sru
$PBExportComments$modified for the prascticeaddress section and address links
forward
global type n_cst_caqh_roster_maha from nonvisualobject
end type
end forward

global type n_cst_caqh_roster_maha from nonvisualobject
end type
global n_cst_caqh_roster_maha n_cst_caqh_roster_maha

type variables
Public:
CONSTANT String IS_SUBMISSION = 'SUBMISSION'
CONSTANT String IS_LIST = 'LIST' //Return List File
CONSTANT String IS_EXCEPTION = 'EXCEPTION'

Private:
n_cst_message inv_message //scheduler

boolean  ib_schedule = false

datastore ids_setting
datastore ids_files_save //save to table caqh_roster_files

//Setting-Layout (Submission file)
Int ii_maxsizes[]
String is_field_names[] 
String is_formats[]
String is_matchs[]
String is_descriptions[]
String is_expressions[]
String is_errtext //used for of_send_file and of_get_file function

n_cst_string inv_string


end variables

forward prototypes
public function integer of_set_sched_flag (boolean ab_flag)
public function long of_get_file_id ()
public function long of_get_export_id ()
public function string of_get_po_id ()
public function string of_get_region_id ()
public function integer of_check_settings (ref string as_err)
public function string of_get_export_sql ()
public function integer of_get_export_pracs (ref long al_prac_id[])
public function integer of_add_submission_dw (datawindow adw_curr)
public function integer of_add_submission_ds (datastore ads_curr)
public function integer of_add_submission_ds (datastore ads_curr, long al_prac_ids[], boolean ab_auto)
public function integer of_add_submission_dw (datawindow adw_curr, long al_prac_ids[], boolean ab_auto)
public function integer of_check_layout (datawindow adw)
public function integer of_create_dw_detail (ref datawindow adw_detail, datawindow adw_browser)
public function integer of_modify_dw_detail (ref datawindow adw)
public function integer of_check_layout_row (datawindow adw, long al_row)
public function string of_check_layout_field (datawindow adw, long al_row, long al_column)
public function integer of_get_ftpparms (ref str_ftp_parms as_parms)
public function string of_get_name_last (string as_type)
public function integer of_set_name_last (string as_type, string as_name)
public function integer of_get_ftp_filenames (datastore ads_dirlist, string as_type, ref string al_rnames[], ref string al_rpaths[])
public function integer of_log_file (string as_filetype, long al_file_ids[], string as_file_names[], integer ai_submit)
public function integer of_get_file_nm (ref string as_nm)
public function integer of_get_file_id (ref long al_file_ids[], integer ai_cnt)
public function integer of_log_file (string as_filetype, long al_file_ids[], string as_file_names[])
public function integer of_import_file (string as_filetype, long al_file_ids[], string as_file_names[])
public function integer of_import_file2ds (ref datastore ads_temp, string as_filetype, long al_file_ids, string as_file_names)
public subroutine of_refresh_settings ()
public function integer of_get_file (string as_type, ref string as_errtext)
public function integer of_send_file (long al_file_id, ref string as_errtext)
public function integer of_create_file (ref string as_file_nm, long al_file_id)
public function integer of_match_exception (ref datastore ads_exception)
public function long of_get_max_roster_id ()
public function integer of_check_layout_row (datawindow adw, long al_row, boolean ab_scroll2error)
public subroutine of_delete_returnroster ()
public function integer of_get_len_max (string as_value)
public function integer of_fix_na (datawindow adw)
public function integer of_zip2txt (ref string as_zipfile)
end prototypes

public function integer of_set_sched_flag (boolean ab_flag);//====================================================================
//$<Function>: of_set_sched_flag
//$<Arguments>:
// 	value    boolean    ab_flag
//$<Return>:  integer
//$<Description>: Set the schedule flag
//$<Author>: (Appeon) long.zhang 05.18.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_schedule = ab_flag

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function long of_get_file_id ();//====================================================================
//$<Function>: of_get_file_id
//$<Arguments>:
//$<Return>:  long
//$<Description>: Get new file id by  caqh_roster_files.
//$<Author>: (Appeon) long.zhang 05.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_file_id
select max(file_id) into :ll_file_id from caqh_roster_files using sqlca;
If sqlca.sqlcode >= 0 Then
	If ll_file_id>0 Then
		ll_file_id = ll_file_id + 1
	Else
		ll_file_id = 1
	End If
Else
	ll_file_id = -1
End If

return ll_file_id


end function

public function long of_get_export_id ();//====================================================================
//$<Function>: of_get_export_id
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Get Export Id setting
//$<Author>: (Appeon) long.zhang 05.27.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long id = 0
int li_find

li_find =  ids_setting.find("stype = 'EXPORT' and item_1 = '" +  'Export ID' + "'", 1, ids_setting.rowcount()) 
If li_find > 0 Then 
	id = Long(ids_setting.getitemstring(li_find, 'value_1'))
	If isnull(id) Then id = 0
End If

Return id
end function

public function string of_get_po_id ();//====================================================================
//$<Function>: of_get_po_id
//$<Arguments>:
//$<Return>:  string
//$<Description>: This field denotes the Organization Identifier. This is a CAQH assigned identifier for each Participating Organization established at the time of contracting.
//$<Author>: (Appeon) long.zhang 05.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_organization_id = ''
int li_find

li_find =  ids_setting.find("stype = 'BASIC' and item_1 = '" +  'Organization ID' + "'", 1, ids_setting.rowcount()) 
If li_find > 0 Then 
	ls_organization_id = Trim(ids_setting.getitemstring(li_find, 'value_1'))
	If isnull(ls_organization_id) Then ls_organization_id = ''
End If

Return ls_organization_id
end function

public function string of_get_region_id ();//====================================================================
//$<Function>: of_get_region_id
//$<Arguments>:
//$<Return>:  string
//$<Description>:This field denotes a Participating organization’s region identifier.
//						Region ID is an identifier assigned by UPD to assist large organizations in decentralizing UPD usage based on regional demographics.
//$<Author>: (Appeon) long.zhang 05.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_id = ''
int li_find
li_find =  ids_setting.find("stype = 'BASIC' and item_1 = '" +  'Region ID' + "'", 1, ids_setting.rowcount()) 
If li_find > 0 Then 
	ls_id = Trim(ids_setting.getitemstring(li_find, 'value_1'))
	If isnull(ls_id) Then ls_id = ''
End If

Return ls_id
end function

public function integer of_check_settings (ref string as_err);//====================================================================
//$<Function>: of_check_settings
//$<Arguments>:
// 	reference    string    as_err
//$<Return>:  integer
//$<Description>: Check CAQH Roster settings.
//$<Author>: (Appeon) long.zhang 05.28.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_value
String ls_error = ''
Long ll_value = 0
str_ftp_parms lstr_parms

//1.Check Organization ID
ls_value = of_get_po_id()
If ls_value = '' Then
	ls_error +=  "There is no Orgnization ID Setting available." +'~r~n'
End If

//2.Check  ll_export_id
ll_value = of_get_export_id()
If ll_value = 0 Then
	ls_error +=  "There is no Export ID Setting available." +'~r~n'
End If

////3.Check Export sql
//ls_value = of_get_export_sql()
//If ls_value = '' Then
//	ls_error +=  "There is no Export Retrieval Query Setting available." +'~r~n'
//End If

//4.Check SFTP Setting
ll_value = of_get_ftpparms(lstr_parms)
If ll_value < 0  Then
	ls_error +=  "There is no SFTP Setting available." +'~r~n'
End If

If LenA(ls_error) > 0 Then
	as_err = ls_error
	Return -1
End If

Return 0
end function

public function string of_get_export_sql ();//====================================================================
//$<Function>: of_get_export_sql
//$<Arguments>:
//$<Return>:  string
//$<Description>: Get Export SQL setting
//$<Author>: (Appeon) long.zhang 05.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_value = ''
int li_find

li_find =  ids_setting.find("stype = 'EXPORT' and item_1 = '" +  'Retrieval Query' + "'", 1, ids_setting.rowcount()) 
If li_find > 0 Then 
	ls_value = Trim(ids_setting.getitemstring(li_find, 'expression'))
	If isnull(ls_value) Then ls_value = ''
End If

Return ls_value
end function

public function integer of_get_export_pracs (ref long al_prac_id[]);//====================================================================
//$<Function>: of_get_export_pracs
//$<Arguments>:
// 	reference    long    al_prac_id[]
//$<Return>:  integer 1 get prac ids/-1 error/0 get no prac ids
//$<Description>: Get al_prac_id[] by export sql setting.
//$<Author>: (Appeon) long.zhang 05.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long prac_ids[]
long ll_prac_row
string ls_presentation_str
string ls_sny_retrieve
string ls_dwsyntax_str
string ERRORS
string ls_datatype
n_ds lds_export_retrieve
integer i
integer ret  = 1

//Get Retrieval Query setting
ls_sny_retrieve = of_get_export_sql()
If ls_sny_retrieve = '' Then
	inv_message.of_MessageBox("Get Prac IDs", "No Export Retrieval Query Setting.", true)
	return -1
End If

ls_presentation_str = "style(type=grid)"		

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN
	inv_message.of_MessageBox("Get Prac IDs", "SyntaxFromSQL caused these errors: " + ERRORS, true)
	RETURN -1
END IF
lds_export_retrieve = CREATE n_ds
lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
lds_export_retrieve.SetTransObject( SQLCA )

//Check Coltype
ls_datatype = lds_export_retrieve.Describe( "#1" + ".coltype")
Choose Case LeftA (ls_datatype,5)
	Case "char(","char"
		ls_datatype = "C"
	Case "date","datet","time","times"
		ls_datatype = "D"
	Case "decim","numbe","doubl","real","long","ulong","int"
		ls_datatype = "N"
End Choose

If ls_datatype <> "N" Then
	inv_message.of_MessageBox("Get Prac IDs", "SyntaxFromSQL caused these errors: " + ls_sny_retrieve, true)
	RETURN -1
End If	

lds_export_retrieve.retrieve()
ll_prac_row = lds_export_retrieve.rowcount()

if ll_prac_row = 0 then 
	return 0
elseif ll_prac_row = -1 then
	return -1
end if

lds_export_retrieve.Setsort( "#1 A")
lds_export_retrieve.Sort()

for i = 1 to ll_prac_row
	prac_ids[i] = lds_export_retrieve.getitemnumber(i,1)
next

al_prac_id[] = prac_ids[]

return 1 
end function

public function integer of_add_submission_dw (datawindow adw_curr);//====================================================================
//$<Function>: of_add_submission_dw
//$<Arguments>:
// 	value    datawindow    adw_curr
//$<Return>:  integer
//$<Description>: Auto get data source.
//$<Author>: (Appeon) long.zhang 05.18.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_prac_ids[]
string ls_Syntax
string ls_ErrorText
integer li_Return
DataStore lds_Data

//Dynamic create datawindow
lds_Data = Create DataStore
ls_Syntax = adw_curr.object.datawindow.syntax
lds_Data.Create(ls_Syntax, ls_ErrorText)
adw_curr.ShareData(lds_Data)

li_Return = of_add_submission_ds(lds_Data,ll_prac_ids[], true)

Destroy lds_Data

Return li_Return

end function

public function integer of_add_submission_ds (datastore ads_curr);//====================================================================
//$<Function>: of_add_submission_ds
//$<Arguments>:
// 	value    datastore    adw_curr
//$<Return>:  integer
//$<Description>: Auto get data source.
//$<Author>: (Appeon) long.zhang 05.18.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_prac_ids[]

Return of_add_submission_ds(ads_curr,ll_prac_ids[], true)
end function

public function integer of_add_submission_ds (datastore ads_curr, long al_prac_ids[], boolean ab_auto);//====================================================================
//$<Function>: of_add_submission_ds
//$<Arguments>:
// 	value    datastore    ads_curr
// 	value    long          al_prac_ids[]
//	value	  boolean		ab_auto 	true:use sql condition in export Templete to get  al_prac_ids[]/ false: use al_prac_ids[].
//$<Return>:  integer 0 Not prac ids/1 success/-1 error
//$<Description>: Get data source by al_prac_ids[] and set data to ads_curr.
//$<Author>: (Appeon) long.zhang 05.18.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Datastore lds_source
Long ll_cnt
Long i
Long j
Long ll_curr_row
Long li_col_cnt
Long ll_export_id
String ls_col_nm_source
String ls_col_type_source
String ls_value
String ls_organization_id
String ls_region_id
pfc_n_cst_ai_export_apb ln_export

If not ab_auto and (UpperBound(al_prac_ids[]) < 1) Then Return 0

//Get default Orgnization ID,Region ID by settings
ls_organization_id = of_get_po_id()
If ls_organization_id = '' Then
	inv_message.of_MessageBox("Add Submission", "No Orgnization ID Setting.", true)
	Destroy lds_source
	Return -1
End If
ls_region_id = of_get_region_id()

//Get ll_export_id
ll_export_id = of_get_export_id()
If ll_export_id = 0 Then
	inv_message.of_MessageBox("Add Submission", "No Export ID Setting.", true)
	Destroy lds_source
	Return -1
End If

//Get data source by Export Id
lds_source = Create datastore
ln_export = Create pfc_n_cst_ai_export_apb

//Get al_prac_ids[] when ab_auto = true
If ab_auto Then 
	i = of_get_export_pracs(al_prac_ids[] )
	If i < 1 Then 
		inv_message.of_MessageBox("Add Submission", "Get no Prac Ids by Export Retrieval Query Setting.", true)
		Return 0
	End If	
End If
	
i = ln_export.of_get_export_data(ll_export_id,al_prac_ids[],lds_source)
Destroy pfc_n_cst_ai_export_apb

If i < 0 Then
	inv_message.of_MessageBox("Add Submission", "No rows found.", true)
	Return -1
End If

//Set Data from lds_source to ads_curr, only for the columns with the same name.
ll_cnt = lds_source.rowcount()
For i = 1 to ll_cnt
	//Move data to ads_curr, all columns are varchar(n)
	ll_curr_row = ads_curr.insertrow(0)
	
	li_col_cnt = integer( lds_source.object.DataWindow.Column.Count)
	For j = 1 to li_col_cnt
		ls_col_nm_source = lds_source.describe('#'+ string(j) +'.Name')
		ls_col_type_source = lds_source.describe('#'+ string(j) +'.ColType')
		If LeftA(ls_col_type_source,4) <> 'char' Then Continue 
		If ads_curr.Describe(ls_col_nm_source + '.ColType') <> '!' Then
			ls_value = lds_source.getitemstring( i, ls_col_nm_source)
			If isnull(ls_value) Then ls_value = ''
			ads_curr.setitem(ll_curr_row, ls_col_nm_source, ls_value)
		End If
	Next

	//Auto Set
	If ads_curr.Describe('roster_record_number.ColType') <> '!'  Then ads_curr.setitem(ll_curr_row, 'roster_record_number', ll_curr_row)
	If ads_curr.Describe('organization_id.ColType') <> '!'  Then ads_curr.setitem(ll_curr_row, 'organization_id', ls_organization_id)
	If ads_curr.Describe('region_id.ColType') <> '!'  Then ads_curr.setitem(ll_curr_row, 'region_id', ls_region_id)
Next

//Destroy
Destroy lds_source

Return 1
end function

public function integer of_add_submission_dw (datawindow adw_curr, long al_prac_ids[], boolean ab_auto);//====================================================================
//$<Function>: of_add_submission_ds
//$<Arguments>:
// 	value    datawindow    adw_curr
// 	value    long          al_prac_ids[]
//	value	  boolean		ab_auto 	true:use sql condition in export Templete to get  al_prac_ids[]/ false: use al_prac_ids[].
//$<Return>:  integer 0 Not prac ids/1 success/-1 error
//$<Description>: Get data source by al_prac_ids[] and set data to ads_curr.
//$<Author>: (Appeon) long.zhang 05.18.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_Syntax
string ls_ErrorText
integer li_Return
DataStore lds_Data

//Dynamic create datawindow
lds_Data = Create DataStore
ls_Syntax = adw_curr.object.datawindow.syntax
lds_Data.Create(ls_Syntax, ls_ErrorText)
adw_curr.ShareData(lds_Data)

li_Return = of_add_submission_ds(lds_Data,al_prac_ids[], ab_auto)

Destroy lds_Data

Return li_Return
end function

public function integer of_check_layout (datawindow adw);//====================================================================
//$<Function>: of_check_layout
//$<Arguments>:
// 	value    datawindow    adw
//$<Return>:  integer 1: All fields are ok /-X the first row that got error
//$<Description>: Check layout for a datawindow.
//$<Author>: (Appeon) long.zhang 06.02.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long li_cnt
Long i
Long j
Long li_end
Long ll_row_err
String ls_err
Boolean lb_row_err = false

li_cnt = adw.rowcount()
If li_cnt < 1 Then
	return 0
End If

//Check data
For i = 1 to li_cnt //Rows
	j = of_check_layout_row(adw, i)
	If j < 0 And (Not lb_row_err) Then 
		lb_row_err = true
		ll_row_err = i
	End If
Next

//Return first error row.
If lb_row_err = true Then Return -ll_row_err

Return 1
end function

public function integer of_create_dw_detail (ref datawindow adw_detail, datawindow adw_browser);//====================================================================
//$<Function>: of_create_dw_detail
//$<Arguments>:
// 	reference    datawindow    adw_detail
// 	value        datawindow    adw_browser
//$<Return>:  integer
//$<Description>: Create datawindow for Submisson Detail.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_rowcount,i
String ls_select_sql
String error_syntaxfromSQL, error_create
String new_syntax
String ls_presentation_str
String ls_grey
String ls_background

ls_grey = "80269524"//String(rgb(192,192,192))
ls_background = "16777215" 

ls_select_sql = adw_browser.getsqlselect()
i = PosA(Upper(ls_select_sql),'WHERE ') 
If i > 0 Then ls_select_sql = LeftA(ls_select_sql, i - 1)

ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_background + " )" + "Text(Background.Color=" + ls_grey + ")"  

new_syntax = sqlca.SyntaxFromSQL(ls_select_sql,ls_presentation_str, error_syntaxfromSQL)
IF Len(error_syntaxfromSQL) > 0 THEN
	 inv_message.of_MessageBox("Caution", "SyntaxFromSQL caused these errors: " + error_syntaxfromSQL,true)
	 Return -1
ELSE
	// Generate new DataWindow
	adw_detail.Create(new_syntax, error_create)
	IF Len(error_create) > 0 THEN
		inv_message.of_MessageBox("Caution", "SyntaxFromSQL caused these errors: " + error_create,true)
		 Return -1
	END IF
	
	//Modify dw_detail
	of_modify_dw_detail(adw_detail)
	
	adw_detail.SetTransObject(sqlca)
END IF

Return 1
end function

public function integer of_modify_dw_detail (ref datawindow adw);//====================================================================
//$<Function>: of_modify_dw_detail
//$<Arguments>:
// 	reference    datawindow    adw
//$<Return>:  integer
//$<Description>:show 36 columns of Roster Submission file.
//$<Author>: (Appeon) long.zhang 07.31.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i
Int li_cur
Int li_title_x
Int li_title_y
Int li_err_x
Int ERR_X
Int li_row
Int res
String ls_retval
String ls_dddw
String ls_tmp
String ls_column
String ls_title
String ls_err_nm
String ls_modify_err
Constant Int COL_WIDTH = 700
Constant Int TXT_WIDTH = 620
Constant Int ERR_WIDTH = 400
Constant Int COL_TXT_HEIGHT = 67
Constant Int OBJ_GAP = 15
Constant Int COL_TXT_GAP = 12
Constant Int HALF = 1750
Long ll_pos
Datawindowchild dwchild
n_cst_string lnv_string

//x of err_text
ERR_X = 2*OBJ_GAP + COL_WIDTH + TXT_WIDTH + COL_TXT_GAP

adw.setredraw(false)

//Hide file_id 
adw.modify('file_id.visible = 0')
adw.modify('file_id_t.visible = 0')

//Protect Seq_no
adw.modify('roster_record_number_t.visible = 0')
adw.modify('roster_record_number.visible = 0')

//Hide err_flag 
adw.modify('err_flag.visible = 0')
adw.modify('err_flag_t.visible = 0')

//fixed columns
For i = 1 to Upperbound(is_field_names[] )
	ls_column = Trim(is_field_names[i])
	ls_title = Trim(is_field_names[i]) + '_t'
	ls_err_nm = "t_err_" + string(i)
	
	//Title
	//adw.modify(ls_title+".text = '" + String(is_field_names[i]) + "'"	)
	ls_tmp = lnv_string.of_globalreplace( is_field_names[i], '_', ' ') //Added by Appeon long.zhang 12.08.2015
	adw.modify(ls_title+".text = '" + ls_tmp + "'"	)
	adw.Modify(ls_title+ ".background.mode = '1'") //
	
	//Add ddlb or dddw for some columns
	ll_pos = PosA(is_expressions[i],'#VALUES#')
	If ll_pos > 0 Then
		//Get value list
		ls_tmp = MidA(is_expressions[i],ll_pos + LenA('#VALUES#'))
		ll_pos = PosA(ls_tmp,'#')
		If ll_pos > 0 Then 
			ls_tmp = LeftA(ls_tmp, ll_pos - 1)
		End If
		
		//Modify dw
		adw.modify(ls_column +".ddlb.case = 'any'")
		adw.Modify( ls_column + ".ddlb.useasborder = Yes")	
		adw.modify(ls_column +".values = '"+ ls_tmp +"'")
		adw.modify(ls_column+'.width = ' + String(Integer(of_get_len_max(ls_tmp)) * 25 + 130) )	//Get max len of values
	Else
		ll_pos = PosA(is_expressions[i],'#DDDW#')
		If ll_pos > 0 Then
			//Get dddw setting
			ls_tmp = MidA(is_expressions[i],ll_pos + LenA('#DDDW#'))
			ll_pos = PosA(ls_tmp,'#')
			If ll_pos > 0 Then 
				ls_tmp = LeftA(ls_tmp, ll_pos - 1)
			End If
			
			//Set dddw (Format: 'dddw,data value,display value')
			ls_dddw = LeftA(ls_tmp, PosA(ls_tmp,',') - 1 )
			
			ls_retval = adw.Modify( ls_column + ".dddw.VscrollBar = Yes")		
			adw.Modify( ls_column + ".dddw.HScrollBar = Yes")	
			adw.Modify( ls_column + ".dddw.useasborder = Yes")			
			adw.Modify( ls_column + ".dddw.NilIsNull= Yes")
			adw.Modify( ls_column + ".dddw.Lines= 15")
			adw.Modify( ls_column + ".dddw.Required = No")
			adw.Modify( ls_column + ".dddw.AllowEdit = No")		
			adw.Modify( ls_column + ".dddw.name = '" +ls_dddw+"'")		
			adw.Modify( ls_column + ".dddw.PercentWidth= 300")
								
			ls_tmp = MidA(ls_tmp, PosA(ls_tmp,',') + 1) //'data value,display value'
			adw.Modify( ls_column + ".dddw.datacolumn = '" +LeftA(ls_tmp, PosA(ls_tmp, ',') - 1)+"'")			
			adw.Modify( ls_column + ".dddw.displaycolumn = '" +MidA(ls_tmp,  PosA(ls_tmp, ',') + 1 ) +"'")	
			
			//Retrieve data
			res  = adw.GetChild( ls_column, dwchild )
			If res = 1 then
				IF LenA( ls_retval ) = 0 THEN
					dwchild.SetTransObject( SQLCA )
					dwchild.Retrieve()
					dwchild.InsertRow( 1 )
				END IF
				
				adw.modify(ls_column+'.width = ' + String(Integer(adw.describe(ls_column+'.width')) + 130 ))
			End If	
		Else
			//Increase for column width
			adw.modify(ls_column+'.width = ' + String(Integer(adw.describe(ls_column+'.width')) + 30 ))
		End If
	End If
	
	//Modify width and HEIGHT
	adw.modify(ls_title+'.width = ' + String(TXT_WIDTH))
	 
	If Integer(adw.describe(ls_column+'.width')) > COL_WIDTH Then
		adw.modify(ls_column+'.width = ' + String(COL_WIDTH))	
	End If
	
	adw.modify(ls_title+'.height = ' + String(COL_TXT_HEIGHT))
	adw.modify(ls_column+'.height = ' + String(COL_TXT_HEIGHT))	
	
	//Modify position
	If Mod(i, 2) = 1  Then
		li_row = ( i + 1 )/2
		li_title_x = OBJ_GAP
		li_title_y = OBJ_GAP*li_row + COL_TXT_HEIGHT*(li_row - 1)
		adw.modify(ls_title+'.x = ' + String(li_title_x) )
		adw.modify(ls_title+'.y = ' +  String(li_title_y) )
	
		adw.modify(ls_column+'.x = ' + String(li_title_x + TXT_WIDTH + COL_TXT_GAP))
		adw.modify(ls_column+'.y = ' +  String(li_title_y) )
		
		li_err_x = ERR_X
	Else
		li_row = i /2
		li_title_x = HALF + OBJ_GAP
		li_title_y =  OBJ_GAP*li_row + COL_TXT_HEIGHT*(li_row - 1)
		adw.modify(ls_title+'.x = ' + String(li_title_x) )
		adw.modify(ls_title+'.y = ' +  String(li_title_y) )
	
		adw.modify(ls_column+'.x = ' + String(li_title_x + TXT_WIDTH + COL_TXT_GAP))
		adw.modify(ls_column+'.y = ' +  String(li_title_y) )
		
		li_err_x = HALF + ERR_X
	End If
	
	//Create t_err_x for show errors
	ls_modify_err = adw.Modify("create text(band=detail text='' name=" +ls_err_nm +" x='" + String(li_err_x) + "' y='" + String(li_title_y)  + "' height='"+String(COL_TXT_HEIGHT)+"' width='" + String(ERR_WIDTH) + "' visible='1' text='' height.autosize=no border='0' color='255'  font.face='MS Sans Serif' font.height='-8' font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' )" )
	
	//Add ToolTips for t_err_x
	ls_modify_err  = adw.modify(ls_err_nm+".Tooltip.Enabled = Yes" )	
	ls_modify_err  = adw.modify(ls_err_nm+".Tooltip.Icon = 1" )	
	
	//Add Tooltips
	ls_modify_err  = adw.modify(ls_column+".Tooltip.Enabled = Yes" )	
	ls_modify_err  = adw.modify(ls_column+".Tooltip.Icon = 1" )	
	ls_modify_err  = adw.modify(ls_column+".Tooltip.tip = '" + is_descriptions[i] + "'" )	
	
Next

adw.modify("DataWindow.Detail.Height= " + String(li_title_y + 100))

//Add buttons ,Added by Appeon long.zhang 10.12.2015 (BugS092802)
adw.Modify ("DataWindow.Header.Height= '110'" )
adw.Modify("create button(band=header text='Fix Not Applicable Fields' filename='' action='0' border='1' color='128' x='" +String(2000) +"' y='16' height='85' width='835' vtextalign='0' htextalign='0'  font.face='MS Sans Serif' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = b_clear)")


adw.setredraw(true)

Return 1
end function

public function integer of_check_layout_row (datawindow adw, long al_row);//====================================================================
//$<Function>: of_check_layout
//$<Arguments>:
// 	value    datawindow    adw
// 	value    long          al_row
//$<Return>:  integer
//$<Description>: Check layout for one row in a datawindow.
//$<Author>: (Appeon) long.zhang 06.04.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return of_check_layout_row(adw, al_row, False)
end function

public function string of_check_layout_field (datawindow adw, long al_row, long al_column);//====================================================================
//$<Function>: of_check_layout_field
//$<Arguments>:
// 	value    datawindow    adw
// 	value    long         al_row
// 	value    long         al_column
//$<Return>:  string
//$<Description>: Check Roster Data File Layout for a specified field by Roster Data Exchange Guidelines.
//$<Author>: (Appeon) long.zhang 06.02.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int li_cnt
Int li_layout
Int li_end
Int i
Long ll_pos
String ls_err
String ls_data
String ls_begin
String ls_action_flag
String ls_CAQH_Provider_ID
String ls_required
String ls_expression_tmp
String ls_match
String ls_column_name
DatawindowChild dwchild

If al_column < 3 Then return '' //Don't check 2 fields (file_id and roster_record_number) .

ls_err = ''
ls_data = adw.GetItemString(al_row, al_column)
If IsNull(ls_data) Then ls_data = ''

li_layout = al_column - 2 //Don't check 2 fields (file_id and roster_record_number) .

//field name
//ls_begin =  'Invalid value: '


//Max Size
If LenA(ls_data) > ii_maxsizes[li_layout] Then
	ls_err += '[Max Size:' + String(ii_maxsizes[li_layout])+'], '
End If

//Format
If LenA(ls_data) <> 0 Then
	Choose case is_formats[li_layout]
		Case 'CHAR' //Must reach the max size.
			If  LenA(ls_data) < ii_maxsizes[li_layout] Then
				ls_err += '[Size:' + String(ii_maxsizes[li_layout])+'], '
			End If
		Case 'DATE'
			If (Not IsDate(ls_data)) And (Not IsDate(Mid(ls_data,1,4) + '-' + Mid(ls_data,5,2) + '-' + Mid(ls_data,7,2)) )Then
				ls_err += '[Format:YYYYMMDD], '
			End If
		Case 	'INTEGER'
			If Not Match(ls_data,'^[0-9]+$') Then //all numeric digits
				ls_err += '[Format:Integer], '
			End If
		Case 'VARCHAR'
			//
		Case Else
				ls_err += '[Invalid format type], '	
	End Choose
	
	//Match (A: [A-Z]  9:[0-9]
	If LenA(is_matchs[li_layout]) > 0 Then
		ls_match = '^'
		For i = 1 to LenA(is_matchs[li_layout])
			If MidA(is_matchs[li_layout], i, 1) = 'A' Then
				ls_match += '[A-Z]'
			ElseIf MidA(is_matchs[li_layout], i, 1) = '9' Then
				ls_match += '[0-9]'
			End If
		Next
		ls_match +='$'
		
		If Not Match(ls_data, ls_match) Then
			ls_err +=  '[Format:'+is_matchs[li_layout]+'], '
		End If
	End If			
End If


//Required
If (is_field_names[li_layout] = 'Action_Flag') Then 
	ls_required = 'R'
Else	
	//Action_Flag
	ls_action_flag = adw.getitemstring(al_row, 'Action_Flag')
	If IsNull(ls_action_flag) Then ls_action_flag = ''
	//CAQH_Provider_ID
	ls_CAQH_Provider_ID = adw.getitemstring(al_row, 'CAQH_Provider_ID')
	If IsNull(ls_CAQH_Provider_ID) Then ls_CAQH_Provider_ID = ''
	
	If Trim(ls_action_flag) <> '' Then
		If LenA(ls_CAQH_Provider_ID) > 0 And ls_action_flag = 'A' Then //Quick Add with CAQH ID
			ls_required = MidA(is_expressions[li_layout],2,1)
		ElseIf LenA(ls_CAQH_Provider_ID) = 0 And ls_action_flag = 'A' Then //Initial Add
			ls_required = MidA(is_expressions[li_layout],1,1)
		ElseIf ls_action_flag = 'U' Then //Delete
			ls_required = MidA(is_expressions[li_layout],3,1)
		ElseIf ls_action_flag = 'D' Then //Delete
			ls_required = MidA(is_expressions[li_layout],4,1)
		End If
		
		//Conditional -C, special logic.
		If ls_required = 'C' Then
			//#C1# the first condition.
			ll_pos = PosA(is_expressions[li_layout],'#C1#')
			If ll_pos > 0 Then
				ls_expression_tmp = MidA(is_expressions[li_layout],ll_pos + LenA('#C1#'))
				ll_pos = PosA(ls_expression_tmp,'#')
				If ll_pos > 0 Then 
					ls_expression_tmp = LeftA(ls_expression_tmp, ll_pos - 1)
				End If

				ls_required = adw.Describe("evaluate('" +ls_expression_tmp + "'," +string(al_row)+ ")")
				If ls_required = '!' Then ls_required = ''
			End If
		End If
	Else
		ls_required = '' //unknown
	End If
End If

Choose case ls_required
	case 'R' //Required
		If LenA(ls_data) = 0 Then 
			ls_err += '[Required Field], '
		End If
	case 'N' //Not Applicable
		If LenA(ls_data) > 0 Then 	
			ls_err += '[Not Applicable], '
		End If
End Choose

//Check whether current value is in the dddw list
If PosA(is_expressions[li_layout],'#DDDW#') > 0 And (ls_required <> 'N') Then//Don't check 'Not Applicable' any more, Added by Appeon long.zhang 12.29.2015
	//current column name
	ls_column_name = adw.Describe( "#" + String(al_column) + ".name")
	
	//DDDW
	If adw.GetChild( ls_column_name, dwchild ) = 1 then
		//dddw.datacolumn
		If dwchild.Find( adw.Describe( ls_column_name + ".dddw.datacolumn") + " = '" + ls_data + "'", 1, dwchild.rowcount()) < 1 Then
			ls_err +=  '[Invalid Value], '
		End If
	End If
End If

//Set err text for current row
If adw.GetRow() = al_row Then
	//ls_err
	If lenA(ls_err) > 0 Then 
		ls_err = ls_begin + LeftA(ls_err, LenA(ls_err) - 2)
	
		//Only for dw_submit_detail
		If adw.Describe("t_err_" +string(li_layout) +".text" ) <>'!' Then
			//Add whole error text to ToolTip. Added by Appeon long.zhang 09.29.2015 (BugS092401) 
			adw.modify("t_err_" +string(li_layout) +".Tooltip.tip = '"+ ls_err +"'") 
			
			//Only show the first error if has more errors.
			If PosA(ls_err,',') > 0 Then
				ls_err = LeftA(ls_err, PosA(ls_err, ']')) + '...'
			End If
			adw.Modify("t_err_" +string(li_layout) +".text = '"+ ls_err +"'")
		End If
	Else
		//Only for dw_submit_detail
		If adw.Describe("t_err_" +string(li_layout) +".text" ) <>'!' Then
			adw.Modify("t_err_" +string(li_layout) +".text = ''")
			adw.modify("t_err_" +string(li_layout) +".Tooltip.tip = ''") 
		End If
	End If
End If
	
return ls_err
end function

public function integer of_get_ftpparms (ref str_ftp_parms as_parms);//====================================================================
//$<Function>: of_get_ftpparms
//$<Arguments>:
// 	reference    str_ftp_parms    as_parms
//$<Return>:  integer
//$<Description>: Get SFTP Setting
//$<Author>: (Appeon) long.zhang 06.30.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
str_ftp_parms lstr_parms
String ls_username
String ls_password
String ls_hostname
String ls_port
int li_find

//Get from ids_setting
li_find =  ids_setting.find("stype = 'SFTP'", 1, ids_setting.rowcount()) 
If li_find > 0 Then 
	ls_hostname = Trim(ids_setting.getitemstring(li_find, 'value_1'))
	ls_port = Trim(ids_setting.getitemstring(li_find, 'value_2'))
	ls_username = Trim(ids_setting.getitemstring(li_find, 'value_3'))
	ls_password = Trim(ids_setting.getitemstring(li_find, 'value_4'))
End If

If IsNull(ls_hostname) or ls_hostname = '' Then
	Return -1
End If

If IsNull(ls_port) or ls_port = '' Then
	Return -1
End If

If IsNull(ls_username) or ls_username = '' Then
	Return -1
End If

If IsNull(ls_password) or ls_password = '' Then
	Return -1
End If

lstr_parms.hostname =ls_hostname
lstr_parms.port = ls_port
lstr_parms.protocol = 1 //SFTP

lstr_parms.login = ls_username
lstr_parms.password = ls_password

as_parms = lstr_parms

Return 1
end function

public function string of_get_name_last (string as_type);//====================================================================
//$<Function>: of_get_name_last
//$<Arguments>:
//$<Return>:  string
//$<Description>: Find last 1. Submission, or 2.Return Roster List, or 3.Exception file name.
//$<Author>: (Appeon) long.zhang 05.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_name = ''
int li_find

Choose case as_type
	case IS_SUBMISSION	
		//POID>_ProviderRoster_YYYY_MM_DD_HH_MM.txt
		SELECT  value_1 INTO :ls_name FROM caqh_roster_setting WHERE stype = 'MAXNAME' ;
	case IS_LIST
		//<POID>_ReturnRoster_YYYY_MM_DD.txt
		SELECT  value_2 INTO :ls_name FROM caqh_roster_setting WHERE stype = 'MAXNAME' ;
	case IS_EXCEPTION
		//_RosterException_YYYY_MM_DD_HH_MM.txt
		SELECT  value_3 INTO :ls_name FROM caqh_roster_setting WHERE stype = 'MAXNAME' ;
	case else
		Return ''
End Choose

Return ls_name
end function

public function integer of_set_name_last (string as_type, string as_name);//====================================================================
//$<Function>: of_set_name_last
//$<Arguments>:
// 	value    string    as_type
// 	value    string    as_name
//$<Return>:  integer 1:successful/-1: fail
//$<Description>: Set last  Submission, or Return Roster List, or Exception file name.
//$<Author>: (Appeon) long.zhang 07.03.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_name = ''
Int li_find
Int i = 0

Choose case as_type
	case IS_SUBMISSION	
		//POID>_ProviderRoster_YYYY_MM_DD_HH_MM.txt
		UPDATE caqh_roster_setting SET value_1 = :as_name WHERE stype = 'MAXNAME'  and (value_1 < :as_name or value_1 is null);
	case IS_LIST
		//<POID>_ReturnRoster_YYYY_MM_DD.txt
		UPDATE caqh_roster_setting SET value_2 = :as_name WHERE stype = 'MAXNAME'  and (value_2 < :as_name or value_2 is null);
	case IS_EXCEPTION
		//_RosterException_YYYY_MM_DD_HH_MM.txt
		UPDATE caqh_roster_setting SET value_3 = :as_name WHERE stype = 'MAXNAME'  and (value_3 < :as_name or value_3 is null);
		i = ids_setting.setitem(li_find, 'value_3',as_name)
End Choose

If sqlca.sqlcode < 0 Then
	Return -1
Else
	Return 1
End If

end function

public function integer of_get_ftp_filenames (datastore ads_dirlist, string as_type, ref string al_rnames[], ref string al_rpaths[]);//====================================================================
//$<Function>: of_get_ftp_filenames
//$<Arguments>:
// 	value        datastore    ads_dirlist
// 	value        string       as_type
// 	reference    string       al_rnames[]
// 	reference    string       al_rpaths[]
//$<Return>:  integer  0:no files/ -1:get POID error/ -2:invalid as_type /Else: return names count.
//$<Description>: Get names and paths if needed from ftp. 
//						Compare with local filenames and only get lager date files.
//$<Author>: (Appeon) long.zhang 07.02.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_cnt = 0
Long ll_find
Long ll_start = 1
Long ll_end
String ls_poid
String ls_find
String ls_last_file_name
String ls_rfile_name
String ls_max_rfile_name = ''
String ls_max_rname

Boolean lb_compare = true
Boolean lb_get = true

ll_end = ads_dirlist.rowcount()
If ll_end = 0 Then Return 0

ads_dirlist.SetSort('parent_name asc, item_name asc')
ads_dirlist.Sort()

//The <POID> is the identifier supplied by UPD to each Participating Organization
ls_poid = of_get_po_id()
If ls_poid = '' Then Return -1

//Difference between two types
If as_type = IS_LIST Then //<POID>_ReturnRoster_YYYY_MM_DD.txt/.zip
	ls_find = "upper(parent_name) = 'OUTGOING' and PosA(item_name, '_ReturnRoster_')> 0 "
ElseIf as_type = IS_EXCEPTION Then //<POID>_RosterException_YYYY_MM_DD_HH_MM.txt	
	ls_find = "upper(parent_name) = 'OUTGOING' and PosA(item_name, '_RosterException_')> 0 "
Else //Invalid as_type
	Return -2
End If	

//Get Local max Roster file name	
ls_last_file_name = of_get_name_last(as_type)	
If IsNull(ls_last_file_name) or Trim(ls_last_file_name) = '' Then lb_compare = FALSE

lb_get = TRUE

//Get al_rnames[] and al_rpaths[]
ll_find = ads_dirlist.find(ls_find, ll_start, ll_end)
Do while (ll_find > 0)
	ls_rfile_name = ads_dirlist.getItemString(ll_find,'item_name')
	
	//Compare remote file date with local max date. Only get lager date files.
	If lb_compare Then
		//Get Remote File Date	
		If ls_rfile_name <= ls_last_file_name  Then 
			lb_get = FALSE
		Else
			lb_get = TRUE
		End If
	End If
	
	If lb_get Then
		//Return Roster, Only get the max name.
		If as_type = IS_LIST Then
			If (ls_max_rfile_name = '') or (ls_max_rfile_name < ls_rfile_name) Then
				ls_max_rfile_name = ls_rfile_name
				ls_max_rname = ads_dirlist.getItemString(ll_find,'item_path')
			End If
		Else //IS_EXCEPTION, get each files.
			ll_cnt++
			al_rnames[ll_cnt] = ls_rfile_name
			al_rpaths[ll_cnt] =  ads_dirlist.getItemString(ll_find,'item_path')
		End If
	End If
	
	ll_start = ll_find + 1
	If ll_start > ll_end Then Exit
	ll_find = ads_dirlist.find(ls_find, ll_start, ll_end)
Loop

//Only get the Return Roster file with the max name.
If as_type = IS_LIST and ls_max_rfile_name <> '' Then
	al_rnames[1] = ls_max_rfile_name
	al_rpaths[1] = ls_max_rname
	ll_cnt = 1
End If

Return ll_cnt
end function

public function integer of_log_file (string as_filetype, long al_file_ids[], string as_file_names[], integer ai_submit);//====================================================================
//$<Function>: of_log_file
//$<Arguments>:
// 	value    string     as_filetype
// 	value    long       al_file_ids[]
// 	value    string     as_file_names[]
// 	value    integer    ai_submit  0:save 1:submit.
//$<Return>:  integer 1:success/-1:Retrieve idw_files_save error/-2: invalid as_filetype
//						-3:Record max file name to ids_setting error
//						-4:Update idw_files_save error
//						-5:This file had been send to CAQH before this time, can not submit it again.
//$<Description>: Insert or update to caqh_roster_files as file log.
//$<Author>: (Appeon) long.zhang 07.06.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i
Int j
Long li_cnt
String ls_max_file_name = ''
Datetime ldt_CurrentTime

ids_files_save.Reset()

SELECT getdate() INTO :ldt_CurrentTime FROM ids;

//1.Submission  a.save/b.submit   , ONLY deal with al_file_ids[1] 
If as_filetype = IS_SUBMISSION Then 
	If ai_submit = 0 Then //Save to database
		//new idw_files record
		i =	ids_files_save.insertrow(0)
		ids_files_save.setitem(i, 'file_id', al_file_ids[1])
		ids_files_save.setitem(i, 'file_type', 'S') //submission
		ids_files_save.setitem(i, 'create_user_id', gs_user_id)  
		ids_files_save.setitem(i, 'create_date', ldt_CurrentTime)  
		ids_files_save.setitem(i, 'send_status', 'N')  
		ids_files_save.setitem(i, 'exception_status', 'N')  
	Else //Submit to CAQH FTP
		i =	ids_files_save.retrieve(al_file_ids[1])
		If i <>1 Then
			is_errtext = 'Can not find file id ' +String(al_file_ids[1]) +'.'
			Return -1
		End If
		
		//If this file had been send to CAQH before this time, can not submit it again.
		If ids_files_save.GetItemString(i, 'send_status') = 'Y' Then
			is_errtext = 'File id ' +String(al_file_ids[1]) +' has been sent to CAQH previously, and can not be submitted again.'
			Return -5
		End If
		
		ids_files_save.setitem(i, 'file_name', as_file_names[1])  
		ids_files_save.setitem(i, 'send_status', 'Y')  
		ids_files_save.setitem(i, 'send_user_id', gs_user_id)  
		ids_files_save.setitem(i, 'send_date', ldt_CurrentTime)  	
		ls_max_file_name = as_file_names[1]
	End If
//2.roster return list, ONLY deal with al_file_ids[1] 
ElseIf as_filetype = IS_LIST Then
	i =	ids_files_save.insertrow(0)
	ids_files_save.setitem(i, 'file_id', al_file_ids[1])
	ids_files_save.setitem(i, 'file_name', as_file_names[1])  
	ids_files_save.setitem(i, 'file_type', 'R') //Roster Return list
	ids_files_save.setitem(i, 'create_user_id', gs_user_id)  
	ids_files_save.setitem(i, 'create_date', ldt_CurrentTime)  
	ls_max_file_name = as_file_names[1]
//3.Exception 
ElseIf as_filetype = IS_EXCEPTION Then
	li_cnt = Upperbound(al_file_ids[])
	For j = 1 to li_cnt
		i =	ids_files_save.insertrow(0)
		ids_files_save.setitem(i, 'file_id', al_file_ids[j])
		ids_files_save.setitem(i, 'file_name', as_file_names[j])  
		ids_files_save.setitem(i, 'file_type', 'E') //Roster Return list
		ids_files_save.setitem(i, 'create_user_id', gs_user_id)  
		ids_files_save.setitem(i, 'create_date', ldt_CurrentTime)  
		If ls_max_file_name = '' or ls_max_file_name < as_file_names[j] Then ls_max_file_name = as_file_names[j]
	Next
Else //invalid filetype
	is_errtext = 'Invalid filetype argument.'
	Return -2
End If

i = ids_files_save.update()
If i = 1 Then
	//Record max file name to ids_setting
	If ls_max_file_name <>'' Then 
		i = of_set_name_last(as_filetype, ls_max_file_name)
		If i <0 Then	
			is_errtext = 'Record max file name error.'
			Return -3
		End If
	End If
Else
	is_errtext = 'Save ids_files_save error.'
	Return -4
End If

Return 1
end function

public function integer of_get_file_nm (ref string as_nm);//====================================================================
//$<Function>: of_get_file_nm
//$<Arguments>:
// 	reference    string      as_nm
//$<Return>:  integer
//$<Description>: Generate a file name like <POID>_ProviderRoster_YYYY_MM_DD_HH_MM.txt and check it.
//$<Author>: (Appeon) long.zhang 05.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_file_nm = ''
String ls_po_id
int li_cnt
Datetime ldt_time

//Organization ID (POID)
ls_po_id = of_get_po_id()
If ls_po_id = '' Then 
	is_errtext = 'Organization ID (POID) is not valid.'
	Return -1
End If

SELECT getdate() INTO :ldt_time FROM ids;

ls_file_nm = ls_po_id + '_ProviderRoster_' + string(date(ldt_time),'yyyy_mm_dd') + '_' + string(time(ldt_time),'hh_mm') +'.txt'

//Check existing file names
select count(1) into :li_cnt from caqh_roster_files where file_name = :ls_file_nm using sqlca;
If li_cnt > 0 Then
	is_errtext = ls_file_nm + ' has already been submitted. It is not permited to send another file to CAQH with the same name.~r~n Please wait a minute and retry.'
	Return -1
End If

as_nm = ls_file_nm

Return 0
end function

public function integer of_get_file_id (ref long al_file_ids[], integer ai_cnt);//====================================================================
//$<Function>: of_get_file_id
//$<Arguments>:
// 	reference    long    al_file_ids[]
//	value			int		ai_cnt
//$<Return>:  int 1:success/ -1 error
//$<Description>:  Get new file ids by  caqh_roster_files.
//$<Author>: (Appeon) long.zhang 07.06.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int i
Long ll_file_id

ll_file_id = of_get_file_id()

If ll_file_id > 0 Then
	al_file_ids[1] = ll_file_id
	For i = 2 to ai_cnt
		al_file_ids[i] = al_file_ids[i - 1] + 1
	Next
Else
	Return -1
End If

Return 1
end function

public function integer of_log_file (string as_filetype, long al_file_ids[], string as_file_names[]);//====================================================================
//$<Function>: of_log_file
//$<Arguments>:
// 	value    string     as_filetype
// 	value    long       al_file_ids[]
// 	value    string     as_file_names[]
//$<Return>:  integer 
//$<Description>: Insert or update to caqh_roster_files as file log.
//$<Author>: (Appeon) long.zhang 07.06.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return of_log_file(as_filetype, al_file_ids[], as_file_names[], 0)
end function

public function integer of_import_file (string as_filetype, long al_file_ids[], string as_file_names[]);//====================================================================
//$<Function>: of_import_file
//$<Arguments>:
// 	value    string     as_filetype
// 	value    long       al_file_ids[]
// 	value    string     as_file_names[]
//$<Return>:  integer 1:success/-1:arguments error
//						-1X:zip2txt failed
//						-2X:import file to ds error
//						-3X:Match submission file id error (only used when as_filetype= EXCEPTION)
//						-4:save ds error
//$<Description>: Import file to database by as_filetype, and Insert or update to caqh_roster_files as file log.
//$<Author>: (Appeon) long.zhang 07.06.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int li_cnt
Int i
Int j
Int li_rtn = 1
String ls_file_names[]
String ls_dataobject
datastore lds_save
Boolean lb_stop = false

//Check arguments
li_cnt = upperbound(al_file_ids[]) 
If li_cnt = 0 Then Return -1

If upperbound(al_file_ids[])  <> upperbound(as_file_names[]) Then Return -1

For i = 1 to li_cnt
	ls_file_names[i] = gs_temp_path + "caqh\" + as_file_names[i]
Next
 
//Roster Return list
If as_filetype = IS_LIST Then //Only deal with al_file_ids[1]
	ls_dataobject = 'd_caqh_roster_list'
ElseIf as_filetype = IS_EXCEPTION Then
	ls_dataobject = 'd_caqh_roster_exception'
Else
	Return -1
End If

//Create lds_save
lds_save = Create datastore 
lds_save.dataobject = ls_dataobject
lds_save.SetTransObject(SQLCA)
	
For i = 1 to li_cnt
	//ReturnRoster maybe zip file, need to get the txt file from it.
	If as_filetype = IS_LIST Then
		j = of_zip2txt(ls_file_names[i])
		If j < 0 Then 
			li_rtn = -10 + j
			lb_stop = True
			Exit
		End If
	End If
	
	//Import txt to datastore
	j = of_import_file2ds(lds_save,as_filetype,al_file_ids[i], ls_file_names[i])
	If j < 0 Then 
		li_rtn = -20 + j
		lb_stop = True
		Exit
	End If
Next

//match submission file id (only used when as_filetype= EXCEPTION)
If Not lb_stop Then
	If  as_filetype = IS_EXCEPTION Then
		i = of_match_exception(lds_save)
		If i < 0 Then 
			li_rtn = -3 + i
			lb_stop = True
		End If
	End If
End If

//Save data
If Not lb_stop Then
	i = lds_save.update()
	If i = -1 Then
		li_rtn = -4
		lb_stop = True
	End If
End If

Destroy lds_save

Return li_rtn
end function

public function integer of_import_file2ds (ref datastore ads_temp, string as_filetype, long al_file_ids, string as_file_names);//====================================================================
//$<Function>: of_import_file2ds
//$<Arguments>:
// 	reference    datastore    ads_temp
// 	value        string       as_filetype
// 	value        long         al_file_ids
// 	value        string       as_file_names
//$<Return>:  integer  1:success/-1:error/ -2 importstring error
//$<Description>:  set file data to a datastore
//$<Author>: (Appeon) long.zhang 07.06.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_read
Long i
Long j
Long ll_row
String ls_read
String ls_begin

//Read data
li_read = FileOpen (as_file_names)
If li_read = -1 Then Return -1

If as_filetype = IS_LIST Then
	ls_begin = String(al_file_ids) + '~t' //#1 file_id
ElseIf as_filetype = IS_EXCEPTION Then
	ls_begin = String(al_file_ids) + '~t0~t' //#1  file_id and #2 submit_file_id
End If

//First Line
FileRead ( li_read, ls_read) 
For i = 1 To 50000
 	If FileRead ( li_read, ls_read) = -100 Then Exit
	 
	 ls_read = inv_string.of_globalreplace(ls_read, '|','~t')
	 ls_read = ls_begin + ls_read
	 
	//Set ads_temp
	j = ads_temp.ImportString(ls_read)
	If j < 0 Then 
		FileClose(li_read)
		Return -2
	End If
Next

FileClose(li_read)

Return 1
end function

public subroutine of_refresh_settings ();//====================================================================
//$<Function>: of_refresh_settings
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Retrieve ids_setting and set related instance variables.
//$<Author>: (Appeon) long.zhang 07.08.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int i
String	ls_Password
long		ll_find
n_cst_encrypt ln_encrypt

//Get Settings
ids_setting.retrieve()

//SFTP password
ll_find = ids_setting.find("stype = 'SFTP'", 1, ids_setting.rowcount())
If ll_find > 0 Then
	ls_Password = ids_setting.GetItemString(ll_find,"value_4")
	if Not IsNull(ls_Password) Then 
		ls_Password = ln_encrypt.of_Decrypt(ls_Password)
		ids_setting.SetItem(ll_find,"value_4",ls_Password)
		ids_setting.SetItemStatus(ll_find,"value_4",Primary!,NotModified!)
	End If
End If

Return
end subroutine

public function integer of_get_file (string as_type, ref string as_errtext);//====================================================================
//$<Function>: of_get_file
//$<Arguments>:
// 	value    string    as_type  EXCEPTION/LIST
// 	reference    string    as_errtext  used to return error text.
//$<Return>:  integer 
//						>0:Succeed. New files count.
//						0:No file needs to download.
//						-1:Get FTP parms error
//						-2:Get file id error
//						-3:Unable to create caqh file directory
//					 	-1X:Connect error
//					 	-2X:Analyse file names Error
//					 	-3X: Get File Error
//						-4X:Insert to caqh_roster_files error
//						-5XX:Insert to caqh_roster_list or caqh_roster_exception error
//$<Description>: Get all File needed from FTP Server and save data to database tables.   
//$<Author>: (Appeon) long.zhang 07.01.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i
Int j
Int li_rtn = 1
Long ll_file_ids[]
n_cst_ftp lnv_ftp
n_cst_dirattrib lnv_dirlist[]
n_cst_filesrvwin32 lnv_filesrv
Str_ftp_parms lstr_parms
String ls_rpath
String ls_filename
String ls_rpaths[]
String ls_filenames[]
String ls_write_path
Boolean lb_stop = false
Boolean lb_connect = False

is_errtext = ''

//Get FTP parms to lstr_parms
i =of_get_ftpparms(lstr_parms)
If i < 0 Then 
	is_errtext = 'Get FTP settings failed.'
	as_errtext = is_errtext
	Return -1
End If

lnv_ftp = Create n_cst_ftp

//1.Connect FTP
i = lnv_ftp.of_connect(lstr_parms)
If i < 0 Then 
	is_errtext = 'Connect to FTP failed.'
	li_rtn = -10 + i 
	lb_stop = true
Else
	lb_connect = True
End If

If Not lb_stop Then
	//Analyse file names which need download
	i = of_get_ftp_filenames(lnv_ftp.ids_dirlist,as_type,ls_filenames[],ls_rpaths[])
	If i < 0 Then
		is_errtext = 'Analyze FTP files failed.'
		li_rtn = -20 + i 
		lb_stop = true
	ElseIf i = 0 Then //Not file needs download
		li_rtn = 0
		lb_stop = true
	End If
End If


If Not lb_stop Then
	//Creating local CAQH directory
	ls_write_path = gs_temp_path + "caqh"
	if DirectoryExists ( ls_write_path ) = false then
		i = CreateDirectory ( ls_write_path )
		if i = -1 then
			is_errtext = 'Create local CAQH directory failed.'
			li_rtn = -3
			lb_stop = true
		end if
	end if
	
	//Delete old roster files
	lnv_filesrv = create n_cst_filesrvwin32
	i = lnv_filesrv.of_DirList(ls_write_path + "\*Roster*.*", 0, lnv_dirlist)
	If i >0 then 
		for j = 1 to upperbound(lnv_dirlist)
			FileDelete ( ls_write_path + "\" + lnv_dirlist[j].is_filename )
		next
	End If
	Destroy lnv_filesrv
End If

//Get File from ftp
If Not lb_stop Then
	For j = 1 to UpperBound(ls_filenames[])
		ls_filename = gs_temp_path + "caqh\" + ls_filenames[j] //local path
		ls_rpath = ls_rpaths[j] //remote path
		
		i = lnv_ftp.of_getfile(ls_filename, ls_rpath)
		If i < 0 Then
			li_rtn = -30 + i 
			is_errtext = 'Download file '+ ls_rpath +' failed.'
			lb_stop = true
			Exit
		End If
	Next
End If

//Insert file data to database
If Not lb_stop Then
	//Get file ids
	i = of_get_file_id(ll_file_ids[], upperbound(ls_filenames[]))
	If i < 0 Then
		li_rtn = -2
		lb_stop = true
	Else
		sqlca.autocommit = false
		
		//Insert to caqh_roster_files, occupy file ids.
		i = of_log_file(as_type, ll_file_ids[], ls_filenames[])
		If i < 0 Then
			is_errtext = 'Save file logs failed .' + is_errtext
			li_rtn = -40 + i
			lb_stop = true
		Else		
			//Insert to caqh_roster_list or caqh_roster_exception
			i = of_import_file(as_type, ll_file_ids[], ls_filenames[])
			If i < 0 Then
				is_errtext = 'Save file data failed.'
				li_rtn = -500 + i
				lb_stop = true
			End If
		End If
		
		If li_rtn < 0 Then 
			Rollback Using sqlca;
		Else
			Commit Using sqlca;
		End If
		sqlca.autocommit = true
	End If
End If

//Disconnect
If lb_connect Then lnv_ftp.of_disconnect()
Destroy lnv_ftp

If li_rtn = 1 Then li_rtn = UpperBound(ll_file_ids[])

If li_rtn < 0 Then as_errtext = is_errtext

Return li_rtn
end function

public function integer of_send_file (long al_file_id, ref string as_errtext);//====================================================================
//$<Function>: of_send_file
//$<Arguments>:
// 	value    long    al_file_id
//  reference string	as_errtext
//$<Return>:  integer  1:successful/ 
//	-1:Create file_name error
//	-2X:Update file log error
//	-3:Get FTP parms error
//	-4:Create file error
// -5X:connect error
// -6X:Send File error
//$<Description>: Create file and Send CAQH Submission File to FTP Server.
//$<Author>: (Appeon) long.zhang 07.01.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i
Int li_rtn
n_cst_ftp lnv_ftp
Str_ftp_parms lstr_parms
String ls_rpath
String ls_file_name
String ls_file_fullname
String ls_file_names[]
String ls_error
Long ll_file_ids[]
Boolean lb_stop = false

is_errtext = ''

//Create file_name
i = this.of_get_file_nm(ls_file_name)
If i < 0 Then //No Organization Id , or exists this name.
	is_errtext = 'Create file name error: ' + is_errtext
	as_errtext = is_errtext
	return -1
End If

//Begin transaction
sqlca.autocommit = false

//Write Log
ll_file_ids[1]	 = al_file_id
ls_file_names[1] = ls_file_name
i = this.of_log_file(this.IS_SUBMISSION, ll_file_ids[], ls_file_names[], 1)
If i < 0 Then
	is_errtext = 'Update file log error: ' + is_errtext
	li_rtn = -20 + i
	lb_stop = true
End If

//Get FTP parms to lstr_parms
If Not lb_stop  Then
	i =of_get_ftpparms(lstr_parms)
	If i < 0 Then 
		is_errtext = 'Get FTP settings failed.'
		li_rtn = -3
		lb_stop = true
	End If
End If

//Create File
If Not lb_stop  Then
	ls_file_fullname = ls_file_name
	i = this.of_create_file(ls_file_fullname, al_file_id)
	If i < 0 Then 
		is_errtext = 'Create file error: ' + is_errtext
		li_rtn = -4
		lb_stop = true
	End If	
End If

//Send file to FTP
If Not lb_stop = true Then
	lnv_ftp = Create n_cst_ftp
	//Connect to FTP
	i = lnv_ftp.of_connect(lstr_parms)
	If i < 0 Then 
		is_errtext = 'Connect to FTP failed.'
		li_rtn = -50 + i 
		lb_stop = true
	Else
		//Send File
		ls_rpath = '\Incoming\'
		i = lnv_ftp.of_putfile(ls_file_fullname, ls_rpath)
		If i < 0 Then 
			li_rtn= -60 + i 
			lb_stop = true
			is_errtext = 'Send file ' +ls_file_fullname+ ' failed.'
		End If
		
		//Disconnect
		lnv_ftp.of_disconnect()
	End If
	Destroy lnv_ftp
End If

//End Transaction
If i < 0 Then
	Rollback using sqlca;
Else
	Commit Using sqlca;
End If

sqlca.autocommit = true

as_errtext = is_errtext

Return li_rtn
end function

public function integer of_create_file (ref string as_file_nm, long al_file_id);//====================================================================
//$<Function>: of_create_file
//$<Arguments>:
// 	value    string        as_file_nm
// 	value    long    al_file_id
//$<Return>:  integer
//$<Description>: Create Roster Submission File.
//$<Author>: (Appeon) long.zhang 05.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_lines[]
String ls_columns[]
String ls_value
String ls_write_path, ls_file_name
Int li_column_cnt, i , j
integer li_write
n_cst_string lnv_string
Datastore ldw_source

ldw_source = create datastore
ldw_source.dataobject = 'd_caqh_roster_submit_browse'
ldw_source.settransobject(sqlca)
i = ldw_source.retrieve(al_file_id)

If i < 1 Then 
	is_errtext = 'No record of file id ' +string(al_file_id)+' found.'
	Destroy ldw_source
	Return -1
End If

//Head
ls_columns[] = is_field_names[]
i = lnv_string.of_arraytostring(ls_columns[], '|', ls_lines[1])
//ls_lines[1] = 'Action_Flag|Provider_First_Name|Provider_Middle_Name|Provider_Last_Name|Provider_Name_Suffix|Provider_Gender|Provider_Address1|Provider_Address2|Provider_Address_City|Provider_Address_State|Provider_Address_Zip|Provider_Address_Zip_Extn|Provider_Phone|Provider_Fax|Provider_Email|Provider_Practice_State|Provider_Birthdate|Provider_SSN|Short_SSN|Provider_DEA|Provider_UPIN|Provider_Type|Provider_Tax_ID|Provider_NPI|Provider_License_State|Provider_License_Number|CAQH_Provider_ID|PO_Provider_ID|Last_Recredential_Date|Next_Recredential_Date|Delegation_Flag|Application_Type|Affiliation_Flag|Organization_ID|Region_ID'

//Row Loop
li_column_cnt = UpperBound(ls_columns[])
For i = 1 to ldw_source.rowcount()
	//Get Value
	For j = 1 to li_column_cnt
		ls_value = ldw_source.GetItemString(i, ls_columns[j])
		ls_value = Trim(ls_value)
		If IsNull(ls_value) Then ls_value = ''
		
		If j = li_column_cnt Then //Last Column
			ls_lines[i + 1] += ls_value
		Else
			ls_lines[i + 1] += ls_value + '|'
		End If
	Next
Next
Destroy ldw_source

//Create caqh folder
ls_write_path = gs_temp_path + "caqh"
if DirectoryExists ( ls_write_path ) = false then
	i = CreateDirectory ( ls_write_path )
	if i = -1 then
		is_errtext = "Unable to create the file directory:" + ls_write_path
		return -2
	end if
end if

//FileOpen
ls_file_name = ls_write_path +  "\" + as_file_nm
li_write = FileOpen (ls_file_name, LineMode!, Write!, LockWrite!, Replace!)
If li_write < 0 Then
	is_errtext = "Unable to open the file:" + ls_file_name
	return -3
End If

//FileWrite
For i = 1 to UpperBound(ls_lines[])
	j = FileWrite ( li_write, ls_lines[i])
	If j < 0 Then
		FileClose(li_write)
		is_errtext = "Unable to write the file:" + ls_file_name
		return -4
	End If
Next

FileClose(li_write)

as_file_nm = ls_file_name

return 1
end function

public function integer of_match_exception (ref datastore ads_exception);//====================================================================
//$<Function>: of_match_exception
//$<Arguments>:
// 	reference    datastore    ads_exception
//$<Return>:  integer
//				0:No record to match
//				-1:Retrieve lds_match error
//				-2:lds_match.Update error
//				1.success
//$<Description>: Match Exception file data with Submission file, save to caqh_roster_files table.
//$<Author>: (Appeon) long.zhang 07.10.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long i
Long ll_cnt
Long ll_find = 0
Long ll_submit_file_id
Long ll_exception_id_cur
Long ll_exception_id_last
String ls_filenm_cur
String ls_filenm_last
boolean lb_same = false

Datastore lds_match

lds_match = Create datastore
lds_match.dataobject = 'd_caqh_roster_exception_match'
lds_match.SetTransObject(SQLCA);

i = lds_match.Retrieve()
If i = 0 Then //No record to match
	Destroy lds_match
	Return 0
ElseIf i < 0 Then //Error
	Destroy lds_match
	Return -1
End If

ads_exception.SetSort('Roster_file_name asc, file_id asc')
ads_exception.Sort()

ll_cnt = ads_exception.RowCount()
For i = 1 to ll_cnt
	//file id(PK) and file name
	ll_exception_id_cur = ads_exception.GetItemNumber(i, 'file_id')
	ls_filenm_cur = ads_exception.GetItemString(i, 'Roster_file_name')
	
	//Reduce find times
	If (ll_exception_id_cur = ll_exception_id_last) And  (ls_filenm_cur = ls_filenm_last) Then
		lb_same = True //already matched
	Else
		lb_same = False
		//Find the submission file in caqh_roster_file table
		ll_find = lds_match.Find("file_name = '" + ls_filenm_cur + "'", 1, lds_match.RowCount() )
	End If
		
	If ll_find > 0 Then
		//Submission file id
		ll_submit_file_id = lds_match.GetItemNumber(ll_find, 'file_id')
		
		//Set caqh_roster_exception.submit_file_id
		ads_exception.SetItem(i, 'submit_file_id', ll_submit_file_id)
		
		//Update caqh_roster_files
		If Not lb_same Then
			lds_match.SetItem(ll_find, 'exception_status', 'Y')
			lds_match.SetItem(ll_find, 'exception_file_id', ll_exception_id_cur)
			
			//Remember 2 last values for next loop
			ll_exception_id_last = ll_exception_id_cur
			ls_filenm_last = ls_filenm_cur	
		End If
	End If
Next

//Update caqh_roster_files table
i = lds_match.Update()
Destroy lds_match

If i = -1 Then 
	Return -2
Else
	Return 1
End If

	
end function

public function long of_get_max_roster_id ();//====================================================================
//$<Function>: of_get_max_roster_id
//$<Arguments>:
//$<Return>:  long
//$<Description>: Get max Return Roster file id by  caqh_roster_files.
//$<Author>: (Appeon) long.zhang 05.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_file_id
select max(file_id) into :ll_file_id from caqh_roster_files where file_type = 'R' using sqlca;
If sqlca.sqlcode = 0 Then
	If Not(ll_file_id>0) Then ll_file_id = 0
Else
	ll_file_id = 0
End If

return ll_file_id


end function

public function integer of_check_layout_row (datawindow adw, long al_row, boolean ab_scroll2error);//====================================================================
//$<Function>: of_check_layout_row
//$<Arguments>:
// 	value    datawindow    adw
// 	value    long          al_row
//	value	boolean	ab_scroll2error true:scroll to the error column. false:do not scroll.
//$<Return>:  integer
//$<Description>: Check layout for one row in a datawindow.
//$<Author>: (Appeon) long.zhang 06.04.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_cnt
Int i
Int j
Int li_end
Int li_scroll = 0
Int li_current_row
String ls_err
Boolean lb_field_err = false
DwItemStatus le_dwItemStatus

If al_row < 1 Then
	return -1
End If

//Don't change row
li_current_row = adw.getrow()

//Check data
li_end = UpperBound(is_field_names[])
i = al_row
lb_field_err = false
For j = 1 to li_end //Columns. 
	ls_err = of_check_layout_field(adw, i, (j + 2) ) //Don't check 2 fields (file_id and roster_record_number) .
	If LenA(ls_err) > 0 Then 
		lb_field_err = true
		If li_scroll = 0 Then li_scroll = j + 2
	End If
Next

//Show row error flag
le_dwItemStatus = adw.GetItemStatus(al_row, 0, Primary!) 

If lb_field_err = true Then
	If adw.describe('err_flag.coltype')<>'!' Then  adw.setitem(i, 'err_flag',1)
Else
	If adw.describe('err_flag.coltype')<>'!' Then  adw.setitem(i, 'err_flag',0)
End If

//Don't change row
If adw.getrow() <> li_current_row Then adw.SetRow(li_current_row)

//Reset Modify status
If le_dwItemStatus <>  adw.GetItemStatus(al_row, 0, Primary!)  Then adw.SetItemStatus ( al_row, 0, Primary!, le_dwItemStatus )

If lb_field_err = true Then 
	//scroll to error column
	If ab_scroll2error Then
		adw.SetColumn(li_scroll)
	End If
	
	Return -1
End If

Return 1
end function

public subroutine of_delete_returnroster ();//====================================================================
//$<Function>: of_delete_returnroster
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Only save 10 return roster files in database.   (This function has not been used till now).
//$<Author>: (Appeon) long.zhang 05.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Delete old record from caqh_roster_list
Delete from caqh_roster_list where 
file_id < (select min(file_id) from
(select top 10 file_id from caqh_roster_files where file_type = 'R'
order by file_id desc) b);

//Delete old record from caqh_roster_files
Delete from caqh_roster_files where 
file_id < (select min(file_id) from
(select top 10 file_id from caqh_roster_files where file_type = 'R'
order by file_id desc) b);

end subroutine

public function integer of_get_len_max (string as_value);//====================================================================
//$<Function>: of_get_len_max()
//$<Arguments>:
// 	value    string    as_value
//$<Return>:  integer
//$<Description>:Get max length from values 'display1~tdata1/display2~tdata2/display3~tdata3.../displayX~tdataX'
//						used in of_modify_dw_detail().
//$<Author>: (Appeon) long.zhang 09.30.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int li_max = 0
long ll_pos_start, ll_pos_end
String ls_tmp

If LenA(as_value) = 0 Then Return 0

//Multi values
If LeftA(as_value, 1) <>'/' Then as_value='/' + as_value
ll_pos_start = 1
Do while (ll_pos_start > 0) 
	ll_pos_end = 	PosA(as_value, '~~t', ll_pos_start)
	
	If (ll_pos_end - ll_pos_start - 1) >li_max Then
		li_max = (ll_pos_end - ll_pos_start - 1)
	End If
	
	ll_pos_start = PosA(as_value, '/', ll_pos_end)
Loop

Return li_max


end function

public function integer of_fix_na (datawindow adw);//====================================================================
//$<Function>: of_fix_na
//$<Arguments>:
// 	value    datawindow    adw
//$<Return>:  integer
//$<Description>: Fix [Not Applicable] columns for current row.
//$<Author>: (Appeon) long.zhang 10.12.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int i
Long ll_curr_row
String ls_err_nm
Boolean lb_set = False

ll_curr_row = adw.GetRow()
If ll_curr_row <1 Then Return 0

For i = 1 to Upperbound(is_field_names[] )
	ls_err_nm = "t_err_" + string(i)
	If adw.Describe(ls_err_nm +".text") = '[Not Applicable]' Then
		adw.SetItem(ll_curr_row, is_field_names[i], '')
		lb_set = True
	End If
Next

//Check Again
If lb_set Then This.of_check_layout_row(adw, ll_curr_row)

Return 1
end function

public function integer of_zip2txt (ref string as_zipfile);//====================================================================
//$<Function>: of_zip2txt
//$<Arguments>:
// 	reference    string    as_zipfile
//$<Return>:  integer 0: not .zip/ -1: Not exist zip file/ -2: timeout / -3: error / 1: successful.
//$<Description>: open zip file for CAQH ReturnRoster File
//$<Author>: (Appeon) long.zhang 10.23.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer r
Int i = 0
string ls_current_dir
String ls_txt_name
n_cst_datetime lnv_dt

If RightA(as_zipfile, 4) <> '.zip' Then Return 0

ls_current_dir = GetCurrentDirectory()

If  fileexists(as_zipfile) Then
	ChangeDirectory(gs_dllocx_path) 
	r = run("7z e " + as_zipfile + " -o" +gs_temp_path + "CAQH\"  , Minimized!)	
	
	ls_txt_name = LeftA(as_zipfile ,LenA(as_zipfile) - 3) + 'txt'

	//Wait 30 second at most
	Do while (Not fileexists(ls_txt_name) and i <31)
		lnv_dt.of_wait(1)
		i++
	Loop
	
	If fileexists(ls_txt_name) Then 
		as_zipfile = ls_txt_name
		r = 1
	ElseIf i = 31 Then
		r = -2  //Timeout
	Else		
		r = -3
	End If
Else
	r = -1
End If	

//if r = -1 then 
	//messagebox("Unzip failed","Unable to run the unzip function.  May be a permission issue.  Please run manually.")
	//run("explorer.exe /n,/e," + gs_temp_path + "oig\")
//end if

ChangeDirectory(ls_current_dir)

Return r
end function

on n_cst_caqh_roster_maha.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_caqh_roster_maha.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i
Int li_pos
String ls_temp

//Get Settings
ids_setting = create datastore
ids_setting.dataobject = 'd_caqh_roster_setting'
ids_setting.settransobject(sqlca)

of_refresh_settings() //retrieve ids_setting and set related instance variables.

//Get Layout rulers, settings are directly stored in d_caqh_roster_set_layout
datastore lds_layout_setting
lds_layout_setting = Create datastore
lds_layout_setting.dataobject = 'd_caqh_roster_set_layout'
For i = 1 to lds_layout_setting.rowcount()
	is_field_names[i] = lds_layout_setting.getitemstring(i, 'value_2')
	//format
	ls_temp = Upper(lds_layout_setting.getitemstring(i, 'value_3'))
	li_pos = PosA(ls_temp,'#')
	If li_pos > 0 Then
		is_formats[i] = LeftA(ls_temp, li_pos - 1)
		 is_matchs[i] = MidA(ls_temp, li_pos + 1)
	Else
		is_formats[i]= ls_temp
		is_matchs[i] = ''
	End If
	ii_maxsizes[i] = Integer(lds_layout_setting.getitemstring(i, 'value_4'))
	is_descriptions[i] =  lds_layout_setting.getitemstring(i, 'description')
	is_expressions[i] =  lds_layout_setting.getitemstring(i, 'expression')
Next
Destroy lds_layout_setting

//Used to save log to table:caqh_roster_files
ids_files_save = create datastore
ids_files_save.dataobject = 'd_caqh_roster_files_save'
ids_files_save.settransobject(sqlca)





end event

event destructor;//====================================================================
//$<Event>: destructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Destroy ids_setting
Destroy ids_files_save
end event

