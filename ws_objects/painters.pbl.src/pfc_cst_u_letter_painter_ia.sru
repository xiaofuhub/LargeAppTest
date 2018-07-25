$PBExportHeader$pfc_cst_u_letter_painter_ia.sru
forward
global type pfc_cst_u_letter_painter_ia from pfc_cst_u_letter_painter
end type
type dw_path from u_dw within tabpage_browse
end type
end forward

global type pfc_cst_u_letter_painter_ia from pfc_cst_u_letter_painter
integer width = 2871
integer height = 1932
end type
global pfc_cst_u_letter_painter_ia pfc_cst_u_letter_painter_ia

on pfc_cst_u_letter_painter_ia.create
int iCurrent
call super::create
end on

on pfc_cst_u_letter_painter_ia.destroy
call super::destroy
end on

type cb_close from pfc_cst_u_letter_painter`cb_close within pfc_cst_u_letter_painter_ia
integer x = 2405
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
end type

type cb_save from pfc_cst_u_letter_painter`cb_save within pfc_cst_u_letter_painter_ia
integer x = 827
integer weight = 400
string facename = "Segoe UI"
end type

event cb_save::clicked;call super::clicked;String ls_letter_path

ls_letter_path = tab_letter.tabpage_browse.dw_path.GetItemString( 1, "letter_path" )

UPDATE facility
SET letter_path = :ls_letter_path;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF




end event

type cb_print from pfc_cst_u_letter_painter`cb_print within pfc_cst_u_letter_painter_ia
integer x = 1998
string facename = "Segoe UI"
end type

type cb_delete from pfc_cst_u_letter_painter`cb_delete within pfc_cst_u_letter_painter_ia
integer x = 1600
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
end type

type cb_add from pfc_cst_u_letter_painter`cb_add within pfc_cst_u_letter_painter_ia
integer x = 1225
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
end type

type tab_letter from pfc_cst_u_letter_painter`tab_letter within pfc_cst_u_letter_painter_ia
integer width = 2830
end type

type tabpage_browse from pfc_cst_u_letter_painter`tabpage_browse within tab_letter
integer width = 2793
dw_path dw_path
end type

on tabpage_browse.create
this.dw_path=create dw_path
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_path
end on

on tabpage_browse.destroy
call super::destroy
destroy(this.dw_path)
end on

type dw_1 from pfc_cst_u_letter_painter`dw_1 within tabpage_browse
end type

type st_1 from pfc_cst_u_letter_painter`st_1 within tabpage_browse
integer x = 50
integer y = 44
end type

type dw_browse from pfc_cst_u_letter_painter`dw_browse within tabpage_browse
integer x = 5
integer height = 1540
end type

type tabpage_detail from pfc_cst_u_letter_painter`tabpage_detail within tab_letter
integer width = 2793
end type

type dw_detail from pfc_cst_u_letter_painter`dw_detail within tabpage_detail
integer x = 0
integer y = 0
integer width = 2793
integer height = 1764
end type

type dw_path from u_dw within tabpage_browse
integer x = 9
integer y = 1672
integer width = 2784
integer height = 124
integer taborder = 11
string dataobject = "d_get_letter_path"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
This.Retrieve( )

This.InsertRow( 0 )

This.Of_SetUpdateAble( False )
end event

