$PBExportHeader$w_npdb_qrxs_file_util.srw
forward
global type w_npdb_qrxs_file_util from window
end type
type cb_1 from commandbutton within w_npdb_qrxs_file_util
end type
end forward

global type w_npdb_qrxs_file_util from window
integer width = 1038
integer height = 452
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_npdb_qrxs_file_util w_npdb_qrxs_file_util

on w_npdb_qrxs_file_util.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_npdb_qrxs_file_util.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_npdb_qrxs_file_util
integer x = 197
integer y = 120
integer width = 640
integer height = 104
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "QRXS Existing File Utility"
end type

event clicked;n_cst_npdb lo_npdb

lo_npdb = create n_cst_npdb


lo_npdb.of_initial_qrxs()
lo_npdb.of_get_qrxs_report_util_call()

Destroy lo_npdb

messagebox("","Completed")
end event

