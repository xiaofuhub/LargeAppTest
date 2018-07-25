$PBExportHeader$w_exp_cred_missing_utl.srw
forward
global type w_exp_cred_missing_utl from window
end type
type cb_close from commandbutton within w_exp_cred_missing_utl
end type
type st_1 from statictext within w_exp_cred_missing_utl
end type
type cb_run from commandbutton within w_exp_cred_missing_utl
end type
end forward

global type w_exp_cred_missing_utl from window
integer width = 2885
integer height = 552
boolean titlebar = true
string title = "Check for missing Expiring Verifications"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
st_1 st_1
cb_run cb_run
end type
global w_exp_cred_missing_utl w_exp_cred_missing_utl

on w_exp_cred_missing_utl.create
this.cb_close=create cb_close
this.st_1=create st_1
this.cb_run=create cb_run
this.Control[]={this.cb_close,&
this.st_1,&
this.cb_run}
end on

on w_exp_cred_missing_utl.destroy
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.cb_run)
end on

type cb_close from commandbutton within w_exp_cred_missing_utl
integer x = 1385
integer y = 260
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

type st_1 from statictext within w_exp_cred_missing_utl
integer x = 151
integer y = 100
integer width = 2473
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "This utility will check data records for Expiring Verifications per the Facility Verification rules."
boolean focusrectangle = false
end type

type cb_run from commandbutton within w_exp_cred_missing_utl
integer x = 946
integer y = 260
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;pfc_n_cst_ai_printletters lnv_run

lnv_run = create pfc_n_cst_ai_printletters

open(w_aiq_run)

lnv_run.ib_from_utility = true

lnv_run.of_expiring_credentials_from_data( )

Close(w_aiq_run)

destroy lnv_run
end event

