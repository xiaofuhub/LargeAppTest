$PBExportHeader$w_setup_central_cont.srw
forward
global type w_setup_central_cont from w_setup_central
end type
end forward

global type w_setup_central_cont from w_setup_central
integer width = 1911
integer height = 1636
end type
global w_setup_central_cont w_setup_central_cont

on w_setup_central_cont.create
call super::create
end on

on w_setup_central_cont.destroy
call super::destroy
end on

type cb_activity from w_setup_central`cb_activity within w_setup_central_cont
integer x = 2039
integer y = 444
end type

type cb_photo_prof from w_setup_central`cb_photo_prof within w_setup_central_cont
end type

type cb_saved_reports from w_setup_central`cb_saved_reports within w_setup_central_cont
integer y = 888
end type

type cb_verif_batch from w_setup_central`cb_verif_batch within w_setup_central_cont
integer x = 133
integer y = 1580
end type

type cb_zip from w_setup_central`cb_zip within w_setup_central_cont
end type

type cb_tracking_labels from w_setup_central`cb_tracking_labels within w_setup_central_cont
end type

type cb_rec_qual from w_setup_central`cb_rec_qual within w_setup_central_cont
end type

type cb_rec_pos from w_setup_central`cb_rec_pos within w_setup_central_cont
end type

type cb_rec_group from w_setup_central`cb_rec_group within w_setup_central_cont
end type

type cb_rec_rec from w_setup_central`cb_rec_rec within w_setup_central_cont
end type

type cb_picture_painter from w_setup_central`cb_picture_painter within w_setup_central_cont
integer x = 114
integer y = 1000
end type

type cb_entity from w_setup_central`cb_entity within w_setup_central_cont
integer x = 2043
integer y = 920
integer width = 759
end type

type cb_expiring_data_settings from w_setup_central`cb_expiring_data_settings within w_setup_central_cont
integer x = 2510
integer y = 1240
integer taborder = 490
boolean enabled = false
end type

type cb_wv_sig_agree from w_setup_central`cb_wv_sig_agree within w_setup_central_cont
integer x = 3429
integer y = 144
integer taborder = 370
end type

type cb_group_setup from w_setup_central`cb_group_setup within w_setup_central_cont
boolean visible = false
integer x = 3424
integer y = 2320
integer taborder = 350
boolean enabled = false
end type

type cb_import from w_setup_central`cb_import within w_setup_central_cont
integer y = 784
integer taborder = 200
end type

type cb_close from w_setup_central`cb_close within w_setup_central_cont
integer x = 1609
integer y = 12
end type

type cb_reference from w_setup_central`cb_reference within w_setup_central_cont
boolean visible = false
integer x = 2542
integer y = 372
integer taborder = 450
boolean enabled = false
end type

type cb_profile_screen_design from w_setup_central`cb_profile_screen_design within w_setup_central_cont
boolean visible = false
integer x = 3442
integer y = 2084
integer taborder = 440
boolean enabled = false
end type

type cb_fax_templates from w_setup_central`cb_fax_templates within w_setup_central_cont
integer y = 268
integer taborder = 160
end type

type cb_dtl_setup from w_setup_central`cb_dtl_setup within w_setup_central_cont
integer x = 105
integer y = 380
integer taborder = 50
end type

type cb_questions from w_setup_central`cb_questions within w_setup_central_cont
boolean visible = false
integer x = 2514
integer y = 500
integer taborder = 510
boolean enabled = false
end type

type cb_profile_design from w_setup_central`cb_profile_design within w_setup_central_cont
boolean visible = false
integer x = 3442
integer y = 1988
integer taborder = 500
boolean enabled = false
end type

type cb_lookup from w_setup_central`cb_lookup within w_setup_central_cont
integer x = 105
integer y = 68
integer taborder = 20
end type

type cb_letter_storage from w_setup_central`cb_letter_storage within w_setup_central_cont
integer y = 468
integer taborder = 180
end type

type cb_letter_setup from w_setup_central`cb_letter_setup within w_setup_central_cont
integer y = 368
integer taborder = 170
end type

type cb_document_type_setup from w_setup_central`cb_document_type_setup within w_setup_central_cont
boolean visible = false
integer x = 2523
integer y = 1088
integer taborder = 680
boolean enabled = false
end type

type cb_screen_design from w_setup_central`cb_screen_design within w_setup_central_cont
boolean visible = false
integer x = 3424
integer y = 2608
integer taborder = 630
boolean enabled = false
end type

type cb_checklist_setup from w_setup_central`cb_checklist_setup within w_setup_central_cont
boolean visible = false
integer x = 2574
integer y = 880
integer taborder = 670
boolean enabled = false
end type

type cb_email_templates from w_setup_central`cb_email_templates within w_setup_central_cont
integer y = 168
integer taborder = 150
end type

type cb_group_practice from w_setup_central`cb_group_practice within w_setup_central_cont
integer x = 105
integer y = 172
integer taborder = 30
end type

type cb_user_setup from w_setup_central`cb_user_setup within w_setup_central_cont
integer x = 1019
integer y = 1300
integer taborder = 230
end type

type cb_role_setup from w_setup_central`cb_role_setup within w_setup_central_cont
integer x = 1019
integer y = 1200
integer taborder = 220
end type

type cb_view_setup from w_setup_central`cb_view_setup within w_setup_central_cont
boolean visible = false
integer x = 3424
integer y = 2512
integer taborder = 620
boolean enabled = false
end type

type cb_export from w_setup_central`cb_export within w_setup_central_cont
integer y = 684
integer taborder = 190
end type

type cb_scheduler from w_setup_central`cb_scheduler within w_setup_central_cont
integer x = 105
integer y = 276
integer taborder = 40
end type

type cb_notifications from w_setup_central`cb_notifications within w_setup_central_cont
boolean visible = false
integer x = 2533
integer y = 2528
integer taborder = 430
boolean enabled = false
end type

type cb_data_flow from w_setup_central`cb_data_flow within w_setup_central_cont
boolean visible = false
integer x = 2533
integer y = 2432
integer taborder = 420
boolean enabled = false
end type

type cb_workflow from w_setup_central`cb_workflow within w_setup_central_cont
integer x = 105
integer y = 484
integer taborder = 60
end type

type cb_standing from w_setup_central`cb_standing within w_setup_central_cont
boolean visible = false
integer x = 2574
integer y = 228
integer taborder = 480
boolean enabled = false
end type

type cb_qa_setup from w_setup_central`cb_qa_setup within w_setup_central_cont
boolean visible = false
integer x = 3442
integer y = 1768
integer taborder = 290
boolean enabled = false
end type

type cb_qa_metrics from w_setup_central`cb_qa_metrics within w_setup_central_cont
boolean visible = false
integer x = 3442
integer y = 1672
integer taborder = 280
boolean enabled = false
end type

type cb_process_temp from w_setup_central`cb_process_temp within w_setup_central_cont
boolean visible = false
integer x = 3442
integer y = 1576
integer taborder = 270
boolean enabled = false
end type

type cb_priv_templates from w_setup_central`cb_priv_templates within w_setup_central_cont
boolean visible = false
integer x = 3442
integer y = 1480
integer taborder = 260
boolean enabled = false
end type

type cb_priv_procd from w_setup_central`cb_priv_procd within w_setup_central_cont
boolean visible = false
integer x = 3442
integer y = 1384
integer taborder = 250
boolean enabled = false
end type

type cb_sec_set from w_setup_central`cb_sec_set within w_setup_central_cont
integer x = 1019
integer y = 1400
integer taborder = 240
end type

type cb_app_labels from w_setup_central`cb_app_labels within w_setup_central_cont
boolean visible = false
integer x = 3424
integer y = 2416
integer taborder = 210
boolean enabled = false
end type

type cb_appt_screen from w_setup_central`cb_appt_screen within w_setup_central_cont
boolean visible = false
integer x = 3424
integer y = 2224
integer taborder = 110
boolean enabled = false
end type

type cb_survey from w_setup_central`cb_survey within w_setup_central_cont
boolean visible = false
integer x = 2537
integer y = 1976
integer taborder = 610
boolean enabled = false
end type

type cb_non_prac from w_setup_central`cb_non_prac within w_setup_central_cont
boolean visible = false
integer x = 2514
integer y = 1824
integer taborder = 600
boolean enabled = false
end type

type cb_multi_app from w_setup_central`cb_multi_app within w_setup_central_cont
boolean visible = false
integer x = 2523
integer y = 1720
integer taborder = 590
boolean enabled = false
end type

type cb_batch from w_setup_central`cb_batch within w_setup_central_cont
boolean visible = false
integer x = 2491
integer y = 1592
integer taborder = 580
boolean enabled = false
end type

type cb_facility from w_setup_central`cb_facility within w_setup_central_cont
boolean visible = false
integer x = 2523
integer y = 1360
integer taborder = 570
boolean enabled = false
end type

type cb_comm_meeting_set from w_setup_central`cb_comm_meeting_set within w_setup_central_cont
boolean visible = false
integer x = 3433
integer y = 1104
integer taborder = 560
boolean enabled = false
end type

type cb_app_track from w_setup_central`cb_app_track within w_setup_central_cont
boolean visible = false
integer x = 2546
integer y = 764
integer taborder = 550
boolean enabled = false
end type

type cb_web_crawl from w_setup_central`cb_web_crawl within w_setup_central_cont
boolean visible = false
integer x = 2528
integer y = 2284
integer taborder = 540
boolean enabled = false
end type

type cb_fppe_plan from w_setup_central`cb_fppe_plan within w_setup_central_cont
boolean visible = false
integer x = 3442
integer y = 1288
integer taborder = 380
boolean enabled = false
end type

type cb_wv_priv_opt from w_setup_central`cb_wv_priv_opt within w_setup_central_cont
boolean visible = false
integer x = 3429
integer y = 432
integer taborder = 360
boolean enabled = false
end type

type cb_wv_role from w_setup_central`cb_wv_role within w_setup_central_cont
boolean visible = false
integer x = 3438
integer y = 528
integer taborder = 410
boolean enabled = false
end type

type cb_wv_agree from w_setup_central`cb_wv_agree within w_setup_central_cont
boolean visible = false
integer x = 3429
integer y = 624
integer taborder = 470
boolean enabled = false
end type

type cb_wv_logo from w_setup_central`cb_wv_logo within w_setup_central_cont
boolean visible = false
integer x = 3429
integer y = 336
integer taborder = 460
boolean enabled = false
end type

type cb_wv_doc_temp from w_setup_central`cb_wv_doc_temp within w_setup_central_cont
boolean visible = false
integer x = 3429
integer y = 912
integer taborder = 530
boolean enabled = false
end type

type cb_wv_letter_temp from w_setup_central`cb_wv_letter_temp within w_setup_central_cont
boolean visible = false
integer x = 3429
integer y = 240
integer taborder = 400
boolean enabled = false
end type

type cb_wv_users from w_setup_central`cb_wv_users within w_setup_central_cont
boolean visible = false
integer x = 3429
integer y = 816
integer taborder = 520
boolean enabled = false
end type

type cb_wv_settings from w_setup_central`cb_wv_settings within w_setup_central_cont
boolean visible = false
integer x = 3429
integer y = 720
integer taborder = 660
boolean enabled = false
end type

type cb_wv_help from w_setup_central`cb_wv_help within w_setup_central_cont
boolean visible = false
integer x = 3429
integer y = 1008
integer taborder = 650
boolean enabled = false
end type

type cb_cont_req_profile from w_setup_central`cb_cont_req_profile within w_setup_central_cont
integer x = 105
integer y = 800
integer taborder = 90
end type

type cb_cpt_codes from w_setup_central`cb_cpt_codes within w_setup_central_cont
integer x = 105
integer y = 900
integer taborder = 100
end type

type cb_cont_clause from w_setup_central`cb_cont_clause within w_setup_central_cont
integer x = 105
integer y = 1200
integer taborder = 120
end type

type cb_cont_doc_lib from w_setup_central`cb_cont_doc_lib within w_setup_central_cont
integer x = 105
integer y = 1300
integer taborder = 130
end type

type cb_cont_temp_lib from w_setup_central`cb_cont_temp_lib within w_setup_central_cont
integer x = 105
integer y = 1400
integer taborder = 140
end type

type cb_app_map from w_setup_central`cb_app_map within w_setup_central_cont
boolean visible = false
integer x = 2551
integer y = 636
integer taborder = 640
boolean enabled = false
end type

type cb_cont_view from w_setup_central`cb_cont_view within w_setup_central_cont
integer x = 105
integer y = 588
integer taborder = 70
end type

type cb_cont_screen from w_setup_central`cb_cont_screen within w_setup_central_cont
integer x = 105
integer y = 692
integer taborder = 80
end type

type cb_wv_email_set from w_setup_central`cb_wv_email_set within w_setup_central_cont
boolean visible = false
integer x = 2519
integer y = 2124
boolean enabled = false
end type

type cb_app_temp from w_setup_central`cb_app_temp within w_setup_central_cont
boolean visible = false
integer x = 2542
integer y = 980
boolean enabled = false
end type

type cb_button from w_setup_central`cb_button within w_setup_central_cont
integer x = 1019
integer y = 1100
end type

type cb_recruit from w_setup_central`cb_recruit within w_setup_central_cont
boolean visible = false
integer x = 91
integer y = 1796
boolean enabled = false
end type

type cb_calllog from w_setup_central`cb_calllog within w_setup_central_cont
boolean visible = false
integer x = 96
integer y = 1696
boolean enabled = false
end type

type cb_call_lookup from w_setup_central`cb_call_lookup within w_setup_central_cont
end type

type cb_zip_setup from w_setup_central`cb_zip_setup within w_setup_central_cont
boolean visible = false
integer x = 69
integer y = 1908
boolean enabled = false
end type

type cb_recruit_design from w_setup_central`cb_recruit_design within w_setup_central_cont
boolean visible = false
integer x = 969
integer y = 1808
boolean enabled = false
end type

type gb_11 from w_setup_central`gb_11 within w_setup_central_cont
boolean visible = false
integer x = 2491
integer y = 2352
integer taborder = 390
boolean enabled = false
end type

type gb_10 from w_setup_central`gb_10 within w_setup_central_cont
integer y = 108
end type

type gb_5 from w_setup_central`gb_5 within w_setup_central_cont
integer y = 624
end type

type gb_4 from w_setup_central`gb_4 within w_setup_central_cont
boolean visible = false
integer x = 2505
integer y = 152
integer taborder = 310
boolean enabled = false
end type

type gb_1 from w_setup_central`gb_1 within w_setup_central_cont
end type

type gb_sec from w_setup_central`gb_sec within w_setup_central_cont
integer x = 987
integer y = 1044
end type

type gb_8 from w_setup_central`gb_8 within w_setup_central_cont
integer x = 59
integer height = 1092
end type

type gb_2 from w_setup_central`gb_2 within w_setup_central_cont
boolean visible = false
integer x = 3401
integer y = 1228
integer taborder = 300
boolean enabled = false
end type

type gb_rec from w_setup_central`gb_rec within w_setup_central_cont
end type

type gb_7 from w_setup_central`gb_7 within w_setup_central_cont
boolean visible = false
integer x = 3383
integer y = 2160
integer taborder = 340
boolean enabled = false
end type

type gb_cont from w_setup_central`gb_cont within w_setup_central_cont
integer x = 64
integer y = 1124
integer height = 388
string text = "Documents"
end type

type gb_wv from w_setup_central`gb_wv within w_setup_central_cont
boolean visible = false
integer x = 3387
integer y = 60
integer taborder = 330
boolean enabled = false
end type

