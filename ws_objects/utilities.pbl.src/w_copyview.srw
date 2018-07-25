$PBExportHeader$w_copyview.srw
forward
global type w_copyview from w_response
end type
type st_database from statictext within w_copyview
end type
type st_server_ip from statictext within w_copyview
end type
type sle_server from singlelineedit within w_copyview
end type
type cb_server from commandbutton within w_copyview
end type
type rb_other from radiobutton within w_copyview
end type
type rb_current from radiobutton within w_copyview
end type
type st_server from statictext within w_copyview
end type
type dw_passdb from datawindow within w_copyview
end type
type cb_close from commandbutton within w_copyview
end type
type cb_copy from commandbutton within w_copyview
end type
type dw_view from datawindow within w_copyview
end type
type ddlb_souredbname from dropdownlistbox within w_copyview
end type
type gb_db from groupbox within w_copyview
end type
type gb_sourceview from groupbox within w_copyview
end type
end forward

global type w_copyview from w_response
integer width = 1966
integer height = 1404
string title = "Copy View and Screen"
long backcolor = 33551856
string icon = "AppIcon!"
st_database st_database
st_server_ip st_server_ip
sle_server sle_server
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
global w_copyview w_copyview

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
"  select  name" + &
"    from " + as_DBName + ".dbo.sysobjects" + &
"   where  xtype = 'U' and name = 'data_view'"

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
String	 ls_Screen_version_s, ls_Screen_version_t

DECLARE my_cursor1 DYNAMIC CURSOR FOR SQLSA ;
ls_sqlstatement_s = "SELECT set_18,set_patch_ver,screen_version FROM "+as_sourcedb+".dbo.icred_settings "
PREPARE SQLSA FROM :ls_sqlstatement_s ;
OPEN DYNAMIC my_cursor1;
FETCH my_cursor1 INTO :li_version_s,:ls_version_patch_s ,:ls_Screen_version_s;
CLOSE my_cursor1 ;


DECLARE my_cursor2 DYNAMIC CURSOR FOR SQLSA ;
ls_sqlstatement_t = "SELECT set_18,set_patch_ver, screen_version FROM "+as_targetdb+".dbo.icred_settings "
PREPARE SQLSA FROM :ls_sqlstatement_t ;
OPEN DYNAMIC my_cursor2;
FETCH my_cursor2 INTO :li_version_t,:ls_version_patch_t,:ls_Screen_version_t ;
CLOSE my_cursor2 ;

If li_version_s <> li_version_t or ls_version_patch_s <> ls_version_patch_t Then//modified by gavins 20120322 
//	If Messagebox('Alert','The source database version ('+String(li_version_s) + '.' + ls_version_patch_s +') is different from the target database version ('+String(li_version_t) + '.' + ls_version_patch_t +'). ~r~nThe implementation of Copy may cause problems, do you want to continue?',Question!, YesNo!,2) = 2 Then
//		Return -1
//	End If
	Messagebox('Alert','The source database version ('+String(li_version_s) + '.' + ls_version_patch_s + &
		') is different from the target database version ('+String(li_version_t) + '.' + ls_version_patch_t + &
		'). ~r~nThe implementation of Copy may cause problems. Please upgrade to the latest version.'  )
	Return -1
End If

If  ls_Screen_version_s <> ls_Screen_version_t Then
	Messagebox('Alert','The source screen version ('+ ls_Screen_version_s + &
		') is different from the target screen version ('+ ls_Screen_version_t + &
		'). ~r~nThe implementation of Copy may cause problems, Please upgrade to the latest version. '  )
	Return -1
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

on w_copyview.create
int iCurrent
call super::create
this.st_database=create st_database
this.st_server_ip=create st_server_ip
this.sle_server=create sle_server
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
this.Control[iCurrent+2]=this.st_server_ip
this.Control[iCurrent+3]=this.sle_server
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

on w_copyview.destroy
call super::destroy
destroy(this.st_database)
destroy(this.st_server_ip)
destroy(this.sle_server)
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
	is_alias_server =  "CLXServer"+ gs_session_id
	ls_sql = " exec sp_droplinkedsrvlogin " + is_alias_server + ",null "
//	of_execute(ls_sql,this.title )
	gnv_string.of_exec_sql( ls_sql, ls_output)
	
	ls_sql = " exec sp_dropserver  " + is_alias_server  
//	of_execute(ls_sql,this.title )
	gnv_string.of_exec_sql( ls_sql, ls_output)

	Commit; 					//need it 
ENd If
end event

type st_database from statictext within w_copyview
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

type st_server_ip from statictext within w_copyview
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

type sle_server from singlelineedit within w_copyview
integer x = 571
integer y = 208
integer width = 1294
integer height = 80
integer taborder = 20
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

type cb_server from commandbutton within w_copyview
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
	is_alias_server =  "CLXServer"+ gs_session_id
	ibn_flag  = true 
	sle_server.text =  Trim(gnv_user_option.of_Get_option_value(gs_user_id, "Server_Address_For_Copy_Data_On_Connect_Server" ))
	
	of_setsourcedb(True)
End If
end event

type rb_other from radiobutton within w_copyview
integer x = 1339
integer y = 108
integer width = 402
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

type rb_current from radiobutton within w_copyview
integer x = 581
integer y = 108
integer width = 466
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

type st_server from statictext within w_copyview
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

type dw_passdb from datawindow within w_copyview
boolean visible = false
integer x = 251
integer y = 784
integer width = 352
integer height = 236
string title = "none"
string dataobject = "d_existviewdb"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_copyview
integer x = 1577
integer y = 1192
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

type cb_copy from commandbutton within w_copyview
integer x = 1198
integer y = 1192
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

event clicked;String	ls_SourceDBName,ls_TargetDBName,ls_ViewID,ls_Error
long		ll_Cycle,ll_ViewCnt,ll_Select,ll_SelCnt,ll_MaxViewID, ll_step
string 	ls_newViewName

n_cst_update_view_fields_alias lnvo_update

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
	MessageBox(gnv_app.iapp_object.DisplayName,"Please select at least one View!")
	Return
end if

lnvo_update = Create n_cst_update_view_fields_alias

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

//ls_SourceDBName = '"' + ls_SourceDBName + '"'
//ls_TargetDBName = '"' + ls_TargetDBName + '"'
//open 
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
	
	ls_ViewID = String(dw_View.GetItemNumber(ll_Cycle,"data_view_id"))
	
	//Set New View Name -- jervis 03.07.2011
	ls_newViewName = dw_view.GetItemString( ll_Cycle, "new_view_name")
	if isnull(ls_newViewName) or ls_newViewName = '' then
		ls_newViewName = dw_view.GetItemString( ll_Cycle, "data_view_name")
	end if
	//ls_newViewName = '"' + ls_newViewName + '"'
	
	DECLARE lup_ImportView PROCEDURE FOR up_ImportView
			  :ls_SourceDBName,
			  :ls_TargetDBName,
			  :ls_ViewID,
			  :ls_newViewName;
			  
	EXECUTE lup_ImportView;
	
	if SQLCA.SQLCode < 0 then
		ls_Error += "Data View ID: " + ls_ViewID + "~n" + SQLCA.SQLErrText + "~n~n"
		ROLLBACK;
	else
		//Update the view alias
		FETCH lup_ImportView INTO :ll_MaxViewID;
		lnvo_update.of_update_view_fields_alias(1,ll_MaxViewID)
		
		COMMIT;
	end if
	
	CLOSE lup_ImportView;
next

//close
If isvalid(w_appeon_gifofwait) Then
	Close(w_appeon_gifofwait)
End If

if ls_Error = "" then
	MessageBox(gnv_app.iapp_object.DisplayName,"Copy view(s) successfully!")
else
	MessageBox(gnv_app.iapp_object.DisplayName,"Failed to copy the following view(s)!~n~n" + Left(ls_Error,Len(ls_Error) - 2),StopSign!)
end if

Destroy lnvo_update

end event

type dw_view from datawindow within w_copyview
integer x = 78
integer y = 556
integer width = 1801
integer height = 564
integer taborder = 20
string title = "none"
string dataobject = "d_allview"
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

type ddlb_souredbname from dropdownlistbox within w_copyview
integer x = 571
integer y = 316
integer width = 1294
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

if Index <= 0  then Return

ls_DBName = This.Text(Index)
//ls_DBName = '"' + ls_DBName + '"'	//Added By Mark Lee 03/01/2013
ls_DBName = "[" +ls_DBName+"]"			//Added By Mark Lee 09/18/2013
If trim(is_alias_server) <> "" Then 
	ls_DBName =  is_alias_server +'.' + ls_DBName 
End IF 

ls_SQL = &
"  SELECT 0 as is_selected," + &
"			data_view_id," + &
"         data_view_name," + &
"         'Copy of ' + data_view_name new_view_name" + &
"    FROM " + ls_DBName + ".dbo.data_view" + &
"   WHERE type_c = 'C'"

dw_View.SetSQLSelect(ls_SQL)
dw_View.SetTransObject(SQLCA)
dw_View.Retrieve()

end event

type gb_db from groupbox within w_copyview
integer x = 32
integer y = 12
integer width = 1897
integer height = 444
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Source Database"
end type

type gb_sourceview from groupbox within w_copyview
integer x = 32
integer y = 476
integer width = 1893
integer height = 688
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Source View"
end type

