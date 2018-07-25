$PBExportHeader$w_copy_data_connect_server.srw
forward
global type w_copy_data_connect_server from w_response
end type
type cb_cancel from commandbutton within w_copy_data_connect_server
end type
type cb_connect from commandbutton within w_copy_data_connect_server
end type
type st_pwd from statictext within w_copy_data_connect_server
end type
type sle_pwd from singlelineedit within w_copy_data_connect_server
end type
type sle_name from singlelineedit within w_copy_data_connect_server
end type
type st_login_name from statictext within w_copy_data_connect_server
end type
type st_server_ip from statictext within w_copy_data_connect_server
end type
type sle_server from singlelineedit within w_copy_data_connect_server
end type
type gb_db from groupbox within w_copy_data_connect_server
end type
end forward

global type w_copy_data_connect_server from w_response
integer width = 1874
integer height = 728
string title = "Connect Link Server"
long backcolor = 33551856
cb_cancel cb_cancel
cb_connect cb_connect
st_pwd st_pwd
sle_pwd sle_pwd
sle_name sle_name
st_login_name st_login_name
st_server_ip st_server_ip
sle_server sle_server
gb_db gb_db
end type
global w_copy_data_connect_server w_copy_data_connect_server

forward prototypes
public function boolean of_add_link_server (string as_server, string as_login_name, string as_login_pwd)
end prototypes

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
String 		ls_sql, ls_output, ls_alias_server
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

ls_alias_server = "CLXServer"+gs_session_id

ls_sql = " exec sp_droplinkedsrvlogin " + ls_alias_server + ",null "
//of_execute(ls_sql,this.title )
gnv_string.of_exec_sql( ls_sql, ls_output)

ls_sql = " exec sp_dropserver  " + ls_alias_server  
//of_execute(ls_sql,this.title )
gnv_string.of_exec_sql( ls_sql, ls_output)

Commit; 					//need it 
ls_output = ""

ls_sql = " exec sp_addlinkedserver @server = '" + ls_alias_server + "', @srvproduct='',@provider='SQLOLEDB',@datasrc='"+as_server+"' "
//of_execute(ls_sql,this.title )
gnv_string.of_exec_sql( ls_sql, ls_output)
ls_sql = " exec sp_addlinkedsrvlogin '" + ls_alias_server + "','false',null,'"+as_login_name+"','"+as_login_pwd+"' "
//of_execute(ls_sql,this.title )
gnv_string.of_exec_sql( ls_sql, ls_output)

//IF SQLCA.SQLCODE = 0 Then
If Pos(ls_output,"ERROR") > 0 Then 
	lbn_return = False
	gnv_debug.of_output( True, "of_add_link_server: Output Error:"+ls_output )	
Else
	//successful
	lbn_return = True
End IF

Commit;					// commit

// 
IF lbn_return = True Then 
	DECLARE my_cursors DYNAMIC CURSOR FOR SQLSA ;
	ls_sql = "SELECT count(1)    FROM "+ls_alias_server+".master.dbo.sysdatabases " 
	PREPARE SQLSA FROM :ls_sql ;
	OPEN DYNAMIC my_cursors;
	FETCH my_cursors INTO :li_count ;
	CLOSE my_cursors ;

	IF isnull(li_count ) or li_count <= 0 or SQLCA.SQLCODE <> 0  Then 
		gnv_debug.of_output( True, "of_add_link_server: SQLCA.sqlerrtext: "+SQLCA.sqlerrtext   )
		lbn_return = False
	End IF 
End IF 

Return lbn_return
end function

on w_copy_data_connect_server.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_connect=create cb_connect
this.st_pwd=create st_pwd
this.sle_pwd=create sle_pwd
this.sle_name=create sle_name
this.st_login_name=create st_login_name
this.st_server_ip=create st_server_ip
this.sle_server=create sle_server
this.gb_db=create gb_db
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_connect
this.Control[iCurrent+3]=this.st_pwd
this.Control[iCurrent+4]=this.sle_pwd
this.Control[iCurrent+5]=this.sle_name
this.Control[iCurrent+6]=this.st_login_name
this.Control[iCurrent+7]=this.st_server_ip
this.Control[iCurrent+8]=this.sle_server
this.Control[iCurrent+9]=this.gb_db
end on

on w_copy_data_connect_server.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_connect)
destroy(this.st_pwd)
destroy(this.sle_pwd)
destroy(this.sle_name)
destroy(this.st_login_name)
destroy(this.st_server_ip)
destroy(this.sle_server)
destroy(this.gb_db)
end on

event open;call super::open;String ls_tmp

ls_tmp = Trim(gnv_user_option.of_Get_option_value(gs_user_id, "Server_Address_For_Copy_Data_On_Connect_Server" ))
sle_server.text = ls_tmp
ls_tmp = gnv_user_option.of_Get_option_value(gs_user_id, "Login_Name_For_Copy_Data_On_Connect_Server" )
sle_name.text = ls_tmp
ls_tmp = gnv_user_option.of_Get_option_value(gs_user_id, "Login_Password_For_Copy_Data_On_Connect_Server" )
sle_pwd.text = ls_tmp


end event

type cb_cancel from commandbutton within w_copy_data_connect_server
integer x = 1166
integer y = 468
integer width = 416
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "Cancel")
end event

type cb_connect from commandbutton within w_copy_data_connect_server
integer x = 558
integer y = 468
integer width = 416
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Connect"
boolean default = true
end type

event clicked;String 	ls_login_name, 	ls_login_pwd, ls_server_name, ls_sql
Integer 	li_count

ls_login_name = sle_name.text
ls_login_pwd = sle_pwd.text
ls_server_name = sle_server.text

If of_add_link_server(ls_server_name,ls_login_name,ls_login_pwd)  = True Then 
		gnv_user_option.of_Set_option_value(gs_user_id, "Server_Address_For_Copy_Data_On_Connect_Server", string(sle_server.text) )
		gnv_user_option.of_Set_option_value(gs_user_id, "Login_Name_For_Copy_Data_On_Connect_Server", string(sle_name.text) )
		gnv_user_option.of_Set_option_value(gs_user_id, "Login_Password_For_Copy_Data_On_Connect_Server", string(sle_pwd.text) )
		gnv_user_option.of_save( )	

		CloseWithReturn(Parent, "Success")
Else
		MessageBox(gnv_app.iapp_object.DisplayName," Failed to connect to the link server. ~r~n Please verify the Server IP and the account information. ")		
		return
End IF 

end event

type st_pwd from statictext within w_copy_data_connect_server
integer x = 183
integer y = 328
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
string text = "Password: "
boolean focusrectangle = false
end type

type sle_pwd from singlelineedit within w_copy_data_connect_server
integer x = 498
integer y = 328
integer width = 1184
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_name from singlelineedit within w_copy_data_connect_server
integer x = 498
integer y = 228
integer width = 1184
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_login_name from statictext within w_copy_data_connect_server
integer x = 133
integer y = 228
integer width = 306
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Login Name: "
boolean focusrectangle = false
end type

type st_server_ip from statictext within w_copy_data_connect_server
integer x = 187
integer y = 136
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

type sle_server from singlelineedit within w_copy_data_connect_server
integer x = 498
integer y = 132
integer width = 1184
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_db from groupbox within w_copy_data_connect_server
integer x = 50
integer y = 32
integer width = 1783
integer height = 592
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

