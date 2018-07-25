$PBExportHeader$w_saveas_contract.srw
forward
global type w_saveas_contract from w_response
end type
type cb_2 from commandbutton within w_saveas_contract
end type
type cb_1 from commandbutton within w_saveas_contract
end type
type cb_cancel from commandbutton within w_saveas_contract
end type
type cb_ok from commandbutton within w_saveas_contract
end type
type st_1 from statictext within w_saveas_contract
end type
type dw_1 from u_dw within w_saveas_contract
end type
end forward

global type w_saveas_contract from w_response
integer width = 2482
integer height = 2468
string title = "Save as a Template"
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
dw_1 dw_1
end type
global w_saveas_contract w_saveas_contract

type variables
long il_ctx_id

end variables

forward prototypes
public function long of_save_to_template ()
end prototypes

public function long of_save_to_template ();Long ll_ctx_id,  ll_tmp
n_cst_copy_ctx lnv_copy_ctx
str_copy_ctx lstr_copy_ctx
String 		ls_tmp

lnv_copy_ctx = Create n_cst_copy_ctx

lstr_copy_ctx.si_is_template = 1
lstr_copy_ctx.ss_template_name = dw_1.getitemstring(1,'template_name')
lstr_copy_ctx.sl_ctx_id = il_ctx_id
lstr_copy_ctx.sb_contract_detail = dw_1.getitemnumber(1,'ib_contract_detail') 
lstr_copy_ctx.sb_contract_dates = dw_1.getitemnumber(1,'ib_contract_dates')
lstr_copy_ctx.sb_custom_data = dw_1.getitemnumber(1,'ib_custom_data')
//Added By Mark Lee 05/11/12
lstr_copy_ctx.sb_custom_data2 = dw_1.getitemnumber(1,'ib_custom_data2')

lstr_copy_ctx.sb_notes = dw_1.getitemnumber(1,'ib_notes') 
lstr_copy_ctx.sb_contracted_contacts = dw_1.getitemnumber(1,'ib_contract_contacts')
lstr_copy_ctx.sb_group_access = dw_1.getitemnumber(1,'ib_group_access')
lstr_copy_ctx.sb_products = dw_1.getitemnumber(1,'ib_products')
lstr_copy_ctx.sb_our_contacts = dw_1.getitemnumber(1,'ib_our_contacts')
lstr_copy_ctx.sb_requirements = dw_1.getitemnumber(1,'ib_requirements')
lstr_copy_ctx.sb_other_contacts = dw_1.getitemnumber(1,'ib_other_contacts')
lstr_copy_ctx.sb_locations = dw_1.getitemnumber(1,'ib_locations')
lstr_copy_ctx.sb_organizations = dw_1.getitemnumber(1,'ib_organizations')
lstr_copy_ctx.sb_fee_schedule = dw_1.getitemnumber(1,'ib_fee_schedule')
lstr_copy_ctx.sb_document_manager = dw_1.getitemnumber(1,'ib_document_manager')
lstr_copy_ctx.sb_action_items = dw_1.getitemnumber(1,'ib_action_items')
lstr_copy_ctx.ss_template_comment = dw_1.getitemstring(1,'notes')
lstr_copy_ctx.si_located_tab = dw_1.GetItemNumber(1,'located_tab_index')
lstr_copy_ctx.si_clear_company = dw_1.GetItemNumber(1,'clear_company')
lstr_copy_ctx.si_add_contact = dw_1.GetItemNumber(1,'add_contact') 
lstr_copy_ctx.sl_workflow = dw_1.GetItemNumber(1,'trigger_workflow')
//Added By Mark Lee 05/09/12
lstr_copy_ctx.ai_ib_default_email = dw_1.GetItemNumber(1,'ib_default_email')
lstr_copy_ctx.ai_ib_owner = dw_1.GetItemNumber(1,'ib_owner')
//Added By Mark Lee 05/11/12
lstr_copy_ctx.sb_custom_multi = dw_1.GetItemNumber(1,'ib_custom_multi')

//Begin - Added By Mark Lee 11/19/2012
lstr_copy_ctx.ai_ib_create_child 						= dw_1.GetItemNumber(1,'ib_create_child')
lstr_copy_ctx.ai_ib_copy_m_company					= dw_1.GetItemNumber(1,'ib_copy_m_company')
lstr_copy_ctx.ai_ib_copy_m_company_contact		= dw_1.GetItemNumber(1,'ib_copy_m_company_contact')
//End - Added By Mark Lee 11/19/2012

lstr_copy_ctx.sb_link_privider = dw_1.getitemnumber( 1,'ib_linked_provider')//Added by Appeon long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)

ll_ctx_id = lnv_copy_ctx.of_copy_ctx_data( lstr_copy_ctx)

 
If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx

Return ll_ctx_id
end function

on w_saveas_contract.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_1
end on

on w_saveas_contract.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>openw_copy_contract()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.08.2007 by Jack
//////////////////////////////////////////////////////////////////////
long ls_parm
il_ctx_id = message.doubleparm
dw_1.insertrow(0)



//Modified By Ken.Guo 2009-08-25
//Details Tab
IF w_mdi.of_security_access(2091) < 1 Then dw_1.modify("ib_custom_data.protect = '1' ib_custom_data.CheckBox.3D = NO") //Custom data
//Added By Mark Lee 05/11/12
IF w_mdi.of_security_access(2093) < 1 Then dw_1.modify("ib_custom_data2.protect = '1' ib_custom_data2.CheckBox.3D = NO") //Custom Data 2
IF w_mdi.of_security_access(2092) < 1 Then dw_1.modify("ib_notes.protect = '1' ib_notes.CheckBox.3D = NO") //Notes
IF w_mdi.of_security_access(6951) < 1 Then dw_1.modify("ib_group_access.protect = '1' ib_group_access.CheckBox.3D = NO") //Group Access

//Main Tab
IF w_mdi.of_security_access(2100) < 1 THEN dw_1.modify("ib_requirements.protect = '1' ib_requirements.CheckBox.3D = NO")  //Requirements
IF w_mdi.of_security_access(2110) < 1 THEN dw_1.modify("ib_other_contacts.protect = '1' ib_other_contacts.CheckBox.3D = NO")  //Contacts
IF w_mdi.of_security_access(2120) < 1 THEN dw_1.modify("ib_locations.protect = '1' ib_locations.CheckBox.3D = NO")  //Locations
IF w_mdi.of_security_access(2130) < 1 THEN dw_1.modify("ib_organizations.protect = '1' ib_organizations.CheckBox.3D = NO")	//Organizations
IF w_mdi.of_security_access(2150) < 1 THEN dw_1.modify("ib_document_manager.protect = '1' ib_document_manager.CheckBox.3D = NO") //Document Manager
IF w_mdi.of_security_access(2160) < 1 THEN dw_1.modify("ib_action_items.protect = '1' ib_action_items.CheckBox.3D = NO")	//Action Items
IF (w_mdi.of_security_access(2220) < 1) and (w_mdi.of_security_access(2140) < 1) THEN dw_1.modify("ib_fee_schedule.protect = '1' ib_fee_schedule.CheckBox.3D = NO")	//Fee Schedules & Fees Non-Medical	 	 
//Added By Mark Lee 05/11/12
IF w_mdi.of_security_access(2170) < 1 THEN dw_1.modify("ib_custom_multi.protect = '1' ib_custom_multi.CheckBox.3D = NO")	//Custom multi

//Added by Appeon long.zhang 08.05.2014 (v14.2 BugH062501 hide ib_linked_provider when it is contract version)
if gb_contract_version then 
	dw_1.modify("ib_linked_provider.visible = '0' gb_1.height='396'")
else
	dw_1.modify("ib_linked_provider.visible = '1'")
end if

//---------Begin Added by (Appeon)Harry 05.05.2014 for V142 ISG-CLX--------
Long ll_ProviderRight 
if gs_cust_type = "I" or of_get_app_setting("set_9","I") = 0 then	//Linked Providers data
	ll_ProviderRight = w_mdi.of_security_access(7751)
		if ll_ProviderRight = 0 then
			dw_1.modify("ib_linked_provider.protect = '1' ib_linked_provider.CheckBox.3D = NO")
		end if
else
	dw_1.modify("ib_linked_provider.protect = '1' ib_linked_provider.CheckBox.3D = NO")
end if
//---------End Added ------------------------------------------------------
end event

type cb_2 from commandbutton within w_saveas_contract
string tag = "&Deselect All"
integer x = 50
integer y = 2248
integer width = 416
integer height = 92
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select All Tabs"
end type

event clicked;
If This.text = '&Select All Tabs' Then
	If dw_1.Describe("ib_contract_detail.protect") <> '1' Then dw_1.SetItem(1,'ib_contract_detail',1)
	If dw_1.Describe("ib_contract_dates.protect") <> '1' Then dw_1.SetItem(1,'ib_contract_dates',1)
	If dw_1.Describe("ib_custom_data.protect") <> '1' Then dw_1.SetItem(1,'ib_custom_data',1)
	//Added By Mark Lee 05/11/12
	If dw_1.Describe("ib_custom_data2.protect") <> '1' Then dw_1.SetItem(1,'ib_custom_data2',1)
	If dw_1.Describe("ib_notes.protect") <> '1' Then dw_1.SetItem(1,'ib_notes',1)
	If dw_1.Describe("ib_contract_contacts.protect") <> '1' Then dw_1.SetItem(1,'ib_contract_contacts',1)
	If dw_1.Describe("ib_group_access.protect") <> '1' Then dw_1.SetItem(1,'ib_group_access',1)
	If dw_1.Describe("ib_products.protect") <> '1' Then dw_1.SetItem(1,'ib_products',1)
	If dw_1.Describe("ib_our_contacts.protect") <> '1' Then dw_1.SetItem(1,'ib_our_contacts',1)
	If dw_1.Describe("ib_requirements.protect") <> '1' Then dw_1.SetItem(1,'ib_requirements',1)
	If dw_1.Describe("ib_other_contacts.protect") <> '1' Then dw_1.SetItem(1,'ib_other_contacts',1)
	If dw_1.Describe("ib_locations.protect") <> '1' Then dw_1.SetItem(1,'ib_locations',1)
	If dw_1.Describe("ib_organizations.protect") <> '1' Then dw_1.SetItem(1,'ib_organizations',1)
	If dw_1.Describe("ib_fee_schedule.protect") <> '1' Then dw_1.SetItem(1,'ib_fee_schedule',1)
	If dw_1.Describe("ib_document_manager.protect") <> '1' Then dw_1.SetItem(1,'ib_document_manager',1)
	If dw_1.Describe("ib_action_items.protect") <> '1' Then dw_1.SetItem(1,'ib_action_items',1)
	//Added By Mark Lee 05/11/12
	If dw_1.Describe("ib_custom_multi.protect") <> '1' Then dw_1.SetItem(1,'ib_custom_multi',1)
	
	//If dw_1.Describe("ib_linked_provider") <> '1' Then dw_1.SetItem(1,'ib_linked_provider',1)//Added by Appeon long.zhang 04.24.2014 (v14.2 Provider-Contract direct linking)
	If dw_1.Describe("ib_linked_provider.protect") <> '1' Then dw_1.SetItem(1,'ib_linked_provider',1)//Added by Appeon long.zhang 08.05.2014 (v14.2 BugH061301 'ib_linked_provider'=> 'ib_linked_provider.protect')

	This.text = '&Deselect All Tabs'
Else 
	dw_1.SetItem(1,'ib_contract_detail',0)
	dw_1.SetItem(1,'ib_contract_dates',0)
	dw_1.SetItem(1,'ib_custom_data',0)
	//Added By Mark Lee 05/11/12
	dw_1.SetItem(1,'ib_custom_data2',0)
	dw_1.SetItem(1,'ib_notes',0)
	dw_1.SetItem(1,'ib_contract_contacts',0)
	dw_1.SetItem(1,'ib_group_access',0)
	dw_1.SetItem(1,'ib_products',0)
	dw_1.SetItem(1,'ib_our_contacts',0)
	dw_1.SetItem(1,'ib_requirements',0)
	dw_1.SetItem(1,'ib_other_contacts',0)
	dw_1.SetItem(1,'ib_locations',0)
	dw_1.SetItem(1,'ib_organizations',0)
	dw_1.SetItem(1,'ib_fee_schedule',0)
	dw_1.SetItem(1,'ib_document_manager',0)
	dw_1.SetItem(1,'ib_action_items',0)	
	//Added By Mark Lee 05/11/12
	dw_1.SetItem(1,'ib_custom_multi',0)	
	dw_1.SetItem(1,'ib_linked_provider',0)//Added by Appeon long.zhang 04.24.2014 (v14.2 Provider-Contract direct linking)
	This.text = '&Select All Tabs'
End IF


end event

type cb_1 from commandbutton within w_saveas_contract
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

type cb_cancel from commandbutton within w_saveas_contract
integer x = 2089
integer y = 2248
integer width = 343
integer height = 92
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_cancel()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.08.2007 by Jack
//////////////////////////////////////////////////////////////////////
closewithreturn(parent,0)

end event

type cb_ok from commandbutton within w_saveas_contract
integer x = 1719
integer y = 2248
integer width = 343
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;long ll_existed_ctx_id,ll_ctx_id
String ls_template_name
Boolean ll_replaced = False

dw_1.Accepttext( )
ls_template_name = dw_1.GetItemString(1,'template_name')

If ls_template_name = '' or Isnull(ls_template_name) Then
	Messagebox('Template Name','Please input the template name.')
	Return 1
End If

If dw_1.Getitemnumber(1,'compute_selected_cnt') = 0 Then
	Messagebox('Save Contract Failed','The selected items have no data at all.')
	Return 1
End If

Select Top 1 ctx_id Into :ll_existed_ctx_id From ctx_templates_info Where template_name = :ls_template_name;
If sqlca.sqlcode = 0 and ll_existed_ctx_id < 0 Then
	If Messagebox('Save','Do you want to replace the existing template "' +ls_template_name+ '"?',Question!,YesNo!) = 2 Then 
		Return 1
	Else
		ll_replaced = True
	End If 
End If

ll_ctx_id = of_save_to_template()

n_cst_contract lnv_contract
lnv_contract = Create n_cst_contract
If ll_replaced Then
	lnv_contract.of_delete_ctx_detail(ll_existed_ctx_id )
	Delete From ctx_basic_info where ctx_id = :ll_existed_ctx_id;
	Commit;
End If

//Begin - Added By Mark Lee 11/21/2012				refresh the menu of the contract module
If isvalid(w_contract) and ll_replaced = false Then 
	w_contract.tab_contract_details.tabpage_search.of_create_menu_item()
End If
//End - Added By Mark Lee 11/21/2012

Close(Parent)
end event

type st_1 from statictext within w_saveas_contract
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

type dw_1 from u_dw within w_saveas_contract
integer x = 5
integer y = 4
integer width = 2450
integer height = 2240
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_saveas_ctx_to_template"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(False)
end event

event itemchanged;call super::itemchanged;String 	ls_add_contact
Integer 	li_tmp

//Begin - Added By Mark Lee 05/09/12 email subject is 'BUG: Using Templates - Dynamically Add User'
If row <= 0 Then
	Return
End If 

Choose Case dwo.name
	Case "add_contact"
		ls_add_contact = string(data)
		If not isnull(ls_add_contact) And ls_add_contact = '0' Then
			this.setitem( row,"ib_owner",0)	
			this.setitem( row,"ib_default_email",0)	
		End IF
//End - Added By Mark Lee 05/09/12
	Case "ib_copy_m_company"				//Added By Mark Lee 11/20/2012 
		If string(data) = '1' Then 
			li_tmp = this.GetItemNumber(row,"clear_company")
			If Not IsNull(li_tmp) and li_tmp = 1 Then 
				this.SetItem(row,"clear_company",0)
			End If
		End IF	
End Choose 


end event

event clicked;call super::clicked;//Added By Mark Lee 11/20/2012
IF row > 0 Then 
	Choose Case dwo.name
		Case 'b_ib_create_child'
			Messagebox(gnv_app.iapp_object.DisplayName,"The new contract will be automatically linked as a child contract to the selected contract.")
	End Choose 	
End If 
end event

