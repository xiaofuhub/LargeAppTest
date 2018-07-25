$PBExportHeader$u_tabpg_contract_master.sru
$PBExportComments$[intellicontract_tab] Master Tab page for the contract module
forward
global type u_tabpg_contract_master from u_tabpg
end type
type st_1 from u_st within u_tabpg_contract_master
end type
end forward

global type u_tabpg_contract_master from u_tabpg
integer width = 3099
integer height = 1652
long backcolor = 33551856
boolean ib_alwaysvalidate = true
event ue_selectionchanged ( )
event type long ue_selectionchanging ( )
event ue_new ( )
event ue_reset_ib_retrieve ( )
event ue_open_contact ( )
event ue_keydown pbm_keydown
event ue_set_security ( )
event type integer ue_post_doc_changed ( long al_old_doc_id,  long al_new_doc_id,  decimal adc_old_revision,  decimal adc_new_revision )
event type integer ue_doc_changed ( long al_old_doc_id,  long al_new_doc_id,  decimal adc_old_revision,  decimal adc_new_revision )
event ue_initinstancevar ( )
st_1 st_1
end type
global u_tabpg_contract_master u_tabpg_contract_master

type prototypes
Public Function Long Beep (Long dwFreq, Long dwDuration) Library "kernel32"
end prototypes

type variables

n_cst_contract inv_contract_details
n_cst_filesrvwin32 inv_filesrv 
//string is_mode
//
//CONSTANT STRING NEW  = 'NEW'
//CONSTANT STRING EDIT  = 'EDIT'
//CONSTANT STRING QUERY  = 'QUERY'



boolean ib_retrieved 






//string ls_table_name,ls_field_text[],ls_field_type[]
//long ll_rowcount,field_order[],ll_field_width[]
//string ls_column_name[],field_sql[]
////u_dw ldw
//string ls_Table
//long ll_table_id
//long ll_field_id
//
//long integers
//
//long ll_start, ll_used
//
//string is_docname,is_named
//long   ll_FileNum
//long   ll_return 
//blob   b_text_blob
//string ls_file_dump
//string is_file_names[]
//
//CONSTANT STRING NEW_LINE = '~r~n'	
////string ls_file_path
//n_cst_string       lnv_string
//
//integer li_FileNum
//

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.29.2007 By: Frank.Gui
//$<reason> : Used by Document Manager tabpage

protected:

long    il_doc_id
dec{1}  idc_revision
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_set_contract_details (ref n_cst_contract anv_contract_details)
public function integer of_retrieve ()
public function integer of_new ()
public subroutine of_set_message (string as_message)
public function integer of_create_sys_lisst ()
public function boolean of_check_read_only ()
public function long of_get_doc_id ()
public function decimal of_get_revision ()
public subroutine of_set_docrevision (long al_new_id, decimal adc_new_revision)
end prototypes

event ue_selectionchanged();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
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

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.09.2017
//<$>reason:Set w_mdi redraw to false by argument, For Contracts Module Slowness

/////////////////////////////////////////////////
// adjust the menu as needed
/////////////////////////////////////////////////
//w_mdi.SetReDraw (False)  //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX
//inv_contract_details.of_adjust_menu(this,'')
//w_mdi.SetReDraw (True)  //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX
inv_contract_details.of_adjust_menu(this,'', True) 

//------------------- APPEON END -------------------



end event

event type long ue_selectionchanging();
//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ue_selectionchanging
//
//	Returns:			1 = Error encountered, do not allow tabpage to change
//						0 = Allow tabpage to change
//
//	Description:	Validates the datawindows on this tabpage
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

if not inv_contract_details.of_get_tab_change( ) then return 1

li_rc = this.of_validation( )

If li_rc = failure Then
	Return 1
else 
	Return 0
end if 
		
		


end event

event ue_new();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

dragobject temp
int ll_i,i

ll_i = upperbound(this.control)
for i = ll_i to 1 step -1
	temp = this.control[i]
	
	choose case typeof(temp)
		case datawindow! 
			u_dw dw
			dw = temp
			
			if dw.getItemstatus( 1, 0, primary!) <> NEW! or dw.getItemstatus( 1, 0, primary!) <> NEWmodified!then
				if inv_contract_details.is_mode = inv_contract_details.new then
					dw.reset()
					dw.event pfc_insertrow( )
				end if
		   end if
			
			if dw.rowcount() < 1 then 
				dw.event pfc_insertrow( )
			end if
	

	end choose
next

	

end event

event ue_reset_ib_retrieve();

ib_retrieved = false
end event

event ue_set_security();integer          li_index, li_count 
windowobject     lwo_temp 
u_dw_contract       lst_temp 

//--------Begin Added by Alfee 09.30.2007---------------
//<$Reason>Add read only control to Contract module
//Get & set read only flag at tab page level
boolean lb_protect 
lb_protect = inv_contract_details.of_get_protect_tabpg()
//--------End Added -------------------------------------	

////////////////////////////////////////////////////////////
// enable/disable columns
////////////////////////////////////////////////////////////
li_count = UpperBound ( this.Control[] ) 
FOR li_index = 1 TO li_count 
     lwo_temp = this.Control[li_index] 
     CHOOSE CASE lwo_temp.TypeOf() 
          CASE datawindow! 
               lst_temp = lwo_temp 
					//----Begin Modified by Alfee 09.30.2007--------------
					//if inv_contract_details.of_get_protect_columns( ) then 
					if	lb_protect then
					//----End Modified -----------------------------------	
						   lst_temp.of_disable_columns( ) 
						 else
							lst_temp.of_enable_columns( )
						end if 
          CASE ELSE 
               //Nothing 
     END CHOOSE 
NEXT
end event

event ue_post_doc_changed;//////////////////////////////////////////////////////////////////////
// $<event>ue_post_doc_changed()
// $<arguments>
//		value	long   	al_old_doc_id   		
//		value	long   	al_new_doc_id   		
//		value	decimal	adc_old_revision		
//		value	decimal	adc_new_revision		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-08 by Frank.Gui
//////////////////////////////////////////////////////////////////////
return 1
end event

event type integer ue_doc_changed(long al_old_doc_id, long al_new_doc_id, decimal adc_old_revision, decimal adc_new_revision);//////////////////////////////////////////////////////////////////////
// $<event>ue_doc_changed()
// $<arguments>
//		value	long   	al_old_doc_id   	Old Document ID	
//		value	long   	al_new_doc_id   	New Document ID	
//		value	decimal	adc_old_revision	Old Document revision	
//		value	decimal	adc_new_revision	New Document Revision	
// $<returns> integer
// $<description>This event will be triggered by manul. You can write scripts to do something, 
//               such as retrieving audit data from DB.
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-08 by Frank.Gui
//////////////////////////////////////////////////////////////////////

this.of_set_docrevision(al_new_doc_id,adc_new_revision)

//POST
this.post event ue_post_doc_changed(al_old_doc_id,al_new_doc_id,adc_old_revision,adc_new_revision)

return 1

end event

event ue_initinstancevar();//////////////////////////////////////////////////////////////////////
// $<event>  ue_initinstancevar
// $<arguments> (None)
// $<returns>   (None)
// $<description> Use this event to initialize instance variables.
//                This event calls from ue_show_close event of w_contract window.
//////////////////////////////////////////////////////////////////////
// $<add> 11/28/2008 by Evan
//////////////////////////////////////////////////////////////////////

ib_retrieved = false
il_doc_id = 0
idc_revision = 0
end event

public function integer of_set_contract_details (ref n_cst_contract anv_contract_details);/******************************************************************************************************************
**  [PUBLIC]   : sets the userobject to the current tabpage
**==================================================================================================================
**  Purpose   	: Makes it to pass variables and to use functions
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



inv_contract_details = anv_contract_details



return 1
end function

public function integer of_retrieve ();





return success
end function

public function integer of_new ();

event ue_new( )
return success
end function

public subroutine of_set_message (string as_message);

if len(trim(as_message))  > 1 then
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 12.14.2006 By: Davis
//$<reason> Comment out beep.
//		Beep (1000, 100)
//---------------------------- APPEON END ----------------------------
//		Beep (6000, 100)
//		Beep (8000, 100)
		st_1.text = as_message
	else 
		st_1.text = ""
end if










end subroutine

public function integer of_create_sys_lisst ();







//ll_table_id++
//
//dragobject temp
//int ll_i,i
//
//ll_i = upperbound(this.control)
//for i = 1 to ll_i
//	temp = this.control[i]
//	choose case typeof(temp)
//		case DataWindow! 
//			u_dw ldw
//			ldw = temp
//			ls_table_name = this.text + "\" +     ldw.title
//
//			for ll_rowcount =  1 to long(ldw.Describe("DataWindow.Column.Count"))
//				if long(ldw.Describe("#" + string(ll_rowcount) + ".TabSequence")) = 0 then continue
//				if ldw.Describe( ldw.describe ("#" + string(ll_rowcount) + + ".name") + "_t" + ".Text" ) = '!' then continue
//				field_order[upperbound(field_order) + 1]    =  long(ldw.Describe("#" + string(ll_rowcount) + ".TabSequence"))
//				ls_column_name[upperbound(ls_column_name) + 1] =  string(ldw.Describe("#" + string(ll_rowcount) + ".dbName"))
//				field_order[upperbound(field_order) + 1]    =  long(ldw.Describe("#" + string(ll_rowcount) + ".TabSequence"))
//				ls_field_text[upperbound(ls_field_text) + 1]  =  ldw.Describe ( ldw.describe ("#" + string(ll_rowcount) + + ".name") + "_t" + ".Text" )
//				ls_field_type[upperbound(ls_field_type) + 1]   = upper(left( string(ldw.Describe("#" + string(ll_rowcount) + ".Type"))   ,1 ))
//				ll_field_width[upperbound(ll_field_width) + 1] =   long(ldw.Describe("#" + string(ll_rowcount) + ".Width"))
//				
//			next
//
//
//			//////////////////////////////////////////////////////////////
//			// create the table insert sql
//			//////////////////////////////////////////////////////////////
//			ls_Table = "DELETE FROM DBA.sys_tables WHERE (table_id = " + STRING(ll_table_id) + "');"
//			ls_Table = "INSERT INTO DBA.sys_tables(table_id,table_name) VALUES (" +string(ll_table_id) +",'"+ string(ls_table_name) + "');"
//
//			//////////////////////////////////////////////////////////////
//			// create the sys_field insert sql
//			//////////////////////////////////////////////////////////////
//
//				for ll_rowcount =  1 to upperbound(ls_column_name)
//					//ls_column_name[ll_rowcount] =  string(ldw.Describe("#" + string(ll_rowcount) + ".dbName"))
//					//field_order[ll_rowcount]    =  long(ldw.Describe("#" + string(ll_rowcount) + ".TabSequence"))
//					//ls_field_text[ll_rowcount]  = ldw.INV_base.OF_GETcolumndisplayname(ldw.Describe("#" + string(ll_rowcount) + ".Name"))
//					ll_field_id++
//					field_sql[upperbound(field_sql) + 1] = "if exists(select 1 from DBA.sys_fields where table_id= " + string(ll_table_id)  + ' and field_id = ' + string(ll_field_id)+ ')' &
//																		+ ' then delete from DBA.sys_fields where table_id= ' + string(ll_table_id) + ' and field_id = ' + string(ll_field_id) +' end if; ' 
//					
//					field_sql[upperbound(field_sql) + 1] = "INSERT INTO DBA.sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES ("+ string(ll_table_id) +&
//																																',' +string(ll_field_id) + ','+ &
//																																	  string(field_order[ll_rowcount]) + ','+ &
//																																	"'" + ls_column_name[ll_rowcount] + "'," + &
//																																	"'" + ls_field_type[ll_rowcount] + "',"  + &
//																																  string(ll_field_width[ll_rowcount]) +  &
//																																	",'" + string(ls_field_text[ll_rowcount] ) +"'" + ");"
//				
//				next
//				
//						end choose
//				next
//
//
//
//li_FileNum = FileOpen("C:\sql.sql",StreamMode!, Write!, LockWrite!, REPLACE!)
//	
//FileWrite ( li_FileNum, "string  ls_sql_statments []" + NEW_LINE)
//FileWrite ( li_FileNum, "long  ll_i" + NEW_LINE)
//
//for ll_i = 1 to upperbound(field_sql)
//	  FileWrite ( li_FileNum, 'ls_sql_statments[upperbound(ls_sql_statments) + 1] = "' + field_sql[ll_i]  + ' " '+ NEW_LINE)
//next
//
//
//FileWrite ( li_FileNum, "FOR ll_i = 1 TO upperbound(ls_sql_statments)" + NEW_LINE)
//FileWrite ( li_FileNum, "execute immediate :ls_sql_statments[LL_I] using sqlca;" + NEW_LINE)
//FileWrite ( li_FileNum, "IF len(sqlca.sqlerrtext) > 0 THEN " + NEW_LINE)
//FileWrite ( li_FileNum, "messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(ls_sql_statments[LL_I]) + new_line + 'Please contact software vendor.' )"  + NEW_LINE )
//FileWrite ( li_FileNum, "END IF" + NEW_LINE)
//FileWrite ( li_FileNum, "NEXT" + NEW_LINE)
//
//FileClose ( li_FileNum )
//
//string ls_Null
//SetNull(ls_Null)
//
//ShellExecuteA ( Handle( This ), "open", "C:\sql.sql", ls_Null, ls_Null, 1)
//
//

return 0
end function

public function boolean of_check_read_only ();//--------------Begin Modified by Alfee 09.30.2007----------------
//<$Reason>Get read only flag from it's parent tab page
Integer li_tabidx
u_tabpg_contract_master	lu_tabpg

IF IsValid(gw_contract) THEN
	li_tabidx = gw_contract.tab_contract_details.selectedtab
	IF li_tabidx > 0 THEN
		// get the current tab page index
		lu_tabpg = gw_contract.tab_contract_details.of_gettabpage(li_tabidx)
		IF lu_tabpg.inv_contract_details.of_get_protect_columns( ) THEN
			//of_set_message('Contract is presently read only. No changes can be made. ')
			RETURN TRUE
		END IF
	END IF
END IF
/*IF inv_contract_details.of_get_protect_columns( )  THEN	
			of_set_message('Contract is presently read only. No changes can be made. ')
			return true
END IF */
//---------------End Modified --------------------------------------

return false
end function

public function long of_get_doc_id ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_super.of_get_doc_id()
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-08 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return this.il_doc_id
end function

public function decimal of_get_revision ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_super.of_get_doc_id()
// $<returns> decimal
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-08 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return this.idc_revision
end function

public subroutine of_set_docrevision (long al_new_id, decimal adc_new_revision);//////////////////////////////////////////////////////////////////////
// $<function>of_set_docrevision()
// $<arguments>
//		value	long   	al_new_id       		
//		value	decimal	adc_new_revision		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-08 by Frank.Gui
//////////////////////////////////////////////////////////////////////


IF il_doc_id <> al_new_id or idc_revision<>adc_new_revision THEN
	//this.event ue_doc_changed(il_doc_id,al_new_id,idc_revision,adc_new_revision)
	this.il_doc_id = al_new_id
	this.idc_revision=adc_new_revision
END IF
end subroutine

on u_tabpg_contract_master.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on u_tabpg_contract_master.destroy
call super::destroy
destroy(this.st_1)
end on

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.22.2006 By: LeiWei
//$<reason> Performance tuning.
//$<modification> Add a condition to ensure that constructor will not be executed, since
//$<modification> the execution of inv_resize negatively affects the performance very much
this.of_getparentwindow( iw_parent)
i_parent_tab = this.GetParent( )


If gb_autoresize Then
	CALL super::constructor
	
	//$<add> 10.23.2006 By: Gary
	IF Isvalid(inv_resize) THEN
		
		IF Lower(this.getparent().classname()) = "tab_contract_details" THEN
			if This.ClassName() = "tabpage_search" then		//Added by Scofield on 2008-12-04
				This.inv_resize.of_SetOrigSize(3877,2016)
				This.inv_resize.Event pfc_resize(0, width, height)
				This.inv_resize.of_Resize(this.control[],handle(iw_parent))
			else
				
				This.inv_resize.of_SetOrigSize(3877,2024)
				iw_parent.post SetRedraw(False)	//Jervis 08.24.2010
				This.inv_resize.Post Event pfc_resize(0, width, height)
				This.inv_resize.Post of_Resize(this.control[],handle(iw_parent))
				iw_parent.post  SetRedraw(True)  //Jervis 08.24.2010
			end if
		END IF
	END IF
	//$<add> 10.23.2006 By: Gary
	
	//---------Begin Commented by (Appeon)Harry  03.10.2014 for V142 ISG-CLX--------
	//Begin - Added By Mark Lee 03/13/2013
	//resize custom tab - jervis 03.12.2011
	//if iw_parent.classname( ) = 'w_contract' and this.getparent().classname() = "tab_1"  then
		
	//	if  this.getparent( ).getparent( ).getparent().classname( ) = 'tabpage_details'  then
	//		if abs(width - 2757) > 20 and abs(height - 564) > 20 then
	//			this.inv_resize.of_setOrigsize(2757, 564)
	//			This.inv_resize.post Event pfc_resize(0, width, height)
	//			This.inv_resize.post of_Resize(this.control[],handle(iw_parent))
	//		end if
	//	end if
	//end if
	//End - Added By Mark Lee 03/13/2013
	//---------End Commented ------------------------------------------------------
End If
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 03.14.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Have the application create n_cst_contract only when it is invalid.
/*
inv_contract_details  = CREATE n_cst_contract
*/
If Not Isvalid(inv_contract_details) Then
	inv_contract_details  = CREATE n_cst_contract
End If
//---------------------------- APPEON END ----------------------------

//of_getparentwindow( iw_parent)

inv_filesrv  = CREATE n_cst_filesrvwin32 



return 0






end event

type st_1 from u_st within u_tabpg_contract_master
integer x = 37
integer y = 1312
integer width = 2889
integer height = 160
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = ""
alignment alignment = center!
end type

