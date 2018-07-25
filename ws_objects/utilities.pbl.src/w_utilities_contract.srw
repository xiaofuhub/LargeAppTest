$PBExportHeader$w_utilities_contract.srw
forward
global type w_utilities_contract from w_utilities5
end type
type cb_ocr from commandbutton within w_utilities_contract
end type
type cb_convert from commandbutton within w_utilities_contract
end type
type cb_update_action from commandbutton within w_utilities_contract
end type
type cb_create_ftx from commandbutton within w_utilities_contract
end type
type cb_weblink from commandbutton within w_utilities_contract
end type
type cb_esign_settings from commandbutton within w_utilities_contract
end type
type cb_rdfilter_set from commandbutton within w_utilities_contract
end type
type cb_merge_category from commandbutton within w_utilities_contract
end type
type cb_ctx_upg from commandbutton within w_utilities_contract
end type
type cb_email_audit from commandbutton within w_utilities_contract
end type
type cb_picture_painter from commandbutton within w_utilities_contract
end type
type cb_screen_picture from commandbutton within w_utilities_contract
end type
type cb_copy_data_in_different_database from commandbutton within w_utilities_contract
end type
end forward

global type w_utilities_contract from w_utilities5
integer width = 2341
integer height = 1524
string title = "IntelliContract Utilities"
cb_ocr cb_ocr
cb_convert cb_convert
cb_update_action cb_update_action
cb_create_ftx cb_create_ftx
cb_weblink cb_weblink
cb_esign_settings cb_esign_settings
cb_rdfilter_set cb_rdfilter_set
cb_merge_category cb_merge_category
cb_ctx_upg cb_ctx_upg
cb_email_audit cb_email_audit
cb_picture_painter cb_picture_painter
cb_screen_picture cb_screen_picture
cb_copy_data_in_different_database cb_copy_data_in_different_database
end type
global w_utilities_contract w_utilities_contract

on w_utilities_contract.create
int iCurrent
call super::create
this.cb_ocr=create cb_ocr
this.cb_convert=create cb_convert
this.cb_update_action=create cb_update_action
this.cb_create_ftx=create cb_create_ftx
this.cb_weblink=create cb_weblink
this.cb_esign_settings=create cb_esign_settings
this.cb_rdfilter_set=create cb_rdfilter_set
this.cb_merge_category=create cb_merge_category
this.cb_ctx_upg=create cb_ctx_upg
this.cb_email_audit=create cb_email_audit
this.cb_picture_painter=create cb_picture_painter
this.cb_screen_picture=create cb_screen_picture
this.cb_copy_data_in_different_database=create cb_copy_data_in_different_database
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ocr
this.Control[iCurrent+2]=this.cb_convert
this.Control[iCurrent+3]=this.cb_update_action
this.Control[iCurrent+4]=this.cb_create_ftx
this.Control[iCurrent+5]=this.cb_weblink
this.Control[iCurrent+6]=this.cb_esign_settings
this.Control[iCurrent+7]=this.cb_rdfilter_set
this.Control[iCurrent+8]=this.cb_merge_category
this.Control[iCurrent+9]=this.cb_ctx_upg
this.Control[iCurrent+10]=this.cb_email_audit
this.Control[iCurrent+11]=this.cb_picture_painter
this.Control[iCurrent+12]=this.cb_screen_picture
this.Control[iCurrent+13]=this.cb_copy_data_in_different_database
end on

on w_utilities_contract.destroy
call super::destroy
destroy(this.cb_ocr)
destroy(this.cb_convert)
destroy(this.cb_update_action)
destroy(this.cb_create_ftx)
destroy(this.cb_weblink)
destroy(this.cb_esign_settings)
destroy(this.cb_rdfilter_set)
destroy(this.cb_merge_category)
destroy(this.cb_ctx_upg)
destroy(this.cb_email_audit)
destroy(this.cb_picture_painter)
destroy(this.cb_screen_picture)
destroy(this.cb_copy_data_in_different_database)
end on

event open;call super::open;//---------Begin Added by (Appeon)Toney 08.07.2013 for V141 ISG-CLX--------
If AppeonGetClientType() = 'PB' Then
	cb_weblink.enabled = False
End If
//---------End Added ------------------------------------------------------------------

//---------Begin Added by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
//Begin - Added By Mark Lee 03/04/2013 access_utility_menu
String 	ls_tmp
ls_tmp = gnv_data.of_getitem( "icred_settings", "access_utility_menu",FALSE)
If isnull(ls_tmp) Or trim(ls_tmp) = '' or ls_tmp = '0' or gs_dbtype = 'ASA' Then
	cb_copy_data_in_different_database.enabled = False
Else
	cb_copy_data_in_different_database.enabled = True	
End IF 
//End - Added By Mark Lee 03/04/2013
//---------End Added ------------------------------------------------------
end event

type cb_usertracking from w_utilities5`cb_usertracking within w_utilities_contract
integer x = 41
integer y = 1052
integer width = 933
end type

type cb_report_log from w_utilities5`cb_report_log within w_utilities_contract
end type

type cb_sign from w_utilities5`cb_sign within w_utilities_contract
boolean visible = false
integer x = 2062
integer y = 1896
end type

type cb_report_man from w_utilities5`cb_report_man within w_utilities_contract
boolean visible = false
integer x = 41
integer y = 532
integer width = 933
end type

type cb_caqh_rost_set from w_utilities5`cb_caqh_rost_set within w_utilities_contract
boolean visible = false
integer x = 2350
integer y = 840
end type

type cb_8 from w_utilities5`cb_8 within w_utilities_contract
end type

type cb_caqh_roster from w_utilities5`cb_caqh_roster within w_utilities_contract
boolean visible = false
integer x = 2350
end type

type cb_copy_emailmsg from w_utilities5`cb_copy_emailmsg within w_utilities_contract
integer y = 1592
end type

type cb_sync_alias from w_utilities5`cb_sync_alias within w_utilities_contract
integer y = 2232
end type

type cb_psv from w_utilities5`cb_psv within w_utilities_contract
integer x = 73
integer y = 2440
end type

type cb_userdocs from w_utilities5`cb_userdocs within w_utilities_contract
end type

type cb_sessions from w_utilities5`cb_sessions within w_utilities_contract
integer y = 2136
end type

type cb_6 from w_utilities5`cb_6 within w_utilities_contract
integer y = 1860
end type

type cb_namsspass_query from w_utilities5`cb_namsspass_query within w_utilities_contract
integer y = 2584
end type

type cb_recruit_eva from w_utilities5`cb_recruit_eva within w_utilities_contract
end type

type cb_recdata_entry from w_utilities5`cb_recdata_entry within w_utilities_contract
end type

type cb_ctx_utilities from w_utilities5`cb_ctx_utilities within w_utilities_contract
integer x = 1605
integer y = 1560
end type

type cb_splash_set from w_utilities5`cb_splash_set within w_utilities_contract
integer x = 2350
integer y = 536
end type

type cb_namsspass_upload from w_utilities5`cb_namsspass_upload within w_utilities_contract
integer y = 1952
end type

type cb_gud from w_utilities5`cb_gud within w_utilities_contract
integer y = 1768
end type

type cb_batch_add from w_utilities5`cb_batch_add within w_utilities_contract
integer y = 2224
end type

type cb_app_track_utl from w_utilities5`cb_app_track_utl within w_utilities_contract
integer x = 73
integer y = 1792
end type

type cb_npdb_reload from w_utilities5`cb_npdb_reload within w_utilities_contract
integer x = 2057
integer y = 2228
end type

type cb_lookup_cleanup from w_utilities5`cb_lookup_cleanup within w_utilities_contract
integer y = 2120
end type

type cb_email_sent_items from w_utilities5`cb_email_sent_items within w_utilities_contract
integer y = 2008
end type

type cb_images from w_utilities5`cb_images within w_utilities_contract
integer y = 1900
end type

type cb_5 from w_utilities5`cb_5 within w_utilities_contract
integer x = 2057
integer y = 1580
end type

type cb_group_painter from w_utilities5`cb_group_painter within w_utilities_contract
integer x = 3342
integer y = 2276
end type

type cb_app_tracking_setup from w_utilities5`cb_app_tracking_setup within w_utilities_contract
integer x = 3342
integer y = 2064
end type

type cb_standing from w_utilities5`cb_standing within w_utilities_contract
integer x = 3342
integer y = 2540
end type

type cb_reg from w_utilities5`cb_reg within w_utilities_contract
integer x = 41
integer y = 844
integer width = 933
end type

type cb_alert_audit from w_utilities5`cb_alert_audit within w_utilities_contract
boolean visible = false
integer y = 1772
end type

type cb_caqh_settings from w_utilities5`cb_caqh_settings within w_utilities_contract
integer x = 73
integer y = 1464
end type

type cb_overview from w_utilities5`cb_overview within w_utilities_contract
integer x = 1061
integer y = 2012
end type

type cb_hvc from w_utilities5`cb_hvc within w_utilities_contract
integer x = 1065
integer y = 2332
end type

type cb_aquest_sync from w_utilities5`cb_aquest_sync within w_utilities_contract
boolean visible = false
integer x = 1070
integer y = 1752
end type

type cb_importphoto from w_utilities5`cb_importphoto within w_utilities_contract
integer x = 2057
integer y = 2012
end type

type cb_set_facility_app_label from w_utilities5`cb_set_facility_app_label within w_utilities_contract
integer x = 3342
integer y = 2384
end type

type cb_fixfax from w_utilities5`cb_fixfax within w_utilities_contract
integer x = 1061
integer y = 1468
end type

type cb_npdb from w_utilities5`cb_npdb within w_utilities_contract
integer x = 2057
integer y = 2120
end type

type cb_view_alias from w_utilities5`cb_view_alias within w_utilities_contract
integer x = 1051
integer y = 948
end type

type cb_migrate from w_utilities5`cb_migrate within w_utilities_contract
integer y = 2628
integer taborder = 350
end type

type cb_updae_sql from w_utilities5`cb_updae_sql within w_utilities_contract
integer x = 1051
integer y = 740
integer taborder = 430
end type

type cb_wc_setup from w_utilities5`cb_wc_setup within w_utilities_contract
integer x = 1106
integer y = 2700
integer taborder = 440
end type

type cb_crawls from w_utilities5`cb_crawls within w_utilities_contract
integer x = 73
integer y = 2944
integer taborder = 500
end type

type cb_dba from w_utilities5`cb_dba within w_utilities_contract
integer x = 3031
integer y = 4008
integer taborder = 230
end type

type cb_sec_paint from w_utilities5`cb_sec_paint within w_utilities_contract
integer x = 128
integer y = 1660
integer taborder = 190
end type

type cb_nonprac from w_utilities5`cb_nonprac within w_utilities_contract
integer x = 1111
integer y = 3024
integer taborder = 390
end type

type cb_caqh_codes from w_utilities5`cb_caqh_codes within w_utilities_contract
integer x = 1129
integer y = 3504
integer taborder = 400
end type

type cb_caqh_fields from w_utilities5`cb_caqh_fields within w_utilities_contract
integer x = 1129
integer y = 3400
integer taborder = 410
end type

type cb_screen_view from w_utilities5`cb_screen_view within w_utilities_contract
integer x = 1106
integer y = 2872
integer taborder = 360
end type

type cb_paths from w_utilities5`cb_paths within w_utilities_contract
integer x = 3031
integer y = 3900
integer taborder = 200
end type

type cb_4 from w_utilities5`cb_4 within w_utilities_contract
integer x = 1125
integer y = 3292
integer taborder = 210
end type

type cb_index from w_utilities5`cb_index within w_utilities_contract
integer x = 1125
integer y = 3184
end type

type cb_date_fields from w_utilities5`cb_date_fields within w_utilities_contract
integer x = 2085
integer y = 3568
integer taborder = 420
end type

type cb_appt_painter from w_utilities5`cb_appt_painter within w_utilities_contract
integer x = 1120
integer y = 2944
integer taborder = 370
end type

type cb_clear_quotes from w_utilities5`cb_clear_quotes within w_utilities_contract
integer x = 2089
integer y = 3676
integer taborder = 170
end type

type cb_prem_utl from w_utilities5`cb_prem_utl within w_utilities_contract
integer x = 59
integer y = 3212
end type

type cb_selects from w_utilities5`cb_selects within w_utilities_contract
integer x = 41
integer y = 80
integer width = 933
integer taborder = 340
integer weight = 700
end type

type cb_check_ids from w_utilities5`cb_check_ids within w_utilities_contract
integer x = 1051
integer y = 116
integer taborder = 180
end type

type cb_exp_not_comp from w_utilities5`cb_exp_not_comp within w_utilities_contract
integer x = 3031
integer y = 3788
integer taborder = 220
end type

type cb_registry from w_utilities5`cb_registry within w_utilities_contract
integer x = 1102
integer y = 2784
integer taborder = 320
end type

type cb_user_reset from w_utilities5`cb_user_reset within w_utilities_contract
integer x = 41
integer y = 1216
integer width = 933
integer taborder = 330
end type

type cb_bd_exp from w_utilities5`cb_bd_exp within w_utilities_contract
integer x = 2089
integer y = 3460
integer taborder = 310
end type

type cb_comp_info from w_utilities5`cb_comp_info within w_utilities_contract
integer x = 2089
integer y = 3352
integer taborder = 300
end type

type cb_requested from w_utilities5`cb_requested within w_utilities_contract
integer x = 3031
integer y = 3676
integer taborder = 160
end type

type cb_field_ord_chk from w_utilities5`cb_field_ord_chk within w_utilities_contract
integer x = 3031
integer y = 3568
integer taborder = 150
end type

type cb_iapp_fix from w_utilities5`cb_iapp_fix within w_utilities_contract
integer x = 3031
integer y = 3460
end type

type cb_multi_affil_check from w_utilities5`cb_multi_affil_check within w_utilities_contract
integer x = 3035
integer y = 3352
end type

type cb_dapplications from w_utilities5`cb_dapplications within w_utilities_contract
integer x = 73
integer y = 2836
integer taborder = 460
end type

type cb_dmanual from w_utilities5`cb_dmanual within w_utilities_contract
integer x = 73
integer y = 2732
integer taborder = 450
end type

type cb_print_reset from w_utilities5`cb_print_reset within w_utilities_contract
integer x = 2089
integer y = 2812
integer taborder = 250
end type

type cb_assignedusers from w_utilities5`cb_assignedusers within w_utilities_contract
integer x = 2089
integer y = 3028
integer taborder = 270
end type

type cb_oig from w_utilities5`cb_oig within w_utilities_contract
integer x = 2089
integer y = 2920
integer taborder = 260
end type

type st_2 from w_utilities5`st_2 within w_utilities_contract
integer x = 3040
integer y = 2528
end type

type cb_user_security from w_utilities5`cb_user_security within w_utilities_contract
integer x = 96
integer y = 3096
end type

type cb_docids from w_utilities5`cb_docids within w_utilities_contract
integer x = 3031
integer y = 3136
end type

type cb_stat_check from w_utilities5`cb_stat_check within w_utilities_contract
integer x = 3031
integer y = 3028
end type

type cb_support_settings from w_utilities5`cb_support_settings within w_utilities_contract
integer x = 2043
integer y = 244
integer taborder = 510
end type

type cb_priv_adj from w_utilities5`cb_priv_adj within w_utilities_contract
integer x = 3031
integer y = 2920
end type

type cb_comm_review_fix from w_utilities5`cb_comm_review_fix within w_utilities_contract
integer x = 2089
integer y = 3136
integer taborder = 280
end type

type cb_links from w_utilities5`cb_links within w_utilities_contract
integer x = 3031
integer y = 2812
end type

type cb_db_back from w_utilities5`cb_db_back within w_utilities_contract
integer x = 1998
integer y = 1472
end type

type cb_fix from w_utilities5`cb_fix within w_utilities_contract
integer x = 3031
integer y = 2704
end type

type dw_3 from w_utilities5`dw_3 within w_utilities_contract
integer x = 3186
integer y = 1520
integer taborder = 480
end type

type cb_3 from w_utilities5`cb_3 within w_utilities_contract
integer x = 2043
integer y = 44
end type

type cb_2 from w_utilities5`cb_2 within w_utilities_contract
integer x = 2089
integer y = 3244
integer taborder = 290
end type

type cb_1 from w_utilities5`cb_1 within w_utilities_contract
integer x = 2043
integer y = 144
integer taborder = 540
end type

type dw_facilcomm from w_utilities5`dw_facilcomm within w_utilities_contract
integer x = 3232
integer y = 1840
integer taborder = 550
end type

type dw_praccomm from w_utilities5`dw_praccomm within w_utilities_contract
integer x = 3145
integer y = 1368
integer taborder = 530
end type

type dw_pracaffil from w_utilities5`dw_pracaffil within w_utilities_contract
integer x = 3127
integer y = 1664
integer taborder = 520
end type

type gb_adm from w_utilities5`gb_adm within w_utilities_contract
integer y = 20
integer height = 1404
end type

type gb_2 from w_utilities5`gb_2 within w_utilities_contract
integer x = 46
integer y = 2668
end type

type dw_dvfieldcopy from w_utilities5`dw_dvfieldcopy within w_utilities_contract
integer taborder = 490
end type

type dw_data_view_list from w_utilities5`dw_data_view_list within w_utilities_contract
integer taborder = 470
end type

type gb_3 from w_utilities5`gb_3 within w_utilities_contract
integer x = 1088
integer y = 2596
integer height = 92
end type

type gb_4 from w_utilities5`gb_4 within w_utilities_contract
integer x = 1029
integer y = 20
integer height = 1404
end type

type cb_settings from w_utilities5`cb_settings within w_utilities_contract
integer x = 41
integer y = 1312
integer width = 933
integer taborder = 380
end type

type cb_mod_prf_scr from w_utilities5`cb_mod_prf_scr within w_utilities_contract
integer x = 1065
integer y = 2244
end type

type cb_clientsetting from w_utilities5`cb_clientsetting within w_utilities_contract
integer x = 1051
integer y = 436
integer width = 919
end type

type cb_old from w_utilities5`cb_old within w_utilities_contract
integer x = 1422
integer y = 2576
end type

type cb_image_migrate from w_utilities5`cb_image_migrate within w_utilities_contract
integer x = 2057
integer y = 2712
end type

type gb_hide from w_utilities5`gb_hide within w_utilities_contract
integer x = 1033
integer y = 2440
end type

type cb_ocr from commandbutton within w_utilities_contract
integer x = 41
integer y = 636
integer width = 933
integer height = 92
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OCR All Image Document"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
open(w_ocr_all_document)
end event

type cb_convert from commandbutton within w_utilities_contract
integer x = 41
integer y = 220
integer width = 933
integer height = 92
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Convert Image Document to PDF"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
open(w_convert_tif2pdf)
end event

type cb_update_action from commandbutton within w_utilities_contract
integer x = 41
integer y = 324
integer width = 933
integer height = 92
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Update Create Action Item"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
Open(w_batch_update_alarm_create_ai)
Return 1

end event

type cb_create_ftx from commandbutton within w_utilities_contract
integer x = 1051
integer y = 428
integer width = 919
integer height = 92
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Full-Text Catalog"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
IF Not Isvalid(gnv_logservice) THEN gnv_logservice = Create n_logservice

n_cst_update_sql_clx lnv_sql
lnv_sql = Create n_cst_update_sql_clx

//Modified By Ken.Guo 2010-12-09
//lnv_sql.of_ver70_release_createfulltext1( )
//lnv_sql.of_ver85_release_dropfulltext1( )
//lnv_sql.of_ver85_release_createfulltext1( )
//lnv_sql.of_ver95_release_dropfulltext1( )	//jervis 10.21.2009
//lnv_sql.of_ver95_release_createfulltext1( )	//jervis 10.21.2009
//lnv_sql.of_ver100_release_dropfulltext1( )	//Added By Ken.Guo 2010-05-13.
//lnv_sql.of_ver100_release_createfulltext1( )	//Added By Ken.Guo 2010-05-13.

lnv_sql.of_release_fulltext( ) 

Destroy lnv_sql
destroy gnv_logservice
end event

type cb_weblink from commandbutton within w_utilities_contract
integer x = 1051
integer y = 1052
integer width = 919
integer height = 92
integer taborder = 480
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Web Link Settings"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
Open(w_weblink_settings)
end event

type cb_esign_settings from commandbutton within w_utilities_contract
integer x = 41
integer y = 428
integer width = 933
integer height = 92
integer taborder = 490
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Electronic Signature Settings"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
//Open(w_esign_settings)
if gs_esigntype = 'docusign' then  // (Appeon)Harry 07.08.2016 - for docusign
	Open(w_esign_settings_docusign)
Else
	Open(w_esign_settings)
End if

end event

type cb_rdfilter_set from commandbutton within w_utilities_contract
integer x = 1051
integer y = 636
integer width = 919
integer height = 92
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reports Data Filter Settings"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
Open(w_reports_access_settings)
end event

type cb_merge_category from commandbutton within w_utilities_contract
integer x = 1051
integer y = 532
integer width = 919
integer height = 92
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Merge Contract Category"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
Open(w_merge_ctx_category)
end event

type cb_ctx_upg from commandbutton within w_utilities_contract
integer x = 1051
integer y = 220
integer width = 919
integer height = 92
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Contract Screen Upgrade"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
//Added By Ken.Guo 2010-03-09. Force Update Screen
n_cst_update_screen lnvo_screen

If Messagebox('Upgrade','Do you want to upgrade the Contract Screens?',Question!, yesno!) = 2 Then Return

lnvo_screen = Create n_cst_update_screen
lnvo_screen.of_appeon2_changes(True)
If IsValid(w_infodisp) Then Close(w_infodisp)
Destroy lnvo_screen
end event

type cb_email_audit from commandbutton within w_utilities_contract
integer x = 1051
integer y = 844
integer width = 919
integer height = 92
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sent Emails Log"
end type

event clicked;// (Appeon)Harry 06.13.2013 - V141 ISG-CLX
Open(w_email_audit)
Return 1

//If Isvalid(w_email_audit) Then
//	w_email_audit.BringtoTop = True
//	w_email_audit.WindowState = Normal!
//Else
//	//OpenSheet(w_email_audit, w_mdi, 4, original!) 
//	Open(w_email_audit)
//End If
//Close(Parent)
end event

type cb_picture_painter from commandbutton within w_utilities_contract
integer x = 41
integer y = 740
integer width = 933
integer height = 92
integer taborder = 390
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Picture Painter"
end type

event clicked;//---------Begin Added by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
Open(w_picture_painter)
//---------End Added ------------------------------------------------------
end event

type cb_screen_picture from commandbutton within w_utilities_contract
integer x = 41
integer y = 948
integer width = 933
integer height = 92
integer taborder = 400
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Repair Screen Picture Issue"
end type

event clicked;//---------Begin Added by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
open( w_repair_screen_picture )
//---------End Added ------------------------------------------------------
end event

type cb_copy_data_in_different_database from commandbutton within w_utilities_contract
integer x = 1051
integer y = 324
integer width = 919
integer height = 92
integer taborder = 400
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy Data in Different Database "
end type

event clicked;//---------Begin Added by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
//Added By Mark Lee 02/20/2013 Copy Data in Different Database 
m_copy_data_in_different_database lm_copy_data

lm_copy_data = Create m_copy_data_in_different_database
 
lm_copy_data.PopMenu(Parent.PointerX(),Parent.PointerY())

Destroy lm_copy_data
//---------End Added ------------------------------------------------------
end event

type cb_5A from commandbutton within w_utilities_contract
integer x = 59
integer y = 556
integer width = 901
integer height = 92
integer taborder = 480
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Splash Screen Picture Settings"
end type

event clicked;open(w_splah_screen_set)
end event

