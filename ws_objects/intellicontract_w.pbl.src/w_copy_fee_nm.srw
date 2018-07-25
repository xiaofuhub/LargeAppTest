$PBExportHeader$w_copy_fee_nm.srw
forward
global type w_copy_fee_nm from w_response
end type
type em_fee2 from editmask within w_copy_fee_nm
end type
type em_fee from editmask within w_copy_fee_nm
end type
type em_fee2_perc from editmask within w_copy_fee_nm
end type
type em_fee_perc from editmask within w_copy_fee_nm
end type
type st_8 from statictext within w_copy_fee_nm
end type
type st_7 from statictext within w_copy_fee_nm
end type
type ddlb_end from dropdownlistbox within w_copy_fee_nm
end type
type ddlb_start from dropdownlistbox within w_copy_fee_nm
end type
type sle_end from singlelineedit within w_copy_fee_nm
end type
type sle_start from singlelineedit within w_copy_fee_nm
end type
type sle_times from singlelineedit within w_copy_fee_nm
end type
type cb_2 from u_cb within w_copy_fee_nm
end type
type cb_1 from u_cb within w_copy_fee_nm
end type
type st_fee2 from statictext within w_copy_fee_nm
end type
type st_end from statictext within w_copy_fee_nm
end type
type st_fee from statictext within w_copy_fee_nm
end type
type st_start from statictext within w_copy_fee_nm
end type
type st_2 from statictext within w_copy_fee_nm
end type
type st_1 from statictext within w_copy_fee_nm
end type
end forward

global type w_copy_fee_nm from w_response
integer width = 1989
integer height = 924
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
event ue_ok ( )
em_fee2 em_fee2
em_fee em_fee
em_fee2_perc em_fee2_perc
em_fee_perc em_fee_perc
st_8 st_8
st_7 st_7
ddlb_end ddlb_end
ddlb_start ddlb_start
sle_end sle_end
sle_start sle_start
sle_times sle_times
cb_2 cb_2
cb_1 cb_1
st_fee2 st_fee2
st_end st_end
st_fee st_fee
st_start st_start
st_2 st_2
st_1 st_1
end type
global w_copy_fee_nm w_copy_fee_nm

type variables
u_dw idw_fee
end variables

forward prototypes
public function datetime of_dateadd (string as_type, long al_inc, datetime adt_org)
end prototypes

event ue_ok();//Duplicate fee record - jervis 12.16.2010
boolean lb_check

int li_start,li_end
decimal{4} ldec_inc_fee,ldec_inc_fee2
decimal{4} ldec_inc_fee_perc,ldec_inc_fee2_perc
long ll_times,ll_i,ll_row
datetime ldt_start,ldt_end,ldt_temp
decimal{4} ldec_fee,ldec_fee2
string ls_start_type,ls_end_type
n_cst_datetime lnv_dt
decimal{4} ldec_temp
long ll_null

SetNull(ll_null)

ll_times = long(sle_times.text)
if ll_times > 0 then 
	li_start = long(sle_start.text)
	li_end = long(sle_end.text)
	ls_start_type = lower(ddlb_start.text)
	ls_end_type = lower(ddlb_end.text)
	ldec_inc_fee_perc = dec(em_fee_perc.text)
	ldec_inc_fee = dec(em_fee.text)
	ldec_inc_fee2_perc = dec(em_fee2_perc.text)
	ldec_inc_fee2 = dec(em_fee2.text)
	
	ll_row = idw_fee.getrow( )		
	ldt_start = idw_fee.GetItemDatetime( ll_row,"start_date")
	ldt_end = idw_fee.GetItemDatetime( ll_row,"end_date")
	ldec_fee = idw_fee.GetItemDecimal( ll_row,"fee")
	ldec_fee2 = idw_fee.GetItemDecimal( ll_row,"custom_fee1")
	for ll_i = 1 to ll_times
		idw_fee.RowsCopy( ll_row, ll_row, primary!, idw_fee, idw_fee.RowCount() + 1,Primary!)
		idw_fee.SetItem(idw_fee.RowCount(),'ctx_id',ll_null)
		//Set Start Date
		if idw_fee.Describe( "start_date.visible") = '1' and li_start > 0 and not isnull(ldt_start) then
			ldt_temp = of_dateadd(ls_start_type,ll_i*li_start,ldt_start)
			idw_fee.SetItem( idw_fee.RowCount(),"start_date", ldt_temp)
		end if
		
		//Set End Date
		if idw_fee.Describe( "end_date.visible") = '1' and li_end > 0 and not isnull(ldt_end) then
			ldt_temp = of_dateadd(ls_end_type,ll_i*li_end,ldt_end)
			idw_fee.SetItem( idw_fee.RowCount(),"end_date", ldt_temp)
		end if
		//Set Fee
		if idw_fee.Describe( "fee.visible") = '1' and (ldec_inc_fee > 0 or ldec_inc_fee_perc > 0)and not isnull(ldec_fee) then
			if ldec_inc_fee_perc > 0 then
				ldec_temp = ldec_fee*(1+ ll_i*ldec_inc_fee_perc/100)
			else
				ldec_temp = ll_i*ldec_inc_fee + ldec_fee
			end if
			idw_fee.SetItem( idw_fee.RowCount(),"fee", ldec_temp)
		end if
		
		//Set Fee2
		if idw_fee.Describe( "custom_fee1.visible") = '1' and (ldec_inc_fee2 > 0 or ldec_inc_fee2_perc > 0) and not isnull(ldec_fee2) then
			if ldec_inc_fee2_perc > 0 then
				ldec_temp = ldec_fee2*(1+ ll_i*ldec_inc_fee2_perc/100)
			else
				ldec_temp = ll_i*ldec_inc_fee2 + ldec_fee2
			end if
			idw_fee.SetItem( idw_fee.RowCount(),"custom_fee1", ldec_temp)
		end if
	next
end if

Close(this)

end event

public function datetime of_dateadd (string as_type, long al_inc, datetime adt_org);//Add by jervis 12.17.2010

n_cst_datetime lnv_dt
datetime ldt_new
date ld_new
time lt_temp

ld_new = date(adt_org)
lt_temp = time(adt_org)

choose case  lower(as_type)
	case 'day'
		ldt_new = datetime(RelativeDate ( ld_new, al_inc ),lt_temp)
	case 'month'
		ldt_new = datetime(lnv_dt.of_relativemonth(  ld_new, al_inc ),lt_temp)
	case 'year'
		ldt_new = datetime(lnv_dt.of_relativeyear(  ld_new, al_inc ),lt_temp)
	case else
		ldt_new = adt_org
end choose

return ldt_new
end function

on w_copy_fee_nm.create
int iCurrent
call super::create
this.em_fee2=create em_fee2
this.em_fee=create em_fee
this.em_fee2_perc=create em_fee2_perc
this.em_fee_perc=create em_fee_perc
this.st_8=create st_8
this.st_7=create st_7
this.ddlb_end=create ddlb_end
this.ddlb_start=create ddlb_start
this.sle_end=create sle_end
this.sle_start=create sle_start
this.sle_times=create sle_times
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_fee2=create st_fee2
this.st_end=create st_end
this.st_fee=create st_fee
this.st_start=create st_start
this.st_2=create st_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_fee2
this.Control[iCurrent+2]=this.em_fee
this.Control[iCurrent+3]=this.em_fee2_perc
this.Control[iCurrent+4]=this.em_fee_perc
this.Control[iCurrent+5]=this.st_8
this.Control[iCurrent+6]=this.st_7
this.Control[iCurrent+7]=this.ddlb_end
this.Control[iCurrent+8]=this.ddlb_start
this.Control[iCurrent+9]=this.sle_end
this.Control[iCurrent+10]=this.sle_start
this.Control[iCurrent+11]=this.sle_times
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.st_fee2
this.Control[iCurrent+15]=this.st_end
this.Control[iCurrent+16]=this.st_fee
this.Control[iCurrent+17]=this.st_start
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.st_1
end on

on w_copy_fee_nm.destroy
call super::destroy
destroy(this.em_fee2)
destroy(this.em_fee)
destroy(this.em_fee2_perc)
destroy(this.em_fee_perc)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.ddlb_end)
destroy(this.ddlb_start)
destroy(this.sle_end)
destroy(this.sle_start)
destroy(this.sle_times)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_fee2)
destroy(this.st_end)
destroy(this.st_fee)
destroy(this.st_start)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;call super::open;string ls_visible
string ls_label
idw_fee = Message.Powerobjectparm

//init duplicate UI
if idw_fee.Describe( "start_date.visible") = '1' then
	ls_label = idw_fee.Describe( "start_date_t.text")
	if len(ls_label) > 2 then
		st_start.text = "Increment " + ls_label + " by"
	end if
	sle_start.text  = '1'
else
	st_start.enabled = false
	sle_start.enabled = false
	ddlb_start.enabled = false
end if

if idw_fee.Describe( "end_date.visible") = '1' then
	ls_label = idw_fee.Describe( "end_date_t.text")
	if len(ls_label) > 2 then
		st_end.text = "Increment " + ls_label + " by"
	end if
	sle_end.text  = '1'
else
	st_end.enabled = false
	sle_end.enabled = false
	ddlb_end.enabled = false
end if

if idw_fee.Describe( "fee.visible") = '1' then
	ls_label = idw_fee.Describe( "fee_t.text")
	if len(ls_label) > 2 then
		st_fee.text = "Increment " + ls_label + " by"
	end if
	em_fee_perc.text = '1'
else
	st_fee.enabled = false
	em_fee_perc.enabled = false
	st_7.enabled = false
	em_fee.enabled = false
end if
	
if idw_fee.Describe( "custom_fee1.visible") = '1' then
	ls_label = idw_fee.Describe( "custom_fee1_t.text")
	if len(ls_label) > 2 then
		st_fee2.text = "Increment " + ls_label + " by"
	end if
	em_fee2_perc.text = '1'
else
	st_fee2.enabled = false
	em_fee2_perc.enabled = false
	st_8.enabled = false
	em_fee2.enabled = false
end if 

end event

type em_fee2 from editmask within w_copy_fee_nm
integer x = 1554
integer y = 628
integer width = 370
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "###,###.##"
double increment = 1
string minmax = "0~~"
end type

event modified;if dec(this.text) > 0 then em_fee2_perc.text = '0'
end event

type em_fee from editmask within w_copy_fee_nm
integer x = 1554
integer y = 524
integer width = 370
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "###,###.##"
double increment = 1
string minmax = "0~~"
end type

event modified;if dec(this.text) > 0 then em_fee_perc.text = '0'
end event

type em_fee2_perc from editmask within w_copy_fee_nm
integer x = 946
integer y = 628
integer width = 187
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##.##"
double increment = 1
string minmax = "0~~99"
end type

event modified;if dec(this.text) > 0 then em_fee2.text = '0'
end event

type em_fee_perc from editmask within w_copy_fee_nm
integer x = 946
integer y = 524
integer width = 187
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##.##"
double increment = 1
string minmax = "0~~99"
end type

event modified;if dec(this.text) > 0 then em_fee.text = '0'
end event

type st_8 from statictext within w_copy_fee_nm
integer x = 1138
integer y = 644
integer width = 411
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "% Or Set Amount"
boolean focusrectangle = false
end type

type st_7 from statictext within w_copy_fee_nm
integer x = 1138
integer y = 536
integer width = 411
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "% Or Set Amount"
boolean focusrectangle = false
end type

type ddlb_end from dropdownlistbox within w_copy_fee_nm
integer x = 1527
integer y = 412
integer width = 393
integer height = 324
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Day","Month","Year"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.selectitem( 1)
end event

type ddlb_start from dropdownlistbox within w_copy_fee_nm
integer x = 1527
integer y = 304
integer width = 393
integer height = 324
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Day","Month","Year"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.selectitem( 1)
end event

type sle_end from singlelineedit within w_copy_fee_nm
integer x = 1234
integer y = 412
integer width = 283
integer height = 84
integer taborder = 40
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

type sle_start from singlelineedit within w_copy_fee_nm
integer x = 1234
integer y = 304
integer width = 283
integer height = 84
integer taborder = 20
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

type sle_times from singlelineedit within w_copy_fee_nm
integer x = 480
integer y = 44
integer width = 174
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_2 from u_cb within w_copy_fee_nm
integer x = 1202
integer y = 788
integer taborder = 100
string text = "OK"
boolean default = true
end type

event clicked;call super::clicked;event ue_OK()
end event

type cb_1 from u_cb within w_copy_fee_nm
integer x = 1568
integer y = 788
integer taborder = 110
string text = "Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;close(parent)
end event

type st_fee2 from statictext within w_copy_fee_nm
integer x = 73
integer y = 636
integer width = 864
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Increase Fee 2 by"
boolean focusrectangle = false
end type

type st_end from statictext within w_copy_fee_nm
integer x = 73
integer y = 424
integer width = 731
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Increment End Date by"
boolean focusrectangle = false
end type

type st_fee from statictext within w_copy_fee_nm
integer x = 73
integer y = 532
integer width = 864
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Increase Fee by "
boolean focusrectangle = false
end type

type st_start from statictext within w_copy_fee_nm
integer x = 73
integer y = 320
integer width = 736
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Increment Start Date by"
boolean focusrectangle = false
end type

type st_2 from statictext within w_copy_fee_nm
integer x = 73
integer y = 232
integer width = 1006
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "For Each Duplicated Record:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_copy_fee_nm
integer x = 78
integer y = 56
integer width = 1006
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Duplicate Record   [###]   Times"
boolean focusrectangle = false
end type

