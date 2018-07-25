$PBExportHeader$w_utl_update_views.srw
forward
global type w_utl_update_views from window
end type
type cb_2 from commandbutton within w_utl_update_views
end type
type dw_2 from datawindow within w_utl_update_views
end type
type cb_run from commandbutton within w_utl_update_views
end type
type dw_1 from datawindow within w_utl_update_views
end type
type cb_4 from commandbutton within w_utl_update_views
end type
type cb_3 from commandbutton within w_utl_update_views
end type
type cb_1 from commandbutton within w_utl_update_views
end type
end forward

global type w_utl_update_views from window
integer x = 27
integer y = 64
integer width = 3616
integer height = 2428
boolean titlebar = true
string title = "View Update"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_2 cb_2
dw_2 dw_2
cb_run cb_run
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
end type
global w_utl_update_views w_utl_update_views

type variables
long il_openfor
end variables

on w_utl_update_views.create
this.cb_2=create cb_2
this.dw_2=create dw_2
this.cb_run=create cb_run
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.dw_2,&
this.cb_run,&
this.dw_1,&
this.cb_4,&
this.cb_3,&
this.cb_1}
end on

on w_utl_update_views.destroy
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.cb_run)
destroy(this.dw_1)
destroy(this.cb_4)
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
	dw_1.Retrieve()
end event

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type cb_2 from commandbutton within w_utl_update_views
integer x = 1563
integer y = 28
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Views"
end type

event clicked;openwithparm(w_utl_get_views,"P")
end event

type dw_2 from datawindow within w_utl_update_views
boolean visible = false
integer x = 571
integer y = 1976
integer width = 1175
integer height = 156
integer taborder = 40
string dataobject = "d_view_update_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_run from commandbutton within w_utl_update_views
integer x = 1833
integer y = 28
integer width = 800
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update Selected Views"
end type

event clicked;debugbreak()
integer a
integer ac
integer p
integer pc
integer c
integer cc
integer nr
integer nc
integer li_type
long ll_commid
long ll_newid
long ll_id
Long ll_seq
integer lic
datetime ldt_date
string ls_view
string ls_sql

dw_2.settransobject(sqlca)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-11 By: owen chen
//$<reason> add database option for sql excution

string ls_sqlsyntax

choose case gs_dbtype
	case 'ASA'
		ls_sqlsyntax =  "  SELECT systable.table_id, "+&
									"systable.creator, "+&  
									"systable.table_name, "+&  
									"systable.view_def, "+&  
									"systable.table_type, "+&  
									"sysobjects.id "+& 
									"FROM systable, "+&  
										 "  sysobjects "+& 
									"WHERE ( systable.table_name = sysobjects.name ) and "+& 
									 "     ( ( systable.table_name = :vname ) AND "+& 
									  "    ( systable.creator = 1 ) AND "+& 
							 		 "( sysobjects.type = 'V' ) ) " 
	case 'SQL'
		ls_sqlsyntax =   "  SELECT v_systable.table_id, "+&
									"v_systable.creator, "+&  
									"v_systable.table_name, "+&  
									"v_systable.view_def, "+&  
									"v_systable.table_type, "+&  
									"sysobjects.id "+& 
								"FROM v_systable, "+&  
      						 "  sysobjects "+& 
								"WHERE ( v_systable.table_name = sysobjects.name ) and "+& 
								 "     ( ( v_systable.table_name = :vname ) AND "+& 
								  "    ( v_systable.creator = 1 ) AND "+& 
								  "( sysobjects.type = 'V' ) ) "  
end choose
dw_2.Object.DataWindow.Table.Select = ls_sqlsyntax

//---------------------------- APPEON END ----------------------------



ac = dw_1.rowcount()//a list of all active appointments
//
for a = 1 to ac
	if dw_1.getitemnumber(a,"selected") = 1 then
		ls_view = dw_1.getitemstring(a,"view_name")
		ls_sql = dw_1.getitemstring(a,"view_sql")
		cc = dw_2.retrieve(ls_view)
		if cc > 1 then
			messagebox("Multiple rows for: ",ls_view + "; skipping")
			continue
		//elseif cc < 1 then
			//messagebox("No rows for: ",ls_view + "; skipping")
			//continue
		elseif cc = 1 then
		ll_id = dw_2.getitemnumber(1,"sysobjects_id")
		end if
		if PosA(upper(ls_sql),"CREATE",1) < 5 then
			ls_sql = "drop view " + ls_view + ";"
			execute immediate :ls_sql using sqlca;
			commit using sqlca;
			ls_sql = dw_1.getitemstring(a,"view_sql")
			//messagebox("ls_sql",ls_sql)
		end if
			
		execute immediate :ls_sql using sqlca;
		commit using sqlca;
		
		cc = dw_2.retrieve(ls_view)
		
		if cc <> 1 then
			messagebox("", "Unable to create view " + ls_view + " ; Old id was (better write it down) " + string(ll_id))
			continue
		end if
		ll_newid = dw_2.getitemnumber(1,"sysobjects_id")
		//messagebox(string(ll_id),string(ll_newid))
		
		update conv_view_tables set cust_table_name = :ll_newid where cust_table_name = :ll_id;
		commit using sqlca;
			
	end if
		

next

messagebox("Done"," Update Completed")

end event

type dw_1 from datawindow within w_utl_update_views
integer x = 46
integer y = 144
integer width = 3465
integer height = 1920
integer taborder = 60
string dataobject = "d_view_list_update"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_4 from commandbutton within w_utl_update_views
integer x = 2651
integer y = 28
integer width = 274
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;//if dw_1.rowcount() < 1 then
//	messagebox("","nothing to print")
//	return
//end if
//
dw_1.update()
commit using sqlca;
end event

type cb_3 from commandbutton within w_utl_update_views
integer x = 3237
integer y = 28
integer width = 274
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_utl_update_views
integer x = 2953
integer y = 28
integer width = 265
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Select a record type. Click run.  You will get a list of expiring records from 30 days in the future for active records.")
end event

