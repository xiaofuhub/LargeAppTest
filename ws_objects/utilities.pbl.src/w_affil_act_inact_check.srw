$PBExportHeader$w_affil_act_inact_check.srw
forward
global type w_affil_act_inact_check from window
end type
type dw_dupe_names from datawindow within w_affil_act_inact_check
end type
type cb_dupes from commandbutton within w_affil_act_inact_check
end type
type dw_dupe_list from datawindow within w_affil_act_inact_check
end type
type st_2 from statictext within w_affil_act_inact_check
end type
type st_1 from statictext within w_affil_act_inact_check
end type
type cb_6 from commandbutton within w_affil_act_inact_check
end type
type sle_1 from singlelineedit within w_affil_act_inact_check
end type
type dw_4 from datawindow within w_affil_act_inact_check
end type
type dw_imp from datawindow within w_affil_act_inact_check
end type
type dw_addr_list from datawindow within w_affil_act_inact_check
end type
type cb_3 from commandbutton within w_affil_act_inact_check
end type
type cb_2 from commandbutton within w_affil_act_inact_check
end type
type cb_1 from commandbutton within w_affil_act_inact_check
end type
end forward

global type w_affil_act_inact_check from window
integer x = 690
integer y = 904
integer width = 2491
integer height = 448
boolean titlebar = true
string title = "Check Affil Stat for abberant actives "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
dw_dupe_names dw_dupe_names
cb_dupes cb_dupes
dw_dupe_list dw_dupe_list
st_2 st_2
st_1 st_1
cb_6 cb_6
sle_1 sle_1
dw_4 dw_4
dw_imp dw_imp
dw_addr_list dw_addr_list
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_affil_act_inact_check w_affil_act_inact_check

on w_affil_act_inact_check.create
this.dw_dupe_names=create dw_dupe_names
this.cb_dupes=create cb_dupes
this.dw_dupe_list=create dw_dupe_list
this.st_2=create st_2
this.st_1=create st_1
this.cb_6=create cb_6
this.sle_1=create sle_1
this.dw_4=create dw_4
this.dw_imp=create dw_imp
this.dw_addr_list=create dw_addr_list
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_dupe_names,&
this.cb_dupes,&
this.dw_dupe_list,&
this.st_2,&
this.st_1,&
this.cb_6,&
this.sle_1,&
this.dw_4,&
this.dw_imp,&
this.dw_addr_list,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_affil_act_inact_check.destroy
destroy(this.dw_dupe_names)
destroy(this.cb_dupes)
destroy(this.dw_dupe_list)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_6)
destroy(this.sle_1)
destroy(this.dw_4)
destroy(this.dw_imp)
destroy(this.dw_addr_list)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;SQLCA.DBMS="ODBC"
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
	MESSAGEBOX("","LOGIN OK")
END IF
end event

event close;disCONNECT USING SQLCA;
end event

type dw_dupe_names from datawindow within w_affil_act_inact_check
integer x = 997
integer y = 824
integer width = 955
integer height = 316
integer taborder = 60
string dataobject = "d_affil_stat_active_for_prac"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_dupes from commandbutton within w_affil_act_inact_check
integer x = 1413
integer y = 36
integer width = 635
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "List of mult active affils"
end type

event clicked;integer a
integer ac
integer i
integer ic
integer p
long recid
long facil
long prac
integer pc
string pcn
string ls_st2
string ls_city
string ls_zip
string ls_arch
string ls_id
integer ck1 = 0
integer ck2 = 0



dw_dupe_list.settransobject(sqlca)
dw_addr_list.settransobject(sqlca)
pc = dw_addr_list.retrieve()
st_2.text = string(pc)
for p = 1 to pc
	st_1.text = string(p)
	prac = dw_addr_list.getitemnumber(p,"prac_id")
	facil = dw_addr_list.getitemnumber(p,"parent_facility_id")
		
	dw_dupe_list.settransobject(sqlca)
	ic = dw_dupe_list.retrieve(prac,facil)
	
	if ic > 1 then
		
			dw_dupe_list.RowsCopy (1, 1,primary!, dw_dupe_names, 5000, primary! )
			ck2++
			sle_1.text = string(ck2)

	end if
	
//	update pd_affil_stat
//	set active_status = 0 
//	where active_status = 3 and prac_id = :prac and parent_facility_id = :facil;
	
next
gnv_dw.of_SaveAs(dw_dupe_names)//.saveas() Modify by Evan 05.11.2010
//--------Begin Added by Nova 04.29.2008------------------------
ChangeDirectory(gs_current_path)//restore currentdirectory
//--------End Added --------------------------------------------------	

end event

type dw_dupe_list from datawindow within w_affil_act_inact_check
integer x = 1033
integer y = 552
integer width = 882
integer height = 248
integer taborder = 90
string dataobject = "d_affil_stat_active_for_prac"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_affil_act_inact_check
integer x = 827
integer y = 132
integer width = 197
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
boolean focusrectangle = false
end type

type st_1 from statictext within w_affil_act_inact_check
integer x = 827
integer y = 36
integer width = 192
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
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_affil_act_inact_check
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

event clicked;dw_imp.update()
commit using sqlca;
end event

type sle_1 from singlelineedit within w_affil_act_inact_check
integer x = 1088
integer y = 36
integer width = 247
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_affil_act_inact_check
integer x = 2830
integer y = 1624
integer width = 494
integer height = 108
integer taborder = 110
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_imp from datawindow within w_affil_act_inact_check
integer x = 613
integer y = 440
integer width = 882
integer height = 248
integer taborder = 80
string dataobject = "d_affil_stat_inactive_for_prac"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_addr_list from datawindow within w_affil_act_inact_check
integer x = 78
integer y = 436
integer width = 503
integer height = 636
integer taborder = 70
string dataobject = "d_affil_stat_all_active"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_affil_act_inact_check
integer x = 2103
integer y = 36
integer width = 274
integer height = 84
integer taborder = 40
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

type cb_2 from commandbutton within w_affil_act_inact_check
integer x = 46
integer y = 36
integer width = 695
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Check active/inactives"
end type

event clicked;integer a
integer ac
integer i
integer ic
integer p
long recid
long facil
long prac
integer pc
string pcn
string ls_st2
string ls_city
string ls_zip
string ls_arch
string ls_id
integer ck1 = 0
integer ck2 = 0



dw_imp.settransobject(sqlca)
dw_addr_list.settransobject(sqlca)
pc = dw_addr_list.retrieve()
st_2.text = string(pc)
for p = 1 to pc
	st_1.text = string(p)
	prac = dw_addr_list.getitemnumber(p,"prac_id")
	facil = dw_addr_list.getitemnumber(p,"parent_facility_id")
		
	dw_imp.settransobject(sqlca)
	ic = dw_imp.retrieve(prac,facil)
	
	if ic > 0 then
		for i = 1 to ic
			dw_imp.setitem(i,"active_status",0)
			ck2++
			sle_1.text = string(ck2)
		next
		dw_imp.update()
		commit using sqlca;
	end if
	
//	update pd_affil_stat
//	set active_status = 0 
//	where active_status = 3 and prac_id = :prac and parent_facility_id = :facil;
	
next

end event

type cb_1 from commandbutton within w_affil_act_inact_check
integer x = 2103
integer y = 140
integer width = 274
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Will check for appt stat records that have both active and inactiverecords, and change the inactive to history. ~rMulti active will create a list of practitioners with multiple active associations which can be saved as a file for future reference. ")
end event

