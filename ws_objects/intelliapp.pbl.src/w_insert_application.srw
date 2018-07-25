$PBExportHeader$w_insert_application.srw
forward
global type w_insert_application from window
end type
type st_6 from statictext within w_insert_application
end type
type em_to_page from editmask within w_insert_application
end type
type em_from_page from editmask within w_insert_application
end type
type st_3 from statictext within w_insert_application
end type
type ole_edit from olecustomcontrol within w_insert_application
end type
type ole_admin from olecustomcontrol within w_insert_application
end type
type em_insert_page from editmask within w_insert_application
end type
type st_5 from statictext within w_insert_application
end type
type st_4 from statictext within w_insert_application
end type
type cb_4 from commandbutton within w_insert_application
end type
type st_2 from statictext within w_insert_application
end type
type cb_3 from commandbutton within w_insert_application
end type
type st_1 from statictext within w_insert_application
end type
type sle_appname_from from singlelineedit within w_insert_application
end type
type dw_fld_prop_to from datawindow within w_insert_application
end type
type dw_fld_prop_from from datawindow within w_insert_application
end type
type cb_2 from commandbutton within w_insert_application
end type
type cb_1 from commandbutton within w_insert_application
end type
type sle_appname_to from singlelineedit within w_insert_application
end type
type gb_2 from groupbox within w_insert_application
end type
type gb_1 from groupbox within w_insert_application
end type
end forward

global type w_insert_application from window
integer x = 946
integer y = 544
integer width = 2062
integer height = 1104
windowtype windowtype = response!
long backcolor = 33551856
st_6 st_6
em_to_page em_to_page
em_from_page em_from_page
st_3 st_3
ole_edit ole_edit
ole_admin ole_admin
em_insert_page em_insert_page
st_5 st_5
st_4 st_4
cb_4 cb_4
st_2 st_2
cb_3 cb_3
st_1 st_1
sle_appname_from sle_appname_from
dw_fld_prop_to dw_fld_prop_to
dw_fld_prop_from dw_fld_prop_from
cb_2 cb_2
cb_1 cb_1
sle_appname_to sle_appname_to
gb_2 gb_2
gb_1 gb_1
end type
global w_insert_application w_insert_application

type variables
Long il_app_id_from
Long il_app_id_to

Integer il_max_to_page
Integer il_max_insert_after_page
end variables

on w_insert_application.create
this.st_6=create st_6
this.em_to_page=create em_to_page
this.em_from_page=create em_from_page
this.st_3=create st_3
this.ole_edit=create ole_edit
this.ole_admin=create ole_admin
this.em_insert_page=create em_insert_page
this.st_5=create st_5
this.st_4=create st_4
this.cb_4=create cb_4
this.st_2=create st_2
this.cb_3=create cb_3
this.st_1=create st_1
this.sle_appname_from=create sle_appname_from
this.dw_fld_prop_to=create dw_fld_prop_to
this.dw_fld_prop_from=create dw_fld_prop_from
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_appname_to=create sle_appname_to
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_6,&
this.em_to_page,&
this.em_from_page,&
this.st_3,&
this.ole_edit,&
this.ole_admin,&
this.em_insert_page,&
this.st_5,&
this.st_4,&
this.cb_4,&
this.st_2,&
this.cb_3,&
this.st_1,&
this.sle_appname_from,&
this.dw_fld_prop_to,&
this.dw_fld_prop_from,&
this.cb_2,&
this.cb_1,&
this.sle_appname_to,&
this.gb_2,&
this.gb_1}
end on

on w_insert_application.destroy
destroy(this.st_6)
destroy(this.em_to_page)
destroy(this.em_from_page)
destroy(this.st_3)
destroy(this.ole_edit)
destroy(this.ole_admin)
destroy(this.em_insert_page)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.cb_4)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.sle_appname_from)
destroy(this.dw_fld_prop_to)
destroy(this.dw_fld_prop_from)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_appname_to)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type st_6 from statictext within w_insert_application
integer x = 626
integer y = 296
integer width = 133
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
string text = "Thru"
boolean focusrectangle = false
end type

type em_to_page from editmask within w_insert_application
integer x = 759
integer y = 276
integer width = 174
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
end type

type em_from_page from editmask within w_insert_application
integer x = 439
integer y = 276
integer width = 174
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
end type

type st_3 from statictext within w_insert_application
integer x = 123
integer y = 288
integer width = 311
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean enabled = false
string text = "Insert Pages "
boolean focusrectangle = false
end type

type ole_edit from olecustomcontrol within w_insert_application
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
integer x = 306
integer y = 1108
integer width = 201
integer height = 132
integer taborder = 90
borderstyle borderstyle = stylelowered!
string binarykey = "w_insert_application.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_admin from olecustomcontrol within w_insert_application
event filepropertiesclose ( )
integer x = 530
integer y = 1116
integer width = 155
integer height = 136
integer taborder = 80
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "w_insert_application.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type em_insert_page from editmask within w_insert_application
integer x = 123
integer y = 756
integer width = 174
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "0~~1000"
end type

type st_5 from statictext within w_insert_application
integer x = 311
integer y = 772
integer width = 997
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean enabled = false
string text = "( Leave Blank to insert at beginning )"
boolean focusrectangle = false
end type

type st_4 from statictext within w_insert_application
integer x = 123
integer y = 696
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
string text = "Insert After Page"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_insert_application
integer x = 1655
integer y = 592
integer width = 247
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

event clicked;String ls_app_name
String ls_app_path
Integer li_image_page_cnt

Open( w_find_app )

IF Message.StringParm = "Cancel" THEN
	Return -1
END IF

il_app_id_to = Long( MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1 , 100 ) )

SELECT application_name
INTO: ls_app_name
FROM app_hdr
WHERE app_id = :il_app_id_to;

sle_appname_to.Text = ls_app_name

SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

ole_edit.Object.Image( ls_app_path + String( il_app_id_to ) + ".tif" )	

li_image_page_cnt = ole_edit.Object.PageCount( )	

il_max_insert_after_page = ole_edit.Object.PageCount( )

//em_from_page.Text = "1"
em_insert_page.Text = String( li_image_page_cnt )
end event

type st_2 from statictext within w_insert_application
integer x = 123
integer y = 536
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
string text = "Application Name"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_insert_application
integer x = 1655
integer y = 160
integer width = 247
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

event clicked;String ls_app_name
String ls_app_path
Integer li_image_page_cnt

Open( w_find_app )

IF Message.StringParm = "Cancel" THEN
	Return -1
END IF

il_app_id_from = Long( MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1 , 100 ) )

SELECT application_name
INTO: ls_app_name
FROM app_hdr
WHERE app_id = :il_app_id_from;

sle_appname_from.Text = ls_app_name

SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

ole_edit.Object.Image( ls_app_path + String( il_app_id_from ) + ".tif" )	

li_image_page_cnt = ole_edit.Object.PageCount( )	

il_max_to_page = ole_edit.Object.PageCount( )

em_from_page.Text = "1"
em_to_page.Text = String( li_image_page_cnt )
end event

type st_1 from statictext within w_insert_application
integer x = 123
integer y = 104
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
string text = "Application Name"
boolean focusrectangle = false
end type

type sle_appname_from from singlelineedit within w_insert_application
integer x = 123
integer y = 164
integer width = 1509
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_fld_prop_to from datawindow within w_insert_application
integer x = 745
integer y = 1204
integer width = 1234
integer height = 912
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_app_field_properties_for_copying"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fld_prop_from from datawindow within w_insert_application
integer x = 64
integer y = 1220
integer width = 709
integer height = 852
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_app_field_properties_for_copying"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_insert_application
integer x = 1705
integer y = 912
integer width = 247
integer height = 84
integer taborder = 120
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

type cb_1 from commandbutton within w_insert_application
integer x = 1417
integer y = 912
integer width = 247
integer height = 84
integer taborder = 70
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

event clicked;Long ll_next_app_id
Long ll_next_field_id
Integer li_insert_from_page
Integer li_insert_to_page
Integer li_image_page_cnt
Integer li_facility_id
Integer li_page
Integer li_rc_to
Integer li_rc_from
Integer li_page_cnt
Integer i
Integer li_insert_after_page
String ls_app_path
String ls_filter

IF IsNull( sle_appname_from.Text ) OR sle_appname_from.Text = "" THEN
	MessageBox( "Application Name", "You must select an Insert FROM application." )
	Return -1
END IF

IF IsNull( sle_appname_to.Text ) OR sle_appname_to.Text = "" THEN
	MessageBox( "Application Name", "You must select an Insert INTO application." )
	Return -1
END IF

IF IsNull( em_from_page.Text ) OR em_from_page.Text = "" THEN
	MessageBox( "Insert From Page", "You must select an Insert From Page" )
	em_from_page.SetFocus( )
	Return -1
END IF

IF IsNull( em_to_page.Text ) OR em_to_page.Text = "" THEN
	MessageBox( "Insert From Page", "You must select an Insert From Page" )
	em_to_page.SetFocus( )
	Return -1
END IF

SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

ole_edit.Object.Image( ls_app_path + String( il_app_id_from ) + ".tif" )	

li_image_page_cnt = ole_edit.Object.PageCount( )	

IF IsNull( em_insert_page.Text ) OR em_insert_page.Text = "" THEN
	li_insert_after_page = 0
ELSE
	li_insert_after_page = Integer( em_insert_page.Text )
END IF

li_insert_from_page = Integer( em_from_page.Text )

li_insert_to_page = Integer( em_to_page.Text )

IF li_insert_after_page > il_max_insert_after_page THEN
	MessageBox( "To Page", "The Insert After Page is larger than the number of pages in the document.  Please adjust to a number less than " + String( il_max_insert_after_page ) )
	em_insert_page.SetFocus( )
	Return
END IF

IF li_insert_to_page > il_max_to_page THEN
	MessageBox( "To Page", "The Insert TO page is larger than the number of pages in the document.  Please adjust to a number less than " + String( il_max_to_page ) )
	em_to_page.SetFocus( )
	Return
END IF

IF li_insert_to_page < li_insert_from_page THEN
	MessageBox( "Page Error", "The TO page can't be smaller than the FROM page.  Please Correct." )
	em_to_page.SetFocus( )
	Return -1
END IF

dw_fld_prop_from.SetTransObject( SQLCA )
dw_fld_prop_to.SetTransObject( SQLCA )
dw_fld_prop_from.Retrieve( il_app_id_from )
dw_fld_prop_to.Retrieve( il_app_id_to )

li_rc_to = dw_fld_prop_to.RowCount( )

SELECT Max( Page )
INTO :li_page_cnt
FROM app_field_prop
WHERE app_id = :il_app_id_from;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("SQL Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

li_page_cnt = li_insert_to_page - li_insert_from_page + 1

FOR i = 1 TO li_rc_to
	li_page = dw_fld_prop_to.GetItemNumber( i, "page" )
	IF li_page > li_insert_after_page THEN
		dw_fld_prop_to.SetItem( i, "page", li_page + li_page_cnt )
	END IF
END FOR

FOR i = li_insert_from_page TO li_insert_to_page
	ls_filter = ls_filter + " page = " + String( i ) + " OR "
END FOR

ls_filter = MidA( ls_filter, 1, LenA( ls_filter )- 4 )

dw_fld_prop_from.SetFilter( ls_filter )

dw_fld_prop_from.Filter(  )

li_rc_from = dw_fld_prop_from.RowCount( )

//MESSAGEBOX("from app field cnt", li_rc_from )

FOR i = 1 TO li_rc_from																			//look here
	li_page = dw_fld_prop_from.GetItemNumber( i, "page" ) - (li_insert_from_page -1)
	dw_fld_prop_from.SetItem( i, "app_id", il_app_id_to )
	dw_fld_prop_from.SetItem( i, "app_field_id", 0 )
	dw_fld_prop_from.SetItem( i, "page", li_page + li_insert_after_page )
	//messagebox( "old page " + String(li_page), li_page + li_insert_after_page )
END FOR

dw_fld_prop_from.RowsCopy( 1, li_rc_from, Primary!, dw_fld_prop_to, 1, Primary! )

SELECT Max( app_field_id )
INTO :ll_next_field_id
FROM app_field_prop;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Database Error", SQLCA.SQLCODE )
	Return -1
END IF

li_rc_from = dw_fld_prop_from.RowCount( )

FOR i = 1 TO li_rc_from
	ll_next_field_id ++
	IF dw_fld_prop_to.GetItemNumber( i, "app_field_id" ) = 0 THEN
		dw_fld_prop_to.SetItem( i, "app_field_id", ll_next_field_id )
	END IF
END FOR

dw_fld_prop_to.Update( )

SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

ole_admin.Object.Image( ls_app_path + String( il_app_id_to ) + ".tif" )	

li_insert_after_page = li_insert_after_page + 1
debugbreak()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07/09/2007 By: Ken.Guo
//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
	Messagebox('Image','The current image file must be in "TIF" format.')
	Return -1			
End If
//---------------------------- APPEON END ----------------------------

ole_admin.Object.Insert( ls_app_path + String( il_app_id_from ) + ".tif", li_insert_from_page , li_insert_after_page, li_page_cnt )

MessageBox("Insert", "The Application insert is complete." )

gs_pass_ids pass_ids

SELECT facility_id
INTO :li_facility_id
FROM app_hdr
WHERE app_id = :il_app_id_to;

pass_ids.facility_id = li_facility_id
pass_ids.l_app_id = ll_next_app_id

CloseWithReturn( Parent, pass_ids )




end event

type sle_appname_to from singlelineedit within w_insert_application
integer x = 123
integer y = 596
integer width = 1509
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_insert_application
integer x = 87
integer y = 464
integer width = 1870
integer height = 432
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Application to Insert Into"
end type

type gb_1 from groupbox within w_insert_application
integer x = 82
integer y = 28
integer width = 1870
integer height = 396
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Application to Insert"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
05w_insert_application.bin 
2A00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000000b8564b001d1752b00000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c000000000b8564b001d1752b0b8564b001d1752b000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc0000000300020005000000030000048c0000000300000369000000030000006000000002000000010000001e0000000945676d493174696400000000000000031ffffffe0000000b0000ffff000000020000bb8c000000020000bb8c000000030012bbdc000000030012bbdc0000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f697300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200050000048c000003690000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000001fffff00000000ee000100bc2000001000bc20100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000000b8564b001d1752b00000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c0024000000000b8564b001d1752b0b8564b001d1752b000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000300020000038400000384000000000000010000000000000000000000000001010000000000000000000000000000010003000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000001000000000200000300000000000300000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15w_insert_application.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
