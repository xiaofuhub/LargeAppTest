$PBExportHeader$w_contract_templates_management.srw
forward
global type w_contract_templates_management from w_response
end type
type cb_delete from commandbutton within w_contract_templates_management
end type
type cb_2 from commandbutton within w_contract_templates_management
end type
type tab_1 from tab within w_contract_templates_management
end type
type tabpage_1 from userobject within tab_1
end type
type dw_browse from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_browse dw_browse
end type
type tabpage_2 from userobject within tab_1
end type
type dw_detail from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_detail dw_detail
end type
type tab_1 from tab within w_contract_templates_management
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_1 from commandbutton within w_contract_templates_management
end type
type cb_cancel from commandbutton within w_contract_templates_management
end type
type cb_ok from commandbutton within w_contract_templates_management
end type
type st_1 from statictext within w_contract_templates_management
end type
end forward

global type w_contract_templates_management from w_response
integer width = 2478
integer height = 1504
string title = "Contract Templates Management"
long backcolor = 33551856
cb_delete cb_delete
cb_2 cb_2
tab_1 tab_1
cb_1 cb_1
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
end type
global w_contract_templates_management w_contract_templates_management

type variables
long il_ctx_id

end variables

forward prototypes
public function long of_save_to_template ()
end prototypes

public function long of_save_to_template ();Long ll_ctx_id
n_cst_copy_ctx lnv_copy_ctx
str_copy_ctx lstr_copy_ctx


lnv_copy_ctx = Create n_cst_copy_ctx

lstr_copy_ctx.si_is_template = 1
lstr_copy_ctx.ss_template_name = tab_1.tabpage_1.dw_browse.getitemstring(1,'template_name')
lstr_copy_ctx.sl_ctx_id = il_ctx_id
lstr_copy_ctx.sb_contract_detail = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_contract_detail') 
lstr_copy_ctx.sb_contract_dates = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_contract_dates')
lstr_copy_ctx.sb_custom_data = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_custom_data')
lstr_copy_ctx.sb_notes = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_notes') 
lstr_copy_ctx.sb_contracted_contacts = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_contract_contacts')
lstr_copy_ctx.sb_group_access = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_group_access')
lstr_copy_ctx.sb_products = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_products')
lstr_copy_ctx.sb_our_contacts = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_our_contacts')
lstr_copy_ctx.sb_requirements = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_requirements')
lstr_copy_ctx.sb_other_contacts = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_other_contacts')
lstr_copy_ctx.sb_locations = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_locations')
lstr_copy_ctx.sb_organizations = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_organizations')
lstr_copy_ctx.sb_fee_schedule = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_fee_schedule')
lstr_copy_ctx.sb_document_manager = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_document_manager')
lstr_copy_ctx.sb_action_items = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_action_items')
lstr_copy_ctx.ss_template_comment = tab_1.tabpage_1.dw_browse.getitemstring(1,'notes')

//Added By Mark Lee 05/11/12
lstr_copy_ctx.ai_ib_default_email = tab_1.tabpage_1.dw_browse.GetItemNumber(1,'ib_default_email')
lstr_copy_ctx.ai_ib_owner = tab_1.tabpage_1.dw_browse.GetItemNumber(1,'ib_owner')
lstr_copy_ctx.sb_custom_multi = tab_1.tabpage_1.dw_browse.GetItemNumber(1,'ib_custom_multi')
lstr_copy_ctx.sb_custom_data2 = tab_1.tabpage_1.dw_browse.getitemnumber(1,'ib_custom_data2')

ll_ctx_id = lnv_copy_ctx.of_copy_ctx_data( lstr_copy_ctx)


/*
lds_ctx_template.SetItem(1,'template_name',lstr_copy_ctx.ss_template_name)
lds_ctx_template.SetItem(1,'create_date',today())
lds_ctx_template.SetItem(1,'create_by',gs_user_id)
lds_ctx_template.SetItem(1,'ctx_id',al_template_id)
lds_ctx_template.SetItem(1,'original_ctx_id',lstr_copy_ctx.sl_ctx_id)
lds_ctx_template.SetItem(1,'ib_contract_detail',lstr_copy_ctx.sb_contract_detail)
lds_ctx_template.SetItem(1,'ib_contract_dates',lstr_copy_ctx.sb_contract_dates)
lds_ctx_template.SetItem(1,'ib_custom_data',lstr_copy_ctx.sb_custom_data)
lds_ctx_template.SetItem(1,'ib_notes',lstr_copy_ctx.sb_notes)
lds_ctx_template.SetItem(1,'ib_contract_contacts',lstr_copy_ctx.sb_contracted_contacts)
lds_ctx_template.SetItem(1,'ib_group_access',lstr_copy_ctx.sb_group_access)
lds_ctx_template.SetItem(1,'ib_products',lstr_copy_ctx.sb_products)
lds_ctx_template.SetItem(1,'ib_our_contacts',lstr_copy_ctx.sb_our_contacts)
lds_ctx_template.SetItem(1,'ib_requirements',lstr_copy_ctx.sb_requirements)
lds_ctx_template.SetItem(1,'ib_other_contacts',lstr_copy_ctx.sb_other_contacts)
lds_ctx_template.SetItem(1,'ib_locations',lstr_copy_ctx.sb_locations)
lds_ctx_template.SetItem(1,'ib_organizations',lstr_copy_ctx.sb_organizations)
lds_ctx_template.SetItem(1,'ib_fee_schedule',lstr_copy_ctx.sb_fee_schedule)
lds_ctx_template.SetItem(1,'ib_document_manager',lstr_copy_ctx.sb_document_manager)
lds_ctx_template.SetItem(1,'ib_action_items',lstr_copy_ctx.sb_action_items)
lds_ctx_template.SetItem(1,'notes',lstr_copy_ctx.ss_template_comment)

 
If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
*/

Return 1
end function

on w_contract_templates_management.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.cb_2=create cb_2
this.tab_1=create tab_1
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.st_1
end on

on w_contract_templates_management.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.cb_2)
destroy(this.tab_1)
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>w_use_template_create_ctx::open()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-24 by Ken.Guo
//////////////////////////////////////////////////////////////////////

tab_1.tabpage_1.dw_browse.SetTransObject(SQLCA)
tab_1.tabpage_2.dw_detail.SetTransObject(SQLCA)

tab_1.tabpage_1.dw_browse.Retrieve()
If tab_1.tabpage_1.dw_browse.rowcount() <= 0 Then
	tab_1.tabpage_2.enabled = False
	cb_ok.enabled = False
End IF

end event

type cb_delete from commandbutton within w_contract_templates_management
integer x = 384
integer y = 1300
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;String ls_template_name
Long ll_ctx_id,ll_template_id
n_cst_contract lnv_contract 
Long ll_row

ll_row = tab_1.tabpage_1.dw_browse.GetRow()
If ll_row = 0 Then Return
lnv_contract = Create n_cst_contract
ls_template_name = tab_1.tabpage_1.dw_browse.GetItemString(ll_row,'template_name')
If Messagebox('Delete','Do you want to delete the contract template "'+ls_template_name+'"?',Question!, YesNo!) = 1 Then
	SetPointer(HourGlass!)
	ll_ctx_id = tab_1.tabpage_1.dw_browse.GetItemNumber(ll_row,'ctx_id')
	lnv_contract.of_delete_ctx_detail(ll_ctx_id)
	Delete From ctx_basic_info where ctx_id = :ll_ctx_id;
	tab_1.tabpage_1.dw_browse.DeleteRow(ll_row)
	tab_1.tabpage_2.dw_detail.Reset()
End If

If tab_1.tabpage_1.dw_browse.GetRow() > 0 Then
	tab_1.tabpage_1.dw_browse.ScrolltoRow(tab_1.tabpage_1.dw_browse.GetRow())
	tab_1.tabpage_1.dw_browse.SelectRow(0,False)
	tab_1.tabpage_1.dw_browse.SelectRow(tab_1.tabpage_1.dw_browse.GetRow(),True)
	If tab_1.tabpage_1.dw_browse.GetRow() > 0 and tab_1.selectedtab = 2 Then
		tab_1.event selectionchanged( 1, 2)
	End IF
End If

//Begin - Added By Mark Lee 11/21/2012				refresh the menu of the contract module
If isvalid(w_contract) Then 
	w_contract.tab_contract_details.tabpage_search.of_create_menu_item()
End If
//End - Added By Mark Lee 11/21/2012

SetPointer(Arrow!)
If isvalid(lnv_contract) Then Destroy lnv_contract


end event

type cb_2 from commandbutton within w_contract_templates_management
integer x = 37
integer y = 1300
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Properties"
end type

event clicked;Long ll_template_id,ll_row
str_copy_ctx lstr_copy_ctx

ll_row = tab_1.tabpage_1.dw_browse.getrow()
If ll_row <= 0 Then Return 
ll_template_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_row,'id') 

OpenwithParm(w_ctx_template_properties,ll_template_id)

/*
If isvalid(Message.powerobjectparm ) Then
	lstr_copy_ctx = Message.powerobjectparm
	tab_1.tabpage_1.dw_browse.SetItem(ll_row,'located_tab_index',lstr_copy_ctx.si_located_tab )
	tab_1.tabpage_1.dw_browse.SetItem(ll_row,'clear_company',lstr_copy_ctx.si_clear_company )
	tab_1.tabpage_1.dw_browse.SetItem(ll_row,'add_contact',lstr_copy_ctx.si_add_contact )
	tab_1.tabpage_1.dw_browse.SetItem(ll_row,'trigger_workflow', lstr_copy_ctx.sl_workflow )
End If
*/

end event

type tab_1 from tab within w_contract_templates_management
event create ( )
event destroy ( )
integer x = 18
integer y = 24
integer width = 2405
integer height = 1232
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;long ll_ctx_id

If newindex = 2 Then
	If tabpage_1.dw_browse.getrow() > 0 Then
		ll_ctx_id = tabpage_1.dw_browse.getitemnumber(tabpage_1.dw_browse.getrow(),'ctx_id')
		tabpage_2.dw_detail.retrieve(ll_ctx_id)
	End If
End IF
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2368
integer height = 1116
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_browse dw_browse
end type

on tabpage_1.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_1.destroy
destroy(this.dw_browse)
end on

type dw_browse from u_dw within tabpage_1
integer x = 14
integer width = 2368
integer height = 1108
integer taborder = 10
string dataobject = "d_use_templates_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event doubleclicked;If row > 0 Then
	Tab_1.selecttab(2)
End If
end event

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setrowselect(True)
This.inv_rowselect.of_setstyle(This.inv_rowselect.single )
This.of_setsort(True)
This.inv_sort.of_setcolumnheader(True)
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2368
integer height = 1116
long backcolor = 33551856
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_detail dw_detail
end type

on tabpage_2.create
this.dw_detail=create dw_detail
this.Control[]={this.dw_detail}
end on

on tabpage_2.destroy
destroy(this.dw_detail)
end on

type dw_detail from u_dw within tabpage_2
integer y = 4
integer width = 2368
integer height = 1108
integer taborder = 20
string dataobject = "d_use_templates"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(False)

end event

type cb_1 from commandbutton within w_contract_templates_management
boolean visible = false
integer x = 1486
integer y = 484
integer width = 352
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;////////////////////////////////////////////////////////////////////////
//// $<event>clickedcb_1()
//// $<arguments>(None)
//// $<returns> long
//// $<description>
//// $<description>
////////////////////////////////////////////////////////////////////////
//// $<add> 06.08.2007 by Jack
////////////////////////////////////////////////////////////////////////
//If this.text = 'Select All' Then
//	cbx_1.checked = True
//	cbx_2.checked = True
//	cbx_3.checked = True
//	cbx_4.checked = True
//	cbx_5.checked = True
//	cbx_6.checked = True
//	cbx_7.checked = True
//	this.text = 'Deselect All'
//Else
//	cbx_1.checked = False
//	cbx_2.checked = False
//	cbx_3.checked = False
//	cbx_4.checked = False
//	cbx_5.checked = False
//	cbx_6.checked = False
//	cbx_7.checked = False
//	this.text = 'Select All'
//End If	
//
end event

type cb_cancel from commandbutton within w_contract_templates_management
integer x = 2057
integer y = 1300
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(parent,0)

end event

type cb_ok from commandbutton within w_contract_templates_management
integer x = 1710
integer y = 1300
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&reate"
boolean default = true
end type

event clicked;str_copy_ctx lstr_copy_ctx
long ll_new_ctx_id,ll_row,ll_template_id
integer li_tab_index
n_cst_copy_ctx lnv_copy_ctx

ll_row = tab_1.tabpage_1.dw_browse.getrow()
If ll_row <= 0 Then Return 
lnv_copy_ctx = Create n_cst_copy_ctx

//Get template info
ll_template_id = tab_1.tabpage_1.dw_browse.getitemnumber(ll_row,'id') 

//Copy CTX from Template
ll_new_ctx_id = lnv_copy_ctx.of_copy_ctx_from_template(ll_template_id )
If ll_new_ctx_id < 0 Then
	Messagebox('Error','Failed to create contract from the template, please call support.')
	If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
	Return 1
End If

//Open new CTX
li_tab_index = tab_1.tabpage_1.dw_browse.getitemnumber(ll_row,'located_tab_index') 
If isnull(li_tab_index) Then li_tab_index = 2
lnv_copy_ctx.of_locate_ctx(ll_new_ctx_id,li_tab_index)

If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx

CloseWithReturn(Parent,1)
end event

type st_1 from statictext within w_contract_templates_management
boolean visible = false
integer x = 1088
integer y = 1544
integer width = 160
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

