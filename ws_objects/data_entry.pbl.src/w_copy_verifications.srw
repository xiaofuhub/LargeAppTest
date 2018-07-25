$PBExportHeader$w_copy_verifications.srw
forward
global type w_copy_verifications from w_response
end type
type dw_browse from u_dw within w_copy_verifications
end type
type cb_1 from u_cb within w_copy_verifications
end type
type cb_2 from u_cb within w_copy_verifications
end type
end forward

global type w_copy_verifications from w_response
integer x = 123
integer y = 212
integer width = 3438
integer height = 2108
string title = "Copy Verifications"
long backcolor = 12639424
dw_browse dw_browse
cb_1 cb_1
cb_2 cb_2
end type
global w_copy_verifications w_copy_verifications

on w_copy_verifications.create
int iCurrent
call super::create
this.dw_browse=create dw_browse
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_browse
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_copy_verifications.destroy
call super::destroy
destroy(this.dw_browse)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type dw_browse from u_dw within w_copy_verifications
integer x = 59
integer y = 48
integer width = 3291
integer height = 1772
integer taborder = 10
string dataobject = "d_copy_verification"
end type

event constructor;DatawindowChild dwchild

This.of_SetUpdateAble( False )
This.of_SetTransObject(SQLCA)


This.GetChild( "response_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("credentials verification response")


This.GetChild( "verification_method", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("verification method")

Integer li_rc
Integer i

li_rc = This.Retrieve( Message.DoubleParm )

FOR i = 1 TO li_rc
	IF This.GetItemString( i, "verify_data" ) = "B" THEN
		This.SetItem( i, "selected", 1 )
	ELSE
		This.SetItem( i, "selected", 0 )
	END IF
END FOR




end event

type cb_1 from u_cb within w_copy_verifications
integer x = 3003
integer y = 1844
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;Close( Parent )
end event

type cb_2 from u_cb within w_copy_verifications
integer x = 2619
integer y = 1844
integer height = 84
integer taborder = 11
boolean bringtotop = true
string text = "&Print"
end type

event clicked;dw_browse.Print()
end event

