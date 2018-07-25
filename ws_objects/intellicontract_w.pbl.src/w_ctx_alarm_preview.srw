$PBExportHeader$w_ctx_alarm_preview.srw
forward
global type w_ctx_alarm_preview from w_response
end type
type ole_message from u_email_edit within w_ctx_alarm_preview
end type
type st_1 from statictext within w_ctx_alarm_preview
end type
type cb_close from u_cb within w_ctx_alarm_preview
end type
end forward

global type w_ctx_alarm_preview from w_response
integer width = 3502
integer height = 2120
string title = "Email Preview"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
ole_message ole_message
st_1 st_1
cb_close cb_close
end type
global w_ctx_alarm_preview w_ctx_alarm_preview

type variables
str_alarm_email  istr_alarm_email 
String is_sender
Long il_export_id
end variables

forward prototypes
public subroutine of_insert_signature (string as_userid)
public subroutine of_preview_data ()
end prototypes

public subroutine of_insert_signature (string as_userid);//Insert Signature
Long ll_DataLen,ll_Count,ll_Cycle,ll_Start
long 		READ_ONE_LENGTH = 8000
Blob lb_Temp,lblb_Signature
If istr_alarm_email.as_sign = 'Y' Then
	SELECT Datalength(security_user_mailsetting.signature)
	  INTO :ll_DataLen
	  FROM security_user_mailsetting
	 WHERE security_user_mailsetting.user_id = :as_userid AND flag = 1;
	
	If isnull(ll_DataLen) or ll_DataLen = 0 Then Return
	
	// Get signature from user ID
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
		ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
		
		for ll_Cycle = 1 To ll_Count
			ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(signature,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM security_user_mailsetting
				  WHERE security_user_mailsetting.user_id = :as_userid AND flag = 1;
			
			lblb_Signature += lb_Temp
		next
	else
		SELECTBLOB signature
				INTO :lblb_Signature
				FROM security_user_mailsetting
			  WHERE security_user_mailsetting.user_id = :as_userid AND flag = 1;
	end if
	
	// Send email
	if Len(lblb_Signature) > 0 then
		// Merge signature
		ole_message.of_InsertFileLast(lblb_Signature)
	end if
end if	

end subroutine

public subroutine of_preview_data ();String ls_sender_email
String ls_subject
Integer li_ret

ole_message.of_open()
ole_Message.Object.Data = istr_alarm_email.aole_message.Data //Added By Ken.Guo 10/15/2012

//Get Sender Email Address
SELECT email  INTO :ls_sender_email From em_smtp_accounts Where user_id = :is_sender and is_default = 'Y';

//Add Email Header
//ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = 1
//ole_message.object.ActiveDocument.ActiveWindow.Selection.End = 1
ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('From: ' )
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = True
ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter(ls_sender_email)
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False

ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('~r~nTo: ' )
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = True
ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter( istr_alarm_email.as_to  )
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False

ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('~r~nSubject: ' )
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = True
ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter( istr_alarm_email.as_subject )
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False

If istr_alarm_email.as_attach <> '' Then
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('~r~nAttachment: ' )
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = True
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter( istr_alarm_email.as_attach  )
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False
End If

ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('~r~n~r~n' )
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False

ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = 2
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Font.Name =  'Segoe UI' //'Tahoma'//

ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = 0
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Font.Color = 0 //Blank
ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Font.Size = 10

ole_message.object.ActiveDocument.ActiveWindow.Selection.End = ole_message.object.ActiveDocument.ActiveWindow.Selection.Start

//ole_message.object.ActiveDocument.Content.InsertBefore('~r~n')
//ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = 0
//ole_message.object.ActiveDocument.ActiveWindow.Selection.End = ole_message.object.ActiveDocument.ActiveWindow.Selection.Start

ole_message.object.ActiveDocument.ActiveWindow.View.Type = 6 //wdWebView
ole_message.object.ActiveDocument.ActiveWindow.DocumentMap = False

//Added By Ken.Guo 10/11/2011. 
ole_message.object.ActiveDocument.ActiveWindow.View.Zoom.Percentage = 100

//Add Signature
If istr_alarm_email.as_sign = 'Y' Then
	of_insert_signature(is_sender)
End If

//Merge Data
n_cst_word_utility lnv_word
If il_export_id > 0 Then
	lnv_word = Create n_cst_word_utility
	li_ret = lnv_word.of_replace_export_word(ole_message.Object.ActiveDocument , ls_subject, istr_alarm_email.ctx_id , il_export_id)
	Destroy lnv_word
End If

end subroutine

on w_ctx_alarm_preview.create
int iCurrent
call super::create
this.ole_message=create ole_message
this.st_1=create st_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_message
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_close
end on

on w_ctx_alarm_preview.destroy
call super::destroy
destroy(this.ole_message)
destroy(this.st_1)
destroy(this.cb_close)
end on

event pfc_preopen;call super::pfc_preopen;istr_alarm_email = Message.Powerobjectparm

If isnull(istr_alarm_email.as_attach) Then istr_alarm_email.as_attach = ''
If isnull(istr_alarm_email.as_sign ) Then istr_alarm_email.as_sign = 'N'
If isnull(istr_alarm_email.as_to ) Then istr_alarm_email.as_to = ''
If isnull(istr_alarm_email.as_subject  ) Then istr_alarm_email.as_subject = ''

end event

event open;call super::open;String ls_owner

//Get Info
gnv_appeondb.of_startqueue( )
SELECT ctx_contacts.user_d INTO :ls_owner FROM ctx_contract_contacts,ctx_contacts,app_facility
WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id )
	AND (ctx_contacts.facility_id = app_facility.facility_id)
	AND ( ctx_contract_contacts.ctx_id = :istr_alarm_email.ctx_id  )
	AND ctx_contract_contacts.owner = 'Y'
	AND ctx_contract_contacts.ic_area = 'I';
Select top 1 set_addresser Into :is_sender From icred_settings;
Select export_id into :il_export_id from wf_email where email_id = :istr_alarm_email.al_template_id;
gnv_appeondb.of_commitqueue( )

If IsNull(is_sender) or Trim(is_sender) = "" Then
	is_sender = ls_owner
End If










end event

event pfc_postopen;call super::pfc_postopen;st_1.visible = True
ole_message.Setredraw( False)
of_preview_data()
ole_message.Setredraw( True)
st_1.visible = False
end event

event activate;call super::activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_message ) Then
	ole_message.object.activate(true)
End If
end event

type ole_message from u_email_edit within w_ctx_alarm_preview
integer x = 18
integer y = 16
integer width = 3433
integer height = 1868
integer taborder = 20
borderstyle borderstyle = stylebox!
string binarykey = "w_ctx_alarm_preview.win"
end type

type st_1 from statictext within w_ctx_alarm_preview
boolean visible = false
integer x = 46
integer y = 1928
integer width = 859
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Loading Email..."
boolean focusrectangle = false
end type

type cb_close from u_cb within w_ctx_alarm_preview
integer x = 3081
integer y = 1904
integer width = 343
integer taborder = 20
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
09w_ctx_alarm_preview.bin 
2F00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000d0b5cd8001d131cc00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000d0b5cd8001d131ccd0b5cd8001d131cc0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00004d9e0000304400dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00004d9e0000304400dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19w_ctx_alarm_preview.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
