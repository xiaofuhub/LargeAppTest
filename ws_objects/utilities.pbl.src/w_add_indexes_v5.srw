$PBExportHeader$w_add_indexes_v5.srw
forward
global type w_add_indexes_v5 from window
end type
type cb_3 from commandbutton within w_add_indexes_v5
end type
type st_1 from statictext within w_add_indexes_v5
end type
type cb_2 from commandbutton within w_add_indexes_v5
end type
type cb_1 from commandbutton within w_add_indexes_v5
end type
end forward

global type w_add_indexes_v5 from window
integer width = 2853
integer height = 636
boolean titlebar = true
string title = "Add Indexes"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_add_indexes_v5 w_add_indexes_v5

type variables
integer ii_stop = 0
end variables

forward prototypes
public function integer of_add_indexes ()
public function integer of_stop ()
public function integer of_execute (string as_sql)
end prototypes

public function integer of_add_indexes ();string ls_sql

SetPointer ( hourglass! )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.10.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.


/*
ls_sql = "CREATE INDEX idx_code_lookup_code ON code_lookup ( code );"
if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_data_view_fields_field_id ON data_view_fields ( field_id );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_app_hdr_facility_active ON app_hdr ( facility_id,active_status );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_verif_info_screen_active_response ON verif_info ( screen_id,active_status,response_code );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE CLUSTERED INDEX idx_security_user_facilities_rights_facility_user ON security_user_facilities ( access_rights,facility_id,user_id );"

if of_execute(ls_sql) = 1 then return 1
//ls_sql = "REORGANIZE TABLE security_user_facilities;"
//
//if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_verif_info_screen_active_facility  ON verif_info ( screen_id,active_status,facility_id );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_pd_affil_stat_prac_facility_active ON pd_affil_stat ( prac_id,parent_facility_id,active_status );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_security_user_facilities_rights_user  ON security_user_facilities ( access_rights,user_id );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE CLUSTERED INDEX idx_pd_affil_stat_facility_active  ON pd_affil_stat ( parent_facility_id,active_status );"

if of_execute(ls_sql) = 1 then return 1
//ls_sql = "REORGANIZE TABLE pd_affil_stat;"
//
//if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_SECURITY_ROLES_RIGHTS_ROLE_ID ON SECURITY_ROLES_RIGHTS ( ROLE_ID );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_net_dev_action_items_facility_active ON net_dev_action_items ( facility_id,active_status );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_pd_affil_stat_active_verifying  ON pd_affil_stat ( active_status,verifying_facility );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_security_user_facilities_rights_facility_user ON security_user_facilities ( access_rights,facility_id,user_id );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_verif_info_print_flag_screen_prac  ON verif_info ( print_flag,screen_id,prac_id );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE INDEX idx_pd_affil_stat_parent_prac_active ON pd_affil_stat ( parent_facility_id,prac_id,active_status );"

if of_execute(ls_sql) = 1 then return 1
ls_sql = "CREATE CLUSTERED INDEX idx_code_lookup_code_cluster ON code_lookup ( code );"

if of_execute(ls_sql) = 1 then return 1
//ls_sql = "REORGANIZE TABLE code_lookup;"
//
//if of_execute(ls_sql) = 1 then return 1
*/

gnv_appeondb.of_startqueue( )

//---------------------------- APPEON END ----------------------------

ls_sql = "CREATE INDEX idx_code_lookup_code ON code_lookup ( code );"
if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_data_view_fields_field_id ON data_view_fields ( field_id );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_app_hdr_facility_active ON app_hdr ( facility_id,active_status );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_verif_info_screen_active_response ON verif_info ( screen_id,active_status,response_code );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE CLUSTERED INDEX idx_security_user_facilities_rights_facility_user ON security_user_facilities ( access_rights,facility_id,user_id );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_verif_info_screen_active_facility  ON verif_info ( screen_id,active_status,facility_id );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_pd_affil_stat_prac_facility_active ON pd_affil_stat ( prac_id,parent_facility_id,active_status );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_security_user_facilities_rights_user  ON security_user_facilities ( access_rights,user_id );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE CLUSTERED INDEX idx_pd_affil_stat_facility_active  ON pd_affil_stat ( parent_facility_id,active_status );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_SECURITY_ROLES_RIGHTS_ROLE_ID ON SECURITY_ROLES_RIGHTS ( ROLE_ID );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_net_dev_action_items_facility_active ON net_dev_action_items ( facility_id,active_status );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_pd_affil_stat_active_verifying  ON pd_affil_stat ( active_status,verifying_facility );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_security_user_facilities_rights_facility_user ON security_user_facilities ( access_rights,facility_id,user_id );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_verif_info_print_flag_screen_prac  ON verif_info ( print_flag,screen_id,prac_id );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE INDEX idx_pd_affil_stat_parent_prac_active ON pd_affil_stat ( parent_facility_id,prac_id,active_status );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if
ls_sql = "CREATE CLUSTERED INDEX idx_code_lookup_code_cluster ON code_lookup ( code );"

if of_execute(ls_sql) = 1 then 	
	gnv_appeondb.of_commitqueue( )
	return 1
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 02.10.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.


gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------
return 1


end function

public function integer of_stop ();yield()

return ii_stop
end function

public function integer of_execute (string as_sql);st_1.text = as_sql
execute immediate :as_sql using sqlca;
commit using sqlca;


return of_stop()
end function

on w_add_indexes_v5.create
this.cb_3=create cb_3
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.st_1,&
this.cb_2,&
this.cb_1}
end on

on w_add_indexes_v5.destroy
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_add_indexes_v5
integer x = 2053
integer y = 312
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;ii_stop = 1
end event

type st_1 from statictext within w_add_indexes_v5
integer x = 55
integer y = 56
integer width = 2706
integer height = 220
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Click Run to start."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_add_indexes_v5
integer x = 2432
integer y = 312
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean default = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_add_indexes_v5
integer x = 1678
integer y = 312
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;of_add_indexes()

SetPointer ( arrow! )

st_1.text = "Completed"
end event

