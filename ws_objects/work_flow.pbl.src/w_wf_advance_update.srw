$PBExportHeader$w_wf_advance_update.srw
forward
global type w_wf_advance_update from w_response
end type
type cb_criteria from commandbutton within w_wf_advance_update
end type
type dw_screen from u_dw within w_wf_advance_update
end type
type cb_delete from commandbutton within w_wf_advance_update
end type
type cb_add from commandbutton within w_wf_advance_update
end type
type cb_ok from commandbutton within w_wf_advance_update
end type
type cb_cancel from commandbutton within w_wf_advance_update
end type
type dw_data from u_dw within w_wf_advance_update
end type
end forward

global type w_wf_advance_update from w_response
integer width = 2697
integer height = 1564
string title = "Advanced Update Data"
long backcolor = 33551856
cb_criteria cb_criteria
dw_screen dw_screen
cb_delete cb_delete
cb_add cb_add
cb_ok cb_ok
cb_cancel cb_cancel
dw_data dw_data
end type
global w_wf_advance_update w_wf_advance_update

type variables
str_parm istr_parm
n_cst_workflow_triggers inv_workflow
end variables

on w_wf_advance_update.create
int iCurrent
call super::create
this.cb_criteria=create cb_criteria
this.dw_screen=create dw_screen
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_data=create dw_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_criteria
this.Control[iCurrent+2]=this.dw_screen
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.dw_data
end on

on w_wf_advance_update.destroy
call super::destroy
destroy(this.cb_criteria)
destroy(this.dw_screen)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_data)
end on

event open;call super::open;datawindowchild ldwc

//Get Parm
istr_parm = Message.Powerobjectparm

//Retrieve DDDW
dw_data.event pfc_populatedddw("screen_id", ldwc)
dw_data.event pfc_populatedddw("field_label", ldwc)

//Retrieve data
dw_data.event pfc_retrieve()
end event

event pfc_preopen;call super::pfc_preopen;inv_workflow = create n_cst_workflow_triggers
end event

event close;call super::close;if isvalid(inv_workflow) then destroy inv_workflow
end event

type cb_criteria from commandbutton within w_wf_advance_update
integer x = 773
integer y = 1360
integer width = 393
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update Criteria"
end type

event clicked;if parent.event pfc_save() >=0 then
	istr_parm.l_key_id = dw_data.GetItemNumber( dw_data.getRow(), "key_id")
	istr_parm.l_screen_id = dw_data.GetItemNumber( dw_data.getRow(), "screen_id")
	
	Openwithparm(w_wf_advance_update_criteria,istr_parm)
end if
end event

type dw_screen from u_dw within w_wf_advance_update
boolean visible = false
integer x = 1074
integer y = 1592
integer width = 727
integer height = 152
integer taborder = 0
end type

type cb_delete from commandbutton within w_wf_advance_update
integer x = 402
integer y = 1360
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;dw_data.event pfc_deleterow()
end event

type cb_add from commandbutton within w_wf_advance_update
integer x = 32
integer y = 1360
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;dw_data.event pfc_AddRow()

//(Appeon)Alfee 12.18.2013 - V141 ISG-CLX for BugH121003
dw_data.setcolumn("screen_id")
dw_data.setfocus( )


end event

type cb_ok from commandbutton within w_wf_advance_update
integer x = 1929
integer y = 1360
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;parent.event pfc_save()
close(parent)
end event

type cb_cancel from commandbutton within w_wf_advance_update
integer x = 2295
integer y = 1360
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;close(parent)
end event

type dw_data from u_dw within w_wf_advance_update
integer x = 32
integer y = 28
integer width = 2619
integer height = 1296
integer taborder = 10
string dataobject = "d_wf_advanced_update"
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;long ll_screen_id
string ls_lookup_name 
string ls_desc
str_pass lstr_pass
datawindow	ldw[]
string ls_dw_name[]
string ls_dataobject[]
string ls_tab_name
string ls_dddw_type

choose case dwo.name
	case 'b_screen'
		//Select screen base on view
		OpenWithParm(w_contract_selectscreen,istr_parm.l_view_id)
		ll_screen_id = Message.doubleparm
		if ll_screen_id > 0 then
			this.SetItem( row,'screen_id',ll_screen_id)
			this.event ItemChanged(row,dwo,string(ll_screen_id))
			this.event ItemFocusChanged(row,this.object.field_label)
		end if
	case 'b_lookup'
		ls_dddw_type = this.GetItemString( row, "field_flag")
		ls_lookup_name = this.GetItemString(row,"lookup_name")
		if ls_dddw_type = 'C' then
			//Select code lookup
			OpenWithParm( w_lookup_search_dddw,'C' + "@" + ls_lookup_name)
			if message.stringparm <> "Cancel" then
				this.SetItem(row,"field_value",string(message.DoubleParm))
				ls_desc = gnv_data.of_GetItem("code_lookup","code","lookup_code = " + string(message.DoubleParm))
				this.SetItem(row,"field_display_value",ls_desc)
			end if
		elseif ls_dddw_type = 'P' then	//Company dddw-jervis 12.9.2009
			string ls_value
			string ls_operator
			//Select company
			OpenWithParm(w_facility_name_select,"code&" + ls_lookup_name)
			
			ls_Value = Message.StringParm
			if IsNull(ls_Value) or Trim(ls_Value) = "" then Return
			
			ls_operator = this.GetItemString(row, "operator")
			if Lower(ls_operator) <> "in" then
				ls_Value = Left(ls_Value,Pos(ls_Value,",") - 1)
			else
				ls_Value = Left(ls_Value,Len(ls_Value) - 1)
			end if
			
			This.SetItem(row,"field_value", ls_value)
			ls_desc = gnv_data.of_getItem("ctx_facility","facility_name","facility_id = " + string(ls_value))
			This.SetItem(row,"field_display_value",ls_desc)
		elseif ls_dddw_type= 'U' then 	//User dddw-jervis 12.9.2009
			//
		end if
	case 'b_expression'
		ll_screen_id = this.GetItemNumber( row,'screen_id')
		if ll_screen_id > 0 then
			//Dynamic Create Screen DW
			ls_tab_name = gnv_data.of_get_table_name( ll_screen_id, 'C', 'tab_name')
			ldw[1] = dw_screen
			ls_dw_name[1] 		= gnv_data.of_get_table_name( ll_screen_id, 'C', 'dw_name')
			ls_dataobject[1] 	= gnv_data.of_get_table_name( ll_screen_id, 'C', 'dataobject')
			f_create_contract_dw(istr_parm.l_view_id ,ls_tab_name,ldw,ls_dw_name,ls_dataobject)
	
			//Advanced Update
			//lstr_pass.s_long[1] = 3	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call
			lstr_pass.s_long[1] = 4	//Use SQL Format Expression - jervis 11.03.2010
			//lstr_pass.l_facility_id
			if this.GetItemString( row,"field_flag") = 'E' then
				lstr_pass.s_string          = this.GetItemString(row,'field_expression')
			end if
			//lstr_pass.s_string_array[1] = this.GetItemString( row,'field_colname')
			lstr_pass.s_string_array[1] = this.GetItemString( row,'field_name')
			lstr_pass.s_string_array[2] = this.GetItemString(row, 'field_type')
			
			//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
			//Added By Mark Lee 09/07/12
//			lstr_pass.s_u_dw            = dw_screen
			lstr_pass.s_u_dw            = this
			
			//Added By Mark Lee 09/07/12
			this.event ItemfocusChanged(row,this.object.field_label)
			//---------End Modfiied ------------------------------------------------------
			
			OpenWithParm(w_export_expression,lstr_pass)
			lstr_pass = Message.PowerObjectParm
			if isvalid(lstr_pass) then
				if  trim(lstr_pass.s_string) <> "" then
					this.SetItem(row,"Field_display_value",lstr_pass.s_string)
					this.SetItem(row,"field_flag",'E')
					this.SetItem(row,"field_expression",lstr_pass.s_string)
				end if
			end if
		end if
end choose
end event

event pfc_retrieve;call super::pfc_retrieve;long ll_ret
ll_ret =  retrieve(istr_parm.l_wf_id,istr_parm.l_step_id,istr_parm.l_status_id )

if ll_ret < 1 then
	event pfc_addrow()
end if
return ll_ret
end event

event pfc_preupdate;call super::pfc_preupdate;long ll_count,ll_i

ll_count = this.Rowcount( )

for ll_i = 1 to ll_count
	if this.GetItemStatus( ll_i,0,primary!) = NewModified! then
		this.setItem(ll_i,"wf_id",istr_parm.l_wf_id)
		this.setItem(ll_i,"view_id",istr_parm.l_view_id)
		this.SetItem(ll_i,"wf_step_id",istr_parm.l_step_id)
		this.SetItem(ll_i,"wf_status_id",istr_parm.l_status_id)
	end if
next
return 1
end event

event itemchanged;call super::itemchanged;string ls_null
datawindowchild ldwc
long ll_row


SetNull(ls_null)
Choose Case dwo.name
	Case "screen_id"
		//Clear field_name data
		this.SetItem(row,"field_label",ls_null)
		this.SetItem(row,"field_name",ls_null)
		this.SetItem(row,"field_flag",ls_null)
		this.SetItem(row,"lookup_name",ls_null)
		this.SetItem(row,"field_expression",ls_null)
		this.SetItem(row,"field_value",this.GetItemString(row,"field_display_value"))

		
		if row > 0 then
			if data = '31' or data = '33' then
				cb_criteria.enabled= true
			else
				cb_criteria.enabled= false
			end if
		end if

	Case "field_label"
		If this.GetChild( dwo.name,ldwc) = 1 Then
			ll_row = ldwc.GetRow()
			
			this.SetItem(row,"field_name",ldwc.GetItemString(ll_row,"sys_fields_field_name"))
			this.SetItem(row,"field_type",ldwc.GetItemString(ll_row,"sys_fields_field_type"))
			
			//start code 1.11.2007 By jervis
			if ldwc.GetItemString(ll_row,"sys_fields_lookup_type") = 'C' and ldwc.GetItemString(ll_row,"sys_fields_lookup_field") = 'Y' and ldwc.GetItemString(ll_row,"sys_fields_lookup_field_name") = 'Code' then
				this.SetItem(row,"field_flag","C")
				this.SetItem(row,"lookup_name",ldwc.GetItemString(ll_row,"sys_fields_lookup_code"))
				this.SetItem(row,"field_value",ls_null)
				this.SetItem(row,"field_display_value",ls_null)
			elseif ldwc.GetItemString(ll_row,"sys_fields_lookup_type") = 'P' then	//Company dddw-jervis 12.9.2009
				this.SetItem(row,"field_flag","P")
				this.SetItem(row,"lookup_name",ldwc.GetItemString(ll_row,"sys_fields_lookup_code"))
				this.SetItem(row,"field_value",ls_null)
				this.SetItem(row,"field_display_value",ls_null)
			elseif ldwc.GetItemString(ll_row,"sys_fields_lookup_type") = 'U' then	//user dddw - jervis 12.9.2009
				this.SetItem(row,"field_flag","U")
				this.SetItem(row,"lookup_name",ls_null)
				this.SetItem(row,"field_value",ls_null)
				this.SetItem(row,"field_display_value",ls_null)
			else
				this.SetItem(row,"field_flag",ls_null)
				this.SetItem(row,"lookup_name",ls_null)
				//this.SetItem(row,"field_value",this.GetItemString(row,"field_display_value"))
				this.SetItem(row,"field_value",ls_null)
				this.SetItem(row,"field_display_value",ls_null)
			end if
			//end code 
			
			this.SetItem(row,"table_name",ldwc.GetItemString(ll_row,"table_name"))
		End If
	case "field_display_value"
		this.SetItem(row,"field_value",data)
End Choose
end event

event itemfocuschanged;call super::itemfocuschanged;long ll_screen_id,ll_row
datawindowchild ldwc_field,ldwc_screen
string ls_dwsyntax



if dwo.name = "field_label" then
	ll_screen_id = this.GetItemNumber( row, "screen_id")
	if this.GetChild( dwo.name,ldwc_field) = 1 then
		if ll_screen_id > 0 then
			ldwc_field.SetFilter( "data_view_screen_screen_id = " + string(ll_screen_id))
			ldwc_field.Filter()
		else
			ldwc_field.SetFilter( "1 = 2")
			ldwc_field.Filter( )
		end if
	
		if ldwc_field.Rowcount( ) < 1  then
			//Init Contract Logix Field Data of Screen
			if this.GetChild( "screen_id",ldwc_screen) = 1 then
				ll_row = ldwc_screen.find( "screen_id = " + string(ll_screen_id), 1,ldwc_screen.RowCount())
				if ll_row > 0 then
					//Dynamic Create DataStore,Gets all field
					inv_workflow.of_build_fielddddw(istr_parm.l_view_id,ll_screen_id,dw_screen,ldwc_field,"")
				end if
	
			end if
		end if
	end if
elseif this.GetChild( "field_label", ldwc_field) = 1 then
	if ldwc_field.Describe("datawindow.table.filter") <> "?" then
		ldwc_field.SetFilter("")
		ldwc_field.Filter( )
		this.SetRedraw( true)
	end if
end if

end event

event pfc_populatedddw;call super::pfc_populatedddw;long ll_ret
if this.GetChild( as_colname,adwc_obj) = 1 then
	adwc_obj.SetTransObject(sqlca)
	ll_ret = adwc_obj.Retrieve(istr_parm.l_view_id)
	if ll_ret < 1 then
		ll_ret = adwc_obj.InsertRow(0)
	end if
	if as_colname = 'screen_id' then	//Only can update contract info
		//adwc_obj.SetFilter("screen_id = 3 or screen_id = 5 or screen_id = 9 or screen_id = 8")
		adwc_obj.SetFilter("screen_id in (3,5,8,9,31,33)")		//Add 31,33(Fee Schedule NM, Action Item) - jervis 09.27.2010
		adwc_obj.Filter()
	end if
end if
return ll_ret
end event

event rowfocuschanged;call super::rowfocuschanged;//Add record update criteria for fee schedule NM and Action Items - jervis 09.27.2010

long ll_screen_id
if currentrow > 0 then
	ll_screen_id = this.GetItemNumber( currentrow,"screen_id")
	if ll_screen_id = 31 or ll_screen_id = 33 then
		//Open(w_wf_advance_update_criteria,ll_screen_id)
		cb_criteria.enabled= true
	else
		cb_criteria.enabled= false
	end if
end if
end event

event pfc_postupdate;call super::pfc_postupdate;//delete waste data - jervis 10.12.2010
delete wf_advanced_update_criteria
from wf_advanced_update
where wf_advanced_update_criteria.wf_id = wf_advanced_update.wf_id and
		wf_advanced_update_criteria.view_id = wf_advanced_update.view_id and		
		wf_advanced_update_criteria.wf_step_id = wf_advanced_update.wf_step_id and 
		wf_advanced_update_criteria.wf_status_id = wf_advanced_update.wf_status_id and
		wf_advanced_update_criteria.key_id	= wf_advanced_update.key_id and wf_advanced_update_criteria.screen_id <> wf_advanced_update.screen_id;
		
commit;

		
return 1
end event

event constructor;call super::constructor;this.of_setrowselect( true)
this.inv_rowselect.of_setstyle( this.inv_rowselect.single )
end event

