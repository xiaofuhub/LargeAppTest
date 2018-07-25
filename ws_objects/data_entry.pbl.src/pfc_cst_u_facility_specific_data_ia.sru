$PBExportHeader$pfc_cst_u_facility_specific_data_ia.sru
forward
global type pfc_cst_u_facility_specific_data_ia from pfc_cst_u_letter_painter
end type
type dw_path from u_dw within tabpage_browse
end type
type cb_1 from u_cb within pfc_cst_u_facility_specific_data_ia
end type
end forward

global type pfc_cst_u_facility_specific_data_ia from pfc_cst_u_letter_painter
cb_1 cb_1
end type
global pfc_cst_u_facility_specific_data_ia pfc_cst_u_facility_specific_data_ia

on pfc_cst_u_facility_specific_data_ia.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on pfc_cst_u_facility_specific_data_ia.destroy
call super::destroy
destroy(this.cb_1)
end on

type cb_close from pfc_cst_u_letter_painter`cb_close within pfc_cst_u_facility_specific_data_ia
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
end type

type cb_save from pfc_cst_u_letter_painter`cb_save within pfc_cst_u_facility_specific_data_ia
integer weight = 400
string facename = "Segoe UI"
end type

type cb_print from pfc_cst_u_letter_painter`cb_print within pfc_cst_u_facility_specific_data_ia
string facename = "Segoe UI"
end type

type cb_delete from pfc_cst_u_letter_painter`cb_delete within pfc_cst_u_facility_specific_data_ia
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
end type

type cb_add from pfc_cst_u_letter_painter`cb_add within pfc_cst_u_facility_specific_data_ia
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
end type

type tab_letter from pfc_cst_u_letter_painter`tab_letter within pfc_cst_u_facility_specific_data_ia
end type

type tabpage_browse from pfc_cst_u_letter_painter`tabpage_browse within tab_letter
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
end type

type dw_browse from pfc_cst_u_letter_painter`dw_browse within tabpage_browse
integer y = 24
integer height = 1452
end type

type tabpage_detail from pfc_cst_u_letter_painter`tabpage_detail within tab_letter
end type

type dw_detail from pfc_cst_u_letter_painter`dw_detail within tabpage_detail
end type

type dw_path from u_dw within tabpage_browse
integer x = 9
integer y = 1512
integer width = 2263
integer height = 112
integer taborder = 11
string dataobject = "d_get_letter_path"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event pfc_postupdate;call super::pfc_postupdate;String ls_letter_path

ls_letter_path = This.GetItemString( 1, "letter_path" )

UPDATE facility
SET letter_path = :ls_letter_path;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
	RETURN Failure
END IF

Return Success


end event

type cb_1 from u_cb within pfc_cst_u_facility_specific_data_ia
integer x = 2313
integer y = 1628
integer width = 430
integer height = 84
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Browse"
end type

event clicked;call super::clicked;string docname, named

integer value

value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "Doc Files (*.DOC),*.DOC")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value = 1 THEN
	tab_letter.tabpage_browse.dw_path.SetItem( 1, "letter_path", named )	
END IF


end event

