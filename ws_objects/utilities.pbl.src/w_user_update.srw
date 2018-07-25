$PBExportHeader$w_user_update.srw
forward
global type w_user_update from window
end type
type st_9 from statictext within w_user_update
end type
type dw_dept from datawindow within w_user_update
end type
type st_ver from statictext within w_user_update
end type
type st_app from statictext within w_user_update
end type
type st_6 from statictext within w_user_update
end type
type st_5 from statictext within w_user_update
end type
type st_4 from statictext within w_user_update
end type
type dw_facility from datawindow within w_user_update
end type
type st_2 from statictext within w_user_update
end type
type st_1 from statictext within w_user_update
end type
type dw_vercred from datawindow within w_user_update
end type
type dw_affil from datawindow within w_user_update
end type
type dw_to from datawindow within w_user_update
end type
type dw_from from datawindow within w_user_update
end type
type cb_3 from commandbutton within w_user_update
end type
type cb_1 from commandbutton within w_user_update
end type
type gb_1 from groupbox within w_user_update
end type
type cb_2 from commandbutton within w_user_update
end type
type st_3 from statictext within w_user_update
end type
end forward

global type w_user_update from window
integer x = 965
integer y = 256
integer width = 1326
integer height = 1572
boolean titlebar = true
string title = "Update Assigned Users"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
st_9 st_9
dw_dept dw_dept
st_ver st_ver
st_app st_app
st_6 st_6
st_5 st_5
st_4 st_4
dw_facility dw_facility
st_2 st_2
st_1 st_1
dw_vercred dw_vercred
dw_affil dw_affil
dw_to dw_to
dw_from dw_from
cb_3 cb_3
cb_1 cb_1
gb_1 gb_1
cb_2 cb_2
st_3 st_3
end type
global w_user_update w_user_update

type variables
string is_from
string is_to
integer ii_facil
long il_dept = 0
end variables

on w_user_update.create
this.st_9=create st_9
this.dw_dept=create dw_dept
this.st_ver=create st_ver
this.st_app=create st_app
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.dw_facility=create dw_facility
this.st_2=create st_2
this.st_1=create st_1
this.dw_vercred=create dw_vercred
this.dw_affil=create dw_affil
this.dw_to=create dw_to
this.dw_from=create dw_from
this.cb_3=create cb_3
this.cb_1=create cb_1
this.gb_1=create gb_1
this.cb_2=create cb_2
this.st_3=create st_3
this.Control[]={this.st_9,&
this.dw_dept,&
this.st_ver,&
this.st_app,&
this.st_6,&
this.st_5,&
this.st_4,&
this.dw_facility,&
this.st_2,&
this.st_1,&
this.dw_vercred,&
this.dw_affil,&
this.dw_to,&
this.dw_from,&
this.cb_3,&
this.cb_1,&
this.gb_1,&
this.cb_2,&
this.st_3}
end on

on w_user_update.destroy
destroy(this.st_9)
destroy(this.dw_dept)
destroy(this.st_ver)
destroy(this.st_app)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.dw_facility)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_vercred)
destroy(this.dw_affil)
destroy(this.dw_to)
destroy(this.dw_from)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.cb_2)
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
dw_to.settransobject(sqlca)
dw_to.retrieve()
dw_to.insertrow(1)
dw_to.GetChild( "user_id", dwchild )
dwchild.insertrow(1)
dwchild.setitem(1,"user_id","Public")
dw_facility.settransobject(sqlca)
dw_facility.retrieve()
dw_facility.insertrow(1)
dw_dept.settransobject(sqlca)
dw_dept.retrieve()
dw_dept.insertrow(1)

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

type st_9 from statictext within w_user_update
integer x = 46
integer y = 848
integer width = 800
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
string text = "Select Department: (Optional)"
boolean focusrectangle = false
end type

type dw_dept from datawindow within w_user_update
integer x = 37
integer y = 924
integer width = 1189
integer height = 92
integer taborder = 90
string dataobject = "d_dept_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_dept = long(data)
end event

type st_ver from statictext within w_user_update
integer x = 672
integer y = 1204
integer width = 247
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
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_app from statictext within w_user_update
integer x = 247
integer y = 1204
integer width = 247
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
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_user_update
integer x = 635
integer y = 1124
integer width = 338
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
string text = "Verifications"
boolean focusrectangle = false
end type

type st_5 from statictext within w_user_update
integer x = 187
integer y = 1124
integer width = 379
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
string text = "Appointments"
boolean focusrectangle = false
end type

type st_4 from statictext within w_user_update
integer x = 46
integer y = 620
integer width = 411
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
string text = "Select Facility:"
boolean focusrectangle = false
end type

type dw_facility from datawindow within w_user_update
integer x = 32
integer y = 692
integer width = 1202
integer height = 92
integer taborder = 80
string dataobject = "d_facility_all"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_facil = integer(data)
end event

type st_2 from statictext within w_user_update
integer x = 722
integer y = 380
integer width = 247
integer height = 56
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

type st_1 from statictext within w_user_update
integer x = 178
integer y = 380
integer width = 247
integer height = 48
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

type dw_vercred from datawindow within w_user_update
boolean visible = false
integer x = 1074
integer y = 1064
integer width = 96
integer height = 40
integer taborder = 30
string dataobject = "d_verif_by_user_facil"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_affil from datawindow within w_user_update
boolean visible = false
integer x = 1038
integer y = 1124
integer width = 73
integer height = 68
integer taborder = 20
string dataobject = "d_affil_by_user"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_to from datawindow within w_user_update
integer x = 722
integer y = 440
integer width = 384
integer height = 80
integer taborder = 90
string dataobject = "d_users_utl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_to = data
end event

type dw_from from datawindow within w_user_update
integer x = 169
integer y = 440
integer width = 389
integer height = 80
integer taborder = 70
string dataobject = "d_users_utl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_from = data
end event

type cb_3 from commandbutton within w_user_update
integer x = 923
integer y = 20
integer width = 320
integer height = 84
integer taborder = 40
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

type cb_1 from commandbutton within w_user_update
integer x = 923
integer y = 112
integer width = 320
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("This program:","Designed for resetting the assigned user on the Appointment Status screen.~rSelect a 'from' user name and a 'to' user name and a facility.  Department selection is optional. Click run.~rIMPORTANT! This utility is designed for systems where parent and verifying facilities are the same.~rTo use in a system where the verifying facility is a separate facility, Run first on the Parent Facility to update the Appointment records and Basic Information screen verifications like NPDB and expiring Appointments, then run the Verifying Facility for other credentials.")
end event

type gb_1 from groupbox within w_user_update
integer x = 32
integer y = 304
integer width = 1216
integer height = 280
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Change user:"
end type

type cb_2 from commandbutton within w_user_update
integer x = 923
integer y = 204
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

if isnull(is_from) or is_from = "" then
	messagebox("select Error","You must select a FROM user.")
	return
end if

if isnull(is_to) or is_to = "" then
	messagebox("select Error","You must select a TO user.")
	return
end if

if isnull(ii_facil) or ii_facil = 0 then
	messagebox("select Error","You must select a FACILITY.")
	return
end if

if il_dept > 0 then //if department being used
	dw_affil.dataobject = "d_affil_by_user_dept"
	dw_affil.settransobject(sqlca)
	ac = dw_affil.retrieve(is_from,ii_facil,il_dept)
else
	ac = dw_affil.retrieve(is_from,ii_facil)
end if
st_app.text = string(ac)

if il_dept > 0 then //if department being used
	dw_vercred.dataobject = "d_verif_by_user_facil_dept"
	dw_vercred.settransobject(sqlca)
	vc = dw_vercred.retrieve(is_from,ii_facil,il_dept)
else	
	vc = dw_vercred.retrieve(is_from,ii_facil)
end if

st_ver.text = string(vc)

if ac < 1 and vc < 1 then
	messagebox("No records","No matching records found for the selected user and facility.")
	return
end if

if ac < 1 and vc > 0 then
	res = messagebox("No records","No matching records found for Appointments.  Continue updates of the " + string(vc) + " verification records?",question!,yesno!,1)
	if res = 2 then return	
end if

if ac > 0 and vc < 1 then
	res = messagebox("No records","No matching records found for Verifications.  Continue updates of the " + string(ac) + " Appointments records?",question!,yesno!,1)
	if res = 2 then return	
end if



if ac > 0 then
	for a = 1 to ac
		dw_affil.setitem(a,"priority_user",is_to)
	next
end if

if vc > 0 then
	for v = 1 to vc
		dw_vercred.setitem(v,"priority_user",is_to)
	next
end if

res = messagebox("Finish?","Update of the records?",question!,yesno!,1)
if res = 2 then return

dw_affil.update()
dw_vercred.update()
commit using sqlca;

messagebox("","Completed")



end event

type st_3 from statictext within w_user_update
integer x = 41
integer y = 24
integer width = 896
integer height = 260
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "IMPORTANT! This utility is built only for systems where parent and verifying facilities are the same.  "
boolean focusrectangle = false
end type

