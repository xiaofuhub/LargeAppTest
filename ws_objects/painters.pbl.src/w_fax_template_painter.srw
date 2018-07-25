$PBExportHeader$w_fax_template_painter.srw
forward
global type w_fax_template_painter from w_response
end type
type dw_template from u_dw within w_fax_template_painter
end type
type cb_save from commandbutton within w_fax_template_painter
end type
type cb_2 from commandbutton within w_fax_template_painter
end type
type gb_1 from groupbox within w_fax_template_painter
end type
type dw_select_template from u_dw within w_fax_template_painter
end type
type cb_3 from commandbutton within w_fax_template_painter
end type
type cb_4 from commandbutton within w_fax_template_painter
end type
type dw_user_facility_list from datawindow within w_fax_template_painter
end type
end forward

global type w_fax_template_painter from w_response
integer x = 471
integer y = 96
integer width = 2574
integer height = 2236
string title = "Fax Templates"
long backcolor = 33551856
dw_template dw_template
cb_save cb_save
cb_2 cb_2
gb_1 gb_1
dw_select_template dw_select_template
cb_3 cb_3
cb_4 cb_4
dw_user_facility_list dw_user_facility_list
end type
global w_fax_template_painter w_fax_template_painter

type variables
Integer ii_facility_access[]
Integer ii_fax_type
Blob iblob_coverfile
end variables

forward prototypes
public function integer of_save ()
end prototypes

public function integer of_save ();Integer li_data
Integer li_next_fax_temp_id
Integer li_cr
DataWindowChild dwchild
String ls_data

dw_template.AcceptText( )
dw_template.SetFocus( )

li_cr = dw_template.GetRow()
//Required Data
ls_data = dw_template.GetItemString( li_cr, "template_name" )
IF IsNull( ls_data ) OR ls_data = "" THEN
	//MessageBox("Required Field", "You must enter in a Template Name." )
	MessageBox("Required Field", "You must enter a Template Name." )
	dw_template.SetColumn( "template_name" )	
	Return -1
END IF

li_data = dw_template.GetItemNumber( li_cr, "facility_id" )
IF IsNull( li_data ) THEN
	MessageBox("Required Field", "You must assign a Facility." )
	dw_template.SetColumn( "facility_id" )	
	Return -1
END IF


ls_data = dw_template.GetItemString( li_cr, "cover_sheet" )
IF IsNull( ls_data ) OR ls_data = "" THEN
	MessageBox("Required Field", "You must select a Cover Sheet." )
	dw_template.SetColumn( "cover_sheet" )
	Return -1
END IF

ls_data = dw_template.GetItemString( li_cr, "subject_text" )
IF IsNull( ls_data ) OR ls_data = "" THEN
	//MessageBox("Required Field", "You must enter in a Subject Text." )
	MessageBox("Required Field", "You must enter a Subject Text." )
	dw_template.SetColumn( "subject_text" )
	Return -1
END IF

ls_data = dw_template.GetItemString( li_cr, "cover_message" )
IF IsNull( ls_data ) OR ls_data = "" THEN
	//MessageBox("Required Field", "You must enter in a Cover Message." )
	MessageBox("Required Field", "You must enter a Cover Message." )
	dw_template.SetColumn( "cover_message" )
	Return -1
END IF

IF dw_template.GetItemStatus( li_cr, 0, Primary! ) = NewModified! THEN
	SELECT Max( fax_temp_id )
	INTO: li_next_fax_temp_id
	FROM sys_fax_template;

	IF IsNull( li_next_fax_temp_id ) THEN
		li_next_fax_temp_id = 0
	END IF

	li_next_fax_temp_id++
	
	dw_template.SetItem( dw_template.GetRow(), "fax_temp_id", li_next_fax_temp_id )

	If dw_template.Update() = 1 Then
		//added by ken at 2007-05-29
		UpdateBlob sys_fax_template set cover_file = :iblob_coverfile where fax_temp_id = :li_next_fax_temp_id;
	End If
	dw_select_template.Reset( )
	
	dw_select_template.of_SetTransObject( SQLCA )
	
	dw_select_template.GetChild( "template_id" , dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( ii_facility_access )
	
	dw_select_template.InsertRow( 0 )

	dw_select_template.SetItem( 1, "template_id", dw_template.GetItemNumber( dw_template.GetRow(), "fax_temp_id" ) )
ELSE
	If dw_template.Update() = 1 Then
		If LenA(iblob_coverfile) > 0 Then 
			li_next_fax_temp_id = dw_template.getitemnumber(dw_template.getrow(),'fax_temp_id')
			UpdateBlob sys_fax_template set cover_file = :iblob_coverfile where fax_temp_id = :li_next_fax_temp_id;
		End If
	End If
END IF

Return 0
end function

on w_fax_template_painter.create
int iCurrent
call super::create
this.dw_template=create dw_template
this.cb_save=create cb_save
this.cb_2=create cb_2
this.gb_1=create gb_1
this.dw_select_template=create dw_select_template
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_user_facility_list=create dw_user_facility_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_template
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_select_template
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.dw_user_facility_list
end on

on w_fax_template_painter.destroy
call super::destroy
destroy(this.dw_template)
destroy(this.cb_save)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.dw_select_template)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_user_facility_list)
end on

event open;call super::open;Integer li_rc
Integer i
DataWindowChild dw_child

This.of_SetUpdateAble( False )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05/29/2007 By: Ken.Guo
//$<reason> Add fax_type. 1: WinFax,2:MSFax
if gds_settings.rowcount() > 0 then
	ii_fax_type = gds_settings.getitemnumber(1,'set_52') 
else
	ii_fax_type = 1
end if 
//---------------------------- APPEON END ----------------------------
dw_select_template.of_SetTransObject( SQLCA )
dw_select_template.InsertRow( 0 )

dw_template.of_SetTransObject( SQLCA )
dw_template.InsertRow( 0 )
dw_template.setitem(1,'fax_type',ii_fax_type) //added by ken at 2007-05-29
dw_template.GetChild( "facility_id", dw_child )

dw_child.InsertRow( 1 )
dw_child.SetItem( 1, "facility_id", 0 )
dw_child.SetItem( 1, "facility_name", "All Facilities" )

dw_user_facility_list.SetTransObject( SQLCA )
dw_user_facility_list.Retrieve( gs_user_id )

li_rc = dw_user_facility_list.RowCount( )
FOR i = 1 TO li_rc
	ii_facility_access[ i ] = dw_user_facility_list.GetItemNumber( i, "user_facility_id" )
END FOR


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.10.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
dw_select_template.GetChild( "template_id", dw_child )
dw_child.SetTransObject( SQlCA )
dw_child.Retrieve( ii_facility_access[] )

dw_template.GetChild( "facility_id", dw_child )
dw_child.SetTransObject( SQlCA )
dw_child.Retrieve( ii_facility_access[] )
*/
if upperbound(ii_facility_access) = 0 then
	ii_facility_access[1] = 0
end if

DataWindowChild dw_child1,dw_child2
dw_select_template.GetChild( "template_id", dw_child1 )
dw_child1.SetTransObject( SQlCA )
dw_template.GetChild( "facility_id", dw_child2 )
dw_child2.SetTransObject( SQlCA )

gnv_appeondb.of_startqueue( )

dw_child1.Retrieve( ii_facility_access[] )
dw_child2.Retrieve( ii_facility_access[] )

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05/29/2007 By: Ken.Guo
//$<reason> Add fax_type. 1: WinFax,2:MSFax
dw_child1.Setfilter('fax_type = '+string(ii_fax_type))
dw_child1.Filter()
//---------------------------- APPEON END ----------------------------

end event

type dw_template from u_dw within w_fax_template_painter
integer x = 5
integer y = 240
integer width = 2551
integer height = 1892
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fax_template"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string is_path
string docname, named
integer value

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05/29/2007 By: Ken.Guo
//$<reason> Add MSFax type
/*
value = GetFileOpenName("Select File", docname, named, "CVO", "Cover Page Files (*.CVP),*.CVP")
IF value > 0 THEN
	dw_template.SetItem( dw_template.GetRow( ), "cover_sheet", docname  )
End If
*/
integer li_ret
String ls_ext,ls_filename,ls_pathname
n_cst_filesrvwin32 nvo_file
nvo_file = Create n_cst_filesrvwin32
long ll_temp_id
int li_pos
String ls_cover_sheet
Blob lblob_coverfile

If ii_fax_type = 1 Then
	//For WinFax
	ls_ext = 'CVP'
Else
	//For MSFax
	ls_ext = 'COV'
End If

Choose Case dwo.name 
	Case 'b_browse' 
		gf_load_dir_path() //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX
		value = GetFileOpenName("Select File", docname, named, ls_ext, "Cover Page Files (*."+ls_ext+"),*."+ls_ext)
//		ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
		gf_save_dir_path(docname) //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX
		IF value > 0 THEN
			dw_template.SetItem( dw_template.GetRow( ), "cover_sheet", named ) 
			nvo_file.of_fileread(docname, iblob_coverfile)
			if LenA(iblob_coverfile) = 0 or isnull(iblob_coverfile) then
				//messagebox('Cover Page','Failed to read the cover page file,please select again.',Exclamation!)
  				messagebox('Cover Page','Failed to read the cover page file, please select again.',Exclamation!)
				dw_template.SetItem( dw_template.GetRow( ), "cover_sheet", '' )  
			end if
		END IF
	Case 'b_get'
//		//Begin get file name
//		ls_cover_sheet = dw_template.getitemstring(dw_template.getrow(),'cover_sheet')
//		li_pos = pos(ls_cover_sheet,'\',1) 
//		//For old data, the data have full path name.
//		Do while li_pos > 0 
//			ls_cover_sheet = Right(ls_cover_sheet,li_pos+1)
//			li_pos = pos(ls_cover_sheet,'\',1) 
//		Loop
//		
		//Output file
		If dw_template.getitemstatus( getrow(),0, primary!) <> NotModified! Then 
			Messagebox('Cover Page','Please save this template first.')
			Return
		End If
		gf_load_dir_path()  //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX
		value = GetFileSaveName ( 'Save File', ls_pathname, ls_cover_sheet ,ls_ext, "Cover Page Files (*."+ls_ext+"),*."+ls_ext)
//		ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
		gf_save_dir_path(ls_pathname) //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX
		If value > 0 Then
			ll_temp_id = dw_template.getitemnumber(dw_template.getrow(),'fax_temp_id')
			selectblob cover_file into :lblob_coverfile from sys_fax_template where fax_temp_id = :ll_temp_id;
			If LenA(lblob_coverfile) = 0 or isnull(lblob_coverfile) Then
				Messagebox('Cover Page','No file was uploaded. Please upload the file first.',Exclamation!)
				Return 
			End If
			li_ret = nvo_file.of_filewrite( ls_pathname, lblob_coverfile, False)
			If li_ret <> 1 Then 
				Messagebox('Cover Page','Failed to get cover page from DB.',Exclamation!)
				Return
			End If
		End If
End Choose
Destroy nvo_file
//---------------------------- APPEON END ----------------------------
end event

type cb_save from commandbutton within w_fax_template_painter
integer x = 1458
integer y = 80
integer width = 256
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.28.2006 By: LeiWei
//$<reason> Fix a defect.
//of_save( )

IF of_save() = -1 THEN
	RETURN -1
END IF

if upperbound(ii_facility_access) = 0 then
	ii_facility_access[1] = 0
end if

DataWindowChild dw_child1
dw_select_template.GetChild( "template_id", dw_child1 )
dw_child1.SetTransObject( SQlCA )
dw_child1.Retrieve( ii_facility_access[] )

//---------------------------- APPEON END ----------------------------

end event

type cb_2 from commandbutton within w_fax_template_painter
integer x = 2258
integer y = 80
integer width = 256
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close( Parent )
end event

type gb_1 from groupbox within w_fax_template_painter
integer x = 5
integer y = 20
integer width = 2546
integer height = 184
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Template"
end type

type dw_select_template from u_dw within w_fax_template_painter
integer x = 27
integer y = 76
integer width = 1381
integer height = 84
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_select_fax_template"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;

IF row > 0 THEN
	dw_template.Retrieve( Long( data ) )
END IF
end event

event constructor;call super::constructor;This.of_SetUpdateable( False )
end event

type cb_3 from commandbutton within w_fax_template_painter
integer x = 1993
integer y = 80
integer width = 256
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;Integer li_nr

IF of_Save( ) = -1 THEN
	Return -1
END IF

li_nr = dw_template.InsertRow( 0 )
dw_template.setitem(li_nr,'fax_type',ii_fax_type) //added by ken at 2007-05-29
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 08.28.2006 By: LeiWei
//$<reason> Fix a defect.
//dw_template.SetRow( li_nr )
//---------------------------- APPEON END ----------------------------

dw_template.ScrollToRow( li_nr )
dw_template.SetFocus( )

end event

type cb_4 from commandbutton within w_fax_template_painter
integer x = 1728
integer y = 80
integer width = 256
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;Integer li_ans
DataWindowChild dwchild

IF dw_template.RowCount() = 0 THEN
	Return -1
END IF

li_ans = MessageBox( "Delete", "Are you sure you want to DELETE this fax template.", StopSign!, YesNo!, 1 )

IF li_ans = 1 THEN
	dw_template.DeleteRow( 0 )
	IF dw_template.RowCount( ) = 0 THEN
		dw_template.InsertRow( 0 )
	END IF
	
	dw_template.Update( )
	
	dw_select_template.Reset( )	
	dw_select_template.of_SetTransObject( SQLCA )
	dw_select_template.InsertRow( 0 )

	dw_select_template.GetChild( "template_id" , dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( ii_facility_access )
	
	
		
END IF

dw_template.SetFocus( )
end event

type dw_user_facility_list from datawindow within w_fax_template_painter
boolean visible = false
integer x = 1216
integer y = 228
integer width = 494
integer height = 360
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_user_facility_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

