$PBExportHeader$w_utl_print_reset.srw
forward
global type w_utl_print_reset from window
end type
type cb_5 from commandbutton within w_utl_print_reset
end type
type st_2 from statictext within w_utl_print_reset
end type
type st_1 from statictext within w_utl_print_reset
end type
type cb_2 from commandbutton within w_utl_print_reset
end type
type dw_2 from datawindow within w_utl_print_reset
end type
type em_1 from editmask within w_utl_print_reset
end type
type cb_run from commandbutton within w_utl_print_reset
end type
type dw_1 from datawindow within w_utl_print_reset
end type
type cb_4 from commandbutton within w_utl_print_reset
end type
type cb_3 from commandbutton within w_utl_print_reset
end type
type cb_1 from commandbutton within w_utl_print_reset
end type
end forward

global type w_utl_print_reset from window
integer x = 123
integer y = 112
integer width = 2638
integer height = 2260
boolean titlebar = true
string title = "Reset verification Print flag"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_5 cb_5
st_2 st_2
st_1 st_1
cb_2 cb_2
dw_2 dw_2
em_1 em_1
cb_run cb_run
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
end type
global w_utl_print_reset w_utl_print_reset

type variables
long il_code
end variables

on w_utl_print_reset.create
this.cb_5=create cb_5
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.em_1=create em_1
this.cb_run=create cb_run
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_5,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.dw_2,&
this.em_1,&
this.cb_run,&
this.dw_1,&
this.cb_4,&
this.cb_3,&
this.cb_1}
end on

on w_utl_print_reset.destroy
destroy(this.cb_5)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.em_1)
destroy(this.cb_run)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
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
//	//MESSAGEBOX("","LOGIN OK")
//END IF

date d_t

d_t = today()
em_1.text = string(d_t) 


dw_1.settransobject(sqlca)
//dw_1.retrieve()
dw_2.settransobject(sqlca)
dw_2.retrieve()
dw_2.insertrow(1)









end event

event close;//disCONNECT USING SQLCA;
end event

type cb_5 from commandbutton within w_utl_print_reset
integer x = 1806
integer y = 136
integer width = 352
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.SetFilter(null_str)

dw_1.Filter()
end event

type st_2 from statictext within w_utl_print_reset
integer x = 46
integer y = 56
integer width = 311
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Print Date"
boolean focusrectangle = false
end type

type st_1 from statictext within w_utl_print_reset
integer x = 466
integer y = 56
integer width = 535
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
string text = "Select Verif Method"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_utl_print_reset
integer x = 2171
integer y = 136
integer width = 352
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset Print"
end type

event clicked;long i
long ic

for i = 1 to dw_1.rowcount()
	if dw_1.getitemnumber(i,"selected") = 1 then  //Start Code Change ----05.17.2011 #V11 maha - added individual select ability
		dw_1.setitem(i,"print_flag",1)
	end if
next

dw_1.update()
commit using sqlca;
end event

type dw_2 from datawindow within w_utl_print_reset
integer x = 434
integer y = 128
integer width = 791
integer height = 84
integer taborder = 30
string dataobject = "d_utl_verification_method"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_code = long(data)
end event

type em_1 from editmask within w_utl_print_reset
integer x = 46
integer y = 128
integer width = 357
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

type cb_run from commandbutton within w_utl_print_reset
integer x = 1285
integer y = 136
integer width = 352
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

event clicked;//integer res
//res = messagebox("This operation:","This utility will add missing facility committees to current appointments.  Used when committees have been added to a facility after the appointments were created.  ~rContinue?",question!,yesno!,2)
//if res = 2 then return
//
//integer a
//integer ac
//integer p
//integer pc
//integer c
//integer cc
//integer nr
//integer nc
//integer li_fac
//long ll_commid
//long ll_rec
long ll_code

date ld_date

ld_date = date(em_1.text)

if not isdate(em_1.text) then
	messagebox("","Please enter valid date for search")
	return
end if
//if il_code < 1  then
if il_code =0  then //Modified by (Appeon)Harry 08.03.2016 for BugH072806--------
	messagebox("","Please select verification method for search")
	return
end if

dw_1.retrieve(ld_date,il_code)
//dw_pracaffil.settransobject(sqlca)
//ac = dw_pracaffil.retrieve()//a list of all active appointments
//
//for a = 1 to ac
//	ll_rec = dw_pracaffil.getitemnumber(a,"rec_id")
//	ll_prac = dw_pracaffil.getitemnumber(a,"prac_id")
//	li_fac = dw_pracaffil.getitemnumber(a,"parent_facility_id")
//	li_seq = dw_pracaffil.getitemnumber(a,"seq_no")
//	ldt_date = dw_pracaffil.getitemdatetime(a,"apptmnt_start_date")
//	dw_praccomm.settransobject(sqlca)
//	pc = dw_praccomm.retrieve(ll_rec)// a list of comms for the appnt
//	dw_facilcomm.settransobject(sqlca)
//	cc = dw_facilcomm.retrieve(li_fac)// a list of committees for the facil of the appnt.
//	for c = 1 to cc
//		comfind = 0
//		//messagebox("cc",cc)
//		ll_commid = dw_facilcomm.getitemnumber(c,"committee_id")
//		for p = 1 to pc
//			if ll_commid = dw_praccomm.getitemnumber(p,"committee_id") then 
//				comfind = 1
//			end if
//		next
//			if comfind = 0 then
//				nr = dw_praccomm.insertrow(0)
//				dw_praccomm.setitem(nr,"rec_id",ll_rec)
//				dw_praccomm.setitem(nr,"prac_id",ll_prac)
//				dw_praccomm.setitem(nr,"facility_id",li_fac)
//				dw_praccomm.setitem(nr,"seq_no",li_seq)
//				dw_praccomm.setitem(nr,"committee_id",ll_commid)
//				dw_praccomm.setitem(nr,"active_status",1)
//				dw_praccomm.setitem(nr,"date_sent_for_review", ldt_date )
//				dw_praccomm.setitem(nr,"date_back_from_review", ldt_date )
//				if not isnull(ldt_date) then
//					dw_praccomm.setitem(nr,"review_results", 615 )//approved	
//				end if
//				dw_praccomm.update()
//				commit using sqlca;
//			end if
//	next
//next
//			
//
//
//
//messagebox("Done"," Update Completed")
//
//
//
//
//
//
end event

type dw_1 from datawindow within w_utl_print_reset
integer x = 46
integer y = 244
integer width = 2482
integer height = 1856
integer taborder = 80
string dataobject = "d_utl_verif_reprint"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_4 from commandbutton within w_utl_print_reset
integer x = 2683
integer y = 196
integer width = 219
integer height = 108
integer taborder = 10
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

type cb_3 from commandbutton within w_utl_print_reset
integer x = 2171
integer y = 36
integer width = 352
integer height = 84
integer taborder = 20
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

type cb_1 from commandbutton within w_utl_print_reset
integer x = 1806
integer y = 36
integer width = 352
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

event clicked;messagebox("To operate this program :","Enter Printed Date. Select verification type.  Click find.  This will retrieve all verification matching those values.  Click reset to update the records to be reprintable.")
end event

