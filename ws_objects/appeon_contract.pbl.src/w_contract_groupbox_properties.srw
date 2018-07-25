$PBExportHeader$w_contract_groupbox_properties.srw
forward
global type w_contract_groupbox_properties from w_popup
end type
type cb_cancel from u_cb within w_contract_groupbox_properties
end type
type tab_1 from tab within w_contract_groupbox_properties
end type
type tabpage_general from userobject within tab_1
end type
type dw_general from u_dw within tabpage_general
end type
type tabpage_general from userobject within tab_1
dw_general dw_general
end type
type tabpage_position from userobject within tab_1
end type
type dw_position from u_dw within tabpage_position
end type
type tabpage_position from userobject within tab_1
dw_position dw_position
end type
type tab_1 from tab within w_contract_groupbox_properties
tabpage_general tabpage_general
tabpage_position tabpage_position
end type
end forward

global type w_contract_groupbox_properties from w_popup
integer width = 1838
integer height = 1732
string title = "Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
cb_cancel cb_cancel
tab_1 tab_1
end type
global w_contract_groupbox_properties w_contract_groupbox_properties

type variables
pfc_cst_u_contract_data_design inv_data_design
pfc_cst_u_band					idw_band
String							is_SetObject, is_Objects[], is_Type

pfc_cst_u_band_painter inv_band


end variables

forward prototypes
public subroutine wf_refreshdata (datawindow adw_syntax, string as_object)
public function string of_objectnameverify (string as_name)
public function integer of_parsecolor (ref long al_color)
public subroutine wf_resetdata ()
public function integer of_showcolor ()
public function integer of_showcolor (string as_object, string as_color)
end prototypes

public subroutine wf_refreshdata (datawindow adw_syntax, string as_object);//

String					ls_Visible, ls_Band, ls_Color, ls_Border, ls_VisibleExpress, ls_slideup
DataWindow		ldw_General
Long					ll_Color

If tab_1.tabpage_general.dw_general.RowCount( ) = 0 Then 
	tab_1.tabpage_general.dw_general.InsertRow( 0 )
	tab_1.tabpage_general.dw_general.ShareData( tab_1.tabpage_position.dw_Position )
End If

ldw_General = tab_1.tabpage_general.dw_general

is_Type = adw_syntax.Describe( as_object + ".type" )

This.title = wordcap(is_Type) + ' Properties' 

tab_1.tabpage_general.Text = wordcap(is_Type) + ' Display'


ldw_General.SetItem(1, "name", as_Object)

ls_Visible = adw_syntax.Describe(as_Object + ".visible") //added by gavins 20120503
If ls_Visible = '-1' Then ls_Visible = '1'
If Pos( ls_Visible, '~t' ) > 0   Then
	ls_VisibleExpress =  ls_Visible
	ls_Visible = "1"
	ldw_General.Modify( "visible.protect = 1" )
 	ldw_General.Modify( "visible.color = 8421504" )
	ldw_General.Modify( "b_visible.color = '16711935'" )
Else
	ldw_General.Modify( "visible.protect = 0" )
 	ldw_General.Modify( "visible.color = 0" )
	ldw_General.Modify( "b_visible.color = '0'" )
	ls_VisibleExpress = ""
End If

ldw_General.SetItem(1, "visible", ls_Visible )
ldw_General.SetItem(1, "visibleexpress", ls_VisibleExpress )

ldw_General.SetItem(1, "text", adw_syntax.Describe(as_Object + ".text"))

ldw_General.SetItem(1, "border", adw_syntax.Describe(as_Object + ".border"))

ll_Color = Long(adw_syntax.Describe(as_Object + ".color"))
ldw_General.SetItem(1, "text_color", ll_Color)
ll_Color = Long(adw_syntax.Describe(as_Object + ".background.color"))
ldw_General.SetItem(1, "background_color", ll_Color)

//Add font.properties  - jervis 09.06.2011
string	ls_fonts_face,ls_fonts_size,ls_fonts_bold,ls_fonts_italic,ls_fonts_underline,ls_fonts_strikeout
ls_fonts_face = adw_syntax.Describe(as_Object + ".font.face")
ldw_General.SetItem(1,"font_face",ls_fonts_face)

ls_fonts_size = adw_syntax.Describe(as_Object + ".font.height")
if ls_fonts_size = '?' then ls_fonts_size = '-8'
ls_fonts_size = string(Abs(long(ls_fonts_size)))
ldw_General.SetItem(1,"font_height",long(ls_fonts_size))

ls_fonts_bold = adw_syntax.Describe(as_Object + ".font.weight")
ldw_General.SetItem(1,"font_weight",ls_fonts_bold)

ls_fonts_italic = adw_syntax.Describe(as_Object + ".font.italic")
if ls_fonts_italic = '?' then ls_fonts_italic = '0'
ldw_General.SetItem(1,"font_italic",ls_fonts_italic)

ls_fonts_underline = adw_syntax.Describe(as_Object + ".font.underline")
if ls_fonts_underline = '?' then ls_fonts_underline = '0'
ldw_General.SetItem(1,"font_underline",ls_fonts_underline)

ls_fonts_strikeout = adw_syntax.Describe(as_Object + ".font.strikethrough")
if ls_fonts_strikeout = '?' then ls_fonts_strikeout = '0'
ldw_General.SetItem(1,"font_strikethrough",ls_fonts_strikeout)

ls_Slideup = adw_syntax.Describe(as_Object + ".slideup")
if ls_Slideup = '?' then ls_Slideup = 'no'
ldw_General.SetItem(1,"slideup",ls_Slideup)	
	
of_ShowColor()







end subroutine

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

public function integer of_parsecolor (ref long al_color);if IsNull(al_Color) or al_Color = 33554432 then
	al_Color = RGB(0,0,0)
elseif al_Color = 67108864 then
	al_Color = RGB(212,208,200)
end if

Return 1
end function

public subroutine wf_resetdata ();//

tab_1.tabpage_general.dw_general.Reset()
end subroutine

public function integer of_showcolor ();long ll_Row


ll_Row = tab_1.tabpage_general.dw_general.GetRow()
tab_1.tabpage_general.dw_general.AcceptText( )
if ll_Row <= 0 then Return -1

//modified by gavins 20120503

tab_1.tabpage_general.dw_general.object.t_text_color.background.color = tab_1.tabpage_general.dw_general.object.text_color[ll_Row]
tab_1.tabpage_general.dw_general.object.t_background_color.background.color = tab_1.tabpage_general.dw_general.object.background_color[ll_Row]


Return 1
end function

public function integer of_showcolor (string as_object, string as_color);


Choose Case as_object
	case 'text_color'
		tab_1.tabpage_general.dw_general.object.t_text_color.background.color = as_color
	case 'background_color'
		tab_1.tabpage_general.dw_general.object.t_background_color.background.color = as_color
end choose


Return 1
end function

on w_contract_groupbox_properties.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.tab_1
end on

on w_contract_groupbox_properties.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.tab_1)
end on

event open;call super::open;str_set_properties       lstr_pro


lstr_pro = Message.Powerobjectparm

inv_data_design = lstr_Pro.lst_data_design

inv_band = lstr_Pro.lst_band_painter

idw_band = lstr_Pro.lst_band

is_SetObject = lstr_Pro.lst_code

is_Objects = lstr_Pro.lst_object


If tab_1.tabpage_general.dw_general.RowCount( ) = 0 Then tab_1.tabpage_general.dw_general.InsertRow( 0 )


tab_1.tabpage_general.dw_general.ShareData( tab_1.tabpage_position.dw_Position )

wf_refreshData(  inv_band.dw_Syntax  , is_SetObject )

If inv_data_design.is_open_style <> 'report' Then
	tab_1.tabpage_general.dw_general.Modify( "slideup.visible=0 slideup_t.visible=0" )
	
End If
end event

event key;call super::key;If key = KeyEscape! Then cb_cancel.Event  Clicked( )
end event

event closequery;//abrogate  inheritation
end event

type cb_cancel from u_cb within w_contract_groupbox_properties
integer x = 1449
integer y = 1532
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

type tab_1 from tab within w_contract_groupbox_properties
integer x = 14
integer y = 8
integer width = 1806
integer height = 1512
integer taborder = 10
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
tabpage_position tabpage_position
end type

on tab_1.create
this.tabpage_general=create tabpage_general
this.tabpage_position=create tabpage_position
this.Control[]={this.tabpage_general,&
this.tabpage_position}
end on

on tab_1.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_position)
end on

type tabpage_general from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1769
integer height = 1396
long backcolor = 33551856
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_general dw_general
end type

on tabpage_general.create
this.dw_general=create dw_general
this.Control[]={this.dw_general}
end on

on tabpage_general.destroy
destroy(this.dw_general)
end on

type dw_general from u_dw within tabpage_general
integer x = 9
integer width = 1760
integer height = 1432
integer taborder = 20
string dataobject = "d_contract_groupboxgeneral_properties"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;String			ls_Object, ls_Modify, ls_Modify2, ls_Modify3, ls_Visible
String			ls_Err

If row <=0 Then Return

ls_Object = dwo.Name

ls_Modify = ""
ls_Modify2 = ''
Choose Case ls_Object 
	case 'visible'
		ls_Modify = is_SetObject + ".visible='" + data + "' "
	case 'text'
		ls_Modify = is_SetObject + ".text='" + data + "' "
		ls_Modify2 = 	ls_Modify	
	case 'layer'
		idw_band.of_setobjectlayer( is_SetObject, Data )
		Return
	case 'background_color'
		ls_Modify = is_SetObject + ".background.color='" + data + "' " + is_SetObject + ".background.mode = '2' "
		ls_Modify2 = 	ls_Modify
		ls_Modify3 = "t_background_color.background.color=" + data 
	case "text_color"
		ls_Modify = is_SetObject + ".color='" + data + "' "
		ls_Modify2 = 	ls_Modify
		ls_Modify3 = "t_text_color.background.color=" + data 
	case 'border'
		ls_Modify = is_SetObject + ".border='" + data + "'"
		ls_Modify2 = 	ls_Modify	
	case 'express'
		ls_Modify = is_SetObject + '.expression="' + data + '"'
		ls_Modify2 = 	ls_Modify	
	case 'alignment'
		ls_Modify = is_SetObject + ".alignment=" + data
		ls_Modify2 = 	ls_Modify	
	case 'format'
		ls_Modify = is_SetObject + ".format='" + data + "'"
		ls_Modify2 = 	ls_Modify			
	case 'font_face'
		ls_Modify = is_SetObject + ".font.face='" + data + "'"
		ls_Modify2 = 	ls_Modify			
	case 'font_height'
		ls_Modify = is_SetObject + ".font.height='-" + data + "'"
		ls_Modify2 = 	ls_Modify		
	case 'font_weight'
		ls_Modify = is_SetObject + ".font.weight='" + data + "'"
		ls_Modify2 = 	ls_Modify		
	case 'font_italic'
		ls_Modify = is_SetObject + ".font.italic='" + data + "'"
		ls_Modify2 = 	ls_Modify	
	case 'font_underline'
		ls_Modify = is_SetObject + ".font.underline='" + data + "'"
		ls_Modify2 = 	ls_Modify	
	case 'font_strikethrough'
		ls_Modify = is_SetObject + ".font.strikethrough='" + data + "'"
		ls_Modify2 = 	ls_Modify		
	case 'visibleexpress'
		ls_Visible = data
		If Pos( ls_Visible, '~t' ) > 0 Then ls_Visible = Mid( ls_Visible, pos( ls_Visible, '~t' ) + 1 )
		ls_Modify = is_SetObject + '.visible="' +GetItemString( row, 'visible' ) + '~t' +ls_Visible + '" '
	case 'slideup'
		ls_Modify = is_SetObject + ".slideup='" + data + "'"
		ls_Modify2 = 	ls_Modify		
End Choose


If Len( ls_Modify ) > 0 Then
	this.Modify( ls_Modify3 ) 
	
	ls_Err = idw_band.Modify( 	ls_Modify2  )
	If Len( ls_Err ) > 0 Then
		MessageBox( 'Tips', ls_Err )
		Return 2
	End If
	ls_Err = inv_data_design.Event ue_SetModify( ls_Modify )
	If Len( ls_Err ) > 0 Then
		MessageBox( 'Tips', ls_Err )
		Return 2
	End If
//	.of_RefreshMarkPos()
End If
end event

event losefocus;call super::losefocus;this.AcceptText()
end event

event editchanged;call super::editchanged;If row> 0 Then
	choose case dwo.name 
		case "text_color", "background_color"
			If  data = '' or isnull( data ) Or Not IsNumber( data )  Then Return
			of_ShowColor( string(dwo.name), data )
	end choose
End If
end event

event buttonclicked;call super::buttonclicked;long 			ll_Color
String			ls_visible, ls_Expression
str_pass		lstr_pass
n_cst_string lnvo_string

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
		this.object.text_color[Row] = 0
		this.SetColumn("text_color")
		this.Event ItemChanged(Row, this.object.text_color, "0")

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
	Case "b_expression"
		ls_Expression = this.GetItemString(row,'express')
		if isnull(ls_Expression) then ls_Expression = ''
		IF Upper( appeongetclienttype() ) = 'PB' THEN
			if Left(ls_Expression,1) = '"' and Right(ls_Expression,1) = '"' then
				ls_Expression = Mid(ls_Expression,2,Len(ls_Expression) - 2)
			end if
			ls_Expression = lnvo_string.of_globalreplace( ls_Expression, '~~"', '"')
		end if

		lstr_pass.s_long[1] = 6	
		lstr_pass.s_string   = ls_Expression//expression
		lstr_pass.s_string_array[1] =  this.GetItemString( row,'name')
		lstr_pass.s_u_dw   = idw_band//relative dw
		openwithparm(w_export_expression,lstr_pass)
		
		//Modified the Fee Schedule screen and calc_field_1 or calc_field_2 or calc_field_2 field
		lstr_pass = message.Powerobjectparm
		if isvalid(lstr_pass) then
			if inv_data_design.ii_screen_id = 31 and ls_Expression <> lstr_pass.s_string then
				if this.GetItemString( row,'name') = "calc_field_1" then inv_data_design.ib_calc1_changed = true
				if this.GetItemString( row,'name') = "calc_field_2" then inv_data_design.ib_calc2_changed = true
				if this.GetItemString( row,'name') = "calc_field_3" then inv_data_design.ib_calc3_changed = true
			end if
			this.SetItem( row, 'express',  lstr_pass.s_string  )
			this.Event ItemChanged( Row, this.object.express, lstr_pass.s_string  )
		end if
		
end choose
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

event itemerror;call super::itemerror;Return 3
end event

type tabpage_position from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 1769
integer height = 1396
boolean enabled = false
long backcolor = 33551856
string text = "Position"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_position dw_position
end type

on tabpage_position.create
this.dw_position=create dw_position
this.Control[]={this.dw_position}
end on

on tabpage_position.destroy
destroy(this.dw_position)
end on

type dw_position from u_dw within tabpage_position
integer width = 1198
integer height = 1360
integer taborder = 10
string dataobject = "d_contract_groupboxgeneral_properties"
boolean vscrollbar = false
boolean border = false
end type

event itemchanged;call super::itemchanged;String			ls_Object, ls_Modify, ls_Modify2, ls_Band


ls_Object = dwo.Name

ls_Modify = ""
ls_Modify2 = ''
Choose Case ls_Object 
		
	case 'layer'
		ls_Band = data
		If data = 'band' Then
			CHOOSE CASE UPPER( inv_data_design.is_CurBand)
				CASE 'HEADER'
					ls_Band = 'header'
				CASE 'DETAIL'
					ls_Band = 'detail'
				CASE 'SUMMARY'
					ls_Band = 'summary'
				CASE 'FOOTER'
					ls_Band = 'footer'
				CASE 'HEADERGROUP','HEADER.1'
					ls_Band = 'header.1'
				CASE 'TRAILERGROUP','TRAILER.1'
					ls_Band = 'trailer.1'
				CASE else
					Return
			END CHOOSE
			
		End If
		ls_Modify = is_SetObject + ".band='" + ls_Band + "' "
		ls_Modify2 = 	ls_Modify
	case 'x1'
		If Long( data ) < 0 Or Not IsNumber( data ) Then
			SetItem(Row, ls_Object, '0' )
		End If
		ls_Modify = is_SetObject + ".x1='" + data + "' "
		ls_Modify2 = 	ls_Modify
	case 'x2'
		If Long( data ) < 0 Or Not IsNumber( data ) Then
			SetItem(Row, ls_Object, '0' )
		End If
		ls_Modify = is_SetObject + ".x2r='" + data + "' "
		ls_Modify2 = 	ls_Modify			
	case 'y1'
		If Long( data ) < 0 Or Not IsNumber( data ) Then
			SetItem(Row, ls_Object, '0' )
		End If
		ls_Modify = is_SetObject + ".y1='" + data + "' "		
		ls_Modify2 = 	ls_Modify
	case 'y2'
		If Long( data ) < 0 Or Not IsNumber( data ) Then
			SetItem(Row, ls_Object, '0' )
		End If	
		ls_Modify = is_SetObject + ".y2='" + data + "' "
		ls_Modify2 = 	ls_Modify		
End Choose


If Len( ls_Modify ) > 0 Then
	idw_band.Modify( 	ls_Modify2  )
	inv_data_design.of_SetModify( ls_Modify )
//	.of_RefreshMarkPos()
End If
end event

