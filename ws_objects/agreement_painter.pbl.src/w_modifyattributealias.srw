$PBExportHeader$w_modifyattributealias.srw
forward
global type w_modifyattributealias from window
end type
type cb_cancel from commandbutton within w_modifyattributealias
end type
type cb_ok from commandbutton within w_modifyattributealias
end type
type st_1 from statictext within w_modifyattributealias
end type
type sle_alias from singlelineedit within w_modifyattributealias
end type
end forward

global type w_modifyattributealias from window
integer width = 1582
integer height = 464
boolean titlebar = true
string title = "Modify Alias"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
sle_alias sle_alias
end type
global w_modifyattributealias w_modifyattributealias

type variables
DataWindow	idw_attributes

String	is_OriAlias

end variables

forward prototypes
public function long of_aliascheck (string as_alias)
end prototypes

public function long of_aliascheck (string as_alias);long		ll_Cycle,ll_RowCnts,ll_Count
String	ls_Alias

ll_RowCnts = idw_Attributes.RowCount()
for ll_Cycle = 1 to ll_RowCnts
	ls_Alias = idw_Attributes.GetItemString(ll_Cycle,"alias_name")
	if ls_Alias = as_alias then Return 1
next

SELECT Count(*) INTO :ll_Count FROM code_lookup WHERE lookup_name = :as_Alias;

Return ll_Count

end function

on w_modifyattributealias.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.sle_alias=create sle_alias
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.st_1,&
this.sle_alias}
end on

on w_modifyattributealias.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.sle_alias)
end on

event open;long		ll_Row

idw_Attributes = Message.PowerObjectParm

ll_Row = idw_Attributes.GetRow()
is_OriAlias = idw_Attributes.GetItemString(ll_Row,"alias_name")

sle_Alias.Text = is_OriAlias

sle_Alias.SelectText(1,Len(sle_Alias.Text))

end event

type cb_cancel from commandbutton within w_modifyattributealias
integer x = 1097
integer y = 236
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
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,"")

end event

type cb_ok from commandbutton within w_modifyattributealias
integer x = 727
integer y = 236
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;String	ls_NewAlias
long		ll_Rtn

ls_NewAlias = Trim(sle_Alias.Text)

if Len(ls_NewAlias) <= 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,"The name can't be null.",Exclamation!)
	Return
end if

if ls_NewAlias <> is_OriAlias then
	ll_Rtn = of_AliasCheck(ls_NewAlias)
	if ll_Rtn > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,"This name already exists.",Exclamation!)
		Return
	end if
	CloseWithReturn(Parent,ls_NewAlias)
else
	CloseWithReturn(Parent,"")
end if

end event

type st_1 from statictext within w_modifyattributealias
integer x = 41
integer y = 96
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "New Name"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_alias from singlelineedit within w_modifyattributealias
integer x = 443
integer y = 80
integer width = 997
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

