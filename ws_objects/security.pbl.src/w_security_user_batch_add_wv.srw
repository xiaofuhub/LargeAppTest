$PBExportHeader$w_security_user_batch_add_wv.srw
forward
global type w_security_user_batch_add_wv from w_popup
end type
type uo_1 from pfc_cst_u_wv_user_add_batch within w_security_user_batch_add_wv
end type
end forward

global type w_security_user_batch_add_wv from w_popup
integer width = 3886
integer height = 2260
long backcolor = 33551856
uo_1 uo_1
end type
global w_security_user_batch_add_wv w_security_user_batch_add_wv

on w_security_user_batch_add_wv.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_security_user_batch_add_wv.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;//Start Code Change ----06.09.2016 #V152 maha - created
uo_1.iw_window = this
uo_1.of_set_prac("")
end event

event closequery;return 0
end event

type uo_1 from pfc_cst_u_wv_user_add_batch within w_security_user_batch_add_wv
integer taborder = 120
end type

on uo_1.destroy
call pfc_cst_u_wv_user_add_batch::destroy
end on

