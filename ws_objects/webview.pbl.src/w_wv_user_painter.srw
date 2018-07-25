$PBExportHeader$w_wv_user_painter.srw
forward
global type w_wv_user_painter from w_sheet
end type
type ddlb_search_prac from dropdownlistbox within w_wv_user_painter
end type
type cb_search from commandbutton within w_wv_user_painter
end type
type sle_search_value from singlelineedit within w_wv_user_painter
end type
type ddlb_search_user from dropdownlistbox within w_wv_user_painter
end type
type cbx_includeinactive from checkbox within w_wv_user_painter
end type
type cb_select from commandbutton within w_wv_user_painter
end type
type cb_1 from u_search_letter_button within w_wv_user_painter
end type
type cb_2 from u_search_letter_button within w_wv_user_painter
end type
type cb_3 from u_search_letter_button within w_wv_user_painter
end type
type cb_4 from u_search_letter_button within w_wv_user_painter
end type
type cb_5 from u_search_letter_button within w_wv_user_painter
end type
type cb_6 from u_search_letter_button within w_wv_user_painter
end type
type cb_7 from u_search_letter_button within w_wv_user_painter
end type
type cb_8 from u_search_letter_button within w_wv_user_painter
end type
type cb_9 from u_search_letter_button within w_wv_user_painter
end type
type cb_10 from u_search_letter_button within w_wv_user_painter
end type
type cb_11 from u_search_letter_button within w_wv_user_painter
end type
type cb_12 from u_search_letter_button within w_wv_user_painter
end type
type cb_13 from u_search_letter_button within w_wv_user_painter
end type
type cb_14 from u_search_letter_button within w_wv_user_painter
end type
type cb_15 from u_search_letter_button within w_wv_user_painter
end type
type cb_16 from u_search_letter_button within w_wv_user_painter
end type
type cb_17 from u_search_letter_button within w_wv_user_painter
end type
type cb_18 from u_search_letter_button within w_wv_user_painter
end type
type cb_19 from u_search_letter_button within w_wv_user_painter
end type
type cb_20 from u_search_letter_button within w_wv_user_painter
end type
type cb_21 from u_search_letter_button within w_wv_user_painter
end type
type cb_22 from u_search_letter_button within w_wv_user_painter
end type
type cb_23 from u_search_letter_button within w_wv_user_painter
end type
type cb_24 from u_search_letter_button within w_wv_user_painter
end type
type cb_25 from u_search_letter_button within w_wv_user_painter
end type
type cb_28 from u_search_letter_button within w_wv_user_painter
end type
type gb_4 from groupbox within w_wv_user_painter
end type
type gb_3 from groupbox within w_wv_user_painter
end type
type rb_practitioner from radiobutton within w_wv_user_painter
end type
type rb_user from radiobutton within w_wv_user_painter
end type
type dw_browse from u_dw within w_wv_user_painter
end type
type gb_2 from groupbox within w_wv_user_painter
end type
type gb_1 from groupbox within w_wv_user_painter
end type
type cb_close from commandbutton within w_wv_user_painter
end type
type dw_facility from u_dw within w_wv_user_painter
end type
type tab_1 from tab within w_wv_user_painter
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_1 from userobject within tab_1
end type
type tab_1 from tab within w_wv_user_painter
tabpage_1 tabpage_1
end type
end forward

global type w_wv_user_painter from w_sheet
integer width = 3959
integer height = 1844
string title = "WebView User Account Management"
boolean maxbox = false
long backcolor = 33551856
ddlb_search_prac ddlb_search_prac
cb_search cb_search
sle_search_value sle_search_value
ddlb_search_user ddlb_search_user
cbx_includeinactive cbx_includeinactive
cb_select cb_select
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
cb_10 cb_10
cb_11 cb_11
cb_12 cb_12
cb_13 cb_13
cb_14 cb_14
cb_15 cb_15
cb_16 cb_16
cb_17 cb_17
cb_18 cb_18
cb_19 cb_19
cb_20 cb_20
cb_21 cb_21
cb_22 cb_22
cb_23 cb_23
cb_24 cb_24
cb_25 cb_25
cb_28 cb_28
gb_4 gb_4
gb_3 gb_3
rb_practitioner rb_practitioner
rb_user rb_user
dw_browse dw_browse
gb_2 gb_2
gb_1 gb_1
cb_close cb_close
dw_facility dw_facility
tab_1 tab_1
end type
global w_wv_user_painter w_wv_user_painter

type variables
string is_AuthType
string is_OriginalSql

boolean ib_ShowDOB
boolean ib_ShowSSN
boolean ib_ShowStatus

integer ii_SearchType
constant integer II_LAST_NAME = 1
constant integer II_SSN 		= 2
constant integer II_ID 			= 3
constant integer II_DATE 		= 4
constant integer II_AUDIT 		= 5
end variables

forward prototypes
public function integer of_searchfirstletter (string as_text)
public function string of_getauthtype ()
public function string of_getoriginalsql ()
public function integer of_getinlist (ref string as_prac_status_list, ref string as_prac_audit_list)
public function string of_buildsqlselect ()
public function integer of_getshowcolumnoptions ()
end prototypes

public function integer of_searchfirstletter (string as_text);//////////////////////////////////////////////////////////////////////
// $<function> of_searchfirstletter
// $<arguments>
//		string	as_text
// $<returns> integer
// $<description> First letter of last name search
//////////////////////////////////////////////////////////////////////
// $<add> 02.28.2012 by Evan
//////////////////////////////////////////////////////////////////////

if rb_user.Checked then
	ddlb_search_user.SelectItem(1)
	ddlb_search_user.Event SelectionChanged(1)
else
	ddlb_search_prac.SelectItem(1)
	ddlb_search_prac.Event SelectionChanged(1)
end if

sle_search_value.Text = as_Text
cb_search.Event Clicked()

Return 1
end function

public function string of_getauthtype ();//////////////////////////////////////////////////////////////////////
// $<function> of_GetAuthType
// $<arguments>
// $<returns> string
// $<description> Get authentication type
//////////////////////////////////////////////////////////////////////
// $<add> 02.28.2012 by Evan
//////////////////////////////////////////////////////////////////////

string ls_AuthType
long ll_setting_value

SELECT setting_value INTO :ll_setting_value FROM wv_setting WHERE wv_setting_id = 5;
choose case ll_setting_value
	case 0
		ls_AuthType = "systemdb"
	case 1, 3
		ls_AuthType = "windows"
	case else
		ls_AuthType = "ldap"
end choose

Return ls_AuthType
end function

public function string of_getoriginalsql ();//////////////////////////////////////////////////////////////////////
// $<function> of_GetOriginalSql
// $<arguments>
// $<returns> string
// $<description> Get original sql for practitioners search.
//////////////////////////////////////////////////////////////////////
// $<add> 02.29.2012 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Pos
string ls_Sql

ls_Sql = dw_browse.GetSqlSelect()
ll_Pos = Pos(ls_Sql, "FROM pd_basic")

if ll_Pos > 0 then
	ls_Sql = Left(ls_Sql, ll_Pos - 1)
end if

Return ls_Sql
end function

public function integer of_getinlist (ref string as_prac_status_list, ref string as_prac_audit_list);//////////////////////////////////////////////////////////////////////
// $<function> of_GetInList
// $<arguments>
//		ref string	as_prac_status_list
//		ref string	as_prac_audit_list
// $<returns> integer
// $<description> Get list of IN operator
//////////////////////////////////////////////////////////////////////
// $<add> 03.01.2012 by Evan
//////////////////////////////////////////////////////////////////////
//Start Code Change ----02.12.2013 #V12 maha - removed the status code as overwritten in the function calling

long ll_prac_id
long i, ll_RowCount
long ll_active_status
string ls_prac_status_list
string ls_prac_audit_list
datastore lds_prac_status_list
datastore lds_prac_audit_list

lds_prac_status_list = Create datastore
lds_prac_audit_list = Create datastore
//lds_prac_status_list.DataObject = "d_wv_prac_status_list"
lds_prac_audit_list.DataObject = "d_wv_prac_audit_list"
//lds_prac_status_list.SetTransObject(SQLCA)
lds_prac_audit_list.SetTransObject(SQLCA)

// Retrieve data
gnv_appeondb.of_StartQueue()
//if cbx_includeinactive.Checked then
//	lds_prac_status_list.Retrieve(gs_user_id, 1)
//else
//	lds_prac_status_list.Retrieve(gs_user_id, 0)
//end if
lds_prac_audit_list.Retrieve()
gnv_appeondb.of_CommitQueue()

// Build prac status list
//ll_RowCount = lds_prac_status_list.RowCount()
//for i = 1 to ll_RowCount
//	ll_active_status = lds_prac_status_list.GetItemNumber(i, "active_status")
//	if ll_active_status <> -9999 then
//		if ls_prac_status_list <> "" then ls_prac_status_list += ","
//		ls_prac_status_list += String(ll_active_status)
//	end if
//next
//if ls_prac_status_list = "" then ls_prac_status_list = "-9999"
as_prac_status_list = ""     // ls_prac_status_list

// Build prac audit list
ll_RowCount = lds_prac_audit_list.RowCount()
for i = 1 to ll_RowCount
	ll_prac_id = lds_prac_audit_list.GetItemNumber(i, "prac_id")
	if not IsNull(ll_prac_id) then
		if ls_prac_audit_list <> "" then ls_prac_audit_list += ","
		ls_prac_audit_list += String(ll_prac_id)
	end if
next
if ls_prac_audit_list <> "" then ls_prac_audit_list += ","
ls_prac_audit_list += "0"
as_prac_audit_list = ls_prac_audit_list

// Destroy datastores
//Destroy lds_prac_status_list
Destroy lds_prac_audit_list

Return 1
end function

public function string of_buildsqlselect ();//////////////////////////////////////////////////////////////////////
// $<function> of_BuildSqlSelect
// $<arguments>
// $<returns> string
// $<description> Build sql select for practitioners search.
//////////////////////////////////////////////////////////////////////
// $<add> 02.29.2012 by Evan
//////////////////////////////////////////////////////////////////////

long ll_facility_id, ll_Pos
string ls_Criteria, ls_NewSql
string ls_Date, ls_search_value
string ls_prac_status_list, ls_prac_audit_list

ls_search_value = sle_search_value.Text
ll_facility_id = dw_facility.GetItemNumber(1, "facility_id")

//Start Code Change ----02.12.2013 #V12 maha - modified to call funciton only for audit; hard code the statuses
if ii_searchtype = II_AUDIT then
	of_GetInList(ls_prac_status_list, ls_prac_audit_list)
end if

ls_prac_status_list = "1,4"
if cbx_includeinactive.checked then
	ls_prac_status_list+= ", 3 "
end if
//End Code Change ----02.12.2013

ls_Criteria = &
"FROM	pd_basic left outer join pd_affil_stat on pd_basic.prac_id = pd_affil_stat.prac_id " + &
"		inner join (select distinct facility_id from security_user_facilities where access_rights = 1 and user_id = '" + gs_user_id + "' "
						if ll_facility_id <> 0 then ls_Criteria += " and facility_id = " + string(ll_facility_id)
						ls_Criteria += " ) fac_access on pd_affil_stat.parent_facility_id = fac_access.facility_id " + &
"		left outer join facility on pd_affil_stat.parent_facility_id = facility.facility_id " + &
"		left outer join security_users su on pd_basic.prac_id = su.prac_id "
if of_get_app_setting("set_37", "I") > 0 then
	//-----------appeon begin-----------------
	//<$> commented:long.zhang appeon 02.27.2013
	//<$> reason:	Bug 3414 Modified the WebView user Setup in IntelliCred so that the user is not required to have a WebView role to access the practitioner.
	//		ls_Criteria += &
	//"		left outer join (select case when sum(access_rights) < count(access_rights) then 0 else 1 end full_access " + &
	//"		from security_user_department " + &
	//"		where user_id = '" + gs_user_id + "') dep_access on 1 = 1 "
	//-----------appeon end--------------------
end if
if ii_SearchType = II_DATE then
		ls_Criteria += &
"		inner join pd_comm_review on pd_affil_stat.parent_facility_id = pd_comm_review.facility_id "
end if

ls_Criteria += &
"WHERE	pd_affil_stat.active_status in(" + ls_prac_status_list + ") AND "
choose case ii_SearchType
	case II_LAST_NAME
		ll_Pos = Pos(ls_search_value, "%")
		ll_Pos = ll_Pos + Pos(ls_search_value, "_")
		if ll_Pos > 0 then
			ls_Criteria += "0 = 1 "
		else
			ls_Criteria += "pd_basic.last_name like '" + ls_search_value + "%' "
		end if
	case II_SSN
		ls_Criteria += "pd_basic.ssn like '" + ls_search_value + "%' "
	case II_ID
		if Long(ls_search_value) > 0 then
			ls_Criteria += "pd_basic.prac_id = " + String(Long(ls_search_value)) + " "
		else
			ls_Criteria += "0 = 1 "
		end if
	case II_DATE
		ls_Criteria += "pd_basic.prac_id = pd_comm_review.prac_id AND "
		ls_Criteria += "pd_comm_review.facility_id = pd_affil_stat.parent_facility_id AND "
		ls_Date = String(Date(ls_search_value), "yyyy/mm/dd")
		if gs_DbType = "SQL" then
			ls_Criteria += "convert(varchar(10), pd_comm_review.date_back_from_review, 111) = '" + ls_Date + "' "
		else
			ls_Criteria += "dateformat(pd_comm_review.date_back_from_review, 'yyyy/mm/dd') = '" + ls_Date+ "' "
		end if
	case II_AUDIT
		ls_Criteria += "pd_basic.prac_id in (" + ls_prac_audit_list + ") "
	case else
		ls_Criteria += "0 = 1 "
end choose
if of_get_app_setting("set_37", "I") > 0 then
	//-----------appeon begin-----------------
	//<$> commented:long.zhang appeon 02.27.2013
	//<$> reason:	Bug 3414 Modified the WebView user Setup in IntelliCred so that the user is not required to have a WebView role to access the practitioner.
//	ls_Criteria += "AND (dep_access.full_access = 1 or "
//	ls_Criteria += "pd_basic.prac_id in ( " + &
//						"	select distinct pd_dep.prac_id from pd_affil_dept pd_dep " + &
//						"			inner join (select distinct department_id from security_user_department " + &
//						"							where user_id='" + gs_user_id + "' and access_rights = 1) dept_access " + &
//						"	on pd_dep.department = dept_access.department_id and pd_dep.primary_dept = 1) " + &
//						"	  ) "
	//-----------appeon end--------------------					
end if

ls_Criteria += "ORDER BY pd_basic.last_name, pd_basic.first_name "
ls_NewSql = is_OriginalSql + ls_Criteria
//openwithparm(w_sql_msg , ls_NewSql )

Return ls_NewSql
end function

public function integer of_getshowcolumnoptions ();//////////////////////////////////////////////////////////////////////
// $<function> of_GetShowColumnOptions
// $<arguments>
// $<returns> integer
// $<description> Get show column options
//////////////////////////////////////////////////////////////////////
// $<add> 03.02.2012 by Evan
//////////////////////////////////////////////////////////////////////

long ll_role_id
long i, ll_RowCount
datastore lds_data

lds_data = Create datastore
lds_data.DataObject = "d_wv_show_column_options"
lds_data.SetTransObject(SQLCA)

SELECT wv_role_id INTO :ll_role_id FROM security_users WHERE user_id = :gs_user_id;
ll_RowCount = lds_data.Retrieve(ll_role_id)

for i = 1 to ll_RowCount
	if lds_data.GetItemString(i, "action_name") = "DOB" then
		if lds_data.GetItemNumber(i, "value_id") = 2 then ib_ShowDOB = true
	end if
	if lds_data.GetItemString(i, "action_name") = "SSN" then
		if lds_data.GetItemNumber(i, "value_id") = 2 then ib_ShowSSN = true
	end if
	if lds_data.GetItemString(i, "action_name") = "Status Indicators" then
		if lds_data.GetItemNumber(i, "value_id") = 2 then ib_ShowStatus = true
	end if
next
Destroy lds_data

Return 1
end function

on w_wv_user_painter.create
int iCurrent
call super::create
this.ddlb_search_prac=create ddlb_search_prac
this.cb_search=create cb_search
this.sle_search_value=create sle_search_value
this.ddlb_search_user=create ddlb_search_user
this.cbx_includeinactive=create cbx_includeinactive
this.cb_select=create cb_select
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_11=create cb_11
this.cb_12=create cb_12
this.cb_13=create cb_13
this.cb_14=create cb_14
this.cb_15=create cb_15
this.cb_16=create cb_16
this.cb_17=create cb_17
this.cb_18=create cb_18
this.cb_19=create cb_19
this.cb_20=create cb_20
this.cb_21=create cb_21
this.cb_22=create cb_22
this.cb_23=create cb_23
this.cb_24=create cb_24
this.cb_25=create cb_25
this.cb_28=create cb_28
this.gb_4=create gb_4
this.gb_3=create gb_3
this.rb_practitioner=create rb_practitioner
this.rb_user=create rb_user
this.dw_browse=create dw_browse
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_close=create cb_close
this.dw_facility=create dw_facility
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_search_prac
this.Control[iCurrent+2]=this.cb_search
this.Control[iCurrent+3]=this.sle_search_value
this.Control[iCurrent+4]=this.ddlb_search_user
this.Control[iCurrent+5]=this.cbx_includeinactive
this.Control[iCurrent+6]=this.cb_select
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.cb_4
this.Control[iCurrent+11]=this.cb_5
this.Control[iCurrent+12]=this.cb_6
this.Control[iCurrent+13]=this.cb_7
this.Control[iCurrent+14]=this.cb_8
this.Control[iCurrent+15]=this.cb_9
this.Control[iCurrent+16]=this.cb_10
this.Control[iCurrent+17]=this.cb_11
this.Control[iCurrent+18]=this.cb_12
this.Control[iCurrent+19]=this.cb_13
this.Control[iCurrent+20]=this.cb_14
this.Control[iCurrent+21]=this.cb_15
this.Control[iCurrent+22]=this.cb_16
this.Control[iCurrent+23]=this.cb_17
this.Control[iCurrent+24]=this.cb_18
this.Control[iCurrent+25]=this.cb_19
this.Control[iCurrent+26]=this.cb_20
this.Control[iCurrent+27]=this.cb_21
this.Control[iCurrent+28]=this.cb_22
this.Control[iCurrent+29]=this.cb_23
this.Control[iCurrent+30]=this.cb_24
this.Control[iCurrent+31]=this.cb_25
this.Control[iCurrent+32]=this.cb_28
this.Control[iCurrent+33]=this.gb_4
this.Control[iCurrent+34]=this.gb_3
this.Control[iCurrent+35]=this.rb_practitioner
this.Control[iCurrent+36]=this.rb_user
this.Control[iCurrent+37]=this.dw_browse
this.Control[iCurrent+38]=this.gb_2
this.Control[iCurrent+39]=this.gb_1
this.Control[iCurrent+40]=this.cb_close
this.Control[iCurrent+41]=this.dw_facility
this.Control[iCurrent+42]=this.tab_1
end on

on w_wv_user_painter.destroy
call super::destroy
destroy(this.ddlb_search_prac)
destroy(this.cb_search)
destroy(this.sle_search_value)
destroy(this.ddlb_search_user)
destroy(this.cbx_includeinactive)
destroy(this.cb_select)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_11)
destroy(this.cb_12)
destroy(this.cb_13)
destroy(this.cb_14)
destroy(this.cb_15)
destroy(this.cb_16)
destroy(this.cb_17)
destroy(this.cb_18)
destroy(this.cb_19)
destroy(this.cb_20)
destroy(this.cb_21)
destroy(this.cb_22)
destroy(this.cb_23)
destroy(this.cb_24)
destroy(this.cb_25)
destroy(this.cb_28)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.rb_practitioner)
destroy(this.rb_user)
destroy(this.dw_browse)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_close)
destroy(this.dw_facility)
destroy(this.tab_1)
end on

event open;call super::open;is_AuthType = of_GetAuthType()
rb_user.Event Clicked()
end event

type ddlb_search_prac from dropdownlistbox within w_wv_user_painter
integer x = 133
integer y = 1240
integer width = 631
integer height = 476
integer taborder = 310
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Last Name","SS #","I.D.","Date Back From Comm","Audit needed"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//====================================================================
// $<event> selectionchanged()
// $<arguments>
// 	value	integer	oldindex
// 	value	integer	newindex
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.29.2012
//====================================================================

ii_SearchType = Index
end event

type cb_search from commandbutton within w_wv_user_painter
integer x = 809
integer y = 1236
integer width = 270
integer height = 92
integer taborder = 310
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Search"
boolean default = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Search accounts
// $<add> (Appeon) evan 02.28.2012
//====================================================================

string ls_NewSql
string ls_search_value

if rb_user.Checked then
	ls_search_value = sle_search_value.Text + "%"
	dw_browse.Retrieve(ls_search_value)
else
	ls_NewSql = of_BuildSqlSelect()
	if ls_NewSql = '' then return -1
	dw_browse.SetSqlSelect(ls_NewSql)
	if dw_browse.Retrieve() = -1 then
		MessageBox("Retrieve Error", ls_NewSql, StopSign!)
	end if
end if

dw_browse.SelectRow(1, true)
end event

type sle_search_value from singlelineedit within w_wv_user_painter
integer x = 133
integer y = 1348
integer width = 946
integer height = 84
integer taborder = 320
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type ddlb_search_user from dropdownlistbox within w_wv_user_painter
integer x = 133
integer y = 1240
integer width = 631
integer height = 324
integer taborder = 300
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"User Login Id"}
borderstyle borderstyle = stylelowered!
end type

type cbx_includeinactive from checkbox within w_wv_user_painter
integer x = 142
integer y = 1508
integer width = 859
integer height = 64
integer taborder = 330
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Include Inactive files in search"
end type

type cb_select from commandbutton within w_wv_user_painter
integer x = 133
integer y = 1592
integer width = 343
integer height = 92
integer taborder = 340
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&elect"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> select
// $<add> (Appeon) evan 03.13.2012
//====================================================================

long ll_Row
long ll_prac_id
string ls_user_id

ll_Row = dw_browse.GetRow()
if ll_Row < 1 then Return

if rb_user.Checked then
	ls_user_id = dw_browse.GetItemString(ll_Row, "user_id")
	OpenWithParm(w_wv_user_edit, "User|" + ls_user_id + "|" + is_AuthType)
else
	ll_prac_id = dw_browse.GetItemNumber(ll_Row, "prac_id")
	//OpenWithParm(w_wv_user_edit, "Practitioner|" + String(ll_prac_id) + "|" + is_AuthType)
	OpenWithParm(w_security_user_add_wv,  String(ll_prac_id) + "@0" )  //Start Code Change ----05.30.2014 #V14.2 maha - change for consistant addition of new users.
end if
end event

type cb_1 from u_search_letter_button within w_wv_user_painter
integer x = 128
integer y = 660
integer width = 233
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "A"
end type

event clicked;of_SearchFirstLetter(this.Text)
end event

type cb_2 from u_search_letter_button within w_wv_user_painter
integer x = 128
integer y = 724
integer width = 233
integer height = 64
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "B"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_3 from u_search_letter_button within w_wv_user_painter
integer x = 128
integer y = 788
integer width = 233
integer height = 64
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "C"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_4 from u_search_letter_button within w_wv_user_painter
integer x = 128
integer y = 852
integer width = 233
integer height = 64
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "D"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_5 from u_search_letter_button within w_wv_user_painter
integer x = 128
integer y = 916
integer width = 233
integer height = 64
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "E"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_6 from u_search_letter_button within w_wv_user_painter
integer x = 128
integer y = 980
integer width = 233
integer height = 64
integer taborder = 240
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "F"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_7 from u_search_letter_button within w_wv_user_painter
integer x = 128
integer y = 1044
integer width = 233
integer height = 64
integer taborder = 270
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "G"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_8 from u_search_letter_button within w_wv_user_painter
integer x = 366
integer y = 660
integer width = 233
integer height = 64
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "H"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_9 from u_search_letter_button within w_wv_user_painter
integer x = 366
integer y = 724
integer width = 233
integer height = 64
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "I"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_10 from u_search_letter_button within w_wv_user_painter
integer x = 366
integer y = 788
integer width = 233
integer height = 64
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "J"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_11 from u_search_letter_button within w_wv_user_painter
integer x = 366
integer y = 852
integer width = 233
integer height = 64
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "K"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_12 from u_search_letter_button within w_wv_user_painter
integer x = 366
integer y = 916
integer width = 233
integer height = 64
integer taborder = 210
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "L"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_13 from u_search_letter_button within w_wv_user_painter
integer x = 366
integer y = 980
integer width = 233
integer height = 64
integer taborder = 250
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "M"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_14 from u_search_letter_button within w_wv_user_painter
integer x = 366
integer y = 1044
integer width = 233
integer height = 64
integer taborder = 280
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "N"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_15 from u_search_letter_button within w_wv_user_painter
integer x = 603
integer y = 660
integer width = 233
integer height = 64
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "O"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_16 from u_search_letter_button within w_wv_user_painter
integer x = 603
integer y = 724
integer width = 233
integer height = 64
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "P"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_17 from u_search_letter_button within w_wv_user_painter
integer x = 603
integer y = 788
integer width = 233
integer height = 64
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "Q"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_18 from u_search_letter_button within w_wv_user_painter
integer x = 603
integer y = 852
integer width = 233
integer height = 64
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "R"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_19 from u_search_letter_button within w_wv_user_painter
integer x = 603
integer y = 916
integer width = 233
integer height = 64
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "S"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_20 from u_search_letter_button within w_wv_user_painter
integer x = 603
integer y = 980
integer width = 233
integer height = 64
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "T"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_21 from u_search_letter_button within w_wv_user_painter
integer x = 603
integer y = 1044
integer width = 233
integer height = 64
integer taborder = 290
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "U"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_22 from u_search_letter_button within w_wv_user_painter
integer x = 841
integer y = 660
integer width = 233
integer height = 64
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "V"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_23 from u_search_letter_button within w_wv_user_painter
integer x = 841
integer y = 724
integer width = 233
integer height = 64
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "W"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_24 from u_search_letter_button within w_wv_user_painter
integer x = 841
integer y = 788
integer width = 233
integer height = 64
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "X"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_25 from u_search_letter_button within w_wv_user_painter
integer x = 841
integer y = 852
integer width = 233
integer height = 64
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "Y"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_28 from u_search_letter_button within w_wv_user_painter
integer x = 841
integer y = 916
integer width = 233
integer height = 64
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "Z"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type gb_4 from groupbox within w_wv_user_painter
integer x = 91
integer y = 1164
integer width = 1029
integer height = 300
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Custom Search"
end type

type gb_3 from groupbox within w_wv_user_painter
integer x = 91
integer y = 584
integer width = 1029
integer height = 552
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "First Letter of Last Name Search"
end type

type rb_practitioner from radiobutton within w_wv_user_painter
integer x = 599
integer y = 228
integer width = 517
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "WV Practitioners"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.28.2012
//====================================================================

// Search criteria processing
dw_facility.Modify("facility_id.protect = 0 facility_id.background.color = 16777215")
cbx_includeinactive.Enabled = true
ddlb_search_user.Hide()
ddlb_search_prac.Show()
if ddlb_search_prac.Text = "" then
	ddlb_search_prac.SelectItem(1)
	ddlb_search_prac.Event SelectionChanged(1)
end if

// Switch data object
dw_browse.DataObject = "d_wv_account_prac_list"
dw_browse.SetTransObject(SQLCA)
if is_OriginalSql = "" then
	is_OriginalSql = of_GetOriginalSql()
	if Lower(gs_user_id) <> "master" then
		of_GetShowColumnOptions()
	end if
end if

// User type processing
if is_AuthType = "ldap" then
	dw_browse.Modify("wv_ldap_user_t.text = 'LDAP User Id'")
elseif is_AuthType = "windows" then
	dw_browse.Modify("wv_ldap_user_t.text = 'Windows User Id'")
else
	dw_browse.Modify("wv_ldap_user.visible = '0'")
end if

// Hide columns processing

//Start Code Change ----02.12.2013 #V12 maha - removed

//if Lower(gs_user_id) <> "master" then
//	if not ib_ShowStatus then
//		dw_browse.Modify("compute_status.visible = '0'")
//	end if
//end if
//End Code Change ----02.12.2013

if of_get_app_setting("set_42", "I") > 0 then
	dw_browse.Modify("ssn.visible = '0'")
	dw_browse.Modify("date_of_birth.visible = '0'")
else
	if Lower(gs_user_id) <> "master" then
		if not ib_ShowSSN then
			dw_browse.Modify("ssn.visible = '0'")
		end if
		if not ib_ShowStatus then
			dw_browse.Modify("date_of_birth.visible = '0'")
		end if
	end if
end if
end event

type rb_user from radiobutton within w_wv_user_painter
integer x = 192
integer y = 228
integer width = 338
integer height = 64
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "WV Users"
boolean checked = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.28.2012
//====================================================================

// Search criteria processing
dw_facility.Modify("facility_id.protect = 1 facility_id.background.color = 67108864")
cbx_includeinactive.Enabled = false
ddlb_search_prac.Hide()
ddlb_search_user.Show()
if ddlb_search_user.Text = "" then
	ddlb_search_user.SelectItem(1)
	ddlb_search_user.Event SelectionChanged(1)
end if

// Switch data object and LDAP column pressing
dw_browse.DataObject = "d_wv_account_user_list"
dw_browse.SetTransObject(SQLCA)
if is_AuthType = "ldap" then
	dw_browse.Modify("wv_ldap_user_t.text = 'LDAP User Name'")
	dw_browse.Modify("role_name.width = 970 role_name_t.width = 970")
elseif is_AuthType = "windows" then
	dw_browse.Modify("wv_ldap_user_t.text = 'Windows User Name'")
	dw_browse.Modify("role_name.width = 970 role_name_t.width = 970")
else
	dw_browse.Modify("wv_ldap_user.visible = '0'")
end if
end event

type dw_browse from u_dw within w_wv_user_painter
integer x = 1138
integer y = 132
integer width = 2738
integer height = 1564
integer taborder = 360
boolean bringtotop = true
string dataobject = "d_wv_account_prac_list"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.15.2012
//====================================================================

this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
// $<event> rowfocuschanged()
// $<arguments>
// 	value	long	currentrow
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.28.2012
//====================================================================

this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

event doubleclicked;call super::doubleclicked;//====================================================================
// $<event> doubleclicked()
// $<arguments>
//		value integer	xpos
//		value integer	ypos
//		value long		row
//		value dwobject	dwo
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 03.05.2012
//====================================================================

cb_select.Event Clicked()
end event

type gb_2 from groupbox within w_wv_user_painter
integer x = 91
integer y = 364
integer width = 1029
integer height = 184
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Facility"
end type

type gb_1 from groupbox within w_wv_user_painter
integer x = 91
integer y = 144
integer width = 1029
integer height = 184
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select User Account Type"
end type

type cb_close from commandbutton within w_wv_user_painter
integer x = 535
integer y = 1592
integer width = 343
integer height = 92
integer taborder = 350
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Close
// $<add> (Appeon) evan 02.28.2012
//====================================================================

Close(Parent)
end event

type dw_facility from u_dw within w_wv_user_painter
integer x = 128
integer y = 436
integer width = 974
integer height = 92
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_wv_facility_select"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.28.2012
//====================================================================

datawindowchild ldwc_child

this.of_SetUpdateAble(false)
this.GetChild("facility_id", ldwc_child)

ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve(gs_user_id)
ldwc_child.InsertRow(1)
ldwc_child.SetItem(1, "facility_facility_id", 0)
ldwc_child.SetItem(1, "facility_facility_name", "ALL")
ldwc_child.SelectRow(0, false)

this.InsertRow(1)
this.SetItem(1, "facility_id", 0)
end event

type tab_1 from tab within w_wv_user_painter
integer width = 3909
integer height = 1716
boolean enabled = false
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

event selectionchanged;//====================================================================
// $<event> selectionchanged()
// $<arguments>
// 	value	integer	oldindex
// 	value	integer	newindex
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.13.2012
//====================================================================


end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3872
integer height = 1600
long backcolor = 33551856
string text = "Search"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
end type

