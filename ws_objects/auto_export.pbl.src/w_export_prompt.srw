$PBExportHeader$w_export_prompt.srw
forward
global type w_export_prompt from window
end type
type st_4 from statictext within w_export_prompt
end type
type st_facil from statictext within w_export_prompt
end type
type dw_facil from datawindow within w_export_prompt
end type
type st_dates from statictext within w_export_prompt
end type
type st_3 from statictext within w_export_prompt
end type
type st_2 from statictext within w_export_prompt
end type
type st_1 from statictext within w_export_prompt
end type
type sle_3 from singlelineedit within w_export_prompt
end type
type sle_2 from singlelineedit within w_export_prompt
end type
type sle_1 from singlelineedit within w_export_prompt
end type
type cb_2 from commandbutton within w_export_prompt
end type
type cb_1 from commandbutton within w_export_prompt
end type
end forward

global type w_export_prompt from window
integer x = 1056
integer y = 484
integer width = 1824
integer height = 848
windowtype windowtype = response!
long backcolor = 33551856
st_4 st_4
st_facil st_facil
dw_facil dw_facil
st_dates st_dates
st_3 st_3
st_2 st_2
st_1 st_1
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
end type
global w_export_prompt w_export_prompt

type variables
string is_return
string is_type1
string is_type2
string is_type3
long il_facil = -1
end variables

forward prototypes
public function integer of_parse_arg (string as_pass)
public function integer of_validate ()
public function integer of_check_date (string as_date)
public function string of_date_format (string as_sql)
end prototypes

public function integer of_parse_arg (string as_pass);//determine the number of parameters and datatype
string ls_arg
integer p1
integer p2
integer p3
datawindowchild dwchild
integer res

ls_arg = as_pass

is_type1 = ""
is_type2 = ""
is_type3 = ""

sle_1.visible = false
sle_2.visible = false
sle_3.visible = false

is_type1 = MidA(ls_arg,1,1)
if isnull(is_type1) or is_type1 = "*" then is_type1 = "" //(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2
p1 = PosA(ls_arg,"*",1)
if p1 > 0 then 
	is_type2 = MidA(ls_arg,p1 + 1,1)
	if isnull(is_type2) or is_type2 = "*" then is_type2 = "" //(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2
	p2 = PosA(ls_arg,"*",p1+1)
	if p2 > 0 then
		is_type3 = MidA(ls_arg,p2 + 1,1)
		if isnull(is_type3) or is_type3 = "*" then is_type3 = "" //(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2
	end if
end if

//Start Code Change ----02.04.2011 #V11 maha - added for facility criteria
if is_type1 = "D" or is_type2 = "D" or is_type3 = "D" then
	st_dates.visible = true
else
	st_dates.visible = false
end if

//(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2
dw_facil.visible = false
st_facil.visible = false

if is_type1 = 'F'  then
	debugbreak()
	dw_facil.visible = true
	st_facil.visible = true
	dw_facil.settransobject(sqlca)
	//dw_facil.retrieve( )
	dw_facil.insertrow(1)
	res = dw_facil.getchild( "facility_name",dwchild)
	dwchild.settransobject(sqlca)
	res = dwchild.retrieve(gs_user_id )
	dwchild.insertrow(1)
	dwchild.setitem(1,"facility_id",0)
	dwchild.setitem(1,"facility_facility_name","All")
	

	
	st_1.visible = false
elseif LenA(is_type1) > 0 then
	sle_1.visible = true
	choose case is_type1
		case "D"
			st_1.text = "Enter Start Date"
		case "C"
			st_1.text = "Enter String Value"
		case "N"
			st_1.text = "Enter Number"
	end choose
	dw_facil.visible = false
else
	st_1.visible = false
end if
//End Code Change ----02.04.2011

if LenA(is_type2) > 0 then
	sle_2.visible = true
	choose case is_type2
		case "D"
			if st_1.text = "Enter Start Date" then
				st_2.text = "Enter To Date"
			else
				st_2.text = "Enter From Date"
			end if
		case "C"
			st_2.text = "Enter String Value"
		case "N"
			st_2.text = "Enter Number"

	end choose
else
	st_2.visible = false
end if
if LenA(is_type3) > 0 then
	sle_3.visible = true
	choose case is_type3
		case "D"
			if st_2.text = "Enter From Date" then
				st_3.text = "Enter To Date"
			else
				st_3.text = "Enter Date"
			end if
		case "C"
			st_3.text = "Enter String Value"
		case "N"
			st_3.text = "Enter Number"

	end choose
else
	st_3.visible = false
end if
	


return 1
end function

public function integer of_validate ();string ls_parm1 
string ls_parm2
string ls_parm3
integer chk


ls_parm1 = sle_1.text
ls_parm2 = sle_2.text
ls_parm3 = sle_3.text

if sle_1.visible and LenA(ls_parm1) < 1 then
	messagebox("Missing Parameter","Please enter a value for the first parameter")
	return -1
end if
if sle_2.visible and LenA(ls_parm2) < 1 then
	messagebox("Missing Parameter","Please enter a value for the second parameter")
	return -1
end if	
if sle_3.visible and LenA(ls_parm3) < 1 then
	messagebox("Missing Parameter","Please enter a value for the third parameter")
	return -1
end if
debugbreak()

if il_facil >= 0 then  //Start Code Change ----02.04.2011 #V11 maha 
	ls_parm1 = string(il_facil)

elseif sle_1.visible then
	if LenA(ls_parm1) > 0 then
		choose case  is_type1
			case "D"
				if of_check_date(ls_parm1) = -1 then return -1
				//Start Code Change ---- 11.30.2006 #V7 maha
				ls_parm1 = of_date_format(ls_parm1)
				//End Code Change---11.30.2006
				
			case "C"
				ls_parm1 = "'" + ls_parm1 + "'"
			case "I", "N"
				//do nothing
		end choose
	else	
		messagebox("Missing Parameter","Please enter a value for the first parameter")
		return -1
	end if
end if

if sle_2.visible then
	if LenA(ls_parm2) > 0 then
		choose case  is_type2
			case "D"
				if of_check_date(ls_parm2) = -1 then return -1
				//ls_parm2 = "date('" + ls_parm2 + "')"
				ls_parm2 = of_date_format(ls_parm2)
			case "C"
				ls_parm2 = "'" + ls_parm2 + "'"
			case "I", "N"
				//do nothing
		end choose
	else	
		messagebox("Missing Parameter","Please enter a value for the second parameter")
		return -1
	end if
end if
	//validate based on datatype
if sle_3.visible then
	if LenA(ls_parm3) > 0 then
		choose case  is_type3
			case "D"
				if of_check_date(ls_parm3) = -1 then return -1
				//ls_parm3 = "date('" + ls_parm3 + "')"
				ls_parm3 = of_date_format(ls_parm3)
			case "C"
				ls_parm3 = "'" + ls_parm3 + "'"
			case "I", "N"
				//do nothing
		end choose
	else	
		messagebox("Missing Parameter","Please enter a value for the third parameter")
		return -1
	end if
end if	
	
is_return = ls_parm1 + "*" + ls_parm2 + "*" + ls_parm3

return 1
end function

public function integer of_check_date (string as_date);string s
string ls_char
integer i
integer ic
integer ck = 1

s = as_date

ic = LenA(s)
for i = 1 to ic
	ls_char = MidA(s,i,1)
	choose case i
		case 1,2,3,4,6,7,9,10
			if not isnumber(ls_char) then
				ck = -1
				end if
		case 5,8
			if ls_char <> "/" and ls_char <> "-" then// Code Change ---- 12.01.2006 #V7 maha
				ck = -1
			end if
	end choose

next

if ck = -1 then
	messagebox("Parameter error","Invalid date format.  Date parameters must be entered as YYYY/MM/DD.")
return -1
else
	return 1
end if
end function

public function string of_date_format (string as_sql);string ls_ret

ls_ret = as_sql

if gs_dbtype = "ASA" then
	ls_ret = "date('" + ls_ret + "')"
else  //MSSQL
	//ls_ret = "cast('" + ls_ret + "' as date)"		//comment by Scofield on 2007-06-26
	
	ls_ret = "cast('" + ls_ret + "' as datetime)"	//Added by Scofield on 2007-06-26
end if

return ls_ret
end function

on w_export_prompt.create
this.st_4=create st_4
this.st_facil=create st_facil
this.dw_facil=create dw_facil
this.st_dates=create st_dates
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_4,&
this.st_facil,&
this.dw_facil,&
this.st_dates,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.cb_2,&
this.cb_1}
end on

on w_export_prompt.destroy
destroy(this.st_4)
destroy(this.st_facil)
destroy(this.dw_facil)
destroy(this.st_dates)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;string s

s = message.stringparm

of_parse_arg(s)
end event

type st_4 from statictext within w_export_prompt
integer x = 517
integer y = 16
integer width = 846
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Enter Criteria Values"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_facil from statictext within w_export_prompt
integer x = 41
integer y = 212
integer width = 480
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Facility"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_facil from datawindow within w_export_prompt
integer x = 530
integer y = 196
integer width = 1001
integer height = 80
integer taborder = 10
string title = "none"
string dataobject = "d_facility_select"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_facil = long(data)
end event

type st_dates from statictext within w_export_prompt
integer x = 571
integer y = 112
integer width = 846
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Enter Dates as YYYY/MM/DD"
boolean focusrectangle = false
end type

type st_3 from statictext within w_export_prompt
integer x = 41
integer y = 532
integer width = 480
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Prompt 3"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_export_prompt
integer x = 41
integer y = 424
integer width = 480
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Prompt 2"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_export_prompt
integer x = 41
integer y = 316
integer width = 480
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Prompt 1"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_export_prompt
integer x = 530
integer y = 508
integer width = 1170
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_export_prompt
integer x = 530
integer y = 400
integer width = 1170
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_export_prompt
integer x = 530
integer y = 296
integer width = 1170
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_export_prompt
integer x = 1010
integer y = 636
integer width = 247
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_1 from commandbutton within w_export_prompt
integer x = 750
integer y = 636
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;integer i

i = of_validate()



if i = 1 then closewithreturn(parent,is_return)
end event

