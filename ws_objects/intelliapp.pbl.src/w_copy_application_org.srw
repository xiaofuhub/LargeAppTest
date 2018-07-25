$PBExportHeader$w_copy_application_org.srw
forward
global type w_copy_application_org from w_response
end type
type dw_facility from datawindow within w_copy_application_org
end type
type st_3 from statictext within w_copy_application_org
end type
type cb_1 from commandbutton within w_copy_application_org
end type
type cb_2 from commandbutton within w_copy_application_org
end type
type dw_hdr_from from datawindow within w_copy_application_org
end type
type dw_fld_prop_from from datawindow within w_copy_application_org
end type
type dw_hdr_to from datawindow within w_copy_application_org
end type
type dw_fld_prop_to from datawindow within w_copy_application_org
end type
type sle_appname from singlelineedit within w_copy_application_org
end type
type st_1 from statictext within w_copy_application_org
end type
type ole_edit from olecustomcontrol within w_copy_application_org
end type
end forward

global type w_copy_application_org from w_response
integer x = 933
integer y = 656
integer width = 1650
integer height = 532
string title = "Copy Application"
boolean controlmenu = false
long backcolor = 80269524
dw_facility dw_facility
st_3 st_3
cb_1 cb_1
cb_2 cb_2
dw_hdr_from dw_hdr_from
dw_fld_prop_from dw_fld_prop_from
dw_hdr_to dw_hdr_to
dw_fld_prop_to dw_fld_prop_to
sle_appname sle_appname
st_1 st_1
ole_edit ole_edit
end type
global w_copy_application_org w_copy_application_org

type variables
Long il_app_id
end variables

on w_copy_application_org.create
int iCurrent
call super::create
this.dw_facility=create dw_facility
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_hdr_from=create dw_hdr_from
this.dw_fld_prop_from=create dw_fld_prop_from
this.dw_hdr_to=create dw_hdr_to
this.dw_fld_prop_to=create dw_fld_prop_to
this.sle_appname=create sle_appname
this.st_1=create st_1
this.ole_edit=create ole_edit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_facility
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_hdr_from
this.Control[iCurrent+6]=this.dw_fld_prop_from
this.Control[iCurrent+7]=this.dw_hdr_to
this.Control[iCurrent+8]=this.dw_fld_prop_to
this.Control[iCurrent+9]=this.sle_appname
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.ole_edit
end on

on w_copy_application_org.destroy
call super::destroy
destroy(this.dw_facility)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_hdr_from)
destroy(this.dw_fld_prop_from)
destroy(this.dw_hdr_to)
destroy(this.dw_fld_prop_to)
destroy(this.sle_appname)
destroy(this.st_1)
destroy(this.ole_edit)
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
end event

type dw_facility from datawindow within w_copy_application_org
integer x = 41
integer y = 264
integer width = 955
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_select_app_facility"
boolean border = false
boolean livescroll = true
end type

event constructor;//This.of_setUpdateable( False )
end event

type st_3 from statictext within w_copy_application_org
integer x = 55
integer y = 216
integer width = 978
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
string text = "Select Organization To Copy to"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_copy_application_org
integer x = 1024
integer y = 260
integer width = 247
integer height = 108
integer taborder = 30
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

event clicked;//As of 090104 still needs:
//to be able to copy to an existing app_id will have to test for existing data and delete any existing.
//test for duplicate name
Long ll_next_app_id
Long ll_next_field_id
Integer li_rc
Integer i
integer ac
integer res
String ls_app_path,ls_Rtn

dw_facility.AcceptText( )
IF IsNull( dw_facility.GetItemNumber( 1, "facility_id" ) ) THEN
	MessageBox("Copy To Facility", "You must select the Facility to copy the selected application to." )
	Return -1
END IF

IF IsNull( sle_appname.Text ) OR sle_appname.Text = "" THEN
	MessageBox( "Application Name", "You must assign a new name to the application you are copying." )
	Return -1
END IF

SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

If not FileExists (ls_app_path + String( il_app_id ) + ".tif") then //maha 090204
	messagebox("Copy Function","There is no tif image for this Application; copy canceled")
	return
end if

ole_edit.Object.Image( ls_app_path + String( il_app_id ) + ".tif" )	

dw_fld_prop_from.SetTransObject( SQLCA )
dw_fld_prop_to.SetTransObject( SQLCA )
dw_hdr_from.SetTransObject( SQLCA )
dw_hdr_to.SetTransObject( SQLCA )

if il_app_id < 1 then //maha trap added 090204
	messagebox("Copy Function","Please select the application you wish to copy.")
	return
end if

ac = dw_hdr_from.Retrieve( il_app_id )
if ac < 1 then //maha trap added 090204
	messagebox("Copy Function","Application Header does not exist.  Please select an application.~rCopy Canceled")
	return
end if

li_rc = dw_fld_prop_from.Retrieve( il_app_id )
if li_rc < 1 then //maha trap added 090204
	messagebox("Copy Function","There is no training data for this Application.~rDo you wish to copy the tif image?",question!,yesno!,2)
	if res = 2 then return
	return
end if


dw_hdr_from.RowsCopy( 1, 100000, Primary!, dw_hdr_to, 1, Primary! )

dw_fld_prop_from.RowsCopy( 1, 100000, Primary!, dw_fld_prop_to, 1, Primary! )

SELECT Max( app_id )
INTO :ll_next_app_id
FROM app_hdr;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Database Error", SQLCA.SQLCODE )
	Return -1
END IF

ll_next_app_id ++

dw_hdr_to.SetItem( 1, "app_id", ll_next_app_id )
dw_hdr_to.SetItem( 1, "facility_id", dw_facility.GetItemNumber( 1, "facility_id" ))
dw_hdr_to.SetItem( 1, "application_name", sle_appname.Text )
dw_hdr_to.setitem(1,"date_first_scanned",datetime(today(),now())) //maha 090204
dw_hdr_to.SetItem( 1, "trained_by", "Copy" ) //maha 090204



SELECT Max( app_field_id )
INTO :ll_next_field_id
FROM app_field_prop;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "Database Error", SQLCA.SQLCODE )
	Return -1
END IF

li_rc = dw_fld_prop_to.RowCount( )

FOR i = 1 TO li_rc
	ll_next_field_id++
	dw_fld_prop_to.SetItem( i, "app_field_id", ll_next_field_id )
	dw_fld_prop_to.SetItem( i, "app_id", ll_next_app_id )	
END FOR

dw_hdr_from.Update( )
dw_fld_prop_from.Update( )



SELECT ids.intelliapp_app_path  
INTO :ls_app_path  
FROM ids  ;

IF RightA( ls_app_path, 1 ) <> "\" THEN
	ls_app_path = ls_app_path + "\"
END IF

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

ole_edit.Object.SaveAs( ls_app_path + String( ll_next_app_id ) + ".tif" ,1,1,1,0,false )
	
gs_pass_ids pass_ids

pass_ids.facility_id = dw_facility.GetItemNumber( 1, "facility_id" )
pass_ids.l_app_id = ll_next_app_id

CloseWithReturn( Parent, pass_ids )





end event

type cb_2 from commandbutton within w_copy_application_org
integer x = 1317
integer y = 260
integer width = 247
integer height = 108
integer taborder = 40
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

type dw_hdr_from from datawindow within w_copy_application_org
integer x = 78
integer y = 632
integer width = 137
integer height = 112
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_app_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fld_prop_from from datawindow within w_copy_application_org
integer x = 229
integer y = 628
integer width = 137
integer height = 112
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_app_field_properties_for_copying"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hdr_to from datawindow within w_copy_application_org
integer x = 539
integer y = 628
integer width = 137
integer height = 112
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_app_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fld_prop_to from datawindow within w_copy_application_org
integer x = 695
integer y = 628
integer width = 137
integer height = 112
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_app_field_properties_for_copying"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_appname from singlelineedit within w_copy_application_org
integer x = 55
integer y = 76
integer width = 1509
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
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_copy_application_org
integer x = 55
integer y = 16
integer width = 978
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
string text = "Application Name"
boolean focusrectangle = false
end type

type ole_edit from olecustomcontrol within w_copy_application_org
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
integer x = 151
integer y = 820
integer width = 1083
integer height = 648
integer taborder = 30
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "w_copy_application_org.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
02w_copy_application_org.bin 
2300000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000b9311ba001c8e64e00000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000b9311ba001c8e64eb9311ba001c8e64e000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201056d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc00000003000200050000000300020005000000036d940280000000030000006000000002000000010000001e0000000945676d493374696400000000000000030d85a9000000000b0000ffff000000020000de94000000020000de94000000030012df28000000030012df280000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f697300000000006400640063005f006e006f0072007400630061005f00740061006d0061006e006500670065006d0074006e0074005f00020005000200056d9402800000006000010001000000006d490800696445670001337400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff0300000000000000000d85a90000000000000100dfa00000df68dfa0df6800122e2e0012000000000000000000000001005f0074006c00630075006100650073005f0073006900660074006c007200650064002e006f007700280020002900780028002000330037003600330020002900300032003800300030002d002d00360030003300310020003a0030003800340030003a0020003400640000005f0064006f00630074006e0061007200740063006d005f006e006100670061006d0065006e0065005f007400720074006300610069006b0067006e0064002e006f007700280020002900780028002000360035003900320020002900300032003800300030002d002d00360030003300310020003a0030003800340030003a0020003400640000005f00640074006300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
12w_copy_application_org.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
