$PBExportHeader$w_caqh_import_utl.srw
forward
global type w_caqh_import_utl from window
end type
type uo_1 from uo_caqh_import within w_caqh_import_utl
end type
end forward

global type w_caqh_import_utl from window
integer x = 123
integer y = 112
integer width = 3726
integer height = 2236
boolean titlebar = true
string title = "CAQH Data Utility"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 33551856
boolean center = true
uo_1 uo_1
end type
global w_caqh_import_utl w_caqh_import_utl

type variables
long il_openfor
string is_path
string is_error
string is_type
end variables

forward prototypes
public function integer of_set_dws (integer ai_item)
end prototypes

public function integer of_set_dws (integer ai_item);

return 1
end function

on w_caqh_import_utl.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_caqh_import_utl.destroy
destroy(this.uo_1)
end on

event open;long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows
integer res


if message.stringparm = "P" then  //from the intellicred program
	//skip login
	il_openfor = 0
else
	
	SQLCA.DBMS="ODBC"
	SQLCA.DbParm="ConnectString='DSN=Iapp;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"
	
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
		MessageBox("Not Logged In", "Login Failed!")
	ELSE
		//MESSAGEBOX("","LOGIN OK")
	END IF
	il_openfor = 1
	
end if

is_path = gs_dir_path + "intellicred\"

uo_1.of_open()



end event

event close;if il_openfor = 1 then
	DISCONNECT USING SQLCA;
end if
end event

type uo_1 from uo_caqh_import within w_caqh_import_utl
integer y = 12
integer height = 2116
integer taborder = 50
end type

on uo_1.destroy
call uo_caqh_import::destroy
end on

