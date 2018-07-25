$PBExportHeader$w_master.srw
$PBExportComments$Extension Master Window class
forward
global type w_master from pfc_w_master
end type
end forward

global type w_master from pfc_w_master
string icon = "favicon-purple.ico"
end type
global w_master w_master

type prototypes
FUNCTION ulong SetCapture(ulong a) LIBRARY "user32.dll"
FUNCTION boolean ReleaseCapture() LIBRARY "user32.dll"
end prototypes

type variables

// mskinner 28 feb 2006 -- begin
n_ToolTip 	inv_ToolTip
string 		is_ColName
integer 		ii_dwID
// mskinner 28 feb 2006 -- end
end variables

forward prototypes
public subroutine of_register (u_tabpg a_po)
public subroutine of_register (u_tab a_po)
public function integer of_setcontrols (windowobject lwo_windowobject[])
end prototypes

public subroutine of_register (u_tabpg a_po);
long ll_i



if not isvalid(inv_resize) then return 

this.inv_resize.of_Register (a_po, inv_resize.scale  )

FOR LL_I =  1 TO UPPERBOUND(a_po.CONTrol)
   this.inv_resize.of_Register (a_po.CONTrol[LL_I]  , inv_resize.scale	 )
NEXT
end subroutine

public subroutine of_register (u_tab a_po);
 

long ll_i

if not isvalid(inv_resize) then return 

this.inv_resize.of_Register (a_po, inv_resize.scale  )

FOR LL_I =  1 TO UPPERBOUND(a_po.CONTrol)
   this.inv_resize.of_Register (a_po.CONTrol[LL_I]  , inv_resize.scale	 )
NEXT
end subroutine

public function integer of_setcontrols (windowobject lwo_windowobject[]);//Loop through the object's control array and do stuff...
//set the background color
//set button flatstyle = true

integer li_counter, li_dwtype, li_looper
windowobject lw_windowobject
checkbox lwo_checkbox
commandbutton lwo_commandbutton
picturebutton lwo_picturebutton
datawindow lwo_datawindow
datepicker lwo_
dropdownlistbox lwo_dropdownlistbox
graph lwo_graph
groupbox lwo_groupbox
hprogressbar lwo_hprogressbar
hscrollbar lwo_hscrollbar
htrackbar lwo_htrackbar
listbox lwo_listbox
listview lwo_listview
monthcalendar lwo_monthcalendar
multilineedit lwo_multilineedit
radiobutton lwo_radiobutton
singlelineedit lwo_singlelineedit
statictext lwo_statictext
tab lwo_tab
treeview lwo_treeview
userobject lwo_userobject
vprogressbar lwo_vprogressbar
vscrollbar lwo_vscrollbar
vtrackbar lwo_vtrackbar
u_dw lu_dw

/*According to Mike, The current custom color used are
V15
lighest blue  rgb(240,245,255 )    16774640 main color with white
lighest grey rgb(243,243,243 )   15987699 alternate row gray

yellow rgb(245,245,210) - 13825525  for required fields

others used minimally
pink rgb(245,210,225) - 14799605
green rgb(210,245,225) - 14808530
blue rgb(210,225,245) - 16114130
windowbacktround 16774640
*/


For li_counter = 1 to upperbound(lwo_windowobject[]) step 1
	choose case typeof(lwo_windowobject[li_counter])
		case checkbox!
			lwo_checkbox = lwo_windowobject[li_counter]
			lwo_checkbox.backcolor = 16774640
		case commandbutton!
			lwo_commandbutton = lwo_windowobject[li_counter]
			//lwo_commandbutton.flatstyle =  true
			lwo_commandbutton.textsize = -8
			lwo_commandbutton.weight = 400
			lwo_commandbutton.fontcharset = ansi!
			lwo_commandbutton.fontpitch = variable!
			lwo_commandbutton.fontfamily = swiss!
			lwo_commandbutton.facename = "Segoe UI"
			//lwo_commandbutton.text =of_strip_char("", lwo_commandbutton.text , "@REVERSE@")  //Start Code Change ----09.08.2016 #V152 maha - 
		case picturebutton!
			lwo_picturebutton = lwo_windowobject[li_counter]
			//lwo_picturebutton.flatstyle =  true
			lwo_picturebutton.textsize = -8
			lwo_picturebutton.weight = 400
			lwo_picturebutton.fontcharset = ansi!
			lwo_picturebutton.fontpitch = variable!
			lwo_picturebutton.fontfamily = swiss!
			lwo_picturebutton.facename = "Segoe UI"
			//lwo_picturebutton.text =of_strip_char("", lwo_picturebutton.text , "@REVERSE@") //Start Code Change ----09.08.2016 #V152 maha - 

		case datawindow! 
			lwo_datawindow = lwo_windowobject[li_counter]
//			if lwo_datawindow.dataobject <> 'd_nav_bar' then lwo_datawindow.modify("DataWindow.Color='16774640'")
			// Get the type of DW - either 0=NonPFC, 1=PFC, 2=PFC_Linked, -1=Error.
			
			li_dwtype = of_GetDWType(lwo_datawindow)
			If li_dwtype > 0 Then //we have a PFC datawindow
				lu_dw = lwo_datawindow
				lu_dw.of_setbase(True)
				if isvalid(lu_dw.inv_base) then

// RP					lu_dw.inv_base.of_Modify("background.color", "16774640", "text", "*", TRUE)
					lu_dw.inv_base.of_Modify("font.face", "Segoe UI", "text", "*", TRUE)
					lu_dw.inv_base.of_Modify("font.face", "Segoe UI", "column", "*", TRUE)
					
					//font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" 
					//background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" 
					//background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" 
					//background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" 
					//background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" 
					//tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" 
					//tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" 
					//tooltip.transparency="0" transparency="0" )
 					//lu_dw.inv_base.of_Modify("border", "5", "column", "*", TRUE)
				end if
			end if
			
			//lwo_datawindow.borderstyle = stylebox!
		case datepicker!
		case dropdownlistbox!
			lwo_dropdownlistbox = lwo_windowobject[li_counter]
			lwo_dropdownlistbox.backcolor = 16774640
			lwo_dropdownlistbox.facename = "Segoe UI"
		case graph!
		case groupbox!
			lwo_groupbox = lwo_windowobject[li_counter]
			lwo_groupbox.backcolor = 16774640
			lwo_groupbox.facename = "Segoe UI"
		case hprogressbar!
		case hscrollbar!
		case htrackbar!
		case listbox!
			lwo_listbox = lwo_windowobject[li_counter]
			lwo_listbox.backcolor = 16777215    //16774640  //Start Code Change ----02.23.2016 #V15 maha - changed to white
			lwo_listbox.facename = "Segoe UI"			
		case listview!
			lwo_listview = lwo_windowobject[li_counter]
			lwo_listview.backcolor = 16774640
			lwo_listview.facename = "Segoe UI"		
		case monthcalendar!
			lwo_monthcalendar = lwo_windowobject[li_counter]
			lwo_monthcalendar.backcolor = 16774640
			lwo_monthcalendar.facename = "Segoe UI"
		case multilineedit!
			lwo_multilineedit = lwo_windowobject[li_counter]
			lwo_multilineedit.backcolor = 16777215    //16774640  //Start Code Change ----02.23.2016 #V15 maha - changed to white
			lwo_multilineedit.facename = "Segoe UI"
		case radiobutton!
			lwo_radiobutton = lwo_windowobject[li_counter]
			lwo_radiobutton.backcolor = 16774640
			lwo_radiobutton.facename = "Segoe UI"			
			
		case singlelineedit!
			lwo_singlelineedit = lwo_windowobject[li_counter]
			lwo_singlelineedit.backcolor = 16777215    //16774640  //Start Code Change ----02.23.2016 #V15 maha - changed to white
			lwo_singlelineedit.facename = "Segoe UI"			
		case statictext!
			lwo_statictext = lwo_windowobject[li_counter]
// RP			lwo_statictext.backcolor = 16774640
			lwo_statictext.facename = "Segoe UI"				
		Case tab!
			//special case!  Call function recursively
			lwo_tab = lwo_windowobject[li_counter]
			lwo_tab.backcolor = 16774640
			lwo_tab.facename = "Segoe UI"
			for li_looper = 1 to upperbound(lwo_tab.control[]) step 1
				lwo_tab.control[li_looper].tabbackcolor = 16774640
				lwo_tab.control[li_looper].backcolor = 16774640
				//lwo_tab.control[li_looper].facename = "Segoe UI"	
			//	lwo_tab.control[li_looper].text = of_strip_char("", lwo_tab.control[li_looper].text , "@REVERSE@")    //Start Code Change ----09.08.2016 #V152 maha - 

			next
			
			this.of_setcontrols(lwo_tab.control[])
		case treeview!
			lwo_treeview = lwo_windowobject[li_counter]
			lwo_treeview.backcolor = 16774640
			lwo_treeview.facename = "Segoe UI"	
		case userobject!
			//special case!  Call function recursively
			lwo_userobject = lwo_windowobject[li_counter]
			lwo_userobject.backcolor = 16774640
			//lwo_userobject.facename = "Segoe UI"	
			this.of_setcontrols(lwo_userobject.control[])
			
		case vprogressbar!
		case vscrollbar!
		case vtrackbar!

			
		Case else
			//do nothing?
		end choose
		
next

return 1



end function

on w_master.create
call super::create
end on

on w_master.destroy
call super::destroy
end on

event activate;call super::activate;// MSKINNER 29 DEC 2005 --- BEGIN
// DEFECT 634
IF ISVALID(W_MDI) and This.ClassName() <> 'w_mdi' THEN  //add ClassName condition, by Appeon long.zhang 08.04.2017 (Bug id 5673 - IE Freezes When Trying to Search Providers)
w_mdi.of_menu_security( w_mdi.MenuName )
END IF 
// MSKINNER 29 DEC 2005 --- END

end event

event pfc_postopen;call super::pfc_postopen;// MSKINNER 29 DEC 2005 --- BEGIN
// DEFECT 634
IF ISVALID(W_MDI) THEN 
	w_mdi.of_menu_security( w_mdi.MenuName )
END IF 
// MSKINNER 29 DEC 2005 --- END

end event

event pfc_preopen;call super::pfc_preopen;
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
**  Created By	: Michael B. Skinner 28 Febuary 2006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i
///////////////////////////////////////////////////////////////
// set the inital values for the tool tip service
///////////////////////////////////////////////////////////////

inv_Tooltip.of_set_window_tip(this)

//call the mystic of_setcontrols()
of_setcontrols(control[])
end event

event resize;call super::resize;//////////////////////////////////////////////////////////////////////
// $<event>w_master::resize()
// $<arguments>
//		value	unsignedlong	sizetype 		
//		value	integer     	newwidth 		
//		value	integer     	newheight		
// $<returns> long
// $<description>
// $<description> Set w_dashboard as backgroup
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If This.WindowState = Minimized! Then
	If isvalid(w_dashboard) Then
		This.BringtoTop = True
		//w_dashboard.Post of_set_backgroup() - commented by alfee 05.12.2010. It will cause all other windows minimized
	End If
End If

end event

event open;call super::open;gnv_win_backcolor.of_ChangeWindowBackColor(this) //Add by Evan 11/25/2008
end event

