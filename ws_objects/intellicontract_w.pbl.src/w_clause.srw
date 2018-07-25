$PBExportHeader$w_clause.srw
$PBExportComments$Displayed to allow the user to accept/append/decline the  new clause
forward
global type w_clause from w_response
end type
type cb_2 from commandbutton within w_clause
end type
type cb_1 from u_cb within w_clause
end type
type dw_1 from u_dw_contract within w_clause
end type
end forward

global type w_clause from w_response
integer width = 3429
integer height = 2028
string title = "Clause Modification"
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_clause w_clause

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2005-11-03 By: Zhang Lingping
//$<reason> The variable is not used in window, comment out it.
// window w_req_work
//---------------------------- APPEON END ----------------------------




 n_cst_filesrvwin32 inv_filesrv
string is_existing_clause
string is_new_clause
string is_final_clause
end variables

on w_clause.create
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

on w_clause.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;n_cst_string inv_string
blob lb_blob
string ls_clause

inv_filesrv = create n_cst_filesrvwin32

//w_req_work =message.powerobjectparm

is_existing_clause =  message.stringparm

dw_1.object.final_clause[1] =  message.stringparm

dw_1.object.existing_clause[1] = message.stringparm

inv_filesrv.of_fileread( "c:\ocr.text", lb_blob)

is_new_clause = string(lb_blob)

is_new_clause = inv_string.of_globalreplace( is_new_clause, 'ÿ', '')

dw_1.object.new_clause[1] = is_new_clause











end event

type cb_2 from commandbutton within w_clause
integer x = 3058
integer y = 1844
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;

CloseWithReturn ( parent, string(dw_1.object.final_clause[1] ))
end event

type cb_1 from u_cb within w_clause
integer x = 2693
integer y = 1848
integer taborder = 20
string text = "&OK"
end type

event clicked;call super::clicked;
CloseWithReturn ( parent, is_final_clause )
end event

type dw_1 from u_dw_contract within w_clause
string tag = "Clause View"
integer width = 3406
integer height = 1824
integer taborder = 10
boolean titlebar = true
string title = "Clause View"
string dataobject = "d_clause_viewer"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;

insertrow(0)
end event

event itemchanged;call super::itemchanged;
/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



choose case string(data )
	case '0' // append
		    this.object.final_clause[1] = is_existing_clause + is_new_clause
	case '1' // overwrite
		 this.object.final_clause[1]    = is_new_clause
	case '2' // cancel -- do nothing
		this.object.final_clause[1]     = is_existing_clause
end choose

is_final_clause = this.object.final_clause[1]

accepttext( )
end event

