$PBExportHeader$w_utl_get_views.srw
forward
global type w_utl_get_views from window
end type
type dw_2 from datawindow within w_utl_get_views
end type
type dw_1 from datawindow within w_utl_get_views
end type
type cb_3 from commandbutton within w_utl_get_views
end type
type cb_1 from commandbutton within w_utl_get_views
end type
end forward

global type w_utl_get_views from window
integer x = 27
integer y = 64
integer width = 3589
integer height = 2264
boolean titlebar = true
string title = "Reset group ids"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
dw_2 dw_2
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_utl_get_views w_utl_get_views

type variables
long il_openfor
end variables

on w_utl_get_views.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.dw_2,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_utl_get_views.destroy
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event open;long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows

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
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2005-11-11 By: owen chen
	//$<reason> add database option for sql excution
	
	string ls_sqlsyntax
	
	choose case gs_dbtype
		case 'ASA'
			ls_sqlsyntax = "  SELECT systable.table_id, "+&  
											"systable.creator, "+&  
											"systable.table_name, "+&  
											"systable.view_def, "+&  
											"systable.table_type, "+&  
											"sysobjects.id "+& 
									 "FROM systable, "+&  
											"sysobjects "+& 
									"WHERE ( systable.table_name = sysobjects.name ) and "+& 
											"( systable.table_name like 'v_%' ) AND "+& 
											"systable.creator = 1 AND "+& 
											"sysobjects.type = 'V' "
  
		case 'SQL'
			ls_sqlsyntax =  "  SELECT v_systable.table_id, "+&  
											"v_systable.creator, "+&  
											"v_systable.table_name, "+&  
											"v_systable.view_def, "+&  
											"v_systable.table_type, "+&  
											"sysobjects.id "+& 
									 "FROM v_systable, "+&  
											"sysobjects "+& 
									"WHERE ( v_systable.table_name = sysobjects.name ) and "+& 
											"( v_systable.table_name like 'v_%' ) AND "+& 
											"v_systable.creator = 1 AND "+& 
											"sysobjects.type = 'V' "
	end choose
	dw_1.Object.DataWindow.Table.Select = ls_sqlsyntax

	
	//---------------------------- APPEON END ----------------------------

	
	dw_1.Retrieve()
end event

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type dw_2 from datawindow within w_utl_get_views
integer x = 571
integer y = 1976
integer width = 1175
integer height = 156
integer taborder = 20
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_utl_get_views
integer x = 46
integer y = 40
integer width = 3465
integer height = 1920
integer taborder = 40
string dataobject = "d_view_update_list_all"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_3 from commandbutton within w_utl_get_views
integer x = 3223
integer y = 1988
integer width = 274
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_utl_get_views
integer x = 73
integer y = 1988
integer width = 265
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Select a record type. Click run.  You will get a list of expiring records from 30 days in the future for active records.")
end event

