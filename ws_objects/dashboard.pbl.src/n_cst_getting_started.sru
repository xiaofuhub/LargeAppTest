$PBExportHeader$n_cst_getting_started.sru
forward
global type n_cst_getting_started from nonvisualobject
end type
end forward

global type n_cst_getting_started from nonvisualobject autoinstantiate
event ue_do ( string as_tag )
end type

forward prototypes
public function integer of_set_picture (ref picturebutton apb_module[])
public function integer of_set_access (picturebutton apb_module[])
public function string of_get_tips (string as_id)
public function integer of_initgettingstart (string as_userid, ref datastore ads_gettingstart)
end prototypes

event ue_do(string as_tag);PowerObject lpo_NullParm
Boolean	lbn_tag = False
Choose Case as_tag
	Case '1','1,0','1,1' //add_new_contract
		If Not isvalid(gw_contract) Then
			gf_OpenContractFolder(lpo_NullParm)
			//Added By Mark Lee 05/07/12
			lbn_tag = True
		End If
		gw_contract.bringtotop = True
		If gw_contract.windowstate = Minimized! Then
			gw_contract.windowstate = Normal! 
		End If
		If as_tag = '1,1' Then
			//New CTX with Template
			gw_contract.post event ue_use_template()			
		Else
			//New CTX
			gw_contract.post event pfc_new()
			//Added By Mark Lee 05/07/12	
			If gw_contract.windowstate <> Maximized! and lbn_tag = False and as_tag ='1,0' Then
				gw_contract.windowstate = Maximized!
			End If
		End If
	Case '2' //search_for_contract
		If Not isvalid(gw_contract) Then
			gf_OpenContractFolder(lpo_NullParm)
		End If
		gw_contract.bringtotop = True
		If gw_contract.windowstate = Minimized! Then
			gw_contract.windowstate = Normal! 
		End If		
		gw_contract.tab_contract_details.Post selecttab(1)
		
	Case '3' //search_for_document
		OpenSheet( w_documents_browse, w_mdi, 0, Original!)
		
	Case '4' //full_text_search
		If Not isvalid(gw_contract) Then
			gf_OpenContractFolder(lpo_NullParm)
		End If
		gw_contract.bringtotop = True
		If gw_contract.windowstate = Minimized! Then
			gw_contract.windowstate = Normal! 
		End If		
		POST Open (w_contract_globalsearch)		
	Case '5' //view_calendar
		If Not isvalid(w_CalendarView) Then
			OpenSheet(w_CalendarView,w_mdi,-1,Original!)	
		Else
			w_CalendarView.Bringtotop = True
		End If
	Case '6' //configure_email
		OpenWithParm(w_email_account_edit, "PERSONAL|" + gs_user_id)
	Case '7' //email_templates
		w_mdi.event pfc_cst_email_painter()
		
	Case '8' //manage_users
		//w_mdi.event pfc_cst_security_user_painter()  //Commented by (Appeon)Harry 10.24.2014
		Open (w_security_user_painter_ctx) //(Appeon)Harry 10.24.2014 - for BugH102201
	Case '9' //customize_screens
		w_mdi.event pfc_cst_contract_screen_painter()
		
	Case '10' //edit_lookup_tables
		w_mdi.event pfc_cst_lookup_painter()
	
	Case '11' //View Contact
		w_mdi.event pfc_cst_contact()
		
End Choose


end event

public function integer of_set_picture (ref picturebutton apb_module[]);Integer i,j,li_find,li_cnt
String ls_sort,ls_sort_col[]
Boolean lb_exists
n_cst_string lnv_string

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("getting_started_data", FALSE)
gnv_data.of_retrieveIfNecessary("dashboard_getting_started", FALSE)
//------------------------------------------------------------------------

// RP comment out
//If gnv_data.ids_getting_started.rowcount() = 0 Then gnv_data.of_retrieve("getting_started_data") //(Appeon)Eugene 06.10.2013 - V141 ISG-CLX//(Appeon)Toney 09.04.2013 - V141 ISG-CLX unnecessary 
																															 //(Appeon)Toney 10.15.2013 - V141 ISG-CLX, Fix Reintegration BugH101201
If gnv_data.ids_getting_started.rowcount() = 0 Then
	Messagebox('Getting Started','Failed to get Getting Started data, please call support.')
	Return -1
End If

If gnv_data.ids_dashboard_getting_started.rowcount() = 0 Then
	
	Select count(1) into :li_cnt From dashboard_gadgets_getting_started where user_id = :gs_user_id;
	If li_cnt = 0 or isnull(li_cnt) Then
		For i = 1 To gnv_data.ids_getting_started.rowcount()
			ls_sort += String(gnv_data.ids_getting_started.GetItemNumber(i,'id') ) + ','
		Next
		ls_sort = Mid(ls_sort,1,len(ls_sort) - 1)
		gnv_data.ids_dashboard_getting_started.InsertRow(0)
		gnv_data.ids_dashboard_getting_started.SetItem(1,'user_id',gs_user_id)
		gnv_data.ids_dashboard_getting_started.SetItem(1,'sort_result',ls_sort)
		gnv_data.ids_dashboard_getting_started.SetItem(1,'display_columns',2)
		If gnv_data.ids_dashboard_getting_started.Update() <> 1 Then
			gnv_data.ids_dashboard_getting_started.Reset()
			Messagebox('Getting Started','Failed to initialize data, please call support.')
			Return -2
		End If
	Else
		gnv_data.ids_dashboard_getting_started.Retrieve(gs_user_id)
	End If
	
End If

ls_sort = gnv_data.ids_dashboard_getting_started.GetItemString(1,'sort_result')
lnv_string.of_parsetoarray( ls_sort, ',', ls_sort_col[])

If UpperBound(ls_sort_col[]) < gnv_data.ids_getting_started.rowcount() Then
	For i = 1 to gnv_data.ids_getting_started.rowcount()
		lb_exists = False
		For j = 1 To UpperBound(ls_sort_col[])
			If gnv_data.ids_getting_started.GetItemNumber(i,'id') = Integer(ls_sort_col[j]) Then
				lb_exists = true
				Exit
			End If
		Next
		If Not lb_exists Then
			ls_sort_col[UpperBound(ls_sort_col[]) + 1] = String(gnv_data.ids_getting_started.GetItemNumber(i,'id'))
		End If
	Next
End If

For i = 1 To UpperBound(apb_module[])
	If i > UpperBound(ls_sort_col[]) Then 
		apb_module[i].Tag = ''
		apb_module[i].DisabledName = ''
		apb_module[i].PictureName  = ''	
		apb_module[i].powertiptext = ''
		Continue
	End If
	li_find = gnv_data.ids_getting_started.Find('id = ' + ls_sort_col[i],1,gnv_data.ids_getting_started.RowCount())
	If li_find > 0 Then
		apb_module[i].Tag = ls_sort_col[i]		
		apb_module[i].PictureName = gnv_data.ids_getting_started.GetItemString(li_find,'enable_picture')
		apb_module[i].DisabledName  = gnv_data.ids_getting_started.GetItemString(li_find,'disable_picture')
		apb_module[i].powertiptext  = gnv_data.ids_getting_started.GetItemString(li_find,'tips')
	Else
		apb_module[i].Tag = ''
		apb_module[i].DisabledName = ''
		apb_module[i].PictureName  = ''
		apb_module[i].powertiptext = ''
	End If
Next

Return 1
end function

public function integer of_set_access (picturebutton apb_module[]);Integer i
String ls_id
For i = 1 To UpperBound(apb_module[])
	ls_id = apb_module[i].tag
	Choose Case ls_id
		Case '1' //add_new_contract
			//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
			//If w_mdi.of_security_access( 2070 ) > 0 Then
			If w_mdi.of_security_access( 2070 ) = 2 and (w_mdi.of_security_access( 6955 ) = 1 or w_mdi.of_security_access( 6988 ) = 1 ) Then //New CTX or use Template
			//---------End Modfiied ------------------------------------------------------
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			Else
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"
			End If
			
		Case '2' //search_for_contract
			//N/A
			//---------Begin Added by (Appeon)Harry 10.24.2014 for BugH102202--------
			If w_mdi.of_security_access( 2070 ) <> 0 then
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			Else
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"
			End if
			//---------End Added ------------------------------------------------------
		Case '3' //search_for_document
			//N/A
			
		Case '4' //full_text_search
			IF gs_dbtype = "SQL" AND gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' AND w_mdi.of_security_access( 2076 ) > 0 AND gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' THEN		
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			ELSE
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"
			END IF
			
		Case '5' //view_calendar
			If w_mdi.of_security_access(6957) > 0 Then
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			Else
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"
			End If
			
		Case '6' //configure_email
			//N/A
			//Begin - Added By Mark Lee 05/19/12
			If w_mdi.of_security_access(6931) > 0 Then
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			Else
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"
			End If
			//End - Added By Mark Lee 05/19/12

			
		Case '7' //email_templates
			IF w_mdi.of_security_access( 5831 ) > 0 THEN
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			Else
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"
			End If
			
		Case '8' //manage_users
			IF w_mdi.of_security_access( 900 ) > 0 THEN
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			Else
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"
			End If
			
		Case '9' //customize_screens
			IF w_mdi.of_security_access( 5300 ) > 0 THEN
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			Else
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"
			End If
			
		Case '10' //edit_lookup_tables
			IF w_mdi.of_security_access( 560 ) > 0 THEN
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			Else
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"
			End If
			
		Case '11' //View Contacts
			If w_mdi.of_security_access( 6930 ) = 0 Then 
				apb_module[i].enabled = False
				apb_module[i].Pointer = "Arrow!"				
			Else
				apb_module[i].enabled = True
				apb_module[i].Pointer = "HyperLink!"
			End If
	End Choose
Next


Return 1
end function

public function string of_get_tips (string as_id);String ls_tips
Choose Case as_id
	Case '1','1,0','1,1' //add_new_contract
		ls_tips = 'Add A New Contract - Add a new contract record into the system.'
		
	Case '2' //search_for_contract
		ls_tips = 'Search For A Contract - Search for a contract record in the system.'
		
	Case '3' //search_for_document
		ls_tips = 'Search For Document - Search for a document attached to a contract record by name.'
		
	Case '4' //full_text_search
		ls_tips = 'Full Text Search - Search for text/language with the documents attached to your contract records.'
		
	Case '5' //view_calendar
		ls_tips = 'View Calendar - Display contract record Action Items and Data Alarm in Calendar format/view.'
		
	Case '6' //configure_email
		ls_tips = 'Configure Email - Configure your email settings to send email, alerts and document from system.'

	Case '7' //email_templates
		ls_tips = 'Email Templates - Add, Edit and Maintain Email Templates to streamline emailing out of the system.'
		
	Case '8' //manage_users
		ls_tips = 'Manager User - Maintain Users accessing the system.'

	Case '9' //customize_screens
		ls_tips = 'Customize Screens - Add fields, modify field labels, remove fields from contract data screens.'
		
	Case '10' //edit_lookup_tables
		ls_tips = 'Edit Lookup Tables - Maintain drop-down menus and lookup tables.'
	
	Case '11' //View Contacts
		ls_tips = 'Manager Contacts - Maintain your customer, vendor and internal contact data.'

End Choose


Return ls_tips


end function

public function integer of_initgettingstart (string as_userid, ref datastore ads_gettingstart);//====================================================================
//$<Function>: of_initgettingstart
//$<Arguments>:
// 	value        string       as_userid               
// 	reference    datastore    ads_gettingstart return datastore reference,controled in the transaction
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Toney 09.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
String ls_sort

//Check parameters
IF IsNull(as_userid) OR LenA(as_userid) = 0 THEN
	Messagebox('Getting Started','user id is not allowed to be null.')
	Return -1
END IF
//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("getting_started_data", FALSE)
//If gnv_data.ids_getting_started.rowcount() = 0 Then gnv_data.of_retrieve("getting_started_data") 
//------------------------------------------------------------------------
If gnv_data.ids_getting_started.rowcount() = 0 Then
	Messagebox('Getting Started','Failed to get Getting Started data, please call support.')
	Return -1
End If
//----------------------2.25.2016 RP added for just-in-time cache service-----------------------------
gnv_data.of_initCache("dashboard_getting_started")
//------------------------------------------------------------------------------------------------------------
//Create Getting Start DataStore
ads_gettingstart = create DataStore
ads_gettingstart.dataobject = gnv_data.ids_dashboard_getting_started.dataobject
ads_gettingstart.SetTransObject(sqlca)
//Retrieve data,not need to initialize
IF ads_gettingstart.retrieve(as_userid) > 0 THEN Return 1
//Init data	
For i = 1 To gnv_data.ids_getting_started.rowcount()
	ls_sort += String(gnv_data.ids_getting_started.GetItemNumber(i,'id') ) + ','
Next
ls_sort = Mid(ls_sort,1,len(ls_sort) - 1)
ads_gettingstart.InsertRow(0)
ads_gettingstart.SetItem(1,'user_id',as_userid)
ads_gettingstart.SetItem(1,'sort_result',ls_sort)
ads_gettingstart.SetItem(1,'display_columns',2)

Return 1
end function

on n_cst_getting_started.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_getting_started.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

