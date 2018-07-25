$PBExportHeader$uo_req_image.sru
$PBExportComments$[intellicontract_tab]  The contract locations Tab Page
forward
global type uo_req_image from u_tabpg_contract_master
end type
type ole_scan from olecustomcontrol within uo_req_image
end type
type ole_edit from olecustomcontrol within uo_req_image
end type
type ole_admin from olecustomcontrol within uo_req_image
end type
type ole_2 from olecustomcontrol within uo_req_image
end type
type ole_ocr from olecustomcontrol within uo_req_image
end type
type cb_3 from commandbutton within uo_req_image
end type
type ole_thumbnail from olecustomcontrol within uo_req_image
end type
type ln_1 from line within uo_req_image
end type
type dw_1 from u_dw_contract within uo_req_image
end type
type st_2 from u_st_splitbar within uo_req_image
end type
type st_3 from u_st_splitbar within uo_req_image
end type
type ole_edit_work from olecustomcontrol within uo_req_image
end type
type cb_1 from commandbutton within uo_req_image
end type
type st_4 from statictext within uo_req_image
end type
type st_5 from statictext within uo_req_image
end type
type em_1 from editmask within uo_req_image
end type
type cbx_1 from u_cbx within uo_req_image
end type
end forward

global type uo_req_image from u_tabpg_contract_master
integer width = 3840
integer height = 2088
boolean enabled = false
string text = "Images"
string powertiptext = "Images"
event ue_print ( )
event ue_scan ( long al_method )
event ue_straighten_page ( )
event ue_select ( )
event ue_load_image ( long al_image_id,  string as_file_name,  long al_version )
event ue_set_contract_id ( )
event ue_showannotationtoolpalette ( )
event ue_setthumbsize ( )
event ue_del_thumbs ( )
event ue_delete_image_object ( )
event ue_delete_image_page ( )
event ue_image_cut ( )
event ue_image_copy ( )
event ue_image_paste ( )
event ue_burninannotations ( )
event ue_rotatepage ( long al_index )
event ue_rotate_all_pages ( integer al_index )
event ue_draw_text_zone ( )
event ue_ocr ( )
event ue_ocr_all ( )
event ue_remove_all_ocr_zones ( )
event ue_add_blank_page ( integer al_page,  string as_gstrinsertappend )
event ue_annotationtoolselection ( string as_annotationtype )
event ue_undo ( )
event ue_redo ( )
event ue_show_anotations ( integer al_index )
event ue_pagedirection ( integer al_index )
event ue_keydown2 pbm_keydown
ole_scan ole_scan
ole_edit ole_edit
ole_admin ole_admin
ole_2 ole_2
ole_ocr ole_ocr
cb_3 cb_3
ole_thumbnail ole_thumbnail
ln_1 ln_1
dw_1 dw_1
st_2 st_2
st_3 st_3
ole_edit_work ole_edit_work
cb_1 cb_1
st_4 st_4
st_5 st_5
em_1 em_1
cbx_1 cbx_1
end type
global uo_req_image uo_req_image

type variables
pfc_cst_nv_image_functions image_functions

//of_FileRead
string ls_current_image_path
string gs_contract_path

long ll_current_page
long ll_current_row
string is_file_name
boolean il_pallet_vis 

long ll_ocx_page
long ll_ocx_width
long ll_ocx_height
long ll_ocx_left
long ll_ocx_top

boolean ib_new_zone
boolean ib_new_zone_ocr
CONSTANT STRING SCAN_TYPE_DOCUMENT = 'document'

boolean ib_default_printer = true

end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_delete (long al_start_page, long al_end_page)
public function integer of_print ()
public function integer of_del_save ()
public function integer of_set_page ()
public function integer of_load_image (long al_image_id, string as_file_name, long al_version)
end prototypes

event ue_print();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 08 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

try


if ib_default_printer then
	//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
	//--------Begin Modified by  Nova 05.05.2010------------------------
   //ole_edit.object.PrintImage()
	ole_edit.object.PrintImage(1,ole_edit.object.PageCount,3)
	//--------End Modified --------------------------------------------
else 
  	ole_admin.object.image = ole_edit.object.image
  	image_functions.of_print( ole_admin, ole_edit, Handle(this), '',1, ole_edit.object.pagecount())
end if 
catch (runtimeerror rte)
end try 
//inv_contract_details.of_adjust_menu( getparent(), '')

end event

event ue_scan(long al_method);
/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 08 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

IF FileExists(ls_current_image_path)  THEN
	if MessageBox( "OverWrite", "Are you sure you want to rescan the contract " + ls_current_image_path , Question!, YesNo!, 1 ) = 2 then 
	 Return 
	end if

END IF
// clear the current image
ole_edit.Object.Image = ""
ole_edit.Object.ClearDisplay()

ole_scan.object.DestImageControl =   ole_edit.object.ImageControl
// set the page property if we are inserting a page
if al_method = 2 or al_method = 4 then 
	ole_scan.object.page = ole_edit.object.page
end if

//ole_scan.object.MultiPage = True
//ole_scan.object.PageCount = 5
//ole_scan.object.SetPageTypeCompressionOpts(1,3,0,0)

image_functions.of_Setup_Scan( ole_scan, ls_current_image_path , al_method )
ole_thumbnail.object.Image(ls_current_image_path)
ole_thumbnail.object.ThumbSelected(1,true)







end event

event ue_straighten_page();

image_functions.of_straighten_page(ole_edit)
end event

event ue_select();

string ll_path
long ThumbNumber
ThumbNumber =  ole_thumbnail.object.LastSelectedThumb
ole_edit.object.Image = ole_thumbnail.object.Image
ole_edit.object.page(ThumbNumber)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.21.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
/*
ole_edit.Object.Display()
*/
if ole_edit.object.Image <> '' then
	ole_edit.Object.Display()
end if
//---------------------------- APPEON END ----------------------------
ole_edit.object.FitTo(1)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.21.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
/*
  ole_ocr.object.Image = ole_thumbnail.object.Image
*/
try 
   ole_ocr.object.Image = ole_thumbnail.object.Image
CATCH (RunTimeError rte)
end try
//---------------------------- APPEON END ----------------------------
of_set_page( )










	
end event

event ue_load_image(long al_image_id, string as_file_name, long al_version);/******************************************************************************************************************
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

//ls_current_image_path = inv_contract_details.of_get_image(al_image_id,as_file_name)
ls_current_image_path = inv_contract_details.of_get_image(al_image_id,al_version)


if len(ls_current_image_path) > 0 then
	try
		
		ole_thumbnail.object.Image(ls_current_image_path)
		ole_admin.object.Image(ls_current_image_path)
		ole_thumbnail.object.ThumbSelected(1,true)
		// dispaly the ocr zomes that have been saved-
		image_functions.of_tool_item(4, ole_edit, ole_ocr, ole_admin)
		event ue_select( )
	catch (runtimeerror rte)
		//messagebox('Image Missing', 'The image: ' +ls_current_image_path+ ' is missing. Please check your path.')
	end try
else
	messagebox('Image Retreival Failure','The Image was not retrieved from the database.')

end if 



end event

event ue_showannotationtoolpalette();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 09 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


try
//	if il_pallet_vis then 
//	  ole_edit.object.HideAnnotationToolPalette()
//   end if
	ole_edit.object.ShowAnnotationToolPalette()
	il_pallet_vis = true
catch (runtimeerror rte)
//	il_pallet_vis = false
//	event ue_showannotationtoolpalette( )
end try
end event

event ue_setthumbsize();

  image_functions.of_setthumbsize(ole_thumbnail )
end event

event ue_del_thumbs();
//we_del_thumbs
openwithparm(w_contract_delete_thums,this)
end event

event ue_delete_image_object();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.01.2006 By: WangChao
//$<reason> Fix a defect.

if not isvalid(image_functions) then image_functions = CREATE pfc_cst_nv_image_functions 

//---------------------------- APPEON END ----------------------------

image_functions.of_editactionitem(OLE_EDIT,0,ole_thumbnail,  ole_admin , ole_ocr)
end event

event ue_delete_image_page();/******************************************************************************************************************
**  [PUBLIC]   : Delete the selected thumbnails
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 10 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


if messagebox('Delete Pages','Are you sure you want to delete the selected page(s)? They will be deleted immediately.',question!,yesno!,2 ) = 1 then
   image_functions.of_editactionitem(  ole_edit, 7, ole_thumbnail,  ole_admin,ole_ocr )
end if 

end event

event ue_image_cut();


image_functions.of_editactionitem(ole_edit, 0, ole_thumbnail, ole_admin,ole_ocr)
end event

event ue_image_copy();

image_functions.of_editactionitem(ole_edit, 1, ole_thumbnail, ole_admin,ole_ocr)
end event

event ue_image_paste();


image_functions.of_editactionitem(ole_edit, 4, ole_thumbnail, ole_admin,ole_ocr)
end event

event ue_burninannotations();/******************************************************************************************************************
**  [PUBLIC]   : 
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


if messagebox('Make Annotations Permanent','Are you sure you want to make annotations permanent?',question!,yesno!,2)= 1 then 
   //image_functions.of_BurnInAnnotations(ole_edit,0,0)
	ole_edit.object.BurnInAnnotations(1, 2)
end if
end event

event ue_rotatepage(long al_index);
ole_thumbnail.Visible = true
image_functions.of_RotatePage( al_index, ole_edit, ole_thumbnail)
end event

event ue_rotate_all_pages(integer al_index);
try 
image_functions.of_rotate_all_pages(al_index,ole_edit, ole_thumbnail)

catch (runtimeerror rte)
end try 

end event

event ue_draw_text_zone();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 11 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



//image_functions.of_tool_item(4, ole_edit, ole_ocr, ole_admin)
image_functions.of_tool_item(2, ole_edit, ole_ocr, ole_admin)
end event

event ue_ocr();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 15 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



if ll_current_row < 1 then 
	messagebox('No data', 'No requirement selected. Please select a requirement' )
	return 
end if 

try 
image_functions.of_tool_item(0, ole_edit, ole_ocr, ole_admin)

catch (runtimeerror rte)
end try 

end event

event ue_ocr_all();
/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 15 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/





if ll_current_row < 1 then 
	messagebox('No data', 'No requirement selected. Please select a requirement' )
	return 
end if 

try
image_functions.of_tool_item(11, ole_edit, ole_ocr, ole_admin)

catch (runtimeerror rte)
end try 

end event

event ue_remove_all_ocr_zones();/******************************************************************************************************************
**  [PUBLIC]   : ue_Remove_All_OCR_Zones
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 11 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



try 
if messagebox('Remove All Ocr Zones', 'Are you sure you want to remove all OCR zones?',question!,YesNo!,2) = 1 then
  image_functions.of_tool_item(5, ole_edit, ole_ocr, ole_admin)
end if 

catch (runtimeerror rte)
end try 

end event

event ue_add_blank_page(integer al_page, string as_gstrinsertappend);
try

image_functions.of_insert_blank_page(ole_thumbnail, &
                                     ole_edit, &
												ole_edit_work, &
												ole_admin, &
												al_page, &
												as_gstrinsertappend)
												
									of_set_page( )
									
									catch (runtimeerror rte)
end try 

end event

event ue_annotationtoolselection(string as_annotationtype);



//image_functions.of_annotationtoolselection( )
image_functions.of_annotationtoolselection(ole_edit,as_annotationtype )
end event

event ue_undo();

try
ole_edit.object.Undo()
catch (runtimeerror ret)
end try
end event

event ue_redo();


try
ole_edit.object.Redo()
catch (runtimeerror rte)
end try 

end event

event ue_show_anotations(integer al_index);

 image_functions.of_show_anotations( al_index,ole_edit)
end event

event ue_pagedirection(integer al_index);
try 
of_del_save( )
image_functions.of_PageDirection(ole_thumbnail ,al_index,ole_edit)

of_set_page( )

catch (runtimeerror rte)
end try 






end event

public function integer of_retrieve ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  16 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



if not ib_retrieved then
	 
end if

ib_retrieved = true

RETURN SUCcess
end function

public function integer of_delete (long al_start_page, long al_end_page);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 09 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

setredraw(false)

ole_edit.Object.Image = ""
ole_edit.Object.ClearDisplay()
ole_thumbnail.Object.Image = ""
ole_admin.object.DeletePages(al_start_page ,al_end_page)
ole_thumbnail.Object.Image = ls_current_image_path
ole_edit.Object.Image = ls_current_image_path
event ue_select( )
setredraw(true)



return 0

end function

public function integer of_print ();//
//
//
//Private Sub mnuFilePrint_Click()
//'**************************************************************
//' PRIVATE SUB mnuFilePrint_Click:  Open ImgAdmin's Print dialog
//' and call ImgEdit's Print function with the user selected
//' options.
//'**************************************************************
//'** Booleans
//    Dim blnAnnotations As Boolean
//'** Integers
//    Dim intFormat As Integer
//
//    On Error Resume Next
//    
//    If ImgEdit1.ImageModified = True Then
//        If MsgBox(SAVE_BEFORE_PRINT, vbYesNo) = vbYes Then
//            mnuFileSave_Click
//        End If
//    End If
//    
//    ImgAdmin1.Flags = 0
//    ImgAdmin1.ShowPrintDialog frmMain.hWnd
//    
//    '----------------------------------------------------------
//    ' If the Cancel button was pressed, exit the subroutine.
//    ' If a different error occurred, declare a message box and
//    ' exit the subroutine.
//    '----------------------------------------------------------
//    If Err.Number = CANCEL_PRESSED Then     '32755 = Cancel pressed
//        Exit Sub
//    ElseIf ImgAdmin1.StatusCode <> 0 Then
//        MsgBox Err.Description & " (ImgAdmin error " & _
//            Hex(ImgAdmin1.StatusCode) & ")", vbCritical
//        Exit Sub
//    End If
//    
//    '----------------------------------------------------------
//    ' Using the values from the Print dialog box, print the
//    ' image.  If an error occurred, declare a message box and
//    ' exit the subroutine.
//    '----------------------------------------------------------
//    intFormat = ImgAdmin1.PrintOutputFormat
//    blnAnnotations = ImgAdmin1.PrintAnnotations
//    ImgEdit1.PrintImage ImgAdmin1.PrintStartPage, ImgAdmin1.PrintEndPage, intFormat, blnAnnotations
//        
//    If ImgEdit1.StatusCode <> 0 Then
//        MsgBox Err.Description & " (ImgEdit error " & _
//            Hex(ImgEdit1.StatusCode) & ")", vbCritical
//        Exit Sub
//    End If
//	 
	 
	 
	 
	 
	 return 0
end function

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

if ib_new_zone then 
	if not  ib_new_zone_ocr then
		dw_1.object.ctx_elements_ctx_page[dw_1.getrow()]    =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctx_page',primary!,true)
		dw_1.object.ctx_elements_ctx_hilgt_x[dw_1.getrow()] =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctx_hilgt_x',primary!,true)
		dw_1.object.ctx_elements_ctx_hilgt_y[dw_1.getrow()] =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctx_hilgt_y',primary!,true)
		dw_1.object.ctx_elements_ctc_hilgt_w[dw_1.getrow()] =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctc_hilgt_w',primary!,true)
		dw_1.object.ctx_elements_ctx_hilgt_h[dw_1.getrow()] =   dw_1.getitemNumber(dw_1.getrow(),'ctx_elements_ctx_hilgt_h',primary!,true)
		dw_1.accepttext( )
		ib_new_zone = false
		ib_new_zone_ocr = false
	end if 
end if

if ll_ocx_page > 0 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-17 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(ole_edit.object.Image)
	if Len(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return 0
	end if
	//---------------------------- APPEON END ----------------------------
	try 
		ole_edit.object.DeleteAnnotationGroup ('mymark')
		ole_edit.object.save()
	catch (runtimeerror rete)
	
	end try
end if

return 0

end function

public function integer of_set_page ();

try

st_4.text = 'Page: '+ string( ole_edit.object.page()) +' of ' + string( ole_edit.object.pagecount()) 
catch (runtimeerror rte)
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
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 19 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
string ls_from,ls_Rtn

////////////////////////////////////////////////////////////////////
// check for nulls
////////////////////////////////////////////////////////////////////

if not f_validstr(as_file_name) then 
	return -1
end if

try 
	
//ls_current_image_path = gnv_app.of_get_contract_path( ) + as_from +'_'+ + string(inv_contract_details.of_get_ctx_id( )) + '.tif'
//if not f_validstr(gnv_app.of_get_contract_path( )) then
//	messagebox('Error', 'Contract Image path is not set. Please add the path.')
//	return 0
//end if

event ue_load_image(al_image_id, as_file_name,al_version )

image_functions.of_tool_item(5, ole_edit, ole_ocr, ole_admin)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-17 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.

ls_Rtn = f_ExaWriteRight(ole_edit.object.Image)
if Len(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if
//---------------------------- APPEON END ----------------------------

ole_edit.object.save()

catch (runtimeerror rte)
	//messagebox('Error', 'uo_req_image::of_load_image has failed.')
	
end try

return 0
end function

on uo_req_image.create
int iCurrent
call super::create
this.ole_scan=create ole_scan
this.ole_edit=create ole_edit
this.ole_admin=create ole_admin
this.ole_2=create ole_2
this.ole_ocr=create ole_ocr
this.cb_3=create cb_3
this.ole_thumbnail=create ole_thumbnail
this.ln_1=create ln_1
this.dw_1=create dw_1
this.st_2=create st_2
this.st_3=create st_3
this.ole_edit_work=create ole_edit_work
this.cb_1=create cb_1
this.st_4=create st_4
this.st_5=create st_5
this.em_1=create em_1
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_scan
this.Control[iCurrent+2]=this.ole_edit
this.Control[iCurrent+3]=this.ole_admin
this.Control[iCurrent+4]=this.ole_2
this.Control[iCurrent+5]=this.ole_ocr
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.ole_thumbnail
this.Control[iCurrent+8]=this.ln_1
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.ole_edit_work
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.em_1
this.Control[iCurrent+17]=this.cbx_1
end on

on uo_req_image.destroy
call super::destroy
destroy(this.ole_scan)
destroy(this.ole_edit)
destroy(this.ole_admin)
destroy(this.ole_2)
destroy(this.ole_ocr)
destroy(this.cb_3)
destroy(this.ole_thumbnail)
destroy(this.ln_1)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.ole_edit_work)
destroy(this.cb_1)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.em_1)
destroy(this.cbx_1)
end on

event dragdrop;call super::dragdrop;//
end event

event constructor;call super::constructor;image_functions = CREATE pfc_cst_nv_image_functions 




end event

event resize;call super::resize;ole_edit.object.FitTo(1)
end event

event destructor;call super::destructor;//
// /******************************************************************************************************************
//**  [PUBLIC]   : 
//**==================================================================================================================
//**  Purpose   	: 
//**==================================================================================================================
//**  Arguments 	: [none] 
//**==================================================================================================================
//**  Returns   	: [none]   
//**==================================================================================================================
//**  Notes     	: 	   
//**==================================================================================================================
//**  Created By	: Michael B. Skinner 10 August 2005  © Intellisoftgroup, Inc
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//********************************************************************************************************************/
//
// If ole_edit.object.ImageModified = True Then
//	if Messagebox('Save Changes', "Changes have been made to the image. Do you want to save changes",Question!,YesNo!,1) = 1 then
//        ole_edit.object.Save()
//	end if
//  End If

of_del_save( )



end event

type st_1 from u_tabpg_contract_master`st_1 within uo_req_image
integer x = 265
integer y = 2068
end type

type ole_scan from olecustomcontrol within uo_req_image
event scanstarted ( )
event scandone ( )
event pagedone ( long pagenumber )
event scanuidone ( )
event filenamerequest ( long pagenumber )
boolean visible = false
integer x = 443
integer y = 2104
integer width = 128
integer height = 112
integer taborder = 10
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_req_image.udo"
string displayname = "Scan Control"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_edit from olecustomcontrol within uo_req_image
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
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
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
integer x = 992
integer y = 72
integer width = 2793
integer height = 1500
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_req_image.udo"
integer binaryindex = 1
string displayname = "Edit Contral"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event mouseup(integer button, integer shift, long ocx_x, long ocx_y);
//This method is valid only at run-time.
//long nCoordinates[]
//object.GetSelectedAnnotationPoints(nCoordinates)
//st_4.text= string(nCoordinates[1])

//Menu4 m_req
//
//m_req = CREATE Menu4

//m_req.m_tools.PopMenu(PointerX(), PointerY())



//messagebox('',string(ole_edit.object.MousePointer()))

// st_4.text = string(object.MousePointer() )
If Button = 2 Then 
	    //'User selected mark with a right mouse click
      try
		  ole_edit.object.ShowAttribsDialog()
	   catch(runTimeError rte)
      end try
End If
end event

event markselect(integer button, integer shift, long left, long top, long ocx_width, long ocx_height, integer marktype, string groupname);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [integer] button			Specifies the mouse button pressed: 1-Left button 2-Right button 4-Middle button
**             : [integer] shift          Specifies whether the Shift, Ctrl, or Alt key is pressed:1  Shift key 2  Ctrl key 4  Alt key
**             : [long]    left 				The beginning horizontal position within the image in image pixels
**             : [long]    top            The beginning vertical position within the image in image pixels
**             : [long] 	ocx_width		The ending horizontal position within the image in image pixels
**             : [long] 	ocx_height		The ending vertical position within the image in image pixels
**             : [long] 	marktype			Integer	The AnnotationType of the annotation mark (except for the Select Annotations annotation type)
**             : [integer] groupname		The name of the annotation group to which the annotation belongs
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 12 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long 		AnnotationType
String	ls_Rtn

if dw_1.rowcount( ) < 1 then return 

choose case marktype
	case 13
		dw_1.object.ctx_elements_ctx_page[dw_1.getrow()] =  ole_edit.object.page
		dw_1.object.ctx_elements_ctx_hilgt_x[dw_1.getrow()] = left
		dw_1.object.ctx_elements_ctx_hilgt_y[dw_1.getrow()] = top
		dw_1.object.ctx_elements_ctc_hilgt_w[dw_1.getrow()] = ocx_width
		dw_1.object.ctx_elements_ctx_hilgt_h[dw_1.getrow()] = ocx_height
		dw_1.accepttext( )
		ib_new_zone =  true
		ole_edit.Object.AddAnnotationGroup( "mymark")
	case else
		ole_edit.Object.AddAnnotationGroup( "other")
		
end choose

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-17 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.

ls_Rtn = f_ExaWriteRight(ole_edit.object.Image)
if Len(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return
end if
//---------------------------- APPEON END ----------------------------
ole_edit.object.save()

end event

event load(double zoom);String	ls_Rtn

ole_edit.SetRedraw( false)
if ll_ocx_page > 0 and ll_ocx_width > 0 and ll_ocx_height > 0 then 
	if ll_ocx_page =  ole_edit.object.page() then
		ole_edit.Object.AddAnnotationGroup( "mymark")
		ole_edit.object.Annotationtype(4)
		ole_edit.object.Draw( ll_ocx_left, ll_ocx_top,ll_ocx_width,ll_ocx_height)
		ole_edit.object.SetSelectedAnnotationFillColor( rgb(166,202,240))//8454143
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-17 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		
		ls_Rtn = f_ExaWriteRight(ole_edit.object.Image)
		if Len(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			ole_edit.SetRedraw(true)
			Return 
		end if
		//---------------------------- APPEON END ----------------------------
		ole_edit.object.save()
	end if
end if

ole_edit.SetRedraw(true)

end event

event doubleclicked;


ole_thumbnail.Visible = true
st_2.Visible = true
ole_edit.height = ole_thumbnail.y -10
dw_1.height = ole_thumbnail.y -10
ole_edit.object.FitTo(1)
end event

event constructor;image_functions.of_annotationtoolselection( this, "SelectAnnoAndZones")


//ole_edit.object.UndoLevels = 1
end event

type ole_admin from olecustomcontrol within uo_req_image
event filepropertiesclose ( )
boolean visible = false
integer x = 590
integer y = 2104
integer width = 128
integer height = 112
integer taborder = 80
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_req_image.udo"
integer binaryindex = 2
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_2 from olecustomcontrol within uo_req_image
event click ( )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event keydown ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event keyup ( integer keycode,  integer shift )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event readystatechange ( long readystate )
boolean visible = false
integer x = 882
integer y = 2104
integer width = 128
integer height = 112
integer taborder = 100
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_req_image.udo"
integer binaryindex = 3
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_ocr from olecustomcontrol within uo_req_image
event ocrcomplete ( integer status )
event ocrprogress ( integer percentage )
event readystatechange ( long readystate )
event ue_post_complete ( )
boolean visible = false
integer x = 736
integer y = 2104
integer width = 128
integer height = 112
integer taborder = 110
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_req_image.udo"
integer binaryindex = 4
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event ocrcomplete(integer status);

if status = 100 then 
	this.postevent('ue_post_complete')
	ib_new_zone_ocr =  true

	
end if


return 
end event

event ue_post_complete();/******************************************************************************************************************
**  [PUBLIC]   : event ue_post_complete( /*integer status */)
**==================================================================================================================
**  Purpose   	: Signals the completion of OCR processing.
**==================================================================================================================
**  Arguments 	: [integer]  status 100  OCR completed sucessfully
												-1  An error occurred and recognition was terminated
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 15 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_clause 
blob lb_blob

n_cst_string inv_string
if ll_current_row < 1 then return 

 ls_clause  = parent.dw_1.object.clause[ll_current_row]
 
 if len(ls_clause) > 0 then
	openwithparm (w_clause, ls_clause)
	parent.dw_1.object.clause[ll_current_row] = message.Stringparm
 else 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 08.21.2006 By: Liang QingShi
	//$<reason> Contract module modification
	//$<reason> Fix a defect.
	/*
	 inv_filesrv.of_fileread( ole_ocr.object.OutputFile, lb_blob)
	*/
	try 
	   inv_filesrv.of_fileread( ole_ocr.object.OutputFile, lb_blob)
	CATCH (RunTimeError rte)
	end try
	//---------------------------- APPEON END ----------------------------
	 ls_clause = string(lb_blob)
	 ls_clause = inv_string.of_globalreplace( ls_clause, 'ÿ', '')
    parent.dw_1.object.clause[ll_current_row] = ls_clause
 end if



dw_1.accepttext( )
end event

type cb_3 from commandbutton within uo_req_image
boolean visible = false
integer x = 3333
integer y = 2084
integer width = 343
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Zoom"
end type

event clicked;


 parent.ole_edit.object.Zoom = parent.ole_edit.object.Zoom / 2
  parent.ole_edit.object.Refresh()
end event

type ole_thumbnail from olecustomcontrol within uo_req_image
integer y = 1596
integer width = 3803
integer height = 332
integer taborder = 30
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "uo_req_image.udo"
integer binaryindex = 5
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event doubleclicked;

/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 10 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String	ls_Rtn

If ole_edit.object.ImageModified = True  Then
	//if Messagebox('Save Changes', "Changes have been made to the current page. Do you want to save changes",Question!,YesNo!,1) = 1 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-17 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(ole_edit.object.Image)
	if Len(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return
	end if
	//---------------------------- APPEON END ----------------------------
	ole_edit.object.Save()
	//end if
End If


ole_thumbnail.Visible = false
st_2.Visible = false
ole_edit.height = parent.height - 20
dw_1.height = parent.height - 20
ole_edit.object.FitTo(1)

parent.event ue_select( )

end event

event clicked;String	ls_Rtn

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.07.2006 By: Davis
//$<reason> Users should have the ability to click on the page on the bottom to go from one page to the next

If ole_edit.object.ImageModified = True  Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-17 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(ole_edit.object.Image)
	if Len(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return
	end if
	//---------------------------- APPEON END ----------------------------
	ole_edit.object.Save()
End If

string ll_path
long ThumbNumber
ThumbNumber =  ole_thumbnail.object.LastSelectedThumb
ole_edit.object.Image = ole_thumbnail.object.Image
ole_edit.object.page(ThumbNumber)

if ole_edit.object.Image <> '' then
	ole_edit.Object.Display()
end if

ole_edit.object.FitTo(1)

of_set_page( )

//---------------------------- APPEON END ----------------------------

end event

type ln_1 from line within uo_req_image
integer linethickness = 4
integer beginx = 46
integer beginy = 1888
integer endx = 2999
integer endy = 1888
end type

type dw_1 from u_dw_contract within uo_req_image
event ue_draw ( )
integer width = 969
integer height = 1564
integer taborder = 40
string dataobject = "d_contract_requirements"
boolean ib_retrieve_drop_downs = true
end type

event ue_draw();/******************************************************************************************************************
**  [PUBLIC]   :ue_draw 
**==================================================================================================================
**  Purpose   	: draws the anotation
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

if dw_1.rowcount( ) < 1 then return 

of_del_save()


ll_ocx_page       = dw_1.object.ctx_elements_ctx_page[dw_1.getrow()]
ll_ocx_left       = dw_1.object.ctx_elements_ctx_hilgt_x[dw_1.getrow()]
ll_ocx_top     	= dw_1.object.ctx_elements_ctx_hilgt_y[dw_1.getrow()]
ll_ocx_width		= dw_1.object.ctx_elements_ctc_hilgt_w[dw_1.getrow()]
ll_ocx_height		= dw_1.object.ctx_elements_ctx_hilgt_h[dw_1.getrow()]


//if ll_ocx_page > 0 then 
//	   try 
//		ole_edit.object.page(ll_ocx_page)
//		ole_edit.object.display()
//	catch (runtimeerror rte)
//	end try
//end if





end event

event constructor;call super::constructor;this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )
end event

event rowfocuschanged;call super::rowfocuschanged;
ll_current_row =  currentrow



event ue_draw()


//of_set_page( )
end event

event rowfocuschanging;call super::rowfocuschanging;String	ls_Rtn

If ole_edit.object.ImageModified = True  Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-17 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(ole_edit.object.Image)
	if Len(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return 1
	end if
	//---------------------------- APPEON END ----------------------------
	ole_edit.object.Save()
end if

end event

event clicked;call super::clicked;//ll_current_row =  row
//
//
//
//event ue_draw()
end event

type st_2 from u_st_splitbar within uo_req_image
integer y = 1572
integer width = 4000
boolean bringtotop = true
end type

event constructor;call super::constructor;

this.of_Register(ole_edit,abovE)
this.of_Register(dw_1,ABOVE)
this.of_Register(ole_thumbnail,bELOW)


end event

type st_3 from u_st_splitbar within uo_req_image
integer x = 969
integer y = 4
integer width = 18
integer height = 1552
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
end type

event constructor;call super::constructor;




this.of_Register(ole_edit,right)
this.of_Register(dw_1,left)



end event

type ole_edit_work from olecustomcontrol within uo_req_image
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
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
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
boolean visible = false
integer x = 1029
integer y = 2104
integer width = 128
integer height = 112
integer taborder = 50
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_req_image.udo"
integer binaryindex = 6
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_1 from commandbutton within uo_req_image
boolean visible = false
integer x = 50
integer y = 2104
integer width = 343
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;ole_edit.object.ScrollPositionX(800)
end event

type st_4 from statictext within uo_req_image
integer x = 1024
integer width = 800
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
boolean focusrectangle = false
end type

type st_5 from statictext within uo_req_image
boolean visible = false
integer x = 1861
integer y = 4
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Goto Page:"
boolean focusrectangle = false
end type

type em_1 from editmask within uo_req_image
event ue_keydown pbm_keydown
boolean visible = false
integer x = 2318
integer width = 343
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
double increment = 1
string minmax = "1~~50000"
end type

event ue_keydown;

IF KeyDown(KeyEnter!) then 
	long  ll_data
	ll_data = long(this.text)
	
	if ll_data > ole_edit.object.pagecount() then return 
	//ole_edit.object.Image = ole_thumbnail.object.Image
	ole_edit.object.page(ll_data)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 08.21.2006 By: Liang QingShi
	//$<reason> Contract module modification
	//$<reason> Fix a defect.
	/*
	ole_edit.Object.Display()
	*/
	if ole_edit.object.Image <> '' then
		ole_edit.Object.Display()
	end if
	//---------------------------- APPEON END ----------------------------
	ole_edit.object.FitTo(1)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 08.21.2006 By: Liang QingShi
	//$<reason> Contract module modification
	//$<reason> Fix a defect.
	/*
	ole_ocr.object.Image = ole_thumbnail.object.Image
	*/
	try 
	   ole_ocr.object.Image = ole_thumbnail.object.Image
	CATCH (RunTimeError rte)
	end try
	//---------------------------- APPEON END ----------------------------
	of_set_page( )
end if
end event

type cbx_1 from u_cbx within uo_req_image
integer x = 2235
integer width = 750
integer height = 68
boolean bringtotop = true
long backcolor = 33551856
string text = "Use Default\Previous Printer"
boolean checked = true
end type

event clicked;call super::clicked;


if checked then 
	ib_default_printer = true 
else 
	ib_default_printer = false
end if 
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
04uo_req_image.bin 
2500000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c415d38001d131c800000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff0000000384926ca0101c2941600e6f817f4b111300000000c415d38001d131c8c415d38001d131c8000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000003b0000000000000001000000020000000300000004fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe0002020684926ca0101c2941600e6f817f4b111300000001fb8f0821101b01640008ed8413c72e2b00000030000000e000000006000001000000003800000101000000400000010200000048000001030000005000000104000000580000000000000068000000030001000000000003000002e500000003000002e500000003000000000000001e00000006696177540000006e00000006000000000000000d6e6163536e6f43206c6f727400010400000010006c657300657463656163736472656e6e0001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000002e5000002e500000000000100000001000000007fff00000001000100000003000100000008000000000142c8006177540500006e6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c415d38001d131c800000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000027f00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000c415d38001d131c8c415d38001d131c8000000000000000000000000006f00430074006e006e006500730074
2C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000024f0000001000000100000000880000010100000090000001020000009800000103000000a000000104000000a800000105000000b000000106000000c400000107000000cc00000108000000d400000109000000dc0000010a000000e40000010b000000ec0000010c000000f40000010d000000fc0000010e00000104000000000000010c00000003000200050000000300003f2600000003000026c2000000030000006000000002000000010000001e0000000945676d493174696400000000000000032ffffffe0000000b0000ffff00000002000064c9000000020000bd94000000020000bd94000000030018bde4000000030018bde40000000b0000ffff0000000b0000ffff00000010000000000000000d746964456e6f43206c61727400010b0000000b0065726c0076726573003164650000010d0000000b73657262657672650c0031640b0000016c000000657365726465767201090032000b00007273000072657365316465760001080000000e0067616d006966696e6f7a72650e006d6f0b000001620000006573657264657672010a0032000b00007273000072657365326465760001030000000c0074735f00706b636f73706f720001040000000c00726f620073726564656c79740001050000000d00616d69006f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e000001070000001363726f666c6966656e696c65676e696b060078310f00000175000000626f646e656666757a6973720100006500090000765f00006973726500006e6f0002000500003f26000026c20000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100be2864c91000be28100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c415fa9001d131c800000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000c415fa9001d131c8c415fa9001d131c8000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020206009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f0000000070000010000000040000001010000004800000102000000500000010300000058000001040000006000000105000000680000000000000070000000030003000200000003000002e500000003000002e50000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000
220000000000000000000000000000000000000000000000000000000000030002000002e5000002e500000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c415fa9001d131c800000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000010900000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028511ce9f116002fd838ac03e8c00000000c415fa9001d131c8c415fa9001d131c8000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000005000000410000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028511ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b00000030000000d90000000600000100000000380000010100000040000001020000004800000103000000500000010400000058000000000000006c000000030002000500000003000002e500000003000002e500000003000000400000001e0000000945676d4931746964000000000000000600000000000000010001030000000c0074735f00706b636f73706f72000104000000110073656400616d69746f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020005000002e5000002e5000000400000ff01676d4908746964450000003100ff0002ffff000000000000000000ff000000ffff0000000000ffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c415fa9001d131c800000003000001400000000000500003004f0042005800430054005300450052004d004100000000000000000000000000000000000000000000000000000000
2D0000000000000000000000000102001affffffff00000002ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038fc248e311cfd4d920002787a7dca5af00000000c415fa9001d131c8c415fa9001d131c8000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000040000003c00000000000000010000000200000003fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202068fc248e311cfd4d920002787a7dca5af00000001fb8f0821101b01640008ed8413c72e2b00000030000000a400000005000001000000003000000101000000380000010200000040000001030000004800000000000000500000000300000000000000030002010500000003000013d800000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020105000013d80000000000010000000000000101000000000000000000000000000000000000000000c80000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c415fa9001d131c800000003000002000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000016100000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003e1a6b8a0101c360302046eac029c002400000000c415fa9001d131c8c415fa9001d131c8000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000600000046000000000000000100000002000000030000000400000005fffffffe00000007fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020206e1a6b8a0101c360302046eac029c002400000001fb8f0821101b01640008ed8413c72e2b000000300000013100000009000001000000005000000101000000580000010200000060000001030000006800000104000000700000010500000078000001060000008000000107000000880000000000000090000000030002000200000003000055fd000000030000089400000003000000610000000300c0c0c0000000020000000100000003000000780000000b0000ffff0000000900000000000000010001030000000c0074735f00706b636f73706f720001050000000c00726f620073726564656c79740001040000000a00636162006c6f636b0700726f0b00000161000000736f747563656c6501060074000c00006874000068626d75686769650101007400090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000020002000055fd000008940000006100c0c0c0c00100018000c0c00100808000005500000078000000000000010000ff0001010000000000000000ff0000000000000100000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001
26fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c41621a001d131c800000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000027300000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000c415fa9001d131c8c41621a001d131c8000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f11
2C6002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b00000030000002430000001000000100000000880000010100000090000001020000009800000103000000a000000104000000a800000105000000b000000106000000c400000107000000cc00000108000000d400000109000000dc0000010a000000e40000010b000000ec0000010c000000f40000010d000000fc0000010e00000104000000000000010c000000030002000500000003000002e500000003000002e5000000030000006000000002000000010000001e0000000945676d493274696400000000000000032ffffffe0000000b0000ffff00000002000064c9000000020000bd94000000020000bd94000000030018bde4000000030018bde40000000b0000ffff0000000b0000ffff00000010000000000000000100010b0000000b0065726c0076726573003164650000010d0000000b73657262657672650c0031640b0000016c000000657365726465767201090032000b00007273000072657365316465760001080000000e0067616d006966696e6f7a72650e006d6f0b000001620000006573657264657672010a0032000b00007273000072657365326465760001030000000c0074735f00706b636f73706f720001040000000c00726f620073726564656c79740001050000000d00616d69006f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e000001070000001363726f666c6966656e696c65676e696b060078310f00000175000000626f646e656666757a6973720100006500090000765f00006973726500006e6f00000000000000000000000000020005000002e5000002e50000006000010001000000006d490800696445670001327400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100be2864c91000be28100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14uo_req_image.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
