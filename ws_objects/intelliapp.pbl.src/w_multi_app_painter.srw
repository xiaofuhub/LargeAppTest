$PBExportHeader$w_multi_app_painter.srw
$PBExportComments$used with intellicred
forward
global type w_multi_app_painter from w_response
end type
type uo_multi_app from pfc_cst_u_multi_app_painter within w_multi_app_painter
end type
end forward

global type w_multi_app_painter from w_response
integer x = 320
integer y = 160
integer width = 3493
integer height = 2480
string title = "Multi App Setup"
long backcolor = 33551856
uo_multi_app uo_multi_app
end type
global w_multi_app_painter w_multi_app_painter

on w_multi_app_painter.create
int iCurrent
call super::create
this.uo_multi_app=create uo_multi_app
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_multi_app
end on

on w_multi_app_painter.destroy
call super::destroy
destroy(this.uo_multi_app)
end on

event open;call super::open;uo_multi_app.iw_win = This
end event

event closequery;//long.zhang 03.14.2014 rewrite
Integer li_msg

uo_multi_app.dw_app_data.accepttext( )

if uo_multi_app.dw_app_data.modifiedcount( ) + uo_multi_app.dw_app_data.deletedcount( ) > 0 then
	
	li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
						gnv_app.iapp_object.DisplayName, &
						"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
						
	if li_msg = 1 then
		if uo_multi_app.of_save() = -1 then return 1
	elseif li_msg = 2 then
		return 0
	else
		return 1
	end if
end if

return 0
end event

type uo_multi_app from pfc_cst_u_multi_app_painter within w_multi_app_painter
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_multi_app.destroy
call pfc_cst_u_multi_app_painter::destroy
end on

