$PBExportHeader$w_convert_npdb.srw
forward
global type w_convert_npdb from window
end type
type st_rc from statictext within w_convert_npdb
end type
type st_3 from statictext within w_convert_npdb
end type
type st_2 from statictext within w_convert_npdb
end type
type st_cnt from statictext within w_convert_npdb
end type
type dw_2 from datawindow within w_convert_npdb
end type
type cb_2 from commandbutton within w_convert_npdb
end type
type cb_run from commandbutton within w_convert_npdb
end type
type dw_1 from datawindow within w_convert_npdb
end type
end forward

global type w_convert_npdb from window
integer x = 1170
integer y = 940
integer width = 951
integer height = 452
boolean titlebar = true
string title = "Convert NPDB records"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 80269524
st_rc st_rc
st_3 st_3
st_2 st_2
st_cnt st_cnt
dw_2 dw_2
cb_2 cb_2
cb_run cb_run
dw_1 dw_1
end type
global w_convert_npdb w_convert_npdb

on w_convert_npdb.create
this.st_rc=create st_rc
this.st_3=create st_3
this.st_2=create st_2
this.st_cnt=create st_cnt
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_run=create cb_run
this.dw_1=create dw_1
this.Control[]={this.st_rc,&
this.st_3,&
this.st_2,&
this.st_cnt,&
this.dw_2,&
this.cb_2,&
this.cb_run,&
this.dw_1}
end on

on w_convert_npdb.destroy
destroy(this.st_rc)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_cnt)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_run)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
 dw_1.retrieve()
end event

type st_rc from statictext within w_convert_npdb
integer x = 539
integer y = 196
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
string text = "0"
boolean focusrectangle = false
end type

type st_3 from statictext within w_convert_npdb
integer x = 105
integer y = 196
integer width = 192
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
string text = "Record"
boolean focusrectangle = false
end type

type st_2 from statictext within w_convert_npdb
integer x = 453
integer y = 196
integer width = 78
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
string text = "of "
boolean focusrectangle = false
end type

type st_cnt from statictext within w_convert_npdb
integer x = 256
integer y = 196
integer width = 155
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
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_convert_npdb
integer x = 238
integer y = 60
integer width = 64
integer height = 56
integer taborder = 40
string dataobject = "d_parent_facilities_of_verif"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_convert_npdb
integer x = 471
integer y = 28
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
end type

event clicked;close(parent)
end event

type cb_run from commandbutton within w_convert_npdb
integer x = 91
integer y = 28
integer width = 247
integer height = 108
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

event clicked;integer i
integer ic
integer v
integer vc
integer pfac
integer vfac
long prac
integer check
integer cnt = 0
string ls_doc_id
long recid
Long ll_seq_no

debugbreak()

ic = dw_1.rowcount()
st_rc.text = string(ic)
for i = 1 to ic
	check = 0
	vfac = dw_1.getitemnumber(i,"facility_id")
	prac = dw_1.getitemnumber(i,"prac_id")
	recid = dw_1.getitemnumber(i,"rec_id")
	ll_seq_no = dw_1.getitemnumber(i,"seq_no")
	
	dw_2.settransobject(sqlca)
	v = dw_2.retrieve(vfac,prac)
	
	if v = 0 then 
		continue
	elseif v = -1 then
		messagebox("","fix the datawindow")
		return
	elseif v = 1 then
		pfac = dw_2.getitemnumber(v,"parent_facility_id")
		dw_1.setitem(i,"facility_id",pfac)
		ls_doc_id = String( recid ) + "-" + String( prac ) + "-" + String( pfac ) +  "-" + String( ll_seq_no )
		dw_1.setitem(i,"doc_id",pfac)
		cnt = cnt + 1
	elseif v > 1 then
		for v = 1 to vc
			if isnull(dw_2.getitemnumber(v,"appmnt_start_date")) then
				pfac = dw_2.getitemnumber(v,"parent_facility_id")
				dw_1.setitem(i,"facility_id",pfac)
				ls_doc_id = String( recid ) + "-" + String( prac ) + "-" + String( pfac ) +  "-" + String( ll_seq_no )
				dw_1.setitem(i,"doc_id",pfac)
				check = 1
				cnt = cnt + 1
				continue
			end if
		next
		if check = 0 then // if the set not done use the first record
			pfac = dw_2.getitemnumber(1,"parent_facility_id")
			dw_1.setitem(i,"facility_id",pfac)
			ls_doc_id = String( recid ) + "-" + String( prac ) + "-" + String( pfac ) +  "-" + String( ll_seq_no )
			dw_1.setitem(i,"doc_id",pfac)
			cnt = cnt + 1
		end if
	end if
	st_cnt.text = string(i)
next
check = 0
check = dw_1.update()

if check = -1 then
	messagebox("Save error","Unable to update")
else
	update icred_settings
	set set_20 = 1;
	commit using sqlca;
end if
cb_run.enabled = false
messagebox("Done",string(cnt) + " records updated.")
end event

type dw_1 from datawindow within w_convert_npdb
integer x = 110
integer y = 56
integer width = 82
integer height = 64
integer taborder = 30
string dataobject = "d_npdb_verif_facil_incl"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

