$PBExportHeader$w_dm_email_document_send_ic.srw
forward
global type w_dm_email_document_send_ic from w_dm_email_document_send
end type
end forward

global type w_dm_email_document_send_ic from w_dm_email_document_send
integer height = 2728
end type
global w_dm_email_document_send_ic w_dm_email_document_send_ic

on w_dm_email_document_send_ic.create
call super::create
end on

on w_dm_email_document_send_ic.destroy
call super::destroy
end on

type cb_2 from w_dm_email_document_send`cb_2 within w_dm_email_document_send_ic
integer y = 2520
end type

type cb_1 from w_dm_email_document_send`cb_1 within w_dm_email_document_send_ic
integer y = 2520
end type

type st_2 from w_dm_email_document_send`st_2 within w_dm_email_document_send_ic
integer y = 960
end type

type mle_1 from w_dm_email_document_send`mle_1 within w_dm_email_document_send_ic
integer y = 1272
end type

type st_1 from w_dm_email_document_send`st_1 within w_dm_email_document_send_ic
integer y = 60
end type

type sle_1 from w_dm_email_document_send`sle_1 within w_dm_email_document_send_ic
integer y = 148
integer width = 3497
end type

type sle_subject from w_dm_email_document_send`sle_subject within w_dm_email_document_send_ic
integer y = 340
integer width = 3497
end type

type st_3 from w_dm_email_document_send`st_3 within w_dm_email_document_send_ic
integer y = 348
end type

type sle_sendto from w_dm_email_document_send`sle_sendto within w_dm_email_document_send_ic
integer y = 52
integer width = 3497
end type

type sle_attach from w_dm_email_document_send`sle_attach within w_dm_email_document_send_ic
integer y = 592
end type

type cb_ic from w_dm_email_document_send`cb_ic within w_dm_email_document_send_ic
integer y = 2332
end type

type cb_outlook from w_dm_email_document_send`cb_outlook within w_dm_email_document_send_ic
integer y = 2332
end type

type st_5 from w_dm_email_document_send`st_5 within w_dm_email_document_send_ic
integer y = 160
end type

type rb_file from w_dm_email_document_send`rb_file within w_dm_email_document_send_ic
integer y = 500
end type

type rb_library from w_dm_email_document_send`rb_library within w_dm_email_document_send_ic
integer y = 500
end type

type rb_document from w_dm_email_document_send`rb_document within w_dm_email_document_send_ic
integer y = 500
end type

type cbx_1 from w_dm_email_document_send`cbx_1 within w_dm_email_document_send_ic
boolean visible = false
integer y = 508
boolean enabled = false
end type

type st_4 from w_dm_email_document_send`st_4 within w_dm_email_document_send_ic
boolean visible = false
end type

type st_6 from w_dm_email_document_send`st_6 within w_dm_email_document_send_ic
end type

type st_7 from w_dm_email_document_send`st_7 within w_dm_email_document_send_ic
boolean visible = false
integer y = 2536
integer width = 288
boolean enabled = false
end type

type ddlb_item from w_dm_email_document_send`ddlb_item within w_dm_email_document_send_ic
boolean visible = false
integer y = 2528
boolean enabled = false
end type

type gb_1 from w_dm_email_document_send`gb_1 within w_dm_email_document_send_ic
integer y = 432
end type

type dw_1 from w_dm_email_document_send`dw_1 within w_dm_email_document_send_ic
boolean visible = false
integer x = 622
integer y = 1112
integer width = 2962
boolean enabled = false
end type

type cb_clear_attach from w_dm_email_document_send`cb_clear_attach within w_dm_email_document_send_ic
integer y = 496
end type

type st_file from w_dm_email_document_send`st_file within w_dm_email_document_send_ic
integer y = 508
end type

type st_document from w_dm_email_document_send`st_document within w_dm_email_document_send_ic
boolean visible = false
integer y = 508
boolean enabled = false
end type

type st_library from w_dm_email_document_send`st_library within w_dm_email_document_send_ic
boolean visible = false
integer y = 508
boolean enabled = false
end type

type pb_file from w_dm_email_document_send`pb_file within w_dm_email_document_send_ic
integer y = 492
end type

type pb_library from w_dm_email_document_send`pb_library within w_dm_email_document_send_ic
boolean visible = false
integer y = 492
boolean enabled = false
end type

type pb_document from w_dm_email_document_send`pb_document within w_dm_email_document_send_ic
boolean visible = false
integer y = 492
boolean enabled = false
end type

type rb_ic from w_dm_email_document_send`rb_ic within w_dm_email_document_send_ic
boolean visible = false
integer x = 3488
integer y = 108
boolean enabled = false
boolean checked = false
end type

type rb_oc from w_dm_email_document_send`rb_oc within w_dm_email_document_send_ic
boolean visible = false
integer x = 3488
integer y = 216
boolean enabled = false
boolean checked = true
end type

type sle_sendbcc from w_dm_email_document_send`sle_sendbcc within w_dm_email_document_send_ic
integer y = 244
integer width = 3497
end type

type cb_sendto from w_dm_email_document_send`cb_sendto within w_dm_email_document_send_ic
integer y = 48
end type

type cb_sendcc from w_dm_email_document_send`cb_sendcc within w_dm_email_document_send_ic
integer y = 144
end type

type cb_sendbcc from w_dm_email_document_send`cb_sendbcc within w_dm_email_document_send_ic
integer y = 240
end type

type cb_resize from w_dm_email_document_send`cb_resize within w_dm_email_document_send_ic
integer y = 2520
end type

type cbx_clean from w_dm_email_document_send`cbx_clean within w_dm_email_document_send_ic
boolean visible = false
integer y = 508
boolean enabled = false
end type

type cb_paste_link from w_dm_email_document_send`cb_paste_link within w_dm_email_document_send_ic
boolean visible = false
integer y = 2520
boolean enabled = false
end type

type st_sending_status from w_dm_email_document_send`st_sending_status within w_dm_email_document_send_ic
boolean visible = false
integer y = 2536
boolean enabled = false
end type

type ole_message from w_dm_email_document_send`ole_message within w_dm_email_document_send_ic
integer y = 768
end type

type gb_2 from w_dm_email_document_send`gb_2 within w_dm_email_document_send_ic
boolean visible = false
integer y = 2468
boolean enabled = false
end type

type gb_3 from w_dm_email_document_send`gb_3 within w_dm_email_document_send_ic
integer y = 712
end type

type gb_4 from w_dm_email_document_send`gb_4 within w_dm_email_document_send_ic
boolean visible = false
integer x = 3159
integer y = 720
boolean enabled = false
end type

