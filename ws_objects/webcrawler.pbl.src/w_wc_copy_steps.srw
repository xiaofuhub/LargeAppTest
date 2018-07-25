$PBExportHeader$w_wc_copy_steps.srw
forward
global type w_wc_copy_steps from w_response
end type
type em_num from editmask within w_wc_copy_steps
end type
type st_1 from statictext within w_wc_copy_steps
end type
type dw_select from u_dw within w_wc_copy_steps
end type
type gb_1 from groupbox within w_wc_copy_steps
end type
type cb_new from u_cb within w_wc_copy_steps
end type
type cb_quit from u_cb within w_wc_copy_steps
end type
type cb_copy from u_cb within w_wc_copy_steps
end type
type st_exp from statictext within w_wc_copy_steps
end type
type dw_to from datawindow within w_wc_copy_steps
end type
type dw_from from u_dw within w_wc_copy_steps
end type
type cbx_1 from checkbox within w_wc_copy_steps
end type
end forward

global type w_wc_copy_steps from w_response
integer x = 759
integer y = 64
integer width = 1522
integer height = 2132
string title = "Copy Export Fields"
long backcolor = 33551856
em_num em_num
st_1 st_1
dw_select dw_select
gb_1 gb_1
cb_new cb_new
cb_quit cb_quit
cb_copy cb_copy
st_exp st_exp
dw_to dw_to
dw_from dw_from
cbx_1 cbx_1
end type
global w_wc_copy_steps w_wc_copy_steps

type variables
Integer il_export_id
Integer il_table_id
long il_recid
Boolean lb_insert = False

Boolean lb_new = False
end variables

on w_wc_copy_steps.create
int iCurrent
call super::create
this.em_num=create em_num
this.st_1=create st_1
this.dw_select=create dw_select
this.gb_1=create gb_1
this.cb_new=create cb_new
this.cb_quit=create cb_quit
this.cb_copy=create cb_copy
this.st_exp=create st_exp
this.dw_to=create dw_to
this.dw_from=create dw_from
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_num
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_select
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_new
this.Control[iCurrent+6]=this.cb_quit
this.Control[iCurrent+7]=this.cb_copy
this.Control[iCurrent+8]=this.st_exp
this.Control[iCurrent+9]=this.dw_to
this.Control[iCurrent+10]=this.dw_from
this.Control[iCurrent+11]=this.cbx_1
end on

on w_wc_copy_steps.destroy
call super::destroy
destroy(this.em_num)
destroy(this.st_1)
destroy(this.dw_select)
destroy(this.gb_1)
destroy(this.cb_new)
destroy(this.cb_quit)
destroy(this.cb_copy)
destroy(this.st_exp)
destroy(this.dw_to)
destroy(this.dw_from)
destroy(this.cbx_1)
end on

event open;call super::open;integer i
string exportname

il_export_id = message.doubleparm


//select export_name into :exportname from export_header where export_id = :il_export_id;

st_exp.text = exportname

dw_from.settransobject(sqlca)

dw_to.settransobject(sqlca)
dw_select.settransobject(sqlca)
dw_select.retrieve()





end event

type em_num from editmask within w_wc_copy_steps
integer x = 1193
integer y = 400
integer width = 174
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_1 from statictext within w_wc_copy_steps
integer x = 1029
integer y = 412
integer width = 174
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "After #"
boolean focusrectangle = false
end type

type dw_select from u_dw within w_wc_copy_steps
integer x = 224
integer y = 228
integer width = 1038
integer height = 88
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wc_browse_descrip"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )


end event

event itemchanged;call super::itemchanged;integer cnt
integer li_exp
li_exp = Integer( data )


dw_from.Retrieve( li_exp )






end event

type gb_1 from groupbox within w_wc_copy_steps
integer x = 82
integer y = 156
integer width = 1303
integer height = 200
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Crawler from which to Copy Fields"
end type

type cb_new from u_cb within w_wc_copy_steps
integer x = 64
integer y = 1900
integer width = 325
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "Select All"
end type

event clicked;Integer i
Integer li_nr

for i = 1 to dw_from.rowcount()
	dw_from.setitem(i,"selected",1)
next

end event

type cb_quit from u_cb within w_wc_copy_steps
integer x = 951
integer y = 1900
integer width = 279
integer height = 84
integer taborder = 50
boolean bringtotop = true
string text = "Cancel"
boolean cancel = true
end type

event clicked;Parent.Event pfc_close()
end event

type cb_copy from u_cb within w_wc_copy_steps
integer x = 608
integer y = 1900
integer width = 325
integer height = 84
integer taborder = 40
boolean bringtotop = true
string text = "Copy"
boolean cancel = true
end type

event clicked;//maha app 102405 made various modifications for order setting

integer i
integer ic
long recid
integer ord
integer ck

ic  = dw_from.rowcount()
if ic < 1 then return

for i = 1 to ic //copy steps
	if dw_from.getitemnumber(i,"selected") = 1 then
		dw_from.rowscopy(i, i, primary!, dw_to, 10000, 	primary!)
	end if
next

select max(step_order) into :ord from wc_steps where wc_id = :il_export_id;

if isnull(ord) then ord = 0
//if dw_to.rowcount( ) > 0 then
//	ord = dw_to.getitemnumber(dw_to.rowcount(),"step_order")
//else
//	ord = 0
//end if
//select max(rec_id) into :recid from export_fields;
//if len(em_num.text) > 0 then //if after # populated
//	ord = integer(em_num.text)
//	ord++
//	ck = 1
//end if

//if cbx_1.checked then //add to end
//	select max(export_order) into :ord from export_fields where export_id = :il_export_id;
//	if isnull(ord) then ord = 0
//end if

for i = 1 to dw_to.rowcount()
	dw_to.setitem(i,"wc_id",il_export_id)
	//recid++
	//dw_to.setitem(i,"rec_id",recid)
	//if cbx_1.checked then  //add to end
		ord = ord + 10
		dw_to.setitem(i,"step_order",ord)
	//elseif ck = 1 then
	//	dw_to.setitem(i,"step_order",ord)
	//	ord++
	//else
//Start Code Change ---- 01.23.2006 #209 maha
//		ord++
//		dw_to.setitem(i,"export_order",ord)
//End Code Change---01.23.2005 
//	end if
next


dw_to.update()
commit using sqlca;



Parent.Event pfc_close()
end event

type st_exp from statictext within w_wc_copy_steps
integer x = 123
integer y = 44
integer width = 1006
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_to from datawindow within w_wc_copy_steps
boolean visible = false
integer x = 485
integer y = 1908
integer width = 59
integer height = 48
string dataobject = "d_wc_steps_copy"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_from from u_dw within w_wc_copy_steps
integer x = 32
integer y = 496
integer width = 1458
integer height = 1384
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_wc_steps_copy"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_setupdateable(false) 
end event

type cbx_1 from checkbox within w_wc_copy_steps
integer x = 110
integer y = 412
integer width = 695
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add to End of Field List"
end type

