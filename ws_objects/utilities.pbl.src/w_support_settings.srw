$PBExportHeader$w_support_settings.srw
forward
global type w_support_settings from window
end type
type st_1 from statictext within w_support_settings
end type
type cb_4 from commandbutton within w_support_settings
end type
type cb_3 from commandbutton within w_support_settings
end type
type cb_2 from commandbutton within w_support_settings
end type
type cb_1 from commandbutton within w_support_settings
end type
type dw_1 from datawindow within w_support_settings
end type
end forward

global type w_support_settings from window
integer x = 827
integer y = 364
integer width = 1477
integer height = 1532
boolean titlebar = true
string title = "Module Switches"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_support_settings w_support_settings

type variables
integer ii_sechange = 0
end variables

forward prototypes
public function integer of_setup_icse ()
end prototypes

public function integer of_setup_icse ();UPDATE icred_settings
SET set_ireport = 0,
    set_iauto = 0,
    set_iapps = 0,
    set_meetings = 1,
    set_11 = 0,
    set_priv = 0,
    set_img = 0,
    set_peer = 0,
    set_31 = 1 , //intelliapp dash board
	 set_37 = 0;  //department level

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 156;

UPDATE security_roles_rights
SET value_id = 0
WHERE rights_id = 663;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 161;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 601;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 593;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 599;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 158;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 653;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 155;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 589;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 625;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 605;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 1659;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 613;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 169;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 132;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 146;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 162;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 160;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 168;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 145;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 2000;

UPDATE security_roles_rights
SET value_id = 0 
WHERE rights_id = 900;



UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 145;

UPDATE security_roles_rights
SET value_id = 1 
WHERE rights_id = 591;

UPDATE security_roles_rights
SET value_id = 1 
WHERE rights_id = 619;

UPDATE security_roles_rights
SET value_id = 1 
WHERE rights_id = 167;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 165;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 133;


UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 159;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 144;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 149;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 119;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 166;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 157;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 140;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 118;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 121;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 123;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 124;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 131;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 165;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 145;

UPDATE security_roles_rights
SET value_id = 1
WHERE rights_id = 167;



Return 0
end function

on w_support_settings.create
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_support_settings.destroy
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type st_1 from statictext within w_support_settings
integer x = 123
integer y = 1240
integer width = 1239
integer height = 156
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217857
long backcolor = 67108864
string text = "NO longer used"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_support_settings
integer x = 73
integer y = 36
integer width = 805
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Store image files in the database"
end type

event clicked;Open( w_store_image_in_db )
end event

type cb_3 from commandbutton within w_support_settings
boolean visible = false
integer x = 2098
integer y = 1272
integer width = 352
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Other Settings"
end type

event clicked;open(w_sys_field_utility)
end event

type cb_2 from commandbutton within w_support_settings
integer x = 1129
integer y = 36
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;gds_settings.retrieve()

close(parent)
end event

type cb_1 from commandbutton within w_support_settings
integer x = 878
integer y = 36
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;Integer li_ans

dw_1.update()

IF ii_sechange = 1 THEN
	//li_ans = MessageBox( "IntelliCred SE", "Are you sure you want to change this to an IntelliCred SE version?", StopSign!, YesNo!, 2 )
	//IF li_ans = 1 THEN
		of_Setup_ICSE( )
	//END IF
END IF

commit using sqlca;
end event

type dw_1 from datawindow within w_support_settings
integer x = 73
integer y = 168
integer width = 1280
integer height = 1056
integer taborder = 10
string dataobject = "d_support_set"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer li_ans

this.accepttext()

IF This.GetColumnName() = "set_9" THEN
	if this.getitemnumber(1,'set_9') = 1 then //setting for IntelliApp customers
		gs_cust_type = "I"
	elseif this.getitemnumber(1,'set_9') = 2 then
		li_ans = MessageBox( "IntelliCred SE", "Are you sure you want to change this to an IntelliCred SE version?~r If you say YES, selected security settings will be set for all roles.  Corrections will have to be made manually. ", StopSign!, YesNo!, 2 )
		IF li_ans = 1 THEN
			ii_sechange = 1
		else
			ii_sechange = 0
		END IF
	else
		gs_cust_type = ""
	end if
end if

IF This.GetColumnName() = "set_iauto" THEN
	if this.getitemnumber(1,'set_iauto') = 1 then // has export module
		gi_export_on = 1
	else
		gi_export_on = 0
	end if
end if

IF This.GetColumnName() = "set_ireport" THEN  // has intellireport module
	if this.getitemnumber(1,'set_ireport') = 1 then
		gi_ireport_on = 1
	else
		gi_ireport_on = 0
	end if
end if

IF This.GetColumnName() = "set_iapps" THEN  // has application printing module
	if this.getitemnumber(1,'set_iapps') = 1 then
		gi_iapp_on = 1
	else
		gi_iapp_on = 0
	end if
end if


end event

