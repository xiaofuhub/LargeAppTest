$PBExportHeader$w_view_ocr_result.srw
forward
global type w_view_ocr_result from w_response
end type
type cbx_match_case from checkbox within w_view_ocr_result
end type
type cb_find from commandbutton within w_view_ocr_result
end type
type sle_find from singlelineedit within w_view_ocr_result
end type
type cb_close from commandbutton within w_view_ocr_result
end type
type cb_update from commandbutton within w_view_ocr_result
end type
type mle_ocr_text from multilineedit within w_view_ocr_result
end type
end forward

global type w_view_ocr_result from w_response
integer width = 2619
integer height = 2056
long backcolor = 33551856
cbx_match_case cbx_match_case
cb_find cb_find
sle_find sle_find
cb_close cb_close
cb_update cb_update
mle_ocr_text mle_ocr_text
end type
global w_view_ocr_result w_view_ocr_result

type variables
Long il_doc_id
Decimal{1} idec_revision
String is_ocr_org
String is_doc_name
long il_page_lines = 33 //If changed MLE control, must reset this value. //Added By Ken.Guo 2010-02-01. for workaround APB bug.
end variables

forward prototypes
public function integer of_get_ocr_result (long al_doc_id, decimal adc_revision, ref string as_ocr_result)
public function integer of_set_ocr_text (string as_text)
end prototypes

public function integer of_get_ocr_result (long al_doc_id, decimal adc_revision, ref string as_ocr_result);string ls_data
Integer li_ret
n_cst_image_cp_ocr lnv_ocr
lnv_ocr = Create n_cst_image_cp_ocr
li_ret = lnv_ocr.of_get_ocr_result(al_doc_id, adc_revision, as_ocr_result, 'dm')
Destroy lnv_ocr
Return li_ret

/*
Integer li_counter, li_loops, li_MaxPosition, li_Position
Integer li_SetStep, li_NewStep, li_loopsR, li_rtn
Long ll_start, ll_data_length
String ls_title
Boolean lb_needrestore = FALSE
string ls_data, ls_all_data

SetPointer(HourGlass!) 

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	
	// Get file data from database
	SELECT Datalength(pdftext)
	INTO :ll_data_length
	FROM ctx_am_doc_image
	WHERE doc_id = :al_doc_id
	AND revision = :adc_revision;
	
	IF SQLCA.SQLCODE = -1 THEN 
		MessageBox( "OCR", "Download OCR Text failed! ~r~n" + SQLCA.SQLERRTEXT )
		RETURN -1 
	End If
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		RETURN 0
	END IF
	
	//Get length of the blob
	IF ll_data_length > 8000 THEN 
		 IF Mod(ll_data_length,8000) = 0 THEN 
			  li_loops = ll_data_length/8000 
		 ELSE 
			  li_loops = (ll_data_length/8000) + 1 
		 END IF 
	ELSE 
		 li_loops = 1 
	END IF 
	
	li_NewStep = 20
	IF li_loops > li_NewStep THEN
		IF Not IsValid(w_appeon_gifofwait) THEN 
			OpenwithParm(w_appeon_gifofwait,"Getting the data...")
		END IF
		//Set the new progress bar
		li_loopsR = li_loops / li_NewStep
		IF Mod(li_loops, li_NewStep) <> 0 THEN li_loopsR ++
		w_appeon_gifofwait.st_1.Text = "Getting the data..."
		w_appeon_gifofwait.hpb_1.MaxPosition = li_loopsR * li_NewStep
		w_appeon_gifofwait.hpb_1.Position = 0
		w_appeon_gifofwait.hpb_1.SetStep = li_loopsR		
	END IF
	
	//Get and store the blob
	li_rtn = 1
	FOR li_counter = 1 to li_loops
		ll_start = (li_counter - 1) * 8000 + 1
		SELECT substring(pdftext,:ll_start,8000)
				INTO :ls_data
				FROM ctx_am_doc_image
				WHERE doc_id = :al_doc_id
				AND revision = :adc_revision;
		IF SQLCA.SQLCODE = -1 THEN 
			li_rtn = -1
			EXIT
		END IF
		
		ls_all_data += ls_data
		
		//Change the progress bar
		IF IsValid(w_appeon_gifofwait) AND li_loops > li_NewStep THEN
			IF Mod(li_counter, li_loopsR) = 1 THEN w_appeon_gifofwait.hpb_1.StepIt() 
		ELSE
			IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
		END IF
	NEXT 

	IF IsValid(w_appeon_gifofwait)  THEN 
		Close(w_appeon_gifofwait)
	END IF
	
	//Store the blob
	as_ocr_result = ls_all_data
Else //WEB, JDBC Driver.
	SELECT pdftext
			INTO :ls_data
			FROM ctx_am_doc_image
			WHERE doc_id = :al_doc_id
			AND revision = :adc_revision;
	IF SQLCA.SQLCODE = -1 THEN 
		MessageBox( "OCR", "Download OCR Text failed! ~r~n" + SQLCA.SQLERRTEXT )
		Return -1
	End If
	as_ocr_result = ls_data
END IF	

Return 1
*/
end function

public function integer of_set_ocr_text (string as_text);Long ll_row
Datawindow ldw_browse
If isvalid(gw_contract) Then
	If isvalid(gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse) Then
		ldw_browse = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse
		If ldw_browse.Rowcount() > 0 Then
			ll_row = ldw_browse.GetRow()
			If il_doc_id = ldw_browse.GetItemNumber(ll_row,'doc_id') and &
				idec_revision	=ldw_browse.GetItemDecimal(ll_row,'revision') Then
					gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.uo_2.of_set_ocr_result(as_text)
			End If
 		End If
	End If
End If

Return 1
end function

on w_view_ocr_result.create
int iCurrent
call super::create
this.cbx_match_case=create cbx_match_case
this.cb_find=create cb_find
this.sle_find=create sle_find
this.cb_close=create cb_close
this.cb_update=create cb_update
this.mle_ocr_text=create mle_ocr_text
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_match_case
this.Control[iCurrent+2]=this.cb_find
this.Control[iCurrent+3]=this.sle_find
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_update
this.Control[iCurrent+6]=this.mle_ocr_text
end on

on w_view_ocr_result.destroy
call super::destroy
destroy(this.cbx_match_case)
destroy(this.cb_find)
destroy(this.sle_find)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.mle_ocr_text)
end on

event open;call super::open;Integer li_ret
String ls_ocr
str_add_doc lstr_doc_info
lstr_doc_info = Message.Powerobjectparm

il_doc_id = lstr_doc_info.doc_id
idec_revision = lstr_doc_info.revision
is_doc_name = lstr_doc_info.filename

this.title = "OCR Result Viewer - " + is_doc_name

li_ret = This.of_get_ocr_result(il_doc_id,idec_revision,is_ocr_org)

If li_ret > 0 Then
	mle_ocr_text.text = is_ocr_org
End If
cb_update.enabled = False
end event

event key;call super::key;GraphicObject luo_focus
If key = KeyEnter! Then
	luo_focus = GetFocus()
	If Not isvalid(luo_focus) Then Return
	If luo_focus.classname( ) = 'sle_find' Then
		cb_find.event clicked( )
	End If
End If

end event

type cbx_match_case from checkbox within w_view_ocr_result
integer x = 969
integer y = 1864
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Match case"
end type

type cb_find from commandbutton within w_view_ocr_result
integer x = 603
integer y = 1848
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
end type

event clicked;String ls_text
String ls_find_text
Long ll_pos,ll_line


If cbx_match_case.checked Then //Added By Ken.Guo 2011-03-21.
	ls_text = mle_ocr_text.text
	ls_find_text = sle_find.text
Else
	ls_text = Lower(mle_ocr_text.text)
	ls_find_text = lower(sle_find.text)
End If

//Search begin by focus postion
ll_pos = Pos(ls_text, ls_find_text, mle_ocr_text.selectedstart( ) + mle_ocr_text.SelectedLength ( ) )
If ll_pos > 0 Then
	mle_ocr_text.selecttext(ll_pos ,len(ls_find_text))
	//Added By Ken.Guo 2010-02-01. Workaround APB bug. selecttext() function do not scroll to the current line.
	ll_line = mle_ocr_text.selectedline()
	mle_ocr_text.SetRedraw(False)
	mle_ocr_text.scroll(-100000)
	If ll_line > il_page_lines Then
		mle_ocr_text.scroll(ll_line - 1)
	End If
	mle_ocr_text.SetRedraw(True)
Else
	//Search begin by top postion
	If mle_ocr_text.selectedstart( ) + mle_ocr_text.SelectedLength ( ) > 0 Then
		ll_pos = Pos(ls_text, ls_find_text, 1 )
		If ll_pos > 0 Then
			mle_ocr_text.selecttext(ll_pos ,len(ls_find_text))
			//Added By Ken.Guo 2010-02-01. Workaround APB bug. selecttext() function do not scroll to the current line.
			ll_line = mle_ocr_text.selectedline()
			mle_ocr_text.SetRedraw(False)
			mle_ocr_text.scroll(-100000)
			If ll_line > il_page_lines Then
				mle_ocr_text.scroll(ll_line - 1)
			End If
			mle_ocr_text.SetRedraw(True)
			Return 
		End If
	End If
	Messagebox('Search','Search string not found.')
End If


end event

type sle_find from singlelineedit within w_view_ocr_result
event keydown pbm_syskeydown
integer x = 46
integer y = 1848
integer width = 553
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event keydown;If key = KeyEnter! Then
	cb_find.event clicked( )
End If
end event

type cb_close from commandbutton within w_view_ocr_result
integer x = 2213
integer y = 1848
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_update from commandbutton within w_view_ocr_result
integer x = 1861
integer y = 1848
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;String ls_ocr

If mle_ocr_text.text = is_ocr_org Then
	Messagebox('Update OCR','The text has not been modified.')
	Return
End If

ls_ocr = mle_ocr_text.text 
Update ctx_am_doc_image 
Set pdftext = :ls_ocr
Where doc_id = :il_doc_id and revision = :idec_revision;

If sqlca.sqlcode = 0 Then
	Commit;
	Messagebox('Update OCR','Succeed to update.')
	cb_update.enabled = False
	of_set_ocr_text(ls_ocr)	
Else
	Rollback;
	Messagebox('Update OCR','Failed to update the OCR result to database.' + sqlca.sqlerrtext )
End If
end event

type mle_ocr_text from multilineedit within w_view_ocr_result
event changed pbm_enchange
integer x = 23
integer y = 28
integer width = 2546
integer height = 1780
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

event changed;cb_update.enabled = True
end event

event modified;cb_update.enabled = True
end event

