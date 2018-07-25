$PBExportHeader$w_npdb_reject_codes.srw
forward
global type w_npdb_reject_codes from window
end type
type dw_1 from datawindow within w_npdb_reject_codes
end type
type cb_1 from commandbutton within w_npdb_reject_codes
end type
end forward

global type w_npdb_reject_codes from window
integer width = 3150
integer height = 1536
boolean titlebar = true
string title = "NPDB File Rejection Codes"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_1 cb_1
end type
global w_npdb_reject_codes w_npdb_reject_codes

type variables
//------------ APPEON BEGIN ------------
//$<Add> 12.23.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
long il_Interface
constant long ITP_INTERFACE  = 1
constant long QRXS_INTERFACE = 2
//------------ APPEON END --------------
end variables

on w_npdb_reject_codes.create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_1}
end on

on w_npdb_reject_codes.destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;string s
string r[]
integer f
string ls_f

s = message.stringparm

//------------------- APPEON BEGIN -------------------
//$<Add> 12.23.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
il_Interface = of_get_app_setting("set_8", "I")
choose case il_Interface
	case ITP_INTERFACE
		if LenA(s) = 3 then
			r[1] = "error_cd"  //send error
		else
			r[1] = "list_q"	 //file error
		end if
	case QRXS_INTERFACE
		r[1] = "error_cd_qrxs"
		r[2] = "list_q"
end choose
//------------------- APPEON END ---------------------

//of_strip_char("*", s,",")

dw_1.settransobject(sqlca)
dw_1.retrieve(r)

ls_f = "npdb_list_code = '" + s + "'"
//messagebox("",ls_f)
 f = dw_1.find(ls_f ,1,dw_1.rowcount())
 
 if f > 0 then
	dw_1.scrolltorow(f)
	dw_1.selectrow(0,false)
	dw_1.selectrow(f,true)
end if


end event

type dw_1 from datawindow within w_npdb_reject_codes
integer x = 37
integer y = 128
integer width = 3022
integer height = 1168
integer taborder = 10
string title = "none"
string dataobject = "d_npdb_error_codes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_npdb_reject_codes
integer x = 2725
integer y = 16
integer width = 329
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

