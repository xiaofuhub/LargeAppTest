$PBExportHeader$w_email_painter.srw
$PBExportComments$Email Painter of work flow
forward
global type w_email_painter from w_response
end type
type cb_select from commandbutton within w_email_painter
end type
type ddlb_category from dropdownlistbox within w_email_painter
end type
type cb_del from commandbutton within w_email_painter
end type
type st_2 from statictext within w_email_painter
end type
type cb_close from commandbutton within w_email_painter
end type
type cb_properties from commandbutton within w_email_painter
end type
type cb_print from commandbutton within w_email_painter
end type
type cb_copy from commandbutton within w_email_painter
end type
type cb_new from commandbutton within w_email_painter
end type
type dw_email from u_dw within w_email_painter
end type
end forward

global type w_email_painter from w_response
string tag = "Email Painter"
integer width = 3570
integer height = 1848
string title = "Email Templates"
long backcolor = 33551856
string icon = "AppIcon!"
cb_select cb_select
ddlb_category ddlb_category
cb_del cb_del
st_2 st_2
cb_close cb_close
cb_properties cb_properties
cb_print cb_print
cb_copy cb_copy
cb_new cb_new
dw_email dw_email
end type
global w_email_painter w_email_painter

type variables
String is_Module,is_InitModule
String is_callby
end variables

forward prototypes
public function integer of_refresh (long al_email_id)
public function boolean of_is_used (long al_mailid, boolean ab_showmessage)
end prototypes

public function integer of_refresh (long al_email_id);Long ll_Email_id, ll_Row
/*
String ls_Email_Name
DatawindowChild ldw_child_email

dw_email_list.InsertRow(0)

dw_email_list.GetChild("email", ldw_child_email)
ldw_child_email.SetTransObject(Sqlca)
ldw_child_email.Retrieve()

ldw_child_email.SetFilter("")
ldw_child_email.Filter()

IF ldw_child_email.RowCount() < 1 THEN RETURN -1
*/
ll_Row = dw_email.Retrieve(ll_Email_id)
IF ll_Row < 1 THEN RETURN -1

IF al_Email_id <> 0 THEN
	ll_Email_id = al_Email_id
	ll_Row = dw_email.Find("email_id = " + String(ll_Email_id), 1, dw_email.RowCount())
	IF ll_Row > 0 THEN
		IF al_Email_id = 0 THEN ll_Row = 1
		dw_email.ScrollToRow(ll_Row)				//Added by WuZhiJun on 2007-05-24
		dw_email.SelectRow(0, False)
		dw_email.SelectRow(ll_Row, True)
		dw_email.SetRow(ll_Row)
	END IF
ELSE
	dw_email.ScrollToRow(1)							//Added by WuZhiJun on 2007-05-24
	dw_email.SelectRow(0, False)
	dw_email.SelectRow(1, True)
END IF

/*
ls_Email_Name = dw_email.GetItemString(1, "Email_Name")
dw_email_list.SetItem(1, "email", ls_Email_Name)
ll_Row = ldw_child_email.InsertRow(1)
ldw_child_email.SetItem(1, "email_id", -999)
ldw_child_email.SetItem(1, "email_name", "All")
ddlb_category.SelectItem(1)
*/

RETURN 0
end function

public function boolean of_is_used (long al_mailid, boolean ab_showmessage);// (Appeon)Eugene 06.17.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////
// Function: of_is_used()
// Arguments:
// 	value    long       al_mailid
// 	value    boolean    ab_showmessage
//--------------------------------------------------------------------
// Return:  boolean
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-07-20.
//--------------------------------------------------------------------
// Description: Check the email template whether using.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
String ls_wfname1, ls_wfname2
String ls_alm_column,ls_alm_column_template,ls_viewname
Long ll_ctxid
Long ll_alarmused

gnv_appeondb.of_startqueue( )
	select Top 1 wf_workflow.wf_name into :ls_wfname1 from wf_action_status,wf_workflow where wf_action_status.wf_id = wf_workflow.wf_id and (mail_notify = :al_mailid or mail_reminder = :al_mailid or mail_message = :al_mailid );
	select Top 1 wf_workflow.wf_name into :ls_wfname2 from wf_action_types,wf_workflow where wf_action_types.wf_id = wf_workflow.wf_id and mail_notify = :al_mailid;
	select Top 1 ctx_id,alm_column  into :ll_ctxid,:ls_alm_column  from CTX_NOTIFICATION where alm_email_template_id = :al_mailid;
	select Top 1 data_view.data_view_name, alm_column into :ls_viewname,:ls_alm_column_template from ctx_notification_templates,data_view Where ctx_notification_templates.view_id = data_view.data_view_id  and alm_email_template_id = :al_mailid;
	select count(*) into :ll_alarmused from icred_settings where group_email_template = :al_mailid; //(Appeon)Harry 12.20.2013 - V141 for BugH120602 of IntelliContract History Issues
gnv_appeondb.of_commitqueue( )

If Len(ls_wfname1) > 0 Then
	If ab_showmessage Then
		Messagebox('Error','Because this Email Template is used by Work Flow '+ls_wfname1+', it failed to delete this Email Template.'	)
	End If
	Return True
End If

If Len(ls_wfname2) > 0 Then
	If ab_showmessage Then
		Messagebox('Error','Because this Email Template is used by Work Flow '+ls_wfname2+', it failed to delete this Email Template.'	)
	End If
	Return True
End If

If Len(ls_alm_column) > 0 Then
	If ab_showmessage Then
		Messagebox('Error','Because this Email Template is used by Date Alarm with Contract #'+String(ll_ctxid)+ + ' ('+ls_alm_column+')' +', it failed to delete this Email Template.'	)
	End If
	Return True
End If

If Len(ls_alm_column_template) > 0 Then
	If ab_showmessage Then
		Messagebox('Error','Because this Email Template is used by Date Alarm Template with View '+ ls_viewname+ ' ('+ls_alm_column_template+').' +', it failed to delete this Email Template.'	)		
	End If
	Return True
End If
//(Appeon)Harry 12.20.2013 - V141 for BugH120602 of IntelliContract History Issues
if isnull(ll_alarmused) then ll_alarmused = 0
if ll_alarmused > 0 then
	If ab_showmessage Then
		Messagebox('Error','Because this Email Template is used by Group Email Alarm Template' +', it failed to delete this Email Template.'	)		
	End If
	Return True
end if

Return False
end function

on w_email_painter.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.ddlb_category=create ddlb_category
this.cb_del=create cb_del
this.st_2=create st_2
this.cb_close=create cb_close
this.cb_properties=create cb_properties
this.cb_print=create cb_print
this.cb_copy=create cb_copy
this.cb_new=create cb_new
this.dw_email=create dw_email
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.ddlb_category
this.Control[iCurrent+3]=this.cb_del
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_properties
this.Control[iCurrent+7]=this.cb_print
this.Control[iCurrent+8]=this.cb_copy
this.Control[iCurrent+9]=this.cb_new
this.Control[iCurrent+10]=this.dw_email
end on

on w_email_painter.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.ddlb_category)
destroy(this.cb_del)
destroy(this.st_2)
destroy(this.cb_close)
destroy(this.cb_properties)
destroy(this.cb_print)
destroy(this.cb_copy)
destroy(this.cb_new)
destroy(this.dw_email)
end on

event open;call super::open;String ls_parm

IF ISVALID(W_MDI) THEN 
	w_mdi.of_menu_security( w_mdi.MenuName )
END IF
dw_email.SetTransObject(Sqlca)

ddlb_category.SelectItem(1)
of_refresh(0)

ls_parm = message.stringparm

//Start Code Change ----06.13.2011 #V11 maha - moved code inside if statement
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-29 By: Scofield
//$<Reason> Hide or show the Select button

if IsNull(ls_parm) or (Trim(ls_parm) = '') then
	cb_select.Visible = false
else
	cb_select.Visible = true
	is_callby = MidA(ls_parm , 1 ,1)
	is_module = MidA(ls_parm , 2 )
	is_InitModule = is_module
end if
//---------------------------- APPEON END ----------------------------


//is_callby = MidA(ls_parm , 1 ,1)
//is_module = MidA(ls_parm , 2 )
//is_InitModule = is_module				//Added by Scofield on 2008-03-12: save the init module value
//Start Code Change ----06.13.2011

If is_callby = 'Y' Then
	cb_select.visible = true
	ddlb_category.selectitem( long(is_module) + 1)
	dw_email.SetFilter("module = '" + is_module + "'")
	dw_email.filter()
End If

//Start Code Change ----06.07.2010 #V10 maha
if gi_user_readonly = 1 then
	dw_email.enabled = false
	cb_copy.enabled = false
	cb_properties.enabled = false
	cb_new.enabled = false
	cb_del.enabled = false
end if
//End Code Change---06.07.2010

end event

type cb_select from commandbutton within w_email_painter
integer x = 1513
integer y = 48
integer width = 279
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
end type

event clicked;long	ll_email_id

If not dw_email.Getrow( ) > 0 Then return

if ddlb_category.Text <> ddlb_category.Text(long(is_InitModule) + 1) then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please select " + ddlb_category.Text(long(is_InitModule) + 1) + " Module.")
	return
end if

ll_email_id = dw_email.getitemnumber( dw_email.getrow(), 'email_id')

CloseWithreturn(Parent , ll_email_id)

end event

type ddlb_category from dropdownlistbox within w_email_painter
integer x = 256
integer y = 56
integer width = 1079
integer height = 452
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"All","IntelliCred","IntelliApp","IntelliContract->Parent Level","IntelliContract->Document Manager","Group Email Alarm"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;

choose case lower(text(index))
	case "all"
		is_Module ="00"
	case "intellicred"
		is_Module = "01" 
	case "intelliapp"
		is_Module = "02" 
	case "intellicontract->parent level"
		is_Module = "03" 
	case "intellicontract->document manager"
		is_Module = "04" 
	case 'group email alarm' //(Appeon)Eugene 06.17.2013 - V141 ISG-CLX
		is_Module = "05" 
end choose

if is_Module <> "00" then
	dw_email.SetFilter("module = '" + is_Module + "'")
else
	dw_email.SetFilter("")
end if

dw_email.Filter()

IF dw_email.RowCount() > 0 THEN
	dw_email.SelectRow(0, False)
	dw_email.SelectRow(1, True)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007.08.13 By: Frank.Gui
	//$<reason> 
	cb_print.Enabled = True
	cb_del.Enabled = True
	cb_copy.Enabled = True
	cb_properties.Enabled = True
	//---------------------------- APPEON END ----------------------------
END IF

end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 15/05/2007 By: Jervis
//$<reason> 
/*
if gb_contract_version then
	ddlb_category.Reset()
	ddlb_category.Additem("All")
	ddlb_category.Additem("IntelliContract->Parent Level")
	ddlb_category.Additem("IntelliContract->Document Manager")
end if
*/
integer li_product
integer li_contract_set
li_product = of_get_app_setting('set_9', 'I')
li_contract_set = of_get_app_setting('set_cont', 'I')

ddlb_category.Reset()
ddlb_category.Additem("All")

choose case li_product
	case 0
		ddlb_category.Additem("IntelliCred")
		if li_contract_set = 1 then
			ddlb_category.Additem("IntelliContract->Parent Level")
			ddlb_category.Additem("IntelliContract->Document Manager")
			ddlb_category.Additem("Group Email Alarm")    //(Appeon)Harry 11.18.2013 - V141 ISG-CLX  for BugH111201
		else
			ddlb_category.Deleteitem(1)
			is_Module = "01"
		end if
	case 1	
		ddlb_category.Additem("IntelliApp")
		if li_contract_set = 1 then
			ddlb_category.Additem("IntelliContract->Parent Level")
			ddlb_category.Additem("IntelliContract->Document Manager")
			ddlb_category.Additem("Group Email Alarm")    //(Appeon)Harry 11.18.2013 - V141 ISG-CLX  for BugH111201
		else
			ddlb_category.Deleteitem(1)
			is_Module = "02"
		end if
	case 2,3  //Start Code Change ----06.13.2011 #V11 maha - at this date there are no user versions with type 2 or 3
		ddlb_category.Additem("IntelliCred")
		ddlb_category.Additem("IntelliApp")
		if li_contract_set = 1 then
			ddlb_category.Additem("IntelliContract->Parent Level")
			ddlb_category.Additem("IntelliContract->Document Manager")
			ddlb_category.Additem("Group Email Alarm")    //(Appeon)Harry 11.18.2013 - V141 ISG-CLX  for BugH111201
		end if
	case 4 //IntelliContract
		ddlb_category.Additem("IntelliContract->Parent Level")
		ddlb_category.Additem("IntelliContract->Document Manager")
		ddlb_category.Additem("Group Email Alarm")   //(Appeon)Eugene 07.09.2013 - V141 ISG-CLX
	case 5			//Start Code Change ----06.13.2011 #V11 maha - added 5 for sk
		ddlb_category.Additem("IntelliApp")
		is_Module = "02"
		ddlb_category.Deleteitem(1)
end choose

//---------------------------- APPEON END ----------------------------

end event

type cb_del from commandbutton within w_email_painter
integer x = 2418
integer y = 48
integer width = 279
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Delete"
end type

event clicked;IF dw_email.RowCount() < 1 THEN RETURN

int  li_Row,li_Rtn

//---------Begin Modified by (Appeon)Eugene 06.17.2013 for V141 ISG-CLX--------
li_Row = dw_email.getrow()

//Added By Ken.Guo 2011-07-20. 
Long ll_emailid
ll_emailid = dw_email.getitemnumber(li_row, 'email_id')
If Parent.of_is_used( ll_emailid, True) Then Return
//---------End Modfiied ------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modified> 2007-05-24 By: Wu ZhiJun
//$<reason> Fix a bug
li_Rtn = MessageBox('Confirm EMail Delete','Are you sure you want to delete this EMail?',Question!,YesNo!)
if li_Rtn <> 1 then return
//--------------------------- APPEON END -----------------------------

//li_Row = dw_email.getrow()  //Commented by (Appeon)Eugene 06.17.2013 - V141 ISG-CLX

IF dw_email.event pfc_deleterow() < 0 THEN return
IF parent.event pfc_save() < 1 THEN
	
	of_refresh(0)
	dw_email.scrolltorow( li_row)
ELSE
	IF li_Row > dw_email.rowcount() THEN
		li_Row = dw_email.rowcount()
	END IF
	dw_email.scrolltorow( li_row)
END IF

end event

type st_2 from statictext within w_email_painter
integer x = 50
integer y = 68
integer width = 215
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Module"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_email_painter
integer x = 3269
integer y = 48
integer width = 279
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.02.2007 By: Jack 
//$<reason> Fix a defect.
/*
Closewithreturn(Parent , 0)
*/
Closewithreturn(w_email_painter , 0)
//---------------------------- APPEON END ----------------------------

end event

type cb_properties from commandbutton within w_email_painter
integer x = 2702
integer y = 48
integer width = 279
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "P&roperties"
end type

event clicked;Long ll_Row, ll_Email_ID
IF dw_email.RowCount() < 1 THEN RETURN

ll_Row = dw_email.GetRow()
ll_Email_ID = dw_email.GetItemNumber(ll_Row, "Email_ID")
OpenWithParm(w_email_add, "Edit:" + String(ll_Email_ID))

ll_Email_ID = Message.DoubleParm
If ll_Email_Id = 0 then return 

of_refresh(ll_Email_ID)
end event

type cb_print from commandbutton within w_email_painter
integer x = 2985
integer y = 48
integer width = 279
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Print"
end type

event clicked;datastore lds_data
lds_data = Create DataStore
lds_data.dataobject = "d_email_report"
lds_data.SetTransObject(Sqlca)

IF lds_data.Retrieve() > 0 THEN
//	lds_data.object.datawindow.Print.FileName = "temp"
	lds_data.object.datawindow.Print.Orientation = "1"//<0 - default, 1 - Landscape, 2 - Portrait>
	lds_data.Print()
//	lds_data.object.datawindow.Print.FileName = ""
END IF

destroy lds_data
end event

type cb_copy from commandbutton within w_email_painter
integer x = 2135
integer y = 48
integer width = 279
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "C&opy"
end type

event clicked;Long   ll_Row, ll_Email_id, ll_Max_ID
String ls_Subject, ls_Module, ls_Msg
String ls_Email_Name, ls_Attach_Name

ll_Row = dw_email.RowCount()
IF ll_Row < 1 THEN RETURN
ll_Row = dw_email.GetRow()
ll_Email_id = dw_email.GetItemNumber(ll_Row, "Email_id")

OpenWithParm(w_email_add, "Copy:"+String(ll_Email_id))

ll_Email_ID = Message.DoubleParm
If ll_Email_Id = 0 then return 

If is_callby = 'Y' Then
	Closewithreturn(parent , ll_email_id)
Else
	of_refresh(ll_Email_ID)
End If

end event

type cb_new from commandbutton within w_email_painter
integer x = 1851
integer y = 48
integer width = 279
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;OpenWithParm(w_email_add, "Add:"+is_Module)

Long ll_Email_ID
String ls_email_name, ls_Module, ls_email

ll_Email_ID = Message.DoubleParm

If ll_Email_Id = 0 then return 

If is_callby = 'Y' Then
	Closewithreturn(parent , ll_email_id)
Else
	of_refresh(ll_Email_ID)
End If

end event

type dw_email from u_dw within w_email_painter
integer y = 180
integer width = 3552
integer height = 1584
integer taborder = 80
string title = "none"
string dataobject = "d_email_view"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;IF currentrow < 1 THEN
	cb_print.Enabled = False
	cb_del.Enabled = False
	cb_copy.Enabled = False
	cb_properties.Enabled = False
ELSE
	cb_print.Enabled = True
	cb_del.Enabled = True
	cb_copy.Enabled = True
	cb_properties.Enabled = True
END IF

IF CurrentRow < 1 THEN RETURN

SelectRow(0, False)
SelectRow(CurrentRow, True)


end event

event doubleclicked;call super::doubleclicked;IF Row < 1 THEN RETURN

cb_properties.Event Clicked()
end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-08-29 By: Scofield
//$<Reason> When there is only one row,can select it also

if (row = 1) and (This.RowCount()) > 0 then
	This.Trigger Event RowFocusChanged(row)
end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_deleterow;// (Appeon)Eugene 06.17.2013 - V141 ISG-CLX
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-02-20 By: Scofield
//$<Reason> Delete email attachment.

long	ll_Row,ll_EmailID

ll_Row = This.GetRow()
if ll_Row > 0 and ll_Row <= This.RowCount() then
	ll_EmailID = This.GetItemNumber(ll_Row,"Email_id")
	
	DELETE FROM wf_email_attachment WHERE email_id = :ll_EmailID;
end if

Return Super::Event pfc_deleterow()

//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;// (Appeon)Eugene 06.17.2013 - V141 ISG-CLX
//sorts when the user clicks on a column header -- jervis 03.03.2011
this.of_SetSort( true)
this.inv_sort.of_SetColumnHeader(true)
end event

