$PBExportHeader$w_ocr_all_document.srw
forward
global type w_ocr_all_document from w_response
end type
type cb_on_off from commandbutton within w_ocr_all_document
end type
type dw_filter from datawindow within w_ocr_all_document
end type
type cb_settings from commandbutton within w_ocr_all_document
end type
type cb_stop from commandbutton within w_ocr_all_document
end type
type st_process from statictext within w_ocr_all_document
end type
type cb_retrieve from commandbutton within w_ocr_all_document
end type
type st_1 from statictext within w_ocr_all_document
end type
type cb_cancel from commandbutton within w_ocr_all_document
end type
type cb_ocr from commandbutton within w_ocr_all_document
end type
type cb_select from commandbutton within w_ocr_all_document
end type
type dw_doc from u_dw within w_ocr_all_document
end type
type r_on from rectangle within w_ocr_all_document
end type
end forward

global type w_ocr_all_document from w_response
integer width = 3680
integer height = 2192
string title = "OCR Image Document"
boolean controlmenu = false
long backcolor = 33551856
cb_on_off cb_on_off
dw_filter dw_filter
cb_settings cb_settings
cb_stop cb_stop
st_process st_process
cb_retrieve cb_retrieve
st_1 st_1
cb_cancel cb_cancel
cb_ocr cb_ocr
cb_select cb_select
dw_doc dw_doc
r_on r_on
end type
global w_ocr_all_document w_ocr_all_document

type variables
n_cst_image_cp_ocr inv_ocr
Boolean ib_stop = false

String is_type

Integer ii_on_off = 0

Long ii_timer = 60
Long ii_cnt
end variables

forward prototypes
public subroutine of_set_enable (boolean ab_value)
public function integer of_auto_ocr ()
end prototypes

public subroutine of_set_enable (boolean ab_value);cb_select.enabled = ab_value
cb_retrieve.enabled = ab_value
cb_ocr.enabled = ab_value
cb_cancel.enabled = ab_value
cb_settings.enabled = ab_value

dw_doc.Modify("DataWindow.ReadOnly= " + String(Not ab_value) )
dw_doc.enabled = ab_value
cb_stop.enabled = not ab_value
end subroutine

public function integer of_auto_ocr ();Timer(0,This)
ii_cnt = 0

cb_retrieve. Event clicked()
cb_ocr.event clicked( )

If ii_on_off = 1  Then
	Timer(1, This)
End If

Return 1



end function

on w_ocr_all_document.create
int iCurrent
call super::create
this.cb_on_off=create cb_on_off
this.dw_filter=create dw_filter
this.cb_settings=create cb_settings
this.cb_stop=create cb_stop
this.st_process=create st_process
this.cb_retrieve=create cb_retrieve
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ocr=create cb_ocr
this.cb_select=create cb_select
this.dw_doc=create dw_doc
this.r_on=create r_on
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_on_off
this.Control[iCurrent+2]=this.dw_filter
this.Control[iCurrent+3]=this.cb_settings
this.Control[iCurrent+4]=this.cb_stop
this.Control[iCurrent+5]=this.st_process
this.Control[iCurrent+6]=this.cb_retrieve
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.cb_cancel
this.Control[iCurrent+9]=this.cb_ocr
this.Control[iCurrent+10]=this.cb_select
this.Control[iCurrent+11]=this.dw_doc
this.Control[iCurrent+12]=this.r_on
end on

on w_ocr_all_document.destroy
call super::destroy
destroy(this.cb_on_off)
destroy(this.dw_filter)
destroy(this.cb_settings)
destroy(this.cb_stop)
destroy(this.st_process)
destroy(this.cb_retrieve)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ocr)
destroy(this.cb_select)
destroy(this.dw_doc)
destroy(this.r_on)
end on

event open;call super::open;
is_type = Message.Stringparm
If is_type = 'AUTO' Then
	ii_on_off = 1
	dw_doc.dataobject = 'd_ctx_image_document_noocr_list'
	dw_doc.SetTransObject(SQLCA)
	dw_filter.visible = False
	dw_doc.y = dw_filter.y
	dw_doc.height = dw_doc.height + dw_filter.height + 20
Else
	cb_on_off.visible = False
	r_on.visible = False
End If

inv_ocr = Create n_cst_image_cp_ocr

This.of_set_enable(True)

////Added By Mark Lee 05/14/2013
//cb_select.Text = '&Select All'
end event

event close;call super::close;If isvalid(inv_ocr) Then Destroy inv_ocr
end event

event timer;call super::timer;Long ll_left 
ii_cnt ++

ll_left = ii_timer - ii_cnt
If ll_left <= 0 Then
	of_auto_ocr()
Else
	st_process.text =  'Auto-OCR will start in '+ String (ii_timer - ii_cnt)+' seconds.'  
End If

end event

event pfc_postopen;call super::pfc_postopen;cb_retrieve.event clicked( ) 

If is_type = 'AUTO' Then
	cb_select.event clicked( )
	Timer(1,This)
End If


end event

type cb_on_off from commandbutton within w_ocr_all_document
integer x = 1568
integer y = 1988
integer width = 603
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "AUTO OCR ON"
end type

event clicked;integer i
integer c = 0

st_process.text = ''
if ii_on_off = 0 then
	ii_on_off = 1
	Timer(1, Parent)
	this.text = "AUTO OCR ON"
	r_on.fillcolor = RGB(0,255,0)
else 
	Timer(0, Parent)
	ii_on_off = 0
	this.text = "AUTO OCR OFF"
	r_on.fillcolor = RGB(255,0,0)
end if

end event

type dw_filter from datawindow within w_ocr_all_document
event ue_system pbm_syscommand
event ue_filter ( )
integer x = 37
integer y = 28
integer width = 3593
integer height = 272
integer taborder = 10
boolean titlebar = true
string title = "Search"
string dataobject = "d_ocr_result_filter"
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

li_ocr_result = This.GetItemnumber(1,'ocr_result')
If li_ocr_result <> 2 and Not isnull(li_ocr_result) Then
	If ls_filter <> '' Then
		ls_filter +=  ' and is_ocr = ' + String(li_ocr_result)
	Else
		ls_filter +=  ' is_ocr = ' + String(li_ocr_result)
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

type cb_settings from commandbutton within w_ocr_all_document
integer x = 2217
integer y = 1984
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&ettings.."
end type

event clicked;Open(w_ocr_settings)
end event

type cb_stop from commandbutton within w_ocr_all_document
integer x = 2917
integer y = 1984
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&top"
end type

event clicked;ib_stop = True
inv_ocr.of_stop_ocr()
Parent.post of_set_enable(True)

end event

type st_process from statictext within w_ocr_all_document
integer x = 763
integer y = 2004
integer width = 782
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

type cb_retrieve from commandbutton within w_ocr_all_document
integer x = 393
integer y = 1984
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;dw_doc.SetRedraw(False)
dw_doc.retrieve( )
dw_filter.event ue_filter( )
dw_doc.SetRedraw(True)
end event

type st_1 from statictext within w_ocr_all_document
integer x = 59
integer y = 1888
integer width = 2313
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "After OCR, the OCR result will be saved in Database, so it can be used by Global Search function."
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_ocr_all_document
integer x = 3264
integer y = 1984
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

type cb_ocr from commandbutton within w_ocr_all_document
integer x = 2569
integer y = 1984
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OCR"
end type

event clicked;Long i, ll_cnt
long j, ll_selected_cnt
Long ll_find
decimal{1} ldec_reversion
long ll_doc_id
String ls_file
String ls_ocr_text
String ls_doc_ext
n_cst_dm_utils lnv_dm_utils
n_cst_pdf2text lnv_cst_pdf2text

ll_cnt = dw_doc.rowcount()
If ll_cnt = 0 Then Return 

ll_find = dw_doc.find('checked = 1', 1, ll_cnt)
If ll_find <= 0 Then
	//Messagebox('OCR','Please select a document to OCR.')
	st_process.text = 'Please select a document to OCR.'
	Return 
End If

ib_stop = False
of_set_enable(False)
ll_selected_cnt = dw_doc.getitemnumber(ll_cnt,'compute_selected_cnt')

For i = 1 To ll_cnt
	If dw_doc.getItemNumber(i,'checked') = 1 Then
		J++
		st_process.text = 'OCRing Document ' + String(j) + ' of ' + String(ll_selected_cnt) + ' ...'
		dw_doc.SetItem(i,'ocr_result','OCRing ...')		
		dw_doc.SetRow(i)
		dw_doc.Scrolltorow(i)
		
		//Downlaod the document
		ll_doc_id = dw_doc.getItemNumber(i,'ctx_am_document_doc_id') 
		ldec_reversion = dw_doc.getItemNumber(i,'ctx_am_document_revision') 
		ls_file = lnv_dm_utils.of_download_file(ll_doc_id,ldec_reversion)
		If Not FileExists(ls_file) Then
			dw_doc.SetItem(i,'ocr_result','Failed to download the document.')
			Continue
		End If
		
		//OCRing
		ls_ocr_text = '' //Added By Ken.Guo 11/14/2012
		ls_doc_ext = Mid(ls_file, Lastpos(ls_file,'.') + 1)
		If Upper(ls_doc_ext) = 'PDF' Then
			//OCR the document with PDF2text function first for PDF 
			lnv_cst_pdf2text.of_pdf2text(ls_file, ls_ocr_text)
			If ls_ocr_text = '' Then
				//OCR the document with Image CP.
				ls_ocr_text = inv_ocr.of_ocr(ls_file)
			End If
		Else
			//OCR the document with Image CP.
			ls_ocr_text = ''
			ls_ocr_text = inv_ocr.of_ocr(ls_file)			
		End If
		
		Yield()
		If ib_stop Then 
			dw_doc.SetItem(i,'ocr_result','the OCR is stopped.')
			Exit
		End If
			
		If ls_ocr_text = '' Then 
			dw_doc.SetItem(i,'ocr_result','Failed to OCR the document or the OCR result is empty.')
			Continue			
		End If
		
		//Update OCR result to database
		UPDATE ctx_am_doc_image
		SET pdftext = :ls_ocr_text
		WHERE doc_id = :ll_doc_id AND revision = :ldec_reversion;
		If SQLCA.sqlcode = 0 Then
			Commit;
			dw_doc.SetItem(i,'is_ocr',1)
			dw_doc.SetItem(i,'ocr_result','The OCR is completed.')
			Continue			
		Else
			Rollback;
			dw_doc.SetItem(i,'ocr_result','Failed to upload the OCR result to database. ' + sqlca.sqlerrtext )			
		End If
		
	End If
Next

of_set_enable(True)
st_process.text = 'The OCR is completed.'

If ii_on_off = 0 Then
	Messagebox('OCR','The OCR is completed.')
End If


end event

type cb_select from commandbutton within w_ocr_all_document
integer x = 41
integer y = 1984
integer width = 343
integer height = 92
integer taborder = 20
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

type dw_doc from u_dw within w_ocr_all_document
event ue_system pbm_syscommand
integer x = 37
integer y = 320
integer width = 3593
integer height = 1536
integer taborder = 10
boolean titlebar = true
string title = "Browse"
string dataobject = "d_ctx_image_document_list"
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

type r_on from rectangle within w_ocr_all_document
long linecolor = 80269524
integer linethickness = 4
long fillcolor = 65280
integer x = 1541
integer y = 1968
integer width = 654
integer height = 124
end type

