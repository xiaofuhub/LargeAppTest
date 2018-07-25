$PBExportHeader$w_practice_to_addr_find_new.srw
forward
global type w_practice_to_addr_find_new from window
end type
type rb_state from radiobutton within w_practice_to_addr_find_new
end type
type rb_suite from radiobutton within w_practice_to_addr_find_new
end type
type rb_id from radiobutton within w_practice_to_addr_find_new
end type
type rb_city from radiobutton within w_practice_to_addr_find_new
end type
type rb_street from radiobutton within w_practice_to_addr_find_new
end type
type rb_tin from radiobutton within w_practice_to_addr_find_new
end type
type cb_add_loc from commandbutton within w_practice_to_addr_find_new
end type
type rb_up from radiobutton within w_practice_to_addr_find_new
end type
type rb_add from radiobutton within w_practice_to_addr_find_new
end type
type rb_parent_name from radiobutton within w_practice_to_addr_find_new
end type
type rb_pho from radiobutton within w_practice_to_addr_find_new
end type
type rb_addr from radiobutton within w_practice_to_addr_find_new
end type
type cb_3 from commandbutton within w_practice_to_addr_find_new
end type
type cb_populate from commandbutton within w_practice_to_addr_find_new
end type
type dw_1 from datawindow within w_practice_to_addr_find_new
end type
type cb_filter from commandbutton within w_practice_to_addr_find_new
end type
type sle_1 from singlelineedit within w_practice_to_addr_find_new
end type
type gb_1 from groupbox within w_practice_to_addr_find_new
end type
type gb_2 from groupbox within w_practice_to_addr_find_new
end type
end forward

global type w_practice_to_addr_find_new from window
integer x = 741
integer y = 96
integer width = 3214
integer height = 2412
boolean titlebar = true
string title = "Find Practice"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
rb_state rb_state
rb_suite rb_suite
rb_id rb_id
rb_city rb_city
rb_street rb_street
rb_tin rb_tin
cb_add_loc cb_add_loc
rb_up rb_up
rb_add rb_add
rb_parent_name rb_parent_name
rb_pho rb_pho
rb_addr rb_addr
cb_3 cb_3
cb_populate cb_populate
dw_1 dw_1
cb_filter cb_filter
sle_1 sle_1
gb_1 gb_1
gb_2 gb_2
end type
global w_practice_to_addr_find_new w_practice_to_addr_find_new

type variables
long il_addr_id[]
integer ii_close = 0
end variables

forward prototypes
public function integer of_search_groups (string as_value)
public function string of_replace (string arg_str, string arg_old, string arg_new)
end prototypes

public function integer of_search_groups (string as_value);//Start Code Change ----10.123.2017 #V154 maha - added for retrieval search
string ls_sql_org
string ls_sql
string ls_filter
integer ans

ls_sql_org = dw_1.getsqlselect( ) //(Appeon)Stephen 11.02.2017 - Alpha id 5868 - Find Addresses Search Error  C/S 15.406 10202017, SaaS 
if as_value = "" then
	ans = messagebox("Search All?","You have not  entered a search value.  Do you want to retrieve all Group/Location records?", question!, yesno!, 2)
	if ans = 2 then return 1
else
	ls_filter = as_value
	ls_filter = of_replace(ls_filter,"'","''") //(Appeon)Stephen 11.02.2017 - Alpha id 5868 - Find Addresses Search Error  C/S 15.406 10202017, SaaS 
	if rb_addr.checked = true then 
		//ls_filter = "upper(street) like '%" + ls_filter + "%'"  
		ls_filter = "upper(street) like '%" + ls_filter + "%'"
	elseif rb_pho.checked = true then 	
		ls_filter = "group_practice.phone like '%" + ls_filter + "%'"
	elseif rb_tin.checked = true then 	
		ls_filter = "upper(tax_id) like '%" + ls_filter + "%'"
	elseif rb_street.checked = true then 	
		ls_filter = "upper(street_2) like '%" + ls_filter + "%'"
	elseif rb_city.checked = true then 	
		ls_filter = "upper(city) like '%" + ls_filter + "%'"
	elseif rb_id.checked = true then 	
		ls_filter = "group_practice.rec_id  = " + ls_filter + ""	
	elseif rb_suite.checked = true then 	
		ls_filter = "upper(suite_apart) like '%" + ls_filter + "%'"
	elseif rb_state.checked = true then 	
		ls_filter = "upper(code_lookup_b.code) = '" + ls_filter + "'"
	
	else //group name
		ls_filter = "upper(gp_name) like '%" + ls_filter + "%'" //alfee 12.12.2008
		//ls_filter = "gp_name like '%" + ls_filter + "%'"
	end if
	
	ls_filter = " AND " + ls_filter
	
	//ls_sql_org = dw_1.getsqlselect( )//Commented by (Appeon)Stephen 11.02.2017 - Alpha id 5868 - Find Addresses Search Error  C/S 15.406 10202017, SaaS 
	
	ls_sql = ls_sql_org + ls_filter
		//openwithparm(w_sql_msg, ls_sql)
	dw_1.setsqlselect(ls_sql)	
end if


dw_1.settransobject(sqlca)
dw_1.retrieve()

dw_1.setsqlselect(ls_sql_org)


return 1
end function

public function string of_replace (string arg_str, string arg_old, string arg_new);//====================================================================
//$<Function>: of_replace
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Stephen 11.02.2017 (Alpha id 5868 - Find Addresses Search Error  C/S 15.406 10202017, SaaS )
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long start_pos = 1
string ls_return
// Find the first occurrence of old_str.

start_pos = PosA(arg_str, arg_old, start_pos)

// Only enter the loop if you find old_str.

DO WHILE start_pos > 0
	
	// Replace old_str with new_str.
	
	arg_str = ReplaceA(arg_str, start_pos, LenA(arg_old), arg_new)
	
	// Find the next occurrence of old_str.
	
	start_pos = PosA(arg_str, arg_old, start_pos+LenA(arg_new))
	
LOOP

return arg_str
end function

on w_practice_to_addr_find_new.create
this.rb_state=create rb_state
this.rb_suite=create rb_suite
this.rb_id=create rb_id
this.rb_city=create rb_city
this.rb_street=create rb_street
this.rb_tin=create rb_tin
this.cb_add_loc=create cb_add_loc
this.rb_up=create rb_up
this.rb_add=create rb_add
this.rb_parent_name=create rb_parent_name
this.rb_pho=create rb_pho
this.rb_addr=create rb_addr
this.cb_3=create cb_3
this.cb_populate=create cb_populate
this.dw_1=create dw_1
this.cb_filter=create cb_filter
this.sle_1=create sle_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.rb_state,&
this.rb_suite,&
this.rb_id,&
this.rb_city,&
this.rb_street,&
this.rb_tin,&
this.cb_add_loc,&
this.rb_up,&
this.rb_add,&
this.rb_parent_name,&
this.rb_pho,&
this.rb_addr,&
this.cb_3,&
this.cb_populate,&
this.dw_1,&
this.cb_filter,&
this.sle_1,&
this.gb_1,&
this.gb_2}
end on

on w_practice_to_addr_find_new.destroy
destroy(this.rb_state)
destroy(this.rb_suite)
destroy(this.rb_id)
destroy(this.rb_city)
destroy(this.rb_street)
destroy(this.rb_tin)
destroy(this.cb_add_loc)
destroy(this.rb_up)
destroy(this.rb_add)
destroy(this.rb_parent_name)
destroy(this.rb_pho)
destroy(this.rb_addr)
destroy(this.cb_3)
destroy(this.cb_populate)
destroy(this.dw_1)
destroy(this.cb_filter)
destroy(this.sle_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;integer li_single  //maha 10.12.2017

//Start Code Change ----10.12.2017 #V154 maha
li_single = of_get_app_setting("set_70","I")
if li_single = 1 then //search not retrieve
	cb_filter.text = "Search" 
end if
//End Code Change ----10.12.2017

if w_mdi.of_security_access(1320) < 2 then
	cb_add_loc.visible = false
end if

//Start Code Change ----07.11.2016 #V152 maha
if w_mdi.of_security_access(7826) = 0 then
	rb_up.visible = false
end if
//End Code Change ----07.11.2016

//Start Code Change ----04.28.2014 #V14.2 maha- when used from templates
if message.stringparm = "TEMPLATE" then
	cb_add_loc.visible = false
	rb_add.visible = false
	rb_up.visible = false
	gb_1.visible = false
	cb_populate.text = "Select"
end if
//End Code Change ----04.28.2014
	
//Start Code Change ----10.12.2017 #V154 maha	
if li_single = 1 then
	//skip retrieve
else
	dw_1.retrieve()
end if
//End Code Change ----10.12.2017


end event

event closequery;if ii_close = 0 then
	messagebox("Close","Click Cancel to close")
	return 1
end if
end event

type rb_state from radiobutton within w_practice_to_addr_find_new
integer x = 1504
integer y = 240
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
string text = "State"
end type

event clicked;sle_1.setfocus( )
end event

type rb_suite from radiobutton within w_practice_to_addr_find_new
integer x = 1737
integer y = 172
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

type rb_id from radiobutton within w_practice_to_addr_find_new
integer x = 503
integer y = 240
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

type rb_city from radiobutton within w_practice_to_addr_find_new
integer x = 1504
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

type rb_street from radiobutton within w_practice_to_addr_find_new
integer x = 1207
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

type rb_tin from radiobutton within w_practice_to_addr_find_new
integer x = 1207
integer y = 240
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

type cb_add_loc from commandbutton within w_practice_to_addr_find_new
integer x = 1527
integer y = 16
integer width = 475
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add &New Location"
end type

event clicked;//Integer li_rc
long ll_rc
Integer i
string ls_ret

openwithparm(w_group_add, 0)  //Start Code Change ----08.17.2016 #V152 maha - modified to include parameter

ls_ret = message.stringparm

if ls_ret = "Cancel" then
	return
else
	//------------------- APPEON BEGIN -------------------
	//$<modify> Evan 09.26.2011
	//$<reason> Extend return values
	//li_rc = long(ls_ret)	
	string ls_Arg[]
	n_cst_string lnv_string
	lnv_string.of_ParseToArray(ls_ret, '|', ls_Arg[])
	if UpperBound(ls_Arg) > 1 then ll_rc = long(ls_Arg[2])
	//------------------- APPEON END ---------------------
	
	dw_1.retrieve()
//	i = dw_1.find( "rec_id = " + ls_ret, 1, dw_1.rowcount())
	i = dw_1.find( "rec_id = " + String(ll_rc), 1, dw_1.rowcount())	//long.zhang 12.14.2011
	if i > 0 then
		dw_1.setitem(i,"selected",1)
		dw_1.scrolltorow(i)
	end if
end if


end event

type rb_up from radiobutton within w_practice_to_addr_find_new
integer x = 2519
integer y = 192
integer width = 640
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update Existing Record"
end type

event clicked;gi_temp_switch = 1
end event

type rb_add from radiobutton within w_practice_to_addr_find_new
integer x = 2112
integer y = 196
integer width = 366
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add as New"
boolean checked = true
end type

event clicked;gi_temp_switch = 0
end event

type rb_parent_name from radiobutton within w_practice_to_addr_find_new
integer x = 69
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

type rb_pho from radiobutton within w_practice_to_addr_find_new
integer x = 69
integer y = 240
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

type rb_addr from radiobutton within w_practice_to_addr_find_new
integer x = 503
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

type cb_3 from commandbutton within w_practice_to_addr_find_new
integer x = 2944
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

event clicked;gs_pass_ids ids

ids.l_ids[1] = 0
ii_close = 1
CloseWithReturn(Parent, ids)
end event

type cb_populate from commandbutton within w_practice_to_addr_find_new
integer x = 2071
integer y = 16
integer width = 507
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Populate Address"
boolean default = true
end type

event clicked;Integer li_Rc
Integer i


dw_1.AcceptText()

dw_1.SetFilter( "selected = 1" ) 
dw_1.Filter()

li_rc = dw_1.RowCount( )

IF li_rc = 0 THEN
	MessageBox( "Nothing Selected", "You must select at least one address to populate." )
	dw_1.SetFilter( "" ) 
	dw_1.Filter()
	Return
END IF

gs_pass_ids ids

FOR i = 1 TO li_rc
	ids.l_ids[ i ]  = dw_1.GetItemNumber( i, "rec_id" )
END FOR

message.doubleparm = 1
ii_close = 1
CloseWithReturn( Parent, ids )

debugbreak()
end event

type dw_1 from datawindow within w_practice_to_addr_find_new
integer x = 14
integer y = 360
integer width = 3177
integer height = 1960
integer taborder = 60
string dataobject = "d_group_prac_search_new"
boolean vscrollbar = true
end type

event clicked;Integer li_row

li_row = this.getclickedrow()

dw_1.setrow(li_row)
dw_1.selectrow(0,false)
dw_1.selectrow(li_row,true)
//
//il_addr_id = dw_1.getitemnumber(li_row,"rec_id")



end event

event doubleclicked;cb_populate.TriggerEvent( Clicked! )

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

type cb_filter from commandbutton within w_practice_to_addr_find_new
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

//Start Code Change ----10.12.2017 #V154 maha
if this.text = "Search" then
	of_search_groups(ls_filter)
	return
end if
//End Code Change ----10.12.2017

if ls_filter = "" then 
	ls_filter = ""
else
	 //Start Code Change ----10.19.2015 #V15 maha - modified for apostrophie
	 ls_filter = of_replace(ls_filter,"'","~~'") //(Appeon)Stephen 11.02.2017 - Alpha id 5868 - Find Addresses Search Error  C/S 15.406 10202017, SaaS 
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
	elseif rb_state.checked = true then 	
		ls_filter = "upper(state_code) = '" + ls_filter + "'"
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

type sle_1 from singlelineedit within w_practice_to_addr_find_new
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

type gb_1 from groupbox within w_practice_to_addr_find_new
integer x = 2071
integer y = 112
integer width = 1106
integer height = 216
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Populate Action"
end type

type gb_2 from groupbox within w_practice_to_addr_find_new
integer x = 32
integer y = 112
integer width = 1966
integer height = 216
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

