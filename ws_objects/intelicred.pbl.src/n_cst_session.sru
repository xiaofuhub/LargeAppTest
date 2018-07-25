$PBExportHeader$n_cst_session.sru
forward
global type n_cst_session from nonvisualobject
end type
end forward

global type n_cst_session from nonvisualobject
end type
global n_cst_session n_cst_session

type variables
String is_create = 'CREATE'
String is_update = 'UPDATE'
String is_delete = 'DELETE'

Integer ii_license_readonly_users_cnt
Integer ii_license_full_users_cnt
Integer ii_session_refresh_frequency  //Unit: Minute

String is_license_key

end variables

forward prototypes
public function string of_generate_session_id ()
public function integer of_delete_current_session ()
public function string of_get_err_msg (integer ai_err_number)
public function integer of_create_session ()
public subroutine of_set_session_refresh_time (integer ai_value)
public function integer of_update_current_session ()
end prototypes

public function string of_generate_session_id ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_session::of_generate_session_id()
// $<arguments>(None)
// $<returns> string
// $<description>
// $<description> Generate Session ID
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-26 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_random,ls_session_id
Long ll_sum,ll_exist
Long ll_rand1,ll_rand2,ll_rand3
Int li_randomize
Do While 1 > 0 
	If ll_sum >= 10 Then Return ''
	li_randomize = Integer(String(Today(),'fff')) + ll_sum
	Randomize (li_randomize)
	ll_rand1 = Rand(30000)
	ll_rand2 = Rand(ll_rand1)
	ll_rand3 = Rand(li_randomize)
	ls_random = String(ll_rand1+ll_rand2+ll_rand3,'00000')
	ls_session_id = String(today(),'yymmddhhmmssfff') +ls_random 
	ls_session_id = LeftA(ls_session_id, 20) //alfee 08.03.2009
	
	Select count(*) into :ll_exist From session_info Where session_id = :ls_session_id;
	If ll_exist = 0 Then Exit
	ll_sum++
Loop

Return ls_session_id

end function

public function integer of_delete_current_session ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_session::of_delete_current_session()
// $<arguments>(None)
// $<returns> integer
// $<description> 
// $<description> Delete current Session
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-26 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int li_cnt_current_session

If Gs_session_id = '' Then Return -1 

//Gnv_appeondb.of_startqueue() - commented by alfee 06.25.2009
DECLARE lup_update_session PROCEDURE FOR up_update_session  
          :gs_session_id,   
          :gs_user_id,  
			 :gs_client_ip,
          :is_delete  ;
EXECUTE lup_update_session;

//Check Session
Select Count(*) Into :li_cnt_current_session From session_info where session_id = :gs_session_id;

//Commit;
//Gnv_appeondb.of_commitqueue() - commented by alfee 06.25.2009

If li_cnt_current_session <> 0 Then Return -31
Return 1
end function

public function string of_get_err_msg (integer ai_err_number);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_sessionof_get_err_msg()
// $<arguments>
//		value	integer	ai_err_number		
// $<returns> string
// $<description>
// $<description> Error Information
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-26 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Choose Case ai_err_number
	Case -100
		Return 'The application has no license key, please enter it.'
		//called from of_create session in app_filler
	Case -101
		Return 'The application has an invalid license key, please re-enter it.'
	Case -11
		Return 'Failed to generate session ID, please try again later.'
	Case -12
		Return 'Failed to create session, please call support.'
	Case -21
		Return 'Failed to update session, please call support.'
	Case -31
		Return 'Failed to delete the current session.'
	Case -8
		Return 'The maximum number of read-only users are currently logged into the system. Please try later or contact IntelliSoft Group to purchase additional licenses.'
	Case -9
		Return 'The maximum number of full-access users are currently logged into the system. Please try later or contact IntelliSoft Group to purchase additional licenses.'
	Case -13 //Start Code Change ----04.06.2009 #V92 maha - unique user for ameripath custom (moved up - alfee 06.25.2009)
		return 'User ' + gs_user_id + ' is currently logged into the system.  System Settings require unique logins.' 
	Case is < 0
		Return 'Failed to update session, please call support.'
End Choose
end function

public function integer of_create_session ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_session::of_create_session()
// $<arguments>(None)
// $<returns> integer
// $<description> 
// $<description> Create Session
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-26 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Datetime ldt_date
Integer li_cnt_current_session
Integer li_readonly_users_cnt,li_full_users_cnt
integer li_unique, li_user_cnt //maha 04.06.2009
integer ccc
String ls_create
String ls_sb,ls_sc,ls_sd,ls_se,ls_sf,ls_sg,ls_sh,ls_si,ls_sj,ls_sk
string ls_lic  //maha 07.17.2013

//Get Session Id
gs_session_id = This.of_generate_session_id()
If gs_session_id = '' Then Return -11 //Failed to get session id.

if gb_cvo_user = false then //(Appeon)Stephen 03.23.2017 - add gb_cvo_user  judge--V15.3 Bug # 5568 - Issue with CVO user session bypass
	DECLARE lup_update_session PROCEDURE FOR up_update_session 
		:gs_session_id, 
		:gs_user_id, 
		:gs_client_ip,
		:is_create;
	EXECUTE lup_update_session;
end if

gnv_appeondb.of_startqueue()

Select license_info,session_refresh_frequency into :is_license_key,:ii_session_refresh_frequency from icred_settings;

Select Count(*) Into :li_cnt_current_session From session_info where session_id = :gs_session_id;

Select count(*) Into :li_readonly_users_cnt From session_info,security_users 
	Where session_info.user_id = security_users.user_id and security_users.readonly = 1;

Select count(*) Into :li_full_users_cnt From session_info,security_users 
	Where session_info.user_id = security_users.user_id and security_users.readonly = 0;

// Start Code Change ----04.06.2009 #V92 maha - unique user for ameripath custom
select unique_user into :li_unique from security_settings;

//-----Begin Modified by Alfee 06.25.2009 -----------------
Select Count(*) Into :li_user_cnt From session_info where upper(user_id) = upper(:gs_user_id);
/* if li_unique = 1 then
	Select Count(*) Into :li_user_cnt From session_info where upper(user_id) = upper(:gs_user_id);
	if li_user_cnt > 0 then
		return -13
	end if
end if */
//------End Modified ----------------------------------------
//End Code Change---04.06.2009 

//commit; - commented by alfee 07.30.2009

gnv_appeondb.of_commitqueue()

If li_unique = 1 And li_user_cnt > 1 Then Return -13  //alfee 06.25.2009

//If No license Key
If is_license_key = '' Or Isnull(is_license_key) Then 
	Return -100 
End If
//debugbreak()
//Check license Key
//Start Code Change ----07.17.2013 #V14 maha - allow validation of 090 and 140 license keys
ls_lic = of_strip_char(" ",is_license_key , "")
ls_lic = mid( is_license_key ,4,3)

if ls_lic = '090' then
	If f_license_check(is_license_key,ls_sb,ls_sc,ls_sd,ls_se,ls_sf,ls_sg,ls_sh) < 0 Then 
		Return -101
	end if
elseif ls_lic = '140' then
	ccc =  f_license_check_v14(is_license_key,ls_sb,ls_sc,ls_sd,ls_se,ls_sf,ls_sg,ls_sh,ls_si,ls_sj,ls_sk) 
	If ccc < 0 Then 
		Return -101
	end if
else
	Return -101
End If

If ii_session_refresh_frequency = 0 Or Isnull(ii_session_refresh_frequency) Then
	ii_session_refresh_frequency = 3 //Default 3 minutes
End If

ii_license_full_users_cnt = Integer(MidA(is_license_key,8,3))
ii_license_readonly_users_cnt = Integer(MidA(is_license_key,15,3))

//Failed to create session 
If li_cnt_current_session <> 1 Then 
	Gs_session_id = ''
	//Return -12 - commented by alfee 08.03.2009
End If

//Great than full users count defined by license.
If li_full_users_cnt > ii_license_full_users_cnt Then
	Return -9
End If

//Great than readonly users count defined by license.
If li_readonly_users_cnt > ii_license_readonly_users_cnt Then
	Return -8
End If

Return 1
end function

public subroutine of_set_session_refresh_time (integer ai_value);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_sessionof_set_session_refresh_time()
// $<arguments>
//		value	integer	ai_value		
// $<returns> (none)
// $<description>
// $<description> Only for a Interface
//////////////////////////////////////////////////////////////////////
// $<add> 08.26.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

ii_session_refresh_frequency = ai_value

end subroutine

public function integer of_update_current_session ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_sessionof_update_session()
// $<arguments>
//		value	string	as_session_id		
// $<returns> integer
// $<description>
// $<description> Update Session. 
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-26 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Datetime ldt_date
Int li_cnt_current_session

If gs_session_id = '' Then Return -1
if gb_cvo_user = true then Return 1 //(Appeon)Stephen 03.23.2017 - add gb_cvo_user  judge--V15.3 Bug # 5568 - Issue with CVO user session bypass

gnv_appeondb.of_startqueue()
DECLARE lup_update_session PROCEDURE FOR up_update_session  
			:gs_session_id,   
			:gs_user_id,   
			:gs_client_ip,
			:is_update  ;
EXECUTE lup_update_session;

//Check Session
Select Count(*) Into :li_cnt_current_session From session_info where session_id = :gs_session_id;
Commit;
gnv_appeondb.of_commitqueue()

If li_cnt_current_session <> 1 Then 
	Return -21 
End If

Return 1

end function

on n_cst_session.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_session.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

