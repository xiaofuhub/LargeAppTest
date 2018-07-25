$PBExportHeader$w_phonedetail.srw
forward
global type w_phonedetail from w_response
end type
type sle_comb from singlelineedit within w_phonedetail
end type
type st_1 from statictext within w_phonedetail
end type
type sle_country from singlelineedit within w_phonedetail
end type
type cb_cancel from commandbutton within w_phonedetail
end type
type cb_ok from commandbutton within w_phonedetail
end type
type st_local from statictext within w_phonedetail
end type
type st_city from statictext within w_phonedetail
end type
type st_country from statictext within w_phonedetail
end type
type sle_local from singlelineedit within w_phonedetail
end type
type sle_city from singlelineedit within w_phonedetail
end type
type gb_1 from groupbox within w_phonedetail
end type
end forward

global type w_phonedetail from w_response
integer width = 1614
integer height = 688
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
string icon = "AppIcon!"
boolean clientedge = true
sle_comb sle_comb
st_1 st_1
sle_country sle_country
cb_cancel cb_cancel
cb_ok cb_ok
st_local st_local
st_city st_city
st_country st_country
sle_local sle_local
sle_city sle_city
gb_1 gb_1
end type
global w_phonedetail w_phonedetail

type variables
string is_Return = "Cancel" //Add by Evan 02/03/2009
end variables

forward prototypes
public function string wf_combphone ()
end prototypes

public function string wf_combphone ();String	ls_CombPhone,ls_Country,ls_City,ls_Local

ls_Country = Trim(sle_country.Text)
ls_City = Trim(sle_city.text)
ls_Local = Trim(sle_local.text)

if ls_Country <> '' then ls_CombPhone = "+" + ls_Country + " "
if ls_City <> '' then ls_CombPhone += "(" + ls_City + ") "
if ls_Local <> '' then ls_CombPhone += ls_Local

return ls_CombPhone

end function

on w_phonedetail.create
int iCurrent
call super::create
this.sle_comb=create sle_comb
this.st_1=create st_1
this.sle_country=create sle_country
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_local=create st_local
this.st_city=create st_city
this.st_country=create st_country
this.sle_local=create sle_local
this.sle_city=create sle_city
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_comb
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_country
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.st_local
this.Control[iCurrent+7]=this.st_city
this.Control[iCurrent+8]=this.st_country
this.Control[iCurrent+9]=this.sle_local
this.Control[iCurrent+10]=this.sle_city
this.Control[iCurrent+11]=this.gb_1
end on

on w_phonedetail.destroy
call super::destroy
destroy(this.sle_comb)
destroy(this.st_1)
destroy(this.sle_country)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_local)
destroy(this.st_city)
destroy(this.st_country)
destroy(this.sle_local)
destroy(this.sle_city)
destroy(this.gb_1)
end on

event open;call super::open;String	ls_Param,ls_Country,ls_City,ls_Local,ls_Type
long		ll_AddPos,ll_LeftCom,ll_RightCom,ll_Space

ls_Param = Trim(Message.StringParm)  //Example "phone:+80 (569) 3443423"

if IsNull(ls_Param) then ls_Param = ""

ls_Type = LeftA(ls_Param,PosA(ls_Param,":") - 1)
ls_Param = MidA(ls_Param,PosA(ls_Param,":") + 1)

if Trim(ls_Type) = "" or Lower(ls_Type) = "phone" then
	ls_Type = "Phone"
else
	ls_Type = "Fax"
end if

This.Title = ls_Type + " Number"
gb_1.text = ls_Type + " details"
st_1.text = ls_Type + ":"

ll_AddPos = PosA(ls_Param,"+")
ll_LeftCom = PosA(ls_Param,"(")
ll_RightCom = PosA(ls_Param,")")
ll_Space = PosA(ls_Param," ")

if PosA(ls_Param,"+") > 0 then
	if ll_LeftCom > 0 then
		ls_Country = MidA(ls_Param,ll_AddPos + 1,ll_LeftCom - ll_AddPos - 1)
		ls_Param = MidA(ls_Param,ll_LeftCom)
	elseif ll_Space > 0 then
		ls_Country = MidA(ls_Param,ll_AddPos + 1,ll_Space - ll_AddPos - 1)
		ls_Param = MidA(ls_Param,ll_Space + 1)
	else
		ls_Country = MidA(ls_Param,ll_AddPos + 1)
		ls_Param = ''
	end if
end if

ll_LeftCom = PosA(ls_Param,"(")
ll_RightCom = PosA(ls_Param,")")

if ll_LeftCom > 0 and ll_RightCom > 0 then
	ls_City = MidA(ls_Param,ll_LeftCom + 1,ll_RightCom - ll_LeftCom - 1)
	ls_Param = MidA(ls_Param,ll_RightCom + 1)
end if

ls_Local = ls_Param

sle_country.Text = Trim(ls_Country)
sle_city.Text = Trim(ls_City)
sle_local.Text = Trim(ls_Local)

end event

event close;call super::close;CloseWithReturn(this, is_Return) //Add by Evan 02/03/2009
end event

type sle_comb from singlelineedit within w_phonedetail
integer x = 471
integer y = 84
integer width = 978
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean border = false
boolean displayonly = true
end type

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>  constructor
// $<arguments> (None)
// $<returns>   long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 11/25/2008 by Evan
//////////////////////////////////////////////////////////////////////

long ll_BackColor

if gb_contract_version then
	ll_BackColor = gnv_win_backcolor.of_GetObjectBackColor("SingleLineEdit!", this)
	if not IsNull(ll_BackColor) then
		this.BackColor = ll_BackColor
	end if
end if
end event

type st_1 from statictext within w_phonedetail
integer x = 78
integer y = 92
integer width = 192
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Phone:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_country from singlelineedit within w_phonedetail
event ue_change pbm_enchange
integer x = 475
integer y = 176
integer width = 978
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event ue_change;sle_comb.text = wf_combphone()
end event

type cb_cancel from commandbutton within w_phonedetail
integer x = 1198
integer y = 544
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;//BEGIN---Modify by Evan 02/03/2009
//CloseWithReturn(Parent,'Cancel')
Close(Parent)
//END---Modify by Evan 02/03/2009
end event

type cb_ok from commandbutton within w_phonedetail
integer x = 837
integer y = 544
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//BEGIN---Modify by Evan 02/03/2009
//CloseWithReturn(Parent,sle_comb.text)
is_Return = sle_comb.text
Close(Parent)
//END---Modify by Evan 02/03/2009
end event

type st_local from statictext within w_phonedetail
integer x = 78
integer y = 384
integer width = 384
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Local number:"
boolean focusrectangle = false
end type

type st_city from statictext within w_phonedetail
integer x = 78
integer y = 288
integer width = 384
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "City/Area code:"
boolean focusrectangle = false
end type

type st_country from statictext within w_phonedetail
integer x = 78
integer y = 188
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Country/Region:"
boolean focusrectangle = false
end type

type sle_local from singlelineedit within w_phonedetail
event ue_change pbm_enchange
integer x = 475
integer y = 376
integer width = 978
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event ue_change;sle_comb.text = wf_combphone()
end event

type sle_city from singlelineedit within w_phonedetail
event ue_change pbm_enchange
integer x = 475
integer y = 276
integer width = 978
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event ue_change;sle_comb.text = wf_combphone()
end event

type gb_1 from groupbox within w_phonedetail
integer x = 23
integer y = 4
integer width = 1518
integer height = 520
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Phone details"
end type

