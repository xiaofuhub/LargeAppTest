$PBExportHeader$u_cst_gadget_favorite_correspondence.sru
forward
global type u_cst_gadget_favorite_correspondence from u_cst_gadget_favorite_master
end type
end forward

global type u_cst_gadget_favorite_correspondence from u_cst_gadget_favorite_master
string tag = "u_gadget_3  .favorite correspondence"
end type
global u_cst_gadget_favorite_correspondence u_cst_gadget_favorite_correspondence

forward prototypes
public function integer of_settings ()
end prototypes

public function integer of_settings ();OpenwithParm(w_dashboard_gadget_favorite_cor_cfg,This)
Return 1
end function

on u_cst_gadget_favorite_correspondence.create
call super::create
end on

on u_cst_gadget_favorite_correspondence.destroy
call super::destroy
end on

event constructor;call super::constructor;of_register('COR')
end event

event ue_run;call super::ue_run;Long ll_data_id
str_dashboard str_para

If al_row <= 0 Then Return 1

ll_data_id = dw_content.GetItemNumber(al_row,'dashboard_gadgets_favorite_data_id')
str_para.data_id = ll_data_id

IF IsValid(w_letter_generator)  THEN
	w_letter_generator.of_dashboard(str_para.data_id)
ELSE
	OpenSheetWithParm(w_letter_generator,str_para,w_mdi,4,Original! )
END IF

Return 1
end event

type dw_content from u_cst_gadget_favorite_master`dw_content within u_cst_gadget_favorite_correspondence
string dataobject = "d_dashb_gadget_favorite_correspondence"
end type

type ln_split from u_cst_gadget_favorite_master`ln_split within u_cst_gadget_favorite_correspondence
end type

type st_1 from u_cst_gadget_favorite_master`st_1 within u_cst_gadget_favorite_correspondence
end type

type st_title from u_cst_gadget_favorite_master`st_title within u_cst_gadget_favorite_correspondence
end type

type pb_close from u_cst_gadget_favorite_master`pb_close within u_cst_gadget_favorite_correspondence
end type

type pb_max from u_cst_gadget_favorite_master`pb_max within u_cst_gadget_favorite_correspondence
end type

type pb_edit from u_cst_gadget_favorite_master`pb_edit within u_cst_gadget_favorite_correspondence
end type

