$PBExportHeader$w_data_view_hints.srw
forward
global type w_data_view_hints from window
end type
type cb_1 from commandbutton within w_data_view_hints
end type
type st_13 from statictext within w_data_view_hints
end type
type st_7 from statictext within w_data_view_hints
end type
type st_8 from statictext within w_data_view_hints
end type
type st_9 from statictext within w_data_view_hints
end type
type st_12 from statictext within w_data_view_hints
end type
type st_11 from statictext within w_data_view_hints
end type
type st_16 from statictext within w_data_view_hints
end type
type st_14 from statictext within w_data_view_hints
end type
type st_10 from statictext within w_data_view_hints
end type
end forward

global type w_data_view_hints from window
integer x = 1056
integer y = 484
integer width = 2290
integer height = 964
boolean titlebar = true
string title = "Data View field usage instructions"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
cb_1 cb_1
st_13 st_13
st_7 st_7
st_8 st_8
st_9 st_9
st_12 st_12
st_11 st_11
st_16 st_16
st_14 st_14
st_10 st_10
end type
global w_data_view_hints w_data_view_hints

on w_data_view_hints.create
this.cb_1=create cb_1
this.st_13=create st_13
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.st_12=create st_12
this.st_11=create st_11
this.st_16=create st_16
this.st_14=create st_14
this.st_10=create st_10
this.Control[]={this.cb_1,&
this.st_13,&
this.st_7,&
this.st_8,&
this.st_9,&
this.st_12,&
this.st_11,&
this.st_16,&
this.st_14,&
this.st_10}
end on

on w_data_view_hints.destroy
destroy(this.cb_1)
destroy(this.st_13)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_16)
destroy(this.st_14)
destroy(this.st_10)
end on

type cb_1 from commandbutton within w_data_view_hints
integer x = 946
integer y = 760
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type st_13 from statictext within w_data_view_hints
integer x = 78
integer y = 36
integer width = 914
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Data View field usage instructions:"
boolean focusrectangle = false
end type

type st_7 from statictext within w_data_view_hints
integer x = 78
integer y = 128
integer width = 2162
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "1. This field allows a user to select an IntelliCred/App or IntelliContract View."
boolean focusrectangle = false
end type

type st_8 from statictext within w_data_view_hints
integer x = 78
integer y = 216
integer width = 2162
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "2. Depending on the view selected, the system will display the appropriate table and column names."
boolean focusrectangle = false
end type

type st_9 from statictext within w_data_view_hints
integer x = 78
integer y = 304
integer width = 2162
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "3. The column names will come from the column names set in the Screen Painter-Contract Data or "
boolean focusrectangle = false
end type

type st_12 from statictext within w_data_view_hints
integer x = 133
integer y = 364
integer width = 2089
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "the Screen Painter-Provider Data."
boolean focusrectangle = false
end type

type st_11 from statictext within w_data_view_hints
integer x = 78
integer y = 440
integer width = 2162
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "4. Once the report is defined, the user is strongly discouraged to change the view selection as this"
boolean focusrectangle = false
end type

type st_16 from statictext within w_data_view_hints
integer x = 133
integer y = 640
integer width = 2098
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "they are upgraded to v8. The user can change the default view to fit their real situations."
boolean focusrectangle = false
end type

type st_14 from statictext within w_data_view_hints
integer x = 78
integer y = 580
integer width = 2162
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "5. Reports that are defined prior to v8 will use Default System View as the default Data View after"
boolean focusrectangle = false
end type

type st_10 from statictext within w_data_view_hints
integer x = 133
integer y = 492
integer width = 2089
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " would mess up the report."
boolean focusrectangle = false
end type

