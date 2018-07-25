$PBExportHeader$w_contract_search_filter.srw
forward
global type w_contract_search_filter from w_child
end type
type st_txt from statictext within w_contract_search_filter
end type
type cb_filter3 from commandbutton within w_contract_search_filter
end type
type cb_filter2 from commandbutton within w_contract_search_filter
end type
type cb_filter1 from commandbutton within w_contract_search_filter
end type
type cb_close from commandbutton within w_contract_search_filter
end type
type cb_ok from commandbutton within w_contract_search_filter
end type
type dw_filter from u_dw_contract within w_contract_search_filter
end type
end forward

global type w_contract_search_filter from w_child
string tag = "Contract Quick Filter Setting"
integer width = 2455
integer height = 1500
string title = "Contract Quick Filter Setting"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
event ue_viewfilter ( long al_number )
event ue_renamefilter ( long al_number )
event ue_assignfilter ( long al_number )
event ue_set_as_default ( string as_set_as_default )
st_txt st_txt
cb_filter3 cb_filter3
cb_filter2 cb_filter2
cb_filter1 cb_filter1
cb_close cb_close
cb_ok cb_ok
dw_filter dw_filter
end type
global w_contract_search_filter w_contract_search_filter

type variables
n_cst_string 						inv_string
m_contract_search_filter 		im_Filter
String 								is_sql
end variables

forward prototypes
public subroutine of_get_filter ()
public subroutine of_popmenu (string as_filter)
public subroutine of_set_filter ()
public subroutine of_set_as_default_button_text ()
end prototypes

event ue_viewfilter(long al_number);//====================================================================
// Event: ue_viewfilter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_number
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/07/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 		ls_sql , ls_err, ls_sort


ls_sort = string(al_number)
dw_filter.reset( )
dw_filter.retrieve(gs_user_id, ls_sort)


end event

event ue_renamefilter(long al_number);//====================================================================
// Event: ue_renamefilter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_number
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/07/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_OldName,ls_NewName,ls_TransName, ls_contract_search_filter_set_as_default

Choose Case al_number
	Case 1	// quick filter 1
		ls_OldName = cb_filter1.text
	Case 2	// quick filter 2
		ls_OldName = cb_filter2.text
	Case 3	// quick filter 3
		ls_OldName = cb_filter3.text
	Case else
		Return
End Choose

OpenWithParm(w_Rename,ls_OldName)

ls_NewName = Message.StringParm

ls_TransName = inv_String.of_GlobalReplace(ls_NewName,"~~","~~~~")
ls_TransName = inv_String.of_GlobalReplace(ls_NewName,"~'","~~'")

ls_contract_search_filter_set_as_default = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default" )

if ls_NewName <> "" then
	If Right(ls_NewName,3) =  '(D)' Then 
		ls_NewName = Left(ls_NewName,len(ls_NewName) - 3 )
	End If
	Choose Case al_number
		Case 1
			cb_filter1.text = ls_NewName
			gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Seacrh_FilterName_1",ls_NewName )
			
			IF not isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = string(al_number) Then
				cb_filter1.text = ls_NewName + '(D)'
			End IF
		Case 2
			cb_filter2.text = ls_NewName
			gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Seacrh_FilterName_2",ls_NewName )
			
			IF not isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = string(al_number) Then
				cb_filter2.text = ls_NewName + '(D)'
			End IF
		Case 3
			cb_filter3.text = ls_NewName
			gnv_user_option.of_Set_option_value(gs_user_id, "Contract_Seacrh_FilterName_3",ls_NewName )
			IF not isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = string(al_number) Then
				cb_filter3.text = ls_NewName + '(D)'
			End IF			
		Case else
			Return
	End Choose
	gnv_user_option.of_save( )
	
	If isvalid(gw_contract) Then
		gw_Contract.tab_contract_details.tabpage_search.of_Refresh_FilterName()
	End If
end if

end event

event ue_assignfilter(long al_number);//====================================================================
// Event: ue_assignfilter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_number
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/07/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 				ll_RtnVal, ll_count, i
String 			ls_sort, ls_text, ls_new
Boolean			lbn_flag
Datetime			ldt_lastupdate

lbn_flag = False
ll_count =	dw_filter.rowcount()

Choose Case al_number
	Case 1 	// quick filter 1
		ls_text = cb_filter1.text
	Case 2 	//  quick filter 2
		ls_text = cb_filter2.text			
	Case 3	//	 quick filter 3
		ls_text = cb_filter3.text
End Choose 

If  ll_count  > 0 Then 
	ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"Are you sure you want to assign the current filter to Quick Filter '" + ls_text+ "'?",Question!,YesNo!,1)
	If ll_RtnVal = 1 Then 
		For i = 1 to ll_count
			ls_sort = dw_filter.getitemstring( i, 'sort')
			If (isnull(ls_sort) or trim(ls_sort) = '') then 
				lbn_flag = true
				dw_filter.setitem( i, 'sort', String(al_number))
			End If
		Next
		If lbn_flag = True Then 
			ls_sort = String(al_number)
			gnv_appeondb.of_startqueue( )
			//clear data
			Delete From ctx_search_user_filter
			Where users_id = :gs_user_id and sort = :ls_sort ;
			//update data
			dw_filter.update( )
			gnv_appeondb.of_commitqueue( )
		Else
			If ls_sort <> string(al_number) Then
				ldt_lastupdate = datetime(today())
				ls_new = string(al_number)
	
				Insert into ctx_search_user_filter (column_name,users_id,sort,col_type,lengths,last_update,data_values,col_text,col_display)
				Select column_name,users_id,:ls_new,col_type,lengths,:ldt_lastupdate,data_values,col_text,col_display
				From ctx_search_user_filter
				Where users_id = :gs_user_id and sort = :ls_sort ;

	//			Trigger Event ue_viewfilter(al_number)
				This.Dynamic Trigger Event ue_viewfilter(al_number)
			End if
		End If
	Else
		Return 
	End If
Else
	// reset dw value
	ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"There are no filter criteria.~r~n~r~nDo you want to reset the current filter?",Question!,YesNo!,1)
	If ll_RtnVal = 1 Then 
		ls_new = string(al_number)
		//clear data
		Delete From ctx_search_user_filter
		Where users_id = :gs_user_id and sort = :ls_new ;
	End If	
End If
end event

event ue_set_as_default(string as_set_as_default);//====================================================================
// Event: ue_set_as_default
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_set_as_default
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/03/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

If Isnull(as_set_as_default) or Trim(as_set_as_default) = '' Then 
	Return
End If

gnv_user_option.of_Set_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default",as_set_as_default )
gnv_user_option.of_save( )

of_set_as_default_button_text()
If isvalid(gw_contract) Then
	gw_Contract.tab_contract_details.tabpage_search.of_Refresh_FilterName()
End If

end event

public subroutine of_get_filter ();//====================================================================
// Function: of_get_filter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/06/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long   				ll_Num,ll_Cnt
String 				ls_ColType,ls_ColName,ls_Value
String					ls_Visible, ls_col_text, ls_col_display
n_ds					lds_Value
Datawindow			ldw_search							//Added By Mark Lee 11/06/2012
Long					ll_row

If isvalid(gw_contract) and gw_Contract.tab_contract_details.tabpage_search.dw_search.rowcount() > 0 Then
	gw_Contract.tab_contract_details.tabpage_search.dw_search.accepttext()
	ldw_search  = 	gw_Contract.tab_contract_details.tabpage_search.dw_search
	if ldw_search.RowCount() < 1 then return

	ll_Cnt = Long(ldw_search.describe("DataWindow.Column.Count"))
	dw_filter.reset( )
	FOR ll_Num = 1 to ll_Cnt
		ls_ColType =  ldw_search.describe("#" + string(ll_Num) + ".ColType")
		ls_ColName =  ldw_search.describe("#" + string(ll_Num) + ".Name")
		ls_Visible = ldw_search.describe("#" + string(ll_Num) + ".visible")
		ls_Value = gw_Contract.tab_contract_details.tabpage_search.dw_search.inv_base.of_getitem(1,ls_ColName,false)
	
		If ls_Visible <> '1' Then 
			Continue
		End If

		If Not f_validstr(ls_Value) THEN 
			Continue
		End If
		
		ll_row = dw_filter.insertrow(0)
		ls_col_text = ldw_search.describe(string(ls_ColName) + "_t.text")
		IF isnull(ls_col_text) or trim(ls_col_text) = '' or ls_col_text = '?' or ls_col_text = '!' Then
			ls_col_text = ls_ColName
		End If				
		dw_filter.setItem( ll_row,"col_text", ls_col_text)							
		
		If ldw_search.describe("#" + string(ll_Num) + ".edit.style") = 'dddw' then
			ls_col_display = ldw_search.Describe("Evaluate('LookupDisplay("+string(ls_ColName)+")'," + "1" + ")")
			dw_filter.setItem( ll_row,"col_display", ls_col_display)				//ls_col_display			
		Else
			dw_filter.setItem( ll_row,"col_display", ls_Value)			
		End If
		
		Choose Case Lower(Left ( ls_ColType , 3 ))
			CASE 'int','lon','dec','num','dou','rea','ulo', 'mon'
					dw_filter.setItem( ll_row,"column_name", ls_ColName)
					dw_filter.setItem( ll_row,"users_id", gs_user_id)
					dw_filter.setItem( ll_row,"col_type", ls_ColType)					
					dw_filter.setItem( ll_row,"last_update", datetime(today()))
					dw_filter.setItem( ll_row,"data_values", ls_Value)								
			CASE 'dat'	
					dw_filter.setItem( ll_row,"column_name", ls_ColName)
					dw_filter.setItem( ll_row,"users_id", gs_user_id)
					dw_filter.setItem( ll_row,"col_type", ls_ColType)				
					dw_filter.setItem( ll_row,"last_update", datetime(today()))
					dw_filter.setItem( ll_row,"data_values",datetime(ls_Value))							
			CASE 'var','cha'							
					dw_filter.setItem( ll_row,"column_name", ls_ColName)
					dw_filter.setItem( ll_row,"users_id", gs_user_id)
					dw_filter.setItem( ll_row,"col_type", ls_ColType)									
					dw_filter.setItem( ll_row,"last_update", datetime(today()))
					dw_filter.setItem( ll_row,"data_values",ls_Value)		
		End Choose	
		
	NEXT 	
End If


end subroutine

public subroutine of_popmenu (string as_filter);String 	ls_contract_search_filter_set_as_default

im_Filter = Create m_contract_search_filter
im_Filter.iw_Parent = This

im_Filter.m_ViewFilter.Tag   = as_filter
im_Filter.m_AssignFilter.Tag = as_filter
im_Filter.m_RenameFilter.Tag = as_filter
im_Filter.m_set_as_default.tag = as_filter
//Added By Mark Lee 11/30/2012
ls_contract_search_filter_set_as_default = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default" )
If not isnull(ls_contract_search_filter_set_as_default) and Trim(ls_contract_search_filter_set_as_default) <> '' Then 
	IF ls_contract_search_filter_set_as_default = as_filter  Then 
		gnv_app.of_modify_menu_attr( im_Filter.m_set_as_default,'checked', True) 
	Else
		gnv_app.of_modify_menu_attr( im_Filter.m_set_as_default,'checked', False)
	End IF
Else
	gnv_app.of_modify_menu_attr( im_Filter.m_set_as_default,'checked', False)
End If

im_Filter.PopMenu(this.PointerX(),this.PointerY())


end subroutine

public subroutine of_set_filter ();//====================================================================
// Function: of_set_filter
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/07/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long   				ll_Num,ll_Cnt
String 				ls_ColType,ls_ColName,ls_Value
String					ls_Visible
n_ds					lds_Value
Datawindow			ldw_search							
Long					ll_row

//If isvalid(gw_contract)  Then
	gw_Contract.tab_contract_details.tabpage_search.dw_search.reset()
	ll_row = gw_Contract.tab_contract_details.tabpage_search.dw_search.insertrow( 0)
	ldw_search  = 	gw_Contract.tab_contract_details.tabpage_search.dw_search
	
	ll_Cnt = dw_filter.rowcount( )
	FOR ll_Num = 1 to ll_Cnt
		ls_ColName = dw_filter.GetItemString(ll_num,'column_name')
		ls_ColType = dw_filter.GetItemString(ll_num,'col_type')
		ls_Value = dw_filter.GetItemString(ll_num,'data_values')		
		
		Choose Case Lower(Left ( ls_ColType , 3 ))
			CASE 'int','num'
				ldw_search.setitem( ll_row, ls_ColName, Integer(ls_Value))
			Case	'lon','ulo'
				ldw_search.setitem( ll_row, ls_ColName, Long(ls_Value))
			Case 'dou'
				ldw_search.setitem( ll_row, ls_ColName, Double(ls_Value))
			Case 'rea'
				ldw_search.setitem( ll_row, ls_ColName, real(ls_Value))
			Case 'dec', 'mon'
				ldw_search.setitem( ll_row, ls_ColName, Dec(ls_Value))
			CASE 'dat'
				If ls_ColType = 'date' Then
					ldw_search.setitem( ll_row, ls_ColName, date(ls_Value))					
				ElseIf ls_ColType = 'datetime' Then
					ldw_search.setitem( ll_row, ls_ColName, datetime(ls_Value))					
				End If
			CASE 'var','cha'				
				ldw_search.setitem( ll_row, ls_ColName, ls_Value)
			Case Else
				//
		End Choose 
	NEXT 	
//End If


end subroutine

public subroutine of_set_as_default_button_text ();//====================================================================
// Function: of_set_as_default_button_text
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/03/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String ls_name,	ls_contract_search_filter_set_as_default
ls_contract_search_filter_set_as_default = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default" )

ls_name =  gnv_user_option.of_Get_option_value( gs_user_id,"Contract_Seacrh_FilterName_1" )
If not isnull(ls_name) and trim(ls_name) <> '' Then 
	If not Isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = '1' Then
		cb_filter1.text = ls_name +  '(D)'
	Else
		cb_filter1.text = ls_name
	End If
Else
	If not Isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = '1' Then
		cb_filter1.text = "Quick Filter1" +  '(D)'
	Else
		cb_filter1.text = "Quick Filter1" 
	End If
End If

ls_name =  gnv_user_option.of_Get_option_value( gs_user_id,"Contract_Seacrh_FilterName_2" )
If not isnull(ls_name) and trim(ls_name) <> '' Then 
	If not Isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = '2' Then
		cb_filter2.text = ls_name +  '(D)'
	Else
		cb_filter2.text = ls_name
	End If
Else
	If not Isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = '2' Then
		cb_filter2.text =  "Quick Filter2" +  '(D)'
	Else
		cb_filter2.text =  "Quick Filter2"
	end If
End If

ls_name =  gnv_user_option.of_Get_option_value( gs_user_id,"Contract_Seacrh_FilterName_3" )
If not isnull(ls_name) and trim(ls_name) <> '' Then 
	If not Isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = '3' Then
		cb_filter3.text = ls_name +  '(D)'
	Else
		cb_filter3.text = ls_name
	End If	
Else
	If not Isnull(ls_contract_search_filter_set_as_default) and ls_contract_search_filter_set_as_default = '3' Then
		cb_filter3.text = "Quick Filter3"  +  '(D)'
	else
		cb_filter3.text = "Quick Filter3"
	End If
End If
end subroutine

on w_contract_search_filter.create
int iCurrent
call super::create
this.st_txt=create st_txt
this.cb_filter3=create cb_filter3
this.cb_filter2=create cb_filter2
this.cb_filter1=create cb_filter1
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.dw_filter=create dw_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_txt
this.Control[iCurrent+2]=this.cb_filter3
this.Control[iCurrent+3]=this.cb_filter2
this.Control[iCurrent+4]=this.cb_filter1
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.dw_filter
end on

on w_contract_search_filter.destroy
call super::destroy
destroy(this.st_txt)
destroy(this.cb_filter3)
destroy(this.cb_filter2)
destroy(this.cb_filter1)
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.dw_filter)
end on

event open;call super::open;Long 		ll_number

If isvalid(w_contract) Then
	this.backcolor = Long(w_Contract.tab_contract_details.tabpage_search.dw_search.describe("Datawindow.color"))
//	st_txt.backcolor = 	this.backcolor 
	dw_filter.modify("Datawindow.color ="+string(this.backcolor ))
//	of_get_filter()
	ll_number = Message.doubleparm
	If not isnull(ll_number) and ll_number > 0 then 
		Trigger event ue_viewfilter(ll_number)
	End If
End If

end event

event pfc_preopen;call super::pfc_preopen;

is_sql = dw_filter.Describe("DataWindow.Table.Select")

//of_set_as_default_button_text()		//Added By Mark Lee 11/30/2012

end event

type st_txt from statictext within w_contract_search_filter
boolean visible = false
integer y = 1304
integer width = 581
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Quick Filter Assignment:"
boolean focusrectangle = false
end type

type cb_filter3 from commandbutton within w_contract_search_filter
boolean visible = false
integer x = 1504
integer y = 1292
integer width = 462
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quick Filter3"
end type

event clicked;
of_popmenu('3')
end event

type cb_filter2 from commandbutton within w_contract_search_filter
boolean visible = false
integer x = 1042
integer y = 1292
integer width = 462
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quick Filter2"
end type

event clicked;
of_popmenu('2')
end event

type cb_filter1 from commandbutton within w_contract_search_filter
boolean visible = false
integer x = 581
integer y = 1292
integer width = 462
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quick Filter1"
end type

event clicked;
of_popmenu('1')

end event

type cb_close from commandbutton within w_contract_search_filter
integer x = 1966
integer y = 1292
integer width = 462
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;//CloseWithReturn(Parent,"Cancel")
Close(Parent)
end event

type cb_ok from commandbutton within w_contract_search_filter
boolean visible = false
integer x = 105
integer y = 1408
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
end type

event clicked;String 			ls_sort


dw_filter.accepttext( )
If dw_filter.rowcount( ) > 0 then 
	If dw_filter.ModifiedCount() > 0 Then
		If dw_filter.update( ) = -1 Then 
			Return
		End IF 
	End If
	
	If isvalid(gw_contract ) Then 
		of_set_filter()
		gw_Contract.tab_contract_details.tabpage_search.dw_search.dynamic Trigger Event buttonclicked(1,0,gw_Contract.tab_contract_details.tabpage_search.dw_search.object.b_search)
		cb_close.event clicked( )		
	Else
		cb_close.event clicked( )
	End If
Else
	cb_close.event clicked( )
End If
end event

type dw_filter from u_dw_contract within w_contract_search_filter
integer width = 2427
integer height = 1268
integer taborder = 10
string dataobject = "d_contract_search_filter"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event pfc_preupdate;call super::pfc_preupdate;//Long 			ll_row , ll_count
//String			ls_sort
//
//this.accepttext( )
//ll_count	=	this.rowcount( ) 
//
//If ll_count > 0 then 
//	For ll_row = 1 To ll_count 
//		ls_sort = this.getitemstring( ll_row, 'sort')
//		If isnull(ls_sort) Or trim(ls_sort) = '' Then
//			Messagebox('Contractlogix','Please set filter button value. ')
//			Return -1
//		End If
//	Next
//End If
//
Return 1 
end event

