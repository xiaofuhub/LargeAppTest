$PBExportHeader$w_wv_help_setup.srw
forward
global type w_wv_help_setup from window
end type
type cb_html from commandbutton within w_wv_help_setup
end type
type st_help_help from statictext within w_wv_help_setup
end type
type cb_1 from commandbutton within w_wv_help_setup
end type
type cb_add from commandbutton within w_wv_help_setup
end type
type cb_save from commandbutton within w_wv_help_setup
end type
type cb_close from commandbutton within w_wv_help_setup
end type
type dw_browse from datawindow within w_wv_help_setup
end type
type dw_detail from datawindow within w_wv_help_setup
end type
end forward

global type w_wv_help_setup from window
integer width = 4105
integer height = 1960
boolean titlebar = true
string title = "WebView Provider Interface Help "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_html cb_html
st_help_help st_help_help
cb_1 cb_1
cb_add cb_add
cb_save cb_save
cb_close cb_close
dw_browse dw_browse
dw_detail dw_detail
end type
global w_wv_help_setup w_wv_help_setup

forward prototypes
public function boolean of_check_duplicate ()
end prototypes

public function boolean of_check_duplicate ();//===================================
// $<Function> of_check_duplicate ()
// $<arguments> none
// $<returns> boolean
// $<description> Check whether the dw_browse have the samw webview tab or screen
// $<add> (Appeon) Long.zhang 08.22.2012
//===================================
long ll_row
long ll_wv_tab
long ll_screen_id
String ls_filter

ll_row = dw_detail.getrow( )

ll_screen_id = dw_detail.getitemnumber(ll_row,"screen_id")
ll_wv_tab = dw_detail.getitemnumber(ll_row,"wv_tab")

ls_filter = "wv_tab="+string(ll_wv_tab)	
if ll_wv_tab = 2 then
	ls_filter += " and screen_id="+string(ll_screen_id)
end if

ll_row = dw_browse.find( ls_filter,1,dw_browse.rowcount())

if dw_detail.getitemstatus(dw_detail.getrow(),0,primary!) = NewModified! then
	if ll_row > 0 then return true
elseif 	dw_detail.getitemstatus(dw_detail.getrow(),0,primary!) = DataModified! then
	if ll_row >0 and ll_row <> dw_browse.getRow() then return true
end if

return false
end function

on w_wv_help_setup.create
this.cb_html=create cb_html
this.st_help_help=create st_help_help
this.cb_1=create cb_1
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_browse=create dw_browse
this.dw_detail=create dw_detail
this.Control[]={this.cb_html,&
this.st_help_help,&
this.cb_1,&
this.cb_add,&
this.cb_save,&
this.cb_close,&
this.dw_browse,&
this.dw_detail}
end on

on w_wv_help_setup.destroy
destroy(this.cb_html)
destroy(this.st_help_help)
destroy(this.cb_1)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_browse)
destroy(this.dw_detail)
end on

event open;long ll_row
string ls_help //maha 11.09.2015
DataWindowChild ldw_browse_child
DataWindowChild ldw_detail_child

dw_browse.settransobject(sqlca)
dw_detail.settransobject(sqlca)

dw_browse.retrieve()

//--------------------appeon Begin-----------------------
//<$>added:long.zhang 08.21.2012
//<$>reason:For Demographics tab help information
dw_browse.getchild("screen_id",ldw_browse_child)
ll_row = ldw_browse_child.insertrow( 1)
if ll_row <> -1 then
	ldw_browse_child.setitem( ll_row, 'data_view_screen_screen_name','')
	ldw_browse_child.setitem( ll_row, 'data_view_screen_screen_id',0)
end if

dw_detail.getchild("screen_id",ldw_detail_child)
ldw_detail_child.reset( )
ldw_browse_child.rowscopy( 1, ldw_browse_child.rowcount(),primary!,ldw_detail_child ,1,primary!)

ls_help = " Using the WebView Provider Help Setup:~r~r"
ls_help+= " Help can be added for each tab of the interface.~r~r"
ls_help+= " For the Demographics tab, help text can be added at the screen level.~r"
ls_help+= " If help is not added for a specific data screen, the generic (having no screen selected) Demographics help text will be used for that screen.~r"

st_help_help.text = ls_help   //Start Code Change ----11.09.2015 #V15 maha


//-------------------appeon end---------------------------
end event

type cb_html from commandbutton within w_wv_help_setup
integer x = 1120
integer y = 36
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "HTML Edit"
end type

event clicked; //Start Code Change ----12.02.2015 #V15 maha
string s

s = dw_detail.getitemstring(1,"help_description")
openwithparm(w_html_edit,s)

if message.stringparm = "CANCEL" then 
	return
else
	dw_detail.setitem(1,"help_description",message.stringparm)
end if
end event

type st_help_help from statictext within w_wv_help_setup
integer x = 2226
integer y = 1044
integer width = 1810
integer height = 780
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "How to use the help setup screen:"
boolean border = true
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_wv_help_setup
integer x = 759
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Import"
end type

event clicked;//Start Code Change ----04.05.2011 #V11 maha - added
string docname, named
string ls_file
integer value
integer res

value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")

IF value = 1 THEN
	ls_file = docname
END IF

res= dw_browse.importfile( ls_file)

if res < 1 then messagebox(ls_file,"Import failed")

dw_browse.update()
end event

type cb_add from commandbutton within w_wv_help_setup
integer x = 393
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;if cb_save.event clicked() = -1 then return	//added by long.zhang 08.21.2012
dw_detail.reset( )
dw_detail.insertrow(1)


end event

type cb_save from commandbutton within w_wv_help_setup
integer x = 37
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;long  lid
long ll_id //maha 12.02.2015
long ll_find  //maha 12.02.2015
integer r
long ll_row
long ll_wv_tab

//-------------appeon begin-------------------------
//<$>added long.zhang 08.21.2012
//<$>reason:Data validate
dw_detail.accepttext( )

ll_row = dw_detail.getrow( )
if ll_row < 1 then return 0

ll_wv_tab = dw_detail.getitemnumber(ll_row,"wv_tab")

if isNull(ll_wv_tab) then
	MessageBox("Prompt","Required value missing for the WebView Tab, please select a value.")
	return -1
end if
if dw_detail.Modifiedcount() = 0 then return 0

if of_check_duplicate() then
	MessageBox("Prompt","The help information for the selected WebView tab is already existed.")
	return -1
end if
//---------------appeon end---------------------------

select max(help_id) into :lid from wv_help;
if isNull(lid) then lid = 0	//added by long.zhang 08.21.2012

for r = 1 to dw_detail.rowcount()
	ll_id = dw_detail.getitemnumber(r,'help_id')   //Start Code Change ----12.02.2015 #V15 maha
	if isnull(ll_id) then
		lid++	
		dw_detail.setitem(r,'help_id',lid)
		ll_id = lid   //Start Code Change ----12.02.2015 #V15 maha
	end if
next

gnv_appeondb.of_startqueue( )//added by long.zhang 08.21.2012
	dw_detail.update()
	dw_browse.retrieve( )
gnv_appeondb.of_commitqueue( )	//added by long.zhang 08.21.2012

 //Start Code Change ----12.02.2015 #V15 maha
ll_find = dw_browse.find("help_id = " + string(ll_id), 1, dw_browse.rowcount())
if ll_find > 0 then
	dw_browse.scrolltorow(ll_find)
	dw_browse.setrow(ll_find)
end if
 //End Code Change ----12.02.2015

return 1
end event

type cb_close from commandbutton within w_wv_help_setup
integer x = 3685
integer y = 40
integer width = 343
integer height = 92
integer taborder = 20
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

type dw_browse from datawindow within w_wv_help_setup
integer x = 18
integer y = 156
integer width = 4014
integer height = 848
integer taborder = 10
string title = "none"
string dataobject = "d_wv_help_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()
this.setrow(r)

end event

event rowfocuschanged;integer r
integer h

r = currentrow

this.selectrow(0,false)
this .selectrow(r,true)
this.scrolltorow(r)

h = this.getitemnumber(r,"help_id")
dw_detail.retrieve(h)

 //Start Code Change ----12.02.2015 #V15 maha
if dw_detail.getitemnumber(1,"help_type") = 1 then
	cb_html.enabled = true
else
	cb_html.enabled = false
end if
 //Start Code Change ----12.02.2015
end event

type dw_detail from datawindow within w_wv_help_setup
integer x = 23
integer y = 1044
integer width = 2162
integer height = 780
integer taborder = 10
string title = "none"
string dataobject = "d_wv_help_de"
boolean livescroll = true
end type

event itemchanged;if dwo.name = "wv_tab" then	//added by long.zhang 08.21.2012
	if data="2" then
		if isnull(this.getItemNumber(row,"screen_id")) then this.setitem( row,"screen_id",0)
	end if	
end if	
 //Start Code Change ----12.02.2015 #V15 maha
if dwo.name = "help_type" then
	if data="1" then
		cb_html.enabled = true
	else
		cb_html.enabled = false
	end if
end if
 //End Code Change ----12.02.2015
end event

