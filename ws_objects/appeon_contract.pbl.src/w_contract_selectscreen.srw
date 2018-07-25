$PBExportHeader$w_contract_selectscreen.srw
forward
global type w_contract_selectscreen from window
end type
type cb_cancel from u_cb within w_contract_selectscreen
end type
type cb_select from u_cb within w_contract_selectscreen
end type
type tv_screen from u_contract_screen within w_contract_selectscreen
end type
end forward

global type w_contract_selectscreen from window
integer width = 1477
integer height = 1724
boolean titlebar = true
string title = "Select Screen"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_select cb_select
tv_screen tv_screen
end type
global w_contract_selectscreen w_contract_selectscreen

type variables
long il_Return = -1
long il_data_view_id
end variables

on w_contract_selectscreen.create
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.tv_screen=create tv_screen
this.Control[]={this.cb_cancel,&
this.cb_select,&
this.tv_screen}
end on

on w_contract_selectscreen.destroy
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.tv_screen)
end on

event open;il_data_view_id = Message.DoubleParm
tv_screen.of_Retrieve(il_data_view_id)
end event

event close;CloseWithReturn(this, il_Return)
end event

type cb_cancel from u_cb within w_contract_selectscreen
integer x = 1097
integer y = 1512
integer width = 343
integer taborder = 30
boolean bringtotop = true
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_select from u_cb within w_contract_selectscreen
integer x = 741
integer y = 1512
integer width = 343
integer taborder = 20
boolean bringtotop = true
string text = "&Select"
boolean default = true
end type

event clicked;if tv_screen.itvi_CurrentItem.PictureIndex = 1 then
	MessageBox("Select", "Please select a screen item.")
else
	il_Return = tv_screen.itvi_CurrentItem.Data
	Close(Parent)
end if
end event

type tv_screen from u_contract_screen within w_contract_selectscreen
integer x = 14
integer y = 16
integer width = 1422
integer height = 1468
integer taborder = 10
end type

event doubleclicked;call super::doubleclicked;cb_select.Event Clicked()
end event

