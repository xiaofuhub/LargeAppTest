$PBExportHeader$w_npdb_direction_chooser.srw
$PBExportComments$Used to choose the direction RECIEVE
forward
global type w_npdb_direction_chooser from w_response
end type
type st_1 from u_st within w_npdb_direction_chooser
end type
type cb_1 from commandbutton within w_npdb_direction_chooser
end type
type st_recieve from u_st within w_npdb_direction_chooser
end type
type st_send from u_st within w_npdb_direction_chooser
end type
type cb_cancel from u_cb within w_npdb_direction_chooser
end type
type cb_recieve from u_cb within w_npdb_direction_chooser
end type
type cb_send from u_cb within w_npdb_direction_chooser
end type
end forward

global type w_npdb_direction_chooser from w_response
integer width = 1998
integer height = 624
string title = "NPDB Action"
long backcolor = 33551856
st_1 st_1
cb_1 cb_1
st_recieve st_recieve
st_send st_send
cb_cancel cb_cancel
cb_recieve cb_recieve
cb_send cb_send
end type
global w_npdb_direction_chooser w_npdb_direction_chooser

type variables


LONG il_return_parm

constant long 	RECIEVE = 1
constant long 	SEND    = 2
constant long 	QUIT    = 3
end variables

on w_npdb_direction_chooser.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.st_recieve=create st_recieve
this.st_send=create st_send
this.cb_cancel=create cb_cancel
this.cb_recieve=create cb_recieve
this.cb_send=create cb_send
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_recieve
this.Control[iCurrent+4]=this.st_send
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_recieve
this.Control[iCurrent+7]=this.cb_send
end on

on w_npdb_direction_chooser.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_recieve)
destroy(this.st_send)
destroy(this.cb_cancel)
destroy(this.cb_recieve)
destroy(this.cb_send)
end on

event pfc_preopen;call super::pfc_preopen;
//long il_sending
//long il_recieving
//
//DATASTORE LDS
//LDS=CREATE DATASTORE
//LDS.DATAOBJECT = 'd_npdb_doc_ids_2'
//LDS.SETTRANSObject( SQLCA)
//LDS.RETRIEVE()
//
//LDS.SETFILTER(' verif_info_print_flag = 1')
//LDS.FILTER()
//il_sending = LDS.ROWCOUNT()
//
//
//
//LDS.SETFILTER(' verif_info_print_flag = 0')
//LDS.FILTER()
//il_recieving = LDS.ROWCOUNT()
//


//st_recieve.text = 'There are '+string(il_recieving)+ ' practitioners awaiting to be retrieved from the PDBB databank.'

//st_send.text    = 'There are '+string(il_sending)+ ' practitioners to be sent to the PDBB databank for verification.'
		
end event

type st_1 from u_st within w_npdb_direction_chooser
integer x = 425
integer y = 320
integer width = 1536
integer height = 84
long backcolor = 33551856
boolean enabled = true
string text = "Review Existing Reports"
end type

type cb_1 from commandbutton within w_npdb_direction_chooser
integer x = 37
integer y = 320
integer width = 352
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "All Reports"
end type

event clicked;open(w_npdb_reports)
close(parent)
end event

type st_recieve from u_st within w_npdb_direction_chooser
integer x = 439
integer y = 192
integer width = 1536
integer height = 128
long backcolor = 33551856
boolean enabled = true
string text = "Check to see if any NPDB reports are ready."
end type

type st_send from u_st within w_npdb_direction_chooser
integer x = 439
integer y = 32
integer width = 1536
integer height = 128
long backcolor = 33551856
string text = "Send the currently selected Practitioners to the NPDB for verification."
end type

type cb_cancel from u_cb within w_npdb_direction_chooser
integer x = 1614
integer y = 432
integer taborder = 30
string text = "&Cancel"
boolean default = true
end type

event clicked;call super::clicked;



closewithreturn(parent,quit)
end event

type cb_recieve from u_cb within w_npdb_direction_chooser
integer x = 37
integer y = 192
integer taborder = 20
string text = "&Receive"
end type

event clicked;call super::clicked;

closewithreturn(parent,recieve)
end event

type cb_send from u_cb within w_npdb_direction_chooser
integer x = 37
integer y = 32
integer taborder = 10
string text = "&Send"
end type

event clicked;call super::clicked;


closewithreturn(parent,send)
end event

