$PBExportHeader$w_peer_de.srw
forward
global type w_peer_de from window
end type
type dw_1 from datawindow within w_peer_de
end type
type cb_2 from commandbutton within w_peer_de
end type
type cb_1 from commandbutton within w_peer_de
end type
end forward

global type w_peer_de from window
integer x = 553
integer y = 388
integer width = 2313
integer height = 1296
boolean titlebar = true
string title = "Select Record"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_peer_de w_peer_de

type variables
long il_lcode
string is_noe
end variables

on w_peer_de.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_peer_de.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;integer r
long ll_noe
integer cnt
string ls_code 

ll_noe = message.doubleparm
//messagebox("ll_noe",ll_noe)
if ll_noe = 0 then
	dw_1.settransobject(sqlca)
	r = dw_1.insertrow(0)
	
	il_lcode = gnv_app.of_get_id("LOOKUP")  //maha changed to this function 061803
//	select lookup_code_id
//	into :il_lcode
//	from ids;
//	
//	il_lcode++
	
	select count(lookup_code)
	into :cnt
	from address_lookup
	where lookup_name  = 'Peer References';
	cnt++
	
	ls_code = "PR" + string(cnt)
	dw_1.setitem(r,"lookup_code",il_lcode)
	dw_1.setitem(r,"lookup_name","Peer References")
	dw_1.setitem(r,"code",ls_code)
	is_noe = "new"
else
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ll_noe)
	il_lcode = ll_noe
	is_noe = "edit"
end if
end event

event closequery;if isnull(il_lcode) then 
	cb_2.triggerevent(clicked!)
end if
end event

type dw_1 from datawindow within w_peer_de
integer x = 18
integer y = 8
integer width = 2272
integer height = 1076
integer taborder = 10
string dataobject = "d_peer_lu_de"
end type

event clicked;integer i

i = this.getclickedrow()



end event

event rowfocuschanged;il_lcode = this.getitemnumber(currentrow,"lookup_code")
end event

event constructor;DataWindowChild dwchild



This.GetChild( "contact_salutation", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Title")

This.GetChild( "web_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Name Suffix")

This.GetChild( "contact_name", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Professional Suffix")

This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("State")

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Country")

end event

type cb_2 from commandbutton within w_peer_de
integer x = 1280
integer y = 1104
integer width = 375
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;

closewithreturn(parent,0)
end event

type cb_1 from commandbutton within w_peer_de
integer x = 841
integer y = 1104
integer width = 375
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;integer res

res = dw_1.update()
commit using sqlca;

if res > 0 then
//	if is_noe = "new" then  //maha removed 061803
//		update ids
//		set lookup_code_id = :il_lcode;
//	end if
//	//messagebox("il_lcode",il_lcode)
	closewithreturn(parent,il_lcode)
else
	messagebox("Save Error","Unable to save this record.")
end if
end event

