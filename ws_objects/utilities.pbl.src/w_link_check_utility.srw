$PBExportHeader$w_link_check_utility.srw
forward
global type w_link_check_utility from window
end type
type cb_5 from commandbutton within w_link_check_utility
end type
type st_dup from statictext within w_link_check_utility
end type
type dw_link_dump from datawindow within w_link_check_utility
end type
type rb_adr from radiobutton within w_link_check_utility
end type
type st_recs from statictext within w_link_check_utility
end type
type st_5 from statictext within w_link_check_utility
end type
type st_4 from statictext within w_link_check_utility
end type
type st_3 from statictext within w_link_check_utility
end type
type rb_spec from radiobutton within w_link_check_utility
end type
type rb_hosp from radiobutton within w_link_check_utility
end type
type st_2 from statictext within w_link_check_utility
end type
type st_1 from statictext within w_link_check_utility
end type
type cb_6 from commandbutton within w_link_check_utility
end type
type dw_affil from datawindow within w_link_check_utility
end type
type dw_hlink from datawindow within w_link_check_utility
end type
type dw_hosp from datawindow within w_link_check_utility
end type
type cb_4 from commandbutton within w_link_check_utility
end type
type cb_3 from commandbutton within w_link_check_utility
end type
type cb_2 from commandbutton within w_link_check_utility
end type
type cb_1 from commandbutton within w_link_check_utility
end type
type cb_7 from commandbutton within w_link_check_utility
end type
type gb_1 from groupbox within w_link_check_utility
end type
end forward

global type w_link_check_utility from window
integer x = 123
integer y = 112
integer width = 2601
integer height = 460
boolean titlebar = true
string title = "Facility Link Check Utility"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_5 cb_5
st_dup st_dup
dw_link_dump dw_link_dump
rb_adr rb_adr
st_recs st_recs
st_5 st_5
st_4 st_4
st_3 st_3
rb_spec rb_spec
rb_hosp rb_hosp
st_2 st_2
st_1 st_1
cb_6 cb_6
dw_affil dw_affil
dw_hlink dw_hlink
dw_hosp dw_hosp
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_7 cb_7
gb_1 gb_1
end type
global w_link_check_utility w_link_check_utility

type variables
string is_dw = "S"
end variables

on w_link_check_utility.create
this.cb_5=create cb_5
this.st_dup=create st_dup
this.dw_link_dump=create dw_link_dump
this.rb_adr=create rb_adr
this.st_recs=create st_recs
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.rb_spec=create rb_spec
this.rb_hosp=create rb_hosp
this.st_2=create st_2
this.st_1=create st_1
this.cb_6=create cb_6
this.dw_affil=create dw_affil
this.dw_hlink=create dw_hlink
this.dw_hosp=create dw_hosp
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_7=create cb_7
this.gb_1=create gb_1
this.Control[]={this.cb_5,&
this.st_dup,&
this.dw_link_dump,&
this.rb_adr,&
this.st_recs,&
this.st_5,&
this.st_4,&
this.st_3,&
this.rb_spec,&
this.rb_hosp,&
this.st_2,&
this.st_1,&
this.cb_6,&
this.dw_affil,&
this.dw_hlink,&
this.dw_hosp,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_7,&
this.gb_1}
end on

on w_link_check_utility.destroy
destroy(this.cb_5)
destroy(this.st_dup)
destroy(this.dw_link_dump)
destroy(this.rb_adr)
destroy(this.st_recs)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.rb_spec)
destroy(this.rb_hosp)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_6)
destroy(this.dw_affil)
destroy(this.dw_hlink)
destroy(this.dw_hosp)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_7)
destroy(this.gb_1)
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

is_dw = "A"
end event

type cb_5 from commandbutton within w_link_check_utility
integer x = 41
integer y = 220
integer width = 526
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Duplicates"
end type

event clicked;long rc
long r
long runcnt

//st_4.text = "Deleted:"
r = messagebox("Clear duplicates","This function clears only address links that have been created with the wrong prac_id.  Continue?", question!,yesno!,1)
if r = 2 then return

dw_link_dump.dataobject = "d_links_bad_prac"
dw_link_dump.settransobject(sqlca)
rc = dw_link_dump.retrieve()
st_recs.text = string(rc)
for r = 1 to rc
	dw_link_dump.deleterow(1)	
		runcnt++	
next
		
dw_link_dump.update()
commit using sqlca;

messagebox("Done","Completed")
end event

type st_dup from statictext within w_link_check_utility
integer x = 1870
integer y = 176
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
string text = "none"
boolean focusrectangle = false
end type

type dw_link_dump from datawindow within w_link_check_utility
integer x = 55
integer y = 584
integer width = 1175
integer height = 428
integer taborder = 60
string dataobject = "d_hf_link"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_adr from radiobutton within w_link_check_utility
integer x = 631
integer y = 44
integer width = 443
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Address links"
boolean checked = true
end type

event clicked;is_dw = "A"
end event

type st_recs from statictext within w_link_check_utility
integer x = 1883
integer y = 56
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
string text = "none"
boolean focusrectangle = false
end type

type st_5 from statictext within w_link_check_utility
integer x = 1778
integer y = 56
integer width = 73
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
string text = "of"
boolean focusrectangle = false
end type

type st_4 from statictext within w_link_check_utility
integer x = 1221
integer y = 172
integer width = 210
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
string text = "Added:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_link_check_utility
integer x = 1216
integer y = 56
integer width = 233
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
string text = "Record:"
boolean focusrectangle = false
end type

type rb_spec from radiobutton within w_link_check_utility
integer x = 631
integer y = 180
integer width = 471
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Specialty links"
end type

event clicked;is_dw = "S"
end event

type rb_hosp from radiobutton within w_link_check_utility
integer x = 631
integer y = 112
integer width = 439
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Hospital links"
end type

event clicked;is_dw = "H"
end event

type st_2 from statictext within w_link_check_utility
integer x = 1481
integer y = 176
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
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within w_link_check_utility
integer x = 1490
integer y = 56
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
string text = "none"
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_link_check_utility
integer x = 1175
integer y = 1644
integer width = 247
integer height = 108
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "save"
end type

event clicked;//dw_addr_list.update()
commit using sqlca;
end event

type dw_affil from datawindow within w_link_check_utility
integer x = 1445
integer y = 484
integer width = 1115
integer height = 232
integer taborder = 110
string dataobject = "d_prac_affils"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hlink from datawindow within w_link_check_utility
integer x = 1339
integer y = 568
integer width = 1285
integer height = 284
integer taborder = 80
string dataobject = "d_sfup_link"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hosp from datawindow within w_link_check_utility
integer x = 73
integer y = 480
integer width = 1029
integer height = 188
integer taborder = 70
string dataobject = "d_all_specialties"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_link_check_utility
boolean visible = false
integer x = 2359
integer y = 296
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

type cb_3 from commandbutton within w_link_check_utility
integer x = 2222
integer y = 40
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

type cb_2 from commandbutton within w_link_check_utility
integer x = 41
integer y = 24
integer width = 526
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add missing links"
end type

event clicked;//Reconstructed for performance tuning - alfee 02.04.2010

Long rc, r, nr, runcnt
Long pracid, recid, facid, pracing

st_4.Text = "Added:"

Choose Case is_dw
	Case "S"
		dw_hosp.DataObject = "d_spec_for_link_chk"
		dw_hlink.DataObject = "d_sfup_link"
	Case "H"
		dw_hosp.DataObject = "d_hosp_for_link_chk"
		dw_hlink.DataObject = "d_hf_link_utl"
	Case "A"
		dw_hosp.DataObject = "d_addr_for_link_chk"
		dw_hlink.DataObject = "d_addr_link"
End Choose

dw_hlink.SetTransObject(sqlca)
dw_hosp.SetTransObject(sqlca)

rc = dw_hosp.Retrieve()
st_recs.Text = String(rc)

For r = 1 To rc //for each unlinked record
	pracid = dw_hosp.GetItemNumber(r,"prac_id")
	recid = dw_hosp.GetItemNumber(r,"rec_id")
	facid = dw_hosp.GetItemNumber(r,"facility_id")
	If is_dw = "S" Then
		pracing = dw_hosp.GetItemNumber(r,"practicing")
		If IsNull(pracing) Then pracing = 581
	ElseIf is_dw = "H" Then
		pracing = dw_hosp.GetItemNumber(r,"primary")
	ElseIf is_dw = "A" Then 
		pracing = 0
	End If
	
	runcnt++
	nr = dw_hlink.InsertRow(0)
	dw_hlink.SetItem(nr,"rec_id",recid)
	dw_hlink.SetItem(nr,"facility_id",facid)
	dw_hlink.SetItem(nr,"p_set",pracing)
	dw_hlink.SetItem(nr,"prac_id",pracid)
	If is_dw = "A" Then
		dw_hlink.SetItem(nr,"billing",pracing)
		dw_hlink.SetItem(nr,"home_address",0)
		dw_hlink.SetItem(nr,"primary_office",0)
		dw_hlink.SetItem(nr,"additional_office",0)
		dw_hlink.SetItem(nr,"exp_letters",0)
		dw_hlink.SetItem(nr,"include_in_directory",0)
	End If

	st_1.Text = String(r)
	st_2.Text = String(runcnt)
Next

If dw_hlink.Update() = 1 Then
	Commit Using sqlca;
	MessageBox("Done","Completed")
Else
	Rollback Using sqlca;
	MessageBox("Error","Failed to update")
End If



//Long rc
//long r
//long nr
//long f
//long fc
//long fac[]
//Long rec[]
//long recid
//Long spec
//Long prac[]
//long pracid
//Long pracing
//Long runcnt = 0
//long p
//Long pc
//long s
//Long sc
//Long ll_rowcount
//long t
//string filt
//long hc
//
//st_4.Text = "Added:"
//
//Choose Case is_dw
//	Case "S"
//		dw_hosp.DataObject = "d_all_specialties"
//		dw_hlink.DataObject = "d_sfup_link"
//	Case "H"
//		dw_hosp.DataObject = "d_all_hosp_affil_utl"
//		dw_hlink.DataObject = "d_hf_link_utl"
//	Case "A"
//		dw_hosp.DataObject = "d_addr_all_for_link_chk"
//		dw_hlink.DataObject = "d_addr_link"
//End Choose
//
//dw_hlink.SetTransObject(sqlca)
//dw_hosp.SetTransObject(sqlca)
//
//rc = dw_hosp.Retrieve()
//
//datastore lds_affil,lds_specialty,lds_hosp_affil,lds_address
//string ls_sql_syntax,ls_err,ls_dw
//
//lds_affil=create datastore
//lds_specialty=create datastore
//lds_hosp_affil=create datastore
//lds_address=create datastore
////Start Code Change ---- 03.22.2007 #V7 maha -- changed dataobjects because when the data was being retrieved, it locked up larger systems
////lds_affil.dataobject='d_prac_affils_for_pt'
//lds_affil.dataobject='d_affil_all_for_link_utl'
//lds_affil.settransobject(sqlca)
////lds_specialty.dataobject='d_spec_for_pt'
//lds_specialty.dataobject='d_sf_link_all'
//lds_specialty.settransobject(sqlca)
////lds_hosp_affil.dataobject='d_hosp_for_pt'
//lds_hosp_affil.dataobject = 'd_hf_link_utl_all'
//lds_hosp_affil.settransobject(sqlca)
////lds_address.dataobject='d_addr_for_pt'
//lds_address.dataobject='d_addr_link_all'
//lds_address.settransobject(sqlca)
//
////For r = 1 To rc //gets all prac ids for the data table// removed getting individual below
////	prac[r] = dw_hosp.GetItemNumber(r,"prac_id")
////	rec[r] = dw_hosp.GetItemNumber(r,"rec_id")
////next
////if upperbound(prac) = 0 then
////	prac[1] = 0
////end if
////if upperbound(rec) = 0 then
////	rec[1] = 0
////end if
//
//lds_affil.retrieve() // retreives all affil stat records connected to all the data records
////lds_affil.retrieve(prac) 
////End Code Change---03.22.2007
//
////ll_rowcount = lds_affil.rowcount( )
////for f = 1 to ll_rowcount
////	fac[f] = lds_affil.GetItemNumber(f,"parent_facility_id")
////next
////if upperbound(fac) = 0 then
////	fac[1] = 0
////end if
//
//gnv_appeondb.of_startqueue( )
////Start Code Change ---- 03.20.2007 #V7 maha  not necessary to retrieve links for all screens at once
//Choose Case is_dw
//	Case "S"
//		//lds_specialty.retrieve(rec, fac)
//		lds_specialty.retrieve()
//	Case "H"
//		//lds_specialty.retrieve(rec, fac)
//		lds_hosp_affil.retrieve()  ////Start Code Change ---- 12.20.2007 #V8 maha -- corrected to proper ds
//	Case "A"
//		//lds_address.retrieve(rec, fac)
//		lds_address.retrieve()
//end choose
////End Code Change---03.20.2007
//
//gnv_appeondb.of_commitqueue( )
//
//st_recs.Text = String(rc)
//For r = 1 To rc //for each cred data record
//	pracid = dw_hosp.GetItemNumber(r,"prac_id")
//	recid = dw_hosp.GetItemNumber(r,"rec_id")
//	t = lds_affil.setfilter('prac_id = ' + string(pracid))
//	lds_affil.filter( )
//	fc = lds_affil.rowcount( )
//	if pracid = 2 then debugbreak()
//	For f = 1 To fc
//		fac[f] = lds_affil.GetItemNumber(f,"parent_facility_id")
//		//messagebox("sc",sc)
//		Choose Case is_dw
//			Case "S"
//				//sc = lds_specialty.find('specialty_id = ' + string(rec[r]) + ' and facility_id = ' + string(fac[f]), 1, lds_specialty.rowcount( ))
//				sc = lds_specialty.find('rec_id = ' + string(recid) + ' and facility_id = ' + string(fac[f]), 1, lds_specialty.rowcount( ))  //Start Code Change ---- 12.20.2007 #V8 maha -- corrected filter
//			Case "H"
//				filt = 'rec_id = ' + string(recid) + ' and facility_id = ' + string(fac[f])
//				//sc = lds_hosp_affil.find('hosp_affil_id = ' + string(rec[r]) + ' and facility_id = ' + string(fac[f]), 1, lds_hosp_affil.rowcount( ))	
//				sc = lds_hosp_affil.find(filt, 1, lds_hosp_affil.rowcount( )) //Start Code Change ---- 12.20.2007 #V8 maha
//			Case "A"
//				//sc = lds_address.find('address_id = ' + string(rec[r]) + ' and facility_id = ' + string(fac[f]), 1, lds_address.rowcount( ))
//				sc = lds_address.find('address_id = ' + string(recid) + ' and facility_id = ' + string(fac[f]), 1, lds_address.rowcount( ))
//		End Choose
//		//messagebox("sc",sc)
//		If sc = 0 Then
//			If is_dw = "S" Then
//				pracing = dw_hosp.GetItemNumber(r,"practicing")
//				If IsNull(pracing) Then pracing = 581
//			ElseIf is_dw = "H" Then
//				pracing = dw_hosp.GetItemNumber(r,"primary")
//				//if isnull(pracing) then setnull(pracing) 
//			ElseIf is_dw = "A" Then //will be used for address update
//				pracing = 0
//			End If
//			runcnt++
//			nr = dw_hlink.InsertRow(0)
//			dw_hlink.SetItem(nr,"rec_id",recid)
//			dw_hlink.SetItem(nr,"facility_id",fac[f])
//			dw_hlink.SetItem(nr,"p_set",pracing)
//			dw_hlink.SetItem(nr,"prac_id",pracid)
//			If is_dw = "A" Then
//				dw_hlink.SetItem(nr,"billing",pracing)
//				dw_hlink.SetItem(nr,"home_address",0)
//				dw_hlink.SetItem(nr,"primary_office",0)
//				dw_hlink.SetItem(nr,"additional_office",0)
//				dw_hlink.SetItem(nr,"exp_letters",0)
//				dw_hlink.SetItem(nr,"include_in_directory",0)
//			End If
//		End If
//	Next
//	//messagebox("prac",prac)
//	//messagebox("r",r)
//	st_1.Text = String(r)
//	st_2.Text = String(runcnt)
//Next
//
//gnv_appeondb.of_startqueue( )
//
//dw_hlink.Update()
//Commit Using sqlca;
//	
//gnv_appeondb.of_commitqueue( )
//
//destroy lds_affil
//destroy lds_specialty
//destroy lds_hosp_affil
//destroy lds_address
////---------------------------- APPEON END ----------------------------
//
////next
////581 = yes
//MessageBox("Done","Completed")
//
////		dw_hosp.SetRedraw(FALSE)
////		dw_hlink.SetRedraw(FALSE)

end event

type cb_1 from commandbutton within w_link_check_utility
integer x = 2226
integer y = 164
integer width = 265
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("To operate", "Select data screen.  Add will check all addresses for facility links to each of the practitioners facilities. ~rDelete will check all links and remove ones that no longer belong.")
end event

type cb_7 from commandbutton within w_link_check_utility
integer x = 41
integer y = 120
integer width = 526
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Dump bad links"
end type

event clicked;//reconstructed by alfee 10.18.2010

Long rc, r, ll_parent_facility
Long runcnt, ecnt, ll_rec_id_cnt

SetPointer(hourglass!)

Choose Case is_dw
	Case "A"
		dw_link_dump.DataObject = "d_link_fix_addr"
	Case "H"
		dw_link_dump.DataObject = "d_link_fix_hf"
	Case "S"
		dw_link_dump.DataObject = "d_link_fix_sf"
End Choose

dw_link_dump.SetTransObject(sqlca)
rc = dw_link_dump.Retrieve()

st_4.Text = "Deleted:"
st_recs.Text = String(rc)

For r = rc To 1 Step -1
	ll_parent_facility = dw_link_dump.GetItemNumber(r, "parent_facility_id")
	If IsNull(ll_parent_facility)  Then //
		dw_link_dump.DeleteRow(r)
		runcnt++
	Else
		ll_rec_id_cnt = dw_link_dump.Getitemnumber(r,"rec_id_cnt")
		If ll_rec_id_cnt > 1 Then ecnt++
	End If
	st_1.Text = String(r)
	st_2.Text = String(runcnt)
	st_dup.Text = String(ecnt)
Next

gnv_appeondb.of_startqueue( )
dw_link_dump.Update()
Commit Using sqlca;
gnv_appeondb.of_commitqueue( )

MessageBox("Done","Completed")


////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-02
////$<modify> 02.24.2006 By: owen chen
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
///*
//Long rc
//Integer r
//Integer nr
//Integer f
//Integer fc
//Integer fac
//Long rec
//Long spec
//Long prac
//Long pracing
//Long runcnt = 0
//Integer p
//Long pc
//Integer s
//Long sc
//Integer ecnt = 0
//
//st_4.Text = "Deleted:"
//
//Choose Case is_dw
//	Case "S"
//		dw_link_dump.DataObject = "d_sf_link_all"
//		
//	Case "H"
//		dw_link_dump.DataObject = "d_hf_link_utl_all"
//		
//	Case "A"
//		dw_link_dump.DataObject = "d_addr_link_all"
//End Choose
//
////dw_prac.settransobject(sqlca)
////pc = dw_prac.retrieve()
////
////
////for p = 1 to pc
////	prac = dw_prac.getitemnumber(p,"prac_id")
////dw_hlink.settransobject(sqlca)
//dw_link_dump.SetTransObject(sqlca)
//rc = dw_link_dump.Retrieve()
//st_recs.Text = String(rc)
//For r = rc To 1 Step -1
//	//rec = dw_link_dump.getitemnumber(r,"rec_id")
//	prac = dw_link_dump.GetItemNumber(r,"prac_id")
//	fac = dw_link_dump.GetItemNumber(r,"facility_id")
//	//dw_hlink.settransobject(sqlca)
//	//sc = dw_hlink.retrieve(rec)
//	//messagebox("sc",sc)
//	//messagebox("r",r)
//	Select count(rec_id) Into :sc From pd_affil_stat Where prac_id = :prac And parent_facility_id = :fac;
//	If sc = 0 Then
//		dw_link_dump.DeleteRow(r)
//		runcnt++
//	ElseIf sc > 1 Then
//		ecnt++
//	End If
//	//messagebox("r",r)
//	st_1.Text = String(r)
//	st_2.Text = String(runcnt)
//	st_dup.Text = String(ecnt)
//Next
////next
//dw_link_dump.Update()
//Commit Using sqlca;
//*/
//Long rc
//long r
//long nr
//long f
//long fc
//long fac[]
//long rec
//Long spec
//Long prac[]
//Long pracing
//Long runcnt = 0
//long p
//Long pc
//long s
//Long sc
//long ac
//long ecnt = 0
//
//st_4.Text = "Deleted:"
//
//Choose Case is_dw
//	Case "S"
//		dw_link_dump.DataObject = "d_sf_link_all"
//		
//	Case "H"
//		dw_link_dump.DataObject = "d_hf_link_utl_all"
//		
//	Case "A"
//		dw_link_dump.DataObject = "d_addr_link_all"
//End Choose
//
//dw_link_dump.SetTransObject(sqlca)
//rc = dw_link_dump.Retrieve()
//
//datastore lds_affil_stat
//lds_affil_stat = create datastore
//lds_affil_stat.dataobject='d_affil_stat_for_pt'
//
//lds_affil_stat.settransobject( sqlca )
//ac = lds_affil_stat.retrieve( )
//
//if gi_test_mode = 1 then
//	messagebox("Prac records",ac)
//end if
//
//For r = rc To 1 Step -1
//	prac[r] = dw_link_dump.GetItemNumber(r,"prac_id")
//	fac[r] = dw_link_dump.GetItemNumber(r,"facility_id")
//next
//
//if upperbound(prac) = 0 then 
//	prac[1] = 0
//end if
//if upperbound(fac) = 0 then 
//	fac[1] = 0
//end if
//
//lds_affil_stat.retrieve(prac, fac)
//
//st_recs.Text = String(rc)
//For r = rc To 1 Step -1
//	sc = lds_affil_stat.find('prac_id = ' + string(prac[r]) + ' and parent_facility_id = ' + string(fac[r]), 1, lds_affil_stat.rowcount())
//	if gi_test_mode = 1 then
//		messagebox("Filter test",ac)
//		gi_test_mode = 0
//	end if
//	If sc = 0 Then
//		dw_link_dump.DeleteRow(r)
//		runcnt++
//	Else
//		sc = lds_affil_stat.Getitemnumber(sc,"rec_id_cnt")
//		If sc > 1 Then
//			ecnt++
//		End If
//	End If
//	st_1.Text = String(r)
//	st_2.Text = String(runcnt)
//	st_dup.Text = String(ecnt)
//Next
//
//gnv_appeondb.of_startqueue( )
//
//dw_link_dump.Update()
//Commit Using sqlca;
//
//gnv_appeondb.of_commitqueue( )
//destroy lds_affil_stat
////---------------------------- APPEON END ----------------------------
//
//MessageBox("Done","Completed")
//
//
//
end event

type gb_1 from groupbox within w_link_check_utility
integer x = 608
integer width = 521
integer height = 304
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "For:"
end type

