$PBExportHeader$w_contract_mul_field_properties.srw
forward
global type w_contract_mul_field_properties from w_popup
end type
type dw_properties from u_dw within w_contract_mul_field_properties
end type
type cb_ok from u_cb within w_contract_mul_field_properties
end type
type cb_cancel from u_cb within w_contract_mul_field_properties
end type
end forward

global type w_contract_mul_field_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1271
integer height = 1548
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
global w_contract_mul_field_properties w_contract_mul_field_properties

type variables
//modify by gavin on 2009/3/5
pfc_cst_u_contract_data_design inv_data_design
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

on w_contract_mul_field_properties.create
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

on w_contract_mul_field_properties.destroy
call super::destroy
destroy(this.dw_properties)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event pfc_postopen;call super::pfc_postopen;of_ShowColor() //Add by Evan 07/24/2008
end event

event open;call super::open;long	ll_Row

str_FieldProperty	lstr_Property

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

if Not IsNull(lstr_Property.label_font_face) then //added by gavins 20121214
	dw_properties.SetItem(ll_Row,"label_font_face",lstr_Property.label_font_face)
end if

if Not IsNull(lstr_Property.label_font_height) then
	dw_properties.SetItem(ll_Row,"label_font_height",long( lstr_Property.label_font_height) )
end if

if Not IsNull(lstr_Property.field_font_face) then
	dw_properties.SetItem(ll_Row,"fields_font_face",lstr_Property.field_font_face)
end if

if Not IsNull(lstr_Property.field_font_height) then
	dw_properties.SetItem(ll_Row,"fields_font_height",long( lstr_Property.field_font_height) )
end if

gf_WinCenter(This)

end event

type dw_properties from u_dw within w_contract_mul_field_properties
integer x = 14
integer y = 28
integer width = 1230
integer height = 1312
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_contract_mul_field_properties"
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

/***************************************/ //added by gavins 20120308 grid
If dwo.Name = 'data_view_fields_visible' Then
	If Data = 'N'  and inv_data_design.il_dw_style = 1  Then
		If MessageBox( 'Prompt', 'Modification of the visible property: ~r~n1. “Invisible”, the column will be hidden and moved to the end of all columns. ~r~n2. When the property is changed from “invisible” to “visible”, the column will be displayed at the end of all visible columns. ~r~nAre you sure you want to modify it? ', &
						question!, yesno!, 1 )  = 1 Then
		Else
			SetItem( row, 'data_view_fields_visible', 'Y' )
			SetItemStatus( row, 'data_view_fields_visible', primary!, notmodified! )
			Return 2
		End If	
	End If
End If
/***************************************/

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
String ls_fonts[]
datawindowchild ldwc_fonts, ldwc_fonts2
int i,j
n_cst_appeondll lnv_appeon_dll

lnv_appeon_dll.of_getfonts(ls_fonts)

if this.getchild("label_font_face",ldwc_fonts) = 1 then
	
	For i = 1 To UpperBound(ls_fonts[])
		If Trim(ls_fonts[i]) = '' Then Continue
		If i > 1 Then
			If ls_fonts[i - 1] = ls_fonts[i] Then Continue
		End If
		j = ldwc_fonts.InsertRow(0)
		ldwc_fonts.SetItem(j,1,ls_fonts[i])
	Next
	
	If ldwc_fonts.RowCount() = 0 Then
		ldwc_fonts.InsertRow(1)
		ldwc_fonts.SetItem(1,1,'Segoe UI')
	End If
	
	ldwc_fonts.SetSort('fonts_face A')
	ldwc_fonts.Sort()

end if

If  this.getchild("fields_font_face",ldwc_fonts2 ) = 1 Then
	For i = 1 To UpperBound(ls_fonts[])
		If Trim(ls_fonts[i]) = '' Then Continue
		If i > 1 Then
			If ls_fonts[i - 1] = ls_fonts[i] Then Continue
		End If
		j = ldwc_fonts2.InsertRow(0)
		ldwc_fonts2.SetItem(j,1,ls_fonts[i])
	Next
	
	If ldwc_fonts2.RowCount() = 0 Then
		ldwc_fonts2.InsertRow(1)
		ldwc_fonts2.SetItem(1,1,'Segoe UI')
	End If
	
	ldwc_fonts2.SetSort('fonts_face A')
	ldwc_fonts2.Sort()

End If
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

type cb_ok from u_cb within w_contract_mul_field_properties
boolean visible = false
integer x = 503
integer y = 1092
integer width = 343
integer taborder = 30
boolean bringtotop = true
string text = "&OK"
end type

event clicked;Close(Parent)

end event

type cb_cancel from u_cb within w_contract_mul_field_properties
integer x = 896
integer y = 1360
integer width = 343
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean default = true
end type

event clicked;Close(Parent)
end event

