$PBExportHeader$u_picturebutton_started.sru
forward
global type u_picturebutton_started from picturebutton
end type
end forward

global type u_picturebutton_started from picturebutton
integer width = 343
integer height = 184
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "HyperLink!"
alignment htextalign = left!
event mousemove pbm_mousemove
end type
global u_picturebutton_started u_picturebutton_started

event mousemove;Parent.Dynamic Event ue_mousemove(This)
end event

on u_picturebutton_started.create
end on

on u_picturebutton_started.destroy
end on

event clicked;PowerObject lpo_parent
Window lw_parent
lpo_parent = This.GetParent()
If lpo_parent.ClassName() = 'w_getting_started' Then
	lw_parent = lpo_parent
	lw_parent.windowstate = Minimized!
End If


n_cst_getting_started lnv_started
lnv_started.event ue_do(This.tag)



end event

