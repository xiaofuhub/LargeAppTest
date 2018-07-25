$PBExportHeader$w_quick_access_screen.srw
forward
global type w_quick_access_screen from window
end type
type pb_can from picturebutton within w_quick_access_screen
end type
type dw_1 from datawindow within w_quick_access_screen
end type
type st_1 from statictext within w_quick_access_screen
end type
type p_1 from picture within w_quick_access_screen
end type
end forward

global type w_quick_access_screen from window
integer width = 4558
integer height = 2472
windowtype windowtype = popup!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
pb_can pb_can
dw_1 dw_1
st_1 st_1
p_1 p_1
end type
global w_quick_access_screen w_quick_access_screen

on w_quick_access_screen.create
this.pb_can=create pb_can
this.dw_1=create dw_1
this.st_1=create st_1
this.p_1=create p_1
this.Control[]={this.pb_can,&
this.dw_1,&
this.st_1,&
this.p_1}
end on

on w_quick_access_screen.destroy
destroy(this.pb_can)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.p_1)
end on

type pb_can from picturebutton within w_quick_access_screen
integer x = 4151
integer y = 16
integer width = 343
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean originalsize = true
long backcolor = 29935871
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_quick_access_screen
integer x = 5
integer y = 8
integer width = 4535
integer height = 2444
integer taborder = 10
string title = "none"
string dataobject = "d_quick_access"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_ob

ls_ob = dwo.name

choose case ls_ob
	case "t_prac"
		if gb_contract_version = false and  w_mdi.of_security_access( 40 ) > 0 then
			w_mdi.Post triggerevent("pfc_cst_practitioner")
		end if
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
//			Post OpenSheet( w_custom_report, w_mdi, 4, Original!)
//		end if
//	case 6  //App mapping
//		IF w_mdi.of_security_access( 1460 ) > 0 and gi_iapp_on = 1 then
//			Post OpenSheet( w_train_app, w_mdi, 4,Original!)
//		end if
	case "t_export" //Export Painter
		IF w_mdi.of_security_access( 550 ) > 0 and of_get_app_setting("set_iauto","I") = 1 THEN 
			w_mdi.Post triggerevent("pfc_cst_export_painter")
		end if
//	case 8 //import Painter 
//		IF  of_get_app_setting("set_import","I") = 1 and  w_mdi.of_security_access( 6928 ) > 0 THEN
//			Post OpenSheet(w_import_painter, w_mdi, 4, Original!)
//		end if
//	//Start Code Change ----05.21.2013 #V14 maha
//	case 9 //call log
//		opensheetwithparm(w_call_log,0, w_mdi, 4, Original!)
//	case 10 //privileges
//		OpenSheet(w_privilege_painter, w_mdi, 4, Original!)
//	case 11 //groups
//		OpenSheet( w_group_practice, w_mdi, 4, Original!)
//	case 12 //app printing
//		OpenSheet( w_intelliApp_print, w_mdi, 4, Original!)
//	case 13 //utilities
//		if of_get_app_setting("set_9","I") = 4 then
//			OpenSheet(w_utilities_contract, w_mdi, 4, Original!)
//		elseif gs_cust_type = "I" then  
//			OpenSheet(w_utilities_app, w_mdi, 4, Original!)
//		else
//			OpenSheet(w_utilities5, w_mdi, 4, Original!)
//		end if
//	case 14 //setup
//		if gb_contract_version then //contract
//			OpenSheet(w_setup_central_cont, w_mdi, 4, Original!)
//		elseif gb_sk_ver then //smart
//			OpenSheet(w_setup_central_sk, w_mdi, 4, Original!)
//		elseif gs_cust_type = 'I' then //app
//			OpenSheet(w_setup_central_app , w_mdi, 4, Original!)
//		else //cred
//			OpenSheet(w_setup_central, w_mdi, 4, Original!)
//		end if
//	case 15 //letters
//		OpenSheet( w_letter_generator , w_mdi, 4, Original!)
//	case 16 //TD list
//		OpenSheet(w_todolist, w_mdi, 4, original!)
//	case 17 //main screen
//	//End Code Change ----05.21.2013 	
end choose


messagebox("", ls_ob)
end event

type st_1 from statictext within w_quick_access_screen
integer x = 55
integer y = 176
integer width = 3397
integer height = 240
integer textsize = -36
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 8388608
string text = "IntelliCred for Windows Quick Access"
boolean focusrectangle = false
end type

event constructor;this.backcolor = 7153193
end event

type p_1 from picture within w_quick_access_screen
boolean visible = false
integer x = 9
integer y = 12
integer width = 4503
integer height = 2416
string picturename = "button pict\quick access background.jpg"
boolean focusrectangle = false
end type

