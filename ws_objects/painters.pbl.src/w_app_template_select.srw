$PBExportHeader$w_app_template_select.srw
forward
global type w_app_template_select from window
end type
type cb_1 from commandbutton within w_app_template_select
end type
type cb_filter from commandbutton within w_app_template_select
end type
type sle_filter from singlelineedit within w_app_template_select
end type
type cb_close from commandbutton within w_app_template_select
end type
type cb_copy from commandbutton within w_app_template_select
end type
type dw_browse from u_dw within w_app_template_select
end type
type dw_loc from datawindow within w_app_template_select
end type
type dw_items from u_dw within w_app_template_select
end type
end forward

global type w_app_template_select from window
integer width = 3845
integer height = 2464
boolean titlebar = true
string title = "Application Template Select"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_filter cb_filter
sle_filter sle_filter
cb_close cb_close
cb_copy cb_copy
dw_browse dw_browse
dw_loc dw_loc
dw_items dw_items
end type
global w_app_template_select w_app_template_select

type variables
long il_temp_id
long il_facil
end variables

on w_app_template_select.create
this.cb_1=create cb_1
this.cb_filter=create cb_filter
this.sle_filter=create sle_filter
this.cb_close=create cb_close
this.cb_copy=create cb_copy
this.dw_browse=create dw_browse
this.dw_loc=create dw_loc
this.dw_items=create dw_items
this.Control[]={this.cb_1,&
this.cb_filter,&
this.sle_filter,&
this.cb_close,&
this.cb_copy,&
this.dw_browse,&
this.dw_loc,&
this.dw_items}
end on

on w_app_template_select.destroy
destroy(this.cb_1)
destroy(this.cb_filter)
destroy(this.sle_filter)
destroy(this.cb_close)
destroy(this.cb_copy)
destroy(this.dw_browse)
destroy(this.dw_loc)
destroy(this.dw_items)
end on

event open;//Start Code Change ----03.13.2013 #V12 maha - screen created
//il_facil = message.doubleparm
//
dw_browse.retrieve()
//
//dw_browse.setfilter("facility_id = " + string( il_facil))
//dw_browse.filter()

//Start Code Change ----01.06.2015 #V14.2 maha
choose case gi_intelliapp_type
	case 3,0
		dw_loc.visible = false
		dw_browse.height = 1280
end choose
//Start Code Change ----01.06.2015
end event

type cb_1 from commandbutton within w_app_template_select
integer x = 1175
integer y = 36
integer width = 178
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;dw_browse.setfilter("")
dw_browse.filter()
end event

type cb_filter from commandbutton within w_app_template_select
integer x = 942
integer y = 36
integer width = 238
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;//Start Code Change ----04.23.2014 #V14.2 maha - added
string s

s = sle_filter.text
s = upper(s)

if len(s) = 0 then
	dw_browse.setfilter("")
else
	dw_browse.setfilter("posA(  upper(temp_name) , '" + s + "', 1 ) > 0")
end if

dw_browse.filter()

end event

type sle_filter from singlelineedit within w_app_template_select
integer x = 69
integer y = 36
integer width = 864
integer height = 88
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

type cb_close from commandbutton within w_app_template_select
integer x = 3470
integer y = 36
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;closewithreturn(parent, "Cancel")
end event

type cb_copy from commandbutton within w_app_template_select
integer x = 2194
integer y = 36
integer width = 370
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;gs_pass_ids lst_ids
integer r
long ll_loc //maha 04.28.2014
long ll_app
long ll_facil


for r = 1 to dw_items.rowcount()
	if dw_items.getitemnumber(r, "selected") = 1 then
		ll_app = dw_items.getitemnumber(r, "app_id")
		lst_ids.l_ids[ upperbound(lst_ids.l_ids) + 1 ] = ll_app
	end if
next

//Start Code Change ----04.28.2014 #V14.2 maha
for r = 1 to dw_loc.rowcount()
	if dw_loc.getitemnumber(r, "selected") = 1 then
		ll_loc = dw_loc.getitemnumber(r, "loc_id")
		lst_ids.sl_action_type[ upperbound(lst_ids.sl_action_type) + 1 ] = ll_loc
	end if
next
//End Code Change ----04.28.2014


ll_facil = dw_browse.getitemnumber(dw_browse.getrow(), "facility_id")
if isnull(ll_facil) then ll_facil = 0
lst_ids.facility_id = ll_facil

closewithreturn(parent, lst_ids)


end event

type dw_browse from u_dw within w_app_template_select
integer x = 5
integer y = 160
integer width = 3808
integer height = 1000
integer taborder = 10
string dataobject = "d_app_template_browse_select"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;long r

r = this.getclickedrow( )
this.setrow(r)

end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return  //Start Code Change ----04.23.2014 #V14.2 maha

il_temp_id = this.getitemnumber( currentrow , "temp_id" )
this.selectrow(0, false)
this.selectrow(currentrow, true)
dw_loc.retrieve(il_temp_id)
dw_items.retrieve(il_temp_id)
end event

type dw_loc from datawindow within w_app_template_select
integer x = 5
integer y = 1176
integer width = 3813
integer height = 268
integer taborder = 20
string title = "none"
string dataobject = "d_app_template_locations_get"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type dw_items from u_dw within w_app_template_select
integer y = 1460
integer width = 3822
integer height = 908
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_app_temp_items_select"
borderstyle borderstyle = stylebox!
end type

