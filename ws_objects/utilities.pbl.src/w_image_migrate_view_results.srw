$PBExportHeader$w_image_migrate_view_results.srw
forward
global type w_image_migrate_view_results from window
end type
type cb_3 from commandbutton within w_image_migrate_view_results
end type
type st_mess from statictext within w_image_migrate_view_results
end type
type cb_2 from commandbutton within w_image_migrate_view_results
end type
type cb_1 from commandbutton within w_image_migrate_view_results
end type
type dw_1 from datawindow within w_image_migrate_view_results
end type
end forward

global type w_image_migrate_view_results from window
integer width = 1669
integer height = 2472
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
st_mess st_mess
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_image_migrate_view_results w_image_migrate_view_results

on w_image_migrate_view_results.create
this.cb_3=create cb_3
this.st_mess=create st_mess
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.st_mess,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_image_migrate_view_results.destroy
destroy(this.cb_3)
destroy(this.st_mess)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;gs_variable_array ls_pass
string ls_mess
long ll_pracs[]

ls_pass = message.powerobjectparm

ls_mess = ls_pass.as_string[1]
ll_pracs[] = ls_pass.as_number[]

st_mess.text = ls_mess

if UpperBound(ll_pracs)  <= 0 then ll_pracs[1] = 0 //Added by (Appeon)Harry 08.03.2016 for BugH072804--------

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_pracs)






end event

type cb_3 from commandbutton within w_image_migrate_view_results
integer x = 558
integer y = 20
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_1.print()
end event

type st_mess from statictext within w_image_migrate_view_results
integer x = 87
integer y = 116
integer width = 1440
integer height = 280
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_image_migrate_view_results
integer x = 919
integer y = 20
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export"
end type

event clicked;gnv_dw.of_SaveAs(dw_1)//.saveas() Modify by Evan 05.11.2010
ChangeDirectory(gs_current_path)//restore currentdirectory-Added by Nova 04.29.2008
end event

type cb_1 from commandbutton within w_image_migrate_view_results
integer x = 1280
integer y = 20
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type dw_1 from datawindow within w_image_migrate_view_results
integer x = 41
integer y = 452
integer width = 1573
integer height = 1880
integer taborder = 10
string title = "none"
string dataobject = "d_prac_id_name"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

