$PBExportHeader$w_web_crawler_user_info.srw
forward
global type w_web_crawler_user_info from window
end type
type cb_close from commandbutton within w_web_crawler_user_info
end type
type cb_save from commandbutton within w_web_crawler_user_info
end type
type tab_1 from tab within w_web_crawler_user_info
end type
type tabpage_detail from userobject within tab_1
end type
type dw_detail from datawindow within tabpage_detail
end type
type dw_brow from datawindow within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
dw_detail dw_detail
dw_brow dw_brow
end type
type tabpage_links from userobject within tab_1
end type
type dw_links from datawindow within tabpage_links
end type
type dw_param from datawindow within tabpage_links
end type
type tabpage_links from userobject within tab_1
dw_links dw_links
dw_param dw_param
end type
type tabpage_lookup from userobject within tab_1
end type
type dw_map_detail from datawindow within tabpage_lookup
end type
type dw_map_browse from datawindow within tabpage_lookup
end type
type tabpage_lookup from userobject within tab_1
dw_map_detail dw_map_detail
dw_map_browse dw_map_browse
end type
type tab_1 from tab within w_web_crawler_user_info
tabpage_detail tabpage_detail
tabpage_links tabpage_links
tabpage_lookup tabpage_lookup
end type
end forward

global type w_web_crawler_user_info from window
integer width = 3058
integer height = 2384
boolean titlebar = true
string title = "Web Crawler User Settings"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_save cb_save
tab_1 tab_1
end type
global w_web_crawler_user_info w_web_crawler_user_info

type variables
long il_wcid
end variables

forward prototypes
public function integer of_get_links (long al_wcid, string as_lu)
public function integer of_update_links ()
end prototypes

public function integer of_get_links (long al_wcid, string as_lu);long i 
long ic
datawindow dwlink
datawindow dwlookup

dwlink = tab_1.tabpage_links.dw_links
dwlookup = tab_1.tabpage_lookup.dw_map_browse

ic = dwlink.retrieve(as_lu,al_wcid)

dwlookup.retrieve(al_wcid)

for i = 1 to ic
	if not isnull(dwlink.getitemnumber(i,"wc_lookup_code")) then
		dwlink.setitem(i,"selected",1)
	end if
next

return 1
end function

public function integer of_update_links ();long i 
long ic
long ll_luc
long cnt
string ls_insert[]
datawindow dwlink

dwlink = tab_1.tabpage_links.dw_links

ic = dwlink.rowcount( )
cnt = 1
ls_insert[1] = "delete from wc_multi_entity_link where wc_id = " + string(il_wcid) + ";"
ls_insert[2] = "commit using sqlca;"
for i = 1 to ic
	if dwlink.getitemnumber(i,"selected") = 1 then
		ll_luc = dwlink.getitemnumber(i,"lookup_code")
		cnt++
		ls_insert[cnt] = "insert into wc_multi_entity_link  values( " + string(il_wcid) + ", " + string(ll_luc) + " );"
		
	end if
next
cnt++
ls_insert[cnt] = "commit using sqlca;"
for i = 1 to upperbound(ls_insert[])
	//messagebox("",ls_insert[i])
	execute immediate :ls_insert[i] using sqlca;
next


return 1
end function

on w_web_crawler_user_info.create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.tab_1=create tab_1
this.Control[]={this.cb_close,&
this.cb_save,&
this.tab_1}
end on

on w_web_crawler_user_info.destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.tab_1)
end on

event open;tab_1.tabpage_detail.dw_brow.settransobject( sqlca)
tab_1.tabpage_detail.dw_detail.settransobject( sqlca)
tab_1.tabpage_links.dw_param.settransobject( sqlca)
tab_1.tabpage_links.dw_links.settransobject( sqlca)

tab_1.tabpage_detail.dw_brow.retrieve()



end event

type cb_close from commandbutton within w_web_crawler_user_info
integer x = 2551
integer y = 12
integer width = 343
integer height = 84
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

type cb_save from commandbutton within w_web_crawler_user_info
integer x = 2185
integer y = 12
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;tab_1.tabpage_detail.dw_detail.update()
tab_1.tabpage_lookup.dw_map_detail.update() //add by stephen 03.05.2013 -Bug 3432
of_update_links( )

end event

type tab_1 from tab within w_web_crawler_user_info
event create ( )
event destroy ( )
integer y = 24
integer width = 3017
integer height = 2248
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_detail tabpage_detail
tabpage_links tabpage_links
tabpage_lookup tabpage_lookup
end type

on tab_1.create
this.tabpage_detail=create tabpage_detail
this.tabpage_links=create tabpage_links
this.tabpage_lookup=create tabpage_lookup
this.Control[]={this.tabpage_detail,&
this.tabpage_links,&
this.tabpage_lookup}
end on

on tab_1.destroy
destroy(this.tabpage_detail)
destroy(this.tabpage_links)
destroy(this.tabpage_lookup)
end on

type tabpage_detail from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2981
integer height = 2132
long backcolor = 33551856
string text = "Web Crawlers"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_detail dw_detail
dw_brow dw_brow
end type

on tabpage_detail.create
this.dw_detail=create dw_detail
this.dw_brow=create dw_brow
this.Control[]={this.dw_detail,&
this.dw_brow}
end on

on tabpage_detail.destroy
destroy(this.dw_detail)
destroy(this.dw_brow)
end on

type dw_detail from datawindow within tabpage_detail
integer y = 996
integer width = 2990
integer height = 1132
integer taborder = 30
boolean titlebar = true
string title = "Crawler Detail"
string dataobject = "d_wc_header_user"
boolean livescroll = true
end type

type dw_brow from datawindow within tabpage_detail
integer y = 12
integer width = 2981
integer height = 972
integer taborder = 30
boolean titlebar = true
string title = "Web Crawlers"
string dataobject = "d_wc_browse"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;long i
string ls_lu_name

if this.rowcount() < 1 then return  //Start Code Change ---- 05.01.2007 #V7 maha error trap

this.setrow( currentrow)
this.selectrow( 0,false)
this.selectrow( currentrow,true)

i = this.getitemnumber(currentrow,"wc_id")
il_wcid = i
dw_detail.retrieve(i )
tab_1.tabpage_links.dw_param.retrieve(i)
ls_lu_name = tab_1.tabpage_links.dw_param.getitemstring(1,"wc_comparison_lookup_table")
if not isnull(ls_lu_name ) then
	of_get_links(i,ls_lu_name)
else 
	tab_1.tabpage_links.dw_links.reset()
end if


end event

event doubleclicked;tab_1.selecttab( 2)
end event

type tabpage_links from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2981
integer height = 2132
long backcolor = 33551856
string text = "Link Parameters"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_links dw_links
dw_param dw_param
end type

on tabpage_links.create
this.dw_links=create dw_links
this.dw_param=create dw_param
this.Control[]={this.dw_links,&
this.dw_param}
end on

on tabpage_links.destroy
destroy(this.dw_links)
destroy(this.dw_param)
end on

type dw_links from datawindow within tabpage_links
integer y = 688
integer width = 2981
integer height = 1448
integer taborder = 40
boolean titlebar = true
string title = "Entity Links"
string dataobject = "d_wc_lookup_data_linked"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;integer i
integer val
string ls_title

if dwo.name = "b_1" then
	if dwo.text = "Select All" then
		val = 1
		ls_title = "Deselect All"
	else
		val = 0
		ls_title = "Select All"
	end if
	for i = 1 to this.rowcount()
		this.setitem(i,"selected",val)
	next
	dwo.text = ls_title
			
end if
end event

type dw_param from datawindow within tabpage_links
integer y = 4
integer width = 2981
integer height = 680
integer taborder = 30
boolean titlebar = true
string title = "D/E Screen Link Parameters"
string dataobject = "d_wc_data_link_user"
boolean livescroll = true
end type

type tabpage_lookup from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2981
integer height = 2132
long backcolor = 33551856
string text = "Lookup Values"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_map_detail dw_map_detail
dw_map_browse dw_map_browse
end type

on tabpage_lookup.create
this.dw_map_detail=create dw_map_detail
this.dw_map_browse=create dw_map_browse
this.Control[]={this.dw_map_detail,&
this.dw_map_browse}
end on

on tabpage_lookup.destroy
destroy(this.dw_map_detail)
destroy(this.dw_map_browse)
end on

type dw_map_detail from datawindow within tabpage_lookup
integer y = 416
integer width = 2971
integer height = 1716
integer taborder = 50
string title = "none"
string dataobject = "d_web_data_map_user"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type dw_map_browse from datawindow within tabpage_lookup
integer y = 8
integer width = 2976
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_wc_steps_browse_user"
boolean livescroll = true
end type

event rowfocuschanged;string ls_table
datawindowchild dwchild

if this.rowcount() > 0 then //Start Code Change ---- 04.10.2007 #V7 maha
	dw_map_detail.retrieve(il_wcid , this.getitemnumber( currentrow,"step_order"))
	ls_table = this.getitemstring( currentrow,"content_or_value")

	dw_map_detail.GetChild( "intellicred_data", dwchild )
	dwchild.settransobject(sqlca)
	dwchild.retrieve(ls_table)
end if
//dwchild.insertrow(1)
end event

event constructor;this.settransobject(sqlca)
end event

