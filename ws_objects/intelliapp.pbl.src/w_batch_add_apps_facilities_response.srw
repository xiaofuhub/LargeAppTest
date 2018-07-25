$PBExportHeader$w_batch_add_apps_facilities_response.srw
forward
global type w_batch_add_apps_facilities_response from w_batch_add_apps_facilities
end type
end forward

global type w_batch_add_apps_facilities_response from w_batch_add_apps_facilities
end type
global w_batch_add_apps_facilities_response w_batch_add_apps_facilities_response

on w_batch_add_apps_facilities_response.create
call super::create
end on

on w_batch_add_apps_facilities_response.destroy
call super::destroy
end on

event open;call super::open;////Start Code Change ----12.11.2008 #V85 maha - inherited from w_batch _add_app_facilities so as to be a response window

end event

type dw_1 from w_batch_add_apps_facilities`dw_1 within w_batch_add_apps_facilities_response
end type

type cb_1 from w_batch_add_apps_facilities`cb_1 within w_batch_add_apps_facilities_response
end type

type cb_2 from w_batch_add_apps_facilities`cb_2 within w_batch_add_apps_facilities_response
end type

event cb_2::clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_create from w_batch_add_apps_facilities`cb_create within w_batch_add_apps_facilities_response
end type

event cb_create::clicked;call super::clicked;//Start Code Change ----12.11.2008 #V85 maha
if rb_print.checked then
	closewithreturn (parent,"Print")  //Start Code Change ----04.28.2009 #V92 maha - changed from ok to print
end if
end event

type cb_5 from w_batch_add_apps_facilities`cb_5 within w_batch_add_apps_facilities_response
end type

type dw_all_facilities from w_batch_add_apps_facilities`dw_all_facilities within w_batch_add_apps_facilities_response
end type

type st_3 from w_batch_add_apps_facilities`st_3 within w_batch_add_apps_facilities_response
end type

type st_4 from w_batch_add_apps_facilities`st_4 within w_batch_add_apps_facilities_response
end type

type dw_facility_add from w_batch_add_apps_facilities`dw_facility_add within w_batch_add_apps_facilities_response
end type

type cb_now from w_batch_add_apps_facilities`cb_now within w_batch_add_apps_facilities_response
end type

type st_6 from w_batch_add_apps_facilities`st_6 within w_batch_add_apps_facilities_response
end type

type rb_facility from w_batch_add_apps_facilities`rb_facility within w_batch_add_apps_facilities_response
end type

type rb_apps from w_batch_add_apps_facilities`rb_apps within w_batch_add_apps_facilities_response
end type

type rb_print from w_batch_add_apps_facilities`rb_print within w_batch_add_apps_facilities_response
end type

type dw_type from w_batch_add_apps_facilities`dw_type within w_batch_add_apps_facilities_response
end type

type st_1 from w_batch_add_apps_facilities`st_1 within w_batch_add_apps_facilities_response
end type

type sle_note from w_batch_add_apps_facilities`sle_note within w_batch_add_apps_facilities_response
end type

type st_2 from w_batch_add_apps_facilities`st_2 within w_batch_add_apps_facilities_response
end type

type cbx_done from w_batch_add_apps_facilities`cbx_done within w_batch_add_apps_facilities_response
end type

type st_5 from w_batch_add_apps_facilities`st_5 within w_batch_add_apps_facilities_response
end type

type gb_1 from w_batch_add_apps_facilities`gb_1 within w_batch_add_apps_facilities_response
end type

type gb_3 from w_batch_add_apps_facilities`gb_3 within w_batch_add_apps_facilities_response
end type

type cb_prac from w_batch_add_apps_facilities`cb_prac within w_batch_add_apps_facilities_response
end type

type cb_batch from w_batch_add_apps_facilities`cb_batch within w_batch_add_apps_facilities_response
end type

type cb_view from w_batch_add_apps_facilities`cb_view within w_batch_add_apps_facilities_response
end type

type st_pracs from w_batch_add_apps_facilities`st_pracs within w_batch_add_apps_facilities_response
end type

type cb_3 from w_batch_add_apps_facilities`cb_3 within w_batch_add_apps_facilities_response
end type

type dw_locations from w_batch_add_apps_facilities`dw_locations within w_batch_add_apps_facilities_response
end type

type cbx_items from w_batch_add_apps_facilities`cbx_items within w_batch_add_apps_facilities_response
end type

type cb_4 from w_batch_add_apps_facilities`cb_4 within w_batch_add_apps_facilities_response
end type

type st_group from w_batch_add_apps_facilities`st_group within w_batch_add_apps_facilities_response
end type

type st_loc from w_batch_add_apps_facilities`st_loc within w_batch_add_apps_facilities_response
end type

type st_app from w_batch_add_apps_facilities`st_app within w_batch_add_apps_facilities_response
end type

type dw_user from w_batch_add_apps_facilities`dw_user within w_batch_add_apps_facilities_response
end type

type st_7 from w_batch_add_apps_facilities`st_7 within w_batch_add_apps_facilities_response
end type

type pb_notes from w_batch_add_apps_facilities`pb_notes within w_batch_add_apps_facilities_response
end type

type cb_filter_fac from w_batch_add_apps_facilities`cb_filter_fac within w_batch_add_apps_facilities_response
end type

type cb_filter_loc from w_batch_add_apps_facilities`cb_filter_loc within w_batch_add_apps_facilities_response
end type

type cb_filter_app from w_batch_add_apps_facilities`cb_filter_app within w_batch_add_apps_facilities_response
end type

type sle_ffac from w_batch_add_apps_facilities`sle_ffac within w_batch_add_apps_facilities_response
end type

type sle_fapp from w_batch_add_apps_facilities`sle_fapp within w_batch_add_apps_facilities_response
end type

type sle_floc from w_batch_add_apps_facilities`sle_floc within w_batch_add_apps_facilities_response
end type

type st_8 from w_batch_add_apps_facilities`st_8 within w_batch_add_apps_facilities_response
end type

type dw_dept from w_batch_add_apps_facilities`dw_dept within w_batch_add_apps_facilities_response
integer width = 745
integer height = 76
end type

type ddlb_ir from w_batch_add_apps_facilities`ddlb_ir within w_batch_add_apps_facilities_response
end type

type st_ir from w_batch_add_apps_facilities`st_ir within w_batch_add_apps_facilities_response
end type

type gb_prac from w_batch_add_apps_facilities`gb_prac within w_batch_add_apps_facilities_response
end type

