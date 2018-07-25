$PBExportHeader$w_sys_table_batch_setting.srw
forward
global type w_sys_table_batch_setting from window
end type
type dw_1 from datawindow within w_sys_table_batch_setting
end type
type cb_4 from commandbutton within w_sys_table_batch_setting
end type
type cb_3 from commandbutton within w_sys_table_batch_setting
end type
end forward

global type w_sys_table_batch_setting from window
integer x = 78
integer y = 64
integer width = 2930
integer height = 2096
boolean titlebar = true
string title = "Batch Screens"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
end type
global w_sys_table_batch_setting w_sys_table_batch_setting

type variables
string is_field1
string is_field2
string is_field3
string is_table
string is_where
end variables

on w_sys_table_batch_setting.create
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.Control[]={this.dw_1,&
this.cb_4,&
this.cb_3}
end on

on w_sys_table_batch_setting.destroy
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	MESSAGEBOX("","LOGIN OK")
//END IF
//
dw_1.settransobject(sqlca)
dw_1.retrieve()

end event

event close;//disCONNECT USING SQLCA;
end event

type dw_1 from datawindow within w_sys_table_batch_setting
integer x = 41
integer y = 140
integer width = 2807
integer height = 1820
integer taborder = 30
string dataobject = "d_sys_table_batch_setting"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;//integer li_screen
//integer r
//integer t
//string find
//string ls_filt
//datawindowchild dwchild
//
//li_screen = this.getitemnumber(currentrow, "table_id")
//
//
//ls_filt = "sys_fields_table_id = " + string(li_screen)
//
//r = dw_1.GetChild( "batch_add_field", dwchild )
//r = dwchild.setfilter(ls_filt)
//r = dwchild.filter()
//dwchild.insertrow(1)  //Start Code Change ----03.15.2011 #V11 maha - added blank
end event

event clicked;integer r

r = this.getclickedrow()

this.setrow(r)
end event

event buttonclicked;long ll_id

openwithparm(w_select_batch_field, dw_1.getitemnumber(row,"table_id"))

if Message.stringparm = "Cancel" then
	return 0
else
	ll_id = message.doubleparm
	if ll_id < 0 then
		return 0
	else
		dw_1.setitem(row, "batch_add_field", ll_id)
	end if
end if
end event

type cb_4 from commandbutton within w_sys_table_batch_setting
integer x = 2171
integer y = 28
integer width = 247
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_1.update()
commit using sqlca;
end event

type cb_3 from commandbutton within w_sys_table_batch_setting
integer x = 2459
integer y = 28
integer width = 274
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

