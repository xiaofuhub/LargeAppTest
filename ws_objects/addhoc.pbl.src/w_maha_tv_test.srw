$PBExportHeader$w_maha_tv_test.srw
forward
global type w_maha_tv_test from window
end type
type tv_fields from u_tvs_rpt within w_maha_tv_test
end type
end forward

global type w_maha_tv_test from window
integer width = 3168
integer height = 1760
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
tv_fields tv_fields
end type
global w_maha_tv_test w_maha_tv_test

on w_maha_tv_test.create
this.tv_fields=create tv_fields
this.Control[]={this.tv_fields}
end on

on w_maha_tv_test.destroy
destroy(this.tv_fields)
end on

type tv_fields from u_tvs_rpt within w_maha_tv_test
integer x = 18
integer y = 20
integer width = 1033
integer height = 1608
integer taborder = 10
end type

event constructor;call super::constructor;
this.of_register( 1, "data_view_screen_screen_name", "data_view_screen_screen_alias", ":table_id", "d_app_select_tables", SQLCA, "")
this.of_register( 2, "field_id", "field_name_allias", ":table_id", "d_app_select_field", SQLCA, "")
//if gs_DbType = 'SQL' THEN
//	this.of_register( 3, "c_name", "c_alias", ":as_table,:al_data_view_id,:al_view_id,:al_onlyvisible", "d_view_fields_alias_sql", SQLCA, "flag")
//ELSE
//	this.of_register( 3, "c_name", "c_alias", ":as_table,:al_data_view_id,:al_view_id,:al_onlyvisible", "d_view_fields_alias_asa", SQLCA, "flag")
//END IF


//this.of_register( 1, "module", "name", ":al_view_id", "d_view_module_fields", SQLCA, "")
//this.of_register( 2, "v_name", "v_alias", ":al_view_id,:al_module", "d_view_names_fields", SQLCA, "")
//if gs_DbType = 'SQL' THEN
//	this.of_register( 3, "c_name", "c_alias", ":as_table,:al_data_view_id,:al_view_id,:al_onlyvisible", "d_view_fields_alias_sql", SQLCA, "flag")
//ELSE
//	this.of_register( 3, "c_name", "c_alias", ":as_table,:al_data_view_id,:al_view_id,:al_onlyvisible", "d_view_fields_alias_asa", SQLCA, "flag")
//END IF
end event

