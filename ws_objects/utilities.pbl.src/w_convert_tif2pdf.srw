$PBExportHeader$w_convert_tif2pdf.srw
forward
global type w_convert_tif2pdf from w_response
end type
type st_1 from statictext within w_convert_tif2pdf
end type
type dw_filter from datawindow within w_convert_tif2pdf
end type
type cb_stop from commandbutton within w_convert_tif2pdf
end type
type st_process from statictext within w_convert_tif2pdf
end type
type cb_retrieve from commandbutton within w_convert_tif2pdf
end type
type cb_cancel from commandbutton within w_convert_tif2pdf
end type
type cb_convert from commandbutton within w_convert_tif2pdf
end type
type cb_select from commandbutton within w_convert_tif2pdf
end type
type dw_doc from u_dw within w_convert_tif2pdf
end type
end forward

global type w_convert_tif2pdf from w_response
integer width = 2624
integer height = 2184
string title = "Batch Convert Image Document to PDF"
boolean controlmenu = false
long backcolor = 33551856
st_1 st_1
dw_filter dw_filter
cb_stop cb_stop
st_process st_process
cb_retrieve cb_retrieve
cb_cancel cb_cancel
cb_convert cb_convert
cb_select cb_select
dw_doc dw_doc
end type
global w_convert_tif2pdf w_convert_tif2pdf

type variables
n_cst_dm_utils  inv_dm_utils
Boolean ib_stop = false
end variables

forward prototypes
public subroutine of_set_enable (boolean ab_value)
end prototypes

public subroutine of_set_enable (boolean ab_value);cb_select.enabled = ab_value
cb_retrieve.enabled = ab_value
cb_convert.enabled = ab_value
cb_cancel.enabled = ab_value


dw_doc.Modify("DataWindow.ReadOnly= " + String(Not ab_value) )
dw_doc.enabled = ab_value
cb_stop.enabled = not ab_value
end subroutine

on w_convert_tif2pdf.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_filter=create dw_filter
this.cb_stop=create cb_stop
this.st_process=create st_process
this.cb_retrieve=create cb_retrieve
this.cb_cancel=create cb_cancel
this.cb_convert=create cb_convert
this.cb_select=create cb_select
this.dw_doc=create dw_doc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_filter
this.Control[iCurrent+3]=this.cb_stop
this.Control[iCurrent+4]=this.st_process
this.Control[iCurrent+5]=this.cb_retrieve
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.cb_convert
this.Control[iCurrent+8]=this.cb_select
this.Control[iCurrent+9]=this.dw_doc
end on

on w_convert_tif2pdf.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_filter)
destroy(this.cb_stop)
destroy(this.st_process)
destroy(this.cb_retrieve)
destroy(this.cb_cancel)
destroy(this.cb_convert)
destroy(this.cb_select)
destroy(this.dw_doc)
end on

event open;call super::open;cb_retrieve.post event clicked( ) 
This.of_set_enable(True)

end event

event pfc_postopen;call super::pfc_postopen;If isvalid(gw_contract) Then
	messagebox('tip','Please close the Contract window before you converting.')
End If
end event

type st_1 from statictext within w_convert_tif2pdf
integer x = 50
integer y = 1880
integer width = 2519
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "This function will batch convert the image files to PDF format, this process is irreversible."
boolean focusrectangle = false
end type

type dw_filter from datawindow within w_convert_tif2pdf
event ue_system pbm_syscommand
event ue_filter ( )
integer x = 37
integer y = 28
integer width = 2533
integer height = 272
integer taborder = 10
boolean titlebar = true
string title = "Search"
string dataobject = "d_tif_document_filter"
boolean livescroll = true
end type

event ue_system;If message.wordparm = 61458 Then
	Return -1
End If

end event

event ue_filter();String ls_doc_type
integer li_ocr_result
Long ll_ctx_id
String ls_filter

This.AcceptText()
ll_ctx_id = This.GetItemNumber(1,'ctx_id')
If ll_ctx_id > 0 Then
	ls_filter = ' ctx_am_document_ctx_id = ' + String(ll_ctx_id)
End If

ls_doc_type = This.GetItemString(1,'doc_type')
If ls_doc_type <> 'ALL' and Not isnull(ls_doc_type) Then
	If ls_filter <> '' Then
		ls_filter +=  ' and Upper(ctx_am_document_doc_ext) = "' +Upper(ls_doc_type)+ '"'
	Else
		ls_filter +=  ' Upper(ctx_am_document_doc_ext) = "' +Upper(ls_doc_type)+ '"'
	End If
End If

SetPointer(HourGlass!)
dw_doc.SetRedraw(False)
dw_doc.VScrollbar = False
dw_doc.SetFilter(ls_filter)
dw_doc.Filter()
dw_doc.SetSort('ctx_am_document_ctx_id Asc, ctx_am_document_doc_name Asc')
dw_doc.Sort()
dw_doc.groupcalc( )
dw_doc.VScrollbar = True
dw_doc.SetRedraw(True)
SetPointer(Arrow!)

end event

event constructor;This.InsertRow(0)
end event

event buttonclicked;Choose Case dwo.name
	Case 'b_clear'
		dw_filter.Reset()
		dw_filter.InsertRow(0)
	Case 'b_filter'
		This.event ue_filter( )
End Choose
end event

type cb_stop from commandbutton within w_convert_tif2pdf
boolean visible = false
integer x = 1513
integer y = 1972
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&top"
end type

event clicked;ib_stop = True
Parent.post of_set_enable(True)

end event

type st_process from statictext within w_convert_tif2pdf
integer x = 791
integer y = 1992
integer width = 699
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_convert_tif2pdf
integer x = 393
integer y = 1972
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;dw_doc.retrieve( )
dw_filter.event ue_filter( )
end event

type cb_cancel from commandbutton within w_convert_tif2pdf
integer x = 2222
integer y = 1972
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_convert from commandbutton within w_convert_tif2pdf
integer x = 1870
integer y = 1972
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Con&vert"
end type

event clicked;Long i, ll_cnt
long j, ll_selected_cnt
Long ll_find
decimal{1} ldec_reversion
long ll_doc_id
String ls_file
String ls_doc_ext
Integer li_ret
n_cst_dm_utils lnv_dm_utils


ll_cnt = dw_doc.rowcount()
If ll_cnt = 0 Then Return 

ll_find = dw_doc.find('checked = 1', 1, ll_cnt)
If ll_find <= 0 Then
	Messagebox('Convert','Please select a document to Convert.')
	Return 
End If

ib_stop = False
of_set_enable(False)
ll_selected_cnt = dw_doc.getitemnumber(ll_cnt,'compute_selected_cnt')

SetPointer(HourGlass!)
For i = 1 To ll_cnt
	Yield()
	If dw_doc.getItemNumber(i,'checked') = 1 Then
		J++
		st_process.text = 'Converting Document ' + String(j) + ' of ' + String(ll_selected_cnt) + ' ...'
		dw_doc.SetItem(i,'convert_result','Converting ...')		
		dw_doc.SetRow(i)
		dw_doc.Scrolltorow(i)
		
		ls_doc_ext = dw_doc.getItemString(i,'ctx_am_document_doc_ext')   		
		If Upper(ls_doc_ext) = 'PDF' Then
			dw_doc.SetItem(i,'convert_result','Need not convert for PDF file.')	
			Continue
		End If
		
		//Downlaod the document
		ll_doc_id = dw_doc.getItemNumber(i,'ctx_am_document_doc_id') 
		//ldec_reversion = dw_doc.getItemNumber(i,'ctx_am_document_revision') 
		//Get newest revision.
		Select max(revision) into :ldec_reversion from ctx_am_document Where doc_id = :ll_doc_id;
		
		ls_file = lnv_dm_utils.of_download_file(ll_doc_id,ldec_reversion)
		If Not FileExists(ls_file) Then
			dw_doc.SetItem(i,'convert_result','Failed to download the document.')
			Continue
		End If
		
		li_ret = lnv_dm_utils.of_convert2pdf(ll_doc_id , ldec_reversion, ls_file, ls_doc_ext)
		If li_ret < 0 Then
			dw_doc.SetItem(i,'convert_result','Failed to convert the document.')
			Continue
		End If
		
		//Set new information for document
		dw_doc.SetItem(i,'ctx_am_document_revision',ldec_reversion)
		dw_doc.SetItem(i,'ctx_am_document_doc_ext','pdf')
		dw_doc.SetItem(i,'convert_result','Successful.')
		
		//Yield()
		If ib_stop Then 
			Exit
		End If
		
	End If
Next
SetPointer(Arrow!)
of_set_enable(True)
st_process.text = 'The converting is completed.'
Messagebox('Convert','The converting is completed.')


end event

type cb_select from commandbutton within w_convert_tif2pdf
integer x = 41
integer y = 1972
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select All"
end type

event clicked;Integer li_value0[], li_value1[]
long i,ll_cnt

ll_cnt = dw_doc.rowcount() 
If ll_cnt = 0 Then Return

For i = 1 to ll_cnt
	li_value0[i] = 0
	li_value1[i] = 1
Next

If This.text = '&Deselect All' Then
	This.Text = '&Select All'
	dw_doc.object.checked[1,ll_cnt] = li_value0[]
Else
	This.Text = '&Deselect All'
	dw_doc.object.checked[1,ll_cnt] = li_value1[]
End If

end event

type dw_doc from u_dw within w_convert_tif2pdf
event ue_system pbm_syscommand
integer x = 37
integer y = 320
integer width = 2533
integer height = 1536
integer taborder = 20
boolean titlebar = true
string title = "Browse"
string dataobject = "d_ctx_tif_document_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event ue_system;If message.wordparm = 61458 Then
	Return -1
End If
end event

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setrowselect(True)
This.inv_rowselect.of_setstyle(This.inv_rowselect.single )

This.SetTransObject(SQLCA)



end event

event clicked;call super::clicked;str_add_doc lstr_doc_info

If row <= 0 Then Return

If dwo.name = 'p_ocr_green' Then
	lstr_doc_info.doc_id = dw_doc.GetItemNumber(row,'ctx_am_document_doc_id')
	lstr_doc_info.revision = dw_doc.GetItemDecimal(row,'ctx_am_document_revision')
	lstr_doc_info.filename = dw_doc.GetItemString(row,'compute_doc_name')	
	OpenwithParm(w_view_ocr_result,lstr_doc_info )	
End If

end event

