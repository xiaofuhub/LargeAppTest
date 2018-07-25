$PBExportHeader$w_word_testing.srw
forward
global type w_word_testing from window
end type
type cb_close from commandbutton within w_word_testing
end type
type mle_1 from multilineedit within w_word_testing
end type
type cb_run from commandbutton within w_word_testing
end type
end forward

global type w_word_testing from window
integer width = 1362
integer height = 1760
boolean titlebar = true
string title = "Word Instances"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
mle_1 mle_1
cb_run cb_run
end type
global w_word_testing w_word_testing

on w_word_testing.create
this.cb_close=create cb_close
this.mle_1=create mle_1
this.cb_run=create cb_run
this.Control[]={this.cb_close,&
this.mle_1,&
this.cb_run}
end on

on w_word_testing.destroy
destroy(this.cb_close)
destroy(this.mle_1)
destroy(this.cb_run)
end on

type cb_close from commandbutton within w_word_testing
integer x = 882
integer y = 1484
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type mle_1 from multilineedit within w_word_testing
integer x = 55
integer y = 36
integer width = 1175
integer height = 1412
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_run from commandbutton within w_word_testing
integer x = 480
integer y = 1484
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;/////////////////////////////////////////////////////////////////////////////
// $<function>of_clearout_word
// $<arguments> 
// $<returns> integer
// $<description>Clear out Microsoft Word documents opened by Intellisoft system
// $<description>while only 1 intellcred applcation running in the client
/////////////////////////////////////////////////////////////////////////////
// $<add> 01.16.2008 Alfee
/////////////////////////////////////////////////////////////////////////////
CONSTANT Integer WM_CLOSE = 16
CONSTANT String CLSNAME_WORD = 'OpusApp'
CONSTANT String CLSNAME_IEFRAME = 'IEFrame'
CONSTANT String CLSNAME_Intelli = 'FNWND390'

Long ll_handle, ll_rtn, ll_null, ll_counter
String ls_title, ls_null
Boolean lb_visible
integer i
integer d


//Initilize variables
Setnull(ll_null)
SetNull(ls_null)
ll_counter = 0
ls_title = Space(255)

////Get the handle of first IntelliCred application window
//ll_handle = FindWindowExA(ll_null, ll_null, CLSNAME_Intelli, ls_null)
//DO WHILE ll_handle > 0 
//	//Get Window's title
//	ll_rtn = GetWindowTextA(ll_handle, ls_title, 255)
//	//Count it with comparing the title
//	IF ll_rtn > 0 and ls_title = gs_mdi_title THEN ll_counter ++
//	//Skip closing if more than 1 IntelliCred application window found
//	IF ll_counter > 1 THEN RETURN 0
//	//Get the next
//	ll_handle = FindWindowExA(ll_null, ll_handle, CLSNAME_Intelli, ls_null)
//LOOP
//
////Get the handle of first IntelliCred Web application window
//ll_handle = FindWindowExA(ll_null, ll_null, CLSNAME_IEFRAME, ls_null)
//DO WHILE ll_handle > 0 
//	//Get Window's title
//	ll_rtn = GetWindowTextA(ll_handle, ls_title, 255)
//	//Count it with comparing the title
//	IF ll_rtn > 0 and ls_title = gs_mdi_title + ' - Microsoft Internet Explorer' THEN ll_counter ++
//	//Skip closing if more than 1 IntelliCred application window found
//	IF ll_counter > 1 THEN RETURN 0
//	//Get the next
//	ll_handle = FindWindowExA(ll_null, ll_handle, CLSNAME_IEFRAME, ls_null)
//LOOP

//Get the handle of first Word instance window
ll_handle = FindWindowExA(ll_null, ll_null, CLSNAME_WORD, ls_null)
DO WHILE ll_handle > 0 
	//Get Window's title
	ll_rtn = GetWindowTextA(ll_handle, ls_title, 255)
	//Close the invisible Word instance window
	IF ll_rtn > 0 and PosA(ls_title, '- Microsoft Word') > 0 THEN 
		mle_1.text = mle_1.text + "~r" + ls_title
		IF NOT IsWindowVisible(ll_handle) THEN	Post Send( ll_handle, WM_CLOSE, 1, 0)
	END IF
	//Get the next
	ll_handle = FindWindowExA(ll_null, ll_handle, CLSNAME_WORD, ls_null)
	i++
	if i > 1000 then exit
LOOP

RETURN 1
end event

