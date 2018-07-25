$PBExportHeader$w_agreement_template_insert_requirement.srw
forward
global type w_agreement_template_insert_requirement from w_popup
end type
type ole_1 from u_email_edit within w_agreement_template_insert_requirement
end type
type cbx_parent from checkbox within w_agreement_template_insert_requirement
end type
type cb_goto from commandbutton within w_agreement_template_insert_requirement
end type
type cbx_preview from checkbox within w_agreement_template_insert_requirement
end type
type cb_collapse_all from commandbutton within w_agreement_template_insert_requirement
end type
type cb_expand_all from commandbutton within w_agreement_template_insert_requirement
end type
type cb_remove from commandbutton within w_agreement_template_insert_requirement
end type
type tv_requirement from treeview within w_agreement_template_insert_requirement
end type
type cb_close from commandbutton within w_agreement_template_insert_requirement
end type
type cb_insert from commandbutton within w_agreement_template_insert_requirement
end type
type gb_1 from groupbox within w_agreement_template_insert_requirement
end type
type gb_2 from groupbox within w_agreement_template_insert_requirement
end type
end forward

global type w_agreement_template_insert_requirement from w_popup
integer width = 4014
integer height = 2052
string title = "Insert Requirement"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
ole_1 ole_1
cbx_parent cbx_parent
cb_goto cb_goto
cbx_preview cbx_preview
cb_collapse_all cb_collapse_all
cb_expand_all cb_expand_all
cb_remove cb_remove
tv_requirement tv_requirement
cb_close cb_close
cb_insert cb_insert
gb_1 gb_1
gb_2 gb_2
end type
global w_agreement_template_insert_requirement w_agreement_template_insert_requirement

type variables
Long il_ctx_id
DataStore ids_profile,ids_profile_category,ids_profile_category_element
DataStore ids_reqmnt_ctx,ids_reqmnt_ctx_parent
n_cst_word_utility inv_word
str_ole_ctxid istr_ole_ctxid
Long il_profile_hand[]
end variables

forward prototypes
public subroutine of_retrieve_profile ()
public subroutine of_gen_treeview ()
public function integer of_preview_reqmnt_doc (long al_reqmnt_id)
public function integer of_get_attachemnt_result (long al_element_id)
public function long of_get_reqmnt_id (long al_element_id, boolean ab_parent_data)
end prototypes

public subroutine of_retrieve_profile ();Long ll_parent_ctx_id

//Get Parent CTX ID
If istr_ole_ctxid.sl_ctx_id > 0 Then
	Select master_contract_id into :ll_parent_ctx_id from ctx_basic_info where ctx_id = :istr_ole_ctxid.sl_ctx_id;
	If ll_parent_ctx_id = 0 or isnull(ll_parent_ctx_id) Then 
		ll_parent_ctx_id = istr_ole_ctxid.sl_ctx_id
	End If
End If

gnv_appeondb.of_startqueue( )
	ids_profile.Retrieve()
	ids_profile_category.Retrieve()
	ids_profile_category_element.Retrieve()
	If istr_ole_ctxid.sl_ctx_id > 0 Then
		ids_reqmnt_ctx.Retrieve(istr_ole_ctxid.sl_ctx_id)
		ids_reqmnt_ctx_parent.Retrieve(ll_parent_ctx_id)
		cbx_parent.text = "Get Data From Master CTX - " + String(ll_parent_ctx_id)
	End If
gnv_appeondb.of_commitqueue( )


end subroutine

public subroutine of_gen_treeview ();long ll_root, ll_profile_hand,ll_category_hand,ll_element_hand
String ls_bookmark_name,ls_bookmark_name_parent
int index,li_state_index
Treeviewitem litv_root,litv_profile,litv_catetory,litv_element
Integer i,j,k
Boolean lb_parent_data

//Root
tv_requirement.PictureHeight = 32
litv_root.label = 'Requirements'
litv_root.data = -1
litv_root.children = true
litv_root.pictureindex =1
litv_root.selectedpictureindex = 2
ll_root = tv_requirement.insertitemlast(0,litv_root)

if ll_root = -1 then 
	Return
end if

tv_requirement.setredraw(false)

//build requirement treeview

For i = 1 to ids_profile.RowCount() 
	//Level 1: Profile
	litv_profile.label = ids_profile.GetItemString(i,'rqmnt_name')
	litv_profile.data = ids_profile.GetItemNumber(i,'ctx_req_profile_id')
	litv_profile.children = true
	litv_profile.pictureindex =1
	litv_profile.selectedpictureindex = 2
	ll_profile_hand = tv_requirement.insertitemlast(ll_root,litv_profile)
	If ll_Profile_hand > 0 Then
		il_profile_hand[UpperBound(il_profile_hand[]) + 1] = ll_profile_hand
		ids_profile_category.SetFilter("ctx_req_profile_id = " + String(litv_profile.data) )
		ids_profile_category.Filter()
		ids_profile_category.Sort()
		//Level 2: Category
		For j = 1 To ids_profile_category.RowCount()
			litv_catetory.label = ids_profile_category.GetItemString(j,'category_name')
			litv_catetory.data = ids_profile_category.GetItemNumber(j,'ctx_rqmnt_category_id')
			litv_catetory.children = True
			litv_catetory.pictureindex = 1
			litv_catetory.selectedpictureindex = 2
			ll_category_hand = tv_requirement.insertitemlast(ll_profile_hand,litv_catetory)			

			If ll_category_hand > 0 Then
				ids_profile_category_element.SetFilter("ctx_rqmnt_category_id = " + String(litv_catetory.data) )
				ids_profile_category_element.Filter()
				ids_profile_category_element.Sort()
				//Level 3: Elements
				For k = 1 To ids_profile_category_element.RowCount()
					litv_element.label = ids_profile_category_element.GetItemString(k,'element_name')
					litv_element.data = ids_profile_category_element.GetItemNumber(k,'ctx_req_tmplt_element_id')
					litv_element.children = False
					litv_element.statepictureindex = 0
					ls_bookmark_name = 'reqmnt_' + String(litv_element.data)
					ls_bookmark_name_parent = 'reqmnt_parent_' + String(litv_element.data)
					
					if istr_ole_ctxid.sl_opentype = 1 then	//Add by jervis 08.26.2009
						lb_parent_data = False
						litv_element.pictureindex = 3
						litv_element.selectedpictureindex = 4	
					else
						If istr_ole_ctxid.sole_word.object.ActiveDocument.Bookmarks.Exists(ls_bookmark_name) Then
							litv_element.pictureindex = 5
							litv_element.selectedpictureindex = 5
							lb_parent_data = False
						ElseIf istr_ole_ctxid.sole_word.object.ActiveDocument.Bookmarks.Exists(ls_bookmark_name_parent) Then
							litv_element.pictureindex = 6
							litv_element.selectedpictureindex = 6					
							lb_parent_data = True
						Else
							lb_parent_data = False
							litv_element.pictureindex = 3
							litv_element.selectedpictureindex = 4	
						End If
					end if
					
					If istr_ole_ctxid.sl_ctx_id > 0 Then
						li_state_index = of_get_attachemnt_result(litv_element.data)
						litv_element.statepictureindex = li_state_index
					End If
					
					//litv_element.statepictureindex = 1
					ll_element_hand = tv_requirement.insertitemlast(ll_category_hand,litv_element)			
				Next
				//Set Children to false if not 
				If ids_profile_category_element.RowCount() = 0 Then
					tv_requirement.GetItem(ll_category_hand,litv_catetory)
					litv_catetory.children = False
					tv_requirement.SetItem(ll_category_hand,litv_catetory)
				End If
			End If
		Next
		//Set Children to false if not
		If ids_profile_category.RowCount() = 0 Then
			tv_requirement.GetItem(ll_profile_hand,litv_profile)
			litv_profile.children = False		
			tv_requirement.SetItem(ll_profile_hand,litv_profile)
		End If
	End If
Next		

//Expand profile tv
tv_requirement.expanditem(ll_root)
For i = 1 To UpperBound(il_profile_hand[])
	tv_requirement.expanditem(il_profile_hand[i])
Next

tv_requirement.setredraw(true)

Return

end subroutine

public function integer of_preview_reqmnt_doc (long al_reqmnt_id);
String ls_reqmnt_file

ole_1.object.Close()
If al_reqmnt_id < 0 Then
	ole_1.object.createNew("Word.Document")
End If

ls_reqmnt_file = inv_word.of_get_requirement_file(al_reqmnt_id)
If Not FileExists(ls_reqmnt_file) Then 
	Messagebox('Error','Failed to get requirement file, please call support.')
	ole_1.object.close()
	Return -1
End If
ole_1.object.OpenLocalFile(ls_reqmnt_file,True)
//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
gnv_word_utility.of_modify_word_property( ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
//---------End Added ------------------------------------------------------
Return 1
end function

public function integer of_get_attachemnt_result (long al_element_id);Long ll_find,ll_find_parent
Long ll_len,ll_len_parent
ll_find = ids_reqmnt_ctx.Find("ctx_req_tmplt_element_element_id = " + String(al_element_id),1,ids_reqmnt_ctx.RowCount())
ll_find_parent = ids_reqmnt_ctx_parent.Find("ctx_req_tmplt_element_element_id = " + String(al_element_id),1,ids_reqmnt_ctx_parent.RowCount())

If ll_find <= 0 and ll_find_parent <= 0 Then Return 0

If ll_find > 0 Then
	ll_len = ids_reqmnt_ctx.GetItemNumber(ll_find,'image_length')	
End If
If ll_find_parent > 0 Then
	ll_len_parent = ids_reqmnt_ctx_parent.GetItemNumber(ll_find_parent,'image_length')	
End If

If ll_len > 0 Then
	If ll_len_parent > 0 Then
		Return 3
	Else
		Return 1
	End If
ElseIf ll_len_parent > 0 Then
	Return 2
Else
	Return 0
End If

end function

public function long of_get_reqmnt_id (long al_element_id, boolean ab_parent_data);Long ll_find

If ab_parent_data Then
	ll_find = ids_reqmnt_ctx_parent.Find("ctx_req_tmplt_element_element_id = " + String(al_element_id) + &
				" And image_length > 0",1,ids_reqmnt_ctx_parent.RowCount())
	If ll_find <= 0 Then Return -100
	Return ids_reqmnt_ctx_parent.GetItemNumber(ll_find,'ctx_elements_reqmnt_id')
Else
	ll_find = ids_reqmnt_ctx.Find("ctx_req_tmplt_element_element_id = " + String(al_element_id) + &
				" And image_length > 0",1,ids_reqmnt_ctx.RowCount())
	If ll_find <= 0 Then Return -100
	Return ids_reqmnt_ctx.GetItemNumber(ll_find,'ctx_elements_reqmnt_id')	
End If

Return -100


end function

on w_agreement_template_insert_requirement.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.cbx_parent=create cbx_parent
this.cb_goto=create cb_goto
this.cbx_preview=create cbx_preview
this.cb_collapse_all=create cb_collapse_all
this.cb_expand_all=create cb_expand_all
this.cb_remove=create cb_remove
this.tv_requirement=create tv_requirement
this.cb_close=create cb_close
this.cb_insert=create cb_insert
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.cbx_parent
this.Control[iCurrent+3]=this.cb_goto
this.Control[iCurrent+4]=this.cbx_preview
this.Control[iCurrent+5]=this.cb_collapse_all
this.Control[iCurrent+6]=this.cb_expand_all
this.Control[iCurrent+7]=this.cb_remove
this.Control[iCurrent+8]=this.tv_requirement
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.cb_insert
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
end on

on w_agreement_template_insert_requirement.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.cbx_parent)
destroy(this.cb_goto)
destroy(this.cbx_preview)
destroy(this.cb_collapse_all)
destroy(this.cb_expand_all)
destroy(this.cb_remove)
destroy(this.tv_requirement)
destroy(this.cb_close)
destroy(this.cb_insert)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event pfc_preopen;call super::pfc_preopen;
istr_ole_ctxid = Message.powerobjectparm
inv_word = Create n_cst_word_utility

If istr_ole_ctxid.sl_ctx_id <= 0 Then
	This.width = 1888
	gb_2.width = 1829
	tv_requirement.width = 1769	
	cb_goto.x = 430
	cb_remove.x = 791
	cb_insert.x = 1152
	cb_close.x = 1513
	gb_1.visible = False
	ole_1.visible = False
	cbx_preview.visible = False
	This.maxbox = False
	This.resizable = False
	This.center = True
End If


cb_goto.enabled = False
cb_remove.enabled = False
cb_insert.enabled = False
cbx_parent.enabled = False

//Add by Jervis 08.26.2009
//1-Open by Export Painter
if istr_ole_ctxid.sl_OpenType = 1 then
	cb_goto.visible = False
	cb_remove.visible = False
	cb_insert.text = "&Select"
	cbx_parent.visible = False
	this.title = "Select Requirement"
end if

end event

event open;call super::open;ids_profile = Create datastore
ids_profile_category = Create datastore
ids_profile_category_element = Create datastore
ids_reqmnt_ctx = Create datastore
ids_reqmnt_ctx_parent = Create datastore

ids_profile.DataObject = 'd_requirement_profiles'
ids_profile_category.DataObject = 'd_requirement_profile_category'
ids_profile_category_element.DataObject = 'd_requirement_profile_category_element'
ids_reqmnt_ctx.DataObject = 'd_requirement_ctx'
ids_reqmnt_ctx_parent.DataObject = 'd_requirement_ctx'

ids_profile.SetTransObject(SQLCA)
ids_profile_category.SetTransObject(SQLCA)
ids_profile_category_element.SetTransObject(SQLCA)
ids_reqmnt_ctx.SetTransObject(SQLCA)
ids_reqmnt_ctx_parent.SetTransObject(SQLCA)

of_retrieve_profile()

of_gen_treeview()



end event

event activate;call super::activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_1 ) Then
	ole_1.object.activate(true)
End If
end event

type ole_1 from u_email_edit within w_agreement_template_insert_requirement
integer x = 1294
integer y = 68
integer width = 2661
integer height = 1620
integer taborder = 20
string binarykey = "w_agreement_template_insert_requirement.win"
end type

type cbx_parent from checkbox within w_agreement_template_insert_requirement
integer x = 55
integer y = 1716
integer width = 1097
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Get Data From Master CTX"
end type

event clicked;Long ll_tvi_hand

ll_tvi_hand = tv_requirement.FindItem ( CurrentTreeItem!, 0 )
If ll_tvi_hand <= 0 Then Return -1

tv_requirement.event selectionchanged(ll_tvi_hand, ll_tvi_hand)

end event

type cb_goto from commandbutton within w_agreement_template_insert_requirement
integer x = 2514
integer y = 1844
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Go To"
end type

event clicked;TreeviewItem ltvi_current
Long ll_tvi_hand,ll_data,ll_reqmnt_id
String ls_name
Boolean lb_parent_data
ll_tvi_hand = tv_requirement.FindItem ( CurrentTreeItem!, 0 )
If ll_tvi_hand <= 0 Then Return -1

tv_requirement.GetItem(ll_tvi_hand,ltvi_current)
If ltvi_current.level <> 4 Then Return -1

ll_data = ltvi_current.data
If ltvi_current.pictureindex = 6 Then lb_parent_data = True

istr_ole_ctxid.sole_word.SetRedraw(False)
If inv_word.of_goto_requirement_field( istr_ole_ctxid.sole_word.object, ll_data,lb_parent_data)	 > 0 Then
	istr_ole_ctxid.sole_word.SetRedraw(True)
	istr_ole_ctxid.sole_word.SetFocus()
	cb_close.event clicked( )
Else
	istr_ole_ctxid.sole_word.SetRedraw(True)
End If

end event

type cbx_preview from checkbox within w_agreement_template_insert_requirement
integer x = 1294
integer y = 1716
integer width = 654
integer height = 64
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Requirement Preview"
boolean checked = true
end type

event clicked;TreeviewItem ltvi_current
Long ll_tvi_hand,ll_data,ll_reqmnt_id
String ls_name

If This.Checked Then
	ll_tvi_hand = tv_requirement.FindItem ( CurrentTreeItem!, 0 )
	If ll_tvi_hand <= 0 Then Return -1
	tv_requirement.GetItem(ll_tvi_hand,ltvi_current)
	If ltvi_current.level <> 4 Then Return -1
	tv_requirement.event selectionchanged(ll_tvi_hand, ll_tvi_hand)
Else
	ole_1.object.close()
End If
end event

type cb_collapse_all from commandbutton within w_agreement_template_insert_requirement
integer x = 215
integer y = 1844
integer width = 160
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "- ALL"
end type

event clicked;long ll_tvi

ll_tvi = tv_requirement.finditem(roottreeitem!, 0)
do while ll_tvi > 0 
	tv_requirement.collapseitem(ll_tvi)
	ll_tvi = tv_requirement.finditem(NextTreeItem!, ll_tvi)
loop
end event

type cb_expand_all from commandbutton within w_agreement_template_insert_requirement
integer x = 27
integer y = 1844
integer width = 174
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+ ALL"
end type

event clicked;long ll_tvi

ll_tvi = tv_requirement.finditem(roottreeitem!, 0)
do while ll_tvi > 0 
	tv_requirement.expandall(ll_tvi)
	ll_tvi = tv_requirement.finditem(NextTreeItem!, ll_tvi)
loop
end event

type cb_remove from commandbutton within w_agreement_template_insert_requirement
integer x = 2875
integer y = 1844
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Remove"
end type

event clicked;TreeviewItem ltvi_current
Long ll_tvi_hand,ll_data,ll_reqmnt_id
String ls_name
Boolean lb_parent_data
ll_tvi_hand = tv_requirement.FindItem ( CurrentTreeItem!, 0 )
If ll_tvi_hand <= 0 Then Return -1

tv_requirement.GetItem(ll_tvi_hand,ltvi_current)
If ltvi_current.level <> 4 Then Return -1
ls_name = ltvi_current.label
ll_data = ltvi_current.data
If ltvi_current.pictureindex = 6 Then lb_parent_data = True
SetPointer(HourGlass!)
ole_1.Setredraw(False)
istr_ole_ctxid.sole_word.SetRedraw(False)
If Messagebox('Delete','Do you want to delete the requirement field "'+ls_name+'" in this document?',Question!,YesNo!) = 2 Then Return 0
If inv_word.of_remove_reqmnt_field( istr_ole_ctxid.sole_word.object, ll_data,lb_parent_data)	> 0 Then
	ltvi_current.pictureindex = 3
	ltvi_current.selectedpictureindex = 4
	tv_requirement.SetItem(ll_tvi_hand,ltvi_current)
	cb_insert.enabled = True
	cbx_parent.enabled = True
	cb_remove.enabled = False
	cb_goto.enabled = False
End If
ole_1.Setredraw(True)
istr_ole_ctxid.sole_word.SetRedraw(True)
SetPointer(Arrow!)
end event

type tv_requirement from treeview within w_agreement_template_insert_requirement
integer x = 55
integer y = 64
integer width = 1157
integer height = 1624
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean fullrowselect = true
string picturename[] = {"Custom039!","Custom050!","MultiLineEdit!","SingletonReturn!","sectiongreen.bmp","sectiongreen_p.bmp"}
long picturemaskcolor = 536870912
string statepicturename[] = {"attachment.jpg","attachment_p.jpg","attachment_all.jpg"}
long statepicturemaskcolor = 536870912
end type

event selectionchanged;Long ll_reqmnt_id
Boolean lb_parent_data
TreeviewItem ltvi_selected

//Set controls status.
SetPointer(HourGlass!)
If tv_requirement.GetItem(newhandle,ltvi_selected) <> 1 Then Return -1
If ltvi_selected.level = 4 Then
	If ltvi_selected.selectedpictureindex = 5 or ltvi_selected.selectedpictureindex = 6 Then
		cb_insert.enabled = False
		cbx_parent.enabled = False
		cb_remove.enabled = True
		cb_goto.enabled = True
		If ltvi_selected.selectedpictureindex = 5 Then
			cbx_parent.checked = False
		Else
			cbx_parent.checked = True
		End If
	Else
		cb_insert.enabled = True	
		cbx_parent.enabled = True
		cb_remove.enabled = False	
		cb_goto.enabled = False
	End If
	
	Parent.title = 'Insert Requirement - ' + String(ltvi_selected.data) + ' - ' + ltvi_selected.label

Else
	cb_insert.enabled = False
	cbx_parent.enabled = False
	cb_remove.enabled = False
	cb_goto.enabled = False
	Parent.title = 'Insert Requirement'
End If	

lb_parent_data = cbx_parent.checked

//Preview doc
If Not cbx_preview.Checked Then Return 1
If ltvi_selected.level = 4 and istr_ole_ctxid.sl_ctx_id > 0 Then
	ole_1.SetRedraw(False)
	If istr_ole_ctxid.sl_ctx_id > 0 Then
		ll_reqmnt_id = of_get_reqmnt_id(ltvi_selected.data,lb_parent_data)
		of_preview_reqmnt_doc(ll_reqmnt_id)
	Else
		//Show Empty doc
		try
			ole_1.object.close()
			ole_1.object.createNew("Word.Document")
		catch(oleruntimeerror err)
			ole_1.SetRedraw(True)
			Messagebox('Warning','Failed to create a new document in the OLE control due to: '+ err.text +'~r~n~r~nPlease check if your Office Viewer OCX has been installed correctly.',exclamation!)
			Return -1
		end try
	End If
	ole_1.SetRedraw(True)
End If
SetPointer(Arrow!)

end event

event doubleclicked;Treeviewitem ltvi_selected
If tv_requirement.GetItem(handle,ltvi_selected) <> 1 Then Return -1
If ltvi_selected.level = 4 And ltvi_selected.selectedpictureindex <> 5 and ltvi_selected.selectedpictureindex <> 6 Then
	cb_insert.Event clicked()
End If

If ltvi_selected.level < 4 Then
	If ltvi_selected.Expanded Then
		tv_requirement.collapseitem(handle)
	Else
		tv_requirement.expanditem(handle)
	End If
Else

End If
Return 1

end event

type cb_close from commandbutton within w_agreement_template_insert_requirement
integer x = 3598
integer y = 1844
integer width = 343
integer height = 92
integer taborder = 70
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

type cb_insert from commandbutton within w_agreement_template_insert_requirement
integer x = 3237
integer y = 1844
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Insert"
end type

event clicked;TreeviewItem ltvi_current
Long ll_tvi_hand,ll_data,ll_reqmnt_id
String ls_name
Boolean lb_parent_data
ll_tvi_hand = tv_requirement.FindItem ( CurrentTreeItem!, 0 )
If ll_tvi_hand <= 0 Then Return -1

tv_requirement.GetItem(ll_tvi_hand,ltvi_current)
If ltvi_current.level <> 4 Then Return -1
ls_name = ltvi_current.label
ll_data = ltvi_current.data
lb_parent_data = cbx_parent.checked

//Add by Jervis 08.26.2009
//1-Open by Export Painter
if istr_ole_ctxid.sl_OpenType = 1 then
	istr_ole_ctxid.sdw_object.dynamic event ue_set_reqFilter(ll_data)
	Close(parent)
else
	SetPointer(HourGlass!)
	ole_1.Setredraw(False)
	istr_ole_ctxid.sole_word.Setredraw(False)
	If istr_ole_ctxid.sl_ctx_id > 0 Then
		//Insert CTX word Content
	//	If ltvi_current.statepictureindex = 1 Then
	//		ll_reqmnt_id = Parent.of_get_reqmnt_id(ll_data)
	//		If ll_reqmnt_id <= 0 Then
	//			Messagebox('Error','Failed to get requirement ID, please call support.')
	//			ole_1.Setredraw(True)
	//			istr_ole_ctxid.sole_word.Setredraw(True)
	//			SetPointer(Arrow!)
	//			Return -1
	//		End If
	//	Else
	//		ll_reqmnt_id = -100 //Means No requirement attachment
	//	End If		
		ll_reqmnt_id = Parent.of_get_reqmnt_id(ll_data,lb_parent_data)
		If inv_word.of_add_requirement_field(istr_ole_ctxid.sole_word.object ,ll_reqmnt_id, ls_name, ll_data,lb_parent_data) > 0 Then
			If lb_parent_data Then
				ltvi_current.pictureindex = 6
				ltvi_current.selectedpictureindex = 6		
			Else
				ltvi_current.pictureindex = 5
				ltvi_current.selectedpictureindex = 5					
			End IF
			tv_requirement.SetItem(ll_tvi_hand,ltvi_current)
			cb_insert.enabled = False
			cbx_parent.enabled = False
			cb_remove.enabled = True
			cb_goto.enabled = True
		End If
	Else
		//Insert Field Name
		If inv_word.of_add_requirement_field(istr_ole_ctxid.sole_word.object , ls_name, ll_data,lb_parent_data) >= 0 Then
			If lb_parent_data Then
				ltvi_current.pictureindex = 6
				ltvi_current.selectedpictureindex = 6		
			Else
				ltvi_current.pictureindex = 5
				ltvi_current.selectedpictureindex = 5					
			End IF 
			tv_requirement.SetItem(ll_tvi_hand,ltvi_current)
			cb_insert.enabled = False
			cbx_parent.enabled = False
			cb_remove.enabled = True
			cb_goto.enabled = True
		End If
	End If
	ole_1.Setredraw(True)
	istr_ole_ctxid.sole_word.Setredraw(True)
	istr_ole_ctxid.sole_word.SetFocus()
	SetPointer(Arrow!)
end if
end event

type gb_1 from groupbox within w_agreement_template_insert_requirement
integer x = 1262
integer y = 8
integer width = 2715
integer height = 1804
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Preview"
end type

type gb_2 from groupbox within w_agreement_template_insert_requirement
integer x = 27
integer y = 8
integer width = 1216
integer height = 1804
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Requirements"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_agreement_template_insert_requirement.bin 
2600000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000003304fc8001d1312900000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000003304fc8001d131293304fc8001d131290000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00003c27000029dc00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00003c27000029dc00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_agreement_template_insert_requirement.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
