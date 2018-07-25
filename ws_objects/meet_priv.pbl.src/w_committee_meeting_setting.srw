$PBExportHeader$w_committee_meeting_setting.srw
forward
global type w_committee_meeting_setting from window
end type
type dw_detail from u_dw within w_committee_meeting_setting
end type
type dw_browse from u_dw within w_committee_meeting_setting
end type
type cb_add from commandbutton within w_committee_meeting_setting
end type
type cb_delete from commandbutton within w_committee_meeting_setting
end type
type cb_save from commandbutton within w_committee_meeting_setting
end type
type cb_close from commandbutton within w_committee_meeting_setting
end type
end forward

global type w_committee_meeting_setting from window
integer width = 3104
integer height = 1704
boolean titlebar = true
string title = "Committee Meeting Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_detail dw_detail
dw_browse dw_browse
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
end type
global w_committee_meeting_setting w_committee_meeting_setting

on w_committee_meeting_setting.create
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.Control[]={this.dw_detail,&
this.dw_browse,&
this.cb_add,&
this.cb_delete,&
this.cb_save,&
this.cb_close}
end on

on w_committee_meeting_setting.destroy
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> N/A  V11.3 Committee Proc Upd
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 06.27.2011
//////////////////////////////////////////////////////////////////////
integer li_val
datawindowchild ldwc_1, ldwc_d

dw_browse.getchild("facility_id", ldwc_1)
dw_detail.getchild("facility_id", ldwc_d)
ldwc_1.settransobject(sqlca)
ldwc_1.retrieve(gs_user_id)
ldwc_1.insertrow(1)
ldwc_1.setitem(1,"facility_facility_name", "Inactive")
ldwc_1.setitem(1,"facility_facility_id", -1)
ldwc_1.insertrow(1)
ldwc_1.setitem(1,"facility_facility_name", "All")
ldwc_1.setitem(1,"facility_facility_id", 0)
 ldwc_1.rowscopy(1, ldwc_1.rowcount(), primary!, ldwc_d,1,primary!)
 
li_val = w_mdi.of_security_access( 530 )
IF li_val  = 1 or  w_mdi.of_security_access(470)  = 1 THEN
	cb_add.enabled = false
	cb_delete.enabled = false
	cb_save.enabled = false
	dw_detail.enabled = false
else
end if

dw_browse.retrieve()

end event

event closequery;//////////////////////////////////////////////////////////////////////
// $<event> closequery
// $<arguments>
// $<returns> integer
// $<description> N/A  V11.3 Committee Proc Upd
//////////////////////////////////////////////////////////////////////
// $<add> 06.28.2011 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_Result

// Check data if changed
if dw_detail.AcceptText() = -1 then Return 1
if dw_browse.ModifiedCount() + dw_browse.DeletedCount() < 1 then
	Return 0
end if

// Ask you if save data
li_Result = MessageBox("Save", "The data is changed, would you like to save data?", Question!, YesNoCancel!)
if li_Result = 2 then
	Return 0
elseif li_Result = 3 then
	Return 1
end if

// Save data
if cb_save.Event Clicked() = 1 then
	Return 0
else
	Return 1
end if
end event

type dw_detail from u_dw within w_committee_meeting_setting
integer x = 50
integer y = 972
integer width = 3003
integer height = 592
integer taborder = 50
string dataobject = "d_committee_meeting_setting_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event other;call super::other;//////////////////////////////////////////////////////////////////////
// $<event> other
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 08.18.2011  V11.3 Committee Proc Upd
//////////////////////////////////////////////////////////////////////

if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0	
end if

if Message.Number = 522 then
	Return 1
end if
end event

type dw_browse from u_dw within w_committee_meeting_setting
integer x = 46
integer y = 196
integer width = 3003
integer height = 744
integer taborder = 50
string dataobject = "d_committee_meeting_setting_browse"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 06.27.2011  V11.3 Committee Proc Upd
//////////////////////////////////////////////////////////////////////

dw_browse.sharedata(dw_detail)
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 06.27.2011  V11.3 Committee Proc Upd
//////////////////////////////////////////////////////////////////////

if row <1 then return

this.selectrow(0, false)
this.selectrow(row, true)
this.setrow(row)
dw_detail.scrolltorow(row)
end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 06.27.2011  V11.3 Committee Proc Upd
//////////////////////////////////////////////////////////////////////

if currentrow <1 then return

this.selectrow(0, false)
this.selectrow(currentrow, true)
this.setrow(currentrow)
dw_detail.scrolltorow(currentrow)
end event

type cb_add from commandbutton within w_committee_meeting_setting
integer x = 1586
integer y = 52
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 06.27.2011  V11.3 Committee Proc Upd
//////////////////////////////////////////////////////////////////////

long ll_Row

if dw_detail.AcceptText() = -1 then Return -1

ll_Row = dw_browse.InsertRow(0)
dw_browse.ScrollToRow(ll_Row)

dw_detail.SetColumn("setup_name")
dw_detail.SetFocus()
end event

type cb_delete from commandbutton within w_committee_meeting_setting
integer x = 1957
integer y = 52
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> V11.3 Committee Proc Upd
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 06.27.2011 
//////////////////////////////////////////////////////////////////////
long ll_id, ll_cnt, ll_row
dwitemstatus lds_new

ll_row = dw_browse.GetRow()
if  ll_row < 1 then Return -1

lds_new = dw_browse.getitemstatus(ll_row,0,primary!)
if lds_new = new! or lds_new=newmodified! then
else
	ll_id = dw_browse.getitemnumber(ll_row, "setup_id")
	select count(1)
	  into  :ll_cnt
	  from committee_lookup
	where meeting_setting = :ll_id;
	
	if ll_cnt > 0 then
		messagebox("Delete Error", 'The row cannot be deleted from the database. It is being referenced by another record.',information! )	
		return 0
	end if
	
	if MessageBox("Delete", "Are you sure that you want to delete the selected record?", Question!, YesNo!, 2) = 2 then
		Return 0
	end if
end if

dw_browse.deleterow(ll_row)

dw_browse.SelectRow(0, false)
dw_browse.SelectRow(dw_browse.GetRow(), true)
dw_detail.ScrollToRow(dw_browse.GetRow())
end event

type cb_save from commandbutton within w_committee_meeting_setting
integer x = 2322
integer y = 52
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A  V11.3 Committee Proc Upd
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 06.28.2011
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_setup_id, ll_facility_id
dwitemstatus ldws_new
string ls_setup_name

// Check data if changed
if dw_detail.AcceptText() = -1 then Return -1
if dw_browse.ModifiedCount() + dw_browse.DeletedCount() < 1 then
	Return 1
end if

//// Check data if null
SELECT max(Setup_id) INTO :ll_setup_id FROM committee_meeting_settings ;
if IsNull(ll_setup_id) then ll_setup_id = 0
for ll_Row = 1 to dw_browse.RowCount()
	ldws_new = dw_browse.GetItemStatus(ll_Row, 0, Primary!)
		
	if  ldws_new = NewModified! or  ldws_new = dataModified! then
		ls_setup_name = dw_browse.getitemstring(ll_row, "setup_name")
		if isnull(ls_setup_name) or ls_setup_name = '' then
			dw_browse.ScrollToRow(ll_Row)
			dw_detail.SetColumn("setup_name")
			dw_detail.Post SetFocus()
			MessageBox("Warning", "Setup Name connot be null.", Exclamation!)
			Return -1
		end if
		
		ll_facility_id = dw_browse.getitemnumber(ll_row, "facility_id")
		if isnull(ll_facility_id)  then
			dw_browse.ScrollToRow(ll_Row)
			dw_detail.SetColumn("facility_id")
			dw_detail.Post SetFocus()
			MessageBox("Warning", "Facility connot be null.", Exclamation!)
			Return -1
		end if
		
		// Set primary keys of new record
		if ldws_new = NewModified! then
			ll_setup_id ++
			dw_browse.SetItem(ll_Row, "setup_id", ll_setup_id)
		end if

	end if
next

// Save data
if dw_browse.Update(true, false) = 1 then
	Commit;
else
	Rollback;
	MessageBox("Save", "Failed to save data.", StopSign!)
	Return -1
end if

// Update connected template records
dw_browse.ResetUpdate()

Return 1
end event

type cb_close from commandbutton within w_committee_meeting_setting
integer x = 2688
integer y = 52
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

