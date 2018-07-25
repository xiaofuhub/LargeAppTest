$PBExportHeader$w_appl_website_fill1.srw
forward
global type w_appl_website_fill1 from w_main
end type
type st_stamp from statictext within w_appl_website_fill1
end type
type st_3 from statictext within w_appl_website_fill1
end type
type dw_crawler from u_dw within w_appl_website_fill1
end type
type dw_last_log from u_dw within w_appl_website_fill1
end type
type cb_close from commandbutton within w_appl_website_fill1
end type
type cb_forward from commandbutton within w_appl_website_fill1
end type
type cb_back from commandbutton within w_appl_website_fill1
end type
type uo_prac_data from pcf_cst_prac_data_view within w_appl_website_fill1
end type
type ole_browser from olecustomcontrol within w_appl_website_fill1
end type
end forward

global type w_appl_website_fill1 from w_main
integer width = 4549
integer height = 2676
string title = "Batch Web Verifications"
windowtype windowtype = popup!
long backcolor = 33551856
st_stamp st_stamp
st_3 st_3
dw_crawler dw_crawler
dw_last_log dw_last_log
cb_close cb_close
cb_forward cb_forward
cb_back cb_back
uo_prac_data uo_prac_data
ole_browser ole_browser
end type
global w_appl_website_fill1 w_appl_website_fill1

type variables
long il_pracs[]
long il_batch
long il_pracid
long il_screen
long il_dvid = 1
long il_rec_id
long il_wc_id
long il_facility
long il_entity
string is_save_type = 'N'
string is_prac_names[]
string is_url
string is_type
string is_lookup_search_column_field = "None" 
string is_lookup_search_column_table = "None"
string is_sql_syntax
string is_first_column_detail_1
pfc_cst_nv_data_entry_functions inv_data_fun
pfc_n_cst_ai_action_items  inv_action_items
end variables

forward prototypes
public function integer of_get_sreen_print (integer ai_format)
public function integer of_capture_html ()
public function integer of_capture_bmp ()
end prototypes

public function integer of_get_sreen_print (integer ai_format);//Start Code Change ----07.10.2014 #V14.2 maha - added alternative capture method
String ls_fname
Blob lblb_bitmap
n_bitmap in_bitmap
n_runandwait in_runandwait
String is_tempdir
string ls_doc_id
string ls_text
long ll_id

//if il_current_row < 1 then return //(Appeon)Stephen 10.22.2014 - BugS101401
if ai_format = 2 then  //html
//	Return of_Capture() //Add by Evan 03.26.2009
elseif ai_format = 1 then //screenprint
	SetPointer(HourGlass!)
	
	ls_fname = gs_dir_path + "intellicred\webcapt.bmp"
	
//	ls_text = "Captured by: " + gs_user_id + "         Date: " + string(today()) + " " +  string(Now())
//	st_datestamp.text = ls_text
//	st_datestamp.visible = true
//	st_datestamp.bringtotop = true
	
	lblb_bitmap = in_bitmap.of_WindowCapture(w_batch_manual_verifications, False)
	
//	st_datestamp.visible = false
//	st_datestamp.bringtotop = false
	
	in_bitmap.of_WriteBlob(ls_fname, lblb_bitmap)

//	tab_1.tabpage_view.st_cap_mess.text = "Web Page Captured"
//	ls_doc_id = idw_verif_list.GetItemString(il_current_row, "doc_id")
	
	UPDATEBLOB verif_info
	SET verification_picture = :lblb_bitmap
	WHERE doc_id = :ls_doc_id
	USING SQLCA;
	if SQLCA.SQLCode = -1 then
		ROLLBACK USING SQLCA;
		MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
//	tab_1.tabpage_view.st_cap_mess.text = "Database Updated With Web Screen Shot."
	
	UPDATE verif_info
	SET verification_picture_flag = 3
	WHERE doc_id = :ls_doc_id
	USING SQLCA;
	if SQLCA.SQLCode = -1 then
		ROLLBACK USING SQLCA;
		MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
//	idw_verif_list.SetItem(il_current_row, "verification_picture_flag", 4)
	
	//MessageBox("Capture", "Update successfully!")
//	MessageBox("Capture", "Update successful!") //Modified by Appeon long.zhang 09.09.2014 (v14.2 update successfully->update successful)
end if

end function

public function integer of_capture_html ();// Start Code Change ----07.20.2015 #V15 maha
//Copied from verification batch screen capture function

integer li_Return
integer li_Null
long ll_counter, ll_loops
long ll_logid
long ll_cnt
string ls_doc_id
string ls_Error
string ls_URL
string ls_FileName
blob lblb_verif_picture

inet lnv_inet
n_internetresult lnv_InternetResult
n_cst_dm_utils lnv_file
n_cst_appeondll lnv_AppeonDll

SetNull(li_Null)
ls_FileName =  gs_temp_path + "capture.htm"
FileDelete(ls_FileName)

SetPointer(HOURGLASS!) 

//ll_logid = dw_log.getitemnumber(1,"log_id")

try
	//-----Begin modified by alfee 04.16.2010 ---------------------------------
	lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 1) //modify file name & save	
	ole_browser.object.ExecWB(4, 2, ls_FileName, li_Null)


catch (RuntimeError e)
//	tab_1.tabpage_view.st_cap_mess.text = "Web Page not Captured"
	lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 0) //close the thread - alfee 04.16.2010
	Return -1
end try

do while true
	Yield()
	if FileExists(ls_FileName) then Exit
	//---------Begin Added by alfee 04.16.2010 -------------------------------
	ll_loops ++
	if ll_loops > 99999 and appeongetclienttype() = 'WEB' then 
		//Prompt user from second time
		if ll_counter > 0 then 
			if messagebox(ls_FileName, "Waiting for capture file. Continue to wait?",question!,yesno!,1) = 2 then
//				tab_1.tabpage_view.st_cap_mess.text = "Web Page not Captured"
				lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 0) //close the thread
				Return -1								
			end if
		end if
		
		//Popup the SaveAs dialog and wait to save the Web page manually
		ll_loops = 0
		ll_counter ++
//		tab_1.tabpage_view.st_cap_mess.text = "Make sure the File name is '" + ls_FileName + "' and the Save as type is 'Web Page, HTML only'."
		lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 2)	//modify the file name (not always working)
		ole_browser.object.ExecWB(4, 1, ls_FileName, li_Null) 
	end if
	//---------End Added ------------------------------------------------------
loop

lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 0) //close the thread - alfee 04.16.2010

lnv_file.of_ReadBlob(ls_FileName, lblb_verif_picture)
//------------------- APPEON END ---------------------

// Update HTML source to database
//tab_1.tabpage_view.st_cap_mess.text = "Web Page Captured"
//ls_doc_id = idw_verif_list.GetItemString(il_current_row, "doc_id")

//---------Begin Added by (Appeon)Stephen 09.18.2016 for V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row--------
select count(1) into :ll_cnt from verif_batch_log_image where log_id = :ll_logid;
if ll_cnt < 1 then
//---------End Added ------------------------------------------------------
	insert into verif_batch_log_image (log_id, prac_id, rec_id, image_type) values(:ll_logid, :il_pracid, :il_rec_id, 'htm' );
	if SQLCA.SQLCode = -1 then
			MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
end if //(Appeon)Stephen 09.18.2016 - V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row

UPDATEBLOB verif_batch_log_image
SET image_data = :lblb_verif_picture
WHERE log_id = :ll_logid
USING SQLCA;

if SQLCA.SQLCode = -1 then
	ROLLBACK USING SQLCA;
	MessageBox("SQL Error", SQLCA.SQLErrText)
	Return -1
end if
//tab_1.tabpage_view.st_cap_mess.text = "Database Updated With Web Screen Shot."

//UPDATE verif_info
//SET verification_picture_flag = 3
//WHERE doc_id = :ls_doc_id
//USING SQLCA;
//if SQLCA.SQLCode = -1 then
//	ROLLBACK USING SQLCA;
//	MessageBox("SQL Error", SQLCA.SQLErrText)
//	Return -1
//end if
//idw_verif_list.SetItem(il_current_row, "verification_picture_flag", 3)


MessageBox("Capture", "Update successful!")// Modified by Appeon long.zhang 09.09.2014 (v14.2 update successfully->update successful)
Return 1
end function

public function integer of_capture_bmp ();//Start Code Change ----07.21.2015 #V15 maha - copied from Web verifications screen
String ls_fname
Blob lblb_bitmap
n_bitmap in_bitmap
n_runandwait in_runandwait
String is_tempdir
string ls_doc_id
string ls_text
long ll_logid
long lw
long lh
long ll_cnt
n_cst_datetime lnv

SetPointer(HourGlass!)
	
ls_fname = gs_dir_path + "intellicred\webcapt.bmp"
	
ls_text = "Captured by: " + gs_user_id + "         Date: " + string(today()) + " " +  string(Now())
st_stamp.text = ls_text
st_stamp.visible = true
st_stamp.bringtotop = true

lw =  w_batch_manual_verifications.Width 
lh = w_batch_manual_verifications.Height

ole_browser.bringtotop = true
ole_browser.width = w_batch_manual_verifications.Width 
ole_browser.height = w_batch_manual_verifications.Height
ole_browser.x = 10
ole_browser.y = 100

lnv.of_wait(1)

//return 1
lblb_bitmap = in_bitmap.of_WindowCapture(w_batch_manual_verifications, False)

//messagebox(string(lw) + " - " + string(lh),  string(ole_browser.width) + " - " + string(ole_browser.height))

w_batch_manual_verifications.triggerevent(resize!)
st_stamp.visible = false
	
//	st_datestamp.visible = false
//	st_datestamp.bringtotop = false
//	
in_bitmap.of_WriteBlob(ls_fname, lblb_bitmap)



//ll_logid = dw_log.getitemnumber(1,"log_id")

//---------Begin Added by (Appeon)Stephen 09.18.2016 for V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row--------
select count(1) into :ll_cnt from verif_batch_log_image where log_id = :ll_logid;
if ll_cnt < 1 then
//---------End Added ------------------------------------------------------
	insert into verif_batch_log_image (log_id, prac_id, rec_id, image_type) values(:ll_logid, :il_pracid, :il_rec_id, 'bmp' );
	if SQLCA.SQLCode = -1 then
			MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
end if //(Appeon)Stephen 09.18.2016 - V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row

UPDATEBLOB verif_batch_log_image
SET image_data = :lblb_bitmap
WHERE log_id = :ll_logid
USING SQLCA;

if SQLCA.SQLCode = -1 then
	ROLLBACK USING SQLCA;
	MessageBox("SQL Error", SQLCA.SQLErrText)
	Return -1
end if
	
//MessageBox("Capture", "Update successful!") 
return 1

end function

on w_appl_website_fill1.create
int iCurrent
call super::create
this.st_stamp=create st_stamp
this.st_3=create st_3
this.dw_crawler=create dw_crawler
this.dw_last_log=create dw_last_log
this.cb_close=create cb_close
this.cb_forward=create cb_forward
this.cb_back=create cb_back
this.uo_prac_data=create uo_prac_data
this.ole_browser=create ole_browser
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_stamp
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.dw_crawler
this.Control[iCurrent+4]=this.dw_last_log
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_forward
this.Control[iCurrent+7]=this.cb_back
this.Control[iCurrent+8]=this.uo_prac_data
this.Control[iCurrent+9]=this.ole_browser
end on

on w_appl_website_fill1.destroy
call super::destroy
destroy(this.st_stamp)
destroy(this.st_3)
destroy(this.dw_crawler)
destroy(this.dw_last_log)
destroy(this.cb_close)
destroy(this.cb_forward)
destroy(this.cb_back)
destroy(this.uo_prac_data)
destroy(this.ole_browser)
end on

event resize;call super::resize; //Start Code Change ----05.14.2015 #V15 maha 
long ll_win_h
long ll_win_w
long ll_ole_h
long ll_ole_w
long ll_wsplit
long ll_hsplit


ll_win_h = this.WorkSpaceHeight() - 100
//
ole_browser.height = ll_win_h
uo_prac_data.height = ole_browser.height + 24
//ll_hsplit = ll_win_h / 4 - 5
//dw_select_section.height = ll_hsplit
//dw_browse.height = ll_hsplit
//dw_detail.height = ll_hsplit * 2
//
//dw_browse.y = dw_select_section.y + dw_select_section.height + 5
//dw_detail.y = dw_browse.y + dw_browse.height + 5

ll_win_w = this.WorkSpaceWidth() -20
ll_wsplit = ll_win_w / 4
ole_browser.width = ll_wsplit * 3
uo_prac_data.width = ll_wsplit 
ole_browser.x = ll_wsplit + 10

uo_prac_data.of_resize(uo_prac_data.ib_link)
//dw_select_section.width = ll_wsplit 
//dw_browse.width = ll_wsplit 
//dw_detail.width = ll_wsplit 
//






end event

event open;call super::open; //Start Code Change ----07.07.2015 #V15 maha - Added for 15.1
 string ls_site
 
 inv_data_fun = create pfc_cst_nv_data_entry_functions
 inv_data_fun.of_setup_cache()
inv_data_fun.of_refresh_cache()

il_pracid = 1
il_dvid = 1
il_screen = 1

ls_site = "http://commerce.alaska.gov/cbp/Main/CBPLSearch.aspx?mode=Prof"
ole_browser.visible = true
try
	ole_browser.object.navigate(ls_site)
	catch (RuntimeError e)
end try

uo_prac_data.of_initiate( il_pracid, il_dvid, 2)

//dw_detail.of_settransobject( sqlca)
//dw_select_section.retrieve(1)
//dw_detail.of_SetDropDownCalendar( TRUE )
//dw_detail.iuo_calendar.of_Register(dw_detail.iuo_calendar.DDLB)
//dw_pracs.retrieve(1)
//of_get_data()


end event

event close;call super::close;destroy inv_data_fun
end event

type st_stamp from statictext within w_appl_website_fill1
boolean visible = false
integer x = 2747
integer y = 24
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "st_stamp"
boolean focusrectangle = false
end type

type st_3 from statictext within w_appl_website_fill1
integer x = 5
integer y = 8
integer width = 2679
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Double-click data to place on clipboard. You can right-click->Paste into the Browser field."
boolean focusrectangle = false
end type

type dw_crawler from u_dw within w_appl_website_fill1
boolean visible = false
integer x = 3959
integer y = 368
integer width = 91
integer height = 56
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_wc_hdr_imp"
boolean hscrollbar = true
end type

type dw_last_log from u_dw within w_appl_website_fill1
boolean visible = false
integer x = 3607
integer y = 344
integer width = 210
integer height = 84
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_batch_verif_log_last"
boolean vscrollbar = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.of_setupdateable(false)
end event

type cb_close from commandbutton within w_appl_website_fill1
integer x = 4142
integer y = 8
integer width = 343
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)

end event

type cb_forward from commandbutton within w_appl_website_fill1
integer x = 3771
integer y = 8
integer width = 325
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Forward >>"
end type

event clicked;//---------Begin Modified by alfee 08.11.2010 --------
//If ole_browser.bringtotop = True Then
	ole_browser.object.goforward()
//ElseIf ole_browser2.bringtotop = True Then
//	ole_browser2.object.goforward()
//End If
//tab_1.tabpage_view.ole_browser.object.goforward()
//---------End Modified ------------------------------

end event

type cb_back from commandbutton within w_appl_website_fill1
integer x = 3438
integer y = 8
integer width = 325
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<< Back"
end type

event clicked;try

//	If ole_browser.bringtotop = True Then
		ole_browser.object.goback()
//	ElseIf ole_browser2.bringtotop = True Then
//		ole_browser2.object.goback()
//	End If

	//---------End Modified ------------------------------	
catch (RuntimeError e) // Add by Evan on 10.19.2009
end try
end event

type uo_prac_data from pcf_cst_prac_data_view within w_appl_website_fill1
integer y = 88
integer height = 2468
integer taborder = 20
boolean bringtotop = true
end type

on uo_prac_data.destroy
call pcf_cst_prac_data_view::destroy
end on

type ole_browser from olecustomcontrol within w_appl_website_fill1
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean ab_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean ab_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean ab_resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean ab_cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean ab_cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean ab_cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
integer x = 1111
integer y = 92
integer width = 3397
integer height = 2468
integer taborder = 20
boolean focusrectangle = false
string binarykey = "w_appl_website_fill1.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event commandstatechange(long command, boolean enable);CHOOSE CASE command
CASE 1 //CSC_NAVIGATEFORWARD
	cb_forward.enabled = enable
CASE 2 //CSC_NAVIGATEBACK
	cb_back.enabled = enable
END CHOOSE
end event

event newwindow2(ref oleobject ppdisp, ref boolean ab_cancel);//alfee 08.11.2010

//ole_browser2.Visible = True
//ole_browser2.object.RegisterAsBrowser = True
//ppDisp =ole_browser2.object
end event

event navigatecomplete2(oleobject pdisp, any url);//code to enable back button

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
03w_appl_website_fill1.bin 
2400000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000028cd35b001d2975400000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f0000000028cd35b001d2975428cd35b001d29754000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00004ccb00003fc50000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00004ccb00003fc50000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13w_appl_website_fill1.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
