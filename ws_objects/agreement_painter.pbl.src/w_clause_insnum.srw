$PBExportHeader$w_clause_insnum.srw
forward
global type w_clause_insnum from w_popup
end type
type st_clause from statictext within w_clause_insnum
end type
type rb_clause from radiobutton within w_clause_insnum
end type
type st_r from statictext within w_clause_insnum
end type
type st_n from statictext within w_clause_insnum
end type
type rb_r from radiobutton within w_clause_insnum
end type
type rb_n from radiobutton within w_clause_insnum
end type
type gb_2 from groupbox within w_clause_insnum
end type
type st_schdule from statictext within w_clause_insnum
end type
type st_subsection from statictext within w_clause_insnum
end type
type st_section from statictext within w_clause_insnum
end type
type st_article from statictext within w_clause_insnum
end type
type rb_section from radiobutton within w_clause_insnum
end type
type rb_subsection from radiobutton within w_clause_insnum
end type
type rb_schedule from radiobutton within w_clause_insnum
end type
type rb_article from radiobutton within w_clause_insnum
end type
type cb_cancel from commandbutton within w_clause_insnum
end type
type cb_ok from commandbutton within w_clause_insnum
end type
type gb_1 from groupbox within w_clause_insnum
end type
end forward

global type w_clause_insnum from w_popup
integer width = 1445
integer height = 1032
string title = "Auto Numbering"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
boolean ib_isupdateable = false
event ue_rb_clicked ( boolean ab_disp )
st_clause st_clause
rb_clause rb_clause
st_r st_r
st_n st_n
rb_r rb_r
rb_n rb_n
gb_2 gb_2
st_schdule st_schdule
st_subsection st_subsection
st_section st_section
st_article st_article
rb_section rb_section
rb_subsection rb_subsection
rb_schedule rb_schedule
rb_article rb_article
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
end type
global w_clause_insnum w_clause_insnum

type variables
String is_msg  //action message
String is_parm //Alfee 09.21.2007
Boolean ib_inserted = False //for performance tunning

Window iw_parent
Oleobject iole_word 

n_cst_word_utility inv_word

end variables

forward prototypes
public subroutine of_set_parent (window iw_parent_window)
public subroutine of_set_object (oleobject aole_word)
end prototypes

event ue_rb_clicked(boolean ab_disp);rb_n.Enabled = ab_disp
rb_r.Enabled = ab_disp
st_n.Visible = ab_disp
st_r.Visible = ab_disp

end event

public subroutine of_set_parent (window iw_parent_window);iw_parent = iw_parent_window
end subroutine

public subroutine of_set_object (oleobject aole_word);iole_word = aole_word
end subroutine

on w_clause_insnum.create
int iCurrent
call super::create
this.st_clause=create st_clause
this.rb_clause=create rb_clause
this.st_r=create st_r
this.st_n=create st_n
this.rb_r=create rb_r
this.rb_n=create rb_n
this.gb_2=create gb_2
this.st_schdule=create st_schdule
this.st_subsection=create st_subsection
this.st_section=create st_section
this.st_article=create st_article
this.rb_section=create rb_section
this.rb_subsection=create rb_subsection
this.rb_schedule=create rb_schedule
this.rb_article=create rb_article
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_clause
this.Control[iCurrent+2]=this.rb_clause
this.Control[iCurrent+3]=this.st_r
this.Control[iCurrent+4]=this.st_n
this.Control[iCurrent+5]=this.rb_r
this.Control[iCurrent+6]=this.rb_n
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.st_schdule
this.Control[iCurrent+9]=this.st_subsection
this.Control[iCurrent+10]=this.st_section
this.Control[iCurrent+11]=this.st_article
this.Control[iCurrent+12]=this.rb_section
this.Control[iCurrent+13]=this.rb_subsection
this.Control[iCurrent+14]=this.rb_schedule
this.Control[iCurrent+15]=this.rb_article
this.Control[iCurrent+16]=this.cb_cancel
this.Control[iCurrent+17]=this.cb_ok
this.Control[iCurrent+18]=this.gb_1
end on

on w_clause_insnum.destroy
call super::destroy
destroy(this.st_clause)
destroy(this.rb_clause)
destroy(this.st_r)
destroy(this.st_n)
destroy(this.rb_r)
destroy(this.rb_n)
destroy(this.gb_2)
destroy(this.st_schdule)
destroy(this.st_subsection)
destroy(this.st_section)
destroy(this.st_article)
destroy(this.rb_section)
destroy(this.rb_subsection)
destroy(this.rb_schedule)
destroy(this.rb_article)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

event open;call super::open;inv_word = Create n_cst_word_utility

//---------Begin Added by Alfee 05.25.2007----------------
//String ls_parm -- Replaced with is_parm by Alfee 09.21.2007
u_tabpg_dm_data lnv_data

is_parm = Message.StringParm
CHOOSE CASE Lower(is_parm)
	CASE "clause"
		IF IsValid(w_clause_painter) THEN
			iole_word = w_clause_painter.tab_1.tabpage_clause.ole_1.object.ActiveDocument
		END IF
	CASE "template"
		IF IsValid(w_agreement_template_painter) THEN
			iole_word = w_agreement_template_painter.tab_1.tabpage_2.ole_1.object.ActiveDocument
		END IF
	CASE "document"
		IF IsValid(gw_contract) THEN
			lnv_data = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data
			iole_word = lnv_data.tab_1.tabpage_preview.ole_doc.object.ActiveDocument
		END If
	
END CHOOSE
//---------End Added -----------------------------------------
end event

event close;call super::close;Destroy inv_word
end event

type st_clause from statictext within w_clause_insnum
integer x = 891
integer y = 500
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "<<|...|>>"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type rb_clause from radiobutton within w_clause_insnum
integer x = 64
integer y = 500
integer width = 576
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Clause Reference"
end type

event clicked;parent.event ue_rb_clicked(False)
end event

type st_r from statictext within w_clause_insnum
boolean visible = false
integer x = 891
integer y = 740
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "\r"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_n from statictext within w_clause_insnum
boolean visible = false
integer x = 891
integer y = 648
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "\n"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type rb_r from radiobutton within w_clause_insnum
integer x = 59
integer y = 744
integer width = 681
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
string text = "Resets Sequence Number"
end type

type rb_n from radiobutton within w_clause_insnum
integer x = 64
integer y = 648
integer width = 640
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
string text = "Next Sequence Number"
boolean checked = true
end type

type gb_2 from groupbox within w_clause_insnum
integer x = 14
integer y = 592
integer width = 1403
integer height = 236
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
end type

type st_schdule from statictext within w_clause_insnum
integer x = 891
integer y = 400
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "A, B, C ..."
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_subsection from statictext within w_clause_insnum
integer x = 891
integer y = 292
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "1.1, 1.2 ..."
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_section from statictext within w_clause_insnum
integer x = 891
integer y = 184
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "1.0, 2.0 ..."
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_article from statictext within w_clause_insnum
integer x = 891
integer y = 76
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "I, II, III ..."
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type rb_section from radiobutton within w_clause_insnum
integer x = 64
integer y = 184
integer width = 576
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Section"
end type

event clicked;parent.event ue_rb_clicked(True)
end event

type rb_subsection from radiobutton within w_clause_insnum
integer x = 64
integer y = 292
integer width = 576
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Sub Section Level 1"
end type

event clicked;parent.event ue_rb_clicked(False)
end event

type rb_schedule from radiobutton within w_clause_insnum
integer x = 64
integer y = 400
integer width = 576
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Schedule"
end type

event clicked;parent.event ue_rb_clicked(False)
end event

type rb_article from radiobutton within w_clause_insnum
event ue_rb_clicked ( )
integer x = 64
integer y = 76
integer width = 576
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Article "
boolean checked = true
end type

event clicked;parent.event ue_rb_clicked(False)
end event

type cb_cancel from commandbutton within w_clause_insnum
integer x = 1129
integer y = 856
integer width = 279
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;
//Update document fields while close the window
If ib_inserted Then 
	OpenwithParm(w_appeon_gifofwait,"Updating fields...") 
	//---------Begin Modified by Alfee 09.21.2007 -------------------------------------
	IF Lower(is_parm)= "document" THEN
		Boolean lb_track, lb_showreviewmenu
		u_tabpg_dm_data lnv_data 
		//Disable checking rights on the clause 
		lnv_data = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data
		lnv_data.of_set_checkrights(FALSE)
		//Disable tracking changes on the document
		lb_track = lnv_data.inv_ole_utils_doc.of_istrackon()
		lb_showreviewmenu = lnv_data.inv_ole_utils_doc.of_isshowreviewmenu()
		lnv_data.inv_ole_utils_doc.of_trackchange_ini() //Stop to track changes
	END If
	
	inv_word.of_update_field(iole_word,False)
	
	IF Lower(is_parm)= "document" THEN
		//Restore checking rights on the clause 
		lnv_data.of_set_checkrights(TRUE)
		//Restore the track status
		lnv_data.inv_ole_utils_doc.of_trackchange(lb_track, lb_showreviewmenu) 		
	END If
	//inv_word.of_update_field(iole_word,False)
	//----------End Modified -----------------------------------------------------------
	If IsValid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)	
End If

Close(Parent)
end event

type cb_ok from commandbutton within w_clause_insnum
integer x = 846
integer y = 856
integer width = 279
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Insert"
end type

event clicked;String ls_num, ls_switch

If rb_article.checked Then
	ls_num = "article"
ElseIf rb_section.checked Then
	ls_num = "section"
ElseIf rb_subsection.checked Then
	ls_num = "subsection"
ElseIf rb_schedule.checked Then
	ls_num = "schedule"
ElseIf rb_clause.checked Then
	ls_num = "clause"	
ENd If

IF rb_n.checked Then 
	ls_switch = ' \n'
Else
	ls_switch = ' \r'
End If

ib_inserted = True

If Len(Trim(ls_num)) > 0 and IsValid(inv_word) Then
	//iw_parent.dynamic of_insert_number(ls_num, ls_switch)	
	
	//Unprotect document if needed - Alfee 03.10.2008
	//inv_word.of_unprotect_doc(iole_word) 
	IF inv_word.of_unprotect_doc(iole_word) = -1 THEN RETURN  //Alfee 10.08.2008
	
	inv_word.dynamic of_insert_number(iole_word, ls_num, ls_switch)
End If	

end event

type gb_1 from groupbox within w_clause_insnum
integer x = 14
integer width = 1403
integer height = 588
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
end type

