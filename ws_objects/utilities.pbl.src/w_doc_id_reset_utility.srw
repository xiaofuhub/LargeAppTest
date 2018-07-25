$PBExportHeader$w_doc_id_reset_utility.srw
forward
global type w_doc_id_reset_utility from window
end type
type cb_6 from commandbutton within w_doc_id_reset_utility
end type
type dw_print from datawindow within w_doc_id_reset_utility
end type
type cbx_1 from checkbox within w_doc_id_reset_utility
end type
type st_2 from statictext within w_doc_id_reset_utility
end type
type cb_5 from commandbutton within w_doc_id_reset_utility
end type
type st_1 from statictext within w_doc_id_reset_utility
end type
type dw_3 from datawindow within w_doc_id_reset_utility
end type
type dw_2 from datawindow within w_doc_id_reset_utility
end type
type dw_1 from datawindow within w_doc_id_reset_utility
end type
type cb_3 from commandbutton within w_doc_id_reset_utility
end type
type cb_2 from commandbutton within w_doc_id_reset_utility
end type
type cb_1 from commandbutton within w_doc_id_reset_utility
end type
end forward

global type w_doc_id_reset_utility from window
integer x = 123
integer y = 112
integer width = 2112
integer height = 1400
boolean titlebar = true
string title = "Reset doc_ids"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_6 cb_6
dw_print dw_print
cbx_1 cbx_1
st_2 st_2
cb_5 cb_5
st_1 st_1
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_doc_id_reset_utility w_doc_id_reset_utility

on w_doc_id_reset_utility.create
this.cb_6=create cb_6
this.dw_print=create dw_print
this.cbx_1=create cbx_1
this.st_2=create st_2
this.cb_5=create cb_5
this.st_1=create st_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_6,&
this.dw_print,&
this.cbx_1,&
this.st_2,&
this.cb_5,&
this.st_1,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_doc_id_reset_utility.destroy
destroy(this.cb_6)
destroy(this.dw_print)
destroy(this.cbx_1)
destroy(this.st_2)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
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
//	//MESSAGEBOX("","LOGIN OK")
//END IF

end event

event close;//disCONNECT USING SQLCA;
end event

type cb_6 from commandbutton within w_doc_id_reset_utility
integer x = 1746
integer y = 428
integer width = 297
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save List"
end type

event clicked;gnv_dw.of_SaveAs(dw_print)//.SaveAs() Modify by Evan 05.11.2010
ChangeDirectory(gs_current_path) //restore currentdirectory-Added by Nova 04.29.2008

end event

type dw_print from datawindow within w_doc_id_reset_utility
integer x = 1746
integer y = 440
integer width = 78
integer height = 52
integer taborder = 50
string dataobject = "d_doc_id_retr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_doc_id_reset_utility
integer x = 1330
integer y = 36
integer width = 384
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Active Only"
end type

event clicked;if this.checked = true then
	dw_1.setfilter("active_status = 1")
	dw_1.filter()
else
	dw_1.setfilter("")
	dw_1.filter()
end if
end event

type st_2 from statictext within w_doc_id_reset_utility
integer x = 1321
integer y = 432
integer width = 384
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
string text = "none"
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_doc_id_reset_utility
integer x = 1746
integer y = 332
integer width = 297
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Rerun"
end type

event clicked;long i
long ic
string doc
long rec
long prac
integer facil
Long ll_seq_no
integer r
string odoc

//dw_2.settransobject(sqlca)
//dw_3.settransobject(sqlca)
dw_1.reset()
for i = 1 to dw_3.rowcount()
	st_1.text = string(i)
	odoc = dw_3.getitemstring(i,"doc_id")
	dw_2.reset()
	dw_2.retrieve(odoc)
	//dw_1.rowscopy(i, i, primary!, dw_2,10, 	primary!)
	rec = dw_2.getitemnumber(1,"rec_id")
	prac = dw_2.getitemnumber(1,"prac_id")
	facil = dw_2.getitemnumber(1,"facility_id")
	ll_seq_no = dw_2.getitemnumber(1,"seq_no")
//	select max(seq_no) into :ll_seq_no from verif_info
//	where prac_id = :prac and rec_id = :rec and facility_id = :facil;
//	if isnull(ll_seq_no) or ll_seq_no < 1 then ll_seq_no = 0
//	ll_seq_no++
	//dw_2.setitem(1,"seq_no",ll_seq_no)
	doc = string(rec) + "-" + string(prac) + "-" + string(facil) + "-" + string(ll_seq_no)
	dw_2.setitem(1,"doc_id",doc)

	r = dw_2.update()
	if r < 1 then
		dw_2.rowscopy(1, 1, primary!, dw_1,1000000, 	primary!)
	else
		commit using sqlca;
	end if
	

next






end event

type st_1 from statictext within w_doc_id_reset_utility
integer x = 1321
integer y = 316
integer width = 384
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
string text = "none"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_doc_id_reset_utility
integer x = 1321
integer y = 548
integer width = 722
integer height = 612
integer taborder = 80
string dataobject = "d_doc_id_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_doc_id_reset_utility
integer x = 64
integer y = 548
integer width = 1216
integer height = 612
integer taborder = 60
string dataobject = "d_doc_id_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_doc_id_reset_utility
integer x = 55
integer y = 40
integer width = 1221
integer height = 472
integer taborder = 90
string dataobject = "d_doc_id_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_doc_id_reset_utility
integer x = 1746
integer y = 36
integer width = 297
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

type cb_2 from commandbutton within w_doc_id_reset_utility
integer x = 1746
integer y = 232
integer width = 297
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

event clicked;//Start Code Change ----12.10.2009 #V92 maha - rebuilt to eliminate the second retrieve entirely
long i
long ic
string doc
long rec
long prac
integer facil
Long ll_seq_no
integer r
string ls_odoc
long cnt = 0
integer res

dw_1.settransobject(sqlca)
dw_2.settransobject( sqlca)
dw_3.settransobject(sqlca)

dw_1.retrieve()

if cbx_1.checked = true then
	dw_1.setfilter("active_status = 1")
	dw_1.filter()
end if

for i = 1 to dw_1.rowcount()
	dw_2.reset()
	st_1.text = string(i)
	 res = dw_1.rowscopy(i, i, primary!, dw_2 ,1000, 	primary!)
	 if res < 1 then exit
	rec = dw_2.getitemnumber(1,"rec_id")
	prac = dw_2.getitemnumber(1,"prac_id")
	facil = dw_2.getitemnumber(1,"facility_id")
	ll_seq_no = dw_2.getitemnumber(1,"seq_no")
	ls_odoc= dw_2.getitemstring(1,"doc_id")
	doc = string(rec) + "-" + string(prac) + "-" + string(facil) + "-" + string(ll_seq_no)
	if ls_odoc <> doc then
		dw_2.setitem(1,"doc_id",doc)
		dw_2.rowscopy(1, 1, primary!, dw_print,1000000, 	primary!)
		cnt++
		st_2.text = string(cnt)
		r = dw_2.update()
		if r < 1 then //if an update failure, try resetting the ll_seq_no and update again.
			select max(seq_no) into :ll_seq_no from verif_info
			where prac_id = :prac and rec_id = :rec and facility_id = :facil;
			if isnull(ll_seq_no) or ll_seq_no < 1 then ll_seq_no = 0
			ll_seq_no++
			doc = string(rec) + "-" + string(prac) + "-" + string(facil) + "-" + string(ll_seq_no)
			dw_2.setitem(1,"doc_id",doc)
			r = dw_2.update()
			if r < 1 then //if it still fails copy it
				dw_2.rowscopy(1, 1, primary!, dw_3,1000000, 	primary!)
			end if
		else
			commit using sqlca;
		end if
	end if
next

//---------------------------- APPEON END ----------------------------

messagebox("","Complete")
cb_5.enabled = true


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.02.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Use d_doc_id_retr_for_pt to retrieve data from the database at one time instead 
//$<modification> of using d_doc_id_retr to retrieve data in a loop.
/*
long i
long ic
string doc
long rec
long prac
integer facil
Long ll_seq_no
integer r
string odoc
long cnt = 0

dw_1.settransobject(sqlca)
dw_1.retrieve()

if cbx_1.checked = true then
	dw_1.setfilter("active_status = 1")
	dw_1.filter()
end if

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

for i = 1 to dw_1.rowcount()
	st_1.text = string(i)
	odoc = dw_1.getitemstring(i,"doc_id")
	dw_2.reset()
	dw_2.retrieve(odoc)
	//dw_1.rowscopy(i, i, primary!, dw_2,10, 	primary!)
	rec = dw_2.getitemnumber(1,"rec_id")
	prac = dw_2.getitemnumber(1,"prac_id")
	facil = dw_2.getitemnumber(1,"facility_id")
	ll_seq_no = dw_2.getitemnumber(1,"seq_no")
	odoc = dw_2.getitemstring(1,"doc_id")
	doc = string(rec) + "-" + string(prac) + "-" + string(facil) + "-" + string(ll_seq_no)
	if odoc <> doc then
		dw_2.setitem(1,"doc_id",doc)
		dw_2.rowscopy(1, 1, primary!, dw_print,1000000, 	primary!)
		cnt++
		st_2.text = string(cnt)
		r = dw_2.update()
		if r < 1 then //if an update failure, try resetting the ll_seq_no and update again.
			select max(seq_no) into :ll_seq_no from verif_info
			where prac_id = :prac and rec_id = :rec and facility_id = :facil;
			if isnull(ll_seq_no) or ll_seq_no < 1 then ll_seq_no = 0
			ll_seq_no++
			doc = string(rec) + "-" + string(prac) + "-" + string(facil) + "-" + string(ll_seq_no)
			dw_2.setitem(1,"doc_id",doc)
			r = dw_2.update()
			if r < 1 then //if it still fails copy it
				dw_2.rowscopy(1, 1, primary!, dw_3,1000000, 	primary!)
			end if
		else
			commit using sqlca;
		end if
	end if
next
*/

//long i
//long ic
//string doc
//long rec
//long prac
//integer facil
//Long ll_seq_no
//integer r
//string odoc[]
//long cnt = 0
//
//dw_1.settransobject(sqlca)
//dw_2.dataobject = 'd_doc_id_retr_for_pt'
//dw_2.settransobject( sqlca)
//dw_3.settransobject(sqlca)
//
//dw_1.retrieve()
//
//for i = 1 to dw_1.rowcount()
//	odoc[i] = dw_1.getitemstring(i,"doc_id")
//next
//
//if upperbound(odoc) = 0 then
//	odoc[1] = ''
//end if
//
//dw_2.retrieve( odoc)
//
//if cbx_1.checked = true then
//	dw_1.setfilter("active_status = 1")
//	dw_1.filter()
//end if
//
//for i = 1 to dw_1.rowcount()
//	st_1.text = string(i)
//	dw_2.setfilter('doc_id = "'+ odoc[i] + '"')
//	dw_2.filter( )
//	rec = dw_2.getitemnumber(1,"rec_id")
//	prac = dw_2.getitemnumber(1,"prac_id")
//	facil = dw_2.getitemnumber(1,"facility_id")
//	ll_seq_no = dw_2.getitemnumber(1,"seq_no")
//	odoc[i] = dw_2.getitemstring(1,"doc_id")
//	doc = string(rec) + "-" + string(prac) + "-" + string(facil) + "-" + string(ll_seq_no)
//	if odoc[i] <> doc then
//		dw_2.setitem(1,"doc_id",doc)
//		dw_2.rowscopy(1, 1, primary!, dw_print,1000000, 	primary!)
//		cnt++
//		st_2.text = string(cnt)
//		r = dw_2.update()
//		if r < 1 then //if an update failure, try resetting the ll_seq_no and update again.
//			select max(seq_no) into :ll_seq_no from verif_info
//			where prac_id = :prac and rec_id = :rec and facility_id = :facil;
//			if isnull(ll_seq_no) or ll_seq_no < 1 then ll_seq_no = 0
//			ll_seq_no++
//			doc = string(rec) + "-" + string(prac) + "-" + string(facil) + "-" + string(ll_seq_no)
//			dw_2.setitem(1,"doc_id",doc)
//			r = dw_2.update()
//			if r < 1 then //if it still fails copy it
//				dw_2.rowscopy(1, 1, primary!, dw_3,1000000, 	primary!)
//			end if
//		else
//			commit using sqlca;
//		end if
//	end if
//next
//
////---------------------------- APPEON END ----------------------------
//
//messagebox("","Complete")
//cb_5.enabled = true





end event

type cb_1 from commandbutton within w_doc_id_reset_utility
integer x = 1746
integer y = 136
integer width = 297
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

event clicked;messagebox("To operate this program :","Click retrieve to get all verification records. Click run to check that the doc_id is consistant with the the four values that make it up.  Rerun retries and records that may have had an update error the first time around.")
end event

