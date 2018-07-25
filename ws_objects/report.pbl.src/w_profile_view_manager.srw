$PBExportHeader$w_profile_view_manager.srw
forward
global type w_profile_view_manager from w_response
end type
type uo_profile_mgr from pfc_cst_u_profile_views_manager within w_profile_view_manager
end type
end forward

global type w_profile_view_manager from w_response
integer x = 704
integer y = 276
integer width = 2917
integer height = 2168
string title = "Profile Setup"
boolean controlmenu = false
long backcolor = 33551856
uo_profile_mgr uo_profile_mgr
end type
global w_profile_view_manager w_profile_view_manager

on w_profile_view_manager.create
int iCurrent
call super::create
this.uo_profile_mgr=create uo_profile_mgr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_profile_mgr
end on

on w_profile_view_manager.destroy
call super::destroy
destroy(this.uo_profile_mgr)
end on

event open;call super::open;uo_profile_mgr.of_set_parent_window( This )

uo_profile_mgr.cb_required.visible = false  //Start Code Change ----03.24.2008 #V8 maha - not used on this screen
end event

type uo_profile_mgr from pfc_cst_u_profile_views_manager within w_profile_view_manager
integer width = 2926
integer height = 2060
integer taborder = 10
boolean bringtotop = true
end type

on uo_profile_mgr.destroy
call pfc_cst_u_profile_views_manager::destroy
end on

