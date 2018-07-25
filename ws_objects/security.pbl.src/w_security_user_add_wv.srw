$PBExportHeader$w_security_user_add_wv.srw
forward
global type w_security_user_add_wv from w_response
end type
type uo_1 from pfc_cst_u_wv_user_add within w_security_user_add_wv
end type
end forward

global type w_security_user_add_wv from w_response
integer width = 2830
integer height = 2236
string title = "User Setup"
long backcolor = 33551856
uo_1 uo_1
end type
global w_security_user_add_wv w_security_user_add_wv

on w_security_user_add_wv.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_security_user_add_wv.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;string ls_mess

ls_mess = message.stringparm

uo_1.iw_window = this
uo_1.of_set_prac( ls_mess)
//uo_1.of_set_prac( "214@2")


end event

event closequery;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-01-04 By: Scofield
//$<Reason> If there is no user,then don't save

long		ll_Row
String	ls_UserId

ll_Row = uo_1.dw_Select_User.GetRow()
ls_UserId = uo_1.dw_Select_User.GetItemString(ll_Row,'user_id')

if IsNull(ls_UserId) or Trim(ls_UserId) = '' then return 0

if uo_1.cb_continue.text = "Continue" then return 0 //Added by Appeon long.zhang 10.16.2014

return Super::Event CloseQuery()
//---------------------------- APPEON END ----------------------------
end event

type uo_1 from pfc_cst_u_wv_user_add within w_security_user_add_wv
integer width = 2816
integer height = 2148
integer taborder = 10
end type

on uo_1.destroy
call pfc_cst_u_wv_user_add::destroy
end on

