$PBExportHeader$w_web_browse_ocx.srw
$PBExportComments$MS Web Browser OCX as a simple Web Browser
forward
global type w_web_browse_ocx from window
end type
type cb_4 from commandbutton within w_web_browse_ocx
end type
type cb_3 from commandbutton within w_web_browse_ocx
end type
type cb_2 from commandbutton within w_web_browse_ocx
end type
type cb_1 from commandbutton within w_web_browse_ocx
end type
type ole_1 from olecustomcontrol within w_web_browse_ocx
end type
type cb_saveas from commandbutton within w_web_browse_ocx
end type
type cb_print_setup from commandbutton within w_web_browse_ocx
end type
type cb_url2 from commandbutton within w_web_browse_ocx
end type
type cb_url1 from commandbutton within w_web_browse_ocx
end type
type cb_stop from commandbutton within w_web_browse_ocx
end type
type cb_search from commandbutton within w_web_browse_ocx
end type
type sle_title from singlelineedit within w_web_browse_ocx
end type
type cb_home from commandbutton within w_web_browse_ocx
end type
type cb_forward from commandbutton within w_web_browse_ocx
end type
type lb_1 from listbox within w_web_browse_ocx
end type
type cb_print from commandbutton within w_web_browse_ocx
end type
type sle_1 from singlelineedit within w_web_browse_ocx
end type
type cb_back from commandbutton within w_web_browse_ocx
end type
type cb_load_url from commandbutton within w_web_browse_ocx
end type
end forward

global type w_web_browse_ocx from window
integer x = 96
integer y = 112
integer width = 3758
integer height = 2648
boolean titlebar = true
string title = "Simple Web Browser"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
ole_1 ole_1
cb_saveas cb_saveas
cb_print_setup cb_print_setup
cb_url2 cb_url2
cb_url1 cb_url1
cb_stop cb_stop
cb_search cb_search
sle_title sle_title
cb_home cb_home
cb_forward cb_forward
lb_1 lb_1
cb_print cb_print
sle_1 sle_1
cb_back cb_back
cb_load_url cb_load_url
end type
global w_web_browse_ocx w_web_browse_ocx

type variables
int iOldWinWidth = 0
int iOldWinHeight = 0


end variables

on w_web_browse_ocx.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ole_1=create ole_1
this.cb_saveas=create cb_saveas
this.cb_print_setup=create cb_print_setup
this.cb_url2=create cb_url2
this.cb_url1=create cb_url1
this.cb_stop=create cb_stop
this.cb_search=create cb_search
this.sle_title=create sle_title
this.cb_home=create cb_home
this.cb_forward=create cb_forward
this.lb_1=create lb_1
this.cb_print=create cb_print
this.sle_1=create sle_1
this.cb_back=create cb_back
this.cb_load_url=create cb_load_url
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.ole_1,&
this.cb_saveas,&
this.cb_print_setup,&
this.cb_url2,&
this.cb_url1,&
this.cb_stop,&
this.cb_search,&
this.sle_title,&
this.cb_home,&
this.cb_forward,&
this.lb_1,&
this.cb_print,&
this.sle_1,&
this.cb_back,&
this.cb_load_url}
end on

on w_web_browse_ocx.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ole_1)
destroy(this.cb_saveas)
destroy(this.cb_print_setup)
destroy(this.cb_url2)
destroy(this.cb_url1)
destroy(this.cb_stop)
destroy(this.cb_search)
destroy(this.sle_title)
destroy(this.cb_home)
destroy(this.cb_forward)
destroy(this.lb_1)
destroy(this.cb_print)
destroy(this.sle_1)
destroy(this.cb_back)
destroy(this.cb_load_url)
end on

event resize;// resize the OLE object too
if sizetype <> 0 then
	return 0
end if

int ObjWidth,   ObjHeight
int marginLeft, marginRight
int marginTop,  marginBottom

// The space (margins) around the web-browser control
// This technique depends on there being NO BORDER around the OLE control
marginLeft   = ole_1.x
marginRight  = iOldWinWidth - ole_1.width - marginLeft
marginTop    = ole_1.y
marginBottom = iOldWinHeight - ole_1.height - marginTop

ObjWidth  = newWidth  - (marginRight + marginLeft)
ObjHeight = newHeight - (marginTop   + marginBottom)

// Tell the control - but first convert to PIXELS
ole_1.width  = objWidth
ole_1.object.Width  = UnitsToPixels( objWidth, XUnitsToPixels!)

ole_1.height  = objheight
ole_1.object.height  = UnitsToPixels( objheight, YUnitsToPixels!)

// store the new height/width in the window's instance variables
iOldWinWidth  = newWidth
iOldWinHeight = newHeight

// continue processing
return 0

end event

event open;iOldWinWidth  = this.width
iOldWinHeight = this.height



end event

type cb_4 from commandbutton within w_web_browse_ocx
integer x = 3040
integer y = 32
integer width = 622
integer height = 80
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)

end event

type cb_3 from commandbutton within w_web_browse_ocx
integer x = 1632
integer y = 332
integer width = 622
integer height = 80
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OLE"
end type

event clicked;integer p
String ls_url
inet iinet_base

ls_url = sle_1.text

if LenA(ls_url) < 6 then 
	messagebox("Error","Invalid URL")
	return
end if


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.23.2006 By: Liang QingShi
//$<reason>  GetContextService is currently unsupported. 
//$<modification> Replace GetContextService with ShellExecuteA to provide the
//$<modification> same functionality.
/*
GetContextService("Internet", iinet_base)
iinet_base.HyperlinkToURL(ls_url)
*/
String ls_null
setnull(ls_null)
//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser

//---------------------------- APPEON END ----------------------------

end event

type cb_2 from commandbutton within w_web_browse_ocx
integer x = 1632
integer y = 236
integer width = 622
integer height = 80
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "PATH"
end type

event clicked;String ls_browser_path
string lsurl
lsurl = sle_1.text

ls_browser_path = ProfileString(gs_dir_path + "intellicred\intellicred.ini", "Paths","browser", "None")


	Run( ls_browser_path + " " + lsurl)



end event

type cb_1 from commandbutton within w_web_browse_ocx
integer x = 1632
integer y = 140
integer width = 622
integer height = 80
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SHELL"
end type

event clicked;string ls_null
string lsurl

setnull(ls_null)

lsurl = sle_1.text

//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', lsurl , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), lsurl, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser

end event

type ole_1 from olecustomcontrol within w_web_browse_ocx
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
integer x = 37
integer y = 640
integer width = 3634
integer height = 1600
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_web_browse_ocx.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_saveas from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 37
integer y = 428
integer width = 622
integer height = 80
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save As"
end type

event clicked;// Jump to a specified URL
any vaURL, a_null
//setNull(a_null)
vaURL = "D:\PBstuff\PB7only\test2.html"
integer OLECMDID_SAVEAS, OLECMDEXECOPT_DONTPROMPTUSER, OLECMDID_SAVE, OLECMDEXECOPT_PROMPTUSER, ii
OLECMDID_SAVE = 3
OLECMDID_SAVEAS = 4
OLECMDEXECOPT_DONTPROMPTUSER = 2
OLECMDEXECOPT_PROMPTUSER = 1



ole_1.object.ExecWB(OLECMDID_SAVEAS, OLECMDEXECOPT_DONTPROMPTUSER, vaURL, a_null)

ii = 1
end event

type cb_print_setup from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 37
integer y = 332
integer width = 622
integer height = 80
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print Page Setup"
end type

event clicked;// Execute the "Page Setup" dialog
int OLECMDID_PRINT           = 6
int OLECMDID_PRINTPREVIEW    = 7
int OLECMDID_PAGESETUP       = 8

int OLECMDEXECOPT_DODEFAULT      = 0
int OLECMDEXECOPT_PROMPTUSER     = 1
int OLECMDEXECOPT_DONTPROMPTUSER = 2

ole_1.object.ExecWB( OLECMDID_PAGESETUP, OLECMDEXECOPT_DONTPROMPTUSER, AsStatement! )

end event

type cb_url2 from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 1170
integer y = 428
integer width = 439
integer height = 80
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "UI URL"
end type

event clicked;// display the UI Friendly name
string stmp
stmp = ole_1.object.LocationName()

sle_title.text = stmp

lb_1.AddItem( "LocationName: " + stmp )

end event

type cb_url1 from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 731
integer y = 428
integer width = 439
integer height = 80
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Full URL"
end type

event clicked;// display the FULL URL
string stmp
stmp = ole_1.object.LocationURL()

sle_title.text = stmp

lb_1.AddItem( "LocationURL: " + stmp )

end event

type cb_stop from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 1170
integer y = 332
integer width = 439
integer height = 80
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stop"
end type

event clicked;// stop the download
ole_1.object.Stop()

end event

type cb_search from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 731
integer y = 240
integer width = 439
integer height = 80
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Goto Search"
end type

event clicked;// Search on page
ole_1.object.GoSearch()

end event

type sle_title from singlelineedit within w_web_browse_ocx
integer x = 37
integer y = 544
integer width = 3625
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "...title..."
borderstyle borderstyle = stylelowered!
end type

type cb_home from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 1170
integer y = 240
integer width = 439
integer height = 80
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Home"
end type

event clicked;// Navigate to the configured HomePage
ole_1.object.GoHome()

end event

type cb_forward from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 1170
integer y = 140
integer width = 439
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Forward>>"
end type

event clicked;// Navigate Forward in the history list
ole_1.object.GoForward()

end event

type lb_1 from listbox within w_web_browse_ocx
boolean visible = false
integer x = 1943
integer y = 36
integer width = 1390
integer height = 480
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type cb_print from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 37
integer y = 240
integer width = 622
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;// Print this web page
int OLECMDID_PRINT           = 6
int OLECMDID_PRINTPREVIEW    = 7
int OLECMDID_PAGESETUP       = 8

int OLECMDEXECOPT_DODEFAULT      = 0
int OLECMDEXECOPT_PROMPTUSER     = 1
int OLECMDEXECOPT_DONTPROMPTUSER = 2

ole_1.object.ExecWB( OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER )		// this works
// ole_1.object.ExecWB( OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER , AsStatement! )	// this works
// ole_1.object.ExecWB( OLECMDID_PAGESETUP, OLECMDEXECOPT_DONTPROMPTUSER )		      // this works

end event

type sle_1 from singlelineedit within w_web_browse_ocx
event evt_enter ( )
event evt_char pbm_char
event evt_ pbm_keyup
event evt_keyup pbm_keyup
integer x = 37
integer y = 32
integer width = 1573
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "www.google.com"
borderstyle borderstyle = stylelowered!
end type

event evt_keyup;// wait for the <cr>
if key = keyEnter! then
	ole_1.object.Navigate( sle_1.text )
end if
end event

type cb_back from commandbutton within w_web_browse_ocx
boolean visible = false
integer x = 731
integer y = 140
integer width = 439
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<< Back"
end type

event clicked;// Navigate BACK in the history list
ole_1.object.GoBack()

end event

type cb_load_url from commandbutton within w_web_browse_ocx
integer x = 1632
integer y = 36
integer width = 622
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OCX"
end type

event clicked;// Jump to a specified URL
any vaURL, a_null
setNull(a_null)
vaURL = sle_1.text
ole_1.object.Navigate2(vaURL, a_null, a_null, a_null, a_null);
ole_1.object.FullScreen = TRUE
ole_1.object.Offline = TRUE

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
05w_web_browse_ocx.bin 
2700000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000f8bbe00001d0818500000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000f8bbe00001d08185f8bbe00001d08185000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c0000522a000029570000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c0000522a000029570000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15w_web_browse_ocx.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
