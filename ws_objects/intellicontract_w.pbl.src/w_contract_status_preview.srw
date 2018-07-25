$PBExportHeader$w_contract_status_preview.srw
forward
global type w_contract_status_preview from w_report_preview
end type
end forward

global type w_contract_status_preview from w_report_preview
integer width = 3771
integer height = 2628
end type
global w_contract_status_preview w_contract_status_preview

on w_contract_status_preview.create
call super::create
end on

on w_contract_status_preview.destroy
call super::destroy
end on

event open;call super::open;long	ll_ctx_id
str_ctx_info lstr_ctx

//add custom status process - jervis 04.19.2011
//ll_ctx_id = Message.DoubleParm
lstr_ctx = Message.powerobjectparm


dw_1.Retrieve(lstr_ctx.al_ctx_id,lstr_ctx.as_fieldname )

end event

event pfc_postopen;//Overwrite - jervis 05.06.2011
end event

type cb_5 from w_report_preview`cb_5 within w_contract_status_preview
integer x = 2912
integer y = 2436
integer width = 448
end type

type cb_4 from w_report_preview`cb_4 within w_contract_status_preview
integer y = 2436
end type

type cb_2 from w_report_preview`cb_2 within w_contract_status_preview
integer x = 3383
integer y = 2436
end type

type dw_1 from w_report_preview`dw_1 within w_contract_status_preview
integer x = 14
integer y = 12
integer width = 3721
integer height = 2396
string dataobject = "d_contract_status_list"
end type

event dw_1::constructor;call super::constructor;This.Object.DataWindow.Print.Preview = 'yes'
end event

