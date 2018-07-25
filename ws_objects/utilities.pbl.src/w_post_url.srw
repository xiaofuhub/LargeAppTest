$PBExportHeader$w_post_url.srw
forward
global type w_post_url from window
end type
type cb_2 from commandbutton within w_post_url
end type
type cb_1 from commandbutton within w_post_url
end type
end forward

global type w_post_url from window
integer x = 1056
integer y = 484
integer width = 2249
integer height = 1708
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_2 cb_2
cb_1 cb_1
end type
global w_post_url w_post_url

type variables
InternetResult iir_msgbox
Inet  iinet_base
end variables

on w_post_url.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.cb_1}
end on

on w_post_url.destroy
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within w_post_url
integer x = 315
integer y = 568
integer width = 1161
integer height = 304
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

type cb_1 from commandbutton within w_post_url
integer x = 142
integer y = 236
integer width = 1847
integer height = 304
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;//lblb_args = blob("select_search=Name&select_criteria=smith&select_county=ALL&select_profession=ALL")

iir_msgbox = CREATE n_ir_msgbox
Integer retval

GetContextService("Internet", iinet_base)

iir_msgbox = CREATE n_ir_msgbox

Blob    lblb_args
String  ls_headers
String  ls_url
Long    ll_length

ls_url = "http://pr.mo.gov/licensee-search-results.asp?passview=1"
lblb_args = blob("select_search=Number&select_county=ALL&select_profession=ALL&select_criteria=2000152597",EncodingAnsi!) //Encoding – Nova 11.16.2010
ll_length = LenA(lblb_args)
ls_headers = "Content-Length: " + String(ll_length) + "~n~n"


retval = iinet_base.PostURL(ls_url, lblb_args, ls_headers, iir_msgbox)


If Retval = 1 then This.text = "success" 
If Retval = -1 then This.text = "General Error"
If Retval = -2 then This.text = "Invalid URL"
If Retval = -4 then This.text = "Cannot connect to the Internet"
If Retval = -6 then This.text = "Internet request failed"
end event

