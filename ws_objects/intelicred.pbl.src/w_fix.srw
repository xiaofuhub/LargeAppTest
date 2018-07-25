$PBExportHeader$w_fix.srw
forward
global type w_fix from window
end type
type st_1 from statictext within w_fix
end type
type cb_1 from commandbutton within w_fix
end type
end forward

global type w_fix from window
integer x = 1056
integer y = 484
integer width = 2569
integer height = 1516
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
st_1 st_1
cb_1 cb_1
end type
global w_fix w_fix

on w_fix.create
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.cb_1}
end on

on w_fix.destroy
destroy(this.st_1)
destroy(this.cb_1)
end on

type st_1 from statictext within w_fix
integer x = 151
integer y = 1116
integer width = 2121
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean border = true
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fix
integer x = 827
integer y = 308
integer width = 658
integer height = 476
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-12-05 By: Cao YongWang
//$<reason> 
//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=HS Data;UID=dba;PWD=sql;',DelimitIdentifier='No'"
//SQLCA.AutoCommit = TRUE
Choose Case gs_dbType
	Case 'ASA'
		SQLCA.DBMS="ODBC"
		SQLCA.DbParm="ConnectString='DSN=HS Data;UID=dba;PWD=sql;',DelimitIdentifier='Yes'"
		SQLCA.AutoCommit = TRUE
	Case 'SQL'
		SQLCA.DBMS="ODBC"
		SQLCA.DbParm="ConnectString='DSN=HS Data;UID=sa;PWD=;',DelimitIdentifier='Yes'"
		SQLCA.AutoCommit = TRUE		
End Choose
//---------------------------- APPEON END ----------------------------

gs_user_ID = "MASTER"
gs_password = SUPER_MASTER_PASSWORD				//Modified by Scofield on 2008-11-12

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-14 By: Scofield
//$<Reason> Set the connection cache dynamically on Web
if AppeonGetClientType() = 'WEB' then
	SQLCA.DBMS = gs_CacheType
	SQLCA.DBParm = gs_CacheSet
end if
//---------------------------- APPEON END ----------------------------

CONNECT USING SQLCA;

Integer li_screen_id
Integer li_cnt
Long ll_rec_id
Long ll_id
 
UPDATE ver_info
SET exp_credential_flag = 0;
 
UPDATE ver_info
SET verification_method = 15;

DECLARE vers CURSOR FOR  
SELECT verif_info.rec_id,   
       verif_info.screen_id  
FROM verif_info  ;
 
OPEN vers;
 
FETCH vers INTO :ll_rec_id, :li_screen_id;

DO WHILE SQLCA.SQLCODE = 0 
	 
	 li_cnt++
	 st_1.Text = String( li_cnt )
	 CHOOSE CASE li_screen_id

		//EDUCATION	
		CASE 6
			SELECT school_code 
			INTO :ll_id
			FROM pd_education 
			WHERE rec_id = :ll_rec_id;
		//LICENSE
		CASE 4
			SELECT verifying_agency
			INTO :ll_id
			FROM pd_license
			WHERE rec_id = :ll_rec_id;		
		//INSURANCE	
		CASE 15
			SELECT carrier_code 
			INTO :ll_id
			FROM pd_insurance
			WHERE rec_id = :ll_rec_id;
		//HOSP
		CASE 10
			SELECT hospital_code 
			INTO :ll_id
			FROM pd_hosp_affil
			WHERE rec_id = :ll_rec_id;
		//train
		CASE 7
			SELECT institution_code
			INTO :ll_id
			FROM pd_training
			WHERE rec_id = :ll_rec_id;		
	END CHOOSE

	UPDATE ver_info
	SET address_lookup_code = :ll_id
	WHERE rec_id = :ll_rec_id;

	FETCH vers INTO :ll_rec_id, :li_screen_id;
LOOP

COMMIT USING SQLCA;
end event

