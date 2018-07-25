$PBExportHeader$u_contract_select_screen.sru
forward
global type u_contract_select_screen from userobject
end type
type tv_screen from u_contract_screen within u_contract_select_screen
end type
type st_title from statictext within u_contract_select_screen
end type
end forward

global type u_contract_select_screen from userobject
integer width = 1221
integer height = 1684
long backcolor = 8421504
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_resize pbm_size
event type long ue_selectionchanged ( long al_oldhandle,  long al_newhandle )
event type long ue_selectionchanging ( long al_oldhandle,  long al_newhandle )
event type long ue_rightclicked ( long handle )
tv_screen tv_screen
st_title st_title
end type
global u_contract_select_screen u_contract_select_screen

forward prototypes
public function integer of_settitle (string as_text)
public function integer of_get_current_id ()
end prototypes

event ue_resize;st_title.width = NewWidth + 500
tv_screen.width = NewWidth - 5
tv_screen.height = NewHeight - tv_screen.y - 5
end event

event type long ue_selectionchanged(long al_oldhandle, long al_newhandle);Return 0
end event

event type long ue_SelectionChanging(long al_oldhandle, long al_newhandle);Return 0
end event

event type long ue_rightclicked(long handle);return 0
end event

public function integer of_settitle (string as_text);if Len(as_Text) > 40 then
	as_Text = Left(as_Text, 40) + "...)"
end if
st_title.Text = as_Text

Return 1
end function

public function integer of_get_current_id ();long ll_handle
Treeviewitem ltvi_screen
ll_handle = tv_screen.FindItem(CurrentTreeItem!	, 0)
If ll_handle > 0 Then
	tv_screen.GetItem(ll_handle,ltvi_screen)
	Return ltvi_screen.data
Else
	Return -1
End If


end function

on u_contract_select_screen.create
this.tv_screen=create tv_screen
this.st_title=create st_title
this.Control[]={this.tv_screen,&
this.st_title}
end on

on u_contract_select_screen.destroy
destroy(this.tv_screen)
destroy(this.st_title)
end on

event constructor;this.Event ue_Resize(0, Width, Height)
end event

type tv_screen from u_contract_screen within u_contract_select_screen
integer y = 72
integer width = 1221
integer height = 1612
integer taborder = 10
boolean border = false
borderstyle borderstyle = stylebox!
string picturename[] = {"Custom039!","Custom050!","DataWindow5!","DataWindow!","sectiongreen.bmp"}
end type

event selectionchanged;call super::selectionchanged;long ll_Return

ll_Return = Parent.Event ue_SelectionChanged(OldHandle, NewHandle)
Return ll_Return
end event

event selectionchanging;call super::selectionchanging;long ll_Return

ll_Return = Parent.Event ue_SelectionChanging(OldHandle, NewHandle)
Return ll_Return
end event

event rightclicked;call super::rightclicked;return parent.event ue_rightclicked(handle)
end event

type st_title from statictext within u_contract_select_screen
integer y = 8
integer width = 1221
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 8421504
string text = "Select Data Screen"
boolean focusrectangle = false
end type

