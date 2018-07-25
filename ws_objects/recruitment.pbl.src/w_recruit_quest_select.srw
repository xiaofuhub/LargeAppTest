$PBExportHeader$w_recruit_quest_select.srw
forward
global type w_recruit_quest_select from w_popup
end type
type cb_1 from commandbutton within w_recruit_quest_select
end type
type p_1 from picture within w_recruit_quest_select
end type
type cb_save from commandbutton within w_recruit_quest_select
end type
type cb_close from commandbutton within w_recruit_quest_select
end type
type dw_template from u_dw within w_recruit_quest_select
end type
type dw_quest from u_dw within w_recruit_quest_select
end type
end forward

global type w_recruit_quest_select from w_popup
integer x = 214
integer y = 221
integer width = 3163
integer height = 2252
string title = "Recruitment Qualification Questions"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
cb_1 cb_1
p_1 p_1
cb_save cb_save
cb_close cb_close
dw_template dw_template
dw_quest dw_quest
end type
global w_recruit_quest_select w_recruit_quest_select

type variables
long il_temp_id
gs_pass_ids ist_ids  //(Appeon)Stephen 05.23.2016 - Recruitment Module Bug Case#63973 Bug_id#5169 Version 15.1 Build 05/05/2016
end variables

on w_recruit_quest_select.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.p_1=create p_1
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_template=create dw_template
this.dw_quest=create dw_quest
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_template
this.Control[iCurrent+6]=this.dw_quest
end on

on w_recruit_quest_select.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_template)
destroy(this.dw_quest)
end on

event open;call super::open;datawindowchild dwchild

dw_template.settransobject(sqlca)
dw_quest.settransobject(sqlca)

dw_template.retrieve()

dw_template.getchild( "facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)
dwchild.setitem(1,"facility_id", 0)
dwchild.setitem(1,"facility_name", 'All')
ist_ids.ls_ref_value = "Cancel"  //(Appeon)Stephen 05.23.2016 - V15.2-Application Tracking full Auditing

if dw_template.rowcount() > 0 then
	il_temp_id = dw_template.getitemnumber(1,"temp_id")
	dw_quest.retrieve(il_temp_id)
end if
end event

event close;call super::close;//---------Begin Modified by (Appeon)Stephen 05.23.2016 for Recruitment Module Bug Case#63973 Bug_id#5169 Version 15.1 Build 05/05/2016--------
//cb_close.event clicked()   // (Appeon)Harry 03.31.2016 for BugH033103
closewithreturn(this, ist_ids)
//---------End Modfiied ------------------------------------------------------
end event

type cb_1 from commandbutton within w_recruit_quest_select
boolean visible = false
integer x = 50
integer y = 864
integer width = 334
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

type p_1 from picture within w_recruit_quest_select
boolean visible = false
integer x = 50
integer y = 36
integer width = 82
integer height = 60
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_recruit_quest_select
integer x = 1216
integer y = 32
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked; //Start Code Change ----03.26.2015 #V15 maha
long r
long rc = 0
long ll_temp = 0
long ll_qid[]
//gs_pass_ids lst_ids //Commented by (Appeon)Stephen 05.23.2016 - Recruitment Module Bug Case#63973 Bug_id#5169 Version 15.1 Build 05/05/2016


for r = 1 to dw_quest.rowcount()
	if dw_quest.getitemnumber(r,"selected") = 1 then
		ll_qid[upperbound(ll_qid) + 1]  = dw_quest.getitemnumber(r,"qt_id") 
		rc++
	end if
next 

if rc = 0 then
	messagebox("Select Error","You have not selected any questions")
	return
else
	ist_ids.l_ids = ll_qid
	ist_ids.ls_ref_value = "Ok"  //(Appeon)Stephen 05.23.2016 - Recruitment Module Bug Case#63973 Bug_id#5169 Version 15.1 Build 05/05/2016
	closewithreturn(parent, ist_ids)
end if



end event

type cb_close from commandbutton within w_recruit_quest_select
integer x = 1577
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;//---------Begin Modified by (Appeon)Stephen 05.23.2016 for Recruitment Module Bug Case#63973 Bug_id#5169 Version 15.1 Build 05/05/2016--------
//closewithreturn(parent, "Cancel")
ist_ids.ls_ref_value = "Cancel"
closewithreturn(parent, ist_ids)
//---------End Modfiied ------------------------------------------------------
end event

type dw_template from u_dw within w_recruit_quest_select
integer y = 148
integer width = 3141
integer height = 704
integer taborder = 60
boolean titlebar = true
string title = "Select Template"
string dataobject = "d_recruit_quest_template_select"
end type

event clicked;call super::clicked;integer r
if row = 0 then return
r = this.getclickedrow()

this.setrow(r)

end event

event rowfocuschanged;call super::rowfocuschanged;integer r


if currentrow = 0 then return

il_temp_id = this.getitemnumber(currentrow, "temp_id")

dw_quest.retrieve(il_temp_id)
end event

event constructor;call super::constructor;this.setrowfocusindicator( p_1)

end event

type dw_quest from u_dw within w_recruit_quest_select
integer y = 856
integer width = 3141
integer height = 1308
integer taborder = 60
boolean titlebar = true
string title = "Select Questions"
string dataobject = "d_recruit_temp_question_select"
end type

event constructor;call super::constructor;this.of_setupdateable( false)
end event

