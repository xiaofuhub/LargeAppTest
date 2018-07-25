$PBExportHeader$w_manual_workflow_list.srw
forward
global type w_manual_workflow_list from w_response
end type
type dw_1 from u_dw within w_manual_workflow_list
end type
type cb_create from commandbutton within w_manual_workflow_list
end type
type cb_2 from commandbutton within w_manual_workflow_list
end type
end forward

global type w_manual_workflow_list from w_response
integer x = 946
integer y = 432
integer width = 1787
integer height = 1852
string title = "Create Work Flow "
boolean controlmenu = false
long backcolor = 33551856
dw_1 dw_1
cb_create cb_create
cb_2 cb_2
end type
global w_manual_workflow_list w_manual_workflow_list

type variables
string	is_module
long		il_prac_id , il_facility_id,il_ctx_action_item_id,il_ctx_id
long il_doc_id		//15.01.2007 By Jervis
end variables

on w_manual_workflow_list.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_create=create cb_create
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_create
this.Control[iCurrent+3]=this.cb_2
end on

on w_manual_workflow_list.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_create)
destroy(this.cb_2)
end on

event open;call super::open;str_manual_wf lstr_workflow

lstr_workflow = Message.powerobjectparm

is_module 	= lstr_workflow.is_module
il_prac_id 	= lstr_workflow.il_prac_id
il_facility_id = lstr_workflow.il_facility_id
il_ctx_action_item_id = lstr_workflow.ctx_action_item_id
il_ctx_id = lstr_workflow.ctx_id
il_doc_id = lstr_workflow.doc_id	//15.1.2007 By Jervis
//---------Begin Modified by (Appeon)Harry 06.14.2013 for V141 ISG-CLX--------
//dw_1.retrieve( is_module )
If IsNull(il_doc_id) Then il_doc_id = -1
dw_1.Retrieve(is_module,il_doc_id)
//---------End Modfiied ------------------------------------------------------

If dw_1.rowcount() > 0 Then cb_create.enabled = true


end event

type dw_1 from u_dw within w_manual_workflow_list
integer x = 18
integer y = 16
integer width = 1737
integer height = 1628
integer taborder = 10
string dataobject = "d_manual_worflow_list"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
If not row > 0 Then return

cb_create.event clicked()

end event

event constructor;call super::constructor;this.of_setupdateable( false)
end event

event rowfocuschanged;call super::rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-15 By: Scofield
//$<Reason> Select current row.

if CurrentRow > 0 and CurrentRow <= This.RowCount() then
	This.SelectRow(0,false)
	This.SelectRow(CurrentRow,true)
end if
//---------------------------- APPEON END ----------------------------

end event

type cb_create from commandbutton within w_manual_workflow_list
integer x = 905
integer y = 1660
integer width = 480
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Create Work Flow"
end type

event clicked;
//Added for Work Flow. 10/30/2006
n_cst_workflow_triggers lnv_workflow
long ll_wf_id,ll_Rtn

If not gb_workflow Then return 0
If not dw_1.GetRow() > 0 Then return 0

ll_wf_id = dw_1.GetItemnumber(dw_1.getrow() , 'wf_id')

lnv_workflow = create n_cst_workflow_triggers

//If there is no work flow is related to the facility, then return 
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11.17.2006 By: Jervis
//$<reason> 
//lnv_workflow.of_workflow_create_action_items( il_prac_id, 1, 1, il_facility_id, ll_wf_id)
str_action_item lstr_action
choose case is_module
	case "01","02"
		lstr_action.prac_id = il_prac_id
		lstr_action.rec_id = 1
		lstr_action.screen_id = -10
		lstr_action.facility_id = il_facility_id
	case "03"
		lstr_action.ctx_action_item_id = il_ctx_action_item_id
		lstr_action.ctx_id = il_ctx_id
	case "04"
		lstr_action.doc_id = il_doc_id
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.09.2007 By: Machongmin
		//$<reason> Fix a defect.	
		lstr_action.ctx_id = il_ctx_id
		//---------------------------- APPEON END ----------------------------
end choose

lstr_action.wf_id  = ll_wf_id
ll_Rtn = lnv_workflow.of_workflow_create_action_items(lstr_action)

destroy lnv_workflow

if ll_Rtn = 0 then Return			//Added by Scofield on 2008-12-10
//---------------------------- APPEON END ----------------------------

CloseWithReturn( Parent, "OK")

end event

type cb_2 from commandbutton within w_manual_workflow_list
integer x = 1413
integer y = 1660
integer width = 343
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "CANCEL")
end event

