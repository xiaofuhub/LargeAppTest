$PBExportHeader$n_cst_import_sql.sru
$PBExportComments$Create by Jack 11/30/2006
forward
global type n_cst_import_sql from nonvisualobject
end type
end forward

global type n_cst_import_sql from nonvisualobject autoinstantiate
end type

type variables
string is_sql_statments[]
end variables

forward prototypes
public subroutine of_update_version_7 ()
public subroutine of_execute ()
end prototypes

public subroutine of_update_version_7 ();/////////////////////////////////////////////////////////////////////////
// Create import tables syntax
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_hdr" + & 
"(" + &
"import_id integer identity," + &
"import_name varchar(50) null," + &
"imp_file varchar(100) null," + &
"imp_format char(1) null," + &
"record_delimiter varchar(5) null," + &
"field_delimiter varchar(5) null," + &
"odbc_name varchar (50) null," + &
"odbc_login varchar(25) null," + &
"odbc_password varchar(25) null," + &
"ignore_header_row integer null," + &
"flat_multi integer null," + &
"lock_file integer null," + &
"project_id integer null," + &
"isoft_module integer null," + &
"create_date datetime null," + &
"mod_date datetime null," + &
"mod_user varchar(25) null," + &
"audit_type char(1) null," + &
"add_protocol integer null," + & 
"err_notify integer null," + &
"err_process integer null," + &
"err_file integer null," + &
"notify_addr1 varchar(100) null," + &
"notify_addr2 varchar(100) null," + &
"update_verifications integer null," + &
"import_notes varchar(255) null," + &
"import_sql varchar(1000) null," + &
"doc_updated datetime null," + &
"doc_name varchar(50) null," + &
"import_doc image null," + &
"primary key (import_id)" + &
");"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "alter table import_hdr alter column record_delimiter varchar(5) null;"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "alter table import_hdr alter column field_delimiter varchar(5) null;"
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_project" + & 
"(" + &
"project_id integer identity," + &
"project_name varchar(30) null," + &
"def_parent_id integer null," + &
"def_audit_id integer null," + &
"def_verif_id integer null," + &
"def_affil_stat char(1) null," + &
"def_appt_type char(1) null," + &
"def_status integer null," + &
"def_user char(10) null," + &
"primary key (project_id)" + &
");"
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_table_records" + &
"(" + &
"table_records_id integer identity," + &
"import_id integer not null," + &
"isoft_table_id integer null," + &
"primary key (table_records_id)" + &
");"
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_mapping_fields" + &
"(" + &
"rec_id decimal(10, 0) identity," + &
"table_records_id integer not null," + &
"case_type char(1) null," + &
"strip_type char(1) null," + &
"field_format varchar(40) null," + &
"isoft_field_id integer null," + &
"key_field integer null," + &
"id_field integer null," + &
"null_type integer null," + &  
"null_value varchar(50) null," + &
"link_value decimal(10, 0) null," + &
"facility_id integer null," + &
"no_match_procd decimal(10, 0) null," + &
"lu_template decimal(10,0) null," + &
"lu_type char(1) null," + &
"lu_table varchar(50) null," + &
"lu_field_name varchar(50) null," + &
"import_field_id decimal(10,0) null," + &
"primary key (rec_id)" + &
");"
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_file_fields" + &
"(" + &
"rec_id decimal(10, 0) identity," + &
"import_id integer not null," + &
"field_order integer not null," + &
"imp_field_name varchar(40) not null," + &
"field_length integer not null," + &
"field_format varchar(40) null," + &
"case_type char(1) null," + &
"strip_type char(1) null," + &
"comp_def varchar(50) null," + &
"default_value varchar(100) null," + &
"primary key (rec_id)" + &
");"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "alter table import_file_fields add default_value varchar(100) null;"
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_process" + &
"(" + &
"process_id numeric(16,0) identity," + &
"import_id integer null," + &
"pro_date datetime null," + &
"rec_count numeric(10,0) null," + &
"error_count numeric(10,0) null," + &
"mod_count numeric(10,0) null," + &
"add_count numeric(10,0) null," + &
"process_file image null," + &
"primary key (process_id)" + &
");"
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_process_errors" + &
"(" + &
"error_id numeric(16,0) identity," + &
"process_id numeric(16,0) null," + &
"error_record numeric(10,0) null," + &
"error_field varchar(40) null," + &
"err_type integer null," + &
"err_value varchar(300) null," + &
"err_isoft_table varchar(50) null," + &
"primary key (error_id)" + &
");"
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_lookup_mapping" + &
"(" + &
"ilm_id decimal(10,0) identity," + &
"map_type char(1) null," + &
"lookup_table varchar(50) null," + &
"template_name varchar(40) null," + &
"primary key (ilm_id)" + &
");"
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_lu_map_fields" + &
"(" + &
"map_id decimal(10,0) identity," + &
"ilm_id  decimal(10,0) null," + &
"is_lu_code decimal(10,0) null," + &
"import_value varchar(50) null," + &
"primary key (map_id)" + &
");"
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"CREATE TABLE import_table_gen" + &
"(" + & 
"field_1 varchar(100) null," + &
"field_2 varchar(100) null," + &
"field_3 varchar(100) null," + &
"field_4 varchar(100) null," + &
"field_5 varchar(100) null," + &
"field_6 varchar(100) null," + &
"field_7 varchar(100) null," + &
"field_8 varchar(100) null," + &
"field_9 varchar(100) null," + &
"field_10 varchar(100) null," + &
"field_11 varchar(100) null," + &
"field_12 varchar(100) null," + &
"field_13 varchar(100) null," + &
"field_14 varchar(100) null," + &
"field_15 varchar(100) null," + &
"field_16 varchar(100) null," + &
"field_17 varchar(100) null," + &
"field_18 varchar(100) null," + &
"field_19 varchar(100) null," + &
"field_20 varchar(100) null," + &
"field_21 varchar(100) null," + &
"field_22 varchar(100) null," + &
"field_23 varchar(100) null," + &
"field_24 varchar(100) null," + &
"field_25 varchar(100) null," + &
"field_26 varchar(100) null," + &
"field_27 varchar(100) null," + &
"field_28 varchar(100) null," + &
"field_29 varchar(100) null," + &
"field_30 varchar(100) null," + &
"field_31 varchar(100) null," + &
"field_32 varchar(100) null," + &
"field_33 varchar(100) null," + &
"field_34 varchar(100) null," + &
"field_35 varchar(100) null," + &
"field_36 varchar(100) null," + &
"field_37 varchar(100) null," + &
"field_38 varchar(100) null," + &
"field_39 varchar(100) null," + &
"field_40 varchar(100) null," + &
"field_41 varchar(100) null," + &
"field_42 varchar(100) null," + &
"field_43 varchar(100) null," + &
"field_44 varchar(100) null," + &
"field_45 varchar(100) null," + &
"field_46 varchar(100) null," + &
"field_47 varchar(100) null," + &
"field_48 varchar(100) null," + &
"field_49 varchar(100) null," + &
"field_50 varchar(100) null," + &
"field_51 varchar(100) null," + &
"field_52 varchar(100) null," + &
"field_53 varchar(100) null," + &
"field_54 varchar(100) null," + &
"field_55 varchar(100) null," + &
"field_56 varchar(100) null," + &
"field_57 varchar(100) null," + &
"field_58 varchar(100) null," + &
"field_59 varchar(100) null," + &
"field_60 varchar(100) null," + &
"field_61 varchar(100) null," + &
"field_62 varchar(100) null," + &
"field_63 varchar(100) null," + &
"field_64 varchar(100) null," + &
"field_65 varchar(100) null," + &
"field_66 varchar(100) null," + &
"field_67 varchar(100) null," + &
"field_68 varchar(100) null," + &
"field_69 varchar(100) null," + &
"field_70 varchar(100) null," + &
"field_71 varchar(100) null," + &
"field_72 varchar(100) null," + &
"field_73 varchar(100) null," + &
"field_74 varchar(100) null," + &
"field_75 varchar(100) null," + &
"field_76 varchar(100) null," + &
"field_77 varchar(100) null," + &
"field_78 varchar(100) null," + &
"field_79 varchar(100) null," + &
"field_80 varchar(100) null," + &
"field_81 varchar(100) null," + &
"field_82 varchar(100) null," + &
"field_83 varchar(100) null," + &
"field_84 varchar(100) null," + &
"field_85 varchar(100) null," + &
"field_86 varchar(100) null," + &
"field_87 varchar(100) null," + &
"field_88 varchar(100) null," + &
"field_89 varchar(100) null," + &
"field_90 varchar(100) null," + &
"field_91 varchar(100) null," + &
"field_92 varchar(100) null," + &
"field_93 varchar(100) null," + &
"field_94 varchar(100) null," + &
"field_95 varchar(100) null," + &
"field_96 varchar(100) null," + &
"field_97 varchar(100) null," + &
"field_98 varchar(100) null," + &
"field_99 varchar(100) null," + &
"field_100 varchar(100) null," + &
"field_101 varchar(100) null," + &
"field_102 varchar(100) null," + &
"field_103 varchar(100) null," + &
"field_104 varchar(100) null," + &
"field_105 varchar(100) null," + &
"field_106 varchar(100) null," + &
"field_107 varchar(100) null," + &
"field_108 varchar(100) null," + &
"field_109 varchar(100) null," + &
"field_110 varchar(100) null," + &
"field_111 varchar(100) null," + &
"field_112 varchar(100) null," + &
"field_113 varchar(100) null," + &
"field_114 varchar(100) null," + &
"field_115 varchar(100) null," + &
"field_116 varchar(100) null," + &
"field_117 varchar(100) null," + &
"field_118 varchar(100) null," + &
"field_119 varchar(100) null," + &
"field_120 varchar(100) null," + &
"field_121 varchar(100) null," + &
"field_122 varchar(100) null," + &
"field_123 varchar(100) null," + &
"field_124 varchar(100) null," + &
"field_125 varchar(100) null," + &
"field_126 varchar(100) null," + &
"field_127 varchar(100) null," + &
"field_128 varchar(100) null," + &
"field_129 varchar(100) null," + &
"field_130 varchar(100) null," + &
"field_131 varchar(100) null," + &
"field_132 varchar(100) null," + &
"field_133 varchar(100) null," + &
"field_134 varchar(100) null," + &
"field_135 varchar(100) null," + &
"field_136 varchar(100) null," + &
"field_137 varchar(100) null," + &
"field_138 varchar(100) null," + &
"field_139 varchar(100) null," + &
"field_140 varchar(100) null," + &
"field_141 varchar(100) null," + &
"field_142 varchar(100) null," + &
"field_143 varchar(100) null," + &
"field_144 varchar(100) null," + &
"field_145 varchar(100) null," + &
"field_146 varchar(100) null," + &
"field_147 varchar(100) null," + &
"field_148 varchar(100) null," + &
"field_149 varchar(100) null," + &
"field_150 varchar(100) null," + &
"field_151 varchar(100) null," + &
"field_152 varchar(100) null," + &
"field_153 varchar(100) null," + &
"field_154 varchar(100) null," + &
"field_155 varchar(100) null," + &
"field_156 varchar(100) null," + &
"field_157 varchar(100) null," + &
"field_158 varchar(100) null," + &
"field_159 varchar(100) null," + &
"field_160 varchar(100) null," + &
"field_161 varchar(100) null," + &
"field_162 varchar(100) null," + &
"field_163 varchar(100) null," + &
"field_164 varchar(100) null," + &
"field_165 varchar(100) null," + &
"field_166 varchar(100) null," + &
"field_167 varchar(100) null," + &
"field_168 varchar(100) null," + &
"field_169 varchar(100) null," + &
"field_170 varchar(100) null," + &
"field_171 varchar(100) null," + &
"field_172 varchar(100) null," + &
"field_173 varchar(100) null," + &
"field_174 varchar(100) null," + &
"field_175 varchar(100) null," + &
"field_176 varchar(100) null," + &
"field_177 varchar(100) null," + &
"field_178 varchar(100) null," + &
"field_179 varchar(100) null," + &
"field_180 varchar(100) null," + &
"field_181 varchar(100) null," + &
"field_182 varchar(100) null," + &
"field_183 varchar(100) null," + &
"field_184 varchar(100) null," + &
"field_185 varchar(100) null," + &
"field_186 varchar(100) null," + &
"field_187 varchar(100) null," + &
"field_188 varchar(100) null," + &
"field_189 varchar(100) null," + &
"field_190 varchar(100) null," + &
"field_191 varchar(100) null," + &
"field_192 varchar(100) null," + &
"field_193 varchar(100) null," + &
"field_194 varchar(100) null," + &
"field_195 varchar(100) null," + &
"field_196 varchar(100) null," + &
"field_197 varchar(100) null," + &
"field_198 varchar(100) null," + &
"field_199 varchar(100) null," + &
"field_200 varchar(100) null," + &
");"

/////////////////////////////////////////////////////////////////////////
// Insert security records
long ll_role_id[]
long i, ll_max_rights_id
DataStore lds_roles

lds_roles = Create DataStore
lds_roles.DataObject = 'd_security_roles'
lds_roles.SetTransObject(sqlca)

gnv_appeondb.of_StartQueue( )
lds_roles.Retrieve()
Select Max(rights_id) Into :ll_max_rights_id From security_roles_rights;
gnv_appeondb.of_CommitQueue( )

is_sql_statments[UpperBound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (6928);"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 66, 4, 'Import Painter', 1);"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 66, 605, 'Main', 1);"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6928, 66, 605, 'View Rights', 2);"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "UPDATE security_modules SET prod_id = 1 WHERE module_id = 66;"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "UPDATE security_sub_module SET prod_id = 1 WHERE sub_module_id = 605;"

ll_role_id[] = lds_roles.object.role_id[1, lds_roles.RowCount()]
ll_role_id[UpperBound(ll_role_id) + 1] = 1
for i = 1 to UpperBound(ll_role_id)
	ll_max_rights_id ++
	is_sql_statments[UpperBound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values( " + String(ll_max_rights_id) + ", " + String(ll_role_id[i]) + ", 6928, 2);"
next
Destroy lds_roles

/////////////////////////////////////////////////////////////////////////
// Execute update
of_Execute()
end subroutine

public subroutine of_execute ();long ll_i
string ls_null[]
boolean lb_ref_cache

If Upperbound(is_sql_statments) > 0 Then  lb_ref_cache  = True

If Upperbound(is_sql_statments) > 0 Then 
	
	If Not isvalid( w_infodisp ) Then Open(w_infodisp)

	If isvalid(w_infodisp) Then w_infodisp.title = 'Creating import module tables, Please stand by'
	If isvalid(w_infodisp) Then w_infodisp.Center = True
	If isvalid(w_infodisp) Then w_infodisp.st_complete.visible = False
	If isvalid(w_infodisp) Then w_infodisp.st_3.visible = False
	If isvalid(w_infodisp) Then w_infodisp.st_information.visible = False
	If isvalid(w_infodisp) Then w_infodisp.st_1.text = 'Creating import module tables, Please stand by for version 7.0: ' 
	If isvalid(w_infodisp) Then w_infodisp.wf_set_min_max(1,upperbound(is_sql_statments))
		
	gnv_appeondb.of_startqueue( )
	
	For ll_i = 1 TO upperbound(is_sql_statments)
		If isvalid(w_infodisp) Then w_infodisp.st_1.text = 'ModIfication:' +string(ll_i) +' of '+ string(upperbound(is_sql_statments)) +' Please stand by!'
		EXECUTE IMMEDIATE :is_sql_statments[LL_I] USING sqlca;
		Commit;
		If isvalid(w_infodisp) Then w_infodisp.wf_step_pbar(1)
	Next
	
	gnv_appeondb.of_commitqueue( )
	
	If isvalid(w_infodisp) Then w_infodisp.st_1.text = 'Commiting modIfications Please stand by!'
	
	If isvalid(w_infodisp) Then Close(w_infodisp)
	    
End If
is_sql_statments = ls_null


end subroutine

on n_cst_import_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_import_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

