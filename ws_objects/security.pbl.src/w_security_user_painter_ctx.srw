$PBExportHeader$w_security_user_painter_ctx.srw
forward
global type w_security_user_painter_ctx from w_response
end type
type uo_1 from pfc_cst_u_security_user_painter_ctx within w_security_user_painter_ctx
end type
end forward

global type w_security_user_painter_ctx from w_response
integer width = 3561
integer height = 1992
string title = "User Administration"
long backcolor = 33551856
uo_1 uo_1
end type
global w_security_user_painter_ctx w_security_user_painter_ctx

on w_security_user_painter_ctx.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_security_user_painter_ctx.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;uo_1.of_set_parent_window( This )
end event

event closequery;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-01-04 By: Scofield
//$<Reason> If there is no user,then don't save

long		ll_Row
String	ls_UserId

ll_Row = uo_1.dw_Select_User.GetRow()
ls_UserId = uo_1.dw_Select_User.GetItemString(ll_Row,'user_id')

if IsNull(ls_UserId) or Trim(ls_UserId) = '' then return 0

return Super::Event CloseQuery()
//---------------------------- APPEON END ----------------------------
end event

type uo_1 from pfc_cst_u_security_user_painter_ctx within w_security_user_painter_ctx
integer x = 37
integer y = 24
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_1.destroy
call pfc_cst_u_security_user_painter_ctx::destroy
end on

