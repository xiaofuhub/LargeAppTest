$PBExportHeader$n_cst_dm_sql.sru
forward
global type n_cst_dm_sql from nonvisualobject
end type
end forward

global type n_cst_dm_sql from nonvisualobject autoinstantiate
end type

type variables
string is_init
string is_sql_statments[]
end variables

forward prototypes
public subroutine of_update_version_7 ()
public function integer of_execute (string as_sql)
public subroutine of_execute_sqls ()
public function integer of_import_from_support_doc ()
end prototypes

public subroutine of_update_version_7 ();//This function contained all db updates for workflow
String ls_sql
//Update the secuity
Long ll_Module_id
long ll_num

if Not isvalid( w_infodisp ) then open(w_infodisp)

/*
if isvalid(w_infodisp) then w_infodisp.title = 'Creating Document Manager Module tables, Please stand by'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Creating security roles for work flow module, Please stand by for version 7.0: ' 


Select Count(*) Into :ll_Module_id From security_modules Where module_name = 'Work Flow Painter';
If ll_Module_id = 0 Then
	Insert Into security_modules Values(61, 0,'Work Flow Painter', 1);
	Insert Into security_sub_module Values(600, 61, 'Main', 1);
	Insert Into security_rights_action Values(5830, 61, 600, 'View Rights', 2);
	
	Insert Into security_modules Values(62, 0,'Email Painter', 1);
	Insert Into security_sub_module Values(601, 62, 'Main', 1);
	Insert Into security_rights_action Values(5831, 62, 601, 'View Rights', 2);
	
	n_ds ds_roles, lds_rolerights
	Integer li_rows, i
	Long ll_roleid, ll_maxid, ll_found
	String ls_new_syntax, ls_error
	
	ds_roles = Create n_ds
	ds_roles.DataObject = "d_roles"
	ds_roles.SetTransObject( SQLCA )
	
	lds_rolerights = Create n_ds
	ls_sql = "select security_roles_rights.role_id, security_roles_rights.action_id from security_roles_rights "
	ls_new_syntax = SQLCA.SyntaxFromSQL( ls_sql, "", ls_error )
	lds_rolerights.Create( ls_new_syntax, ls_error )
	lds_rolerights.SetTransObject(SQLCA)
	
	gnv_appeondb.of_startqueue()
	ds_roles.Retrieve()
	lds_rolerights.Retrieve()
	Select Max( rights_id ) Into :ll_maxid From security_roles_rights;
	gnv_appeondb.of_commitqueue()
	
	If IsNull( ll_maxid ) Then ll_maxid = 0;
	li_rows = ds_roles.RowCount()
	
	For i = 1 To li_rows
		ll_roleid = ds_roles.GetItemNumber( i, "role_id" )
		
		ll_found = lds_rolerights.Find( "role_id = " + String( ll_roleid ) + " and action_id = 5830", 1, lds_rolerights.RowCount() )
		If ll_found < 1 Then
			ll_maxid ++
			of_execute( "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + String( ll_maxid ) +  ", " + String( ll_roleid ) + ", 5830, 2);" )
		End If
		
		ll_found = lds_rolerights.Find( "role_id = " + String( ll_roleid ) + " and action_id = 5831", 1, lds_rolerights.RowCount() )
		If ll_found < 1 Then
			ll_maxid ++
			of_execute( "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + String( ll_maxid ) +  ", " + String( ll_roleid ) + ", 5831, 2);" )
		End If
	Next
	
	Destroy( ds_roles );
	Destroy( lds_rolerights );
End If
*/

//1. document manager

ls_sql = " &
	create table Ctx_am_document (	&
	Doc_id               int         not null,	&
	ctx_id               int         not null,	&
	doc_name             Varchar(200)         not null,	&
	Revision             Numeric(5,1)         not null default 0,	&
	doc_type             char(1)           not null,	&
	doc_ext              varchar(10)           not null default 'doc',	&
	category             numeric(6,0)         not null,	&
	Base_type            char(1)           null,	&
	From_templete_id        numeric(6,0)         null,	&
	export_id 				int 					null, &
	Wf_id                int         null,	&
	Create_by            char(10)          null,	&
	Create_date          datetime             null default getdate(),	&
	Status               numeric(6,0)         null,	&
	Status_by            char(10)          null,	&
	Status_date          datetime             null,	&
	filename     	     Varchar(250)         null,	&
	Doc_from_type        char(1)           null,	&
	Doc_from_name        Varchar(20)          null,	&
	Notes                Varchar(255)         null,	&
	checkout_by	     varchar(10)          null,	&
	checkout_date	     datetime             null,	&
	checkout_status	     char(1)           not null default '0',	&
	Revision_control     char(1)           not null default '0',	&
	constraint PK_CTX_AM_DOCUMENT primary key  (Doc_id) &
	);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table Ctx_am_document add constraint FK_CTX_AM_DOCUMENT_CTX_BASI foreign key (ctx_id) references CTX_BASIC_INFO (ctx_id);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table Ctx_am_document  add constraint FK_CTX_AM_DOCUMENT_CODE_LOO1 foreign key (category)  references code_lookup (lookup_code);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table Ctx_am_document  add constraint FK_CTX_AM_DOCUMENT_CODE_LOO2 foreign key (Status) references code_lookup (lookup_code);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//2. document audit 
ls_sql = "&
	create table Ctx_am_doc_audit (	&
	Doc_id               int         not null,	&
	audit_id             int         not null,	&
	Revision             Numeric(5,1)         not null,	&
	doc_ext              varchar(10)           not null default 'doc',	&
	action               varchar(200)         not null,	&
	action_by            varchar(10)          null,	&
	action_date          datetime             null default getdate(),	&
	filename     	     Varchar(250)         null,	&
	Doc_from_type        char(1)           null,	&
	Doc_from_name        Varchar(20)          null,	&
	Notes                Varchar(255)         null,	&
	id_forcatalog        int identity,	&
	constraint PK_CTX_AM_DOC_AUDIT primary key  (Doc_id,audit_id)	&
	);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "CREATE UNIQUE INDEX index_ctx_am_doc_audit_id_forcatalog ON Ctx_am_doc_audit (id_forcatalog);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table Ctx_am_doc_audit add constraint FK_CTX_AM_DOC_AUDIT_Doc_id foreign key (Doc_id) references Ctx_am_document (Doc_id);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql



//3. document image
ls_sql = " &
	create table Ctx_am_doc_image (	&
	Doc_id               int         not null,	&
	Revision             Numeric(5,1)         not null,	&
	image_file           Image                null,	&
	pdftext           	text                 null,	&
	modify_date          datetime             null default getdate(),	&
	id_forcatalog        int identity,	&
	doc_ext             varchar(10)           null default 'doc',	&
	constraint PK_CTX_AM_DOC_IMAGE primary key  (Doc_id,Revision)	&
	) ;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = "CREATE UNIQUE INDEX index_ctx_am_doc_image_id_forcatalog ON Ctx_am_doc_image (id_forcatalog);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table Ctx_am_doc_image add constraint FK_CTX_AM_DOC_IMAGE_Doc_id foreign key (Doc_id) references Ctx_am_document (Doc_id);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//4. Action Item for document
//01.30.2007 By Jervis Modify:Seq_ID integer identity NOT NULL,	&
ls_sql = " &
	CREATE TABLE ctx_am_action_item(	&
	Doc_ID integer NOT NULL, 	&
	Seq_ID integer identity NOT NULL,	&
	action_order integer not null default 0, &
	Action_Type decimal(6,0) NOT NULL, 	&
	Action_User varchar(50)         null, &
	Action_Status decimal(6,0)         null, 	&
	Status_Date datetime         null, &
	Due_Date datetime         null, &
	Attempt_Times integer         null, &
	First_Attempt datetime         null, &
	Last_Attempt datetime         null, &
	Print_flag integer         null, &
	Create_date datetime          null DEFAULT getdate(), &
	Letter_id integer         null, &
	Wf_step integer         null, &
	Wf_id integer         null, &
	Wf_action_type_id integer         null, &
	wf_assigned_by varchar(50)         null, &
	active_status integer         null, &
	wf_complete_flag char(1)          null DEFAULT ('N'), &
	Notes varchar(255)         null , &
	CONSTRAINT PK_CTX_AM_ACTION_ITEMS PRIMARY KEY (doc_id,seq_id)&
	);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = "alter table ctx_am_action_item add constraint FK_CTX_AM_ACTION_ITEM_Doc_id foreign key (Doc_id) references Ctx_am_document (Doc_id);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table ctx_am_action_item add constraint FK_CTX_AM_ACTION_ITEM_wf_id foreign key (wf_id) references wf_workflow (wf_id);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table ctx_am_action_item add constraint FK_CTX_AM_ACTION_ITEM_letter_id foreign key (letter_id) references sys_letters (letter_id);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//Added 01.12.2007 By Jervis
//05 Ctx_am_document_clause
ls_sql = " &
	CREATE TABLE Ctx_am_document_clause (	&
	Doc_id int NOT NULL ,	&
	Revision numeric(5, 1) NOT NULL ,	&
	Ctx_acp_clause_id numeric(6, 0) NOT NULL ,&
	Orders int NULL,	&
	CONSTRAINT PK_Ctx_am_document_clause PRIMARY KEY (Doc_id,Revision,Ctx_acp_clause_id	) &
	) ;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = "ALTER TABLE Ctx_am_document_clause ADD CONSTRAINT FK_Ctx_am_document_clause_ctx_acp_clause FOREIGN KEY (Ctx_acp_clause_id) REFERENCES ctx_acp_clause (	ctx_acp_clause_id);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE Ctx_am_document_clause ADD CONSTRAINT FK_Ctx_am_document_clause_Ctx_am_document FOREIGN KEY (Doc_id) REFERENCES Ctx_am_document (Doc_id	);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql


// Insert data of Code Lookup for Contract Document Status
// Added 01.12.2007 By: Davis
SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Document Status';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Status', 'New', 'New Document', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Status', 'Pending', 'Pending', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Status', 'On Hold', 'On Hold', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Status', 'Under Review', 'Under Review', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Status', 'Approved', 'Approved', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Status', 'Declined', 'Declined', 'C');"
End If

// Added 01.23.2007 By: Jack
SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Document Status' AND code = 'ChangeRequest';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Status', 'ChangeRequest', 'ChangeRequest', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE code_lookup SET custom_1 = '1' WHERE lookup_name = 'Contract Document Status' AND code = 'Approved' AND custom_1 is null;"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE code_lookup SET custom_1 = '0' WHERE lookup_name = 'Contract Document Status' AND code <> 'Approved' AND custom_1 is null;"
End If

// Added 03.29.2007 By: Jack
SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Document Status' AND code = 'Executed';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, custom_1,type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Status', 'Executed', 'Executed Agreement', '0', 'C');"
End If

//Insert data of code lookup for work flow
//15.01.2007 By Jervis
//01.30.2007 By Jervis Modify
SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Action Type' and code = 'LegalApproval';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type', 'LegalApproval', 'LegalApproval', 'C');"
End If
SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Action Type' and code = 'MGRApproval';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type', 'MGRApproval', 'MGRApproval', 'C');"
End If
SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Action Type' and code = 'CustApproval';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type', 'CustApproval', 'CustApproval', 'C');"
End If
	
	

SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Action Status' and code = 'Pending';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Status', 'Pending', 'Pending', 'C');"
End If
SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Action Status' and code = 'Approved';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Status', 'Approved', 'Approved', 'C');"
End If
SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Action Status' and code = 'Reject';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Status', 'Reject', 'Reject', 'C');"
End If

	

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.02.2007 By: Jack (Document Manager)
//$<reason> 
is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE security_sub_module SET sub_module_name = 'Document Manager' WHERE sub_module_id = 370;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6901, 33, 370, 'Add Buy', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7401, 1, 6901, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6902, 33, 370, 'Add Sell', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7402, 1, 6902, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6903, 33, 370, 'Properties', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7403, 1, 6903, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6904, 33, 370, 'Report', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7404, 1, 6904, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6905, 33, 370, 'Email', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7405, 1, 6905, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6906, 33, 370, 'Output->Print', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7406, 1, 6906, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6907, 33, 370, 'Output->Email', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7407, 1, 6907, 2);"

//is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6908, 33, 370, 'Output->Create PDF', 2 );"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7408, 1, 6908, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6909, 33, 370, 'Output->Save to File', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7409, 1, 6909, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6910, 33, 370, 'Check In', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7410, 1, 6910, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6911, 33, 370, 'Check Out', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7411, 1, 6911, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6912, 33, 370, 'Save', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7412, 1, 6912, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6913, 33, 370, 'Add Clause', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7413, 1, 6913, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6914, 33, 370, 'Merge Field', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7414, 1, 6914, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6915, 33, 370, 'Merge Data', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7415, 1, 6915, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6916, 33, 370, 'Work Flow', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7416, 1, 6916, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6917, 33, 370, 'Clause Map', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7417, 1, 6917, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6918, 33, 370, 'Add Action Item', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7418, 1, 6918, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6919, 33, 370, 'Delete Action Item', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7419, 1, 6919, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6920, 33, 370, 'Print Letters', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7420, 1, 6920, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6921, 33, 370, 'Revision Control', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7408, 1, 6921, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6922, 33, 370, 'Delete Document', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7501, 1, 6922, 2);"
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.07.2007 By: Jervis
//$<reason> Add an Access entry of "Modify Other Users AI"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6925, 33, 370, 'Modify Other Users AI', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7800, 1, 6925, 2);"

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-25 By: Rodger Wu (add other)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify>2007-04-23 By: Alfee (add other) Fix a bug
//is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6926, 33, 370, 'Add Other', 1 );"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7900, 1, 6926, 1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6926, 33, 370, 'Add Other', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE rights_id = 7900 and role_id <> 1;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7900, 1, 6926, 2);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE security_rights_action SET dddw_type = 2 WHERE module_id = 33 and sub_module_id = 370 and action_id = 6926;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE security_roles_rights SET action_id = 6926, value_id = 2 WHERE rights_id = 7900;" 
//---------------------------- APPEON END ----------------------------
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.27.2007 By: Machongmin
//$<reason> Fix a defect.	
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE ids add doc_id int not null default 0;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE ids set doc_id = (SELECT max(doc_id) FROM ctx_am_document);"
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.23.2007 By: Alfee
//$<reason> Fix a defect.
Delete from ctx_am_document_clause where str(doc_id, 6) + str(revision,6,1) not in (select str(doc_id, 6) + str(revision,6,1) from ctx_am_doc_image);
If gs_dbtype = "ASA" Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_am_document_clause drop foreign key FK_Ctx_am_document_clause_Ctx_am_document;"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_am_document_clause add foreign key FK_Ctx_am_document_clause_Ctx_am_doc_image (Doc_id, Revision) references Ctx_am_doc_image (Doc_id, Revision) on update restrict on delete cascade;"
Else
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_am_document_clause drop constraint FK_Ctx_am_document_clause_Ctx_am_document;"  
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_am_document_clause add constraint FK_Ctx_am_document_clause_Ctx_am_doc_image foreign key (Doc_id, Revision) references Ctx_am_doc_image (Doc_id, Revision) ;"
End If	
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.14.2007 By: Jack
Select Max(rights_id) + 1 Into :ll_num From security_roles_rights;
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  values( 25,552,  'User ID Batch Update' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5511, 25, 552, 'View Rights', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values (" + string(ll_num) + ", 1, 5511, 2);"
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.20.2007 By: Jervis
//$<reason> Move to here from app_filter.open event
is_sql_statments[upperbound(is_sql_statments) + 1] = "Alter table icred_settings add set_51 int null;"
//---------------------------- APPEON END ----------------------------


of_execute_sqls()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.27.2007 By: Jack (Document Manager)
//$<reason> 

f_document_manager_sql()
//---------------------------- APPEON END ----------------------------

// Import data from support document, Added by Davis 01.30.2007
//This.of_import_from_support_doc( )
end subroutine

public function integer of_execute (string as_sql);string ls_sql

ls_sql = as_sql
//sle_1.text = ls_sql
execute immediate :ls_sql using sqlca;
commit using sqlca;

return 1
end function

public subroutine of_execute_sqls ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_i
string ls_null[]
boolean lb_ref_cache

IF UPPERBOUND(is_sql_statments) > 0 THEN  lb_ref_cache  = true

IF UPPERBOUND(is_sql_statments) > 0 THEN 
	   is_sql_statments[upperbound(is_sql_statments) + 1] = "commit;"

		if Not isvalid( w_infodisp ) then open(w_infodisp)

		if isvalid(w_infodisp) then w_infodisp.title = 'Creating Document Manager Module tables, Please stand by'
		if isvalid(w_infodisp) then w_infodisp.Center = TRUE
		if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Creating Document Manager Module Tabels, Please stand by for version 7.0: ' 
		if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(is_sql_statments))
		
		
		gnv_appeondb.of_startqueue( )
		
		FOR ll_i = 1 TO upperbound(is_sql_statments)
			if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Modification:' +string(ll_i) +' of '+ string(upperbound(is_sql_statments)) +' Please stand by!'
				 EXECUTE IMMEDIATE :is_sql_statments[LL_I] using sqlca;
				 IF len(sqlca.sqlerrtext) > 0 THEN
					// Added by Davis 11.14.2006
					IF handle(getapplication()) = 0 THEN
//						messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(is_sql_statments[LL_I]) + new_line + "Please contact software vendor."   )
					END IF
					// Added by Davis 11.14.2006

					else
				  commit;
					
				END IF
				if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		NEXT
		
		gnv_appeondb.of_commitqueue( )
		
		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Commiting modifications Please stand by!'
		
      if isvalid(w_infodisp) then close(w_infodisp)
	    
END IF


is_sql_statments = ls_null

return 
end subroutine

public function integer of_import_from_support_doc ();Long ll_doc_id
Long ll_image_id, ll_image_id_arry[]
Long ll_doc_category
String ls_file_name, ls_file_name_arry[], ls_doc_ext
Integer i
Long ll_audit_id
n_cst_dm_utils lnvo_dm_utils

DECLARE Emp_cur CURSOR FOR
        SELECT Distinct a.image_id, a.file_name
        FROM ctx_images a, ctx_image b
	Where a.image_id = b.image_id
	And Not Exists(Select 1 From ctx_am_document c 
		Where c.base_type = '3' And c.from_templete_id = a.image_id);
		  
OPEN Emp_cur;

FETCH Emp_cur Into :ll_image_id, :ls_file_name;
DO WHILE Sqlca.Sqlcode = 0
	i++
	ll_image_id_arry[i] = ll_image_id
	ls_file_name_arry[i] = ls_file_name

	FETCH Emp_cur Into :ll_image_id, :ls_file_name;
LOOP

CLOSE Emp_cur;

IF UpperBound(ll_image_id_arry) = 0 THEN RETURN 1

SELECT max(doc_id)
INTO :ll_doc_id
FROM ctx_am_document;
IF Isnull(ll_doc_id) THEN
	ll_doc_id = 1
END IF

SELECT max(audit_id)
INTO :ll_audit_id
FROM ctx_am_doc_audit;
IF Isnull(ll_audit_id) THEN
	ll_audit_id = 1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 02.14.2007 By: Jervis
//$<reason> 
//ll_doc_category = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Contract')"))
ll_doc_category = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Contract')"))
//---------------------------- APPEON END ----------------------------

IF Isnull(ll_doc_category) THEN ll_doc_category = 0

FOR i = 1 TO UpperBound(ll_image_id_arry)
	ll_doc_id++

	ls_file_name = ls_file_name_arry[i]
	ll_image_id = ll_image_id_arry[i]

	ls_doc_ext = lnvo_dm_utils.of_get_fileext( ls_file_name)
	
	Insert Into ctx_am_document(doc_id, ctx_id, doc_name, doc_ext, revision, doc_type, category, base_type, from_templete_id, create_by, create_date, notes, Revision_control)
	Select :ll_doc_id, a.ctx_id, a.file_name, :ls_doc_ext, b.image_version, "Buy", :ll_doc_category, '3', :ll_image_id, b.inserted_by_user, b.inserted_at_date_time, a.page_description, '1'
	From ctx_images a, ctx_image b
	Where a.image_id = b.image_id
		And a.image_id = :ll_image_id;
		
	Insert Into ctx_am_doc_image (Doc_id, Revision, image_file, modify_date, doc_ext)
	Select :ll_doc_id, b.image_version, b.image_file, getdate(), :ls_doc_ext
	From ctx_image b
	Where b.image_id = :ll_image_id;

	Insert Into ctx_am_doc_audit (Doc_id, audit_id, doc_ext, Revision, action, action_by, action_date, Notes)
	Select :ll_doc_id, :ll_audit_id, :ls_doc_ext, b.image_version, 'New - Existing', b.inserted_by_user, b.inserted_at_date_time, 'Imported from Support Document' 
	From ctx_image b
	Where b.image_id = :ll_image_id;

	Commit;
END FOR

RETURN 1
end function

on n_cst_dm_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dm_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

