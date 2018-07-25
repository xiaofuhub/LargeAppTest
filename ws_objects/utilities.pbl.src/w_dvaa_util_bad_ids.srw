$PBExportHeader$w_dvaa_util_bad_ids.srw
forward
global type w_dvaa_util_bad_ids from window
end type
type cbx_test from checkbox within w_dvaa_util_bad_ids
end type
type cb_close from commandbutton within w_dvaa_util_bad_ids
end type
type cb_run from commandbutton within w_dvaa_util_bad_ids
end type
type dw_prac from datawindow within w_dvaa_util_bad_ids
end type
type dw_bad from datawindow within w_dvaa_util_bad_ids
end type
type dw_dups from datawindow within w_dvaa_util_bad_ids
end type
end forward

global type w_dvaa_util_bad_ids from window
integer width = 3017
integer height = 1688
boolean titlebar = true
string title = "Checklist Irregularities"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cbx_test cbx_test
cb_close cb_close
cb_run cb_run
dw_prac dw_prac
dw_bad dw_bad
dw_dups dw_dups
end type
global w_dvaa_util_bad_ids w_dvaa_util_bad_ids

on w_dvaa_util_bad_ids.create
this.cbx_test=create cbx_test
this.cb_close=create cb_close
this.cb_run=create cb_run
this.dw_prac=create dw_prac
this.dw_bad=create dw_bad
this.dw_dups=create dw_dups
this.Control[]={this.cbx_test,&
this.cb_close,&
this.cb_run,&
this.dw_prac,&
this.dw_bad,&
this.dw_dups}
end on

on w_dvaa_util_bad_ids.destroy
destroy(this.cbx_test)
destroy(this.cb_close)
destroy(this.cb_run)
destroy(this.dw_prac)
destroy(this.dw_bad)
destroy(this.dw_dups)
end on

type cbx_test from checkbox within w_dvaa_util_bad_ids
integer x = 165
integer y = 1456
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
string text = "test only"
boolean checked = true
end type

type cb_close from commandbutton within w_dvaa_util_bad_ids
integer x = 1426
integer y = 1436
integer width = 343
integer height = 92
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

type cb_run from commandbutton within w_dvaa_util_bad_ids
integer x = 1056
integer y = 1436
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;long d
long dc
long i
long ic
long p
long pc
long ll_ids[]
long ll_cur
long ll_prior
long ll_max
long ll_id_org
long ll_temp
long cnt_a
long cnt_p

dw_dups.settransobject(sqlca)
dw_bad.settransobject(sqlca)
dw_prac.settransobject(sqlca)

dc = dw_dups.retrieve()

if dc < 1 then 
	messagebox("Duplicate Checklist Ids","No duplicate Checklist ids found.  This is good.")
	return
end if

//max id
select max(app_audit_id) into :ll_max from data_view_app_audit;

//get the ids for all the duplicates
for d = 1 to dc
	ll_ids[d] = dw_dups.getitemnumber(d,"app_audit_id")
next

//get the dup ids records
ic = dw_bad.retrieve(ll_ids)

for i = 1 to ic
	ll_cur = dw_bad.getitemnumber(i,"app_audit_id")
	if i = 1 then 
		ll_prior = ll_cur
		continue  
	end if
	if ll_cur = ll_prior then
		ll_max ++
		dw_bad.setitem(i, "app_audit_id",ll_max)
		dw_bad.setitem(i, "mod_ed",ll_cur)  //set original id
		ll_prior = ll_cur
		cnt_a++
	else
		ll_prior = ll_cur
	end if

next

if cbx_test.checked = false then
	dw_bad.update()
	update ids set app_audit_id  = :ll_max;
	commit using sqlca;
end if


for i = 1 to ic
	ll_id_org = dw_bad.getitemnumber(i,"mod_ed")  //get org id
	
	if ll_id_org > 0  then
		ll_cur = dw_bad.getitemnumber(i,"app_audit_id")  //current id
		ll_temp = dw_bad.getitemnumber(i,"facility_id")  //template id
		pc = dw_prac.retrieve(ll_id_org,ll_temp)  //find matching prac data
		
		for p = 1 to pc
			dw_prac.setitem(p,"app_audit_id",ll_cur)
			cnt_p++
		next
		
		if cbx_test.checked = false then
				dw_prac.update()
		end if
	end if
	
next

messagebox("Completed", string(cnt_a) + " Template records updated, and " + string(cnt_p) + " practitioner checklist records updated.")











end event

type dw_prac from datawindow within w_dvaa_util_bad_ids
integer x = 41
integer y = 532
integer width = 2871
integer height = 860
integer taborder = 30
string title = "none"
string dataobject = "d_dvaa_util_bad_ids_prac"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_bad from datawindow within w_dvaa_util_bad_ids
integer x = 841
integer y = 92
integer width = 2080
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "d_dvaa_util_bad_ids"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_dups from datawindow within w_dvaa_util_bad_ids
integer x = 55
integer y = 88
integer width = 686
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_dvaa_util_bad_dup_ids"
boolean vscrollbar = true
boolean livescroll = true
end type

