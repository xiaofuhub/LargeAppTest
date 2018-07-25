$PBExportHeader$u_cst_gadget.sru
forward
global type u_cst_gadget from userobject
end type
type dw_content from u_dw within u_cst_gadget
end type
type ln_split from line within u_cst_gadget
end type
type st_1 from statictext within u_cst_gadget
end type
type st_title from statictext within u_cst_gadget
end type
type pb_close from picturebutton within u_cst_gadget
end type
type pb_max from picturebutton within u_cst_gadget
end type
type pb_edit from picturebutton within u_cst_gadget
end type
end forward

global type u_cst_gadget from userobject
string tag = "u_gadget_"
integer width = 1248
integer height = 672
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_resize_ini ( )
event ue_max ( )
event ue_min ( )
event ue_resize ( )
event resize pbm_size
event ue_retrieve ( )
event type integer ue_do ( )
event ue_close ( )
event type integer ue_save ( )
event type integer ue_run ( long al_row )
dw_content dw_content
ln_split ln_split
st_1 st_1
st_title st_title
pb_close pb_close
pb_max pb_max
pb_edit pb_edit
end type
global u_cst_gadget u_cst_gadget

type variables


Long il_pointerX_ini, il_pointerY_ini
Boolean ib_buttondown = False , ib_from_title = False
u_cst_tabpg_gadget iuo_tabpge_gadget 
n_ds ids_other_properties
Long il_tab_id

Long il_fixed_height = 0
str_gadget istr_current_gadget

Boolean ib_visible_status = False

Integer il_edit_visible = 0

String is_title

Public:
//For All
CONSTANT String CONST_TITLE = 'title'
CONSTANT String CONST_TITLE_COLOR = 'title_bg_color'
CONSTANT String CONST_ROWS_NUMBER = 'rows_number'
CONSTANT String CONST_MAXIMIZE = 'maximize'
CONSTANT String CONST_BG_COLOR = 'bg_color'
CONSTANT String CONST_TITLE_FONT_FACE = 'title_font_face'
CONSTANT String CONST_TITLE_FONT_SIZE = 'title_font_size'
CONSTANT String CONST_TITLE_FONT_COLOR = 'title_font_color'

//For Contract Template Gadget
CONSTANT String CONST_DISPLAY_CREATEBY = 'display_create_by'
CONSTANT String CONST_DISPLAY_CREATEDATE = 'display_create_date'

end variables

forward prototypes
public subroutine of_set_pointer_pos (long al_x, long al_y)
public subroutine of_release_button ()
public function integer of_set_property (string as_property_name, string as_value)
public function integer of_set_property (string as_property_name, long al_value)
public function integer of_set_properties ()
public function integer of_set_row_number (integer al_row_number)
public function integer of_update_to_db ()
public function integer of_settings ()
public subroutine of_set_bg_color (long al_color_value)
public function integer of_edit_visible ()
public subroutine of_edit_visible (integer ai_value)
public subroutine of_set_title (string as_title)
public function integer of_set_other_properties ()
public function string of_get_other_property_value (string as_property_name)
public function integer of_save_other_property_value (string as_property_name, string as_property_value)
public function integer of_save_other_property_value (string as_property_name[], string as_property_value[])
end prototypes

event ue_resize_ini();//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget::ue_resize_ini()
// $<arguments>
//		None		
// $<returns> (None)
// $<description> Resize control[] in this gadget.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int li_width,li_space
li_width = pb_close.width
li_space = 20

st_title.width = This.Width + 100
st_1.width = st_title.Width
st_1.y = 0
st_1.x = 0
ln_split.EndX = st_title.width

pb_close.x = This.width - li_width - li_space
pb_max.x = pb_close.x - li_width - li_space
pb_edit.x = pb_max.x - li_width + 1

dw_content.x = 0
dw_content.y = st_title.y + st_title.height + 5
dw_content.width = This.width - 5 




end event

event ue_max();//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget::ue_max()
// $<arguments>
//		None		
// $<returns> (None)
// $<description> Maximize current gedget.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If istr_current_gadget.gadget_rows_number = 0 Then
	If istr_current_gadget.adec_height_ier = 0 Then istr_current_gadget.adec_height_ier = 1
	This.Height = il_fixed_height * istr_current_gadget.adec_height_ier
	dw_content.Height = This.Height - dw_content.y - 14
Else
	This.Height = dw_content.y + dw_content.Height + 14
End If
istr_current_gadget.gadget_maximize = 1
pb_max.Powertiptext = 'Minimize'
pb_max.picturename = "AlignTop!"
end event

event ue_min();//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget::ue_min()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description> Minimize Current Gadget
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

This.Height = st_title.y + st_title.height + 8
istr_current_gadget.gadget_maximize = 0
pb_max.Powertiptext = 'Restore'
pb_max.picturename = "AlignBottom!"
end event

event ue_resize();//////////////////////////////////////////////////////////////////////
// $<event>ue_resizeu_cst_gadget()
// $<arguments>
//		None		
// $<returns> (None)
// $<description> Max or Min current gadget 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////


If istr_current_gadget.gadget_maximize = 0 then
	Event ue_min()
Else
	Event ue_max()
End If

end event

event resize;
//Get fixed height on first event.
If il_fixed_height = 0 Then
	il_fixed_height = This.Height
End If

//Resize
Trigger Event ue_resize_ini()

end event

event ue_retrieve();If dw_content.dataobject <> '' Then
	dw_content.retrieve(gs_user_id,iuo_tabpge_gadget.istr_current_tab.sl_tab_id)
	//dw_content.SetFocus()  //Delete by Ken.Guo 2009-01-04
End If

end event

event type integer ue_do();Return 1
end event

event ue_close();//
end event

event type integer ue_save();Return 1
end event

event type integer ue_run(long al_row);//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget::ue_run()
// $<arguments>
//		value	long	al_row, dw_content row number.		
// $<returns> 
// $<description>
// $<description> When clicked a row on dw_content, then execute it.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-12 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Return 1
end event

public subroutine of_set_pointer_pos (long al_x, long al_y);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadgetof_set_pointer_pos()
// $<arguments>
//		value	long	al_x		
//		value	long	al_y		
// $<returns> (none)
// $<description>
// $<description> Set INI value for mouse's position
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

 il_pointerX_ini = al_x
 il_pointerY_ini = al_y
end subroutine

public subroutine of_release_button ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget::of_release_button()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Reset status flag when release mouse left button
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

ib_buttondown = False 
ib_from_title = False
end subroutine

public function integer of_set_property (string as_property_name, string as_value);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget::of_set_property()
// $<arguments>
//		value	string	as_property_name		
//		value	string	as_value        		
// $<returns> integer
// $<description>  Set Gadget's property.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If Isnull(as_value) Then Return 1
Choose Case Upper(as_property_name)
	Case Upper(CONST_TITLE)
		st_title.text = ' ' + as_value + ' '
		istr_current_gadget.gadget_title = as_value
	Case Upper(CONST_TITLE_FONT_FACE)
		If as_value = '' Then as_value = 'MS Sans Serif'
		st_title.facename = as_value
	Case ''
		
	Case Else
		Return -100
End Choose
Return 1


end function

public function integer of_set_property (string as_property_name, long al_value);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadgetof_set_property()
// $<arguments>
//		value	string	as_property_name		
//		value	long  	al_value        		
// $<returns> integer
// $<description>
// $<description> Set Gadget's property.
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If isnull(al_value) Then Return 1
Choose Case Upper(as_property_name)
	Case Upper(CONST_TITLE_COLOR)
		st_title.backcolor = al_value
		st_1.backcolor = al_value
	Case Upper(CONST_ROWS_NUMBER)
		of_set_row_number(al_value)
		istr_current_gadget.gadget_rows_number = al_value
	Case Upper(CONST_MAXIMIZE)
		If al_value = 0 Then
			Event ue_min()
		Else
			Event ue_max()
		End If
	Case Upper(CONST_BG_COLOR)
		dw_content.Modify("Datawindow.Color='"+String(al_value)+"'")
		This.backcolor = al_value
		of_set_bg_color(al_value) //For other objects.
	Case Upper(CONST_TITLE_FONT_SIZE)
		If al_value = 0 or isnull(al_value) Then al_value = 10
		st_title.textsize = al_value
	Case Upper(CONST_TITLE_FONT_COLOR)
		If isnull(al_value) Then al_value = 0
		st_title.textcolor = al_value
	Case Else
		Return -100
End Choose
Return 1


end function

public function integer of_set_properties ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadgetof_set_properties()
// $<arguments>(None)
// $<returns> integer
// $<description> Set All properties for current gadget
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If is_title = '' Then
	of_set_property(CONST_TITLE,istr_current_gadget.gadget_title)
Else
	of_set_property(CONST_TITLE,is_title)
End If

of_set_other_properties()

of_set_property(CONST_ROWS_NUMBER,istr_current_gadget.gadget_rows_number )
of_set_property(CONST_MAXIMIZE,istr_current_gadget.gadget_maximize )
of_set_property(CONST_TITLE_COLOR,iuo_tabpge_gadget.istr_current_tab.sl_gadget_title_bg_color)
of_set_property(CONST_BG_COLOR,iuo_tabpge_gadget.istr_current_tab.sl_gadget_bg_color)

of_set_property(CONST_TITLE_FONT_FACE,iuo_tabpge_gadget.istr_current_tab.ss_gadget_title_font_face )
of_set_property(CONST_TITLE_FONT_SIZE,iuo_tabpge_gadget.istr_current_tab.si_gadget_title_font_size )
of_set_property(CONST_TITLE_FONT_COLOR,iuo_tabpge_gadget.istr_current_tab.sl_gadget_title_font_color )




Return 1
end function

public function integer of_set_row_number (integer al_row_number);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadgetof_set_row_number()
// $<arguments>
//		value	integer	al_row_number		
// $<returns> integer
// $<description>
// $<description> Set current gadget's height with al_row_number argument.
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_height_datawindow
Long ll_header_height
Long ll_detail_height
Long ll_summery_height
Long ll_foot_height
Long ll_quotiety
Long ll_cnt

//If al_row_number = 0 Then 
//	If of_edit_visible() = 1 Then 
//		pb_edit.visible = True
//	Else
//		pb_edit.visible = False
//	End If
//	Return 0   //Fixed height for gadget.
//Else
//	pb_edit.visible = True	
//End If
pb_edit.visible = True	

If Not Isvalid(dw_content) Then Return 0
If dw_content.Dataobject = '' Then Return 0

If dw_content.hscrollbar = True Then
	ll_quotiety = 100
Else
	ll_quotiety = 14
End If
If dw_content.titlebar = True Then ll_quotiety = ll_quotiety + 100


//Get datawindow's band height
ll_header_height = Long(dw_content.Describe("DataWindow.Header.Height"))
ll_detail_height = Long(dw_content.Describe("DataWindow.Detail.Height"))
ll_summery_height = Long(dw_content.Describe("DataWindow.Summary.Height"))
ll_foot_height = Long(dw_content.Describe("DataWindow.Footer.Height"))

//Set datawindow's height. //Ignore group datawindow.
ll_cnt = dw_content.RowCount()
If ll_cnt = 0 Then ll_cnt = 1
If ll_cnt <= al_row_number Then
	ll_height_datawindow = ll_header_height + ll_detail_height * ll_cnt &
								+ 1.5*ll_summery_height + ll_foot_height  + ll_quotiety
Else
	ll_height_datawindow = ll_header_height + ll_detail_height * al_row_number &
								 + ll_foot_height  + ll_quotiety	
End If
dw_content.Height = ll_height_datawindow	

This.Height = dw_content.y + ll_height_datawindow + 14

Return This.Height

end function

public function integer of_update_to_db ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadgetof_update_to_db()
// $<arguments>(None)
// $<returns> integer
// $<description> Update current gadget's property to DB
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_ret 
li_ret = iuo_tabpge_gadget.of_update_from_gadget(istr_current_gadget)
If li_ret < 0 Then
	Messagebox('Save Error','Failed to save the changes for the gadget.')
End If
Return li_ret

end function

public function integer of_settings ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget::of_settings()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>Open gadget's Settings window
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-06 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Str_gadget lstr_gadget

//Open Settings window
//OpenwithParm(w_dashboard_gadget_config,istr_current_gadget)
OpenwithParm(w_dashboard_gadget_config,This)
lstr_gadget = Message.powerobjectparm

//No changes
If lstr_gadget = istr_current_gadget Then Return 1

//Apply the changes
istr_current_gadget = lstr_gadget
of_set_properties()
of_update_to_db()
iuo_tabpge_gadget.of_refresh_ui()

Return 1
end function

public subroutine of_set_bg_color (long al_color_value);//Set other objects' BG color.
end subroutine

public function integer of_edit_visible ();Return il_edit_visible
end function

public subroutine of_edit_visible (integer ai_value);il_edit_visible = ai_value
end subroutine

public subroutine of_set_title (string as_title);is_title = as_title
of_set_property(CONST_TITLE,is_title)

end subroutine

public function integer of_set_other_properties ();long ll_find
String ls_title

ls_title = of_get_other_property_value(CONST_TITLE)
If ls_title <> '' and Not isnull(ls_title) Then
	of_set_property(CONST_TITLE,ls_title)
End If

Return 1
end function

public function string of_get_other_property_value (string as_property_name);long ll_find
String ls_value
If isvalid(ids_other_properties) Then
	ll_find = ids_other_properties.find('tab_id = '+String(iuo_tabpge_gadget.istr_current_tab.sl_tab_id) +&
													' and gadget_id = '+String(istr_current_gadget.gadget_id) +&
													' and property_name = "'+as_property_name+'" ',1,ids_other_properties.rowcount())
	If ll_find > 0 Then
		ls_value = ids_other_properties.GetItemString(ll_find,'property_value')
		If ls_value <> '' and Not isnull(ls_value) Then
			Return ls_value
		End If
	End If
End If

Return ''
end function

public function integer of_save_other_property_value (string as_property_name, string as_property_value);String ls_name[],ls_value[]
ls_name[1] =  as_property_name
ls_value[1] = as_property_value
Return of_save_other_property_value(ls_name[],ls_value[])

end function

public function integer of_save_other_property_value (string as_property_name[], string as_property_value[]);long ll_find,i
String ls_value
If Not isvalid(ids_other_properties) Then Return -1

For i = 1 To UpperBound(as_property_name[])
	If as_property_name[i] = CONST_TITLE and as_property_value[i] = '' Then Continue
	
	ll_find = ids_other_properties.find('tab_id = '+String(iuo_tabpge_gadget.istr_current_tab.sl_tab_id) +&
													' and gadget_id = '+String(istr_current_gadget.gadget_id) +&
													' and property_name = "'+as_property_name[i]+'" ',1,ids_other_properties.rowcount())
													
	If ll_find > 0 Then
		ls_value = ids_other_properties.GetItemString(ll_find,'property_value')
		If ls_value = as_property_value[i] Then Continue
		ids_other_properties.SetITem(ll_find,'property_value',as_property_value[i])
	Else
		ll_find = ids_other_properties.InsertRow(0)
		ids_other_properties.SetItem(ll_find,'user_id',gs_user_id)
		ids_other_properties.SetItem(ll_find,'tab_id',iuo_tabpge_gadget.istr_current_tab.sl_tab_id)
		ids_other_properties.SetItem(ll_find,'gadget_id',istr_current_gadget.gadget_id)
		ids_other_properties.SetItem(ll_find,'property_name',as_property_name[i])
		ids_other_properties.SetItem(ll_find,'property_value',as_property_value[i])
	End If
Next


If ids_other_properties.modifiedcount( ) > 0 Then
	If ids_other_properties.update() = 1 Then
		Commit;
	Else
		Rollback;
		Messagebox('Save Error','Failed to save the changes, please call support.')
		ids_other_properties.Retrieve(gs_user_id)
		Return -1
	End If
End If

Return 1
end function

on u_cst_gadget.create
this.dw_content=create dw_content
this.ln_split=create ln_split
this.st_1=create st_1
this.st_title=create st_title
this.pb_close=create pb_close
this.pb_max=create pb_max
this.pb_edit=create pb_edit
this.Control[]={this.dw_content,&
this.ln_split,&
this.st_1,&
this.st_title,&
this.pb_close,&
this.pb_max,&
this.pb_edit}
end on

on u_cst_gadget.destroy
destroy(this.dw_content)
destroy(this.ln_split)
destroy(this.st_1)
destroy(this.st_title)
destroy(this.pb_close)
destroy(this.pb_max)
destroy(this.pb_edit)
end on

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget::Constructor()
// $<arguments>(None)
// $<returns> (none)
// $<description> INI and Resize gadget.
// $<description> This object only place in u_cst_tabpg_gadget.
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(3)

iuo_tabpge_gadget = GetParent()
ids_other_properties = w_dashboard.inv_dashboard.ids_dashboard_other_properties

//Get fixed height on first event.
If il_fixed_height = 0 Then
	il_fixed_height = This.Height
End If

//Set gadget's Max/Min Status
//Post Event ue_resize() 
end event

type dw_content from u_dw within u_cst_gadget
integer x = 5
integer y = 100
integer width = 1234
integer height = 380
integer taborder = 40
boolean border = false
borderstyle borderstyle = stylebox!
end type

event resize;call super::resize;//Parent.Trigger Event ue_resize()
end event

event constructor;call super::constructor;This.SetTransObject(SQLCA)

end event

event clicked;call super::clicked;If Row > 0 Then
	If iuo_tabpge_gadget.istr_current_tab.si_single_double_clk = 1 Then
		Trigger Event ue_run(row)
	End If
End If
end event

event doubleclicked;call super::doubleclicked;If Row > 0 Then
	If iuo_tabpge_gadget.istr_current_tab.si_single_double_clk = 2 Then
		Trigger Event ue_run(row)
	End If
End If
end event

type ln_split from line within u_cst_gadget
long linecolor = 33554432
integer linethickness = 4
integer beginy = 80
integer endx = 2002
integer endy = 80
end type

type st_1 from statictext within u_cst_gadget
integer width = 2002
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_title from statictext within u_cst_gadget
event lbuttondown pbm_lbuttondown
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
integer y = 8
integer width = 2002
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "Size!"
long textcolor = 33554432
long backcolor = 12632256
string text = "Title"
boolean focusrectangle = false
end type

event lbuttondown;//////////////////////////////////////////////////////////////////////
// $<event>st_title::lbuttondown()
// $<arguments>
//		value	unsignedlong	flags		
//		value	integer     	xpos 		
//		value	integer     	ypos 		
// $<returns> long
// $<description> Only mouse button down on st_title, Gadget can be moved.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////


If iuo_tabpge_gadget.istr_current_tab.si_tab_locked = 1 Then
	//Workaround for web's bug
	SetPointer(Arrow!)
End If

If iuo_tabpge_gadget.istr_current_tab.si_tab_locked = 1 Then Return
	
ib_from_title = True
ib_buttondown = true
iuo_tabpge_gadget.Dynamic Event ue_buttondown(Parent)
end event

event mousemove;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadgetControl List()
// $<arguments>
//		value	unsignedlong	flags		
//		value	integer     	xpos 		
//		value	integer     	ypos 		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If iuo_tabpge_gadget.istr_current_tab.si_tab_locked = 1 Then
	SetPointer(Arrow!)
	Return
Else
	If This.Pointer <> 'Size!' Then
		SetPointer(Size!)
	End If
End If

If ib_buttondown Then
	iuo_tabpge_gadget.Dynamic Event ue_mousemove()
End If

end event

event lbuttonup;//////////////////////////////////////////////////////////////////////
// $<event>lbuttonupst_title()
// $<arguments>
//		value	unsignedlong	flags		
//		value	integer     	xpos 		
//		value	integer     	ypos 		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If iuo_tabpge_gadget.istr_current_tab.si_tab_locked = 1 Then Return

ib_buttondown = false
iuo_tabpge_gadget.Dynamic Event ue_buttonup()
end event

type pb_close from picturebutton within u_cst_gadget
integer x = 1152
integer y = 8
integer width = 82
integer height = 68
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Close!"
alignment htextalign = left!
string powertiptext = "Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event>u_cst_gadget::Clicked()
// $<arguments>(None)
// $<returns> (none)
// $<description>	Hide(Close) this gadget.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If iuo_tabpge_gadget.istr_current_tab.si_tab_locked = 1 Then
	Messagebox('Delete','Gadget cannot be deleted from LOCKED tab. '+&
	'~r~nIf you want to delete a gadget, please unlock the current tab first.')
	Return 1
End If

Parent.hide()
iuo_tabpge_gadget.of_delete_gadget(Integer(Mid(Parent.Classname(),10)))
iuo_tabpge_gadget.of_refresh_ui()
end event

type pb_max from picturebutton within u_cst_gadget
integer x = 1061
integer y = 8
integer width = 82
integer height = 68
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
alignment htextalign = left!
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget::Clicked()
// $<arguments>(None)
// $<returns> (none)
// $<description> Maximize or Minimize gadget. Switch the status.
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Switch the status
If istr_current_gadget.gadget_maximize = 0 Then
	istr_current_gadget.gadget_maximize = 1
Else
	istr_current_gadget.gadget_maximize = 0
End If
If of_update_to_db() > 0 Then
	iuo_tabpge_gadget.of_refresh_ui()
End If

end event

type pb_edit from picturebutton within u_cst_gadget
string tag = "MultiLineEdit!"
integer x = 974
integer y = 8
integer width = 82
integer height = 68
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "test"
string picturename = "MultiLineEdit!"
string disabledname = "MultiLineEdit!"
alignment htextalign = left!
vtextalign vtextalign = top!
string powertiptext = "Edit"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>pb_edit::clicked()
// $<arguments>(None)
// $<returns> long
// $<description> Open gadget's Settings window
//////////////////////////////////////////////////////////////////////
// $<add> 31/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

m_dashboard_gadget lm_gadget
lm_gadget = Create m_dashboard_gadget
lm_gadget.popmenu( w_mdi.PointerX(),w_mdi.PointerY())
//of_settings()


end event

event getfocus;iuo_tabpge_gadget.iuo_current_gadget = Parent
end event

