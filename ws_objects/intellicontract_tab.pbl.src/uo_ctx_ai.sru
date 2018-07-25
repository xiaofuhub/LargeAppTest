$PBExportHeader$uo_ctx_ai.sru
$PBExportComments$Action Items User object
forward
global type uo_ctx_ai from u_base
end type
type tab_1 from u_tab_action_items within uo_ctx_ai
end type
type tab_1 from u_tab_action_items within uo_ctx_ai
end type
end forward

global type uo_ctx_ai from u_base
integer width = 3465
integer height = 1888
long backcolor = 33551856
tab_1 tab_1
end type
global uo_ctx_ai uo_ctx_ai

on uo_ctx_ai.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on uo_ctx_ai.destroy
call super::destroy
destroy(this.tab_1)
end on

type tab_1 from u_tab_action_items within uo_ctx_ai
integer x = 5
integer width = 3415
integer height = 1884
integer taborder = 11
end type

