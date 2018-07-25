$PBExportHeader$w_agreement_template_properties.srw
forward
global type w_agreement_template_properties from w_popup
end type
type cb_cancel from commandbutton within w_agreement_template_properties
end type
type cb_ok from commandbutton within w_agreement_template_properties
end type
type dw_1 from u_dw_contract within w_agreement_template_properties
end type
end forward

global type w_agreement_template_properties from w_popup
integer width = 1897
integer height = 1580
string title = "Template Properties"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
event ue_inidw ( )
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
end type
global w_agreement_template_properties w_agreement_template_properties

type variables
long il_status_ori //added by alfee 08.31.2007
Long il_default_category = -1//03.12.2008
string is_msg  //action message
boolean ib_need_update //

datawindow idw_browse
n_cst_right inv_right 
end variables

forward prototypes
public function integer of_check_required ()
end prototypes

event ue_inidw();//////////////////////////////////////////////////////////////////////
// $<event>ue_inidw.w_agreement_template_properties()
// $<arguments>
// $<returns> (None)
// $<description>Initialize datawindows
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_currentrow,ll_row,ll_find
long ll_template_id,ll_category,ll_reviewed_status
integer li_export_id,li_wf_id
string ls_template_name,ls_description,ls_reviewed_by
datetime ldt_date_reviewed
datawindowchild dwc_status

if not isvalid(idw_browse) then return
ll_currentrow = idw_browse.getrow()

ll_row = dw_1.insertrow(0)

choose case lower(is_msg)
	case "add"		
		//Set default category - 03.12.2008
		if il_default_category > 0 then
			dw_1.SetItem(ll_row,"category", il_default_category)
		end if
		
		//set default value of reviewed status
		if dw_1.getchild("reviewed_status",dwc_status) = 1 then
			ll_find = dwc_status.find("lower(code) = 'pending'",1,dwc_status.rowcount())
			if ll_find > 0 then 
				ll_reviewed_status = dwc_status.getitemnumber(ll_find,"lookup_code")
				dw_1.setitem(ll_row,"reviewed_status",ll_reviewed_status)
				dw_1.setitem(ll_row,'date_reviewed',today())
				dw_1.setitem(ll_row,'reviewed_by',gs_user_id)	
			end if
		end if
	case "edit"
		if ll_currentrow < 1 then return
		ll_template_id = idw_browse.getitemnumber(ll_currentrow,"ctx_acp_template_id")
		ll_category = idw_browse.getitemnumber(ll_currentrow,"category")
		ls_template_name = idw_browse.getitemstring(ll_currentrow,"template_name")
		li_export_id = idw_browse.getitemnumber(ll_currentrow,"export_id")
		li_wf_id = idw_browse.getitemnumber(ll_currentrow,"wf_id")
		ls_description = idw_browse.getitemstring(ll_currentrow,"description")
		ls_reviewed_by = idw_browse.getitemstring(ll_currentrow,"reviewed_by")
		ldt_date_reviewed = idw_browse.getitemdatetime(ll_currentrow,"date_reviewed")
		ll_reviewed_status = idw_browse.getitemnumber(ll_currentrow,"reviewed_status")
			
		dw_1.setitem(ll_row,"ctx_acp_template_id",ll_template_id)
		dw_1.setitem(ll_row,"category",ll_category)
		dw_1.setitem(ll_row,"template_name",ls_template_name)
		dw_1.setitem(ll_row,"export_id",li_export_id)
		dw_1.setitem(ll_row,"wf_id",li_wf_id)
		dw_1.setitem(ll_row,"description",ls_description)
		dw_1.setitem(ll_row,"reviewed_by",ls_reviewed_by)
		dw_1.setitem(ll_row,"date_reviewed",ldt_date_reviewed)
		dw_1.setitem(ll_row,"reviewed_status",ll_reviewed_status)					
	case "copy"  
		//set default value of reviewed status
		if dw_1.getchild("reviewed_status",dwc_status) = 1 then
			ll_find = dwc_status.find("lower(code) = 'pending'",1,dwc_status.rowcount())
			if ll_find > 0 then 
				ll_reviewed_status = dwc_status.getitemnumber(ll_find,"lookup_code")
				dw_1.setitem(ll_row,"reviewed_status",ll_reviewed_status)
				dw_1.setitem(ll_row,'date_reviewed',today())
				dw_1.setitem(ll_row,'reviewed_by',gs_user_id)					
			end if
		end if	

		//Set other default values - 03.12.2008
		if ll_currentrow < 1 then return
		ll_category = idw_browse.getitemnumber(ll_currentrow,"category")
		ls_template_name = idw_browse.getitemstring(ll_currentrow,"template_name")
		li_export_id = idw_browse.getitemnumber(ll_currentrow,"export_id")
		li_wf_id = idw_browse.getitemnumber(ll_currentrow,"wf_id")
		ls_description = idw_browse.getitemstring(ll_currentrow,"description")
			
		dw_1.setitem(ll_row,"category",ll_category)
		dw_1.setitem(ll_row,"template_name","Copy of " + ls_template_name)
		dw_1.setitem(ll_row,"export_id",li_export_id)
		dw_1.setitem(ll_row,"wf_id",li_wf_id)
		dw_1.setitem(ll_row,"description",ls_description)		
				
end choose
		
		
		
end event

public function integer of_check_required ();//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_properties.of_check_required()
// $<arguments>
// $<returns> integer
// $<description> Check required columns
//////////////////////////////////////////////////////////////////////
// $<add> 11.10.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_row
string ls_column_name,ls_label_text

ll_row = dw_1.getrow()
if ll_row < 1 then return -1

if isnull(dw_1.getitemnumber(ll_row,"category")) then
	ls_column_name = "category"
elseif isnull(dw_1.getitemstring(ll_row,"template_name")) or &
		 len(dw_1.getitemstring(ll_row,"template_name")) < 1 then
	ls_column_name = "template_name"
elseif isnull(dw_1.getitemnumber(ll_row,"export_id")) then
	ls_column_name = "export_id"
elseif isnull(dw_1.getitemnumber(ll_row,"reviewed_status")) then
	ls_column_name = "reviewed_status"
end if

if len(ls_column_name) > 0 then
	ls_label_text = dw_1.describe(ls_column_name+"_t.text")	
	//messagebox("Template Properties", "The '" + ls_label_text +"' field cannot be empty!")
	messagebox( "IntelliSoftGroup", "Required value missing for " + ls_label_text + " on row 1. Please enter a value." )	
	dw_1.setfocus()
	dw_1.setcolumn(ls_column_name)
	return -1	
end if

/*----------Commented by Alfee 11.13.2007-------------------
//----------Begin Modified by Alfee 08.31.2007--------------
//<$Reason>Don't change the approved status if it used already
//<$Reason>This checking is necessary while adding lookup code funtion called by user
If Lower(is_msg) <> "edit" Then return 1

Long ll_templateid, ll_approved, ll_cnt, ll_status		
ll_templateid = dw_1.GetItemNumber(ll_row, "ctx_acp_template_id")
ll_status = dw_1.getitemnumber(ll_row,"reviewed_status")
ll_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Template Review Status' and code = 'Approved'"))	
If il_status_ori = ll_approved and ll_status <> ll_approved Then
	Select count(*) Into :ll_cnt From ctx_am_document Where base_type = '1' and from_templete_id = :ll_templateid ;
	If ll_cnt > 0 Then 
		MessageBox("Alert Message","This field can't be changed until the template is removed from the affected file(s).")
		dw_1.SetItem(ll_row, "reviewed_status", il_status_ori)		
		Return -1
	End If
End If
//-----------End Modified -------------------------------------
-------------End Commented-----------------------------------*/

return 1
end function

on w_agreement_template_properties.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_agreement_template_properties.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;//is_msg = message.stringparm
Integer li_setting

if isvalid(w_agreement_template_painter) then
	is_msg = w_agreement_template_painter.is_properties
	il_default_category = w_agreement_template_painter.il_category //03.12.2008
end if

ib_need_update = false
ib_disableclosequery = false

if len(is_msg) > 0 then this.title = this.title + " - " + is_msg

if isvalid(w_agreement_template_painter) then
	idw_browse = w_agreement_template_painter.tab_1.tabpage_1.dw_browse
	this.event ue_inidw()
end if

//-----------Appeon Begin-----------------------------
//Set work flow. By alfee 04.24.2007
li_setting = of_get_app_setting("set_47","I")
If li_setting = 0 Then
		dw_1.object.wf_id_t.visible = False
		dw_1.object.wf_id.visible = False
		dw_1.object.description_t.y = dw_1.object.wf_id_t.y
		dw_1.object.description.height = String(Integer(dw_1.object.description.height) + Integer(dw_1.object.description.y) - Integer(dw_1.object.wf_id.y))
		dw_1.object.description.y = dw_1.object.wf_id.y	
END IF
//-----------Appeon End-------------------------------

//-------Begin Added by Alfee 08.31.2007 --------------------
If Lower(is_msg) = 'edit' and dw_1.GetRow() > 0 Then 
	il_status_ori = dw_1.getitemnumber(dw_1.getrow(),'reviewed_status')	
End If		
//-------End Added ------------------------------------------		
		
//-------Begin Added by Alfee 09.20.2007----------------------
If w_mdi.of_security_access(6801) < 2 Then		
	dw_1.Enabled = False
	cb_ok.Enabled = False
End If
//-------End Added ------------------------------------------

		
		
end event

event pfc_save;call super::pfc_save;long ll_currentrow,ll_row
long ll_template_id,ll_new_template_id,ll_category,ll_reviewed_status
integer li_export_id,li_wf_id, li_filenum
string ls_template_name,ls_description,ls_reviewed_by,ls_filename,ls_new_filename,ls_sql
datetime ldt_date_reviewed, ldt_lastupdate,ldt_new_lastupdate
blob lblb_file

dw_1.accepttext() 
ll_row = dw_1.getrow()
ll_currentrow = idw_browse.getrow()

//check required columns
if of_check_required() = -1 then return -1

ll_template_id = dw_1.getitemnumber(ll_row,"ctx_acp_template_id")
ll_category = dw_1.getitemnumber(ll_row,"category")
ls_template_name = dw_1.getitemstring(ll_row,"template_name")
li_export_id = dw_1.getitemnumber(ll_row,"export_id")
li_wf_id = dw_1.getitemnumber(ll_row,"wf_id")
ls_description = dw_1.getitemstring(ll_row,"description")
ls_reviewed_by = dw_1.getitemstring(ll_row,"reviewed_by")
ldt_date_reviewed = dw_1.getitemdatetime(ll_row,"date_reviewed")
ll_reviewed_status = dw_1.getitemnumber(ll_row,"reviewed_status")

choose case lower(is_msg)
	case "add"
		//update DB
		//gnv_appeondb.of_startqueue() //commented by alfee 05.18.2007, this will cause a web bug;
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.17.2007 By: WuZhiJun
		//$<reason> 
		//insert into ctx_acp_template(ctx_acp_template_id,category,template_name,export_id,
		//				wf_id,description,reviewed_by,date_reviewed,reviewed_status)
 		//     select isnull(max(ctx_acp_template_id),0) + 1,:ll_category,:ls_template_name,:li_export_id,:li_wf_id,
		//		  	   :ls_description,:ls_reviewed_by,:ldt_date_reviewed,:ll_reviewed_status
  		//	    from ctx_acp_template ;		
		//---------------------------- APPEON END ----------------------------
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.17.2007 By: Jack
		//$<reason> 
		/*
		select max(ctx_acp_template_id) into :ll_template_id from ctx_acp_template ;
		*/
		ll_template_id = gnv_app.of_get_id("ctx_acp_template_id")
		//---------------------------- APPEON END ----------------------------
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 05.05.2007 By: WuZhiJun
		//-------------Begin Modified by Alfee 01.07.2008---------------------
		//<$Reason>update doctype field with default value of 'doc' for fulltextsearch
		INSERT INTO ctx_acp_template(ctx_acp_template_id,category,template_name,export_id,
						wf_id,description,reviewed_by,date_reviewed,reviewed_status, doctype)
 		     VALUES(:ll_template_id,:ll_category,:ls_template_name,:li_export_id,
						:li_wf_id,:ls_description,:ls_reviewed_by,:ldt_date_reviewed,:ll_reviewed_status,'doc');
		/*
		INSERT INTO ctx_acp_template(ctx_acp_template_id,category,template_name,export_id,
						wf_id,description,reviewed_by,date_reviewed,reviewed_status)
 		     VALUES(:ll_template_id,:ll_category,:ls_template_name,:li_export_id,
						:li_wf_id,:ls_description,:ls_reviewed_by,:ldt_date_reviewed,:ll_reviewed_status);
		*/
		//-------------End Modified -----------------------------------------
		//---------------------------- APPEON END ----------------------------
		
		//gnv_appeondb.of_commitqueue()	//commented by alfee 05.18.2007
	
	   if SQLCA.Sqlcode <> 0 then	
			messagebox("Template Properties","Template properties update failed!") 
			return -1
		end if			
		
 	   dw_1.setitem(ll_row,"ctx_acp_template_id",ll_template_id)
		
	case "edit"
		gnv_appeondb.of_startqueue() //for web performance tuning	
		//update DB
		update ctx_acp_template 
			set category=:ll_category, template_name=:ls_template_name,export_id=:li_export_id,
				 wf_id =:li_wf_id,description=:ls_description,reviewed_by=:ls_reviewed_by,
				 date_reviewed=:ldt_date_reviewed,reviewed_status=:ll_reviewed_status
	 	 where ctx_acp_template_id=:ll_template_id ;

		//refresh DataWindow
		idw_browse.setredraw(false)
		idw_browse.retrieve()
		idw_browse.setredraw(true)		
		gnv_appeondb.of_commitqueue()	//for web performance tuning

		if SQLCA.Sqlcode <> 0 then	
			messagebox("Template Properties","Template properties update failed!") 
			return -1
		end if	

		idw_browse.setrow(ll_currentrow)
		idw_browse.scrolltorow(ll_currentrow)
		
	case "copy"  		
		if ll_currentrow < 1 then return -1
		//get current template id and modify date
		ll_template_id = idw_browse.getitemnumber(ll_currentrow,"ctx_acp_template_id")
		ls_filename = w_agreement_template_painter.is_agreement_path + "template_" + string(ll_template_id) + ".doc"				
		ldt_lastupdate = idw_browse.getitemdatetime(ll_currentrow,"modify_date")
		
		//gnv_appeondb.of_startqueue() //for web performance tuning	
		//get or gen current local template file
		if isvalid(w_agreement_template_painter) then
			w_agreement_template_painter.of_get_template_file(ll_template_id,ldt_lastupdate)
		end if
		
		//get new template id
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.17.2007 By: Jack
		//$<reason> 
		/*
		select isnull(max(ctx_acp_template_id),0) + 1 into :ll_new_template_id from ctx_acp_template ;
		*/
		ll_new_template_id = gnv_app.of_get_id("ctx_acp_template_id")
		//---------------------------- APPEON END ----------------------------
		//gnv_appeondb.of_commitqueue()	//for web performance tuning
		ls_new_filename = w_agreement_template_painter.is_agreement_path + "template_" + string(ll_new_template_id) + ".doc"	
		ldt_new_lastupdate = datetime(today(),now())		
			
		//copy and save new template file into DB
		if not fileexists(ls_filename) or filecopy(ls_filename,ls_new_filename,true) < 1 then 
			messagebox("Template Properties","Can't copy the template file, update failed!") 
			return -1
		end if
		
		//update DB
		gnv_appeondb.of_startqueue() //for web performance tuning	
		//-------------Begin Modified by Alfee 01.07.2008---------------------
		//<$Reason>update doctype field with default value of 'doc' for fulltextsearch		
		/*
		insert into ctx_acp_template(ctx_acp_template_id,category,template_name,export_id,
						wf_id,description,reviewed_by,date_reviewed,reviewed_status)
 		     values(:ll_new_template_id,:ll_category,:ls_template_name,:li_export_id,:li_wf_id,
				  	   :ls_description,:ls_reviewed_by,:ldt_date_reviewed,:ll_reviewed_status);
		*/
		insert into ctx_acp_template(ctx_acp_template_id,category,template_name,export_id,
						wf_id,description,reviewed_by,date_reviewed,reviewed_status, doctype)
 		     values(:ll_new_template_id,:ll_category,:ls_template_name,:li_export_id,:li_wf_id,
				  	   :ls_description,:ls_reviewed_by,:ldt_date_reviewed,:ll_reviewed_status,'doc');
		//-------------End Modified ----------------------------------------------				  
		insert into ctx_acp_template_clause(ctx_acp_template_id,ctx_acp_clause_id,orders) 
			  select :ll_new_template_id,ctx_acp_clause_id,orders
			  	 from ctx_acp_template_clause
				where ctx_acp_template_id = :ll_template_id;	
		
		//Copy the dynamic add formulas -- jervis 09.19.2010
		INSERT INTO ctx_acp_template_clause_rules
           (ctx_acp_template_id
           ,ctx_acp_clause_id
           ,rule_row_id
           ,rule_name
           ,screen_id
           ,left_bracket
           ,field_name
           ,field_label
           ,operator
           ,value
           ,right_bracket
           ,logical
           ,field_type
           ,table_name
           ,value_display
           ,lookup_code
           ,lookup_flag
           ,data_view_id
           ,used_master_ctx)
		select :ll_new_template_id
			  ,ctx_acp_clause_id
           ,rule_row_id
           ,rule_name
           ,screen_id
           ,left_bracket
           ,field_name
           ,field_label
           ,operator
           ,value
           ,right_bracket
           ,logical
           ,field_type
           ,table_name
           ,value_display
           ,lookup_code
           ,lookup_flag
           ,data_view_id
           ,used_master_ctx
		from ctx_acp_template_clause_rules
		where ctx_acp_template_id = :ll_template_id;
		
		//w_agreement_template_painter.of_put_template_file(ll_new_template_id,ldt_new_lastupdate) //commented by alfee 07.23.2007
		gnv_appeondb.of_commitqueue()	//for web performance tuning
	
	   if SQLCA.Sqlcode <> 0 then	
			//messagebox("Template Properties","Template properties update faild!") 
			messagebox("Template Properties","Failed to update template properties!") 
			return -1
		end if					
		
		w_agreement_template_painter.of_put_template_file(ll_new_template_id,ldt_new_lastupdate) //moved here by alfee 07.23.2007
		
 	   dw_1.setitem(ll_row,"ctx_acp_template_id",ll_new_template_id)
end choose

return 1
		
		

end event

event closequery;//override
dw_1.accepttext() //09.03.2007
If ib_need_update and not ib_disableclosequery Then
	//--------Begin Modified by Alfee 09.03.2007------------------------
	/*if messagebox("Template Properties","The information has been changed, close without saving changes?", &
					Exclamation!,YesNo!,2) =  1 then
		return 0
	else
		return 1
	end if*/
	Integer li_return
	li_return = Messagebox( "IntelliSoftGroup", "Do you want to save changes?",exclamation!,YesNoCancel!,1 )	
	Choose Case li_return
	Case 1
		cb_ok.Post Event clicked()
		Return 1
	Case 3
		Return 1
	End Choose
	//--------End Modified -----------------------------------------------
End if

Return 0
end event

event close;call super::close;destroy inv_right
end event

type cb_cancel from commandbutton within w_agreement_template_properties
integer x = 1504
integer y = 1372
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
boolean cancel = true
end type

event clicked;closewithreturn(parent,"-1")
end event

type cb_ok from commandbutton within w_agreement_template_properties
integer x = 1161
integer y = 1372
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;long ll_template_id


if parent.event pfc_save() = 1 then
	ib_disableclosequery = true
	
	//dw_1.accepttext() //marked by alfee 08.31.2007
	ll_template_id = dw_1.getitemnumber(dw_1.getrow(), "ctx_acp_template_id")
   if isnull(ll_template_id) or not ll_template_id > 0 then ll_template_id = -1
	
	closewithreturn(parent,string(ll_template_id))
//	if isvalid(w_agreement_template_painter) then
//		w_agreement_template_painter.tab_1.tabpage_1.cb_go.post event clicked()
//	end if		
end if

end event

type dw_1 from u_dw_contract within w_agreement_template_properties
event ue_inidddws ( )
integer x = 41
integer y = 40
integer width = 1801
integer height = 1284
integer taborder = 10
string dataobject = "d_agreement_template_properties"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event ue_inidddws();datawindowchild dwc_export,dwc_workflow,dwc_reviewby

this.GetChild ("export_id", dwc_export)
this.GetChild ("wf_id", dwc_workflow)
this.GetChild ("reviewed_by", dwc_reviewby)

dwc_export.settransobject(sqlca)
dwc_workflow.settransobject(sqlca)
dwc_reviewby.settransobject(sqlca)

//for web performance
gnv_appeondb.of_startqueue() 
	dwc_export.retrieve()
	dwc_workflow.retrieve('04')
	dwc_reviewby.retrieve()	
gnv_appeondb.of_commitqueue()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.27.2007 By: Jervis
//$<reason> Set Filter trigger by <> 104-New Buy Side Document
dwc_workflow.SetFilter("wf_triggered_by <> '104'")
dwc_workflow.Filter( )
//---------------------------- APPEON END ----------------------------

dwc_export.insertrow(1)
dwc_export.setitem(1,"export_name","")

dwc_workflow.insertrow(1)
dwc_workflow.setitem(1,"wf_name", "")

dwc_reviewby.insertrow(1)
dwc_reviewby.setitem(1,"user_id", "")
end event

event constructor;call super::constructor;this.of_setupdateable(false)

this.event ue_populatedddws()

this.of_setdropdowncalendar(true)

this.event ue_inidddws()


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04-04-2007 By: Ken.Guo
//$<reason> Filter category data when current user have no access right.
inv_right = Create n_cst_right
datawindowchild ldwc_category
dw_1.getchild('category',ldwc_category)
inv_right.of_filter_right( ldwc_category, 'code', 3)
//---------------------------- APPEON END ----------------------------
end event

event getfocus;//
end event

event losefocus;//

end event

event pfc_preupdate;//override
return success
end event

event pfc_update;//override
return 1
end event

event itemchanged;call super::itemchanged;Long ll_templateid, ll_approved, ll_cnt

ib_need_update = true

this.accepttext()
//If lower(dwo.name) = "reviewed_status" and not isnull(data) then
If lower(dwo.name) = "reviewed_status"then		
	if Long( data ) > 0 then
		this.setitem(row,'date_reviewed',today())
		this.setitem(row,'reviewed_by',gs_user_id)	
	end if
	
	/*----------Commented by Alfee 11.13.2007-------------------
	//----------Begin Modified by Alfee 08.31.2007--------------
	//<$Reason>Don't change the approved status if it used already
	If Lower(is_msg) <> "edit" Then return 0
		
	ll_templateid = This.GetItemNumber(getrow(), "ctx_acp_template_id")
	ll_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Template Review Status' and code = 'Approved'"))	
	If il_status_ori = ll_approved and (IsNull(data) or Long(data) <> ll_approved) Then
		Select count(*) Into :ll_cnt From ctx_am_document Where base_type = '1' and from_templete_id = :ll_templateid ;
		If ll_cnt > 0 Then 
			MessageBox("Alert Message","This field can't be changed until the template is removed from the affected file(s).")
			This.SetItem(getrow(), "reviewed_status", il_status_ori)			
			Return 1
		End If
	End If
	//-----------End Modified -------------------------------------
	-------------End Commented-------------------------------------*/
End If
end event

