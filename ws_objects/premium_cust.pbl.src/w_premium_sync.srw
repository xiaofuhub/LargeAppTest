$PBExportHeader$w_premium_sync.srw
forward
global type w_premium_sync from window
end type
type dw_comp_copy from datawindow within w_premium_sync
end type
type cb_copy_comp from commandbutton within w_premium_sync
end type
type cb_savecomp from commandbutton within w_premium_sync
end type
type dw_comp from datawindow within w_premium_sync
end type
type cb_1 from commandbutton within w_premium_sync
end type
type st_prog from statictext within w_premium_sync
end type
type gb_4 from groupbox within w_premium_sync
end type
type gb_1 from groupbox within w_premium_sync
end type
type dw_sys_fields_to from datawindow within w_premium_sync
end type
type dw_sys_tables_to from datawindow within w_premium_sync
end type
type dw_object_to from datawindow within w_premium_sync
end type
type dw_fields_to from datawindow within w_premium_sync
end type
type dw_screen_to from datawindow within w_premium_sync
end type
type dw_sys_fields_from from datawindow within w_premium_sync
end type
type dw_sys_tables_from from datawindow within w_premium_sync
end type
type dw_fields_from from datawindow within w_premium_sync
end type
type dw_screen_from from datawindow within w_premium_sync
end type
type dw_object_from from datawindow within w_premium_sync
end type
type dw_sync_note_2 from datawindow within w_premium_sync
end type
type dw_sync_note_1 from datawindow within w_premium_sync
end type
type cb_import from commandbutton within w_premium_sync
end type
type cb_close from commandbutton within w_premium_sync
end type
type cb_save from commandbutton within w_premium_sync
end type
type dw_screen_notes from datawindow within w_premium_sync
end type
type dw_screens from datawindow within w_premium_sync
end type
type cb_lookups from commandbutton within w_premium_sync
end type
type cb_copy_notes from commandbutton within w_premium_sync
end type
type dw_view_select from datawindow within w_premium_sync
end type
type cb_views from commandbutton within w_premium_sync
end type
type gb_2 from groupbox within w_premium_sync
end type
type r_1 from rectangle within w_premium_sync
end type
type r_blue from rectangle within w_premium_sync
end type
type gb_3 from groupbox within w_premium_sync
end type
type dw_code_prem from datawindow within w_premium_sync
end type
type dw_addr_prem from datawindow within w_premium_sync
end type
type dw_addr_icred from datawindow within w_premium_sync
end type
type dw_code_icred from datawindow within w_premium_sync
end type
type dw_delete from datawindow within w_premium_sync
end type
end forward

global type w_premium_sync from window
integer x = 187
integer y = 32
integer width = 2985
integer height = 2152
boolean titlebar = true
string title = "MIIP Utilities"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
dw_comp_copy dw_comp_copy
cb_copy_comp cb_copy_comp
cb_savecomp cb_savecomp
dw_comp dw_comp
cb_1 cb_1
st_prog st_prog
gb_4 gb_4
gb_1 gb_1
dw_sys_fields_to dw_sys_fields_to
dw_sys_tables_to dw_sys_tables_to
dw_object_to dw_object_to
dw_fields_to dw_fields_to
dw_screen_to dw_screen_to
dw_sys_fields_from dw_sys_fields_from
dw_sys_tables_from dw_sys_tables_from
dw_fields_from dw_fields_from
dw_screen_from dw_screen_from
dw_object_from dw_object_from
dw_sync_note_2 dw_sync_note_2
dw_sync_note_1 dw_sync_note_1
cb_import cb_import
cb_close cb_close
cb_save cb_save
dw_screen_notes dw_screen_notes
dw_screens dw_screens
cb_lookups cb_lookups
cb_copy_notes cb_copy_notes
dw_view_select dw_view_select
cb_views cb_views
gb_2 gb_2
r_1 r_1
r_blue r_blue
gb_3 gb_3
dw_code_prem dw_code_prem
dw_addr_prem dw_addr_prem
dw_addr_icred dw_addr_icred
dw_code_icred dw_code_icred
dw_delete dw_delete
end type
global w_premium_sync w_premium_sync

type variables
n_tr tr_prem
integer ii_view = 0
string is_viewname
end variables

on w_premium_sync.create
this.dw_comp_copy=create dw_comp_copy
this.cb_copy_comp=create cb_copy_comp
this.cb_savecomp=create cb_savecomp
this.dw_comp=create dw_comp
this.cb_1=create cb_1
this.st_prog=create st_prog
this.gb_4=create gb_4
this.gb_1=create gb_1
this.dw_sys_fields_to=create dw_sys_fields_to
this.dw_sys_tables_to=create dw_sys_tables_to
this.dw_object_to=create dw_object_to
this.dw_fields_to=create dw_fields_to
this.dw_screen_to=create dw_screen_to
this.dw_sys_fields_from=create dw_sys_fields_from
this.dw_sys_tables_from=create dw_sys_tables_from
this.dw_fields_from=create dw_fields_from
this.dw_screen_from=create dw_screen_from
this.dw_object_from=create dw_object_from
this.dw_sync_note_2=create dw_sync_note_2
this.dw_sync_note_1=create dw_sync_note_1
this.cb_import=create cb_import
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_screen_notes=create dw_screen_notes
this.dw_screens=create dw_screens
this.cb_lookups=create cb_lookups
this.cb_copy_notes=create cb_copy_notes
this.dw_view_select=create dw_view_select
this.cb_views=create cb_views
this.gb_2=create gb_2
this.r_1=create r_1
this.r_blue=create r_blue
this.gb_3=create gb_3
this.dw_code_prem=create dw_code_prem
this.dw_addr_prem=create dw_addr_prem
this.dw_addr_icred=create dw_addr_icred
this.dw_code_icred=create dw_code_icred
this.dw_delete=create dw_delete
this.Control[]={this.dw_comp_copy,&
this.cb_copy_comp,&
this.cb_savecomp,&
this.dw_comp,&
this.cb_1,&
this.st_prog,&
this.gb_4,&
this.gb_1,&
this.dw_sys_fields_to,&
this.dw_sys_tables_to,&
this.dw_object_to,&
this.dw_fields_to,&
this.dw_screen_to,&
this.dw_sys_fields_from,&
this.dw_sys_tables_from,&
this.dw_fields_from,&
this.dw_screen_from,&
this.dw_object_from,&
this.dw_sync_note_2,&
this.dw_sync_note_1,&
this.cb_import,&
this.cb_close,&
this.cb_save,&
this.dw_screen_notes,&
this.dw_screens,&
this.cb_lookups,&
this.cb_copy_notes,&
this.dw_view_select,&
this.cb_views,&
this.gb_2,&
this.r_1,&
this.r_blue,&
this.gb_3,&
this.dw_code_prem,&
this.dw_addr_prem,&
this.dw_addr_icred,&
this.dw_code_icred,&
this.dw_delete}
end on

on w_premium_sync.destroy
destroy(this.dw_comp_copy)
destroy(this.cb_copy_comp)
destroy(this.cb_savecomp)
destroy(this.dw_comp)
destroy(this.cb_1)
destroy(this.st_prog)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.dw_sys_fields_to)
destroy(this.dw_sys_tables_to)
destroy(this.dw_object_to)
destroy(this.dw_fields_to)
destroy(this.dw_screen_to)
destroy(this.dw_sys_fields_from)
destroy(this.dw_sys_tables_from)
destroy(this.dw_fields_from)
destroy(this.dw_screen_from)
destroy(this.dw_object_from)
destroy(this.dw_sync_note_2)
destroy(this.dw_sync_note_1)
destroy(this.cb_import)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_screen_notes)
destroy(this.dw_screens)
destroy(this.cb_lookups)
destroy(this.cb_copy_notes)
destroy(this.dw_view_select)
destroy(this.cb_views)
destroy(this.gb_2)
destroy(this.r_1)
destroy(this.r_blue)
destroy(this.gb_3)
destroy(this.dw_code_prem)
destroy(this.dw_addr_prem)
destroy(this.dw_addr_icred)
destroy(this.dw_code_icred)
destroy(this.dw_delete)
end on

event open;integer i
tr_prem = CREATE n_tr;

tr_prem.DBMS="ODBC"
tr_prem.DbParm="ConnectString='DSN=ipremium;UID=dba;PWD=sql',DelimitIdentifier='Yes',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-14 By: Scofield
//$<Reason> Set the connection cache dynamically on Web
if AppeonGetClientType() = 'WEB' then
	tr_prem.DBMS = gs_CacheType
	tr_prem.DBParm = gs_CacheSet
end if
//---------------------------- APPEON END ----------------------------

CONNECT USING tr_prem;

IF tr_prem.SQLCODE = -1 THEN
	MessageBox("Login", "unable to connect to imiip database.  Check your IPREMIUM ODBC configuration")
	cb_copy_notes.enabled = false
	cb_lookups.enabled = false
	cb_views.enabled = false
	Return -1
else
	dw_view_select.settransobject(sqlca)
	dw_view_select.retrieve()
	dw_view_select.insertrow(1)
	
	dw_comp.settransobject(sqlca)
	i = dw_comp.retrieve()
	if i = 0 then 
		dw_comp.insertrow(1)
		dw_comp.setitem(1,"rec_id",1)
	end if
	Return 1

END IF


end event

event close;disCONNECT USING tr_prem;
end event

type dw_comp_copy from datawindow within w_premium_sync
integer x = 2606
integer y = 1848
integer width = 137
integer height = 60
integer taborder = 80
string dataobject = "d_company_de_premium"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_copy_comp from commandbutton within w_premium_sync
integer x = 2519
integer y = 1100
integer width = 297
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sync Notes"
end type

event clicked;integer i
integer cc1
integer cc2

debugbreak()
r_blue.width = 100
st_prog.text = "Clearing Note data"

dw_sync_note_1.settransobject(sqlca)
dw_sync_note_2.settransobject(tr_prem)
cc1 = dw_sync_note_1.retrieve()
cc2 = dw_sync_note_2.retrieve()

for i = dw_sync_note_2.rowcount() to 1 step - 1
	dw_sync_note_2.deleterow(i)
next
dw_sync_note_2.update()
commit using tr_prem;

r_blue.width = 500
st_prog.text = "Updating Note data"
dw_sync_note_1.rowscopy (1, dw_sync_note_1.rowcount(), primary!, dw_sync_note_2,10000, primary! )
i = dw_sync_note_2.update()
if i < 0 then messagebox("Update","Unable to update note data.")
commit using tr_prem;

r_blue.width = 1000
st_prog.text = "Note data Updated "
//commit using tr_prem;
messagebox("Update","Completed")
end event

type cb_savecomp from commandbutton within w_premium_sync
integer x = 2267
integer y = 1840
integer width = 247
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_comp.update()
//commit using tr_prem;
commit using sqlca;
end event

type dw_comp from datawindow within w_premium_sync
integer x = 64
integer y = 1252
integer width = 2830
integer height = 564
integer taborder = 280
string dataobject = "d_company_de_premium"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_premium_sync
integer x = 2089
integer y = 428
integer width = 649
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete All Practitioner data"
end type

event clicked;long s
long sc
string ls_table
string ls_sql
integer cc

r_blue.width = 50

dw_delete.settransobject(tr_prem)
sc = dw_delete.retrieve(1)
if sc = 0 then return
r_blue.width = 100
st_prog.text = "Deleting Pactitioner data"
cc = 500 / sc
for s = 1 to sc
	ls_table = dw_delete.getitemstring(s,"sys_tables_table_name")

	ls_sql = "Delete from " + ls_table + ";"

	execute immediate :ls_sql using tr_prem;
	commit using tr_prem;
	r_blue.width = r_blue.width + cc
next
r_blue.width = 600
delete from dba.pd_affil_staff_cat using tr_prem;
delete from dba.pd_affil_staff_leave using tr_prem;
delete from dba.pd_affil_dept using tr_prem;
delete from dba.pd_address_link using tr_prem;
delete from dba.pd_spec_facility_link using tr_prem;
r_blue.width = 800
delete from dba.pd_hosp_facility_link using tr_prem;
delete from dba.net_dev_action_items using tr_prem;
delete from dba.net_dev_ids using tr_prem;
delete from verif_info using tr_prem;
delete from dba.sys_audit using tr_prem;
commit using tr_prem;

delete from dba.pd_affil_stat using tr_prem;
commit using tr_prem;
r_blue.width = 900
delete from dba.pd_basic using tr_prem;
commit using tr_prem;

r_blue.width = 1000
st_prog.text = "Pactitioner data deleted"

messagebox("Delete","Completed")
end event

type st_prog from statictext within w_premium_sync
integer x = 69
integer y = 148
integer width = 878
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
string text = "Progress"
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_premium_sync
integer x = 1998
integer y = 240
integer width = 823
integer height = 360
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "MIIP Database"
end type

type gb_1 from groupbox within w_premium_sync
integer x = 795
integer y = 240
integer width = 1166
integer height = 360
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "DE Screens"
end type

type dw_sys_fields_to from datawindow within w_premium_sync
integer x = 1554
integer y = 456
integer width = 151
integer height = 76
integer taborder = 190
string dataobject = "d_prem_sys_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_sys_tables_to from datawindow within w_premium_sync
integer x = 1280
integer y = 468
integer width = 165
integer height = 112
integer taborder = 250
string dataobject = "d_prem_sys_tables"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_object_to from datawindow within w_premium_sync
integer x = 1289
integer y = 292
integer width = 160
integer height = 88
integer taborder = 260
string dataobject = "d_prem_dv_objects"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fields_to from datawindow within w_premium_sync
integer x = 1029
integer y = 300
integer width = 174
integer height = 60
integer taborder = 120
string dataobject = "d_prem_dv_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_screen_to from datawindow within w_premium_sync
integer x = 1330
integer y = 420
integer width = 146
integer height = 80
integer taborder = 170
string dataobject = "d_prem_dv_screens"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_sys_fields_from from datawindow within w_premium_sync
integer x = 1093
integer y = 504
integer width = 151
integer height = 76
integer taborder = 180
string dataobject = "d_prem_sys_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_sys_tables_from from datawindow within w_premium_sync
integer x = 1093
integer y = 388
integer width = 165
integer height = 88
integer taborder = 230
string dataobject = "d_prem_sys_tables"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fields_from from datawindow within w_premium_sync
integer x = 873
integer y = 536
integer width = 174
integer height = 60
integer taborder = 110
string dataobject = "d_prem_dv_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_screen_from from datawindow within w_premium_sync
integer x = 914
integer y = 424
integer width = 146
integer height = 80
integer taborder = 200
string dataobject = "d_prem_dv_screens"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_object_from from datawindow within w_premium_sync
integer x = 1659
integer y = 444
integer width = 160
integer height = 88
integer taborder = 270
string dataobject = "d_prem_dv_objects"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_sync_note_2 from datawindow within w_premium_sync
integer x = 2702
integer y = 1108
integer width = 69
integer height = 60
integer taborder = 100
string dataobject = "d_screen_notes_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_sync_note_1 from datawindow within w_premium_sync
integer x = 2565
integer y = 1112
integer width = 73
integer height = 56
integer taborder = 290
string dataobject = "d_screen_notes_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_import from commandbutton within w_premium_sync
boolean visible = false
integer x = 2002
integer y = 32
integer width = 558
integer height = 116
integer taborder = 310
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import DataFile"
end type

event clicked;open(w_modify_codes)
end event

type cb_close from commandbutton within w_premium_sync
integer x = 2661
integer y = 28
integer width = 247
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_premium_sync
integer x = 2240
integer y = 1100
integer width = 247
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_screen_notes.update()
//commit using tr_prem;
commit using sqlca;
end event

type dw_screen_notes from datawindow within w_premium_sync
integer x = 1015
integer y = 684
integer width = 1801
integer height = 400
integer taborder = 320
string dataobject = "d_screen_notes_de"
boolean border = false
boolean livescroll = true
end type

type dw_screens from datawindow within w_premium_sync
integer x = 105
integer y = 676
integer width = 869
integer height = 512
integer taborder = 300
string dataobject = "d_screen_alias_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer r
integer sid
integer n

cb_save.triggerevent(clicked!)
r = this.getclickedrow()

if r > 0 then
	this.setrow(r)
	this.selectrow(0,false)
	this.selectrow(r,true)
	sid = this.getitemnumber(r,"screen_id")
	n = dw_screen_notes.retrieve(sid)
	if n = 0 then dw_screen_notes.insertrow(1)
	dw_screen_notes.setitem(1,"screen_id",sid)
	dw_screen_notes.setfocus()
end if




end event

event retrieveend;//dw_screen_notes.settransobject(tr_prem)
dw_screen_notes.settransobject(sqlca)
end event

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
this.setitem(1,"screen_id",0)

end event

type cb_lookups from commandbutton within w_premium_sync
integer x = 128
integer y = 428
integer width = 521
integer height = 84
integer taborder = 330
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sync Lookup Tables"
end type

event clicked;integer p
integer pc
integer i
integer ic

dw_addr_icred.settransobject(sqlca)
dw_code_icred.settransobject(sqlca)
dw_code_prem.settransobject(tr_prem)
dw_addr_prem.settransobject(tr_prem)

r_blue.width = 100

st_prog.text = "Deleting address lookups"
delete from dba.code_lookup using tr_prem;
commit using tr_prem;
st_prog.text = "Deleting code lookups"
delete from dba.address_lookup using tr_prem;
commit using tr_prem;

ic = dw_addr_icred.retrieve()

st_prog.text = "Retrieving address lookups"
pc = dw_addr_prem.retrieve()
if pc > 0 then 
	messagebox("Delete","Unable to delete all address lookups.  Use delete practitioner utility, and rerun")
	return
end if
r_blue.width = 200
st_prog.text = "Copying address lookups"
//for p = 1 to pc
//	dw_addr_prem.deleterow(1)
//next
r_blue.width = 250
//dw_addr_prem.update()
//commit using tr_prem;
r_blue.width = 300
dw_addr_icred.RowsCopy (1, ic, primary!, dw_addr_prem, 1000000, primary! )
st_prog.text = "Updating address lookups"

dw_addr_prem.update()
r_blue.width = 400
update dba.address_lookup set code = substring(code,2) where code like '*%' using tr_prem;
commit using tr_prem;
r_blue.width = 500



ic = dw_code_icred.retrieve()
r_blue.width = 600
st_prog.text = "Retrieving code lookups"
pc = dw_code_prem.retrieve()
if pc > 0 then 
	messagebox("Delete","Unable to delete all code lookups.  Use delete practitioner utility, and rerun")
	return
end if
r_blue.width = 700
st_prog.text = "Copying code lookups"
//for p = 1 to pc
//	dw_code_prem.deleterow(1)
//next
r_blue.width = 750
//dw_code_prem.update()
//commit using tr_prem;
r_blue.width = 800
dw_code_icred.RowsCopy (1, ic, primary!, dw_code_prem, 1000000, primary! )
st_prog.text = "Updating code lookups"
dw_code_prem.update()
r_blue.width = 900
update dba.code_lookup set code = substring(code,2) where code like '*%' using tr_prem;
commit using tr_prem;
r_blue.width = 995

st_prog.text = "Lookup Updates Completed"

messagebox("Update","Completed")
























end event

type cb_copy_notes from commandbutton within w_premium_sync
integer x = 2528
integer y = 1840
integer width = 370
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sync Company"
end type

event clicked;integer i

r_blue.width = 100
st_prog.text = "Clearing Company data"

//dw_sync_note_1.settransobject(sqlca)
dw_comp_copy.settransobject(tr_prem)

 i = dw_comp_copy.retrieve()

if i = 1 then
	dw_comp_copy.deleterow(1)
	dw_comp_copy.update() 
	commit using tr_prem;
end if



r_blue.width = 500
st_prog.text = "Updating Company data"
dw_comp.rowscopy (1,1, primary!, dw_comp_copy,10000, primary! )
dw_comp_copy.update()
commit using tr_prem;

r_blue.width = 1000
st_prog.text = "Note data Updated "
//commit using tr_prem;
messagebox("Update","Completed")
end event

type dw_view_select from datawindow within w_premium_sync
integer x = 905
integer y = 320
integer width = 946
integer height = 96
integer taborder = 220
boolean bringtotop = true
string dataobject = "d_prem_views_dddw_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_view = integer(data)
end event

type cb_views from commandbutton within w_premium_sync
integer x = 1166
integer y = 428
integer width = 375
integer height = 84
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update View"
end type

event clicked;long i
long ic
long dvid

if ii_view = 0 then
	messagebox("Select","Please Select View")
	return
end if

r_blue.width = 100
st_prog.text = "Retrieving Screen data"

dw_screen_from.settransobject(sqlca)
if dw_screen_from.retrieve(ii_view) < 1 then return

dw_sys_tables_from.settransobject(sqlca)
dw_sys_tables_from.retrieve()
dw_sys_fields_from.settransobject(sqlca)
dw_sys_fields_from.retrieve()
dw_fields_from.settransobject(sqlca)
dw_fields_from.retrieve(ii_view)
dw_object_from.settransobject(sqlca)
dw_object_from.retrieve(ii_view)

r_blue.width = 300
st_prog.text = "Clearing Screen data"	

delete from dba.data_view_screen using tr_prem;
delete from dba.data_view_fields using tr_prem;
delete from dba.data_view_screen_objects using tr_prem;

delete from dba.sys_tables using tr_prem;
delete from dba.sys_fields using tr_prem;

commit using tr_prem;

dw_screen_to.settransobject(tr_prem)
dw_sys_tables_to.settransobject(tr_prem)
dw_sys_fields_to.settransobject(tr_prem)
dw_fields_to.settransobject(tr_prem)
dw_object_to.settransobject(tr_prem)

r_blue.width = 500
st_prog.text = "Copying Screen data"

dw_screen_from.rowscopy (1, dw_screen_from.rowcount(), primary!, dw_screen_to,10000, primary! )
dw_sys_tables_from.rowscopy (1, dw_sys_tables_from.rowcount(), primary!, dw_sys_tables_to,10000, primary! )
dw_sys_fields_from.rowscopy (1, dw_sys_fields_from.rowcount(), primary!, dw_sys_fields_to,10000, primary! )
dw_fields_from.rowscopy (1, dw_fields_from.rowcount(), primary!, dw_fields_to,10000, primary! )
dw_object_from.rowscopy (1, dw_object_from.rowcount(), primary!, dw_object_to,10000, primary! )

//select max(data_view_field_id) into :dvid from dba.data_view_fields using tr_prem;
for i = 1 to dw_screen_to.rowcount()
	
	dw_screen_to.setitem(i,"data_view_id",1)
next

for i = 1 to dw_fields_to.rowcount()
	
	dw_fields_to.setitem(i,"data_view_id",1)
next
//
//select max(data_view_object_id) into :dvid from dba.data_view_screen_objects using tr_prem;
for i = 1 to dw_object_to.rowcount()
	dvid++
	dw_object_to.setitem(i,"data_view_id",1)
next

r_blue.width = 700
st_prog.text = "Updating Screen data"

dw_screen_to.update()
dw_sys_tables_to.update()
dw_sys_fields_to.update()
dw_fields_to.update()
dw_object_to.update()

r_blue.width = 1000


commit using tr_prem;

messagebox("Update","Completed")
end event

type gb_2 from groupbox within w_premium_sync
integer x = 41
integer y = 608
integer width = 2862
integer height = 616
integer taborder = 210
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select Screen to Modify Notes"
end type

type r_1 from rectangle within w_premium_sync
integer linethickness = 4
long fillcolor = 80269524
integer x = 69
integer y = 36
integer width = 1033
integer height = 100
end type

type r_blue from rectangle within w_premium_sync
long linecolor = 80269524
integer linethickness = 4
long fillcolor = 16711680
integer x = 73
integer y = 40
integer width = 46
integer height = 92
end type

type gb_3 from groupbox within w_premium_sync
integer x = 46
integer y = 244
integer width = 709
integer height = 356
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Lookup Tables"
end type

type dw_code_prem from datawindow within w_premium_sync
integer x = 485
integer y = 332
integer width = 82
integer height = 64
integer taborder = 30
string dataobject = "d_prem_code_lookup"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_addr_prem from datawindow within w_premium_sync
integer x = 352
integer y = 332
integer width = 82
integer height = 64
integer taborder = 10
string dataobject = "d_prem_addr_lookup"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_addr_icred from datawindow within w_premium_sync
integer x = 178
integer y = 332
integer width = 82
integer height = 64
integer taborder = 20
string dataobject = "d_prem_addr_lookup"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_code_icred from datawindow within w_premium_sync
integer x = 119
integer y = 328
integer width = 82
integer height = 64
integer taborder = 340
string dataobject = "d_prem_code_lookup"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_delete from datawindow within w_premium_sync
integer x = 2226
integer y = 408
integer width = 219
integer height = 40
integer taborder = 240
string dataobject = "d_premium_export_tables"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

