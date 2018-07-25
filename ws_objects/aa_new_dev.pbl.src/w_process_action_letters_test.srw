$PBExportHeader$w_process_action_letters_test.srw
forward
global type w_process_action_letters_test from window
end type
type dw_1 from u_dw within w_process_action_letters_test
end type
type cb_1 from commandbutton within w_process_action_letters_test
end type
end forward

global type w_process_action_letters_test from window
integer width = 3493
integer height = 1328
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_1 cb_1
end type
global w_process_action_letters_test w_process_action_letters_test

on w_process_action_letters_test.create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_1}
end on

on w_process_action_letters_test.destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type dw_1 from u_dw within w_process_action_letters_test
integer x = 50
integer y = 36
integer width = 3177
integer height = 952
integer taborder = 20
string dataobject = "d_process_actions_ai"
end type

type cb_1 from commandbutton within w_process_action_letters_test
integer x = 1467
integer y = 1052
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "run"
end type

event clicked;gs_pass_ids lstr_ids
integer r
integer lid

for r = 1 to dw_1.rowcount()
	 lstr_ids.s_ids[r] = string(dw_1.getitemnumber(r,"rec_id"))
	  lstr_ids.l_ids[r] = dw_1.getitemnumber(r,"rec_id")
next

 lstr_ids.dw = dw_1
 
lstr_ids.ls_from_window = "Test"
lstr_ids.committee_id = 1

openwithparm(w_ai_print_letters, lstr_ids )
end event

