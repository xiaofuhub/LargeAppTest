$PBExportHeader$w_loc_find.srw
forward
global type w_loc_find from window
end type
type rb_suite from radiobutton within w_loc_find
end type
type rb_id from radiobutton within w_loc_find
end type
type rb_city from radiobutton within w_loc_find
end type
type rb_street from radiobutton within w_loc_find
end type
type rb_tin from radiobutton within w_loc_find
end type
type rb_parent_name from radiobutton within w_loc_find
end type
type rb_pho from radiobutton within w_loc_find
end type
type rb_addr from radiobutton within w_loc_find
end type
type cb_close from commandbutton within w_loc_find
end type
type cb_select from commandbutton within w_loc_find
end type
type dw_1 from datawindow within w_loc_find
end type
type cb_1 from commandbutton within w_loc_find
end type
type sle_1 from singlelineedit within w_loc_find
end type
type gb_2 from groupbox within w_loc_find
end type
end forward

global type w_loc_find from window
integer x = 741
integer y = 96
integer width = 3177
integer height = 2492
boolean titlebar = true
string title = "Find Practice"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
rb_suite rb_suite
rb_id rb_id
rb_city rb_city
rb_street rb_street
rb_tin rb_tin
rb_parent_name rb_parent_name
rb_pho rb_pho
rb_addr rb_addr
cb_close cb_close
cb_select cb_select
dw_1 dw_1
cb_1 cb_1
sle_1 sle_1
gb_2 gb_2
end type
global w_loc_find w_loc_find

type variables
long il_addr_id
integer ii_close = 0
end variables

on w_loc_find.create
this.rb_suite=create rb_suite
this.rb_id=create rb_id
this.rb_city=create rb_city
this.rb_street=create rb_street
this.rb_tin=create rb_tin
this.rb_parent_name=create rb_parent_name
this.rb_pho=create rb_pho
this.rb_addr=create rb_addr
this.cb_close=create cb_close
this.cb_select=create cb_select
this.dw_1=create dw_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.gb_2=create gb_2
this.Control[]={this.rb_suite,&
this.rb_id,&
this.rb_city,&
this.rb_street,&
this.rb_tin,&
this.rb_parent_name,&
this.rb_pho,&
this.rb_addr,&
this.cb_close,&
this.cb_select,&
this.dw_1,&
this.cb_1,&
this.sle_1,&
this.gb_2}
end on

on w_loc_find.destroy
destroy(this.rb_suite)
destroy(this.rb_id)
destroy(this.rb_city)
destroy(this.rb_street)
destroy(this.rb_tin)
destroy(this.rb_parent_name)
destroy(this.rb_pho)
destroy(this.rb_addr)
destroy(this.cb_close)
destroy(this.cb_select)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.gb_2)
end on

event open;	
dw_1.retrieve()
end event

type rb_suite from radiobutton within w_loc_find
integer x = 1710
integer y = 168
integer width = 224
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Suite"
end type

event clicked;sle_1.setfocus( )
end event

type rb_id from radiobutton within w_loc_find
integer x = 2601
integer y = 168
integer width = 370
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Location ID"
end type

event clicked;sle_1.setfocus( )
end event

type rb_city from radiobutton within w_loc_find
integer x = 1481
integer y = 168
integer width = 224
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "City"
end type

event clicked;sle_1.setfocus( )
end event

type rb_street from radiobutton within w_loc_find
integer x = 1184
integer y = 164
integer width = 270
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Street"
end type

event clicked;sle_1.setfocus( )
end event

type rb_tin from radiobutton within w_loc_find
integer x = 2373
integer y = 168
integer width = 215
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "TIN"
end type

event clicked;sle_1.setfocus( )
end event

type rb_parent_name from radiobutton within w_loc_find
integer x = 46
integer y = 164
integer width = 389
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Group Name"
end type

event clicked;sle_1.setfocus( )
end event

type rb_pho from radiobutton within w_loc_find
integer x = 2007
integer y = 168
integer width = 311
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Phone #"
end type

event clicked;sle_1.setfocus( )
end event

type rb_addr from radiobutton within w_loc_find
integer x = 480
integer y = 164
integer width = 645
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Practice Location  Name"
boolean checked = true
end type

event clicked;sle_1.setfocus( )
end event

type cb_close from commandbutton within w_loc_find
integer x = 2880
integer y = 16
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type cb_select from commandbutton within w_loc_find
integer x = 2533
integer y = 16
integer width = 311
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
boolean default = true
end type

event clicked;Integer li_Rc
Integer i

ii_close = 1
CloseWithReturn( Parent, il_addr_id )


end event

type dw_1 from datawindow within w_loc_find
integer x = 14
integer y = 292
integer width = 3154
integer height = 2120
integer taborder = 60
string dataobject = "d_group_prac_search"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;Integer li_row

li_row = this.getclickedrow()
il_addr_id = dw_1.getitemnumber(li_row,"rec_id")



end event

event doubleclicked;cb_select.TriggerEvent( Clicked! )

end event

event constructor;this.settransobject(sqlca)

DataWindowChild dwchild


This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
dwchild.InsertRow( 1 )



end event

event itemchanged;//added maha 083004 for checking add/update default does not work
//
//long i
//long ic
//integer cnt
//
//this.accepttext()
//
//for i = 1 to ic
//	if this.getitemnumber(i,"selected") = 0 then //this means it will be checked
//		cnt++
//	end if
//	if cnt > 1 then //if more that one selected default to add
//		gi_temp_switch = 0
//		rb_add.checked = true
//		rb_up.checked = false
//		rb_up.enabled = false
//		exit
//	else
//		rb_up.enabled = true
//	end if
//next

end event

type cb_1 from commandbutton within w_loc_find
integer x = 1253
integer y = 16
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;string ls_filter = ""
integer li_rtnval

if isnull(sle_1.text) then return

ls_filter = upper(sle_1.text)

if ls_filter = "" then 
	ls_filter = ""
else
	 //Start Code Change ----10.19.2015 #V15 maha - modified for apostrophie
	if rb_addr.checked = true then 
		//ls_filter = "upper(street) like '%" + ls_filter + "%'"  
		ls_filter = 'upper(street) like "%' + ls_filter + '%"'
	elseif rb_pho.checked = true then 	
		ls_filter = 'phone like "%' + ls_filter + '%"'
	elseif rb_tin.checked = true then 	
		ls_filter = 'upper(tax_id) like "%' + ls_filter + '%"'
	elseif rb_street.checked = true then 	
		ls_filter = 'upper(street_2) like "%' + ls_filter + '%"'
	elseif rb_city.checked = true then 	
		ls_filter = 'upper(city) like "%' + ls_filter + '%"'
	elseif rb_id.checked = true then 	
		ls_filter = 'rec_id  = ' + ls_filter + ''	
	elseif rb_suite.checked = true then 	
		ls_filter = 'upper(suite_apart) like "%' + ls_filter + '%"'
	else
		ls_filter = 'upper(gp_name) like "%' + ls_filter + '%"' //alfee 12.12.2008
		//ls_filter = "gp_name like '%" + ls_filter + "%'"
	end if
	//End Code Change ----10.19.2015
end if
	

//messagebox("filter",ls_filter)
//li_rtnval = 
dw_1.setfilter(ls_filter)  
if li_rtnval < 0 then messagebox("Location Search","Filter Failed")
dw_1.filter()

dw_1.groupcalc( )  //Start Code Change ----04.24.2014 #V14.2 maha - regroup data
//

end event

type sle_1 from singlelineedit within w_loc_find
integer x = 41
integer y = 12
integer width = 1193
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_loc_find
integer x = 9
integer y = 112
integer width = 3154
integer height = 172
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filter By"
end type

