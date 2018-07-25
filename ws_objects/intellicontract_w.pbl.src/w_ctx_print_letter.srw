$PBExportHeader$w_ctx_print_letter.srw
$PBExportComments$[INTELLICONTRACT_W] ui  for the user to select what letter to print.
forward
global type w_ctx_print_letter from w_response
end type
type cb_4 from commandbutton within w_ctx_print_letter
end type
type cb_3 from u_cb within w_ctx_print_letter
end type
type cb_2 from u_cb within w_ctx_print_letter
end type
type cb_1 from u_cb within w_ctx_print_letter
end type
type dw_1 from u_dw within w_ctx_print_letter
end type
end forward

global type w_ctx_print_letter from w_response
integer width = 2775
integer height = 1280
string title = "Print Letters"
long backcolor = 33551856
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_ctx_print_letter w_ctx_print_letter

type variables
str_pass istr_pass

n_cst_string inv_string

end variables

forward prototypes
public function integer of_print_letter (long row_start, long row_end)
end prototypes

public function integer of_print_letter (long row_start, long row_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_print_letter
//
//	Arguments:  
//
//	Returns:  integer
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version By Jervis
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
string ls_doc,ls_action_desc
long ll_use_export,ll_ret,ll_i,ll_count
datetime ldt_today
long ll_ctx_id[],ll_action_item_id[],ll_export_id[],ll_doc_id[]

if row_end < 1 then return 1

//Get the name of document 
ls_doc = dw_1.GetItemString(row_start,"document_name")
ls_action_desc = dw_1.GetItemString(row_start,"action_description")

If Not f_validstr(ls_doc) Then
	MessageBox('Missing Document Name', 'The Action Item Type you have selected does not have a Word Document associated with it.  To associate a Word document with this Action Item Type go to the System->Painters->Lookup Painter and fill in the Word document field of the lookup record.')
	Return -1
End If



ll_use_export = dw_1.GetItemNumber(row_start,"use_export")
ll_export_id[1] = dw_1.GetItemNumber(row_start,"export_id")



//Print the Document
n_cst_ctx_letter  lnv_ctx_letter
lnv_ctx_letter = create n_cst_ctx_letter

//Get Ctx_id,Action Item_ID or Export_ID
ll_count = 1
if istr_pass.s_string = "d_ai_letter" then
	for ll_i = row_start to  row_end
		ll_ctx_id[ll_count] = dw_1.GetItemNumber(ll_i,"ctx_id")
		ll_action_item_id[ll_count] = dw_1.GetItemNumber(ll_i,"ctx_action_item_id")
		ll_count++
	next
	if ll_use_export = 1 then	//From Export Painter Data
		ll_ret = lnv_ctx_letter.of_export_letter(ls_doc,0,ll_ctx_id,ll_doc_id,ll_export_id)
	else								//From Contract Data
		ll_ret = lnv_ctx_letter.of_export_letter(ls_doc,1,ll_ctx_id,ll_doc_id,ll_action_item_id)
	end if
elseif istr_pass.s_string = "d_doc_letter" then
	for ll_i = row_start to  row_end
		ll_ctx_id[ll_count] = dw_1.GetItemNumber(ll_i,"ctx_id")
		ll_doc_id[ll_count] = dw_1.GetItemNumber(ll_i,"doc_id")
		ll_action_item_id[ll_count] = dw_1.GetItemNumber(ll_i,"seq_id")
		ll_count++
	next
	if ll_use_export = 1 then	//From Export Painter Data
		ll_ret = lnv_ctx_letter.of_export_letter(ls_doc,0,ll_ctx_id,ll_doc_id,ll_export_id)
	else								//From Contract Data
		ll_ret = lnv_ctx_letter.of_export_letter(ls_doc,2,ll_ctx_id,ll_doc_id,ll_action_item_id)
	end if
end if

destroy lnv_ctx_letter

//Update number of print
if ll_ret = 1 then
	//If MessageBox(This.Title,'Did the letters print ok?', question!,yesNo!,1) <> 1 Then
	//	return 0
	//end if
		
	ldt_today = f_get_server_dtm()
	for ll_i = row_start to row_end
		dw_1.SetItem(ll_i,"print_flag",-1)
		
		if not f_validstr(string(dw_1.GetItemDatetime(ll_i,"first_attempt"))) then
				dw_1.SetItem(ll_i,"first_attempt",ldt_today)
		end if 		
		dw_1.SetItem(ll_i,"last_attempt",ldt_today)
		if istr_pass.s_string = "d_ai_letter" then
			ll_count = dw_1.GetItemNumber(ll_i,"no_attempts")
			if isnull(ll_count) or ll_count < 1 then
				dw_1.SetItem(ll_i,"no_attempts",1)
			else
				dw_1.SetItem(ll_i,"no_attempts",ll_count + 1)
			end if 
		elseif istr_pass.s_string = "d_doc_letter" then
			ll_count = dw_1.GetItemNumber(ll_i,"attempt_times")
			if isnull(ll_count) or ll_count < 1 then
				dw_1.SetItem(ll_i,"attempt_times",1)
			else
				dw_1.SetItem(ll_i,"attempt_times",ll_count + 1)
			end if 
		end if 
	next
	
	dw_1.accepttext( )
	gnv_appeondb.of_autocommitrollback( )
	if dw_1.UPDATE() = 1 then
		commit;
	else
		rollback;
	end if
else
	MessageBox("Letter error","Failed to print letter.")
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lnv_ctx_letter) then Destroy lnv_ctx_letter
//---------------------------- APPEON END ----------------------------

return ll_ret



end function

on w_ctx_print_letter.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_ctx_print_letter.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event pfc_postopen;call super::pfc_postopen;



//////////////////////////////////////////
// catch the structure 
//////////////////////////////////////////
if isvalid(message.powerobjectparm) then 
    istr_pass = message.powerobjectparm
end if

dw_1.dataobject = istr_pass.s_string
dw_1.SetTransObject(sqlca)
dw_1.retrieve(istr_pass.action_items)

gnv_win_backcolor.of_ChangeWindowBackColor(this) //Add by Evan 11/24/2008
end event

type cb_4 from commandbutton within w_ctx_print_letter
integer x = 2395
integer y = 1084
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
end type

event clicked;Close(Parent)
end event

type cb_3 from u_cb within w_ctx_print_letter
boolean visible = false
integer x = 928
integer y = 1336
integer taborder = 20
end type

type cb_2 from u_cb within w_ctx_print_letter
boolean visible = false
integer x = 512
integer y = 1340
integer taborder = 10
end type

type cb_1 from u_cb within w_ctx_print_letter
boolean visible = false
integer x = 128
integer y = 1332
integer taborder = 10
end type

type dw_1 from u_dw within w_ctx_print_letter
integer x = 18
integer y = 20
integer width = 2720
integer height = 1032
integer taborder = 10
string dataobject = "d_ai_letter"
end type

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
**  Created By	: Michael B. Skinner xx August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

/*
String ls_run_path
String ls_open_merge
String ls_doc
String ls_filter
String Var1
String  ls_return
Long ll_i
Long ll_attempts
*/

string ls_doc
long ll_use_export,ll_export_id

Choose Case dwo.Name
	Case 'b_print_letter'
		/*
		n_cst_ctx_letter  invo_ctx_letters
		invo_ctx_letters =  Create n_cst_ctx_letter
		
		istr_pass.s_string = This.GetItemString(row,'custom_6')
		
		ls_return  = invo_ctx_letters.of_start(istr_pass)
		
		
		
		If ls_return <> 'success' Then
			MessageBox(iw_parent.Title, ls_return)
			Return failure
		End If
		
		If MessageBox(Parent.Title,'Did the letters print ok?', question!,yesNo!,1) = 1 Then
			Var1 = This.Object.custom_6[row]
			SetFilter("custom_6 = '"+ Var1 +" '")
			Filter()
			For ll_i = 1 To RowCount()
				//Start Change 01.22.2007 By Jervis
				//setitem(ll_i,'print_flag',1)
				SetItem(ll_i,'print_flag',-1)
				//End Change
				// set the attempt dates
				If Not f_validstr(String(GetItemDate(ll_i,'first_attempt'))) Then
					SetItem(ll_i,'first_attempt',Date(f_get_server_dtm()))
					SetItem(ll_i,'last_attempt',Date(f_get_server_dtm()))
				Else
					SetItem(ll_i,'last_attempt',Date(f_get_server_dtm()))
				End If
				// print flag
				//object.print_flag[ll_i] = 1
				
				// set the number of attempts
				
				ll_attempts = GetItemNumber(ll_i,'no_attempts')
				
				If Not f_validstr(String(ll_attempts)) Or ll_attempts = 0 Then
					SetItem(ll_i,'no_attempts',1)
				Else
					SetItem(ll_i,'no_attempts',1 + ll_attempts)
				End If
				
			Next
			
			Parent.of_update( True,True)
			
		End If
		*/
		
		//Add Code by Jervis 01.27.2007
		if row > 0 then
			ls_doc  = this.GetItemString(row,"document_name")
			ll_use_export = this.GetItemNumber(row,"use_export")
			ll_export_id = this.GetItemNumber(row,"export_id")

			 
			dw_1.SetRedraw(false)
			if isnull(ll_use_export) and not isnull(ll_export_id) then
				dw_1.SetFilter( "document_name ='" + ls_doc + "' and isnull(use_export) and export_id =" + string(ll_export_id) )
			elseif not isnull(ll_use_export) and isnull(ll_export_id) then
				dw_1.SetFilter( "document_name ='" + ls_doc + "' and (use_export =" + string(ll_use_export) + ") and isnull(export_id)" )
			elseif isnull(ll_use_export) and isnull(ll_export_id) then
				dw_1.SetFilter( "document_name ='" + ls_doc + "' and isnull(use_export) and isnull(export_id)" )
			else
				dw_1.SetFilter( "document_name ='" + ls_doc + "' and (use_export =" + string(ll_use_export) + ") and export_id =" + string(ll_export_id) )
			end if
			dw_1.Filter()
			of_print_letter(1,dw_1.RowCount())
			
			//Clear Filter
			dw_1.SetFilter("")
			dw_1.Filter()
			dw_1.retrieve(istr_pass.action_items)
			dw_1.SetRedraw(true)
		end if
	Case Else
		
End Choose

Return success

end event

