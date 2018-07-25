$PBExportHeader$w_todolist_report.srw
forward
global type w_todolist_report from w_response
end type
type rb_portrait from radiobutton within w_todolist_report
end type
type rb_landscape from radiobutton within w_todolist_report
end type
type cb_5 from uo_cb_output within w_todolist_report
end type
type cb_2 from u_cb within w_todolist_report
end type
type dw_1 from u_dw within w_todolist_report
end type
type gb_1 from groupbox within w_todolist_report
end type
end forward

global type w_todolist_report from w_response
integer width = 3410
integer height = 1976
string title = "To-Do List Report"
long backcolor = 33551856
rb_portrait rb_portrait
rb_landscape rb_landscape
cb_5 cb_5
cb_2 cb_2
dw_1 dw_1
gb_1 gb_1
end type
global w_todolist_report w_todolist_report

type variables


long il_retive_parm

u_cst_todolist iuo_todolist
end variables

on w_todolist_report.create
int iCurrent
call super::create
this.rb_portrait=create rb_portrait
this.rb_landscape=create rb_landscape
this.cb_5=create cb_5
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_portrait
this.Control[iCurrent+2]=this.rb_landscape
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.gb_1
end on

on w_todolist_report.destroy
call super::destroy
destroy(this.rb_portrait)
destroy(this.rb_landscape)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event pfc_postopen;call super::pfc_postopen;this.dw_1.event pfc_retrieve( )

dw_1.Object.DataWindow.Print.Preview = "yes"		//Added by Scofield on 2008-03-13

end event

event pfc_preopen;call super::pfc_preopen;If isvalid( Message.Powerobjectparm) Then
	iuo_todolist = Message.Powerobjectparm
End If
end event

type rb_portrait from radiobutton within w_todolist_report
integer x = 471
integer y = 1780
integer width = 256
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Portrait"
boolean checked = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-03-13 By: Scofield
//$<Reason> Set portrait print.

if This.Checked then
	dw_1.SetRedraw(false)
	dw_1.ScrollToRow(1)
	dw_1.Object.DataWindow.Print.Orientation = 2
	dw_1.modify("tdl_data.width = 3401")   //Start Code Change ----06.17.2015 #V15 maha
	dw_1.SetRedraw(true)
end if
//---------------------------- APPEON END ----------------------------

end event

type rb_landscape from radiobutton within w_todolist_report
integer x = 78
integer y = 1776
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Landscape"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-03-13 By: Scofield
//$<Reason> Set landscape print.

if This.Checked then
	dw_1.SetRedraw(false)
	dw_1.ScrollToRow(1)
	dw_1.Object.DataWindow.Print.Orientation = 1
	dw_1.modify("tdl_data.width = 4498")   //Start Code Change ----06.17.2015 #V15 maha
	dw_1.SetRedraw(true)
end if
//---------------------------- APPEON END ----------------------------

end event

type cb_5 from uo_cb_output within w_todolist_report
integer x = 2642
integer y = 1744
integer width = 352
integer height = 92
integer taborder = 50
string text = "&Print"
end type

event constructor;call super::constructor;

 idw =  dw_1
end event

event clicked;dw_1.Print( )
end event

type cb_2 from u_cb within w_todolist_report
integer x = 3013
integer y = 1744
integer taborder = 30
string text = "&Close"
end type

event clicked;call super::clicked;
close(parent)
end event

type dw_1 from u_dw within w_todolist_report
event ue_mail_current ( )
integer x = 14
integer y = 12
integer width = 3369
integer height = 1684
integer taborder = 10
boolean titlebar = true
string title = "Report Preview"
string dataobject = "d_tdl_report"
boolean hscrollbar = true
boolean border = false
boolean ib_isupdateable = false
end type

event ue_mail_current();

Super::EVENT ue_save_pdf_for_mailing( )

//releasecapture( )

//Start Code Change ----10.09.2008 #V85 maha -  readded option to use outlook email
if gi_email_type = 1 then
	Super::EVENT ue_mail_bak('QA Profile','' )
else
	Super::EVENT ue_mail('QA Profile','' )
end if
//End Code Change---10.09.2008

end event

event pfc_retrieve;call super::pfc_retrieve;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> To retrieve to do list item.

IF Isvalid(iuo_todolist) THEN
	iuo_todolist.of_Fill_Report(dw_1)
END IF

RETURN 1

//---------------------------- APPEON END ----------------------------

end event

type gb_1 from groupbox within w_todolist_report
integer x = 14
integer y = 1704
integer width = 850
integer height = 172
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Paper Orientation"
end type

