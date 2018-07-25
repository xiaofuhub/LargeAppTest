$PBExportHeader$w_cpt_find.srw
$PBExportComments$[intellicontract_w]
forward
global type w_cpt_find from w_response
end type
type cb_2 from u_cb within w_cpt_find
end type
type cb_1 from u_cb within w_cpt_find
end type
type dw_1 from u_dw_contract within w_cpt_find
end type
end forward

global type w_cpt_find from w_response
integer width = 2455
integer height = 1084
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_cpt_find w_cpt_find

type variables

u_dw ids_cpt_code
str_pass lstr_pass

end variables

on w_cpt_find.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_cpt_find.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;lstr_pass = message.powerobjectparm

ids_cpt_code =  lstr_pass.s_u_dw 

end event

type cb_2 from u_cb within w_cpt_find
string tag = "Find the requested codes"
integer x = 1710
integer y = 16
integer taborder = 30
string text = "&Retrieve"
end type

event clicked;call super::clicked;string ls_return

dw_1.accepttext( )

lstr_pass.s_u_dw.setcolumn('cpt_code')
lstr_pass.s_u_dw.setrow(1)
lstr_pass.s_u_dw.settext(dw_1.object.cpt_code[1])
//lstr_pass.s_u_dw.object.cpt_code[1] = dw_1.object.cpt_code[1]  

lstr_pass.s_u_dw.setcolumn('cpt_code_description')
lstr_pass.s_u_dw.setrow(1)
lstr_pass.s_u_dw.settext(dw_1.object.cpt_code_description[1] )

//lstr_pass.s_u_dw.object.cpt_code_description[1] = dw_1.object.cpt_code_description[1] 

lstr_pass.s_u_dw.accepttext( )

choose case dw_1.object.starting[1] 
	case 1
		ls_return ='EXACT'
	case 2		
		ls_return ='SIM'
	case 3
		ls_return ='ALL'
end choose 

closewithreturn(parent,ls_return)

end event

type cb_1 from u_cb within w_cpt_find
integer x = 2075
integer y = 16
integer taborder = 20
string text = "&Cancel"
end type

event clicked;call super::clicked;


CloseWithReturn(Parent, 'CANCEL')
end event

type dw_1 from u_dw_contract within w_cpt_find
string tag = "Find an exact match (very restrictive search): ~n  - Finds the exact match of the CPT Code or description entered ~n ~r Find similarly named codes and or descriptions (Less restrictive): ~n  - Finds matches that START with the entered value. ~t              ~n ~r Find all codes, let me filter afterward (No restrictions of the search). ~n   - Retrieves ALL of the CPT Codes., the user can then filter down the list as he/she sees fit"
integer y = 136
integer width = 2427
integer height = 904
integer taborder = 10
string dataobject = "d_ext_cpt_find"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;insertrow( 0)
end event

