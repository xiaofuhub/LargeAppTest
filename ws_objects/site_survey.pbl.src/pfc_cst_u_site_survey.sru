$PBExportHeader$pfc_cst_u_site_survey.sru
forward
global type pfc_cst_u_site_survey from userobject
end type
type cb_2 from u_cb within pfc_cst_u_site_survey
end type
type cb_save from u_cb within pfc_cst_u_site_survey
end type
type st_4 from statictext within pfc_cst_u_site_survey
end type
type st_3 from statictext within pfc_cst_u_site_survey
end type
type st_2 from statictext within pfc_cst_u_site_survey
end type
type st_1 from statictext within pfc_cst_u_site_survey
end type
type tab_survey from tab within pfc_cst_u_site_survey
end type
type tabpage_survey from userobject within tab_survey
end type
type dw_survey from u_dw within tabpage_survey
end type
type tabpage_survey from userobject within tab_survey
dw_survey dw_survey
end type
type tabpage_groups from userobject within tab_survey
end type
type cb_insert from u_cb within tabpage_groups
end type
type cb_delete_group from u_cb within tabpage_groups
end type
type cb_add_group from u_cb within tabpage_groups
end type
type dw_grouping from u_dw within tabpage_groups
end type
type tabpage_groups from userobject within tab_survey
cb_insert cb_insert
cb_delete_group cb_delete_group
cb_add_group cb_add_group
dw_grouping dw_grouping
end type
type tabpage_question from userobject within tab_survey
end type
type cb_deleteq from commandbutton within tabpage_question
end type
type cb_insertq from commandbutton within tabpage_question
end type
type cb_addq from commandbutton within tabpage_question
end type
type st_question from statictext within tabpage_question
end type
type cb_insert_ans from u_cb within tabpage_question
end type
type cb_delete_quest_ans from u_cb within tabpage_question
end type
type cb_add_quest_ans from u_cb within tabpage_question
end type
type dw_questions from u_dw within tabpage_question
end type
type dw_answers from u_dw within tabpage_question
end type
type tabpage_question from userobject within tab_survey
cb_deleteq cb_deleteq
cb_insertq cb_insertq
cb_addq cb_addq
st_question st_question
cb_insert_ans cb_insert_ans
cb_delete_quest_ans cb_delete_quest_ans
cb_add_quest_ans cb_add_quest_ans
dw_questions dw_questions
dw_answers dw_answers
end type
type tabpage_preview from userobject within tab_survey
end type
type dw_preview from u_dw within tabpage_preview
end type
type tabpage_preview from userobject within tab_survey
dw_preview dw_preview
end type
type tab_survey from tab within pfc_cst_u_site_survey
tabpage_survey tabpage_survey
tabpage_groups tabpage_groups
tabpage_question tabpage_question
tabpage_preview tabpage_preview
end type
type cb_4 from u_cb within pfc_cst_u_site_survey
end type
type cb_3 from u_cb within pfc_cst_u_site_survey
end type
type cb_new from u_cb within pfc_cst_u_site_survey
end type
type dw_select_survey from u_dw within pfc_cst_u_site_survey
end type
type gb_1 from groupbox within pfc_cst_u_site_survey
end type
type gb_select from groupbox within pfc_cst_u_site_survey
end type
end forward

global type pfc_cst_u_site_survey from userobject
integer width = 3653
integer height = 2556
boolean border = true
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_2 cb_2
cb_save cb_save
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
tab_survey tab_survey
cb_4 cb_4
cb_3 cb_3
cb_new cb_new
dw_select_survey dw_select_survey
gb_1 gb_1
gb_select gb_select
end type
global pfc_cst_u_site_survey pfc_cst_u_site_survey

type variables
w_response iw_parent_window

Integer ii_review_id

u_dw idw_current

Long il_vert_scroll_pos = 0

Boolean ib_new = False

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.23.2006 By: Liang QingShi
//$<modification> Define variables to be used in subsequent script.
long il_review_id,il_question_id
Boolean ib_delete = false
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_retrieve_detail (integer ai_review_id)
public function integer of_save ()
public function integer of_set_parent_window (w_response aw_parent_win)
public function integer of_max_score_old ()
public function integer of_calc_total ()
public function integer of_error ()
end prototypes

public function integer of_retrieve_detail (integer ai_review_id);if not f_validstr(string(ai_review_id)) then return 0
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 02.06.2006 By: owen chen
//$<reason> performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
tab_survey.tabpage_survey.dw_survey.Retrieve( ai_review_id )
tab_survey.tabpage_groups.dw_grouping.Retrieve( ai_review_id )
*/
gnv_appeondb.of_startqueue( )

tab_survey.tabpage_survey.dw_survey.Retrieve( ai_review_id )
tab_survey.tabpage_groups.dw_grouping.Retrieve( ai_review_id )

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Stephen 11.28.2013 for BugS112001--------
tab_survey.tabpage_question.dw_questions.reset()
tab_survey.tabpage_question.dw_answers.reset()
//---------End Added ------------------------------------------------------

tab_survey.tabpage_question.dw_questions.Retrieve( ai_review_id )
tab_survey.tabpage_survey.dw_survey.SetFocus()

RETURN 1
end function

public function integer of_save ();IF tab_survey.tabpage_survey.dw_survey.Update( True, False ) = 1 THEN
	IF tab_survey.tabpage_groups.dw_grouping.Update( True, False ) = 1 THEN
		IF tab_survey.tabpage_question.dw_questions.Update( True, False ) = 1 THEN
			IF tab_survey.tabpage_question.dw_answers.Update( True, False ) = 1 THEN
				tab_survey.tabpage_survey.dw_survey.ResetUpdate()
				tab_survey.tabpage_groups.dw_grouping.ResetUpdate()
				tab_survey.tabpage_question.dw_questions.ResetUpdate()
				tab_survey.tabpage_question.dw_answers.ResetUpdate()
				COMMIT USING SQLCA;
				DataWindowChild dwchild
				dw_select_survey.Reset()
				dw_select_survey.of_SetTransObject( SQLCA )
				dw_select_survey.InsertRow( 0 )
				dw_select_survey.GetChild( "review_id", dwchild )
				dwchild.SetTransObject( SQLCA )
				dwchild.Retrieve()
				if ii_review_id<>0 then
					dw_select_survey.SetItem( 1, "review_id", ii_review_id )	
				end if
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> UM-01
				//$<modify> 01.13.2006 By: Wang Chao
				//$<reason> The GOTO statement is currently unsupported.
				//$<modification> Encapsualte the script associated with the label into of_error,
				//$<modification> and call of_error to provide the same functionaltiy.
				//GOTO ERROR
				Return of_error()
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSE
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> UM-02
			//$<modify> 01.13.2006 By: Wang Chao
			//$<reason> The GOTO statement is currently unsupported.
			//$<modification> Encapsualte the script associated with the label into of_error,
			//$<modification> and call of_error to provide the same functionaltiy.
			//GOTO ERROR
			Return of_error()
			//---------------------------- APPEON END ----------------------------
		END IF
	ELSE
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> UM-03
		//$<modify> 01.13.2006 By: Wang Chao
		//$<reason> The GOTO statement is currently unsupported.
		//$<modification> Encapsualte the script associated with the label into of_error,
		//$<modification> and call of_error to provide the same functionaltiy.
		//GOTO ERROR
		Return of_error()
		//---------------------------- APPEON END ----------------------------
	END IF
ELSE
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-04
	//$<modify> 01.13.2006 By: Wang Chao
	//$<reason> The GOTO statement is currently unsupported.
	//$<modification> Encapsualte the script associated with the label into of_error,
	//$<modification> and call of_error to provide the same functionaltiy.
	//GOTO ERROR
	Return of_error()
	//---------------------------- APPEON END ----------------------------
END IF

RETURN 1
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-05
//$<modify> 01.13.2006 By: Wang Chao
//$<reason> The GOTO statement is currently unsuported.
//$<modification> Encapsulate the following script into of_error and have the application
//$<modification> call of_error to provide the same functionality. 
//Error:
//ROLLBACK USING SQLCA;
//MessageBox("Update Error", "Error updating survey tables.")
//Return -1
//---------------------------- APPEON END ----------------------------

end function

public function integer of_set_parent_window (w_response aw_parent_win);iw_parent_window = aw_parent_win

RETURN 1
end function

public function integer of_max_score_old ();//this function not called in the program maha 082604

Integer li_max_score
Integer li_ans_rc
Integer li_total_score
Integer a
Integer li_quest_row
String ls_display_type

li_quest_row = tab_survey.tabpage_question.dw_questions.GetRow()
li_max_score = tab_survey.tabpage_question.dw_questions.GetItemNumber( li_quest_row, "question_maximum_points" )
li_ans_rc = tab_survey.tabpage_question.dw_answers.RowCount()
ls_display_type =  tab_survey.tabpage_question.dw_questions.GetItemString( li_quest_row, "display_type" )
FOR a = 1 TO li_ans_rc
	li_total_score = tab_survey.tabpage_question.dw_answers.GetItemNumber( a, "answer_score" )
	IF li_total_score > li_max_score THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> UM-06
		//$<modify> 01.13.2006 By: LeiWei
		//$<reason> It is currently unsupported to dynamically call an overloaded function. 
		//$<modification> Change the function from of_SetDBErrorMsg to of_SetDBErrorMsg_new.
		//iw_parent_window.of_SetDBErrorMsg( "Answer score exceeds maximum allowable score for question, please correct." )
		iw_parent_window.of_SetDBErrorMsg_new( "Answer score exceeds maximum allowable score for question, please correct." )
		//---------------------------- APPEON END ----------------------------
		tab_survey.tabpage_question.dw_answers.SetFocus()
		tab_survey.tabpage_question.dw_answers.SetRow( a )
		tab_survey.tabpage_question.dw_answers.ScrollToRow( a )
		tab_survey.tabpage_question.dw_answers.SetColumn( "answer_score" )
		RETURN -1
	END IF
END FOR

RETURN 1
end function

public function integer of_calc_total ();//maha 090804 called from save button
datawindow dw_grouping
long t 
long tval = 0
long p
long pval = 0
long r
string ls_type


dw_grouping = tab_survey.tabpage_groups.dw_grouping
if dw_grouping.rowcount() < 1 then return 1

for r = 1 to dw_grouping.rowcount()
	ls_type = dw_grouping.getitemstring(r, "group_subgroup") 
	if ls_type = "S"  or ls_type = "B" then  //Subgroup or both
		t = dw_grouping.getitemnumber(r,"group_total_points")
		tval+= t
		p = dw_grouping.getitemnumber(r,"group_passing_score")
		pval+= p
	end if
next

dw_grouping.object.t_total_points.text = string(tval)
dw_grouping.object.t_total_passing.text = string(pval)

tab_survey.tabpage_survey.dw_survey.setitem(1,"total_points",tval)
tab_survey.tabpage_survey.dw_survey.setitem(1,"minimum_passing_score",pval)

return 1
end function

public function integer of_error ();//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_site_surveyof_error()
// $<arguments>(None)
// $<returns> integer
// $<description>Replace the goto error statement
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2006 by Wang Chao
//////////////////////////////////////////////////////////////////////
ROLLBACK USING SQLCA;
MessageBox("Update Error", "Error updating survey tables.")
Return -1
end function

on pfc_cst_u_site_survey.create
this.cb_2=create cb_2
this.cb_save=create cb_save
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.tab_survey=create tab_survey
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_new=create cb_new
this.dw_select_survey=create dw_select_survey
this.gb_1=create gb_1
this.gb_select=create gb_select
this.Control[]={this.cb_2,&
this.cb_save,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.tab_survey,&
this.cb_4,&
this.cb_3,&
this.cb_new,&
this.dw_select_survey,&
this.gb_1,&
this.gb_select}
end on

on pfc_cst_u_site_survey.destroy
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.tab_survey)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_new)
destroy(this.dw_select_survey)
destroy(this.gb_1)
destroy(this.gb_select)
end on

type cb_2 from u_cb within pfc_cst_u_site_survey
integer x = 3131
integer y = 80
integer width = 453
integer taborder = 20
string text = "&Close"
end type

event clicked;Close( iw_parent_window )
end event

type cb_save from u_cb within pfc_cst_u_site_survey
integer x = 571
integer y = 340
integer width = 453
integer taborder = 30
integer weight = 700
fontcharset fontcharset = ansi!
string text = "&Save"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.23.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
of_calc_total() //maha 090804
iw_parent_window.Event pfc_save()
*/
if ib_delete then
	delete from review_question_answer where review_id = :il_review_id and question_id = :il_question_id;
	tab_survey.tabpage_question.dw_questions.update()
	ib_delete = false
else
	of_calc_total() //maha 090804
	iw_parent_window.Event pfc_save()
	
end if
//---------------------------- APPEON END ----------------------------

IF ib_new THEN
	DataWindowChild dwchild
	dw_select_survey.GetChild( "review_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve()
	dw_select_survey.SetItem( 1, "review_id", ii_review_id )
END IF

ib_new = False
end event

type st_4 from statictext within pfc_cst_u_site_survey
boolean visible = false
integer x = 3173
integer y = 60
integer width = 270
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "# Groups"
boolean focusrectangle = false
end type

type st_3 from statictext within pfc_cst_u_site_survey
boolean visible = false
integer x = 3173
integer y = 136
integer width = 320
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "# Questions"
boolean focusrectangle = false
end type

type st_2 from statictext within pfc_cst_u_site_survey
boolean visible = false
integer x = 2446
integer y = 136
integer width = 663
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Current Accumulated Score"
boolean focusrectangle = false
end type

type st_1 from statictext within pfc_cst_u_site_survey
boolean visible = false
integer x = 2446
integer y = 68
integer width = 471
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Maximum Set Score"
boolean focusrectangle = false
end type

type tab_survey from tab within pfc_cst_u_site_survey
integer x = 41
integer y = 232
integer width = 3598
integer height = 2296
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
integer selectedtab = 1
tabpage_survey tabpage_survey
tabpage_groups tabpage_groups
tabpage_question tabpage_question
tabpage_preview tabpage_preview
end type

on tab_survey.create
this.tabpage_survey=create tabpage_survey
this.tabpage_groups=create tabpage_groups
this.tabpage_question=create tabpage_question
this.tabpage_preview=create tabpage_preview
this.Control[]={this.tabpage_survey,&
this.tabpage_groups,&
this.tabpage_question,&
this.tabpage_preview}
end on

on tab_survey.destroy
destroy(this.tabpage_survey)
destroy(this.tabpage_groups)
destroy(this.tabpage_question)
destroy(this.tabpage_preview)
end on

event selectionchanged;IF iw_parent_window.Event pfc_save() < 0 THEN
	Return 1
END IF

IF newindex = 1 THEN
	tab_survey.tabpage_survey.dw_survey.SetFocus()
ELSEIF newindex = 2 THEN
	tab_survey.tabpage_groups.dw_grouping.SetFocus()
ELSEIF newindex = 3 THEN
	if not f_validstr(string(ii_review_id)) then return 0
	tab_survey.tabpage_question.dw_questions.SetFocus()
	DataWindowChild dwchild
	tab_survey.tabpage_question.dw_questions.GetChild( "group_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	if dwchild.Retrieve( ii_review_id ) < 1 then
		dwchild.insertrow( 0)	//04.30.2008 By Jervis
	end if
	tab_survey.tabpage_question.dw_questions.GetChild( "sub_group_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	if dwchild.Retrieve( ii_review_id ) <1 then
			dwchild.insertrow( 0)  //04.30.2008 By Jervis
	end if
	IF tab_survey.tabpage_question.dw_questions.RowCount() > 0 THEN
		tab_survey.tabpage_question.dw_questions.SetColumn( "question" )
		tab_survey.tabpage_question.dw_questions.SetColumn( "group_id" )
	END IF
ELSEIF newindex = 4 THEN
	tab_survey.tabpage_preview.dw_preview.Retrieve( ii_review_id )
END IF

//Start Code Change ----11.06.2012 #V12 maha
if  newindex = 4 THEN
	cb_save.visible = false
else
	cb_save.visible = true
end if
//End Code Change ----11.06.2012
end event

type tabpage_survey from userobject within tab_survey
integer x = 18
integer y = 100
integer width = 3561
integer height = 2180
long backcolor = 33551856
string text = "Survey"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_survey dw_survey
end type

on tabpage_survey.create
this.dw_survey=create dw_survey
this.Control[]={this.dw_survey}
end on

on tabpage_survey.destroy
destroy(this.dw_survey)
end on

type dw_survey from u_dw within tabpage_survey
integer x = 14
integer y = 112
integer width = 3438
integer height = 1988
integer taborder = 50
string dataobject = "d_survey_header"
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetReqColumn(TRUE)

end event

event pfc_addrow;call super::pfc_addrow;//Start Code Change ---- 05.19.2006 #472 maha
this.setitem(this.rowcount(),"maximum_score",1)

return 1
//End Code Change---05.19.2006


end event

type tabpage_groups from userobject within tab_survey
integer x = 18
integer y = 100
integer width = 3561
integer height = 2180
long backcolor = 33551856
string text = "Grouping"
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_insert cb_insert
cb_delete_group cb_delete_group
cb_add_group cb_add_group
dw_grouping dw_grouping
end type

on tabpage_groups.create
this.cb_insert=create cb_insert
this.cb_delete_group=create cb_delete_group
this.cb_add_group=create cb_add_group
this.dw_grouping=create dw_grouping
this.Control[]={this.cb_insert,&
this.cb_delete_group,&
this.cb_add_group,&
this.dw_grouping}
end on

on tabpage_groups.destroy
destroy(this.cb_insert)
destroy(this.cb_delete_group)
destroy(this.cb_add_group)
destroy(this.dw_grouping)
end on

type cb_insert from u_cb within tabpage_groups
integer x = 1445
integer y = 8
integer width = 453
integer taborder = 11
string text = "&Insert"
end type

event clicked;Integer li_nr
Integer li_cr

li_cr = dw_grouping.GetRow()

li_nr = dw_grouping.InsertRow( li_cr )
dw_grouping.SetRow( li_cr )
dw_grouping.ScrollToRow( li_cr )
dw_grouping.SetFocus()
end event

type cb_delete_group from u_cb within tabpage_groups
integer x = 1906
integer y = 8
integer width = 453
integer taborder = 11
string text = "&Delete"
end type

event clicked;Integer li_ans

IF dw_grouping.RowCount() = 0 THEN
	Beep(2)
	RETURN -1
END IF

li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected row?", Question!, YesNo!, 1 )

IF li_ans = 1 THEN
	dw_grouping.DeleteRow( 0 )
END IF

dw_grouping.SetFocus( )
end event

type cb_add_group from u_cb within tabpage_groups
integer x = 978
integer y = 8
integer width = 453
integer taborder = 11
string text = "&Add"
end type

event clicked;Integer li_nr

li_nr = dw_grouping.InsertRow( 0 )
dw_grouping.SetRow( li_nr )
dw_grouping.ScrollToRow( li_nr )
dw_grouping.SetFocus()
end event

type dw_grouping from u_dw within tabpage_groups
integer x = 14
integer y = 108
integer width = 3438
integer height = 1984
integer taborder = 80
string dataobject = "d_survey_groups"
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetReqColumn(TRUE)

end event

event pfc_preupdate;call super::pfc_preupdate;Integer i
Integer l
Integer li_rc
Integer li_temp_id
Integer li_group_id

li_rc = This.RowCount()

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		This.SetItem( i, "review_id", ii_review_id )
		li_temp_id = 0
		FOR l = 1 TO li_rc
			IF This.GetItemNumber( l, "group_id" ) > li_temp_id THEN
				li_temp_id = This.GetItemNumber( l, "group_id" )
			END IF
		END FOR
		IF IsNull( li_temp_id ) THEN
			li_group_id = 1
		ELSE
			li_group_id = li_temp_id + 1
		END IF
		This.SetItem( i, "group_id", li_group_id )
	END IF
	if isnull ( This.getItemnumber( i, "group_order")) then //Start Code Change ----11.07.2012 #V12 maha - added to set only if blank
		This.SetItem( i, "group_order", i )
	end if
END FOR

RETURN SUCCESS
end event

event itemchanged;call super::itemchanged;of_calc_total( )
end event

type tabpage_question from userobject within tab_survey
integer x = 18
integer y = 100
integer width = 3561
integer height = 2180
long backcolor = 33551856
string text = "Questions"
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_deleteq cb_deleteq
cb_insertq cb_insertq
cb_addq cb_addq
st_question st_question
cb_insert_ans cb_insert_ans
cb_delete_quest_ans cb_delete_quest_ans
cb_add_quest_ans cb_add_quest_ans
dw_questions dw_questions
dw_answers dw_answers
end type

on tabpage_question.create
this.cb_deleteq=create cb_deleteq
this.cb_insertq=create cb_insertq
this.cb_addq=create cb_addq
this.st_question=create st_question
this.cb_insert_ans=create cb_insert_ans
this.cb_delete_quest_ans=create cb_delete_quest_ans
this.cb_add_quest_ans=create cb_add_quest_ans
this.dw_questions=create dw_questions
this.dw_answers=create dw_answers
this.Control[]={this.cb_deleteq,&
this.cb_insertq,&
this.cb_addq,&
this.st_question,&
this.cb_insert_ans,&
this.cb_delete_quest_ans,&
this.cb_add_quest_ans,&
this.dw_questions,&
this.dw_answers}
end on

on tabpage_question.destroy
destroy(this.cb_deleteq)
destroy(this.cb_insertq)
destroy(this.cb_addq)
destroy(this.st_question)
destroy(this.cb_insert_ans)
destroy(this.cb_delete_quest_ans)
destroy(this.cb_add_quest_ans)
destroy(this.dw_questions)
destroy(this.dw_answers)
end on

type cb_deleteq from commandbutton within tabpage_question
integer x = 1906
integer y = 8
integer width = 453
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;//Start Code Change ----11.06.2012 #V12 maha - separate buttons added for questions
Integer li_ans
long ll_row, ll_loop, ll_rowcount

IF idw_current.RowCount() = 0 THEN
	Beep(2)
	RETURN -1
END IF

li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected Question?", Question!, YesNo!, 1 )

IF li_ans = 1 THEN

	ll_row = dw_questions.getrow()
	if ll_row <= 0 then return -1
	il_review_id = dw_questions.GetItemNumber( ll_row, "review_id" )
	il_question_id = dw_questions.GetItemNumber( ll_row, "question_id" )
	
	ll_rowcount = dw_answers.rowcount()
	for ll_loop = 1 to ll_rowcount
		dw_answers.deleterow(0)
	next
		idw_current.DeleteRow( 0 )
	ib_delete = true
	
	If ll_row = 1 Then //Rodger Wu add.
		If dw_questions.rowcount() > 0 Then
			dw_questions.Trigger Event RowFocusChanged( 1 );
		Else
			dw_answers.Reset()
		End If
	End If


END IF

dw_questions.SetFocus( )
end event

type cb_insertq from commandbutton within tabpage_question
integer x = 1440
integer y = 8
integer width = 453
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Insert"
end type

event clicked;//Start Code Change ----11.06.2012 #V12 maha - separate buttons added for questions
Integer li_cr
datawindow ldw_current

ldw_current = dw_questions

li_cr = ldw_current.GetRow()
ldw_current.InsertRow( li_cr )
ldw_current.SetRow( li_cr )
ldw_current.ScrollToRow( li_cr )
ldw_current.SetFocus()

ldw_current.SetColumn("group_id")

end event

type cb_addq from commandbutton within tabpage_question
integer x = 978
integer y = 8
integer width = 453
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;//Start Code Change ----11.06.2012 #V12 maha - separate buttons added for questions
Integer li_nr

li_nr = dw_questions.InsertRow( 0 )
dw_questions.SetRow( li_nr )
dw_questions.ScrollToRow( li_nr )
dw_questions.SetFocus()
dw_questions.SetColumn("group_id")


end event

type st_question from statictext within tabpage_question
integer x = 14
integer y = 1660
integer width = 2811
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_insert_ans from u_cb within tabpage_question
integer x = 2848
integer y = 1836
integer width = 453
integer taborder = 21
string text = "&Insert"
end type

event clicked;Integer li_cr
datawindow ldw_current

ldw_current = dw_answers

li_cr = ldw_current.GetRow()
ldw_current.InsertRow( li_cr )
ldw_current.SetRow( li_cr )
ldw_current.ScrollToRow( li_cr )
ldw_current.SetFocus()

ldw_current.SetColumn("question_answer")


end event

type cb_delete_quest_ans from u_cb within tabpage_question
integer x = 2848
integer y = 1932
integer width = 453
integer taborder = 11
string text = "&Delete"
end type

event clicked;Integer li_ans

IF idw_current.RowCount() = 0 THEN
	Beep(2)
	RETURN -1
END IF

li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected row?", Question!, YesNo!, 1 )
//Start Code Change ----11.06.2012 #V12 maha - separate buttons added for questions
IF li_ans = 1 THEN
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 03.23.2006 By: Liang QingShi
//	//$<reason> Fix a defect for avoid foreign key restraint.
//	/*
//	idw_current.DeleteRow( 0 )
//	*/
//	if idw_current.classname() = 'dw_questions' then
//		long ll_row, ll_loop, ll_rowcount
//		ll_row = dw_questions.getrow()
//		if ll_row <= 0 then return -1
//		il_review_id = dw_questions.GetItemNumber( ll_row, "review_id" )
//		il_question_id = dw_questions.GetItemNumber( ll_row, "question_id" )
//		
//		ll_rowcount = dw_answers.rowcount()
//		for ll_loop = 1 to ll_rowcount
//			dw_answers.deleterow(0)
//		next
//
//		idw_current.DeleteRow( 0 )
//		ib_delete = true
//		
//		If ll_row = 1 Then //Rodger Wu add.
//			If dw_questions.rowcount() > 0 Then
//				dw_questions.Trigger Event RowFocusChanged( 1 );
//			Else
//				dw_answers.Reset()
//			End If
//		End If
//	else
		dw_answers.DeleteRow( 0 )		
//	end if
	//---------------------------- APPEON END ----------------------------
END IF

dw_answers.SetFocus( )
end event

type cb_add_quest_ans from u_cb within tabpage_question
integer x = 2848
integer y = 1740
integer width = 453
integer taborder = 11
string text = "&Add"
end type

event clicked;Integer li_nr

li_nr = dw_answers.InsertRow( 0 )
dw_answers.SetRow( li_nr )
dw_answers.ScrollToRow( li_nr )
dw_answers.SetFocus()
dw_answers.SetColumn("question_answer")



end event

type dw_questions from u_dw within tabpage_question
integer x = 18
integer y = 148
integer width = 3438
integer height = 1480
integer taborder = 80
string dataobject = "d_survey_questions"
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;This.of_SetTransObject( SQLCA )
This.of_SetReqColumn(TRUE)

end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow > 0 THEN

		dw_answers.Retrieve( This.GetItemNumber( currentrow, "review_id" ), This.GetItemNumber( currentrow, "question_id" ) )
		st_question.Text = dw_questions.GetItemString( currentrow, "question" )

END IF


end event

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetReqColumn( True )
end event

event getfocus;call super::getfocus;idw_current = This
This.BorderStyle = styleLowered!
dw_answers.BorderStyle = styleBox!
end event

event pfc_preupdate;call super::pfc_preupdate;Integer i
Integer a
Integer li_ans_rc
Integer li_total_score
Integer l
Integer li_rc
Integer li_temp_id
Integer li_question_id
Integer li_max_score

li_rc = This.RowCount()

This.AcceptText()

FOR i = 1 TO li_rc
	if isnull(this.getitemnumber(i,"group_id")) or isnull(this.getitemnumber(i,"sub_group_id")) then
		messagebox("Incomplete data","The group and subgroup must be selected for each question.")
		return - 1
	end if
next

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		This.SetItem( i, "review_id", ii_review_id )
		li_temp_id = 0
		FOR l = 1 TO li_rc
			IF This.GetItemNumber( l, "question_id" ) > li_temp_id THEN
				li_temp_id = This.GetItemNumber( l, "question_id" )
			END IF
		END FOR
		IF IsNull( li_temp_id ) THEN
			li_question_id = 1
		ELSE
			li_question_id = li_temp_id + 1
		END IF
		This.SetItem( i, "question_id", li_question_id )
	END IF
	This.SetItem( i, "question_order", i )
//	IF of_max_score() = -1 THEN
//		RETURN -1
//	END IF
END FOR

RETURN Success
end event

event clicked;call super::clicked;Integer li_row

dw_answers.AcceptText()
IF dw_answers.ModifiedCount()+dw_answers.DeletedCount() > 0 THEN
	cb_save.TriggerEvent(Clicked!)
END IF

li_row = This.GetClickedRow()
IF li_row > 0 THEN
	This.SetRow( li_row )
	This.ScrollToRow( li_row )
	SetColumn( "group_id" )
END IF



end event

type dw_answers from u_dw within tabpage_question
integer x = 14
integer y = 1740
integer width = 2811
integer height = 424
integer taborder = 11
string dataobject = "d_survey_answers"
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetReqColumn(TRUE)

end event

event getfocus;call super::getfocus;idw_current = This
This.BorderStyle = StyleLowered!
dw_questions.BorderStyle = styleBox!
dw_questions.AcceptText()
IF dw_questions.RowCount() > 0  THEN
	st_question.Text = dw_questions.GetItemString( dw_questions.GetRow(), "question" )
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;Integer i
Integer l
Integer li_rc
Integer li_temp_id
Integer li_answer_id
Integer li_question_id
Long ll_question_answer_id

li_rc = This.RowCount()

This.AcceptText()

li_question_id = dw_questions.GetItemNumber( dw_questions.GetRow(), "question_id" )

SELECT Max( question_answer_id )  
INTO :ll_question_answer_id  
FROM review_question_answer  ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Error", "Error selecting next question_answer_id" )
	Return -1
END IF

IF IsNull( ll_question_answer_id ) THEN
	ll_question_answer_id = 1
END IF

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		This.SetItem( i, "review_id", ii_review_id )
		This.SetItem( i, "question_id", li_question_id )
		li_temp_id = 0
		FOR l = 1 TO li_rc
			IF This.GetItemNumber( l, "answer_id" ) > li_temp_id THEN
				li_temp_id = This.GetItemNumber( l, "answer_id" )
			END IF
		END FOR
		IF IsNull( li_temp_id ) THEN
			li_answer_id = 1
		ELSE
			li_answer_id = li_temp_id + 1
		END IF
		This.SetItem( i, "answer_id", li_answer_id )
	END IF
	if isnull(This.getItemnumber( i, "answer_order")) then //maha 060904
		This.SetItem( i, "answer_order", i )
	end if
	//IF of_max_score() = -1 THEN
	//	RETURN -1
	//END IF
	li_answer_id = This.GetItemNumber( i, "answer_id" ) 
	ll_question_answer_id ++
	if isnull(This.getItemnumber( i, "question_answer_id")) then //maha 060904
		This.SetItem( i, "question_answer_id", ll_question_answer_id )
	end if
END FOR

RETURN Success
end event

type tabpage_preview from userobject within tab_survey
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3561
integer height = 2180
long backcolor = 33551856
string text = "Preview"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_preview dw_preview
end type

on tabpage_preview.create
this.dw_preview=create dw_preview
this.Control[]={this.dw_preview}
end on

on tabpage_preview.destroy
destroy(this.dw_preview)
end on

type dw_preview from u_dw within tabpage_preview
integer x = 14
integer y = 8
integer width = 3479
integer height = 2152
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_survey_preview"
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
end event

event itemchanged;call super::itemchanged;This.of_SetTransObject( SQLCA )
This.of_SetReqColumn(TRUE)

end event

event buttonclicked;//removed maha 090804
//String ls_ans
//
//ls_ans = This.GetItemString( row, "answer_notes" )
//
//OpenWithParm( w_get_additional_notes, ls_ans )
//
//IF Message.StringParm = "Cancel" THEN
//	Return
//ELSE
//	This.SetItem( row, "answer_notes", Message.StringParm )
//END IF

messagebox("Notes button", "Notes are intended to be entered for the individual survey not in the painter.")

end event

type cb_4 from u_cb within pfc_cst_u_site_survey
boolean visible = false
integer x = 1984
integer y = 80
integer width = 361
integer taborder = 70
string text = "Copy &Survey"
end type

event clicked;messagebox("Future Development","This function not coded")

//of_enable_select_buttons()
end event

type cb_3 from u_cb within pfc_cst_u_site_survey
integer x = 1600
integer y = 80
integer width = 361
integer taborder = 60
string text = "&Delete Survey"
end type

event clicked;Integer 	li_ans
long		ll_Row,ll_ReView

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-18 By: Scofield
//$<Reason> Remind user to select a survey.

ll_Row = dw_select_survey.GetRow()
ll_ReView = dw_select_survey.GetItemNumber(ll_Row,'Review_id')
if IsNull(ll_ReView) then
	MessageBox(gnv_app.iapp_object.DisplayName,"You haven't select any Survey, Please select one.")
	Return
end if
//---------------------------- APPEON END ----------------------------
//---------Begin Added by (Appeon)Toney 12.05.2013 for V141 ISG-CLX--------
//$Reason:Fix history BugT072901,This survey has already been used in Site Survey module.Not allowed to delete
long ll_count
select count(*) into :ll_count from pd_review_hdr where review_id = :ii_review_id;
IF ll_count > 0 THEN 
	MessageBox("Delete Survey","This survey has already been used in Site Survey module.Not allowed to delete!",StopSign!)
	Return
END IF
//---------End Added ------------------------------------------------------------------


li_ans = MessageBox("Delete Survey", "Are you sure you want to delete the selected survey?", Question!, YesNo!, 2 )		//Modified by Scofield on 2008-04-18: Modify StopSign! to Question!
IF li_ans = 2 THEN
	Return 
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 02.06.2006 By: owen chen
//$<reason> performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
DELETE FROM review_question_answer 
WHERE review_id = :ii_review_id;

DELETE FROM review_question
WHERE review_id = :ii_review_id;

DELETE FROM review_question_groups
WHERE review_id = :ii_review_id;

DELETE FROM review_hdr
WHERE review_id = :ii_review_id;

COMMIT USING SQLCA;

DataWindowChild dwchild

dw_select_survey.GetChild( "review_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
*/
gnv_appeondb.of_startqueue( )

DataWindowChild dwchild

dw_select_survey.GetChild( "review_id", dwchild )
dwchild.SetTransObject( SQLCA )

DELETE FROM review_question_answer 
WHERE review_id = :ii_review_id;

DELETE FROM review_question
WHERE review_id = :ii_review_id;

DELETE FROM review_question_groups
WHERE review_id = :ii_review_id;

DELETE FROM review_hdr
WHERE review_id = :ii_review_id;

COMMIT USING SQLCA;

dwchild.Retrieve()

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

dw_select_survey.SetTransObject( SQLCA )
dw_select_survey.InsertRow( 0 )

IF dwchild.RowCount() > 0 THEN
	dw_select_survey.SetItem( 1, "review_id", dwchild.GetItemNumber( 1, "review_id" ))
	ii_review_id = dwchild.GetItemNumber( 1, "review_id" )
	of_retrieve_detail( ii_review_id )	
END IF


end event

type cb_new from u_cb within pfc_cst_u_site_survey
integer x = 1225
integer y = 80
integer width = 361
integer taborder = 50
boolean bringtotop = true
string text = "&Create Survey"
end type

event clicked;Integer li_review_id
Integer li_nr
String ls_survey_name

IF of_save() = -1 THEN
	Return -1
END IF

tab_survey.SelectTab(1)

SELECT Max( review_id )  
INTO :li_review_id  
FROM review_hdr  ;

ii_review_id = li_review_id + 1
IF IsNull( ii_review_id ) THEN
	ii_review_id = 1
END IF

tab_survey.tabpage_survey.dw_survey.Reset()
li_nr = tab_survey.tabpage_survey.dw_survey.InsertRow( 0 )
tab_survey.tabpage_survey.dw_survey.SetItem( li_nr, "review_id", ii_review_id )
tab_survey.tabpage_survey.dw_survey.SetColumn( "review_description" )
tab_survey.tabpage_survey.dw_survey.SetFocus()

tab_survey.tabpage_groups.dw_grouping.Reset()
tab_survey.tabpage_question.dw_questions.Reset()
tab_survey.tabpage_question.dw_answers.Reset()

ib_new = True


end event

type dw_select_survey from u_dw within pfc_cst_u_site_survey
integer x = 69
integer y = 84
integer width = 1129
integer height = 80
integer taborder = 10
string dataobject = "d_select_survey"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.Retrieve()
This.InsertRow( 0 )

This.of_SetUpdateable( False )
end event

event itemchanged;call super::itemchanged;This.AcceptText()
ii_review_id = Integer(data)
of_retrieve_detail( ii_review_id )
end event

type gb_1 from groupbox within pfc_cst_u_site_survey
boolean visible = false
integer x = 2405
integer y = 16
integer width = 1152
integer height = 196
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Status"
end type

type gb_select from groupbox within pfc_cst_u_site_survey
integer x = 41
integer y = 16
integer width = 1938
integer height = 196
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Survey"
end type

