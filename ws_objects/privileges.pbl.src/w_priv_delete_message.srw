$PBExportHeader$w_priv_delete_message.srw
forward
global type w_priv_delete_message from window
end type
type cb_4 from commandbutton within w_priv_delete_message
end type
type cb_3 from commandbutton within w_priv_delete_message
end type
type cb_2 from commandbutton within w_priv_delete_message
end type
type cb_1 from commandbutton within w_priv_delete_message
end type
type dw_view from datawindow within w_priv_delete_message
end type
type st_1 from statictext within w_priv_delete_message
end type
end forward

global type w_priv_delete_message from window
integer width = 3141
integer height = 580
boolean titlebar = true
string title = "Privilege Delete"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_view dw_view
st_1 st_1
end type
global w_priv_delete_message w_priv_delete_message

type variables
String is_type
long il_id

end variables

on w_priv_delete_message.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_view=create dw_view
this.st_1=create st_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_view,&
this.st_1}
end on

on w_priv_delete_message.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_view)
destroy(this.st_1)
end on

event open;//Start Code Change ----10.06.2009 #V10 maha - new window for delet message to allow viewing of practitioners
string s
string ls_mes
long ll_count

s = message.stringparm
debugbreak()
is_type = LeftA(s,1)
il_id = long(MidA(s,2))

//set window, get data
choose case is_type
	case "C" //department
		dw_view.dataobject = "d_priv_delete_list_dept"
	case "S" //section
		dw_view.dataobject = "d_priv_delete_list_section"
	case "P"	//procedure
		dw_view.dataobject = "d_priv_delete_list_procedure"
end choose

dw_view.settransobject(sqlca)
ll_count = dw_view.retrieve(il_id)

//set message
choose case is_type
	case "C" //department
		ls_mes = "There are " + string(ll_count) + " practitioner privilege record(s)  connected to this Clinical Department.~rThese records must be deleted before the Procedure can be deleted."
	case "S" //section
		ls_mes = "There are " + string(ll_count) + " practitioner privilege record(s)  connected to this Section.~rThese records must be deleted before the Procedure can be deleted."		
	case "P"	//procedure
		ls_mes = "There are " + string(ll_count) + " practitioner privilege record(s) connected to this procedure.~rThese records must be deleted before the Procedure can be deleted."
end choose

st_1.text = ls_mes


end event

type cb_4 from commandbutton within w_priv_delete_message
integer x = 2789
integer y = 16
integer width = 297
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_priv_delete_message
integer x = 2121
integer y = 16
integer width = 347
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export"
end type

event clicked;gnv_dw.of_SaveAs(dw_view)//.saveas() Modify by Evan 05.11.2010
end event

type cb_2 from commandbutton within w_priv_delete_message
integer x = 2478
integer y = 16
integer width = 297
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;integer res
long i

i = messagebox("Delete privilege records","Are you sure that you want to delete the existing privilege records for these providers?",question!,yesno!,2)
if i = 2 then return

i = messagebox("Delete privilege records","Are you absolutely positive that you want to permanently delete the existing privilege records for these providers?",question!,yesno!,2)
if i = 2 then return

i = messagebox("Delete privilege records","Really, really positive?",question!,yesno!,2)
if i = 2 then return

for i = 1 to dw_view.rowcount()
	dw_view.deleterow(1)
next

dw_view.update()
end event

type cb_1 from commandbutton within w_priv_delete_message
integer x = 1765
integer y = 16
integer width = 347
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Records"
end type

event clicked;parent.height = 2700
end event

type dw_view from datawindow within w_priv_delete_message
integer x = 27
integer y = 540
integer width = 3058
integer height = 2028
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_priv_delete_message
integer x = 18
integer y = 140
integer width = 3104
integer height = 348
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "message text"
alignment alignment = center!
boolean focusrectangle = false
end type

