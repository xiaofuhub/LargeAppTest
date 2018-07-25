$PBExportHeader$w_logview.srw
forward
global type w_logview from window
end type
type st_1 from statictext within w_logview
end type
type dw_logview_filter from datawindow within w_logview
end type
type st_tip from statictext within w_logview
end type
type cb_close from commandbutton within w_logview
end type
type cb_print from commandbutton within w_logview
end type
type cb_export from commandbutton within w_logview
end type
type cb_clear from commandbutton within w_logview
end type
type dw_viewlog from datawindow within w_logview
end type
type gb_1 from groupbox within w_logview
end type
end forward

global type w_logview from window
integer width = 2706
integer height = 1384
boolean titlebar = true
string title = "Log Viewer"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
dw_logview_filter dw_logview_filter
st_tip st_tip
cb_close cb_close
cb_print cb_print
cb_export cb_export
cb_clear cb_clear
dw_viewlog dw_viewlog
gb_1 gb_1
end type
global w_logview w_logview

type variables
long il_cache_id
end variables

forward prototypes
public function integer f_fresh_filter ()
end prototypes

public function integer f_fresh_filter ();
dw_logview_filter.settransobject(CC_tansobject)

DataWindowChild ldwc_version
dw_logview_filter.GetChild("type_filter", ldwc_version ) 

ldwc_version.settransobject(CC_tansobject)
ldwc_version.retrieve()
ldwc_version.InsertRow(1)
ldwc_version.SetItem(1,"log_title",'All')

dw_logview_filter.Insertrow(0)

return 1
end function

on w_logview.create
this.st_1=create st_1
this.dw_logview_filter=create dw_logview_filter
this.st_tip=create st_tip
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_export=create cb_export
this.cb_clear=create cb_clear
this.dw_viewlog=create dw_viewlog
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.dw_logview_filter,&
this.st_tip,&
this.cb_close,&
this.cb_print,&
this.cb_export,&
this.cb_clear,&
this.dw_viewlog,&
this.gb_1}
end on

on w_logview.destroy
destroy(this.st_1)
destroy(this.dw_logview_filter)
destroy(this.st_tip)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_export)
destroy(this.cb_clear)
destroy(this.dw_viewlog)
destroy(this.gb_1)
end on

event open;il_cache_id=message.DoubleParm
dw_viewlog.retrieve(il_cache_id)

f_fresh_filter()
end event

type st_1 from statictext within w_logview
integer x = 32
integer y = 1176
integer width = 169
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Type:"
boolean focusrectangle = false
end type

type dw_logview_filter from datawindow within w_logview
integer x = 210
integer y = 1156
integer width = 526
integer height = 96
integer taborder = 60
string title = "none"
string dataobject = "d_log_view_filter"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_type

ls_type = data

if data='All' then
	dw_viewlog.SetFilter("")
else
	dw_viewlog.SetFilter("log_title = '"+ ls_type +" '")
end if

dw_viewlog.Filter()

dw_viewlog.Event RowFocusChanged(dw_viewlog.GetRow())
end event

type st_tip from statictext within w_logview
integer x = 759
integer y = 1168
integer width = 750
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217729
long backcolor = 33551856
string text = " Doubleclicked view log  detail."
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_logview
integer x = 2395
integer y = 1156
integer width = 288
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;
if isvalid(w_log_detail) then close(w_log_detail)

close(parent)
end event

type cb_print from commandbutton within w_logview
integer x = 2098
integer y = 1156
integer width = 288
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

event clicked;if dw_viewlog.rowcount()<1 then return
dw_viewlog.print()
end event

type cb_export from commandbutton within w_logview
integer x = 1801
integer y = 1156
integer width = 288
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;if dw_viewlog.rowcount()<1 then return
gnv_dw.of_SaveAs(dw_viewlog)//.saveas() Modify by Evan 05.11.2010
end event

type cb_clear from commandbutton within w_logview
integer x = 1504
integer y = 1156
integer width = 288
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear &All"
end type

event clicked;
if dw_viewlog.rowcount()<1 then return

long ll_return
ll_return=MessageBox("Log Viewer", "Do you want to save  before clearing all?", Question!, YesNoCancel!)

IF  ll_return= 3 THEN
	RETURN
elseif ll_return= 1 then
	cb_export.triggerevent(clicked!)
END IF

delete from update_log where cache_id=:il_cache_id using CC_tansobject;

dw_viewlog.reset( )
f_fresh_filter()
end event

type dw_viewlog from datawindow within w_logview
integer width = 2683
integer height = 1104
integer taborder = 10
string title = "none"
string dataobject = "d_viewlog"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(CC_tansobject)
end event

event clicked;If row > 0 Then
	This.SelectRow(0, FALSE)
	This.scrolltorow(row)
	This.SelectRow(row, TRUE)
End If

end event

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

event doubleclicked;if row>0 then
open(w_log_detail)
w_log_detail.tab_1.tabpage_1.dw_log_detail.scrolltorow(row)
end if
end event

type gb_1 from groupbox within w_logview
integer x = 9
integer y = 1100
integer width = 745
integer height = 192
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filter"
end type

