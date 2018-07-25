$PBExportHeader$w_priv_procedure_lookup.srw
forward
global type w_priv_procedure_lookup from w_sheet
end type
type uo_proc_lookup from u_cst_priv_procedure_lookup within w_priv_procedure_lookup
end type
end forward

global type w_priv_procedure_lookup from w_sheet
integer width = 4539
integer height = 2212
string title = "Privilege Procedure Lookup"
long backcolor = 33551856
uo_proc_lookup uo_proc_lookup
end type
global w_priv_procedure_lookup w_priv_procedure_lookup

on w_priv_procedure_lookup.create
int iCurrent
call super::create
this.uo_proc_lookup=create uo_proc_lookup
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_proc_lookup
end on

on w_priv_procedure_lookup.destroy
call super::destroy
destroy(this.uo_proc_lookup)
end on

event open;call super::open;this.of_SetResize(true)
inv_resize.of_setorigsize(this.WorkspaceWidth(), this.WorkspaceHeight())
inv_resize.of_setminsize(this.WorkspaceWidth(), this.WorkspaceHeight())
inv_resize.of_Register(uo_proc_lookup, inv_resize.SCALE)

uo_proc_lookup.of_Init(this, 1)
end event

event activate;call super::activate;if w_mdi.menuname <> "m_pfe_cst_mdi_menu" then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
end if
end event

event closequery;Return uo_proc_lookup.Event ue_CloseQuery()
end event

type uo_proc_lookup from u_cst_priv_procedure_lookup within w_priv_procedure_lookup
integer taborder = 30
end type

on uo_proc_lookup.destroy
call u_cst_priv_procedure_lookup::destroy
end on

