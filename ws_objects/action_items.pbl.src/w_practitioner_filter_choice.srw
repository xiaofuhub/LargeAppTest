$PBExportHeader$w_practitioner_filter_choice.srw
forward
global type w_practitioner_filter_choice from window
end type
type st_4 from statictext within w_practitioner_filter_choice
end type
type st_3 from statictext within w_practitioner_filter_choice
end type
type cb_batch from commandbutton within w_practitioner_filter_choice
end type
type st_1 from statictext within w_practitioner_filter_choice
end type
type cb_2 from commandbutton within w_practitioner_filter_choice
end type
type cb_single from commandbutton within w_practitioner_filter_choice
end type
type dw_1 from datawindow within w_practitioner_filter_choice
end type
end forward

global type w_practitioner_filter_choice from window
integer x = 585
integer y = 932
integer width = 2889
integer height = 728
boolean titlebar = true
string title = "Practitioner Selection Type"
windowtype windowtype = response!
long backcolor = 32891346
st_4 st_4
st_3 st_3
cb_batch cb_batch
st_1 st_1
cb_2 cb_2
cb_single cb_single
dw_1 dw_1
end type
global w_practitioner_filter_choice w_practitioner_filter_choice

type variables
integer ii_screen
end variables

on w_practitioner_filter_choice.create
this.st_4=create st_4
this.st_3=create st_3
this.cb_batch=create cb_batch
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_single=create cb_single
this.dw_1=create dw_1
this.Control[]={this.st_4,&
this.st_3,&
this.cb_batch,&
this.st_1,&
this.cb_2,&
this.cb_single,&
this.dw_1}
end on

on w_practitioner_filter_choice.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_batch)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_single)
destroy(this.dw_1)
end on

event open;IF gb_sk_ver = True THEN  //Start Code Change ----11.19.2010 #V10 maha - hide for SK
	cb_single.triggerevent(clicked!)
	return
end if

dw_1.settransobject(sqlca)
dw_1.retrieve()
//--------------------------- APPEON BEGIN ---------------------------
//$<Modified> 01.13.2006 By: Liuhongxin
//$<reason> Fix a defect.
/* 
dw_1.insertrow(1)
*/
datawindowchild dwchild
dw_1.GetChild("batch_id", dwchild)
dwchild.SetTransObject(Sqlca)
dwchild.InsertRow(1)
dwchild.SetItem(1, "batch_id", -999)
dwchild.SetItem(1, "batch_name", "")

dw_1.SetItem(1, "batch_id", -999)
//---------------------------- APPEON END ----------------------------

end event

type st_4 from statictext within w_practitioner_filter_choice
integer x = 306
integer y = 188
integer width = 1605
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32891346
boolean enabled = false
string text = "the BATCH SEARCH button to create a list,"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_practitioner_filter_choice
integer x = 873
integer y = 316
integer width = 1033
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32891346
boolean enabled = false
string text = "or select an existing IntelliBatch list."
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_batch from commandbutton within w_practitioner_filter_choice
integer x = 1979
integer y = 188
integer width = 571
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Batch Search"
end type

event clicked;closewithreturn(parent,"B")
end event

type st_1 from statictext within w_practitioner_filter_choice
integer y = 60
integer width = 1911
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32891346
boolean enabled = false
string text = "Click the INDIVIDUAL PRACTITIONER button for specific practitoners, "
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_practitioner_filter_choice
integer x = 1979
integer y = 432
integer width = 571
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"C")
end event

type cb_single from commandbutton within w_practitioner_filter_choice
integer x = 1979
integer y = 56
integer width = 645
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Individual Practitioner"
end type

event clicked;closewithreturn(parent,"S")
end event

type dw_1 from datawindow within w_practitioner_filter_choice
integer x = 1979
integer y = 304
integer width = 841
integer height = 92
integer taborder = 30
string dataobject = "d_d_batch_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//ii_screen = integer(data)
//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 01.13.2006 By: Liuhongxin
//$<reason> Fix a defect.
if Long(data) = -999 then return 0
//---------------------------- APPEON END ----------------------------

closewithreturn(parent,data)
end event

