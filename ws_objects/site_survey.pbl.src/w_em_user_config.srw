$PBExportHeader$w_em_user_config.srw
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type w_em_user_config from w_response
end type
type cb_cancel from commandbutton within w_em_user_config
end type
type cb_ok from commandbutton within w_em_user_config
end type
type dw_config from u_dw within w_em_user_config
end type
end forward

global type w_em_user_config from w_response
integer width = 1888
integer height = 1704
long backcolor = 33551856
cb_cancel cb_cancel
cb_ok cb_ok
dw_config dw_config
end type
global w_em_user_config w_em_user_config

type variables
String is_user
Long il_tag_mode_org
end variables

on w_em_user_config.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_config=create dw_config
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_config
end on

on w_em_user_config.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_config)
end on

event open;call super::open;
//---------Begin Added by (Appeon)Eugene 09.17.2013 for V141 ISG-CLX--------
If Not gb_contract_module Then
	dw_config.dataobject= 'd_em_user_config_ic'
	cb_ok.y = cb_ok.y - 534
	cb_cancel.y = cb_ok.y
	This.height = This.height - 534
End If
//---------End Added ------------------------------------------------------------------

dw_config.SetTransObject(SQLCA)
dw_config.Retrieve(is_user)

If dw_config.rowcount() = 0 Then 
	Insert Into em_user_config(user_id,email_receive_start_date,email_receive_by_date,email_receive_by_clx,email_receive_by_subject,email_receive_all,email_log,email_delete_from_server,email_timer,auto_add_ctx)
	Select :is_user,(select email_start_date from icred_settings),1,1,1,0,1,0,3,1;	
	If sqlca.sqlcode <> 0 Then
		Messagebox('Error','Failed to initialize the configuation. '+ SQLCA.sqlerrtext +'. Please call support.')
	End If
	dw_config.Retrieve(is_user)
End If
This.title = 'Email Receive Options (' + is_user + ')'


il_tag_mode_org = dw_config.GetItemNumber(1,'email_tag_mode')
end event

event pfc_preopen;call super::pfc_preopen;is_user = Message.stringparm



end event

type cb_cancel from commandbutton within w_em_user_config
integer x = 1454
integer y = 1480
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_em_user_config
integer x = 1083
integer y = 1480
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Integer li_ret
Long ll_tag_mode_new
Boolean lb_timer_changed

If dw_config.GetItemStatus(1,'email_timer',Primary!) = DataModified! Then
	lb_timer_changed = True
End If

li_ret = Parent.event pfc_save( )
If li_ret = 0 Then 
	Close(Parent)
	Return
End If

If li_ret = 1 Then 
	gnv_data.of_retrieve("em_user_config") 
	If lb_timer_changed and Isvalid(w_email_folder) Then
		w_email_folder.of_reset_timer()
	End If
	
	ll_tag_mode_new = dw_config.GetItemNumber(1,'email_tag_mode')
	If ll_tag_mode_new <> il_tag_mode_org Then
		Update icred_settings Set email_tag_mode = :ll_tag_mode_new;
		gnv_data.of_retrieve("icred_settings") 
	End If
	Close(Parent)
End If

Return
end event

type dw_config from u_dw within w_em_user_config
integer x = 9
integer y = 12
integer width = 1842
integer height = 1444
integer taborder = 10
string dataobject = "d_em_user_config"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.Post of_setdropdowncalendar(True)
end event

event buttonclicked;call super::buttonclicked;String ls_log_file
String ls_null


If dwo.name = 'b_view' Then
	SetNull(ls_null)
	//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
	//ls_log_file = gs_dir_path + gs_DefDirName + "\Email\POP3\TEMP\Log.txt"
	ls_log_file = gs_dir_path + gs_DefDirName + '\Email.Log'
	//---------End Modfiied ------------------------------------------------------
	If Not FileExists(ls_log_file) Then
		Messagebox('Log','No log files.')
		Return 1
	End If	
	//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
	//ShellExecuteA ( Handle( Parent ), "open", 'iexplore', ls_log_file , ls_Null, 4)
	ShellExecuteA ( Handle( Parent ), "open", 'Notepad.exe', ls_log_file , ls_Null, 4)
	//---------End Modfiied ------------------------------------------------------
ElseIf dwo.name = 'b_delete' Then 
	If Messagebox('Delete Confirm','Do you want to delete the log file?', question!, yesno!) = 1 Then
		//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		//ls_log_file = gs_dir_path + gs_DefDirName + "\Email\POP3\TEMP\Log.txt"
		ls_log_file = gs_dir_path + gs_DefDirName + '\Email.Log'
		//---------End Modfiied ------------------------------------------------------
		If FileExists(ls_log_file) Then
			If Not FileDelete(ls_log_file) Then
				Messagebox('Delete Error','Failed to delete the log file ' +ls_log_file + '.' )
				Return -1
			End If
		//---------Begin Added by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		Else
			This.Modify('b_delete.enabled = false')
		//---------End Added ------------------------------------------------------
		End If
	End If
End If
end event

