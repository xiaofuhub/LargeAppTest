$PBExportHeader$w_send_to_committee.srw
forward
global type w_send_to_committee from w_response
end type
type dw_priv_list from u_dw within w_send_to_committee
end type
type rb_today from radiobutton within w_send_to_committee
end type
type rb_meet from radiobutton within w_send_to_committee
end type
type st_3 from statictext within w_send_to_committee
end type
type cb_all from commandbutton within w_send_to_committee
end type
type cbx_profile from checkbox within w_send_to_committee
end type
type cbx_priv from checkbox within w_send_to_committee
end type
type dw_priv from u_dw within w_send_to_committee
end type
type rb_wv from radiobutton within w_send_to_committee
end type
type rb_ef from radiobutton within w_send_to_committee
end type
type rb_p from radiobutton within w_send_to_committee
end type
type dw_profile_view from u_dw within w_send_to_committee
end type
type st_1 from statictext within w_send_to_committee
end type
type dw_meet_date from u_dw within w_send_to_committee
end type
type st_2 from statictext within w_send_to_committee
end type
type cbx_print_summary from checkbox within w_send_to_committee
end type
type cb_cancel from u_cb within w_send_to_committee
end type
type cb_send from u_cb within w_send_to_committee
end type
type dw_profile from u_dw within w_send_to_committee
end type
type dw_ver_info from u_dw within w_send_to_committee
end type
type st_4 from statictext within w_send_to_committee
end type
type st_5 from statictext within w_send_to_committee
end type
type st_6 from statictext within w_send_to_committee
end type
type gb_1 from groupbox within w_send_to_committee
end type
type cb_1 from commandbutton within w_send_to_committee
end type
type gb_2 from groupbox within w_send_to_committee
end type
type gb_3 from groupbox within w_send_to_committee
end type
type r_print_stat_border from statictext within w_send_to_committee
end type
type r_bar from statictext within w_send_to_committee
end type
type gb_hide from groupbox within w_send_to_committee
end type
end forward

global type w_send_to_committee from w_response
integer x = 1097
integer y = 524
integer width = 2062
integer height = 1692
string title = "Send To Committee"
boolean controlmenu = false
long backcolor = 33551856
dw_priv_list dw_priv_list
rb_today rb_today
rb_meet rb_meet
st_3 st_3
cb_all cb_all
cbx_profile cbx_profile
cbx_priv cbx_priv
dw_priv dw_priv
rb_wv rb_wv
rb_ef rb_ef
rb_p rb_p
dw_profile_view dw_profile_view
st_1 st_1
dw_meet_date dw_meet_date
st_2 st_2
cbx_print_summary cbx_print_summary
cb_cancel cb_cancel
cb_send cb_send
dw_profile dw_profile
dw_ver_info dw_ver_info
st_4 st_4
st_5 st_5
st_6 st_6
gb_1 gb_1
cb_1 cb_1
gb_2 gb_2
gb_3 gb_3
r_print_stat_border r_print_stat_border
r_bar r_bar
gb_hide gb_hide
end type
global w_send_to_committee w_send_to_committee

type variables
gs_pass_ids ist_ids
end variables

forward prototypes
public function integer of_email_wvlnk (long al_meeting_id, long al_facility_id)
end prototypes

public function integer of_email_wvlnk (long al_meeting_id, long al_facility_id);//////////////////////////////////////////////////////////////////////
// $<function> of_email_wvlnk
// $<arguments>
//              	long al_meeting_id
//						long al_facility_id
// $<returns> 0 successfully -1 error
// $<description> V12.1 meeting
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 02.09.2012
//////////////////////////////////////////////////////////////////////
Integer li_set_56
Integer li_smtpssl, li_pop3ssl //alfee 09.24.2013
long ll_committeeid
long ll_sub,ll_Return,ll_i
long ll_Port,ll_Authmode
string ls_email_address,ls_members
string ls_meeting_link,ls_wv_link 
string ls_mess
string ls_notetext,ls_subject
string ls_Server,ls_Account,ls_Password,ls_Email,ls_HtmlFile,ls_attach ='',ls_address_mailcc=''
String ls_Recipient[]
blob lblb_MailContent

n_cst_string lnv_string
u_email_edit luo_email_edit 
n_cst_easymail_smtp 	lnv_Mail

mailSession mSes
mailReturnCode mRet
mailMessage mMsg
mailFileDescription nfile1


select committee into :ll_committeeid from meetings where meeting_id = :al_meeting_id;

//get and specified address
declare c_email_address cursor for 
select email_address 
from committee_members
where facility_id = :al_facility_id and committee_id = :ll_committeeid and ( email_address is not null);
		
open c_email_address;

fetch c_email_address into :ls_members;
DO WHILE sqlca.sqlcode = 0 
	ls_email_address = ls_email_address + trim(ls_members) + ";"
	fetch c_email_address into :ls_members;
LOOP
close c_email_address;

if isnull(ls_email_address) or len(ls_email_address)< 1 then
	return -1
end if

//Build the WV email link 
ls_wv_link = gnv_data.of_getitem('ids','wv_meeting_link',false)
if right(ls_wv_link,1) = '/' then
	ls_meeting_link = ls_wv_link +'meeting/index.cfm?meeting_id='+string(al_meeting_id)
else
	ls_meeting_link = ls_wv_link +'/meeting/index.cfm?meeting_id='+string(al_meeting_id)
end if

openwithparm(w_get_email_address_message,ls_email_address+"|"+ls_meeting_link)
ls_mess = Message.StringParm
li_set_56 = of_get_app_setting("set_56","I")
if li_set_56 = 1 then
	//outlook	
	IF ls_mess = "Cancel" THEN Return -1
	IF IsNull(ls_mess) OR LenA(Trim(ls_mess)) < 1 THEN Return -1	
	ls_email_address = MidA( ls_mess, 1, PosA( ls_mess, "*" ) -1)
	ll_sub = PosA( ls_mess, "**" ) 
	ls_notetext = MidA( ls_mess, PosA( ls_mess, "*" ) +1, ll_sub - PosA( ls_mess, "*" ) - 1)	
	ls_subject = MidA( ls_mess, ll_sub +2)

	//---------- APPEON BEGIN ----------
	//$<modify> Evan 06.11.2012
	//$<reason> V12.2-Email Logging
	/*
	mSes = create mailSession	
	mRet = mailReturnSuccess!	
	mRet = mSes.mailLogon( mailNewSession!)
	IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon failed.  Check to make sure you have an email id setup in the user painter.')		
		Return -1
	END IF
	mMsg.Subject = ls_subject
	mMsg.NoteText = ls_notetext
	lnv_string.of_parsetoarray( ls_email_address, ';', ls_Recipient[])
	FOR ll_i = 1 To UpperBound(ls_Recipient[])
		mMsg.Recipient[ll_i].Name = Trim(ls_Recipient[ll_i])
	NEXT
	
	mRet = mSes.mailSend(mMsg)
	IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail Send", 'Mail not sent')
		mSes.mailLogoff()
		DESTROY mSes
		Return -1
	END IF
	mSes.mailLogoff()
	DESTROY mSes
	*/
	n_cst_outlook lnv_Outlook
	if lnv_Outlook.of_Logon() = -1 then
		MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
		Return -1
	end if
	ll_Return = lnv_Outlook.of_Send(ls_email_address, "", "", ls_subject, ls_notetext, "")
	lnv_Outlook.of_Logoff()
	if ll_Return <> 1 then
		MessageBox("Mail Send", "Mail not sent.")
		Return -1
	end if
	//---------- APPEON END ------------
else
	//Easy mail	
	IF ls_mess = "Cancel" THEN Return -1
	IF IsNull(ls_mess) OR LenA(Trim(ls_mess)) < 1 THEN Return -1 	
	ls_email_address = MidA( ls_mess, 1, PosA( ls_mess, "*" ) -1)
	ll_sub = PosA( ls_mess, "**" ) 
	ls_notetext = MidA( ls_mess, PosA( ls_mess, "*" ) +1, ll_sub - PosA( ls_mess, "*" ) - 1)	
	ls_subject = MidA( ls_mess, ll_sub +2) 

	if lnv_Mail.of_CreateObject() = -1 then
		f_show_message('create Email object','','','','')
		Return -1
	end if	
	
	ls_HtmlFile = ls_notetext
	//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
	/*
	//Set SMTP information from user ID
	//if lnv_Mail.of_GetDefaultAccount(gs_user_id,ls_Server,ll_Port,ll_Authmode,ls_Account,ls_Password,ls_Email) = -1 then Return -1
	if lnv_Mail.of_GetDefaultAccount(gs_user_id,ls_Server,ll_Port,ll_Authmode,ls_Account,ls_Password,ls_Email, li_smtpssl, li_pop3ssl) = -1 then Return -1	 //(BugA090401) Alfee 09.24.2013
	
	
	//ll_Return = lnv_Mail.of_SetSmtpInfo(ls_Server, ll_Port, ll_Authmode)
	ll_Return = lnv_Mail.of_SetSmtpInfo(ls_Server, ll_Port, ll_Authmode, li_smtpssl)	 //(BugA090401) Alfee 09.24.2013
	
	if  ll_Return < 0 then return ll_Return
	
	ll_Return = lnv_Mail.of_SetAccountAddress(ls_Account, ls_Password, ls_Email)
	*/
	str_email_account lstr_email_account 
	if lnv_Mail.of_GetDefaultAccount(gs_user_id,lstr_email_account) = -1 then Return -1
	ll_Return = lnv_Mail.of_SetSmtpInfo(lstr_email_account)
	
	if  ll_Return < 0 then return ll_Return
	
	ll_Return = lnv_Mail.of_SetAccountAddress(lstr_email_account)
	//---------End Modfiied ------------------------------------------------------
	
	luo_email_edit = create u_email_edit
	luo_email_edit.of_readfile(luo_email_edit.of_GetEmailDir() + "\Email.doc", lblb_MailContent)
	lnv_Mail.is_user_id = gs_user_id
	lnv_Mail.iblb_mailcontent = lblb_MailContent
	if isvalid(luo_email_edit) then destroy luo_email_edit	
	ll_Return = lnv_Mail.of_SendHtml(ls_email_address, ls_address_mailcc, '',ls_subject,ls_HtmlFile, ls_attach)
	if ll_Return <> 0 then	
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
		lnv_Mail.of_DeleteObject()
		return -1
	end if
	lnv_Mail.of_DeleteObject()
end if
return 0
end function

on w_send_to_committee.create
int iCurrent
call super::create
this.dw_priv_list=create dw_priv_list
this.rb_today=create rb_today
this.rb_meet=create rb_meet
this.st_3=create st_3
this.cb_all=create cb_all
this.cbx_profile=create cbx_profile
this.cbx_priv=create cbx_priv
this.dw_priv=create dw_priv
this.rb_wv=create rb_wv
this.rb_ef=create rb_ef
this.rb_p=create rb_p
this.dw_profile_view=create dw_profile_view
this.st_1=create st_1
this.dw_meet_date=create dw_meet_date
this.st_2=create st_2
this.cbx_print_summary=create cbx_print_summary
this.cb_cancel=create cb_cancel
this.cb_send=create cb_send
this.dw_profile=create dw_profile
this.dw_ver_info=create dw_ver_info
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.gb_1=create gb_1
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.r_print_stat_border=create r_print_stat_border
this.r_bar=create r_bar
this.gb_hide=create gb_hide
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_priv_list
this.Control[iCurrent+2]=this.rb_today
this.Control[iCurrent+3]=this.rb_meet
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.cb_all
this.Control[iCurrent+6]=this.cbx_profile
this.Control[iCurrent+7]=this.cbx_priv
this.Control[iCurrent+8]=this.dw_priv
this.Control[iCurrent+9]=this.rb_wv
this.Control[iCurrent+10]=this.rb_ef
this.Control[iCurrent+11]=this.rb_p
this.Control[iCurrent+12]=this.dw_profile_view
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.dw_meet_date
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.cbx_print_summary
this.Control[iCurrent+17]=this.cb_cancel
this.Control[iCurrent+18]=this.cb_send
this.Control[iCurrent+19]=this.dw_profile
this.Control[iCurrent+20]=this.dw_ver_info
this.Control[iCurrent+21]=this.st_4
this.Control[iCurrent+22]=this.st_5
this.Control[iCurrent+23]=this.st_6
this.Control[iCurrent+24]=this.gb_1
this.Control[iCurrent+25]=this.cb_1
this.Control[iCurrent+26]=this.gb_2
this.Control[iCurrent+27]=this.gb_3
this.Control[iCurrent+28]=this.r_print_stat_border
this.Control[iCurrent+29]=this.r_bar
this.Control[iCurrent+30]=this.gb_hide
end on

on w_send_to_committee.destroy
call super::destroy
destroy(this.dw_priv_list)
destroy(this.rb_today)
destroy(this.rb_meet)
destroy(this.st_3)
destroy(this.cb_all)
destroy(this.cbx_profile)
destroy(this.cbx_priv)
destroy(this.dw_priv)
destroy(this.rb_wv)
destroy(this.rb_ef)
destroy(this.rb_p)
destroy(this.dw_profile_view)
destroy(this.st_1)
destroy(this.dw_meet_date)
destroy(this.st_2)
destroy(this.cbx_print_summary)
destroy(this.cb_cancel)
destroy(this.cb_send)
destroy(this.dw_profile)
destroy(this.dw_ver_info)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.r_print_stat_border)
destroy(this.r_bar)
destroy(this.gb_hide)
end on

event open;call super::open;long ll_meet_id
integer li_row
DatawindowChild dwchild


ist_ids = Message.PowerObjectParm

dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("committee")

dw_meet_date.of_SetTransObject( SQLCA)
dw_meet_date.InsertRow( 0 )

dw_profile_view.of_SetTransObject( SQLCA)
dw_profile_view.InsertRow( 0 )


//Start Code Change ---- 12.13.2006 #V7 maha removed because duplicated none
//Start Code Change ----08.25.2009 #V92 maha - readded because was showing -999
dw_profile_view.getchild( "profile_view_id", dwchild)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "profile_view_id", -999 )
dwchild.SetItem( 1, "profile_view_name", "None" )
//End Code Change---08.25.2009
//End Code Change---12.13.2006
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 05.04.2006 By: Liu Hongxin
//$<reason> Appeon deal with NULL differently from that in PowerBuilder.
//$<modification> Set -999 as the initial value of dw_profile_view.
dw_profile_view.setitem(1 , 'profile_view_id',-999)
//---------------------------- APPEON END ----------------------------
r_bar.Width = 1

dw_meet_date.GetChild( "meeting_date", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( ist_ids.i_ids[2] ,Today() )

//------------------- APPEON BEGIN -------------------  //Start Code Change ----03.272012 #V12 maha - readded from 11.3
//$<add> Stephen 06.23.2011
//$<reason>V11.3 Committee Proc Upd
ll_meet_id =  ist_ids.l_app_id

li_row = dwchild.find("meetings_meeting_id = "+string(ll_meet_id),1, dwchild.rowcount())
if li_row > 0 then
	dw_meet_date.setitem(1, "meeting_date", dwchild.getitemdatetime(li_row,"meetings_start_date"))
end if
//------------------- APPEON END -------------------

dw_profile_view.SetFocus()


end event

type dw_priv_list from u_dw within w_send_to_committee
boolean visible = false
integer x = 1687
integer y = 1764
integer width = 233
integer height = 160
integer taborder = 30
string dataobject = "d_prac_priv_list_all_status_w_notes"
end type

type rb_today from radiobutton within w_send_to_committee
integer x = 1307
integer y = 456
integer width = 421
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Today~'s date"
end type

event clicked;//Start Code Change ----02.27.2013 #V12 maha - added rb
end event

type rb_meet from radiobutton within w_send_to_committee
integer x = 736
integer y = 456
integer width = 434
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Meeting Date"
boolean checked = true
end type

event clicked;//Start Code Change ----02.27.2013 #V12 maha - added rb
end event

type st_3 from statictext within w_send_to_committee
integer x = 110
integer y = 456
integer width = 549
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Set Sent To date to:"
boolean focusrectangle = false
end type

type cb_all from commandbutton within w_send_to_committee
integer x = 96
integer y = 1064
integer width = 151
integer height = 68
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "All"
end type

event clicked;cbx_print_summary.checked  = true
cbx_priv.checked  = true
cbx_profile.checked  = true
end event

type cbx_profile from checkbox within w_send_to_committee
integer x = 128
integer y = 736
integer width = 763
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Include Data Profile"
end type

type cbx_priv from checkbox within w_send_to_committee
integer x = 128
integer y = 964
integer width = 846
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Include Requested Privileges"
end type

type dw_priv from u_dw within w_send_to_committee
boolean visible = false
integer x = 2039
integer y = 1760
integer width = 215
integer height = 172
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_prf_master"
boolean vscrollbar = false
boolean border = false
end type

type rb_wv from radiobutton within w_send_to_committee
integer x = 1015
integer y = 116
integer width = 709
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "WebView Meeting Email"
end type

event clicked;gb_hide.visible = true
end event

type rb_ef from radiobutton within w_send_to_committee
integer x = 2162
integer y = 1404
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32891346
string text = "Electronic File"
end type

type rb_p from radiobutton within w_send_to_committee
integer x = 425
integer y = 116
integer width = 430
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Printed Files"
boolean checked = true
end type

event clicked;gb_hide.visible = false
end event

type dw_profile_view from u_dw within w_send_to_committee
integer x = 955
integer y = 736
integer width = 919
integer height = 84
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pfl_select_views_dddw_list_no_hdr"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetReqColumn(True)
end event

type st_1 from statictext within w_send_to_committee
integer x = 969
integer y = 668
integer width = 722
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Profile"
boolean focusrectangle = false
end type

type dw_meet_date from u_dw within w_send_to_committee
integer x = 777
integer y = 344
integer width = 411
integer height = 72
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_cred_meeting_date"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetReqColumn(True)
end event

type st_2 from statictext within w_send_to_committee
integer x = 110
integer y = 352
integer width = 672
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Committee Meeting Date:"
boolean focusrectangle = false
end type

type cbx_print_summary from checkbox within w_send_to_committee
integer x = 128
integer y = 848
integer width = 837
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Include Verification Summary"
end type

type cb_cancel from u_cb within w_send_to_committee
integer x = 1001
integer y = 1444
integer width = 471
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;Integer li_ans

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.24.2006 By: LeiWei
//$<reason> Fix a defect.
//IF r_bar.Width = 1 THEN
IF r_bar.Width <= 1 OR Isnull(r_bar.Width) THEN
//---------------------------- APPEON END ----------------------------
	li_ans = MessageBox("Send To Committee", "Close without sending to committee?", Question!, YesNo!, 2)
	IF li_ans = 2 THEN
		Return 
	ELSE
		CloseWithReturn( Parent, "Cancel" )
	END IF
ELSE
	CloseWithReturn( Parent, "Sent" )	
END IF


end event

type cb_send from u_cb within w_send_to_committee
integer x = 453
integer y = 1444
integer width = 530
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Send To Committee"
boolean default = true
end type

event clicked;pfc_cst_u_reports inv_reports
Integer li_prac_cnt
Integer i, li_row
Integer li_profile_view
Integer li_bar_ticks
Integer li_facility_id
Integer li_ans
integer li_set_chk
Long ll_prac_id
Long ll_prac[]
Long li_facility_ids[]
long ll_appt_rec[]  //maha 12.15.2014
long ll_recid //10.10.2014
Date ld_meet_date
Date ld_today = Today()
DateTime ldt_todaysDate
string ls_facility_name //maha110602
string ls_appt_type
string ls_ir_filter
long   ll_meeting_id
datawindowchild ldwc_meet

ldt_todaysDate = DateTime( Today() )


	IF r_bar.Width > 1 THEN
		li_ans = MessageBox("Print", "Are you sure you want to Reprint?", Question!, YesNo!, 2)
		IF li_ans = 2 THEN
			Return
		END IF
	END IF
	
	r_bar.Width = 1
	
	li_profile_view = dw_profile_view.GetItemNumber(1, "profile_view_id")
	

	
	string ls_datatype
	ls_datatype = dw_meet_date.Describe( "meeting_date.ColType" )
	IF ls_datatype = "date" THEN
		ld_meet_date = dw_meet_date.GetItemDate( 1, "meeting_date" )
	ELSEIF ls_datatype = "datetime" THEN
		ld_meet_date = Date(dw_meet_date.GetItemDateTime( 1, "meeting_date" ))
	END IF
	//---------------------------- APPEON END ----------------------------
	
	IF IsNull( ld_meet_date ) THEN
		MessageBox("Meeting Date", "A Meeting Date must be selected!", Question!)
		dw_meet_date.SetFocus()
		Return
	END IF
	
	if rb_meet.checked then ldt_todaysDate = datetime(ld_meet_date, time(00:00:00))  //Start Code Change ----02.27.2013 #V12 maha
	
	SetPointer( HourGlass! )
	
	inv_reports = CREATE	pfc_cst_u_reports
	
	
	li_facility_id = ist_ids.i_ids[1]
	li_facility_ids[1] = li_facility_id
	
	
//	li_prac_cnt = UpperBound( ist_ids.l_ids )
	li_prac_cnt = UpperBound( ist_ids.sl_prac_ids )
	

	dw_ver_info.of_SetTransObject( SQLCA )
	dw_priv_list.of_SetTransObject( SQLCA )  //(Appeon)Stephen 12.16.2014 - Bug #4354 - Requested privileges are not included when sending a provider to committee
	
	li_bar_ticks = 1000 / li_prac_cnt
	
FOR i = 1 TO li_prac_cnt
	ll_prac_id = ist_ids.sl_prac_ids[ i ] //Start Code Change ----04.19.2012 #V12 maha - moved out of if below
	ll_prac[1] = ll_prac_id
	ll_recid =  ist_ids.l_ids[ i ]
	ll_appt_rec[1] = ll_recid   //Start Code Change ----12.15.2014 #V14.2 maha - for midcycle
	if rb_p.checked then  //Start Code Change ----03.26.2012 #V12 maha - added if when printing
		//IF li_profile_view <> 0 THEN
		IF li_profile_view > 0 THEN //Start Code Change ---- 03.13.2007 #V7 maha was printing a blank
			//inv_reports.of_profile_report( dw_profile, li_facility_id, ll_prac_id, li_profile_view,false )
			inv_reports.of_profile_report_v8( dw_profile, li_facility_id, ll_prac_id, li_profile_view,false, dw_profile, 1 )	//alfee 03.04.2010			
			dw_profile.Print()
		END IF
		IF cbx_print_summary.Checked THEN
			//Start Code Change ----12.15.2014 #V14.2 maha - modified for midcycle also:dataobject changed to d_prf_ver_results_prac 

			//dw_ver_info.Retrieve(li_facility_ids, ll_prac) //maha modified to array 041305
			dw_ver_info.Retrieve(ll_appt_rec[], ll_prac)  //Start Code Change ----12.15.2014 #V14.2 maha - for midcycle
			//End Code Change ----12.15.2014
			//\/maha added 11-06-02 to add facility name to report
			SELECT facility.facility_name  
			INTO :ls_facility_name  
			FROM facility  
			WHERE facility.facility_id = :li_facility_id   ;
			dw_ver_info.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" )
			//\maha
			//Start Code Change ----07.09.2009 #V92 maha - migrated from prac folder code
			li_set_chk = of_get_app_setting("set_55","I") 
			if  li_set_chk = 1 then //CCVS filter
				select apptmnt_type into :ls_appt_type from pd_affil_stat where active_status in (1,4) and parent_facility_id = :li_facility_id and prac_id = :ll_prac_id;
				pfc_n_cst_ai_printletters lnv_printletters
				 lnv_printletters = create pfc_n_cst_ai_printletters
				ls_ir_filter = lnv_printletters.of_set_i_r_filter (ls_appt_type,li_facility_id)
				ls_ir_filter  = MidA (ls_ir_filter,8) //remove ' and ( '
				ls_ir_filter  = MidA (ls_ir_filter,1,LenA(ls_ir_filter ) - 2) //remove last ')'
				if dw_ver_info.setfilter(ls_ir_filter) = 1 then
					dw_ver_info.filter()
				else
					messagebox("","ccvs filter failed")
				end if
				destroy lnv_printletters
			elseif  li_set_chk = 2 then//exp cred filter//Start Code Change ----07.09.2009 #V92 maha -  added to filter out exp cred verifications
				ls_ir_filter = "code_lookup_code <> 'Exp Cred Ltr'"
				if dw_ver_info.setfilter(ls_ir_filter) = 1 then
					dw_ver_info.filter()
				else
					messagebox("Verification Profile","exp cred filter failed")
				end if
			end if
			//End Code Change---07.09.2009

			dw_ver_info.Print()
		END IF
		//---------Begin Added by (Appeon)Stephen 12.16.2014 for Bug #4354 - Requested privileges are not included when sending a provider to committee--------
		if cbx_priv.checked then
			dw_priv_list.retrieve(ll_prac_id, li_facility_ids)
			dw_priv_list.setfilter("code_lookup_code = 'REQST'")
			dw_priv_list.filter()
			if dw_priv_list.rowcount() > 0 then dw_priv_list.print()
			dw_priv_list.setfilter("")
		end if
		//---------End Added ------------------------------------------------------
	end if  //printed items
				
//debugbreak()	
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 06.23.2011
	//$<reason>V11.3 Committee Proc Upd
	dw_meet_date.getchild("meeting_date", ldwc_meet)
	li_row = ldwc_meet.getrow()
	if li_row > 0 then
		ll_meeting_id = ldwc_meet.getitemnumber(li_row, "meetings_meeting_id")
	else
		ll_meeting_id = ist_ids.l_app_id
	end if
	//------------------- APPEON END -------------------
	//---------Begin Added by (Appeon)Stephen 06.22.2017 for V15.3 Bug # 5709 - Ready for Committee checkbox: Provider shows on Ready for Committee tab but does not show on Post Committee Results--------
//Start Code Change ----06.22.2017 #V154 maha - commented
//	update pd_affil_stat
//	     set date_verif_completed = :ldt_TodaysDate
//	 where rec_id = :ll_recid
//	     and date_verif_completed is null;
//	IF SQLCA.SQLCODE < 0 THEN
//		MessageBox("SQL Error", "Error updating pd_affil_stat table." )
//		ROLLBACK USING SQLCA;
//		Return -1
//	END IF
	//---------End Added ------------------------------------------------------
	
	//Start Code Change ----10.10.2014 #V14.2 maha - modified update with recid and status of 6
	UPDATE pd_comm_review  
   SET date_sent_for_review = :ldt_TodaysDate ,
	     meeting_id = :ll_meeting_id
   WHERE ( pd_comm_review.facility_id = :li_facility_id ) AND  
         ( pd_comm_review.prac_id = :ll_prac_id ) AND  
			  ( pd_comm_review.rec_id = :ll_recid ) AND
			( pd_comm_review.committee_id = :ist_ids.i_ids[2]) AND
         ( pd_comm_review.active_status in (1,4,6) )   ;
	//End Code Change ----10.10.2014 
	IF SQLCA.SQLCODE < 0 THEN
		MessageBox("SQL Error", "Error updating pd_comm_review table." )
		ROLLBACK USING SQLCA;
		Return -1
	END IF
	r_bar.Width = r_bar.Width + li_bar_ticks
END FOR

COMMIT USING SQLCA;

//------------------- APPEON BEGIN -------------------
//$<add> Michael 02.09.2012
//$<reason> V12.1 meeting
if rb_wv.checked then
	of_email_wvlnk(ll_meeting_id,li_facility_id)
end if
//------------------- APPEON END ---------------------
Close( Parent )



end event

type dw_profile from u_dw within w_send_to_committee
boolean visible = false
integer x = 1088
integer y = 1824
integer width = 137
integer height = 96
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_prf_master"
boolean vscrollbar = false
boolean border = false
end type

type dw_ver_info from u_dw within w_send_to_committee
boolean visible = false
integer x = 1385
integer y = 1796
integer width = 242
integer height = 136
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_prf_ver_results_prac"
boolean vscrollbar = false
boolean border = false
end type

type st_4 from statictext within w_send_to_committee
integer x = 448
integer y = 1244
integer width = 96
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "0%"
boolean focusrectangle = false
end type

type st_5 from statictext within w_send_to_committee
integer x = 1330
integer y = 1232
integer width = 133
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "100%"
boolean focusrectangle = false
end type

type st_6 from statictext within w_send_to_committee
integer x = 448
integer y = 1112
integer width = 722
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Process Status"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_send_to_committee
integer x = 50
integer y = 276
integer width = 1893
integer height = 288
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Meeting"
end type

type cb_1 from commandbutton within w_send_to_committee
integer x = 1307
integer y = 340
integer width = 416
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Meeting"
end type

event clicked;close(parent)
open(w_meetings)
end event

type gb_2 from groupbox within w_send_to_committee
integer x = 50
integer y = 36
integer width = 1897
integer height = 204
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Process Type"
end type

type gb_3 from groupbox within w_send_to_committee
integer x = 55
integer y = 616
integer width = 1888
integer height = 724
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Profiles"
end type

type r_print_stat_border from statictext within w_send_to_committee
integer x = 448
integer y = 1172
integer width = 1001
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 12632256
boolean focusrectangle = false
end type

type r_bar from statictext within w_send_to_committee
integer x = 448
integer y = 1172
integer width = 1001
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 8388608
boolean focusrectangle = false
end type

type gb_hide from groupbox within w_send_to_committee
boolean visible = false
integer x = 46
integer y = 568
integer width = 1947
integer height = 832
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

