$PBExportHeader$w_database_field_verify.srw
forward
global type w_database_field_verify from window
end type
type cb_correct_help from commandbutton within w_database_field_verify
end type
type cbx_correct from checkbox within w_database_field_verify
end type
type cb_test from commandbutton within w_database_field_verify
end type
type cb_ok from commandbutton within w_database_field_verify
end type
type dw_1 from datawindow within w_database_field_verify
end type
type cb_quit from commandbutton within w_database_field_verify
end type
end forward

global type w_database_field_verify from window
integer width = 3534
integer height = 2356
boolean titlebar = true
string title = "Verify Table Fields"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_correct_help cb_correct_help
cbx_correct cbx_correct
cb_test cb_test
cb_ok cb_ok
dw_1 dw_1
cb_quit cb_quit
end type
global w_database_field_verify w_database_field_verify

type variables
string is_errors
string is_mess_all
integer ii_cnt
boolean ib_IsOK = false //Add by Evan on 04/25/2008
end variables

forward prototypes
public function integer of_verify_field_name ()
public function integer of_check_4_dupes (integer ai_row, string as_name)
public function integer of_message (integer ai_row, string as_mess)
end prototypes

public function integer of_verify_field_name ();//Start Code Change ----12.18.2007 #V8 maha -- new function
boolean lb_correct
integer i
integer li_dup

string ls_field
string ls_mess1

is_mess_all = ""
ii_cnt = 0

if cbx_correct.checked then lb_correct = true


for i = 1 to dw_1.rowcount()
	ls_field = dw_1.getitemstring(i,"application_name")
	 dw_1.setitem(i,"org_field", ls_field)
	//test length 3 to 40
	if LenA(ls_field) < 3 or LenA(ls_field) > 40 then
		if lb_correct = true then 
			choose case LenA(ls_field)
				case 1
					ls_field+= "XX"
				case 2
					ls_field+= "X"
			end choose
			if LenA(ls_field) > 40 then
				debugbreak()
				ls_field = MidA(ls_field,1,40)
			end if
		else
			ls_mess1 = "Field " + string(i) + " ( " + ls_field + " )  has an invalid length.  Must be between 3 an 40 characters"
			of_message( i, ls_mess1)
		end if
	end if
	//test for bad characters
	//if i = 7 then debugbreak()
	if lb_correct then
		ls_mess1 = of_strip_char ("@Y@",ls_field,"@DBFIELD@") //will do auto corrections
	else
		ls_mess1 = of_strip_char ("",ls_field,"@DBFIELD@") //trap errors only
	end if
	if ls_mess1 = "FAILS" then
		if lb_correct then 
			dw_1.setitem(i,"application_name","field_" + string(i))
		else
			ls_mess1 = "Field " + string(i) + " ( " + ls_field + " )  is an invalid field name.  It must contain only letters, numbers or underscores, and cannot start with a number."
			of_message( i, ls_mess1)
		end if
	elseif ls_mess1 = "" then
		if lb_correct then 
			dw_1.setitem(i,"application_name","field_" + string(i))
		else
			ls_mess1 = "Field " + string(i) + " ( " + ls_field + " )  came back blank."
			of_message( i, ls_mess1)
		end if
	else
		dw_1.setitem(i,"application_name",ls_mess1)
		
	end if
	
	//Start Code Change ----08.14.2013 #V14 maha - test for key words
	choose case lower(ls_field)
		case 'select', 'from', 'to', 'where', 'group', 'having', 'by', 'create', 'drop',  'table', 'field', 'key', 'primary', 'first', 'before', 'current_date', 'procedure','begin', 'end'
			if lb_correct then
				dw_1.setitem(i,"application_name",ls_field + "_x")
			else
				ls_mess1 = "Field " + string(i) + " ( " + ls_field + " )  is a protected database word.  See field #" + string(li_dup)
				of_message( i, ls_mess1)
			end if
		case else
			//ok
	end choose
	//End Code Change ----08.14.2013 
	
	ls_field = dw_1.getitemstring(i,"application_name") //re-get ls_field after above modifications
	//check for duplicates
	li_dup = of_check_4_dupes(i,ls_field)
	if li_dup > 0 then
		if lb_correct then
			dw_1.setitem(i,"application_name",ls_field + string(i))
		else
			ls_mess1 = "Field " + string(i) + " ( " + ls_field + " )  has a duplicate field name.  See field #" + string(li_dup)
			of_message( i, ls_mess1)
		end if
	end if
next

is_errors = is_mess_all
			
return ii_cnt
	
end function

public function integer of_check_4_dupes (integer ai_row, string as_name);integer i
integer ret
string ls_field

dw_1.accepttext( )

for i = 1 to dw_1.rowcount()
	choose case i
		case ai_row
			//no test
		case else
			if dw_1.getitemstring(i,"application_name") = as_name then
				ret = i
				exit
			end if
	end choose
next

return ret
			
end function

public function integer of_message (integer ai_row, string as_mess);string ls_mess


ls_mess = as_mess

if LenA(is_mess_all) > 0 then ls_mess = "~r" + ls_mess //put return on beginning of string
is_mess_all = is_mess_all + ls_mess
ii_cnt++
dw_1.setitem(ai_row,"error_type", as_mess)

return 1
end function

event open;//Start Code Change ----12.17.2007 #V8 maha -- Window Created
gs_variable_array lst_fields
integer i
integer ic
string ls_field[]

lst_fields = message.powerobjectparm

ic = upperbound(lst_fields.as_string[])
for i = 1 to ic
	dw_1.insertrow(0)
	dw_1.setitem(i,"application_name",lst_fields.as_string[i] )
next
end event

on w_database_field_verify.create
this.cb_correct_help=create cb_correct_help
this.cbx_correct=create cbx_correct
this.cb_test=create cb_test
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.cb_quit=create cb_quit
this.Control[]={this.cb_correct_help,&
this.cbx_correct,&
this.cb_test,&
this.cb_ok,&
this.dw_1,&
this.cb_quit}
end on

on w_database_field_verify.destroy
destroy(this.cb_correct_help)
destroy(this.cbx_correct)
destroy(this.cb_test)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.cb_quit)
end on

event close;if not ib_IsOK then //Add by Evan on 04/25/2008
	CloseWithReturn(this, -1)
end if
end event

type cb_correct_help from commandbutton within w_database_field_verify
integer x = 526
integer y = 24
integer width = 73
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;//BEGIN---Modify by Evan 09/17/2008
//Messagebox("Auto Correct Help","The Verify function will will trap for many errors including invalid characters.  Auto Correct will:~r~rCheck field length to between 3 and 40 characters, and will pad or truncate as required.~rField names must begin with a letter, so the letter X will be added to the front of the field name where the first character is invalid.  ~rInvalid characters will be replaced by underscores.~rFor duplicated field names, the field number will be added to the end of the name.")
Messagebox("Auto Correct Help","The Verify function will trap for many errors including invalid characters.  Auto Correct will:~r~rCheck field length to between 3 and 40 characters, and will pad or truncate as required.~rField names must begin with a letter, so the letter X will be added to the front of the field name where the first character is invalid.  ~rInvalid characters will be replaced by underscores.~rFor duplicated field names, the field number will be added to the end of the name.")
//END---Modify by Evan 09/17/2008
end event

type cbx_correct from checkbox within w_database_field_verify
integer x = 73
integer y = 32
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Auto Correct"
end type

type cb_test from commandbutton within w_database_field_verify
integer x = 2496
integer y = 20
integer width = 293
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Verify"
boolean default = true
end type

event clicked;integer res

res = of_verify_field_name( )

if res > 0 then
	openwithparm(w_sql_msg, is_errors )
else
	//BEGIN---Add by Evan 09/18/2008
	string ls_error_type[]
	if dw_1.RowCount() > 0 then
		ls_error_type[dw_1.RowCount()] = ""
		dw_1.object.error_type[1, dw_1.RowCount()] = ls_error_type[]
	end if
	//END---Add by Evan 09/17/2008
	Messagebox("Verify","Field list OK")
end if

end event

type cb_ok from commandbutton within w_database_field_verify
integer x = 2885
integer y = 20
integer width = 293
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;
gs_variable_array lst_fields
string ls_field[]
integer i
integer ic
integer res

res = of_verify_field_name( )



if res > 0 then
	openwithparm(w_sql_msg, is_errors )
else
	ic = dw_1.rowcount( )
	for i = 1 to ic
		ls_field[i] = dw_1.getitemstring(i,"application_name" )
	next
	lst_fields.as_string[] = ls_field[] 
	
	ib_IsOK = true //Add by Evan on 04/25/2008
	closewithreturn(parent,lst_fields)
end if



end event

type dw_1 from datawindow within w_database_field_verify
integer x = 32
integer y = 152
integer width = 3456
integer height = 2088
integer taborder = 10
string title = "none"
string dataobject = "d_import_field_name_create"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_quit from commandbutton within w_database_field_verify
integer x = 3195
integer y = 20
integer width = 293
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;//START --- modify by Evan on 04/25/2008
//closewithreturn(parent,-1) 
Close(Parent)
//END --- modify by Evan on 04/25/2008
end event

