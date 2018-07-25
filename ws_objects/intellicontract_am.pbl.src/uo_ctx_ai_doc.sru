$PBExportHeader$uo_ctx_ai_doc.sru
$PBExportComments$Action Items User object
forward
global type uo_ctx_ai_doc from u_base
end type
type tab_1 from u_tab_action_items_doc within uo_ctx_ai_doc
end type
type tab_1 from u_tab_action_items_doc within uo_ctx_ai_doc
end type
end forward

global type uo_ctx_ai_doc from u_base
integer width = 3543
integer height = 1956
long backcolor = 33551856
tab_1 tab_1
end type
global uo_ctx_ai_doc uo_ctx_ai_doc

on uo_ctx_ai_doc.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on uo_ctx_ai_doc.destroy
call super::destroy
destroy(this.tab_1)
end on

event constructor;call super::constructor;//Added by Alan on 2009-1-4
//BugS040903
this.of_SetResize(true)
this.inv_resize.of_SetOrigSize(3506,1932)
this.inv_resize.of_Register(tab_1, this.inv_resize.scale)
this.triggerevent("resize")
end event

type tab_1 from u_tab_action_items_doc within uo_ctx_ai_doc
integer x = 5
integer width = 3520
integer taborder = 11
end type

