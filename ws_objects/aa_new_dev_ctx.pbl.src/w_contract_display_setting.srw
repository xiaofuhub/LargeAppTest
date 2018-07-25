$PBExportHeader$w_contract_display_setting.srw
forward
global type w_contract_display_setting from w_popup
end type
type rb_to_do_list_right from radiobutton within w_contract_display_setting
end type
type rb_to_do_list_left from radiobutton within w_contract_display_setting
end type
type st_to_do_list from statictext within w_contract_display_setting
end type
type cbx_to_do_list from checkbox within w_contract_display_setting
end type
type rb_document_right from radiobutton within w_contract_display_setting
end type
type rb_document_left from radiobutton within w_contract_display_setting
end type
type st_parent_child_tree from statictext within w_contract_display_setting
end type
type st_document_preview from statictext within w_contract_display_setting
end type
type cbx_powerfilter from checkbox within w_contract_display_setting
end type
type rb_standard_results_list from radiobutton within w_contract_display_setting
end type
type rb_calendar from radiobutton within w_contract_display_setting
end type
type cb_close from commandbutton within w_contract_display_setting
end type
type cbx_search_criteria from checkbox within w_contract_display_setting
end type
type cbx_display_document_preview from checkbox within w_contract_display_setting
end type
type cbx_display_contract_parent_child_tree from checkbox within w_contract_display_setting
end type
type cb_apply from commandbutton within w_contract_display_setting
end type
type gb_browse_screen from groupbox within w_contract_display_setting
end type
type gb_pane_settings from groupbox within w_contract_display_setting
end type
type gb_to_do_list from groupbox within w_contract_display_setting
end type
type gb_document from groupbox within w_contract_display_setting
end type
type rb_tree_right from radiobutton within w_contract_display_setting
end type
type rb_tree_left from radiobutton within w_contract_display_setting
end type
type gb_parent_child_tree from groupbox within w_contract_display_setting
end type
type gb_position_settings from groupbox within w_contract_display_setting
end type
end forward

global type w_contract_display_setting from w_popup
integer width = 1458
integer height = 1556
string title = "Contract Search Tab Display Setting"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean center = true
rb_to_do_list_right rb_to_do_list_right
rb_to_do_list_left rb_to_do_list_left
st_to_do_list st_to_do_list
cbx_to_do_list cbx_to_do_list
rb_document_right rb_document_right
rb_document_left rb_document_left
st_parent_child_tree st_parent_child_tree
st_document_preview st_document_preview
cbx_powerfilter cbx_powerfilter
rb_standard_results_list rb_standard_results_list
rb_calendar rb_calendar
cb_close cb_close
cbx_search_criteria cbx_search_criteria
cbx_display_document_preview cbx_display_document_preview
cbx_display_contract_parent_child_tree cbx_display_contract_parent_child_tree
cb_apply cb_apply
gb_browse_screen gb_browse_screen
gb_pane_settings gb_pane_settings
gb_to_do_list gb_to_do_list
gb_document gb_document
rb_tree_right rb_tree_right
rb_tree_left rb_tree_left
gb_parent_child_tree gb_parent_child_tree
gb_position_settings gb_position_settings
end type
global w_contract_display_setting w_contract_display_setting

type variables
Boolean 			ibn_modified  = false,  ibn_position = False, ibn_position_other = False
end variables

on w_contract_display_setting.create
int iCurrent
call super::create
this.rb_to_do_list_right=create rb_to_do_list_right
this.rb_to_do_list_left=create rb_to_do_list_left
this.st_to_do_list=create st_to_do_list
this.cbx_to_do_list=create cbx_to_do_list
this.rb_document_right=create rb_document_right
this.rb_document_left=create rb_document_left
this.st_parent_child_tree=create st_parent_child_tree
this.st_document_preview=create st_document_preview
this.cbx_powerfilter=create cbx_powerfilter
this.rb_standard_results_list=create rb_standard_results_list
this.rb_calendar=create rb_calendar
this.cb_close=create cb_close
this.cbx_search_criteria=create cbx_search_criteria
this.cbx_display_document_preview=create cbx_display_document_preview
this.cbx_display_contract_parent_child_tree=create cbx_display_contract_parent_child_tree
this.cb_apply=create cb_apply
this.gb_browse_screen=create gb_browse_screen
this.gb_pane_settings=create gb_pane_settings
this.gb_to_do_list=create gb_to_do_list
this.gb_document=create gb_document
this.rb_tree_right=create rb_tree_right
this.rb_tree_left=create rb_tree_left
this.gb_parent_child_tree=create gb_parent_child_tree
this.gb_position_settings=create gb_position_settings
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_to_do_list_right
this.Control[iCurrent+2]=this.rb_to_do_list_left
this.Control[iCurrent+3]=this.st_to_do_list
this.Control[iCurrent+4]=this.cbx_to_do_list
this.Control[iCurrent+5]=this.rb_document_right
this.Control[iCurrent+6]=this.rb_document_left
this.Control[iCurrent+7]=this.st_parent_child_tree
this.Control[iCurrent+8]=this.st_document_preview
this.Control[iCurrent+9]=this.cbx_powerfilter
this.Control[iCurrent+10]=this.rb_standard_results_list
this.Control[iCurrent+11]=this.rb_calendar
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.cbx_search_criteria
this.Control[iCurrent+14]=this.cbx_display_document_preview
this.Control[iCurrent+15]=this.cbx_display_contract_parent_child_tree
this.Control[iCurrent+16]=this.cb_apply
this.Control[iCurrent+17]=this.gb_browse_screen
this.Control[iCurrent+18]=this.gb_pane_settings
this.Control[iCurrent+19]=this.gb_to_do_list
this.Control[iCurrent+20]=this.gb_document
this.Control[iCurrent+21]=this.rb_tree_right
this.Control[iCurrent+22]=this.rb_tree_left
this.Control[iCurrent+23]=this.gb_parent_child_tree
this.Control[iCurrent+24]=this.gb_position_settings
end on

on w_contract_display_setting.destroy
call super::destroy
destroy(this.rb_to_do_list_right)
destroy(this.rb_to_do_list_left)
destroy(this.st_to_do_list)
destroy(this.cbx_to_do_list)
destroy(this.rb_document_right)
destroy(this.rb_document_left)
destroy(this.st_parent_child_tree)
destroy(this.st_document_preview)
destroy(this.cbx_powerfilter)
destroy(this.rb_standard_results_list)
destroy(this.rb_calendar)
destroy(this.cb_close)
destroy(this.cbx_search_criteria)
destroy(this.cbx_display_document_preview)
destroy(this.cbx_display_contract_parent_child_tree)
destroy(this.cb_apply)
destroy(this.gb_browse_screen)
destroy(this.gb_pane_settings)
destroy(this.gb_to_do_list)
destroy(this.gb_document)
destroy(this.rb_tree_right)
destroy(this.rb_tree_left)
destroy(this.gb_parent_child_tree)
destroy(this.gb_position_settings)
end on

event pfc_preopen;call super::pfc_preopen;String 	ls_browse_screen_results_style,ls_display_contract_parent_child_tree,ls_display_document_preview
Integer 	li_mode
String 	ls_powerfilter, ls_search_criteria, ls_position, ls_to_do_list

//Browse Screen Results Style  
ls_browse_screen_results_style = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style" )

//null
IF isnull(ls_browse_screen_results_style) Or trim(ls_browse_screen_results_style ) = '' Then
	ibn_modified  = True
	ibn_position = True
	
	//got original default values.
	Select contract_display_mode
	Into :li_mode
	From security_users
	Where user_id = :gs_user_id ;
	
	Choose Case li_mode
		Case 0
			cbx_display_contract_parent_child_tree.checked = False
			rb_standard_results_list.checked = True
			rb_calendar.checked = False
			cbx_display_contract_parent_child_tree.enabled = True
			cbx_to_do_list.enabled = True														
			cbx_display_document_preview.enabled = True
			cbx_search_criteria.checked = True						//default value
			
			rb_tree_right.Enabled = False														
			rb_tree_left.Enabled = False																
			rb_to_do_list_left.enabled = True													
			rb_to_do_list_right.enabled = True												
		Case 1
			cbx_display_contract_parent_child_tree.checked = True			
			rb_standard_results_list.checked = True			
			rb_calendar.checked = False
			cbx_display_contract_parent_child_tree.enabled = True
			cbx_to_do_list.enabled = True																	
			cbx_display_document_preview.enabled = True			
			cbx_search_criteria.checked = True						//default value
			rb_tree_right.Enabled = True														
			rb_tree_left.Enabled = True														 
			rb_to_do_list_left.enabled = True												
			rb_to_do_list_right.enabled = True													
		Case 2
			cbx_display_contract_parent_child_tree.checked = False
			rb_standard_results_list.checked = False
			rb_calendar.checked = True		
			cbx_display_contract_parent_child_tree.enabled = False
			cbx_to_do_list.enabled = False														
			cbx_display_document_preview.enabled = False
			cbx_search_criteria.checked = True						//default value
			rb_tree_right.Enabled = False													
			rb_tree_left.Enabled = False															
			rb_document_left.Enabled = False												
			rb_document_right.Enabled = False												
			rb_to_do_list_left.enabled = False												
			rb_to_do_list_right.enabled = False													
	 End	Choose 
Else
	// '1'
	If 	ls_browse_screen_results_style = '1' 	Then
		rb_calendar.checked = False
		rb_standard_results_list.checked = True	
		cbx_display_contract_parent_child_tree.enabled = True
		cbx_display_document_preview.enabled = True		
		cbx_powerfilter.enabled = True
		cbx_to_do_list.enabled = True														
	Else
		rb_calendar.checked = True
		rb_standard_results_list.checked = False		
		cbx_display_contract_parent_child_tree.enabled = False
		cbx_display_document_preview.enabled = False
		cbx_to_do_list.enabled = False													
		cbx_powerfilter.enabled = False
	End If
		
	//Contract Parent Child Tree
	ls_display_contract_parent_child_tree = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Contract_Parent_Child_Tree" )
	//Display Document Preview
	ls_display_document_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Document_Preview" )
	
	If Not Isnull(ls_display_contract_parent_child_tree) And ls_display_contract_parent_child_tree = '1' Then
		cbx_display_contract_parent_child_tree.checked = True
		rb_tree_right.Enabled = True													
		rb_tree_left.Enabled = True															
	Else
		cbx_display_contract_parent_child_tree.checked = False
		rb_tree_right.Enabled = False												
		rb_tree_left.Enabled = False													
	End If

	If Not Isnull(ls_display_document_preview) And ls_display_document_preview = '1' Then
		cbx_display_document_preview.checked = True
		rb_document_left.Enabled = True												
		rb_document_right.Enabled = True												
	Else
		cbx_display_document_preview.checked = False
		rb_document_left.Enabled = False												
		rb_document_right.Enabled = False											
	End If	

	//To Do List						
	ls_to_do_list = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_To_Do_List" )
	If  Isnull(ls_to_do_list) Or Trim(ls_to_do_list)  = '' Then 
		ibn_modified  = True
		cbx_to_do_list.checked = False	
		rb_to_do_list_left.enabled = False													
		rb_to_do_list_right.enabled = False												
	ElseIf  ls_to_do_list = '1' Then
		cbx_to_do_list.checked = True
		rb_to_do_list_left.enabled = True												
		rb_to_do_list_right.enabled = True												
	Else
		cbx_to_do_list.checked = False
		rb_to_do_list_left.enabled = False												
		rb_to_do_list_right.enabled = False												
	End IF
End IF

//Turn On Search Criteria
ls_search_criteria = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_Criteria" )
If  Isnull(ls_search_criteria) Or Trim(ls_search_criteria)  = '' Then 
	ibn_modified  = True
	ibn_position_other = True 	
	cbx_search_criteria.checked = True				//default
ElseIf  ls_search_criteria = '1' Then
	cbx_search_criteria.checked = True
Else
	cbx_search_criteria.checked = False
End IF

//PowerFilter: 
ls_powerfilter = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_PowerFilter" )
If  Isnull(ls_powerfilter) Or Trim(ls_powerfilter)  = '' Then 
	cbx_powerfilter.checked = False	
	gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_PowerFilter",'1' )
	gnv_user_option.of_save( )	
ElseIf  ls_powerfilter = '1' Then
	cbx_powerfilter.checked = True
Else
	cbx_powerfilter.checked = False
End IF

//the right controls
If w_Mdi.of_security_access(6957) = 0 Then
	rb_calendar.enabled = False
	rb_calendar.checked = False
	rb_standard_results_list.checked = True
	gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style",'1' )
	gnv_user_option.of_save( )	
End If

//Position Setting
ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting" )
If  Isnull(ls_position) Or Trim(ls_position)  = ''  Then 
	rb_document_left.checked = True
	rb_tree_right.checked = True
	rb_document_right.checked = False
	rb_tree_left.checked = False											
	ibn_modified  = True
	ibn_position = True
ElseIf  trim(ls_position ) = '1' Then
	rb_document_left.checked = True
	rb_tree_right.checked = True
	rb_document_right.checked = False
	rb_tree_left.checked = False				
Else
	rb_document_left.checked = False
	rb_tree_right.checked = False
	rb_document_right.checked = True
	rb_tree_left.checked = True										
End If

//Position Setting the To  Do List Pane. and this is always reverse the positions of the document view pane.
ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting_ToDoList" )
If  Isnull(ls_position) Or Trim(ls_position)  = ''  Then 
	ibn_modified  = True
	ibn_position_other = True 
	IF rb_tree_right.checked = True then 
		rb_to_do_list_left.checked = False	
		rb_to_do_list_right.checked = True
	Else
		rb_to_do_list_left.checked = True	
		rb_to_do_list_right.checked = False		
	End If
ElseIf  trim(ls_position ) = '1' Then
	rb_to_do_list_left.checked = True	
	rb_to_do_list_right.checked = False
Else
	rb_to_do_list_left.checked = False	
	rb_to_do_list_right.checked = True	
End If
end event

type rb_to_do_list_right from radiobutton within w_contract_display_setting
integer x = 1093
integer y = 1212
integer width = 224
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Right "
end type

event clicked;String 	ls_position

ibn_modified  = True
If rb_to_do_list_right.checked Then 
	If cbx_display_document_preview.checked = True then 
		rb_document_right.checked  =  False
		rb_document_left.checked = True
		rb_tree_right.checked = True
		rb_tree_left.checked = False	
	End If
End If


ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting_ToDoList" )
IF not isnull(ls_position) and ls_position = '0' then 
	ibn_position_other = False
ElseIF not isnull(ls_position) and ls_position = '1' then 
	ibn_position_other = True
End If
end event

type rb_to_do_list_left from radiobutton within w_contract_display_setting
integer x = 827
integer y = 1212
integer width = 224
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Left "
end type

event clicked;string 	ls_position

ibn_modified  = True
If rb_to_do_list_left.checked Then 
	If cbx_display_document_preview.checked = True then 
		rb_document_left.checked = false
		rb_document_right.checked = True
		rb_tree_left.checked = True
		rb_tree_right.checked = false
		ibn_position = True		
	End If
End If

ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting_ToDoList" )
IF not isnull(ls_position) and ls_position = '0' then 
	ibn_position_other = True
ElseIF not isnull(ls_position) and ls_position = '1' then 
	ibn_position_other = False
End If
end event

type st_to_do_list from statictext within w_contract_display_setting
integer x = 59
integer y = 1220
integer width = 608
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = " To Do List"
boolean focusrectangle = false
end type

type cbx_to_do_list from checkbox within w_contract_display_setting
integer x = 64
integer y = 700
integer width = 727
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Turn On To Do List"
end type

event clicked;ibn_Modified = true

IF this.checked Then 
	rb_to_do_list_left.Enabled = True															
	rb_to_do_list_right.Enabled = True																	
Else
	rb_to_do_list_left.Enabled = False															
	rb_to_do_list_right.Enabled = False															
End If
end event

type rb_document_right from radiobutton within w_contract_display_setting
integer x = 1093
integer y = 1036
integer width = 224
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Right "
end type

event clicked;String 	ls_position

ibn_modified  = True
If rb_document_right.checked Then 
	rb_tree_right.checked  =  False
	rb_tree_left.checked = True
	rb_to_do_list_left.checked = True						
	rb_to_do_list_right.checked = false
	ibn_position_other = True
End If

ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting" )
IF not isnull(ls_position) and ls_position = '0' then 
	ibn_position = False
Else
	ibn_position = True
End If
end event

type rb_document_left from radiobutton within w_contract_display_setting
integer x = 827
integer y = 1036
integer width = 197
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Left "
end type

event clicked;String 		ls_position

ibn_modified  = True
If rb_document_left.checked Then 
	rb_tree_left.checked = false
	rb_tree_right.checked = True
	rb_to_do_list_left.checked = false					
	rb_to_do_list_right.checked = True			
	ibn_position_other = True
End If

ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting" )
IF not isnull(ls_position) and ls_position = '0' then 
	ibn_position = True
Else
	ibn_position = False
End If
end event

type st_parent_child_tree from statictext within w_contract_display_setting
integer x = 59
integer y = 1128
integer width = 663
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = " Contract Parent Child Tree "
boolean focusrectangle = false
end type

type st_document_preview from statictext within w_contract_display_setting
integer x = 59
integer y = 1036
integer width = 489
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = " Document Preview "
boolean focusrectangle = false
end type

type cbx_powerfilter from checkbox within w_contract_display_setting
integer x = 64
integer y = 584
integer width = 731
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Turn On Power Filter"
end type

event clicked;ibn_Modified = true
end event

type rb_standard_results_list from radiobutton within w_contract_display_setting
integer x = 64
integer y = 116
integer width = 658
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Standard Results List   "
end type

event clicked;ibn_Modified = true

IF this.checked = True Then
	rb_calendar.checked = False
	cbx_display_contract_parent_child_tree.enabled = True
	cbx_display_document_preview.enabled = True
	cbx_powerfilter.enabled = True
	cbx_to_do_list.enabled = True
	
	If cbx_display_contract_parent_child_tree.checked Then 
		rb_tree_right.Enabled = True														
		rb_tree_left.Enabled = True															
	End IF	
	
	If cbx_display_document_preview.checked Then 
		rb_document_left.Enabled = True													
		rb_document_right.Enabled = True											
	End If
	
	If cbx_to_do_list.checked Then 
		rb_to_do_list_left.Enabled = True													
		rb_to_do_list_right.Enabled = True												
	End If	
Else
	rb_calendar.checked = True
	cbx_display_contract_parent_child_tree.enabled = False
	cbx_display_document_preview.enabled = False
	cbx_powerfilter.enabled = False
	cbx_to_do_list.enabled = False
	
	rb_tree_right.Enabled = False														
	rb_tree_left.Enabled = False															
	rb_document_left.Enabled = False													
	rb_document_right.Enabled = False												
	rb_to_do_list_left.Enabled = False													
	rb_to_do_list_right.Enabled = False		
End If
end event

type rb_calendar from radiobutton within w_contract_display_setting
integer x = 731
integer y = 116
integer width = 379
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calendar"
end type

event clicked;ibn_Modified = true
IF this.checked = True Then
	rb_standard_results_list.checked = False
	cbx_display_contract_parent_child_tree.enabled = False
	cbx_display_document_preview.enabled = False
	cbx_powerfilter.enabled = False
	cbx_to_do_list.enabled = False

	rb_tree_right.Enabled = False													
	rb_tree_left.Enabled = False														
	rb_document_left.Enabled = False												
	rb_document_right.Enabled = False												
	rb_to_do_list_left.Enabled = False													
	rb_to_do_list_right.Enabled = False											
Else
	rb_standard_results_list.checked = True
	cbx_display_contract_parent_child_tree.enabled = True
	cbx_display_document_preview.enabled = True
	cbx_powerfilter.enabled = True
	cbx_to_do_list.enabled = True
End If

end event

type cb_close from commandbutton within w_contract_display_setting
integer x = 1065
integer y = 1348
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;Close( parent )

end event

type cbx_search_criteria from checkbox within w_contract_display_setting
integer x = 64
integer y = 812
integer width = 727
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Turn On Search Criteria"
end type

event clicked;ibn_Modified = true
end event

type cbx_display_document_preview from checkbox within w_contract_display_setting
integer x = 64
integer y = 472
integer width = 1061
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Turn On Display Document Preview"
end type

event clicked;ibn_Modified = true

If this.checked Then 
	rb_document_left.Enabled = True												
	rb_document_right.Enabled = True					
	
	If rb_document_left.checked = True Then 
		rb_document_left.event clicked( )
	End If
	
	IF rb_document_right.checked =  True Then 
		rb_document_right.event clicked( )
	End If
Else
	rb_document_left.Enabled = False													
	rb_document_right.Enabled = False												
End If
end event

type cbx_display_contract_parent_child_tree from checkbox within w_contract_display_setting
integer x = 64
integer y = 360
integer width = 1198
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Turn On Display Contract Parent Child Tree"
end type

event clicked;ibn_Modified = true

IF this.checked Then 
	rb_tree_right.Enabled = True														
	rb_tree_left.Enabled = True															
Else
	rb_tree_right.Enabled = False														
	rb_tree_left.Enabled = False														
End If
end event

type cb_apply from commandbutton within w_contract_display_setting
integer x = 672
integer y = 1348
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;String 	ls_browse_screen_results_style,ls_display_contract_parent_child_tree,ls_display_document_preview
String 	ls_powerfilter, ls_tmp, ls_search_criteria,	ls_position, ls_to_do_list
Integer 	li_rtn

li_rtn = 0 
If ibn_position = True Or ibn_position_other = True Then 
	li_rtn 	=	Messagebox(gnv_app.iapp_object.DisplayName,"You have changed the Position Settings.~r~n" + &
				"In order to update the setting, the system will close and reopen the Contract window now.~r~n~r~n " +  &
				"Do you want continue? ", Question!, YesNo!  ) 
	If li_rtn = 2 Then
		Return 
	End If
End If 				

If ibn_Modified = True Then	
	//Browse Screen Results Style  
	ls_tmp = ''
	ls_browse_screen_results_style = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style" )
	IF rb_standard_results_list.checked = True And (not isnull(ls_browse_screen_results_style) and ls_browse_screen_results_style = '1') then 
		//
	ElseIf rb_calendar.checked = True And (not isnull(ls_browse_screen_results_style) and ls_browse_screen_results_style = '0') then 
		//
	Else
		If rb_standard_results_list.checked = True Then
			ls_tmp = '1'
		Else
			ls_tmp = '0'
		End IF
		gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style",ls_tmp )
	End If		
	
	//Turn On Display Contract Parent Child Tree
	ls_tmp = ''
	ls_display_contract_parent_child_tree = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Contract_Parent_Child_Tree" )
	IF cbx_display_contract_parent_child_tree.checked = True And (not isnull(ls_display_contract_parent_child_tree) and ls_display_contract_parent_child_tree = '1') then 
		//
	ElseIf cbx_display_contract_parent_child_tree.checked = False And (not isnull(ls_display_contract_parent_child_tree) and ls_display_contract_parent_child_tree = '0') then 
		//
	Else
		If cbx_display_contract_parent_child_tree.checked = True Then
			ls_tmp = '1'
		Else
			ls_tmp = '0'
		End IF
		gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_Display_Contract_Parent_Child_Tree",ls_tmp )
	End If	
	
	
	// Turn On Display Document Preview
	ls_tmp = ''
	ls_display_document_preview = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Display_Document_Preview" )
	IF cbx_display_document_preview.checked = True And (not isnull(ls_display_document_preview) and ls_display_document_preview = '1') then 
		//
	ElseIf cbx_display_document_preview.checked = False And (not isnull(ls_display_document_preview) and ls_display_document_preview = '0') then 
		//
	Else
		If cbx_display_document_preview.checked = True Then
			ls_tmp = '1'
		Else
			ls_tmp = '0'
		End IF
		gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_Display_Document_Preview",ls_tmp )
	End If		
	
	//Turn On Search Criteria
	ls_tmp = ''
	ls_search_criteria = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_Criteria" )
	IF cbx_search_criteria.checked = True And (not isnull(ls_search_criteria) and ls_search_criteria = '1') then 
		//
	ElseIf cbx_search_criteria.checked = False And (not isnull(ls_search_criteria) and ls_search_criteria = '0') then 
		//
	Else
		If cbx_search_criteria.checked = True Then
			ls_tmp = '1'
		Else
			ls_tmp = '0'
		End IF
		gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_Search_Criteria",ls_tmp )
	End If		
	
	//PowerFilter: 
	ls_tmp = ''
	ls_powerfilter = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_PowerFilter" )
	IF cbx_powerfilter.checked = True And (not isnull(ls_powerfilter) and ls_powerfilter = '1') then 
		//
	ElseIf cbx_powerfilter.checked = False And (not isnull(ls_powerfilter) and ls_powerfilter = '0') then 
		//
	Else
		If cbx_powerfilter.checked = True Then
			ls_tmp = '1'
		Else
			ls_tmp = '0'
		End IF
		gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_PowerFilter",ls_tmp )
	End If		

	//To Do List						//Added By Mark Lee 12/21/2012
	ls_tmp = ''
	ls_to_do_list = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_To_Do_List" )
	IF cbx_to_do_list.checked = True And (not isnull(ls_to_do_list) and ls_to_do_list = '1') then 
		//
	ElseIf cbx_to_do_list.checked = False And (not isnull(ls_to_do_list) and ls_to_do_list = '0') then 
		//
	Else
		If cbx_to_do_list.checked = True Then
			ls_tmp = '1'
		Else
			ls_tmp = '0'
		End IF
		gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_To_Do_List",ls_tmp )
	End If		

	//Position Setting			// 1 : Document Preview left ; 					0 : Document Preview right;
									// 1 : Contract Parent Child Tree right; 		0 : Contract Parent Child Tree Left;
	ls_tmp = ''
	ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting" )
	If rb_document_left.checked = False Or rb_tree_right.checked = False Then 
		ls_tmp = '0'
	Else 
		ls_tmp = '1'
	End If
	gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_Position_Setting",ls_tmp )
	
	ls_tmp = ''
	ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting_ToDoList" )
	If   rb_to_do_list_left.checked = False Then 
		ls_tmp = '0'
	Else 
		ls_tmp = '1'
	End If
	gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Search_Tab_Position_Setting_ToDoList",ls_tmp )
	
	//update 
	gnv_user_option.of_save( )	
End If

If ibn_position = True Or ibn_position_other = True Then 
//	Messagebox(gnv_app.iapp_object.DisplayName,"You have changed the Position Setting.~r~n" + &
//				"In order to update the setting, the system will close and reopen the Contract window now.~r~n~r~n " +  &
//				"Do you want continue? ", Question!, YesNo!  ) 
	If isvalid(w_contract) Then
		w_contract.ib_IsMDIClose = True
		Close(w_contract)
	End If 
	If isvalid(gw_contract) Then
		gw_contract.ib_IsMDIClose = True
		Close(gw_contract)
	End If 
	
	PowerObject lpo_NullParm
	gf_OpenContractFolder(lpo_NullParm)
		
Else
	If isvalid(gw_contract) Then
		gw_contract.tab_contract_details.tabpage_search.of_set_default_bar_position()			//Added By Mark Lee 04/12/2013
		gw_contract.tab_contract_details.tabpage_search.of_set_styles(True)
	End If
End If 

//close window
Close( parent )
end event

type gb_browse_screen from groupbox within w_contract_display_setting
integer x = 18
integer y = 20
integer width = 1381
integer height = 220
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Browse Screen Results Style  "
end type

type gb_pane_settings from groupbox within w_contract_display_setting
integer x = 18
integer y = 272
integer width = 1390
integer height = 652
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pane Settings"
end type

type gb_to_do_list from groupbox within w_contract_display_setting
boolean visible = false
integer x = 41
integer y = 1184
integer width = 1349
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_document from groupbox within w_contract_display_setting
boolean visible = false
integer x = 41
integer y = 1008
integer width = 1349
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
end type

type rb_tree_right from radiobutton within w_contract_display_setting
integer x = 1093
integer y = 1124
integer width = 224
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Right "
end type

event clicked;String 	ls_position

ibn_modified  = True
If rb_tree_right.checked Then 
	rb_document_right.checked  =  False
	rb_document_left.checked = True
	If cbx_display_document_preview.checked = True then 
		rb_to_do_list_left.checked = false					
		rb_to_do_list_right.checked = True		
		ibn_position_other = True		
	End If
End If

ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting" )
IF not isnull(ls_position) and ls_position = '0' then 
	ibn_position = True
Else
	ibn_position = False
End If
end event

type rb_tree_left from radiobutton within w_contract_display_setting
integer x = 827
integer y = 1124
integer width = 224
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Left "
end type

event clicked;string 	ls_position

ibn_modified  = True
If rb_tree_left.checked Then 
	rb_document_left.checked = false
	rb_document_right.checked = True
	If cbx_display_document_preview.checked = True then 
		rb_to_do_list_left.checked = True						
		rb_to_do_list_right.checked = false
		ibn_position_other = True
	End If
End If

ls_position = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Position_Setting" )
IF not isnull(ls_position) and ls_position = '0' then 
	ibn_position = False
Else
	ibn_position = True
End If


end event

type gb_parent_child_tree from groupbox within w_contract_display_setting
boolean visible = false
integer x = 41
integer y = 1096
integer width = 1349
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_position_settings from groupbox within w_contract_display_setting
integer x = 18
integer y = 948
integer width = 1390
integer height = 368
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Position Settings"
end type

