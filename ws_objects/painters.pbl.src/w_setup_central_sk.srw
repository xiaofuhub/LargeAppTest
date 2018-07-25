$PBExportHeader$w_setup_central_sk.srw
forward
global type w_setup_central_sk from w_setup_central
end type
end forward

global type w_setup_central_sk from w_setup_central
integer width = 2912
integer height = 1492
end type
global w_setup_central_sk w_setup_central_sk

on w_setup_central_sk.create
call super::create
end on

on w_setup_central_sk.destroy
call super::destroy
end on

type cb_saved_reports from w_setup_central`cb_saved_reports within w_setup_central_sk
boolean visible = false
integer x = 2976
integer y = 1096
boolean enabled = false
end type

type cb_verif_batch from w_setup_central`cb_verif_batch within w_setup_central_sk
end type

type cb_zip from w_setup_central`cb_zip within w_setup_central_sk
integer x = 1051
integer y = 956
end type

type cb_tracking_labels from w_setup_central`cb_tracking_labels within w_setup_central_sk
end type

type cb_rec_qual from w_setup_central`cb_rec_qual within w_setup_central_sk
integer x = 1998
integer y = 2108
end type

type cb_rec_pos from w_setup_central`cb_rec_pos within w_setup_central_sk
integer x = 1993
integer y = 1704
end type

type cb_rec_group from w_setup_central`cb_rec_group within w_setup_central_sk
integer x = 1998
integer y = 2004
end type

type cb_rec_rec from w_setup_central`cb_rec_rec within w_setup_central_sk
integer x = 1998
integer y = 1904
end type

type cb_picture_painter from w_setup_central`cb_picture_painter within w_setup_central_sk
integer x = 142
integer y = 1832
end type

type cb_entity from w_setup_central`cb_entity within w_setup_central_sk
boolean visible = false
integer x = 142
integer y = 1996
end type

type cb_expiring_data_settings from w_setup_central`cb_expiring_data_settings within w_setup_central_sk
integer x = 64
integer y = 644
end type

type cb_wv_sig_agree from w_setup_central`cb_wv_sig_agree within w_setup_central_sk
integer y = 2136
integer taborder = 420
end type

type cb_group_setup from w_setup_central`cb_group_setup within w_setup_central_sk
integer y = 160
integer taborder = 240
end type

type cb_import from w_setup_central`cb_import within w_setup_central_sk
boolean visible = false
integer x = 933
integer y = 1876
integer taborder = 680
boolean enabled = false
end type

type cb_close from w_setup_central`cb_close within w_setup_central_sk
integer x = 2537
end type

type cb_reference from w_setup_central`cb_reference within w_setup_central_sk
integer x = 1047
integer y = 852
integer taborder = 180
end type

type cb_profile_screen_design from w_setup_central`cb_profile_screen_design within w_setup_central_sk
integer x = 1056
integer y = 1252
integer taborder = 210
end type

type cb_fax_templates from w_setup_central`cb_fax_templates within w_setup_central_sk
integer x = 1051
integer y = 268
integer taborder = 120
end type

type cb_dtl_setup from w_setup_central`cb_dtl_setup within w_setup_central_sk
boolean visible = false
integer x = 3136
integer y = 2064
integer taborder = 530
boolean enabled = false
end type

type cb_questions from w_setup_central`cb_questions within w_setup_central_sk
integer x = 1047
integer y = 752
integer taborder = 170
end type

type cb_profile_design from w_setup_central`cb_profile_design within w_setup_central_sk
integer x = 1056
integer y = 1156
integer taborder = 200
end type

type cb_lookup from w_setup_central`cb_lookup within w_setup_central_sk
integer x = 1047
integer y = 656
integer taborder = 160
end type

type cb_letter_storage from w_setup_central`cb_letter_storage within w_setup_central_sk
integer x = 1051
integer y = 468
integer taborder = 140
end type

type cb_letter_setup from w_setup_central`cb_letter_setup within w_setup_central_sk
integer x = 1051
integer y = 368
integer taborder = 130
end type

type cb_document_type_setup from w_setup_central`cb_document_type_setup within w_setup_central_sk
integer y = 544
end type

type cb_screen_design from w_setup_central`cb_screen_design within w_setup_central_sk
integer y = 460
integer taborder = 290
end type

type cb_checklist_setup from w_setup_central`cb_checklist_setup within w_setup_central_sk
integer y = 448
end type

type cb_email_templates from w_setup_central`cb_email_templates within w_setup_central_sk
integer x = 1051
integer y = 168
integer taborder = 110
end type

type cb_group_practice from w_setup_central`cb_group_practice within w_setup_central_sk
integer y = 852
end type

type cb_user_setup from w_setup_central`cb_user_setup within w_setup_central_sk
integer x = 1993
integer y = 856
integer taborder = 350
end type

type cb_role_setup from w_setup_central`cb_role_setup within w_setup_central_sk
integer x = 1993
integer y = 760
integer taborder = 330
end type

type cb_view_setup from w_setup_central`cb_view_setup within w_setup_central_sk
integer y = 360
integer taborder = 270
end type

type cb_export from w_setup_central`cb_export within w_setup_central_sk
integer x = 59
integer y = 752
integer taborder = 70
end type

type cb_scheduler from w_setup_central`cb_scheduler within w_setup_central_sk
boolean visible = false
integer x = 3086
integer y = 976
integer taborder = 520
boolean enabled = false
end type

type cb_notifications from w_setup_central`cb_notifications within w_setup_central_sk
boolean visible = false
integer x = 3086
integer y = 880
integer taborder = 510
boolean enabled = false
end type

type cb_data_flow from w_setup_central`cb_data_flow within w_setup_central_sk
boolean visible = false
integer x = 3086
integer y = 784
integer taborder = 500
boolean enabled = false
end type

type cb_workflow from w_setup_central`cb_workflow within w_setup_central_sk
boolean visible = false
integer x = 3150
integer y = 2172
integer taborder = 570
boolean enabled = false
end type

type cb_standing from w_setup_central`cb_standing within w_setup_central_sk
boolean visible = false
integer x = 3104
integer y = 1136
integer taborder = 560
boolean enabled = false
end type

type cb_qa_setup from w_setup_central`cb_qa_setup within w_setup_central_sk
boolean visible = false
integer x = 3081
integer y = 580
integer taborder = 340
boolean enabled = false
end type

type cb_qa_metrics from w_setup_central`cb_qa_metrics within w_setup_central_sk
boolean visible = false
integer x = 3081
integer y = 484
integer taborder = 320
boolean enabled = false
end type

type cb_process_temp from w_setup_central`cb_process_temp within w_setup_central_sk
boolean visible = false
integer x = 3081
integer y = 388
integer taborder = 300
boolean enabled = false
end type

type cb_priv_templates from w_setup_central`cb_priv_templates within w_setup_central_sk
boolean visible = false
integer x = 3081
integer y = 292
integer taborder = 280
boolean enabled = false
end type

type cb_priv_procd from w_setup_central`cb_priv_procd within w_setup_central_sk
boolean visible = false
integer x = 3081
integer y = 196
integer taborder = 260
boolean enabled = false
end type

type cb_sec_set from w_setup_central`cb_sec_set within w_setup_central_sk
integer x = 1993
integer y = 952
integer taborder = 360
end type

type cb_app_labels from w_setup_central`cb_app_labels within w_setup_central_sk
integer y = 260
integer taborder = 250
end type

type cb_appt_screen from w_setup_central`cb_appt_screen within w_setup_central_sk
boolean visible = false
integer x = 105
integer y = 1872
integer taborder = 100
boolean enabled = false
end type

type cb_survey from w_setup_central`cb_survey within w_setup_central_sk
boolean visible = false
integer x = 3145
integer y = 2384
integer taborder = 670
boolean enabled = false
end type

type cb_non_prac from w_setup_central`cb_non_prac within w_setup_central_sk
boolean visible = false
integer x = 3141
integer y = 2492
integer taborder = 660
boolean enabled = false
end type

type cb_multi_app from w_setup_central`cb_multi_app within w_setup_central_sk
boolean visible = false
integer x = 389
integer y = 1980
integer taborder = 650
boolean enabled = false
end type

type cb_batch from w_setup_central`cb_batch within w_setup_central_sk
boolean visible = false
integer x = 1216
integer y = 1976
integer taborder = 640
boolean enabled = false
end type

type cb_facility from w_setup_central`cb_facility within w_setup_central_sk
boolean visible = false
integer x = 2048
integer y = 1976
integer taborder = 630
boolean enabled = false
end type

type cb_comm_meeting_set from w_setup_central`cb_comm_meeting_set within w_setup_central_sk
boolean visible = false
integer x = 873
integer y = 2524
integer taborder = 620
boolean enabled = false
end type

type cb_app_track from w_setup_central`cb_app_track within w_setup_central_sk
integer y = 256
end type

type cb_web_crawl from w_setup_central`cb_web_crawl within w_setup_central_sk
boolean visible = false
integer x = 3154
integer y = 2280
integer taborder = 610
boolean enabled = false
end type

type cb_fppe_plan from w_setup_central`cb_fppe_plan within w_setup_central_sk
boolean visible = false
integer x = 3081
integer y = 100
integer taborder = 220
boolean enabled = false
end type

type cb_wv_priv_opt from w_setup_central`cb_wv_priv_opt within w_setup_central_sk
boolean visible = false
integer y = 2424
integer taborder = 410
boolean enabled = false
end type

type cb_wv_role from w_setup_central`cb_wv_role within w_setup_central_sk
boolean visible = false
integer y = 2520
integer taborder = 490
boolean enabled = false
end type

type cb_wv_agree from w_setup_central`cb_wv_agree within w_setup_central_sk
boolean visible = false
integer y = 2616
integer taborder = 550
boolean enabled = false
end type

type cb_wv_logo from w_setup_central`cb_wv_logo within w_setup_central_sk
boolean visible = false
integer y = 2328
integer taborder = 540
boolean enabled = false
end type

type cb_wv_doc_temp from w_setup_central`cb_wv_doc_temp within w_setup_central_sk
boolean visible = false
integer x = 869
integer y = 2332
integer taborder = 600
boolean enabled = false
end type

type cb_wv_letter_temp from w_setup_central`cb_wv_letter_temp within w_setup_central_sk
boolean visible = false
integer y = 2232
integer taborder = 480
boolean enabled = false
end type

type cb_wv_users from w_setup_central`cb_wv_users within w_setup_central_sk
boolean visible = false
integer x = 869
integer y = 2236
integer taborder = 590
boolean enabled = false
end type

type cb_wv_settings from w_setup_central`cb_wv_settings within w_setup_central_sk
boolean visible = false
integer x = 869
integer y = 2140
integer taborder = 720
boolean enabled = false
end type

type cb_wv_help from w_setup_central`cb_wv_help within w_setup_central_sk
boolean visible = false
integer x = 869
integer y = 2428
integer taborder = 710
boolean enabled = false
end type

type cb_cont_req_profile from w_setup_central`cb_cont_req_profile within w_setup_central_sk
boolean visible = false
integer x = 3136
integer y = 1324
integer taborder = 580
boolean enabled = false
end type

type cb_cpt_codes from w_setup_central`cb_cpt_codes within w_setup_central_sk
boolean visible = false
integer x = 3136
integer y = 1420
integer taborder = 400
boolean enabled = false
end type

type cb_cont_clause from w_setup_central`cb_cont_clause within w_setup_central_sk
boolean visible = false
integer x = 3136
integer y = 1516
integer taborder = 390
boolean enabled = false
end type

type cb_cont_doc_lib from w_setup_central`cb_cont_doc_lib within w_setup_central_sk
boolean visible = false
integer x = 3136
integer y = 1612
integer taborder = 470
boolean enabled = false
end type

type cb_cont_temp_lib from w_setup_central`cb_cont_temp_lib within w_setup_central_sk
boolean visible = false
integer x = 3136
integer y = 1708
integer taborder = 460
boolean enabled = false
end type

type cb_app_map from w_setup_central`cb_app_map within w_setup_central_sk
integer y = 156
end type

type cb_cont_view from w_setup_central`cb_cont_view within w_setup_central_sk
boolean visible = false
integer x = 3141
integer y = 1804
integer taborder = 700
boolean enabled = false
end type

type cb_cont_screen from w_setup_central`cb_cont_screen within w_setup_central_sk
boolean visible = false
integer x = 3141
integer y = 1900
integer taborder = 690
boolean enabled = false
end type

type cb_wv_email_set from w_setup_central`cb_wv_email_set within w_setup_central_sk
boolean visible = false
integer x = 3035
end type

type cb_app_temp from w_setup_central`cb_app_temp within w_setup_central_sk
integer y = 352
end type

type cb_button from w_setup_central`cb_button within w_setup_central_sk
integer x = 1993
integer y = 660
end type

type cb_recruit from w_setup_central`cb_recruit within w_setup_central_sk
boolean visible = false
integer x = 3026
integer y = 1008
end type

type cb_calllog from w_setup_central`cb_calllog within w_setup_central_sk
boolean visible = false
integer x = 3045
integer y = 892
end type

type cb_call_lookup from w_setup_central`cb_call_lookup within w_setup_central_sk
end type

type cb_zip_setup from w_setup_central`cb_zip_setup within w_setup_central_sk
boolean visible = false
integer x = 105
integer y = 2164
end type

type cb_recruit_design from w_setup_central`cb_recruit_design within w_setup_central_sk
integer x = 1998
integer y = 1804
end type

type gb_11 from w_setup_central`gb_11 within w_setup_central_sk
boolean visible = false
integer x = 3045
integer y = 728
integer taborder = 440
boolean enabled = false
end type

type gb_10 from w_setup_central`gb_10 within w_setup_central_sk
integer x = 1010
integer y = 100
integer taborder = 90
end type

type gb_5 from w_setup_central`gb_5 within w_setup_central_sk
boolean visible = false
integer x = 142
integer y = 2252
integer taborder = 430
boolean enabled = false
end type

type gb_4 from w_setup_central`gb_4 within w_setup_central_sk
integer x = 1006
integer y = 592
integer height = 476
integer taborder = 150
end type

type gb_1 from w_setup_central`gb_1 within w_setup_central_sk
integer x = 1015
integer y = 1092
end type

type gb_sec from w_setup_central`gb_sec within w_setup_central_sk
integer x = 1952
integer y = 604
end type

type gb_8 from w_setup_central`gb_8 within w_setup_central_sk
integer y = 100
integer height = 904
end type

type gb_2 from w_setup_central`gb_2 within w_setup_central_sk
boolean visible = false
integer x = 3040
integer y = 40
integer taborder = 370
boolean enabled = false
end type

type gb_rec from w_setup_central`gb_rec within w_setup_central_sk
integer x = 1943
integer y = 1452
end type

type gb_7 from w_setup_central`gb_7 within w_setup_central_sk
integer y = 100
integer height = 484
integer taborder = 230
end type

type gb_cont from w_setup_central`gb_cont within w_setup_central_sk
boolean visible = false
integer x = 3095
integer y = 1256
integer taborder = 450
boolean enabled = false
end type

type gb_wv from w_setup_central`gb_wv within w_setup_central_sk
boolean visible = false
integer x = 791
integer y = 2264
integer width = 2222
integer height = 608
integer taborder = 380
boolean enabled = false
end type

