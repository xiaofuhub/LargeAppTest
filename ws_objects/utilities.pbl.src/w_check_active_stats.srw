$PBExportHeader$w_check_active_stats.srw
forward
global type w_check_active_stats from window
end type
type dw_2 from datawindow within w_check_active_stats
end type
type cbx_dep from checkbox within w_check_active_stats
end type
type cbx_cat from checkbox within w_check_active_stats
end type
type cbx_fac from checkbox within w_check_active_stats
end type
type cbx_act from checkbox within w_check_active_stats
end type
type st_1 from statictext within w_check_active_stats
end type
type dw_1 from datawindow within w_check_active_stats
end type
type cb_3 from commandbutton within w_check_active_stats
end type
type cb_2 from commandbutton within w_check_active_stats
end type
type cb_1 from commandbutton within w_check_active_stats
end type
type gb_1 from groupbox within w_check_active_stats
end type
type gb_2 from groupbox within w_check_active_stats
end type
end forward

global type w_check_active_stats from window
integer x = 123
integer y = 112
integer width = 1481
integer height = 1844
boolean titlebar = true
string title = "Syncronize Appointment Data"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
dw_2 dw_2
cbx_dep cbx_dep
cbx_cat cbx_cat
cbx_fac cbx_fac
cbx_act cbx_act
st_1 st_1
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
end type
global w_check_active_stats w_check_active_stats

on w_check_active_stats.create
this.dw_2=create dw_2
this.cbx_dep=create cbx_dep
this.cbx_cat=create cbx_cat
this.cbx_fac=create cbx_fac
this.cbx_act=create cbx_act
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_2,&
this.cbx_dep,&
this.cbx_cat,&
this.cbx_fac,&
this.cbx_act,&
this.st_1,&
this.dw_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.gb_2}
end on

on w_check_active_stats.destroy
destroy(this.dw_2)
destroy(this.cbx_dep)
destroy(this.cbx_cat)
destroy(this.cbx_fac)
destroy(this.cbx_act)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
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
//END IF
//
////
dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

event close;//disCONNECT USING SQLCA;
end event

type dw_2 from datawindow within w_check_active_stats
boolean visible = false
integer x = 864
integer y = 876
integer width = 576
integer height = 304
integer taborder = 50
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_dep from checkbox within w_check_active_stats
integer x = 891
integer y = 728
integer width = 366
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Department"
end type

type cbx_cat from checkbox within w_check_active_stats
integer x = 891
integer y = 644
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Staff Cat"
end type

type cbx_fac from checkbox within w_check_active_stats
integer x = 891
integer y = 300
integer width = 334
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Facility"
end type

type cbx_act from checkbox within w_check_active_stats
integer x = 896
integer y = 220
integer width = 434
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Active Status"
boolean checked = true
end type

type st_1 from statictext within w_check_active_stats
integer x = 869
integer y = 1460
integer width = 347
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_check_active_stats
integer x = 32
integer y = 32
integer width = 782
integer height = 1616
integer taborder = 40
string dataobject = "d_all_affil_stat_recordsl"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_check_active_stats
integer x = 1152
integer y = 36
integer width = 274
integer height = 84
integer taborder = 20
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

type cb_2 from commandbutton within w_check_active_stats
integer x = 864
integer y = 36
integer width = 261
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;long i
long ic
long rec
long c
long ct
integer stat
integer facil
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.23.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
for i = 1 to dw_1.rowcount()
	st_1.text = string(i)
	rec = dw_1.getitemnumber(i,"rec_id")
	stat = dw_1.getitemnumber(i,"active_status")
	facil = dw_1.getitemnumber(i,"parent_facility_id")
	if cbx_act.checked then
		update pd_affil_dept set active_status = :stat where rec_id = :rec; 
		update pd_affil_staff_cat set active_status = :stat where rec_id = :rec; 
		//update pd_affil_staff_leave set active_status = :stat where rec_id = :rec; //removed maha 031504 for lij
		update pd_comm_review set active_status = :stat where rec_id = :rec;
	end if
	if cbx_fac.checked then//maha added 090904
		update pd_affil_dept set facility_id = :facil where rec_id = :rec; 
		update pd_affil_staff_cat set facility_id = :facil where rec_id = :rec; 
		update pd_comm_review set facility_id = :facil where rec_id = :rec; 
	end if
	commit using sqlca;
	if cbx_cat.checked then
		dw_2.dataobject = "d_pd_affil_staff_cat"
		dw_2.settransobject(sqlca)
		ct = dw_2.retrieve(rec, "MASTER")
		for c = 1 to ct
			dw_2.setitem(c,"seq_no",c)
		next
		dw_2.update()
	end if
	if cbx_dep.checked then
		dw_2.dataobject = "d_pd_affil_departments"
		dw_2.settransobject(sqlca)
		ct = dw_2.retrieve(rec,"MASTER")
		for c = 1 to ct
			dw_2.setitem(c,"seq_no",c)
		next
		dw_2.update()
	end if
next
*/
gnv_appeondb.of_startqueue( )

for i = 1 to dw_1.rowcount()
	st_1.text = string(i)
	rec = dw_1.getitemnumber(i,"rec_id")
	stat = dw_1.getitemnumber(i,"active_status")
	facil = dw_1.getitemnumber(i,"parent_facility_id")
	if cbx_act.checked then
		update pd_affil_dept set active_status = :stat where rec_id = :rec; 
		update pd_affil_staff_cat set active_status = :stat where rec_id = :rec; 
		//update pd_affil_staff_leave set active_status = :stat where rec_id = :rec; //removed maha 031504 for lij
		update pd_comm_review set active_status = :stat where rec_id = :rec;
		//Start Code Change ----11.05.2009 #V10 maha
		update pd_attest_questions set active_status = :stat where appt_stat_id = :rec;
	end if
	if cbx_fac.checked then//maha added 090904
		update pd_affil_dept set facility_id = :facil where rec_id = :rec; 
		update pd_affil_staff_cat set facility_id = :facil where rec_id = :rec; 
		update pd_comm_review set facility_id = :facil where rec_id = :rec; 
		//Start Code Change ----11.05.2009 #V10 maha
		update pd_attest_questions set facility_id = :facil where appt_stat_id = :rec;
	end if
	commit using sqlca;
	
	if cbx_cat.checked then
		dw_2.dataobject = "d_pd_affil_staff_cat"
		dw_2.settransobject(sqlca)
		ct = dw_2.retrieve(rec, "MASTER")
		for c = 1 to ct
			dw_2.setitem(c,"seq_no",c)
		next
		dw_2.update()
	end if
	if cbx_dep.checked then
		dw_2.dataobject = "d_pd_affil_departments"
		dw_2.settransobject(sqlca)
		ct = dw_2.retrieve(rec,"MASTER")
		for c = 1 to ct
			dw_2.setitem(c,"seq_no",c)
		next
		dw_2.update()
	end if
next

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//dw_1.update()
//commit using sqlca;
end event

type cb_1 from commandbutton within w_check_active_stats
integer x = 1641
integer y = 200
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

type gb_1 from groupbox within w_check_active_stats
integer x = 864
integer y = 148
integer width = 567
integer height = 264
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select fields"
end type

type gb_2 from groupbox within w_check_active_stats
integer x = 864
integer y = 568
integer width = 567
integer height = 264
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "SEQ No (conversions)"
end type

