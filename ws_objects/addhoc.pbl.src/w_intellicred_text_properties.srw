$PBExportHeader$w_intellicred_text_properties.srw
forward
global type w_intellicred_text_properties from w_popup
end type
type dw_properties_text from u_dw within w_intellicred_text_properties
end type
type cb_ok from u_cb within w_intellicred_text_properties
end type
type cb_cancel from u_cb within w_intellicred_text_properties
end type
end forward

global type w_intellicred_text_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1134
integer height = 1440
string title = "Text Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
dw_properties_text dw_properties_text
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_intellicred_text_properties w_intellicred_text_properties

type variables
private:
u_cst_dw_design inv_data_design
end variables

forward prototypes
public function integer of_showcolor ()
public function integer of_parsecolor (ref long al_color)
public function string of_objectnameverify (string as_name)
end prototypes

public function integer of_showcolor ();long ll_Row

dw_properties_text.AcceptText()
ll_Row = dw_properties_text.GetRow()
if ll_Row <= 0 then Return -1

dw_properties_text.object.t_text_color.background.color = dw_properties_text.object.text_color[ll_Row]
dw_properties_text.object.t_background_color.background.color = dw_properties_text.object.background_color[ll_Row]

Return 1
end function

public function integer of_parsecolor (ref long al_color);if IsNull(al_Color) or al_Color = 33554432 then
	al_Color = RGB(0,0,0)
elseif al_Color = 67108864 then
	al_Color = RGB(212,208,200)
end if

Return 1
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

as_Name = Lower(as_Name)

ERROR_NOTVALID   = "'" + as_name + "' is not a valid name."

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

on w_intellicred_text_properties.create
int iCurrent
call super::create
this.dw_properties_text=create dw_properties_text
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_properties_text
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_intellicred_text_properties.destroy
call super::destroy
destroy(this.dw_properties_text)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event closequery;//override
end event

event open;call super::open;//Modified by gavin on 2009-03-05
inv_data_design = message.powerobjectparm
end event

event key;call super::key;if Key = KeyEscape! then Close(This)

end event

type dw_properties_text from u_dw within w_intellicred_text_properties
integer x = 14
integer y = 12
integer width = 1102
integer height = 1176
integer taborder = 10
string dataobject = "d_contract_text_properties"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;long ll_Color
long gl_custom_colors[]

this.AcceptText()
if Row <= 0 then Return

choose case dwo.name
	case "b_text_color"
		ll_Color = this.object.text_color[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.text_color[Row] = ll_Color
			this.SetColumn("text_color")
			this.Event ItemChanged(Row, this.object.text_color, String(ll_Color))
		end if
	case "b_text_color_def"
		this.object.text_color[Row] = 33554432
		this.SetColumn("text_color")
		this.Event ItemChanged(Row, this.object.text_color, "33554432")

	case "b_background_color"
		ll_Color = this.object.background_color[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.background_color[Row] = ll_Color
			this.SetColumn("background_color")
			this.Event ItemChanged(Row, this.object.background_color, String(ll_Color))
		end if
	case "b_background_color_def"
		this.object.background_color[Row] = 67108864
		this.SetColumn("background_color")
		this.Event ItemChanged(Row, this.object.background_color, "67108864")
end choose
end event

event itemchanged;call super::itemchanged;String	ls_Error

choose case dwo.name 
	case "text_color", "background_color"
		of_ShowColor()
	Case "text"
		inv_data_design.ib_HasNewModify = true
end choose

//ls_Error = of_ObjectNameVerify(data)
//if ls_Error <> "" then
//	MessageBox(gnv_app.iapp_object.DisplayName,ls_Error)
//	Return 1
//end if

//Modified by gavin on 2009-03-05
inv_data_design.Post of_set_dw_properties(this.GetColumnName(), 3)

end event

event losefocus;call super::losefocus;this.AcceptText()
end event

type cb_ok from u_cb within w_intellicred_text_properties
boolean visible = false
integer x = 411
integer y = 1228
integer width = 343
integer taborder = 20
boolean bringtotop = true
string text = "&OK"
end type

event clicked;Close( Parent )

end event

type cb_cancel from u_cb within w_intellicred_text_properties
integer x = 768
integer y = 1228
integer width = 343
integer taborder = 30
boolean bringtotop = true
string text = "&Close"
boolean default = true
end type

event clicked;//BEGIN---Modify by Scofield on 2009-09-29
String 	ls_ObjName,ls_Visible
long		ll_Row

dw_Properties_Text.AcceptText()

ll_Row = dw_Properties_Text.GetRow()
ls_ObjName = dw_Properties_Text.GetItemString(ll_Row,"name")

if inv_data_design.is_open_style = "screen" and inv_data_design.ib_HasNewModify and inv_data_design.ii_Screen_id >= 3 and inv_data_design.ii_Screen_id <= 10 then
	inv_data_design.Post of_AutoUpdateSearchScreen(ls_ObjName)
end if
//END---Modify by Scofield on 2009-09-29

Close(Parent)

end event

