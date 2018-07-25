$PBExportHeader$w_import_linkvalue_setting.srw
forward
global type w_import_linkvalue_setting from window
end type
type cb_cancel from commandbutton within w_import_linkvalue_setting
end type
type dw_data from u_dw within w_import_linkvalue_setting
end type
type cb_ok from commandbutton within w_import_linkvalue_setting
end type
end forward

global type w_import_linkvalue_setting from window
integer width = 1902
integer height = 808
boolean titlebar = true
string title = "Facility Link Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
dw_data dw_data
cb_ok cb_ok
end type
global w_import_linkvalue_setting w_import_linkvalue_setting

type variables
datawindow idw_data
end variables

on w_import_linkvalue_setting.create
this.cb_cancel=create cb_cancel
this.dw_data=create dw_data
this.cb_ok=create cb_ok
this.Control[]={this.cb_cancel,&
this.dw_data,&
this.cb_ok}
end on

on w_import_linkvalue_setting.destroy
destroy(this.cb_cancel)
destroy(this.dw_data)
destroy(this.cb_ok)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 11.09.2009
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_table_id
DataWindowChild ldwc_child

idw_data = Message.PowerObjectParm
ll_Row = idw_data.GetRow()
ll_table_id = idw_data.object.isoft_table_id[ll_Row]
choose case ll_table_id
	case 2
		dw_data.DataObject = "d_import_table_lv_spec"
	case 9
		dw_data.DataObject = "d_import_table_lv_hosp"
	case 20
		dw_data.DataObject = "d_import_table_lv_address"
end choose

dw_data.SetTransObject(SQLCA)
dw_data.InsertRow(0)
dw_data.object.data[1] = idw_data.object.data[ll_Row]
dw_data.ResetUpdate()

if dw_data.GetChild("lv_primary_hosp", ldwc_child) = 1 then
	ldwc_child.SelectRow(0, false)
	ldwc_child.InsertRow(1)
end if
if dw_data.GetChild("lv_practicing", ldwc_child) = 1 then
	ldwc_child.SelectRow(0, false)
	ldwc_child.InsertRow(1)
end if

if w_import_painter.ib_LockFile then
	dw_data.Modify("datawindow.readonly='Yes'")
	cb_ok.Enabled = false
end if
end event

type cb_cancel from commandbutton within w_import_linkvalue_setting
integer x = 1504
integer y = 560
integer width = 343
integer height = 92
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

event clicked;Close(Parent)
end event

type dw_data from u_dw within w_import_linkvalue_setting
event mousemove pbm_mousemove
integer x = 23
integer y = 20
integer width = 1842
integer height = 520
integer taborder = 10
string dragicon = "droparrow.ico"
string dataobject = "d_import_table_lv_hosp"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dberror;Return 1
end event

event itemchanged;call super::itemchanged;if this.DataObject = "d_import_table_lv_address" then
	if dwo.name = "lv_primary_office" and data = '1' then
		this.Post SetItem(Row, "lv_additional_office", 0)
	end if
	if dwo.name = "lv_additional_office" and data = '1' then
		this.Post SetItem(Row, "lv_primary_office", 0)
	end if
end if
end event

type cb_ok from commandbutton within w_import_linkvalue_setting
integer x = 1129
integer y = 560
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 11.09.2009
//////////////////////////////////////////////////////////////////////

long ll_Row

// Set flag value
dw_data.SetItem(1, "address_link_set", 0)
if dw_data.object.lv_primary_office[1] = 1 then dw_data.SetItem(1, "address_link_set", 1)
if dw_data.object.lv_additional_office[1] = 1 then dw_data.SetItem(1, "address_link_set", 1)
if dw_data.object.lv_billing[1] = 1 then dw_data.SetItem(1, "address_link_set", 1)
if dw_data.object.lv_home_address[1] = 1 then dw_data.SetItem(1, "address_link_set", 1)
if dw_data.object.lv_mailing[1] = 1 then dw_data.SetItem(1, "address_link_set", 1)
if dw_data.object.lv_exp_letters[1] = 1 then dw_data.SetItem(1, "address_link_set", 1)
if dw_data.object.lv_include_in_directory[1] = 1 then dw_data.SetItem(1, "address_link_set", 1)
if dw_data.object.lv_match_gp[1] = 1 then dw_data.SetItem(1, "address_link_set", 1)
dw_data.SetItem(1, "hosp_facility_link_set", 0)
if dw_data.object.lv_primary_hosp[1] > 0 then dw_data.SetItem(1, "hosp_facility_link_set", 1)
dw_data.SetItem(1, "spec_facility_link_set", 0)
if dw_data.object.lv_practicing[1] > 0 then dw_data.SetItem(1, "spec_facility_link_set", 1)

// Save data
if dw_data.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", "Failed to save data.", StopSign!)
	Return
end if
ll_Row = idw_data.GetRow()
idw_data.object.data[ll_Row] = dw_data.object.data[1]
idw_data.ResetUpdate()

Close(Parent)
end event

