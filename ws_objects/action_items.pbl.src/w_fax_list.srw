$PBExportHeader$w_fax_list.srw
forward
global type w_fax_list from window
end type
type cbx_always from checkbox within w_fax_list
end type
type cb_cancel from commandbutton within w_fax_list
end type
type cb_ok from commandbutton within w_fax_list
end type
type st_1 from statictext within w_fax_list
end type
type lb_fax from listbox within w_fax_list
end type
end forward

global type w_fax_list from window
integer width = 1783
integer height = 832
boolean titlebar = true
string title = "MS Fax Printer List"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_always cbx_always
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
lb_fax lb_fax
end type
global w_fax_list w_fax_list

type variables
Integer ii_item

end variables

on w_fax_list.create
this.cbx_always=create cbx_always
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.lb_fax=create lb_fax
this.Control[]={this.cbx_always,&
this.cb_cancel,&
this.cb_ok,&
this.st_1,&
this.lb_fax}
end on

on w_fax_list.destroy
destroy(this.cbx_always)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.lb_fax)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event>w_fax_listopen()
// $<arguments>(None)
// $<returns> long
// $<description> List fax printer in ListBox
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05/30/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
String ls_fax_list[],ls_fax_parm
string ls_mailto_arry[],ls_mailcc_arry[]
n_cst_string lnv_string

//Must set sorted to false.
lb_fax.sorted = False

ls_fax_parm = Message.stringparm
lnv_string.of_parsetoarray( ls_fax_parm, ";", ls_fax_list[])
For i = 1 to UpperBound(ls_fax_list) 
	lb_fax.additem(ls_fax_list[i])
Next

If lb_fax.TotalItems() = 0 Then
	ii_item = 0
	cb_ok.Enabled = False
Else
	ii_item = lb_fax.selectitem(1)
End If


end event

type cbx_always from checkbox within w_fax_list
integer x = 41
integer y = 624
integer width = 1248
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Always use this MS Fax Printer."
end type

type cb_cancel from commandbutton within w_fax_list
integer x = 1353
integer y = 268
integer width = 343
integer height = 100
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

event clicked;CloseWithReturn(Parent,0)
end event

type cb_ok from commandbutton within w_fax_list
integer x = 1349
integer y = 128
integer width = 343
integer height = 100
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

event clicked;String ls_content
ls_content = lb_fax.Text(ii_item)
If PosA(Upper(ls_content),'ERROR') > 0 Then
	Messagebox('Information','Current MS Fax Printer is not useable.Please choose a valid MS Fax printer.')
	Return
End If
If cbx_always.Checked Then
	Gi_MSFax_Number = ii_item
End If
CloseWithReturn(Parent,ii_item)
end event

type st_1 from statictext within w_fax_list
integer x = 50
integer y = 36
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "MS Fax Printer:"
boolean focusrectangle = false
end type

type lb_fax from listbox within w_fax_list
integer x = 41
integer y = 124
integer width = 1257
integer height = 468
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_item = index

end event

