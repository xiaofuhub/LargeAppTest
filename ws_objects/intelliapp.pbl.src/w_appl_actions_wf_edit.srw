$PBExportHeader$w_appl_actions_wf_edit.srw
forward
global type w_appl_actions_wf_edit from w_response
end type
type cb_close from commandbutton within w_appl_actions_wf_edit
end type
type cb_save from commandbutton within w_appl_actions_wf_edit
end type
type dw_action from u_dw within w_appl_actions_wf_edit
end type
end forward

global type w_appl_actions_wf_edit from w_response
integer width = 3529
integer height = 1184
string title = "Edit Workflow Actions"
boolean controlmenu = false
long backcolor = 33551856
cb_close cb_close
cb_save cb_save
dw_action dw_action
end type
global w_appl_actions_wf_edit w_appl_actions_wf_edit

type variables
long il_prac
long il_facility
long il_app
long il_gpid
long il_track
pfc_cst_nv_data_entry_functions inv_data_entry
end variables

event open;call super::open;//Start Code Change ----12.01.2017 #V16 maha
integer li_row
integer res
long ll_wf
gs_pass_ids lst_ids

lst_ids = message.powerobjectparm

il_facility = lst_ids.facility_id
il_prac = lst_ids.prac_id
il_app = lst_ids.l_app_id
il_gpid = lst_ids.l_ids[1]
ll_wf = lst_ids.l_ids[2]
il_track = lst_ids.l_ids[3]

dw_action.settransobject(sqlca)
dw_action.retrieve(il_prac, ll_wf)

end event

on w_appl_actions_wf_edit.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_action=create dw_action
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.dw_action
end on

on w_appl_actions_wf_edit.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_action)
end on

type cb_close from commandbutton within w_appl_actions_wf_edit
integer x = 1669
integer y = 8
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, 0)
end event

type cb_save from commandbutton within w_appl_actions_wf_edit
integer x = 1253
integer y = 8
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;//of_app_tracking_update_new(ll_prac_id, ll_facility, ll_app_id, 0, datetime(today(),now()), ll_loc, ll_track)

inv_data_entry = create pfc_cst_nv_data_entry_functions 
inv_data_entry.of_field_audit( dw_action )

dw_action.update()

destroy inv_data_entry


closewithreturn(parent, 1)
end event

type dw_action from u_dw within w_appl_actions_wf_edit
integer x = 23
integer y = 108
integer width = 3483
integer height = 968
integer taborder = 10
string dataobject = "d_net_dev_action_items_wf_edit"
boolean hscrollbar = true
end type

