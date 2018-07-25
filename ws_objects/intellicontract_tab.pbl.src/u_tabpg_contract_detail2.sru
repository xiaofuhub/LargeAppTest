$PBExportHeader$u_tabpg_contract_detail2.sru
$PBExportComments$[intellicontract_tab]  The contract locations Tab Page
forward
global type u_tabpg_contract_detail2 from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_contract_detail2
end type
end forward

global type u_tabpg_contract_detail2 from u_tabpg_contract_master
integer width = 3643
integer height = 1928
long backcolor = 33551856
string text = "Supporting Documents"
dw_1 dw_1
end type
global u_tabpg_contract_detail2 u_tabpg_contract_detail2

type variables

end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_browse ()
end prototypes

public function integer of_retrieve ();

dw_1.event pfc_retrieve( )
dw_1.setfocus( )
return success
end function

public function integer of_browse ();string ls_path
string docname, named, path
integer value
string ls_Null
SetNull(ls_Null)
	
	
	
	
	if len(string(dw_1.object.ctx_file_location_path[dw_1.getrow()]) ) > 0 then
			inv_filesrv.of_ChangeDirectory ((Mid ( string(dw_1.object.ctx_file_location_path[dw_1.getrow()]), 1 ,LastPos ( dw_1.object.ctx_file_location_path[dw_1.getrow()], '\') -1 )))
	end if
	IF GetFilesaveName("Select a file",docname, named, "All Files", + "All Files (*.*),*.*") = 1 THEN
		dw_1.object.ctx_file_location_path[dw_1.getrow()] = docname
	END IF
	gf_save_dir_path(docname) //Added by Ken.Guo on 2009-03-10
	//ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
	
return success
end function

on u_tabpg_contract_detail2.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_contract_detail2.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_keydown;call super::ue_keydown;

IF KeyDown(KeyControl!) and KeyDown(65) then
	dw_1.event ue_add( )

end if


IF KeyDown(KeyControl!) and KeyDown(65) then
	//dw_1.event ue_add( )

end if

      
end event

event constructor;call super::constructor;DW_1.SETFOcus( )
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_detail2
integer x = 78
integer y = 1704
integer width = 3182
integer height = 100
long backcolor = 33551856
boolean enabled = true
end type

type dw_1 from u_dw_contract within u_tabpg_contract_detail2
event ue_add ( )
string tag = "Document List"
integer width = 3621
integer height = 1856
integer taborder = 10
boolean titlebar = true
string title = "Document List"
string dataobject = "d_ctx_file_location"
end type

event ue_add();


dw_1.event pfc_addrow( )
parent.of_browse( )
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
		 //--------------------------- APPEON BEGIN ---------------------------
		 //$<ID> UM-01
		 //$<modify> 03.24.2006 By: Liang QingShi
		 //$<reason> Performance tuning
		 //$<modification> This original script opens a new page in the same IE, which is incorrect.
		 //$<modification> Modify the script to open a new IE instead of open a new page in the same IE.
		 /*
		 value = ShellExecuteA ( Handle( This ), "open", string(object.ctx_file_location_path[row]), ls_Null, ls_Null, 4)
		 */
		 //value = ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', string(object.ctx_file_location_path[row]), ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		 value = ShellExecuteA ( Handle( This ), "open",  of_getbrowserversion( ), string(object.ctx_file_location_path[row]), ls_Null, 4)   //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		 //---------------------------- APPEON END ----------------------------   		
		choose case value
			case 0 
				parent.of_set_message( 'The operating system is out of memory or resources.')
            
			CASE 2 
				 	parent.of_set_message('The specified file was not found. ')
			CASE 3 
					parent.of_set_message('The specified path was not found. ' ) 
			CASE 11 
					parent.of_set_message('The .exe file is invalid (non-Win32® .exe or error in .exe image). ') 
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
					parent.of_set_message('There is no application associated with the given file name extension. This error will also be returned if you attempt to print a file that is not printable.' )  
			CASE 8 
					parent.of_set_message('There was not enough memory to complete the operation. ') 
			CASE 26 
					parent.of_set_message('A sharing violation occurred')  
		end choose
END CHOOSE



end event

event pfc_preupdate;call super::pfc_preupdate;

long ll_i 

for ll_i = 1 to rowcount()
	
	if isnull(object.ctx_id[ll_i]) then
		object.ctx_id[ll_i] = inv_contract_details.of_get_ctx_id( )
	end if
next



return success
end event

event pfc_retrieve;call super::pfc_retrieve;
THIS.RETRIEVE(inv_contract_details.of_get_ctx_id( ))
return success
end event

event constructor;call super::constructor;
of_SetRowManager(TRUE)
inv_rowmanager.of_SetRestoreRow(TRUE)
inv_rowmanager.of_SetConfirmOnDelete ( true )
end event

event pfc_addrow;call super::pfc_addrow;




parent.of_browse( )
return success
end event

event ue_key;call super::ue_key;
IF  KeyDown(KeyControl!) and KeyDown(65) theN
   event ue_add( )
	RETURN
end if


IF  KeyDown(KeyControl!) and KeyDown(68) then
   dw_1.event pfc_deleterow( )
	RETURN
end if



end event

