$PBExportHeader$pfc_cst_u_org_facility_selector_horiz.sru
forward
global type pfc_cst_u_org_facility_selector_horiz from datawindow
end type
end forward

global type pfc_cst_u_org_facility_selector_horiz from datawindow
integer width = 1737
integer height = 196
integer taborder = 10
string dataobject = "d_org_facility_select_horizontal"
boolean border = false
boolean livescroll = true
end type
global pfc_cst_u_org_facility_selector_horiz pfc_cst_u_org_facility_selector_horiz

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

event itemchanged;DataWindowChild dwchild

IF This.GetColumnName() = "org_id" THEN
	il_org_id = Integer( data )
	This.GetChild( "facility_id", dwchild)
	IF il_org_id = 0 THEN
		dwchild.SetFilter("")
		dwchild.Filter()
		This.SetItem( 1, "facility_id", 0 )
	ELSE
		dwchild.SetFilter( "facility_name = 'All' OR organization_id = " + String( il_org_id ) )
		dwchild.Filter( )
	END IF
ELSEIF This.GetColumnName() = "facility_id" THEN	
	il_facility_id = Integer( data )
END IF
end event

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

on pfc_cst_u_org_facility_selector_horiz.create
end on

on pfc_cst_u_org_facility_selector_horiz.destroy
end on

