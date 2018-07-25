$PBExportHeader$w_utl_app_id_update.srw
forward
global type w_utl_app_id_update from window
end type
type cb_3 from commandbutton within w_utl_app_id_update
end type
type st_3 from statictext within w_utl_app_id_update
end type
type st_2 from statictext within w_utl_app_id_update
end type
type st_1 from statictext within w_utl_app_id_update
end type
type cb_run from commandbutton within w_utl_app_id_update
end type
type dw_to from datawindow within w_utl_app_id_update
end type
type dw_from from datawindow within w_utl_app_id_update
end type
type gb_1 from groupbox within w_utl_app_id_update
end type
end forward

global type w_utl_app_id_update from window
integer x = 123
integer y = 112
integer width = 1454
integer height = 1260
boolean titlebar = true
string title = "Application ID Update"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_3 cb_3
st_3 st_3
st_2 st_2
st_1 st_1
cb_run cb_run
dw_to dw_to
dw_from dw_from
gb_1 gb_1
end type
global w_utl_app_id_update w_utl_app_id_update

type variables
long il_openfor
long il_new_id
long il_org_id
end variables

on w_utl_app_id_update.create
this.cb_3=create cb_3
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_run=create cb_run
this.dw_to=create dw_to
this.dw_from=create dw_from
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_run,&
this.dw_to,&
this.dw_from,&
this.gb_1}
end on

on w_utl_app_id_update.destroy
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_run)
destroy(this.dw_to)
destroy(this.dw_from)
destroy(this.gb_1)
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
	SQLCA.DbParm="ConnectString='DSN=Intellicred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"
	
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

	dw_from.settransobject(sqlca)
	dw_from.Retrieve()
	dw_from.insertrow(1)
	dw_to.settransobject(sqlca)
	dw_to.Retrieve()	
	dw_to.insertrow(1)
	
	
	st_3.text = "This utility will allow you to update Application/ Payor data in Multi App Templates, Application Action Items and Application Plan ID data.  All active data in these tables will be updated."
end event

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type cb_3 from commandbutton within w_utl_app_id_update
integer x = 955
integer y = 956
integer width = 261
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CLOSE(PARENT)
end event

type st_3 from statictext within w_utl_app_id_update
integer x = 37
integer y = 36
integer width = 1367
integer height = 284
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "this message set in the open event of the window"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_utl_app_id_update
integer x = 251
integer y = 636
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "To:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_utl_app_id_update
integer x = 251
integer y = 420
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "From:"
boolean focusrectangle = false
end type

type cb_run from commandbutton within w_utl_app_id_update
integer x = 677
integer y = 956
integer width = 261
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;integer res
res = messagebox("This operation:","This utility will update ALL Application/ Payor data in Multi App Templates, Application Action Items and Application IDs data.  ~rAre you sure you wish to Continue?",question!,yesno!,2)
if res = 2 then return

integer a
integer ac
integer p
integer pc
integer c
integer cc
integer nr
integer nc
integer li_fac
//long ll_org_id
//long ll_new_id
long ll_prac
Long ll_seq
integer comfind
datetime ldt_date

if il_new_id = 0 then 
	messagebox("missing Selection","There is no TO Application selected.  Please select.")
	return
end if
if il_org_id = 0 then 
	messagebox("missing Selection","There is no FROM Application selected.  Please select.")
	return
end if

update net_dev_action_items set app_id = :il_new_id  where app_id = :il_org_id;
update net_dev_ids set app_id = :il_new_id  where app_id = :il_org_id;
update sys_multi_app set app_id = :il_new_id  where app_id = :il_org_id;

commit using sqlca;


//messagebox("Done"," Update Completed")

end event

type dw_to from datawindow within w_utl_app_id_update
integer x = 251
integer y = 724
integer width = 910
integer height = 96
integer taborder = 20
string dataobject = "d_app_select_utl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_new_id = long(data)
end event

type dw_from from datawindow within w_utl_app_id_update
integer x = 251
integer y = 488
integer width = 910
integer height = 96
integer taborder = 10
string dataobject = "d_app_select_utl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_org_id = long(data)
end event

type gb_1 from groupbox within w_utl_app_id_update
integer x = 192
integer y = 340
integer width = 1033
integer height = 584
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Application/Payor"
end type

