$PBExportHeader$w_priv_procedure_select.srw
forward
global type w_priv_procedure_select from window
end type
type uo_proc_lookup from u_cst_priv_procedure_lookup within w_priv_procedure_select
end type
end forward

global type w_priv_procedure_select from window
integer width = 4512
integer height = 2164
boolean titlebar = true
string title = "Select Privilege Procedure"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
uo_proc_lookup uo_proc_lookup
end type
global w_priv_procedure_select w_priv_procedure_select

on w_priv_procedure_select.create
this.uo_proc_lookup=create uo_proc_lookup
this.Control[]={this.uo_proc_lookup}
end on

on w_priv_procedure_select.destroy
destroy(this.uo_proc_lookup)
end on

event open;uo_proc_lookup.of_Init(this, 2)
end event

event close;uo_proc_lookup.Event ue_Close()
end event

event closequery;Return uo_proc_lookup.Event ue_CloseQuery()
end event

type uo_proc_lookup from u_cst_priv_procedure_lookup within w_priv_procedure_select
integer taborder = 140
end type

on uo_proc_lookup.destroy
call u_cst_priv_procedure_lookup::destroy
end on

