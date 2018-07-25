$PBExportHeader$w_contract_delete_thums.srw
forward
global type w_contract_delete_thums from w_response
end type
type dw_1 from u_dw within w_contract_delete_thums
end type
end forward

global type w_contract_delete_thums from w_response
integer width = 1637
integer height = 316
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
dw_1 dw_1
end type
global w_contract_delete_thums w_contract_delete_thums

type variables
uo_req_image io_req_image
end variables

on w_contract_delete_thums.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_contract_delete_thums.destroy
call super::destroy
destroy(this.dw_1)
end on

event pfc_postopen;call super::pfc_postopen;


io_req_image = message.powerobjectparm
end event

type dw_1 from u_dw within w_contract_delete_thums
integer height = 280
integer taborder = 10
boolean titlebar = true
string title = "Delete Thumbs"
string dataobject = "d_ext_page"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;


accepttext( )
try 
	
io_req_image.of_delete( object.first_page[1],object.last_page[1] )
catch (runtimeerror rte)
end try
end event

event constructor;call super::constructor;insertrow(0)
end event

