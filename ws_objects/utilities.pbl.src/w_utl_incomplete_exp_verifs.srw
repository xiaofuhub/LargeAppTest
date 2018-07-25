$PBExportHeader$w_utl_incomplete_exp_verifs.srw
forward
global type w_utl_incomplete_exp_verifs from window
end type
type dw_1 from u_dw within w_utl_incomplete_exp_verifs
end type
type cb_run from commandbutton within w_utl_incomplete_exp_verifs
end type
type cb_4 from commandbutton within w_utl_incomplete_exp_verifs
end type
type cb_3 from commandbutton within w_utl_incomplete_exp_verifs
end type
end forward

global type w_utl_incomplete_exp_verifs from window
integer x = 14
integer y = 112
integer width = 3602
integer height = 2248
boolean titlebar = true
string title = "Expired Verifications Not Completed"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
dw_1 dw_1
cb_run cb_run
cb_4 cb_4
cb_3 cb_3
end type
global w_utl_incomplete_exp_verifs w_utl_incomplete_exp_verifs

type variables
long il_openfor
end variables

on w_utl_incomplete_exp_verifs.create
this.dw_1=create dw_1
this.cb_run=create cb_run
this.cb_4=create cb_4
this.cb_3=create cb_3
this.Control[]={this.dw_1,&
this.cb_run,&
this.cb_4,&
this.cb_3}
end on

on w_utl_incomplete_exp_verifs.destroy
destroy(this.dw_1)
destroy(this.cb_run)
destroy(this.cb_4)
destroy(this.cb_3)
end on

event open;long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows
datawindowchild dwchild

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

	dw_1.settransobject(sqlca)
//	dw_1.iuo_calendar.of_Register(dw_1.iuo_calendar.DDLB)
	dw_1.GetChild( "response_code", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve("Credentials Verification Response")
	dwchild.InsertRow( 1 )

	dw_1.Retrieve()
	
	
end event

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type dw_1 from u_dw within w_utl_incomplete_exp_verifs
integer x = 46
integer y = 156
integer width = 3465
integer height = 1888
integer taborder = 40
string dataobject = "d_utl_verif_exp_not_done"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "response_code" THEN
	This.SetItem( row, "user_name", gs_user_id )
	This.SetItem( row, "source", "P" )
	This.SetItem( row, "date_recieved", Today() )
	This.SetItem( row, "print_flag", 0 )
//	if this.getitemstring(row, "reference_value") <> 'Expiring Appointment Letter' then//maha 100400 to keep recieved letters from being recredentialed
	This.SetItem( row, "verif_info_exp_credential_flag", 0 )
//	end if
END IF
end event

type cb_run from commandbutton within w_utl_incomplete_exp_verifs
integer x = 2656
integer y = 36
integer width = 274
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Save"
end type

event clicked;

dw_1.update()
commit using sqlca;
end event

type cb_4 from commandbutton within w_utl_incomplete_exp_verifs
integer x = 2949
integer y = 36
integer width = 274
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Print"
end type

event clicked;//if dw_1.rowcount() < 1 then
//	messagebox("","nothing to print")
//	return
//end if
//
dw_1.print()
end event

type cb_3 from commandbutton within w_utl_incomplete_exp_verifs
integer x = 3237
integer y = 36
integer width = 274
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Close"
end type

event clicked;CLOSE(PARENT)
end event

