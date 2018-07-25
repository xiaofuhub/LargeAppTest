$PBExportHeader$uo_ctt_image.sru
forward
global type uo_ctt_image from uo_req_image
end type
type ole_admin_work from olecustomcontrol within uo_ctt_image
end type
end forward

global type uo_ctt_image from uo_req_image
boolean visible = false
integer height = 2808
ole_admin_work ole_admin_work
end type
global uo_ctt_image uo_ctt_image

type variables
string is_image_name
long il_image_id

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.16.2006 By: LeiWei
//$<modification> Define a variable to be used in subsequent script.
Boolean ib_created = false
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_del_save ()
public function integer of_load_image (long al_image_id, string as_file_name, long al_version)
end prototypes

public function integer of_del_save ();
/******************************************************************************************************************
**  [PUBLIC]   : of_del_save( )
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 18 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
String	ls_Rtn

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Fix a defect.
If Not ib_created Then Return 0
//---------------------------- APPEON END ----------------------------

if ib_new_zone then 
	if not  ib_new_zone_ocr then
		dw_1.object.ctx_elements_ctx_page[dw_1.getrow()]    =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctx_page',primary!,true)
		dw_1.object.ctx_elements_ctx_hilgt_x[dw_1.getrow()] =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctx_hilgt_x',primary!,true)
		dw_1.object.ctx_elements_ctx_hilgt_y[dw_1.getrow()] =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctx_hilgt_y',primary!,true)
		dw_1.object.ctx_elements_ctc_hilgt_w[dw_1.getrow()] =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctc_hilgt_w',primary!,true)
		dw_1.object.ctx_elements_ctx_hilgt_h[dw_1.getrow()] =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctx_hilgt_h',primary!,true)
		dw_1.accepttext()
		ib_new_zone = false
		ib_new_zone_ocr = false
	end if 
end if

try
	if ole_edit.object.ImageModified then
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-17 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		
		ls_Rtn = f_ExaWriteRight(ole_edit.object.Image)
		if Len(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			Return 0
		end if
		//---------------------------- APPEON END ----------------------------
		
		ole_edit.object.DeleteAnnotationGroup ('mymark')
		ole_edit.object.save()
	end if
catch (runtimeerror rete)
	  //messagebox('Imaging','Modifications made to image have not beenn saved. Please save changes prior to closing window.')
end try

return 0
end function

public function integer of_load_image (long al_image_id, string as_file_name, long al_version);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [string]  as_from -- coming from contract or supporting documents
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	:  user to get the image from the database and load it up	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 19 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
string ls_from
n_cst_string lnvo_cst_string 

if isnull(al_image_id) then return 0

////////////////////////////////////////////////////////////////////
// check for nulls
////////////////////////////////////////////////////////////////////

//if not f_validstr(as_file_name) then 
//	return -1
//end if

try 
	 
//ls_current_image_path = gnv_app.is_application_path  + '\' + as_file_name
///ls_current_image_path = gnv_app.of_get_contract_path( ) + as_from +'_'+ + string(inv_contract_details.of_get_ctx_id( )) + '.tif'

//IF lnvo_cst_string.of_countoccurrences(as_file_name , '.tif') > 0 then
		
		//if not f_validstr(gnv_app.of_get_contract_path( )) then
		//	messagebox('Error', 'Contract Image path is not set. Please add the path.')
		//	return 0
		//end if
		
		event ue_load_image(al_image_id,'',al_version) //as_file_name
//end if

catch (runtimeerror rte)
	
	messagebox('Error', 'uo_req_image::of_load_image has failed.')
	
end try

return 0
end function

on uo_ctt_image.create
int iCurrent
call super::create
this.ole_admin_work=create ole_admin_work
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_admin_work
end on

on uo_ctt_image.destroy
call super::destroy
destroy(this.ole_admin_work)
end on

event ue_scan;/**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: override !!!  
**==================================================================================================================
**  Created By	: Michael B. Skinner 24 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
constant string  TEMP_LOCATION = 'c:\' + gs_user_id  + 'temp.tif'
long ll_page_count // the total page count before appending
long il_new_page_added
st_4.text = 'Scaning, please stand by.... '

//this.tabpage_view.of_select_pages( il_start_page, il_end_page,is_page_description)

try 
if not fileexists(ls_current_image_path) 	then
	ll_page_count =  0
   else
    ll_page_count = ole_edit.object.pagecount()
end if

if not fileexists(ls_current_image_path )  then 
	
	ole_scan.object.DestImageControl =   ole_edit.object.ImageControl
   image_functions.of_Setup_Scan( ole_scan, ls_current_image_path , 0 )
	il_new_page_added = ole_edit.object.pagecount()
	i_parent_tab.function dynamic of_set_current((1), (1 ),long( il_new_page_added ) )
   i_parent_tab.function dynamic of_set_data(long((ll_page_count)), long(il_new_page_added ) )
	
else 
		   ole_admin.Object.Image = ole_edit.Object.Image 
			ole_edit.Object.Image("")
			ole_edit.Object.ClearDisplay()
			ole_scan.object.DestImageControl =   ole_edit.object.ImageControl		
			////////////////////////////////////////////////////////////////////////////////////////////
			// set the page property if we are inserting a page
			////////////////////////////////////////////////////////////////////////////////////////////
			
			if al_method = 2 or al_method = 4 then 
				ole_scan.object.page = ole_edit.object.page
			end if
			
			////////////////////////////////////////////////////////////////////////////////////////////
			// scan to temp tiff file
			////////////////////////////////////////////////////////////////////////////////////////////
			
			filedelete(TEMP_LOCATION)
			
			if image_functions.of_Setup_Scan( ole_scan, ls_current_image_path , al_method ) = -1 then return 
			
			////////////////////////////////////////////////////////////////////////////////////////////
			// get the page count of the file .
			////////////////////////////////////////////////////////////////////////////////////////////
			
//			ole_admin_work.Object.Image = ""
//			//ole_admin_work.Object.ClearDisplay()
//			ole_admin_work.object.image(TEMP_LOCATION)
//			//ole_admin_work.object.display()
//			
//			OLE_admin.OBJECT.Append(TEMP_LOCATION,1,   ole_admin_work.object.pagecount())
//			il_new_page_added = ole_admin_work.object.pagecount()
//			ole_edit.Object.Image = ""
//			ole_edit.Object.ClearDisplay()
//			ole_edit.object.image = OLE_admin.OBJECT.image
//			ole_edit.object.page(ll_page_count + 1)
			
		   ole_edit.object.FitTo(1)
			ole_edit.object.display()
			
			
			i_parent_tab.function dynamic of_set_current(1, 1,long(il_new_page_added + 1) )
         i_parent_tab.function dynamic of_set_data(long((ll_page_count)), long(ll_page_count + il_new_page_added ) )
end if

			
catch (runtimeerror rte)
	ll_page_count = 0
end try

st_4.text = 'Scaning done.'

iw_parent.width =  3000
//ole_thumbnail.object.Image(ls_current_image_path)
//ole_thumbnail.object.ThumbSelected(1,true)




end event

event ue_load_image;/******************************************************************************************************************
**  [PUBLIC]   : event ue_load_image( )
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



try
	   ole_edit.object.ClearDisplay()
      ls_current_image_path = inv_contract_details.of_get_image(al_image_id, al_version)  
	   ole_edit.object.Image(ls_current_image_path)
		ole_edit.object.page(1)
		ole_edit.Object.Display()
		ole_edit.object.FitTo(1)
		ole_edit.Object.DisplayScaleAlgorithm = 4  //Start Code Change ---- 11.08.2006 #1 maha
		ole_ocr.object.Image = ole_edit.object.Image
	   ole_admin.object.Image = ole_edit.object.Image
	   of_set_page( )
    	//image_functions.of_tool_item(4, ole_edit, ole_ocr, ole_admin)
	   //messagebox('','')
	
catch (runtimeerror rte)
	//messagebox('Image Missing', 'The image: ' +ls_current_image_path+ ' is missing. Please check your path.')
end try


//
end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.16.2006 By: LeiWei
//$<modification> Define a variable to be used in subsequent script.
ib_created = True
//---------------------------- APPEON END ----------------------------

end event

type st_1 from uo_req_image`st_1 within uo_ctt_image
integer x = 379
integer y = 1892
boolean enabled = true
end type

type ole_scan from uo_req_image`ole_scan within uo_ctt_image
end type

type ole_edit from uo_req_image`ole_edit within uo_ctt_image
integer x = 9
integer y = 92
integer width = 3803
integer height = 1760
end type

type ole_admin from uo_req_image`ole_admin within uo_ctt_image
integer taborder = 90
end type

type ole_2 from uo_req_image`ole_2 within uo_ctt_image
integer taborder = 110
end type

type ole_ocr from uo_req_image`ole_ocr within uo_ctt_image
integer width = 1317
integer height = 768
integer taborder = 120
end type

type cb_3 from uo_req_image`cb_3 within uo_ctt_image
integer taborder = 100
end type

type ole_thumbnail from uo_req_image`ole_thumbnail within uo_ctt_image
integer y = 2360
end type

type ln_1 from uo_req_image`ln_1 within uo_ctt_image
integer beginx = 279
integer beginy = 2316
integer endx = 3232
integer endy = 2316
end type

type dw_1 from uo_req_image`dw_1 within uo_ctt_image
boolean visible = false
integer x = 1234
integer y = 2044
integer taborder = 50
boolean enabled = false
end type

type st_2 from uo_req_image`st_2 within uo_ctt_image
integer x = 59
integer y = 2264
end type

type st_3 from uo_req_image`st_3 within uo_ctt_image
boolean visible = false
integer x = 1755
integer y = 2060
boolean enabled = false
end type

type ole_edit_work from uo_req_image`ole_edit_work within uo_ctt_image
integer taborder = 60
end type

type cb_1 from uo_req_image`cb_1 within uo_ctt_image
integer taborder = 80
end type

type st_4 from uo_req_image`st_4 within uo_ctt_image
integer x = 9
integer y = 16
integer width = 2501
long backcolor = 33551856
end type

type st_5 from uo_req_image`st_5 within uo_ctt_image
integer x = 3003
integer y = 16
long backcolor = 33551856
end type

type em_1 from uo_req_image`em_1 within uo_ctt_image
integer x = 3461
integer y = 16
integer taborder = 70
end type

event em_1::ue_keydown;
IF KeyDown(KeyEnter!) then 
	long  ll_data
	ll_data = long(this.text)
//	ll_data = ll_data + i
	if ll_data > ole_edit.object.pagecount() then return 
	//ole_edit.object.Image = ole_thumbnail.object.Image
	ole_edit.object.page(ll_data)
	ole_edit.Object.Display()
//	ole_edit.object.FitTo(1)
//	ole_ocr.object.Image = ole_thumbnail.object.Image
  of_set_page( )
end if
end event

type cbx_1 from uo_req_image`cbx_1 within uo_ctt_image
integer x = 2213
integer y = 12
long backcolor = 33551856
end type

type ole_admin_work from olecustomcontrol within uo_ctt_image
event filepropertiesclose ( )
integer x = 1184
integer y = 2080
integer width = 155
integer height = 136
integer taborder = 40
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_ctt_image.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
07uo_ctt_image.bin 
2D00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000a5f8c7e001d131c800000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000a5f8c7e001d131c8a5f8c7e001d131c8000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
25ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020206009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000300020000038400000384000000000000010000000000000000000000000001010000000000000000000000000000010003000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000001000000000200000300000000000300000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17uo_ctt_image.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
