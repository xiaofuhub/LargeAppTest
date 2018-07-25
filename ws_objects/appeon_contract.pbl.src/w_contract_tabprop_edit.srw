$PBExportHeader$w_contract_tabprop_edit.srw
forward
global type w_contract_tabprop_edit from window
end type
type ddlb_fontheight from dropdownlistbox within w_contract_tabprop_edit
end type
type cbx_fixedwidth from checkbox within w_contract_tabprop_edit
end type
type cbx_underline from checkbox within w_contract_tabprop_edit
end type
type cbx_italic from checkbox within w_contract_tabprop_edit
end type
type st_7 from statictext within w_contract_tabprop_edit
end type
type st_6 from statictext within w_contract_tabprop_edit
end type
type cb_layout_setting from commandbutton within w_contract_tabprop_edit
end type
type cbx_visible from checkbox within w_contract_tabprop_edit
end type
type cb_8 from commandbutton within w_contract_tabprop_edit
end type
type cb_7 from commandbutton within w_contract_tabprop_edit
end type
type p_1 from picture within w_contract_tabprop_edit
end type
type st_5 from statictext within w_contract_tabprop_edit
end type
type cb_6 from commandbutton within w_contract_tabprop_edit
end type
type cb_5 from commandbutton within w_contract_tabprop_edit
end type
type cb_4 from commandbutton within w_contract_tabprop_edit
end type
type cb_3 from commandbutton within w_contract_tabprop_edit
end type
type st_backcolor from statictext within w_contract_tabprop_edit
end type
type st_4 from statictext within w_contract_tabprop_edit
end type
type cb_2 from commandbutton within w_contract_tabprop_edit
end type
type st_tabbackcolor from statictext within w_contract_tabprop_edit
end type
type st_3 from statictext within w_contract_tabprop_edit
end type
type cb_1 from commandbutton within w_contract_tabprop_edit
end type
type st_textcolor from statictext within w_contract_tabprop_edit
end type
type cbx_icon from checkbox within w_contract_tabprop_edit
end type
type st_2 from statictext within w_contract_tabprop_edit
end type
type st_1 from statictext within w_contract_tabprop_edit
end type
type sle_text from singlelineedit within w_contract_tabprop_edit
end type
type cb_cancel from commandbutton within w_contract_tabprop_edit
end type
type cb_ok from commandbutton within w_contract_tabprop_edit
end type
type gb_1 from groupbox within w_contract_tabprop_edit
end type
type ddlb_fontname from dropdownlistbox within w_contract_tabprop_edit
end type
type gb_2 from groupbox within w_contract_tabprop_edit
end type
end forward

global type w_contract_tabprop_edit from window
integer width = 1719
integer height = 1300
boolean titlebar = true
string title = "Tab Page Properties"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
ddlb_fontheight ddlb_fontheight
cbx_fixedwidth cbx_fixedwidth
cbx_underline cbx_underline
cbx_italic cbx_italic
st_7 st_7
st_6 st_6
cb_layout_setting cb_layout_setting
cbx_visible cbx_visible
cb_8 cb_8
cb_7 cb_7
p_1 p_1
st_5 st_5
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
st_backcolor st_backcolor
st_4 st_4
cb_2 cb_2
st_tabbackcolor st_tabbackcolor
st_3 st_3
cb_1 cb_1
st_textcolor st_textcolor
cbx_icon cbx_icon
st_2 st_2
st_1 st_1
sle_text sle_text
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
ddlb_fontname ddlb_fontname
gb_2 gb_2
end type
global w_contract_tabprop_edit w_contract_tabprop_edit

type variables
long    il_data_view_id
string  is_tab_name
string  is_Label
string  is_Return = "cancel!"
boolean ib_Exists = false, ib_Modified = false
end variables

forward prototypes
public function integer of_choosecolor (ref statictext ast_text)
public function integer of_parsecolor (ref long al_color)
public function string wf_get_tab_default_ico (string as_tabpagename)
public subroutine wf_set_tab_ico (string as_tabname, string as_icon)
end prototypes

public function integer of_choosecolor (ref statictext ast_text);long ll_Color
long ll_CustomColors[]

ll_Color = ast_text.BackColor
of_ParseColor(ll_Color)

if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
	ast_text.BackColor = ll_Color
end if

Return 1
end function

public function integer of_parsecolor (ref long al_color);if IsNull(al_Color) or al_Color = 33554432 then
	al_Color = RGB(0,0,0)
elseif al_Color = 67108864 then
	al_Color = RGB(212,208,200)
end if

Return 1
end function

public function string wf_get_tab_default_ico (string as_tabpagename);Return gf_get_tabpage_default_icon(as_tabpagename)

//String ls_icon
//u_tab_contract_details lu_tab_contract_details
//lu_tab_contract_details = Create u_tab_contract_details
//
//Choose Case Lower(as_tabpagename)
//	Case 'tabpage_search'
//		ls_icon = lu_tab_contract_details.tabpage_search.picturename
//		
//	Case 'tabpage_details'
//		ls_icon = lu_tab_contract_details.tabpage_details.picturename
//	Case 'tabpage_det_notes'
//		ls_icon = lu_tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_notes.picturename
//	Case 'tabpage_det_custom'
//		ls_icon = lu_tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.picturename
//	Case 'tabpage_det_audit'
//		ls_icon = lu_tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.picturename
//	Case 'tabpage_det_linked'
//		ls_icon = lu_tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_2.picturename
//	Case 'tabpage_det_group'
//		ls_icon = lu_tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_group_access.picturename
//		
//	Case 'tabpage_requirements'
//		ls_icon = lu_tab_contract_details.tabpage_requirements.picturename
//		
//	Case 'tabpage_contacts'
//		ls_icon = lu_tab_contract_details.tabpage_contacts.picturename
//		
//	Case 'tabpage_locations'
//		ls_icon = lu_tab_contract_details.tabpage_locations.picturename
//		
//	Case 'tabpage_orgabizations'
//		ls_icon = lu_tab_contract_details.tabpage_orgabizations.picturename
//		
//		
//	Case 'tabpage_fee_schedules'
//		ls_icon = lu_tab_contract_details.tabpage_fee_schedules.picturename
//	Case 'tabpage_fee_browse'	
//		ls_icon = lu_tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse.picturename
//	Case 'tabpage_fee_notes'
//		ls_icon = lu_tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_notes.picturename
//		
//	Case 'tabpage_fee_sched2'
//		ls_icon = lu_tab_contract_details.tabpage_fee_sched2.picturename
//		
//	Case 'tabpage_images'
//		ls_icon = lu_tab_contract_details.tabpage_images.picturename
//	Case 'tabpage_dm_document'
//		ls_icon = lu_tab_contract_details.tabpage_images.tab_1.tabpage_data.picturename
//	Case 'tabpage_dm_workflow'
//		ls_icon = lu_tab_contract_details.tabpage_images.tab_1.tabpage_action.picturename
//	Case 'tabpage_dm_audit'
//		ls_icon = lu_tab_contract_details.tabpage_images.tab_1.tabpage_audit.picturename
//		
//	Case 'tabpage_action_items'
//		ls_icon = lu_tab_contract_details.tabpage_action_items.picturename
//		
//	Case 'tabpage_qrg'
//		ls_icon = lu_tab_contract_details.tabpage_qrg.picturename
//		
//	Case 'tabpage_qrg_select'
//		ls_icon = lu_tab_contract_details.tabpage_qrg.tab_1.tabpage_selection.picturename
//
//End Choose
//
//Return ls_icon
//
//
//
end function

public subroutine wf_set_tab_ico (string as_tabname, string as_icon);String ls_icon
n_cst_dm_utils lnv_utils //Added By Ken.Guo 03/28/2013

If as_icon = '' or isnull(as_icon) Then
	ls_icon = wf_get_tab_default_ico(as_tabname)
	If ls_icon <> '' Then
		p_1.picturename = ls_icon
		p_1.tag = ls_icon
	End If
Else
	If isnumber(as_icon) Then //Use Picture Painter.
		p_1.tag = as_icon
		lnv_utils.of_download_picture( Long(as_icon),as_icon) 
	End If
	p_1.picturename = as_icon
End If

end subroutine

on w_contract_tabprop_edit.create
this.ddlb_fontheight=create ddlb_fontheight
this.cbx_fixedwidth=create cbx_fixedwidth
this.cbx_underline=create cbx_underline
this.cbx_italic=create cbx_italic
this.st_7=create st_7
this.st_6=create st_6
this.cb_layout_setting=create cb_layout_setting
this.cbx_visible=create cbx_visible
this.cb_8=create cb_8
this.cb_7=create cb_7
this.p_1=create p_1
this.st_5=create st_5
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.st_backcolor=create st_backcolor
this.st_4=create st_4
this.cb_2=create cb_2
this.st_tabbackcolor=create st_tabbackcolor
this.st_3=create st_3
this.cb_1=create cb_1
this.st_textcolor=create st_textcolor
this.cbx_icon=create cbx_icon
this.st_2=create st_2
this.st_1=create st_1
this.sle_text=create sle_text
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.ddlb_fontname=create ddlb_fontname
this.gb_2=create gb_2
this.Control[]={this.ddlb_fontheight,&
this.cbx_fixedwidth,&
this.cbx_underline,&
this.cbx_italic,&
this.st_7,&
this.st_6,&
this.cb_layout_setting,&
this.cbx_visible,&
this.cb_8,&
this.cb_7,&
this.p_1,&
this.st_5,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.st_backcolor,&
this.st_4,&
this.cb_2,&
this.st_tabbackcolor,&
this.st_3,&
this.cb_1,&
this.st_textcolor,&
this.cbx_icon,&
this.st_2,&
this.st_1,&
this.sle_text,&
this.cb_cancel,&
this.cb_ok,&
this.gb_1,&
this.ddlb_fontname,&
this.gb_2}
end on

on w_contract_tabprop_edit.destroy
destroy(this.ddlb_fontheight)
destroy(this.cbx_fixedwidth)
destroy(this.cbx_underline)
destroy(this.cbx_italic)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.cb_layout_setting)
destroy(this.cbx_visible)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.p_1)
destroy(this.st_5)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.st_backcolor)
destroy(this.st_4)
destroy(this.cb_2)
destroy(this.st_tabbackcolor)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.st_textcolor)
destroy(this.cbx_icon)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_text)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.ddlb_fontname)
destroy(this.gb_2)
end on

event open;integer li_Pos
string  ls_Message
string  ls_text,ls_tab_icon
long    ll_text_color
long    ll_backcolor
long    ll_tab_backcolor
string  ls_icon_visible
string ls_tab_visible  //jervis 09.15.2011
String	ls_FontName, ls_Italic, ls_Underline, ls_fixedwidth
Long	ll_Font_height

//Commented By Ken.Guo 2010-09-19
//// APB not support dynamic picture
//if AppeonGetClientType() = "PB" then
//	cbx_icon.Show()
//else
//	cbx_icon.Hide()
//end if

// Get data view id and tab page name from message object
ls_Message = Message.StringParm
li_Pos = Pos(ls_Message, "|")
il_data_view_id = Long(Left(ls_Message, li_Pos - 1))
ls_Message = Right(ls_Message, Len(ls_Message) - li_Pos)
li_Pos = Pos(ls_Message, "|")
is_tab_name = Left(ls_Message, li_Pos - 1)
is_Label = Right(ls_Message, Len(ls_Message) - li_Pos)

//Set visible for custom data2 tab - jervis 09.15.2011
if is_tab_name = 'tabpage_det_audit'  or is_tab_name = 'tabpage_det_custom' or is_tab_name = 'tabpage_det_notes' then cbx_visible.visible = true

// Get properties value from database
SELECT text, text_color, icon_visible, backcolor, tab_backcolor,tab_icon,tab_visible
INTO :ls_text, :ll_text_color, :ls_icon_visible, :ll_backcolor, :ll_tab_backcolor, :ls_tab_icon,:ls_tab_visible
FROM ctx_tabpage_properties
WHERE data_view_id = :il_data_view_id AND tabpage_name = :is_tab_name ;

ls_fontname = gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Font_Name_Properties' , FALSE )
ls_italic = gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Font_Italic_Properties' , FALSE )
ls_underline = gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Font_Underline_Properties' , FALSE )
ll_Font_height = Long( gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Font_Height_Properties' , FALSE ) )
ls_fixedwidth = gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Fixed_Width_Properties' , FALSE )

If ll_Font_height = 0 Or isnull( ll_Font_height ) then ll_Font_height = 8
If isnull(ls_fontname ) or trim( ls_fontname ) = '' then ls_fontname ='MS Scans Serif'  

ddlb_fontname.text = ls_fontname //added by gaivns 20130415
if ls_italic = 'T' Then cbx_italic.checked = True
if ls_underline = 'T' Then cbx_underline.checked = True
If ls_fixedwidth = 'F' Then cbx_fixedwidth.checked = False
ddlb_fontheight.text = string( ll_Font_height )

// Show properties in window
if SQLCA.SQLCode = 0 then
	sle_text.Text = ls_text
	st_textcolor.BackColor = ll_text_color
	st_backcolor.BackColor = ll_backcolor
	st_tabbackcolor.BackColor = ll_tab_backcolor
	if ls_icon_visible = "F" then cbx_icon.Checked = false
	if ls_tab_visible = 'F' then cbx_visible.checked = false // jervis 09.15.2011
	ib_Exists = true
else
	sle_text.Text = is_Label
	ib_Exists = false
end if

//Begin - Added By Mark Lee 01/07/2013
If is_tab_name = 'tabpage_details' Then 
	cb_layout_setting.enabled = True
Else
	cb_layout_setting.enabled = false
End If
//End - Added By Mark Lee 01/07/2013

wf_set_tab_ico(is_tab_name,ls_tab_icon) //Added By Ken.Guo 2010-09-19.

end event

event close;CloseWithReturn(this, is_Return)
end event

type ddlb_fontheight from dropdownlistbox within w_contract_tabprop_edit
integer x = 448
integer y = 944
integer width = 562
integer height = 276
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"8","9","10","12","14","18"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ib_Modified = True
end event

event modified;ib_Modified = True

If isnumber( this.text ) Then
Else
	This.Text = '8'
End If
	
	
end event

type cbx_fixedwidth from checkbox within w_contract_tabprop_edit
integer x = 1070
integer y = 824
integer width = 535
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Tab width is fixed"
boolean checked = true
end type

event clicked;ib_Modified = true
end event

type cbx_underline from checkbox within w_contract_tabprop_edit
integer x = 1335
integer y = 956
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Underline"
end type

event clicked;ib_Modified = True
end event

type cbx_italic from checkbox within w_contract_tabprop_edit
integer x = 1070
integer y = 956
integer width = 215
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Italic"
end type

event clicked;ib_Modified = true
end event

type st_7 from statictext within w_contract_tabprop_edit
integer x = 87
integer y = 960
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Font Height:"
boolean focusrectangle = false
end type

type st_6 from statictext within w_contract_tabprop_edit
integer x = 87
integer y = 828
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Font Name:"
boolean focusrectangle = false
end type

type cb_layout_setting from commandbutton within w_contract_tabprop_edit
integer x = 571
integer y = 1100
integer width = 379
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Layout Setting "
end type

event clicked;Integer  li_rtn

//If isvalid(gw_contract) Then
//	li_rtn = Messagebox(gnv_app.iapp_object.DisplayName,"For the new design to take effect, the system will close the Contract Folder. ~r~nDo you want to continue?", Question!,YesNo!)
//	IF li_rtn = 1 Then 
//		OpenWithParm(w_contract_layout,il_data_view_id)			 
//	End IF 
//Else
	OpenWithParm(w_contract_layout,il_data_view_id)
//	OpenSheetWithParm(w_contract_layout, il_data_view_id,  w_mdi, 2, Layered!)

	parent.cb_cancel.event clicked( )
//End IF
end event

type cbx_visible from checkbox within w_contract_tabprop_edit
boolean visible = false
integer x = 1065
integer y = 104
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Visible"
boolean checked = true
end type

type cb_8 from commandbutton within w_contract_tabprop_edit
integer x = 1344
integer y = 216
integer width = 265
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Default"
end type

event clicked;String ls_icon
ls_icon = wf_get_tab_default_ico(is_tab_name)

If ls_icon <> '' Then
	p_1.picturename = ls_icon
End If
end event

type cb_7 from commandbutton within w_contract_tabprop_edit
integer x = 1061
integer y = 216
integer width = 265
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Choose..."
end type

event clicked;//Modified By Ken.Guo 03/28/2013. Support Picture Painter

String ls_icon
n_cst_dm_utils lnv_utils 
str_picture lstr_picture,lstr_picture_new

If p_1.tag <> '' Then
	ls_icon = p_1.tag
Else
	ls_icon = p_1.picturename
End If

If  isnumber(ls_icon) Then
	lstr_picture.al_pic_id = Long(ls_icon)
	lstr_picture.ab_support_picture_painter = True
Else
	lstr_picture.as_pic_file  = ls_icon
	lstr_picture.ab_support_picture_painter = True		
End If
OpenwithParm(w_icon_select,lstr_picture)
If isvalid(Message.powerobjectparm ) Then
	lstr_picture_new = Message.Powerobjectparm
	If lstr_picture_new.al_pic_id > 0 Then //User Picture Painter
		p_1.picturename = lstr_picture_new.as_pic_file
		p_1.tag = String(lstr_picture_new.al_pic_id)
	ElseIf lstr_picture_new.as_pic_file <> '' Then  //Use System Picture
		p_1.picturename =  lstr_picture_new.as_pic_file
		p_1.tag = lstr_picture_new.as_pic_file
	End If
End If



end event

type p_1 from picture within w_contract_tabprop_edit
integer x = 448
integer y = 212
integer width = 73
integer height = 64
string picturename = "AddWatch5!"
boolean focusrectangle = false
end type

type st_5 from statictext within w_contract_tabprop_edit
integer x = 87
integer y = 224
integer width = 352
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Tab page icon:"
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_contract_tabprop_edit
integer x = 1344
integer y = 552
integer width = 265
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Default"
end type

event clicked;st_backcolor.BackColor = 67108864
end event

type cb_5 from commandbutton within w_contract_tabprop_edit
integer x = 1344
integer y = 440
integer width = 265
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Default"
end type

event clicked;st_tabbackcolor.BackColor = 67108864
end event

type cb_4 from commandbutton within w_contract_tabprop_edit
integer x = 1344
integer y = 328
integer width = 265
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Default"
end type

event clicked;st_textcolor.BackColor = 33554432
end event

type cb_3 from commandbutton within w_contract_tabprop_edit
integer x = 1061
integer y = 552
integer width = 265
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Choose..."
end type

event clicked;of_ChooseColor(st_backcolor)
end event

type st_backcolor from statictext within w_contract_tabprop_edit
integer x = 448
integer y = 564
integer width = 562
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_contract_tabprop_edit
integer x = 87
integer y = 568
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Back Color:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_contract_tabprop_edit
integer x = 1061
integer y = 440
integer width = 265
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Choose..."
end type

event clicked;of_ChooseColor(st_tabbackcolor)
end event

type st_tabbackcolor from statictext within w_contract_tabprop_edit
integer x = 448
integer y = 452
integer width = 562
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type st_3 from statictext within w_contract_tabprop_edit
integer x = 87
integer y = 456
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Tab Back Color:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_contract_tabprop_edit
integer x = 1061
integer y = 328
integer width = 265
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Choose..."
end type

event clicked;of_ChooseColor(st_textcolor)
end event

type st_textcolor from statictext within w_contract_tabprop_edit
integer x = 448
integer y = 340
integer width = 562
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33554432
boolean border = true
boolean focusrectangle = false
end type

type cbx_icon from checkbox within w_contract_tabprop_edit
integer x = 617
integer y = 220
integer width = 384
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Show "
boolean checked = true
end type

type st_2 from statictext within w_contract_tabprop_edit
integer x = 87
integer y = 344
integer width = 256
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Text Color:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_contract_tabprop_edit
integer x = 87
integer y = 112
integer width = 256
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Text:"
boolean focusrectangle = false
end type

type sle_text from singlelineedit within w_contract_tabprop_edit
integer x = 448
integer y = 92
integer width = 562
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_contract_tabprop_edit
integer x = 1349
integer y = 1100
integer width = 343
integer height = 92
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_contract_tabprop_edit
integer x = 978
integer y = 1100
integer width = 343
integer height = 92
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;string  ls_text
long    ll_text_color
long    ll_backcolor
long    ll_tab_backcolor
string  ls_icon_visible = "F",ls_icon
string ls_tab_visible = 'F'

String	ls_FontName, ls_Italic='F', ls_Underline='F', ls_fixedwidth='F'
Long	ll_Font_height

// Get properties value
ls_text = sle_text.Text
ll_text_color = st_textcolor.BackColor
ll_backcolor = st_backcolor.BackColor
ll_tab_backcolor = st_tabbackcolor.BackColor
if cbx_icon.Checked then ls_icon_visible = "T"
if cbx_visible.checked then ls_tab_visible = 'T'


ls_FontName = ddlb_fontname.Text //added by gavins 20130415
If cbx_italic.checked Then ls_Italic = 'T'
If cbx_underline.checked Then ls_underline = 'T'
If cbx_fixedwidth.checked Then ls_fixedwidth = 'T'
ll_Font_height = long( ddlb_fontheight.Text )

If ib_Modified Then
	If ll_Font_height = 0 Or isnull( ll_Font_height ) Then ll_Font_height = 8
	If trim(ls_FontName) = '' or isnull(ls_FontName) Then ls_FontName = 'Segoe UI'
	gnv_user_option.of_set_viewid_option_value( il_data_view_id, 'View_Tab_Font_Name_Properties' ,ls_FontName )
	gnv_user_option.of_set_viewid_option_value( il_data_view_id, 'View_Tab_Font_Italic_Properties' ,ls_Italic )
	gnv_user_option.of_set_viewid_option_value( il_data_view_id, 'View_Tab_Font_Underline_Properties' ,ls_underline )
	gnv_user_option.of_set_viewid_option_value( il_data_view_id, 'View_Tab_Font_Height_Properties' ,string( ll_Font_height)  )
	gnv_user_option.of_set_viewid_option_value( il_data_view_id, 'View_Tab_Fixed_Width_Properties' ,ls_fixedwidth )
End If


If p_1.tag <> '' Then
	ls_icon = p_1.tag
Else
	ls_icon = p_1.picturename 
End If

// Save properties value to database
if ib_Exists then
	UPDATE ctx_tabpage_properties SET
	       text = :ls_text,
			 text_color = :ll_text_color,
			 icon_visible = :ls_icon_visible,
			 backcolor = :ll_backcolor,
			 tab_backcolor = :ll_tab_backcolor,
			 tab_icon = :ls_icon,
			 tab_visible = :ls_tab_visible
	WHERE data_view_id = :il_data_view_id AND tabpage_name = :is_tab_name;
else
	INSERT INTO ctx_tabpage_properties(data_view_id, tabpage_name, text, text_color, icon_visible, backcolor, tab_backcolor,tab_icon,tab_visible)
	       VALUES(:il_data_view_id, :is_tab_name, :ls_text, :ll_text_color, :ls_icon_visible, :ll_backcolor, :ll_tab_backcolor, :ls_icon,:ls_tab_visible);
end if

// Close window
if SQLCA.SQLCode < 0 then
	gnv_debug.of_output( True, 'Failed to save tab properties. ' + sqlca.sqlerrtext )
	MessageBox("Error", "Failed to update.", StopSign!);
else
	
	COMMIT;
	is_Return = ls_text + "|" + String(ll_text_color) + "|" + ls_icon_visible
	//Begin - Added By Mark Lee 08/23/12
	If IsValid( gw_contract ) Then //modified by gavins 20121022   if gw_contract is not open then  it must valid !
		If isvalid(gw_contract.ids_tabpage_prop) Then
			gw_contract.ids_tabpage_prop.settransobject( sqlca)
			gw_contract.ids_tabpage_prop.reset( )
			gw_contract.ids_tabpage_prop.retrieve( )
		End If
	End If
	//End - Added By Mark Lee 08/23/12
	Close(Parent)	
end if
end event

type gb_1 from groupbox within w_contract_tabprop_edit
integer x = 46
integer y = 20
integer width = 1641
integer height = 652
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Tab Page Properties Setting"
end type

type ddlb_fontname from dropdownlistbox within w_contract_tabprop_edit
integer x = 448
integer y = 812
integer width = 562
integer height = 408
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ib_Modified = True
end event

event modified;ib_Modified = True
end event

event constructor;String ls_fonts[]
int i,j
n_cst_appeondll lnv_appeon_dll



lnv_appeon_dll.of_getfonts(ls_fonts)

For i = 1 To UpperBound(ls_fonts[])
	If Trim(ls_fonts[i]) = '' Then Continue
	If i > 1 Then
		If ls_fonts[i - 1] = ls_fonts[i] Then Continue
	End If
	ddlb_fontname.additem(ls_fonts[i])
Next

If ddlb_fontname.TotalItems() = 0 Then
	ddlb_fontname.addItem('Segoe UI')
End If

ddlb_fontname.Additem( "")
end event

type gb_2 from groupbox within w_contract_tabprop_edit
integer x = 46
integer y = 716
integer width = 1641
integer height = 348
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Tab Properties Setting ( All tab pages share the following settings. )"
end type

