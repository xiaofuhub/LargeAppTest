$PBExportHeader$w_contract_field_properties_datafill.srw
forward
global type w_contract_field_properties_datafill from window
end type
type cb_help from commandbutton within w_contract_field_properties_datafill
end type
type cb_close from commandbutton within w_contract_field_properties_datafill
end type
type cb_save from commandbutton within w_contract_field_properties_datafill
end type
type cb_delete from commandbutton within w_contract_field_properties_datafill
end type
type cb_add from commandbutton within w_contract_field_properties_datafill
end type
type dw_datafill from datawindow within w_contract_field_properties_datafill
end type
end forward

global type w_contract_field_properties_datafill from window
integer width = 1467
integer height = 1368
boolean titlebar = true
string title = "Data Fill Properties for"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_help cb_help
cb_close cb_close
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
dw_datafill dw_datafill
end type
global w_contract_field_properties_datafill w_contract_field_properties_datafill

type variables
long		il_ViewId,il_ScreenId
String	is_FieldName,is_LabelText,is_LookupName
end variables

forward prototypes
public subroutine wf_addrow ()
public function integer wf_verify ()
public function integer wf_typecompare (string as_fillcoltype, string as_mapcoltype)
public function integer wf_save ()
end prototypes

public subroutine wf_addrow ();long		ll_Row
DateTime	ldt_ModifyDate

ldt_ModifyDate = DateTime(Today(),Now())
ll_Row = dw_datafill.InsertRow(0)
dw_datafill.SetItem(ll_Row,'data_view_id',il_ViewId)
dw_datafill.SetItem(ll_Row,'screen_id',il_ScreenId)
dw_datafill.SetItem(ll_Row,'field_name',is_FieldName)

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
		return -1
	end if
	
	for ll_ComCol = ll_Cycle + 1 to ll_RowCnt
		ls_ComName = dw_datafill.GetItemString(ll_ComCol,'field_name_fill')
		if ls_FillName = ls_ComName then
			MessageBox(gnv_app.iapp_object.DisplayName,"Value in the " + String(ll_Cycle) + " row duplicates with value in the " + String(ll_ComCol) + " row in Fill Field. Please select another value.",Exclamation!)
			dw_datafill.SetRow(ll_ComCol)
			dw_datafill.SetColumn('field_name_fill')
			dw_datafill.SetFocus()
			return -1
		end if
	next
	
	if ldwis_Status = NotModified! then Continue
	
	ll_Find = ldwc_FillChild.Find("fillcolumn='" + ls_FillName + "'", 1 , ldwc_FillChild.RowCount())
	
	if ll_Find > 0 then
		ls_FillColType = ldwc_FillChild.GetItemString(ll_Find,'coltype')
	end if
	
	ll_Find = 0
	ls_MapName = dw_datafill.GetItemString(ll_Cycle,'field_name_map')
	if IsNull(ls_MapName) or Trim(ls_MapName) = '' then
		MessageBox(gnv_app.iapp_object.DisplayName,'Map Field cannot be empty. Please select a value from the dropdown list.',Exclamation!)
		dw_datafill.SetRow(ll_Cycle)
		dw_datafill.SetColumn('field_name_map')
		dw_datafill.SetFocus()
		return -1
	end if
	
	ll_Find = ldwc_MapChild.Find("mapcolumn='" + ls_MapName + "'", 1 , ldwc_MapChild.RowCount())
	
	if ll_Find > 0 then
		ls_MapColType = ldwc_MapChild.GetItemString(ll_Find,'coltype')
	end if
	
	if wf_TypeCompare(ls_FillColType,ls_MapColType) <> 1 then
		MessageBox(gnv_app.iapp_object.DisplayName,"Value type in Fill Field does not match with value type in Map Field in the " + String(ll_Cycle) + " row. Please select another value.",Exclamation!)
		dw_datafill.SetRow(ll_Cycle)
		dw_datafill.SetColumn('field_name_fill')
		dw_datafill.SetFocus()
		return -1
	end if
next

return 1
end function

public function integer wf_typecompare (string as_fillcoltype, string as_mapcoltype);String	ls_FillType,ls_MapType

as_FillColType = Lower(as_FillColType)
as_MapColType = Lower(as_MapColType)

if as_FillColType = as_MapColType then return 1
if Pos(as_FillColType,'char') > 0 or Pos(as_MapColType,'char') > 0 then return 1

//date,datetime,int,long,number,real,time,ulong,char(n),decimal(n)		//don't process timestamp
/*********************************Map relation*********************************
date<--datetime,char(n)
datetime<--date,time,char(n)
int<--long,number,real,ulong,char(n),decimal(n)
long<--int,number,real,ulong,char(n),decimal(n)
number<--int,long,real,ulong,char(n),decimal(n)
real<--int,long,number,ulong,char(n),decimal(n)
time<--datetime,char(n)
ulong<--int,long,number,real,char(n),decimal(n)
char(n)<--date,datetime,int,long,number,real,time,ulong,char(n),decimal(n)
decimal(n)<--int,long,number,real,ulong,char(n),decimal(n)
******************************************************************************/

Choose Case as_FillColType
	Case 'date','time'
		if as_MapColType = 'datetime' then return 1
	Case 'datetime'
		if as_MapColType = 'date' or as_MapColType = 'time' then return 1
	Case 'int'
		if as_MapColType = 'long' or as_MapColType = 'number' or &
			as_MapColType = 'real' or as_MapColType = 'ulong' or &
			Pos(as_MapColType,'decimal') > 0 then return 1
	Case 'long'
		if as_MapColType = 'int' or as_MapColType = 'number' or &
			as_MapColType = 'real' or as_MapColType = 'ulong' or &
			Pos(as_MapColType,'decimal') > 0 then return 1
	Case 'number'
		if as_MapColType = 'int' or as_MapColType = 'long' or &
			as_MapColType = 'real' or as_MapColType = 'ulong' or &
			Pos(as_MapColType,'decimal') > 0 then return 1
	Case 'real'
		if as_MapColType = 'int' or as_MapColType = 'long' or &
			as_MapColType = 'number' or as_MapColType = 'ulong' or &
			Pos(as_MapColType,'decimal') > 0 then return 1
	Case 'ulong'
		if as_MapColType = 'int' or as_MapColType = 'long' or &
			as_MapColType = 'number' or as_MapColType = 'real' or &
			Pos(as_MapColType,'decimal') > 0 then return 1
	Case else
		if Pos(as_FillColType,'decimal') > 0 then
			if as_MapColType = 'int' or as_MapColType = 'long' or &
				as_MapColType = 'number' or as_MapColType = 'real' or &
				as_MapColType = 'ulong' or Pos(as_MapColType,'decimal') > 0 then return 1  //Add "Pos(as_MapColType,'decimal') > 0" -- jervis 02.18.2011
		end if
End Choose

return -1

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

on w_contract_field_properties_datafill.create
this.cb_help=create cb_help
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_datafill=create dw_datafill
this.Control[]={this.cb_help,&
this.cb_close,&
this.cb_save,&
this.cb_delete,&
this.cb_add,&
this.dw_datafill}
end on

on w_contract_field_properties_datafill.destroy
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_datafill)
end on

event open;long		ll_ColCnt,ll_Cycle,ll_Row,ll_SepPos,ll_RowCnt,ll_Find
String	ls_ColName,ls_ColType,ls_LabelText,ls_Visible,ls_Objects,ls_ObjName,ls_ObjCopy,ls_ColLabel

DataWindowChild	ldwc_Child
DataStore			lds_MapField,lds_ColLabel

il_ViewId = w_contract_data_design.uo_design.il_select_view
il_ScreenId = w_contract_data_design.uo_design.ii_screen_id
is_FieldName = w_contract_field_properties.dw_properties.GetItemString(1,'sys_fields_field_name')
is_LabelText = w_contract_data_design.uo_design.uo_band.dw_syntax.Describe(is_FieldName + "_t.Text")
if is_LabelText = "" or is_LabelText = "!" or is_LabelText = "?" then is_LabelText = is_FieldName
is_LookupName = w_contract_field_properties.dw_properties.GetItemString(1,'sys_fields_lookup_code')

This.Title = "Data Fill Properties for " + is_LabelText



ll_ColCnt = long(w_contract_data_design.uo_design.uo_band.dw_syntax.Object.DataWindow.Column.Count)
dw_datafill.GetChild('field_name_fill',ldwc_Child)

for ll_Cycle = 1 to ll_ColCnt
	if w_contract_data_design.uo_design.uo_band.dw_syntax.Describe("#" + String(ll_Cycle) + ".Key") = 'no' then
		ls_ColName = w_contract_data_design.uo_design.uo_band.dw_syntax.Describe("#" + String(ll_Cycle) + ".Name")
		if ls_ColName <> is_FieldName then
			ls_ColType = w_contract_data_design.uo_design.uo_band.dw_syntax.Describe("#" + String(ll_Cycle) + ".Coltype")
			ls_Visible = w_contract_data_design.uo_design.uo_band.dw_syntax.Describe("#" + String(ll_Cycle) + ".Visible")
			if ls_Visible <> "0" then
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

lds_MapField = Create DataStore
lds_MapField.DataObject = 'd_code_lookup'

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-02-19 By: Scofield
//$<Reason> Get column label text

lds_ColLabel = Create DataStore
lds_ColLabel.DataObject = 'd_lookup_coltitle'
lds_ColLabel.SetTransObject(SQLCA)
lds_ColLabel.Retrieve('C',is_LookupName)
ll_RowCnt = lds_ColLabel.RowCount()

ll_ColCnt = long(lds_MapField.Object.DataWindow.Column.Count)
dw_datafill.GetChild('field_name_map',ldwc_Child)

ls_Objects = lds_MapField.Describe("DataWindow.Objects") + "~t"
	
for ll_Cycle = 1 to ll_ColCnt
	ls_ColName = lds_MapField.Describe("#" + String(ll_Cycle) + ".Name")
	ls_ColType = lds_MapField.Describe("#" + String(ll_Cycle) + ".Coltype")
	ll_Row = ldwc_Child.InsertRow(0)
	ldwc_Child.SetItem(ll_Row,'mapcolumn',ls_ColName)
	ldwc_Child.SetItem(ll_Row,'discolumn',ls_ColName)
	ldwc_Child.SetItem(ll_Row,'coltype',ls_ColType)
	
	ls_ObjCopy = ls_Objects
	ll_SepPos = Pos(ls_ObjCopy,"~t")
	do while ll_SepPos > 0
		ls_ObjName = Left(ls_ObjCopy,ll_SepPos - 1)
		ls_ObjCopy = Mid(ls_ObjCopy,ll_SepPos + 1)
		ll_SepPos = Pos(ls_ObjCopy,"~t")
		
		if long(lds_MapField.Describe(ls_ObjName + ".x")) <> long(lds_MapField.Describe(ls_ColName + ".x")) then continue
		if long(lds_MapField.Describe(ls_ObjName + ".Width")) <> long(lds_MapField.Describe(ls_ColName + ".Width")) then continue
		if lds_MapField.Describe(ls_ObjName + ".Band") <> "header" then continue
		if lds_MapField.Describe(ls_ObjName + ".Type") <> "text" then continue
		
		ll_Find = lds_ColLabel.Find("coltitlename='" + ls_ObjName + "'",1,ll_RowCnt)
		if ll_Find > 0 then
			ls_ColLabel = lds_ColLabel.GetItemString(ll_Find,'coltitletext')
			ldwc_Child.SetItem(ll_Row,'discolumn',ls_ColLabel)
		end if
		Exit
	loop
next

ldwc_Child.SetSort("mapcolumn A")
ldwc_Child.Sort()

dw_datafill.SetTransObject(SQLCA)
dw_datafill.Retrieve(il_ViewId,il_ScreenId,is_FieldName)

if dw_datafill.RowCount() <= 0 then
	wf_addrow()
end if

Destroy lds_ColLabel
Destroy lds_MapField
//---------------------------- APPEON END ----------------------------
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

type cb_help from commandbutton within w_contract_field_properties_datafill
integer x = 1152
integer y = 1176
integer width = 279
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
end type

event clicked;String	ls_Message

ls_Message = "&
Mapping rules for fields are as below: ~r~n~r~n&
Fill Field                     Map Field~r~n&
---------------------------------------------------------------------------------------------~r~n&
date                     date,datetime,char(n)~r~n&
datetime              date,time,datetime,char(n)~r~n&
int                         int,long,number,real,ulong,char(n),decimal(n)~r~n&
long                      int,long,number,real,ulong,char(n),decimal(n)~r~n&
number                 int,long,number,real,ulong,char(n),decimal(n)~r~n&
real                       int,long,number,real,ulong,char(n),decimal(n)~r~n&
time                      time,datetime,char(n)~r~n&
ulong                    int,long,number,real,ulong,char(n),decimal(n)~r~n&
char(n)                 date,datetime,int,long,number,real,time,ulong,char(n),decimal(n)~r~n&
decimal(n)            int,long,number,real,ulong,char(n),decimal(n)~r~n&
---------------------------------------------------------------------------------------------~r~n~r~n&
Note: If the length of Map Field exceeds the lenght of Fill Field.  The extra data will be truncated. "

MessageBox('Mapping rules',ls_Message)

end event

type cb_close from commandbutton within w_contract_field_properties_datafill
integer x = 869
integer y = 1176
integer width = 279
integer height = 88
integer taborder = 50
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

type cb_save from commandbutton within w_contract_field_properties_datafill
integer x = 585
integer y = 1176
integer width = 279
integer height = 88
integer taborder = 40
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

type cb_delete from commandbutton within w_contract_field_properties_datafill
integer x = 302
integer y = 1176
integer width = 279
integer height = 88
integer taborder = 30
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

type cb_add from commandbutton within w_contract_field_properties_datafill
integer x = 18
integer y = 1176
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

type dw_datafill from datawindow within w_contract_field_properties_datafill
integer x = 18
integer y = 16
integer width = 1413
integer height = 1132
integer taborder = 10
string dataobject = "d_contract_field_properties_datafill"
boolean vscrollbar = true
boolean livescroll = true
end type

event dberror;MessageBox('Error Code: ' + String(SQLDBCode),SQLErrText,StopSign!)

Return 1

end event

