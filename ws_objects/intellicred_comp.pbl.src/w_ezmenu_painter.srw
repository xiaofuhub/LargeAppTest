$PBExportHeader$w_ezmenu_painter.srw
forward
global type w_ezmenu_painter from w_sheet
end type
type uo_font_list from u_cst_fonts_list within w_ezmenu_painter
end type
type cb_close from commandbutton within w_ezmenu_painter
end type
type cb_save from commandbutton within w_ezmenu_painter
end type
type dw_1 from u_dw within w_ezmenu_painter
end type
type dw_2 from u_dw within w_ezmenu_painter
end type
type gb_1 from groupbox within w_ezmenu_painter
end type
type gb_2 from groupbox within w_ezmenu_painter
end type
end forward

global type w_ezmenu_painter from w_sheet
integer width = 4187
integer height = 2512
string title = "EZ Menu Design"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
uo_font_list uo_font_list
cb_close cb_close
cb_save cb_save
dw_1 dw_1
dw_2 dw_2
gb_1 gb_1
gb_2 gb_2
end type
global w_ezmenu_painter w_ezmenu_painter

type variables
String						is_User ='intellisoft-super-master'
n_cst_dm_utils			inv_utils
end variables

forward prototypes
public function string of_getstring (string as_source, string as_char)
end prototypes

public function string of_getstring (string as_source, string as_char);int							li_pos

If as_char  = 'last' Then
	li_pos =  Pos( as_source, ',' )
	If li_pos > 0 Then
		as_source = Mid( as_source, li_pos + 1 )
	End If
Else
	li_pos =  Pos( as_source, ',' )
	If li_pos > 0 Then
		as_source = Left( as_source, li_pos - 1 )
	End If
	
End If




return as_source
end function

on w_ezmenu_painter.create
int iCurrent
call super::create
this.uo_font_list=create uo_font_list
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_1=create dw_1
this.dw_2=create dw_2
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_font_list
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_ezmenu_painter.destroy
call super::destroy
destroy(this.uo_font_list)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;String				ls_ShowToolBar, ls_ShowMainToolBar, ls_Value
String				ls_pic, ls_toolbarico, ls_name, ls_Temp, ls_Parent
Integer			li_i


If IsValid( w_MDI ) Then
	w_MDI.dw_EZMenu.of_CopyEZMenuTo( dw_1 )
End If

//Start Code Change ----10.06.2014 #V14.2 maha - hide columns if no contracts
if gb_contract_module = false then
	dw_1.modify("toolbaritem.visible = false")
	dw_1.modify("toolbartip.visible = false")
end if
//End Code Change ----10.06.2014


For li_i = 1 To dw_1.RowCount( )
	ls_pic = dw_1.GetItemString( li_i, 'newmenuico' )
	ls_toolbarico = dw_1.GetItemString( li_i, 'toolbarico' )
	ls_name = dw_1.GetItemString( li_i, 'toolbarname' )
	ls_Parent = dw_1.GetItemString( li_i, 'parentmenu' )
	ls_temp = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_ICON' , FALSE )
	If IsNumber( ls_Temp ) Then	dw_1.setitem( li_i, 'iconumber1' , ls_Temp )
	ls_temp = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TOOLBARICON' , FALSE )
	If IsNumber( ls_Temp ) Then	dw_1.setitem( li_i, 'iconumber2' , ls_Temp )
Next
dw_1.ResetUpdate( )

If dw_2.RowCount( ) = 0 Then
	dw_2.insertrow( 0 )
End If
ls_ShowToolBar = gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'SHOWTOOLBAR' )

If IsNull( ls_ShowToolBar ) Then ls_ShowToolBar = ''
If ls_ShowToolBar = '1' Or ls_ShowToolBar = '' Then
	dw_2.setItem( dw_2.RowCount( ), 'showtoolbar', 1 )
Else
	dw_2.setItem( dw_2.RowCount( ), 'showtoolbar', 0 )
End If
ls_ShowMainToolBar = gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'SHOWMAINTOOLBAR' )

If IsNull( ls_ShowMainToolBar ) Then ls_ShowMainToolBar = ''
If ls_ShowMainToolBar = '1' Or ls_ShowMainToolBar = '' Then
	dw_2.setItem( dw_2.RowCount( ), 'showmaintoolbar', 1 )
Else
	dw_2.setItem( dw_2.RowCount( ), 'showmaintoolbar', 0 )
End If
ls_Value = gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'showezmenuicon'  )
If Len( ls_Value ) > 0 Then dw_2.setItem( dw_2.GetRow( ), 'showicon' , long( ls_Value ) ) 	

ls_Value = gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'showcustomizetoolbartexticontips'  )
If Len( ls_Value ) > 0 Then dw_2.setItem( dw_2.GetRow( ), 'customizetoolbar' , long( ls_Value ) ) 		
	
ls_Value = gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'backgroundcolor' )
If Len( ls_Value ) > 0 Then dw_2.setItem( dw_2.GetRow( ), 'backgroundcolor' , long( ls_Value ) ) 
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'headfontname' )
If Len( ls_Value ) > 0 Then dw_2.setItem( dw_2.GetRow( ), 'headfontname', ls_Value ) 
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'headfontsize' )
If Len( ls_Value ) > 0 Then dw_2.setItem( dw_2.GetRow( ), 'headfontsize', long(ls_Value ) )
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'headfontcolor' )
If Len( ls_Value ) > 0 Then dw_2.setItem( dw_2.GetRow( ), 'headfontcolor',long(ls_Value ) )
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'headbackcolor' )
If Len( ls_Value ) > 0 Then  dw_2.setItem( dw_2.GetRow( ), 'headbackcolor' ,long(ls_Value ) )
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'headfontbold' )
If Len( ls_Value ) > 0 Then  dw_2.setItem( dw_2.GetRow( ), 'headfontbold' ,long(ls_Value ) )
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'headfontitalic' )
If Len( ls_Value ) > 0 Then  dw_2.setItem( dw_2.GetRow( ), 'headfontitalic', long(ls_Value ) )

ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'rowfontname' )
If Len( ls_Value ) > 0 Then dw_2.setItem( dw_2.GetRow( ), 'rowfontname' , ls_Value ) 
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'rowfontsize' )
If Len( ls_Value ) > 0 Then  dw_2.setItem( dw_2.GetRow( ), 'rowfontsize', long(ls_Value ) )
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'rowfontcolor' )
If Len( ls_Value ) > 0 Then  dw_2.setItem( dw_2.GetRow( ), 'rowfontcolor', long(ls_Value ) )
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'rowbackcolor' )
If Len( ls_Value ) > 0 Then  dw_2.setItem( dw_2.GetRow( ), 'rowbackcolor', long(ls_Value ) )
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'rowfontbold' )
If Len( ls_Value ) > 0 Then dw_2.setItem( dw_2.GetRow( ), 'rowfontbold' , long(ls_Value ) )
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'rowfontitalic' )
If Len( ls_Value ) > 0 Then  dw_2.setItem( dw_2.GetRow( ), 'rowfontitalic' ,long(ls_Value ) ) 
ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'ezmenutitle' )
If Len( ls_Value ) > 0 Then  dw_2.setItem( dw_2.GetRow( ), 'ezmenutitle' ,ls_Value )


dw_2.SetItemStatus( dw_2.Rowcount( ), 0, primary!, notmodified! )


dw_1.Modify( "toolbarico.visible='0' c_select2.visible='0' c_toolbaricondefault.visible='0' toolbarico_t.visible='0' t_5.visible='0' t_6.visible='0'" )
//If isvalid( w_mdi ) Then
//	IF w_mdi.of_security_access( 6986 ) = 0 THEN
//		dw_1.Modify( "newitems.protect = 1 newitems.background.color = 79741120 newitemtip.protect =1 newitemtip.background.color = 79741120 compute_2.visible=0 compute_1.visible=0" )
//	End If
//End If
end event

event closequery;Integer		li_ret

If dw_1.Modifiedcount( ) + dw_2.Modifiedcount( ) > 0  Then 

	li_ret = Messagebox('Save','Do you want to save the changes?',Question!,YesNoCancel!)
	If li_ret = 1 Then
		If cb_save.Trigger Event Clicked() > 0 Then 

		Else
			Return -1
		End If
	ElseIf li_ret = 2 Then

	Else
		//3
		Return 1
	End If
End If
end event

type uo_font_list from u_cst_fonts_list within w_ezmenu_painter
boolean visible = false
integer x = 2857
integer y = 376
integer width = 731
integer height = 84
integer taborder = 30
end type

on uo_font_list.destroy
call u_cst_fonts_list::destroy
end on

type cb_close from commandbutton within w_ezmenu_painter
integer x = 3767
integer y = 32
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Integer li_ret

dw_1.AcceptText()
dw_2.AcceptText( )
If dw_1.Modifiedcount( ) + dw_2.ModifiedCount( ) = 0  Then 
	Close( Parent )
	Return 1
End If
	
li_ret = Messagebox('Save','Do you want to save the changes?',Question!,YesNoCancel!)
If li_ret = 1 Then
	If cb_save.Trigger Event Clicked() > 0 Then 
		Close( Parent )
	Else
		Return -1
	End If
ElseIf li_ret = 2 Then
	dw_1.ResetUpdate()
	dw_2.ResetUpdate( )
	Close( Parent )
Else
	//3
	Return 1
End If
Return 1
end event

type cb_save from commandbutton within w_ezmenu_painter
integer x = 3392
integer y = 32
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//save
Integer					li_i, li_Count, li_Row
String						ls_name, ls_Tip, ls_Parent, ls_newitem, ls_newtips, ls_Item, ls_pic,ls_Title
String						ls_toolbarico, ls_toolbaritem, ls_toolbartip, ls_Temp


dw_1.AcceptText( )
dw_2.AcceptText( )
If dw_1.ModifiedCount( ) + dw_2.Modifiedcount( ) = 0 Then
	//MessageBox( 'Tips', 'There is no data that need to be saved.' )  //Start Code Change ----08.15.2014 #V14.2 maha - removed as unnecessary
	Return
End If

If dw_1.ModifiedCount( ) > 0 Then 
	li_Count = dw_1.RowCount( )
	For li_i = 1 To li_Count
		ls_newitem = dw_1.GetItemString( li_i, 'newitems' )
		ls_newtips = dw_1.GetItemString( li_i, 'newitemtip' )
		ls_toolbaritem = dw_1.GetItemString( li_i, 'toolbaritem' )
		ls_toolbartip =  dw_1.GetItemString( li_i, 'toolbartip' )
			
		if isnull( ls_newitem ) or trim( ls_newitem ) = '' then
			MessageBox(gnv_app.iapp_object.DisplayName,'"EZ Menu Text" Field cannot be empty. Please enter a value.',Exclamation!)
			dw_1.ScrolltoRow( li_i )
			dw_1.Setcolumn( "newitems" )
			return
		end if
		if isnull( ls_newtips ) or trim( ls_newtips ) = '' then
			MessageBox(gnv_app.iapp_object.DisplayName,'"EZ Menu Micro Help Text" Field cannot be empty. Please enter a value.',Exclamation!)
			dw_1.ScrolltoRow( li_i )
			dw_1.Setcolumn( "newitemtip" )
			return
		end if
		if isnull( ls_toolbaritem ) or trim( ls_toolbaritem ) = '' then
			MessageBox(gnv_app.iapp_object.DisplayName,'"Toolbar Text" Field cannot be empty. Please enter a value.',Exclamation!)
			dw_1.ScrolltoRow( li_i )
			dw_1.Setcolumn( "toolbaritem" )
			return
		end if
		if isnull( ls_toolbartip ) or trim( ls_toolbartip ) = '' then
			MessageBox(gnv_app.iapp_object.DisplayName,'"Toolbar Micro Help Text" Field cannot be empty. Please enter a value.',Exclamation!)
			dw_1.ScrolltoRow( li_i )
			dw_1.Setcolumn( "toolbartip" )
			return
		end if
	Next
	For li_i = 1 To li_Count
		ls_newitem = dw_1.GetItemString( li_i, 'newitems' )
		ls_newtips = dw_1.GetItemString( li_i, 'newitemtip' )
		ls_Parent = dw_1.GetItemString( li_i, 'parentmenu' )
		ls_name = dw_1.GetItemString( li_i, 'toolbarname' )
		ls_pic = dw_1.GetItemString( li_i, 'newmenuico' )
		If isnumber( dw_1.GetItemString( li_i, 'iconumber1' ) ) Then ls_pic = dw_1.GetItemString( li_i, 'iconumber1' )
		
		ls_toolbarico = dw_1.GetItemString( li_i, 'toolbarico' )
		If isnumber( dw_1.GetItemString( li_i, 'iconumber2' ) ) Then ls_toolbarico = dw_1.GetItemString( li_i, 'iconumber2' )
		
		ls_toolbaritem = dw_1.GetItemString( li_i, 'toolbaritem' )
		ls_toolbartip =  dw_1.GetItemString( li_i, 'toolbartip' )
		
		If dw_1.getitemstatus(li_i, 0, primary! ) = DataModified! Or dw_1.getitemstatus(li_i, 0, primary! ) = NewModified! Then
			If Not( isnull( ls_newitem ) Or trim( ls_newitem ) = '' ) Then
				gnv_user_option.of_set_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TEXT' ,ls_newitem )
			End If
			If Not( isnull( ls_newtips ) Or trim( ls_newtips ) = '' ) Then
				gnv_user_option.of_set_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TIP' ,ls_newtips )
			End If		
			If Not( isnull( ls_pic ) Or trim( ls_pic ) = '' ) Then
//				ls_temp = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_ICON' , FALSE )
//				If IsNumber( ls_Temp ) Then	ls_pic = ls_Temp
				gnv_user_option.of_set_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_ICON' ,ls_pic )
			End If		
		End If
		If dw_1.getitemstatus(li_i, 'toolbarico', primary! ) = DataModified! Or dw_1.getitemstatus(li_i, 'toolbarico', primary! ) = NewModified! Then
			If Not( isnull( ls_toolbarico ) Or trim( ls_toolbarico ) = '' ) Then
//				ls_temp = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TOOLBARICON' , FALSE )
//				If IsNumber( ls_Temp ) Then	ls_toolbarico = ls_Temp
				gnv_user_option.of_set_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TOOLBARICON' ,ls_toolbarico )
			End If		
		End If	
		If dw_1.getitemstatus(li_i, 'toolbaritem', primary! ) = DataModified! Or dw_1.getitemstatus(li_i, 'toolbaritem', primary! ) = NewModified! Then
			If Not( isnull( ls_toolbaritem ) Or trim( ls_toolbaritem ) = '' ) Then
				gnv_user_option.of_set_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TOOLBARITEMTEXT' ,ls_toolbaritem )
			End If	
		End If
		If dw_1.getitemstatus(li_i, 'toolbartip', primary! ) = DataModified! Or dw_1.getitemstatus(li_i, 'toolbartip', primary! ) = NewModified! Then
			If Not( isnull( ls_toolbartip ) Or trim( ls_toolbartip ) = '' ) Then
				gnv_user_option.of_set_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TOOLBARITEMTIP' ,ls_toolbartip )
			End If	
		End If
	Next
	gnv_user_option.of_viewid_save( )
	dw_1.ResetUpdate( )
End If

If dw_2.ModifiedCount( ) > 0 Then
	
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'SHOWTOOLBAR' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'showtoolbar' ) ) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'SHOWMAINTOOLBAR' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'showmaintoolbar' )) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'showezmenuicon' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'showicon' )) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'showcustomizetoolbartexticontips' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'customizetoolbar' )) )
	
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'backgroundcolor' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'backgroundcolor' ) ) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'headfontname' ,  dw_2.GetItemString( dw_2.GetRow( ), 'headfontname' )) 
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'headfontsize' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'headfontsize' ) ) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'headfontcolor' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'headfontcolor' )) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'headbackcolor' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'headbackcolor' ) ) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'headfontbold' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'headfontbold' )) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'headfontitalic' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'headfontitalic' )) )
	
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'rowfontname' ,  dw_2.GetItemString( dw_2.GetRow( ), 'rowfontname' )) 
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'rowfontsize' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'rowfontsize' ) ) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'rowfontcolor' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'rowfontcolor' )) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'rowbackcolor' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'rowbackcolor' ) ) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'rowfontbold' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'rowfontbold' )) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'rowfontitalic' , string(dw_2.GetItemNumber( dw_2.GetRow( ), 'rowfontitalic' )) )
	gnv_user_option.of_Set_Option_value( Is_User, 'EZMENU_' + 'ezmenutitle' , dw_2.GetItemString( dw_2.GetRow( ), 'ezmenutitle' )) 
	
	gnv_user_option.of_Save( )
	dw_2.ResetUpdate( )
	

	
	If  IsValid( w_MDI ) Then
		If dw_2.GetItemNumber( dw_2.GetRow( ), 'customizetoolbar' ) = 0 Then w_mdi.of_restore_toolbar_attr( )
		w_mdi.of_ShowToolbar( dw_2.GetItemNumber( dw_2.GetRow( ), 'showtoolbar' ) = 1 )
		w_mdi.of_Refresh_ezmenu_screen( )
	End If
End If

If  IsValid( w_MDI ) Then
	w_mdi.Event ue_RefreshEZMenu( )
End If

end event

type dw_1 from u_dw within w_ezmenu_painter
integer x = 64
integer y = 864
integer width = 4032
integer height = 1472
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ezmenu_setting"
boolean hscrollbar = true
boolean ib_showtipshelp = false
end type

event clicked;call super::clicked;If Row > 0 Then SetRow( Row ) 

If dwo.Name = 'compute_2' Then
	If MessageBox( 'Tips', 'Are you sure you want to use the default setting?', question!, yesno!, 1 ) = 1 Then
		SetItem( Row, 'newitems', of_GetString( This.object.items[row], '' ) )
	End If
	
End If


If dwo.Name = 'compute_1' Then
	If MessageBox( 'Tips', 'Are you sure you want to use the default setting?', question!, yesno!, 1 ) = 1 Then
		SetItem( Row, 'newitemtip', of_GetString( This.object.items[row], 'last' ) )
	End If
	
End If

//If isnumber(ls_tv_icon) Then //From Picture Painter //Added By Ken.Guo 03/27/2013
//	inv_utils.of_download_picture( Long(ls_tv_icon), ls_pic_file)
String ls_icon,ls_new_icon, ls_pic_file
str_picture lstr_picture,lstr_picture_new


If dwo.name = 'c_select1' Then
	ls_icon = This.GetitemString(row,'iconumber1')
	if AppeonGetClientType() = "PB" then
	
		If  isnumber(ls_icon) Then lstr_picture.al_pic_id = Long( ls_icon )  
		lstr_picture.as_type = 'select'   
		
		Openwithparm(w_picture_painter, lstr_picture)
		
	Else	
		If  isnumber(ls_icon) Then  //For Picture Painter
			lstr_picture.al_pic_id = Long(ls_icon)
			lstr_picture.ab_support_picture_painter = True
		Else //For system picture.
			lstr_picture.as_pic_file  = This.GetitemString(row,'newmenuico')
			lstr_picture.ab_support_picture_painter = True		
		End If
		OpenwithParm(w_icon_select,lstr_picture)
	End If
	
	If isvalid(Message.powerobjectparm ) Then
		lstr_picture_new = Message.Powerobjectparm
		If lstr_picture_new.al_pic_id > 0 Then
			inv_utils.of_download_picture( Long( lstr_picture_new.al_pic_id), ls_pic_file)
			This.SetItem(row,'iconumber1', String(lstr_picture_new.al_pic_id)) 
			This.SetItem(row,'newmenuico', ls_pic_file) 
		ElseIf lstr_picture_new.as_pic_file <> '' Then
			This.SetItem(row,'newmenuico', lstr_picture_new.as_pic_file)
			This.SetItem(row,'iconumber1', '' )
		End If
	End If

End If

If dwo.Name = 'compute_3' Then
	If MessageBox( 'Tips', 'Are you sure you want to use the default setting?', question!, yesno!, 1 ) = 1 Then
		SetItem( Row, 'newmenuico', This.object.menuico[row] )
		This.SetItem(row,'iconumber1', '' )
	End If
	
End If

If dwo.name = 'c_select2' Then
	ls_icon = This.GetitemString(row,'iconumber2')
	if AppeonGetClientType() = "PB" then
	
		If  isnumber(ls_icon) Then lstr_picture.al_pic_id = Long( ls_icon )  
		lstr_picture.as_type = 'select'   
		
		Openwithparm(w_picture_painter, lstr_picture)
		
	Else	
		If  isnumber(ls_icon) Then  //For Picture Painter
			lstr_picture.al_pic_id = Long(ls_icon)
			lstr_picture.ab_support_picture_painter = True
		Else //For system picture.
			lstr_picture.as_pic_file  = This.GetitemString(row,'toolbarico')
			lstr_picture.ab_support_picture_painter = True		
		End If
		OpenwithParm(w_icon_select,lstr_picture)
	End If
	If isvalid(Message.powerobjectparm ) Then
		lstr_picture_new = Message.Powerobjectparm
		If lstr_picture_new.al_pic_id > 0 Then
			inv_utils.of_download_picture( Long( lstr_picture_new.al_pic_id), ls_pic_file)
			This.SetItem(row,'iconumber2', String(lstr_picture_new.al_pic_id)) 
			This.SetItem(row,'toolbarico', ls_pic_file) 
		ElseIf lstr_picture_new.as_pic_file <> '' Then
			This.SetItem(row,'toolbarico', lstr_picture_new.as_pic_file)
			This.SetItem(row,'iconumber2', '' )

		End If
	End If
End If
If dwo.Name = 'c_toolbaricondefault' Then
	If MessageBox( 'Tips', 'Are you sure you want to use the default setting?', question!, yesno!, 1 ) = 1 Then
		SetItem( Row, 'toolbarico', This.object.menuico[row]  )
		This.SetItem(row,'iconumber2', '' )
	End If
	
End If

If dwo.Name = 'c_toolbartextdefault' Then
	If MessageBox( 'Tips', 'Are you sure you want to use the default setting?', question!, yesno!, 1 ) = 1 Then
		SetItem( Row, 'toolbaritem', of_GetString( This.object.items[row], '' ) )
	End If
	
End If


If dwo.Name = 'c_toolbartip' Then
	If MessageBox( 'Tips', 'Are you sure you want to use the default setting?', question!, yesno!, 1 ) = 1 Then
		SetItem( Row, 'toolbartip', of_GetString( This.object.items[row], 'last' ) )
	End If
	
End If

end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 And RowCount( ) > 0 Then
	This.SelectRow( 0, False )
	This.SelectRow( CurrentRow, True )
End If
end event

event losefocus;call super::losefocus;This.AcceptText( )
end event

type dw_2 from u_dw within w_ezmenu_painter
integer x = 23
integer y = 156
integer width = 4078
integer height = 692
integer taborder = 20
string dataobject = "d_ezmenu_personal_setting"
boolean vscrollbar = false
boolean border = false
boolean ib_showtipshelp = false
end type

event losefocus;call super::losefocus;AcceptText( )
end event

event clicked;call super::clicked;String				ls_Object, ls_column, ls_column2
Long				ll_color, ll_Value
Integer			li_return

If row > 0 Then
	ls_Object = dwo.Name
	
	Choose Case lower(ls_Object)
		Case 't_backgroundcolor'
			ls_column = 'backgroundcolor'
		Case 't_headtextcolor'
			ls_column = 'headfontcolor'
		Case 't_headbackcolor'
			ls_column = 'headbackcolor'
		case 't_rowtextcolor'
			ls_column = 'rowfontcolor'
		case 't_rowbackcolor'
			ls_column = 'rowbackcolor'
		case 'head_bold_down'
			ls_column2 = 'headfontbold'
			ll_color = 1
		case 'head_bold_up'
			ls_column2 = 'headfontbold'
			ll_color = 0
		case 'head_italic_down'
			ls_column2 = 'headfontitalic'
			ll_color = 1
		case 'head_italic_up'
			ls_column2 = 'headfontitalic'
			ll_color = 0
		case 'row_bold_down'
			ls_column2 = 'rowfontbold'
			ll_color = 1
		case 'row_bold_up'
			ls_column2 = 'rowfontbold'
			ll_color = 0
		case 'row_italy_down'
			ls_column2 = 'rowfontitalic'
			ll_color = 1
		case 'row_italy_up'
			ls_column2 = 'rowfontitalic'
			ll_color = 0
//		case 'b_default'
//			This.Object.backgroundcolor[row] =Long( This.Object.backgroundcolor.Initial )
//			This.Object.headfontcolor[row] = Long( This.Object.headfontcolor.Initial )
//			This.Object.headbackcolor[row] = Long(This.Object.headbackcolor.Initial)
//			This.Object.rowfontcolor[row] = Long(This.Object.rowfontcolor.Initial)
//			This.Object.rowbackcolor[row] =Long( This.Object.rowbackcolor.Initial)
//			This.Object.headfontbold[row] =Long( This.Object.headfontbold.Initial)
//			This.Object.headfontitalic[row] =Long( This.Object.headfontitalic.Initial)
//			This.Object.rowfontbold[row] = Long(This.Object.rowfontbold.Initial)
//			This.Object.rowfontitalic[row] = Long(This.Object.rowfontitalic.Initial)
//			This.Object.headfontsize[row] = Long(This.Object.headfontsize.Initial)
//			This.Object.rowfontsize[row] = Long(This.Object.rowfontsize.Initial)
//			This.Object.headfontname[row] =String( This.Object.headfontname.Initial )
//			This.Object.rowfontname[row] = String(This.Object.rowfontname.Initial)
//			This.Object.ezmenutitle[row] = String(This.Object.ezmenutitle.Initial)
	End Choose
	If Len( ls_column2 ) > 1 Then
		ll_value = GetItemNumber( row, ls_column2 )
		ll_Color =  1	- ll_value	
		SetItem( row, ls_column2, ll_Color )
	End If
	
	If Len( ls_column ) > 1 Then
		ll_value = GetItemNumber( row, ls_column )
		ll_Color = ll_value
		li_return = ChooseColor(  ll_color )
		If li_Return = 1 And ll_color <> ll_value Then SetItem( row, ls_column, ll_Color )
	End If
End If

AcceptText( )



end event

event constructor;call super::constructor;DatawindowChild		ldwc_child

GetChild( 'headfontname', ldwc_Child )

uo_font_list.idwc_fonts.RowsCopy(1,uo_font_list.idwc_fonts.RowCount(),primary!,ldwc_Child,1,primary!)


GetChild( 'rowfontname', ldwc_Child )
uo_font_list.idwc_fonts.RowsCopy(1,uo_font_list.idwc_fonts.RowCount(),primary!,ldwc_Child,1,primary!)
end event

event buttonclicked;call super::buttonclicked;
//Start Code Change ----08.15.2014 #V14.2 maha - moved from clicked event

if dwo.name =  'b_default' then
	This.Object.backgroundcolor[row] =Long( This.Object.backgroundcolor.Initial )
	This.Object.headfontcolor[row] = Long( This.Object.headfontcolor.Initial )
	This.Object.headbackcolor[row] = Long(This.Object.headbackcolor.Initial)
	This.Object.rowfontcolor[row] = Long(This.Object.rowfontcolor.Initial)
	This.Object.rowbackcolor[row] =Long( This.Object.rowbackcolor.Initial)
	This.Object.headfontbold[row] =Long( This.Object.headfontbold.Initial)
	This.Object.headfontitalic[row] =Long( This.Object.headfontitalic.Initial)
	This.Object.rowfontbold[row] = Long(This.Object.rowfontbold.Initial)
	This.Object.rowfontitalic[row] = Long(This.Object.rowfontitalic.Initial)
	This.Object.headfontsize[row] = Long(This.Object.headfontsize.Initial)
	This.Object.rowfontsize[row] = Long(This.Object.rowfontsize.Initial)
	This.Object.headfontname[row] =String( This.Object.headfontname.Initial )
	This.Object.rowfontname[row] = String(This.Object.rowfontname.Initial)
	This.Object.ezmenutitle[row] = String(This.Object.ezmenutitle.Initial)
end if
end event

type gb_1 from groupbox within w_ezmenu_painter
integer x = 18
integer y = 92
integer width = 4123
integer height = 2280
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "EZ Menu Settings (Affecting All Users)"
end type

type gb_2 from groupbox within w_ezmenu_painter
integer x = 18
integer y = 880
integer width = 3223
integer height = 1492
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "EZ Menu System Level Settings(Affecting All Users)"
end type

