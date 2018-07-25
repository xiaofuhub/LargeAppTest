$PBExportHeader$w_npdb_exceptions.srw
forward
global type w_npdb_exceptions from window
end type
type cb_3 from commandbutton within w_npdb_exceptions
end type
type dw_1 from datawindow within w_npdb_exceptions
end type
type cb_2 from commandbutton within w_npdb_exceptions
end type
type cb_1 from commandbutton within w_npdb_exceptions
end type
end forward

global type w_npdb_exceptions from window
integer x = 823
integer y = 360
integer width = 2071
integer height = 1592
boolean titlebar = true
string title = "NPDB Processing Exceptions"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_3 cb_3
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_npdb_exceptions w_npdb_exceptions

event open;string ls_mess

ls_mess = "EXCEPTIONS:~r~r" + message.stringparm

//messagebox("ls_mess",ls_mess )

dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_1.setitem(1,"print_space",ls_mess)
end event

on w_npdb_exceptions.create
this.cb_3=create cb_3
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_npdb_exceptions.destroy
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_npdb_exceptions
integer x = 827
integer y = 1280
integer width = 366
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save As"
end type

event clicked;gnv_dw.of_SaveAs(dw_1)//.SaveAs() Modify by Evan 05.11.2010
ChangeDirectory ( gs_dir_path )//For restore Directory   Added by Nova 04.29.2008


end event

type dw_1 from datawindow within w_npdb_exceptions
integer x = 41
integer y = 52
integer width = 1920
integer height = 1204
integer taborder = 30
string dataobject = "d_npdb_exceptions"
boolean livescroll = true
end type

type cb_2 from commandbutton within w_npdb_exceptions
integer x = 1595
integer y = 1280
integer width = 366
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

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_npdb_exceptions
integer x = 1211
integer y = 1280
integer width = 366
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print "
end type

event clicked;dw_1.print()
end event

