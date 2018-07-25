$PBExportHeader$w_export_priv_procedures.srw
forward
global type w_export_priv_procedures from window
end type
type dw_lookup from datawindow within w_export_priv_procedures
end type
type cb_sort from commandbutton within w_export_priv_procedures
end type
type cb_delete from commandbutton within w_export_priv_procedures
end type
type cb_save from commandbutton within w_export_priv_procedures
end type
type cb_import from commandbutton within w_export_priv_procedures
end type
type cb_close from commandbutton within w_export_priv_procedures
end type
type dw_import from datawindow within w_export_priv_procedures
end type
end forward

global type w_export_priv_procedures from window
integer width = 3168
integer height = 2132
boolean titlebar = true
string title = "Export Privilege Procedures"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_lookup dw_lookup
cb_sort cb_sort
cb_delete cb_delete
cb_save cb_save
cb_import cb_import
cb_close cb_close
dw_import dw_import
end type
global w_export_priv_procedures w_export_priv_procedures

on w_export_priv_procedures.create
this.dw_lookup=create dw_lookup
this.cb_sort=create cb_sort
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_import=create cb_import
this.cb_close=create cb_close
this.dw_import=create dw_import
this.Control[]={this.dw_lookup,&
this.cb_sort,&
this.cb_delete,&
this.cb_save,&
this.cb_import,&
this.cb_close,&
this.dw_import}
end on

on w_export_priv_procedures.destroy
destroy(this.dw_lookup)
destroy(this.cb_sort)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_import)
destroy(this.cb_close)
destroy(this.dw_import)
end on

type dw_lookup from datawindow within w_export_priv_procedures
boolean visible = false
integer x = 55
integer y = 48
integer width = 750
integer height = 136
integer taborder = 10
string title = "none"
string dataobject = "d_code_lookup"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_sort from commandbutton within w_export_priv_procedures
integer x = 2149
integer y = 48
integer width = 247
integer height = 68
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_import.SetSort(null_str)

dw_import.Sort( )
end event

type cb_delete from commandbutton within w_export_priv_procedures
integer x = 2149
integer y = 116
integer width = 247
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;dw_import.deleterow(0)
end event

type cb_save from commandbutton within w_export_priv_procedures
integer x = 1632
integer y = 72
integer width = 375
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "2) Export data"
end type

event clicked;
string ls_path, ls_file
int li_rc

ls_path = gs_dir_path + "\Priv Procd export.txt" 

//li_rc = GetFileSaveName ( "Select File",    ls_path, ls_file , "Text",    "Text Files (*.txt),*.txt" , gs_dir_path ,    32770)
li_rc = GetFileSaveName("Select File", ls_path, ls_file, "Text", 	"Text Files (*.TXT),*.TXT," )

dw_import.saveas( ls_file, Text!, False)
end event

type cb_import from commandbutton within w_export_priv_procedures
integer x = 1029
integer y = 72
integer width = 562
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "1) Get procedure data"
end type

event clicked;string pathandfile
string file

dw_import.reset()
 
dw_import.retrieve()
 
 
end event

type cb_close from commandbutton within w_export_priv_procedures
integer x = 2766
integer y = 68
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

event clicked;close(parent)
end event

type dw_import from datawindow within w_export_priv_procedures
integer x = 55
integer y = 204
integer width = 2999
integer height = 1724
integer taborder = 10
string title = "none"
string dataobject = "d_priv_procd_import"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

