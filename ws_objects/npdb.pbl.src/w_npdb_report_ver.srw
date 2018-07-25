$PBExportHeader$w_npdb_report_ver.srw
$PBExportComments$Used to display the data in the datastord
forward
global type w_npdb_report_ver from w_sheet
end type
type cb_close from commandbutton within w_npdb_report_ver
end type
type st_2 from u_st_splitbar within w_npdb_report_ver
end type
type st_1 from statictext within w_npdb_report_ver
end type
type dw_1 from u_dw within w_npdb_report_ver
end type
type cb_7 from commandbutton within w_npdb_report_ver
end type
type cb_submission from commandbutton within w_npdb_report_ver
end type
type cb_response from commandbutton within w_npdb_report_ver
end type
type cb_1 from commandbutton within w_npdb_report_ver
end type
type cb_4 from commandbutton within w_npdb_report_ver
end type
type cb_6 from commandbutton within w_npdb_report_ver
end type
type tv_1 from u_tv within w_npdb_report_ver
end type
end forward

global type w_npdb_report_ver from w_sheet
integer width = 3712
integer height = 1980
string title = "NPDB Reports"
long backcolor = 33551856
boolean center = true
event pfc_print_all ( )
event ue_button_clicl pbm_lbuttonclk
event ue_mail_current ( )
event ue_create_reports ( )
cb_close cb_close
st_2 st_2
st_1 st_1
dw_1 dw_1
cb_7 cb_7
cb_submission cb_submission
cb_response cb_response
cb_1 cb_1
cb_4 cb_4
cb_6 cb_6
tv_1 tv_1
end type
global w_npdb_report_ver w_npdb_report_ver

type prototypes
FUNCTION ulong SetCapture(ulong a) LIBRARY "user32.dll"
FUNCTION boolean ReleaseCapture() LIBRARY "user32.dll"
end prototypes

type variables
n_cst_npdb invo
string is_doc_id
long il_count
long il_prac_id
string is_title = 'NPDB Test Harness '

long li_return_parm
end variables

forward prototypes
public function integer of_open_progress_window ()
end prototypes

event pfc_print_all();


il_count = il_count + 1

for il_count = 1 to  upperbound(invo.ids_npdb_dws)  
	dw_1.dataobject = invo.ids_npdb_dws[il_count].dataobject 
	invo.ids_npdb_dws[il_count].ShareData(dw_1)
	dw_1.event dynamic pfc_print()
next


end event

event ue_create_reports();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_create_reports
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long  ll_lev1, ll_lev2, ll_lev3, ll_lev4
int   index
long ll_start, ll_used

ll_start = Cpu()
//
//invo.OF_Report_npdb(il_prac_id, li_return_parm )

INVO = create n_cst_npdb
INVO.of_initialize( )

INVO.OF_Start_npdb( INVO.is_report , il_prac_id, li_return_parm,is_doc_id,dw_1)

ll_used = Cpu() - ll_start


tv_1.PictureHeight = 32
tv_1.PictureWidth = 32


if upperbound(invo.ids_report_dws) > 0  then
	dw_1.dataobject = invo.ids_report_dws[1].dataobject 
	invo.ids_report_dws[1].ShareData(dw_1)
   il_count = il_count + 1
	if  not f_validstr(invo.ids_report_dws[1].object.compute_9[1]) then 
	   ll_lev1 = tv_1.InsertItemLast(0,  invo.ids_report_dws[1].object.compute_9[1]  ,1)
	else
		ll_lev1 = tv_1.InsertItemLast(0,  'Not Reports Found',1)

	end if

for  il_count = 1 to  upperbound(invo.ids_report_dws)   
	string ls_report_name
	ls_report_name = invo.ids_report_dws[il_count].object.report_type_code[1]
	
	choose case ls_report_name
		case "C"
			ls_report_name=  'Adverse Action Report'
		case "J"
			ls_report_name=  'Judgment or Conviction Report'
		case "P"
			ls_report_name=  'Medical Malpractice Payment Report'
		//Start Code Change ----05.07.2008 #V8 maha - added legacy reports
		case "M"
			ls_report_name=  'Legacy Medical Malpractice Payment Report'
		case "A"
			ls_report_name=  'Legacy Adverse Action Report'
		//End Code Change---05.07.2008
	end choose

	if f_validstr(ls_report_name) then 
	     ll_lev3 = tv_1.InsertItemlast(ll_lev1, ls_report_name, 3)
   end if 

   invo.ids_report_dws[il_count].Object.DataWindow.Print.DocumentName = invo.ids_report_dws[1].object.compute_9[1] + ls_report_name + string(il_count)
	
next

tv_1.ExpandItem(ll_lev1)
tv_1.ExpandItem(ll_lev2)
tv_1.ExpandItem(ll_lev3)
st_1.TEXT =  invo.is_retreive_time + '~r~n' +  "Total Completion Time:" + STRING(ll_used/1000) + ' seconds'

else
	messagebox(title, 'No reports found for this practitioner. ')
	close(this)
end if






end event

public function integer of_open_progress_window (); 
   open(w_infodisp)
	//w_infodisp.visible = false
	//w_infodisp.center = true 
	//w_infodisp.visible = true
	// w_infodisp.height=  340
	w_infodisp.st_1.text = 'Creating NPDB Reports - Please stand by.'
	w_infodisp.title = 'NPDB Reports'
   w_infodisp.st_information.visible = false
	
	
	return 1
	


end function

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : open
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [none]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.visible = false




is_doc_id = Message.stringparm

//OpenWithParm(w_multiple_versions, il_prac_id)

if LenA(is_doc_id) > 0  then
	of_open_progress_window( )
   event ue_create_reports()
   close( w_infodisp )
   IF ISVALID(THIS) THEN this.visible = true
else
	messagebox('PDBB Reports', 'No reports exist for this practitioner..')
	close(this)
end if 







end event

on w_npdb_report_ver.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_7=create cb_7
this.cb_submission=create cb_submission
this.cb_response=create cb_response
this.cb_1=create cb_1
this.cb_4=create cb_4
this.cb_6=create cb_6
this.tv_1=create tv_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_7
this.Control[iCurrent+6]=this.cb_submission
this.Control[iCurrent+7]=this.cb_response
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.cb_6
this.Control[iCurrent+11]=this.tv_1
end on

on w_npdb_report_ver.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_7)
destroy(this.cb_submission)
destroy(this.cb_response)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.cb_6)
destroy(this.tv_1)
end on

event pfc_postopen;call super::pfc_postopen;/****************************************************************************************************************
** [PUBLIC] EVENT   
**--------------------------------------------------------------------------------------------------------------
** Description: Perform pre open requirments
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**--------------------------------------------------------------------------------------------------------------
** Returns:	(none) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/


// set up the rezize, we only need to register userobjects and non PFC objects. All pfc relared stuff will be handeled
// automatically


LONG LL_I
string ls_scale

powerobject lo_powerobjects[]

this.of_SetResize(TRUE)

this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )

ls_scale = this.inv_resize.scale


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
	this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
NEXT
end event

event close;call super::close;
if isvalid(invo) then destroy invo

end event

type cb_close from commandbutton within w_npdb_report_ver
event ue_click pbm_lbuttondblclk
integer x = 3323
integer y = 24
integer width = 311
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)



end event

type st_2 from u_st_splitbar within w_npdb_report_ver
integer x = 731
integer y = 144
integer width = 37
integer height = 1696
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;
n_cst_color lnvo 

//lnvo.dark_magenta

this.of_Register(tv_1, LEFT)

this.of_Register(dw_1, RIGHT)

end event

type st_1 from statictext within w_npdb_report_ver
integer x = 1138
integer width = 878
integer height = 128
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_npdb_report_ver
event pfc_print_all ( )
event ue_mail_current ( )
integer x = 754
integer y = 148
integer width = 2889
integer height = 1696
integer taborder = 30
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event pfc_print_all();LONG LL_COUNT


FOR ll_COUNT = 1 TO upperbound(invo.ids_report_dws) 
	dw_1.dataobject = invo.ids_report_dws[LL_COUNT].dataobject 
	invo.ids_report_dws[LL_COUNT].ShareData(THIS)
	event pfc_print( )
NEXT


end event

event ue_mail_current();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT ue_mail_current
//==================================================================================================================
//  Purpose   	: Mail the curennt reports
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
SetCapture(Handle(this)) // keeps the hourglass solid


constant string ADVERSE_ACTION_REPORT = 'C'
constant string JUDJEMENT_OR_CONVICTION_REPORT = 'J'
constant string MEDICAL_MALPRACTICE_PAYMENT_REPORT = 'P'
constant string LEGACY_ADVERSE_ACTION_REPORT = 'A'
constant string LEGACY_MEDICAL_MALPRACTICE_PAYMENT_REPORT = 'M'
string ls_report_name

choose case parent.dw_1.object.report_type_code[1]
	case ADVERSE_ACTION_REPORT
		ls_report_name = WordCap ( (Lower ('ADVERSE ACTION REPORT')))
	case JUDJEMENT_OR_CONVICTION_REPORT
		ls_report_name =  WordCap (  lower('JUDJEMENT OR CONVICTION REPORT'))
	case MEDICAL_MALPRACTICE_PAYMENT_REPORT
		ls_report_name=  WordCap (  lower('MEDICAL MALPRACTICE PAYMENT REPORT'))
	case LEGACY_MEDICAL_MALPRACTICE_PAYMENT_REPORT
		ls_report_name=  WordCap (  lower('LEGACY MEDICAL MALPRACTICE PAYMENT REPORT'))
	case LEGACY_ADVERSE_ACTION_REPORT
		ls_report_name=  WordCap (  lower(' LEGACY ADVERSE ACTION REPORT'))
	end choose




parent.dw_1.Object.DataWindow.Print.DocumentName = trim(parent.dw_1.object.compute_9[1])	+ ' - ' +ls_report_name
Super::EVENT ue_save_pdf_for_mailing( )

releasecapture( )

//Start Code Change ----10.09.2008 #V85 maha -  readded option to use outlook email
if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
	Super::EVENT ue_mail_bak('NPDB Reports for : ' + trim(parent.dw_1.object.compute_9[1]),'' )
else
	Super::EVENT ue_mail('NPDB Reports for : ' + trim(parent.dw_1.object.compute_9[1]),'' )
end if
//End Code Change---10.09.2008

end event

event ue_mail;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT ue_mail
//==================================================================================================================
//  Purpose   	: Mail the reports
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SetCapture(Handle(this)) // keeps the hourglass solid

constant string ADVERSE_ACTION_REPORT = 'C'
constant string JUDJEMENT_OR_CONVICTION_REPORT = 'J'
constant string MEDICAL_MALPRACTICE_PAYMENT_REPORT = 'P'
constant string LEGACY_ADVERSE_ACTION_REPORT = 'A'
constant string LEGACY_MEDICAL_MALPRACTICE_PAYMENT_REPORT = 'M'
string ls_report_name

long ll_count

for il_count = 1 to upperbound(invo.ids_report_dws)   
	parent.dw_1.dataobject = invo.ids_report_dws[il_count].dataobject 
	invo.ids_report_dws[il_count].ShareData(parent.dw_1)
	
	choose case parent.dw_1.object.report_type_code[1]
		case ADVERSE_ACTION_REPORT
			ls_report_name = WordCap ( (Lower ('ADVERSE ACTION REPORT')))
		case JUDJEMENT_OR_CONVICTION_REPORT
			ls_report_name =  WordCap (  lower('JUDJEMENT OR CONVICTION REPORT'))
		case MEDICAL_MALPRACTICE_PAYMENT_REPORT
			ls_report_name=  WordCap (  lower('MEDICAL MALPRACTICE PAYMENT REPORT'))
		case LEGACY_MEDICAL_MALPRACTICE_PAYMENT_REPORT
			ls_report_name=  WordCap (  lower('LEGACY MEDICAL MALPRACTICE PAYMENT REPORT'))
		case LEGACY_ADVERSE_ACTION_REPORT
			ls_report_name=  WordCap (  lower(' LEGACY ADVERSE ACTION REPORT'))
	end choose
	
	
	parent.dw_1.Object.DataWindow.Print.DocumentName = trim(parent.dw_1.object.compute_9[1]) +' - ' + ls_report_name + '  ' +string(il_count) +  ' of '+ string (upperbound(invo.ids_report_dws))
	event ue_save_pdf_for_mailing( )
next


Super::EVENT ue_mail('NPDB Reports for : ' + wordcap(lower(trim(parent.dw_1.object.compute_9[1])))  ,'' )

releasecapture( )

end event

type cb_7 from commandbutton within w_npdb_report_ver
event ue_click pbm_lbuttondblclk
integer x = 2885
integer y = 24
integer width = 430
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Output Options"
end type

event clicked;


m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options

NewMenu.of_setparent( dw_1)
NewMenu.m_options.PopMenu(parent.x + this.x, parent.y + this.y - 190)



end event

type cb_submission from commandbutton within w_npdb_report_ver
integer x = 146
integer y = 2208
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "ITP Send"
end type

event clicked;

//datastore lds_1
//lds_1 = create datastore
//lds_1.dataobject = 'd_npdb_aa_test'
//lds_1.settransobject( sqlca)
//lds_1.retrieve()
//
//long ll_i
//string ls_doc_id[]
//for ll_i = 1 to lds_1.rowcount( )
//	ls_doc_id[ll_i] = lds_1.object.doc_id[ll_i]
//next
//
//invo.of_send(ls_doc_id) 

 invo.of_start_npdb( invo.is_send,0,0 ,'NONE',dw_1)


///ids_npdb_tracker_upd
//parent.dw_1.dataobject = invo.ids_npdb_tracker_upd.dataobject 
//	invo.ids_npdb_tracker_upd.ShareData(parent.dw_1)
//

end event

type cb_response from commandbutton within w_npdb_report_ver
integer x = 549
integer y = 2208
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "ITP Recieve"
end type

event clicked;

invo.of_start_npdb( invo.is_recieve,0,0,'NONE',dw_1)
parent.cb_4.event clicked( )






end event

type cb_1 from commandbutton within w_npdb_report_ver
integer x = 987
integer y = 2208
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Database"
end type

event clicked;invo.of_create_database()
end event

type cb_4 from commandbutton within w_npdb_report_ver
boolean visible = false
integer x = 731
integer y = 2336
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Nav DWs"
end type

event clicked;

il_count = il_count + 1

if il_count <>  upperbound(invo.ids_npdb_dws) + 1  then
	parent.dw_1.dataobject = invo.ids_npdb_dws[il_count].dataobject 
	invo.ids_npdb_dws[il_count].ShareData(parent.dw_1)
	parent.title = 'NPDB Test Harness ' +'( '+ string(dw_1.Object.DataWindow.Print.DocumentName) +')'
end if

end event

type cb_6 from commandbutton within w_npdb_report_ver
boolean visible = false
integer x = 219
integer y = 2336
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;il_count = il_count + 1

if il_count <>  upperbound(invo.ids_report_dws  ) + 1  then
	parent.dw_1.dataobject = invo.ids_report_dws[il_count].dataobject 
	invo.ids_report_dws[il_count].ShareData(parent.dw_1)
	//parent.title = 'NPDB Test Harness ' +'( '+ string(dw_1.Object.DataWindow.Print.DocumentName) +')'
end if

end event

type tv_1 from u_tv within w_npdb_report_ver
integer y = 144
integer width = 731
integer height = 1696
integer taborder = 10
borderstyle borderstyle = stylebox!
string picturename[] = {"Report!","Output!","Report!"}
end type

event clicked;call super::clicked;

integer li_index

li_index= this.GetItematPointer ( )
li_index  = li_index - 1

if li_index > 0  then
	parent.dw_1.dataobject = invo.ids_report_dws[li_index].dataobject 
	invo.ids_report_dws[li_index].ShareData(parent.dw_1)
   //parent.dw_1.Object.DataWindow.Zoom = 80
   // parent.dw_1.Object.DataWindow.Print.Preview = 'no'
end if

end event

