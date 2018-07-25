$PBExportHeader$u_tab_supporting_other_docs_det.sru
forward
global type u_tab_supporting_other_docs_det from u_tab
end type
type tabpage_1 from u_tabpg_contract_detail2 within u_tab_supporting_other_docs_det
end type
type tabpage_1 from u_tabpg_contract_detail2 within u_tab_supporting_other_docs_det
end type
end forward

global type u_tab_supporting_other_docs_det from u_tab
integer width = 3666
integer height = 1936
long backcolor = 33551856
boolean showtext = false
tabposition tabposition = tabsonbottom!
tabpage_1 tabpage_1
end type
global u_tab_supporting_other_docs_det u_tab_supporting_other_docs_det

forward prototypes
public function integer of_retrieve ()
end prototypes

public function integer of_retrieve ();


this.tabpage_1.of_retrieve()


return 0
end function

on u_tab_supporting_other_docs_det.create
this.tabpage_1=create tabpage_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
end on

on u_tab_supporting_other_docs_det.destroy
call super::destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from u_tabpg_contract_detail2 within u_tab_supporting_other_docs_det
integer x = 18
integer y = 16
integer width = 3630
integer height = 1872
end type

