$PBExportHeader$uo_cb_output.sru
$PBExportComments$User object for out put options
forward
global type uo_cb_output from commandbutton
end type
end forward

global type uo_cb_output from commandbutton
integer width = 393
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OutPut Options"
event ue_clicked ( )
end type
global uo_cb_output uo_cb_output

type variables
datawindow idw
end variables

forward prototypes
public function string of_set_source (u_dw adw)
end prototypes

event ue_clicked();


//of_set_source( /*u_dw adw */)

event clicked( )
end event

public function string of_set_source (u_dw adw);

idw = adw


RETURN ''


end function

on uo_cb_output.create
end on

on uo_cb_output.destroy
end on

event clicked;





m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent( idw)
NewMenu.m_options.PopMenu(NewMenu.parentwindow.x + NewMenu.parentwindow.x, NewMenu.parentwindow.y + NewMenu.parentwindow.y - 190)
end event

