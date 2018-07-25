$PBExportHeader$w_home_buttons.srw
forward
global type w_home_buttons from w_sheet
end type
type pb_3 from picturebutton within w_home_buttons
end type
type pb_6 from picturebutton within w_home_buttons
end type
type pb_9 from picturebutton within w_home_buttons
end type
type pb_8 from picturebutton within w_home_buttons
end type
type pb_5 from picturebutton within w_home_buttons
end type
type pb_2 from picturebutton within w_home_buttons
end type
type pb_1 from picturebutton within w_home_buttons
end type
type pb_4 from picturebutton within w_home_buttons
end type
type pb_7 from picturebutton within w_home_buttons
end type
end forward

global type w_home_buttons from w_sheet
integer x = 214
integer y = 221
integer width = 2889
integer height = 2576
string title = "Home"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 23930409
string icon = "AppIcon!"
boolean center = true
pb_3 pb_3
pb_6 pb_6
pb_9 pb_9
pb_8 pb_8
pb_5 pb_5
pb_2 pb_2
pb_1 pb_1
pb_4 pb_4
pb_7 pb_7
end type
global w_home_buttons w_home_buttons

type variables
integer ii_set_9, ii_set_ireport, ii_set_iapps, ii_set_iauto, ii_set_import, ii_set_call_log,ii_set_cont, ii_set_priv
integer ii_button_set[], ii_set_setup

constant long INTELLI_ORANGE = rgb(255,201,14)
string is_from  //maha 02001.2016
end variables

forward prototypes
public function integer of_button_settings ()
public function integer of_button_mod_sec (integer ai_type)
public function integer of_open_screen (integer ai_screen)
end prototypes

public function integer of_button_settings ();//Start Code Change ----05.21.2015 #V15 maha - copy from login window
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

public function integer of_button_mod_sec (integer ai_type);//Start Code Change ---05.21.2015 V15 maha - copy from login
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

public function integer of_open_screen (integer ai_screen);//Start Code Change ----04.07.2014 #V14.2 maha
//Start Code Change ----10.14.2014 #V14.2 maha - modified all open sheet to 0 for the position value


//Start Code Change ----02.01.2016 #V15 maha - If from login, close this window and open from of_open_at_start

if is_from = "LOG" then
	//
else
	post of_open_at_start_new(false)
end if
//
//
close(w_home_buttons)
//all other code called in of_open at start_new
//End Code Change ----02.01.2016


//
//choose case ai_screen
//	case 1 ///prac folder
//		if gb_contract_version = false and  w_mdi.of_security_access( 40 ) > 0 then
//			w_mdi.Post triggerevent("pfc_cst_practitioner")
//		end if
//	case 2  //contract
//		if gb_contract_version = True or of_get_app_setting("set_cont","I") = 1 then
//			PowerObject lpo_NullParm
//			Post gf_OpenContractFolder(lpo_NullParm)			
//		end if
//	case 3 //action items
//		if w_mdi.of_security_access( 240 ) > 0 then 
//			w_mdi.Post triggerevent("pfc_cst_action_items")
//		end if	
//	case 4 //Reports
//		if w_mdi.of_security_access( 700 ) > 0 then
//			w_mdi.Post Triggerevent("pfc_cst_reports")
//		end if
//	case 5 //intellireport
//		if w_mdi.of_security_access( 1470 ) > 0 and gi_ireport_on = 1 then
//			Post OpenSheet( w_custom_report, w_mdi, 0, Original!)
//		end if
//	case 6  //App mapping
//		IF w_mdi.of_security_access( 1460 ) > 0 and gi_iapp_on = 1 then
//			Post OpenSheet( w_train_app, w_mdi, 0,Original!)			
//		end if
//	case 7 //Export Painter
//		IF w_mdi.of_security_access( 550 ) > 0 and of_get_app_setting("set_iauto","I") = 1 THEN 
//			//------------------- APPEON BEGIN -------------------
//			//<$>added:long.zhang 01.12.2015
//			//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons
//			//w_mdi.Post triggerevent("pfc_cst_export_painter")
//			Post Open( w_export_painter )
//			//------------------- APPEON END -------------------
//		end if
//	case 8 //import Painter 
//		IF  of_get_app_setting("set_import","I") = 1 and  w_mdi.of_security_access( 6928 ) > 0 THEN
//			Post OpenSheet(w_import_painter, w_mdi, 0, Original!)
//		end if
//	//Start Code Change ----05.21.2013 #V14 maha
//	case 9 //call log
//		opensheetwithparm(w_call_log,0, w_mdi, 0, Original!)
//	case 10 //privileges
//		OpenSheet(w_privilege_painter, w_mdi, 0, Original!)
//	case 11 //groups
//		//------------------- APPEON BEGIN -------------------
//		//<$>added:long.zhang 01.12.2015
//		//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons
//
//		//OpenSheet( w_group_practice, w_mdi, 0, Original!)
//		Post Open( w_group_practice)
//		//------------------- APPEON END -------------------
//
//	case 12 //app printing
//		//---------Begin Added by (Appeon)Harry 10.22.2014 for BugH092802--------
//		Boolean lb_Maximized = false
//		if isvalid (w_mdi.GetActiveSheet( )) then 
//			if w_mdi.GetActiveSheet( ).classname() = "w_dashboard" and not isvalid(w_intelliApp_print) then
//				lb_Maximized = true
//			end if
//		end if
//		//---------End Added ------------------------------------------------------
//		
//		//------------------- APPEON BEGIN -------------------
//		//<$>added:long.zhang 01.12.2015
//		//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons
//		//OpenSheet( w_intelliApp_print, w_mdi, 0, Original!)  
//		Post Open( w_intelliApp_print)  
//		//------------------- APPEON END -------------------
//		
//		//---------Begin Added by (Appeon)Harry 10.22.2014 for BugH092802--------
//		if lb_Maximized then //(Appeon)Harry 10.16.2014 - BugH092501
//			if  isvalid(w_intelliApp_print) then
//				if w_intelliApp_print.windowstate  = Minimized! then
//					w_intelliApp_print.WindowState = Normal!
//				end if
//			end if
//		end if
//		//---------End Added ------------------------------------------------------
//	case 13 //utilities
//		//------------------- APPEON BEGIN -------------------
//		//<$>added:long.zhang 01.12.2015
//		//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons
////		if of_get_app_setting("set_9","I") = 4 then
////			OpenSheet(w_utilities_contract, w_mdi, 0, Original!)
////		elseif gs_cust_type = "I" then  
////			OpenSheet(w_utilities_app, w_mdi, 0, Original!)
////		else
////			OpenSheet(w_utilities5, w_mdi, 0, Original!)
////		end if		
//		if of_get_app_setting("set_9","I") = 4 then
//			post open(w_utilities_contract)
//		elseif gs_cust_type = "I" then  //Start Code Change ----06.29.2010 #V102 maha - app type utilities
//			post open(w_utilities_app)
//		else
//			post open(w_utilities5)
//		end if
//		//------------------- APPEON END -------------------
//	case 14 //setup
//		//------------------- APPEON BEGIN -------------------
//		//<$>added:long.zhang 01.12.2015
//		//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons
//
////		if gb_contract_version then //contract
////			OpenSheet(w_setup_central_cont, w_mdi, 0, Original!)
////		elseif gb_sk_ver then //smart
////			OpenSheet(w_setup_central_sk, w_mdi, 0, Original!)
////		elseif gs_cust_type = 'I' then //app
////			OpenSheet(w_setup_central_app , w_mdi, 0, Original!)
////		else //cred
////			OpenSheet(w_setup_central, w_mdi, 0, Original!)
////		end if
//		if gb_contract_version then //contract
//			Post open(w_setup_central_cont)
//		elseif gb_sk_ver then //smart
//			Post open(w_setup_central_sk)
//		elseif gs_cust_type = 'I' then //app
//			Post open(w_setup_central_app)
//		else //cred
//			Post open(w_setup_central)
//		end if
//		//------------------- APPEON END -------------------
//	case 15 //letters
//		Open( w_letter_generator)  //Start Code Change ----10.14.2014 #V14.2 maha - changed from opensheet
//	case 16 //TD list
//		OpenSheet(w_todolist, w_mdi, 0, Original!)
//	case 17 //main screen
//	//End Code Change ----05.21.2013 	
//case 18 //Contact log actions  //Start Code Change ----11.18.2013 #V14 maha - added
//	opensheetwithparm(w_call_log_open_calls,0, w_mdi, 0, Original!) 
//	
//case 19 //recruitment
//	OpenSheet(w_recruitment_data_tabs, w_mdi, 0, Original!)
//end choose
//w_mdi.setfocus()  //Stephen 05.19.2011 --- Fixed a bug closing the Setup Launch Pad it also closes the Task List
//
//function post close(w_home_buttons)  //Start Code Change ----02.01.2016 #V15 maha
	
return 1

end function

on w_home_buttons.create
int iCurrent
call super::create
this.pb_3=create pb_3
this.pb_6=create pb_6
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_5=create pb_5
this.pb_2=create pb_2
this.pb_1=create pb_1
this.pb_4=create pb_4
this.pb_7=create pb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_3
this.Control[iCurrent+2]=this.pb_6
this.Control[iCurrent+3]=this.pb_9
this.Control[iCurrent+4]=this.pb_8
this.Control[iCurrent+5]=this.pb_5
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.pb_4
this.Control[iCurrent+9]=this.pb_7
end on

on w_home_buttons.destroy
call super::destroy
destroy(this.pb_3)
destroy(this.pb_6)
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_5)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.pb_4)
destroy(this.pb_7)
end on

event open; //Start Code Change ----05.22.2015 #V15 maha = created

string s

gw_popup[UpperBound(gw_popup[]) + 1] = This //Added by Appeon long.zhang 11.06.2015 (V14.2 Applause Bug # 4830 - The Home and Utilities windows do not close when you relogin (login as..))

//r_1.fillcolor = intelli_orange
of_button_settings( )

if gs_cust_type = "I" then
	s = "IntelliApp"
elseif gb_contract_version then
	s = "IntelliContract"
else
	s = "IntelliCred"
end if

if message.stringparm = "LOGIN" then
	is_from = "LOG"
else
	is_from = "MENU"
end if

//--------------------------- RP 1.26.2016 ----------------------------------
//st_home.text = s + " Home"
//st_home.text = s

//------------------------------ RP 1.21.2016 -------------------------------
//this.backColor = rgb(25, 48, 72)
//st_home.backColor = rgb(25, 48, 72)
//r_1.fillColor = rgb(153, 153, 153)
//st_home.textColor = rgb(197, 203, 209)


//--------------------------------- RP 1.22.2016-----------------------------
//r_1.width = this.workspaceWidth() - 2*r_1.x
//this.of_setResize(TRUE)
//this.inv_resize.of_setOrigSize(this.workspaceWidth(), this.workspaceHeight())
//this.inv_resize.of_register(r_1, 0, 0, 100, 0)

//-----------------------------RP 3.1.2016------------------------------------
gnv_app.of_benchmark("home buttons")
//gnv_app.of_displaybenchmark()

end event

type pb_3 from picturebutton within w_home_buttons
integer x = 1929
integer y = 44
integer width = 887
integer height = 776
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Button 3"
boolean flatstyle = true
long textcolor = 16777215
long backcolor = 33551856
end type

event clicked; //Start Code Change ----05.21.2015 #V15 maha
gi_openscreen= ii_button_set[3]
of_open_screen(gi_openscreen)
// RP parent.triggerevent(close! )
//function post close(parent)

end event

type pb_6 from picturebutton within w_home_buttons
integer x = 1929
integer y = 860
integer width = 887
integer height = 776
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Button 6"
boolean flatstyle = true
long textcolor = 16777215
long backcolor = 33551856
end type

event clicked; //Start Code Change ----05.21.2015 #V15 maha
gi_openscreen= ii_button_set[6]
of_open_screen(gi_openscreen)
// RP parent.triggerevent(close! )
//function post close(parent)

end event

type pb_9 from picturebutton within w_home_buttons
integer x = 1929
integer y = 1676
integer width = 887
integer height = 776
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Button 9"
boolean flatstyle = true
long textcolor = 16777215
long backcolor = 33551856
end type

event clicked; //Start Code Change ----05.21.2015 #V15 maha
gi_openscreen= ii_button_set[9]
of_open_screen(gi_openscreen)
// RP parent.triggerevent(close! )
//function post close(parent)

end event

type pb_8 from picturebutton within w_home_buttons
integer x = 992
integer y = 1676
integer width = 887
integer height = 776
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Button 8"
boolean flatstyle = true
long textcolor = 16777215
long backcolor = 33551856
end type

event clicked; //Start Code Change ----05.21.2015 #V15 maha
gi_openscreen= ii_button_set[8]
of_open_screen(gi_openscreen)
// RP parent.triggerevent(close! )
//function post close(parent)

end event

type pb_5 from picturebutton within w_home_buttons
integer x = 992
integer y = 860
integer width = 887
integer height = 776
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Button 5"
boolean default = true
boolean flatstyle = true
long textcolor = 16777215
long backcolor = 33551856
end type

event clicked; //Start Code Change ----05.21.2015 #V15 maha
gi_openscreen= ii_button_set[5]
of_open_screen(gi_openscreen)
// RP parent.triggerevent(close! )
//function post close(parent)

end event

type pb_2 from picturebutton within w_home_buttons
integer x = 992
integer y = 44
integer width = 887
integer height = 776
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Button 2"
boolean flatstyle = true
long textcolor = 16777215
long backcolor = 33551856
end type

event clicked; //Start Code Change ----05.21.2015 #V15 maha
gi_openscreen= ii_button_set[2]
of_open_screen(gi_openscreen)
// RP parent.triggerevent(close! )
//function post close(parent)

end event

type pb_1 from picturebutton within w_home_buttons
integer x = 55
integer y = 44
integer width = 887
integer height = 776
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Button 1"
boolean flatstyle = true
long textcolor = 16777215
long backcolor = 33551856
end type

event clicked; //Start Code Change ----05.21.2015 #V15 maha
gi_openscreen= ii_button_set[1]
of_open_screen(gi_openscreen)
// RP parent.triggerevent(close! )
//function post close(parent)

end event

type pb_4 from picturebutton within w_home_buttons
integer x = 55
integer y = 860
integer width = 887
integer height = 776
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Button 4"
boolean flatstyle = true
long textcolor = 16777215
long backcolor = 33551856
end type

event clicked; //Start Code Change ----05.21.2015 #V15 maha
gi_openscreen= ii_button_set[4]
of_open_screen(gi_openscreen)
// RP parent.triggerevent(close! )
//function post close(parent)

end event

type pb_7 from picturebutton within w_home_buttons
integer x = 55
integer y = 1676
integer width = 887
integer height = 776
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Button 7"
boolean flatstyle = true
long textcolor = 16777215
long backcolor = 33551856
end type

event clicked; //Start Code Change ----05.21.2015 #V15 maha
gi_openscreen= ii_button_set[7]
of_open_screen(gi_openscreen)
// RP parent.triggerevent(close! )
//function post close(parent)

end event

