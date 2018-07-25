$PBExportHeader$w_user_update_new.srw
forward
global type w_user_update_new from window
end type
type st_app from statictext within w_user_update_new
end type
type st_ver from statictext within w_user_update_new
end type
type cbx_v from checkbox within w_user_update_new
end type
type cbx_a from checkbox within w_user_update_new
end type
type cbx_prac from checkbox within w_user_update_new
end type
type st_4 from statictext within w_user_update_new
end type
type cb_prac from commandbutton within w_user_update_new
end type
type dw_dept from datawindow within w_user_update_new
end type
type dw_facility from datawindow within w_user_update_new
end type
type st_2 from statictext within w_user_update_new
end type
type dw_vercred from datawindow within w_user_update_new
end type
type dw_affil from datawindow within w_user_update_new
end type
type dw_to from datawindow within w_user_update_new
end type
type dw_from from datawindow within w_user_update_new
end type
type cb_close from commandbutton within w_user_update_new
end type
type cb_1 from commandbutton within w_user_update_new
end type
type gb_3 from groupbox within w_user_update_new
end type
type gb_5 from groupbox within w_user_update_new
end type
type gb_4 from groupbox within w_user_update_new
end type
type gb_1 from groupbox within w_user_update_new
end type
type cb_run from commandbutton within w_user_update_new
end type
type st_3 from statictext within w_user_update_new
end type
end forward

global type w_user_update_new from window
integer x = 965
integer y = 256
integer width = 1897
integer height = 956
boolean titlebar = true
string title = "Change User Assignment"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
st_app st_app
st_ver st_ver
cbx_v cbx_v
cbx_a cbx_a
cbx_prac cbx_prac
st_4 st_4
cb_prac cb_prac
dw_dept dw_dept
dw_facility dw_facility
st_2 st_2
dw_vercred dw_vercred
dw_affil dw_affil
dw_to dw_to
dw_from dw_from
cb_close cb_close
cb_1 cb_1
gb_3 gb_3
gb_5 gb_5
gb_4 gb_4
gb_1 gb_1
cb_run cb_run
st_3 st_3
end type
global w_user_update_new w_user_update_new

type variables
string is_from
string is_to
integer ii_facil
long il_dept = 0
string is_pracs
end variables

on w_user_update_new.create
this.st_app=create st_app
this.st_ver=create st_ver
this.cbx_v=create cbx_v
this.cbx_a=create cbx_a
this.cbx_prac=create cbx_prac
this.st_4=create st_4
this.cb_prac=create cb_prac
this.dw_dept=create dw_dept
this.dw_facility=create dw_facility
this.st_2=create st_2
this.dw_vercred=create dw_vercred
this.dw_affil=create dw_affil
this.dw_to=create dw_to
this.dw_from=create dw_from
this.cb_close=create cb_close
this.cb_1=create cb_1
this.gb_3=create gb_3
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_1=create gb_1
this.cb_run=create cb_run
this.st_3=create st_3
this.Control[]={this.st_app,&
this.st_ver,&
this.cbx_v,&
this.cbx_a,&
this.cbx_prac,&
this.st_4,&
this.cb_prac,&
this.dw_dept,&
this.dw_facility,&
this.st_2,&
this.dw_vercred,&
this.dw_affil,&
this.dw_to,&
this.dw_from,&
this.cb_close,&
this.cb_1,&
this.gb_3,&
this.gb_5,&
this.gb_4,&
this.gb_1,&
this.cb_run,&
this.st_3}
end on

on w_user_update_new.destroy
destroy(this.st_app)
destroy(this.st_ver)
destroy(this.cbx_v)
destroy(this.cbx_a)
destroy(this.cbx_prac)
destroy(this.st_4)
destroy(this.cb_prac)
destroy(this.dw_dept)
destroy(this.dw_facility)
destroy(this.st_2)
destroy(this.dw_vercred)
destroy(this.dw_affil)
destroy(this.dw_to)
destroy(this.dw_from)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.cb_run)
destroy(this.st_3)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	//MESSAGEBOX("","LOGIN OK")
//END if

DataWindowChild dwchild

dw_affil.settransobject(sqlca)
dw_vercred.settransobject(sqlca)
dw_from.settransobject(sqlca)
dw_from.retrieve()
dw_from.insertrow(1)
dw_from.GetChild( "user_id", dwchild )
dwchild.insertrow(1)
dwchild.setitem(1,"user_id","Public")
dwchild.insertrow(1)
dw_to.settransobject(sqlca)
dw_to.retrieve()
dw_to.insertrow(1)
dw_to.GetChild( "user_id", dwchild )
dwchild.insertrow(1)
dwchild.setitem(1,"user_id","Public")
dwchild.insertrow(1)
dw_facility.settransobject(sqlca)
dw_facility.retrieve()
dw_facility.insertrow(1)
dw_dept.settransobject(sqlca)
dw_dept.retrieve()
dw_dept.insertrow(1)
dw_dept.GetChild( "lookup_code", dwchild )
dwchild.insertrow(1)

//
//
//dw_facility.GetChild( "facility_id", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve()
//dwchild.insertrow(1)
//dwchild.setitem(1,"facility_name","All")
//dwchild.setitem(1,"facility_id",-1)


end event

event close;//disCONNECT USING SQLCA;
end event

type st_app from statictext within w_user_update_new
integer x = 137
integer y = 704
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "0"
boolean focusrectangle = false
end type

type st_ver from statictext within w_user_update_new
integer x = 640
integer y = 704
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "0"
boolean focusrectangle = false
end type

type cbx_v from checkbox within w_user_update_new
integer x = 635
integer y = 624
integer width = 407
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Verifications"
boolean checked = true
end type

event clicked;if this.checked or cbx_a.checked then
	cb_run.enabled = true
else
	cb_run.enabled = false
end if
end event

type cbx_a from checkbox within w_user_update_new
integer x = 137
integer y = 628
integer width = 448
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Appointments"
boolean checked = true
end type

event clicked;if this.checked or cbx_v.checked then
	cb_run.enabled = true
else
	cb_run.enabled = false
end if
end event

type cbx_prac from checkbox within w_user_update_new
integer x = 1061
integer y = 632
integer width = 631
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Use Practitioner List"
end type

event clicked;if this.checked then
	cb_prac.enabled = true
else
	cb_prac.enabled = False
end if
end event

type st_4 from statictext within w_user_update_new
integer x = 375
integer y = 1308
integer width = 928
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "This is not yet completed"
boolean focusrectangle = false
end type

type cb_prac from commandbutton within w_user_update_new
integer x = 448
integer y = 28
integer width = 453
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Get Practitioners"
end type

event clicked;
is_pracs = of_get_prac_list("L")
//messagebox("pracs",is_pracs)







end event

type dw_dept from datawindow within w_user_update_new
integer x = 59
integer y = 400
integer width = 1189
integer height = 84
integer taborder = 100
string dataobject = "d_dept_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_dept = long(data)
end event

type dw_facility from datawindow within w_user_update_new
integer x = 50
integer y = 212
integer width = 1202
integer height = 80
integer taborder = 90
string dataobject = "d_facility_all"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_facil = integer(data)
end event

type st_2 from statictext within w_user_update_new
integer x = 1353
integer y = 340
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "To:(required)"
boolean focusrectangle = false
end type

type dw_vercred from datawindow within w_user_update_new
integer x = 791
integer y = 1188
integer width = 96
integer height = 40
integer taborder = 30
string dataobject = "d_verif_by_user_facil"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_affil from datawindow within w_user_update_new
integer x = 283
integer y = 1172
integer width = 73
integer height = 68
integer taborder = 20
string dataobject = "d_affil_by_user"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_to from datawindow within w_user_update_new
integer x = 1344
integer y = 400
integer width = 462
integer height = 80
integer taborder = 130
string dataobject = "d_users_utl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_to = data
end event

type dw_from from datawindow within w_user_update_new
integer x = 1349
integer y = 212
integer width = 466
integer height = 80
integer taborder = 80
string dataobject = "d_users_utl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_from = data
end event

type cb_close from commandbutton within w_user_update_new
integer x = 1573
integer y = 28
integer width = 274
integer height = 84
integer taborder = 50
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

type cb_1 from commandbutton within w_user_update_new
integer x = 1275
integer y = 28
integer width = 270
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("This program:","Designed for resetting the assigned user on the Appointment Status screen and Verification Records.~rSelect a 'from' user name (or leave blank) and a 'to' user name and a facility.  Department selection is optional.~rYou can further select a practitioner filter and only update for the selected practitioners. Click Run.~r~rIMPORTANT! This utility is designed for systems where parent and verifying facilities are the same.~rTo use in a system where the verifying facility is a separate facility from the Parent Facility, Run first on the Parent Facility to update the Appointment records and Basic Information screen verifications like NPDB and Expiring Appointments, then run the Verifying Facility for other credentials.")
end event

type gb_3 from groupbox within w_user_update_new
integer x = 37
integer y = 548
integer width = 1815
integer height = 264
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Update:"
end type

type gb_5 from groupbox within w_user_update_new
integer x = 37
integer y = 340
integer width = 1243
integer height = 192
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Department: (optional)"
end type

type gb_4 from groupbox within w_user_update_new
integer x = 37
integer y = 136
integer width = 1253
integer height = 192
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Facility: (required)"
end type

type gb_1 from groupbox within w_user_update_new
integer x = 1307
integer y = 136
integer width = 549
integer height = 396
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "From (optional):"
end type

type cb_run from commandbutton within w_user_update_new
integer x = 928
integer y = 28
integer width = 320
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;long a
long ac
long v
long vc
string userfrom
integer res
long lu_code
string ls_pracs
string ls_sql
string ls_sql_org
string ls_where
string ls_update_affil
string ls_update_ver
string ls_street
string ls_phone
integer rows

st_app.text = "0"
st_ver.text = "0"
//check required selections
if isnull(is_to) or is_to = "" then
	messagebox("select Error","You must select a TO user.")
	return
end if

if isnull(ii_facil) or ii_facil = 0 then
	messagebox("select Error","You must select a FACILITY.")
	return
end if

if cbx_prac.checked then
	if LenA( is_pracs ) < 1 then
		messagebox("Practitioner selection","There are no practitioners selected, No records found.")
		return
	end if
end if

if not cbx_a.checked and not cbx_v.checked then
	messagebox("Update selection","Neither Appointments or Verifications is selected.")
	return
end if
	

if il_dept > 0 then //if department being used
	dw_affil.dataobject = "d_affil_by_user_dept"
	dw_vercred.dataobject = "d_verif_by_user_facil_dept"
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.06.2006 By: Rodger Wu
	//$<reason> Change logicality of update SQL Syntax for supporting MS SQL Server database.
	/*
	ls_update_affil = "UPDATE pd_affil_stat, pd_affil_dept set pd_affil_stat.priority_user = '" + is_to + "'  WHERE ( pd_affil_stat.rec_id = pd_affil_dept.rec_id ) and  ( pd_affil_stat.active_status in (1,4) ) AND  ( pd_affil_dept.primary_dept = 1 ) "
	ls_update_ver = "update verif_info,   pd_affil_dept,   pd_affil_stat set verif_info.priority_user = '" + is_to + "' WHERE ( pd_affil_stat.rec_id = pd_affil_dept.rec_id ) and  ( verif_info.prac_id = pd_affil_stat.prac_id ) and   ( verif_info.facility_id = pd_affil_stat.parent_facility_id ) and  ( ( verif_info.active_status = 1 ) AND  ( pd_affil_dept.primary_dept = 1 ) )"	
	*/
	ls_update_affil = "UPDATE pd_affil_stat set pd_affil_stat.priority_user = '" + is_to + "'  WHERE "
	ls_update_ver = "update verif_info set verif_info.priority_user = '" + is_to + "' WHERE "	
	//---------------------------- APPEON END ----------------------------
else
	dw_affil.dataobject = "d_affil_by_user"
	dw_vercred.dataobject = "d_verif_by_user_facil"
	ls_update_affil = "update pd_affil_stat set pd_affil_stat.priority_user = '" + is_to + "' WHERE pd_affil_stat.active_status in (1,4)"
	ls_update_ver = "update verif_info set verif_info.priority_user = '" + is_to + "'  WHERE verif_info.active_status = 1 "
end if

dw_affil.SetTransObject( SQLCA )
dw_vercred.SetTransObject( SQLCA )

//appointments
ls_sql = dw_affil.getsqlSelect()
ls_sql_org = ls_sql
//messagebox("sqlorg",ls_sql_org)
//ls_sql = dw_affil.Describe("DataWindow.Table.Select")
//messagebox("sql",ls_sql)
integer t
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.06.2006 By: Rodger Wu
//$<reason> Append table name ahead of columns.
/*
ls_where =  "AND parent_facility_id = " + string(ii_facil)

if len(is_from) > 0 then
	ls_where = ls_where + " and upper(priority_user) = upper('" + is_from + "')"
end if

if il_dept > 0 then
	ls_where = ls_where + " and department = " + string(il_dept)
end if
*/
ls_where =  "AND pd_affil_stat.parent_facility_id = " + string(ii_facil)

if LenA(is_from) > 0 then
	ls_where = ls_where + " and upper(pd_affil_stat.priority_user) = upper('" + is_from + "')"
end if

if il_dept > 0 then
	ls_where = ls_where + " and pd_affil_dept.department = " + string(il_dept)
end if
//---------------------------- APPEON END ----------------------------

//add prac list to sql 
if cbx_prac.checked then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.13.2006 By: Luke
	//$<reason> Old application bugs. pd_affil_stat and pd_affil_dept have 
	//$<reason> same column 'prac_id'. need add table name before column.
	
	// ls_where = ls_where + " and prac_id in (" + is_pracs + ")"
	   ls_where = ls_where + " and pd_affil_stat.prac_id in (" + is_pracs + ")"
	//---------------------------- APPEON END ----------------------------
end if

ls_sql = ls_sql + ls_where
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.06.2006 By: Rodger Wu
//$<reason> Change logicality of update SQL Syntax for supporting MS SQL Server database.
/* ls_update_affil = ls_update_affil + ls_where + ";" */
if Not il_dept > 0 then
	ls_update_affil = ls_update_affil + ls_where + ";"
end if
//---------------------------- APPEON END ----------------------------

//messagebox("sql",ls_sql)
//t = dw_affil.SetTransObject( SQLCA )
//if t < 1 then messagebox("sql","trea setr error")
t = dw_affil.SetSQLSelect ( ls_sql )
if t < 1 then 
	messagebox("SetSQLselect error",ls_sql)
	//clipboard(ls_sql)
	return
end if

//dw_affil.modify("priority_user.update=Yes")
//dw_affil.object.DataWindow.Table.updatetable="pd_affil_stat"
//dw_affil.object.DataWindow.Table.updatekeyinplace="YES"
//dw_affil.object.DataWindow.Table.updatewhere=1

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.09.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )

//---------------------------- APPEON END ----------------------------

if cbx_a.checked then
	ac = dw_affil.retrieve()
else
	//messagebox("","no appt")
end if
dw_affil.SetSQLSelect ( ls_sql_org )


//verification
ls_sql = dw_vercred.GetSQLSelect()
ls_sql_org = ls_sql

ls_where =  "AND verif_info.facility_id = " + string(ii_facil)

if LenA(is_from) > 0 then
	ls_where =  ls_where + " and upper(verif_info.priority_user) = upper('" + is_from + "')"
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.06.2006 By: Rodger Wu
//$<reason> Append table name ahead of columns.
/*
if il_dept > 0 then
	ls_where = ls_where + " and department = " + string(il_dept)
end if
*/
if il_dept > 0 then
	ls_where = ls_where + " and pd_affil_dept.department = " + string(il_dept)
end if
//---------------------------- APPEON END ----------------------------


//add prac list to sql 
if cbx_prac.checked then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.24.2006 By: Rodger Wu
	//$<reason> Original code bug fixing 
	/* ls_where =  " and verif_info.prac_id in (" + is_pracs + ")" */
	ls_where +=  " and verif_info.prac_id in (" + is_pracs + ")"
	//---------------------------- APPEON END ----------------------------
end if

ls_sql = ls_sql + ls_where
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.06.2006 By: Rodger Wu
//$<reason> Change logicality of update SQL Syntax for supporting MS SQL Server database.
/* ls_update_ver = ls_update_ver + ls_where + ";" */
if Not il_dept > 0 then
	ls_update_ver = ls_update_ver + ls_where + ";"
end if
//---------------------------- APPEON END ----------------------------
//dw_vercred.SetTransObject( SQLCA )
dw_vercred.SetSQLSelect ( ls_sql )
//clipboard(ls_sql)
//messagebox("ver",ls_sql)

if cbx_v.checked then
	if il_dept > 0 then //if department being used
		vc = dw_vercred.retrieve()
	else	
		vc = dw_vercred.retrieve()
	end if
else
	//messagebox("","no ver")
end if

dw_vercred.SetSQLSelect ( ls_sql_org ) //reset to org

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 02.09.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_commitqueue( )
ac = dw_affil.RowCount()
vc = dw_vercred.RowCount()
//---------------------------- APPEON END ----------------------------
st_app.text = string(ac)
st_ver.text = string(vc)

if ac < 1 and vc < 1 then
	messagebox("No records","No matching records found for the selected user and facility.")
	return
end if
	
if cbx_a.checked then
	if ac < 1 and vc > 0 then
		res = messagebox("No records","No matching records found for Appointments.  Continue updates of the " + string(vc) + " verification records?",question!,yesno!,1)
		if res = 2 then return	
	end if
end if

if cbx_v.checked then
	if ac > 0 and vc < 1 then
		res = messagebox("No records","No matching records found for Verifications.  Continue updates of the " + string(ac) + " Appointments records?",question!,yesno!,1)
		if res = 2 then return	
	end if
end if



//if ac > 0 then
//	for a = 1 to ac
//		dw_affil.setitem(a,"priority_user",is_to)
//	next
//end if
//
//if vc > 0 then
//	for v = 1 to vc
//		dw_vercred.setitem(v,"priority_user",is_to)
//	next
//end if

res = messagebox("Finish?","Update the records?",question!,yesno!,1)
if res = 2 then return

//messagebox("ls_update_affil",ls_update_affil)
//messagebox("ls_update_ver",ls_update_ver)
//clipboard(ls_update_ver)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.06.2006 By: Rodger Wu
//$<reason> Change logicality of update SQL Syntax for supporting MS SQL Server database.
Long ll_loop
String ls_recid
if il_dept > 0 then
	if ac > 0 then
		For ll_loop = 1 to ac
			ls_recid += String( dw_affil.GetItemNumber( ll_loop, "rec_id" )) + ", "
		Next
		ls_recid = LeftA( ls_recid, LenA( ls_recid ) - 2 )
		ls_update_affil += "pd_affil_stat.rec_id in ( " + ls_recid + " )"
	end if
	
	if vc > 0 then
		ls_recid = ''
		For ll_loop = 1 to vc
			ls_recid += String( dw_vercred.GetItemNumber( ll_loop, "rec_id" )) + ", "
		Next
		ls_recid = LeftA( ls_recid, LenA( ls_recid ) - 2 )
		ls_update_ver += "verif_info.rec_id in ( " + ls_recid + " )"
	end if
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 02.09.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
/*
execute immediate :ls_update_affil using sqlca;
execute immediate :ls_update_ver using sqlca;
//dw_affil.update()
//dw_vercred.update()
*/
gnv_appeondb.of_startqueue( )
if ac > 0 then
	execute immediate :ls_update_affil using sqlca;
end if
if vc > 0 then
	execute immediate :ls_update_ver using sqlca;
end if
commit using sqlca;

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------
//messagebox("Update","Completed")
end event

type st_3 from statictext within w_user_update_new
integer x = 1001
integer y = 1552
integer width = 1179
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "IMPORTANT! This utility is built only for systems where parent and verifying facilities are the same.  "
boolean focusrectangle = false
end type

