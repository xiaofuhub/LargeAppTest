$PBExportHeader$w_icon_select.srw
forward
global type w_icon_select from w_response
end type
type st_3 from statictext within w_icon_select
end type
type st_1 from statictext within w_icon_select
end type
type cb_browse from commandbutton within w_icon_select
end type
type cb_cancel from commandbutton within w_icon_select
end type
type cb_ok from commandbutton within w_icon_select
end type
type ddplb_icon from u_picturebutton_icons within w_icon_select
end type
end forward

global type w_icon_select from w_response
integer width = 1801
integer height = 256
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
event ue_syscommand pbm_syscommand
st_3 st_3
st_1 st_1
cb_browse cb_browse
cb_cancel cb_cancel
cb_ok cb_ok
ddplb_icon ddplb_icon
end type
global w_icon_select w_icon_select

type variables
Long il_pic_id
end variables

event ue_syscommand;If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

on w_icon_select.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_1=create st_1
this.cb_browse=create cb_browse
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.ddplb_icon=create ddplb_icon
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_browse
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.ddplb_icon
end on

on w_icon_select.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_browse)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.ddplb_icon)
end on

event open;call super::open;String ls_pre_icon
Str_picture lstr_picture

lstr_picture = Message.PowerObjectParm

If lstr_picture.al_pic_id > 0 Then
	il_pic_id = lstr_picture.al_pic_id
Else
	ddplb_icon.text = lstr_picture.as_pic_file
End If

If lstr_picture.ab_support_picture_painter  Then
	cb_browse.visible = True
Else
	cb_browse.visible = False
End If




end event

type st_3 from statictext within w_icon_select
integer x = 763
integer y = 28
integer width = 645
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "OR        Click Get Picture"
boolean focusrectangle = false
end type

type st_1 from statictext within w_icon_select
integer x = 55
integer y = 28
integer width = 567
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Icon and click OK"
boolean focusrectangle = false
end type

type cb_browse from commandbutton within w_icon_select
integer x = 946
integer y = 92
integer width = 389
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Picture..."
end type

event clicked;str_picture lstr_picture

lstr_picture.al_pic_id = il_pic_id
lstr_picture.as_type = 'select'

Post Openwithparm(w_picture_painter, lstr_picture)

Close(Parent)

Return


end event

type cb_cancel from commandbutton within w_icon_select
integer x = 1385
integer y = 92
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;str_picture lstr_picture

CloseWithReturn(Parent,lstr_picture)


end event

type cb_ok from commandbutton within w_icon_select
integer x = 704
integer y = 96
integer width = 165
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;String ls_icon
str_picture lstr_picture

lstr_picture.as_pic_file = ddplb_icon.text

CloseWithReturn(Parent,lstr_picture)
end event

type ddplb_icon from u_picturebutton_icons within w_icon_select
integer x = 55
integer y = 96
integer taborder = 10
end type

