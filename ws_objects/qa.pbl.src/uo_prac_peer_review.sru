$PBExportHeader$uo_prac_peer_review.sru
$PBExportComments$uo_peer_reviewb - decencent of uo_peer_review
forward
global type uo_prac_peer_review from uo_peer_review_alternate
end type
type cb_save from commandbutton within uo_prac_peer_review
end type
type cb_add from commandbutton within uo_prac_peer_review
end type
type cb_delete from commandbutton within uo_prac_peer_review
end type
type cb_letter from commandbutton within uo_prac_peer_review
end type
type cb_report from commandbutton within uo_prac_peer_review
end type
end forward

global type uo_prac_peer_review from uo_peer_review_alternate
integer width = 3698
integer height = 1796
long backcolor = 16777215
cb_save cb_save
cb_add cb_add
cb_delete cb_delete
cb_letter cb_letter
cb_report cb_report
end type
global uo_prac_peer_review uo_prac_peer_review

type variables

constant string is_title = 'Case Review'
//PROTECTED:

long   	il_prac_id
long     il_facility_id
boolean ib_prac_focus = false  //maha 12.03.2015

end variables

forward prototypes
public subroutine of_set_prac_id (long al_prac_id)
public subroutine of_set_facility_id (long al_facility_id)
public function integer of_security ()
end prototypes

public subroutine of_set_prac_id (long al_prac_id);


il_prac_id = al_prac_id
end subroutine

public subroutine of_set_facility_id (long al_facility_id);//Added by  Nova 12.08.2009 --v10.1 Profiles Build out
 il_facility_id=al_facility_id
end subroutine

public function integer of_security (); //Start Code Change ----12.03.2015 #V15 maha - readonly security
if w_mdi.	of_security_access(2020) = 1 THEN
	cb_add.visible = false
	cb_delete.visible = false
	cb_letter.visible = false
	cb_save.visible = false
	tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail.enabled = false
	tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.enabled = false
	tab_1.tabpage_detail.tab_2.tabpage_ai.dw_action_item.enabled = false
else
 //Start Code Change ----02.17.2017 #V153 maha - fix add/save buttons
	choose case tab_1.selectedtab
		case 1
			cb_delete.visible = false
			cb_letter.visible = false
			cb_add.visible = false
			cb_save.visible = false	
		case else
			cb_delete.visible = true
			cb_letter.visible = true
			cb_add.visible = true
			cb_save.visible = true	
	end choose
	
//	cb_add.visible = false
//	cb_save.visible = false
 //End Code Change ----02.17.2017
end if

return 1
end function

on uo_prac_peer_review.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_letter=create cb_letter
this.cb_report=create cb_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_letter
this.Control[iCurrent+5]=this.cb_report
end on

on uo_prac_peer_review.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_letter)
destroy(this.cb_report)
end on

event uo_retrieve_browse;//tab_1.tabpage_browse.dw_browse.Retrieve( gs_user_id, il_prac_id, 2 )//commented by  Nova 12.08.2009 --v10.1 Profiles Build out
//Added by  Nova 12.08.2009 --v10.1 Profiles Build outil_facility_id
tab_1.tabpage_browse.dw_browse.Retrieve( gs_user_id, il_prac_id, il_facility_id )
end event

type p_1 from uo_peer_review_alternate`p_1 within uo_prac_peer_review
integer x = 718
integer y = 36
end type

type dw_report from uo_peer_review_alternate`dw_report within uo_prac_peer_review
boolean visible = false
integer x = 1294
integer y = 2732
end type

type tab_1 from uo_peer_review_alternate`tab_1 within uo_prac_peer_review
integer width = 3621
integer height = 1764
long backcolor = 16777215
end type

event tab_1::selectionchanged;call super::selectionchanged; //Start Code Change ----12.03.2015 #V15 maha
of_security()

end event

type tabpage_browse from uo_peer_review_alternate`tabpage_browse within tab_1
integer width = 3584
integer height = 1636
long backcolor = 16777215
end type

type dw_browse from uo_peer_review_alternate`dw_browse within tabpage_browse
integer width = 3579
integer height = 1588
string dataobject = "d_case_review_prac_browse"
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
integer width = 3584
integer height = 1636
end type

type tab_2 from uo_peer_review_alternate`tab_2 within tabpage_detail
integer width = 3584
integer height = 1640
long backcolor = 16777215
tabposition tabposition = tabsontop!
end type

type tabpage_case_detail from uo_peer_review_alternate`tabpage_case_detail within tab_2
integer y = 112
integer width = 3547
integer height = 1512
long backcolor = 16777215
end type

type dw_physicians from uo_peer_review_alternate`dw_physicians within tabpage_case_detail
integer x = 50
integer y = 472
end type

event dw_physicians::constructor;call super::constructor;this.of_setresize( true)
end event

event dw_physicians::getfocus;call super::getfocus;ib_prac_focus = true    //Start Code Change ----12.03.2015 #V15 maha
end event

event dw_physicians::losefocus;call super::losefocus;ib_prac_focus = false   //Start Code Change ----12.03.2015 #V15 maha
end event

type dw_detail from uo_peer_review_alternate`dw_detail within tabpage_case_detail
integer width = 3191
integer height = 1500
end type

type tabpage_ai from uo_peer_review_alternate`tabpage_ai within tab_2
integer y = 112
integer width = 3547
integer height = 1512
long backcolor = 16777215
end type

type dw_ai_report from uo_peer_review_alternate`dw_ai_report within tabpage_ai
end type

event dw_ai_report::constructor;call super::constructor;this.of_setresize( true)
end event

type dw_action_item from uo_peer_review_alternate`dw_action_item within tabpage_ai
integer width = 3182
integer height = 1420
end type

event dw_action_item::constructor;call super::constructor;this.of_setresize( true)
this.setrowfocusindicator( p_1)
end event

type cb_save from commandbutton within uo_prac_peer_review
integer x = 1138
integer y = 12
integer width = 256
integer height = 80
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

type cb_add from commandbutton within uo_prac_peer_review
integer x = 1413
integer y = 12
integer width = 256
integer height = 80
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked; //Start Code Change ----12.03.2015 #V15 maha
choose case tab_1.selectedtab
	case 1
		of_add_case()
	case 2
		choose case tab_1.tabpage_detail.tab_2.selectedtab
			case 1
				if  ib_prac_focus then
					of_add_doc( )
				else
					of_add_case()
				end if
			case 2
				
		end choose
end choose	
	
end event

type cb_delete from commandbutton within uo_prac_peer_review
integer x = 1678
integer y = 12
integer width = 256
integer height = 80
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked; //Start Code Change ----12.03.2015 #V15 maha
choose case tab_1.selectedtab
	case 1
		//cannot delete from here
	case 2
		choose case tab_1.tabpage_detail.tab_2.selectedtab
			case 1 
				if  ib_prac_focus then
					tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.triggerevent("pfc_deleterow")
				else
					tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail.triggerevent("pfc_deleterow")
				end if
			case 2
				tab_1.tabpage_detail.tab_2.tabpage_ai.dw_action_item.triggerevent("pfc_deleterow")
		end choose
end choose	
end event

type cb_letter from commandbutton within uo_prac_peer_review
integer x = 1938
integer y = 12
integer width = 256
integer height = 80
integer taborder = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Letter"
end type

event clicked;of_letter()
end event

type cb_report from commandbutton within uo_prac_peer_review
boolean visible = false
integer x = 2203
integer y = 12
integer width = 256
integer height = 80
integer taborder = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Report"
end type

event clicked;of_ai_report()
end event

