$PBExportHeader$w_invisiblefieldlist.srw
forward
global type w_invisiblefieldlist from w_response
end type
type cbx_filter from checkbox within w_invisiblefieldlist
end type
type cb_select from commandbutton within w_invisiblefieldlist
end type
type cb_cancel from commandbutton within w_invisiblefieldlist
end type
type cb_ok from commandbutton within w_invisiblefieldlist
end type
type dw_fieldlist from u_dw within w_invisiblefieldlist
end type
type ddlb_1 from dropdownlistbox within w_invisiblefieldlist
end type
type st_1 from statictext within w_invisiblefieldlist
end type
end forward

global type w_invisiblefieldlist from w_response
integer width = 2437
integer height = 1348
string title = "Add Field"
long backcolor = 33551856
cbx_filter cbx_filter
cb_select cb_select
cb_cancel cb_cancel
cb_ok cb_ok
dw_fieldlist dw_fieldlist
ddlb_1 ddlb_1
st_1 st_1
end type
global w_invisiblefieldlist w_invisiblefieldlist

type variables
String			is_FieldList

Boolean			ib_Select = true

pfc_cst_u_contract_data_design inv_data_design

CONSTANT STRING TABCHAR = "~t"
CONSTANT STRING ENTERCHAR = "~r~n"

end variables

forward prototypes
public subroutine wf_getscreensyntax (long al_viewid, long al_screen_id[], ref string as_screenname[], ref string as_syntax[])
public subroutine wf_getscreensyntax (long al_viewid, long al_screen_id[], ref string as_screenname[], ref datastore ads_screen[])
end prototypes

public subroutine wf_getscreensyntax (long al_viewid, long al_screen_id[], ref string as_screenname[], ref string as_syntax[]);//====================================================================
// Function: wf_getscreensyntax
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long      al_viewid
// 	value    long      al_screen_id[]
// 	value    string    as_screenname[]
// 	value    string    as_syntax[]
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-02-28
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String			ls_SQL[],ls_Temp, ls_ScreenName[],ls_ScreenStyle
long			ll_DataLen,ll_Cycle,ll_Count,ll_Start
Boolean		lb_Osql = gb_use_opmode, lb_file
long			READ_ONE_LENGTH = 8000,ll_getupdate
Integer		li_i, li_find
String			ls_updatedate,ls_syntaxfile, ls_lastupdate, ls_dwsyntax
Long			ll_flen, ll_FileNum, ll_loops
Blob			lb_bytes_read, lb_syntax


For li_i = 1 To UpperBound( al_screen_id )
	lb_Osql = gb_use_opmode//modified by gavins 20120927
	lb_file = true //default is true file is exists
	ls_SQL[li_i] = ""
	li_find = gds_contract_screen.find("screen_id = " + string( al_screen_id[li_i] ) ,1,gds_contract_screen.RowCount( ))
	If li_find > 0 Then
		ls_updatedate = string(gds_contract_screen.getitemdatetime(li_find,'modify_date'))
		ls_ScreenName[li_i] = gds_contract_screen.getitemstring(li_find,'titlebar_text')
		If Len( ls_ScreenName[li_i] ) = 0 Or IsNull( ls_ScreenName[li_i] )  Then
			 ls_ScreenName[li_i] = gds_Contract_Screen.GetItemString( li_find,'screen_name' )
		End If
	Else
		ls_updatedate = ''
	End if
	
	if gb_use_opmode then
		ls_syntaxfile = gs_dir_path + gs_DefDirName + "\DWOBSyntax\" + string(al_viewid) + '-' + string(al_screen_id[li_i]) + '.srd'  //jervis 10.11.2011
	else
		ls_syntaxfile = gs_dir_path + gs_DefDirName + "\DWSyntax\" + string(al_viewid) + '-' + string(al_screen_id[li_i]) + '.srd'
	end if
	
	If  Not fileexists(ls_syntaxfile) Then lb_file = false
	If lb_File Then
		//update 	
		//Modified By Mark Lee 04/18/12
//		ll_getupdate = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Screens List", "Screen-"+string(al_viewid) + '-' + string(al_screen_id[li_i]), regstring!, ls_lastupdate)
		ll_getupdate = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Screens List", "Screen-"+string(al_viewid) + '-' + string(al_screen_id[li_i]), regstring!, ls_lastupdate)
		If ll_getupdate <> 1 Then lb_file = false
	End If
	
	If lb_File Then
		if gb_use_opmode then
			ls_updatedate = gs_dir_path + gs_DefDirName + "\DWOBSyntax  " + ls_updatedate
		else
			ls_updatedate = gs_dir_path + gs_DefDirName + "\DWSyntax  " + ls_updatedate
		end if
		If ls_updatedate <> ls_lastupdate Then  lb_file = false
	End If
	
	If lb_File Then
		//Get the syntax for detail datawindow
		ll_flen = FileLength(ls_syntaxfile)
		ll_FileNum = FileOpen(ls_syntaxfile , StreamMode!, Read!, LockWrite!)
		If ll_FileNum = -1 Then lb_file = false
	End If
	
	if lb_file Then
		IF ll_flen > 32765 THEN
			IF Mod(ll_flen, 32765) = 0 THEN
				 ll_flen = ll_flen/32765
			ELSE
				 ll_loops = (ll_flen/32765) + 1
			END IF
		ELSE
			ll_loops = 1
		END IF
		lb_bytes_read = blob('')
		lb_syntax = blob('')
		
		FOR ll_Cycle = 1 to ll_loops
			 FileRead(ll_FileNum, lb_bytes_read)
			 lb_syntax = lb_syntax + lb_bytes_read
		NEXT
		
		FileClose(ll_FileNum)
		ls_dwsyntax = string(lb_syntax)
		If  isnull(ls_dwsyntax) Or Trim( ls_dwsyntax) = '' Then
			lb_File = false
		End If		
	End If
	
	If lb_File Then
		ls_SQL[li_i] = ls_dwsyntax
	Else
		ll_DataLen = 0
		ls_ScreenStyle = ""
		ls_ScreenName[li_i] =""
		If gb_use_opmode Then
			SELECT ( case when screen_style = 'G' then Datalength(grid_opsql) else Datalength(dw_opsql) end ), screen_name , screen_style
			INTO :ll_DataLen, :ls_ScreenName[li_i], :ls_ScreenStyle
			FROM ctx_screen
			WHERE data_view_id = :al_ViewID
			AND screen_id = :al_screen_id[li_i];
			
			if ll_DataLen = 0 OR Isnull(ll_DataLen) then
				SELECT (case when screen_style = 'G' then  Datalength(grid_sql)  else Datalength(dw_sql) end ), screen_name , screen_style
				INTO :ll_DataLen, :ls_ScreenName[li_i], :ls_ScreenStyle
				FROM ctx_screen
				WHERE data_view_id = :al_ViewID
				AND screen_id =:al_screen_id[li_i];
				lb_Osql = False
			end if
		else
			SELECT (case when screen_style = 'G' then  Datalength(grid_sql) else Datalength(dw_sql) end ), screen_name, screen_style
			INTO :ll_DataLen, :ls_ScreenName[li_i], :ls_ScreenStyle
			FROM ctx_screen
			WHERE data_view_id = :al_ViewID
			AND screen_id = :al_screen_id[li_i];
		
		end if
		
		ls_Temp = ""	
		if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
			ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
			
			for ll_Cycle = 1 To ll_Count
				ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
				If ls_ScreenStyle = 'G' Then
					If lb_Osql Then
						SELECT SubString(grid_opsql,:ll_Start,:READ_ONE_LENGTH)
						  INTO :ls_Temp
						  FROM ctx_screen
						 WHERE data_view_id = :al_ViewID AND screen_id = :al_screen_id[li_i];
					Else
						SELECT SubString(grid_sql,:ll_Start,:READ_ONE_LENGTH)
						  INTO :ls_Temp
						  FROM ctx_screen
						 WHERE data_view_id = :al_ViewID AND screen_id = :al_screen_id[li_i];
					End If
				Else
					If lb_Osql Then
						SELECT SubString(dw_opsql,:ll_Start,:READ_ONE_LENGTH)
						  INTO :ls_Temp
						  FROM ctx_screen
						 WHERE data_view_id = :al_ViewID AND screen_id = :al_screen_id[li_i];
					Else
						SELECT SubString(dw_sql,:ll_Start,:READ_ONE_LENGTH)
						  INTO :ls_Temp
						  FROM ctx_screen
						 WHERE data_view_id = :al_ViewID AND screen_id = :al_screen_id[li_i];
					End If
				End If
				ls_SQL[li_i] += ls_Temp
			next
		else
			If ls_ScreenStyle = 'G' Then
				If lb_Osql Then
					SELECT grid_opsql
					  INTO :ls_SQL[li_i]
					  FROM ctx_screen
					 WHERE data_view_id = :al_ViewID AND screen_id = :al_screen_id[li_i];
				Else
					SELECT grid_sql
					  INTO :ls_SQL[li_i]
					  FROM ctx_screen
					 WHERE data_view_id = :al_ViewID AND screen_id = :al_screen_id[li_i];
				End If
			Else
				If lb_Osql Then
					SELECT dw_opsql
					  INTO :ls_SQL[li_i]
					  FROM ctx_screen
					 WHERE data_view_id = :al_ViewID AND screen_id = :al_screen_id[li_i];
				Else
					SELECT dw_sql
					  INTO :ls_SQL[li_i]
					  FROM ctx_screen
					 WHERE data_view_id = :al_ViewID AND screen_id = :al_screen_id[li_i];
				End If
				
			End If
		end if
	end if//
	If  LastPos( ls_ScreenName[li_i], '->' ) > 0 Then 
		as_screenname[li_i] = Mid ( ls_ScreenName[li_i], LastPos( ls_ScreenName[li_i], '->' ) + 2 )
	Else
		as_screenname[li_i] =ls_ScreenName[li_i]
	End If
	as_syntax[li_i] = ls_Sql[li_i]
Next


end subroutine

public subroutine wf_getscreensyntax (long al_viewid, long al_screen_id[], ref string as_screenname[], ref datastore ads_screen[]);//====================================================================
// Function: wf_GetScreenSyntax
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value        long         al_viewid
// 	value        long         al_screen_id[]
// 	reference    string       as_screenname[]
// 	reference    datastore    ads_screen[]
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-02-28
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String			ls_SQL[]
Integer		li_i
string			ls_Err
DataStore	lds_Null

wf_GetScreensyntax( al_viewid, al_screen_id, as_screenname, ls_SQL )

For li_i = 1 To UpperBound( ls_SQL )
	If ls_SQL[li_i] = "" Or isnull( ls_SQL[li_i] ) Then
		ads_screen[li_i] = Create DataStore
	Else
		ads_screen[li_i] = Create DataStore
		ads_screen[li_i].Create( ls_SQL[li_i], ls_Err )
		If len( ls_Err ) > 0 Then MessageBox( 'Tips', ls_Err )
	End If
Next


end subroutine

on w_invisiblefieldlist.create
int iCurrent
call super::create
this.cbx_filter=create cbx_filter
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_fieldlist=create dw_fieldlist
this.ddlb_1=create ddlb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_filter
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.dw_fieldlist
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.st_1
end on

on w_invisiblefieldlist.destroy
call super::destroy
destroy(this.cbx_filter)
destroy(this.cb_select)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_fieldlist)
destroy(this.ddlb_1)
destroy(this.st_1)
end on

event open;call super::open;String		ls_FieldList,ls_FieldName,ls_FieldLabel
long		ll_EnterPos,ll_Row, ll_view_id, ll_Screen_ID
String		ls_SQL[], ls_ScreenName[], ls_Visible, ls_Custom2Name, ls_Facility, ls_ContractContact, ls_OurContact
String		ls_TempName[], ls_Document, ls_FeeSchedule, ls_Err
Boolean	lb_Category
Integer	li_i
Long		li_id[]
DataStore	lds_Screen[], lds_Temp[]

Inv_Data_Design = Message.PowerObjectParm

ls_FieldList = Inv_Data_Design.of_Get_InVisible_Field()
if Right(ls_FieldList,Len(ENTERCHAR)) <> ENTERCHAR then ls_FieldList += ENTERCHAR

ll_view_id = Inv_Data_Design.il_data_view_id
ll_Screen_ID = Inv_Data_Design.ii_screen_id
//added by gavins 20120227 find fieldname in screenname
If ll_Screen_ID = 1 Or ll_Screen_ID = 2 Or ll_Screen_ID = 3 Or ll_Screen_ID = 5 Or ll_Screen_ID = 9 Or ll_Screen_ID = 8  Then
	//modified by gavins 20120405
	If ll_Screen_ID <=2 Then
		dw_fieldlist.y = 140
		this.ddlb_1.visible = true
		st_1.visible = true
		cbx_filter.Text = "Show all fields that have been added to this View"
		cb_ok.y = 140
		cb_cancel.y = cb_cancel.y + 108
		cb_select.y = cb_select.y + 108
		dw_fieldlist.Height = dw_fieldlist.Height - 108
		ddlb_1.addItem("All" )
	End If
	cbx_filter.checked = true
	this.Height = this.Height + 150
		
	If Not IsValid(gds_contract_screen) Then
		gds_contract_screen = create datastore
		gds_contract_screen.dataobject = 'd_contract_dw_sql_all'
	End if
		
	gds_contract_screen.SetTransObject(SQLCA)
    gds_contract_screen.Retrieve(ll_view_id)

	ll_Row = gds_Contract_Screen.Find( "screen_id = 10 " , 1, gds_Contract_Screen.RowCount( ))
	If ll_Row > 0 Then
		ls_Custom2Name =gds_Contract_Screen.GetItemString( ll_Row,'titlebar_text' )
		If Len( ls_Custom2Name ) = 0 Or IsNull( ls_Custom2Name )  Then
			ls_Custom2Name =gds_Contract_Screen.GetItemString( ll_Row,'screen_name' )
			If  LastPos( ls_Custom2Name, '->' ) > 0 Then  ls_Custom2Name = Mid ( ls_Custom2Name, LastPos( ls_Custom2Name, '->' ) + 2 )
		End If
	Else
		ls_Custom2Name = 'Custom Data 2'
	End If
	
	ll_Row = gds_Contract_Screen.Find( "screen_id = 6 " , 1, gds_Contract_Screen.RowCount( ))//added by gavins 20120326
	If ll_Row > 0 Then
		ls_ContractContact =gds_Contract_Screen.GetItemString( ll_Row,'titlebar_text' )
		If Len( ls_ContractContact ) = 0 Or IsNull( ls_ContractContact )  Then
			ls_ContractContact =gds_Contract_Screen.GetItemString( ll_Row,'screen_name' )
			If  LastPos( ls_ContractContact, '->' ) > 0 Then  ls_ContractContact = Mid ( ls_ContractContact, LastPos( ls_ContractContact, '->' ) + 2 )
		End If
	Else
		ls_ContractContact = 'Contracted Company Contact'
	End If
	
	ll_Row = gds_Contract_Screen.Find( "screen_id = 7 " , 1, gds_Contract_Screen.RowCount( ))//added by gavins 20120326
	If ll_Row > 0 Then
		ls_OurContact =gds_Contract_Screen.GetItemString( ll_Row,'titlebar_text' )
		If Len( ls_OurContact ) = 0 Or IsNull( ls_OurContact )  Then
			ls_OurContact =gds_Contract_Screen.GetItemString( ll_Row,'screen_name' )
			If  LastPos( ls_OurContact, '->' ) > 0 Then  ls_OurContact = Mid ( ls_OurContact, LastPos( ls_OurContact, '->' ) + 2 )
		End If
	Else
		ls_OurContact = 'Our Company Contact'
	End If
	
	ll_Row = gds_Contract_Screen.Find( "screen_id = 56 " , 1, gds_Contract_Screen.RowCount( ))//added by gavins 20120425
	If ll_Row > 0 Then
		ls_Document =gds_Contract_Screen.GetItemString( ll_Row,'titlebar_text' )
		If Len( ls_Document ) = 0 Or IsNull( ls_Document )  Then
			ls_Document =gds_Contract_Screen.GetItemString( ll_Row,'screen_name' )
			If  LastPos( ls_Document, '->' ) > 0 Then  ls_Document = Mid ( ls_Document, LastPos( ls_Document, '->' ) + 2 )
		End If
	Else
		ls_Document = 'Document Browse'
	End If
	
	ls_Facility = 'Company Information' 
	
	ll_Row = gds_Contract_Screen.Find( "screen_id = 31 " , 1, gds_Contract_Screen.RowCount( ))//added by gavins 20120607
	If ll_Row > 0 Then
		ls_FeeSchedule =gds_Contract_Screen.GetItemString( ll_Row,'titlebar_text' )
		If Len( ls_FeeSchedule ) = 0 Or IsNull( ls_FeeSchedule )  Then
			ls_FeeSchedule =gds_Contract_Screen.GetItemString( ll_Row,'screen_name' )
			If  LastPos( ls_FeeSchedule, '->' ) > 0 Then  ls_FeeSchedule = Mid ( ls_FeeSchedule, LastPos( ls_FeeSchedule, '->' ) + 2 )
		End If
	Else
		ls_FeeSchedule = 'Fee Schedule (NM)'
	End If
	
	dw_fieldlist.dataobject = 'd_screen_field_category_list'
	dw_fieldlist.settransObject( sqlca )

//	gnv_appeondb.of_startqueue()
	li_id =  { 3, 5, 8 , 9  }	
	wf_GetScreenSyntax( ll_view_id, li_ID ,ls_ScreenName, lds_Screen )
	For li_i = 1 To UpperBound( li_id )
		If li_id[li_i ] = ll_Screen_ID Then
			If li_i <= UpperBound( 	lds_Screen ) Then lds_Screen[li_i].Create( inv_data_design.uo_band.dw_syntax.describe( "datawindow.syntax" ) , ls_Err)
			exit
		End If
	Next
	li_id = {10,6,7,31} 
	wf_GetScreenSyntax( ll_view_id, li_ID ,ls_TempName, lds_Temp )
//	gnv_appeondb.of_commitqueue( )
	lb_Category = True
End If

do 
	ll_EnterPos  = Pos(ls_FieldList,ENTERCHAR)
	ls_FieldName = Trim(Left(ls_FieldList,ll_EnterPos - 1))
	ls_FieldList = Trim(Mid(ls_FieldList,ll_EnterPos + Len(ENTERCHAR)))
	
	if ls_FieldName <> "" then
		ls_FieldLabel = Inv_Data_Design.uo_band.dw_Syntax.Describe(ls_FieldName + "_t.Text")
		if IsNull(ls_FieldLabel) or Trim(ls_FieldLabel) = "" or ls_FieldLabel = "!" or ls_FieldLabel = "?" then 
			ls_FieldLabel = ls_FieldName
		end if
		
		ll_Row = dw_FieldList.InsertRow(0)
		dw_FieldList.SetItem(ll_Row,"FieldName",ls_FieldName)
		dw_FieldList.SetItem(ll_Row,"FieldLabel",ls_FieldLabel)
		
		//added by gavins 20120227 find fieldname in screenname
		If lb_Category Then
			If left( ls_FieldName, 14) = 'custom2_custom' Then
				If  lds_Temp[1].Describe( Mid(ls_FieldName, 9 ) + ".visible" ) = '1' Then
					dw_FieldList.SetItem(ll_Row,"screenname", ls_Custom2Name )
					If this.ddlb_1.FindItem( ls_Custom2Name, 0 ) <0 Then
						ddlb_1.addItem( ls_Custom2Name )
					End If 
				End If
			ElseIf left( ls_FieldName, 5) = 'ccci_' Then
				If  lds_Temp[2].Describe( Mid(ls_FieldName,6 ) + ".visible" ) = '1' Or  lower(Mid(ls_FieldName,6 ) ) = 'name'  Then
					dw_FieldList.SetItem(ll_Row,"screenname", ls_ContractContact )
					If this.ddlb_1.FindItem( ls_ContractContact, 0 ) <0 Then
						ddlb_1.addItem( ls_ContractContact )
					End If 
				End If
			ElseIf left( ls_FieldName, 5) = 'occi_' Then
				If  lds_Temp[3].Describe( Mid(ls_FieldName, 6 ) + ".visible" ) = '1' Or  lower(Mid(ls_FieldName,6 ) ) = 'name'  Then
					dw_FieldList.SetItem(ll_Row,"screenname", ls_OurContact )
					If this.ddlb_1.FindItem( ls_OurContact, 0 ) <0 Then
						ddlb_1.addItem( ls_OurContact )
					End If 	
				End If
			ElseIf Pos( ls_FieldName, 'app_facility_contact' ) > 0 Then
				dw_FieldList.SetItem(ll_Row,"screenname", ls_Facility )
				If this.ddlb_1.FindItem( ls_Facility, 0 ) <0 Then
					ddlb_1.addItem( ls_Facility )
				End If 	
			ElseIf  lower(Left( ls_FieldName, 9)) = 'document_' Then
				dw_FieldList.SetItem(ll_Row,"screenname", ls_Document )
				If this.ddlb_1.FindItem( ls_Document, 0 ) <0 Then
					ddlb_1.addItem( ls_Document )
				End If 
			ElseIf Left( Lower( ls_FieldName), 9 ) = 'feesched_' Then
				If  lds_Temp[4].Describe( Mid(ls_FieldName, 10 ) + ".visible" ) = '1' Then
					dw_FieldList.SetItem(ll_Row,"screenname", ls_FeeSchedule )
					If this.ddlb_1.FindItem( ls_FeeSchedule, 0 ) <0 Then
						ddlb_1.addItem( ls_FeeSchedule )
					End If 	
				End If
			Else
				
				For li_i = 1 To UpperBound( lds_Screen )
					ls_visible = lds_Screen[li_i].Describe( ls_FieldName + ".visible" )
					If ls_visible = '1' Then
						If Len( dw_FieldList.GetItemString( ll_Row, 'screenname' ) ) > 0 Then
							dw_FieldList.SetItem(ll_Row,"screenname",ls_screenname[li_i] + '; ' + dw_FieldList.GetItemString( ll_Row, 'screenname' )  )
						Else
							dw_FieldList.SetItem(ll_Row,"screenname",ls_screenname[li_i] )
						End If
						If this.ddlb_1.FindItem( ls_screenname[li_i], 0 ) <0 Then
							ddlb_1.addItem( ls_screenname[li_i] )
						End If 
					End If
				Next
			End If
		End If		
	end if
loop while ll_EnterPos > 0 and Trim(ls_FieldList) <> ""

If lb_Category Then
	cbx_filter.event clicked( )
End If

dw_FieldList.SetSort("Lower(FieldLabel) Asc")
dw_FieldList.Sort()

end event

type cbx_filter from checkbox within w_invisiblefieldlist
integer x = 32
integer y = 1280
integer width = 1202
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display all unused data fields "
end type

event clicked;
If Inv_Data_Design.ii_screen_id = 2 Or  Inv_Data_Design.ii_screen_id = 1 Then
	If this.Checked Then
		dw_fieldlist.Setfilter( " Not( isnull(screenname ) or trim(screenname ) = '' )" )
		dw_fieldlist.filter( )
		ddlb_1.selectitem(1)
	Else
		dw_fieldlist.Setfilter( "" )
		dw_fieldlist.filter( )
		ddlb_1.selectitem(1)
	End If

Else
	If this.Checked Then
		dw_fieldlist.Setfilter( " isnull(screenname ) or trim(screenname ) = '' " )
		dw_fieldlist.filter( )
		dw_fieldlist.Modify( "screenname_t.visible= '0' screenname.visible = '0' " )
	Else
		dw_fieldlist.Setfilter( "" )
		dw_fieldlist.filter( )
		
		dw_fieldlist.SetRedraw( false )
		dw_fieldlist.Modify( "fieldname.visible = '0' fieldname_t.visible = '0' screenname_t.visible= '1' screenname.visible = '1' " )
		dw_fieldlist.Modify( "fieldname.visible = '1' fieldname_t.visible = '1'  " )
		dw_fieldlist.SetRedraw( true )
	End If
End If
end event

type cb_select from commandbutton within w_invisiblefieldlist
integer x = 2002
integer y = 268
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;long	ll_Cycle,ll_RowCnts

ll_RowCnts = dw_FieldList.RowCount()
for ll_Cycle = 1 to ll_RowCnts
	dw_FieldList.SelectRow(ll_Cycle,ib_Select)
next

ib_Select = Not ib_Select

if ib_Select then
	This.Text = "Select All"
else
	This.Text = "Unselect All"
end if

end event

type cb_cancel from commandbutton within w_invisiblefieldlist
integer x = 2002
integer y = 144
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

event clicked;CloseWithReturn(Parent,"")

end event

type cb_ok from commandbutton within w_invisiblefieldlist
integer x = 2002
integer y = 20
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

event clicked;long		ll_SelRow
String	ls_FieldName

ll_SelRow = dw_FieldList.GetSelectedRow(0)
do while ll_SelRow > 0
	ls_FieldName = dw_FieldList.GetItemString(ll_SelRow,"FieldName")
	is_FieldList += ls_FieldName + ENTERCHAR
	ll_SelRow = dw_FieldList.GetSelectedRow(ll_SelRow)
loop

CloseWithReturn(Parent,is_FieldList)

end event

type dw_fieldlist from u_dw within w_invisiblefieldlist
integer x = 32
integer y = 24
integer width = 1920
integer height = 1212
integer taborder = 40
string dataobject = "d_screen_field_list"
boolean hscrollbar = true
end type

event clicked;call super::clicked;if Row > 0 and Row <= This.RowCount() then
	This.SelectRow(Row,Not This.IsSelected(Row))
end if

end event

event doubleclicked;call super::doubleclicked;This.Trigger Event Clicked(XPos,YPos,Row,Dwo)

end event

event constructor;call super::constructor;This.of_SetUpdateAble(false)

of_SetSort(True)
inv_Sort.of_SetColumnHeader(True)

if AppeonGetClientType() = "WEB" then This.Height = This.Height + 6

end event

type ddlb_1 from dropdownlistbox within w_invisiblefieldlist
integer x = 512
integer y = 32
integer width = 1435
integer height = 800
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible = false
end event

event modified;String			ls_Text


ls_Text = This.Text

If Len( ls_Text ) > 0 Then 
	If Pos( lower( ls_Text), 'all' ) > 0 Then
		cbx_filter.checked = true
		dw_fieldlist.Setfilter( " Not( isnull(screenname ) or trim(screenname ) = '' )" )
		dw_fieldlist.filter( )
	Else
		dw_fieldlist.SetFilter( "Screenname = '" + ls_Text + "'" )
		dw_fieldlist.Filter( )
	End If
End If
end event

type st_1 from statictext within w_invisiblefieldlist
integer x = 27
integer y = 44
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
string text = "Select Screen Name"
boolean focusrectangle = false
end type

event constructor;visible = false
end event

