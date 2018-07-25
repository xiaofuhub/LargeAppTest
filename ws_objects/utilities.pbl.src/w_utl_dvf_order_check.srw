$PBExportHeader$w_utl_dvf_order_check.srw
forward
global type w_utl_dvf_order_check from window
end type
type cb_run from commandbutton within w_utl_dvf_order_check
end type
type dw_2 from datawindow within w_utl_dvf_order_check
end type
type dw_1 from datawindow within w_utl_dvf_order_check
end type
type cb_4 from commandbutton within w_utl_dvf_order_check
end type
type cb_3 from commandbutton within w_utl_dvf_order_check
end type
type cb_1 from commandbutton within w_utl_dvf_order_check
end type
end forward

global type w_utl_dvf_order_check from window
integer x = 850
integer y = 720
integer width = 1019
integer height = 364
boolean titlebar = true
string title = "Check field order values"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
event ue_run ( )
cb_run cb_run
dw_2 dw_2
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
end type
global w_utl_dvf_order_check w_utl_dvf_order_check

type variables
integer il_openfor
// mskinner 23 Feb 2006 --- begin
boolean il_show_message = true
// mskinner 23 Feb 2006 --- endd 
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.14.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Define a datastore for caching data. 
datastore	ids_fields
//---------------------------- APPEON END ----------------------------

end variables

event ue_run();/******************************************************************************************************************
**  [PUBLIC]   : ue_run
**==================================================================================================================
**  Purpose   	: Run the cb licked event, call from outside object
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 23 Feb 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

il_show_message = false
cb_run.triggerevent( clicked!)
close(this)
end event

on w_utl_dvf_order_check.create
this.cb_run=create cb_run
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_run,&
this.dw_2,&
this.dw_1,&
this.cb_4,&
this.cb_3,&
this.cb_1}
end on

on w_utl_dvf_order_check.destroy
destroy(this.cb_run)
destroy(this.dw_2)
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
	this.Hide() // Add by Evan 05.14.2009 --- Corrected BugG031004
else
	
	SQLCA.DBMS="ODBC"
	SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"
	
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

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.14.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> 1)Use datastore to cache data. The data will be used by script in PT-03.
//$<modification> 2)Add Appeon Queue labels to reduce client-server interactions.
ids_fields = create datastore
ids_fields.dataobject = 'd_utl_dv_fields_all_pt'
ids_fields.settransobject(SQLCA)
gnv_appeondb.of_startqueue()
ids_fields.retrieve()
//---------------------------- APPEON END ----------------------------

dw_1.settransobject(sqlca)
dw_1.retrieve()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 03.14.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> 1)Add Appeon Queue labels to reduce client-server interactions.
//$<modification> 2)Write script to retrieve data from a cache in PT-02 instead of from the database.
gnv_appeondb.of_commitqueue()
ids_fields.RowsCopy(1,ids_fields.Rowcount(),Primary!,dw_2,1,primary!)
//---------------------------- APPEON END ----------------------------

end event

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type cb_run from commandbutton within w_utl_dvf_order_check
integer x = 142
integer y = 72
integer width = 416
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run"
end type

event clicked;//integer res
//res = messagebox("This operation:","This utility will add missing facility committees to current appointments.  Used when committees have been added to a facility after the appointments were created.  ~rContinue?",question!,yesno!,2)
//if res = 2 then return

integer a
integer ac
integer p
integer pc
integer f
integer fc
integer nr
integer nc = 0
integer li_fac
long ll_commid
long ll_screen
long ll_ord
integer li_prior
integer comfind
datetime ldt_date
long ll_total_dups

ac = dw_1.rowcount()
// MSKINNER 23 fEB 2006 -- BEGIN
// RUN THIS ULTILITY UNTIL  NO DUPS ARE FOUND
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 03.14.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
DO
 
for a = 1 to ac 
	nc = 0
	ll_screen = dw_1.getitemnumber(a,"screen_id")
	dw_2.settransobject(sqlca)
	fc = dw_2.retrieve(ll_screen)
	
	for f = 1 to fc
		ll_ord = dw_2.getitemnumber(f,"field_order")
		if f > 1 then
			if ll_ord = dw_2.getitemnumber(f - 1,"field_order") then
				ll_ord++
				dw_2.setitem(f,"field_order",ll_ord)
				nc++
				dw_2.accepttext()
			end if
		end if
	next
	dw_2.update()
	commit using sqlca;
  ll_total_dups = ll_total_dups + nc
next
			
LOOP WHILE nc <> 0
*/
ids_fields.setsort("screen_id asc, field_order asc")
ids_fields.sort()
long	ll_fc , ll_findrow
DO
	For a = 1 to ac 
		nc = 0
		ll_screen = dw_1.getitemnumber(a,"screen_id")
		dw_2.setfilter("screen_id=" + string(ll_screen))
		fc = dw_2.filter()
		dw_2.setsort("field_order asc")
		dw_2.sort()
		ll_fc = dw_2.RowCount()
		ll_findrow = ids_fields.Find("screen_id=" + string(ll_screen),1,ids_fields.RowCount())
		for f = ll_findrow to ll_findrow + ll_fc - 1
			ll_ord = ids_fields.getitemnumber(f,"field_order")
			if f > ll_findrow then
				if ll_ord = ids_fields.getitemnumber(f - 1,"field_order") then
					ll_ord++
					ids_fields.setitem(f,"field_order",ll_ord)
					nc++
					
				end if
			end if
		next
	  ll_total_dups = ll_total_dups + nc
	Next
LOOP WHILE nc <> 0
If ids_fields.modifiedcount( ) > 0 Then
	gnv_appeondb.of_autocommit()
	ids_fields.update()
	commit using sqlca;
End If
//---------------------------- APPEON END ----------------------------

if il_show_message then 
    messagebox("Done",string (ll_total_dups) + " duplicates found and corrected.")
end if 

// MSKINNER 23 fEB 2006 -- END






end event

type dw_2 from datawindow within w_utl_dvf_order_check
integer x = 352
integer y = 332
integer width = 110
integer height = 76
integer taborder = 10
string dataobject = "d_utl_dv_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_utl_dvf_order_check
integer x = 187
integer y = 356
integer width = 87
integer height = 72
integer taborder = 60
string dataobject = "d_utl_dv_screen"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_utl_dvf_order_check
integer x = 2199
integer y = 108
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;//if dw_1.rowcount() < 1 then
//	messagebox("","nothing to print")
//	return
//end if
//
//dw_1.print()
end event

type cb_3 from commandbutton within w_utl_dvf_order_check
integer x = 681
integer y = 24
integer width = 274
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_utl_dvf_order_check
integer x = 690
integer y = 136
integer width = 265
integer height = 72
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;Messagebox("To operate this program :","Click run.  This utility will check for and correct duplicated field orders on the default data view which could cause app populating problems.")

end event

