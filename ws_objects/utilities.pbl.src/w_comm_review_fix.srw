$PBExportHeader$w_comm_review_fix.srw
forward
global type w_comm_review_fix from window
end type
type st_4 from statictext within w_comm_review_fix
end type
type st_3 from statictext within w_comm_review_fix
end type
type st_2 from statictext within w_comm_review_fix
end type
type st_1 from statictext within w_comm_review_fix
end type
type dw_commit from datawindow within w_comm_review_fix
end type
type dw_comm from datawindow within w_comm_review_fix
end type
type dw_affil from datawindow within w_comm_review_fix
end type
type cb_4 from commandbutton within w_comm_review_fix
end type
type cb_3 from commandbutton within w_comm_review_fix
end type
type cb_2 from commandbutton within w_comm_review_fix
end type
type cb_1 from commandbutton within w_comm_review_fix
end type
end forward

global type w_comm_review_fix from window
integer x = 123
integer y = 112
integer width = 1623
integer height = 388
boolean titlebar = true
string title = "Missing committee Generator"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
dw_commit dw_commit
dw_comm dw_comm
dw_affil dw_affil
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_comm_review_fix w_comm_review_fix

on w_comm_review_fix.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_commit=create dw_commit
this.dw_comm=create dw_comm
this.dw_affil=create dw_affil
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_commit,&
this.dw_comm,&
this.dw_affil,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_comm_review_fix.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_commit)
destroy(this.dw_comm)
destroy(this.dw_affil)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
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
end event

event close;//disCONNECT USING SQLCA;
end event

type st_4 from statictext within w_comm_review_fix
integer x = 315
integer y = 44
integer width = 201
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
string text = "Added"
boolean focusrectangle = false
end type

type st_3 from statictext within w_comm_review_fix
integer x = 549
integer y = 44
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
boolean focusrectangle = false
end type

type st_2 from statictext within w_comm_review_fix
integer x = 23
integer y = 140
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within w_comm_review_fix
integer x = 23
integer y = 36
integer width = 256
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type dw_commit from datawindow within w_comm_review_fix
integer x = 283
integer y = 1088
integer width = 1207
integer height = 356
integer taborder = 70
string dataobject = "d_committee_of_facil"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_comm from datawindow within w_comm_review_fix
integer x = 270
integer y = 676
integer width = 1225
integer height = 364
integer taborder = 60
string dataobject = "d_comm_review_of_recid"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_affil from datawindow within w_comm_review_fix
integer x = 270
integer y = 332
integer width = 923
integer height = 380
integer taborder = 50
string dataobject = "d_affil_stat_w_no_comms"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_comm_review_fix
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

type cb_3 from commandbutton within w_comm_review_fix
integer x = 1280
integer y = 28
integer width = 274
integer height = 84
integer taborder = 30
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

type cb_2 from commandbutton within w_comm_review_fix
integer x = 997
integer y = 28
integer width = 247
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

event clicked;//Start Code Change ----09.24.2013 #V14 maha - changed all loop variables from integer to long
long a
long ac
long r
long rc
long c
long cc
long n
long recid
long pracid
long facil
long commitee
integer cnt1 = 0
integer act_stat

dw_comm.settransobject(sqlca)
dw_affil.settransobject(sqlca)
ac = dw_affil.retrieve()
st_2.text = string(ac)
for a = 1 to ac
	dw_comm.reset()
	st_1.text = string(a)
	recid = dw_affil.getitemnumber(a,"rec_id")
	pracid = dw_affil.getitemnumber(a,"prac_id")
	facil = dw_affil.getitemnumber(a,"parent_facility_id")
	act_stat = dw_affil.getitemnumber(a,"active_status")
		dw_commit.settransobject(sqlca)
		cc = dw_commit.retrieve(facil)
		cnt1++
		st_3.text = string(cnt1)
		for c = 1 to cc
			commitee = dw_commit.getitemnumber(c,"committee_id")
			n = dw_comm.insertrow(0)
			dw_comm.setitem(n,"rec_id",recid)
			dw_comm.setitem(n,"prac_id",pracid)
			dw_comm.setitem(n,"facility_id",facil)
			dw_comm.setitem(n,"seq_no",1)
			dw_comm.setitem(n,"committee_id",commitee)
			dw_comm.setitem(n,"active_status",act_stat)
			
		next
		
		dw_comm.update()
		commit using sqlca;
		
	
next
	
messagebox("","Done")	
	
	
	
	
	
	
	
end event

type cb_1 from commandbutton within w_comm_review_fix
integer x = 3086
integer y = 164
integer width = 265
integer height = 72
integer taborder = 40
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

