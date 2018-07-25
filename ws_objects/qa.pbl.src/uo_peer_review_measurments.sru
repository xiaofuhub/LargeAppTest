$PBExportHeader$uo_peer_review_measurments.sru
forward
global type uo_peer_review_measurments from uo_peer_review_alternate
end type
end forward

global type uo_peer_review_measurments from uo_peer_review_alternate
integer width = 3264
integer height = 1600
end type
global uo_peer_review_measurments uo_peer_review_measurments

on uo_peer_review_measurments.create
call super::create
end on

on uo_peer_review_measurments.destroy
call super::destroy
end on

type dw_report from uo_peer_review_alternate`dw_report within uo_peer_review_measurments
end type

type tab_1 from uo_peer_review_alternate`tab_1 within uo_peer_review_measurments
boolean visible = false
integer height = 1580
end type

type tabpage_browse from uo_peer_review_alternate`tabpage_browse within tab_1
integer height = 1452
end type

type dw_browse from uo_peer_review_alternate`dw_browse within tabpage_browse
integer height = 1412
end type

type tabpage_detail from uo_peer_review_alternate`tabpage_detail within tab_1
integer height = 1452
end type

type tab_2 from uo_peer_review_alternate`tab_2 within tabpage_detail
integer height = 1420
end type

type tabpage_case_detail from uo_peer_review_alternate`tabpage_case_detail within tab_2
integer height = 1292
end type

type dw_physicians from uo_peer_review_alternate`dw_physicians within tabpage_case_detail
end type

type dw_detail from uo_peer_review_alternate`dw_detail within tabpage_case_detail
integer x = 0
integer y = 0
integer height = 1272
string dataobject = "d_case_review_det"
end type

type tabpage_ai from uo_peer_review_alternate`tabpage_ai within tab_2
integer height = 1292
end type

type dw_ai_report from uo_peer_review_alternate`dw_ai_report within tabpage_ai
end type

type dw_action_item from uo_peer_review_alternate`dw_action_item within tabpage_ai
end type

