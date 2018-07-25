$PBExportHeader$w_data_flow_painter.srw
forward
global type w_data_flow_painter from window
end type
type cb_view from commandbutton within w_data_flow_painter
end type
type cb_retrieve from commandbutton within w_data_flow_painter
end type
type cb_add from commandbutton within w_data_flow_painter
end type
type cb_delete from commandbutton within w_data_flow_painter
end type
type cb_save from commandbutton within w_data_flow_painter
end type
type cb_close from commandbutton within w_data_flow_painter
end type
type st_master from statictext within w_data_flow_painter
end type
type tab_1 from tab within w_data_flow_painter
end type
type tabpage_browse from userobject within tab_1
end type
type mle_1 from multilineedit within tabpage_browse
end type
type dw_browse from datawindow within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
mle_1 mle_1
dw_browse dw_browse
end type
type tabpage_detail from userobject within tab_1
end type
type dw_detail from datawindow within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
dw_detail dw_detail
end type
type tab_1 from tab within w_data_flow_painter
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
end forward

global type w_data_flow_painter from window
integer width = 2944
integer height = 2204
boolean titlebar = true
string title = "Data Flow Setup"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_view cb_view
cb_retrieve cb_retrieve
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
st_master st_master
tab_1 tab_1
end type
global w_data_flow_painter w_data_flow_painter

type variables
boolean ib_browse_retrieve //alfee 01.07.2010
integer li_fac_specific = 0 //maha 03.03.2010

datawindowchild idwc_table_from, idwc_field_from
datawindowchild idwc_table_to, idwc_field_to 
datawindowchild idwc_newvalue, idwc_updatevalue

datawindow idw_detail, idw_browse
end variables

forward prototypes
public subroutine of_set_value_field (string as_field)
public function integer of_add_row ()
public function integer of_filter_totable (string as_type)
public function integer of_set_defaults (string as_type)
end prototypes

public subroutine of_set_value_field (string as_field);//set edit style for the value field - alfee 01.07.2010

integer li_ret
long ll_row, ll_row_dwc, ll_table_id, ll_field_id
string ls_lu_type, ls_field_type, ls_lookup_field
string ls_table, ls_name, ls_dataname, ls_displayname
datawindowchild ldwc_field

ll_row = idw_detail.getrow()
if ll_row < 1 then return 
debugbreak()
idw_detail.AcceptText()
choose case lower(as_field)
	case 'from_value' 
		ldwc_field = idwc_field_from
		ll_table_id = idw_detail.getitemnumber(ll_row, 'from_table')
		ll_field_id = idw_detail.getitemnumber(ll_row, 'from_field')
		idw_detail.object.t_dt_format1.visible = false		
	case 'to_value'
		ldwc_field = idwc_field_to
		ll_table_id = idw_detail.getitemnumber(ll_row, 'to_table')		
		ll_field_id = idw_detail.getitemnumber(ll_row, 'to_field')				
		idw_detail.object.t_dt_format2.visible = false			
	case else
		return
end choose

if lower(as_field) = 'from_value' and idw_detail.getitemstring(ll_row, "update_type") = 'E' then 
	return
end if

ll_row_dwc = ldwc_field.Find("field_id=" + String(ll_field_id), 1, ldwc_field.rowcount())
if IsNull(ll_row_dwc) or ll_row_dwc < 1 then 
	//edit style - for new record
	idw_detail.Modify(as_field + ".edit.case='any'")   
	idw_detail.Modify(as_field + ".edit.AutoSelect='Yes'")   			
	return
end if
	
ls_field_type = ldwc_field.getitemstring(ll_row_dwc,"field_type")	
ls_lookup_field = gnv_data.of_getitem('sys_fields', 'lookup_field', 'field_id = ' + string(ll_field_id) + ' and table_id = ' + string(ll_table_id))
if ls_lookup_field = "Y" then //dddw style
	ls_lu_type = ldwc_field.GetItemString(ll_row_dwc, "lookup_type")
	ls_table = ldwc_field.GetItemString(ll_row_dwc,"lookup_code")

	if ls_lu_type = "C" then
		ls_name = "d_dddw_code_lookup_batch"
		ls_dataname = 'lookup_code'
		ls_displayname = 'descandcode'
	elseif ls_lu_type = "A" then
		ls_name = "d_dddw_address_lookup_batch"
		ls_dataname = 'lookup_code'
		ls_displayname = 'nameandcode'
		//ELSEIF ls_lu_type = "D" THEN
		//	ls_name = "d_dddw_priv_clinical_area"
		//	ls_dataname = 'clinical_area_id'
		//	ls_displayname = 'clinical_area_code'
		//ELSEIF ls_lu_type = "P" THEN
		//	ls_name = "d_dddw_priv_core_procd"
		//	ls_dataname = 'procd_id'
		//	ls_displayname = 'procd_name'
		//ELSEIF ls_lu_type = "S" THEN
		//	ls_name = "d_dddw_priv_core"
		//	ls_dataname = 'priv_core_id'
		//	ls_displayname = 'priv_core_description'
	end if
	
	//idw_detail.modify(as_field + ".dddw.AutoRetrieve	 = 'no'")
	idw_detail.modify(as_field + ".dddw.vscrollbar	 = 'yes'")
	idw_detail.modify(as_field + ".dddw.hscrollbar	 = 'yes'")
	idw_detail.modify(as_field + ".dddw.PercentWidth	 = '150'")		
	idw_detail.modify(as_field + ".dddw.name = '" + ls_name + "'")
	idw_detail.modify(as_field + ".dddw.displaycolumn = '" + ls_displayname + "'")
	idw_detail.modify(as_field + ".dddw.datacolumn = '" + ls_dataname + "'")
	li_ret = idw_detail.getchild(as_field, idwc_newvalue)
	if li_ret = 1 then
		idwc_newvalue.SetTransObject( sqlca )
		if ls_lu_type = "C" or  ls_lu_type = "A" THEN 
			idwc_newvalue.Retrieve(ls_table)
		else
			idwc_newvalue.Retrieve()
		end if
		idwc_newvalue.InsertRow( 1 )
	end if			
	
else//edit style
	idw_detail.Modify(as_field + ".edit.case='any'")   
	idw_detail.Modify(as_field + ".edit.AutoSelect='Yes'")   			
	if Upper(ls_field_type) = 'D' then //for datetime field	
		if lower(as_field) = 'from_value' then
			idw_detail.object.t_dt_format1.visible = true
		else
			idw_detail.object.t_dt_format2.visible = true	
		end if
	end if
end if

//Start Code Change ----08.29.2016 #V152 maha
// 'in_good_standing' 
if ll_field_id =	100053 then
	idw_detail.modify(as_field + ".dddw.vscrollbar	 = 'yes'")
	idw_detail.modify(as_field + ".dddw.hscrollbar	 = 'yes'")
	idw_detail.modify(as_field + ".dddw.PercentWidth	 = '150'")		
	idw_detail.modify(as_field + ".dddw.name = 'd_dddw_standing_display_only'")
	idw_detail.modify(as_field + ".dddw.displaycolumn = 'display_value'")
	idw_detail.modify(as_field + ".dddw.datacolumn = 'lu_id'")
	li_ret = idw_detail.getchild(as_field, idwc_newvalue)
	idwc_newvalue.SetTransObject( sqlca )
	idwc_newvalue.Retrieve()
end if
//End Code Change ----08.29.2016



end subroutine

public function integer of_add_row ();//add a new row  - alfee 01.07.2010
long nr

if gs_user_id <> "MASTER" then return 0 //Start Code Change ----04.19.2016 #V15 maha

//set detail dw
idw_detail.reset()
nr = idw_detail.insertrow(0)
idw_detail.setitem(nr, "df_status", 1)  //Start Code Change ----03.22.2012 #V12 maha - add a default to the status
idw_detail.setitem(nr, "df_description", "new test")

//reset dddws
idwc_field_from.reset()
idwc_field_to.reset()
idwc_field_from.insertrow(0)
idwc_field_to.insertrow(0)

//reset value fields
of_set_value_field("from_value")
of_set_value_field("to_value")

return 1
end function

public function integer of_filter_totable (string as_type);//===================================
// $<Function>V12.2 Privilege Suspension   : of_filter_totable ()
// $<arguments>
// $ value string as_type:the data value of update_type field
// $<returns>Integer 1 success -1 fail
// $<description> filter the to_table field in dw_detail
// $<add> (Appeon) Long.zhang 06.12.2012
//===================================

DataWindowChild ldw_child
long ll_table_id
long ll_cur_row

idw_detail.getChild("to_table",ldw_child)

IF as_type = "P" THEN
	ldw_child.setfilter( "table_id=90")
else
	ldw_child.setfilter( "screen_type='S'")
END IF
ldw_child.filter( )
ll_cur_row = idw_detail.getrow()
if ldw_child.rowcount( ) = 0 then return -1

if as_type = 'P' then
	ll_table_id = ldw_child.getitemnumber(1, "table_id")	
else
	ll_table_id = idw_detail.getitemnumber( ll_cur_row,"to_table",primary!,true)
	if ll_table_id = 90 then	//New added
		setnull(ll_table_id)
		idw_detail.setitem( ll_cur_row,"to_table",ll_table_id)
		return 1
	end if	
end if
if idw_detail.getitemnumber(ll_cur_row,"to_table") <>ll_table_id or isNull( idw_detail.getitemnumber(ll_cur_row,"to_table")) then
	idw_detail.setitem( ll_cur_row,"to_table",ll_table_id)
end if

ll_cur_row = ldw_child.find( "table_id="+string(ll_table_id),1,ldw_child.rowcount())
	
if ll_cur_row > 0 then
	ldw_child.scrolltorow(ll_cur_row)
	ldw_child.selectrow( 0,false)
	ldw_child.selectrow( ll_cur_row,true)
end if	
return 1
end function

public function integer of_set_defaults (string as_type);//Start Code Change ----07.26.2012 #V12 maha - to set data defults based on flow type

if as_type = "P" then
	tab_1.tabpage_detail.dw_detail.setitem(1,"from_value","Current Date")
	tab_1.tabpage_detail.dw_detail.setitem(1,"from_filter","For Privilege Suspensions typically the actve status of the expiring records should be set to Active (1) ")
	tab_1.tabpage_detail.dw_detail.setitem(1,"to_filter","pd_priv_list.status_code = 24478 and pd_priv_list.facility_id = ?? and pd_priv_list.prac_id = %%prac_id and pd_priv_list.active_status = 1 ~r~r The target filter will typically be like the one above which uses the default Granted status.  Replace the ?? with the facility_if of the Facility for which this Data Flow is set up.  Delete this note before saving. ")
	tab_1.tabpage_detail.dw_detail.setitem(1,"to_table",90)
	tab_1.tabpage_detail.dw_detail.setitem(1,"to_field",30000008)
	tab_1.tabpage_detail.dw_detail.setitem(1,"to_value",24481)
end if

return 1
	
	
	
end function

on w_data_flow_painter.create
this.cb_view=create cb_view
this.cb_retrieve=create cb_retrieve
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.st_master=create st_master
this.tab_1=create tab_1
this.Control[]={this.cb_view,&
this.cb_retrieve,&
this.cb_add,&
this.cb_delete,&
this.cb_save,&
this.cb_close,&
this.st_master,&
this.tab_1}
end on

on w_data_flow_painter.destroy
destroy(this.cb_view)
destroy(this.cb_retrieve)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.st_master)
destroy(this.tab_1)
end on

event open;//dataflow: joe.zhang 12.21.2009

SetRedraw(false)

//initialize dws
idw_browse = tab_1.tabpage_browse.dw_browse
idw_detail = tab_1.tabpage_detail.dw_detail
idw_browse.modify("datawindow.readonly = 'yes'")

//initialize dddws
idw_detail.getchild("from_table", idwc_table_from)
idw_detail.getchild("from_field", idwc_field_from)
idw_detail.getchild("to_table", idwc_table_to)
idw_detail.getchild("to_field", idwc_field_to)

idwc_table_from.settransobject(sqlca)
idwc_field_from.settransobject(sqlca)
idwc_table_to.settransobject(sqlca)
idwc_field_to.settransobject(sqlca)

//retrieve data
gnv_appeondb.of_startqueue()
idw_browse.retrieve()
idwc_table_from.retrieve()
idwc_table_to.retrieve()
gnv_appeondb.of_commitqueue()

idw_browse.event rowfocuschanged(idw_browse.getrow())
if idw_detail.rowcount() < 1 then of_add_row()

if gs_user_id <> "MASTER" then 
	tab_1.tabpage_detail.dw_detail.enabled = false  //Start Code Change ----04.19.2016 #V15 maha
	cb_add.visible = false
	cb_delete.visible = false
	cb_save.visible = false
	st_master.visible = true
end if

SetRedraw(True)



end event

event close;//commented by alfee 03.23.2010
//if isvalid(idw_detail) then destroy idw_detail
//if isvalid(idw_browse) then destroy idw_browse

end event

event closequery;integer li_ret

idw_detail.accepttext()
if idw_detail.modifiedcount() <> 0 or idw_detail.deletedcount() <> 0 then
	li_ret = MessageBox("Save Data", "Do you want to save the current data?", Question!, YesNo!, 1)
	IF li_ret = 1 THEN
		cb_save.event clicked()	
		if idw_detail.modifiedcount() <> 0 or idw_detail.deletedcount() <> 0 then
			return 1
		end if		
	END IF	
end if

return 0
end event

type cb_view from commandbutton within w_data_flow_painter
integer x = 2258
integer y = 60
integer width = 338
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Syntax"
end type

event clicked;string ls_select_sql, ls_update_sql, ls_text

n_cst_dataflow ln_cst_dataflow

ln_cst_dataflow.of_build_sql(idw_detail, 1, ls_update_sql, ls_select_sql)

ls_text = "UPDATE: ~r~n  " + ls_update_sql + "~r~n~r~nSELECT : ~r~n  " + ls_select_sql
OpenWithParm(w_data_flow_sql, ls_text)


end event

type cb_retrieve from commandbutton within w_data_flow_painter
boolean visible = false
integer x = 1947
integer y = 60
integer width = 306
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Retrieve"
end type

event clicked;idw_browse.retrieve()

end event

type cb_add from commandbutton within w_data_flow_painter
integer x = 1326
integer y = 60
integer width = 306
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;integer li_ret

idw_detail.accepttext()
if idw_detail.modifiedcount() <> 0 or idw_detail.deletedcount() <> 0 then
	li_ret = MessageBox("Save Data", "Do you want to save the current data?", Question!, YesNo!, 1)
	IF li_ret = 1 THEN
		cb_save.event clicked()	
	END IF	
end if

of_add_row()
end event

type cb_delete from commandbutton within w_data_flow_painter
integer x = 1637
integer y = 60
integer width = 306
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;long ll_row
integer li_ret

if idw_detail.rowcount() < 1 then return 
ll_row = idw_detail.getrow()

li_ret = MessageBox("Delete Data", "Do you want to delete the current data?", Question!, YesNo!, 2)
IF li_ret = 1 THEN
	idw_detail.deleterow(ll_row)	
	cb_save.event clicked()
	
	if idw_detail.rowcount() < 1 then
		idw_browse.event rowfocuschanged(idw_browse.getrow())
	end if
END IF
end event

type cb_save from commandbutton within w_data_flow_painter
integer x = 1010
integer y = 60
integer width = 306
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;string ls_type, ls_status, ls_from_table, ls_from_field, ls_to_table, ls_to_field
string ls_from_filter, ls_to_filter, ls_from_value, ls_to_value
long ll_row, ll_id

idw_detail.accepttext()
if idw_detail.modifiedcount() = 0 and idw_detail.deletedcount() = 0 then
	//MessageBox("No Change","No change detected in this window. Make change and try again !")
	return
end if

//verification before update
ll_row = idw_detail.getrow()
if ll_row > 0 then
	//Update Type Column
	ls_type = idw_detail.getitemstring(ll_row, "update_type")
	if isnull(ls_type) or LenA(trim(ls_type)) = 0 then
		MessageBox("Verification","The Update Type is required!")
		idw_detail.setfocus()
		idw_detail.setcolumn("update_type")
		return
	end if
	//DF Status Column
	ls_status = idw_detail.getitemstring(ll_row, "df_status")
	if isnull(ls_status) or LenA(trim(ls_status)) = 0 then
		MessageBox("Verification","The DF Status is required!")
		idw_detail.setfocus()
		idw_detail.setcolumn("df_status")
		return
	end if
	//From Table Column
	ls_from_table = string(idw_detail.getitemnumber(ll_row, "from_table"))
	if isnull(ls_from_table) or LenA(trim(ls_from_table)) = 0 then
		MessageBox("Verification","The From Table is required!")
		idw_detail.setfocus()
		idw_detail.setcolumn("from_table")
		return
	end if
//	//From Field Column
//	ls_from_field = string(idw_detail.getitemnumber(ll_row, "from_field"))
//	if isnull(ls_from_field) or len(trim(ls_from_field)) = 0 then
//		MessageBox("Required","From Field is required. Try again !")
//		idw_detail.setfocus()
//		idw_detail.setcolumn("from_field")
//		return
//	end if
//	//From Filter Column
//	ls_from_filter = idw_detail.getitemstring(ll_row, "from_filter")
//	if isnull(ls_from_filter) or len(trim(ls_from_table)) = 0 then
//		MessageBox("Required","From Filter is required. Try again !")
//		idw_detail.setfocus()
//		idw_detail.setcolumn("from_filter")
//		return
//	end if
//	//From Value Column
//	ls_from_value = idw_detail.getitemstring(ll_row, "from_value")
//	if isnull(ls_from_value) or len(trim(ls_from_value)) = 0 then
//		MessageBox("Required","New Value is required. Try again !")
//		idw_detail.setfocus()
//		idw_detail.setcolumn("from_value")
//		return
//	end if
	//To Table Column
	ls_to_table = string(idw_detail.getitemnumber(ll_row, "to_table"))
	if isnull(ls_to_table) or LenA(trim(ls_to_table)) = 0 then
		MessageBox("Verification","The To Table is required!")
		idw_detail.setfocus()
		idw_detail.setcolumn("to_table")
		return
	end if
	//To Field Column
	ls_to_field = string(idw_detail.getitemnumber(ll_row, "to_field"))
	if isnull(ls_to_field) or LenA(trim(ls_to_field)) = 0 then
		MessageBox("Verification","The To Field is required!")
		idw_detail.setfocus()
		idw_detail.setcolumn("to_field")
		return
	end if
//	//To Filter Column
//	ls_to_filter = idw_detail.getitemstring(ll_row, "to_filter")
//	if isnull(ls_to_filter) or len(trim(ls_to_filter)) = 0 then
//		MessageBox("Required","To Filter is required. Try again !")
//		idw_detail.setfocus()
//		idw_detail.setcolumn("to_filter")
//		return
//	end if
	//To Value Column
	ls_to_value = idw_detail.getitemstring(ll_row, "to_value")
	if isnull(ls_to_value) or LenA(trim(ls_to_value)) = 0 then
		MessageBox("Verification","The Update Value is required!")
		idw_detail.setfocus()
		idw_detail.setcolumn("to_value")
		return
	end if
end if

//Set df id
if ll_row > 0 then
	if idw_detail.getitemstatus(ll_row, 0, primary!) = newmodified! then
		select max(df_id) into :ll_id from data_flow;
		if isnull(ll_id) then ll_id = 0
		ll_id ++
		idw_detail.setitem(ll_row, "df_id", ll_id)
	end if
end if

//Update data
if idw_detail.update() = 1 then
	idw_browse.retrieve() 
	if ll_id > 0 then //for new record
		ll_row = idw_browse.find("df_id = " + String(ll_id), 1, idw_browse.rowcount())
		if ll_row > 0 then idw_browse.scrolltorow(ll_row)
	elseif idw_detail.getrow() < 1 then //for deleted record
		idw_browse.event rowfocuschanged(idw_browse.getrow())
	end if
	
	//refresh the cached data - alfee 03.06.2010
	gnv_data.of_retrieve('data_flow') 		
	//MessageBox("Save", "Succeeded to save data!")
	//	commit;
else
	MessageBox("Save", "Failed to save data!")
	//	rollback;
end if
end event

type cb_close from commandbutton within w_data_flow_painter
integer x = 2606
integer y = 60
integer width = 306
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;
close(parent)
end event

type st_master from statictext within w_data_flow_painter
boolean visible = false
integer x = 640
integer width = 1550
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Only user MASTER can make modifcations to the Data flow setup."
boolean focusrectangle = false
end type

type tab_1 from tab within w_data_flow_painter
integer x = 18
integer y = 76
integer width = 2903
integer height = 2036
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.Control[]={this.tabpage_browse,&
this.tabpage_detail}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
end on

event selectionchanged;if newindex = 1 then
	cb_retrieve.enabled = true
	cb_view.enabled = false
	cb_add.enabled = false
	cb_delete.enabled = false
	cb_save.enabled = false
else
	cb_retrieve.enabled = false
	cb_view.enabled = true
	cb_add.enabled = true
	cb_delete.enabled = true
	cb_save.enabled = true
end if
end event

event selectionchanging;//integer li_ret
//
//if oldindex = 2 then
//	idw_detail.accepttext()
//	if idw_detail.modifiedcount() <> 0 or idw_detail.deletedcount() <> 0 then
//		li_ret = MessageBox("Save Data", "Do you want to save the current data?", Question!, YesNo!, 1)
//		IF li_ret = 1 THEN
//			cb_save.event clicked()	
//		END IF	
//	end if
//end if

end event

type tabpage_browse from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2866
integer height = 1920
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
mle_1 mle_1
dw_browse dw_browse
end type

on tabpage_browse.create
this.mle_1=create mle_1
this.dw_browse=create dw_browse
this.Control[]={this.mle_1,&
this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.mle_1)
destroy(this.dw_browse)
end on

type mle_1 from multilineedit within tabpage_browse
integer x = 9
integer y = 20
integer width = 2798
integer height = 176
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Data Flow is a powerful tool, but it can be damaging to your data if used improperly. Extreme care must be exercised when creating Data Flows as improper setup can modify records in an unintended fashion. Set up in a test environment, before deployment to a production system, is recommended.  If assistance is required, contact ISG Technical Support.  "
boolean border = false
end type

type dw_browse from datawindow within tabpage_browse
integer y = 224
integer width = 2843
integer height = 1672
integer taborder = 20
string dataobject = "d_data_flow_browse"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
//this.retrieve()
end event

event rowfocuschanged;long ll_id, ll_row, ll_from_table, ll_to_table

if ib_browse_retrieve then return  
if currentrow < 1 then return

this.selectrow(0, false)
this.selectrow(currentrow, true)

//retieve in detail dw
ll_id = this.getitemnumber(currentrow, "df_id")
idw_detail.retrieve(ll_id)

if idw_detail.rowcount() < 1 then of_add_row()

//retireve in field dddws
ll_row = idw_detail.getrow()
if ll_row < 1 then return 

ll_from_table = idw_detail.getitemnumber(ll_row, "from_table")
ll_to_table = idw_detail.getitemnumber(ll_row, "to_table")

gnv_appeondb.of_startqueue()
idwc_field_from.retrieve(ll_from_table)
idwc_field_to.retrieve(ll_to_table)
gnv_appeondb.of_commitqueue()
if idwc_field_from.rowcount() < 1 then	idwc_field_from.insertrow(0)
if idwc_field_to.rowcount() < 1 then idwc_field_to.insertrow(0)

//set edit style for value fields
of_set_value_field("from_value")
of_set_value_field("to_value")

of_filter_totable(idw_detail.getitemstring(ll_row,"update_type"))	//v12.2 priv suspention added by long.zhang 06.12.2012



end event

event doubleclicked;
if row > 0 then  //alfee 01.07.2010
	this.scrolltorow(row)
	tab_1.SelectTab(2)
end if

end event

event retrievestart;ib_browse_retrieve = true //alfee 01.07.2010
end event

event retrieveend;ib_browse_retrieve = false //alfee 01.07.2010
end event

type tabpage_detail from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2866
integer height = 1920
long backcolor = 16777215
string text = "Detail"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_detail dw_detail
end type

on tabpage_detail.create
this.dw_detail=create dw_detail
this.Control[]={this.dw_detail}
end on

on tabpage_detail.destroy
destroy(this.dw_detail)
end on

type dw_detail from datawindow within tabpage_detail
integer y = 8
integer width = 2866
integer height = 1916
integer taborder = 20
string dataobject = "d_data_flow_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
//this.retrieve()
end event

event buttonclicked;string ls_mess, ls_filter
string ls_tableid
string ls_table_name, ls_from_tablenm
string ls_syntax
string ls_from_facility = "facility_id"
string ls_facility = "facility_id"
integer li_table, li_from_table

this.accepttext()
if row <= 0 then return
IF dwo.Name = "b_from_wiz" or dwo.Name = "b_to_wiz" THEN	
	IF dwo.Name = "b_from_wiz" then
		ls_tableid = string(this.getitemnumber(row, "from_table"))	
		//ls_filter = this.getitemstring(row, "from_filter")
	else
		ls_tableid = string(this.getitemnumber(row, "to_table"))	
		//ls_filter = this.getitemstring(row, "to_filter")
	end if
	
	if isnull(ls_tableid) then ls_tableid = '0'
	//if isnull(ls_filter) then ls_filter = ''
	//ls_Mess = ls_tableid + "|" + ls_filter
	//OpenWithParm(w_filter_wizard, ls_Mess)
	ls_Mess = "PD_DATAFLOW|" + ls_tableid + "|NULL|NULL"
	OpenWithParm(w_query_wizard, ls_Mess)
	
	ls_mess = message.stringparm
	if lower(ls_mess) <> "cancel" then		
		IF dwo.Name = "b_from_wiz" then
			this.setitem(row,"from_filter",ls_mess)
		else
			this.setitem(row,"to_filter",ls_mess)
		end if
	end if	
	return;
end if

if dwo.name = "b_prac" then
	li_table = this.getitemnumber(row, "to_table")
	select table_name into :ls_table_name from sys_tables where table_id = :li_table;
	ls_syntax = this.getitemstring(row, "to_filter")
	if isnull(ls_syntax) then ls_syntax = ""
	if LenA(ls_syntax) > 0 and PosA(ls_syntax,"and",LenA(ls_syntax) - 4) = 0 then ls_syntax+= " and" //check for and 
	ls_syntax+= " " + ls_table_name + ".prac_id = %%prac_id"
	this.setitem(row,"to_filter",ls_syntax)
end if

if dwo.name = "b_facil" then
	li_table = this.getitemnumber(row, "to_table")
	select table_name into :ls_table_name from sys_tables where table_id = :li_table;	
	if ls_table_name = "pd_affil_stat" or ls_table_name = "dba.pd_affil_stat" then ls_facility = "parent_facility_id"
	ls_syntax = this.getitemstring(row, "to_filter")
	if isnull(ls_syntax) then ls_syntax = ""
	if LenA(ls_syntax) > 0 and PosA(ls_syntax,"and",LenA(ls_syntax) - 4) = 0 then ls_syntax+= " and" //check for and 

	//--------Begin Modified by Alfee 03.10.2010 ------------
	li_from_table = this.getitemnumber(row, "from_table")
	if isnull(li_from_table) then li_from_table = -1
	ls_from_tablenm = gnv_data.of_getitem("sys_tables", "table_name", "table_id = " + String(li_from_table));
	if ls_from_tablenm = "pd_affil_stat" or ls_from_tablenm = "dba.pd_affil_stat" then ls_from_facility = "parent_facility_id"		
	
	ls_syntax+= " " + ls_table_name + "." + ls_facility + " = %%" + ls_from_facility
	//ls_syntax+= " " + ls_table_name + "." + ls_facility + " = %%facility_id"
	//---------End Modified ---------------------------------
	
	this.setitem(row,"to_filter",ls_syntax)
end if

//Start Code Change ----02.02.2016 #V15 maha
if dwo.name = "b_rec" then
	li_table = this.getitemnumber(row, "to_table")
	select table_name into :ls_table_name from sys_tables where table_id = :li_table;
	ls_syntax = this.getitemstring(row, "to_filter")
	if isnull(ls_syntax) then ls_syntax = ""
	if LenA(ls_syntax) > 0 and PosA(ls_syntax,"and",LenA(ls_syntax) - 4) = 0 then ls_syntax+= " and" //check for and 
	ls_syntax+= " " + ls_table_name + ".rec_id = %%rec_id"
	this.setitem(row,"to_filter",ls_syntax)
end if	
//End Code Change ----02.02.2016

if dwo.name = "b_help" then
	messagebox("Data Flow","It is also possible to add other field references other than Prac and Facility.  For these using %% in front of the field name will tell the program that you want the table name from the Modified table added in front of the field name.~r~rClicking the View Syntax button will show you the syntax that will be used.~r~rTypically the Prac filtering will always be used.")
end if
end event

event itemchanged;long ll_rowcount
long ll_row 
String ls_null


Setnull(ls_null)

if row < 1 then return
if dwo.name = "from_table" then
	this.SetItem(row,"from_field",ls_null)
	this.SetItem(row,"from_value",ls_null)
	ll_rowcount = idwc_field_from.retrieve(long(data))
	if ll_rowcount < 1 then idwc_field_from.insertrow(0)
end if

if dwo.name = "to_table" then
	this.SetItem(row,"to_field",ls_null)
	this.SetItem(row,"to_value",ls_null)
	ll_rowcount = idwc_field_to.retrieve(long(data))
	if ll_rowcount < 1 then idwc_field_to.insertrow(0)
	
	if data = "90" then //added by long.zhang 06.12.2012 V12.2 Privilege Suspension 
		ll_row = idwc_field_to.find( "field_id=31008",1,idwc_field_to.rowcount())
		if ll_row > 0 then
			this.setitem( row,"to_field",31008)
			idwc_field_to.scrolltorow( ll_row)
		end if
	else
		if this.getItemnumber( row,"to_field") = 31008 then
			this.setitem( row,"to_field",ls_null)
		end if
	end if
	
end if

if dwo.name = "from_field" then
	this.setitem(row,"from_value",ls_null)
	of_set_value_field("from_value")
elseif dwo.name = "to_field" then
	this.setitem(row,"to_value",ls_null)	
	of_set_value_field("to_value")
end if

if dwo.name="update_type" then	//added by long.zhang 06.12.2012 V12.2 Privilege Suspension 
	//Start Code Change ----07.26.2012 #V12 maha
	if data = "P" then  //priv susp
		of_set_defaults("P")
	end if
	if of_filter_totable(data) =1 then
		this.event itemchanged(row,this.object.to_table,string(this.getitemnumber(row,"to_table")))
		of_set_value_field("to_value")
	end if
	
end if


end event

