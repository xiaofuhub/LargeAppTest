$PBExportHeader$w_req_profile_select.srw
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type w_req_profile_select from window
end type
type cb_1 from commandbutton within w_req_profile_select
end type
type cb_cancel from commandbutton within w_req_profile_select
end type
type cb_ok from commandbutton within w_req_profile_select
end type
type dw_profile_select from datawindow within w_req_profile_select
end type
end forward

global type w_req_profile_select from window
integer width = 2277
integer height = 1384
boolean titlebar = true
string title = "Contract Requirement Profile"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_cancel cb_cancel
cb_ok cb_ok
dw_profile_select dw_profile_select
end type
global w_req_profile_select w_req_profile_select

on w_req_profile_select.create
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_profile_select=create dw_profile_select
this.Control[]={this.cb_1,&
this.cb_cancel,&
this.cb_ok,&
this.dw_profile_select}
end on

on w_req_profile_select.destroy
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_profile_select)
end on

event open;String	ls_Value,ls_rqmnt
long		ll_Find,ll_Pos

dw_profile_select.SetTransObject(SQLCA)
dw_profile_select.Retrieve()

ls_Value = Trim(Message.StringParm)
if Not (IsNull(ls_Value) or Trim(ls_Value) = "") then
	if Right(ls_Value,1) <> "," then ls_Value += ","
	
	do 
		ll_Pos = Pos(ls_Value,"',")
		ls_rqmnt = Left(ls_Value,ll_Pos - 1)
		ls_Value = Mid(ls_Value,ll_Pos + 1)
		
		ll_Find = dw_profile_select.Find("rqmnt_name = " + ls_rqmnt,1,dw_profile_select.RowCount())
		if ll_Find > 0 then
			dw_profile_select.SetItem(ll_Find,"selected",1)
		end if
	loop while ls_Value <> ""
end if

end event

type cb_1 from commandbutton within w_req_profile_select
integer x = 18
integer y = 1176
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Select All"
end type

event clicked;long	ll_Cycle,ll_RowCnts,ls_Value[]

ll_RowCnts = dw_profile_select.RowCount()

if this.text = "&Select All" then
	for ll_Cycle = 1 to ll_RowCnts
		ls_Value[ll_Cycle] = 1
	next
	dw_profile_select.Object.selected.Primary = ls_Value
	this.text = "&Deselect All"
else
	for ll_Cycle = 1 to ll_RowCnts
		ls_Value[ll_Cycle] = 0
	next
	dw_profile_select.Object.selected.Primary = ls_Value
	this.text = "&Select All"
end if

end event

type cb_cancel from commandbutton within w_req_profile_select
integer x = 1906
integer y = 1176
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,"")

end event

type cb_ok from commandbutton within w_req_profile_select
integer x = 1527
integer y = 1176
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
boolean default = true
end type

event clicked;long		ll_Find,ll_RowCnts
String	ls_AllSelect,ls_rqmnt

ll_RowCnts = dw_profile_select.RowCount()

do 
	ll_Find = dw_profile_select.Find("selected = 1",ll_Find + 1,ll_RowCnts)
	if ll_Find <= 0 then Exit
	
	ls_rqmnt = dw_profile_select.GetItemString(ll_Find,"rqmnt_name")
	ls_AllSelect += "'" + String(ls_rqmnt) + "',"
loop while ll_Find < ll_RowCnts

if ls_AllSelect = "" then ls_AllSelect = ","

CloseWithReturn(Parent,ls_AllSelect)

end event

type dw_profile_select from datawindow within w_req_profile_select
integer x = 18
integer y = 20
integer width = 2231
integer height = 1132
integer taborder = 10
string title = "none"
string dataobject = "d_req_profile_select"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long	ll_Selected

if Row > 0 and Row <= This.RowCount() then
	This.SetRow(Row)
	if Lower(dwo.Name) <> Lower("Selected") then
		ll_Selected = This.GetItemNumber(Row,"Selected")
		This.SetItem(Row,"Selected",1 - ll_Selected)
	end if
end if

end event

event doubleclicked;This.Trigger Event Clicked(XPos,YPos,Row,dwo)
end event

