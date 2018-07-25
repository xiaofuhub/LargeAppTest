$PBExportHeader$w_security_user_painter.srw
forward
global type w_security_user_painter from w_response
end type
type uo_1 from pfc_cst_u_security_user_painter within w_security_user_painter
end type
end forward

global type w_security_user_painter from w_response
integer width = 4178
integer height = 2688
string title = "User Administration"
long backcolor = 33551856
uo_1 uo_1
end type
global w_security_user_painter w_security_user_painter

on w_security_user_painter.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_security_user_painter.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;string ls_license_key

uo_1.of_set_parent_window( This )

//Start Code Change ----06.16.2009 #V92 maha
if gi_user_readonly = 1 or (w_mdi.of_security_access( 900 ) = 1) then //Add 900, modified by Appeon long.zhang 01.20.2016 (V15.1 Applause Cycle 3 Bug #4926 - User with RO access to User Admin can modify existing user settings and add a new user)
	uo_1.of_set_security( )
end if
//End Code Change---06.16.2009

//Start Code Change ----08.05.2010 #V10 maha
Select license_info into :ls_license_key from icred_settings;
uo_1.ii_readonly =  Integer(MidA(ls_license_key,15,3))
//End Code Change ----08.05.2010


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

type uo_1 from pfc_cst_u_security_user_painter within w_security_user_painter
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_1.destroy
call pfc_cst_u_security_user_painter::destroy
end on

