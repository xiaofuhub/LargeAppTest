$PBExportHeader$w_practice_to_addr_find.srw
forward
global type w_practice_to_addr_find from window
end type
type rb_id from radiobutton within w_practice_to_addr_find
end type
type rb_tin from radiobutton within w_practice_to_addr_find
end type
type rb_street from radiobutton within w_practice_to_addr_find
end type
type rb_suite from radiobutton within w_practice_to_addr_find
end type
type rb_pho from radiobutton within w_practice_to_addr_find
end type
type rb_addr from radiobutton within w_practice_to_addr_find
end type
type cb_3 from commandbutton within w_practice_to_addr_find
end type
type cb_2 from commandbutton within w_practice_to_addr_find
end type
type dw_1 from datawindow within w_practice_to_addr_find
end type
type cb_1 from commandbutton within w_practice_to_addr_find
end type
type sle_1 from singlelineedit within w_practice_to_addr_find
end type
type gb_1 from groupbox within w_practice_to_addr_find
end type
end forward

global type w_practice_to_addr_find from window
integer x = 887
integer y = 524
integer width = 4343
integer height = 2204
boolean titlebar = true
string title = "Find Practice"
windowtype windowtype = response!
long backcolor = 33551856
rb_id rb_id
rb_tin rb_tin
rb_street rb_street
rb_suite rb_suite
rb_pho rb_pho
rb_addr rb_addr
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
sle_1 sle_1
gb_1 gb_1
end type
global w_practice_to_addr_find w_practice_to_addr_find

type variables
long il_addr_id
string is_from   //maha 07.24.2017
end variables

forward prototypes
public function string of_replace (string arg_str, string arg_old, string arg_new)
end prototypes

public function string of_replace (string arg_str, string arg_old, string arg_new);//====================================================================
//$<Function>: of_replace
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Stephen 11.02.2017 (Alpha id 5867 - Groups 'Link Existing' Filter Search Error  SaaS build 15.4 Build 10242017, C/S 15.406 Build 10202017)
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

on w_practice_to_addr_find.create
this.rb_id=create rb_id
this.rb_tin=create rb_tin
this.rb_street=create rb_street
this.rb_suite=create rb_suite
this.rb_pho=create rb_pho
this.rb_addr=create rb_addr
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.gb_1=create gb_1
this.Control[]={this.rb_id,&
this.rb_tin,&
this.rb_street,&
this.rb_suite,&
this.rb_pho,&
this.rb_addr,&
this.cb_3,&
this.cb_2,&
this.dw_1,&
this.cb_1,&
this.sle_1,&
this.gb_1}
end on

on w_practice_to_addr_find.destroy
destroy(this.rb_id)
destroy(this.rb_tin)
destroy(this.rb_street)
destroy(this.rb_suite)
destroy(this.rb_pho)
destroy(this.rb_addr)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.gb_1)
end on

event open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.13.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product

//Start Code Change ----07.24.2017 #V154 maha
is_from = message.stringparm

if is_from = "LINK" then
	dw_1.dataobject = "d_group_prac_search_multi"
else
	dw_1.dataobject = "d_group_prac_search"
end if

dw_1.settransobject(sqlca)
//End Code Change ----07.24.2017



if gb_contract_version then  //Start Code Change ----06.04.2012 #V12 maha - added if for only Contract version
	rb_addr.text = "Filter by Location Name"
	dw_1.Modify("practice_type_t.text='Location Name'")
end if
//---------------------------- APPEON END ----------------------------

dw_1.retrieve()
end event

type rb_id from radiobutton within w_practice_to_addr_find
integer x = 1879
integer y = 76
integer width = 160
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "ID"
end type

type rb_tin from radiobutton within w_practice_to_addr_find
integer x = 1664
integer y = 68
integer width = 201
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

type rb_street from radiobutton within w_practice_to_addr_find
integer x = 535
integer y = 68
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Street 2"
end type

event clicked;sle_1.setfocus( )
end event

type rb_suite from radiobutton within w_practice_to_addr_find
integer x = 878
integer y = 68
integer width = 471
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Suite Apartment"
end type

event clicked;sle_1.setfocus( )
end event

type rb_pho from radiobutton within w_practice_to_addr_find
integer x = 1399
integer y = 68
integer width = 238
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Phone"
end type

event clicked;sle_1.setfocus( )
end event

type rb_addr from radiobutton within w_practice_to_addr_find
integer x = 55
integer y = 68
integer width = 443
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Practice Name"
boolean checked = true
end type

event clicked;sle_1.setfocus( )
end event

type cb_3 from commandbutton within w_practice_to_addr_find
integer x = 4064
integer y = 56
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
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type cb_2 from commandbutton within w_practice_to_addr_find
integer x = 3790
integer y = 56
integer width = 265
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Populate"
end type

event clicked;
//Start Code Change ----07.24.2017 #V154 maha - added code for multi-select
long r
integer s
gs_pass_ids lds_ids

if is_from = "LINK" then
	for r = 1 to dw_1.rowcount()
		if dw_1.getitemnumber(r, "selected") = 1 then
			lds_ids.l_ids[upperbound(lds_ids.l_ids) + 1] = dw_1.getitemnumber(r, "rec_id")
		end if
	next
	
	if upperbound(lds_ids.l_ids) = 0 then
		messagebox("Populate","No Locations selected")
		return
	else
		CloseWithReturn(Parent, lds_ids)
	end if
else
	CloseWithReturn(Parent, il_addr_id)
end if
//End Code Change ----07.24.2017
end event

type dw_1 from datawindow within w_practice_to_addr_find
integer y = 192
integer width = 4329
integer height = 1928
integer taborder = 30
string dataobject = "d_group_prac_search_multi"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;integer li_row

li_row = this.getclickedrow()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.13.2006 By: LeiWei
//$<reason> Fix a defect.
IF li_row = 0 THEN RETURN
//---------------------------- APPEON END ----------------------------


dw_1.setrow(li_row)
dw_1.selectrow(0,false)
dw_1.selectrow(li_row,true)

il_addr_id = dw_1.getitemnumber(li_row,"rec_id")
end event

event doubleclicked;//Start Code Change ----07.24.2017 #V154 maha - added trap for from link
if is_from = "LINK" then
	return
else
	closewithreturn(parent,il_addr_id)
end if
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

event buttonclicked;//Start Code Change ----07.24.2017 #V154 maha
long r
integer i
string t

if dwo.name = "b_select" then
	if dwo.text = "Select All" then
		i = 1
		t = "Deselect All"
	else
		i = 0
		t = "Select All"
	end if
	
	for r = 1 to dw_1.rowcount()
		dw_1.setitem(r, "selected", i)
	next
	
	dwo.text = t
end if
	
end event

type cb_1 from commandbutton within w_practice_to_addr_find
integer x = 3534
integer y = 56
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
boolean default = true
end type

event clicked;String 	ls_filter = ""

if IsNull(sle_1.text) then return

ls_filter = Upper(sle_1.text)

if ls_filter = "" then 
	ls_filter = ""
else
	ls_filter = of_replace(ls_filter,"'","~~'") //(Appeon)Stephen 11.02.2017 - Alpha id 5867 - Groups 'Link Existing' Filter Search Error  SaaS build 15.4 Build 10242017, C/S 15.406 Build 10202017
	if rb_addr.checked = true then 
		ls_filter = "upper(group_street) like '%" + ls_filter + "%'"
	elseif rb_street.checked = true then 	
		ls_filter = "upper(street_2) like '%" + ls_filter + "%' "
	elseif rb_suite.checked = true then 	
		ls_filter = "upper(suite_apart) like '%" + ls_filter + "%'"
	elseif rb_tin.checked = true then 	
		ls_filter = "upper(tax_id) like '%" + ls_filter + "%'"	
	elseif rb_pho.checked = true then 	
		ls_filter = "phone like '%" + ls_filter + "%'"
	elseif rb_id.checked = true then 	
		ls_filter = "rec_id = " + ls_filter
	end if
end if

	
dw_1.setfilter(ls_filter)  
dw_1.filter()

sle_1.SetFocus()

end event

type sle_1 from singlelineedit within w_practice_to_addr_find
integer x = 2263
integer y = 52
integer width = 1266
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

type gb_1 from groupbox within w_practice_to_addr_find
integer x = 9
integer width = 2048
integer height = 176
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filter By:"
end type

