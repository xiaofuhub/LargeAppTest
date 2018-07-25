$PBExportHeader$w_ctx_template_properties.srw
forward
global type w_ctx_template_properties from w_response
end type
type dw_1 from u_dw within w_ctx_template_properties
end type
type cb_1 from commandbutton within w_ctx_template_properties
end type
type cb_cancel from commandbutton within w_ctx_template_properties
end type
type cb_ok from commandbutton within w_ctx_template_properties
end type
type st_1 from statictext within w_ctx_template_properties
end type
end forward

global type w_ctx_template_properties from w_response
integer width = 2505
integer height = 1280
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
dw_1 dw_1
cb_1 cb_1
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
end type
global w_ctx_template_properties w_ctx_template_properties

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
lstr_copy_ctx.ss_template_name = dw_1.getitemstring(1,'template_name')
lstr_copy_ctx.sl_ctx_id = il_ctx_id
lstr_copy_ctx.sb_contract_detail = dw_1.getitemnumber(1,'ib_contract_detail') 
lstr_copy_ctx.sb_contract_dates = dw_1.getitemnumber(1,'ib_contract_dates')
lstr_copy_ctx.sb_custom_data = dw_1.getitemnumber(1,'ib_custom_data')
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

//Added By Mark Lee 05/11/12
lstr_copy_ctx.ai_ib_default_email = dw_1.GetItemNumber(1,'ib_default_email')
lstr_copy_ctx.ai_ib_owner = dw_1.GetItemNumber(1,'ib_owner')
lstr_copy_ctx.sb_custom_multi = dw_1.GetItemNumber(1,'ib_custom_multi')
lstr_copy_ctx.sb_custom_data2 = dw_1.getitemnumber(1,'ib_custom_data2')

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

on w_ctx_template_properties.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.st_1
end on

on w_ctx_template_properties.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
end on

event open;call super::open;long ll_template_id
ll_template_id = message.doubleparm

dw_1.SetTransObject(SQLCA)
dw_1.Retrieve( ll_template_id)
end event

type dw_1 from u_dw within w_ctx_template_properties
integer x = 5
integer y = 4
integer width = 2482
integer height = 1136
integer taborder = 10
string title = "none"
string dataobject = "d_ctx_template_properties"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(True)
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
			Messagebox(gnv_app.iapp_object.DisplayName,"The new contract will be automatically linked as a child contract to the selected contract. ")
	End Choose 	
End If 
end event

type cb_1 from commandbutton within w_ctx_template_properties
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

type cb_cancel from commandbutton within w_ctx_template_properties
integer x = 2107
integer y = 1144
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

event clicked;//closewithreturn(parent,0)
Close(Parent)

end event

type cb_ok from commandbutton within w_ctx_template_properties
integer x = 1728
integer y = 1144
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

event clicked;str_copy_ctx lstr_copy_ctx
dw_1.Accepttext( )
If dw_1.Modifiedcount( ) > 0 Then
	If dw_1.update() = 1 Then
		Commit;
	Else
		Messagebox('Save Error','Failed to save data, please call support.')
		Return 1
	End IF
End If

cb_cancel.event clicked( )	
end event

type st_1 from statictext within w_ctx_template_properties
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

