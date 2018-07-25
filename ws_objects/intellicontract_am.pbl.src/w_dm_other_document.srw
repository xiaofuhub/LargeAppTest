$PBExportHeader$w_dm_other_document.srw
forward
global type w_dm_other_document from w_dm_sell_document
end type
end forward

global type w_dm_other_document from w_dm_sell_document
integer height = 1368
string title = "Buy Side Document Properties"
long backcolor = 33551856
end type
global w_dm_other_document w_dm_other_document

on w_dm_other_document.create
call super::create
end on

on w_dm_other_document.destroy
call super::destroy
end on

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-25 By: Rodger Wu (add other)
/* This window and datawindow are newly added. */
//---------------------------- APPEON END ----------------------------
this.title = "Add Other Document"  
end event

type cbx_preview from w_dm_sell_document`cbx_preview within w_dm_other_document
long backcolor = 33551856
end type

type st_process from w_dm_sell_document`st_process within w_dm_other_document
long backcolor = 33551856
end type

type cb_design from w_dm_sell_document`cb_design within w_dm_other_document
end type

type st_info from w_dm_sell_document`st_info within w_dm_other_document
end type

type cb_preview from w_dm_sell_document`cb_preview within w_dm_other_document
end type

type cb_weblink from w_dm_sell_document`cb_weblink within w_dm_other_document
end type

type cb_4 from w_dm_sell_document`cb_4 within w_dm_other_document
integer y = 1100
end type

type cb_3 from w_dm_sell_document`cb_3 within w_dm_other_document
integer y = 992
end type

type cb_checkin from w_dm_sell_document`cb_checkin within w_dm_other_document
end type

type dw_1 from w_dm_sell_document`dw_1 within w_dm_other_document
integer width = 1737
integer height = 1196
string dataobject = "d_dm_new_other_document"
boolean hscrollbar = false
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

type cb_pastefile from w_dm_sell_document`cb_pastefile within w_dm_other_document
end type

type cb_scan from w_dm_sell_document`cb_scan within w_dm_other_document
end type

