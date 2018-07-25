$PBExportHeader$w_procd_migrate.srw
forward
global type w_procd_migrate from window
end type
type cb_create_procd from commandbutton within w_procd_migrate
end type
type cb_close from commandbutton within w_procd_migrate
end type
type cb_create_lu from commandbutton within w_procd_migrate
end type
type cb_check_lu from commandbutton within w_procd_migrate
end type
type dw_section_list from datawindow within w_procd_migrate
end type
type dw_clin_list from datawindow within w_procd_migrate
end type
type dw_section from datawindow within w_procd_migrate
end type
type dw_clin_area from datawindow within w_procd_migrate
end type
type dw_procd from datawindow within w_procd_migrate
end type
type dw_data from datawindow within w_procd_migrate
end type
end forward

global type w_procd_migrate from window
integer width = 4133
integer height = 1900
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_create_procd cb_create_procd
cb_close cb_close
cb_create_lu cb_create_lu
cb_check_lu cb_check_lu
dw_section_list dw_section_list
dw_clin_list dw_clin_list
dw_section dw_section
dw_clin_area dw_clin_area
dw_procd dw_procd
dw_data dw_data
end type
global w_procd_migrate w_procd_migrate

on w_procd_migrate.create
this.cb_create_procd=create cb_create_procd
this.cb_close=create cb_close
this.cb_create_lu=create cb_create_lu
this.cb_check_lu=create cb_check_lu
this.dw_section_list=create dw_section_list
this.dw_clin_list=create dw_clin_list
this.dw_section=create dw_section
this.dw_clin_area=create dw_clin_area
this.dw_procd=create dw_procd
this.dw_data=create dw_data
this.Control[]={this.cb_create_procd,&
this.cb_close,&
this.cb_create_lu,&
this.cb_check_lu,&
this.dw_section_list,&
this.dw_clin_list,&
this.dw_section,&
this.dw_clin_area,&
this.dw_procd,&
this.dw_data}
end on

on w_procd_migrate.destroy
destroy(this.cb_create_procd)
destroy(this.cb_close)
destroy(this.cb_create_lu)
destroy(this.cb_check_lu)
destroy(this.dw_section_list)
destroy(this.dw_clin_list)
destroy(this.dw_section)
destroy(this.dw_clin_area)
destroy(this.dw_procd)
destroy(this.dw_data)
end on

type cb_create_procd from commandbutton within w_procd_migrate
integer x = 3538
integer y = 712
integer width = 443
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create procedures"
end type

event clicked;long r
long rc
long p
long pc
long nr
long ll_facil
long ll_ca
long ll_sect
long ll_pracdid
integer f
string ls_ca
string ls_sect
string ls_desc
string ls_name

dw_data.settransobject(sqlca)
dw_procd.settransobject(sqlca)

pc = dw_procd.retrieve()

if pc > 0 then return

rc = dw_data.retrieve()
	
for r = 1 to rc
	//get data values
	ll_facil = dw_data.getitemnumber(r,"facility_id")
	ls_ca = dw_data.getitemstring(r,"clinical_area_description")
	ll_pracdid = dw_data.getitemnumber(r,"priv_core_procd_procd_id")
	ls_sect = dw_data.getitemstring(r,"priv_core_description") 
	ls_sect = mid(ls_sect,1,75) //limit length for lookup table search
	ls_desc = dw_data.getitemstring(r,"procd_description")
	ls_name = dw_data.getitemstring(r,"procd_name")
	//if name or desc are blank copy other value
	if len(ls_desc) = 0 then ls_desc = ls_name
	if len(ls_name) = 0 then ls_name = ls_desc
	
	f = dw_clin_area.find( "description = '" + ls_ca + "'", 1,dw_clin_area.rowcount())
	if f < 1 then  messagebox("CA filter", ls_ca)
	ll_ca = dw_clin_area.getitemnumber ( f,"lookup_code")
	f = dw_section.find( "description = '" + ls_sect + "'", 1,dw_section.rowcount())
	if f < 1 then  messagebox("Section filter", ls_sect)
	ll_sect = dw_section.getitemnumber ( f,"lookup_code")
	
	nr = dw_procd.insertrow(0)
	dw_procd.setitem(nr,"clinical_area_id",ll_ca)
	dw_procd.setitem(nr,"section_id",ll_sect)
	dw_procd.setitem(nr,"facility_specific",ll_facil)
	dw_procd.setitem(nr,"procedure_description",ls_desc)
	dw_procd.setitem(nr,"procd_name",ls_name)
	dw_procd.setitem(nr,"procedure_pk",ll_pracdid)
	dw_procd.setitem(nr,"active_status",1)

next

dw_procd.update()

update pd_priv_list set procd_lookup_id = procd_id where procd_lookup_id is null;
	
end event

type cb_close from commandbutton within w_procd_migrate
integer x = 3726
integer y = 36
integer width = 343
integer height = 92
integer taborder = 60
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

type cb_create_lu from commandbutton within w_procd_migrate
integer x = 3022
integer y = 148
integer width = 393
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create lookups"
end type

event clicked;integer cc
integer sc
integer r
integer rc
integer nr
integer p
long ll_lid
string ls_descr
string ls_code

dw_clin_area.settransobject(sqlca)
dw_section.settransobject(sqlca)

cc = dw_clin_area.retrieve()
sc = dw_section.retrieve()


if cc= 0 then
	dw_clin_list.settransobject(sqlca)
	rc = dw_clin_list.retrieve()
	for r = 1 to rc
		ls_descr = dw_clin_list.getitemstring(r,"clinical_area_description")
		p = pos(ls_descr," ",1)
		if p = 0 then p = 15
		ls_code = mid(ls_descr,1,p -1)
		ls_code = upper(ls_code)
		nr = dw_clin_area.insertrow(0)
		dw_clin_area.setitem( nr,"description", ls_descr)
		dw_clin_area.setitem( nr,"code", ls_code)
		dw_clin_area.setitem( nr,"lookup_name", "Priv Clinical Area")
	next
	debugbreak()
	ll_lid = gnv_app.of_get_id("LOOKUP", nr)
	for r = 1 to dw_clin_area.rowcount( )
		dw_clin_area.setitem( r,"lookup_code", ll_lid)
		ll_lid++
	next
	dw_clin_area.update()
end if

if sc= 0 then
	dw_section_list.settransobject(sqlca)
	rc = dw_section_list.retrieve()
	for r = 1 to rc
		ls_descr = dw_section_list.getitemstring(r,"priv_core_description")
		p = pos(ls_descr," ",1)
		if p = 0 then p = 15
		ls_code = mid(ls_descr,1,p -1)
		ls_code = upper(ls_code)
		nr = dw_section.insertrow(0)
		dw_section.setitem( nr,"description", ls_descr)
		dw_section.setitem( nr,"code", ls_code)
		dw_section.setitem( nr,"lookup_name", "Priv Section")
	next
	ll_lid = gnv_app.of_get_id("LOOKUP", nr)
	for r = 1 to dw_section.rowcount( )
		dw_section.setitem( r,"lookup_code", ll_lid)
		ll_lid++
	next
	dw_section.update()
end if
		
		
end event

type cb_check_lu from commandbutton within w_procd_migrate
integer x = 3026
integer y = 44
integer width = 370
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Check lookups"
end type

event clicked;dw_clin_area.settransobject(sqlca)
dw_section.settransobject(sqlca)

dw_clin_area.retrieve()
dw_section.retrieve()
end event

type dw_section_list from datawindow within w_procd_migrate
integer x = 2263
integer y = 128
integer width = 635
integer height = 312
integer taborder = 60
string title = "none"
string dataobject = "d_section_migrate"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_clin_list from datawindow within w_procd_migrate
integer x = 1536
integer y = 124
integer width = 690
integer height = 312
integer taborder = 50
string title = "none"
string dataobject = "d_clin_area_migrate"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_section from datawindow within w_procd_migrate
integer x = 768
integer y = 28
integer width = 686
integer height = 400
integer taborder = 40
string title = "none"
string dataobject = "d_dddw_code_lookup_subsection"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_clin_area from datawindow within w_procd_migrate
integer x = 50
integer y = 28
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_dddw_code_lookup_clin_area"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_procd from datawindow within w_procd_migrate
integer x = 73
integer y = 1208
integer width = 3995
integer height = 540
integer taborder = 20
string title = "none"
string dataobject = "d_priv_procd_lookup_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_data from datawindow within w_procd_migrate
integer x = 73
integer y = 472
integer width = 3433
integer height = 700
integer taborder = 10
string title = "none"
string dataobject = "d_procd_migration"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

