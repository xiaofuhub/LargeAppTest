$PBExportHeader$p_toolbar_pushbutton.sru
forward
global type p_toolbar_pushbutton from p_toolbar_button
end type
end forward

global type p_toolbar_pushbutton from p_toolbar_button
event ue_lbuttonup pbm_lbuttonup
end type
global p_toolbar_pushbutton p_toolbar_pushbutton

event ue_lbuttonup;of_SetUpStatus()

end event

on p_toolbar_pushbutton.create
call super::create
end on

on p_toolbar_pushbutton.destroy
call super::destroy
end on

event ue_mouseaway;of_SetNormalStatus()

end event

event ue_lbuttondown;of_SetDownStatus()

end event

