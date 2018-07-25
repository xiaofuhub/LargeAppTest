$PBExportHeader$u_cst_dw_band.sru
forward
global type u_cst_dw_band from u_dw
end type
end forward

global type u_cst_dw_band from u_dw
integer width = 494
integer height = 360
integer taborder = 10
event ue_regenerate ( )
event ue_postopen ( )
event ue_key pbm_dwnkey
event ue_calc_tab_position ( )
event ue_mouse_move pbm_dwnmousemove
event ue_regenerate_01 ( )
end type
global u_cst_dw_band u_cst_dw_band

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
end prototypes

type variables

datawindow idw_syntax
long   	cil_HighLightColor=15793151
string   is_BandType,is_objects[],is_null[]
string   is_OrgObj,is_CurObj,is_lastdwoname

boolean    ib_draging=FALSE,ib_MoveSelf=FALSE

w_contract_data_design iw_parentwin

u_cst_dw_design iuo_parent

long    il_LineOrgX,il_LineOrgY

CONSTANT STRING TABCHAR = "~t"
CONSTANT STRING ENTERCHAR = "~r~n"
CONSTANT STRING LEFTUPTEXTMARK    = "Draw_Select_Mark_LeftUp_"
CONSTANT STRING LEFTDOWNTEXTMARK  = "Draw_Select_Mark_LeftDown_"
CONSTANT STRING RIGHTUPTEXTMARK   = "Draw_Select_Mark_RightUp_"
CONSTANT STRING RIGHTDOWNTEXTMARK = "Draw_Select_Mark_RightDown_"

CONSTANT LONG   TEXTMARKWIDTH   = 12
CONSTANT LONG   TEXTMARKHEIGHT  = 12

CONSTANT LONG   TEXTMARKHSPACE  = 8
CONSTANT LONG   TEXTMARKVSPACE  = 8

String	is_RectFrameName = "Object_Select_Rect_Frame"
long		il_OriginX,il_OriginY,il_Left_Margin,il_Down_Margin
long		il_RectFrameColor = RGB(112,112,112)
long		il_RightClickXPos,il_RightClickYPos

String	is_NewObjName

end variables

forward prototypes
public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly)
public function integer of_unselectobj (string as_name)
public function integer of_selectobject (string as_name)
public subroutine of_getgroupobjects (string as_groupobjects[])
public function integer of_setdesign (string as_objname)
public subroutine of_setuserobject (u_cst_dw_design auo_obj)
public subroutine of_populatedw ()
public function integer of_show_invisible (boolean ab_show)
public function integer of_setdesign (boolean ab_true)
public function integer of_modifytextproperties (string as_property)
public function integer of_settextdisplayproperties ()
public function integer of_modifyovalproperties (string as_property)
public function integer of_set_parent (u_cst_dw_design anv_parent)
public function u_cst_dw_design of_get_parent ()
public function boolean of_isselected (string as_objname, ref long al_pos)
public subroutine of_addordelsingleselect (string as_objname, boolean ab_isaddmark)
public subroutine of_create_rectangle_frame (string as_band, long al_xpos, long al_ypos)
public subroutine of_refreshmarkpos (string as_objname)
public subroutine of_moveselectedobject (string as_objname, long al_diff_x, long al_diff_y)
public subroutine of_getobjectinformation (string as_objname, ref string as_objtype, ref long al_x, ref long al_y, ref long al_width, ref long al_height)
public function string of_getobjecttype (string as_objname)
public function string of_getobjecttag (string as_objname)
public function string of_getobjectid (string as_objname)
public subroutine of_getobjectattr (string as_objname, ref string as_bold, ref string as_italic, ref string as_underline, ref string as_align)
public function string of_getrelcolname (string as_objname)
public subroutine of_destroy_rectangle_frame ()
public subroutine of_modify_rectangle_frame ()
public subroutine of_rectframeselectobject (long al_outsiderectx, long al_outsiderecty, long al_outsiderectwidth, long al_outsiderectheight)
public subroutine of_resizeselectedobject (string as_objname, long al_diff_x, long al_diff_y)
public subroutine of_getlastrightclickpos (ref long al_xpos, ref long al_ypos)
public function string of_getobjectsyntax (string as_objectname)
public function string of_objectnameverify (string as_name)
public function string of_get_invisible_field ()
public function integer of_modify_column_property (string as_column_name, string as_property_name)
public subroutine of_modify_collabel_property (string as_label, string as_value)
public function integer of_set_dw_properties (string as_property_name)
public subroutine of_getobject_fontsize (string as_objname, ref string as_size)
end prototypes

event ue_regenerate();//////////////////////////////////////////////////////////////////////
// $<event> ue_regenerate
// $<arguments>
// $<returns> (None)
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.27.2010
//////////////////////////////////////////////////////////////////////

string  ls_modify,ls_Array[]
string  ls_BandType
Long    ll_row
Long ll_cnt,i

If Upper(is_BandType) <> 'DETAIL' Then
	ll_cnt = Long(this.object.datawindow.Column.Count)
	For i = 1 to ll_cnt
		This.Modify("#"+String(i)+".TabSequence = '0'")
	Next
End If

CHOOSE CASE  Upper(is_BandType)
	CASE 'HEADER'
		ls_Modify = "datawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		this.Modify("datawindow.header.1.height=0~tdatawindow.trailer.1.height=0")
		this.Modify("datawindow.header.2.height=0~tdatawindow.trailer.2.height=0")
		this.Modify("datawindow.header.3.height=0~tdatawindow.trailer.3.height=0")
	CASE 'DETAIL'
		ls_Modify = "datawindow.header.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		this.Modify("datawindow.header.1.height=0~tdatawindow.trailer.1.height=0")
		this.Modify("datawindow.header.2.height=0~tdatawindow.trailer.2.height=0")
		this.Modify("datawindow.header.3.height=0~tdatawindow.trailer.3.height=0")
	CASE 'SUMMARY'
		ls_Modify = "datawindow.detail.height=0~tdatawindow.header.height=0~tdatawindow.footer.height=0"
		this.Modify("datawindow.header.1.height=0~tdatawindow.trailer.1.height=0")
		this.Modify("datawindow.header.2.height=0~tdatawindow.trailer.2.height=0")
		this.Modify("datawindow.header.3.height=0~tdatawindow.trailer.3.height=0")
	CASE 'FOOTER'
		ls_Modify = "datawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.header.height=0"
		this.Modify("datawindow.header.1.height=0~tdatawindow.trailer.1.height=0")
		this.Modify("datawindow.header.2.height=0~tdatawindow.trailer.2.height=0")
		this.Modify("datawindow.header.3.height=0~tdatawindow.trailer.3.height=0")
	CASE "HEADER.1"
		ls_Modify = "datawindow.trailer.1.height=0~tdatawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		this.Modify("datawindow.header.2.height=0~tdatawindow.trailer.2.height=0")
		this.Modify("datawindow.header.3.height=0~tdatawindow.trailer.3.height=0")		
	CASE "HEADER.2"
		ls_Modify = "datawindow.trailer.2.height=0~tdatawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		this.Modify("datawindow.header.1.height=0~tdatawindow.trailer.1.height=0")
		this.Modify("datawindow.header.3.height=0~tdatawindow.trailer.3.height=0")		
	CASE "HEADER.3"
		ls_Modify = "datawindow.trailer.3.height=0~tdatawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		this.Modify("datawindow.header.1.height=0~tdatawindow.trailer.1.height=0")
		this.Modify("datawindow.header.2.height=0~tdatawindow.trailer.2.height=0")
	CASE "TRAILER.1"
		ls_Modify = "datawindow.header.1.height=0~tdatawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		this.Modify("datawindow.header.2.height=0~tdatawindow.trailer.2.height=0")
		this.Modify("datawindow.header.3.height=0~tdatawindow.trailer.3.height=0")
	CASE "TRAILER.2"
		ls_Modify = "datawindow.header.2.height=0~tdatawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		this.Modify("datawindow.header.1.height=0~tdatawindow.trailer.1.height=0")
		this.Modify("datawindow.header.3.height=0~tdatawindow.trailer.3.height=0")
	CASE "TRAILER.3"
		ls_Modify = "datawindow.header.3.height=0~tdatawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		this.Modify("datawindow.header.1.height=0~tdatawindow.trailer.1.height=0")
		this.Modify("datawindow.header.2.height=0~tdatawindow.trailer.2.height=0")
END CHOOSE

ls_Modify += " DataWindow.Detail.Height.AutoSize=No" 
this.modify(ls_Modify)

is_objects = ls_Array
is_CurObj = ''
is_OrgObj = ''
of_getobjects(is_objects[], '*', is_BandType, FALSE)
ll_row = this.insertrow(0)

this.groupcalc()
this.bringtotop = TRUE
of_setdesign(true)
of_populatedw()
end event

event ue_postopen();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
//this.of_getparentwindow(iw_parentwin)  //Modified by gavin on 2009-03-04
//---------------------------- APPEON END ----------------------------
end event

event ue_key;//====================================================================
// Event: ue_key()
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

long		ll_KeyAsc,ll_SelObjCnts
String	ls_KeySign,ls_ObjName,ls_Type
Boolean	lb_ModifyText

if iuo_parent.ib_Set_Tab_Order then Return 1

//BEGIN---Modify by Scofield on 2009-12-04
if Key = KeyEnter! then
	iuo_Parent.Event ue_Properties()
	Return 1
end if
//END---Modify by Scofield on 2009-12-04

//BEGIN---Modify by Scofield on 2009-09-03
ll_SelObjCnts = iuo_Parent.of_GetSelectedObjectCnts()
if ll_SelObjCnts = 1 then
	ls_ObjName = iuo_Parent.of_GetLastSelectedObject()
	ls_Type = iuo_Parent.of_GetSelectedObjectType(ls_ObjName)
	if Upper(ls_Type) = Upper("text") or Upper(ls_Type) = Upper("groupbox") then
		lb_ModifyText = true
	end if
end if

ll_KeyAsc = gf_KeycodeToAsc(key,keyflags)
if ll_KeyAsc > 0 and lb_ModifyText then
	ls_KeySign = CharA(ll_KeyAsc)
	iuo_parent.uo_design.dw_1.SetItem(1,"label",ls_KeySign)
	iuo_parent.uo_design.dw_1.Trigger Event EditChanged(1,iuo_parent.uo_design.dw_1.Object.label,ls_KeySign)
	iuo_parent.uo_design.dw_1.SelectText(LenA(ls_KeySign) + 1,0)
	iuo_parent.uo_design.dw_1.SetFocus()
	Return 1
end if

iuo_parent.Post Event Key(key,keyflags)
//END---Modify by Scofield on 2009-09-03

Return 1

end event

event ue_mouse_move;//====================================================================
// Event: ue_mouse_move()
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
// Author:	Scofield		Date: 2009-04-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Modify,ls_ObjName
long		ll_X,ll_Y,ll_Diff_X,ll_Diff_Y,ll_Width,ll_Height
long		ll_SelObjCnts

if iuo_Parent.il_dw_style = 1 then Return
if iuo_Parent.ib_Set_Tab_Order then Return

XPos = This.PointerX()
YPos = This.PointerY()
if XPos <= 0 then XPos = 0
if YPos <= 0 then YPos = 0

if Not KeyDown(KeyLeftButton!) then iuo_Parent.ib_Mouse_Down = false

if Not iuo_parent.uo_band.ib_MouseDown then
	ll_SelObjCnts = iuo_Parent.of_GetSelectedObjectCnts()
	if ll_SelObjCnts <= 0 then
		if PosA(This.Describe("DataWindow.Pointer"),"Arrow!") <= 0 then This.Modify("DataWindow.Pointer = 'Arrow!'")
		Return
	end if
	
	ls_ObjName = iuo_Parent.of_GetLastSelectedObject()
	
	ll_X = long(This.Describe(ls_ObjName + ".X"))
	ll_Y = long(This.Describe(ls_ObjName + ".Y"))
	ll_Width = long(This.Describe(ls_ObjName + ".Width"))
	ll_Height = long(This.Describe(ls_ObjName + ".Height"))
	
	IF Not iuo_Parent.ib_Resize_Height AND Not iuo_Parent.ib_Resize_Width AND iuo_Parent.ib_Mouse_Down AND iuo_Parent.ib_Control_Down = False THEN		
		if PosA(This.Describe("DataWindow.Pointer"),"Arrow!") <= 0 then This.Modify("DataWindow.Pointer = 'Arrow!'")
		
		ll_Diff_X = This.X + XPos - iuo_Parent.il_Ancor_X
		ll_Diff_Y = This.Y + YPos - iuo_Parent.il_Ancor_Y
		
		iuo_Parent.il_Ancor_X = This.X + XPos
		iuo_Parent.il_Ancor_Y = This.Y + YPos
		
		iuo_Parent.of_MoveSelectedObject(ll_Diff_X,ll_Diff_Y)
	ELSEIF ll_SelObjCnts = 1 and (XPos >= ll_X + ll_Width) AND (XPos <= ll_X + ll_Width + 12) and (YPos >= ll_Y) AND (YPos <= ll_Y + ll_Height) and Not iuo_Parent.ib_Mouse_Down THEN
		if PosA(This.Describe("DataWindow.Pointer"),"SizeWE!") <= 0 then This.Modify("DataWindow.Pointer = 'SizeWE!'")
		iuo_Parent.ib_Resize_Width = True
	ELSEIF ll_SelObjCnts = 1 and (YPos >= ll_Y + ll_Height) AND (YPos <= ll_Y + ll_Height + 12) and (XPos >= ll_X) AND (XPos <= ll_X + ll_Width) and Not iuo_Parent.ib_Mouse_Down THEN
		if PosA(This.Describe("DataWindow.Pointer"),"SizeNS!") <= 0 then This.Modify("DataWindow.Pointer = 'SizeNS!'")
		iuo_Parent.ib_Resize_Height = True
	ELSEIF ll_SelObjCnts = 1 and iuo_Parent.ib_Resize_Width AND iuo_Parent.ib_Mouse_Down THEN
		if PosA(This.Describe("DataWindow.Pointer"),"SizeWE!") <= 0 then This.Modify("DataWindow.Pointer = 'SizeWE!'")
		ll_Width = XPos - ll_X - il_Left_Margin
		if ll_Width <= 4 then ll_Width = 4
		ls_Modify = ls_ObjName + ".Width = '" + String(ll_Width) + "' "
	ELSEIF ll_SelObjCnts = 1 and iuo_Parent.ib_Resize_Height AND iuo_Parent.ib_Mouse_Down THEN
		if PosA(This.Describe("DataWindow.Pointer"),"SizeNS!") <= 0 then This.Modify("DataWindow.Pointer = 'SizeNS!'")
		ll_Height = YPos - ll_Y - il_Down_Margin
		if ll_Height <= 4 then ll_Height = 4
		ls_Modify = ls_ObjName + ".Height = '" + String(ll_Height) + "' "
	ELSE
		if PosA(This.Describe("DataWindow.Pointer"),"Arrow!") <= 0 then This.Modify("DataWindow.Pointer = 'Arrow!'")
		iuo_Parent.ib_Resize_Width = False
		iuo_Parent.ib_Resize_Height = False
	END IF
	
	if ls_Modify <> "" then
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
		iuo_Parent.of_RefreshMarkPos()
	end if
end if

//Workaround APB Bug
if PosA(This.Describe("DataWindow.Pointer"),"Arrow!") > 0 then SetPointer(Arrow!)

end event

event ue_regenerate_01();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
string  ls_modify,ls_Array[]
string  ls_Modify1,ls_BandType
Long    ll_row

//this.settransobject(SQLCA)-- Comment by jervis -- performance optimize
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05/14/2008 By: Ken.Guo
//$<reason> Added By Ken.Guo. Workaround APB Bug26761.
Long ll_cnt,i
If Upper(is_BandType) <> 'DETAIL' Then
	ll_cnt = Long(this.object.datawindow.Column.Count)
	For i = 1 to ll_cnt
		This.Modify("#"+String(i)+".TabSequence = '0'")
	Next
End If
//---------------------------- APPEON END ----------------------------

//Modified by gavin on 2009-03-04
CHOOSE CASE  Upper(is_BandType)
	CASE 'HEADER'
		ls_Modify = "datawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.header.1.height=0~tdatawindow.trailer.1.height=0"
	CASE 'DETAIL'
		ls_Modify = "datawindow.header.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.header.1.height=0~tdatawindow.trailer.1.height=0"
	CASE 'SUMMARY'
		ls_Modify = "datawindow.detail.height=0~tdatawindow.header.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.header.1.height=0~tdatawindow.trailer.1.height=0"
	CASE 'FOOTER'
		ls_Modify = "datawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.header.height=0"
		ls_Modify1 = "datawindow.header.1.height=0~tdatawindow.trailer.1.height=0"
	CASE 'HEADERGROUP','HEADER.1'
		ls_Modify = "datawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.trailer.1.height=0"
	CASE 'TRAILERGROUP','TRAILER.1'
		ls_Modify = "datawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.header.1.height=0"	
	CASE ELSE
		RETURN 
END CHOOSE
//Start add By Jervis 03.25.2008
ls_Modify += " DataWindow.Detail.Height.AutoSize=No" 
//End add By Jervis 03.25.2008

this.modify(ls_Modify)
this.modify(ls_Modify1)
//Modified by gavin on 2009-03-04
//$<add> 01.12.2008 by Andy
//if Long( this.Describe("Datawindow.Header.1.Height")) > 0 then
//	this.modify("Datawindow.Header.1.Height=0")	
//end if
//if Long( this.Describe("Datawindow.Trailer.1.Height")) > 0 then
//	this.modify("Datawindow.Trailer.1.Height=0")	
//end if
//end of add 01.12.2008
is_objects = ls_Array
is_CurObj = ''
is_OrgObj = ''

//BEGIN---Modify by Scofield on 2010-05-06
if Upper(is_BandType) = "HEADERGROUP" then
	ls_BandType = "HEADER.1"
elseif Upper(is_BandType) = "TRAILERGROUP" then
	ls_BandType = "TRAILER.1"
else
	ls_BandType = is_BandType
end if
//END---Modify by Scofield on 2010-05-06

of_getobjects(is_objects[],'*',ls_BandType,FALSE)

ll_row = this.insertrow(0)

//Modified by gavin on 2009-03-04
if Upper(is_BandType)="HEADERGROUP" or Upper(is_BandType)="TRAILERGROUP" or Upper(is_BandType)="HEADER.1" or Upper(is_BandType)="TRAILER.1" then this.groupcalc()
this.bringtotop = TRUE
	
of_setdesign(true)

of_populatedw()

//---------------------------- APPEON END ----------------------------





end event

public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly); //////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetObjects (FORMAT 2)
//
//	Access:    		Public
//
//	Arguments:
//   as_objtype:  	The type of objects to get (* for all, others defined
//							by the object .TYPE attribute)
//   as_band:  		The dw band to get objects from (* for all) 
//							Valid bands: header, detail, footer, summary
//							header.#, trailer.#
//   ab_visibleonly: TRUE  - get only the visible objects,
//							 FALSE - get visible and non-visible objects
//
//	Returns:  		Integer
//   					The number of objects in the array
//
//////////////////////////////////////////////////////////////////////////////
string	ls_ObjString, ls_ObjHolder
integer	li_Start=1, li_Tab, li_Count=0

/* Get the Object String */
ls_ObjString = this.Describe("Datawindow.Objects")

as_band = upper(as_band)
as_objtype = upper(as_objtype)

/* Get the first tab position. */
li_Tab =  PosA(ls_ObjString, "~t", li_Start)
Do While li_Tab > 0
	ls_ObjHolder = MidA(ls_ObjString, li_Start, (li_Tab - li_Start))

	// Determine if object is the right type and in the right band
	If (upper(this.Describe(ls_ObjHolder + ".type")) = as_ObjType Or as_ObjType = "*") And &
		(upper(this.Describe(ls_ObjHolder + ".band")) = as_Band Or as_Band = "*") And &
		(this.Describe(ls_ObjHolder + ".visible") = "1" Or Not ab_VisibleOnly) Then
			li_Count ++
			as_ObjList[li_Count] = ls_ObjHolder
	End if

	/* Get the next tab position. */
	li_Start = li_Tab + 1
	li_Tab =  PosA(ls_ObjString, "~t", li_Start)
Loop 

// Check the last object
ls_ObjHolder = MidA(ls_ObjString, li_Start, LenA(ls_ObjString))

// Determine if object is the right type and in the right band
If (upper(this.Describe(ls_ObjHolder + ".type")) = as_ObjType or as_ObjType = "*") And &
	(upper(this.Describe(ls_ObjHolder + ".band")) = as_Band or as_Band = "*") And &
	(this.Describe(ls_ObjHolder + ".visible") = "1" Or Not ab_VisibleOnly) Then
		li_Count ++
		as_ObjList[li_Count] = ls_ObjHolder
End if

Return li_Count


end function

public function integer of_unselectobj (string as_name);
string ls_modify
long ll_find
string ls_r,ls_type
datawindow   ldw_syntax

IF as_Name = '' THEn return -1
ls_type = this.describe(as_name+'.type')

//Modified by gavin on 2009-03-04
//ldw_Syntax = iw_Parentwin.uo_design.uo_band.dw_Syntax
ldw_Syntax = iuo_parent.uo_band.dw_Syntax

//IF ls_type = 'text' THEN //Add by Evan 07/21/2008
//	this.modify(as_Name+".background.color='67108864'")
IF this.describe(as_name+".type") <> 'line' THEN //Delete by Evan 07/21/2008
//ELSEIF ls_type <> 'line' THEN //Add by Evan 07/21/2008
	this.modify(as_Name+".background.color='"+ldw_Syntax.describe(as_Name+".background.color")+"'")
	this.modify(as_Name+".background.mode='"+ldw_Syntax.describe(as_Name+".background.mode")+"'")
	this.modify(as_Name+".brush.color='"+ldw_Syntax.describe(as_Name+".brush.color")+"'")
	this.modify(as_Name+".brush.hatch='"+ldw_Syntax.describe(as_Name+".brush.hatch")+"'")
else
	this.modify(as_Name+".background.color='"+ldw_Syntax.describe(as_Name+".background.color")+"'")
	this.modify(as_Name+".background.mode='"+ldw_Syntax.describe(as_Name+".background.mode")+"'")
	this.modify(as_Name+".pen.color='"+ldw_Syntax.describe(as_Name+".pen.color")+"'")
end if
return 1
end function

public function integer of_selectobject (string as_name);
string ls_modify='',ls_name,ls_type,ls_band
string ls_r
int lx,ly,lw,lh
string ls1

IF this.describe(as_name+".type") <> 'line' THEN 
	IF this.describe(as_name+".brush.hatch") = '7' THEN
		this.modify(as_name+".brush.hatch='6'~t"+as_name+".brush.color='"+string(cil_HighLightColor)+"'")
	ELSE
		this.modify(as_name+".Background.Mode='0'~t"+as_name+".background.color='"+string(cil_HighLightColor)+"'")
	END IF
else
	ls_modify = this.modify(as_name+".pen.color = '" + string(cil_HighLightColor) + "'")
end if
return 1


end function

public subroutine of_getgroupobjects (string as_groupobjects[]);String ls_header_1[],ls_header_2[],ls_trailer_1[],ls_trailer_2[]
long i

this.of_getobjects(ls_header_1[],'*','header.1',FALSE)
this.of_getobjects(ls_header_2[],'*','header.2',FALSE)
this.of_getobjects(ls_trailer_1[],'*','trailer.1',FALSE)
this.of_getobjects(ls_trailer_2[],'*','trailer.2',FALSE)

For i=1 To upperbound(ls_header_1[])
	as_groupobjects[upperbound(as_groupobjects[])+1]=ls_header_1[i] 
Next	
For i=1 To upperbound(ls_header_2[])
	as_groupobjects[upperbound(as_groupobjects[])+1]=ls_header_2[i]
Next
For i=1 To upperbound(ls_trailer_1[])
	as_groupobjects[upperbound(as_groupobjects[])+1]=ls_trailer_1[i]
Next
For i=1 To upperbound(ls_trailer_2[])
	as_groupobjects[upperbound(as_groupobjects[])+1]=ls_trailer_2[i]
Next
end subroutine

public function integer of_setdesign (string as_objname);//long  ll,row
//string  ls_modify,ls_ColTYpe,ls_Type,ls_EditStyle
//int  li,li_temp
//datetime  ldt_temp
//time  lt_temp
//any  la
//
//if iuo_parent.il_dw_style = 1 then return 1
//
//IF this.describe(as_ObjName+".moveable") ='0' THEN
//	ls_Modify+="~t"+ as_ObjName+".moveable=1"+"~t"+ as_ObjName+".resizeable=1"
//END IF
//
//this.modify(ls_Modify)
//ls_Modify = ''

return 1
end function

public subroutine of_setuserobject (u_cst_dw_design auo_obj);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-07 By: Andy
iuo_parent = auo_obj
//---------------------------- APPEON END ----------------------------
end subroutine

public subroutine of_populatedw ();//====================================================================
// Event: u_cst_dw_band.of_populatedw()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 06,2007
//--------------------------------------------------------------------
// Modify History:
//	
//====================================================================

LONG LL_I,ll_count
string ls_dddw_name
string ls_colname
String ls_coltag
Integer li_value
String ls_DataColumn
string ls_band

DataWindowChild dwchild
n_ds lnds_user
n_cst_string lnv_string
String ls_objects,ls_arr_objects[],ls_type
String ls_column_visible,ls_str,ls_column_ID

// Set design datawindow background color as button face
//this.Modify("datawindow.color=67108864") //Add by Evan 07/18/2008; Delete 09/27/2008

// Set display properties of text objects
//of_SetTextDisplayProperties() //Add by Evan 07/25/2008; Delete 09/27/2008

ls_objects = this.Describe("datawindow.objects")
ll_count = lnv_string.of_parsetoarray( ls_objects, "~t", ls_arr_objects)

//LL_COLUMN_COUNT = LONG(This.Describe("DataWindow.Column.Count"))
//IF LL_COLUMN_COUNT = 0 THEN RETURN

//start modify by gavin on 2009/3/3
ls_band = lower(this.is_bandType)
if lower(this.is_bandType) = 'trailergroup' then ls_band = 'trailer.1'
if lower(this.is_bandType) = 'headergroup' then ls_band = 'header.1'
//end modify by gavin on 2009/3/3

FOR LL_I = 1 TO ll_count
	IF lower(Describe(ls_arr_objects[ll_i] + ".Band")) =  lower(ls_band) then
		ls_type = lower(Describe(ls_arr_objects[ll_i] + ".type"))
		ls_colname = Describe(ls_arr_objects[ll_i] + ".Name")

		//<modify> 04.11.2008 by Andy
		//Reason:Backup expression if there is a expression in visible property,not button only.
		//       (fixed issue 1 from Issues for Tracy.doc)
		//if ls_type = "button" then 
		If ls_type <> "ellipse" and this.Describe(ls_arr_objects[ll_i] + ".visible") <> '0' And this.Describe(ls_arr_objects[ll_i] + ".visible") <> '1' Then
			iuo_parent.is_button_object[upperbound(iuo_parent.is_button_object) + 1] = ls_colname
			iuo_parent.is_button_visible[upperbound(iuo_parent.is_button_visible) + 1] = this.Describe(ls_arr_objects[ll_i] + ".visible")
			this.Modify(ls_arr_objects[ll_i] + ".visible = 1")
		end if
		//end if
		//end modify 04.11.2008
		
		IF ls_type = "compute" or ls_type = "column" then
			// Grid style
			IF iuo_parent.il_dw_style = 1 THEN	this.Modify( ls_colname + "_t.border = '6'" )
			if This.Describe(ls_colname + ".border") = '0' then
				This.Modify(ls_colname + ".border = '5'" )
			end if
		end if
		
		if ls_type = "column" then
			/*
			//visible
			ls_column_visible= this.Describe(ls_colname +".Visible")
			
			IF ls_column_visible = "0" THEN
				this.Modify(ls_colname + ".visible = 1")
				this.Modify(ls_colname + "_t.visible = 1")
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify(ls_colname + "_t.visible = 1")
				
				this.Modify(ls_colname + ".color = '8421504'") 
				this.Modify(ls_colname + ".background.color = '12632256'")
				this.Modify(ls_colname + "_t.color = '8421504'")
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify(ls_colname + "_t.color = '8421504'")
			ELSE
				//BEGIN---Delete by Evan 09/27/2008
				
				this.Modify(ls_colname + ".color = '0'")
				this.Modify(ls_colname + "_t.color = '0'")
				this.Modify(ls_colname + "_t.background.color = '67108864'") //Add by Evan 07/21/2008
		
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify(ls_colname + "_t.color = '0'")
				iuo_parent.uo_band.dw_header.Modify(ls_colname + "_t.background.color = '67108864'") //Add by Evan 07/23/2008
				*/
				//END---Delete by Evan 09/27/2008
				/*ls_str = this.Describe(ls_colname + ".TabSequence")
				If ls_str <> '0' Then
					this.Modify(ls_colname + ".background.color = '16777215'")
				End If
			END IF*/
			//end of visible
			
			//columnid/protect
			ls_column_ID = This.Describe( ls_colname + ".ID" )
			This.Modify( ls_colname + "_t.tag = '" + ls_column_ID + "'" )
			This.Modify( ls_colname + ".protect = 1" )
			//end of columnid/protect
			
			This.Modify(ls_colname + ".Height.AutoSize = 'No'" )		//Added by Scofield on 2010-02-01

			//dddw
			IF Describe(ls_arr_objects[ll_i] + ".Edit.Style") = 'dddw' then				
				ls_dddw_name = lower(Describe(ls_arr_objects[ll_i] + ".DDDW.Name"))							
				IF ls_dddw_name = "d_dddw_code_lookup" OR ls_dddw_name = "d_dddw_code_lookup_action_type" THEN
					ls_coltag = Lower(Describe(ls_arr_objects[ll_i] + ".TAG"))
					li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
						
					IF li_value <> 1 THEN
						gnv_app.of_setcontraccache_code_lookup( ls_coltag )
						li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
					END IF
				ELSE
					li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user)
				END IF
						
				IF li_value = 1 THEN
					getchild( ls_colname, dwchild)
					dwchild.Reset( )
					lnds_user.rowscopy( 1, 1000, primary!, dwchild, 1, primary!)
					long ll_find
					string ls_displaycolumn
					ls_displaycolumn = This.Describe(ls_colname + ".dddw.displaycolumn")
					ll_find = dwchild.find(ls_displaycolumn + " = '(NONE)'",1,dwchild.rowcount())
					If ll_find > 0 Then
						dwchild.setitem(ll_find,ls_displaycolumn,'')
					End If
					ls_DataColumn = This.Describe(ls_colname + ".dddw.DataColumn")
					dwchild.SetFilter( "isnull(" + ls_DataColumn + ") or " + ls_DataColumn + " > 0 " )
					dwchild.Filter( )
				END IF
			END IF
			//end of dddw
			
		end if
		//end of column
		
	END IF
NEXT

Return

end subroutine

public function integer of_show_invisible (boolean ab_show);//====================================================================
// Event: u_cst_dw_band.of_show_invisible()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	ab_show	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 08,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer li_rc
Integer i
String ls_fld

iuo_parent.dw_properties.SetFilter("")
iuo_parent.dw_properties.Filter( )
li_rc = iuo_parent.dw_properties.RowCount()

FOR i = 1 TO li_rc

	ls_fld = iuo_parent.dw_properties.GetItemString( i, "sys_fields_field_name" )
	IF lower(Describe(ls_fld + ".Band")) =  lower(is_bandType) then
		If iuo_parent.dw_properties.GetItemString( i, "data_view_fields_visible" ) = "N" Then
			IF NOT ab_show THEN
				Modify( ls_fld + ".Visible = 1")
				Modify( ls_fld + "_t.Visible = 1")
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify( ls_fld + "_t.Visible = 1")
			ELSE
				Modify( ls_fld + ".Visible = 0")
				Modify( ls_fld + "_t.Visible = 0")
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify( ls_fld + "_t.Visible = 0")			
			END IF
		End If
	end if
	
END FOR

RETURN 1
end function

public function integer of_setdesign (boolean ab_true);//====================================================================
// Event: u_cst_dw_band.of_setdesign()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//     boolean ab_true
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 06,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//long  ll,row
//string  ls_modify,ls_ColTYpe,ls_Type,ls_EditStyle
//int  li,li_temp
//datetime  ldt_temp
//time  lt_temp
//any  la
//string ls_groupobj[]
//
//if iuo_parent.il_dw_style = 1 then return 1
//
//of_getgroupobjects(ls_groupobj[])
//
//FOR ll = 1 TO upperbound(ls_groupobj)
//
//	if ab_true then
//		IF this.describe(ls_groupobj[ll]+".moveable") ='0' THEN
//			ls_Modify+="~t"+ ls_groupobj[ll]+".moveable=1"+"~t"+ ls_groupobj[ll]+".resizeable=1" 
//		END IF
//	else
//		IF this.describe(ls_groupobj[ll]+".moveable") ='1' THEN
//			ls_Modify+="~t"+ ls_groupobj[ll]+".moveable=0"+"~t"+ ls_groupobj[ll]+".resizeable=0" 
//		END IF
//	end if
//	
//	this.modify(ls_Modify)
//	ls_Modify = ''
//NEXT
//
//FOR ll = 1 TO upperbound(is_Objects)
//
//	if ab_true then
//		IF this.describe(is_Objects[ll]+".moveable") ='0' THEN
//			ls_Modify+="~t"+ is_Objects[ll]+".moveable=1"+"~t"+ is_Objects[ll]+".resizeable=1" 
//		END IF
//	else
//		IF this.describe(is_Objects[ll]+".moveable") ='1' THEN
//			ls_Modify+="~t"+ is_Objects[ll]+".moveable=0"+"~t"+ is_Objects[ll]+".resizeable=0" 
//		END IF
//	end if
//
//	this.modify(ls_Modify)
//	ls_Modify = ''
//NEXT

return 1
end function

public function integer of_modifytextproperties (string as_property);string 	ls_CurTextName,ls_OriTextName
string 	ls_ObjectSyntax,ls_Modify,ls_Error
long		ll_Pos,ll_NextBlank

datawindow ldw_prop

ls_OriTextName = iuo_parent.is_OriTextName
// Get text object name
ldw_prop = iuo_parent.dw_properties_text
ls_CurTextName = ldw_prop.object.name[1]

// Get modify expression
choose case as_Property
	case "name"
		ls_Error = of_ObjectNameVerify(ls_CurTextName)
		
		if ls_Error <> "" then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Error,Exclamation!)
			ldw_prop.object.name[1] = iuo_parent.is_OriTextName
			Return 1
		else
			ls_ObjectSyntax = of_GetObjectSyntax(ls_OriTextName)
			ll_Pos = PosA(ls_ObjectSyntax,"name=" + ls_OriTextName)
			ll_NextBlank = PosA(ls_ObjectSyntax," ",ll_Pos)
			if ll_Pos > 0 and ll_NextBlank > 0 then
				ls_ObjectSyntax = ReplaceA(ls_ObjectSyntax,ll_Pos + LenA("name="),ll_NextBlank - (ll_Pos + LenA("name=")),ls_CurTextName)
				of_AddOrDelSingleSelect(ls_OriTextName,false)
				ls_Modify = "destroy " + ls_OriTextName
				ls_Modify += " create " + ls_ObjectSyntax
				This.Modify(ls_Modify)
				iuo_parent.Event ue_SetModify(ls_Modify)
				iuo_parent.is_OriTextName = ls_CurTextName
				of_AddOrDelSingleSelect(ls_CurTextName,true)
				iuo_Parent.of_Refresh_Object_Inforamtion()
				Return 1
			end if
		end if
	case "text"
		ls_Modify = ls_CurTextName + ".text = '" + ldw_prop.object.text[1] + "'"
	case "visible"
		ls_Modify = ls_CurTextName + ".visible = '" + ldw_prop.object.visible[1] + "'"
	case "text_color"
		ls_Modify = ls_CurTextName + ".color = '" + String(ldw_prop.object.text_color[1]) + "'"
	case "background_color"
		ls_Modify  = ls_CurTextName + ".background.mode = '2' "
		ls_Modify += ls_CurTextName + ".background.color = '" + String(ldw_prop.object.background_color[1]) + "'"
	case "alignment"
		ls_Modify = ls_CurTextName + ".alignment = '" + ldw_prop.object.alignment[1] + "'"
	case "border"
		ls_Modify = ls_CurTextName + ".border = '" + ldw_prop.object.border[1] + "'"
	case else
		Return 0
end choose

// Modify text object property
this.Modify(ls_Modify)

//Modified by gavin on 2009-03-04
iuo_parent.Event ue_SetModify(ls_Modify)

Return 1
end function

public function integer of_settextdisplayproperties ();string ls_Modify
string ls_ObjectsStr
string ls_Objects[]
integer i, li_ObjectCount
n_cst_string lnv_string

// Get objects
ls_ObjectsStr = this.Describe("datawindow.objects")
lnv_string.of_ParseToArray(ls_ObjectsStr, "~t", ls_Objects[])
li_ObjectCount = UpperBound(ls_Objects[])

// Set text object show properties
for i = 1 to li_ObjectCount
	if this.Describe(ls_Objects[i] + ".type") = "text" then
		ls_Modify = ls_Objects[i] + ".color = '0' "
		ls_Modify += ls_Objects[i] + ".background.mode = '2' "
		ls_Modify += ls_Objects[i] + ".background.color = '67108864'"
		this.Modify(ls_Modify)
	end if
next

Return 1
end function

public function integer of_modifyovalproperties (string as_property);//====================================================================
// Event: of_ModifyOvalProperties()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_property	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-26
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String 		ls_Object,ls_Modify,ls_PropExp

DataWindow 	ldw_prop

// Get oval object name
ldw_prop = iuo_parent.dw_Properties_Oval
ls_Object = ldw_prop.object.name[1]

ls_PropExp = ldw_prop.GetItemString(1,as_Property)

// Get modify expression
CHOOSE CASE as_Property
	CASE "visible"
		if PosA(ls_PropExp,"~t") <= 0 then ls_PropExp = "1" + TABCHAR + ls_PropExp
		ls_Modify = ls_Object + ".visible = ~"" + ls_PropExp + '"'
	CASE "background_color"
		if PosA(ls_PropExp,"~t") <= 0 then ls_PropExp = "0" + TABCHAR + ls_PropExp
		ls_Modify = ls_Object + ".Background.Color = ~"" + ls_PropExp + '"'
	CASE "brush_color"
		if PosA(ls_PropExp,"~t") <= 0 then ls_PropExp = "0" + TABCHAR + ls_PropExp
		ls_Modify = ls_Object + ".Brush.Color = ~"" + ls_PropExp + '"'
	CASE "brush_hatch"
		if PosA(ls_PropExp,"~t") <= 0 then ls_PropExp = "6" + TABCHAR + ls_PropExp
		ls_Modify = ls_Object + ".Brush.Hatch = ~"" + ls_PropExp + '"'
	CASE "pen_color"
		if PosA(ls_PropExp,"~t") <= 0 then ls_PropExp = "0" + TABCHAR + ls_PropExp
		ls_Modify = ls_Object + ".Pen.Color = ~"" + ls_PropExp + '"'
	CASE "pen_style"
		if PosA(ls_PropExp,"~t") <= 0 then ls_PropExp = "0" + TABCHAR + ls_PropExp
		ls_Modify = ls_Object + ".Pen.Style = ~"" + ls_PropExp + '"'
	CASE "pen_width"
		if PosA(ls_PropExp,"~t") <= 0 then ls_PropExp = "1" + TABCHAR + ls_PropExp
		ls_Modify = ls_Object + ".Pen.Width = ~"" + ls_PropExp + '"'
	CASE else
		Return 0
end CHOOSE

// Modify oval object property
This.Modify(ls_Modify)

//Modified by gavin on 2009-03-04
iuo_parent.Event ue_SetModify(ls_Modify)

Return 1

end function

public function integer of_set_parent (u_cst_dw_design anv_parent);//Modified by gavin on 2009-03-04
iuo_parent = anv_parent
return 1
end function

public function u_cst_dw_design of_get_parent ();//Modified by gavin on 2009-03-04
 
return iuo_parent
end function

public function boolean of_isselected (string as_objname, ref long al_pos);//====================================================================
// Function: of_IsSelected()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value        string    as_objname
// 	reference    long      al_Pos
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-08
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Cycle,ll_Cnts

al_Pos = 0

ll_Cnts = UpperBound(iuo_parent.istr_SelectObj)
for ll_Cycle = 1 to ll_Cnts
	if Lower(iuo_parent.istr_SelectObj[ll_Cycle].FName) = Lower(as_ObjName) then
		al_Pos = ll_Cycle
		Return true
	END IF
next

Return false

end function

public subroutine of_addordelsingleselect (string as_objname, boolean ab_isaddmark);//====================================================================
// Function: of_addordelsingleselect()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string     as_objname
// 	value    boolean    ab_isaddmark
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_X1,ll_X2,ll_Y1,ll_Y2,ll_ObjX,ll_ObjY,ll_ObjWidth,ll_ObjHeight,ll_BandHeight,ll_Pos,ll_Cycle,ll_Cnts
long		ll_LeftUpX,ll_LeftUpY,ll_LeftDownX,ll_LeftDownY,ll_RightUpX,ll_RightUpY,ll_RightDownX,ll_RightDownY
String	ls_Band,ls_LeftUpMarkName,ls_LeftDownMarkName,ls_RightUpMarkName,ls_RightDownMarkName,ls_AllObjects,ls_ObjName,ls_ObjType,ls_ModifySyntax
Boolean	lb_IsSelected

if IsNull(as_ObjName) or Trim(as_ObjName) = "" then Return

if PosA(Lower(as_ObjName),Lower(LEFTUPTEXTMARK)) > 0 or PosA(Lower(as_ObjName),Lower(LEFTDOWNTEXTMARK)) > 0 or &
	PosA(Lower(as_ObjName),Lower(RIGHTUPTEXTMARK)) > 0 or PosA(Lower(as_ObjName),Lower(RIGHTDOWNTEXTMARK)) > 0 then
	Return
end if

ll_BandHeight = This.Height

ls_LeftUpMarkName    = LEFTUPTEXTMARK + as_ObjName
ls_LeftDownMarkName  = LEFTDOWNTEXTMARK + as_ObjName
ls_RightUpMarkName   = RIGHTUPTEXTMARK + as_ObjName
ls_RightDownMarkName = RIGHTDOWNTEXTMARK + as_ObjName

ls_AllObjects = TABCHAR + This.Describe("DataWindow.Objects") + TABCHAR
ls_ObjType = This.Describe(as_ObjName + ".Type")
lb_IsSelected = of_IsSelected(as_ObjName,ll_Pos)

if ab_IsAddMark then
	if This.Describe(as_ObjName + ".Visible") = "0" then Return
	ls_Band = This.Describe(as_ObjName + ".Band")
	
	if ls_ObjType = "line" then
		ll_X1 = long(This.Describe(as_ObjName + ".X1"))
		ll_Y1 = long(This.Describe(as_ObjName + ".Y1"))
		ll_X2 = long(This.Describe(as_ObjName + ".X2"))
		ll_Y2 = long(This.Describe(as_ObjName + ".Y2"))
		
		if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_LeftUpMarkName + TABCHAR)) <= 0 then
			ll_LeftUpX = ll_X1 - 2 * TEXTMARKWIDTH
			ll_LeftUpY = ll_Y1 - TEXTMARKHEIGHT - TEXTMARKVSPACE
			ls_ModifySyntax = ' create text(band=' + ls_Band + ' text="" x="' + String(ll_LeftUpX) + '" y="' + String(ll_LeftUpY) + '" height="' + String(TEXTMARKHEIGHT) + '" width="' + String(TEXTMARKWIDTH) + '" name=' + ls_LeftUpMarkName + ')'
			This.Modify(ls_ModifySyntax)
		end if
		
		if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_RightDownMarkName + TABCHAR)) <= 0 then
			ll_RightDownX = ll_X2 + TEXTMARKHSPACE
			ll_RightDownY = ll_Y2 + TEXTMARKVSPACE
			ls_ModifySyntax = ' create text(band=' + ls_Band + ' text="" x="' + String(ll_RightDownX) + '" y="' + String(ll_RightDownY) + '" height="' + String(TEXTMARKHEIGHT) + '" width="' + String(TEXTMARKWIDTH) + '" name=' + ls_RightDownMarkName + ')'
			This.Modify(ls_ModifySyntax)
		end if
	else
		ll_ObjX = long(This.Describe(as_ObjName + ".X"))
		ll_ObjY = long(This.Describe(as_ObjName + ".Y"))
		ll_ObjWidth = long(This.Describe(as_ObjName + ".Width"))
		ll_ObjHeight = long(This.Describe(as_ObjName + ".Height"))
		
		if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_LeftUpMarkName + TABCHAR)) <= 0 then
			ll_LeftUpX = ll_ObjX - 2 * TEXTMARKWIDTH
			ll_LeftUpY = ll_ObjY - TEXTMARKHEIGHT - TEXTMARKVSPACE
			
			if ll_LeftUpY <= 0 then ll_LeftUpY += TEXTMARKHEIGHT
			
			ls_ModifySyntax = ' create text(band=' + ls_Band + ' text="" x="' + String(ll_LeftUpX) + '" y="' + String(ll_LeftUpY) + '" height="' + String(TEXTMARKHEIGHT) + '" width="' + String(TEXTMARKWIDTH) + '" name=' + ls_LeftUpMarkName + ')'
			This.Modify(ls_ModifySyntax)
		end if
		
		if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_LeftDownMarkName + TABCHAR)) <= 0 then
			ll_LeftDownX = ll_ObjX - 2 * TEXTMARKWIDTH
			ll_LeftDownY = ll_ObjY + ll_ObjHeight + TEXTMARKVSPACE
			
			if ll_LeftDownY + TEXTMARKHEIGHT >= ll_BandHeight then ll_LeftDownY = ll_LeftDownY - TEXTMARKHEIGHT
			
			ls_ModifySyntax = ' create text(band=' + ls_Band + ' text="" x="' + String(ll_LeftDownX) + '" y="' + String(ll_LeftDownY) + '" height="' + String(TEXTMARKHEIGHT) + '" width="' + String(TEXTMARKWIDTH) + '" name=' + ls_LeftDownMarkName + ')'
			This.Modify(ls_ModifySyntax)
		end if
		
		if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_RightUpMarkName + TABCHAR)) <= 0 then
			ll_RightUpX = ll_ObjX + ll_ObjWidth + TEXTMARKHSPACE
			ll_RightUpY = ll_ObjY - TEXTMARKHEIGHT - TEXTMARKVSPACE
			
			if ll_RightUpY <= 0 then ll_RightUpY += TEXTMARKHEIGHT
			
			ls_ModifySyntax = ' create text(band=' + ls_Band + ' text="" x="' + String(ll_RightUpX) + '" y="' + String(ll_RightUpY) + '" height="' + String(TEXTMARKHEIGHT) + '" width="' + String(TEXTMARKWIDTH) + '" name=' + ls_RightUpMarkName + ')'
			This.Modify(ls_ModifySyntax)
		end if
		
		if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_RightDownMarkName + TABCHAR)) <= 0 then
			ll_RightDownX = ll_ObjX + ll_ObjWidth + TEXTMARKHSPACE
			ll_RightDownY = ll_ObjY + ll_ObjHeight + TEXTMARKVSPACE
			
			if ll_RightDownY + TEXTMARKHEIGHT >= ll_BandHeight then ll_RightDownY = ll_RightDownY - TEXTMARKHEIGHT
			
			ls_ModifySyntax = ' create text(band=' + ls_Band + ' text="" x="' + String(ll_RightDownX) + '" y="' + String(ll_RightDownY) + '" height="' + String(TEXTMARKHEIGHT) + '" width="' + String(TEXTMARKWIDTH) + '" name=' + ls_RightDownMarkName + ')'
			This.Modify(ls_ModifySyntax)
		end if
	end if
	
	if Not lb_IsSelected then
		ll_Cnts = UpperBound(iuo_parent.istr_SelectObj)
		for ll_Cycle = 1 to ll_Cnts
			ls_ObjName = iuo_parent.istr_SelectObj[ll_Cycle].FName
			if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then Exit
		next
		iuo_parent.istr_SelectObj[ll_Cycle].FBand = This
		iuo_parent.istr_SelectObj[ll_Cycle].FName = as_ObjName
		ll_Pos = ll_Cycle
	end if
	iuo_parent.of_UpdateLastSelObjList(ll_Pos,true)
	is_CurObj = as_ObjName
else
	ls_ModifySyntax = ""
	
	if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_LeftUpMarkName + TABCHAR)) > 0 then
		ls_ModifySyntax += ' Destroy ' + ls_LeftUpMarkName
	end if
	
	if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_LeftDownMarkName + TABCHAR)) > 0 then
		ls_ModifySyntax += ' Destroy ' + ls_LeftDownMarkName
	end if
	
	if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_RightUpMarkName + TABCHAR)) > 0 then
		ls_ModifySyntax += ' Destroy ' + ls_RightUpMarkName
	end if
	
	if PosA(Lower(ls_AllObjects),Lower(TABCHAR + ls_RightDownMarkName + TABCHAR)) > 0 then
		ls_ModifySyntax += ' Destroy ' + ls_RightDownMarkName
	end if
	
	if Not IsNull(ls_ModifySyntax) and Trim(ls_ModifySyntax) <> "" then
		This.Modify(ls_ModifySyntax)
	end if
	
	if lb_IsSelected then
		iuo_parent.istr_SelectObj[ll_Pos].FName = ""
		iuo_parent.of_UpdateLastSelObjList(ll_Pos,false)
	end if
end if
end subroutine

public subroutine of_create_rectangle_frame (string as_band, long al_xpos, long al_ypos);//====================================================================
// Function: of_create_rectangle_frame()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_band
// 	value    long      al_xpos
// 	value    long      al_ypos
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_AllObjects

ls_AllObjects = TABCHAR + This.Describe("DataWindow.Objects") + TABCHAR
if PosA(Lower(ls_AllObjects),Lower(TABCHAR + is_RectFrameName + TABCHAR)) > 0 then
	Return
end if

il_OriginX = al_XPos
il_OriginY = al_YPos

This.Modify('create rectangle(band=' + Lower(as_Band) + ' x="' + String(il_OriginX) + '" y="' + String(il_OriginY) + '" height="4" width="4" name=' + is_RectFrameName + ' brush.hatch="7" pen.color="' + String(il_RectFrameColor) + '")')

end subroutine

public subroutine of_refreshmarkpos (string as_objname);//====================================================================
// Function: of_refreshmarkpos()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_X1,ll_X2,ll_Y1,ll_Y2,ll_ObjX,ll_ObjY,ll_ObjWidth,ll_ObjHeight,ll_BandHeight
long		ll_LeftUpX,ll_LeftUpY,ll_LeftDownX,ll_LeftDownY,ll_RightUpX,ll_RightUpY,ll_RightDownX,ll_RightDownY
String	ls_LeftUpMarkName,ls_LeftDownMarkName,ls_RightUpMarkName,ls_RightDownMarkName
String	ls_Modify,ls_ObjType

if IsNull(as_ObjName) or Trim(as_ObjName) = "" then Return

ll_BandHeight = This.Height

ls_LeftUpMarkName    = LEFTUPTEXTMARK + as_ObjName
ls_LeftDownMarkName  = LEFTDOWNTEXTMARK + as_ObjName
ls_RightUpMarkName   = RIGHTUPTEXTMARK + as_ObjName
ls_RightDownMarkName = RIGHTDOWNTEXTMARK + as_ObjName

ls_ObjType = This.Describe(as_ObjName + ".Type")

if ls_ObjType = "line" then
	ll_X1 = long(This.Describe(as_ObjName + ".X1"))
	ll_Y1 = long(This.Describe(as_ObjName + ".Y1"))
	ll_X2 = long(This.Describe(as_ObjName + ".X2"))
	ll_Y2 = long(This.Describe(as_ObjName + ".Y2"))
	
	ls_Modify  = " " + ls_LeftUpMarkName + ".X = " + String(ll_X1 - 2 * TEXTMARKWIDTH)
	ls_Modify += " " + ls_LeftUpMarkName + ".Y = " + String(ll_Y1 - TEXTMARKHEIGHT - TEXTMARKVSPACE)
	
	ls_Modify += " " + ls_RightDownMarkName + ".X = " + String(ll_X2 + TEXTMARKHSPACE)
	ls_Modify += " " + ls_RightDownMarkName + ".Y = " + String(ll_Y2 + TEXTMARKVSPACE)
else
	ll_ObjX = long(This.Describe(as_ObjName + ".X"))
	ll_ObjY = long(This.Describe(as_ObjName + ".Y"))
	ll_ObjWidth = long(This.Describe(as_ObjName + ".Width"))
	ll_ObjHeight = long(This.Describe(as_ObjName + ".Height"))
	
	ll_LeftUpX = ll_ObjX - 2 * TEXTMARKWIDTH
	ll_LeftUpY = ll_ObjY - TEXTMARKHEIGHT - TEXTMARKVSPACE
	if ll_LeftUpY <= 0 then ll_LeftUpY += TEXTMARKHEIGHT
	
	ll_LeftDownX = ll_ObjX - 2 * TEXTMARKWIDTH
	ll_LeftDownY = ll_ObjY + ll_ObjHeight + TEXTMARKVSPACE
	if ll_LeftDownY + TEXTMARKHEIGHT >= ll_BandHeight then ll_LeftDownY = ll_LeftDownY - TEXTMARKHEIGHT
	
	ll_RightUpX = ll_ObjX + ll_ObjWidth + TEXTMARKHSPACE
	ll_RightUpY = ll_ObjY - TEXTMARKHEIGHT - TEXTMARKVSPACE
	if ll_RightUpY <= 0 then ll_RightUpY += TEXTMARKHEIGHT
	
	ll_RightDownX = ll_ObjX + ll_ObjWidth + TEXTMARKHSPACE
	ll_RightDownY = ll_ObjY + ll_ObjHeight + TEXTMARKVSPACE
	if ll_RightDownY + TEXTMARKHEIGHT >= ll_BandHeight then ll_RightDownY = ll_RightDownY - TEXTMARKHEIGHT
	
	ls_Modify  = " " + ls_LeftUpMarkName + ".X = " + String(ll_LeftUpX)
	ls_Modify += " " + ls_LeftUpMarkName + ".Y = " + String(ll_LeftUpY)
	
	ls_Modify += " " + ls_LeftDownMarkName + ".X = " + String(ll_LeftDownX)
	ls_Modify += " " + ls_LeftDownMarkName + ".Y = " + String(ll_LeftDownY)
	
	ls_Modify += " " + ls_RightUpMarkName + ".X = " + String(ll_RightUpX)
	ls_Modify += " " + ls_RightUpMarkName + ".Y = " + String(ll_RightUpY)
	
	ls_Modify += " " + ls_RightDownMarkName + ".X = " + String(ll_RightDownX)
	ls_Modify += " " + ls_RightDownMarkName + ".Y = " + String(ll_RightDownY)
end if

This.Modify(ls_Modify)

end subroutine

public subroutine of_moveselectedobject (string as_objname, long al_diff_x, long al_diff_y);//====================================================================
// Function: of_moveselectedobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_objname
// 	value    long      al_diff_x
// 	value    long      al_diff_y
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Modify,ls_Band
long		ll_X1,ll_X2,ll_Y1,ll_Y2

if IsNull(as_ObjName) or Trim(as_ObjName) = "" then Return

if Lower(is_BandType) = Lower("HeaderGroup") then
	ls_Band = "header.1"
elseif Lower(is_BandType) = Lower("TrailerGroup") then
	ls_Band = "trailer.1"
else
	ls_Band = is_BandType
end if

if Lower(This.Describe(as_ObjName + ".band")) <> Lower(ls_Band) then Return

if This.Describe(as_ObjName + ".type") <> 'line' THEN
	ll_X1 = long(This.Describe(as_ObjName + ".X")) + al_Diff_X
	ll_Y1 = long(This.Describe(as_ObjName + ".Y")) + al_Diff_Y
	if ll_X1 < 0 then ll_X1 = 0
	if ll_Y1 < 0 then ll_Y1 = 0
	ls_Modify += " " + as_ObjName + ".X = " + String(ll_X1)
	ls_Modify += " " + as_ObjName + ".Y = " + String(ll_Y1)
else
	ll_X1 = long(This.Describe(as_ObjName + ".X1")) + al_Diff_X
	ll_X2 = long(This.Describe(as_ObjName + ".X2")) + al_Diff_X
	ll_Y1 = long(This.Describe(as_ObjName + ".Y1")) + al_Diff_Y
	ll_Y2 = long(This.Describe(as_ObjName + ".Y2")) + al_Diff_Y
	if ll_X1 < 0 then ll_X1 = 0
	if ll_X2 < 0 then ll_X2 = 0
	if ll_Y1 < 0 then ll_Y1 = 0
	if ll_Y2 < 0 then ll_Y2 = 0
	ls_Modify += " " + as_ObjName + ".X1 = " + String(ll_X1)
	ls_Modify += " " + as_ObjName + ".X2 = " + String(ll_X2)
	ls_Modify += " " + as_ObjName + ".Y1 = " + String(ll_Y1)
	ls_Modify += " " + as_ObjName + ".Y2 = " + String(ll_Y2)
end if

This.Modify(ls_Modify)
iuo_Parent.Event ue_SetModify(ls_Modify)

end subroutine

public subroutine of_getobjectinformation (string as_objname, ref string as_objtype, ref long al_x, ref long al_y, ref long al_width, ref long al_height);//====================================================================
// Function: of_GetObjectInformation()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value        string    as_objname
// 	reference    string    as_ObjType
// 	reference    long      al_x
// 	reference    long      al_y
// 	reference    long      al_width
// 	reference    long      al_height
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

as_ObjType = This.Describe(as_ObjName + ".Type")

if as_ObjType = "line" then
	al_X = long(This.Describe(as_ObjName + ".X1"))
	al_Y = long(This.Describe(as_ObjName + ".Y1"))
	al_Width  = long(This.Describe(as_ObjName + ".X2"))
	al_Height = long(This.Describe(as_ObjName + ".Y2"))
else
	al_X = long(This.Describe(as_ObjName + ".X"))
	al_Y = long(This.Describe(as_ObjName + ".Y"))
	al_Width  = long(This.Describe(as_ObjName + ".Width"))
	al_Height = long(This.Describe(as_ObjName + ".Height"))
end if

end subroutine

public function string of_getobjecttype (string as_objname);//====================================================================
// Function: of_GetObjectType()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjType

ls_ObjType = This.Describe(as_ObjName + ".Type")

Return ls_ObjType

end function

public function string of_getobjecttag (string as_objname);//====================================================================
// Function: of_GetObjectTag()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_objname
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjTag

ls_ObjTag = This.Describe(as_ObjName + ".Tag")

Return ls_ObjTag

end function

public function string of_getobjectid (string as_objname);//====================================================================
// Function: of_GetObjectID()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_objname
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjID

ls_ObjID = This.Describe(as_ObjName + ".ID")

Return ls_ObjID

end function

public subroutine of_getobjectattr (string as_objname, ref string as_bold, ref string as_italic, ref string as_underline, ref string as_align);//====================================================================
// Function: of_getobjectattr()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value        string    as_objname
// 	reference    string    as_bold
// 	reference    string    as_italic
// 	reference    string    as_underline
// 	reference    string    as_align
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-14
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjType

as_bold = This.Describe(as_ObjName + ".Font.Weight")
as_italic = This.Describe(as_ObjName + ".Font.Italic")
as_align = This.Describe(as_ObjName + ".Alignment")

ls_ObjType = of_GetObjectType(as_ObjName)
if ls_ObjType = "column" then as_ObjName += "_t"
as_underline = This.Describe(as_ObjName + ".Font.Underline")

end subroutine

public function string of_getrelcolname (string as_objname);//====================================================================
// Function: of_GetRelColName()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-15
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjType,ls_ColName,ls_Field_id
long		ll_Cycle,ll_ColCnts

ls_ObjType = of_GetObjectType(as_ObjName)

if Lower(ls_ObjType) = "column" then
	ls_Field_id = of_GetObjectID(as_ObjName)
elseif Lower(ls_ObjType) = "text" then
	ls_Field_id = of_GetObjectTag(as_ObjName)
end if

if Not IsNumber(ls_Field_id) then Return ""

ll_ColCnts = long(This.Describe("DataWindow.Column.Count"))
for ll_Cycle = 1 to ll_ColCnts
	if This.Describe("#" + String(ll_Cycle) + ".id") = ls_Field_id then
		ls_ColName = This.Describe("#" + String(ll_Cycle) + ".Name")
		Exit
	end if
next

Return ls_ColName

end function

public subroutine of_destroy_rectangle_frame ();//====================================================================
// Function: of_Destroy_Rectangle_Frame()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-16
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_AllObjects

ls_AllObjects = TABCHAR + This.Describe("DataWindow.Objects") + TABCHAR
if PosA(Lower(ls_AllObjects),Lower(TABCHAR + is_RectFrameName + TABCHAR)) > 0 then
	This.Modify('Destroy ' + is_RectFrameName)
end if

end subroutine

public subroutine of_modify_rectangle_frame ();//====================================================================
// Function: of_Modify_Rectangle_Frame()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-17
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_XPos,ll_YPos
long		ll_X,ll_Y,ll_Width,ll_Height
String	ls_Syntax

ll_XPos = This.PointerX()
ll_YPos = This.PointerY()
if ll_XPos <= 0 then ll_XPos = 0
if ll_YPos <= 0 then ll_YPos = 0

if ll_XPos > il_OriginX then
	ll_X = il_OriginX
	ll_Width = ll_XPos - il_OriginX
else
	ll_X = ll_XPos
	ll_Width = il_OriginX - ll_XPos
end if

if ll_YPos > il_OriginY then
	ll_Y = il_OriginY
	ll_Height = ll_YPos - il_OriginY
else
	ll_Y = ll_YPos
	ll_Height = il_OriginY - ll_YPos
end if

if ll_X <= 0 then ll_X = 0
if ll_Y <= 0 then ll_Y = 0

ls_Syntax = is_RectFrameName + ".X = '" + String(ll_X) + "' " + &
				is_RectFrameName + ".Y = '" + String(ll_Y) + "' " + &
				is_RectFrameName + ".Width = '" + String(ll_Width) + "' " + &
				is_RectFrameName + ".Height = '" + String(ll_Height) + "'"

This.Modify(ls_Syntax)

end subroutine

public subroutine of_rectframeselectobject (long al_outsiderectx, long al_outsiderecty, long al_outsiderectwidth, long al_outsiderectheight);//====================================================================
// Function: of_RectFrameSelectObject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_OutsideRectX
// 	value    long    al_OutsideRectY
// 	value    long    al_OutsideRectWidth
// 	value    long    al_OutsideRectHeight
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_ObjLeftUpX,ll_ObjLeftUpY,ll_ObjWidth,ll_ObjHeight,ll_Pos
long		ll_InsideRectX,ll_InsideRectY,ll_InsideRectWidth,ll_InsideRectHeight
String	ls_AllObjects,ls_ObjName,ls_ObjType,ls_Band

if al_OutsideRectWidth <= 0 and al_OutsideRectHeight <= 0 then Return
if This.Y > al_OutsideRectY + al_OutsideRectHeight or This.Y + This.Height < al_OutsideRectY then Return

ll_InsideRectX = al_OutsideRectX - This.X
ll_InsideRectWidth = al_OutsideRectWidth

if This.Y < al_OutsideRectY then
	ll_InsideRectY = al_OutsideRectY - This.Y
else
	ll_InsideRectY = 0
end if

if This.Y + This.Height < al_OutsideRectY + al_OutsideRectHeight then
	ll_InsideRectHeight = This.Height - ll_InsideRectY
else
	ll_InsideRectHeight = al_OutsideRectY + al_OutsideRectHeight - (ll_InsideRectY + This.Y)
end if

ls_AllObjects = This.Describe("DataWindow.Objects") + TABCHAR
ll_Pos = PosA(ls_AllObjects,TABCHAR)

do while ll_Pos > 0
	ls_ObjName = LeftA(ls_AllObjects,ll_Pos - 1)
	ls_AllObjects = MidA(ls_AllObjects,ll_Pos + LenA(TABCHAR))
	ll_Pos = PosA(ls_AllObjects,TABCHAR)
	
	if IsNull(ls_ObjName) or Trim(ls_ObjName) = "" then CONTINUE
	
	if PosA(Lower(ls_ObjName),Lower(LEFTUPTEXTMARK)) > 0 or PosA(Lower(ls_ObjName),Lower(LEFTDOWNTEXTMARK)) > 0 or &
		PosA(Lower(ls_ObjName),Lower(RIGHTUPTEXTMARK)) > 0 or PosA(Lower(ls_ObjName),Lower(RIGHTDOWNTEXTMARK)) > 0 or &
		PosA(Lower(ls_ObjName),Lower(is_RectFrameName)) > 0 then
		CONTINUE
	end if
	
	if This.Describe(ls_ObjName + ".Visible") = "0" then CONTINUE
	
	if Lower(is_BandType) = Lower("HeaderGroup") then
		ls_Band = "header.1"
	elseif Lower(is_BandType) = Lower("TrailerGroup") then
		ls_Band = "trailer.1"
	else
		ls_Band = is_BandType
	end if
	
	if Lower(This.Describe(ls_ObjName + ".Band")) <> Lower(ls_Band) then CONTINUE
	
	ls_ObjType = This.Describe(ls_ObjName + ".Type")
	if ls_ObjType = "line" then
		ll_ObjLeftUpX = long(This.Describe(ls_ObjName + ".X1"))
		ll_ObjLeftUpY = long(This.Describe(ls_ObjName + ".Y1"))
		ll_ObjWidth   = long(This.Describe(ls_ObjName + ".X2")) - ll_ObjLeftUpX
		ll_ObjHeight  = long(This.Describe(ls_ObjName + ".Y2")) - ll_ObjLeftUpY
	else
		ll_ObjLeftUpX = long(This.Describe(ls_ObjName + ".X"))
		ll_ObjLeftUpY = long(This.Describe(ls_ObjName + ".Y"))
		ll_ObjWidth   = long(This.Describe(ls_ObjName + ".Width"))
		ll_ObjHeight  = long(This.Describe(ls_ObjName + ".Height"))
	end if
	
	if (ll_ObjLeftUpX + ll_ObjWidth >= ll_InsideRectX and ll_ObjLeftUpX <= ll_InsideRectX + ll_InsideRectWidth) and &
		(ll_ObjLeftUpY <= ll_InsideRectY + ll_InsideRectHeight and ll_ObjLeftUpY + ll_ObjHeight >= ll_InsideRectY) then
		of_AddOrDelSingleSelect(ls_ObjName,true)
	end if
loop

end subroutine

public subroutine of_resizeselectedobject (string as_objname, long al_diff_x, long al_diff_y);//====================================================================
// Function: of_ResizeSelectedObject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjName
// 	value    long      al_Diff_X
// 	value    long      al_Diff_Y
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

String	ls_Modify
long		ll_Width,ll_X2,ll_Height,ll_Y2

if IsNull(as_ObjName) or Trim(as_ObjName) = "" then Return
if Lower(This.Describe(as_ObjName + ".band")) <> Lower(is_BandType) then Return

if This.Describe(as_ObjName + ".type") <> 'line' THEN
	ll_Width = long(This.Describe(as_ObjName + ".Width")) + al_Diff_X
	ll_Height = long(This.Describe(as_ObjName + ".Height")) + al_Diff_Y
	if ll_Width < 4 then ll_Width = 4
	if ll_Height < 4 then ll_Height = 4
	ls_Modify += " " + as_ObjName + ".Width = " + String(ll_Width)
	ls_Modify += " " + as_ObjName + ".Height = " + String(ll_Height)
else
	ll_X2 = long(This.Describe(as_ObjName + ".X2")) + al_Diff_X
	ll_Y2 = long(This.Describe(as_ObjName + ".Y2")) + al_Diff_Y
	ls_Modify += " " + as_ObjName + ".X2 = " + String(ll_X2)
	ls_Modify += " " + as_ObjName + ".Y2 = " + String(ll_Y2)
end if

This.Modify(ls_Modify)
iuo_Parent.Event ue_SetModify(ls_Modify)

end subroutine

public subroutine of_getlastrightclickpos (ref long al_xpos, ref long al_ypos);//====================================================================
// Function: of_GetLastRightClickPos()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_XPos
// 	value    long    al_YPos
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

al_XPos = il_RightClickXPos
al_YPos = il_RightClickYPos

end subroutine

public function string of_getobjectsyntax (string as_objectname);//====================================================================
// Function: of_GetObjectSyntax()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ObjectName
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String 	ls_Syntax,ls_Object,ls_RowStr,ls_Modify,ls_CurLetter
long		ll_Pos,ll_RowStart,ll_RowEnd,ll_SecleftBraPos,ll_FirRighBraPos,ll_LeftBracketCnts,ll_RightBracketCnts

ls_Syntax = This.Describe("Datawindow.Syntax")
ls_Syntax = MidA(ls_Syntax,LastPos(LeftA(ls_Syntax,PosA(ls_Syntax,"band=")),ENTERCHAR) + LenA(ENTERCHAR))
ll_Pos = PosA(ls_Syntax,"name=" + Lower(as_ObjectName) + " ")
if ll_Pos > 0 then
	ll_RowStart = LastPos(LeftA(ls_Syntax,ll_Pos),ENTERCHAR) + LenA(ENTERCHAR)
	ll_RowEnd = ll_RowStart
	
	ll_SecleftBraPos = PosA(ls_Syntax,"(",PosA(ls_Syntax,"(",ll_RowStart) + 1)
	ll_FirRighBraPos = PosA(ls_Syntax,")",ll_RowStart)
	
	if ll_SecleftBraPos > ll_FirRighBraPos then		//Adjust the performance
		ll_RowEnd = ll_FirRighBraPos + 1
	else
		ll_LeftBracketCnts = 0
		ll_RightBracketCnts = 0
		do while ll_LeftBracketCnts = 0 or ll_LeftBracketCnts <> ll_RightBracketCnts
			ls_CurLetter = MidA(ls_Syntax,ll_RowEnd,1)
			if ls_CurLetter = "(" then ll_LeftBracketCnts++
			if ls_CurLetter = ")" then ll_RightBracketCnts++
			ll_RowEnd++
		loop
	end if

	ls_RowStr = MidA(ls_Syntax,ll_RowStart,ll_RowEnd - ll_RowStart)
end if

Return ls_RowStr

end function

public function string of_objectnameverify (string as_name);//====================================================================
// Function: of_ObjectNameVerify()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_name
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_SingleLetter
long		ll_Cycle,ll_Length

STRING ERROR_NOTVALID
STRING ERROR_NAMEREPEAT

as_Name = Lower(as_Name)

ERROR_NOTVALID   = "'" + as_name + "' is not a valid name."
ERROR_NAMEREPEAT = "'" + as_name + "' is already in use."

if This.Describe(as_name + ".Name") <> "!" then
	Return ERROR_NAMEREPEAT
end if

ls_SingleLetter = LeftA(as_Name,1)
if Not (ls_SingleLetter >= 'a' and ls_SingleLetter <= 'z') then
	Return ERROR_NOTVALID
end if

ll_Length = LenA(as_Name)
for ll_Cycle = 2 to ll_Length
	ls_SingleLetter = MidA(as_Name,ll_Cycle,1)
	if Not (ls_SingleLetter >= 'a' and ls_SingleLetter <= 'z' or ls_SingleLetter >= '0' and ls_SingleLetter <= '9' or ls_SingleLetter = '_') then
		Return ERROR_NOTVALID
	end if
next

Return ""

end function

public function string of_get_invisible_field ();//====================================================================
// Function: Of_Get_Invisible_Field()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_RowCnts
String	ls_FieldName,ls_FieldLabel,ls_InVisibleFieldList

iuo_Parent.dw_Properties.SetFilter("")
iuo_Parent.dw_Properties.Filter( )

ll_RowCnts = iuo_Parent.dw_Properties.RowCount()

for ll_Cycle = 1 to ll_RowCnts
	ls_FieldName = iuo_Parent.dw_Properties.GetItemString(ll_Cycle,"sys_fields_field_name")
	if Lower(Describe(ls_FieldName + ".band")) = Lower(is_BandType) then
		if Upper(iuo_Parent.dw_Properties.GetItemString(ll_Cycle, "data_view_fields_visible" )) = "N" then
			ls_FieldLabel = iuo_Parent.dw_Properties.GetItemString(ll_Cycle, "data_view_fields_field_label" )
			ls_InVisibleFieldList += ls_FieldName + ENTERCHAR
		end if
	end if
next

Return ls_InVisibleFieldList

end function

public function integer of_modify_column_property (string as_column_name, string as_property_name);//====================================================================
// Function: of_Modify_Column_Property()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_Column_Name
// 	value    string    as_Property_Name
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_Edit_Style,ls_EditMask,ls_UseAsBorder,ls_Protect
String ls_DefValue,ls_VScrollBar,ls_LabelBand
String ls_Column_Name,ls_Case,ls_DisplayOnly
String ls_Modify,ls_LabelName,ls_FieldLabel,ls_b_Name
String ls_Value,ls_Visible,ls_AutoHeight
Long   ll_Cnt,ll_Find
string ls_str

u_cst_dw_band	ldw_band

iuo_Parent.dw_properties.AcceptText()

if RightA(as_Column_Name,2) = "_t" then
	ls_LabelName = as_Column_Name
	ls_Column_Name = LeftA(as_Column_Name,LenA(as_Column_Name) - 2)
else
	ls_LabelName = as_Column_Name + "_t"
	ls_Column_Name = as_Column_Name
end if

if IsNull(ls_LabelName) or Trim(ls_LabelName) = "" then Return 1
if IsNull(ls_Column_Name) or Trim(ls_Column_Name) = "" then Return 1

ls_LabelBand = iuo_Parent.uo_band.dw_Syntax.Describe(ls_LabelName + ".Band")
CHOOSE CASE UPPER(ls_LabelBand)
	CASE 'HEADER'
		ldw_band = iuo_Parent.uo_band.dw_Header
	CASE 'DETAIL'
		ldw_band = iuo_Parent.uo_band.dw_detail
	CASE 'SUMMARY'
		ldw_band = iuo_Parent.uo_band.dw_Summary
	CASE 'FOOTER'
		ldw_Band = iuo_Parent.uo_band.dw_Footer
	CASE 'HEADER.1'
		ldw_band = iuo_Parent.uo_band.dw_Headergroup
	CASE 'HEADER.2'
		ldw_band = iuo_Parent.uo_band.dw_Headergroup2
	CASE 'HEADER.3'
		ldw_band = iuo_Parent.uo_band.dw_Headergroup3
	CASE 'TRAILER.1'
		ldw_band = iuo_Parent.uo_band.dw_trailergroup
	CASE 'TRAILER.2'
		ldw_band = iuo_Parent.uo_band.dw_trailergroup2
	CASE 'TRAILER.3'
		ldw_band = iuo_Parent.uo_band.dw_trailergroup3
	CASE else
		//None
END CHOOSE

ls_Edit_Style = This.Describe(ls_Column_Name + ".Edit.Style")

CHOOSE CASE as_Property_Name
	CASE "fields_label_border"
		ls_Modify = ls_LabelName + ".Border = '" + String(iuo_Parent.dw_properties.GetItemString(1, "fields_label_border")) + "'"
		if IsValid(ldw_band) then ldw_band.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "fields_border"
		ls_Modify = ls_Column_Name + ".Border = '" + String(iuo_Parent.dw_properties.GetItemString(1, "fields_border")) + "'"
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "data_view_fields_visible"
		ls_Visible = iuo_Parent.dw_properties.GetItemString(1, "data_view_fields_visible")
		if ls_Visible = "N" then ls_Visible = '0' else ls_Visible = '1'
		
		ls_Modify = ls_Column_Name + ".Visible = '" + ls_Visible + "' "
		iuo_Parent.Event ue_SetModify(ls_Modify)
		
		ls_Modify += LEFTUPTEXTMARK + ls_Column_Name + ".visible = '" + ls_Visible + "' "
		ls_Modify += LEFTDOWNTEXTMARK + ls_Column_Name + ".visible = '" + ls_Visible + "' "
		ls_Modify += RIGHTUPTEXTMARK + ls_Column_Name + ".visible = '" + ls_Visible + "' "
		ls_Modify += RIGHTDOWNTEXTMARK + ls_Column_Name + ".visible = '" + ls_Visible + "' "
		This.Modify(ls_Modify)
		
		if LeftA(ls_Column_Name,LenA("object")) <> "object" then
			if iuo_Parent.uo_band.dw_Syntax.Describe(ls_LabelName + ".Name") = ls_LabelName then
				ls_Modify = ls_LabelName + ".visible = '" + ls_Visible + "' "
				if ls_Visible = '0' then
					ls_FieldLabel = ls_Column_Name
				else
					ls_FieldLabel = iuo_parent.dw_properties.GetItemString(1, "data_view_fields_field_label")
				end if
				ls_Modify += ls_LabelName + ".text = ~"" + ls_FieldLabel + "~" "
				iuo_Parent.Event ue_SetModify(ls_Modify)
				
				ls_Modify += LEFTUPTEXTMARK + ls_LabelName + ".visible = '" + ls_Visible + "' "
				ls_Modify += LEFTDOWNTEXTMARK + ls_LabelName + ".visible = '" + ls_Visible + "' "
				ls_Modify += RIGHTUPTEXTMARK + ls_LabelName + ".visible = '" + ls_Visible + "' "
				ls_Modify += RIGHTDOWNTEXTMARK + ls_LabelName + ".visible = '" + ls_Visible + "' "
				if IsValid(ldw_band) then ldw_band.Modify(ls_Modify)
			end if
		end if
		
		ls_b_name = 'b_' + ls_Column_Name
		if iuo_Parent.uo_band.dw_Syntax.Describe(ls_b_name + ".Name") = ls_b_name then
			ls_Modify = ls_b_name + ".visible = '" + ls_Visible + "' "
			iuo_Parent.Event ue_SetModify(ls_Modify)
		
			ls_Modify += LEFTUPTEXTMARK + ls_b_name + ".visible = '" + ls_Visible + "' "
			ls_Modify += LEFTDOWNTEXTMARK + ls_b_name + ".visible = '" + ls_Visible + "' "
			ls_Modify += RIGHTUPTEXTMARK + ls_b_name + ".visible = '" + ls_Visible + "' "
			ls_Modify += RIGHTDOWNTEXTMARK + ls_b_name + ".visible = '" + ls_Visible + "' "
			This.Modify(ls_Modify)
		end if
	CASE "data_view_fields_field_label"
		ls_FieldLabel = iuo_parent.dw_properties.GetItemString(1, "data_view_fields_field_label")
		ls_Modify = ls_LabelName + ".text = ~"" + ls_FieldLabel + "~""
		if IsValid(ldw_band) then ldw_band.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "data_view_fields_label_justification"
		ls_Modify = ls_LabelName + ".Alignment = '" + String(iuo_Parent.dw_properties.GetItemNumber(1, "data_view_fields_label_justification")) + "'" 
		if IsValid(ldw_band) then ldw_band.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "data_view_fields_field_order"
		ls_Modify = ls_Column_Name + ".tabsequence = '" + String(iuo_parent.dw_properties.GetItemNumber(1, "data_view_fields_field_order")) + "'"
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "data_view_fields_required"
		// Required
		if iuo_Parent.dw_properties.GetItemString(1, "data_view_fields_required") = "Y" then
			ls_Modify = ls_Column_Name + "." + ls_Edit_Style + ".Required = 'Yes'"
			This.Modify(ls_Modify)
			iuo_Parent.Event ue_SetModify(ls_Modify)
			
			ls_Modify = ls_LabelName + ".font.underline = '1' "
			if IsValid(ldw_band) then ldw_band.Modify(ls_Modify)
			iuo_Parent.Event ue_SetModify(ls_Modify)
		else
			ls_Modify = ls_Column_Name + "." + ls_Edit_Style + ".Required = 'No'"
			This.Modify(ls_Modify)
			iuo_Parent.Event ue_SetModify(ls_Modify)
			
			ls_Modify = ls_LabelName + ".font.underline = '0' "
			if IsValid(ldw_band) then ldw_band.Modify(ls_Modify)
			iuo_Parent.Event ue_SetModify(ls_Modify)
		end if
	CASE "data_view_fields_justification"
		// Justification
		ls_Modify = ls_Column_Name + ".Alignment = '" + String(iuo_Parent.dw_properties.GetItemNumber(1, "data_view_fields_justification")) + "'"
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "sys_fields_drop_down_width"
		// Drop Down Width
		if ls_Edit_Style = "dddw" then
			ls_Modify = ls_Column_Name + ".dddw.PercentWidth = " + String(iuo_parent.dw_properties.GetItemNumber(1, "sys_fields_drop_down_width"))
			This.Modify(ls_Modify)
			iuo_Parent.Event ue_SetModify(ls_Modify)
		end if
	CASE "sys_fields_field_case"
		// Field Case
		if ls_Edit_Style = "edit" OR ls_Edit_Style = "dddw" OR ls_Edit_Style = "ddlb" then
			ls_Case = String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_field_case"))
			CHOOSE CASE UPPER(ls_Case)
				CASE "L"
					ls_Case = "lower"
				CASE "U"
					ls_Case = "upper"
				CASE "A"
					ls_Case = "any"
				CASE "F"
					ls_Case = "first"
				CASE else
					ls_Case = "lower"
			END CHOOSE
			ls_Modify = ls_Column_Name + "." + ls_Edit_Style + ".Case = '" + ls_Case + "'"
			This.Modify(ls_Modify)
			iuo_Parent.Event ue_SetModify(ls_Modify)
		end if
	CASE "sys_fields_field_mask"
		// Mask
		ls_EditMask = iuo_Parent.dw_properties.GetItemString(1,"sys_fields_field_mask")
		if IsNull(ls_EditMask) or Trim(ls_EditMask) = "" or Trim(ls_EditMask) = "null" then ls_EditMask = ""
		
		if ls_Edit_Style = "edit" then
			ls_Modify = ls_Column_Name + ".Edit.Format = '" + ls_EditMask + "' "
		elseif ls_Edit_Style = "editmask" then
			ls_Modify = ls_Column_Name + ".EditMask.Mask = '" + ls_EditMask + "' "
		end if
		
		ls_Modify += ls_Column_Name + ".format = '" + ls_EditMask + "'"
		
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "data_view_fields_display_only"
		// Display Only
		if ls_Edit_Style = "edit" then
			if upper(iuo_Parent.dw_properties.GetItemString(1, "data_view_fields_display_only")) = "Y" then
				ls_DisplayOnly = 'Yes'
			else
				ls_DisplayOnly = 'No'
			end if
			ls_Modify = ls_Column_Name + ".edit.displayonly = '" + ls_DisplayOnly + "'"
			This.Modify(ls_Modify)
			iuo_Parent.Event ue_SetModify(ls_Modify)
		end if
	CASE "sys_fields_lookup_field"
		ls_str = iuo_parent.dw_properties.GetItemString(1, "sys_fields_lookup_field")
		// Lookup Field
		choose case ls_str
			case 'Y'	//Lookup code
				ls_Modify = ''
			case 'C'	//Company
				ls_Modify = ''
			case 'U'	//User
				if iuo_parent.il_dw_style = 1 OR iuo_parent.ii_screen_id = 2 then 
					ls_UseAsBorder = 'No'
				else
					ls_UseAsBorder = 'Yes'
				end if
				
				// Lookup Table
				ls_Modify = ls_Column_Name + ".dddw.VscrollBar = Yes " + ls_Column_Name + ".dddw.AutoHScroll = Yes " + ls_Column_Name + ".dddw.useasborder = " + ls_UseAsBorder + " " + &
								ls_Column_Name + ".dddw.NilIsNull= Yes " + ls_Column_Name + ".dddw.name = 'd_dddw_users' " + ls_Column_Name + ".dddw.datacolumn = 'user_id' " + &
								ls_Column_Name + ".dddw.displaycolumn = 'user_id' " + ls_Column_Name + ".dddw.PercentWidth = 100 " + &
								ls_Column_Name + ".tag = ''"
		
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_default_value", "" )
				//iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field", "Y" )
				//iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field_name", "code" )
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_drop_down_width",100 )
			case 'N'	//None
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_type", "" )
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_code", "" )
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field_name", "" )
				
				ls_Modify = ls_Column_Name + ".edit.AutoHScroll = Yes " + ls_Column_Name + ".edit.NilIsNull = Yes"
		end choose
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)

	CASE "sys_fields_lookup_code"
		if iuo_parent.il_dw_style = 1 OR iuo_parent.ii_screen_id = 2 then 
			ls_UseAsBorder = 'No'
		else
			ls_UseAsBorder = 'Yes'
		end if
		ls_str = iuo_parent.dw_properties.GetItemString(1, "sys_fields_lookup_field")
		choose case ls_str
			case 'Y'	// Lookup Table
				ls_Modify = ls_Column_Name + ".dddw.VscrollBar = Yes " + ls_Column_Name + ".dddw.AutoHScroll = Yes " + ls_Column_Name + ".dddw.useasborder = " + ls_UseAsBorder + " " + &
								ls_Column_Name + ".dddw.NilIsNull= Yes " + ls_Column_Name + ".dddw.name = 'd_dddw_code_lookup' " + ls_Column_Name + ".dddw.datacolumn = 'lookup_code' " + &
								ls_Column_Name + ".dddw.displaycolumn = 'code' " + ls_Column_Name + ".dddw.PercentWidth = 300 " + &
								ls_Column_Name + ".tag = '" + String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_lookup_code")) + "'"
		
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_default_value", "" )
				//iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field", "Y" )
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field_name", "code" )
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_drop_down_width", 300 )
			case 'C'	//Company
				ls_Modify = ls_Column_Name + ".dddw.VscrollBar = Yes " + ls_Column_Name + ".dddw.AutoHScroll = Yes " + ls_Column_Name + ".dddw.useasborder = " + ls_UseAsBorder + " " + &
								ls_Column_Name + ".dddw.NilIsNull= Yes " + ls_Column_Name + ".dddw.name = 'd_dddw_company' " + ls_Column_Name + ".dddw.datacolumn = 'facility_id' " + &
								ls_Column_Name + ".dddw.displaycolumn = 'facility_name' " + ls_Column_Name + ".dddw.PercentWidth = 300 " + &
								ls_Column_Name + ".tag = '" + String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_lookup_code")) + "'"
		
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_default_value", "" )
				//iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field", "C" )
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field_name", "facility_name" )
				iuo_parent.dw_properties.SetItem( 1, "sys_fields_drop_down_width", 300 )
			case 'U'	//User
				ls_Modify = ""
			case 'N'	//None
				ls_Modify = ""
		end choose
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "sys_fields_lookup_field_name"
		// Lookup Field Name
		ls_Modify = ls_Column_Name + ".dddw.displaycolumn = '" + String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_lookup_field_name")) + "'"
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "sys_fields_default_value"
		ls_DefValue = iuo_parent.dw_properties.GetItemString(1, "sys_fields_default_value")
		if Not IsNull(ls_DefValue) and ls_DefValue <> '' then
			ls_Modify = ls_Column_Name + ".Initial = '" + String(ls_DefValue) + "'"
		else
			ls_Modify = ls_Column_Name + ".Initial = 'null'"
		end if
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "fields_label_textcolor"
		ls_Modify = ls_LabelName + ".color = " + String(iuo_Parent.dw_properties.GetItemNumber(1, "fields_label_textcolor"))
		if IsValid(ldw_band) then ldw_band.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE "fields_label_textbkcolor"
		ls_Modify = ls_LabelName + ".background.mode='2' "
		ls_Modify += ls_LabelName + ".background.color = " + String(iuo_Parent.dw_properties.GetItemNumber(1, "fields_label_textbkcolor"))
		if IsValid(ldw_band) then ldw_band.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	case 'fields_vscrollbar'
		if ls_Edit_Style = "edit" OR ls_Edit_Style = "dddw" OR ls_Edit_Style = "ddlb" then
			ls_VScrollBar = iuo_Parent.dw_properties.GetItemString(1, as_Property_Name)
			if ls_VScrollBar = 'Y' then
				ls_Modify = ls_Column_Name + "." + ls_Edit_Style + ".VScrollBar = Yes " + ls_Column_Name + "." + ls_Edit_Style + ".AutoHScroll = No " 
			else
				ls_Modify = ls_Column_Name + "." + ls_Edit_Style + ".VScrollBar = No " + ls_Column_Name + "." + ls_Edit_Style + ".AutoHScroll = Yes " 
			end if
			This.Modify(ls_Modify)
			iuo_Parent.Event ue_SetModify(ls_Modify)
		end if
	case 'fields_textcolor'
		ls_Modify = ls_Column_Name + ".color = " + String(iuo_Parent.dw_properties.GetItemNumber(1, "fields_textcolor"))
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	case 'fields_textbkcolor'
		ls_Modify  = ls_Column_Name + ".background.mode='2' "
		ls_Modify += ls_Column_Name + ".background.color = " + String(iuo_Parent.dw_properties.GetItemNumber(1, "fields_textbkcolor"))
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	//BEGIN---Modify by Scofield on 2010-04-07
	Case 'fields_protect'
		ls_Protect = Trim(iuo_Parent.dw_Properties.GetItemString(1,"fields_protect"))
		if LeftA(ls_Protect,1) = "'" and RightA(ls_Protect,1) = "'" or LeftA(ls_Protect,1) = '"' and RightA(ls_Protect,1) = '"' then
			ls_Protect = MidA(ls_Protect,2,LenA(ls_Protect) - 2)
		end if
		
		ls_Modify  = ls_Column_Name + ".Protect = '" + ls_Protect + "'"
		iuo_Parent.Event ue_SetModify(ls_Modify)
	//END---Modify by Scofield on 2010-04-07
	Case 'fields_slideup'
		ls_Modify = ls_Column_Name + ".SlideUp='" + iuo_Parent.dw_properties.GetItemString(1,"Fields_SlideUp") + "' "
		This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	Case 'fields_autoheight'
		ls_Modify = ""
		
		ls_AutoHeight = iuo_Parent.dw_Properties.GetItemString(1,"Fields_AutoHeight")
		
		if Lower(ls_AutoHeight) = Lower("Yes") then
			ls_Modify += "DataWindow.Detail.Height.AutoSize='Yes' "
		end if
		
		ls_Modify += ls_Column_Name + ".Height.AutoSize='" + ls_AutoHeight + "' "
		
		//This.Modify(ls_Modify)
		iuo_Parent.Event ue_SetModify(ls_Modify)
	CASE else
		RETURN 0
END CHOOSE

if as_Property_Name = "data_view_fields_visible" OR as_Property_Name = "data_view_fields_field_label" then
	if as_Property_Name = "data_view_fields_visible" then ls_Value = ls_Visible else ls_Value = ls_FieldLabel
	
	ll_Cnt = iuo_Parent.dw_fields_alias.RowCount()
	ll_Find = iuo_Parent.dw_fields_alias.Find("c_name='" + ls_Column_Name + "'",ll_Find,ll_Cnt)
	do while ll_Find > 0
		if as_Property_Name = "data_view_fields_visible" then
			iuo_Parent.dw_fields_alias.SetItem(ll_Find,"visible",Long(ls_Value))
		else
			iuo_Parent.dw_fields_alias.SetItem(ll_Find,"c_alias",LeftA(ls_Value,255))
		end if
		if ll_Find >= ll_Cnt then Exit
		ll_Find = iuo_Parent.dw_fields_alias.Find("c_name='" + ls_Column_Name + "'",ll_Find + 1,ll_Cnt)
	loop
end if

Return 1

end function

public subroutine of_modify_collabel_property (string as_label, string as_value);//====================================================================
// Function: of_Modify_ColLabel_Property()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_Label
// 	value    string    as_Value
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


end subroutine

public function integer of_set_dw_properties (string as_property_name);String ls_Column_Name,ls_LabelName

iuo_parent.dw_properties.AcceptText( )

if RightA(is_CurObj,2) = "_t" then
	ls_Column_Name = LeftA(is_CurObj,LenA(is_CurObj) - 2)
	ls_LabelName = is_CurObj
else
	ls_LabelName = of_GetRelColName(is_CurObj) + "_t"
	ls_Column_Name = is_CurObj
end if

if IsNull(ls_LabelName) or Trim(ls_LabelName) = "" then Return 1
if IsNull(ls_Column_Name) or Trim(ls_Column_Name) = "" then Return 1

of_Modify_Column_Property(ls_Column_Name,as_Property_Name)

RETURN 1

end function

public subroutine of_getobject_fontsize (string as_objname, ref string as_size);//====================================================================
//$<Function>: of_getobject_fontsize
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.14.2014 (IntelliReport Modifications 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

as_size = This.Describe(as_ObjName + ".Font.height")

end subroutine

event getfocus;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
//this.modify('datawindow.'+is_bandtype+'.color=15793151')
//---------------------------- APPEON END ----------------------------

end event

event constructor;of_GetParentWindow(iw_parent)			//Added by Scofield on 2009-04-22

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2008 By: Andy
This.of_SetUpdateable(False)

//$<add> 2007-11-05 By: Andy
Event post ue_postopen()
//---------------------------- APPEON END ----------------------------
end event

event rbuttondown;//====================================================================
// Event: rbuttondown()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ObjName
long		ll_Pos
Boolean	lb_Selected

if iuo_parent.ib_Set_Tab_Order then Return
if iuo_parent.is_AddObjectType <> '' then Return

ls_ObjName = This.GetObjectatPointer()
ls_ObjName = LeftA(ls_ObjName,PosA(ls_ObjName,'~t') - 1)
if Lower(ls_ObjName) = Lower(is_RectFrameName) then ls_ObjName = ""

il_RightClickXPos = PointerX()
il_RightClickYPos = PointerY()

if Not IsNull(ls_ObjName) and ls_ObjName <> "" Then
	lb_Selected = of_IsSelected(ls_ObjName,ll_Pos)
end if

if KeyDown(KeyControl!) then
	iuo_parent.ib_Control_Down = True
	iuo_parent.ib_Multi_Select = True
	
	if ls_ObjName <> "" then
		of_AddOrDelSingleSelect(ls_ObjName,Not lb_Selected)
	end if
else
	iuo_parent.ib_Control_Down = False
	iuo_parent.ib_Multi_Select = False
	
	if Not lb_Selected then
		iuo_parent.of_UnSelectAllObject()
		if ls_ObjName <> "" then
			if This.Describe(ls_ObjName + ".type") = 'line' Then
				il_LineOrgX = XPos
				il_LineOrgY = YPos
			end if
			of_AddOrDelSingleSelect(ls_ObjName,true)
		end if
	end if
end if

ls_ObjName = iuo_Parent.of_GetLastSelectedObject()
if Not IsNull(ls_ObjName) and Trim(ls_ObjName) <> "" then
	is_CurObj = ls_ObjName
end if

iuo_Parent.of_Refresh_Object_Inforamtion()

iuo_parent.dynamic event ue_RButtonDown()

end event

event doubleclicked;//BEGIN---Delete by Evan 07/24/2008
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-13 By: Andy

IF isNull(is_CurObj) or is_CurObj = "" THEN
	Return
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> 
If isvalid(m_pfe_cst_contract_data_design) Then
	If m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = False Then Return
End If
//---------------------------- APPEON END ----------------------------

//IF is_last_object[1] <> "" AND Right(is_last_object[1],2) <> "_t" THEN
iuo_parent.of_field_property_sheet()
//END IF
*/
iuo_parent.TriggerEvent("ue_properties")
//END---Delete by Evan 07/24/2008

end event

event losefocus;//Commented by Scofield on 2009-04-09

/*
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
GraphicObject which_control
datawindow	ldw

if iuo_parent.ib_Set_Tab_Order then return
which_control = GetFocus()

if not IsValid(which_control) or isnull(which_control) then return
if TypeOf(which_control) = datawindow! then
	ldw = which_control
	if lower(ldw.classname())<>'dw_rulers' then
		this.of_AddOrDelSingleSelect(is_CurObj,false)
	end if
end if
//---------------------------- APPEON END ----------------------------
*/

end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-6 By: Andy
//iuo_parent.il_sel

String 	ls_text
String 	ls_ObjName
String 	ls_field_id
String 	ls_last_field_temp[]
String 	ls_Type,ls_RetVal
long	 	ll_Row,ll_Count
long   	ll_X,ll_Y,ll_SelObjCnts

datawindowchild dwchild

ll_SelObjCnts = iuo_Parent.of_GetSelectedObjectCnts()
if ll_SelObjCnts = 1 and (iuo_Parent.ib_Resize_Width or iuo_Parent.ib_Resize_Height) then
	Return
end if

ls_ObjName = This.GetObjectAtPointer()
ls_ObjName = MidA(ls_ObjName, 1, PosA(ls_ObjName, "~t" ) -1)
if Lower(ls_ObjName) = Lower(is_RectFrameName) then ls_ObjName = ""		//Added by Scofield on 2009-04-10

IF iuo_parent.ib_Set_Tab_Order THEN
	IF LeftA( ls_ObjName, 4 ) = "tab_" THEN
		ls_RetVal = This.Modify(MidA(iuo_parent.is_last_tab_label_name,5,100) + ".TabSequence = '" + iuo_parent.uo_band.sle_tab.text + "'" )
		This.Modify(iuo_parent.is_last_tab_label_name + ".text = '" + iuo_parent.uo_band.sle_tab.text + "'")
		
		//Modify by gavin on 2009-03-04
		iuo_parent.Event ue_setmodify(MidA(iuo_parent.is_last_tab_label_name,5,100) + ".TabSequence = '" + iuo_parent.uo_band.sle_tab.text + "'" )
		
		iuo_parent.uo_band.sle_tab.Text = Describe(MidA(ls_ObjName,5,100 ) + ".TabSequence" )
		iuo_parent.is_last_tab_label_name = ls_ObjName
		
		iuo_parent.ib_clicked = True	// Add by Jack 05/17/2007	
		This.Event ue_calc_tab_position()
	END IF
	RETURN 
END IF

IF iuo_parent.is_AddObjectType <>'' THEN
	ib_Draging = FALSE
	ll_X = PointerX()
	ll_y = PointerY()
	iuo_parent.Post wf_AddObject(iuo_parent.is_AddObjectType,ll_X,ll_Y)	//Modify by gavin on 2009-02-26
	//$<add> 01.08.2008 by: Andy
	//$Reason:BugN122710
	iuo_parent.ib_multi_select = False
	iuo_parent.is_last_object[] = ls_last_field_temp[]
	iuo_parent.il_Ancor_X = 0
	iuo_parent.il_Ancor_Y = 0	
	iuo_parent.ii_Obj_Select_Cnt = 0
	RETURN
	//end of add 01.08.2008
END IF

IF iuo_parent.ii_Obj_Select_Cnt = 1 THEN
	IF ls_ObjName <> iuo_parent.is_last_object[1] THEN
		iuo_parent.ib_resize_height = False
		iuo_parent.ib_resize_width = False
	END IF
END IF

IF (ls_ObjName = "" AND iuo_parent.ii_Obj_Select_Cnt > 0) THEN
	iuo_parent.ib_multi_select = False
	iuo_parent.is_last_object[] = ls_last_field_temp[]
	iuo_parent.il_Ancor_X = 0
	iuo_parent.il_Ancor_Y = 0	
	iuo_parent.ii_Obj_Select_Cnt = 0
	RETURN 0
END IF

IF iuo_parent.ib_multi_select THEN
	iuo_parent.ii_Obj_Select_Cnt ++
ELSE
	iuo_parent.ii_Obj_Select_Cnt = 1
END IF

iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] = ls_ObjName

//BEGIN---Add by Evan 07/24/2008
ls_Type = This.Describe(iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".type")
choose case ls_Type
	case "text"
		if IsValid(w_intellicred_text_properties) then
			iuo_parent.dw_properties_text.Event ue_Retrieve(iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt])
		end if
	case else
end choose
//END---Add by Evan 07/24/2008

IF ls_Type = "line" THEN //Modify by Evan 07/24/2008
	iuo_parent.il_last_object_y[iuo_parent.ii_Obj_Select_Cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".y1") )
	iuo_parent.il_last_object_x[iuo_parent.ii_Obj_Select_Cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".x1") )
	//$<add> 01.08.2008 by: Andy
	iuo_parent.il_x2 = Long(This.Describe(iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".x2"))
	//end of add 01.08.2008
	iuo_parent.il_last_object_width[iuo_parent.ii_Obj_Select_Cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".width") )
	iuo_parent.il_last_object_height[iuo_parent.ii_Obj_Select_Cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".height"))	
Else
	iuo_parent.il_last_object_y[iuo_parent.ii_Obj_Select_Cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".y") )
	iuo_parent.il_last_object_x[iuo_parent.ii_Obj_Select_Cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".x") )
	iuo_parent.il_last_object_width[iuo_parent.ii_Obj_Select_Cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".width") )
	iuo_parent.il_last_object_height[iuo_parent.ii_Obj_Select_Cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".height"))
End If

IF RightA(iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt], 2) = "_t" THEN
	ls_field_id = Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".tag" )
ELSE
	ls_field_id = Describe( iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt] + ".id" )
END IF

IF ls_field_id="?" OR ls_field_id="!" OR ls_field_id="" THEN ls_field_id="0"

IF PosA(iuo_parent.is_last_object[iuo_parent.ii_Obj_Select_Cnt], "obj" ) = 0 THEN
	iuo_parent.dw_properties.SetFilter("data_view_fields_field_id = " + ls_field_id)
	iuo_parent.dw_properties.Filter()
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.06.2007 By: Jack
	//$<reason> Fix a defect.
	
	IF IsValid(w_intellicred_field_properties) THEN
		w_intellicred_field_properties.of_ShowColor() 								//Add by Evan 07/24/2008
		ll_Row = w_intellicred_field_properties.dw_properties.GetRow()			//Added by Scofield on 2007-09-11
		ll_Count = w_intellicred_field_properties.dw_properties.RowCount()	//Added by Scofield on 2007-09-11
		IF ll_Row > 0 AND ll_Row <= ll_Count THEN									//Added by Scofield on 2007-09-11
			IF w_intellicred_field_properties.dw_properties.GetItemString(ll_Row,"sys_fields_lookup_field" ) = "Y" THEN
				w_intellicred_field_properties.cb_DataFill.Enabled = true		//Added by Scofield on 2007-10-25
				w_intellicred_field_properties.dw_properties.GetChild("sys_fields_default_value", dwchild )
				dwchild.SetTransObject(SQLCA)
				dwchild.Retrieve(w_intellicred_field_properties.dw_properties.GetItemString(w_intellicred_field_properties.dw_properties.GetRow(), "sys_fields_lookup_code" ))
			ELSE
				w_intellicred_field_properties.cb_DataFill.Enabled = false		//Added by Scofield on 2007-10-25
			END IF
		END if
	END If
	//---------------------------- APPEON END ----------------------------
END IF

ls_text = This.Describe(ls_ObjName + ".text" )

IF ls_text <> "?" AND ls_text <> "!" THEN
	if LeftA(ls_text,1) = '"' then ls_text = MidA(ls_text,2)
	if RightA(ls_text,1) = '"' then ls_text = LeftA(ls_text,LenA(ls_text) - 1)

	iuo_parent.uo_design.dw_1.SetText( ls_text )
END IF

end event

on u_cst_dw_band.create
call super::create
end on

on u_cst_dw_band.destroy
call super::destroy
end on

event lbuttondown;call super::lbuttondown;//====================================================================
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

long		ll_Pos,ll_SelObjCnts
String	ls_ObjName
Boolean	lb_Selected

if iuo_parent.ib_Set_Tab_Order then Return
if iuo_parent.is_AddObjectType <> '' then Return

iuo_Parent.ib_Mouse_Down = true

ll_SelObjCnts = iuo_Parent.of_GetSelectedObjectCnts()
if ll_SelObjCnts = 1 and (iuo_Parent.ib_Resize_Width or iuo_Parent.ib_Resize_Height) then
	ls_ObjName = iuo_Parent.of_GetLastSelectedObject()	
	il_Left_Margin = XPos - long(This.Describe(ls_ObjName + ".X")) - long(This.Describe(ls_ObjName + ".Width"))
	il_Down_Margin = YPos - long(This.Describe(ls_ObjName + ".Y")) - long(This.Describe(ls_ObjName + ".Height"))
	Return
end if

ls_ObjName = This.GetObjectatPointer()
ls_ObjName = LeftA(ls_ObjName,PosA(ls_ObjName,'~t') - 1)
if Lower(ls_ObjName) = Lower(is_RectFrameName) then ls_ObjName = ""

if Not IsNull(ls_ObjName) and ls_ObjName <> "" Then
	lb_Selected = of_IsSelected(ls_ObjName,ll_Pos)
end if

if KeyDown(KeyControl!) then
	iuo_parent.ib_Control_Down = True
	iuo_parent.ib_Multi_Select = True
	
	if ls_ObjName = "" then
		iuo_parent.uo_band.Event lbuttondown(Flags,This.X + XPos,This.Y + YPos)
	else
		of_AddOrDelSingleSelect(ls_ObjName,Not lb_Selected)
	end if
else
	iuo_parent.ib_Control_Down = False
	iuo_parent.ib_Multi_Select = False
	
	if Not lb_Selected then
		iuo_parent.of_UnSelectAllObject()
		if ls_ObjName = "" then
			iuo_parent.uo_band.Event lbuttondown(Flags,This.X + XPos,This.Y + YPos)
		else
			if This.Describe(ls_ObjName + ".type") = 'line' Then
				il_LineOrgX = XPos
				il_LineOrgY = YPos
			end if
			of_AddOrDelSingleSelect(ls_ObjName,true)
		end if
	end if
end if

iuo_parent.il_Ancor_X = This.X + XPos
iuo_parent.il_Ancor_Y = This.Y + YPos

ls_ObjName = iuo_Parent.of_GetLastSelectedObject()
if Not IsNull(ls_ObjName) and Trim(ls_ObjName) <> "" then
	is_CurObj = ls_ObjName
end if

iuo_Parent.of_Refresh_Object_Inforamtion()

end event

event lbuttonup;call super::lbuttonup;//====================================================================
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
// Author:	Scofield		Date: 2009-04-08
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_SelObjCnts
String	ls_ObjName

if iuo_Parent.ib_Set_Tab_Order then Return

ll_SelObjCnts = iuo_Parent.of_GetSelectedObjectCnts()
if ll_SelObjCnts >= 1 then
	ls_ObjName = iuo_Parent.of_GetLastSelectedObject()
	is_CurObj = ls_ObjName
	iuo_Parent.is_CurSelectObj = ls_ObjName
end if

iuo_Parent.of_Refresh_Object_Inforamtion()

iuo_Parent.ib_Mouse_Down = False
iuo_Parent.ib_Resize_Height = False
iuo_Parent.ib_Resize_Width = False

end event

event pfc_selectall;call super::pfc_selectall;iuo_parent.of_SelectAll(true)

Return 1

end event

event pfc_undo;call super::pfc_undo;//iuo_Parent.of_Undo()

Return 1

end event

