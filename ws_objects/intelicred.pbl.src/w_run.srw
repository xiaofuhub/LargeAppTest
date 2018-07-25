$PBExportHeader$w_run.srw
forward
global type w_run from window
end type
type sle_1 from singlelineedit within w_run
end type
type cb_1 from commandbutton within w_run
end type
end forward

global type w_run from window
integer width = 2075
integer height = 528
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
sle_1 sle_1
cb_1 cb_1
end type
global w_run w_run

type variables
n_cst_encrypt invo_encrypt  
end variables

on w_run.create
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.sle_1,&
this.cb_1}
end on

on w_run.destroy
destroy(this.sle_1)
destroy(this.cb_1)
end on

type sle_1 from singlelineedit within w_run
integer x = 59
integer y = 84
integer width = 1915
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_run
integer x = 1582
integer y = 244
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Encrypt"
end type

event clicked;


choose case  this.text
	case 'Encrypt' 
		this.text = 'Decrypt'
		   sle_1.text = invo_encrypt.of_encrypt(sle_1.text )
		
	case 'Decrypt'
		this.text = 'Encrypt'
		
		sle_1.text  = invo_encrypt.of_decrypt( sle_1.text)
end choose
end event

