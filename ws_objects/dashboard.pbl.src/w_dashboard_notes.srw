$PBExportHeader$w_dashboard_notes.srw
$PBExportComments$Notes tips window
forward
global type w_dashboard_notes from window
end type
type st_nwse from statictext within w_dashboard_notes
end type
type st_ns from statictext within w_dashboard_notes
end type
type r_area from rectangle within w_dashboard_notes
end type
type st_we from statictext within w_dashboard_notes
end type
type mle_note from multilineedit within w_dashboard_notes
end type
type sle_focus from singlelineedit within w_dashboard_notes
end type
end forward

global type w_dashboard_notes from window
integer width = 448
integer height = 136
boolean border = false
windowtype windowtype = child!
long backcolor = 65535
string icon = "AppIcon!"
event lost_focus pbm_killfocus
event ue_delete ( )
event type integer ue_save ( )
event ue_hide ( )
st_nwse st_nwse
st_ns st_ns
r_area r_area
st_we st_we
mle_note mle_note
sle_focus sle_focus
end type
global w_dashboard_notes w_dashboard_notes

type prototypes

end prototypes

type variables
//For note window move
boolean ib_mousedown = False  
Long il_pointerX_ini,il_pointerY_ini

//For note window resize
Boolean ib_mouse_down_border = False 
Long il_pointerX_ini_border,il_pointerY_ini_border

//For note window property
Long il_default_back_color =  RGB(255,255,128)  //Default color

Str_notes istr_notes



end variables

forward prototypes
public subroutine of_set_back_color (long al_rgb)
public function integer of_set_properties ()
public function integer of_edit_on ()
public subroutine of_set_font ()
end prototypes

event ue_delete();//////////////////////////////////////////////////////////////////////
// $<event>ue_closew_dashboard_notes()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description> Close the note 
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_find_row
If isvalid(istr_notes.sdw_note_list) Then
	ll_find_row = istr_notes.sdw_note_list.Find('id = '+String(istr_notes.sl_note_id),1,istr_notes.sdw_note_list.RowCount())
	If ll_find_row < 1 Then Return 
	istr_notes.sdw_note_list.Dynamic Post Event ue_delete(ll_find_row)
End If
	
end event

event type integer ue_save();//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard_notesControl List()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Save all data for note
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_find_row
Integer li_hide

ll_find_row = istr_notes.sdw_note_list.Find('id = '+String(istr_notes.sl_note_id),1,istr_notes.sdw_note_list.RowCount())
If ll_find_row < 1 Then Return -1

If istr_notes.sdw_note_list.GetItemString(ll_find_row,'notes') <> mle_note.text Then
	istr_notes.sdw_note_list.SetItem(ll_find_row,'notes',mle_note.text)
End If

If istr_notes.sdw_note_list.GetItemNumber(ll_find_row,'notes_x') <> This.x Then
	istr_notes.sdw_note_list.SetItem(ll_find_row,'notes_x',This.x)
End If

If istr_notes.sdw_note_list.GetItemNumber(ll_find_row,'notes_y') <> This.y Then
	istr_notes.sdw_note_list.SetItem(ll_find_row,'notes_y',This.y)
End If

If istr_notes.sdw_note_list.GetItemNumber(ll_find_row,'notes_width') <> This.width Then
	istr_notes.sdw_note_list.SetItem(ll_find_row,'notes_width',This.width)
End If

If istr_notes.sdw_note_list.GetItemNumber(ll_find_row,'notes_height') <> This.height Then
	istr_notes.sdw_note_list.SetItem(ll_find_row,'notes_height',This.height)
End If

If This.visible Then 
	li_hide = 0
Else
	li_hide = 1
End If

If istr_notes.sdw_note_list.GetItemNumber(ll_find_row,'is_hide') <> li_hide Then
	istr_notes.sdw_note_list.SetItem(ll_find_row,'is_hide',li_hide)
End If

If istr_notes.sdw_note_list.ModifiedCount() > 0 Then
	If istr_notes.sdw_note_list.Update() = 1 Then
		//
	Else
		Messagebox('Save error','Failed to save the note data, please call support.')
		istr_notes.sdw_note_list.Dynamic Event ue_retrieve() //Restore data
	End If
End If

Return 1
end event

event ue_hide();
Long ll_find_row
If isvalid(istr_notes.sdw_note_list) Then
	ll_find_row = istr_notes.sdw_note_list.Find('id = '+String(istr_notes.sl_note_id),1,istr_notes.sdw_note_list.RowCount())
	If ll_find_row < 1 Then Return 
	istr_notes.sdw_note_list.Dynamic Post Event ue_hide(ll_find_row)
End If
	
end event

public subroutine of_set_back_color (long al_rgb);//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard_notesof_set_back_color()
// $<arguments>
//		value	long	al_rgb		
// $<returns> (none)
// $<description>
// $<description> Set the backcolor property for all objects
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

This.backcolor = al_rgb
st_nwse.backcolor = al_rgb
st_ns.backcolor = al_rgb
st_we.backcolor = al_rgb
mle_note.backcolor = al_rgb
sle_focus.backcolor = al_rgb
r_area.fillcolor = al_rgb
end subroutine

public function integer of_set_properties ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard_notesof_set_properties()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Set all properties. Means refresh UI.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_find_row
Long ll_back_color
Long ll_x,ll_y

ll_find_row = istr_notes.sdw_note_list.Find('id = '+String(istr_notes.sl_note_id),1,istr_notes.sdw_note_list.RowCount())
If ll_find_row < 1 Then Return -1

//Set BackColor
ll_back_color = istr_notes.sdw_note_list.GetItemNumber(ll_find_row,'back_color')
If isnull(ll_back_color) Then ll_back_color = il_default_back_color
of_set_back_color(ll_back_color)

//Set Position
This.width = istr_notes.sdw_note_list.GetItemnumber(ll_find_row,'notes_width')
This.height = istr_notes.sdw_note_list.GetItemnumber(ll_find_row,'notes_height')
ll_x = istr_notes.sdw_note_list.GetItemnumber(ll_find_row,'notes_x')
ll_y = istr_notes.sdw_note_list.GetItemnumber(ll_find_row,'notes_y')
This.Move(ll_x,ll_y)	

//Set Text
mle_note.text = istr_notes.sdw_note_list.GetItemString(ll_find_row,'notes')

//Set Visible
If istr_notes.sdw_note_list.GetItemNumber(ll_find_row,'is_hide') = 1 Then
	This.visible = False
Else
	This.visible = True	
End If	

Return 1
end function

public function integer of_edit_on ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard_notes::of_edit_on()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Make the editing status to ON
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If This.visible = False Then Return 1
mle_note.taborder = 10
mle_note.Selecttext( 1,Len(mle_note.Text) )
mle_note.Pointer = 'Ibeam!'
r_area.visible = True 
This.bringtotop = True
//SetWindowPos(Handle(This),-1,0,0,0,0,3) //Bring to top
mle_note.Post Setfocus()	
Return 1
end function

public subroutine of_set_font ();If Right(AppeonGetOSType(),3) >= '6.0' Then 
	mle_note.facename = 'Segoe Print'
End If
end subroutine

on w_dashboard_notes.create
this.st_nwse=create st_nwse
this.st_ns=create st_ns
this.r_area=create r_area
this.st_we=create st_we
this.mle_note=create mle_note
this.sle_focus=create sle_focus
this.Control[]={this.st_nwse,&
this.st_ns,&
this.r_area,&
this.st_we,&
this.mle_note,&
this.sle_focus}
end on

on w_dashboard_notes.destroy
destroy(this.st_nwse)
destroy(this.st_ns)
destroy(this.r_area)
destroy(this.st_we)
destroy(this.mle_note)
destroy(this.sle_focus)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event>openw_dashboard_notes()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Open the notes
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If isvalid(Message.powerobjectparm) Then
	istr_notes = Message.powerobjectparm
Else
	Close(This)
End If

of_set_font()
of_set_properties()





//SetWindowPos(Handle(This),-1,0,0,0,0,3) //Bring to top
end event

event resize;//////////////////////////////////////////////////////////////////////
// $<event>resizew_dashboard_notes()
// $<arguments>
//		value	unsignedlong	sizetype 		
//		value	integer     	newwidth 		
//		value	integer     	newheight		
// $<returns> long
// $<description>
// $<description> Resize note window
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

integer li_border = 5, li_resize_border = 20

Mle_note.x = li_border
Mle_note.y = li_border
Mle_note.width = This.Width - Mle_note.x - li_resize_border - li_border
Mle_note.Height = This.Height - Mle_note.y - li_resize_border - li_border

st_we.x = Mle_note.x + Mle_note.width
st_we.y = Mle_note.y
st_we.width = li_resize_border
st_we.height = Mle_note.Height

st_ns.x = Mle_note.x 
st_ns.y = Mle_note.y + Mle_note.Height
st_ns.width = Mle_note.width
st_ns.height = li_resize_border

st_nwse.x = Mle_note.x + Mle_note.width
st_nwse.y = Mle_note.y + Mle_note.Height
st_nwse.width = li_resize_border
st_nwse.height = li_resize_border

r_area.x = 0
r_area.y = 0
//---------Begin Modified by (Appeon)Harry 01.27.2016 for Bug # 4951 - Dashboard: when editing a note, the dashed box is smaller than the size of the note
//r_area.height = This.height 
//r_area.width = This.width 
r_area.height =newheight 
r_area.width = newwidth
//---------End Modfiied ------------------------------------------------------

end event

type st_nwse from statictext within w_dashboard_notes
event mousebuttondown pbm_lbuttondown
event mousemove pbm_mousemove
event mousebuttonup pbm_lbuttonup
integer x = 626
integer y = 284
integer width = 50
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeNWSE!"
long textcolor = 33554432
long backcolor = 65535
boolean focusrectangle = false
end type

event mousebuttondown;ib_mouse_down_border = True
il_pointerX_ini_border = Parent.PointerX()
il_pointerY_ini_border = Parent.PointerY()


end event

event mousemove;//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard_notesControl List()
// $<arguments>
//		value	unsignedlong	flags		
//		value	integer     	xpos 		
//		value	integer     	ypos 		
// $<returns> (none)
// $<description>
// $<description> Resize Notes window with SizeNWSE!
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If ib_mouse_down_border = True Then
	//Verify invalid position 
	If Parent.Width + Parent.PointerX() - il_pointerX_ini_border < 50 Then Return
	If Parent.Height + Parent.PointerY() - il_pointerY_ini_border < 50 Then Return
	//Set new position
	Parent.Width = Parent.Width + Parent.PointerX() - il_pointerX_ini_border
	Parent.Height = Parent.Height + Parent.PointerY() - il_pointerY_ini_border
	il_pointerX_ini_border = Parent.PointerX()
	il_pointerY_ini_border = Parent.PointerY()	
End If

end event

event mousebuttonup;ib_mouse_down_border = False
Trigger Event ue_save()
end event

type st_ns from statictext within w_dashboard_notes
event mousebuttondown pbm_lbuttondown
event mousemove pbm_mousemove
event mousebuttonup pbm_lbuttonup
integer x = 78
integer y = 276
integer width = 238
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeNS!"
long textcolor = 33554432
long backcolor = 65535
boolean focusrectangle = false
end type

event mousebuttondown;ib_mouse_down_border = True
il_pointerX_ini_border = Parent.PointerX()
il_pointerY_ini_border = Parent.PointerY()


end event

event mousemove;//////////////////////////////////////////////////////////////////////
// $<event>mousemovest_ns()
// $<arguments>
//		value	unsignedlong	flags		
//		value	integer     	xpos 		
//		value	integer     	ypos 		
// $<returns> long
// $<description>
// $<description> Resize Notes window with SizeNS!
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If ib_mouse_down_border = True Then
	If Parent.Height + Parent.PointerY() - il_pointerY_ini_border < 50 Then Return
	Parent.Height = Parent.Height + Parent.PointerY() - il_pointerY_ini_border
	il_pointerY_ini_border = Parent.PointerY()
End If

end event

event mousebuttonup;ib_mouse_down_border = False
Trigger Event ue_save()
end event

type r_area from rectangle within w_dashboard_notes
boolean visible = false
linestyle linestyle = dot!
integer linethickness = 4
long fillcolor = 65535
integer x = 974
integer y = 256
integer width = 165
integer height = 144
end type

type st_we from statictext within w_dashboard_notes
event mousebuttondown pbm_lbuttondown
event mousemove pbm_mousemove
event mousebuttonup pbm_lbuttonup
integer x = 635
integer y = 20
integer width = 50
integer height = 204
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeWE!"
long textcolor = 33554432
long backcolor = 65535
boolean focusrectangle = false
end type

event mousebuttondown;ib_mouse_down_border = True
il_pointerX_ini_border = Parent.PointerX()
il_pointerY_ini_border = Parent.PointerY()


end event

event mousemove;//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard_notesControl List()
// $<arguments>
//		value	unsignedlong	flags		
//		value	integer     	xpos 		
//		value	integer     	ypos 		
// $<returns> (none)
// $<description>
// $<description>Resize Notes window with SizeWE!
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If ib_mouse_down_border = True Then
	If Parent.Width + Parent.PointerX() - il_pointerX_ini_border < 50 Then Return	
	Parent.Width = Parent.Width + Parent.PointerX() - il_pointerX_ini_border
	il_pointerX_ini_border = Parent.PointerX()
End If

end event

event mousebuttonup;ib_mouse_down_border = False
Trigger Event ue_save()
end event

type mle_note from multilineedit within w_dashboard_notes
event mousebuttondown pbm_lbuttondown
event ue_doubleclicked pbm_lbuttondblclk
event mousebuttonup pbm_lbuttonup
event mousemove pbm_mousemove
event rbuttonup pbm_rbuttonup
integer x = 14
integer y = 12
integer width = 603
integer height = 232
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 65535
boolean border = false
boolean autovscroll = true
integer limit = 200
end type

event mousebuttondown;
//Send ( Handle( Parent ), 274, 61458, 0 ) //Send Move Message

Long ll_find_row

Parent.bringtotop = True

//Set INI value
ib_mousedown = True
il_pointerX_ini = Parent.PointerX()
il_pointerY_ini = Parent.PointerY()

//Set Highlight row
ll_find_row = istr_notes.sdw_note_list.Find('id = '+String(istr_notes.sl_note_id),1,istr_notes.sdw_note_list.RowCount())
If ll_find_row > 0 Then
	istr_notes.sdw_note_list.Dynamic Trigger Event ue_highlight_row(ll_find_row)
End If
end event

event ue_doubleclicked;of_edit_on()
end event

event mousebuttonup;
//Set Pointer, Reset mouse status flag
ib_mousedown = False
If this.taborder = 0 Then
	This.pointer = "Arrow!"
Else
	This.pointer = "Ibeam!"
End If

//Save data
Trigger Event ue_save()
end event

event mousemove;
IF ib_mousedown and This.taborder = 0 Then
	If Parent.x + Parent.PointerX() - il_pointerX_ini + This.width > w_mdi.mdi_1.Width or Parent.x + Parent.PointerX() - il_pointerX_ini < 0 Then Return
	If Parent.Y + Parent.PointerY() - il_pointerY_ini + This.Height > w_mdi.mdi_1.height or Parent.Y + Parent.PointerY() - il_pointerY_ini < 0 Then Return
	Parent.Move(Parent.x + Parent.PointerX() - il_pointerX_ini, Parent.Y + Parent.PointerY() - il_pointerY_ini )
	il_pointerX_ini = Parent.PointerX()
	il_pointerY_ini = Parent.PointerY()
End If
end event

event rbuttonup;//
end event

event losefocus;This.taborder = 0
This.Pointer = 'Arrow!'
r_area.visible = False

Trigger Event ue_save()

end event

event getfocus;If This.taborder = 0 Then
	//Jump focus for prevent modification
	sle_focus.SetFocus()
End If

end event

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>constructor()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> For Notes Gadget 
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

end event

event rbuttondown;If r_area.visible = False Then
	m_dashboard_notes lm_notes
	lm_notes = Create m_dashboard_notes
	lm_notes.iw_notes = Parent
	
	Popmenu(lm_notes,w_mdi.PointerX(),w_mdi.PointerY())
End If
Return 0
end event

type sle_focus from singlelineedit within w_dashboard_notes
string tag = "Focus jump to current object"
integer x = 142
integer y = 452
integer width = 457
integer height = 128
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

