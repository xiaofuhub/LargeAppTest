$PBExportHeader$w_intellicred_report_design.srw
forward
global type w_intellicred_report_design from w_main
end type
type cb_resize from commandbutton within w_intellicred_report_design
end type
type cb_exit from commandbutton within w_intellicred_report_design
end type
type cb_save from commandbutton within w_intellicred_report_design
end type
type uo_design from u_cst_dw_design within w_intellicred_report_design
end type
end forward

global type w_intellicred_report_design from w_main
integer width = 4745
integer height = 2316
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
event ue_nclbuttondblclk pbm_nclbuttondblclk
cb_resize cb_resize
cb_exit cb_exit
cb_save cb_save
uo_design uo_design
end type
global w_intellicred_report_design w_intellicred_report_design

type variables
//added by gavin on 2009-03-04
Boolean  ib_disable_activate
String   is_OrgSyntax
//------------end--------------
end variables

event ue_nclbuttondblclk;if This.Windowstate = Maximized! then
	This.Windowstate = Normal!
else
	This.Windowstate = Maximized!
end if

Return 1

end event

on w_intellicred_report_design.create
int iCurrent
call super::create
this.cb_resize=create cb_resize
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.uo_design=create uo_design
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_resize
this.Control[iCurrent+2]=this.cb_exit
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.uo_design
end on

on w_intellicred_report_design.destroy
call super::destroy
destroy(this.cb_resize)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.uo_design)
end on

event activate;call super::activate;IF ib_disable_activate THEN RETURN

end event

event closequery;string   ls_Syntax
int  li

//uo_design.dw_properties_dw.AcceptText() //Add by Evan 07/18/2008
ls_Syntax = uo_design.uo_band.dw_syntax.describe("datawindow.syntax")

//IF ls_Syntax <> is_OrgSyntax or uo_design.dw_properties_dw.ModifiedCount() > 0 THEN //Modify by Evan 07/18/2008
IF ls_Syntax <> uo_design.is_OrgSyntax or uo_design.ib_DoSave then
	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF li = 1 THEN
		cb_save.triggerevent("clicked")
	ELSEIF li = 3 THEN
		return 1
	END IF
END IF
end event

event open;call super::open;//
//modify by gavin on 2009/3/4
this.of_SetBase(true)
this.inv_base.of_center()

str_custom_report lstr
datawindow ldw_item
long       li_data_view

IF gb_se_version THEN
	uo_design.il_data_view_id = 2
	This.Title = "Advanced Screen Design"
END IF

lstr = message.PowerObjectParm
ldw_item = lstr.adw_preview
li_data_view = lstr.al_view_id

uo_design.of_set_parent_window( This )
//uo_design.of_Setup( False )
uo_design.of_Setup_painter()

//modify by gavin on 2009/3/2
uo_design.of_init(this,'report',ldw_item,li_data_view)
uo_design.of_set_datagroup(true)

//Added by Appeon long.zhang 05.16.2016 (Bug id 5146 - Some Computed fields not saving in PDF document)
uo_design.of_set_gb_sendtoback(True)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.06.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
/*
This.y = 296
This.Width = 3543
This.Height = 1800
*/
this.resize( 4009,2500)
//This.Width = 4009
//This.Height = 2500

//---------------------------- APPEON END ----------------------------

uo_design.x = 1
uo_design.y = 1
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.06.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
/*
uo_design.width = 3543
uo_design.height = 1712
*/
uo_design.width = 3980
uo_design.height = 2300

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-07 By: Andy
uo_design.uo_band.dw_header.of_setuserobject( uo_design)
uo_design.uo_band.dw_detail.of_setuserobject( uo_design)
uo_design.uo_band.dw_Summary.of_setuserobject( uo_design)
uo_design.uo_band.dw_footer.of_setuserobject( uo_design)
//modify by gavin 2009/3/2
uo_design.uo_band.dw_headergroup.of_setuserobject( uo_design)
uo_design.uo_band.dw_headergroup2.of_setuserobject( uo_design)
uo_design.uo_band.dw_headergroup3.of_setuserobject( uo_design)
uo_design.uo_band.dw_trailergroup.of_setuserobject( uo_design)
uo_design.uo_band.dw_trailergroup2.of_setuserobject( uo_design)
uo_design.uo_band.dw_trailergroup3.of_setuserobject( uo_design)
//---------------------------- APPEON END ----------------------------

integer li_Return
li_Return = uo_design.Event pfc_cst_select_view()
if li_Return = -1 then
	Close(this)
	Return
end if

end event

event resize;call super::resize; if AppeonGetClientType() = "WEB" then this.setredraw(false)  //(Appeon)Harry 05.07.2014 - for Bug #4021
//Modified by gavin on 2009-03-05
uo_Design.x = 1
uo_Design.y = 1
uo_Design.height = this.height - 250
uo_Design.width = this.width - 20

cb_save.y   = uo_Design.y + uo_Design.height + 10
cb_exit.y   = cb_save.y

//BEGIN---Modify by Scofield on 2009-12-30
//cb_Resize.X = This.Width - cb_Resize.Width - 30
cb_Resize.Y = cb_save.y

cb_exit.x = This.Width - cb_exit.width - 30
cb_save.x = cb_exit.x - cb_save.width - 20
cb_resize.x = cb_save.x - cb_resize.width - 20

if SizeType = 0 then
	cb_resize.text = '&Maximized'
elseif SizeType = 2 then
	cb_resize.text = '&Normal'
end if
//END---Modify by Scofield on 2009-12-30

 if AppeonGetClientType() = "WEB" then this.setredraw(true)  //(Appeon)Harry 05.07.2014 - for Bug #4021
end event

event timer;call super::timer;if uo_design.uo_band.ib_MouseDown and KeyDown(KeyLeftButton!) then
	uo_design.uo_band.of_Modify_Rectangle_Frame()
else
	Timer(0)
	uo_design.uo_band.TriggerEvent("lbuttonup")	
end if

end event

event pfc_preopen;call super::pfc_preopen;long ll_i
string ls_scale

uo_design.of_set_isshowtree(False)

end event

type cb_resize from commandbutton within w_intellicred_report_design
integer x = 3657
integer y = 2132
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Maximized"
end type

event clicked;if Parent.WindowState = Maximized! then
	uo_design.ib_max = false //(Appeon)Stephen 08.29.2017 - Bug id 5780 - IntelliReport Advanced Screen Design Maximized SaaS 15.3 Build 08092017, 08152017, C/S 08102017
	Parent.WindowState = Normal!
else
	uo_design.ib_max = true //(Appeon)Stephen 08.29.2017 - Bug id 5780 - IntelliReport Advanced Screen Design Maximized SaaS 15.3 Build 08092017, 08152017, C/S 08102017
	Parent.WindowState = Maximized!
end if

end event

type cb_exit from commandbutton within w_intellicred_report_design
integer x = 4389
integer y = 2132
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//Exit
Close(parent)
end event

type cb_save from commandbutton within w_intellicred_report_design
integer x = 4023
integer y = 2132
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//modify by gavin on 2009/3/4
parent.uo_design.of_save_report()
end event

type uo_design from u_cst_dw_design within w_intellicred_report_design
integer height = 2124
integer taborder = 40
end type

on uo_design.destroy
call u_cst_dw_design::destroy
end on

