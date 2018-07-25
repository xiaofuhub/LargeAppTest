$PBExportHeader$w_import_data_store_view.srw
forward
global type w_import_data_store_view from pfc_w_response
end type
type dw_user from datawindow within w_import_data_store_view
end type
type st_1 from statictext within w_import_data_store_view
end type
type cb_4 from commandbutton within w_import_data_store_view
end type
type cb_reset from commandbutton within w_import_data_store_view
end type
type dw_date_range from u_dw within w_import_data_store_view
end type
type dw_detail from datawindow within w_import_data_store_view
end type
type cb_1 from commandbutton within w_import_data_store_view
end type
type cb_2 from commandbutton within w_import_data_store_view
end type
type cb_3 from commandbutton within w_import_data_store_view
end type
type dw_list from u_dw within w_import_data_store_view
end type
type gb_1 from groupbox within w_import_data_store_view
end type
end forward

global type w_import_data_store_view from pfc_w_response
integer width = 3698
integer height = 2212
string title = "View Saved Imported Data"
long backcolor = 33551856
boolean center = true
dw_user dw_user
st_1 st_1
cb_4 cb_4
cb_reset cb_reset
dw_date_range dw_date_range
dw_detail dw_detail
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_list dw_list
gb_1 gb_1
end type
global w_import_data_store_view w_import_data_store_view

type variables
long ii_import_id
string is_table_name
end variables

forward prototypes
public function integer of_dycreate_dw (string as_table_name)
public function integer of_modifystyle (datawindow adw_1)
public function integer of_filter_dw ()
end prototypes

public function integer of_dycreate_dw (string as_table_name);//////////////////////////////////////////////////////////////////////
// $<function> of_dycreate_dw
// $<arguments>
//               string as_table_name
// $<returns> (integer)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.18.2012
//////////////////////////////////////////////////////////////////////

string ls_SQLSelect, ls_DWSyntax, ls_Error

ls_SQLSelect = "SELECT distinct created_date, created_by, process_id FROM " + as_table_name + "  where process_id is not null " 

//Dynamic create DW_LIST
ls_DWSyntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "Style(Type=Grid)", ls_Error)
if LenA(ls_Error) > 0 then
	MessageBox("Caution", "SyntaxFromSQL caused these errors: " + ls_Error)
	Return -1
end if
dw_list.Create(ls_DWSyntax, ls_Error)
dw_list.SetTransObject(SQLCA)
of_ModifyStyle(dw_list)

//Dynamic create DW_Detail
ls_SQLSelect = "select * from "  + as_table_name + "  where process_id is not null " 
ls_DWSyntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "Style(Type=Grid)", ls_Error)
if LenA(ls_Error) > 0 then
	MessageBox("Caution", "SyntaxFromSQL caused these errors: " + ls_Error)
	Return -1
end if
dw_detail.Create(ls_DWSyntax, ls_Error)
dw_detail.SetTransObject(SQLCA)
of_ModifyStyle(dw_detail)

dw_list.setsort("process_id asc")
dw_list.sort()
dw_list.retrieve()
dw_detail.retrieve()


return 1
end function

public function integer of_modifystyle (datawindow adw_1);//////////////////////////////////////////////////////////////////////
// $<function> of_modifystyle
// $<arguments>
//               datawindow adw_1
// $<returns> (integer)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.18.2012
//////////////////////////////////////////////////////////////////////

string ls_Name
string ls_Style
integer ll_PosX
integer i, li_FieldCount

w_import_data_store_view.SetRedraw(false)

li_FieldCount = Integer(adw_1.object.datawindow.column.count)
for i = 1 to li_FieldCount
	ls_Name = adw_1.Describe("#" + String(i) + ".name")
	ls_Style = ls_Name + ".width=400"
	ls_Style += " " + ls_Name + "_t.width=400"
	if i = 1 then
		ls_Style += " " + ls_Name + "_t.X=0"
	else
		ls_Style += " " + ls_Name + "_t.X=" + String(ll_PosX)
	end if
	ls_Style += " " + ls_Name + "_t.border=6"
	ls_Style += " " + ls_Name + "_t.background.mode=2"
	ls_Style += " " + ls_Name + "_t.background.color=67108864"
	ls_Style += " " + ls_Name + ".tabsequence = 0"
	
	adw_1.Modify(ls_Style)	
	ll_PosX = Long(adw_1.Describe(ls_Name + ".X")) + 400
next
//adw_1.Modify("sys_pc_id.visible=0")
//adw_1.Modify("sys_facility_id.visible=0")
//adw_1.Modify("sys_contact_id.visible=0")

w_import_data_store_view.SetRedraw(true)

return 1
end function

public function integer of_filter_dw ();//////////////////////////////////////////////////////////////////////
// $<function> of_filter_dw
// $<arguments>
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 12.19.2012 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_from_date, ls_to_date
string ls_filter, ls_user

if dw_date_range.accepttext() = -1 then return -1
ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

ls_filter = ''
if ls_from_date <>'' and not isnull(ls_from_date) then
	ls_from_date = ls_from_date + " 00:00:00"
	ls_filter =  "created_date >="+ls_from_date
	if ls_to_date <>'' and not isnull(ls_to_date) then
		ls_to_date = ls_to_date + " 23:59:59"
		ls_filter = ls_filter +" and created_date <= "+ls_to_date
	end if
	
elseif  ls_to_date <>'' and not isnull(ls_to_date) then
	ls_to_date = ls_to_date + " 23:59:59"
	ls_filter = " created_date <= "+ ls_to_date
else
	ls_filter = '1 = 1 '
end if

ls_user = dw_user.getitemstring(1, "user_id")
if not(isnull(ls_user) or ls_user = '') then
	ls_filter = ls_filter + " and created_by = '" + ls_user +"'"
end if

dw_list.setfilter(ls_filter)
dw_list.filter()

end function

on w_import_data_store_view.create
int iCurrent
call super::create
this.dw_user=create dw_user
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_reset=create cb_reset
this.dw_date_range=create dw_date_range
this.dw_detail=create dw_detail
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_list=create dw_list
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_user
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.cb_reset
this.Control[iCurrent+5]=this.dw_date_range
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.dw_list
this.Control[iCurrent+11]=this.gb_1
end on

on w_import_data_store_view.destroy
call super::destroy
destroy(this.dw_user)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_reset)
destroy(this.dw_date_range)
destroy(this.dw_detail)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_list)
destroy(this.gb_1)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<Event> open
// $<arguments> N/A
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 12.18.2012 by Stephen
//////////////////////////////////////////////////////////////////////
string ls_sql
datawindowchild ldwc_1
str_parm lstr_store

// Set resize
this.setredraw(false)
this.of_SetResize(true)
inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())

inv_resize.of_Register(dw_detail, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(dw_list, inv_resize.SCALEBOTTOM)

lstr_store = Message.powerobjectparm
is_table_name = lstr_store.s_module
ii_import_id = lstr_store.l_wf_id

if of_dycreate_dw(is_table_name) = -1 then
	closewithreturn(this, 0)
	return
end if

dw_user.settransobject(sqlca)
dw_user.retrieve()
dw_user.insertrow(0)
dw_user.getchild("user_id", ldwc_1)
ldwc_1.insertrow(1)



this.setredraw(true)
end event

event pfc_postopen;call super::pfc_postopen;//////////////////////////////////////////////////////////////////////
// $<Event> pfc_postopen
// $<arguments> N/A
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 12.19.2012 by Stephen
//////////////////////////////////////////////////////////////////////

dw_date_range.of_SetUpdateAble( False )
dw_date_range.of_SetTransObject( SQLCA )
dw_date_range.InsertRow( 0 )

dw_date_range.of_SetDropDownCalendar( TRUE )
dw_date_range.iuo_calendar.of_Register(dw_date_range.iuo_calendar.DDLB)
dw_date_range.of_setupdateable(false) 
end event

type dw_user from datawindow within w_import_data_store_view
integer x = 1504
integer y = 76
integer width = 466
integer height = 96
integer taborder = 40
string title = "none"
string dataobject = "d_select_user_for_audit_trail"
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within w_import_data_store_view
integer x = 1509
integer y = 16
integer width = 320
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Create User"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_import_data_store_view
integer x = 2094
integer y = 64
integer width = 293
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run &Filter"
end type

event clicked;of_filter_dw()
end event

type cb_reset from commandbutton within w_import_data_store_view
integer x = 1207
integer y = 64
integer width = 247
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reset"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> Clicked
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 12.18.2012 by Stephen
//////////////////////////////////////////////////////////////////////

//if isnull(dw_date_range.GetItemDate( 1, "from_date" )) and dw_1.rowcount() < 1 then return

dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )




end event

type dw_date_range from u_dw within w_import_data_store_view
integer x = 46
integer y = 72
integer width = 1175
integer height = 80
integer taborder = 30
string dataobject = "d_faxlog_date_range"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type dw_detail from datawindow within w_import_data_store_view
integer x = 805
integer y = 200
integer width = 2857
integer height = 1904
integer taborder = 20
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_import_data_store_view
integer x = 2437
integer y = 64
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
//               
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.18.2012
//////////////////////////////////////////////////////////////////////
long ll_row, ll_process_id, ll_import_id
string ls_sql

ll_row = dw_list.getrow()

if ll_row < 1 then return
if MessageBox("Prompt", "Are you sure you want to delete the record?", Question!, YesNo!) = 2 then return

ll_process_id = dw_list.getitemnumber(ll_row, "process_id")

gnv_appeondb.of_startqueue( )
delete from import_file_store where process_id = :ll_process_id and import_id = :ii_import_id;
ls_sql = "delete from " + is_table_name + " where process_id = " + string(ll_process_id)
EXECUTE IMMEDIATE :ls_sql;
gnv_appeondb.of_commitqueue( )	

if sqlca.sqlcode <> 0 then 
	messagebox("Prompt", sqlca.sqlerrtext)
	return -1
else
	commit using sqlca;
end if

dw_list.deleterow(ll_row)

ll_row = dw_list.getrow()
dw_list.event rowfocuschanged(ll_row)






end event

type cb_2 from commandbutton within w_import_data_store_view
integer x = 2779
integer y = 64
integer width = 539
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Return &With Selected"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
//               
// $<returns> (integer)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.18.2012
//////////////////////////////////////////////////////////////////////

long ll_process_id
long ll_row

ll_row = dw_list.getrow()
if ll_row < 1 then 
	ll_process_id = 0
else
	ll_process_id = dw_list.getitemnumber(ll_row, "process_id")
end if

if isvalid(w_import_painter) then w_import_painter.ii_process_id = ll_process_id
close(parent)
end event

type cb_3 from commandbutton within w_import_data_store_view
integer x = 3369
integer y = 64
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<function> clicked
// $<arguments>
//               
// $<returns> (integer)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.14.2012
//////////////////////////////////////////////////////////////////////

if isvalid(w_import_painter) then w_import_painter.ii_process_id = 0
close(parent)
end event

type dw_list from u_dw within w_import_data_store_view
integer x = 18
integer y = 200
integer width = 759
integer height = 1904
integer taborder = 10
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//               long currentrow
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.18.2012
//////////////////////////////////////////////////////////////////////
long li_process_id

if currentrow < 1 then
	if this.rowcount() < 1 then
		dw_detail.setfilter("1<>1")
		dw_detail.filter()
	end if
	return
end if

this.selectrow(0, false)
this.selectrow(currentrow, true)
li_process_id = this.getitemnumber(currentrow, "process_id")

dw_detail.setfilter("process_id = "+ string(li_process_id))
dw_detail.filter()
end event

type gb_1 from groupbox within w_import_data_store_view
integer x = 18
integer y = 16
integer width = 1472
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Date Range"
end type

