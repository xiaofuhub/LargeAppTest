$PBExportHeader$w_audit_painter.srw
forward
global type w_audit_painter from w_sheet
end type
type cb_filter from u_cb within w_audit_painter
end type
type cb_export from u_cb within w_audit_painter
end type
type cb_print from u_cb within w_audit_painter
end type
type dw_filter from u_dw within w_audit_painter
end type
type dw_audit from u_dw within w_audit_painter
end type
type gb_1 from groupbox within w_audit_painter
end type
end forward

global type w_audit_painter from w_sheet
integer width = 3918
integer height = 1960
string title = "Audit Information For Contract"
windowstate windowstate = maximized!
long backcolor = 33551856
cb_filter cb_filter
cb_export cb_export
cb_print cb_print
dw_filter dw_filter
dw_audit dw_audit
gb_1 gb_1
end type
global w_audit_painter w_audit_painter

forward prototypes
public function integer wf_run_filter ()
end prototypes

public function integer wf_run_filter ();//Run Filter Audit -- Add by Jervis 03.31.2011
String ls_sql
String ls_user
String ls_from_date
String ls_to_date
Integer li_screen_id
string ls_original_sql
long ll_ctx_id, ll_pos
string ls_edit

dw_audit.dataobject = ''
dw_audit.dataobject =  'd_view_audit_ctx'

ls_original_sql = dw_audit.Object.DataWindow.Table.Select

//added by gavins 20120815
ll_pos = Pos( ls_original_sql, 'sys_fields.field_name' )
If ll_Pos > 0 Then
	ls_original_sql = Replace( ls_original_sql, ll_Pos, Len(  'sys_fields.field_name'  ) , "isnull( sys_audit.tfield_name, sys_fields.field_name) field_name" )
End If
ll_pos = Pos( ls_original_sql, 'sys_fields.field_name_allias' )
If ll_Pos > 0 Then
	ls_original_sql = Replace( ls_original_sql, ll_Pos, Len(  'sys_fields.field_name_allias'  ) , "isnull( sys_audit.tfield_name_allias, sys_fields.field_name_allias) field_name_allias" )
End If

dw_filter.AcceptText()
ls_user = dw_filter.GetItemString( 1, "user_id" )

IF ls_user <> "All" THEN
	ls_sql = ls_sql + " AND sys_audit.user_id = '" + ls_user + "'"
END IF

li_screen_id = dw_filter.GetItemNumber( 1, "screen_id" )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 04.22.2006 By: LeiWei
//$<reason> The way Appeon deals with the NULL value on the Web is different from that in PowerBuilder.
//$<modification> Modify the condition to make sure the applciation works correctly on the Web.
//IF li_screen_id <> 0 THEN
IF li_screen_id <> 0 AND NOT ISNULL(li_screen_id) THEN
//---------------------------- APPEON END ----------------------------
	ls_sql = ls_sql + " AND sys_audit.table_id = " + String( li_screen_id )
END IF



ls_from_date = String(dw_filter.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String(dw_filter.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

ll_ctx_id = dw_filter.GetItemNumber( 1,"contract_id")
IF  not IsNull( ll_ctx_id ) and ll_ctx_id <> 0 THEN
	ls_sql = ls_sql + " AND sys_audit.prac_id= " + String( ll_ctx_id )
END IF


IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date = "" OR IsNull( ls_to_date ) OR ls_to_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a Thru Date" )
		dw_filter.SetColumn( "to_date" )
		Return -1
	END IF
END IF

IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN
	IF ls_from_date = "" OR IsNull( ls_from_date ) OR ls_from_date = "00/00/0000" THEN		
		MessageBox("Select Error", "You must select a From Date" )
   	dw_filter.SetColumn( "from_date" )
		Return -1
	END IF
END IF

IF ls_from_date <> "" AND NOT IsNull( ls_from_date ) AND ls_from_date <> "00/00/0000" THEN
	IF ls_to_date <> "" AND NOT IsNull( ls_to_date ) AND ls_to_date <> "00/00/0000" THEN	
		ls_from_date = "'" + ls_from_date + "'"
		ls_to_date = "'" + ls_to_date + "'"
		ls_sql = ls_sql + " AND convert(datetime,  convert( varchar, sys_audit.date_time_modified,102) )  >= " + ls_from_date +&
								" AND convert(datetime, convert( varchar, sys_audit.date_time_modified,102) )  <= " + ls_to_date 

	END IF
END IF

ls_edit = dw_filter.GetItemString( 1, 'edit_type')
if ls_edit <> "" and not isnull(ls_edit) and ls_edit <> 'A' then
	ls_sql = ls_sql + "and audit_type = '" + ls_edit + "'"
end if

ls_sql = ls_original_sql + ls_sql

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<modify> 04.22.2006 By: LeiWei
//$<reason> SetSQLSelect doest not work correctly against SQL server database on the Web.
//$<modification> Change it to Modify() to make sure the application runs correctly against
//$<modification> both SQL server database and ASA database on the Web.
//dw_audit.SetSQLSelect ( ls_sql )
dw_audit.Modify('DataWindow.Table.Select="'+ls_sql + '"')
//---------------------------- APPEON END ----------------------------

dw_audit.SetTransObject( SQLCA )
dw_audit.Retrieve()


return 0
end function

on w_audit_painter.create
int iCurrent
call super::create
this.cb_filter=create cb_filter
this.cb_export=create cb_export
this.cb_print=create cb_print
this.dw_filter=create dw_filter
this.dw_audit=create dw_audit
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_filter
this.Control[iCurrent+2]=this.cb_export
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.dw_filter
this.Control[iCurrent+5]=this.dw_audit
this.Control[iCurrent+6]=this.gb_1
end on

on w_audit_painter.destroy
call super::destroy
destroy(this.cb_filter)
destroy(this.cb_export)
destroy(this.cb_print)
destroy(this.dw_filter)
destroy(this.dw_audit)
destroy(this.gb_1)
end on

event pfc_preopen;call super::pfc_preopen;long ll_i

this.of_SetResize( true)
this.inv_resize.of_setminsize( this.workspacewidth( ) ,this.workspaceheight( ) )
this.inv_resize.of_setorigsize(  this.workspacewidth( ) ,this.workspaceheight( ) )


FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (this.CONTrol[LL_I]  , this.inv_resize.scale	 )
NEXT
end event

event open;call super::open;//Set current contract id  when contract folder have been opened -- jervis 03.31.2011
long ll_ctx_id
if isvalid(gw_contract) then
	ll_ctx_id = gw_contract.tab_contract_details.tabpage_details.inv_contract_details.of_get_ctx_id( )
	if ll_ctx_id > 0 then
		dw_filter.SetItem( 1,'contract_id',ll_ctx_id)
		cb_filter.event clicked( )
	end if
end if
end event

event activate;call super::activate;long ll_ctx_id, ll_contract_id

//Switch MDI menu while to do list window get the focus. - jervis 05.09.2011
if w_mdi.MenuName <> "m_pfe_cst_mdi_menu" then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
end if


//Set current contract id  when contract folder have been opened -- jervis 05.09.2011
if isvalid(gw_contract) then
	ll_ctx_id = gw_contract.tab_contract_details.tabpage_details.inv_contract_details.of_get_ctx_id( )
	//Added By Mark Lee 09/14/12
//	if ll_ctx_id > 0  and ll_ctx_id <> dw_filter.GetItemNumber( 1,'contract_id') then
	ll_contract_id	= dw_filter.GetItemNumber( 1,'contract_id')
	if ll_ctx_id > 0  and ll_ctx_id <> ll_contract_id and not isnull(ll_contract_id) then
		
		dw_filter.SetItem( 1,'contract_id',ll_ctx_id)
		cb_filter.event clicked( )
	end if
end if

end event

type cb_filter from u_cb within w_audit_painter
integer x = 3493
integer y = 236
integer taborder = 30
string text = "&Run Filter"
end type

event clicked;call super::clicked;wf_run_filter()
end event

type cb_export from u_cb within w_audit_painter
integer x = 3493
integer y = 136
integer taborder = 20
string text = "&Export"
end type

event clicked;call super::clicked;dw_audit.saveas()
end event

type cb_print from u_cb within w_audit_painter
integer x = 3493
integer y = 36
integer taborder = 20
string text = "&Print"
end type

event clicked;call super::clicked;dw_audit.Print()
end event

type dw_filter from u_dw within w_audit_painter
integer x = 69
integer y = 64
integer width = 3337
integer height = 244
integer taborder = 10
string dataobject = "d_audit_filter"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;DataWindowChild ldwc_Child

This.of_SetUpdateAble( False )
This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

this.SetTransObject( sqlca)
this.InsertRow(0)

this.GetChild("screen_id", ldwc_Child)
ldwc_Child.InsertRow(1)
ldwc_Child.SetItem( 1, "table_name_allias", "All" )
ldwc_Child.SetItem( 1, "table_id", 0 )
this.SetItem(1,"screen_id",0)


This.GetChild( "user_id", ldwc_Child )
ldwc_Child.InsertRow( 1 )
ldwc_Child.SetItem( 1, "user_id", "All" )
This.SetItem( 1, "user_id", "All" )









end event

event rbuttondown;call super::rbuttondown;string 	ls_name
integer 	li_Rtn
datetime ldt_Null

SetNull(ldt_Null)

ls_name = dwo.name
if this.Describe( ls_name + ".ColType") = "date" THEN
	li_Rtn = MessageBox("Set Null?","Would you like to set this date to null?",question!,yesno!,2 )
	
	if li_Rtn = 1 then
		this.SetItem(Row,ls_name,ldt_Null)
	end if
end if

end event

type dw_audit from u_dw within w_audit_painter
integer x = 32
integer y = 356
integer width = 3813
integer height = 1464
integer taborder = 10
string dataobject = "d_view_audit"
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )

This.of_SetTransObject(SQLCA)

This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(1)

This.inv_sort.of_SetColumnHeader(True)


end event

type gb_1 from groupbox within w_audit_painter
integer x = 32
integer y = 12
integer width = 3419
integer height = 320
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Filter"
end type

