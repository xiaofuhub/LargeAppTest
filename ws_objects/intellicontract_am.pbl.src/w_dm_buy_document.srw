$PBExportHeader$w_dm_buy_document.srw
forward
global type w_dm_buy_document from w_dm_sell_document
end type
end forward

global type w_dm_buy_document from w_dm_sell_document
integer height = 1412
long backcolor = 33551856
end type
global w_dm_buy_document w_dm_buy_document

type variables

end variables

on w_dm_buy_document.create
call super::create
end on

on w_dm_buy_document.destroy
call super::destroy
end on

event open;call super::open;String	ls_Null
DateTime	ldt_Null
datawindowchild ldwc_category
Long ll_category,ll_null

SetNull(ll_null)
SetNull(ls_Null)
SetNull(ldt_Null)

if ib_new then
	dw_1.SetItem(1,"doc_type","Other")
	dw_1.SetItem(1,"received_by",gs_user_id)
	dw_1.SetItem(1,"received_date",Today())
	dw_1.SetColumn("doc_name")
	
	//Added By Ken.Guo 2009-12-04. Filter by contract category.
	dw_1.Getchild( "category", ldwc_category)
	of_filter_category(ldwc_category, '-1')
	//Added By Ken.Guo 2010-01-14.
	ll_category = dw_1.GetItemNumber(1,'Category')
	IF ldwc_category.find('lookup_code = '+string(ll_category),1,ldwc_category.rowcount()) < 1 THEN 
		dw_1.setitem(1, 'category', ll_NULL)
	END IF 	
	
	
	dw_1.SetitemStatus(1,0,Primary!,NotModified!)		//Added by Scofield on 2009-12-10
Else
	dw_1.modify('p_attachment.height = 0')
end if

end event

type cbx_preview from w_dm_sell_document`cbx_preview within w_dm_buy_document
integer x = 1925
long backcolor = 33551856
end type

type st_process from w_dm_sell_document`st_process within w_dm_buy_document
integer x = 1925
integer y = 736
long backcolor = 33551856
end type

type cb_design from w_dm_sell_document`cb_design within w_dm_buy_document
integer x = 1925
integer y = 1024
end type

type st_info from w_dm_sell_document`st_info within w_dm_buy_document
boolean visible = true
integer y = 1252
integer width = 1632
long backcolor = 33551856
end type

type cb_preview from w_dm_sell_document`cb_preview within w_dm_buy_document
boolean visible = true
integer x = 1925
end type

type cb_weblink from w_dm_sell_document`cb_weblink within w_dm_buy_document
integer x = 1925
end type

type cb_4 from w_dm_sell_document`cb_4 within w_dm_buy_document
integer x = 1925
integer y = 1136
end type

type cb_3 from w_dm_sell_document`cb_3 within w_dm_buy_document
integer x = 1925
integer y = 1024
end type

type cb_checkin from w_dm_sell_document`cb_checkin within w_dm_buy_document
boolean visible = true
integer x = 1925
end type

type dw_1 from w_dm_sell_document`dw_1 within w_dm_buy_document
integer width = 1874
integer height = 1204
string dataobject = "d_dm_new_buy_document"
borderstyle borderstyle = stylebox!
end type

event dw_1::clicked;call super::clicked;If dwo.name = 'p_attachment' Then
	cb_preview.event clicked( )
End If
end event

type cb_pastefile from w_dm_sell_document`cb_pastefile within w_dm_buy_document
boolean visible = true
integer x = 1925
end type

type cb_scan from w_dm_sell_document`cb_scan within w_dm_buy_document
boolean visible = true
integer x = 1925
end type

