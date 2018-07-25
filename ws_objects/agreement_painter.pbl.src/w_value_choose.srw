$PBExportHeader$w_value_choose.srw
forward
global type w_value_choose from w_response
end type
type cb_cancel from commandbutton within w_value_choose
end type
type cb_ok from commandbutton within w_value_choose
end type
type dw_1 from u_dw within w_value_choose
end type
end forward

global type w_value_choose from w_response
integer width = 1838
integer height = 1304
string title = "Selection"
long backcolor = 33551856
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
end type
global w_value_choose w_value_choose

type variables
str_get_dw istr_get_dw
end variables

on w_value_choose.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_value_choose.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event pfc_preopen;call super::pfc_preopen;Long ll_find

//Retrieve dw
istr_get_dw = Message.Powerobjectparm
dw_1.dataobject = istr_get_dw.ls_dw_name
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve()

//Locate current row
ll_find = dw_1.Find(istr_get_dw.ls_value_col + " = '" + istr_get_dw.ls_current_value + "'",1,dw_1.Rowcount())
If ll_find > 0 Then
	dw_1.SetRow(ll_find)
	dw_1.ScrolltoRow(ll_find)
	dw_1.SelectRow(0,False)
	dw_1.SelectRow(ll_find,True)
End If

end event

type cb_cancel from commandbutton within w_value_choose
integer x = 1413
integer y = 1096
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

event clicked;ClosewithReturn(Parent,'')
end event

type cb_ok from commandbutton within w_value_choose
integer x = 1047
integer y = 1096
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
end type

event clicked;Long ll_row
String ls_value

ll_row = dw_1.GetRow()
If ll_row > 0 Then 
	ls_value = dw_1.GetItemString(ll_row,istr_get_dw.ls_value_col )
	ClosewithReturn(Parent,ls_value)
Else
	ClosewithReturn(Parent,'')	
End If

end event

type dw_1 from u_dw within w_value_choose
integer x = 32
integer y = 24
integer width = 1751
integer height = 1032
integer taborder = 10
string title = "none"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_setrowselect(True)
This.inv_rowselect.of_setstyle(This.inv_rowselect.single)
end event

event doubleclicked;call super::doubleclicked;If row > 0 Then
	cb_ok.event clicked( )
End If
end event

