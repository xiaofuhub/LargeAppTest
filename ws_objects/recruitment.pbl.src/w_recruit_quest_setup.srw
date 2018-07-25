$PBExportHeader$w_recruit_quest_setup.srw
forward
global type w_recruit_quest_setup from w_popup
end type
type p_1 from picture within w_recruit_quest_setup
end type
type cb_delq from commandbutton within w_recruit_quest_setup
end type
type cb_addq from commandbutton within w_recruit_quest_setup
end type
type cb_view from commandbutton within w_recruit_quest_setup
end type
type cb_delt from commandbutton within w_recruit_quest_setup
end type
type cb_addt from commandbutton within w_recruit_quest_setup
end type
type cb_save from commandbutton within w_recruit_quest_setup
end type
type cb_close from commandbutton within w_recruit_quest_setup
end type
type dw_template from u_dw within w_recruit_quest_setup
end type
type dw_quest from u_dw within w_recruit_quest_setup
end type
end forward

global type w_recruit_quest_setup from w_popup
integer width = 3200
integer height = 2144
string title = "Recruitment Qualification Questions"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
p_1 p_1
cb_delq cb_delq
cb_addq cb_addq
cb_view cb_view
cb_delt cb_delt
cb_addt cb_addt
cb_save cb_save
cb_close cb_close
dw_template dw_template
dw_quest dw_quest
end type
global w_recruit_quest_setup w_recruit_quest_setup

type variables
long il_temp_id
end variables

on w_recruit_quest_setup.create
int iCurrent
call super::create
this.p_1=create p_1
this.cb_delq=create cb_delq
this.cb_addq=create cb_addq
this.cb_view=create cb_view
this.cb_delt=create cb_delt
this.cb_addt=create cb_addt
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_template=create dw_template
this.dw_quest=create dw_quest
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.cb_delq
this.Control[iCurrent+3]=this.cb_addq
this.Control[iCurrent+4]=this.cb_view
this.Control[iCurrent+5]=this.cb_delt
this.Control[iCurrent+6]=this.cb_addt
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.dw_template
this.Control[iCurrent+10]=this.dw_quest
end on

on w_recruit_quest_setup.destroy
call super::destroy
destroy(this.p_1)
destroy(this.cb_delq)
destroy(this.cb_addq)
destroy(this.cb_view)
destroy(this.cb_delt)
destroy(this.cb_addt)
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

if dw_template.rowcount() > 0 then
	il_temp_id = dw_template.getitemnumber(1,"temp_id")
	dw_quest.retrieve(il_temp_id)
end if
end event

type p_1 from picture within w_recruit_quest_setup
boolean visible = false
integer x = 466
integer y = 40
integer width = 82
integer height = 60
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type cb_delq from commandbutton within w_recruit_quest_setup
integer x = 2766
integer y = 840
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;integer li_res
integer r
integer rc
integer t

li_res = messagebox("Delete template","Are you sure you want to delete this Question?  It will not effect existing candidate Responses.", Question!,Yesno!,2)

if li_res = 2 then return

dw_quest.deleterow(0)

dw_quest.update()

end event

type cb_addq from commandbutton within w_recruit_quest_setup
integer x = 2405
integer y = 840
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;integer nr
integer r
integer f
Integer li_row
long ll_quest[]
gs_variable_array ls_struct
datawindowchild ldwc_1

//---------Begin Added by (Appeon)Stephen 03.04.2016 for ISG TEST--------
li_row = dw_template.getrow()
if li_row < 1 then return
il_temp_id = dw_template.getitemnumber(li_row, "temp_id")
if isnull(il_temp_id) or il_temp_id = 0 then
	messagebox("Prompt", "Please save the Question Template first!")
	return
end if
//---------End Added ------------------------------------------------------

openwithparm (w_question_select, "RECRUIT")

if message.stringparm = "Cancel" then return

ls_struct = message.powerobjectparm

ll_quest = ls_struct.as_number

//---------Begin Added by (Appeon)Stephen 03.09.2016 for ISG TEST--------
dw_quest.getchild("quest_id", ldwc_1)
ldwc_1.settransobject(sqlca)
ldwc_1.retrieve()
//---------End Added ------------------------------------------------------

for r = 1 to upperbound(ll_quest)
	f = dw_quest.find( "quest_id = " + string(ll_quest[r]), 1, dw_quest.rowcount())
	if f = 0 then
		nr = dw_quest.insertrow(0)
		dw_quest.scrolltorow(nr)
		dw_quest.setitem(nr ,"temp_id", il_temp_id)
		dw_quest.setitem(nr ,"quest_id", ll_quest[r])
	end if
next



end event

type cb_view from commandbutton within w_recruit_quest_setup
integer x = 50
integer y = 36
integer width = 439
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Question Setup"
end type

event clicked;openwithparm(w_question_painter, "RECRUIT")
end event

type cb_delt from commandbutton within w_recruit_quest_setup
integer x = 2766
integer y = 160
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;integer li_res
integer r
integer rc
integer t
integer li_row, li_temp_id

//---------Begin Added by (Appeon)Stephen 03.04.2016 for V15.1-Additional TDL type of Recruitment Task--------
li_row = dw_template.getrow()
if li_row > 0 then
	li_temp_id = dw_template.getitemnumber(li_row, "temp_id")
	select count(1) into :li_res from recruit_positions where quest_temp_id = :li_temp_id;
	if li_res > 0 then
		messagebox("Prompt", "The Question Template is used in Recruitment Positions and cannot be deleted!")
		return
	end if
else
	return
end if
//---------End Added ------------------------------------------------------

li_res = messagebox("Delete template","Are you sure you want to delete this Question Template?  It will not effect existing candidate Responses.", Question!,Yesno!,2)

if li_res = 2 then return

rc = dw_quest.rowcount()
t = dw_template.getrow()
for r = 1 to rc
	dw_quest.deleterow(1)
next

dw_template.deleterow(0)

dw_quest.update()
dw_template.update()

if t = 1 and dw_template.rowcount( ) > 0 then
	dw_template.retrieve()
end if

end event

type cb_addt from commandbutton within w_recruit_quest_setup
integer x = 2405
integer y = 160
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;
integer nr

nr = dw_template.insertrow(0)

dw_template.scrolltorow(nr)
dw_template.setitem(nr,"active_status",1)
dw_template.setitem(nr,"facility_id",0)
dw_template.setfocus( )

dw_quest.reset()


end event

type cb_save from commandbutton within w_recruit_quest_setup
integer x = 2405
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;long r
long rc
long ll_temp = 0


rc = dw_template.rowcount()
if rc < 1 then return  //Start Code Change ----01.04.2016 #V15 maha

for r = 1 to rc
	if isnull(dw_template.getitemnumber(r,"temp_id")) then
		if ll_temp = 0 then
			select max(temp_id) into :ll_temp from recruit_quest_template;
			if isnull(ll_temp) then ll_temp = 0
		end if
		ll_temp++
		dw_template.setitem(r,"temp_id", ll_temp)
	end if
next

 ll_temp = 0
 
rc = dw_quest.rowcount()
for r = 1 to rc
	if isnull(dw_quest.getitemnumber(r,"qt_id")) then
		if ll_temp = 0 then
			select max(qt_id) into :ll_temp from recruit_quest_template_quest;
			if isnull(ll_temp) then ll_temp = 0
		end if
		ll_temp++
		dw_quest.setitem(r,"qt_id", ll_temp)
	end if
next 

dw_template.update()
dw_quest.update()

end event

type cb_close from commandbutton within w_recruit_quest_setup
integer x = 2766
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_template from u_dw within w_recruit_quest_setup
integer y = 148
integer width = 3182
integer height = 684
integer taborder = 60
boolean titlebar = true
string title = "Templates"
string dataobject = "d_recruit_quest_template"
borderstyle borderstyle = stylebox!
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

type dw_quest from u_dw within w_recruit_quest_setup
integer y = 836
integer width = 3182
integer height = 1220
integer taborder = 60
boolean titlebar = true
string title = "Questions"
string dataobject = "d_recruit_temp_question"
borderstyle borderstyle = stylebox!
end type

