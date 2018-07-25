$PBExportHeader$w_screen_alias_set.srw
forward
global type w_screen_alias_set from window
end type
type cb_1 from commandbutton within w_screen_alias_set
end type
type cb_ok from commandbutton within w_screen_alias_set
end type
type cb_close from commandbutton within w_screen_alias_set
end type
type dw_values from datawindow within w_screen_alias_set
end type
end forward

global type w_screen_alias_set from window
integer x = 5
integer y = 48
integer width = 3090
integer height = 816
boolean titlebar = true
string title = "Edit Screen Alias"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_1 cb_1
cb_ok cb_ok
cb_close cb_close
dw_values dw_values
end type
global w_screen_alias_set w_screen_alias_set

type variables
string is_field1
string is_field2
string is_field3
string is_table
string is_where
integer ii_screen = 0
integer ii_view
end variables

on w_screen_alias_set.create
this.cb_1=create cb_1
this.cb_ok=create cb_ok
this.cb_close=create cb_close
this.dw_values=create dw_values
this.Control[]={this.cb_1,&
this.cb_ok,&
this.cb_close,&
this.dw_values}
end on

on w_screen_alias_set.destroy
destroy(this.cb_1)
destroy(this.cb_ok)
destroy(this.cb_close)
destroy(this.dw_values)
end on

event open;//Start Code Change ----10.10.2016 #V152 maha - added screen
integer p
integer r
integer rc
string s

s = message.stringparm

p = pos(s,"*", 1)
debugbreak()
ii_screen = integer(mid(s,1,p - 1))
ii_view = integer(mid(s,p +1))

dw_values.settransobject(sqlca)
rc = dw_values.retrieve(ii_screen)

r = dw_values.find( "data_view_id = " + string(ii_view), 1, rc)
if r > 0 then
	dw_values.selectrow(r,true)
	dw_values.scrolltorow(r)
end if

end event

type cb_1 from commandbutton within w_screen_alias_set
integer x = 1774
integer y = 36
integer width = 434
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy First Value"
end type

event clicked;integer r
string s

if dw_values.rowcount() < 2 then return

s = dw_values.getitemstring(1,"screen_alias")

for r = 2 to dw_values.rowcount()
	dw_values.setitem(r, "screen_alias", s)
next
	
end event

type cb_ok from commandbutton within w_screen_alias_set
integer x = 2528
integer y = 36
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;integer r
string s

dw_values.update()
debugbreak()
r = dw_values.find( "data_view_id = " + string(ii_view), 1, dw_values.rowcount())
if r > 0 then
	s = dw_values.getitemstring(r,"screen_alias")
end if

s = "1*" + s

closewithreturn(parent, s)

end event

type cb_close from commandbutton within w_screen_alias_set
integer x = 2789
integer y = 36
integer width = 274
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "0")
end event

type dw_values from datawindow within w_screen_alias_set
integer x = 5
integer y = 152
integer width = 3072
integer height = 580
integer taborder = 20
string dataobject = "d_screen_alias_edit"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;DataWindowChild dwchild

This.GetChild( "reference_field_1", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)

This.GetChild( "reference_field_2", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)

This.GetChild( "reference_field_3", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)

This.GetChild( "exp_field", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)






end event

