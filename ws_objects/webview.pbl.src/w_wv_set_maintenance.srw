$PBExportHeader$w_wv_set_maintenance.srw
forward
global type w_wv_set_maintenance from w_sheet
end type
type cb_2 from commandbutton within w_wv_set_maintenance
end type
type cb_1 from commandbutton within w_wv_set_maintenance
end type
type dw_settings_log from u_dw within w_wv_set_maintenance
end type
type dw_setting from u_dw within w_wv_set_maintenance
end type
type dw_type_set from u_dw within w_wv_set_maintenance
end type
type dw_dom_name from u_dw within w_wv_set_maintenance
end type
end forward

global type w_wv_set_maintenance from w_sheet
integer width = 3758
integer height = 1896
string title = "WebView Settings Maintenance"
boolean maxbox = false
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
dw_settings_log dw_settings_log
dw_setting dw_setting
dw_type_set dw_type_set
dw_dom_name dw_dom_name
end type
global w_wv_set_maintenance w_wv_set_maintenance

type variables
boolean ib_save
string is_appname
boolean ib_bomain
end variables

forward prototypes
public function integer of_select_wv_type (integer ai_type)
public function integer of_verify_settings ()
end prototypes

public function integer of_select_wv_type (integer ai_type);//////////////////////////////////////////////////////////////////////
// $<function> of_select_wv_type
// $<arguments>
// $<returns> integer
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.29.2012 by Stephen
//////////////////////////////////////////////////////////////////////
string ls_type_desc

select option_desc_long
    into :ls_type_desc 
   from wv_setting_option
 where wv_setting_id = 5 and option_value = :ai_type;

if sqlca.sqlcode <> 0 then return 0

dw_setting.modify("t_1.text = '"+ls_type_desc+"'")

choose case ai_type
	case 1,3
		dw_type_set.visible = true
		dw_type_set.dataobject = 'd_wv_settings_windows_set'
		dw_type_set.settransobject(sqlca)
		dw_type_set.retrieve(is_appname)
		if dw_type_set.rowcount() < 1 then dw_type_set.insertrow(1)
		if ib_bomain then
			dw_dom_name.visible = true
			dw_dom_name.bringtotop = true
		end if
	case 2,4
		dw_type_set.visible = true
		dw_type_set.dataobject = 'd_wv_settings_ldap_set'
		dw_type_set.settransobject(sqlca)
		dw_type_set.retrieve(is_appname)
		if dw_type_set.rowcount() < 1 then dw_type_set.insertrow(1)
		if ib_bomain then
			dw_dom_name.visible = true
			dw_dom_name.bringtotop = true
		end if
	case else
		dw_type_set.visible = false
		dw_dom_name.visible = false
end choose

return 1
end function

public function integer of_verify_settings ();//////////////////////////////////////////////////////////////////////
// $<function> of_verify_settings
// $<arguments>
// $<returns> integer
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////
string ls_server_name, ls_server_type
string ls_username, ls_psd, ls_appname
long   ll_port

if dw_type_set.accepttext() = -1 then return -1
if dw_type_set.rowcount() < 1  then return -1
if dw_type_set.dataobject = "d_wv_settings_ldap_set" then
	ls_server_name = trim(dw_type_set.getitemstring(1, "server_name"))
	ls_server_type = trim(dw_type_set.getitemstring(1, "server_type"))
	ls_username = trim(dw_type_set.getitemstring(1, "username") )
	ls_psd =  trim(dw_type_set.getitemstring(1, "password") )
	ll_port =  dw_type_set.getitemnumber(1, "port") 
	ls_appname = trim(dw_type_set.getitemstring(1, "appname") ) 
	
	if isnull(ls_appname) or ls_appname = '' then
		messagebox("Prompt", "App Name  is required.")
		dw_type_set.setcolumn("appname")
		return -1
	end if
	
	if isnull(ls_server_name) or ls_server_name = '' then
		messagebox("Prompt", "Server Name  is required.")
		dw_type_set.setcolumn("server_name")
		return 0
	end if
	
	if isnull(ls_server_type) or ls_server_type = '' then
		messagebox("Prompt", "Server Type is required.")
		dw_type_set.setcolumn("server_type")
		return 0
	end if
	
	if isnull(ls_username) or ls_username = '' then
		messagebox("Prompt", "User ID is required.")
		dw_type_set.setcolumn("username")
		return 0
	end if
	
	if isnull(ls_psd) or ls_psd = '' then
		messagebox("Prompt", "Password is required.")
		dw_type_set.setcolumn("password")
		return 0
	end if
	
	if isnull(ll_port) then
		messagebox("Prompt", "Port is required.")
		dw_type_set.setcolumn("port")
		return 0
	end if
	
else
	ls_username = trim(dw_type_set.getitemstring(1, "username")) 
	ls_psd =  trim(dw_type_set.getitemstring(1, "password") )
	ls_server_name = trim(dw_type_set.getitemstring(1, "domain"))
	ls_appname = trim(dw_type_set.getitemstring(1, "appname") ) 
	
	if isnull(ls_appname) or ls_appname = '' then
		messagebox("Prompt", "App Name  is required.")
		dw_type_set.setcolumn("appname")
		return -1
	end if
	
	if isnull(ls_server_name) or ls_server_name = '' then
		messagebox("Prompt", "Window Domain Name is required.")
		dw_type_set.setcolumn("domain")
		return 0
	end if
	
	if isnull(ls_username) or ls_username = '' then
		messagebox("Prompt", "User ID is required.")
		dw_type_set.setcolumn("username")
		return 0
	end if
	
	if isnull(ls_psd) or ls_psd = '' then
		messagebox("Prompt", "Password is required.")
		dw_type_set.setcolumn("password")
		return 0
	end if
end if

return 1
end function

on w_wv_set_maintenance.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_settings_log=create dw_settings_log
this.dw_setting=create dw_setting
this.dw_type_set=create dw_type_set
this.dw_dom_name=create dw_dom_name
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_settings_log
this.Control[iCurrent+4]=this.dw_setting
this.Control[iCurrent+5]=this.dw_type_set
this.Control[iCurrent+6]=this.dw_dom_name
end on

on w_wv_set_maintenance.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_settings_log)
destroy(this.dw_setting)
destroy(this.dw_type_set)
destroy(this.dw_dom_name)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.29.2012 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_cnt
datawindowchild ldwc_1

gnv_appeondb.of_startqueue( )
dw_settings_log.retrieve()
select count(1) into :li_cnt from wv_ldap_settings using sqlca;
gnv_appeondb.of_commitqueue( ) //evan 03.20.2012 --- moved it from bottom

if li_cnt > 1 then
	ib_bomain = true
	dw_dom_name.retrieve()
	dw_dom_name.insertrow(0)
	dw_dom_name.bringtotop = true
	dw_dom_name.getchild("dom_name", ldwc_1)
	if  ldwc_1.rowcount() > 0 then
		is_appname =  ldwc_1.getitemstring(1,"appname")
		dw_dom_name.setitem(1, "dom_name", is_appname)	
	else
		is_appname = ''
	end if
else
	dw_dom_name.visible = false
	is_appname = 'all'
	ib_bomain = false
end if
dw_setting.retrieve()
end event

event closequery;call super::closequery;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance  (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 03.02.2012 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_Result

dw_setting.accepttext()
dw_type_set.accepttext()
if dw_setting.modifiedcount() > 0 or  dw_type_set.modifiedcount() > 0 then
	li_Result = MessageBox("Save", "Do you want to save changes?", Question!, YesNoCancel!)
	choose case li_Result
		case 1
			if cb_1.event clicked() = -1 then return 1
		case 2
			return 0
		case 3
			return 1
	end choose
	
end if
return 0
end event

type cb_2 from commandbutton within w_wv_set_maintenance
integer x = 3250
integer y = 24
integer width = 439
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_wv_set_maintenance
integer x = 2779
integer y = 24
integer width = 439
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////
long  ll_new_type, ll_old_type
integer li_row, li_ret
string ls_mess
long  ll_log_id
dwitemstatus lds_status
integer li_set_id

ib_save = true
if dw_type_set.visible then
	if of_verify_settings() = 0 then //evan 03.20.2012 --- added prompt
		if MessageBox("Save", "Do you want to continue saving data?", Question!, YesNo!) = 2 then
			Return -1
		end if
	end if
	if dw_type_set.update() <> 1 then
		MessageBox("Error", "Failed to save data.", StopSign!)
		rollback using sqlca;
		return -1
	end if
end if

SELECT	max( wv_setting_audit_log_id ) 
  INTO :ll_log_id
FROM	wv_setting_audit_log using sqlca;
if isnull(ll_log_id) then ll_log_id = 0 //add by Stephen 04.01.2012 --BugL040101

gnv_appeondb.of_startqueue( )
for li_row = 1 to dw_setting.rowcount()
	lds_status = dw_setting.getitemstatus(li_row, 0, primary!)
	if lds_status <> datamodified! then continue
	
	li_set_id = dw_setting.getitemnumber(li_row, "wv_setting_id")
	ll_new_type = dw_setting.getitemnumber(li_row, "setting_value")
	ll_old_type =  dw_setting.getitemnumber(li_row, "setting_value",primary!, true )
	
	if ll_new_type = ll_old_type then continue
	if li_set_id = 5  then
		ls_mess = ""
		if (ll_old_type = 1 or ll_old_type = 3 ) and (ll_new_type = 2 or ll_new_type = 4 ) then
			ls_mess = "You have changed the authentication type from Windows to LDAP." +&
						  +"It will clear the old relative Windows User settings in WebView User Painter." +&
						+"~r~nAre you sure you want to change it?"		
		end if
		
		if (ll_old_type = 2 or ll_old_type = 4 ) and (ll_new_type = 1 or ll_new_type = 3 ) then
			ls_mess = "You have changed the authentication type from LDAP to Windows." +&
						  +"It will clear the old relative LDAP User settings in WebView User Painter." +&
						+"~r~nAre you sure you want to change it?"		
		end if
		
		if ls_mess = "" or isnull(ls_mess) then
		else
			if messagebox("Prompt", ls_mess,  Question!, YesNo!) = 1 then
				UPDATE	security_users
				SET		wv_ldap_user=null using sqlca;
			else
				rollback using sqlca;
				gnv_appeondb.of_commitqueue( )
				return 
			end if
		end if
	end if
	
	ll_log_id +=1
	
	INSERT INTO	wv_setting_audit_log
				(	wv_setting_audit_log_id
					, wv_setting_id
					, old_setting_value
					, new_setting_value
					, user_id
					, audit_date
				)				 
			VALUES
				(	:ll_log_id,
					:li_set_id,
					:ll_old_type,
					:ll_new_type,
					:gs_user_id,
					 getdate()
				) using sqlca;				 
				
next

if dw_setting.accepttext() = -1 then 
	MessageBox("Error", "Failed to save data.", StopSign!)
	gnv_appeondb.of_commitqueue( )
	return -1
end if
gnv_appeondb.of_commitqueue( )

if dw_setting.update() = 1 then
	MessageBox("Prompt","Saving Settings successful !")
	commit using sqlca;
else
	MessageBox("Error", "Failed to save data.", StopSign!)
	rollback using sqlca;
	return -1
end if
dw_settings_log.retrieve()



end event

type dw_settings_log from u_dw within w_wv_set_maintenance
integer x = 1659
integer y = 128
integer width = 2043
integer height = 1648
integer taborder = 20
boolean titlebar = true
string title = "Settings Change Log"
string dataobject = "d_wv_settings_audit_log"
boolean hscrollbar = true
end type

event other;call super::other;//$<add> 04.17.2008 by Andy
if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.29.2012 by Stephen
//////////////////////////////////////////////////////////////////////
if currentrow < 1 then return
this.selectrow(0,false)
this.selectrow(currentrow, true)
end event

type dw_setting from u_dw within w_wv_set_maintenance
integer x = 5
integer y = 128
integer width = 1641
integer height = 596
integer taborder = 10
string title = "WebView Settings"
string dataobject = "d_wv_main_settings"
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.29.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false)
end event

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.29.2012 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_set_id

if row < 1 then return
li_set_id = this.getitemnumber(row, 'wv_setting_id')

if li_set_id = 5 and dwo.name = 'new_value' then
	this.setitem(row, "setting_value", long(data))
	of_select_wv_type(integer(data))
end if

//For V14.2 NYHH  - alfee 08.27.2015
if li_set_id = 10 and dwo.name = 'new_value10' then
	this.setitem(row, "setting_value", long(data))
end if

//V15.3 Provider - alfee 04.14.2017
if li_set_id = 14 and dwo.name = 'new_value14' then
	this.setitem(row, "setting_value", long(data))
end if
end event

event retrieveend;call super::retrieveend;//////////////////////////////////////////////////////////////////////
// $<event> retrieveend
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.29.2012 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_row, li_type

li_row = this.find("wv_setting_id = "+string(5)+"", 1, this.rowcount())
if li_row > 0 then
	li_type = this.getitemnumber(li_row, "new_value")
	of_select_wv_type(li_type)
end if



end event

event other;call super::other;//$<add> 04.17.2008 by Andy
if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

type dw_type_set from u_dw within w_wv_set_maintenance
integer x = 5
integer y = 728
integer width = 1641
integer height = 1048
integer taborder = 30
string dataobject = "d_wv_settings_ldap_set"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.29.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false)
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.29.2012 by Stephen
//////////////////////////////////////////////////////////////////////
string ls_mess, ls_appname
dwitemstatus ldws_1

if  this.dataobject = "d_wv_settings_ldap_set" then
	choose case  dwo.name 
		case "t_2"
			ls_mess = "LDAP Example:~r~n~r~nServer Name: 192.0.3.16~r~nPort: 389 ~r~nStart String: dc=intellisoftgroup,dc=com~r~n" +&
							  +"Filter:~r~n    Microsoft LDAP  : (&(objectClass=user)(cn={username})(!(objectClass=computer)))" +&
						 +"~r~n    IBM LDAP          : (&(objectClass=inetOrgPerson)(cn={username}))" +&
						 +"~r~n    Sun ONE LDAP  : (&(objectClass=person)(uid={username}))"
			messagebox("Prompt", ls_mess)	
		case "t_3"
			ldws_1 = this.getitemstatus(1, "appname", primary!)
			if ldws_1 = newmodified! or ldws_1 = datamodified! or ldws_1 = new! then
				messagebox("Prompt", "App Name has been changed, please save changes!")
				return
			end if
			ls_appname = this.getitemstring(1, "appname")
			if isnull(ls_appname) or ls_appname = '' then return
			openwithparm(w_wv_set_ldap_user, ls_appname)
		case "t_5"
			ls_appname = this.getitemstring(1, "appname")
			if isnull(ls_appname) then ls_appname = '' //add by Stephen 04.01.2012 --BugL040102
			openwithparm(w_wv_appname_modify, ls_appname)
			ls_mess = trim(message.stringparm)
			if not(isnull(ls_mess) or ls_mess = '' ) and ls_appname <> ls_mess then
				this.setitem(1, "appname", ls_mess)
			end if
		case else
	end choose
end if

if this.dataobject = "d_wv_settings_windows_set" then
	choose case dwo.name
		case "t_4"
			ls_appname = this.getitemstring(1, "appname")
			if isnull(ls_appname) then ls_appname = '' //add by Stephen 04.01.2012 --BugL040102
			openwithparm(w_wv_appname_modify, ls_appname)
			ls_mess = trim(message.stringparm)
			if not(isnull(ls_mess) or ls_mess = '' )  and ls_appname <> ls_mess then
				this.setitem(1, "appname", ls_mess)
			end if
		case else
			
	end choose
end if

end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event> buttonclicked
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////

if dwo.name = 'b_1' then
	of_verify_settings()	
end if

end event

type dw_dom_name from u_dw within w_wv_set_maintenance
integer x = 37
integer y = 744
integer width = 1289
integer height = 92
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_wv_settings_domname_sel"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.29.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false)
end event

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
// $<returns> integer
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.05.2012 by Stephen
//////////////////////////////////////////////////////////////////////

if row < 1 then return
is_appname = data
dw_type_set.retrieve(is_appname)
end event

