$PBExportHeader$w_npdb_itp_tracking_report.srw
forward
global type w_npdb_itp_tracking_report from window
end type
type cb_2 from commandbutton within w_npdb_itp_tracking_report
end type
type rb_log from radiobutton within w_npdb_itp_tracking_report
end type
type rb_dllog from radiobutton within w_npdb_itp_tracking_report
end type
type rb_track from radiobutton within w_npdb_itp_tracking_report
end type
type dw_date_range from u_dw within w_npdb_itp_tracking_report
end type
type cb_1 from commandbutton within w_npdb_itp_tracking_report
end type
type rb_all from radiobutton within w_npdb_itp_tracking_report
end type
type rb_inc from radiobutton within w_npdb_itp_tracking_report
end type
type rb_comp from radiobutton within w_npdb_itp_tracking_report
end type
type cb_get from commandbutton within w_npdb_itp_tracking_report
end type
type cb_print from commandbutton within w_npdb_itp_tracking_report
end type
type cb_export from commandbutton within w_npdb_itp_tracking_report
end type
type dw_1 from datawindow within w_npdb_itp_tracking_report
end type
type cb_sort from commandbutton within w_npdb_itp_tracking_report
end type
type cb_filter from commandbutton within w_npdb_itp_tracking_report
end type
type cb_close from commandbutton within w_npdb_itp_tracking_report
end type
type gb_1 from groupbox within w_npdb_itp_tracking_report
end type
type gb_2 from groupbox within w_npdb_itp_tracking_report
end type
type gb_type from groupbox within w_npdb_itp_tracking_report
end type
end forward

global type w_npdb_itp_tracking_report from window
integer width = 4261
integer height = 2256
boolean titlebar = true
string title = "NPDB ITP Tracking Report"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
rb_log rb_log
rb_dllog rb_dllog
rb_track rb_track
dw_date_range dw_date_range
cb_1 cb_1
rb_all rb_all
rb_inc rb_inc
rb_comp rb_comp
cb_get cb_get
cb_print cb_print
cb_export cb_export
dw_1 dw_1
cb_sort cb_sort
cb_filter cb_filter
cb_close cb_close
gb_1 gb_1
gb_2 gb_2
gb_type gb_type
end type
global w_npdb_itp_tracking_report w_npdb_itp_tracking_report

type variables
//------------ APPEON BEGIN ------------
//$<Add> 12.23.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
long il_Interface
constant long ITP_INTERFACE  = 1
constant long QRXS_INTERFACE = 2
//------------ APPEON END --------------
end variables

forward prototypes
public function integer of_set_rbs (boolean ab_true)
end prototypes

public function integer of_set_rbs (boolean ab_true);//Start Code Change ----09.07.2012 #V12 maha
if not ab_true then 
	rb_all.checked = true 
	rb_comp.checked = false
	rb_inc.checked = false
end if

rb_all.enabled = ab_true
rb_comp.enabled = ab_true
rb_inc.enabled = ab_true

return 1
end function

on w_npdb_itp_tracking_report.create
this.cb_2=create cb_2
this.rb_log=create rb_log
this.rb_dllog=create rb_dllog
this.rb_track=create rb_track
this.dw_date_range=create dw_date_range
this.cb_1=create cb_1
this.rb_all=create rb_all
this.rb_inc=create rb_inc
this.rb_comp=create rb_comp
this.cb_get=create cb_get
this.cb_print=create cb_print
this.cb_export=create cb_export
this.dw_1=create dw_1
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.cb_close=create cb_close
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_type=create gb_type
this.Control[]={this.cb_2,&
this.rb_log,&
this.rb_dllog,&
this.rb_track,&
this.dw_date_range,&
this.cb_1,&
this.rb_all,&
this.rb_inc,&
this.rb_comp,&
this.cb_get,&
this.cb_print,&
this.cb_export,&
this.dw_1,&
this.cb_sort,&
this.cb_filter,&
this.cb_close,&
this.gb_1,&
this.gb_2,&
this.gb_type}
end on

on w_npdb_itp_tracking_report.destroy
destroy(this.cb_2)
destroy(this.rb_log)
destroy(this.rb_dllog)
destroy(this.rb_track)
destroy(this.dw_date_range)
destroy(this.cb_1)
destroy(this.rb_all)
destroy(this.rb_inc)
destroy(this.rb_comp)
destroy(this.cb_get)
destroy(this.cb_print)
destroy(this.cb_export)
destroy(this.dw_1)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.cb_close)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_type)
end on

event open;dw_1.settransobject(sqlca)

//------------------- APPEON BEGIN -------------------
//$<Add> 12.23.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
il_Interface = of_get_app_setting("set_8", "I")
choose case il_Interface
	case ITP_INTERFACE
	case else //QRXS_INTERFACE //Start Code Change ----07.23.2012 #V12 maha - default to qrsx
		this.Title = "NPDB Tracking Report"
		dw_1.Modify("t_4.text = 'NPDB Tracking Data'")
end choose
//------------------- APPEON END ---------------------
end event

type cb_2 from commandbutton within w_npdb_itp_tracking_report
boolean visible = false
integer x = 3899
integer y = 208
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Existing Files"
end type

event clicked;////Start Code Change ----10.23.2013 #V14 maha - added to test report creation functionality
//cannot really be run as not all instance objects are created.
//open(w_npdb_qrxs_file_util)
end event

type rb_log from radiobutton within w_npdb_itp_tracking_report
integer x = 1701
integer y = 204
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Err log"
end type

event clicked;dw_1.dataobject =  "d_npdb_qrxs_log"
dw_1.settransobject(sqlca)
of_set_rbs( false)
end event

type rb_dllog from radiobutton within w_npdb_itp_tracking_report
integer x = 1408
integer y = 204
integer width = 288
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "D/L log"
end type

event clicked;dw_1.dataobject = "d_npdb_download_log"
dw_1.settransobject(sqlca)
of_set_rbs( false)
end event

type rb_track from radiobutton within w_npdb_itp_tracking_report
integer x = 1088
integer y = 208
integer width = 288
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Tracking"
boolean checked = true
end type

event clicked;dw_1.dataobject = "d_npdb_tracker_report"
dw_1.settransobject(sqlca)

of_set_rbs(true)
end event

type dw_date_range from u_dw within w_npdb_itp_tracking_report
integer x = 46
integer y = 76
integer width = 946
integer height = 144
integer taborder = 50
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

type cb_1 from commandbutton within w_npdb_itp_tracking_report
integer x = 2062
integer y = 180
integer width = 338
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Err Codes"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-15 By: Scofield
//$<Reason> Check the current is lower than zero.

//string s
//
//s = dw_1.getitemstring(dw_1.getrow(),"cust_3")
//
//OpenWithParm(w_npdb_reject_codes,s)

long		ll_Row
String	ls_Cust3

ll_Row = dw_1.GetRow()
if ll_Row <= 0 or ll_Row > dw_1.RowCount() then Return

ls_Cust3 = dw_1.GetItemString(ll_Row,"cust_3")

OpenWithParm(w_npdb_reject_codes,ls_Cust3)
//---------------------------- APPEON END ----------------------------

end event

type rb_all from radiobutton within w_npdb_itp_tracking_report
integer x = 1083
integer y = 56
integer width = 160
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;dw_1.setfilter("")
dw_1.filter()
dw_1.sort()
end event

type rb_inc from radiobutton within w_npdb_itp_tracking_report
integer x = 1637
integer y = 56
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Incomplete"
end type

event clicked;dw_1.setfilter("isnull(r_date)")
dw_1.filter()
dw_1.sort()
end event

type rb_comp from radiobutton within w_npdb_itp_tracking_report
integer x = 1294
integer y = 56
integer width = 320
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Complete"
end type

event clicked;dw_1.setfilter("not isnull(r_date)")
dw_1.filter()
dw_1.sort()

end event

type cb_get from commandbutton within w_npdb_itp_tracking_report
integer x = 2057
integer y = 52
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Get Data"
end type

event clicked;string ls_filter
string ls_from
string ls_to
DateTime ldt_From, ldt_To

//Start Code Change ----09.05.2012 #V12 maha - changed from em to dw
//ls_from = em_from.text
//ls_to = em_to.text

//BEGIN --- Modify by Evan on 12.23.2009
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05/27/2008 By: Ken.Guo
//$<reason> Fix BugS050608. Need use currency date format.
/*
if ls_from = 'none' then ls_from = "01/01/2000"
if ls_to = 'none' then ls_to = "01/01/2200"	
*/
//if ls_from = 'none' then ls_from = "2000-01-01"
//if ls_to = 'none' then ls_to = "2200-01-01"	
//---------------------------- APPEON END ----------------------------

//debugbreak()
//dw_1.retrieve(date(ls_from),date(ls_to))

dw_date_range.accepttext()
ls_from = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 



if ls_from = "none" or ls_from = "" or ls_from = "00/00/0000" or isnull(ls_from) then
	ls_from = "2000-01-01"
end if
if ls_to = "none" or ls_to = "" or  isnull(ls_to) or ls_to = "00/00/0000" then
	ls_to = "2200-01-01"
end if
//End Code Change ----09.05.2012

ldt_From = DateTime(date(ls_from), 00:00:00)
ldt_To = DateTime(date(ls_to), 23:59:59)
dw_1.Retrieve(ldt_From, ldt_To)
//END --- Modify by Evan on 12.23.2009

if rb_all.checked then
	ls_filter = ""
elseif rb_comp.checked then
	ls_filter = "not isnull(r_date)"
elseif rb_inc.checked then
	ls_filter =  "isnull(r_date)"
end if

dw_1.setfilter(ls_filter)
dw_1.filter()
dw_1.sort()

end event

type cb_print from commandbutton within w_npdb_itp_tracking_report
integer x = 2414
integer y = 52
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;dw_1.print()
end event

type cb_export from commandbutton within w_npdb_itp_tracking_report
integer x = 2766
integer y = 52
integer width = 343
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;gnv_dw.of_SaveAs(dw_1)//.saveas() Modify by Evan 05.11.2010
end event

type dw_1 from datawindow within w_npdb_itp_tracking_report
integer x = 37
integer y = 304
integer width = 4155
integer height = 1836
integer taborder = 90
string title = "none"
string dataobject = "d_npdb_tracker_report"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long i

i = this.getclickedrow()
this.setrow(i)
this .selectrow(0,false)
this.selectrow(i,true)
end event

type cb_sort from commandbutton within w_npdb_itp_tracking_report
integer x = 3118
integer y = 52
integer width = 343
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.Setsort(null_str)

dw_1.sort()
end event

type cb_filter from commandbutton within w_npdb_itp_tracking_report
integer x = 3470
integer y = 52
integer width = 343
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.SetFilter(null_str)

dw_1.Filter()
end event

type cb_close from commandbutton within w_npdb_itp_tracking_report
integer x = 3831
integer y = 52
integer width = 343
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type gb_1 from groupbox within w_npdb_itp_tracking_report
integer x = 1042
integer width = 965
integer height = 144
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status"
end type

type gb_2 from groupbox within w_npdb_itp_tracking_report
integer x = 27
integer width = 987
integer height = 284
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Send Date Range (Optional)"
end type

type gb_type from groupbox within w_npdb_itp_tracking_report
integer x = 1047
integer y = 156
integer width = 965
integer height = 128
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Type"
end type

