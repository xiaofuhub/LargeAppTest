$PBExportHeader$w_case_review.srw
forward
global type w_case_review from w_main
end type
type uo_case_review from uo_peer_review_alternate within w_case_review
end type
end forward

global type w_case_review from w_main
string tag = "Case/Peer Review"
integer x = 5
integer y = 192
integer width = 3355
integer height = 1932
string title = "Case/Peer Review"
long backcolor = 80269524
event pfc_cst_letter ( )
event pfc_cst_print_report ( )
event pfc_cst_filter ( )
uo_case_review uo_case_review
end type
global w_case_review w_case_review

forward prototypes
public function integer of_security ()
end prototypes

event pfc_cst_letter;uo_case_review.Event pfc_cst_letter()
end event

event pfc_cst_print_report;uo_case_review.Event pfc_cst_print_report()
end event

event pfc_cst_filter;uo_case_review.Event pfc_cst_filter( )
end event

public function integer of_security ();//for readonly control - alfee 01.14.2010

w_mdi.of_case_review_security(this)

return 1
end function

on w_case_review.create
int iCurrent
call super::create
this.uo_case_review=create uo_case_review
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_case_review
end on

on w_case_review.destroy
call super::destroy
destroy(this.uo_case_review)
end on

event open;call super::open;//w_mdi.SetToolbar( 1, False, AlignAtLeft! )
//w_mdi.SetToolbar( 2, False, AlignAtLeft! )
//w_mdi.SetToolbar( 3, False, AlignAtLeft! )
//w_mdi.SetToolbarPos ( 1, 1, 10, False)	

uo_case_review.parent_window = This
uo_case_review.parent_window_review = This //alfee 01.14.2010
uo_case_review.of_SetUp()
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 02.28.2006 By: Rodger Wu
//$<reson> Fix a defect.
//$<modification> The following script moved to the pfc_postopen event.
/* uo_case_review.tab_1.tabpage_browse.dw_browse.SetFocus( ) */
//---------------------------- APPEON END ----------------------------

of_security() //for security control - alfee 01.14.2010
end event

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-15 By: Allen
//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
/*
w_mdi.ChangeMenu(m_pfe_cst_qa)
*/
If w_mdi.menuname <> 'm_pfe_cst_qa' Then w_mdi.ChangeMenu( m_pfe_cst_qa )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.21.2006 By: LeiWei
//$<reason> Fix a defect.
w_mdi.of_menu_security( w_mdi.MenuName )
//---------------------------- APPEON END ----------------------------

w_mdi.SetToolbarPos ( 2, 1, 200, False)	

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)
//---------------------------- APPEON END ----------------------------
end event

event close;call super::close;if isvalid(w_case_review_filter) then close(w_case_review_filter)// Added by  Nova 05.06.2010


w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.21.2006 By: LeiWei
//$<reason> Fix a defect.
w_mdi.of_menu_security( w_mdi.MenuName )
//---------------------------- APPEON END ----------------------------




end event

event pfc_postopen;call super::pfc_postopen;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.28.2006 By: Rodger Wu
//$<reason> Fix a defect.
//$<modification> The following script line is moved from open event.
uo_case_review.tab_1.tabpage_browse.dw_browse.SetFocus( )
//---------------------------- APPEON END ----------------------------
//For resize  Added by  Nova 02.11.2010------------------------

LONG LL_I
string ls_scale

powerobject lo_powerobjects[]
this.of_SetResize(TRUE)
this.inv_resize.of_setminsize( this.workspacewidth( ) , this.WorkSpaceHeight()	)
this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )
ls_scale = this.inv_resize.scale


//If appeongetclienttype() = 'WEB' Then return//fixed BugE032201	(WEB P3 Nova)  Added by  Nova 03.23.2010

this.inv_resize.of_Register (this.uo_case_review , ls_scale  )

FOR LL_I =  1 TO UPPERBOUND(this.uo_case_review.CONTrol)
   this.inv_resize.of_Register (this.uo_case_review.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.uo_case_review.tab_1.tabpage_browse.CONTrol)
   this.inv_resize.of_Register (this.uo_case_review.tab_1.tabpage_browse.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.uo_case_review.tab_1.tabpage_detail.CONTrol)
   this.inv_resize.of_Register (this.uo_case_review.tab_1.tabpage_detail.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_ai.CONTrol)
   this.inv_resize.of_Register (this.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_ai.CONTrol[LL_I]  , ls_scale )
next
this.inv_resize.of_Register(this.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail, ls_Scale)
this.inv_resize.of_Register(this.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians , ls_Scale)

end event

type uo_case_review from uo_peer_review_alternate within w_case_review
integer x = 5
integer height = 1804
integer taborder = 10
boolean bringtotop = true
boolean border = false
long backcolor = 80269524
end type

on uo_case_review.destroy
call uo_peer_review_alternate::destroy
end on

