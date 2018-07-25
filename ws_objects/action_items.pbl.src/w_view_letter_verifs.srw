$PBExportHeader$w_view_letter_verifs.srw
forward
global type w_view_letter_verifs from w_response
end type
type cb_3 from commandbutton within w_view_letter_verifs
end type
type cb_2 from commandbutton within w_view_letter_verifs
end type
type cb_1 from commandbutton within w_view_letter_verifs
end type
type dw_1 from u_dw within w_view_letter_verifs
end type
end forward

global type w_view_letter_verifs from w_response
integer width = 2281
string title = "Letter Records"
long backcolor = 33551856
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_view_letter_verifs w_view_letter_verifs

on w_view_letter_verifs.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_view_letter_verifs.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;gs_variable_array lst_array
n_ds lds_data
string ls_obj

lst_array = message.powerobjectparm
lds_data = lst_array.as_ds[1]

ls_obj = lds_data.dataobject

dw_1.dataobject = ls_obj
dw_1.settransobject(sqlca)
lds_data.sharedata( dw_1)



end event

event closequery;return 0
end event

type cb_3 from commandbutton within w_view_letter_verifs
integer x = 425
integer y = 32
integer width = 370
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort by Id"
end type

event clicked;integer r
integer rc
integer li_col
string ls_name

rc = integer(dw_1.Object.DataWindow.Column.Count)

for r = 1 to rc
	li_col = r
	ls_name = lower(dw_1.describe("#" +string(li_col)+".name"))
	debugbreak()
	if ls_name = "prac_id" then
		dw_1.setsort("prac_id")
		exit
	elseif ls_name = "v_full_name_prac_id" then
		dw_1.setsort("v_full_name_prac_id")	
		exit
	end if		
next

dw_1.sort()
end event

type cb_2 from commandbutton within w_view_letter_verifs
integer x = 50
integer y = 32
integer width = 370
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort by Name"
end type

event clicked;dw_1.setsort('v_full_name_full_name ASC')
dw_1.sort()

end event

type cb_1 from commandbutton within w_view_letter_verifs
integer x = 1865
integer y = 32
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;close(parent)
end event

type dw_1 from u_dw within w_view_letter_verifs
integer x = 37
integer y = 160
integer width = 2171
integer height = 1184
integer taborder = 10
borderstyle borderstyle = stylebox!
end type

