$PBExportHeader$w_columns_select.srw
forward
global type w_columns_select from w_response
end type
type cb_select from commandbutton within w_columns_select
end type
type cb_cancel from commandbutton within w_columns_select
end type
type cb_ok from commandbutton within w_columns_select
end type
type dw_list from u_dw within w_columns_select
end type
type gb_1 from groupbox within w_columns_select
end type
end forward

global type w_columns_select from w_response
integer width = 1170
integer height = 1880
string title = "Contract Search Report"
long backcolor = 33551856
cb_select cb_select
cb_cancel cb_cancel
cb_ok cb_ok
dw_list dw_list
gb_1 gb_1
end type
global w_columns_select w_columns_select

type variables
u_dw idw_search
Long il_width = 3968 ,il_height = 2224
Long il_header_band_h,il_detail_band_h,il_foot_band_h,il_summary_band_h
end variables

forward prototypes
public function integer of_gen_col_list ()
public subroutine of_get_bands_height ()
public function boolean of_is_out_band (string as_col_name)
end prototypes

public function integer of_gen_col_list ();String ls_objects_string,ls_hide_columns_string,ls_coltype
String ls_objects_all[],ls_columns[],ls_columns_label[],ls_column_type[]
String ls_char500,ls_sql,ls_syntax,ls_err
Long i,j,ll_row_cnt,ll_row,ll_columns_x[],ll_column_len[],ll_col_cnt
Integer li_char_len
n_cst_string_appeon lnv_string
DataStore lds_report
ls_char500 = Space(500)

//idw_search.Modify("datawindow.Print.Preview = 'Yes'")

SetPointer(HourGlass!)

ls_objects_string = idw_search.Describe("datawindow.Objects")
lnv_string.of_parsetoarray(ls_objects_string,'~t',ls_objects_all[])

of_get_bands_height()

//Get Visible Columns or Compute 
For i = 1 To UpperBound(ls_objects_all[])
	//If not exists
	If idw_search.Describe(ls_objects_all[i]+'.Attributes') = '!' or idw_search.Describe(ls_objects_all[i]+'.Attributes') = '?' Then Continue
	//If invisible
	If idw_search.Describe(ls_objects_all[i]+'.visible') = '0' Or Pos(Upper(ls_hide_columns_string),'/' + Upper(ls_objects_all[i]) + '/') > 0 Then
		Continue	
	End If
	If Upper(idw_search.Describe(ls_objects_all[i]+'.type')) = 'COLUMN' Or Upper(idw_search.Describe(ls_objects_all[i]+'.type')) = 'COMPUTE' Then
		If of_is_out_band(ls_objects_all[i]) Then Continue
		ls_columns[UpperBound(ls_columns[]) + 1] = ls_objects_all[i]
		ll_columns_x[UpperBound(ll_columns_x[]) + 1] = Long(idw_search.Describe(ls_objects_all[i]+'.x'))
		
		//Gen column label
		If Len(idw_search.Describe(ls_objects_all[i] + '_t.Attributes')) > 1 Then
			ls_columns_label[UpperBound(ls_columns_label[]) + 1] = idw_search.Describe(ls_objects_all[i] + '_t.Text')
		Else
			If Len(idw_search.Describe(Left(ls_objects_all[i],Len(ls_objects_all[i]) - 2) + '_t.Attributes')) > 1 Then
				//For Compute Column
				ls_columns_label[UpperBound(ls_columns_label[]) + 1] = idw_search.Describe(Left(ls_objects_all[i],Len(ls_objects_all[i]) - 2) + '_t.Text')
			Else
				ls_columns_label[UpperBound(ls_columns_label[]) + 1] = ls_objects_all[i]
			End If
		End If
		
		//Gen column length
		ls_coltype = idw_search.Describe(ls_objects_all[i] + '.coltype')
		ls_column_type[UpperBound(ls_column_type[]) + 1] = ls_coltype //Added By Ken.Guo 04/19/2012		
		Choose Case Left(Lower(ls_coltype),5)
			Case 'char(','char'
				li_char_len = Integer(Mid(ls_coltype,6,2))
				If li_char_len > 0 Then
					ll_column_len[UpperBound(ll_column_len[]) + 1] = li_char_len
				Else
					ll_column_len[UpperBound(ll_column_len[]) + 1] = 150
				End If
			Case 'date','datet'
				ll_column_len[UpperBound(ll_column_len[]) + 1] = 20 
			Case Else //'decim','real','int','long','numbe','ulong'
				Choose Case lower(ls_objects_all[i])
					Case 'app_facility'
						ll_column_len[UpperBound(ll_column_len[]) + 1] = 150
					Case 'ctx_id','master_contract_id','master_cnt'
						ll_column_len[UpperBound(ll_column_len[]) + 1] = 15
					Case Else
						ll_column_len[UpperBound(ll_column_len[]) + 1] = 75		
				End Choose
		End Choose
	End If
Next

ll_col_cnt = UpperBound(ls_columns[])
If  ll_col_cnt > 0 Then 
	dw_list.SetRedraw(False)
	For i = 1 To ll_col_cnt
		dw_list.InsertRow(0)
	Next
	dw_list.object.col_name[1,ll_col_cnt] = ls_columns[]
	dw_list.object.col_label[1,ll_col_cnt] = ls_columns_label[]
	dw_list.object.col_x[1,ll_col_cnt] = ll_columns_x[]
	dw_list.object.col_length[1,ll_col_cnt] = ll_column_len[]
	dw_list.object.col_type[1,ll_col_cnt] = ls_column_type[] //Added By Ken.Guo 04/19/2012
	dw_list.SetSort('col_x Asc')
	dw_list.Sort()
	dw_list.SetRedraw(True)
Else
	cb_ok.enabled = False
	Return -1
End If

Return 1
end function

public subroutine of_get_bands_height ();il_header_band_h	=	Long(idw_search.Describe("DataWindow.Header.Height"))
il_detail_band_h	=	Long(idw_search.Describe("DataWindow.Detail.Height"))
il_foot_band_h		=	Long(idw_search.Describe("DataWindow.Footer.Height"))
il_summary_band_h	=	Long(idw_search.Describe("DataWindow.Summary.Height"))



end subroutine

public function boolean of_is_out_band (string as_col_name);String ls_band
Long ll_y
ls_band = idw_search.Describe(as_col_name+ ".Band")
ll_y = Long(idw_search.Describe(as_col_name+ ".y"))
Choose Case lower(ls_band)
	Case 'header'
		If ll_y >= il_header_band_h Then Return True
	Case 'detail'
		If ll_y >= il_detail_band_h Then Return True
	Case 'summary'
		If ll_y >= il_summary_band_h Then Return True
	Case 'footer'
		If ll_y >= il_foot_band_h Then Return True
End Choose

Return False



end function

on w_columns_select.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_list=create dw_list
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.gb_1
end on

on w_columns_select.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_list)
destroy(this.gb_1)
end on

event open;call super::open;If isvalid(Message.powerobjectparm) Then
	idw_search = Message.powerobjectparm
Else
	Messagebox('Error','Failed to get data, please call support')
	Close(This)
End If

of_gen_col_list()



end event

type cb_select from commandbutton within w_columns_select
integer x = 14
integer y = 1664
integer width = 379
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "De&select ALL"
end type

event clicked;Long i, ll_cnt
Integer li_value_0[],li_value_1[]

ll_cnt = dw_list.RowCount()
If ll_cnt < 1 Then Return 1
For i = 1 To ll_cnt
	li_value_0[UpperBound(li_value_0[]) + 1 ] = 0
	li_value_1[UpperBound(li_value_1[]) + 1 ] = 1	
Next

If This.Text = '&Select ALL' Then
	dw_list.object.selected[1,ll_cnt] = li_value_1[]
	This.Text = 'De&select ALL'
Else
	dw_list.object.selected[1,ll_cnt] = li_value_0[]
	This.Text = '&Select ALL'
End If

end event

type cb_cancel from commandbutton within w_columns_select
integer x = 782
integer y = 1664
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

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_columns_select
integer x = 439
integer y = 1664
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

event clicked;Long ll_cnt
str_print_search_dw lstr_search

dw_list.SetFilter('Selected = 1')
dw_list.Filter()

ll_cnt = dw_list.RowCount()
If ll_cnt = 0 Then
	Messagebox('Selection Error','You must at least select one column.')
	Return -1
End If

lstr_search.col_name[] = dw_list.object.col_name[1,ll_cnt]
lstr_search.col_label[] = dw_list.object.col_label[1,ll_cnt]
lstr_search.col_length[] = dw_list.object.col_length[1,ll_cnt]
lstr_search.col_x[] = dw_list.object.col_x[1,ll_cnt]
lstr_search.col_type[] = dw_list.object.col_type[1,ll_cnt]
lstr_search.adw_search = idw_search

Hide(Parent)
OpenWithParm(w_ctx_search_print,lstr_search)
Close(Parent)

end event

type dw_list from u_dw within w_columns_select
integer x = 46
integer y = 88
integer width = 1051
integer height = 1512
integer taborder = 10
string title = "none"
string dataobject = "d_ctx_search_column_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(False)
end event

type gb_1 from groupbox within w_columns_select
integer x = 14
integer y = 28
integer width = 1115
integer height = 1600
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Selected Columns"
end type

