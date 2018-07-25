$PBExportHeader$w_logon_org.srw
forward
global type w_logon_org from w_response
end type
type p_save from picture within w_logon_org
end type
type p_i5 from picture within w_logon_org
end type
type p_i4 from picture within w_logon_org
end type
type p_i3 from picture within w_logon_org
end type
type p_i2 from picture within w_logon_org
end type
type p_i1 from picture within w_logon_org
end type
type st_program from statictext within w_logon_org
end type
type r_2 from rectangle within w_logon_org
end type
type shl_website from statichyperlink within w_logon_org
end type
type st_version from statictext within w_logon_org
end type
type sle_pwtestdb from singlelineedit within w_logon_org
end type
type sle_pwtest from singlelineedit within w_logon_org
end type
type cbx_1 from checkbox within w_logon_org
end type
type cb_1 from statictext within w_logon_org
end type
type cb_2 from statictext within w_logon_org
end type
type sle_user_id from singlelineedit within w_logon_org
end type
type st_1 from statictext within w_logon_org
end type
type sle_password from singlelineedit within w_logon_org
end type
type st_2 from statictext within w_logon_org
end type
type cb_ok from u_cb within w_logon_org
end type
type cb_22 from u_cb within w_logon_org
end type
type cb_3 from commandbutton within w_logon_org
end type
type rb_test from radiobutton within w_logon_org
end type
type rb_tutor from radiobutton within w_logon_org
end type
type rb_prod from radiobutton within w_logon_org
end type
type p_logo from picture within w_logon_org
end type
type p_1 from picture within w_logon_org
end type
end forward

global type w_logon_org from w_response
integer x = 1184
integer y = 716
integer width = 3264
integer height = 2480
string title = "IntelliSoft Login"
boolean controlmenu = false
long backcolor = 16777215
p_save p_save
p_i5 p_i5
p_i4 p_i4
p_i3 p_i3
p_i2 p_i2
p_i1 p_i1
st_program st_program
r_2 r_2
shl_website shl_website
st_version st_version
sle_pwtestdb sle_pwtestdb
sle_pwtest sle_pwtest
cbx_1 cbx_1
cb_1 cb_1
cb_2 cb_2
sle_user_id sle_user_id
st_1 st_1
sle_password sle_password
st_2 st_2
cb_ok cb_ok
cb_22 cb_22
cb_3 cb_3
rb_test rb_test
rb_tutor rb_tutor
rb_prod rb_prod
p_logo p_logo
p_1 p_1
end type
global w_logon_org w_logon_org

type variables
Integer il_attempts  //Start Code Change ---- 08.02.2007 #V7 maha
integer ii_lock_num
String is_version
string is_mess
constant long INTELLI_PURPLE = RGB(80 ,0, 170)
//constant long INTELLI_PURPLE = RGB(35 ,0, 105)
constant long INTELLI_ORANGE = rgb(255,153,0)
constant long INTELLI_WHITE = rgb(255, 255, 255)
constant long INTELLI_GREY = rgb(175, 175, 175)
constant long INTELLI_black = rgb(0, 0, 0)
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
end prototypes

public function integer of_logon ();/******************************************************************************************************************
**  [PUBLIC]   : of_logon
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [long] failure,success
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: ???
**==================================================================================================================
**  Modification Log
**   Changed By               Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
**  Michael B. Skinner       27  December 2005  										Simplified the function for connecting to the 
**                                                                            Database.
**  Michael B. Skinner        10 January 2005                                 Changed the conect string so that bolbs bigger
**                                                                            then 32767 will be selected. This will override 
**                                                                            pbodbXX.ini file
********************************************************************************************************************/
//Start Code Change ---- 06.19.2007 #V7 maha
//changed to use new connection function
IF of_connect_to_db() = -1 THEN
	return Failure
else
	return Success
end if

//SQLCA.DBMS       = "ODBC"
//SQLCA.Lock       = "RU" // for sql server READ UNCOMMITED - PREVENT LOCKING
//SQLCA.AutoCommit = True
//SQLCA.DBParm     = "ConnectString='DSN=" + gs_odbc + ";UID=dba;PWD=sql',StaticBind=0,DisableBind=1,PBUseProcOwner='Yes',RPCReBind=1,MsgTerse='Yes', " + & 
//																	"DelimitIdentifier='No',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT ',"+ & 
//																	"PBTrimCharColumns='Yes',PBMaxBlobSize = '2147483647' ,PBMaxTextSize = '2147483647'"    
//												
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = 0  THEN 
//	CHOOSE CASE SQLCA.SQLreturndata
//		CASE 'Adaptive Server Anywhere'
//			  gs_dbType = 'ASA'
//		CASE 'Microsoft SQL Server'
//			  gs_dbType = 'SQL'
//		CASE ELSE 
//				f_system_error_handler ('Inital Login Failed!  ' +    SQLCA.sqlerrtext)
//				//SQLCA.sqldbcode
//				Return FAILURE
//	END CHOOSE 
//ELSE 
//	// msskiner 10 March 2006 -- begin
//	// if the database is not runnning - don't tell up about it
//	if sqlca.sqldbcode = -100 then 
//	   messageBOX(title,'The database server is not running. Contact your system administrator' )		
//	else 
//	    f_system_error_handler ('Inital Login Failed!  ' +    SQLCA.sqlerrtext)
//   end if
//	// msskiner 10 March 2006 -- end 
//	//SQLCA.sqldbcode
//	Return FAILURE
//END IF
//
//RETURN SUCCESS
//End Code Change---06.19.2007
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

public function integer of_user_login (integer ai_attempt);//Start Code Change ----03.06.2009 #V92 maha  - added blank role trap and cleaned up code 
//which was making addition unnecessary db hits for the same data.
integer cnt
string ls_passdb
string ls_user
string ls_password
string ls_user_test = ""
string ls_passorg
integer li_ret
integer li_role
integer li_active = 1 ////Start Code Change ----07.16.2009 #V92 maha - initialized to 1 to avoid update issue
datetime ldt_locktime

ls_user = sle_user_id.text
ls_password = sle_password.text
ls_passorg = ls_password
ls_password = in_encrypt.of_encrypt(ls_password)
sle_pwtest.text = ls_password


//get user info
select user_id, user_password, role_id into :ls_user_test, :ls_passdb,  :li_role from security_users where upper(user_id) = upper(:ls_user);
//Start Code Change ----04.10.2009 #V92 maha - added separate query for new fields because upgrades from 6 to 8 caused failure of role test because fields did not exist
select  lock_until, active_status into  :ldt_locktime, :li_active from security_users where upper(user_id) = upper(:ls_user);
gs_user_id = ls_user


//Start Code Change ----04.06.2009 #V92 maha - Ameripath custom
//if upper(ls_user) = "MASTER" then
//	//skip test
//else
//	if li_active = 0 then
//		return -3
//	end if		
//end if
//End Code Change---04.06.2009
		

//lockout check
if upper(ls_user) = "MASTER" then
	//skip test
else
	if ii_lock_num > 0 then
		if ldt_locktime > datetime(today(),now()) then //lockout test
			return -5
		end if
	end if
	sle_pwtestdb.text = ls_passdb
	//check existance of user
	if isnull(ls_user_test) or ls_user_test = "" then //Start Code Change ----05.27.2009 #V92 maha - changed to ls_user_test variable
		messagebox("Login Error","Invalid user name '" + ls_user + "'.  Please check your spelling or the user is not entered into IntelliCred.")
		return -1
	end if
	//Start Code Change ----0515.2009 #V92 maha - check active (ameripath)
	if li_active = 0 then
		return -3
	end if
	//End Code Change---05.15.2009
end if


if upper(ls_user) = "MASTER" then 
	//Start Code Change ----12.29.2008 #V91 maha - changed MASTER password
	if upper(ls_passorg) =  'INTELLIMASTER' then
		messagebox("Login Error","Invalid password for user name MASTER.  The old password is no longer valid past version 8.")
 		return -1
	elseif lower(ls_passorg)  <> "4isg2login" then //Start Code Change ----06.26.2009 #V92 maha - to make password entry easier
		messagebox("Login Error","Invalid password for user name MASTER. ")
 		return -1
	end if
//---------------------------- APPEON END ----------------------------
else

	if isnull(ls_passdb) or ls_passdb = "" then
		li_ret = of_change_password("login")
		if li_ret = -1 then return -1
	elseif ls_passdb = "123" and ls_passorg = '123' then			//Modified by Scofield on 2007-08-21: Add condition "and ls_passorg = '123'"
		li_ret = of_change_password("login")
		if li_ret = -1 then return -1
	else
		if ls_passdb <> ls_password then  //comparing encrypted  pw as entered with value in datatabase
			messagebox("Login Error","Invalid password for user name '" + ls_user + "'.  Please check your spelling.")
			return -1
		end if
	end if
	
	//Start Code Change ----03.06.2009 #V92 maha - added trap for null role
	if isnull(li_role) or li_role = 0 then
		messagebox("Login Error","User name '" + ls_user + "' has no Intellisoft role and may have been setup in Webview only.  This user must be assigned a role in the user painter in order to log in to this program.")
		return -1
	end if
	//End Code Change---03.06.2009
	
end if

//messagebox("","test")
return 1 
//org code 03062009

////created maha 111605 to test for user in user security.
//integer cnt
//string ls_pass
//string ls_user
//string ls_password
//string ls_user_test = ""
//string ls_passorg
//integer li_ret
//datetime ldt_locktime
//
//ls_user = sle_user_id.text
//ls_password = sle_password.text
//ls_passorg = ls_password
//ls_password = in_encrypt.of_encrypt(ls_password)
//sle_pwtest.text = ls_password
////get user info
//if upper(ls_user) = "MASTER" then
//	//skip test
//else
////	Start Code Change ---- 08.02.2007 #V7 maha
//	select user_id, user_password,lock_until into :ls_user_test, :ls_pass, :ldt_locktime from security_users where upper(user_id) = upper(:ls_user);
//	if ii_lock_num > 0 then
//		if ldt_locktime > datetime(today(),now()) then //lockout test
//			return -5
//		end if
//	end if
//
//	select user_id, user_password into :ls_user_test, :ls_pass from security_users where upper(user_id) = upper(:ls_user);
//	//End Code Change---08.02.2007
//	sle_pwtestdb.text = ls_pass
//	//check existance of user
//	if isnull(ls_user_test) or ls_user_test = "" then 
//		messagebox("Login Error","Invalid user name '" + ls_user + "'.  Please check your spelling or the user is not entered into IntelliCred.")
//		return -1
//	end if
//end if
//
//	
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 08/21/2007 By: Ken.Guo
////$<reason> when user input 'master' in sle_user_id , the gs_user_id is set to 'master', but in DB it maybe is 'MASTER' .  
//select user_id into :gs_user_id from security_users where upper(user_id) = upper(:ls_user);
////---------------------------- APPEON END ----------------------------
//
////
////check PASSWORD
////--------------------------- APPEON BEGIN ---------------------------
////$<modified> 2005-11-23 By: Zhang Lingping
////$<reason>1. The password for user 'Master' has been encrypted. the process 
////$<reason> for check need  encrypt password too.
////$<reason>2.If the password for user 'MASTER' is invalid, the application 
////$<reason> should halt().
//
//if upper(ls_user) = "MASTER" then
//	//Start Code Change ----12.29.2008 #V91 maha - changed MASTER password
//	if upper(ls_passorg) =  'INTELLIMASTER' then
//		messagebox("Login Error","Invalid password for user name MASTER.  The old password is no longer valid past version 8.")
// 			return -1
//	//if upper(ls_passorg) <> Upper(SUPER_MASTER_PASSWORD) then
//	elseif ls_passorg <> SUPER_MASTER_PASSWORD then
//	//End Code Change---12.09.2008
//	//maha remodified 121305 // this login always uses this password and bypasses normal security
//		messagebox("Login Error","Invalid password for user name MASTER. ")
// 			return -1
//	end if
////---------------------------- APPEON END ----------------------------
//else
//	if isnull(ls_pass) or ls_pass = "" then
//		li_ret = of_change_password("login")
//		if li_ret = -1 then return -1
//	elseif ls_pass = "123" and ls_passorg = '123' then			//Modified by Scofield on 2007-08-21: Add condition "and ls_passorg = '123'"
//		li_ret = of_change_password("login")
//		if li_ret = -1 then return -1
//	else
//		if ls_pass <> ls_password then
//			messagebox("Login Error","Invalid password for user name '" + ls_user + "'.  Please check your spelling.")
//			return -1
//		end if
//	end if
//end if
//
////messagebox("","test")
//return 1 
end function

public function integer of_log_connection (string as_pass);//function created maha 11-21-05 to track login attempts for future development
//Start Code Change ---- 10.05.2006 #1 maha changed table name updated.
time lt_time = now()

datetime ldt_date
string ls_password

ldt_date = datetime(today(),now())
 
if as_pass = "FAIL"  or as_pass = "LOCK" or as_pass = "INACTIVE"   then //Start Code Change ----04.06.2009 #V92 maha - added inactive for ameripath
	if upper(gs_user_id) = "MASTER" then  //Start Code Change ---- 03.13.07.2007 #V7 maha
		ls_password = "********"  
	else
		ls_password = gs_password
	end if
else //if pass don't log the password
	ls_password = "********"
	
	update security_users set last_login_date = :ldt_date where user_id = :gs_user_id; //Start Code Change ----05.15.2009 #V92 maha - added for ameripath
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_autocommit()
//---------------------------- APPEON END ----------------------------
insert into security_login_tracking (user_id,user_password,log_date,pass_fail,client_ip) values (:gs_user_id,:ls_password,:ldt_date,:as_pass,:gs_client_ip); //Evan 08.26.2009 --- Audit Client IP
commit using sqlca;
//End Code Change---10.05.2006

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

this.Resize(3770, 2476)
p_1.Move(0, -10)
p_1.Resize(3749, 2400)

sle_user_id.X = 1150
sle_password.X = sle_user_id.X
sle_user_id.Y = 1230
sle_password.Y = sle_user_id.Y + 168

st_1.X = sle_user_id.X
st_2.X = sle_user_id.X
st_1.Y = sle_user_id.Y - st_1.Height - 4
st_2.Y = sle_password.Y - st_2.Height - 4
st_1.Text = "Username"
st_1.TextColor = RGB(66,66,66)
st_2.TextColor = RGB(66,66,66)
st_1.BackColor = RGB(244,245,245)
st_2.BackColor = RGB(244,245,245)

cb_2.X = sle_user_id.X
cb_1.X = sle_user_id.X + cb_2.Width + 4
cb_2.Y = sle_password.Y + 150
cb_1.Y = cb_2.Y
cb_1.Text = "&Login"
cb_1.TextColor = RGB(248,251,246)
cb_2.TextColor = RGB(248,251,246)
cb_1.BackColor = RGB(134,196,64)
cb_2.BackColor = RGB(134,196,64)

rb_test.X = sle_user_id.X + sle_user_id.Width + 250
rb_test.Y = sle_user_id.Y
rb_prod.X = rb_test.X
rb_prod.Y = rb_test.Y + 100
rb_tutor.X = rb_test.X
rb_tutor.Y = rb_prod.Y + 100
rb_test.TextColor = RGB(244,245,245)
rb_prod.TextColor = RGB(244,245,245)
rb_tutor.TextColor = RGB(244,245,245)
rb_test.BackColor = RGB(42,134,199)
rb_prod.BackColor = RGB(42,134,199)
rb_tutor.BackColor = RGB(42,134,199)

st_version.X = 832
st_version.Y = 1880
st_version.Resize(1486, 152)
st_version.TextColor = RGB(198,216,229)
st_version.BackColor = RGB(42,134,199)
st_version.Alignment = Left!
st_version.Show()

shl_website.X = 841
shl_website.Y = 2068
shl_website.Resize(1330, 68)
shl_website.TextColor = RGB(18,58,87)
shl_website.BackColor = RGB(42,134,199)
shl_website.Show()

Return 1
end function

on w_logon_org.create
int iCurrent
call super::create
this.p_save=create p_save
this.p_i5=create p_i5
this.p_i4=create p_i4
this.p_i3=create p_i3
this.p_i2=create p_i2
this.p_i1=create p_i1
this.st_program=create st_program
this.r_2=create r_2
this.shl_website=create shl_website
this.st_version=create st_version
this.sle_pwtestdb=create sle_pwtestdb
this.sle_pwtest=create sle_pwtest
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.sle_user_id=create sle_user_id
this.st_1=create st_1
this.sle_password=create sle_password
this.st_2=create st_2
this.cb_ok=create cb_ok
this.cb_22=create cb_22
this.cb_3=create cb_3
this.rb_test=create rb_test
this.rb_tutor=create rb_tutor
this.rb_prod=create rb_prod
this.p_logo=create p_logo
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_save
this.Control[iCurrent+2]=this.p_i5
this.Control[iCurrent+3]=this.p_i4
this.Control[iCurrent+4]=this.p_i3
this.Control[iCurrent+5]=this.p_i2
this.Control[iCurrent+6]=this.p_i1
this.Control[iCurrent+7]=this.st_program
this.Control[iCurrent+8]=this.r_2
this.Control[iCurrent+9]=this.shl_website
this.Control[iCurrent+10]=this.st_version
this.Control[iCurrent+11]=this.sle_pwtestdb
this.Control[iCurrent+12]=this.sle_pwtest
this.Control[iCurrent+13]=this.cbx_1
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.sle_user_id
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.sle_password
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.cb_ok
this.Control[iCurrent+21]=this.cb_22
this.Control[iCurrent+22]=this.cb_3
this.Control[iCurrent+23]=this.rb_test
this.Control[iCurrent+24]=this.rb_tutor
this.Control[iCurrent+25]=this.rb_prod
this.Control[iCurrent+26]=this.p_logo
this.Control[iCurrent+27]=this.p_1
end on

on w_logon_org.destroy
call super::destroy
destroy(this.p_save)
destroy(this.p_i5)
destroy(this.p_i4)
destroy(this.p_i3)
destroy(this.p_i2)
destroy(this.p_i1)
destroy(this.st_program)
destroy(this.r_2)
destroy(this.shl_website)
destroy(this.st_version)
destroy(this.sle_pwtestdb)
destroy(this.sle_pwtest)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.sle_user_id)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.st_2)
destroy(this.cb_ok)
destroy(this.cb_22)
destroy(this.cb_3)
destroy(this.rb_test)
destroy(this.rb_tutor)
destroy(this.rb_prod)
destroy(this.p_logo)
destroy(this.p_1)
end on

event open;call super::open;integer setprod
integer li_testbox
integer li_rand //maha 072409
string pspath
String ls_dev
blob lb_splash_pic
integer li_banner //maha 040109

string ls_original_dev_setting

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
/*
select set_24 into :li_testbox from icred_settings; //maha123102
select set_9 into :setprod from icred_settings; //maha031705
*/
gnv_appeondb.of_startqueue()
select set_24 into :li_testbox from icred_settings; //maha123102
select set_9 into :setprod from icred_settings; //maha031705
select login_lockout into :ii_lock_num from security_settings; //Start Code Change ---- 08.02.2007 #V7 maha
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------
if isnull(ii_lock_num) then ii_lock_num = 0  //Start Code Change ---- 08.02.2007 #V7 maha

//login screen format changes
//Start Code Change ----06.25.2009 #V92 maha - additional text changes
if setprod = 1 then
//	this.title = "IntelliApp Logon"
//	p_1.picturename= "IntelliApp-Splash.gif" 
	IF appeongetclienttype() = 'WEB' THEN
		st_program.text = "IntelliApp Renaissance for Web" 
	else
		st_program.text = "IntelliApp Renaissance for Windows" 
	end if
	
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-17 By: Rodger Wu
elseif setprod = 4 then
//	this.title = "IntelliContract Logon"
//	p_1.picturename= "IntelliContract-Splash.gif" 
//---------------------------- APPEON END ----------------------------
//	of_IntelliContractLayout() //Add by Evan 11/10/2008
	IF appeongetclienttype() = 'WEB' THEN
		st_program.text = "IntelliContract Renaissance for Web" 
	else
		st_program.text = "IntelliContract Renaissance for Windows" 
	end if
else
//	this.title = "IntelliCred Logon"
//	p_1.picturename= "IntelliCred-Splash.gif"
	IF appeongetclienttype() = 'WEB' THEN
		st_program.text = "IntelliCred Renaissance for Web"
	else
		st_program.text = "IntelliCred Renaissance for Windows" 
	end if
end if

//Start Code Change ----07.24.2009 #V92 maha
randomize(0)
li_rand = Rand(5)
choose case li_rand
	case 1
		p_i1.visible = true
	case 2
		p_i2.visible = true
	case 3
		p_i3.visible = true
	case 4
		p_i4.visible = true
	case 5
		p_i5.visible = true
end choose
//End Code Change---07.24.2009

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

if li_banner = 1 then
	open(w_security_banner)
	if message.stringparm = "Cancel" then 
		close (this)
		Halt
	end if
end if
//End Code Change---04.01.2009


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
if gb_IsAutoExpImp  or gb_AutoSchedule then	//Modified by Nova 12.29.2009 -v10.1 Scheduler Functionality 
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
End If
//---------------------------- APPEON END ----------------------------
end event

event pfc_preopen;call super::pfc_preopen;if gb_IsAutoExpImp or gb_AutoSchedule then this.Hide()//Modified by Nova 12.29.2009 -v10.1 Scheduler Functionality  //Added by Evan 03.12.2009
end event

type p_save from picture within w_logon_org
boolean visible = false
integer x = 73
integer y = 1812
integer width = 343
integer height = 400
string picturename = "vert_man.jpg"
boolean focusrectangle = false
end type

type p_i5 from picture within w_logon_org
boolean visible = false
integer x = 2098
integer y = 1452
integer width = 343
integer height = 400
string picturename = "vert_man.jpg"
boolean focusrectangle = false
end type

type p_i4 from picture within w_logon_org
boolean visible = false
integer x = 837
integer y = 1444
integer width = 343
integer height = 400
string picturename = "mona-lisa-frame.bmp"
boolean focusrectangle = false
end type

type p_i3 from picture within w_logon_org
boolean visible = false
integer x = 55
integer y = 1024
integer width = 343
integer height = 400
string picturename = "mona-lisa-frame.bmp"
boolean focusrectangle = false
end type

type p_i2 from picture within w_logon_org
boolean visible = false
integer x = 2807
integer y = 1020
integer width = 343
integer height = 400
string picturename = "mona-lisa-frame.bmp"
boolean focusrectangle = false
end type

type p_i1 from picture within w_logon_org
boolean visible = false
integer x = 1925
integer y = 4
integer width = 343
integer height = 400
string picturename = "vert_man.jpg"
boolean focusrectangle = false
end type

type st_program from statictext within w_logon_org
integer y = 1156
integer width = 3255
integer height = 140
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Papyrus"
long backcolor = 33554431
string text = "IntelliCred Renaissance"
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

event constructor;this.backcolor = INTELLI_PURPLE
this.textcolor = INTELLI_orange

//BEGIN---Add by Evan 11/11/2008
//this.Move(64, 1240)
//this.Resize(1193, 236)
//END---Add by Evan 11/11/2008
end event

type r_2 from rectangle within w_logon_org
long linecolor = 8388608
integer linethickness = 4
long fillcolor = 16777215
integer x = -5
integer y = 1172
integer width = 3269
integer height = 1228
end type

type shl_website from statichyperlink within w_logon_org
boolean visible = false
integer x = 3351
integer y = 2304
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

type st_version from statictext within w_logon_org
integer y = 2316
integer width = 3255
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bodoni MT"
boolean italic = true
long backcolor = 33554431
string text = "Product Version"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;this.backcolor = INTELLI_PURPLE
this.textcolor = INTELLI_orange

//BEGIN---Add by Evan 11/11/2008
//this.Move(64, 1240)
//this.Resize(1193, 236)
//END---Add by Evan 11/11/2008
end event

type sle_pwtestdb from singlelineedit within w_logon_org
boolean visible = false
integer x = 3291
integer y = 2192
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

type sle_pwtest from singlelineedit within w_logon_org
boolean visible = false
integer x = 3296
integer y = 2092
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

type cbx_1 from checkbox within w_logon_org
boolean visible = false
integer x = 1531
integer y = 2672
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

type cb_1 from statictext within w_logon_org
integer x = 1253
integer y = 1772
integer width = 352
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Papyrus"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 67108864
string text = "&OK"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;

cb_ok.TRIGGERevent( CLICKED!)
end event

event constructor;//this.backcolor = rgb(0,255,0)
//THIS.textcolor = rgb(0,0,0)

//this.backcolor = intelli_grey
//THIS.textcolor = INTELLI_black
this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_ORANGE
end event

type cb_2 from statictext within w_logon_org
integer x = 1627
integer y = 1772
integer width = 352
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Papyrus"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Cancel"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;is_mess = "Cancel"
w_logon_screen.triggerevent(close! )
//CloseWithReturn( Parent, is_mess )
end event

event constructor;this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_ORANGE

//this.backcolor = rgb(255,0,0)
//THIS.textcolor = rgb(0,0,0)
end event

type sle_user_id from singlelineedit within w_logon_org
integer x = 1253
integer y = 1484
integer width = 713
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
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

type st_1 from statictext within w_logon_org
integer x = 1253
integer y = 1408
integer width = 361
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Papyrus"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "User ID"
boolean focusrectangle = false
end type

event constructor;this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_orange
end event

type sle_password from singlelineedit within w_logon_org
integer x = 1253
integer y = 1648
integer width = 709
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.text = ""
end event

type st_2 from statictext within w_logon_org
integer x = 1253
integer y = 1580
integer width = 357
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Papyrus"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Password"
boolean focusrectangle = false
end type

event constructor;this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_orange
end event

type cb_ok from u_cb within w_logon_org
integer x = 3831
integer y = 1412
integer height = 84
integer taborder = 30
boolean bringtotop = true
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
		halt
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
		HALT
	elseif il_attempts =  ii_lock_num then //08.02.2007 #V7 maha
		of_log_connection("LOCK")
		messagebox("Login Error","You have reached the maximum number of attempts and will be locked out.  Closing Program")
		select lockout_min into :li_lock from security_settings;
		lt_time = now()
		lt_time = RelativeTime ( lt_time, li_lock  * 60 )
		ldt_lock = datetime(today(),lt_time)
		update security_users set lock_until = :ldt_lock where user_id = :gs_user_id;
		commit using sqlca;
		HALT
	ELSE  
//		if gi_test_database > 0 then //maha removed 8.2.07 should not connect to prod database if test fails
//			of_logon() //reconnect to the production database
//		end if
		Return
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
END IF
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
w_logon_screen.triggerevent(close!)

end event

type cb_22 from u_cb within w_logon_org
integer x = 3826
integer y = 1508
integer height = 84
integer taborder = 40
boolean bringtotop = true
string pointer = "HyperLink!"
string text = "Cancel"
boolean cancel = true
end type

event clicked;is_mess = "Cancel"
w_logon_screen.triggerevent(close! )
//CloseWithReturn( Parent, is_mess )
end event

event constructor;call super::constructor;//this.  backcolor =  rgb(171, 130, 255)
end event

type cb_3 from commandbutton within w_logon_org
boolean visible = false
integer x = 3872
integer y = 1604
integer width = 91
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "U1"
end type

event clicked;sle_user_id.text = "user1"
sle_password.text = "123"
cb_1.triggerevent(clicked!)
end event

type rb_test from radiobutton within w_logon_org
integer x = 1257
integer y = 1892
integer width = 997
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Papyrus"
long textcolor = 33554432
long backcolor = 67108864
string text = "Connect to Test Database "
end type

event constructor;this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_ORANGE
end event

type rb_tutor from radiobutton within w_logon_org
integer x = 1257
integer y = 2076
integer width = 1079
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Papyrus"
long textcolor = 33554432
long backcolor = 67108864
string text = "Connect to Tutorial Database "
end type

event constructor;this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_ORANGE
end event

type rb_prod from radiobutton within w_logon_org
integer x = 1257
integer y = 1988
integer width = 1161
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Papyrus"
long textcolor = 33554432
long backcolor = 67108864
string text = "Connect to Production Database "
boolean checked = true
end type

event constructor;this.backcolor = INTELLI_PURPLE
THIS.textcolor = INTELLI_ORANGE
end event

type p_logo from picture within w_logon_org
integer width = 3259
integer height = 2324
boolean enabled = false
string picturename = "isg logo92.bmp"
end type

type p_1 from picture within w_logon_org
boolean visible = false
integer y = 576
integer width = 859
integer height = 384
string picturename = "C:\ISGDev\ver9.2\isg gif graphictop.gif"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

