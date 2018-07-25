$PBExportHeader$w_import_app_audit.srw
forward
global type w_import_app_audit from window
end type
type cb_1 from commandbutton within w_import_app_audit
end type
end forward

global type w_import_app_audit from window
integer x = 823
integer y = 360
integer width = 2473
integer height = 1640
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_1 cb_1
end type
global w_import_app_audit w_import_app_audit

on w_import_app_audit.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_import_app_audit.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_import_app_audit
integer x = 398
integer y = 220
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;long ll_prac_id
Integer i
long ll_rec_id

SQLCA.DBMS="ODBC"
SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-14 By: Scofield
//$<Reason> Set the connection cache dynamically on Web
if AppeonGetClientType() = 'WEB' then
	SQLCA.DBMS = gs_CacheType
	SQLCA.DBParm = gs_CacheSet
end if
//---------------------------- APPEON END ----------------------------

CONNECT USING SQLCA;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Login", "Login Failed!")
END IF

DECLARE PRAC_IDS CURSOR FOR  
SELECT DISTINCT pd_basic.prac_id  
FROM pd_basic  ;
 
OPEN prac_ids;

FETCH PRAC_IDS INTO :ll_prac_id;

DO WHILE SQLCA.SQLCODE = 0
	FOR i = 2 TO 12
	  ll_rec_id++
	    INSERT INTO pd_app_audit  
         ( record_id,   
           prac_id,   
           facility_id,   
           seq_no,   
           app_audit_id,   
           completed,   
           fax_message,   
           active_status,   
           date_completed,   
           data_status,   
           notes,   
           identifying_number,   
           appt_stat_id )  
  VALUES ( :LL_REC_ID,   
           :LL_PRAC_ID,   
           1,   
           1,   
           :I,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )  ;

		
	END FOR
	FETCH PRAC_IDS INTO :ll_prac_id;
LOOP

COMMIT USING SQLCA;
end event

