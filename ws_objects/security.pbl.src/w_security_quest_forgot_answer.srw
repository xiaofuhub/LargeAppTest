$PBExportHeader$w_security_quest_forgot_answer.srw
forward
global type w_security_quest_forgot_answer from window
end type
type cb_done from commandbutton within w_security_quest_forgot_answer
end type
type st_num from statictext within w_security_quest_forgot_answer
end type
type st_total from statictext within w_security_quest_forgot_answer
end type
type st_3 from statictext within w_security_quest_forgot_answer
end type
type st_2 from statictext within w_security_quest_forgot_answer
end type
type dw_1 from datawindow within w_security_quest_forgot_answer
end type
end forward

global type w_security_quest_forgot_answer from window
integer width = 2263
integer height = 1032
boolean titlebar = true
string title = "Security Questions"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_done cb_done
st_num st_num
st_total st_total
st_3 st_3
st_2 st_2
dw_1 dw_1
end type
global w_security_quest_forgot_answer w_security_quest_forgot_answer

type variables
integer ii_total = 0
integer ii_cnt
integer ii_lock_num //maha 11.02.2016
n_cst_encrypt invo_encrypt  
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
integer li_fail = 0
string ls_ans
string ls_ent
string ls_ent_new //(V15.2 WV Security Questions) alfee 12.30.2016

rc = dw_1.rowcount()
dw_1.accepttext()

//make sure all questions are answered
for r = 1 to rc
	ls_ans = dw_1.getitemstring(r,"user_answer")
	if isnull(ls_ans) or len(ls_ans) = 0 then
		messagebox("Finished","You have not entered an answer for this question.")
		dw_1.scrolltorow(r)
		return -1
	end if
next

//check for correct answers
for r = 1 to rc
	ls_ans = dw_1.getitemstring(r,"user_answer")
	ls_ent = dw_1.getitemstring(r,"entered_answer")
	ls_ent = invo_encrypt.of_encrypt( ls_ent )
	ls_ent_new = invo_encrypt.of_encrypt( ls_ent, true ) //(V15.2 WV Security Questions) alfee 12.30.2016		

	//if ls_ans <> ls_ent then li_fail++
	if ls_ans <> ls_ent and ls_ans <> ls_ent_new then li_fail++ //(V15.2 WV Security Questions) alfee 12.30.2016	
next

if li_fail > 0 then 
	//Start Code Change ----11.02.2016 #V153 maha
	 ii_cnt++
	 if ii_cnt <  ii_lock_num then
		 messagebox("Failed","One or more of your answers in incorrect.  Please check case and spelling.")
	elseif ii_cnt >= ii_lock_num then  //Start Code Change ----11.02.2016 #V153 maha - changed to lockout number
		closewithreturn(w_security_quest_forgot_answer,-2)
	end if
	//End Code Change ----11.02.2016
else
	//success
	closewithreturn(w_security_quest_forgot_answer,1)
end if



return 1

end function

event open;//Start Code Change ----12.10.2015 #V15 maha
integer li_cnt
string s
string ls_user

ls_user = message.stringparm

select count(quest_id) into :li_cnt from security_user_quest where user_id = :ls_user;

//Start Code Change ----11.02.2016 #V152 maha
select login_lockout into :ii_lock_num from security_settings;
if ii_lock_num = 0 or isnull(ii_lock_num) then ii_lock_num = 3
//End Code Change ----11.02.2016

if li_cnt = 0 or isnull(li_cnt) then
	messagebox("Forgot password","The system requires security questions to be able to use the Forgot Password function.  Please contact your System Administrator to reset your password.")
	return -1
end if


st_total.text = "Total Questions: " + string(li_cnt)
//select min_quest into :li_cnt from security_settings;

if isnull(li_cnt) or li_cnt = 0 then li_cnt = 2



ii_total = li_cnt

dw_1.retrieve(ls_user)

st_total.text = "Total Questions: " + string(dw_1.rowcount()) //BugA072801 - alfee 07.28.2016

end event

on w_security_quest_forgot_answer.create
this.cb_done=create cb_done
this.st_num=create st_num
this.st_total=create st_total
this.st_3=create st_3
this.st_2=create st_2
this.dw_1=create dw_1
this.Control[]={this.cb_done,&
this.st_num,&
this.st_total,&
this.st_3,&
this.st_2,&
this.dw_1}
end on

on w_security_quest_forgot_answer.destroy
destroy(this.cb_done)
destroy(this.st_num)
destroy(this.st_total)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_1)
end on

event close;//If caceled, return a failure, Added by Appeon long.zhang 07.18.2016 (BugA071102)
//If Message.DoubleParm = 0 Then Message.DoubleParm = -1 - commented for BugA071102 - alfee 07.26.2016
end event

type cb_done from commandbutton within w_security_quest_forgot_answer
integer x = 882
integer y = 828
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Finished"
end type

event clicked;
if of_check_quest( ) < 1 then
	return
else

end if


end event

type st_num from statictext within w_security_quest_forgot_answer
integer x = 562
integer y = 16
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

type st_total from statictext within w_security_quest_forgot_answer
integer x = 55
integer y = 16
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

type st_3 from statictext within w_security_quest_forgot_answer
boolean visible = false
integer x = 1166
integer y = 16
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Next >>"
boolean focusrectangle = false
end type

type st_2 from statictext within w_security_quest_forgot_answer
boolean visible = false
integer x = 855
integer y = 16
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "<< Prior"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_security_quest_forgot_answer
integer x = 9
integer y = 100
integer width = 2235
integer height = 696
integer taborder = 10
string title = "none"
string dataobject = "d_security_quest_user_user_answer"
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

