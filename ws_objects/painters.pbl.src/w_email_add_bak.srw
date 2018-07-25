$PBExportHeader$w_email_add_bak.srw
$PBExportComments$Email Painter of work flow for add data
forward
global type w_email_add_bak from w_popup
end type
type sle_sendbcc from singlelineedit within w_email_add_bak
end type
type sle_sendcc from singlelineedit within w_email_add_bak
end type
type sle_sendto from singlelineedit within w_email_add_bak
end type
type mle_message from multilineedit within w_email_add_bak
end type
type ole_message from u_email_edit within w_email_add_bak
end type
type dw_email from u_dw within w_email_add_bak
end type
type gb_1 from groupbox within w_email_add_bak
end type
type gb_2 from groupbox within w_email_add_bak
end type
type cb_resize from commandbutton within w_email_add_bak
end type
type cb_field from commandbutton within w_email_add_bak
end type
type cb_save from commandbutton within w_email_add_bak
end type
type cb_cancel from commandbutton within w_email_add_bak
end type
end forward

global type w_email_add_bak from w_popup
integer width = 3867
integer height = 2428
string title = "Email Templates"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
event ue_nclbuttondblclk pbm_nclbuttondblclk
sle_sendbcc sle_sendbcc
sle_sendcc sle_sendcc
sle_sendto sle_sendto
mle_message mle_message
ole_message ole_message
dw_email dw_email
gb_1 gb_1
gb_2 gb_2
cb_resize cb_resize
cb_field cb_field
cb_save cb_save
cb_cancel cb_cancel
end type
global w_email_add_bak w_email_add_bak

type variables
n_cst_filesrv in_FileSrv	//used for blob/file

String is_edit_type	//Add Copy Edit

String is_FileName	//include the path
Boolean ib_delete_attach = False	//Is delete a attachment?

string is_EmailType = "Easymail!" //Add by Evan 01.28.2010
end variables

forward prototypes
public function string of_findrquired (datawindow adw_data)
public subroutine of_refresh_export (string as_module)
public subroutine of_add_merge_field (string as_merge_field)
public subroutine of_getemailmessage (long al_email_id, ref blob ablb_message)
end prototypes

event ue_nclbuttondblclk;if This.Windowstate = Maximized! then
	This.Windowstate = Normal!
else
	This.Windowstate = Maximized!
end if

return 1

end event

public function string of_findrquired (datawindow adw_data);long ll_row = 1

integer colnbr = 0

string colname, ls_text


DO WHILE ll_row <> 0

        colnbr++ // Continue searching at next column
        // If there's an error, exit
        IF adw_data.FindRequired(Primary!, &
            ll_row, colnbr, &
            colname, FALSE) < 0 THEN EXIT
        // If a row was found, save the row and column
        IF ll_row <> 0 THEN
            ls_text = ls_text + colname + "~r~n" //+ String(ll_row) + "~t" &
                
			END IF
LOOP
RETURN ls_text
end function

public subroutine of_refresh_export (string as_module);string ls_module
long	 ll_modules[]
DataWindowChild ldwc_child

Choose Case as_module
	Case '01','02'
		ll_modules[1] = 1
		ll_modules[2] = 2
	Case '03','04'
		ll_modules[1] = 3
		ll_modules[2] = 4
	Case else
		ll_modules[1] = 0
End Choose

dw_email.GetChild('export_id' , ldwc_child)
ldwc_child.settransobject( SQLCA)
ldwc_child.retrieve( ll_modules )
ldwc_child.insertrow( 1 )
end subroutine

public subroutine of_add_merge_field (string as_merge_field);
If not LenA(as_merge_field) > 0 Then return

if is_EmailType = "Easymail!" then //Evan 01.28.2010
	//--------Begin Modified by Alfee 11.23.2007---------
	//<$Reason>Replaced the email edit control with Word OCX
	IF ole_message.Object.Doctype <> 1 THEN RETURN
	
	ole_message.Object.ActiveDocument.ActiveWindow.Selection.TypeText("$<" + as_merge_field + ">$")
	//dw_email.replacetext("$<"+as_merge_field+">$")
	//--------End Modified --------------------------------
else
	mle_Message.ReplaceText("$<" + as_merge_field + ">$")
	mle_Message.SetFocus()
end if
end subroutine

public subroutine of_getemailmessage (long al_email_id, ref blob ablb_message);long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000

SELECT Datalength(wf_email.Email_Message)
  INTO :ll_DataLen
  FROM wf_email
 WHERE wf_email.email_id = :al_EMail_Id;

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(Email_Message,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM wf_email
		     WHERE wf_email.email_id = :al_EMail_Id;
		
		ablb_Message += lb_Temp
	next
else
	SELECTBLOB Email_Message
	      INTO :ablb_Message
	      FROM wf_email
	     WHERE wf_email.email_id = :al_EMail_Id;
end if

end subroutine

on w_email_add_bak.create
int iCurrent
call super::create
this.sle_sendbcc=create sle_sendbcc
this.sle_sendcc=create sle_sendcc
this.sle_sendto=create sle_sendto
this.mle_message=create mle_message
this.ole_message=create ole_message
this.dw_email=create dw_email
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_resize=create cb_resize
this.cb_field=create cb_field
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_sendbcc
this.Control[iCurrent+2]=this.sle_sendcc
this.Control[iCurrent+3]=this.sle_sendto
this.Control[iCurrent+4]=this.mle_message
this.Control[iCurrent+5]=this.ole_message
this.Control[iCurrent+6]=this.dw_email
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.cb_resize
this.Control[iCurrent+10]=this.cb_field
this.Control[iCurrent+11]=this.cb_save
this.Control[iCurrent+12]=this.cb_cancel
end on

on w_email_add_bak.destroy
call super::destroy
destroy(this.sle_sendbcc)
destroy(this.sle_sendcc)
destroy(this.sle_sendto)
destroy(this.mle_message)
destroy(this.ole_message)
destroy(this.dw_email)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_resize)
destroy(this.cb_field)
destroy(this.cb_save)
destroy(this.cb_cancel)
end on

event open;call super::open;Long 		ll_Row,ll_EMailId
String 	ls_module,ls_Null
Blob		lblb_Message

SetNull(ls_Null)

in_FileSrv = Create pfc_n_cst_filesrv

is_edit_type = Message.StringParm
//------------------- APPEON BEGIN -------------------
//$<add> Evan 01.28.2010
//$<reason> Support outlook send email
if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
	is_EmailType = "Outlook!"
	ole_Message.Hide()
	mle_Message.Show()
end if
//------------------- APPEON END ---------------------

dw_email.SetTransObject(Sqlca)

IF LeftA(is_edit_type, 3) = "Add" THEN
	dw_email.InsertRow(0)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 2007-08-21 By: Evan
	//$<Reason> Not prompt save data when no data change.
	/*
	IF Mid(is_edit_type, Pos(is_edit_type, ":") + 1) <> "00" THEN												
		dw_email.SetItem(1, "module", Mid(is_edit_type, Pos(is_edit_type, ":") + 1))
		
	END IF
	*/
	ls_Module = MidA(is_edit_type, PosA(is_edit_type, ":") + 1)
	if ls_Module <> "00" and LenA(ls_Module) > 0 then
		dw_email.SetItem(1, "module", ls_Module)
	end if
	//---------------------------- APPEON END ----------------------------	
	cb_field.enabled = false  //Start Code Change ----10.29.2008 #V85 maha
	
	if is_EmailType = "Easymail!" then ole_Message.of_Open() //Evan 01.28.2010
ELSEIF LeftA(is_edit_type, 4) = "Copy" THEN
	ll_Row = w_email_painter.dw_email.GetRow()
	w_email_painter.dw_email.RowsCopy(ll_Row, ll_Row, Primary!, dw_email, 1, Primary!)
	dw_email.SetItem(1, "email_id", 0)
	dw_email.SetItem(1, "email_name", ls_Null)
	//--------Begin Modified by Nova 04.15.2009-----------
	//cb_field.enabled = false  //Start Code Change ----10.29.2008 #V85 maha
	IF dw_email.GetItemNumber(1, "export_id") > 0 THEN 
		cb_field.Enabled = True
	ELSE
		cb_field.Enabled = False
	END IF
	//--------End Modified ---------------------------------
	ll_EMailId = w_email_painter.dw_email.GetItemNumber(ll_Row,'email_id')
	
	if is_EmailType = "Easymail!" then //Evan 01.28.2010
		of_GetEMailMessage(ll_EMailId,lblb_Message)
		ole_Message.of_Open(lblb_Message)
	else
		mle_Message.Text = dw_email.GetItemString(1, "email_msg")
	end if
ELSE  //edit
	ll_EMailId = Long(MidA(is_edit_type, PosA(is_edit_type, ":") + 1))
	dw_email.Retrieve(ll_EMailId)
	//--------Begin Modified by Nova 04.15.2009-----------
	//	if dw_email.getItemnumber(1, "email_id") > 0 then  //Start Code Change ----10.29.2008 #V85 maha
	//		cb_field.enabled = false 
	//	end if
	IF dw_email.GetItemNumber(1, "export_id") > 0 THEN 
		cb_field.Enabled = True
	ELSE
		cb_field.Enabled = False
	END IF
	//--------End Modified ---------------------------------
	
	if is_EmailType = "Easymail!" then //Evan 01.28.2010
		of_GetEMailMessage(ll_EMailId,lblb_Message)
		ole_Message.of_Open(lblb_Message)
	else
		mle_Message.Text = dw_email.GetItemString(1, "email_msg")
	end if
END IF

//--------Begin Modified by Nova 04.15.2009-----------
//This.Title += Left(is_edit_type, Pos(is_edit_type, ":") - 1)
this.Title +=' - '+ LeftA(is_edit_type, PosA(is_edit_type, ":") - 1)
//--------End Modified ---------------------------------
If dw_email.GetRow() > 0 Then
	ls_module = dw_email.GetItemString(dw_email.Getrow(), 'module')
	If IsNull(ls_module) Then ls_module = ''
	of_refresh_export(ls_module)
End If

end event

event close;call super::close;if is_EmailType = "Easymail!" then //Evan 01.28.2010
	ole_Message.of_Close()
end if

IF IsValid(in_FileSrv) THEN DESTROY in_FileSrv
end event

event pfc_preopen;call super::pfc_preopen;

this.of_setresize(true)

this.inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
//this.inv_resize.of_setminsize( w_mdi.WorkSpaceWidth(),w_mdi.WorkSpaceHeight())
this.inv_resize.of_SetMinSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())

this.inv_resize.of_Register(gb_2, this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(gb_1, this.inv_resize.SCALERIGHTBOTTOM)
this.inv_resize.of_Register(ole_message, this.inv_resize.SCALERIGHTBOTTOM)
this.inv_resize.of_Register(mle_message, this.inv_resize.SCALERIGHTBOTTOM) //Evan 01.28.2010
//this.inv_resize.of_Register(cb_resize, this.inv_resize.FIXEDBOTTOM)

this.inv_resize.of_Register(dw_email, this.inv_resize.SCALERIGHT)
//this.inv_resize.of_Register(cb_cancel, this.inv_resize.FIXEDRIGHTBOTTOM)
//this.inv_resize.of_Register(cb_save, this.inv_resize.FIXEDRIGHTBOTTOM)
//this.inv_resize.of_Register(cb_field, this.inv_resize.FIXEDRIGHTBOTTOM)


end event

event closequery;//Override

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007-08-21 By: Evan
//$<Reason> Not prompt save data when no data change.
boolean lb_ShowPrompt = false

dw_email.AcceptText()
if dw_email.GetItemStatus(1, "email_name", Primary!) = DataModified! then lb_ShowPrompt = true
if dw_email.GetItemStatus(1, "module", Primary!) = DataModified! then lb_ShowPrompt = true
if dw_email.GetItemStatus(1, "export_id", Primary!) = DataModified! then lb_ShowPrompt = true
if dw_email.GetItemStatus(1, "subject", Primary!) = DataModified! then lb_ShowPrompt = true
if dw_email.GetItemStatus(1, "attach_name", Primary!) = DataModified! then lb_ShowPrompt = true
if dw_email.GetItemStatus(1, "email_msg", Primary!) = DataModified! then lb_ShowPrompt = true
if lb_ShowPrompt then
	if MessageBox("Save data", "Close without saving changes?", Question!, YesNo!) = 2 then
		Return 1
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

event resize;call super::resize;if SizeType = 0 then
	cb_resize.text = '&Maximized'
elseif SizeType = 2 then
	cb_resize.text = '&Normal'
end if

end event

type sle_sendbcc from singlelineedit within w_email_add_bak
boolean visible = false
integer x = 544
integer y = 36
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean border = false
end type

type sle_sendcc from singlelineedit within w_email_add_bak
boolean visible = false
integer x = 539
integer y = 28
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean border = false
end type

type sle_sendto from singlelineedit within w_email_add_bak
boolean visible = false
integer x = 544
integer y = 36
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean border = false
end type

type mle_message from multilineedit within w_email_add_bak
boolean visible = false
integer x = 50
integer y = 956
integer width = 3739
integer height = 1320
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ole_message from u_email_edit within w_email_add_bak
integer x = 55
integer y = 964
integer width = 3739
integer height = 1320
integer taborder = 30
string binarykey = "w_email_add_bak.win"
end type

type dw_email from u_dw within w_email_add_bak
integer x = 55
integer y = 172
integer width = 3762
integer height = 704
integer taborder = 10
string title = "none"
string dataobject = "d_email"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-16 By: Liu Hongxin
//$<reason> Get File to Attachment.
IF dwo.Name = "b_attach" THEN	//Add Attachment
	string docpath, docname, ls_Attach
	integer li_rtn

	li_rtn = GetFileOpenName("Select File", &
		docpath, docname, "DOC", &
		+ "All Files (*.*), *.*", &
		gs_temp_path) 
	ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
	IF li_rtn < 1 THEN RETURN

	ls_Attach = docname
	is_FileName = docpath
	dw_email.SetItem(1, "Attach_name", ls_Attach)
	//IF cb_save.Enabled = False THEN cb_save.Enabled = True
	ib_delete_attach = False
END IF
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> Stephen 05.07.2013
//$<reason> V12.3 Modification estimate
//  get email cc
n_cst_outlook lnv_Outlook
string  ls_cc

if row < 1 then return
if dwo.name="b_cc" then
	lnv_Outlook.of_SelectXPContacts(sle_sendto, sle_sendcc, sle_sendbcc)
	ls_cc = trim(this.getitemstring(1, "cc_recip"))
	if isnull(ls_cc) or ls_cc = '' then
		this.setitem(1, "cc_recip", sle_sendcc.text)
	else
		if right(ls_cc,1) <> ";" then
			ls_cc = ls_cc +";"
		end if
		this.setitem(1, "cc_recip", ls_cc + sle_sendcc.text)		
	end if
	
end if
//--------------------------- APPEON END ---------------------------
end event

event rbuttondown;call super::rbuttondown;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-10 By: Liu Hongxin
//$<reason> delete the attachment
IF Row < 1 THEN RETURN -1
IF dwo.name = "attach_name" THEN
	Long	 ll_Email_id
	String ls_attach_name
	ls_attach_name = GetItemString(Row, "attach_name")
	IF ls_attach_name <> "" AND Not IsNull(ls_attach_name) THEN
		IF MessageBox(gnv_app.iapp_object.DisplayName, "Are you sure you want to delete the attachment?", Question!, YesNo!) = 1 THEN
			ll_Email_id = GetItemNumber(Row, "Email_id")
			
			SetItem(Row, "attach_name", "")
			/*
			gnv_appeondb.of_StartQueue()
			Update wf_email
			Set Attachment = Null,
				 attach_name = Null
			Where Email_id = :ll_Email_id;
			
			Commit;
			gnv_appeondb.of_CommitQueue()
			*/
			ib_delete_attach = true
			//IF cb_save.Enabled = False THEN cb_save.Enabled = True
		END IF
	END IF
END IF
//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-10 By: Liu Hongxin
//$<reason> View Attachment
Long 		ll_Email_Id,ll_FileLen
String 	ls_FileName, ls_Null
BLOB 		lblb_data,lb_Temp

long		ll_DataLen,ll_Cycle,ll_Count,ll_Start
long 		READ_ONE_LENGTH = 8000

IF dwo.Name = "attach_name" THEN
	ll_Email_Id = this.GetItemNumber(Row, "Email_id")
	ls_FileName = this.GetItemString(Row, "Attach_name")
	IF LenA(ls_FileName) < 1 OR IsNull(ls_FileName) THEN RETURN
	
	SetNull(ls_Null)

	SELECT Datalength(wf_email.Attachment)
	  INTO :ll_DataLen
	  FROM wf_email
	 WHERE wf_email.email_id = :ll_EMail_Id;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
		ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
		
		for ll_Cycle = 1 To ll_Count
			ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(Attachment,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM wf_email
				  WHERE wf_email.email_id = :ll_EMail_Id;
			
			lblb_data += lb_Temp
		next
	else
		SELECTBLOB Attachment
				INTO :lblb_data
				FROM wf_email
			  WHERE wf_email.email_id = :ll_EMail_Id;
	end if
	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( gnv_app.iapp_object.DisplayName, SQLCA.SQLERRTEXT )
		Return -1
	END IF
	
	ll_FileLen = LenA( lblb_data )
	
	// Check blob data
	IF ll_FileLen = 0 OR Isnull(lblb_data) THEN
		RETURN -2
	END IF
	
	ls_FileName = gs_temp_path + ls_FileName
	in_FileSrv.of_FileWrite(ls_FileName, lblb_data, FALSE)

	If RightA(lower(ls_FileName),5)='.html' or RightA(lower(ls_FileName),4)='.htm' Then
		 //ll_FileLen = ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_FileName , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		 ll_FileLen = ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_FileName , ls_Null, 4)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
	else				
		 ll_FileLen = ShellExecuteA ( Handle( This ), "open", ls_FileName , ls_Null, ls_Null, 4)
	end if
END IF
//---------------------------- APPEON END ----------------------------

end event

event losefocus;call super::losefocus;this.AcceptText()
end event

event itemerror;call super::itemerror;RETURN 1
end event

event itemchanged;call super::itemchanged;
CHOOSE CASE dwo.Name
	CASE 'module'
		//cb_save.Enabled = True
		of_refresh_export(Data)
	CASE "export_id" //Start Code Change ----10.29.2008 #V85 maha
		IF Integer(Data) > 0 THEN
			cb_field.Enabled = True
		ELSE // Added by Nova 04.15.2009
			cb_field.Enabled = False
		END IF
END CHOOSE

//IF cb_save.Enabled = False THEN cb_save.Enabled = True


end event

event constructor;call super::constructor;dw_email.of_setresize(true)
//dw_email.inv_resize.of_setorigsize( dw_email.width,dw_email.height)
//dw_email.inv_resize.of_SetMinSize( dw_email.width,dw_email.height)
//for ll_i = 1 to ll_count
//	dw_email.inv_resize.of_register(ls_array[ll_i],dw_email.inv_resize.SCALE)
//next
//dw_email.inv_resize.of_register("datawindow.detail",dw_email.inv_resize.FIXEDBOTTOM)
//
//
// Args - PercentageX, PercentageY, PercentageWidth, PercentageHeight
inv_resize.of_Register('email_name', 0, 0, 100, 0)
inv_resize.of_Register('email_name_t', 0, 0, 0, 0)
inv_resize.of_Register('module', 0, 0, 100, 0)
inv_resize.of_Register('category_name_t', 0, 0, 0, 0)
inv_resize.of_Register('export_id', 0, 0, 100, 0)
inv_resize.of_Register('t_1', 0, 0, 0, 0)
inv_resize.of_Register('subject', 0, 0, 100, 0)
inv_resize.of_Register('subject_t', 0, 0, 0, 0)
inv_resize.of_Register('attach_name', 0, 0, 100, 0)
inv_resize.of_Register('attachment_t', 0, 0, 0, 0)
inv_resize.of_Register('b_attach', 100, 0, 0, 0)
//inv_resize.of_Register('email_msg_t', 0, 0, 0, 0)
//inv_resize.of_Register('email_msg', 0,0,100,100)


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 15/05/2007 By: Jervis
//$<reason> 
/*
if gb_contract_version then
	this.Modify("module.values = 'IntelliContract->Parent Level	03/IntelliContract->Document Manager	04/'")
end if
*/
integer li_product
integer li_contract_set
string ls_ddlb
li_product = of_get_app_setting('set_9', 'I')
li_contract_set = of_get_app_setting('set_cont', 'I')

choose case li_product
	case 0
		ls_ddlb = "IntelliCred	01/"
		if li_contract_set = 1 then
			ls_ddlb += "IntelliContract->Parent Level	03/IntelliContract->Document Manager	04/"
		end if
	case 1
		ls_ddlb = "IntelliApp	02/"
		if li_contract_set = 1 then
			ls_ddlb += "IntelliContract->Parent Level	03/IntelliContract->Document Manager	04/"
		end if
	case 2	//IntelliCred SE
		ls_ddlb = "IntelliCred	01/"
	case 3
		ls_ddlb = "IntelliCred	01/IntelliApp	02/"
		if li_contract_set = 1 then
			ls_ddlb += "IntelliContract->Parent Level	03/IntelliContract->Document Manager	04/"
		end if
	case 4 //IntelliContract
		ls_ddlb = "IntelliContract->Parent Level	03/IntelliContract->Document Manager	04/"
	//------------------- APPEON BEGIN -------------------
	//$<add> Michael 04.28.2011
	//$<reason>Fixed a bug:the Module drop down is blank. 
	case 5	
		ls_ddlb = "IntelliApp	02/"//Start Code Change ----06.13.2011 #V11 maha - corrected label to App  - ls_ddlb = "IntelliCred	01/"
	//------------------- APPEON END ---------------------
end choose

this.Modify("module.values = '" + ls_ddlb + "'")	

//---------------------------- APPEON END ----------------------------

//---------------------------- APPEON END ----------------------------



end event

event rbuttonup;//UnExtend Ancestor Script
//Modify by Ken at 2007-05-31 for show rightbutton menu.
end event

type gb_1 from groupbox within w_email_add_bak
integer x = 18
integer y = 904
integer width = 3813
integer height = 1412
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Message"
end type

type gb_2 from groupbox within w_email_add_bak
integer x = 18
integer y = 116
integer width = 3813
integer height = 772
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Basic Information"
end type

type cb_resize from commandbutton within w_email_add_bak
integer x = 2240
integer y = 4
integer width = 343
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Maximized"
end type

event clicked;if parent.windowstate = maximized! then
	parent.windowstate = normal!
else
	parent.windowstate = maximized!
end if

end event

type cb_field from commandbutton within w_email_add_bak
integer x = 2798
integer y = 4
integer width = 343
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Insert Field"
end type

event clicked;long		ll_row,ll_export_id
string	ls_merge_field

ll_row = dw_email.getrow()
if ll_row < 1 then return

ll_export_id = dw_email.getitemnumber(ll_row,"export_id")
if IsNull(ll_export_id) then 
	MessageBox("IntelliSoft Group","There is no export selected.  Please select first.")
	return
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 25/04/2007 By: Jervis
//$<reason> 
//openwithparm(w_agreement_template_merge_fields,ll_export_id)
str_pass lstr_pass
lstr_pass.s_long[1] = ll_export_id
lstr_pass.s_string = "EMAIL"
OpenWithParm(w_agreement_template_merge_fields,lstr_pass)
//---------------------------- APPEON END ----------------------------

w_agreement_template_merge_fields.of_set_parent(parent)
//ls_merge_field = message.stringparm
//
//If not len(ls_merge_field) > 0 Then 
//	return
//End If
//
//dw_email.replacetext("$<"+ls_merge_field+">$")
end event

type cb_save from commandbutton within w_email_add_bak
integer x = 3154
integer y = 4
integer width = 343
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;Long 		ll_Rtn, ll_Max_ID, ll_email_id,ll_FileLen
String 	ls_email_name, ls_Module,ls_err
Blob 		lblb_data[],lb_Temp

long		ll_DataLen,ll_Cycle,ll_Count,ll_Start
long 		READ_ONE_LENGTH = 8000

dw_email.accepttext( )

ll_eMail_id = Long(MidA(is_edit_type, PosA(is_edit_type, ":") + 1))
ls_email_name = Trim(dw_email.GetItemString(1, "Email_name"))
ls_Module = Trim(dw_email.GetItemString(1, "Module"))

IF IsNull(ls_email_name) OR ls_email_name = "" THEN
	MessageBox(gnv_app.iapp_object.DisplayName, "Email name can not be empty!")
	dw_email.SetColumn("Email_name")
	dw_email.SetFocus()
	RETURN -1
END IF

IF IsNull(ls_Module) OR ls_Module = "" THEN
	MessageBox(gnv_app.iapp_object.DisplayName, "Module can not be empty!")
	dw_email.SetColumn("Module")
	dw_email.SetFocus()
	RETURN -1
END IF

//Set max ID
IF LeftA(is_edit_type, 4) <> "Edit" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.17.2007 By: Jack
	//$<reason> 
	/*
	Select IsNull(Max(email_id)+1, 1) INTO :ll_Max_ID FROM wf_email;
	*/
	ll_Max_ID = gnv_app.of_get_id("email_id")
	//---------------------------- APPEON END ----------------------------
	dw_email.SetItem(dw_email.GetRow(), "Email_id", ll_Max_ID)
END IF

if is_EmailType = "Outlook!" then //Evan 01.28.2010
	dw_email.SetItem(1, "email_msg", mle_Message.Text)
end if
ll_Rtn = parent.event pfc_save()

if ll_Rtn < 0 then return -1

IF LeftA(is_edit_type, 4) = "Copy" THEN
	if Trim(is_FileName) = '' or Not FileExists(is_FileName) then
		SELECT Datalength(wf_email.Attachment)
		  INTO :ll_DataLen
		  FROM wf_email
		 WHERE wf_email.email_id = :ll_Email_id;
		
		if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
			ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
			
			for ll_Cycle = 1 To ll_Count
				ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
				SELECTBLOB SubString(Attachment,:ll_Start,:READ_ONE_LENGTH)
						INTO :lb_Temp
						FROM wf_email
					  WHERE wf_email.email_id = :ll_Email_id;
				
				lblb_data[1] += lb_Temp
			next
		else
			SELECTBLOB Attachment
					INTO :lblb_data[1]
					FROM wf_email
				  WHERE wf_email.email_id = :ll_Email_id;
		end if
		UPDATEBLOB wf_email SET attachment = :lblb_data[1] WHERE email_id = :ll_Max_ID;
	else
		ll_FileLen = in_FileSrv.of_FileRead(is_FileName, lblb_data[1])
		IF ll_FileLen > 0 THEN
			UPDATEBLOB wf_email SET attachment = :lblb_data[1] WHERE email_id = :ll_Max_ID;
		END IF
	end if
ELSEIF LenA(is_FileName) > 3 THEN	//Add attachment when add new row
	IF ll_Max_ID = 0 THEN
		ll_Max_ID = Long(MidA(is_edit_type, PosA(is_edit_type, ":") + 1))
	END IF
	ll_FileLen = in_FileSrv.of_FileRead(is_FileName, lblb_data[2])
	IF ll_FileLen > 0 THEN
		UPDATEBLOB wf_email SET attachment = :lblb_data[2] FROM wf_email WHERE email_id = :ll_Max_ID;
	END IF
ELSEIF ib_delete_attach = True THEN
	UPDATE wf_email SET Attachment = Null,attach_name = Null Where Email_id = :ll_Email_id;
END IF

//Add,Edit,Copy
if is_EmailType = "Easymail!" then //Evan 01.28.2010
	ll_Email_id = dw_email.GetItemNumber(dw_email.GetRow(), "Email_id")
	ole_Message.of_GetBlob(lblb_data[3])
	UPDATEBLOB wf_email SET email_message = :lblb_data[3] WHERE email_id = :ll_Email_id;
end if
IF Sqlca.SqlCode = 0 THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
END IF
	
If isvalid(w_email_painter) Then w_email_painter.of_refresh(ll_Email_id)
//Close(Parent)
end event

type cb_cancel from commandbutton within w_email_add_bak
integer x = 3502
integer y = 4
integer width = 343
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;long	ll_Email_id

ll_Email_id = dw_email.GetItemNumber(dw_email.GetRow(), "Email_id")  //Added by WuZhiJun on 2007-05-24

//CloseWithReturn(Parent, 0)
if ll_Email_id > 0 then
	If isvalid(w_email_painter) Then w_email_painter.of_refresh(ll_Email_id)
end if

Close(Parent)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Aw_email_add_bak.bin 
2900000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000008f587f1001d0817600000003000002000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000dc00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003d267e82f41ee8649010521915f71b130000000008f587f1001d081768f587f1001d081760000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000004000000dc00000000000000010000000200000003fffffffe000000050000000600000007fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd0000548b0000221b8000001080000005800000088000001080000014010100010000000000000000000000000000000000000000000000000000000000000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100c8d0d4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f6e6d300e3ba9200000000000000000000000000000001000000000000000100000000000003a8000000010000000000000000000000000000000000000000000000000000000000000000000000001234abcd0000548b0000221b8000001080000005800000088000001080000014010100010000000000000000000000000000000000000000000000000000000000000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100c8d0d4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f6e6d300e3ba9200000000000000000000000000000001000000000000000100000000000003a800000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Aw_email_add_bak.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
