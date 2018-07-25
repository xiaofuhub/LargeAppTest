$PBExportHeader$w_clause_export_single.srw
forward
global type w_clause_export_single from w_response
end type
type cbx_open from checkbox within w_clause_export_single
end type
type st_3 from statictext within w_clause_export_single
end type
type st_2 from statictext within w_clause_export_single
end type
type st_1 from statictext within w_clause_export_single
end type
type cb_close from commandbutton within w_clause_export_single
end type
type cb_export from commandbutton within w_clause_export_single
end type
type cb_bowse from commandbutton within w_clause_export_single
end type
type sle_file from singlelineedit within w_clause_export_single
end type
type dw_1 from u_dw within w_clause_export_single
end type
end forward

global type w_clause_export_single from w_response
integer width = 1445
integer height = 1340
string title = "Clause Export"
long backcolor = 33551856
event syscommend pbm_syscommand
cbx_open cbx_open
st_3 st_3
st_2 st_2
st_1 st_1
cb_close cb_close
cb_export cb_export
cb_bowse cb_bowse
sle_file sle_file
dw_1 dw_1
end type
global w_clause_export_single w_clause_export_single

type variables
boolean ib_mouse_ldown

end variables

event syscommend;If message.wordparm = 61536 Then
	cb_close.Trigger Event Clicked()
End If

end event

on w_clause_export_single.create
int iCurrent
call super::create
this.cbx_open=create cbx_open
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_export=create cb_export
this.cb_bowse=create cb_bowse
this.sle_file=create sle_file
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_open
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_export
this.Control[iCurrent+7]=this.cb_bowse
this.Control[iCurrent+8]=this.sle_file
this.Control[iCurrent+9]=this.dw_1
end on

on w_clause_export_single.destroy
call super::destroy
destroy(this.cbx_open)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_export)
destroy(this.cb_bowse)
destroy(this.sle_file)
destroy(this.dw_1)
end on

type cbx_open from checkbox within w_clause_export_single
integer x = 27
integer y = 1064
integer width = 1289
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Open the file after export."
boolean checked = true
end type

type st_3 from statictext within w_clause_export_single
integer x = 27
integer y = 304
integer width = 1344
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "(Drag allows you to change the order of the properties)"
boolean focusrectangle = false
end type

type st_2 from statictext within w_clause_export_single
integer x = 23
integer y = 244
integer width = 1221
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Please choose the properties for exported clause:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_clause_export_single
integer x = 23
integer y = 32
integer width = 1454
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Please select a file to save the exported clause:"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_clause_export_single
integer x = 1038
integer y = 1140
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)

end event

type cb_export from commandbutton within w_clause_export_single
integer x = 677
integer y = 1140
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Start Export"
end type

event clicked;String ls_file
Integer i,li_ave_cnt,li_width
Long ll_width_sum
Str_clause_export lstr_clause_export

//Check the options
ls_file = Trim(sle_file.text) 
If ls_file = '' Then
	Messagebox('Export','Please select a file to save the exported clause.')
	sle_file.SetFocus()
	Return
End If

//If Lower(Right(ls_file,4)) <> '.doc' Then
//	Messagebox('Export','Please input a *.doc file to export.')
//	sle_file.SetFocus()
//	Return 1
//End If

ll_width_sum = dw_1.GetItemNumber(Dw_1.rowCount(),'compute_sum_width')
If ll_width_sum > 100 Then
	Messagebox('Export','The entire width is greater than 100.')
	Return
End If

If ll_width_sum = 100 and dw_1.GetItemNumber(Dw_1.rowCount(),'compute_ave_cnt') > 0 Then
	Messagebox('Export','The entire width must be less than 100.') 
	Return
End If

//Check the file whether exists
If FileExists(ls_file) Then
	If Messagebox('Export','The file '+ls_file+' already exists, do you want to replace it?',Question!,YesNo!) = 1 Then
		If Not FileDelete(ls_file) Then 
			Messagebox('Export','Failed to delete the original file '+ls_file+', please check if the source file is being used by other programs.')
			Return -1
		End If
	Else
		Return 0
	End If
End If

//Set the structure element value
lstr_clause_export.as_export_file = ls_file
lstr_clause_export.ab_openfile = cbx_open.checked
ll_width_sum = 0
For i = 1 To dw_1.rowcount()
	If dw_1.GetItemNumber(i,'Selected') = 0 Then Continue
	li_width = dw_1.GetitemNumber(i,'col_width')
	lstr_clause_export.col_name[UpperBound(lstr_clause_export.col_name[]) + 1] = dw_1.GetitemString(i,'col_name')
	lstr_clause_export.col_label[UpperBound(lstr_clause_export.col_label[]) + 1] = dw_1.GetitemString(i,'col_label')
	lstr_clause_export.col_type[UpperBound(lstr_clause_export.col_type[]) + 1] = dw_1.GetitemString(i,'col_type')
	lstr_clause_export.col_width[UpperBound(lstr_clause_export.col_width[]) + 1] = li_width
	If li_width = -1 Then 
		li_ave_cnt++
	Else
		ll_width_sum += li_width
	End If
Next

If li_ave_cnt > 0 Then
	lstr_clause_export.al_ave_width = (100 - ll_width_sum)/li_ave_cnt
End If

CloseWithReturn(Parent,lstr_clause_export)

end event

type cb_bowse from commandbutton within w_clause_export_single
integer x = 1061
integer y = 108
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse..."
end type

event clicked;Integer li_rc
String ls_path,ls_file
gf_load_dir_path() 
li_rc = GetFileSaveName ( "Select File", ls_path, ls_file, "DOC", "Word File (*.doc),*.doc" )
If li_rc <> 1 Then Return
sle_file.text = ls_path

gf_save_dir_path(ls_path)
end event

type sle_file from singlelineedit within w_clause_export_single
integer x = 27
integer y = 108
integer width = 1029
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 134217750
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from u_dw within w_clause_export_single
integer x = 27
integer y = 368
integer width = 1362
integer height = 684
integer taborder = 10
string dataobject = "d_clause_export_cols"
end type

event clicked;call super::clicked;this.DragIcon = "droparrow.ico"
end event

event dragdrop;call super::dragdrop;String ls_col_name
long ll_id
long ll_row

If This <> source Then Return 
If This.GetRow() = row Then Return

ls_col_name = This.GetItemString(Getrow(),'col_name')
If This.PointerY( ) > 624 Then
	ll_row = This.RowCount() + 1
Else
	If row = 0 Then Return
	ll_row = Row
End If
This.Rowsmove( This.GetRow(), This.GetRow(), Primary!, This, ll_row, Primary!)
ll_row = This.Find('col_name = "' + ls_col_name + '"',1,This.RowCount())
If ll_Row > 0 Then
	This.Scrolltorow(ll_Row)
	This.SetRow(ll_Row)
	This.Selectrow( 0,False)
	This.Selectrow(ll_Row,True)
End If
end event

event lbuttondown;call super::lbuttondown;ib_mouse_ldown = true
end event

event lbuttonup;call super::lbuttonup;ib_mouse_ldown = false
end event

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setrowselect(True)
This.inv_rowselect.of_setstyle(This.inv_rowselect.single )

end event

event mousemove;call super::mousemove;if ib_mouse_ldown and this.RowCount() > 0 then
	this.Drag (begin!)
end if
end event

