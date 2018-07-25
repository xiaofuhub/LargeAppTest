$PBExportHeader$w_wv_priv_view_setting.srw
forward
global type w_wv_priv_view_setting from w_sheet
end type
type cb_2 from commandbutton within w_wv_priv_view_setting
end type
type cb_save from commandbutton within w_wv_priv_view_setting
end type
type dw_special_opt from u_dw within w_wv_priv_view_setting
end type
type dw_field_opt from u_dw within w_wv_priv_view_setting
end type
type gb_1 from groupbox within w_wv_priv_view_setting
end type
type gb_2 from groupbox within w_wv_priv_view_setting
end type
end forward

global type w_wv_priv_view_setting from w_sheet
integer width = 3374
integer height = 1812
string title = "WebView Privilege View Options"
boolean maxbox = false
long backcolor = 33551856
cb_2 cb_2
cb_save cb_save
dw_special_opt dw_special_opt
dw_field_opt dw_field_opt
gb_1 gb_1
gb_2 gb_2
end type
global w_wv_priv_view_setting w_wv_priv_view_setting

type variables
boolean ib_save
end variables

on w_wv_priv_view_setting.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_save=create cb_save
this.dw_special_opt=create dw_special_opt
this.dw_field_opt=create dw_field_opt
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.dw_special_opt
this.Control[iCurrent+4]=this.dw_field_opt
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_2
end on

on w_wv_priv_view_setting.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.dw_special_opt)
destroy(this.dw_field_opt)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> Privilege View options (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 02.27.2012 by Stephen
// $<modify> 03.20.2012 by Evan --- Fixed bug
//////////////////////////////////////////////////////////////////////

integer li_Exists

gnv_appeondb.of_StartQueue()
select Count(*) into :li_Exists from sysobjects where name = 'wv_priv_view_settings' and type = 'U';
dw_field_opt.Retrieve()
dw_special_opt.Retrieve()
gnv_appeondb.of_CommitQueue()

if IsNull(li_Exists) or li_Exists <> 1 then
	MessageBox("Warning", "This module is unavailable currently because he privilege view options have not been upgraded in WebView.", Exclamation!)
	Close(this)
	Return
end if
end event

event closequery;call super::closequery;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> Privilege View options (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 02.27.2012 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_Result

if dw_field_opt.modifiedcount() > 0 or dw_special_opt.modifiedcount() > 0 then
	li_Result = MessageBox("Save", "Do you want to save changes?", Question!, YesNoCancel!)
	choose case li_Result
		case 1
			cb_save.event clicked()
			if not ib_save then return 1
		case 2
			return 0
		case 3
			return 1
	end choose
	
end if
return 0
end event

type cb_2 from commandbutton within w_wv_priv_view_setting
integer x = 2935
integer y = 52
integer width = 370
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description>  Privilege View options (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.27.2012 by Stephen
//////////////////////////////////////////////////////////////////////
close(parent)
end event

type cb_save from commandbutton within w_wv_priv_view_setting
integer x = 2450
integer y = 52
integer width = 462
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save Settings"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> Privilege View options (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 02.27.2012 by Stephen
//////////////////////////////////////////////////////////////////////

ib_save = true
dw_field_opt.accepttext()
dw_special_opt.accepttext()
if dw_field_opt.update() = 1 and dw_special_opt.update() = 1 then
	commit using sqlca;
else
	MessageBox("Error", "Failed to save data.", StopSign!)
	ib_save = false
	rollback using sqlca;
end if
end event

type dw_special_opt from u_dw within w_wv_priv_view_setting
integer x = 2011
integer y = 236
integer width = 1262
integer height = 516
integer taborder = 20
string dataobject = "d_wv_field_special"
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> Privilege View options (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 02.27.2012 by Stephen
//////////////////////////////////////////////////////////////////////
if row < 1 then return

this.selectrow(0, false)
this.selectrow(row, true)
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description>  Privilege View options (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.27.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false)
end event

type dw_field_opt from u_dw within w_wv_priv_view_setting
integer x = 37
integer y = 72
integer width = 1888
integer height = 1580
integer taborder = 10
string dataobject = "d_wv_field_display"
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> Privilege View options (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 02.27.2012 by Stephen
//////////////////////////////////////////////////////////////////////
if row < 1 then return

this.selectrow(0, false)
this.selectrow(row, true)
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description>  Privilege View options (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.27.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false)
end event

type gb_1 from groupbox within w_wv_priv_view_setting
integer x = 14
integer y = 12
integer width = 1952
integer height = 1672
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Field Display Options"
borderstyle borderstyle = stylebox!
end type

type gb_2 from groupbox within w_wv_priv_view_setting
integer x = 1979
integer y = 160
integer width = 1335
integer height = 624
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Special Options"
borderstyle borderstyle = stylebox!
end type

