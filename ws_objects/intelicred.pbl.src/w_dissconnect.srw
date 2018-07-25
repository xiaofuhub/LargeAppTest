$PBExportHeader$w_dissconnect.srw
forward
global type w_dissconnect from window
end type
type st_idle from statictext within w_dissconnect
end type
type st_4 from statictext within w_dissconnect
end type
type st_3 from statictext within w_dissconnect
end type
type st_2 from statictext within w_dissconnect
end type
type cb_3 from commandbutton within w_dissconnect
end type
type cb_2 from commandbutton within w_dissconnect
end type
type cb_1 from commandbutton within w_dissconnect
end type
type st_1 from statictext within w_dissconnect
end type
end forward

global type w_dissconnect from window
integer width = 2025
integer height = 596
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_idle st_idle
st_4 st_4
st_3 st_3
st_2 st_2
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_dissconnect w_dissconnect

on w_dissconnect.create
this.st_idle=create st_idle
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.st_idle,&
this.st_4,&
this.st_3,&
this.st_2,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_dissconnect.destroy
destroy(this.st_idle)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;st_idle.text = string(gnv_app.il_itle_time/60) + " minutes."
end event

type st_idle from statictext within w_dissconnect
integer x = 64
integer y = 608
integer width = 517
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_4 from statictext within w_dissconnect
integer x = 9
integer y = 988
integer width = 2272
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = " You may be unable to save work in the window that you are working"
boolean focusrectangle = false
end type

type st_3 from statictext within w_dissconnect
integer x = 32
integer y = 912
integer width = 2766
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Click reconnect to attempt to reconnect to the database.  "
boolean focusrectangle = false
end type

type st_2 from statictext within w_dissconnect
integer x = 329
integer y = 236
integer width = 1376
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Click Close to terminate the program, then restart."
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_dissconnect
integer x = 987
integer y = 1196
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

type cb_2 from commandbutton within w_dissconnect
integer x = 823
integer y = 404
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
Halt
end event

type cb_1 from commandbutton within w_dissconnect
integer x = 1353
integer y = 1168
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reconnect"
end type

event clicked;disconnect using sqlca;

SQLCA.DBMS       = "ODBC"
SQLCA.Lock       = "RU" // for sql server READ UNCOMMITED - PREVENT LOCKING
SQLCA.AutoCommit = true
SQLCA.DBParm     = "ConnectString='DSN=" + gs_odbc + ";UID=dba;PWD=sql';StaticBind=0,DisableBind=1,PBUseProcOwner='Yes',RPCReBind=1,MsgTerse='Yes', " + & 
																	"DelimitIdentifier='Yes',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT ',"+ & 
																	"PBTrimCharColumns='Yes',PBMaxBlobSize = '2147483647' ,PBMaxTextSize = '2147483647'" 
																	
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-14 By: Scofield
//$<Reason> Set the connection cache dynamically on Web
if AppeonGetClientType() = 'WEB' then
	SQLCA.DBMS = gs_CacheType
	SQLCA.DBParm = gs_CacheSet
end if
//---------------------------- APPEON END ----------------------------

connect using sqlca;
																	

IF SQLCA.SQLCODE = 0  THEN 
	CHOOSE CASE SQLCA.SQLreturndata
		CASE 'Adaptive Server Anywhere'
			  gs_dbType = 'ASA'
		CASE 'Microsoft SQL Server'
			  gs_dbType = 'SQL'
	   END CHOOSE 
		messagebox("Reconnect Attempt","Successful")
ELSE
	// msskiner 10 March 2006 -- begin
	// if the database is not runnning - don't tell up about it
	if sqlca.sqldbcode = -100 then 
	   messageBOX('Unable to connect','The database server is not running. Check your ODBC configuration or Contact your system administrator.' )		
	else 
	    f_system_error_handler ('Inital Login Failed!  ' +    SQLCA.sqlerrtext)
   end if
	// msskiner 10 March 2006 -- end 
	//SQLCA.sqldbcode
	Return - 1
END IF

close (parent)
end event

type st_1 from statictext within w_dissconnect
integer x = 347
integer y = 108
integer width = 1289
integer height = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "You have lost your connection to the datebase. "
boolean focusrectangle = false
end type

