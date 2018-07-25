$PBExportHeader$w_copyusers.srw
forward
global type w_copyusers from w_response
end type
type st_database from statictext within w_copyusers
end type
type sle_server from singlelineedit within w_copyusers
end type
type st_server_ip from statictext within w_copyusers
end type
type cb_server from commandbutton within w_copyusers
end type
type rb_other from radiobutton within w_copyusers
end type
type rb_current from radiobutton within w_copyusers
end type
type st_server from statictext within w_copyusers
end type
type cb_1 from commandbutton within w_copyusers
end type
type cbx_email from checkbox within w_copyusers
end type
type cbx_group from checkbox within w_copyusers
end type
type dw_passdb from datawindow within w_copyusers
end type
type cb_close from commandbutton within w_copyusers
end type
type cb_copy from commandbutton within w_copyusers
end type
type dw_users from datawindow within w_copyusers
end type
type ddlb_souredbname from dropdownlistbox within w_copyusers
end type
type gb_db from groupbox within w_copyusers
end type
type gb_sourceview from groupbox within w_copyusers
end type
type gb_1 from groupbox within w_copyusers
end type
end forward

global type w_copyusers from w_response
integer width = 2405
integer height = 1916
string title = "Copy Users"
long backcolor = 33551856
string icon = "AppIcon!"
st_database st_database
sle_server sle_server
st_server_ip st_server_ip
cb_server cb_server
rb_other rb_other
rb_current rb_current
st_server st_server
cb_1 cb_1
cbx_email cbx_email
cbx_group cbx_group
dw_passdb dw_passdb
cb_close cb_close
cb_copy cb_copy
dw_users dw_users
ddlb_souredbname ddlb_souredbname
gb_db gb_db
gb_sourceview gb_sourceview
gb_1 gb_1
end type
global w_copyusers w_copyusers

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

ls_SQL = &
"  select name" + &
"    from " + as_DBName + ".dbo.sysobjects" + &
"   where xtype = 'U' and name = 'data_view'"

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

on w_copyusers.create
int iCurrent
call super::create
this.st_database=create st_database
this.sle_server=create sle_server
this.st_server_ip=create st_server_ip
this.cb_server=create cb_server
this.rb_other=create rb_other
this.rb_current=create rb_current
this.st_server=create st_server
this.cb_1=create cb_1
this.cbx_email=create cbx_email
this.cbx_group=create cbx_group
this.dw_passdb=create dw_passdb
this.cb_close=create cb_close
this.cb_copy=create cb_copy
this.dw_users=create dw_users
this.ddlb_souredbname=create ddlb_souredbname
this.gb_db=create gb_db
this.gb_sourceview=create gb_sourceview
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_database
this.Control[iCurrent+2]=this.sle_server
this.Control[iCurrent+3]=this.st_server_ip
this.Control[iCurrent+4]=this.cb_server
this.Control[iCurrent+5]=this.rb_other
this.Control[iCurrent+6]=this.rb_current
this.Control[iCurrent+7]=this.st_server
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cbx_email
this.Control[iCurrent+10]=this.cbx_group
this.Control[iCurrent+11]=this.dw_passdb
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.cb_copy
this.Control[iCurrent+14]=this.dw_users
this.Control[iCurrent+15]=this.ddlb_souredbname
this.Control[iCurrent+16]=this.gb_db
this.Control[iCurrent+17]=this.gb_sourceview
this.Control[iCurrent+18]=this.gb_1
end on

on w_copyusers.destroy
call super::destroy
destroy(this.st_database)
destroy(this.sle_server)
destroy(this.st_server_ip)
destroy(this.cb_server)
destroy(this.rb_other)
destroy(this.rb_current)
destroy(this.st_server)
destroy(this.cb_1)
destroy(this.cbx_email)
destroy(this.cbx_group)
destroy(this.dw_passdb)
destroy(this.cb_close)
destroy(this.cb_copy)
destroy(this.dw_users)
destroy(this.ddlb_souredbname)
destroy(this.gb_db)
destroy(this.gb_sourceview)
destroy(this.gb_1)
end on

event open;String		ls_DBName,	ls_new_DBName
long		ll_Cycle,ll_RowCnt

DataStore		lds_DBList

dw_users.SetTransObject(SQLCA)
dw_PassDB.SetTransObject(SQLCA)

lds_DBList = Create DataStore
lds_DBList.DataObject = "d_alldbname"
lds_DBList.SetTransObject(SQLCA)
lds_DBList.Retrieve()

//Added By Mark Lee 03/04/2013
is_alias_server = ""
sle_server.text = 'Current Server'
rb_current.checked = True
rb_other.checked = False


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

type st_database from statictext within w_copyusers
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

type sle_server from singlelineedit within w_copyusers
integer x = 571
integer y = 208
integer width = 1362
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event losefocus;If rb_other.checked = True Then 
	of_setsourcedb(True)
End If 
end event

type st_server_ip from statictext within w_copyusers
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

type cb_server from commandbutton within w_copyusers
integer x = 1742
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
	is_alias_server =  "CLXServer"+gs_session_id
	ibn_flag  = true 
	sle_server.text =  Trim(gnv_user_option.of_Get_option_value(gs_user_id, "Server_Address_For_Copy_Data_On_Connect_Server" ))
	
	of_setsourcedb(True)
End If
end event

type rb_other from radiobutton within w_copyusers
integer x = 1344
integer y = 108
integer width = 393
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
	
	dw_users.reset()
		
	ddlb_SoureDBName.reset( )
	cb_server.event clicked( )
End If 

end event

type rb_current from radiobutton within w_copyusers
integer x = 585
integer y = 108
integer width = 471
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
	dw_users.reset()
	ddlb_SoureDBName.reset( )
	of_setsourcedb(False)
	
End If 
end event

type st_server from statictext within w_copyusers
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

type cb_1 from commandbutton within w_copyusers
integer x = 37
integer y = 1688
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
boolean default = true
end type

event clicked;long ll_i,ll_count

ll_count = dw_users.RowCount()



integer i

if this.text = "Select &All" then
	for ll_i = 1 to ll_count
		dw_users.SetItem(ll_i,'selected',1)
	next
	this.text = "&Deselect All"
elseif this.text = "&Deselect All" then
	for ll_i = 1 to ll_count
		dw_users.setitem(ll_i,"selected",0)
	next
	this.text = "Select &All"
end if


end event

type cbx_email from checkbox within w_copyusers
integer x = 87
integer y = 560
integer width = 585
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Copy Email Account "
boolean checked = true
end type

type cbx_group from checkbox within w_copyusers
boolean visible = false
integer x = 82
integer y = 560
integer width = 558
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Copy Group Access"
end type

type dw_passdb from datawindow within w_copyusers
boolean visible = false
integer x = 251
integer y = 780
integer width = 352
integer height = 236
string title = "none"
string dataobject = "d_existviewdb"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_copyusers
integer x = 2007
integer y = 1696
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

type cb_copy from commandbutton within w_copyusers
integer x = 1627
integer y = 1696
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

event clicked;//Copy users - add by jervis 03.16.2011
String	ls_SourceDBName,ls_TargetDBName,ls_UserID,ls_Error
long		ll_Cycle,ll_ViewCnt,ll_Select,ll_SelCnt,ll_MaxViewID,ll_exists, ll_step
string 	ls_newViewName,ls_newrole,ls_copyemail

n_cst_update_view_fields_alias lnvo_update

dw_users.Accepttext( )

ls_SourceDBName = ddlb_SoureDBName.Text
if IsNull(ls_SourceDBName) or Trim(ls_SourceDBName) = "" then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please select a Source Database.")
	Return
end if

if dw_users.RowCount() <= 0 then Return

ll_SelCnt = dw_users.GetItemNumber(1,"selcount")
if ll_SelCnt = 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please select at least one user!")
	Return
end if

lnvo_update = Create n_cst_update_view_fields_alias

ls_SourceDBName = "[" + ls_SourceDBName+ "]"		//Added By Mark Lee 09/18/2013
// add linkserver name			//Added By Mark Lee 03/04/2013
If trim(is_alias_server) <> "" Then 
	ls_SourceDBName =  is_alias_server +'.' + ls_SourceDBName 
End IF 

SELECT db_name() INTO :ls_TargetDBName FROM ids;
ls_TargetDBName	= "[" +ls_TargetDBName+ "]"			//Added By Mark Lee 09/18/2013
//Added By Ken.Guo 2010-06-04.
If of_check_version(ls_SourceDBName,ls_TargetDBName) < 0 Then 
	Return
End If

//ls_SourceDBName = '"' + ls_SourceDBName + '"'
//ls_TargetDBName = '"' + ls_TargetDBName + '"'
//open  wait
OpenWithParm(w_appeon_gifofwait, "Copying the selected data...")
w_appeon_gifofwait.of_setmaxposition(ll_SelCnt)
w_appeon_gifofwait.of_setposition(0)

ll_ViewCnt = dw_users.RowCount()
for ll_Cycle = 1 to ll_ViewCnt
	ll_Select = dw_users.GetItemNumber(ll_Cycle,"selected")
	if ll_Select = 0 then Continue
	
	ls_UserID = dw_users.GetItemString(ll_Cycle,"user_id")
	
	//exists same user
	ll_exists = 0
	select 1 into :ll_exists from security_users where user_id = :ls_userid;
	if ll_exists = 1 then continue
	
	//do wait
	ll_step = ll_step + 1
	w_appeon_gifofwait.of_setposition(ll_step)
	
	ls_newViewName = string(dw_users.getitemnumber( ll_Cycle, "new_data_view") )
	ls_newrole = string(dw_users.getitemnumber( ll_Cycle, "new_role") )
	if cbx_email.checked then 
		ls_copyemail = '1'
	else
		ls_copyemail = '0'
	end if
	
	
	DECLARE lup_copy_user PROCEDURE FOR up_copy_user
			  :ls_SourceDBName,
			  :ls_TargetDBName,
			  :ls_UserID,
			  :ls_newViewName,
			  :ls_newrole,
			  :ls_copyemail;
			  
	
	EXECUTE lup_copy_user;
	
	if SQLCA.SQLCode < 0 then
		ls_Error += "User ID: " + ls_UserID + "~n" + SQLCA.SQLErrText + "~n~n"
		ROLLBACK;
	else
		COMMIT;
	end if
	
	CLOSE lup_copy_user;
next

//close wait
If isvalid(w_appeon_gifofwait) Then
	Close(w_appeon_gifofwait)
End If

if ls_Error = "" then
	MessageBox(gnv_app.iapp_object.DisplayName,"Copy user(s) successfully!")
else
	MessageBox(gnv_app.iapp_object.DisplayName,"Failed to copy the following user(s)!~n~n" + Left(ls_Error,Len(ls_Error) - 2),StopSign!)
end if

Destroy lnvo_update

end event

type dw_users from datawindow within w_copyusers
integer x = 82
integer y = 780
integer width = 2226
integer height = 844
integer taborder = 20
string title = "none"
string dataobject = "d_copy_user"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;//long	ll_Selected
//
//if row > 0 and Row <= This.RowCount() then
//	This.SetRow(Row)
//	
//	if Lower(dwo.Name) <> Lower("is_selected") then
//		ll_Selected = This.GetItemNumber(Row,"is_selected")
//		This.SetItem(Row,"is_selected",1 - ll_Selected)
//	end if
//end if
//
end event

type ddlb_souredbname from dropdownlistbox within w_copyusers
integer x = 571
integer y = 324
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
long backcolor = 33551856
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String	ls_SQL,ls_DBName
datawindowchild ldwc_view
long ll_i,ll_count,ll_find
string ls_old_view,ls_old_role

if Index <= 0  then Return

ls_DBName = This.Text(Index)
ls_DBName = "[" +ls_DBName+"]"			//Added By Mark Lee 09/18/2013
//Added By Mark Lee 03/04/2013
If trim(is_alias_server) <> "" Then 
	ls_DBName =  is_alias_server +'.' + ls_DBName 
End IF 

//Added By Mark Lee 03/04/2013
//Modify 'dbo.security_users.default_view' to 'dbo.security_users.contract_default_view' -- jervis 04.06.2011
//ls_SQL = &
//"  SELECT " + ls_DBName + ".dbo.security_users.user_id, " + &  
//"         selected = 0,    " + &  
//"         " + ls_DBName + ".dbo.security_roles.role_name,    " + &  
//"        " + ls_DBName + ".dbo. data_view.data_view_name,   " + &  
//"			1 as New_Role, " + &  
//"			1001 as new_data_view " + &  
//"    FROM " + ls_DBName + ".dbo.security_users," + ls_DBName + ".dbo.security_roles," + ls_DBName + ".dbo.data_view " + &  
//"	where   " + ls_DBName + ".dbo.security_users.contract_default_view =  " + ls_DBName + ".dbo.data_view.data_view_id and  " + &  	
//"			" + ls_DBName + ".dbo.security_users.role_id = " + ls_DBName + ".dbo.security_roles.role_id " 
ls_SQL = &
"  SELECT s.user_id, " + &  
"         selected = 0,    " + &  
"          r.role_name,    " + &  
"        v.data_view_name,   " + &  
"			1 as New_Role, " + &  
"			1001 as new_data_view " + &  
"    FROM " + ls_DBName + ".dbo.security_users s," + ls_DBName + ".dbo.security_roles r," + ls_DBName + ".dbo.data_view v " + &  
"	where   s.contract_default_view = v.data_view_id and  " + &  	
"			 s.role_id = r.role_id " 

dw_users.SetSQLSelect(ls_SQL)
dw_users.SetTransObject(SQLCA)
ll_count = dw_users.Retrieve()

//init new data view
if dw_users.getchild("new_data_view", ldwc_view) = 1  then 
	for ll_i =1  to ll_count
		ls_old_view = dw_users.GetItemString(ll_i,'data_view_name')
		ll_find = ldwc_view.Find( "data_view_name ='" + ls_old_view + "'", 1, ldwc_view.Rowcount())
		if ll_find > 0 then dw_users.SetItem( ll_i,"new_data_view", ldwc_view.GetItemNumber(ll_find,"data_view_id"))
	next
end if

//init new role
if dw_users.getchild("new_role", ldwc_view) = 1  then 
	for ll_i =1  to ll_count
		ls_old_role = dw_users.GetItemString(ll_i,'role_name')
		ll_find = ldwc_view.Find( "role_name ='" + ls_old_role + "'", 1, ldwc_view.Rowcount())
		if ll_find > 0 then dw_users.SetItem( ll_i,"new_role", ldwc_view.GetItemNumber(ll_find,"role_id"))
	next
end if

cb_1.text = "Select &All"
end event

type gb_db from groupbox within w_copyusers
integer x = 37
integer y = 12
integer width = 2313
integer height = 456
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

type gb_sourceview from groupbox within w_copyusers
integer x = 37
integer y = 700
integer width = 2318
integer height = 968
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Source Users"
end type

type gb_1 from groupbox within w_copyusers
integer x = 37
integer y = 480
integer width = 2313
integer height = 196
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Copy option"
end type

