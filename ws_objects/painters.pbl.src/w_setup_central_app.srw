$PBExportHeader$w_setup_central_app.srw
forward
global type w_setup_central_app from w_setup_central
end type
end forward

global type w_setup_central_app from w_setup_central
integer height = 2168
end type
global w_setup_central_app w_setup_central_app

on w_setup_central_app.create
call super::create
end on

on w_setup_central_app.destroy
call super::destroy
end on

type cb_activity from w_setup_central`cb_activity within w_setup_central_app
end type

type cb_photo_prof from w_setup_central`cb_photo_prof within w_setup_central_app
integer x = 78
integer y = 1776
end type

type cb_saved_reports from w_setup_central`cb_saved_reports within w_setup_central_app
end type

type cb_verif_batch from w_setup_central`cb_verif_batch within w_setup_central_app
end type

type cb_zip from w_setup_central`cb_zip within w_setup_central_app
end type

type cb_tracking_labels from w_setup_central`cb_tracking_labels within w_setup_central_app
integer y = 788
end type

type cb_rec_qual from w_setup_central`cb_rec_qual within w_setup_central_app
integer x = 1984
integer y = 592
end type

type cb_rec_pos from w_setup_central`cb_rec_pos within w_setup_central_app
integer x = 1975
integer y = 292
end type

type cb_rec_group from w_setup_central`cb_rec_group within w_setup_central_app
integer x = 1979
integer y = 492
end type

type cb_rec_rec from w_setup_central`cb_rec_rec within w_setup_central_app
integer x = 1984
integer y = 392
end type

type cb_picture_painter from w_setup_central`cb_picture_painter within w_setup_central_app
integer x = 69
end type

type cb_entity from w_setup_central`cb_entity within w_setup_central_app
integer y = 748
end type

type cb_expiring_data_settings from w_setup_central`cb_expiring_data_settings within w_setup_central_app
integer x = 64
integer y = 652
end type

type cb_wv_sig_agree from w_setup_central`cb_wv_sig_agree within w_setup_central_app
end type

type cb_group_setup from w_setup_central`cb_group_setup within w_setup_central_app
integer x = 1970
integer y = 984
end type

type cb_import from w_setup_central`cb_import within w_setup_central_app
end type

type cb_close from w_setup_central`cb_close within w_setup_central_app
end type

type cb_reference from w_setup_central`cb_reference within w_setup_central_app
end type

type cb_profile_screen_design from w_setup_central`cb_profile_screen_design within w_setup_central_app
integer x = 78
integer y = 1968
end type

type cb_fax_templates from w_setup_central`cb_fax_templates within w_setup_central_app
end type

type cb_dtl_setup from w_setup_central`cb_dtl_setup within w_setup_central_app
integer y = 1420
end type

type cb_questions from w_setup_central`cb_questions within w_setup_central_app
end type

type cb_profile_design from w_setup_central`cb_profile_design within w_setup_central_app
integer x = 78
integer y = 1872
end type

type cb_lookup from w_setup_central`cb_lookup within w_setup_central_app
end type

type cb_letter_storage from w_setup_central`cb_letter_storage within w_setup_central_app
end type

type cb_letter_setup from w_setup_central`cb_letter_setup within w_setup_central_app
end type

type cb_document_type_setup from w_setup_central`cb_document_type_setup within w_setup_central_app
end type

type cb_screen_design from w_setup_central`cb_screen_design within w_setup_central_app
integer x = 1970
integer y = 1276
end type

type cb_checklist_setup from w_setup_central`cb_checklist_setup within w_setup_central_app
end type

type cb_email_templates from w_setup_central`cb_email_templates within w_setup_central_app
end type

type cb_group_practice from w_setup_central`cb_group_practice within w_setup_central_app
integer y = 940
end type

type cb_user_setup from w_setup_central`cb_user_setup within w_setup_central_app
integer x = 1979
integer y = 1792
end type

type cb_role_setup from w_setup_central`cb_role_setup within w_setup_central_app
integer x = 1979
integer y = 1696
end type

type cb_view_setup from w_setup_central`cb_view_setup within w_setup_central_app
integer x = 1970
integer y = 1180
end type

type cb_export from w_setup_central`cb_export within w_setup_central_app
end type

type cb_scheduler from w_setup_central`cb_scheduler within w_setup_central_app
end type

type cb_notifications from w_setup_central`cb_notifications within w_setup_central_app
end type

type cb_data_flow from w_setup_central`cb_data_flow within w_setup_central_app
end type

type cb_workflow from w_setup_central`cb_workflow within w_setup_central_app
integer y = 1516
end type

type cb_standing from w_setup_central`cb_standing within w_setup_central_app
end type

type cb_qa_setup from w_setup_central`cb_qa_setup within w_setup_central_app
integer x = 4128
integer y = 608
boolean enabled = false
end type

type cb_qa_metrics from w_setup_central`cb_qa_metrics within w_setup_central_app
integer x = 4128
integer y = 512
boolean enabled = false
end type

type cb_process_temp from w_setup_central`cb_process_temp within w_setup_central_app
integer x = 4128
integer y = 416
boolean enabled = false
end type

type cb_priv_templates from w_setup_central`cb_priv_templates within w_setup_central_app
integer x = 4128
integer y = 320
boolean enabled = false
end type

type cb_priv_procd from w_setup_central`cb_priv_procd within w_setup_central_app
integer x = 4128
integer y = 224
boolean enabled = false
end type

type cb_sec_set from w_setup_central`cb_sec_set within w_setup_central_app
integer x = 1979
integer y = 1888
end type

type cb_app_labels from w_setup_central`cb_app_labels within w_setup_central_app
integer x = 1970
integer y = 1084
end type

type cb_appt_screen from w_setup_central`cb_appt_screen within w_setup_central_app
integer x = 1970
integer y = 884
end type

type cb_survey from w_setup_central`cb_survey within w_setup_central_app
integer x = 64
integer y = 1324
end type

type cb_non_prac from w_setup_central`cb_non_prac within w_setup_central_app
integer x = 3854
integer y = 1768
end type

type cb_multi_app from w_setup_central`cb_multi_app within w_setup_central_app
integer y = 1132
end type

type cb_batch from w_setup_central`cb_batch within w_setup_central_app
integer y = 1036
end type

type cb_facility from w_setup_central`cb_facility within w_setup_central_app
integer y = 844
end type

type cb_comm_meeting_set from w_setup_central`cb_comm_meeting_set within w_setup_central_app
end type

type cb_app_track from w_setup_central`cb_app_track within w_setup_central_app
end type

type cb_web_crawl from w_setup_central`cb_web_crawl within w_setup_central_app
integer x = 4005
integer y = 1996
end type

type cb_fppe_plan from w_setup_central`cb_fppe_plan within w_setup_central_app
integer x = 4128
integer y = 128
boolean enabled = false
end type

type cb_wv_priv_opt from w_setup_central`cb_wv_priv_opt within w_setup_central_app
end type

type cb_wv_role from w_setup_central`cb_wv_role within w_setup_central_app
end type

type cb_wv_agree from w_setup_central`cb_wv_agree within w_setup_central_app
end type

type cb_wv_logo from w_setup_central`cb_wv_logo within w_setup_central_app
end type

type cb_wv_doc_temp from w_setup_central`cb_wv_doc_temp within w_setup_central_app
end type

type cb_wv_letter_temp from w_setup_central`cb_wv_letter_temp within w_setup_central_app
end type

type cb_wv_users from w_setup_central`cb_wv_users within w_setup_central_app
end type

type cb_wv_settings from w_setup_central`cb_wv_settings within w_setup_central_app
end type

type cb_wv_help from w_setup_central`cb_wv_help within w_setup_central_app
end type

type cb_cont_req_profile from w_setup_central`cb_cont_req_profile within w_setup_central_app
integer y = 1360
end type

type cb_cpt_codes from w_setup_central`cb_cpt_codes within w_setup_central_app
integer y = 1456
end type

type cb_cont_clause from w_setup_central`cb_cont_clause within w_setup_central_app
integer y = 1552
end type

type cb_cont_doc_lib from w_setup_central`cb_cont_doc_lib within w_setup_central_app
integer y = 1648
end type

type cb_cont_temp_lib from w_setup_central`cb_cont_temp_lib within w_setup_central_app
integer y = 1744
end type

type cb_app_map from w_setup_central`cb_app_map within w_setup_central_app
end type

type cb_cont_view from w_setup_central`cb_cont_view within w_setup_central_app
integer y = 1840
end type

type cb_cont_screen from w_setup_central`cb_cont_screen within w_setup_central_app
integer y = 1936
end type

type cb_wv_email_set from w_setup_central`cb_wv_email_set within w_setup_central_app
end type

type cb_app_temp from w_setup_central`cb_app_temp within w_setup_central_app
end type

type cb_button from w_setup_central`cb_button within w_setup_central_app
integer x = 1979
integer y = 1600
end type

type cb_recruit from w_setup_central`cb_recruit within w_setup_central_app
integer x = 1970
integer y = 88
end type

type cb_calllog from w_setup_central`cb_calllog within w_setup_central_app
end type

type cb_call_lookup from w_setup_central`cb_call_lookup within w_setup_central_app
end type

type cb_zip_setup from w_setup_central`cb_zip_setup within w_setup_central_app
integer y = 1612
end type

type cb_recruit_design from w_setup_central`cb_recruit_design within w_setup_central_app
integer x = 1975
integer y = 192
end type

type gb_11 from w_setup_central`gb_11 within w_setup_central_app
end type

type gb_10 from w_setup_central`gb_10 within w_setup_central_app
end type

type gb_5 from w_setup_central`gb_5 within w_setup_central_app
end type

type gb_4 from w_setup_central`gb_4 within w_setup_central_app
integer height = 684
end type

type gb_1 from w_setup_central`gb_1 within w_setup_central_app
integer x = 23
integer y = 1724
integer height = 348
end type

type gb_sec from w_setup_central`gb_sec within w_setup_central_app
integer x = 1943
integer y = 1536
end type

type gb_8 from w_setup_central`gb_8 within w_setup_central_app
integer x = 18
integer y = 0
integer height = 1728
end type

type gb_2 from w_setup_central`gb_2 within w_setup_central_app
integer x = 4087
integer y = 68
boolean enabled = false
end type

type gb_rec from w_setup_central`gb_rec within w_setup_central_app
integer x = 1929
integer y = 16
end type

type gb_7 from w_setup_central`gb_7 within w_setup_central_app
integer x = 1929
integer y = 728
integer height = 736
end type

type gb_cont from w_setup_central`gb_cont within w_setup_central_app
integer y = 1292
end type

type gb_wv from w_setup_central`gb_wv within w_setup_central_app
end type

