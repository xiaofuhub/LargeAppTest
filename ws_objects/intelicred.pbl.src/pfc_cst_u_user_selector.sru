$PBExportHeader$pfc_cst_u_user_selector.sru
forward
global type pfc_cst_u_user_selector from datawindow
end type
end forward

global type pfc_cst_u_user_selector from datawindow
integer width = 521
integer height = 196
integer taborder = 10
string dataobject = "d_select_user"
boolean border = false
boolean livescroll = true
end type
global pfc_cst_u_user_selector pfc_cst_u_user_selector

type variables
Private Integer il_org_id
Private Integer il_facility_id

end variables

forward prototypes
protected function integer of_get_org_id ()
protected function integer of_get_facility_id ()
end prototypes

protected function integer of_get_org_id ();Return il_org_id
end function

protected function integer of_get_facility_id ();Return il_facility_id
end function

event constructor;DataWindowChild dwchild

This.SetTransObject( SQLCA )
This.InsertRow( 0 )

This.GetChild( "user_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
//Start Code Change ----05.13.2011 #V11 maha 
dwchild.InsertRow(1)
dwchild.SetItem( 1, "user_id", "PUBLIC" )
//Start Code Change ----05.13.2011
dwchild.InsertRow(1)
dwchild.SetItem( 1, "user_id", "All" )



end event

on pfc_cst_u_user_selector.create
end on

on pfc_cst_u_user_selector.destroy
end on

