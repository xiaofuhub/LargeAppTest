$PBExportHeader$uo_calendar_object.sru
forward
global type uo_calendar_object from userobject
end type
type vsb_year from vscrollbar within uo_calendar_object
end type
type em_year from editmask within uo_calendar_object
end type
type dw_day from datawindow within uo_calendar_object
end type
type ddlb_month from dropdownlistbox within uo_calendar_object
end type
end forward

global type uo_calendar_object from userobject
integer width = 814
integer height = 692
boolean border = true
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_datechanged ( date newdate )
vsb_year vsb_year
em_year em_year
dw_day dw_day
ddlb_month ddlb_month
end type
global uo_calendar_object uo_calendar_object

type prototypes
function long GetLocaleInfo(long Locale,long LCType, ref string buffer,long buflen)library "kernel32" alias for "GetLocaleInfoA;Ansi"

end prototypes

type variables
private date currentdate
private date startdate

end variables

forward prototypes
private function boolean f_init ()
private function string f_getmonthname (integer month)
public function integer f_getfirstdayofweek ()
private function string f_getlocaleinfo (long locale_type)
public function string f_getshortdayname (integer day)
public function boolean f_setdate (date newdate)
private function boolean f_changemonth (integer number)
public function boolean f_setdate (integer year, integer month, integer day)
private function boolean f_changeyear (integer number)
private function boolean f_nextmonth (integer direction)
private function boolean f_changeday (integer number)
public function date f_getdate ()
end prototypes

private function boolean f_init ();int i,j,k
string s

setNull(currentdate)

//fill month ddlb with names
ddlb_month.reset()
for i=1 to 12
	ddlb_month.addItem( f_getMonthName(i) )
next

//set week day names
j=f_getFirstDayOfWeek()
s=''
for i=1 to 7
	s += 'h'+string(i)+'.text="'
	k = mod( (i + j - 2), 7 ) + 1
	s += f_getShortDayName( k )
	s += '" '
	if k = 1 or k = 7 then s+='h'+string(i)+'.color="'+string(rgb(192,0,0))+'"'
next
dw_day.modify(s)

f_setDate(today())

return true

end function

private function string f_getmonthname (integer month);if month<1 or month>12 then return ''

month = 56 + month - 1 //LOCALE_SMONTHNAME1          0x00000038 + month  (winnls.h)
return f_getLocaleInfo(month)

end function

public function integer f_getfirstdayofweek ();//LOCALE_IFIRSTDAYOFWEEK      0x0000100C=4108
int i
i=integer(f_getLocaleInfo(4108))
//i contains 0 for monday, ... , 6 for sunday
//now convert it to pb value 1 for sunday, ... 7 for saturday

i += 2 //2 for monday, ... , 8 for sunday
if i=8 then i=1
return i

end function

private function string f_getlocaleinfo (long locale_type);string buf
long buflen

//LOCALE_USER_DEFAULT=1024
buflen=GetLocaleInfo(1024,locale_type,buf,0)
buf=space(buflen)
GetLocaleInfo(1024,locale_type,buf,buflen+1)
return buf

end function

public function string f_getshortdayname (integer day);//LOCALE_SABBREVDAYNAME1      0x00000031=49   /* abbreviated name for Monday */
day -= 2
if day=-1 then day=6
day += 49
return f_getLocaleInfo(day)

end function

public function boolean f_setdate (date newdate);int i
string s

if isNull(newdate) then newdate=today()

if integer(em_year.text)<>year(newdate) then em_year.text=string(year(newdate))
//if ddlb_month.selectedItem<>month(newdate) then 
ddlb_month.selectItem(month(newdate))

if month(currentdate)=month(newdate) and year(currentdate)=year(newdate) then
else
	date d
	i=f_getFirstDayOfWeek()
	startdate=date(year(newdate),month(newdate),1)
	DO
		startdate=RelativeDate(startdate,-1)
	LOOP WHILE DayNumber(startdate)<>i
	startdate=RelativeDate(startdate,-1)
	for i=1 to 42
		d=relativedate(startdate,i)
		s+='f'+string(i)+'.text="'+string(day(d))+'" '
		s+='f'+string(i)+'.color="'
		if month(d)<>month(newdate) then 
			s+=string(274359156)
		else
			s+=string(33554432)
		end if
		s+='" '
	next
end if
dw_day.modify(s)
dw_day.setItem(1,1,'f'+string(daysafter(startdate,newdate)))

if currentdate=newdate then
else
	this.event ue_datechanged(newdate)
end if
currentdate=newdate
return true

end function

private function boolean f_changemonth (integer number);return f_setDate(year(currentdate),number,day(currentdate))

end function

public function boolean f_setdate (integer year, integer month, integer day);
if day<1 then day=1
if day>31 then day=31

if month<1 then month=1
if month>12 then month=12

if year>3000 then year=3000
if year<1000 then year=1000

do while day(date(year,month,day))<>day
	day --
loop
f_setDate(date(year,month,day))

return true

end function

private function boolean f_changeyear (integer number);return f_setDate(number,month(currentdate),day(currentdate))

end function

private function boolean f_nextmonth (integer direction);int yy,m,d

if direction=0 or isNull(direction) then return false

yy=year(currentdate)
m=month(currentdate)
d=day(currentdate)

if direction>0 then
	m ++
else
	m --
end if

if m>12 then
	m=1
	yy ++
end if
if m<1 then
	m=12
	yy --
end if

return f_setDate(yy,m,d)

end function

private function boolean f_changeday (integer number);return f_setDate( relativeDate( startdate, number ) )

end function

public function date f_getdate ();return currentdate

end function

on uo_calendar_object.create
this.vsb_year=create vsb_year
this.em_year=create em_year
this.dw_day=create dw_day
this.ddlb_month=create ddlb_month
this.Control[]={this.vsb_year,&
this.em_year,&
this.dw_day,&
this.ddlb_month}
end on

on uo_calendar_object.destroy
destroy(this.vsb_year)
destroy(this.em_year)
destroy(this.dw_day)
destroy(this.ddlb_month)
end on

event constructor;f_init()

end event

type vsb_year from vscrollbar within uo_calendar_object
integer x = 704
integer y = 36
integer width = 64
integer height = 84
boolean stdwidth = false
end type

event lineup;f_changeYear(integer(em_year.text)+1)

end event

event linedown;f_changeYear(integer(em_year.text)-1)

end event

type em_year from editmask within uo_calendar_object
event change pbm_enchange
event keydown pbm_keydown
integer x = 471
integer y = 36
integer width = 233
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "0000"
string displaydata = ""
end type

event keydown;CHOOSE CASE key
	CASE KeyUpArrow!
		vsb_year.event lineup()
	CASE KeyDownArrow!
		vsb_year.event linedown()
END CHOOSE

end event

event modified;parent.post f_changeYear(long(this.text))

end event

type dw_day from datawindow within uo_calendar_object
event key pbm_dwnkey
integer x = 14
integer y = 128
integer width = 773
integer height = 556
integer taborder = 30
string dataobject = "d_calendar_object"
boolean border = false
boolean livescroll = true
end type

event key;CHOOSE CASE key
	CASE KeyUpArrow!
		f_setDate(relativeDate(currentDate,-7))
	CASE KeyDownArrow!
		f_setDate(relativeDate(currentDate,+7))
	CASE KeyLeftArrow!
		f_setDate(relativeDate(currentDate,-1))
	CASE KeyRightArrow!
		f_setDate(relativeDate(currentDate,+1))
	CASE KeyPageUp!
		f_nextMonth(-1)
	CASE KeyPageDown!
		f_nextMonth(+1)
END CHOOSE
//

end event

event constructor;SetRowFocusIndicator(FocusRect!)

end event

event clicked;if dwo.type='text' then
	if CharA(dwo.name)='f' then
		f_changeDay( integer( MidA(dwo.name,2) ) )
	end if
end if

end event

type ddlb_month from dropdownlistbox within uo_calendar_object
integer x = 37
integer y = 36
integer width = 416
integer height = 856
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;f_changeMonth(index)

end event

