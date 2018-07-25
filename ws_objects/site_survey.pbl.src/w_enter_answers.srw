$PBExportHeader$w_enter_answers.srw
forward
global type w_enter_answers from window
end type
type cb_quit from commandbutton within w_enter_answers
end type
type cb_ok from commandbutton within w_enter_answers
end type
type dw_1 from datawindow within w_enter_answers
end type
end forward

global type w_enter_answers from window
integer width = 3749
integer height = 2580
boolean titlebar = true
string title = "Enter Survey  Answers"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_quit cb_quit
cb_ok cb_ok
dw_1 dw_1
end type
global w_enter_answers w_enter_answers

on w_enter_answers.create
this.cb_quit=create cb_quit
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={this.cb_quit,&
this.cb_ok,&
this.dw_1}
end on

on w_enter_answers.destroy
destroy(this.cb_quit)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;//Start Code Change ---- 05.22.2006 #467 maha  new window 05.22.06

long ll_recid
string ls_dw
string ls_mes

ls_mes = message.stringparm

ls_dw = MidA(ls_mes,1,1)

ll_recid = long(MidA(ls_mes,3))

if ls_dw = "E" then
	dw_1.dataobject = "d_pd_survey_preview"
elseif ls_dw = "I" then
	dw_1.dataobject = "d_pd_survey_score_min"
else //A
	dw_1.dataobject = "d_pd_survey_score_max"
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_recid)



end event

type cb_quit from commandbutton within w_enter_answers
integer x = 3365
integer y = 28
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;closewithreturn(parent,"Cancel")

end event

type cb_ok from commandbutton within w_enter_answers
integer x = 3013
integer y = 28
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-04-18 By: Scofield
//$<Reason> Only when dw_1's dataobject is d_pd_survey_preview then update.

if dw_1.dataobject = "d_pd_survey_preview" then
	dw_1.update()
end if
//---------------------------- APPEON END ----------------------------

CloseWithReturn(parent,"Ok")

end event

type dw_1 from datawindow within w_enter_answers
integer x = 41
integer y = 152
integer width = 3639
integer height = 2304
integer taborder = 10
string title = "none"
string dataobject = "d_pd_survey_preview"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;//Start Code Change ---- 05.23.2006 #485 maha
String ls_ans

ls_ans = This.GetItemString( row, "answers_notes" )

OpenWithParm( w_get_additional_notes, ls_ans )

IF Message.StringParm = "Cancel" THEN
	Return
ELSE
	//messagebox("", message.Stringparm )
	This.SetItem( row, "answers_notes", Trim( Message.StringParm ) )
END IF
//End Code Change---05.23.2006

end event

