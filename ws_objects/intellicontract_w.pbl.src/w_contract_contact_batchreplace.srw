$PBExportHeader$w_contract_contact_batchreplace.srw
$PBExportComments$[intellicontract_w] Contact Maintence window
forward
global type w_contract_contact_batchreplace from w_popup
end type
type cb_output from commandbutton within w_contract_contact_batchreplace
end type
type cb_refresh from commandbutton within w_contract_contact_batchreplace
end type
type cb_select from commandbutton within w_contract_contact_batchreplace
end type
type dw_type from u_dw within w_contract_contact_batchreplace
end type
type cb_update from commandbutton within w_contract_contact_batchreplace
end type
type cb_cancel from commandbutton within w_contract_contact_batchreplace
end type
type dw_list from u_dw within w_contract_contact_batchreplace
end type
end forward

global type w_contract_contact_batchreplace from w_popup
integer width = 3671
integer height = 2124
string title = " Contract Contact Batch Update"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
cb_output cb_output
cb_refresh cb_refresh
cb_select cb_select
dw_type dw_type
cb_update cb_update
cb_cancel cb_cancel
dw_list dw_list
end type
global w_contract_contact_batchreplace w_contract_contact_batchreplace

type variables
Long				il_contact_ID
n_ds				ids_UpdateContact
end variables

on w_contract_contact_batchreplace.create
int iCurrent
call super::create
this.cb_output=create cb_output
this.cb_refresh=create cb_refresh
this.cb_select=create cb_select
this.dw_type=create dw_type
this.cb_update=create cb_update
this.cb_cancel=create cb_cancel
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_output
this.Control[iCurrent+2]=this.cb_refresh
this.Control[iCurrent+3]=this.cb_select
this.Control[iCurrent+4]=this.dw_type
this.Control[iCurrent+5]=this.cb_update
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.dw_list
end on

on w_contract_contact_batchreplace.destroy
call super::destroy
destroy(this.cb_output)
destroy(this.cb_refresh)
destroy(this.cb_select)
destroy(this.dw_type)
destroy(this.cb_update)
destroy(this.cb_cancel)
destroy(this.dw_list)
end on

event open;call super::open;
dw_list.SetTransObject( SQLCA )
ids_UpdateContact = Create n_ds

ids_UpdateContact.DataObject = 'ds_contract_contact_bacthlist'

//gnv_appeondb.of_startqueue( )

dw_type.Event pfc_Retrieve( )
dw_list.Event pfc_Retrieve( )

This.Title = ' Contract Contact Batch Update - [Contact ID: ' + string( il_contact_ID ) + ']'
//gnv_appeondb.of_commitqueue( )


If w_mdi.of_security_access( 6983 )  > 0 Then
Else
	MessageBox( this.Title, 'You don’t have the permission to do the batch update.' )
	cb_Update.Enabled = false
End If
end event

event pfc_preopen;call super::pfc_preopen;il_contact_ID = Long( Message.StringParm )
end event

event closequery;Destroy ids_UpdateContact
end event

type cb_output from commandbutton within w_contract_contact_batchreplace
integer x = 2117
integer y = 1920
integer width = 434
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Out&Put Options"
end type

event clicked;m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(dw_list)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
NewMenu.m_options.PopMenu(Parent.pointerx(),Parent.pointerY())
end event

type cb_refresh from commandbutton within w_contract_contact_batchreplace
integer x = 2551
integer y = 1920
integer width = 347
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;dw_List.Event pfc_Retrieve( )
end event

type cb_select from commandbutton within w_contract_contact_batchreplace
integer x = 37
integer y = 1920
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Deselect All"
end type

event clicked;Int			li_value
Long		ll_i

If dw_list.RowCount( ) > 0 Then
	
	If This.Text = '&Deselect All' Then
		this.Text = '&Select All'
		li_value = 0
	Else
		This.Text = '&Deselect All'
		li_value = 1
	End If
	
	For ll_i = 1 To dw_List.RowCount( )
		dw_list.SetItem( ll_i, 'selected' , li_value )		
	Next	
	dw_List.SetItemStatus( ll_i, 0, primary!, notmodified! )
End If
end event

type dw_type from u_dw within w_contract_contact_batchreplace
integer x = 23
integer y = 36
integer width = 3648
integer height = 224
integer taborder = 20
string dataobject = "d_contract_contact_bacthupdate"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event pfc_retrieve;call super::pfc_retrieve;If Rowcount( ) = 0 Then
	Return InsertRow( 0 )
End If
return 0
end event

event buttonclicked;call super::buttonclicked;str_pass 	lstr_pass
String		ls_Company
long ll_contact_id,ll_access

////Add group access - jervis 11.26.2010
//if (as_string = 'EXTERNAL' OR as_string = 'INTERNAL') and adw.GetRow() > 0 then
//	ll_contact_id = adw.GetItemNumber(adw.GetRow(),"contact_id")
//	select 1 into :ll_access	
//	FROM ctx_contacts left join ctx_contact_group_access on (ctx_contacts.contact_id = ctx_contact_group_access.contact_id and ctx_contacts.contact_id = :ll_contact_id) 
//								left join security_group_users on (ctx_contact_group_access.group_id = security_group_users.group_id)
//	WHERE  (((ctx_contact_group_access.Access <> 'N' or ctx_contact_group_access.Access is null) and 
//		 Upper(security_group_users.user_id) = Upper(:gs_user_id)) or security_group_users.user_id is null) ;
//
//
//	if ll_access <> 1 then
//		MessageBox("information","The current user does not have permission to view the contact information.")
//		return 1
//	end if
//end if
If row <= 0 Then Return

If GetItemNumber( row, 'class' ) <> 1 Then Return

lstr_pass.s_u_dw = This

if IsNull(ls_Company) then ls_Company = '0'

lstr_pass.s_string_array[1]  = ls_Company// company name id of the contract
lstr_pass.s_string = 'Select_New_Contact' // as_string 'EXTERNAL'

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.24.2007 By: Davis
lstr_pass.display_contact_detail = false
//---------------------------- APPEON END ----------------------------

OpenWithParm ( w_contract_contact, lstr_pass)



end event

event itemchanged;call super::itemchanged;If dwo.Name = 'class' Then
	AcceptText( )
	If data = '1' Then
		Modify( "b_1.enabled='yes'" )
	Else
		Modify( "b_1.enabled='no'" )
	End If
	
End If
end event

event losefocus;call super::losefocus;AcceptText( )
end event

event constructor;call super::constructor;Modify( "b_1.enabled=false" )
end event

type cb_update from commandbutton within w_contract_contact_batchreplace
integer x = 2898
integer y = 1920
integer width = 379
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Update"
end type

event clicked;If dw_List.RowCount( ) = 0 Then Return
If dw_type.RowCount( ) = 0 Then Return

Long				ll_k, ll_i, ll_CtxID[], ll_FRow, ll_Count
Long				ll_New_Contact_ID, ll_Type
Long				ll_Or_contact_ID , ll_ctx_ID
String				ls_Result, ls_ContactType


ll_Type = dw_Type.GetItemNumber( dw_Type.GetRow( ), 'class' ) 


If dw_List.Find( "selected = 1 ", 1, dw_List.RowCount( ) ) =0 Then
	MessageBox( 'Tips', 'Please select the contract that you want to replace or delete!' )
	Return	
End If

If dw_List.Find( " not( result = '1' Or result = '0' ) and selected > 0 ", 1, dw_List.RowCount( ) ) =0 Then
	Return	
End If	
	
ll_CtxID = dw_List.object.ctx_id.current
ids_UpdateContact.SetTransObject( sqlca )
ids_UpdateContact.Retrieve( ll_CtxID )

If ll_Type = 0 Then //delete
	For ll_i = 1 To dw_List.RowCount( )
		
		If dw_List.GetItemNumber( ll_i, 'selected' ) = 1 and not( dw_List.GetItemString( ll_i, 'result' ) = '1' or dw_List.GetItemString( ll_i, 'result' ) = '0' ) Then
			ls_ContactType = 	dw_List.GetItemString( ll_i, 'ic_area' )		
			ll_ctx_ID = dw_List.GetItemNumber( ll_i, 'ctx_id' )
			ll_Or_contact_ID = dw_List.GetItemNumber( ll_i, 'contact_id' )
			ll_FRow = ids_UpdateContact.Find( "ctx_id=" + string( ll_ctx_id) + " and contact_id=" + string( ll_Or_contact_ID ) + " and ic_area ='" + ls_ContactType + "'", 1, ids_UpdateContact.RowCount( ) )
			If ll_FRow > 0 Then
				ll_Count = ids_UpdateContact.GetItemNumber( ll_Frow, 'rec' )			
				If ll_Count = 1 And  ids_UpdateContact.GetItemString( ll_FRow, 'ic_area' ) <> 'C' Then
					dw_List.SetItem( ll_i, 'result', 'It failed to delete the contact. You need to keep at lest one contact for the contract.' )
				ElseIf ll_Count > 1 Then
					//  check  it if owner   or  default  
					If ids_UpdateContact.GetItemString( ll_FRow, 'owner' ) = 'Y'  and  ids_UpdateContact.GetItemString( ll_FRow, 'ic_area' ) = 'I' Then
						dw_List.SetItem( ll_i, 'result', 'It failed to delete the contact. The contact is the contract owner.' )
					ElseIf ids_UpdateContact.GetItemString( ll_FRow, 'default_email' ) = 'Y' and  ids_UpdateContact.GetItemString( ll_FRow, 'ic_area' ) = 'I' Then
						dw_List.SetItem( ll_i, 'result', 'It failed to delete the contact. The contact is the default contact.' )
					ElseIf ids_UpdateContact.GetItemString( ll_FRow, 'default_email' ) = 'Y' and ( ids_UpdateContact.GetItemString( ll_FRow, 'ic_area' ) = 'E'  and  ids_UpdateContact.GetItemNumber( ll_FRow, 'default_count' )  <= 1 ) Then
						dw_List.SetItem( ll_i, 'result', 'It failed to delete the contact. The contact is the default contact.' )	
					Else
						ids_UpdateContact.DeleteRow( ll_FRow )
						dw_List.SetItem( ll_i, 'result', '1' )
					End If
					//attention  :  caution : replace contact   include  user_d   default_email  etc.
				Else
					ids_UpdateContact.DeleteRow( ll_FRow )
					dw_List.SetItem( ll_i, 'result', '1' )
				End If
			Else
				dw_List.SetItem( ll_i, 'result', 'The contact can not be found.' )
			End If	
		End If
	Next

ElseIf ll_Type = 1 Then //replace
	ll_New_Contact_ID = dw_Type.GetItemNumber( dw_Type.GetRow( ), 'contact_id' )
	
	If IsNull( ll_New_Contact_ID ) Or ll_New_Contact_ID = 0 Then
		MessageBox( 'Tips' , 'Please select one target contact.' )
		Return
	End If
	For ll_i = 1 To dw_List.RowCount( )
		
		If dw_List.GetItemNumber( ll_i, 'selected' ) = 1 and not( dw_List.GetItemString( ll_i, 'result' ) = '1' or dw_List.GetItemString( ll_i, 'result' ) = '0' ) Then
			ls_ContactType = 	dw_List.GetItemString( ll_i, 'ic_area' )		
			ll_ctx_ID = dw_List.GetItemNumber( ll_i, 'ctx_id' )
			ll_Or_contact_ID = dw_List.GetItemNumber( ll_i, 'contact_id' )
			
			ll_FRow = ids_UpdateContact.Find( "ctx_id=" + string( ll_ctx_id) + " and contact_id=" + string( ll_New_Contact_ID ) + " and ic_area ='" + ls_ContactType + "'", 1, ids_UpdateContact.RowCount( ) )
			If ll_FRow >0 Then
				dw_List.SetItem( ll_i, 'result', 'It failed to replace. The target contact is already in the contract’s contact list.' )
				Continue
			End If
			
			ll_FRow = ids_UpdateContact.Find( "ctx_id=" + string( ll_ctx_id) + " and contact_id=" + string( ll_Or_contact_ID ) + " and ic_area ='" + ls_ContactType + "'", 1, ids_UpdateContact.RowCount( ) )
			If ll_FRow > 0 Then
				ll_Count = ids_UpdateContact.GetItemNumber( ll_Frow, 'rec' )			
				If ids_UpdateContact.GetItemString( ll_FRow, 'owner' ) = 'Y'  and  ids_UpdateContact.GetItemString( ll_FRow, 'ic_area' ) = 'I' Then
					If dw_Type.GetItemString(dw_Type.GetRow( ),"user_d") = '' or Isnull(dw_Type.GetItemString(dw_Type.GetRow( ),"user_d")) Then
						dw_List.SetItem( ll_i, 'result', 'It failed to replace. The original contact is the contract owner but the target contact is not the contract owner.' )
					Else
						ids_UpdateContact.SetItem( ll_FRow, 'contact_id', ll_New_Contact_ID )
						ids_UpdateContact.SetItem( ll_FRow, 'association', dw_Type.GetItemString(dw_Type.GetRow( ),"association") )
						dw_List.SetItem( ll_i, 'result', '0' )
					End If					
				Else
					ids_UpdateContact.SetItem( ll_FRow, 'contact_id', ll_New_Contact_ID )
					ids_UpdateContact.SetItem( ll_FRow, 'association', dw_Type.GetItemString(dw_Type.GetRow( ),"association") )
					dw_List.SetItem( ll_i, 'result', '0' )
				End If
			Else
				dw_List.SetItem( ll_i, 'result', 'The contact can not be found.' )
			End If
		End If
	Next
End If

If ids_UpdateContact.Update( ) <> 1 Then
	MessageBox( 'Tips', sqlca.sqlerrtext )
	Return
End If
If MessageBox( 'Tips', 'Batch replacing or deleting is completed. Do you want to refresh the contract list now?', question!, yesno! ) = 1 Then
	cb_Refresh.Event Clicked( )
	
End If





end event

type cb_cancel from commandbutton within w_contract_contact_batchreplace
integer x = 3278
integer y = 1920
integer width = 347
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;close( parent )
end event

type dw_list from u_dw within w_contract_contact_batchreplace
integer x = 32
integer y = 288
integer width = 3602
integer height = 1592
integer taborder = 10
string dataobject = "d_contract_contact_bacthlist"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event pfc_retrieve;call super::pfc_retrieve;This.Retrieve( il_contact_ID )

Return 1
end event

