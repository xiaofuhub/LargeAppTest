$PBExportHeader$w_contract_text_properties.srw
forward
global type w_contract_text_properties from w_popup
end type
type tab_1 from tab within w_contract_text_properties
end type
type tabpage_general from userobject within tab_1
end type
type dw_1 from u_dw within tabpage_general
end type
type tabpage_general from userobject within tab_1
dw_1 dw_1
end type
type tabpage_font from userobject within tab_1
end type
type dw_2 from u_dw within tabpage_font
end type
type tabpage_font from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within w_contract_text_properties
tabpage_general tabpage_general
tabpage_font tabpage_font
end type
type dw_properties_text from u_dw within w_contract_text_properties
end type
type cb_ok from u_cb within w_contract_text_properties
end type
type cb_cancel from u_cb within w_contract_text_properties
end type
end forward

global type w_contract_text_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1888
integer height = 1912
string title = "Text Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
tab_1 tab_1
dw_properties_text dw_properties_text
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_contract_text_properties w_contract_text_properties

type variables
private:
pfc_cst_u_contract_data_design inv_data_design
String			is_Name
pfc_cst_u_band   idw_band
end variables

forward prototypes
public function integer of_showcolor ()
public function integer of_parsecolor (ref long al_color)
public function string of_objectnameverify (string as_name)
public function integer wf_setvisibleexpress ()
public subroutine wf_resetdata ()
public function integer of_showcolor (string as_object, string as_color)
end prototypes

public function integer of_showcolor ();long ll_Row

dw_properties_text.AcceptText()
ll_Row = tab_1.tabpage_general.dw_1.GetRow()
tab_1.tabpage_general.dw_1.AcceptText( )
if ll_Row <= 0 then Return -1

//dw_properties_text.object.t_text_color.background.color = dw_properties_text.object.text_color[ll_Row]
//dw_properties_text.object.t_background_color.background.color = dw_properties_text.object.background_color[ll_Row]
//modified by gavins 20120503

tab_1.tabpage_general.dw_1.object.t_text_color.background.color = tab_1.tabpage_general.dw_1.object.text_color[ll_Row]
tab_1.tabpage_general.dw_1.object.t_background_color.background.color = tab_1.tabpage_general.dw_1.object.background_color[ll_Row]


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
// Author:	Scofield		Date: 2009-06-22
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_SingleLetter
long		ll_Cycle,ll_Length

STRING ERROR_NOTVALID

as_Name = Lower(as_Name)

ERROR_NOTVALID   = "'" + as_name + "' is not a valid name."

ls_SingleLetter = Left(as_Name,1)
if Not (ls_SingleLetter >= 'a' and ls_SingleLetter <= 'z') then
	Return ERROR_NOTVALID
end if

ll_Length = Len(as_Name)
for ll_Cycle = 2 to ll_Length
	ls_SingleLetter = Mid(as_Name,ll_Cycle,1)
	if Not (ls_SingleLetter >= 'a' and ls_SingleLetter <= 'z' or ls_SingleLetter >= '0' and ls_SingleLetter <= '9' or ls_SingleLetter = '_') then
		Return ERROR_NOTVALID
	end if
next

Return ""

end function

public function integer wf_setvisibleexpress ();String ls_Visible, ls_Object, ls_Type, ls_color

/*******************************************************/
If  tab_1.tabpage_general.dw_1.GetRow( ) > 0  Then
	ls_Visible =  tab_1.tabpage_general.dw_1.GetItemString(  tab_1.tabpage_general.dw_1.GetRow( ), "visibleexpress")
	
	ls_Object = tab_1.tabpage_general.dw_1.GetItemString(  tab_1.tabpage_general.dw_1.GetRow( ), "name")
	
	ls_Type = idw_band.Describe( Left( ls_Object, Len( ls_Object ) - 2  ) + ".type" )
	ls_Type = idw_band.Describe( Left( ls_Object, Len( ls_Object ) - 2  ) + ".type" )
	If ls_Type = 'column' Then
		tab_1.tabpage_general.dw_1.Modify( "visible.protect = 1" )
		tab_1.tabpage_general.dw_1.Modify( "visible.color = 8421504" )
		tab_1.tabpage_general.dw_1.Modify( "b_visible.enabled = false" ) 
		tab_1.tabpage_general.dw_1.Modify( "t_tips.Visible=1" )
	Else
		tab_1.tabpage_general.dw_1.Modify( "b_visible.enabled = true" ) 
		If Not ( (ls_Visible) = '0' Or ( ls_Visible ) = '1' Or ls_Visible = '-1'  Or ls_Visible = '?' Or ls_Visible = '!'  or ls_Visible = '' or isnull( ls_visible ) ) Then
			tab_1.tabpage_general.dw_1.Modify( "visible.protect = 1" )
			tab_1.tabpage_general.dw_1.Modify( "visible.color = 8421504" )
			 tab_1.tabpage_general.dw_1.Modify( "b_visible.color = '16711935'" )
		Else
			tab_1.tabpage_general.dw_1.Modify( "visible.protect = 0" )
			tab_1.tabpage_general.dw_1.Modify( "visible.color = 0" )
			 tab_1.tabpage_general.dw_1.Modify( "b_visible.color = '0'" )
		End If
		tab_1.tabpage_general.dw_1.Modify( "t_tips.Visible=0" )
	End If
	
	ls_Color =  tab_1.tabpage_general.dw_1.GetItemString(tab_1.tabpage_general.dw_1.GetRow( ), "backgroundcolorexpress")

	If Not(trim( ls_color)= '' or isnull( ls_color ) ) Then
		tab_1.tabpage_general.dw_1.Modify( "b_background_colorexpress.color = '16711935'" )	
	Else
		tab_1.tabpage_general.dw_1.Modify( "b_background_colorexpress.color = '0'" )	
	End If
	ls_Color = tab_1.tabpage_general.dw_1.GetItemString(tab_1.tabpage_general.dw_1.GetRow( ), "fontcolorexpress")
	
	If Not(trim( ls_color)= '' or isnull( ls_color ) ) Then
		tab_1.tabpage_general.dw_1.Modify( "b_font_colorexpress.color = '16711935'" )	
	Else
		tab_1.tabpage_general.dw_1.Modify( "b_font_colorexpress.color = '0'" )	
	End If
		
End If
/*******************************************************/

Return 1
end function

public subroutine wf_resetdata ();//

tab_1.tabpage_general.dw_1.Reset( )
end subroutine

public function integer of_showcolor (string as_object, string as_color);
choose case as_object
	case 'text_color'
		tab_1.tabpage_general.dw_1.object.t_text_color.background.color =as_color
	case 'background_color'
		tab_1.tabpage_general.dw_1.object.t_background_color.background.color = as_color
end choose

Return 1
end function

on w_contract_text_properties.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_properties_text=create dw_properties_text
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_properties_text
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancel
end on

on w_contract_text_properties.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_properties_text)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event closequery;//override
end event

event open;call super::open;//Modified by gavin on 2009-03-05
String					ls_Visible, ls_Object, ls_Type
str_set_properties lstr_item

lstr_item = message.powerobjectparm


inv_data_design = lstr_item.lst_data_design


idw_band = lstr_item.lst_band

/*******************************************************/
Post wf_setvisibleexpress( )
/*******************************************************/


tab_1.tabpage_general.text = "Text Display"

If inv_data_design.is_open_style <> 'report' Then
	tab_1.tabpage_general.dw_1.Modify( "slideup.visible=0 slideup_t.visible=0" )
	
End If
end event

event key;call super::key;if Key = KeyEscape! then Close(This)

end event

type tab_1 from tab within w_contract_text_properties
integer x = 32
integer y = 16
integer width = 1819
integer height = 1692
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
alignment alignment = center!
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_font tabpage_font
end type

on tab_1.create
this.tabpage_general=create tabpage_general
this.tabpage_font=create tabpage_font
this.Control[]={this.tabpage_general,&
this.tabpage_font}
end on

on tab_1.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_font)
end on

event selectionchanged;If tab_1.tabpage_general.dw_1.GetRow( ) > 0 Then
	is_Name =  tab_1.tabpage_general.dw_1.getItemString(  tab_1.tabpage_general.dw_1.getrow( ), 'name' )
	
End If
	
end event

type tabpage_general from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1783
integer height = 1576
long backcolor = 33551856
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
long picturemaskcolor = 536870912
string powertiptext = "General"
dw_1 dw_1
end type

on tabpage_general.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_general.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within tabpage_general
integer x = 14
integer y = 16
integer width = 1760
integer height = 1556
integer taborder = 10
string dataobject = "d_contract_text_properties_general"
boolean vscrollbar = false
boolean border = false
end type

event buttonclicked;call super::buttonclicked;long 			ll_Color
String			ls_visible, ls_color, ls_default, ls_expression, ls_column
str_pass		lstr_pass


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
			this.SetItem(row,'fontcolorexpress',"")	
			this.Modify( "text_color.protect = 0" )
			This.Modify( "b_font_colorexpress.color = '0'" )
		end if
	case "b_text_color_def"
		this.object.text_color[Row] = 33554432
		this.SetColumn("text_color")
		this.Event ItemChanged(Row, this.object.text_color, "33554432")
		this.SetItem(row,'fontcolorexpress',"")	
		this.Modify( "text_color.protect = 0" )
		This.Modify( "b_font_colorexpress.color = '0'" )
	case "b_background_color"
		ll_Color = this.object.background_color[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.background_color[Row] = ll_Color
			this.SetColumn("background_color")
			this.Event ItemChanged(Row, this.object.background_color, String(ll_Color))
			this.SetItem(row,'backgroundcolorexpress',"")	
			this.Modify( "background_color.protect = 0" )	
			This.Modify( "b_background_colorexpress.color = '0'" )	
		end if
	case "b_background_color_def"
		this.object.background_color[Row] = 67108864
		this.SetColumn("background_color")
		this.Event ItemChanged(Row, this.object.background_color, "67108864")
		this.SetItem(row,'backgroundcolorexpress',"")	
		this.Modify( "background_color.protect = 0" )			
		This.Modify( "b_background_colorexpress.color = '0'" )	
	case "b_visible"
		ls_visible =  this.GetItemString(row,'visibleexpress')
		If Pos( ls_visible, '~t' ) > 0 Then ls_visible = Mid( ls_visible, pos( ls_visible, '~t' ) + 1 ) 
		If right( ls_visible , 1 ) = '"' or right( ls_visible, 1 ) = "'" Then ls_visible = left( ls_visible, len( ls_visible ) - 1 )
		lstr_pass.s_long[1] = 5	
		lstr_pass.s_string          = ls_visible
		lstr_pass.as_search_type = "visible"
		lstr_pass.s_string_array[1] = this.GetItemString( row,'name')
		lstr_pass.s_string_array[2] = "text"
		lstr_pass.s_u_dw   = idw_band
		OpenWithParm(w_export_expression,lstr_pass)
		lstr_pass = Message.PowerObjectParm
		if isvalid(lstr_pass) then
			
			if  trim(lstr_pass.s_string) <> "" then
				this.SetItem(row,"visibleexpress",lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.visibleexpress, lstr_pass.s_string)
				this.Modify( "visible.protect = 1" )
				this.Modify( "visible.color = 8421504" )
				This.Modify( "b_visible.color = '16711935'" )
			Else
				this.SetItem(row,"visibleexpress",lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.visible, GetItemString( row, 'visible' ) )
				this.Modify( "visible.protect = 0" )
				this.Modify( "visible.color = 0" )
				This.Modify( "b_visible.color = '0'" )
			end if
		end if	
	case 'b_background_colorexpress' 
		
		ls_Column = 'backgroundcolorexpress'
		
		ls_color =  this.GetItemString(row,ls_Column )
		If Pos( ls_color, '~t' ) > 0 Then ls_color = Mid( ls_color, pos( ls_color, '~t' ) + 1 ) 
		If right( ls_color , 1 ) = '"' or right( ls_color, 1 ) = "'" Then ls_color = left( ls_color, len( ls_color ) - 1 )
		lstr_pass.s_long[1] = 5	
		lstr_pass.s_string          = ls_color
		lstr_pass.as_search_type = "background.color"
		lstr_pass.s_string_array[1] = this.GetItemString( row,'name')
		lstr_pass.s_string_array[2] = "text"
		ls_Default =  String( this.GetItemNumber( row, 'background_color' ))
		If IsNull( ls_Default ) Or Trim( ls_Default ) = '' Then ls_Default = '0'
		lstr_pass.s_string_array[3] =ls_Default
		lstr_pass.s_u_dw            = idw_band
		OpenWithParm(w_export_expression,lstr_pass)
		lstr_pass = Message.PowerObjectParm
		if isvalid(lstr_pass) then
			if  trim(lstr_pass.s_string) <> "" then
				this.SetItem(row,ls_Column,lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.backgroundcolorexpress, lstr_pass.s_string)
				this.Modify( "background_color.protect = 1" )
				This.Modify( "b_background_colorexpress.color = '16711935'" )	
				SetColumn( 'backgroundcolorexpress' )
			Else
				this.SetItem(row,ls_Column,"")
				this.Event ItemChanged( Row, this.object.background_color,  String(GetItemNumber( row, 'background_color' ) ) )
				this.Modify( "background_color.protect = 0" )
				This.Modify( "b_background_colorexpress.color = '0'" )	
				SetColumn( 'background_color' )
			end if
		end if
	case 'b_font_colorexpress' 
		
		ls_Column = 'fontcolorexpress'
		
		ls_color =  this.GetItemString(row,ls_Column )
		If Pos( ls_color, '~t' ) > 0 Then ls_color = Mid( ls_color, pos( ls_color, '~t' ) + 1 ) 
		If right( ls_color , 1 ) = '"' or right( ls_color, 1 ) = "'" Then ls_color = left( ls_color, len( ls_color ) - 1 )
		lstr_pass.s_long[1] = 5	
		lstr_pass.s_string          = ls_color
		lstr_pass.as_search_type = "color"
		lstr_pass.s_string_array[1] = this.GetItemString( row,'name')
		lstr_pass.s_string_array[2] = "text"
		ls_Default =  string( this.GetItemnumber( row, 'text_color' ) )
		If IsNull( ls_Default ) Or Trim( ls_Default ) = '' Then ls_Default = '0'
		lstr_pass.s_string_array[3] =ls_Default
		lstr_pass.s_u_dw            = idw_band
		OpenWithParm(w_export_expression,lstr_pass)
		lstr_pass = Message.PowerObjectParm
		if isvalid(lstr_pass) then
			if  trim(lstr_pass.s_string) <> "" then
				this.SetItem(row,ls_Column,lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.fontcolorexpress, lstr_pass.s_string)
				this.Modify( "text_color.protect = 1" )
				This.Modify( "b_font_colorexpress.color = '16711935'" )	
				SetColumn( 'fontcolorexpress' )
			Else
				this.SetItem(row,ls_Column,"")
				this.Event ItemChanged( Row, this.object.text_color,  string( GetItemNumber( row, 'text_color' ) ) )
				this.Modify( "text_color.protect = 0" )
				This.Modify( "b_font_colorexpress.color = '0'" )
				SetColumn( 'text_color' )
			end if
		end if		
end choose
end event

event itemchanged;call super::itemchanged;String	ls_Error, ls_data
Integer		li_Return

choose case dwo.name 
	case "text_color", "background_color"
		of_ShowColor()
	Case "text"
		If Len( data ) > 0 Then
			Long ll_Pos, ll_LeftBracketCnts, ll_RightBracketCnts
			
			ll_Pos = Pos(data,"(")
			do while ll_Pos > 0
				ll_LeftBracketCnts++
				ll_Pos = Pos(data,"(",ll_Pos + 1)
			loop
			
			ll_Pos = Pos(data,")")
			do while ll_Pos > 0
				ll_RightBracketCnts++
				ll_Pos = Pos(data,")",ll_Pos + 1)
			loop
			
			if ll_LeftBracketCnts < ll_RightBracketCnts then
				MessageBox(gnv_app.iapp_object.DisplayName, "Unpaired ‘)’ is not allowed and it will be replaced by ‘>’.",StopSign!)
				ll_pos= pos( data, ')' )
				ls_data = data
				do while ll_pos > 0 
					ls_data = replace( ls_data, ll_pos, 1, '>' )
					ll_pos = Pos( ls_data, ')', ll_pos +  1 )			
				loop
				SetText( ls_Data )
				SetItem( row, 'text', ls_data )
				//Modified by gavin on 2009-03-05
				inv_data_design.ib_HasNewModify = true	
				inv_data_design.Post of_set_dw_properties( dwo.Name, 3)
				Return 2
			end if				
			
		End If		
		inv_data_design.ib_HasNewModify = true
	Case "name"
		If inv_data_design.il_dw_style = 1 Then
			li_Return = MessageBox( 'Tip', 'After you modify the field label ~r~n you will not be able to sort this column by clicking on the label,~r~n nor will the label move along with the field when you move the field.~r~n Are you sure you want to modify the label?', Question!, yesno! )
			If li_Return <> 1 Then
				SetItem(row, 'name', is_Name )
				Return 2
			End If
			is_Name = Data
		End If
end choose

//ls_Error = of_ObjectNameVerify(data)
//if ls_Error <> "" then
//	MessageBox(gnv_app.iapp_object.DisplayName,ls_Error)
//	Return 1
//end if

//Modified by gavin on 2009-03-05
inv_data_design.Post of_set_dw_properties( dwo.Name, 3)



end event

event losefocus;call super::losefocus;this.AcceptText()
end event

event constructor;call super::constructor;String ls_fonts[]
datawindowchild ldwc_fonts
int i,j
n_cst_appeondll lnv_appeon_dll


if this.getchild("font_face",ldwc_fonts) = 1 then
	lnv_appeon_dll.of_getfonts(ls_fonts)
	
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
	this.InsertRow(0)
end if
end event

event clicked;call super::clicked;AcceptText( )

end event

event editchanged;call super::editchanged;If row> 0 Then
	If IsNull( data ) Or Trim( data ) = '' Or Not IsNumber( data ) Then Return
	choose case dwo.name 
		case "text_color", "background_color"
			of_ShowColor( string( dwo.name ) , data )
	end choose
End If
end event

event itemerror;call super::itemerror;Return 3
end event

type tabpage_font from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 1783
integer height = 1576
long backcolor = 33551856
string text = "Font"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
long picturemaskcolor = 536870912
string powertiptext = "Font"
dw_2 dw_2
end type

on tabpage_font.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_font.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw within tabpage_font
integer x = 14
integer y = 20
integer width = 1765
integer height = 1040
integer taborder = 10
string dataobject = "d_contract_text_properties_font"
boolean vscrollbar = false
boolean border = false
end type

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

event constructor;call super::constructor;This.of_SetUpdateable(False)

String ls_fonts[]
datawindowchild ldwc_fonts
int i,j
n_cst_appeondll lnv_appeon_dll


if this.getchild("font_face",ldwc_fonts) = 1 then
	lnv_appeon_dll.of_getfonts(ls_fonts)
	
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
	this.InsertRow(0)
end if
end event

type dw_properties_text from u_dw within w_contract_text_properties
boolean visible = false
integer x = 14
integer y = 12
integer width = 1061
integer height = 1176
integer taborder = 10
string dataobject = "d_contract_text_properties"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;long ll_Color

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

type cb_ok from u_cb within w_contract_text_properties
boolean visible = false
integer x = 379
integer y = 1228
integer width = 343
integer taborder = 20
boolean bringtotop = true
string text = "&OK"
end type

event clicked;Close( Parent )

end event

type cb_cancel from u_cb within w_contract_text_properties
integer x = 1504
integer y = 1720
integer width = 343
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean default = true
end type

event clicked;//BEGIN---Modify by Scofield on 2009-09-29
String 	ls_ObjName,ls_Visible, ls_TObj
long		ll_Row

dw_Properties_Text.AcceptText()

ll_Row = dw_Properties_Text.GetRow()
ls_ObjName = dw_Properties_Text.GetItemString(ll_Row,"name")

if inv_data_design.is_open_style = "screen" and inv_data_design.ib_HasNewModify and inv_data_design.ii_Screen_id >= 3 and inv_data_design.ii_Screen_id <= 10 Then
	If ( inv_data_design.ii_Screen_id >=6 and inv_data_design.ii_Screen_id  <=7  and Pos( lower(ls_ObjName),'owner' ) > 0 )   then
		inv_data_design.Post of_AutoUpdateSearchScreen(ls_ObjName, 'owner' )		
	ElseIf Not( inv_data_design.ii_Screen_id >=6 and inv_data_design.ii_Screen_id  <=7 ) Then
		inv_data_design.Post of_AutoUpdateSearchScreen(ls_ObjName)
		inv_data_design.Post of_AutoUpdateDetailScreen(ls_ObjName)	//Jervis 10.21.2010
	End If
end if
//END---Modify by Scofield on 2009-09-29
//added by gavins 20120329
if inv_data_design.is_open_style = "screen" and inv_data_design.ib_HasNewModify and ( inv_data_design.ii_Screen_id = 6 Or inv_data_design.ii_Screen_id = 7 ) then
	If inv_data_design.ii_Screen_id = 6 Then
		ls_TObj = 'ccci_' + ls_ObjName
	Else
		ls_TObj = 'occi_' + ls_ObjName
	ENd If
	If Pos(  'association,custom_n1, custom_1' , lower(ls_ObjName) ) > 0  Or  Pos(  'association_t,custom_n1_t, custom_1_t' , lower(ls_ObjName) ) > 0  Then
		inv_data_design.Post of_AutoUpdateSearchScreen(ls_ObjName, ls_TObj )		
//		inv_data_design.Post of_AutoUpdateSearchScreen(ls_ObjName, ls_TObj )	
	End If
End If
//added by gavins 20120607
if inv_data_design.is_open_style = "screen" and inv_data_design.ib_HasNewModify and ( inv_data_design.ii_Screen_id =31 ) then
	ls_TObj = 'feesched_' + ls_ObjName
	inv_data_design.Post of_AutoUpdateSearchScreen(ls_ObjName, ls_TObj )		
//	inv_data_design.Post of_AutoUpdateSearchScreen(ls_ObjName, ls_TObj )	
	
End If


Close(Parent)

end event

