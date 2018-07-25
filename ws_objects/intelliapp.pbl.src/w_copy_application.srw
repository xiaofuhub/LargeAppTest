$PBExportHeader$w_copy_application.srw
forward
global type w_copy_application from w_response
end type
type st_2 from statictext within w_copy_application
end type
type dw_facility from datawindow within w_copy_application
end type
type st_3 from statictext within w_copy_application
end type
type cb_1 from commandbutton within w_copy_application
end type
type cb_2 from commandbutton within w_copy_application
end type
type dw_hdr_from from datawindow within w_copy_application
end type
type dw_fld_prop_from from datawindow within w_copy_application
end type
type dw_hdr_to from datawindow within w_copy_application
end type
type dw_fld_prop_to from datawindow within w_copy_application
end type
type sle_appname from singlelineedit within w_copy_application
end type
type ole_edit from olecustomcontrol within w_copy_application
end type
type gb_1 from groupbox within w_copy_application
end type
type dw_app from datawindow within w_copy_application
end type
type gb_2 from groupbox within w_copy_application
end type
end forward

global type w_copy_application from w_response
integer x = 933
integer y = 656
integer width = 2533
integer height = 1020
boolean controlmenu = false
long backcolor = 33551856
st_2 st_2
dw_facility dw_facility
st_3 st_3
cb_1 cb_1
cb_2 cb_2
dw_hdr_from dw_hdr_from
dw_fld_prop_from dw_fld_prop_from
dw_hdr_to dw_hdr_to
dw_fld_prop_to dw_fld_prop_to
sle_appname sle_appname
ole_edit ole_edit
gb_1 gb_1
dw_app dw_app
gb_2 gb_2
end type
global w_copy_application w_copy_application

type variables
Long il_app_id
Long il_copy_to_id = 0
end variables

on w_copy_application.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_facility=create dw_facility
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_hdr_from=create dw_hdr_from
this.dw_fld_prop_from=create dw_fld_prop_from
this.dw_hdr_to=create dw_hdr_to
this.dw_fld_prop_to=create dw_fld_prop_to
this.sle_appname=create sle_appname
this.ole_edit=create ole_edit
this.gb_1=create gb_1
this.dw_app=create dw_app
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_facility
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.dw_hdr_from
this.Control[iCurrent+7]=this.dw_fld_prop_from
this.Control[iCurrent+8]=this.dw_hdr_to
this.Control[iCurrent+9]=this.dw_fld_prop_to
this.Control[iCurrent+10]=this.sle_appname
this.Control[iCurrent+11]=this.ole_edit
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.dw_app
this.Control[iCurrent+14]=this.gb_2
end on

on w_copy_application.destroy
call super::destroy
destroy(this.st_2)
destroy(this.dw_facility)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_hdr_from)
destroy(this.dw_fld_prop_from)
destroy(this.dw_hdr_to)
destroy(this.dw_fld_prop_to)
destroy(this.sle_appname)
destroy(this.ole_edit)
destroy(this.gb_1)
destroy(this.dw_app)
destroy(this.gb_2)
end on

event open;call super::open;String ls_app_name

il_app_id = Message.DoubleParm

SELECT application_name
INTO :ls_app_name
FROM app_hdr
WHERE app_id = :il_app_id;

This.Title = "Copying " + ls_app_name + "(" + String( il_app_id ) + ")"

dw_facility.SetTransObject( SQLCA )
dw_facility.InsertRow( 0 )

dw_app.SetTransObject( SQLCA )
dw_app.InsertRow( 0 )
end event

event closequery;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.04.2006 By: Rodger Wu
//$<reason> Fix a defect.

Return 0;
//---------------------------- APPEON END ----------------------------
end event

type st_2 from statictext within w_copy_application
integer x = 73
integer y = 248
integer width = 229
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "- OR -"
boolean focusrectangle = false
end type

type dw_facility from datawindow within w_copy_application
integer x = 96
integer y = 560
integer width = 2254
integer height = 88
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_select_app_facility"
boolean border = false
boolean livescroll = true
end type

event constructor;//This.of_setUpdateable( False )
end event

type st_3 from statictext within w_copy_application
integer x = 114
integer y = 500
integer width = 978
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "Select Organization:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_copy_application
integer x = 1093
integer y = 740
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//modified 090304 maha still needs:
//to be able to copy to an existing app_id will have to test for existing data and delete any existing.
//test for duplicate name
Long ll_next_app_id
Long ll_next_field_id
Integer li_rc
integer li_cc  //maha 8.4.09
Integer i
integer ac
integer res
integer li_facid
integer li_map_type   //1= form 2 = website
String ls_app_path,ls_Rtn

dw_facility.AcceptText( )

IF il_copy_to_id = 0 and sle_appname.Text = "" THEN //trap for application 
	MessageBox( "Application Name", "You must select an application to copy to, or enter a new name for the copied application." )
	Return -1
END IF

if il_copy_to_id > 0 then //facility id (copy to selected)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-01
	//$<modify> 04.05.2006 By: Rodger Wu
	//$<reason> Performance Tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/* select facility_id into :li_facid from app_hdr where app_id = :il_copy_to_id; */
	Integer li_found
	datawindowchild ldwc_app
	
	dw_app.GetChild( "app_id", ldwc_app )
	li_found = ldwc_app.Find( "app_hdr_app_id = " + string( il_copy_to_id ), 1, ldwc_app.rowcount() )
	If li_found > 0 Then
		li_facid = ldwc_app.GetItemNumber( li_found, "app_hdr_facility_id" )
	End If
	//---------------------------- APPEON END ----------------------------
else
	li_facid = dw_facility.GetItemNumber( 1, "facility_id" )
	IF IsNull( li_facid ) or li_facid = 0 THEN
		MessageBox("Copy To Facility", "You must select the Facility to copy the selected application to." )
		Return -1
	END IF
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 04.05.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;
*/
ls_app_path = gnv_data.of_GetItem( "ids", "intelliapp_app_path", False )
//---------------------------- APPEON END ----------------------------

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

//Start Code Change ----05.03.2013 #V12 maha - moved above the image check to check type
if il_app_id < 1 then //maha trap added 090204
	messagebox("Copy Function","Please select the application you wish to copy.")
	return
end if

dw_hdr_from.SetTransObject( SQLCA )
dw_hdr_from.Retrieve( il_app_id )

ac = dw_hdr_from.RowCount()
if ac < 1 then //maha trap added 090204
	messagebox("Copy Function","Application Header does not exist.  Please select an application.~rCopy Canceled")
	return
end if

li_map_type = dw_hdr_from.getitemnumber(1, "mapping_type")

if li_map_type = 1 then   //only check if application
	If not FileExists (ls_app_path + String( il_app_id ) + ".tif") then //maha 090204 trap for missing image
		messagebox("Copy Function","There is no tif image for this Application; copy canceled")
		return
	end if
	w_train_app.of_clear_annos()
	ole_edit.Object.Image( ls_app_path + String( il_app_id ) + ".tif" )	
end if

dw_fld_prop_from.SetTransObject( SQLCA )
dw_fld_prop_to.SetTransObject( SQLCA )
//dw_hdr_from.SetTransObject( SQLCA ) //moved above maha 05.03.2013
dw_hdr_to.SetTransObject( SQLCA )


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Copy the script from PT-04 and integrate it into Appeon Queue labels
//$<modification> together with other SQLs to reduces client-server interactions.
 
/*
ac = dw_hdr_from.Retrieve( il_app_id )
if ac < 1 then //maha trap added 090204
	messagebox("Copy Function","Application Header does not exist.  Please select an application.~rCopy Canceled")
	return
end if

li_rc = dw_fld_prop_from.Retrieve( il_app_id )
if li_rc < 1 then //maha trap added 090204
	res = messagebox("Copy Function","There is no training data for this Application.~rDo you wish to copy the tif image?",question!,yesno!,2)
	if res = 2 then return
	return
end if
*/
gnv_appeondb.of_StartQueue()
//Start Code Change ----08.04.2009 #V92 maha - check for existing mapping 
if il_copy_to_id > 0 then
	dw_fld_prop_to.Retrieve( il_copy_to_id)
end if
//End Code Change---08.04.2009	
//dw_hdr_from.Retrieve( il_app_id )   //moved above maha 05.03.2013
dw_fld_prop_from.Retrieve( il_app_id )
SELECT Max( app_field_id )
INTO :ll_next_field_id
FROM app_field_prop;
gnv_appeondb.of_CommitQueue()

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Database Error", SQLCA.SQLCODE )
	Return -1
END IF

//ac = dw_hdr_from.RowCount()  
//if ac < 1 then //maha trap added 090204
//	messagebox("Copy Function","Application Header does not exist.  Please select an application.~rCopy Canceled")
//	return
//end if

//Start Code Change ----08.04.2009 #V92 maha - check for existing mapping and delete if copy continues.
li_cc = dw_fld_prop_to.rowcount()
if li_cc > 0 then
	messagebox("Copy Function","The Application you are copying to already has mapped fields.  Do you wish to replace the existing mapping?",question!,yesno!,2)
	if res = 2 then
		return
	else
		for i = li_cc to 1 step -1
			dw_fld_prop_to.deleterow(i)
		next
		dw_fld_prop_to.Update( )
	end if
end if
//End Code Change---08.04.2009

li_rc = dw_fld_prop_from.Rowcount()
if li_rc < 1 then //maha trap added 090204
	res = messagebox("Copy Function","There is no mapping data for this Application.~rDo you wish to copy the tif image?",question!,yesno!,2)
	if res = 2 then return
	//return  //Start Code Change ----05.28.2014 #V14.2 maha  removed
end if
//---------------------------- APPEON END ----------------------------

dw_fld_prop_from.RowsCopy( 1, 100000, Primary!, dw_fld_prop_to, 1, Primary! )

//app header
if il_copy_to_id = 0 then //maha  090304 if a new app
	dw_hdr_from.RowsCopy( 1, 100000, Primary!, dw_hdr_to, 1, Primary! )
	
	SELECT Max( app_id )
	INTO :ll_next_app_id
	FROM app_hdr;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "Database Error", SQLCA.SQLCODE )
		Return -1
	END IF
	
	ll_next_app_id ++
	
	dw_hdr_to.SetItem( 1, "app_id", ll_next_app_id )
	dw_hdr_to.SetItem( 1, "facility_id", li_facid)
	dw_hdr_to.SetItem( 1, "application_name", sle_appname.Text )
	dw_hdr_to.setitem(1,"date_first_scanned",datetime(today(),now())) //maha 090204
	dw_hdr_to.SetItem( 1, "trained_by", "Copy" ) //maha 090204
else //for copy to existing app
	ll_next_app_id = il_copy_to_id
end if 

//fields
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<comment> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Move the following script to PT-03 and integrate it into Appeon
//$<modification> Queue labels with other SQLs to reduce client-server interactions.
/*
SELECT Max( app_field_id )
INTO :ll_next_field_id
FROM app_field_prop;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Database Error", SQLCA.SQLCODE )
	Return -1
END IF
*/
//---------------------------- APPEON END ----------------------------

li_rc = dw_fld_prop_to.RowCount( )

FOR i = 1 TO li_rc
	ll_next_field_id++
	dw_fld_prop_to.SetItem( i, "app_field_id", ll_next_field_id )
	dw_fld_prop_to.SetItem( i, "app_id", ll_next_app_id )	
END FOR
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<modify> 04.04.2006 By: Rodger Wu
//$<reason> Defect fixing and performance tuning 
//$<modification> 1)Correct the DataWindow name to dw_fld_prop_to.
//$<modification> 2)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
dw_hdr_from.Update( )
dw_fld_prop_from.Update( )
*/
gnv_appeondb.of_StartQueue()
dw_hdr_to.Update( )
dw_fld_prop_to.Update( )
gnv_appeondb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------

if li_map_type = 1 then //application only//Start Code Change ----05.03.2013 #V12 maha
	ole_edit.Object.Image( ls_app_path + String( il_app_id ) + ".tif" )	
	ole_edit.Object.Page(1)
	ole_edit.Object.FitTo(3)
	ole_edit.Object.Display()
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-14 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(ls_app_path)
	if LenA(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return
	end if
	
	//---------------------------- APPEON END ----------------------------
	
	//ole_edit.Object.SaveAs( ls_app_path + String( ll_next_app_id ) + ".tif",1,1,1,0,false  )
	ole_edit.Object.SaveAs( ls_app_path + String( ll_next_app_id ) + ".tif")	//long.zhang 04.23.2012 Bug 2997
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 06.08.2006 By: LeiWei
	//$<reason> Upload Image file to Database when import new Applications. byran
	
	Integer li_image_storage_type
	
	li_image_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "image_storage_type", FALSE))
	IF Isnull(li_image_storage_type) THEN li_image_storage_type = 0
	IF Upper( AppeonGetClientType() ) <> "PB" OR li_image_storage_type = 1 THEN
		n_appeon_storage_area lnv_storage_area	
		lnv_storage_area.of_upload_app_image( ll_next_app_id, ls_app_path + String( ll_next_app_id ) + ".tif" )
	END IF
end if
//---------------------------- APPEON END ----------------------------

gs_pass_ids pass_ids

pass_ids.facility_id = li_facid
pass_ids.l_app_id = ll_next_app_id
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.04.2006 By: Rodger Wu
//$<reason> Fix a defect.


if il_copy_to_id = 0 then
	pass_ids.sl_label1 = sle_appname.Text
else
	If li_found > 0 Then
		pass_ids.sl_label1 = ldwc_app.GetItemString( li_found, "app_hdr_application_name" )
	End If
end if
//---------------------------- APPEON END ----------------------------

CloseWithReturn( Parent, pass_ids )
end event

type cb_2 from commandbutton within w_copy_application
integer x = 1385
integer y = 740
integer width = 247
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type dw_hdr_from from datawindow within w_copy_application
integer x = 357
integer y = 976
integer width = 137
integer height = 112
integer taborder = 70
boolean bringtotop = true
string title = "d_app_detail"
string dataobject = "d_app_detail_sk"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fld_prop_from from datawindow within w_copy_application
integer x = 507
integer y = 972
integer width = 137
integer height = 112
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_app_field_properties_for_copying"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hdr_to from datawindow within w_copy_application
integer x = 818
integer y = 972
integer width = 137
integer height = 112
integer taborder = 90
boolean bringtotop = true
string title = "d_app_detail"
string dataobject = "d_app_detail_sk"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fld_prop_to from datawindow within w_copy_application
integer x = 974
integer y = 972
integer width = 137
integer height = 112
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_app_field_properties_for_copying"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_appname from singlelineedit within w_copy_application
integer x = 110
integer y = 392
integer width = 2231
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type ole_edit from olecustomcontrol within w_copy_application
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
integer x = 155
integer y = 1144
integer width = 1083
integer height = 648
integer taborder = 50
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "w_copy_application.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type gb_1 from groupbox within w_copy_application
integer x = 64
integer y = 40
integer width = 2341
integer height = 188
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Existing Application to copy to:"
end type

type dw_app from datawindow within w_copy_application
integer x = 91
integer y = 112
integer width = 2258
integer height = 84
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_app_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_copy_to_id = long(data)
//messagebox("appid",il_copy_to_id)
end event

type gb_2 from groupbox within w_copy_application
integer x = 64
integer y = 324
integer width = 2341
integer height = 376
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Enter New Application Name"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Bw_copy_application.bin 
2D00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000004807974001d1852b00000003000003000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000022d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c000000004807974001d1852b4807974001d1852b000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000900000084000000000000000100000002000000030000000400000005000000060000000700000008fffffffe0000000a0000000bfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b00000030000001fd0000000e0000010000000078000001010000008000000102000000880000010300000090000001040000009800000105000000a000000106000000b400000107000000bc00000108000000c400000109000000cc0000010a000000d40000010b000000dc0000010c000000e400000000000000ec0000000300020005000000030000187f00000003000010be000000030000006000000002000000010000001e0000000945676d493274696400000000000000032ffffffe0000000b0000ffff00000002000064c9000000020000bac0000000020000bac00000000b0000ffff0000000b0000ffff0000000e000000000000000100010b0000000b00657262007672657300316465000001090000000b7365727365767265080031640e0000016d000000696e6761726569666d6f6f7a00010c0000000b006572620076726573003264650000010a0000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f69730000000000000000000000000000000000000000000200050000187f000010be0000006000010001000000006d490800696445670001327400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff00000000e0000100bbb064c9ffffbbb0ffffffff0000ffff0000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Bw_copy_application.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
