$PBExportHeader$w_ccp_facility.srw
forward
global type w_ccp_facility from window
end type
type cb_2 from commandbutton within w_ccp_facility
end type
type cb_1 from commandbutton within w_ccp_facility
end type
type dw_2 from datawindow within w_ccp_facility
end type
type dw_1 from datawindow within w_ccp_facility
end type
end forward

global type w_ccp_facility from window
integer width = 1993
integer height = 1720
boolean titlebar = true
string title = "Common Core Privilege Facilities"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_ccp_facility w_ccp_facility

type variables
long il_clinid
end variables

on w_ccp_facility.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_ccp_facility.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;//Start Code Change ---- 10.03.2006 #660 maha
//window created 10.03.06
il_clinid = message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_2.settransobject(sqlca)
dw_2.retrieve(il_clinid)
end event

type cb_2 from commandbutton within w_ccp_facility
integer x = 1550
integer y = 1504
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_ccp_facility
integer x = 1189
integer y = 1504
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;integer i
long ccpid

select max(ccp_id) into :ccpid from priv_ccp_facility;

if isnull(ccpid) then ccpid = 0

for i = 1 to dw_2.rowcount()
	if isnull(dw_2.getitemnumber(i,"ccp_id")) then
		ccpid++
		dw_2.setitem(i,"ccp_id",ccpid)
	end if
next

dw_2.update()

close(parent)
		
end event

type dw_2 from datawindow within w_ccp_facility
integer y = 756
integer width = 1975
integer height = 720
integer taborder = 20
boolean titlebar = true
string title = "Double-click to Remove"
string dataobject = "d_ccp_facil_add"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;this.deleterow(this.getrow())
end event

event clicked;integer i

i = this.getclickedrow()
this.setrow(i)
end event

type dw_1 from datawindow within w_ccp_facility
integer width = 1970
integer height = 748
integer taborder = 10
boolean titlebar = true
string title = "Double-click to Add"
string dataobject = "d_facility_list_for_list_view"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;long li_fac
integer li_find

li_fac = this.getitemnumber(this.getrow(), "facility_id" )

// R. Avital v11.3 BugS082103
// Commented line below was performing "dw.find()" on wrong criteria, which allowed
// User to re-add the same facility over and over.
// Begin changes

//li_find = dw_2.find ("facility_id  = " + string(il_clinid),1,dw_2.rowcount() )
li_find = dw_2.find ("facility_id  = " + string(li_fac),1,dw_2.rowcount() )
// End changes

if li_find = 0 then
	dw_2.insertrow(1)
	dw_2.setitem(1, "facility_id", li_fac)
	dw_2.setitem(1, "clin_id", il_clinid)
end if

//il_clinid
end event

event clicked;integer i

i = this.getclickedrow()
this.setrow(i)
end event

