$PBExportHeader$w_screensyntaxupdate.srw
$PBExportComments$(Appeon)Toney 06.05.2013 - V141 ISG-CLX
forward
global type w_screensyntaxupdate from w_popup
end type
type cb_resetsyntax from commandbutton within w_screensyntaxupdate
end type
type cb_selectview from commandbutton within w_screensyntaxupdate
end type
type dw_screen_list from datawindow within w_screensyntaxupdate
end type
type dw_view_list from datawindow within w_screensyntaxupdate
end type
type cb_upload from commandbutton within w_screensyntaxupdate
end type
type cb_download from commandbutton within w_screensyntaxupdate
end type
type cb_cb_selectscreen from commandbutton within w_screensyntaxupdate
end type
type cb_close from commandbutton within w_screensyntaxupdate
end type
type cbx_dynamicscreen from checkbox within w_screensyntaxupdate
end type
end forward

global type w_screensyntaxupdate from w_popup
integer width = 3333
integer height = 2124
string title = "Screen Syntax Update"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_resetsyntax cb_resetsyntax
cb_selectview cb_selectview
dw_screen_list dw_screen_list
dw_view_list dw_view_list
cb_upload cb_upload
cb_download cb_download
cb_cb_selectscreen cb_cb_selectscreen
cb_close cb_close
cbx_dynamicscreen cbx_dynamicscreen
end type
global w_screensyntaxupdate w_screensyntaxupdate

type variables
CONSTANT STRING EXPORTHEADERFLAG = "$PBExportHeader$"
CONSTANT STRING ENTERCHAR = "~r~n"

DataStore	ids_Screen
String		is_CurDir

end variables

forward prototypes
public function long of_writestrtofile (string as_filename, string as_context, boolean ab_replace)
public function string of_getscreensyntax (long al_data_view_id, long al_screen_id)
public function long of_readstrfromfile (string as_filename, ref string as_context)
public subroutine of_getcheckedlist (ref long al_vclist[], ref long al_sclist[], ref string as_dolist[], ref string as_fixfield[])
end prototypes

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
filedelete(as_FileName)  //jervis 10.25.2011
AppeonWriteFile(as_FileName, lb_syntax,ll_BlobLen)


Return 1

end function

public function string of_getscreensyntax (long al_data_view_id, long al_screen_id);long		ll_data_length,ll_loops,ll_Cnts,ll_start
Long		ll_GridDataLength
String		ls_SQL,ls_all_SQL, ls_ScreenStyle

//modified by gavins 20120312 grid
SELECT (Case when screen_style = 'G' Then Datalength(grid_SQL) else  Datalength(dw_SQL) end ), Screen_style 
  INTO :ll_data_length, :ls_ScreenStyle
  FROM ctx_screen
 WHERE data_view_id = :al_data_view_id AND screen_id = :al_screen_id;

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
		  FROM ctx_screen
		 WHERE data_view_id = :al_data_view_id AND screen_id = :al_screen_id;
	Else
		SELECT  SubString(dw_SQL,:ll_start,8000)
		  INTO :ls_SQL
		  FROM ctx_screen
		 WHERE data_view_id = :al_data_view_id AND screen_id = :al_screen_id;
	End If
	ls_all_SQL += ls_SQL
next

Return ls_all_SQL

end function

public function long of_readstrfromfile (string as_filename, ref string as_context);String		ls_Buffer
long		ll_FileNo,ll_ReadCnts
blob		lb_Buffer

as_Context = ""

ll_FileNo = FileOpen(as_FileName,StreamMode!,Read!,LockReadWrite!)
if ll_FileNo < 0 then Return -1

ll_ReadCnts = FileReadex(ll_FileNo,lb_Buffer)
do while ll_ReadCnts > 0
	as_Context += String( lb_Buffer )
	ll_ReadCnts = FileReadex(ll_FileNo,lb_Buffer)
loop

FileClose(ll_FileNo)

Return 1

end function

public subroutine of_getcheckedlist (ref long al_vclist[], ref long al_sclist[], ref string as_dolist[], ref string as_fixfield[]);long	ll_VCRow,ll_SCRow
String	ls_Screen_Style, ls_fixfield


ll_VCRow = dw_view_list.Find("selected = 1",1,dw_view_list.RowCount())
do while ll_VCRow > 0
	al_VCList[UpperBound(al_VCList) + 1] = dw_view_list.GetItemNumber(ll_VCRow,"data_view_id")
	if ll_VCRow >= dw_view_list.RowCount() then Exit
	ll_VCRow = dw_view_list.Find("selected = 1",ll_VCRow + 1,dw_view_list.RowCount())
loop

ll_SCRow = dw_screen_list.Find("selected = 1",1,dw_screen_list.RowCount())
do while ll_SCRow > 0
	//modified by gavins 20120312 grid
	ls_Screen_Style = dw_screen_list.GetItemString( ll_Scrow, 'screen_style' )
	ls_fixfield = dw_screen_list.getItemString( ll_Scrow, 'fix_field' )
	
	as_fixfield[ upperbound( as_fixfield) + 1 ] = ls_fixfield
	
	al_SCList[UpperBound(al_SCList) + 1] = dw_screen_list.GetItemNumber(ll_SCRow,"screen_id")
	If ls_Screen_Style = 'G' Then
		as_DOList[UpperBound(as_DOList) + 1] = dw_screen_list.GetItemString(ll_SCRow,"grid_dataobject")
	Else
		as_DOList[UpperBound(as_DOList) + 1] = dw_screen_list.GetItemString(ll_SCRow,"screen_dataobject")
	End If
	if ll_SCRow >= dw_screen_list.RowCount() then Exit
	ll_SCRow = dw_screen_list.Find("selected = 1",ll_SCRow + 1,dw_screen_list.RowCount())
loop

end subroutine

on w_screensyntaxupdate.create
int iCurrent
call super::create
this.cb_resetsyntax=create cb_resetsyntax
this.cb_selectview=create cb_selectview
this.dw_screen_list=create dw_screen_list
this.dw_view_list=create dw_view_list
this.cb_upload=create cb_upload
this.cb_download=create cb_download
this.cb_cb_selectscreen=create cb_cb_selectscreen
this.cb_close=create cb_close
this.cbx_dynamicscreen=create cbx_dynamicscreen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_resetsyntax
this.Control[iCurrent+2]=this.cb_selectview
this.Control[iCurrent+3]=this.dw_screen_list
this.Control[iCurrent+4]=this.dw_view_list
this.Control[iCurrent+5]=this.cb_upload
this.Control[iCurrent+6]=this.cb_download
this.Control[iCurrent+7]=this.cb_cb_selectscreen
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cbx_dynamicscreen
end on

on w_screensyntaxupdate.destroy
call super::destroy
destroy(this.cb_resetsyntax)
destroy(this.cb_selectview)
destroy(this.dw_screen_list)
destroy(this.dw_view_list)
destroy(this.cb_upload)
destroy(this.cb_download)
destroy(this.cb_cb_selectscreen)
destroy(this.cb_close)
destroy(this.cbx_dynamicscreen)
end on

event open;if Not IsValid(ids_Screen) then ids_Screen = Create DataStore

is_CurDir = GetCurrentDirectory()

if AppeonGetClientType() = "WEB" then This.Resize(This.Width + 18,This.Height + 22)

end event

event close;ChangeDirectory(is_CurDir)

if IsValid(ids_Screen) then Destroy ids_Screen

end event

event closequery;//
end event

type cb_resetsyntax from commandbutton within w_screensyntaxupdate
integer x = 2560
integer y = 1928
integer width = 393
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset Syntax"
end type

event clicked;//modified by gavins 20120312 grid

long		ll_VCList[],ll_SCList[],ll_RtnVal,ll_ErrCnts
long		ll_VCCycle,ll_VCCnts,ll_SCCycle,ll_SCCnts
String		ls_DOList[],ls_Syntax, ls_dw_opsyntax, ls_lookuplist, ls_spcelist, ls_fixField[], ls_err_text=''

DateTime	ldt_Now

of_GetCheckedList(ll_VCList,ll_SCList,ls_DOList, ls_fixField )
ll_VCCnts = UpperBound(ll_VCList)
ll_SCCnts = UpperBound(ll_SCList)
if ll_VCCnts <= 0 or ll_SCCnts <= 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please check at least one view and one screen.")
	Return
end if

ll_RtnVal = MessageBox("Confirm Reset","Are you sure you want to reset the screen syntax?",Question!,YesNo!,2)
if ll_RtnVal <> 1 then Return

This.Enabled = false
SetPointer(HourGlass!)

ldt_Now = DateTime(Today(),Now())

for ll_SCCycle = 1 to ll_SCCnts
	ids_Screen.DataObject = ls_DOList[ll_SCCycle]
	ls_Syntax = ids_Screen.Describe("DataWindow.Syntax")
	
	/*****************************************************///added by gavins 20120519
	if gf_get_opsyntax(ls_Syntax,ls_fixField[ll_SCCycle],ls_dw_opsyntax,ls_lookuplist) < 0 then ls_dw_opsyntax = ls_Syntax
	
	for ll_VCCycle = 1 to ll_VCCnts
						
		//modified by gavins 20120312 grid
		UPDATE ctx_screen
			SET dw_sql = ( case when screen_style = 'F' then :ls_Syntax else dw_sql end ),
				grid_sql = ( case when screen_style = 'G' then :ls_Syntax else grid_sql end ),
				dw_opsql = ( case when screen_style = 'F' then :ls_dw_opsyntax else dw_opsql end ),
				grid_opsql = ( case when screen_style = 'G' then :ls_dw_opsyntax else grid_opsql end ),
			modify_date = :ldt_Now, lookup_list = :ls_lookuplist
		 WHERE data_view_id = :ll_VCList[ll_VCCycle] AND
				 screen_id = :ll_SCList[ll_SCCycle];
				 
		ls_err_text = String( ll_VCList[ll_VCCycle] ) + '-' + string( ll_SCList[ll_SCCycle] )
				
		if SQLCA.SQLCode = 0 then
			COMMIT;
		else
			MessageBox("Error",SQLCA.SQLErrText,StopSign!)
			ROLLBACK;
			ll_ErrCnts++
		end if
	next
next
gnv_debug.of_output( true, 'Reset Screen=' +  ls_err_text	) //added by gavins 20120919

SetPointer(Arrow!)
This.Enabled = true

if ll_ErrCnts <= 0 then
	MessageBox("Congratulations","Screen syntax is updated successfully!")
end if

end event

type cb_selectview from commandbutton within w_screensyntaxupdate
integer x = 23
integer y = 1928
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;long		ll_Row,ll_Cycle,ll_Cnts,ll_data[]

ll_Row = dw_view_list.GetRow()

ll_Cnts = dw_view_list.RowCount()

if This.Text = "Select All" then
	for ll_Cycle = 1 to ll_Cnts
		ll_data[ll_Cycle] = 1
	next
	dw_view_list.Object.Selected.Primary = ll_data
	This.Text = "Deselect All"
else
	for ll_Cycle = 1 to ll_Cnts
		ll_data[ll_Cycle] = 0
	next
	dw_view_list.Object.Selected.Primary = ll_data
	This.Text = "Select All"
end if

dw_view_list.SetRow(ll_Row)

end event

type dw_screen_list from datawindow within w_screensyntaxupdate
integer x = 1184
integer y = 16
integer width = 2117
integer height = 1884
integer taborder = 20
string dataobject = "d_screen_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(SQLCA)
dw_screen_list.Retrieve(1001)

end event

event clicked;This.SetRow(Row)

end event

type dw_view_list from datawindow within w_screensyntaxupdate
integer x = 23
integer y = 16
integer width = 1138
integer height = 1884
integer taborder = 10
string dataobject = "d_all_view_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(SQLCA)
This.Retrieve()

end event

event clicked;This.SetRow(Row)

end event

event rowfocuschanged;long	ll_view_id

if CurrentRow <= 0 then Return

if cbx_DynamicScreen.Checked then
	ll_view_id = dw_view_list.GetItemNumber(CurrentRow,"data_view_id")
	dw_screen_list.Retrieve(ll_view_id)
end if

end event

type cb_upload from commandbutton within w_screensyntaxupdate
integer x = 2048
integer y = 1928
integer width = 503
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Upload Syntax..."
end type

event clicked;long		ll_VCList[],ll_SCList[],ll_VCRow,ll_SCRow,ll_VCCnts,ll_SCCnts
long		ll_RtnVal,ll_Pos,ll_Cycle,ll_ErrCnts
String	ls_PathName,ls_FileName,ls_Syntax,ls_DOList[], ls_fixField[], ls_lookuplist, ls_dw_opsyntax
String	ls_view_name,ls_screen_name,ls_Detail, ls_Screenstyle, ls_Err, ls_errtext=''

DateTime	ldt_Now
DataStore	lds_Create


lds_Create = Create DataStore

of_GetCheckedList(ll_VCList,ll_SCList,ls_DOList, ls_fixField )
ll_VCCnts = UpperBound(ll_VCList)
ll_SCCnts = UpperBound(ll_SCList)
if ll_VCCnts <= 0 or ll_SCCnts <= 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please check at least one view and check only one screen.")
	Return
elseif ll_SCCnts > 1 then
	MessageBox(gnv_app.iapp_object.DisplayName,"You can upload only one screen at a time.")
	Return
end if

ll_RtnVal = GetFileOpenName("Select Import Files",ls_PathName,ls_FileName,"srd","DataWindows (*.srd),*.srd")
if ll_RtnVal <> 1 then Return

of_ReadSTRFromfile(ls_PathName,ls_Syntax)

ll_Pos = Pos(ls_Syntax,EXPORTHEADERFLAG)
if ll_Pos > 0 then
	ll_Pos = Pos(ls_Syntax,ENTERCHAR,ll_Pos + Len(EXPORTHEADERFLAG))
	ls_Syntax = Mid(ls_Syntax,ll_Pos + Len(ENTERCHAR))
end if

ls_Detail = "View to update:" + ENTERCHAR

ll_SCRow = dw_screen_list.Find("screen_id = " + String(ll_SCList[1]),1,dw_screen_list.RowCount())
if ll_SCRow > 0 then
	ls_screen_name = dw_screen_list.GetItemString(ll_SCRow,"screen_name")
	ls_Screenstyle = dw_screen_list.GetItemString(ll_SCRow,"screen_style")
	
	for ll_Cycle = 1 to ll_VCCnts
		ll_VCRow = dw_view_list.Find("data_view_id = " + String(ll_VCList[ll_Cycle]),1,dw_view_list.RowCount())
		if ll_VCRow > 0 then
			ls_view_name = dw_view_list.GetItemString(ll_VCRow,"data_view_name")
			ls_Detail += String(ll_VCList[ll_Cycle]) + "," + ls_view_name + ENTERCHAR
		end if
	next
	
	ls_Detail += ENTERCHAR + "Screen to update: " + ENTERCHAR
	ls_Detail += String(ll_SCList[1]) + ", " + ls_screen_name + ENTERCHAR + ENTERCHAR + &
					"File Name: " + ls_PathName + ENTERCHAR + ENTERCHAR
	
	ll_RtnVal = MessageBox("Confirm Overwrite",ls_Detail + "Are you sure you want to update the screen syntax?",Question!,YesNo!,2)
	if ll_RtnVal <> 1 then Return
	
	ldt_Now = DateTime(Today(),Now())
		
	lds_Create.Create( ls_Syntax, ls_Err )
	If len( ls_Err ) > 0 Then
		MessageBox( 'Screen to update' ,ls_screen_name + ':' + ls_Err )
		Return
	End If
	
	/***********************************///added by gavins 20120312 grid processing=1
	If Pos( ls_Syntax,"processing=1") = 0 And ls_Screenstyle = 'G'  Then
		MessageBox( 'Confirm', 'The DataWindows you unloaded are not of Grid Style. Please confirm!' )
		Return
	End If
	/***********************************/
	This.Enabled = false
	SetPointer(HourGlass!)
	
	/*****************************************************///added by gavins 20120519
	if gf_get_opsyntax(ls_Syntax,ls_fixField[1],ls_dw_opsyntax,ls_lookuplist) < 0 then ls_dw_opsyntax = ls_Syntax
	
	
	for ll_Cycle = 1 to ll_VCCnts
		If ls_Screenstyle = 'G' Then
			UPDATE ctx_screen
				SET  	grid_sql = :ls_Syntax,grid_opsql = :ls_dw_opsyntax,
				modify_date = :ldt_Now
			 WHERE data_view_id = :ll_VCList[ll_Cycle] AND
					 screen_id = :ll_SCList[1];
		Else
			UPDATE ctx_screen
				SET  dw_sql =   :ls_Syntax,dw_opsql = :ls_dw_opsyntax,
					modify_date = :ldt_Now
			 WHERE data_view_id = :ll_VCList[ll_Cycle] AND
					 screen_id = :ll_SCList[1];
			
		End If
		ls_errtext = ls_errtext +string( ll_VCList[ll_Cycle] ) + '-' +  string( ll_SCList[1] )			
		if SQLCA.SQLCode = 0 then
			COMMIT;
		else
			MessageBox("Error",SQLCA.SQLErrText,StopSign!)
			ROLLBACK;
			ll_ErrCnts++
		end if
	next
	gnv_debug.of_output( true, 'Upload Screen=' +  ls_errtext	) //added by gavins 20120919
	SetPointer(Arrow!)
	This.Enabled = true
end if

if ll_ErrCnts <= 0 then
	MessageBox("Congratulations","Screen syntax is updated successfully!")
end if

end event

type cb_download from commandbutton within w_screensyntaxupdate
integer x = 1536
integer y = 1928
integer width = 503
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Download Syntax..."
end type

event clicked;long		ll_VCList[],ll_SCList[],ll_RtnVal
long		ll_VCCycle,ll_VCCnts,ll_SCCycle,ll_SCCnts
String	ls_CurDir,ls_FileName,ls_Syntax,ls_DOList[], ls_fixfield[]

of_GetCheckedList(ll_VCList,ll_SCList,ls_DOList, ls_fixfield )
ll_VCCnts = UpperBound(ll_VCList)
ll_SCCnts = UpperBound(ll_SCList)
if ll_VCCnts <= 0 or ll_SCCnts <= 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please check at least one view and one screen.")
	Return
end if

ls_CurDir = GetCurrentDirectory()
ll_RtnVal = GetFolder("Please select a directory.",ls_CurDir)
if ll_RtnVal <> 1 then Return

if Right(ls_CurDir,1) <> '\' then ls_CurDir += '\'

This.Enabled = false
SetPointer(HourGlass!)

for ll_VCCycle = 1 to ll_VCCnts
	for ll_SCCycle = 1 to ll_SCCnts
		ls_Syntax = of_GetScreenSyntax(ll_VCList[ll_VCCycle],ll_SCList[ll_SCCycle])
		if Not IsNull(ls_Syntax) and Trim(ls_Syntax) <> "" then
			ls_FileName = ls_CurDir + String(ll_VCList[ll_VCCycle]) + "-" + String(ll_SCList[ll_SCCycle]) + ".srd"
			of_WriteSTRToFile(ls_FileName,ls_Syntax,true)
		end if
	next
next

SetPointer(Arrow!)
This.Enabled = true

Run("Explorer.exe " + ls_CurDir)

end event

type cb_cb_selectscreen from commandbutton within w_screensyntaxupdate
integer x = 1184
integer y = 1928
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;long		ll_Row,ll_Cycle,ll_Cnts,ll_data[]

ll_Row = dw_screen_list.GetRow()

ll_Cnts = dw_screen_list.RowCount()

if This.Text = "Select All" then
	for ll_Cycle = 1 to ll_Cnts
		ll_data[ll_Cycle] = 1
	next
	dw_screen_list.Object.Selected.Primary = ll_data
	This.Text = "Deselect All"
else
	for ll_Cycle = 1 to ll_Cnts
		ll_data[ll_Cycle] = 0
	next
	dw_screen_list.Object.Selected.Primary = ll_data
	This.Text = "Select All"
end if

dw_screen_list.SetRow(ll_Row)

end event

type cb_close from commandbutton within w_screensyntaxupdate
integer x = 2962
integer y = 1928
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)

end event

type cbx_dynamicscreen from checkbox within w_screensyntaxupdate
integer x = 402
integer y = 1944
integer width = 768
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Display Existing Screens Only"
end type

event clicked;long	ll_Row,ll_view_id

if This.Checked then
	ll_Row = dw_view_list.GetRow()
	ll_view_id = dw_view_list.GetItemNumber(ll_Row,"data_view_id")
else
	ll_view_id = 1001
end if

dw_screen_list.Retrieve(ll_view_id)

end event

