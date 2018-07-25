$PBExportHeader$w_user_security_fix.srw
forward
global type w_user_security_fix from window
end type
type cb_2 from commandbutton within w_user_security_fix
end type
type dw_all_rights from datawindow within w_user_security_fix
end type
type cb_rights from commandbutton within w_user_security_fix
end type
type dw_rights from datawindow within w_user_security_fix
end type
type dw_act from datawindow within w_user_security_fix
end type
type dw_role from datawindow within w_user_security_fix
end type
type dw_2 from datawindow within w_user_security_fix
end type
type cb_view from commandbutton within w_user_security_fix
end type
type dw_view from datawindow within w_user_security_fix
end type
type st_3 from statictext within w_user_security_fix
end type
type st_1 from statictext within w_user_security_fix
end type
type st_2 from statictext within w_user_security_fix
end type
type cb_dupe from commandbutton within w_user_security_fix
end type
type dw_3 from datawindow within w_user_security_fix
end type
type dw_1 from datawindow within w_user_security_fix
end type
type cb_3 from commandbutton within w_user_security_fix
end type
type cb_1 from commandbutton within w_user_security_fix
end type
type dw_dupe from datawindow within w_user_security_fix
end type
end forward

global type w_user_security_fix from window
integer x = 1207
integer y = 1092
integer width = 1307
integer height = 556
boolean titlebar = true
string title = "Adjust user security"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_2 cb_2
dw_all_rights dw_all_rights
cb_rights cb_rights
dw_rights dw_rights
dw_act dw_act
dw_role dw_role
dw_2 dw_2
cb_view cb_view
dw_view dw_view
st_3 st_3
st_1 st_1
st_2 st_2
cb_dupe cb_dupe
dw_3 dw_3
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
dw_dupe dw_dupe
end type
global w_user_security_fix w_user_security_fix

type variables
integer ii_row
integer ii_fac
integer ii_mes
end variables

on w_user_security_fix.create
this.cb_2=create cb_2
this.dw_all_rights=create dw_all_rights
this.cb_rights=create cb_rights
this.dw_rights=create dw_rights
this.dw_act=create dw_act
this.dw_role=create dw_role
this.dw_2=create dw_2
this.cb_view=create cb_view
this.dw_view=create dw_view
this.st_3=create st_3
this.st_1=create st_1
this.st_2=create st_2
this.cb_dupe=create cb_dupe
this.dw_3=create dw_3
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_dupe=create dw_dupe
this.Control[]={this.cb_2,&
this.dw_all_rights,&
this.cb_rights,&
this.dw_rights,&
this.dw_act,&
this.dw_role,&
this.dw_2,&
this.cb_view,&
this.dw_view,&
this.st_3,&
this.st_1,&
this.st_2,&
this.cb_dupe,&
this.dw_3,&
this.dw_1,&
this.cb_3,&
this.cb_1,&
this.dw_dupe}
end on

on w_user_security_fix.destroy
destroy(this.cb_2)
destroy(this.dw_all_rights)
destroy(this.cb_rights)
destroy(this.dw_rights)
destroy(this.dw_act)
destroy(this.dw_role)
destroy(this.dw_2)
destroy(this.cb_view)
destroy(this.dw_view)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_dupe)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.dw_dupe)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	MESSAGEBOX("","LOGIN OK")
//END IF

ii_mes = message.doubleparm

dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.retrieve()
dw_3.retrieve()
dw_2.settransobject(sqlca)
dw_2.retrieve()

end event

event close;//disCONNECT USING SQLCA;
end event

type cb_2 from commandbutton within w_user_security_fix
integer x = 1632
integer y = 524
integer width = 654
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run facility access old"
end type

event clicked;long i
long ic
long v
long vc
long recid
long meth
integer r
integer rc
integer cnt = 0
integer ck
integer facid
string useid


delete from security_users where user_id is null;
delete from security_users where user_id = '';

delete from security_user_facilities where user_id is null;
delete from security_user_facilities where user_id = '';


select max(user_facility_id) into :recid from security_user_facilities;
	


vc = dw_1.rowcount()
ic = dw_3.rowcount()
//st_2.text = string(vc)
for v = 1 to  vc //
	//st_1.text = string(v)
	facid = dw_1.getitemnumber(v,"facility_id")

	for i = 1 to  ic
		useid = dw_3.getitemstring(i,"user_id")

		dw_dupe.settransobject(sqlca)
		rc = dw_dupe.retrieve(facid,useid)  //get all user security records
		ck = 0
		//messagebox("rc",rc)
		if rc = 1 then
			//nothing
		elseif rc = 0 then
			dw_dupe.insertrow(1)
			recid++
			dw_dupe.setitem(1,"user_facility_id",recid)
			dw_dupe.setitem(1,"user_id",useid)
			dw_dupe.setitem(1,"facility_id",facid)
			dw_dupe.setitem(1,"access_rights",0)
			dw_dupe.update()
			commit using sqlca;

		else
			for r = rc to 2 step -1
				dw_dupe.deleterow(r) //delete extra rows
			next
			dw_dupe.update()
			commit using sqlca;
		end if			
	next	
	
next

messagebox("Finished", "Done")
end event

type dw_all_rights from datawindow within w_user_security_fix
integer x = 1682
integer y = 728
integer width = 686
integer height = 400
integer taborder = 100
string title = "none"
string dataobject = "d_sec_role_rights_by_role"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_rights from commandbutton within w_user_security_fix
integer x = 37
integer y = 256
integer width = 654
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "3) Check Role Rights"
end type

event clicked;long i
long ic
long v
long vc
long recid
long meth
long dcnt = 0
long ll_act
long ll_find
long newcnt
integer r
integer rc
integer cnt = 0
integer ck
integer facid
integer nr
integer roleid
integer check_type
string sadd
string sdel



dw_role.settransobject(sqlca)
dw_act.settransobject(sqlca)
vc = dw_act.retrieve()
ic = dw_role.retrieve()

select max(rights_id) into :recid from security_roles_rights;

//st_2.text = string(vc)
for v = 1 to  vc //scan actions
	//st_1.text = string(v)
	facid = dw_act.getitemnumber(v,"action_id")
	check_type = dw_act.getitemnumber(v,"dddw_type")
	
	dw_rights.settransobject(sqlca) //get existing rights
	rc = dw_rights.retrieve(facid)
	for i = 1 to  ic //scan roles against rights
		roleid = dw_role.getitemnumber(i,"role_id")
		ck = 0
		//messagebox("rc",rc)
		for r = 1 to rc
			if dw_rights.getitemnumber(r,"role_id") = roleid then
				ck = 1
			end if
		next
		
		if ck = 1 then
			//nothing
		else 
			nr = dw_rights.insertrow(0)
			cnt++
			st_1.text = string(cnt)
			recid++
			dw_rights.setitem(nr,"rights_id",recid)
			dw_rights.setitem(nr,"action_id",facid)
			sadd+= string(facid) + "-"
			dw_rights.setitem(nr,"role_id",roleid)
			debugbreak()
			if check_type = 2 then
				dw_rights.setitem(nr,"value_id",2)
			else
				dw_rights.setitem(nr,"value_id",1)
			end if
			dw_rights.update()
			commit using sqlca;
		end if			
	next	
	
next

//Start Code Change ----02.05.2008 #V8 maha - added to clear duplicates
dw_all_rights.settransobject(sqlca)
for i = 1 to ic
	roleid = dw_role.getitemnumber(i,"role_id")
	vc = dw_all_rights.retrieve(roleid) //all rights for a role
	for v = 1 to vc
		newcnt = dw_all_rights.rowcount()
		if v > newcnt - 1 then exit  //if deleted recs put v over rowcount and skip last row
		ll_act = dw_all_rights.getitemnumber(v,"action_id")
		ll_find = dw_all_rights.find("action_id = " + string(ll_act), v+1, newcnt) //find it again
		if ll_find > 0 then
			sdel+= string(ll_act) + "-"
			dw_all_rights.deleterow(ll_find)
			v = v - 1 //reset v to check again
			dcnt++
		end if
	next
	dw_all_rights.update()
	
next //roleid


if ii_mes = 1 then
	messagebox("Finished", string (cnt ) + " Added (" + sadd + ") and "  + string(dcnt) + " Deleted (" + sdel + ").")
end if
end event

type dw_rights from datawindow within w_user_security_fix
integer x = 1138
integer y = 744
integer width = 494
integer height = 360
integer taborder = 100
string dataobject = "d_sec_role_rights"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_act from datawindow within w_user_security_fix
integer x = 608
integer y = 728
integer width = 494
integer height = 360
integer taborder = 90
string dataobject = "d_scrty_actions_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_role from datawindow within w_user_security_fix
integer x = 73
integer y = 724
integer width = 494
integer height = 360
integer taborder = 80
string dataobject = "d_roles"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_user_security_fix
integer x = 242
integer y = 512
integer width = 59
integer height = 76
integer taborder = 50
string dataobject = "d_sec_data_view"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_view from commandbutton within w_user_security_fix
integer x = 37
integer y = 144
integer width = 654
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "2) Run view access"
end type

event clicked;long i
long ic
long v
long vc
long recid
long meth
integer r
integer rc
integer cnt = 0
integer ck
integer facid
string useid
boolean lb_add = false


delete from security_user_views where user_id is null;
delete from security_user_views where user_id = '';

select max(user_view_id) into :recid from security_user_views;
	


vc = dw_2.rowcount()
ic = dw_3.rowcount()
//st_2.text = string(vc)
for v = 1 to  vc //
	//st_1.text = string(v)
	facid = dw_2.getitemnumber(v,"data_view_id")

	for i = 1 to  ic
		useid = dw_3.getitemstring(i,"user_id")

		dw_view.settransobject(sqlca)
		rc = dw_view.retrieve(facid,useid)  //get all user security records
		ck = 0
		//messagebox("rc",rc)
		if rc = 1 then
			//nothing
		elseif rc = 0 then
			dw_view.insertrow(1)
			lb_add = true
			recid++
			dw_view.setitem(1,"user_view_id",recid)
			dw_view.setitem(1,"user_id",useid)
			dw_view.setitem(1,"view_id",facid)
			dw_view.setitem(1,"access_rights",0)
			dw_view.update()
			commit using sqlca;

		else
			for r = rc to 2 step -1
				dw_view.deleterow(r) //delete extra rows
			next
			dw_view.update()
			commit using sqlca;
		end if			
	next	
	
next

//Start Code Change ----02.12.2013 #V12 maha
if lb_add then
	recid++
	update ids set user_view_id = :recid;
end if
//End Code Change ----02.12.2013 

messagebox("Finished", "Done")
end event

type dw_view from datawindow within w_user_security_fix
integer x = 315
integer y = 624
integer width = 91
integer height = 84
integer taborder = 70
string dataobject = "d_user_view_secrty"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_user_security_fix
integer x = 1595
integer y = 184
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_user_security_fix
integer x = 805
integer y = 268
integer width = 247
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
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_user_security_fix
integer x = 1865
integer y = 272
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type cb_dupe from commandbutton within w_user_security_fix
integer x = 37
integer y = 32
integer width = 654
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "1) Run facility access"
end type

event clicked;//Start Code Change ----03.21.2011 #V11 maha - modified by filtering to be more effecient.
long i
long ic
long v
long vc
long recid
long meth
Long ll_dupe_cnt //Added by Appeon long.zhang 05.24.2017
Long ll_dupe_row = 0 //Added by Appeon long.zhang 05.24.2017
//integer r
//integer rc
Long r //modified by Appeon long.zhang 05.24.2017
Long rc //modified by Appeon long.zhang 05.24.2017
//integer cnt = 0
//integer ck
integer facid
string useid
string ls_filter
boolean lb_add = false  //maha 02.12.2013

delete from security_users where user_id is null;
delete from security_users where user_id = '';

delete from security_user_facilities where user_id is null;
delete from security_user_facilities where user_id = '';

//Added by Appeon long.zhang 05.24.2017 (Bug id 5652 - Case 71112 Cannot run User Security Utilities through System>Utilities SaaS 14.2 Build 02082017)
delete from security_user_facilities
where not exists(select 1 from security_users where security_users.user_id = security_user_facilities.user_id) 
OR not exists(select 1 from facility where facility.facility_id = security_user_facilities.facility_id);

select max(user_facility_id) into :recid from security_user_facilities;
	

vc = dw_1.rowcount()
ic = dw_3.rowcount()

dw_dupe.settransobject(sqlca)
rc = dw_dupe.retrieve()


//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 05.24.2017
//<$>reason:Optimize the speed, For Bug id 5652 - Case 71112 Cannot run User Security Utilities through System>Utilities SaaS 14.2 Build 02082017

////st_2.text = string(vc)
//for v = 1 to  vc
//	//st_1.text = string(v)
//	facid = dw_1.getitemnumber(v,"facility_id")
//
//	for i = 1 to  ic
//		useid = dw_3.getitemstring(i,"user_id")
//
//		ls_filter = 'facility_id = ' + string(facid) + ' and user_id = "' + useid + '"'
//		rc = dw_dupe.setfilter( ls_filter)
//		dw_dupe.filter()
//		if rc < 1 then
//			messagebox("Filter failed",ls_filter)
//			//return
//		end if
//		rc = dw_dupe.rowcount()
//		ck = 0
//		//messagebox("rc",rc)
//		if rc = 1 then
//			//nothing
//		elseif rc = 0 then
//			dw_dupe.insertrow(1)
//			lb_add = true
//			recid++
//			dw_dupe.setitem(1,"user_facility_id",recid)
//			dw_dupe.setitem(1,"user_id",useid)
//			dw_dupe.setitem(1,"facility_id",facid)
//			dw_dupe.setitem(1,"access_rights",0)
//			dw_dupe.update()
//			commit using sqlca;
//
//		else
//			for r = rc to 2 step -1
//				dw_dupe.deleterow(r) //delete extra rows
//			next
//			dw_dupe.update()
//			commit using sqlca;
//		end if			
//	next	
//next

//Delete dupplcate records from dw_dupe (dw_dupe was already sorted by facility_id, user_id)
For i = rc to  2 Step -1
	If dw_dupe.GetItemNumber(i, 'facility_id') = dw_dupe.GetItemNumber(i - 1, 'facility_id')  &
		And dw_dupe.GetItemString(i, 'user_id') = dw_dupe.GetItemString(i - 1, 'user_id')  Then
		dw_dupe.DeleteRow(i)
	End If
Next	
dw_dupe.update()

ll_dupe_cnt = dw_dupe.RowCount() 

//Check whether need to insert to dw_dupe (dw_dupe was already sorted by facility_id, user_id)
for v = 1 to  vc	
	st_1.text = string(v) +'/' + String(vc)
	Yield()
		
	facid = dw_1.getitemnumber(v,"facility_id")

	for i = 1 to  ic
		useid = dw_3.getitemstring(i,"user_id")

		ll_dupe_row++ //Check this record
		If ll_dupe_row <= ll_dupe_cnt Then //Loop all dw_dupe records
			If dw_dupe.GetItemNumber(ll_dupe_row, 'facility_id') = facid And &
				dw_dupe.GetItemString(ll_dupe_row, 'user_id') = useid Then 		
				Continue // don't need to insert
			End If
		End If
		
		//Need to insert	
		dw_dupe.insertrow(ll_dupe_row)
		ll_dupe_cnt++
		
		lb_add = true
		recid++
		dw_dupe.setitem(ll_dupe_row,"user_facility_id",recid)
		dw_dupe.setitem(ll_dupe_row,"user_id",useid)
		dw_dupe.setitem(ll_dupe_row,"facility_id",facid)
		dw_dupe.setitem(ll_dupe_row,"access_rights",0)
	next	
next

dw_dupe.update()
//------------------- APPEON END -------------------

//Start Code Change ----02.12.2013 #V12 maha
if lb_add then
	recid++
	update ids set user_facility_id = :recid;
end if
//End Code Change ----02.12.2013 

messagebox("Finished", "Done")

st_1.text = '' //Added by Appeon long.zhang 05.24.2017

end event

type dw_3 from datawindow within w_user_security_fix
integer x = 411
integer y = 492
integer width = 91
integer height = 76
integer taborder = 110
string dataobject = "d_sec_users"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_user_security_fix
integer x = 123
integer y = 500
integer width = 64
integer height = 76
integer taborder = 120
string dataobject = "d_sec_facility"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_user_security_fix
integer x = 791
integer y = 32
integer width = 274
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_user_security_fix
integer x = 795
integer y = 140
integer width = 265
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Click button.  Program will check users facilities and add and delete appropriate records.")
end event

type dw_dupe from datawindow within w_user_security_fix
integer x = 599
integer y = 492
integer width = 334
integer height = 92
integer taborder = 60
string dataobject = "d_user_facil_fix"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

