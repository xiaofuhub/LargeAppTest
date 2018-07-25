$PBExportHeader$w_facility_billing_rules.srw
forward
global type w_facility_billing_rules from w_response
end type
type dw_copy from u_dw within w_facility_billing_rules
end type
type cb_copy from commandbutton within w_facility_billing_rules
end type
type cb_close from commandbutton within w_facility_billing_rules
end type
type cb_delete from commandbutton within w_facility_billing_rules
end type
type cb_add from commandbutton within w_facility_billing_rules
end type
type cb_save from commandbutton within w_facility_billing_rules
end type
type dw_browse from u_dw within w_facility_billing_rules
end type
type dw_detail from u_dw within w_facility_billing_rules
end type
end forward

global type w_facility_billing_rules from w_response
integer x = 214
integer y = 221
integer width = 2757
integer height = 1864
long backcolor = 33551856
dw_copy dw_copy
cb_copy cb_copy
cb_close cb_close
cb_delete cb_delete
cb_add cb_add
cb_save cb_save
dw_browse dw_browse
dw_detail dw_detail
end type
global w_facility_billing_rules w_facility_billing_rules

type variables
long il_facil
boolean ib_new = false
end variables

forward prototypes
public function integer of_check_data (integer ai_row)
end prototypes

public function integer of_check_data (integer ai_row);string ls_mess
string ls_val
long ll_value
integer res = 1

dw_detail.accepttext()
//type
ls_val = dw_detail.getitemstring(ai_row, "bill_type")
if isnull(ls_val) or ls_val = "" then
	ls_mess = "Please select the billing type." 
	res = 0
else
	choose case ls_val
		case "R"
			ll_value  =  dw_detail.getitemnumber(ai_row, "maint_frequency")
			if isnull(ll_value) then
				ls_mess = "For the billing type Recurring, a frequescy is required." 
				res = 0
			end if
		case "A"
			ll_value  =  dw_detail.getitemnumber(ai_row, "action_type_id")
			if isnull(ll_value) then
				ls_mess = "For the billing type Application, an Action Type is required." 
				res = 0
			end if
	end choose
end if

//bill amt
if isnull(dw_detail.getitemnumber(ai_row, "bill_amount")) then
	ls_mess = "Please enter a billing amount."
	res = 0
end if

if res = 0 then
	//messagebox("Required data",res)
	messagebox("Required data",ls_mess) //Modified by Appeon long.zhang 02.20.2017 (BugL022002)
end if

return res
				



end function

on w_facility_billing_rules.create
int iCurrent
call super::create
this.dw_copy=create dw_copy
this.cb_copy=create cb_copy
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_save=create cb_save
this.dw_browse=create dw_browse
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_copy
this.Control[iCurrent+2]=this.cb_copy
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.dw_browse
this.Control[iCurrent+8]=this.dw_detail
end on

on w_facility_billing_rules.destroy
call super::destroy
destroy(this.dw_copy)
destroy(this.cb_copy)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.dw_browse)
destroy(this.dw_detail)
end on

event open;call super::open;il_facil = message.doubleparm

dw_browse.retrieve(il_facil)
end event

type dw_copy from u_dw within w_facility_billing_rules
boolean visible = false
integer x = 41
integer y = 28
integer width = 146
integer height = 80
integer taborder = 10
string dataobject = "d_facility_bill_browse"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_settransobject(sqlca )

end event

type cb_copy from commandbutton within w_facility_billing_rules
integer x = 1568
integer y = 32
integer width = 379
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Copy From"
end type

event clicked;integer res
integer r
integer rc
long ll_null

openwithparm(w_select_facility, "B")
res = message.doubleparm
debugbreak()
if res = 0 then 
	return
elseif res = il_facil then
	messagebox("Copy'","You have selected the same Facility. Please select another")
	return
else
	rc = dw_copy.retrieve(res)
	if rc = 0 then return
	dw_browse.reset()
	dw_detail.reset()
	dw_copy.rowscopy( 1, rc, primary!,dw_browse, 1, primary!)
	setnull(ll_null)
	for r = 1 to rc 
		dw_browse.setitem(r, "facility_id", il_facil)
		dw_browse.setitem(r, "pk_id", ll_null)
	next
	
	r = dw_browse.update()
	r = dw_browse.retrieve(il_facil)
	
end if
end event

type cb_close from commandbutton within w_facility_billing_rules
integer x = 2354
integer y = 32
integer width = 379
integer height = 92
integer taborder = 30
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

type cb_delete from commandbutton within w_facility_billing_rules
integer x = 1957
integer y = 32
integer width = 379
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;integer res

res = messagebox("Delete", "Are you sure you wish to delete the current record?", question!, yesno!, 2)

if res = 2 then return

dw_detail.deleterow(0)
dw_detail.update()
dw_browse.retrieve(il_facil)
end event

type cb_add from commandbutton within w_facility_billing_rules
integer x = 1179
integer y = 32
integer width = 379
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;
cb_save.triggerevent(clicked!)
dw_detail.reset()
dw_detail.insertrow(1)
dw_detail.setitem(1, "facility_id", il_facil)
dw_detail.setitem(1, "active_status", 1)
ib_new = true

end event

type cb_save from commandbutton within w_facility_billing_rules
integer x = 786
integer y = 32
integer width = 379
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;long ll_id
integer rc
integer r

if dw_detail.rowcount() = 0 then return

dw_detail.accepttext()
if dw_detail.getitemstatus( 1, 0,primary!) = notmodified! then return 

if of_check_data(dw_detail.getrow()) = 1 then
	dw_detail.update()
end if


ll_id = dw_detail.getitemnumber(1, "pk_id")
rc = dw_browse.retrieve(il_facil)
	//refresh
if rc > 1 then
	r = dw_browse.find( "pk_id = " + string(ll_id),1, rc)
	dw_browse.setrow(r)
end if

	
	
end event

type dw_browse from u_dw within w_facility_billing_rules
integer x = 14
integer y = 148
integer width = 2720
integer height = 764
integer taborder = 10
string dataobject = "d_facility_bill_browse"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//this.of_setupdateable( false)
this.of_settransobject(sqlca )

end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id

If currentrow > 0 Then //Added by Appeon long.zhang 02.20.2017 (BugL022001)
	this.selectrow(0,false)
	this.selectrow(currentrow, true)
	ll_id = this.getitemnumber(currentrow, "pk_id")
	
	dw_detail.retrieve(ll_id)
End If
end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)

end event

type dw_detail from u_dw within w_facility_billing_rules
integer x = 14
integer y = 928
integer width = 2725
integer height = 844
integer taborder = 10
string dataobject = "d_facility_bill_detail"
boolean vscrollbar = false
end type

event constructor;call super::constructor;this.of_settransobject(sqlca )
end event

