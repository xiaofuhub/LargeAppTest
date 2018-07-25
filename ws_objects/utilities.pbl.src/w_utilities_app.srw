$PBExportHeader$w_utilities_app.srw
forward
global type w_utilities_app from w_utilities5
end type
end forward

global type w_utilities_app from w_utilities5
integer width = 2021
integer height = 2372
end type
global w_utilities_app w_utilities_app

on w_utilities_app.create
call super::create
end on

on w_utilities_app.destroy
call super::destroy
end on

type cb_usertracking from w_utilities5`cb_usertracking within w_utilities_app
integer y = 1856
end type

type cb_report_log from w_utilities5`cb_report_log within w_utilities_app
integer x = 1029
integer y = 1460
end type

type cb_sign from w_utilities5`cb_sign within w_utilities_app
integer y = 712
end type

type cb_report_man from w_utilities5`cb_report_man within w_utilities_app
integer x = 73
end type

type cb_caqh_rost_set from w_utilities5`cb_caqh_rost_set within w_utilities_app
integer x = 73
integer y = 608
end type

type cb_8 from w_utilities5`cb_8 within w_utilities_app
end type

type cb_caqh_roster from w_utilities5`cb_caqh_roster within w_utilities_app
end type

type cb_copy_emailmsg from w_utilities5`cb_copy_emailmsg within w_utilities_app
end type

type cb_sync_alias from w_utilities5`cb_sync_alias within w_utilities_app
integer x = 73
integer y = 1128
end type

type cb_psv from w_utilities5`cb_psv within w_utilities_app
integer x = 2039
integer y = 1116
end type

type cb_userdocs from w_utilities5`cb_userdocs within w_utilities_app
integer y = 1752
end type

type cb_sessions from w_utilities5`cb_sessions within w_utilities_app
integer x = 3163
integer y = 1448
end type

type cb_6 from w_utilities5`cb_6 within w_utilities_app
integer x = 3264
integer y = 1656
end type

type cb_namsspass_query from w_utilities5`cb_namsspass_query within w_utilities_app
end type

type cb_recruit_eva from w_utilities5`cb_recruit_eva within w_utilities_app
integer x = 2016
integer y = 1336
end type

type cb_recdata_entry from w_utilities5`cb_recdata_entry within w_utilities_app
integer x = 2053
integer y = 1236
end type

type cb_ctx_utilities from w_utilities5`cb_ctx_utilities within w_utilities_app
integer x = 69
integer y = 4
integer width = 896
integer height = 92
end type

type cb_splash_set from w_utilities5`cb_splash_set within w_utilities_app
integer x = 2062
integer y = 828
end type

type cb_namsspass_upload from w_utilities5`cb_namsspass_upload within w_utilities_app
integer x = 3241
integer y = 1764
end type

type cb_gud from w_utilities5`cb_gud within w_utilities_app
integer x = 73
integer y = 920
end type

type cb_batch_add from w_utilities5`cb_batch_add within w_utilities_app
integer x = 73
integer y = 1544
end type

type cb_app_track_utl from w_utilities5`cb_app_track_utl within w_utilities_app
integer x = 73
integer y = 400
end type

type cb_npdb_reload from w_utilities5`cb_npdb_reload within w_utilities_app
end type

type cb_lookup_cleanup from w_utilities5`cb_lookup_cleanup within w_utilities_app
integer x = 73
integer y = 1232
end type

type cb_email_sent_items from w_utilities5`cb_email_sent_items within w_utilities_app
integer x = 73
integer y = 816
end type

type cb_images from w_utilities5`cb_images within w_utilities_app
integer x = 73
integer y = 1336
end type

type cb_5 from w_utilities5`cb_5 within w_utilities_app
integer taborder = 570
end type

type cb_group_painter from w_utilities5`cb_group_painter within w_utilities_app
integer x = 3090
integer y = 456
string text = "Group Data Screen Setup"
end type

type cb_app_tracking_setup from w_utilities5`cb_app_tracking_setup within w_utilities_app
integer x = 3099
integer y = 136
string text = "Application Tracking Setup"
end type

type cb_standing from w_utilities5`cb_standing within w_utilities_app
integer x = 3099
integer y = 1000
string text = "Standing Lookup Edit"
end type

type cb_reg from w_utilities5`cb_reg within w_utilities_app
integer x = 73
integer y = 1440
end type

type cb_alert_audit from w_utilities5`cb_alert_audit within w_utilities_app
integer x = 2149
integer y = 352
integer taborder = 540
end type

type cb_caqh_settings from w_utilities5`cb_caqh_settings within w_utilities_app
integer x = 73
integer y = 504
end type

type cb_overview from w_utilities5`cb_overview within w_utilities_app
integer y = 1688
end type

type cb_hvc from w_utilities5`cb_hvc within w_utilities_app
integer x = 1033
integer y = 1132
end type

type cb_aquest_sync from w_utilities5`cb_aquest_sync within w_utilities_app
integer y = 396
integer taborder = 440
end type

type cb_importphoto from w_utilities5`cb_importphoto within w_utilities_app
integer x = 2240
integer y = 2644
integer taborder = 520
end type

type cb_set_facility_app_label from w_utilities5`cb_set_facility_app_label within w_utilities_app
integer x = 3099
integer y = 564
string text = "IntelliApp Header Painter"
end type

type cb_fixfax from w_utilities5`cb_fixfax within w_utilities_app
integer x = 1029
integer y = 1024
end type

type cb_npdb from w_utilities5`cb_npdb within w_utilities_app
integer x = 2167
integer y = 2612
integer taborder = 500
end type

type cb_view_alias from w_utilities5`cb_view_alias within w_utilities_app
integer x = 1042
integer y = 2008
end type

type cb_migrate from w_utilities5`cb_migrate within w_utilities_app
integer x = 2043
integer y = 2376
end type

type cb_updae_sql from w_utilities5`cb_updae_sql within w_utilities_app
integer x = 2126
integer y = 2568
integer taborder = 480
end type

type cb_wc_setup from w_utilities5`cb_wc_setup within w_utilities_app
integer x = 2176
end type

type cb_crawls from w_utilities5`cb_crawls within w_utilities_app
integer x = 2181
integer y = 2060
integer taborder = 550
end type

type cb_dba from w_utilities5`cb_dba within w_utilities_app
integer x = 2107
integer y = 2136
end type

type cb_sec_paint from w_utilities5`cb_sec_paint within w_utilities_app
integer x = 3099
integer y = 888
string text = "Security Painter"
end type

type cb_nonprac from w_utilities5`cb_nonprac within w_utilities_app
integer x = 2094
integer y = 2524
end type

type cb_caqh_codes from w_utilities5`cb_caqh_codes within w_utilities_app
integer x = 1042
integer y = 600
integer taborder = 450
end type

type cb_caqh_fields from w_utilities5`cb_caqh_fields within w_utilities_app
integer x = 2126
integer y = 2504
integer taborder = 460
end type

type cb_screen_view from w_utilities5`cb_screen_view within w_utilities_app
integer x = 73
integer y = 1648
integer taborder = 0
end type

type cb_paths from w_utilities5`cb_paths within w_utilities_app
integer y = 1796
end type

type cb_4 from w_utilities5`cb_4 within w_utilities_app
integer x = 1047
integer y = 188
end type

type cb_index from w_utilities5`cb_index within w_utilities_app
integer x = 2199
integer y = 452
end type

type cb_date_fields from w_utilities5`cb_date_fields within w_utilities_app
integer x = 2117
integer y = 2532
integer taborder = 470
end type

type cb_appt_painter from w_utilities5`cb_appt_painter within w_utilities_app
integer x = 2176
integer y = 2524
end type

type cb_clear_quotes from w_utilities5`cb_clear_quotes within w_utilities_app
integer x = 2167
integer y = 2584
end type

type cb_prem_utl from w_utilities5`cb_prem_utl within w_utilities_app
integer x = 2066
integer y = 2368
end type

type cb_selects from w_utilities5`cb_selects within w_utilities_app
integer x = 73
integer y = 188
end type

type cb_check_ids from w_utilities5`cb_check_ids within w_utilities_app
integer x = 1033
integer y = 700
end type

type cb_exp_not_comp from w_utilities5`cb_exp_not_comp within w_utilities_app
integer x = 1029
integer y = 916
end type

type cb_registry from w_utilities5`cb_registry within w_utilities_app
end type

type cb_user_reset from w_utilities5`cb_user_reset within w_utilities_app
integer x = 73
integer y = 2008
end type

type cb_bd_exp from w_utilities5`cb_bd_exp within w_utilities_app
integer x = 2153
integer y = 2524
end type

type cb_comp_info from w_utilities5`cb_comp_info within w_utilities_app
integer x = 2103
integer y = 2528
end type

type cb_requested from w_utilities5`cb_requested within w_utilities_app
integer x = 2135
integer y = 2492
end type

type cb_field_ord_chk from w_utilities5`cb_field_ord_chk within w_utilities_app
integer x = 1029
integer y = 808
end type

type cb_iapp_fix from w_utilities5`cb_iapp_fix within w_utilities_app
integer x = 1029
integer y = 1240
end type

type cb_multi_affil_check from w_utilities5`cb_multi_affil_check within w_utilities_app
boolean visible = false
integer x = 1047
integer y = 292
end type

type cb_dapplications from w_utilities5`cb_dapplications within w_utilities_app
integer x = 2144
integer y = 2572
integer taborder = 510
end type

type cb_dmanual from w_utilities5`cb_dmanual within w_utilities_app
integer x = 2094
integer y = 2612
integer taborder = 490
end type

type cb_print_reset from w_utilities5`cb_print_reset within w_utilities_app
integer x = 1047
integer y = 500
end type

type cb_assignedusers from w_utilities5`cb_assignedusers within w_utilities_app
integer x = 2235
integer y = 556
end type

type cb_oig from w_utilities5`cb_oig within w_utilities_app
integer x = 2126
integer y = 2572
end type

type st_2 from w_utilities5`st_2 within w_utilities_app
end type

type cb_user_security from w_utilities5`cb_user_security within w_utilities_app
integer y = 1904
end type

type cb_docids from w_utilities5`cb_docids within w_utilities_app
integer x = 2281
integer y = 1988
end type

type cb_stat_check from w_utilities5`cb_stat_check within w_utilities_app
integer x = 2249
integer y = 1876
end type

type cb_support_settings from w_utilities5`cb_support_settings within w_utilities_app
integer x = 1143
integer taborder = 560
end type

type cb_priv_adj from w_utilities5`cb_priv_adj within w_utilities_app
integer x = 2107
integer y = 2532
end type

type cb_comm_review_fix from w_utilities5`cb_comm_review_fix within w_utilities_app
integer x = 2135
integer y = 2464
end type

type cb_links from w_utilities5`cb_links within w_utilities_app
integer x = 1029
integer y = 1352
end type

type cb_db_back from w_utilities5`cb_db_back within w_utilities_app
end type

type cb_fix from w_utilities5`cb_fix within w_utilities_app
integer x = 2126
integer y = 2412
end type

type dw_3 from w_utilities5`dw_3 within w_utilities_app
end type

type cb_3 from w_utilities5`cb_3 within w_utilities_app
integer x = 1719
end type

type cb_2 from w_utilities5`cb_2 within w_utilities_app
integer x = 2085
integer y = 2364
end type

type cb_1 from w_utilities5`cb_1 within w_utilities_app
integer x = 1431
integer taborder = 580
end type

type dw_facilcomm from w_utilities5`dw_facilcomm within w_utilities_app
end type

type dw_praccomm from w_utilities5`dw_praccomm within w_utilities_app
end type

type dw_pracaffil from w_utilities5`dw_pracaffil within w_utilities_app
end type

type gb_adm from w_utilities5`gb_adm within w_utilities_app
integer x = 14
integer height = 2128
end type

type gb_2 from w_utilities5`gb_2 within w_utilities_app
integer x = 2117
integer y = 1444
end type

type dw_dvfieldcopy from w_utilities5`dw_dvfieldcopy within w_utilities_app
end type

type dw_data_view_list from w_utilities5`dw_data_view_list within w_utilities_app
end type

type gb_3 from w_utilities5`gb_3 within w_utilities_app
integer x = 2103
integer y = 176
end type

type gb_4 from w_utilities5`gb_4 within w_utilities_app
integer x = 1019
integer y = 128
integer height = 2128
end type

type cb_settings from w_utilities5`cb_settings within w_utilities_app
integer x = 73
integer y = 2112
integer taborder = 420
end type

type cb_mod_prf_scr from w_utilities5`cb_mod_prf_scr within w_utilities_app
integer x = 3250
integer y = 1664
end type

type cb_clientsetting from w_utilities5`cb_clientsetting within w_utilities_app
integer x = 73
integer y = 856
end type

type cb_old from w_utilities5`cb_old within w_utilities_app
integer x = 3122
integer y = 2384
end type

type cb_image_migrate from w_utilities5`cb_image_migrate within w_utilities_app
integer taborder = 430
end type

type gb_hide from w_utilities5`gb_hide within w_utilities_app
integer x = 2917
integer y = 2180
integer width = 114
integer height = 80
end type

