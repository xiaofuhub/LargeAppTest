$PBExportHeader$w_npdb_reports.srw
forward
global type w_npdb_reports from w_sheet
end type
type cb_sort from commandbutton within w_npdb_reports
end type
type cb_track from commandbutton within w_npdb_reports
end type
type cb_dall from commandbutton within w_npdb_reports
end type
type cb_delete from commandbutton within w_npdb_reports
end type
type cb_1 from commandbutton within w_npdb_reports
end type
type reports from tab within w_npdb_reports
end type
type tabpage_1 from userobject within reports
end type
type cb_2 from pfc_u_cb within tabpage_1
end type
type cb_search from pfc_u_cb within tabpage_1
end type
type sle_prac from singlelineedit within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type dw_1 from u_dw within tabpage_1
end type
type rb_both from radiobutton within tabpage_1
end type
type rb_inc from radiobutton within tabpage_1
end type
type rb_comp from radiobutton within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within reports
cb_2 cb_2
cb_search cb_search
sle_prac sle_prac
st_3 st_3
dw_1 dw_1
rb_both rb_both
rb_inc rb_inc
rb_comp rb_comp
gb_1 gb_1
end type
type tabpage_2 from userobject within reports
end type
type uo_1 from uo_npdb_reports within tabpage_2
end type
type tabpage_2 from userobject within reports
uo_1 uo_1
end type
type tabpage_3 from userobject within reports
end type
type dw_3 from u_dw within tabpage_3
end type
type tabpage_3 from userobject within reports
dw_3 dw_3
end type
type reports from tab within w_npdb_reports
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_npdb_reports from w_sheet
integer width = 4485
integer height = 2364
string title = "NPDB Reports"
long backcolor = 33551856
boolean center = true
cb_sort cb_sort
cb_track cb_track
cb_dall cb_dall
cb_delete cb_delete
cb_1 cb_1
reports reports
end type
global w_npdb_reports w_npdb_reports

type variables


constant string NO_RESPONSE_CODE = 'isNull( response_code )'
constant string WITH_RESPONSE_CODE= 'NOT isNull( response_code )'
constant string BOTH_RESPONSE_CODE= ""
constant string WINDOW_TITLE = 'NPDB Report Viewer'
n_cst_npdb invo_npdb
string is_current_doc_id
string is_run_doc_id
string is_doc_ids[]

str_pass istr_pass


//------------ APPEON BEGIN ------------
//$<Add> 12.04.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
long il_Interface
string is_AdditionFilter = "" // evan 04.16.2010
constant long ITP_INTERFACE  = 1
constant long QRXS_INTERFACE = 2
//------------ APPEON END --------------
end variables

forward prototypes
public function integer wf_filter_dw (u_dw adw, string as_filter)
public subroutine of_set_doc_ids (ref string as_doc_ids[])
public function integer of_show_prac_rpts (string as_doc_id)
public function integer of_set_readonly ()
end prototypes

public function integer wf_filter_dw (u_dw adw, string as_filter);/******************************************************************************************************************
**  [PUBLIC]   : wf_filter_dw( /*u_dw adw*/, /*string as_filter */)
**==================================================================================================================
**  Purpose   	: Filter the datawindow
**==================================================================================================================
**  Arguments 	: [u_dw]  data window
**					: [string] as_filter
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  14 March 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
adw.setredraw(false)

if LenA(is_AdditionFilter) > 0 then // evan 04.16.2010
	if LenA(as_filter) > 0 then as_filter += " AND "
	as_filter += "(" + is_AdditionFilter + ")"
end if

adw.setfilter(as_filter)
if adw.filter() = -1 then messagebox(this.title, 'filter failed')

adw.setredraw(true)


return reports.tabpage_1.dw_1.success




end function

public subroutine of_set_doc_ids (ref string as_doc_ids[]);

is_doc_ids = as_doc_ids

reports.tabpage_1.dw_1.retrieve( is_doc_ids )
end subroutine

public function integer of_show_prac_rpts (string as_doc_id);//////////////////////////////////////////////////////////////////////
// $<function> of_show_prac_rpts
// $<arguments>
// $<returns> integer
// $<description> V10.1 - NPDB QRXS
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.16.2010
//////////////////////////////////////////////////////////////////////

is_AdditionFilter = "doc_id = '" + as_doc_id + "'"

reports.SelectTab(1)
reports.tabpage_1.rb_both.SetFocus()
reports.tabpage_1.rb_both.Checked = true
reports.tabpage_1.rb_both.Event Clicked()

Return 1
end function

public function integer of_set_readonly ();//added by long.zhang 11.13.2021 BugL100904
int i
long LL_COLUMN_COUNT

LL_COLUMN_COUNT = LONG(reports.tabpage_3.dw_3.Describe("DataWindow.Column.Count"))

for i = 1 to LL_COLUMN_COUNT
	reports.tabpage_3.dw_3.Modify( '#'+String(i)+'.protect=1')
	reports.tabpage_3.dw_3.Modify( '#'+String(i)+'.background.color=14803425')
end for

return 1
end function

on w_npdb_reports.create
int iCurrent
call super::create
this.cb_sort=create cb_sort
this.cb_track=create cb_track
this.cb_dall=create cb_dall
this.cb_delete=create cb_delete
this.cb_1=create cb_1
this.reports=create reports
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_sort
this.Control[iCurrent+2]=this.cb_track
this.Control[iCurrent+3]=this.cb_dall
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.reports
end on

on w_npdb_reports.destroy
call super::destroy
destroy(this.cb_sort)
destroy(this.cb_track)
destroy(this.cb_dall)
destroy(this.cb_delete)
destroy(this.cb_1)
destroy(this.reports)
end on

event pfc_postopen;call super::pfc_postopen;//Start Code Change ----05.01.2008 #V8 maha
invo_npdb = create n_cst_npdb
if gs_user_id = "MASTER" then cb_dall.visible = true
//End Code Change---05.01.2008
/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  14 March 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
/*
STRING AS_DOC_IDS[]
long ll_i

setnull(is_current_doc_id)
reports.SelectTab(1)


invo_npdb.of_initialize( )

istr_pass = message.powerobjectparm
invo_npdb =  istr_pass.uo1 

reports.tabpage_2.uo_1.invo = invo_npdb

if upperbound(istr_pass.s_string_array) > 0 then 
			reports.tabpage_1.dw_1.retrieve( istr_pass.s_string_array)
			IF reports.tabpage_1.dw_1.ROWcount( ) > 0 THEN 
			 // 
			ELSE 
				//CLOSE(THIS)
			END IF
			// need to clear out the messageparm for the calander service
			setnull(message.powerobjectparm)
			
			n_cst_color  lnv_color
			reports.tabpage_3.dw_3.of_SetDropDownCalendar(TRUE)
			reports.tabpage_3.dw_3.iuo_calendar.of_Register("first_sent", reports.tabpage_3.dw_3.iuo_calendar.DDLB)
			reports.tabpage_3.dw_3.iuo_calendar.of_Register("last_sent", reports.tabpage_3.dw_3.iuo_calendar.DDLB)
			reports.tabpage_3.dw_3.iuo_calendar.of_Register("date_recieved", reports.tabpage_3.dw_3.iuo_calendar.DDLB)
			reports.tabpage_3.dw_3.iuo_calendar.of_SetSaturdayBold(TRUE)
			reports.tabpage_3.dw_3.iuo_calendar.of_SetSaturdayColor (lnv_color.dark_red )
			reports.tabpage_3.dw_3.iuo_calendar.of_SetSundayBold(TRUE)
			reports.tabpage_3.dw_3.iuo_calendar.of_SetSundayColor(lnv_color.dark_red)
			
			THIS.Visible = TRUE
			
	ELSE
	 close(this)
end if 

setpointer(arrow!)
*/


end event

event pfc_preopen;call super::pfc_preopen;/****************************************************************************************************************
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

setpointer(hourglass!)

LONG LL_I
string ls_scale

powerobject lo_powerobjects[]

this.of_SetResize(TRUE)

this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )

ls_scale = this.inv_resize.scale

FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
NEXT

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.inv_resize.of_Register (reports.tabpage_1, ls_scale  )

FOR LL_I =  1 TO UPPERBOUND(reports.tabpage_1.CONTrol)
   this.inv_resize.of_Register (reports.tabpage_1.CONTrol[LL_I]  , ls_scale )
next


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search uo_data_entry
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.inv_resize.of_Register (reports.tabpage_2, ls_scale  )

FOR LL_I =  1 TO UPPERBOUND(reports.tabpage_2.CONTrol)
   this.inv_resize.of_Register (reports.tabpage_2.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(reports.tabpage_2.uo_1.CONTrol)
   this.inv_resize.of_Register (reports.tabpage_2.uo_1.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(reports.tabpage_3.CONTrol)
   this.inv_resize.of_Register (reports.tabpage_3.CONTrol[LL_I]  , ls_scale )
next

end event

event pfc_close;call super::pfc_close;

//if isvalid( invo_npdb) then destroy invo_npdb
end event

event close;call super::close;
if isvalid(invo_npdb) then destroy invo_npdb
end event

event open;call super::open;//------------------- APPEON BEGIN -------------------
//$<Add> 12.04.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
u_dw ldw_data

il_Interface = of_get_app_setting("set_8", "I")
ldw_data = reports.tabpage_1.dw_1
choose case il_Interface
	case ITP_INTERFACE
		ldw_data.DataObject = "d_npdb_get_responses"
	case else //QRXS_INTERFACE  //Start Code Change ----07.23.2012 #V12 maha - default to QRSX
		ldw_data.DataObject = "d_npdb_get_responses_qrxs"
end choose

ldw_data.of_SetRowSelect(true)
ldw_data.SetTransObject(SQLCA)
//---------Begin Modified by (Appeon)Stephen 04.10.2015 for V15.1-Import Improvements 2015--------
//ldw_data.Retrieve()
choose case il_Interface
	case ITP_INTERFACE
		ldw_data.Retrieve()
	case else 
		ldw_data.Retrieve(gs_user_id)
end choose
//---------End Modfiied ------------------------------------------------------
wf_filter_dw(ldw_data, NO_RESPONSE_CODE)
//------------------- APPEON END ---------------------
end event

event resize;call super::resize;//////////////////////////////////////////////////////////////////////
// $<event> resize
// $<arguments>
//				
// $<returns> integer
// $<description> set resize
//                  v12.2 modify NPDB qrxs report
//////////////////////////////////////////////////////////////////////
// $<add> 09.24.2012 by Stephen
//////////////////////////////////////////////////////////////////////


this.setredraw(false)
reports.tabpage_2.height = reports.tabpage_3.height 
reports.tabpage_2.width = reports.tabpage_3.width 
reports.tabpage_2.y = reports.tabpage_3.y
reports.tabpage_2.x = reports.tabpage_3.x
reports.tabpage_1.height = reports.tabpage_3.height 
reports.tabpage_1.width = reports.tabpage_3.width 
reports.tabpage_1.y = reports.tabpage_3.y
reports.tabpage_1.x = reports.tabpage_3.x
this.setredraw(true)
end event

type cb_sort from commandbutton within w_npdb_reports
integer x = 2409
integer y = 12
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)
reports.tabpage_1.dw_1.SetSort(null_str)

reports.tabpage_1.dw_1.Sort( )
end event

type cb_track from commandbutton within w_npdb_reports
integer x = 2770
integer y = 8
integer width = 421
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Tracking Reports"
end type

event clicked;open(w_npdb_itp_tracking_report)
end event

type cb_dall from commandbutton within w_npdb_reports
boolean visible = false
integer x = 1326
integer y = 16
integer width = 297
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete All"
end type

event clicked;integer res
long li_id
res = messagebox("Delete","Are you sure you wish to delete all data?", question!, yesno!, 2)

if res = 2 then return

//li_id = reports.tabpage_1.dw_1.getitemnumber(reports.tabpage_1.dw_1.getrow(),"npdb_hdr_id")

invo_npdb.of_delete_npdb_data(0)

reports.tabpage_1.dw_1.retrieve()
end event

type cb_delete from commandbutton within w_npdb_reports
integer x = 3200
integer y = 8
integer width = 297
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer res
long li_id
res = messagebox("Delete","Are you sure you wish to delete this record?", question!, yesno!, 2)

if res = 2 then return
if reports.tabpage_1.dw_1.rowcount( )=0  then return

li_id = reports.tabpage_1.dw_1.getitemnumber(reports.tabpage_1.dw_1.getrow(),"npdb_hdr_id")

invo_npdb.of_delete_npdb_data(li_id)

reports.tabpage_1.dw_1.retrieve()
end event

type cb_1 from commandbutton within w_npdb_reports
integer x = 4082
integer y = 8
integer width = 297
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close( Parent)
end event

type reports from tab within w_npdb_reports
integer x = 23
integer y = 20
integer width = 4375
integer height = 2212
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on reports.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on reports.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanging;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  14 March 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if oldindex = newindex then return
if oldindex < 1 then return
long ll_rpt_id //maha 041808
long ll_Row
long ll_npdb_hdr_id
string ls_RootLabel

choose case il_Interface
	case ITP_INTERFACE
		//IF NOT ISNULL(is_current_doc_id) and (is_run_doc_id <> is_current_doc_id) THEN 
		IF NOT ISNULL(is_current_doc_id) and (is_run_doc_id <> is_current_doc_id) and is_current_doc_id <> "" THEN //04.29.2008 By Jervis
			reports.tabpage_2.ENabled = TRUE
			reports.tabpage_2.uo_1.event ue_retrieve(is_current_doc_id)		
			reports.tabpage_3.dw_3.retrieve(is_current_doc_id)
			is_run_doc_id = is_current_doc_id
		END IF
		
		//if isnull(is_current_doc_id)then
		if isnull(is_current_doc_id) or is_current_doc_id = "" then	//04/29/2008 By Jervis
			messagebox(TItle, 'Please select a practitioner.')
			return 1 // do not let the tab change
		end if
	case QRXS_INTERFACE //Add by Evan 12.16.2009 (V10.1 - NPDB QRXS)
		ll_Row = reports.tabpage_1.dw_1.GetRow()
		if ll_Row < 1 then
			MessageBox(Title, "Please select a practitioner.")
			Return 1
		end if
		ls_RootLabel = reports.tabpage_1.dw_1.object.compute_1[ll_Row]
		ll_npdb_hdr_id = reports.tabpage_1.dw_1.object.npdb_hdr_id[ll_Row]
		reports.tabpage_2.uo_1.event ue_retrieve_qrxs(ll_npdb_hdr_id, ls_RootLabel)
		reports.tabpage_3.dw_3.retrieve(is_current_doc_id)
		is_run_doc_id = is_current_doc_id
end choose
end event

type tabpage_1 from userobject within reports
integer x = 18
integer y = 100
integer width = 4338
integer height = 2096
long backcolor = 33551856
string text = "NPDB Report Listing"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_2 cb_2
cb_search cb_search
sle_prac sle_prac
st_3 st_3
dw_1 dw_1
rb_both rb_both
rb_inc rb_inc
rb_comp rb_comp
gb_1 gb_1
end type

on tabpage_1.create
this.cb_2=create cb_2
this.cb_search=create cb_search
this.sle_prac=create sle_prac
this.st_3=create st_3
this.dw_1=create dw_1
this.rb_both=create rb_both
this.rb_inc=create rb_inc
this.rb_comp=create rb_comp
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_search,&
this.sle_prac,&
this.st_3,&
this.dw_1,&
this.rb_both,&
this.rb_inc,&
this.rb_comp,&
this.gb_1}
end on

on tabpage_1.destroy
destroy(this.cb_2)
destroy(this.cb_search)
destroy(this.sle_prac)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.rb_both)
destroy(this.rb_inc)
destroy(this.rb_comp)
destroy(this.gb_1)
end on

type cb_2 from pfc_u_cb within tabpage_1
integer x = 3113
integer y = 48
integer width = 229
integer height = 84
integer taborder = 70
boolean bringtotop = true
string text = "&Clear"
boolean cancel = true
end type

event clicked;//Start Code Change ----09.07.2012 #V12 maha - new button
gs_search lstr_search
string ls_prac_id
string ls_name
u_dw ldw

ldw = reports.tabpage_1.dw_1
reports.tabpage_1.sle_prac.text = ""
is_additionfilter = ""

if reports.tabpage_1.rb_inc.checked then
	wf_filter_dw( ldw, no_response_code )
elseif reports.tabpage_1.rb_comp.checked then
	wf_filter_dw( ldw, with_response_code )
elseif reports.tabpage_1.rb_both.checked then
	wf_filter_dw( ldw, both_response_code )
end if
end event

type cb_search from pfc_u_cb within tabpage_1
integer x = 2871
integer y = 48
integer width = 229
integer height = 84
integer taborder = 60
boolean bringtotop = true
string text = "&Search"
boolean cancel = true
end type

event clicked;//Start Code Change ----09.07.2012 #V12 maha - new button
gs_search lstr_search
string ls_prac_id
string ls_name
u_dw ldw

ldw = reports.tabpage_1.dw_1
lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "MEETINGS" 

OpenWithParm( w_extended_search_new , lstr_search )

if message.doubleparm = -1 then
	is_additionfilter = ""
	reports.tabpage_1.sle_prac.text = ""
else
	ls_name = message.stringparm
	debugbreak()
	ls_prac_id = mid(ls_name, 1, pos(ls_name, "-", 1) -1)
	ls_name = mid(ls_name, pos(ls_name, "-", 1) + 1)
	ls_prac_id = "prac_id = " + ls_prac_id 
	is_additionfilter = ls_prac_id
	reports.tabpage_1.sle_prac.text = ls_name
end if

if reports.tabpage_1.rb_inc.checked then
	wf_filter_dw( ldw, no_response_code )
elseif reports.tabpage_1.rb_comp.checked then
	wf_filter_dw( ldw, with_response_code )
elseif reports.tabpage_1.rb_both.checked then
	wf_filter_dw( ldw, both_response_code )
end if
end event

type sle_prac from singlelineedit within tabpage_1
integer x = 1925
integer y = 52
integer width = 923
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean autohscroll = false
boolean displayonly = true
end type

type st_3 from statictext within tabpage_1
integer x = 1614
integer y = 64
integer width = 302
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Practitioner:"
boolean focusrectangle = false
end type

type dw_1 from u_dw within tabpage_1
integer x = 18
integer y = 168
integer width = 3575
integer height = 1912
integer taborder = 60
string dataobject = "d_npdb_get_responses_qrxs"
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;long ll_row //maha 04.18.08
long ll_rpt_id  //maha 04.18.08

if row < 1 then return

if isvalid(dwo) then
	is_current_doc_id = this.object.doc_id[row]
	TItle = WINDOW_TITLE + ' - '  + this.object.compute_1[row]
end if

inv_rowselect.of_RowSelect(row) //???

//Start Code Change ----04.18.2008 #V8 maha - pass report id
ll_row = this.getclickedrow()
dw_1.setrow(ll_row)
ll_rpt_id = this.getitemnumber(ll_row,"npdb_hdr_id")
reports.tabpage_2.uo_1.of_set_id(ll_rpt_id)
//End Code Change---04.18.2008

end event

event constructor;call super::constructor;//------------------- APPEON BEGIN -------------------
//$<Delete> 12.04.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
/*
this.of_SetRowSelect(TRUE)
retrieve( )
wf_filter_dw(dw_1, NO_RESPONSE_CODE)
*/
//------------------- APPEON END ---------------------
end event

event retrieveend;call super::retrieveend;
if this.rowcount() > 0 then
  //is_current_doc_id = this.object.doc_id[this.GetSelectedRow(0)] 
   is_current_doc_id = this.object.doc_id[1] 
end if
end event

event doubleclicked;call super::doubleclicked;reports.selecttab( 2)
end event

type rb_both from radiobutton within tabpage_1
integer x = 814
integer y = 60
integer width = 219
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Both"
end type

event clicked;


wf_filter_dw(dw_1, BOTH_RESPONSE_CODE)
end event

type rb_inc from radiobutton within tabpage_1
integer x = 55
integer y = 60
integer width = 361
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Incomplete"
boolean checked = true
end type

event clicked;

wf_filter_dw(dw_1, NO_RESPONSE_CODE)
end event

type rb_comp from radiobutton within tabpage_1
integer x = 430
integer y = 60
integer width = 379
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Completed"
end type

event clicked;
wf_filter_dw(dw_1, WITH_RESPONSE_CODE)
end event

type gb_1 from groupbox within tabpage_1
integer x = 18
integer y = -4
integer width = 3365
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Query Results"
end type

type tabpage_2 from userobject within reports
integer x = 18
integer y = 100
integer width = 4338
integer height = 2096
long backcolor = 33551856
string text = "Report(s)"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_1 uo_1
end type

on tabpage_2.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on tabpage_2.destroy
destroy(this.uo_1)
end on

type uo_1 from uo_npdb_reports within tabpage_2
integer x = 18
integer y = 20
integer width = 4315
integer height = 2076
integer taborder = 50
end type

on uo_1.destroy
call uo_npdb_reports::destroy
end on

type tabpage_3 from userobject within reports
integer x = 18
integer y = 100
integer width = 4338
integer height = 2096
long backcolor = 33551856
string text = "Verification"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw within tabpage_3
integer y = 16
integer width = 3401
integer height = 1996
integer taborder = 70
string dataobject = "d_npdb_verif_info_doc_id"
end type

event retrieveend;call super::retrieveend;
of_set_readonly()	//added by long.zhang 11.13.2021 BugL100904
end event

