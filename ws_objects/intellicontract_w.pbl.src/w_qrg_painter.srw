$PBExportHeader$w_qrg_painter.srw
$PBExportComments$Painter window for contract reports
forward
global type w_qrg_painter from w_response
end type
type uo_1 from u_tabpg_qrg_selection within w_qrg_painter
end type
end forward

global type w_qrg_painter from w_response
integer width = 3954
integer height = 2352
string title = "QRG Painter"
long backcolor = 33551856
uo_1 uo_1
end type
global w_qrg_painter w_qrg_painter

event open;call super::open;//
end event

on w_qrg_painter.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_qrg_painter.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from u_tabpg_qrg_selection within w_qrg_painter
integer x = 5
integer y = 20
integer taborder = 41
end type

on uo_1.destroy
call u_tabpg_qrg_selection::destroy
end on

