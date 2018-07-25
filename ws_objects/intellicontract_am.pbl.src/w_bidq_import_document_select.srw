$PBExportHeader$w_bidq_import_document_select.srw
forward
global type w_bidq_import_document_select from w_bidq_import_document
end type
end forward

global type w_bidq_import_document_select from w_bidq_import_document
string tag = "Add From Document Queue"
integer width = 2875
integer height = 1376
string title = "Add From Document Queue"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
windowstate windowstate = normal!
boolean center = true
end type
global w_bidq_import_document_select w_bidq_import_document_select

type variables
Long il_ctx_id


end variables

on w_bidq_import_document_select.create
call super::create
end on

on w_bidq_import_document_select.destroy
call super::destroy
end on

event closequery;//Override
If ib_Doing Then 
	Return 1
Else
	Return 0
End If

end event

event pfc_preopen;//Override

end event

event pfc_postopen;call super::pfc_postopen;//Modified By Ken.Guo 2010-07-01
//For Batch Add/Create Doc Feature
/*
If il_ctx_id = 0 Then
	Messagebox('Error','Failed to get contract ID, please call support.')
	Close(This)
End If
uo_search.dw_search_det1.insertRow(0)
uo_search.dw_search_det1.SetItem(1,'ctx_id',il_ctx_id)
*/

Long i,ll_cnt,ll_row
ll_cnt = UpperBound(istr_batch_doc.al_ctx_id[])
If ll_cnt = 0 Then
	Messagebox('Error','Failed to get contract ID, please call support.')
	Close(This)	
End If
For i = 1 To ll_cnt
	ll_row = uo_search.dw_search_det1.insertRow(0)
	uo_search.dw_search_det1.SetItem(ll_row,'ctx_id',istr_batch_doc.al_ctx_id[i])	
Next
cbx_attachall.checked = True
end event

event open;call super::open;//il_ctx_id = Message.doubleparm  //Need move to dw_document.Constructor()
end event

event activate;//Override-jervis 04.24.2009
end event

type cb_log from w_bidq_import_document`cb_log within w_bidq_import_document_select
end type

type cb_stop from w_bidq_import_document`cb_stop within w_bidq_import_document_select
end type

type cb_save2 from w_bidq_import_document`cb_save2 within w_bidq_import_document_select
end type

type cb_select from w_bidq_import_document`cb_select within w_bidq_import_document_select
integer x = 41
integer y = 1168
end type

type cbx_attachall from w_bidq_import_document`cbx_attachall within w_bidq_import_document_select
boolean visible = false
integer y = 2212
end type

type cb_scan from w_bidq_import_document`cb_scan within w_bidq_import_document_select
boolean visible = false
integer x = 1833
integer y = 1476
end type

type cb_preview from w_bidq_import_document`cb_preview within w_bidq_import_document_select
boolean visible = false
integer x = 2190
integer y = 1476
end type

type cb_clearcriteria from w_bidq_import_document`cb_clearcriteria within w_bidq_import_document_select
boolean visible = false
integer y = 2080
end type

type cb_search from w_bidq_import_document`cb_search within w_bidq_import_document_select
boolean visible = false
integer y = 2080
end type

type cb_selectfile from w_bidq_import_document`cb_selectfile within w_bidq_import_document_select
boolean visible = false
integer x = 1477
integer y = 1476
end type

type dw_document from w_bidq_import_document`dw_document within w_bidq_import_document_select
integer y = 256
integer width = 2738
integer height = 852
string dragicon = ""
borderstyle borderstyle = stylebox!
end type

event dw_document::constructor;call super::constructor;This.of_setupdateable(False)

This.Modify("doc_name.Protect = '1'")
This.Modify("doc_type.Protect = '1'")
This.Modify("category.Protect = '1'")
This.Modify("doc_from_name.Protect = '1'")
This.Modify("filename.Protect = '1'")
This.Modify("notes.Protect = '1'")


//il_ctx_id = Message.doubleparm //Added by Ken.Guo on 2009-01-08
istr_batch_doc = Message.Powerobjectparm
end event

event dw_document::mousemove;//
end event

type cb_save from w_bidq_import_document`cb_save within w_bidq_import_document_select
integer x = 3689
integer y = 176
end type

type cb_add from w_bidq_import_document`cb_add within w_bidq_import_document_select
boolean visible = false
integer x = 599
integer y = 1476
end type

type cb_delete from w_bidq_import_document`cb_delete within w_bidq_import_document_select
boolean visible = false
integer x = 955
integer y = 1476
end type

type cb_attach from w_bidq_import_document`cb_attach within w_bidq_import_document_select
integer x = 2098
integer y = 1168
end type

type cbx_pdf from w_bidq_import_document`cbx_pdf within w_bidq_import_document_select
boolean visible = false
integer x = 2779
integer y = 1376
end type

type cb_setdef from w_bidq_import_document`cb_setdef within w_bidq_import_document_select
boolean visible = false
integer x = 3237
integer y = 176
end type

type cbx_preview from w_bidq_import_document`cbx_preview within w_bidq_import_document_select
boolean visible = false
integer x = 3337
integer y = 1376
end type

type hpb_progress from w_bidq_import_document`hpb_progress within w_bidq_import_document_select
integer x = 901
integer y = 1172
integer width = 1010
end type

type cb_createqueue from w_bidq_import_document`cb_createqueue within w_bidq_import_document_select
boolean visible = false
integer x = 3255
integer y = 524
end type

type cb_close from w_bidq_import_document`cb_close within w_bidq_import_document_select
integer x = 2455
integer y = 1168
end type

type cb_deletequeue from w_bidq_import_document`cb_deletequeue within w_bidq_import_document_select
boolean visible = false
integer x = 3232
integer y = 380
end type

type dw_bidq from w_bidq_import_document`dw_bidq within w_bidq_import_document_select
integer y = 60
integer width = 1445
end type

type gb_view from w_bidq_import_document`gb_view within w_bidq_import_document_select
integer y = 4
integer width = 1481
end type

type gb_document from w_bidq_import_document`gb_document within w_bidq_import_document_select
integer y = 196
integer width = 2807
integer height = 944
string text = "Select Imported Documents"
end type

type uo_search from w_bidq_import_document`uo_search within w_bidq_import_document_select
boolean visible = false
integer y = 1452
end type

type gb_contract from w_bidq_import_document`gb_contract within w_bidq_import_document_select
boolean visible = false
integer y = 1400
end type

type lb_tempfile from w_bidq_import_document`lb_tempfile within w_bidq_import_document_select
integer x = 3337
integer y = 820
end type

type st_progress from w_bidq_import_document`st_progress within w_bidq_import_document_select
integer x = 398
integer y = 1184
integer width = 503
long backcolor = 33551856
end type

