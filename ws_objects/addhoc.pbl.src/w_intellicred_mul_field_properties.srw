$PBExportHeader$w_intellicred_mul_field_properties.srw
forward
global type w_intellicred_mul_field_properties from w_popup
end type
type dw_properties from u_dw within w_intellicred_mul_field_properties
end type
type cb_ok from u_cb within w_intellicred_mul_field_properties
end type
type cb_cancel from u_cb within w_intellicred_mul_field_properties
end type
end forward

global type w_intellicred_mul_field_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1280
integer height = 1296
string title = "Group Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
dw_properties dw_properties
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_intellicred_mul_field_properties w_intellicred_mul_field_properties

type variables
//modify by gavin on 2009/3/5
u_cst_dw_design inv_data_design
uo_contract_design_menu  inv_menu
pfc_cst_u_band_painter inv_band
datawindow  idw_properties
end variables

forward prototypes
public function integer of_showcolor ()
public function integer of_parsecolor (ref long al_color)
end prototypes

public function integer of_showcolor ();long ll_Row

dw_properties.AcceptText()
ll_Row = dw_properties.GetRow()
if ll_Row <= 0 then Return -1

dw_properties.object.t_fields_label_textcolor.background.color = dw_properties.object.fields_label_textcolor[ll_Row]
dw_properties.object.t_fields_label_textbkcolor.background.color = dw_properties.object.fields_label_textbkcolor[ll_Row]

//BEGIN---Modify by Scofield on 2009-09-01
dw_properties.object.t_fields_textcolor.background.color = dw_properties.object.fields_textcolor[ll_Row]
dw_properties.object.t_fields_textbkcolor.background.color = dw_properties.object.fields_textbkcolor[ll_Row]
//END---Modify by Scofield on 2009-09-01
Return 1

end function

public function integer of_parsecolor (ref long al_color);if IsNull(al_Color) or al_Color = 33554432 then
	al_Color = RGB(0,0,0)
elseif al_Color = 67108864 then
	al_Color = RGB(212,208,200)
end if

Return 1
end function

on w_intellicred_mul_field_properties.create
int iCurrent
call super::create
this.dw_properties=create dw_properties
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_properties
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_intellicred_mul_field_properties.destroy
call super::destroy
destroy(this.dw_properties)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event pfc_postopen;call super::pfc_postopen;of_ShowColor() //Add by Evan 07/24/2008
end event

event open;call super::open;long	ll_Row
//---------Begin Modified by (Appeon)Toney 06.11.2013 for V141 ISG-CLX--------
//$Reason:
  /*
    str_FieldProperty	lstr_Property  
  */
  str_FieldProperty_rpt	lstr_Property 
//---------End Modfiied ------------------------------------------------------------------

lstr_Property = Message.PowerObjectParm

inv_data_design = lstr_Property.data_design

ll_Row = dw_properties.InsertRow(0)

if Not IsNull(lstr_Property.Field_Visible) then
	if lstr_Property.Field_Visible = '1' then
		dw_properties.SetItem(ll_Row,"data_view_fields_visible",'Y')
	else
		dw_properties.SetItem(ll_Row,"data_view_fields_visible",'N')
	end if
end if

if Not IsNull(lstr_Property.Label_Color) then
	dw_properties.SetItem(ll_Row,"fields_label_textcolor",long(lstr_Property.Label_Color))
end if

if Not IsNull(lstr_Property.Label_BkColor) then
	dw_properties.SetItem(ll_Row,"fields_label_textbkcolor",long(lstr_Property.Label_BkColor))
end if

if Not IsNull(lstr_Property.Label_Alignment) then
	dw_properties.SetItem(ll_Row,"data_view_fields_label_justification",long(lstr_Property.Label_Alignment))
end if

if Not IsNull(lstr_Property.Label_Border) then
	dw_properties.SetItem(ll_Row,"fields_label_border",lstr_Property.Label_Border)
end if

if Not IsNull(lstr_Property.Field_Required) then
	if Upper(lstr_Property.Field_Required) = Upper('Yes') then
		dw_properties.SetItem(ll_Row,"data_view_fields_required",'Y')
	else
		dw_properties.SetItem(ll_Row,"data_view_fields_required",'N')
	end if
end if

if Not IsNull(lstr_Property.Field_Mask) then
	dw_properties.SetItem(ll_Row,"sys_fields_field_mask",lstr_Property.Field_Mask)
end if

if Not IsNull(lstr_Property.Field_Alignment) then
	dw_properties.SetItem(ll_Row,"data_view_fields_justification",long(lstr_Property.Field_Alignment))
end if

if Not IsNull(lstr_Property.Field_display_only) then
	if Upper(lstr_Property.Field_display_only) = Upper('Yes') then
		dw_properties.SetItem(ll_Row,"data_view_fields_display_only",'Y')
	else
		dw_properties.SetItem(ll_Row,"data_view_fields_display_only",'N')
	end if
end if

if Not IsNull(lstr_Property.Field_Color) then
	dw_properties.SetItem(ll_Row,"fields_textcolor",long(lstr_Property.Field_Color))
end if

if Not IsNull(lstr_Property.Field_BKColor) then
	dw_properties.SetItem(ll_Row,"fields_textbkcolor",long(lstr_Property.Field_BKColor))
end if

if Not IsNull(lstr_Property.Field_Border) then
	dw_properties.SetItem(ll_Row,"fields_border",lstr_Property.Field_Border)
end if

if Not IsNull(lstr_Property.Field_Word_Wrap) then
	if Upper(lstr_Property.Field_Word_Wrap) = Upper('Yes') then
		dw_properties.SetItem(ll_Row,"fields_vscrollbar",'Y')
	else
		dw_properties.SetItem(ll_Row,"fields_vscrollbar",'N')
	end if
end if

gf_WinCenter(This)

end event

type dw_properties from u_dw within w_intellicred_mul_field_properties
integer x = 14
integer y = 28
integer width = 1234
integer height = 1040
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_intellicred_mul_field_properties"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;String 	ls_lookup_field,ls_FieldName
long		ll_ViewId,ll_ScreenId,ll_Count
Integer	li_Rtn

This.AcceptText()

choose case dwo.name
	case "fields_label_textcolor", "fields_label_textbkcolor", "fields_textcolor", "fields_textbkcolor"
		of_ShowColor()
end choose

IF This.GetColumnName( ) = "data_view_fields_visible"  Then
	If This.GetItemString(This.GetRow(),'data_view_fields_visible') = 'N' Then
		If This.GetItemString(This.GetRow(),'data_view_fields_required') = 'Y' Then
			MessageBox('Prompt','System will automatically set the Required property to False when the Visible property is set to False. This will cause saving failure if the field is not allowed to be null in the database.')
			This.SetItem(This.GetRow(),'data_view_fields_required','N')
			inv_data_design.Post of_Modify_Column_Property('data_view_fields_required','N')
		End If
	End If
End If

IF This.GetColumnName( ) = "data_view_fields_required" Then
	If This.getitemstring(This.getrow(),'data_view_fields_required') = 'N' Then
		MessageBox('Prompt','When the Required property is set to False, saving error may occur if the field is not allowed to be null in the database.')
	End If
End If

inv_data_design.of_Modify_Column_Property(dwo.Name,Data)

end event

event constructor;call super::constructor;This.of_SetUpdateable(False)

end event

event itemfocuschanged;call super::itemfocuschanged;IF This.GetColumnName() = "sys_fields_default_value" THEN
	String ls_field_name
	ls_field_name = Upper( This.GetItemString( row, "sys_fields_lookup_field_name" ) )
	DataWindowChild dwchild	
	This.GetChild( "sys_fields_default_value" , dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ) )	
END IF
end event

event buttonclicked;call super::buttonclicked;long ll_Color
long gl_custom_colors[]

This.AcceptText()
if Row <=0 then Return

choose case dwo.name
	case "b_text_color"
		ll_Color = This.object.fields_label_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			This.object.fields_label_textcolor[Row] = ll_Color
			This.SetColumn("fields_label_textcolor")
			This.Event ItemChanged(Row, This.object.fields_label_textcolor, String(ll_Color))
		end if
	case "b_text_color_def"
		This.object.fields_label_textcolor[Row] = 33554432
		This.SetColumn("fields_label_textcolor")
		This.Event ItemChanged(Row, This.object.fields_label_textcolor, "33554432")
		
	case "b_text_bk_color"
		ll_Color = This.object.fields_label_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			This.object.fields_label_textbkcolor[Row] = ll_Color
			This.SetColumn("fields_label_textbkcolor")
			This.Event ItemChanged(Row, This.object.fields_label_textbkcolor, String(ll_Color))
		end if
	case "b_text_bk_color_def"
		This.object.fields_label_textbkcolor[Row] = 67108864
		This.SetColumn("fields_label_textbkcolor")
		This.Event ItemChanged(Row, This.object.fields_label_textbkcolor, "67108864")
	//BEGIN---Modify by Scofield on 2009-09-01
	case "b_fields_textcolor"
		ll_Color = this.object.fields_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textcolor[Row] = ll_Color
			this.SetColumn("fields_textcolor")
			this.Event ItemChanged(Row, this.object.fields_textcolor, String(ll_Color))
		end if
	case "b_fields_textcolor_def"
		this.object.fields_textcolor[Row] = 0
		this.SetColumn("fields_textcolor")
		this.Event ItemChanged(Row, this.object.fields_textcolor, "0")
		
	case "b_fields_textbkcolor"
		ll_Color = this.object.fields_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_textbkcolor, String(ll_Color))
		end if
	case "b_fields_textbkcolor_def"
		this.object.fields_textbkcolor[Row] = 16777215
		this.SetColumn("fields_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_textbkcolor, "16777215")
	//END---Modify by Scofield on 2009-09-01
end choose

end event

type cb_ok from u_cb within w_intellicred_mul_field_properties
boolean visible = false
integer x = 535
integer y = 1092
integer width = 343
integer taborder = 30
boolean bringtotop = true
string text = "&OK"
end type

event clicked;Close(Parent)

end event

type cb_cancel from u_cb within w_intellicred_mul_field_properties
integer x = 891
integer y = 1092
integer width = 343
integer taborder = 20
boolean bringtotop = true
string text = "&Close"
boolean default = true
end type

event clicked;Close(Parent)
end event

