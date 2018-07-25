$PBExportHeader$w_logon_screen_14.srw
forward
global type w_logon_screen_14 from w_response
end type
type pb_mc from picturebutton within w_logon_screen_14
end type
type pb_lr from picturebutton within w_logon_screen_14
end type
type pb_ur from picturebutton within w_logon_screen_14
end type
type pb_lc from picturebutton within w_logon_screen_14
end type
type pb_uc from picturebutton within w_logon_screen_14
end type
type pb_mr from picturebutton within w_logon_screen_14
end type
type pb_ll from picturebutton within w_logon_screen_14
end type
type pb_ml from picturebutton within w_logon_screen_14
end type
type pb_ul from picturebutton within w_logon_screen_14
end type
type p_2 from picture within w_logon_screen_14
end type
type st_program from statictext within w_logon_screen_14
end type
type shl_website from statichyperlink within w_logon_screen_14
end type
type st_version from statictext within w_logon_screen_14
end type
type sle_pwtestdb from singlelineedit within w_logon_screen_14
end type
type sle_pwtest from singlelineedit within w_logon_screen_14
end type
type cbx_1 from checkbox within w_logon_screen_14
end type
type sle_user_id from singlelineedit within w_logon_screen_14
end type
type st_1 from statictext within w_logon_screen_14
end type
type sle_password from singlelineedit within w_logon_screen_14
end type
type st_2 from statictext within w_logon_screen_14
end type
type cb_ok from u_cb within w_logon_screen_14
end type
type cb_22 from u_cb within w_logon_screen_14
end type
type rb_test from radiobutton within w_logon_screen_14
end type
type rb_tutor from radiobutton within w_logon_screen_14
end type
type rb_prod from radiobutton within w_logon_screen_14
end type
type p_1 from picture within w_logon_screen_14
end type
type r_1 from rectangle within w_logon_screen_14
end type
type p_logo from picture within w_logon_screen_14
end type
end forward

global type w_logon_screen_14 from w_response
integer x = 1184
integer y = 716
integer width = 3465
integer height = 2424
string title = "IntelliSoft Login"
boolean controlmenu = false
long backcolor = 32891346
pb_mc pb_mc
pb_lr pb_lr
pb_ur pb_ur
pb_lc pb_lc
pb_uc pb_uc
pb_mr pb_mr
pb_ll pb_ll
pb_ml pb_ml
pb_ul pb_ul
p_2 p_2
st_program st_program
shl_website shl_website
st_version st_version
sle_pwtestdb sle_pwtestdb
sle_pwtest sle_pwtest
cbx_1 cbx_1
sle_user_id sle_user_id
st_1 st_1
sle_password sle_password
st_2 st_2
cb_ok cb_ok
cb_22 cb_22
rb_test rb_test
rb_tutor rb_tutor
rb_prod rb_prod
p_1 p_1
r_1 r_1
p_logo p_logo
end type
global w_logon_screen_14 w_logon_screen_14

type variables
Integer il_attempts  //Start Code Change ---- 08.02.2007 #V7 maha
integer ii_lock_num
String is_version
string is_mess
string is_sched_username, is_sched_password //Web based scheduler - alfee 01.27.2011

//constant long INTELLI_PURPLE = RGB(80 ,0, 170) v92
//constant long INTELLI_PURPLE = RGB(35 ,0, 105)
constant long INTELLI_PURPLE = RGB(0 ,0, 80)
//constant long INTELLI_PURPLE = RGB(32 ,0, 128)
constant long INTELLI_ORANGE = rgb(255,153,0)
constant long INTELLI_WHITE = rgb(255, 255, 255)
constant long INTELLI_GREY = rgb(175, 175, 175)
constant long INTELLI_black = rgb(0, 0, 0)
constant long INTELLI_Purple_V12 = rgb(75,77,136)
n_cst_encrypt in_encrypt



end variables

forward prototypes
public function integer of_logon ()
public function integer of_change_password (string as_from)
public function integer of_connection ()
public function integer of_user_login (integer ai_attempt)
public function integer of_log_connection (string as_pass)
public function string of_get_autologinname ()
public function integer of_intellicontractlayout ()
public function integer of_click_ok ()
public function integer of_buttons_visible (boolean ab_buttons_visible)
public function integer of_log_failure ()
end prototypes

public function integer of_logon ();
IF of_connect_to_db() = -1 THEN
	return Failure
else
	return Success
end if

end function

public function integer of_change_password (string as_from);
if as_from = "ENCRYPT" then
	messagebox("Password update","Please change your password at this time.  Enter your Current password and then change by entering the New password and Verifying it.")
	openwithparm(w_change_password,"ENCRYPT")
else  //login
	messagebox("Password update","Please change your password at this time.  Enter your Current password and then change by entering the New password and Verifying it.")
	openwithparm(w_change_password,"login")
end if

if message.stringparm = "Cancel" then
	messagebox("Password","Your password is no longer valid.  Closing program.")
	halt
end if


return 1
end function

public function integer of_connection ();//Start Code Change ---- 11.01.2005 #0 maha
//Start Code Change ---- 06.19.2007 #V7 maha
//changed to use new connection function

//SQLCA.DBMS="ODBC"
//if gi_test_database = 1 then //maha 123102
//	SQLCA.DbParm="ConnectString='DSN=IntelliCred Test;UID=DBA;PWD=SQL',DelimitIdentifier='No', ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT', StaticBind=1, DisableBind = 1 "
//elseif gi_test_database = 2 then //tutorial 030805
//	SQLCA.DbParm="ConnectString='DSN=IntelliCred Tutorial;UID=DBA;PWD=SQL',DelimitIdentifier='No', ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT', StaticBind=1, DisableBind = 1 "
////else
////	SQLCA.DbParm="ConnectString='DSN=" + gs_odbc + ";UID=" + gs_user_id + ";PWD=" + gs_password + "',DelimitIdentifier='No', ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT', StaticBind=1, DisableBind = 1 "
//end if	
//SQLCA.AutoCommit = TRUE
//	
string ls_mess
if gi_test_database = 1 then //maha 123102
	gs_odbc = "IntelliCred Test"
	ls_mess = "Login to Test Database Failed! Most likely caused by not having an IntelliCred Test ODBC to connect to the test database."
elseif gi_test_database = 2 then //tutorial 030805
	gs_odbc = "IntelliCred Tutorial"
	ls_mess = "Login to Tutorial Database Failed! Most likely caused by not having an IntelliCred Tutorial ODBC to connect to the tutorial database."
end if

IF of_connect_to_db() = -1 THEN
	MessageBox("Login", ls_mess)
	sle_user_id.setfocus()//maha 080300
	il_attempts ++
	IF il_attempts = 3 THEN
		HALT
	ELSE
		of_logon()
		Return 1
	END IF

end if

//CONNECT USING SQLCA;

//IF SQLCA.SQLCODE = -1 THEN
//	if gi_test_database = 1 then //maha 123102
//		MessageBox("Login", "Login to Test Database Failed! Most likely caused by not having an IntelliCred Test ODBC to connect to the test database.")
//	elseif gi_test_database = 2 then //maha 030805
//		MessageBox("Login", "Login to Tutorial Database Failed! Most likely caused by not having an IntelliCred Tutorial ODBC to connect to the tutorial database.")
//	//else normal
//	end if
//	sle_user_id.setfocus()//maha 080300
//	il_attempts ++
//	IF il_attempts = 3 THEN
//		HALT
//	ELSE
//		of_logon()
//		Return 1
//	END IF
//end if
//End Code Change---06.20.2007 


return 1


end function

public function integer of_user_login (integer ai_attempt);//Start Code Change ----03.20.2013 #V12 maha - rebuilt function for new password encryption
integer cnt
integer li_opt2 //maha 10.23.2012
string ls_passdb
string ls_user
string ls_password
string ls_user_test = ""
string ls_passorg
string ls_salt  //maha 03.20.2013
string ls_type  //maha 03.20.2013
integer li_ret
integer li_role
integer li_active = 1 ////Start Code Change ----07.16.2009 #V92 maha - initialized to 1 to avoid update issue
integer li_failed_count
datetime ldt_locktime

ls_user = sle_user_id.text
ls_password = sle_password.text
ls_passorg = ls_password
////ls_password = in_encrypt.of_encrypt(ls_password)
////sle_pwtest.text = ls_password


//get user info
gnv_appeondb.of_startqueue() //alfee 04.08.2013
select set_45, set_36 into :gi_encryption_val, :gi_pw_expdays from icred_settings; //alfee 04.10.2013
select user_id, user_password, role_id into :ls_user_test, :ls_passdb,  :li_role from security_users where upper(user_id) = upper(:ls_user);
//Start Code Change ----04.10.2009 #V92 maha - added separate query for new fields because upgrades from 6 to 8 caused failure of role test because fields did not exist
select  lock_until, active_status into  :ldt_locktime, :li_active from security_users where upper(user_id) = upper(:ls_user);
//Start Code Change ----03.20.2013 #V12 maha
select brown_val, fail_count into  :ls_salt, :li_failed_count  from security_users where upper(user_id) = upper(:ls_user);
select opt_2 into :li_opt2 from security_settings;
gnv_appeondb.of_commitqueue() //alfee 04.08.2013

gs_user_id = ls_user

//set defaults for nulls
if isnull(ls_salt) then ls_salt = ""
if isnull(li_failed_count) then li_failed_count = 0

if isnull(ls_passdb) or ls_passdb = "" then
	ls_type = "NONE" //no pw in db
elseif mida(ls_passdb, 1,1) = "#" then
	ls_type = "E1"  //encrypt 1
elseif mida(ls_passdb, 1,1) = "$" then //Start Code Change ----03.30.2013 #V12 maha
	ls_type = "E2"	//encrypt 2
else
	ls_type = "NE" //not encrypted
end if

//lockout check
if upper(ls_user) = "MASTER" then
	//skip test
else
	//Checked for locked out
	if ii_lock_num > 0 then  //locked = 1
		if ldt_locktime > datetime(today(),now()) then //lockout test
			return -5
		end if
	end if
	
	sle_pwtestdb.text = ls_passdb
	
	//check existance of user
	if isnull(ls_user_test) or ls_user_test = "" then 
		if li_opt2 = 1 then
			messagebox("Login Error","Invalid user name or password.")
		else
			messagebox("Login Error","Invalid user name '" + ls_user + "'.  Please check your spelling, or the user is not entered into IntelliCred.")
		end if
		return -1
	end if
	
	//check active (ameripath)
	if li_active = 0 then
		return -3
	end if
	//End Code Change---05.15.2009
	
		
	//check for high failed count   //Start Code Change ----03.30.2013 #V12 maha
	if li_failed_count > 25 then
		return -6
	end if
end if

//check for MASTER login
if upper(ls_user) = "MASTER" then 

	if appeongetclienttype() = "PB" and (gb_IsAutoExpImp or gb_AutoSchedule) then  //add if statement for Web based scheduler - alfee 01.27.2011
		//do nothing
	else
		if upper(ls_passorg) <> of_day_password(today()) then
			messagebox("Login Error","Invalid password for user name MASTER.  This is not today's password")
			return -1
		end if
	end if
else 
//ALL OTHER USERS
	if ls_type = "NONE" then
		li_ret = of_change_password("login")
		if li_ret = -1 then
			of_log_failure()
			return -1
		end if
	elseif ls_type = "NE" then //No Encryption
		if  ls_passdb = ls_passorg then
			li_ret = of_change_password("login")
			if li_ret = -1 then
				of_log_failure()
				return -1
			end if
		else
			of_log_failure()
			return -1
		end if
	elseif ls_type = "E1" then  //Encryption 1
		ls_password = in_encrypt.of_encrypt(ls_password)
		if ls_passdb <> ls_password then  //comparing encrypted  pw as entered with value in datatabase
			if li_opt2 = 1 then
				messagebox("Login Error","Invalid user name or password.")
			else
				messagebox("Login Error","Invalid password for user name '" + ls_user + "'.  Please check your spelling.")
			end if
			of_log_failure()
			return -1
		end if
	elseif ls_type = "E2" then  //Encryption 2   //Start Code Change ----03.30.2013 #V12 maha
		if ls_salt = "" then //if encrypted but there is no salt value
			li_ret = of_change_password("login")
			if li_ret = -1 then
				of_log_failure()
				return -1
			end if
		else
			ls_password = in_encrypt.of_encrypt2(ls_password, ls_salt)
			if ls_passdb <> ls_password then  //comparing encrypted  pw as entered with value in datatabase
				if li_opt2 = 1 then
					messagebox("Login Error","Invalid user name or password.")
				else
					messagebox("Login Error","Invalid password for user name '" + ls_user + "'.  Please check your spelling.")
				end if
				of_log_failure()
				return -1
			end if
		end if
	else
		messagebox("Login Error","Unable to check user and password combination.  Contact ISG support")
	end if
	
	//Start Code Change ----03.06.2009 #V92 maha - added trap for null role
	if isnull(li_role) or li_role = 0 then
		messagebox("Login Error","User name '" + ls_user + "' has no IntelliSoft role and may have been setup in Webview only.  This user id must be assigned a role in the User Administration in order to log in to this program.")
		return -1
	end if
	//End Code Change---03.06.2009
	
end if

//messagebox("","test")
return 1 

end function

public function integer of_log_connection (string as_pass);//function created maha 11-21-05 to track login attempts for future development
//Start Code Change ---- 10.05.2006 #1 maha changed table name updated.
time lt_time = now()

datetime ldt_date
string ls_password

ldt_date = datetime(today(),now())
 
gnv_appeondb.of_startqueue() //alfee 04.08.2013  
if as_pass = "FAIL"  or as_pass = "LOCK" or as_pass = "INACTIVE"   then //Start Code Change ----04.06.2009 #V92 maha - added inactive for ameripath
	if upper(gs_user_id) = "MASTER" then  //Start Code Change ---- 03.13.07.2007 #V7 maha
		ls_password = "********"  
	else
		ls_password =  "********"  //gs_password  //Start Code Change ---- 05.13.07.2011 #V11 maha - don't track bad passwords
	end if
else //if pass don't log the password
	ls_password = "********"
	
	update security_users set last_login_date = :ldt_date, fail_count = 0 where user_id = :gs_user_id; //Start Code Change ----03.20.2013 v12 maha - added fail_count
end if

//----------Begin Modified by alfee 04.08.2013 for performance tuning ------------------
insert into security_login_tracking (user_id,user_password,log_date,pass_fail,client_ip) values (:gs_user_id,:ls_password,:ldt_date,:as_pass,:gs_client_ip); 
gnv_appeondb.of_commitqueue()
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-02
////$<add> 03.15.2006 By: Cao YongWang
////$<reason> Performance tuning.
////$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.
//gnv_appeondb.of_autocommit()
////---------------------------- APPEON END ----------------------------
//insert into security_login_tracking (user_id,user_password,log_date,pass_fail,client_ip) values (:gs_user_id,:ls_password,:ldt_date,:as_pass,:gs_client_ip); //Evan 08.26.2009 --- Audit Client IP
//commit using sqlca;
////End Code Change---10.05.2006
//----------End Modified --------------------------------------------------------------------------

return 1
end function

public function string of_get_autologinname ();//////////////////////////////////////////////////////////////////////
// $<function>w_logon_screenof_get_autologinname()
// $<arguments>(None)
// $<returns> string : Auto Login Name
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11/19/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_LDAPUser,ls_os_username,ls_domainname,ls_computer_name
String ls_user_id
n_cst_systeminfo lnv_systeminfo
gb_autologin = False

//Case Appeon Security User(LDAP User)
ls_LDAPUser = AppeonGetAppeonUserName()

If LenA(ls_LDAPUser) > 0 Then
	//Get login user ID for IC by LDAP User
	Select user_id Into :ls_user_id From security_users Where upper(ic_ldap_user) = upper(:ls_LDAPuser);
	If ls_user_id = '' or isnull(ls_user_id) Then
		MessageBox("Login Error","The LDAP user '"+ls_LDAPUser+"' does not map with any IntelliCred user ID in the User Painter.")
		Halt
	End If
	gb_autologin = True
	Return ls_user_id
End If

//Case Command Line User(LDAP User)
//Get login user from Command Line 
//For Interface in the future


//Case Domain & User(OS Login User)
lnv_systeminfo = Create n_cst_systeminfo
ls_os_username = lnv_systeminfo.of_get_username()
ls_domainname = lnv_systeminfo.of_get_domainname()
ls_computer_name = lnv_systeminfo.of_get_computername()

//ls_domainname = ls_computer_name means it do not login domain server.
If ls_domainname <> ls_computer_name Then
	Select user_id Into :ls_user_id From security_users Where upper(ic_ldap_user) = upper(:ls_os_username) and upper(domain_name) = upper(:ls_domainname);	
	If ls_user_id = '' or isnull(ls_user_id) Then
		Select user_id Into :ls_user_id From security_users Where upper(ic_ldap_user) = upper(:ls_os_username) and upper(domain_name) = upper(:ls_domainname) + '.COM';
		If ls_user_id = '' or isnull(ls_user_id) Then
			//Continue
		Else
			Destroy lnv_systeminfo
			gb_autologin = True
			Return ls_user_id
		End If
	Else
		Destroy lnv_systeminfo
		gb_autologin = True
		Return ls_user_id
	End If
End If
If isvalid(lnv_systeminfo) Then Destroy lnv_systeminfo
Return ''
end function

public function integer of_intellicontractlayout ();//////////////////////////////////////////////////////////////////////
// $<Function>  of_intellicontractlayout()
// $<arguments> (None)
// $<returns>   integer
// $<description> Execute IntelliContract screen layout
//////////////////////////////////////////////////////////////////////
// $<add> 11/10/2008 by Evan
//////////////////////////////////////////////////////////////////////
//Start Code Change ----05.21.2013 #V14 maha - this code not used since ver8  commented for reference reasons
//this.Resize(3770, 2476)
//p_1.Move(0, -10)
//p_1.Resize(3749, 2400)
//
//sle_user_id.X = 1150
//sle_password.X = sle_user_id.X
//sle_user_id.Y = 1230
//sle_password.Y = sle_user_id.Y + 168
//
//st_1.X = sle_user_id.X
//st_2.X = sle_user_id.X
//st_1.Y = sle_user_id.Y - st_1.Height - 4
//st_2.Y = sle_password.Y - st_2.Height - 4
//st_1.Text = "Username"
//st_1.TextColor = RGB(66,66,66)
//st_2.TextColor = RGB(66,66,66)
//st_1.BackColor = RGB(244,245,245)
//st_2.BackColor = RGB(244,245,245)
//
//cb_2.X = sle_user_id.X
//cb_1.X = sle_user_id.X + cb_2.Width + 4
//cb_2.Y = sle_password.Y + 150
//cb_1.Y = cb_2.Y
//cb_1.Text = "&Login"
//cb_1.TextColor = RGB(248,251,246)
//cb_2.TextColor = RGB(248,251,246)
//cb_1.BackColor = RGB(134,196,64)
//cb_2.BackColor = RGB(134,196,64)
//
//rb_test.X = sle_user_id.X + sle_user_id.Width + 250
//rb_test.Y = sle_user_id.Y
//rb_prod.X = rb_test.X
//rb_prod.Y = rb_test.Y + 100
//rb_tutor.X = rb_test.X
//rb_tutor.Y = rb_prod.Y + 100
//rb_test.TextColor = RGB(244,245,245)
//rb_prod.TextColor = RGB(244,245,245)
//rb_tutor.TextColor = RGB(244,245,245)
//rb_test.BackColor = RGB(42,134,199)
//rb_prod.BackColor = RGB(42,134,199)
//rb_tutor.BackColor = RGB(42,134,199)
//
//st_version.X = 832
//st_version.Y = 1880
//st_version.Resize(1486, 152)
//st_version.TextColor = RGB(198,216,229)
//st_version.BackColor = RGB(42,134,199)
//st_version.Alignment = Left!
//st_version.Show()
//
//shl_website.X = 841
//shl_website.Y = 2068
//shl_website.Resize(1330, 68)
//shl_website.TextColor = RGB(18,58,87)
//shl_website.BackColor = RGB(42,134,199)
//shl_website.Show()

Return 1
end function

public function integer of_click_ok ();//Start Code Change ----08.20.2012 #V12 maha - new function
String ls_password
integer li_user
integer li_set7
date ld_password
datetime ldt_lock //Start Code Change ---- 08.02.2007 #V7 maha
integer li_days
integer li_res
integer li_lock //Start Code Change ---- 08.02.2007 #V7 maha
time lt_time


//maha 112105 major functionality change connection using dba for all connections

IF IsNull( sle_user_id.Text ) OR sle_user_id.Text = "" THEN
	MessageBox("Required Field", "You must enter a user name." )
	sle_user_id.setfocus()//maha 080300
	Return -1
END IF

IF IsNull( sle_password.Text ) OR sle_password.Text = "" THEN
	MessageBox("Required Field", "You must enter a password." )
	sle_password.setfocus()//maha 080300
	Return -1
END IF

gs_user_id = sle_user_id.Text
gs_password = sle_password.Text
gnv_app.of_setuserid( gs_user_id )
ls_password = sle_password.Text

IF ls_password = "IntelliMasterSE" THEN
	sle_user_id.Visible = True
	st_1.Visible = True
	sle_password.Text = ""
	sle_user_id.Text = ""
	Return 1
END IF

if rb_test.checked = true  then //maha 123102
	gi_test_database = 1
elseif rb_tutor.checked = true then //maha 03085
	gi_test_database = 2
else  //production database
	gi_test_database = 0
end if


if gi_test_database > 0 then
	DISCONNECT USING SQLCA;
	li_res = of_connection()
	if li_res = -1 then
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 06.30.2011
		//$<reason> login failure web deployment bug #2491
		/*
		HALT
		*/
		is_mess = "Cancel"
		w_logon_screen.triggerevent(close! )
		return -1
		//------------------- APPEON END -------------------
	end if
end if


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11/19/2007 By: Ken.Guo
//$<reason> LDAP user need auto login
//li_res = of_user_login( il_attempts)
If gb_autologin = True Then
	//Use LDAP user login
	gs_user_id = sle_user_id.text
	li_res = 1
Else 
	//Use intellicred user login
	li_res = of_user_login( il_attempts)
End If
//---------------------------- APPEON END ----------------------------

//Start Code Change ---- 08.02.2007 #V7 maha added changes for login locking
IF li_res = -1 THEN
	of_log_connection("FAIL")
	il_attempts ++
	IF il_attempts = 3  and ii_lock_num = 0   THEN
		messagebox("Login Error","You have reached the maximum number of attempts.  Closing Program")
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 06.30.2011
		//$<reason> login failure web deployment bug #2491
		/*
		HALT
		*/
		is_mess = "Cancel"
		w_logon_screen.triggerevent(close! )
		return -1
		//------------------- APPEON END -------------------
	elseif il_attempts =  ii_lock_num then //08.02.2007 #V7 maha
		of_log_connection("LOCK")
		messagebox("Login Error","You have reached the maximum number of attempts and will be locked out.  Closing Program")
		select lockout_min into :li_lock from security_settings;
		lt_time = now()
		lt_time = RelativeTime ( lt_time, li_lock  * 60 )
		ldt_lock = datetime(today(),lt_time)
		update security_users set lock_until = :ldt_lock where user_id = :gs_user_id;
		commit using sqlca;
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 06.30.2011
		//$<reason> login failure web deployment bug #2491
		/*
		HALT
		*/
		is_mess = "Cancel"
		w_logon_screen.triggerevent(close! )
		return -1
		//------------------- APPEON END -------------------
	ELSE  
//		if gi_test_database > 0 then //maha removed 8.2.07 should not connect to prod database if test fails
//			of_logon() //reconnect to the production database
//		end if
		Return li_res //Change from "Return" to "Return li_res" - Web based scheduler - alfee 01.27.2011
	END IF
elseif li_res = -5 then 
	messagebox("Login Error","This login is currently locked out.  Closing Program")
	of_log_connection("LOCK")
	HALT
//End Code Change---08.02.2007		
elseif li_res = -3 then //Start Code Change ----04.06.2009 #V92 maha - added ameripath custom
	messagebox("Login Error"," The user '" + gs_user_id + "' is an inactive login and cannot be used to connect to the program.  Contact your system administrator to reset.")
	of_log_connection("INACTIVE")
	HALT
else //login successful
	of_log_connection("PASS")
	//-----Begin Added by Alfee 01.27.2011 ----------------------------
	//Web based scheduler - Keep the login info for the first time
	if AppeonGetClientType() = "WEB" and (gb_IsAutoExpImp or gb_AutoSchedule) and upper(gs_user_id) <> "MASTER" and Not gb_autologin then 
		if IsNull(is_sched_username) or IsNull(is_sched_password) or Len(Trim(is_sched_username)) < 1 or Len(Trim(is_sched_password)) < 1 then	
			if MessageBox("Question", "Do you want the system to remember the login info for the IntelliSoft Scheduler program?", Question!, YesNo!, 1) = 1 then
				gnv_appeondll.of_registryset ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Username", regstring!, gs_user_id)
				gnv_appeondll.of_registryset ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Password", regstring!, in_encrypt.of_encrypt(ls_password))
			end if				
		end if
	end if
	//-----End Added ------------------------------------------------------
end if

is_mess = gs_user_id
//w_logon_screen.triggerevent(close!)

Return li_res //Web based scheduler - alfee 01.27.2011


return 1
end function

public function integer of_buttons_visible (boolean ab_buttons_visible);//Start Code Change ----03.12.2013 #V12 maha - added

If ab_buttons_visible then //when ok clicked
	cb_ok.visible = false
	pb_ul.visible = true
	pb_ul.bringtotop = true
	pb_uc.visible = true
	pb_uc.bringtotop = true
	pb_ur.visible = true
	pb_ur.bringtotop = true
	pb_ml.visible = true
	pb_ml.bringtotop = true
	pb_mc.visible = true
	pb_mc.bringtotop = true
	pb_mr.visible = true
	pb_mr.bringtotop = true
	pb_ll.visible = true
	pb_ll.bringtotop = true
	pb_lc.visible = true
	pb_lc.bringtotop = true	
	pb_lr.visible = true
	pb_lr.bringtotop = true
	
	p_logo.visible = false

	
else //when window opens
	pb_ul.visible = False
	pb_ul.bringtotop = False
	pb_uc.visible = False
	pb_uc.bringtotop = False
	pb_ur.visible = False
	pb_ur.bringtotop = False
	pb_ml.visible = False
	pb_ml.bringtotop = False
	pb_mc.visible = False
	pb_mc.bringtotop = False
	pb_mr.visible = False
	pb_mr.bringtotop = False
	pb_ll.visible = False
	pb_ll.bringtotop = False
	pb_lc.visible = False
	pb_lc.bringtotop = False	
	pb_lr.visible = False
	pb_lr.bringtotop = False
	
	p_logo.visible = true
	p_logo.bringtotop = false
	cb_ok.default = true
	
end if


return 1
end function

public function integer of_log_failure ();//Start Code Change ----03.30.2013 #V12 maha
update security_users set fail_count = fail_count + 1 where user_id = :gs_user_id;
commit using sqlca;

return 1
end function

on w_logon_screen_14.create
int iCurrent
call super::create
this.pb_mc=create pb_mc
this.pb_lr=create pb_lr
this.pb_ur=create pb_ur
this.pb_lc=create pb_lc
this.pb_uc=create pb_uc
this.pb_mr=create pb_mr
this.pb_ll=create pb_ll
this.pb_ml=create pb_ml
this.pb_ul=create pb_ul
this.p_2=create p_2
this.st_program=create st_program
this.shl_website=create shl_website
this.st_version=create st_version
this.sle_pwtestdb=create sle_pwtestdb
this.sle_pwtest=create sle_pwtest
this.cbx_1=create cbx_1
this.sle_user_id=create sle_user_id
this.st_1=create st_1
this.sle_password=create sle_password
this.st_2=create st_2
this.cb_ok=create cb_ok
this.cb_22=create cb_22
this.rb_test=create rb_test
this.rb_tutor=create rb_tutor
this.rb_prod=create rb_prod
this.p_1=create p_1
this.r_1=create r_1
this.p_logo=create p_logo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_mc
this.Control[iCurrent+2]=this.pb_lr
this.Control[iCurrent+3]=this.pb_ur
this.Control[iCurrent+4]=this.pb_lc
this.Control[iCurrent+5]=this.pb_uc
this.Control[iCurrent+6]=this.pb_mr
this.Control[iCurrent+7]=this.pb_ll
this.Control[iCurrent+8]=this.pb_ml
this.Control[iCurrent+9]=this.pb_ul
this.Control[iCurrent+10]=this.p_2
this.Control[iCurrent+11]=this.st_program
this.Control[iCurrent+12]=this.shl_website
this.Control[iCurrent+13]=this.st_version
this.Control[iCurrent+14]=this.sle_pwtestdb
this.Control[iCurrent+15]=this.sle_pwtest
this.Control[iCurrent+16]=this.cbx_1
this.Control[iCurrent+17]=this.sle_user_id
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.sle_password
this.Control[iCurrent+20]=this.st_2
this.Control[iCurrent+21]=this.cb_ok
this.Control[iCurrent+22]=this.cb_22
this.Control[iCurrent+23]=this.rb_test
this.Control[iCurrent+24]=this.rb_tutor
this.Control[iCurrent+25]=this.rb_prod
this.Control[iCurrent+26]=this.p_1
this.Control[iCurrent+27]=this.r_1
this.Control[iCurrent+28]=this.p_logo
end on

on w_logon_screen_14.destroy
call super::destroy
destroy(this.pb_mc)
destroy(this.pb_lr)
destroy(this.pb_ur)
destroy(this.pb_lc)
destroy(this.pb_uc)
destroy(this.pb_mr)
destroy(this.pb_ll)
destroy(this.pb_ml)
destroy(this.pb_ul)
destroy(this.p_2)
destroy(this.st_program)
destroy(this.shl_website)
destroy(this.st_version)
destroy(this.sle_pwtestdb)
destroy(this.sle_pwtest)
destroy(this.cbx_1)
destroy(this.sle_user_id)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.st_2)
destroy(this.cb_ok)
destroy(this.cb_22)
destroy(this.rb_test)
destroy(this.rb_tutor)
destroy(this.rb_prod)
destroy(this.p_1)
destroy(this.r_1)
destroy(this.p_logo)
end on

event open;call super::open;blob lb_splash_pic
integer setprod
integer li_testbox
integer li_rand //maha 072409
integer li_banner //maha 040109
integer li_set //maha 03.24.2011
string pspath
String ls_dev
string ls_original_dev_setting
string ls_prod
string ls_dep
string ls_name

//in_encrypt = create n_cst_encrypt
 

is_version = ProfileString(gs_IniFilePathName, "Setup", "GraphAngle", "None")
gs_odbc = ProfileString(gs_IniFilePathName, "Setup", "odbc", "None")

//Start Code Change ---- 12.21.2005 #172 maha
pspath = gs_IniFilePathName


ls_original_dev_setting = ProfileString(pspath, "setup", "development", "None")
// set the development to 2 so that it will pop up
//SetProfileString(pspath,"setup", "development", "2")
// reset to defauly
ls_dev = ProfileString(pspath, "setup", "development", "None")
// reset 
//SetProfileString(pspath,"setup", "development", ls_original_dev_setting)
//maha 122105

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-03-14 By: Scofield
//$<Reason> Init gi_support_pw_on variable.

//if integer(ls_dev) > 0 then
//	gi_support_pw_on = 1 //maha 032806
//end if

ls_dev = ProfileString(gs_IniFilePathName, "setup", "development", "None")
if Integer(ls_dev) > 0 then
	gi_dev_mode = Integer(ls_dev) //alfee 04.16.2009
	gi_support_pw_on = 0		//Turn off password protect,developer don't need password
else
	gi_support_pw_on = 1		//Turn on password protect,general user need password
end if
//---------------------------- APPEON END ----------------------------
//string gs_dev_mode //Alfee 04.16.2009


if integer(ls_dev) = 1 or integer(ls_dev) = 3 then	
	
	open (w_database_type)
	gs_dbtype =  message.stringparm
	if gs_dbtype = "ASA" then
		gs_odbc = "IntelliCred Client"
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources", "IntelliCred Client", RegString!, "SQL Server")
//    RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "Driver", RegString!, "C:\PROGRAM FILES\SYBASE\SQL ANYWHERE 7\WIN32\dbodbc7.dll")
//    RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "autostop", RegString!, "Y")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "CommBufferSize", RegString!, "8192")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "CommBufferSpace", RegString!, "32")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "CommLinks", RegString!, "SharedMemory,TCPIP{}")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "Debug", RegString!, "NO")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "DisableMultiRowFetch", RegString!, "NO")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "EngineName", RegString!, "appeon")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "Integrated", RegString!, "NO")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "PrefetchBuffer", RegString!, "256")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "PWD", RegString!, "sql")
//		RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client", "UID", RegString!, "dba")
		
	elseif gs_dbtype = "SQL" then
		// trusted connection
       // RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources", "IntelliCred Client SQL", RegString!, "SQL Server")
//      RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client SQL", "Driver", RegString!, "C:\\WINNT\\System32\\SQLSRV32.dll")
//      RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client SQL", "Server", RegString!, "DELL5\INTELLISOFT")
        //RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client SQL", "Trusted_connection", RegString!, "Y")
			// not trusted connection
		   string ls_titlefont
         RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client SQL", "Database", RegString!, ls_titlefont)
			
		   if LenA(ls_titlefont) < 1 then  
			  RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI", "IntelliCred Client SQL", RegString!, "SQL Server")
			  RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client SQL", "Driver", RegString!, "C:\WINDOWS\system32\SQLSRV32.dll")
			  RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client SQL", "Server", RegString!, "DELL5\INTELLISOFT")
			  RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client SQL", "Database", RegString!, "Intellicred") 
			  RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\IntelliCred Client SQL", "LastUser", RegString!, "dba")
		end if 
	
	gs_odbc = "IntelliCred Client SQL"

	else
		gs_dbtype = ""
	end if
end if
//End Code Change---12.21.2005 

if gs_odbc = "None" then gs_odbc = "Intellicred Client"
//messagebox("gs_odbc",gs_odbc)
//If GraphAngle = 50 then its a IntelliCred SE install
IF is_version = "50" THEN
	sle_user_id.Visible = False
	st_1.Visible = False
	sle_user_id.Text = "SE"
	sle_password.SetFocus()
END IF

IF of_logon() = -1 THEN
	is_mess = "DB Error"
	w_logon_screen.triggerevent(close! )
//CloseWithReturn( Parent, is_mess )

	Return
END IF


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.16.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Integrate the SQL statements that retrieve data from the database into Appeon Queue labels to reudce 
//$<modification> client-server interactions for performance tuning.

//select set_24 into :li_testbox from icred_settings; //maha123102
//select set_9 into :setprod from icred_settings; //maha031705

gnv_appeondb.of_startqueue()
select set_24 into :li_testbox from icred_settings; //maha123102
select set_9 into :setprod from icred_settings; //maha031705
select login_lockout into :ii_lock_num from security_settings; //Start Code Change ---- 08.02.2007 #V7 maha
select set_product into :li_set from icred_settings; //Start Code Change ----03.24.2011 #V11 maha 
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------
if isnull(ii_lock_num) then ii_lock_num = 0  //Start Code Change ---- 08.02.2007 #V7 maha

//login screen format changes
//Start Code Change ----04.02.2010 #V10 maha - reworked title code
choose case setprod
	case 1
		ls_prod = "IntelliApp" 
	case 4
		ls_prod = "IntelliContract"
	case 5
		ls_prod = "IntelliApp Smart" //killnetics" //"IntelliApp Kenetics"
	case else
		ls_prod = "IntelliCred"
end choose

ls_name = CharA ( 174 ) 

//if setprod <> 5 then
	ls_name+= " 14.0"
//end if

IF appeongetclienttype() = 'WEB' THEN
	ls_dep =  " for Web" 
else
	ls_dep  = " for Windows" 
end if

//Start Code Change ----03.24.2011 #V11 maha 
if li_set = 1 then
	st_program.text = "IntelliSoft Group Software"
else
	st_program.text = ls_prod + ls_name + ls_dep
end if
//Start Code Change ----03.24.2011 

//Start Code Change ----06.25.2009 #V92 maha - additional text changes
//if setprod = 1 then
////	this.title = "IntelliApp Logon"
////	p_1.picturename= "IntelliApp-Splash.gif" 
//	
//	IF appeongetclienttype() = 'WEB' THEN
//		st_program.text = "IntelliApp Renaissance for Web" 
//	else
//		st_program.text = "IntelliApp Renaissance for Windows" 
//	end if
//	
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-01-17 By: Rodger Wu
//elseif setprod = 4 then
////	this.title = "IntelliContract Logon"
////	p_1.picturename= "IntelliContract-Splash.gif" 
////---------------------------- APPEON END ----------------------------
////	of_IntelliContractLayout() //Add by Evan 11/10/2008
//	IF appeongetclienttype() = 'WEB' THEN
//		st_program.text = "IntelliContract Renaissance for Web" 
//	else
//		st_program.text = "IntelliContract Renaissance for Windows" 
//	end if
//else
////	this.title = "IntelliCred Logon"
////	p_1.picturename= "IntelliCred-Splash.gif"
//	IF appeongetclienttype() = 'WEB' THEN
//		st_program.text = "IntelliCred Renaissance for Web"
//	else
//		st_program.text = "IntelliCred Renaissance for Windows" 
//	end if
//end if
//
////Start Code Change ----07.24.2009 #V92 maha
//randomize(0)
//li_rand = Rand(5)
//choose case li_rand
//	case 1
//		p_i1.visible = true
//	case 2
//		p_i2.visible = true
//	case 3
//		p_i3.visible = true
//	case 4
//		p_i4.visible = true
//	case 5
//		p_i5.visible = true
//end choose
////End Code Change---07.24.2009

//Start Code Change ----06.25.2009 #V92 maha - removed; do not want this functionality at this time
//lb_splash_pic=of_get_pic_fromdb()
//if not isnull(lb_splash_pic) then
//	p_1.originalsize=false
//	p_1.width=3749
//	p_1.height=2400
//	p_1.setpicture(lb_splash_pic)
//end if
//End Code Change---06.25.2009


Choose CASE li_testbox //maha 030805
	case 0
		rb_test.visible = false
		rb_tutor.visible = false
		rb_prod.visible = false
	case 1
		rb_test.visible = true
		rb_tutor.visible = false
		rb_prod.visible = true
	case 2
		rb_test.visible = false
		rb_tutor.visible = true
		rb_prod.visible = true
	case 3
		rb_test.visible = true
		rb_tutor.visible = true
		rb_prod.visible = true
end choose

//BEGIN---Modify by Evan 11/11/2008
//st_version.text = "Product Version " + gs_version
st_version.text = gnv_app.of_GetVersionLabel()
st_version.text+=  " " + CharA ( 169 ) + "ISG Group LLC 1998-2013" //maha 04.02.2010 - added
//END---Modify by Evan 11/11/2008

IF ls_dev = "1" THEN
	SQLCA.DBMS="ODBC"
	if gi_test_database = 1 then
		SQLCA.DbParm="ConnectString='DSN=IntelliCred Test;UID=master;PWD=" + SUPER_MASTER_PASSWORD + ";',DelimitIdentifier='Yes'"
	else
		SQLCA.DbParm="ConnectString='DSN=" + gs_odbc + ";UID=master;PWD=" + SUPER_MASTER_PASSWORD + ";',DisableBind=1,DelimitIdentifier='Yes',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
	end if

	SQLCA.AutoCommit = TRUE
	gs_user_ID = "MASTER"
	gs_password = SUPER_MASTER_PASSWORD

	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2007-09-14 By: Scofield
	//$<Reason> Set the connection cache dynamically on Web
	if AppeonGetClientType() = 'WEB' then
		SQLCA.DBMS = gs_CacheType
		SQLCA.DBParm = gs_CacheSet
	end if
	//---------------------------- APPEON END ----------------------------

	CONNECT USING SQLCA;
	gnv_app.of_setuserid( "MASTER" )
	is_mess = gs_user_id
	w_logon_screen.triggerevent(close! )
elseif ls_dev = "2"  or ls_dev = "3" THEN
	sle_user_id.text = "user1"
	sle_password.text = "123"
END IF

String ls_password

gs_user_id = 'MASTER'
gnv_app.of_setuserid( gs_user_id )
ls_password = SUPER_MASTER_PASSWORD

//Start Code Change ----04.01.2009 #V92 maha - added for ameripath customization
select use_banner into :li_banner from security_settings;

//if li_banner = 1 then
if li_banner = 1 and not gb_IsAutoExpImp and not gb_AutoSchedule then //web based scheduler - alfee 01.27.2011
	open(w_security_banner)
	if message.stringparm = "Cancel" then 
		close (this)
		Halt
	end if
end if
//End Code Change---04.01.2009

//Start Code Change ----03.12.2013 #V14 maha - hide buttons
of_buttons_visible( false)
//End Code Change ----03.12.2013 


end event

event closequery;call super::closequery;if is_mess = "" then is_mess = "Cancel"
end event

event close;call super::close;CloseWithReturn( this, is_mess )
end event

event key;call super::key;

IF KeyDown(KeyF12!) THEN
	cbx_1.visible = true
end if 
end event

event pfc_postopen;call super::pfc_postopen;//--------------------------- APPEON BEGIN ---------------------------
//$<add> Evan 03.12.2009
//$<reason> Auto login with MASTER user if is auto export or auto import
string ls_dev
//if gb_IsAutoExpImp  or gb_AutoSchedule then	//Modified by Nova 12.29.2009 -v10.1 Scheduler Functionality 
if AppeonGetClientType() = "PB" and (gb_IsAutoExpImp  or gb_AutoSchedule) then //Web based scheduler - alfee 01.27.2011
	ls_dev = ProfileString(gs_IniFilePathName, "setup", "development", "None")
	if not (Integer(ls_dev) = 1 or Integer(ls_dev) = 3) then
		sle_user_id.Text = "MASTER"
		sle_password.Text = SUPER_MASTER_PASSWORD
		cb_ok.Event Clicked()
		Return
	end if
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10/09/2007 By: Ken.Guo
//$<reason> Auto login if use LDAP user
String ls_user_id
//Get auto login user ID if need.
ls_user_id = of_get_autologinname()

If ls_user_id <> '' Then
	sle_user_id.text = ls_user_id
	sle_user_id.displayonly = True
	sle_password.text = '********'
	sle_password.displayonly = True
	Post Sleep(1)  //For displaying logo.
	cb_ok.post event CLICKED()	
	Return //Web based scheduler - alfee 01.27.2011	
End If
//---------------------------- APPEON END ----------------------------

//-----Begin Added by Alfee 01.27.2011 ----------------------------
//Web based scheduler 
If AppeonGetClientType() = "WEB" and (gb_IsAutoExpImp or gb_AutoSchedule) Then 
	//Get the username and password
	gnv_appeondll.of_registryget ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Username", regstring!, is_sched_username)
	gnv_appeondll.of_registryget ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Password", regstring!, is_sched_password)
	If Len(Trim(is_sched_username)) > 0 And Len(Trim(is_sched_password)) > 0 Then
		//verify the username and password
		sle_user_id.Text = is_sched_username
		sle_password.Text = in_encrypt.of_decrypt(is_sched_password) //decrypt the password
		//show the logon window if failed to login 
		If cb_ok.Event Clicked() <> 1 Then 
			is_sched_username = ""
			is_sched_password = ""
			this.show() 
		End If
	Else
		//show the logon window for the first time
		this.show()
	End If
End If
//-----End Added ------------------------------------------------------
end event

event pfc_preopen;call super::pfc_preopen;if gb_IsAutoExpImp or gb_AutoSchedule then this.Hide()//Modified by Nova 12.29.2009 -v10.1 Scheduler Functionality  //Added by Evan 03.12.2009
end event

type pb_mc from picturebutton within w_logon_screen_14
integer x = 1152
integer y = 832
integer width = 1134
integer height = 644
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Main Window"
string picturename = "Splash-v12.png"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen = 0 
parent.triggerevent(close! )
	

end event

type pb_lr from picturebutton within w_logon_screen_14
integer x = 2299
integer y = 1500
integer width = 1134
integer height = 644
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print Apps"
string picturename = "C:\Users\maha\Pictures\login buttons\appl 1.jpg"
long textcolor = 16777215
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen = 0
parent.triggerevent(close! )
	

end event

type pb_ur from picturebutton within w_logon_screen_14
integer x = 2299
integer y = 168
integer width = 1134
integer height = 644
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Privileges"
string picturename = "C:\Users\maha\Pictures\login buttons\key 3.jpg"
long textcolor = 16711680
long backcolor = 32891346
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen = 0
parent.triggerevent(close! )
	

end event

type pb_lc from picturebutton within w_logon_screen_14
integer x = 1147
integer y = 1500
integer width = 1134
integer height = 644
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "IntelliReport"
boolean default = true
string picturename = "C:\Users\maha\Desktop\checklist linking.png"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen = 0
parent.triggerevent(close! )
	

end event

type pb_uc from picturebutton within w_logon_screen_14
integer x = 1147
integer y = 168
integer width = 1134
integer height = 644
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Call Log"
string picturename = "C:\Users\maha\Pictures\login buttons\call 3.jpg"
long textcolor = 16777215
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen = 0 
parent.triggerevent(close! )
	

end event

type pb_mr from picturebutton within w_logon_screen_14
integer x = 2299
integer y = 836
integer width = 1134
integer height = 644
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reports"
string picturename = "C:\Users\maha\Pictures\login buttons\report 1.jpg"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen = 5
parent.triggerevent(close! )
	

end event

type pb_ll from picturebutton within w_logon_screen_14
integer x = 9
integer y = 1500
integer width = 1134
integer height = 644
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Groups"
string picturename = "C:\Users\maha\Pictures\login buttons\group 1.jpg"
long textcolor = 16777215
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen = 0
parent.triggerevent(close! )
	

end event

type pb_ml from picturebutton within w_logon_screen_14
integer x = 9
integer y = 836
integer width = 1134
integer height = 644
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Actions"
string picturename = "C:\Users\maha\Pictures\login buttons\actions 1.jpg"
long textcolor = 16777215
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen = 3 
parent.triggerevent(close! )
end event

type pb_ul from picturebutton within w_logon_screen_14
integer y = 168
integer width = 1134
integer height = 644
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Provider"
string picturename = "C:\Users\maha\Pictures\login buttons\steth 2.jpg"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= 1
parent.triggerevent(close! )
	

end event

type p_2 from picture within w_logon_screen_14
integer x = 2336
integer y = 2852
integer width = 983
integer height = 224
boolean enabled = false
string picturename = "isg namelogo.bmp"
end type

type st_program from statictext within w_logon_screen_14
integer y = 8
integer width = 3447
integer height = 136
integer textsize = -22
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 65535
long backcolor = 16711680
string text = "Intellisoft"
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

event constructor;//this.backcolor = INTELLI_PURPLE
//this.textcolor = INTELLI_orange

this.backcolor = INTELLI_orange
this.textcolor = INTELLI_purple





//BEGIN---Add by Evan 11/11/2008
//this.Move(64, 1240)
//this.Resize(1193, 236)
//END---Add by Evan 11/11/2008
end event

type shl_website from statichyperlink within w_logon_screen_14
boolean visible = false
integer x = 3662
integer y = 2280
integer width = 1330
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "HyperLink!"
long backcolor = 67108864
boolean enabled = false
string text = "http://web.contractlogix.com/prod/?[customer_id]"
boolean focusrectangle = false
end type

type st_version from statictext within w_logon_screen_14
integer y = 2172
integer width = 3456
integer height = 180
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 65535
long backcolor = 16711680
string text = "Product Version"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;//this.backcolor = INTELLI_PURPLE
//this.textcolor = INTELLI_orange

this.backcolor = INTELLI_orange
this.textcolor = INTELLI_purple

//Modified by NM 05/15/2012
//this.textcolor = INTElli_black
//this.backcolor = INTELLI_white
//END --- NM 05/15/2012

//BEGIN---Add by Evan 11/11/2008
//this.Move(64, 1240)
//this.Resize(1193, 236)
//END---Add by Evan 11/11/2008
end event

type sle_pwtestdb from singlelineedit within w_logon_screen_14
boolean visible = false
integer x = 3602
integer y = 2168
integer width = 343
integer height = 80
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type sle_pwtest from singlelineedit within w_logon_screen_14
boolean visible = false
integer x = 3607
integer y = 2068
integer width = 343
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "log"
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_logon_screen_14
boolean visible = false
integer x = 3712
integer y = 2392
integer width = 754
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "ODBC Trace"
end type

event clicked;

DISCONNECT USING SQLCA;
IF THIS.CHECKed = TRUE THEN 
		SQLCA.DBMS="TRACE ODBC"
	Else 
		
		SQLCA.DBMS="ODBC"
END IF 


SQLCA.DBParm     = "ConnectString='DSN=" + gs_odbc + ";UID=dba;PWD=sql',DisableBind=1,PBUseProcOwner='Yes',RPCReBind=1,MsgTerse='Yes', " + & 
																	"DelimitIdentifier='Yes',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT ',"+ & 
																	"PBTrimCharColumns='Yes',PBMaxBlobSize = '2147483647' ,PBMaxTextSize = '2147483647'"    
												

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-14 By: Scofield
//$<Reason> Set the connection cache dynamically on Web
if AppeonGetClientType() = 'WEB' then
	SQLCA.DBMS = gs_CacheType
	SQLCA.DBParm = gs_CacheSet
end if
//---------------------------- APPEON END ----------------------------

CONNECT USING SQLCA;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Login", "Inital Login Failed!  Check your ODBC configuration")
	Return -1
END IF

Return 1
end event

type sle_user_id from singlelineedit within w_logon_screen_14
integer x = 1349
integer y = 984
integer width = 736
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;//gs_user_id = This.Text
//DataWindowChild dwchild
//
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( gs_user_id )
//
//
//
//
//
//
end event

type st_1 from statictext within w_logon_screen_14
integer x = 1349
integer y = 908
integer width = 361
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 16711680
boolean enabled = false
string text = "User ID"
boolean focusrectangle = false
end type

event constructor;//this.textcolor = INTELLI_PURPLE
//THIS.backcolor = INTELLI_orange
//this.backcolor = INTELLI_PURPLE
//THIS.textcolor = INTELLI_orange

//BEGIN change font background color and text color for Version 12.1 NM 05/15/12
//this.backcolor = INTELLI_white
//this.textcolor = Intelli_black
//END NM 05/15/2012


end event

type sle_password from singlelineedit within w_logon_screen_14
integer x = 1349
integer y = 1144
integer width = 731
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.text = ""
end event

type st_2 from statictext within w_logon_screen_14
integer x = 1353
integer y = 1076
integer width = 357
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 16711680
boolean enabled = false
string text = "Password"
boolean focusrectangle = false
end type

event constructor;//this.textcolor = INTELLI_PURPLE
//THIS.backcolor = INTELLI_orange
//this.backcolor = INTELLI_PURPLE
//THIS.textcolor = INTELLI_orange

//BEGIN change font background color and text color for Version 12.1 NM 05/15/12
//this.backcolor = INTELLI_white
//this.textcolor = Intelli_black
//END NM 05/15/2012

end event

type cb_ok from u_cb within w_logon_screen_14
integer x = 1838
integer y = 880
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = ansi!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
boolean default = true
end type

event clicked;//maha 112105 major functionality change to connect via DBA.  

String ls_password
integer li_user
integer li_set7
date ld_password
datetime ldt_lock //Start Code Change ---- 08.02.2007 #V7 maha
integer li_days
integer li_res
integer li_lock //Start Code Change ---- 08.02.2007 #V7 maha
time lt_time


//maha 112105 major functionality change connection using dba for all connections

IF IsNull( sle_user_id.Text ) OR sle_user_id.Text = "" THEN
	MessageBox("Required Field", "You must enter a user name." )
	sle_user_id.setfocus()//maha 080300
	Return -1
END IF

IF IsNull( sle_password.Text ) OR sle_password.Text = "" THEN
	MessageBox("Required Field", "You must enter a password." )
	sle_password.setfocus()//maha 080300
	Return -1
END IF

gs_user_id = sle_user_id.Text
gs_password = sle_password.Text
gnv_app.of_setuserid( gs_user_id )
ls_password = sle_password.Text

IF ls_password = "IntelliMasterSE" THEN
	sle_user_id.Visible = True
	st_1.Visible = True
	sle_password.Text = ""
	sle_user_id.Text = ""
	Return 1
END IF

if rb_test.checked = true  then //maha 123102
	gi_test_database = 1
elseif rb_tutor.checked = true then //maha 03085
	gi_test_database = 2
else  //production database
	gi_test_database = 0
end if


if gi_test_database > 0 then
	DISCONNECT USING SQLCA;
	li_res = of_connection()
	if li_res = -1 then
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 06.30.2011
		//$<reason> login failure web deployment bug #2491
		/*
		HALT
		*/
		is_mess = "Cancel"
		w_logon_screen.triggerevent(close! )
		return
		//------------------- APPEON END -------------------
	end if
end if


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11/19/2007 By: Ken.Guo
//$<reason> LDAP user need auto login
//li_res = of_user_login( il_attempts)
If gb_autologin = True Then
	//Use LDAP user login
	gs_user_id = sle_user_id.text
	li_res = 1
Else 
	//Use intellicred user login
	li_res = of_user_login( il_attempts)
End If
//---------------------------- APPEON END ----------------------------

//Start Code Change ---- 08.02.2007 #V7 maha added changes for login locking
IF li_res = -1 THEN
	of_log_connection("FAIL")
	il_attempts ++
	IF il_attempts = 3  and ii_lock_num = 0   THEN
		messagebox("Login Error","You have reached the maximum number of attempts.  Closing Program")
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 06.30.2011
		//$<reason> login failure web deployment bug #2491
		/*
		HALT
		*/
		is_mess = "Cancel"
		w_logon_screen.triggerevent(close! )
		return
		//------------------- APPEON END -------------------
	elseif il_attempts =  ii_lock_num then //08.02.2007 #V7 maha
		of_log_connection("LOCK")
		messagebox("Login Error","You have reached the maximum number of attempts and will be locked out.  Closing Program")
		select lockout_min into :li_lock from security_settings;
		lt_time = now()
		lt_time = RelativeTime ( lt_time, li_lock  * 60 )
		ldt_lock = datetime(today(),lt_time)
		//Start Code Change ----03.20.2013 #V12 maha - added fail_count
//		update security_users set lock_until = :ldt_lock, fail_count = fail_count + il_attempts where user_id = :gs_user_id;
//		update security_users set lock_until = :ldt_lock, fail_count = :il_attempts where user_id = :gs_user_id;//long.zhang 04.12.2013
		update security_users set lock_until = :ldt_lock where user_id = :gs_user_id;	//long.zhang 05.02.2013 - fail count is incremented in of_log_failure

		commit using sqlca;
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 06.30.2011
		//$<reason> login failure web deployment bug #2491
		/*
		HALT
		*/
		is_mess = "Cancel"
		w_logon_screen.triggerevent(close! )
		return
		//------------------- APPEON END -------------------
	ELSE  
//		if gi_test_database > 0 then //maha removed 8.2.07 should not connect to prod database if test fails
//			of_logon() //reconnect to the production database
//		end if
		Return li_res //Change from "Return" to "Return li_res" - Web based scheduler - alfee 01.27.2011
	END IF
elseif li_res = -5 then 
	messagebox("Login Error","This login is currently locked out.  Closing Program")
	of_log_connection("LOCK")
	HALT
//End Code Change---08.02.2007		
elseif li_res = -3 then //Start Code Change ----04.06.2009 #V92 maha - added ameripath custom
	messagebox("Login Error"," The user '" + gs_user_id + "' is an inactive login and cannot be used to connect to the program.  Contact your system administrator to reset.")
	of_log_connection("INACTIVE")
	HALT
elseif li_res = -6 then 
	messagebox("Login Error","This login has more than 25 consecutive failed attempts.  For security purposes, this user id is being set to inactive.  Closing Program")
	of_log_connection("INACTIVE")
	//Start Code Change ----03.25.2013 #V12 maha
	update security_users set active_status = 0 where user_id = :gs_user_id;
	commit using sqlca;
	//End Code Change ----03.25.2013
	HALT
else //login successful
	of_log_connection("PASS")
	//-----Begin Added by Alfee 01.27.2011 ----------------------------
	//Web based scheduler - Keep the login info for the first time
	if AppeonGetClientType() = "WEB" and (gb_IsAutoExpImp or gb_AutoSchedule) and upper(gs_user_id) <> "MASTER" and Not gb_autologin then 
		if IsNull(is_sched_username) or IsNull(is_sched_password) or Len(Trim(is_sched_username)) < 1 or Len(Trim(is_sched_password)) < 1 then	
			if MessageBox("Question", "Do you want the system to remember the login info for the IntelliSoft Scheduler program?", Question!, YesNo!, 1) = 1 then
				gnv_appeondll.of_registryset ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Username", regstring!, gs_user_id)
				gnv_appeondll.of_registryset ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Password", regstring!, in_encrypt.of_encrypt(ls_password))
			end if				
		end if
	end if
	//-----End Added ------------------------------------------------------
end if
//Start code changes - 1.4.2007 Henry. move the scrips to application open event
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.16.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Integrate the SQL statements that retrieve data from the database into Appeon Queue labels to reudce 
//$<modification> client-server interactions for performance tuning.
gnv_appeondb.of_startqueue()
gnv_data.of_retrieve('icred_settings') //cache data for icred_settings table
gnv_data.of_retrieve('security_users') //cache data for security_users table
gnv_data.of_retrieve('ids')				//cache data for ids table
gnv_data.of_retrieve('sys_tables')				//cache data for sys_tables table
gnv_data.of_retrieve('code_lookup')				//cache data for code_lookup table
gnv_data.of_retrieve('ctx_notification')				//cache data for ctx_notification table
gnv_data.of_retrieve('sys_fields')				//cache data for sys_fields and sys_tables table
gnv_data.of_retrieve('facility')				//cache data for facility table
gnv_data.of_retrieve('data_view_screen')				//cache data for data_view_screen table
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Jack (Inova)
//$<reason> Queue Images for Scanning from Data Entry.
gnv_data.of_retrieve('image_type')				//cache data for image_type table	
//---------------------------- APPEON END ----------------------------

gnv_data.of_retrieve('code_lookup_2') //Added 11.30.2006 henry
	
//Added for work flow. 6/11/2006 Henry
gnv_data.of_retrieve('wf_workflow')	
gnv_data.of_retrieve('wf_action_types')	
gnv_data.of_retrieve('wf_action_status')	
gnv_data.of_retrieve('wf_trigger_param_data_comparison')	
gnv_data.of_retrieve('wf_trigger_param_action_status')	
//End added for work flow.
	
//$<add> 10.12.2006 By: LeiWei
IF appeongetclienttype() = 'WEB' Then
	select image_flag into :gs_image_flag from security_users where user_id = :gs_user_id;
END IF
//$<add> 10.12.2006 By: LeiWei

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------
*/
//End code changes - 1.4.2007 Henry
is_mess = gs_user_id

//Start Code Change ----03.12.2013 #V14 maha - hide buttons
of_buttons_visible( true)
//w_logon_screen.triggerevent(close!)
//Start Code Change ----03.12.2013

Return li_res //Web based scheduler - alfee 01.27.2011

end event

type cb_22 from u_cb within w_logon_screen_14
integer x = 1728
integer y = 1236
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = ansi!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string pointer = "HyperLink!"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;is_mess = "Cancel"
parent.triggerevent(close! )
//CloseWithReturn( Parent, is_mess )
end event

event constructor;call super::constructor;//this.  backcolor =  rgb(171, 130, 255)
end event

type rb_test from radiobutton within w_logon_screen_14
integer x = 1239
integer y = 1400
integer width = 1029
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 16711680
string text = "Connect to Test Database "
end type

event constructor;//this.textcolor = INTELLI_PURPLE
//THIS.backcolor = INTELLI_orange
this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_orange
end event

type rb_tutor from radiobutton within w_logon_screen_14
integer x = 3767
integer y = 1644
integer width = 1029
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 16777215
string text = "Connect to Tutorial Database "
end type

event constructor;//this.textcolor = INTELLI_PURPLE
//THIS.backcolor = INTELLI_orange
this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_orange
end event

type rb_prod from radiobutton within w_logon_screen_14
integer x = 1234
integer y = 1332
integer width = 1029
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 16711680
string text = "Connect to Production Database "
boolean checked = true
end type

event constructor;this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_orange
end event

type p_1 from picture within w_logon_screen_14
boolean visible = false
integer x = 1330
integer y = 2720
integer width = 859
integer height = 384
string picturename = "isg gif graphictop.gif"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_logon_screen_14
long linecolor = 8388608
integer linethickness = 4
long fillcolor = 8388608
integer x = 4174
integer y = 112
integer width = 320
integer height = 168
end type

type p_logo from picture within w_logon_screen_14
integer x = 9
integer y = 144
integer width = 3429
integer height = 2144
boolean enabled = false
string picturename = "Splash-v12.png"
end type

