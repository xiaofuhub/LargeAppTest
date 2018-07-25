$PBExportHeader$w_recred_log.srw
forward
global type w_recred_log from window
end type
type cb_2 from commandbutton within w_recred_log
end type
type cb_sort from commandbutton within w_recred_log
end type
type dw_dates from u_dw within w_recred_log
end type
type dw_log from datawindow within w_recred_log
end type
type cb_run from commandbutton within w_recred_log
end type
type cb_close from commandbutton within w_recred_log
end type
end forward

global type w_recred_log from window
integer width = 2885
integer height = 2880
boolean titlebar = true
string title = "Recredentialing log"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_sort cb_sort
dw_dates dw_dates
dw_log dw_log
cb_run cb_run
cb_close cb_close
end type
global w_recred_log w_recred_log

on w_recred_log.create
this.cb_2=create cb_2
this.cb_sort=create cb_sort
this.dw_dates=create dw_dates
this.dw_log=create dw_log
this.cb_run=create cb_run
this.cb_close=create cb_close
this.Control[]={this.cb_2,&
this.cb_sort,&
this.dw_dates,&
this.dw_log,&
this.cb_run,&
this.cb_close}
end on

on w_recred_log.destroy
destroy(this.cb_2)
destroy(this.cb_sort)
destroy(this.dw_dates)
destroy(this.dw_log)
destroy(this.cb_run)
destroy(this.cb_close)
end on

event open;//Start Code Change ----08.21.2008 #V85 maha - window created for recred logs
dw_log.settransobject(sqlca)


end event

type cb_2 from commandbutton within w_recred_log
integer x = 2126
integer y = 68
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
dw_log.Setfilter(null_str)
dw_log.filter( )



end event

type cb_sort from commandbutton within w_recred_log
integer x = 1765
integer y = 68
integer width = 343
integer height = 92
integer taborder = 30
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

dw_log.SetSort(null_str)

dw_log.Sort( )

end event

type dw_dates from u_dw within w_recred_log
integer x = 215
integer y = 20
integer width = 969
integer height = 156
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

end event

event rbuttondown;call super::rbuttondown;integer 	li_Col
integer 	li_Rtn
datetime ldt_Null

SetNull(ldt_Null)

li_Col = this.GetClickedColumn()

li_Rtn = MessageBox("Set Null?","Would you like to set this date to null?",question!,yesno!,2 )

if li_Rtn = 1 then
	this.SetItem(Row,li_Col,ldt_Null)
end if

end event

type dw_log from datawindow within w_recred_log
integer x = 23
integer y = 196
integer width = 2834
integer height = 2532
integer taborder = 50
string title = "none"
string dataobject = "d_recred_log"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_run from commandbutton within w_recred_log
integer x = 1399
integer y = 68
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Run"
end type

event clicked;string ls_from_date
string ls_to_date
datetime ldt_from
datetime ldt_to

dw_dates.AcceptText()

ls_from_date = String( dw_dates.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_dates.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

IF ls_from_date = "" or IsNull( ls_from_date ) or ls_from_date = "00/00/0000" THEN
	ls_from_date = "01-01-2000"
END IF

IF ls_to_date = "" or IsNull( ls_to_date ) or ls_to_date = "00/00/0000" THEN
	ls_to_date = "12-12-2222"
END IF

ldt_from = datetime(date(ls_from_date),time("00:00:00"))
ldt_to = datetime(date(ls_to_date),time("23:59:59"))

dw_log.retrieve(ldt_from,ldt_to)


end event

type cb_close from commandbutton within w_recred_log
integer x = 2487
integer y = 68
integer width = 343
integer height = 92
integer taborder = 10
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

