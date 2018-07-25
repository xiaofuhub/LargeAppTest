$PBExportHeader$w_exp_cred_create_util.srw
forward
global type w_exp_cred_create_util from window
end type
type cb_run from commandbutton within w_exp_cred_create_util
end type
type dw_data from datawindow within w_exp_cred_create_util
end type
end forward

global type w_exp_cred_create_util from window
integer width = 2354
integer height = 1912
boolean titlebar = true
string title = "Find Expiring credentisls"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_run cb_run
dw_data dw_data
end type
global w_exp_cred_create_util w_exp_cred_create_util

on w_exp_cred_create_util.create
this.cb_run=create cb_run
this.dw_data=create dw_data
this.Control[]={this.cb_run,&
this.dw_data}
end on

on w_exp_cred_create_util.destroy
destroy(this.cb_run)
destroy(this.dw_data)
end on

type cb_run from commandbutton within w_exp_cred_create_util
integer x = 1317
integer y = 8
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;pfc_n_cst_ai_printletters lnv_function

lnv_function = create pfc_n_cst_ai_printletters

lnv_function.of_expiring_credentials_from_data_new("Utility")
//w_exp_cred_create_util

destroy lnv_function
end event

type dw_data from datawindow within w_exp_cred_create_util
integer x = 23
integer y = 112
integer width = 2281
integer height = 1656
integer taborder = 10
string title = "none"
string dataobject = "d_verif_exp_4_record"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

