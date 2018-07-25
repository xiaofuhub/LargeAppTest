$PBExportHeader$w_export_sort_select.srw
forward
global type w_export_sort_select from w_response
end type
type cb_close from commandbutton within w_export_sort_select
end type
type st_1 from statictext within w_export_sort_select
end type
type cb_1 from commandbutton within w_export_sort_select
end type
type dw_sort from u_dw within w_export_sort_select
end type
type dw_fld_list from u_dw within w_export_sort_select
end type
end forward

global type w_export_sort_select from w_response
integer width = 2199
integer height = 1872
string title = "Select Export Sort Fields"
long backcolor = 33551856
cb_close cb_close
st_1 st_1
cb_1 cb_1
dw_sort dw_sort
dw_fld_list dw_fld_list
end type
global w_export_sort_select w_export_sort_select

on w_export_sort_select.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_sort=create dw_sort
this.dw_fld_list=create dw_fld_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_sort
this.Control[iCurrent+5]=this.dw_fld_list
end on

on w_export_sort_select.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_sort)
destroy(this.dw_fld_list)
end on

event open;call super::open;long ll_exp

ll_exp = message.doubleparm

dw_fld_list.retrieve(ll_exp)

end event

event closequery;return 0
end event

type cb_close from commandbutton within w_export_sort_select
integer x = 1819
integer y = 56
integer width = 347
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"CANCEL")
	
end event

type st_1 from statictext within w_export_sort_select
integer x = 105
integer y = 60
integer width = 1079
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Double click field to add or remove."
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_export_sort_select
integer x = 1431
integer y = 56
integer width = 347
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;integer i
integer ic
string ls_field
string ls_sql
string ls_dir

ic = dw_sort.rowcount()
if ic = 0 then 
	messagebox("Sort Fields","No field selected")
	return
end if

dw_sort.sort()

for i = 1 to ic
	ls_field = dw_sort.getitemstring(i,"export_field_name")
	if dw_sort.getitemnumber(i,"rec_id") = 1 then
		ls_dir = "ASC"
	else
		ls_dir = "DESC"
	end if
	
	ls_sql += ls_field + " " + ls_dir + " ,"
next

ls_sql = MidA(ls_sql,1, LenA(ls_sql) - 1)

closewithreturn(parent,ls_sql)
	
end event

type dw_sort from u_dw within w_export_sort_select
integer x = 1083
integer y = 184
integer width = 1088
integer height = 1604
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_export_flds_sort_list"
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;Integer li_row
//integer recid
//datawindowchild dwchild
//
li_row = this.getclickedrow() 

end event

event constructor;
This.of_SetTransObject( SQLCA )
this.of_setupdateable( false)
end event

event doubleclicked;call super::doubleclicked;if row > 0 then
	deleterow(row)
end if
end event

type dw_fld_list from u_dw within w_export_sort_select
integer x = 18
integer y = 184
integer width = 1051
integer height = 1604
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_export_flds_list"
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;Integer li_row

//integer recid
//datawindowchild dwchild
//
li_row = this.getclickedrow() 

this.setrow(li_row)
this.selectrow(0,false)
this.selectrow(li_row,true)


end event

event constructor;
This.of_SetTransObject( SQLCA )
this.of_setupdateable( false)

end event

event rowfocuschanged;call super::rowfocuschanged;Integer li_table_id
long recid
long ll_field
long ll_find
string ls_lookup_type
string ls_type_filter
String ls_field_name, ls_filter_addtl //alfee 01.27.2010
datawindowchild dwchild

//IF NOT lb_new THEN
//	dw_detail.ScrollToRow( currentrow )
//	dw_detail.SetRow( currentrow )
//END IF
IF currentrow < 1 THEN
	Return
END IF

recid = this.getitemnumber(currentrow,"rec_id")

end event

event doubleclicked;call super::doubleclicked;string ls_field
integer i

if row <= 0 then return //(Appeon)Harry 11.19.2013 - V141 for BugH081202 of IntelliCredApp V14.1 History Issues
ls_field = this.getitemstring(row,"export_field_name")

i = dw_sort.insertrow(0)
dw_sort.setitem(i,"export_field_name",ls_field)
dw_sort.setitem(i,"export_order",i)
dw_sort.setitem(i,"rec_id",1)
end event

