$PBExportHeader$w_em_import_msg.srw
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type w_em_import_msg from w_response
end type
type st_info from statictext within w_em_import_msg
end type
type cb_clipboard from commandbutton within w_em_import_msg
end type
type cb_outlook from commandbutton within w_em_import_msg
end type
type dw_1 from u_dw within w_em_import_msg
end type
type cb_cancel from commandbutton within w_em_import_msg
end type
type cb_ok from commandbutton within w_em_import_msg
end type
type cb_paste from commandbutton within w_em_import_msg
end type
type cb_select from commandbutton within w_em_import_msg
end type
type gb_1 from groupbox within w_em_import_msg
end type
end forward

global type w_em_import_msg from w_response
integer width = 2135
integer height = 900
string title = "Import Email Item"
long backcolor = 33551856
event ue_command pbm_syscommand
event ue_mail_paste ( string as_tag )
st_info st_info
cb_clipboard cb_clipboard
cb_outlook cb_outlook
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
cb_paste cb_paste
cb_select cb_select
gb_1 gb_1
end type
global w_em_import_msg w_em_import_msg

type variables
str_import_msg istr_import_msg
DatawindowChild idwc_folder
end variables

forward prototypes
public function integer of_disable_ctx_flds ()
end prototypes

event ue_command;If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

event ue_mail_paste(string as_tag);//====================================================================
// Event: ue_mail_paste
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_tag
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/01/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String ls_ext
String ls_filepath
String ls_filename
String ls_fullname
n_cst_appeondll lnv_appeondll
oleobject lole_outlook, lole_item
String 	ls_null, ls_array[]
Long 		ll_FileLen, li_rc, ll_count, i 
Boolean	lbn_rtn
Integer 	li_return

Setnull(ls_null)
lbn_rtn = False 
If isnull(as_tag) or trim(as_tag) = "" Then 
	Return 
End IF 

ls_filename = SPACE(256)
ls_filepath = gs_dir_path + gs_DefDirName + "\Email\POP3\Temp\"
lnv_appeondll.of_parsepath( ls_filepath )
IF NOT DirectoryExists(ls_filepath) THEN 
	Messagebox('Email','Failed to create the Email temp directory '+ls_filepath+', please call support.')
	Return 
End If

istr_import_msg.as_paste_way = as_tag				//Added By Mark Lee 07/01/2013
istr_import_msg.as_filename[] = ls_array			//Added By Mark Lee 07/03/2013
dw_1.SetItem( 1, "filename", "" ) 
dw_1.SetItem( 1, "fullname", "" )   //Added By Ken.Guo 08/30/2013
ls_filename = ""
st_info.text = '' //Added By Ken.Guo 08/30/2013
Choose Case as_tag
	Case 'clipboard'
	IF lnv_appeondll.of_pastefromclipboard( ls_filepath, ls_filename) > 0 THEN
		ls_ext = Mid(ls_filename,lastpos(ls_filename,'.') + 1, len(ls_filename))
		If Lower(ls_ext) <> 'msg' Then
			Messagebox('Paste', 'Unspport the *.' + ls_ext + ' file, only the *.msg file is supported to copy.')
			Return 
		End If
		ls_fullname = ls_filepath + ls_filename
		IF FileExists(ls_fullname) THEN
			dw_1.SetItem( 1, "filename", ls_filename ) 
			dw_1.SetItem( 1, "fullname", ls_fullname ) 
			cb_ok.Enabled = TRUE
		END IF
		st_info.text = 'There is an email attached. Please click OK to import it.' //Added By Ken.Guo 08/30/2013
	END IF
	Case 'outlook'
		SetPointer(HourGlass!)					//Added By Mark Lee 07/12/2013
		//Messagebox('Contract Logix', 'During the import, the MS Outlook may pop up a message box. Please always click the Allow button.')		//Added By Mark Lee 07/12/2013 //Commented by (Appeon)Harry 01.22.2014 - V142 ISG-CLX
		Messagebox('IntelliSoft', 'During the import, the MS Outlook may pop up a message box. Please always click the Allow button.')		//(Appeon)Harry 01.22.2014 - V142 ISG-CLX
		Try
			lole_outlook = Create oleobject
			li_rc = lole_outlook.Connecttonewobject("Outlook.Application") 
			IF li_rc <> 0 THEN
				Destroy lole_outlook
				SetPointer(Arrow!)				//Added By Mark Lee 07/12/2013
				Messagebox('Client Error', 'Could not connect to Outlook. Please make sure it is properly installed.'+' (Error: ' + String(li_rc)+'" ')
				RETURN
			END IF
			
			If Not isvalid(lole_outlook.ActiveExplorer) or isnull(lole_outlook.ActiveExplorer) Then
				lole_outlook.DisconnectObject()
				Destroy lole_outlook		
				SetPointer(Arrow!)				//Added By Mark Lee 07/12/2013
				messagebox('Paste mail','Please check if the MS Outlook is started and you have highlighted the corresponding email item.')
				Return
			End If
			
			If Not isvalid(lole_outlook.ActiveExplorer.Selection) or  isnull(lole_outlook.ActiveExplorer.Selection) Then 
				lole_outlook.DisconnectObject()		
				Destroy lole_outlook
				SetPointer(Arrow!)				//Added By Mark Lee 07/12/2013
				messagebox('Paste mail (2)','Please check if the MS Outlook is started and you have highlighted the corresponding email item.')
				Return 
			End If
			
			If Long(lole_outlook.ActiveExplorer.Selection.Count) = 0 Then 
				lole_outlook.DisconnectObject()
				Destroy lole_outlook
				SetPointer(Arrow!)				//Added By Mark Lee 07/12/2013
				messagebox('Paste mail (3)','Please check if the MS Outlook is started and you have highlighted the corresponding email item.')
				Return
			End If

			ll_count =	Long(lole_outlook.ActiveExplorer.Selection.count)
			For i = 1  to ll_count			 	
				lole_item= lole_outlook.ActiveExplorer.Selection.item[i]
				//mail
				If lole_item.class = 43 or lole_item.class = 45 Then //MailItem
					IF Isnull(ls_filename) or trim(ls_filename) = '' Then  
						ls_filename = lole_item.Subject		
					Else
						ls_filename = ls_filename + '; '+lole_item.Subject		
					End IF 
					ls_fullname = ls_filepath +'paste_temp'+String(i)+'.msg'
					istr_import_msg.as_filename[i] = ls_fullname	 
				
					IF FileExists(ls_fullname) Then 
						lbn_rtn =  FileDelete(ls_fullname) 
						IF Not lbn_rtn Then 
							dw_1.SetItem( 1, "filename", "" )  
							lole_outlook.DisconnectObject()
							Destroy lole_outlook
							destroy	lole_item	 
							SetPointer(Arrow!)				//Added By Mark Lee 07/12/2013
							MessageBox("Paste mail","Failed to delete the temporary file("+ls_fullname+"). ~r~n~r~nPlease delete the corresponding temporary file manually." )
							Return 
						End IF 
					End IF 
					lole_item.saveas(ls_fullname, 3)
					//confirm the saveas function successful.
					IF FileExists(ls_fullname) Then 
						dw_1.SetItem( 1, "filename", ls_filename ) 
						dw_1.SetItem( 1, "fullname", ls_fullname ) 
						cb_ok.Enabled = TRUE
					Else
						dw_1.SetItem( 1, "filename", "" )  
						lole_outlook.DisconnectObject()
						Destroy lole_outlook
						destroy	lole_item	 
						SetPointer(Arrow!)				//Added By Mark Lee 07/12/2013
						MessageBox("Paste mail","Failed to save the temporary file" )
						Return 
					End IF 
				//open file
				//				 ll_FileLen = ShellExecuteA ( Handle( This ), "open",ls_fullname , ls_Null, ls_Null, 4)	
				Else
					dw_1.SetItem( 1, "filename", "" )  
					lole_outlook.DisconnectObject()
					Destroy lole_outlook
					destroy	lole_item	 
					SetPointer(Arrow!)				//Added By Mark Lee 07/12/2013
					//				messagebox('Paste mail',"no mail item("+String(lole_item.class )+") in the Outlook.")
					messagebox('Paste mail'," Please select the mail item you want to paste in MS Outlook.")
					Return 
				End If
			Next	 
			lole_outlook.DisconnectObject()
			destroy lole_outlook
			destroy	lole_item	
			
			//Added By Ken.Guo 08/30/2013
			If UpperBound(istr_import_msg.as_filename[]) = 1 Then
				st_info.text = 'There is an email attached. Please click OK to import it.' //Added By Ken.Guo 08/30/2013
			ElseIf UpperBound(istr_import_msg.as_filename[]) > 1 Then
				st_info.text = 'There are '+String(UpperBound(istr_import_msg.as_filename[]))+' emails attached. Please click OK to import them.'
			End If
			
			SetPointer(Arrow!)				//Added By Mark Lee 07/12/2013
		Catch (RuntimeError Err1)
			dw_1.SetItem( 1, "filename", "" )  
			Destroy lole_outlook	
			IF isvalid(lole_item) Then 			  
			destroy	lole_item	 
			End If
			SetPointer(Arrow!)				//Added By Mark Lee 07/12/2013
			messagebox('Paste mail',"An error occurred when pasting the email item.~r~n Error: "+Err1.text)
		End Try

End Choose 
end event

public function integer of_disable_ctx_flds ();//====================================================================
//$<Function>: of_disable_ctx_flds()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Disable ctx fields
//$<Author>: (Appeon) Eugene 09.23.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:for BugA082003  
// (Appeon)Harry 01.22.2014 - V142 ISG-CLX Copy from ISG14.1
//====================================================================

IF dw_1.Describe("ctx_id.ColType") <> "!" THEN
	dw_1.Modify("ctx_id.Protect=1")
	dw_1.Modify("ctx_id.Background.Color='553648127'")
END IF

IF dw_1.Describe("doc_id.ColType") <> "!" THEN
	dw_1.Modify("doc_id.Protect=1")
	dw_1.Modify("doc_id.Background.Color='553648127'")
END IF

IF dw_1.Describe("ai_id.ColType") <> "!" THEN
	dw_1.Modify("ai_id.Protect=1")
	dw_1.Modify("ai_id.Background.Color='553648127'")
END IF

RETURN 1
end function

on w_em_import_msg.create
int iCurrent
call super::create
this.st_info=create st_info
this.cb_clipboard=create cb_clipboard
this.cb_outlook=create cb_outlook
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_paste=create cb_paste
this.cb_select=create cb_select
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_info
this.Control[iCurrent+2]=this.cb_clipboard
this.Control[iCurrent+3]=this.cb_outlook
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.cb_paste
this.Control[iCurrent+8]=this.cb_select
this.Control[iCurrent+9]=this.gb_1
end on

on w_em_import_msg.destroy
call super::destroy
destroy(this.st_info)
destroy(this.cb_clipboard)
destroy(this.cb_outlook)
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_paste)
destroy(this.cb_select)
destroy(this.gb_1)
end on

event open;call super::open;//'Inbox','Sent Items','Favorite Items','History Items'

String ls_foldername[] = {'Inbox','Sent Items','Favorite Items','History Items'}
long ll_folderid[] = {2,3,5,6}
Long i,ll_row

istr_import_msg = Message.powerobjectparm

dw_1.InsertRow(0)
dw_1.GetChild('folder_id',idwc_folder)
For i = 1 To UpperBound(ls_foldername[])
	ll_row = idwc_folder.InsertRow(0)
	idwc_folder.SetItem(ll_row,'folder_id',ll_folderid[i])
	idwc_folder.SetItem(ll_row,'folder_label',ls_foldername[i])
	If ll_folderid[i] = istr_import_msg.al_folder_id Then
		dw_1.SetItem(1,'folder_id',istr_import_msg.al_folder_id)
	End If
Next

If istr_import_msg.al_ctx_id > 0 Then
	dw_1.SetItem(1,'ctx_id',istr_import_msg.al_ctx_id)
End If

If istr_import_msg.al_doc_id > 0 Then
	dw_1.SetItem(1,'doc_id',istr_import_msg.al_doc_id)
End If

If istr_import_msg.al_ai_id > 0 Then
	dw_1.SetItem(1,'ai_id',istr_import_msg.al_ai_id)
End If


end event

type st_info from statictext within w_em_import_msg
integer x = 64
integer y = 728
integer width = 1696
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_clipboard from commandbutton within w_em_import_msg
integer x = 114
integer y = 216
integer width = 695
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Windows Clipboard"
end type

event clicked;Parent.event ue_mail_paste( 'clipboard')


end event

type cb_outlook from commandbutton within w_em_import_msg
integer x = 114
integer y = 96
integer width = 695
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Selected MS Outlook Emails"
end type

event clicked;Parent.event ue_mail_paste('outlook')
end event

type dw_1 from u_dw within w_em_import_msg
integer x = 14
integer y = 376
integer width = 1669
integer height = 348
integer taborder = 10
string dataobject = "d_em_import_msg"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(False)

//---------Begin Added by (Appeon)Harry 01.22.2014 for V142 ISG-CLX-------- from ISG14.1
IF NOT gb_contract_module THEN	of_disable_ctx_flds ()  //for BugA082003  - (Appeon) Eugene 09.23.2013 (V141 ISG-CLX)
//---------End Added ------------------------------------------------------

end event

type cb_cancel from commandbutton within w_em_import_msg
integer x = 1728
integer y = 184
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;String ls_array[]

//Added By Mark Lee 07/03/2013
//istr_import_msg.as_filename = ''
istr_import_msg.as_filename =ls_array[]
istr_import_msg.as_filename[1] = ''
CloseWithReturn(Parent,istr_import_msg)
end event

type cb_ok from commandbutton within w_em_import_msg
integer x = 1733
integer y = 80
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&OK"
end type

event clicked;String ls_fullname
Long ll_ctx_id,ll_doc_id,ll_ai_id
Long 	ll_upperbound

dw_1.AcceptText()
ls_fullname = dw_1.GetitemString(1,'fullname')

IF NOT f_validstr( ls_fullname ) THEN
	MessageBox(Parent.title,"Please Select/Paste a file first.")
	RETURN
END IF

//Added By Mark Lee 07/03/2013
//istr_import_msg.as_filename = ls_fullname
ll_upperbound = UpperBound(istr_import_msg.as_filename[])
If not isnull(ll_upperbound) and ll_upperbound > 1  then 
	//
Else
	istr_import_msg.as_filename[1] = ls_fullname	
ENd If
istr_import_msg.al_folder_id = dw_1.GetItemNumber(1,'folder_id')
istr_import_msg.al_sub_folder_id = dw_1.GetItemNumber(1,'folder_id')

ll_ctx_id = dw_1.GetItemNumber(1,'ctx_id')
ll_doc_id = dw_1.GetItemNumber(1,'doc_id')
ll_ai_id = dw_1.GetItemNumber(1,'ai_id')

If isnull(ll_ctx_id) Then ll_ctx_id = 0
If isnull(ll_doc_id) Then ll_doc_id = 0
If isnull(ll_ai_id) Then ll_ai_id = 0

istr_import_msg.al_ctx_id = ll_ctx_id
istr_import_msg.al_doc_id = ll_doc_id
istr_import_msg.al_ai_id = ll_ai_id

CloseWithReturn(Parent,istr_import_msg)

end event

type cb_paste from commandbutton within w_em_import_msg
boolean visible = false
integer x = 1015
integer y = 1064
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Paste"
end type

event clicked;//Commented By Mark Lee 07/01/2013
//String ls_ext
//String ls_filepath
//String ls_filename
//String ls_fullname
//n_cst_appeondll lnv_appeondll
//
//
//ls_filename = SPACE(256)
//ls_filepath = gs_dir_path + gs_DefDirName + "\Email\POP3\Temp\"
//lnv_appeondll.of_parsepath( ls_filepath )
//IF NOT DirectoryExists(ls_filepath) THEN 
//	Messagebox('Email','Failed to create the Email temp directory '+ls_filepath+', please call support.')
//	Return 
//End If
//
//IF lnv_appeondll.of_pastefromclipboard( ls_filepath, ls_filename) > 0 THEN
//	ls_ext = Mid(ls_filename,lastpos(ls_filename,'.') + 1, len(ls_filename))
//	If Lower(ls_ext) <> 'msg' Then
//		Messagebox('Paste', 'Unspport the *.' + ls_ext + ' file, only the *.msg file is supported to copy.')
//		Return 0
//	End If
//	ls_fullname = ls_filepath + ls_filename
//	IF FileExists(ls_fullname) THEN
//		dw_1.SetItem( 1, "filename", ls_filename ) 
//		dw_1.SetItem( 1, "fullname", ls_fullname ) 
//		cb_ok.Enabled = TRUE
//	END IF
//	
//END IF
//Added By Mark Lee 07/01/2013
m_mail_paste		lm_mail_paste

lm_mail_paste = Create m_mail_paste
lm_mail_paste.iw_parent = Parent

lm_mail_paste.Popmenu(Parent.pointerx( ) , Parent.pointery( ) )

Destroy lm_mail_paste
end event

type cb_select from commandbutton within w_em_import_msg
integer x = 882
integer y = 96
integer width = 695
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Outlook .MSG &File..."
end type

event clicked;String docname, named
Integer value
gf_load_dir_path() 
value = GetFileOpenName("Select File",&
+ docname, named, 'MSG', "Outlook Message Format(*.MSG),*.MSG")
gf_save_dir_path(docname) 

IF value = 1 THEN
	dw_1.SetItem( 1, "filename", named )
	dw_1.SetItem( 1, "fullname", docname )
	cb_ok.Enabled = TRUE
	st_info.text = 'There is an email attached. Please click OK to import it.'
END IF


end event

type gb_1 from groupbox within w_em_import_msg
integer x = 55
integer y = 12
integer width = 1577
integer height = 348
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Import From"
end type

