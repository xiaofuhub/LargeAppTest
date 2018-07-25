$PBExportHeader$w_html_edit.srw
forward
global type w_html_edit from window
end type
type cb_8 from commandbutton within w_html_edit
end type
type mle_1 from multilineedit within w_html_edit
end type
type cb_c from commandbutton within w_html_edit
end type
type cb_i from commandbutton within w_html_edit
end type
type cb_1 from commandbutton within w_html_edit
end type
type cb_p from commandbutton within w_html_edit
end type
type cb_base from commandbutton within w_html_edit
end type
type cb_4 from commandbutton within w_html_edit
end type
type cb_b from commandbutton within w_html_edit
end type
type cb_6 from commandbutton within w_html_edit
end type
type ole_1 from olecustomcontrol within w_html_edit
end type
type dw_help from datawindow within w_html_edit
end type
end forward

global type w_html_edit from window
integer width = 2720
integer height = 2028
boolean titlebar = true
string title = "HTML Editing"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_8 cb_8
mle_1 mle_1
cb_c cb_c
cb_i cb_i
cb_1 cb_1
cb_p cb_p
cb_base cb_base
cb_4 cb_4
cb_b cb_b
cb_6 cb_6
ole_1 ole_1
dw_help dw_help
end type
global w_html_edit w_html_edit

forward prototypes
public function integer of_add_base ()
end prototypes

public function integer of_add_base ();string ls_text
string sn
string sr

sn = char(10)
sr = char(13)
//ls_text = "<HTML>~n~r"
//ls_text+= "<HEAD>~n~r"
//ls_text+= "<TITLE>~n~rThis is the title if you want to use one~n~r</TITLE>~n~r"
//ls_text+= "</HEAD>~n~r"
//ls_text+= "<BODY>~n~r"
//ls_text+= "This is the Body of the help.~n~r"
//ls_text+= "</BODY>~n~r"
//ls_text+= "</HTML>~n~r"
ls_text = "<HTML>" +sr + sn
//ls_text+= "<HEAD>"  +sr + sn
//ls_text+= "<TITLE>This is the title if you want to use one</TITLE>" +sr + sn
//ls_text+= "</HEAD>" +sr + sn
ls_text+= "<BODY>" +sr + sn
ls_text+= "<p>" +sr + sn
ls_text+= "This is the Body of the help."  +sr + sn
ls_text+= "</p>" +sr + sn
ls_text+= "</BODY>"  +sr + sn
ls_text+= "</HTML>"  +sr + sn

//mle_1.text = ls_text

dw_help.setitem(1,"help_description", ls_text)

return 1
end function

on w_html_edit.create
this.cb_8=create cb_8
this.mle_1=create mle_1
this.cb_c=create cb_c
this.cb_i=create cb_i
this.cb_1=create cb_1
this.cb_p=create cb_p
this.cb_base=create cb_base
this.cb_4=create cb_4
this.cb_b=create cb_b
this.cb_6=create cb_6
this.ole_1=create ole_1
this.dw_help=create dw_help
this.Control[]={this.cb_8,&
this.mle_1,&
this.cb_c,&
this.cb_i,&
this.cb_1,&
this.cb_p,&
this.cb_base,&
this.cb_4,&
this.cb_b,&
this.cb_6,&
this.ole_1,&
this.dw_help}
end on

on w_html_edit.destroy
destroy(this.cb_8)
destroy(this.mle_1)
destroy(this.cb_c)
destroy(this.cb_i)
destroy(this.cb_1)
destroy(this.cb_p)
destroy(this.cb_base)
destroy(this.cb_4)
destroy(this.cb_b)
destroy(this.cb_6)
destroy(this.ole_1)
destroy(this.dw_help)
end on

event open; //Start Code Change ----.2015 #V15 maha
string ls_text

ls_text = message.stringparm

dw_help.settransobject(sqlca)
dw_help.insertrow(1)

if len(ls_text) > 0 then
	dw_help.setitem(1,"help_description",ls_text)
else
	of_add_base( )
end if
end event

type cb_8 from commandbutton within w_html_edit
integer x = 302
integer y = 2076
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Read"
end type

event clicked;string s
string g
long c
long ll_asc

s = mle_1.text

for c = 1 to len(s)
	g = mid(s,c,1)
	ll_asc = asc(g)
	messagebox(g,ll_asc)
next
end event

type mle_1 from multilineedit within w_html_edit
integer x = 59
integer y = 192
integer width = 247
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_c from commandbutton within w_html_edit
integer x = 1056
integer y = 32
integer width = 178
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Color"
end type

event clicked;string s
string res

s = dw_help.selectedtext()

open(w_get_font_color)
res = message.stringparm

if res = "CANCEL" then return

s = '<font color="' + res + '">' + s + '</font>'

dw_help.replacetext(s)

//<font color="red">This will make your text red.</font>
end event

type cb_i from commandbutton within w_html_edit
integer x = 859
integer y = 32
integer width = 178
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Italic"
end type

event clicked;string s

s = dw_help.selectedtext()

s = "<i>" + s + "</i>"

dw_help.replacetext(s)
end event

type cb_1 from commandbutton within w_html_edit
integer x = 2341
integer y = 32
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "CANCEL"
end type

event clicked;closewithreturn(parent,"CANCEL")
end event

type cb_p from commandbutton within w_html_edit
integer x = 338
integer y = 32
integer width = 306
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Paragraph"
end type

event clicked;string s

s = "~r~n<p>~r~n~r~n</p>~r~n" 

dw_help.replacetext(s)
end event

type cb_base from commandbutton within w_html_edit
integer x = 46
integer y = 32
integer width = 279
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Base html"
end type

event clicked;dw_help.insertrow(1)
of_add_base()
end event

type cb_4 from commandbutton within w_html_edit
integer x = 1381
integer y = 32
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Preview"
end type

event clicked;string ls_path
string s
long ll_i
integer li_FileNum

dw_help.accepttext()
s = dw_help.getitemstring(1,"help_description")

ls_path = gs_dir_path + "intellicred/help_file.htm"

filedelete(ls_path)

li_FileNum = FileOpen( ls_path ,streamMode!, Write!, LockWrite!, Replace!)

FileWrite(li_FileNum, s)
	
FileClose ( li_FileNum )

ole_1.object.navigate(ls_path)
//next

return 0


end event

type cb_b from commandbutton within w_html_edit
integer x = 658
integer y = 32
integer width = 178
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Bold"
end type

event clicked;string s

s = dw_help.selectedtext()

s = "<b>" + s + "</b>"

dw_help.replacetext(s)
end event

type cb_6 from commandbutton within w_html_edit
integer x = 1984
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;string s

s = dw_help.getitemstring(1,"help_description")

closewithreturn(parent,s)
end event

type ole_1 from olecustomcontrol within w_html_edit
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean ab_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean ab_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean ab_resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean ab_cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean ab_cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean ab_cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
integer x = 1367
integer y = 188
integer width = 1326
integer height = 1720
integer taborder = 10
boolean focusrectangle = false
string binarykey = "w_html_edit.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type dw_help from datawindow within w_html_edit
integer x = 18
integer y = 192
integer width = 1335
integer height = 1720
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wv_help_detail"
boolean livescroll = true
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
07w_html_edit.bin 
2500000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000702697a001d16a8f00000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000702697a001d16a8f702697a001d16a8f000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00001df900002c710000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00001df900002c710000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17w_html_edit.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
