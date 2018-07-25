$PBExportHeader$w_dm_document_report.srw
forward
global type w_dm_document_report from w_response
end type
type cbx_3 from checkbox within w_dm_document_report
end type
type cbx_2 from checkbox within w_dm_document_report
end type
type cbx_1 from checkbox within w_dm_document_report
end type
type cb_5 from uo_cb_output within w_dm_document_report
end type
type cb_2 from u_cb within w_dm_document_report
end type
type dw_1 from u_dw_contract within w_dm_document_report
end type
type dw_2 from u_dw_contract within w_dm_document_report
end type
end forward

global type w_dm_document_report from w_response
integer width = 3538
integer height = 1936
string title = "Document Report Viewer"
long backcolor = 33551856
event ue_filter ( )
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
cb_5 cb_5
cb_2 cb_2
dw_1 dw_1
dw_2 dw_2
end type
global w_dm_document_report w_dm_document_report

type variables


str_open_report istr_pass   //01.24.2007 By Jervis

end variables

event ue_filter();string ls_Filter


ls_Filter = '1=1'
IF cbx_1.checked THEN
	ls_Filter += " AND ctx_am_document_doc_id="+string(istr_pass.l_doc_id)
END IF

IF cbx_2.checked THEN
	IF not cbx_3.checked THEN
		ls_Filter += " AND ctx_am_doc_audit_action<>'Viewed'"
	END IF
	dw_1.setfilter(ls_Filter)
	dw_1.filter()
	dw_1.sort( )
ELSE
	dw_2.setfilter(ls_Filter)
	dw_2.filter()

END IF

end event

on w_dm_document_report.create
int iCurrent
call super::create
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.cb_5=create cb_5
this.cb_2=create cb_2
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_3
this.Control[iCurrent+2]=this.cbx_2
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.dw_2
end on

on w_dm_document_report.destroy
call super::destroy
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event pfc_postopen;call super::pfc_postopen;
//01.24.2007 By Jervis
istr_pass = message.PowerObjectParm
dw_1.dataobject = istr_pass.s_dataobject
dw_1.SetTransObject(sqlca)
IF istr_pass.s_style='doc' THEN
	dw_1.Retrieve(istr_pass.l_ctx_id)
	dw_2.dataobject = istr_pass.s_dataobject+'_noaudit'
	dw_2.SetTransObject(sqlca)
	dw_2.Retrieve(istr_pass.l_ctx_id)
ELSE
	dw_1.Retrieve(istr_pass.l_doc_id)
	cbx_1.hide( )
	cbx_2.hide( )
	cbx_3.hide()
END IF

If istr_pass.l_ctx_id > 0 Then
	dw_1.Title = 'Report Preview - Contract ID:' + String( istr_pass.l_ctx_id) 
End If

end event

type cbx_3 from checkbox within w_dm_document_report
integer x = 1289
integer y = 1720
integer width = 681
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Include &Viewed actions"
boolean checked = true
end type

event clicked;parent.event ue_filter()
end event

type cbx_2 from checkbox within w_dm_document_report
integer x = 709
integer y = 1720
integer width = 558
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Include &Audit Trail "
boolean checked = true
end type

event clicked;cbx_3.enabled = this.checked

IF Not this.checked THEN cbx_3.checked = FALSE //03.13.2008

IF this.checked THEN
	dw_1.show()
	dw_2.hide()
ELSE
	dw_2.show()
	dw_1.hide()
END IF

parent.event ue_filter()
end event

type cbx_1 from checkbox within w_dm_document_report
integer x = 32
integer y = 1720
integer width = 658
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Only current &document"
end type

event clicked;parent.event ue_filter()
end event

type cb_5 from uo_cb_output within w_dm_document_report
integer x = 2775
integer y = 1708
integer width = 352
integer height = 92
integer taborder = 50
string text = "&Print"
end type

event constructor;call super::constructor;

 idw =  dw_1
end event

event clicked;IF dw_1.visible THEN
	dw_1.Print( )
ELSE
	dw_2.print()
END IF

end event

type cb_2 from u_cb within w_dm_document_report
integer x = 3145
integer y = 1708
integer taborder = 30
string text = "&Close"
end type

event clicked;call super::clicked;
close(parent)
end event

type dw_1 from u_dw_contract within w_dm_document_report
string tag = "Report Preview"
integer width = 3497
integer height = 1684
integer taborder = 10
boolean titlebar = true
string title = "Report Preview"
string dataobject = "d_dm_browse_report"
boolean hscrollbar = true
boolean border = false
boolean ib_isupdateable = false
end type

event rbuttondown;//
end event

event constructor;call super::constructor;this.of_setupdateable( false)
this.ib_rmbmenu = false
end event

type dw_2 from u_dw_contract within w_dm_document_report
string tag = "Report Preview"
boolean visible = false
integer y = 4
integer width = 3497
integer height = 1684
integer taborder = 20
boolean titlebar = true
string title = "Report Preview"
string dataobject = "d_dm_browse_report_noaudit"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.ib_rmbmenu = false
end event

