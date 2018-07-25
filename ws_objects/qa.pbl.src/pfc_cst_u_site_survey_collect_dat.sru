$PBExportHeader$pfc_cst_u_site_survey_collect_dat.sru
$PBExportComments$inhereted from pfc_cst_u_site_survey_collect_data
forward
global type pfc_cst_u_site_survey_collect_dat from pfc_cst_u_site_survey_collect_data
end type
type dw_addresses from u_dw within tabpage_browse
end type
type cb_save from commandbutton within pfc_cst_u_site_survey_collect_dat
end type
type cb_delete from commandbutton within pfc_cst_u_site_survey_collect_dat
end type
type cb_add_gp from commandbutton within pfc_cst_u_site_survey_collect_dat
end type
type cb_print from commandbutton within pfc_cst_u_site_survey_collect_dat
end type
type cb_import from commandbutton within pfc_cst_u_site_survey_collect_dat
end type
type cb_export from commandbutton within pfc_cst_u_site_survey_collect_dat
end type
type dw_imp_surv from datawindow within pfc_cst_u_site_survey_collect_dat
end type
end forward

global type pfc_cst_u_site_survey_collect_dat from pfc_cst_u_site_survey_collect_data
integer width = 3803
integer height = 2024
cb_save cb_save
cb_delete cb_delete
cb_add_gp cb_add_gp
cb_print cb_print
cb_import cb_import
cb_export cb_export
dw_imp_surv dw_imp_surv
end type
global pfc_cst_u_site_survey_collect_dat pfc_cst_u_site_survey_collect_dat

type variables
protected:

long il_prac_id
long il_adddress_id
long il_zoom
end variables

forward prototypes
public subroutine of_set_prac_id (long al_prac_id)
public function integer of_set_zoom (integer al_zoom)
end prototypes

public subroutine of_set_prac_id (long al_prac_id);



il_prac_id = al_prac_id
end subroutine

public function integer of_set_zoom (integer al_zoom);

il_zoom = al_zoom

return 1
end function

on pfc_cst_u_site_survey_collect_dat.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add_gp=create cb_add_gp
this.cb_print=create cb_print
this.cb_import=create cb_import
this.cb_export=create cb_export
this.dw_imp_surv=create dw_imp_surv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_add_gp
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.cb_import
this.Control[iCurrent+6]=this.cb_export
this.Control[iCurrent+7]=this.dw_imp_surv
end on

on pfc_cst_u_site_survey_collect_dat.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add_gp)
destroy(this.cb_print)
destroy(this.cb_import)
destroy(this.cb_export)
destroy(this.dw_imp_surv)
end on

type tab_review from pfc_cst_u_site_survey_collect_data`tab_review within pfc_cst_u_site_survey_collect_dat
integer y = 4
integer width = 3790
integer height = 2012
integer selectedtab = 1
end type

event tab_review::selectionchanged;call super::selectionchanged;//Added by  Nova 02.25.2010
IF oldindex = 1 THEN
	if tab_review.tabpage_browse.dw_browse.rowcount( )>0 then
		of_retrieve_detail(tab_review.tabpage_browse.dw_browse.GetItemNumber(tab_review.tabpage_browse.dw_browse.GetRow(), "rec_id") )
	end if
END IF

end event

type tabpage_browse from pfc_cst_u_site_survey_collect_data`tabpage_browse within tab_review
integer width = 3753
integer height = 1896
dw_addresses dw_addresses
end type

on tabpage_browse.create
this.dw_addresses=create dw_addresses
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_addresses
end on

on tabpage_browse.destroy
call super::destroy
destroy(this.dw_addresses)
end on

type dw_browse from pfc_cst_u_site_survey_collect_data`dw_browse within tabpage_browse
integer y = 664
integer width = 3744
integer height = 1232
string dataobject = "d_survey_basic_info_bwse"
end type

event dw_browse::pfc_retrieve;call super::pfc_retrieve;


return this.retrieve(il_adddress_id )
end event

event dw_browse::resize;call super::resize;// Added by  Nova 02.25.2010
//this.object.datawindow.zoom =il_zoom 

//---------Begin Added by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
If gb_contract_module Then
	If gb_autozoom then this.object.datawindow.zoom =il_zoom  //added by gavins 20130107
End If
//---------End Added ------------------------------------------------------
end event

type tabpage_setup from pfc_cst_u_site_survey_collect_data`tabpage_setup within tab_review
integer width = 3753
integer height = 1896
end type

type dw_setup from pfc_cst_u_site_survey_collect_data`dw_setup within tabpage_setup
integer y = 0
integer width = 3753
integer height = 1896
boolean ib_isupdateable = false
end type

event dw_setup::resize;call super::resize;//Added by  Nova 02.25.2010
//this.object.datawindow.zoom =il_zoom 

//---------Begin Added by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
if gb_contract_module then
	If gb_autozoom then this.object.datawindow.zoom =il_zoom  //added by gavins 20130107
end if
//---------End Added ------------------------------------------------------
end event

event dw_setup::constructor;call super::constructor;//For resize  Added by  Nova 02.25.2010
this.of_setresize(true)
this.inv_resize.of_setorigsize( this.width,this.height)
this.inv_resize.of_setminsize( this.width,this.height)
this.inv_resize.of_register(this.inv_resize.scale)
this.inv_resize.of_SetDetailHeight(true)
end event

type tabpage_questions from pfc_cst_u_site_survey_collect_data`tabpage_questions within tab_review
integer width = 3753
integer height = 1896
end type

type cb_1 from pfc_cst_u_site_survey_collect_data`cb_1 within tabpage_questions
integer y = 4
integer height = 76
end type

type cb_enlarge from pfc_cst_u_site_survey_collect_data`cb_enlarge within tabpage_questions
boolean visible = false
integer y = 4
end type

type rb_summary from pfc_cst_u_site_survey_collect_data`rb_summary within tabpage_questions
end type

type rb_answers from pfc_cst_u_site_survey_collect_data`rb_answers within tabpage_questions
end type

type dw_survey_questions from pfc_cst_u_site_survey_collect_data`dw_survey_questions within tabpage_questions
end type

type dw_answers from pfc_cst_u_site_survey_collect_data`dw_answers within tabpage_questions
end type

type dw_questions from pfc_cst_u_site_survey_collect_data`dw_questions within tabpage_questions
integer y = 88
integer width = 3771
integer height = 1808
boolean ib_isupdateable = false
end type

type dw_addresses from u_dw within tabpage_browse
integer width = 3744
integer height = 656
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_prac_addresses_display"
end type

event pfc_retrieve;call super::pfc_retrieve;

this.retrieve(il_prac_id)
return 1
end event

event rowfocuschanged;call super::rowfocuschanged;


if this.rowcount( ) > 0 then
 il_adddress_id = 	this.object.gp_id[currentrow]
 il_gp_id=il_adddress_id//Added by  Nova 02.26.2010
 parent.dw_browse.event pfc_retrieve( )
end if
end event

event constructor;call super::constructor;


setnull(il_adddress_id )
THIS.of_SetRowSelect(TRUE)
THIS.inv_rowselect.of_SetStyle(THIS.inv_rowselect.single )
end event

event resize;call super::resize;
//Added by  Nova 02.25.2010
//this.object.datawindow.zoom =il_zoom 

//---------Begin Added by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
if gb_contract_module then
	If gb_autozoom then this.object.datawindow.zoom =il_zoom  //added by gavins 20130107
end if
//---------End Added ------------------------------------------------------
end event

type cb_save from commandbutton within pfc_cst_u_site_survey_collect_dat
integer x = 3163
integer y = 4
integer width = 233
integer height = 84
integer taborder = 22
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//Added by  Nova 02.26.2010
IF IsValid(w_qa_peer_profile_screen) THEN w_qa_peer_profile_screen.Event pfc_save()

end event

type cb_delete from commandbutton within pfc_cst_u_site_survey_collect_dat
integer x = 2930
integer y = 4
integer width = 233
integer height = 84
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//Added by  Nova 02.26.2010
of_delete_survey()


end event

type cb_add_gp from commandbutton within pfc_cst_u_site_survey_collect_dat
integer x = 2697
integer y = 4
integer width = 233
integer height = 84
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//Added by  Nova 02.26.2010
of_new_record ( il_adddress_id )


end event

type cb_print from commandbutton within pfc_cst_u_site_survey_collect_dat
integer x = 2464
integer y = 4
integer width = 233
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;//??//Added by  Nova 02.26.2010
IF tab_review.tabpage_questions.dw_questions.RowCount( ) = 0 THEN RETURN
//tab_review.tabpage_questions.dw_questions.Print()
Parent.Event pfc_cst_print_survey( )



end event

type cb_import from commandbutton within pfc_cst_u_site_survey_collect_dat
integer x = 2043
integer y = 4
integer width = 379
integer height = 84
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Import Survey"
end type

event clicked;string ls_docid
string ls_surv
integer res
long ll_export
long ll_pd_rev
long s_cnt
long r
integer i

r = tab_review.tabpage_setup.dw_setup.getrow()

if r < 1 then //trap
	messagebox("No Survey","No survey to import.")
	return
end if

ll_pd_rev = tab_review.tabpage_setup.dw_setup.getitemnumber(1,"rec_id")

select export_id into :ll_export from pd_review_export where pd_review_id = :ll_pd_rev;

if ll_export < 1 or isnull(ll_export) then  //check to see if was exported
	messagebox("Export not Found","This survey was not previously exported.  Unable to import")
	return
else
	select doc_id into :ls_docid from pd_review_export where pd_review_id = :ll_pd_rev;
	if isnull(ls_docid) or ls_docid = "" then
		messagebox("Import Error","Unable to get the document id for this record.  Unable to import.")
		return
	end if
end if

//ls_docid = tab_1.tabpage_gp.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.getitemstring(1,"doc_id")
ls_surv = gs_dir_path + "intellicred\intellisite\imports\" + ls_docid + "_surveyback.txt"

//messagebox("ls_surv",ls_surv)

if not fileexists(ls_surv) then 
	messagebox("No Survey File","Cannot find Survey file " + ls_surv)
	return
end if
//
dw_imp_surv.settransobject(sqlca)
dw_imp_surv.reset()
//
s_cnt = dw_imp_surv.importfile(ls_surv)
if s_cnt < 1 then
	messagebox("Import error","Unable to import survey data")
	return
end if

for i = 1 to s_cnt //set the imported data so that it can be updated
	dw_imp_surv.SetItemStatus ( i, 0, primary!,datamodified! )
	dw_imp_surv.SetItemStatus ( i, "answer_on_off", primary!,datamodified! )
	dw_imp_surv.SetItemStatus ( i, "score", primary!,datamodified! )
	dw_imp_surv.SetItemStatus ( i, "notes", primary!,datamodified! )
	
next

res = dw_imp_surv.update()

//messagebox("",res)

if res < 1 then
	messagebox("Import Error","Unable to update Survey data.")
else
	of_retrieve_detail(ll_pd_rev)
	messagebox("Survey Import","Import Complete")
end if



end event

type cb_export from commandbutton within pfc_cst_u_site_survey_collect_dat
integer x = 1659
integer y = 4
integer width = 366
integer height = 84
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export Survey"
end type

event clicked;//function added maha 061004 for intellisite

long ll_pd_rev
long ll_gpid
long ll_export
long ll_review
integer r
integer c
integer res

r = tab_review.tabpage_setup.dw_setup.getrow()

if r < 1 then //trap
	messagebox("No Survey","No survey to export.")
	return
end if

ll_gpid = il_adddress_id
ll_pd_rev = tab_review.tabpage_setup.dw_setup.getitemnumber(r,"rec_id")
ll_review = tab_review.tabpage_setup.dw_setup.getitemnumber(r,"review_id")

select export_id into :ll_export from pd_review_export where pd_review_id = :ll_pd_rev;

if ll_export > 0 then  //check to see if was exported
	res = messagebox("Survey Found","This survey was previously exported.  Do you want to export again?", question!,yesno!,2)
	if res = 2 then return
else
	select max(export_id) into :ll_export from pd_review_export;
	if isnull(ll_export) then ll_export =  0 
	ll_export++
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-17
	//$<add> 02.09.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------

	insert into pd_review_export (export_id,review_id, pd_review_id,gp_id) values (:ll_export, :ll_review, :ll_pd_rev, :ll_gpid);
	commit using sqlca;

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-18
	//$<add> 02.09.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------
end if


openwithparm(w_survey_export,ll_export)
end event

type dw_imp_surv from datawindow within pfc_cst_u_site_survey_collect_dat
boolean visible = false
integer x = 1403
integer y = 32
integer width = 165
integer height = 52
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_pd_survey_import"
boolean resizable = true
boolean livescroll = true
end type

