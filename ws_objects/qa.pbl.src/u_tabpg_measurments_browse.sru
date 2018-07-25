$PBExportHeader$u_tabpg_measurments_browse.sru
$PBExportComments$The Measurements serach tab
forward
global type u_tabpg_measurments_browse from u_tabpg
end type
type dw_1 from u_dw within u_tabpg_measurments_browse
end type
end forward

global type u_tabpg_measurments_browse from u_tabpg
integer width = 3557
integer height = 1652
string text = "Browse"
string picturename = "Find!"
dw_1 dw_1
end type
global u_tabpg_measurments_browse u_tabpg_measurments_browse

type prototypes
SUBROUTINE GetClientRect (ULONG hClntWnd, REF STR_CLIENT_RECT lpRect) LIBRARY "USER32.DLL" alias for "GetClientRect;Ansi" 
end prototypes

type variables


long il_facility_id


protected:

long il_header_id       // The primary key
long il_prac_id






end variables

forward prototypes
public function long of_get_header_id ()
public subroutine of_set_header_id ()
public subroutine of_set_prac_id (integer al_prac_id)
public function integer of_get_prac_id ()
public subroutine of_set_header_id (long al_header_id)
end prototypes

public function long of_get_header_id ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_get_header_id
//==================================================================================================================
//  Purpose   	: 
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


return il_header_id
end function

public subroutine of_set_header_id ();


if dw_1.rowcount( ) > 0 then
	il_header_id =  this.dw_1.object.pd_qa_hdr_id[dw_1.getrow()]
	iw_parent.dynamic of_setheader_id(il_header_id)
else
	setnull(il_header_id)
	iw_parent.dynamic of_setheader_id(il_header_id)
end if

end subroutine

public subroutine of_set_prac_id (integer al_prac_id);

il_prac_id = al_prac_id
end subroutine

public function integer of_get_prac_id ();

return il_prac_id
end function

public subroutine of_set_header_id (long al_header_id);

il_header_id = al_header_id


end subroutine

on u_tabpg_measurments_browse.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_measurments_browse.destroy
call super::destroy
destroy(this.dw_1)
end on

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : constructor
//==================================================================================================================
//  Purpose   	:
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


this.of_setresize( true)
end event

type dw_1 from u_dw within u_tabpg_measurments_browse
integer width = 3525
integer height = 1616
integer taborder = 10
string dataobject = "d_pd_profile_search"
boolean hscrollbar = true
end type

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : contructor dw_1::u_tabpage_measurements_brouse
//==================================================================================================================
//  Purpose   	: Set up needed services for the datawindow
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]  not used    
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ib_rmbmenu	= true

THIS.of_SetRowSelect(TRUE)
THIS.inv_rowselect.of_SetStyle(THIS.inv_rowselect.single )




end event

event pfc_retrieve;call super::pfc_retrieve;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT pfc_retrieve
//==================================================================================================================
//  Purpose   	: retrieve the datawindow
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	:     
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//debugbreak()

THIS.SETFOcus( )

RETURN THIS.RETRIEVE(il_prac_id, il_facility_id )


end event

event rowfocuschanged;call super::rowfocuschanged;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : FUCNCTION rowfocuschanged
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// set the header id
of_set_header_id()
// set the header_id 
iw_parent.dynamic of_set_hdr_id ( parent.of_get_header_id( ) )



end event

event doubleclicked;call super::doubleclicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]  EVENT  : 
//==================================================================================================================
//  Purpose   	: Triggger a function on the parent window dynamically
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
// make sure all is updated
////////////////////////////////////////////////////////////////////////
iw_parent.dynamic of_accepttext( true)
if iw_parent.function dynamic of_updatespending( ) > 0  then
	if messagebox('Updates Pending', 'Do you want to save changes?',question!,YesNo!) = 1 then
      if iw_parent.dynamic of_save()  < 0 then
			of_MessageBox ( '', 'Update Error', 'Update has failed', Exclamation!, ok!, 1)
			return 
		else
		end if
	end if
end if


TRY
	   iw_parent.DYNAMIC of_select_tab()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2005-11-11 By: Liang QingShi
		//$<reason> 

		//	il_facility_id =  this.object.facility_id[this.getrow()]
		//	il_header_id =  this.object.pd_qa_hdr_id[this.getrow()]
		
		if this.getrow() > 0 then
			il_facility_id =  this.object.facility_id[this.getrow()]
			il_header_id =  this.object.pd_qa_hdr_id[this.getrow()]
		end if
		//---------------------------- APPEON END ----------------------------
CATCH (RunTimeError rte)
      messagebox("Runtime Error",'Function of_select_tab() does not exist on the parent window!' + '~r~r' +  rte.getmessage()  )
END TRY
end event

event pfc_addrow;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]  EVENT  : 
//==================================================================================================================
//  Purpose   	: Triggger a function on the parent window dynamically
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// OVERRIDE

TRY
	   iw_parent.DYNAMIC of_new()
CATCH (RunTimeError rte)
      messagebox("Runtime Error",'Function of_new() does not exist on the parent window!' + '~r~r' +  rte.getmessage()  )
END TRY

return 1
end event

event pfc_deleterow;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]  EVENT  : 
//==================================================================================================================
//  Purpose   	: Triggger a function on the parent window dynamically
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//TRY
	   iw_parent.DYNAMIC OF_DELETE()
//CATCH (RunTimeError rte)
   //   messagebox("Runtime Error",'Function OF_DELETE () does not exist on the parent window!' + '~r~r' +  rte.getmessage()  )
//END TRY

RETURN 1
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;
//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
/*
// turn off insert, add, delete menu option
//am_DW.m_Table.m_AddRow.Enabled = False
am_DW.m_Table.m_Insert.Enabled = False
am_DW.m_Table.m_Delete.Enabled = False
*/
gnv_app.of_modify_menu_attr( am_DW.m_Table.m_Insert,'Enabled', False)
gnv_app.of_modify_menu_attr( am_DW.m_Table.m_Delete,'Enabled', False)
//---------End Modfiied ------------------------------------------------------
end event

event retrievestart;call super::retrievestart;//pd_qa_hdr_id


end event

event retrieveend;call super::retrieveend;


// set the header id
of_set_header_id()
// set the header_id 
iw_parent.dynamic of_set_hdr_id ( parent.of_get_header_id( ) )
end event

