$PBExportHeader$w_group_painter.srw
forward
global type w_group_painter from w_response
end type
type cb_2 from commandbutton within w_group_painter
end type
type cb_1 from commandbutton within w_group_painter
end type
type dw_group from u_dw within w_group_painter
end type
type cb_close from commandbutton within w_group_painter
end type
type cb_save from commandbutton within w_group_painter
end type
type cb_delete from commandbutton within w_group_painter
end type
type cb_create from commandbutton within w_group_painter
end type
type dw_group_users from u_dw within w_group_painter
end type
type gb_1 from groupbox within w_group_painter
end type
type gb_users from groupbox within w_group_painter
end type
end forward

global type w_group_painter from w_response
integer width = 1371
integer height = 1404
string title = "Group Admin"
long backcolor = 33551856
event ue_syscommand pbm_syscommand
cb_2 cb_2
cb_1 cb_1
dw_group dw_group
cb_close cb_close
cb_save cb_save
cb_delete cb_delete
cb_create cb_create
dw_group_users dw_group_users
gb_1 gb_1
gb_users gb_users
end type
global w_group_painter w_group_painter

type variables
DatawindowChild idwc_group
Long il_group_id
DataStore ids_group_users
Boolean ib_changed = false
end variables

event ue_syscommand;//Trigger Close button when click close.
If message.wordparm = 61536 Then
	cb_close.Trigger Event Clicked()
End If
end event

on w_group_painter.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_group=create dw_group
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_create=create cb_create
this.dw_group_users=create dw_group_users
this.gb_1=create gb_1
this.gb_users=create gb_users
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_group
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.cb_create
this.Control[iCurrent+8]=this.dw_group_users
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_users
end on

on w_group_painter.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_group)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_create)
destroy(this.dw_group_users)
destroy(this.gb_1)
destroy(this.gb_users)
end on

event open;call super::open;Long ll_group_id
ll_group_id = Message.Doubleparm

ids_group_users = Create DataStore
ids_group_users.Dataobject = 'd_security_group_users'
ids_group_users.SetTransObject(SQLCA)

dw_group.GetChild('Group_id',idwc_group)
idwc_group.SetTransObject(SQLCA)
idwc_group.Retrieve()
dw_group.InsertRow(0)

If ll_group_id > 0 Then
	dw_group.SetItem(1,'Group_id',ll_group_id)
	dw_group.Trigger Event ItemChanged(1,dw_group.Object.Group_id,String(ll_group_id))
End If



end event

type cb_2 from commandbutton within w_group_painter
integer x = 969
integer y = 288
integer width = 361
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Properties"
end type

event clicked;Long ll_find_row
String ls_group_name

If il_group_id <= 0 Then Return

OpenwithParm(w_group_properties,il_group_id)
If Message.number > 0 Then 
	idwc_group.Retrieve()
	ll_find_row = idwc_group.Find( 'id = '+ String(il_group_id), 1, idwc_group.Rowcount())
	ls_group_name = idwc_group.GetItemString(ll_find_row,'Group_name')
	If ls_group_name = '' Then
		gb_users.text = 'Assign users to the group:'
	Else
		gb_users.text = 'Assign users to '+ls_group_name+':'
	End If

	ib_changed = True
End If
	
end event

type cb_1 from commandbutton within w_group_painter
integer x = 969
integer y = 944
integer width = 361
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;Long ll_cnt,i
Integer li_select_value[],li_deselect_value[]
ll_cnt = dw_group_users.RowCount()
If ll_cnt = 0 Then Return 1

For i = 1 to ll_cnt
	li_select_value[i] = 1
	li_deselect_value[i] = 0
Next

If This.Text = 'Deselect &All' Then
	dw_group_users.object.selected[1,ll_cnt] = li_deselect_value[]
	This.Text = 'Select &All'
Else
	dw_group_users.object.selected[1,ll_cnt] = li_select_value[]
	This.Text = 'Deselect &All'
End If

end event

type dw_group from u_dw within w_group_painter
integer x = 41
integer y = 80
integer width = 841
integer height = 84
integer taborder = 10
string dataobject = "d_group_list"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////
// $<event>dw_group::itemchanged()
// $<arguments>
//		value	long    	row 		
//		value	dwobject	dwo 		
//		value	string  	data		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

integer li_ret
Long ll_find_row
String ls_group_name

If dw_group_users.ModifiedCount() > 0 Then
	li_ret = Messagebox('Save','You have modified some data. ~r~nDo you want to save the changes?',Question!,YesNo!)
	If li_ret = 1 Then
		cb_save.Trigger Event Clicked()
	End If
End If
il_group_id = Long(data)
dw_group_users.Retrieve(il_group_id)


ll_find_row = idwc_group.Find( 'id = '+ String(il_group_id), 1, idwc_group.Rowcount())
ls_group_name = idwc_group.GetItemString(ll_find_row,'Group_name')
If ls_group_name = '' Then
	gb_users.text = 'Assign users to the group:'
Else
	gb_users.text = 'Assign users to '+ls_group_name+':'
End If


end event

event constructor;call super::constructor;This.of_SetUpdateAble( False )

end event

type cb_close from commandbutton within w_group_painter
integer x = 969
integer y = 1184
integer width = 361
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cb_close::clicked()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_ret
If dw_group_users.Modifiedcount( ) > 0 Then
	li_ret = Messagebox('Save','Do you want to save the changes?',Question!,YesNoCancel!)
	If li_ret = 1 Then
		If cb_save.Trigger Event Clicked() > 0 Then
			//Refresh group access tabpge data
			If ib_changed and IsValid(gw_contract) Then
				gw_contract.tab_contract_details.of_refresh_group()
			End If
			ClosewithReturn(Parent,1)
		Else
			Return -1
		End If
	ElseIf li_ret = 2 Then
		If ib_changed Then
			//Refresh group access tabpge data
			If IsValid(gw_contract) Then
				gw_contract.tab_contract_details.of_refresh_group()
			End If			
			ClosewithReturn(Parent,1)
		Else
			ClosewithReturn(Parent,0)
		End If
	Else
		Return 1
	End If
Else
	If ib_changed Then
		//Refresh group access tabpge data
		If IsValid(gw_contract) Then
			gw_contract.tab_contract_details.of_refresh_group()
		End If		
		ClosewithReturn(Parent,1)
	Else
		ClosewithReturn(Parent,0)
	End If
End If

Return 1
end event

type cb_save from commandbutton within w_group_painter
integer x = 969
integer y = 1064
integer width = 361
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cb_save::clicked()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_cnt,i,ll_find_row,ll_row
Integer li_selected,ll_ret
String ls_user_id

//Add or Delete data.
If dw_group_users.ModifiedCount() > 0 Then
	ids_group_users.Retrieve(il_group_id)
	ll_cnt = dw_group_users.rowcount()
	For i = 1 To ll_cnt
		If dw_group_users.GetItemStatus(i,0,Primary!) = DataModified! Then
			li_selected = dw_group_users.GetItemNumber(i,'Selected')	
			ls_user_id = dw_group_users.GetItemString(i,'user_id')
			ll_find_row = ids_group_users.Find('user_id = "'+ls_user_id+'"',1,ids_group_users.RowCount())			
			If li_selected = 0 Then
				//Delete Row
				If ll_find_row > 0 Then 
					ids_group_users.DeleteRow(ll_find_row)
				End If
			Else
				//Add Row
				If ll_find_row = 0 Then
					ll_row = ids_group_users.InsertRow(0)
					ids_group_users.SetItem(ll_row,'group_id',il_group_id)
					ids_group_users.SetItem(ll_row,'user_id',ls_user_id)
				End If
			End If
		End If
	Next
Else
	Return 1
End If

//Update data
If ids_group_users.ModifiedCount() + ids_group_users.DeletedCount() > 0 Then
	gnv_appeondb.of_autocommitrollback()
	If ids_group_users.Update() = 1 Then
		ib_changed = True
		Commit;
		ll_ret = 1
		dw_group_users.ResetUpdate() //Refresh Row/Column status
	Else
		Rollback;
		Messagebox('Save','Failed to save data, please call support.')
		ll_ret = -1	
		ids_group_users.Retrieve(il_group_id) //Refresh data.
	End If
End If

Return ll_ret
end event

type cb_delete from commandbutton within w_group_painter
integer x = 969
integer y = 172
integer width = 361
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Group"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>w_group_painter Properties -  cb_delete  inherited  from  commandbutton()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_group_name
Long ll_group_id
Long ll_row

ll_group_id = dw_group.GetItemNumber(1,'Group_id')
If ll_group_id <= 0 Then Return -1

ll_row = idwc_group.Find( 'id = '+String(ll_group_id), 1,idwc_group.rowcount() )
If ll_row > 0 Then
	ls_group_name = idwc_group.GetItemString(ll_row,'Group_name')
	If Messagebox('Delete','Do you want to delete the group "' + ls_group_name + '"?',Question!,YesNo!) = 1 Then 
		//Delete data
		gnv_appeondb.of_startqueue( )
		Delete From security_groups where id = :ll_group_id;
		Delete From security_group_users where group_id = :ll_group_id;
		gnv_appeondb.of_commitqueue()
		//Refresh DDDW data
		ib_changed = True
		If idwc_group.rowcount() = 1 Then
			ll_row = 0
			il_group_id = 0
		ElseIf ll_row > 1 and ll_row = idwc_group.rowcount() Then
			ll_row = ll_row - 1
		Else
			ll_row = ll_row + 1
		End If
		If ll_row = 0 Then 
			idwc_group.SetTransObject(SQLCA)
			idwc_group.Retrieve()
			SetNull(ll_group_id)
			dw_group.SetItem(1,'Group_id',ll_group_id)
			dw_group_users.Reset()
			Return 1
		End If
		//Get Next Group 
		ll_group_id = idwc_group.GetItemNumber(ll_row,'id')
		idwc_group.SetTransObject(SQLCA)
		idwc_group.Retrieve()
		dw_group.SetItem(1,'Group_id',ll_group_id)
		dw_group.Trigger Event ItemChanged(1,dw_group.Object.Group_id,String(ll_group_id))
	End If		
End If


end event

type cb_create from commandbutton within w_group_painter
integer x = 969
integer y = 56
integer width = 361
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&reate Group"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>w_group_painter -  cb_create  inherited  from  commandbutton()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.19.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long ll_group_id

cb_save.Trigger Event Clicked()

Open(w_group_name_add)
ll_group_id = Message.doubleparm
If ll_group_id <= 0 Then Return 1
idwc_group.SetTransObject(SQLCA)
idwc_group.Retrieve()

If ll_group_id > 0 Then
	dw_group.SetItem(1,'Group_id',ll_group_id)
	dw_group.Trigger Event ItemChanged(1,dw_group.Object.Group_id,String(ll_group_id))
	ib_changed = True
End If

end event

type dw_group_users from u_dw within w_group_painter
integer x = 18
integer y = 264
integer width = 896
integer height = 1032
integer taborder = 30
string dataobject = "d_group_users_select"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
end event

type gb_1 from groupbox within w_group_painter
integer y = 20
integer width = 928
integer height = 176
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Group"
end type

type gb_users from groupbox within w_group_painter
integer y = 208
integer width = 928
integer height = 1104
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Assign users to the group:"
end type

