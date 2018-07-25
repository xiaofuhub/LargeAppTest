$PBExportHeader$u_tab_supporting_images_det.sru
$PBExportComments$[intellicontract_tab]  Supporting information Tab
forward
global type u_tab_supporting_images_det from u_tab
end type
type tabpage_browse from u_tabpage_supporting_images_det_browse within u_tab_supporting_images_det
end type
type tabpage_browse from u_tabpage_supporting_images_det_browse within u_tab_supporting_images_det
end type
type tabpage_view from u_tabpage_supporting_images_det_view within u_tab_supporting_images_det
end type
type tabpage_view from u_tabpage_supporting_images_det_view within u_tab_supporting_images_det
end type
end forward

global type u_tab_supporting_images_det from u_tab
integer width = 4599
integer height = 2184
long backcolor = 33551856
tabpage_browse tabpage_browse
tabpage_view tabpage_view
end type
global u_tab_supporting_images_det u_tab_supporting_images_det

type variables



datastore ids_cntx_images


boolean ib_image_used /* the current media is a tif file*/

long    il_start_page
long    il_end_page
long 		il_image_id
string  is_page_description
string  is_image_name
long il_version

n_cst_contract INV_cst_contract
end variables

forward prototypes
public function integer of_retrieve ()
public function u_tabpg of_gettabpage (integer ai_index)
public function integer of_select_view_tabpage ()
public function integer of_save_image ()
public function integer of_share_data (datawindow ads)
public function integer of_set_row (integer al_row)
public function integer of_set_data (long al_start_page, long al_end_page, string as_image_name)
public function string of_get_image_name ()
public function integer of_select_pages (long al_start_page, long al_end_page, string as_page_description, string as_image_name, long al_image_id)
public function long of_get_image_id ()
public function integer of_get_version ()
public function integer of_set_image_type (integer al_type)
public function integer of_get_image_type ()
end prototypes

public function integer of_retrieve ();
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
**  Created By	: Michael B. Skinner 23 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


this.tabpage_browse.of_retrieve( )

RETURN 0
end function

public function u_tabpg of_gettabpage (integer ai_index);/******************************************************************************************************************
**  [PUBLIC]   : of_GetTabPage( /*integer ai_index */)
**==================================================================================================================
**  Purpose   	: Return the specified tab page based upon the index, ai_index.
**==================================================================================================================
**  Arguments 	: [ai_index] index of the tabpage in the control array
**==================================================================================================================
**  Returns   	: [u_tabpg] The current tab page   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 28 July 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


Return this.Control[ai_index]
end function

public function integer of_select_view_tabpage ();/******************************************************************************************************************
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

this.SelectedTab = 2




return success

end function

public function integer of_save_image ();

this.tabpage_view.uo_1.of_del_save( )


return success
end function

public function integer of_share_data (datawindow ads);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 26 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


ads.sharedata(ids_cntx_images)


return success
end function

public function integer of_set_row (integer al_row);

ids_cntx_images.setrow( al_row)

return 0
end function

public function integer of_set_data (long al_start_page, long al_end_page, string as_image_name);
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
**  Created By	: Michael B. Skinner 26 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


ids_cntx_images.object.page_start[ids_cntx_images.getrow()] = al_start_page
ids_cntx_images.object.page_end[ids_cntx_images.getrow()]   = al_end_page

if f_validstr(as_image_name) then
	is_image_name = as_image_name
    ids_cntx_images.object.file_name[ids_cntx_images.getrow()]   = as_image_name
end if

this.tabpage_browse.dw_1.event pfc_update(true,true)

return success

end function

public function string of_get_image_name ();


return is_image_name
end function

public function integer of_select_pages (long al_start_page, long al_end_page, string as_page_description, string as_image_name, long al_image_id);
/******************************************************************************************************************
**  [PUBLIC]   : of_select_pages( /*integer al_start_page*/, /*integer al_end_page*/, /*string as_page_description */)
**==================================================================================================================
**  Purpose   	: set some instance variables
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 06 September 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


il_start_page = al_start_page
il_end_page=  al_end_page
is_page_description = as_page_description
is_image_name = as_image_name
il_image_id = al_image_id

//this.tabpage_view.of_select_pages( al_start_page, al_end_page)



return success
end function

public function long of_get_image_id ();

return il_image_id
end function

public function integer of_get_version ();

return ids_cntx_images.object.image_version[ids_cntx_images.getrow()]
end function

public function integer of_set_image_type (integer al_type);/******************************************************************************************************************
**  [PUBLIC]   : of_set_image_type
**==================================================================================================================
**  Purpose   	: Sets the image type Historial or not
**==================================================================================================================
**  Arguments 	: [integer] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


il_version = al_type

return 0
end function

public function integer of_get_image_type ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_image_type
**==================================================================================================================
**  Purpose   	: Sets the image type Historial or not
**==================================================================================================================
**  Arguments 	: [integer] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/




return il_version
end function

on u_tab_supporting_images_det.create
this.tabpage_browse=create tabpage_browse
this.tabpage_view=create tabpage_view
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_browse
this.Control[iCurrent+2]=this.tabpage_view
end on

on u_tab_supporting_images_det.destroy
call super::destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_view)
end on

event selectionchanging;call super::selectionchanging;
/******************************************************************************************************************
**  [PUBLIC]   : event selectionchanging( /*integer oldindex*/, /*integer newindex */)
**==================================================================================================================
**  Purpose   	: This will trigger the ue_selectionchanging event on then currrent tab page. Wich will trigger the
**                pfc_validation  event. If the validation should fail the user will not be allowed to 
**                to change the tab untill the rewuired columns have data
**=================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long li_rc 

u_tabpg_contract_master	lu_tabpg

if iw_parent.function dynamic wf_get_save_status() = false then
		If oldindex > 0 Then
			// get the current tab page index
			lu_tabpg = of_GetTabPage (oldindex)
			//7/septli_rc = lu_tabpg.Event ue_selectionchanging()
			// special case - tab in a tab
			if oldindex = 2 then
				//if this.tabpage_details.tab_1.tabpage_1.dw_1.event pfc_validation( ) = failure then
	          //  return 1 			
			   //end if
				
			end if
			
			
		End If
end if
Return li_rc

end event

event selectionchanged;call super::selectionchanged;/******************************************************************************************************************
**  [PUBLIC]   :event selectionchanged( /*integer oldindex*/, /*integer newindex */)
**==================================================================================================================
**  Purpose   	: trigger ue_selectionchanged event on u_tabpg. Process Return Code. Which will run of_retrieve
**					- to retrieve the data for the tab
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

u_tabpg_contract_master	lu_tabpg
this.tabpage_view.uo_1.of_del_save( )
if iw_parent.function dynamic wf_get_save_status() = false then
	If newindex > 0 Then
		lu_tabpg = of_GetTabPage (newindex)
		lu_tabpg.Event ue_selectionchanged ()
	End If
end if

if newindex = 2 then 
	 //if il_start_page <>   0 then
	  //this.tabpage_view.uo_1.event ue_load_image( il_image_id,'')
	  this.tabpage_view.enabled = true
     this.tabpage_view.of_select_pages( il_start_page, il_end_page,is_page_description,il_image_id)
     //end if 
end if 


if newindex = 1 then 
	   this.tabpage_browse.dw_1.setfocus( )
		il_start_page =  0
		this.tabpage_view.enabled = false
		// loop throught the contract folder and save all of the
		// files to the database
		
		// NEW
//		 if ole_edit.object.ImageModified then
//		    ole_edit.object.DeleteAnnotationGroup ('mymark')
//		    ole_edit.object.save()
//        INV_cst_contract.OF_add_filetodb( /*string as_file_location*/, /*long al_image_id */)
//		 end if 


      // now delete all of the files
		
		
end if

Return success

end event

event constructor;call super::constructor;
ids_cntx_images = create datastore
ids_cntx_images.dataobject = 'd_cntx_images'
ids_cntx_images.settransobject( sqlca)


INV_cst_contract  = CREATE n_cst_contract 


end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(ids_cntx_images) then Destroy ids_cntx_images
if IsValid(inv_cst_contract) then Destroy inv_cst_contract
//---------------------------- APPEON END ----------------------------
end event

type tabpage_browse from u_tabpage_supporting_images_det_browse within u_tab_supporting_images_det
integer x = 18
integer y = 100
integer width = 4562
integer height = 2068
end type

type tabpage_view from u_tabpage_supporting_images_det_view within u_tab_supporting_images_det
integer x = 18
integer y = 100
integer width = 4562
integer height = 2068
end type

