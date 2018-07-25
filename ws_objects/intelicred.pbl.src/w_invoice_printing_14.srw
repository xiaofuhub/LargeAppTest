$PBExportHeader$w_invoice_printing_14.srw
forward
global type w_invoice_printing_14 from w_master
end type
type dw_facility from datawindow within w_invoice_printing_14
end type
type cb_up from commandbutton within w_invoice_printing_14
end type
type cb_2 from commandbutton within w_invoice_printing_14
end type
type st_2a from statictext within w_invoice_printing_14
end type
type st_1a from statictext within w_invoice_printing_14
end type
type em_to from editmask within w_invoice_printing_14
end type
type em_from from editmask within w_invoice_printing_14
end type
type gb_3 from groupbox within w_invoice_printing_14
end type
type gb_f from groupbox within w_invoice_printing_14
end type
type dw_browse from u_dw within w_invoice_printing_14
end type
type cb_3 from commandbutton within w_invoice_printing_14
end type
type rb_ddr from radiobutton within w_invoice_printing_14
end type
type rb_all from radiobutton within w_invoice_printing_14
end type
type rb_sdree from radiobutton within w_invoice_printing_14
end type
type rb_ldr from radiobutton within w_invoice_printing_14
end type
type gb_1 from groupbox within w_invoice_printing_14
end type
type cb_1 from commandbutton within w_invoice_printing_14
end type
end forward

global type w_invoice_printing_14 from w_master
integer x = 14
integer y = 16
integer width = 3648
integer height = 2316
string title = "Print Invoices"
windowtype windowtype = popup!
long backcolor = 33551856
dw_facility dw_facility
cb_up cb_up
cb_2 cb_2
st_2a st_2a
st_1a st_1a
em_to em_to
em_from em_from
gb_3 gb_3
gb_f gb_f
dw_browse dw_browse
cb_3 cb_3
rb_ddr rb_ddr
rb_all rb_all
rb_sdree rb_sdree
rb_ldr rb_ldr
gb_1 gb_1
cb_1 cb_1
end type
global w_invoice_printing_14 w_invoice_printing_14

type variables
integer ii_facil
integer ii_usedates = 1
long il_status
long il_prac
long il_req
string is_type
string is_ret_type
end variables

on w_invoice_printing_14.create
int iCurrent
call super::create
this.dw_facility=create dw_facility
this.cb_up=create cb_up
this.cb_2=create cb_2
this.st_2a=create st_2a
this.st_1a=create st_1a
this.em_to=create em_to
this.em_from=create em_from
this.gb_3=create gb_3
this.gb_f=create gb_f
this.dw_browse=create dw_browse
this.cb_3=create cb_3
this.rb_ddr=create rb_ddr
this.rb_all=create rb_all
this.rb_sdree=create rb_sdree
this.rb_ldr=create rb_ldr
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_facility
this.Control[iCurrent+2]=this.cb_up
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_2a
this.Control[iCurrent+5]=this.st_1a
this.Control[iCurrent+6]=this.em_to
this.Control[iCurrent+7]=this.em_from
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.gb_f
this.Control[iCurrent+10]=this.dw_browse
this.Control[iCurrent+11]=this.cb_3
this.Control[iCurrent+12]=this.rb_ddr
this.Control[iCurrent+13]=this.rb_all
this.Control[iCurrent+14]=this.rb_sdree
this.Control[iCurrent+15]=this.rb_ldr
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.cb_1
end on

on w_invoice_printing_14.destroy
call super::destroy
destroy(this.dw_facility)
destroy(this.cb_up)
destroy(this.cb_2)
destroy(this.st_2a)
destroy(this.st_1a)
destroy(this.em_to)
destroy(this.em_from)
destroy(this.gb_3)
destroy(this.gb_f)
destroy(this.dw_browse)
destroy(this.cb_3)
destroy(this.rb_ddr)
destroy(this.rb_all)
destroy(this.rb_sdree)
destroy(this.rb_ldr)
destroy(this.gb_1)
destroy(this.cb_1)
end on

event open;call super::open;long ll_batch_id
long ll_pracs[]
integer ic
integer i
integer li_type
long p
datawindowchild dwchild
integer li_facility_id
gs_batch_search lst_sent


dw_facility.settransobject(sqlca)

dw_facility.getchild("facility_facility_id",dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
//dw_facility.retrieve(gs_user_id)
dw_facility.insertrow(1)
if li_facility_id < 1 or isnull(li_facility_id) then
	SELECT security_users.default_search_facility  
	INTO :li_facility_id  
	FROM security_users  
	WHERE security_users.user_id = :gs_user_id;
end if

IF Not IsNull( li_facility_id ) THEN //set user default facility
	dw_facility.SetItem( 1, "facility_facility_id", li_facility_id )
END IF
ii_facil = li_facility_id

end event

event closequery;//no message
end event

event resize;call super::resize;//Start Code Change ----08.08.2016 #V152 maha
long ll_h
long ll_w

ll_h = this.workspaceheight( )
ll_w = this.workspacewidth( )

dw_browse.height = ll_h - 25 - 348
dw_browse.width = ll_w - 25 - 10
end event

type dw_facility from datawindow within w_invoice_printing_14
integer x = 78
integer y = 200
integer width = 837
integer height = 84
integer taborder = 60
string dataobject = "d_facility_users_batch"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_facil = integer(data)



end event

type cb_up from commandbutton within w_invoice_printing_14
integer x = 2519
integer y = 32
integer width = 247
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Preview"
end type

event clicked;date ld_from
date ld_to
integer i
integer rc
integer res
long p
long pcnt
long rcnt


//dw_browse.SetRedraw(False)

ld_from = date(em_from.text)
ld_to = date(em_to.text)
//messagebox("ld_from",em_from.text)

if  ii_facil < 1 then
	messagebox("User Select Error","You must select a facility to run this function.")
	return
end if
//
//if  il_status < 1 then
//	messagebox("Missing Value","You must have a Status.")
//	return
//end if

if em_from.text = "" then ld_from = date(01-01-1950)
if em_to.text = ""  then ld_to = date(12-31-2099)
//messagebox("ii_usedates",ii_usedates)
if ii_usedates = 1 then
	dw_browse.retrieve(ii_facil,ld_from,ld_to)
else
	dw_browse.retrieve(ii_facil)
end if

end event

type cb_2 from commandbutton within w_invoice_printing_14
integer x = 3314
integer y = 32
integer width = 247
integer height = 84
integer taborder = 20
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

type st_2a from statictext within w_invoice_printing_14
integer x = 1627
integer y = 212
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "End Date"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1a from statictext within w_invoice_printing_14
integer x = 1042
integer y = 212
integer width = 247
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Start Date"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_to from editmask within w_invoice_printing_14
integer x = 1870
integer y = 200
integer width = 315
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "[date]"
end type

type em_from from editmask within w_invoice_printing_14
integer x = 1303
integer y = 200
integer width = 311
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "[date]"
end type

type gb_3 from groupbox within w_invoice_printing_14
integer x = 2318
integer y = 124
integer width = 1257
integer height = 204
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "InvoiceType"
end type

type gb_f from groupbox within w_invoice_printing_14
integer x = 41
integer y = 120
integer width = 960
integer height = 212
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Facility"
end type

type dw_browse from u_dw within w_invoice_printing_14
integer x = 14
integer y = 348
integer width = 3589
integer height = 1856
integer taborder = 10
string dataobject = "d_frm_facility_invoice_summary"
boolean hscrollbar = true
end type

event clicked;//
//Integer li_row
//
//li_row = This.GetClickedRow( )
//
//IF li_row < 1 THEN
//	Return
//END IF
//
//
//This.ScrollToRow( li_row )
//This.SetRow( li_row )
////this.selectrow(0,false)
////this.selectrow(li_row,true)
//
end event

event doubleclicked;call super::doubleclicked;
//long ll_core
//integer li_row
//integer li_end
//
//if this.rowcount() > 0 then
//	tab_1.selecttab (2)
//	
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;
//IF tab_1.tabpage_detail.dw_detail.RowCount() >= currentrow THEN
	//tab_1.tabpage_detail.dw_detail.SetRow( currentrow )
	//tab_1.tabpage_detail.dw_detail.ScrollToRow( currentrow )
//END IF
//this.selectrow(0,false)
//this.selectrow(this.getrow(),true)

//st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
end event

event pfc_deleterow;
integer res

res = messagebox("Delete","Are you sure you wish to delete the selected privilege?",Question!,yesno!,2)

if res = 1 then
	this.deleterow(this.getrow())
end if

this.update()

return 0
end event

event buttonclicked;call super::buttonclicked;integer i

for i = 1 to this.rowcount()
	this.setitem(i,"selected",1)
next
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type cb_3 from commandbutton within w_invoice_printing_14
integer x = 2779
integer y = 32
integer width = 256
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_browse.print()
end event

type rb_ddr from radiobutton within w_invoice_printing_14
integer x = 2994
integer y = 168
integer width = 544
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Detail (Date Range)"
end type

event clicked;dw_browse.dataobject = "d_frm_facility_invoice_detail"
dw_browse.settransobject(sqlca)
dw_browse.title = "Detail Date Range"
ii_usedates = 1
end event

type rb_all from radiobutton within w_invoice_printing_14
integer x = 2990
integer y = 244
integer width = 562
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All Open (No Range)"
end type

event clicked;dw_browse.dataobject = "d_frm_facility_invoice_all_open"
dw_browse.settransobject(sqlca)
dw_browse.title = "All Open"

ii_usedates = 0
end event

type rb_sdree from radiobutton within w_invoice_printing_14
integer x = 2359
integer y = 176
integer width = 608
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Summary (Date Range)"
boolean checked = true
end type

event clicked;dw_browse.dataobject = "d_frm_facility_invoice_summary"
dw_browse.settransobject(sqlca)
dw_browse.title = "Summary Date Range"
//st_mess.text = "Sets all REQUESTED Privileges to the update settings ,and sends all other active privileges to history."
ii_usedates = 1
end event

type rb_ldr from radiobutton within w_invoice_printing_14
integer x = 2359
integer y = 244
integer width = 571
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "List (Date Range)"
end type

event clicked;dw_browse.dataobject = "d_frm_facility_invoice_4_date"
dw_browse.settransobject(sqlca)
dw_browse.title = "List Date Range"
ii_usedates = 1
end event

type gb_1 from groupbox within w_invoice_printing_14
integer x = 1015
integer y = 120
integer width = 1285
integer height = 208
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Invoice Date Range"
end type

type cb_1 from commandbutton within w_invoice_printing_14
integer x = 3049
integer y = 32
integer width = 247
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;openwithparm(w_help_window,1)
end event

