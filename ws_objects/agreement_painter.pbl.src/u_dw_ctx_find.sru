$PBExportHeader$u_dw_ctx_find.sru
forward
global type u_dw_ctx_find from u_dw
end type
end forward

global type u_dw_ctx_find from u_dw
integer width = 2857
integer height = 724
string dataobject = "d_agreement_template_clause_rules"
event ue_init_field_dddw ( string as_syntax,  integer ai_view_id,  long al_screen_id,  ref datawindowchild adwc_field,  ref datawindow adw_1 )
event type long ue_init_screen_dddw ( integer ai_viewid )
event ue_reset_calendar_flag ( )
end type
global u_dw_ctx_find u_dw_ctx_find

type prototypes
//Added By Mark Lee 07/12/12
SUBROUTINE GetClientRect (ULONG hClntWnd, REF STR_CLIENT_RECT lpRect) LIBRARY "USER32.DLL" alias for "GetClientRect;Ansi" 
end prototypes

type variables
datawindowchild idwc_screen, idwc_field
protected long il_prezoom	//Added By Mark Lee 07/12/12
end variables

forward prototypes
public function boolean of_verify_syntax_logical ()
public function string of_parse_bracket (string as_string, string as_operation)
public function string of_get_lookupdesc_multi (string as_lookup_code)
public function long of_init_screen_dddw (long al_view_id, long al_screen_id[])
public function string of_get_companyname_multi (string as_company_id)
public subroutine of_resize ()
end prototypes

event ue_init_field_dddw(string as_syntax, integer ai_view_id, long al_screen_id, ref datawindowchild adwc_field, ref datawindow adw_1);integer li_count, li_i, ll_row  
string ls_name, ls_text, ls_error, ls_coltype, ls_tablename, ls_DbName
string ls_tab_name, ls_dw_name[], ls_dataobject[]
datawindow ldw[] 
string ls_dddwname

Setredraw(false)

adwc_field.Reset() //Alfee 03.26.2008

ls_tab_name = gnv_data.of_get_table_name( al_screen_id, 'C', 'tab_name')
ldw[1] = adw_1
ls_dw_name[1] 	= gnv_data.of_get_table_name( al_screen_id, 'C', 'dw_name')
ls_dataobject[1] 	= gnv_data.of_get_table_name( al_screen_id, 'C', 'dataobject')

f_create_contract_dw(ai_view_id,ls_tab_name,ldw,ls_dw_name,ls_dataobject) 

adw_1.visible = false
li_count  = integer(adw_1.Describe("DataWindow.Column.Count"))

If li_count > 0  Then
	//ls_tablename = adw_1.Object.DataWindow.Table.UpdateTable		//Commented by Scofield on 2007-09-18
	
	For li_i = 1 to li_count
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modified> 2007-05-16 By: Wu ZhiJun
		//$<reason> Fix a bug
		ls_name = adw_1.Describe("#"+string(li_i) + ".name")

		ls_DbName = adw_1.Describe("#"+string(li_i) + ".dbName")
		if Pos(ls_DbName,".") <= 0 then continue
		ls_tablename = Left(ls_DbName,Pos(ls_DbName,".") - 1)
		
		ls_name = mid(ls_DbName,Pos(ls_DbName,".") + 1)  //Added By Ken.Guo 2009-07-15.

		//Added By Ken.Guo 2009-07-15. Add Special Fields.
		If (al_screen_id = 13 and Lower(ls_name) = 'field_value') or &
			(al_screen_id = 13 and Lower(ls_name) = 'rqmnt_name') or &
			(al_screen_id = 13 and Lower(ls_name) = 'category_name')	Then
			//Do
		Else
			If long(adw_1.describe(ls_name + ".y")) > long(adw_1.describe("datawindow.detail.height")) Then 
				Continue
			End If
			If long(adw_1.describe(ls_name + ".visible")) = 0 then 
				continue
			End If			
		End If
		

		//--------------------------- APPEON END -----------------------------
		
		//---------------Begin Added by Alfee 01.03.2007----------------------
		//<$Reason>Skip the invalid columns in table of 'ctx_basic_info'
		IF lower(ls_tablename) = 'ctx_basic_info' and (lower(ls_name) = 'product_name' OR lower(ls_name) = 'product_type') THEN 
			Continue
		END IF
		//---------------End Added --------------------------------------------
		
		ll_row = adwc_field.InsertRow(0)
		
		adwc_field.SetItem(ll_row,"data_view_screen_screen_id",al_screen_id)
		
		adwc_field.SetItem(ll_row,"sys_fields_field_name",ls_name)
		
		ls_text = adw_1.Describe( ls_name + "_t.text")
		if ls_text = "?" or ls_text = "!" then ls_text = ""
		if ls_text = '' then ls_text = ls_name

		//Added By Ken.Guo 2009-07-15. Assign text value for the special fields.
		If al_screen_id = 13 Then
			Choose Case  Lower(ls_name) 
				Case 'field_value'
					ls_text = adw_1.Describe( "t_1.text")
					If ls_text = "?" or ls_text = "!" Then ls_text = ""
					If ls_text = '' Then ls_text = 'Value'
				Case 'rqmnt_name'
					ls_text = 'Profile Name'
				Case 'category_name'
					ls_text = 'Category Name'
				Case 'element_name'
					ls_text = 'Requirement Name'
			End Choose
		End If
		
		//Use specail DDDW
		If (al_screen_id = 13 and ( Lower(ls_name) = 'rqmnt_name' or Lower(ls_name) = 'category_name' or Lower(ls_name) = 'element_name') ) Then
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","O")
		End If
		
		adwc_field.SetItem(ll_row,"data_view_fields_field_label",ls_text)
		adwc_field.SetItem(ll_row,"data_view_fields_field_order",ll_row)
		
		ls_coltype = adw_1.Describe("#"+string(li_i) + ".coltype")
		Choose Case Left ( ls_coltype , 5 )
			Case "char(", "char"
				adwc_field.SetItem(ll_row,"sys_fields_field_type",'C')
			Case "date"	,"datet"	,"time", "times"
				adwc_field.SetItem(ll_row,"sys_fields_field_type",'D')
			Case "decim","numbe", "doubl", "real","long", "ulong", "int"
				adwc_field.SetItem(ll_row,"sys_fields_field_type",'N')
		End Choose
		
		adwc_field.SetItem(ll_row,"table_name",ls_tablename)
		
		//modify 08/28/2007 by: Andy
		ls_dddwname = adw_1.Describe(ls_name+".dddw.name")	//Jervis 12.15.2009
		//if adw_1.Describe(ls_name+".dddw.name") = "d_dddw_code_lookup" then
		if ls_dddwname = "d_dddw_code_lookup" or ls_dddwname = "dddw_dm_category" then
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","C")
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field","Y")
			adwc_field.SetItem(ll_row,"sys_fields_lookup_code",adw_1.Describe(ls_name+".tag"))
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field_name","Code")
		elseif ls_dddwname = 'd_dddw_company' or ls_dddwname = 'd_dddw_company_list'   then	//Company dddw-jervis 12.15.2009
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","P")
			//adwc_field.SetItem(ll_row,"sys_fields_lookup_field","Y")
			adwc_field.SetItem(ll_row,"sys_fields_lookup_code",adw_1.Describe(ls_name+".tag"))
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field_name","falicity_id")
		elseif ls_dddwname = 'd_dddw_users' then	//users dddw -- jervis 12.15.2009
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","U")
			//adwc_field.SetItem(ll_row,"sys_fields_lookup_field","Y")
			//adwc_field.SetItem(ll_row,"sys_fields_lookup_code",adw_screen.Describe(ls_colname+".tag"))
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field_name","user_id")			
		end if
		
		//Set with DDDW
		Choose Case al_screen_id
			Case 13 //Requirement Profile
				Choose Case Lower(ls_name) 
					Case 'ctx_req_profile_id','ctx_rqmnt_category_id'
						
				End Choose
		End Choose

		
	Next
Else
	of_MessageBox ("ue_init_field_dddw", gnv_app.iapp_object.DisplayName, &
						"The DDDW of Field Data Retrieve failed!", information!, Ok!, 1)
End if

Setredraw(true)


end event

event type long ue_init_screen_dddw(integer ai_viewid);//Added by Alfee on 02.20.2008
long ll_count

if ai_viewid = 0 then ai_viewid = 1001		//Added by Scofield on 2010-01-20

//initilize the DDDW
ll_count = idwc_screen.Retrieve(ai_viewid) 

//---------Begin Added by Alfee 01.03.2007--------------
//<$Reason>Filter the screens with external data source
Long i, ll_cnt, ll_screen_id[]
String ls_filter, ls_screen_name[] 

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2009-07-17 By: Ken.Guo
//$<reason> use screen id filter data.
//ls_screen_name[1] = "Search->Contract Browse"
//ls_screen_name[2] = "Details->Linked Contracts Tab->Linked Contracts"
//ls_screen_name[3] = "Document Manager->Work Flow Tab->Search Criteria"
//ls_screen_name[4] = "Document Manager->Audit Trail Tab->Search Criteria"
//ls_screen_name[5] = "Requirements->Profile Selection"
//ll_cnt = UpperBound(ls_screen_name) 
//FOR i = 1 to ll_cnt
//	ls_filter = ls_filter + "'" + ls_screen_name[i] + "'"	
//	IF i < ll_cnt THEN ls_filter += ", "
//NEXT
//IF Len(ls_filter) > 0 THEN ls_filter = "screen_name not in (" + ls_filter + ")"

ll_screen_id[1] = 1		//"Search->Contract Browse"
ll_screen_id[2] = 2		//Search->Contract Browse
ll_screen_id[3] = 11		//"Requirements->Profile Selection"
ll_screen_id[4] = 12		//"Requirements->Profile detail"
ll_screen_id[5] = 14		//Other Contacts->Contacts List
ll_screen_id[6] = 15		//Other Contacts->Contract Details
ll_screen_id[7] = 16		//Other Contacts->Contract Information
ll_screen_id[8] = 17		//Other Contacts->Contract Notes
ll_screen_id[9] = 34		//QRG->Select Data Tab->Report Profiles
ll_screen_id[10] = 35	//QRG->Select Data Tab->Basic Information to Include
ll_screen_id[11] = 36	//QRG->Select Data Tab->Contract Contact Information to Include
ll_screen_id[12] = 37	//QRG->Select Data Tab->Precertifications Requirements
ll_screen_id[13] = 38	//QRG->Select Data Tab->Authorizations Requirements
ll_screen_id[14] = 39	//QRG->Select Data Tab->Fee Schedule Data to Include
ll_screen_id[15] = 40	//QRG->Select Data Tab->Organization Types to Include
ll_screen_id[16] = 41	//QRG->Select Data Tab->Requirements to Include
ll_screen_id[17] = 45	//Document Manager->Work Flow Tab->Search Criteria
ll_screen_id[18] = 46	//Document Manager->Work Flow Tab->Action Item Browse
ll_screen_id[19] = 47	//Document Manager->Work Flow Tab->Action Item Detail
ll_screen_id[20] = 48	//Document Manager->Audit Trail Tab->Search Criteria
ll_screen_id[21] = 49	//Document Manager->Audit Trail Tab->Document Browse
ll_screen_id[22] = 49	//Document Manager->Audit Trail Tab->Document Browse

For i  = 1 To UpperBound(ll_screen_id[])
	ls_filter += String(ll_screen_id[i])
	If i < UpperBound(ll_screen_id[]) Then ls_filter += ','
Next
If Len(ls_filter) > 0 Then ls_filter = "Screen_id Not In (" + ls_filter + ")"
//---------------------------- APPEON END ----------------------------

idwc_screen.SetFilter(ls_filter)
idwc_screen.Filter()

ll_count = idwc_screen.RowCount()
//---------End Added ------------------------------------		
		
if ll_count < 1 then
	ll_count = idwc_screen.InsertRow(0)
end if

return ll_count

end event

event ue_reset_calendar_flag();//====================================================================
// Function: ue_reset_calendar_flag
//--------------------------------------------------------------------
// Description: copy from u_dw_contract
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/12/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.06.2006 By: LeiWei
//$<reason> Fix a defect.
//$<modification> Set variables of iuo_calendar to NULL when this datawindow is re-created.

If isvalid(iuo_Calendar) Then
	iuo_Calendar.of_reset_flag( )
End If

//Added By Mark Lee 07/12/12
//ib_enable_columns = TRUE
//ib_read_only = FALSE

//$<add> 09.18.2006 By: LeiWei
//$<reason> The X button should be disabled on all datawindow title bars.
This.Controlmenu = False

//---------------------------- APPEON END ----------------------------

//Reset prezoom when re-create dw
il_prezoom = 0

//Start Code By Jervis 04.17.2008
//Move to of_resize()
of_resize()		

end event

public function boolean of_verify_syntax_logical ();Integer li_rtn
Long ll_cnt, i
String ls_left_bracket, ls_right_bracket, ls_logical, ls_rules
	
ll_cnt = This.RowCount()	
IF ll_cnt < 1 THEN RETURN TRUE

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

FOR i = 1 to ll_cnt 
	ls_left_bracket = This.GetItemString( i , 'left_bracket')
	ls_right_bracket= This.GetItemString( i , 'right_bracket')
	ls_logical 		 = This.GetItemString( i , 'logical')
	IF IsNull(ls_left_bracket) THEN ls_left_bracket = ""
	IF IsNull(ls_right_bracket) THEN ls_right_bracket = ""
		
	ls_rules = ls_rules + ls_left_bracket + "1=1" + ls_right_bracket 
	IF i <> ll_cnt THEN ls_rules = " " + ls_rules + ls_logical + " "	
NEXT

ls_rules = "Select count(*) from ctx_basic_info where ctx_id = 1 and (" + ls_rules + ");"

//Execute the sql statement to get the result
PREPARE SQLSA FROM :ls_rules Using SQLCA ;
OPEN DYNAMIC my_cursor ;
FETCH my_cursor INTO :li_rtn ;
IF SQLCA.SQLCODE = -1 THEN li_rtn = -1	//If any SQL error return -1	
CLOSE my_cursor ;

IF li_rtn = -1 THEN RETURN FALSE

RETURN TRUE
end function

public function string of_parse_bracket (string as_string, string as_operation);//Add or remove the bracket - Alfee 07.25.2008
String ls_string

IF IsNULL(as_string) OR Len(Trim(as_string)) < 1 THEN RETURN ""

ls_string = Trim(as_string)

CHOOSE CASE Upper(as_operation)
	CASE 'ADD'
		IF Left(ls_string, 1) <> "(" THEN ls_string = "(" + ls_string
		IF Right(ls_string, 1) <> ")" THEN ls_string = ls_string + ")"			
	CASE 'REMOVE'
		IF Left(ls_string, 1) = "(" THEN ls_string = Mid(ls_string, 2)
		IF Right(ls_string, 1) = ")" THEN ls_string = Left(ls_string, Len(ls_string) -1 )
END CHOOSE


RETURN ls_string
end function

public function string of_get_lookupdesc_multi (string as_lookup_code);//Get lookup names based on lookup codes - Alfee 07.25.2008
Long i, ll_cnt
string ls_desc, ls_temp, ls_lookupcode[]
n_cst_string lnv_string

IF IsNull(as_lookup_code) OR LEN(TRIM(as_lookup_code)) < 1 THEN RETURN ""

lnv_string.of_parsetoarray(as_lookup_code, ",", ls_lookupcode)

FOR i = 1 to UpperBound(ls_lookupcode)
	ls_temp = gnv_data.of_GetItem("code_lookup","code","lookup_code = " + ls_lookupcode[i])
	IF IsNull(ls_temp) OR Len(Trim(ls_temp)) < 1 THEN CONTINUE
	IF Len(Trim(ls_desc)) < 1 THEN
		ls_desc = '"' + ls_temp + '"'
	ELSE
		ls_desc += ', "' + ls_temp + '"'
	END IF
NEXT

RETURN ls_desc
end function

public function long of_init_screen_dddw (long al_view_id, long al_screen_id[]);//====================================================================
// Function: of_init_screen_dddw()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_view_id
// 	value    long    al_screen_id[]
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-07-17
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Count,ll_Cycle,ll_ScreenCnts
String	ls_filter

ll_ScreenCnts = UpperBound(al_screen_id)
for ll_Cycle = 1 to ll_ScreenCnts
	ls_filter = ls_filter + String(al_screen_id[ll_Cycle]) + ","
next

if Right(ls_filter,1) = "," then
	ls_filter = "screen_id in (" + Left(ls_filter,Len(ls_filter) - 1) + ")"
end if

idwc_screen.SetFilter(ls_filter)

ll_Count = idwc_screen.Retrieve(al_view_id)

if ll_Count < 1 then
	ll_Count = idwc_screen.InsertRow(0)
end if

Return ll_Count

end function

public function string of_get_companyname_multi (string as_company_id);//Get lookup names based on lookup codes - Alfee 07.25.2008
Long i, ll_cnt
string ls_desc, ls_temp, ls_lookupcode[]
n_cst_string lnv_string

IF IsNull(as_company_id) OR LEN(TRIM(as_company_id)) < 1 THEN RETURN ""

lnv_string.of_parsetoarray(as_company_id, ",", ls_lookupcode)

FOR i = 1 to UpperBound(ls_lookupcode)
	ls_temp = gnv_data.of_getItem("ctx_facility","facility_name","facility_id = " + ls_lookupcode[i])
	IF IsNull(ls_temp) OR Len(Trim(ls_temp)) < 1 THEN CONTINUE
	IF Len(Trim(ls_desc)) < 1 THEN
		ls_desc = '"' + ls_temp + '"'
	ELSE
		ls_desc += ', "' + ls_temp + '"'
	END IF
NEXT

RETURN ls_desc
end function

public subroutine of_resize ();//====================================================================
// Function: 
//--------------------------------------------------------------------
// Description: copy from u_dw_contract
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/12/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
If gb_autozoom Then  //modified by gavins 20130107    gb_autoresize
	If this.dataobject = 'd_dm_new_buy_document' or this.dataobject = 'd_dm_new_sell_document' Then Return
	
	datawindowchild ldw_child
	long li_height,li_width,li_zoom,ll_count,ll_i
	string ls_column_name
	string ls_desc2
	
	str_client_rect lstr_client_rect  
	
	if not IsValid(iw_parent) then of_GetParentWindow(iw_parent) //Add by Evan 11/26/2008
	GetClientRect(handle(iw_parent),lstr_client_rect)	
	
	li_width = pixelstoUnits(lstr_client_rect.right,XPixelsToUnits!)
	
	//li_zoom =  li_width / 2800 * 100
	
	// start code change --- 11.23.2005 MSKINNER
	li_zoom =  round(li_width / 3936 * 100,1) //4000->3936 By Jervis 11-21-2008
	// start code change --- 11.23.2005 MSKINNER
	
	//$<add> 11.07.2006 By: Davis
	//$<reason> Fix a defect.
	Long li_zoom2
	li_height = pixelstoUnits(lstr_client_rect.bottom,YPixelsToUnits!)
	li_zoom2 = round(li_height / 2152 * 100,1) //2000->2152 By Jervis 11-21-2008
	IF li_zoom > li_zoom2 THEN li_zoom = li_zoom2
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 12.03.2008 By: Ken.Guo
	//$<reason> Workaround for APB Bug. Trigger Resize event too many times.
	if Abs(il_prezoom - li_zoom) < 2 then 
		return
	End If
	//Added By Mark Lee 07/12/12
	If this.dataobject = 'd_agreement_template_clause_rules' and li_zoom < 100 Then
		li_zoom = 100
	End If
	il_prezoom = li_zoom
	
	This.dynamic function of_setzoomtriggered(true) //Added By Ken.Guo 12/13/2011. 
	this.Modify("datawindow.zoom = " + String(li_zoom))
	This.dynamic function of_setzoomtriggered(false) //Added By Ken.Guo 12/13/2011. 
	
	// loop through the columns and see if it a DDDW and zoom it as well
	//BEGIN---Modify by Evan on 06/12/2008
	integer li_ColCount
	li_ColCount = Integer(this.Describe("dataWindow.column.count"))
	//for ll_i = 1 to long(this.Object.DataWindow.Column.Count)
	for ll_i = 1 to li_ColCount //END---Modify by Evan on 06/12/2008
		ls_column_name = "#" + string(ll_i) + ".name"
		ls_desc2 = this.Describe("#" + string(ll_i) + ".name") + ".Edit.Style"
		
		if this.Describe(ls_desc2) = 'dddw' then
			this.GetChild( this.Describe(ls_column_name), ldw_child )
			ldw_child.Modify('datawindow.zoom=' + string(li_zoom))
		end if
	next
End If
end subroutine

on u_dw_ctx_find.create
call super::create
end on

on u_dw_ctx_find.destroy
call super::destroy
end on

event itemchanged;call super::itemchanged;long ll_row, i
string ls_null

SetNull(ls_null)
Choose Case dwo.name
	Case "screen_id"
		//Clear field_name data
		this.SetItem(row,"field_label",ls_null)
		this.SetItem(row,"field_name",ls_null)
		this.SetItem(row,"lookup_flag",ls_null)
		this.SetItem(row,"lookup_code",ls_null)
		this.SetItem(row,"value",this.GetItemString(row,"value_display"))
		//Reset the field dddw 
		IF Lower(dwo.name) = 'screen_id' THEN idwc_field.Reset()		
	Case "field_label"
		ll_row = idwc_field.GetRow()			
		this.SetItem(row,"field_name",idwc_field.GetItemString(ll_row,"sys_fields_field_name"))
		this.SetItem(row,"field_type",idwc_field.GetItemString(ll_row,"sys_fields_field_type"))
		this.SetItem(row,"table_name",idwc_field.GetItemString(ll_row,"table_name"))	
		//Set for code lookup field
		if idwc_field.GetItemString(ll_row,"sys_fields_lookup_type") = 'C' and idwc_field.GetItemString(ll_row,"sys_fields_lookup_field") = 'Y' and idwc_field.GetItemString(ll_row,"sys_fields_lookup_field_name") = 'Code' then
			this.SetItem(row,"lookup_flag","Y")
			this.SetItem(row,"lookup_code",idwc_field.GetItemString(ll_row,"sys_fields_lookup_code"))
			this.SetItem(row,"value",ls_null)
			this.SetItem(row,"value_display",ls_null)
		elseif idwc_field.GetItemString(ll_row,"sys_fields_lookup_type") = 'P' then	//Company dddw-jervis 12.15.2009
			this.SetItem(row,"lookup_flag","P")
			this.SetItem(row,"lookup_code",idwc_field.GetItemString(ll_row,"sys_fields_lookup_code"))
			this.SetItem(row,"value",ls_null)
			this.SetItem(row,"value_display",ls_null)
		elseif idwc_field.GetItemString(ll_row,"sys_fields_lookup_type") = 'U' then	//user dddw - jervis 12.15.2009
			this.SetItem(row,"lookup_flag","U")
			this.SetItem(row,"lookup_code",ls_null)
			this.SetItem(row,"value",ls_null)
			this.SetItem(row,"value_display",ls_null)
		elseIf idwc_field.GetItemString(ll_row,"sys_fields_lookup_type") = 'O' Then 
			//Added By Ken.Guo 2009-07-16. For Other DDDW
			this.SetItem(row,"lookup_flag","Y")
			this.SetItem(row,"value",ls_null)
			this.SetItem(row,"value_display",ls_null)
			this.SetItem(row,"lookup_code",ls_null)
		Else
			this.SetItem(row,"lookup_flag",ls_null)
			this.SetItem(row,"lookup_code",ls_null)
			this.SetItem(row,"value",this.GetItemString(row,"value_display"))
		end if
	case "value_display"
		this.SetItem(row,"value",data)
	case "left_bracket"
		IF Len(data) > 0 THEN
			FOR i = 1 to Len(data)			
				IF Mid(data, i, i) <> "(" and Mid(data, i, i) <> " " THEN 
					MessageBox("Alert", "Invalid input in the bracket field!")
					This.SetItem( row, "left_bracket", "")
					This.SetColumn( "left_bracket" )					
					EXIT
				END IF
			NEXT
		END IF
	case "right_bracket"
		IF Len(data) > 0 THEN
			FOR i = 1 to Len(data)			
				IF Mid(data, i, i) <> ")" and Mid(data, i, i) <> " " THEN 
					MessageBox("Alert", "Invalid input in the bracket field!")
					This.SetItem( row, "right_bracket", "")
					This.SetColumn( "right_bracket" )					
					EXIT
				END IF
			NEXT
		END IF
End Choose


end event

event pfc_retrievedddw;call super::pfc_retrievedddw;//Moved to ue_init_screen_dddw - Alfee 02.20.2008
/*
long ll_count

//initilize the DDDW
ll_count = idwc_screen.Retrieve(integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'")))

//---------Begin Added by Alfee 01.03.2007--------------
//<$Reason>Filter the screens with external data source
Long i, ll_cnt
String ls_filter, ls_screen_name[] 

ls_screen_name[1] = "Search->Contract Browse"
ls_screen_name[2] = "Details->Linked Contracts Tab->Linked Contracts"
ls_screen_name[3] = "Document Manager->Work Flow Tab->Search Criteria"
ls_screen_name[4] = "Document Manager->Audit Trail Tab->Search Criteria"

ll_cnt = UpperBound(ls_screen_name) 
FOR i = 1 to ll_cnt
	ls_filter = ls_filter + "'" + ls_screen_name[i] + "'"	
	IF i < ll_cnt THEN ls_filter += ", "
NEXT
IF Len(ls_filter) > 0 THEN ls_filter = "screen_name not in (" + ls_filter + ")"

idwc_screen.SetFilter(ls_filter)
idwc_screen.Filter()

ll_count = idwc_screen.RowCount()
//---------End Added ------------------------------------		
		
if ll_count < 1 then
	ll_count = idwc_screen.InsertRow(0)
end if

return ll_count
*/
RETURN 0

end event

event constructor;call super::constructor;GetChild("screen_id", idwc_screen)
GetChild("field_label", idwc_field)

idwc_screen.SetTransObject(SQLCA)
idwc_field.SetTransObject(SQLCA)
end event

event buttonclicked;call super::buttonclicked;string ls_lookup_name
string ls_desc
String ls_operator, ls_Value //07.25.2008
Long ll_screen_id
String ls_field_name
str_get_dw lstr_dw_info
string ls_dddw_type

If row <= 0 Then Return //Added By Ken.Guo 2009-07-28.

if dwo.name = "b_dropdown" then
	ls_lookup_name = this.GetItemString(row,"lookup_code")
	ls_dddw_type = this.GetItemString(row,"lookup_flag")
	If isnull(ls_lookup_name) Then
		//For Specail DDDW.//Added By Ken.Guo 2009-07-28.
		ll_screen_id = this.getitemnumber(row,'screen_id')
		ls_field_name = this.getitemstring(row,'field_name')
		If ll_screen_id = 13 Then
			Choose Case ls_field_name
				Case 'rqmnt_name' //profile name
					lstr_dw_info.ls_dw_name = 'd_dddw_req_profile'
					lstr_dw_info.ls_value_col = 'rqmnt_name'
				Case 'category_name' //category name
					lstr_dw_info.ls_dw_name = 'd_dddw_req_category'
					lstr_dw_info.ls_value_col = 'category_name'					
				Case 'element_name' //requirement name
					lstr_dw_info.ls_dw_name = 'd_dddw_req_element'
					lstr_dw_info.ls_value_col = 'element_name'				
			End Choose
		End If
		lstr_dw_info.ls_current_value = This.GetItemString(row,"value")
		OpenWithParm(w_value_choose,lstr_dw_info)
		If Message.Stringparm <> '' Then
			ls_Value = Message.Stringparm
			this.SetItem(row,"value", ls_Value)					
			this.SetItem(row,"value_display",ls_Value)			
		End If
	Else
		
		//For Lookup DDDW	
		//--------Begin Addedd by Alfee on 07.25.2008 -----------------
		//Multi selection for IN operation
		ls_operator = this.GetItemString(row, "operator")
		if ls_dddw_type = 'Y'	then	//Code Lookup -- jervis 12.15.2009
			IF Lower(ls_operator) = "in" THEN
				ls_Value = this.GetItemString(row, "value")
				if IsNull(ls_Value) then ls_Value = ""
				ls_Value = of_parse_bracket(ls_Value, "remove")
				
				OpenWithParm(w_lookup_search_dddw,'M' + "@" + ls_lookup_name + "@@" + ls_Value)
			
				if message.stringparm <> "Cancel" then
					ls_Value = message.stringparm
					ls_desc = of_get_lookupdesc_multi(ls_Value)
					ls_Value = of_parse_bracket(ls_Value, "add")
					this.SetItem(row,"value", ls_Value)					
					this.SetItem(row,"value_display",ls_desc)
				end if				
				RETURN
			END IF
			//--------End Added -------------------------------------------
			
			OpenWithParm( w_lookup_search_dddw,'C' + "@" + ls_lookup_name)
			if message.stringparm <> "Cancel" then
				this.SetItem(row,"value",string(message.DoubleParm))
				ls_desc = gnv_data.of_GetItem("code_lookup","code","lookup_code = " + string(message.DoubleParm))
				this.SetItem(row,"value_display",ls_desc)
			end if
		elseif ls_dddw_type = 'P' then	//Company dddw-jervis 12.9.2009
			//Select company
			OpenWithParm(w_facility_name_select,"code&" + ls_lookup_name)
			
			ls_Value = Message.StringParm
			if IsNull(ls_Value) or Trim(ls_Value) = "" then Return
			
			if Lower(ls_operator) <> "in" then
				ls_Value = Left(ls_Value,Pos(ls_Value,",") - 1)
			else
				ls_Value = Left(ls_Value,Len(ls_Value) - 1)
			end if
			
			
			This.SetItem(row,"value", ls_value)
			if Lower(ls_operator) <> "in" then
				ls_desc = gnv_data.of_getItem("ctx_facility","facility_name","facility_id = " + string(ls_value))	
			else
				ls_desc = of_get_companyname_multi(ls_Value)
			end if
			
			This.SetItem(row,"value_display",ls_desc)
		elseif ls_dddw_type= 'U' then 	//User dddw-jervis 12.9.2009
			//
		end if
	End if
end if
end event

event clicked;call super::clicked;String ls_data

IF dwo.name = "left_bracket" THEN
	ls_data = This.GetItemString(row, "left_bracket")
	IF  ls_data = "(" THEN
		This.SetItem(row,"left_bracket" , "")
	ELSEIF IsNull(ls_data) OR Trim(ls_data) = "" THEN
		This.SetItem(row,"left_bracket" , "(")
	END IF
ELSEIF dwo.name = "right_bracket" THEN
	ls_data = This.GetItemString(row, "right_bracket")
	IF ls_data = ")" THEN
		This.SetItem(row,"right_bracket", "")
	ELSEIF IsNull(ls_data) OR Trim(ls_data) = "" THEN 
		This.SetItem(row,"right_bracket", ")")
	END IF		
END IF
end event

