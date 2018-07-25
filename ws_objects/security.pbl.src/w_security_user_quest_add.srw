$PBExportHeader$w_security_user_quest_add.srw
forward
global type w_security_user_quest_add from window
end type
type cb_prior from commandbutton within w_security_user_quest_add
end type
type cb_next from commandbutton within w_security_user_quest_add
end type
type cb_3 from commandbutton within w_security_user_quest_add
end type
type cb_add from commandbutton within w_security_user_quest_add
end type
type cb_1 from commandbutton within w_security_user_quest_add
end type
type st_num from statictext within w_security_user_quest_add
end type
type st_4 from statictext within w_security_user_quest_add
end type
type st_1 from statictext within w_security_user_quest_add
end type
type dw_1 from datawindow within w_security_user_quest_add
end type
end forward

global type w_security_user_quest_add from window
integer width = 2359
integer height = 824
boolean titlebar = true
string title = "Enter Security Questions"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_prior cb_prior
cb_next cb_next
cb_3 cb_3
cb_add cb_add
cb_1 cb_1
st_num st_num
st_4 st_4
st_1 st_1
dw_1 dw_1
end type
global w_security_user_quest_add w_security_user_quest_add

type variables
integer ii_total
end variables

forward prototypes
public subroutine of_total ()
public function integer of_check_quest ()
end prototypes

public subroutine of_total ();
st_num.text = string(dw_1.rowcount())
end subroutine

public function integer of_check_quest ();integer rc
integer r
string s


rc = dw_1.rowcount()

for r = 1 to rc
	s = dw_1.getitemstring(r,"user_answer")
	if isnull(s) or len(s) = 0 then
		messagebox("Finished","You have not entered an answer for this question.")
		dw_1.scrolltorow(r)
		return -1
	end if
next



if rc < ii_total then
	 //Start Code Change ----03.15.2017 #V153 maha - modified message
	s = "You have less than the required number of questions(" + string(ii_total) + ").  "
	s+= "Until you complete all the questions you will not be able to use the Forgotten Password link.~r"
	s+= "You can also complete the questions in the from the program menu: System->Personal Settings->My Settings~r~r"
	s+= "Are you sure you want to leave this screen without completing the required number of questions?"
	r = messagebox("Finished", s ,question!,yesno!,2)
	if r = 2 then return -1
end if

return 1

end function

event open;//Start Code Change ----12.10.2015 #V15 maha
integer li_cnt
integer q
string s

select min_quest into :li_cnt from security_settings;

if isnull(li_cnt) or li_cnt = 0 then li_cnt = 2

//Start Code Change ----07.07.2016 #V153 maha - modified order 
ii_total = li_cnt

q = dw_1.retrieve(gs_user_id)
of_total()

s = "Your system security requires that you set up at least " + string(li_cnt) + " security questions for use with the Forgot my Password function."
if q < ii_total then s+= "~rYou currently have " + string(q) + " questions setup.  Please add an additional  "+ string (ii_total - q) + " question(s)."

s+= "~rClick Add to select security questions, then click Enter answer to to provider an answer. (answers are encrypted in the database)"
st_1.text = s


end event

on w_security_user_quest_add.create
this.cb_prior=create cb_prior
this.cb_next=create cb_next
this.cb_3=create cb_3
this.cb_add=create cb_add
this.cb_1=create cb_1
this.st_num=create st_num
this.st_4=create st_4
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.cb_prior,&
this.cb_next,&
this.cb_3,&
this.cb_add,&
this.cb_1,&
this.st_num,&
this.st_4,&
this.st_1,&
this.dw_1}
end on

on w_security_user_quest_add.destroy
destroy(this.cb_prior)
destroy(this.cb_next)
destroy(this.cb_3)
destroy(this.cb_add)
destroy(this.cb_1)
destroy(this.st_num)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.dw_1)
end on

type cb_prior from commandbutton within w_security_user_quest_add
integer x = 896
integer y = 336
integer width = 238
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<<Prior"
end type

event clicked;//Added by Appeon long.zhang 04.18.2016 (BugL041802)
dw_1.ScrollPriorRow () 
end event

type cb_next from commandbutton within w_security_user_quest_add
integer x = 1147
integer y = 336
integer width = 238
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Next>>"
end type

event clicked;//Added by Appeon long.zhang 04.18.2016 (BugL041802)
dw_1.ScrollNextRow()
end event

type cb_3 from commandbutton within w_security_user_quest_add
integer x = 2030
integer y = 336
integer width = 247
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;integer res

res = messagebox("Delete","Are you sure you want to delete the question?",question!,yesno!,2)

if res = 1 then dw_1.deleterow(0)
dw_1.update()

of_total()
end event

type cb_add from commandbutton within w_security_user_quest_add
integer x = 1778
integer y = 336
integer width = 238
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;long qid
integer r
integer nr

open(w_security_quest_select)

if message.stringparm = "Cancel" then
	return
else
	qid = message.doubleparm
	
	if qid > 0 then
		for r = 1 to dw_1.rowcount()
			if qid = dw_1.getitemnumber(r,"security_user_quest_quest_id") then
				messagebox("Select Question","You already have this question selected.")
				return
			end if
		next
		
		nr = dw_1.insertrow(0) 
		dw_1.setitem(nr, "security_user_quest_quest_id",qid)
		dw_1.setitem(nr, "security_user_quest_user_id",gs_user_id)
		dw_1.scrolltorow(nr)
		 //Start Code Change ----03.15.2017 #V153 maha
		dw_1.setrow(nr)
		dw_1.setfocus( )
		//End Code Change ----03.15.2017 
		dw_1.update()
		of_total()
		
		
	end if
end if
end event

type cb_1 from commandbutton within w_security_user_quest_add
integer x = 960
integer y = 620
integer width = 329
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Finished"
boolean default = true
end type

event clicked;if of_check_quest( ) < 1 then
	return
end if

close(parent)
end event

type st_num from statictext within w_security_user_quest_add
integer x = 562
integer y = 332
integer width = 187
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_4 from statictext within w_security_user_quest_add
integer x = 101
integer y = 336
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Total Questions:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_security_user_quest_add
integer x = 50
integer width = 2254
integer height = 308
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "The system requires that you set up ## security questions for use with the Forgot my Password function."
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_security_user_quest_add
integer x = 64
integer y = 412
integer width = 2203
integer height = 192
integer taborder = 10
string title = "none"
string dataobject = "d_security_quest_user"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;datawindowchild dwchild

this.settransobject(sqlca)
this.getchild( "security_user_quest_quest_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve()
end event

event buttonclicked;string s

open(w_security_answer_add)

s = message.stringparm

if s = "Cancel" then
	return
else
	this.setitem(row, "user_answer", s)
	this.update()
end if
end event

