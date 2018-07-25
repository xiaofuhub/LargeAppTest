$PBExportHeader$w_batch_update_actions.srw
forward
global type w_batch_update_actions from window
end type
type dw_actions from datawindow within w_batch_update_actions
end type
type dw_update from datawindow within w_batch_update_actions
end type
type cb_2 from commandbutton within w_batch_update_actions
end type
type cb_1 from commandbutton within w_batch_update_actions
end type
end forward

global type w_batch_update_actions from window
integer width = 2368
integer height = 460
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_actions dw_actions
dw_update dw_update
cb_2 cb_2
cb_1 cb_1
end type
global w_batch_update_actions w_batch_update_actions

on w_batch_update_actions.create
this.dw_actions=create dw_actions
this.dw_update=create dw_update
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_actions,&
this.dw_update,&
this.cb_2,&
this.cb_1}
end on

on w_batch_update_actions.destroy
destroy(this.dw_actions)
destroy(this.dw_update)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;//Start Code Change ----05.08.2012 #V12 maha - created for 12.2
long ll_recids[]


//get the recids

//ll_recids = 

dw_update.settransobject(sqlca)
dw_update.insertrow(1)

dw_actions.settransobject(sqlca)
//retrieve the update records
dw_actions.retrieve (ll_recids[])

end event

type dw_actions from datawindow within w_batch_update_actions
boolean visible = false
integer x = 2167
integer y = 468
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "d_net_dev_action_items"
boolean livescroll = true
end type

type dw_update from datawindow within w_batch_update_actions
integer x = 5
integer y = 140
integer width = 2341
integer height = 292
integer taborder = 10
string title = "none"
string dataobject = "d_net_dev_action_items_update"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;// $<event> buttonclicked
// $<description> Set notes v12.2 app batch update
// $<add> long.zhang 06.19.2012
if dwo.name = "b_notes" then
		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen

	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
	string ls_notes
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)
	//---------End Modfiied ------------------------------------------------------
//	IF appeongetclienttype() = 'WEB' THEN  
//		OpenWithParm( w_ai_notes_web, This.GetItemString( row, "notes" ))
//	ELSE		
//		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
//	END IF	

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		This.SetItem( row, "notes", Message.StringParm )
	END IF
end if
end event

type cb_2 from commandbutton within w_batch_update_actions
integer x = 1989
integer y = 36
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_batch_update_actions
integer x = 1623
integer y = 36
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;//added by long.zhang 06.18.2012 v12.2 app batch update
long ll_row
string ls_message
str_app_update ls_app

ll_row = dw_update.getrow( )
if ll_row < 1 then return 

dw_update.accepttext( )

//Start Code Change ----07.26.2012 #V12 maha - don't update if not changed
if dw_update.getitemstatus( ll_row, "action_status", primary!) = datamodified! then
	ls_app.action_status = dw_update.getitemnumber( ll_row,"action_status")
else
	ls_app.action_status = -100
end if

if dw_update.getitemstatus( ll_row, "action_type", primary!) = datamodified! then
	ls_app.action_type = dw_update.getitemnumber( ll_row,"action_type")
else
	ls_app.action_type = -100
end if

if dw_update.getitemstatus( ll_row, "notes", primary!) = datamodified! then
	ls_app.notes = dw_update.getitemstring( ll_row,"notes")
else
	ls_app.notes = "NoUpdate"
end if
//Start Code Change ----07.26.2012

//Start Code Change ----10.15.2012 #V12 maha
//if dw_update.getitemnumber( ll_row, "send_to_hist") = 1 then
if dw_update.getitemnumber( ll_row, "set_as_hist") = 1 then	//alfee 10.16.2012
	ls_app.send_hist = 1
end if
//End Code Change ----10.15.2012

//Start Code Change ----10.18.2016 #V152 maha
if dw_update.getitemstatus( ll_row, "action_user", primary!) = datamodified! then
	ls_app.action_user = dw_update.getitemstring( ll_row,"action_user")
else
	ls_app.action_user = "NoUpdate"
end if
//End Code Change ----10.18.2016

CloseWithReturn(parent,ls_app)
end event

