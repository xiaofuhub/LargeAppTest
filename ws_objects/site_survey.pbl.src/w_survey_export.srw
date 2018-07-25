$PBExportHeader$w_survey_export.srw
forward
global type w_survey_export from window
end type
type cb_delete from commandbutton within w_survey_export
end type
type cb_find from commandbutton within w_survey_export
end type
type dw_export from datawindow within w_survey_export
end type
type cb_close from commandbutton within w_survey_export
end type
type cb_export from commandbutton within w_survey_export
end type
type dw_survey from datawindow within w_survey_export
end type
end forward

global type w_survey_export from window
integer x = 361
integer y = 336
integer width = 2949
integer height = 1524
boolean titlebar = true
string title = "Export Survey"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_delete cb_delete
cb_find cb_find
dw_export dw_export
cb_close cb_close
cb_export cb_export
dw_survey dw_survey
end type
global w_survey_export w_survey_export

on w_survey_export.create
this.cb_delete=create cb_delete
this.cb_find=create cb_find
this.dw_export=create dw_export
this.cb_close=create cb_close
this.cb_export=create cb_export
this.dw_survey=create dw_survey
this.Control[]={this.cb_delete,&
this.cb_find,&
this.dw_export,&
this.cb_close,&
this.cb_export,&
this.dw_survey}
end on

on w_survey_export.destroy
destroy(this.cb_delete)
destroy(this.cb_find)
destroy(this.dw_export)
destroy(this.cb_close)
destroy(this.cb_export)
destroy(this.dw_survey)
end on

event open;long id
long ll_rev
integer i
date ld_today
string ls_doc
string d

ld_today = today()

id = message.doubleparm

dw_export.settransobject(sqlca)
i = dw_export.retrieve(id)



if i = 1 then //set rest of export data from group data etc.
	dw_export.setitem(i,"pd_review_export_prac_name",dw_export.getitemstring(1,"v_full_name_full_name"))
	dw_export.setitem(i,"pd_review_export_review_name",dw_export.getitemstring(1,"review_hdr_review_description"))
	dw_export.setitem(i,"pd_review_export_street_1",dw_export.getitemstring(1,"group_practice_street"))
	dw_export.setitem(i,"pd_review_export_street_2",dw_export.getitemstring(1,"group_practice_street_2"))
	dw_export.setitem(i,"pd_review_export_city",dw_export.getitemstring(1,"group_practice_city"))
	dw_export.setitem(i,"pd_review_export_state",dw_export.getitemstring(1,"code_lookup_code"))
	dw_export.setitem(i,"pd_review_export_zip",dw_export.getitemstring(1,"group_practice_zip"))
	dw_export.setitem(i,"pd_review_export_phone",dw_export.getitemstring(1,"group_practice_phone"))
	dw_export.setitem(i,"pd_review_export_contact_person",dw_export.getitemstring(1,"group_practice_contact_person"))
	//dw_export.setitem(i,"pd_review_export_exported",today())
	//extract date for doc_id
	d = string(month(ld_today))
	if LenA(d) = 1 then d = "0" + d
	ls_doc = string(year(ld_today)) + d
	d = string(day(ld_today))
	if LenA(d) = 1 then d = "0" + d
	ls_doc = ls_doc + d + "-" + string(dw_export.getitemnumber(1,"pd_review_export_export_id"))
	dw_export.setitem(i,"pd_review_export_doc_id",ls_doc)
	dw_export.setitem(i,"pd_review_export_sent_by",gs_user_id)
	ll_rev = dw_export.getitemnumber(1,"pd_review_id")
	dw_survey.settransobject(sqlca)
	dw_survey.retrieve(ll_rev)
end if
	
//retrieve survey data
//save export and survey files
//email to Agent
	
end event

type cb_delete from commandbutton within w_survey_export
integer x = 2103
integer y = 1316
integer width = 384
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;integer res


//res = 


dw_export.deleterow(1)
dw_export.update()
commit using sqlca;

//cb_close.triggerevent(clicked!)




end event

type cb_find from commandbutton within w_survey_export
integer x = 1646
integer y = 1316
integer width = 434
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find Practitioner"
end type

event clicked;Integer li_nr
Integer li_find
Long ll_prac_id
String ls_full_name
gs_search lstr_search
gs_batch_search ist_search

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "SURVEY"  //Start Code Change ----08.30.2011 #V11 maha - from Reports 1


//messagebox("", lstr_search.ls_open_for )
OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF


ll_prac_id = Long( MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" ) -1 ) )


ls_full_name = MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1, 100 )


dw_export.SetItem(1, "pd_review_export_prac_id", ll_prac_id )
dw_export.SetItem(1, "pd_review_export_prac_name", ls_full_name )




end event

type dw_export from datawindow within w_survey_export
integer x = 23
integer y = 20
integer width = 2885
integer height = 1260
integer taborder = 20
string dataobject = "d_review_export"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_survey_export
integer x = 2510
integer y = 1316
integer width = 384
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_export from commandbutton within w_survey_export
integer x = 1239
integer y = 1316
integer width = 384
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;string ls_docid
string ls_hpath
string ls_spath
string ls_emp_mail_login = ""
string ls_email_address
string ls_subject
string ls_notetext
long p1
long p2

dw_export.update()
//need path trap

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.13.2006 By: LeiWei
//$<reason> Fix a defect.
//ls_docid = dw_export.GetItemString(1,"pd_review_export_doc_id")
If dw_export.rowcount()>0 Then
	ls_docid = dw_export.GetItemString(1,"pd_review_export_doc_id")
else
	Close (Parent)
	Return //Add by Evan 2008-03-18
End If
//---------------------------- APPEON END ----------------------------

ls_hpath = gs_temp_path + "intellisite\exports\" + ls_docid + "_header.txt"

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.13.2006 By: Cao YongWang
//$<modification> Create the downloading directory if it does not exist.

//-------------------------APPEON BEGIN------------------------------
//$<Modified> long.zhang 09.30.2011
//$<Reason>Create the attach directory if it does not exists

//If appeongetclienttype() <> 'PB' Then
//	n_appeon_download lnv_downlaod
//	lnv_downlaod.of_parsepath( ls_hpath)
//End If

n_appeon_download lnv_downlaod
lnv_downlaod.of_parsepath( gs_temp_path + "intellisite\exports\")
//-------------------------APPEON END-------------------------------

//---------------------------- APPEON END ----------------------------

dw_export.SaveAs(ls_hpath, text!, FALSE)

ls_spath = gs_temp_path + "intellisite\exports\" + ls_docid + "_survey.txt"

dw_survey.SaveAs(ls_spath, text!, FALSE)

//SELECT email_id INTO :ls_emp_mail_login FROM security_users WHERE user_id = :gs_user_id;
//IF ls_emp_mail_login = "" OR IsNull( ls_emp_mail_login ) THEN
//	MessageBox("", "You must setup an email login in the Security User Painter for user: " + gs_user_id )
//	Return -1
//END IF

Open( w_survey_email )
IF Message.StringParm = "Cancel" THEN
	Return -1
END IF

p1 =  PosA( Message.StringParm, "*" )
p2 =  PosA( Message.StringParm, "**" )
//Messagebox("",Message.StringParm)
ls_email_address = MidA( Message.StringParm, 1, p1 - 1)
//Messagebox("addr",ls_email_address)
ls_subject = MidA( Message.StringParm, p1 + 1, p2 - p1 - 1 )
//Messagebox("sub",ls_subject)
ls_notetext = MidA( Message.StringParm, PosA( Message.StringParm, "**" ) + 2)
//ls_notetext = ls_notetext +"~r~rTo import, copy the attached files into the IntelliSite folder on your C drive."
//Messagebox("mess",ls_notetext)
//return -1
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06/13/2007 By: Ken.Guo
//$<reason> Send Email


/*
			mailSession mSes
			mailReturnCode mRet
			mailMessage mMsg
			mailFileDescription nfile1
			mailFileDescription nfile2
			mailFileDescription nfile3
			String ls_attach
			mSes = create mailSession
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> UM-02
			//$<add> 01.20.2006 By: LeiWei
			//$<reason> mailSession is currently unsupported.
			//$<modification> Manually specify mailReturnSuccess! as the initial value to mRet. 
			//mRet = mailReturnSuccess!
			mRet = mSes.maillogon('appeon','',mailNewSession!)
			//---------------------------- APPEON END ----------------------------
			
			//mRet = mSes.mailLogon( mailNewSession!) //maha 042005
			//mRet = mSes.mailLogon( ls_emp_mail_logon ,"",mailNewSession!)
			IF mRet <> mailReturnSuccess! THEN
				MessageBox("Mail", 'Logon failed.  Check to make sure you have an email id setup in the user painter.')		
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> UM-03
				//$<modify> 01.13.2006 By: Wang Chao
				//$<reason> The Goto statement is currently unsupported.
				//$<modification> Copy the script associated with the GOTO label here.
				//GOTO CLEAN_UP	
				mSes.mailLogoff()
				Destroy mSes
				
				Close (Parent)
				return -1
				//---------------------------- APPEON END ----------------------------
			END IF
			
			
			// Populate the attachment objects
				nfile1.FileType = MailAttach!
				nfile1.FileName = Mid( ls_hpath, 36, 1000 )
				nfile1.PathName = ls_hpath
				nfile1.position = 1
				mMsg.AttachmentFile[1] = nfile1	
				nfile2.FileType = MailAttach!
				nfile2.FileName = Mid( ls_spath, 36, 1000 )
				nfile2.PathName = ls_spath
				nfile2.position = 2
				mMsg.AttachmentFile[2] = nfile2
				
			mMsg.Subject = ls_subject
			mMsg.NoteText = ls_notetext
				
				
			mMsg.Recipient[1].name = ls_email_address
				
			mRet = mSes.mailSend(mMsg)
				
			IF mRet <> mailReturnSuccess! THEN
				MessageBox("Mail Send", 'Mail not sent')
				//mSes.mailLogoff()
				//DESTROY mSes
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> UM-04
				//$<modify> 01.13.2006 By: Wang Chao
				//$<reason> The Goto statement is currently unsupported.
				//$<modification> Copy the script associated with the GOTO label here.
				//GOTO CLEAN_UP	
				mSes.mailLogoff()
				Destroy mSes
				
				Close (Parent)
				return -1
				//---------------------------- APPEON END ----------------------------
*/
	
String ls_address_mailcc,ls_attach
ls_attach = ls_hpath + ',' + ls_spath

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-21 By: Scofield
//$<Reason> Change the interface of send mail.

//IF lnv_redemption_mail.of_start_email( ls_email_address,ls_address_mailcc,ls_notetext, ls_subject, ls_attach) < 0 THEN
//	Return -1
//else
//	dw_export.setitem(1,"pd_review_export_exported",today())
//	dw_export.update()
//END IF


long		ll_Return

n_cst_easymail_smtp 	lnv_Mail

if lnv_Mail.of_CreateObject() = -1 then
	//Added by Nova.zhang on 2008-11-07
	f_show_message('create Email object','','','','')
	//MessageBox("Error", "Failed to create email object!",StopSign!)
	Return -1
end if

//START---Modify by Evan 2008-03-24 (Reasion:Send email with current user account)
/*
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-02-22 By: Scofield
//$<Reason> Get the Addresser's user id.

String	ls_Addresser

select top 1 set_addresser into :ls_Addresser from icred_settings;

if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
	ls_Addresser = gs_User_Id
end if
//---------------------------- APPEON END ----------------------------

//Send EMail
ll_Return = lnv_Mail.of_SendText(ls_Addresser, ls_email_address, ls_address_mailcc, '',ls_subject, ls_notetext, ls_attach)
*/
lnv_Mail.ib_combine_mail = false // add by Stephen 11.23.2011  V12.1-Fax modification
ll_Return = lnv_Mail.of_SendText(gs_user_Id, ls_email_address, ls_address_mailcc, '',ls_subject, ls_notetext, ls_attach)
//END---Modify by Evan 2008-03-24
	
IF ll_Return <> 0 THEN
	//--------Begin Modified by Nova 11.07.2008-----------
   //MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	//--------End Modified -------------------------------
	lnv_Mail.of_DeleteObject()
	Return -1
else
	dw_export.setitem(1,"pd_review_export_exported",today())
	dw_export.update()
END IF

lnv_Mail.of_DeleteObject()

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-05
//$<comment> 01.13.2006 By: Wang Chao
//$<reason> The Goto statement is currently unsupported.
//$<modification> Move the scripts to the location of GOTO ERROR.
//CLEAN_UP:		

/* //Comment by Ken at 06/13/2007
mSes.mailLogoff()
DESTROY mSes
*/

close (parent)
//---------------------------- APPEON END ----------------------------

end event

type dw_survey from datawindow within w_survey_export
integer x = 1376
integer y = 1324
integer width = 73
integer height = 56
integer taborder = 30
string dataobject = "d_pd_survey_preview"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

