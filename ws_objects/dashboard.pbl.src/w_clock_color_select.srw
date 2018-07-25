$PBExportHeader$w_clock_color_select.srw
forward
global type w_clock_color_select from window
end type
type cb_default from commandbutton within w_clock_color_select
end type
type sle_name from singlelineedit within w_clock_color_select
end type
type st_1 from statictext within w_clock_color_select
end type
type cb_apply from commandbutton within w_clock_color_select
end type
type cb_cancel from commandbutton within w_clock_color_select
end type
type cb_ok from commandbutton within w_clock_color_select
end type
type dw_1 from datawindow within w_clock_color_select
end type
type gb_1 from groupbox within w_clock_color_select
end type
end forward

global type w_clock_color_select from window
integer width = 1097
integer height = 852
boolean titlebar = true
string title = "Clock Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_default cb_default
sle_name sle_name
st_1 st_1
cb_apply cb_apply
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
gb_1 gb_1
end type
global w_clock_color_select w_clock_color_select

type variables
Str_clock_color istr_clock_color
Integer ii_color_id
end variables

forward prototypes
public function integer of_set_layout (integer al_color_control_id)
public function integer of_set_color_painter ()
end prototypes

public function integer of_set_layout (integer al_color_control_id);Integer i,li_color_cnt
Long ll_x,ll_y 
//Modify("<Textname>.Border='<0 - None, 1- Shadow, 2 - Box, 3 - Resize, 4 - Underline, 5 - 3D Lowered, 6 - 3D Raised>'")

li_color_cnt = UpperBound(istr_clock_color.l_color_value[])
For i = 1 to li_color_cnt
	dw_1.Modify("t_color_"+string(i)+".Border='0'")		
Next

If al_color_control_id < 1 Then Return 1

//Set current to Lowered
dw_1.Modify("t_color_"+string(al_color_control_id)+".Border='5'")	
ll_x = Long(dw_1.Describe("t_color_"+string(al_color_control_id)+".x"))
ll_y = Long(dw_1.Describe("t_color_"+string(al_color_control_id)+".y"))

dw_1.Modify("r_border.visible = '1'")	
dw_1.Modify("r_border.x = '" +String(ll_x - 18)+"'")	
dw_1.Modify("r_border.y = '" +String(ll_y - 16)+"'")	
Return 1


end function

public function integer of_set_color_painter ();Integer li_color_cnt,i
li_color_cnt = UpperBound(istr_clock_color.l_color_value[])
//Modify("<Textname>.Background.Color='<a long>'")

For i = 1 to li_color_cnt
	dw_1.Modify("t_color_"+String(i)+".Background.Color='"+String(istr_clock_color.l_color_value[i])+"'")
Next
Return 1
end function

on w_clock_color_select.create
this.cb_default=create cb_default
this.sle_name=create sle_name
this.st_1=create st_1
this.cb_apply=create cb_apply
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_default,&
this.sle_name,&
this.st_1,&
this.cb_apply,&
this.cb_cancel,&
this.cb_ok,&
this.dw_1,&
this.gb_1}
end on

on w_clock_color_select.destroy
destroy(this.cb_default)
destroy(this.sle_name)
destroy(this.st_1)
destroy(this.cb_apply)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;istr_clock_color = Message.Powerobjectparm 
If UpperBound(istr_clock_color.l_color_value[]) < 1 Then
	Messagebox('Error','Failed to load color list, please call support.')
	Return 1
End If

This.Title = istr_clock_color.uo_gadget_clock.istr_current_gadget.gadget_title + ' Settings'
sle_name.text = istr_clock_color.uo_gadget_clock.istr_current_gadget.gadget_title

ii_color_id = istr_clock_color.i_color_id

of_set_color_painter()

of_set_layout(istr_clock_color.i_color_id)
end event

type cb_default from commandbutton within w_clock_color_select
integer x = 695
integer y = 612
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Default"
end type

event clicked;String ls_name

Select gadget_title Into :ls_name From dashboard_gadgets where gadget_id = :istr_clock_color.uo_gadget_clock.istr_current_gadget.gadget_id ;

If ls_name <> '' and not isnull(ls_name) Then
	sle_name.text = ls_name
End IF

ii_color_id = 5
of_set_layout(ii_color_id)	


end event

type sle_name from singlelineedit within w_clock_color_select
integer x = 101
integer y = 36
integer width = 539
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

type st_1 from statictext within w_clock_color_select
integer y = 48
integer width = 114
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Title"
boolean focusrectangle = false
end type

type cb_apply from commandbutton within w_clock_color_select
integer x = 695
integer y = 260
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Apply"
end type

event clicked;Integer li_ret

If sle_name.text = '' Then
	Messagebox('Title','Please input the title.')
	sle_name.setfocus()
	Return -1
End If

If istr_clock_color.uo_gadget_clock.of_save_other_property_value(istr_clock_color.uo_gadget_clock.const_title , sle_name.text) > 0 Then
	istr_clock_color.uo_gadget_clock.of_set_other_properties( )
End If

If ii_color_id = istr_clock_color.i_color_id Then Return 1

istr_clock_color.uo_gadget_clock.of_change_face(ii_color_id)

li_ret = istr_clock_color.uo_gadget_clock.iuo_tabpge_gadget.of_update_clock_to_db(ii_color_id )
If li_ret > 0 Then
	istr_clock_color.i_color_id = ii_color_id
Else
	Messagebox('Save Error '+ String(li_ret),'Failed to save the settings to DB, please call support.')
	istr_clock_color.uo_gadget_clock.of_change_face(istr_clock_color.i_color_id)
	Return -1
End If

Return 1
end event

type cb_cancel from commandbutton within w_clock_color_select
integer x = 695
integer y = 148
integer width = 343
integer height = 92
integer taborder = 40
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

type cb_ok from commandbutton within w_clock_color_select
integer x = 695
integer y = 40
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;/*
istr_clock_color.i_color_id = ii_color_id
ClosewithReturn(Parent,istr_clock_color)
*/


If cb_apply.Event clicked() > 0 Then
	Close(Parent)
End If

end event

type dw_1 from datawindow within w_clock_color_select
integer x = 32
integer y = 224
integer width = 594
integer height = 492
integer taborder = 20
string title = "none"
string dataobject = "d_clock_color_selected"
boolean border = false
boolean livescroll = true
end type

event clicked;Integer i

//Modify("<Textname>.Border='<0 - None, 1- Shadow, 2 - Box, 3 - Resize, 4 - Underline, 5 - 3D Lowered, 6 - 3D Raised>'")
//0 - None, 1- Shadow, 2 - Box, 3 - Resize, 
//4 - Underline, 5 - 3D Lowered, 6 - 3D Raised

If Pos(dwo.name,'t_color_',1) > 0 Then 
	//Get color id
	ii_color_id = Integer(Mid(dwo.name,9,2))
	//Set layout
	of_set_layout(ii_color_id)	
End If




end event

event constructor;dw_1.InsertRow(0)
end event

type gb_1 from groupbox within w_clock_color_select
integer x = 18
integer y = 172
integer width = 622
integer height = 556
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Select Colors"
end type

