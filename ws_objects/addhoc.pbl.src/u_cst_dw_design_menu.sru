$PBExportHeader$u_cst_dw_design_menu.sru
forward
global type u_cst_dw_design_menu from u_base
end type
type em_font from editmask within u_cst_dw_design_menu
end type
type st_1 from statictext within u_cst_dw_design_menu
end type
type pb_delete from picturebutton within u_cst_dw_design_menu
end type
type pb_sort from picturebutton within u_cst_dw_design_menu
end type
type pb_picture from picturebutton within u_cst_dw_design_menu
end type
type pb_oval from picturebutton within u_cst_dw_design_menu
end type
type pb_groupbox from picturebutton within u_cst_dw_design_menu
end type
type p_aligntop from picture within u_cst_dw_design_menu
end type
type p_copysize from picture within u_cst_dw_design_menu
end type
type st_11 from statictext within u_cst_dw_design_menu
end type
type st_xy from statictext within u_cst_dw_design_menu
end type
type st_object_name from statictext within u_cst_dw_design_menu
end type
type st_10 from statictext within u_cst_dw_design_menu
end type
type st_9 from statictext within u_cst_dw_design_menu
end type
type st_8 from statictext within u_cst_dw_design_menu
end type
type st_6 from statictext within u_cst_dw_design_menu
end type
type st_underline from statictext within u_cst_dw_design_menu
end type
type st_italic from statictext within u_cst_dw_design_menu
end type
type st_bold from statictext within u_cst_dw_design_menu
end type
type st_right from statictext within u_cst_dw_design_menu
end type
type st_center from statictext within u_cst_dw_design_menu
end type
type st_left from statictext within u_cst_dw_design_menu
end type
type st_relocate_field from statictext within u_cst_dw_design_menu
end type
type dw_1 from datawindow within u_cst_dw_design_menu
end type
type r_6 from rectangle within u_cst_dw_design_menu
end type
type r_1 from rectangle within u_cst_dw_design_menu
end type
type r_2 from rectangle within u_cst_dw_design_menu
end type
type r_3 from rectangle within u_cst_dw_design_menu
end type
type r_4 from rectangle within u_cst_dw_design_menu
end type
type p_1 from picture within u_cst_dw_design_menu
end type
type p_alignleft from picture within u_cst_dw_design_menu
end type
type st_7 from statictext within u_cst_dw_design_menu
end type
type st_tab_order from statictext within u_cst_dw_design_menu
end type
type st_copysize from statictext within u_cst_dw_design_menu
end type
type st_aligntop from statictext within u_cst_dw_design_menu
end type
type st_12 from statictext within u_cst_dw_design_menu
end type
type st_alignleft from statictext within u_cst_dw_design_menu
end type
type r_5 from rectangle within u_cst_dw_design_menu
end type
type pb_column from picturebutton within u_cst_dw_design_menu
end type
type pb_text from picturebutton within u_cst_dw_design_menu
end type
type pb_compute from picturebutton within u_cst_dw_design_menu
end type
type st_3 from statictext within u_cst_dw_design_menu
end type
type st_show_invisible from statictext within u_cst_dw_design_menu
end type
type st_4 from statictext within u_cst_dw_design_menu
end type
type hsb_1 from hscrollbar within u_cst_dw_design_menu
end type
type hsb_2 from hscrollbar within u_cst_dw_design_menu
end type
type r_7 from rectangle within u_cst_dw_design_menu
end type
end forward

global type u_cst_dw_design_menu from u_base
integer width = 3616
integer height = 288
long backcolor = 33551856
em_font em_font
st_1 st_1
pb_delete pb_delete
pb_sort pb_sort
pb_picture pb_picture
pb_oval pb_oval
pb_groupbox pb_groupbox
p_aligntop p_aligntop
p_copysize p_copysize
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
p_1 p_1
p_alignleft p_alignleft
st_7 st_7
st_tab_order st_tab_order
st_copysize st_copysize
st_aligntop st_aligntop
st_12 st_12
st_alignleft st_alignleft
r_5 r_5
pb_column pb_column
pb_text pb_text
pb_compute pb_compute
st_3 st_3
st_show_invisible st_show_invisible
st_4 st_4
hsb_1 hsb_1
hsb_2 hsb_2
r_7 r_7
end type
global u_cst_dw_design_menu u_cst_dw_design_menu

type variables
u_cst_dw_design inv_data_design

String	is_CurObj
Boolean	ib_HasModify

end variables

forward prototypes
public subroutine of_setobjectenable (boolean ab_enable)
public function integer of_set_parentobject (u_cst_dw_design anv_data_design)
public subroutine of_alignselobjs (long al_align)
public subroutine of_modifyselobjsattr (string as_proexp)
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

public function integer of_set_parentobject (u_cst_dw_design anv_data_design);//add by gavin on 2009-03-04
inv_data_design = anv_data_design
return 1
end function

public subroutine of_alignselobjs (long al_align);//====================================================================
// Function: of_AlignSelObjs()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_Align
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long		ll_Cycle,ll_TotalCnts,ll_SelObjCnts
String	ls_ObjName,ls_Modify,ls_Type,ls_Field_id

if IsValid(inv_data_design) then
	ll_SelObjCnts = inv_data_design.of_GetSelectedObjectCnts()
	if ll_SelObjCnts <= 0 then Return
	
	ll_TotalCnts = UpperBound(inv_data_design.istr_SelectObj)
	for ll_Cycle = 1 to ll_TotalCnts
		ls_ObjName = inv_data_design.istr_SelectObj[ll_Cycle].FName
		if Not IsNull(ls_ObjName) and ls_ObjName <> '' then
			ls_Modify = ls_ObjName + ".alignment = '" + String(al_Align) + "'"
			inv_data_design.istr_SelectObj[ll_Cycle].FBand.Modify(ls_Modify)
			inv_data_design.Event ue_Setmodify(ls_Modify)
			
			ls_Type = inv_Data_Design.of_GetSelectedObjectType(ls_ObjName)
			if ls_Type = "column" or ls_Type = "text" and LeftA(lower(ls_ObjName),LenA("object")) <> "object" then
				if ls_Type = "column" then
					ls_Field_id = inv_Data_Design.of_GetSelectedObjectID(ls_ObjName)
				else
					if RightA(ls_ObjName, 2) = "_t" then
						ls_Field_id = inv_Data_Design.of_GetSelectedObjectTag(ls_ObjName)
					end if
				end if
				
				if IsNull(ls_Field_id) or Trim(ls_Field_id) = "" or ls_Field_id = '!' or ls_Field_id = '?' or Not IsNumber(ls_Field_id) then Continue
				
				inv_Data_Design.dw_Properties.SetFilter("data_view_fields_field_id = " + ls_Field_id)
				inv_Data_Design.dw_Properties.Filter()
				if inv_Data_Design.dw_Properties.RowCount() <= 0 Then Continue
				
				if ls_Type = "column" then
					inv_data_design.dw_properties.SetItem(1,"data_view_fields_justification",al_Align)
				else
					inv_data_design.dw_properties.SetItem(1,"data_view_fields_label_justification",al_Align)
				end if
				inv_data_design.dw_properties.AcceptText()
			end if
		end if
	next
end if

end subroutine

public subroutine of_modifyselobjsattr (string as_proexp);//====================================================================
// Function: of_ModifySelObjsAttr()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ProExp
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long		ll_Cycle,ll_TotalCnts,ll_SelObjCnts
String	ls_ObjName,ls_Modify

as_ProExp = Trim(as_ProExp)
if LeftA(as_ProExp,1) <> "." then as_ProExp = "." + as_ProExp

if IsValid(inv_data_design) then
	ll_SelObjCnts = inv_data_design.of_GetSelectedObjectCnts()
	if ll_SelObjCnts <= 0 then Return
	
	ll_TotalCnts = UpperBound(inv_data_design.istr_SelectObj)
	for ll_Cycle = 1 to ll_TotalCnts
		ls_ObjName = inv_data_design.istr_SelectObj[ll_Cycle].FName
		if Not IsNull(ls_ObjName) and ls_ObjName <> '' then
			ls_Modify = ls_ObjName + as_ProExp
			inv_data_design.istr_SelectObj[ll_Cycle].FBand.Modify(ls_Modify)
			inv_data_design.Event ue_Setmodify(ls_Modify)
		end if
	next
end if

end subroutine

on u_cst_dw_design_menu.create
int iCurrent
call super::create
this.em_font=create em_font
this.st_1=create st_1
this.pb_delete=create pb_delete
this.pb_sort=create pb_sort
this.pb_picture=create pb_picture
this.pb_oval=create pb_oval
this.pb_groupbox=create pb_groupbox
this.p_aligntop=create p_aligntop
this.p_copysize=create p_copysize
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
this.p_1=create p_1
this.p_alignleft=create p_alignleft
this.st_7=create st_7
this.st_tab_order=create st_tab_order
this.st_copysize=create st_copysize
this.st_aligntop=create st_aligntop
this.st_12=create st_12
this.st_alignleft=create st_alignleft
this.r_5=create r_5
this.pb_column=create pb_column
this.pb_text=create pb_text
this.pb_compute=create pb_compute
this.st_3=create st_3
this.st_show_invisible=create st_show_invisible
this.st_4=create st_4
this.hsb_1=create hsb_1
this.hsb_2=create hsb_2
this.r_7=create r_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_font
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.pb_delete
this.Control[iCurrent+4]=this.pb_sort
this.Control[iCurrent+5]=this.pb_picture
this.Control[iCurrent+6]=this.pb_oval
this.Control[iCurrent+7]=this.pb_groupbox
this.Control[iCurrent+8]=this.p_aligntop
this.Control[iCurrent+9]=this.p_copysize
this.Control[iCurrent+10]=this.st_11
this.Control[iCurrent+11]=this.st_xy
this.Control[iCurrent+12]=this.st_object_name
this.Control[iCurrent+13]=this.st_10
this.Control[iCurrent+14]=this.st_9
this.Control[iCurrent+15]=this.st_8
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.st_underline
this.Control[iCurrent+18]=this.st_italic
this.Control[iCurrent+19]=this.st_bold
this.Control[iCurrent+20]=this.st_right
this.Control[iCurrent+21]=this.st_center
this.Control[iCurrent+22]=this.st_left
this.Control[iCurrent+23]=this.st_relocate_field
this.Control[iCurrent+24]=this.dw_1
this.Control[iCurrent+25]=this.r_6
this.Control[iCurrent+26]=this.r_1
this.Control[iCurrent+27]=this.r_2
this.Control[iCurrent+28]=this.r_3
this.Control[iCurrent+29]=this.r_4
this.Control[iCurrent+30]=this.p_1
this.Control[iCurrent+31]=this.p_alignleft
this.Control[iCurrent+32]=this.st_7
this.Control[iCurrent+33]=this.st_tab_order
this.Control[iCurrent+34]=this.st_copysize
this.Control[iCurrent+35]=this.st_aligntop
this.Control[iCurrent+36]=this.st_12
this.Control[iCurrent+37]=this.st_alignleft
this.Control[iCurrent+38]=this.r_5
this.Control[iCurrent+39]=this.pb_column
this.Control[iCurrent+40]=this.pb_text
this.Control[iCurrent+41]=this.pb_compute
this.Control[iCurrent+42]=this.st_3
this.Control[iCurrent+43]=this.st_show_invisible
this.Control[iCurrent+44]=this.st_4
this.Control[iCurrent+45]=this.hsb_1
this.Control[iCurrent+46]=this.hsb_2
this.Control[iCurrent+47]=this.r_7
end on

on u_cst_dw_design_menu.destroy
call super::destroy
destroy(this.em_font)
destroy(this.st_1)
destroy(this.pb_delete)
destroy(this.pb_sort)
destroy(this.pb_picture)
destroy(this.pb_oval)
destroy(this.pb_groupbox)
destroy(this.p_aligntop)
destroy(this.p_copysize)
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
destroy(this.p_1)
destroy(this.p_alignleft)
destroy(this.st_7)
destroy(this.st_tab_order)
destroy(this.st_copysize)
destroy(this.st_aligntop)
destroy(this.st_12)
destroy(this.st_alignleft)
destroy(this.r_5)
destroy(this.pb_column)
destroy(this.pb_text)
destroy(this.pb_compute)
destroy(this.st_3)
destroy(this.st_show_invisible)
destroy(this.st_4)
destroy(this.hsb_1)
destroy(this.hsb_2)
destroy(this.r_7)
end on

type em_font from editmask within u_cst_dw_design_menu
integer x = 2098
integer y = 92
integer width = 293
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean spin = true
double increment = 1
string minmax = "1~~100"
end type

event modified;//====================================================================
//$<Event>: modified
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.14.2014 (IntelliReport Modifications 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_ProExp, ls_ObjName, ls_type
long   ll_SelObjCnts, ll_TotalCnts, ll_Cycle
integer li_size

ls_ProExp = ".font.height='"+"-"+this.text+"'"
li_size = integer(this.text)
if isvalid(w_custom_report) then
	if IsValid(inv_data_design) then
		ll_SelObjCnts = inv_data_design.of_GetSelectedObjectCnts()
		if ll_SelObjCnts <= 0 then Return
		
		ll_TotalCnts = UpperBound(inv_data_design.istr_SelectObj)
		for ll_Cycle = 1 to ll_TotalCnts
			ls_ObjName = inv_data_design.istr_SelectObj[ll_Cycle].FName
			if Not IsNull(ls_ObjName) and ls_ObjName <> '' then				
				ls_type = inv_data_design.of_getselectedobjecttype(ls_ObjName)
				w_custom_report.of_set_fontsize(ls_ObjName, ls_type, li_size)
			end if
		next
	end if
end if

of_ModifySelObjsAttr(ls_ProExp)

end event

type st_1 from statictext within u_cst_dw_design_menu
integer x = 1655
integer y = 4
integer width = 343
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

type pb_delete from picturebutton within u_cst_dw_design_menu
integer x = 1326
integer y = 152
integer width = 105
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Clear!"
boolean map3dcolors = true
string powertiptext = "Delete Object"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

//Integer li_obj_id
//Integer li_found
//String ls_obj_id
//String ls_Type//<add> 06/21/2007 by: Andy
//
//if upperbound(w_contract_data_design.uo_design.is_last_object) = 0 then return //maha 052005
////<add> 06/21/2007 by: Andy
//ls_Type = w_contract_data_design.uo_design.idw_detail.describe(w_contract_data_design.uo_design.is_last_object[1] + '.type')
//if isnull(ls_Type) then ls_Type = ''
////end of add
//IF Pos(w_contract_data_design.uo_design.is_last_object[1], "object" ) > 0 or &
//	ls_Type = 'compute' THEN//<add> 06/21/2007 by: Andy
//	ls_obj_id = Mid(w_contract_data_design.uo_design.is_last_object[1], 7,100)
//	IF Right( ls_obj_id, 2) = "_t" THEN
//		ls_obj_id = Mid(ls_obj_id, 1, Len(ls_obj_id) -2 )
//	END IF
//	w_contract_data_design.uo_design.idw_detail.Modify("destroy " + w_contract_data_design.uo_design.is_last_object[1] )
//ELSE
//	//MessageBox("Clear Error", "You can't delete field or field label objects.  To hide, make the Visible property in the propeties dialog box = No.")
//	MessageBox("Clear Error", "You can't delete field or field label objects.  To hide these objects, set the Visible property in the properties dialog box to No.")
//END IF

//modify by gavin on 2009/3/4
IF IsValid(inv_data_design) then 
	inv_data_design.event ue_modify('delete')
END IF


//---------------------------- APPEON END ----------------------------
end event

type pb_sort from picturebutton within u_cst_dw_design_menu
integer x = 1463
integer y = 152
integer width = 105
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Sort!"
boolean map3dcolors = true
string powertiptext = "Sort"
end type

event clicked;//start--modify by gavin on 2009-03-04
//if isvalid(w_contract_data_design) then
//	w_contract_data_design.uo_design.Triggerevent('pfc_cst_sort')
//end if

IF IsValid(inv_data_design) then
	inv_data_design.Triggerevent('pfc_cst_sort')
END IF
//End--modify by gavin on 2009-03-04
end event

type pb_picture from picturebutton within u_cst_dw_design_menu
integer x = 1134
integer y = 152
integer width = 105
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Picture5!"
boolean map3dcolors = true
string powertiptext = "Add Picture control"
end type

event clicked;//Create Picture Control - jervis 11.20.2009
IF IsValid(inv_data_design) then
	inv_data_design.event ue_new('picture')
END IF

end event

type pb_oval from picturebutton within u_cst_dw_design_menu
integer x = 1015
integer y = 152
integer width = 105
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Oval!"
boolean map3dcolors = true
string powertiptext = "Add Oval control"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2009-03-02 By: Scofield
//$<Reason> Create a new oval.

//if IsValid(w_contract_data_design) then 
//	w_contract_data_design.event ue_new("oval")
//end if

IF IsValid(inv_data_design) then
	inv_data_design.event ue_new('oval')
END IF

//---------------------------- APPEON END ----------------------------

end event

type pb_groupbox from picturebutton within u_cst_dw_design_menu
integer x = 896
integer y = 152
integer width = 105
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "GroupBox!"
boolean map3dcolors = true
string powertiptext = "Add Groupbox control"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

//Integer li_object_no
//String ls_obj_name
//
//FOR li_object_no = 1 TO 1000
//	ls_obj_name = w_contract_data_design.uo_design.idw_detail.Describe("object" + String(li_object_no) + ".name")
//	IF ls_obj_name = "object" + String(li_object_no) THEN CONTINUE
//
//	w_contract_data_design.uo_design.idw_detail.Modify("create groupbox(band=detail text='none'border='5' color='128' x='20' y='20' height='390' width='660'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=object" + String(li_object_no) +")" )
//	EXIT
//NEXT

//modify by gavin on 2009/3/4
//if isValid(w_contract_data_design) then 
//	w_contract_data_design.event ue_new("groupbox")
//end if

IF IsValid(inv_data_design) then
	inv_data_design.event ue_new('groupbox')
END IF
//---------------------------- APPEON END ----------------------------

end event

type p_aligntop from picture within u_cst_dw_design_menu
integer x = 2487
integer y = 164
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "AlignTop!"
boolean focusrectangle = false
boolean map3dcolors = true
end type

event clicked;if IsValid(inv_data_design) then
	inv_data_design.event ue_arrange('snap_to_top')
end if

end event

type p_copysize from picture within u_cst_dw_design_menu
integer x = 2487
integer y = 72
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "SizeHorizontal!"
boolean focusrectangle = false
boolean map3dcolors = true
end type

event clicked;if IsValid(inv_data_design) then
	inv_data_design.event ue_arrange('same_width')
end if

end event

type st_11 from statictext within u_cst_dw_design_menu
integer x = 2853
integer y = 4
integer width = 270
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

type st_xy from statictext within u_cst_dw_design_menu
integer x = 2770
integer y = 160
integer width = 800
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

type st_object_name from statictext within u_cst_dw_design_menu
integer x = 2770
integer y = 64
integer width = 800
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

type st_10 from statictext within u_cst_dw_design_menu
integer x = 46
integer width = 247
integer height = 60
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

type st_9 from statictext within u_cst_dw_design_menu
integer x = 2473
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
long backcolor = 33551856
boolean enabled = false
string text = "Size/Align"
boolean focusrectangle = false
end type

type st_8 from statictext within u_cst_dw_design_menu
integer x = 2107
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
long backcolor = 33551856
boolean enabled = false
string text = "Font Size"
boolean focusrectangle = false
end type

type st_6 from statictext within u_cst_dw_design_menu
integer x = 1403
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
long backcolor = 33551856
boolean enabled = false
string text = "Edit"
boolean focusrectangle = false
end type

type st_underline from statictext within u_cst_dw_design_menu
integer x = 1906
integer y = 60
integer width = 105
integer height = 88
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

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-15
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String   ls_ObjName,ls_ColName,ls_Type,ls_Modify,ls_Syntax,ls_Err,ls_Field_id,ls_EditStyle
long		ll_Cycle,ll_TotalCnts,ll_SelObjCnts,ll_Rtn

ll_SelObjCnts = inv_Data_Design.of_GetSelectedObjectCnts()
if ll_SelObjCnts <= 0 then Return
	
if This.BorderStyle = StyleLowered! then
	This.BorderStyle = StyleRaised!
	ls_Syntax = ".font.underline='0'"
else
	This.BorderStyle = StyleLowered!
	ls_Syntax = ".font.underline='1'"
end if

ll_TotalCnts = UpperBound(inv_Data_Design.istr_SelectObj)
for ll_Cycle = 1 to ll_TotalCnts
	ls_ObjName = inv_Data_Design.istr_SelectObj[ll_Cycle].FName
	if IsNull(ls_ObjName) or ls_ObjName = '' then Continue
	
	ls_Type = inv_Data_Design.of_GetSelectedObjectType(ls_ObjName)
	if ls_Type <> "text" and ls_Type <> "compute" and ls_Type <> "column" then Continue
	
	if ls_Type = "text" and RightA(ls_ObjName,2) = "_t" then
		ls_ColName = inv_Data_Design.istr_SelectObj[ll_Cycle].FBand.Describe(LeftA(ls_ObjName,LenA(ls_ObjName) - 2) + ".Name")
	end if
	
	if ls_Type = 'compute' or ls_ColName = "?" or ls_ColName = "!" then
		inv_Data_Design.istr_SelectObj[ll_Cycle].FBand.Modify(ls_ObjName + ls_Syntax)
		inv_Data_Design.Event ue_SetModify(ls_ObjName + ls_Syntax)
	else
		if ll_Rtn <> 0 and ll_Rtn <> 1 then Continue
		
		if Lower(ls_Type) = "column" then
			ls_Field_id = inv_Data_Design.of_GetSelectedObjectID(ls_ObjName)
			ls_ColName = ls_ObjName
		else
			if RightA(ls_ObjName, 2) = "_t" then
				ls_Field_id = inv_Data_Design.of_GetSelectedObjectTag(ls_ObjName)
				ls_ColName = LeftA(ls_ObjName,LenA(ls_ObjName) - 2)
			end if
		end if
		
		if IsNull(ls_Field_id) or Trim(ls_Field_id) = "" or ls_Field_id = '!' or ls_Field_id = '?' or Not IsNumber(ls_Field_id) then Continue
		
		inv_Data_Design.dw_Properties.SetFilter("data_view_fields_field_id = " + ls_Field_id)
		inv_Data_Design.dw_Properties.Filter()
		if inv_Data_Design.dw_Properties.RowCount() <= 0 Then Continue
		
		ls_EditStyle = inv_Data_Design.istr_SelectObj[ll_Cycle].FBand.Describe(ls_ColName + ".Edit.Style")
		
		if This.BorderStyle = StyleLowered! then
			if ll_Rtn <> 1 and inv_Data_Design.is_Open_Style = 'screen' then
				ll_Rtn = MessageBox("Underline Format","Only required fields are underlined.  Would you like to make this a required field?", Question!,YesNo!,1)
				if ll_Rtn <> 1 then Continue
			end if
			inv_Data_Design.dw_Properties.SetItem(1,"data_view_fields_required",'Y')
			ls_Modify  = " " + ls_ColName + "." + ls_EditStyle + ".Required = 'Yes'"
		else
			inv_Data_Design.dw_Properties.SetItem(1,"data_view_fields_required",'N')
			ls_Modify  = " " + ls_ColName + "." + ls_EditStyle + ".Required = 'No'"
		end if
		
		ls_Modify += " " + ls_ColName + "_t" + ls_Syntax
		
		inv_Data_Design.dw_Properties.Accepttext()
		inv_Data_Design.istr_SelectObj[ll_Cycle].FBand.Modify(ls_Modify)
		inv_Data_Design.Event ue_SetModify(ls_Modify)
	end if
next

end event

type st_italic from statictext within u_cst_dw_design_menu
integer x = 1787
integer y = 60
integer width = 105
integer height = 88
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

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_ProExp

if This.BorderStyle = StyleLowered! then
	This.BorderStyle = StyleRaised!
	ls_ProExp = ".font.italic='0'"
else
	This.BorderStyle = StyleLowered!
	ls_ProExp = ".font.italic='1'"
end if

of_ModifySelObjsAttr(ls_ProExp)

end event

type st_bold from statictext within u_cst_dw_design_menu
integer x = 1669
integer y = 60
integer width = 105
integer height = 88
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

event clicked;String ls_ProExp

if This.BorderStyle = StyleLowered! then
	This.BorderStyle = StyleRaised!
	ls_ProExp = ".font.weight='400'"
else
	This.BorderStyle = StyleLowered!
	ls_ProExp = ".font.weight='700'"
end if

of_ModifySelObjsAttr(ls_ProExp)

end event

type st_right from statictext within u_cst_dw_design_menu
event lbuttondown pbm_lbuttondown
integer x = 1906
integer y = 152
integer width = 105
integer height = 88
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

event lbuttondown;//====================================================================
// Event: lbuttondown()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    unsignedlong    flags
// 	value    integer         xpos
// 	value    integer         ypos
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

st_Left.BorderStyle = StyleRaised!
st_Center.BorderStyle = StyleRaised!
st_Right.BorderStyle = StyleLowered!

of_AlignSelObjs(1)

end event

type st_center from statictext within u_cst_dw_design_menu
event lbuttondown pbm_lbuttondown
integer x = 1787
integer y = 152
integer width = 105
integer height = 88
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

event lbuttondown;//====================================================================
// Event: lbuttondown()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    unsignedlong    flags
// 	value    integer         xpos
// 	value    integer         ypos
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

st_Left.BorderStyle = StyleRaised!
st_Center.BorderStyle = StyleLowered!
st_Right.BorderStyle = StyleRaised!

of_AlignSelObjs(2)

end event

type st_left from statictext within u_cst_dw_design_menu
event lbuttondown pbm_lbuttondown
integer x = 1669
integer y = 152
integer width = 105
integer height = 88
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

event lbuttondown;//====================================================================
// Event: lbuttondown()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    unsignedlong    flags
// 	value    integer         xpos
// 	value    integer         ypos
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

st_Left.BorderStyle = StyleLowered!
st_Center.BorderStyle = StyleRaised!
st_Right.BorderStyle = StyleRaised!

of_AlignSelObjs(0)

end event

type st_relocate_field from statictext within u_cst_dw_design_menu
boolean visible = false
integer x = 946
integer y = 160
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

IF UpperBound(w_contract_data_design.uo_design.is_last_object[]) = 0 THEN
	MessageBox("Error", "You must first select the fields you want to relocate.")
	Return
END IF

w_contract_data_design.uo_design.ib_relocating_fields = True

end event

type dw_1 from datawindow within u_cst_dw_design_menu
event ue_dwnprocessenter pbm_dwnprocessenter
integer x = 27
integer y = 92
integer width = 791
integer height = 108
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_design_label_editor"
boolean border = false
boolean livescroll = true
end type

event ue_dwnprocessenter;//====================================================================
// Event: ue_dwnProcessEnter()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

inv_data_design.of_AutoUpdateSearchScreen(is_CurObj)

end event

event editchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-15 By: Andy
u_cst_dw_band ldw_band
String ls_Modify

//modify by gavin on 2009/3/4
//if isValid(w_contract_data_design) then 
if isValid(inv_data_design) then
	ldw_band = inv_data_design.wf_getband(inv_data_design.is_curBand)
	if isNull(ldw_band.is_curobj) or ldw_band.is_curobj = "" then return
	
	//$<modify> 04.10.2008 by Andy
	//Reason:   fixed BugG041001,Issue 2 from Issues for Tracy.doc
	//ls_Modify = ldw_band.is_curobj + ".text = '" + data + "'"
	//$<modify> 04.17.2008 by nova
	//Reason:   fixed BugG
	
	is_CurObj = ldw_band.is_curobj
	
	ls_Modify = is_CurObj + ".text = ~"" + data + "~""
	
	ldw_band.modify( ls_Modify )
	inv_data_design.event ue_setModify(ls_Modify)
	
	if inv_data_design.dw_properties.GetRow() > 0 then 
		inv_data_design.dw_properties.SetItem(1, "data_view_fields_field_label", data )
		//$<add> 03.26.2008 by Andy
		//$Reason:Auto set view fields alias
		ldw_band.of_set_dw_properties( "data_view_fields_field_label" )
	end if
	//end modify 04.10.2008
	
	ib_HasModify = true
end if

/*
if upperbound(w_contract_data_design.uo_design.is_last_object[]) < 1 then //maha 100404

else
	w_contract_data_design.uo_design.idw_detail.Modify( w_contract_data_design.uo_design.is_last_object[1] + ".text = '" + data + "'")
	w_contract_data_design.uo_design.dw_properties.SetItem(1, "data_view_fields_field_label", data )
end if
*/
//---------------------------- APPEON END ----------------------------

end event

event constructor;dw_1.insertrow(0)

end event

event getfocus;ib_HasModify = false
end event

event losefocus;if ib_HasModify then
	ib_HasModify = false
	inv_data_design.of_AutoUpdateSearchScreen(is_CurObj)
end if

end event

type r_6 from rectangle within u_cst_dw_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 2761
integer y = 32
integer width = 827
integer height = 220
end type

type r_1 from rectangle within u_cst_dw_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 1307
integer y = 32
integer width = 288
integer height = 220
end type

type r_2 from rectangle within u_cst_dw_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 864
integer y = 32
integer width = 411
integer height = 220
end type

type r_3 from rectangle within u_cst_dw_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 1627
integer y = 32
integer width = 425
integer height = 220
end type

type r_4 from rectangle within u_cst_dw_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 2441
integer y = 32
integer width = 283
integer height = 220
end type

type p_1 from picture within u_cst_dw_design_menu
integer x = 2601
integer y = 72
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "SizeVertical!"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean map3dcolors = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_contract_data_design.uo_design.ii_obj_select_cnt
	w_contract_data_design.uo_design.idw_detail.Modify( w_contract_data_design.uo_design.is_last_object[i] + ".height = '" + String(w_contract_data_design.uo_design.il_last_object_height[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	
*/

//modify by gavin on 2009/3/4
//if isValid(w_contract_data_design) then
//	w_contract_data_design.event ue_arrange('same_height')
//end if

if isValid(inv_data_design) then
	inv_data_design.event ue_arrange('same_height')
end if
//---------------------------- APPEON END ----------------------------

end event

type p_alignleft from picture within u_cst_dw_design_menu
integer x = 2601
integer y = 164
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "AlignLeft!"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean map3dcolors = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy

/*
Integer i
String ls_syntax


This.BorderStyle = StyleLowered!	

FOR i = 1 TO w_contract_data_design.uo_design.ii_obj_select_cnt
	w_contract_data_design.uo_design.idw_detail.Modify( w_contract_data_design.uo_design.is_last_object[i] + ".x = '" + String(w_contract_data_design.uo_design.il_last_object_x[1]) + "'" )
END FOR

This.BorderStyle = StyleRaised!	
*/

//modify by gavin on 2009/3/4
//if isValid(w_contract_data_design) then
//	w_contract_data_design.event ue_arrange('snap_to_left')
//end if

if isValid(inv_data_design) then
	inv_data_design.event ue_arrange('snap_to_left')
end if
//---------------------------- APPEON END ----------------------------

end event

type st_7 from statictext within u_cst_dw_design_menu
integer x = 946
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

type st_tab_order from statictext within u_cst_dw_design_menu
integer x = 1321
integer y = 60
integer width = 261
integer height = 88
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
string text = "Tab Order"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean disabledlook = true
end type

event clicked;//start--modify by gavin on 2009-02-26
IF IsValid(inv_data_design) then
   inv_data_design.ib_disable_activate = TRUE
//	w_contract_data_design.ib_disable_activate = TRUE

	IF This.BorderStyle = StyleLowered! THEN
		This.BorderStyle = StyleRaised!
		inv_data_design.of_set_tab_order( False )
	ELSE
		This.BorderStyle = StyleLowered!
		inv_data_design.of_set_tab_order( True )
	END IF
	
//	w_contract_data_design.ib_disable_activate = FALSE
	inv_data_design.ib_disable_activate = FALSE
	//End--modify by gavin on 2009-02-26
END IF
end event

type st_copysize from statictext within u_cst_dw_design_menu
integer x = 2473
integer y = 60
integer width = 105
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 79741120
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;if IsValid(inv_data_design) then
	inv_data_design.event ue_arrange('same_width')
end if

end event

type st_aligntop from statictext within u_cst_dw_design_menu
integer x = 2473
integer y = 152
integer width = 105
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 79741120
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;if IsValid(inv_data_design) then
	inv_data_design.event ue_arrange('snap_to_top')
end if

end event

type st_12 from statictext within u_cst_dw_design_menu
integer x = 2587
integer y = 60
integer width = 105
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 79741120
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;if IsValid(inv_data_design) then
	inv_data_design.event ue_arrange('same_height')
end if

end event

type st_alignleft from statictext within u_cst_dw_design_menu
integer x = 2587
integer y = 152
integer width = 105
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 79741120
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;if IsValid(inv_data_design) then
	inv_data_design.event ue_arrange('snap_to_left')
end if

end event

type r_5 from rectangle within u_cst_dw_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer y = 36
integer width = 837
integer height = 212
end type

type pb_column from picturebutton within u_cst_dw_design_menu
integer x = 896
integer y = 60
integer width = 105
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Justify!"
boolean map3dcolors = true
string powertiptext = "Add Field control"
end type

event clicked;String	ls_Select_Field_List
//---------Begin Modified by (Appeon)Toney 06.11.2013 for V141 ISG-CLX--------
//$Reason:The w_InVisibleFieldList object of ISG was saved as w_InVisibleFieldList
  /*
   OpenWithParm(w_InVisibleFieldList,Inv_Data_Design)   
  */
 OpenWithParm(w_InVisibleFieldList_rpt,Inv_Data_Design)
//---------End Modfiied ------------------------------------------------------------------



ls_Select_Field_List = Message.StringParm
if ls_Select_Field_List <> "" and IsValid(inv_data_design) then
	inv_data_design.wf_PickUpFieldSyntax(ls_Select_Field_List)
end if

end event

type pb_text from picturebutton within u_cst_dw_design_menu
integer x = 1015
integer y = 60
integer width = 105
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "StaticText!"
boolean map3dcolors = true
string powertiptext = "Add Text control"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Andy
//Integer li_object_no
//long ll_scroll
//long ll_y
//String ls_obj_name
//
//ll_scroll = Long(w_contract_data_design.uo_design.idw_detail.Object.DataWindow.VerticalScrollPosition)
//ll_y = ll_scroll + 20
//
//if w_contract_data_design.triggerevent("pfc_save") < 1 then return -1
//
//FOR li_object_no = 1 TO 1000
//	ls_obj_name = w_contract_data_design.uo_design.idw_detail.Describe("object" + String(li_object_no) + "_t.name")
//	IF ls_obj_name = "object" + String(li_object_no) + "_t" THEN CONTINUE
//
//	w_contract_data_design.uo_design.idw_detail.Modify("create text(band=detail text='text' border='0' color='0' x='20' y='" + string(ll_y) + "' height='52' width='150'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=object" + String(li_object_no) + "_t)"  )
//	EXIT
//NEXT

//modify by gavin on 2009/3/4
//if isValid(w_contract_data_design) then 
//	w_contract_data_design.event ue_new('text')
//end if
IF IsValid(inv_data_design) then
	inv_data_design.event ue_new('text')
END IF

//---------------------------- APPEON END ----------------------------
end event

type pb_compute from picturebutton within u_cst_dw_design_menu
integer x = 1134
integer y = 60
integer width = 105
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Compute5!"
boolean map3dcolors = true
string powertiptext = "Add Compute control"
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
//ldw_Temp  = w_contract_data_design.uo_design.idw_detail
//ll_scroll = Long(ldw_Temp.Object.DataWindow.VerticalScrollPosition)
//ll_y      = ll_scroll + 20
//
//if w_contract_data_design.triggerevent("pfc_save") < 1 then return -1
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

//modify by gavin on 2009/3/4
if isValid(inv_data_design) then 
	inv_data_design.event ue_new('compute')
end if
//---------------------------- APPEON END ----------------------------
end event

type st_3 from statictext within u_cst_dw_design_menu
boolean visible = false
integer x = 946
integer y = 4
integer width = 329
integer height = 76
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
string text = "Adjust Width"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_show_invisible from statictext within u_cst_dw_design_menu
boolean visible = false
integer x = 1015
integer y = 172
integer width = 530
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
string text = "Show Invisible"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//start--modify by gavin on 2009-03-04
//IF This.BorderStyle = StyleLowered! THEN
//	This.BorderStyle = StyleRaised!
//	w_contract_data_design.uo_design.of_show_invisible( True )
//	w_contract_data_design.uo_design.ib_show_invisible = True
//ELSE
//	This.BorderStyle = StyleLowered!
//	w_contract_data_design.uo_design.of_show_invisible( False )
//	w_contract_data_design.uo_design.ib_show_invisible = False
//END IF

IF IsValid(inv_data_design) then
	IF This.BorderStyle = StyleLowered! THEN
		This.BorderStyle = StyleRaised!
		inv_data_design.of_show_invisible( True )
		inv_data_design.ib_show_invisible = True
	ELSE
		This.BorderStyle = StyleLowered!
		inv_data_design.of_show_invisible( False )
		inv_data_design.ib_show_invisible = False
	END IF
END IF
//End--modify by gavin on 2009-03-04


end event

type st_4 from statictext within u_cst_dw_design_menu
boolean visible = false
integer x = 1102
integer y = 136
integer width = 329
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
string text = "Move "
alignment alignment = center!
boolean focusrectangle = false
end type

type hsb_1 from hscrollbar within u_cst_dw_design_menu
boolean visible = false
integer x = 946
integer y = 76
integer width = 329
integer height = 68
boolean bringtotop = true
end type

event constructor;This.MinPosition = 1
This.MaxPosition = 3
This.Position = 2
end event

event lineleft;w_contract_data_design.uo_design.of_adjust_width( -25 )

end event

event lineright;w_contract_data_design.uo_design.of_adjust_width( 25 )
end event

event pageleft;w_contract_data_design.uo_design.of_adjust_width( -75 )
end event

event pageright;w_contract_data_design.uo_design.of_adjust_width( 75 )
end event

type hsb_2 from hscrollbar within u_cst_dw_design_menu
boolean visible = false
integer x = 1285
integer y = 76
integer width = 329
integer height = 68
boolean bringtotop = true
integer minposition = 3
integer maxposition = 1
integer position = 2
end type

event constructor;This.MinPosition = 1
This.MaxPosition = 3
This.Position = 2
end event

event lineleft;w_contract_data_design.uo_design.of_adjust_position( -25 )


end event

event lineright;w_contract_data_design.uo_design.of_adjust_position( 25 )


end event

event pageleft;w_contract_data_design.uo_design.of_adjust_position( -75 )


end event

event pageright;w_contract_data_design.uo_design.of_adjust_position( 75 )


end event

type r_7 from rectangle within u_cst_dw_design_menu
integer linethickness = 4
long fillcolor = 33551856
integer x = 2085
integer y = 32
integer width = 329
integer height = 220
end type

