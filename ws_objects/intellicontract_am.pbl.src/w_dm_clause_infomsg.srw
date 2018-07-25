$PBExportHeader$w_dm_clause_infomsg.srw
forward
global type w_dm_clause_infomsg from w_response
end type
type pb_last from picturebutton within w_dm_clause_infomsg
end type
type pb_next from picturebutton within w_dm_clause_infomsg
end type
type pb_prior from picturebutton within w_dm_clause_infomsg
end type
type pb_first from picturebutton within w_dm_clause_infomsg
end type
type st_1 from statictext within w_dm_clause_infomsg
end type
type dw_1 from u_dw within w_dm_clause_infomsg
end type
type cb_1 from commandbutton within w_dm_clause_infomsg
end type
type rte_1 from richtextedit within w_dm_clause_infomsg
end type
end forward

global type w_dm_clause_infomsg from w_response
integer x = 946
integer y = 432
integer width = 2021
integer height = 1696
string title = "Clause Information Message"
long backcolor = 33551856
boolean ib_isupdateable = false
event ue_move ( string as_move )
pb_last pb_last
pb_next pb_next
pb_prior pb_prior
pb_first pb_first
st_1 st_1
dw_1 dw_1
cb_1 cb_1
rte_1 rte_1
end type
global w_dm_clause_infomsg w_dm_clause_infomsg

event ue_move(string as_move);Long ll_row, ll_cnt
ll_row = dw_1.GetRow()
ll_cnt = dw_1.RowCount()

CHOOSE CASE Lower(as_move)
	CASE "first"
		IF ll_row > 1 THEN 
			dw_1.scrolltorow(1)
			dw_1.setrow(1)
//			pb_first.Enabled = False
//			pb_prior.Enabled = False
//			pb_next.Enabled = TRUE
//			pb_last.Enabled = TRUE
		END IF		
	CASE "prior"
		IF ll_row > 1 THEN 
			dw_1.scrollpriorrow()
			dw_1.SetRow(ll_row - 1)
//			IF ll_row = 1 THEN 
//				pb_first.Enabled = False
//				pb_prior.Enabled = False
//			END IF
//			pb_next.Enabled = TRUE
//			pb_last.Enabled = TRUE
		END IF			
	CASE "next"
		IF ll_row < ll_cnt THEN 
			dw_1.ScrollNextRow()
			dw_1.SetRow(ll_row + 1)
//			IF ll_row + 1 = ll_cnt THEN 
//				pb_next.Enabled = False
//				pb_last.Enabled = False
//			END IF
//			pb_first.Enabled = TRUE
//			pb_prior.Enabled = TRUE
		END IF			
	CASE "last"
		IF ll_row < ll_cnt THEN 
			dw_1.ScrolltoRow(ll_cnt)
			dw_1.SetRow(ll_cnt)
//			pb_next.Enabled = False
//			pb_last.Enabled = False
//			pb_first.Enabled = TRUE
//			pb_prior.Enabled = TRUE
		END IF					
		
END CHOOSE
end event

on w_dm_clause_infomsg.create
int iCurrent
call super::create
this.pb_last=create pb_last
this.pb_next=create pb_next
this.pb_prior=create pb_prior
this.pb_first=create pb_first
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.rte_1=create rte_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_last
this.Control[iCurrent+2]=this.pb_next
this.Control[iCurrent+3]=this.pb_prior
this.Control[iCurrent+4]=this.pb_first
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.rte_1
end on

on w_dm_clause_infomsg.destroy
call super::destroy
destroy(this.pb_last)
destroy(this.pb_next)
destroy(this.pb_prior)
destroy(this.pb_first)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.rte_1)
end on

event open;call super::open;DataStore lds_1
Long ll_cnt

IF Not IsValid(Message.PowerObjectParm) THEN RETURN
lds_1 = Message.PowerObjectParm

ll_cnt = lds_1.rowcount()
st_1.text = "Total " +String(ll_cnt) + " Message(s)"

IF ll_cnt > 0 THEN	
	lds_1.rowscopy(1, ll_cnt, Primary!, dw_1, 1, Primary!)
END IF	

IF ll_cnt > 1 THEN	
		pb_first.Visible = True
		pb_prior.Visible = True
		pb_next.Visible = True
		pb_last.Visible = True
ELSE
		pb_first.Visible = False
		pb_prior.Visible = False
		pb_next.Visible = False
		pb_last.Visible = False
END IF

end event

type pb_last from picturebutton within w_dm_clause_infomsg
integer x = 1216
integer y = 1512
integer width = 151
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">>"
end type

event clicked;parent.event ue_move('last')
end event

type pb_next from picturebutton within w_dm_clause_infomsg
integer x = 1065
integer y = 1512
integer width = 151
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">"
end type

event clicked;parent.event ue_move('next')
end event

type pb_prior from picturebutton within w_dm_clause_infomsg
integer x = 914
integer y = 1512
integer width = 151
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<"
end type

event clicked;parent.event ue_move('prior')
end event

type pb_first from picturebutton within w_dm_clause_infomsg
integer x = 763
integer y = 1512
integer width = 151
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<<"
end type

event clicked;parent.event ue_move('first')
end event

type st_1 from statictext within w_dm_clause_infomsg
integer x = 23
integer y = 1516
integer width = 590
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_dm_clause_infomsg
integer x = 23
integer y = 20
integer width = 1952
integer height = 1472
integer taborder = 10
string dataobject = "d_dm_clause_infomsg"
boolean controlmenu = true
boolean vscrollbar = false
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;of_setrowselect(FALSE)
end event

type cb_1 from commandbutton within w_dm_clause_infomsg
integer x = 1696
integer y = 1512
integer width = 279
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type rte_1 from richtextedit within w_dm_clause_infomsg
boolean visible = false
integer x = 521
integer y = 1528
integer width = 215
integer height = 140
integer taborder = 30
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
end type

