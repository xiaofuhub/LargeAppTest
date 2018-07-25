$PBExportHeader$w_export_test_param.srw
forward
global type w_export_test_param from window
end type
type em_to from editmask within w_export_test_param
end type
type em_from from editmask within w_export_test_param
end type
type st_3 from statictext within w_export_test_param
end type
type st_2 from statictext within w_export_test_param
end type
type st_1 from statictext within w_export_test_param
end type
type cb_2 from commandbutton within w_export_test_param
end type
type cb_1 from commandbutton within w_export_test_param
end type
end forward

global type w_export_test_param from window
integer x = 1056
integer y = 804
integer width = 1440
integer height = 744
windowtype windowtype = response!
long backcolor = 33551856
em_to em_to
em_from em_from
st_3 st_3
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_export_test_param w_export_test_param

on w_export_test_param.create
this.em_to=create em_to
this.em_from=create em_from
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.em_to,&
this.em_from,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1}
end on

on w_export_test_param.destroy
destroy(this.em_to)
destroy(this.em_from)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;//<add> 08/24/2007 by: Andy
Long ll_type

if isValid(w_export_painter) then 
	ll_type = w_export_painter.tab_1.tabpage_export_hdr.dw_export_file.GetItemNumber( 1, "export_type" )
	if ll_type = 3 or ll_type = 4 then
		st_1.text = "Select a range of contract ids to test."
	end if
end if
end event

type em_to from editmask within w_export_test_param
integer x = 718
integer y = 312
integer width = 247
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#######"
end type

type em_from from editmask within w_export_test_param
integer x = 443
integer y = 312
integer width = 247
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#######"
end type

type st_3 from statictext within w_export_test_param
integer x = 690
integer y = 232
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "To:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_export_test_param
integer x = 416
integer y = 232
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "From:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_export_test_param
integer x = 64
integer y = 80
integer width = 1335
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select a range of practitioner ids to test."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_export_test_param
integer x = 718
integer y = 452
integer width = 242
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_1 from commandbutton within w_export_test_param
integer x = 439
integer y = 452
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Ok"
end type

event clicked;string ls_from
string ls_to
string ls_return

ls_from  = em_from.text
if isnull(ls_from) then ls_from  = "0"
ls_to  = em_to.text
if isnull(ls_to) then
	//messagebox("Input Error","Please enter a To: value.")
	messagebox("Input Error","Please enter a To value.")
	return
end if
//---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 2009-08-25.
If Long(ls_from) < 0 Then
	Messagebox('Input Error','The From value must be greater than 0.')	
	em_from.setfocus()
	Return
End If
If Long(ls_to) < 0 Then
	Messagebox('Input Error','The To value must be greater than 0.')		
	em_to.Setfocus()
	Return
End If
//---------End Added ------------------------------------------------------------------

ls_return = ls_from + "@" + ls_to

closewithreturn(parent,ls_return)





end event

