$PBExportHeader$w_todolist_settings.srw
forward
global type w_todolist_settings from w_response
end type
type cb_1 from commandbutton within w_todolist_settings
end type
type cb_default from commandbutton within w_todolist_settings
end type
type uo_font_list from u_cst_fonts_list within w_todolist_settings
end type
type cb_close from commandbutton within w_todolist_settings
end type
type cb_save from commandbutton within w_todolist_settings
end type
type dw_settings from u_dw within w_todolist_settings
end type
end forward

global type w_todolist_settings from w_response
integer width = 2441
integer height = 1812
string title = "To Do List Global Settings"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_1 cb_1
cb_default cb_default
uo_font_list uo_font_list
cb_close cb_close
cb_save cb_save
dw_settings dw_settings
end type
global w_todolist_settings w_todolist_settings

type variables

end variables

forward prototypes
public subroutine of_refresh ()
end prototypes

public subroutine of_refresh ();gnv_user_option.of_system_retrieve( )

String ls_value

ls_value = gnv_user_option.of_get_option_value( "todolist_style" )
If ls_value = '' Then ls_value = '1'
dw_settings.SetItem(1, 'style', Long(ls_value))

//Added by Appeon long.zhang 08.26.2014 (v14.2 BugH082102 of IntelliCredApp V14.2 Issues of New Features)
if  Long(ls_value) =1 then
	cb_default.enabled = false
else
	cb_default.enabled = true
end if


ls_value = gnv_user_option.of_get_option_value( "todolist_tv_filter_font" )
If ls_value = '' Then ls_value = 'Segoe UI'
dw_settings.SetItem(1, 'tv_filter_font', ls_value)

ls_value = gnv_user_option.of_get_option_value( "todolist_tv_filter_font_size" )
If ls_value = '' Then ls_value = '9'
dw_settings.SetItem(1, 'tv_filter_font_size', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_tv_filter_font_color" )
If ls_value = '' Then ls_value = String(RGB(0,0,0))
dw_settings.SetItem(1, 'tv_filter_font_color', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_tv_bk_color" )
If ls_value = '' Then ls_value = String(RGB(255,255,255))
dw_settings.SetItem(1, 'tv_bk_color', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_filter_bk_color" )
If ls_value = '' Then ls_value = dw_settings.Describe("DataWindow.Color") //'536870912'
dw_settings.SetItem(1, 'filter_bk_color', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_whole_bk_color" )
If ls_value = '' Then ls_value = String(This.backcolor) //'536870912'
dw_settings.SetItem(1, 'whole_bk_color', Long(ls_value))

//Level 1 Font
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level1_font" )
If ls_value = '' Then ls_value = 'Segoe UI'
dw_settings.SetItem(1, 'tv_level1_font', ls_value)
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level1_font_size" )
If ls_value = '' Then ls_value = '9'
dw_settings.SetItem(1, 'tv_level1_font_size', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level1_font_color" )
If ls_value = '' Then ls_value = String(RGB(0,0,0))
dw_settings.SetItem(1, 'tv_level1_font_color', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level1_font_bold" )
If ls_value = '' Then ls_value = '1'
dw_settings.SetItem(1, 'tv_level1_font_bold', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level1_font_italy" )
If ls_value = '' Then ls_value = '0'
dw_settings.SetItem(1, 'tv_level1_font_italy', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level1_font_underline" )
If ls_value = '' Then ls_value = '0'
dw_settings.SetItem(1, 'tv_level1_font_underline', Long(ls_value))

//Level 2 Font
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level2_font" )
If ls_value = '' Then ls_value = 'Segoe UI'
dw_settings.SetItem(1, 'tv_level2_font', ls_value)
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level2_font_size" )
If ls_value = '' Then ls_value = '9'
dw_settings.SetItem(1, 'tv_level2_font_size', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level2_font_color" )
If ls_value = '' Then ls_value = String(RGB(0,0,0))
dw_settings.SetItem(1, 'tv_level2_font_color', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level2_font_bold" )
If ls_value = '' Then ls_value = '0'
dw_settings.SetItem(1, 'tv_level2_font_bold', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level2_font_italy" )
If ls_value = '' Then ls_value = '0'
dw_settings.SetItem(1, 'tv_level2_font_italy', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level2_font_underline" )
If ls_value = '' Then ls_value = '0'
dw_settings.SetItem(1, 'tv_level2_font_underline', Long(ls_value))

//Level 3 Font
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level3_font" )
If ls_value = '' Then ls_value = 'Segoe UI'
dw_settings.SetItem(1, 'tv_level3_font', ls_value)
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level3_font_size" )
If ls_value = '' Then ls_value = '9'
dw_settings.SetItem(1, 'tv_level3_font_size', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level3_font_color" )
If ls_value = '' Then ls_value = String(RGB(0,0,0))
dw_settings.SetItem(1, 'tv_level3_font_color', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level3_font_bold" )
If ls_value = '' Then ls_value = '0'
dw_settings.SetItem(1, 'tv_level3_font_bold', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level3_font_italy" )
If ls_value = '' Then ls_value = '0'
dw_settings.SetItem(1, 'tv_level3_font_italy', Long(ls_value))
ls_value = gnv_user_option.of_get_option_value( "todolist_tv_level3_font_underline" )
If ls_value = '' Then ls_value = '0'
dw_settings.SetItem(1, 'tv_level3_font_underline', Long(ls_value))

//Field Widths
ls_value = gnv_user_option.of_get_option_value( "todolist_display_field1_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field1_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field2_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field2_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field3_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field3_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field4_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field4_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field5_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field5_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field6_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field6_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field7_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field7_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field8_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field8_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field9_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field9_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field10_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field10_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field11_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field11_width', Long(ls_value))

ls_value = gnv_user_option.of_get_option_value( "todolist_display_field12_width" )
If ls_value = '' Then ls_value = '500'
dw_settings.SetItem(1, 'display_field12_width', Long(ls_value))


end subroutine

on w_todolist_settings.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_default=create cb_default
this.uo_font_list=create uo_font_list
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_settings=create dw_settings
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_default
this.Control[iCurrent+3]=this.uo_font_list
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.dw_settings
end on

on w_todolist_settings.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_default)
destroy(this.uo_font_list)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_settings)
end on

event pfc_postopen;call super::pfc_postopen;Datawindowchild ldwc_text_fonts,ldwc_text_fonts1,ldwc_text_fonts2,ldwc_text_fonts3

dw_settings.GetChild('tv_filter_font',ldwc_text_fonts)
uo_font_list.idwc_fonts.RowsCopy(1,uo_font_list.idwc_fonts.RowCount(),primary!,ldwc_text_fonts,1,primary!)

dw_settings.GetChild('tv_level1_font',ldwc_text_fonts1)
uo_font_list.idwc_fonts.RowsCopy(1,uo_font_list.idwc_fonts.RowCount(),primary!,ldwc_text_fonts1,1,primary!)

dw_settings.GetChild('tv_level2_font',ldwc_text_fonts2)
uo_font_list.idwc_fonts.RowsCopy(1,uo_font_list.idwc_fonts.RowCount(),primary!,ldwc_text_fonts2,1,primary!)

dw_settings.GetChild('tv_level3_font',ldwc_text_fonts3)
uo_font_list.idwc_fonts.RowsCopy(1,uo_font_list.idwc_fonts.RowCount(),primary!,ldwc_text_fonts3,1,primary!)

end event

event open;call super::open;of_refresh()

end event

type cb_1 from commandbutton within w_todolist_settings
integer x = 914
integer y = 60
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Preview"
end type

event clicked;//Start Code Change ----07.16.2014 #V14.2 maha - added preview button
Open(w_todolist)
end event

type cb_default from commandbutton within w_todolist_settings
integer x = 1275
integer y = 60
integer width = 370
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Default"
end type

event clicked;
integer li_res
//Start Code Change ----07.16.2014 #V14.2 maha - added confirmation message

//Modified by Appeon long.zhang 08.20.2014 (v14.2 For an error of BugH081902 of IntelliCredApp V14.2 Issues of New Features)
//messagebox("Reset Defaults","Are you sure you wish to reset all of the custom settings to the Program defaults?", question!,yesno!,2)
li_res = messagebox("Reset Defaults","Are you sure you wish to reset all of the custom settings to the Program defaults?", question!,yesno!,2)

if li_res = 1 then
	dw_settings.SetRedraw(False)
	dw_settings.Reset()
	dw_settings.InsertRow(0)
	dw_settings.SetItem(1, 'filter_bk_color', Parent.backcolor)
	dw_settings.SetItem(1, 'Whole_bk_color', Parent.backcolor)
	dw_settings.SetRedraw(True)
end if

end event

type uo_font_list from u_cst_fonts_list within w_todolist_settings
integer x = 2999
integer y = 3000
integer width = 0
integer height = 0
integer taborder = 40
end type

on uo_font_list.destroy
call u_cst_fonts_list::destroy
end on

type cb_close from commandbutton within w_todolist_settings
integer x = 2016
integer y = 60
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_save from commandbutton within w_todolist_settings
integer x = 1655
integer y = 60
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;
String ls_value
Long ll_value

//n_cst_user_option object is stored in intellicontract_am.pbl.  Table is system_options.

dw_settings.AcceptText()
ll_value = dw_settings.GetItemNumber(1, 'style' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_style", String(ll_value) )
End If

ls_value = dw_settings.GetItemString(1, 'tv_filter_font' )
If Not isnull(ls_value) and ls_value <> '' Then
	gnv_user_option.of_set_option_value( "todolist_tv_filter_font", ls_value )
End If

ll_value = dw_settings.GetItemNumber(1, 'tv_filter_font_size' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_filter_font_size", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'tv_filter_font_color' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_filter_font_color", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'tv_bk_color' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_bk_color", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'filter_bk_color' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_filter_bk_color", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'whole_bk_color' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_whole_bk_color", String(ll_value) )
End If

//Level 1 Font
ls_value = dw_settings.GetItemString(1, 'tv_level1_font' )
If Not isnull(ls_value) and ls_value <> '' Then
	gnv_user_option.of_set_option_value( "todolist_tv_level1_font", ls_value )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level1_font_size' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level1_font_size", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level1_font_color' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level1_font_color", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level1_font_bold' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level1_font_bold", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level1_font_italy' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level1_font_italy", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level1_font_underline' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level1_font_underline", String(ll_value) )
End If
//Level 2 Font
ls_value = dw_settings.GetItemString(1, 'tv_level2_font' )
If Not isnull(ls_value) and ls_value <> '' Then
	gnv_user_option.of_set_option_value( "todolist_tv_level2_font", ls_value )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level2_font_size' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level2_font_size", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level2_font_color' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level2_font_color", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level2_font_bold' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level2_font_bold", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level2_font_italy' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level2_font_italy", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level2_font_underline' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level2_font_underline", String(ll_value) )
End If
//Level 3 Font
ls_value = dw_settings.GetItemString(1, 'tv_level3_font' )
If Not isnull(ls_value) and ls_value <> '' Then
	gnv_user_option.of_set_option_value( "todolist_tv_level3_font", ls_value )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level3_font_size' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level3_font_size", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level3_font_color' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level3_font_color", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level3_font_bold' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level3_font_bold", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level3_font_italy' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level3_font_italy", String(ll_value) )
End If
ll_value = dw_settings.GetItemNumber(1, 'tv_level3_font_underline' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_tv_level3_font_underline", String(ll_value) )
End If


//Field Width
ll_value = dw_settings.GetItemNumber(1, 'display_field1_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field1_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field2_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field2_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field3_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field3_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field4_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field4_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field5_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field5_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field6_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field6_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field7_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field7_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field8_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field8_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field9_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field9_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field10_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field10_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field11_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field11_width", String(ll_value) )
End If

ll_value = dw_settings.GetItemNumber(1, 'display_field12_width' )
If Not isnull(ll_value) Then
	gnv_user_option.of_set_option_value( "todolist_display_field12_width", String(ll_value) )
End If

gnv_user_option.of_system_save( )

Parent.of_refresh( )
end event

type dw_settings from u_dw within w_todolist_settings
integer y = 8
integer width = 2409
integer height = 1716
integer taborder = 10
string dataobject = "d_todolist_settings"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;Long ll_color,ll_color_org 

If This.RowCount() = 0 Then Return

If This.GetItemNumber(1, 'style') = 1 Then Return //Classic

////For Text Color
//If dwo.name = 'r_text_color' Then
//	ll_color = This.GetItemNumber(1,'tv_font_color')
//	ll_color_org = ll_color
//	ChooseColor(ll_color,gl_custom_colors[])
//	If ll_color_org <> ll_color Then
//		This.SetItem(1,'tv_font_color',ll_color)
//	End If
//End If

//For TDL BK Color
If dwo.name = 'r_bk_color' Then
	ll_color = This.GetItemNumber(1,'tv_bk_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'tv_bk_color',ll_color)
	End If
End If

//For Filter BK Color
If dwo.name = 'r_filter_bk_color' Then
	ll_color = This.GetItemNumber(1,'filter_bk_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'filter_bk_color',ll_color)
	End If
End If

//For Whole BK Color
If dwo.name = 'r_whole_bk_color' Then
	ll_color = This.GetItemNumber(1,'whole_bk_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'whole_bk_color',ll_color)
	End If
End If

//For Level 1 Color
If dwo.name = 'r_level1_text_color' Then
	ll_color = This.GetItemNumber(1,'tv_level1_font_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'tv_level1_font_color',ll_color)
	End If
End If

//For Level 2 Color
If dwo.name = 'r_level2_text_color' Then
	ll_color = This.GetItemNumber(1,'tv_level2_font_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'tv_level2_font_color',ll_color)
	End If
End If

//For Level 3 Color
If dwo.name = 'r_level3_text_color' Then
	ll_color = This.GetItemNumber(1,'tv_level3_font_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'tv_level3_font_color',ll_color)
	End If
End If

String ls_dwoname, ls_fieldname,ls_fieldtype
Long ll_need_down = -1, ll_level
ls_dwoname = dwo.name
If Left( ls_dwoname , 7) = 'p_level' Then
	ll_level = Long(Mid(ls_dwoname, 8, 1))
	If Pos(ls_dwoname, '_down') > 0 Then
		ll_need_down = 0
	End If
	If Pos(ls_dwoname, '_up') > 0 Then
		ll_need_down = 1
	End If
	If ll_need_down <> -1 Then
		If Pos(ls_dwoname, '_bold') > 0 Then
			ls_fieldtype = 'bold'
		End If
		If Pos(ls_dwoname, '_italy') > 0 Then
			ls_fieldtype = 'italy'
		End If
		If Pos(ls_dwoname, '_underline') > 0 Then
			ls_fieldtype = 'underline'
		End If		
		If ls_fieldtype <> ''  Then
			ls_fieldname = 'tv_level' + String(ll_level) + '_font_' + ls_fieldtype
			If This.Describe(ls_fieldname+'.type') = 'column' Then
				This.SetItem(1,ls_fieldname,ll_need_down )
			End If
		End If
	End If
End If
		

end event

event constructor;call super::constructor;This.InsertRow(0)
This.of_setupdateable( False )

end event

event itemchanged;call super::itemchanged;//Added by Appeon long.zhang 08.26.2014 (v14.2 BugH082102 of IntelliCredApp V14.2 Issues of New Features)
if dwo.name ='style' then
	if data ='1' then
		cb_default.enabled = false
	else
		cb_default.enabled = true
	end if
end if
end event

