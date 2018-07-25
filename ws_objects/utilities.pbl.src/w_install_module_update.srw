$PBExportHeader$w_install_module_update.srw
forward
global type w_install_module_update from window
end type
type cb_bypass from commandbutton within w_install_module_update
end type
type dw_agree from datawindow within w_install_module_update
end type
type st_5 from statictext within w_install_module_update
end type
type st_4 from statictext within w_install_module_update
end type
type sle_co from singlelineedit within w_install_module_update
end type
type sle_name from singlelineedit within w_install_module_update
end type
type rb_2 from radiobutton within w_install_module_update
end type
type rb_1 from radiobutton within w_install_module_update
end type
type st_3 from statictext within w_install_module_update
end type
type dw_set from datawindow within w_install_module_update
end type
type st_2 from statictext within w_install_module_update
end type
type st_progress from statictext within w_install_module_update
end type
type st_1 from statictext within w_install_module_update
end type
type sle_1 from singlelineedit within w_install_module_update
end type
type cb_4 from commandbutton within w_install_module_update
end type
type cb_cancel from commandbutton within w_install_module_update
end type
type cb_run from commandbutton within w_install_module_update
end type
type gb_1 from groupbox within w_install_module_update
end type
type r_print_stat_border from rectangle within w_install_module_update
end type
type r_bar from rectangle within w_install_module_update
end type
end forward

global type w_install_module_update from window
integer x = 123
integer y = 112
integer width = 3429
integer height = 2904
boolean titlebar = true
string title = "IntelliSoft License Key"
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
event sys_close pbm_syscommand
cb_bypass cb_bypass
dw_agree dw_agree
st_5 st_5
st_4 st_4
sle_co sle_co
sle_name sle_name
rb_2 rb_2
rb_1 rb_1
st_3 st_3
dw_set dw_set
st_2 st_2
st_progress st_progress
st_1 st_1
sle_1 sle_1
cb_4 cb_4
cb_cancel cb_cancel
cb_run cb_run
gb_1 gb_1
r_print_stat_border r_print_stat_border
r_bar r_bar
end type
global w_install_module_update w_install_module_update

type variables
string is_type
boolean ib_new = false //maha 02.13.2012
end variables

forward prototypes
public function integer modupdate (string ai_type)
public function integer of_failure (string as_s)
public function integer of_check (string as_val)
public function integer of_run_license ()
public subroutine of_refresh_module ()
public function integer of_subscription (string as_key)
public function integer of_add_agreement ()
public function integer of_set_4_smart (boolean ab_smart)
public function integer of_run_license_14 ()
end prototypes

event sys_close;//Trigger it if clicked close button on titlebar.
If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

public function integer modupdate (string ai_type);integer i


	r_bar.width = 1
//r_print_stat_border
//li_bar_ticks = 100

for i = 1 to 1000
	if mod(1,0) = 0 then
		r_bar.Width = r_bar.Width + 14
	end if
	if i =  50 then
		if ai_type = "EXP" then
			update ids set set_19 = 1;
		end if
		if ai_type = "APP" then
			update ids set set_19 = 1;
		end if
		if ai_type = "REP" then
			update ids set set_19 = 1;
		end if
	end if
next








return 1
end function

public function integer of_failure (string as_s);

messagebox("Update Failure " + as_s,"Invalid serial number.  Please check that it is entered correctly with no spaces or dashes.")
return 1
end function

public function integer of_check (string as_val);if not isnumber(as_val) then
	of_failure("")
	return -1
else
	return 1
end if

end function

public function integer of_run_license ();//Start Code Change ----05.28.2008 #V8 maha - added function for functionality change in 8.5
//used versions 9 through 12.3
integer i
integer ic
integer li_bar_ticks
integer li_mod
long ll_sum
string s
string sa
string sb = 'x'
string sc = 'x'
string sd = 'x'
string se = 'x'
string srrr = 'x'
string sf = 'x'
string sg = 'x' 
string sh = 'x' 
string si = 'x'
string si2 = 'x'
string ls_org
Integer li_check_ret
debugbreak()

//Start Code Change ----08.25.2010 #V10 maha - modified for subscription
s = sle_1.text
s = of_strip_char(" ", s,"")
s = of_strip_char("-", s,"") //Start Code Change ----03.29.2011 #V11 maha  - strip the dash

ls_org = s
if is_type = "S" then
	i = of_subscription(s )
	return i
end if
//the key code is created in the support program logic of_keycode_8 (minicontact.pbl)
//ISG 0800 aaabcde rrrfghii

//number of full users		aaa
//app						b	7,5,4,2
//image					b	--
//install imaging			c	9,1		
//priv						d	8,6,4,0
//webview					d	--
//report					e	9,5,3,1
//export					e	--
//read only users			rrr
//contract					f	7,6,4,2
//qa						f	--
//peer						h	9,4,3,1
//site						h	--
//program					g	9,8,7
//checksum 1 and 2		 ii

//logic changed 10-29-08
//ISG 0900 aaabcde rrrfghii

//number of users		aaa
//app					b	7,5,4,2
//image				b	--
//install imaging		c	9,1		
//priv					d	9,8,7,6,5,4,3,0
//webview				d	--
//workflow				d	--
//report				e	9,8,7,6,5,4,3,0
//export				e	--
//import 				e	--
//read only users		rrr
//contract				f	9,8,7,6,5,4,3,0
//qa					f	--
//contact create		f	--
//peer					h	9,4,3,1
//site					h	--
//program				g	9,8,7
//checksum (programs)	i
//checksum2	(users)		i2

//m1 = 9,8,7,6
//m2 = 9,8,5,4
//m3 = 9,7,5,3

//ISG 1400 aaabcde rrrfghjklii

//number of users		aaa
//app						b	7,5,4,2
//image					b	--
//install imaging		c	9,1		
//priv					d	9,8,7,6,5,4,3,0
//webview				d	--
//workflow				d	--
//report					e	9,8,7,6,5,4,3,0
//export					e	--
//import 				e	--
//read only users		rrr
//contract				f	9,8,7,6,5,4,3,0
//qa						f	--
//contact create		f	--
///////peer	old		h	9,4,3,1
//peer					h  9,8,7,6,5,4,3,0
//site					h	--
//subscription			h  --			//maha 8-2010
//automation		j 	9,0
//call log		k 	9,0
//recruitment		l 	9,0
//program				g	9,8,7,6
//checksum (programs)	i
//checksum2	(users)		i2
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2008-08-26 By: Ken.Guo
//$<reason> Move these check script to f_license_check() function.
//$<reason> In order to session module can call it.

sa = mid(s,8,3)
sb = mid(s,11,1)
sc = mid(s,12,1)
sd = mid(s,13,1)
se = mid(s,14,1)
srrr = mid(s,15,3)
sf = mid(s,18,1)
sg = mid(s,19,1)
sh = mid(s,20,1)
si = mid(s,21,1)
si2 = mid(s,22,1)

li_check_ret = f_license_check(s,sb,sc,sd,se,sf,sg,sh) //intellicred.pbl

If li_check_ret < 0 Then
	Choose Case li_check_ret
		Case -1
			Messagebox("Key Error","Please check License Number and re-enter.  Should be 22 characters.")
			Return -1			
		Case -2
			Messagebox("Key Error","Please check License Number.  If it does not start ISG 090 it is invalid.  Contact customer support for a current license number.")
			Return -1	
		Case -3   //Start Code Change ----08.25.2010 #V10 maha - subscription
			Messagebox("Key Error","Please check License Number.  It Should be 22 characters for license only or 34 characters for license and subscription.")
			Return -1	
		Case -10
			of_failure("")
			Return -1
		Case -11
			Messagebox("Key Error","License Number checksum1 error. ~r~rPlease check that the license number was entered correctly.  ~r~r If so, contact customer support for a current license number.")
			return -1	
		Case -12
			Messagebox("Key Error","License Number checksum2 error. ~r~rPlease check that the license number was entered correctly.  ~r~r If so, contact customer support for a current license number.")
			return -1	
		Case Else
			Messagebox('Key Error','Invalid License number.')
			Return -1
	End Choose
End If
//---------------------------- APPEON END ----------------------------

choose case sb  //app print, imaging
	case "7" 
		dw_set.setitem(1,"set_iapps",1)
		dw_set.setitem(1,"set_img",1)
	case "5"
		dw_set.setitem(1,"set_iapps",1)
		dw_set.setitem(1,"set_img",0)
	case "4"
		dw_set.setitem(1,"set_iapps",0)
		dw_set.setitem(1,"set_img",1)
	case "2"
		dw_set.setitem(1,"set_iapps",0)
		dw_set.setitem(1,"set_img",0)
	case else
		of_failure("B")
		return - 1
end choose

//sc is not a program setting used by the installer for imaging

choose case sd //privileges, webview, workflow
	case "9" 
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",1)
		dw_set.setitem(1,"set_47",1)		
	case "8" 
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",1)
		dw_set.setitem(1,"set_47",0)
	case "7" 
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",0)
		dw_set.setitem(1,"set_47",1)
	case "6"
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",0)
		dw_set.setitem(1,"set_47",0)
	case "5" 
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",1)
		dw_set.setitem(1,"set_47",1)
	case "4"
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",1)
		dw_set.setitem(1,"set_47",0)
	case "3" 
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",0)
		dw_set.setitem(1,"set_47",1)
	case "0"
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",0)
		dw_set.setitem(1,"set_47",0)
	case else
		of_failure("D")
		return -1
end choose
		
choose case se //report, export,import

	case "9" 
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",1)
		if  dw_set.getitemnumber(1,"set_import") = 0 then dw_set.setitem(1,"set_import",2)  //Start Code Change ----08.21.2015 #V15 maha
	case "8" 
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",1)
		dw_set.setitem(1,"set_import",0)
	case "7" 
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",0)
		if  dw_set.getitemnumber(1,"set_import") = 0 then dw_set.setitem(1,"set_import",2)  //Start Code Change ----08.21.2015 #V15 maha
	case "6" 
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",0)
		dw_set.setitem(1,"set_import",0)
	case "5"
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",1)
		if  dw_set.getitemnumber(1,"set_import") = 0 then dw_set.setitem(1,"set_import",2)  //Start Code Change ----08.21.2015 #V15 maha
	case "4" 
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",1)
		dw_set.setitem(1,"set_import",0)
	case "3"
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",0)
		if  dw_set.getitemnumber(1,"set_import") = 0 then dw_set.setitem(1,"set_import",2)  //Start Code Change ----08.21.2015 #V15 maha
	case "0"
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",0)
		dw_set.setitem(1,"set_import",0)
	case else
		of_failure("E")
		return -1
end choose
//m1 = 9,8,7,6
//m2 = 9,8,5,4
//m3 = 9,7,5,3
choose case sf //contracts, qa, contract create (only on if contract is on);  global search(always on for contract)
	case "9" 
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",1)
		dw_set.setitem(1,"set_51",1)
		dw_set.setitem(1,"set_48",1)
	case "8" 
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",1)
		//---------Begin Modified by (Appeon)Harry 06.11.2013 for V141 ISG-CLX--------
		//dw_set.setitem(1,"set_51",0)  //Modified By Ken.Guo 2010-01-27
		dw_set.setitem(1,"set_51",3)
		//---------End Modfiied ------------------------------------------------------
		dw_set.setitem(1,"set_48",1)
	case "7" 
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",0)
		dw_set.setitem(1,"set_51",1)
		dw_set.setitem(1,"set_48",1)
	case "6"
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",0)
		//---------Begin Modified by (Appeon)Harry 06.11.2013 for V141 ISG-CLX--------
		//dw_set.setitem(1,"set_51",0)  //Modified By Ken.Guo 2010-01-27
		dw_set.setitem(1,"set_51",3)
		//---------End Modfiied ------------------------------------------------------
		dw_set.setitem(1,"set_48",1)
	case "5" 
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",1)
		//---------Begin Modified by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
		//dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_51",3) //Modified By Ken.Guo 07/01/2013. Change 0 to 3.
		//---------End Modfiied ------------------------------------------------------
		dw_set.setitem(1,"set_48",0)
	case "4"
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",1)
		//---------Begin Modified by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
		//dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_51",3) //Modified By Ken.Guo 07/01/2013. Change 0 to 3.
		//---------End Modfiied ------------------------------------------------------
		dw_set.setitem(1,"set_48",0)
	case "3" 
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",0)
		//---------Begin Modified by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
		//dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_51",3) //Modified By Ken.Guo 07/01/2013. Change 0 to 3.
		//---------End Modfiied ------------------------------------------------------
		dw_set.setitem(1,"set_48",0)
	case "0"
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",0)
		//---------Begin Modified by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
		//dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_51",3) //Modified By Ken.Guo 07/01/2013. Change 0 to 3.
		//---------End Modfiied ------------------------------------------------------
		dw_set.setitem(1,"set_48",0)
	case else
		of_failure("F")
		return -1
end choose

choose case sg //product
	case "8" 
		dw_set.setitem(1,"set_9",1)
		of_set_4_smart(false) //Start Code Change ----02.13.2012 #V12 maha
	case "9"
		dw_set.setitem(1,"set_9",0)
		of_set_4_smart(false) //Start Code Change ----02.13.2012 #V12 maha
	case "7"
		dw_set.setitem(1,"set_9",4)
		dw_set.setitem(1,"set_cont",1) //Added by Ken.Guo 08.27.2008 Contract product alway can access contract module. 
		of_set_4_smart(false) //Start Code Change ----02.13.2012 #V12 maha
	case "6"
		dw_set.setitem(1,"set_9",5)  //Start Code Change ----08.27.2010 #V10 maha - added for SK
		of_set_4_smart(true)	//Start Code Change ----02.13.2012 #V12 maha - added argument
	case else
		of_failure("G")
		return -1
end choose



choose case sh //peer, site, subscription
	case "9" ,"8"
		dw_set.setitem(1,"set_peer",1)
		dw_set.setitem(1,"set_site",1)
	case "4" ,"7"
		dw_set.setitem(1,"set_peer",1)
		dw_set.setitem(1,"set_site",0)
	case "3" ,"5"
		dw_set.setitem(1,"set_peer",0)
		dw_set.setitem(1,"set_site",1)
	case "1"
		dw_set.setitem(1,"set_peer",0)
		dw_set.setitem(1,"set_site",0)
	case else
		of_failure("H")
		return -1
end choose

//Start Code Change ----06.06.2013 #V14 maha//automation and V14 added mods
dw_set.setitem(1,"set_automation",1)  //this will be turned off for smart below
dw_set.setitem(1,"set_call_log",0)
dw_set.setitem(1,"set_recruit",0)
//EndCode Change ----06.06.2013



choose case sh //subscription
	case "8","7","5"
		update ids set pp_s = 1;
		commit using sqlca;
		is_type = "S"
	case else
		update ids set pp_s = 0;
		commit using sqlca;
		is_type = "L"
end choose

//Start Code Change ----09.01.2010 #V10 maha - sk only switches - regardless of other settings
if sg = "6" then
	dw_set.setitem(1,"set_cont",0)
	dw_set.setitem(1,"set_qa",0)
	dw_set.setitem(1,"set_51",0)
	dw_set.setitem(1,"set_48",0)
	dw_set.setitem(1,"set_import",0)
	dw_set.setitem(1,"set_priv",0)
	dw_set.setitem(1,"set_web",0)
	dw_set.setitem(1,"set_47",0)
	dw_set.setitem(1,"set_peer",0)
	dw_set.setitem(1,"set_site",0)
	dw_set.setitem(1,"set_automation",0)  //Start Code Change ----06.06.2013
end if
//End Code Change ----09.01.2010 #V10 maha

//Full access users
//dw_set.setitem(1,"",integer(sa))

//read only users
//dw_set.setitem(1,"",integer(srrr))

s = left(s,22) //Start Code Change ----08.25.2010 #V10 maha - reset if includes the sub

dw_set.setitem(1,"set_product",0)

dw_set.setitem(1,"license_info",s) //Added by Ken.Guo 08.26.2008


gnv_appeondb.of_autocommitrollback( )
If dw_set.update() = 1 Then
	Commit using SQLCA;
	gnv_session.is_license_key = s 
	of_refresh_module()  
	Return 1
Else
	Rollback using SQLCA;
	Messagebox('Save Error','Failed to save license key, please call support.')
	of_refresh_module() 
	Return -1
End If

//Start Code Change ----08.25.2010 #V10 maha - subscription
if len(ls_org) = 34 then
	string ls_sub
	ls_sub = right(ls_org,12)
	if of_subscription( ls_sub) = 1 then
		is_type = "L"
	end if
end if

if is_type = "LS" then
	st_1.text = "Enter Install Subscription Key and click Run."
	is_type = "SI" //used in close query
end if
//End Code Change ----08.25.2010
	
	
return 1
	
























end function

public subroutine of_refresh_module ();//////////////////////////////////////////////////////////////////// //
// $<function>w_install_module_updateof_refresh()
// $<arguments>(None)
// $<returns> (none)
// $<description> 
// $<description> synchronize module and menu
//////////////////////////////////////////////////////////////////////
// $<add> 08.27.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////


//Copy below script from w_utilities_support.cb_1::Clicked()
Integer li_set_9
Integer li_set_cont

gds_settings.Retrieve()
gnv_data.of_retrieve( "icred_settings" )

li_set_9 = Integer(gnv_data.of_getitem( "icred_settings", "set_9", False))
IF IsNull(li_set_9) THEN li_set_9 = 0
gb_contract_version = li_set_9 = 4

IF IsValid(w_mdi) THEN
	w_mdi.of_setup_security()
END IF

//--------Begin Added by Nova 03.28.2008------------------------
//$reaseon:fixed bug BugG031801(WEB Only P2) BugG031802(WEB Only P2)

li_set_cont = Integer(gnv_data.of_getitem("icred_settings" , "set_cont" , False))
IF li_set_cont = 1 THEN gnv_app.of_setcontraccache_register( )
IF li_set_cont = 1 THEN //Alfee 05.12.2008
	gb_contract_module = True
ELSE
	gb_contract_module = False
END IF
//--------End Added --------------------------------------------------



end subroutine

public function integer of_subscription (string as_key);//Start Code Change ----08.25.2010 #V10 maha - added for subscription update
string res
string ls_years
date d
datetime ld_sub
long ll_days



res = of_validate_sub_key(as_key,"KEY")
debugbreak()
if res = "0" then
	return -1
else //set the expired dates and the subscription switch
	//ls_years = right(res,1) ////Start Code Change ----10.21.2010 #V10 maha - changed so end date is set in key
	//ll_days = 365 * integer(ls_years)
	d = date(left(res,10))
	//d = RelativeDate ( d, ll_days )
	if d < today() then
		messagebox("Subscription key","The expiration date (" + string(d) + ") on the Key entered is not valid past this date.")
		return -1
	end if
	ld_sub = datetime(d,time("00:00:00"))
	update ids set pp_date = :ld_sub, pp_end = :ld_sub, pp_s = 1;
end if


return 1
end function

public function integer of_add_agreement ();string ls_email
string ls_company
string ls_license
long li_id

ls_company = sle_co.text
ls_email = sle_name.text
ls_license = sle_1.text

if len(ls_email) = 0 then
	messagebox("Agreement","Please enter your Email Address")
	setfocus(sle_name)
	return -1
end if

if len(ls_company) = 0 then
	messagebox("Agreement","Please enter your Company Name")
	setfocus(sle_co)
	return -1
end if

select max(agree_id) into :li_id from lag_track;
if isnull(li_id) then li_id = 1   //Start Code Change ----06.09.2011 #V11 maha 
li_id++

dw_agree.insertrow(2)
dw_agree.setitem(2,"agree_id",li_id)
dw_agree.setitem(2,"email_addr",ls_email)
dw_agree.setitem(2,"company",ls_company)
dw_agree.setitem(2,"license_key",sle_1.text)
//dw_agree.setitem(2,"aggreement_text",dw_agree.getitemstring(1,"aggreement_text"))
//dw_agree.setitem(2,"aggreement_date",datetime(today(),now()))
dw_agree.setitem(2,"agreement_text",dw_agree.getitemstring(1,"agreement_text"))//added by long.zhang 06.09.2011
dw_agree.setitem(2,"agreement_date",datetime(today(),now()))//added by long.zhang 06.09.2011


//dw_agree.update()

return 1
end function

public function integer of_set_4_smart (boolean ab_smart);//Start Code Change ----03.24.2011 #V11 maha - function to be sure group and entity data exists for Smart.  
//Assumes facility id 1 exists.
integer ecnt
integer gcnt
long gid

if ab_smart then
	//Start Code Change ----02.13.2012 #V12 maha - modified to check for the specific group and entity and added clear entity code
//	select count(rec_id)  into :gcnt from group_multi_loc;
//	select count(entity_id) into :ecnt from entity_lookup;
	select count(rec_id)  into :gcnt from group_multi_loc where rec_id = 1;
	select count(entity_id) into :ecnt from entity_lookup where entity_id = 1;
	
	if gcnt = 0 then
		insert into group_multi_loc (rec_id,gp_name) values (1,"Default Group");
		commit using sqlca;
	end if
	
	if ecnt = 0 then
		insert into entity_lookup (entity_id,entity_name, facility_id, group_id )  values (1,"Default",1, 1);
		commit using sqlca;
	elseif ecnt = 1 then
		update entity_lookup set facility_id = 1, group_id = 1 where entity_id = 1;
		commit using sqlca;
	else
		//never mind
	end if
else //for app and cred clear the default entity link
	delete from entity_lookup  where entity_id = 1 and facility_id = 1 and  group_id = 1; 
	//End Code Change ----02.13.2012
end if


return 1
end function

public function integer of_run_license_14 ();//Start Code Change ----05.29.2013 #V14 maha - added new license setup
integer i
integer ic
integer li_bar_ticks
integer li_mod
long ll_sum
string s
string sa
string sb = 'x'
string sc = 'x'
string sd = 'x'
string se = 'x'
string srrr = 'x'
string sf = 'x'
string sg = 'x' 
string sh = 'x' 
string si = 'x'
string si2 = 'x'
string sj = 'x'
string sk = 'x'
string sl = 'x'
string ls_org
Integer li_check_ret
debugbreak()

//Start Code Change ----08.25.2010 #V10 maha - modified for subscription
s = sle_1.text
s = of_strip_char(" ", s,"")
s = of_strip_char("-", s,"") //Start Code Change ----03.29.2011 #V11 maha  - strip the dash

ls_org = s
if is_type = "S" then
	i = of_subscription(s )
	return i
end if


//ISG 1400 aaabcde rrrfghjklii

//number of users		aaa
//app						b	7,5,4,2
//image					b	--
//install imaging		c	9,1		
//priv					d	9,8,7,6,5,4,3,0
//webview				d	--
//workflow				d	--
//report					e	9,8,7,6,5,4,3,0
//export					e	--
//import 				e	--
//read only users		rrr
//contract				f	9,8,7,6,5,4,3,0
//qa						f	--
//contact create		f	--
///////peer	old		h	9,4,3,1
//peer					h  9,8,7,6,5,4,3,0
//site					h	--
//subscription			h  --			//maha 8-2010
//automation		j 	9,0
//call log		k 	9,0
//recruitment		l 	9,0
//program				g	9,8,7,6
//checksum (programs)	i
//checksum2	(users)		i2
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2008-08-26 By: Ken.Guo
//$<reason> Move these check script to f_license_check() function.
//$<reason> In order to session module can call it.

sa = mid(s,8,3)
sb = mid(s,11,1)
sc = mid(s,12,1)
sd = mid(s,13,1)
se = mid(s,14,1)
srrr = mid(s,15,3)
sf = mid(s,18,1)
sg = mid(s,19,1)
sh = mid(s,20,1)
sj = mid(s,21,1)
sk = mid(s,22,1)
sl = mid(s,23,1)
si = mid(s,24,1)
si2 = mid(s,25,1)

li_check_ret = f_license_check_v14(s,sb,sc,sd,se,sf,sg,sh,sj,sk,sl) //intellicred.pbl

If li_check_ret < 0 Then
	Choose Case li_check_ret
		Case -1
			Messagebox("Key Error","Please check License Number and re-enter.  Should be 25 characters.")
			Return -1			
		Case -2
			Messagebox("Key Error","Please check License Number.  If it does not start ISG 140 it is invalid.  Contact customer support for a current license number.")
			Return -1	
		Case -3   //Start Code Change ----08.25.2010 #V10 maha - subscription
			Messagebox("Key Error","Please check License Number.  It Should be 25 characters for license only or 37 characters for license and subscription.")
			Return -1	
		Case -10
			of_failure("")
			Return -1
		Case -11
			Messagebox("Key Error","License Number checksum1 error. ~r~rPlease check that the license number was entered correctly.  ~r~r If so, contact customer support for a current license number.")
			return -1	
		Case -12
			Messagebox("Key Error","License Number checksum2 error. ~r~rPlease check that the license number was entered correctly.  ~r~r If so, contact customer support for a current license number.")
			return -1	
		Case Else
			Messagebox('Key Error','Invalid License number.')
			Return -1
	End Choose
End If
//---------------------------- APPEON END ----------------------------

choose case sb  //app print, imaging
	case "7" 
		dw_set.setitem(1,"set_iapps",1)
		dw_set.setitem(1,"set_img",1)
	case "5"
		dw_set.setitem(1,"set_iapps",1)
		dw_set.setitem(1,"set_img",0)
	case "4"
		dw_set.setitem(1,"set_iapps",0)
		dw_set.setitem(1,"set_img",1)
	case "2"
		dw_set.setitem(1,"set_iapps",0)
		dw_set.setitem(1,"set_img",0)
	case else
		of_failure("B")
		return - 1
end choose

//sc is not a program setting used by the installer for imaging

choose case sd //privileges, webview, workflow
	case "9" 
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",1)
		dw_set.setitem(1,"set_47",1)		
	case "8" 
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",1)
		dw_set.setitem(1,"set_47",0)
	case "7" 
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",0)
		dw_set.setitem(1,"set_47",1)
	case "6"
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",0)
		dw_set.setitem(1,"set_47",0)
	case "5" 
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",1)
		dw_set.setitem(1,"set_47",1)
	case "4"
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",1)
		dw_set.setitem(1,"set_47",0)
	case "3" 
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",0)
		dw_set.setitem(1,"set_47",1)
	case "0"
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",0)
		dw_set.setitem(1,"set_47",0)
	case else
		of_failure("D")
		return -1
end choose
		
choose case se //report, export,import

	case "9" 
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",1)
		if  dw_set.getitemnumber(1,"set_import") = 0 then dw_set.setitem(1,"set_import",2)  //Start Code Change ----08.21.2015 #V15 maha
	case "8" 
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",1)
		dw_set.setitem(1,"set_import",0)
	case "7" 
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",0)
		if  dw_set.getitemnumber(1,"set_import") = 0 then dw_set.setitem(1,"set_import",2)  //Start Code Change ----08.21.2015 #V15 maha
	case "6" 
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",0)
		dw_set.setitem(1,"set_import",0)
	case "5"
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",1)
		if  dw_set.getitemnumber(1,"set_import") = 0 then dw_set.setitem(1,"set_import",2)  //Start Code Change ----08.21.2015 #V15 maha
	case "4" 
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",1)
		dw_set.setitem(1,"set_import",0)
	case "3"
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",0)
		if  dw_set.getitemnumber(1,"set_import") = 0 then dw_set.setitem(1,"set_import",2)  //Start Code Change ----08.21.2015 #V15 maha
	case "0"
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",0)
		dw_set.setitem(1,"set_import",0)
	case else
		of_failure("E")
		return -1
end choose
//m1 = 9,8,7,6
//m2 = 9,8,5,4
//m3 = 9,7,5,3
choose case sf //contracts, qa, contract create (only on if contract is on);  global search(always on for contract)
	case "9" 
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",1)
		dw_set.setitem(1,"set_51",1)
		dw_set.setitem(1,"set_48",1)
	case "8" 
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",1)
		dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_48",1)
	case "7" 
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",0)
		dw_set.setitem(1,"set_51",1)
		dw_set.setitem(1,"set_48",1)
	case "6"
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",0)
		dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_48",1)
	case "5" 
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",1)
		dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_48",0)
	case "4"
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",1)
		dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_48",0)
	case "3" 
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",0)
		dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_48",0)
	case "0"
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",0)
		dw_set.setitem(1,"set_51",0)
		dw_set.setitem(1,"set_48",0)
	case else
		of_failure("F")
		return -1
end choose

choose case sg //product
	case "8" 
		dw_set.setitem(1,"set_9",1)
		of_set_4_smart(false) //Start Code Change ----02.13.2012 #V12 maha
	case "9"
		dw_set.setitem(1,"set_9",0)
		of_set_4_smart(false) //Start Code Change ----02.13.2012 #V12 maha
	case "7"
		dw_set.setitem(1,"set_9",4)
		dw_set.setitem(1,"set_cont",1) //Added by Ken.Guo 08.27.2008 Contract product alway can access contract module. 
		of_set_4_smart(false) //Start Code Change ----02.13.2012 #V12 maha
	case "6"
		dw_set.setitem(1,"set_9",5)  //Start Code Change ----08.27.2010 #V10 maha - added for SK
		of_set_4_smart(true)	//Start Code Change ----02.13.2012 #V12 maha - added argument
	case else
		of_failure("G")
		return -1
end choose



choose case sh //peer, site, subscription
	case "9" ,"8"
		dw_set.setitem(1,"set_peer",1)
		dw_set.setitem(1,"set_site",1)
	case "4" ,"7"
		dw_set.setitem(1,"set_peer",1)
		dw_set.setitem(1,"set_site",0)
	case "3" ,"5"
		dw_set.setitem(1,"set_peer",0)
		dw_set.setitem(1,"set_site",1)
	case "1"
		dw_set.setitem(1,"set_peer",0)
		dw_set.setitem(1,"set_site",0)
	case else
		of_failure("H")
		return -1
end choose

choose case sh //subscription
	case "8","7","5"
		update ids set pp_s = 1;
		commit using sqlca;
		is_type = "S"
	case else
		update ids set pp_s = 0;
		commit using sqlca;
		is_type = "L"
end choose

//automation
choose case sj 
	case "3" 
		dw_set.setitem(1,"set_automation",1)
	case "0"
		dw_set.setitem(1,"set_automation",0)
	case else
		of_failure("J")
end choose

//call log
choose case sk 
	case "3" 
		dw_set.setitem(1,"set_call_log",1)
	case "0"
		dw_set.setitem(1,"set_call_log",0)
	case else
		of_failure("K")
end choose

//recruitment
choose case sl 
	case "3" 
		dw_set.setitem(1,"set_recruit",1	)
	case "0"
		dw_set.setitem(1,"set_recruit",0)
	case else
		of_failure("L")
end choose

//sk only switches - regardless of other settings
if sg = "6" then
	dw_set.setitem(1,"set_cont",0)
	dw_set.setitem(1,"set_qa",0)
	dw_set.setitem(1,"set_51",0)
	dw_set.setitem(1,"set_48",0)
	dw_set.setitem(1,"set_import",0)
	dw_set.setitem(1,"set_priv",0)
	dw_set.setitem(1,"set_web",0)
	dw_set.setitem(1,"set_47",0)
	dw_set.setitem(1,"set_peer",0)
	dw_set.setitem(1,"set_site",0)
	dw_set.setitem(1,"set_automation",0)
	dw_set.setitem(1,"set_recruit",0	)
	dw_set.setitem(1,"set_call_log",0)
end if


//Full access users
//dw_set.setitem(1,"",integer(sa))

//read only users
//dw_set.setitem(1,"",integer(srrr))

s = left(s,25) //Start Code Change ----08.25.2010 #V10 maha - reset if includes the sub

dw_set.setitem(1,"set_product",0)

dw_set.setitem(1,"license_info",s) //Added by Ken.Guo 08.26.2008


gnv_appeondb.of_autocommitrollback( )
If dw_set.update() = 1 Then
	Commit using SQLCA;
	gnv_session.is_license_key = s 
	of_refresh_module()  
	Return 1
Else
	Rollback using SQLCA;
	Messagebox('Save Error','Failed to save license key, please call support.')
	of_refresh_module() 
	Return -1
End If

//Start Code Change ----08.25.2010 #V10 maha - subscription
if len(ls_org) = 34 then
	string ls_sub
	ls_sub = right(ls_org,12)
	if of_subscription( ls_sub) = 1 then
		is_type = "L"
	end if
end if

if is_type = "LS" then
	st_1.text = "Enter Install Subscription Key and click Run."
	is_type = "SI" //used in close query
end if
//End Code Change ----08.25.2010
	
	
return 1
	
























end function

on w_install_module_update.create
this.cb_bypass=create cb_bypass
this.dw_agree=create dw_agree
this.st_5=create st_5
this.st_4=create st_4
this.sle_co=create sle_co
this.sle_name=create sle_name
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_3=create st_3
this.dw_set=create dw_set
this.st_2=create st_2
this.st_progress=create st_progress
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_4=create cb_4
this.cb_cancel=create cb_cancel
this.cb_run=create cb_run
this.gb_1=create gb_1
this.r_print_stat_border=create r_print_stat_border
this.r_bar=create r_bar
this.Control[]={this.cb_bypass,&
this.dw_agree,&
this.st_5,&
this.st_4,&
this.sle_co,&
this.sle_name,&
this.rb_2,&
this.rb_1,&
this.st_3,&
this.dw_set,&
this.st_2,&
this.st_progress,&
this.st_1,&
this.sle_1,&
this.cb_4,&
this.cb_cancel,&
this.cb_run,&
this.gb_1,&
this.r_print_stat_border,&
this.r_bar}
end on

on w_install_module_update.destroy
destroy(this.cb_bypass)
destroy(this.dw_agree)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_co)
destroy(this.sle_name)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_3)
destroy(this.dw_set)
destroy(this.st_2)
destroy(this.st_progress)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.cb_cancel)
destroy(this.cb_run)
destroy(this.gb_1)
destroy(this.r_print_stat_border)
destroy(this.r_bar)
end on

event open;
integer i
string s
dw_set.settransobject(sqlca)
i = dw_set.retrieve()


//Start Code Change ----08.25.2010 #V10 maha - added for subscription
is_type = message.stringparm

choose case is_type
	case "L"
		st_1.text = "Enter Install License Key."
	case "S"
		st_1.text = "Enter Install Subscription Key."
		this.y = 2400
		this.x = 572
		cb_run.enabled = true
	case "LS"
		st_1.text = "Enter Install License Key."	
	case "NEW"  //Start Code Change ----02.13.2012 #V12 maha
		st_1.text = "Enter Install License Key."
		ib_new = true
	case else
		st_1.text = "Enter Install License Key."	
end choose

dw_agree.settransobject(sqlca)
dw_agree.retrieve(1)

if i < 1 then
	MessageBox("Connection failure", "Unable to get settings")
	closewithreturn(this,"fail")
end if

if upper(gs_user_id) = "MASTER" then cb_bypass.visible = true



	
end event

event close;//disCONNECT USING SQLCA;


end event

event closequery;//Start Code Change ----08.25.2010 #V10 maha
integer ans

if is_type = "SI" then
	ans = messagebox("Subscription License","Your license requires a Subscription key.  If you do not have the key yet, you will have 10 days to get it from IntelliSoft and enter it.  It can be entered fromThe About window accessed from the Help menu.~rr Do you wish to enter the Subscription key before closing?",question!,yesno!,1)
	if ans = 1 then
		return 1
	else 
		return 0
	end if
	
end if
	
end event

type cb_bypass from commandbutton within w_install_module_update
boolean visible = false
integer x = 2062
integer y = 148
integer width = 274
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Bypass"
boolean cancel = true
end type

event clicked;closewithreturn(parent,"Bypass")
end event

type dw_agree from datawindow within w_install_module_update
integer x = 41
integer y = 544
integer width = 3310
integer height = 2188
integer taborder = 40
string title = "none"
string dataobject = "d_license_agreement_isg"
end type

type st_5 from statictext within w_install_module_update
integer x = 1102
integer y = 352
integer width = 338
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Email address:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_install_module_update
integer x = 1120
integer y = 420
integer width = 256
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Company:"
boolean focusrectangle = false
end type

type sle_co from singlelineedit within w_install_module_update
integer x = 1454
integer y = 408
integer width = 1586
integer height = 76
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_name from singlelineedit within w_install_module_update
integer x = 1454
integer y = 324
integer width = 1586
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_install_module_update
integer x = 142
integer y = 336
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "I Accept"
end type

event clicked;cb_run.enabled = true
end event

type rb_1 from radiobutton within w_install_module_update
integer x = 512
integer y = 336
integer width = 485
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "I do not Accept"
end type

event clicked;cb_run.enabled = false
cb_cancel.triggerevent(clicked!)
end event

type st_3 from statictext within w_install_module_update
integer x = 489
integer y = 12
integer width = 69
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

event clicked;closewithreturn(parent,"Bypass")
end event

type dw_set from datawindow within w_install_module_update
boolean visible = false
integer x = 1911
integer y = 12
integer width = 1385
integer height = 136
integer taborder = 50
string title = "none"
string dataobject = "d_icred_settings"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_install_module_update
boolean visible = false
integer x = 3067
integer y = 416
integer width = 357
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean enabled = false
string text = "Not completed"
boolean focusrectangle = false
end type

type st_progress from statictext within w_install_module_update
integer x = 2359
integer y = 164
integer width = 201
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Progress"
boolean focusrectangle = false
end type

type st_1 from statictext within w_install_module_update
integer x = 101
integer y = 80
integer width = 1486
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Enter Install License Key and click Continue"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_install_module_update
integer x = 105
integer y = 152
integer width = 1353
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_install_module_update
integer x = 146
integer y = 416
integer width = 274
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;//if dw_1.rowcount() < 1 then
//	messagebox("","nothing to print")
//	return
//end if
//
dw_agree.print()
end event

type cb_cancel from commandbutton within w_install_module_update
integer x = 1765
integer y = 148
integer width = 274
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CLOSEwithreturn(PARENT,"Cancel")
end event

type cb_run from commandbutton within w_install_module_update
integer x = 1486
integer y = 148
integer width = 261
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Continue"
boolean default = true
end type

event clicked;string s
integer li_len

//Start Code Change ----02.24.2011 #V11 maha - isg license agreement
if of_add_agreement() < 0 Then
	return -1
end if
//End Code Change ----02.24.2011
debugbreak()
//Start Code Change ----06.06.2013 #V14 maha
s = sle_1.text
s = of_strip_char(" ", s,"")
s = of_strip_char("-", s,"") //Start Code Change ----03.29.2011 #V11 maha  - strip the dash
li_len = len(s)

//Start Code Change ----08.09.2017 #V154 maha
if left(s,3) <> "ISG" then
	messagebox("Invalid Key", "All License Keys should begin with 'ISG'")
	return -1
end if
//End Code Change ----08.09.2017

choose case li_len
	case 22    //ver 9-12
		If of_run_license() < 0 Then Return -1
	case 25    //ver 14
		If of_run_license_14() < 0 Then Return -1
	case 34  //ver 9-12 with subscription
		If of_run_license() < 0 Then Return -1
	case 37  //ver 14 with subscription
		If of_run_license_14() < 0 Then Return -1
	case 12  //subscription only
		If of_subscription(s) < 0 Then Return -1
	case else
		if pos(s, "ISG14", 1) > 0 then
			If of_run_license_14() < 0 Then Return -1
		else
			If of_run_license() < 0 Then Return -1
		end if
end choose

//If of_run_license() < 0 Then
//	Return -1
//End If
//End Code Change ----06.06.2013

dw_agree.update() //Start Code Change ----02.24.2011 #V11 maha

//dw_set.retrieve()
//messagebox("","hold")

if is_type <> "LS" then
	Closewithreturn(parent,"OK")
end if




/*
//of_run_license()//Start Code Change ----05.28.2008 #V8 maha - added for v8.5 license development
//return
integer i
integer ic
integer li_bar_ticks
string s
string sb = 'x'
string sc = 'x'
string sd = 'x'
string se = 'x'
string sf = 'x'
string sg = 'x' 
string sh = 'x'

//the key code is created in the support program logic w_request_form (minicontact.pbl)
//ISG 0500 aabcde fghi

//number of users		aa
//app					b	7,5,4,2
//image				b	--
//install imaging		c	9,1		
//priv					d	8,6,4,0
//webview				d	--
//report				e	9,5,3,1
//export				e	--
//contract				f	7,6,4,2
//qa					f	--
//program				g	9,8,7
//peer					h	9,4,3,1
//site					h	--

//tutorial database 	i

s = sle_1.text

if len(s) <> 17 then
	Messagebox("Key Error","Please check Serial Number and re-enter")
	return
end if

if mid(s,4,3) <> "050" then //Start Code Change ----01.28.2008 #V8 maha - changed to allow sql database key code
	Messagebox("Key Error","Please check Serial Number.  If it does not start ISG050 it is invalid for this function.  Contact customer support.")
	return
end if

sb = mid(s,10,1)
if of_check(sb) = -1 then return
sd = mid(s,12,1)
if of_check(sd) = -1 then return
se = mid(s,13,1)
if of_check(se) = -1 then return
sf = mid(s,14,1)
if of_check(sf) = -1 then return
sg = mid(s,15,1)
if of_check(sg) = -1 then return
sh = mid(s,16,1)
if of_check(sh) = -1 then return

choose case sb  //app print, imaging
	case "7" 
		dw_set.setitem(1,"set_iapps",1)
		dw_set.setitem(1,"set_img",1)
	case "5"
		dw_set.setitem(1,"set_iapps",1)
		dw_set.setitem(1,"set_img",0)
	case "4"
		dw_set.setitem(1,"set_iapps",0)
		dw_set.setitem(1,"set_img",1)
	case "2"
		dw_set.setitem(1,"set_iapps",0)
		dw_set.setitem(1,"set_img",0)
	case else
		of_failure("B")
		return
end choose

choose case sd //privileges, webview
	case "8" 
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",1)
	case "6"
		dw_set.setitem(1,"set_priv",1)
		dw_set.setitem(1,"set_web",0)
	case "4"
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",1)
	case "0"
		dw_set.setitem(1,"set_priv",0)
		dw_set.setitem(1,"set_web",0)
	case else
		of_failure("D")
		return
end choose
		
choose case se //report, export
	case "9" 
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",1)
	case "5"
		dw_set.setitem(1,"set_ireport",1)
		dw_set.setitem(1,"set_iauto",0)
	case "3"
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",1)
	case "1"
		dw_set.setitem(1,"set_ireport",0)
		dw_set.setitem(1,"set_iauto",0)
	case else
		of_failure("E")
		return
end choose

choose case sf //contracts, qa
	case "7" 
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",1)
	case "6"
		dw_set.setitem(1,"set_cont",1)
		dw_set.setitem(1,"set_qa",0)
	case "4"
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",1)
	case "2"
		dw_set.setitem(1,"set_cont",0)
		dw_set.setitem(1,"set_qa",0)
	case else
		of_failure("F")
		return
end choose

choose case sg //product
	case "8" 
		dw_set.setitem(1,"set_9",1)
	case "9"
		dw_set.setitem(1,"set_9",0)
	case "7"
		dw_set.setitem(1,"set_9",4)
	case else
		of_failure("G")
		return
end choose

choose case sh //peer, site
	case "9" 
		dw_set.setitem(1,"set_peer",1)
		dw_set.setitem(1,"set_site",1)
	case "4"
		dw_set.setitem(1,"set_peer",1)
		dw_set.setitem(1,"set_site",0)
	case "3"
		dw_set.setitem(1,"set_peer",0)
		dw_set.setitem(1,"set_site",1)
	case "1"
		dw_set.setitem(1,"set_peer",0)
		dw_set.setitem(1,"set_site",0)
	case else
		of_failure("H")
		return
end choose

dw_set.setitem(1,"set_product",0)

dw_set.update()
commit using sqlca;
	
closewithreturn(parent,"OK")
*/	
























end event

type gb_1 from groupbox within w_install_module_update
integer x = 73
integer y = 268
integer width = 3072
integer height = 252
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "I agree to the following license agreement"
end type

type r_print_stat_border from rectangle within w_install_module_update
integer linethickness = 4
long fillcolor = 12632256
integer x = 2583
integer y = 172
integer width = 1344
integer height = 56
end type

type r_bar from rectangle within w_install_module_update
long linecolor = 8388608
integer linethickness = 4
long fillcolor = 8388608
integer x = 2583
integer y = 172
integer width = 1344
integer height = 48
end type

