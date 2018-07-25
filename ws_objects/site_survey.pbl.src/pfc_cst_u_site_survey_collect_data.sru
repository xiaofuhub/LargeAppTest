$PBExportHeader$pfc_cst_u_site_survey_collect_data.sru
forward
global type pfc_cst_u_site_survey_collect_data from userobject
end type
type tab_review from tab within pfc_cst_u_site_survey_collect_data
end type
type tabpage_browse from userobject within tab_review
end type
type dw_browse from u_dw within tabpage_browse
end type
type tabpage_browse from userobject within tab_review
dw_browse dw_browse
end type
type tabpage_setup from userobject within tab_review
end type
type dw_setup from u_dw within tabpage_setup
end type
type tabpage_setup from userobject within tab_review
dw_setup dw_setup
end type
type tabpage_questions from userobject within tab_review
end type
type cb_1 from commandbutton within tabpage_questions
end type
type cb_enlarge from commandbutton within tabpage_questions
end type
type rb_summary from radiobutton within tabpage_questions
end type
type rb_answers from radiobutton within tabpage_questions
end type
type dw_survey_questions from u_dw within tabpage_questions
end type
type dw_answers from u_dw within tabpage_questions
end type
type dw_questions from u_dw within tabpage_questions
end type
type tabpage_questions from userobject within tab_review
cb_1 cb_1
cb_enlarge cb_enlarge
rb_summary rb_summary
rb_answers rb_answers
dw_survey_questions dw_survey_questions
dw_answers dw_answers
dw_questions dw_questions
end type
type tab_review from tab within pfc_cst_u_site_survey_collect_data
tabpage_browse tabpage_browse
tabpage_setup tabpage_setup
tabpage_questions tabpage_questions
end type
end forward

global type pfc_cst_u_site_survey_collect_data from userobject
integer width = 4443
integer height = 2264
boolean border = true
long backcolor = 16777215
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_print_survey ( )
event pfc_cst_delete_survey ( )
tab_review tab_review
end type
global pfc_cst_u_site_survey_collect_data pfc_cst_u_site_survey_collect_data

type variables
Private Long il_template_review_id
Private Long il_address_review_id
Long il_gp_id
Private Boolean ib_new_record = False
end variables

forward prototypes
public function integer of_reset ()
public function integer of_delete_survey ()
public function integer of_new_record (long al_address_id)
public function integer of_retrieve ()
public function integer of_retrieve_browse (integer al_address_id)
public function integer of_retrieve_detail (long al_rec_id)
public function integer of_lock_for_edit ()
public subroutine of_zoom ()
end prototypes

event pfc_cst_print_survey();IF tab_review.SelectedTab = 1 THEN
	if tab_review.tabpage_browse.dw_browse.rowcount( )=0 then return
	tab_review.tabpage_browse.dw_browse.Print()
ELSEIF tab_review.SelectedTab = 2 THEN
	if tab_review.tabpage_setup.dw_setup.rowcount( )=0 then return
	tab_review.tabpage_setup.dw_setup.Print()
ELSEIF tab_review.SelectedTab = 3 THEN
	if tab_review.tabpage_questions.dw_questions.rowcount( )=0 then return
	tab_review.tabpage_questions.dw_questions.Print()
END IF
end event

event pfc_cst_delete_survey;of_delete_survey()
end event

public function integer of_reset ();//dw_reviewed_addresses.Reset()
tab_review.tabpage_browse.dw_browse.Reset()
tab_review.tabpage_questions.dw_survey_questions.Reset()
tab_review.tabpage_questions.dw_questions.Reset()
tab_review.tabpage_questions.dw_answers.Reset()
tab_review.tabpage_setup.dw_setup.Reset()


Return 0
end function

public function integer of_delete_survey ();Integer li_ans
Integer li_row
Long ll_rec_id

//----Begin Added by alfee 11.13.2010 --------------
//<$Reason>For deletion in detail tab page
if tab_review.selectedtab = 2 then	
	if tab_review.tabpage_setup.dw_setup.rowcount( ) < 1 then return 0
	li_row = tab_review.tabpage_setup.dw_setup.getrow()
	if tab_review.tabpage_setup.dw_setup.getitemstatus(li_row,0,primary!) = New! THEN 
		tab_review.tabpage_setup.dw_setup.deleteRow(li_row)
		return 1
	elseif tab_review.tabpage_setup.dw_setup.getitemstatus(li_row,0,primary!) = NewModified! THEN 
		li_ans = MessageBox("Delete", "Are you sure you want to delete this record?", Question!, YesNo! )
		if li_ans = 1 then tab_review.tabpage_setup.dw_setup.deleteRow(li_row)
		return	 1
	end if 
end if
//-----End Added ------------------------------------------

if tab_review.tabpage_browse.dw_browse.rowcount( )=0 then return 0//Added by  Nova 02.26.2010
li_ans = MessageBox("Delete", "Are you sure you want to delete this record?", Question!, YesNo! )

IF li_ans = 1 THEN
	li_row = tab_review.tabpage_browse.dw_browse.GetRow()
	if li_row <= 0 then Return -1 //Add by Evan 2008-03-18
	ll_rec_id =	tab_review.tabpage_browse.dw_browse.GetItemNumber( li_row, "rec_id" ) 
	
	DELETE FROM pd_review_answers  
     WHERE pd_review_answers.rec_id = :ll_rec_id   ;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Error", "Database Error." )
		Return -1
	END IF

	tab_review.tabpage_browse.dw_browse.DeleteRow( li_row )
	tab_review.tabpage_browse.dw_browse.Update( )
	tab_review.tabpage_setup.dw_setup.reset()
	//in postupdate event, of_retrieve_browse is called
	Commit Using SQLCA;
	
	
	
	

END IF

Return 0
end function

public function integer of_new_record (long al_address_id);Integer li_nr
DataWindowChild dwchild

IF il_gp_id = 0 THEN
	MessageBox("Select Error", "You must first select an address to associate with the Survey." )
	Return -1
END IF

tab_review.SelectTab( 2 )

tab_review.tabpage_setup.dw_setup.Reset()
tab_review.tabpage_questions.dw_answers.Reset()
tab_review.tabpage_questions.dw_survey_questions.Reset()

li_nr = tab_review.tabpage_setup.dw_setup.InsertRow(1)
//tab_review.tabpage_setup.dw_setup.ScrollToRow( li_nr )
tab_review.tabpage_setup.dw_setup.SetRow( li_nr )
tab_review.tabpage_setup.dw_setup.SetFocus()
tab_review.tabpage_setup.dw_setup.SetItem( li_nr, "address_id", al_address_id )
tab_review.tabpage_setup.dw_setup.SetItem( li_nr, "lock_for_edit", 0 )

ib_new_record = True

tab_review.tabpage_questions.dw_questions.Reset()
//tab_review.tabpage_questions.dw_questions.InsertRow(0)


RETURN 1
end function

public function integer of_retrieve ();Integer li_rc

//li_rc = dw_reviewed_addresses.Retrieve( il_prac_id )
IF li_rc > 0 THEN
//	dw_reviewed_addresses.SetRow( 1 )
//	dw_reviewed_addresses.ScrollToRow( 1 )
END IF

Return 0

end function

public function integer of_retrieve_browse (integer al_address_id);Integer li_row_cnt

li_row_cnt = tab_review.tabpage_browse.dw_browse.Retrieve( al_address_id )
il_gp_id = al_address_id
if li_row_cnt > 0 then
	il_address_review_id = tab_review.tabpage_browse.dw_browse.GetItemNumber( 1, "rec_id" )
	of_retrieve_detail(il_address_review_id) //added maha 061104
//	tab_review.tabpage_setup.dw_setup.Retrieve( il_address_review_id ) //removed maha 061104
//	tab_review.tabpage_questions.dw_questions.Retrieve( il_address_review_id )
//li_row_cnt = tab_review.tabpage_setup.dw_setup.Retrieve( il_address_review_id )

	IF li_row_cnt = 1 THEN 
		tab_review.SelectTab( 2 )
	ELSE
		tab_review.SelectTab( 1 )	
	END IF
end if

of_zoom()


RETURN 1
end function

public function integer of_retrieve_detail (long al_rec_id);//called from browse clicked as well sw_setup post update

DataWindowChild dwchild
Integer li_row_cnt

//tab_review.tabpage_browse.dw_browse.Retrieve( al_address_id )
//messagebox("al_rec_id",al_rec_id)

//il_address_review_id = tab_review.tabpage_setup.dw_setup.GetItemNumber( 1, "rec_id" )
il_address_review_id = al_rec_id
//messagebox("il_address_review_id",il_address_review_id)

//IF li_row_cnt = 1 THEN  //removed maha 061104
//	tab_review.SelectTab( 2 )
//ELSE
//	tab_review.SelectTab( 1 )	
//END IF

//COMMIT USING SQLCA;

//w_group_practice.Event pfc_save()
tab_review.tabpage_questions.rb_answers.Checked = True
tab_review.tabpage_questions.rb_summary.Checked = False
tab_review.tabpage_questions.dw_questions.DataObject = "d_pd_survey_preview"
tab_review.tabpage_questions.dw_questions.of_SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add the Appeon Queue Labels. 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

tab_review.tabpage_setup.dw_setup.Retrieve( al_rec_id )
tab_review.tabpage_questions.dw_questions.Retrieve( il_address_review_id )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add an Appeon Commit Queue Label. 
gnv_appeondb.of_commitqueue( )
li_row_cnt = tab_review.tabpage_setup.dw_setup.rowcount( )
//---------------------------- APPEON END ----------------------------

of_lock_for_edit() //maha 090104


RETURN 1
end function

public function integer of_lock_for_edit ();if tab_review.tabpage_setup.dw_setup.RowCount() <= 0 then Return 1 //Add by Evan 01/11/2008

//maha created 090104
//Start Code Change ---- 05.23.2006 #482 maha
if tab_review.tabpage_setup.dw_setup.getitemnumber(1,"lock_for_edit") = 1 then //maha 090104
	if tab_review.tabpage_questions.dw_questions.dataobject = "d_pd_survey_preview" then
		tab_review.tabpage_questions.dw_questions.enabled = false
		tab_review.tabpage_questions.cb_enlarge.enabled = false
	else
		tab_review.tabpage_questions.dw_questions.enabled = true
		tab_review.tabpage_questions.cb_enlarge.enabled = true
	end if
	//tab_review.tabpage_questions.dw_questions.Modify( "answer_on_off.protect = '1'" )
else
	tab_review.tabpage_questions.dw_questions.enabled = true
	tab_review.tabpage_questions.cb_enlarge.enabled = true
	//tab_review.tabpage_questions.dw_questions.Modify( "answer_on_off.TabSequence = '10'" )
end if
//End Code Change---05.23.2006
return 1
end function

public subroutine of_zoom (); //Start Code Change ----08.01.2017 #V154 maha
 
tab_review.tabpage_browse.dw_browse.modify("Datawindow.zoom=" + string(gi_zoom)) 
tab_review.tabpage_setup.dw_setup.modify("Datawindow.zoom=" + string(gi_zoom)) 


end subroutine

on pfc_cst_u_site_survey_collect_data.create
this.tab_review=create tab_review
this.Control[]={this.tab_review}
end on

on pfc_cst_u_site_survey_collect_data.destroy
destroy(this.tab_review)
end on

type tab_review from tab within pfc_cst_u_site_survey_collect_data
integer width = 4411
integer height = 2248
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean fixedwidth = true
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 2
tabpage_browse tabpage_browse
tabpage_setup tabpage_setup
tabpage_questions tabpage_questions
end type

on tab_review.create
this.tabpage_browse=create tabpage_browse
this.tabpage_setup=create tabpage_setup
this.tabpage_questions=create tabpage_questions
this.Control[]={this.tabpage_browse,&
this.tabpage_setup,&
this.tabpage_questions}
end on

on tab_review.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_setup)
destroy(this.tabpage_questions)
end on

event selectionchanged;IF newindex = 1 THEN
	tab_review.tabpage_browse.dw_browse.SetFocus()
	IF IsValid( m_pfe_cst_site_survey ) THEN	
		//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		/*
		m_pfe_cst_site_survey.m_file.m_save.enabled = False
		m_pfe_cst_site_survey.m_file.m_print.enabled = True
		m_pfe_cst_site_survey.m_edit.m_delete1.enabled = False
		m_pfe_cst_site_survey.m_edit.m_insert.enabled = False
		*/
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_file.m_save,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_file.m_print,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_edit.m_delete1,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_edit.m_insert,'enabled', False)
		//---------End Modfiied ------------------------------------------------------
	END IF
ELSEIF newindex = 2 THEN
	tab_review.tabpage_setup.dw_setup.SetFocus()	
	tab_review.tabpage_setup.dw_setup.SetColumn( "address_id" )
	IF IsValid( m_pfe_cst_site_survey ) THEN
		//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		/*
		m_pfe_cst_site_survey.m_file.m_save.enabled = True
		m_pfe_cst_site_survey.m_file.m_print.enabled = True
		m_pfe_cst_site_survey.m_edit.m_delete1.enabled = True
		m_pfe_cst_site_survey.m_edit.m_insert.enabled = True
		*/
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_file.m_save,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_file.m_print,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_edit.m_delete1,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_edit.m_insert,'enabled', True)
		//---------End Modfiied ------------------------------------------------------
	END IF
ELSE  //index 3
	tab_review.tabpage_questions.rb_answers.TriggerEvent( Clicked! )
	tab_review.tabpage_questions.rb_answers.checked = true //maha 090701
	tab_review.tabpage_questions.dw_questions.SetFocus()
	//Added by  Nova 02.25.2010
//maha@@@	if IsValid( w_group_practice ) THEN		w_group_practice.tab_1.tabpage_gp.cb_print.visible = true
	IF IsValid( m_pfe_cst_site_survey ) THEN	
		//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		/*
		m_pfe_cst_site_survey.m_file.m_save.enabled = True
		m_pfe_cst_site_survey.m_file.m_print.enabled = True
		m_pfe_cst_site_survey.m_edit.m_delete1.enabled = False
		m_pfe_cst_site_survey.m_edit.m_insert.enabled = False
		*/
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_file.m_save,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_file.m_print,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_edit.m_delete1,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_site_survey.m_edit.m_insert,'enabled', False)
		//---------End Modfiied ------------------------------------------------------
	END IF
END IF
end event

type tabpage_browse from userobject within tab_review
integer x = 18
integer y = 100
integer width = 4375
integer height = 2132
long backcolor = 16777215
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_browse dw_browse
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
end on

type dw_browse from u_dw within tabpage_browse
integer y = 24
integer width = 4357
integer height = 2108
integer taborder = 30
string dataobject = "d_survey_basic_info_browse"
boolean hscrollbar = true
boolean livescroll = false
end type

event doubleclicked;
IF row > 0 THEN
//	of_retrieve_detail( This.GetItemNumber( row, "rec_id" ) )
//	tab_review.tabpage_setup.dw_setup.SetFocus()
	tab_review.SelectTab( 2 )
END IF

end event

event constructor;This.of_SetTransObject( SQLCA )

This.of_SetUpdateAble( False )

DataWindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add the Appeon Queue Labels. 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

This.GetChild( "review_start_time", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Time")

This.GetChild( "review_end_time", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Time")

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add an Appeon Commit Queue Label. 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

end event

event clicked;call super::clicked;
IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	This.ScrollToRow( row )
	This.SetRow( row )
	//\/maha 061104 moved here
	of_retrieve_detail( This.GetItemNumber( row, "rec_id" ) )
	tab_review.tabpage_setup.dw_setup.SetFocus()
END IF
end event

event retrieveend;call super::retrieveend;
IF rowcount > 0 THEN
	This.SelectRow( 1, True )
	This.ScrollToRow( 1 )
	This.SetRow( 1 )
END IF
end event

type tabpage_setup from userobject within tab_review
integer x = 18
integer y = 100
integer width = 4375
integer height = 2132
long backcolor = 16777215
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_setup dw_setup
end type

on tabpage_setup.create
this.dw_setup=create dw_setup
this.Control[]={this.dw_setup}
end on

on tabpage_setup.destroy
destroy(this.dw_setup)
end on

type dw_setup from u_dw within tabpage_setup
integer y = 12
integer width = 4366
integer height = 2120
integer taborder = 11
string dataobject = "d_survey_basic_info"
end type

event pfc_preupdate;call super::pfc_preupdate;Integer i
Integer l
Integer q
Integer li_row_cnt
Integer li_nr
Integer li_quest_row_cnt
Integer li_temp
integer res
Long ll_rec_id
Long  ll_question_answer_id
debugbreak()
//li_row_cnt = This.RowCount()
i = 1
//FOR i = 1 TO li_row_cnt 
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		ib_new_record = True
//		li_temp = 0
//		FOR l = 1 TO li_row_cnt //not necessary as seq_no has no real purpose.  The rec_id  is the primary key.
//			IF This.GetItemNumber( l, "seq_no" ) > li_temp THEN
//				li_temp = This.GetItemNumber( l, "seq_no" )
//			END IF
//		END FOR
//		IF li_temp = 0 THEN
			li_temp = 1
//		ELSE
//			li_temp++
//		END IF
		ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )
		il_address_review_id = ll_rec_id
		This.SetItem( i, "seq_no", li_temp )
		This.SetItem( i, "rec_id", ll_rec_id )

		//Add in template for questions
		il_template_review_id = This.GetItemNumber( i, "review_id" )
		tab_review.tabpage_questions.dw_survey_questions.Retrieve( il_template_review_id )
		li_quest_row_cnt = tab_review.tabpage_questions.dw_survey_questions.RowCount()
		if li_quest_row_cnt < 1 then
			messagebox("The selected review has no questions.","Please complete in Survey Painter before adding.")
			return -1
		else
			FOR q = 1 TO li_quest_row_cnt
				ll_question_answer_id = tab_review.tabpage_questions.dw_survey_questions.GetItemNumber( q, "question_answer_id" )
				li_nr = tab_review.tabpage_questions.dw_answers.InsertRow( 0 )
				tab_review.tabpage_questions.dw_answers.SetItem( li_nr, "rec_id", il_address_review_id )				
				tab_review.tabpage_questions.dw_answers.SetItem( li_nr, "question_answer_id", ll_question_answer_id )			
				tab_review.tabpage_questions.dw_answers.SetItem( li_nr, "answer_on_off", 0 )			
			END FOR	
//			res = tab_review.tabpage_questions.dw_answers.Update()
//			if res < 1 then
//				messagebox("Update failure on survey questions.","The survey questions failed to update.")
//				return -1
//			else
//				commit using sqlca;
//			END IF
		end if
		//retrieve the site surveys into the survey questions tab done in post update

	END IF
//END FOR

RETURN 1
end event

event constructor;DataWindowChild dwchild

This.of_SetTransObject( SQLCA )
This.of_SetReqColumn(TRUE)

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add the Appeon Queue Labels. 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

This.GetChild( "review_start_time", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Time")

This.GetChild( "review_end_time", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Time")

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add an Appeon Commit Queue Label. 
gnv_appeondb.of_commitqueue( )
tab_review.tabpage_setup.dw_setup.Object.lock_for_edit.Protect = 0
//---------------------------- APPEON END ----------------------------

This.of_SetUpdateAble( True )
end event

event pfc_addrow;call super::pfc_addrow;//of_new_record( tab_review.tabpage_setup.dw_setup.GetItemNumber( 1, "address_id" ) )
of_new_record(il_gp_id) //maha changed 062104

Return 1
end event

event pfc_postupdate;call super::pfc_postupdate;integer r
integer rc
integer res

//rc = tab_review.tabpage_browse.dw_browse.Retrieve( tab_review.tabpage_setup.dw_setup.GetItemNumber( 1, "address_id" ) )
rc = tab_review.tabpage_browse.dw_browse.Retrieve( il_gp_id )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.21.2006 By: LeiWei
//$<reason> Performance tuning
gnv_appeondb.of_autocommit( )
//---------------------------- APPEON END ----------------------------
res = tab_review.tabpage_questions.dw_answers.Update()
if res < 1 then
	messagebox("Update failure on survey questions.","The survey questions failed to update.")
	return -1
else
	commit using sqlca;
END IF
		
IF ib_new_record THEN
	//\/maha added 062104
	//r = tab_review.tabpage_browse.dw_browse.find("address_id = " + string(il_address_review_id),r,rc)
	r = tab_review.tabpage_browse.dw_browse.find("rec_id = " + string(il_address_review_id), 1, rc)	 //alfee 11.13.2010
	tab_review.tabpage_browse.dw_browse.scrolltorow(r)
	tab_review.tabpage_browse.dw_browse.setrow(r)
	tab_review.tabpage_browse.dw_browse.selectrow(0,false)
	tab_review.tabpage_browse.dw_browse.selectrow(r,true)
	//\maha
	of_retrieve_detail( il_address_review_id )
else
	of_lock_for_edit()
END IF
ib_new_record = False

Return 1
end event

event itemchanged;call super::itemchanged;long		ll_Rtn

if This.GetColumnName() = "lock_for_edit" then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.29.2006 By: LiuHongXin
	//$<reason> Fix Web Bug: Protect of Column lock_for_edit.
	if this.GetItemNumber(Row, "lock_for_edit") = 1 then 
		if this.GetItemStatus(Row, "lock_for_edit", Primary!) = NotModified! then 
			return 2
		end if
	else
		ll_Rtn = MessageBox("Lock Survey","if you lock the survey, you will not be able to edit answers any further.  You will also not be able unlock it.~rAre you sure you want to do this?",question!,yesno!,2)
		if ll_Rtn = 1 then
			of_lock_for_edit()
		else
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Modify> 2008-04-18 By: Scofield
			//$<Reason> Fix a defect.
	
			//this.setitem(this.getrow(),"lock_for_edit",0)
			Return 2
			//---------------------------- APPEON end ----------------------------
		end if
	end if
	//---------------------------- APPEON end ----------------------------
end if

end event

type tabpage_questions from userobject within tab_review
integer x = 18
integer y = 100
integer width = 4375
integer height = 2132
long backcolor = 16777215
string text = "Survey Questions"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_1 cb_1
cb_enlarge cb_enlarge
rb_summary rb_summary
rb_answers rb_answers
dw_survey_questions dw_survey_questions
dw_answers dw_answers
dw_questions dw_questions
end type

on tabpage_questions.create
this.cb_1=create cb_1
this.cb_enlarge=create cb_enlarge
this.rb_summary=create rb_summary
this.rb_answers=create rb_answers
this.dw_survey_questions=create dw_survey_questions
this.dw_answers=create dw_answers
this.dw_questions=create dw_questions
this.Control[]={this.cb_1,&
this.cb_enlarge,&
this.rb_summary,&
this.rb_answers,&
this.dw_survey_questions,&
this.dw_answers,&
this.dw_questions}
end on

on tabpage_questions.destroy
destroy(this.cb_1)
destroy(this.cb_enlarge)
destroy(this.rb_summary)
destroy(this.rb_answers)
destroy(this.dw_survey_questions)
destroy(this.dw_answers)
destroy(this.dw_questions)
end on

type cb_1 from commandbutton within tabpage_questions
boolean visible = false
integer x = 1970
integer y = -16
integer width = 343
integer height = 92
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;messagebox(string(dw_questions.object.group_total_point_2[1]),string(dw_questions.object.compute_3))

//dw_questions.object.compute_3
end event

type cb_enlarge from commandbutton within tabpage_questions
integer x = 1445
integer width = 343
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Enlarge"
end type

event clicked;//Start Code Change ---- 05.22.2006 #468 maha  new button 052206
string ls_parm

if tab_review.tabpage_questions.rb_answers.checked then //answers
	ls_parm = "E*"
else
	if tab_review.tabpage_browse.dw_browse.getrow() <= 0 then Return //Add by Evan 2008-03-18
	if tab_review.tabpage_browse.dw_browse.getitemnumber(tab_review.tabpage_browse.dw_browse.getrow(),"maximum_score") = 1 then
		ls_parm = "I*"
	else
		ls_parm = "A*"
	end if
end if

ls_parm += string(il_address_review_id)
//messagebox(ls_parm,ls_parm)

openwithparm(w_enter_answers,ls_parm )

if message.stringparm = "Cancel" then
	
else
	tab_review.tabpage_questions.dw_questions.Retrieve( il_address_review_id )
end if
end event

type rb_summary from radiobutton within tabpage_questions
integer x = 635
integer width = 763
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "View Score Summary Report"
end type

event clicked;if tab_review.tabpage_browse.dw_browse.getrow() <= 0 then Return //Add by Evan 01/11/2008

if tab_review.tabpage_browse.dw_browse.getitemnumber(tab_review.tabpage_browse.dw_browse.getrow(),"maximum_score") = 1 then
	tab_review.tabpage_questions.dw_questions.DataObject = "d_pd_survey_score_min"
else
	tab_review.tabpage_questions.dw_questions.DataObject = "d_pd_survey_score_max"
end if
tab_review.tabpage_questions.dw_questions.of_SetTransObject( SQLCA )
tab_review.tabpage_questions.dw_questions.Retrieve( il_address_review_id )
of_lock_for_edit()//Start Code Change ---- 05.23.2006 #483 maha
end event

type rb_answers from radiobutton within tabpage_questions
integer x = 14
integer width = 590
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Input Survey Answers "
boolean checked = true
end type

event clicked;tab_review.tabpage_questions.dw_questions.DataObject = "d_pd_survey_preview"
tab_review.tabpage_questions.dw_questions.of_SetTransObject( SQLCA )
tab_review.tabpage_questions.dw_questions.Retrieve( il_address_review_id )
of_lock_for_edit()//Start Code Change ---- 05.23.2006 #484 maha
end event

type dw_survey_questions from u_dw within tabpage_questions
boolean visible = false
integer x = 32
integer y = 1008
integer width = 2619
integer height = 312
integer taborder = 11
string dataobject = "d_pd_question_answer_ids"
boolean livescroll = false
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateable( False )
end event

type dw_answers from u_dw within tabpage_questions
boolean visible = false
integer x = 37
integer y = 1364
integer width = 2619
integer height = 152
integer taborder = 11
string dataobject = "d_pd_site_survey_answers"
boolean livescroll = false
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type dw_questions from u_dw within tabpage_questions
integer y = 76
integer width = 4361
integer height = 2056
integer taborder = 30
string dataobject = "d_pd_survey_preview"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;This.of_SetTransObject( SQLCA )




end event

event buttonclicked;String ls_ans

ls_ans = This.GetItemString( row, "answers_notes" )

OpenWithParm( w_get_additional_notes, ls_ans )

IF Message.StringParm = "Cancel" THEN
	Return
ELSE
	//messagebox("", message.Stringparm )
	This.SetItem( row, "answers_notes", Trim( Message.StringParm ) )
END IF


end event

event pfc_preupdate;call super::pfc_preupdate;//code to prevent update if the locked button is checked



return 1
end event

event retrieveend;call super::retrieveend;this.modify("Datawindow.zoom=" + string(gi_zoom))  //Start Code Change ----08.01.2017 #V154 maha
end event

