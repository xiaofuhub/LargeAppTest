$PBExportHeader$w_ctxs_email_send_result.srw
forward
global type w_ctxs_email_send_result from w_response
end type
type cb_saveas from commandbutton within w_ctxs_email_send_result
end type
type cb_close from commandbutton within w_ctxs_email_send_result
end type
type dw_1 from datawindow within w_ctxs_email_send_result
end type
end forward

global type w_ctxs_email_send_result from w_response
boolean visible = false
integer width = 3045
integer height = 1732
string title = "Default to Contact Person"
boolean controlmenu = false
windowtype windowtype = popup!
long backcolor = 33551856
cb_saveas cb_saveas
cb_close cb_close
dw_1 dw_1
end type
global w_ctxs_email_send_result w_ctxs_email_send_result

type variables

end variables

on w_ctxs_email_send_result.create
int iCurrent
call super::create
this.cb_saveas=create cb_saveas
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_saveas
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.dw_1
end on

on w_ctxs_email_send_result.destroy
call super::destroy
destroy(this.cb_saveas)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type cb_saveas from commandbutton within w_ctxs_email_send_result
integer x = 2272
integer y = 1504
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save As..."
end type

event clicked;dw_1.SaveAs()
end event

type cb_close from commandbutton within w_ctxs_email_send_result
integer x = 2642
integer y = 1504
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type dw_1 from datawindow within w_ctxs_email_send_result
integer x = 23
integer y = 24
integer width = 2967
integer height = 1440
integer taborder = 10
string title = "none"
string dataobject = "d_ctx_contract_email"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;String  ls_downurl
inet linet_help

If Row <= 0 Then Return 1

This.SelectRow(0, False)
This.SelectRow(Row, True)

If dwo.name = 'sent_result' And Pos(Lower(This.GetItemString(Row,'sent_result')),'error code') > 0 Then
	IF appeongetclienttype() = 'WEB' THEN
	  SELECT Top 1 downloadurl Into :ls_downurl From icred_settings;
		IF Len(ls_downurl) > 0 THEN
			linet_help = Create inet
			linet_help.HyperLinkToURL(ls_downurl+'help\html\'+'email_Send.htm')
			Destroy linet_help
		ELSE
			MessageBox("Error","Tring get help file path Failed.")
		END IF
	else	
		ShowHelp(Gs_Current_Directory+"\help\Intellihelp.chm", Keyword!, "Email Send")
	end if
End If
end event

event rowfocuschanged;If CurrentRow > 0 Then
	This.SelectRow(0, False)
	This.SelectRow(CurrentRow, True)
End If
end event

event constructor;This.SetTransObject(SQLCA)
end event

