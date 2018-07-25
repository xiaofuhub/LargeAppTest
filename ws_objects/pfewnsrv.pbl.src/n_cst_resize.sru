$PBExportHeader$n_cst_resize.sru
$PBExportComments$Extension Resize service
forward
global type n_cst_resize from pfc_n_cst_resize
end type
end forward

global type n_cst_resize from pfc_n_cst_resize
end type
global n_cst_resize n_cst_resize

type prototypes
SUBROUTINE GetClientRect (ULONG hClntWnd, REF STR_CLIENT_RECT lpRect) LIBRARY "USER32.DLL" alias for "GetClientRect;Ansi" 
end prototypes

type variables
protected:
boolean ib_setdwzoom = true

Long il_prezoom
end variables

forward prototypes
public function integer of_resize (windowobject adw_control_array[], long al_handle)
public subroutine of_setdwzoom (boolean ab_zoom)
public function integer of_setorigsize (windowobject awo_control, integer ai_x, integer ai_y, integer ai_width, integer ai_height)
end prototypes

public function integer of_resize (windowobject adw_control_array[], long al_handle);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfe_n_cst_resize::of_resize
//==================================================================================================================
//  Purpose   	: this function will zoom the datawindows in the control array
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

datawindowchild ldw_child
long li_height,li_width,li_zoom,ll_count,ll_i
string ls_column_name
string ls_desc2

object winobjecttype[]
datawindow ldw

str_client_rect lstr_client_rect  

If gb_contract_version Then  //(Appeon)Harry 03.18.2014 - V142 ISG-CLX
	If Not gb_autozoom Then Return 1 //added by gavins 20130107 //(Appeon)Harry 01.21.2014 - V142 ISG-CLX
End If

//Start Code By Jervis 11.08.2007
//Prevent set dw zoom
if not ib_SetDWZoom then return 0
//End Code By Jervis 11.08.2007

GetClientRect(al_handle,lstr_client_rect)

li_width = pixelstoUnits(lstr_client_rect.right,XPixelsToUnits!)

//li_zoom =  li_width / 2800 * 100

// start code change --- 11.23.2005 MSKINNER
li_zoom =  round(li_width / 3936 * 100,1) //4000->3936 By Jervis 11-21-2008
// start code change --- 11.23.2005 MSKINNER

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.07.2006 By: Davis
//$<reason> Fix a defect.
Long li_zoom2
li_height = pixelstoUnits(lstr_client_rect.bottom,YPixelsToUnits!)
li_zoom2 = round(li_height / 2152 * 100,1) //2200->2152 By Jervis 11-21-2008
IF li_zoom > li_zoom2 THEN li_zoom = li_zoom2
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.03.2008 By: Ken.Guo
//$<reason> Workaround for APB Bug. Trigger Resize event too many times.
if il_prezoom = li_zoom then 
	return 1
End If
il_prezoom = li_zoom
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10.23.2006 By: Gary
//$<reason> Fix a defect.
//if li_zoom < 100 then return 1
//if li_zoom < 100 then li_zoom = 100	//Jervis 11-21-2008
//---------------------------- APPEON END ----------------------------

FOR ll_count = 1 to UpperBound(adw_control_array[])
	
   if   TypeOf(adw_control_array[ll_count]) = datawindow! then
		   ldw = adw_control_array[ll_count]
			//---------Begin Modified by (Appeon)Toney 06.05.2013 for V141 ISG-CLX--------
			  /*
				IF LenA(string(ldw.dataobject)) > 1 then
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 04.19.2007 By: Jack 04.25.2007 By: alfee
				//$<reason> Fix a defect.
				/*
					ldw.object.datawindow.zoom = li_zoom
				*/
				If ldw.dataobject <> 'd_sp_contract_search' and ldw.dataobject <> 'd_agreement_template_browse' Then
					 ldw.object.datawindow.zoom = li_zoom
				End If	
			  */
			 IF len(string(ldw.Describe('datawindow.Type'))) > 1 then
				Choose Case ldw.dataobject 
					Case 'd_ctx_letter_status','d_dm_doc_ai_graph','d_sp_contract_search','d_agreement_template_browse'
					Case Else
						If ldw.triggerevent('ue_isudw') = 1 Then //Only u_dw can set zoom
							ldw.dynamic function of_setzoomtriggered(true)
							ldw.object.datawindow.zoom = li_zoom
							ldw.dynamic function of_setzoomtriggered(false)
						End If
				End Choose
			//---------End Modfiied ------------------------------------------------------------------

			
				
				//---------------------------- APPEON END ----------------------------
				// loop through the columns and see if it a DDDW and zoom it as well
				 for ll_i = 1 to long(ldw.Object.DataWindow.Column.Count)
					ls_column_name = "#" + string(ll_i) + ".name"
					ls_desc2 = ldw.Describe("#" + string(ll_i) + ".name") + ".Edit.Style"
					
					if ldw.Describe(ls_desc2) = 'dddw' then
						ldw.GetChild( ldw.Describe(ls_column_name), ldw_child )
						ldw_child.Modify('datawindow.zoom=' + string(li_zoom))
					end if 
				 next		 
			 
			 end if
			
	end if 
NEXT

return 1



end function

public subroutine of_setdwzoom (boolean ab_zoom);ib_setdwzoom = ab_zoom
end subroutine

public function integer of_setorigsize (windowobject awo_control, integer ai_x, integer ai_y, integer ai_width, integer ai_height);//
////////////////////////////////////////////////////////////////////////////////
////	Protected Function:		of_SetOrigSize
////	Arguments:					awo_control    
////									ai_x				the orig x 
////									ai_y				the orig y
////									ai_newwidth		The new width of the parent object.
////									ai_newheight	The new height of the parent object.
////	Returns:  					integer
////									1 if it succeeds and -1 if an error occurs.
////	Description:  				Initializes the Resize object 
////////////////////////////////////////////////////////////////////////////////
integer			li_upperbound
integer			li_cnt
string ls_name

//Check parameters
If IsNull(awo_control) or Not IsValid(awo_control) or &
	IsNull(ai_x) or ai_x<0 or &
	IsNull(ai_y) or ai_y<0 or &
	IsNull(ai_width) or ai_width<0 or & 
	IsNull(ai_height) or ai_height<0 Then
	Return -1
End If

ls_name = awo_control.classname()

//Loop trough all controls
li_upperbound = UpperBound (inv_registered[])
For li_cnt = 1 to li_upperbound
	if ls_name = inv_registered[li_cnt].s_classname then
		inv_registered[li_cnt].r_x = ai_x
		inv_registered[li_cnt].r_y = ai_y
		inv_registered[li_cnt].r_width = ai_width
		inv_registered[li_cnt].r_height = ai_height
		exit
	end if
next
return 1


end function

on n_cst_resize.create
call super::create
end on

on n_cst_resize.destroy
call super::destroy
end on

