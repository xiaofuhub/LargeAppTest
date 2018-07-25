$PBExportHeader$w_ctx_tv_settings.srw
forward
global type w_ctx_tv_settings from w_response
end type
type uo_font_list from u_cst_fonts_list within w_ctx_tv_settings
end type
type dw_1 from datawindow within w_ctx_tv_settings
end type
type cb_ok from commandbutton within w_ctx_tv_settings
end type
type cb_cancel from commandbutton within w_ctx_tv_settings
end type
end forward

global type w_ctx_tv_settings from w_response
integer width = 2409
integer height = 1560
string title = "Tree View Display Settings - User Level"
long backcolor = 33551856
event ue_system pbm_syscommand
uo_font_list uo_font_list
dw_1 dw_1
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_ctx_tv_settings w_ctx_tv_settings

type variables
n_cst_ctx_tv iuo_parm
end variables

forward prototypes
public function integer of_check_data ()
end prototypes

event ue_system;If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

public function integer of_check_data ();Integer li_use_group
String ls_group_by
String ls_group_sort_type
String ls_col1,ls_col2,ls_col3,ls_col4,ls_col5
String ls_data_sort_by, ls_data_sort_type

li_use_group = dw_1.GetItemNumber(1,'show_group')
ls_group_by = dw_1.GetItemString(1,'group_by')
ls_col1 = dw_1.GetItemString(1,'display_col1')
ls_col2 = dw_1.GetItemString(1,'display_col2')
ls_col3 = dw_1.GetItemString(1,'display_col3')
ls_col4 = dw_1.GetItemString(1,'display_col4')
ls_col5 = dw_1.GetItemString(1,'display_col5')
ls_data_sort_by = dw_1.GetItemString(1,'display_sort_by')
ls_data_sort_type = dw_1.GetItemString(1,'display_sort_type')

If li_use_group = 1 and (ls_group_by = '' or isnull(ls_group_by)) Then
	Messagebox('Data Verification',"'Group By' field can not be empty if the 'Show in Group' field is checked.")
	dw_1.setfocus()
	dw_1.SetColumn("show_group")
	Return -1
End If

If (ls_col1 = '' or isnull(ls_col1) ) And &
	(ls_col2 = '' or isnull(ls_col2) ) And &
	(ls_col3 = '' or isnull(ls_col3) ) And &
	(ls_col4 = '' or isnull(ls_col4) ) And & 
	(ls_col1 = '' or isnull(ls_col5) ) Then 
		Messagebox('Data Verification',"At least you need to select a Display Field.")
		dw_1.setfocus()
		dw_1.SetColumn("display_col1")
		Return -1
End If


Return 1



end function

on w_ctx_tv_settings.create
int iCurrent
call super::create
this.uo_font_list=create uo_font_list
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_font_list
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancel
end on

on w_ctx_tv_settings.destroy
call super::destroy
destroy(this.uo_font_list)
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event open;call super::open;Blob lb_data
Integer li_find
DatawindowChild ldwc_groupby

If isvalid(Message.Powerobjectparm) Then
	iuo_parm = Message.Powerobjectparm
End If

iuo_parm.ids_ctx_tv_settings.GetFullState(lb_data)
dw_1.SetFullState(lb_data)
dw_1.SetTransObject(SQLCA)

dw_1.GetChild('group_by',ldwc_groupby)

//Delete empty row.
//ldwc_groupby.DeleteRow(1) 
//Delete contract_id
li_find = ldwc_groupby.Find('data_column = ""',1,ldwc_groupby.Rowcount())
If li_find > 0 Then
	ldwc_groupby.DeleteRow(li_find)
End If


//Delete contract_id
li_find = ldwc_groupby.Find('data_column = "ctx_id"',1,ldwc_groupby.Rowcount())
If li_find > 0 Then
	ldwc_groupby.DeleteRow(li_find)
End If

If dw_1.RowCount() = 0 Then
	dw_1.InsertRow(0)
	dw_1.SetItem(1,'user_id',gs_user_id)
End If


end event

event close;//
end event

event closequery;//
end event

event pfc_postopen;call super::pfc_postopen;//Added By Ken.Guo 04/09/2013
Datawindowchild ldwc_text_fonts,ldwc_text_fonts1,ldwc_text_fonts2,ldwc_text_fonts3

dw_1.GetChild('font',ldwc_text_fonts)
uo_font_list.idwc_fonts.RowsCopy(1,uo_font_list.idwc_fonts.RowCount(),primary!,ldwc_text_fonts,1,primary!)

end event

type uo_font_list from u_cst_fonts_list within w_ctx_tv_settings
boolean visible = false
integer x = 974
integer y = 344
integer width = 0
integer height = 0
integer taborder = 50
end type

on uo_font_list.destroy
call u_cst_fonts_list::destroy
end on

type dw_1 from datawindow within w_ctx_tv_settings
integer width = 2377
integer height = 1444
integer taborder = 10
string title = "none"
string dataobject = "d_ctx_tv_settings"
boolean border = false
boolean livescroll = true
end type

event itemchanged;Choose Case dwo.name 
	Case 'show_group' 
		If data = '1' Then
			dw_1.Modify("displaycount.CheckBox.3D='YES'")	
		Else
			dw_1.Modify("displaycount.CheckBox.3D='NO'")	
		End If
	Case 'tv_type'
		If data = 'row' Then
			dw_1.Modify("show_data.CheckBox.3D='YES'")	
		Else
			dw_1.Modify("show_data.CheckBox.3D='NO'")	
		End If
End Choose



end event

event clicked;//Added By Ken.Guo 04/09/2013
Long ll_color,ll_color_org
If dwo.name = 'r_text_color' Then
	ll_color = This.GetItemNumber(1,'font_text_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'font_text_color',ll_color)
	End If
End If


String ls_dwoname, ls_fieldname,ls_fieldtype
Long ll_need_down = -1
ls_dwoname = dwo.name

If Pos(ls_dwoname, '_down') > 0 Then
	ll_need_down = 0
End If
If Pos(ls_dwoname, '_up') > 0 Then
	ll_need_down = 1
End If
If ll_need_down <> -1 Then
	If Pos(ls_dwoname, 'bold') > 0 Then
		ls_fieldtype = 'bold'
	End If
	If Pos(ls_dwoname, 'italy') > 0 Then
		ls_fieldtype = 'italy'
	End If
	If Pos(ls_dwoname, 'underline') > 0 Then
		ls_fieldtype = 'underline'
	End If		
	If ls_fieldtype <> ''  Then
		ls_fieldname = 'font_' + ls_fieldtype
		If This.Describe(ls_fieldname+'.type') = 'column' Then
			This.SetItem(1,ls_fieldname,ll_need_down )
		End If
	End If
End If

end event

type cb_ok from commandbutton within w_ctx_tv_settings
integer x = 1637
integer y = 1340
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;Blob lb_data
dw_1.AcceptText()

If dw_1.ModifiedCount() > 0 Then
	If of_check_data() < 0 Then Return
	If dw_1.Update() <> 1 Then
		Messagebox('Error','Failed to save it. ' + SQLCA.sqlerrtext )
		Return
	End If
	dw_1.GetFullState(lb_data)
	iuo_parm.ids_ctx_tv_settings.SetFullState(lb_data)
	iuo_parm.ids_ctx_tv_settings.SetTransObject(SQLCA)
	CloseWithReturn(Parent,1)	
Else
	CloseWithReturn(Parent,0)	
End If


end event

type cb_cancel from commandbutton within w_ctx_tv_settings
integer x = 2002
integer y = 1340
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent,0)
end event

