$PBExportHeader$w_update_app_ids.srw
forward
global type w_update_app_ids from window
end type
type st_1 from statictext within w_update_app_ids
end type
type cb_1 from commandbutton within w_update_app_ids
end type
end forward

global type w_update_app_ids from window
integer x = 1056
integer y = 484
integer width = 905
integer height = 672
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
global w_update_app_ids w_update_app_ids

type prototypes

end prototypes

on w_update_app_ids.create
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.cb_1}
end on

on w_update_app_ids.destroy
destroy(this.st_1)
destroy(this.cb_1)
end on

type st_1 from statictext within w_update_app_ids
integer x = 165
integer y = 416
integer width = 462
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
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_update_app_ids
integer x = 165
integer y = 144
integer width = 421
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update Ids"
end type

event clicked;SQLCA.DBMS="ODBC"
SQLCA.DBParm = "ConnectString='DSN=IntelliCred Client;UID=dba;PWD=sql',DelimitIdentifier='Yes'"

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
	MessageBox("Login", "Inital Login Failed!  Check your ODBC configuration")
	Return -1
END IF

debugbreak()

String ls_from
String ls_to
String ls_app_path
Long li_app_id
Long li_next_app_id = 10000
Integer i

FOR i = 1 TO 1000
	
	st_1.Text = String( i ) + " of 10,000" 
	
	li_next_app_id ++
	IF FileExists( "S:\IntelliApp Perm\Applications\" + String( i ) + ".tif" ) THEN

		ls_from =  "S:\IntelliApp Perm\Applications\" + String( i ) + ".tif"

		ls_to =   "S:\IntelliApp Perm\Applications\" + String( li_next_app_id ) + ".tif"
				
		CopyFileA( ls_from , ls_to , True )
		
		UPDATE app_hdr
		SET app_id = :li_next_app_id
		WHERE app_id = :i;
		if sqlca.sqlcode = -1 then
			messagebox("", sqlca.sqlerrtext)
		end if
		
		//commit using sqlca;
		
		UPDATE app_field_prop
		SET app_id = :li_next_app_id
		WHERE app_id = :i;
		if sqlca.sqlcode = -1 then
			messagebox("", sqlca.sqlerrtext)
		end if

		commit using sqlca;

	END IF
END FOR

commit using sqlca;



end event

