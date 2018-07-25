$PBExportHeader$w_alert_audit.srw
forward
global type w_alert_audit from pfc_w_response
end type
type cb_delete from pfc_u_cb within w_alert_audit
end type
type st_run from statictext within w_alert_audit
end type
type cb_close from pfc_u_cb within w_alert_audit
end type
type cb_print from pfc_u_cb within w_alert_audit
end type
type cb_help from pfc_u_cb within w_alert_audit
end type
type cb_1 from pfc_u_cb within w_alert_audit
end type
type dw_alert from u_dw within w_alert_audit
end type
type dw_filter from u_dw within w_alert_audit
end type
end forward

global type w_alert_audit from pfc_w_response
integer x = 9
integer y = 248
integer width = 3776
integer height = 2356
string title = "Alert Audit"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
long backcolor = 33551856
boolean center = true
cb_delete cb_delete
st_run st_run
cb_close cb_close
cb_print cb_print
cb_help cb_help
cb_1 cb_1
dw_alert dw_alert
dw_filter dw_filter
end type
global w_alert_audit w_alert_audit

type variables
String	is_original_sql
String	is_filter
//String	is_status_filter
//Long		il_alert_id
Boolean	ib_TDLcall
n_ds		ids_steps

Long il_prac_id //alfee 11.30.2012

end variables

forward prototypes
public function integer wf_reset_st_run ()
public subroutine wf_run_filter ()
public subroutine wf_change_dwtitle (long al_alert_id)
end prototypes

public function integer wf_reset_st_run ();

st_run.BorderStyle = StyleRaised!
st_run.TextColor = RGB( 128, 0, 0 )
st_run.Enabled = True

return 0
end function

public subroutine wf_run_filter ();//
// Add by andy 01/14/2010 V10.1 - Notification Alert
//
String	ls_sql, ls_temp, ls_from_date, ls_to_date
Long		ll_temp

SetPointer(HourGlass!)
dw_alert.Reset()

If ib_TDLcall Then
	ib_TDLcall = False
	ls_sql = " Where " + is_filter
Else
	dw_filter.AcceptText()
	
	// table_name
	ls_temp = dw_filter.GetItemString( 1, "table_name" )
	
	IF ls_temp <> "All" THEN
		ls_sql = ls_sql + " AND alert_records.table_name = '" + ls_temp + "' "
	END IF
	
	// prac_id
	ls_temp = dw_filter.GetItemString(1, "sle_prac")
	IF ls_temp <> "" AND NOT IsNull( ls_temp ) THEN
		//ls_sql = ls_sql + " AND alert_records.prac_id= " + String( gl_prac_id )		
		ls_sql = ls_sql + " AND alert_records.prac_id= " + String( il_prac_id ) //alfee 11.30.2012
	END IF
	
	// exp_date
	ls_from_date = String(dw_filter.GetItemDate( 1, "exp_date_from" ), 'yyyy-mm-dd' ) 
	ls_to_date =  String( dw_filter.GetItemDate( 1, "exp_date_to" ), 'yyyy-mm-dd' ) 
	
	IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) THEN
		IF ls_to_date = "" OR IsNull( ls_to_date ) THEN		
			MessageBox("Select Error", "You must select a Thru Date" )
			dw_filter.SetColumn( "exp_date_to" )
			Return
		END IF
	END IF
	
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) THEN
		IF ls_from_date = "" OR IsNull( ls_from_date ) THEN		
			MessageBox("Select Error", "You must select a From Date" )
			dw_filter.SetColumn( "exp_date_from" )
			Return
		END IF
	END IF
	
	IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) THEN
		IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) THEN	
			ls_from_date = "'" + ls_from_date + "'"
			ls_to_date = "'" + ls_to_date + "'"
			
			ls_sql = ls_sql + " AND convert(varchar(10), alert_records.exp_date,121) >= " + ls_from_date +&
									" AND convert(varchar(10), alert_records.exp_date,121) <= " + ls_to_date 
	
		END IF
	END IF
	
	// active_status
	ll_temp = dw_filter.GetItemNumber( 1, "active_status" )
	IF ll_temp <> -1 THEN
		ls_sql = ls_sql + " AND alert_records.active_status = " + String(ll_temp)
	END IF
	
	// alert_id
	ll_temp = dw_filter.GetItemNumber( 1, "alert_id" )
	IF ll_temp <> 0 THEN
		ls_sql = ls_sql + " AND alert_records.alert_id = " + String(ll_temp)
	END IF
	// Change dw title according to alert name.
	wf_change_dwtitle(ll_temp)
	
	// alert_category
	ll_temp = dw_filter.GetItemNumber( 1, "alert_category" )
	IF ll_temp <> 0 THEN
		ls_sql = ls_sql + " AND alert_hdr.alert_category = " + String(ll_temp)
	END IF
	
	// alert_type
	ll_temp = dw_filter.GetItemNumber( 1, "alert_type" )
	IF ll_temp <> 0 THEN
		ls_sql = ls_sql + " AND alert_hdr.alert_type = " + String(ll_temp)
	END IF
	
	IF LenA(ls_sql) > 0 Then ls_sql = " Where " + MidA(ls_sql, 5)
	
End If

ls_sql = is_original_sql + ls_sql
dw_alert.Modify('DataWindow.Table.Select = "' + ls_sql + '"')
dw_alert.SetTransObject(SQLCA)
dw_alert.Retrieve()
end subroutine

public subroutine wf_change_dwtitle (long al_alert_id);//////////////////////////////////////////////////////////////////////////////
//
//	Function:
//	wf_change_dwtitle
//
//	Access:  	public
//
//	Arguments:  long al_alert_id
//
//	Returns:  <none>
//	
//	Description:
//	Change dw title according to alert name.
//////////////////////////////////////////////////////////////////////////////
//
// Add by andy 01/15/2010 V10.1 - Notification Alert
//

Long		ll_i, ll_cnt
Long       ll_alert_type
String	ls_syntax
String	ls_step_desc
n_cst_string lnvo_string

// Alert is All
If al_alert_id = 0  Then
	// Change dataobject directly instead of changing dw title.
	dw_alert.DataObject = 'd_na_alerts'
	dw_alert.SetTransobject(SQLCA)
	Return
End If

ids_steps.Reset()
ll_cnt = ids_steps.Retrieve(al_alert_id)

//---------Begin Added by (Appeon)Stephen 02.14.2017 for V15.3-Combined Expiring Credentials in Notifications--------
ll_alert_type = ids_steps.getitemnumber(1, "alert_hdr_alert_type")
if ll_alert_type = 40 then
	dw_alert.DataObject = 'd_na_alerts'
	dw_alert.SetTransobject(SQLCA)
	Return
end if
//---------End Added ------------------------------------------------------

// Change dw tile and set visible.
For ll_i = 1 To ll_cnt
	// Only support 10 steps.
	If ll_i > 10 Then Exit
	
	ls_step_desc = ids_steps.GetItemString(ll_i, "step_description")
	If PosA(ls_step_desc, "'") > 0 Then
		ls_step_desc  = lnvo_string.of_globalreplace( ls_step_desc, "'", "~~'")	
	End If
	
	ls_syntax += "step" + String(ll_i) + "_t.text='" + ls_step_desc + "' "
	ls_syntax += "step" + String(ll_i) + "_t.Visible='1' step" + String(ll_i) + ".Visible='1' "
Next

// Set invisible.
For ll_i = ll_cnt + 1 To 10
	ls_syntax += "step" + String(ll_i) + "_t.Visible='0' step" + String(ll_i) + ".Visible='0' "
Next

dw_alert.Modify(ls_syntax)

end subroutine

event open;call super::open;//
// Add by andy 01/14/2010 V10.1 - Notification Alert
//
Long		ll_alert_category
Long		ll_alert_type
Long		ll_active_status
n_cst_string lnvo_string

is_original_sql = dw_alert.Object.DataWindow.Table.Select

ids_steps = Create n_ds
ids_steps.DataObject = "d_na_step_browse"
ids_steps.SetTransObject(SQLCA)

//Format: category|type|status|Where
is_filter = Message.StringParm

dw_filter.of_SetDropDownCalendar( TRUE )
dw_filter.iuo_calendar.of_Register(dw_filter.iuo_calendar.DDLB)

If LenA(is_filter) > 0 Then
	ib_TDLcall = True
	ll_alert_category = Long(lnvo_string.of_gettoken(is_filter, "|"))
	ll_alert_type     = Long(lnvo_string.of_gettoken(is_filter, "|"))
	ll_active_status  = Long(lnvo_string.of_gettoken(is_filter, "|"))
	
	dw_filter.SetItem(1, "alert_category", ll_alert_category)
	dw_filter.SetItem(1, "alert_type", ll_alert_type)
	dw_filter.SetItem(1, "active_status", ll_active_status)
	
	wf_run_filter()
End If

end event

on w_alert_audit.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.st_run=create st_run
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_help=create cb_help
this.cb_1=create cb_1
this.dw_alert=create dw_alert
this.dw_filter=create dw_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.st_run
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.cb_help
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_alert
this.Control[iCurrent+8]=this.dw_filter
end on

on w_alert_audit.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.st_run)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_help)
destroy(this.cb_1)
destroy(this.dw_alert)
destroy(this.dw_filter)
end on

event close;call super::close;//
// Add by andy 01/15/2010 V10.1 - Notification Alert
//
If IsValid(ids_steps) Then Destroy ids_steps

end event

type cb_delete from pfc_u_cb within w_alert_audit
integer x = 1989
integer y = 36
integer width = 325
integer height = 84
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete"
boolean cancel = true
end type

event clicked;//
// Add by Evan 03/31/2010 V10.1 - Notification Alert
//
long ll_Row
long ll_RowCount
boolean lb_Selected = false

// Determine if delete records
ll_RowCount = dw_alert.RowCount()
for ll_Row = 1 to ll_RowCount
	if dw_alert.object.selected[ll_Row] = 1 then
		lb_Selected = true
		Exit
	end if
next
if lb_Selected then
	if MessageBox("Delete", "Are you sure that you want to permanently delete the selected record(s)?", Question!, YesNo!) = 2 then
		Return
	end if
else
	Return
end if

// Delete rows
dw_alert.SetRedraw(false)
for ll_Row = ll_RowCount to 1 step -1
	if dw_alert.object.selected[ll_Row] = 1 then
		dw_alert.DeleteRow(ll_Row)
	end if
next
dw_alert.SetRedraw(true)

// Update data
if dw_alert.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Update Data", "Failed to update data.", StopSign!)
end if
end event

type st_run from statictext within w_alert_audit
integer x = 1627
integer y = 36
integer width = 325
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 67108864
string text = "Run Filter"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//
// Add by andy 01/07/2010 V10.1 - Notification Alert
//
st_run.BorderStyle = StyleLowered!
st_run.TextColor = 0
st_run.Enabled = False

wf_run_filter()

end event

type cb_close from pfc_u_cb within w_alert_audit
integer x = 3374
integer y = 36
integer width = 325
integer height = 84
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close( Parent )
end event

type cb_print from pfc_u_cb within w_alert_audit
integer x = 2656
integer y = 36
integer width = 325
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Print"
boolean cancel = true
end type

event clicked;dw_alert.Print()
end event

type cb_help from pfc_u_cb within w_alert_audit
integer x = 2322
integer y = 36
integer width = 325
integer height = 84
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Sort"
boolean cancel = true
end type

event clicked;dw_alert.Event pfc_SortDlg()

dw_alert.SetFocus()
end event

type cb_1 from pfc_u_cb within w_alert_audit
integer x = 2990
integer y = 36
integer width = 325
integer height = 84
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Export"
boolean cancel = true
end type

event clicked;call super::clicked;gnv_dw.of_SaveAs(dw_alert)//.saveas() Modify by Evan 05.11.2010
ChangeDirectory(gs_current_path)
end event

type dw_alert from u_dw within w_alert_audit
integer x = 23
integer y = 544
integer width = 3680
integer height = 1676
integer taborder = 70
string dataobject = "d_na_alerts"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;This.of_SetUpdateAble( False )

This.of_SetTransObject(SQLCA)

This.of_setrowselect(True)
This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(1)

This.inv_sort.of_SetColumnHeader(True)

end event

event buttonclicked;call super::buttonclicked;//
// Add by Evan 03/31/2010 V10.1 - Notification Alert
//
long ll_Row
long ll_Selected

choose case dwo.name
	case "b_select"
		if this.object.b_select.text = "S" then
			this.object.b_select.text = "D"
			ll_Selected = 1
		else
			this.object.b_select.text = "S"
			ll_Selected = 0
		end if
		
		this.SetRedraw(false)
		for ll_Row = 1 to this.RowCount()
			this.SetItem(ll_Row, "selected", ll_Selected)
		next
		this.SetRedraw(true)
	case "b_show_msg"
		MessageBox("Last Result", this.GetItemString(Row, "last_result"))
end choose
end event

type dw_filter from u_dw within w_alert_audit
integer x = 18
integer y = 152
integer width = 3694
integer height = 416
integer taborder = 10
string dataobject = "d_na_alerts_filter"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//
// Add by andy 01/08/2010 V10.1 - Notification Alert
//
DataWindowChild dwchild

This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

// table_name
This.GetChild( "table_name", dwchild )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "table_name_allias", "All" )
dwchild.SetItem( 1, "table_name", "All" )
dwchild.SetItem( 1, "table_id", 0 )

This.SetItem( 1, "table_name", "All" )

// alert_category
This.GetChild( "alert_category", dwchild )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "alert_category_desc", "All" )
dwchild.SetItem( 1, "alert_category", 0 )

This.SetItem( 1, "alert_category", 0 )

// alert_type
This.GetChild( "alert_type", dwchild )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "alert_type_desc", "All" )
dwchild.SetItem( 1, "alert_type", 0 )
dwchild.SetItem( 1, "alert_category", 0 )

This.SetItem( 1, "alert_type", 0 )

// alert_id
This.GetChild( "alert_id", dwchild )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "alert_name", "All" )
dwchild.SetItem( 1, "alert_id", 0 )
dwchild.SetItem( 1, "alert_type", 0 )
dwchild.SetItem( 1, "alert_category", 0 )

This.SetItem( 1, "alert_id", 0 )

end event

event itemchanged;call super::itemchanged;//
// Add by andy 01/08/2010 V10.1 - Notification Alert
//
wf_reset_st_run()

end event

event buttonclicked;call super::buttonclicked;//
// Add by andy 01/08/2010 V10.1 - Notification Alert
//

Choose Case lower(dwo.name)
	Case "b_search"
		gs_search lstr_search
		
		lstr_search.stran_transaction = SQLCA
		lstr_search.ls_open_for = "AUDIT" 
		
		OpenWithParm( w_extended_search_new , lstr_search )
		
		IF Message.DoubleParm = -1 THEN
			Return -1				
		ELSE
			nv_prac_info lnv_full_name
			lnv_full_name = CREATE nv_prac_info
			String ls_name
			//---Begin Modified by Alfee 11.30.2012 ------
			il_prac_id = Message.DoubleParm
			ls_name = lnv_full_name.of_get_name( il_prac_id )
			//ls_name = lnv_full_name.of_get_name( gl_prac_id )
			//---End Modified --------------------------------
			DESTROY lnv_full_name
			dw_filter.setitem(1,"sle_prac",ls_name)
			wf_reset_st_run( )
		END IF
		
	Case "b_reset"
		datetime ldt_null
		
		setnull(ldt_null)
		
		dw_filter.setitem(1,"exp_date_from",ldt_null)
		dw_filter.setitem(1,"exp_date_to",ldt_null)
		dw_filter.setitem(1,"sle_prac","")
		//dw_filter.setitem(1,"active_status",1) //Start Code Change ----03.30.2010 #V10 maha - removed
		dw_filter.setitem(1,"alert_category",0)
		dw_filter.setitem(1,"alert_type",0)
		dw_filter.setitem(1,"alert_id",0)
		dw_filter.setitem(1,"table_name","All")
		
		wf_reset_st_run( )
		dw_alert.Reset()
End Choose

end event

