$PBExportHeader$w_letter_painter_ia.srw
forward
global type w_letter_painter_ia from w_response
end type
type uo_letter from pfc_cst_u_letter_painter_ia within w_letter_painter_ia
end type
end forward

global type w_letter_painter_ia from w_response
integer width = 2862
integer height = 2028
long backcolor = 33551856
uo_letter uo_letter
end type
global w_letter_painter_ia w_letter_painter_ia

on w_letter_painter_ia.create
int iCurrent
call super::create
this.uo_letter=create uo_letter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_letter
end on

on w_letter_painter_ia.destroy
call super::destroy
destroy(this.uo_letter)
end on

event open;call super::open;uo_letter.of_Set_Parent_Window( This )
end event

type uo_letter from pfc_cst_u_letter_painter_ia within w_letter_painter_ia
integer y = 28
integer height = 1924
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_letter.destroy
call pfc_cst_u_letter_painter_ia::destroy
end on

