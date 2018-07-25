$PBExportHeader$w_import_apps.srw
forward
global type w_import_apps from window
end type
type st_status1 from statictext within w_import_apps
end type
type ole_edit from olecustomcontrol within w_import_apps
end type
type st_7 from statictext within w_import_apps
end type
type cb_4 from commandbutton within w_import_apps
end type
type cb_1 from commandbutton within w_import_apps
end type
type cb_3 from commandbutton within w_import_apps
end type
type st_3 from statictext within w_import_apps
end type
type dw_facility from datawindow within w_import_apps
end type
type st_status from statictext within w_import_apps
end type
type dw_1 from datawindow within w_import_apps
end type
type dw_2 from datawindow within w_import_apps
end type
type cb_2 from commandbutton within w_import_apps
end type
type st_6 from statictext within w_import_apps
end type
type gb_3 from groupbox within w_import_apps
end type
end forward

global type w_import_apps from window
integer x = 1056
integer y = 484
integer width = 2505
integer height = 1400
boolean titlebar = true
string title = "Import Applications"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 33551856
st_status1 st_status1
ole_edit ole_edit
st_7 st_7
cb_4 cb_4
cb_1 cb_1
cb_3 cb_3
st_3 st_3
dw_facility dw_facility
st_status st_status
dw_1 dw_1
dw_2 dw_2
cb_2 cb_2
st_6 st_6
gb_3 gb_3
end type
global w_import_apps w_import_apps

type variables
String is_app_path
String is_app_path_only

end variables

forward prototypes
public function integer of_clear_annos (long ii_app_id)
public function string of_check_4_dupe_name (long ai_app, string as_name)
end prototypes

public function integer of_clear_annos (long ii_app_id);//Start change 04.10.2009 - maha - recorrected replaced code
//Long li_Cnt
Long i
//Long p
String ls_annotation_group
//Integer li_page_cnt
String ls_group
String ls_label_data
String ls_field_description
String ls_object_type
String ls_field_type
String ls_lookup_link_type
String ls_group_nm
String ls_fld_desc
String ls_lookup_link_field
String ls_fld_display
String ls_font_type
Long ll_field_id
Long ll_table_id
Long li_field_len
long li_app_field_id //modified 071802 maha
String ls_fld_nm
String ls_tbl_nm
long li_fld_cnt
Long li_x_pos
Long li_y_pos
Long li_fld_loop
Long li_prev_scrollY
Long li_prev_scrollX
Long li_cnt
Integer p
INTEGER LI_PAGE_CNT
Integer li_current_page

//Start Code Change ---- 04.14.2006 #391 maha trap 5207
if not fileexists(is_app_path + String( ii_app_id ) + ".tif") then
	messagebox("","Unable to find file for importing: " + is_app_path + String( ii_app_id ) + ".tif")
	return 0
end if
//End Code Change---04.14.2006

ole_edit.Object.Image( is_app_path + String( ii_app_id ) + ".tif" )

li_page_cnt = ole_edit.Object.PageCount()

FOR p = 1 TO li_page_cnt

	st_status.Text = "Clearing annotations from application " + String( ii_app_id ) + ".tif page " + String( p ) + " of " + String( li_page_cnt ) + "   " + String( ii_app_id  )



	ole_edit.Object.Page( p )
	ole_edit.Object.Display()
	
	ole_edit.Object.SelectAnnotationGroup( "" )	

	li_cnt = ole_edit.Object.AnnotationGroupCount()

	FOR i = 0 TO li_cnt - 1
		ls_annotation_group = ole_edit.Object.GetAnnotationGroup( 0 )
		ole_edit.Object.DeleteAnnotationGroup( ls_annotation_group )		
	END FOR



	ole_edit.Object.Save()
END FOR


ole_edit.Object.ClearDisplay( )

Return 0
end function

public function string of_check_4_dupe_name (long ai_app, string as_name);//maha 072004 called from clicked of cb_1

integer cnt
string ls_name
string ls_return
string res
string s
string ls_new
long ll_app

ls_name = as_name

select count( application_name) into : cnt from app_hdr where application_name = :ls_name;

if cnt > 0 then
	openwithparm(w_app_dupe_choices,ls_name)
	res = message.stringparm
	s = MidA(res,1,1)
	if s = "N" then
		ls_return = res
	elseif s = "O" then //if rename old
		ls_new = MidA(res,3)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-01
		//$<modify> 04.01.2006 By: Cao YongWang
		//$<reason> Performance tuning.
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		/*
		select app_id into :ll_app from app_hdr where application_name = :ls_name;
		update app_hdr 
		set application_name = :ls_new
		where app_id = :ll_app;
		commit using sqlca;
		*/
		gnv_appeondb.of_autocommit()
		update app_hdr 
		set application_name = :ls_new
		where app_id = (select app_id from app_hdr where application_name = :ls_name);
		commit using sqlca;
		//---------------------------- APPEON END ----------------------------

		ls_return = "C"
	else
		ls_return = "C"
	end if
else
	ls_return = "C"
end if




return ls_return

end function

event open;
//SQLCA.DBMS="ODBC"
//SQLCA.DBParm = "ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Login", "Inital Login Failed!  Check your ODBC configuration")
//	Return -1
//END IF
//

dw_1.SetTransObject( sqlca )
dw_2.SetTransObject( sqlca )

dw_facility.SetTransObject( sqlca )
dw_facility.InsertRow( 1 )

SELECT ids.intelliapp_app_path
INTO :is_app_path  
FROM ids  ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Login", "Inital Login Failed!  Check your ODBC configuration")
	Return -1
END IF

IF LenA( is_app_path ) = 0 THEN
	MessageBox("Application Path", "You must first set your application image path before using the Import utility.  Select File->Set Image Path in Application Mapping Utility to set you path." )
END IF

IF RightA( is_app_path, 1 ) <> "\" THEN
	is_app_path = is_app_path + "\"
END IF

is_app_path_only = is_app_path

//is_app_path = is_app_path + "intelliapps.exe"

//ClipBoard( is_app_path )

//st_path.Text = is_app_path
//st_path1.Text = is_app_path

end event

on w_import_apps.create
this.st_status1=create st_status1
this.ole_edit=create ole_edit
this.st_7=create st_7
this.cb_4=create cb_4
this.cb_1=create cb_1
this.cb_3=create cb_3
this.st_3=create st_3
this.dw_facility=create dw_facility
this.st_status=create st_status
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_2=create cb_2
this.st_6=create st_6
this.gb_3=create gb_3
this.Control[]={this.st_status1,&
this.ole_edit,&
this.st_7,&
this.cb_4,&
this.cb_1,&
this.cb_3,&
this.st_3,&
this.dw_facility,&
this.st_status,&
this.dw_1,&
this.dw_2,&
this.cb_2,&
this.st_6,&
this.gb_3}
end on

on w_import_apps.destroy
destroy(this.st_status1)
destroy(this.ole_edit)
destroy(this.st_7)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.dw_facility)
destroy(this.st_status)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.st_6)
destroy(this.gb_3)
end on

type st_status1 from statictext within w_import_apps
integer x = 64
integer y = 1168
integer width = 2327
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type ole_edit from olecustomcontrol within w_import_apps
event keydown ( ref integer keycode,  integer shift )
event keyup ( ref integer keycode,  integer shift )
event keypress ( ref integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  ref string description,  long scode,  string source,  string helpfile,  long helpcontext,  ref boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  ref boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( ref long mode )
event baddocumentfiletype ( long page,  ref boolean errorout,  ref boolean skippage,  ref boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( ref string overlayfilename,  ref boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( ref boolean bcancelmove )
event readystatechange ( long readystate )
integer x = 219
integer y = 1436
integer width = 987
integer height = 640
integer taborder = 50
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "w_import_apps.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type st_7 from statictext within w_import_apps
integer x = 69
integer y = 684
integer width = 2277
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " 3)  Follow the directions on the web page to download the applications."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_import_apps
integer x = 69
integer y = 540
integer width = 2277
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = " 2) &Go to IntelliSoft Web Site"
end type

event clicked;string ls_url
Inet  iinet_base

ls_url = "http://www2.intellisoftgroup.com/intelliapp/apps.cfm?path=" + is_app_path   //Start Code Change ----10.08.2013 #V14 maha - 2 added to url
if gi_citrix = 1 then
	of_open_web(ls_url)
else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 06.23.2006 By: Liang QingShi
	//$<reason>  GetContextService is currently unsupported. 
	//$<modification> Replace GetContextService with ShellExecuteA to provide the
	//$<modification> same functionality.
	/*
	GetContextService("Internet", iinet_base)
	iinet_base.HyperlinkToURL(ls_url)
	*/
	String ls_null
	setnull(ls_null)
	//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
	ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
	//---------------------------- APPEON END ----------------------------
	
end if




end event

type cb_1 from commandbutton within w_import_apps
integer x = 69
integer y = 800
integer width = 2277
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "4) Once the Applications have been downloaded, click to import."
end type

event clicked;
//John d created for version 4.1
IF IsNull( dw_facility.GetItemNumber( 1, "facility_id" )) THEN
	MessageBox("Select Error", "You must select an organization to import under." )
	Return -1
END IF


st_status.Text = "Starting import."

Long ll_field_id
String ls_from
String ls_to
string ls_hdr_file, named
String ls_orig_dir
string ls_drive, ls_field_prop_file
String ls_app_path
String ls_alternative_path
string ls_app_name
string ls_new
Long value, i, li_rc, li_app_id, li_cnt, li_rows, li_num_apps
Long li_next_app_id
Long li_fld_rc
Long f
Long li_find
Long ll_next_field_id
Integer li_facility_id
String	ls_Rtn
boolean lb_map_field
boolean lb_upload //maha 07.06.2015 - for ipop

dw_facility.AcceptText( )
li_facility_id = Integer( dw_facility.GetText() )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 04.01.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;
*/
ls_app_path = gnv_data.of_getitem("ids" , "intelliapp_app_path" , False)
//---------------------------- APPEON END ----------------------------

ls_orig_dir = ls_app_path

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

String ls_temp_path
String ls_dir[]
Integer li_start
Integer li_dir_cnt


//ls_temp_path = ls_app_path
//li_start = 1
//DO WHILE Len( ls_temp_path ) > 0 
//	li_dir_cnt++
//	li_start = POS( ls_temp_path, "\" )
//	IF li_start > 0 THEN
//		ls_dir[ li_dir_cnt ] = Mid( ls_temp_path, 1, li_start )
//		IF li_start > 8 THEN
//			ls_dir[ li_dir_cnt ] = Mid( ls_dir[li_dir_cnt], 1, 6 ) + "~~1" + "\"
//		END IF
//	ELSE
//		ls_dir[ li_dir_cnt ] = ls_temp_path
//	END IF
//	ls_temp_path = Mid( ls_temp_path, li_start + 1,  1000 )
//LOOP
//
////ls_app_path = ""
//FOR i = 1 TO upperbound( ls_dir)
//	ls_alternative_path = ls_alternative_path + ls_app_path + ls_dir[ i ]
//	//ls_app_path = ls_app_path + ls_dir[ i ]
//END FOR

//messagebox("",ls_orig_dir + "app_hdr.txt")
IF NOT FileExists( ls_orig_dir + "app_hdr.txt" ) THEN
	MessageBox("Import Error", "Can't find file " + ls_orig_dir + "app_hdr.txt.  Try downloading applications again." )
	Return -1	
END IF
//import data
dw_1.reset() //maha 072104
dw_2.reset()
li_cnt = 0

li_rows = dw_1.ImportFile( ls_orig_dir + "app_hdr.txt" )
li_num_apps = li_rows
IF li_rows < 0 THEN
	MessageBox("Import failed", "Can't find file app_hdr.txt!" )
	Return -1
END IF

IF NOT FileExists( ls_orig_dir + "app_fld_prop.txt" ) THEN
	MessageBox("Import Error", "Error copying " + ls_orig_dir + "app_fld_prop.txt file" )
	Return -1
END IF

st_status.Text = "Importing Field Data"

li_rows = dw_2.ImportFile( ls_orig_dir + "app_fld_prop.txt" )
IF li_rows < 0 THEN
	MessageBox("Import failed", "ImportFile app_fld_prop.txt failed!" )
	Return -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 04.01.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
SELECT Max( app_id ) 
INTO :li_next_app_id
FROM app_hdr;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Error 2", SQLCA.SQLERRTEXT )
END IF
IF IsNull( li_next_app_id ) THEN
	li_next_app_id = 1
END IF

SELECT Max( app_field_id ) 
INTO :ll_next_field_id
FROM app_field_prop;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Error 2", SQLCA.SQLERRTEXT )
END IF
IF IsNull( ll_next_field_id ) THEN
	ll_next_field_id = 1
END IF
*/
gnv_appeondb.of_startqueue()
SELECT Max( app_id ) 
INTO :li_next_app_id
FROM app_hdr;

SELECT Max( app_field_id ) 
INTO :ll_next_field_id
FROM app_field_prop;
gnv_appeondb.of_commitqueue()

IF IsNull( li_next_app_id ) THEN
	li_next_app_id = 1
END IF

IF IsNull( ll_next_field_id ) THEN
	ll_next_field_id = 1
END IF
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Stephen 12.23.2014 for Q using an online application that can’t be mapped--------
lb_map_field = false
if messagebox("Prompt", "Do you want to set the mapping fields?", question!, yesno!,1) = 1 then
	lb_map_field = true
else
	dw_2.reset()
end if
//---------End Added ------------------------------------------------------

li_rc = dw_1.RowCount( )
li_fld_rc = dw_2.RowCount( )

//clear annotations
FOR i = 1 TO li_rc
	li_app_id = dw_1.GetItemNumber( i, "app_id" )	
	of_clear_annos( li_app_id )	
END FOR

ole_edit.Object.ClearDisplay()

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-14 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.

ls_Rtn = f_ExaWriteRight(ls_app_path)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return
end if

//---------------------------- APPEON END ----------------------------

//rename
FOR i = 1 TO li_rc
	
	li_next_app_id++
	
	st_status1.Text = "Importing Data For Application " + String( i ) + " of " + String( li_rc )
	
	li_app_id = dw_1.GetItemNumber( i, "app_id" )
	ls_app_name = dw_1.GetItemstring( i, "application_name" )
	
	DO WHILE TRUE //trap to see that the new app_id to be assigned does not match any of the import app ids
		li_find = dw_1.Find( "app_id = " + String( li_next_app_id ), 1, 9999 )
		IF li_find > 0 THEN
			li_next_app_id++
		ELSE
			EXIT
		END IF
	LOOP

	ls_from = ls_app_path + String( li_app_id ) + ".tif" 
	ls_to =   ls_app_path + String( li_next_app_id) + ".tif" 

	if NOT fileexists(ls_from) then //trap maha 030904
		 //Start Code Change ----07.06.2015 #V15 maha - modified trap for upload of ipop files
		lb_upload = false
		//messagebox("File?","Unable to find file to copy, " + ls_from)
		//return
	else
		lb_upload = true
	end if
	 //End Code Change ----07.06.2015 
	
	//------Begin Modified by Alfee 03.10.2009-----------
	//<$Reason>To keep the same compression info
	 if lb_upload = true then //Start Code Change ----07.06.2015 #V15 maha 
		IF FileCopy(ls_from, ls_to, TRUE ) <> 1 THEN
			MessageBox("File?","Unable copy the file " + ls_from + " to " + ls_to)
			RETURN
		END IF
		//delete org tif file  maha 071904
		filedelete(ls_from)
	end if
	

	//maha 072004 if a duplicate name and user wants to rename 
	ls_new = of_check_4_dupe_name(li_next_app_id,ls_app_name)
	
	if MidA(ls_new,1,1) = "N" then
		dw_1.SetItem( i, "application_name", MidA(ls_new,3) )
	end if

	dw_1.SetItem( i, "app_id", li_next_app_id )
	dw_1.SetItem( i, "facility_id", li_facility_id )

	dw_2.SetFilter( "app_id = " + String( li_app_id ) )
	dw_2.Filter( )
	li_fld_rc = dw_2.RowCount()
	FOR f = 1 TO li_fld_rc
		dw_2.SetItem( f, "app_id", li_next_app_id )		
	END FOR
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 06.08.2006 By: LeiWei
	//$<modification> Upload image files to database when importing new applications.
	
	
	//Start Code Change ----07.06.2015 #V15 maha  -added boolean check
	if lb_upload then
		Integer li_image_storage_type
	
		li_image_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "image_storage_type", FALSE))
		IF Isnull(li_image_storage_type) THEN li_image_storage_type = 0
		IF Upper( AppeonGetClientType() ) <> "PB" OR li_image_storage_type = 1 THEN
			n_appeon_storage_area lnv_storage_area	
			lnv_storage_area.of_upload_app_image( li_next_app_id, ls_to )
		END IF
	end if 
	//End Code Change ----07.06.2015

	//---------------------------- APPEON END ----------------------------
	
END FOR

if lb_map_field = true then  //(Appeon)Stephen 12.23.2014 - Q using an online application that can’t be mapped 
	dw_2.SetFilter( "" )
	dw_2.Filter( )
	li_fld_rc = dw_2.RowCount()	
		
	//update app fields
	SELECT Max( app_field_id ) 
	INTO :ll_next_field_id
	FROM app_field_prop;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Error 2", SQLCA.SQLERRTEXT )
	END IF
	IF IsNull( ll_next_field_id ) THEN
		ll_next_field_id = 1
	END IF
	
	FOR i = 1 TO li_fld_rc
		ll_next_field_id++
		dw_2.SetItem( i, "app_field_id", ll_next_field_id )	
	END FOR
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 04.01.2006 By: Cao YongWang
//$<reason>Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

IF dw_1.Update() = -1 THEN
	MessageBox("Failed" , "Update Failed dw_1" )
	Return -1
END IF

if lb_map_field = true then  //(Appeon)Stephen 12.23.2014 - Q using an online application that can’t be mapped
	IF dw_2.Update() = -1 THEN
		MessageBox("Failed" , "Update Failed dw_2" )
		Return -1
	END IF
end if
commit using sqlca;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 04.01.2006 By: Cao YongWang
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------
st_status1.Text = ""
st_status.Text = String ( li_num_apps ) + " credentialing applications imported."

FileDelete( ls_app_path + "app_hdr.txt" )
FileDelete( ls_app_path + "app_fld_prop.txt" )

//RUN( "rt.bat", Maximized! )

//------------------- APPEON BEGIN -------------------
//$<add> Evan 11.10.2010
//$<reason> V10.5-App Mapping
if IsValid(w_train_app) then
	w_train_app.tab_1.tabpage_select.dw_app_tv.Retrieve()
	w_train_app.tab_1.tabpage_select.dw_app_tv.Expand(1, 1)
end if
//------------------- APPEON END ---------------------
end event

type cb_3 from commandbutton within w_import_apps
boolean visible = false
integer x = 997
integer y = 1724
integer width = 521
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Extract Zip File"
end type

event clicked;String ls_app_path
String k

SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

RUN( ls_app_path + "intelliapps.exe" )
end event

type st_3 from statictext within w_import_apps
integer x = 69
integer y = 356
integer width = 2277
integer height = 152
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean enabled = false
string text = "1) Select Organization To which the Applications will be connected"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_facility from datawindow within w_import_apps
integer x = 82
integer y = 420
integer width = 2240
integer height = 76
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_select_app_facility"
boolean border = false
boolean livescroll = true
end type

type st_status from statictext within w_import_apps
integer x = 82
integer y = 1232
integer width = 2327
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_import_apps
integer x = 73
integer y = 1724
integer width = 2226
integer height = 340
integer taborder = 80
string dataobject = "d_imp_app_hdr"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_import_apps
integer x = 73
integer y = 2080
integer width = 2217
integer height = 360
integer taborder = 90
string dataobject = "d_imp_field_prop"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_import_apps
integer x = 919
integer y = 1000
integer width = 475
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type st_6 from statictext within w_import_apps
integer x = 50
integer y = 36
integer width = 2437
integer height = 140
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "To view a complete list of applications that are currently available from IntelliSoft Group Inc, click on the Go To Web Site button below."
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_import_apps
integer x = 37
integer y = 276
integer width = 2414
integer height = 688
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Import Mapped Credentailing Applications"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Bw_import_apps.bin 
2D00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005e2ccb1001d1c1aa00000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000027300000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c000000005e2ccb1001d1c1aa5e2ccb1001d1c1aa000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b00000030000002430000001000000100000000880000010100000090000001020000009800000103000000a000000104000000a800000105000000b000000106000000c400000107000000cc00000108000000d400000109000000dc0000010a000000e40000010b000000ec0000010c000000f40000010d000000fc0000010e00000104000000000000010c000000030002000500000003000016530000000300001089000000030000006000000002000000010000001e0000000945676d493174696400000000000000032ffffffe0000000b0000ffff00000002000064c9000000020000bcac000000020000bcac000000030018bcfc000000030018bcfc0000000b0000ffff0000000b0000ffff00000010000000000000000100010b0000000b0065726c0076726573003164650000010d0000000b73657262657672650c0031640b0000016c000000657365726465767201090032000b00007273000072657365316465760001080000000e0067616d006966696e6f7a72650e006d6f0b000001620000006573657264657672010a0032000b00007273000072657365326465760001030000000c0074735f00706b636f73706f720001040000000c00726f620073726564656c79740001050000000d00616d69006f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e000001070000001363726f666c6966656e696c65676e696b060078310f00000175000000626f646e656666757a6973720100006500090000765f00006973726500006e6f0000000000000000000000000002000500001653000010890000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100bd4064c91000bd40100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Bw_import_apps.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
