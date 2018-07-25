$PBExportHeader$w_dm_image_properties.srw
forward
global type w_dm_image_properties from w_response
end type
type cb_cancel from commandbutton within w_dm_image_properties
end type
type cb_ok from commandbutton within w_dm_image_properties
end type
type tab_1 from tab within w_dm_image_properties
end type
type tabpage_1 from userobject within tab_1
end type
type ddlb_compression from dropdownlistbox within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
ddlb_compression ddlb_compression
st_1 st_1
end type
type tabpage_2 from userobject within tab_1
end type
type sle_x from editmask within tabpage_2
end type
type sle_y from editmask within tabpage_2
end type
type st_4 from statictext within tabpage_2
end type
type st_x from statictext within tabpage_2
end type
type st_r from statictext within tabpage_2
end type
type ddlb_resolution from dropdownlistbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
sle_x sle_x
sle_y sle_y
st_4 st_4
st_x st_x
st_r st_r
ddlb_resolution ddlb_resolution
end type
type tabpage_3 from userobject within tab_1
end type
type sle_height from editmask within tabpage_3
end type
type sle_width from editmask within tabpage_3
end type
type sle_ori_units from singlelineedit within tabpage_3
end type
type ddlb_units from dropdownlistbox within tabpage_3
end type
type st_u from statictext within tabpage_3
end type
type st_h from statictext within tabpage_3
end type
type st_w from statictext within tabpage_3
end type
type ddlb_size from dropdownlistbox within tabpage_3
end type
type st_s from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
sle_height sle_height
sle_width sle_width
sle_ori_units sle_ori_units
ddlb_units ddlb_units
st_u st_u
st_h st_h
st_w st_w
ddlb_size ddlb_size
st_s st_s
end type
type tab_1 from tab within w_dm_image_properties
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_dm_image_properties from w_response
integer width = 1531
integer height = 1004
string title = "Properties"
boolean controlmenu = false
long backcolor = 33551856
cb_cancel cb_cancel
cb_ok cb_ok
tab_1 tab_1
end type
global w_dm_image_properties w_dm_image_properties

type variables

str_img_prop istr_img

Decimal{2} idc_size[2,3] = {8.50,13.00,  8.46,10.83, 10.00, 14.00 }   //default size - inches
						

end variables

forward prototypes
public function integer of_initialize ()
public function decimal of_convert_size (decimal adc_size, integer ai_resolution, string as_unit_from, string as_unit_to)
public function decimal of_convert_size (decimal adc_size, integer ai_resolution, integer ai_unit_from, integer ai_unit_to)
public function boolean of_get_settings ()
public function boolean of_verify_resolution ()
public function boolean of_verify_size ()
public function integer of_set_size (integer ai_size)
public function integer of_set_resolution (integer ai_resolution)
end prototypes

public function integer of_initialize ();//Initialize the settings

IF IsNull(istr_img) THEN RETURN 0

//compression
IF istr_img.image_compression > 0 THEN tab_1.tabpage_1.ddlb_compression.SelectItem(istr_img.image_compression) 

//Resolution
IF istr_img.image_resolution > 0 THEN tab_1.tabpage_2.ddlb_resolution.SelectItem(istr_img.image_resolution) 
IF istr_img.image_resolution_x > 0 THEN tab_1.tabpage_2.sle_x.text = String(istr_img.image_resolution_x)
IF istr_img.image_resolution_y > 0 THEN tab_1.tabpage_2.sle_y.text = String(istr_img.image_resolution_y)
IF istr_img.image_resolution <> 4 THEN //4 -custom
	tab_1.tabpage_2.sle_x.Enabled = FALSE
	tab_1.tabpage_2.sle_y.Enabled = FALSE	
END IF

//Size
IF istr_img.image_size > 0 THEN tab_1.tabpage_3.ddlb_size.SelectItem(istr_img.image_size) 
IF istr_img.image_width > 0 THEN 
	tab_1.tabpage_3.sle_width.text = String(of_convert_size(istr_img.image_width, istr_img.image_resolution_x, 'pixel', 'inch'))
END IF	
IF istr_img.image_height > 0 THEN
	tab_1.tabpage_3.sle_height.text = String(of_convert_size(istr_img.image_height, istr_img.image_resolution_y, 'pixel', 'inch'))
END IF
tab_1.tabpage_3.ddlb_units.SelectItem(1)  //default to inches
tab_1.tabpage_3.sle_ori_units.text = tab_1.tabpage_3.ddlb_units.text
IF istr_img.image_size <> 4 THEN //4 -custom
	tab_1.tabpage_3.sle_width.Enabled = FALSE
	tab_1.tabpage_3.sle_height.Enabled = FALSE	
END IF

RETURN 1


end function

public function decimal of_convert_size (decimal adc_size, integer ai_resolution, string as_unit_from, string as_unit_to);//Convert size with a differnt unit
Decimal ldc_rtn = -1
Decimal ldc_inch2mm = 25.4

//Othes to pixels
IF Lower(as_unit_to) = 'pixel' THEN
	IF NOT ai_resolution > 0 THEN RETURN -1
	CHOOSE CASE Lower(as_unit_from)
		CASE 'inch'
			ldc_rtn = adc_size * ai_resolution
		CASE 'mm'
			ldc_rtn = (adc_size * ai_resolution) / ldc_inch2mm
	END CHOOSE
END IF		
		
//Pixels to Others
IF Lower(as_unit_from) = 'pixel' THEN
	IF NOT ai_resolution > 0 THEN RETURN -1
	CHOOSE CASE Lower(as_unit_to)
		CASE 'inch'
			ldc_rtn = adc_size / ai_resolution
		CASE 'mm'
			ldc_rtn = (adc_size / ai_resolution) * ldc_inch2mm
	END CHOOSE
END IF

//inch to mm 
IF Lower(as_unit_from) = 'inch' and Lower(as_unit_to) = 'mm' THEN
	ldc_rtn = adc_size * ldc_inch2mm
END IF

//mm to inch
IF Lower(as_unit_from) = 'mm' AND Lower(as_unit_to) = 'inch' THEN
	ldc_rtn = adc_size / ldc_inch2mm
END IF

IF IsNull(ldc_rtn) or ldc_rtn < 0 THEN
	MessageBox("Convert Size","The size conversion is current unsupported!")
	RETURN -1
END IF

RETURN ldc_rtn
end function

public function decimal of_convert_size (decimal adc_size, integer ai_resolution, integer ai_unit_from, integer ai_unit_to);//Convert size with a differnt unit
Decimal ldc_rtn
String ls_unit_from, ls_unit_to

CHOOSE CASE ai_unit_from
	CASE 1
		ls_unit_from = 'inch'
	CASE 2
		ls_unit_from = 'mm'
	CASE 3
		ls_unit_from = 'pixel'
	CASE ELSE
		RETURN adc_size
END CHOOSE

CHOOSE CASE ai_unit_to
	CASE 1
		ls_unit_to = 'inch'
	CASE 2
		ls_unit_to = 'mm'
	CASE 3
		ls_unit_to = 'pixel'
	CASE ELSE
		RETURN adc_size
END CHOOSE

ldc_rtn = of_convert_size(adc_size, ai_resolution, ls_unit_from, ls_unit_to)

RETURN ldc_rtn
end function

public function boolean of_get_settings ();//Get current setting into a variable, and identify if they are changed

Integer li_compression, li_resolution, li_x, li_y, li_size, li_units
Decimal ldc_width, ldc_height
Boolean lb_modified = FALSE

//Get the current settings
li_compression = tab_1.tabpage_1.ddlb_compression.Finditem(tab_1.tabpage_1.ddlb_compression.text, 0)

li_resolution = tab_1.tabpage_2.ddlb_resolution.Finditem(tab_1.tabpage_2.ddlb_resolution.text, 0)
li_x = Integer(Trim(tab_1.tabpage_2.sle_x.text))
li_y = Integer(Trim(tab_1.tabpage_2.sle_y.text))

li_size = tab_1.tabpage_3.ddlb_size.Finditem(tab_1.tabpage_3.ddlb_size.text, 0)
ldc_width = Dec(Trim(tab_1.tabpage_3.sle_width.text))
ldc_height = Dec(Trim(tab_1.tabpage_3.sle_height.text)) 
li_units = tab_1.tabpage_3.ddlb_units.Finditem(tab_1.tabpage_3.ddlb_units.text, 0) 
IF li_units <> 3 THEN //convert to pixels
	ldc_width = of_convert_size(ldc_width, li_x, li_units, 3)
	ldc_height = of_convert_size(ldc_height, li_y, li_units, 3)
END IF

//Identify if they are changed
IF istr_img.image_compression <> li_compression OR &
	istr_img.image_resolution <> li_resolution OR &
	istr_img.image_resolution_x <> li_x OR &
	istr_img.image_resolution_y <> li_y OR &
	istr_img.image_size <> li_size OR &
	istr_img.image_width <> ldc_width OR &
	istr_img.image_height <> ldc_height THEN
	//Store the current settings
	istr_img.image_compression = li_compression 
	istr_img.image_resolution = li_resolution 
	istr_img.image_resolution_x = li_x 
	istr_img.image_resolution_y = li_y 
	istr_img.image_size = li_size 
	istr_img.image_width = ldc_width
	istr_img.image_height = ldc_height
	lb_modified = TRUE
END IF

RETURN lb_modified

end function

public function boolean of_verify_resolution ();//Verify the resolution values

String ls_x, ls_y
Boolean lb_warning = FALSE

ls_x = Trim(tab_1.tabpage_2.sle_x.text)
ls_y = Trim(tab_1.tabpage_2.sle_y.text)

IF NOT IsNumber(ls_x) OR NOT IsNumber(ls_y) THEN 
	lb_warning = TRUE
ELSEIF Integer(ls_x) < 20 OR Integer(ls_x) > 1200 THEN
	lb_warning = TRUE
ELSEIF Integer(ls_y) < 20 OR Integer(ls_y) > 1200 THEN
	lb_warning = TRUE
END IF

IF lb_warning THEN 
	MessageBox("Properties","Resolution value is not between 20 and 1200 dpi.")
	RETURN FALSE
END If

RETURN TRUE
end function

public function boolean of_verify_size ();//Verify the size settings

Integer li_unit, li_x, li_y
Decimal ldc_max_width = 60.00, ldc_max_height = 60.00
String ls_width, ls_height
Boolean lb_warning1 = FALSE, lb_warning2 = FALSE

ls_width = Trim(tab_1.tabpage_3.sle_width.text)
ls_height = Trim(tab_1.tabpage_3.sle_height.text)
li_unit = Integer(tab_1.tabpage_3.ddlb_units.text)
li_x = Integer(tab_1.tabpage_2.sle_x.text)
li_y = Integer(tab_1.tabpage_2.sle_y.text)

CHOOSE CASE li_unit
	CASE 1 //inches
		//
	CASE 2 //millimeters
		ldc_max_width = ldc_max_width * 25.4	
		ldc_max_height = ldc_max_width
	CASE 3 //piexls
		ldc_max_width = ldc_max_width * li_x
		ldc_max_height = ldc_max_height * li_y
END CHOOSE

IF NOT IsNumber(ls_width) OR NOT IsNumber(ls_height) THEN 
	lb_warning1 = TRUE
ELSEIF dec(ls_width) <= 0 OR dec(ls_height) <= 0 THEN
	lb_warning1 = TRUE
ELSEIF dec(ls_width) > ldc_max_width OR dec(ls_height) > ldc_max_height THEN
	lb_warning2 = TRUE
END IF

IF lb_warning1 THEN 
	MessageBox("Properties","The size is too small and must be increased.")
	RETURN FALSE
ELSEIF lb_warning2 THEN 
	MessageBox("Properties","The size is too large and must be decreased.")
	RETURN FALSE
END If

RETURN TRUE
end function

public function integer of_set_size (integer ai_size);//Set the width and height according to the size option

IF ai_size <> 4 THEN // 4 - custom
	//Set to default size
	tab_1.tabpage_3.sle_width.text = String(idc_size[1,ai_size])
	tab_1.tabpage_3.sle_height.text = String(idc_size[2,ai_size])
	//Set to default unit
	tab_1.tabpage_3.ddlb_units.selectitem(1) //default to inches
END IF

RETURN 1
end function

public function integer of_set_resolution (integer ai_resolution);//Set resolution x and y values accordingly

IF ai_resolution <> 4  THEN //4 - custom
	tab_1.tabpage_2.sle_x.text = String(ai_resolution) + "00"	
	tab_1.tabpage_2.sle_y.text = String(ai_resolution) + "00"	
END IF

RETURN 1
end function

on w_dm_image_properties.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.tab_1
end on

on w_dm_image_properties.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.tab_1)
end on

event open;call super::open;//Created by Alfee on 11.18.2008

IF Not IsNull(Message.powerobjectparm) THEN 
	istr_img = Message.powerobjectparm
	of_initialize()
END IF
end event

type cb_cancel from commandbutton within w_dm_image_properties
integer x = 1157
integer y = 816
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
end type

event clicked;
ClosewithReturn(parent, "cancel")
end event

type cb_ok from commandbutton within w_dm_image_properties
integer x = 809
integer y = 816
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;Boolean lb_modified = FALSE

//convert to default unit
IF tab_1.SelectedTab = 3 THEN //size
	IF Lower(tab_1.tabpage_3.ddlb_units.Text) <> 'inches' THEN
		tab_1.tabpage_3.ddlb_units.SelectItem(1)
		tab_1.tabpage_3.ddlb_units.event SelectionChanged(1)
	END IF
END IF

//verify settings
IF NOT of_verify_resolution() OR NOT of_verify_size() THEN
	RETURN
END IF

//Get settings
lb_modified = of_get_settings()

IF lb_modified THEN 
	ClosewithReturn(Parent, istr_img)
ELSE
	ClosewithReturn(Parent, 'cancel')
END IF
end event

type tab_1 from tab within w_dm_image_properties
integer y = 16
integer width = 1499
integer height = 784
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanging;Boolean lb_rtn = TRUE

CHOOSE CASE(oldindex)
	CASE 1 //compression
		//
	CASE 2 //resolution
		lb_rtn = of_verify_resolution()
	CASE 3 //size
		IF Lower(tab_1.tabpage_3.ddlb_units.Text) <> 'inches' THEN
			tab_1.tabpage_3.ddlb_units.SelectItem(1)
			tab_1.tabpage_3.ddlb_units.event SelectionChanged(1)
		END IF
		lb_rtn = of_verify_size()
END CHOOSE

IF NOT lb_rtn THEN RETURN 1

RETURN 0
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1463
integer height = 668
long backcolor = 33551856
string text = "Compression"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
ddlb_compression ddlb_compression
st_1 st_1
end type

on tabpage_1.create
this.ddlb_compression=create ddlb_compression
this.st_1=create st_1
this.Control[]={this.ddlb_compression,&
this.st_1}
end on

on tabpage_1.destroy
destroy(this.ddlb_compression)
destroy(this.st_1)
end on

type ddlb_compression from dropdownlistbox within tabpage_1
integer x = 370
integer y = 96
integer width = 585
integer height = 320
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
string item[] = {"LZW","CITT3","CITT4","RLE","NONE"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within tabpage_1
integer x = 9
integer y = 108
integer width = 347
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Compression :"
alignment alignment = right!
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1463
integer height = 668
long backcolor = 33551856
string text = "Resolution"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
sle_x sle_x
sle_y sle_y
st_4 st_4
st_x st_x
st_r st_r
ddlb_resolution ddlb_resolution
end type

on tabpage_2.create
this.sle_x=create sle_x
this.sle_y=create sle_y
this.st_4=create st_4
this.st_x=create st_x
this.st_r=create st_r
this.ddlb_resolution=create ddlb_resolution
this.Control[]={this.sle_x,&
this.sle_y,&
this.st_4,&
this.st_x,&
this.st_r,&
this.ddlb_resolution}
end on

on tabpage_2.destroy
destroy(this.sle_x)
destroy(this.sle_y)
destroy(this.st_4)
destroy(this.st_x)
destroy(this.st_r)
destroy(this.ddlb_resolution)
end on

type sle_x from editmask within tabpage_2
integer x = 347
integer y = 232
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
string minmax = "~~"
end type

type sle_y from editmask within tabpage_2
integer x = 347
integer y = 328
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
string minmax = "0~~"
end type

type st_4 from statictext within tabpage_2
integer x = 18
integer y = 348
integer width = 293
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Y :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_x from statictext within tabpage_2
integer x = 18
integer y = 252
integer width = 293
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&X :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_r from statictext within tabpage_2
integer y = 108
integer width = 311
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Resolution :"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_resolution from dropdownlistbox within tabpage_2
integer x = 347
integer y = 92
integer width = 585
integer height = 320
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"100 x 100 dpi","200 x 200 dpi","300 x 300 dpi","Custom"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;IF index <> 4 THEN //4 -custom
	tab_1.tabpage_2.sle_x.Enabled = FALSE
	tab_1.tabpage_2.sle_y.Enabled = FALSE	
	//Set resolution x and y accordingly
	of_set_resolution(index)
ELSE
	tab_1.tabpage_2.sle_x.Enabled = TRUE
	tab_1.tabpage_2.sle_y.Enabled = TRUE		
END IF
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1463
integer height = 668
long backcolor = 33551856
string text = "Size    "
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
sle_height sle_height
sle_width sle_width
sle_ori_units sle_ori_units
ddlb_units ddlb_units
st_u st_u
st_h st_h
st_w st_w
ddlb_size ddlb_size
st_s st_s
end type

on tabpage_3.create
this.sle_height=create sle_height
this.sle_width=create sle_width
this.sle_ori_units=create sle_ori_units
this.ddlb_units=create ddlb_units
this.st_u=create st_u
this.st_h=create st_h
this.st_w=create st_w
this.ddlb_size=create ddlb_size
this.st_s=create st_s
this.Control[]={this.sle_height,&
this.sle_width,&
this.sle_ori_units,&
this.ddlb_units,&
this.st_u,&
this.st_h,&
this.st_w,&
this.ddlb_size,&
this.st_s}
end on

on tabpage_3.destroy
destroy(this.sle_height)
destroy(this.sle_width)
destroy(this.sle_ori_units)
destroy(this.ddlb_units)
destroy(this.st_u)
destroy(this.st_h)
destroy(this.st_w)
destroy(this.ddlb_size)
destroy(this.st_s)
end on

type sle_height from editmask within tabpage_3
integer x = 334
integer y = 332
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "###,###.00"
end type

type sle_width from editmask within tabpage_3
integer x = 334
integer y = 232
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "###,###.00"
end type

type sle_ori_units from singlelineedit within tabpage_3
boolean visible = false
integer x = 951
integer y = 440
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type ddlb_units from dropdownlistbox within tabpage_3
integer x = 334
integer y = 452
integer width = 485
integer height = 276
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Inches","Millimeters","Pixels"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Integer li_resolution_x, li_resolution_y
Decimal ldc_width_ori, ldc_height_ori, ldc_width, ldc_height
String ls_unit_from, ls_unit_to

//Get last unit
CHOOSE CASE Lower(tab_1.tabpage_3.sle_ori_units.text)
	CASE 'inches'
		ls_unit_from = 'inch'
	CASE 'millimeters'
		ls_unit_from = 'mm'
	CASE 'pixels'
		ls_unit_from = 'pixel'
	CASE ELSE
		ls_unit_from = 'inch'
END CHOOSE

//Get current unit
CHOOSE CASE index
	CASE 1
		ls_unit_to = 'inch'
	CASE 2
		ls_unit_to = 'mm'		
	CASE 3
		ls_unit_to = 'pixel'		
END CHOOSE

//Get resolution and size
li_resolution_x = Integer(tab_1.tabpage_2.sle_x.text)
li_resolution_y = Integer(tab_1.tabpage_2.sle_y.text)
ldc_width_ori =  Dec(sle_width.text)
ldc_height_ori = Dec(sle_height.text) 

//calculate and set the new width and length
ldc_width = of_convert_size(ldc_width_ori, li_resolution_x, ls_unit_from, ls_unit_to)
ldc_height = of_convert_size(ldc_height_ori, li_resolution_y, ls_unit_from, ls_unit_to)
sle_width.text = String(ldc_width)
sle_height.text = String(ldc_height)

//keep the current unit 
tab_1.tabpage_3.sle_ori_units.text = tab_1.tabpage_3.ddlb_units.text

end event

type st_u from statictext within tabpage_3
integer x = 146
integer y = 468
integer width = 174
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Units :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_h from statictext within tabpage_3
integer x = 110
integer y = 348
integer width = 210
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Height :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_w from statictext within tabpage_3
integer x = 133
integer y = 248
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Width :"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_size from dropdownlistbox within tabpage_3
integer x = 334
integer y = 92
integer width = 585
integer height = 320
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Folio","Quarto","10x14  in.","Custom"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;IF index <> 4 THEN //4 -custom
	tab_1.tabpage_3.sle_width.Enabled = FALSE
	tab_1.tabpage_3.sle_height.Enabled = FALSE
	//set default setting accordingly
	of_set_size(index)		
ELSE
	tab_1.tabpage_3.sle_width.Enabled = TRUE
	tab_1.tabpage_3.sle_height.Enabled = TRUE
END IF
end event

type st_s from statictext within tabpage_3
integer x = 155
integer y = 108
integer width = 165
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Size :"
alignment alignment = right!
boolean focusrectangle = false
end type

