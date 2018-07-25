$PBExportHeader$pfc_cst_qa_priv.sru
forward
global type pfc_cst_qa_priv from userobject
end type
type dw_priv from u_dw within pfc_cst_qa_priv
end type
end forward

global type pfc_cst_qa_priv from userobject
integer width = 3360
integer height = 1792
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_priv dw_priv
end type
global pfc_cst_qa_priv pfc_cst_qa_priv

type variables
Long il_prac_id
Long il_facility_id
end variables

forward prototypes
public function integer of_set_prac_id (long al_prac_id)
public function integer of_retrieve (long ai_prac_id, long ai_facil)
public function integer of_set_facility_id (long ai_facility_id)
end prototypes

public function integer of_set_prac_id (long al_prac_id);il_prac_id = al_prac_id

Return 0
end function

public function integer of_retrieve (long ai_prac_id, long ai_facil);//of_set_facility_id(ai_prac_id)
//of_set_facility_id(ai_facil)
dw_priv.retrieve(ai_prac_id,ai_facil )
return 0
end function

public function integer of_set_facility_id (long ai_facility_id);il_facility_id = ai_facility_id

Return 1
end function

on pfc_cst_qa_priv.create
this.dw_priv=create dw_priv
this.Control[]={this.dw_priv}
end on

on pfc_cst_qa_priv.destroy
destroy(this.dw_priv)
end on

type dw_priv from u_dw within pfc_cst_qa_priv
integer x = 5
integer width = 3351
integer height = 1792
integer taborder = 10
string dataobject = "d_priv_list_d_browse_profile"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_setresize( true)
end event

