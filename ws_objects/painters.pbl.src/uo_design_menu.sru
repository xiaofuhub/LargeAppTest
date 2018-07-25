$PBExportHeader$uo_design_menu.sru
$PBExportComments$Create by Jack.
forward
global type uo_design_menu from u_base
end type
type cb_alias from commandbutton within uo_design_menu
end type
type cb_report_view from commandbutton within uo_design_menu
end type
type r_6 from rectangle within uo_design_menu
end type
type st_width from statictext within uo_design_menu
end type
type pb_6 from picturebutton within uo_design_menu
end type
type pb_5 from picturebutton within uo_design_menu
end type
type pb_4 from picturebutton within uo_design_menu
end type
type pb_3 from picturebutton within uo_design_menu
end type
type pb_2 from picturebutton within uo_design_menu
end type
type pb_1 from picturebutton within uo_design_menu
end type
type st_11 from statictext within uo_design_menu
end type
type st_xy from statictext within uo_design_menu
end type
type st_object_name from statictext within uo_design_menu
end type
type st_10 from statictext within uo_design_menu
end type
type st_9 from statictext within uo_design_menu
end type
type st_8 from statictext within uo_design_menu
end type
type st_7 from statictext within uo_design_menu
end type
type st_6 from statictext within uo_design_menu
end type
type st_show_invisible from statictext within uo_design_menu
end type
type p_1 from picture within uo_design_menu
end type
type st_2 from statictext within uo_design_menu
end type
type st_1 from statictext within uo_design_menu
end type
type p_alignleft from picture within uo_design_menu
end type
type p_aligntop from picture within uo_design_menu
end type
type p_copysize from picture within uo_design_menu
end type
type st_underline from statictext within uo_design_menu
end type
type st_italic from statictext within uo_design_menu
end type
type st_bold from statictext within uo_design_menu
end type
type st_text from statictext within uo_design_menu
end type
type st_right from statictext within uo_design_menu
end type
type st_center from statictext within uo_design_menu
end type
type st_left from statictext within uo_design_menu
end type
type st_relocate_field from statictext within uo_design_menu
end type
type st_tab_order from statictext within uo_design_menu
end type
type dw_1 from datawindow within uo_design_menu
end type
type r_1 from rectangle within uo_design_menu
end type
type r_2 from rectangle within uo_design_menu
end type
type r_3 from rectangle within uo_design_menu
end type
type r_4 from rectangle within uo_design_menu
end type
type r_5 from rectangle within uo_design_menu
end type
end forward

global type uo_design_menu from u_base
integer width = 3607
integer height = 280
long backcolor = 33551856
cb_alias cb_alias
cb_report_view cb_report_view
r_6 r_6
st_width st_width
pb_6 pb_6
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
st_11 st_11
st_xy st_xy
st_object_name st_object_name
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_show_invisible st_show_invisible
p_1 p_1
st_2 st_2
st_1 st_1
p_alignleft p_alignleft
p_aligntop p_aligntop
p_copysize p_copysize
st_underline st_underline
st_italic st_italic
st_bold st_bold
st_text st_text
st_right st_right
st_center st_center
st_left st_left
st_relocate_field st_relocate_field
st_tab_order st_tab_order
dw_1 dw_1
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
r_5 r_5
end type
global uo_design_menu uo_design_menu

type variables
boolean ib_IsScreenChanged = false //Add by Evan 05.19.2009 --- Corrected BugG031002
integer ii_screen  //maha 10.10.2016
end variables

on uo_design_menu.create
int iCurrent
call super::create
this.cb_alias=create cb_alias
this.cb_report_view=create cb_report_view
this.r_6=create r_6
this.st_width=create st_width
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_11=create st_11
this.st_xy=create st_xy
this.st_object_name=create st_object_name
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_show_invisible=create st_show_invisible
this.p_1=create p_1
this.st_2=create st_2
this.st_1=create st_1
this.p_alignleft=create p_alignleft
this.p_aligntop=create p_aligntop
this.p_copysize=create p_copysize
this.st_underline=create st_underline
this.st_italic=create st_italic
this.st_bold=create st_bold
this.st_text=create st_text
this.st_right=create st_right
this.st_center=create st_center
this.st_left=create st_left
this.st_relocate_field=create st_relocate_field
this.st_tab_order=create st_tab_order
this.dw_1=create dw_1
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.r_5=create r_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_alias
this.Control[iCurrent+2]=this.cb_report_view
this.Control[iCurrent+3]=this.r_6
this.Control[iCurrent+4]=this.st_width
this.Control[iCurrent+5]=this.pb_6
this.Control[iCurrent+6]=this.pb_5
this.Control[iCurrent+7]=this.pb_4
this.Control[iCurrent+8]=this.pb_3
this.Control[iCurrent+9]=this.pb_2
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.st_11
this.Control[iCurrent+12]=this.st_xy
this.Control[iCurrent+13]=this.st_object_name
this.Control[iCurrent+14]=this.st_10
this.Control[iCurrent+15]=this.st_9
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.st_6
this.Control[iCurrent+19]=this.st_show_invisible
this.Control[iCurrent+20]=this.p_1
this.Control[iCurrent+21]=this.st_2
this.Control[iCurrent+22]=this.st_1
this.Control[iCurrent+23]=this.p_alignleft
this.Control[iCurrent+24]=this.p_aligntop
this.Control[iCurrent+25]=this.p_copysize
this.Control[iCurrent+26]=this.st_underline
this.Control[iCurrent+27]=this.st_italic
this.Control[iCurrent+28]=this.st_bold
this.Control[iCurrent+29]=this.st_text
this.Control[iCurrent+30]=this.st_right
this.Control[iCurrent+31]=this.st_center
this.Control[iCurrent+32]=this.st_left
this.Control[iCurrent+33]=this.st_relocate_field
this.Control[iCurrent+34]=this.st_tab_order
this.Control[iCurrent+35]=this.dw_1
this.Control[iCurrent+36]=this.r_1
this.Control[iCurrent+37]=this.r_2
this.Control[iCurrent+38]=this.r_3
this.Control[iCurrent+39]=this.r_4
this.Control[iCurrent+40]=this.r_5
end on

on uo_design_menu.destroy
call super::destroy
destroy(this.cb_alias)
destroy(this.cb_report_view)
destroy(this.r_6)
destroy(this.st_width)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_11)
destroy(this.st_xy)
destroy(this.st_object_name)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_show_invisible)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_alignleft)
destroy(this.p_aligntop)
destroy(this.p_copysize)
destroy(this.st_underline)
destroy(this.st_italic)
destroy(this.st_bold)
destroy(this.st_text)
destroy(this.st_right)
destroy(this.st_center)
destroy(this.st_left)
destroy(this.st_relocate_field)
destroy(this.st_tab_order)
destroy(this.dw_1)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.r_5)
end on

type cb_alias from commandbutton within uo_design_menu
integer x = 507
integer y = 176
integer width = 430
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Screen Label"
end type

event clicked;//Start Code Change ----10.10.2016.2016 #V152 maha - added
integer res
string s

s = string(w_prac_data_design.uo_design.ii_screen_id) + "*" + string(w_prac_data_design.uo_design.il_data_view_id)

openwithparm(w_screen_alias_set, s)

s = message.stringparm

res = integer (mid(s, 1,1))

s = mid(s, 3)

if res = 1 then
	if isvalid(w_prac_data_design.uo_design) then
		w_prac_data_design.uo_design.dw_select_section.setitem(w_prac_data_design.uo_design.dw_select_section.getrow() , "screen_alias", s )
	end if
end if


end event

type cb_report_view from commandbutton within uo_design_menu
integer x = 27
integer y = 176
integer width = 471
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "iReport View Alias"
end type

event clicked;open(w_view_alias_maintenance)
end event

type r_6 from rectangle within uo_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 2958
integer y = 32
integer width = 613
integer height = 220
end type

type st_width from statictext within uo_design_menu
integer x = 2994
integer y = 324
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
long backcolor = 32891346
boolean enabled = false
boolean focusrectangle = false
end type

type pb_6 from picturebutton within uo_design_menu
integer x = 2423
integer y = 376
integer width = 119
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Underline!"
boolean map3dcolors = true
end type

type pb_5 from picturebutton within uo_design_menu
integer x = 2304
integer y = 376
integer width = 119
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Italic!"
boolean map3dcolors = true
end type

type pb_4 from picturebutton within uo_design_menu
integer x = 2185
integer y = 376
integer width = 119
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Bold!"
boolean map3dcolors = true
end type

type pb_3 from picturebutton within uo_design_menu
integer x = 2432
integer y = 456
integer width = 119
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "AlignRight!"
boolean map3dcolors = true
end type

type pb_2 from picturebutton within uo_design_menu
integer x = 2309
integer y = 452
integer width = 119
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "AlignVCenter!"
boolean map3dcolors = true
end type

type pb_1 from picturebutton within uo_design_menu
integer x = 2190
integer y = 452
integer width = 119
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "AlignLeft!"
boolean map3dcolors = true
end type

type st_11 from statictext within uo_design_menu
integer x = 3003
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
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Object Info"
boolean focusrectangle = false
end type

type st_xy from statictext within uo_design_menu
integer x = 2994
integer y = 116
integer width = 512
integer height = 116
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

type st_object_name from statictext within uo_design_menu
integer x = 2994
integer y = 60
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
boolean focusrectangle = false
end type

type st_10 from statictext within uo_design_menu
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
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Label Text"
boolean focusrectangle = false
end type

type st_9 from statictext within uo_design_menu
integer x = 2661
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
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Size/Align"
boolean focusrectangle = false
end type

type st_8 from statictext within uo_design_menu
integer x = 2149
integer y = 4
integer width = 357
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Text Properties"
boolean focusrectangle = false
end type

type st_7 from statictext within uo_design_menu
integer x = 1509
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
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Objects"
boolean focusrectangle = false
end type

type st_6 from statictext within uo_design_menu
integer x = 1015
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
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Edit"
boolean focusrectangle = false
end type

type st_show_invisible from statictext within uo_design_menu
integer x = 1019
integer y = 148
integer width = 370
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
	w_prac_data_design.uo_design.of_show_invisible( True )
	w_prac_data_design.uo_design.ib_show_invisible = True
ELSE
	This.BorderStyle = StyleLowered!
	w_prac_data_design.uo_design.of_show_invisible( False )
	w_prac_data_design.uo_design.ib_show_invisible = False
END IF



end event

type p_1 from picture within uo_design_menu
integer x = 2775
integer y = 56
integer width = 110
integer height = 92
string picturename = "copyheight.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ".height = '" + String(w_prac_data_design.uo_design.il_last_object_height[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	



end event

type st_2 from statictext within uo_design_menu
integer x = 1513
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

if upperbound(w_prac_data_design.uo_design.is_last_object) = 0 then return //maha 052005

IF PosA(w_prac_data_design.uo_design.is_last_object[1], "object" ) > 0 THEN
	ls_obj_id = MidA(w_prac_data_design.uo_design.is_last_object[1], 7,100)
	IF RightA( ls_obj_id, 2) = "_t" THEN
		ls_obj_id = MidA(ls_obj_id, 1, LenA(ls_obj_id) -2 )
	END IF
	w_prac_data_design.uo_design.idw_detail.Modify("destroy " + w_prac_data_design.uo_design.is_last_object[1] )
	li_found = w_prac_data_design.uo_design.dw_screen_objects.Find( "data_view_object_id = " + ls_obj_id, 1, 1000 )
	w_prac_data_design.uo_design.dw_screen_objects.DeleteRow( li_found )
ELSE
	MessageBox("Clear Error", "You can't delete field or field label objects.  To hide, make the Visible property in the propeties dialog box = No.")
END IF
end event

type st_1 from statictext within uo_design_menu
integer x = 1769
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

if w_prac_data_design.triggerevent("pfc_save") < 1 then return -1

li_nr = w_prac_data_design.uo_design.dw_screen_objects.InsertRow(0)

SELECT Max(data_view_screen_objects.data_view_object_id)  
INTO :li_object_no  
FROM data_view_screen_objects;  
//WHERE ( data_view_screen_objects.data_view_id = :w_prac_data_design.uo_design.il_data_view_id ); //removed 010203 maha not part of primary key.

		
IF IsNull(li_object_no) THEN
	li_object_no = 0
END IF

li_object_no ++

w_prac_data_design.uo_design.idw_detail.Modify("create groupbox(band=detail text='none'border='5' color='128' x='20' y='20' height='390' width='660'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=object" + String(li_object_no) +")" )

w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "data_view_object_id", li_object_no)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "data_view_id", w_prac_data_design.uo_design.il_data_view_id )
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "screen_id", w_prac_data_design.uo_design.ii_screen_id)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_type", "B")
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_x", 20)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_y", 20)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_width", 660)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_height", 390)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_text", "none")
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_alignment", 0)



end event

type p_alignleft from picture within uo_design_menu
integer x = 2775
integer y = 152
integer width = 110
integer height = 92
string picturename = "alignleft.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ".x = '" + String(w_prac_data_design.uo_design.il_last_object_x[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	



end event

type p_aligntop from picture within uo_design_menu
integer x = 2656
integer y = 152
integer width = 110
integer height = 92
string picturename = "aligntop.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ".y = '" + String(w_prac_data_design.uo_design.il_last_object_y[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	



end event

type p_copysize from picture within uo_design_menu
integer x = 2656
integer y = 56
integer width = 110
integer height = 92
string picturename = "copywidth.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	


FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ".width = '" + w_prac_data_design.uo_design.is_last_object_width + "'")
END FOR

This.BorderStyle = StyleRaised!	



end event

type st_underline from statictext within uo_design_menu
integer x = 2405
integer y = 64
integer width = 119
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 33554432
long backcolor = 67108864
string text = "U"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i, j
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

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-08-30 By: Liu HongXin
//$<reason> 
/*
//FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
//	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ls_syntax )
//	IF Right( w_prac_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
//		w_prac_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification",  )
//	ELSE
//		w_prac_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", "1" )
//	END IF
//END FOR
*/
FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ls_syntax )
	IF RightA( w_prac_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_label_underline",  ls_value)
	ELSEIF LeftA( w_prac_data_design.uo_design.is_last_object[i], 6) = "object" THEN
		j++
		w_prac_data_design.uo_design.dw_screen_objects.SetItem(j, "object_underline", Long(ls_value))
	ELSE
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_field_underline", ls_value )
	END IF
END FOR
//---------------------------- APPEON END ----------------------------

ib_IsScreenChanged = true //Add by Evan 05.19.2009 --- Corrected BugG031002
end event

type st_italic from statictext within uo_design_menu
integer x = 2286
integer y = 64
integer width = 119
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "I"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;Integer i, j
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-08-30 By: Liu HongXin
//$<reason> Because no column, couldn't save to db.
/*
String ls_syntax

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.italic='0'"
ELSE
	IF Right( w_prac_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		//w_prac_data_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "0" )
	ELSE
		//w_prac_data_design.dw_properties.SetItem(1, "data_view_fields_justification", "0" )
	END IF
END FOR
*/
String ls_syntax, ls_value

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.italic='0'"
	ls_value = "0"
ELSE
	This.BorderStyle = StyleLowered!
	ls_syntax = ".font.italic='1'"
	ls_value = "1"
END IF

FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ls_syntax)
	IF RightA( w_prac_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		//w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_label_justification", ls_value )
	ELSEIF LeftA( w_prac_data_design.uo_design.is_last_object[i], 6) = "object" THEN
		j++
		w_prac_data_design.uo_design.dw_screen_objects.SetItem(j, "object_italic", Long(ls_value))
	ELSE
		//w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_justification", ls_value )
	END IF
END FOR
//---------------------------- APPEON END ----------------------------

ib_IsScreenChanged = true //Add by Evan 05.19.2009 --- Corrected BugG031002

end event

type st_bold from statictext within uo_design_menu
integer x = 2162
integer y = 64
integer width = 119
integer height = 80
integer textsize = -8
integer weight = 700
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

event clicked;Integer i, j
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-08-30 By: Liu HongXin
//$<reason> 
/*
String ls_syntax

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.weight='400'"
ELSE
	IF Right( w_prac_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		//w_prac_data_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "0" )
	ELSE
		//w_prac_data_design.dw_properties.SetItem(1, "data_view_fields_justification", "0" )
	END IF
END FOR
*/
String ls_syntax
Long ll_value

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.weight='400'"
	ll_value = 400
ELSE
	This.BorderStyle = StyleLowered!
	ls_syntax = ".font.weight='700'"
	ll_value = 700
END IF

FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ls_syntax )
	IF RightA( w_prac_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_font_wieght", ll_value )
	ELSEIF LeftA( w_prac_data_design.uo_design.is_last_object[i], 6) = "object" THEN
		j ++
		w_prac_data_design.uo_design.dw_screen_objects.SetItem(j, "object_bold", ll_value)
	ELSE
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_font_wieght", ll_value )
	END IF
END FOR
//---------------------------- APPEON END ----------------------------

ib_IsScreenChanged = true //Add by Evan 05.19.2009 --- Corrected BugG031002

end event

type st_text from statictext within uo_design_menu
integer x = 1513
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

event clicked;//maha app081005 updated all from 4.5
Integer li_nr
Integer li_object_no
long ll_scroll
long ll_y

ll_scroll = Long(w_prac_data_design.uo_design.idw_detail.Object.DataWindow.VerticalScrollPosition)
ll_y = ll_scroll + 20

if w_prac_data_design.triggerevent("pfc_save") < 1 then return -1

li_nr = w_prac_data_design.uo_design.dw_screen_objects.InsertRow(0)

SELECT Max(data_view_screen_objects.data_view_object_id)  
INTO :li_object_no  
FROM data_view_screen_objects;  
//WHERE ( data_view_screen_objects.data_view_id = :w_prac_data_design.uo_design.il_data_view_id );

		
IF IsNull(li_object_no) THEN
	li_object_no = 0
END IF

li_object_no ++
w_prac_data_design.uo_design.idw_detail.Modify("create text(band=detail text='text' border='0' color='0' x='20' y='" + string(ll_y) + "' height='52' width='150'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=object" + String(li_object_no) + "_t)"  )

w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "data_view_object_id", li_object_no)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "data_view_id", w_prac_data_design.uo_design.il_data_view_id )
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "screen_id", w_prac_data_design.uo_design.ii_screen_id)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_type", "T")
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_x", 20)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_y", ll_y) //maha 052405
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_width", 660)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_height", 390)
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_text", "none")
w_prac_data_design.uo_design.dw_screen_objects.SetItem(li_nr, "object_alignment", 0)

end event

type st_right from statictext within uo_design_menu
integer x = 2405
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

event clicked;Integer i, j

This.BorderStyle = StyleLowered!
st_center.BorderStyle = StyleRaised!
st_left.BorderStyle = StyleRaised!

FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[I] + ".alignment = '1'")
	IF RightA( w_prac_data_design.uo_design.is_last_object[I], 2) =  "_t" THEN
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_label_justification", "1" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> fix defect: save a stand-alone text object to database.
	ELSEIF LeftA( w_prac_data_design.uo_design.is_last_object[i], 6) = "object" THEN
		j++
		w_prac_data_design.uo_design.dw_screen_objects.SetItem(j, "object_alignment", "1")
	//---------------------------- APPEON END ----------------------------
	ELSE
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_justification", "1" )
	END IF
END FOR

ib_IsScreenChanged = true //Add by Evan 05.19.2009 --- Corrected BugG031002
end event

type st_center from statictext within uo_design_menu
integer x = 2286
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

event clicked;Integer i, j

This.BorderStyle = StyleLowered!
st_left.BorderStyle = StyleRaised!
st_right.BorderStyle = StyleRaised!


FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ".alignment = '2'")
	IF RightA( w_prac_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_label_justification", "2" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> fix defect: save a stand-alone text object to database.
	ELSEIF LeftA( w_prac_data_design.uo_design.is_last_object[i], 6) = "object" THEN
		j++
		w_prac_data_design.uo_design.dw_screen_objects.SetItem(j, "object_alignment", "2")
	//---------------------------- APPEON END ----------------------------
	ELSE
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_justification", "2" )
	END IF
END FOR

ib_IsScreenChanged = true //Add by Evan 05.19.2009 --- Corrected BugG031002
end event

type st_left from statictext within uo_design_menu
integer x = 2167
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

event clicked;Integer i, j

This.BorderStyle = StyleLowered!
st_center.BorderStyle = StyleRaised!
st_right.BorderStyle = StyleRaised!
	

FOR i = 1 TO w_prac_data_design.uo_design.ii_obj_select_cnt
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[i] + ".alignment = '0'")
	IF RightA( w_prac_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_label_justification", "0" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> fix defect: save a stand-alone text object to database.
	ELSEIF LeftA( w_prac_data_design.uo_design.is_last_object[i], 6) = "object" THEN
		j++
		w_prac_data_design.uo_design.dw_screen_objects.SetItem(j, "object_alignment", "0")
	//---------------------------- APPEON END ----------------------------
	ELSE
		w_prac_data_design.uo_design.dw_properties.SetItem(i - j, "data_view_fields_justification", "0" )
	END IF
END FOR

ib_IsScreenChanged = true //Add by Evan 05.19.2009 --- Corrected BugG031002
end event

type st_relocate_field from statictext within uo_design_menu
boolean visible = false
integer x = 1714
integer width = 357
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
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

type st_tab_order from statictext within uo_design_menu
integer x = 1019
integer y = 68
integer width = 370
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

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.09.2006 By: LeiWei
//$<reason> Performance tuning
w_prac_data_design.ib_disable_activate = TRUE
//---------------------------- APPEON END ----------------------------

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	w_prac_data_design.uo_design.of_set_tab_order( False )
ELSE
	This.BorderStyle = StyleLowered!
	w_prac_data_design.uo_design.of_set_tab_order( True )
END IF


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.09.2006 By: LeiWei
//$<reason> Performance tuning
w_prac_data_design.ib_disable_activate = FALSE
//---------------------------- APPEON END ----------------------------

end event

type dw_1 from datawindow within uo_design_menu
integer x = 82
integer y = 60
integer width = 768
integer height = 80
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_design_label_editor"
boolean border = false
boolean livescroll = true
end type

event editchanged;if upperbound(w_prac_data_design.uo_design.is_last_object[]) < 1 then //maha 100404

else
	w_prac_data_design.uo_design.idw_detail.Modify( w_prac_data_design.uo_design.is_last_object[1] + ".text = '" + data + "'")
	w_prac_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_field_label", data )
	
	//$<add> 03.26.2008 by Andy
	//$Reason:Auto set view fields alias if find out.
	String ls_field
	Long   ll_Cnt, ll_R=0
	if w_prac_data_design.uo_design.dw_properties.rowcount() < 1 then return //(Appeon)Stephen 06.30.2014 - bug 4090 : Issues found after Go-Live
	
	ls_field = w_prac_data_design.uo_design.dw_properties.GetItemString(1,"sys_fields_field_name")
	
	ll_Cnt = w_prac_data_design.uo_design.dw_fields_alias.RowCount( )
	DO WHILE (1=1)
		ll_R = w_prac_data_design.uo_design.dw_fields_alias.Find("c_name='" + ls_field + "'",ll_R,ll_Cnt)
		if ll_R < 1 then EXIT
		
		w_prac_data_design.uo_design.dw_fields_alias.SetItem(ll_R,"c_alias",LeftA(data,255))
		ll_R ++
		if ll_R > ll_Cnt THEN EXIT
	LOOP
	//End Add 03.26.2008
end if

end event

event constructor;dw_1.InsertRow( 0 )

end event

type r_1 from rectangle within uo_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 983
integer y = 32
integer width = 443
integer height = 220
end type

type r_2 from rectangle within uo_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 1472
integer y = 32
integer width = 599
integer height = 220
end type

type r_3 from rectangle within uo_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 2121
integer y = 32
integer width = 443
integer height = 220
end type

type r_4 from rectangle within uo_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 2629
integer y = 32
integer width = 283
integer height = 220
end type

type r_5 from rectangle within uo_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 37
integer y = 36
integer width = 887
integer height = 124
end type

