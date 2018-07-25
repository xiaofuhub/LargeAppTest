$PBExportHeader$w_security_user_personal_settings.srw
forward
global type w_security_user_personal_settings from window
end type
type cb_1 from commandbutton within w_security_user_personal_settings
end type
type dw_audit from datawindow within w_security_user_personal_settings
end type
type cb_save from commandbutton within w_security_user_personal_settings
end type
type cb_close from commandbutton within w_security_user_personal_settings
end type
type dw_1 from u_dw within w_security_user_personal_settings
end type
end forward

global type w_security_user_personal_settings from window
integer width = 2798
integer height = 1632
boolean titlebar = true
string title = "Personal Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_audit dw_audit
cb_save cb_save
cb_close cb_close
dw_1 dw_1
end type
global w_security_user_personal_settings w_security_user_personal_settings

forward prototypes
public function integer of_write_audit ()
end prototypes

public function integer of_write_audit ();//Start Code Change ----02.25.2013 #V12 maha - added.  Copied from user painter pfc_preupdate for dw_roles
Long ll_recid
string ls_old
string ls_new
string ls_column
string ls_type
datetime ldt_now
integer i
integer ic
integer nr

dw_1.accepttext()

//Start Code Change ----06.25.2009 #V92 maha - role audit functionality for ameripath
IF dw_1.GetItemStatus( 1, 0, Primary! ) = DataModified! THEN
	select max(rec_id) into :ll_recid from sys_audit_user;
	if isnull(ll_recid) then ll_recid = 0
	ldt_now = datetime(today(),now())
	
	FOR i = 1 TO 14   //(Appeon)Stephen 12.27.2014 - Modify 9 to 14 --NPDB QRXS using proxy 
		choose case i
			case 1
				ls_column = "user_name"
				ls_type = "S"
			case 2
				ls_column = "npdb_user_id"
				ls_type = "S"
			case 3
				ls_column = "npdb_password"
				ls_type = "S"
			case 4
				ls_column = "set_go_on_open"
				ls_type = "N"
			case 5
				ls_column = "set_tdl"
				ls_type = "N"
			case 6
				ls_column = "set_task"
				ls_type = "N"
			case 7
				ls_column = "set_dashboard"
				ls_type = "N"
			case 8
				ls_column = "set_3"
				ls_type = "N"
			case 9
				ls_column = "set_4"
				ls_type = "N"
		   //---------Begin Added by (Appeon)Stephen 12.27.2014 for NPDB QRXS using proxy--------
			case 10
				ls_column = "npdb_proxyhostname"
				ls_type = "S"
			case 11
				ls_column = "npdb_proxyport"
				ls_type = "S"
			case 12
				ls_column = "npdb_proxyuser"
				ls_type = "S"
			case 13
				ls_column = "npdb_proxypassword"
				ls_type = "S"
			case 14
				ls_column = "npdb_proxydomain"
				ls_type = "S"
		   //---------End Added ------------------------------------------------------
		end choose
		
		if dw_1.getitemstatus( 1, ls_column, primary!) <> datamodified! then continue
		
		//Start Code Change ----11.17.2014 #V14.2 maha - added trap to blank this field
		if ls_column = "npdb_password" or ls_column = "npdb_proxypassword" then //(Appeon)Stephen 12.27.2014 - add 'ls_column = "npdb_proxypassword"' --NPDB QRXS using proxy 
			ls_new = '*******'
			ls_old = '********'
		 //End Code Change ----11.17.2014
		elseif ls_type = "S" then
			ls_new = dw_1.getitemstring(1,ls_column)
			ls_old = dw_1.getitemstring(1,ls_column,primary!,true)
		elseif ls_type = "N" then
			ls_new = string(dw_1.getitemnumber(1,ls_column))
			ls_old = string( dw_1.getitemnumber(1,ls_column,primary!,true))
		end if
		if ls_old <> ls_new then
		//if dw_1.getitemstatus( i, "security_roles_rights_value_id", primary!) = datamodified! then
			nr = dw_audit.insertrow(0)
			dw_audit.setitem(nr,"user_id",dw_1.getitemstring(1,"user_id"))
			dw_audit.setitem(nr,"field_name", ls_column)
			//dw_audit.setitem(nr,"sub_id",dw_1.getitemnumber(i,"sub_module_id"))
			//dw_audit.setitem(nr,"action_id",dw_1.getitemnumber(i,"action_id"))
			dw_audit.setitem(nr,"audit_type","E")
	
			dw_audit.setitem(nr,"new_value",ls_new)
			dw_audit.setitem(nr,"old_value",ls_old)
			ll_recid++
			dw_audit.setitem(nr,"rec_id",ll_recid)
			dw_audit.setitem(nr,"date_time_modified",ldt_now)
			dw_audit.setitem(nr,"mod_by",gs_user_id )		
		end if
	END FOR	
	
	i = dw_audit.update()
//	messagebox("",i)
end if
//End Code Change---06.25.2009


RETURN 1
end function

on w_security_user_personal_settings.create
this.cb_1=create cb_1
this.dw_audit=create dw_audit
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_audit,&
this.cb_save,&
this.cb_close,&
this.dw_1}
end on

on w_security_user_personal_settings.destroy
destroy(this.cb_1)
destroy(this.dw_audit)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event open;if gb_sk_ver then
	dw_1.dataobject = "d_security_user_personal_sets_sk"
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user_id)


end event

type cb_1 from commandbutton within w_security_user_personal_settings
integer x = 5
integer y = 20
integer width = 494
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Security Questions"
end type

event clicked;open(w_security_user_quest_add)
end event

type dw_audit from datawindow within w_security_user_personal_settings
boolean visible = false
integer x = 1742
integer y = 1336
integer width = 411
integer height = 204
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_view_audit_user"
boolean hscrollbar = true
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type cb_save from commandbutton within w_security_user_personal_settings
integer x = 2034
integer y = 24
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;of_write_audit()

dw_1.update()

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 10.16.2014
//<$>reason:After changing “Home Icon on Menubar”, menu toolbar is not immediately refreshed
if dw_1.getitemnumber(1,'set_home') = 0 then 
		gb_home_icon = False
else
		gb_home_icon = True	
end if
//------------------- APPEON END -------------------


end event

type cb_close from commandbutton within w_security_user_personal_settings
integer x = 2405
integer y = 24
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_1 from u_dw within w_security_user_personal_settings
integer y = 136
integer width = 2784
integer height = 1404
integer taborder = 30
string dataobject = "d_security_user_personal_sets"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked; //Start Code Change ----04.07.2015 #V15 maha - added to allow user to check their password
string s

if dwo.name = "b_view_pass" then
	s = this.getitemstring(1,"npdb_password")
	if len(s) > 1 then
		//login again??
		messagebox("NPDB Password", s)
	end if
end if

	
end event

event itemchanged;call super::itemchanged;
if  dwo.name = 'font_zoom' then  //Start Code Change ----08.01.2017 #V154 maha
	//---------Begin Modified by (Appeon)Stephen 10.23.2017 for Alpha Testing V15.4 Cosmetic Bug # 5849 - Personal Settings->Zoom Setting info window:  Extra space in message--------
	//messagebox("Zoom Setting","You may have to  close open windows for the Zoom to display properly.")
	messagebox("Zoom Setting","You may have to close all open windows for the zoom to display properly.")
	//---------End Modfiied ------------------------------------------------------
	gi_zoom = integer(data)
end if
end event

