$PBExportHeader$w_logon_screen_15.srw
forward
global type w_logon_screen_15 from w_response
end type
type st_welcome from statictext within w_logon_screen_15
end type
type p_gear from picture within w_logon_screen_15
end type
type st_isg from statictext within w_logon_screen_15
end type
type cb_cancel_button from commandbutton within w_logon_screen_15
end type
type cb_1 from commandbutton within w_logon_screen_15
end type
type pb_5 from picturebutton within w_logon_screen_15
end type
type pb_9 from picturebutton within w_logon_screen_15
end type
type pb_3 from picturebutton within w_logon_screen_15
end type
type pb_8 from picturebutton within w_logon_screen_15
end type
type pb_2 from picturebutton within w_logon_screen_15
end type
type pb_6 from picturebutton within w_logon_screen_15
end type
type pb_7 from picturebutton within w_logon_screen_15
end type
type pb_4 from picturebutton within w_logon_screen_15
end type
type pb_1 from picturebutton within w_logon_screen_15
end type
type p_2 from picture within w_logon_screen_15
end type
type shl_website from statichyperlink within w_logon_screen_15
end type
type sle_pwtestdb from singlelineedit within w_logon_screen_15
end type
type sle_pwtest from singlelineedit within w_logon_screen_15
end type
type cbx_1 from checkbox within w_logon_screen_15
end type
type rb_test from radiobutton within w_logon_screen_15
end type
type rb_tutor from radiobutton within w_logon_screen_15
end type
type rb_prod from radiobutton within w_logon_screen_15
end type
type p_1 from picture within w_logon_screen_15
end type
type r_1 from rectangle within w_logon_screen_15
end type
type st_iss from statictext within w_logon_screen_15
end type
type p_logo from picture within w_logon_screen_15
end type
type cb_support from commandbutton within w_logon_screen_15
end type
type st_forgot_pw from statictext within w_logon_screen_15
end type
type dw_image from datawindow within w_logon_screen_15
end type
type st_id from statictext within w_logon_screen_15
end type
type sle_user_id from singlelineedit within w_logon_screen_15
end type
type st_pw from statictext within w_logon_screen_15
end type
type sle_password from singlelineedit within w_logon_screen_15
end type
type cb_ok from u_cb within w_logon_screen_15
end type
type cb_close from u_cb within w_logon_screen_15
end type
type st_program from statictext within w_logon_screen_15
end type
type st_version from statictext within w_logon_screen_15
end type
type cbx_remember from checkbox within w_logon_screen_15
end type
end forward

global type w_logon_screen_15 from w_response
integer x = 1184
integer y = 716
integer width = 4517
integer height = 2668
boolean controlmenu = false
long backcolor = 8388608
st_welcome st_welcome
p_gear p_gear
st_isg st_isg
cb_cancel_button cb_cancel_button
cb_1 cb_1
pb_5 pb_5
pb_9 pb_9
pb_3 pb_3
pb_8 pb_8
pb_2 pb_2
pb_6 pb_6
pb_7 pb_7
pb_4 pb_4
pb_1 pb_1
p_2 p_2
shl_website shl_website
sle_pwtestdb sle_pwtestdb
sle_pwtest sle_pwtest
cbx_1 cbx_1
rb_test rb_test
rb_tutor rb_tutor
rb_prod rb_prod
p_1 p_1
r_1 r_1
st_iss st_iss
p_logo p_logo
cb_support cb_support
st_forgot_pw st_forgot_pw
dw_image dw_image
st_id st_id
sle_user_id sle_user_id
st_pw st_pw
sle_password sle_password
cb_ok cb_ok
cb_close cb_close
st_program st_program
st_version st_version
cbx_remember cbx_remember
end type
global w_logon_screen_15 w_logon_screen_15

type variables
Integer il_attempts  //Start Code Change ---- 08.02.2007 #V7 maha
integer ii_lock_num
integer ii_button_set[]  //maha 05.21.2013
integer ii_set_9, ii_set_ireport, ii_set_iapps, ii_set_iauto, ii_set_import, ii_set_call_log, ii_set_cont
Integer ii_set_priv	//long.zhang 11.22.2013 BugL102904 
integer ii_set_setup  //maha 08.11.2014
integer ii_opt_2  //maha 12.10.2015
integer ii_forgot_method = 0  //maha 12.10.2015
integer ii_min_quest  //maha 12.10.2015
String is_version
string is_mess
string is_sched_username, is_sched_password //Web based scheduler - alfee 01.27.2011

//SSO User Login  -- Add by Jimmy 20140604 ,copied from CLX,by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)
string is_use_saml = "0"
string is_only_saml_user = "0" 

boolean ib_dev = false  //maha 07.14.2015 
boolean ib_user_quest = false  //maha 12.10.2015

//-------------------------------- RP 1.26.2016 -------------------------------------
constant long COLOR_BACKGROUND =     RGB(41 ,38, 109)        // rgb(25, 48, 72) slate blue
constant long COLOR_TEXT = rgb(172, 172, 172)

//constant long INTELLI_PURPLE = RGB(80 ,0, 170) v92
//constant long INTELLI_PURPLE = RGB(35 ,0, 105)
constant long INTELLI_PURPLE = RGB(41 ,38, 109)
//constant long INTELLI_PURPLE = RGB(0 ,0, 128)
//constant long INTELLI_PURPLE = RGB(4 ,0, 93)
//constant long INTELLI_PURPLE = RGB(32 ,0, 128)
constant long INTELLI_ORANGE = rgb(255,153,0)
constant long INTELLI_WHITE = rgb(255, 255, 255)
constant long INTELLI_GREY = rgb(175, 175, 175)
constant long INTELLI_black = rgb(0, 0, 0)
constant long INTELLI_Purple_12 = rgb(226,228,243)
//constant long Text_Color = rgb(255,153,0)  //maha 05.21.2013
constant long Text_Color = rgb(41 ,38, 109)  //maha 08.20.2013
//constant long Text_Color = 0

n_cst_encrypt in_encrypt

//Added By Ken.Guo 2016-06-16//Copied from CLX by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)
String is_user_id
n_cst_ad inv_ad  
Boolean ib_ad_autologin, ib_using_ad
n_cst_systeminfo inv_systeminfo
end variables

forward prototypes
public function integer of_logon ()
public function integer of_change_password (string as_from)
public function integer of_connection ()
public function integer of_user_login (integer ai_attempt)
public function integer of_log_connection (string as_pass)
public function string of_get_autologinname ()
public function integer of_click_ok ()
public function integer of_log_failure ()
public function integer of_button_color ()
public function integer of_button_settings ()
public function integer of_buttons_visible (boolean ab_buttons_visible)
public function integer of_button_mod_sec (integer ai_type)
public function integer of_welcome ()
public function integer of_lockout_user ()
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
string	ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
Boolean	lb_Relogin //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
String ls_ad_server, ls_ad_user, ls_ad_password, ls_ad_error, ls_userid //Added by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)
String ls_ad_pc_domainname,ls_domainuser, ls_shortdomainname  //Added by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)
Integer li_ad_save_pwd, li_ad_status, li_active_status, li_count //Added by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)

ls_user = sle_user_id.text
ls_password = sle_password.text
ls_passorg = ls_password
////ls_password = in_encrypt.of_encrypt(ls_password)
////sle_pwtest.text = ls_password

//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
lb_ReLogin = gf_Get_ReLogin_Status( )
If  lb_ReLogin Then  ls_OriginalUser = 	gs_user_id//added by gavins 20130515
//---------End Added ------------------------------------------------------

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

//Start Code Change ----12.09.2013 #V14 maha - set global user to security user case value
//gs_user_id = ls_user
gs_user_id = ls_user_test
//End Code Change ----12.09.2013

//set defaults for nulls
if isnull(ls_salt) then ls_salt = ""
if isnull(li_failed_count) then li_failed_count = 0

ii_opt_2 = li_opt2   //Start Code Change ----12.10.2015 #V15 maha

if isnull(ls_passdb) or ls_passdb = "" then
	ls_type = "NONE" //no pw in db
elseif mida(ls_passdb, 1,1) = "#" then
	ls_type = "E1"  //encrypt 1
elseif mida(ls_passdb, 1,1) = "$" then //Start Code Change ----03.30.2013 #V12 maha
	ls_type = "E2"	//encrypt 2
elseif mida(ls_passdb, 1,1) = "@" then //Start Code Change ----03.02.2016 #V15 maha
	ls_type = "E3"	//encrypt 3
elseif mida(ls_passdb, 1,1) = "&" then //Start Code Change ----08.15.2016 #V153 maha - added here but coded for elsewhere
	ls_type = "ET"	//temporary pw
else
	ls_type = "NE" //not encrypted
end if

//lockout check
if upper(ls_user) = "MASTER" then
	//skip test
else
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 11.15.2016
	//<$>reason:Use AD login, Copied and modified from CLX, for v15.3 AD Authentication
	If ib_ad_autologin Then
		gs_user_id = is_user_id
		return 1 
	End If
	ls_ad_error = ''
	gb_ad_login = False
	If gnv_user_option.of_get_option_value('allow_ad_function') = '1'  Then
		ls_ad_pc_domainname = inv_systeminfo.of_get_domaindnsname( )
		ls_shortdomainname = inv_systeminfo.of_get_domainname( )

		If lastpos(ls_user,'\') > 0 Then
			ls_domainuser = Mid(ls_user, lastpos(ls_user,'\') + 1 , Len(ls_user))
		Else
			ls_domainuser = ls_user
		End If		
		select Top 1 user_id, active_status, ad_server, ad_user, ad_password, ad_save_pwd, ad_status  
		into :ls_userid, :li_active_status,:ls_ad_server, :ls_ad_user, :ls_ad_password,:li_ad_save_pwd, :li_ad_status from security_users 
		where ad_user = :ls_domainuser or ad_user = :ls_user or ad_user = :ls_ad_pc_domainname + '\' + :ls_domainuser or ad_user = :ls_shortdomainname + '\' + :ls_domainuser ;
		If sqlca.sqlcode = 0 and li_ad_status = 1  and (Not(li_active_status = 0) ) Then
			If inv_ad.of_connect_ad( ls_ad_pc_domainname, ls_ad_user, ls_passorg, ref ls_ad_error, True, True) = 0 Then
				gs_user_id = ls_userid
				//save pwd
				If cbx_remember.checked Then
					ls_password = in_encrypt.of_encrypt(ls_password) //Encrypt
					Update security_users set  ad_password = :ls_password, ad_save_pwd = 1 where  user_id = :ls_userid ;
				ElseIf cbx_remember.visible Then
					Update security_users set  ad_save_pwd = 0 where user_id = :ls_userid ;
				End If
				ib_using_ad = True
				gb_ad_login = True
				Return 1 
			Else
				Messagebox('Active Directory Login Error','Failed to login with Active Directory account.~r~n'  + ls_ad_error) 
				Return -1
			End If
		Else
			If  sqlca.sqlcode = 0 Then
				If li_ad_status = 0 or isnull(li_ad_status) Then
					//check the user id whether exists.
					Select count(1) into :li_count from security_users where user_id = :ls_user;
					If li_count > 0 Then
						//Continue login with Account login
					Else
						Messagebox('Active Directory Login Error','Failed to login with Active Directory account. ~r~nThe account "' + ls_domainuser + '" is disabled in the AD User Painter.')
						Return -1
					End If
				End If
				If  li_active_status = 1  Then
					Messagebox('Active Directory Login Error','Failed to login with Active Directory account. ~r~nThe mapped user  "' + ls_userid + '" is inactive in the User Painter. ')
					Return -1					
				End If
			End If
		End If
	End If
	//------------------- APPEON END -------------------
	
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
			messagebox("Login Error","Invalid User ID or password.")//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
		else
			messagebox("Login Error","Invalid User ID '" + ls_user + "'.  Please check your spelling, or the user id is not setup in the system.")//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
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
			messagebox("Login Error","Invalid password for user ID MASTER.  This is not today's password")//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
			If  lb_ReLogin Then gs_user_id = ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
			return -1
		end if
	end if
else 
//ALL OTHER USERS
	if ls_type = "NONE" then
		li_ret = of_change_password("login")
		if li_ret = -1 then
			of_log_failure()
			If  lb_ReLogin Then gs_user_id = ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
			return -1
		end if
	elseif ls_type = "NE" then //No Encryption (new or reset password)
		if  ls_passdb = ls_passorg then
			li_ret = of_change_password("login")
			if li_ret = -1 then
				of_log_failure()
				If  lb_ReLogin Then gs_user_id = ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
				return -1
			end if
		else
			messagebox("Login Error","Invalid password for User ID '" + ls_user + "'.  Please check your spelling.") //(Appeon)Stephen 03.17.2016 - V15.1 Applause Cycle 4 Bug # 5048 - No password warning when new users types password incorrectly
			of_log_failure()
			If  lb_ReLogin Then gs_user_id = ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
			return -1
		end if
	elseif ls_type = "E1" then  //Encryption 1
		ls_password = in_encrypt.of_encrypt(ls_password)
		if ls_passdb <> ls_password then  //comparing encrypted  pw as entered with value in datatabase
			if li_opt2 = 1 then
				messagebox("Login Error","Invalid User ID or password.")//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
			else
				messagebox("Login Error","Invalid password for User ID '" + ls_user + "'.  Please check your spelling.")//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
			end if
			of_log_failure()
			If  lb_ReLogin Then gs_user_id = ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
			return -1
		end if
	elseif ls_type = "E2" then  //Encryption 2   //Start Code Change ----03.30.2013 #V12 maha
		if ls_salt = "" then //if encrypted but there is no salt value
			li_ret = of_change_password("login")
			if li_ret = -1 then
				of_log_failure()
				If  lb_ReLogin Then gs_user_id = ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
				return -1
			end if
		else
			ls_password = in_encrypt.of_encrypt2(ls_password, ls_salt)
			if ls_passdb <> ls_password then  //comparing encrypted  pw as entered with value in datatabase
				if li_opt2 = 1 then 
					messagebox("Login Error","Invalid user ID or password.")//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
				else
					messagebox("Login Error","Invalid password for User ID '" + ls_user + "'.  Please check your spelling.")//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
				end if
				of_log_failure()
				If  lb_ReLogin Then gs_user_id = ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
				return -1
			end if
		end if	
	elseif ls_type = "E3" then  //Encryption 3   //Start Code Change ----03.02.2016 #V15 maha
		if ls_salt = "" then //if encrypted but there is no salt value
			li_ret = of_change_password("login")
			if li_ret = -1 then
				of_log_failure()
				If  lb_ReLogin Then gs_user_id = ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
				return -1
			end if
		else
			ls_password = in_encrypt.of_encrypt3(ls_password, ls_salt)
			if ls_passdb <> ls_password then  //comparing encrypted  pw as entered with value in datatabase
				if li_opt2 = 1 then 
					messagebox("Login Error","Invalid user ID or password.")//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
				else
					messagebox("Login Error","Invalid password for User ID '" + ls_user + "'.  Please check your spelling.")//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
				end if
				of_log_failure()
				If  lb_ReLogin Then gs_user_id = ls_OriginalUser //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
				return -1
			end if
		end if
	else
		messagebox("Login Error","Unable to check user and password combination.  Contact ISG support")
	end if
	
	//Start Code Change ----03.06.2009 #V92 maha - added trap for null role
	if isnull(li_role) or li_role = 0 then
		messagebox("Login Error","User name '" + ls_user + "' has no IntelliSoft role and may have been setup for Webview only.  This User id must be assigned a role in the User Administration in order to log in to this program.")
		return -1
	else  //Start Code Change ----06.14.2016 #V152 maha - set new variable
		gi_role_id = li_role
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
Long ll_cnt  //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
integer li_active_status  //(Appeon)Stephen 01.12.2017 - Inactive users able to access live database
n_cst_systeminfo lnv_systeminfo
gb_autologin = False

//Case Appeon Security User(LDAP User)
ls_LDAPUser = AppeonGetAppeonUserName()

If LenA(ls_LDAPUser) > 0 Then
	//Get login user ID for IC by LDAP User
	//---------Begin Modified by (Appeon)Stephen 01.12.2017 for Inactive users able to access live database--------
	//Select user_id Into :ls_user_id From security_users Where upper(ic_ldap_user) = upper(:ls_LDAPuser);
	Select user_id, active_status Into :ls_user_id, :li_active_status From security_users Where upper(ic_ldap_user) = upper(:ls_LDAPuser);
	//---------End Modfiied ------------------------------------------------------
	
	If ls_user_id = '' or isnull(ls_user_id) or li_active_status = 0 or isnull(li_active_status) Then
		//---------Begin Modified by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
		//MessageBox("Login Error","The LDAP user '"+ls_LDAPUser+"' does not map with any IntelliCred user ID in the User Painter.")
		//Halt
		
		//Added By Ken.Guo 06/03/2013. map user id
		Select Count(1) Into :ll_cnt From security_users Where upper(user_id) = upper(:ls_LDAPuser);
		If ll_cnt = 0 or isnull(ll_cnt) Then
			//MessageBox("Login Error","The LDAP user '"+ls_LDAPUser+"' does not map with any IntelliCred user ID in the User Painter.")  //(Appeon)Harry 05.28.2014 - V142 ISG-CLX modify "Contractlogix" to "IntelliCred"
			MessageBox("Login Error","The domain user '"+ls_LDAPUser+"' does not map with any IntelliCred user ID in the User Painter.")  //alfee 05.10.2016
			Halt
		Else
			ls_user_id = ls_LDAPuser
		End If
		//---------End Modfiied ------------------------------------------------------
		
		//---------Begin Added by (Appeon)Stephen 01.12.2017 for Inactive users able to access live database--------
		if li_active_status = 0 or isnull(li_active_status) then
			messagebox("Login Error"," The LDAP user '" + ls_LDAPuser + "' is an inactive login and cannot be used to connect to the program.  Contact your system administrator to reset.")
			Halt Close
		end if
		//---------End Added ------------------------------------------------------
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
	//---------Begin Modified by (Appeon)Stephen 01.19.2017 for Inactive users able to access live database--------
	//Select user_id Into :ls_user_id From security_users Where upper(ic_ldap_user) = upper(:ls_os_username) and upper(domain_name) = upper(:ls_domainname);	
	Select user_id, active_status Into :ls_user_id, :li_active_status From security_users Where upper(ic_ldap_user) = upper(:ls_os_username) and upper(domain_name) = upper(:ls_domainname);
	//---------End Modfiied ------------------------------------------------------
	If ls_user_id = '' or isnull(ls_user_id) or li_active_status <>1 or isnull(li_active_status) Then
		//---------Begin Modified by (Appeon)Stephen 01.19.2017 for Inactive users able to access live database--------
		//Select user_id Into :ls_user_id From security_users Where upper(ic_ldap_user) = upper(:ls_os_username) and upper(domain_name) = upper(:ls_domainname) + '.COM';
		Select user_id, active_status Into :ls_user_id, :li_active_status From security_users Where upper(ic_ldap_user) = upper(:ls_os_username) and upper(domain_name) = upper(:ls_domainname) + '.COM';
		//---------End Modfiied ------------------------------------------------------
		If ls_user_id = '' or isnull(ls_user_id) or li_active_status <>1 or isnull(li_active_status) Then
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

public function integer of_click_ok ();//@@@ THIS FUNCTION IS NOT USED AND DOES NOT HAVE TO BE MAINTAINED @@@

////Start Code Change ----08.20.2012 #V12 maha - new function
//String ls_password
//integer li_user
//integer li_set7
//date ld_password
//datetime ldt_lock //Start Code Change ---- 08.02.2007 #V7 maha
//integer li_days
//integer li_res
//integer li_lock //Start Code Change ---- 08.02.2007 #V7 maha
//time lt_time
//
//
////maha 112105 major functionality change connection using dba for all connections
//
//IF IsNull( sle_user_id.Text ) OR sle_user_id.Text = "" THEN
//	MessageBox("Required Field", "You must enter a User ID." )//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
//	sle_user_id.setfocus()//maha 080300
//	Return -1
//END IF
//
//IF IsNull( sle_password.Text ) OR sle_password.Text = "" THEN
//	MessageBox("Required Field", "You must enter a password." )
//	sle_password.setfocus()//maha 080300
//	Return -1
//END IF
//
//gs_user_id = sle_user_id.Text
//gs_password = sle_password.Text
//gnv_app.of_setuserid( gs_user_id )
//ls_password = sle_password.Text
//
//IF ls_password = "IntelliMasterSE" THEN
//	sle_user_id.Visible = True
//	st_id.Visible = True
//	sle_password.Text = ""
//	sle_user_id.Text = ""
//	Return 1
//END IF
//
//if rb_test.checked = true  then //maha 123102
//	gi_test_database = 1
//elseif rb_tutor.checked = true then //maha 03085
//	gi_test_database = 2
//else  //production database
//	gi_test_database = 0
//end if
//
//
//if gi_test_database > 0 then
//	DISCONNECT USING SQLCA;
//	li_res = of_connection()
//	if li_res = -1 then
//		//------------------- APPEON BEGIN -------------------
//		//$<modify> Stephen 06.30.2011
//		//$<reason> login failure web deployment bug #2491
//		/*
//		HALT
//		*/
//		is_mess = "Cancel"
//		w_logon_screen.triggerevent(close! )
//		return -1
//		//------------------- APPEON END -------------------
//	end if
//end if
//
//
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 11/19/2007 By: Ken.Guo
////$<reason> LDAP user need auto login
////li_res = of_user_login( il_attempts)
//If gb_autologin = True Then
//	//Use LDAP user login
//	gs_user_id = sle_user_id.text
//	li_res = 1
//Else 
//	//Use intellicred user login
//	li_res = of_user_login( il_attempts)
//End If
////---------------------------- APPEON END ----------------------------
//
////Start Code Change ---- 08.02.2007 #V7 maha added changes for login locking
//IF li_res = -1 THEN
//	of_log_connection("FAIL")
//	il_attempts ++
//	IF il_attempts = 3  and ii_lock_num = 0   THEN
//		messagebox("Login Error","You have reached the maximum number of attempts(3).  Closing Program") //'(3)' Added by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4881 - Login Error received when max # of attempts is reached doesn't specify the actual # of attempts)
//		//------------------- APPEON BEGIN -------------------
//		//$<modify> Stephen 06.30.2011
//		//$<reason> login failure web deployment bug #2491
//		/*
//		HALT
//		*/
//		is_mess = "Cancel"
//		w_logon_screen.triggerevent(close! )
//		return -1
//		//------------------- APPEON END -------------------
//	elseif il_attempts =  ii_lock_num then //08.02.2007 #V7 maha
//		of_log_connection("LOCK")
//		messagebox("Login Error","You have reached the maximum number of attempts(" + String(ii_lock_num) + ") and will be locked out.  Closing Program")//'ii_lock_num' Added by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4881 - Login Error received when max # of attempts is reached doesn't specify the actual # of attempts)
//		select lockout_min into :li_lock from security_settings;
//		lt_time = now()
//		lt_time = RelativeTime ( lt_time, li_lock  * 60 )
//		ldt_lock = datetime(today(),lt_time)
//		update security_users set lock_until = :ldt_lock where user_id = :gs_user_id;
//		commit using sqlca;
//		//------------------- APPEON BEGIN -------------------
//		//$<modify> Stephen 06.30.2011
//		//$<reason> login failure web deployment bug #2491
//		/*
//		HALT
//		*/
//		is_mess = "Cancel"
//		w_logon_screen.triggerevent(close! )
//		return -1
//		//------------------- APPEON END -------------------
//	ELSE  
////		if gi_test_database > 0 then //maha removed 8.2.07 should not connect to prod database if test fails
////			of_logon() //reconnect to the production database
////		end if
//		Return li_res //Change from "Return" to "Return li_res" - Web based scheduler - alfee 01.27.2011
//	END IF
//elseif li_res = -5 then 
//	messagebox("Login Error","This login is currently locked out.  Closing Program")
//	of_log_connection("LOCK")
//	HALT
////End Code Change---08.02.2007		
//elseif li_res = -3 then //Start Code Change ----04.06.2009 #V92 maha - added ameripath custom
//	messagebox("Login Error"," The user '" + gs_user_id + "' is an inactive login and cannot be used to connect to the program.  Contact your system administrator to reset.")
//	of_log_connection("INACTIVE")
//	HALT
//else //login successful
//	of_log_connection("PASS")
//	//-----Begin Added by Alfee 01.27.2011 ----------------------------
//	//Web based scheduler - Keep the login info for the first time
//	if AppeonGetClientType() = "WEB" and (gb_IsAutoExpImp or gb_AutoSchedule) and upper(gs_user_id) <> "MASTER" and Not gb_autologin then 
//		if IsNull(is_sched_username) or IsNull(is_sched_password) or Len(Trim(is_sched_username)) < 1 or Len(Trim(is_sched_password)) < 1 then	
//			if MessageBox("Question", "Do you want the system to remember the login info for the IntelliSoft Scheduler program?", Question!, YesNo!, 1) = 1 then
//				gnv_appeondll.of_registryset ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Username", regstring!, gs_user_id)
//				gnv_appeondll.of_registryset ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Password", regstring!, in_encrypt.of_encrypt(ls_password))
//			end if				
//		end if
//	end if
//	//-----End Added ------------------------------------------------------
//end if
//
//is_mess = gs_user_id
////w_logon_screen.triggerevent(close!)
//
//Return li_res //Web based scheduler - alfee 01.27.2011
//

return 1
end function

public function integer of_log_failure ();//Start Code Change ----03.30.2013 #V12 maha
update security_users set fail_count = fail_count + 1 where user_id = :gs_user_id;
commit using sqlca;

return 1
end function

public function integer of_button_color ();pb_1.textcolor = text_color
pb_2.textcolor = text_color
pb_3.textcolor = text_color
pb_4.textcolor = text_color
pb_5.textcolor = text_color
pb_6.textcolor = text_color
pb_7.textcolor = text_color
pb_8.textcolor = text_color
pb_9.textcolor = text_color



return 1
end function

public function integer of_button_settings ();//Start Code Change ----05.21.2013 #V14 maha - new
integer bs1,bs2,bs3,bs4,bs5,bs6,bs7,bs8,bs9
integer li_find, b
integer li_temp, ll_role, li_ro
integer li_go = 0 //maha 11.14.2013
string ls_desc
string ls_pict
datastore lds_buttons
picturebutton ibt_set

//get template
select security_roles.button_temp, security_users.role_id, security_users.readonly into :li_temp, :ll_role, :li_ro
from security_users,security_roles 
where security_users.role_id = security_roles.role_id
and security_users.user_id = :gs_user_id ;

if isnull(li_temp) then return -1

//get settings
select button_1  , button_2,  button_3 ,button_4,button_5,button_6,button_7,button_8,button_9 
into :bs1,:bs2,:bs3,:bs4,:bs5,:bs6,:bs7,:bs8,:bs9 from button_template where temp_id = :li_temp; 

select set_9, set_ireport, set_iapps, set_iauto, set_import, set_call_log, set_cont,set_priv into 
:ii_set_9, :ii_set_ireport, :ii_set_iapps, :ii_set_iauto, :ii_set_import, :ii_set_call_log,:ii_set_cont,:ii_set_priv  from  icred_settings;//added set_priv by long.zhang 11.22.2013 BugL102904 

//Start Code Change ----08.11.2014 #V14.2 maha
select value_id into :ii_set_setup from security_roles_rights where role_id = :ll_role and action_id = 7767;


if isnull(bs1) then return -1

ii_button_set[1] = bs1
ii_button_set[2] = bs2
ii_button_set[3] = bs3
ii_button_set[4] = bs4
ii_button_set[5] = bs5
ii_button_set[6] = bs6
ii_button_set[7] = bs7
ii_button_set[8] = bs8
ii_button_set[9] = bs9

lds_buttons = create datastore
lds_buttons.dataobject = "d_button_types"
lds_buttons.settransobject(sqlca)
b = lds_buttons.retrieve(ll_role)
if b < 1 then
	destroy lds_buttons
	return -1
end if

//Start Code Change ----11.14.2013 #V14 maha - trap for all none
for b = 1 to upperbound( ii_button_set[])
	if ii_button_set[b] <> 0 then
		li_go = 1
		exit
	end if
next

if li_go = 0 then
	destroy lds_buttons
	return -1
end if
//End Code Change ----11.14.2013

for b = 1 to 9
	
	choose case b
		case 1
			ibt_set = pb_1
		case 2
			ibt_set = pb_2
		case 3
			ibt_set = pb_3
		case 4
			ibt_set = pb_4
		Case 5
			ibt_set = pb_5
		case 6
			ibt_set = pb_6
		case 7
			ibt_set = pb_7
		case 8
			ibt_set = pb_8
		case 9
			ibt_set = pb_9
	end choose

	li_find = lds_buttons.find("button_type = " + string(ii_button_set[b]) , 1, 20 )
	if li_find > 0 then
		choose case  ii_button_set[b]
			case 0
				ibt_set.visible = false
			case 17
				ls_desc = lds_buttons.getitemstring(li_find, "description")
				ls_pict = lds_buttons.getitemstring(li_find, "pict_name")
				ibt_set.text = ls_desc
				//ibt_set.picturename = gs_dir_path + "intellicred\button pict\" + ls_pict  //Start Code Change ----09.11.2013 #V14 maha - added intellicred to path
				ibt_set.picturename = "button pict\" + ls_pict   //Start Code Change ----10.23.2013 #V14 maha - removed intellicred from path
				ibt_set.visible = true	
			case 14
				if li_ro = 1 then
					ibt_set.visible = false
				else
					ls_desc = lds_buttons.getitemstring(li_find, "description")
					ls_pict = lds_buttons.getitemstring(li_find, "pict_name")
					ibt_set.text = ls_desc
					ibt_set.picturename = "button pict\" + ls_pict     //Start Code Change ----10.23.2013 #V14 maha - removed intellicred from path
					ibt_set.visible = true	
				end if
			case else
				if lds_buttons.getitemnumber(li_find, "value_id") = 0 then //check security
					ibt_set.visible = false	
				else
					
					ls_desc = lds_buttons.getitemstring(li_find, "description")
					ls_pict = lds_buttons.getitemstring(li_find, "pict_name")
					ibt_set.text = ls_desc
					ibt_set.picturename = "button pict\" + ls_pict   //Start Code Change ----10.23.2013 #V14 maha - removed intellicred from path
					ibt_set.visible = true	
				end if
		end choose
	else
		ibt_set.visible = false	
	end if
	
	if of_button_mod_sec( ii_button_set[b])	= 0 then 	ibt_set.visible = false	//Start Code Change ----11.14.2013 #V14 maha
next

//Start Code Change ----11.14.2013 #V14 maha - trap for all invisible
li_go = 0			
for b = 1 to 9
	choose case b
		case 1
			if pb_1.visible then 
				li_go = 1
				exit
			end if
		case 2
			if pb_2.visible then 
				li_go = 1
				exit
			end if
		case 3
			if pb_3.visible then 
				li_go = 1
				exit
			end if
		case 4
			if pb_4.visible then 
				li_go = 1
				exit
			end if
		Case 5
			if pb_5.visible then 
				li_go = 1
				exit
			end if
		case 6
			if pb_6.visible then 
				li_go = 1
				exit
			end if
		case 7
			if pb_7.visible then 
				li_go = 1
				exit
			end if
		case 8
			if pb_8.visible then 
				li_go = 1
				exit
			end if
		case 9
			if pb_9.visible then 
				li_go = 1
			end if
	end choose
next

destroy lds_buttons
//get setting values
if li_go = 0 then return -1

//End Code Change ----11.14.2013

return 1
end function

public function integer of_buttons_visible (boolean ab_buttons_visible);//Start Code Change ----03.12.2013 #V12 maha - added

If ab_buttons_visible then
	cb_ok.visible = false
	cb_close.visible = false
	sle_user_id.visible = false
	sle_password.visible = false
	rb_prod.visible = false
	rb_test.visible = false
	st_id.visible = false
	st_pw.visible = false
	p_logo.visible = false
	st_program.visible = false
	cb_cancel_button.visible = True
	st_isg.visible = false
	st_iss.visible = false
	p_gear.visible = false
	if upper(gs_user_id) = 'MASTER' then   //Start Code Change ----12.07.2015 #V15 maha
		cb_support.visible = true
	end if
	st_welcome.visible = true
	st_forgot_pw.visible = false
	st_version.visible = false
else
	pb_1.visible = False
	pb_1.bringtotop = False
	pb_2.visible = False
	pb_2.bringtotop = False
	pb_3.visible = False
	pb_3.bringtotop = False
	pb_4.visible = False
	pb_4.bringtotop = False
	pb_5.visible = False
	pb_5.bringtotop = False
	pb_6.visible = False
	pb_6.bringtotop = False
	pb_7.visible = False
	pb_7.bringtotop = False
	pb_8.visible = False
	pb_8.bringtotop = False	
	pb_9.visible = False
	pb_9.bringtotop = False
	cb_cancel_button.visible = False
// RP	p_logo.visible = true
	p_logo.bringtotop = false
	st_welcome.visible = false
end if


return 1
end function

public function integer of_button_mod_sec (integer ai_type);//Start Code Change ----11.14.2013 #V14 maha - created
integer s = 1

choose Case ai_type
	case 1 //prac
		if ii_set_9 = 4 then s = 0
	case 2 //contracts
		if ii_set_9 <> 4 and ii_set_cont = 0 then s = 0
	case 5 //ireport
		if ii_set_ireport = 0 then  s = 0
	case 6 //mapping
		if ii_set_iapps = 0 then  s = 0
	case 7 //export
		if ii_set_iauto = 0 then  s = 0
	case 8 //import
		if ii_set_import = 0 then  s = 0
	case 9 //call log
		if ii_set_call_log = 0 then  s = 0
	case 10	//Privileges	long.zhang BugL102904 
		if ii_set_priv = 0 then s = 0
	case 12 //app  print
		if ii_set_iapps = 0 then  s = 0
	case 14 // setup
		if ii_set_setup = 0 then  s = 0	
	case 18 //call actions
		if ii_set_call_log = 0 then  s = 0
end choose

return s
end function

public function integer of_welcome (); //Start Code Change ----11.13.2015 #V15 maha = added
string ls_name
string ls_day
integer p
time lt_time

lt_time = now()

if lt_time < time("12:00:00") then
	ls_day = "morning"
elseif  lt_time < time("17:00:00") then
	 ls_day = "afternoon"
else
	 ls_day = "evening"	 
end if

select user_name into :ls_name from security_users where user_id = :gs_user_id;

if isnull(ls_name) or ls_name = "" then
	ls_name = gs_user_id
else
	p = pos(ls_name, " ", 1)
	if p = 0 then p = len(ls_name)
	ls_name = mid(ls_name, 1 , p - 1)
end if

st_welcome.text = "Good " + ls_day + " " + ls_name + ".  Where would you like to start?"


return 1
end function

public function integer of_lockout_user ();//Start Code Change ----11.02.2016 #V153 maha
integer li_lock
time lt_time
datetime ldt_lock

of_log_connection("LOCK")
		
select lockout_min into :li_lock from security_settings;
		//Start Code Change ----12.10.2015 #V15 maha - changed from  '= 1'
choose case ii_opt_2
	case 0
		messagebox("Login Error","You have reached the maximum number of attempts(" + String(ii_lock_num) + ") and will be locked out.  Closing Program")//'(ii_lock_num)' Added by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4881 - Login Error received when max # of attempts is reached doesn't specify the actual # of attempts)
	case 1
		messagebox("Login Error","You have reached the maximum number of attempts and will be locked out.  Closing Program")//'(ii_lock_num)' Added by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4881 - Login Error received when max # of attempts is reached doesn't specify the actual # of attempts)
	case 2
		messagebox("Login Error","You have reached the maximum number of attempts(" + String(ii_lock_num) + ") and will be locked out for " + String(li_lock) + " minutes.  Closing Program")//'(ii_lock_num)' Added by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4881 - Login Error received when max # of attempts is reached doesn't specify the actual # of attempts)
end choose
lt_time = now()
lt_time = RelativeTime ( lt_time, li_lock  * 60 )
ldt_lock = datetime(today(),lt_time)

update security_users set lock_until = :ldt_lock where user_id = :gs_user_id;	//long.zhang 05.02.2013 - fail count is incremented in of_log_failure

commit using sqlca;

return 1
end function

on w_logon_screen_15.create
int iCurrent
call super::create
this.st_welcome=create st_welcome
this.p_gear=create p_gear
this.st_isg=create st_isg
this.cb_cancel_button=create cb_cancel_button
this.cb_1=create cb_1
this.pb_5=create pb_5
this.pb_9=create pb_9
this.pb_3=create pb_3
this.pb_8=create pb_8
this.pb_2=create pb_2
this.pb_6=create pb_6
this.pb_7=create pb_7
this.pb_4=create pb_4
this.pb_1=create pb_1
this.p_2=create p_2
this.shl_website=create shl_website
this.sle_pwtestdb=create sle_pwtestdb
this.sle_pwtest=create sle_pwtest
this.cbx_1=create cbx_1
this.rb_test=create rb_test
this.rb_tutor=create rb_tutor
this.rb_prod=create rb_prod
this.p_1=create p_1
this.r_1=create r_1
this.st_iss=create st_iss
this.p_logo=create p_logo
this.cb_support=create cb_support
this.st_forgot_pw=create st_forgot_pw
this.dw_image=create dw_image
this.st_id=create st_id
this.sle_user_id=create sle_user_id
this.st_pw=create st_pw
this.sle_password=create sle_password
this.cb_ok=create cb_ok
this.cb_close=create cb_close
this.st_program=create st_program
this.st_version=create st_version
this.cbx_remember=create cbx_remember
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_welcome
this.Control[iCurrent+2]=this.p_gear
this.Control[iCurrent+3]=this.st_isg
this.Control[iCurrent+4]=this.cb_cancel_button
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.pb_5
this.Control[iCurrent+7]=this.pb_9
this.Control[iCurrent+8]=this.pb_3
this.Control[iCurrent+9]=this.pb_8
this.Control[iCurrent+10]=this.pb_2
this.Control[iCurrent+11]=this.pb_6
this.Control[iCurrent+12]=this.pb_7
this.Control[iCurrent+13]=this.pb_4
this.Control[iCurrent+14]=this.pb_1
this.Control[iCurrent+15]=this.p_2
this.Control[iCurrent+16]=this.shl_website
this.Control[iCurrent+17]=this.sle_pwtestdb
this.Control[iCurrent+18]=this.sle_pwtest
this.Control[iCurrent+19]=this.cbx_1
this.Control[iCurrent+20]=this.rb_test
this.Control[iCurrent+21]=this.rb_tutor
this.Control[iCurrent+22]=this.rb_prod
this.Control[iCurrent+23]=this.p_1
this.Control[iCurrent+24]=this.r_1
this.Control[iCurrent+25]=this.st_iss
this.Control[iCurrent+26]=this.p_logo
this.Control[iCurrent+27]=this.cb_support
this.Control[iCurrent+28]=this.st_forgot_pw
this.Control[iCurrent+29]=this.dw_image
this.Control[iCurrent+30]=this.st_id
this.Control[iCurrent+31]=this.sle_user_id
this.Control[iCurrent+32]=this.st_pw
this.Control[iCurrent+33]=this.sle_password
this.Control[iCurrent+34]=this.cb_ok
this.Control[iCurrent+35]=this.cb_close
this.Control[iCurrent+36]=this.st_program
this.Control[iCurrent+37]=this.st_version
this.Control[iCurrent+38]=this.cbx_remember
end on

on w_logon_screen_15.destroy
call super::destroy
destroy(this.st_welcome)
destroy(this.p_gear)
destroy(this.st_isg)
destroy(this.cb_cancel_button)
destroy(this.cb_1)
destroy(this.pb_5)
destroy(this.pb_9)
destroy(this.pb_3)
destroy(this.pb_8)
destroy(this.pb_2)
destroy(this.pb_6)
destroy(this.pb_7)
destroy(this.pb_4)
destroy(this.pb_1)
destroy(this.p_2)
destroy(this.shl_website)
destroy(this.sle_pwtestdb)
destroy(this.sle_pwtest)
destroy(this.cbx_1)
destroy(this.rb_test)
destroy(this.rb_tutor)
destroy(this.rb_prod)
destroy(this.p_1)
destroy(this.r_1)
destroy(this.st_iss)
destroy(this.p_logo)
destroy(this.cb_support)
destroy(this.st_forgot_pw)
destroy(this.dw_image)
destroy(this.st_id)
destroy(this.sle_user_id)
destroy(this.st_pw)
destroy(this.sle_password)
destroy(this.cb_ok)
destroy(this.cb_close)
destroy(this.st_program)
destroy(this.st_version)
destroy(this.cbx_remember)
end on

event open;call super::open;blob lb_splash_pic
integer setprod
integer li_testbox
integer li_rand //maha 072409
integer li_banner //maha 040109
integer li_set //maha 03.24.2011
integer li_forgot_pw   //maha 12.10.2015
integer li_forgot_method   //maha 12.10.2015
Integer li_ad_save_pwd, li_ad_status,li_active_status_user //Added by Appeon long.zhang 01.09.2017 (v15.3 AD Authentication)
int li_hascolumns = 0 //Added by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)
string pspath
String ls_dev
string ls_original_dev_setting
string ls_prod
string ls_dep
string ls_name
String ls_ad_pc_domainname, ls_ad_pc_username, ls_shortdomainname //Added by Appeon long.zhang 01.09.2017 (v15.3 AD Authentication)
String ls_ad_server, ls_ad_user, ls_ad_password,ls_passorg, ls_error //Added by Appeon long.zhang 01.09.2017 (v15.3 AD Authentication)

datetime ldt_validetime, ldt_utcnow //Added by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)
string ls_mapping_user = ""//Added by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)
//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
Boolean	lb_ReLogin

//Added By Ken.Guo 2016-06-16//Copied from CLX by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)
inv_ad = create n_cst_ad  
inv_systeminfo = create n_cst_systeminfo

 lb_ReLogin = gf_get_relogin_status( )//added by gavins 20130515
//---------End Added ------------------------------------------------------

//in_encrypt = create n_cst_encrypt
 this.backcolor = intelli_purple  //Start Code Change ----09.11.2013 #V14 maha

//---------------------------- RP 1.26.2016 ---------------------------------------------------
this.backColor = rgb(255, 255, 255)

//------------------- APPEON BEGIN -------------------
//<$>Modified:long.zhang 02.24.2016
//<$>reason: Not correct.
//dw_image.width = this.width
//dw_image.height = this.height
dw_image.width = WorkSpaceWidth() 
dw_image.height = WorkSpaceHeight() 
//------------------- APPEON END -------------------

dw_image.object.datawindow.color = COLOR_BACKGROUND
IF dw_image.rowCount() = 0 THEN
	dw_image.insertRow(0)
END IF
st_id.textColor = COLOR_TEXT
st_id.backColor = COLOR_BACKGROUND
st_pw.textColor = COLOR_TEXT
st_pw.backColor = COLOR_BACKGROUND
st_program.backColor = COLOR_BACKGROUND
st_program.textColor = rgb(192, 192, 172)
st_version.textColor = COLOR_TEXT
st_version.backColor = COLOR_BACKGROUND
rb_prod.textColor = COLOR_TEXT
rb_prod.backColor = COLOR_BACKGROUND
rb_test.textColor = COLOR_TEXT
rb_test.backColor = COLOR_BACKGROUND
//-------------------------------------------------------------------------------------------------
cbx_remember.textColor = COLOR_TEXT
cbx_remember.backColor = COLOR_BACKGROUND


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
	st_id.Visible = False
	sle_user_id.Text = "SE"
	sle_password.SetFocus()
END IF

If Not lb_ReLogin Then //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
	IF of_logon() = -1 THEN
		is_mess = "DB Error"
		w_logon_screen.triggerevent(close! )
	//CloseWithReturn( Parent, is_mess )
	
		Return
	END IF
End If


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
	ls_name+= " 15"
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
st_version.text+=  " " + CharA ( 169 ) + "ISG Group LLC 1998-2016" //maha 04.02.2010 - added
//END---Modify by Evan 11/11/2008

If Not lb_ReLogin Then //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
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
		//$<Reason> Set the ion cache dynamically on Web
		if AppeonGetClientType() = 'WEB' then
			SQLCA.DBMS = gs_CacheType
			SQLCA.DBParm = gs_CacheSet
		end if
		//---------------------------- APPEON END ----------------------------
	
		CONNECT USING SQLCA;
		gnv_app.of_setuserid( "MASTER" )
		is_mess = gs_user_id
		w_logon_screen.triggerevent(close! )
		RETURN   //alfee 06.25.2013
	elseif ls_dev = "2"  or ls_dev = "3" THEN
		sle_user_id.text = "user1"
		sle_password.text = "123"
		ib_dev = true  //Start Code Change ----07.14.2015 #V15 maha
	END IF
	
	String ls_password
	
	gs_user_id = 'MASTER'
	gnv_app.of_setuserid( gs_user_id )
	ls_password = SUPER_MASTER_PASSWORD
End If

//Start Code Change ----03.12.2013 #V14 maha - hide buttons
of_buttons_visible( false)  //moved above for Bug # 4035 - alfee 05.15.2014 
//End Code Change ----03.12.2013 

//Start Code Change ----04.01.2009 #V92 maha - added for ameripath customization
select use_banner into :li_banner from security_settings;

//if li_banner = 1 then
if li_banner = 1 and not gb_IsAutoExpImp and not gb_AutoSchedule then //web based scheduler - alfee 01.27.2011
	open(w_security_banner)
	if message.stringparm = "Cancel" then 
		Halt Close //Bug # 4035 - alfee 05.15.2014
		//close (this)
		//Halt
	end if
end if
//End Code Change---04.01.2009

 //Start Code Change ----12.10.2015 #V15 maha - settings for forgot password
select forgot_pw_request, quest_email, min_quest into :li_forgot_pw, :li_forgot_method, :ii_min_quest from security_settings;
Choose case li_forgot_pw  //Start Code Change ----04.07.2016 #V15 maha - modified to case statement
	case 1, 2  
		st_forgot_pw.visible = true
		 ii_forgot_method =  li_forgot_method 
		choose case li_forgot_method
			case 0, 2
				ib_user_quest = false
			case 1, 3
				ib_user_quest = true 
		end choose
	case else
		ib_user_quest = false
		ii_forgot_method =0
end choose
 //End Code Change ----12.10.2015 

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.15.2016
//<$>reason:Use AD auto Login. if open from saml, then need not AD login. Copied and modified from CLX, for v15.3 AD Authentication
If Not isvalid(gnv_user_option) Then 
	gnv_user_option = Create n_cst_user_option  
	gnv_user_option.of_system_retrieve( ) 
End If

If Not gb_ad_command_off and Not lb_ReLogin and gs_verifycode = '' and (gnv_user_option.of_get_option_value('allow_ad_function') = '1'  )Then
	ls_ad_pc_domainname = inv_systeminfo.of_get_domaindnsname( )
	ls_shortdomainname = inv_systeminfo.of_get_domainname( )
	gnv_debug.of_output(False, 'domaindnsname='+ls_ad_pc_domainname)
	If ls_ad_pc_domainname <> '' Then		
		ls_ad_pc_username = inv_systeminfo.of_get_username( )
		select Top 1 user_id, active_status, ad_server, ad_user, ad_password, ad_save_pwd, ad_status  
		into :is_user_id, :li_active_status_user,:ls_ad_server, :ls_ad_user, :ls_ad_password,:li_ad_save_pwd, :li_ad_status from security_users 
		where ad_user = :ls_ad_pc_username or ad_user = :ls_ad_pc_domainname + '\' + :ls_ad_pc_username or ad_user = :ls_shortdomainname + '\' + :ls_ad_pc_username ;
		If sqlca.sqlcode = 0 and li_ad_status = 1 and (li_active_status_user = 1 or isnull(li_active_status_user))  Then
			cbx_remember.visible = True
			st_id.text = 'Domain\User'
			If st_id.width < 450 then st_id.width = 450
			If li_ad_save_pwd = 1 Then
				cbx_remember.checked = True
				ls_passorg = in_encrypt.of_decrypt( ls_ad_password)
				If inv_ad.of_connect_ad( ls_ad_pc_domainname, ls_ad_pc_username, ls_passorg, ref ls_error, True, True) = 0 Then
					gs_user_id = is_user_id
					sle_user_id.text = ls_shortdomainname + '\' + ls_ad_pc_username
					sle_user_id.displayonly = True
					sle_user_id.backcolor = RGB(192,192,192)				
					sle_password.text = '******'
					ib_ad_autologin = True
					gb_ad_login = True
					Post Sleep(1)  //For displaying logo.
					cb_ok.Post event clicked( )
					Return
				Else
					sle_user_id.text = ls_shortdomainname + '\' + ls_ad_pc_username
					sle_user_id.displayonly = True
					sle_user_id.backcolor = RGB(192,192,192)		
					sle_password.setfocus()
				end If
			Else
				sle_user_id.text = ls_shortdomainname + '\' + ls_ad_pc_username
				sle_user_id.displayonly = True
				sle_user_id.backcolor = RGB(192,192,192)	
				sle_password.setfocus()
			End If
		Else
		End If
	End If
End If
//------------------- APPEON END -------------------


//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 10.20.2016
//<$>reason:Copied from CLX and modified, for v15.3 SSO Support with SAML
// SAML SSO Auto Login
select top 1 use_saml, only_saml_user 
into :is_use_saml, :is_only_saml_user
from icred_settings using sqlca;

if isnull(is_use_saml) then is_use_saml = "0"

if is_use_saml <> "1" then
	return
end if

if isnull(is_only_saml_user) then is_only_saml_user = "0"

if gs_verifycode<>"" and is_use_saml <> "1" then
	MessageBox("SAML Error","SAML setting error , please enable SAML function at 'System->Setup->User Administration->SAML' ")
	return
end if

if gs_idpname<>"" and gs_verifycode<>"" and AppeonGetClientType() = 'WEB' then
	SQLCA.DBMS="ODBC"
	if gi_test_database = 1 then
		SQLCA.DbParm="ConnectString='DSN=IntelliCred Test;UID=master;PWD=" + SUPER_MASTER_PASSWORD + ";',DelimitIdentifier='Yes'"
	else
		SQLCA.DbParm="ConnectString='DSN=" + gs_odbc + ";UID=master;PWD=" + SUPER_MASTER_PASSWORD + ";',DisableBind=1,DelimitIdentifier='Yes',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
	end if

	SQLCA.AutoCommit = TRUE	

	//Set the connection cache dynamically on Web	
	SQLCA.DBMS = gs_CacheType
	SQLCA.DBParm = gs_CacheSet

	CONNECT USING SQLCA;

	select top 1 getutcdate(), idpuser_validetime, map_user_id 
	into :ldt_utcnow, :ldt_validetime, :ls_mapping_user 
	from idp_users 
	where  app_verifycode = :gs_verifycode  using sqlca;
	
	if IsNull(ls_mapping_user)  or ls_mapping_user = "" then
		MessageBox("SAML Error","Can not find a mapped user to login")
		return
	else
		if ldt_utcnow > ldt_validetime then
			MessageBox("SAML Error","Verify code is not validate.")
			return
		end if
	end if
	
	gs_user_ID = ls_mapping_user
	gnv_app.of_setuserid(ls_mapping_user)
	is_mess = gs_user_id
	of_log_connection('PASS')
	
	gs_idpname = "" 
	
	//Clear verifycode, Added by Appeon long.zhang 10.26.2016 (v15.3 SSO Support with SAML)
	update idp_users set  idpuser_validetime = getutcdate() , app_verifycode = ''	
	where  app_verifycode = :gs_verifycode  using sqlca;
	gs_verifycode = ""

	w_logon_screen.triggerevent(close! )
	Return
end if
//------------------- APPEON END -------------------
end event

event closequery;call super::closequery;if is_mess = "" then is_mess = "Cancel"
end event

event close;call super::close;If isvalid(inv_ad) Then Destroy inv_ad  //Added by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)
If isvalid(inv_systeminfo) then Destroy inv_systeminfo //Added by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)
CloseWithReturn( this, is_mess )
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

If Not gf_Get_ReLogin_Status( ) Then  //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
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
	
	If Not sle_user_id.displayonly Then //If Condition, Added by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)
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
	End If
	//---------------------------- APPEON END ----------------------------
	
	//-----Begin Added by Alfee 01.27.2011 ----------------------------
	//Web based scheduler 
	If AppeonGetClientType() = "WEB" and (gb_IsAutoExpImp or gb_AutoSchedule) Then 
		//Get the username and password
		gnv_appeondll.of_registryget ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Username", regstring!, is_sched_username)
		gnv_appeondll.of_registryget ("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Scheduler", "Password", regstring!, is_sched_password)

		//-----Begin Added by Alfee 05.15.2015 ----------------------------
		If (IsNull(is_sched_username) Or Len(Trim(is_sched_username)) < 1) And of_is_os64 () Then
			RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\IntelliSoft Group\Scheduler", "Username", is_sched_username)	
			RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\IntelliSoft Group\Scheduler", "Password", is_sched_password)	
		End If
		//-----End Added -----------------------------------------------------
	
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
End If

//Start Code Change ----03.01.2016 #V15 maha
cb_ok.textsize = 18
cb_ok.weight = 700
cb_close.textsize = 18
//End Code Change ----03.01.2016

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.15.2016
//<$>reason:If AD account is disabled, then clear the user name. Copied and modified from CLX  (v15.3 AD Authentication)
String ls_user,ls_domainuser,ls_ad_pc_domainname,ls_shortdomainname
Integer li_user_cnt, li_ad_status=100

If not gb_ad_login Then
	ls_user = sle_user_id.text
	If ls_user <> '' Then //Added by Appeon long.zhang 11.15.2016
		ls_ad_pc_domainname = inv_systeminfo.of_get_domaindnsname( )
		ls_shortdomainname = inv_systeminfo.of_get_domainname( )
	
		If lastpos(ls_user,'\') > 0 Then
			ls_domainuser = Mid(ls_user, lastpos(ls_user,'\') + 1 , Len(ls_user))
		Else
			ls_domainuser = ls_user
		End If		
		gnv_appeondb.of_startqueue( )
			select count(1) into :li_user_cnt from security_users where user_id = :ls_user;
			select ad_status into :li_ad_status from security_users 
				where ad_user = :ls_domainuser or ad_user = :ls_user or ad_user = :ls_ad_pc_domainname + '\' + :ls_domainuser or ad_user = :ls_shortdomainname + '\' + :ls_domainuser ;
		gnv_appeondb.of_commitqueue( )
		If li_user_cnt > 0 Then Return //It is not an AD Account.
		If gnv_user_option.of_get_option_value('allow_ad_function') = '0'  or (li_ad_status = 0 or isnull(li_ad_status))  Then //It is Ad ccount, and AD status is turned off.
			sle_user_id.text = ''
			sle_user_id.post setfocus()
		End If 
		
		If gb_ad_command_off Then
			sle_user_id.text = ''
			sle_user_id.post setfocus()
		End If
	End If
End If
//------------------- APPEON END -------------------



end event

event pfc_preopen;call super::pfc_preopen;if gb_IsAutoExpImp or gb_AutoSchedule then this.Hide()//Modified by Nova 12.29.2009 -v10.1 Scheduler Functionality  //Added by Evan 03.12.2009
end event

type st_welcome from statictext within w_logon_screen_15
integer y = 100
integer width = 4507
integer height = 88
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 65535
long backcolor = 8388608
string text = "Product Version"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;this.backcolor = INTELLI_PURPLE
this.textcolor = INTELLI_orange
end event

type p_gear from picture within w_logon_screen_15
boolean visible = false
integer x = 1687
integer y = 36
integer width = 283
integer height = 248
string picturename = "ISG gear.jpg"
boolean focusrectangle = false
end type

type st_isg from statictext within w_logon_screen_15
boolean visible = false
integer x = 1865
integer y = 44
integer width = 850
integer height = 120
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 8388608
long backcolor = 16777215
string text = "Intellisoft Group"
long bordercolor = 16777215
boolean focusrectangle = false
end type

type cb_cancel_button from commandbutton within w_logon_screen_15
integer x = 2098
integer y = 2276
integer width = 389
integer height = 92
integer taborder = 180
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean flatstyle = true
end type

event clicked;is_mess = "Cancel"
parent.triggerevent(close! )
end event

type cb_1 from commandbutton within w_logon_screen_15
boolean visible = false
integer x = 169
integer y = 2208
integer width = 343
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "quick"
end type

event clicked;open(w_quick_access_screen)
end event

type pb_5 from picturebutton within w_logon_screen_15
integer x = 1696
integer y = 952
integer width = 1134
integer height = 644
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Button 5"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= ii_button_set[5]
parent.triggerevent(close! )
	

end event

type pb_9 from picturebutton within w_logon_screen_15
integer x = 2853
integer y = 1616
integer width = 1134
integer height = 644
integer taborder = 130
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Button 9"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= ii_button_set[9]
parent.triggerevent(close! )
	

end event

type pb_3 from picturebutton within w_logon_screen_15
integer x = 2853
integer y = 284
integer width = 1134
integer height = 644
integer taborder = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Button 3"
long textcolor = 16711680
long backcolor = 16777215
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= ii_button_set[3]
parent.triggerevent(close! )
	

end event

type pb_8 from picturebutton within w_logon_screen_15
integer x = 1696
integer y = 1616
integer width = 1134
integer height = 644
integer taborder = 120
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Button 8"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= ii_button_set[8]
parent.triggerevent(close! )
	

end event

type pb_2 from picturebutton within w_logon_screen_15
integer x = 1696
integer y = 284
integer width = 1134
integer height = 644
integer taborder = 70
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Button 2"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= ii_button_set[2]
parent.triggerevent(close! )
	

end event

type pb_6 from picturebutton within w_logon_screen_15
integer x = 2853
integer y = 952
integer width = 1134
integer height = 644
integer taborder = 100
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Button 6"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= ii_button_set[6]
parent.triggerevent(close! )
	

end event

type pb_7 from picturebutton within w_logon_screen_15
integer x = 535
integer y = 1616
integer width = 1134
integer height = 644
integer taborder = 110
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Button 7"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= ii_button_set[7]
parent.triggerevent(close! )
	

end event

type pb_4 from picturebutton within w_logon_screen_15
integer x = 535
integer y = 952
integer width = 1134
integer height = 644
integer taborder = 90
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Button 4"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= ii_button_set[4]
parent.triggerevent(close! )
end event

type pb_1 from picturebutton within w_logon_screen_15
integer x = 535
integer y = 284
integer width = 1134
integer height = 644
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Button 1"
long textcolor = 16711680
end type

event clicked;//Start Code Change ----08.21.2012 #V12 maha - new
//if of_click_ok( ) = - 1 then return

gi_openscreen= ii_button_set[1]
parent.triggerevent(close! )
	

end event

type p_2 from picture within w_logon_screen_15
integer x = 2336
integer y = 2852
integer width = 983
integer height = 224
boolean enabled = false
string picturename = "isg namelogo.bmp"
end type

type shl_website from statichyperlink within w_logon_screen_15
boolean visible = false
integer x = 3662
integer y = 2280
integer width = 1362
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "HyperLink!"
long backcolor = 67108864
boolean enabled = false
string text = "http://web.intellisoftgroup.com/prod/?[customer_id]"
boolean focusrectangle = false
end type

type sle_pwtestdb from singlelineedit within w_logon_screen_15
boolean visible = false
integer x = 3602
integer y = 2168
integer width = 343
integer height = 80
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type sle_pwtest from singlelineedit within w_logon_screen_15
boolean visible = false
integer x = 3607
integer y = 2068
integer width = 343
integer height = 80
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "log"
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_logon_screen_15
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
string facename = "MS Sans Serif"
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

type rb_test from radiobutton within w_logon_screen_15
integer x = 1902
integer y = 2084
integer width = 1102
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 8388608
string text = "Connect to Test Database "
end type

event constructor;//this.textcolor = INTELLI_PURPLE
//THIS.backcolor = INTELLI_orange
//this.backcolor = INTELLI_PURPLE
//THIS.textcolor = INTELLI_orange
this.textcolor = color_text
this.backcolor = color_background
end event

type rb_tutor from radiobutton within w_logon_screen_15
boolean visible = false
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

type rb_prod from radiobutton within w_logon_screen_15
integer x = 1902
integer y = 2008
integer width = 1102
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 8388608
string text = "Connect to Production Database "
boolean checked = true
end type

event constructor;//this.backcolor = INTELLI_PURPLE
//THIS.textcolor = INTELLI_orange
this.textcolor = color_text
this.backcolor = color_background
end event

type p_1 from picture within w_logon_screen_15
boolean visible = false
integer x = 1330
integer y = 2720
integer width = 859
integer height = 384
string picturename = "isg gif graphictop.gif"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_logon_screen_15
long linecolor = 8388608
integer linethickness = 4
long fillcolor = 8388608
integer x = 4585
integer y = 616
integer width = 320
integer height = 168
end type

type st_iss from statictext within w_logon_screen_15
boolean visible = false
integer x = 2007
integer y = 164
integer width = 754
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
string text = "Intelligent Software Solutions"
long bordercolor = 16777215
boolean focusrectangle = false
end type

type p_logo from picture within w_logon_screen_15
boolean visible = false
integer x = 5
integer y = 4
integer width = 4485
integer height = 2512
boolean enabled = false
string picturename = "IntelliCred-login-15.jpg"
end type

type cb_support from commandbutton within w_logon_screen_15
boolean visible = false
integer x = 1714
integer y = 2276
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Support Utl"
boolean flatstyle = true
end type

event clicked;gi_openscreen= 20
parent.triggerevent(close! )
end event

type st_forgot_pw from statictext within w_logon_screen_15
boolean visible = false
integer x = 1920
integer y = 1920
integer width = 622
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16777215
long backcolor = 8388608
string text = "I forgot my password"
boolean focusrectangle = false
end type

event constructor;
//this.backcolor = 553648127   //transparent
this.textcolor = color_text
this.backcolor = color_background




end event

event clicked; //Start Code Change ----12.10.2015 #V15 maha
integer li_cnt
integer r
boolean lb_email
string ls_user

ls_user = sle_user_id.text

//Check user id, Added by Appeon long.zhang 04.18.2016 (BugL041801)
If Trim(ls_user) = '' Then
	messagebox("Forgot password","Please enter your User ID.")
	sle_user_id.SetFocus()
	return 1
End if

if ib_user_quest = true then
	select count(quest_id) into :li_cnt from security_user_quest where user_id = :ls_user;
	if li_cnt = 0 or isnull(li_cnt) then
		messagebox("Forgot password","The system requires security questions to be able to use the Forgot Password function.  Please contact your System Administrator to reset your password.")
		return 1
	end if
end if

if ii_forgot_method = 0 then
	messagebox("Forgot password","The system is not properly set up to be able to use the Forgot Password function.  Please contact your System Administrator to reset your password.")
	return 1
end if

if upper(ls_user) = "MASTER" then
	messagebox("Forgot password","This function cannot be used for user id MASTER.")
	return 1
end if

choose case  ii_forgot_method
	case 2,3
		lb_email = true
	case else
		lb_email = false
end choose
	
r = of_forgot_password(ls_user, ib_user_quest, lb_email)

if r = -2 then
	of_log_connection( "QUESTFAIL")
	of_lockout_user()
	is_mess = "Cancel"
	w_logon_screen.triggerevent(close! )
	return 1
else
	return 1
end if
	
end event

type dw_image from datawindow within w_logon_screen_15
integer width = 3840
integer height = 1784
boolean bringtotop = true
string title = "none"
string dataobject = "d_ext_logon_image"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_id from statictext within w_logon_screen_15
integer x = 1915
integer y = 1468
integer width = 247
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI Semibold"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "User ID"
boolean focusrectangle = false
end type

event constructor;this.textcolor = INTELLI_PURPLE
//THIS.backcolor = INTELLI_orange
this.backcolor = INTELLI_PURPLE_12
//THIS.textcolor = INTELLI_orange

//BEGIN change font background color and text color for Version 12.1 NM 05/15/12
//this.backcolor = INTELLI_white
//this.textcolor = Intelli_black
//END NM 05/15/2012


end event

type sle_user_id from singlelineedit within w_logon_screen_15
integer x = 1915
integer y = 1544
integer width = 731
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

type st_pw from statictext within w_logon_screen_15
integer x = 1920
integer y = 1636
integer width = 325
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI Semibold"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Password"
boolean focusrectangle = false
end type

event constructor;this.textcolor = INTELLI_PURPLE
this.backcolor = INTELLI_PURPLE_12
//this.textcolor = INTELLI_PURPLE
//THIS.backcolor = INTELLI_orange
//this.backcolor = INTELLI_PURPLE
//THIS.textcolor = INTELLI_orange
//
//BEGIN change font background color and text color for Version 12.1 NM 05/15/12
//this.backcolor = INTELLI_white
//this.textcolor = Intelli_black
//END NM 05/15/2012

end event

type sle_password from singlelineedit within w_logon_screen_15
integer x = 1915
integer y = 1712
integer width = 731
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.text = ""
end event

type cb_ok from u_cb within w_logon_screen_15
integer x = 1915
integer y = 1816
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//maha 112105 major functionality change to connect via DBA.  

String ls_password
integer li_user
integer li_set7
integer li_days
integer li_res
integer li_lock //Start Code Change ---- 08.02.2007 #V7 maha
integer li_forgot_pw  //maha 12.1002015
integer li_forgot_method  //maha 12.1002015
integer li_cnt //maha 12.1002015
date ld_password
datetime ldt_lock //Start Code Change ---- 08.02.2007 #V7 maha
time lt_time
Boolean	lb_ReLogin //(Appeon)Harry 03.18.2014 - V142 ISG-CLX

//----------------------------RP 3.3.2016----------------------------------
gnv_app.of_benchmark("clicked ok button on logon screen")
//----------------------------

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 10.20.2016
//<$>reason:Only SAML user can login,copied from CLX, for v15.3 SSO Support with SAML
if is_use_saml = "1" and is_only_saml_user = "1" and upper(sle_user_id.Text) <> "MASTER" and AppeonGetClientType() = 'WEB' then
	messagebox("Login Error","Only SAML user account allow to using this program.")
	return -1
end if
//------------------- APPEON END -------------------

//maha 112105 major functionality change connection using dba for all connections
IF IsNull( sle_user_id.Text ) OR sle_user_id.Text = "" THEN
	MessageBox("Required Field", "You must enter a User ID." )//Modified by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4882 - Inconsistency with using user id vs user name with login screen and error messages)
	sle_user_id.setfocus()//maha 080300
	Return -1
END IF

IF IsNull( sle_password.Text ) OR sle_password.Text = "" THEN
	MessageBox("Required Field", "You must enter a password." )
	sle_password.setfocus()//maha 080300
	Return -1
END IF
lb_ReLogin = gf_Get_ReLogin_Status( )  //(Appeon)Harry 05.07.2015 - for V142 ISG-CLX
If Not lb_ReLogin Then //add if statement - (Appeon)Harry 03.18.2014 for V142 ISG-CLX
	gs_user_id = sle_user_id.Text	
	gnv_app.of_setuserid( gs_user_id )
End If
gs_password = sle_password.Text
ls_password = sle_password.Text

IF ls_password = "IntelliMasterSE" THEN
	sle_user_id.Visible = True
	st_id.Visible = True
	sle_password.Text = ""
	sle_user_id.Text = ""
	Return 1
END IF

If Not lb_ReLogin Then  //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
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
			/*	HALT*/
			is_mess = "Cancel"
			w_logon_screen.triggerevent(close! )
			return
			//------------------- APPEON END -------------------
		end if
	end if
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11/19/2007 By: Ken.Guo
//$<reason> LDAP user need auto login
//li_res = of_user_login( il_attempts)
If ib_ad_autologin Then //Use AD before AUTO LOGIN, Added by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)
	li_res = of_user_login( il_attempts)
ElseIf gb_autologin = True Then
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
		messagebox("Login Error","You have reached the maximum number of attempts(3).  Closing Program") //'(3)' Added by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4881 - Login Error received when max # of attempts is reached doesn't specify the actual # of attempts)
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 06.30.2011
		//$<reason> login failure web deployment bug #2491
		/*		HALT		*/
		is_mess = "Cancel"
		w_logon_screen.triggerevent(close! )
		return
		//------------------- APPEON END -------------------
	elseif il_attempts =  ii_lock_num then //08.02.2007 #V7 maha
		of_log_connection("LOCK")
		
		select lockout_min into :li_lock from security_settings;
		//Start Code Change ----12.10.2015 #V15 maha - changed from  '= 1'
		choose case ii_opt_2
			case 0
				messagebox("Login Error","You have reached the maximum number of attempts(" + String(ii_lock_num) + ") and will be locked out.  Closing Program")//'(ii_lock_num)' Added by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4881 - Login Error received when max # of attempts is reached doesn't specify the actual # of attempts)
			case 1
				messagebox("Login Error","You have reached the maximum number of attempts and will be locked out.  Closing Program")//'(ii_lock_num)' Added by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4881 - Login Error received when max # of attempts is reached doesn't specify the actual # of attempts)
			case 2
				messagebox("Login Error","You have reached the maximum number of attempts(" + String(ii_lock_num) + ") and will be locked out for " + String(li_lock) + " minutes.  Closing Program")//'(ii_lock_num)' Added by Appeon long.zhang 12.10.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4881 - Login Error received when max # of attempts is reached doesn't specify the actual # of attempts)
		end choose
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
		/*		HALT		*/
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
	
	//------------------- APPEON BEGIN -------------------
	//<$>modified:long.zhang 12.18.2014
	//<$>reason:Bug 4368 created for Case# 00051366: Issue when the user is locked out of the system
	//HALT
	is_mess = "Cancel"
	w_logon_screen.triggerevent(close! )
	return
	//------------------- APPEON END -------------------
	
//End Code Change---08.02.2007		
elseif li_res = -3 then //Start Code Change ----04.06.2009 #V92 maha - added ameripath custom
	messagebox("Login Error"," The user '" + gs_user_id + "' is an inactive login and cannot be used to connect to the program.  Contact your system administrator to reset.")
	of_log_connection("INACTIVE")
	
	//------------------- APPEON BEGIN -------------------
	//<$>modified:long.zhang 12.18.2014
	//<$>reason:Bug 4368 created for Case# 00051366: Issue when the user is locked out of the system
	//HALT
	is_mess = "Cancel"
	w_logon_screen.triggerevent(close! )
	return
	//------------------- APPEON END -------------------
	
elseif li_res = -6 then 
	messagebox("Login Error","This login has more than 25 consecutive failed attempts.  For security purposes, this user id is being set to inactive.  Closing Program")
	of_log_connection("INACTIVE")
	//Start Code Change ----03.25.2013 #V12 maha
	update security_users set active_status = 0 where user_id = :gs_user_id;
	commit using sqlca;
	//End Code Change ----03.25.2013
	
	//------------------- APPEON BEGIN -------------------
	//<$>modified:long.zhang 12.18.2014
	//<$>reason:Bug 4368 created for Case# 00051366: Issue when the user is locked out of the system
	//HALT
	is_mess = "Cancel"
	w_logon_screen.triggerevent(close! )
	return
	//------------------- APPEON END -------------------
	
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

 //Start Code Change ----12.10.2015 #V15 maha - security quest
if ib_user_quest = true then
	if upper(gs_user_id) = "MASTER" then
		//skip for master
	else
		//debugbreak()
		select count(quest_id) into :li_cnt from security_user_quest where user_id = :gs_user_id;
		if li_cnt = 0 or isnull(li_cnt) then
			open(w_security_user_quest_add)
		elseif li_cnt < ii_min_quest then
			open(w_security_user_quest_add)
		end if
	end if
end if
 //End Code Change ----12.10.2015

//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
If  lb_ReLogin Then
	gs_password = sle_password.Text
	gnv_app.of_setuserid( gs_user_id )
End If
//-----End Added ---------------------------------------------------------------------

is_mess = gs_user_id

f_get_home_right() //(Appeon)Harry 12.07.2015 - for Bug # 4867
if gb_home_visible then //(Appeon)Harry 12.07.2015 - for Bug # 4867
//----------------------------- RP Modified 1.21.2016------------------------------------
	function post close(parent)
//	//Start Code Change ----05.21.2013 #V14 maha - set buttons
//	w_logon_screen.setredraw(false)
//	of_buttons_visible( true)
//	of_button_color( ) //sets text color
//	of_welcome()
//	// if of_button_settings() < 0 then 
//	if gb_IsAutoExpImp or gb_AutoSchedule or of_button_settings() < 0 then //BugE120301 - Eugene 12.03.2013
//		w_logon_screen.triggerevent(close!)
//	else
//		w_logon_screen.setredraw(true)
//	end if
//	//End Code Change ----05.21.2013
//-------------------- End RP Modified -----------------------------------------------------
else
	w_logon_screen.triggerevent(close!)
end if

Return li_res //Web based scheduler - alfee 01.27.2011

end event

type cb_close from u_cb within w_logon_screen_15
integer x = 2295
integer y = 1816
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
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

type st_program from statictext within w_logon_screen_15
integer x = 521
integer y = 1204
integer width = 3520
integer height = 168
boolean bringtotop = true
integer textsize = -22
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI Semibold"
long textcolor = 65535
long backcolor = 16711680
string text = "IntelliSoft"
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

event constructor;this.backcolor = INTELLI_PURPLE
//this.textcolor = INTELLI_orange
this.textcolor = INTELLI_white
//this.backcolor = INTELLI_orange
//this.textcolor = INTELLI_purple





//BEGIN---Add by Evan 11/11/2008
//this.Move(64, 1240)
//this.Resize(1193, 236)
//END---Add by Evan 11/11/2008
end event

type st_version from statictext within w_logon_screen_15
integer y = 2484
integer width = 4507
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 65535
long backcolor = 16711680
string text = "Product Version"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;this.backcolor = INTELLI_PURPLE
//this.textcolor = INTELLI_orange
this.textcolor = INTELLI_white
//this.backcolor = INTELLI_orange
//this.textcolor = INTELLI_purple

//Modified by NM 05/15/2012
//this.textcolor = INTElli_black
//this.backcolor = INTELLI_white
//END --- NM 05/15/2012

//BEGIN---Add by Evan 11/11/2008
//this.Move(64, 1240)
//this.Resize(1193, 236)
//END---Add by Evan 11/11/2008

If appeongetclienttype() = 'WEB' Then  st_version.y = workspaceheight() - st_version.height + 16 //Walkaround for WEB version, Added by Appeon long.zhang 02.24.2016 (BugL022401)
end event

type cbx_remember from checkbox within w_logon_screen_15
boolean visible = false
integer x = 2665
integer y = 1716
integer width = 475
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 8388608
string text = "Remember me"
end type

