$PBExportHeader$w_caqh_log_report.srw
forward
global type w_caqh_log_report from window
end type
type st_1 from statictext within w_caqh_log_report
end type
type cb_delete from commandbutton within w_caqh_log_report
end type
type dw_dates from u_dw within w_caqh_log_report
end type
type cb_print from commandbutton within w_caqh_log_report
end type
type dw_report from datawindow within w_caqh_log_report
end type
type cb_filt from commandbutton within w_caqh_log_report
end type
type cb_sort from commandbutton within w_caqh_log_report
end type
type cb_run from commandbutton within w_caqh_log_report
end type
type cb_close from commandbutton within w_caqh_log_report
end type
type gb_1 from groupbox within w_caqh_log_report
end type
end forward

global type w_caqh_log_report from window
integer width = 4389
integer height = 2304
boolean titlebar = true
string title = "CAQH Import Log"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_delete cb_delete
dw_dates dw_dates
cb_print cb_print
dw_report dw_report
cb_filt cb_filt
cb_sort cb_sort
cb_run cb_run
cb_close cb_close
gb_1 gb_1
end type
global w_caqh_log_report w_caqh_log_report

type variables
w_prac_data_1 iw_prac
end variables

forward prototypes
public function integer of_open_prac (long al_row)
public subroutine of_find_provider (long al_prac)
end prototypes

public function integer of_open_prac (long al_row);//Start Code Change ----03.17.2016 #V15 maha - added to open provider folder
long ll_prac
integer res


ll_prac = dw_report.getitemnumber(al_row, "prac_id")

IF gs_cust_type = "I" THEN
	IF NOT gb_sk_ver AND (IsNull(gi_prac_tab) OR gi_prac_tab <> 1) THEN 	
		IF NOT Isvalid(w_prac_data_intelliapp) THEN
			OpenSheet( w_prac_data_intelliapp, w_mdi, 4, original!)
			w_prac_data_intelliapp.move(0,0)
			w_prac_data_intelliapp.BringToTop = TRUE
		END IF
		iw_prac = w_prac_data_intelliapp	
	ELSE //smart
		IF NOT Isvalid(w_prac_data_sk) THEN
			OpenSheet( w_prac_data_SK, w_mdi, 4, original!)
		END IF
		iw_prac = w_prac_data_SK
	END IF
ELSE //cred
	IF NOT Isvalid(w_prac_data_1) THEN
		OpenSheet( w_prac_data_1, w_mdi, 4, original!)
	END IF
	
	iw_prac = w_prac_data_1
END IF

iw_prac.BringToTop = TRUE

w_caqh_log_report.post of_find_provider( ll_prac)

//// Find appropriate practitioner
//
//luo_search = iw_prac.tab_1.tabpage_search.uo_search
//debugbreak()
//res = luo_search.dw_org_facility_select.SetItem( 1, "facility_id", 1)
//
//luo_search.ddlb_search_type.SelectItem ('Prac ID',1 )	
//luo_search.sle_srch_val.Text = String(ll_prac)
//luo_search.ddlb_status.selectitem(2)
//iw_prac.ib_skip_inactive_mess = true
//
//luo_search.cb_search.TriggerEvent(Clicked!)
////luo_search.cb_select.TriggerEvent(Clicked!)

return 1

//Parent.post of_goto_practitioner( ll_prac_id, ll_facility_id, ll_parent_facility_id, ll_rec_id, ll_seq_no, ls_moveto, ls_action)
end function

public subroutine of_find_provider (long al_prac);//Start Code Change ----03.17.2016 #V15 maha

long ll_prac
pfc_cst_u_extended_search luo_search

ll_prac = al_prac
// Find appropriate practitioner

luo_search = iw_prac.tab_1.tabpage_search.uo_search

luo_search.dw_org_facility_select.SetItem( 1, "facility_id", 0)

luo_search.ddlb_search_type.SelectItem ('Prac ID',1 )	
luo_search.sle_srch_val.Text = String(ll_prac)
luo_search.ddlb_status.selectitem(2)
iw_prac.ib_skip_inactive_mess = true

luo_search.cb_search.TriggerEvent(Clicked!)
luo_search.cb_select.TriggerEvent(Clicked!)
end subroutine

on w_caqh_log_report.create
this.st_1=create st_1
this.cb_delete=create cb_delete
this.dw_dates=create dw_dates
this.cb_print=create cb_print
this.dw_report=create dw_report
this.cb_filt=create cb_filt
this.cb_sort=create cb_sort
this.cb_run=create cb_run
this.cb_close=create cb_close
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.cb_delete,&
this.dw_dates,&
this.cb_print,&
this.dw_report,&
this.cb_filt,&
this.cb_sort,&
this.cb_run,&
this.cb_close,&
this.gb_1}
end on

on w_caqh_log_report.destroy
destroy(this.st_1)
destroy(this.cb_delete)
destroy(this.dw_dates)
destroy(this.cb_print)
destroy(this.dw_report)
destroy(this.cb_filt)
destroy(this.cb_sort)
destroy(this.cb_run)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event open;if upper(gs_user_id ) = 'MASTER' then
	cb_delete.visible = true
//elseif upper(gs_user_id ) = 'USER1' then
//	cb_delete.visible = true	
end if
	
end event

event resize;//Start Code Change ----05.25.2016 #V152 maha
long lw
long lh

lw = This.WorkSpaceWidth()
lh = This.WorkSpaceHeight()

dw_report.width = lw - 10
dw_report.height = lh - dw_report.y - 10
end event

type st_1 from statictext within w_caqh_log_report
integer x = 1646
integer y = 16
integer width = 1189
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Double-click log entry to open the Provider folder"
boolean focusrectangle = false
end type

type cb_delete from commandbutton within w_caqh_log_report
boolean visible = false
integer x = 2606
integer y = 100
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer r

r = messagebox("Delete","Are you sure you want to delete the selected row?",question!,yesno!,2)

if r = 2 then return

dw_report.deleterow(dw_report.getrow())

dw_report.update()
end event

type dw_dates from u_dw within w_caqh_log_report
integer x = 123
integer y = 56
integer width = 960
integer height = 136
integer taborder = 10
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

type cb_print from commandbutton within w_caqh_log_report
integer x = 3657
integer y = 100
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;dw_report.print()
end event

type dw_report from datawindow within w_caqh_log_report
integer x = 5
integer y = 232
integer width = 4347
integer height = 1968
integer taborder = 20
string title = "none"
string dataobject = "d_rpt_caqh_log_prac"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked; long r

r = this.getclickedrow()

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

event doubleclicked;//Start Code Change ----03.17.2016 #V15 maha
if row < 1 then return
of_open_prac(row) //Start Code Change ----03.17.2016 #V15 maha - added to open prac folder
end event

type cb_filt from commandbutton within w_caqh_log_report
integer x = 2958
integer y = 100
integer width = 343
integer height = 92
integer taborder = 30
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

dw_report.SetFilter(null_str)

dw_report.Filter()
end event

type cb_sort from commandbutton within w_caqh_log_report
integer x = 3305
integer y = 100
integer width = 343
integer height = 92
integer taborder = 20
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
dw_report.Setsort(null_str)
dw_report.sort()
end event

type cb_run from commandbutton within w_caqh_log_report
integer x = 1111
integer y = 100
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
end type

event clicked;//Start Code Change ----08.19.2009 #V92 maha - modified to datetime for sql server
datetime ldt_from_date
datetime ldt_to_date

dw_dates.accepttext()

if isnull(dw_dates.GetItemDate( 1, "from_date" )) then
	ldt_from_date = datetime(date("2000-01-01"),time("00:00:00"))
else
	ldt_from_date = datetime(dw_dates.GetItemDate( 1, "from_date" ),time("00:00:00"))
end if

if isnull( dw_dates.GetItemDate( 1, "to_date" ) ) then
	//---------Begin Modified by (Appeon)Stephen 04.09.2014 for Bug 3995: CAQH log is showing nothing for the completed import--------
	//ldt_to_date = datetime(date("2999-01-01"),time("59:59:59"))
	ldt_to_date = datetime(date("2999-01-01"),time("23:59:59"))
	//---------End Modfiied ------------------------------------------------------		
else
	//---------Begin Modified by (Appeon)Stephen 04.09.2014 for Bug 3995: CAQH log is showing nothing for the completed import--------
	//ldt_to_date =  datetime( dw_dates.GetItemDate( 1, "to_date" ),time("00:00:00"))
	ldt_to_date =  datetime( dw_dates.GetItemDate( 1, "to_date" ),time("23:59:59"))
	//---------End Modfiied ------------------------------------------------------
end if

dw_report.settransobject(sqlca)
dw_report.retrieve(ldt_from_date,ldt_to_date)
//End Code Change---08.09.2009

end event

type cb_close from commandbutton within w_caqh_log_report
integer x = 4005
integer y = 100
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close (parent)
end event

type gb_1 from groupbox within w_caqh_log_report
integer x = 14
integer width = 1481
integer height = 212
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Range"
end type

