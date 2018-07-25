$PBExportHeader$u_tabpage_supporting_images_det_view.sru
$PBExportComments$[intellicontract_tab]  Supporting information Tab
forward
global type u_tabpage_supporting_images_det_view from u_tabpg_contract_master
end type
type uo_1 from uo_ctt_image within u_tabpage_supporting_images_det_view
end type
type st_2 from statictext within u_tabpage_supporting_images_det_view
end type
type em_1 from editmask within u_tabpage_supporting_images_det_view
end type
type cb_1 from commandbutton within u_tabpage_supporting_images_det_view
end type
end forward

global type u_tabpage_supporting_images_det_view from u_tabpg_contract_master
integer width = 3817
integer height = 1744
string text = "View"
uo_1 uo_1
st_2 st_2
em_1 em_1
cb_1 cb_1
end type
global u_tabpage_supporting_images_det_view u_tabpage_supporting_images_det_view

type variables


long il_start_page
long il_end_page
long il_old_start_page
long il_old_end_page
long il_current_page
string is_page_description

n_cst_string inv_string
end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_adjust_menu ()
public function integer of_set_current (integer al_current_page, integer al_start_page, integer al_end_page)
public function integer of_set_data (integer al_start_page, integer al_end_page, string as_image)
public function long of_get_image_id ()
public function integer of_select_pages (long al_start_page, long al_end_page, string as_page_description, long al_image_id)
public function string of_get_current_image ()
end prototypes

public function integer of_retrieve ();



this.uo_1.inv_contract_details =  inv_contract_details

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 03.14.2006 By: LiuHongXin
//$<reason> The statement f1(Dynamic f2()) is unsupported. If a function is dynamically called,
//$<reason>  its return value cannot be passed as an argument of another function.
//$<modification> 1)Create a variable; 2)Specify the return of the function that is dynamically
//$<modification> called to the variable; 3)Use the variable as an argument. 
/*
this.uo_1.of_load_image(i_parent_tab.function dynamic of_get_image_id()   , "", i_parent_tab.function dynamic of_get_version())
*/
Long ll_image_id, ll_version

ll_image_id = i_parent_tab.function dynamic of_get_image_id()
ll_version = i_parent_tab.function dynamic of_get_version()
this.uo_1.of_load_image(ll_image_id, "", ll_version)
//---------------------------- APPEON END ----------------------------

///this.uo_1.of_load_image( uo_1.SCAN_TYPE_DOCUMENT)



return  success
end function

public function integer of_adjust_menu ();
/******************************************************************************************************************
**  [PUBLIC]   : of_adjust_menu( )
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 26 August 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

choose case il_current_page
	case 1 										// first page 
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next,'enabled', true)
	   gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'enabled', false)
	case this.uo_1.ole_edit.object.pagecount() 	// last Page
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next,'enabled', false)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'enabled', true)
	case else 
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'enabled', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next,'enabled', true)
end choose 



return success






















//// last page --  ok
//	if il_current_page <> 1  then 
//				if il_current_page = (il_end_page - il_start_page ) and (il_current_page) > 1 then 
//			 
//					m_req.m_tools.m_page.m_next.enabled = false
//					m_req.m_tools.m_page.m_previous.enabled = true
//					return success	
//				else
//					m_req.m_tools.m_page.m_previous.enabled = true
//					m_req.m_tools.m_page.m_next.enabled = true
//					return success
//				end if
//			else
//				
//				//////////////////////////////////////////////////////////////////////////////////////////////////
//				// first page
//				//////////////////////////////////////////////////////////////////////////////////////////////////
//				
//				if (il_current_page ) =  1  then 
//					m_req.m_tools.m_page.m_next.enabled = true
//					m_req.m_tools.m_page.m_previous.enabled = false
//					return success	
//				else
//					//m_req.m_tools.m_page.m_previous.enabled = false
//					//m_req.m_tools.m_page.m_next.enabled = true
//				end if
//	
//end if 
end function

public function integer of_set_current (integer al_current_page, integer al_start_page, integer al_end_page);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx August 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


il_current_page = al_current_page
il_start_page = al_start_page
il_end_page  = al_end_page
long ll_end_page

if il_end_page - il_start_page = 0 then
	 ll_end_page = 1
else
	ll_end_page = il_end_page - il_start_page
end if 


uo_1.st_4.text = 'Page ' + string(il_current_page ) + ' of ' + string(uo_1.ole_edit.object.pagecount()) +' Description: '  + is_page_description

of_adjust_menu( )

return 0



end function

public function integer of_set_data (integer al_start_page, integer al_end_page, string as_image);

i_parent_tab.function dynamic of_set_data(al_start_page, al_end_page, as_image)

return 0
end function

public function long of_get_image_id ();
return i_parent_tab.function dynamic of_get_image_id()
end function

public function integer of_select_pages (long al_start_page, long al_end_page, string as_page_description, long al_image_id);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx August 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//
//if al_start_page < 1 or al_end_page < 1 then
//	messagebox('', 'nothing selected')
//	return failure
//end if


////////////////////////////////////////////////////////////////
// get the image from the database
////////////////////////////////////////////////////////////////

//this.uo_1.of_del_save( ) -- old

il_start_page       = al_start_page 
il_end_page         = al_end_page
is_page_description = as_page_description

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-13 By: Rodger Wu
//$<reason> Fix a defect that status message is not correct under some circumstance.

uo_1.of_set_page()
uo_1.st_4.text = uo_1.st_4.text +' Description: '  + as_page_description

//---------------------------- APPEON END ----------------------------

////////////////////////////////////////////////////////////////////////////////
// only change if the page if a different image is selected
////////////////////////////////////////////////////////////////////////////////


try 
if this.uo_1.ole_edit.object.PageCount > 1 then 
	this.em_1.enabled = true
else 
	this.em_1.enabled = false
end if 
catch (runtimeerror rt4)
end try


if al_start_page <> il_old_start_page then 
	this.uo_1.ole_edit.object.page(al_start_page)
		// thus finction is called from the parent tab in the selectionchanged event
		// will GPF on the first selectionchanged because no tiff assigned to edit control
	try 
		//		this.uo_1.ole_edit.object.Display()
	catch (runtimeerror tre)
			return success
	end try
end if
//this.uo_1.st_4.text= 'Page ' + string(1) + ' of ' + string(  this.uo_1.ole_edit.object.pagecount())
	il_current_page = 1
	this.em_1.text = '1'
	
	il_old_start_page = al_start_page
	il_old_end_page = al_end_page
	
	
of_adjust_menu( )

//else 
	
//	al_start_page = il_old_start_page 
//	al_end_page = il_old_end_page
//	
//	this.uo_1.ole_edit.object.page(il_current_page )
//		// thus finction is called from the parent tab in the selectionchanged event
//		// will GPF on the first selectionchanged because no tiff assigned to edit control
//	try 
//				this.uo_1.ole_edit.object.Display()
//	catch (runtimeerror treq)
//			return success
//	end try
//	this.uo_1.st_4.text= 'Page ' + string(il_current_page - il_start_page) + ' of ' + string(il_old_end_page -  il_old_start_page ) 
//	//this.uo_1.st_4.text = 'Page ' + string((il_current_page - il_start_page)) + ' of ' + string(il_end_page - il_start_page  )
//			
//	il_current_page = 1
//	this.em_1.text = '1'

	
//end if


return success
end function

public function string of_get_current_image ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_current_image
**==================================================================================================================
**  Purpose   	: The the current image in the users contract directory
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

return INV_contract_details.OF_GET_current_image( )
end function

on u_tabpage_supporting_images_det_view.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.st_2=create st_2
this.em_1=create em_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.cb_1
end on

on u_tabpage_supporting_images_det_view.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.cb_1)
end on

event ue_selectionchanged;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	  OVERRIDE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
**==================================================================================================================
**  Created By	: Michael B. Skinner  05 oCTOBER 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


CHOOSE CASE inv_contract_details.is_mode
	CASE inv_contract_details.new
		this.of_new( )
	CASE inv_contract_details.edit
		
		THIS.of_retrieve()

END CHOOSE


/////////////////////////////////////////////////
// adjust the menu as needed
/////////////////////////////////////////////////

//inv_contract_details.of_adjust_menu(this, STRING(i_parent_tab.FUNCTION DYNAMIC of_get_image_type() ))
inv_contract_details.of_adjust_menu(this, STRING(i_parent_tab.FUNCTION DYNAMIC of_get_image_type() ), True) //Added by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)



end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpage_supporting_images_det_view
end type

type uo_1 from uo_ctt_image within u_tabpage_supporting_images_det_view
boolean visible = true
integer taborder = 20
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_ctt_image::destroy
end on

event ue_pagedirection;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx August 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
this.ll_ocx_page = il_current_page 
long ll_page_count
of_del_save( )

ll_page_count  = this.ole_edit.object.pagecount()

if isnull(is_page_description) then is_page_description = ' '

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-08 By: Rodger Wu
//$<reason> Fix a APB defect.
if appeongetclienttype() = "WEB" then
	if al_index = 0 and message.stringparm = "next" then
		al_index = 1;
		message.stringparm = "";
	end if
end if
//---------------------------- APPEON END ----------------------------

choose case al_index
	case 1 // >>>
		 	il_current_page =  il_current_page + 1
			 
			if  il_current_page > ll_page_count then  
				il_current_page = ll_page_count
				return
			end if
			image_functions.of_PageDirection(ole_thumbnail ,al_index,ole_edit)
			
			
			this.st_4.text = 'Page ' + string((il_current_page)) + ' of ' + string(ll_page_count ) + ' Description: ' + is_page_description
			//of_set_current( il_current_page, il_start_page, il_end_page)
			of_adjust_menu( )
	case 0 // <<<
		 	il_current_page =  il_current_page - 1
			if il_current_page < 1 then 
				il_current_page =  1
            of_adjust_menu( )
				return
			end if
			image_functions.of_PageDirection(ole_thumbnail ,al_index,ole_edit)
			this.st_4.text = 'Page ' + string(il_current_page) + ' of ' + string(ll_page_count ) + ' Description: ' + is_page_description
			of_adjust_menu( )
end choose



end event

event ue_scan;/**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: override !!!  
**==================================================================================================================
**  Created By	: Michael B. Skinner 24 August 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
constant string  TEMP_LOCATION = 'c:\' + gs_user_id  + 'temp.tif'

long ll_page_count // the total page count before appending
long il_new_page_added

st_4.text = 'Scanning, please stand by.... '


//ls_parse_array

/////////////////////////////////////////////////////////////////////////
// remove the #_ protion from the file name
/////////////////////////////////////////////////////////////////////////
string ls_array[]
inv_string.of_parsetoarray(ls_current_image_path, '_', ls_array)

//if upperbound(ls_array) > 1 then
//	ls_current_image_path = ls_array[2]
//end if 

try 
	   if not fileexists(ls_current_image_path) 	then
			ll_page_count =  0
			else
			 ll_page_count = ole_edit.object.pagecount()
		end if
		
		if not fileexists(ls_current_image_path )  then 
			
			ole_scan.object.DestImageControl =   ole_edit.object.ImageControl
			// generate a unique file name
			ls_current_image_path =  ole_ADMIN.object.GetUniqueName(inv_contract_details.is_contrtact_dir_path, "temp", "tif")
			// append 	
			
			image_functions.of_Setup_Scan( ole_scan, inv_contract_details.is_contrtact_dir_path +'\'+ ls_current_image_path , 0 )
			
			//i_parent_tab.function dynamic of_set_current((1), (1 ),long( il_new_page_added ) )
			i_parent_tab.function dynamic of_set_data(long((ll_page_count)), long(il_new_page_added ), ls_current_image_path )
			
		else 
					ole_admin.Object.Image = ole_edit.Object.Image 
					//ole_edit.Object.Image("")
					//ole_edit.Object.ClearDisplay()
					ole_scan.object.DestImageControl =   ole_edit.object.ImageControl		
					////////////////////////////////////////////////////////////////////////////////////////////
					// set the page property if we are inserting a page
					////////////////////////////////////////////////////////////////////////////////////////////
					
					if al_method = 2 or al_method = 4 then 
						ole_scan.object.page = ole_edit.object.page
					end if
					
										
					// NOTIFY THE THE SCAN FUNCTION OF OUR INTENTIONS
					
					inv_contract_details.of_set_scan_method( al_method)
//					// remove the #_ part if it exists
//					if upperbound(ls_array) > 1 then
//	               ls_current_image_path = ls_array[2]
//					end if
					
					//if image_functions.of_Setup_Scan( ole_scan, inv_contract_details.is_contrtact_dir_path + '\'+ of_get_current_image() , al_method ) = -1 then return 
					
					//inv_contract_details.is_contrtact_dir_path + '\'+ 
					if image_functions.of_Setup_Scan( ole_scan, ls_current_image_path , al_method ) = -1 then return 
					
					////////////////////////////////////////////////////////////////////////////////////////////
					// get the page count of the file .
					////////////////////////////////////////////////////////////////////////////////////////////
					i_parent_tab.function dynamic of_set_current(1, 1,long(il_new_page_added + 1) )
					i_parent_tab.function dynamic of_set_data(long((ll_page_count)), long(ll_page_count + il_new_page_added ) , '' )
		end if

			
catch (runtimeerror rte)
	  ll_page_count = 0
end try


gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'enabled', false)
ls_current_image_path = gnv_app.is_application_path + '\' + ls_current_image_path

st_4.text = 'Scanning done.'

INV_contract_details.OF_ADJUST_menu( parent, '')





end event

event ue_load_image;call super::ue_load_image;uo_1.st_4.text = 'Page ' + string(il_current_page ) + ' of ' + string(uo_1.ole_edit.object.pagecount()) +' Description: '  + is_page_description
end event

type st_2 from statictext within u_tabpage_supporting_images_det_view
integer x = 3003
integer y = 20
integer width = 343
integer height = 68
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

type em_1 from editmask within u_tabpage_supporting_images_det_view
event ue_keydown pbm_keydown
integer x = 3259
integer y = 12
integer width = 347
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
string minmax = "1~~1000"
end type

event ue_keydown;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx August 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



IF KeyDown(KeyEnter!) then 
			uo_1.setredraw( false)
			uo_1.of_del_save( ) // save out stuff
			long  ll_data
			ll_data = long(this.text) 
		   if ll_data > uo_1.ole_edit.object.pagecount() then
				uo_1.setredraw(true)
				return 
			end if
			uo_1.ole_edit.object.page(ll_data )
			uo_1.ole_edit.Object.Display()
			uo_1.ole_edit.object.pagecount()
			of_set_current( ll_data, il_start_page, il_end_page)
			uo_1.setredraw(true)
end if
end event

type cb_1 from commandbutton within u_tabpage_supporting_images_det_view
integer x = 3625
integer y = 4
integer width = 133
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go"
end type

event clicked;
			uo_1.setredraw( false)
			uo_1.of_del_save( ) // save out stuff
			long  ll_data
			ll_data = long(em_1.text) 
		   if ll_data > uo_1.ole_edit.object.pagecount() then
				uo_1.setredraw(true)
				return 
			end if 
			uo_1.ole_edit.object.page(ll_data )
			uo_1.ole_edit.Object.Display()
			uo_1.ole_edit.object.pagecount()
			of_set_current( ll_data, il_start_page, il_end_page)
		uo_1.setredraw(true)
			

end event

