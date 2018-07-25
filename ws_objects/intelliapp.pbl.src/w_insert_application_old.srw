$PBExportHeader$w_insert_application_old.srw
forward
global type w_insert_application_old from w_response
end type
type cb_1 from commandbutton within w_insert_application_old
end type
type cb_2 from commandbutton within w_insert_application_old
end type
type dw_fld_prop_from from datawindow within w_insert_application_old
end type
type dw_fld_prop_to from datawindow within w_insert_application_old
end type
type sle_appname_from from singlelineedit within w_insert_application_old
end type
type st_1 from statictext within w_insert_application_old
end type
type cb_3 from commandbutton within w_insert_application_old
end type
type sle_appname_to from singlelineedit within w_insert_application_old
end type
type st_2 from statictext within w_insert_application_old
end type
type cb_4 from commandbutton within w_insert_application_old
end type
type st_4 from statictext within w_insert_application_old
end type
type st_5 from statictext within w_insert_application_old
end type
type em_insert_page from editmask within w_insert_application_old
end type
type ole_admin from olecustomcontrol within w_insert_application_old
end type
type ole_edit from olecustomcontrol within w_insert_application_old
end type
end forward

global type w_insert_application_old from w_response
int X=933
int Y=656
int Width=2025
int Height=2224
boolean TitleBar=true
string Title="Copy Application"
long BackColor=80269524
boolean ControlMenu=false
cb_1 cb_1
cb_2 cb_2
dw_fld_prop_from dw_fld_prop_from
dw_fld_prop_to dw_fld_prop_to
sle_appname_from sle_appname_from
st_1 st_1
cb_3 cb_3
sle_appname_to sle_appname_to
st_2 st_2
cb_4 cb_4
st_4 st_4
st_5 st_5
em_insert_page em_insert_page
ole_admin ole_admin
ole_edit ole_edit
end type
global w_insert_application_old w_insert_application_old

type variables
Long il_app_id_from
Long il_app_id_to
end variables

on w_insert_application_old.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_fld_prop_from=create dw_fld_prop_from
this.dw_fld_prop_to=create dw_fld_prop_to
this.sle_appname_from=create sle_appname_from
this.st_1=create st_1
this.cb_3=create cb_3
this.sle_appname_to=create sle_appname_to
this.st_2=create st_2
this.cb_4=create cb_4
this.st_4=create st_4
this.st_5=create st_5
this.em_insert_page=create em_insert_page
this.ole_admin=create ole_admin
this.ole_edit=create ole_edit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_fld_prop_from
this.Control[iCurrent+4]=this.dw_fld_prop_to
this.Control[iCurrent+5]=this.sle_appname_from
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.sle_appname_to
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.cb_4
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.em_insert_page
this.Control[iCurrent+14]=this.ole_admin
this.Control[iCurrent+15]=this.ole_edit
end on

on w_insert_application_old.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_fld_prop_from)
destroy(this.dw_fld_prop_to)
destroy(this.sle_appname_from)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.sle_appname_to)
destroy(this.st_2)
destroy(this.cb_4)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.em_insert_page)
destroy(this.ole_admin)
destroy(this.ole_edit)
end on

event open;call super::open;//String ls_app_name
//
//il_app_id = Message.DoubleParm
//
//SELECT application_name
//INTO :ls_app_name
//FROM app_hdr
//WHERE app_id = :il_app_id;
//
//This.Title = "Copying " + ls_app_name + "(" + String( il_app_id ) + ")"
//
//dw_facility.SetTransObject( SQLCA )
//dw_facility.InsertRow( 0 )
end event

type cb_1 from commandbutton within w_insert_application_old
int X=1358
int Y=644
int Width=247
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long ll_next_app_id
Long ll_next_field_id
Integer li_facility_id
Integer li_page
Integer li_rc_to
Integer li_rc_from
Integer li_page_cnt
Integer i
Integer li_insert_after_page
String ls_app_path

IF IsNull( sle_appname_from.Text ) OR sle_appname_from.Text = "" THEN
	MessageBox( "Application Name", "You must select an Insert FROM application." )
	Return -1
END IF

IF IsNull( sle_appname_to.Text ) OR sle_appname_to.Text = "" THEN
	MessageBox( "Application Name", "You must select an Insert INTO application." )
	Return -1
END IF

IF IsNull( em_insert_page.Text ) OR em_insert_page.Text = "" THEN
	MessageBox( "Application Name", "You must select an Insert After PAGE." )
	em_insert_page.SetFocus( )
	Return -1
END IF

li_insert_after_page = Integer( em_insert_page )

dw_fld_prop_from.SetTransObject( SQLCA )
dw_fld_prop_to.SetTransObject( SQLCA )


dw_fld_prop_from.Retrieve( il_app_id_from )

dw_fld_prop_to.Retrieve( il_app_id_to )

li_rc_to = dw_fld_prop_to.RowCount( )

SELECT Max( Page )
INTO :li_page_cnt
FROM app_field_prop
WHERE app_id = :il_app_id_from;

FOR i = 1 TO li_rc_to
	li_page = dw_fld_prop_to.GetItemNumber( i, "page" )
	IF li_page > li_insert_after_page THEN
		dw_fld_prop_to.SetItem( i, "page", li_page + li_page_cnt )
	END IF
END FOR

li_rc_from = dw_fld_prop_from.RowCount( )

FOR i = 1 TO li_rc_from
	li_page = dw_fld_prop_from.GetItemNumber( i, "page" )
	dw_fld_prop_from.SetItem( i, "app_id", il_app_id_to )
	dw_fld_prop_from.SetItem( i, "app_field_id", 0 )
	dw_fld_prop_from.SetItem( i, "page", li_page + li_insert_after_page )
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
ole_admin.Object.Insert( ls_app_path + String( il_app_id_from ) + ".tif", 1, li_insert_after_page + 1, li_page_cnt )

gs_pass_ids pass_ids


SELECT facility_id
INTO :li_facility_id
FROM app_hdr
WHERE app_id = :il_app_id_to;

pass_ids.facility_id = li_facility_id
pass_ids.l_app_id = ll_next_app_id

CloseWithReturn( Parent, pass_ids )



//dw_hdr_from.Retrieve( il_app_id_to )
//
//dw_hdr_from.RowsCopy( 1, 100000, Primary!, dw_hdr_to, 1, Primary! )
//
//dw_fld_prop_from.RowsCopy( 1, 100000, Primary!, dw_fld_prop_to, 1, Primary! )
//
//SELECT Max( app_id )
//INTO :ll_next_app_id
//FROM app_hdr;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox( "Database Error", SQLCA.SQLCODE )
//	Return -1
//END IF
//
//ll_next_app_id ++
//
//dw_hdr_to.SetItem( 1, "app_id", ll_next_app_id )
//dw_hdr_to.SetItem( 1, "facility_id", dw_facility.GetItemNumber( 1, "facility_id" ))
//dw_hdr_to.SetItem( 1, "application_name", sle_appname.Text )
//
//SELECT Max( app_field_id )
//INTO :ll_next_field_id
//FROM app_field_prop;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox( "Database Error", SQLCA.SQLCODE )
//	Return -1
//END IF
//
//li_rc = dw_fld_prop_to.RowCount( )
//
//FOR i = 1 TO li_rc
//	ll_next_field_id++
//	dw_fld_prop_to.SetItem( i, "app_field_id", ll_next_field_id )
//	dw_fld_prop_to.SetItem( i, "app_id", ll_next_app_id )	
//END FOR
//
//dw_hdr_from.Update( )
//dw_fld_prop_from.Update( )
//
//String ls_app_path
//
//SELECT ids.intelliapp_app_path  
//INTO :ls_app_path  
//FROM ids  ;
//
//IF Right( ls_app_path, 1 ) <> "\" THEN
//	ls_app_path = ls_app_path + "\"
//END IF
//
//ole_edit.Object.Image( ls_app_path + String( il_app_id ) + ".tif" )	
//ole_edit.Object.Page(1)
//ole_edit.Object.FitTo(3)
//ole_edit.Object.Display()
//ole_edit.Object.SaveAs( ls_app_path + String( ll_next_app_id ) + ".tif" )
//	
//gs_pass_ids pass_ids
//
//pass_ids.facility_id = dw_facility.GetItemNumber( 1, "facility_id" )
//pass_ids.l_app_id = ll_next_app_id
//
//CloseWithReturn( Parent, pass_ids )
//
//
//
//
//
end event

type cb_2 from commandbutton within w_insert_application_old
int X=1650
int Y=644
int Width=247
int Height=108
int TabOrder=90
boolean BringToTop=true
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type dw_fld_prop_from from datawindow within w_insert_application_old
int X=64
int Y=1220
int Width=709
int Height=852
int TabOrder=100
boolean BringToTop=true
string DataObject="d_app_field_properties_for_copying"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_fld_prop_to from datawindow within w_insert_application_old
int X=827
int Y=1216
int Width=1234
int Height=912
int TabOrder=110
boolean BringToTop=true
string DataObject="d_app_field_properties_for_copying"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type sle_appname_from from singlelineedit within w_insert_application_old
int X=123
int Y=88
int Width=1509
int Height=80
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_insert_application_old
int X=123
int Y=28
int Width=978
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Application To Insert"
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_insert_application_old
int X=1655
int Y=80
int Width=247
int Height=108
int TabOrder=70
boolean BringToTop=true
string Text="Find"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_app_name

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
end event

type sle_appname_to from singlelineedit within w_insert_application_old
int X=123
int Y=268
int Width=1509
int Height=80
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_insert_application_old
int X=123
int Y=208
int Width=978
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Application To Insert Into"
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_4 from commandbutton within w_insert_application_old
int X=1650
int Y=260
int Width=247
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Find"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_app_name

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
end event

type st_4 from statictext within w_insert_application_old
int X=123
int Y=400
int Width=978
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Insert After Page"
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_insert_application_old
int X=389
int Y=484
int Width=997
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="(Enter 0 to insert at beginning, 999 to append)"
boolean FocusRectangle=false
long TextColor=255
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_insert_page from editmask within w_insert_application_old
int X=128
int Y=468
int Width=247
int Height=100
int TabOrder=40
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
boolean Spin=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ole_admin from olecustomcontrol within w_insert_application_old
event filepropertiesclose ( )
int X=690
int Y=664
int Width=155
int Height=136
int TabOrder=60
boolean BringToTop=true
long TextColor=33554432
BorderStyle BorderStyle=StyleLowered!
string BinaryKey="w_insert_application_old.win"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ole_edit from olecustomcontrol within w_insert_application_old
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
int X=320
int Y=820
int Width=201
int Height=132
int TabOrder=80
long TextColor=33554432
BorderStyle BorderStyle=StyleLowered!
string BinaryKey="w_insert_application_old.win"
int BinaryIndex=1
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
03w_insert_application_old.bin 
2300000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005fddc14001c421a700000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012900000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c0024000000005fddc14001c421a75fddc14001c421a7000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020005009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f900000007000001000000004000000101000000480000010200000050000001030000005800000104000000600000010500000068000000000000007000000003000300020000000300000384000000030000038400000003000000000000000300000000000000030000000000000007000000000000000a5f656c6f696d64610105006e000d00007270000065746e696170646e030065670c0000015f000000636f74736f72706b040073700f00000170000000746e697272617473676170740101006500090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f69730000ff000000000f000000000000000100010a0000000b000003000200000384000003840000000000000100000000000000000000000000010100000000000000000000000000000100030000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000010000000002000003000000000003000001000000006f720001040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000000000000000800000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005fddc14001c421a700000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025500000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c000000005fddc14001c421a75fddc14001c421a7000000000000000000000000006f00430074006e006e006500730074
2D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000200056d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b00000030000002250000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc0000000300020005000000030000048c0000000300000369000000030000006000000002000000010000001e0000000945676d49327469640000000000000003081176000000000b0000ffff000000020000e998000000020000e998000000030012e9e8000000030012e9e80000000b0000ffff0000000b0000ffff0000000f00000000000000095f656c6f7469646500010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f69730063000000720075006500720074006e0070005c00630066006e007700720073002e0076006200700000006c000200050000048c000003690000006000010001000000006d490800696445670001327400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000000000000008117600000000c0000100ea00000012d7ea0012d7780000007800000000000000000000000001006e006f003400200063002e00720075006500720074006e0070005c006500660077006400720073002e0076006200700000006c003a00530044005c00760065006c00650070006f0065006d0074006e0056005c0072006500690073006e006f003400200063002e00720075006500720074006e0070005c006500660061006d006e00690070002e006c006200530000005c003a0065004400650076006f006c006d0070006e0065005c00740065005600730072006f00690020006e002e00340075006300720072006e0065005c0074006600700075006500690074002e006c006200700000006c0003000200000003000003840000000300000384000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13w_insert_application_old.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
