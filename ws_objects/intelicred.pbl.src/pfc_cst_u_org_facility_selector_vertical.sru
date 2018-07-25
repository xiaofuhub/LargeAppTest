$PBExportHeader$pfc_cst_u_org_facility_selector_vertical.sru
forward
global type pfc_cst_u_org_facility_selector_vertical from pfc_cst_u_org_facility_selector_horiz
end type
end forward

global type pfc_cst_u_org_facility_selector_vertical from pfc_cst_u_org_facility_selector_horiz
int Width=1111
int Height=204
string DataObject="d_org_facility_select_vertical"
end type
global pfc_cst_u_org_facility_selector_vertical pfc_cst_u_org_facility_selector_vertical

event constructor;DataWindowChild dwchild

This.SetTransObject( SQLCA )
This.InsertRow( 0 )

This.GetChild( "facility_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( gs_user_id )
dwchild.InsertRow(1)
dwchild.SetItem( 1, "facility_name", "All" )
dwchild.SetItem( 1, "facility_id", 0 )

This.SetItem( 1, "facility_id", 0 )




end event

