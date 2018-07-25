$PBExportHeader$pfc_cst_u_contracts_provider.sru
forward
global type pfc_cst_u_contracts_provider from userobject
end type
type dw_location from u_dw within pfc_cst_u_contracts_provider
end type
type dw_direct from u_dw within pfc_cst_u_contracts_provider
end type
end forward

global type pfc_cst_u_contracts_provider from userobject
integer width = 4293
integer height = 1968
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_location dw_location
dw_direct dw_direct
end type
global pfc_cst_u_contracts_provider pfc_cst_u_contracts_provider

type variables
long il_prac_id //Added by Appeon long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
end variables

forward prototypes
public function integer of_set_prac_id (long al_prac_id)
public function integer of_retrieve ()
public function integer of_view_contract (long al_ctx_id)
public function integer of_hide_view ()
public function integer of_read_only ()
public function integer of_bg_color (long al_rgb)
public function integer of_post_resize ()
public subroutine of_zoom ()
end prototypes

public function integer of_set_prac_id (long al_prac_id);//====================================================================
//$<Function>: of_set_prac_id
//$<Arguments>:
// 	value    long    al_prac_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
il_prac_id = al_prac_id
return 1
end function

public function integer of_retrieve ();//====================================================================
//$<Function>: of_retrieve
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

gnv_appeondb.of_startqueue( )

	dw_direct.retrieve( il_prac_id,gs_user_id )
	
	dw_location.retrieve( il_prac_id,gs_user_id )
	
gnv_appeondb.of_commitqueue( )

return 1
end function

public function integer of_view_contract (long al_ctx_id);//====================================================================
//$<Function>: of_view_contract
//$<Arguments>:
// 	value    long    al_ctx_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.17.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

str_dashboard str_para

str_para.data_id = al_ctx_id


if IsValid(gw_contract) then	
	gw_contract.of_Dashboard(str_para.data_id)
else
	gf_OpenContractFolder(str_para)
end if


Return 1
end function

public function integer of_hide_view ();//====================================================================
//$<Function>: of_hide_view
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.17.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if w_mdi.of_security_access(7741) = 0 then
		dw_direct.modify( "b_view.visible='0'")
		dw_location.modify( "b_view.visible='0'")
end if

return 1
end function

public function integer of_read_only ();//====================================================================
//$<Function>: of_read_only
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Harry 10.15.2014 for BugA101403
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if w_mdi.of_security_access(7731) = 1 then
		dw_direct.modify("DataWindow.ReadOnly='Yes'")
		dw_location.Modify("DataWindow.ReadOnly='Yes'")
end if

return 1
end function

public function integer of_bg_color (long al_rgb); //Start Code Change ----09.09.2015 #V15 maha
this.backcolor = al_rgb

return 1
end function

public function integer of_post_resize ();//Start Code Change ----02.04.2016 #V15 maha
long ll_w
long ll_h


	ll_w = this.width - 60
	ll_h = this.height / 2 - 60
	
	dw_direct.width = ll_w 
	dw_direct.height = ll_h
	
	dw_location.y = dw_direct.y + ll_h + 16
	dw_location.width = ll_w 
	dw_location.height = ll_h


return 1
end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha
dw_direct.Modify("DataWindow.Zoom=" + string(gi_zoom))  
dw_location.Modify("DataWindow.Zoom=" + string(gi_zoom))
end subroutine

on pfc_cst_u_contracts_provider.create
this.dw_location=create dw_location
this.dw_direct=create dw_direct
this.Control[]={this.dw_location,&
this.dw_direct}
end on

on pfc_cst_u_contracts_provider.destroy
destroy(this.dw_location)
destroy(this.dw_direct)
end on

event constructor;datawindowchild dwchild

dw_direct.GetChild( "status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Contract Status")

dw_direct.GetChild( "category", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Contract Category")

dw_direct.GetChild( "contract_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Contract Type")

dw_direct.GetChild( "app_facility", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(gs_user_id)


dw_location.GetChild( "status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Contract Status")

dw_location.GetChild( "category", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Contract Category")

dw_location.GetChild( "contract_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Contract Type")

dw_location.GetChild( "app_facility", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(gs_user_id)

post of_hide_view()//Added by Appeon long.zhang 04.17.2014 (v14.2 Provider-Contract direct linking)

post of_read_only() //(Appeon)Harry 10.15.2014 - for BugA101403

of_zoom()  //Start Code Change ----07.13.2017 #V154 maha
end event

type dw_location from u_dw within pfc_cst_u_contracts_provider
integer y = 948
integer width = 4293
integer height = 1004
integer taborder = 10
boolean titlebar = true
string title = "Location Linked Contracts"
string dataobject = "d_provider_location_contracts"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//this.retrieve(1)
this.settransobject( sqlca)
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.17.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_ctx_id

if dwo.name = 'b_view' then
	
	if row > 0 then
		
		ll_ctx_id = this.getitemnumber( row,'ctx_id')	
		
		if ll_ctx_id > 0 then
				of_view_contract(ll_ctx_id)
		end if
		
	end if
	
end if
end event

type dw_direct from u_dw within pfc_cst_u_contracts_provider
integer y = 4
integer width = 4293
integer height = 936
integer taborder = 10
boolean titlebar = true
string title = "Direct Link Contracts"
string dataobject = "d_provider_direct_contracts"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//this.retrieve(1)
this.settransobject( sqlca)
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.17.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_ctx_id

if dwo.name = 'b_view' then
	
	if row > 0 then
		
		ll_ctx_id = this.getitemnumber( row,'ctx_id')	
		
		if ll_ctx_id > 0 then
				of_view_contract(ll_ctx_id)
		end if
		
	end if
	
end if
end event

