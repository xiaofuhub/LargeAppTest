$PBExportHeader$w_alm_snooze.srw
forward
global type w_alm_snooze from w_response
end type
type cb_cancel from commandbutton within w_alm_snooze
end type
type cb_ok from commandbutton within w_alm_snooze
end type
type cbx_loop from checkbox within w_alm_snooze
end type
type cb_delete from commandbutton within w_alm_snooze
end type
type cb_add from commandbutton within w_alm_snooze
end type
type dw_1 from u_dw within w_alm_snooze
end type
end forward

global type w_alm_snooze from w_response
integer width = 1339
integer height = 928
string title = "Advanced Snooze Settings"
long backcolor = 33551856
cb_cancel cb_cancel
cb_ok cb_ok
cbx_loop cbx_loop
cb_delete cb_delete
cb_add cb_add
dw_1 dw_1
end type
global w_alm_snooze w_alm_snooze

type variables
str_pass istr_pass 
Long il_ctx_id,il_incream_value
String is_table, is_column, is_incream_unit
long il_doc_id,il_level_id1,il_level_id2


end variables

forward prototypes
public subroutine of_get_current_snooze ()
public subroutine of_set_current_snooze ()
end prototypes

public subroutine of_get_current_snooze ();Long i

For i = 1 to dw_1.RowCount()
	If dw_1.GetItemNumber(i,'asnooze_executed') = 0 Then
		istr_pass.s_string_array[4] = String(dw_1.GetItemNumber(i,'increment_value') )
		istr_pass.s_string_array[5] = dw_1.GetItemString(i,'increment_unit') 
		Exit
	End If
Next



end subroutine

public subroutine of_set_current_snooze ();Long i

If dw_1.rowcount() = 0 Then
	cb_add.event clicked( )
	dw_1.SetItem(1,'increment_value',il_incream_value)
	dw_1.SetItem(1,'increment_unit',is_incream_unit)
	dw_1.ScrolltoRow(1)
	dw_1.SetRow(1)
	dw_1.SetColumn('increment_value')	
Else
	For i = 1 to dw_1.RowCount()
		If dw_1.GetItemNumber(i,'asnooze_executed') = 0 Then
			If dw_1.GetItemNumber(i,'increment_value') <> il_incream_value Then
				dw_1.SetItem(i,'increment_value',il_incream_value)
			End If
			If dw_1.GetItemString(i,'increment_unit') <> is_incream_unit Then
				dw_1.SetItem(i,'increment_unit',is_incream_unit)
			End If
			If dw_1.GetItemNumber(1,'snooze_loop') = 1 Then
				cbx_loop.Checked = True
			End If
			dw_1.ScrolltoRow(i)
			dw_1.SetRow(i)
			dw_1.SetColumn('increment_value')
			Exit
		End If
	Next
End If


end subroutine

on w_alm_snooze.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cbx_loop=create cbx_loop
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cbx_loop
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.dw_1
end on

on w_alm_snooze.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cbx_loop)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_1)
end on

event open;call super::open;istr_pass = Message.powerobjectparm

il_ctx_id = long(istr_pass.s_string_array[1])
is_table = istr_pass.s_string_array[2]
is_column = istr_pass.s_string_array[3]
il_incream_value = long(istr_pass.s_string_array[4])
is_incream_unit = istr_pass.s_string_array[5]
//add level id - jervis 06.30.2011
il_doc_id = 0
il_level_id1 = long(istr_pass.s_string_array[6])
il_level_id2 = long(istr_pass.s_string_array[7])
dw_1.SetTransObject(SQLCA)

//Modified By Ken.Guo 11/29/2012
//dw_1.Retrieve(il_ctx_id,is_table,is_column,il_doc_id,il_level_id1,il_level_id2)
If il_ctx_id = 0 Then
	istr_pass.s_ds.RowsCopy(1, istr_pass.s_ds.Rowcount(),Primary!,dw_1,1, Primary! )
Else
	dw_1.Retrieve(il_ctx_id,is_table,is_column,il_doc_id,il_level_id1,il_level_id2)
End If


of_set_current_snooze()

end event

event closequery;//Override Ancestor Script
Return 0
end event

type cb_cancel from commandbutton within w_alm_snooze
integer x = 928
integer y = 180
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent,istr_pass)
end event

type cb_ok from commandbutton within w_alm_snooze
integer x = 928
integer y = 52
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;Dw_1.AcceptText()

If il_ctx_id = 0 Then //Added By Ken.Guo 11/29/2012. for batch date alarms
	istr_pass.s_ds.Reset()
	dw_1.RowsCopy(1, dw_1.Rowcount(),Primary!,istr_pass.s_ds,1, Primary! )
	CloseWithReturn(Parent,istr_pass)	
Else
	If dw_1.ModifiedCount() + dw_1.DeletedCount() > 0 Then
		If dw_1.event pfc_validation( ) < 0 Then Return 
		If dw_1.Update() = 1 Then
			of_get_current_snooze()
			CloseWithReturn(Parent,istr_pass)
		End If
	Else
		CloseWithReturn(Parent,istr_pass)	
	End If
End IF

end event

type cbx_loop from checkbox within w_alm_snooze
integer x = 37
integer y = 732
integer width = 343
integer height = 64
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Loop"
end type

event clicked;Integer li_value0[],li_value1[],i

dw_1.AcceptText()
If dw_1.RowCount() = 0 Then Return 

For i = 1 To dw_1.RowCount()
	li_value0[i] = 0
	li_value1[i] = 1
Next

If cbx_loop.checked Then
	dw_1.object.snooze_loop[1,dw_1.Rowcount()] = li_value1[]
	
	If dw_1.GetItemNumber(dw_1.Rowcount(),'asnooze_executed') = 1 Then
		dw_1.object.asnooze_executed[1,dw_1.Rowcount()] = li_value0[]
	End If	
	
Else
	dw_1.object.snooze_loop[1,dw_1.Rowcount()] = li_value0[]
End If




end event

type cb_delete from commandbutton within w_alm_snooze
integer x = 928
integer y = 600
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;If dw_1.GetRow() > 0 Then
	dw_1.DeleteRow(dw_1.GetRow())
	If dw_1.getrow() > 0 then
		dw_1.Scrolltorow(dw_1.getrow())
		dw_1.SetRow(dw_1.getrow())	
		dw_1.SetFocus()
		dw_1.SetColumn('increment_value')
	End If
	
End If
end event

type cb_add from commandbutton within w_alm_snooze
integer x = 928
integer y = 484
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;Long ll_row
ll_row = dw_1.InsertRow(0)

dw_1.Scrolltorow(ll_row)
dw_1.SetRow(ll_row)

dw_1.SetItem(ll_row,'ctx_id',il_ctx_id)
dw_1.SetItem(ll_row,'alm_table',is_table)
dw_1.SetItem(ll_row,'alm_column',is_column)
//add level id- jervis 06.30.2011
dw_1.SetItem(ll_row,'doc_id',il_doc_id)
dw_1.SetItem(ll_row,'level_id1',il_level_id1)
dw_1.SetItem(ll_row,'level_id2',il_level_id2)

If cbx_loop.checked Then
	dw_1.SetItem(ll_row,'snooze_loop',1)
Else
	dw_1.SetItem(ll_row,'snooze_loop',0)
End If
dw_1.Setfocus()
dw_1.SetColumn('increment_value')
end event

type dw_1 from u_dw within w_alm_snooze
integer x = 32
integer y = 36
integer width = 850
integer height = 676
integer taborder = 10
string title = "none"
string dataobject = "d_ctx_alm_snooze"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setrowselect(True)
This.inv_rowselect.of_setstyle(This.inv_rowselect.single )
end event

event pfc_validation;Long i,ll_cnt
long ll_value
ll_cnt = This.RowCount()

For i = 1 To ll_cnt
	ll_value = This.GetItemNumber(i,'increment_value')
	If ll_value = 0 or isnull(ll_value) Then
		This.ScrolltoRow(i)
		This.SetRow(i)
		This.SetColumn("increment_value")		
		Messagebox('Verification','Please input the value.')
		This.Setfocus()
		Return -1
	End If
Next
Return 1

end event

