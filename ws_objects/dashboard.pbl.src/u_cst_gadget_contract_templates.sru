$PBExportHeader$u_cst_gadget_contract_templates.sru
forward
global type u_cst_gadget_contract_templates from u_cst_gadget
end type
end forward

global type u_cst_gadget_contract_templates from u_cst_gadget
string tag = "u_gadget_17.Contract Templates"
string text = ""
end type
global u_cst_gadget_contract_templates u_cst_gadget_contract_templates

type variables
n_cst_copy_ctx inv_copy_ctx

end variables

forward prototypes
public function integer of_settings ()
public function integer of_set_other_properties ()
end prototypes

public function integer of_settings ();//Override Ancestor Script
OpenwithParm(w_dashboard_gadget_ctx_template_config,This)
Return 1
end function

public function integer of_set_other_properties ();String ls_display_createby,ls_display_createdate
Boolean lb_show_header


super::of_set_other_properties()

ls_display_createby = This.of_get_other_property_value(CONST_DISPLAY_CREATEBY )
ls_display_createdate = This.of_get_other_property_value(CONST_DISPLAY_CREATEDATE )

If ls_display_createby = '1' Then
	dw_content.Modify("create_by.Visible='1' create_by_t.Visible='1'")
	lb_show_header = True
Else
	dw_content.Modify("create_by.Visible='0' create_by_t.Visible='0'")
End If

If ls_display_createdate = '1' Then
	dw_content.Modify("create_date.Visible='1' create_date_t.Visible='1'")
	lb_show_header = True
Else
	dw_content.Modify("create_date.Visible='0' create_date_t.Visible='0'")
End If

If lb_show_header Then
	dw_content.Modify("DataWindow.Header.Height='72' template_name.Width = '1000'")
Else
	dw_content.Modify("DataWindow.Header.Height='0' template_name.Width = '1600'")
End If

Return 1
end function

on u_cst_gadget_contract_templates.create
call super::create
end on

on u_cst_gadget_contract_templates.destroy
call super::destroy
end on

event ue_run;call super::ue_run;Long ll_template_id,ll_new_ctx_id
String ls_template_name
integer li_tab_index


n_cst_contract lnv_contract

lnv_contract = Create n_cst_contract

//Check right
If Not lnv_contract.of_allow_newctx( ) Then
	If isvalid(lnv_contract) Then Destroy lnv_contract
	MessageBox("IntelliSoft","You don't have rights to create a new contract!")
	Return 1
End If

If inv_copy_ctx.of_check_exist_contract( ) <= 0 Then Return -1

//Get template info
ls_template_name = dw_content.getitemstring(al_row,'template_name')
ll_template_id = dw_content.getitemnumber(al_row,'id')

//If gnv_data.of_getitem('icred_settings' ,'set_59' , False ) = '1' Then  //Commented by (Appeon)Eugene 06.13.2013 - V141 ISG-CLX
//	//SE product need not show message. //Added By Ken.Guo 2009-11-19.
//Else
	If Messagebox('Contract Template','Do you want to create a new contract record with the contract template ~''+ls_template_name+'~'?',Question!,YesNo!) = 2 Then Return 1
//End If

//Copy CTX from Template
ll_new_ctx_id = inv_copy_ctx.of_copy_ctx_from_template(ll_template_id )
If ll_new_ctx_id < 0 Then
	Messagebox('Error','Failed to create contract from the template, please call support.')
	If isvalid(lnv_contract) Then Destroy lnv_contract
	If isvalid(inv_copy_ctx) Then Destroy inv_copy_ctx
	Return 1
End If

//Open contract window.
PowerObject lpo_NullParm
If Not isvalid(gw_contract) Then
	gb_open_from_template = True
	gf_opencontractfolder(lpo_NullParm)
End If

//Locate new contract
li_tab_index = dw_content.getitemnumber(al_row,'located_tab_index') 
If isnull(li_tab_index) Then li_tab_index = 2
inv_copy_ctx.Post of_locate_ctx(ll_new_ctx_id,li_tab_index)

If isvalid(lnv_contract) Then Destroy lnv_contract
if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait) //(Appeon)Harry 11.21.2013 - V141 for BugH082702 of IntelliCredApp V14.1 History Issues
Return 1
end event

event constructor;call super::constructor;inv_copy_ctx = Create n_cst_copy_ctx
end event

event destructor;call super::destructor;If isvalid(inv_copy_ctx) Then Destroy inv_copy_ctx
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_contract_templates
string dataobject = "d_dashb_gadget_contract_templates"
end type

event dw_content::constructor;call super::constructor;This.of_setupdateable(False)
This.of_setsort(True)
This.inv_sort.of_setcolumnheader(True)
end event

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_contract_templates
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_contract_templates
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_contract_templates
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_contract_templates
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_contract_templates
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_contract_templates
end type

