$PBExportHeader$w_agreement_template_add_clause.srw
forward
global type w_agreement_template_add_clause from w_popup
end type
type ole_1 from u_email_edit within w_agreement_template_add_clause
end type
type cb_fresize from commandbutton within w_agreement_template_add_clause
end type
type st_hspitbar1 from u_st_splitbar within w_agreement_template_add_clause
end type
type dw_formula from u_dw_ctx_find within w_agreement_template_add_clause
end type
type st_vsplitbar from u_st_splitbar within w_agreement_template_add_clause
end type
type cb_rules from commandbutton within w_agreement_template_add_clause
end type
type cbx_preview from checkbox within w_agreement_template_add_clause
end type
type tab_1 from u_tab_agreement_template_clause within w_agreement_template_add_clause
end type
type tab_1 from u_tab_agreement_template_clause within w_agreement_template_add_clause
end type
type cb_move_down from commandbutton within w_agreement_template_add_clause
end type
type cb_move_up from commandbutton within w_agreement_template_add_clause
end type
type cb_move_left from commandbutton within w_agreement_template_add_clause
end type
type cb_move_right from commandbutton within w_agreement_template_add_clause
end type
type gb_1 from groupbox within w_agreement_template_add_clause
end type
type gb_2 from groupbox within w_agreement_template_add_clause
end type
type cb_cancel from commandbutton within w_agreement_template_add_clause
end type
type dw_selected from u_dw within w_agreement_template_add_clause
end type
type gb_3 from groupbox within w_agreement_template_add_clause
end type
type cb_add from commandbutton within w_agreement_template_add_clause
end type
type cb_resize from commandbutton within w_agreement_template_add_clause
end type
end forward

global type w_agreement_template_add_clause from w_popup
integer width = 4425
integer height = 2856
string title = "Add Clause"
boolean resizable = false
long backcolor = 33551856
boolean center = true
event ue_inidw ( )
event pfc_cst_selection_changed ( )
event pfc_cst_move_right ( long al_row )
event pfc_cst_move_left ( )
event pfc_cst_move_up ( )
event pfc_cst_move_down ( )
event pfc_cst_rowfocuschanged ( )
event ue_selectrow ( long as_currentrow )
ole_1 ole_1
cb_fresize cb_fresize
st_hspitbar1 st_hspitbar1
dw_formula dw_formula
st_vsplitbar st_vsplitbar
cb_rules cb_rules
cbx_preview cbx_preview
tab_1 tab_1
cb_move_down cb_move_down
cb_move_up cb_move_up
cb_move_left cb_move_left
cb_move_right cb_move_right
gb_1 gb_1
gb_2 gb_2
cb_cancel cb_cancel
dw_selected dw_selected
gb_3 gb_3
cb_add cb_add
cb_resize cb_resize
end type
global w_agreement_template_add_clause w_agreement_template_add_clause

type variables
long il_template_id
long il_export_id //alfee 04.19.2007
long il_clause_id
integer ii_folder_id
string is_clause_name
string is_agreement_path 
string is_current_file //current opened clause file
string is_template_filename 

datetime idt_modify_date

//oleobject iole_word

long ix,iy,iw,ih //coordinate for ole control
boolean ib_refresh = true //indicator of display current clause file
boolean ib_overlay_picture = true //indicator of treeview item
boolean ib_mouse_ldown = false //for dw_selected

DataStore ids_infomsg
DataStore ids_clause_rulecnt //11.12.2007

Boolean	ib_Minimized = false		//Add by Scofield 2007-05-11
Boolean ib_newrules = false //11.12.2007

n_cst_clause inv_clause //Added By Ken.Guo 2010-01-18.
end variables

forward prototypes
public function boolean of_fileopened (string as_file)
public function integer of_get_clause_file (long al_clauseid, datetime adt_lastupdate)
public function integer of_displayfile (string as_file)
public function integer of_get_clause_file (long al_clauseid[], datetime adt_lastupdate[])
public function integer of_add_clause_file ()
public function integer of_set_selected_clauses ()
public function integer of_display_properties ()
public subroutine of_open ()
public function integer of_resize (boolean ab_flag)
public subroutine of_drop_clause_list (integer ai_current_row, integer ai_target_row)
public function integer of_store_clause_rulecnt ()
public subroutine of_refreshclauserules ()
public subroutine of_reszieclauseformula (boolean ab_zoom)
public function integer wf_set_visible (boolean abn_arg)
end prototypes

event ue_inidw();//////////////////////////////////////////////////////////////////////
// $<event>ue_inidw of w_agreement_template_add_clause()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>initialize datawindows
//////////////////////////////////////////////////////////////////////
// $<add> 11.22.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
dw_selected.setredraw(false)
ib_refresh = false //stop to refresh the document display

gnv_appeondb.of_startqueue() //for web performance tuning
//---------Appeon Begin by alfee 08.03.2007-----------------------
//<$Reason>User filter function instead of it
//Modify by jervis - 02.09.2010
//tab_1.tabpage_1.ds_clause.retrieve(w_agreement_template_painter.il_clause_approved)
tab_1.tabpage_1.ds_clause.retrieve()
tab_1.tabpage_1.inv_clause.of_retrieve_attribute_value( ) //added by gavins 20120723
//tab_1.tabpage_1.ds_clause.retrieve(w_agreement_template_painter.il_clause_approved, il_export_id)
//---------Appeon End -------------------------------------------
tab_1.tabpage_1.ds_folder.retrieve()
tab_1.tabpage_1.ds_rely.retrieve()
tab_1.tabpage_1.ds_category_unauthorized.retrieve(gs_user_id) //added by alfee 07.26.2007

//Modify by jervis 02.09.2010
//dw_selected.retrieve(il_template_id,w_agreement_template_painter.il_clause_approved)
dw_selected.retrieve(il_template_id)

gnv_appeondb.of_commitqueue()//for web performance tuning

ib_refresh = true //restore to refresh the document display
dw_selected.setredraw(true)

//Store clauses' rules - 11.12.2007
of_store_clause_rulecnt()
end event

event pfc_cst_selection_changed();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_selection_changedw_agreement_template_add_clause()
// $<arguments>
//		value	integer		
// $<returns> 
// $<description>locate in selected clause while selection changed in clause 
// $<description>treeview, update properties' display and preview the clause
//////////////////////////////////////////////////////////////////////
// $<add> 11.22.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_cnt,ll_row,ll_current
string ls_filename
decimal{1} ldec_revision //Added By Ken.Guo 2010-01-18.

dw_Formula.Reset()

ll_cnt = dw_selected.rowcount()

setpointer(HourGlass!)

if not isnull(il_clause_id )  then
	if ll_cnt > 0 then
		ll_row = dw_selected.find("ctx_acp_clause_id = " + string(il_clause_id),1,ll_cnt)
		//locate in selected clause		
		if ll_row >0 and dw_selected.getrow() <> ll_row then 
			dw_selected.setrow(ll_row)
			dw_selected.scrolltorow(ll_row)	
		else
			dw_selected.selectrow(dw_selected.getrow(),false)
		end if
	end if

	//display properties 
	of_display_properties()
	
	if not cbx_preview.checked then return
	
	//preview the clause
	//ls_filename = is_agreement_path + "clause_" + string(il_clause_id) + ".doc"
	ldec_revision = inv_clause.of_get_revision(il_clause_id)
	ls_filename = inv_clause.of_generate_name(il_clause_id,ldec_revision)
	
	//Check whether this file is already opened
	if of_fileopened(ls_filename) then return
	
	openwithparm( w_appeon_gifofwait, "Opening selected document..." )
	
	//Get or Generate local clause file 
	//of_get_clause_file(il_clause_id,idt_modify_date)	//Modified By Ken.Guo 2010-01-18
	inv_clause.of_download_file( il_clause_id, ldec_revision,ls_filename)
	
	//Open the file in clause preview
	of_displayfile(ls_filename)

	if isvalid( w_appeon_gifofwait) then close(w_appeon_gifofwait)	
end if
end event

event pfc_cst_move_right(long al_row);long ll_find,ll_cnt,ll_row,i, j
long ll_clause_id
integer li_rtn, li_mark
Long ll_clauseid[]

if not isnull(il_clause_id) then 
	//current selected is a clause
	ll_cnt = dw_selected.rowcount()
	ll_find = dw_selected.find("ctx_acp_clause_id ="+string(il_clause_id),1,ll_cnt)
	if ll_find > 0 then 
		//if already selected, select this clause
		dw_selected.setrow(ll_find)
		dw_selected.scrolltorow(ll_find)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.22.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	else 
	*/
	elseif il_clause_id > 0 then	
	//---------------------------- APPEON END ----------------------------
		//if not selected yet,store it to ds_clause_included
		tab_1.tabpage_1.ds_clause_included.reset()
		ll_row = tab_1.tabpage_1.ds_clause_included.insertrow(0)
		tab_1.tabpage_1.ds_clause_included.setitem(ll_row,"ctx_acp_clause_id",il_clause_id)
		tab_1.tabpage_1.ds_clause_included.setitem(ll_row,"clause_name",is_clause_name)	
		tab_1.tabpage_1.ds_clause_included.setitem(ll_row,"modify_date",idt_modify_date)
		
		//Added By Ken.Guo 2011-05-03.
		//tab_1.tabpage_1.ds_clause_included.setitem(ll_row,"revision", Dec(gnv_data.of_getitem( 'clause', 'revision', 'ctx_acp_clause_id = ' + String(il_clause_id)) ))
		
	end if
elseif not isnull(ii_folder_id) then 
	//current selected is a folder
	tab_1.tabpage_1.ds_clause_included.reset()
	//get all clauses under the folder into ds_clause_included 
	tab_1.tabpage_1.of_find_clause(ii_folder_id)	
end if

//find all relies clauses and merge into ds_clause_included
if tab_1.tabpage_1.of_find_relied() = -1 then
	//if any one clause not approved, pop up a messagebox for warning.
	li_rtn = messagebox("Add Clause","As some relied clauses are not approved, one or more selected clauses will not be added!" ,Exclamation!,OKCancel!,1)
	if li_rtn = 2 then return //Cancel		
end if

ib_refresh = false //don't refresh the dispaly of clause files

//Add clauses to dw_selected, and discard duplicated clauses
dw_selected.setredraw(false)
j = 0
ll_cnt = tab_1.tabpage_1.ds_clause_included.rowcount()
for i = 1 to ll_cnt
	//ignore clause not approved
   if tab_1.tabpage_1.ds_clause_included.object.approval_mark[i] = 0 then continue

	//ignore the duplicated clause
	ll_clause_id = tab_1.tabpage_1.ds_clause_included.object.ctx_acp_clause_id[i]
	ll_find = dw_selected.find("ctx_acp_clause_id ="+string(ll_clause_id),1,dw_selected.rowcount())
	if ll_find > 0 then continue		
	
	//add the clause to dw_selected
	If al_row > 0 Then
		ll_row = dw_selected.insertrow(al_row)		
		al_row++
	Else
		ll_row = dw_selected.insertrow(0)
	End If

	dw_selected.object.ctx_acp_clause_id[ll_row] = tab_1.tabpage_1.ds_clause_included.object.ctx_acp_clause_id[i]
	dw_selected.object.clause_name[ll_row] = tab_1.tabpage_1.ds_clause_included.object.clause_name[i]
	dw_selected.object.modify_date[ll_row] = tab_1.tabpage_1.ds_clause_included.object.modify_date[i]	
	
//	dw_selected.setitem(ll_row,"revision", Dec(gnv_data.of_getitem( 'clause', 'revision', 'ctx_acp_clause_id = ' + String(ll_clause_id)) )) //Added By Ken.Guo 2011-05-03.
	
	dw_selected.SetRow(ll_row)	
	//Set dynamic add clause rules' mark - Alfee 11.12.2007
	IF ids_clause_rulecnt.RowCount() > 0 THEN
		ll_find = ids_clause_rulecnt.Find("ctx_acp_clause_id = " + String(ll_clause_id), 1, ids_clause_rulecnt.RowCount())
		IF ll_find > 0 THEN 	dw_selected.object.sum_rules[ll_row] = ids_clause_rulecnt.object.sum_rules[ll_find]
	END IF
	
	//for dispaly clauses' information messagebox window	
	j ++
	ll_clauseid[j] = ll_clause_id
	
	//Set pictureindex for item moved in treeview
	tab_1.tabpage_1.of_set_treeview(ll_clause_id,true)	
next

//ll_cnt = dw_selected.rowcount()
ll_cnt = dw_selected.getrow()
if ll_cnt > 0 then 
	dw_selected.setrow(ll_cnt)
	dw_selected.scrolltorow(ll_cnt)
end if

dw_selected.setredraw(true)

ib_refresh = true //restore to refresh the dispaly of clause files

this.event pfc_cst_rowfocuschanged()

//Display clauses' information messages
IF j > 0 THEN 
	IF ids_infomsg.Retrieve(ll_clauseid) > 0 THEN
		OpenwithParm(w_clause_infomsg_disp, ids_infomsg)
	END IF
END IF
end event

event pfc_cst_move_left();long ll_find,ll_cnt,ll_row, i
long ll_selected_clause,ll_clause_id
integer li_rtn
boolean lb_found = false

ll_row = dw_selected.getrow()
if ll_row < 1 then return 

ll_selected_clause = dw_selected.object.ctx_acp_clause_id[ll_row]

//find cluases which rely on the current clause
tab_1.tabpage_1.ds_clause_included.reset()
tab_1.tabpage_1.of_find_rely(ll_selected_clause)

ib_refresh = false //don't refresh the dispaly of clause files

//remove clauses from dw_selected
ll_cnt = tab_1.tabpage_1.ds_clause_included.rowcount()
dw_selected.setredraw(false)
for i = 1 to ll_cnt
	ll_clause_id = tab_1.tabpage_1.ds_clause_included.object.ctx_acp_clause_id[i]
	if dw_selected.rowcount() < 1 then exit 
	ll_find = dw_selected.find("ctx_acp_clause_id = "+ string(ll_clause_id),1,dw_selected.rowcount())
	if ll_find > 0 then 	
		if not lb_found then  //the first clause found
			lb_found = true		
			if messagebox("Add Clause","The relied clause(s) will be removed too, continue?" &
					,Question!,YesNo!,1) = 2 then //cancel
				dw_selected.setredraw(true)
				ib_refresh = true //restore to refresh the dispaly of clause files
				return 
			end if					
		end if
		dw_selected.deleterow(ll_find)
		//Set pictureindex for item moved in treeview
		tab_1.tabpage_1.of_set_treeview(ll_clause_id,false)
	end if
next

if dw_selected.rowcount() > 0 then
	ll_find = dw_selected.find("ctx_acp_clause_id = "+string(ll_selected_clause),1,dw_selected.rowcount())
	if ll_find >0 then 
		//Added By Mark Lee 07/09/12 add info for user
		if messagebox("Delete Clause","Are you sure want to delete this clause from the template?" &
					,Question!,YesNo!,1) = 2 then //cancel
				dw_selected.setredraw(true)
				ib_refresh = true //restore to refresh the dispaly of clause files
				return 
		End If
		dw_selected.deleterow(ll_find)
		//Set pictureindex for item moved in treeview
		tab_1.tabpage_1.of_set_treeview(ll_selected_clause,false)
	end if
end if

dw_selected.setredraw(true)

ib_refresh = true //restore to refresh the dispaly of clause files

this.event pfc_cst_rowfocuschanged()



end event

event pfc_cst_move_up();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_move_upw_agreement_template_add_clause()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Move up the selected clause
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_row
long ll_clause_id
long ll_sum_rules //11.12.2007
string ls_clause_name
datetime ldt_modify_date

ll_row = dw_selected.getrow()

if ll_row > 1 then
	ll_clause_id = dw_selected.object.ctx_acp_clause_id[ll_row]
	ls_clause_name = dw_selected.object.clause_name[ll_row]
	ldt_modify_date = dw_selected.object.modify_date[ll_row]
	ll_sum_rules = dw_selected.object.sum_rules[ll_row] //11.12.2007
	
	dw_selected.object.ctx_acp_clause_id[ll_row] = dw_selected.object.ctx_acp_clause_id[ll_row -1]
	dw_selected.object.clause_name[ll_row] = dw_selected.object.clause_name[ll_row -1]
	dw_selected.object.modify_date[ll_row] = dw_selected.object.modify_date[ll_row -1]	
	dw_selected.object.sum_rules[ll_row] = dw_selected.object.sum_rules[ll_row -1]	 //11.12.2007
	
	dw_selected.object.ctx_acp_clause_id[ll_row -1] = ll_clause_id
	dw_selected.object.clause_name[ll_row -1] = ls_clause_name
	dw_selected.object.modify_date[ll_row -1] = ldt_modify_date
	dw_selected.object.sum_rules[ll_row -1] = ll_sum_rules //11.12.2007

	dw_selected.accepttext() 
	dw_selected.setrow(ll_row -1)
	dw_selected.scrolltorow(ll_row -1)
end if

end event

event pfc_cst_move_down();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_move_downw_agreement_template_add_clause()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>move down the selected clause 
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_cnt,ll_row
long ll_clause_id
long ll_sum_rules //11.12.2007

string ls_clause_name
datetime ldt_modify_date

ll_row = dw_selected.getrow()
ll_cnt = dw_selected.rowcount()


if ll_row < ll_cnt then
	ll_clause_id = dw_selected.object.ctx_acp_clause_id[ll_row]
	ls_clause_name = dw_selected.object.clause_name[ll_row]
	ldt_modify_date = dw_selected.object.modify_date[ll_row]
	ll_sum_rules = dw_selected.object.sum_rules[ll_row] //11.12.2007
	
	dw_selected.object.ctx_acp_clause_id[ll_row] = dw_selected.object.ctx_acp_clause_id[ll_row +1]
	dw_selected.object.clause_name[ll_row] = dw_selected.object.clause_name[ll_row +1]
	dw_selected.object.modify_date[ll_row] = dw_selected.object.modify_date[ll_row +1]	
	dw_selected.object.sum_rules[ll_row] = dw_selected.object.sum_rules[ll_row +1]	 //11.12.2007	
	
	dw_selected.object.ctx_acp_clause_id[ll_row +1] = ll_clause_id
	dw_selected.object.clause_name[ll_row +1] = ls_clause_name
	dw_selected.object.modify_date[ll_row +1] = ldt_modify_date
	dw_selected.object.sum_rules[ll_row +1] = ll_sum_rules //11.12.2007	

	dw_selected.accepttext() 
	dw_selected.setrow(ll_row +1)
	dw_selected.scrolltorow(ll_row +1)
end if
	



end event

event pfc_cst_rowfocuschanged();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_rowfocuschange() of dw_agreement_template_add_clause
// $<arguments>
//		None		
// $<returns> (None)
// $<description>handling for rowfocuschanged of dw_selected 
//////////////////////////////////////////////////////////////////////
// $<add> 11.23.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

string ls_filename
long currentrow 

currentrow = dw_selected.getrow()
if currentrow < 1 then return

//set instance variables
il_clause_id = dw_selected.getitemnumber(currentrow,"ctx_acp_clause_id")
is_clause_name = dw_selected.getitemstring(currentrow,"clause_name")
idt_modify_date = dw_selected.getitemdatetime(currentrow,"modify_date")

if isnull(il_clause_id) then return 

//locate the clause in treeview, display properties and preview it if not found
if tab_1.tabpage_1.of_locate_clause(il_clause_id) <> 1 then
	//display properties
	of_display_properties()
	
	if cbx_preview.checked then
	
		//Check whether this file is already opened
		//ls_filename = is_agreement_path + "clause_" + string(il_clause_id) + ".doc"
		ls_filename = inv_clause.of_generate_name(il_clause_id)
		
		if of_fileopened(ls_filename) then return

		openwithparm( w_appeon_gifofwait, "Opening selected document..." )

		//Get or Generate local clause file 
		of_get_clause_file(il_clause_id,idt_modify_date)

		//Open the file in clause preview
		of_displayfile(ls_filename)

		if isvalid( w_appeon_gifofwait) then close(w_appeon_gifofwait)	
	end if
end if

post event ue_selectrow(currentrow)
end event

event ue_selectrow(long as_currentrow);//////////////////////////////////////////////////////////////////////
// $<event>ue_selectroww_agreement_template_add_clause()
// $<arguments>
//		long	as_currentrow		
// $<returns> (None)
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

dw_selected.setfocus()
dw_selected.selectrow(as_currentrow,true)
end event

public function boolean of_fileopened (string as_file);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_add_clauseof_fileopened()
// $<arguments>
//		string	as_file		
// $<returns> boolean
// $<description>Check whether the specified file is opened
//////////////////////////////////////////////////////////////////////
// $<add> 12.06.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

if lower(is_current_file) = lower(as_file) then //file already opened
	return true
end if

return false
end function

public function integer of_get_clause_file (long al_clauseid, datetime adt_lastupdate);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_clause_add_clause.of_get_clause_file()
// $<arguments>
//		value	long    	al_clauseid   		
//		value	datetime	adt_lastupdate		
// $<returns> integer
// $<description>Get or Generate clause file from DB
//////////////////////////////////////////////////////////////////////
// $<add> 11.16.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

string ls_lastupdate,ls_regupdate,ls_filename = ''
long ll_len,ll_currentpos,ll_length,ll_start
integer li_writes,li_filenum,li_cnt,li_loops
boolean lb_local //indicate whether local file is existed and updated
blob lblb_file,lblb_data


//Begin - Modified By Ken.Guo 2010-01-15
Integer li_ret
Decimal{1} ldec_revision //Added By Ken.Guo 2011-05-03.
n_cst_clause lnv_clause
lnv_clause = Create n_cst_clause

ldec_revision = Dec(gnv_data.of_getitem( 'clause', 'revision', 'ctx_acp_clause_id = ' + String(al_clauseid)) ) //Added By Ken.Guo 2011-05-03.

li_ret = lnv_clause.of_download_file( al_clauseid,ldec_revision,adt_lastupdate,ls_filename)

Destroy lnv_clause
Return li_ret

/*
setpointer(HourGlass!)
lb_local = false

ls_filename = is_agreement_path + "clause_" + string(al_clauseid) + ".doc"


if not isnull(adt_lastupdate) then
	ls_lastupdate = string(adt_lastupdate, "mm/dd/yyyy hh:mm:ss")
end if

//Compare the updated date between local files and from db
if fileexists(ls_filename) then
	gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_" + string(al_clauseid), regstring!, ls_regupdate)	
	if ls_lastupdate = ls_regupdate then
		lb_local = true
	end if
end if

//If local file not existed or updated, generate new local file and update registry
if not lb_local then 
	if gs_dbtype = "SQL" and appeongetclienttype() = "PB" THEN //SQL
		SELECT datalength( image_file ) INTO :ll_length FROM ctx_acp_clause
		 WHERE ctx_acp_clause_id = :al_clauseid; 
		if ll_length > 8000 then
			li_loops = ( ll_length / 8000 ) + 1
			For li_cnt = 1 To li_loops				
				ll_start = (li_cnt - 1) * 8000 + 1			
				SELECTBLOB substring( image_file, :ll_start, 8000 ) INTO :lblb_data FROM ctx_acp_clause 
					  WHERE ctx_acp_clause_id = :al_clauseid; 			
				IF SQLCA.SQLCode <> 0 THEN
					//Messagebox( "IntelliSoft", "Read file data from database failed." )
   				Messagebox( "IntelliSoft", "Failed to read file data from database." )
					If isvalid(lnv_clause) Then Destroy lnv_clause
					Return -1
				END IF
				lblb_file += lblb_data
			Next
		else
			selectblob image_file into :lblb_file from ctx_acp_clause
				  where ctx_acp_clause_id = :al_clauseid;		
		end if
	else //ASA
		selectblob image_file into :lblb_file from ctx_acp_clause
			  where ctx_acp_clause_id = :al_clauseid;	
	end if
	
	ll_len = len(lblb_file)
	If ll_len > 32765 then
		 if mod(ll_len, 32765) = 0 then
			 li_writes = ll_len / 32765
		 else
			 li_writes = (ll_len / 32765) + 1
		 end If
	 else
		 li_writes = 1
	end if
	
	ll_currentpos = 1
	
	li_filenum = fileopen(ls_filename , StreamMode!, Write!, LockWrite!,Replace!)
	if li_fileNum = -1 then 
		If isvalid(lnv_clause) Then Destroy lnv_clause
		return -1
	End if
	
	for li_cnt = 1 to li_writes
		 lblb_data = blobmid(lblb_file, ll_currentpos, 32765)
		 ll_currentpos += 32765
		 if filewrite(li_filenum, lblb_data) = -1 then
			 If isvalid(lnv_clause) Then Destroy lnv_clause
			 return -1
		 end If
	next
	
	fileclose(li_fileNum)
	
	//Save the latest update date of the current file in Registry
	gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_" + string(al_clauseid), regstring!, ls_lastupdate)	
end if

If isvalid(lnv_clause) Then Destroy lnv_clause
return 1
*/
//End - Modified By Ken.Guo 2010-01-15
end function

public function integer of_displayfile (string as_file);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_add_clauseof_displayfile()
// $<arguments>
//		value	string	as_file		
// $<returns> integer
// $<description>close old and open new file
//////////////////////////////////////////////////////////////////////
// $<add> 11.16.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
setpointer(HourGlass!)
ole_1.visible = false

//close original file
//ole_1.object.close() - commented by alfee 09.23.2008
is_current_file =""

//----------Begin Modified by Alfee on 04.21.2008 ------------------------	
//<$Reason>For the document currently opened in the clause library painter 
Long ll_clauseid
String ls_file, ls_clausefile

IF IsNull(as_file) or Len(Trim(as_file)) < 1 THEN
	ole_1.visible = TRUE
	RETURN -1
END IF

//Copy to a temp file if it opened already in clause library painter 
ls_file = as_file
IF IsValid(w_clause_painter) THEN
	IF w_clause_painter.tab_1.tabpage_clause.ole_1.object.doctype = 1 THEN
		ll_clauseid = w_clause_painter.tab_1.il_old_clause_id
		IF ll_clauseid > 0 THEN 
			//ls_clausefile = is_agreement_path + "clause_" +String(ll_clauseid)  + ".doc" 
			ls_clausefile = inv_clause.of_generate_name(ll_clauseid) //Modified By Ken.Guo 2010-01-18
		End If
		IF Lower(as_file) = Lower(ls_clausefile) THEN
			IF FileCopy(as_file, is_agreement_path + "clause4preview.doc", TRUE)	= 1 THEN
				ls_file = is_agreement_path + "clause4preview.doc"		
			ELSE
				ls_file = ""
			END IF
		END IF
	END IF					
END IF

//Open the file
IF FileExists(ls_file) THEN 
	ole_1.object.openlocalfile(ls_file, true) 
	gnv_word_utility.of_modify_word_property( ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	is_current_file = as_file
ELSE
	ole_1.object.Close() //Alfee 09.23.2008
	ole_1.visible = TRUE
	RETURN -1
END IF

/* if len(trim(as_file)) > 0 then
	ole_1.object.openlocalfile(as_file, true) 
	is_current_file = as_file
end if */
//----------End Modified ----------------------------------------------

ole_1.visible = true
return 1


end function

public function integer of_get_clause_file (long al_clauseid[], datetime adt_lastupdate[]);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_add_clauseof_get_clause_file()
// $<arguments>
//		value	long    	al_clauseid[]   		
//		value	datetime	adt_lastupdate[]		
// $<returns> integer
// $<description>Get/Gen clause files in batch mode for better web performance
//////////////////////////////////////////////////////////////////////
// $<add> 11.16.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

string ls_lastupdate,ls_regupdate,ls_filename,ls_clause_file
long ll_len,ll_currentpos,ll_cnt,i,ll_length[],ll_start
integer li_writes,li_filenum,li_cnt,li_loops,j
boolean lb_local[] //indicate whether local file is existed and updated
blob lblb_file[],lblb_data, lblb_temp[]

ll_cnt = upperbound(al_clauseid[])
if ll_cnt < 1 then return 0

//Begin - Modified By Ken.Guo 2010-01-15. In fact, the old function do not improve the performance.
n_cst_clause lnv_clause
lnv_clause = Create n_cst_clause
for i = ll_cnt to 1 step -1
	If isvalid(w_appeon_gifofwait) Then
		ls_clause_file = gnv_data.of_getitem( 'clause', 'clause_name', 'ctx_acp_clause_id = ' + String(al_clauseid)) 
		w_appeon_gifofwait.of_settext(String(ll_cnt - i + 1) + '/' + String(ll_cnt) + '  Downloading the clause ' + ls_clause_file + '...')
	End If	
	of_get_clause_file(al_clauseid[i],adt_lastupdate[i])
Next
Return 1
/*
setpointer(HourGlass!)

//--------Begin Added by Alfee 11.29.2007----------------------
TRY
	OLEObject lole_word
	lole_word = w_agreement_template_painter.tab_1.tabpage_2.ole_1.object.ActiveDocument
CATCH(Throwable th)
	RETURN -1
END TRY
//--------End Added -------------------------------------------	


//Compare the updated date between local files and from db
for i = ll_cnt to 1 step -1 
	lb_local[i] = false
	
	ls_filename = is_agreement_path + "clause_" + string(al_clauseid[i]) + ".doc" //Modified By Ken.Guo 2010-01-15
	 
	if not isnull(adt_lastupdate[i]) then
		ls_lastupdate = string(adt_lastupdate[i], "mm/dd/yyyy hh:mm:ss")
	end if

	if fileexists(ls_filename) then
		gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_" + string(al_clauseid[i]), regstring!, ls_regupdate)	
		if ls_lastupdate = ls_regupdate then
			lb_local[i] = true
		end if
	end if
	//------------Begin Added by Alfee 11.29.2007-----------------
	//<$Reason>Get only new added clauses' files for performance tuning
	if not lb_local[i] then lb_local[i] = lole_word.content.bookmarks.Exists("clause_" + string(al_clauseid[i])) 
	//------------End Added --------------------------------------		
next



//get needed blob data from db in batch mode
if gs_dbtype = "SQL" and appeongetclienttype() = "PB" THEN //SQL
	//get all files' length
	gnv_appeondb.of_startqueue() //for web performance tunning			 
	for i = ll_cnt to 1 step -1 
		//If local file not existed or updated
		if not lb_local[i] then 
			SELECT datalength( image_file ) INTO :ll_length[i] FROM ctx_acp_clause
			 WHERE ctx_acp_clause_id = :al_clauseid[i]; 
		end if
	next
	gnv_appeondb.of_commitqueue()//for web performance tunning			

	//get all files' data
//	gnv_appeondb.of_startqueue()
	for i = ll_cnt to 1 step -1 
		//If local file not existed or updated
		if not lb_local[i] then 
			if ll_length[i] > 8000 then 
				li_loops = ( ll_length[i] / 8000 ) + 1
				//gnv_appeondb.of_startqueue()//Alfee 06.25.2007-not support for selectblob
				For j = 1 To li_loops				
					ll_start = (j - 1) * 8000 + 1			
					SELECTBLOB substring(image_file, :ll_start, 8000 ) INTO :lblb_temp[j] FROM ctx_acp_clause 
						  WHERE ctx_acp_clause_id = :al_clauseid[i]; 			
				Next
				//gnv_appeondb.of_commitqueue()
				For j = 1 To li_loops				
					lblb_file[i] += lblb_temp[j]
				next
			else
				selectblob image_file into :lblb_file[i] from ctx_acp_clause
 			   	  where ctx_acp_clause_id = :al_clauseid[i];
			end if	
		end if
	next
	//gnv_appeondb.of_commitqueue()
else //ASA
	//gnv_appeondb.of_startqueue()//Alfee 06.25.2007-not support for selectblob
	for i = ll_cnt to 1 step -1 
		//If local file not existed or updated 
		if not lb_local[i] then 
			selectblob image_file into :lblb_file[i] from ctx_acp_clause
 			     where ctx_acp_clause_id = :al_clauseid[i];
		end if
	next		
	//gnv_appeondb.of_commitqueue()
end if
	
//Generate local files needed
for i = ll_cnt to 1 step -1 
	//skip for some updated local files
	if lb_local[i] then continue 
	//get times of writing file
	ll_len = len(lblb_file[i])
	if ll_len > 32765 then
		if mod(ll_len, 32765) = 0 then
			 li_writes = ll_len / 32765
		 else
			 li_writes = (ll_len / 32765) + 1
		 end If
	else
		 li_writes = 1
	end if
	//open file
	ll_currentpos = 1
	ls_filename = is_agreement_path + "clause_" + string(al_clauseid[i]) + ".doc"
	li_filenum = fileopen(ls_filename , StreamMode!, Write!, LockWrite!,Replace!)
	if li_fileNum = -1 then return -1
	//write file
	for li_cnt = 1 to li_writes
		 lblb_data = blobmid(lblb_file[i], ll_currentpos, 32765)
		 ll_currentpos += 32765
		 if filewrite(li_filenum, lblb_data) = -1 then
			 return -1
		 end If
	next
	//close file
	fileclose(li_filenum)
	//Save the latest update date of the current file in Registry
	//--------------------------Begin Modified by Alfee 11.29.2007 ---------------------------------------------------------------------------------------
	if not isnull(adt_lastupdate[i]) then
		gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_" + string(al_clauseid[i]), regstring!, String(adt_lastupdate[i], "mm/dd/yyyy hh:mm:ss")) 	
	end if	
	//gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", "clause_" + string(al_clauseid), regstring!, ls_lastupdate)	
	//--------------------------End Modified -------------------------------------------------------------------------------------------------------------
next
*/
//End - Modified By Ken.Guo 2010-01-15
end function

public function integer of_add_clause_file ();//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_add_clause.of_add_clause_file()
// $<arguments>(None)
// $<returns> integer
// $<description>Add selected clause files to template
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

long ll_cnt,ll_row, i
long ll_clause_id[]
integer li_rtn
string ls_clause_filename,ls_template_filename
datetime ldt_modify_date[]
decimal{1} ldec_revision[]

setpointer(HourGlass!)
dw_selected.accepttext() 
ll_cnt = dw_selected.rowcount()
ls_template_filename = is_agreement_path + "template_" + string(il_template_id) + ".doc"

for i = 1 to ll_cnt 
	ll_clause_id[i] = dw_selected.getitemnumber(i,"ctx_acp_clause_id")
	ldt_modify_date[i] = dw_selected.getitemdatetime(i,"modify_date")	
next

//get or generate all the local files needed
if of_get_clause_file(ll_clause_id,ldt_modify_date) = -1 then 
	messagebox("IntelliSoftGroup","Can't finish adding clause(s) to template file due to getting clause file(s) failed!" ) //(Appeon)Harry 03.12.2014 - V142 ISG-CLX Modify "ContractLogix" to "IntelliSoftGroup"
	return -1
end if

if isvalid(w_appeon_gifofwait) then w_appeon_gifofwait.event timer()

//merge all clause files into template file, and update it into db
//and of_merge_files() fun should call the numbering funtion //04.28.2007
if not isvalid(w_agreement_template_painter) then return -1

//Added By Ken.Guo 2011-05-03.
If isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Merging clauses to template...')

if w_agreement_template_painter.of_merge_files(ll_clause_id) = -1 then return -1

if isvalid(w_appeon_gifofwait) then w_appeon_gifofwait.event timer()

//set selected clauses
of_set_selected_clauses()

//Added By Mark Lee 08/21/12 moved gnv_appeondb 
//update template-clause mapping, and refresh the clause list in template window
//gnv_appeondb.of_startqueue() //for web performance
	dw_selected.update()
	w_agreement_template_painter.of_refresh_clause() 
	//-------Begin Added by Alfee 11.12.2007-----------------------
	f_sync_addclause_rules(il_template_id ) 
	//-------End Added --------------------------------------------		
//gnv_appeondb.of_commitqueue() //for web performance		

if sqlca.sqlcode <> 0 then 
	messagebox("IntelliSoftGroup","Can't finish adding clause(s) to template file due to database updating failed!") //(Appeon)Harry 03.12.2014 - V142 ISG-CLX Modify "ContractLogix" to "IntelliSoftGroup"
	return -1
end if

return 1

end function

public function integer of_set_selected_clauses ();//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_add_clause.of_set_selected_clauses()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>Set selected clauses' order & template id
//////////////////////////////////////////////////////////////////////
// $<add> 11.22.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long ll_cnt,i

ll_cnt = dw_selected.rowcount()
for i = 1 to ll_cnt
	dw_selected.setitem(i,"orders",i)
	dw_selected.setitem(i,"ctx_acp_template_id",il_template_id)
next

return 1
end function

public function integer of_display_properties ();//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_add_clauseof_display_properties()
// $<arguments>(None)
// $<returns> integer
// $<description>Display clause properties if properties tabpage
// $<description>currently selected
//////////////////////////////////////////////////////////////////////
// $<add> 11.24.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

long ll_cnt,ll_row,ll_current
//long ll_category,ll_approval_status
////string ls_clause_name,ls_description,ls_information,ls_approved_by
//datetime ldt_date_approved

//---------------Appeon Begin by alfee 04.19.2007------------------
if tab_1.selectedtab = 2 then
	tab_1.tabpage_2.dw_properties.Retrieve(il_clause_id)
	if tab_1.tabpage_2.dw_properties.rowcount() < 1 then
		tab_1.tabpage_2.dw_properties.insertrow(0)	
	end if
end if

return 1
/*
if tab_1.selectedtab = 2 then
	if tab_1.tabpage_2.dw_properties.rowcount() < 1 then
		ll_current = tab_1.tabpage_2.dw_properties.insertrow(0)	
	else
		ll_current = tab_1.tabpage_2.dw_properties.getrow()	
	end if
	
	//display it if a clause selected
	if not isnull(il_clause_id) then 
		//find firstly in primary! buffer
		ll_cnt = tab_1.tabpage_1.ds_clause.rowcount()
		ll_row = tab_1.tabpage_1.ds_clause.find("ctx_acp_clause_id ="+string(il_clause_id),1,ll_cnt)
		if ll_row > 0 then
			//set values in properties tabpage
			tab_1.tabpage_2.dw_properties.object.data[ll_current] = tab_1.tabpage_1.ds_clause.object.data[ll_row]
		else 
			//find in filter! buffer
			ll_cnt = tab_1.tabpage_1.ds_clause.FilteredCount()		
			for ll_row = 1 to ll_cnt 
				if tab_1.tabpage_1.ds_clause.object.ctx_acp_clause_id.filter.current[ll_row] = il_clause_id then
					tab_1.tabpage_2.dw_properties.object.data[ll_current] = &
						tab_1.tabpage_1.ds_clause.object.data.filter.current[ll_row]	
					exit
				end if
			next
		end if
	end if
end if

return 1
*/
//--------------------Appeon End -------------------------------------------
						
		
//		ll_category = tabpage_1.ds_clause.getitemnumber(ll_row,"category")
//		ls_clause_name = tabpage_1.ds_clause.getitemstring(ll_row,"clause_name")
//		ls_description = tabpage_1.ds_clause.getitemstring(ll_row,"description")
//		ls_information = tabpage_1.ds_clause.getitemstring(ll_row,"information_message")		
//		ls_approved_by = tabpage_1.ds_clause.getitemstring(ll_row,"approved_by")
//		ldt_date_approved = tabpage_1.ds_clause.getitemdatetime(ll_row,"date_approved")	
//		ll_approval_status = tabpage_1.ds_clause.getitemnumber(ll_row,"approval_status")	
//		
//		//display the clause in properties tabpage
//		ll_row = tabpage_2.dw_properties.insertrow(0)
//		tabpage_2.dw_properties.setitem(ll_row,"category",ll_category)
//		tabpage_2.dw_properties.setitem(ll_row,"clause_name",ls_clause_name)
//		tabpage_2.dw_properties.setitem(ll_row,"description",ls_description)
//		tabpage_2.dw_properties.setitem(ll_row,"information_message",ls_information)		
//		tabpage_2.dw_properties.setitem(ll_row,"approved_by",ls_approved_by)
//		tabpage_2.dw_properties.setitem(ll_row,"date_approved",ldt_date_approved)
//		tabpage_2.dw_properties.setitem(ll_row,"approval_status",ll_approval_status)		

end function

public subroutine of_open ();long ll_handle
string ls_filename

il_template_id =w_agreement_template_painter.il_template_id

this.setredraw(false)

//initialize ole_1
if len(trim(is_current_file)) > 0 then
	ole_1.object.close()
	is_current_file = "" 
end if

//initialize datawindow
this.event ue_inidw()

//reset dw_filter
tab_1.tabpage_1.dw_filter.reset()
tab_1.tabpage_1.dw_filter.insertrow(0)

//build treeview
tab_1.tabpage_1.cb_go.event clicked()

//for performance tunning, handle rowfocuschanged of dw_selected only once 
this.event pfc_cst_rowfocuschanged()

tab_1.selecttab(1)

if cb_resize.text = "[-]" then
	cb_resize.post event clicked()
end if

tab_1.tabpage_1.dw_filter.setfocus()

this.setredraw(true)
	







end subroutine

public function integer of_resize (boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<function>w_agreement_template_add_clauseof_resize()
// $<arguments>
//		value	boolean	ab_flag : true: for cb_resize button clicked
//										 false: for window resize event
// $<returns> integer
// $<description>Resize of the document display 
//////////////////////////////////////////////////////////////////////
// $<add> 12.12.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

This.SetRedraw(false)
cb_fresize.Visible = false
If cb_fresize.Text = '[+]' Then
	If (ab_flag and cb_resize.text = '[+]') or &
		(not ab_flag and cb_resize.text = '[-]') Then
		cb_resize.text = '[-]' 
		gb_2.x = 5
		gb_2.y = 0
		gb_2.width = This.width - 65
		gb_2.height = This.height - 115   
		ole_1.x = gb_2.x + 32
		ole_1.y = gb_2.y + 55
		ole_1.width = gb_2.width - 60
		ole_1.height = gb_2.height - 90
		//Added By Mark Lee 09/24/12
//		cb_resize.x = gb_2.x + gb_2.width - 55
		cb_resize.x = gb_2.x + gb_2.width - 36
		//Added By Mark Lee 09/24/12
//		cb_resize.y = gb_2.y - 4
		cb_resize.y = gb_2.y - 2
		tab_1.visible = false
		cb_cancel.visible = false
		gb_1.visible = false
		dw_selected.visible = false
		cbx_preview.visible = false
		st_VSplitBar.Visible = false		//Added by Scofield on 2010-01-14
		st_hspitbar1.Visible = false//added by gavins 20120717
		cb_fresize.Visible = false
		dw_formula.Visible = false
		cb_resize.bringtotop = true
		This.bringtotop = true
		ole_1.setfocus()
	Else
		cb_resize.text = '[+]'
		gb_2.x = gb_1.x
		gb_2.y = cb_cancel.y	+ cb_cancel.height
		gb_2.width = gb_1.width
		//Begin - Added By Mark Lee 09/25/12
//		gb_2.height = gb_3.Y - gb_2.Y
//		If cbx_preview.checked = true Then
//			gb_2.height = gb_3.Y - gb_2.Y - 20
//		Else
			//gb_2.height = gb_3.Y - gb_2.Y - 40 //Commented by (Appeon)Harry 04.01.2014 - V142 ISG-CLX
			gb_2.height = st_hspitbar1.Y - gb_2.Y - 40 //(Appeon)Harry 04.01.2014 - V142 ISG-CLX
//		End If	
//		gb_2.height = integer( gb_1.height / 2 )
		//End - Added By Mark Lee 09/25/12
		ole_1.x = gb_2.x + 32
		ole_1.y = gb_2.y + 52
		ole_1.width = gb_2.width - 59
		ole_1.height = gb_2.height - 72
		cb_resize.x = gb_2.x + gb_2.width - 36
		cb_resize.y = gb_2.y - 2
		If cb_fresize.Text = '[+]' Then
			tab_1.visible = true
			cb_cancel.visible = true
			gb_1.visible = true
			dw_selected.visible = true
			cbx_preview.visible = true
			st_VSplitBar.Visible = true		//Added by Scofield on 2010-01-14
			cb_fresize.Visible = true
			st_hspitbar1.Visible = True
			dw_formula.Visible = true
		End If
		ole_1.bringtotop = true	
		cb_resize.bringtotop = true
		ole_1.setfocus()
	End If
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 21-03-2007 By: Ken.Guo
	//$<reason> Add new requirement. Need auto resize dw_selected when checked cbx_preview
	ole_1.height = gb_2.height - 112 
	if cbx_preview.checked = true and cb_resize.text <> '[-]' then
		//Added By Mark Lee 09/25/12
//		dw_selected.height = tab_1.height * 1/5
		dw_selected.height = tab_1.height * 1/3
		
		gb_1.height =  dw_selected.height + 100
		cbx_preview.y = gb_1.y + gb_1.height + 40
		cb_cancel.y = cbx_preview.y
		cb_add.y = cbx_preview.y
		cb_rules.y = cbx_preview.y	//11.12.2007	
		gb_2.y = cbx_preview.y + cbx_preview.height + 40
		//Begin - Added By Mark Lee 09/25/12
//		gb_2.height = gb_3.Y - gb_2.Y - 20  //modified by gavins 20120717
		If cbx_preview.checked = true Then
			//
		Else
			//gb_2.height = gb_3.Y - gb_2.Y - 40 //Commented by (Appeon)Harry 04.01.2014 - V142 ISG-CLX
			gb_2.height = st_hspitbar1.Y - gb_2.Y - 40 //(Appeon)Harry 04.01.2014 - V142 ISG-CLX
		End If	
		//End - Added By Mark Lee 09/25/12	
		ole_1.y = gb_2.y + 56
		ole_1.height = gb_2.height - 76
	elseif cb_resize.text <> '[-]' then
		dw_selected.height = tab_1.height * 1/3
		gb_1.height =  dw_selected.height + 100
		cbx_preview.y = gb_1.y + gb_1.height + 40
		cb_cancel.y = cbx_preview.y
		cb_add.y = cbx_preview.y
		cb_rules.y = cbx_preview.y	//11.12.2007	
		gb_2.y = cbx_preview.y + cbx_preview.height + 40
		//Begin - Added By Mark Lee 09/24/12
//		gb_2.height = gb_3.Y - gb_2.Y - 20
//		ole_1.y = gb_2.y + 56
//		ole_1.height = gb_2.height - 76
		If cbx_preview.checked = true Then
			//gb_2.height = gb_3.Y - gb_2.Y - 40  //Commented by (Appeon)Harry 04.01.2014 - V142 ISG-CLX
			gb_2.height = st_hspitbar1.Y - gb_2.Y - 40 //(Appeon)Harry 04.01.2014 - V142 ISG-CLX
			ole_1.y = gb_2.y + 56
			ole_1.height = gb_2.height - 76
		Else

			ole_1.y = gb_2.y + 56
			ole_1.height = gb_2.height - 76
		End If		
		//End - Added By Mark Lee 09/24/12

	end if
	
	cb_resize.x = gb_2.x + gb_2.width - 36
	cb_resize.y = gb_2.y - 2
End If

event pfc_preopen()
//---------------------------- APPEON END ----------------------------

This.SetRedraw(true)

Return 1

end function

public subroutine of_drop_clause_list (integer ai_current_row, integer ai_target_row);long ll_sum_rules //11.12.2007
long ll_row , i , ll_target_row , ll_current_row , ll_steps
long ll_clause_id
string ls_clause_name
datetime ldt_modify_date

If not ai_current_row >0 Then return
If not ai_target_row > 0 Then return 
If ai_current_row = ai_target_row Then return

ll_steps = abs(ai_current_row - ai_target_row)
If ai_current_row > ai_target_row Then
	ll_row  = ai_target_row
Else
	ll_row  = ai_current_row
End If


For i = 1 to ll_steps
	If ai_current_row > ai_target_row Then
		ll_row = ai_current_row + 1 - i
		ll_target_row = ll_row -1 
	Else
		ll_row = ai_current_row  + i - 1
		ll_target_row = ll_row + 1
	End If

	ll_clause_id = dw_selected.object.ctx_acp_clause_id[ll_row]
	ls_clause_name = dw_selected.object.clause_name[ll_row]
	ldt_modify_date = dw_selected.object.modify_date[ll_row]
	ll_sum_rules = dw_selected.object.sum_rules[ll_row] //11.12.2007
	
	dw_selected.object.ctx_acp_clause_id[ll_row] = dw_selected.object.ctx_acp_clause_id[ll_target_row]
	dw_selected.object.clause_name[ll_row] = dw_selected.object.clause_name[ll_target_row]
	dw_selected.object.modify_date[ll_row] = dw_selected.object.modify_date[ll_target_row]	
	dw_selected.object.sum_rules[ll_row] = dw_selected.object.sum_rules[ll_target_row]	 //11.12.2007
	
	dw_selected.object.ctx_acp_clause_id[ll_target_row] = ll_clause_id
	dw_selected.object.clause_name[ll_target_row] = ls_clause_name
	dw_selected.object.modify_date[ll_target_row] = ldt_modify_date
	dw_selected.object.sum_rules[ll_target_row] = ll_sum_rules //11.12.2007

Next
dw_selected.accepttext() 
dw_selected.setrow(ll_target_row)
dw_selected.scrolltorow(ll_target_row)
	
end subroutine

public function integer of_store_clause_rulecnt ();//Store selected clauses' rule count(include history clauses') 
//Added by Alfee 11.12.2007

Long ll_cnt, i, ll_row, ll_clauseid, ll_found

ll_cnt = dw_selected.rowcount( )
FOR i = 1 to ll_cnt
	ll_clauseid = dw_selected.GetItemNumber(i, "ctx_acp_clause_id")
	ll_found = ids_clause_rulecnt.Find("ctx_acp_clause_id = " + String(ll_clauseid), 1, ll_cnt)
	IF ll_found > 0 THEN 
		ids_clause_rulecnt.SetItem(ll_found, "sum_rules", dw_selected.GetItemNumber(i, "sum_rules"))
	ELSE		
		ll_row = ids_clause_rulecnt.InsertRow(0)
		ids_clause_rulecnt.SetItem(ll_row, "ctx_acp_clause_id", ll_clauseid)
		ids_clause_rulecnt.SetItem(ll_row, "sum_rules", dw_selected.GetItemNumber(i, "sum_rules"))	
	END IF
NEXT
	
RETURN 1
end function

public subroutine of_refreshclauserules ();//====================================================================
// Function: of_RefreshClauseRules()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-20
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_CurRow,ll_clauseid

ll_CurRow = dw_Selected.GetRow()

if ll_CurRow <= 0 or ll_CurRow > dw_Selected.RowCount() then
	dw_Formula.Reset()
	Return
end if

ll_clauseid = dw_Selected.GetItemNumber(ll_CurRow,'ctx_acp_clause_id')

dw_Formula.Retrieve(il_template_id,ll_clauseid)

end subroutine

public subroutine of_reszieclauseformula (boolean ab_zoom);Boolean 			bln_preview

If 	cb_resize.text = '[+]' Then
	//Added By Mark Lee 09/25/12
	If ab_Zoom Then
		gb_3.x = 5
		gb_3.y = 0
		gb_3.width = This.width - 65
		gb_3.height = This.height - 115   
		dw_formula.x = gb_3.x + 32
		dw_formula.y = gb_3.y + 55
		dw_formula.width = gb_3.width - 60
		dw_formula.height = gb_3.height - 90
		cb_fresize.x = gb_3.x + gb_3.width - 55
		cb_fresize.y = gb_3.y - 4
	
		//Begin - Added By Mark Lee 09/24/12
		gb_2.visible  = false
		//End - Added By Mark Lee 09/24/12

		cb_resize.Visible = false
		cb_add.Visible = false
		ole_1.Visible = false
		tab_1.visible = false
		cb_cancel.visible = false
		gb_1.visible = false
		dw_selected.visible = false
		cbx_preview.visible = false
		st_VSplitBar.Visible = false		//Added by Scofield on 2010-01-14
		st_hspitbar1.Visible = false//added by gavins 20120717
		cb_fresize.Visible = true
		cb_fresize.bringtotop = true
		This.bringtotop = true
		dw_formula.setfocus()
		cb_fresize.Text = '[-]'
	Else
		cb_fresize.text = '[+]'
		gb_3.x = gb_2.x
		//Added By Mark Lee 09/25/12
//		gb_3.y = gb_2.y	+ gb_2.height + 20
		//---------Begin Modified by (Appeon)Harry 04.01.2014 for V142 ISG-CLX--------
		//gb_3.y = gb_2.y	+ gb_2.height + 40
		if cbx_preview.checked then
			gb_3.y = st_hspitbar1.y	+ st_hspitbar1.height + 24 
		else
			gb_3.y = gb_2.y
		end if
		//---------End Modfiied ------------------------------------------------------
		gb_2.width = gb_1.width
		gb_3.width = gb_1.width
		gb_3.height = this.Height - gb_3.Y - 115 - 20
		dw_formula.x = gb_3.x + 32
		dw_formula.y = gb_3.y + 52
		dw_formula.width = gb_3.width - 59
		dw_formula.height = gb_3.height - 72
		cb_fresize.x = gb_3.x + gb_3.width - 36
		cb_fresize.y = gb_3.y - 2
		//st_hspitbar1.Y = gb_3.y - 10 //Commented by (Appeon)Harry 04.01.2014 - V142 ISG-CLX
		
		If cb_Resize.Text = '[+]' 	Then
			tab_1.visible = true
			cb_cancel.visible = true
			gb_1.visible = true
			cb_add.visible = true
//			ole_1.Visible = true				//Modified By Mark Lee 09/25/12
//			cb_resize.Visible = true			//Modified By Mark Lee 09/25/12
			dw_selected.visible = true
			cbx_preview.visible = true
			st_VSplitBar.Visible = true		//Added by Scofield on 2010-01-14
//			st_hspitbar1.Visible = True		//Modified By Mark Lee 09/25/12
			
			//Begin - Added By Mark Lee 09/25/12
			IF cbx_preview.checked = True Then
				bln_preview = True
			Else
				bln_preview = False
			End IF
			//wf_set_visible(bln_preview) //Commented by (Appeon)Harry 04.01.2014 - V142 ISG-CLX
			gb_2.visible = bln_preview
			ole_1.visible = bln_preview
			st_hspitbar1.visible = bln_preview
			cb_resize.visible = bln_preview
			//End - Added By Mark Lee 09/25/12
		End If
		dw_formula.bringtotop = true	
		cb_fresize.bringtotop = true
		dw_formula.setfocus()
	End If
End If
	
end subroutine

public function integer wf_set_visible (boolean abn_arg);//====================================================================
// Function: wf_set_visible
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                abn_arg
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 09/24/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 			ll_height

ll_height = gb_3.y + gb_3.height
If abn_arg = True Then
	gb_2.visible = True
	ole_1.visible = True
	st_hspitbar1.visible = True
	cb_resize.visible = True
//	gb_2.height = 896
	If gb_2.height <= 896 Then
		gb_2.height =integer( gb_3.height / 3 )
	End If
	ole_1.height = gb_2.height - 76
	st_hspitbar1.y = gb_2.y + gb_2.height + 8
	
	gb_3.y = st_hspitbar1.y + st_hspitbar1.height + 24
	
Else
	gb_2.visible = False
	ole_1.visible = False
	st_hspitbar1.visible = False
	cb_resize.visible = False
	
	gb_3.y  = gb_2.y

End If

gb_3.height = ll_height - gb_3.y
dw_formula.y = gb_3.y + 60
dw_formula.height = gb_3.height - 76
cb_fresize.y = gb_3.y - 2

Return 1
end function

on w_agreement_template_add_clause.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.cb_fresize=create cb_fresize
this.st_hspitbar1=create st_hspitbar1
this.dw_formula=create dw_formula
this.st_vsplitbar=create st_vsplitbar
this.cb_rules=create cb_rules
this.cbx_preview=create cbx_preview
this.tab_1=create tab_1
this.cb_move_down=create cb_move_down
this.cb_move_up=create cb_move_up
this.cb_move_left=create cb_move_left
this.cb_move_right=create cb_move_right
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_cancel=create cb_cancel
this.dw_selected=create dw_selected
this.gb_3=create gb_3
this.cb_add=create cb_add
this.cb_resize=create cb_resize
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.cb_fresize
this.Control[iCurrent+3]=this.st_hspitbar1
this.Control[iCurrent+4]=this.dw_formula
this.Control[iCurrent+5]=this.st_vsplitbar
this.Control[iCurrent+6]=this.cb_rules
this.Control[iCurrent+7]=this.cbx_preview
this.Control[iCurrent+8]=this.tab_1
this.Control[iCurrent+9]=this.cb_move_down
this.Control[iCurrent+10]=this.cb_move_up
this.Control[iCurrent+11]=this.cb_move_left
this.Control[iCurrent+12]=this.cb_move_right
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.cb_cancel
this.Control[iCurrent+16]=this.dw_selected
this.Control[iCurrent+17]=this.gb_3
this.Control[iCurrent+18]=this.cb_add
this.Control[iCurrent+19]=this.cb_resize
end on

on w_agreement_template_add_clause.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.cb_fresize)
destroy(this.st_hspitbar1)
destroy(this.dw_formula)
destroy(this.st_vsplitbar)
destroy(this.cb_rules)
destroy(this.cbx_preview)
destroy(this.tab_1)
destroy(this.cb_move_down)
destroy(this.cb_move_up)
destroy(this.cb_move_left)
destroy(this.cb_move_right)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_cancel)
destroy(this.dw_selected)
destroy(this.gb_3)
destroy(this.cb_add)
destroy(this.cb_resize)
end on

event open;call super::open;is_agreement_path = gs_dir_path + gs_DefDirName + "\Agreement\"
il_template_id = w_agreement_template_painter.il_template_id
il_export_id = w_agreement_template_painter.il_export_id //added by alfee 04.19.2007

//BEGIN---Modify by Scofield on 2010-01-14
if IsValid(w_agreement_template_painter) then
	Tab_1.Tabpage_1.istr_ClauseFilter = w_agreement_template_painter.istr_ClauseFilter
end if
//END---Modify by Scofield on 2010-01-14

Tab_1.Tabpage_1.of_RefreshFilterPicture()

ids_infomsg = create DataStore
ids_infomsg.DataObject = 'd_agreement_template_clause_infomsg'
ids_infomsg.SetTransObject(SQLCA)

//-----Begin Added by Alfee 11.12.2007---------------------
ids_clause_rulecnt = Create DataStore
ids_clause_rulecnt.DataObject = 'd_agreement_template_clause_selected'
//-----End Added ------------------------------------------

//iole_word = create oleobject
//iole_word = ole_1.object.GetIDispatch()

//initialize datawindows
this.event ue_inidw()

//build clause tree
tab_1.tabpage_1.cb_go.event clicked()

//for performance tunning, handle rowfocuschanged of dw_selected only once 
this.event pfc_cst_rowfocuschanged()

//if dw_selected.getrow() >0 then
//	il_clause_id = dw_selected.object.ctx_acp_clause_id[dw_selected.getrow()]
//end if

//BEGIN---Modify by Scofield on 2010-01-14
st_VSplitBar.of_Register(Tab_1,st_VSplitBar.Left)
st_VSplitBar.of_Register(ole_1,st_VSplitBar.Right)
st_VSplitBar.of_Register(gb_1,st_VSplitBar.Right)
st_VSplitBar.of_Register(gb_2,st_VSplitBar.Right)
st_VSplitBar.of_Register(dw_selected,st_VSplitBar.Right)
st_VSplitBar.of_Register(gb_3,st_VSplitBar.Right)
st_VSplitBar.of_Register(dw_Formula,st_VSplitBar.Right)
st_VSplitBar.of_Register(st_hspitbar1,st_VSplitBar.Right)
//END---Modify by Scofield on 2010-01-14

//added by gavins 20120717
st_hspitbar1.of_Register(gb_2, 3 )
st_hspitbar1.of_Register(ole_1, 3 )
st_hspitbar1.of_Register(dw_formula, 4 )
st_hspitbar1.of_Register(gb_3, 4 )
st_hspitbar1.of_SetMinobjectsize( 200 )

inv_clause = Create n_cst_clause

gnv_data.of_retrieve('clause') //Added By Ken.Guo 2011-05-03.


//Begin - Added By Mark Lee 09/20/12
If gnv_user_option.of_get_option_value(gs_user_id, "w_agreement_template_add_clause_windowstate" ) = 'maximized' Then
	this.windowstate = Maximized!
Else
	This.WindowState = Normal!
End If
//End - Added By Mark Lee 09/20/12


end event

event close;call super::close;//BEGIN---Modify by Scofield on 2010-01-14
if IsValid(w_agreement_template_painter) then
	w_agreement_template_painter.istr_ClauseFilter = w_agreement_template_add_clause.tab_1.tabpage_1.istr_ClauseFilter
end if
//END---Modify by Scofield on 2010-01-14

//destroy iole_word
ole_1.object.close()
Destroy ids_infomsg
Destroy ids_clause_rulecnt //11.12.2007

If isvalid(inv_clause) Then Destroy inv_clause


//Close clause comparison window - Added by Alfee 10.18.2007
IF IsValid(tab_1.tabpage_1.inv_clause_comparison) THEN
	tab_1.tabpage_1.inv_clause_comparison.of_close_comparison('template')
END IF

if isvalid(w_agreement_template_painter) then
	w_agreement_template_painter.enabled = true
	w_agreement_template_painter.of_menu_security("detail")
	w_agreement_template_painter.setfocus()
end if

//Begin - Added By Mark Lee 09/20/12
If This.WindowState = Maximized! Then
	gnv_user_option.of_Set_option_value(gs_user_id, "w_agreement_template_add_clause_windowstate",'maximized' )
Else
	gnv_user_option.of_Set_option_value(gs_user_id, "w_agreement_template_add_clause_windowstate",'normal' )
End If
gnv_user_option.of_save( )	
//End - Added By Mark Lee 09/20/12


end event

event closequery;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  closequery
//
//	Description:
//	Search for unsaved datawindows prompting the user if any
//	pending updates are found.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced control on what objects are to be updated.
// 6.0.01 Make sure the window is not minimized and behind other windows.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc
String	ls_msgparms[]
Powerobject lpo_updatearray[]

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0 Then
	// Updates are NOT pending, allow the window to be closed.
	//-------Begin Added by Alfee 11.12.2007-----------------------
	//<$Reason>Synchronize the add clause rules data if modified
	IF ib_newrules THEN Post f_sync_addclause_rules(il_template_id )
	//-------End Added --------------------------------------------			
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If
	this.BringToTop = True

	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_failsvalidation", &
					gnv_app.iapp_object.DisplayName, &
					"The information entered does not pass validation and "  + &
					"must be corrected before changes can be saved.~r~n~r~n" + &
					"Close without saving changes?", &
					exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		//-------Begin Added by Alfee 11.12.2007-----------------------
		//<$Reason>Synchronize the add clause rules data if modified
		IF ib_newrules THEN Post f_sync_addclause_rules(il_template_id )
		//-------End Added --------------------------------------------			
		ib_closestatus = False
		Return ALLOW_CLOSE
	End If
Else
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If	
	this.BringToTop = True
	
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			//-------------Appeon Begin -----by Derek at 03.14.2007---------
			integer li_rtn
         openwithparm(w_appeon_gifofwait, "merging clauses to template...")
         li_rtn = of_add_clause_file()
         if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
			if li_rtn = -1 then
				Return PREVENT_CLOSE
			end if
			//-------------Appeon End   ------------------------------------
			If This.Event pfc_save() >= 1 Then
				// Successful update, allow the window to be closed
				ib_closestatus = False
				Return ALLOW_CLOSE
			End If
		Case 2
			// NO - Allow the window to be closed without saving changes
			//-------Begin Added by Alfee 11.12.2007-----------------------
			//<$Reason>Synchronize the add clause rules data if modified
			IF ib_newrules THEN Post f_sync_addclause_rules(il_template_id )
			//-------End Added --------------------------------------------
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE
end event

event pfc_preopen;call super::pfc_preopen;long ll_i
string ls_scale

This.of_SetResize(True)

This.inv_resize.of_SetOrigSize (This.workspacewidth(),This.workspaceheight())
ls_scale = this.inv_resize.scale

For ll_i =  1 To upperbound(This.CONTrol)
   This.inv_resize.of_Register (This.CONTrol[ll_i],ls_scale)
Next


end event

event resize;call super::resize;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007-05-11 By: Wu ZhiJun
//$<reason> Fix a bug
if sizetype = 1 then 		//ZE_MINIMIZED)
	ib_Minimized = true
	return
else
	ib_Minimized = false
end if

if ib_Minimized = true then
	return
end if
//--------------------------- APPEON END -----------------------------


of_resize(false)

If cb_fresize.Text = '[-]' Then//added by gavins 20120717
	of_ReszieClauseformula( true )
ElseIf cb_fresize.Text = '[+]' Then
	of_ReszieClauseformula( false )
End If


environment	 lenv_obj  //added by gavins 20130227
If GetEnvironment (lenv_obj) = 1 Then
	If lenv_obj.screenheight <= 650 then
		this.height =  pixelstounits( 560, Ypixelstounits! )
		
	end if
	
	If lenv_obj.screenwidth <=800 then
		this.width =  pixelstounits( 760, Xpixelstounits! )
	end if
end if
end event

event activate;call super::activate;//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(ole_1 ) Then
	ole_1.object.activate(true)
End If
end event

event deactivate;call super::deactivate;//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(ole_1 ) Then
//	ole_1.object.activate(false)
//End If
end event

event pfc_postopen;call super::pfc_postopen;
//Begin - Added By Mark Lee 09/25/12
If cbx_preview.checked = True Then
		wf_set_visible(True)	
Else
		wf_set_visible(False)	
End If
//End - Added By Mark Lee 09/25/12
end event

type ole_1 from u_email_edit within w_agreement_template_add_clause
integer x = 1897
integer y = 784
integer width = 2446
integer height = 776
integer taborder = 110
string binarykey = "w_agreement_template_add_clause.win"
end type

event constructor;call super::constructor;this.object.menubar(false)
this.object.toolbars( false )
this.object.TitleBar( false )
end event

type cb_fresize from commandbutton within w_agreement_template_add_clause
integer x = 4329
integer y = 1640
integer width = 69
integer height = 60
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "[+]"
end type

event clicked;If this.Text = '[+]' Then
	of_ReszieClauseformula( true )
Else
	of_ReszieClauseformula( false )
End If


end event

type st_hspitbar1 from u_st_splitbar within w_agreement_template_add_clause
integer x = 1870
integer y = 1592
integer width = 2496
integer height = 16
end type

event lbuttonup;call super::lbuttonup;cb_fresize.y = gb_3.y - 2

ole_1.SetRedraw( true)
end event

type dw_formula from u_dw_ctx_find within w_agreement_template_add_clause
integer x = 1902
integer y = 1704
integer width = 2446
integer height = 1052
integer taborder = 90
string dataobject = "d_template_clause_rules_display"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.Post Event ue_init_screen_dddw(gi_contract_view_id)		//Added by Scofield on 2010-01-20

end event

event retrieveend;call super::retrieveend;//BEGIN---Modify by Scofield on 2010-03-01
long		ll_View_id

if RowCount > 0 then
	ll_View_id = This.GetItemNumber(RowCount,"data_view_id")
	This.Trigger Event ue_init_screen_dddw(ll_View_id)
end if
//END---Modify by Scofield on 2010-03-01

end event

type st_vsplitbar from u_st_splitbar within w_agreement_template_add_clause
integer x = 1646
integer width = 23
integer height = 2780
end type

event lbuttonup;call super::lbuttonup;cb_Move_Down.X  = This.X + 41
cb_Move_Up.X    = This.X + 41
cb_Move_Left.X  = This.X + 41
cb_Move_Right.X = This.X + 41
cbx_Preview.X   = This.X + 228

end event

type cb_rules from commandbutton within w_agreement_template_add_clause
integer x = 3218
integer y = 648
integer width = 361
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Dynamic Add"
end type

event clicked;//Added by Alfee 11.12.2007
Long ll_clauseid, ll_row, ll_rulecnt

ll_row = dw_selected.GetRow() 
IF Not ll_row > 0 THEN RETURN

ll_clauseid = dw_selected.GetItemNumber(ll_row, 'ctx_acp_clause_id')
IF Not ll_clauseid > 0 THEN RETURN

//Open the add rules window
OpenwithParm(w_agreement_template_clause_rules, String(il_template_id) + "|" + String(ll_clauseid))

//Refresh the selected clause
ll_rulecnt = Message.doubleparm
IF ll_rulecnt >= 0 THEN //OK operation
	//--------Begin Modified by Alfee 01.02.2008------------------------
	dwItemStatus l_status
	l_status = dw_selected.GetItemStatus(ll_row, 0, Primary!)

	dw_selected.SetItem(ll_row, "sum_rules", ll_rulecnt)
	dw_selected.AcceptText()	

	IF l_status = NotModified! THEN dw_selected.SetItemStatus(ll_row, 0, Primary!, l_status)
	//dw_selected.SetItem(ll_row, "sum_rules", ll_rulecnt)
	//dw_selected.AcceptText()	
	//--------End Modified -----------------------------------------------
	//refresh the clause rules' count in ids_clause_rulecnt
	of_store_clause_rulecnt()
	
	of_RefreshClauseRules()
END IF

//for performance of cancel operation
IF ll_rulecnt > 0 THEN ib_newrules = TRUE 

end event

type cbx_preview from checkbox within w_agreement_template_add_clause
integer x = 1874
integer y = 644
integer width = 530
integer height = 92
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Clause &Preview"
end type

event clicked;boolean lb_rtn
string ls_filename

//Added by Ken.Guo on 2008-11-06	
If gnv_reg_ocx.of_check_ocx( 1,'', True) <> '' Then //1: office 
	This.checked = False
	Return 0
End If	

//Check whether this file is already opened
//ls_filename = is_agreement_path + "clause_" + string(il_clause_id) + ".doc"
ls_filename = inv_clause.of_generate_name( il_clause_id ) //Modified By Ken.Guo 2010-01-18
lb_rtn = of_fileopened(ls_filename)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 21-03-2007 By: Ken.Guo
//$<reason> Add new requirement. Need auto resize dw_selected when checked cbx_preview
of_resize(false)
//--------------------------- APPEON END -----------------------------

//open or close the clause file according to preview checkbox
if not cbx_preview.checked then //Prevent preview
	if lb_rtn then 
		ole_1.object.close()
		is_current_file = ""
	end if		
	//Added By Mark Lee 09/24/12
	wf_set_visible(False)
	
else //Allow preview
	//Added By Mark Lee 09/24/12
	wf_set_visible(True)
	if not lb_rtn then 	
		openwithparm( w_appeon_gifofwait, "Opening selected document..." )		
		
		//Get or Generate local clause file 
		of_get_clause_file(il_clause_id,idt_modify_date)		
		//Open the file in clause preview
		of_displayfile(ls_filename)
		
		if isvalid( w_appeon_gifofwait) then close(w_appeon_gifofwait)	
	end if
end if
end event

type tab_1 from u_tab_agreement_template_clause within w_agreement_template_add_clause
integer y = 4
integer width = 1627
integer height = 2760
integer taborder = 10
string pointer = "Arrow!"
end type

event selectionchanged;call super::selectionchanged;of_display_properties()
end event

type cb_move_down from commandbutton within w_agreement_template_add_clause
integer x = 1687
integer y = 436
integer width = 146
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Dn"
end type

event clicked;parent.event pfc_cst_move_down()
end event

type cb_move_up from commandbutton within w_agreement_template_add_clause
integer x = 1687
integer y = 344
integer width = 146
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Up"
end type

event clicked;parent.event pfc_cst_move_up()
end event

type cb_move_left from commandbutton within w_agreement_template_add_clause
integer x = 1687
integer y = 204
integer width = 146
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<<"
end type

event clicked;parent.event pfc_cst_move_left()
end event

type cb_move_right from commandbutton within w_agreement_template_add_clause
integer x = 1687
integer y = 112
integer width = 146
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">>"
end type

event clicked;parent.event pfc_cst_move_right(0)
end event

type gb_1 from groupbox within w_agreement_template_add_clause
integer x = 1874
integer y = 52
integer width = 2496
integer height = 576
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Selected Clauses"
end type

type gb_2 from groupbox within w_agreement_template_add_clause
integer x = 1874
integer y = 736
integer width = 2496
integer height = 848
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Clause Preview"
end type

type cb_cancel from commandbutton within w_agreement_template_add_clause
integer x = 4027
integer y = 648
integer width = 343
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_selected from u_dw within w_agreement_template_add_clause
event ue_lmousemove pbm_mousemove
event ue_dwnmousemove pbm_dwnmousemove
integer x = 1902
integer y = 108
integer width = 2437
integer height = 492
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_agreement_template_clause_selected"
boolean hscrollbar = true
boolean ib_rmbfocuschange = false
end type

event ue_lmousemove;//////////////////////////////////////////////////////////////////////
// $<event>ue_lmousemovedw_selected()
// $<arguments>
//		value	unsignedlong	flags		
//		value	integer     	xpos 		
//		value	integer     	ypos 		
// $<returns> long
// $<description>If left mouse button is down and user moves the mouse, 
// $<description>initiate drag mode.
//////////////////////////////////////////////////////////////////////
// $<add> 12.12.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
if ib_mouse_ldown and this.RowCount() > 0 then
	this.Drag (begin!)
end if


end event

event ue_dwnmousemove;//====================================================================
// Event: ue_dwnmousemove
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                xpos
//                ypos
//                row
//                dwo
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 09/25/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
if ib_mouse_ldown and this.RowCount() > 0 then
	this.Drag (begin!)
end if

end event

event rowfocuschanged;call super::rowfocuschanged;if ib_refresh then 
	parent.event pfc_cst_rowfocuschanged()
end if

of_RefreshClauseRules()

end event

event constructor;call super::constructor;of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)

end event

event doubleclicked;call super::doubleclicked;parent.post event pfc_cst_move_left()
end event

event dragdrop;call super::dragdrop;Long ll_row
if classname(source) = "tv_1" then
	If row = 0 Then
		ll_row = This.Rowcount() + 1
	Else
		ll_row = row
	End If
	parent.event pfc_cst_move_right(ll_row)
Elseif classname(source) = 'dw_selected' Then
	of_drop_clause_list(dw_selected.getrow() ,row)
end if
end event

event clicked;call super::clicked;
//----------Begin Modified by Alfee 11.12.2007--------------
IF dwo.name = "p_rules" THEN 
	ib_mouse_ldown = FALSE //prevent drag mode
	cb_rules.event clicked()
ELSE
	this.DragIcon = "droparrow.ico"
END IF
//this.DragIcon = "row.ico"
//----------End Added -----------------------------------

end event

event lbuttonup;call super::lbuttonup;ib_mouse_ldown = false
end event

event lbuttondown;call super::lbuttondown;ib_mouse_ldown = true
end event

event getfocus;call super::getfocus;of_RefreshClauseRules()

end event

type gb_3 from groupbox within w_agreement_template_add_clause
integer x = 1874
integer y = 1632
integer width = 2496
integer height = 1136
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Dynamic Clause Formula"
end type

type cb_add from commandbutton within w_agreement_template_add_clause
integer x = 3579
integer y = 648
integer width = 448
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update Template"
end type

event clicked;integer li_rtn

openwithparm(w_appeon_gifofwait, "merging clauses to template...")

li_rtn = of_add_clause_file()

if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

if li_rtn = 1 then close(parent)


////preview the template file
//if isvalid(w_agreement_template_painter)  then
//	w_agreement_template_painter.post event pfc_cst_preview_template()
//end if




	













end event

type cb_resize from commandbutton within w_agreement_template_add_clause
integer x = 4334
integer y = 744
integer width = 69
integer height = 60
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "[+]"
end type

event clicked;of_resize(true)

//Parent.setredraw(false)
//
//If this.text = '[+]' Then
//	this.text = '[-]' 
//   gb_2.x = 5
//	gb_2.y = 0
//	gb_2.width = parent.width - 65
//	gb_2.height = parent.height - 115
//	ole_1.x = gb_2.x + 32
//	ole_1.y = gb_2.y + 55
//	ole_1.width = gb_2.width - 60
//	ole_1.height = gb_2.height - 90
//	this.x = gb_2.x + gb_2.width - 55
//	this.y = gb_2.y - 4
//	tab_1.visible = false
//	cb_cancel.visible = false
//	gb_1.visible = false
//	dw_selected.visible = false
//	cbx_preview.visible = false
//	ole_1.bringtotop = true
//	this.bringtotop = true
//	ole_1.setfocus()
//Else
//	this.text = '[+]'
//	gb_2.x = gb_1.x
//	gb_2.y = cb_cancel.y	+ cb_cancel.height
//	gb_2.width = gb_1.width
//	gb_2.height = tab_1.y + tab_1.height - gb_2.y
//   ole_1.x = gb_2.x + 32
//	ole_1.y = gb_2.y + 52
//	ole_1.width = gb_2.width - 59
//	ole_1.height = gb_2.height - 76
//	this.x = gb_2.x + gb_2.width - 36
//	this.y = gb_2.y - 2
//	tab_1.visible = true
//	cb_cancel.visible = true
//	gb_1.visible = true
//	dw_selected.visible = true
//	cbx_preview.visible = true
//	ole_1.bringtotop = true	
//	this.bringtotop = true
//	ole_1.setfocus()
//End If
//
//Parent.setredraw(true)
//
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_agreement_template_add_clause.bin 
2D00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000008f22706001d16e4600000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000008f22706001d16e468f22706001d16e460000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd0000374b0000140d00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd0000374b0000140d00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_agreement_template_add_clause.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
