$PBExportHeader$w_select_peer.srw
forward
global type w_select_peer from window
end type
type st_1 from statictext within w_select_peer
end type
type cb_5 from commandbutton within w_select_peer
end type
type sle_1 from singlelineedit within w_select_peer
end type
type cb_4 from commandbutton within w_select_peer
end type
type cb_3 from commandbutton within w_select_peer
end type
type dw_1 from datawindow within w_select_peer
end type
type cb_2 from commandbutton within w_select_peer
end type
type cb_pop from commandbutton within w_select_peer
end type
end forward

global type w_select_peer from window
integer x = 553
integer y = 388
integer width = 2574
integer height = 2160
boolean titlebar = true
string title = "Select Peer Record"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12639424
st_1 st_1
cb_5 cb_5
sle_1 sle_1
cb_4 cb_4
cb_3 cb_3
dw_1 dw_1
cb_2 cb_2
cb_pop cb_pop
end type
global w_select_peer w_select_peer

type variables
long il_lcode
end variables

on w_select_peer.create
this.st_1=create st_1
this.cb_5=create cb_5
this.sle_1=create sle_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_pop=create cb_pop
this.Control[]={this.st_1,&
this.cb_5,&
this.sle_1,&
this.cb_4,&
this.cb_3,&
this.dw_1,&
this.cb_2,&
this.cb_pop}
end on

on w_select_peer.destroy
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_pop)
end on

type st_1 from statictext within w_select_peer
integer x = 64
integer y = 172
integer width = 1001
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Double-Click to select and Populate."
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_select_peer
integer x = 846
integer y = 36
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
end type

event clicked;//Start Code Change ---- 04.11.2007 #V7 maha moved from edit modified event
//changes data types to long; changed upper number in find
long li_len
long li_row
string val

val = sle_1.text
li_len = LenA( val )

li_row = dw_1.Find( "Mid(UPPER(peername),1," + String(li_len) + ") = '" + UPPER( val ) + "'" , 1, 100000)

IF li_row = 0 THEN
	Return
END IF
dw_1.SetRow( li_row )
dw_1.ScrollToRow( li_row )
dw_1.SelectRow( 0 , False )
dw_1.SelectRow( li_row, True )
end event

type sle_1 from singlelineedit within w_select_peer
integer x = 64
integer y = 36
integer width = 750
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;//Start Code Change ---- 04.11.2007 #V7 maha
//Integer li_len
//Integer li_row
//string val
//
//val = this.text
//li_len = Len( val )
//
//li_row = dw_1.Find( "Mid(UPPER(peername),1," + String(li_len) + ") = '" + UPPER( val ) + "'" , 1, 10000)
//
//IF li_row = 0 THEN
//	Return
//END IF
//dw_1.SetRow( li_row )
//dw_1.ScrollToRow( li_row )
//dw_1.SelectRow( 0 , False )
//dw_1.SelectRow( li_row, True )
end event

type cb_4 from commandbutton within w_select_peer
integer x = 1682
integer y = 36
integer width = 274
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Edit Peer"
end type

event clicked;long res
integer r
long peerid

peerid = dw_1.getitemnumber(dw_1.getrow(),"lookup_code")
//messagebox("peerid",peerid)
if peerid < 1 then 
	messagebox("Select Error","Please Select Peer Name")
	return
end if

openwithparm(w_peer_de,peerid)

res = message.doubleparm
//messagebox("res",res)
if res > 0 then
	dw_1.retrieve("Peer References")
	r = dw_1.Find ( " lookup_code =" +string(res) , 1, dw_1.rowcount() )
	//messagebox("r",r)
	if r > 0 then
		dw_1.scrolltorow(r)
		dw_1.setrow(r)
		dw_1.selectrow(0,false)
		dw_1.selectrow(r,true)
	end if
	
end if
end event

type cb_3 from commandbutton within w_select_peer
integer x = 1403
integer y = 36
integer width = 265
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;long res
integer r

openwithparm(w_peer_de,0)

res = message.doubleparm
//messagebox("res",res)
if res > 0 then
	dw_1.retrieve("Peer References")
	r = dw_1.Find ( " lookup_code =" +string(res) , 1, dw_1.rowcount() )
	//messagebox("r",r)
	if r > 0 then
		dw_1.scrolltorow(r)
		dw_1.setrow(r)
		dw_1.selectrow(0,false)
		dw_1.selectrow(r,true)
	end if
	
end if
end event

type dw_1 from datawindow within w_select_peer
integer x = 59
integer y = 260
integer width = 2423
integer height = 1748
integer taborder = 30
string dataobject = "d_address_lookup_select"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer i

i = this.getclickedrow()
if i < 1 then return
this.scrolltorow(i)
this.setrow(i)
this.selectrow(0,false)
this.selectrow(i,true)


end event

event constructor;DataWindowChild dwc_state
dw_1.GetChild("state", dwc_state)
dwc_state.SetTransObject(SQLCA)
dwc_state.Retrieve("state")


dw_1.GetChild("country", dwc_state)
dwc_state.SetTransObject(SQLCA)
dwc_state.Retrieve("country")


dw_1.SetTransObject( SQLCA )
dw_1.Retrieve("Peer References")



end event

event rowfocuschanged;il_lcode = this.getitemnumber(currentrow,"lookup_code")
end event

event doubleclicked;cb_pop.triggerevent(clicked!) //Start Code Change ----03.28.2008 #V8 maha - populate on dc rather than edit.
end event

type cb_2 from commandbutton within w_select_peer
integer x = 2231
integer y = 36
integer width = 247
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;

closewithreturn(parent,0)
end event

type cb_pop from commandbutton within w_select_peer
integer x = 1966
integer y = 36
integer width = 265
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Populate"
end type

event clicked;if isnull(il_lcode) then il_lcode = 0

closewithreturn(parent,il_lcode)
end event

