$PBExportHeader$u_tabpage_supporting_docs.sru
$PBExportComments$[intellicontract_tab]  Supporting information Tab
forward
global type u_tabpage_supporting_docs from u_tabpg_contract_master
end type
type tab_1 from u_tab_supporting_other_docs_det within u_tabpage_supporting_docs
end type
type tab_1 from u_tab_supporting_other_docs_det within u_tabpage_supporting_docs
end type
end forward

global type u_tabpage_supporting_docs from u_tabpg_contract_master
integer width = 3653
integer height = 1884
long backcolor = 33551856
string text = "Other Documents"
tab_1 tab_1
end type
global u_tabpage_supporting_docs u_tabpage_supporting_docs

forward prototypes
public function integer of_retrieve ()
end prototypes

public function integer of_retrieve ();

this.tab_1.of_retrieve( )

return 0
end function

on u_tabpage_supporting_docs.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on u_tabpage_supporting_docs.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_selectionchanged;call super::ue_selectionchanged;

this.tab_1.tabpage_1.dw_1.setfocus( )
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpage_supporting_docs
end type

type tab_1 from u_tab_supporting_other_docs_det within u_tabpage_supporting_docs
integer x = 9
integer taborder = 10
boolean bringtotop = true
end type

