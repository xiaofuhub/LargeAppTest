$PBExportHeader$w_req_data_errors.srw
forward
global type w_req_data_errors from w_popup
end type
type cb_1 from commandbutton within w_req_data_errors
end type
type dw_req from u_dw within w_req_data_errors
end type
end forward

global type w_req_data_errors from w_popup
integer x = 214
integer y = 221
integer width = 3067
integer height = 2212
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
cb_1 cb_1
dw_req dw_req
end type
global w_req_data_errors w_req_data_errors

type variables
long il_prac
long il_facil
end variables

on w_req_data_errors.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_req=create dw_req
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_req
end on

on w_req_data_errors.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_req)
end on

event open;call super::open;//Start Code Change ----03.25.2016 #V15 maha - created

//get prac/facility id from structure

//share errors ds if possible or save the data and retrieve.
end event

type cb_1 from commandbutton within w_req_data_errors
integer x = 2697
integer y = 28
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_req from u_dw within w_req_data_errors
integer x = 5
integer y = 140
integer width = 3049
integer height = 1984
integer taborder = 10
string dataobject = "d_req_data_errors_list"
end type

event doubleclicked;call super::doubleclicked;


//open prac folder to the specific screen/record
end event

