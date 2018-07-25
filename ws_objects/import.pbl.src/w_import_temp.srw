$PBExportHeader$w_import_temp.srw
forward
global type w_import_temp from window
end type
type lb_string from listbox within w_import_temp
end type
type em_value from editmask within w_import_temp
end type
end forward

global type w_import_temp from window
boolean visible = false
integer width = 1170
integer height = 520
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
lb_string lb_string
em_value em_value
end type
global w_import_temp w_import_temp

forward prototypes
public function string of_format (string as_value)
public function integer of_setmask (string as_mask)
public function integer of_comparestring (string as_string1, string as_string2)
end prototypes

public function string of_format (string as_value);em_value.Text = as_Value

Return em_value.Text
end function

public function integer of_setmask (string as_mask);em_value.SetMask(StringMask!, as_Mask)

Return 1
end function

public function integer of_comparestring (string as_string1, string as_string2);lb_string.Reset()
lb_string.AddItem(as_String1)

//Return 1 if as_string1 > as_string2
//Return 2 if as_string1 < as_string2
Return lb_string.AddItem(as_String2)
end function

on w_import_temp.create
this.lb_string=create lb_string
this.em_value=create em_value
this.Control[]={this.lb_string,&
this.em_value}
end on

on w_import_temp.destroy
destroy(this.lb_string)
destroy(this.em_value)
end on

type lb_string from listbox within w_import_temp
integer x = 128
integer y = 196
integer width = 873
integer height = 192
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type em_value from editmask within w_import_temp
integer x = 128
integer y = 60
integer width = 878
integer height = 92
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

