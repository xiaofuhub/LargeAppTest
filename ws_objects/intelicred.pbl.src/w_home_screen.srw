$PBExportHeader$w_home_screen.srw
forward
global type w_home_screen from window
end type
type p_2 from picture within w_home_screen
end type
type st_privileges from statictext within w_home_screen
end type
type st_todolist from statictext within w_home_screen
end type
type st_export from statictext within w_home_screen
end type
type st_printapps from statictext within w_home_screen
end type
type st_import from statictext within w_home_screen
end type
type st_contactlog from statictext within w_home_screen
end type
type st_contactactions from statictext within w_home_screen
end type
type st_letters from statictext within w_home_screen
end type
type st_groups from statictext within w_home_screen
end type
type st_mapapps from statictext within w_home_screen
end type
type st_rec from statictext within w_home_screen
end type
type st_stdreports from statictext within w_home_screen
end type
type st_actionitems from statictext within w_home_screen
end type
type st_contracts from statictext within w_home_screen
end type
type st_intellireport from statictext within w_home_screen
end type
type st_utilities from statictext within w_home_screen
end type
type st_setup from statictext within w_home_screen
end type
type st_provider from statictext within w_home_screen
end type
type pb_tdl from picturebutton within w_home_screen
end type
type pb_let from picturebutton within w_home_screen
end type
type pb_log from picturebutton within w_home_screen
end type
type pb_utl from picturebutton within w_home_screen
end type
type pb_papp from picturebutton within w_home_screen
end type
type pb_grp from picturebutton within w_home_screen
end type
type pb_priv from picturebutton within w_home_screen
end type
type pb_irpt from picturebutton within w_home_screen
end type
type pb_std from picturebutton within w_home_screen
end type
type pb_act from picturebutton within w_home_screen
end type
type pb_cont from picturebutton within w_home_screen
end type
type pb_prac from picturebutton within w_home_screen
end type
type pb_cact from picturebutton within w_home_screen
end type
type pb_set from picturebutton within w_home_screen
end type
type pb_map from picturebutton within w_home_screen
end type
type pb_exp from picturebutton within w_home_screen
end type
type pb_imp from picturebutton within w_home_screen
end type
type pb_recruit from picturebutton within w_home_screen
end type
type st_home from statictext within w_home_screen
end type
type st_2 from statictext within w_home_screen
end type
type p_1 from picture within w_home_screen
end type
end forward

global type w_home_screen from window
integer width = 4494
integer height = 2576
boolean titlebar = true
string title = "Home "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
p_2 p_2
st_privileges st_privileges
st_todolist st_todolist
st_export st_export
st_printapps st_printapps
st_import st_import
st_contactlog st_contactlog
st_contactactions st_contactactions
st_letters st_letters
st_groups st_groups
st_mapapps st_mapapps
st_rec st_rec
st_stdreports st_stdreports
st_actionitems st_actionitems
st_contracts st_contracts
st_intellireport st_intellireport
st_utilities st_utilities
st_setup st_setup
st_provider st_provider
pb_tdl pb_tdl
pb_let pb_let
pb_log pb_log
pb_utl pb_utl
pb_papp pb_papp
pb_grp pb_grp
pb_priv pb_priv
pb_irpt pb_irpt
pb_std pb_std
pb_act pb_act
pb_cont pb_cont
pb_prac pb_prac
pb_cact pb_cact
pb_set pb_set
pb_map pb_map
pb_exp pb_exp
pb_imp pb_imp
pb_recruit pb_recruit
st_home st_home
st_2 st_2
p_1 p_1
end type
global w_home_screen w_home_screen

forward prototypes
public function integer of_open_screen (integer ai_screen)
public function integer of_security ()
end prototypes

public function integer of_open_screen (integer ai_screen);//Start Code Change ----04.07.2014 #V14.2 maha
//Start Code Change ----10.14.2014 #V14.2 maha - modified all open sheet to 0 for the position value

choose case ai_screen
	case 1 ///prac folder
		if gb_contract_version = false and  w_mdi.of_security_access( 40 ) > 0 then
			w_mdi.Post triggerevent("pfc_cst_practitioner")
		end if
	case 2  //contract
		if gb_contract_version = True or of_get_app_setting("set_cont","I") = 1 then
			PowerObject lpo_NullParm
			Post gf_OpenContractFolder(lpo_NullParm)			
		end if
	case 3 //action items
		if w_mdi.of_security_access( 240 ) > 0 then 
			w_mdi.Post triggerevent("pfc_cst_action_items")
		end if	
	case 4 //Reports
		if w_mdi.of_security_access( 700 ) > 0 then
			w_mdi.Post Triggerevent("pfc_cst_reports")
		end if
	case 5 //intellireport
		if w_mdi.of_security_access( 1470 ) > 0 and gi_ireport_on = 1 then
			Post OpenSheet( w_custom_report, w_mdi, 0, Original!)
		end if
	case 6  //App mapping
		IF w_mdi.of_security_access( 1460 ) > 0 and gi_iapp_on = 1 then
			Post OpenSheet( w_train_app, w_mdi, 0,Original!)			
		end if
	case 7 //Export Painter
		IF w_mdi.of_security_access( 550 ) > 0 and of_get_app_setting("set_iauto","I") = 1 THEN 
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 01.12.2015
			//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons
			//w_mdi.Post triggerevent("pfc_cst_export_painter")
			Post Open( w_export_painter )
			//------------------- APPEON END -------------------
		end if
	case 8 //import Painter 
		IF  of_get_app_setting("set_import","I") = 1 and  w_mdi.of_security_access( 6928 ) > 0 THEN
			Post OpenSheet(w_import_painter, w_mdi, 0, Original!)
		end if
	//Start Code Change ----05.21.2013 #V14 maha
	case 9 //call log
		opensheetwithparm(w_call_log,0, w_mdi, 0, Original!)
	case 10 //privileges
		OpenSheet(w_privilege_painter, w_mdi, 0, Original!)
	case 11 //groups
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 01.12.2015
		//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons

		//OpenSheet( w_group_practice, w_mdi, 0, Original!)
		Post Open( w_group_practice)
		//------------------- APPEON END -------------------

	case 12 //app printing
		//---------Begin Added by (Appeon)Harry 10.22.2014 for BugH092802--------
		Boolean lb_Maximized = false
		if isvalid (w_mdi.GetActiveSheet( )) then 
			if w_mdi.GetActiveSheet( ).classname() = "w_dashboard" and not isvalid(w_intelliApp_print) then
				lb_Maximized = true
			end if
		end if
		//---------End Added ------------------------------------------------------
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 01.12.2015
		//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons
		//OpenSheet( w_intelliApp_print, w_mdi, 0, Original!)  
		Post Open( w_intelliApp_print)  
		//------------------- APPEON END -------------------
		
		//---------Begin Added by (Appeon)Harry 10.22.2014 for BugH092802--------
		if lb_Maximized then //(Appeon)Harry 10.16.2014 - BugH092501
			if  isvalid(w_intelliApp_print) then
				if w_intelliApp_print.windowstate  = Minimized! then
					w_intelliApp_print.WindowState = Normal!
				end if
			end if
		end if
		//---------End Added ------------------------------------------------------
	case 13 //utilities
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 01.12.2015
		//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons
//		if of_get_app_setting("set_9","I") = 4 then
//			OpenSheet(w_utilities_contract, w_mdi, 0, Original!)
//		elseif gs_cust_type = "I" then  
//			OpenSheet(w_utilities_app, w_mdi, 0, Original!)
//		else
//			OpenSheet(w_utilities5, w_mdi, 0, Original!)
//		end if		
		if of_get_app_setting("set_9","I") = 4 then
			post open(w_utilities_contract)
		elseif gs_cust_type = "I" then  //Start Code Change ----06.29.2010 #V102 maha - app type utilities
			post open(w_utilities_app)
		else
			post open(w_utilities5)
		end if
		//------------------- APPEON END -------------------
	case 14 //setup
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 01.12.2015
		//<$>reason:V14.1 and V14.2 Bug # 4387 Some Pop up windows are trapped inside main screen when selected via Login or Home buttons

//		if gb_contract_version then //contract
//			OpenSheet(w_setup_central_cont, w_mdi, 0, Original!)
//		elseif gb_sk_ver then //smart
//			OpenSheet(w_setup_central_sk, w_mdi, 0, Original!)
//		elseif gs_cust_type = 'I' then //app
//			OpenSheet(w_setup_central_app , w_mdi, 0, Original!)
//		else //cred
//			OpenSheet(w_setup_central, w_mdi, 0, Original!)
//		end if
		if gb_contract_version then //contract
			Post open(w_setup_central_cont)
		elseif gb_sk_ver then //smart
			Post open(w_setup_central_sk)
		elseif gs_cust_type = 'I' then //app
			Post open(w_setup_central_app)
		else //cred
			Post open(w_setup_central)
		end if
		//------------------- APPEON END -------------------
	case 15 //letters
		Open( w_letter_generator)  //Start Code Change ----10.14.2014 #V14.2 maha - changed from opensheet
	case 16 //TD list
		OpenSheet(w_todolist, w_mdi, 0, Original!)
	case 17 //main screen
	//End Code Change ----05.21.2013 	
case 18 //Contact log actions  //Start Code Change ----11.18.2013 #V14 maha - added
	opensheetwithparm(w_call_log_open_calls,0, w_mdi, 0, Original!) 
	
case 19 //recruitment
	OpenSheet(w_recruitment_data, w_mdi, 0, Original!)
end choose
w_mdi.setfocus()  //Stephen 05.19.2011 --- Fixed a bug closing the Setup Launch Pad it also closes the Task List

	
return 1

end function

public function integer of_security ();//Start Code Change ----05.01.2014 #V14.2 maha

//provider folder
IF w_mdi.of_security_access( 40 ) = 0 THEN
	pb_prac.visible = false
	st_provider.visible = false	
else
	pb_prac.visible = true
end if

//setup
if gi_user_readonly = 1 then 
	pb_set.visible = false
	st_setup.visible = false	
else
	pb_set.visible = true
end if	

//utilities
IF w_mdi.of_security_access( 1340 ) = 0 THEN
	pb_utl.visible = false
	st_utilities.visible = false
else
	pb_utl.visible = true
end if

//ireport
IF gi_ireport_on = 0 THEN
	pb_irpt.visible = false
	st_intellireport.visible = false
Else
	IF w_mdi.of_security_access( 1470 ) = 0 THEN
		pb_irpt.visible = false
		st_intellireport.visible = false	
	else
		pb_irpt.visible = true
	end if
end if

// map apps
IF gi_iapp_on = 0 THEN
	pb_map.visible = false
	st_mapapps.visible = false	
ELse
	IF w_mdi.of_security_access( 1460 ) = 0 THEN
		pb_map.visible = false
		st_mapapps.visible = false	
	else
		pb_map.visible = True
	end if
end if

//groups
IF w_mdi.of_security_access( 1320 ) = 0 THEN
	pb_grp.visible = false
	st_groups.visible = false	
else
	pb_grp.visible = true
end if

//contracts
if gb_contract_version or gb_contract_module THEN
	if w_mdi.of_security_access( 2070 ) > 0 then
		pb_cont.visible = true
	else
		pb_cont.visible = false
		st_contracts.visible = false
	end if
else
	pb_cont.visible = false
	st_contracts.visible = false
end if

//export
IF gi_export_on = 0 THEN
	pb_exp.visible = false
	st_export.visible = false	
else
	IF w_mdi.of_security_access( 550 ) = 0 THEN
		pb_exp.visible = false
		st_export.visible = false
	else
		pb_exp.visible = true
	end if
end if

//print apps
IF gi_iapp_on = 0 THEN
	pb_papp.visible = false
	st_printapps.visible = false
else
	IF w_mdi.of_security_access( 1330 ) = 0 THEN
		pb_papp.visible = false
		st_printapps.visible = false
	else
		pb_papp.visible = true
	end if
end if

//actions
IF gb_contract_version = True THEN
	pb_act.visible = false
	st_actionitems.visible = false
else
	IF w_mdi.of_security_access( 240 ) = 0 THEN
		pb_act.visible = false
		st_actionitems.visible = false
	else
		pb_std.visible = true
	end if
end if
	
	

//import
IF of_get_app_setting("set_import","I") = 0 THEN
	pb_imp.visible = false
	st_import.visible = false
else
	//IF w_mdi.of_security_access( 240 ) = 0 THEN
	IF w_mdi.of_security_access( 6928 ) = 0 THEN	
		pb_imp.visible = false
		st_import.visible = false
	else
		pb_imp.visible = true
	end if	
	
end if

// call actions
If of_get_app_setting("set_call_log","I")	= 1 and w_mdi.of_security_access( 7671 ) > 0 THEN
	pb_cact.visible = true
else
	pb_cact.visible = false
	st_contactactions.visible = false
End if

//std reports
IF w_mdi.of_security_access( 700 ) = 0 THEN
	pb_std.visible = false
	st_stdreports.visible = false
else
	pb_std.visible = true
end if

//letters
IF w_mdi.of_security_access( 400 ) = 0 THEN
	pb_let.visible = false
	st_letters.visible = false
else
	pb_let.visible = true
end if

//call log
If of_get_app_setting("set_call_log","I")	= 1 and w_mdi.of_security_access( 7661 ) > 0 THEN
	pb_log.visible = true
else
	pb_log.visible = false
	st_contactlog.visible = false
End if

//recruitment //Start Code Change ----05.06.2014 #V14.2 maha
if w_mdi.of_security_access( 7711 ) = 0 or of_get_app_setting("set_recruit","I") = 0  THEN
	pb_recruit.visible = false
	st_rec.visible = false
else
	pb_recruit.visible = true
End if
//website
//no security

//priv
IF gi_priv_mod = 0 THEN
	pb_priv.visible = false
	st_privileges.visible = false
else
	IF w_mdi.of_security_access( 1310 ) = 0 THEN	
		pb_priv.visible = false
		st_privileges.visible = false
	Else
		pb_priv.visible = true
	End if
end if

//tdl
IF Not gb_ToDoList THEN
	pb_tdl.visible = false
	st_todolist.visible = false
else
	IF w_mdi.of_security_access( 5850 ) = 0 THEN
		pb_tdl.visible = false
		st_todolist.visible = false
	else
		pb_tdl.visible = true
	end if
end if
//

//setup
IF w_mdi.of_security_access( 7767 ) = 0 THEN
	pb_set.visible = false
	st_setup.visible = false
else
	pb_set.visible = true
end if

return 1
end function

on w_home_screen.create
this.p_2=create p_2
this.st_privileges=create st_privileges
this.st_todolist=create st_todolist
this.st_export=create st_export
this.st_printapps=create st_printapps
this.st_import=create st_import
this.st_contactlog=create st_contactlog
this.st_contactactions=create st_contactactions
this.st_letters=create st_letters
this.st_groups=create st_groups
this.st_mapapps=create st_mapapps
this.st_rec=create st_rec
this.st_stdreports=create st_stdreports
this.st_actionitems=create st_actionitems
this.st_contracts=create st_contracts
this.st_intellireport=create st_intellireport
this.st_utilities=create st_utilities
this.st_setup=create st_setup
this.st_provider=create st_provider
this.pb_tdl=create pb_tdl
this.pb_let=create pb_let
this.pb_log=create pb_log
this.pb_utl=create pb_utl
this.pb_papp=create pb_papp
this.pb_grp=create pb_grp
this.pb_priv=create pb_priv
this.pb_irpt=create pb_irpt
this.pb_std=create pb_std
this.pb_act=create pb_act
this.pb_cont=create pb_cont
this.pb_prac=create pb_prac
this.pb_cact=create pb_cact
this.pb_set=create pb_set
this.pb_map=create pb_map
this.pb_exp=create pb_exp
this.pb_imp=create pb_imp
this.pb_recruit=create pb_recruit
this.st_home=create st_home
this.st_2=create st_2
this.p_1=create p_1
this.Control[]={this.p_2,&
this.st_privileges,&
this.st_todolist,&
this.st_export,&
this.st_printapps,&
this.st_import,&
this.st_contactlog,&
this.st_contactactions,&
this.st_letters,&
this.st_groups,&
this.st_mapapps,&
this.st_rec,&
this.st_stdreports,&
this.st_actionitems,&
this.st_contracts,&
this.st_intellireport,&
this.st_utilities,&
this.st_setup,&
this.st_provider,&
this.pb_tdl,&
this.pb_let,&
this.pb_log,&
this.pb_utl,&
this.pb_papp,&
this.pb_grp,&
this.pb_priv,&
this.pb_irpt,&
this.pb_std,&
this.pb_act,&
this.pb_cont,&
this.pb_prac,&
this.pb_cact,&
this.pb_set,&
this.pb_map,&
this.pb_exp,&
this.pb_imp,&
this.pb_recruit,&
this.st_home,&
this.st_2,&
this.p_1}
end on

on w_home_screen.destroy
destroy(this.p_2)
destroy(this.st_privileges)
destroy(this.st_todolist)
destroy(this.st_export)
destroy(this.st_printapps)
destroy(this.st_import)
destroy(this.st_contactlog)
destroy(this.st_contactactions)
destroy(this.st_letters)
destroy(this.st_groups)
destroy(this.st_mapapps)
destroy(this.st_rec)
destroy(this.st_stdreports)
destroy(this.st_actionitems)
destroy(this.st_contracts)
destroy(this.st_intellireport)
destroy(this.st_utilities)
destroy(this.st_setup)
destroy(this.st_provider)
destroy(this.pb_tdl)
destroy(this.pb_let)
destroy(this.pb_log)
destroy(this.pb_utl)
destroy(this.pb_papp)
destroy(this.pb_grp)
destroy(this.pb_priv)
destroy(this.pb_irpt)
destroy(this.pb_std)
destroy(this.pb_act)
destroy(this.pb_cont)
destroy(this.pb_prac)
destroy(this.pb_cact)
destroy(this.pb_set)
destroy(this.pb_map)
destroy(this.pb_exp)
destroy(this.pb_imp)
destroy(this.pb_recruit)
destroy(this.st_home)
destroy(this.st_2)
destroy(this.p_1)
end on

event open;string s

if gs_cust_type = "I" then
	s = "IntelliApp"
elseif gb_contract_version then
	s = "IntelliContract"
else
	s = "IntelliCred"
end if

st_home.text = s + " Home"

of_security()
end event

type p_2 from picture within w_home_screen
boolean visible = false
integer x = 5
integer y = 60
integer width = 1650
integer height = 284
string picturename = "C:\ISGDev\ver14.3\isg namelogo.bmp"
boolean focusrectangle = false
end type

type st_privileges from statictext within w_home_screen
integer x = 3803
integer y = 1708
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Privileges"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_todolist from statictext within w_home_screen
integer x = 3803
integer y = 2336
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "To Do List"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_export from statictext within w_home_screen
integer x = 1582
integer y = 1708
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Export"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_printapps from statictext within w_home_screen
integer x = 1582
integer y = 2336
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Print Apps"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_import from statictext within w_home_screen
integer x = 2322
integer y = 1708
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Import"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_contactlog from statictext within w_home_screen
integer x = 3063
integer y = 2336
integer width = 535
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Contact Log"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_contactactions from statictext within w_home_screen
integer x = 2245
integer y = 2336
integer width = 690
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Contact Actions"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_letters from statictext within w_home_screen
integer x = 3063
integer y = 1708
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Letters"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_groups from statictext within w_home_screen
integer x = 846
integer y = 1716
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Groups"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_mapapps from statictext within w_home_screen
integer x = 850
integer y = 2336
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Map Apps"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_rec from statictext within w_home_screen
integer x = 3803
integer y = 1084
integer width = 539
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Recruitment"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_stdreports from statictext within w_home_screen
integer x = 3017
integer y = 1084
integer width = 626
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Std. Reports"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_actionitems from statictext within w_home_screen
integer x = 2313
integer y = 1084
integer width = 549
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Action Items"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_contracts from statictext within w_home_screen
integer x = 1582
integer y = 1084
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Contracts"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_intellireport from statictext within w_home_screen
integer x = 841
integer y = 1084
integer width = 535
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "IntelliReport"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_utilities from statictext within w_home_screen
integer x = 119
integer y = 2336
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Utilities"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_setup from statictext within w_home_screen
integer x = 101
integer y = 1708
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Setup"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_provider from statictext within w_home_screen
integer x = 101
integer y = 1084
integer width = 530
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Provider"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_tdl from picturebutton within w_home_screen
integer x = 3717
integer y = 1860
integer width = 704
integer height = 476
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\todolist14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(16)
end event

type pb_let from picturebutton within w_home_screen
integer x = 2976
integer y = 1232
integer width = 704
integer height = 476
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\letters14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(15)
end event

type pb_log from picturebutton within w_home_screen
integer x = 2976
integer y = 1860
integer width = 704
integer height = 476
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\calllog14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(9)
end event

type pb_utl from picturebutton within w_home_screen
integer x = 14
integer y = 1860
integer width = 704
integer height = 476
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\utilities14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(13)
end event

type pb_papp from picturebutton within w_home_screen
integer x = 1495
integer y = 1860
integer width = 704
integer height = 476
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\printapps14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(12)
end event

type pb_grp from picturebutton within w_home_screen
integer x = 759
integer y = 1236
integer width = 704
integer height = 476
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\groups14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(11)
end event

type pb_priv from picturebutton within w_home_screen
integer x = 3717
integer y = 1232
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\privileges14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(10)
end event

type pb_irpt from picturebutton within w_home_screen
integer x = 754
integer y = 604
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\intellireport14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(5)
end event

type pb_std from picturebutton within w_home_screen
integer x = 2976
integer y = 608
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\reports14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(4)
end event

type pb_act from picturebutton within w_home_screen
integer x = 2235
integer y = 608
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\actions14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(3)
end event

type pb_cont from picturebutton within w_home_screen
integer x = 1495
integer y = 604
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\contracts14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(2)
end event

type pb_prac from picturebutton within w_home_screen
integer x = 14
integer y = 604
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\provider14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(1)
end event

type pb_cact from picturebutton within w_home_screen
integer x = 2235
integer y = 1860
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\callactions14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(18)
end event

type pb_set from picturebutton within w_home_screen
integer x = 14
integer y = 1232
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\setup14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(14)
end event

type pb_map from picturebutton within w_home_screen
integer x = 763
integer y = 1860
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\appmap14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(6)
end event

type pb_exp from picturebutton within w_home_screen
integer x = 1495
integer y = 1232
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\export14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(7)
end event

type pb_imp from picturebutton within w_home_screen
integer x = 2235
integer y = 1232
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\import14.jpg"
alignment htextalign = left!
end type

event clicked;of_open_screen(8)
end event

type pb_recruit from picturebutton within w_home_screen
integer x = 3717
integer y = 604
integer width = 704
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "button pict\recruitment.png"
alignment htextalign = left!
end type

event clicked;of_open_screen(19)
end event

type st_home from statictext within w_home_screen
integer x = 5
integer y = 60
integer width = 2336
integer height = 372
boolean bringtotop = true
integer textsize = -30
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 8388608
string text = "IntelliSoft Home"
boolean focusrectangle = false
end type

event constructor;//this.backcolor = RGB(41 ,38, 109)
end event

type st_2 from statictext within w_home_screen
integer x = 9
integer y = 556
integer width = 4453
integer height = 1904
integer textsize = -30
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 16777215
boolean focusrectangle = false
end type

type p_1 from picture within w_home_screen
integer width = 4466
integer height = 2432
string picturename = "button pict\Home Background.jpg"
boolean focusrectangle = false
end type

