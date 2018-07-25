$PBExportHeader$w_copy_role.srw
forward
global type w_copy_role from w_response
end type
type cb_server from commandbutton within w_copy_role
end type
type st_database from statictext within w_copy_role
end type
type st_server_ip from statictext within w_copy_role
end type
type sle_server from singlelineedit within w_copy_role
end type
type rb_other from radiobutton within w_copy_role
end type
type rb_current from radiobutton within w_copy_role
end type
type st_server from statictext within w_copy_role
end type
type dw_passdb from datawindow within w_copy_role
end type
type cb_close from commandbutton within w_copy_role
end type
type cb_copy from commandbutton within w_copy_role
end type
type dw_view from u_dw within w_copy_role
end type
type ddlb_souredbname from dropdownlistbox within w_copy_role
end type
type gb_db from groupbox within w_copy_role
end type
type gb_sourceview from groupbox within w_copy_role
end type
end forward

global type w_copy_role from w_response
integer width = 2162
integer height = 1852
string title = "Copy Security Role"
long backcolor = 33551856
string icon = "AppIcon!"
cb_server cb_server
st_database st_database
st_server_ip st_server_ip
sle_server sle_server
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
global w_copy_role w_copy_role

type prototypes

end prototypes

type variables
String 			is_alias_server
Boolean			ibn_flag	=  False							//record the flag for connect server.
end variables

forward prototypes
public function boolean of_existdataview (string as_dbname)
public function integer of_check_version (string as_sourcedb, string as_targetdb)
public function boolean of_add_link_server (string as_server, string as_login_name, string as_login_pwd)
public subroutine of_setsourcedb (boolean abn_flag)
end prototypes

public function boolean of_existdataview (string as_dbname);String	ls_SQL

ls_SQL = &
"  select  name" + &
"    from " + as_DBName + ".dbo.sysobjects" + &
"   where  xtype = 'U' and name = 'conv_view'"

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

public function boolean of_add_link_server (string as_server, string as_login_name, string as_login_pwd);//====================================================================
// Function: of_add_link_server
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_server
//                as_login_name
//                as_login_pwd
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 02/22/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Boolean		lbn_return 
String 		ls_sql, ls_output
Integer 		li_count

IF isnull(as_server) Or trim(as_server) = '' Then 
	MessageBox(gnv_app.iapp_object.DisplayName,"Please input the server ip ")
	Return False
End IF 

IF isnull(as_login_name) Or trim(as_login_name) = '' Then 
	MessageBox(gnv_app.iapp_object.DisplayName,"Please input the login name ")
	Return False
End IF 

IF isnull(as_login_pwd) Or trim(as_login_pwd) = '' Then 
	MessageBox(gnv_app.iapp_object.DisplayName,"Please input the login password ")
	Return False
End IF 

is_alias_server = "CLXServer"+gs_session_id

ls_sql = " exec sp_droplinkedsrvlogin " + is_alias_server + ",null "
//of_execute(ls_sql,this.title )
gnv_string.of_exec_sql( ls_sql, ls_output)

ls_sql = " exec sp_dropserver  " + is_alias_server  
//of_execute(ls_sql,this.title )
gnv_string.of_exec_sql( ls_sql, ls_output)

Commit; 					//need it 
ls_output = ""

ls_sql = " exec sp_addlinkedserver @server = '" + is_alias_server + "', @srvproduct='',@provider='SQLOLEDB',@datasrc='"+as_server+"' "
//of_execute(ls_sql,this.title )
gnv_string.of_exec_sql( ls_sql, ls_output)
ls_sql = " exec sp_addlinkedsrvlogin '" + is_alias_server + "','false',null,'"+as_login_name+"','"+as_login_pwd+"' "
//of_execute(ls_sql,this.title )
gnv_string.of_exec_sql( ls_sql, ls_output)

//IF SQLCA.SQLCODE = 0 Then
If Pos(ls_output,"ERROR") > 0 Then 
	lbn_return = False
	ibn_flag = False
Else
	//successful
	lbn_return = True
	ibn_flag = True
End IF

Commit;					// commit

Return lbn_return
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

on w_copy_role.create
int iCurrent
call super::create
this.cb_server=create cb_server
this.st_database=create st_database
this.st_server_ip=create st_server_ip
this.sle_server=create sle_server
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
this.Control[iCurrent+1]=this.cb_server
this.Control[iCurrent+2]=this.st_database
this.Control[iCurrent+3]=this.st_server_ip
this.Control[iCurrent+4]=this.sle_server
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

on w_copy_role.destroy
call super::destroy
destroy(this.cb_server)
destroy(this.st_database)
destroy(this.st_server_ip)
destroy(this.sle_server)
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

event open;String		ls_DBName,	ls_SQL, ls_tmp,	ls_new_DBName
long		ll_Cycle,ll_RowCnt

DataStore		lds_DBList

dw_View.SetTransObject(SQLCA)
dw_PassDB.SetTransObject(SQLCA)

lds_DBList = Create DataStore
lds_DBList.DataObject = "d_alldbname"
lds_DBList.SetTransObject(SQLCA)

is_alias_server = ""
rb_current.checked = True
rb_other.checked = False
sle_server.enabled = False


lds_DBList.Retrieve()

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

event close;call super::close;String 		ls_sql	,	ls_output

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

type cb_server from commandbutton within w_copy_role
integer x = 1742
integer y = 100
integer width = 87
integer height = 84
integer taborder = 10
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
	is_alias_server =  "CLXServer"+gs_session_id
	ibn_flag  = true 
	sle_server.text =  Trim(gnv_user_option.of_Get_option_value(gs_user_id, "Server_Address_For_Copy_Data_On_Connect_Server" ))
	
	of_setsourcedb(True)
End If
end event

type st_database from statictext within w_copy_role
integer x = 247
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

type st_server_ip from statictext within w_copy_role
integer x = 261
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

type sle_server from singlelineedit within w_copy_role
integer x = 571
integer y = 208
integer width = 1362
integer height = 80
integer taborder = 20
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

type rb_other from radiobutton within w_copy_role
integer x = 1335
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

type rb_current from radiobutton within w_copy_role
integer x = 581
integer y = 108
integer width = 480
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

type st_server from statictext within w_copy_role
integer x = 128
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

type dw_passdb from datawindow within w_copy_role
boolean visible = false
integer x = 251
integer y = 752
integer width = 352
integer height = 236
string title = "none"
string dataobject = "d_existviewdb"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_copy_role
integer x = 1783
integer y = 1644
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

type cb_copy from commandbutton within w_copy_role
integer x = 1403
integer y = 1648
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

event clicked;//Copy Sucerity Role -- add by jervis 03.16.2011
String	ls_SourceDBName,ls_TargetDBName,ls_RoleID,ls_Error
long		ll_Cycle,ll_ViewCnt,ll_Select,ll_SelCnt,ll_MaxViewID, ll_step
string 	ls_newRoleName,ls_RoleName


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
	MessageBox(gnv_app.iapp_object.DisplayName,"Please select at least one Security Role!")
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
	ll_Select = dw_View.GetItemNumber(ll_Cycle,"selected")
	if ll_Select = 0 then Continue
	
	//do wait
	ll_step = ll_step + 1
	w_appeon_gifofwait.of_setposition(ll_step)
	
	ls_RoleID = String(dw_View.GetItemNumber(ll_Cycle,"role_id"))
	ls_RoleName = dw_View.GetItemString(ll_Cycle,"role_name")
	
	//Set New role Name 
	ls_newRoleName = dw_view.GetItemString( ll_Cycle, "new_role_name")
	if isnull(ls_newRoleName) or ls_newRoleName = '' then
		ls_newRoleName = ls_RoleName
	end if
	

	DECLARE lup_copy_role PROCEDURE FOR up_copy_role
			  :ls_SourceDBName,
			  :ls_TargetDBName,
			  :ls_RoleID,
			  :ls_newRoleName;
			  
	EXECUTE lup_copy_role;
	
	if SQLCA.SQLCode < 0 then
		ls_Error += "Role Name: " + ls_RoleName + "~n" + SQLCA.SQLErrText + "~n~n"
		ROLLBACK;
	else
		COMMIT;
	end if
	
	CLOSE lup_copy_role;
next

//close wait
If isvalid(w_appeon_gifofwait) Then
	Close(w_appeon_gifofwait)
End If

if ls_Error = "" then
	MessageBox(gnv_app.iapp_object.DisplayName,"Copy Security Role(s) successfully!")
else
	MessageBox(gnv_app.iapp_object.DisplayName,"Failed to copy the following securiry role(s)!~n~n" + Left(ls_Error,Len(ls_Error) - 2),StopSign!)
	gnv_debug.of_output( True, "Failed to copy the following lookup data!~n~n" + Left(ls_Error,Len(ls_Error) - 2) )
end if



end event

type dw_view from u_dw within w_copy_role
integer x = 73
integer y = 516
integer width = 2007
integer height = 1052
integer taborder = 20
string title = "none"
string dataobject = "d_copy_role"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.of_setsort( true)
this.inv_sort.of_setcolumnheader( true)
end event

type ddlb_souredbname from dropdownlistbox within w_copy_role
integer x = 571
integer y = 308
integer width = 1362
integer height = 676
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


if Index <= 0  then Return

ls_DBName = This.Text(Index)
//ls_DBName = '"' + ls_DBName + '"'		//Added By Mark Lee 03/01/2013
ls_DBName = "[" +ls_DBName+"]"			//Added By Mark Lee 09/18/2013
If trim(is_alias_server) <> "" Then 
	ls_DBName =  is_alias_server +'.' + ls_DBName 
End IF 

//Retrieve Report writer list - jervis 03.09.2011 //Added By Mark Lee 03/01/2013
ls_SQL = &
"  SELECT 0 as selected," + &
"			role_id,  " + & 
"         role_name," + &
"			role_name as new_role_name  " + &
"    FROM " + ls_DBName + ".dbo.security_roles   " 


dw_View.SetSQLSelect(ls_SQL)
dw_View.SetTransObject(SQLCA)
dw_View.Retrieve()

end event

type gb_db from groupbox within w_copy_role
integer x = 32
integer y = 12
integer width = 2094
integer height = 432
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

type gb_sourceview from groupbox within w_copy_role
integer x = 32
integer y = 444
integer width = 2094
integer height = 1168
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

