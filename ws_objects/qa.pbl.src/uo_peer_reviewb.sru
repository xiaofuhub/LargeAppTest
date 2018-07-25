$PBExportHeader$uo_peer_reviewb.sru
$PBExportComments$uo_peer_reviewb - decencent of uo_peer_review
forward
global type uo_peer_reviewb from uo_peer_review_alternate
end type
end forward

global type uo_peer_reviewb from uo_peer_review_alternate
integer width = 3639
integer height = 1872
end type
global uo_peer_reviewb uo_peer_reviewb

type variables

constant string is_title = 'Case Review'
PROTECTED:

long   	il_prac_id

end variables

forward prototypes
public subroutine of_set_prac_id (long al_prac_id)
end prototypes

public subroutine of_set_prac_id (long al_prac_id);


il_prac_id = al_prac_id
end subroutine

on uo_peer_reviewb.create
call super::create
end on

on uo_peer_reviewb.destroy
call super::destroy
end on

type dw_report from uo_peer_review_alternate`dw_report within uo_peer_reviewb
boolean visible = false
integer x = 1294
integer y = 2732
end type

type tab_1 from uo_peer_review_alternate`tab_1 within uo_peer_reviewb
integer width = 3639
integer height = 1752
tabposition tabposition = tabsonbottom!
end type

type tabpage_browse from uo_peer_review_alternate`tabpage_browse within tab_1
integer y = 16
integer width = 3602
integer height = 1624
end type

type dw_browse from uo_peer_review_alternate`dw_browse within tabpage_browse
integer height = 1588
end type

event dw_browse::pfc_retrieve;call super::pfc_retrieve;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT pfc_retrieve
//==================================================================================================================
//  Purpose   	: retrieve the datawindow
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	:     
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//THIS.SETFOcus( )

//if not isnull(il_prac_id)  then
//	if rowcount( ) > 0 then
//		 if gl_prac_id <> this.object.prac_id[1] then
//			THIS.RETRIEVE(il_prac_id)
//		 end if
//		 
//	end if
//		
//end if

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 08.04.2006 By: LeiWei
//$<modification> Comment out the following redundant script.  The data retrieval is
//$<modification> contained in of_setup() as well.
//THIS.RETRIEVE(il_prac_id)
//---------------------------- APPEON END ----------------------------

// mbs 10 decenber 2004 begin
of_setup( )
// mbs 10 decenber 2004 end

RETURN success


end event

event dw_browse::constructor;call super::constructor;//this.of_setresize( true)
end event

type tabpage_detail from uo_peer_review_alternate`tabpage_detail within tab_1
integer y = 16
integer width = 3602
integer height = 1624
end type

type tab_2 from uo_peer_review_alternate`tab_2 within tabpage_detail
integer x = 0
integer y = 0
integer width = 3639
integer height = 1604
end type

type tabpage_case_detail from uo_peer_review_alternate`tabpage_case_detail within tab_2
integer width = 3602
integer height = 1476
end type

type dw_physicians from uo_peer_review_alternate`dw_physicians within tabpage_case_detail
integer y = 596
end type

event dw_physicians::constructor;call super::constructor;this.of_setresize( true)
end event

type dw_detail from uo_peer_review_alternate`dw_detail within tabpage_case_detail
integer x = 0
integer y = 16
integer height = 1440
end type

event dw_detail::constructor;call super::constructor;this.of_setresize( true)
end event

type tabpage_ai from uo_peer_review_alternate`tabpage_ai within tab_2
integer width = 3602
integer height = 1476
end type

type dw_ai_report from uo_peer_review_alternate`dw_ai_report within tabpage_ai
end type

event dw_ai_report::constructor;call super::constructor;this.of_setresize( true)
end event

type dw_action_item from uo_peer_review_alternate`dw_action_item within tabpage_ai
integer height = 1420
end type

event dw_action_item::constructor;call super::constructor;this.of_setresize( true)
end event

