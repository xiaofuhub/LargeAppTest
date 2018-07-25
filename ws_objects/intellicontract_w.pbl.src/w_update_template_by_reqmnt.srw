$PBExportHeader$w_update_template_by_reqmnt.srw
forward
global type w_update_template_by_reqmnt from w_response
end type
type cb_select from commandbutton within w_update_template_by_reqmnt
end type
type st_status from statictext within w_update_template_by_reqmnt
end type
type cb_2 from commandbutton within w_update_template_by_reqmnt
end type
type cb_1 from commandbutton within w_update_template_by_reqmnt
end type
type dw_1 from u_dw_contract within w_update_template_by_reqmnt
end type
end forward

global type w_update_template_by_reqmnt from w_response
integer width = 2848
integer height = 1328
string title = "Update Clause and Template"
long backcolor = 33551856
cb_select cb_select
st_status st_status
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_update_template_by_reqmnt w_update_template_by_reqmnt

type variables
n_cst_dm_utils inv_dm_utils
n_cst_word_utility inv_word
str_used_tempate istr_template
end variables

forward prototypes
public function decimal of_get_new_version (long al_row, long al_doc_id)
end prototypes

public function decimal of_get_new_version (long al_row, long al_doc_id);Boolean lb_revision_control
Integer li_version_increment
decimal ldec_max_revision,ldec_new_revision

lb_revision_control = (dw_1.GetItemString(al_row, "ctx_am_document_revision_control") = "1")
li_version_increment = of_get_app_setting("set_57",'I')	//Version Number Increment Option


Select Max(Revision) Into :ldec_max_revision From Ctx_am_doc_image	Where Doc_id = :al_doc_id ;   //Added By Ken.Guo 2009-05-15. Get newest revision.
		
IF (lb_revision_control and li_version_increment = 1) THEN 
	ldec_new_revision = inv_dm_utils.of_newversion( ldec_max_revision )   
ELSE
	ldec_new_revision = ldec_max_revision 
END IF

Return ldec_new_revision
end function

on w_update_template_by_reqmnt.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.st_status=create st_status
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.st_status
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_update_template_by_reqmnt.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.st_status)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;
istr_template = Message.powerobjectparm

dw_1.SetTransObject(SQLCA)

istr_template.sds_template_list.sharedata(dw_1)

inv_word = Create n_cst_word_utility 
end event

event close;call super::close;If isvalid(inv_word) Then Destroy inv_word
end event

type cb_select from commandbutton within w_update_template_by_reqmnt
integer x = 50
integer y = 1120
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select ALL"
end type

event clicked;Long ll_cnt,i
Integer li_value0[],li_value1[]

ll_cnt = dw_1.RowCount()
If ll_cnt = 0 Then Return 

For i = 1 To ll_cnt
	li_value0[i] = 0
	li_value1[i] = 1
Next

If This.Text = '&Select ALL' Then
	dw_1.object.selected[1,ll_cnt] = li_value1[]
	This.Text = 'De&select ALL'
Else
	dw_1.object.selected[1,ll_cnt] = li_value0[]
	This.Text = '&Select ALL'
End If


end event

type st_status from statictext within w_update_template_by_reqmnt
integer x = 37
integer y = 28
integer width = 2373
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Note: During update, the Clause Painter and the Template Painter will be closed if they are opened."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_update_template_by_reqmnt
integer x = 2427
integer y = 1120
integer width = 343
integer height = 92
integer taborder = 40
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

type cb_1 from commandbutton within w_update_template_by_reqmnt
integer x = 2071
integer y = 1120
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;
String ls_template_file,ls_error,ls_doc_type
Long ll_tempate_id,i
Integer li_ret
Datetime ldt_modify
Boolean lb_exists

SetPointer(HourGlass!)
For i = 1 to dw_1.rowcount()
	If dw_1.getitemnumber(i,'selected') = 0 Then Continue
	
	ll_tempate_id = dw_1.getitemnumber(i,'template_id' )
	ldt_modify = dw_1.getitemdatetime(i,'modify_date' )
	ls_doc_type = dw_1.getitemstring(i,'reqmnt_type')
	dw_1.SetItem(i,'update_result','Update...')
	
	If Not isvalid(w_ole_word) Then Open(w_ole_word)
	
	//Close Clause/Template Painter, and Get Clause/Template file.
	Choose Case ls_doc_type 
		Case 'T'  //Tempalte 
			If Isvalid(w_agreement_template_painter) Then Close(w_agreement_template_painter)
			ls_template_file = gs_dir_path + gs_DefDirName + "\Agreement\template_" + string(ll_tempate_id) + ".doc"
			If inv_word.of_get_template_file(ll_tempate_id, ldt_modify) = -1 THEN
				dw_1.SetItem(i,'update_result','Failure. Failed to download the template file.')
				Continue
			End If
		Case 'C' //Clause
			If Isvalid(w_clause_painter) Then Close(w_clause_painter)
			ls_template_file = gs_dir_path + gs_DefDirName + "\Agreement\" + "clause_" + string(ll_tempate_id) + ".doc"
			If inv_word.of_get_clause_file(ll_tempate_id, ldt_modify) = '' THEN
				dw_1.SetItem(i,'update_result','Failure. Failed to download the clause file.')
				Continue
			End If			
	End Choose
	
	w_ole_word.ole_1.object.openlocalfile(ls_template_file,False)
	//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
	gnv_word_utility.of_modify_word_property( w_ole_word.ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.	
	//---------End Added ------------------------------------------------------
	If inv_word.of_refresh_reqmnt_fields_name( w_ole_word.ole_1.object,istr_template.ss_element_name[], istr_template.sl_element_id[],ls_error ) > 0 Then
		w_ole_word.ole_1.object.savetolocal(ls_template_file,True)
		w_ole_word.ole_1.object.Close()
		Choose Case ls_doc_type 
			Case 'T'  //Tempalte
				li_ret = inv_word.of_put_template_file(ll_tempate_id, DateTime(Today(), Now()))
			Case 'C'	 //Clause 
				li_ret = inv_word.of_put_clause_file(ll_tempate_id, DateTime(Today(), Now()))
		End Choose
		
		IF li_ret = -1 THEN
			dw_1.SetItem(i,'update_result','Failure. Failed to upload the file to DB.')
		Else
			dw_1.SetItem(i,'update_result','Success.')
		END IF	
		
	Else
		w_ole_word.ole_1.object.Close()
		dw_1.SetItem(i,'update_result',ls_error)
	End If

	lb_exists = True
Next

IF lb_exists Then
	Messagebox('Update','Update Complete!')
End If
SetPointer(Arrow!)

Return 1
end event

type dw_1 from u_dw_contract within w_update_template_by_reqmnt
integer x = 23
integer y = 112
integer width = 2784
integer height = 972
integer taborder = 10
string title = "none"
string dataobject = "d_req_template_used"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;of_setrowselect( true)
this.inv_rowselect.of_setstyle( inv_rowselect.single)

this.of_setupdateable( false)
this.ib_rmbmenu=false

this.Event ue_populatedddws()
end event

