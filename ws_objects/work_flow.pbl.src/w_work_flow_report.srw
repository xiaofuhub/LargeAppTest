$PBExportHeader$w_work_flow_report.srw
$PBExportComments$w_work_flow_report
forward
global type w_work_flow_report from window
end type
type cb_print from commandbutton within w_work_flow_report
end type
type cb_close from commandbutton within w_work_flow_report
end type
type dw_1 from datawindow within w_work_flow_report
end type
end forward

global type w_work_flow_report from window
integer width = 3703
integer height = 2420
boolean titlebar = true
string title = "Work Flow Report"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_print cb_print
cb_close cb_close
dw_1 dw_1
end type
global w_work_flow_report w_work_flow_report

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-15 By: Scofield
//$<Reason> Add four instance variables to save data.

long		il_Count
String	is_Module

DataStore	ids_ConType
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public subroutine of_set_tag (string as_module)
end prototypes

public subroutine of_set_tag (string as_module);datawindowchild ldwc_child
String ls_type, ls_err
//Retrieve DDDW for Action Types
dw_1.GetChild("action_type_id" , ldwc_child)
ldwc_child.Settransobject(sqlca)
Choose Case as_module
	Case '01'
		ls_type = 'Verification Method'
	Case '02'
		ls_type = 'Action Type'
	Case '03',"04"
		ls_type = 'Contract Action Type'
//	Case '04'
//		ls_type = 'Agreement Manager Action Type'
End Choose
ls_err = dw_1.Modify("action_type_id.Tag = '" + ls_Type + "'")

Return

end subroutine

on w_work_flow_report.create
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={this.cb_print,&
this.cb_close,&
this.dw_1}
end on

on w_work_flow_report.destroy
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event open;Long 		ll_wf_id,ll_Row,ll_Cycle,ll_Cnts
Integer	li_Rtn
String	ls_SQL,ls_Rtn,ls_Error,ls_User,ls_EMailUser[]

DataWindowChild	ldwc_dw1,ldwc_Child,ldwc_Source

is_Module = Message.StringParm

ll_wf_id = Long(LeftA(is_Module, LenA(is_Module) - 2))
is_Module = RightA(is_Module, 2)

IF IsNull(ll_wf_id) OR ll_wf_id = 0  THEN RETURN

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-15 By: Scofield
//$<Reason> Get the Contract Contact Type data cache.

if is_Module = '03' or is_Module = '04' then	
	ls_SQL = "select lookup_code,code from code_lookup where lookup_name = 'Contract Contact Type';"
	ls_Rtn = SQLCA.SyntaxFromSQL(ls_SQL,"",ls_Error)
	
	ids_ConType = Create DataStore
	
	ids_ConType.Create(ls_Rtn,ls_Error)
	ids_ConType.SetTransObject(SQLCA)
	il_Count = ids_ConType.Retrieve()
end if
//---------------------------- APPEON END ----------------------------

of_Set_Tag(is_Module)
dw_1.Event ue_populatedddws()

dw_1.SetTransObject(Sqlca)

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-09-19 By: Scofield
//$<Reason> Remove the $$ symbol.

IF dw_1.Retrieve(ll_wf_id) > 0 THEN
	ll_Row = dw_1.GetRow()
	ls_EMailUser[UpperBound(ls_EMailUser) + 1] = "wf_action_types_to_user"
	ls_EMailUser[UpperBound(ls_EMailUser) + 1] = "wf_action_types_by_user"
	ls_EMailUser[UpperBound(ls_EMailUser) + 1] = "send_to_user"
	ls_EMailUser[UpperBound(ls_EMailUser) + 1] = "wf_action_types_cc_user"
	
	ll_Cnts = UpperBound(ls_EMailUser)
	for ll_Cycle = 1 to ll_Cnts
		ls_User = Trim(dw_1.GetItemString(ll_Row,ls_EMailUser[ll_Cycle]))
		if ls_User = "$$Owner$$" then
			dw_1.SetItem(ll_Row,ls_EMailUser[ll_Cycle],"Contract Owner")
		elseif LeftA(ls_User,2) = "$$" and RightA(ls_User,2) = "$$" then
			dw_1.SetItem(ll_Row,ls_EMailUser[ll_Cycle],MidA(ls_User,3,LenA(ls_User) - 4))
		end if
	next
	
	cb_print.Enabled = True
END IF
//---------------------------- APPEON END ----------------------------

end event

event close;if IsValid(ids_ConType) then Destroy ids_ConType

end event

type cb_print from commandbutton within w_work_flow_report
integer x = 2871
integer y = 2208
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Print"
end type

event clicked;//String ls_PrintFile
//ls_PrintFile = dw_1.Describe("datawindow.print.filename")

//dw_1.Modify("datawindow.print.filename = 'c:\temp'")
dw_1.Print()

//dw_1.Modify("datawindow.print.filename = '" + ls_PrintFile + "'")
end event

type cb_close from commandbutton within w_work_flow_report
integer x = 3296
integer y = 2208
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type dw_1 from datawindow within w_work_flow_report
event ue_populatedddws ( )
integer x = 27
integer y = 20
integer width = 3611
integer height = 2176
integer taborder = 10
string title = "none"
string dataobject = "d_workflow_report"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_populatedddws();long 		ll_Column_Count,ll_i
String 	ls_dddw_name,ls_ColName,ls_coltag,ls_Code
Integer 	li_value
long		ll_Row,ll_Cycle,ll_LUpCode

DataWindowChild 	dwchild,ldc_Child
n_ds 					lnds_user

ll_Column_Count = long(This.Describe("DataWindow.Column.Count"))
if ll_Column_Count = 0 then Return

for ll_i = 1 to ll_Column_Count
	if Describe("#" +String(ll_i) + ".Edit.Style") = 'dddw' then
		ls_ColName = Describe("#" +String(ll_i) + ".Name")
		ls_dddw_name = lower(Describe("#" +String(ll_i) + ".DDDW.Name"))
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modify> 2008-04-15 By: Scofield
		//$<Reason> Update the datawindow drop down list value.
		
		if (ls_ColName = 'wf_action_types_to_user' or ls_ColName = 'wf_action_types_by_user' or ls_ColName = 'send_to_user' or ls_ColName = 'wf_action_types_cc_user') and (is_Module = '03' or is_Module = '04') then
			This.GetChild(ls_ColName,ldc_Child)
			for ll_Cycle = 1 to il_Count
				ll_LUpCode = ids_ConType.GetItemNumber(ll_Cycle,'lookup_code')
				ls_Code = ids_ConType.GetItemString(ll_Cycle,'code')
				ll_Row = ldc_Child.InsertRow(0)
				ldc_Child.SetItem(ll_Row,"user_id",String(ll_LUpCode))
				ldc_Child.SetItem(ll_Row,"user_name",ls_Code)
			next
		else
			if ls_dddw_name = "d_dddw_code_lookup" OR ls_dddw_name = "d_dddw_code_lookup_action_type" then
				ls_coltag = Lower(Describe("#" +String(ll_i) + ".TAG"))
				li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
					
				if li_value <> 1 then
					gnv_app.of_setcontraccache_code_lookup( ls_coltag )
					li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
				end if
			else
				li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user)
			end if
	
			if li_value = 1 then
				getchild( ls_ColName, dwchild)
				lnds_user.ShareData ( dwchild )
			end if
		end if
		//---------------------------- APPEON END ----------------------------
	end if
next

end event

