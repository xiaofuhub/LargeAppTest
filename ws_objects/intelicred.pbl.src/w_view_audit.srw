$PBExportHeader$w_view_audit.srw
forward
global type w_view_audit from pfc_w_response
end type
type cb_clear from pfc_u_cb within w_view_audit
end type
type cb_search from pfc_u_cb within w_view_audit
end type
type sle_prac from singlelineedit within w_view_audit
end type
type st_prac from statictext within w_view_audit
end type
type cb_dp from pfc_u_cb within w_view_audit
end type
type dw_date_range from u_dw within w_view_audit
end type
type cb_2 from commandbutton within w_view_audit
end type
type st_7 from statictext within w_view_audit
end type
type dw_select_user from u_dw within w_view_audit
end type
type st_run from statictext within w_view_audit
end type
type tab_1 from tab within w_view_audit
end type
type tabpage_1 from userobject within tab_1
end type
type st_5 from statictext within tabpage_1
end type
type dw_select_screen from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_5 st_5
dw_select_screen dw_select_screen
end type
type tabpage_2 from userobject within tab_1
end type
type dw_ctx from u_dw within tabpage_2
end type
type st_6 from statictext within tabpage_2
end type
type dw_tables from u_dw within tabpage_2
end type
type st_4 from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_ctx dw_ctx
st_6 st_6
dw_tables dw_tables
st_4 st_4
end type
type tabpage_roles from userobject within tab_1
end type
type st_1 from statictext within tabpage_roles
end type
type dw_role from datawindow within tabpage_roles
end type
type tabpage_roles from userobject within tab_1
st_1 st_1
dw_role dw_role
end type
type tabpage_users from userobject within tab_1
end type
type st_2 from statictext within tabpage_users
end type
type dw_userid from datawindow within tabpage_users
end type
type tabpage_users from userobject within tab_1
st_2 st_2
dw_userid dw_userid
end type
type tabpage_priv from userobject within tab_1
end type
type tabpage_priv from userobject within tab_1
end type
type tabpage_pracpriv from userobject within tab_1
end type
type tabpage_pracpriv from userobject within tab_1
end type
type tabpage_apps from userobject within tab_1
end type
type rb_all from radiobutton within tabpage_apps
end type
type dw_sele_appscreen from u_dw within tabpage_apps
end type
type st_scr from statictext within tabpage_apps
end type
type cbx_appl_audit from checkbox within tabpage_apps
end type
type rb_app_d from radiobutton within tabpage_apps
end type
type rb_app_m from radiobutton within tabpage_apps
end type
type rb_app_c from radiobutton within tabpage_apps
end type
type gb_3 from groupbox within tabpage_apps
end type
type tabpage_apps from userobject within tab_1
rb_all rb_all
dw_sele_appscreen dw_sele_appscreen
st_scr st_scr
cbx_appl_audit cbx_appl_audit
rb_app_d rb_app_d
rb_app_m rb_app_m
rb_app_c rb_app_c
gb_3 gb_3
end type
type tabpage_verif from userobject within tab_1
end type
type rb_vb from radiobutton within tabpage_verif
end type
type rb_vh from radiobutton within tabpage_verif
end type
type rb_va from radiobutton within tabpage_verif
end type
type rb_vd from radiobutton within tabpage_verif
end type
type rb_vm from radiobutton within tabpage_verif
end type
type rb_vc from radiobutton within tabpage_verif
end type
type gb_vertype from groupbox within tabpage_verif
end type
type gb_1 from groupbox within tabpage_verif
end type
type tabpage_verif from userobject within tab_1
rb_vb rb_vb
rb_vh rb_vh
rb_va rb_va
rb_vd rb_vd
rb_vm rb_vm
rb_vc rb_vc
gb_vertype gb_vertype
gb_1 gb_1
end type
type tabpage_report from userobject within tab_1
end type
type st_3 from statictext within tabpage_report
end type
type ddlb_rpt_type from dropdownlistbox within tabpage_report
end type
type tabpage_report from userobject within tab_1
st_3 st_3
ddlb_rpt_type ddlb_rpt_type
end type
type tab_1 from tab within w_view_audit
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_roles tabpage_roles
tabpage_users tabpage_users
tabpage_priv tabpage_priv
tabpage_pracpriv tabpage_pracpriv
tabpage_apps tabpage_apps
tabpage_verif tabpage_verif
tabpage_report tabpage_report
end type
type cb_close from pfc_u_cb within w_view_audit
end type
type cb_print from pfc_u_cb within w_view_audit
end type
type cb_help from pfc_u_cb within w_view_audit
end type
type cb_1 from pfc_u_cb within w_view_audit
end type
type dw_audit from u_dw within w_view_audit
end type
type gb_filters from groupbox within w_view_audit
end type
type gb_2 from groupbox within w_view_audit
end type
end forward

global type w_view_audit from pfc_w_response
integer x = 9
integer y = 248
integer width = 4119
integer height = 2072
string title = "Audit Information For "
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
boolean center = true
cb_clear cb_clear
cb_search cb_search
sle_prac sle_prac
st_prac st_prac
cb_dp cb_dp
dw_date_range dw_date_range
cb_2 cb_2
st_7 st_7
dw_select_user dw_select_user
st_run st_run
tab_1 tab_1
cb_close cb_close
cb_print cb_print
cb_help cb_help
cb_1 cb_1
dw_audit dw_audit
gb_filters gb_filters
gb_2 gb_2
end type
global w_view_audit w_view_audit

type variables
String is_original_sql
long ll_ctx_id
integer ii_role
string is_user_id

Long il_prac_id //alfee 11.30.2012
end variables

forward prototypes
public function integer wf_run_filter_prac ()
public function integer wf_run_filter_ctx ()
public function integer wf_reset_st_run ()
public function integer wf_audit_role ()
public function integer wf_audit_user ()
public function string wf_get_dates (string as_date)
public function integer wf_run_audit_filter (string as_from)
public function integer wf_run_filter_verif ()
public function integer of_run_filter_net_dev ()
public function integer wf_run_filter_net_dev ()
public function integer of_prac_show (boolean ab_show)
public function integer wf_run_appaudit_filter ()
public function integer of_appl_audit_settings (boolean ab_true)
end prototypes

public function integer wf_run_filter_prac ();String ls_sql
String ls_user
String ls_from_date
String ls_to_date
Integer li_table_id
integer r



ls_user =  dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'")  // Add by Stephen 03.30.2011 --- Fixed a bug.

IF ls_user <> "All" THEN
	ls_sql = ls_sql + " AND sys_audit.user_id = '" + ls_user + "'"
END IF

li_table_id = tab_1.tabpage_1.dw_select_screen.GetItemNumber( 1, "table_id" )

IF li_table_id <> 0 THEN
	ls_sql = ls_sql + " AND sys_audit.table_id = " + String( li_table_id )
END IF

IF sle_prac.Text <> "" AND NOT IsNull( sle_prac.Text ) THEN
	//ls_sql = ls_sql + " AND sys_audit.prac_id= " + String( gl_prac_id )
	ls_sql = ls_sql + " AND sys_audit.prac_id= " + String( il_prac_id )	//alfee 11.30.2012
END IF

dw_date_range.AcceptText()

ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		 //--------------------------- APPEON BEGIN ---------------------------
		 //$<modify> 2005-11-15 By: Zhang Lingping
		 //$<reason>  The database function date is unsupported in SQL Server. 
		 //$<reason>  It need be replace with dabase function "convert".
		 
		 //ls_sql = ls_sql + " AND Date(sys_audit.date_time_modified)  >= " + ls_from_date +&
		 //					" AND Date(sys_audit.date_time_modified)  <= " + ls_to_date 
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, sys_audit.date_time_modified,102) )  >= " + ls_from_date +&
								" AND convert(datetime, convert( varchar, sys_audit.date_time_modified,102) )  <= " + ls_to_date 
		 //---------------------------- APPEON END ----------------------------
	END IF
END IF

ls_sql = is_original_sql + ls_sql

//messagebox("", ls_sql )

r = dw_audit.SetSQLSelect ( ls_sql )
if r < 0 then openwithparm(w_sql_msg, ls_sql)
dw_audit.SetTransObject( SQLCA )
dw_audit.Retrieve()


return 0
end function

public function integer wf_run_filter_ctx ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 22 October 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
Integer li_table_id
Long ll_pos  //(Appeon)Alfee 06.27.2013 - V141 ISG-CLX
String ls_sql
String ls_user
String ls_from_date
String ls_to_date
String ls_original_sql

dw_audit.dataobject = ''
dw_audit.dataobject =  'd_view_audit_ctx'

ls_original_sql = dw_audit.Object.DataWindow.Table.Select

//---------Begin Added by (Appeon)Alfee 06.27.2013 for V141 ISG-CLX--------
//added by gavins 20120815
ll_pos = Pos( ls_original_sql, 'sys_fields.field_name' )
If ll_Pos > 0 Then
	ls_original_sql = Replace( ls_original_sql, ll_Pos, Len(  'sys_fields.field_name'  ) , "isnull( sys_audit.tfield_name, sys_fields.field_name) field_name" )
End If
ll_pos = Pos( ls_original_sql, 'sys_fields.field_name_allias' )
If ll_Pos > 0 Then
	ls_original_sql = Replace( ls_original_sql, ll_Pos, Len(  'sys_fields.field_name_allias'  ) , "isnull( sys_audit.tfield_name_allias, sys_fields.field_name_allias) field_name_allias" )
End If
dw_select_user.AcceptText()
//---------End Added ------------------------------------------------------------------

ls_user = dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'")  // Add by Stephen 03.30.2011 --- Fixed a bug.

IF ls_user <> "All" THEN
	ls_sql = ls_sql + " AND sys_audit.user_id = '" + ls_user + "'"
END IF

li_table_id = this.tab_1.tabpage_2.dw_tables.GetItemNumber( 1, "table_id" )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 04.22.2006 By: LeiWei
//$<reason> The way Appeon deals with the NULL value on the Web is different from that in PowerBuilder.
//$<modification> Modify the condition to make sure the applciation works correctly on the Web.
//IF li_table_id <> 0 THEN
IF li_table_id <> 0 AND NOT ISNULL(li_table_id) THEN
//---------------------------- APPEON END ----------------------------
	ls_sql = ls_sql + " AND sys_audit.table_id = " + String( li_table_id )
END IF

dw_date_range.AcceptText()

ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 


IF  not IsNull( ll_ctx_id ) and ll_ctx_id <> 0 THEN
	ls_sql = ls_sql + " AND sys_audit.prac_id= " + String( ll_ctx_id )
END IF


IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
   		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		 //--------------------------- APPEON BEGIN ---------------------------
		 //$<modify> 2005-11-15 By: Zhang Lingping
		 //$<reason>  The database function date is unsupported in SQL Server. 
		 //$<reason>  It need be replace with dabase function "convert".
		 
		 //ls_sql = ls_sql + " AND Date(sys_audit.date_time_modified)  >= " + ls_from_date +&
		 //					" AND Date(sys_audit.date_time_modified)  <= " + ls_to_date 
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, sys_audit.date_time_modified,102) )  >= " + ls_from_date +&
								" AND convert(datetime, convert( varchar, sys_audit.date_time_modified,102) )  <= " + ls_to_date 
		 //---------------------------- APPEON END ----------------------------
	END IF
END IF

ls_sql = ls_original_sql + ls_sql

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<modify> 04.22.2006 By: LeiWei
//$<reason> SetSQLSelect doest not work correctly against SQL server database on the Web.
//$<modification> Change it to Modify() to make sure the application runs correctly against
//$<modification> both SQL server database and ASA database on the Web.
//dw_audit.SetSQLSelect ( ls_sql )
dw_audit.Modify('DataWindow.Table.Select="'+ls_sql + '"')
//---------------------------- APPEON END ----------------------------

dw_audit.SetTransObject( SQLCA )
dw_audit.Retrieve()


return 0
end function

public function integer wf_reset_st_run ();

st_run.BorderStyle = StyleRaised!
st_run.TextColor = RGB( 128, 0, 0 )
st_run.Enabled = True

return 0
end function

public function integer wf_audit_role ();//Start Code Change ----05.15.2009 #V92 maha - new function to view role audits - ameripath
//Start Code Change ----07.21.2009 #V92 maha - corrected where/ands
String ls_sql
String ls_user
String ls_from_date
String ls_to_date
string ls_original_sql
Integer li_role
integer res

ls_original_sql = dw_audit.Object.DataWindow.Table.Select
debugbreak()
ls_user =  dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'")   // Add by Stephen 03.30.2011 --- Fixed a bug.

IF ls_user <> "All" THEN
	ls_sql = ls_sql + " Where sys_audit_role.mod_by = '" + ls_user + "' "
END IF

li_role = ii_role

IF li_role <> 0 THEN
	if LenA(ls_sql) > 2 then
		ls_sql = ls_sql + " AND sys_audit_role.role_id = " + String( li_role)
	else
		ls_sql = " WHERE sys_audit_role.role_id = " + String( li_role)
	end if
END IF

dw_date_range.AcceptText()

ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		 //--------------------------- APPEON BEGIN ---------------------------
		 //$<modify> 2005-11-15 By: Zhang Lingping
		 //$<reason>  The database function date is unsupported in SQL Server. 
		 //$<reason>  It need be replace with dabase function "convert".
		 
		 //ls_sql = ls_sql + " AND Date(sys_audit.date_time_modified)  >= " + ls_from_date +&
		 //					" AND Date(sys_audit.date_time_modified)  <= " + ls_to_date 
//Start Code Change ----08.10.2010 #V10 maha - corrected table name causing date filter to fail
		if len(ls_sql) > 2 then
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, sys_audit_role.date_time_modified,102) )  >= " + ls_from_date +&
								" AND convert(datetime, convert( varchar, sys_audit_role.date_time_modified,102) )  <= " + ls_to_date 
		else
			ls_sql = "Where convert(datetime,  convert( varchar, sys_audit_role.date_time_modified,102) )  >= " + ls_from_date +&
								" AND convert(datetime, convert( varchar, sys_audit_role.date_time_modified,102) )  <= " + ls_to_date 
		end if		 //---------------------------- APPEON END ----------------------------
//End Code Change ----08.10.2010
	END IF
END IF

ls_sql = ls_original_sql + ls_sql

//messagebox("", ls_sql )

res = dw_audit.SetSQLSelect ( ls_sql )
if res < 0 then messagebox("Filter failed", "Failed to set filter syntax: " + ls_sql)
dw_audit.SetTransObject( SQLCA )
dw_audit.Retrieve()

dw_audit.Modify('DataWindow.Table.Select="'+ls_original_sql + '"')
dw_audit.SetTransObject( SQLCA )

return 0
end function

public function integer wf_audit_user ();//Start Code Change ----05.15.2009 #V92 maha - new function to view role audits - ameripath
//Start Code Change ----07.21.2009 #V92 maha - corrected where/ands
String ls_sql
String ls_user
String ls_from_date
String ls_to_date
string ls_original_sql

debugbreak()
ls_original_sql = dw_audit.Object.DataWindow.Table.Select

ls_user =  dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'")  // Add by Stephen 03.30.2011 --- Fixed a bug.

IF ls_user <> "All" THEN
	ls_sql = ls_sql + " Where sys_audit_user.mod_by = '" + ls_user + "' "
END IF

IF is_user_id <> "" THEN
	if LenA(ls_sql) > 2 then
		ls_sql = ls_sql + " AND sys_audit_user.user_id = '" + is_user_id + "' "
	else
		ls_sql = " Where sys_audit_user.user_id = '" + is_user_id + "' "
	end if
END IF

dw_date_range.AcceptText()

ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		 //--------------------------- APPEON BEGIN ---------------------------
		 //$<modify> 2005-11-15 By: Zhang Lingping
		 //$<reason>  The database function date is unsupported in SQL Server. 
		 //$<reason>  It need be replace with dabase function "convert".
		 
		 //ls_sql = ls_sql + " AND Date(sys_audit.date_time_modified)  >= " + ls_from_date +&
		 //					" AND Date(sys_audit.date_time_modified)  <= " + ls_to_date 
		 if LenA(ls_sql) > 2 then
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, sys_audit_user.date_time_modified,102) )  >= " + ls_from_date +&
								" AND convert(datetime, convert( varchar, sys_audit_user.date_time_modified,102) )  <= " + ls_to_date 
		else
			ls_sql = "Where convert(datetime,  convert( varchar, sys_audit_user.date_time_modified,102) )  >= " + ls_from_date +&
								" AND convert(datetime, convert( varchar, sys_audit_user.date_time_modified,102) )  <= " + ls_to_date 
		end if
		 //---------------------------- APPEON END ----------------------------
	END IF
END IF

ls_sql = ls_original_sql + ls_sql

//messagebox("", ls_sql )

dw_audit.SetSQLSelect ( ls_sql )
dw_audit.SetTransObject( SQLCA )
dw_audit.Retrieve()

dw_audit.Modify('DataWindow.Table.Select="'+ls_original_sql + '"')
dw_audit.SetTransObject( SQLCA )

return 0
end function

public function string wf_get_dates (string as_date);//Start Code Change ----12-15.2009 #V10 maha - function added and default from and to dates allowed
string ls_from_date
string ls_to_date

choose case as_date
	case "From"
		ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' )
		//IF ls_from_date <> "" or NOT IsNull( ls_from_date ) or ls_from_date <> "00/00/0000" THEN
		IF ls_from_date = "" or IsNull( ls_from_date ) or ls_from_date = "00/00/0000" THEN //End Code Change---08.10.2010 - corrected if
			ls_from_date = "1995-01-01"
		END IF
		
		ls_from_date = "'" + ls_from_date + "'"
		return ls_from_date
	case "To"
		ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 
		//IF ls_to_date <> "" or NOT IsNull( ls_to_date ) or ls_to_date <> "00/00/0000" THEN
		IF ls_to_date = "" or IsNull( ls_to_date ) or ls_to_date = "00/00/0000" THEN //End Code Change---08.10.2010 - corrected if
			ls_to_date = "2995-01-01"
		END IF
		
		ls_to_date = "'" + ls_to_date + "'"
		return ls_to_date
end choose

return ""


		
end function

public function integer wf_run_audit_filter (string as_from);
//Start Code Change ----02.17.2010 #V10 maha - added for additional audit functions
String ls_sql
String ls_user
String ls_from_date
String ls_to_date
string ls_original_sql
string ls_table
Integer li_table_id
integer res  //maha 06.16.2016
string ls_mod_user_field   = ".mod_by"  //maha 06.16.2016

ls_original_sql = dw_audit.Object.DataWindow.Table.Select

choose case as_from
	case "Priv Painter"
		ls_table = "sys_audit_priv_painter"
	Case "Priv Prac"
		ls_table = "sys_audit_priv_prac"
	case "Reports"  //Start Code Change ----06.16.2016 #V152 maha
		ls_table = "sys_report_audit"
		ls_mod_user_field = ".mod_user"
	case else
		messagebox("wf_audit_filter","Undefined call to this function -" + as_from)
end choose


//mod by filter
ls_user =  dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'")  // Add by Stephen 03.30.2011 --- Fixed a bug.

IF ls_user <> "All" THEN
	ls_sql = ls_sql + " AND " + ls_table + ls_mod_user_field + " = '" + ls_user + "'"
END IF

Choose case as_from 
	case "Priv Prac" //practitioner privileges
		IF sle_prac.Text <> "" AND NOT IsNull( sle_prac.Text ) THEN
			//ls_sql = ls_sql + " AND " + ls_table + ".prac_id = " + String( gl_prac_id )
			ls_sql = ls_sql + " AND " + ls_table + ".prac_id = " + String( il_prac_id )	//alfee 11.30.2012
		END IF
	case "Reports"  //Start Code Change ----06.16.2016 #V152 maha
		choose case tab_1.tabpage_report.ddlb_rpt_type.text
			Case "Export"
				ls_sql = ls_sql + " AND " + ls_table + ".report_type = 'E'"
			Case "IntelliReport" 
				ls_sql = ls_sql + " AND " + ls_table + ".report_type = 'C'"
			Case "One-Click"
				ls_sql = ls_sql + " AND " + ls_table + ".report_type = '1'"
			case else
				//leave as is
		end choose
		
end choose


//date range filter
dw_date_range.AcceptText()

ls_from_date = wf_get_dates( "From")
ls_to_date =   wf_get_dates( "To") 

Choose case as_from
	case "Reports"
		ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, " + ls_table + ".mod_date, 102) )  >= " + ls_from_date +	" AND convert(datetime, convert( varchar, " + ls_table + ".mod_date,102) )  <= " + ls_to_date 		
	case else
		ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, " + ls_table + ".date_time_modified,102) )  >= " + ls_from_date +	" AND convert(datetime, convert( varchar, " + ls_table + ".date_time_modified,102) )  <= " + ls_to_date 
End choose

ls_sql = ls_original_sql + ls_sql

//openwithparm(w_sql_msg, ls_sql)

dw_audit.SetSQLSelect ( ls_sql )
dw_audit.SetTransObject( SQLCA )
res = dw_audit.Retrieve()
if res < 0 then
	messagebox("filter failed", ls_sql)
end if
dw_audit.SetSQLSelect ( ls_original_sql )


return 0
end function

public function integer wf_run_filter_verif ();//Start Code Change ----08.05.2011 #V11 maha  - function created 
string ls_original_sql
String ls_sql
String ls_user
String ls_from_date
String ls_to_date
Integer li_table_id
integer res

ls_original_sql = dw_audit.Object.DataWindow.Table.Select

ls_user =  dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'")  // Add by Stephen 03.30.2011 --- Fixed a bug.

IF ls_user <> "All" THEN
	if tab_1.tabpage_verif.rb_vc.checked then
		ls_sql = ls_sql + " AND verif_info.create_user = '" + ls_user + "'"
	elseif tab_1.tabpage_verif.rb_vm.checked then
		ls_sql = ls_sql + " AND verif_info.mod_user = '" + ls_user + "'"
	else //delete
		ls_sql = ls_sql + " AND verif_info_delete.del_user = '" + ls_user + "'"
	end if
END IF

IF sle_prac.Text <> "" AND NOT IsNull( sle_prac.Text ) THEN
	if tab_1.tabpage_verif.rb_vc.checked then
		//ls_sql = ls_sql + " AND verif_info.prac_id= " + String( gl_prac_id )
		ls_sql = ls_sql + " AND verif_info.prac_id= " + String( il_prac_id )	//alfee 11.30.2012
	elseif tab_1.tabpage_verif.rb_vm.checked then
		//ls_sql = ls_sql + " AND verif_info.prac_id= " + String( gl_prac_id )
		ls_sql = ls_sql + " AND verif_info.prac_id= " + String( il_prac_id ) //alfee 11.30.2012
	else //delete
		//ls_sql = ls_sql + " AND verif_info_delete.prac_id= " + String( gl_prac_id )
		ls_sql = ls_sql + " AND verif_info_delete.prac_id= " + String( il_prac_id ) //alfee 11.30.2012	
	end if
END IF

dw_date_range.AcceptText()

ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		
		if tab_1.tabpage_verif.rb_vc.checked then	
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, verif_info.create_date,102) )  >= " + ls_from_date +&
									" AND convert(datetime, convert( varchar, verif_info.create_date,102) )  <= " + ls_to_date 
		elseif tab_1.tabpage_verif.rb_vm.checked then
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, verif_info.mod_date,102) )  >= " + ls_from_date +&
									" AND convert(datetime, convert( varchar, verif_info.mod_date,102) )  <= " + ls_to_date 
		else //delete
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, verif_info_delete.del_date,102) )  >= " + ls_from_date +&
									" AND convert(datetime, convert( varchar, verif_info_delete.del_date,102) )  <= " + ls_to_date 
		end if


	END IF
END IF

//only get records with mod dates
if tab_1.tabpage_verif.rb_vc.checked then
	ls_sql = ls_sql + " AND verif_info.create_date is not null "
elseif tab_1.tabpage_verif.rb_vm.checked then
	ls_sql = ls_sql + " AND verif_info.mod_date is not null "
end if

//Active status
if tab_1.tabpage_verif.rb_vc.checked or  tab_1.tabpage_verif.rb_vm.checked then
	if tab_1.tabpage_verif.rb_va.checked then
		ls_sql = ls_sql + " AND verif_info.active_status = 1"
	elseif tab_1.tabpage_verif.rb_vh.checked then
		ls_sql = ls_sql + " AND verif_info.active_status = 0"
	end if
end if


ls_sql = ls_original_sql + ls_sql

//messagebox("", ls_sql )

dw_audit.SetSQLSelect ( ls_sql )
dw_audit.SetTransObject( SQLCA )
res = dw_audit.Retrieve()

if res < 0 then
	messagebox("Audit Filter Failure", ls_sql )
end if

dw_audit.SetSQLSelect (ls_original_sql)

return 0
end function

public function integer of_run_filter_net_dev ();//Start Code Change ----08.05.2011 #V11 maha  - function created 
string ls_original_sql
String ls_sql
String ls_user
String ls_from_date
String ls_to_date
Integer li_table_id
integer res

ls_original_sql = dw_audit.Object.DataWindow.Table.Select

ls_user =  dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'")  // Add by Stephen 03.30.2011 --- Fixed a bug.

IF ls_user <> "All" THEN
	if tab_1.tabpage_verif.rb_vc.checked then
		ls_sql = ls_sql + " AND net_dev_action_items.create_user = '" + ls_user + "'"
	elseif tab_1.tabpage_verif.rb_vm.checked then
		ls_sql = ls_sql + " AND net_dev_action_items.mod_user = '" + ls_user + "'"
	else //delete
		ls_sql = ls_sql + " AND net_dev_action_items_delete.del_user = '" + ls_user + "'"
	end if
END IF

IF sle_prac.Text <> "" AND NOT IsNull( sle_prac.Text ) THEN
	if tab_1.tabpage_verif.rb_vc.checked then
		//ls_sql = ls_sql + " AND net_dev_action_items.prac_id= " + String( gl_prac_id )
		ls_sql = ls_sql + " AND net_dev_action_items.prac_id= " + String( il_prac_id )	//alfee 11.30.2012
	elseif tab_1.tabpage_verif.rb_vm.checked then
		//ls_sql = ls_sql + " AND net_dev_action_items.prac_id= " + String( gl_prac_id )
		ls_sql = ls_sql + " AND net_dev_action_items.prac_id= " + String( il_prac_id )	//alfee 11.30.2012		
	else //delete
		//ls_sql = ls_sql + " AND net_dev_action_items_delete.prac_id= " + String( gl_prac_id )
		ls_sql = ls_sql + " AND net_dev_action_items_delete.prac_id= " + String( il_prac_id ) //alfee 11.30.2012		
	end if
END IF

dw_date_range.AcceptText()

ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		
		if tab_1.tabpage_verif.rb_vc.checked then	
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, net_dev_action_items.create_date,102) )  >= " + ls_from_date +&
									" AND convert(datetime, convert( varchar, net_dev_action_items.create_date,102) )  <= " + ls_to_date 
		elseif tab_1.tabpage_verif.rb_vm.checked then
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, net_dev_action_items.mod_date,102) )  >= " + ls_from_date +&
									" AND convert(datetime, convert( varchar, net_dev_action_items.mod_date,102) )  <= " + ls_to_date 
		else //delete
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, net_dev_action_items_delete.del_date,102) )  >= " + ls_from_date +&
									" AND convert(datetime, convert( varchar, net_dev_action_items_delete.del_date,102) )  <= " + ls_to_date 
		end if


	END IF
END IF

//only get records with mod dates
if tab_1.tabpage_verif.rb_vc.checked then
	ls_sql = ls_sql + " AND net_dev_action_items.create_date is not null "
elseif tab_1.tabpage_verif.rb_vm.checked then
	ls_sql = ls_sql + " AND net_dev_action_items.mod_date is not null "
end if



ls_sql = ls_original_sql + ls_sql

//messagebox("", ls_sql )

dw_audit.SetSQLSelect ( ls_sql )
dw_audit.SetTransObject( SQLCA )
res = dw_audit.Retrieve()

if res < 0 then
	messagebox("Audit Filter Failure", ls_sql )
end if

dw_audit.SetSQLSelect (ls_original_sql)

return 0
end function

public function integer wf_run_filter_net_dev ();//Start Code Change ----08.05.2011 #V11 maha  - function created 
string ls_original_sql
String ls_sql
String ls_user
String ls_from_date
String ls_to_date
Integer li_table_id
integer res

ls_original_sql = dw_audit.Object.DataWindow.Table.Select

ls_user =  dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'")  // Add by Stephen 03.30.2011 --- Fixed a bug.

IF ls_user <> "All" THEN
	if tab_1.tabpage_apps.rb_app_c.checked then
		ls_sql = ls_sql + " AND net_dev_action_items.create_user = '" + ls_user + "'"
	elseif tab_1.tabpage_apps.rb_app_m.checked then
		ls_sql = ls_sql + " AND net_dev_action_items.mod_user = '" + ls_user + "'"
	elseif tab_1.tabpage_apps.rb_app_d.checked then //(Appeon)Stephen 05.31.2016 - V15.2-Application Tracking full Auditing
		ls_sql = ls_sql + " AND  sys_audit_net_dev_action_delete.mod_user = '" + ls_user + "'"
	end if
END IF

IF sle_prac.Text <> "" AND NOT IsNull( sle_prac.Text ) THEN
	//ls_sql = ls_sql + " AND net_dev_action_items.prac_id= " + String( gl_prac_id )
	//---------Begin Modified by (Appeon)Stephen 05.31.2016 for V15.2-Application Tracking full Auditing--------
	//ls_sql = ls_sql + " AND net_dev_action_items.prac_id= " + String( il_prac_id )	//alfee 11.30.2012
	if tab_1.tabpage_apps.rb_app_d.checked then
		ls_sql = ls_sql + " AND  sys_audit_net_dev_action_delete.prac_id= " + String( il_prac_id )
	else
		ls_sql = ls_sql + " AND net_dev_action_items.prac_id= " + String( il_prac_id )	//alfee 11.30.2012
	end if
	//---------End Modfiied ------------------------------------------------------

END IF

dw_date_range.AcceptText()

ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		
		if tab_1.tabpage_apps.rb_app_c.checked then	//Start Code Change ----09.09.2011 #V12 maha - corrected button reference
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, net_dev_action_items.create_date,102) )  >= " + ls_from_date +&
									" AND convert(datetime, convert( varchar, net_dev_action_items.create_date,102) )  <= " + ls_to_date 
		elseif tab_1.tabpage_apps.rb_app_m.checked then
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, net_dev_action_items.mod_date,102) )  >= " + ls_from_date +&
									" AND convert(datetime, convert( varchar, net_dev_action_items.mod_date,102) )  <= " + ls_to_date 
		elseif tab_1.tabpage_apps.rb_app_d.checked then //(Appeon)Stephen 05.31.2016 - V15.2-Application Tracking full Auditing
			ls_sql = ls_sql + " AND convert(datetime,  convert( varchar,  sys_audit_net_dev_action_delete.mod_date,102) )  >= " + ls_from_date +&
									" AND convert(datetime, convert( varchar,  sys_audit_net_dev_action_delete.mod_date,102) )  <= " + ls_to_date 
		end if


	END IF
END IF

//only get records with mod dates
if tab_1.tabpage_apps.rb_app_c.checked then
	ls_sql = ls_sql + " AND net_dev_action_items.create_date is not null "
elseif tab_1.tabpage_apps.rb_app_m.checked then
	ls_sql = ls_sql + " AND net_dev_action_items.mod_date is not null "
elseif tab_1.tabpage_apps.rb_app_d.checked then //(Appeon)Stephen 05.31.2016 - V15.2-Application Tracking full Auditing
	ls_sql = ls_sql + " AND  sys_audit_net_dev_action_delete.mod_date is not null "	
end if




ls_sql = ls_original_sql + ls_sql

//messagebox("", ls_sql )

dw_audit.SetSQLSelect ( ls_sql )
dw_audit.SetTransObject( SQLCA )
res = dw_audit.Retrieve()

if res < 0 then
	messagebox("Audit Filter Failure", ls_sql )
end if

dw_audit.SetSQLSelect (ls_original_sql)

return 0
end function

public function integer of_prac_show (boolean ab_show); //Start Code Change ----08.03.2015 #V15 maha
 st_prac.visible = ab_show
 sle_prac.visible = ab_show
 cb_search.visible = ab_show
 cb_clear.visible = ab_show
 
 return 1

end function

public function integer wf_run_appaudit_filter ();//====================================================================
//$<Function>: wf_run_appaudit_filter
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.01.2016 (V15.2-Application Tracking full Auditing)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_sql
String ls_user
String ls_original_sql
String ls_from_date
String ls_to_date
Integer li_table_id
integer r

ls_user =  dw_select_user.GetItemString( 1, "user_id" )
ls_user =  of_ReviseExpValue(ls_user, "'") 

ls_original_sql = dw_audit.Object.DataWindow.Table.Select

IF ls_user <> "All" THEN
	ls_sql = ls_sql + " AND  sys_audit_appl.user_id = '" + ls_user + "'"
END IF

li_table_id = tab_1.tabpage_apps.dw_sele_appscreen.GetItemNumber( 1, "table_id" )

IF li_table_id <> 0 THEN
	ls_sql = ls_sql + " AND  sys_audit_appl.table_id = " + String( li_table_id )
END IF

IF sle_prac.Text <> "" AND NOT IsNull( sle_prac.Text ) THEN
	ls_sql = ls_sql + " AND  sys_audit_appl.prac_id= " + String( il_prac_id )	
END IF

dw_date_range.AcceptText()

ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_date_range.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
		dw_date_range.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		 
		ls_sql = ls_sql + " AND convert(datetime,  convert( varchar,  sys_audit_appl.date_time_modified,102) )  >= " + ls_from_date +&
							" AND convert(datetime, convert( varchar,  sys_audit_appl.date_time_modified,102) )  <= " + ls_to_date 
	END IF
END IF

if tab_1.tabpage_apps.rb_app_c.checked then
	ls_sql = ls_sql + " AND audit_type ='I' "
elseif tab_1.tabpage_apps.rb_app_m.checked then
	ls_sql = ls_sql + " AND audit_type in ('E' , 'E-S') "
elseif tab_1.tabpage_apps.rb_app_d.checked then
	ls_sql = ls_sql + " AND audit_type ='D' "
end if

ls_sql = ls_original_sql + ls_sql

r = dw_audit.SetSQLSelect ( ls_sql )
if r < 0 then openwithparm(w_sql_msg, ls_sql)
dw_audit.SetTransObject( SQLCA )
dw_audit.Retrieve()

dw_audit.SetSQLSelect (ls_original_sql)
return 0
end function

public function integer of_appl_audit_settings (boolean ab_true);//Start Code Change ----07.07.2016 #V152 maha
if ab_true then
	tab_1.tabpage_apps.st_scr.visible = true
	tab_1.tabpage_apps.dw_sele_appscreen.visible = true
	tab_1.tabpage_apps.rb_all.visible = true
	tab_1.tabpage_apps.rb_all.checked = true
	tab_1.tabpage_apps.gb_3.width = 1060
	tab_1.tabpage_apps.dw_sele_appscreen.setitem(1, "table_id", 0)
	dw_audit.dataobject =  'd_view_sys_audit_appl'	
	dw_audit.settransobject(sqlca)
else
	tab_1.tabpage_apps.st_scr.visible = false
	tab_1.tabpage_apps.dw_sele_appscreen.visible = false
	tab_1.tabpage_apps.rb_all.visible = false
	tab_1.tabpage_apps.rb_app_c.checked = true
	tab_1.tabpage_apps.gb_3.width = 914
	dw_audit.dataobject =  'd_view_audit_net_dev_actions'	
	dw_audit.settransobject(sqlca)
end if

wf_reset_st_run( )



return 1


end function

event open;call super::open;integer c //maha 07.15.2016

is_original_sql = dw_audit.Object.DataWindow.Table.Select

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.18.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product

IF Isvalid(w_mdi) THEN
	//Check Practitioner Data right
	IF gb_contract_version OR w_mdi.of_security_access( 5800 ) = 0 THEN
		tab_1.tabpage_1.Visible = False
		tab_1.Post SelectTab( 2 )
	END IF		
	
	//Check Contract Data right
	IF w_mdi.of_security_access( 5810 ) = 0 THEN
		tab_1.tabpage_2.Visible = False
	END IF
	
	//Check role Data right
	IF w_mdi.of_security_access( 7001 ) = 0 THEN
		tab_1.tabpage_roles.Visible = False
	END IF
	
	//Check user Data right
	IF w_mdi.of_security_access( 7011 ) = 0 THEN
		tab_1.tabpage_users.Visible = False
	END IF
	
	//Start Code Change ----12.14.2010 #V11 maha - privilege audits
	if of_get_app_setting("set_priv","I") = 0 then
		tab_1.tabpage_priv.Visible = False
		tab_1.tabpage_pracpriv.Visible = False
	end if
	//End Code Change ----12.14.2010
	
	//Start Code Change ----07.05.2016 #V152 maha - report audit
	IF w_mdi.of_security_access( 7825 ) = 0 THEN
		tab_1.tabpage_report.Visible = False
	END IF
	//End Code Change ----07.05.2016

END IF

//Start Code Change ----12.14.2010 #V11 maha 
if gb_sk_ver then
	tab_1.tabpage_2.Visible = False
	tab_1.tabpage_roles.Visible = False
	tab_1.tabpage_priv.Visible = False
	tab_1.tabpage_pracpriv.Visible = False
end if
//End Code Change ----12.14.2010

//---------Begin Added by (Appeon)Alfee 06.27.2013 for V141 ISG-CLX--------
//Set current contract id  when contract folder have been opened -- jervis 03.31.2011
long ll_ctx_id_tmp
if gb_contract_version and isvalid(gw_contract) then
	ll_ctx_id_tmp = gw_contract.tab_contract_details.tabpage_details.inv_contract_details.of_get_ctx_id( )
	if ll_ctx_id_tmp > 0 then
		tab_1.tabpage_2.dw_ctx.SetItem( 1,'contract_id',ll_ctx_id_tmp)
		tab_1.tabpage_2.dw_ctx.AcceptText ()
		st_run.event clicked( )
	end if
end if
//---------End Added ------------------------------------------------------------------

//Start Code Change ----12.08.2014 #V14.2 maha - added to set provider when opening
if gl_prac_id > 0 then
	nv_prac_info lnv_full_name
	lnv_full_name = CREATE nv_prac_info
	String ls_name
	il_prac_id = gl_prac_id
	ls_name = lnv_full_name.of_get_name( il_prac_id )
	DESTROY lnv_full_name	
	sle_prac.Text = ls_name
end if
//End Code Change ----12.08.2014

//---------Begin Added by (Appeon)Harry 03.15.2016 for BugH030701--------
if gb_contract_version then  
	cb_dp.visible = false
end if
//---------End Added ------------------------------------------------------------------

//Start Code Change ----07.15.2016 #V152 maha
c = of_get_app_setting("set_85","I") 
if c = 2 then 
	tab_1.tabpage_apps.cbx_appl_audit.checked = true
	of_appl_audit_settings(true)	
else
	of_appl_audit_settings(false)
	tab_1.tabpage_apps.cbx_appl_audit.checked = false
	tab_1.tabpage_apps.cbx_appl_audit.visible = false
end if
//End Code Change ----07.15.2016



end event

on w_view_audit.create
int iCurrent
call super::create
this.cb_clear=create cb_clear
this.cb_search=create cb_search
this.sle_prac=create sle_prac
this.st_prac=create st_prac
this.cb_dp=create cb_dp
this.dw_date_range=create dw_date_range
this.cb_2=create cb_2
this.st_7=create st_7
this.dw_select_user=create dw_select_user
this.st_run=create st_run
this.tab_1=create tab_1
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_help=create cb_help
this.cb_1=create cb_1
this.dw_audit=create dw_audit
this.gb_filters=create gb_filters
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_clear
this.Control[iCurrent+2]=this.cb_search
this.Control[iCurrent+3]=this.sle_prac
this.Control[iCurrent+4]=this.st_prac
this.Control[iCurrent+5]=this.cb_dp
this.Control[iCurrent+6]=this.dw_date_range
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_7
this.Control[iCurrent+9]=this.dw_select_user
this.Control[iCurrent+10]=this.st_run
this.Control[iCurrent+11]=this.tab_1
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.cb_print
this.Control[iCurrent+14]=this.cb_help
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.dw_audit
this.Control[iCurrent+17]=this.gb_filters
this.Control[iCurrent+18]=this.gb_2
end on

on w_view_audit.destroy
call super::destroy
destroy(this.cb_clear)
destroy(this.cb_search)
destroy(this.sle_prac)
destroy(this.st_prac)
destroy(this.cb_dp)
destroy(this.dw_date_range)
destroy(this.cb_2)
destroy(this.st_7)
destroy(this.dw_select_user)
destroy(this.st_run)
destroy(this.tab_1)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_help)
destroy(this.cb_1)
destroy(this.dw_audit)
destroy(this.gb_filters)
destroy(this.gb_2)
end on

event resize;call super::resize;tab_1.resize( newwidth , tab_1.height)

dw_audit.resize( newwidth - 20, newheight - 546)
end event

event activate;call super::activate;//Added by (Appeon)Alfee 06.27.2013 - V141 ISG-CLX

long ll_ctx_id_tmp, ll_contract_id

IF gb_contract_version THEN	
	//Switch MDI menu while to do list window get the focus. - jervis 05.09.2011
	if w_mdi.MenuName <> "m_pfe_cst_mdi_menu" then
		w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
		w_mdi.of_menu_security(w_mdi.MenuName)
	end if
	
	
	//Set current contract id  when contract folder have been opened -- jervis 05.09.2011
	if isvalid(gw_contract) then
		ll_ctx_id_tmp = gw_contract.tab_contract_details.tabpage_details.inv_contract_details.of_get_ctx_id( )
		//Added By Mark Lee 09/14/12
	//	if ll_ctx_id > 0  and ll_ctx_id <> dw_filter.GetItemNumber( 1,'contract_id') then
		ll_contract_id	= tab_1.tabpage_2.dw_ctx.GetItemNumber( 1,'contract_id')
		if ll_ctx_id_tmp > 0  and ll_ctx_id_tmp <> ll_contract_id and not isnull(ll_contract_id) then			
			tab_1.tabpage_2.dw_ctx.SetItem( 1,'contract_id',ll_ctx_id_tmp)
			st_run.event clicked( )
		end if
	end if
END IF
end event

type cb_clear from pfc_u_cb within w_view_audit
integer x = 1362
integer y = 348
integer width = 197
integer height = 84
integer taborder = 180
boolean bringtotop = true
string text = "&Clear"
boolean cancel = true
end type

event clicked;sle_prac.Text = ""
wf_reset_st_run( ) //(Appeon)Harry 11.25.2013 - V141 for BugH110601 of History Issues
end event

type cb_search from pfc_u_cb within w_view_audit
integer x = 1143
integer y = 348
integer width = 215
integer height = 84
integer taborder = 170
boolean bringtotop = true
string text = "&Search"
boolean cancel = true
end type

event clicked;gs_search lstr_search

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "AUDIT" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1

ELSE
	nv_prac_info lnv_full_name
	lnv_full_name = CREATE nv_prac_info
	String ls_name
	//---Begin Modified by Alfee 11.30.2012 ------
	il_prac_id = Message.DoubleParm
	ls_name = lnv_full_name.of_get_name( il_prac_id )
	//ls_name = lnv_full_name.of_get_name( gl_prac_id )
	//---End Modified --------------------------------	
	DESTROY lnv_full_name	
	sle_prac.Text = ls_name
	wf_reset_st_run( )
END IF

// + String( il_facility_id )
end event

type sle_prac from singlelineedit within w_view_audit
integer x = 247
integer y = 352
integer width = 887
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
end type

type st_prac from statictext within w_view_audit
integer x = 27
integer y = 360
integer width = 215
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Provider:"
boolean focusrectangle = false
end type

type cb_dp from pfc_u_cb within w_view_audit
integer x = 2610
integer y = 88
integer width = 457
integer height = 84
integer taborder = 150
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Deleted Providers"
boolean cancel = true
end type

event clicked;open(w_audit_entity_delete)
end event

type dw_date_range from u_dw within w_view_audit
integer x = 544
integer y = 36
integer width = 946
integer height = 144
integer taborder = 140
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

event itemchanged;call super::itemchanged;//wf_reset_st_run( )  //(Appeon)Harry 11.25.2013 - V141 for BugH110601 of History Issues
end event

event editchanged;call super::editchanged;//---------Begin Added by (Appeon)Harry 11.24.2014 for BugH101101--------
DateTime ldt_null
If IsNull(data) or data = "" Then
	SetNull(ldt_null)
	Choose Case dwo.name
		Case 'from_date'
			this.setitem(1, 'from_date', ldt_null)
		Case 'to_date'
			this.setitem(1, 'to_date', ldt_null)
	End Choose
End If
//---------End Added ------------------------------------------------------

wf_reset_st_run( ) //(Appeon)Harry 11.25.2013 - V141 for BugH110601 of History Issues
end event

type cb_2 from commandbutton within w_view_audit
integer x = 1518
integer y = 88
integer width = 325
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset"
end type

event clicked;//Start Code Change ----05.15.2009 #V92 maha - added
datetime ldt_null

setnull(ldt_null)

dw_select_user.setitem(1,"user_id","All")
dw_date_range.setitem(1,"from_date",ldt_null)
dw_date_range.setitem(1,"to_date",ldt_null)

wf_reset_st_run( )
end event

type st_7 from statictext within w_view_audit
integer x = 64
integer y = 44
integer width = 430
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Modified by User"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_select_user from u_dw within w_view_audit
integer x = 59
integer y = 96
integer width = 462
integer height = 84
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_select_user_for_audit_trail"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

DataWindowChild dwchild

This.GetChild( "user_id", dwchild )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "user_id", "All" )

This.SetItem( 1, "user_id", "All" )
end event

event itemchanged;call super::itemchanged;wf_reset_st_run( )
end event

type st_run from statictext within w_view_audit
integer x = 1915
integer y = 88
integer width = 325
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Run Filter"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
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
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 26 October 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

st_run.BorderStyle = StyleLowered!
st_run.TextColor = 0
st_run.Enabled = False
debugbreak()
choose case dw_audit.dataobject
	case 'd_view_audit', 'd_view_audit_with_wv'   //Start Code Change ----09.02.2015 #V15 maha
		wf_run_filter_prac()
	case 'd_view_audit_ctx'
      		wf_run_filter_ctx()
	case 'd_view_role_audit'
		wf_audit_role( )
	case 'd_view_audit_user'
		wf_audit_user( )
	case 'd_priv_audit_painter'
		wf_run_audit_filter("Priv Painter")
	case 'd_priv_audit_report_prac'
		//wf_prac_priv()
		wf_run_audit_filter("Priv Prac")
	case 'd_view_audit_net_dev_actions' , 'd_view_audit_net_dev_actions_del' //(Appeon)Stephen 05.31.2016 -add 'd_view_audit_net_dev_actions_del' V15.2-Application Tracking full Auditing
		wf_run_filter_net_dev()
	case 'd_verif_view_audit'	,'d_verif_view_audit_delete'
		wf_run_filter_verif()
	case 'd_view_sys_audit_appl' //(Appeon)Stephen 06.03.2016 - V15.2-Application Tracking full Auditing
		wf_run_appaudit_filter()
	case "d_report_audit_report"  //Start Code Change ----06.16.2016 #V152 maha
		wf_run_audit_filter("Reports")
end choose 
end event

type tab_1 from tab within w_view_audit
integer y = 212
integer width = 4069
integer height = 252
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
boolean createondemand = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_roles tabpage_roles
tabpage_users tabpage_users
tabpage_priv tabpage_priv
tabpage_pracpriv tabpage_pracpriv
tabpage_apps tabpage_apps
tabpage_verif tabpage_verif
tabpage_report tabpage_report
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_roles=create tabpage_roles
this.tabpage_users=create tabpage_users
this.tabpage_priv=create tabpage_priv
this.tabpage_pracpriv=create tabpage_pracpriv
this.tabpage_apps=create tabpage_apps
this.tabpage_verif=create tabpage_verif
this.tabpage_report=create tabpage_report
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_roles,&
this.tabpage_users,&
this.tabpage_priv,&
this.tabpage_pracpriv,&
this.tabpage_apps,&
this.tabpage_verif,&
this.tabpage_report}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_roles)
destroy(this.tabpage_users)
destroy(this.tabpage_priv)
destroy(this.tabpage_pracpriv)
destroy(this.tabpage_apps)
destroy(this.tabpage_verif)
destroy(this.tabpage_report)
end on

event selectionchanged;integer c

choose case newindex
	case 1
		if of_get_app_setting("set_web","I") = 1 then  //Start Code Change ----08.18.2015 #V15 maha
			dw_audit.dataobject =  'd_view_audit_with_wv'
		else
			dw_audit.dataobject =  'd_view_audit'
		end if
	case 2
	  	dw_audit.dataobject =  'd_view_audit_ctx'
	//Start Code Change ----06.12.2009 #V92 maha - new audits
	case 3
	  	dw_audit.dataobject =  'd_view_role_audit'
	case 4
	  	dw_audit.dataobject =  'd_view_audit_user'
	//End Code Change---06.12.2009
	case 5 //priv painter
		dw_audit.dataobject =  'd_priv_audit_painter'	
	case 6 //prac privileges
		dw_audit.dataobject =  'd_priv_audit_report_prac'	
	Case 7 //apps
		//Start Code Change ----07.15.2016 #V152 maha - just set the dw object; other settings in open event and clicked of checkbox
		if tab_1.tabpage_apps.cbx_appl_audit.checked = true then
			dw_audit.dataobject =  'd_view_sys_audit_appl'	
		else
			dw_audit.dataobject =  'd_view_audit_net_dev_actions'
		end if
			
//		//Start Code Change ----07.07.2016 #V153 maha - added setting check and function call
//		c = of_get_app_setting("set_85","I") 
//		if c = 2 then 
//			tab_1.tabpage_apps.cbx_appl_audit.checked = true //(Appeon)Stephen 07.13.2016 - V15.2-Application Tracking full Auditing
//			of_appl_audit_settings(true)
////			tab_1.tabpage_apps.cbx_appl_audit.checked = true
////			dw_audit.dataobject =  'd_view_sys_audit_appl'	
//		else
//			of_appl_audit_settings(false)
////			tab_1.tabpage_apps.cbx_appl_audit.checked = false //(Appeon)Stephen 06.13.2016 - V15.2-Application Tracking full Auditing
////			tab_1.tabpage_apps.cbx_appl_audit.visible = false
////			dw_audit.dataobject =  'd_view_audit_net_dev_actions'
//		end if
//		//End Code Change ----07.07.2016	
		//End Code Change ----07.15.2016
	case 8 //verif      //Start Code Change ----08.05.2011 #V11 maha - verif audit
		if tab_1.tabpage_verif.rb_vd.checked then
			dw_audit.dataobject =  'd_verif_view_audit_delete'
		else
			dw_audit.dataobject =  'd_verif_view_audit'
		end if
	case 9 //reports  //Start Code Change ----06.16.2016 #V152 maha
		dw_audit.dataobject = "d_report_audit_report"
end choose 

 //Start Code Change ----09.03.2015 #V15 maha - code for hiding provider select
choose case newindex
	case 1, 6, 7, 8
		of_prac_show(true)
	case else
		of_prac_show(false)	
end choose 
 //End Code Change ----09.03.2015

dw_audit.settransobject( sqlca)

is_original_sql = dw_audit.Object.DataWindow.Table.Select //(Appeon)Stephen 09.10.2015 - Issues with WebView columns in Audit trail (FR #4664 - Added the WebView acceptance date and accepting user to the audit trail screen for WV customers.)
wf_reset_st_run( )  //Start Code Change ----08.05.2011 #V11 maha - changed to use function
end event

event constructor;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 25 October 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_count
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.18.2006 By: Cao YongWang
//$<reason> The sys.systable table not exists in SQL Server,
//$<reason> Replace it with v_systable if the appliation running in SQL Server.
/*
select count(*)
into :ll_count
from sys.systable 
where table_name='CTX_BASIC_INFO' ;
*/
Choose Case gs_dbType
	Case 'ASA'
		select count(*) into :ll_count from sys.systable where table_name = 'CTX_BASIC_INFO';
	Case 'SQL'
		select count(*) into :ll_count from v_systable where table_name = 'CTX_BASIC_INFO';
End Choose
//---------------------------- APPEON END ----------------------------
	  
if of_get_app_setting("set_cont","I") = 0 or ll_count < 1 then
		 this.tabpage_2.visible = false
end if

//for BugH110602  - Eugene 11.13.2013
if gb_contract_version then
	this.tabpage_1.visible = false
	this.tabpage_roles.visible = false
	this.tabpage_users.visible = false
	this.tabpage_priv.visible = false
	this.tabpage_pracpriv.visible = false
	this.tabpage_apps.visible = false
	this.tabpage_verif.visible = false
end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4032
integer height = 136
long backcolor = 33551856
string text = "Practitioner"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
st_5 st_5
dw_select_screen dw_select_screen
end type

on tabpage_1.create
this.st_5=create st_5
this.dw_select_screen=create dw_select_screen
this.Control[]={this.st_5,&
this.dw_select_screen}
end on

on tabpage_1.destroy
destroy(this.st_5)
destroy(this.dw_select_screen)
end on

type st_5 from statictext within tabpage_1
integer x = 1774
integer y = 44
integer width = 256
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Screen:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_select_screen from u_dw within tabpage_1
integer x = 2053
integer y = 32
integer width = 727
integer height = 84
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_select_screen_for_field_audit"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

DataWindowChild dwchild

This.GetChild( "table_id", dwchild )

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.26.2014
//<$>reason:Bug 4379 created for Case# 00051492: Audit Trail Issue 

//---------Begin Added by (Appeon)Alfee 12.24.2014 for Bug 4379  -------------------
//dwchild.SetFilter("table_id not in (51,52,53,61,62)")
dwchild.SetFilter("table_id not in (53,61,62)")
dwchild.Filter()
//---------End Added ------------------------------------------------------------------------

//------------------- APPEON END -------------------

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "table_name_allias", "All" )
dwchild.SetItem( 1, "table_id", 0 )

This.SetItem( 1, "table_id", 0 )
end event

event itemchanged;call super::itemchanged;//Start Code Change ---- 02.09.2006 #264 maha
wf_reset_st_run()
//End Code Change---02.09.2006

end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4032
integer height = 136
long backcolor = 33551856
string text = "Contract"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
dw_ctx dw_ctx
st_6 st_6
dw_tables dw_tables
st_4 st_4
end type

on tabpage_2.create
this.dw_ctx=create dw_ctx
this.st_6=create st_6
this.dw_tables=create dw_tables
this.st_4=create st_4
this.Control[]={this.dw_ctx,&
this.st_6,&
this.dw_tables,&
this.st_4}
end on

on tabpage_2.destroy
destroy(this.dw_ctx)
destroy(this.st_6)
destroy(this.dw_tables)
destroy(this.st_4)
end on

type dw_ctx from u_dw within tabpage_2
integer x = 343
integer y = 36
integer width = 837
integer height = 80
integer taborder = 11
string dataobject = "d_ext_ctx"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;// start code change --- 11.01.2005 MSKINNER
if of_get_app_setting("set_cont","I") = 1 then
	 
	 long ll_count
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.18.2006 By: Cao YongWang
	//$<reason> The sys.systable table not exists in SQL Server,
	//$<reason> Replace it with v_systable if the appliation running in SQL Server.
	/*
	select count(*)
	into :ll_count
	from sys.systable 
	where table_name='CTX_BASIC_INFO' ;
	*/
	Choose Case gs_dbType
		Case 'ASA'
			select count(*) into :ll_count from sys.systable where table_name = 'CTX_BASIC_INFO';
		Case 'SQL'
			select count(*) into :ll_count from v_systable where table_name = 'CTX_BASIC_INFO';
	End Choose
	//---------------------------- APPEON END ----------------------------

	 if ll_count < 1 then return 
	

	 
	 
	 This.of_SetUpdateAble( False )
	 This.of_SetTransObject( SQLCA )
	 This.InsertRow( 0 )
	 DataWindowChild dwchild
	 This.GetChild( "table_id", dwchild )
	 dwchild.InsertRow( 1 )
	 dwchild.SetItem( 1, "table_name_allias", "All" )
	dwchild.SetItem( 1, "table_id", 0 )
end if
// end code change --- 11.01.2005 MSKINNER




end event

event itemchanged;call super::itemchanged;
wf_reset_st_run( )


ll_ctx_id = long(data)
end event

type st_6 from statictext within tabpage_2
integer x = 87
integer y = 52
integer width = 229
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contract:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_tables from u_dw within tabpage_2
integer x = 1650
integer y = 24
integer width = 1225
integer height = 76
integer taborder = 11
string dataobject = "d_select_screen_for_field_audit_ctx"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-08-21 By: Evan
//$<Reason> Insert null row to DDDW.
//insertrow(0)
DataWindowChild ldwc_Child

this.InsertRow(0)
this.GetChild("table_id", ldwc_Child)
ldwc_Child.InsertRow(1)
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;wf_reset_st_run( )
end event

type st_4 from statictext within tabpage_2
integer x = 1243
integer y = 44
integer width = 407
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contract Screen:"
alignment alignment = right!
boolean focusrectangle = false
end type

type tabpage_roles from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4032
integer height = 136
long backcolor = 33551856
string text = "Roles"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
st_1 st_1
dw_role dw_role
end type

on tabpage_roles.create
this.st_1=create st_1
this.dw_role=create dw_role
this.Control[]={this.st_1,&
this.dw_role}
end on

on tabpage_roles.destroy
destroy(this.st_1)
destroy(this.dw_role)
end on

type st_1 from statictext within tabpage_roles
integer x = 128
integer y = 48
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Role:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_role from datawindow within tabpage_roles
integer x = 343
integer y = 16
integer width = 1147
integer height = 108
integer taborder = 21
string title = "none"
string dataobject = "d_security_select_roles"
boolean border = false
boolean livescroll = true
end type

event constructor;datawindowchild dwchild

this.SetTransObject( SQLCA )
This.Retrieve()
This.InsertRow( 0 )

this.getchild("role_id",dwchild)
dwchild.insertrow(1)

end event

event itemchanged;ii_role = integer(data)
wf_reset_st_run( )

end event

type tabpage_users from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4032
integer height = 136
long backcolor = 33551856
string text = "Users"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
st_2 st_2
dw_userid dw_userid
end type

on tabpage_users.create
this.st_2=create st_2
this.dw_userid=create dw_userid
this.Control[]={this.st_2,&
this.dw_userid}
end on

on tabpage_users.destroy
destroy(this.st_2)
destroy(this.dw_userid)
end on

type st_2 from statictext within tabpage_users
integer x = 46
integer y = 48
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "User Id:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_userid from datawindow within tabpage_users
integer x = 343
integer y = 32
integer width = 507
integer height = 92
integer taborder = 150
string title = "none"
string dataobject = "d_select_user_for_audit_trail"
boolean border = false
boolean livescroll = true
end type

event constructor;datawindowchild dwchild

this.SetTransObject( SQLCA )
This.Retrieve()
This.InsertRow( 0 )

this.getchild("user_id",dwchild)
dwchild.insertrow(1)
end event

event itemchanged;is_user_id = data
wf_reset_st_run( )
end event

type tabpage_priv from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4032
integer height = 136
long backcolor = 33551856
string text = "Privileges"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
end type

type tabpage_pracpriv from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4032
integer height = 136
long backcolor = 33551856
string text = "Prac Priv"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
end type

type tabpage_apps from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4032
integer height = 136
long backcolor = 33551856
string text = "Appl Actions"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
rb_all rb_all
dw_sele_appscreen dw_sele_appscreen
st_scr st_scr
cbx_appl_audit cbx_appl_audit
rb_app_d rb_app_d
rb_app_m rb_app_m
rb_app_c rb_app_c
gb_3 gb_3
end type

on tabpage_apps.create
this.rb_all=create rb_all
this.dw_sele_appscreen=create dw_sele_appscreen
this.st_scr=create st_scr
this.cbx_appl_audit=create cbx_appl_audit
this.rb_app_d=create rb_app_d
this.rb_app_m=create rb_app_m
this.rb_app_c=create rb_app_c
this.gb_3=create gb_3
this.Control[]={this.rb_all,&
this.dw_sele_appscreen,&
this.st_scr,&
this.cbx_appl_audit,&
this.rb_app_d,&
this.rb_app_m,&
this.rb_app_c,&
this.gb_3}
end on

on tabpage_apps.destroy
destroy(this.rb_all)
destroy(this.dw_sele_appscreen)
destroy(this.st_scr)
destroy(this.cbx_appl_audit)
destroy(this.rb_app_d)
destroy(this.rb_app_m)
destroy(this.rb_app_c)
destroy(this.gb_3)
end on

type rb_all from radiobutton within tabpage_apps
integer x = 2464
integer y = 60
integer width = 142
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.14.2016 (V15.2-Application Tracking full Auditing)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
wf_reset_st_run( )
end event

type dw_sele_appscreen from u_dw within tabpage_apps
integer x = 2821
integer y = 48
integer width = 626
integer height = 84
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_select_app_screen_audit"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

DataWindowChild dwchild

This.GetChild( "table_id", dwchild )

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.26.2014
//<$>reason:Bug 4379 created for Case# 00051492: Audit Trail Issue 

//---------Begin Added by (Appeon)Alfee 12.24.2014 for Bug 4379  -------------------
//dwchild.SetFilter("table_id not in (51,52,53,61,62)")
dwchild.SetFilter("table_id not in (53,61,62)")
dwchild.Filter()
//---------End Added ------------------------------------------------------------------------

//------------------- APPEON END -------------------

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "table_name_allias", "All" )
dwchild.SetItem( 1, "table_id", 0 )

This.SetItem( 1, "table_id", 0 )
end event

event itemchanged;call super::itemchanged;//Start Code Change ---- 02.09.2006 #264 maha
wf_reset_st_run()
//End Code Change---02.09.2006

end event

type st_scr from statictext within tabpage_apps
integer x = 2638
integer y = 60
integer width = 183
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Screen:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_appl_audit from checkbox within tabpage_apps
integer x = 3470
integer y = 56
integer width = 521
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Field level audit"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.13.2016 (V15.2-Application Tracking full Auditing)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Start Code Change ----07.07.2016 #V152 maha - changed to function call
if this.checked then
	of_appl_audit_settings(true)
//	st_scr.visible = true
//	dw_sele_appscreen.visible = true
//	rb_all.visible = true
//	rb_all.checked = true
//	gb_3.width = 1060
//	dw_sele_appscreen.setitem(1, "table_id", 0)
//	dw_audit.dataobject =  'd_view_sys_audit_appl'	
//	dw_audit.settransobject(sqlca)
else
	of_appl_audit_settings(false)
//	st_scr.visible = false
//	dw_sele_appscreen.visible = false
//	rb_all.visible = false
//	rb_app_c.checked = true
//	gb_3.width = 914
//	dw_audit.dataobject =  'd_view_audit_net_dev_actions'	
//	dw_audit.settransobject(sqlca)
end if
//wf_reset_st_run( )
end event

type rb_app_d from radiobutton within tabpage_apps
integer x = 2171
integer y = 56
integer width = 279
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Deleted"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.31.2016 (V15.2-Application Tracking full Auditing)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//---------Begin Added by (Appeon)Stephen 05.31.2016 for V15.2-Application Tracking full Auditing--------
if cbx_appl_audit.checked = false then
	if dw_audit.dataobject <>  'd_view_audit_net_dev_actions_del' then
		dw_audit.dataobject =  'd_view_audit_net_dev_actions_del'
		dw_audit.settransobject(sqlca)
	end if
end if
//---------End Added ------------------------------------------------------
wf_reset_st_run( )
end event

type rb_app_m from radiobutton within tabpage_apps
integer x = 1856
integer y = 56
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Modified"
end type

event clicked;//---------Begin Added by (Appeon)Stephen 05.31.2016 for V15.2-Application Tracking full Auditing--------
if cbx_appl_audit.checked = false then
	if dw_audit.dataobject <>  'd_view_audit_net_dev_actions' then
		dw_audit.dataobject =  'd_view_audit_net_dev_actions'
		dw_audit.settransobject(sqlca)
	end if
end if
//---------End Added ------------------------------------------------------
wf_reset_st_run( )
end event

type rb_app_c from radiobutton within tabpage_apps
integer x = 1577
integer y = 56
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Created"
end type

event clicked;//---------Begin Added by (Appeon)Stephen 05.31.2016 for V15.2-Application Tracking full Auditing--------
if cbx_appl_audit.checked = false then
	if dw_audit.dataobject <>  'd_view_audit_net_dev_actions' then
		dw_audit.dataobject =  'd_view_audit_net_dev_actions'
		dw_audit.settransobject(sqlca)
	end if
end if
//---------End Added ------------------------------------------------------
wf_reset_st_run( )
end event

type gb_3 from groupbox within tabpage_apps
integer x = 1563
integer y = 4
integer width = 1070
integer height = 124
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Search Type"
end type

type tabpage_verif from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4032
integer height = 136
long backcolor = 33551856
string text = "Verifications"
long tabtextcolor = 33554432
long tabbackcolor = 134217747
long picturemaskcolor = 536870912
rb_vb rb_vb
rb_vh rb_vh
rb_va rb_va
rb_vd rb_vd
rb_vm rb_vm
rb_vc rb_vc
gb_vertype gb_vertype
gb_1 gb_1
end type

on tabpage_verif.create
this.rb_vb=create rb_vb
this.rb_vh=create rb_vh
this.rb_va=create rb_va
this.rb_vd=create rb_vd
this.rb_vm=create rb_vm
this.rb_vc=create rb_vc
this.gb_vertype=create gb_vertype
this.gb_1=create gb_1
this.Control[]={this.rb_vb,&
this.rb_vh,&
this.rb_va,&
this.rb_vd,&
this.rb_vm,&
this.rb_vc,&
this.gb_vertype,&
this.gb_1}
end on

on tabpage_verif.destroy
destroy(this.rb_vb)
destroy(this.rb_vh)
destroy(this.rb_va)
destroy(this.rb_vd)
destroy(this.rb_vm)
destroy(this.rb_vc)
destroy(this.gb_vertype)
destroy(this.gb_1)
end on

type rb_vb from radiobutton within tabpage_verif
integer x = 3474
integer y = 60
integer width = 210
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Both"
end type

event clicked;wf_reset_st_run( )
end event

type rb_vh from radiobutton within tabpage_verif
integer x = 3218
integer y = 60
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "History"
end type

event clicked;wf_reset_st_run( )
end event

type rb_va from radiobutton within tabpage_verif
integer x = 2962
integer y = 60
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Active"
boolean checked = true
end type

event clicked;wf_reset_st_run( )
end event

type rb_vd from radiobutton within tabpage_verif
integer x = 2519
integer y = 60
integer width = 283
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Deleted"
end type

event clicked;dw_audit.dataobject =  'd_verif_view_audit_delete'
dw_audit.settransobject(sqlca)

wf_reset_st_run( )
end event

type rb_vm from radiobutton within tabpage_verif
integer x = 2185
integer y = 60
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Modified"
boolean checked = true
end type

event clicked;dw_audit.dataobject =  'd_verif_view_audit'
dw_audit.settransobject(sqlca)

wf_reset_st_run( )
end event

type rb_vc from radiobutton within tabpage_verif
integer x = 1902
integer y = 60
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Created"
end type

event clicked;dw_audit.dataobject =  'd_verif_view_audit'
dw_audit.settransobject(sqlca)

wf_reset_st_run( )



end event

type gb_vertype from groupbox within tabpage_verif
integer x = 1865
integer y = 8
integer width = 969
integer height = 124
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Search type"
end type

type gb_1 from groupbox within tabpage_verif
integer x = 2866
integer y = 8
integer width = 846
integer height = 124
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status"
end type

type tabpage_report from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4032
integer height = 136
long backcolor = 33551856
string text = "Reports"
long tabtextcolor = 33554432
long tabbackcolor = 33551856
long picturemaskcolor = 536870912
st_3 st_3
ddlb_rpt_type ddlb_rpt_type
end type

on tabpage_report.create
this.st_3=create st_3
this.ddlb_rpt_type=create ddlb_rpt_type
this.Control[]={this.st_3,&
this.ddlb_rpt_type}
end on

on tabpage_report.destroy
destroy(this.st_3)
destroy(this.ddlb_rpt_type)
end on

type st_3 from statictext within tabpage_report
integer x = 1669
integer y = 52
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Report Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_rpt_type from dropdownlistbox within tabpage_report
integer x = 2103
integer y = 36
integer width = 453
integer height = 416
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"IntelliReport","Export","One-Click","All"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;wf_reset_st_run( ) 
end event

type cb_close from pfc_u_cb within w_view_audit
integer x = 3753
integer y = 88
integer width = 325
integer height = 84
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;Close( Parent )
end event

type cb_print from pfc_u_cb within w_view_audit
integer x = 3090
integer y = 88
integer width = 325
integer height = 84
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Print"
boolean cancel = true
end type

event clicked;dw_audit.Print()
end event

type cb_help from pfc_u_cb within w_view_audit
integer x = 2254
integer y = 88
integer width = 325
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Sort"
boolean cancel = true
end type

event clicked;dw_audit.Event pfc_SortDlg()

dw_audit.SetFocus()
end event

type cb_1 from pfc_u_cb within w_view_audit
integer x = 3419
integer y = 88
integer width = 325
integer height = 84
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Export"
boolean cancel = true
end type

event clicked;call super::clicked;gnv_dw.of_SaveAs(dw_audit)//.saveas() Modify by Evan 05.11.2010
ChangeDirectory(gs_current_path)//For restore directory  Added by Nova 07.10.2009
end event

type dw_audit from u_dw within w_view_audit
integer x = 5
integer y = 476
integer width = 4069
integer height = 1480
integer taborder = 10
string dataobject = "d_view_audit"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;This.of_SetUpdateAble( False )

This.of_SetTransObject(SQLCA)

This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(1)

This.inv_sort.of_SetColumnHeader(True)


end event

type gb_filters from groupbox within w_view_audit
integer width = 1883
integer height = 196
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters:"
end type

type gb_2 from groupbox within w_view_audit
integer x = 1787
integer y = 252
integer width = 411
integer height = 324
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
end type

