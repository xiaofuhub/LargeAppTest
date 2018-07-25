$PBExportHeader$w_mail_message.srw
$PBExportComments$allows for user input for the mail message
forward
global type w_mail_message from w_response
end type
type st_1 from statictext within w_mail_message
end type
type p_1 from picture within w_mail_message
end type
type cb_1 from u_cb within w_mail_message
end type
type dw_1 from u_dw within w_mail_message
end type
type r_1 from rectangle within w_mail_message
end type
end forward

global type w_mail_message from w_response
integer x = 214
integer y = 221
integer width = 2706
integer height = 1232
st_1 st_1
p_1 p_1
cb_1 cb_1
dw_1 dw_1
r_1 r_1
end type
global w_mail_message w_mail_message

type variables
datastore lds_datastore


  str_pass  is_pass
end variables

on w_mail_message.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_1=create p_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.r_1
end on

on w_mail_message.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.r_1)
end on

event open;call super::open;/****************************************************************************************************************
** [PUBLIC] EVENT   OPEN
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

// CATCH THE PARAMETER
is_pass =  message.powerobjectparm
// SET THE DATAOBJECT IN IS_PASS TO DW_1

dw_1.dataobject = is_pass.s_dw.dataobject

dw_1.insertrow( 1)
dw_1.setrow( 1)
dw_1.setcolumn( 'subject')
end event

type st_1 from statictext within w_mail_message
integer x = 270
integer y = 44
integer width = 2213
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 134217752
string text = "Enter the Subject and text you would like to see in this email."
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_mail_message
integer x = 5
integer y = 8
integer width = 215
integer height = 156
string picturename = "letters.bmp"
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_mail_message
integer x = 2318
integer y = 1036
integer taborder = 20
string text = "OK"
boolean default = true
end type

event clicked;call super::clicked;/****************************************************************************************************************
** [PUBLIC] EVENT   cb_1::CLICKED
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

dw_1.RowsCopy(dw_1.GetRow(), dw_1.RowCount(), Primary!, is_pass.s_dw, 1, Primary!)

CloseWithReturn(Parent, is_pass)
end event

type dw_1 from u_dw within w_mail_message
integer y = 180
integer width = 2670
integer height = 844
integer taborder = 10
string dataobject = "d_ext_mail"
boolean ib_isupdateable = false
end type

type r_1 from rectangle within w_mail_message
long fillcolor = 134217752
integer y = 4
integer width = 2670
integer height = 164
end type

