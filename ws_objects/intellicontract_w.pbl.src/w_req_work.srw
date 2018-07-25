$PBExportHeader$w_req_work.srw
$PBExportComments$This window is used to manipulate the requirements
forward
global type w_req_work from w_sheet
end type
type st_1 from statictext within w_req_work
end type
type dw_1 from u_dw_contract within w_req_work
end type
type hsb_1 from hscrollbar within w_req_work
end type
type uo_1 from uo_req_image within w_req_work
end type
end forward

global type w_req_work from w_sheet
integer width = 3840
integer height = 2308
string menuname = "m_req"
long backcolor = 33551856
boolean center = true
event ue_print ( )
event ue_showannotationtoolpalette ( )
event ue_scan ( )
event ue_setthumbsize ( )
event ue_del_thumbs ( )
event ue_save ( )
event ue_delete_image_object ( )
event ue_delete_image_page ( )
event ue_image_cut ( )
event ue_image_copy ( )
event ue_image_paste ( )
event ue_burninannotations ( )
event ue_rotatepage ( long al_index )
event ue_rotate_all_pages ( integer al_index )
event ue_straighten_page ( )
event ue_draw_text_zone ( )
event ue_ocr ( )
event ue_ocr_all ( )
event ue_remove_all_ocr_zones ( )
event ue_add_blank_page ( integer al_page,  string as_gstrinsertappend )
event ue_annotationtoolselection ( string as_annotationtype )
event ue_redo ( )
event ue_undo ( )
event ue_show_anotations ( integer al_index )
event ue_pagedirection ( integer al_index )
event ue_hide_add_annotation_groups ( string as_group,  integer al_index )
st_1 st_1
dw_1 dw_1
hsb_1 hsb_1
uo_1 uo_1
end type
global w_req_work w_req_work

type prototypes
FUNCTION boolean SetWindowPos ( ulong hWnd, ulong hWinInsertAfter, int newx, int newy, int newwidth, int newheight, long flags ) LIBRARY "user32.dll"
Function long GetWindowLong (long hWindow, integer nIndex) Library "user32.dll" ALIAS FOR GetWindowLongA
Function long SetWindowLong (long hWindow, integer nIndex, long dwNewLong) Library "user32.dll" ALIAS FOR SetWindowLongA
FUNCTION int GetSystemMetrics(integer nIndex) LIBRARY "user32.dll"

end prototypes

type variables
CONSTANT int 	GWL_STYLE		= -16
CONSTANT int 	SBS_SIZEGRIP	= 16
CONSTANT int	SM_CYHSCROLL	= 3
CONSTANT int 	SM_CXHSCROLL	= 21
CONSTANT uint	SWP_NOSIZE			= 1
CONSTANT uint	SWP_NOMOVE			= 2
CONSTANT uint	SWP_NOZORDER		= 4
CONSTANT uint	SWP_FRAMECHANGED	= 32
CONSTANT STRING MYMARK = 'MYMARK'
CONSTANT STRING OTHER = 'OTHER'
u_tabpg_contract_requirements i_u_tabpg_contract_requirements

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-03 By: Zhang Lingping
//$<reason> w_contract conflicts with a global variable of the same name
//$<reason> renamed.

//window w_contract
w_contract iw_contract
str_pass istr_pass
//---------------------------- APPEON END ----------------------------



DataWindowChild page_description
end variables

event ue_print();

this.uo_1.event ue_print( )
end event

event ue_showannotationtoolpalette();
 this.uo_1.event ue_showannotationtoolpalette( )
end event

event ue_scan();

IF not FileExists( this.uo_1.ls_current_image_path)  THEN
	this.uo_1.event dynamic ue_scan(1 )
else
	openwithparm(w_contract_print,uo_1) 
end if


end event

event ue_setthumbsize();
this.uo_1.event ue_setthumbsize( )

end event

event ue_del_thumbs();




this.uo_1.event ue_del_thumbs( )
end event

event ue_save();//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-17 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.
String	ls_Rtn

ls_Rtn = f_ExaWriteRight(this.uo_1.ole_edit.object.Image)
if Len(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return
end if
//---------------------------- APPEON END ----------------------------

this.uo_1.ole_edit.object.save()

If this.uo_1.ole_edit.object.StatusCode <> 0 Then
	messagebox('ImgEdit error','Image not saved')
End If

end event

event ue_delete_image_object();

this.uo_1.event ue_delete_image_object()
end event

event ue_delete_image_page();uo_1.event ue_delete_image_page( )
end event

event ue_image_cut();

uo_1.event ue_image_cut( )
end event

event ue_image_copy();

uo_1.event ue_image_copy( )
end event

event ue_image_paste();

uo_1.event ue_image_paste( )
end event

event ue_burninannotations();



 uo_1.event UE_BurnInAnnotations()
end event

event ue_rotatepage(long al_index);
this.uo_1.event ue_rotatepage(al_index)
end event

event ue_rotate_all_pages(integer al_index);

uo_1.event ue_rotate_all_pages(al_index)
end event

event ue_straighten_page();

uo_1.event ue_straighten_page( )
end event

event ue_draw_text_zone();

uo_1.event ue_draw_text_zone( )
end event

event ue_ocr();
uo_1.event ue_ocr( )
end event

event ue_ocr_all();


uo_1.event ue_ocr_all( )
end event

event ue_remove_all_ocr_zones();

uo_1.event ue_remove_all_ocr_zones()
end event

event ue_add_blank_page(integer al_page, string as_gstrinsertappend);

UO_1.event ue_add_blank_page( al_page, as_gstrinsertappend)


end event

event ue_annotationtoolselection(string as_annotationtype);



uo_1.event ue_annotationtoolselection(as_annotationtype)

end event

event ue_redo();




uo_1.event ue_redo( )
end event

event ue_undo();


uo_1.event ue_undo( )
end event

event ue_show_anotations(integer al_index);


 uo_1.event ue_show_anotations(al_index)

end event

event ue_PageDirection(integer al_index);


uo_1.event ue_pagedirection(al_index)

end event

event ue_hide_add_annotation_groups(string as_group, integer al_index);

choose case al_index
	case 1 // hide
		uo_1.ole_edit.object.HideAnnotationGroup(as_group)
	case 2 // show
		uo_1.ole_edit.object.ShowAnnotationGroup(as_group)
end choose

uo_1.ole_edit.object.Refresh()
end event

on w_req_work.create
int iCurrent
call super::create
if this.MenuName = "m_req" then this.MenuID = create m_req
this.st_1=create st_1
this.dw_1=create dw_1
this.hsb_1=create hsb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.hsb_1
this.Control[iCurrent+4]=this.uo_1
end on

on w_req_work.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.hsb_1)
destroy(this.uo_1)
end on

event pfc_postopen;call super::pfc_postopen;/******************************************************************************************************************
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

str_pass lstr_pass 

lstr_pass = message.powerobjectparm

this.uo_1.inv_contract_details = lstr_pass.s_po[1]

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-03 By: Zhang Lingping
//$<reason> 'w_contract' conflicts with a global variable of the same name
//$<reason> It will be renamed with "iw_contract"

//w_contract = lstr_pass.w_parent_window
//
//if w_contract.tab_contract_details.tabpage_requirements.dw_req_det.sharedata(uo_1.dw_1) < 1 then 
//	messagebox('Share Data', 'The data share has failed')
//end if
istr_pass = lstr_pass
iw_contract = lstr_pass.w_parent_window
if iw_contract.tab_contract_details.tabpage_requirements.dw_req_det.sharedata(uo_1.dw_1) < 1 then 
	messagebox('Share Data', 'The data share has failed')
end if
//---------------------------- APPEON END ----------------------------










end event

event pfc_preopen;call super::pfc_preopen;/******************************************************************************************************************
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


THIS.Move(1,1)

LONG LL_I
string ls_scale

this.of_SetResize(TRUE)


this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )
ls_scale = this.inv_resize.scale

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
NEXT

str_pass lstr_pass 

lstr_pass = message.powerobjectparm

this.uo_1.inv_contract_details = lstr_pass.s_po[1]

w_contract = lstr_pass.w_parent_window

page_description.Retrieve(this.uo_1.inv_contract_details.of_get_ctx_id( ) )

// Set transaction object for main DW and retrieve
dw_1.insertrow( 0)






end event

event closequery;
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

long 		li_msg
String	ls_Rtn


If this.WindowState = Minimized! Then
	this.WindowState = Normal!
End If	

this.BringToTop = True

If  uo_1.ole_edit.object.ImageModified = True Then
	li_msg = of_MessageBox ("pfc_master_closequery_savechanges",gnv_app.iapp_object.DisplayName,"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
			Choose Case li_msg
				Case 1
					//--------------------------- APPEON BEGIN ---------------------------
					//$< Add  > 2008-07-17 By: Scofield
					//$<Reason> Verify if the directory has write right for the current user.
					
					ls_Rtn = f_ExaWriteRight(uo_1.ole_edit.object.Image)
					if Len(ls_Rtn) > 0 then
						MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
						Return 1
					end if
					//---------------------------- APPEON END ----------------------------
					uo_1.ole_edit.object.Save()
				Case 2
					// NO - Allow the window to be closed without saving changes
					ib_closestatus = False
					Return 0
				Case 3
					// CANCEL -  Prevent the window from closing
					Return 1
			End Choose

end if

// If  uo_1.ole_edit.object.ImageModified = True Then
//	if Messagebox('Save Changes', "Changes have been made to the image. Do you want to save changes.",Question!,YesNo!,1) = 1 then
//        
//	end if
//  End If
end event

event activate;call super::activate;

changemenu(m_req)


end event

event close;call super::close;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.19.2006 By: Liang QingShi
//$<reason> Fix a defect.
If appeongetclienttype() <> 'PB' Then
	istr_pass.s_u_dw.event pfc_retrieve()
end if
//---------------------------- APPEON END ----------------------------

end event

type st_1 from statictext within w_req_work
integer x = 23
integer y = 20
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select File:"
boolean focusrectangle = false
end type

type dw_1 from u_dw_contract within w_req_work
integer x = 357
integer y = 12
integer width = 2080
integer height = 92
integer taborder = 30
string dataobject = "d_cntx_images_list"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_retrieve_drop_downs = true
end type

event constructor;
// override !!!!!!!!!!!!!!!!
dw_1.GetChild('page_description', page_description)
page_description.SetTransObject(SQLCA)

end event

event itemchanged;call super::itemchanged;


choose case dwo.name 
	case 'page_description'
		
		parent.uo_1.inv_contract_details.of_save_contract_dir( )
		parent.uo_1.event ue_load_image(page_description.GetitemNumber(page_description.getrow(),'image_id'), &
												  page_description.GetItemString(page_description.getrow(),'file_name'), &
											     page_description.GetitemNumber(page_description.getrow(),'image_version'))
		
	case else 
end choose
end event

event sqlpreview;call super::sqlpreview;//messagebox(''  , sqlsyntax )
end event

type hsb_1 from hscrollbar within w_req_work
boolean visible = false
integer x = 3744
integer y = 2076
integer width = 73
integer height = 44
string pointer = "SizeNWSE!"
end type

event constructor;ulong ll_style

ll_style = GetWindowLong(handle(this), gwl_style)

IF ll_style <> 0 THEN
	IF SetWindowLong(handle(this), gwl_style, ll_style +  SBS_SIZEGRIP) <> 0 THEN
		width = (PixelsToUnits( GetSystemMetrics( SM_CXHSCROLL ) , XPixelsToUnits! ) )
		height = (PixelsToUnits( GetSystemMetrics( SM_CYHSCROLL ), YPixelsToUnits! ) )
		SetWindowPos ( handle(this), 0, 0, 0, 0, 0, SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_FRAMECHANGED )
END IF
end if 

end event

type uo_1 from uo_req_image within w_req_work
integer x = 14
integer y = 124
integer height = 1956
integer taborder = 30
boolean enabled = true
boolean border = true
end type

on uo_1.destroy
call uo_req_image::destroy
end on

