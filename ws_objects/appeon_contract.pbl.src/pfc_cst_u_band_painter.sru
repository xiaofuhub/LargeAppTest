$PBExportHeader$pfc_cst_u_band_painter.sru
forward
global type pfc_cst_u_band_painter from userobject
end type
type st_trailergroup from statictext within pfc_cst_u_band_painter
end type
type dw_trailergroup from pfc_cst_u_band within pfc_cst_u_band_painter
end type
type st_headergroup from statictext within pfc_cst_u_band_painter
end type
type dw_headergroup from pfc_cst_u_band within pfc_cst_u_band_painter
end type
type sle_tab from singlelineedit within pfc_cst_u_band_painter
end type
type st_footer from statictext within pfc_cst_u_band_painter
end type
type st_summary from statictext within pfc_cst_u_band_painter
end type
type st_detail from statictext within pfc_cst_u_band_painter
end type
type dw_footer from pfc_cst_u_band within pfc_cst_u_band_painter
end type
type dw_summary from pfc_cst_u_band within pfc_cst_u_band_painter
end type
type dw_detail from pfc_cst_u_band within pfc_cst_u_band_painter
end type
type dw_header from pfc_cst_u_band within pfc_cst_u_band_painter
end type
type st_header from statictext within pfc_cst_u_band_painter
end type
type dw_ruler from datawindow within pfc_cst_u_band_painter
end type
type st_left from statictext within pfc_cst_u_band_painter
end type
type st_up from statictext within pfc_cst_u_band_painter
end type
type st_right from statictext within pfc_cst_u_band_painter
end type
type st_down from statictext within pfc_cst_u_band_painter
end type
type dw_syntax from u_dw within pfc_cst_u_band_painter
end type
end forward

global type pfc_cst_u_band_painter from userobject
integer width = 3232
integer height = 2596
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
long backcolor = 67108864
string text = "none"
integer unitsperline = 50
integer unitspercolumn = 120
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
event ue_scroll pbm_vscroll
event ue_hscroll pbm_hscroll
st_trailergroup st_trailergroup
dw_trailergroup dw_trailergroup
st_headergroup st_headergroup
dw_headergroup dw_headergroup
sle_tab sle_tab
st_footer st_footer
st_summary st_summary
st_detail st_detail
dw_footer dw_footer
dw_summary dw_summary
dw_detail dw_detail
dw_header dw_header
st_header st_header
dw_ruler dw_ruler
st_left st_left
st_up st_up
st_right st_right
st_down st_down
dw_syntax dw_syntax
end type
global pfc_cst_u_band_painter pfc_cst_u_band_painter

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-06 By: Andy
boolean			ib_Moving = FALSE
long				il_CurrentY[],il_PriorY[]
long				il_loc

//---------------------------- APPEON END ----------------------------

// add by gavin 2009/3/2
pfc_cst_u_contract_data_design inv_data_design
Boolean     ib_group = false
// add by gavin 2009/3/2

long		il_OriginX,il_OriginY
long		il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight
Boolean	ib_MouseDown

long		ll_RectBackColor = RGB(63,63,63)

CONSTANT LONG BANDSEPHEIGHT = 60

end variables

forward prototypes
public function integer of_set_parent (pfc_cst_u_contract_data_design anv_data_design)
public subroutine of_hide_rectangle_frame ()
public subroutine of_modify_rectangle_frame ()
public subroutine of_show_rectangle_frame ()
public subroutine of_selectobjectsinrectframe ()
public subroutine of_enabled_save ()
end prototypes

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
// Author:	Scofield		Date: 2009-04-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

il_OriginX = XPos
il_OriginY = YPos

ib_MouseDown = true
of_Show_Rectangle_Frame()

Timer(0.001,dw_Header.iw_parent)

end event

event lbuttonup;//====================================================================
// Event: lbuttonup()
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
// Author:	Scofield		Date: 2009-04-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjName
long		ll_SelObjCnts

of_Hide_Rectangle_Frame()
of_SelectObjectsInRectFrame()

ll_SelObjCnts = inv_data_design.of_GetSelectedObjectCnts()
if ll_SelObjCnts >= 1 then
	ls_ObjName = inv_data_design.of_GetLastSelectedObject()
	inv_data_design.is_CurSelectObj = ls_ObjName
end if

inv_data_design.of_Refresh_Object_Inforamtion()

ib_MouseDown = false
inv_data_design.ib_Mouse_Down = false

//if (ls_objName = "" Or isnull( ls_objname)) and ll_selobjcnts = 0 then
//	
//	if isvalid(w_contract_field_properties) then Close(w_contract_field_properties)
//	If IsValid( w_contract_other_properties ) Then  Close(w_contract_other_properties)
//	If IsValid( w_contract_compute_properties ) Then  Close(w_contract_compute_properties)
//	If IsValid( w_contract_text_properties ) Then  Close(w_contract_text_properties)
//	If IsValid( w_contract_groupbox_properties ) Then  Close(w_contract_groupbox_properties)
//	If IsValid( w_contract_mul_field_properties ) Then  Close(w_contract_mul_field_properties)
//
//end if
end event

public function integer of_set_parent (pfc_cst_u_contract_data_design anv_data_design);//Add by gavin on 2009/3/4
inv_data_design = anv_data_design
Return 1
end function

public subroutine of_hide_rectangle_frame ();//====================================================================
// Function: of_hide_rectangle_frame()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

This.SetRedraw(false)

st_Left.Visible = false
st_Up.Visible = false
st_Right.Visible = false
st_Down.Visible = false

This.SetRedraw(true)

end subroutine

public subroutine of_modify_rectangle_frame ();//====================================================================
// Function: of_modify_rectangle_frame()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_XPos,ll_YPos

ll_XPos = This.PointerX()
ll_YPos = This.PointerY()

if ll_XPos <= 0 then ll_XPos = 0
if ll_YPos <= 0 then ll_YPos = 0

if ll_XPos > il_OriginX then
	il_RectFrameX = il_OriginX
	il_RectFrameWidth = ll_XPos - il_OriginX
else
	il_RectFrameX = ll_XPos
	il_RectFrameWidth = il_OriginX - ll_XPos
end if

if ll_YPos > il_OriginY then
	il_RectFrameY = il_OriginY
	il_RectFrameHeight = ll_YPos - il_OriginY
else
	il_RectFrameY = ll_YPos
	il_RectFrameHeight = il_OriginY - ll_YPos
end if

if il_RectFrameX <= 0 then il_RectFrameX = 0
if il_RectFrameY <= 0 then il_RectFrameY = 0

if st_Left.X < il_RectFrameX then
	st_Up.Resize(il_RectFrameWidth,4)
	st_Up.Move(il_RectFrameX,il_RectFrameY)
	
	st_Down.Resize(il_RectFrameWidth + 4,4)
	st_Down.Move(il_RectFrameX,il_RectFrameY + il_RectFrameHeight)
else
	st_Up.Move(il_RectFrameX,il_RectFrameY)
	st_Up.Resize(il_RectFrameWidth,4)
	
	st_Down.Move(il_RectFrameX,il_RectFrameY + il_RectFrameHeight)
	st_Down.Resize(il_RectFrameWidth + 4,4)
end if

if st_Left.Y < il_RectFrameY then
	st_Left.Resize(4,il_RectFrameHeight)
	st_Left.Move(il_RectFrameX,il_RectFrameY)
	
	st_Right.Resize(4,il_RectFrameHeight)
	st_Right.Move(il_RectFrameX + il_RectFrameWidth,il_RectFrameY)
else
	st_Left.Move(il_RectFrameX,il_RectFrameY)
	st_Left.Resize(4,il_RectFrameHeight)
	
	st_Right.Move(il_RectFrameX + il_RectFrameWidth,il_RectFrameY)
	st_Right.Resize(4,il_RectFrameHeight)
end if

end subroutine

public subroutine of_show_rectangle_frame ();//====================================================================
// Function: of_show_rectangle_frame()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

st_Left.Move(il_OriginX,il_OriginY)
st_Left.Resize(4,4)

st_Up.Move(il_OriginX,il_OriginY)
st_Up.Resize(4,4)

st_Right.Move(il_OriginX,il_OriginY)
st_Right.Resize(4,4)

st_Down.Move(il_OriginX,il_OriginY)
st_Down.Resize(4,4)

st_Left.Visible = true
st_Up.Visible = true
st_Right.Visible = true
st_Down.Visible = true

end subroutine

public subroutine of_selectobjectsinrectframe ();//====================================================================
// Function: of_SelectObjectsInRectFrame()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

dw_header.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_headergroup.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_detail.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_trailergroup.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_summary.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_footer.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)

il_RectFrameX = 0
il_RectFrameY = 0
il_RectFrameWidth = 0
il_RectFrameHeight = 0

end subroutine

public subroutine of_enabled_save ();//====================================================================
// Function: of_Enabled_Save()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-04-29
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

if IsValid(m_pfe_cst_contract_data_design) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'Enabled', true)
end if

end subroutine

on pfc_cst_u_band_painter.create
this.st_trailergroup=create st_trailergroup
this.dw_trailergroup=create dw_trailergroup
this.st_headergroup=create st_headergroup
this.dw_headergroup=create dw_headergroup
this.sle_tab=create sle_tab
this.st_footer=create st_footer
this.st_summary=create st_summary
this.st_detail=create st_detail
this.dw_footer=create dw_footer
this.dw_summary=create dw_summary
this.dw_detail=create dw_detail
this.dw_header=create dw_header
this.st_header=create st_header
this.dw_ruler=create dw_ruler
this.st_left=create st_left
this.st_up=create st_up
this.st_right=create st_right
this.st_down=create st_down
this.dw_syntax=create dw_syntax
this.Control[]={this.st_trailergroup,&
this.dw_trailergroup,&
this.st_headergroup,&
this.dw_headergroup,&
this.sle_tab,&
this.st_footer,&
this.st_summary,&
this.st_detail,&
this.dw_footer,&
this.dw_summary,&
this.dw_detail,&
this.dw_header,&
this.st_header,&
this.dw_ruler,&
this.st_left,&
this.st_up,&
this.st_right,&
this.st_down,&
this.dw_syntax}
end on

on pfc_cst_u_band_painter.destroy
destroy(this.st_trailergroup)
destroy(this.dw_trailergroup)
destroy(this.st_headergroup)
destroy(this.dw_headergroup)
destroy(this.sle_tab)
destroy(this.st_footer)
destroy(this.st_summary)
destroy(this.st_detail)
destroy(this.dw_footer)
destroy(this.dw_summary)
destroy(this.dw_detail)
destroy(this.dw_header)
destroy(this.st_header)
destroy(this.dw_ruler)
destroy(this.st_left)
destroy(this.st_up)
destroy(this.st_right)
destroy(this.st_down)
destroy(this.dw_syntax)
end on

event constructor;//====================================================================
// Event: constructor()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-24
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

st_Left.BackColor = ll_RectBackColor
st_Up.BackColor = ll_RectBackColor
st_Right.BackColor = ll_RectBackColor
st_Down.BackColor = ll_RectBackColor

end event

type st_trailergroup from statictext within pfc_cst_u_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 1412
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "TrailerGroup"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;//modify by gavin on 2009/3/4
if dw_trailergroup.iuo_parent.ib_set_tab_order then Return

ib_moving = TRUE
il_priory[6] = this.y
il_loc= this.y

end event

event mousemove;long   ll_Y

if dw_trailergroup.iuo_parent.ib_set_tab_order then Return
if ib_MouseDown and This.Pointer <> "Arrow!" then This.Pointer = "Arrow!"
if inv_data_design.ib_Mouse_Down then Return

if Not ib_MouseDown and This.Pointer <> "SizeNS!" then This.Pointer = "SizeNS!"

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.SetPosition(ToTop!)
	ll_Y = Parent.PointerY()
	IF ll_Y < dw_trailergroup.y THEN
		Return 0
	END IF
	this.y = ll_Y
	il_CurrentY[6] = ll_Y
End If

end event

event mouseup;long  ll_Moved
long	ll_find,ll_object_no

if dw_trailergroup.iuo_parent.ib_set_tab_order then Return

If UpperBound(il_CurrentY[])<1 Or UpperBound(il_PriorY[])<1 Then Return 

ll_moved =  il_CurrentY[6] - il_PriorY[6]
If this.y<>il_loc Then
	if ib_moving then
		of_Enabled_Save()		//Added by Scofield on 2010-04-29
		
		this.SetPosition(ToTop!)
	
		this.move(this.x,il_CurrentY[6])
	
		dw_trailergroup.height=dw_trailergroup.height + ll_moved
			
		dw_summary.y = this.y + this.height
		st_summary.y = dw_summary.y + dw_summary.height
		
		dw_footer.y = st_summary.y + st_summary.height
		st_footer.y = dw_footer.y + dw_footer.height
	
		ib_moving=false
		dw_syntax.modify("datawindow.trailer.1.height='"+string(dw_trailergroup.height)+"'")
	end if
	
	il_PriorY[6] = il_CurrentY[6]
	il_PriorY[3] = st_summary.y
	il_CurrentY[3] = st_Header.y
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
else 
	ib_moving=false
End If 

Return 0
end event

event clicked;ib_Moving = FALSE
end event

event getfocus; dw_trailergroup.event getfocus()
end event

type dw_trailergroup from pfc_cst_u_band within pfc_cst_u_band_painter
integer y = 1124
integer width = 2359
integer height = 264
integer taborder = 30
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//modify by gavin on 2009/3/3
this.is_BandType = 'TrailerGroup'
end event

event getfocus;call super::getfocus;//-- modify by gavin on 2009-03-04 ----
inv_data_design.is_curband = this.is_bandType 

/*
//modify by gavin on 2009/3/2
IF dw_header.is_CurObj <> '' THEN
	dw_header.of_AddOrDelSingleSelect(dw_header.is_CurObj,false)
END IF

IF dw_detail.is_CurObj <> '' THEN
	dw_detail.of_AddOrDelSingleSelect(dw_detail.is_CurObj,false)
END IF

IF dw_summary.is_CurObj <> '' THEN
	dw_Summary.of_AddOrDelSingleSelect(dw_Summary.is_CurObj,false)
END IF

IF dw_footer.is_CurObj <> '' THEN
	dw_Footer.of_AddOrDelSingleSelect(dw_Footer.is_CurObj,false)
END IF

//$start$ modify by gavin on 2009/3/2
IF dw_headergroup.is_CurObj <> '' THEN
	dw_headergroup.of_AddOrDelSingleSelect(dw_headergroup.is_CurObj,false)
END IF
//$end$ modify by gavin on 2009/3/2
*/

end event

event resize;call super::resize;//modify by gavin on 2009/3/4
IF IsValid(inv_data_design) THEN
	IF inv_data_design.ib_show_datagroup THEN
      this.modify("datawindow.trailer.1.height="+string(this.height))
	ELSE
		this.modify("datawindow.trailer.1.height='0'")
	END IF
END IF

end event

type st_headergroup from statictext within pfc_cst_u_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 668
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "HeaderGroup"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_headergroup.iuo_parent.ib_set_tab_order then Return

ib_moving = TRUE
il_priory[5] = this.y
il_loc= this.y

end event

event mousemove;long   ll_Y

if dw_headergroup.iuo_parent.ib_set_tab_order then Return
if ib_MouseDown and This.Pointer <> "Arrow!" then This.Pointer = "Arrow!"
if inv_data_design.ib_Mouse_Down then Return

if Not ib_MouseDown and This.Pointer <> "SizeNS!" then This.Pointer = "SizeNS!"

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.SetPosition(ToTop!)
	ll_Y = Parent.PointerY()
	IF ll_Y < dw_headergroup.y THEN
		Return 0
	END IF
	this.y = ll_Y
	il_CurrentY[5] = ll_Y
End If

end event

event mouseup;//Add by gavin on 2009/3/4
long  ll_Moved

if dw_headergroup.iuo_parent.ib_set_tab_order then Return

If UpperBound(il_CurrentY[])<1 Or UpperBound(il_PriorY[])<1 Then Return 

ll_moved =  il_CurrentY[5] - il_PriorY[5]
If this.y<>il_loc Then
	if ib_moving then
		of_Enabled_Save()		//Added by Scofield on 2010-04-29
		
		this.SetPosition(ToTop!)
	
		this.move(this.x,il_CurrentY[5])
	
		dw_headergroup.height = dw_headergroup.height + ll_moved
		
		//Modified by gavin on 2009-03-05
		dw_detail.y = this.y + this.height
		st_detail.y = dw_detail.y + dw_detail.height
		//
		dw_trailergroup.y = st_detail.y + st_detail.height
		st_trailergroup.y = dw_trailergroup.y + dw_trailergroup.height
	
		dw_summary.y = st_trailergroup.y + st_trailergroup.height
		st_summary.y = dw_summary.y + dw_summary.height
		
		dw_footer.y = st_summary.y + st_summary.height
		st_footer.y = dw_footer.y + dw_footer.height
	
		ib_moving=false
		dw_syntax.modify("datawindow.header.1.height='"+string(dw_headergroup.height)+"'")
	
	end if
	
	il_PriorY[5] = il_CurrentY[5]
	il_PriorY[2] = st_detail.y
	il_CurrentY[2] = st_detail.y
	il_PriorY[3] = st_summary.y
	il_CurrentY[3] = st_Header.y
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
	il_PriorY[6] = st_trailergroup.y
	il_CurrentY[6] = st_trailergroup.y
		
else 
	ib_moving=false
End If

Return 0
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;  dw_headergroup.event getfocus()
end event

type dw_headergroup from pfc_cst_u_band within pfc_cst_u_band_painter
integer y = 388
integer width = 2359
integer height = 264
integer taborder = 20
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//modify by gavin on 2009/3/4
this.is_BandType = 'HeaderGroup'
end event

event getfocus;call super::getfocus;//-- modify by gavin on 2009-03-04 ----
inv_data_design.is_curband = this.is_bandType 

/*
//modify by gavin on 2009/3/2
IF dw_header.is_CurObj<>'' THEN
	dw_header.of_AddOrDelSingleSelect(dw_header.is_CurObj,false)
END IF

IF dw_detail.is_CurObj<>'' THEN
	dw_detail.of_AddOrDelSingleSelect(dw_detail.is_CurObj,false)
END IF

IF dw_summary.is_CurObj<>'' THEN
	dw_Summary.of_AddOrDelSingleSelect(dw_Summary.is_CurObj,false)
END IF

IF dw_footer.is_CurObj<>'' THEN
	dw_Footer.of_AddOrDelSingleSelect(dw_Footer.is_CurObj,false)
END IF

//$start$ modify by gavin on 2009/3/2
IF dw_trailergroup.is_CurObj<>''  THEN
	dw_trailergroup.of_AddOrDelSingleSelect(dw_trailergroup.is_CurObj,false)
END IF
//$end$ modify by gavin on 2009/3/2
*/

end event

event resize;call super::resize;//modify by gavin on 2009/3/4
IF IsValid(inv_data_design) THEN
	IF inv_data_design.ib_show_datagroup THEN
      this.modify("datawindow.header.1.height="+string(this.height))
	ELSE
		this.modify("datawindow.header.1.height='0'")
	END IF
END IF
end event

type sle_tab from singlelineedit within pfc_cst_u_band_painter
boolean visible = false
integer x = 9
integer y = 160
integer width = 165
integer height = 68
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

type st_footer from statictext within pfc_cst_u_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 2140
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Footer"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_footer.iuo_parent.ib_set_tab_order then Return

ib_moving = TRUE
il_priory[4] = this.y
il_loc =this.y

end event

event mousemove;long   ll_Y

if dw_footer.iuo_parent.ib_set_tab_order then Return
if ib_MouseDown and This.Pointer <> "Arrow!" then This.Pointer = "Arrow!"
if inv_data_design.ib_Mouse_Down then Return

if Not ib_MouseDown and This.Pointer <> "SizeNS!" then This.Pointer = "SizeNS!"

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.SetPosition(ToTop!)
	ll_Y = Parent.PointerY()
	IF ll_Y <= dw_Footer.y THEN
		Return 0
	END IF
	this.y = ll_Y
	il_CurrentY[4] = ll_Y
End If

end event

event mouseup;long  ll_Moved

if dw_footer.iuo_parent.ib_set_tab_order then Return

If UpperBound(il_CurrentY[])<4 Or UpperBound(il_PriorY[])<4 Then Return 

ll_moved =  il_CurrentY[4] - il_PriorY[4]
If  this.y=il_loc then 
	 ib_moving=false
Else	 
	if ib_moving then
		of_Enabled_Save()		//Added by Scofield on 2010-04-29
		this.SetPosition(ToTop!)
		this.move(this.x,il_CurrentY[4])
	
		dw_Footer.height=dw_Footer.height + ll_moved
	
		ib_moving=false
		dw_syntax.modify("datawindow.footer.height='"+string(dw_footer.height)+"'")

	end if
End If

il_PriorY[4] = il_CurrentY[4]

Return 0

end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_footer.event getfocus()
end event

type st_summary from statictext within pfc_cst_u_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 1772
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_summary.iuo_parent.ib_set_tab_order then Return

ib_moving = TRUE
il_priory[3] = this.y
il_loc =this.y

end event

event mousemove;long   ll_Y

if dw_summary.iuo_parent.ib_set_tab_order then Return
if ib_MouseDown and This.Pointer <> "Arrow!" then This.Pointer = "Arrow!"
if inv_data_design.ib_Mouse_Down then Return

if Not ib_MouseDown and This.Pointer <> "SizeNS!" then This.Pointer = "SizeNS!"

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.SetPosition(ToTop!)
	ll_Y = Parent.PointerY()
	IF ll_Y <= dw_summary.y THEN
		Return 0
	END IF
	this.y = ll_Y
	il_CurrentY[3] = ll_Y
End If

end event

event mouseup;long  ll_Moved

if dw_summary.iuo_parent.ib_set_tab_order then Return

If UpperBound(il_CurrentY[])<3 Or UpperBound(il_PriorY[])<3 Then Return 

ll_moved =  il_CurrentY[3] - il_PriorY[3]
If  this.y=il_loc then 
	 ib_moving=false
Else	 
	if ib_moving then
		of_Enabled_Save()		//Added by Scofield on 2010-04-29
		
		this.SetPosition(ToTop!)
		this.move(this.x,il_CurrentY[3])
	
		dw_Summary.height=dw_Summary.height + ll_moved
		
		dw_footer.y = st_summary.y + st_summary.height
		st_footer.y = dw_footer.y + dw_footer.height
	
		ib_moving=false
		dw_syntax.modify("datawindow.summary.height='"+string(dw_summary.height)+"'")
	
	end if
	
	il_PriorY[3] = il_CurrentY[3]
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
End If	

Return 0

end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_summary.event getfocus()
end event

type st_detail from statictext within pfc_cst_u_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 1040
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_detail.iuo_parent.ib_set_tab_order then Return

ib_moving = TRUE
il_priory[2] = this.y
il_loc= this.y

end event

event mousemove;long   ll_Y

if dw_detail.iuo_parent.ib_set_tab_order then Return
if ib_MouseDown and This.Pointer <> "Arrow!" then This.Pointer = "Arrow!"
if inv_data_design.ib_Mouse_Down then Return

if Not ib_MouseDown and This.Pointer <> "SizeNS!" then This.Pointer = "SizeNS!"

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.SetPosition(ToTop!)
	ll_Y = Parent.PointerY()
	IF ll_Y <= dw_detail.y THEN
		Return 0
	END IF
	this.y = ll_Y
	il_CurrentY[2] = ll_Y
End If

end event

event mouseup;long  ll_Moved

if dw_detail.iuo_parent.ib_set_tab_order then Return

If UpperBound(il_CurrentY[])<2 Or UpperBound(il_PriorY[])<2 Then Return 

ll_moved =  il_CurrentY[2] - il_PriorY[2]
If  this.y=il_loc then 
	 ib_moving=false
Else	 
	if ib_moving then
		of_Enabled_Save()		//Added by Scofield on 2010-04-29
		
		this.SetPosition(ToTop!)
		this.move(this.x,il_CurrentY[2])
	
		dw_detail.height=dw_detail.height + ll_moved
		
		//Modified by gavin on 2009-03-05
		dw_trailergroup.y = st_detail.y + st_detail.height
		st_trailergroup.y = dw_trailergroup.y + dw_trailergroup.height

		dw_summary.y = st_trailergroup.y + st_trailergroup.height
		st_summary.y = dw_summary.y + dw_summary.height
		
		dw_footer.y = st_summary.y + st_summary.height
		st_footer.y = dw_footer.y + dw_footer.height
	
		ib_moving=false
		dw_syntax.modify("datawindow.detail.height='"+string(dw_detail.height)+"'")
		
	end if
	
	il_PriorY[2] = il_CurrentY[2]
	il_PriorY[3] = st_summary.y
	il_CurrentY[3] = st_Header.y
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
	il_PriorY[6] = st_trailergroup.y     //Modified by gavin on 2009-03-05
	il_CurrentY[6] = st_trailergroup.y   //Modified by gavin on 2009-03-05
End If 

Return 0

end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_detail.event getfocus()
end event

type dw_footer from pfc_cst_u_band within pfc_cst_u_band_painter
integer y = 1856
integer width = 2359
integer height = 264
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'FOOTER'
end event

event resize;this.modify("datawindow.footer.height="+string(this.height))
end event

event getfocus;call super::getfocus;//modify by gavin on 2009/3/4
inv_data_design.is_curband = this.is_bandtype

/*
IF dw_Header.is_CurObj<>''  THEN
	dw_Header.of_AddOrDelSingleSelect(dw_Header.is_CurObj,false)
END IF

IF dw_detail.is_CurObj<>''  THEN
	dw_detail.of_AddOrDelSingleSelect(dw_detail.is_CurObj,false)
END IF

IF dw_Summary.is_CurObj<>''  THEN
	dw_Summary.of_AddOrDelSingleSelect(dw_Summary.is_CurObj,false)
END IF

//$start$ modify by gavin on 2009/3/4
IF dw_headergroup.is_CurObj<>''  THEN
	dw_headergroup.of_AddOrDelSingleSelect(dw_headergroup.is_CurObj,false)
END IF

IF dw_trailergroup.is_CurObj<>''  THEN
	dw_trailergroup.of_AddOrDelSingleSelect(dw_trailergroup.is_CurObj,false)
END IF
//$end$ modify by gavin on 2009/3/4
*/

end event

type dw_summary from pfc_cst_u_band within pfc_cst_u_band_painter
integer y = 1496
integer width = 2359
integer height = 264
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'SUMMARY'
end event

event resize;this.modify("datawindow.summary.height="+string(this.height))

end event

event getfocus;call super::getfocus;//modify by gavin on 2009/3/4
inv_data_design.is_curband = this.is_bandtype

/*
IF dw_Header.is_CurObj<>''  THEN
	dw_Header.of_AddOrDelSingleSelect(dw_Header.is_CurObj,false)
END IF

IF dw_detail.is_CurObj<>''  THEN
	dw_detail.of_AddOrDelSingleSelect(dw_detail.is_CurObj,false)
END IF

IF dw_footer.is_CurObj<>''  THEN
	dw_Footer.of_AddOrDelSingleSelect(dw_Footer.is_CurObj,false)
END IF

//$start$ modify by gavin on 2009/3/4
IF dw_headergroup.is_CurObj<>''  THEN
	dw_headergroup.of_AddOrDelSingleSelect(dw_headergroup.is_CurObj,false)
END IF

IF dw_trailergroup.is_CurObj<>''  THEN
	dw_trailergroup.of_AddOrDelSingleSelect(dw_trailergroup.is_CurObj,false)
END IF
//$end$ modify by gavin on 2009/3/4
*/

end event

type dw_detail from pfc_cst_u_band within pfc_cst_u_band_painter
integer y = 760
integer width = 2359
integer height = 264
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'DETAIL'
end event

event resize;this.modify("datawindow.detail.height="+string(this.height))

end event

event getfocus;call super::getfocus;//modify by gavin on 2009/3/4
inv_data_design.is_curband = this.is_bandtype

/*
IF dw_Header.is_CurObj<>'' THEN
	dw_Header.of_AddOrDelSingleSelect(dw_Header.is_CurObj,false)
END IF

IF dw_summary.is_CurObj<>'' THEN
	dw_Summary.of_AddOrDelSingleSelect(dw_Summary.is_CurObj,false)
END IF

IF dw_footer.is_CurObj<>'' THEN
	dw_Footer.of_AddOrDelSingleSelect(dw_Footer.is_CurObj,false)
END IF

//$start$ modify by gavin on 2009/3/2
IF dw_headergroup.is_CurObj<>'' THEN
	dw_headergroup.of_AddOrDelSingleSelect(dw_headergroup.is_CurObj,false)
END IF

IF dw_trailergroup.is_CurObj<>'' THEN
	dw_trailergroup.of_AddOrDelSingleSelect(dw_trailergroup.is_CurObj,false)
END IF
//$end$ modify by gavin on 2009/3/2
*/

end event

event ue_calc_tab_position;call super::ue_calc_tab_position;IF iuo_parent.ib_set_tab_order THEN
	String ls_selected_object_name
	ls_selected_object_name = iuo_parent.is_last_tab_label_name
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.16.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ) ) - Long( dw_detail.Describe("datawindow.HorizontalScrollPosition"))
	sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) - Long( dw_detail.Describe("datawindow.VerticalScrollPosition")) +  Long( dw_detail.Describe("Datawindow.Header.Height") )
	*/
	long ll_max,ll_mun
	If appeongetclienttype() = 'PB' Then
		sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ) ) - Long( dw_detail.Describe("datawindow.HorizontalScrollPosition"))
	Else
//		sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ) ) - PixelsToUnits(long(dw_detail.Describe("datawindow.HorizontalScrollPosition")),XPixelsToUnits! )

		
		If Long( dw_detail.Describe("datawindow.HorizontalScrollPosition")) > 0 then
			ll_max = 36
		Else
			ll_max = 0
		End If
		If iuo_parent.ib_clicked Then
			ll_mun = Long( dw_detail.Describe("datawindow.HorizontalScrollPosition"))
			If ll_mun > 123 And ll_mun <= 188 Then
				sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ))  - ll_mun*5 + (ll_mun - 123)
			ElseIf ll_mun > 188 Then 
//				If isvalid(w_contract_data_design) Then     //modify by gavin on 2009/3/4
				IF IsValid(inv_data_design) THEN
					If iw_parentwin.windowstate = maximized! Then
						If iuo_parent.ii_screen_id = 1 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 6 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 7 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 12 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 13 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 19 Then
							ll_mun = 249
						ElseIf iuo_parent.ii_screen_id = 23 Then
							ll_mun = 30
						ElseIf iuo_parent.ii_screen_id = 25 Then
							If ll_mun > 213 And ll_mun < 259 Then
								ll_mun = 228
							ElseIf ll_mun > 259 And ll_mun < 360 Then
								ll_mun = 366
							ElseIf ll_mun > 360 Then
								ll_mun = 388
							Else
								ll_mun = 188
							End If
						ElseIf iuo_parent.ii_screen_id = 26 Then
							ll_mun = 40
						ElseIf iuo_parent.ii_screen_id = 28 Then
							If ll_mun > 213 And ll_mun < 259 Then
								ll_mun = 228
							ElseIf ll_mun > 259 And ll_mun < 360 Then
								ll_mun = 336
							ElseIf ll_mun > 360 And ll_mun < 439 Then
								ll_mun = 438
							ElseIf ll_mun >= 439 And ll_mun < 560 Then
								ll_mun = 498
							ElseIf ll_mun > 560 And ll_mun < 1000  Then
								ll_mun = 400 + ll_mun/2
							ElseIf ll_mun > 1000 And ll_mun < 1816 Then
								ll_mun =  131 + ll_mun
							ElseIf ll_mun >= 1816 And ll_mun < 1880 Then
								ll_mun = ll_mun
							ElseIf ll_mun >= 1880 Then
								ll_mun = 2021
							Else
								ll_mun = 188
							End If
						ElseIf iuo_parent.ii_screen_id = 31 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 32 Then
							ll_mun = 90
						ElseIf iuo_parent.ii_screen_id = 33 Then
							ll_mun = 100
						ElseIf iuo_parent.ii_screen_id = 45 Then
							ll_mun = 70
						ElseIf iuo_parent.ii_screen_id = 47 Then
							ll_mun = 30
						ElseIf iuo_parent.ii_screen_id = 48 Then  
							ll_mun = -24
						End If
					Else	
						If iuo_parent.ii_screen_id = 1 Then		 //Search->Search Criteria  Ok
							ll_mun = 198
						ElseIf iuo_parent.ii_screen_id = 6 Then	 //Details->Contracted Company Contact  ok
							ll_mun = 0
						ElseIf iuo_parent.ii_screen_id = 7 Then	 //Details->Our Company Contact  ok
							ll_mun = 0
						ElseIf iuo_parent.ii_screen_id = 12 Then  //Requirements->Profile Detail  ?
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 13 Then  //Requirements->Profile Detail
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 19 Then	 //Locations->Facilities   OK
							ll_mun = 340
						ElseIf iuo_parent.ii_screen_id = 23 Then	 //Organizations->Address   Ok
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 25 Then	 //Organizations->Organization Contacts  ?
							If ll_mun > 213 And ll_mun < 259 Then
								ll_mun = 228
							ElseIf ll_mun > 259 And ll_mun < 360 Then
								ll_mun = 306
							ElseIf ll_mun > 360 Then
								ll_mun = 468
							Else
								ll_mun = 188
							End If
						ElseIf iuo_parent.ii_screen_id = 26 Then	 //Fee Schedules->Browse Tab->Fee Schedules  Ok
							ll_mun = 130
						ElseIf iuo_parent.ii_screen_id = 28 Then	 //Fee Schedules->Browse Tab->Fees  ?
							If ll_mun > 213 And ll_mun < 259 Then
								ll_mun = 228
							ElseIf ll_mun > 259 And ll_mun < 360 Then
								ll_mun = 336
							ElseIf ll_mun > 360 And ll_mun < 439 Then
								ll_mun = 438
							ElseIf ll_mun >= 439 And ll_mun < 560 Then
								ll_mun = 498
							ElseIf ll_mun > 560 And ll_mun < 1000  Then
								ll_mun = 400 + ll_mun/2
							ElseIf ll_mun > 1000 And ll_mun < 1816 Then
								ll_mun = 201 + ll_mun
							ElseIf ll_mun >= 1816 And ll_mun < 1880 Then
								ll_mun = ll_mun
							ElseIf ll_mun >= 1880 Then
								ll_mun = 2126
							Else
								ll_mun = 188
							End If
						ElseIf iuo_parent.ii_screen_id = 31 Then  //Fee Schedule (NM)->Fee Schedule (Non Healthcare)
					   	ll_mun = 190
						ElseIf iuo_parent.ii_screen_id = 32 Then  //Document Manager->Document Tab->Search Criteria
						   ll_mun = 182
						ElseIf iuo_parent.ii_screen_id = 33 Then  //Action Items->Action Item List
					   	ll_mun = 188
						ElseIf iuo_parent.ii_screen_id = 45 Then  //Document Manager->Work Flow Tab->Search Criteria
					   	ll_mun = 164
						ElseIf iuo_parent.ii_screen_id = 47 Then  //Document Manager->Work Flow Tab->Action Item Detail
					   	ll_mun = 120
						ElseIf iuo_parent.ii_screen_id = 48 Then  //Document Manager->Audit Trail Tab->Search Criteria
							ll_mun = 70
						End If
					End If
				End If
				sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ))  - ll_mun*5 + (ll_mun - 133)
			Else	
				sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ))  - ll_mun*5
			End If
			
		Else
			sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" )) + ll_max - Long( dw_detail.Describe("datawindow.HorizontalScrollPosition"))*5 
		End If
	End If
	
	//$<modify> 01.07.2008 by: Andy
	//Reason:Should consider the height of group header. bug:BugJ122701
	If iuo_parent.ii_screen_id = 12 And appeongetclienttype() = 'WEB' Then
		//sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) - Long( dw_detail.Describe("datawindow.VerticalScrollPosition")) +  Long( dw_detail.Describe("Datawindow.Header.Height")) + 100
		sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) + 100
	ElseIf iuo_parent.ii_screen_id = 13 And appeongetclienttype() = 'WEB' Then
		//sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) - Long( dw_detail.Describe("datawindow.VerticalScrollPosition")) +  Long( dw_detail.Describe("Datawindow.Header.Height")) + 80
		sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) + 80
	Else
		//sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) - Long( dw_detail.Describe("datawindow.VerticalScrollPosition")) +  Long( dw_detail.Describe("Datawindow.Header.Height"))
		if Long( dw_detail.Describe("Datawindow.Header.1.Height")) > 0 then
			sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) + Long( dw_detail.Describe("Datawindow.Header.1.Height"))
		else
			sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" ))
		end if
	End If		
	//end of modify 01.07.2008
	
	//---------------------------- APPEON END ----------------------------
	
	IF sle_tab.x >= this.x AND sle_tab.x <= this.x + This.width AND sle_tab.y >= this.y AND sle_tab.y <= this.y + This.height THEN 
		IF sle_tab.text <> "" THEN
			sle_tab.Visible = TRUE
		
			sle_tab.SetFocus()
			sle_tab.BringToTop = True
			
			sle_tab.SelectText(1,100)			
		END IF
	ELSE		
		sle_tab.Visible = FALSE
	END IF
END IF

end event

event scrollhorizontal;call super::scrollhorizontal;//iuo_parent.ib_clicked = False   	
//This.Event ue_calc_tab_position()
end event

event scrollvertical;call super::scrollvertical;//This.Event ue_calc_tab_position()
end event

type dw_header from pfc_cst_u_band within pfc_cst_u_band_painter
integer y = 4
integer width = 2359
integer height = 264
integer taborder = 20
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'HEADER'

end event

event resize;this.modify("datawindow.header.height="+string(this.height))
end event

event getfocus;call super::getfocus;//modify by gavin on 2009/3/4
inv_data_design.is_curband = this.is_bandtype

/*
IF dw_detail.is_CurObj<>''  THEN
	dw_detail.of_AddOrDelSingleSelect(dw_detail.is_CurObj,false)
END IF

IF dw_summary.is_CurObj<>'' THEN
	dw_Summary.of_AddOrDelSingleSelect(dw_Summary.is_CurObj,false)
END IF

IF dw_footer.is_CurObj<>'' THEN
	dw_Footer.of_AddOrDelSingleSelect(dw_Footer.is_CurObj,false)
END IF

//$start$ modify by gavin on 2009/3/2
IF dw_headergroup.is_CurObj<>''  THEN
	dw_headergroup.of_AddOrDelSingleSelect(dw_headergroup.is_CurObj,false)
END IF

IF dw_trailergroup.is_CurObj<>''  THEN
	dw_trailergroup.of_AddOrDelSingleSelect(dw_trailergroup.is_CurObj,false)
END IF
//$end$ modify by gavin on 2009/3/2
*/

end event

type st_header from statictext within pfc_cst_u_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 308
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Header"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_header.iuo_parent.ib_set_tab_order then Return

ib_moving = TRUE
il_priory[1] = this.y
il_loc= this.y

end event

event mousemove;long   ll_Y

if dw_header.iuo_parent.ib_set_tab_order then Return
if ib_MouseDown and This.Pointer <> "Arrow!" then This.Pointer = "Arrow!"
if inv_data_design.ib_Mouse_Down then Return

if Not ib_MouseDown and This.Pointer <> "SizeNS!" then This.Pointer = "SizeNS!"

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.SetPosition(ToTop!)
	ll_Y = Parent.PointerY()
	IF ll_Y < dw_header.y THEN
		Return 0
	END IF
	this.y = ll_Y
	il_CurrentY[1] = ll_Y
End If

end event

event mouseup;long  ll_Moved

if dw_header.iuo_parent.ib_set_tab_order then Return

If UpperBound(il_CurrentY[])<1 Or UpperBound(il_PriorY[])<1 Then Return

ll_moved =  il_CurrentY[1] - il_PriorY[1]
If this.y<>il_loc Then
	if ib_moving then
		of_Enabled_Save()		//Added by Scofield on 2010-04-29
		
		this.SetPosition(ToTop!)
	
		this.move(this.x,il_CurrentY[1])
	
		dw_header.height=dw_header.height + ll_moved
		
		//modify by gavin on 2009/3/5
		dw_headergroup.y = this.y + this.height
		st_headergroup.y = dw_headergroup.y + dw_headergroup.height
			
		dw_detail.y = st_headergroup.y + st_headergroup.height
		st_detail.y = dw_detail.y + dw_detail.height
	
		dw_trailergroup.y = st_detail.y + st_detail.height
		st_trailergroup.y = dw_trailergroup.y + dw_trailergroup.height
		
		dw_summary.y = st_trailergroup.y + st_trailergroup.height
		st_summary.y = dw_summary.y + dw_summary.height
				
		dw_footer.y = st_summary.y + st_summary.height
		st_footer.y = dw_footer.y + dw_footer.height

		ib_moving=false
		dw_syntax.modify("datawindow.header.height='"+string(dw_header.height)+"'")
	
	end if
	
	il_PriorY[1] = il_CurrentY[1]
	il_PriorY[2] = st_detail.y
	il_CurrentY[2] = st_detail.y
	il_PriorY[3] = st_summary.y
	il_CurrentY[3] = st_Header.y
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
	il_PriorY[5] = st_headergroup.y
	il_CurrentY[5] = st_headergroup.y
	il_PriorY[6] = st_trailergroup.y
	il_CurrentY[6] = st_trailergroup.y
else 
	ib_moving=false
End If 

Return 0

end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_header.event getfocus()
end event

type dw_ruler from datawindow within pfc_cst_u_band_painter
event lbuttondown pbm_lbuttondown
event key pbm_dwnkey
integer y = 4
integer width = 2917
integer height = 2504
integer taborder = 10
string title = "none"
string dataobject = "d_screen_design"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event lbuttondown;if inv_data_design.ib_Set_Tab_Order then Return

Parent.Event lbuttondown(Flags,This.X + XPos,This.Y + YPos)

end event

event key;//====================================================================
// Event: key()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    keycode         key
// 	value    unsignedlong    keyflags
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-30
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

if inv_data_design.ib_Set_Tab_Order then Return

if Key = KeyEnter! then
	inv_Data_Design.Event ue_Properties()
	Return 1
end if

inv_data_design.Post Event Key(key,keyflags)

end event

event clicked;//BEGIN---Modify by Scofield on 2009-04-24
if inv_data_design.ib_Set_Tab_Order then Return
//when attribute is opened  the selected object isnot unselect all obj
If IsValid( w_contract_field_properties ) Or IsValid( w_contract_mul_field_properties ) Then Return //added by gavins 20120309 grid 


if Not KeyDown(KeyControl!) then
	inv_data_design.of_UnSelectAllObject()
end if
//END---Modify by Scofield on 2009-04-24

end event

type st_left from statictext within pfc_cst_u_band_painter
boolean visible = false
integer x = 480
integer y = 112
integer width = 5
integer height = 1140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 0
boolean focusrectangle = false
end type

type st_up from statictext within pfc_cst_u_band_painter
boolean visible = false
integer x = 480
integer y = 112
integer width = 1591
integer height = 4
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 0
boolean focusrectangle = false
end type

type st_right from statictext within pfc_cst_u_band_painter
boolean visible = false
integer x = 2066
integer y = 112
integer width = 5
integer height = 1140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 0
boolean focusrectangle = false
end type

type st_down from statictext within pfc_cst_u_band_painter
boolean visible = false
integer x = 480
integer y = 1248
integer width = 1591
integer height = 4
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 0
boolean focusrectangle = false
end type

type dw_syntax from u_dw within pfc_cst_u_band_painter
boolean visible = false
integer x = 549
integer y = 1424
integer width = 791
integer height = 184
integer taborder = 20
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//<add> 11/13/2007 by: Andy
of_setbase( true)
inv_base.of_setrequestor(this)
//$<add> 01.10.2008 By: Andy
This.of_SetUpdateable(False)

end event

