$PBExportHeader$w_npdb_testing.srw
forward
global type w_npdb_testing from window
end type
type cb_1 from commandbutton within w_npdb_testing
end type
end forward

global type w_npdb_testing from window
integer width = 1294
integer height = 1028
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_npdb_testing w_npdb_testing

type variables
n_cst_npdb l_npdb
end variables

event open;l_npdb = create n_cst_npdb












end event

event close;destroy(l_npdb)
end event

on w_npdb_testing.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_npdb_testing.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_npdb_testing
integer x = 416
integer y = 332
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;//debugbreak()
l_npdb.of_check_status_send_qrxs( )
end event

