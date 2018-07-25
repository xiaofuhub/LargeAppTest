$PBExportHeader$w_contract_screen_history.srw
forward
global type w_contract_screen_history from w_response
end type
type cb_download from commandbutton within w_contract_screen_history
end type
type cb_1 from commandbutton within w_contract_screen_history
end type
type st_1 from statictext within w_contract_screen_history
end type
type cb_close from commandbutton within w_contract_screen_history
end type
type cb_load from commandbutton within w_contract_screen_history
end type
type dw_history from u_dw within w_contract_screen_history
end type
type gb_1 from groupbox within w_contract_screen_history
end type
end forward

global type w_contract_screen_history from w_response
integer width = 2309
integer height = 2212
string title = "Screen History"
long backcolor = 33551856
boolean ib_isupdateable = false
cb_download cb_download
cb_1 cb_1
st_1 st_1
cb_close cb_close
cb_load cb_load
dw_history dw_history
gb_1 gb_1
end type
global w_contract_screen_history w_contract_screen_history

type variables
String				is_SQL, is_Version, is_Style
Long				il_ViewID, il_ScreenID
end variables

forward prototypes
public function string wf_getsyntax (string as_style, long al_data_view_id, long al_screen_id, datetime adt_backup, long al_seq)
public function string of_getscreensyntax (long al_data_view_id, long al_screen_id, datetime adt_backdate)
public function long of_writestrtofile (string as_filename, string as_context, boolean ab_replace)
end prototypes

public function string wf_getsyntax (string as_style, long al_data_view_id, long al_screen_id, datetime adt_backup, long al_seq);//Add ab_obsyntax argu - jervis 10.11.2011

Long ll_data_length
Integer li_counter
Integer li_loops
String ls_sql
String ls_all_sql
Long ll_start

// Get file data from database
if as_style <> 'G'  then
	SELECT Datalength(dw_sql)
	INTO :ll_data_length
	FROM ctx_screen_bak
	WHERE data_view_id = :al_data_view_id
	AND screen_id = :al_screen_id and backupdate = :adt_backup and seq_no =:al_seq ;
else
	SELECT Datalength(grid_sql)
	INTO :ll_data_length
	FROM ctx_screen_bak
	WHERE data_view_id = :al_data_view_id
	AND screen_id = :al_screen_id and backupdate = :adt_backup and seq_no =:al_seq ;
end if

IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
	Messagebox("Get sql error","Failed to get datawindow syntax from DB, Please report this to support.")
	RETURN ''
END IF

IF ll_data_length > 8000 THEN 
  	 IF Mod(ll_data_length,8000) = 0 THEN 
        li_loops = ll_data_length/8000 
    ELSE 
  	     li_loops = (ll_data_length/8000) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

FOR li_counter = 1 to li_loops
	ll_start = (li_counter - 1) * 8000 + 1
	if as_style <> 'G'  then
		SELECT substring(dw_sql,:ll_start,8000)
		INTO :ls_sql
		FROM ctx_screen_bak 
		WHERE data_view_id = :al_data_view_id 
		AND screen_id = :al_screen_id and backupdate = :adt_backup and seq_no =:al_seq ;
	else
		SELECT substring(grid_sql,:ll_start,8000)
		INTO :ls_sql
		FROM ctx_screen_bak 
		WHERE data_view_id = :al_data_view_id 
		AND screen_id = :al_screen_id and backupdate = :adt_backup and seq_no =:al_seq ;
	end if

	ls_all_sql += ls_sql
NEXT 

If not len(ls_all_sql) > 0 Then
	Messagebox("Get sql error 1","Failed to get datawindow syntax from DB, Please report this to support.")
End If
Return ls_all_sql
end function

public function string of_getscreensyntax (long al_data_view_id, long al_screen_id, datetime adt_backdate);long		ll_data_length,ll_loops,ll_Cnts,ll_start
Long		ll_GridDataLength
String		ls_SQL,ls_all_SQL, ls_ScreenStyle

  SELECT   (Case when screen_style = 'G' Then Datalength(grid_SQL) else  Datalength(dw_SQL) end ), Screen_style    INTO :ll_data_length, :ls_ScreenStyle        
    FROM ctx_screen_bak   where screen_id = :al_screen_id and data_view_id =:al_data_view_id and backupdate = :adt_backdate;

if ll_data_length = 0 or IsNull(ll_data_length) then Return ""

if ll_data_length > 8000 then
  	 if Mod(ll_data_length,8000) = 0 then
        ll_loops = ll_data_length/8000
    else
  	     ll_loops = (ll_data_length/8000) + 1
    end if
else
  	 ll_loops = 1
end if

for ll_Cnts = 1 to ll_loops
	ll_start = (ll_Cnts - 1) * 8000 + 1
	If ls_ScreenStyle = 'G' Then
		SELECT  SubString(grid_SQL,:ll_start,8000)
		  INTO :ls_SQL
		  FROM ctx_screen_bak
		 WHERE data_view_id = :al_data_view_id AND screen_id = :al_screen_id and backupdate = :adt_backdate;
	Else
		SELECT  SubString(dw_SQL,:ll_start,8000)
		  INTO :ls_SQL
		  FROM ctx_screen_bak
		 WHERE data_view_id = :al_data_view_id AND screen_id = :al_screen_id and backupdate = :adt_backdate;
	End If
	ls_all_SQL += ls_SQL
next

Return ls_all_SQL

end function

public function long of_writestrtofile (string as_filename, string as_context, boolean ab_replace);long		ll_FileNo,ll_Cycle,ll_WriteCnts, ll_BlobLen
Blob		lb_syntax
//CONSTANT LONG ONCE_COUNT = 32760
//
//WriteMode	lwm_Mode
//
//if ab_Replace then lwm_Mode = Replace! else lwm_Mode = Append!
//
//ll_FileNo = FileOpen(as_FileName,StreamMode!,Write!,LockReadWrite!,lwm_Mode)
//if ll_FileNo < 0 then Return -1
//
//ll_WriteCnts = Ceiling(Len(as_Context) * 1.0 / ONCE_COUNT)
//
//for ll_Cycle = 1 to ll_WriteCnts
//	FileWrite(ll_FileNo,Mid(as_Context,(ll_Cycle - 1) * ONCE_COUNT + 1,ONCE_COUNT))
//next
//
//FileClose(ll_FileNo)
//modified by gavins 20120313 grid
If len( as_Context ) = 0 Or IsNull( as_Context ) Then Return -1


lb_syntax = blob(as_Context)
ll_BlobLen = Len(lb_syntax)
If fileexists ( as_filename ) then filedelete(as_FileName)  //jervis 10.25.2011
AppeonWriteFile(as_FileName, lb_syntax,ll_BlobLen)


Return 1

end function

on w_contract_screen_history.create
int iCurrent
call super::create
this.cb_download=create cb_download
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_load=create cb_load
this.dw_history=create dw_history
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_download
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_load
this.Control[iCurrent+6]=this.dw_history
this.Control[iCurrent+7]=this.gb_1
end on

on w_contract_screen_history.destroy
call super::destroy
destroy(this.cb_download)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_load)
destroy(this.dw_history)
destroy(this.gb_1)
end on

event open;call super::open;Long				ll_ViewID, ll_ScreenID
String				ls_Temp

ls_Temp = Message.StringParm


dw_history.SetTransObject( SQLCA )

If Len( ls_Temp ) > 0 Then
	ll_ViewID = Long( Mid( ls_Temp, 1, Pos( ls_Temp, '#' ) - 1  ) )
	ll_ScreenID = Long( Mid( ls_Temp, Pos( ls_Temp, '#' ) + 1, Pos( ls_Temp, '*' ) -  Pos( ls_Temp, '#' ) - 1  ) )
	is_Style = Mid( ls_Temp, Pos( ls_Temp, '*' ) + 1 )
	dw_history.Retrieve( ll_ViewID, ll_ScreenID )
	
	il_ViewID = ll_ViewID
	il_ScreenID = ll_ScreenID
End If
end event

event key;call super::key;if Key = KeyEscape! then Close(This)
end event

type cb_download from commandbutton within w_contract_screen_history
integer x = 1029
integer y = 2004
integer width = 494
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Download Syntax..."
end type

event clicked;//====================================================================
// Event: clicked
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-09-19
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long			ll_FR, ll_Seq, ll_ViewID, ll_ScreenID, ll_RtnVal
DateTime	ldt_BackUp
String			ls_ScreenStyle, ls_CurDir, ls_Syntax, ls_FileName



ll_FR = dw_history.Find( "selected = '1'",1, dw_history.RowCount( ) )
If ll_FR <= 0 Then
	MessageBox("Select", "Please select a screen history.")
	Return
End If

is_Version = dw_history.GetItemString( ll_FR, 'version' )
ll_Seq = dw_history.GetItemNumber( ll_FR, 'seq_no' )
ldt_BackUp = dw_history.GetItemDateTime( ll_FR, 'backupdate' )
ll_ViewID = dw_history.GetItemNumber( ll_FR, 'data_view_id' )
ll_ScreenID = dw_history.GetItemNumber( ll_FR, 'screen_id' )
ls_ScreenStyle = dw_history.GetItemString( ll_FR, 'screen_style' )

If IsNull(ls_ScreenStyle) Or Trim( ls_ScreenStyle ) = '' Then ls_ScreenStyle = is_Style
If Lower(is_Version) = 'default' Then
	MessageBox( 'Tips', 'Please select other screen history.')
	Return
End If

ls_CurDir = GetCurrentDirectory()
ll_RtnVal = GetFolder("Please select a directory.",ls_CurDir)
if ll_RtnVal <> 1 then Return

if Right(ls_CurDir,1) <> '\' then ls_CurDir += '\'

This.Enabled = false
SetPointer(HourGlass!)


IF appeongetclienttype() <> 'PB' Then
	If ls_ScreenStyle = 'G' Then
		SELECT grid_sql INTO :ls_Syntax
		FROM ctx_screen_bak 
		WHERE data_view_id = :ll_viewid 
		AND screen_id = :ll_screenid and backupdate = :ldt_backup and seq_no =:ll_seq ;
	Else
		SELECT dw_sql INTO :ls_Syntax
		FROM ctx_screen_bak 
		WHERE data_view_id = :ll_viewid 
		AND screen_id = :ll_screenid and backupdate = :ldt_backup and seq_no =:ll_seq ;
	End If
Else
	ls_Syntax = wf_GetSyntax( ls_ScreenStyle, ll_ViewID, ll_ScreenID, ldt_BackUp, ll_Seq )
End If


if Not IsNull(ls_Syntax) and Trim(ls_Syntax) <> "" then
	ls_FileName = ls_CurDir + String(ll_ViewID) + "-" + String(ll_ScreenID) + '-' +String( ldt_backup, 'yyyymmddhhmm') + ".srd"
	of_WriteSTRToFile(ls_FileName,ls_Syntax,true)
Else
	MessageBox( 'Tips', 'Syntax is empty!' )
end if


SetPointer(Arrow!)
This.Enabled = true

Run("Explorer.exe " + ls_CurDir)

end event

type cb_1 from commandbutton within w_contract_screen_history
boolean visible = false
integer x = 32
integer y = 2000
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reset"
boolean cancel = true
end type

event clicked;Long			ll_FR, ll_Seq, ll_ViewID, ll_ScreenID
DateTime	ldt_BackUp
String			ls_DataObject, ls_ScreenStyle
DataStore	lds_Create




If MessageBox( "Screen History", "Are you sure you want to load the default screen?", question!, yesno! ) <> 1 Then Return
	

ll_ViewID = il_ViewID
ll_ScreenID = il_ScreenID

SELECT Screen_style INTO:ls_ScreenStyle
FROM ctx_screen
	WHERE data_view_id = :ll_viewid 
	AND screen_id = :ll_screenid ;
If IsNull( ls_ScreenStyle ) Or Trim( ls_ScreenStyle ) = '' Then ls_ScreenStyle = is_Style
is_Style = ls_ScreenStyle

If ls_ScreenStyle = 'G' Then
	SELECT grid_dataobject INTO :ls_DataObject
	FROM ctx_screen
	WHERE data_view_id = :ll_viewid 
	AND screen_id = :ll_screenid ;
Else
	SELECT dataobject INTO :ls_DataObject
	FROM ctx_screen
	WHERE data_view_id = :ll_viewid 
	AND screen_id = :ll_screenid ;
End If

lds_Create = Create DataStore

If ls_DataObject = "" Or IsNull( ls_DataObject ) Then
	MessageBox( 'Screen History', 'Failed to get a dataobject.', stopsign! )
	Return
End If

lds_Create.DataObject = ls_DataObject
is_SQL = lds_Create.Describe( "datawindow.syntax" )


If IsNull( is_VerSion ) Then is_VerSion = ''
If IsNull( is_SQL ) Then is_SQL = ''

CloseWithReturn( Parent, is_Style + '##' + is_SQL )
end event

type st_1 from statictext within w_contract_screen_history
integer x = 32
integer y = 20
integer width = 1623
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select the screen history to restore from the last 20 backups:"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_contract_screen_history
integer x = 1920
integer y = 2004
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
boolean cancel = true
end type

event clicked;Close( Parent )
end event

type cb_load from commandbutton within w_contract_screen_history
integer x = 1554
integer y = 2004
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Load"
boolean default = true
end type

event clicked;Long			ll_FR, ll_Seq, ll_ViewID, ll_ScreenID
DateTime	ldt_BackUp
String			ls_ScreenStyle



ll_FR = dw_history.Find( "selected = '1'",1, dw_history.RowCount( ) )
If ll_FR <= 0 Then
	MessageBox("Select", "Please select a screen history.")
	Return
Else
	
	
	is_Version = dw_history.GetItemString( ll_FR, 'version' )
	ll_Seq = dw_history.GetItemNumber( ll_FR, 'seq_no' )
	ldt_BackUp = dw_history.GetItemDateTime( ll_FR, 'backupdate' )
	ll_ViewID = dw_history.GetItemNumber( ll_FR, 'data_view_id' )
	ll_ScreenID = dw_history.GetItemNumber( ll_FR, 'screen_id' )
	ls_ScreenStyle = dw_history.GetItemString( ll_FR, 'screen_style' )

	If IsNull(ls_ScreenStyle) Or Trim( ls_ScreenStyle ) = '' Then ls_ScreenStyle = is_Style
	is_Style = ls_ScreenStyle
	
	If Lower(is_Version) = 'default' Then
		cb_1.Event Clicked( )
		Return
	End If
	If MessageBox( "Screen History", "Are you sure you want to load the history screens?", question!, yesno! ) <> 1 Then Return
	IF appeongetclienttype() <> 'PB' Then
		If ls_ScreenStyle = 'G' Then
			SELECT grid_sql INTO :is_sql
			FROM ctx_screen_bak 
			WHERE data_view_id = :ll_viewid 
			AND screen_id = :ll_screenid and backupdate = :ldt_backup and seq_no =:ll_seq ;
		Else
			SELECT dw_sql INTO :is_sql
			FROM ctx_screen_bak 
			WHERE data_view_id = :ll_viewid 
			AND screen_id = :ll_screenid and backupdate = :ldt_backup and seq_no =:ll_seq ;
		End If
	Else
		is_SQL = wf_GetSyntax( ls_ScreenStyle, ll_ViewID, ll_ScreenID, ldt_BackUp, ll_Seq )
	End If
	If IsNull( is_VerSion ) Then is_VerSion = ''
	If IsNull( is_SQL ) Then is_SQL = ''
	
	CloseWithReturn( Parent, is_Style + '##' + is_SQL )
End If//find


end event

type dw_history from u_dw within w_contract_screen_history
integer x = 32
integer y = 100
integer width = 2240
integer height = 1872
integer taborder = 10
string dataobject = "d_contract_screen_history"
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;Long			ll_FR

If row > 0 Then
	
	ll_FR = Find( "selected = '1'",1, RowCount( ) )
	If ll_FR > 0 Then 
		SetItem( ll_FR, 'selected', '0' )
	End If
	SetItem( Row, 'selected', '1' )
	SetItemStatus( row, 'selected', primary!, notmodified! )
	
	selectRow( 0, false )
	selectRow( row, true )
	
End If
end event

type gb_1 from groupbox within w_contract_screen_history
boolean visible = false
integer x = 27
integer y = 1516
integer width = 1010
integer height = 172
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reset screen to its default setting"
end type

