$PBExportHeader$w_app_w_prac_notes.srw
forward
global type w_app_w_prac_notes from window
end type
type cb_3 from commandbutton within w_app_w_prac_notes
end type
type dw_app from datawindow within w_app_w_prac_notes
end type
type cb_add from commandbutton within w_app_w_prac_notes
end type
type cb_2 from commandbutton within w_app_w_prac_notes
end type
type cb_close from commandbutton within w_app_w_prac_notes
end type
type dw_action from datawindow within w_app_w_prac_notes
end type
type dw_notes from datawindow within w_app_w_prac_notes
end type
type dw_pracs from datawindow within w_app_w_prac_notes
end type
end forward

global type w_app_w_prac_notes from window
integer width = 4146
integer height = 2580
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
dw_app dw_app
cb_add cb_add
cb_2 cb_2
cb_close cb_close
dw_action dw_action
dw_notes dw_notes
dw_pracs dw_pracs
end type
global w_app_w_prac_notes w_app_w_prac_notes

type variables
long il_app
end variables

on w_app_w_prac_notes.create
this.cb_3=create cb_3
this.dw_app=create dw_app
this.cb_add=create cb_add
this.cb_2=create cb_2
this.cb_close=create cb_close
this.dw_action=create dw_action
this.dw_notes=create dw_notes
this.dw_pracs=create dw_pracs
this.Control[]={this.cb_3,&
this.dw_app,&
this.cb_add,&
this.cb_2,&
this.cb_close,&
this.dw_action,&
this.dw_notes,&
this.dw_pracs}
end on

on w_app_w_prac_notes.destroy
destroy(this.cb_3)
destroy(this.dw_app)
destroy(this.cb_add)
destroy(this.cb_2)
destroy(this.cb_close)
destroy(this.dw_action)
destroy(this.dw_notes)
destroy(this.dw_pracs)
end on

event open;////Start Code Change ----10.29.2010 #V10 maha - window created for version 11.1 for Cambron
il_app = message.doubleparm

dw_pracs.retrieve(il_app)
dw_app.retrieve(il_app)



end event

type cb_3 from commandbutton within w_app_w_prac_notes
integer x = 1390
integer y = 144
integer width = 457
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Payor Notes"
end type

event clicked;//view/add notes to application
	//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
	
	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, dw_app.GetItemString( 1, "notes" ))
	string ls_notes
	ls_notes = dw_app.GetItemString( 1, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)
	//---------End Modfiied ------------------------------------------------------
//	IF appeongetclienttype() = 'WEB' THEN  
//		OpenWithParm( w_ai_notes_web, dw_app.GetItemString( 1, "notes" ))
//	ELSE		
//		OpenWithParm( w_ai_notes, dw_app.GetItemString( 1, "notes" ))
//	END IF		
	//OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
	//------End Modified --------------------------------------		

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		dw_app.SetItem( 1, "notes", Message.StringParm )
		dw_app.update()  //Start Code Change ----10.28.2010 #V10 maha - save immediately
	END IF
end event

type dw_app from datawindow within w_app_w_prac_notes
integer x = 32
integer y = 16
integer width = 3611
integer height = 120
integer taborder = 30
string title = "none"
string dataobject = "d_application_name"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type cb_add from commandbutton within w_app_w_prac_notes
integer x = 416
integer y = 144
integer width = 827
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Action for selected providers"
end type

type cb_2 from commandbutton within w_app_w_prac_notes
integer x = 50
integer y = 144
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

type cb_close from commandbutton within w_app_w_prac_notes
integer x = 3712
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
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_action from datawindow within w_app_w_prac_notes
integer x = 1257
integer y = 2116
integer width = 2537
integer height = 340
integer taborder = 20
string title = "none"
string dataobject = "d_net_dev_action_items_add"
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
end event

type dw_notes from datawindow within w_app_w_prac_notes
integer x = 1093
integer y = 240
integer width = 2971
integer height = 1800
integer taborder = 20
string title = "none"
string dataobject = "d_rpt_net_dev_prac_notes_by_appl"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_pracs from datawindow within w_app_w_prac_notes
integer x = 46
integer y = 240
integer width = 1033
integer height = 2220
integer taborder = 10
string title = "none"
string dataobject = "d_apps_with_pracs_inc"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;integer r
long ll_prac

r = this.getclickedrow()
if r < 1 then return //add by appeon:Kater 03.30.2011 
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

ll_prac = this.getitemnumber(r,"prac_id")
dw_notes.retrieve(ll_prac, il_app)

end event

