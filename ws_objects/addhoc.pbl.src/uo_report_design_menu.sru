$PBExportHeader$uo_report_design_menu.sru
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type uo_report_design_menu from u_base
end type
type st_sort from statictext within uo_report_design_menu
end type
type st_3 from statictext within uo_report_design_menu
end type
type st_4 from statictext within uo_report_design_menu
end type
type hsb_1 from hscrollbar within uo_report_design_menu
end type
type hsb_2 from hscrollbar within uo_report_design_menu
end type
type st_11 from statictext within uo_report_design_menu
end type
type st_xy from statictext within uo_report_design_menu
end type
type st_object_name from statictext within uo_report_design_menu
end type
type st_10 from statictext within uo_report_design_menu
end type
type st_9 from statictext within uo_report_design_menu
end type
type st_8 from statictext within uo_report_design_menu
end type
type st_6 from statictext within uo_report_design_menu
end type
type st_underline from statictext within uo_report_design_menu
end type
type st_italic from statictext within uo_report_design_menu
end type
type st_bold from statictext within uo_report_design_menu
end type
type st_right from statictext within uo_report_design_menu
end type
type st_center from statictext within uo_report_design_menu
end type
type st_left from statictext within uo_report_design_menu
end type
type st_relocate_field from statictext within uo_report_design_menu
end type
type dw_1 from datawindow within uo_report_design_menu
end type
type r_6 from rectangle within uo_report_design_menu
end type
type r_1 from rectangle within uo_report_design_menu
end type
type r_2 from rectangle within uo_report_design_menu
end type
type r_3 from rectangle within uo_report_design_menu
end type
type r_4 from rectangle within uo_report_design_menu
end type
type r_5 from rectangle within uo_report_design_menu
end type
type st_show_invisible from statictext within uo_report_design_menu
end type
type p_1 from picture within uo_report_design_menu
end type
type p_alignleft from picture within uo_report_design_menu
end type
type p_aligntop from picture within uo_report_design_menu
end type
type p_copysize from picture within uo_report_design_menu
end type
type st_5 from statictext within uo_report_design_menu
end type
type st_7 from statictext within uo_report_design_menu
end type
type st_2 from statictext within uo_report_design_menu
end type
type st_text from statictext within uo_report_design_menu
end type
type st_1 from statictext within uo_report_design_menu
end type
type st_tab_order from statictext within uo_report_design_menu
end type
end forward

global type uo_report_design_menu from u_base
integer width = 3767
integer height = 268
st_sort st_sort
st_3 st_3
st_4 st_4
hsb_1 hsb_1
hsb_2 hsb_2
st_11 st_11
st_xy st_xy
st_object_name st_object_name
st_10 st_10
st_9 st_9
st_8 st_8
st_6 st_6
st_underline st_underline
st_italic st_italic
st_bold st_bold
st_right st_right
st_center st_center
st_left st_left
st_relocate_field st_relocate_field
dw_1 dw_1
r_6 r_6
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
r_5 r_5
st_show_invisible st_show_invisible
p_1 p_1
p_alignleft p_alignleft
p_aligntop p_aligntop
p_copysize p_copysize
st_5 st_5
st_7 st_7
st_2 st_2
st_text st_text
st_1 st_1
st_tab_order st_tab_order
end type
global uo_report_design_menu uo_report_design_menu

forward prototypes
public subroutine of_setobjectenable (boolean ab_enable)
end prototypes

public subroutine of_setobjectenable (boolean ab_enable);int li_count,li_i
statictext lst_object
picture lp_object
hscrollbar lhs_object

li_count = upperbound(this.control)

for li_i = 1 to li_count
	if this.control[li_i].typeof() = statictext! then
		lst_object = this.control[li_i]
		lst_object.enabled = ab_enable
	elseif this.control[li_i].typeof() = picture! then
		lp_object = this.control[li_i]
		lp_object.enabled = ab_enable
//	elseif this.control[li_i].typeof() = hscrollbar! then
//		lhs_object = this.control[li_i]
//		lhs_object.visible = ab_enable
	end if
next
end subroutine

on uo_report_design_menu.create
int iCurrent
call super::create
this.st_sort=create st_sort
this.st_3=create st_3
this.st_4=create st_4
this.hsb_1=create hsb_1
this.hsb_2=create hsb_2
this.st_11=create st_11
this.st_xy=create st_xy
this.st_object_name=create st_object_name
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_6=create st_6
this.st_underline=create st_underline
this.st_italic=create st_italic
this.st_bold=create st_bold
this.st_right=create st_right
this.st_center=create st_center
this.st_left=create st_left
this.st_relocate_field=create st_relocate_field
this.dw_1=create dw_1
this.r_6=create r_6
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.r_5=create r_5
this.st_show_invisible=create st_show_invisible
this.p_1=create p_1
this.p_alignleft=create p_alignleft
this.p_aligntop=create p_aligntop
this.p_copysize=create p_copysize
this.st_5=create st_5
this.st_7=create st_7
this.st_2=create st_2
this.st_text=create st_text
this.st_1=create st_1
this.st_tab_order=create st_tab_order
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sort
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.hsb_1
this.Control[iCurrent+5]=this.hsb_2
this.Control[iCurrent+6]=this.st_11
this.Control[iCurrent+7]=this.st_xy
this.Control[iCurrent+8]=this.st_object_name
this.Control[iCurrent+9]=this.st_10
this.Control[iCurrent+10]=this.st_9
this.Control[iCurrent+11]=this.st_8
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.st_underline
this.Control[iCurrent+14]=this.st_italic
this.Control[iCurrent+15]=this.st_bold
this.Control[iCurrent+16]=this.st_right
this.Control[iCurrent+17]=this.st_center
this.Control[iCurrent+18]=this.st_left
this.Control[iCurrent+19]=this.st_relocate_field
this.Control[iCurrent+20]=this.dw_1
this.Control[iCurrent+21]=this.r_6
this.Control[iCurrent+22]=this.r_1
this.Control[iCurrent+23]=this.r_2
this.Control[iCurrent+24]=this.r_3
this.Control[iCurrent+25]=this.r_4
this.Control[iCurrent+26]=this.r_5
this.Control[iCurrent+27]=this.st_show_invisible
this.Control[iCurrent+28]=this.p_1
this.Control[iCurrent+29]=this.p_alignleft
this.Control[iCurrent+30]=this.p_aligntop
this.Control[iCurrent+31]=this.p_copysize
this.Control[iCurrent+32]=this.st_5
this.Control[iCurrent+33]=this.st_7
this.Control[iCurrent+34]=this.st_2
this.Control[iCurrent+35]=this.st_text
this.Control[iCurrent+36]=this.st_1
this.Control[iCurrent+37]=this.st_tab_order
end on

on uo_report_design_menu.destroy
call super::destroy
destroy(this.st_sort)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.hsb_1)
destroy(this.hsb_2)
destroy(this.st_11)
destroy(this.st_xy)
destroy(this.st_object_name)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_6)
destroy(this.st_underline)
destroy(this.st_italic)
destroy(this.st_bold)
destroy(this.st_right)
destroy(this.st_center)
destroy(this.st_left)
destroy(this.st_relocate_field)
destroy(this.dw_1)
destroy(this.r_6)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.r_5)
destroy(this.st_show_invisible)
destroy(this.p_1)
destroy(this.p_alignleft)
destroy(this.p_aligntop)
destroy(this.p_copysize)
destroy(this.st_5)
destroy(this.st_7)
destroy(this.st_2)
destroy(this.st_text)
destroy(this.st_1)
destroy(this.st_tab_order)
end on

type st_sort from statictext within uo_report_design_menu
integer x = 1120
integer y = 68
integer width = 265
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sort"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
if isvalid(w_report_data_design) then
	w_report_data_design.uo_design.Triggerevent('pfc_cst_sort')
end if
end event

type st_3 from statictext within uo_report_design_menu
integer x = 1129
integer y = 380
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Adjust Width"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within uo_report_design_menu
integer x = 1541
integer y = 380
integer width = 187
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Move "
alignment alignment = center!
boolean focusrectangle = false
end type

type hsb_1 from hscrollbar within uo_report_design_menu
integer x = 1129
integer y = 464
integer width = 357
integer height = 64
boolean bringtotop = true
end type

event constructor;This.MinPosition = 1
This.MaxPosition = 3
This.Position = 2
end event

event lineleft;w_report_data_design.uo_design.of_adjust_width( -25 )

end event

event lineright;w_report_data_design.uo_design.of_adjust_width( 25 )
end event

event pageleft;w_report_data_design.uo_design.of_adjust_width( -75 )
end event

event pageright;w_report_data_design.uo_design.of_adjust_width( 75 )
end event

type hsb_2 from hscrollbar within uo_report_design_menu
integer x = 1495
integer y = 464
integer width = 357
integer height = 64
boolean bringtotop = true
integer minposition = 3
integer maxposition = 1
integer position = 2
end type

event constructor;This.MinPosition = 1
This.MaxPosition = 3
This.Position = 2
end event

event lineleft;w_report_data_design.uo_design.of_adjust_position( -25 )


end event

event lineright;w_report_data_design.uo_design.of_adjust_position( 25 )


end event

event pageleft;w_report_data_design.uo_design.of_adjust_position( -75 )


end event

event pageright;w_report_data_design.uo_design.of_adjust_position( 75 )


end event

type st_11 from statictext within uo_report_design_menu
integer x = 3017
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
long backcolor = 67108864
boolean enabled = false
string text = "Object Info"
boolean focusrectangle = false
end type

type st_xy from statictext within uo_report_design_menu
integer x = 2958
integer y = 160
integer width = 759
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_object_name from statictext within uo_report_design_menu
integer x = 2958
integer y = 68
integer width = 759
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_10 from statictext within uo_report_design_menu
integer x = 59
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
long backcolor = 67108864
boolean enabled = false
string text = "Label Text"
boolean focusrectangle = false
end type

type st_9 from statictext within uo_report_design_menu
integer x = 2665
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

type st_8 from statictext within uo_report_design_menu
integer x = 2208
integer y = 4
integer width = 334
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
string text = "Text Properties"
boolean focusrectangle = false
end type

type st_6 from statictext within uo_report_design_menu
integer x = 933
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

type st_underline from statictext within uo_report_design_menu
integer x = 2459
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

event clicked;//Integer i
//String ls_syntax
//String ls_value
//
////<modify> 11/09/2007 by: Andy
//pfc_cst_u_band_report     ldw_Temp
//String   ls_Object,ls_type,ls_Err
//If w_report_data_design.uo_design.dw_properties.rowcount() < 1 Then Return  //Add by Jack 07.13.2007
//
//ldw_Temp  = w_report_data_design.wf_getband(w_report_data_design.is_CurBand)
//ls_Object = ldw_Temp.is_CurObj//w_report_data_design.uo_design.is_last_object[1]
//ls_type = ldw_Temp.Describe( ls_Object + ".type")
////end of add
//
//IF This.BorderStyle = StyleLowered! THEN
//	This.BorderStyle = StyleRaised!
//	ls_syntax = ".font.underline='0'"
//	ls_value = "0"
//	//<Modify> 06/22/2007 by: Andy Reason:fixed a bug BugG062101
//	if ls_type = 'compute' then
//		ls_Err = ldw_Temp.Modify(ls_Object + ls_syntax)
//		//<add> 11/09/2007 by: Andy
//		w_report_data_design.event ue_Setmodify(ls_Object + ls_syntax)
//		//w_report_data_design.uo_design.is_last_border[1] = 
//		return
//	else
//		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_required", 'N')
//	end if
//	//end of Modify
//ELSE
//	//<Modify> 06/22/2007 by: Andy Reason:fixed a bug BugG062101
//	if ls_type = 'compute' then
//		This.BorderStyle = StyleLowered!
//		ls_syntax = ".font.underline='1'"
//		ls_Err = ldw_Temp.Modify(ls_Object + ls_syntax)
//		//<add> 11/09/2007 by: Andy
//		w_report_data_design.event ue_Setmodify(ls_Object + ls_syntax)
//		return
//	else
//		integer res
//		res = messagebox("Underline Format","Only required fields are underlined.  Would you like to make this a required field?", question!,yesno!,1)
//		IF res = 2 THEN RETURN
//	
//		This.BorderStyle = StyleLowered!
//		ls_syntax = ".font.underline='1'"
//		ls_value = "1"
//	
//		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_required", 'Y')
//	end if
//	//end of modify
//END IF
//
////$<Modify> 2007-11-09 By: Andy
////w_report_data_design.uo_design.of_set_dw_properties("data_view_fields_required")
//ldw_Temp.of_set_dw_properties("data_view_fields_required")
////end of modify
//
////FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
////	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ls_syntax )
////	IF Right( w_report_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
////		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_required", 'Y')
////	ELSE
////		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_required", "1" )
////	END IF
////END FOR
Integer i
String ls_syntax
long	 ll_underline
string ls_col_name
string ls_font_style
long	 ll_find,ll_object_id

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.underline='0'"
	ll_underline=0
ELSE
	This.BorderStyle = StyleLowered!
	ls_syntax = ".font.underline='1'"
	ll_underline=1
	ls_font_style='U'
END IF

IF st_bold.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "B"
END IF
		
IF st_italic.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "I"
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ls_syntax)
	IF Right( w_report_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		//w_report_data_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "0" )
	ELSE
		//w_report_data_design.dw_properties.SetItem(1, "data_view_fields_justification", "0" )
	END IF
END FOR
*/

Long    ll_i,ll_Cnt
String ls_Modify
string  ls_Name
pfc_cst_u_band_report   ldw_band

if isValid(w_report_data_design) then
	ldw_band = w_report_data_design.wf_getband(w_report_data_design.is_CurBand)
	ls_Name = ldw_band.is_CurObj
	ll_Cnt = upperbound(w_report_data_design.istr_SelectObj)
	if ll_Cnt=0 then
		ls_Modify = ls_Name + ls_syntax
		ldw_band.Modify(ls_Modify)
		w_report_data_design.event ue_Setmodify(ls_Modify)		
	else
		FOR ll_i =  1 to ll_Cnt
			IF not isnull(w_report_data_design.istr_SelectObj[ll_i].FName) AND w_report_data_design.istr_SelectObj[ll_i].FName <> '' THEN
				ls_Modify = w_report_data_design.istr_SelectObj[ll_i].FName + ls_syntax
				w_report_data_design.istr_SelectObj[ll_i].FBand.Modify(ls_Modify)
				w_report_data_design.event ue_Setmodify(ls_Modify)
			end if
		next
	end if
end if

//---------------------------- APPEON END ----------------------------


end event

type st_italic from statictext within uo_report_design_menu
integer x = 2341
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
long	 ll_italic
string ls_col_name
string ls_font_style
long	 ll_find,ll_object_id

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.italic='0'"
	ll_italic=0
ELSE
	This.BorderStyle = StyleLowered!
	ls_syntax = ".font.italic='1'"
	ll_italic=1
	ls_font_style='I'
END IF

IF st_bold.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "B"
END IF
		
IF st_underline.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "U"
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ls_syntax)
	IF Right( w_report_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		//w_report_data_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "0" )
	ELSE
		//w_report_data_design.dw_properties.SetItem(1, "data_view_fields_justification", "0" )
	END IF
END FOR
*/

Long    ll_i,ll_Cnt
String ls_Modify
string  ls_Name
pfc_cst_u_band_report   ldw_band

if isValid(w_report_data_design) then
	ldw_band = w_report_data_design.wf_getband(w_report_data_design.is_CurBand)
	ls_Name = ldw_band.is_CurObj
	ll_Cnt = upperbound(w_report_data_design.istr_SelectObj)
	if ll_Cnt=0 then
		ls_Modify = ls_Name + ls_syntax
		ldw_band.Modify(ls_Modify)
		w_report_data_design.event ue_Setmodify(ls_Modify)		
	else
		FOR ll_i =  1 to ll_Cnt
			IF not isnull(w_report_data_design.istr_SelectObj[ll_i].FName) AND w_report_data_design.istr_SelectObj[ll_i].FName <> '' THEN
				ls_Modify = w_report_data_design.istr_SelectObj[ll_i].FName + ls_syntax
				w_report_data_design.istr_SelectObj[ll_i].FBand.Modify(ls_Modify)
				w_report_data_design.event ue_Setmodify(ls_Modify)
			end if
		next
	end if
end if

//---------------------------- APPEON END ----------------------------
end event

type st_bold from statictext within uo_report_design_menu
integer x = 2222
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
long	 ll_bold
string ls_col_name
string ls_font_style
long	 ll_find,ll_object_id

IF This.BorderStyle = StyleLowered! THEN
	This.BorderStyle = StyleRaised!
	ls_syntax = ".font.weight='400'"
	ll_bold = 400
	ls_font_style = 'N'
ELSE
	This.BorderStyle = StyleLowered!
	ls_syntax = ".font.weight='700'"
	ll_bold = 700
	ls_font_style = 'B'
END IF	
//
IF st_italic.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "I"
END IF
		
IF st_underline.BorderStyle = StyleLowered! THEN
	ls_font_style = ls_font_style + "U"
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ls_syntax )
	IF Right( w_report_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		//w_report_data_design.dw_properties.SetItem(1, "data_view_fields_label_justification", "0" )
	ELSE
		//w_report_data_design.dw_properties.SetItem(1, "data_view_fields_justification", "0" )
	END IF
END FOR
*/

Long    ll_i,ll_Cnt
String ls_Modify
string  ls_Name
pfc_cst_u_band_report   ldw_band

if isValid(w_report_data_design) then
	ldw_band = w_report_data_design.wf_getband(w_report_data_design.is_CurBand)
	ls_Name = ldw_band.is_CurObj
	ll_Cnt = upperbound(w_report_data_design.istr_SelectObj)
	if ll_Cnt=0 then
		ls_Modify = ls_Name + ls_syntax
		ldw_band.Modify(ls_Modify)
		w_report_data_design.event ue_Setmodify(ls_Modify)		
	else
		FOR ll_i =  1 to ll_Cnt
			IF not isnull(w_report_data_design.istr_SelectObj[ll_i].FName) AND w_report_data_design.istr_SelectObj[ll_i].FName <> '' THEN
				ls_Modify = w_report_data_design.istr_SelectObj[ll_i].FName + ls_syntax
				w_report_data_design.istr_SelectObj[ll_i].FBand.Modify(ls_Modify)
				w_report_data_design.event ue_Setmodify(ls_Modify)

				
			end if
		next
	end if
end if

//---------------------------- APPEON END ----------------------------

end event

type st_right from statictext within uo_report_design_menu
integer x = 2459
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

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[I] + ".alignment = '1'")
	IF Right( w_report_data_design.uo_design.is_last_object[I], 2) =  "_t" THEN
		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification", 1 )
	ELSE
		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", 1 )
	END IF
END FOR
*/

Long    ll_i,ll_Cnt
String ls_Modify
string  ls_Name
pfc_cst_u_band_report   ldw_band
long	  ll_align
long	  ll_find,ll_object_id
string  ls_col_name

if isValid(w_report_data_design) then
	ldw_band = w_report_data_design.wf_getband(w_report_data_design.is_CurBand)
	ls_Name = ldw_band.is_CurObj
	ll_Cnt = upperbound(w_report_data_design.istr_SelectObj)
	if ll_Cnt=0 then
		ls_Modify = ls_Name + ".alignment = '1'"
		ll_align=1
		ldw_band.Modify(ls_Modify)
		w_report_data_design.event ue_Setmodify(ls_Modify)		
	else
		FOR ll_i =  1 to ll_Cnt
			IF not isnull(w_report_data_design.istr_SelectObj[ll_i].FName) AND w_report_data_design.istr_SelectObj[ll_i].FName <> '' THEN
				ls_Modify = w_report_data_design.istr_SelectObj[ll_i].FName + ".alignment = '1'"
				w_report_data_design.istr_SelectObj[ll_i].FBand.Modify(ls_Modify)

//				IF Right( w_report_data_design.istr_SelectObj[ll_i].FName, 2) =  "_t" THEN
//					w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification", 1 )
//				ELSE
//					w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", 1 )
//				END IF
				
				w_report_data_design.event ue_Setmodify(ls_Modify)
			end if
		next
	end if
end if

//---------------------------- APPEON END ----------------------------
end event

type st_center from statictext within uo_report_design_menu
integer x = 2341
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

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ".alignment = '2'")
	IF Right( w_report_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification", 2 )
	ELSE
		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", 2 )
	END IF
END FOR
*/

Long    ll_i,ll_Cnt
String ls_Modify
string  ls_Name
pfc_cst_u_band_report   ldw_band
long	  ll_align
long	  ll_find,ll_object_id
string  ls_col_name

if isValid(w_report_data_design) then
	ldw_band = w_report_data_design.wf_getband(w_report_data_design.is_CurBand)
	ls_Name = ldw_band.is_CurObj
	ll_Cnt = upperbound(w_report_data_design.istr_SelectObj)
	if ll_Cnt=0 then
		ls_Modify = ls_Name + ".alignment = '2'"
		ll_align=2
		ldw_band.Modify(ls_Modify)
		w_report_data_design.event ue_Setmodify(ls_Modify)		
	else
		FOR ll_i =  1 to ll_Cnt
			IF not isnull(w_report_data_design.istr_SelectObj[ll_i].FName) AND w_report_data_design.istr_SelectObj[ll_i].FName <> '' THEN
				ls_Modify = w_report_data_design.istr_SelectObj[ll_i].FName + ".alignment = '2'"
				w_report_data_design.istr_SelectObj[ll_i].FBand.Modify(ls_Modify)
				
//				IF Right( w_report_data_design.istr_SelectObj[ll_i].FName, 2) =  "_t" THEN
//					w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification", 2 )
//				ELSE
//					w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", 2 )
//				END IF
				
				w_report_data_design.event ue_Setmodify(ls_Modify)
			end if
		next
	end if
end if

//---------------------------- APPEON END ----------------------------
end event

type st_left from statictext within uo_report_design_menu
integer x = 2222
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
	
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ".alignment = '0'")
	IF Right( w_report_data_design.uo_design.is_last_object[i], 2) =  "_t" THEN
		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification", 0 )
	ELSE
		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", 0 )
	END IF
END FOR
*/

Long    ll_i,ll_Cnt
String ls_Modify
string  ls_Name
pfc_cst_u_band_report   ldw_band
long	  ll_align
long	  ll_find,ll_object_id
string  ls_col_name

if isValid(w_report_data_design) then
	ldw_band = w_report_data_design.wf_getband(w_report_data_design.is_CurBand)
	ls_Name = ldw_band.is_CurObj
	ll_Cnt = upperbound(w_report_data_design.istr_SelectObj)
	if ll_Cnt=0 then
		ls_Modify = ls_Name + ".alignment = '0'"
		ll_align=0
		ldw_band.Modify(ls_Modify)
		w_report_data_design.event ue_Setmodify(ls_Modify)		
	else
		FOR ll_i =  1 to ll_Cnt
			IF not isnull(w_report_data_design.istr_SelectObj[ll_i].FName) AND w_report_data_design.istr_SelectObj[ll_i].FName <> '' THEN
				ls_Modify = w_report_data_design.istr_SelectObj[ll_i].FName + ".alignment = '0'"
				w_report_data_design.istr_SelectObj[ll_i].FBand.Modify(ls_Modify)
				
		
//				IF Right( w_report_data_design.istr_SelectObj[ll_i].FName, 2) =  "_t" THEN
//					w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_label_justification", 0 )
//				ELSE
//					w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_justification", 0 )
//				END IF
				
				w_report_data_design.event ue_Setmodify(ls_Modify)
			end if
		next
	end if
end if

//---------------------------- APPEON END ----------------------------
end event

type st_relocate_field from statictext within uo_report_design_menu
boolean visible = false
integer x = 1650
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

IF UpperBound(w_report_data_design.uo_design.is_last_object[]) = 0 THEN
	MessageBox("Error", "You must first select the fields you want to relocate.")
	Return
END IF

w_report_data_design.uo_design.ib_relocating_fields = True

end event

type dw_1 from datawindow within uo_report_design_menu
integer x = 37
integer y = 92
integer width = 786
integer height = 108
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_design_label_editor"
boolean border = false
boolean livescroll = true
end type

event editchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-15 By: Andy
pfc_cst_u_band_report ldw_band
String ls_Modify
long	 ll_find,ll_object_id
string ls_col_name

if isValid(w_report_data_design) then 
	ldw_band = w_report_data_design.wf_getband(w_report_data_design.is_curBand)
	if isNull(ldw_band.is_curobj) or ldw_band.is_curobj = "" then return
	
	//$<modify> 04.10.2008 by Andy
	//Reason:   fixed BugG041001,Issue 2 from Issues for Tracy.doc
	//ls_Modify = ldw_band.is_curobj + ".text = '" + data + "'"
	//$<modify> 04.17.2008 by nova
	//Reason:   fixed BugG
	ls_Modify = ldw_band.is_curobj + ".text = ~"" + data + "~""
	
	ldw_band.modify( ls_Modify )
	w_report_data_design.event ue_setModify(ls_Modify)
	
		//	if w_report_data_design.uo_design.dw_properties.GetRow() > 0 then 
		//		w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_field_label", data )
		//		//$<add> 03.26.2008 by Andy
		//		//$Reason:Auto set view fields alias
		//		ldw_band.of_set_dw_properties( "data_view_fields_field_label" )
		//	end if
	//end modify 04.10.2008
end if

/*
if upperbound(w_report_data_design.uo_design.is_last_object[]) < 1 then //maha 100404

else
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[1] + ".text = '" + data + "'")
	w_report_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_field_label", data )
end if
*/
//---------------------------- APPEON END ----------------------------

end event

event constructor;dw_1.insertrow(0)

end event

type r_6 from rectangle within uo_report_design_menu
integer linethickness = 4
long fillcolor = 80269524
integer x = 2926
integer y = 32
integer width = 818
integer height = 220
end type

type r_1 from rectangle within uo_report_design_menu
integer linethickness = 4
long fillcolor = 80269524
integer x = 841
integer y = 32
integer width = 567
integer height = 220
end type

type r_2 from rectangle within uo_report_design_menu
integer linethickness = 4
long fillcolor = 80269524
integer x = 1422
integer y = 32
integer width = 745
integer height = 220
end type

type r_3 from rectangle within uo_report_design_menu
integer linethickness = 4
long fillcolor = 80269524
integer x = 2181
integer y = 32
integer width = 443
integer height = 220
end type

type r_4 from rectangle within uo_report_design_menu
integer linethickness = 4
long fillcolor = 80269524
integer x = 2633
integer y = 32
integer width = 283
integer height = 220
end type

type r_5 from rectangle within uo_report_design_menu
integer linethickness = 4
long fillcolor = 80269524
integer x = 27
integer y = 36
integer width = 800
integer height = 212
end type

type st_show_invisible from statictext within uo_report_design_menu
integer x = 855
integer y = 148
integer width = 530
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
	w_report_data_design.uo_design.of_show_invisible( True )
	w_report_data_design.uo_design.ib_show_invisible = True
ELSE
	This.BorderStyle = StyleLowered!
	w_report_data_design.uo_design.of_show_invisible( False )
	w_report_data_design.uo_design.ib_show_invisible = False
END IF



end event

type p_1 from picture within uo_report_design_menu
integer x = 2784
integer y = 60
integer width = 110
integer height = 92
string picturename = "copyheight.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ".height = '" + String(w_report_data_design.uo_design.il_last_object_height[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	
*/

if isValid(w_report_data_design) then
	w_report_data_design.event ue_arrange('same_height')
end if
//---------------------------- APPEON END ----------------------------

end event

type p_alignleft from picture within uo_report_design_menu
integer x = 2784
integer y = 156
integer width = 110
integer height = 92
string picturename = "alignleft.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ".x = '" + String(w_report_data_design.uo_design.il_last_object_x[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	
*/

if isValid(w_report_data_design) then
	w_report_data_design.event ue_arrange('snap_to_left')
end if
//---------------------------- APPEON END ----------------------------

end event

type p_aligntop from picture within uo_report_design_menu
integer x = 2661
integer y = 156
integer width = 110
integer height = 92
string picturename = "aligntop.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ".y = '" + String(w_report_data_design.uo_design.il_last_object_y[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	
*/

if isValid(w_report_data_design) then
	w_report_data_design.event ue_arrange('snap_to_top')
end if
//---------------------------- APPEON END ----------------------------
end event

type p_copysize from picture within uo_report_design_menu
integer x = 2661
integer y = 60
integer width = 110
integer height = 92
string picturename = "copywidth.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	


FOR i = 1 TO w_report_data_design.uo_design.ii_obj_select_cnt
	w_report_data_design.uo_design.idw_detail.Modify( w_report_data_design.uo_design.is_last_object[i] + ".width = '" + w_report_data_design.uo_design.is_last_object_width + "'")
END FOR

This.BorderStyle = StyleRaised!	
*/

if isValid(w_report_data_design) then
	w_report_data_design.event ue_arrange('same_width')
end if
//---------------------------- APPEON END ----------------------------
end event

type st_5 from statictext within uo_report_design_menu
integer x = 1797
integer y = 148
integer width = 347
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Compute"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;////<add>      06/21/2007 by: Andy
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

////describe : create computer field
//Integer  li_object_no
//long     ll_scroll
//long     ll_y
//String   ls_obj_name,ls_modify,ls_Err
//String   ls_Expression
//str_pass lstr_pass,lstr_Ret
//u_dw     ldw_Temp
//
//ldw_Temp  = w_report_data_design.uo_design.idw_detail
//ll_scroll = Long(ldw_Temp.Object.DataWindow.VerticalScrollPosition)
//ll_y      = ll_scroll + 20
//
//if w_report_data_design.triggerevent("pfc_save") < 1 then return -1
////--------------------------- APPEON BEGIN ---------------------------
////$<Modify> 2007-10-29 By: Andy
////$<Reason> compute.name = compute_xx_c
//FOR li_object_no = 1 TO 1000
//	ls_obj_name = ldw_Temp.Describe("compute_" + String(li_object_no) + ".name")
//	IF lower(ls_obj_name) = "compute_" + String(li_object_no) + "_c" THEN CONTINUE
//
//	ls_modify = "create compute(band=detail expression='' border='0' color='0' x='20'" + &
//					" y='" + string(ll_y) + "' height='52' width='520' format='[GENERAL]' name=compute_" + String(li_object_no) + "_c" + " visible='1'" + &
//					" font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0'" + &
//					" background.mode='1' background.color='536870912' tag='' )"//background.mode='2' background.color='1073741824'
//	ls_Err    = ldw_Temp.Modify(ls_modify)	
//	ls_obj_name   = "compute_" + String(li_object_no) + "_c"
//	ls_Expression = ''
//	EXIT
//NEXT
////---------------------------- APPEON END ----------------------------
//
//lstr_pass.l_facility_id     = -1//-1:screen/else:export
//lstr_pass.s_string          = ls_Expression//expression
//lstr_pass.s_string_array[1] = ls_obj_name//object name
//lstr_pass.s_u_dw            = ldw_Temp//relative dw
//openwithparm(w_export_expression,lstr_pass)
//
//lstr_Ret = message.Powerobjectparm
////canceled
//if Not IsValid(lstr_Ret) or ISNULL(lstr_Ret) THEN 
//	ldw_Temp.Modify("destroy " + ls_obj_name)
//end if
////end of add

if isValid(w_report_data_design) then 
	w_report_data_design.event ue_new("compute")
end if
//---------------------------- APPEON END ----------------------------
end event

type st_7 from statictext within uo_report_design_menu
integer x = 1490
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
long backcolor = 67108864
boolean enabled = false
string text = "Objects"
boolean focusrectangle = false
end type

type st_2 from statictext within uo_report_design_menu
integer x = 1449
integer y = 148
integer width = 347
integer height = 80
boolean bringtotop = true
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

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

//Integer li_obj_id
//Integer li_found
//String ls_obj_id
//String ls_Type//<add> 06/21/2007 by: Andy
//
//if upperbound(w_report_data_design.uo_design.is_last_object) = 0 then return //maha 052005
////<add> 06/21/2007 by: Andy
//ls_Type = w_report_data_design.uo_design.idw_detail.describe(w_report_data_design.uo_design.is_last_object[1] + '.type')
//if isnull(ls_Type) then ls_Type = ''
////end of add
//IF Pos(w_report_data_design.uo_design.is_last_object[1], "object" ) > 0 or &
//	ls_Type = 'compute' THEN//<add> 06/21/2007 by: Andy
//	ls_obj_id = Mid(w_report_data_design.uo_design.is_last_object[1], 7,100)
//	IF Right( ls_obj_id, 2) = "_t" THEN
//		ls_obj_id = Mid(ls_obj_id, 1, Len(ls_obj_id) -2 )
//	END IF
//	w_report_data_design.uo_design.idw_detail.Modify("destroy " + w_report_data_design.uo_design.is_last_object[1] )
//ELSE
//	//MessageBox("Clear Error", "You can't delete field or field label objects.  To hide, make the Visible property in the propeties dialog box = No.")
//	MessageBox("Clear Error", "You can't delete field or field label objects.  To hide these objects, set the Visible property in the properties dialog box to No.")
//END IF

if isValid(w_report_data_design) then 
	w_report_data_design.event ue_modify('delete')
end if
//---------------------------- APPEON END ----------------------------
end event

type st_text from statictext within uo_report_design_menu
integer x = 1449
integer y = 68
integer width = 347
integer height = 80
boolean bringtotop = true
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

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy
//Integer li_object_no
//long ll_scroll
//long ll_y
//String ls_obj_name
//
//ll_scroll = Long(w_report_data_design.uo_design.idw_detail.Object.DataWindow.VerticalScrollPosition)
//ll_y = ll_scroll + 20
//
//if w_report_data_design.triggerevent("pfc_save") < 1 then return -1
//
//FOR li_object_no = 1 TO 1000
//	ls_obj_name = w_report_data_design.uo_design.idw_detail.Describe("object" + String(li_object_no) + "_t.name")
//	IF ls_obj_name = "object" + String(li_object_no) + "_t" THEN CONTINUE
//
//	w_report_data_design.uo_design.idw_detail.Modify("create text(band=detail text='text' border='0' color='0' x='20' y='" + string(ll_y) + "' height='52' width='150'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=object" + String(li_object_no) + "_t)"  )
//	EXIT
//NEXT

if isValid(w_report_data_design) then 
	w_report_data_design.event ue_new('text')
end if
//---------------------------- APPEON END ----------------------------
end event

type st_1 from statictext within uo_report_design_menu
integer x = 1797
integer y = 68
integer width = 347
integer height = 80
boolean bringtotop = true
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

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

//Integer li_object_no
//String ls_obj_name
//
//FOR li_object_no = 1 TO 1000
//	ls_obj_name = w_report_data_design.uo_design.idw_detail.Describe("object" + String(li_object_no) + ".name")
//	IF ls_obj_name = "object" + String(li_object_no) THEN CONTINUE
//
//	w_report_data_design.uo_design.idw_detail.Modify("create groupbox(band=detail text='none'border='5' color='128' x='20' y='20' height='390' width='660'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=object" + String(li_object_no) +")" )
//	EXIT
//NEXT

if isValid(w_report_data_design) then 
	w_report_data_design.event ue_new("groupbox")
end if
//---------------------------- APPEON END ----------------------------

end event

type st_tab_order from statictext within uo_report_design_menu
integer x = 855
integer y = 68
integer width = 265
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filter"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//w_report_data_design.ib_disable_activate = TRUE
//
//IF This.BorderStyle = StyleLowered! THEN
//	This.BorderStyle = StyleRaised!
//	w_report_data_design.uo_design.of_set_tab_order( False )
//ELSE
//	This.BorderStyle = StyleLowered!
//	w_report_data_design.uo_design.of_set_tab_order( True )
//END IF
//
//w_report_data_design.ib_disable_activate = FALSE


if isvalid(w_report_data_design) then
	w_report_data_design.uo_design.Triggerevent('pfc_cst_filter')
end if

end event

