$PBExportHeader$w_copy_reportwriter.srw
forward
global type w_copy_reportwriter from w_response
end type
type st_database from statictext within w_copy_reportwriter
end type
type sle_server from singlelineedit within w_copy_reportwriter
end type
type st_server_ip from statictext within w_copy_reportwriter
end type
type cb_server from commandbutton within w_copy_reportwriter
end type
type rb_other from radiobutton within w_copy_reportwriter
end type
type rb_current from radiobutton within w_copy_reportwriter
end type
type st_server from statictext within w_copy_reportwriter
end type
type dw_passdb from datawindow within w_copy_reportwriter
end type
type cb_close from commandbutton within w_copy_reportwriter
end type
type cb_copy from commandbutton within w_copy_reportwriter
end type
type dw_view from u_dw within w_copy_reportwriter
end type
type ddlb_souredbname from dropdownlistbox within w_copy_reportwriter
end type
type gb_db from groupbox within w_copy_reportwriter
end type
type gb_sourceview from groupbox within w_copy_reportwriter
end type
end forward

global type w_copy_reportwriter from w_response
integer width = 3237
integer height = 2200
string title = "Copy Report Writer"
long backcolor = 33551856
string icon = "AppIcon!"
st_database st_database
sle_server sle_server
st_server_ip st_server_ip
cb_server cb_server
rb_other rb_other
rb_current rb_current
st_server st_server
dw_passdb dw_passdb
cb_close cb_close
cb_copy cb_copy
dw_view dw_view
ddlb_souredbname ddlb_souredbname
gb_db gb_db
gb_sourceview gb_sourceview
end type
global w_copy_reportwriter w_copy_reportwriter

type prototypes

end prototypes

type variables
String 			is_alias_server
Boolean			ibn_flag	=  False							//record the flag for connect server.
end variables

forward prototypes
public function boolean of_existdataview (string as_dbname)
public function integer of_check_version (string as_sourcedb, string as_targetdb)
public subroutine of_setsourcedb (boolean abn_flag)
end prototypes

public function boolean of_existdataview (string as_dbname);String	ls_SQL

//Added By Mark Lee 03/04/2013
ls_SQL = &
"  select  name" + &
"    from " + as_DBName + ".dbo.sysobjects" + &
"   where xtype = 'U' and  name = 'conv_view'"

dw_PassDB.SetSQLSelect(ls_SQL)
dw_PassDB.SetTransObject(SQLCA)
dw_PassDB.Retrieve()

if dw_PassDB.RowCount() > 0 then
	Return true
else
	Return false
end if

end function

public function integer of_check_version (string as_sourcedb, string as_targetdb);Integer li_version_s,li_version_t
String ls_version_patch_s, ls_version_patch_t
String ls_sqlstatement_s, ls_sqlstatement_t

DECLARE my_cursor1 DYNAMIC CURSOR FOR SQLSA ;
ls_sqlstatement_s = "SELECT set_18,set_patch_ver FROM "+as_sourcedb+".dbo.icred_settings "
PREPARE SQLSA FROM :ls_sqlstatement_s ;
OPEN DYNAMIC my_cursor1;
FETCH my_cursor1 INTO :li_version_s,:ls_version_patch_s ;
CLOSE my_cursor1 ;


DECLARE my_cursor2 DYNAMIC CURSOR FOR SQLSA ;
ls_sqlstatement_t = "SELECT set_18,set_patch_ver FROM "+as_targetdb+".dbo.icred_settings "
PREPARE SQLSA FROM :ls_sqlstatement_t ;
OPEN DYNAMIC my_cursor2;
FETCH my_cursor2 INTO :li_version_t,:ls_version_patch_t ;
CLOSE my_cursor2 ;

If li_version_s <> li_version_t or ls_version_patch_s <> ls_version_patch_t Then
	If Messagebox('Alert','The source database version ('+String(li_version_s) + '.' + ls_version_patch_s +') is different from the target database version ('+String(li_version_t) + '.' + ls_version_patch_t +'). ~r~nThe implementation of Copy may cause problems, do you want to continue?',Question!, YesNo!,2) = 2 Then
		Return -1
	End If
End If


Return 1
end function

public subroutine of_setsourcedb (boolean abn_flag);//====================================================================
// Function: of_setsourcedb
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                abn_flag
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 02/22/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
n_ds 			lds_DBList
String 		ls_tmp,	ls_SQL, ls_DBName,	ls_new_DBName
Long 			ll_Cycle,	ll_RowCnt

ddlb_SoureDBName.reset()
lds_DBList = Create n_ds
lds_DBList.DataObject = "d_alldbname"
lds_DBList.SetTransObject(SQLCA)

IF abn_flag = True Then
	If isnull(sle_server.text) or Trim(sle_server.text) = '' Then 
		Destroy lds_DBList
		Return 
	End If 

	ls_SQL = " SELECT  name FROM "+is_alias_server+".master.dbo.sysdatabases  " + & 
				" ORDER BY  name ASC "
	lds_DBList.SetSQLSelect(ls_SQL)					
	lds_DBList.SetTransObject(SQLCA)			//need it for setsqlselect()
Else
	is_alias_server = ""					//reset
End If 

lds_DBList.Retrieve()
	
ll_RowCnt = lds_DBList.RowCount()
for ll_Cycle = 1 to ll_RowCnt
	ls_DBName = lds_DBList.GetItemString(ll_Cycle,"Name")
	ls_new_DBName = "["+ls_DBName+"]"			//Added By Mark Lee 09/18/2013		
	If is_alias_server <> "" Then 
		ls_tmp = is_alias_server +'.' + ls_new_DBName 
	Else
		ls_tmp = ls_new_DBName
	End IF 
	if of_ExistDataView(  ls_tmp ) then
		ddlb_SoureDBName.AddItem(ls_DBName)
	end if
next

Destroy lds_DBList

end subroutine

on w_copy_reportwriter.create
int iCurrent
call super::create
this.st_database=create st_database
this.sle_server=create sle_server
this.st_server_ip=create st_server_ip
this.cb_server=create cb_server
this.rb_other=create rb_other
this.rb_current=create rb_current
this.st_server=create st_server
this.dw_passdb=create dw_passdb
this.cb_close=create cb_close
this.cb_copy=create cb_copy
this.dw_view=create dw_view
this.ddlb_souredbname=create ddlb_souredbname
this.gb_db=create gb_db
this.gb_sourceview=create gb_sourceview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_database
this.Control[iCurrent+2]=this.sle_server
this.Control[iCurrent+3]=this.st_server_ip
this.Control[iCurrent+4]=this.cb_server
this.Control[iCurrent+5]=this.rb_other
this.Control[iCurrent+6]=this.rb_current
this.Control[iCurrent+7]=this.st_server
this.Control[iCurrent+8]=this.dw_passdb
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.cb_copy
this.Control[iCurrent+11]=this.dw_view
this.Control[iCurrent+12]=this.ddlb_souredbname
this.Control[iCurrent+13]=this.gb_db
this.Control[iCurrent+14]=this.gb_sourceview
end on

on w_copy_reportwriter.destroy
call super::destroy
destroy(this.st_database)
destroy(this.sle_server)
destroy(this.st_server_ip)
destroy(this.cb_server)
destroy(this.rb_other)
destroy(this.rb_current)
destroy(this.st_server)
destroy(this.dw_passdb)
destroy(this.cb_close)
destroy(this.cb_copy)
destroy(this.dw_view)
destroy(this.ddlb_souredbname)
destroy(this.gb_db)
destroy(this.gb_sourceview)
end on

event open;String		ls_DBName,	ls_new_DBName
long		ll_Cycle,ll_RowCnt

DataStore		lds_DBList

dw_View.SetTransObject(SQLCA)
dw_PassDB.SetTransObject(SQLCA)

lds_DBList = Create DataStore
lds_DBList.DataObject = "d_alldbname"
lds_DBList.SetTransObject(SQLCA)
lds_DBList.Retrieve()

//Added By Mark Lee 03/01/2013
is_alias_server = ""
rb_current.checked = True
rb_other.checked = False
sle_server.enabled = False


ll_RowCnt = lds_DBList.RowCount()
for ll_Cycle = 1 to ll_RowCnt
	ls_DBName = lds_DBList.GetItemString(ll_Cycle,"Name")
	ls_new_DBName = "["+ls_DBName+"]"			//Added By Mark Lee 09/18/2013	
	if of_ExistDataView(ls_new_DBName) then
		ddlb_SoureDBName.AddItem(ls_DBName)
	end if
next

Destroy lds_DBList

end event

event close;call super::close;//Added By Mark Lee 03/04/2013
String 		ls_sql	,	ls_output

If ibn_flag  = true Then 
	is_alias_server =  "CLXServer"+gs_session_id
	ls_sql = " exec sp_droplinkedsrvlogin " + is_alias_server + ",null "
//	of_execute(ls_sql,this.title )
	gnv_string.of_exec_sql( ls_sql, ls_output)
	
	ls_sql = " exec sp_dropserver  " + is_alias_server  
//	of_execute(ls_sql,this.title )
	gnv_string.of_exec_sql( ls_sql, ls_output)

	Commit; 					//need it 
ENd If
end event

type st_database from statictext within w_copy_reportwriter
integer x = 329
integer y = 316
integer width = 265
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Database:  "
boolean focusrectangle = false
end type

type sle_server from singlelineedit within w_copy_reportwriter
integer x = 654
integer y = 208
integer width = 1614
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event losefocus;If rb_other.checked = True Then 
	of_setsourcedb(True)
End If 
end event

type st_server_ip from statictext within w_copy_reportwriter
integer x = 343
integer y = 212
integer width = 251
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Server IP:  "
boolean focusrectangle = false
end type

type cb_server from commandbutton within w_copy_reportwriter
integer x = 1819
integer y = 100
integer width = 87
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "..."
end type

event clicked;String 	ls_msg

//
Open(w_copy_data_connect_server )

ls_msg = Message.stringparm
If not isnull(ls_msg) and ls_msg = 'Success' Then 
	is_alias_server =  "CLXServer"+ gs_session_id
	ibn_flag  = true 
	sle_server.text =  Trim(gnv_user_option.of_Get_option_value(gs_user_id, "Server_Address_For_Copy_Data_On_Connect_Server" ))
	
	of_setsourcedb(True)
End If
end event

type rb_other from radiobutton within w_copy_reportwriter
integer x = 1417
integer y = 108
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
string text = "Other Server "
end type

event clicked;IF this.checked Then
	rb_current.checked = False

	sle_server.text = ''
	
	dw_view.reset()
		
	ddlb_SoureDBName.reset( )
	cb_server.event clicked( )
End If 

end event

type rb_current from radiobutton within w_copy_reportwriter
integer x = 663
integer y = 108
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Current Server "
end type

event clicked;IF this.checked Then
	rb_other.checked = False
	sle_server.text = 'Current Server'
	dw_view.reset()
	ddlb_SoureDBName.reset( )
	of_setsourcedb(False)
	
End If 
end event

type st_server from statictext within w_copy_reportwriter
integer x = 210
integer y = 108
integer width = 384
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Connect Server: "
boolean focusrectangle = false
end type

type dw_passdb from datawindow within w_copy_reportwriter
boolean visible = false
integer x = 251
integer y = 788
integer width = 352
integer height = 236
string title = "none"
string dataobject = "d_existviewdb"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_copy_reportwriter
integer x = 2848
integer y = 1992
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)

end event

type cb_copy from commandbutton within w_copy_reportwriter
integer x = 2469
integer y = 1996
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&opy"
boolean default = true
end type

event clicked;//Copy Report Writer -- add by jervis 03.09.2011
String	ls_SourceDBName,ls_TargetDBName,ls_ReportID,ls_Error
long		ll_Cycle,ll_ViewCnt,ll_Select,ll_SelCnt,ll_MaxViewID, ll_step
string 	ls_newReportName,ls_newCategory
string	ls_moduser,ls_creatuser,ls_reportName
string 		ls_newViewID
//---------Begin Added by (Appeon)Harry 09.23.2014 for Trying to copy CTX Ireport from one db to another--------
DataStore lds_table
DataStore lds_links
DataStore lds_sort
DataStore lds_fields
DataStore lds_where
String ls_ReportID_list = ''
String ls_sql_table
String ls_sql_links
String ls_sql_sort
String ls_sql_fields
String ls_sql_where
Long ll_table
Long ll_links
Long ll_sort
Long ll_fields
Long ll_where
//---------End Added ------------------------------------------------------

dw_view.Accepttext( )

ls_SourceDBName = ddlb_SoureDBName.Text
if IsNull(ls_SourceDBName) or Trim(ls_SourceDBName) = "" then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please select a Source Database.")
	Return
end if
ls_SourceDBName = "[" + ls_SourceDBName+ "]"		//Added By Mark Lee 09/18/2013

if dw_View.RowCount() <= 0 then Return

ll_SelCnt = dw_View.GetItemNumber(1,"selcount")
if ll_SelCnt = 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please select at least one Report!")
	Return
end if

SELECT db_name() INTO :ls_TargetDBName FROM ids;
ls_TargetDBName	= "[" +ls_TargetDBName+ "]"			//Added By Mark Lee 09/18/2013

// add linkserver name  //Added By Mark Lee 03/01/2013
If trim(is_alias_server) <> "" Then 
	ls_SourceDBName =  is_alias_server +'.' + ls_SourceDBName 
End IF

//Added By Ken.Guo 2010-06-04.
If of_check_version(ls_SourceDBName,ls_TargetDBName) < 0 Then 
	Return
End If

//open  wait
OpenWithParm(w_appeon_gifofwait, "Copying the selected data...")
w_appeon_gifofwait.of_setmaxposition(ll_SelCnt)
w_appeon_gifofwait.of_setposition(0)

ll_ViewCnt = dw_View.RowCount()
for ll_Cycle = 1 to ll_ViewCnt
	ll_Select = dw_View.GetItemNumber(ll_Cycle,"is_selected")
	if ll_Select = 0 then Continue
	
	//do wait
	ll_step = ll_step + 1
	w_appeon_gifofwait.of_setposition(ll_step)
	
	ls_ReportID = String(dw_View.GetItemNumber(ll_Cycle,"report_id"))
	ls_ReportID_list += ls_ReportID + "," //(Appeon)Harry 09.23.2014 - for Trying to copy CTX Ireport from one db to another
	ls_reportName = dw_View.GetItemString(ll_Cycle,"report_name")
	
	//Set New View Name -- jervis 03.07.2011
	ls_newReportName = dw_view.GetItemString( ll_Cycle, "new_report_name")
	if isnull(ls_newReportName) or ls_newReportName = '' then
		ls_newReportName = ls_reportName
	end if
	
	ls_newViewID = string(dw_view.GetItemNumber( ll_Cycle, "new_data_view"))
	ls_newCategory = dw_view.GetItemString( ll_Cycle, "Category")
	ls_moduser = dw_view.GetItemString( ll_Cycle, "modify_user")
	ls_creatuser = gs_user_id
	
	DECLARE lup_copy_reportwriter PROCEDURE FOR up_copy_reportwriter
			  :ls_SourceDBName,
			  :ls_TargetDBName,
			  :ls_ReportID,
			  :ls_newReportName,
			  :ls_newViewID,
			  :ls_newCategory,
			  :ls_moduser,
			  :ls_creatuser;
			  
	EXECUTE lup_copy_reportwriter;
	
	if SQLCA.SQLCode < 0 then
		ls_Error += "Report Name: " + ls_reportName + "~n" + SQLCA.SQLErrText + "~n~n"
		ROLLBACK;
	else
		COMMIT;
	end if
	
	CLOSE lup_copy_reportwriter;
next
//---------Begin Added by (Appeon)Harry 09.23.2014 for Trying to copy CTX Ireport from one db to another--------
lds_table = Create DataStore
lds_links = Create DataStore
lds_sort = Create DataStore
lds_fields = Create DataStore
lds_where = Create DataStore
lds_table.dataobject = "d_reportwriter_temp"
lds_links.dataobject = "d_reportwriter_temp"
lds_sort.dataobject = "d_reportwriter_temp"
lds_fields.dataobject = "d_reportwriter_temp"
lds_where.dataobject = "d_reportwriter_temp"
if len(ls_ReportID_list) > 1 then
	ls_ReportID_list = Left(ls_ReportID_list, Len(ls_ReportID_list) - 1 )
else
	ls_ReportID_list = "0"
end if

ls_sql_table = &
" SELECT a.view_id " + &
" FROM " + ls_SourceDBName + ".dbo.conv_view_table a "+ &
" WHERE a.view_id in ( " + ls_ReportID_list + " ) "

lds_table.SetSQLSelect(ls_sql_table)
lds_table.SetTransObject(SQLCA)

ls_sql_links = &
" SELECT a.view_id " + &
" FROM " + ls_SourceDBName + ".dbo.conv_view_links a"+ &
" WHERE a.view_id in ( " + ls_ReportID_list + " ) "

lds_links.SetSQLSelect(ls_sql_links)
lds_links.SetTransObject(SQLCA)

ls_sql_fields = &
" SELECT a.view_id " + &
" FROM " + ls_SourceDBName + ".dbo.conv_view_fields a"+ &
" WHERE a.view_id in ( " + ls_ReportID_list + " ) "

lds_fields.SetSQLSelect(ls_sql_fields)
lds_fields.SetTransObject(SQLCA)

ls_sql_where = &
" SELECT a.view_id " + &
" FROM " + ls_SourceDBName + ".dbo.conv_view_where a"+ &
" WHERE a.view_id in ( " + ls_ReportID_list + " ) "

lds_where.SetSQLSelect(ls_sql_where)
lds_where.SetTransObject(SQLCA)

ls_sql_sort = &
" SELECT a.view_id " + &
" FROM " + ls_SourceDBName + ".dbo.conv_view_sort a"+ &
" WHERE a.view_id in ( " + ls_ReportID_list + " ) "

lds_sort.SetSQLSelect(ls_sql_sort)
lds_sort.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
lds_table.Retrieve()
lds_links.Retrieve()
lds_fields.Retrieve()
lds_where.Retrieve()
lds_sort.Retrieve()
gnv_appeondb.of_commitqueue( )

ll_table = lds_table.rowcount( )
ll_links = lds_links.rowcount( )
ll_fields = lds_fields.rowcount( )
ll_where = lds_where.rowcount( )
ll_sort = lds_sort.rowcount( )

UPDATE ids 
SET 	irep_tbl_id = irep_tbl_id + :ll_table,
		irep_lnk_id = irep_lnk_id + :ll_links,
		irep_fld_id = irep_fld_id + :ll_fields,
		irep_flt_id = irep_flt_id + :ll_where,
		irep_srt_id = irep_srt_id + :ll_sort ;
COMMIT;

if Isvalid (lds_table) then Destroy (lds_table)
if Isvalid (lds_links) then Destroy (lds_links)
if Isvalid (lds_sort) then Destroy (lds_sort)
if Isvalid (lds_fields) then Destroy (lds_fields)
if Isvalid (lds_where) then Destroy (lds_where)
//---------End Added ------------------------------------------------------

//close wait
If isvalid(w_appeon_gifofwait) Then
	Close(w_appeon_gifofwait)
End If

if ls_Error = "" then
	MessageBox(gnv_app.iapp_object.DisplayName,"Copy report(s) successfully!")
else
	MessageBox(gnv_app.iapp_object.DisplayName,"Failed to copy the following report(s)!~n~n" + Left(ls_Error,Len(ls_Error) - 2),StopSign!)
end if



end event

type dw_view from u_dw within w_copy_reportwriter
integer x = 73
integer y = 552
integer width = 3077
integer height = 1364
integer taborder = 20
string title = "none"
string dataobject = "d_copy_reportwriter"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.of_setsort( true)
this.inv_sort.of_setcolumnheader( true)
end event

type ddlb_souredbname from dropdownlistbox within w_copy_reportwriter
integer x = 654
integer y = 304
integer width = 1614
integer height = 656
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String	ls_SQL,ls_DBName
long ll_i,ll_count
datawindowchild ldwc_view
string ls_old_view,ls_new_view
long ll_find

if Index <= 0  then Return

ls_DBName = This.Text(Index)
//ls_DBName = '"' + ls_DBName + '"'	//Added By Mark Lee 03/01/2013
ls_DBName = "[" +ls_DBName+"]"			//Added By Mark Lee 09/18/2013
If trim(is_alias_server) <> "" Then 
	ls_DBName =  is_alias_server +'.' + ls_DBName 
End IF 

//Retrieve Report writer list - jervis 03.09.2011   //Added By Mark Lee 03/04/2013
ls_SQL = &
"  SELECT 0 as is_selected," + &
"			c.view_id as Report_ID," + &   
"         c.view_name as Report_Name, " + &
"			c.view_name as New_Report_Name, " + & 
"        c.category as Category, " + &  
"         'All' as Modify_User,   " + &
"			d.data_view_name as Data_View," + &
"         1001 as New_Data_View" + &
"    FROM " + ls_DBName + ".dbo.conv_view c," + ls_DBName + ".dbo.data_view d " + &
"	where c.data_view_id = d.data_view_id and " + &
"			( substring(c.view_name,1,3) <> 'cd_' ) AND  " + &
"         ( substring(c.view_name,1,3) <> 'ex_' )  "


dw_View.SetSQLSelect(ls_SQL)
dw_View.SetTransObject(SQLCA)
ll_count = dw_View.Retrieve()

if dw_view.getchild("new_data_view", ldwc_view) = 1  then 
	//init new data view
	for ll_i =1  to ll_count
		ls_old_view = dw_view.GetItemString(ll_i,'data_view')
		ll_find = ldwc_view.Find( "data_view_name ='" + ls_old_view + "'", 1, ldwc_view.Rowcount())
		if ll_find > 0 then dw_view.SetItem( ll_i,"new_data_view", ldwc_view.GetItemNumber(ll_find,"data_view_id"))
	next
end if
end event

type gb_db from groupbox within w_copy_reportwriter
integer x = 32
integer y = 12
integer width = 2510
integer height = 460
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Source Database"
end type

type gb_sourceview from groupbox within w_copy_reportwriter
integer x = 32
integer y = 480
integer width = 3163
integer height = 1480
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Source View"
end type

