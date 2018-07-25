$PBExportHeader$w_contract_field_properties_dt_fill.srw
forward
global type w_contract_field_properties_dt_fill from window
end type
type st_hint from statictext within w_contract_field_properties_dt_fill
end type
type cb_add from commandbutton within w_contract_field_properties_dt_fill
end type
type cb_delete from commandbutton within w_contract_field_properties_dt_fill
end type
type cb_save from commandbutton within w_contract_field_properties_dt_fill
end type
type cb_close from commandbutton within w_contract_field_properties_dt_fill
end type
type cb_help from commandbutton within w_contract_field_properties_dt_fill
end type
type dw_datafill from datawindow within w_contract_field_properties_dt_fill
end type
end forward

global type w_contract_field_properties_dt_fill from window
integer width = 1467
integer height = 1368
boolean titlebar = true
string title = "Data Fill Properties for"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_hint st_hint
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
cb_help cb_help
dw_datafill dw_datafill
end type
global w_contract_field_properties_dt_fill w_contract_field_properties_dt_fill

type variables
long		il_ViewId,il_ScreenId
String	is_FieldName,is_LabelText,is_LookupName
end variables

forward prototypes
public subroutine wf_addrow ()
public function integer wf_verify ()
public function integer wf_save ()
end prototypes

public subroutine wf_addrow ();long		ll_Row
DateTime	ldt_ModifyDate

ldt_ModifyDate = DateTime(Today(),Now())
ll_Row = dw_datafill.InsertRow(0)
dw_datafill.SetItem(ll_Row,'data_view_id',il_ViewId)
dw_datafill.SetItem(ll_Row,'screen_id',il_ScreenId)
dw_datafill.SetItem(ll_Row,'field_name',is_FieldName)
dw_datafill.SetItem(ll_Row,'relative_days',0)

dw_datafill.SetItem(ll_Row,'modify_by',gs_user_id)
dw_datafill.SetItem(ll_Row,'modify_date',ldt_ModifyDate)

dw_datafill.SetItemStatus(ll_Row,0,Primary!,NotModified!)		//Set to New! status

dw_datafill.ScrollToRow(ll_Row)
dw_datafill.SetRow(ll_Row)
dw_datafill.SetColumn('field_name_fill')
dw_datafill.SetFocus()

end subroutine

public function integer wf_verify ();long		ll_Cycle,ll_ComCol,ll_Find,ll_RowCnt
String	ls_FillName,ls_MapName,ls_FillColType,ls_MapColType,ls_ComName

DataWindowChild	ldwc_FillChild,ldwc_MapChild
DWItemStatus		ldwis_Status

ll_RowCnt = dw_datafill.RowCount()
dw_datafill.GetChild('field_name_fill',ldwc_FillChild)
dw_datafill.GetChild('field_name_map',ldwc_MapChild)

for ll_Cycle = 1 to ll_RowCnt
	ldwis_Status = dw_datafill.GetItemStatus(ll_Cycle,0,Primary!)
	
	if ldwis_Status = New! then Continue
	
	ll_Find = 0
	ls_FillName = dw_datafill.GetItemString(ll_Cycle,'field_name_fill')
	if IsNull(ls_FillName) or Trim(ls_FillName) = '' then
		MessageBox(gnv_app.iapp_object.DisplayName,'Fill Field cannot be empty. Please select a value from the dropdown list.',Exclamation!)
		dw_datafill.SetRow(ll_Cycle)
		dw_datafill.SetColumn('field_name_fill')
		dw_datafill.SetFocus()
		Return -1
	end if
	
	for ll_ComCol = ll_Cycle + 1 to ll_RowCnt
		ls_ComName = dw_datafill.GetItemString(ll_ComCol,'field_name_fill')
		if ls_FillName = ls_ComName then
			MessageBox(gnv_app.iapp_object.DisplayName,"Value in the " + String(ll_Cycle) + " row duplicates with value in the " + String(ll_ComCol) + " row in Fill Field. Please select another value.",Exclamation!)
			dw_datafill.SetRow(ll_ComCol)
			dw_datafill.SetColumn('field_name_fill')
			dw_datafill.SetFocus()
			Return -1
		end if
	next
	
	if ldwis_Status = NotModified! then Continue
next

Return 1

end function

public function integer wf_save ();Integer	li_Rtn

dw_datafill.AcceptText()

if wf_verify() <> 1 then return -1

li_Rtn = dw_datafill.Update()

if li_Rtn = 1 then
	COMMIT USING sqlca;
	return 1
else
	ROLLBACK USING sqlca;
	return -1
end if


end function

on w_contract_field_properties_dt_fill.create
this.st_hint=create st_hint
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_help=create cb_help
this.dw_datafill=create dw_datafill
this.Control[]={this.st_hint,&
this.cb_add,&
this.cb_delete,&
this.cb_save,&
this.cb_close,&
this.cb_help,&
this.dw_datafill}
end on

on w_contract_field_properties_dt_fill.destroy
destroy(this.st_hint)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.dw_datafill)
end on

event open;long		ll_Cycle,ll_ColCnt,ll_Row
String	ls_ColName,ls_LabelText,ls_ColType,ls_Visible

DataWindowChild	ldwc_Child

il_ViewId = w_contract_data_design.uo_design.il_select_view
il_ScreenId = w_contract_data_design.uo_design.ii_screen_id
is_FieldName = w_contract_field_properties.dw_properties.GetItemString(1,'sys_fields_field_name')
is_LabelText = w_contract_data_design.uo_design.uo_band.dw_syntax.Describe(is_FieldName + "_t.Text")
if is_LabelText = "" or is_LabelText = "!" or is_LabelText = "?" then is_LabelText = is_FieldName
is_LookupName = w_contract_field_properties.dw_properties.GetItemString(1,'sys_fields_lookup_code')

This.Title   = "Data Fill Properties for " + is_LabelText
st_Hint.Text = "Hint: This feature allows you to automatically fill other date fields with a date that is a specific amount of days in the future of the " + is_LabelText + "."

dw_datafill.SetTransObject(SQLCA)
dw_datafill.Retrieve(il_ViewId,il_ScreenId,is_FieldName)

if dw_datafill.RowCount() <= 0 then wf_addrow()

ll_ColCnt = long(w_contract_data_design.uo_design.uo_band.dw_syntax.Object.DataWindow.Column.Count)
dw_datafill.GetChild('field_name_fill',ldwc_Child)

for ll_Cycle = 1 to ll_ColCnt
	if w_contract_data_design.uo_design.uo_band.dw_syntax.Describe("#" + String(ll_Cycle) + ".Key") = 'no' then
		ls_ColName = w_contract_data_design.uo_design.uo_band.dw_syntax.Describe("#" + String(ll_Cycle) + ".Name")
		if ls_ColName <> is_FieldName then
			ls_ColType = w_contract_data_design.uo_design.uo_band.dw_syntax.Describe("#" + String(ll_Cycle) + ".Coltype")
			ls_Visible = w_contract_data_design.uo_design.uo_band.dw_syntax.Describe("#" + String(ll_Cycle) + ".Visible")
			if (ls_ColType = "datetime" or ls_ColType = "date") and ls_Visible <> "0" then
				ll_Row = ldwc_Child.InsertRow(0)
				ldwc_Child.SetItem(ll_Row,'fillcolumn',ls_ColName)
				
				ls_LabelText = w_contract_data_design.uo_design.uo_band.dw_syntax.Describe(ls_ColName + "_t.Text")
				if ls_LabelText = "" or ls_LabelText = "!" or ls_LabelText = "?" then ls_LabelText = ls_ColName
				ldwc_Child.SetItem(ll_Row,'filllabel',ls_LabelText)
				
				ldwc_Child.SetItem(ll_Row,'coltype',ls_ColType)
			end if
		end if
	end if
next

ldwc_Child.SetSort("fillcolumn A")
ldwc_Child.Sort()

end event

event closequery;long	ll_DelCnt,ll_ModCnt,ll_Rtn

ll_DelCnt = dw_datafill.DeletedCount()
ll_ModCnt = dw_datafill.ModifiedCount()

if ll_DelCnt + ll_ModCnt > 0 then
	ll_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	
	if ll_Rtn = 1 then
		if wf_Save() = -1 then
			return 1
		end if
	elseif ll_Rtn = 3 then
		return 1
	end if
end if

return 0

end event

type st_hint from statictext within w_contract_field_properties_dt_fill
integer x = 18
integer y = 1112
integer width = 1413
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_add from commandbutton within w_contract_field_properties_dt_fill
integer x = 18
integer y = 1004
integer width = 279
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;wf_addrow()
end event

type cb_delete from commandbutton within w_contract_field_properties_dt_fill
integer x = 302
integer y = 1004
integer width = 279
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;long	ll_Row

ll_Row = dw_datafill.GetRow()

if ll_Row > 0 and ll_Row <= dw_datafill.RowCount() then
	dw_datafill.DeleteRow(ll_Row)
	if dw_datafill.RowCount() >= ll_Row then
		dw_datafill.SetRow(ll_Row)
	elseif dw_datafill.RowCount() > 0 then
		dw_datafill.SetRow(ll_Row - 1)
	end if
	dw_datafill.SetFocus()
end if

end event

type cb_save from commandbutton within w_contract_field_properties_dt_fill
integer x = 585
integer y = 1004
integer width = 279
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;wf_Save()
end event

type cb_close from commandbutton within w_contract_field_properties_dt_fill
integer x = 869
integer y = 1004
integer width = 279
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CloseWithReturn(Parent,'')
end event

type cb_help from commandbutton within w_contract_field_properties_dt_fill
integer x = 1152
integer y = 1004
integer width = 279
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
end type

event clicked;String	ls_Message

ls_Message = &
"Fill Field: Select the field that you want to automatically fill.~r~n~r~n" + &
"Relative Days: Input a specific amount of days which will be used as the interval between the " + is_LabelText + " field and Fill Field. (A negative number indicates a date before " + is_LabelText + "; a positive number indicates a date in the future of " + is_LabelText + ".)"

MessageBox("Help",ls_Message)

end event

type dw_datafill from datawindow within w_contract_field_properties_dt_fill
integer x = 18
integer y = 16
integer width = 1413
integer height = 960
integer taborder = 10
string dataobject = "d_contract_field_properties_dt_fill"
boolean vscrollbar = true
boolean livescroll = true
end type

event dberror;MessageBox('Error Code: ' + String(SQLDBCode),SQLErrText,StopSign!)

Return 1

end event

