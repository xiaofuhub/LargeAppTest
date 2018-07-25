$PBExportHeader$w_prac_link_check.srw
forward
global type w_prac_link_check from window
end type
type cbx_spec from checkbox within w_prac_link_check
end type
type cbx_hosp from checkbox within w_prac_link_check
end type
type cbx_addr from checkbox within w_prac_link_check
end type
type st_dup from statictext within w_prac_link_check
end type
type dw_link_dump from datawindow within w_prac_link_check
end type
type st_recs from statictext within w_prac_link_check
end type
type st_5 from statictext within w_prac_link_check
end type
type st_4 from statictext within w_prac_link_check
end type
type st_3 from statictext within w_prac_link_check
end type
type st_2 from statictext within w_prac_link_check
end type
type st_1 from statictext within w_prac_link_check
end type
type cb_6 from commandbutton within w_prac_link_check
end type
type dw_affil from datawindow within w_prac_link_check
end type
type dw_hlink from datawindow within w_prac_link_check
end type
type dw_hosp from datawindow within w_prac_link_check
end type
type cb_3 from commandbutton within w_prac_link_check
end type
type cb_2 from commandbutton within w_prac_link_check
end type
type gb_1 from groupbox within w_prac_link_check
end type
end forward

global type w_prac_link_check from window
integer x = 123
integer y = 112
integer width = 782
integer height = 732
boolean titlebar = true
string title = "Check Link Records"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
boolean center = true
cbx_spec cbx_spec
cbx_hosp cbx_hosp
cbx_addr cbx_addr
st_dup st_dup
dw_link_dump dw_link_dump
st_recs st_recs
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_6 cb_6
dw_affil dw_affil
dw_hlink dw_hlink
dw_hosp dw_hosp
cb_3 cb_3
cb_2 cb_2
gb_1 gb_1
end type
global w_prac_link_check w_prac_link_check

type variables
string is_dw = "S"
long il_prac
end variables

on w_prac_link_check.create
this.cbx_spec=create cbx_spec
this.cbx_hosp=create cbx_hosp
this.cbx_addr=create cbx_addr
this.st_dup=create st_dup
this.dw_link_dump=create dw_link_dump
this.st_recs=create st_recs
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_6=create cb_6
this.dw_affil=create dw_affil
this.dw_hlink=create dw_hlink
this.dw_hosp=create dw_hosp
this.cb_3=create cb_3
this.cb_2=create cb_2
this.gb_1=create gb_1
this.Control[]={this.cbx_spec,&
this.cbx_hosp,&
this.cbx_addr,&
this.st_dup,&
this.dw_link_dump,&
this.st_recs,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_6,&
this.dw_affil,&
this.dw_hlink,&
this.dw_hosp,&
this.cb_3,&
this.cb_2,&
this.gb_1}
end on

on w_prac_link_check.destroy
destroy(this.cbx_spec)
destroy(this.cbx_hosp)
destroy(this.cbx_addr)
destroy(this.st_dup)
destroy(this.dw_link_dump)
destroy(this.st_recs)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_6)
destroy(this.dw_affil)
destroy(this.dw_hlink)
destroy(this.dw_hosp)
destroy(this.cb_3)
destroy(this.cb_2)
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

il_prac = message.doubleparm
end event

type cbx_spec from checkbox within w_prac_link_check
integer x = 91
integer y = 224
integer width = 471
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "Specialty links"
boolean checked = true
end type

type cbx_hosp from checkbox within w_prac_link_check
integer x = 96
integer y = 152
integer width = 439
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "Hospital links"
boolean checked = true
end type

type cbx_addr from checkbox within w_prac_link_check
integer x = 96
integer y = 76
integer width = 443
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "Address links"
boolean checked = true
end type

type st_dup from statictext within w_prac_link_check
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
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type dw_link_dump from datawindow within w_prac_link_check
integer x = 55
integer y = 1040
integer width = 1175
integer height = 428
integer taborder = 60
string dataobject = "d_hf_link"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_recs from statictext within w_prac_link_check
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
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type st_5 from statictext within w_prac_link_check
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
long backcolor = 67108864
boolean enabled = false
string text = "of"
boolean focusrectangle = false
end type

type st_4 from statictext within w_prac_link_check
integer x = 32
integer y = 364
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
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_prac_link_check
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
long backcolor = 67108864
boolean enabled = false
string text = "Record:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_prac_link_check
integer x = 261
integer y = 364
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

type st_1 from statictext within w_prac_link_check
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
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_prac_link_check
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

type dw_affil from datawindow within w_prac_link_check
integer x = 1445
integer y = 940
integer width = 1115
integer height = 232
integer taborder = 110
string dataobject = "d_prac_affils"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hlink from datawindow within w_prac_link_check
integer x = 1339
integer y = 1024
integer width = 1285
integer height = 284
integer taborder = 80
string dataobject = "d_sfup_link"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hosp from datawindow within w_prac_link_check
integer x = 73
integer y = 936
integer width = 1029
integer height = 188
integer taborder = 70
string dataobject = "d_all_specialties"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_prac_link_check
integer x = 389
integer y = 460
integer width = 274
integer height = 84
integer taborder = 30
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

type cb_2 from commandbutton within w_prac_link_check
integer x = 64
integer y = 460
integer width = 274
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

event clicked;Long rc
Integer r
Integer nr
Integer f
Integer fc
Integer facid
Long recid
Long spec
Long prac[]
Long pracing
Long runcnt = 0
Integer p
integer u
integer lc
integer ac
integer a
Long pc
Integer s
Long sc
Long ll_rowcount
string findfield

st_4.Text = "Added:"


dw_affil.settransobject(sqlca)
ac = dw_affil.retrieve(il_prac)

For u = 1 to 3
	Choose Case u
		Case 1
			if cbx_addr.checked then
				dw_hosp.DataObject = "d_addresses_for_prac"
				dw_hlink.DataObject = "d_addr_link_prac"
				findfield = "rec_id"
				pracing = 0
			else
				continue
			end if
		Case 2
			if cbx_hosp.checked then
				dw_hosp.DataObject = "d_hosp_for_prac"
				dw_hlink.DataObject = "d_hf_link_prac"
				findfield = "rec_id"
				pracing = 581
			else
				continue
			end if	
		Case 3
			if cbx_spec.checked then
				dw_hosp.DataObject = "d_spec_for_prac"
				dw_hlink.DataObject = "d_spec_link_prac"
				findfield = "rec_id"
				pracing = 581
			else
				continue
			end if
	End Choose

	dw_hlink.SetTransObject(sqlca)
	dw_hosp.SetTransObject(sqlca)
	
	rc = dw_hosp.Retrieve(il_prac)
	lc = dw_hlink.Retrieve(il_prac)


	For r = 1 To rc
		recid = dw_hosp.GetItemNumber(r,"rec_id")
		for a = 1 to ac
			facid = dw_affil.getitemnumber(a,"parent_facility_id")
			f = dw_hlink.find( findfield + " = " + string(recid) + " and  facility_id = " + string(facid),1, lc)
			if f < 0 then
				messagebox("","Program error")
				return
			elseif f > 0 then
				continue
			else  //create link record
				runcnt++
				nr = dw_hlink.InsertRow(0)
				dw_hlink.SetItem(nr,"rec_id",recid)
				dw_hlink.SetItem(nr,"facility_id",facid)
				dw_hlink.SetItem(nr,"p_set",pracing)
				dw_hlink.SetItem(nr,"prac_id",il_prac)
				If u = 1 Then //addresses
					dw_hlink.SetItem(nr,"billing",0)
					dw_hlink.SetItem(nr,"home_address",0)
					dw_hlink.SetItem(nr,"primary_office",0)
					dw_hlink.SetItem(nr,"additional_office",0)
					dw_hlink.SetItem(nr,"exp_letters",0)
					dw_hlink.SetItem(nr,"include_in_directory",0)
				End If
			end if
		next //facility record
	Next //data record
	
	dw_hlink.Update()
	Commit Using sqlca;

	st_2.Text = String(runcnt)
Next

MessageBox("Done","Completed")


end event

type gb_1 from groupbox within w_prac_link_check
integer x = 41
integer y = 24
integer width = 640
integer height = 312
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

