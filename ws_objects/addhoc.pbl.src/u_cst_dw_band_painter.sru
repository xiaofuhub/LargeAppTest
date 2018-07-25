$PBExportHeader$u_cst_dw_band_painter.sru
forward
global type u_cst_dw_band_painter from userobject
end type
type dw_trailergroup3 from u_cst_dw_band within u_cst_dw_band_painter
end type
type dw_trailergroup2 from u_cst_dw_band within u_cst_dw_band_painter
end type
type st_trailergroup3 from statictext within u_cst_dw_band_painter
end type
type st_trailergroup2 from statictext within u_cst_dw_band_painter
end type
type dw_headergroup3 from u_cst_dw_band within u_cst_dw_band_painter
end type
type dw_headergroup2 from u_cst_dw_band within u_cst_dw_band_painter
end type
type st_headergroup3 from statictext within u_cst_dw_band_painter
end type
type st_headergroup2 from statictext within u_cst_dw_band_painter
end type
type st_trailergroup from statictext within u_cst_dw_band_painter
end type
type dw_trailergroup from u_cst_dw_band within u_cst_dw_band_painter
end type
type st_headergroup from statictext within u_cst_dw_band_painter
end type
type dw_headergroup from u_cst_dw_band within u_cst_dw_band_painter
end type
type sle_tab from singlelineedit within u_cst_dw_band_painter
end type
type st_footer from statictext within u_cst_dw_band_painter
end type
type st_summary from statictext within u_cst_dw_band_painter
end type
type st_detail from statictext within u_cst_dw_band_painter
end type
type dw_footer from u_cst_dw_band within u_cst_dw_band_painter
end type
type dw_summary from u_cst_dw_band within u_cst_dw_band_painter
end type
type dw_detail from u_cst_dw_band within u_cst_dw_band_painter
end type
type dw_header from u_cst_dw_band within u_cst_dw_band_painter
end type
type st_header from statictext within u_cst_dw_band_painter
end type
type dw_ruler from datawindow within u_cst_dw_band_painter
end type
type st_left from statictext within u_cst_dw_band_painter
end type
type st_up from statictext within u_cst_dw_band_painter
end type
type st_right from statictext within u_cst_dw_band_painter
end type
type st_down from statictext within u_cst_dw_band_painter
end type
type dw_syntax from u_dw within u_cst_dw_band_painter
end type
end forward

global type u_cst_dw_band_painter from userobject
integer width = 3232
integer height = 2596
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
long backcolor = 67108864
string text = "none"
integer unitspercolumn = 250
integer columnsperpage = 50
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
dw_trailergroup3 dw_trailergroup3
dw_trailergroup2 dw_trailergroup2
st_trailergroup3 st_trailergroup3
st_trailergroup2 st_trailergroup2
dw_headergroup3 dw_headergroup3
dw_headergroup2 dw_headergroup2
st_headergroup3 st_headergroup3
st_headergroup2 st_headergroup2
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
global u_cst_dw_band_painter u_cst_dw_band_painter

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-06 By: Andy
boolean			ib_Moving = FALSE
long				il_CurrentY[],il_PriorY[]
long				il_loc

//---------------------------- APPEON END ----------------------------

// add by gavin 2009/3/2
u_cst_dw_design inv_data_design
Boolean     ib_group = false
// add by gavin 2009/3/2

long		il_OriginX,il_OriginY
long		il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight
Boolean	ib_MouseDown

long		ll_RectBackColor = RGB(63,63,63)

CONSTANT LONG BANDSEPHEIGHT = 60

long il_OldPositionY
statictext ist_spliter
datawindow idw_band
end variables

forward prototypes
public function integer of_set_parent (u_cst_dw_design anv_data_design)
public subroutine of_hide_rectangle_frame ()
public subroutine of_modify_rectangle_frame ()
public subroutine of_show_rectangle_frame ()
public subroutine of_selectobjectsinrectframe ()
public subroutine of_enabled_save ()
public function integer of_mouseup ()
public function integer of_mousemove (statictext ast_spliter, datawindow adw_band)
public function integer of_resize ()
public function integer of_mousedown ()
public function integer of_headergroupmenu ()
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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
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

end event

public function integer of_set_parent (u_cst_dw_design anv_data_design);//Add by gavin on 2009/3/4
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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

dw_header.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_headergroup.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_headergroup2.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_headergroup3.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)

dw_detail.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_trailergroup.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_trailergroup2.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)
dw_trailergroup3.of_RectFrameSelectObject(il_RectFrameX,il_RectFrameY,il_RectFrameWidth,il_RectFrameHeight)

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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

if IsValid(m_pfe_cst_contract_data_design) then
	m_pfe_cst_contract_data_design.m_file.m_save.Enabled = true
end if

end subroutine

public function integer of_mouseup ();//////////////////////////////////////////////////////////////////////
// $<function> of_mouseup
// $<arguments>
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.26.2010
//////////////////////////////////////////////////////////////////////

long ll_Moved

if inv_data_design.ib_set_tab_order then Return -1
if not ib_Moving then Return -1

ib_Moving = false
ll_Moved =  ist_spliter.Y - il_OldPositionY
if ll_Moved = 0 then Return -1
	
of_Enabled_Save()
ist_spliter.SetPosition(ToTop!)
idw_band.height += ll_Moved
 if AppeonGetClientType() = "WEB" then this.setredraw(false)  //(Appeon)Harry 05.07.2014 - for Bug #4021
choose case ist_spliter.ClassName()
	case "st_header"
		dw_syntax.modify("datawindow.header.height='" + string(idw_band.height) + "'")
	//
	case "st_headergroup"
		dw_syntax.modify("datawindow.header.1.height='" + string(idw_band.height) + "'")
	case "st_headergroup2"
		dw_syntax.modify("datawindow.header.2.height='" + string(idw_band.height) + "'")
	case "st_headergroup3"
		dw_syntax.modify("datawindow.header.3.height='" + string(idw_band.height) + "'")
		
	case "st_detail"
		dw_syntax.modify("datawindow.detail.height='" + string(idw_band.height) + "'")
	//
	case "st_trailergroup3"
		dw_syntax.modify("datawindow.trailer.3.height='" + string(idw_band.height) + "'")
	case "st_trailergroup2"
		dw_syntax.modify("datawindow.trailer.2.height='" + string(idw_band.height) + "'")
	case "st_trailergroup"
		dw_syntax.modify("datawindow.trailer.1.height='" + string(idw_band.height) + "'")
	//
	case "st_summary"
		dw_syntax.modify("datawindow.summary.height='" + string(idw_band.height) + "'")
	case "st_footer"
		dw_syntax.modify("datawindow.footer.height='" + string(idw_band.height) + "'")
end choose

of_Resize()
 if AppeonGetClientType() = "WEB" then this.setredraw(true)  //(Appeon)Harry 05.07.2014 - for Bug #4021
Return 1
end function

public function integer of_mousemove (statictext ast_spliter, datawindow adw_band);//////////////////////////////////////////////////////////////////////
// $<function> of_mousemove
// $<arguments>
//			statictext	ast_spliter
//			datawindow	adw_band
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.26.2010
//////////////////////////////////////////////////////////////////////

long ll_Y

idw_band = adw_band
ist_spliter = ast_spliter
if inv_data_design.ib_set_tab_order then Return -1

if ib_MouseDown and ist_spliter.Pointer <> "Arrow!" then
	ist_spliter.Pointer = "Arrow!"
end if

if inv_data_design.ib_Mouse_Down then Return -1
if not ib_MouseDown and ist_spliter.Pointer <> "SizeNS!" then
	ist_spliter.Pointer = "SizeNS!"
end if

if ib_Moving And KeyDown(KeyLeftButton!) then
	ist_spliter.SetPosition(ToTop!)
	ll_Y = this.PointerY() - 25
	if ll_Y < adw_band.Y then
		ist_spliter.Y = adw_band.Y
	else
		ist_spliter.Y = ll_Y
	end if
end if

Return 1
end function

public function integer of_resize ();//////////////////////////////////////////////////////////////////////
// $<function> of_resize
// $<arguments>
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.26.2010
//////////////////////////////////////////////////////////////////////

// Header position
dw_header.y = dw_ruler.Y
dw_Header.width = dw_ruler.width
st_header.y = dw_header.y + dw_header.height + 4
st_header.width = dw_header.width

// Header group 1 position
if dw_headergroup.visible then
	dw_headergroup.y = st_header.y + st_header.height + 4
	dw_headergroup.width = dw_header.width 
	st_headergroup.y = dw_headergroup.y + dw_headergroup.height + 4
	st_headergroup.width = dw_header.width
end if

// Header group 2 position
if dw_headergroup2.visible then
	dw_headergroup2.y = st_headergroup.y + st_headergroup.height + 4
	dw_headergroup2.width = dw_header.width 
	st_headergroup2.y = dw_headergroup2.y + dw_headergroup2.height + 4
	st_headergroup2.width = dw_header.width
end if

// Header group 3 position
if dw_headergroup3.visible then
	dw_headergroup3.y = st_headergroup2.y + st_headergroup2.height + 4
	dw_headergroup3.width = dw_header.width 
	st_headergroup3.y = dw_headergroup3.y + dw_headergroup3.height + 4
	st_headergroup3.width = dw_header.width
end if

// Detail position
if st_headergroup3.visible then
	dw_detail.y = st_headergroup3.y + st_headergroup3.height + 4
elseif st_headergroup2.visible then
	dw_detail.y = st_headergroup2.y + st_headergroup2.height + 4
elseif st_headergroup.visible then
	dw_detail.y = st_headergroup.y + st_headergroup.height + 4
else
	dw_detail.y = st_header.y + st_header.height + 4
end if
dw_detail.width = dw_header.width 
st_detail.y = dw_detail.y + dw_detail.height + 4
st_detail.width = dw_header.width

// Trailer group 3 position
if dw_trailergroup3.visible then	
	dw_trailergroup3.y = st_detail.y + st_detail.height + 4
	dw_trailergroup3.width = dw_header.width 
	st_trailergroup3.y = dw_trailergroup3.y + dw_trailergroup3.height + 4
	st_trailergroup3.width = dw_header.width
end if

// Trailer group 2 position
if dw_trailergroup2.visible then
	if st_trailergroup3.visible then
		dw_trailergroup2.y = st_trailergroup3.y + st_trailergroup3.height + 4
	else
		dw_trailergroup2.y = st_detail.y + st_detail.height + 4
	end if
	dw_trailergroup2.width = dw_header.width
	st_trailergroup2.y = dw_trailergroup2.y + dw_trailergroup2.height + 4
	st_trailergroup2.width = dw_header.width
end if

// Trailer group 1 position
if dw_trailergroup.visible then
	if st_trailergroup2.visible then
		dw_trailergroup.y = st_trailergroup2.y + st_trailergroup2.height + 4
	else
		dw_trailergroup.y = st_detail.y + st_detail.height + 4
	end if
	dw_trailergroup.width = dw_header.width 
	st_trailergroup.y = dw_trailergroup.y + dw_trailergroup.height + 4
	st_trailergroup.width = dw_header.width
end if

// Summary position
if st_trailergroup.visible then
	dw_summary.y = st_trailergroup.y + st_trailergroup.height + 4	
else
	dw_summary.y = st_detail.y + st_detail.height + 4
end if
dw_summary.width = dw_header.width 
st_summary.y = dw_summary.y + dw_summary.height + 4
st_summary.width = dw_header.width

// Footer position
dw_footer.y = st_summary.y + st_summary.height + 4
dw_footer.width = dw_header.width 
st_footer.y = dw_footer.y + dw_footer.height + 4
st_footer.width = dw_header.width

Return 1
end function

public function integer of_mousedown ();//////////////////////////////////////////////////////////////////////
// $<function> of_mousedown
// $<arguments>
//			statictext	ast_spliter
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.26.2010
//////////////////////////////////////////////////////////////////////

if inv_data_design.ib_set_tab_order then
	Return -1
end if

ib_Moving = true
il_OldPositionY = ist_spliter.y

Return 1
end function

public function integer of_headergroupmenu ();//////////////////////////////////////////////////////////////////////
// $<function> of_HeaderGroupMenu
// $<arguments>
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.27.2010
//////////////////////////////////////////////////////////////////////

m_screen_design_rmb_rpt lnv_menu

lnv_menu = Create m_screen_design_rmb_rpt
lnv_menu.uf_set_parent(inv_data_design)

lnv_menu.m_groupedit.PopMenu(inv_data_design.PointerX(), inv_data_design.PointerY())
Destroy lnv_menu

Return 1
end function

on u_cst_dw_band_painter.create
this.dw_trailergroup3=create dw_trailergroup3
this.dw_trailergroup2=create dw_trailergroup2
this.st_trailergroup3=create st_trailergroup3
this.st_trailergroup2=create st_trailergroup2
this.dw_headergroup3=create dw_headergroup3
this.dw_headergroup2=create dw_headergroup2
this.st_headergroup3=create st_headergroup3
this.st_headergroup2=create st_headergroup2
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
this.Control[]={this.dw_trailergroup3,&
this.dw_trailergroup2,&
this.st_trailergroup3,&
this.st_trailergroup2,&
this.dw_headergroup3,&
this.dw_headergroup2,&
this.st_headergroup3,&
this.st_headergroup2,&
this.st_trailergroup,&
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

on u_cst_dw_band_painter.destroy
destroy(this.dw_trailergroup3)
destroy(this.dw_trailergroup2)
destroy(this.st_trailergroup3)
destroy(this.st_trailergroup2)
destroy(this.dw_headergroup3)
destroy(this.dw_headergroup2)
destroy(this.st_headergroup3)
destroy(this.st_headergroup2)
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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

st_Left.BackColor = ll_RectBackColor
st_Up.BackColor = ll_RectBackColor
st_Right.BackColor = ll_RectBackColor
st_Down.BackColor = ll_RectBackColor

end event

type dw_trailergroup3 from u_cst_dw_band within u_cst_dw_band_painter
integer y = 1116
integer width = 2359
integer height = 40
integer taborder = 20
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//modify by gavin on 2009/3/3
this.is_BandType = "TRAILER.3"
end event

event getfocus;call super::getfocus;inv_data_design.is_curband = this.is_bandType
end event

event resize;call super::resize;//modify by gavin on 2009/3/4
IF IsValid(inv_data_design) THEN
	IF inv_data_design.ib_show_datagroup THEN
      this.modify("datawindow.trailer.3.height="+string(this.height))
	ELSE
		this.modify("datawindow.trailer.3.height='0'")
	END IF
END IF

end event

type dw_trailergroup2 from u_cst_dw_band within u_cst_dw_band_painter
integer y = 1240
integer width = 2359
integer height = 40
integer taborder = 40
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//modify by gavin on 2009/3/3
this.is_BandType = "TRAILER.2"
end event

event getfocus;call super::getfocus;inv_data_design.is_curband = this.is_bandType
end event

event resize;call super::resize;//modify by gavin on 2009/3/4
IF IsValid(inv_data_design) THEN
	IF inv_data_design.ib_show_datagroup THEN
      this.modify("datawindow.trailer.2.height="+string(this.height))
	ELSE
		this.modify("datawindow.trailer.2.height='0'")
	END IF
END IF

end event

type st_trailergroup3 from statictext within u_cst_dw_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 1168
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "3: trailer group"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_trailergroup3)
end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_trailergroup3.event getfocus()
end event

type st_trailergroup2 from statictext within u_cst_dw_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 1292
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "2: trailer group"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_trailergroup2)
end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_trailergroup2.event getfocus()
end event

type dw_headergroup3 from u_cst_dw_band within u_cst_dw_band_painter
integer y = 624
integer width = 2359
integer height = 40
integer taborder = 30
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//modify by gavin on 2009/3/4
this.is_BandType = "HEADER.3"
end event

event getfocus;call super::getfocus;inv_data_design.is_curband = this.is_bandType
end event

event resize;call super::resize;//modify by gavin on 2009/3/4
IF IsValid(inv_data_design) THEN
	IF inv_data_design.ib_show_datagroup THEN
      this.modify("datawindow.header.3.height="+string(this.height))
	ELSE
		this.modify("datawindow.header.3.height='0'")
	END IF
END IF
end event

type dw_headergroup2 from u_cst_dw_band within u_cst_dw_band_painter
integer y = 500
integer width = 2359
integer height = 40
integer taborder = 30
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//modify by gavin on 2009/3/4
this.is_BandType = "HEADER.2"
end event

event getfocus;call super::getfocus;inv_data_design.is_curband = this.is_bandType 
end event

event resize;call super::resize;//modify by gavin on 2009/3/4
IF IsValid(inv_data_design) THEN
	IF inv_data_design.ib_show_datagroup THEN
      this.modify("datawindow.header.2.height="+string(this.height))
	ELSE
		this.modify("datawindow.header.2.height='0'")
	END IF
END IF
end event

type st_headergroup3 from statictext within u_cst_dw_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 676
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "3: header group"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_headergroup3)
end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_headergroup3.event getfocus()
end event

event rbuttondown;ist_spliter = this
of_HeaderGroupMenu()
end event

type st_headergroup2 from statictext within u_cst_dw_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 552
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "2: header group"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_headergroup2)

end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_headergroup2.event getfocus()
end event

event rbuttondown;ist_spliter = this
of_HeaderGroupMenu()
end event

type st_trailergroup from statictext within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "1: trailer group"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_trailergroup)
end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_trailergroup.event getfocus()
end event

type dw_trailergroup from u_cst_dw_band within u_cst_dw_band_painter
integer y = 1364
integer width = 2359
integer height = 40
integer taborder = 30
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//modify by gavin on 2009/3/3
this.is_BandType = "TRAILER.1"
end event

event getfocus;call super::getfocus;inv_data_design.is_curband = this.is_bandType
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

type st_headergroup from statictext within u_cst_dw_band_painter
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 432
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "1: header group"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_headergroup)
end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_headergroup.event getfocus()
end event

event rbuttondown;ist_spliter = this
of_HeaderGroupMenu()
end event

type dw_headergroup from u_cst_dw_band within u_cst_dw_band_painter
integer y = 380
integer width = 2359
integer height = 40
integer taborder = 20
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//modify by gavin on 2009/3/4
this.is_BandType = "HEADER.1"
end event

event getfocus;call super::getfocus;inv_data_design.is_curband = this.is_bandType
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

type sle_tab from singlelineedit within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_footer from statictext within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Footer"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_footer)
end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_footer.event getfocus()
end event

type st_summary from statictext within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_summary)
end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_summary.event getfocus()
end event

type st_detail from statictext within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_detail)
end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_detail.event getfocus()
end event

type dw_footer from u_cst_dw_band within u_cst_dw_band_painter
integer y = 1856
integer width = 2359
integer height = 264
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
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

type dw_summary from u_cst_dw_band within u_cst_dw_band_painter
integer y = 1496
integer width = 2359
integer height = 264
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
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

type dw_detail from u_cst_dw_band within u_cst_dw_band_painter
integer y = 760
integer width = 2359
integer height = 264
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
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

type dw_header from u_cst_dw_band within u_cst_dw_band_painter
integer y = 4
integer width = 2359
integer height = 264
integer taborder = 20
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
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

type st_header from statictext within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Header"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;of_MouseDown()
end event

event mousemove;of_MouseMove(this, dw_header)
end event

event mouseup;of_MouseUp()
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_header.event getfocus()
end event

type dw_ruler from datawindow within u_cst_dw_band_painter
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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
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

if Not KeyDown(KeyControl!) then
	inv_data_design.of_UnSelectAllObject()
end if
//END---Modify by Scofield on 2009-04-24

end event

type st_left from statictext within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long backcolor = 0
boolean focusrectangle = false
end type

type st_up from statictext within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long backcolor = 0
boolean focusrectangle = false
end type

type st_right from statictext within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long backcolor = 0
boolean focusrectangle = false
end type

type st_down from statictext within u_cst_dw_band_painter
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
string facename = "MS Sans Serif"
long backcolor = 0
boolean focusrectangle = false
end type

type dw_syntax from u_dw within u_cst_dw_band_painter
boolean visible = false
integer x = 549
integer y = 1424
integer width = 791
integer height = 184
integer taborder = 20
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;//<add> 11/13/2007 by: Andy
of_setbase( true)
inv_base.of_setrequestor(this)
//$<add> 01.10.2008 By: Andy
This.of_SetUpdateable(False)

end event

