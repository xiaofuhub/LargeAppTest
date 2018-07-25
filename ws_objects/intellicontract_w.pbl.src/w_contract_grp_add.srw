$PBExportHeader$w_contract_grp_add.srw
$PBExportComments$[intellicontract_w] Response window used for adding group practices to the location tab
forward
global type w_contract_grp_add from w_response
end type
type cb_close from u_cb within w_contract_grp_add
end type
type cb_ok from u_cb within w_contract_grp_add
end type
type uo_data_add from uo_contract_grp_add within w_contract_grp_add
end type
end forward

global type w_contract_grp_add from w_response
integer width = 3653
integer height = 2032
string title = "Add Groups/Locations"
long backcolor = 33551856
cb_close cb_close
cb_ok cb_ok
uo_data_add uo_data_add
end type
global w_contract_grp_add w_contract_grp_add

type variables
long il_group_id




//n_cst_dwsrv_find inv_find
PowerObject	 ipo

u_tabpg_contract_locations iw_locations_tabpage



n_ds ids_pracs  


string is_sql


//dragObject ipo2 //u_tabpg_contract_locations 
window  iw_window





//ipo2 = u_tabpg_contract_locations 
end variables

on w_contract_grp_add.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.uo_data_add=create uo_data_add
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.uo_data_add
end on

on w_contract_grp_add.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.uo_data_add)
end on

event pfc_postopen;call super::pfc_postopen;

//ids_pracs = create n_ds
//ids_pracs.dataobject=  'd_ctx_group_practitioners'//'dS_contract_group_practitioners'
//ids_pracs.settransobject(sqlca)
//
ipo = message.powerobjectparm	

iw_locations_tabpage = ipo
uo_data_add.of_post_open( )
//uo_data_add.dw_detail.retrieve()
//
//uo_data_add.dw_search.of_setupdateable( false)

iw_window  = w_contract
end event

event closequery;return 0
end event

type cb_close from u_cb within w_contract_grp_add
integer x = 3237
integer y = 32
integer taborder = 31
string text = "&Cancel"
end type

event clicked;call super::clicked;
Close(parent)
end event

type cb_ok from u_cb within w_contract_grp_add
integer x = 2871
integer y = 32
integer taborder = 21
fontcharset fontcharset = ansi!
string text = "&OK"
end type

event clicked;call super::clicked;
long  ll_ctx_id
 
 ll_ctx_id = iw_locations_tabpage.inv_contract_details.of_get_ctx_id( )

uo_data_add.of_add_data( ll_ctx_id)

iw_locations_tabpage.setredraw( true)

CLOSE(PARENT)

end event

type uo_data_add from uo_contract_grp_add within w_contract_grp_add
integer y = 8
integer taborder = 41
end type

on uo_data_add.destroy
call uo_contract_grp_add::destroy
end on

