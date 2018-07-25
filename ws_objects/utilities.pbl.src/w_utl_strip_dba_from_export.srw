$PBExportHeader$w_utl_strip_dba_from_export.srw
forward
global type w_utl_strip_dba_from_export from window
end type
type cb_run from commandbutton within w_utl_strip_dba_from_export
end type
type dw_facilcomm from datawindow within w_utl_strip_dba_from_export
end type
type dw_fields from datawindow within w_utl_strip_dba_from_export
end type
type dw_hdr from datawindow within w_utl_strip_dba_from_export
end type
type dw_list from datawindow within w_utl_strip_dba_from_export
end type
type cb_4 from commandbutton within w_utl_strip_dba_from_export
end type
type cb_3 from commandbutton within w_utl_strip_dba_from_export
end type
type cb_1 from commandbutton within w_utl_strip_dba_from_export
end type
type r_1 from rectangle within w_utl_strip_dba_from_export
end type
type r_2 from rectangle within w_utl_strip_dba_from_export
end type
end forward

global type w_utl_strip_dba_from_export from window
integer x = 123
integer y = 112
integer width = 1728
integer height = 588
boolean titlebar = true
string title = "Strip dba. from export data"
windowtype windowtype = popup!
long backcolor = 80269524
boolean center = true
cb_run cb_run
dw_facilcomm dw_facilcomm
dw_fields dw_fields
dw_hdr dw_hdr
dw_list dw_list
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
r_1 r_1
r_2 r_2
end type
global w_utl_strip_dba_from_export w_utl_strip_dba_from_export

type variables
long il_openfor
end variables

forward prototypes
public function string of_strip (string as_sql)
end prototypes

public function string of_strip (string as_sql);long i = 1
long ic
string ls_str
string ls_ret

ls_str = as_sql
debugbreak()
do while i > 0
	i = PosA(ls_str,"dba.",1)
	if i > 0 then
		ic = 1
		if i = 1 then
			ls_str = MidA(ls_str,5)
		else
			ls_str = MidA(ls_str,1, i - 1) + MidA(ls_str,i+4)
		end if
	end if
loop

if ic = 0 then
	ls_ret = "NONE"
else
	ls_ret = ls_str
	//messagebox("",as_sql + "~r" + ls_ret)
end if

return ls_ret



end function

on w_utl_strip_dba_from_export.create
this.cb_run=create cb_run
this.dw_facilcomm=create dw_facilcomm
this.dw_fields=create dw_fields
this.dw_hdr=create dw_hdr
this.dw_list=create dw_list
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.r_1=create r_1
this.r_2=create r_2
this.Control[]={this.cb_run,&
this.dw_facilcomm,&
this.dw_fields,&
this.dw_hdr,&
this.dw_list,&
this.cb_4,&
this.cb_3,&
this.cb_1,&
this.r_1,&
this.r_2}
end on

on w_utl_strip_dba_from_export.destroy
destroy(this.cb_run)
destroy(this.dw_facilcomm)
destroy(this.dw_fields)
destroy(this.dw_hdr)
destroy(this.dw_list)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.r_1)
destroy(this.r_2)
end on

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type cb_run from commandbutton within w_utl_strip_dba_from_export
integer x = 306
integer y = 92
integer width = 960
integer height = 84
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run"
end type

event clicked;integer e
integer ec
integer f
integer fc
integer i
integer lc
integer nr
integer nc
integer li_fac
long ll_expid
long hcnt
long cnt
integer li_ret
integer comfind
string ls_val
string ls_filt

dw_list.settransobject(sqlca)
dw_hdr.settransobject(sqlca)
dw_fields.settransobject(sqlca)

lc = dw_list.retrieve()
if lc = 0 then return
nc = int(1500/lc)
nr = 0

for i = 1 to lc
	ll_expid = dw_list.getitemnumber(i,"export_id")
	dw_hdr.retrieve(ll_expid)
	ls_val = dw_hdr.getitemstring(1,"prac_sql")
	ls_val = of_strip(ls_val)
	if ls_val  <> "NONE" then
		dw_hdr.setitem(1,"prac_sql",ls_val)
		hcnt++
		dw_hdr.update()
	end if
	fc = dw_fields.retrieve(ll_expid)
	for f = 1 to fc
		ls_filt = dw_fields.getitemstring(f,"filter_query")
		if LenA(ls_filt) > 0 then
			ls_filt = of_strip(ls_filt)
			if ls_filt  <> "NONE" then
				//messagebox("",ls_filt)
				dw_fields.setitem(f,"filter_query",ls_filt)
				cnt++
			end if
		end if
		ls_filt = dw_fields.getitemstring(f,"sort_by")
		if LenA(ls_filt) > 0 then
			ls_filt = of_strip(ls_filt)
			if ls_filt  <> "NONE" then
				dw_fields.setitem(f,"sort_by",ls_filt)
				cnt++
			end if
		end if
		//if cnt = 5 then return
	next
	li_ret = 	dw_fields.update()
	if li_ret < 0 then messagebox("","Update failed on fields")
	nr =  nr + nc
	r_2.width = nr
	
next
	
r_2.width = 1481

messagebox(" Update Completed", string(hcnt) + " header changes and " +string(cnt) +" field changes made.")



end event

type dw_facilcomm from datawindow within w_utl_strip_dba_from_export
boolean visible = false
integer x = 1861
integer y = 1104
integer width = 46
integer height = 64
integer taborder = 10
string dataobject = "d_comm_of_facil"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fields from datawindow within w_utl_strip_dba_from_export
boolean visible = false
integer x = 942
integer y = 52
integer width = 453
integer height = 196
integer taborder = 20
string dataobject = "d_utl_export_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hdr from datawindow within w_utl_strip_dba_from_export
boolean visible = false
integer x = 503
integer y = 56
integer width = 402
integer height = 172
integer taborder = 30
string dataobject = "d_export_hdr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_list from datawindow within w_utl_strip_dba_from_export
boolean visible = false
integer x = 41
integer y = 36
integer width = 370
integer height = 176
integer taborder = 80
string dataobject = "d_dddw_export_files"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_utl_strip_dba_from_export
integer x = 2199
integer y = 108
integer width = 247
integer height = 108
integer taborder = 40
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

type cb_3 from commandbutton within w_utl_strip_dba_from_export
integer x = 1394
integer y = 92
integer width = 274
integer height = 84
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_utl_strip_dba_from_export
boolean visible = false
integer x = 2053
integer y = 656
integer width = 265
integer height = 72
integer taborder = 70
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

type r_1 from rectangle within w_utl_strip_dba_from_export
integer linethickness = 4
long fillcolor = 16777215
integer x = 105
integer y = 316
integer width = 1499
integer height = 68
end type

type r_2 from rectangle within w_utl_strip_dba_from_export
integer linethickness = 4
long fillcolor = 16711680
integer x = 114
integer y = 324
integer width = 46
integer height = 48
end type

