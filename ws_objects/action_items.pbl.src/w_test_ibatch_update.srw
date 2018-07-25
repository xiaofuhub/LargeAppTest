$PBExportHeader$w_test_ibatch_update.srw
forward
global type w_test_ibatch_update from window
end type
type cb_1 from commandbutton within w_test_ibatch_update
end type
end forward

global type w_test_ibatch_update from window
integer width = 1362
integer height = 820
boolean titlebar = true
string title = "Test iBatch Update"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_test_ibatch_update w_test_ibatch_update

on w_test_ibatch_update.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_test_ibatch_update.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_test_ibatch_update
integer x = 306
integer y = 228
integer width = 608
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Run"
end type

event clicked;pfc_n_cst_ai_printletters lnv_aiq

lnv_aiq = create pfc_n_cst_ai_printletters


lnv_aiq.of_intellibatch_update()

destroy lnv_aiq
end event

