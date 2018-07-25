$PBExportHeader$w_fppe_get_method.srw
forward
global type w_fppe_get_method from window
end type
type cb_cancel from commandbutton within w_fppe_get_method
end type
type dw_crit from datawindow within w_fppe_get_method
end type
type cb_1 from commandbutton within w_fppe_get_method
end type
type gb_3 from groupbox within w_fppe_get_method
end type
end forward

global type w_fppe_get_method from window
integer width = 2359
integer height = 952
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
dw_crit dw_crit
cb_1 cb_1
gb_3 gb_3
end type
global w_fppe_get_method w_fppe_get_method

on w_fppe_get_method.create
this.cb_cancel=create cb_cancel
this.dw_crit=create dw_crit
this.cb_1=create cb_1
this.gb_3=create gb_3
this.Control[]={this.cb_cancel,&
this.dw_crit,&
this.cb_1,&
this.gb_3}
end on

on w_fppe_get_method.destroy
destroy(this.cb_cancel)
destroy(this.dw_crit)
destroy(this.cb_1)
destroy(this.gb_3)
end on

type cb_cancel from commandbutton within w_fppe_get_method
integer x = 1243
integer y = 836
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "C")
end event

type dw_crit from datawindow within w_fppe_get_method
integer x = 91
integer y = 76
integer width = 2171
integer height = 716
integer taborder = 50
string title = "none"
string dataobject = "d_fppe_eval_crit_select"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cb_1 from commandbutton within w_fppe_get_method
integer x = 859
integer y = 836
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;integer t = 0
integer r
string ls_type[]
string ls_meth

//debugbreak()


for r = 1 to dw_crit.rowcount()
	if dw_crit.getitemnumber(r,"selected") = 1 then
		t++
		ls_type[t] = dw_crit.getitemstring(r,"description") 
	end if
next

if t = 0 then 
	closewithreturn(parent, "C")
	return//(Appeon)Toney 11.20.2013 - V141 ISG-CLX,Fix history BugT082804
end if

if t > 0 then
	for t = 1 to upperbound(ls_type)
		if t > 1 then ls_meth += " and/or "
		ls_meth = ls_meth + ls_type[t]
	next
end if

closewithreturn(parent, ls_meth)
end event

type gb_3 from groupbox within w_fppe_get_method
integer x = 46
integer y = 20
integer width = 2263
integer height = 800
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Evaluation Criteria  (data sources and methodology)"
end type

