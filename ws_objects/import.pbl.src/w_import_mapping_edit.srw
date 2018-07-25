$PBExportHeader$w_import_mapping_edit.srw
$PBExportComments$(Appeon)Toney 06.14.2013 - V141 ISG-CLX
forward
global type w_import_mapping_edit from window
end type
type cb_report from commandbutton within w_import_mapping_edit
end type
type st_1 from statictext within w_import_mapping_edit
end type
type cb_close from commandbutton within w_import_mapping_edit
end type
type cb_save from commandbutton within w_import_mapping_edit
end type
type dw_4 from u_dw within w_import_mapping_edit
end type
type dw_imp_field from u_dw within w_import_mapping_edit
end type
type dw_map_fileld from u_dw within w_import_mapping_edit
end type
type dw_mapps from u_dw within w_import_mapping_edit
end type
end forward

global type w_import_mapping_edit from window
integer width = 4174
integer height = 2248
boolean titlebar = true
string title = "Import Mappings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_report cb_report
st_1 st_1
cb_close cb_close
cb_save cb_save
dw_4 dw_4
dw_imp_field dw_imp_field
dw_map_fileld dw_map_fileld
dw_mapps dw_mapps
end type
global w_import_mapping_edit w_import_mapping_edit

on w_import_mapping_edit.create
this.cb_report=create cb_report
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_4=create dw_4
this.dw_imp_field=create dw_imp_field
this.dw_map_fileld=create dw_map_fileld
this.dw_mapps=create dw_mapps
this.Control[]={this.cb_report,&
this.st_1,&
this.cb_close,&
this.cb_save,&
this.dw_4,&
this.dw_imp_field,&
this.dw_map_fileld,&
this.dw_mapps}
end on

on w_import_mapping_edit.destroy
destroy(this.cb_report)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_4)
destroy(this.dw_imp_field)
destroy(this.dw_map_fileld)
destroy(this.dw_mapps)
end on

type cb_report from commandbutton within w_import_mapping_edit
integer x = 3013
integer y = 100
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Report"
end type

type st_1 from statictext within w_import_mapping_edit
integer x = 133
integer y = 20
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select Import"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_import_mapping_edit
integer x = 3749
integer y = 100
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type cb_save from commandbutton within w_import_mapping_edit
integer x = 3383
integer y = 100
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

type dw_4 from u_dw within w_import_mapping_edit
integer x = 119
integer y = 88
integer height = 100
integer taborder = 10
end type

type dw_imp_field from u_dw within w_import_mapping_edit
integer x = 1783
integer y = 1316
integer width = 1614
integer height = 724
integer taborder = 10
boolean titlebar = true
string title = "Import Field Detail"
string dataobject = "d_import_field_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_map_fileld from u_dw within w_import_mapping_edit
integer x = 1783
integer y = 228
integer width = 2309
integer height = 1048
integer taborder = 10
boolean titlebar = true
string title = "Mapping Detail"
string dataobject = "d_import_map_detail_indv"
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_mapps from u_dw within w_import_mapping_edit
integer x = 114
integer y = 228
integer height = 1820
integer taborder = 10
boolean titlebar = true
string title = "Import Field Mappings"
end type

