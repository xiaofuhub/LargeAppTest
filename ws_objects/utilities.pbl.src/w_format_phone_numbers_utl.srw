$PBExportHeader$w_format_phone_numbers_utl.srw
forward
global type w_format_phone_numbers_utl from window
end type
type sle_char from singlelineedit within w_format_phone_numbers_utl
end type
type rb_strip from radiobutton within w_format_phone_numbers_utl
end type
type st_error from statictext within w_format_phone_numbers_utl
end type
type cb_save from commandbutton within w_format_phone_numbers_utl
end type
type rb_addr from radiobutton within w_format_phone_numbers_utl
end type
type rb_prac from radiobutton within w_format_phone_numbers_utl
end type
type st_1 from statictext within w_format_phone_numbers_utl
end type
type rb_num from radiobutton within w_format_phone_numbers_utl
end type
type rb_form from radiobutton within w_format_phone_numbers_utl
end type
type dw_1 from datawindow within w_format_phone_numbers_utl
end type
type cb_2 from commandbutton within w_format_phone_numbers_utl
end type
type cb_run from commandbutton within w_format_phone_numbers_utl
end type
type gb_1 from groupbox within w_format_phone_numbers_utl
end type
type gb_3 from groupbox within w_format_phone_numbers_utl
end type
type dw_table from datawindow within w_format_phone_numbers_utl
end type
type dw_field from datawindow within w_format_phone_numbers_utl
end type
type gb_prac from groupbox within w_format_phone_numbers_utl
end type
type gb_addr from groupbox within w_format_phone_numbers_utl
end type
type rb_phone from radiobutton within w_format_phone_numbers_utl
end type
type rb_fax from radiobutton within w_format_phone_numbers_utl
end type
end forward

global type w_format_phone_numbers_utl from window
integer width = 1394
integer height = 2900
boolean titlebar = true
string title = "Phone Numbers Formating"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
sle_char sle_char
rb_strip rb_strip
st_error st_error
cb_save cb_save
rb_addr rb_addr
rb_prac rb_prac
st_1 st_1
rb_num rb_num
rb_form rb_form
dw_1 dw_1
cb_2 cb_2
cb_run cb_run
gb_1 gb_1
gb_3 gb_3
dw_table dw_table
dw_field dw_field
gb_prac gb_prac
gb_addr gb_addr
rb_phone rb_phone
rb_fax rb_fax
end type
global w_format_phone_numbers_utl w_format_phone_numbers_utl

type variables
string is_table
string is_field
n_ds ids_prac_list
end variables

on w_format_phone_numbers_utl.create
this.sle_char=create sle_char
this.rb_strip=create rb_strip
this.st_error=create st_error
this.cb_save=create cb_save
this.rb_addr=create rb_addr
this.rb_prac=create rb_prac
this.st_1=create st_1
this.rb_num=create rb_num
this.rb_form=create rb_form
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_run=create cb_run
this.gb_1=create gb_1
this.gb_3=create gb_3
this.dw_table=create dw_table
this.dw_field=create dw_field
this.gb_prac=create gb_prac
this.gb_addr=create gb_addr
this.rb_phone=create rb_phone
this.rb_fax=create rb_fax
this.Control[]={this.sle_char,&
this.rb_strip,&
this.st_error,&
this.cb_save,&
this.rb_addr,&
this.rb_prac,&
this.st_1,&
this.rb_num,&
this.rb_form,&
this.dw_1,&
this.cb_2,&
this.cb_run,&
this.gb_1,&
this.gb_3,&
this.dw_table,&
this.dw_field,&
this.gb_prac,&
this.gb_addr,&
this.rb_phone,&
this.rb_fax}
end on

on w_format_phone_numbers_utl.destroy
destroy(this.sle_char)
destroy(this.rb_strip)
destroy(this.st_error)
destroy(this.cb_save)
destroy(this.rb_addr)
destroy(this.rb_prac)
destroy(this.st_1)
destroy(this.rb_num)
destroy(this.rb_form)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_run)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.dw_table)
destroy(this.dw_field)
destroy(this.gb_prac)
destroy(this.gb_addr)
destroy(this.rb_phone)
destroy(this.rb_fax)
end on

event open;dw_1.settransobject(sqlca)
//dw_1.retrieve()
ids_prac_list = CREATE n_ds
end event

event close;destroy ids_prac_list
end event

type sle_char from singlelineedit within w_format_phone_numbers_utl
integer x = 1006
integer y = 616
integer width = 142
integer height = 68
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type rb_strip from radiobutton within w_format_phone_numbers_utl
integer x = 896
integer y = 688
integer width = 439
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Strip Character"
end type

type st_error from statictext within w_format_phone_numbers_utl
boolean visible = false
integer x = 59
integer y = 844
integer width = 1262
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
string text = "The selected field must be of character data type!"
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_format_phone_numbers_utl
integer x = 640
integer y = 16
integer width = 343
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;ids_prac_list.update()
end event

type rb_addr from radiobutton within w_format_phone_numbers_utl
integer x = 686
integer y = 204
integer width = 539
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Address Lookup"
end type

event clicked;gb_addr.bringtotop = true
rb_phone.bringtotop = true
rb_fax.bringtotop = true
dw_1.reset()

//Start Code Change ----09.18.2012 #V12 maha
//st_recid.text = "lookup_code"
//st_pracid.text = "lookup_code"
//st_field.text = "field"
dw_1.Modify("rec_id_t.text = 'Lookup Code'")
dw_1.Modify("prac_id_t.text = 'Lookup Code'")
dw_1.Modify("number_t.text = 'Field'")
//End Code Change ----09.18.2012


//string ls_select
//integer res
//
//ls_select = "select rec_id, prac_id, " + is_field + " from " + is_table + " where "  + is_field +  " is not null;" 
////debugbreak()
////messagebox("",ls_select)
////sleep(2)
////dw_1.Modify("DataWindow.Table.Select='select...'")
//res = dw_1.setsqlselect( ls_select)
////messagebox("set select",res)
// dw_1.settransobject(sqlca)
//
//if res = 1 then
//	dw_1.retrieve()
//end if
end event

type rb_prac from radiobutton within w_format_phone_numbers_utl
integer x = 128
integer y = 204
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Provider Data"
boolean checked = true
end type

event clicked;gb_prac.bringtotop = true
dw_field.bringtotop = true
dw_table.bringtotop = true

//st_recid.text = "rec_id"
//st_pracid.text = "prac_id"
//st_field.text = "field"
//Start Code Change ----09.18.2012 #V12 maha
dw_1.Modify("rec_id_t.text = 'Rec id'")
dw_1.Modify("prac_id_t.text = 'Prac Id'")
dw_1.Modify("number_t.text = 'Number'")
//End Code Change ----09.18.2012

dw_1.reset()

end event

type st_1 from statictext within w_format_phone_numbers_utl
integer x = 453
integer y = 616
integer width = 421
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Strip to Numbers"
boolean focusrectangle = false
end type

type rb_num from radiobutton within w_format_phone_numbers_utl
integer x = 462
integer y = 688
integer width = 393
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "1234567890"
end type

type rb_form from radiobutton within w_format_phone_numbers_utl
integer x = 37
integer y = 684
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "(123) 456-7890"
boolean checked = true
end type

type dw_1 from datawindow within w_format_phone_numbers_utl
integer x = 23
integer y = 912
integer width = 1326
integer height = 1880
integer taborder = 10
string title = "none"
string dataobject = "d_fix_fax_fubar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_format_phone_numbers_utl
integer x = 1001
integer y = 16
integer width = 343
integer height = 88
integer taborder = 20
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

type cb_run from commandbutton within w_format_phone_numbers_utl
integer x = 274
integer y = 16
integer width = 343
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;integer res

long i
integer skip
integer w
long ic
string sf
string ls_fax 
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_sql
string c


 //res = 	messagebox("About","This utility will standardize All existing records for the selected data field to the selected format.~r~rDo you wish to continue?",Question!,yesno!,1)
//if res = 2 then return
//Start Code Change ----04.16.2014 #V14.2 maha
if rb_strip.checked then
	c = sle_char.text
	if len(c) < 1 then
		messagebox("Strip Character Function","The Strip Character option has been selected but no character to strip has been entered.")
		return
	end if
end if
//End Code Change ----04.16.2014
//Start Code Change ----04.30.2009 #V92 maha - added address lookup functionality


if rb_prac.checked then
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 11.20.2014
	//<$>reason:BugL100801 of IntelliCredApp V14.2 History Issues.doc
	if trim(is_field) = '' or trim(is_table) = '' then 
		messagebox("","Please select Table and Field.")
		return
	end if
	//------------------- APPEON END -------------------
	
	ls_sql = "select rec_id, prac_id, " + is_field + " from " + is_table + " where "  + is_field +  " is not null;" 
//messagebox("is_sql",is_sql)
else //address lookup
	if rb_phone.checked then
		ls_sql = "select lookup_code, lookup_code ,phone from address_lookup where phone is not null;" 
	elseif rb_fax.checked then
		ls_sql = "select lookup_code, lookup_code, fax from  address_lookup where fax is not null;" 
	end if
end if
//End Code Change---04.30.2009

ls_presentation_str = "style(type=grid)"		
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution on export field " + ls_sql, &
	"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
	//	MessageBox("ls_select_table",ls_select_table)
	RETURN -1
END IF
//lds_prac_list = CREATE n_ds
w = ids_prac_list.Create( ls_dwsyntax_str, ERRORS)

if w < 1 then
	messagebox("error on create",errors)
end if

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.22.2009
//$<reason> Use settrans method is incorrect.
//ids_prac_list.settrans( sqlca)
ids_prac_list.SetTransObject(SQLCA)
//------------------- APPEON END ---------------------

ic = ids_prac_list.retrieve()

//MessageBox("field",ls_sql)
ic = ids_prac_list.rowcount()

if ic = 0 then
	messagebox("No Data",ls_sql)
	return
end if
	
//debugbreak()
//Start Code Change ----04.16.2014 #V14.2 maha - recoded fpr strip function
for i = 1 to ic
	skip = 0
	ls_fax = ids_prac_list.getitemstring(i,3)
	sf = ls_fax
	
	
	
	if rb_form.checked then
		sf =  of_strip_char("", sf,"@NUM@")
		if LenA(sf ) = 10 then
			sf = "(" + MidA(sf,1,3) + ") " + MidA(sf,4,3) + "-" + MidA(sf,7) 
		elseif LenA(sf) = 7 then
			sf = MidA(sf,1,3) + "-" + MidA(sf,4) 
		else
			if LenA( ls_fax) < 14 then
				skip = 1
			else
				skip = 0
			end if
		end if
	elseif rb_num.checked then
		sf =  of_strip_char("", sf,"@NUM@")
	elseif rb_strip.checked then  //Start Code Change ----04.15.2014 #V14.2 maha
		sf =  of_strip_char( c, sf,'')
	end if
		
	if skip = 0 then ids_prac_list.setitem(i,3,sf)
next

//ids_prac_list.update()


//Note: this section of code is for appearance purposes only and duplicates the workof the data store
//the modified base query continues to only update the address fax number
dw_1.accepttext( )
ic = dw_1.rowcount()
//debugbreak()
for i = 1 to ic
	skip = 0
	ls_fax = dw_1.getitemstring(i,3)
	sf = ls_fax
	
	
	if rb_form.checked then
		sf =  of_strip_char("", sf,"@NUM@")
		if LenA(sf ) = 10 then
			sf = "(" + MidA(sf,1,3) + ") " + MidA(sf,4,3) + "-" + MidA(sf,7) 
		elseif LenA(sf) = 7 then
			sf = MidA(sf,1,3) + "-" + MidA(sf,4) 
		else
			if LenA( ls_fax) < 14 then
				skip = 1
			else
				skip = 0
			end if
		end if
	elseif rb_num.checked then
		sf =  of_strip_char("", sf,"@NUM@")
	elseif rb_strip.checked then  //Start Code Change ----04.15.2014 #V14.2 maha
		sf =  of_strip_char( c, sf,'')
	end if
	
	if skip = 0 then dw_1.setitem(i,3,sf)
next
//End Code Change ----04.16.2014
//dw_1.update()

messagebox("Formating completed","Click save to save changes.")




end event

type gb_1 from groupbox within w_format_phone_numbers_utl
integer x = 32
integer y = 612
integer width = 1312
integer height = 176
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Format"
end type

type gb_3 from groupbox within w_format_phone_numbers_utl
integer x = 41
integer y = 136
integer width = 1312
integer height = 168
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Data Type"
end type

type dw_table from datawindow within w_format_phone_numbers_utl
integer x = 119
integer y = 380
integer width = 1070
integer height = 80
integer taborder = 30
string title = "none"
string dataobject = "d_table_list_get_name"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_table = data
integer res
string s
//dw_field.retrieve(is_table)
//debugbreak()
DataWindowChild dwchild

res = dw_field.GetChild( "sys_fields_field_name", dwchild )
s = "sys_tables_table_name = '" + is_table + "'"
res = dwchild.setfilter(s)
res = dwchild.filter()

end event

event constructor;this.settransobject( sqlca)
this.retrieve()
this.insertrow(1)
end event

type dw_field from datawindow within w_format_phone_numbers_utl
integer x = 123
integer y = 476
integer width = 1019
integer height = 92
integer taborder = 30
string title = "none"
string dataobject = "d_sys_field_list_dropdown"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_field = data

string ls_select
integer res

st_error.visible = false
ls_select = "select rec_id, prac_id, " + is_field + " from " + is_table + " where "  + is_field +  " is not null;" 
//debugbreak()
//messagebox("",ls_select)
//sleep(2)
//dw_1.Modify("DataWindow.Table.Select='select...'")
res = dw_1.setsqlselect( ls_select)
if res < 1 then st_error.visible = true
//messagebox("set select",res)
 dw_1.settransobject(sqlca)

if res = 1 then
	dw_1.retrieve()
end if

//dw_1.object.table.UpdateTable = "' +is_table'"
//dw_1.Modify("DataWindow.Table.updatetable='" + is_table + "'")

//string ls_presentation_str
//string ls_dwsyntax_str
//string ERRORS
//
////	is_sql  = is_sql + ";"
////messagebox("is_sql",is_sql)
//
//		
//ls_presentation_str = "style(type=grid)"		
//
//ls_dwsyntax_str = SQLCA.SyntaxFromSQL( ls_select , ls_presentation_str, ERRORS)
//IF Len(ERRORS) > 0 THEN
//	MessageBox("Caution on export field " + is_sql, &
//	"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + is_sql)
//		//	MessageBox("ls_select_table",ls_select_table)
//			
//	RETURN -1
//END IF
//
//lds_prac_list = CREATE n_ds
//w = lds_prac_list.Create( ls_dwsyntax_str, ERRORS)
//if w < 1 then
// messagebox("error on create",errors)
end event

event constructor;this.settransobject( sqlca)
this.retrieve()
this.insertrow(1)
end event

type gb_prac from groupbox within w_format_phone_numbers_utl
integer x = 37
integer y = 312
integer width = 1312
integer height = 296
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Table and Field"
end type

type gb_addr from groupbox within w_format_phone_numbers_utl
integer x = 37
integer y = 312
integer width = 1312
integer height = 296
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Table and Field"
end type

type rb_phone from radiobutton within w_format_phone_numbers_utl
integer x = 165
integer y = 436
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Phone"
end type

event clicked;string ls_select
integer res

if rb_phone.checked then
		ls_select = "select lookup_code, lookup_code ,phone from address_lookup where phone is not null;" 
elseif rb_fax.checked then
		ls_select = "select lookup_code, lookup_code, fax from  address_lookup where fax is not null;" 
end if

res = dw_1.setsqlselect( ls_select)
//messagebox("set select",res)
 dw_1.settransobject(sqlca)

if res = 1 then
	dw_1.retrieve()
end if
end event

type rb_fax from radiobutton within w_format_phone_numbers_utl
integer x = 658
integer y = 436
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Fax"
end type

event clicked;string ls_select
integer res

if rb_phone.checked then
		ls_select = "select lookup_code, lookup_code ,phone from address_lookup where phone is not null;" 
elseif rb_fax.checked then
		ls_select = "select lookup_code, lookup_code, fax from  address_lookup where fax is not null;" 
end if

res = dw_1.setsqlselect( ls_select)
//messagebox("set select",res)
 dw_1.settransobject(sqlca)

if res = 1 then
	dw_1.retrieve()
end if
end event

