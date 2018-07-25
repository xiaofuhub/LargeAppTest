$PBExportHeader$w_select_clincopy.srw
forward
global type w_select_clincopy from pfc_w_response
end type
type dw_clin from datawindow within w_select_clincopy
end type
type cb_ok from commandbutton within w_select_clincopy
end type
type cb_cancel from commandbutton within w_select_clincopy
end type
type st_1 from statictext within w_select_clincopy
end type
end forward

global type w_select_clincopy from pfc_w_response
integer x = 713
integer y = 324
integer width = 1655
integer height = 348
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
boolean center = true
dw_clin dw_clin
cb_ok cb_ok
cb_cancel cb_cancel
st_1 st_1
end type
global w_select_clincopy w_select_clincopy

type variables
long il_clin_id
end variables

on w_select_clincopy.create
int iCurrent
call super::create
this.dw_clin=create dw_clin
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_clin
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_1
end on

on w_select_clincopy.destroy
call super::destroy
destroy(this.dw_clin)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_1)
end on

event open;call super::open;integer li_fac

li_fac = message.doubleparm

DataWindowChild dwchild
dw_clin.GetChild( "clinical_area_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(li_fac)
dw_clin.insertrow(0)


end event

event closequery;//ancestor override
end event

type dw_clin from datawindow within w_select_clincopy
integer x = 41
integer y = 140
integer width = 987
integer height = 76
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dddw_clin_area"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_clin_id = long(data)


end event

event constructor;//integer li_row
//dw_clin.settransobject(sqlca)
//dw_clin.retrieve(gi_facil_change)
//dw_clin.InsertRow( 0 )
//
//
//DataWindowChild dwchild
//
//This.GetChild( "clinical_area_description", dwchild )
//
//
//li_row = dwchild.InsertRow( 1 )
//dwchild.scrolltorow(1)
//dwchild.SetItem( 1, "clinical_area_description", "All" )
//dwchild.SetItem( 1, "clinical_area_id", 0 )
il_clin_id = 0
end event

type cb_ok from commandbutton within w_select_clincopy
integer x = 1088
integer y = 136
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;g_str_general lstr_priv
integer li_left
integer li_filtered
integer li_count
integer li_checked
integer i
string f_filter

IF il_clin_id = 0 THEN
	MessageBox("Select Error", "You must first select a Clinical Area." )
	dw_clin.SetFocus( )
	Return 0
END IF



CloseWithReturn( Parent, il_clin_id )
end event

type cb_cancel from commandbutton within w_select_clincopy
integer x = 1349
integer y = 136
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;Closewithreturn(parent,0)

end event

type st_1 from statictext within w_select_clincopy
integer x = 41
integer y = 64
integer width = 960
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select a Clinical Area"
boolean focusrectangle = false
end type

