$PBExportHeader$u_cst_gadget_favorite_workflow.sru
forward
global type u_cst_gadget_favorite_workflow from u_cst_gadget_favorite_master
end type
end forward

global type u_cst_gadget_favorite_workflow from u_cst_gadget_favorite_master
string tag = "u_gadget_6.Favorite Work Flow"
end type
global u_cst_gadget_favorite_workflow u_cst_gadget_favorite_workflow

type variables
String is_wf_module[]
end variables

forward prototypes
public function integer of_settings ()
public subroutine of_get_right ()
public subroutine of_apply_right ()
public subroutine of_get_modules (ref string as_module[])
end prototypes

public function integer of_settings ();OpenwithParm(w_dashboard_gadget_favorite_wf_cfg,This)

return 1
end function

public subroutine of_get_right ();integer li_product
integer li_contract_set
string ls_ddlb
String ls_empty[]
li_product = of_get_app_setting('set_9', 'I')
li_contract_set = of_get_app_setting('set_cont', 'I')

//Reset
is_wf_module[] = ls_empty[]

//Get modules with right
Choose Case li_product
	Case 0  //
		is_wf_module[1] = '01'
		If li_contract_set = 1 Then
			is_wf_module[2] = '03'
			is_wf_module[3] = '04'
		end If		
	Case 1 //
		is_wf_module[1] = '02'
		If li_contract_set = 1 Then
			is_wf_module[2] = '03'
			is_wf_module[3] = '04'
		end If
	Case 2	//IntelliCred SE
		is_wf_module[1] = '01'
	Case 3  //IntelliCred/App
		is_wf_module[1] = '01'
		is_wf_module[2] = '02'
		If li_contract_set = 1 Then
			is_wf_module[3] = '03'
			is_wf_module[4] = '04'
		end If
	Case 4 //IntelliContract
		is_wf_module[1] = '03'
		is_wf_module[2] = '04'
End Choose


end subroutine

public subroutine of_apply_right ();
Integer i,li_cnt
String ls_filter

of_get_right()

li_cnt = UpperBound(is_wf_module[])
If li_cnt = 0 Then Return 

For i = 1 To li_cnt
	ls_filter +=  "wf_workflow_wf_module = '" + is_wf_module[i] + "' Or "
Next

ls_filter = MidA(ls_filter,1,LenA(ls_filter) - 4 )

dw_content.SetFilter(ls_filter)
dw_content.Filter()
end subroutine

public subroutine of_get_modules (ref string as_module[]);
as_module[] = is_wf_module[]
end subroutine

event constructor;call super::constructor;of_register('WF')
end event

on u_cst_gadget_favorite_workflow.create
call super::create
end on

on u_cst_gadget_favorite_workflow.destroy
call super::destroy
end on

event ue_retrieve;call super::ue_retrieve;of_apply_right()
end event

event ue_run;call super::ue_run;Long ll_data_id
str_dashboard str_para

If al_row <= 0 Then Return 1

ll_data_id = dw_content.GetItemNumber(al_row,'dashboard_gadgets_favorite_data_id')
str_para.data_id = ll_data_id

IF IsValid(w_workflow_painter_app)  THEN
	w_workflow_painter_app.of_dashboard(str_para.data_id)
ELSE
	OpenSheetWithParm(w_workflow_painter_app,str_para,w_mdi,4,Original! )
END IF


Return 1
end event

type dw_content from u_cst_gadget_favorite_master`dw_content within u_cst_gadget_favorite_workflow
string dataobject = "d_dashb_gadget_favorite_workflow"
end type

type ln_split from u_cst_gadget_favorite_master`ln_split within u_cst_gadget_favorite_workflow
end type

type st_1 from u_cst_gadget_favorite_master`st_1 within u_cst_gadget_favorite_workflow
end type

type st_title from u_cst_gadget_favorite_master`st_title within u_cst_gadget_favorite_workflow
end type

type pb_close from u_cst_gadget_favorite_master`pb_close within u_cst_gadget_favorite_workflow
end type

type pb_max from u_cst_gadget_favorite_master`pb_max within u_cst_gadget_favorite_workflow
end type

type pb_edit from u_cst_gadget_favorite_master`pb_edit within u_cst_gadget_favorite_workflow
end type

