$PBExportHeader$u_tabpg_cntct_details.sru
$PBExportComments$[intellicontract_tab]  The contract locations Tab Page
forward
global type u_tabpg_cntct_details from u_tabpg
end type
type dw_contact_master from u_dw_contract within u_tabpg_cntct_details
end type
type dw_facility_detail from u_dw_contract within u_tabpg_cntct_details
end type
type cb_save from u_cb within u_tabpg_cntct_details
end type
type dw_master from u_dw_contract within u_tabpg_cntct_details
end type
type cb_save_select from u_cb within u_tabpg_cntct_details
end type
type cb_phone_delete from u_cb within u_tabpg_cntct_details
end type
type cb_1 from u_cb within u_tabpg_cntct_details
end type
type cb_phone_insert from u_cb within u_tabpg_cntct_details
end type
type cb_udf_ins from u_cb within u_tabpg_cntct_details
end type
type cb_udf_del from u_cb within u_tabpg_cntct_details
end type
type cb_delete from u_cb within u_tabpg_cntct_details
end type
type dw_1 from u_dw_contract within u_tabpg_cntct_details
end type
end forward

global type u_tabpg_cntct_details from u_tabpg
integer width = 3899
integer height = 1940
long backcolor = 33551856
boolean ib_alwaysvalidate = true
event ue_new ( )
dw_contact_master dw_contact_master
dw_facility_detail dw_facility_detail
cb_save cb_save
dw_master dw_master
cb_save_select cb_save_select
cb_phone_delete cb_phone_delete
cb_1 cb_1
cb_phone_insert cb_phone_insert
cb_udf_ins cb_udf_ins
cb_udf_del cb_udf_del
cb_delete cb_delete
dw_1 dw_1
end type
global u_tabpg_cntct_details u_tabpg_cntct_details

type variables
tab a_parent_tab
n_cst_dwsrv invo_cst_dwsrv
long ll_app_facility // then id of the parent facility pass directly from the window
boolean ib_first_time = true
boolean ib_show_button = true
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.08.2007 By: Jack 
//$<reason> Fix a defect.
integer il_row
//---------------------------- APPEON END ----------------------------

//app_facility

str_pass istr_pass

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.29.2006 By: Liang QingShi
//$<reason> Perofrmance tuning
//$<modification> Define a variable to be used in subsequent script.

integer ii_save = 0
boolean ib_new = False
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-27 By: Wu ZhiJun
//$<reason> Current datawindow
integer			ii_CurrentDw = 2				// 1 dw_facility_detail      2 dw_master     3 dw_1    4 dw_2
Boolean			ib_IsValid = false
u_dw_contract	dw_2
//--------------------------- APPEON END -----------------------------


end variables

forward prototypes
public function long of_get_next_sequence_number ()
public function integer of_getcurrentdw ()
end prototypes

event ue_new();/******************************************************************************************************************
**  [PUBLIC]   : event ue_new()
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

dw_1.reset( )
dw_master.reset( )

dw_1.event pfc_insertrow( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-03-08 By: Wu ZhiJun
//$<reason> Insert into the dw_1 two rows every times add 
dw_1.event pfc_insertrow( )

long ll_Phone,ll_Email

ll_Phone = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Contact VIA' and code = 'PHONE'"))
ll_Email = long(gnv_data.of_getitem( "code_lookup", "lookup_code","lookup_name = 'Contract Contact VIA' and code = 'EMAIL'"))

dw_1.SetItem(1,'via',ll_Phone)  //Set to PHONE
dw_1.SetItem(2,'via',ll_Email)	//Set to EMAIL
dw_1.SetItemStatus(1,0,Primary!,New!)
dw_1.SetItemStatus(2,0,Primary!,New!)
//--------------------------- APPEON END -----------------------------


//dw_2.event pfc_insertrow( )
dw_master.event pfc_insertrow( )

dw_master.setfocus( )
dw_master.setcolumn( 'first_name')

this.enabled = true
end event

public function long of_get_next_sequence_number ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_next_sequence_number
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_seq_no

select max(contact_id)
into :ll_seq_no
from  ctx_contacts
using sqlca;

if not f_validstr(string(ll_seq_no)) then
	ll_seq_no  = 1
else
	ll_seq_no =  ll_seq_no + 1
end if 

a_parent_tab.function dynamic of_set_contact_id(ll_seq_no)

return ll_seq_no
end function

public function integer of_getcurrentdw ();Return ii_CurrentDw
end function

on u_tabpg_cntct_details.create
int iCurrent
call super::create
this.dw_contact_master=create dw_contact_master
this.dw_facility_detail=create dw_facility_detail
this.cb_save=create cb_save
this.dw_master=create dw_master
this.cb_save_select=create cb_save_select
this.cb_phone_delete=create cb_phone_delete
this.cb_1=create cb_1
this.cb_phone_insert=create cb_phone_insert
this.cb_udf_ins=create cb_udf_ins
this.cb_udf_del=create cb_udf_del
this.cb_delete=create cb_delete
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_contact_master
this.Control[iCurrent+2]=this.dw_facility_detail
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.dw_master
this.Control[iCurrent+5]=this.cb_save_select
this.Control[iCurrent+6]=this.cb_phone_delete
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_phone_insert
this.Control[iCurrent+9]=this.cb_udf_ins
this.Control[iCurrent+10]=this.cb_udf_del
this.Control[iCurrent+11]=this.cb_delete
this.Control[iCurrent+12]=this.dw_1
end on

on u_tabpg_cntct_details.destroy
call super::destroy
destroy(this.dw_contact_master)
destroy(this.dw_facility_detail)
destroy(this.cb_save)
destroy(this.dw_master)
destroy(this.cb_save_select)
destroy(this.cb_phone_delete)
destroy(this.cb_1)
destroy(this.cb_phone_insert)
destroy(this.cb_udf_ins)
destroy(this.cb_udf_del)
destroy(this.cb_delete)
destroy(this.dw_1)
end on

event constructor;// override
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.22.2006 By: LeiWei
//$<reason> Performance tuning.
//$<modification> Add a condition to ensure that constructor will not be executed, since
//$<modification> the execution of inv_resize negatively affects the performance very much

If appeongetclienttype() = 'WEB' Then
	this.of_getparentwindow( iw_parent)
	i_parent_tab = this.GetParent( )
Else
	CALL super::constructor
End If
//---------------------------- APPEON END ----------------------------

a_parent_tab = GetParent()

boolean ib_show_address_button = true

invo_cst_dwsrv = create n_cst_dwsrv

powerobject lpo[]
lpo[1] = dw_master
lpo[2] = dw_1

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-28 By: Wu ZhiJun
//$<reason> Set dw_facility_detail is update enable
lpo[3] = dw_facility_detail
//--------------------------- APPEON END -----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-04-02 By: Wu ZhiJun
//$<reason> Fix a Bug
if IsValid(w_contract_contact.tab_1.tabpage_custom) then
	dw_2 = w_contract_contact.tab_1.tabpage_custom.dw_2
	dw_master.ShareData(dw_2)
end if
//--------------------------- APPEON END -----------------------------

this.of_setupdateobjects(lpo)

ib_IsValid = true

end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(invo_cst_dwsrv) then Destroy invo_cst_dwsrv
//---------------------------- APPEON END ----------------------------
end event

type dw_contact_master from u_dw_contract within u_tabpg_cntct_details
event ue_populatedddws ( )
string tag = "Contact Information List"
integer x = 1467
integer y = 16
integer width = 2409
integer height = 672
integer taborder = 80
boolean titlebar = true
string title = "Contact Information List"
string dataobject = "d_cntx_list"
boolean hscrollbar = true
boolean livescroll = false
end type

event ue_populatedddws;long 		ll_Column_Count , ll_i
String 	ls_dddw_name
String 	ls_colname
String 	ls_coltag
Long	li_value
Long	ll_lookup_code

DataWindowChild dwchild
n_ds lnds_user

ll_Column_Count = long(This.Describe("DataWindow.Column.Count"))
IF ll_Column_Count = 0 THEN RETURN

FOR ll_i = 1 TO ll_Column_Count
	IF Describe("#" +String(ll_i) + ".Edit.Style") = 'dddw' then
		ls_colname = Describe("#" +String(ll_i) + ".Name")
		ls_dddw_name = lower(Describe("#" +String(ll_i) + ".DDDW.Name"))

		IF ls_dddw_name = "d_dddw_code_lookup" THEN
			ls_coltag = Lower(Describe("#" +String(ll_i) + ".TAG"))
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
				
			IF li_value <> 1 THEN
				gnv_app.of_setcontraccache_code_lookup( ls_coltag )
				li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
			END IF
		ELSE
			li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user)
		END IF

		IF li_value = 1 THEN
			getchild( ls_colname, dwchild)
			lnds_user.ShareData ( dwchild )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03.27.2007 By: Jack 
			//$<reason> Fix a defect.
			long ll_find
			String ls_displaycolumn
			ls_displaycolumn = This.Describe(ls_colname + ".dddw.displaycolumn")
			ll_find = dwchild.find(ls_displaycolumn + " = '(NONE)'",1,dwchild.rowcount())
			If ll_find > 0 Then
				dwchild.setitem(ll_find,ls_displaycolumn,'')
			End If
			//---------------------------- APPEON END ----------------------------
		END IF
	END IF
NEXT

return

end event

event rowfocuschanged;call super::rowfocuschanged;if CurrentRow > 0 then
	this.SelectRow(0,false)
	this.SelectRow(CurrentRow,true)
end if

dw_master.Event pfc_Retrieve()
dw_1.Event pfc_Retrieve()

////Readonly process -- jervis 11.25.2010
//if currentrow > 0 then
//	if this.GetItemString( currentrow,'Access') = 'R' then
//		dw_master.Modify( "datawindow.readonly = Yes")
//		dw_1.Modify( "datawindow.readonly = Yes")
//	else
//		dw_master.Modify( "datawindow.readonly = No")
//		dw_1.Modify( "datawindow.readonly = No")
//	end if
//end if
end event

event pfc_retrieve;call super::pfc_retrieve;Long	ll_Company
long	ll_Row

ll_Row = dw_facility_detail.GetRow()

if ll_Row > 0 then
	ll_Company = dw_facility_detail.GetItemNumber(ll_Row,"facility_id")
	this.retrieve(ll_Company) 
end if

return success

end event

event retrieveend;call super::retrieveend;//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//Integer	li_contact_id,li_Cycle,li_Count,li_Value
long	li_contact_id,li_Cycle,li_Count,li_Value	//long.zhang 12.16.2013
//---------End Modfiied ------------------------------------------------------
long		ll_Row
Boolean 	lb_Flag
Boolean 	lb_IsFind = false

if RowCount <= 0 then
	dw_master.Reset()
	dw_1.Reset()
	return
end if

lb_Flag = a_parent_tab.FUNCTION DYNAMIC of_GetFlag()

if lb_Flag then
	li_contact_id = a_parent_tab.FUNCTION DYNAMIC of_Get_contact_id()
	
	li_Count = This.RowCount()
	
	for li_Cycle = 1 to li_Count
		li_Value = this.GetItemNumber(li_Cycle,'contact_id')
		if li_Value = li_contact_id then
			This.ScrollToRow(li_Cycle)
			This.SetRow(li_Cycle)
			This.SelectRow(0,false)
			This.SelectRow(li_Cycle,true)
			lb_IsFind = true
			exit
		end if
	next
	if lb_IsFind = false and li_Count > 0 then
		This.SetRow(1)
		This.SelectRow(0,false)
		This.SelectRow(1,true)
	end if
else
	if This.RowCount() > 0 then
		This.SetRow(1)
		This.SelectRow(0,false)
		This.SelectRow(1,true)
	end if
end if

ll_Row = This.GetRow()
if ll_Row > 0 then
	This.Event RowFocusChanged(ll_Row)
end if

end event

event getfocus;call super::getfocus;//Added By Mark Lee 03/22/2013
//this.title = ' >>>>>>>>>> ' + this.tag + ' <<<<<<<<<<< '
this.title = gs_left_title_sign + this.tag + gs_right_title_sign

ii_CurrentDw = 2
end event

event losefocus;call super::losefocus;this.title = this.tag
end event

event constructor;call super::constructor;this.event ue_populatedddws( )
This.of_setupdateable(false)

end event

event rowfocuschanging;call super::rowfocuschanging;long		ll_Cycle,ll_Count,ll_Row
Integer	li_Rtn
Boolean	lb_ModiFlag = false
Boolean	lb_ReFlag = false
String	ls_FirstName,ls_LastName

DWItemStatus	ldw_Status

dw_Master.AcceptText()
dw_1.AcceptText()

//Check the dw_1 if had modified
ll_Count = dw_1.RowCount()

for ll_Cycle = 1 to ll_Count
	ldw_Status = dw_1.GetItemStatus(ll_Cycle,0,Primary!)
	if ldw_Status = newmodified! or ldw_Status = datamodified! then
		lb_ModiFlag = true
		exit
	end if
next

if Not lb_ModiFlag then
	//Check the dw_Master if had modified
	ll_Count = dw_Master.RowCount()
	
	for ll_Cycle = 1 to ll_Count
		ldw_Status = dw_Master.GetItemStatus(ll_Cycle,0,Primary!)
		if ldw_Status = newmodified! or ldw_Status = datamodified! then
			lb_ModiFlag = true
			lb_ReFlag = true
			exit
		end if
	next
end if

if lb_ModiFlag then
	ll_Row = dw_master.GetRow()
	if ll_Row > 0 then
		ls_FirstName = dw_master.GetItemString(ll_Row,'first_name')
		if IsNull(ls_FirstName) or Trim(ls_FirstName) = '' then
			MessageBox('Information','First Name is required.')
			dw_master.SetColumn('first_name')
			dw_master.SetFocus()
			return 1
		end if
		
		ls_LastName = dw_master.GetItemString(ll_Row,'last_name')
		if IsNull(ls_LastName) or Trim(ls_LastName) = '' then
			MessageBox('Information','Last Name is required.')
			dw_master.SetColumn('last_name')
			dw_master.SetFocus()
			return 1
		end if
	end if
	
	li_Rtn = MessageBox (gnv_app.iapp_object.DisplayName,"Do you want to save changes?", exclamation!, YesNoCancel!,1)
	if li_Rtn = 1 then
		if IsValid(iw_parent) then
			if iw_parent.Dynamic Event pfc_save() < 0 then
				return 1
			end if
			if lb_ReFlag then
				dw_contact_master.Event pfc_Retrieve()
			end if
		end if
	elseif li_Rtn = 3 then
		return 1
	end if
end if

end event

event clicked;call super::clicked;long	ll_Contactid

if row > 0 then
	ll_Contactid = This.GetItemNumber(row,"contact_id")
	a_parent_tab.function dynamic of_set_contact_id(ll_Contactid)
end if

end event

event other;call super::other;//Commented By mark 03/22/12
////------------------------------------------------------------- 
//// Check to see if the title bar for this datawindow has been 
//// clicked and prevent it
////-------------------------------------------------------------
//If Message.WordParm = 61458 Then 
//		Message.Processed = True
//		Message.ReturnValue = 0 
//End If
end event

event pfc_addrow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_add.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event pfc_deleterow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_delete.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow,ll_Right
String		ls_editstyle
String		ls_val
String		ls_protect
String		ls_colname
String		ls_currcolname
String		ls_type
String		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(6930)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
If ls_type = "ole" Or ls_type = "tableblob" Or ls_type = "graph" Then Return 1

// No RMB support for print preview mode
If This.Object.DataWindow.Print.Preview = "yes" Then Return 1

// Determine parent window for PointerX, PointerY offset
This.of_GetParentWindow (lw_parent)
If IsValid (lw_parent) Then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	Do While IsValid (lw_frame)
		If lw_frame.WindowType = MDI! Or lw_frame.WindowType = MDIHelp! Then
			lb_frame = True
			Exit
		Else
			lw_frame = lw_frame.ParentWindow()
		End If
	Loop
	
	If lb_frame Then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		If lw_parent.WindowType = Child! Then
			lw_parent = lw_frame
		Else
			lw_sheet = lw_frame.GetFirstSheet()
			If IsValid (lw_sheet) Then
				Do
					// Use frame reference for popup menu if the parentwindow is a sheet
					If lw_sheet = lw_parent Then
						lw_parent = lw_frame
						Exit
					End If
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				Loop Until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
			End If
		End If
	Else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		If lw_parent.WindowType = Child! Then
			lw_childparent = lw_parent.ParentWindow()
			If IsValid (lw_childparent) Then
				lw_parent = lw_childparent
			End If
		End If
	End If
Else
	Return 1
End If

// Create popup menu
lm_dw = Create m_dw
lm_dw.of_SetParent (This)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = This.GetRow()

ls_val = This.Object.DataWindow.Readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

Choose Case ls_type
	Case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"
	
	// Row operations based on readonly status
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', Not lb_readonly)
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', lb_desired)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', lb_desired)
	End If
	
Case Else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', False)
End Choose

// Get column properties
ls_currcolname = This.GetColumnName()
If ls_type = "column" Then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	If Not IsNumber(ls_protect) Then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = This.Describe(ls_expression)
	End If
	ls_val = dwo.TabSequence
	If IsNumber (ls_val) Then
		li_tabsequence = Integer (ls_val)
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', False)

// Get the column/editystyle specific editable flag.
If ls_type = "column" And Not lb_readonly Then
	Choose Case ls_editstyle
		Case "edit"
			ls_val = dwo.Edit.DisplayOnly
		Case "editmask"
			ls_val = dwo.EditMask.Readonly
		Case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		Case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		Case Else
			ls_val = ""
	End Choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	If IsNull(lb_editstyleattrib) Then lb_editstyleattrib = False
End If

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', True)
		Else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', False)
lm_dw.m_table.m_values.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', False)
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
	End If
End If

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-18 By: Scofield
//$<Reason> Don't display the mailaspdf and saveaspdf menu item
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

type dw_facility_detail from u_dw_contract within u_tabpg_cntct_details
event ue_save ( )
string tag = "Company Information"
integer x = 9
integer y = 16
integer width = 1435
integer height = 1900
integer taborder = 70
boolean titlebar = true
string title = "Company Information"
string dataobject = "d_facility_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_save();Long 		li_next_id
Integer	li_Rtn

dw_facility_detail.AcceptText()

if Not f_validstr(STRING(this.object.facility_id[this.getrow()])) then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.17.2007 By: Jack
	//$<reason> 
	/*
	SELECT Max( facility_id )
	  INTO :li_next_id
	  FROM app_facility;
	*/
	li_next_id = gnv_app.of_get_id("facility_id")
	//---------------------------- APPEON END ----------------------------
	//---------Begin Modified by (Appeon)Harry 10.30.2015 for Bug id 4811--------
	/*
	IF IsNull(li_next_id) then li_next_id = 0
	li_next_id ++
	*/
	//---------End Modfiied ------------------------------------------------------
	This.SetItem(1,"facility_id", li_next_id )
end if

li_Rtn = This.Update()

if li_Rtn = 1 then
	COMMIT USING SQLCA;
else
	MessageBox('Warning','DataWindow Save failed!',Exclamation!)
	ROLLBACK USING SQLCA;
end if

end event

event itemchanged;call super::itemchanged;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 03.29.2006 By: Liang QingShi
//$<reason> Perofrmance tuning.
//$<modification> Set ii_save to 1 to denote that the status of w_contract_contact has been changed.
//$<modification> Refer to PT-01/03 for more information.
ii_save = 1
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-11-01 By: Scofield
//$<Reason> Display or hide the DefaultTo column

if dwo.name = 'contact_type2' then
	if data = 'B' then
		dw_master.Modify("DefaultTo.Visible='1'")
		dw_master.Modify("t_defaultto.Visible='1'")
		
		dw_master.Modify("user_d_t.Visible='0'")
		dw_master.Modify("user_d.Visible='0'")
	else
		dw_master.Modify("DefaultTo.Visible='0'")
		dw_master.Modify("t_defaultto.Visible='0'")
		
		dw_master.Modify("user_d_t.Visible='1'")
		dw_master.Modify("user_d.Visible='1'")
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_retrieve;call super::pfc_retrieve;Long		ll_Company
Integer	li_Rtn

DataWindowChild	ldw_1

ll_Company = a_parent_tab.Function Dynamic of_Get_facility_id()
this.retrieve(ll_Company)

li_Rtn = This.GetChild("corp_office_link",ldw_1)

if li_Rtn = 1 then
	ldw_1.SetTransObject(SQLCA)
	ldw_1.Retrieve( )
	ldw_1.InsertRow(1) //(Appeon)Harry 02.25.2014 - for Remove the corp office link
end if

return success

end event

event pfc_validation;call super::pfc_validation;if Not f_validstr(this.object.facility_name[getrow()]) then
	Messagebox('Warning', 'Organization Name is a required column' )
	Setcolumn('facility_name' )
	return failure
end if 

return success

end event

event pfc_preupdate;call super::pfc_preupdate;Long li_next_id

if Not f_validstr(STRING(this.object.facility_id[this.getrow()])) then
	SELECT Max( facility_id )
	  INTO :li_next_id
	  FROM app_facility;
	
	IF IsNull(li_next_id) then li_next_id = 0
	li_next_id ++
	
	dw_facility_detail.SetItem( 1, "facility_id", li_next_id )
	a_parent_tab.function dynamic of_set_facility_id(li_next_id,'F') //Add group access -- jervis 12.02.2010
end if

return success

end event

event retrieveend;call super::retrieveend;if RowCount <= 0 then
	dw_contact_master.Reset()
	dw_master.Reset()
	dw_1.Reset()
	return
end if

dw_contact_master.SetRedraw(false)
dw_contact_master.Event pfc_Retrieve()
dw_contact_master.SetRedraw(true)

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-11-01 By: Scofield
//$<Reason> Display or hide the DefaultTo column

long		ll_Row
String	ls_Type

ll_Row = This.GetRow()
if ll_Row > 0 and ll_Row <= This.RowCount() then
	ls_Type = This.GetItemString(ll_Row,'contact_type2')
	
	if ls_Type = 'B' then
		dw_master.Modify("DefaultTo.Visible='1'")
		dw_master.Modify("t_defaultto.Visible='1'")
	else
		dw_master.Modify("DefaultTo.Visible='0'")
		dw_master.Modify("t_defaultto.Visible='0'")
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event getfocus;call super::getfocus;//this.title = ' >>>>>>>>>> ' + this.tag + ' <<<<<<<<<<< '	//Modified By mark 03/22/12

ii_CurrentDw = 1

end event

event losefocus;call super::losefocus;this.title = this.tag
end event

event constructor;call super::constructor;DataWindowChild dwc_Link	, dwc_country		//Added By Mark Lee 05/19/12
Integer	li_Rtn

li_Rtn = dw_facility_detail.GetChild('corp_office_link',dwc_Link)

if li_Rtn = 1 then
	dwc_Link.SetTransObject(SQLCA)
	dwc_Link.Retrieve()
	dwc_Link.InsertRow(1)
end if

//Added By Mark Lee 05/19/12
li_Rtn = dw_facility_detail.GetChild('country',dwc_country)
if li_Rtn = 1 then
	dwc_country.SetTransObject(SQLCA)
	dwc_country.Retrieve()
	dwc_country.InsertRow(1)
end if


end event

event other;call super::other;//Commented By mark 03/22/12
////------------------------------------------------------------- 
//// Check to see if the title bar for this datawindow has been 
//// clicked and prevent it
////-------------------------------------------------------------
//If Message.WordParm = 61458 Then 
//		Message.Processed = True
//		Message.ReturnValue = 0 
//End If

end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-29 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_fax,ls_RetParm

This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if this.Describe( "datawindow.readonly" ) = 'yes' then return //jervis 02.15.2011
	//Added By mark 03/22/12 for right of control 
	If ib_read_only = true or ib_enable_columns = false then 
		return	
	End If 
	if dwo.name = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
	elseif dwo.name = 'fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-12-06 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_fax,ls_RetParm

This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if this.Describe( "datawindow.readonly" ) = 'yes' then return //jervis 02.15.2011
	//Added By mark 03/22/12 for right of control 
	If ib_read_only = true or ib_enable_columns = false then 
		return	
	End If 
	
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_addrow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_add.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event pfc_deleterow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_delete.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow,ll_Right
String		ls_editstyle
String		ls_val
String		ls_protect
String		ls_colname
String		ls_currcolname
String		ls_type
String		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(6930)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
If ls_type = "ole" Or ls_type = "tableblob" Or ls_type = "graph" Then Return 1

// No RMB support for print preview mode
If This.Object.DataWindow.Print.Preview = "yes" Then Return 1

// Determine parent window for PointerX, PointerY offset
This.of_GetParentWindow (lw_parent)
If IsValid (lw_parent) Then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	Do While IsValid (lw_frame)
		If lw_frame.WindowType = MDI! Or lw_frame.WindowType = MDIHelp! Then
			lb_frame = True
			Exit
		Else
			lw_frame = lw_frame.ParentWindow()
		End If
	Loop
	
	If lb_frame Then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		If lw_parent.WindowType = Child! Then
			lw_parent = lw_frame
		Else
			lw_sheet = lw_frame.GetFirstSheet()
			If IsValid (lw_sheet) Then
				Do
					// Use frame reference for popup menu if the parentwindow is a sheet
					If lw_sheet = lw_parent Then
						lw_parent = lw_frame
						Exit
					End If
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				Loop Until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
			End If
		End If
	Else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		If lw_parent.WindowType = Child! Then
			lw_childparent = lw_parent.ParentWindow()
			If IsValid (lw_childparent) Then
				lw_parent = lw_childparent
			End If
		End If
	End If
Else
	Return 1
End If

// Create popup menu
lm_dw = Create m_dw
lm_dw.of_SetParent (This)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = This.GetRow()

ls_val = This.Object.DataWindow.Readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

Choose Case ls_type
	Case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"
	
	// Row operations based on readonly status
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', Not lb_readonly)
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', lb_desired)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', lb_desired)
	End If
	
Case Else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', False)
End Choose

// Get column properties
ls_currcolname = This.GetColumnName()
If ls_type = "column" Then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	If Not IsNumber(ls_protect) Then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = This.Describe(ls_expression)
	End If
	ls_val = dwo.TabSequence
	If IsNumber (ls_val) Then
		li_tabsequence = Integer (ls_val)
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', False)

// Get the column/editystyle specific editable flag.
If ls_type = "column" And Not lb_readonly Then
	Choose Case ls_editstyle
		Case "edit"
			ls_val = dwo.Edit.DisplayOnly
		Case "editmask"
			ls_val = dwo.EditMask.Readonly
		Case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		Case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		Case Else
			ls_val = ""
	End Choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	If IsNull(lb_editstyleattrib) Then lb_editstyleattrib = False
End If

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', True)
		Else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', False)
lm_dw.m_table.m_values.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', False)
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
	End If
End If

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-18 By: Scofield
//$<Reason> Don't display the mailaspdf and saveaspdf menu item
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

event rowfocuschanged;call super::rowfocuschanged;String	ls_Type

if CurrentRow <= 0 or CurrentRow > This.RowCount() then Return

ls_Type = This.GetItemString(CurrentRow,"contact_type2")
if ls_Type = 'B' then
	dw_master.Modify("user_d_t.Visible='0'")
	dw_master.Modify("user_d.Visible='0'")
else
	dw_master.Modify("user_d_t.Visible='1'")
	dw_master.Modify("user_d.Visible='1'")
end if

end event

event updateend;call super::updateend;long ll_facility_id

//Add default group access  -- jervis 12.02.2010
if rowsinserted > 0 then
	ll_facility_id = This.GetItemNumber(1,"facility_id")
	
	insert app_facility_group_access(facility_id,group_id,access,notes)
	select :ll_facility_id,group_id,access,notes
	from app_facility_default_access
	where Upper(user_id) = Upper(:gs_user_id);
	commit;
end if
end event

type cb_save from u_cb within u_tabpg_cntct_details
boolean visible = false
integer x = 3525
integer y = 348
integer width = 325
integer height = 96
integer taborder = 40
string text = "Save"
end type

event clicked;call super::clicked;
//dw_2.accepttext( )

//iw_parent.event dynamic ue_save( )

//IF parent.of_update( true, true) = 1 THEN 
//   PARENT.dw_master.event pfc_retrieve( )
//END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-27 By: Wu ZhiJun
//$<reason> Update the datawindow
if ii_CurrentDw = 1 then
	dw_facility_detail.Event ue_save()
elseif ii_CurrentDw = 2 then
	dw_master.Event ue_save()
end if

//--------------------------- APPEON END -----------------------------


end event

type dw_master from u_dw_contract within u_tabpg_cntct_details
event ue_save ( )
string tag = "Contact Information detail"
integer x = 1467
integer y = 708
integer width = 2409
integer height = 1208
integer taborder = 10
boolean titlebar = true
string title = "Contact Information detail"
string dataobject = "d_cntx_master"
boolean vscrollbar = false
boolean ib_retrieve_drop_downs = true
end type

event ue_save();long		ll_Row
long	li_Rtn,li_facility_id,li_contact_id

ll_Row = dw_master.getrow()

if ll_Row <= 0 then return

if Not f_validstr(STRING(this.object.contact_id[this.getrow()])) then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.17.2007 By: Jack
	//$<reason> 
	/*
	SELECT Max(contact_id)
	  INTO :li_contact_id
	  FROM ctx_contacts;
	*/
	li_contact_id = gnv_app.of_get_id("contact_id")
	//---------------------------- APPEON END ----------------------------
	//---------Begin Modified by (Appeon)Harry 10.30.2015 for Bug id 4811--------
	/*
	IF IsNull(li_contact_id) then li_contact_id = 0
	li_contact_id ++
	*/
	//---------End Modfiied ------------------------------------------------------
	This.SetItem(this.getrow(),"contact_id", li_contact_id )
end if

if Not f_validstr(STRING(dw_master.object.facility_id[ll_Row])) then
	li_facility_id = dw_facility_detail.GetItemNumber(dw_facility_detail.GetRow(),'facility_id')
	dw_master.SetItem(ll_Row, "facility_id", li_facility_id)
end if

dw_master.AcceptText()

li_Rtn = dw_master.Update()

if li_Rtn = 1 then
	COMMIT USING SQLCA;
else
	MessageBox('Warning','DataWindow Save failed!' + SQLCA.SQLErrText,Exclamation!)
	ROLLBACK USING SQLCA;
end if

end event

event pfc_postinsertrow;call super::pfc_postinsertrow;
/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



end event

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.19.2006 By: Liang QingShi
//$<reason> Contract module modification 
//$<reason> Fix a defect.

//this.setitem(this.getrow(),'custom_1',dw_2.getitemstring(dw_2.getrow(),'custom_1'))
//this.setitem(this.getrow(),'custom_2',dw_2.getitemstring(dw_2.getrow(),'custom_2'))
//this.setitem(this.getrow(),'custom_3',dw_2.getitemstring(dw_2.getrow(),'custom_3'))
//this.setitem(this.getrow(),'custom_4',dw_2.getitemstring(dw_2.getrow(),'custom_4'))
//this.setitem(this.getrow(),'custom_5',dw_2.getitemstring(dw_2.getrow(),'custom_5'))
//this.setitem(this.getrow(),'custom_6',dw_2.getitemstring(dw_2.getrow(),'custom_6'))
//this.setitem(this.getrow(),'custom_7',dw_2.getitemstring(dw_2.getrow(),'custom_7'))
//this.setitem(this.getrow(),'custom_8',dw_2.getitemstring(dw_2.getrow(),'custom_8'))
//this.setitem(this.getrow(),'custom_9',dw_2.getitemstring(dw_2.getrow(),'custom_9'))
//this.setitem(this.getrow(),'custom_10',dw_2.getitemstring(dw_2.getrow(),'custom_10'))
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-27 By: Wu ZhiJun
//$<reason> PreUpdate
long		ll_Row
Long	li_facility_id,li_contact_id
//<add> 08/13/2007 by: Andy
String ls_first_name,ls_last_name,ls_user_d,ls_Category
Long   ll_li_contact_id
//end of add

This.AcceptText()

ll_Row = dw_master.getrow()
if ll_Row <= 0 then return failure

//<add> 08/13/2007 by: Andy
ls_user_d = this.getitemstring(ll_Row,"user_d")
ll_li_contact_id = this.getitemNumber(ll_Row,"contact_id")
if isnull(ll_li_contact_id) then ll_li_contact_id = 0
if Len(ls_user_d) > 0 then
	ls_Category = dw_facility_detail.getitemstring(dw_facility_detail.GetRow(),"contact_type2")
	if isnull(ls_Category) then ls_Category = ''
	//Our Company
	if UPPER(ls_Category) = 'A' THEN
		Select TOP 1 ISNULL(a.first_name,''),ISNULL(a.last_name,'') Into :ls_first_name,:ls_last_name from ctx_contacts a inner join app_facility b on (a.facility_id = b.facility_id) where b.contact_type2 = 'A' and a.user_d = :ls_user_d and a.contact_id <> :ll_li_contact_id;
		If SQLCA.sqlcode = 0 Then
			//The user id XX is linked to XX's Contact record and can't be linked to others Contact record.
			messagebox(gnv_app.iapp_object.DisplayName,"The user id " + ls_user_d + " is linked to " + ls_first_name + " " + ls_last_name +  "'s Contact record and can't be linked to others Contact record.")
			return failure
		end if
	END IF
end if
//end of add

if Not f_validstr(string(This.object.contact_id[ll_Row])) then
   object.contact_id[ll_Row] = of_get_next_sequence_number()
else
	a_parent_tab.function dynamic of_set_contact_id(This.object.contact_id[ll_Row])
end if

if Not f_validstr(STRING(dw_master.object.facility_id[ll_Row])) then
	li_facility_id = dw_facility_detail.GetItemNumber(dw_facility_detail.GetRow(),'facility_id')
	
	if Not f_validstr(STRING(li_facility_id)) then
		return failure
	end if
	
	dw_master.SetItem(ll_Row, "facility_id", li_facility_id)
end if

//--------------------------- APPEON END -----------------------------

return success
end event

event pfc_retrieve;call super::pfc_retrieve;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


this.setfocus( )
this.setcolumn('first_name' )

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-27 By: Wu ZhiJun
//$<reason> Retrieve the data depend on dw_contact_master
Long li_contact_id,li_Row

li_Row = dw_contact_master.GetRow()
if li_Row > 0 then
	li_contact_id = dw_contact_master.GetItemNumber(li_Row,'contact_id')
end if

this.Retrieve(li_contact_id)
//--------------------------- APPEON END -----------------------------

RETURN SUCcess


end event

event doubleclicked;call super::doubleclicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


string ls_column 

//Added By mark 03/22/12 for right of control 
If ib_read_only = true or ib_enable_columns = false then 
	return	
End If 

choose case  ls_column
	case 'first_name','last_name','contact_type'
		f_open_lookup_maint(GetColumnName(),this)
	case else 
		//cb_save_select.event clicked( )
end choose 





end event

event retrieveend;call super::retrieveend;
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 03.15.2006 By: Rodger Wu
//$<reason> Fix a defect.
//$<reason> Due to rows in dw_1 can not save after click Save button, 
//$<reason> move following script to w_contract_contact.of_retrieve().
/* dw_1.event pfc_retrieve( ) */
//---------------------------- APPEON END ----------------------------

//dw_master.ShareData ( dw_2 )

//if  ib_show_button = false then
//	this.object.showbutton[1] = 'N'
//else
//	this.object.showbutton[1] = 'Y'
//end if

//THIS.SetItemStatus(1,0,primary!,NOTMODIFIED!)

end event

event getfocus;call super::getfocus;event ue_populatedddws( )
This.border = true
ii_CurrentDw = 2

end event

event constructor;call super::constructor;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.01.2006 By: Liang QingShi
//$<reason> Contract module modification
this.ib_retrieve_drop_downs = false
this.event ue_populatedddws( )

//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-03-09 By: Wu ZhiJun
//$<reason> Update the user in dddw  
DataWindowChild ldwc_User

dw_master.GetChild('user_d',ldwc_User)
ldwc_User.SetTransObject(SQLCA)
ldwc_User.Retrieve()

//--------------------------- APPEON END -----------------------------

this.of_setreqcolumn( true)

ib_rmbmenu = false

end event

event other;call super::other;if message.number = 522 then 
    message.processed= true 
    message.returnvalue = 522 
end if
end event

event pfc_validation;
if this.rowcount( ) <  1 then return success

this.accepttext( )


if not f_validstr(string(this.object.first_name[1])) then
	messagebox('Information', 'First Name is required.')
	return failure
end if

if not f_validstr(string(this.object.last_name[1])) then
	messagebox('Information', 'Last Name is required.')
	return failure
end if 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 04.17.2007 By: Jack
//$<reason> Make Contact Type so it is not Required.
/*
if not f_validstr(string(this.object.contact_type[1])) then
	messagebox('Information', 'Contact Type is required.')
	return failure
end if 
*/
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-27 By: Wu ZhiJun
//$<reason> comment this because the contact_type2 have movied to app_facility
//if this.object.contact_type2[1]= 'A' and isnull(this.object.user_d[1]) then
//	if messagebox('Information', 'This contact should have a user id added since he/she is part of our company. ' +&
//	            'If no user id exists it will not be possible to assign ownership of any contracts to this user. Do you want to continue anyway?',information!, yesno!,1) = 1 then 
//		 return success
//	else 
//	    return failure
//     end if 
//end if 
//--------------------------- APPEON END -----------------------------


//if not f_validstr(this.object.street_1[1]) then
//	messagebox('Information', 'If this contact does not have an address. The will be none printed on letter.')
//end if 

return success
end event

event buttonclicked;call super::buttonclicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 12 May 006 ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

LONG LL_NEW_ROW
LONG ll_found
LONG ll_state_id
string ls_phone 

string ls_state
choose case dwo.name 
	case 'b_ctx_co'
		n_ds lds_app_facility
		lds_app_facility = create n_ds 
		lds_app_facility.dataobject = 'd_facility_detail'
		lds_app_facility.settransobject(sqlca)
		if lds_app_facility.retrieve(ll_app_facility ) > 0 then 
		
		this.object.street_1[1] = lds_app_facility.object.street[1]
		this.object.street_2[1] = lds_app_facility.object.street_2[1]
		//this.object.street_3[1] = lds_app_facility.object.street[1]
		this.object.city[1] = lds_app_facility.object.city[1]
		
		if f_validstr(lds_app_facility.object.state[1]) Then 
			ls_state = lds_app_facility.object.state[1]
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 10.19.2006 By: Davis
			//$<reason> Performance tuning.
			/*
			select lookup_code
			into :ll_state_id
			from code_lookup
			where lookup_name = 'state' and code =:ls_state;
			*/
			ll_state_id = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('state') and upper(code) = upper('"+ls_state+"')"))
			//---------------------------- APPEON END ----------------------------
			// the state field is free form in app_facility
			if ll_state_id > 0 then
			  this.object.state[1] = ll_state_id
		   end if 
	  end if 
		
		this.object.zip[1] = lds_app_facility.object.zip[1]
		
		// add in the phone number
		 if f_validstr(lds_app_facility.object.phone[1]) then 
			 ls_phone  = trim(string(lds_app_facility.object.phone[1]))
			  
         if dw_1.Find("phone = '" + ls_phone+ "'", 1, dw_1.RowCount()) < 1 then
		      LL_NEW_ROW = dw_1.event pfc_addrow( )
			
			   dw_1.object.phone[LL_NEW_ROW] = lds_app_facility.object.phone[1] 
	
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 10.19.2006 By: Davis
				//$<reason> Performance tuning.
				/*
			 	select lookup_code
			 	into :ll_state_id
			 	from code_lookup
			 	where lookup_name = 'Contract Contact VIA' and code = 'PHONE';
				*/
				ll_state_id = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Contract Contact VIA') and upper(code) = upper('PHONE')"))
				//---------------------------- APPEON END ----------------------------
				dw_1.object.via[LL_NEW_ROW] = ll_state_id
				
			end if 
			
		 end if 
		 // this is the contract company so set it
		 this.object.contact_type2[1] = 'B'
	  end if 
		
		
		
		
	case else
end choose
end event

event dberror;call super::dberror;//
end event

event rowfocuschanged;call super::rowfocuschanged;dw_2.SetRow(currentrow)
dw_2.ScrollToRow(currentrow)

end event

event updateend;call super::updateend;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-11-01 By: Scofield
//$<Reason> Control only one contact's defaultto was selected

String	ls_DefaultTo
long		ll_Row,ll_FacilityId,ll_ContactId

ll_Row = This.GetRow()

if ll_Row > 0 and ll_Row <= This.RowCount() then
	ls_DefaultTo = This.GetItemString(ll_Row,'DefaultTo')
	ll_ContactId = This.GetItemNumber(ll_Row,'contact_id')
	
	if ls_DefaultTo = '1' then
		ll_FacilityId = This.GetItemNumber(ll_Row,'facility_id')
		
		
		Update ctx_contacts 
			Set defaultto = '0'
		 Where facility_id = :ll_FacilityId and contact_id <> :ll_ContactId ;
	end if
end if
//---------------------------- APPEON END ----------------------------

////Add default group access  -- jervis 11.26.2010
//if rowsinserted > 0 then
//	insert ctx_contact_group_access(contact_id,group_id,access,notes)
//	select :ll_ContactId,group_id,access,notes
//	from ctx_contact_default_access
//	where Upper(user_id) = Upper(:gs_user_id);
//	commit;
//end if




end event

event itemchanged;call super::itemchanged;//BEGIN---Modify by Evan on 06/16/2008
/*
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-08 By: Scofield
//$<Reason> if there is no a valid email config,popup a informaiton dialog.

String	ls_Server,ls_Account,ls_EMail

if dwo.name = 'user_d' and Not IsNull(data) then
	SELECT em_smtp_accounts.server,em_smtp_accounts.account,em_smtp_accounts.Email
	  INTO :ls_Server,:ls_Account,:ls_EMail
	  FROM em_smtp_accounts
	 WHERE em_smtp_accounts.user_id = :data and em_smtp_accounts.is_default = 'Y' ;
	 
	if IsNull(ls_Server) or Trim(ls_Server) = '' or IsNull(ls_Account) or Trim(ls_Account) = '' or IsNull(ls_EMail) or Trim(ls_EMail) = '' then
		MessageBox(gnv_app.iapp_object.DisplayName,'The email address for this User ID has not been configured properly. If its Contact Type ~r~nis selected in Work Flow, the email will not be sent successfully.')
	end if
end if
//---------------------------- APPEON END ----------------------------
*/
long    ll_Port
long    ll_AuthMode
string  ls_Server
string  ls_Account
string  ls_EMail
boolean lb_Prompt = true

if dwo.name = 'user_d' and not IsNull(data) then
	SELECT server, port, account, email, authmode
	  INTO :ls_Server, :ll_Port, :ls_Account, :ls_EMail, :ll_AuthMode
	  FROM em_smtp_accounts
	  WHERE user_id = :data and is_default = 'Y';
	 
	if ll_AuthMode = 1 then
		if Len(Trim(ls_Server)) > 0 and ll_Port > 0 and &
			Len(Trim(ls_Account)) > 0 and Len(Trim(ls_Email)) > 0 &
		then
			lb_Prompt = false
		end if
	else
		if Len(Trim(ls_Server)) > 0 and ll_Port > 0 and Len(Trim(ls_Email)) > 0 then
			lb_Prompt = false
		end if
	end if
	
	if lb_Prompt then
		//MessageBox(gnv_app.iapp_object.DisplayName,'The email address for this User ID has not been configured properly. If its Contact Type ~r~nis selected in Work Flow, the email will not be sent successfully.')
		MessageBox(gnv_app.iapp_object.DisplayName,'The email address for this User ID has not been configured properly. If its Contact Type is selected in a Work Flow, the email will not be sent successfully.')  //(Appeon)Harry 09.22.2014 - for Bug # 4231 
	end if
end if
//END---Modify by Evan on 06/16/2008
end event

event pfc_addrow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_add.TriggerEvent(Clicked!)
	
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event pfc_deleterow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_delete.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow,ll_Right
String		ls_editstyle
String		ls_val
String		ls_protect
String		ls_colname
String		ls_currcolname
String		ls_type
String		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(6930)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
If ls_type = "ole" Or ls_type = "tableblob" Or ls_type = "graph" Then Return 1

// No RMB support for print preview mode
If This.Object.DataWindow.Print.Preview = "yes" Then Return 1

// Determine parent window for PointerX, PointerY offset
This.of_GetParentWindow (lw_parent)
If IsValid (lw_parent) Then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	Do While IsValid (lw_frame)
		If lw_frame.WindowType = MDI! Or lw_frame.WindowType = MDIHelp! Then
			lb_frame = True
			Exit
		Else
			lw_frame = lw_frame.ParentWindow()
		End If
	Loop
	
	If lb_frame Then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		If lw_parent.WindowType = Child! Then
			lw_parent = lw_frame
		Else
			lw_sheet = lw_frame.GetFirstSheet()
			If IsValid (lw_sheet) Then
				Do
					// Use frame reference for popup menu if the parentwindow is a sheet
					If lw_sheet = lw_parent Then
						lw_parent = lw_frame
						Exit
					End If
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				Loop Until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
			End If
		End If
	Else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		If lw_parent.WindowType = Child! Then
			lw_childparent = lw_parent.ParentWindow()
			If IsValid (lw_childparent) Then
				lw_parent = lw_childparent
			End If
		End If
	End If
Else
	Return 1
End If

// Create popup menu
lm_dw = Create m_dw
lm_dw.of_SetParent (This)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = This.GetRow()

ls_val = This.Object.DataWindow.Readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

Choose Case ls_type
	Case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"
	
	// Row operations based on readonly status
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', Not lb_readonly)
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', lb_desired)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', lb_desired)
	End If
	
Case Else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', False)
End Choose

// Get column properties
ls_currcolname = This.GetColumnName()
If ls_type = "column" Then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	If Not IsNumber(ls_protect) Then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = This.Describe(ls_expression)
	End If
	ls_val = dwo.TabSequence
	If IsNumber (ls_val) Then
		li_tabsequence = Integer (ls_val)
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', False)

// Get the column/editystyle specific editable flag.
If ls_type = "column" And Not lb_readonly Then
	Choose Case ls_editstyle
		Case "edit"
			ls_val = dwo.Edit.DisplayOnly
		Case "editmask"
			ls_val = dwo.EditMask.Readonly
		Case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		Case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		Case Else
			ls_val = ""
	End Choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	If IsNull(lb_editstyleattrib) Then lb_editstyleattrib = False
End If

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', True)
		Else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', False)
lm_dw.m_table.m_values.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', False)
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
	End If
End If

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-18 By: Scofield
//$<Reason> Don't display the mailaspdf and saveaspdf menu item
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

event clicked;call super::clicked;//Added By Ken.Guo 2011-07-07. 
Choose Case dwo.name
	Case 't_1','l_1','l_2'
	dw_1.SetFocus()
	dw_1.event rowfocuschanged( dw_1.getrow())
End Choose
end event

type cb_save_select from u_cb within u_tabpg_cntct_details
boolean visible = false
integer x = 3525
integer y = 196
integer width = 325
integer height = 96
integer taborder = 50
string text = "Save/Select"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.19.2006 By: LeiWei
//$<reason> Fix a defect.
dw_1.accepttext( )
//---------------------------- APPEON END ----------------------------

dw_2.accepttext( )


cb_save.TriggerEvent(clicked!)

long 		ll_i
String 	ll_Phone,ls_EMail

Invo_cst_dwsrv.of_SetreQuestor( DW_1)
for ll_i = 1 to dw_1.RowCount()
	if Upper(Invo_cst_dwsrv.OF_GETITem( LL_I, 'VIA')) = 'PHONE' then 
		ll_Phone = dw_1.object.Phone[ll_i]
	end if
	if Upper(Invo_cst_dwsrv.of_GetItem( ll_i, 'VIA')) = 'EMAIL' then 
		ls_EMail = DW_1.OBJECT.contact_email[ll_i]
	end if
NEXT

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-20 By: Wu ZhiJun
//$<reason> Update the E-Mail value
str_contact lstr_contact
lstr_contact.as_last_name = dw_master.object.last_name[1]
lstr_contact.as_first_name = dw_master.object.first_name[1]
lstr_contact.as_middle_name = dw_master.object.middle_name[1]
lstr_contact.al_contact_id = dw_master.object.contact_id[1] 
lstr_contact.al_contact_type = dw_master.object.contact_type[1] 
lstr_contact.as_user_id = dw_master.object.user_d[1] 
lstr_contact.as_phone_number = LL_PHONE
lstr_contact.as_contact_title = dw_master.object.contact_title[1] 
lstr_contact.al_contact_department = dw_master.object.contact_department[1] 
lstr_contact.as_email = ls_EMail

if iw_parent.ClassName() = "w_contract_contact" then
	//Modified By Ken.Guo 11/01/2012
	//iw_parent.function dynamic of_add_email_contact(dw_master.object.last_name[1],dw_master.object.first_name[1],dw_master.object.middle_name[1],dw_master.object.contact_id[1],dw_master.object.contact_type[1],dw_master.object.user_d[1], LL_PHONE,ls_EMail)
	iw_parent.function dynamic of_add_email_contact( lstr_contact ) 
else
	//Modified By Ken.Guo 11/01/2012
	//iw_parent.function dynamic of_add_contacts(dw_master.object.last_name[1],dw_master.object.first_name[1],dw_master.object.middle_name[1],dw_master.object.contact_id[1],dw_master.object.contact_type[1],dw_master.object.user_d[1], LL_PHONE)
	iw_parent.function dynamic of_add_contacts(lstr_contact)
end if
//--------------------------- APPEON END -----------------------------

close(iw_parent)

end event

type cb_phone_delete from u_cb within u_tabpg_cntct_details
boolean visible = false
integer x = 3525
integer y = 1088
integer width = 325
integer height = 96
integer taborder = 40
string text = "Del Via"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.08.2007 By: Jack 
//$<reason> Fix a defect.
/*
dw_1.event pfc_deleterow( )
*/
dw_1.deleterow(il_row)
//---------------------------- APPEON END ----------------------------

end event

type cb_1 from u_cb within u_tabpg_cntct_details
boolean visible = false
integer x = 3525
integer y = 768
integer width = 325
integer height = 96
integer taborder = 60
string text = "Close"
boolean cancel = true
end type

event clicked;call super::clicked;
dw_2.accepttext( )
close(iw_parent)
end event

type cb_phone_insert from u_cb within u_tabpg_cntct_details
boolean visible = false
integer x = 3525
integer y = 940
integer width = 325
integer height = 96
integer taborder = 30
string text = "Add Via"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.08.2007 By: Jack 
//$<reason> Fix a defect.
/*
dw_1.event pfc_insertrow( )
*/
dw_1.event pfc_addrow( )

//---------------------------- APPEON END ----------------------------

end event

type cb_udf_ins from u_cb within u_tabpg_cntct_details
boolean visible = false
integer x = 3525
integer y = 496
integer width = 325
integer height = 96
integer taborder = 40
string text = "Add"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.09.2007 By: Jack 
//$<reason> Fix a defect.
/*
dw_2.event pfc_insertrow( )
*/
//string ls_contact_type2
//dw_master.accepttext()
//If dw_master.rowcount() < 1 Then Return
//ls_contact_type2 = dw_master.getitemstring(dw_master.getrow(),'contact_type2')
//cb_save.triggerevent(clicked!)
//
//parent.event ue_new()
//dw_master.setitem(dw_master.getrow(),'contact_type2',ls_contact_type2)
//
//---------------------------- APPEON END ----------------------------

long	ll_Row

if ii_CurrentDw = 1 then
	ll_Row = dw_facility_detail.InsertRow(0)
	dw_facility_detail.ScrollToRow(ll_Row)
elseif ii_CurrentDw = 2 then
	ll_Row = dw_master.InsertRow(0)
	dw_master.ScrollToRow(ll_Row)
end if

end event

type cb_udf_del from u_cb within u_tabpg_cntct_details
boolean visible = false
integer x = 3570
integer y = 1656
integer width = 334
integer taborder = 50
string text = "Delete"
end type

type cb_delete from u_cb within u_tabpg_cntct_details
boolean visible = false
integer x = 3525
integer y = 632
integer width = 325
integer height = 96
integer taborder = 50
string text = "Delete"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.17.2006 By: LeiWei
//$<reason> Need a way to delete a contact person.

Long ll_contact_id
Long ll_rnt
Long ll_row

IF dw_master.Rowcount() > 0 THEN
	ll_contact_id = dw_master.GetitemNumber(1, "contact_id")
	
	// make sure contact person is not referenced in any contract
	SELECT COUNT(*) INTO :ll_rnt
	FROM ctx_contract_contacts
	WHERE contact_id = :ll_contact_id;
	
	IF ll_rnt > 0 THEN
		Messagebox("Delete contact", "Can't delete the contact. The contact person is referenced by another contract. ")
		Return
	END IF
	
	// To delete a contact person.
	gnv_appeondb.of_startqueue( )
	
	Delete FROM ctx_contacts_numbers WHERE contact_id = :ll_contact_id;
	Delete FROM ctx_contacts WHERE contact_id = :ll_contact_id;
	Commit;

	gnv_appeondb.of_commitqueue( )
	
	dw_master.Reset( )
	dw_1.Reset( )
	dw_1.Reset( )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01.09.2007 By: Jack 
	//$<reason> Fix a defect. 
	 iw_parent.event dynamic ue_refurbish()
	//---------------------------- APPEON END ----------------------------
	
END IF

//---------------------------- APPEON END ----------------------------

end event

type dw_1 from u_dw_contract within u_tabpg_cntct_details
string tag = "Contact Phone Numbers"
integer x = 1531
integer y = 1340
integer width = 2286
integer height = 512
integer taborder = 20
boolean bringtotop = true
string title = "Contact Phone Numbers"
string dataobject = "d_cntx_phone"
boolean border = false
boolean ib_retrieve_drop_downs = true
boolean ib_use_row_selection = true
end type

event pfc_predeleterow;call super::pfc_predeleterow;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if GetSelectedRow(0) < 1 then 
	Messagebox('Select Row', 'Please select a row.')
	return 0
end if



if Messagebox('Confirm Delete','Are you sure you want to delete this row ?',question!,YesNo!,2) = 1 then 
	return continue_action
else
   return 0	
	
end if

end event

event clicked;call super::clicked;//This.SelectRow(0, FALSE)
//
//This.SelectRow(row, TRUE)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.08.2007 By: Jack 
//$<reason> Fix a defect.
il_row = row
//---------------------------- APPEON END ----------------------------

end event

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long 		ll_i,ll_Count
String	ls_phone,ls_ext,ls_contact_email,ls_Via

if dw_master.RowCount() < 1 then return Success

for ll_i = 1 to RowCount( )
	ls_phone = This.GetItemString(ll_i,'phone')
	ls_ext = This.GetItemString(ll_i,'ext')
	ls_contact_email = This.GetItemString(ll_i,'contact_email')
	ls_Via = Upper(dw_1.Describe("Evaluate('LookUpDisplay(via)'," + String(ll_i) + ")"))		//Added by Scofield on 2008-04-23
	
	if IsNull(ls_phone) then ls_phone = ""
	if IsNull(ls_ext) then ls_ext = ""
	if IsNull(ls_contact_email) then ls_contact_email = ""
		
	if ls_phone + ls_ext + ls_contact_email = "" and ls_Via <> 'WEB' then							//Modified by Scofield on 2008-04-23
		dw_1.SetItemStatus(ll_i,0,Primary!,NotModified!)
		continue
	end if

   this.object.contact_id[ll_i] = dw_master.object.contact_id[1]
next

a_parent_tab.function dynamic of_set_contact_id(dw_master.object.contact_id[1])

return Success

end event

event pfc_retrieve;call super::pfc_retrieve;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


//THIS.Retrieve(A_parent_tab.FUNCTION DYNAMIC of_get_contact_id())
//
//RETURN SUCcess

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-28 By: Wu ZhiJun
//$<reason> Retrieve the data depend on dw_master
Long li_contact_id,li_Row

li_Row = dw_master.GetRow()
if li_Row > 0 then
	li_contact_id = dw_master.GetItemNumber(li_Row,'contact_id')
end if

this.Retrieve(li_contact_id)
//--------------------------- APPEON END -----------------------------

RETURN Success

end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.01.2006 By: Liang QingShi
//$<reason> Contract module modification
this.ib_retrieve_drop_downs = false
this.event ue_populatedddws( )

//---------------------------- APPEON END ----------------------------

ib_rmbmenu = false

if AppeonGetClientType() = "WEB" then This.Y -= 4

end event

event getfocus;call super::getfocus;//this.border = true
ii_CurrentDw = 3

This.event rowfocuschanged(This.GetRow()) //Added By Ken.Guo 2011-07-07. 
end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-10-17 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_RetParm,ls_Via

ls_Via = dw_1.Describe("evaluate('LookUpDisplay(via)'," + String(row) + ")")

if ls_Via <> 'PHONE' and ls_Via <> 'FAX' and ls_Via <> 'CELL' and ls_Via <> 'PAGER' then return

This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if this.Describe( "datawindow.readonly" ) = 'yes' then return //jervis 02.15.2011
	//Added By mark 03/22/12 for right of control 
	If ib_read_only = true or ib_enable_columns = false then 
		return	
	End If 
	if dwo.name = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-12-06 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_RetParm

This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if this.Describe( "datawindow.readonly" ) = 'yes' then return //jervis 02.15.2011
	//Added By mark 03/22/12 for right of control 
	If ib_read_only = true or ib_enable_columns = false then 
		return	
	End If 
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_deleterow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_delete.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow,ll_Right
String		ls_editstyle
String		ls_val
String		ls_protect
String		ls_colname
String		ls_currcolname
String		ls_type
String		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(6930)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
If ls_type = "ole" Or ls_type = "tableblob" Or ls_type = "graph" Then Return 1

// No RMB support for print preview mode
If This.Object.DataWindow.Print.Preview = "yes" Then Return 1

// Determine parent window for PointerX, PointerY offset
This.of_GetParentWindow (lw_parent)
If IsValid (lw_parent) Then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	Do While IsValid (lw_frame)
		If lw_frame.WindowType = MDI! Or lw_frame.WindowType = MDIHelp! Then
			lb_frame = True
			Exit
		Else
			lw_frame = lw_frame.ParentWindow()
		End If
	Loop
	
	If lb_frame Then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		If lw_parent.WindowType = Child! Then
			lw_parent = lw_frame
		Else
			lw_sheet = lw_frame.GetFirstSheet()
			If IsValid (lw_sheet) Then
				Do
					// Use frame reference for popup menu if the parentwindow is a sheet
					If lw_sheet = lw_parent Then
						lw_parent = lw_frame
						Exit
					End If
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				Loop Until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
			End If
		End If
	Else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		If lw_parent.WindowType = Child! Then
			lw_childparent = lw_parent.ParentWindow()
			If IsValid (lw_childparent) Then
				lw_parent = lw_childparent
			End If
		End If
	End If
Else
	Return 1
End If

// Create popup menu
lm_dw = Create m_dw
lm_dw.of_SetParent (This)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = This.GetRow()

ls_val = This.Object.DataWindow.Readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

Choose Case ls_type
	Case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"
	
	// Row operations based on readonly status
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', Not lb_readonly)
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', lb_desired)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', lb_desired)
	End If
	
Case Else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', False)
End Choose

// Get column properties
ls_currcolname = This.GetColumnName()
If ls_type = "column" Then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	If Not IsNumber(ls_protect) Then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = This.Describe(ls_expression)
	End If
	ls_val = dwo.TabSequence
	If IsNumber (ls_val) Then
		li_tabsequence = Integer (ls_val)
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', False)

// Get the column/editystyle specific editable flag.
If ls_type = "column" And Not lb_readonly Then
	Choose Case ls_editstyle
		Case "edit"
			ls_val = dwo.Edit.DisplayOnly
		Case "editmask"
			ls_val = dwo.EditMask.Readonly
		Case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		Case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		Case Else
			ls_val = ""
	End Choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	If IsNull(lb_editstyleattrib) Then lb_editstyleattrib = False
End If

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', True)
		Else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', False)
lm_dw.m_table.m_values.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', False)
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
	End If
End If

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-18 By: Scofield
//$<Reason> Don't display the mailaspdf and saveaspdf menu item
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

event losefocus;call super::losefocus;This.SelectRow( 0, False) //Added By Ken.Guo 2011-07-07. 
end event

