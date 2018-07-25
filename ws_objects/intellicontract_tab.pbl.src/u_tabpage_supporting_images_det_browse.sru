$PBExportHeader$u_tabpage_supporting_images_det_browse.sru
$PBExportComments$[intellicontract_tab]  Supporting information Tab
forward
global type u_tabpage_supporting_images_det_browse from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpage_supporting_images_det_browse
end type
end forward

global type u_tabpage_supporting_images_det_browse from u_tabpg_contract_master
integer width = 3886
integer height = 1868
long backcolor = 33551856
string text = "Browse"
string powertiptext = "Double Click a row to bring up the image."
dw_1 dw_1
end type
global u_tabpage_supporting_images_det_browse u_tabpage_supporting_images_det_browse

type variables

string is_doc_path
n_cst_string inv_string

nvo_commdlg invo_commdlg
end variables

forward prototypes
public function integer of_retrieve ()
public function long of_select_pages (long al_row)
public function integer of_browse ()
public function integer of_view ()
end prototypes

public function integer of_retrieve ();

if not ib_retrieved then 
     dw_1.event pfc_retrieve( )
end if 

ib_retrieved = true

inv_contract_details.of_adjust_menu( this,'')

return success
end function

public function long of_select_pages (long al_row);
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
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


i_parent_tab.function dynamic of_select_pages(dw_1.object.page_start[al_row],     &
                                              dw_1.object.page_end[al_row]  , &
															 dw_1.object.page_description[al_row], &
															 dw_1.object.file_name[al_row], &
															 dw_1.object.image_id[al_row] ) 
															 
															 
		return 0
end function

public function integer of_browse ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_path
string docname, named, path
integer value
string ls_Null
SetNull(ls_Null)


integer li_Files

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 03.27.2006 By: LeiWei
//$<reason> The invo_commdlg object is currently unsupported. 
//$<modification> Replace invo_commdlg with GetFileOpenName to provide the
//$<modification> same functionality.
/*
invo_commdlg.hWndParent	= Handle(this)
invo_commdlg.Title			= "Open image or text file"
invo_commdlg.Filter			= "All Files (*.*),*.*"
invo_commdlg.FilterIndex	= 2
//Dialogs.InitialDir	= "C:\Books"
invo_commdlg.Flags			= invo_commdlg.OFN_FILEMUSTEXIST + invo_commdlg.OFN_LONGNAMES + invo_commdlg.OFN_EXPLORER // + invo_commdlg.ofn_allowmultiselect

If invo_commdlg.OpenDialog() Then
    is_doc_path = invo_commdlg.PathName + "\" + invo_commdlg.Files[1]
End If
*/
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
if GetFileOpenName("Open image or text file", ls_path, named, "*", "All Files (*.*),*.*") = 1 then
	is_doc_path = ls_path
else
	is_doc_path = ''
end if
//---------------------------- APPEON END ----------------------------
gf_save_dir_path(ls_path) //Added by Ken.Guo on 2009-03-10	
//ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

return success
end function

public function integer of_view ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.08.2006 By: LeiWei
//$<reason> Implemnet new requiremnt.
Long ll_row
dwobject dwo

ll_row = dw_1.getrow()
IF ll_row <=0 THEN RETURN 0

Dw_1.event doubleclicked( 0,0,ll_row,dwo)
return 1

//---------------------------- APPEON END ----------------------------

end function

on u_tabpage_supporting_images_det_browse.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpage_supporting_images_det_browse.destroy
call super::destroy
destroy(this.dw_1)
end on

event constructor;call super::constructor;


setfocus()
end event

event ue_selectionchanged;call super::ue_selectionchanged;



this.dw_1.setfocus()
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpage_supporting_images_det_browse
integer x = 462
integer y = 2244
end type

type dw_1 from u_dw_contract within u_tabpage_supporting_images_det_browse
string tag = "Scanned Documents"
integer width = 3817
integer height = 1856
integer taborder = 10
boolean bringtotop = true
string title = "Scanned Documents"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
string dataobject_original = "d_cntx_images"
boolean ib_allow_sort = true
end type

event pfc_retrieve;call super::pfc_retrieve;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.27.2006 By: Liang QingShi
//$<reason> Contract module modification 
/*
retrieve( inv_contract_details.of_get_ctx_id( ) )
*/

long ll_ctx_id,ll_row
datawindowchild child
ll_ctx_id = inv_contract_details.of_get_ctx_id( )

retrieve(ll_ctx_id)

dw_1.getchild('image_version',child)
child.settransobject(sqlca)
child.retrieve(ll_ctx_id)
ll_row = child.insertrow(1)
child.setitem(ll_row,'version_id',0)
child.setitem(ll_row,'version_number','All')

//---------------------------- APPEON END ----------------------------



return success
end event

event doubleclicked;call super::doubleclicked;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.03.2006 By: Liang QingShi
//$<reason> Fix a defect.
if row <= 0 then return
//---------------------------- APPEON END ----------------------------

long ll_ret
string ls_null
setnull(ls_null)
string as_array[]

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-13 By: Rodger Wu
//$<reason> Fix a defect that current row is not set correctly under some circumstance.

This.setrow( row )

//---------------------------- APPEON END ----------------------------

// mskinner 21 april 2006 -- begin
if getrow() < 1 then return 
// mskinner 21 april 2006 -- end 


// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 


///////////////////////////////////////////////////////////////////////////////////////////
// save out/delete the current files checked out by this user
///////////////////////////////////////////////////////////////////////////////////////////

iw_parent.event dynamic ue_save_contract_dir( )


if this.object.status[getrow()] = "H" and f_validstr(this.object.file_name[getrow()]) then
	i_parent_tab.function dynamic of_set_image_type(inv_contract_details.historical_version )
	//messagebox('Historical File', 'Changes will NOT be saved since this document is a historical version.')
ELSE 
	i_parent_tab.function dynamic of_set_image_type(inv_contract_details.current_version )
end if 



if not f_validstr(string(object.file_name[getrow()])) then return success

inv_string.of_parsetoarray( object.file_name[getrow()], '.', as_array)

choose case as_array[2]
	case 'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
			if getrow() < 1 then return success
         i_parent_tab.function dynamic of_select_view_tabpage( )
         of_select_pages(getrow())
         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'enabled', false)
	case else 
		
			if len( inv_contract_details.of_get_image(this.object.image_id[getrow()],this.object.image_version[getrow()]) ) > 0 then 
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-01
			//$<modify> 03.24.2006 By: Liang QingShi
			//$<reason> Performance tuning
			//$<modification> This original script opens a new page in the same IE, which is incorrect.
			//$<modification> Modify the script to open a new IE instead of open a new page in the same IE.
			/*
			 ll_ret = ShellExecuteA ( Handle( This ), "open", inv_contract_details.is_contrtact_dir_path +'\'  + STRING(this.object.image_version[getrow()] ) + '_' +this.object.file_name[getrow()] , ls_Null, ls_Null, 4)
			*/
			If right(lower(STRING(this.object.image_version[getrow()] )),5)='.html' or right(lower(STRING(this.object.image_version[getrow()] )),4)='.htm' Then
			     //ll_ret = ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', inv_contract_details.is_contrtact_dir_path +'\'  + STRING(this.object.image_version[getrow()] ) + '_' +this.object.file_name[getrow()] , ls_Null, 4)  //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
				  ll_ret = ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), inv_contract_details.is_contrtact_dir_path +'\'  + STRING(this.object.image_version[getrow()] ) + '_' +this.object.file_name[getrow()] , ls_Null, 4)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
			else				
			    ll_ret = ShellExecuteA ( Handle( This ), "open", inv_contract_details.is_contrtact_dir_path +'\'  + STRING(this.object.image_version[getrow()] ) + '_' +this.object.file_name[getrow()] , ls_Null, ls_Null, 4)
			end if
			//---------------------------- APPEON END ----------------------------   
		 choose case ll_ret
			CASE 0 
				parent.of_set_message( 'The operating system is out of memory or resources.')
         CASE 2 
				parent.of_set_message('The specified file was not found. ')
			CASE 3 
				parent.of_set_message('The specified path was not found. ' ) 
			CASE 11 
				parent.of_set_message('The .exe file is invalid (non-Win32? .exe or error in .exe image). ') 
			CASE 5 
				parent.of_set_message('The operating system denied access to the specified file. ' ) 
			CASE 27 
				parent.of_set_message('The file name association is incomplete or invalid. ')  
			CASE 30 
				parent.of_set_message('The DDE transaction could not be completed because other DDE transactions were being processed. ')  
			CASE 29 
				parent.of_set_message('The DDE transaction failed. ')  
			CASE 28 
				parent.of_set_message('The DDE transaction could not be completed because the request timed out. ')  
			CASE 32 
				parent.of_set_message('The specified dynamic-link library was not found. ')  
			CASE 31 
				messagebox('File Open Error','There is no application associated with the given file name extension. Contact System Administrator for an application that will open this file.' )  
				ShellExecuteA ( Handle( This ), "open", inv_contract_details.is_contrtact_dir_path , ls_Null, ls_Null, 4)
			CASE 8 
				parent.of_set_message('There was not enough memory to complete the operation. ') 
			CASE 26 
				parent.of_set_message('A sharing violation occurred')  
		end choose
	end if 
		
		
end choose 


return success





end event

event rowfocuschanged;call super::rowfocuschanged;/******************************************************************************************************************
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


if currentrow < 1 then return success


///if isnull(object.compute_1[currentrow]) then  m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.enabled = true

of_select_pages(currentrow)


i_parent_tab.function dynamic of_set_row(getrow())


if isnull(this.object.page_start[getrow()]) then
	    inv_contract_details.of_adjust_menu(parent,"")
else
		inv_contract_details.of_adjust_menu(parent,"")
end if 


if not f_validstr(this.object.file_name[currentrow]) then
	m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= true
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'enabled', true)
else 
	m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= true
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'enabled', false)
end if 
end event

event constructor;call super::constructor;
//this.of_setrowmanager( true)
//this.of_setrowselect( true)
//this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )



end event

event clicked;call super::clicked;
if row < 1 then return success

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-13 By: Rodger Wu
//$<reason> Fix a defect that current row is not set correctly under some circumstance.

This.setrow( row )

//---------------------------- APPEON END ----------------------------

of_select_pages(row)
end event

event pfc_addrow;call super::pfc_addrow;
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
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

iw_parent.event dynamic ue_save_contract_dir( )
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', false)


gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'enabled', true)

This.SelectRow(0, FALSE)
This.SelectRow(rowcount(), TRUE)
scrolltorow( rowcount())

i_parent_tab.function dynamic of_set_row(rowcount())


return success
end event

event pfc_validation;call super::pfc_validation;
long ll_i
accepttext( )


for ll_i = 1 to rowcount( )

	if not f_validstr(object.page_description[ll_i]) then
		messagebox('Missing Data', 'Please enter a decription.')
		setrow( ll_i)
		setcolumn( 'page_description')
		return failure
	end if
		
next


return success
end event

event retrieveend;call super::retrieveend;
long ll_i

i_parent_tab.function dynamic of_share_data(this)


for ll_i = 1 to this.rowcount()
	this.object.status[ll_i] = f_Set_record_status( this.object.image_id[ll_i] , this.object.image_version[ll_i] )
next

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.27.2006 By: LeiWei
//$<reason> Fix a defect.
This.ResetUpdate( )
//---------------------------- APPEON END ----------------------------

end event

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_count
long ll_ctx_id
long ll_i
integer res


for ll_i = 1 to rowcount( )
		if isnull(this.object.ctx_id[ll_i]) then 
				 ll_ctx_id  = inv_contract_details.of_get_ctx_id( )
				 this.object.ctx_id[ll_i] = ll_ctx_id
				 
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 09.26.2006 By: LeiWei
				//$<reason> Performance tuning
				/*
				 SELECT max(image_id)
				 into :ll_count
				 FROM ctx_images  ;
				 /*WHERE "dba"."ctx_images"."ctx_id" = :ll_ctx_id;    */
				*/
				
				IF Isnull(ll_count) OR ll_count = 0 THEN
					 SELECT max(image_id)
					 into :ll_count
					 FROM ctx_images  ;
				ELSE
					ll_count ++
				END IF
				
				//---------------------------- APPEON END ----------------------------
				 
				 if isnull(ll_count) then ll_count = 0
				 
				 ll_count =  ll_count + 1
				 
				 this.object.image_id[ll_i]  = ll_count 
						  
		end if

next

choose case m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.ToolbarItemText 
	case 'Browse'
		//Start Code Change ---- 01.25.2007 #V7 maha
		if is_doc_path = '' then
			res = messagebox("No file","There is no file selected.  Would you like to reselect a file?",question!,yesno!,1)
			if res = 1 then
				//code to select again
			else
				return failure
			end if
			
		else
			if not (fileexists(is_doc_path)) then
				messagebox("File Problem","Cannot find file " + is_doc_path)
				return failure
			end if
		end if
		//End Code Change---01.25.2006
		string ls_parse_array[]
		n_cst_string inv_cst_string
		inv_cst_string.of_parsetoarray( is_doc_path, '\', ls_parse_array)
		if upperbound(ls_parse_array) > 0 then 
			this.object.file_name[getrow()] = ls_parse_array[upperbound(ls_parse_array)]
		else
			return failure
	      end if 
end choose 

return success

end event

event buttonclicked;call super::buttonclicked;/******************************************************************************************************************
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

integer value
string ls_Null
SetNull(ls_Null)

choose case dwo.name
	case 'b_browse'
		of_browse( )

case 'b_open'
	    string ls_execute
		 ls_execute = gs_application_path +'\'+ string(object.file_name[row])
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-03
		//$<modify> 03.24.2006 By: Liang QingShi
		//$<reason> Performance tuning
		//$<modification> This original script opens a new page in the same IE, which is incorrect.
		//$<modification> Modify the script to open a new IE instead of open a new page in the same IE.
		/*
		value = ShellExecuteA ( Handle( This ), "open", ls_execute , ls_Null, ls_Null, 4)
		*/
		//value = ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_execute , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		value = ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_execute , ls_Null, 4)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		//---------------------------- APPEON END ----------------------------   		
		choose case value
			CASE 0 
				parent.of_set_message( 'The operating system is out of memory or resources.')
         CASE 2 
				parent.of_set_message('The specified file was not found. ' + ls_execute )
			CASE 3 
				parent.of_set_message('The specified path was not found. ' ) 
			CASE 11 
				parent.of_set_message('The .exe file is invalid (non-Win32? .exe or error in .exe image). ') 
			CASE 5 
				parent.of_set_message('The operating system denied access to the specified file. ' ) 
			CASE 27 
				parent.of_set_message('The file name association is incomplete or invalid. ')  
			CASE 30 
				parent.of_set_message('The DDE transaction could not be completed because other DDE transactions were being processed. ')  
			CASE 29 
				parent.of_set_message('The DDE transaction failed. ')  
			CASE 28 
				parent.of_set_message('The DDE transaction could not be completed because the request timed out. ')  
			CASE 32 
				parent.of_set_message('The specified dynamic-link library was not found. ')  
			CASE 31 
				 parent.of_set_message('There is no application associated with the given file name extension. This error will also be returned if you attempt to print a file that is not printable.' + ls_execute)  
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-05
				//$<modify> 03.24.2006 By: Liang QingShi
				//$<reason> Performance tuning
				//$<modification> This original script opens a new page in the same IE, which is incorrect.
				//$<modification> Modify the script to open a new IE instead of open a new page in the same IE.
				/*
				ShellExecuteA ( Handle( This ), "open", ls_execute , ls_Null, ls_Null, 4)
				*/
				//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_execute , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
				ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_execute, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
				//---------------------------- APPEON END ----------------------------   
			CASE 8 
				parent.of_set_message('There was not enough memory to complete the operation. ') 
			CASE 26 
				parent.of_set_message('A sharing violation occurred')  
		end choose
END CHOOSE


end event

event pfc_update;call super::pfc_update;
if this.getrow() < 1 then return 0

choose case m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.ToolbarItemText 
	case 'Browse'
			inv_contract_details.of_add_filetodb( is_doc_path , object.image_id[this.getrow()])
			is_doc_path = ''
	case 'Scan'
			inv_contract_details.of_add_filetodb( i_parent_tab.function dynamic of_get_image_name(), object.image_id[this.getrow()])
	case else
		
end choose 


   
	
return 0
end event

event itemchanged;call super::itemchanged;integer res

choose case dwo.name
	case 'media_type'
		inv_contract_details.of_adjust_menu(parent,"")
		if data = '2' then 
			of_browse( )	
			//Start Code Change ---- 01.25.2007 #V7 maha
			if is_doc_path = '' then
				res = messagebox("No file","There is no file selected.  Would you like to reselect a file?",question!,yesno!,1)
				if res = 1 then
					//code to select again
				else
					return failure
				end if
				
			else
				if not (fileexists(is_doc_path)) then
					messagebox("File Problem","Cannot find file " + is_doc_path)
					return failure
				end if
			end if
			//End Code Change---01.25.2006
			string ls_parse_array[]
			n_cst_string inv_cst_string
			inv_cst_string.of_parsetoarray( is_doc_path, '\', ls_parse_array)
			if upperbound(ls_parse_array) > 0 then 
				this.object.file_name[getrow()] = ls_parse_array[upperbound(ls_parse_array)]
			else
				return failure
			end if 
		end if
end choose
end event

event updateend;call super::updateend;

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)


ib_retrieved = false
end event

event pfc_predeleterow;call super::pfc_predeleterow;


if messagebox('Delete Row' , 'Are you sure you want to delete this row?',Question!,YesNo!,2) = 1 then 
	  return  CONTINUE_ACTION 
   else 
	  return PREVENT_ACTION
end if


end event

event pfc_postupdate;call super::pfc_postupdate;
long ll_i
for ll_i = 1 to this.rowcount()
	this.object.status[ll_i] = f_Set_record_status( this.object.image_id[ll_i] , this.object.image_version[ll_i] )
next

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Liang QingShi
//$<reason> Contract module modification
long ll_ctx_id,ll_rowcount,ll_rowcount1,ll_image_version,ll_image_id,ll_ctx_id1,ll_find
string ls_find
datastore lds_image_version
lds_image_version = create datastore
lds_image_version.dataobject = 'd_cntx_images_version'
lds_image_version.settransobject(sqlca)

ll_ctx_id = inv_contract_details.of_get_ctx_id( )
ll_rowcount1 = lds_image_version.retrieve(ll_ctx_id)

ll_rowcount = dw_1.rowcount()
for ll_i = 1 to ll_rowcount
	ll_image_id = dw_1.getitemnumber(ll_i,'image_id')
	ll_ctx_id1 = dw_1.getitemnumber(ll_i,'ctx_id')
	ll_image_version = dw_1.getitemnumber(ll_i,'image_version')
	
	ls_find = "ctx_images_image_id = " + string(ll_image_id) + " and ctx_images_ctx_id = " + string(ll_ctx_id1)
	ll_find = lds_image_version.find(ls_find,1,ll_rowcount1)
	if ll_find > 0 then
		lds_image_version.setitem(ll_find,'image_version',ll_image_version)
	end if
next
lds_image_version.update()
destroy lds_image_version

//---------------------------- APPEON END ----------------------------



//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: LeiWei
//$<reason> Fix a defect.
Parent.of_retrieve( )
//---------------------------- APPEON END ----------------------------

return success
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then 
	return failure
END IF 
// mskinner 05 april 2006 -- END

RETURN SUCCess
end event

event getfocus;call super::getfocus;SETCOLumn( 'page_description')

end event

event pfc_deleterow;call super::pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.26.2006 By: LeiWei
//$<reason> Fix a defect.
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', true)
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.08.2006 By: Liang QingShi
//$<reason> Fix a defect.

OF_ENABLE_SAVE( )
return success
//---------------------------- APPEON END ----------------------------

end event

