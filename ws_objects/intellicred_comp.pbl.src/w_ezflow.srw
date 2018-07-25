$PBExportHeader$w_ezflow.srw
forward
global type w_ezflow from w_main
end type
type ole_edit from olecustomcontrol within w_ezflow
end type
type dw_field_data from u_dw within w_ezflow
end type
end forward

global type w_ezflow from w_main
int X=5
int Y=2248
int Width=3666
int Height=900
WindowType WindowType=popup!
boolean TitleBar=false
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
ole_edit ole_edit
dw_field_data dw_field_data
end type
global w_ezflow w_ezflow

type variables
Integer ii_app_id
end variables

forward prototypes
public function integer of_load_app (long al_prac_id, integer al_parent_facility_id)
public function integer of_select_field (string as_field_id)
end prototypes

public function integer of_load_app (long al_prac_id, integer al_parent_facility_id);Integer li_Rc
Integer li_start_page
Integer li_app_type
Integer li_num_pages
Integer li_image_type_id
String ls_app_type 
String ls_image_path

//DEBUGBREAK()
//get application type ---- initial or reapp
SELECT pd_affil_stat.apptmnt_type  
INTO :ls_app_type  
FROM pd_affil_stat  
WHERE ( pd_affil_stat.prac_id = :al_prac_id ) AND  
      ( pd_affil_stat.parent_facility_id = :al_parent_facility_id ) AND  
      ( pd_affil_stat.active_status in (1,4) )   ;  //maha  changed to include pending 072402
IF SQLCA.SQLCODE = -1 THEN
	MessageBox(" Database Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

IF ls_app_type = "I" THEN
	li_app_type = 1 
ELSE
	li_app_type = 2
END IF

//get the app_id used and 
SELECT image_type.image_type_id, image_type.link_to_app_id
INTO :li_image_type_id, :ii_app_id
FROM image_type,
	app_hdr
WHERE ( image_type.link_to_app_id = app_hdr.app_id ) AND 
      ( app_hdr.application_type = : li_app_type ) AND
	( image_type.parent_facility_id = :al_parent_facility_id ) ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox(" Database Error", SQLCA.SQLERRTEXT )
	Return -1
END IF


//get the image path
SELECT ids.imaging_path  
INTO :ls_image_path  
FROM ids  ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox(" Database Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

//get the start and num of pages from the pd_image table to display application
SELECT pd_images.tif_start_page,
       pd_images.num_pages  
INTO :li_start_page,   
     :li_num_pages  
FROM pd_images  
WHERE ( pd_images.prac_id = :al_prac_id ) AND  
      ( pd_images.image_type_id = :li_image_type_id ) AND  
      ( pd_images.active_status = 1 )   ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox(" Database Error", SQLCA.SQLERRTEXT )
	Return -1
ELSEIF SQLCA.SQLCODE = 100 THEN
	MessageBox(" Invalid", "No EZ-Flow image found for current selected facility." )
	This.SetRedraw( True )
	Close( This )
	Return -1
END IF

IF NOT FileExists( ls_image_path + String( al_prac_id ) + ".tif" ) THEN
	MessageBox("Invalid Application", "The application file " + ls_image_path + String( al_prac_id ) + ".tif does not exist." )
	Return -1
END IF

This.SetRedraw( False )

ole_edit.Object.Image( ls_image_path + String( al_prac_id ) + ".tif" )
ole_edit.Object.Page( li_start_page )
ole_edit.Object.FitTo(3)
ole_edit.Object.Display()
ole_edit.Object.ImageResolutionx( 300 )
ole_edit.Object.ImageResolutionY( 300 )
ole_edit.Object.Annotationtype(11)	
ole_edit.Object.Display()
ole_edit.Object.AutoRefresh( True )
This.SetRedraw( True )

dw_field_data.SetTransObject( SQLCA )
li_rc = dw_field_data.Retrieve( ii_app_id )


Return 1
end function

public function integer of_select_field (string as_field_id);Integer li_found
Integer li_retval
Long ll_y
Long ll_x
Long ll_width
Long ll_last_y = 0

This.SetRedraw( False )

li_found = dw_field_data.Find( "field_id = " + String( as_field_id ) , 1 , dw_field_data.RowCount() )

IF li_found > 0 THEN
	ole_edit.Object.Page( dw_field_data.GetItemNumber( li_found, "page" ) )
	ole_edit.Object.Display( )
	ll_y = dw_field_data.GetItemNumber( li_found, "y_pos" ) -30
	IF ll_y <> ll_last_y THEN
		ll_x = dw_field_data.GetItemNumber( li_found, "x_pos" ) 	
		ll_width = dw_field_data.GetItemNumber( li_found, "width" ) 
		ll_width = ll_width * 10
		ole_edit.object.ScrollPositionY(  ll_y ) 
		ole_edit.object.Annotationtype( 4 )	
		ole_edit.object.AnnotationFillColor( 8454143 )				
		ole_edit.Object.DeleteAnnotationGroup( "highlight" )
		ole_edit.Object.AddAnnotationGroup( "highlight" )
		ole_edit.object.Draw( 1, 30, 1000, 20 )
		//ole_edit.object.ShowMagnifier( True, 1, 30, 800, 30 )		
		ll_last_y = ll_y
	END IF
ELSE
	ole_edit.Object.DeleteAnnotationGroup( "highlight" )
END IF

ole_edit.object.Annotationtype( 0 )	
ole_edit.object.SelectAnnotationGroup ( "" )

This.SetRedraw( True )

Return 1
end function

on w_ezflow.create
int iCurrent
call super::create
this.ole_edit=create ole_edit
this.dw_field_data=create dw_field_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_edit
this.Control[iCurrent+2]=this.dw_field_data
end on

on w_ezflow.destroy
call super::destroy
destroy(this.ole_edit)
destroy(this.dw_field_data)
end on

type ole_edit from olecustomcontrol within w_ezflow
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
event readystatechange ( long readystate )
int Width=3671
int Height=832
int TabOrder=10
boolean BringToTop=true
long TextColor=33554432
BorderStyle BorderStyle=StyleLowered!
string BinaryKey="w_ezflow.win"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_field_data from u_dw within w_ezflow
int X=3904
int Y=392
int Width=571
int Height=180
int TabOrder=20
boolean BringToTop=true
string DataObject="d_ezflow_field_data"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_ezflow.bin 
2B00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000054c5684001c2333200000003000004800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000003b800000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c0000000054c5684001c2333254c5684001c23332000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000f0000009f000000000000000100000002000000030000000400000005000000060000000700000008000000090000000a0000000b0000000c0000000d0000000efffffffe0000001000000011fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000200056d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b00000030000003880000001000000100000000880000010100000090000001020000009800000103000000a000000104000000a800000105000000b000000106000000c40000010700000208000001080000021000000109000002180000010a000002200000010b000002280000010c000002300000010d000002380000010e000002400000000000000248000000030002000400000003000052fe000000030000157f000000030000006000000002000000010000001e0000000945676d4931746964000000000000004b000001390000fffe000100050be3520311ce8f91aa00e39d51b84b0000000001fb8f0821101b01640008ed8413c72e2b00000030000001090000000800000002000000480000000a00000054000000090000005c0000000400000064000000070000007000000006000000780000000800000080000000000000008800000008000000020000004d00000002000000000000000200000190000000060001d4c0000000000000000b000000000000000b000000000000000b00000000000000080000000000000005006f00660000086e00000e00740073006900720065006b000400740005000000730000007a0069000000000900000007006500770a670069080000006300000061006800070072000a0000007500000064006e0072006500000002000000050061006e0000066d000007000000690000006100740000006c000000030188fa000000000b0000ffff000000020000e8cc000000020000e8cc000000030012e91c000000030012e91c0000000b0000ffff0000000b0000ffff0000001000000000000000095f656c6f7469646500010b0000000b0065726c0076726573003164650000010d0000000b73657262657672650c0031640b0000016c000000657365726465767201090032000b00007273000072657365316465760001060000000f006e6e61007461746f666e6f6900746e6f0000010e0000000b73657262657672650a0032640b00000173000000657365726465767201030032000c0000735f00006b636f74706f727001040073000c00006f620000726564726c79747301050065000d00006d6900006365676172746e6f01006c6f090000015f000000657478650078746e00000102000000097478655f79746e650001080000001300726f660069666563696c656c6e696b6e00783167000001070000000f6f646e7566667562697372650000657a090000015f00000073726576006e6f69006e005f006c007500020004000052fe0000157f0000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000000000000be3520311ce8f91aa00e39d51b84b0000000001d4c001904804000100766c65000000000000010000000000ff0000010000010100030000fa0000000000018800000000002e000134e93400001045e900104578000000780000000000000000002e00320075006300720072006e0065005c007400650072006f0070007400720070002e006c006200530000005c003a0065004400650076006f006c006d0070006e0065005c00740065005600730072006f00690020006e002e00320075006300720072006e0065005c0074006500730075006300690072007900740070002e006c006200530000005c003a0065004400650076006f006c006d0070006e0065005c00740065005600730072006f00690020006e002e00320075006300720072006e0065005c007400690073006500740073005f0072007500650076002e0079006200700000006c003a00530044005c00760065006c00650070006f0065006d0074006e0056005c0072006500690073006e006f003200200063002e00720075006500720074006e0075005c0064007000740061002e0065006200700000006c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_ezflow.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
