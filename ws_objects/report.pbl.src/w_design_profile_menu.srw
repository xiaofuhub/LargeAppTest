$PBExportHeader$w_design_profile_menu.srw
forward
global type w_design_profile_menu from w_popup
end type
type r_6 from rectangle within w_design_profile_menu
end type
type dw_1 from datawindow within w_design_profile_menu
end type
type st_tab_order from statictext within w_design_profile_menu
end type
type st_relocate_field from statictext within w_design_profile_menu
end type
type st_left from statictext within w_design_profile_menu
end type
type st_center from statictext within w_design_profile_menu
end type
type st_right from statictext within w_design_profile_menu
end type
type st_text from statictext within w_design_profile_menu
end type
type st_bold from statictext within w_design_profile_menu
end type
type st_italic from statictext within w_design_profile_menu
end type
type st_underline from statictext within w_design_profile_menu
end type
type p_copysize from picture within w_design_profile_menu
end type
type p_aligntop from picture within w_design_profile_menu
end type
type p_alignleft from picture within w_design_profile_menu
end type
type st_1 from statictext within w_design_profile_menu
end type
type st_2 from statictext within w_design_profile_menu
end type
type p_1 from picture within w_design_profile_menu
end type
type st_show_invisible from statictext within w_design_profile_menu
end type
type st_6 from statictext within w_design_profile_menu
end type
type st_7 from statictext within w_design_profile_menu
end type
type st_8 from statictext within w_design_profile_menu
end type
type st_9 from statictext within w_design_profile_menu
end type
type st_10 from statictext within w_design_profile_menu
end type
type st_object_name from statictext within w_design_profile_menu
end type
type st_xy from statictext within w_design_profile_menu
end type
type r_1 from rectangle within w_design_profile_menu
end type
type r_2 from rectangle within w_design_profile_menu
end type
type r_3 from rectangle within w_design_profile_menu
end type
type r_4 from rectangle within w_design_profile_menu
end type
type r_5 from rectangle within w_design_profile_menu
end type
type st_11 from statictext within w_design_profile_menu
end type
type r_8 from rectangle within w_design_profile_menu
end type
type st_3 from statictext within w_design_profile_menu
end type
type st_4 from statictext within w_design_profile_menu
end type
end forward

global type w_design_profile_menu from w_popup
integer width = 3657
integer height = 296
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
long backcolor = 33551856
r_6 r_6
dw_1 dw_1
st_tab_order st_tab_order
st_relocate_field st_relocate_field
st_left st_left
st_center st_center
st_right st_right
st_text st_text
st_bold st_bold
st_italic st_italic
st_underline st_underline
p_copysize p_copysize
p_aligntop p_aligntop
p_alignleft p_alignleft
st_1 st_1
st_2 st_2
p_1 p_1
st_show_invisible st_show_invisible
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
st_10 st_10
st_object_name st_object_name
st_xy st_xy
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
r_5 r_5
st_11 st_11
r_8 r_8
st_3 st_3
st_4 st_4
end type
global w_design_profile_menu w_design_profile_menu

on w_design_profile_menu.create
int iCurrent
call super::create
this.r_6=create r_6
this.dw_1=create dw_1
this.st_tab_order=create st_tab_order
this.st_relocate_field=create st_relocate_field
this.st_left=create st_left
this.st_center=create st_center
this.st_right=create st_right
this.st_text=create st_text
this.st_bold=create st_bold
this.st_italic=create st_italic
this.st_underline=create st_underline
this.p_copysize=create p_copysize
this.p_aligntop=create p_aligntop
this.p_alignleft=create p_alignleft
this.st_1=create st_1
this.st_2=create st_2
this.p_1=create p_1
this.st_show_invisible=create st_show_invisible
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.st_10=create st_10
this.st_object_name=create st_object_name
this.st_xy=create st_xy
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.r_5=create r_5
this.st_11=create st_11
this.r_8=create r_8
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_6
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_tab_order
this.Control[iCurrent+4]=this.st_relocate_field
this.Control[iCurrent+5]=this.st_left
this.Control[iCurrent+6]=this.st_center
this.Control[iCurrent+7]=this.st_right
this.Control[iCurrent+8]=this.st_text
this.Control[iCurrent+9]=this.st_bold
this.Control[iCurrent+10]=this.st_italic
this.Control[iCurrent+11]=this.st_underline
this.Control[iCurrent+12]=this.p_copysize
this.Control[iCurrent+13]=this.p_aligntop
this.Control[iCurrent+14]=this.p_alignleft
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.p_1
this.Control[iCurrent+18]=this.st_show_invisible
this.Control[iCurrent+19]=this.st_6
this.Control[iCurrent+20]=this.st_7
this.Control[iCurrent+21]=this.st_8
this.Control[iCurrent+22]=this.st_9
this.Control[iCurrent+23]=this.st_10
this.Control[iCurrent+24]=this.st_object_name
this.Control[iCurrent+25]=this.st_xy
this.Control[iCurrent+26]=this.r_1
this.Control[iCurrent+27]=this.r_2
this.Control[iCurrent+28]=this.r_3
this.Control[iCurrent+29]=this.r_4
this.Control[iCurrent+30]=this.r_5
this.Control[iCurrent+31]=this.st_11
this.Control[iCurrent+32]=this.r_8
this.Control[iCurrent+33]=this.st_3
this.Control[iCurrent+34]=this.st_4
end on

on w_design_profile_menu.destroy
call super::destroy
destroy(this.r_6)
destroy(this.dw_1)
destroy(this.st_tab_order)
destroy(this.st_relocate_field)
destroy(this.st_left)
destroy(this.st_center)
destroy(this.st_right)
destroy(this.st_text)
destroy(this.st_bold)
destroy(this.st_italic)
destroy(this.st_underline)
destroy(this.p_copysize)
destroy(this.p_aligntop)
destroy(this.p_alignleft)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.st_show_invisible)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_object_name)
destroy(this.st_xy)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.r_5)
destroy(this.st_11)
destroy(this.r_8)
destroy(this.st_3)
destroy(this.st_4)
end on

event open;call super::open;dw_1.InsertRow( 0 )

This.x = 1
This.y = 310
end event

type r_6 from rectangle within w_design_profile_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 2976
integer y = 32
integer width = 613
integer height = 220
end type

type dw_1 from datawindow within w_design_profile_menu
integer x = 41
integer y = 92
integer width = 741
integer height = 84
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_design_label_editor"
boolean border = false
boolean livescroll = true
end type

event editchanged;w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[1] + ".text = '" + data + "'")
w_prac_profile_design.uo_design.dw_properties.SetItem(1, "data_view_fields_field_label", data ) 
end event

type st_tab_order from statictext within w_design_profile_menu
integer x = 869
integer y = 68
integer width = 352
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tab Order"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	w_prac_profile_design.uo_design.of_set_tab_order( False )
ELSE
	This.BorderStyle = StyleLowered!
	w_prac_profile_design.uo_design.of_set_tab_order( True )
END IF



end event

type st_relocate_field from statictext within w_design_profile_menu
boolean visible = false
integer x = 1710
integer width = 357
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Relocate Field"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
ELSE
	This.BorderStyle = StyleLowered!
END IF

IF UpperBound(w_prac_data_design.uo_design.is_last_object[]) = 0 THEN
	MessageBox("Error", "You must first select the fields you want to relocate.")
	Return
END IF

w_prac_data_design.uo_design.ib_relocating_fields = True

end event

type st_left from statictext within w_design_profile_menu
integer x = 1947
integer y = 148
integer width = 119
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 79741120
string text = "L"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i

This.BorderStyle = StyleLowered!
st_center.BorderStyle = StyleRaised!
st_right.BorderStyle = StyleRaised!
	

FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[i] + ".alignment = '0'")
	IF RightA( w_prac_profile_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		w_prac_profile_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "0" )
	ELSE
		w_prac_profile_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", "0" )
	END IF
END FOR
end event

type st_center from statictext within w_design_profile_menu
integer x = 2066
integer y = 148
integer width = 119
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i

This.BorderStyle = StyleLowered!
st_left.BorderStyle = StyleRaised!
st_right.BorderStyle = StyleRaised!


FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[i] + ".alignment = '2'")
	IF RightA( w_prac_profile_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		w_prac_profile_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "2" )
	ELSE
		w_prac_profile_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", "2" )
	END IF
END FOR
end event

type st_right from statictext within w_design_profile_menu
integer x = 2185
integer y = 148
integer width = 119
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "R"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i

This.BorderStyle = StyleLowered!
st_center.BorderStyle = StyleRaised!
st_left.BorderStyle = StyleRaised!

FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[I] + ".alignment = '1'")
	IF RightA( w_prac_profile_design.uo_design.is_last_object[I], 2) =  "_t" THEN
		w_prac_profile_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "1" )
	ELSE
		w_prac_profile_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", "1" )
	END IF
END FOR
end event

type st_text from statictext within w_design_profile_menu
integer x = 1326
integer y = 68
integer width = 256
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Text"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer li_nr
Integer li_object_no

if w_prac_profile_design.triggerevent("pfc_save") < 1 then return -1

li_nr = w_prac_profile_design.uo_design.dw_screen_objects.InsertRow(0)

SELECT Max(data_view_screen_objects.data_view_object_id)  
INTO :li_object_no  
FROM data_view_screen_objects;  
//WHERE ( data_view_screen_objects.data_view_id = :w_prac_profile_design.uo_design.il_data_view_id );

		
IF IsNull(li_object_no) THEN
	li_object_no = 0
END IF

li_object_no ++

w_prac_profile_design.uo_design.idw_detail.Modify("create text(band=detail text='text' border='0' color='0' x='20' y='20' height='52' width='150'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=object" + String(li_object_no) + "_t)"  )

w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "data_view_object_id", li_object_no)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "data_view_id", w_prac_profile_design.uo_design.il_data_view_id )
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "screen_id", w_prac_profile_design.uo_design.ii_screen_id)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_type", "T")
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_x", 20)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_y", 20)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_width", 660)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_height", 390)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_text", "none")
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_alignment", 0)



end event

type st_bold from statictext within w_design_profile_menu
integer x = 1947
integer y = 68
integer width = 119
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 79741120
string text = "B"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.weight='400'"
ELSE
	This.BorderStyle = StyleLowered!
	ls_syntax = ".font.weight='700'"
END IF

FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[i] + ls_syntax )
	IF RightA( w_prac_profile_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		//w_prac_profile_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "0" )
	ELSE
		//w_prac_profile_design.dw_properties.SetItem(1, "data_view_fields_justification", "0" )
	END IF
END FOR
end event

type st_italic from statictext within w_design_profile_menu
integer x = 2066
integer y = 68
integer width = 119
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "I"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.italic='0'"
ELSE
	This.BorderStyle = StyleLowered!
	ls_syntax = ".font.italic='1'"
END IF

FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[i] + ls_syntax)
	IF RightA( w_prac_profile_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		//w_prac_profile_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "0" )
	ELSE
		//w_prac_profile_design.dw_properties.SetItem(1, "data_view_fields_justification", "0" )
	END IF
END FOR
end event

type st_underline from statictext within w_design_profile_menu
integer x = 2185
integer y = 68
integer width = 119
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "U"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax
String ls_value

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.underline='0'"
	ls_value = "0"
ELSE
	This.BorderStyle = StyleLowered!
	ls_syntax = ".font.underline='1'"
	ls_value = "1"
END IF

FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[i] + ls_syntax )
	IF RightA( w_prac_profile_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		w_prac_profile_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_underline", ls_value )
	ELSE
		w_prac_profile_design.uo_design.dw_properties.SetItem(1, "data_view_fields_field_underline", ls_value )
	END IF
END FOR
end event

type p_copysize from picture within w_design_profile_menu
integer x = 2711
integer y = 68
integer width = 96
integer height = 80
boolean originalsize = true
string picturename = "copywidth.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	


FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[i] + ".width = '" + w_prac_profile_design.uo_design.is_last_object_width + "'")
END FOR

This.BorderStyle = StyleRaised!	



end event

type p_aligntop from picture within w_design_profile_menu
integer x = 2711
integer y = 148
integer width = 96
integer height = 80
boolean originalsize = true
string picturename = "aligntop.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[i] + ".y = '" + String(w_prac_profile_design.uo_design.il_last_object_y[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	



end event

type p_alignleft from picture within w_design_profile_menu
integer x = 2811
integer y = 148
integer width = 96
integer height = 80
boolean originalsize = true
string picturename = "alignleft.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[i] + ".x = '" + String(w_prac_profile_design.uo_design.il_last_object_x[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	



end event

type st_1 from statictext within w_design_profile_menu
integer x = 1582
integer y = 68
integer width = 256
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Box"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer li_nr
Integer li_object_no



li_nr = w_prac_profile_design.uo_design.dw_screen_objects.InsertRow(0)

SELECT Max(data_view_screen_objects.data_view_object_id)  
INTO :li_object_no  
FROM data_view_screen_objects  
WHERE ( data_view_screen_objects.data_view_id = :w_prac_profile_design.uo_design.il_data_view_id );

		
IF IsNull(li_object_no) THEN
	li_object_no = 0
END IF

li_object_no ++

w_prac_profile_design.uo_design.idw_detail.Modify("create groupbox(band=detail text='none'border='5' color='128' x='20' y='20' height='390' width='660'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=object" + String(li_object_no) + ")" )

w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "data_view_object_id", li_object_no)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "data_view_id", w_prac_profile_design.uo_design.il_data_view_id )
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "screen_id", w_prac_profile_design.uo_design.ii_screen_id)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_type", "B")
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_x", 20)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_y", 20)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_width", 660)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_height", 390)
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_text", "none")
w_prac_profile_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_alignment", 0)



end event

type st_2 from statictext within w_design_profile_menu
integer x = 1326
integer y = 148
integer width = 512
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Delete Object"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer li_obj_id
Integer li_found
String ls_obj_id

IF PosA(w_prac_profile_design.uo_design.is_last_object[1], "object" ) > 0 THEN
	ls_obj_id = MidA(w_prac_profile_design.uo_design.is_last_object[1], 7,100)
	IF RightA( ls_obj_id, 2) = "_t" THEN
		ls_obj_id = MidA(ls_obj_id, 1, LenA(ls_obj_id) -2 )
	END IF
	w_prac_profile_design.uo_design.idw_detail.Modify("destroy " + w_prac_profile_design.uo_design.is_last_object[1] )
	li_found = w_prac_profile_design.uo_design.dw_screen_objects.Find( "data_view_object_id = " + ls_obj_id, 1, 1000 )
	w_prac_profile_design.uo_design.dw_screen_objects.DeleteRow( li_found )
ELSE
	MessageBox("Clear Error", "You can't delete field or field label objects.  To hide, make the Visible property in the propeties dialog box = No.")
END IF
end event

type p_1 from picture within w_design_profile_menu
integer x = 2811
integer y = 68
integer width = 96
integer height = 80
boolean originalsize = true
string picturename = "copyheight.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_prac_profile_design.uo_design.ii_obj_select_cnt
	w_prac_profile_design.uo_design.idw_detail.Modify( w_prac_profile_design.uo_design.is_last_object[i] + ".height = '" + String(w_prac_profile_design.uo_design.il_last_object_height[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	



end event

type st_show_invisible from statictext within w_design_profile_menu
integer x = 869
integer y = 148
integer width = 352
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Show Invisible"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	w_prac_profile_design.uo_design.of_show_invisible( True )
	w_prac_profile_design.uo_design.ib_show_invisible = True
ELSE
	This.BorderStyle = StyleLowered!
	w_prac_profile_design.uo_design.of_show_invisible( False )
	w_prac_profile_design.uo_design.ib_show_invisible = False
END IF



end event

type st_6 from statictext within w_design_profile_menu
integer x = 873
integer y = 4
integer width = 96
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Edit"
boolean focusrectangle = false
end type

type st_7 from statictext within w_design_profile_menu
integer x = 1353
integer y = 4
integer width = 192
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Objects"
boolean focusrectangle = false
end type

type st_8 from statictext within w_design_profile_menu
integer x = 1934
integer y = 4
integer width = 361
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Text Properties"
boolean focusrectangle = false
end type

type st_9 from statictext within w_design_profile_menu
integer x = 2702
integer y = 4
integer width = 233
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Size/Align"
boolean focusrectangle = false
end type

type st_10 from statictext within w_design_profile_menu
integer x = 69
integer y = 4
integer width = 247
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Label Text"
boolean focusrectangle = false
end type

type st_object_name from statictext within w_design_profile_menu
integer x = 3008
integer y = 68
integer width = 526
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_xy from statictext within w_design_profile_menu
integer x = 3008
integer y = 160
integer width = 512
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type r_1 from rectangle within w_design_profile_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 823
integer y = 32
integer width = 443
integer height = 220
end type

type r_2 from rectangle within w_design_profile_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 1285
integer y = 32
integer width = 599
integer height = 220
end type

type r_3 from rectangle within w_design_profile_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 1906
integer y = 32
integer width = 443
integer height = 220
end type

type r_4 from rectangle within w_design_profile_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 2670
integer y = 32
integer width = 283
integer height = 220
end type

type r_5 from rectangle within w_design_profile_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 37
integer y = 36
integer width = 768
integer height = 64
end type

type st_11 from statictext within w_design_profile_menu
integer x = 3017
integer y = 4
integer width = 274
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Object Info"
boolean focusrectangle = false
end type

type r_8 from rectangle within w_design_profile_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 2373
integer y = 32
integer width = 279
integer height = 220
end type

type st_3 from statictext within w_design_profile_menu
integer x = 2432
integer y = 4
integer width = 174
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Border"
boolean focusrectangle = false
end type

type st_4 from statictext within w_design_profile_menu
integer x = 2432
integer y = 104
integer width = 155
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Off"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

