$PBExportHeader$w_export_painter.srw
forward
global type w_export_painter from w_sheet
end type
type cb_store from commandbutton within w_export_painter
end type
type p_1 from picture within w_export_painter
end type
type sle_rep from singlelineedit within w_export_painter
end type
type sle_tc from singlelineedit within w_export_painter
end type
type sle_tt from singlelineedit within w_export_painter
end type
type cb_2 from commandbutton within w_export_painter
end type
type gb_1 from groupbox within w_export_painter
end type
type cb_new from u_cb within w_export_painter
end type
type tab_1 from tab within w_export_painter
end type
type tabpage_export_hdr from userobject within tab_1
end type
type dw_export_file from u_dw within tabpage_export_hdr
end type
type tabpage_export_hdr from userobject within tab_1
dw_export_file dw_export_file
end type
type tabpage_field_data from userobject within tab_1
end type
type cb_batch_del from commandbutton within tabpage_field_data
end type
type cb_quick from commandbutton within tabpage_field_data
end type
type cbx_autosave from checkbox within tabpage_field_data
end type
type dw_fld_list from u_dw within tabpage_field_data
end type
type dw_detail from u_dw within tabpage_field_data
end type
type cb_add from u_cb within tabpage_field_data
end type
type cb_delete_col from u_cb within tabpage_field_data
end type
type cb_insert from u_cb within tabpage_field_data
end type
type cb_1 from commandbutton within tabpage_field_data
end type
type cb_reorder from commandbutton within tabpage_field_data
end type
type cb_copy from commandbutton within tabpage_field_data
end type
type st_next from statictext within tabpage_field_data
end type
type cb_4 from commandbutton within tabpage_field_data
end type
type st_1 from statictext within tabpage_field_data
end type
type mle_1 from multilineedit within tabpage_field_data
end type
type tabpage_field_data from userobject within tab_1
cb_batch_del cb_batch_del
cb_quick cb_quick
cbx_autosave cbx_autosave
dw_fld_list dw_fld_list
dw_detail dw_detail
cb_add cb_add
cb_delete_col cb_delete_col
cb_insert cb_insert
cb_1 cb_1
cb_reorder cb_reorder
cb_copy cb_copy
st_next st_next
cb_4 cb_4
st_1 st_1
mle_1 mle_1
end type
type tab_1 from tab within w_export_painter
tabpage_export_hdr tabpage_export_hdr
tabpage_field_data tabpage_field_data
end type
type cb_save from u_cb within w_export_painter
end type
type cb_quit from u_cb within w_export_painter
end type
type cb_auto from commandbutton within w_export_painter
end type
type cb_test from commandbutton within w_export_painter
end type
type cb_delete from u_cb within w_export_painter
end type
type st_field1 from statictext within w_export_painter
end type
type cbx_savedata from checkbox within w_export_painter
end type
type cbx_open from checkbox within w_export_painter
end type
type dw_select from datawindow within w_export_painter
end type
type cbx_previewdata from checkbox within w_export_painter
end type
type st_field from statictext within w_export_painter
end type
type dw_screen from u_dw within w_export_painter
end type
type dw_audit from u_dw within w_export_painter
end type
end forward

global type w_export_painter from w_sheet
integer x = 0
integer y = 0
integer width = 3634
integer height = 2416
string title = "Export Setup"
long backcolor = 33551856
cb_store cb_store
p_1 p_1
sle_rep sle_rep
sle_tc sle_tc
sle_tt sle_tt
cb_2 cb_2
gb_1 gb_1
cb_new cb_new
tab_1 tab_1
cb_save cb_save
cb_quit cb_quit
cb_auto cb_auto
cb_test cb_test
cb_delete cb_delete
st_field1 st_field1
cbx_savedata cbx_savedata
cbx_open cbx_open
dw_select dw_select
cbx_previewdata cbx_previewdata
st_field st_field
dw_screen dw_screen
dw_audit dw_audit
end type
global w_export_painter w_export_painter

type variables
long il_export_id
Integer il_table_id
integer testcnt
long il_recid
Boolean lb_insert = False

Boolean lb_new = False

//<add> andy 2007.06.04
Boolean ib_lockcol = True
//end of add
boolean ib_readonly = false //maha 02.05.2015

//==============================APPEON BEGIN==========================
// $<Added>:   Date: Nov 01,2007       Author:Nova
//--------------------------------------------------------------------
// $<reason>   Fix a defect.
int ii_win_width, ii_win_height, ii_win_frame_w, ii_win_frame_h
str_size size_ctrl [] 
long il_tabpage1
//Boolean variable to stop recursion
boolean ib_exec = false
//==============================APPEON END============================

//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
long il_view_id 	//08.07.2009
boolean  ib_reset_dddw_of_lufieldname//(Appeon)Toney 06.21.2013 - V141 ISG-CLX  mark whether reset the drop-down data of lu_filed_name field 
//---------End Added ------------------------------------------------------------------

end variables

forward prototypes
public function long of_get_id ()
public subroutine of_ctx_add_scrn ()
public subroutine of_ctx_generate_linktocolumn (string dwoname, string data, integer row)
public subroutine of_set_lookup_dddw ()
public subroutine of_setui (long al_exporttype)
public function long of_check ()
public subroutine of_updatehistorydata ()
public function integer wf_size_it ()
public function integer wf_resize_it (double size_factor)
public function integer of_enabledfacilityprop (boolean ab_setnull)
public function integer of_check_exportid (integer ai_exportid)
public function integer of_check_field_name (string as_field)
public subroutine of_set_dddw (ref datawindowchild dwchild, string as_dataobject)
public function string of_get_coltype (ref datastore ads_object, string as_name)
public function integer of_restore_lookupfieldname ()
public function boolean of_field_name_check (string as_fieldname)
public function string of_build_alias (string as_label)
public subroutine of_resize ()
public function integer of_security (integer ai_level)
end prototypes

public function long of_get_id ();long rec

select max(rec_id) into :rec from export_fields; 
if isnull(rec) then rec = 0  //Start Code Change ---- 06.06.2006 #515 maha  trap if no fields exist
rec++

return rec 
end function

public subroutine of_ctx_add_scrn ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-13 By: Rodger Wu

datawindowchild ldwc_screen
integer li_inserted
Long ll_ctx_linkscrnid, li_found

tab_1.tabpage_field_data.dw_detail.GetChild( "export_fields_ctx_scrn_id", ldwc_screen )

li_found = ldwc_screen.Find( "screen_id = 2001", 1, ldwc_screen.rowcount() )
if li_found < 1 then
	li_inserted = ldwc_screen.insertrow( 0 )
	ldwc_screen.SetItem( li_inserted, "screen_name", "Contacts->Detail" )
	ldwc_screen.SetItem( li_inserted, "screen_id", 2001 )
	ldwc_screen.SetItem( li_inserted, "dataobject", "d_cntx_master" )
end if

li_found = ldwc_screen.Find( "screen_id = 2002", 1, ldwc_screen.rowcount() )
if li_found < 1 then
	li_inserted = ldwc_screen.insertrow( 0 )
	ldwc_screen.SetItem( li_inserted, "screen_name", "Contacts->Phone Numbers" )
	ldwc_screen.SetItem( li_inserted, "screen_id", 2002 )
	ldwc_screen.SetItem( li_inserted, "dataobject", "d_cntx_phone" )
end if

li_found = ldwc_screen.Find( "screen_id = 2003", 1, ldwc_screen.rowcount() )
if li_found < 1 then
	li_inserted = ldwc_screen.insertrow( 0 )
	ldwc_screen.SetItem( li_inserted, "screen_name", "Company->Detail" )
	ldwc_screen.SetItem( li_inserted, "screen_id", 2003 )
	ldwc_screen.SetItem( li_inserted, "dataobject", "d_facility_detail" )
end if

//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
//Start Add by jervis 03.20.2009	
//Export Contract Status track data
li_found = ldwc_screen.Find( "screen_id = 2004", 1, ldwc_screen.rowcount() )
if li_found < 1 then
	li_inserted = ldwc_screen.insertrow( 0 )
	ldwc_screen.SetItem( li_inserted, "screen_name", "Contract Status Track" )
	ldwc_screen.SetItem( li_inserted, "screen_id", 2004 )
	ldwc_screen.SetItem( li_inserted, "dataobject", "d_export_status_track" )
end if
//End by jervis 03.20.2009

ldwc_screen.Sort( )
//---------End Added ------------------------------------------------------------------
//---------Begin Added by (Appeon)Toney 11.08.2013 for V141 ISG-CLX--------
//$Reason:Fixed Bug #3733 - Can't select fields from Requirements->Profile Selection screen in Export
ldwc_screen.SetFilter("screen_id<>11")
ldwc_screen.Filter( )
//---------End Added ------------------------------------------------------------------

end subroutine

public subroutine of_ctx_generate_linktocolumn (string dwoname, string data, integer row);//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
  /*
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-12-13 By: Rodger Wu (architecture)
	
	datastore lds_ctx
	datawindowchild ldwc_ctxscrn, ldwc_fields
	string ls_table, ls_colname, ls_dbname, ls_temp, ls_label, ls_dataobject
	integer li_found, li_cols, i, li_inserted, li_getrow
	
	tab_1.tabpage_field_data.dw_detail.GetChild( dwoname, ldwc_ctxscrn )
	li_found = ldwc_ctxscrn.Find( "screen_id = " + string( data ), 1, ldwc_ctxscrn.rowcount() )
	if li_found > 0 then
		ls_dataobject = ldwc_ctxscrn.GetItemString( li_found, "dataobject" )
		tab_1.tabpage_field_data.dw_detail.GetChild( "export_fields_ctx_linktocolumn", ldwc_fields )
		ldwc_fields.reset()
	
		lds_ctx = create datastore
		lds_ctx.dataobject = ls_dataobject
		
		ls_table = lower( lds_ctx.Describe( "Datawindow.table.updatetable" ) )
		li_cols = integer( lds_ctx.Describe( "DataWindow.Column.Count" ) )
	
		if row > 0 then
			tab_1.tabpage_field_data.dw_detail.SetItem( row, "export_fields_ctx_linktoscrndw", ls_dataobject )
		end if
		
		for i = 1 to li_cols
			ls_dbname = lower( lds_ctx.Describe("#"+string( i ) + ".dbname") )
			ls_temp = f_get_token( ls_dbname, '.' )
	
			ls_colname = lower( lds_ctx.Describe("#"+string( i ) + ".name") )
			ls_label = lds_ctx.Describe( ls_colname + "_t.text")
			if ls_label = "?" or ls_label = "!" then ls_label = ""
			if ls_label = '' then ls_label = ls_dbname
			
			if ls_temp = ls_table then
				li_inserted = ldwc_fields.insertrow( 0 )
				ldwc_fields.setitem( li_inserted, "field_name", ls_colname )
				ldwc_fields.setitem( li_inserted, "field_name_alias", ls_label )
			end if
		next
	
	end if
	//---------------------------- APPEON END ----------------------------
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 08.23.2007 By: Evan
	//$<Reason> Need to destroy object.
	if IsValid(lds_ctx) then Destroy lds_ctx
	//---------------------------- APPEON END ----------------------------      
  */
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-13 By: Rodger Wu (architecture)
datawindowchild ldwc_ctxscrn, ldwc_fields
string ls_table, ls_colname, ls_dbname, ls_temp, ls_label, ls_dataobject
integer li_found, li_cols, i, li_inserted, li_getrow
string ls_tab_name,ls_dw_name[]
datawindow ldw[]
string ls_dataobjects[]

tab_1.tabpage_field_data.dw_detail.GetChild( dwoname, ldwc_ctxscrn )
li_found = ldwc_ctxscrn.Find( "screen_id = " + string( data ), 1, ldwc_ctxscrn.rowcount() )
if li_found > 0 then
	tab_1.tabpage_field_data.dw_detail.GetChild( "export_fields_ctx_linktocolumn", ldwc_fields )
	ldwc_fields.SetFilter("field_screen = " + string(data))
	ldwc_fields.Filter( )
	ls_dataobject = ldwc_ctxscrn.GetItemString( li_found, "dataobject" )


	if row > 0 then
		tab_1.tabpage_field_data.dw_detail.SetItem( row, "export_fields_ctx_linktoscrndw", ls_dataobject )
	end if
	
	if ldwc_fields.RowCount() < 1 then   
		//dw_screen = create u_dw		
		//Dynamic generate dddw base on view -- jervis 08.06.2009
		dw_screen.dataobject = ls_dataobject
		if long(data) < 1000 then	
			ls_tab_name = gnv_data.of_get_table_name( long(data), 'C', 'tab_name')
	
			ldw[1] = dw_screen
			
			ls_dw_name[1] 		= gnv_data.of_get_table_name( long(data), 'C', 'dw_name')
			ls_dataobjects[1] 	= ls_dataobject //gnv_data.of_get_table_name( long(data), 'C', 'dataobject')
			
			f_create_contract_dw(il_view_id,ls_tab_name,ldw,ls_dw_name,ls_dataobjects)
		end if
		ls_table = lower( dw_screen.Describe( "Datawindow.table.updatetable" ) )
		li_cols = integer( dw_screen.Describe( "DataWindow.Column.Count" ) )


		for i = 1 to li_cols
			ls_dbname = lower( dw_screen.Describe("#"+string( i ) + ".dbname") )
			ls_temp = f_get_token( ls_dbname, '.' )
	
			ls_colname = lower( dw_screen.Describe("#"+string( i ) + ".name") )
			ls_label = dw_screen.Describe( ls_colname + "_t.text")
			if ls_label = "?" or ls_label = "!" then ls_label = ""
			if ls_label = '' then ls_label = ls_dbname
			
			if ls_temp = ls_table then
				li_inserted = ldwc_fields.insertrow( 0 )
				ldwc_fields.setitem( li_inserted, "field_name", ls_colname )
				ldwc_fields.setitem( li_inserted, "field_name_alias", ls_label )
				ldwc_fields.setitem( li_inserted, "field_screen", ls_colname )
			end if
		next
	end if
end if
//---------------------------- APPEON END ----------------------------

//---------End Modfiied ------------------------------------------------------------------

end subroutine

public subroutine of_set_lookup_dddw ();//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
  /*
		//////////////////////////////////////////////////////////////////////
		// $<function>w_export_painterof_set_lookup_dddw()
		// $<arguments>
		//		value	integer		
		// $<returns> (none)
		// $<description>
		// $<description>
		//////////////////////////////////////////////////////////////////////
		// $<add> 03.20.2007 by Jack (Export)
		//////////////////////////////////////////////////////////////////////
		string ls_ctx_column_name,ls_ctx_lookup_type
		string ls_field_name[],ls_field_name1
		String ls_dataType[]//<add> andy 2007.06.01
		long i,ll_row,ll_find
		datawindowchild dwchild
		tab_1.tabpage_field_data.dw_detail.accepttext()
		ls_ctx_column_name = tab_1.tabpage_field_data.dw_detail.getitemstring(tab_1.tabpage_field_data.dw_detail.getrow(),'export_fields_ctx_column_name')
		ls_ctx_lookup_type = tab_1.tabpage_field_data.dw_detail.getitemstring(tab_1.tabpage_field_data.dw_detail.getrow(),'export_fields_ctx_lookup_type')
		
		If ls_ctx_column_name = 'app_facility' And ls_ctx_lookup_type = 'C' Then
			tab_1.tabpage_field_data.dw_detail.modify("t_10.text = 'Company Table Field:'")
			tab_1.tabpage_field_data.dw_detail.getchild("lu_field_name",dwchild)
			dwchild.reset()
			ls_field_name[1] = 'company_id'
			ls_field_name[2] = 'facility_name'
			ls_field_name[3] = 'street'
			ls_field_name[4] = 'street_2'
			ls_field_name[5] = 'city'
			ls_field_name[6] = 'state'
			ls_field_name[7] = 'zip'
			ls_field_name[8] = 'phone'
			ls_field_name[9] = 'ext'
			ls_field_name[10] = 'fax'
			ls_field_name[11] = 'contact'
			ls_field_name[12] = 'web_address'
			ls_field_name[13] = 'email_address'
		
			//<add> andy 2007.06.01 
			//corresponding data type 
			ls_dataType[1]='N'
			ls_dataType[2]='S' 
			ls_dataType[3]='S'
			ls_dataType[4]='S'
			ls_dataType[5]='S'
			ls_dataType[6]='S'
			ls_dataType[7]='S'
			ls_dataType[8]='S'
			ls_dataType[9]='S'
			ls_dataType[10]='S'
			ls_dataType[11]='S'
			ls_dataType[12]='S'
			ls_dataType[13]='S'
			//end of add
			
			For i = 1 To upperbound(ls_field_name)
				ll_row = dwchild.insertrow(0)
				ls_field_name1 = ls_field_name[i]
				dwchild.setitem(ll_row,'field_name',ls_field_name1)
				//<add> andy 2007.06.01 
				//save data type to dwchild
				dwchild.setitem(ll_row,'datatype',ls_dataType[i])
				//end of add
			Next
			tab_1.tabpage_field_data.dw_detail.getchild("export_fields_ctx_column_name",dwchild)
			ll_find = dwchild.find("field_name = 'app_facility'",1,dwchild.rowcount())
			If ll_find > 0 Then
				dwchild.setitem(ll_find,'field_name_alias','Company ID')
			End If
		ElseIf ls_ctx_column_name = 'contact_id' And ls_ctx_lookup_type = 'C' Then
			tab_1.tabpage_field_data.dw_detail.modify("t_10.text = 'Contact Table Field:'")
			tab_1.tabpage_field_data.dw_detail.getchild("lu_field_name",dwchild)
			dwchild.reset()
			ls_field_name[1] = 'contact_id'
			ls_field_name[2] = 'first_name'
			ls_field_name[3] = 'last_name'
			ls_field_name[4] = 'middle_name'
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 05.29.2007 By: Jack
			//$<reason> Fix a defect.
			/*
			ls_field_name[5] = 'street_1'
			ls_field_name[6] = 'street_2'
			ls_field_name[7] = 'street_3'
			ls_field_name[8] = 'city'
			ls_field_name[9] = 'zip'
			ls_field_name[10] = 'user_d'
			*/
			ls_field_name[5] = 'contact_department'
			ls_field_name[6] = 'contact_title'
			ls_field_name[7] = 'contact_type'
			ls_field_name[8] = 'user_d'
			//Add by Jack 06/05/2007
			ls_field_name[9] = 'phone'
			ls_field_name[10] = 'ext'
			ls_field_name[11] = 'contact_email'
			
			//---------------------------- APPEON END ----------------------------
			
			//<add> andy 2007.06.01 
			ls_dataType[1]='N'
			ls_dataType[2]='S' 
			ls_dataType[3]='S'
			ls_dataType[4]='S'
			ls_dataType[5]='S'
			ls_dataType[6]='S'
			ls_dataType[7]='S'
			ls_dataType[8]='S'
			ls_dataType[9]='S'
			ls_dataType[10]='S'
			ls_dataType[11]='S'
			//end of add
			
			For i = 1 To upperbound(ls_field_name)
				ll_row = dwchild.insertrow(0)
				ls_field_name1 = ls_field_name[i]
				dwchild.setitem(ll_row,'field_name',ls_field_name1)
				//<add> andy 2007.06.01 
				//save data type to dwchild
				dwchild.setitem(ll_row,'datatype',ls_dataType[i])
				//end of add
			Next
		Else
			tab_1.tabpage_field_data.dw_detail.modify("t_10.text = 'Lookup Table Field:'")
			tab_1.tabpage_field_data.dw_detail.getchild("lu_field_name",dwchild)
			dwchild.reset()
			ls_field_name[1] = 'Lookup Code'
			ls_field_name[2] = 'Code'
			ls_field_name[3] = 'description'
			ls_field_name[4] = 'Entity_Name'
			ls_field_name[5] = 'Street1'
			ls_field_name[6] = 'Street2'
			ls_field_name[7] = 'City'
			ls_field_name[8] = 'State'
			ls_field_name[9] = 'Zip'
			ls_field_name[10] = 'County'
			ls_field_name[11] = 'Country'
			ls_field_name[12] = 'contact_name'
			ls_field_name[13] = 'Custom_1'
			ls_field_name[14] = 'Custom_2'
			ls_field_name[15] = 'Custom_3'
			ls_field_name[16] = 'Custom_4'
			ls_field_name[17] = 'Custom_5'
			ls_field_name[18] = 'Custom_6'
			ls_field_name[19] = 'large_description_1'		//Added by Scofield on 2007-06-12
			ls_field_name[20] = 'large_description_2'		//Added by Scofield on 2007-06-12
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2008-01-15 By: Scofield
			//$<Reason> Add ten columns.
		
			ls_field_name[21] = 'money_1'
			ls_field_name[22] = 'money_2'
			ls_field_name[23] = 'integer_1'
			ls_field_name[24] = 'integer_2'
			ls_field_name[25] = 'integer_3'
			ls_field_name[26] = 'integer_4'
			ls_field_name[27] = 'integer_5'					
			ls_field_name[28] = 'integer_6'
			ls_field_name[29] = 'integer_7'
			ls_field_name[30] = 'integer_8'
			ls_field_name[31] = 'datetime_1'
			ls_field_name[32] = 'datetime_2'
			//---------------------------- APPEON END ----------------------------
			//<add> andy 2007.06.01 
			ls_dataType[1]='N'
			ls_dataType[2]='S' 
			ls_dataType[3]='S'
			ls_dataType[4]='S'
			ls_dataType[5]='S'
			ls_dataType[6]='S'
			ls_dataType[7]='S'
			ls_dataType[8]='S'
			ls_dataType[9]='S'
			ls_dataType[10]='S'
			ls_dataType[11]='S'
			ls_dataType[12]='S'
			ls_dataType[13]='S'
			ls_dataType[14]='S'
			ls_dataType[15]='S'
			ls_dataType[16]='S'
			ls_dataType[17]='S'
			ls_dataType[18]='S'
			//end of add
			ls_dataType[19]='S'		//Added by Scofield on 2007-06-12
			ls_dataType[20]='S'		//Added by Scofield on 2007-06-12
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2008-01-15 By: Scofield
			//$<Reason> Add ten columns.
			ls_dataType[21]='N'
			ls_dataType[22]='N'
			ls_dataType[23]='N'
			ls_dataType[24]='N'
			ls_dataType[25]='N'
			ls_dataType[26]='N'
			ls_dataType[27]='N'
			ls_dataType[28]='N'
			ls_dataType[29]='N'
			ls_dataType[30]='N'
			ls_dataType[31]='D'
			ls_dataType[32]='D'
			//---------------------------- APPEON END ----------------------------
			
			For i = 1 To upperbound(ls_field_name)
				ll_row = dwchild.insertrow(0)
				ls_field_name1 = ls_field_name[i]
				dwchild.setitem(ll_row,'field_name',ls_field_name1)
				//<add> andy 2007.06.01 
				//save data type to dwchild
				dwchild.setitem(ll_row,'datatype',ls_dataType[i])
				//end of add
			Next
		End If      
  */
//////////////////////////////////////////////////////////////////////
// $<function>w_export_painterof_set_lookup_dddw()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.20.2007 by Jack (Export)
//////////////////////////////////////////////////////////////////////
string ls_ctx_column_name,ls_ctx_lookup_type
string ls_field_name[],ls_field_name1
String ls_dataType[]//<add> andy 2007.06.01
long i,ll_row,ll_find
datawindowchild dwchild
tab_1.tabpage_field_data.dw_detail.accepttext()
ls_ctx_column_name = tab_1.tabpage_field_data.dw_detail.getitemstring(tab_1.tabpage_field_data.dw_detail.getrow(),'export_fields_ctx_column_name')
ls_ctx_lookup_type = tab_1.tabpage_field_data.dw_detail.getitemstring(tab_1.tabpage_field_data.dw_detail.getrow(),'export_fields_ctx_lookup_type')

//If ls_ctx_column_name = 'app_facility' And ls_ctx_lookup_type = 'C' Then
//Add Company dddw process-- jervis 12.9.2009
If (ls_ctx_column_name = 'app_facility' And ls_ctx_lookup_type = 'C') or ls_ctx_lookup_type = "P" Then
	tab_1.tabpage_field_data.dw_detail.modify("t_10.text = 'Company Table Field:'")
	tab_1.tabpage_field_data.dw_detail.getchild("lu_field_name",dwchild)

	dwchild.reset()
	ib_reset_dddw_of_lufieldname = true//(Appeon)Toney 06.21.2013 - V141 ISG-CLX
	ls_field_name[1] = 'facility_id'
	ls_field_name[2] = 'facility_name'
	ls_field_name[3] = 'street'
	ls_field_name[4] = 'street_2'
	ls_field_name[5] = 'city'
	ls_field_name[6] = 'state'
	ls_field_name[7] = 'zip'
	ls_field_name[8] = 'phone'
	ls_field_name[9] = 'ext'
	ls_field_name[10] = 'fax'
	ls_field_name[11] = 'contact'
	ls_field_name[12] = 'web_address'
	ls_field_name[13] = 'email_address'

	//<add> andy 2007.06.01 
	//corresponding data type 
	ls_dataType[1]='N'
	ls_dataType[2]='S' 
	ls_dataType[3]='S'
	ls_dataType[4]='S'
	ls_dataType[5]='S'
	ls_dataType[6]='S'
	ls_dataType[7]='S'
	ls_dataType[8]='S'
	ls_dataType[9]='S'
	ls_dataType[10]='S'
	ls_dataType[11]='S'
	ls_dataType[12]='S'
	ls_dataType[13]='S'
	//end of add
	
	For i = 1 To upperbound(ls_field_name)
		ll_row = dwchild.insertrow(0)
		ls_field_name1 = ls_field_name[i]
		dwchild.setitem(ll_row,'field_name',ls_field_name1)
		dwchild.setitem(ll_row,'field_display',ls_field_name1) // jervis 06.09.2009
		//<add> andy 2007.06.01 
      //save data type to dwchild
		dwchild.setitem(ll_row,'datatype',ls_dataType[i])
		//end of add
	Next
	tab_1.tabpage_field_data.dw_detail.getchild("export_fields_ctx_column_name",dwchild)
	ll_find = dwchild.find("field_name = 'app_facility'",1,dwchild.rowcount())
	If ll_find > 0 Then
		dwchild.setitem(ll_find,'field_name_alias','Company ID')
	End If
ElseIf ls_ctx_column_name = 'contact_id' And ls_ctx_lookup_type = 'C' Then
	tab_1.tabpage_field_data.dw_detail.modify("t_10.text = 'Contact Table Field:'")
	tab_1.tabpage_field_data.dw_detail.getchild("lu_field_name",dwchild)
	dwchild.reset()
	ib_reset_dddw_of_lufieldname = true//(Appeon)Toney 06.21.2013 - V141 ISG-CLX
	ls_field_name[1] = 'contact_id'
	ls_field_name[2] = 'first_name'
	ls_field_name[3] = 'last_name'
	ls_field_name[4] = 'middle_name'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.29.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	ls_field_name[5] = 'street_1'
	ls_field_name[6] = 'street_2'
	ls_field_name[7] = 'street_3'
	ls_field_name[8] = 'city'
	ls_field_name[9] = 'zip'
	ls_field_name[10] = 'user_d'
	*/
	ls_field_name[5] = 'contact_department'
	ls_field_name[6] = 'contact_title'
	ls_field_name[7] = 'contact_type'
	ls_field_name[8] = 'user_d'
	//Add by Jack 06/05/2007
	ls_field_name[9] = 'phone'
	ls_field_name[10] = 'ext'
	ls_field_name[11] = 'contact_email'
	
	//---------------------------- APPEON END ----------------------------
	
	//<add> andy 2007.06.01 
	ls_dataType[1]='N'
	ls_dataType[2]='S' 
	ls_dataType[3]='S'
	ls_dataType[4]='S'
	ls_dataType[5]='S'
	ls_dataType[6]='S'
	ls_dataType[7]='S'
	ls_dataType[8]='S'
	ls_dataType[9]='S'
	ls_dataType[10]='S'
	ls_dataType[11]='S'
	//end of add
	
	For i = 1 To upperbound(ls_field_name)
		ll_row = dwchild.insertrow(0)
		ls_field_name1 = ls_field_name[i]
		dwchild.setitem(ll_row,'field_name',ls_field_name1)
		dwchild.setitem(ll_row,'field_display',ls_field_name1) // jervis 06.09.2009
		//<add> andy 2007.06.01 
      //save data type to dwchild
		dwchild.setitem(ll_row,'datatype',ls_dataType[i])
		//end of add
	Next
//03.16.2009 by jervis 
//Export CTX Profile Table
elseif ls_ctx_column_name = 'ctx_req_profile_id' And ls_ctx_lookup_type = 'R' Then
	tab_1.tabpage_field_data.dw_detail.modify("t_10.text = 'Profile Table Field:'")
	tab_1.tabpage_field_data.dw_detail.getchild("lu_field_name",dwchild)
	dwchild.reset()
	ib_reset_dddw_of_lufieldname = true//(Appeon)Toney 06.21.2013 - V141 ISG-CLX
	ls_field_name[1] = 'rqmnt_name'
	ls_field_name[2] = 'rqmnt_description'
	ls_dataType[1]='S'
	ls_dataType[2]='S' 

	
	For i = 1 To upperbound(ls_field_name)
		ll_row = dwchild.insertrow(0)
		ls_field_name1 = ls_field_name[i]
		dwchild.setitem(ll_row,'field_name',ls_field_name1)
		dwchild.setitem(ll_row,'field_display',ls_field_name1) // jervis 06.09.2009
		dwchild.setitem(ll_row,'datatype',ls_dataType[i])
	Next
//--------------Start Code 06.09.2009 by jervis---------------
//Export Location
elseif ls_ctx_column_name = 'loc_id' and ls_ctx_lookup_type = "L" then
	tab_1.tabpage_field_data.dw_detail.modify("t_10.text = 'Location Table Field:'")
	tab_1.tabpage_field_data.dw_detail.getchild("lu_field_name",dwchild)
	dwchild.reset()
	ib_reset_dddw_of_lufieldname = true//(Appeon)Toney 06.21.2013 - V141 ISG-CLX
	of_Set_dddw(dwchild,"d_export_group_location")  // jervis 06.09.2009
//--------------End code---------------------------------------

//Export Parent Organization -- Jervis 06.23.2009
elseif ls_ctx_column_name = "parent_comp_id" and ls_ctx_lookup_type = "M" then
	tab_1.tabpage_field_data.dw_detail.modify("t_10.text = 'Parent Organization Field:'")
	tab_1.tabpage_field_data.dw_detail.getchild("lu_field_name",dwchild)
	dwchild.reset()
	ib_reset_dddw_of_lufieldname = true//(Appeon)Toney 06.21.2013 - V141 ISG-CLX
	of_Set_dddw(dwchild,"d_export_multi_group_location") 
Else
	tab_1.tabpage_field_data.dw_detail.modify("t_10.text = 'Lookup Table Field:'")
	tab_1.tabpage_field_data.dw_detail.getchild("lu_field_name",dwchild)
	dwchild.reset()
	ib_reset_dddw_of_lufieldname = true//(Appeon)Toney 06.21.2013 - V141 ISG-CLX
	//---------Begin Added by (Appeon)Harry 11.28.2014 for BugH102902 --------
	if ls_ctx_lookup_type = "C" then
		ls_field_name[1] = 'Lookup Code'
		ls_field_name[2] = 'Code'
		ls_field_name[3] = 'description'
		ls_field_name[4] = 'Custom_1'
		ls_field_name[5] = 'Custom_2'
		ls_field_name[6] = 'Custom_3'
		ls_field_name[7] = 'Custom_4'
		ls_field_name[8] = 'Custom_5'
		ls_field_name[9] = 'Custom_6'
		ls_field_name[10] = 'large_description_1'		//Added by Scofield on 2007-06-12
		ls_field_name[11] = 'large_description_2'		//Added by Scofield on 2007-06-12
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-01-15 By: Scofield
		//$<Reason> Add ten columns.
	
		ls_field_name[12] = 'money_1'
		ls_field_name[13] = 'money_2'
		ls_field_name[14] = 'integer_1'
		ls_field_name[15] = 'integer_2'
		ls_field_name[16] = 'integer_3'
		ls_field_name[17] = 'integer_4'
		ls_field_name[18] = 'integer_5'					
		ls_field_name[19] = 'integer_6'
		ls_field_name[20] = 'integer_7'
		ls_field_name[21] = 'integer_8'
		ls_field_name[22] = 'datetime_1'
		ls_field_name[23] = 'datetime_2'
		//---------------------------- APPEON END ----------------------------
		//<add> andy 2007.06.01 
		ls_dataType[1]='N'
		ls_dataType[2]='S' 
		ls_dataType[3]='S'
		ls_dataType[4]='S'
		ls_dataType[5]='S'
		ls_dataType[6]='S'
		ls_dataType[7]='S'
		ls_dataType[8]='S'
		ls_dataType[9]='S'
		//end of add
		ls_dataType[10]='S'		//Added by Scofield on 2007-06-12
		ls_dataType[11]='S'		//Added by Scofield on 2007-06-12
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-01-15 By: Scofield
		//$<Reason> Add ten columns.
		ls_dataType[12]='N'
		ls_dataType[13]='N'
		ls_dataType[14]='N'
		ls_dataType[15]='N'
		ls_dataType[16]='N'
		ls_dataType[17]='N'
		ls_dataType[18]='N'
		ls_dataType[19]='N'
		ls_dataType[20]='N'
		ls_dataType[21]='N'
		ls_dataType[22]='D'
		ls_dataType[23]='D'
	else
	//---------End Added ------------------------------------------------------
		ls_field_name[1] = 'Lookup Code'
		ls_field_name[2] = 'Code'
		ls_field_name[3] = 'description'
		ls_field_name[4] = 'Entity_Name'
		ls_field_name[5] = 'Street1'
		ls_field_name[6] = 'Street2'
		ls_field_name[7] = 'City'
		ls_field_name[8] = 'State'
		ls_field_name[9] = 'Zip'
		ls_field_name[10] = 'County'
		ls_field_name[11] = 'Country'
		ls_field_name[12] = 'contact_name'
		ls_field_name[13] = 'Custom_1'
		ls_field_name[14] = 'Custom_2'
		ls_field_name[15] = 'Custom_3'
		ls_field_name[16] = 'Custom_4'
		ls_field_name[17] = 'Custom_5'
		ls_field_name[18] = 'Custom_6'
		ls_field_name[19] = 'large_description_1'		//Added by Scofield on 2007-06-12
		ls_field_name[20] = 'large_description_2'		//Added by Scofield on 2007-06-12
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-01-15 By: Scofield
		//$<Reason> Add ten columns.
	
		ls_field_name[21] = 'money_1'
		ls_field_name[22] = 'money_2'
		ls_field_name[23] = 'integer_1'
		ls_field_name[24] = 'integer_2'
		ls_field_name[25] = 'integer_3'
		ls_field_name[26] = 'integer_4'
		ls_field_name[27] = 'integer_5'					
		ls_field_name[28] = 'integer_6'
		ls_field_name[29] = 'integer_7'
		ls_field_name[30] = 'integer_8'
		ls_field_name[31] = 'datetime_1'
		ls_field_name[32] = 'datetime_2'
		//---------------------------- APPEON END ----------------------------
		//<add> andy 2007.06.01 
		ls_dataType[1]='N'
		ls_dataType[2]='S' 
		ls_dataType[3]='S'
		ls_dataType[4]='S'
		ls_dataType[5]='S'
		ls_dataType[6]='S'
		ls_dataType[7]='S'
		ls_dataType[8]='S'
		ls_dataType[9]='S'
		ls_dataType[10]='S'
		ls_dataType[11]='S'
		ls_dataType[12]='S'
		ls_dataType[13]='S'
		ls_dataType[14]='S'
		ls_dataType[15]='S'
		ls_dataType[16]='S'
		ls_dataType[17]='S'
		ls_dataType[18]='S'
		//end of add
		ls_dataType[19]='S'		//Added by Scofield on 2007-06-12
		ls_dataType[20]='S'		//Added by Scofield on 2007-06-12
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-01-15 By: Scofield
		//$<Reason> Add ten columns.
		ls_dataType[21]='N'
		ls_dataType[22]='N'
		ls_dataType[23]='N'
		ls_dataType[24]='N'
		ls_dataType[25]='N'
		ls_dataType[26]='N'
		ls_dataType[27]='N'
		ls_dataType[28]='N'
		ls_dataType[29]='N'
		ls_dataType[30]='N'
		ls_dataType[31]='D'
		ls_dataType[32]='D'
		//---------------------------- APPEON END ----------------------------
	end if
	
	For i = 1 To upperbound(ls_field_name)
		ll_row = dwchild.insertrow(0)
		ls_field_name1 = ls_field_name[i]
		dwchild.setitem(ll_row,'field_name',ls_field_name1)
		dwchild.setitem(ll_row,'field_display',ls_field_name1) // jervis 06.09.2009
		//<add> andy 2007.06.01 
      //save data type to dwchild
		dwchild.setitem(ll_row,'datatype',ls_dataType[i])
		//end of add
	Next
End If
tab_1.tabpage_field_data.dw_detail.SetRedraw(true)
  
//---------End Modfiied ------------------------------------------------------------------

end subroutine

public subroutine of_setui (long al_exporttype);/*
Function  : of_setui(long al_exporttype) returns integer
Arguments :al_exporttype long //export type
describe  :Set UI base on export type
author    :andy 2007.05.23
*/
String ls_ctx_column,ls_color,ls_Modify
Long   ll_Row
u_dw   ldw_Temp

ldw_Temp = this.tab_1.tabpage_field_data.dw_detail
ls_color = ldw_Temp.Describe("DataWindow.Color")

choose case al_exporttype
	case 1,2
		ls_Modify = "filter_query.protect='0'~tfilter_query.Background.Color='16777215'~tfilter_wizard.enabled=true"+&
						"~tsort_by.protect='0'~tsort_by.Background.Color='16777215'"
		ldw_Temp.Modify(ls_Modify)
		this.tab_1.tabpage_field_data.cb_1.enabled = true
		this.tab_1.tabpage_field_data.st_1.Visible = false
		this.tab_1.tabpage_field_data.mle_1.Visible = false
		this.tab_1.tabpage_field_data.cb_4.Visible = false
		this.tab_1.tabpage_field_data.mle_1.text = ''
	case 3
		ls_Modify = "filter_query.protect='1'~tfilter_query.Background.Color='" +ls_color+"'~tfilter_wizard.enabled=false"+&
						"~tsort_by.protect='1'~tsort_by.Background.Color='"+ls_color+"'"
		ldw_Temp.Modify(ls_Modify)
		this.tab_1.tabpage_field_data.cb_1.enabled = false
		this.tab_1.tabpage_field_data.st_1.Visible = true
		this.tab_1.tabpage_field_data.mle_1.Visible = true
		this.tab_1.tabpage_field_data.cb_4.Visible = true

		ll_Row = this.tab_1.tabpage_field_data.dw_detail.GetRow()
		if ll_Row > 0 then
			ls_ctx_column = this.tab_1.tabpage_field_data.dw_detail.GetItemString(ll_Row,"export_fields_expression")
			if isnull(ls_ctx_column) then ls_ctx_column = ''
			this.tab_1.tabpage_field_data.mle_1.text = ls_ctx_column
		end if
	case else
		//do nothing
		
end choose

end subroutine

public function long of_check ();/************************************************
Function: of_check
describe:verify Calculation formula
return  :0 successful/-1 failed
author  : andy 2007.05.24
*************************************************/
Long    ll_Row,ll_Num,ll_Cnt
String  ls_Field,ls_Datatype,ls_Source,ls_Err,ls_ComputerField
boolean lb_flag = true
n_ds      lds_field
Long    ll_pos
pfc_n_cst_ai_export_apb  n_export
n_cst_string lnvo_string

if trim(tab_1.tabpage_field_data.mle_1.text)='' or isnull(tab_1.tabpage_field_data.mle_1.text) then
	messagebox(gnv_app.iapp_object.DisplayName,"NULL expression is not valid.")
	tab_1.tabpage_field_data.mle_1.setfocus( )
	return -1
end if

ls_Source = tab_1.tabpage_field_data.mle_1.text

n_export = CREATE pfc_n_cst_ai_export_apb

lds_field = Create n_ds
lds_field.DataObject = "d_export_fields"
lds_field.of_SetTransObject( SQLCA )
lds_field.Retrieve( il_export_id )

ll_Row = tab_1.tabpage_field_data.dw_detail.GetRow()
//filter current computer fields
if ll_Row > 0 then
	ls_ComputerField = tab_1.tabpage_field_data.dw_detail.GetItemString(ll_Row,"export_field_name")
	if isnull(ls_ComputerField) then ls_ComputerField = ''
	lds_field.setFilter("export_field_name<>'" + ls_ComputerField + "'")
	lds_field.Filter( )
end if

//If exists the field of lds_field in the expresstion,
//replace it with 0 for number data type or replace it with '' for string data type.
ll_Cnt = lds_field.RowCount()
for ll_Num = 1 to ll_Cnt
	ls_Field    = lds_field.GetItemString(ll_Num,"export_field_name")
	ls_Datatype = lds_field.GetItemString(ll_Num,"ctx_column_datatype")
	//Modify 07/17/2007 by: Andy Reason:BugG071701
	ll_pos      = PosA(lower(ls_Source),lower(ls_Field))
	if ll_pos < 1 then continue
	
	if upper(ls_Datatype) = 'N' then
		ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_2',true)
	elseif upper(ls_Datatype) = 'S' then
		lb_flag = false
		ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_3',true)
	elseif upper(ls_Datatype) = 'D' then
		lb_flag = false
		//------------------- APPEON BEGIN -------------------
		//$<modify> Evan 06.10.2011
		//$<reason> Actually the ls_Field data type is string.
		//ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, '1900-01-01',true)
		//---------Begin Modified by (Appeon)Stephen 01.27.2015 for age computation--------
		//ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_3',true)
		ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_4',true)
		//------------------- APPEON END ---------------------
	end if
	//end of modify
next

//replace ' with "
ls_Source  = lnvo_string.of_globalreplace( ls_Source, '~~', '~~~~')
ls_Source  = lnvo_string.of_globalreplace( ls_Source, '"', '~~"')
if PosA(ls_Source,'"') > 0 or PosA(ls_Source,"~~'") > 0 then lb_flag = false

ls_Err = lds_field.modify('compute_1.Expression="' + ls_Source + '"')
if ls_Err <> '' then
	messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.")
	tab_1.tabpage_field_data.mle_1.setfocus( )
	if IsValid(lds_field) then Destroy lds_field
	if IsValid(n_export) then Destroy n_export
	return -1
end if

ls_Err=lds_field.Describe('Evaluate("'+ls_Source+'", 1)')
ls_Datatype = ''

if  not isnumber(ls_Err) then 
	//not OK
	if ls_Err = '!' then
		messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.")
		tab_1.tabpage_field_data.mle_1.setfocus( )
		if IsValid(lds_field) then Destroy lds_field
		if IsValid(n_export) then Destroy n_export
		return -1
	else
		ls_Datatype = 'S'
		//OK(denominator is 0)
		if ls_Err = '' and lb_flag then ls_Datatype = 'N'
	end if
else
	//OK
	if lb_flag then ls_Datatype = 'N' else ls_Datatype = 'S' 
end if 

//set values
if ll_Row > 0 then
	tab_1.tabpage_field_data.dw_detail.setitem(ll_Row,"ctx_column_datatype",ls_Datatype)
	tab_1.tabpage_field_data.dw_detail.SetItem(ll_Row,"export_fields_expression", tab_1.tabpage_field_data.mle_1.text )
end if

if IsValid(lds_field) then Destroy lds_field
if IsValid(n_export) then Destroy n_export

return 0

end function

public subroutine of_updatehistorydata ();/***************************************************
function: of_updatehistorydata() returns (none)
describe: 
Update the data type of the export column 
where the data type is null(only execute one time),
in order to resolve the history data.
Because the data type is very important for Calculated fields.
author  : andy 2007.06.01
***************************************************/
long   ll_Cnt = 0,ll_rec_id,ll_find,ll_Ret,ll_Num,ll_Row,ll_ExportType
string ls_ctx_column_name,ls_lu_field_name,ls_datatype,ls_Sql,ls_Syntax,ls_presentation,ls_Err
u_dw   ldw_Temp
datawindowchild dwchild
n_ds   lds_Temp
Long   ll_intcred_field,ll_intcred_table

SELECT TOP 1 1 
	INTO :ll_Cnt 
	FROM export_fields 
	WHERE (ctx_column_datatype is null or ctx_column_datatype in ('A','C','B'))
		and ((export_type = 1 and (isnull(ctx_column_name,'') <> '' or isnull(intcred_field,0) <> 0)) or (export_type = 2) )
		and export_id = :il_export_id;//<add> 07/12/2007 by: Andy optimize
//if not exists ctx_column_datatype is null then do nothing
if ll_Cnt < 1 then return 

setpointer(HourGlass!)

ls_Sql = "select rec_id from  export_fields WHERE (ctx_column_datatype is null or ctx_column_datatype in ('A','C','B')) " + &
		   " and ((export_type = 1 and (isnull(ctx_column_name,'') <> '' or isnull(intcred_field,0) <> 0)) or (export_type = 2) ) and export_id = " + String(il_export_id)
ls_presentation = "style(type=form)"
ls_Syntax = SQLCA.SyntaxFromSQL(ls_Sql, ls_presentation, ls_Err)

lds_Temp = create n_ds
lds_Temp.create(ls_Syntax,ls_Err)
lds_Temp.settransobject(sqlca)
ll_Ret = lds_Temp.Retrieve()

ib_lockcol = false
ldw_Temp = tab_1.tabpage_field_data.dw_detail
ldw_Temp.setredraw(false)

FOR ll_Num = 1 to ll_Ret
	ll_rec_id =lds_Temp.GetitemNumber(ll_Num,"rec_id")
	
	ll_Row    =ldw_Temp.retrieve(ll_rec_id )
	if ll_Row > 0 then
		ll_intcred_field   = ldw_Temp.GetItemNumber(1,"intcred_field")
		ls_ctx_column_name = ldw_Temp.GetItemString(1,"export_fields_ctx_column_name")
		ls_lu_field_name   = ldw_Temp.GetItemString(1,"lu_field_name")
		ll_ExportType      = ldw_Temp.GetItemNumber(1,"export_fields_export_type")
		ll_intcred_table   = ldw_Temp.GetItemNumber(1,"intcred_table")

		if isnull(ls_ctx_column_name) then ls_ctx_column_name = ''
		if isnull(ls_lu_field_name) then ls_lu_field_name = ''
		if isnull(ll_intcred_field) then ll_intcred_field = 0
		if isnull(ll_intcred_table) then ll_intcred_table = 0
		
		if ldw_Temp.getchild("intcred_field",dwchild) = 1 then
			dwchild.Settransobject( SQLCA)
			IF dwchild.Retrieve(ll_intcred_table ) < 1 THEN dwchild.INSERTROW(0)
		end if
		
		
		if ldw_Temp.getchild("export_fields_ctx_column_name",dwchild) = 1 then
			ll_find = dwchild.find("field_name = '" + ls_ctx_column_name +"'",1,dwchild.rowcount())
			If ll_find > 0 Then
				ls_DataType = dwchild.GetItemString(ll_find,"field_datatype")
				ldw_Temp.setitem(1,'ctx_column_datatype',ls_DataType)
			End If
		end if

		//<add> 07/13/2007  by: Andy
		if ldw_Temp.GetChild( "intcred_field", dwchild ) = 1 then
			ll_find = dwchild.Find("field_id=" + String(ll_intcred_field) ,1,dwchild.RowCount())
			if ll_find > 0 then
				ls_DataType = dwchild.GetItemString(ll_find,"field_type")
				if isnull(ls_DataType) then ls_DataType = ''
				if UPPER(ls_DataType) = 'L' OR UPPER(ls_DataType) = 'I' THEN ls_DataType = 'N'
				if UPPER(ls_DataType) = 'C' THEN ls_DataType = 'S'
				ldw_Temp.setitem(1,'ctx_column_datatype',ls_DataType)
			end if
		end if
		//end of add
		
		if ldw_Temp.getchild("lu_field_name",dwchild) = 1 then 
			ll_find = dwchild.find("field_name = '" + ls_lu_field_name +"'",1,dwchild.rowcount())
			If ll_find > 0 Then
				ls_DataType = dwchild.GetItemString(ll_find,"datatype")
				ldw_Temp.setitem(1,'ctx_column_datatype',ls_DataType)
			End If
		end if
		
		//fixed text
		if ll_ExportType = 2 then
			ldw_Temp.setitem(1,'ctx_column_datatype','S')
		end if
		
		if ldw_Temp.update() = 1 then 
			commit;
		else
			rollback;
		end if
				
	end if
next

ldw_Temp.reset()
ib_lockcol = true
ldw_Temp.setredraw(true)
if IsValid(lds_Temp) then Destroy lds_Temp
end subroutine

public function integer wf_size_it ();////////////////////////////////////////////////////////////////////////////////////////////////// //
// function: wf_size_it
////////////////////////////////////////////////////////////////////////////////////////////////////

// save the original sizes of the window and all of the objects on the window
// NOTE !!!! this process does not work on objects that are not descended
// from the dragobject class.
//==============================APPEON BEGIN==========================
// $<Added>:   Date: Nov 01,2007       Author:Nova
//--------------------------------------------------------------------
// $<reason>   Fix a defect.


dragobject temp
Int cnt,i
ii_win_width  = This.Width
ii_win_height = This.Height
ii_win_frame_w = This.Width - This.WorkSpaceWidth()
ii_win_frame_h = This.Height - This.WorkSpaceHeight()

cnt = UpperBound(This.Control)
FOR i = cnt To 1 Step -1
	temp = This.Control[i]
	
	// everything has a x,y,width and height
	size_ctrl[i].X = temp.X
	size_ctrl[i].Width = temp.Width
	size_ctrl[i].Y = temp.Y
	size_ctrl[i].Height = temp.Height
	
	// now go get text size information
	CHOOSE CASE TypeOf(temp)
		CASE commandbutton!
			commandbutton cb
			cb = temp
			size_ctrl[i].fontsize = cb.TextSize
			
		CASE singlelineedit!
			singlelineedit sle
			sle = temp
			size_ctrl[i].fontsize = sle.TextSize
			
		CASE editmask!
			editmask em
			em = temp
			size_ctrl[i].fontsize  	 = 	em.TextSize
			
		CASE statictext!
			statictext st
			st = temp
			size_ctrl[i].fontsize  	 = 	st.TextSize
			
		CASE picturebutton!
			picturebutton pb
			pb = temp
			size_ctrl[i].fontsize = pb.TextSize
			
		CASE checkbox!
			checkbox cbx
			cbx = temp
			size_ctrl[i].fontsize  	 = 	cbx.TextSize
			
		CASE dropdownlistbox!
			dropdownlistbox ddlb
			ddlb = temp
			size_ctrl[i].fontsize  	 = 	ddlb.TextSize
			
		CASE groupbox!
			groupbox gb
			gb = temp
			size_ctrl[i].fontsize  	 = 	gb.TextSize
			
		CASE listbox!
			listbox lb
			lb = temp
			size_ctrl[i].fontsize  	 = 	lb.TextSize
			
		CASE multilineedit!
			multilineedit mle
			mle = temp
			size_ctrl[i].fontsize  	 = 	mle.TextSize
		CASE radiobutton!
			radiobutton rb
			rb = temp
			size_ctrl[i].fontsize  	 = 	rb.TextSize
	END CHOOSE
NEXT

RETURN 1
//==============================APPEON END============================
end function

public function integer wf_resize_it (double size_factor);////////////////////////////////////////////////////////////////////////////////////////////////// //
// function: wf_resize_it
////////////////////////////////////////////////////////////////////////////////////////////////////
//==============================APPEON BEGIN==========================
// $<Added>:   Date: Nov 01,2007       Author:Nova
//--------------------------------------------------------------------
// $<reason>   Fix a defect.
// loop through off of the objects captured in the wf_size_it function and resize them
// Note !! radio buttons and checkboxes do not size properly as they are of fixed size.

dragobject temp
Int cnt,i

ib_exec = False // keep the function from being called recursively
//this.hide()

// resize the window
This.Width = ((  ii_win_width - ii_win_frame_w) * size_factor) + ii_win_frame_w

This.Height = ((  ii_win_height - ii_win_frame_h) * size_factor) + ii_win_frame_h

// for each control in the list, resize it and it's textsize (as applicable)
cnt = UpperBound(This.Control)
FOR i = cnt To 1 Step -1
	temp = This.Control[i]
	Boolean ib_flag = True
	IF TypeOf(temp) = commandbutton! THEN
		commandbutton cbtemp
		cbtemp = temp
		IF cbtemp.Text = "&Save" THEN
			ib_flag = False
		ELSE
			ib_flag = True
		END IF
	ELSE
		ib_flag = True
	END IF
	IF ib_flag THEN
		temp.X		 = size_ctrl[i].X * size_factor
		temp.Width   = size_ctrl[i].Width  * size_factor
		temp.Y		 = size_ctrl[i].Y * size_factor
		temp.Height  = size_ctrl[i].Height * size_factor
		
	END IF
	CHOOSE CASE TypeOf(temp)
		CASE commandbutton!
			commandbutton cb
			cb = temp
			//messagebox("",cb.text)
			IF ib_flag THEN
				cb.TextSize =  size_ctrl[i].fontsize * size_factor
			END IF
			
		CASE singlelineedit!
			singlelineedit sle
			sle = temp
			sle.TextSize =  size_ctrl[i].fontsize * size_factor
			
		CASE editmask!
			editmask em
			em = temp
			em.TextSize =  size_ctrl[i].fontsize * size_factor
			
		CASE statictext!
			statictext st
			st = temp
			st.TextSize =  size_ctrl[i].fontsize * size_factor
			
		CASE datawindow! // datawindows get zoomed
			datawindow dw
			dw = temp
			//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
			//dw.Object.datawindow.zoom = String(Int(size_factor*100))
			if gb_contract_version then
				If gb_autozoom Then dw.Object.datawindow.zoom = String(Int(size_factor*100)) //modified by gavins 20130107
			else
				dw.Object.datawindow.zoom = String(Int(size_factor*100))
			end if
			//---------End Modfiied ------------------------------------------------------
			
		CASE picturebutton!
			picturebutton pb
			pb = temp
			pb.TextSize =  size_ctrl[i].fontsize * size_factor
			
		CASE checkbox!
			checkbox cbx
			cbx = temp
			cbx.TextSize =  size_ctrl[i].fontsize * size_factor
			
		CASE dropdownlistbox!
			dropdownlistbox ddlb
			ddlb = temp
			ddlb.TextSize =  size_ctrl[i].fontsize * size_factor
			
		CASE groupbox!
			groupbox gb
			gb = temp
			gb.TextSize =  size_ctrl[i].fontsize * size_factor
			
		CASE listbox!
			listbox lb
			lb = temp
			lb.TextSize  =  size_ctrl[i].fontsize * size_factor
			
		CASE multilineedit!
			multilineedit mle
			mle = temp
			mle.TextSize =  size_ctrl[i].fontsize * size_factor
			
		CASE radiobutton!
			radiobutton rb
			rb = temp
			rb.TextSize =  size_ctrl[i].fontsize * size_factor
			
	END CHOOSE//"yes_or_no.Color ='"
NEXT
//messagebox("",string(tab_1.tabpage_export_hdr.dw_export_file.height))
//tab_1.height=this.workspaceheight( ) -tab_1.y -80
//tab_1.width =this.workspacewidth( ) -tab_1.x -55
//tab_1.tabpage_export_hdr.dw_export_file.height=tab_1.height - tab_1.tabpage_export_hdr.dw_export_file.y -118
//tab_1.tabpage_export_hdr.dw_export_file.width=tab_1.width - tab_1.tabpage_export_hdr.dw_export_file.y -
////tab_1.tabpage_export_hdr.dw_export_file.Modify("DataWindow.Zoom='"+string((size_factor)*100)+"'")
cb_save.Y = tab_1.Y +120
ib_exec = True
RETURN 1
//==============================APPEON END============================
end function

public function integer of_enabledfacilityprop (boolean ab_setnull);//////////////////////////////////////////////////////////////////////
// $<function> of_enabledfacilityprop
// $<arguments>
//			boolean	ab_setnull
// $<returns> integer
// $<description> Enabled facility field. Corrected BugG122804
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.15.2009
//////////////////////////////////////////////////////////////////////

long ll_Null
long ll_Row
long ll_table_id
//long ll_table_id_arr[] = {16,20,29,32,44,45,46,47,48,49,50,51,52,53,61,62,65}
//long ll_table_id_arr[] = {16,20,29,32,43,44,45,46,47,48,49,50,51,52,53,61,62,65,70,71} //alfee 11.25.2009
long ll_table_id_arr[] = {2,9,16,20,29,32,43,44,45,46,47,48,49,50,51,52,53,61,62,65,70,71}  //Start Code Change ----11.04.2011 #V12 maha - added for Specialty and Hosp
integer i, li_Count
boolean lb_HaveFacilityID = false

// Get table id
ll_Row = tab_1.tabpage_field_data.dw_detail.GetRow()
if ll_Row <= 0 then Return -1
ll_table_id = tab_1.tabpage_field_data.dw_detail.object.intcred_table[ll_Row]
if IsNull(ll_table_id) then Return -1

// Checks facility_id field if exists
li_Count = UpperBound(ll_table_id_arr[])
for i = 1 to li_Count
	if ll_table_id = ll_table_id_arr[i] then
		lb_HaveFacilityID = true
		Exit
	end if
next

// Enabled faicility_id field according to lb_HaveFacilityID value
if lb_HaveFacilityID then
	tab_1.tabpage_field_data.dw_detail.object.facility_id.protect = 0
	//---------Begin Commented by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
//	tab_1.tabpage_field_data.dw_detail.object.facility_id.visible = true  //Start Code Change ----11.04.2011 #V12 maha
//	tab_1.tabpage_field_data.dw_detail.object.t_facility.visible = true  //Start Code Change ----11.04.2011 #V12 maha
	//---------End Commented ------------------------------------------------------
else
	if ab_SetNull then
		SetNull(ll_Null)
		tab_1.tabpage_field_data.dw_detail.object.facility_id[ll_Row] = ll_Null
	end if
	tab_1.tabpage_field_data.dw_detail.object.facility_id.protect = 1
	//---------Begin Commented by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
//	tab_1.tabpage_field_data.dw_detail.object.facility_id.visible = false  //Start Code Change ----11.04.2011 #V12 maha
//	tab_1.tabpage_field_data.dw_detail.object.t_facility.visible = false  //Start Code Change ----11.04.2011 #V12 maha
	//---------End Commented ------------------------------------------------------
end if

Return 1
end function

public function integer of_check_exportid (integer ai_exportid);//Check if the export id has been used in other modules - alfee 05.20.2009

Long ll_cnt_letter, ll_cnt_mail, ll_cnt_auto
String ls_message

IF IsNull(ai_exportid) THEN RETURN 0

gnv_appeondb.of_startqueue( )
select count(*) into :ll_cnt_letter from sys_letters where export_id = :ai_exportid ;
select count(*) into :ll_cnt_mail from wf_email where export_id = :ai_exportid ;
select count(*) into :ll_cnt_auto from export_auto_settings where export_id = :ai_exportid ;
//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
//for contract: Ctx_am_document, ctx_acp_clause, ctx_acp_template
long  ll_cnt_ctx_am_doc,ll_cnt_ctx_acp_temp,ll_cnt_ctx_acp_clause
select count(*) into :ll_cnt_ctx_am_doc from Ctx_am_document where export_id =  :ai_exportid ;
select count(*) into :ll_cnt_ctx_acp_temp from ctx_acp_template where export_id =  :ai_exportid ;
select count(*) into :ll_cnt_ctx_acp_clause from ctx_acp_clause where export_id =  :ai_exportid ;
//---------End Added ------------------------------------------------------------------

gnv_appeondb.of_commitqueue( )

IF ll_cnt_letter > 0 THEN
	ls_message = "Letter Painter"
ELSEIF ll_cnt_mail > 0 THEN
	ls_message = "Email Painter"
ELSEIF ll_cnt_auto > 0 THEN
	ls_message = "Auto Export"	
//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
ELSEIF ll_cnt_ctx_am_doc > 0 THEN
	ls_message = "CTX am document"	
ELSEIF ll_cnt_ctx_acp_temp > 0 THEN
	ls_message = "CTX acp template"	
ELSEIF ll_cnt_ctx_acp_clause > 0 THEN
	ls_message = "CTX acp clause"	
//---------End Added ------------------------------------------------------------------	
END IF

IF LenA(ls_message) > 0 THEN
	MessageBox("Delete", "The export file cannot be deleted as it is being used in " + ls_message + ".")
	RETURN -1
END IF

RETURN 1




end function

public function integer of_check_field_name (string as_field);//Start Code Change ----04.04.2013 #V12 maha - quick field name test


//test 1
if isnumber(mid(as_field,1,1)) then return -1

//keywords
choose case lower(as_field)
	case 'select', 'from', 'to', 'where', 'group', 'having', 'by', 'create', 'drop'
		return -2
	case 'table', 'field', 'key', 'primary'
		return -2
	case else
		//ok
end choose

return 1
end function

public subroutine of_set_dddw (ref datawindowchild dwchild, string as_dataobject);//====================================================================
//$<Function>: of_set_dddw
//$<Arguments>:
// 	reference    datawindowchild    dwchild
// 	value        string             as_dataobject
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Toney 06.21.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Add function by jervis 06.09.2009
datastore lds_obj
long ll_i,ll_count
string ls_field_name
string ls_field_display
string ls_datatype
long ll_row

lds_obj = create datastore
lds_obj.dataobject = as_dataobject
ll_count = long(lds_obj.Describe( "datawindow.column.count"))
for ll_i = 1 to ll_count
	if lds_obj.describe( "#"+string(ll_i)+".visible") = "1" then
		ls_field_name = lds_obj.Describe( "#"+string(ll_i)+".name")
		ls_field_display = lds_obj.describe( ls_field_name+"_t.text")
		if ls_field_display = "!" then continue
		ls_dataType = of_get_coltype(lds_obj,ls_field_name)
		
		ll_row = dwchild.insertrow( 0)
		dwchild.setitem(ll_row,'field_name',ls_field_name)
		dwchild.setitem(ll_row,'field_display',ls_field_display) 
		dwchild.setitem(ll_row,'datatype',ls_dataType)
	end if
next
destroy lds_obj
end subroutine

public function string of_get_coltype (ref datastore ads_object, string as_name);//====================================================================
//$<Function>: of_get_coltype
//$<Arguments>:
// 	reference    datastore    ads_object
// 	value        string       as_name
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Toney 06.21.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Add function by Jervis 03.17.2009

string ls_datatype

//Get Column Type
ls_datatype = ads_object.Describe( as_name + ".coltype")
Choose Case Left ( ls_datatype , 5 )
	Case "char(", "char"
		ls_datatype = "S"
	Case "date"	,"datet"	,"time", "times"
		ls_datatype = "D"
	Case "decim","numbe", "doubl", "real","long", "ulong", "int"
		ls_datatype = "N"
End Choose
return ls_datatype
end function

public function integer of_restore_lookupfieldname ();//====================================================================
//$<Function>: of_restore_lookupfieldname
//$<Arguments>:
//$<Return>:  integer success return 1,failed return -1
//$<Description>: restore the drop-down data of lu_field_name field
//                        because the apb is not support,we can't restore the initial data by changing the child datawindow's name
//$<Author>: (Appeon) Toney 06.21.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
datawindowchild  ldwc_data
datastore    lds_data

IF ib_reset_dddw_of_lufieldname THEN
	ib_reset_dddw_of_lufieldname = False
ELSE
	//the data didn't be re-genrated,so not need to restore
	Return 1
END IF

//Get the datawindowchild object of lu_field_name
IF tab_1.tabpage_field_data.dw_detail.GetChild("lu_field_name",ldwc_Data) <> 1 THEN	Return -1
//Generate the initial data
lds_data = create datastore
lds_data.dataobject = "d_dddw_lookup_fld_nms_export"
//Copy data to the child datawindow object
IF lds_data.rowscopy(1,lds_data.rowcount(),Primary!,ldwc_data,ldwc_data.rowcount() + 1,Primary!) <> 1 THEN
	Destroy lds_data
	Return -1
END IF

Destroy lds_Data

Return 1
end function

public function boolean of_field_name_check (string as_fieldname);//====================================================================
// Function: of_Field_Name_Check()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_FieldName
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-05-15
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//(Appeon)Toney 06.21.2013 - V141 ISG-CLX
//====================================================================

Char	lc_First,lc_Other
long	ll_Cycle,ll_Length

lc_First = Char(as_FieldName)
if Not (lc_First >= 'a' and lc_First <= 'z' or lc_First >= 'A' and lc_First <= 'Z') then Return false

ll_Length = Len(as_FieldName)
for ll_Cycle = 2 to ll_Length
	lc_Other = Char(Mid(as_FieldName,ll_Cycle,1))
	if Not (lc_Other >= 'a' and lc_Other <= 'z' or lc_Other >= 'A' and lc_Other <= 'Z' or lc_Other >= '0' and lc_Other <= '9' or lc_Other = '_') then Return false
next

Return true

end function

public function string of_build_alias (string as_label);//====================================================================
//$<Function>: of_build_alias
//$<Arguments>:
// 	value    string    as_label
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Toney 06.24.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Add by jervis -- 11.20.2009

string ls_alias
int li_i,li_count
string ls_char
string ls_other_alias
boolean lb_duplicates
int li_pos
string ls_num


ls_alias = as_label
//More than 40
if len(ls_alias) > 40 then ls_alias = left(ls_alias,40)

//Replace first char to 'c'
if not ((Asc(ls_alias)>=65 and Asc(ls_alias) <= 90) or (Asc(ls_alias)>=97 and Asc(ls_alias) <= 122))  then
	ls_alias = Replace(ls_alias,1,1,'c')
end if

//if = column then change to column_c

//Replact to '_'(0-9,a-z,A-Z,_)
li_count = len(ls_alias)
for li_i = 1 to li_count
	ls_char = mid(ls_alias,li_i,1)
	if not ((Asc(ls_char)>=48 and Asc(ls_char) <= 57) or (Asc(ls_char)>=65 and Asc(ls_char) <= 90) or (Asc(ls_char)>=97 and Asc(ls_char) <= 122)) and ls_char <> '_' then
		ls_alias = Replace(ls_alias,li_i,1,'_')
	end if
next

//Column name Repeat 
For li_i = 1 To tab_1.tabpage_field_data.dw_fld_list.rowcount() 
	//if li_i = al_row then continue
	ls_other_alias = tab_1.tabpage_field_data.dw_fld_list.getitemstring(li_i,'export_field_name')
	If lower(ls_other_alias) = lower(ls_alias) Then
		li_pos = lastpos(ls_alias,"_")
		if li_pos  > 0 then
			ls_num = mid(ls_alias,li_pos + 1)
			if isnumber(ls_num) then
				ls_alias = mid(ls_alias,1,li_pos) + string(integer(ls_num) + 1)
			else
				ls_alias = ls_alias + "_1"
			end if
		else
			ls_alias = ls_alias + "_1"
		end if
		li_i = 0
	End If
Next

return ls_alias
end function

public subroutine of_resize ();// (Appeon)Harry 10.23.2014 - for BugA101404 / BugH052902
String ls_export_format
String ls_modify
String ls_prac_sql_x
String ls_prac_sql_w
String ls_prac_sql_y
String ls_prac_sql_h
String ls_header1_x
String ls_header1_y
String ls_header1_w
String ls_header1_h

//ls_modify = ""
//DataWindow dw_temp
//
//dw_temp = tab_1.tabpage_export_hdr.dw_export_file
////dw_temp.accepttext( ) 
//ls_export_format = dw_temp.getitemstring(1, "export_format")
//
//ls_prac_sql_x = dw_temp.describe("gb_2.x")
//ls_prac_sql_w = dw_temp.describe("gb_2.width")
//ls_prac_sql_y = String (long(dw_temp.describe("cb_paste.y") ) + long(dw_temp.describe("cb_paste.height") ) + 20)
//
//ls_modify = "prac_sql.x = " + ls_prac_sql_x + " "
//ls_modify += "prac_sql.width = " + ls_prac_sql_w + " "
//ls_modify += "prac_sql.y = " + ls_prac_sql_y + " "
//	
//if ls_export_format = 'export' or ls_export_format = 'form_csv' then
//	
//	ls_prac_sql_h = String (long(dw_temp.describe("t_4.y")) - long (ls_prac_sql_y) - 28)
//	
//	if ls_export_format = 'export' then
//		ls_header1_x = dw_temp.describe("header3.x")
//		ls_header1_y = dw_temp.describe("header2.y")
//		ls_header1_w = dw_temp.describe("header3.width")
//		ls_header1_h = dw_temp.describe("header2.height")
//	else
//		ls_header1_x =string (long(dw_temp.describe("t_4.x")) + long(dw_temp.describe("t_4.width")) + 20)
//		ls_header1_y =dw_temp.describe("t_4.y")
//		ls_header1_w = string (long(dw_temp.describe("gb_2.width")) + long(dw_temp.describe("gb_2.x")) - long(ls_header1_x))
//		ls_header1_h = String (dw_temp.height - long (ls_header1_y) - 28)
//	end if
//	ls_modify += "header1.x = " + ls_header1_x + " "
//	ls_modify += "header1.y = " + ls_header1_y + " "
//	ls_modify += "header1.width = " + ls_header1_w + " "
//	ls_modify += "header1.height = " + ls_header1_h + " "
//else
//	ls_prac_sql_h = String (dw_temp.height - long (ls_prac_sql_y) - 50)    //28)
//end if
//
//ls_modify += "prac_sql.height = " + ls_prac_sql_h + " "
//dw_temp.modify(ls_modify)


end subroutine

public function integer of_security (integer ai_level);//Start Code Change ----06.14.2016 #V152 maha - modified for 
//Start Code Change ----02.05.2015 #V14.2 maha
choose case ai_level
	case 0 //role security
		cb_2.visible = false
		cb_delete.visible = false
		cb_new.visible = false
		cb_save.visible = false
		cbx_savedata.visible = false
		
		tab_1.tabpage_export_hdr.dw_export_file.enabled = false
		
		tab_1.tabpage_field_data.cb_1.visible = false
		tab_1.tabpage_field_data.dw_detail.enabled = false
		//tab_1.tabpage_field_data.dw_fld_list.enabled = false
		tab_1.tabpage_field_data.cb_4.visible = false
		tab_1.tabpage_field_data.cb_add.visible = false
		tab_1.tabpage_field_data.cb_batch_del.visible = false
		tab_1.tabpage_field_data.cb_copy.visible = false		
		tab_1.tabpage_field_data.cb_delete_col.visible = false
		tab_1.tabpage_field_data.cb_insert.visible = false
		tab_1.tabpage_field_data.cb_quick.visible = false
		tab_1.tabpage_field_data.cb_reorder.visible = false
		tab_1.tabpage_field_data.cbx_autosave.visible = false
	case 1 //owner security
		cb_2.visible = false
		cb_delete.visible = false
		cb_new.visible = true
		cb_save.visible = false
		cbx_savedata.visible = false
		
		tab_1.tabpage_export_hdr.dw_export_file.enabled = false
		
		tab_1.tabpage_field_data.cb_1.visible = false
		tab_1.tabpage_field_data.dw_detail.enabled = false
		//tab_1.tabpage_field_data.dw_fld_list.enabled = false
		tab_1.tabpage_field_data.cb_4.visible = false
		tab_1.tabpage_field_data.cb_add.visible = false
		tab_1.tabpage_field_data.cb_batch_del.visible = false
		tab_1.tabpage_field_data.cb_copy.visible = false		
		tab_1.tabpage_field_data.cb_delete_col.visible = false
		tab_1.tabpage_field_data.cb_insert.visible = false
		tab_1.tabpage_field_data.cb_quick.visible = false
		tab_1.tabpage_field_data.cb_reorder.visible = false
		tab_1.tabpage_field_data.cbx_autosave.visible = false
	case 2  //owner access
		cb_delete.visible = true
		cb_new.visible = true
		cb_save.visible = true
		cbx_savedata.visible = true
		
		tab_1.tabpage_export_hdr.dw_export_file.enabled = true
		
		tab_1.tabpage_field_data.cb_1.visible = true
		tab_1.tabpage_field_data.dw_detail.enabled = true
		tab_1.tabpage_field_data.dw_fld_list.enabled = true
		tab_1.tabpage_field_data.cb_4.visible = true
		tab_1.tabpage_field_data.cb_add.visible = true
		tab_1.tabpage_field_data.cb_batch_del.visible = true
		tab_1.tabpage_field_data.cb_copy.visible = true		
		tab_1.tabpage_field_data.cb_delete_col.visible = true
		tab_1.tabpage_field_data.cb_insert.visible = true
		tab_1.tabpage_field_data.cb_quick.visible = true
		tab_1.tabpage_field_data.cb_reorder.visible = true
		tab_1.tabpage_field_data.cbx_autosave.visible = true
end choose

//End Code Change ----06.14.2016

return 1


end function

on w_export_painter.create
int iCurrent
call super::create
this.cb_store=create cb_store
this.p_1=create p_1
this.sle_rep=create sle_rep
this.sle_tc=create sle_tc
this.sle_tt=create sle_tt
this.cb_2=create cb_2
this.gb_1=create gb_1
this.cb_new=create cb_new
this.tab_1=create tab_1
this.cb_save=create cb_save
this.cb_quit=create cb_quit
this.cb_auto=create cb_auto
this.cb_test=create cb_test
this.cb_delete=create cb_delete
this.st_field1=create st_field1
this.cbx_savedata=create cbx_savedata
this.cbx_open=create cbx_open
this.dw_select=create dw_select
this.cbx_previewdata=create cbx_previewdata
this.st_field=create st_field
this.dw_screen=create dw_screen
this.dw_audit=create dw_audit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_store
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.sle_rep
this.Control[iCurrent+4]=this.sle_tc
this.Control[iCurrent+5]=this.sle_tt
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.cb_new
this.Control[iCurrent+9]=this.tab_1
this.Control[iCurrent+10]=this.cb_save
this.Control[iCurrent+11]=this.cb_quit
this.Control[iCurrent+12]=this.cb_auto
this.Control[iCurrent+13]=this.cb_test
this.Control[iCurrent+14]=this.cb_delete
this.Control[iCurrent+15]=this.st_field1
this.Control[iCurrent+16]=this.cbx_savedata
this.Control[iCurrent+17]=this.cbx_open
this.Control[iCurrent+18]=this.dw_select
this.Control[iCurrent+19]=this.cbx_previewdata
this.Control[iCurrent+20]=this.st_field
this.Control[iCurrent+21]=this.dw_screen
this.Control[iCurrent+22]=this.dw_audit
end on

on w_export_painter.destroy
call super::destroy
destroy(this.cb_store)
destroy(this.p_1)
destroy(this.sle_rep)
destroy(this.sle_tc)
destroy(this.sle_tt)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.cb_new)
destroy(this.tab_1)
destroy(this.cb_save)
destroy(this.cb_quit)
destroy(this.cb_auto)
destroy(this.cb_test)
destroy(this.cb_delete)
destroy(this.st_field1)
destroy(this.cbx_savedata)
destroy(this.cbx_open)
destroy(this.dw_select)
destroy(this.cbx_previewdata)
destroy(this.st_field)
destroy(this.dw_screen)
destroy(this.dw_audit)
end on

event open;call super::open;
integer i


if w_mdi.of_security_access( 1420 ) = 0 then ////Start Code Change ----01.04.2008 #V8 maha
	cb_auto.visible = false
end if


 //Start Code Change ----02.05.2015 #V14.2 maha - read only access
if w_mdi.of_security_access(550 ) = 1 then
	of_security(0)
	ib_readonly = true
end if
 //Start Code Change ----02.05.2015
 
 //---------Begin Added by (Appeon)Stephen 05.31.2017 for V15.4-WebView Reporting Functionality--------
if w_mdi.of_security_access( 7846 ) = 0 then 
	cb_store.visible = false
end if
//---------End Added ------------------------------------------------------

//dw_select.of_SetUpdateAble( False )
dw_select.SetTransObject( SQLCA )
dw_select.retrieve()
dw_select.InsertRow( 1 )

dw_select.SetFocus()

tab_1.enabled = false

/*
<add> andy 2007.06.04
Update the data type of the export column 
where the data type is null(only execute one time),
in order to resolve the history data.
Because the data type is very important for Calculated fields.
*/
//comment 07/12/2007 by: Andy optimize
//Move to dw_select.itemchanged event
//of_updatehistorydata()
//end of add

//messagebox("",string(inv_resize.scale))

//--------Begin Added by Nova 11.01.2007------------------------
//of_setresize(true)
//inv_resize.of_setminsize( this.workspacewidth( ) , this.WorkSpaceHeight()	)
//inv_resize.of_setorigsize( this.workspacewidth() ,this.WorkSpaceHeight())
//inv_resize.of_setminsize( this.width , this.Height)

//$<comment> 04.22.2008  
//inv_resize.of_register( this.cb_save ,inv_resize.fixedright )//fixedrightbottom
//inv_resize.of_register( this.cb_auto ,inv_resize.fixedright )
//inv_resize.of_register( this.cb_quit ,inv_resize.fixedright )
//inv_resize.of_register( this.cb_test ,inv_resize.fixedright )
////inv_resize.of_register( this.cb_3 ,inv_resize.fixedrightbottom )

////inv_resize.of_register( this.tab_1.tabpage_field_data.cb_1 ,inv_resize.scale )
//inv_resize.of_register( this.cbx_open ,inv_resize.fixedright )//fixedbottom
//inv_resize.of_register( this.cbx_previewdata ,inv_resize.fixedright )
//inv_resize.of_register( this.cbx_savedata ,inv_resize.fixedright )
//
//inv_resize.of_register( tab_1,inv_resize.scalerightbottom )

//inv_resize.of_register( tab_1.tabpage_export_hdr.dw_export_file, inv_resize.scalerightbottom )  //Start Code Change ----06.13.2016 #V15.2 maha
//inv_resize.of_register( tab_1.tabpage_field_data.dw_detail, inv_resize.scalerightbottom )
//inv_resize.of_register( tab_1.tabpage_field_data.dw_fld_list, inv_resize.scalebottom )
////inv_resize.of_register( this.tab_1.tabpage_field_data.cb_1 ,inv_resize.fixedbottom )  //Start Code Change ----03.18.2016 #V15 maha
//inv_resize.of_register( this.tab_1.tabpage_field_data.st_1 ,inv_resize.fixedbottom )
//inv_resize.of_register( this.tab_1.tabpage_field_data.mle_1 ,inv_resize.fixedbottom )
//inv_resize.of_register( this.tab_1.tabpage_field_data.cb_4 ,inv_resize.fixedbottom )
//--------End Added --------------------------------------------


end event

event close;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.23.2007 By: Jack
//$<reason> Fix a defect.

//---------------------------- APPEON END ----------------------------

end event

event closequery;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.23.2007 By: Jack
//$<reason> Fix a defect.
If ib_closestatus = False Then
   cb_quit.event clicked() 
End If
//---------------------------- APPEON END ----------------------------

end event

event resize;call super::resize;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//// resize script for w_export_painter
//////////////////////////////////////////////////////////////////////////////////////////////////////
////==============================APPEON BEGIN==========================
//// $<Added>:   Date: Nov 01,2007       Author:Nova
////--------------------------------------------------------------------
//// $<reason>   Fix a defect.
//double ratiow, ratio, ratioh
//int rc
//// recalculate the new ratios and then use the minimum
//if ib_exec then  // Check to see if wf_resize_it is already running.
//	ratioh = this.height /ii_win_height
//	ratiow = this.width / ii_win_width
//	ratio = min(ratioh, ratiow)
//	rc = wf_resize_it(ratio)
//end if
////==============================APPEON END============================
//
//windowobject lwo_temp[]
//n_cst_resize lnvo_resize
//
//lnvo_resize = create n_cst_resize
//lwo_temp[1] = tab_1.tabpage_export_hdr.dw_export_file
//lnvo_resize.of_resize(lwo_temp,handle(this))
//destroy lnvo_resize
//

long ll_w
long ll_h


ll_h = this.WorkSpaceHeight ( )
ll_w = this.WorkSpaceWidth ( )

tab_1.width = ll_w - 20
tab_1.height = ll_h - tab_1.y - 20
//tab_1.tabpage_export_hdr.width = tab_1.width - 20
//tab_1.tabpage_export_hdr.height = tab_1.height - 142
tab_1.tabpage_export_hdr.dw_export_file.width = tab_1.width - 36
tab_1.tabpage_export_hdr.dw_export_file.height = tab_1.height - tab_1.tabpage_export_hdr.dw_export_file.y - 88

tab_1.tabpage_field_data.dw_fld_list.height =  tab_1.height - 300
tab_1.tabpage_field_data.dw_detail.height =  tab_1.height - 300
tab_1.tabpage_field_data.dw_detail.width =  tab_1.width - tab_1.tabpage_field_data.dw_detail.x - 20

//tab_1.tabpage_field_data.dw_detail.Object.sort_by.X
//tab_1.tabpage_field_data.cb_1.x=long(tab_1.tabpage_field_data.dw_detail.Object.sort_by.X) +tab_1.tabpage_field_data.dw_fld_list.width+50
//tab_1.tabpage_field_data.st_1.y=tab_1.tabpage_field_data.dw_detail.y + long(tab_1.tabpage_field_data.dw_detail.Object.gb_1.y) + 80
//tab_1.tabpage_field_data.mle_1.y = tab_1.tabpage_field_data.st_1.y + tab_1.tabpage_field_data.st_1.height + 10
//tab_1.tabpage_field_data.cb_4.y = tab_1.tabpage_field_data.mle_1.y 
//tab_1.tabpage_field_data.mle_1.width = long(tab_1.tabpage_field_data.dw_detail.Object.gb_1.width) - 140
//tab_1.tabpage_field_data.mle_1.height = long(tab_1.tabpage_field_data.dw_detail.Object.gb_1.height) - 140//130 (Appeon)Toney 07.08.2013 - V141 ISG-CLX
//tab_1.tabpage_field_data.cb_4.x = tab_1.tabpage_field_data.mle_1.x + tab_1.tabpage_field_data.mle_1.width + 0//10 (Appeon)Toney 07.08.2013 - V141 ISG-CLX




//---------Begin Added by (Appeon)Harry 10.23.2014 for BugA101404 / BugH052902--------
String ls_export_format 
if tab_1.tabpage_export_hdr.dw_export_file.getrow( ) > 0 then
	//post of_resize()
end if
//---------End Added ------------------------------------------------------
end event

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-11-06 By: Scofield
//$<Reason> Change to m_pfe_cst_mdi_menu menu

If w_mdi.menuname <> "m_pfe_cst_mdi_menu" Then
	w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
	w_mdi.of_menu_security( w_mdi.MenuName )
END IF
//---------------------------- APPEON END ----------------------------

end event

type cb_store from commandbutton within w_export_painter
boolean visible = false
integer x = 2537
integer y = 48
integer width = 334
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Store Results"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.31.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_prac_row
Long prac_ids[]
long ll_from
long ll_to
long i
long ic
long ll_pracid
long ll_log
Long    ll_pracidold = -1
Long    ll_Num = 0,ll_pos
long ll_report_storage_id
integer p1
integer p2
integer p3
integer li_savedata = 0
integer li_type1
integer li_type
string ls_prompt1
string ls_prompt2
string ls_prompt3
string ls_prompt
string ls_arg
string ls_parm1 = ""
string ls_parm2 = ""
string ls_parm3 = ""
string ls_presentation_str
string ls_sny_retrieve
string ls_dwsyntax_str
string ERRORS
string ls_path
String  ls_Temp1,ls_Temp2
String  ls_name
string ls_return
string ls_note
String  ls_SQL = '',ls_temp
str_b    lstr_rpt
n_ds lds_export_retrieve
pfc_n_cst_ai_export_apb  n_export

il_export_id = dw_select.getitemnumber(dw_select.getrow(),'export_id')

openwithparm(w_rpt_storage_select, "R-E:"+string(il_export_id))
lstr_rpt = message.powerobjectparm
ll_report_storage_id = lstr_rpt.i_count
ls_note = lstr_rpt.s_type
if ll_report_storage_id < 1 then
	messagebox("Prompt", "This record doesn’t have report storage information. Please set it up in Saved Report Setup window. ")
	return
end if

n_export = CREATE pfc_n_cst_ai_export_apb

If	tab_1.tabpage_field_data.dw_fld_list.rowcount() < 1 Then
	messagebox("Export error","No Export Column.")
	if IsValid(n_export) then destroy n_export
	Return
End If

if isnull(il_export_id) or il_export_id < 1 then
	messagebox("Select error","Please select an export.")
	if IsValid(n_export) then destroy n_export
	return
end if

ls_path = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"save_path")

ls_sny_retrieve = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"prac_sql")

ls_prompt1 = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"prompt_type1")
ls_prompt2 = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"prompt_type2")
ls_prompt3 = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"prompt_type3")

choose case ls_prompt1
	case "C","D","N","F"//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT071302,append F option
		ls_prompt = ls_prompt1
end choose
choose case ls_prompt2
	case "C","D","N"
		ls_prompt += "*" + ls_prompt2
	case else //(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2
		ls_prompt += "*"
end choose
choose case ls_prompt3
	case "C","D","N"
		ls_prompt += "*" + ls_prompt3
	case else //(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2
		ls_prompt += "*"
end choose
if ls_prompt = "**" then ls_prompt = "" //(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-28 By: Rodger Wu (doc painter)
li_type = tab_1.tabpage_export_hdr.dw_export_file.GetItemNumber( 1, "export_type" )
//---------------------------- APPEON END ----------------------------

IF isnull(ls_sny_retrieve) or trim(ls_sny_retrieve) = "" then
	open(w_export_test_param)
	ls_return = message.stringparm
	
	if ls_return = "Cancel" then
		if IsValid(n_export) then destroy n_export
		return
	end if
	
	ll_from = long(MidA(ls_return,1,PosA(ls_return,"@") - 1))
	//messagebox("ls_from",ll_from)
	ll_to = long(MidA(ls_return,PosA(ls_return,"@") + 1))
	//messagebox("ll_to",ll_to)
	ic = ll_to - ll_from + 1
	//messagebox("ic",ic)
	if ic < 0 then
		//messagebox("Input Error","The To: value cannot be less that the From: value.")
		messagebox("Input Error","The To value must be greater than the From value.")
		if IsValid(n_export) then destroy n_export
		return
	end if
	
	if li_type = 3 or li_type = 4 or li_type = 6 then  //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking) add li_type = 6
		ls_sny_retrieve = 'Select distinct ctx_id from ctx_basic_info where ctx_id between ' + string(ll_from) + ' and ' + string(ll_to) + ';'
	else
		ls_sny_retrieve = 'Select distinct prac_id from pd_basic where prac_id between ' + string(ll_from) + ' and ' + string(ll_to) + ';'
	end if
	
	ls_presentation_str = "style(type=grid)"		
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		if IsValid(n_export) then destroy n_export		
		RETURN -1
	END IF
	
	lds_export_retrieve = CREATE n_ds
	lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
	lds_export_retrieve.SetTransObject( SQLCA )
	

	
	ll_prac_row = lds_export_retrieve.retrieve()
	if ll_prac_row < 1 then 
		if li_type = 3 or li_type = 4 or li_type = 6 then //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking) add li_type = 6
			messagebox("Information","No contract rows returned.")
		else
			messagebox("Information","No practitioner rows returned.")
		end if
		if IsValid(n_export) then destroy n_export
		if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
		return -2
	end if
	
	//<add> 07/12/2007 by: Andy
	lds_export_retrieve.Setsort( "#1 A")
	lds_export_retrieve.Sort()
	//end of add
		
	for i = 1 to ll_prac_row
		prac_ids[i] = lds_export_retrieve.getitemnumber(i,1)
	next
	
	//<add> 07/17/2007 by: Andy
	li_type1 = 3
	
else
	
	if LenA(ls_prompt) > 0 then //maha 110305 for prompts
		openwithparm(w_export_prompt,ls_prompt)
		ls_prompt = message.stringparm
		if ls_prompt = "Cancel" then
			if IsValid(n_export) then destroy n_export
			if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
			return -1
		else
		//parses the return into separate variables
		ls_parm1 = ""
		ls_parm2 = ""
		ls_parm3 = ""
		
		ls_arg = ls_prompt
		
		p1 = PosA(ls_arg,"*",1)
		ls_parm1 = MidA(ls_arg,1,p1 - 1)
		
		p2 = PosA(ls_arg,"*",p1 + 1)
		if p2 > 0 then 
			ls_parm2 = MidA(ls_arg,p1 + 1,p2 - p1 - 1)
		
			if p2 < LenA(ls_arg) then //check for third param
				ls_parm3 = MidA(ls_arg,p2 + 1)
			end if
		end if
		
		ls_sny_retrieve = n_export.of_prompt_syntax(ls_sny_retrieve,ls_parm1,ls_parm2,ls_parm3)

		end if
	end if

	//<add> 07/17/2007 by: Andy
	li_type1 = 1
	ls_SQL = ls_sny_retrieve
	//end of add
	
	//$<add> 05.06.2008 by Andy
	ll_pos = PosA(lower(ls_sny_retrieve)," from ")
	if ll_pos <= 0 then ll_pos = PosA(lower(ls_sny_retrieve),"from") //(Appeon)Harry 05.04.2015 -  Issues running a custom correspondence letter against an IntelliBatch
	ls_temp = LeftA(ls_sny_retrieve,ll_pos - 1)
	
	if li_type = 3 or li_type = 4 or li_type = 6 then //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking) add li_type = 6
		if PosA(lower(ls_temp), "ctx_id") < 1 then
			MessageBox("Caution","ctx_id must be the first column of the Contract Retrieval SQL.")		
			if IsValid(n_export) then destroy n_export		
			RETURN -1
		else
			if (PosA(lower(ls_temp), "ctx_id") > PosA(lower(ls_temp), ",")) and  (PosA(lower(ls_temp), ",") > 0)  then
				MessageBox("Caution","ctx_id must be the first column of the Contract Retrieval SQL.")		
				if IsValid(n_export) then destroy n_export		
				RETURN -1
			end if
		end if
	else
		if PosA(lower(ls_temp), "prac_id") < 1 then	
			//MessageBox("Caution","prac_id must be the first column of the Contract Retrieval SQL.")		//Commented by (Appeon)Harry 05.04.2015
			MessageBox("Caution","prac_id must be the first column of the Practitioner Retrieval SQL.")	//(Appeon)Harry 05.04.2015
			if IsValid(n_export) then destroy n_export		
			RETURN -1
		else
			if (PosA(lower(ls_temp), "prac_id") > PosA(lower(ls_temp), ",")) and  (PosA(lower(ls_temp), ",") > 0)  then	
				//MessageBox("Caution","prac_id must be the first column of the Contract Retrieval SQL.")		 //Commented by (Appeon)Harry 05.04.2015
				MessageBox("Caution","prac_id must be the first column of the Practitioner Retrieval SQL.")  //(Appeon)Harry 05.04.2015
				if IsValid(n_export) then destroy n_export		
				RETURN -1
			end if
		end if	
	end if
	//------------------- APPEON END -------------------
	
	//end add 05.06.2008
	
	ls_presentation_str = "style(type=grid)"		
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		MessageBox("SyntaxFromSQL caused these errors: " + ERRORS, ls_sql)
		if IsValid(n_export) then destroy n_export
		RETURN -1
	END IF
	
	lds_export_retrieve = CREATE n_ds
	lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
	lds_export_retrieve.SetTransObject( SQLCA )
		
	ll_log = of_log_sys_report("E","MAN","", il_export_id,tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1, "export_name")  )  //Start Code Change ----06.06.2016 #V152 maha,	07.25.2016 - maha - name parameter
	ll_prac_row = lds_export_retrieve.retrieve()
	
	if ll_prac_row < 1 then 
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-11-28 By: Rodger Wu (doc painter)
		//if li_type = 3 or li_type = 4 then
		if li_type = 3 or li_type = 4 or li_type = 6 then //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
			messagebox("Information","No contract rows returned.")
		else
			messagebox("Information","No practitioner rows returned.")
		end if
		//---------------------------- APPEON END ----------------------------
		if IsValid(n_export) then destroy n_export
		if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
		return -2
	end if

	//<add> 07/12/2007 by: Andy
	lds_export_retrieve.Setsort( "#1 A")
	lds_export_retrieve.Sort()
	//end of add
	
	//lds_export_retrieve.retrieve()
	//Modify 07/13/2007 by: Andy Reason:filter repeated data
	for i = 1 to ll_prac_row
		ll_pracid   = lds_export_retrieve.getitemnumber(i,1)
		if ll_pracid <> ll_pracidold and ll_pracid > 0 then  //jervis 08.26.2009
			ll_Num ++
			prac_ids[ll_Num] = ll_pracid
			ll_pracidold= ll_pracid
		end if
	next
	//end of modify
end if

//<add> 07/18/2007 by: Andy
if cbx_savedata.checked and cbx_previewdata.checked then 
	//save & preview
	li_savedata = 3
elseif cbx_previewdata.checked then
	//preview
	li_savedata = 2
elseif cbx_savedata.checked then
	//save
	li_savedata = 1
else
	//do nothing
	li_savedata = 0
end if
//end of add
//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
n_export.ib_gen_rec_id = False //Added By Ken.Guo 2010-06-30.
//---------End Added ------------------------------------------------------------------
n_export.ib_export_test = True //(Appeon)Harry 09.01.2014 - for BugH070801 in V14.2 Issues of Integration.doc

//if li_type = 3 or li_type = 4 then

if li_type = 3 or li_type = 4 or li_type = 6 then	//Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
	i = n_export.of_export_data_with_text_ctx( il_export_id, prac_ids,ls_path,li_savedata,ls_parm1,ls_parm2,ls_parm3,li_type1,ls_SQL )
else
	i = n_export.of_export_data_with_text( il_export_id, prac_ids,ls_path,li_savedata,ls_parm1,ls_parm2,ls_parm3,li_type1,ls_SQL)	
end if

of_log_sys_report_end( ll_log, gl_export_rows_count, "")  //Start Code Change ----06.06.2016 #V152 maha

datetime ldt_null
if fileexists(ls_path) and ll_report_storage_id>0 then
	f_report_storage(ll_report_storage_id, ls_path, gl_export_rows_count, ldt_null, ldt_null, ls_note, 'M')
end if
destroy n_export;
destroy lds_export_retrieve//<add> 07/13/2007 by: Andy


end event

type p_1 from picture within w_export_painter
boolean visible = false
integer x = 2853
integer y = 12
integer width = 82
integer height = 60
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type sle_rep from singlelineedit within w_export_painter
boolean visible = false
integer x = 3739
integer y = 368
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_tc from singlelineedit within w_export_painter
boolean visible = false
integer x = 3735
integer y = 268
integer width = 343
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_tt from singlelineedit within w_export_painter
boolean visible = false
integer x = 3730
integer y = 156
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_export_painter
boolean visible = false
integer x = 3794
integer y = 80
integer width = 178
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "strip"
end type

event clicked;//string tt
//string cc
//string res
//string rr
//pfc_n_cst_ai_export nv_e
//debugbreak()
//tt = sle_tt.text
//cc = sle_tc.text
//rr = sle_rep.text
//
//nv_e = create pfc_n_cst_ai_export
//
//res = nv_e.of_strip_char( cc,tt, rr)
//messagebox("",res)
//
//destroy nv_e
end event

type gb_1 from groupbox within w_export_painter
integer x = 23
integer width = 2025
integer height = 156
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Export File"
end type

type cb_new from u_cb within w_export_painter
integer x = 1138
integer y = 48
integer width = 411
integer height = 84
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&New Export File"
end type

event clicked;long ll_export_id
Integer li_nr

//-----Begin Modified by alfee 10.22.2010------------------------------
//ll_export_id = gnv_app.of_get_id("MEETING")
long ll_temp_id
select isnull(max(export_id),0) + 1 into :ll_export_id from export_header;
ll_temp_id = gnv_app.of_get_id("EXPORT")
if ll_temp_id < ll_export_id then
	update ids set export_id = :ll_export_id;	
elseif ll_temp_id > ll_export_id then 
	ll_export_id = ll_temp_id
end if
//-----End Modified ---------------------------------------------------
lb_new = true
tab_1.enabled = true

il_export_id = ll_export_id
li_nr = tab_1.tabpage_export_hdr.dw_export_file.InsertRow( 1 )
tab_1.tabpage_export_hdr.dw_export_file.SetItem( li_nr, "export_id", ll_export_id)
tab_1.tabpage_export_hdr.dw_export_file.SetItem( li_nr, "field_delimiter", "T")
tab_1.tabpage_export_hdr.dw_export_file.SetItem( li_nr, "record_delimiter", "R")
tab_1.tabpage_export_hdr.dw_export_file.SetItem( li_nr, "report_owner", 0)  //Start Code Change ----06.15.2016 #V152 maha
//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
  /*
    tab_1.tabpage_export_hdr.dw_export_file.SetItem( li_nr, "export_type", "1")  //maha 08.21.2012  
  */
IF gb_contract_version THEN
	tab_1.tabpage_export_hdr.dw_export_file.SetItem( li_nr, "export_type", 3)  //maha 08.21.2012  
	//---------Begin Added by (Appeon)Toney 11.14.2013 for V141 ISG-CLX--------
	//$Reason:Fix BugT110801,trigger the event in order to refresh data of dropdowndatawindow
	dwobject ldwo_viewid
	long  ll_viewid
	ldwo_viewid = tab_1.tabpage_export_hdr.dw_export_file.object.view_id
	ll_viewid = tab_1.tabpage_export_hdr.dw_export_file.getitemnumber(li_nr,"view_id")
	tab_1.tabpage_export_hdr.dw_export_file.event itemchanged(li_nr,ldwo_viewid,string(ll_viewid))
	//---------End Added ------------------------------------------------------------------
ELSE
	tab_1.tabpage_export_hdr.dw_export_file.SetItem( li_nr, "export_type", 1)  //maha 08.21.2012  
END IF
//---------End Modfiied ------------------------------------------------------------------
tab_1.tabpage_export_hdr.dw_export_file.ScrollToRow( li_nr )
tab_1.tabpage_export_hdr.dw_export_file.SetRow( li_nr )
tab_1.tabpage_export_hdr.dw_export_file.SetFocus( )
tab_1.selecttab(1)
tab_1.tabpage_field_data.dw_fld_list.reset()
tab_1.tabpage_field_data.dw_detail.reset()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.23.2007 By: Jack
//$<reason> Fix a defect.
dw_select.reset()
dw_select.insertrow(0)
//---------------------------- APPEON END ----------------------------

//<add> andy 2007.05.30
//set mle_1¡¢st_1¡¢cb_4 visible = false
of_setui(1)
//end of add

//Start Code Change ----06.16.2016 #V152 maha - auditing record
dw_audit.reset()
dw_audit.insertrow(1)
dw_audit.setitem(1, "report_id", il_view_id)
dw_audit.setitem(1, "report_name",tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"export_name"))
dw_audit.setitem(1, "mod_user", gs_user_id)
dw_audit.setitem(1, "add_edit", "A")
dw_audit.setitem(1, "report_type", "E")
//End Code Change ----06.16.2016
end event

type tab_1 from tab within w_export_painter
event create ( )
event destroy ( )
string tag = "Auto save"
integer y = 172
integer width = 3570
integer height = 2136
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_export_hdr tabpage_export_hdr
tabpage_field_data tabpage_field_data
end type

on tab_1.create
this.tabpage_export_hdr=create tabpage_export_hdr
this.tabpage_field_data=create tabpage_field_data
this.Control[]={this.tabpage_export_hdr,&
this.tabpage_field_data}
end on

on tab_1.destroy
destroy(this.tabpage_export_hdr)
destroy(this.tabpage_field_data)
end on

event selectionchanged;if newindex = 2 then
	cb_save.triggerevent(clicked!)
	tab_1.tabpage_field_data.st_next.text = "Next Col " + (string(tab_1.tabpage_field_data.dw_fld_list.rowcount()+ 1))
	//---------Begin Modified by (Appeon)Harry 11.07.2013 for V141 ISG-CLX  BugH101701--------
	Long ll_row, ll_export_type
	ll_row = tab_1.tabpage_export_hdr.dw_export_file.GetRow()
	if ll_row <= 0 then return
	ll_export_type = tab_1.tabpage_export_hdr.dw_export_file.GetItemNumber(ll_row, 'export_type')
	//---------Begin Commented by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
	/*
	if ll_export_type = 3 or ll_export_type = 4 then
		tab_1.tabpage_field_data.dw_detail.modify("record_level.visible='1'")
	else
		tab_1.tabpage_field_data.dw_detail.modify("record_level.visible='0'")
	end if
	*/
	if ll_export_type =  5 or ll_export_type = 6 then
		tab_1.tabpage_field_data.dw_detail.modify("export_fields_module_type.visible='1'")
	else
		tab_1.tabpage_field_data.dw_detail.modify("export_fields_module_type.visible='0'")
	end if
	//---------End Commented ------------------------------------------------------
	//---------End Modfiied ------------------------------------------------------
end if
end event

event constructor;this.backcolor = gl_bg_color
end event

type tabpage_export_hdr from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3534
integer height = 2020
long backcolor = 33551856
string text = "Export File Properties"
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_export_file dw_export_file
end type

on tabpage_export_hdr.create
this.dw_export_file=create dw_export_file
this.Control[]={this.dw_export_file}
end on

on tabpage_export_hdr.destroy
destroy(this.dw_export_file)
end on

type dw_export_file from u_dw within tabpage_export_hdr
event type integer of_create_export_ds ( string as_unionsql,  string as_tabletemp,  string as_rowno )
integer y = 124
integer width = 3525
integer height = 1896
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_export_hdr"
boolean vscrollbar = false
boolean livescroll = false
end type

event type integer of_create_export_ds(string as_unionsql, string as_tabletemp, string as_rowno);String ls_UnionSQL
String ls_tabletemp
String ls_RowNo
String ls_Mysql

ls_UnionSQL = as_UnionSQL
ls_tabletemp = as_tabletemp
ls_RowNo = as_RowNo

RETURN 1
end event

event constructor;datawindowchild dwchild  //maha 06.14.2016
This.of_SetReqColumn( TRUE )
of_SetTransObject( SQLCA )

//--------Begin Added by Nova 11.05.2007------------------------
this.of_setresize(true)
this.inv_resize.of_setorigsize( this.width,this.height)
this.inv_resize.of_setminsize( this.width,this.height)
this.inv_resize.of_register(this.inv_resize.scale)
this.inv_resize.of_SetDetailHeight(true)
//--------End Added --------------------------------------------

//Start Code Change ----06.14.2016 #V152 maha
this.getchild( "report_owner", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)
dwchild.setitem(1, "role_id", 0)
dwchild.setitem(1, "role_name", "Any")
dwchild.insertrow(1)
dwchild.setitem(1, "role_id", -1)
dwchild.setitem(1, "role_name", "MASTER")
end event

event buttonclicked;call super::buttonclicked;string docname, named, path
integer value
integer li_type
long ll_pos

if dwo.Name = "cb_browse" THEN
	//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------	
	  /*
			value = GetFilesaveName("Select Directory and enter file name to be used for saved file.",&
		+ docname, named, "DOC", &
			+ "text Files (*.txt),*.txt")
		ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008	
	  */
	gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
	value = GetFilesaveName("Select Directory and enter file name to be used for saved file.",&
	+ docname, named, "DOC", &
		+ "text Files (*.txt),*.txt")
	gf_save_dir_path(docname) //Added by Ken.Guo on 2009-03-10	
	//---------End Modfiied ------------------------------------------------------------------	
	IF value = 1 THEN
		path = MidA(docname,1,PosA(docname,".txt",1) - 1)
		this.setitem(1,"save_path",path) 
	END IF
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-28 By: Rodger Wu (doc painter)
//$<reason> added example for contracts
if dwo.Name = "cb_paste" THEN
	li_type = This.GetItemNumber( row, "export_type" )
	//---------Begin Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
	//if li_type = 3 or li_type = 4 then
	if li_type = 3 or li_type = 4 or li_type = 6 then
	//---------End Modfiied ------------------------------------------------------
		named = "Select distinct ctx_id from ctx_basic_info where ctx_id in (1,2,3,4,5);"
	else
		named = "Select distinct prac_id from pd_basic where prac_id in (1,2,3,4,5);"
	end if
	
	tab_1.tabpage_export_hdr.dw_export_file.setitem(1,"prac_sql",named)
	of_report_audit_set('P', dw_audit, false)   //Start Code Change ----06.16.2016 #V152 maha
end if
//---------------------------- APPEON END ----------------------------

if dwo.Name = "cb_batch" THEN
	openwithparm(w_batch_prac_select_new,"E")
	named = message.stringparm
	if named <> "Cancel" then
		//Start Code Change ----12.14.2007 #V8 maha -- strip out order by
		ll_pos = PosA(named,"order by",1)
		if ll_pos > 1 then
			named  = MidA(named,1,ll_pos -1) + ";"
		end if
		//End Code Change---12.14.2007
		
		//$<add> 01.12.2008 by Andy
		ll_pos = PosA(named," from ",1)
		if ll_pos > 1 then
			named = "select distinct v_full_name.prac_id " + MidA(named,ll_pos)
		end if
		//end of add 01.12.2008
		tab_1.tabpage_export_hdr.dw_export_file.setitem(1,"prac_sql",named)
		of_report_audit_set('P', dw_audit, false)   //Start Code Change ----06.16.2016 #V152 maha
	end if	
end if
//Start Code Change ----03.02.2010 #V10 maha
if  dwo.Name = "cb_get_sort" THEN
	long l
	string ls_order

	openwithparm(w_export_sort_select,il_export_id)
	ls_order = message.stringparm
	if ls_order <> "CANCEL" then
		this.setitem(1,"sort_fields",ls_order)
		of_report_audit_set('P', dw_audit, false)   //Start Code Change ----06.16.2016 #V152 maha
	end if
end if
//End Code Change---03.02.2010

//Start Code Change ----08.19.2014 #V14.2 maha
if  dwo.Name = "b_pud" THEN
	string ls_sql

	open(w_export_pud_settings)
	ls_sql = message.stringparm
	if ls_order <> "Cancel" then
		this.setitem(1,"prac_sql",ls_sql)
		of_report_audit_set('P', dw_audit, false)   //Start Code Change ----06.16.2016 #V152 maha
	end if
end if
//End Code Change---08.19.2014


//Start Code Change ----09.22.2014 #V14.2 maha
if dwo.Name = "b_format_help" then
	path = "Delimited text:~r"
	path+= "File saved in a tab delimited text format.~r"
	path+= "Headers are included if defined in the header settings.~r~r"
	path+= "Excel:~r"
	path+= "Saved as an xls file, with headers if so defined.~r~r"
	path+= "Formatted Export:~r"
	path+= "Creates the file based on all of the settings defined including headers and footers, record and field delimiters.~r"
	path+= "HL7 format files typically will use this format.~r~r"
	path+= "CSV:~r"
	path+= "File saved as a .CSV comma delimited file.~r"
	path+= "Any commas in the text values are removed.~r~r"
	path+= "Formated CSV extension:~r"
	path+= "Like a Formatted Export file with the following exceptions:~r"
	path+= "Only header 1 can be used, no footer values.~r"
	path+= "Text file saved as .csv, field delimiters should be used on each field except last.~r"
	path+= "Uses the Text delimiter from the Export settings record to surround each data value.~r"
	path+= "If using a header, all required delimiter forrmating should be included in the header 1 text value as this will be the first row of the file.~r"

	messagebox("About File Formats",path)
	
end if
end event

event itemchanged;call super::itemchanged;//---------Begin Modified by (Appeon)Toney 07.03.2013 for V141 ISG-CLX--------
//$Reason:Lead to loop recursive trigger event
  /*
   if This.GetColumnName() = "export_format" THEN   
  */
 if Lower(dwo.name) = "export_format" THEN 
//---------End Modfiied ------------------------------------------------------------------
	this.accepttext()
	//messagebox("",data)
	//this.prac_sql.y = 1340
	if data = ".txt" or  data = ".xls" then
		this.setitem(1,"field_labels_as_header",1)
	end if
	post of_resize() //(Appeon)Harry 10.23.2014 -  for BugA101404 / BugH052902
end if

//Start Code Change ----10.18.2012 #V12 maha
//---------Begin Modified by (Appeon)Toney 07.03.2013 for V141 ISG-CLX--------
//$Reason:Lead to loop recursive trigger event
  /*
  if This.GetColumnName() = "export_type" THEN 
  */
 if Lower(dwo.name) = "export_type" THEN 
//---------End Modfiied ------------------------------------------------------------------
	//this.accepttext()//(Appeon)Toney 11.14.2013 - V141 ISG-CLX,Fix BugT110801,Depending on the event return value to decide whether to accept the entered value
	choose case data
		//---------Begin Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
		/*
		case "3", "4"
			tab_1.tabpage_field_data.cb_quick.visible = false
			//(Appeon)Toney 11.14.2013 - V141 ISG-CLX,Fix BugT110801,trigger the event in order to refresh data of dropdowndatawindow
			IF dwo.primary[row] <> 3 AND dwo.primary[row] <> 4 THEN THIS.event itemchanged(row,this.object.view_id,string(this.getitemnumber(row,"view_id")))
		*/
		case "3", "4", "6"
			tab_1.tabpage_field_data.cb_quick.visible = false
			//(Appeon)Toney 11.14.2013 - V141 ISG-CLX,Fix BugT110801,trigger the event in order to refresh data of dropdowndatawindow
			IF dwo.primary[row] <> 3 AND dwo.primary[row] <> 4 AND dwo.primary[row] <> 6 THEN THIS.event itemchanged(row,this.object.view_id,string(this.getitemnumber(row,"view_id")))
		//---------End Modfiied ------------------------------------------------------
		case else
			if ib_readonly = false then //Start Code Change ----02.05.2015 #V14.2 maha 
				tab_1.tabpage_field_data.cb_quick.visible = true
			end if
			//---------Begin Added by (Appeon)Toney 07.03.2013 for V141 ISG-CLX--------
			//$Reason:set view id field to default value and refresh the dddw data if this settings will not apply to contract 
			IF This.object.view_id[row] = 1001 THEN
			ELSE
				This.object.view_id[row] = 1001
				This.event itemchanged(row,this.object.view_id,"1001")
			END IF
			//---------End Added ------------------------------------------------------------------
	end choose
end if
//End Code Change ----10.18.2012

//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
//Dynamic change screens/field base on selected view -- jervis 08.06.2009
datawindowchild dwchild
if dwo.name = "view_id" then
	il_view_id = long(data)	
	if isnull(il_view_id) then il_view_id = 1001
	tab_1.tabpage_field_data.dw_detail.GetChild("export_fields_ctx_scrn_id",dwchild)
	dwchild.SetTransObject(sqlca)
	if dwchild.Retrieve(il_view_id) < 1 then	dwchild.insertrow(1)
	tab_1.tabpage_field_data.dw_detail.GetChild("export_fields_ctx_linktoscrnid",dwchild)
	dwchild.SetTransObject(sqlca)
	if dwchild.Retrieve(il_view_id) < 1 then	dwchild.insertrow(1)
end if
//---------End Added ------------------------------------------------------------------

of_report_audit_set('P', dw_audit, false)   //Start Code Change ----06.16.2016 #V152 maha
end event

event pfc_preupdate;call super::pfc_preupdate;//<add> 07/18/2007 by: Andy
if RowCount() < 1 then return 1
//end of add

//Start Code Change ---- 03.01.2006 #305 maha
if this.getitemstatus( 1, 0, primary!) = datamodified! then
	this.setitem(1,"save_path",of_check_path(this.GetItemString( 1, "save_path" ),0)) 
end if

if this.getitemstatus( 1, 0, primary!) = newmodified! then
	
end if

//<add> 07/16/2007 by: Andy
string ls_presentation_str
string ls_sny_retrieve
string ls_dwsyntax_str
string ERRORS
//n_ds lds_export_retrieve
integer li_type
//String  ls_Temp1,ls_Temp2,ls_name
String  ls_prompt_type1,ls_prompt_type2,ls_prompt_type3,ls_temp
n_cst_string lnvo_string
Long ll_pos

ls_sny_retrieve = getitemstring(1,"prac_sql")
ls_prompt_type1 = getitemstring(1,"prompt_type1")
ls_prompt_type2 = getitemstring(1,"prompt_type2")
ls_prompt_type3 = getitemstring(1,"prompt_type3")
//---------Begin Added by (Appeon)Toney 08.09.2013 for V141 ISG-CLX--------
long   ll_viewid
li_type = THIS.GetItemNumber(1,"export_type",Primary!,False)

//IF li_type = 3 OR li_type = 4 THEN
IF li_type = 3 OR li_type = 4 or li_type = 6 THEN  //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)  add li_type = 6
	ll_viewid = THIS.GetItemNumber(1,"view_id",Primary!,False)
	IF IsNull(ll_viewid) OR ll_viewid = 0 THEN
		messagebox(gnv_app.iapp_object.DisplayName,"Required value missing for Base On View on Record 1.~r~nPlease enter a value.")		
		Return Failure
	END IF
END IF
//---------End Added ------------------------------------------------------------------


IF isnull(ls_sny_retrieve) then ls_sny_retrieve = ''
IF isnull(ls_prompt_type1) then ls_prompt_type1 = ''
IF isnull(ls_prompt_type2) then ls_prompt_type2 = ''
IF isnull(ls_prompt_type3) then ls_prompt_type3 = ''

if ls_prompt_type1 = 'C' then 
	ls_prompt_type1 = "''"
elseif ls_prompt_type1 = 'D' then 
	ls_prompt_type1 = "'1900-01-01'"
elseif ls_prompt_type1 = 'N' then 
	ls_prompt_type1 = "0"
elseif ls_prompt_type1 = 'F' then//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT071301,append F option
	ls_prompt_type1 = "0"	
end if


if ls_prompt_type2 = 'C' then 
	ls_prompt_type2 = "''"
elseif ls_prompt_type2 = 'D' then 
	ls_prompt_type2 = "'1900-01-01'"
elseif ls_prompt_type2 = 'N' then 
	ls_prompt_type2 = "0"
end if

if ls_prompt_type3 = 'C' then 
	ls_prompt_type3 = "''"
elseif ls_prompt_type3 = 'D' then 
	ls_prompt_type3 = "'1900-01-01'"
elseif ls_prompt_type3 = 'N' then 
	ls_prompt_type3 = "0"
end if

if LenA(ls_prompt_type1) > 0 and PosA(lower(ls_sny_retrieve),'prompt1') > 0 then 
	ls_sny_retrieve = lnvo_string.of_globalreplace( ls_sny_retrieve, 'prompt1', ls_prompt_type1)
end if

if LenA(ls_prompt_type2) > 0 and PosA(lower(ls_sny_retrieve),'prompt2') > 0 then 
	ls_sny_retrieve = lnvo_string.of_globalreplace( ls_sny_retrieve, 'prompt2', ls_prompt_type2)
end if

if LenA(ls_prompt_type3) > 0 and PosA(lower(ls_sny_retrieve),'prompt3') > 0 then 
	ls_sny_retrieve = lnvo_string.of_globalreplace( ls_sny_retrieve, 'prompt3', ls_prompt_type3)
end if

IF trim(ls_sny_retrieve) <> "" then
	//$<add> 05.06.2008 by Andy
	li_type = GetItemNumber( 1, "export_type" )
	ll_pos = PosA(lower(ls_sny_retrieve)," from ")
	if ll_pos = 0 then ll_pos = PosA(lower(ls_sny_retrieve),"from ")
	ls_temp = LeftA(ls_sny_retrieve,ll_pos - 1)	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 07.19.2012
	//$<reason> DataWindow column type does not match GetItem type
	/*
	if li_type = 3 or li_type = 4 then
		if PosA(lower(ls_temp), "ctx_id") < 1 then
			MessageBox("Caution","The Contract Retrieval SQL must contain the ctx_id column.")		
			RETURN 1
		end if
	else
		if PosA(lower(ls_temp), "prac_id") < 1 then
			MessageBox("Caution","The Practitioner Retrieval SQL must contain the prac_id column.")		
			RETURN 1
		end if		
	end if
	*/
	
	//if li_type = 3 or li_type = 4 then
	if li_type = 3 or li_type = 4 or li_type = 6 then //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)  add li_type = 6
		if PosA(lower(ls_temp), "ctx_id") < 1 then
			MessageBox("Caution","ctx_id must be the first column of the Contract Retrieval SQL.")		
			RETURN 1
		else
			if (PosA(lower(ls_temp), "ctx_id") > PosA(lower(ls_temp), ",")) and  (PosA(lower(ls_temp), ",") > 0)  then
				MessageBox("Caution","ctx_id must be the first column of the Contract Retrieval SQL.")		
				RETURN 1
			end if
		end if
	else
		if PosA(lower(ls_temp), "prac_id") < 1 then
			MessageBox("Caution","prac_id must be the first column of the Practitioner Retrieval SQL.")		
			RETURN 1
		else
			if (PosA(lower(ls_temp), "prac_id") > PosA(lower(ls_temp), ",")) and  (PosA(lower(ls_temp), ",") > 0)  then
				MessageBox("Caution","prac_id must be the first column of the Practitioner Retrieval SQL.")		
				RETURN 1
			end if
		end if	
	end if
	//------------------- APPEON END -------------------
	
	//end add 05.06.2008
	
	ls_presentation_str = "style(type=grid)"		
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Note: Retrieval Query is invalid", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		//RETURN -1
		RETURN 1//Start Code Change ---- 10.01.2007 #V7 maha
	END IF
	
//$<del> 05.06.2008 by Andy
//$<Reason> Allow select more than one field,maybe the old customers have many Retrieval SQL that select more than one field.
//	lds_export_retrieve = CREATE n_ds
//	lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
//	lds_export_retrieve.SetTransObject( SQLCA )
//	
//	li_type = GetItemNumber( 1, "export_type" )
//	if li_type = 3 or li_type = 4 then
//		ls_Temp1 = "The Contract Retrieval SQL"
//		ls_Temp2 = "ctx_id"
//	else
//		ls_Temp1 = "The Practitioner Retrieval SQL"
//		ls_Temp2 = "prac_id"
//	end if

//	//The Practitioner Retrieval SQL can only contain the prac_id column.	
//	if long(lds_export_retrieve.Describe( "DataWindow.Column.Count")) <> 1 then
//		messagebox(gnv_app.iapp_object.DisplayName,ls_Temp1 + " can only contain the " + ls_Temp2 + " column.")
//		if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
//		return -1
//	end if
	
//	ls_name = lds_export_retrieve.Describe( "#1.name")
//	if li_type = 3 or li_type = 4 then
//		if pos(ls_name,"ctx_id") < 1 then
//			messagebox(gnv_app.iapp_object.DisplayName,ls_Temp1 + " can only contain the " + ls_Temp2 + " column.")
//			if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
//			return -1
//		end if		
//	else
//		if pos(ls_name,"prac_id") < 1 then
//			messagebox(gnv_app.iapp_object.DisplayName,ls_Temp1 + " can only contain the " + ls_Temp2 + " column.")
//			if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
//			return -1
//		end if			
//	end if
//	
//	destroy lds_export_retrieve
end if
//end of add

return 1
//End Code Change---03.01.2006


end event

event resize;////long ll_percent,ll_per
//////
////
//////PixelsToUnits ( newwidth, XPixelsToUnits! )
////ll_percent = PixelsToUnits ( newwidth, XPixelsToUnits! )/this.width*100 
////////ll_per=newheight/this.height*100
////messagebox(string(PixelsToUnits ( newwidth, XPixelsToUnits! )),string(this.width))
////this.modify("datawindow.zoom = '" +string(ll_percent) + "'")
//
//
//long ll_width
//long ll_percent
//
//ll_width = pixelstoUnits(newwidth,XPixelsToUnits!)
//ll_percent = ll_width/3365 * 100
//this.modify("datawindow.zoom = '" +string(ll_percent) + "'")
end event

event retrieveend;call super::retrieveend;//---------Begin Modified by (Appeon)Harry 08.05.2014 for BugS072301 in V14.2 Issues of New Feature--------
/*
//Start Code Change ----12.18.2012 #V12 maha
if this.getitemnumber( 1,"export_type") > 2 then
*/
Long ll_export_type
ll_export_type = this.getitemnumber( 1,"export_type")
if ll_export_type > 2 and ll_export_type <> 5 then
//---------End Modfiied ------------------------------------------------------
	tab_1.tabpage_field_data.cb_quick.visible = false
else
	if ib_readonly = false then //Start Code Change ----02.05.2015 #V14.2 maha
		tab_1.tabpage_field_data.cb_quick.visible = True
	end if
end if
//End Code Change ----12.18.2012 	

end event

event rowfocuschanged;call super::rowfocuschanged;//---------Begin Added by (Appeon)Harry 08.12.2014 for BugS072401--------
DataWindowChild dwchild
this.GetChild( "multi_row_table", dwchild )
dwchild.setfilter("table_id < 1000")
dwchild.filter( )
dwchild.insertrow(1)
//---------End Added ------------------------------------------------------
end event

type tabpage_field_data from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3534
integer height = 2020
long backcolor = 33551856
string text = "Columns Properties"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_batch_del cb_batch_del
cb_quick cb_quick
cbx_autosave cbx_autosave
dw_fld_list dw_fld_list
dw_detail dw_detail
cb_add cb_add
cb_delete_col cb_delete_col
cb_insert cb_insert
cb_1 cb_1
cb_reorder cb_reorder
cb_copy cb_copy
st_next st_next
cb_4 cb_4
st_1 st_1
mle_1 mle_1
end type

on tabpage_field_data.create
this.cb_batch_del=create cb_batch_del
this.cb_quick=create cb_quick
this.cbx_autosave=create cbx_autosave
this.dw_fld_list=create dw_fld_list
this.dw_detail=create dw_detail
this.cb_add=create cb_add
this.cb_delete_col=create cb_delete_col
this.cb_insert=create cb_insert
this.cb_1=create cb_1
this.cb_reorder=create cb_reorder
this.cb_copy=create cb_copy
this.st_next=create st_next
this.cb_4=create cb_4
this.st_1=create st_1
this.mle_1=create mle_1
this.Control[]={this.cb_batch_del,&
this.cb_quick,&
this.cbx_autosave,&
this.dw_fld_list,&
this.dw_detail,&
this.cb_add,&
this.cb_delete_col,&
this.cb_insert,&
this.cb_1,&
this.cb_reorder,&
this.cb_copy,&
this.st_next,&
this.cb_4,&
this.st_1,&
this.mle_1}
end on

on tabpage_field_data.destroy
destroy(this.cb_batch_del)
destroy(this.cb_quick)
destroy(this.cbx_autosave)
destroy(this.dw_fld_list)
destroy(this.dw_detail)
destroy(this.cb_add)
destroy(this.cb_delete_col)
destroy(this.cb_insert)
destroy(this.cb_1)
destroy(this.cb_reorder)
destroy(this.cb_copy)
destroy(this.st_next)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.mle_1)
end on

type cb_batch_del from commandbutton within tabpage_field_data
integer x = 3095
integer y = 20
integer width = 402
integer height = 84
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Delete"
end type

event clicked;integer i
integer r

//Start Code Change ----07.19.2016 #V152 maha - audit writing
r = tab_1.tabpage_field_data.dw_fld_list.rowcount()

openwithparm(w_export_field_delete, il_export_id)

i = tab_1.tabpage_field_data.dw_fld_list.Retrieve( il_export_id )

if i <> r then
	of_report_audit_set('C', dw_audit, true)  //Start Code Change ----07.19.2016 #V152 maha
end if
//End Code Change ----07.19.2016

//---------Begin Modified by (Appeon)Harry 11.22.2013 for V141 for BugH101501 of History Issues--------
Long ll_rowcount

ll_rowcount = tab_1.tabpage_field_data.dw_fld_list.RowCount()
if ll_rowcount > 0 then
	tab_1.tabpage_field_data.dw_fld_list.setrow(1)
	tab_1.tabpage_field_data.dw_fld_list.setfocus( )
	tab_1.tabpage_field_data.dw_fld_list.TriggerEvent(clicked!)
else
	 tab_1.tabpage_field_data.dw_detail.reset( )
end if
tab_1.tabpage_field_data.st_next.text = "Next Col " + (string(ll_rowcount+ 1))
//---------End Modfiied ------------------------------------------------------

end event

type cb_quick from commandbutton within tabpage_field_data
integer x = 1408
integer y = 20
integer width = 402
integer height = 84
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quick Select"
end type

event clicked;long ll_orderid,ll_export_type
long ll_currentrow,ll_countrow

ll_orderid = long(dw_fld_list.describe("Evaluate('max(export_order)',0)"))
ll_export_type = tab_1.tabpage_export_hdr.dw_export_file.getitemnumber( 1, "export_type" ) 
openwithparm(w_export_quick_select,string(ll_orderid)+"|"+string(il_export_id)+"!"+string(ll_export_type))

//ll_currentrow = tab_1.tabpage_field_data.dw_fld_list.GetRow()
//ll_countrow = tab_1.tabpage_field_data.dw_fld_list.Retrieve(il_export_id )
//if ll_countrow > 0 and ll_currentrow = 1 then
//	tab_1.tabpage_field_data.dw_fld_list.Trigger Event rowfocuschanged( 1 )
//end if
end event

type cbx_autosave from checkbox within tabpage_field_data
integer x = 27
integer y = 112
integer width = 905
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Auto Save when changing fields"
boolean checked = true
end type

type dw_fld_list from u_dw within tabpage_field_data
integer y = 184
integer width = 960
integer height = 1836
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_export_flds_list"
end type

event constructor;This.SetRowFocusIndicator( p_1 )
This.of_SetReqColumn( TRUE )
This.of_SetTransObject( SQLCA )

end event

event rowfocuschanged;call super::rowfocuschanged;Integer li_table_id
long recid
long ll_field
long ll_find
string ls_lookup_type
string ls_type_filter
String ls_field_name, ls_filter_addtl //alfee 01.27.2010
datawindowchild dwchild

//IF NOT lb_new THEN
//	dw_detail.ScrollToRow( currentrow )
//	dw_detail.SetRow( currentrow )
//END IF
IF currentrow < 1 THEN
	Return
END IF

recid = this.getitemnumber(currentrow,"rec_id")
il_recid = recid
dw_detail.settransobject(sqlca)
dw_detail.retrieve(recid )

IF dw_detail.RowCount() > 0 THEN
	li_table_id = dw_detail.GetItemNumber( 1, "intcred_table" )
	dw_detail.GetChild( "intcred_field", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( li_table_id )
	dwchild.insertrow(1)//maha
	dwchild.setitem(1,"table_id",0)//maha
	//dwchild.setitem(1,"table_name_allias","None")//maha
	//Start Code Change ----10.23.2008 #V85 maha - filter field list
	ll_field = dw_detail.getitemnumber(1,"intcred_field")
	ll_find = dwchild.Find("field_id=" + string(ll_field),1,dwchild.RowCount())
	if ll_find > 0 then
		ls_field_name = dwchild.GetItemString(ll_find,"field_name")
		ls_lookup_type = dwchild.GetItemString(ll_find,"lookup_type")
		//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
		//$Reason:Restore the initial data
		of_restore_lookupfieldname()
		//---------End Added ------------------------------------------------------------------
		dw_detail.GetChild( "lu_field_name", dwchild ) //set list filter

		//-----Begin Added by alfee 01.27.2010 --------
		//<$Reason>Privilege export
		if Upper(ls_lookup_type) = 'D' then //DDDW lookup type
			if li_table_id = 90 then //priviliege
				choose case lower(ls_field_name)
					case "clinical_area_id"
						ls_filter_addtl = " and left(field_name, 4) = 'Dept'"
					case "priv_core_id"
						ls_filter_addtl = " and left(field_name, 4) = 'Sect'"
					case "procd_id"
						ls_filter_addtl = " and left(field_name, 4) = 'Proc'"			
				end choose
			elseif li_table_id = 91 then //pd_comm_review added by long.zhang 01.21.2013
				choose case lower(ls_field_name)
					case "meeting_id"
						ls_filter_addtl = " and left(field_name,7) = 'Meeting' "
					case "committee_id"
						ls_filter_addtl = " and left(field_name, 9) = 'Committee'"
					end choose		
			end if
		end if
		//-----End Added -------------------------------				
		
		if LenA(ls_lookup_type) > 0 then
			//This.GetChild( "lu_field_name", dwchild )//Added by  Nova 10.09.2009
			choose case ls_lookup_type
				case "A","C"
					ls_type_filter  = "type = '" + ls_lookup_type + "' or type = 'B'"
				case else
					ls_type_filter  = "type = '" + ls_lookup_type + "'"
					ls_type_filter += ls_filter_addtl //alfee 01.27.2010
			end choose
			integer res
			res = dwchild.setfilter(ls_type_filter )
			if res < 1 then
				messagebox("rowfocuschanged;  filter failed",ls_type_filter )
			else
				dwchild.filter()
			end if
		end if
	end if
	//End Code Change---10.23.2008
END IF

dw_detail.event itemchanged(1, dw_detail.object.export_fields_module_type, String(dw_detail.getitemnumber(1, 'export_fields_module_type')))  //(Appeon)Harry 08.05.2014 - for BugS072301 in V14.2 Issues of New Feature

of_EnabledFacilityProp(false) // Add by Evan 05.15.2009 --- Corrected BugG122804
	

end event

event clicked;call super::clicked;Integer li_row
//integer recid
//datawindowchild dwchild
//
li_row = this.getclickedrow() 
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.28.2006 By: Liu Hongxin
//$<reason> Fix a defect.
/*
if li_row < 1 THEN
	Return
END IF

if cbx_autosave.checked then //maha 061405
	//if tab_1.tabpage_field_data.dw_detail.getitemstatus(1,0,primary!) = newmodified! or tab_1.tabpage_field_data.dw_detail.getitemstatus(1,0,Primary!) = datamodified! then
		setredraw( false)
		cb_save.triggerevent(clicked!)
*/
if li_row < 1 or li_row = this.GetRow() THEN
	Return
END IF

if cbx_autosave.checked then //maha 061405
		setredraw( false)
		dw_detail.accepttext() //Start Code Change ---- 12.06.2006 #V7 maha
		if dw_detail.ModifiedCount() > 0 then
			cb_save.triggerevent(clicked!)
		end if
//---------------------------- APPEON END ----------------------------

		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-01
		//$<comment> 04.28.2006 By: Liu Hongxin
		//$<reason> Performance tuning.
		//$<modification> Comment out the following script since cb_save has alreay provided the same
		//$<modification> functionality.
		/*
		this.setrow(li_row)
		this.scrolltorow(li_row)
		*/
		//---------------------------- APPEON END ----------------------------
		setredraw( true)
	//end if
end if

//
//recid = this.getitemnumber(row,"rec_id")
//
//dw_detail.settransobject(sqlca)
//
//dw_detail.retrieve(recid )
//

//IF dw_detail.RowCount() > 0 THEN
//	li_table_id = dw_detail.GetItemNumber( dw_detail.getrow(), "intcred_table" )
//	dw_detail.GetChild( "intcred_field", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( li_table_id )
////	dwchild.insertrow(1)//maha
////	dwchild.setitem(1,"table_id",0)//maha
////	dwchild.setitem(1,"table_name_allias","None")//maha
//END IF


end event

type dw_detail from u_dw within tabpage_field_data
event ue_generate_dddw ( string dwoname,  string data,  integer row,  ref boolean ab_ctx_id_existed )
event ue_column_check ( string data,  integer row )
event ue_set_reqfilter ( long al_req_id )
integer x = 969
integer y = 184
integer width = 2551
integer height = 1836
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_export_flds_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_generate_dddw(string dwoname, string data, integer row, ref boolean ab_ctx_id_existed);//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
  /*


		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-11-28 By: Rodger Wu
		
		datastore lds_ctx
		datawindowchild ldwc_ctxscrn, ldwc_fields, ldwc_linkfromcolumn
		string ls_table, ls_colname, ls_dbname, ls_temp, ls_label, ls_dataobject
		integer li_found, li_cols, i, li_inserted, li_getrow
		String  ls_DataTypeTemp,ls_DataType//<add> andy 2007.05.23
		
		This.GetChild( dwoname, ldwc_ctxscrn )
		li_found = ldwc_ctxscrn.Find( "screen_id = " + string( data ), 1, ldwc_ctxscrn.rowcount() )
		if li_found > 0 then
			ls_dataobject = ldwc_ctxscrn.GetItemString( li_found, "dataobject" )
			This.GetChild( "export_fields_ctx_column_name", ldwc_fields )
			ldwc_fields.reset()
		
			This.GetChild( "export_fields_ctx_linkfromcolumn", ldwc_linkfromcolumn )
			ldwc_linkfromcolumn.reset()
			
			lds_ctx = create datastore
			lds_ctx.dataobject = ls_dataobject
			
			ls_table = lower( lds_ctx.Describe( "Datawindow.table.updatetable" ) )
			li_cols = integer( lds_ctx.Describe( "DataWindow.Column.Count" ) )
		
			if row > 0 then
				This.SetItem( row, "export_fields_ctx_scrn_dataobject", ls_dataobject )
			end if
			
			for i = 1 to li_cols
				ls_dbname = lower( lds_ctx.Describe("#"+string( i ) + ".dbname") )
				ls_temp = f_get_token( ls_dbname, '.' )
		
				ls_colname = lower( lds_ctx.Describe("#"+string( i ) + ".name") )
				ls_label = lds_ctx.Describe( ls_colname + "_t.text")
				if ls_label = "?" or ls_label = "!" then ls_label = ""
				if ls_label = '' then ls_label = ls_dbname
		
				//<add> andy 2007.05.23
				ls_DataType = ''
				ls_DataTypeTemp = lower( lds_ctx.Describe("#"+string( i ) + ".ColType") )
				choose case LeftA(ls_DataTypeTemp,5)
					case 'char('
						ls_DataType = 'S'
					case 'date','datet'
						ls_DataType = 'D'
					case 'decim','int','long','number','real','ulong'
						ls_DataType = 'N'
				end choose
				//end of add
				
				if ls_temp = ls_table then
					li_inserted = ldwc_fields.insertrow( 0 )
					ldwc_fields.setitem( li_inserted, "field_name", ls_colname )
					ldwc_fields.setitem( li_inserted, "field_name_alias", ls_label )
					//<add> andy 2007.05.23
					ldwc_fields.setitem( li_inserted, "field_datatype", ls_DataType )
					//end of add
					
					li_inserted = ldwc_linkfromcolumn.insertrow( 0 )
					ldwc_linkfromcolumn.setitem( li_inserted, "field_name", ls_colname )
					ldwc_linkfromcolumn.setitem( li_inserted, "field_name_alias", ls_label )
				end if
		
				if Not ab_ctx_id_existed then
					if lower( ls_dbname ) = "ctx_id" then ab_ctx_id_existed = true
				end if	
			next
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03.26.2007 By: Jack (Export)
			//$<reason> Fix a defect.
			
			If ls_dataobject = 'd_contract_det_contact_external' Then
				li_inserted = ldwc_fields.insertrow( 0 )
				ldwc_fields.setitem( li_inserted, "field_name", 'compute_1' )
				ldwc_fields.setitem( li_inserted, "field_name_alias", 'Name' )
				//<add> andy 2007.06.04
				ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
				//end of add
				
				li_inserted = ldwc_linkfromcolumn.insertrow( 0 )
				ldwc_linkfromcolumn.setitem( li_inserted, "field_name", 'compute_1' )
				ldwc_linkfromcolumn.setitem( li_inserted, "field_name_alias", 'Name' )
				
				li_inserted = ldwc_fields.insertrow( 0 )
				ldwc_fields.setitem( li_inserted, "field_name", 'contact_phone' )
				ldwc_fields.setitem( li_inserted, "field_name_alias", 'Contact Phone' )
				//<add> andy 2007.06.04
				ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
				//end of add
				
				li_inserted = ldwc_linkfromcolumn.insertrow( 0 )
				ldwc_linkfromcolumn.setitem( li_inserted, "field_name", 'contact_phone' )
				ldwc_linkfromcolumn.setitem( li_inserted, "field_name_alias", 'Contact Phone' )
				
				li_inserted = ldwc_fields.insertrow( 0 )
				ldwc_fields.setitem( li_inserted, "field_name", 'contact_email' )
				ldwc_fields.setitem( li_inserted, "field_name_alias", 'Contact Email' )
				//<add> andy 2007.06.04
				ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
				//end of add
				
				li_inserted = ldwc_linkfromcolumn.insertrow( 0 )
				ldwc_linkfromcolumn.setitem( li_inserted, "field_name", 'contact_email' )
				ldwc_linkfromcolumn.setitem( li_inserted, "field_name_alias", 'Contact Email' )
			End If	
			//---------------------------- APPEON END ----------------------------
		end if
		//---------------------------- APPEON END ----------------------------
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Add> 08.23.2007 By: Evan
		//$<Reason> Need to destroy object.
		if IsValid(lds_ctx) then Destroy lds_ctx
		//---------------------------- APPEON END ----------------------------
		
  */
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-28 By: Rodger Wu

//datawindow dw_screen
datawindowchild ldwc_ctxscrn, ldwc_fields, ldwc_linkfromcolumn
string ls_table, ls_colname, ls_dbname, ls_temp, ls_label, ls_dataobject
integer li_found, li_cols, i, li_inserted, li_getrow
String  ls_DataTypeTemp,ls_DataType//<add> andy 2007.05.23
string ls_dwsyntax
string ls_tab_name
datawindow ldw[]
string ls_dw_name[]
string ls_dataobjects[]
string ls_dddw_data
string ls_dddw_display
string ls_format
string ls_export_name


This.GetChild( dwoname, ldwc_ctxscrn )
li_found = ldwc_ctxscrn.Find( "screen_id = " + string( data ), 1, ldwc_ctxscrn.rowcount() )
if li_found > 0 then
	This.GetChild( "export_fields_ctx_column_name", ldwc_fields )
	This.GetChild( "export_fields_ctx_linkfromcolumn", ldwc_linkfromcolumn )
	ldwc_fields.SetFilter("field_screen = " + string(data))
	ldwc_fields.Filter( )
	ldwc_linkfromcolumn.SetFilter("field_screen = " + string(data))
	ldwc_linkfromcolumn.Filter( )
	
	if data = '12' then	//12-Exprot Profile Detail- jervis 03.17.2009
		ls_dataobject = 'd_export_contract_profile'
	else
		ls_dataobject = ldwc_ctxscrn.GetItemString( li_found, "dataobject" )
	end if
	
	if row > 0 then
		This.SetItem( row, "export_fields_ctx_scrn_dataobject", ls_dataobject )
	end if
		
	if ldwc_fields.RowCount() < 1 then   
		dw_screen.dataobject = ls_dataobject
		
		If ls_dataobject = 'd_contract_det_contact_external' Then
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'compute_1' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Name' )
			//<add> andy 2007.06.04
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			//end of add
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			
			li_inserted = ldwc_linkfromcolumn.insertrow( 0 )
			ldwc_linkfromcolumn.setitem( li_inserted, "field_name", 'compute_1' )
			ldwc_linkfromcolumn.setitem( li_inserted, "field_name_alias", 'Name' )
			ldwc_linkfromcolumn.setitem( li_inserted, "field_screen", data )
			
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'contact_phone' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Contact Phone' )
			//<add> andy 2007.06.04
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			//end of add
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			
			li_inserted = ldwc_linkfromcolumn.insertrow( 0 )
			ldwc_linkfromcolumn.setitem( li_inserted, "field_name", 'contact_phone' )
			ldwc_linkfromcolumn.setitem( li_inserted, "field_name_alias", 'Contact Phone' )
			ldwc_linkfromcolumn.setitem( li_inserted, "field_screen", data )
			
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'contact_email' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Contact Email' )
			//<add> andy 2007.06.04
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			//end of add
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			
			li_inserted = ldwc_linkfromcolumn.insertrow( 0 )
			ldwc_linkfromcolumn.setitem( li_inserted, "field_name", 'contact_email' )
			ldwc_linkfromcolumn.setitem( li_inserted, "field_name_alias", 'Contact Email' )
			ldwc_linkfromcolumn.setitem( li_inserted, "field_screen", data )
			
			//Add contact_id and association -- jervis 01.28.2011
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'contact_id' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Contact ID' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'N' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			   
			 
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )  //(Appeon)Harry 01.23.2014 - V142 ISG-CLX
			
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'Facility_id' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Company ID' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'N' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'P' )
					
			//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association2' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association2' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association3' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association3' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association4' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association4' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association5' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association5' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association6' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association6' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association7' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association7' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association8' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association8' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association9' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association9' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )
			li_inserted = ldwc_fields.insertrow( 0 )
			ldwc_fields.setitem( li_inserted, "field_name", 'association10' )
			ldwc_fields.setitem( li_inserted, "field_name_alias", 'Association10' )
			ldwc_fields.setitem( li_inserted, "field_datatype", 'S' )
			ldwc_fields.setitem( li_inserted, "field_screen", data )
			ldwc_fields.SetItem( li_inserted, "field_type", 'C' )
			//---------End Added ------------------------------------------------------
		else
			//dw_screen = create u_dw		
			//Dynamic generate dddw base on view -- jervis 08.06.2009
			if data <> '12' and long(data) < 1000 then	
				ls_tab_name = gnv_data.of_get_table_name( long(data), 'C', 'tab_name')
		
				ldw[1] = dw_screen
				
				ls_dw_name[1] 		= gnv_data.of_get_table_name( long(data), 'C', 'dw_name')
				ls_dataobjects[1] 	= ls_dataobject //gnv_data.of_get_table_name( long(data), 'C', 'dataobject')
				
				f_create_contract_dw(il_view_id,ls_tab_name,ldw,ls_dw_name,ls_dataobjects)
			end if
			
			ls_table = lower( dw_screen.Describe( "Datawindow.table.updatetable" ) )
			li_cols = integer( dw_screen.Describe( "DataWindow.Column.Count" ) )
			If ls_dataobject = 'd_org_search2' And ls_Table = 'ctx_orgs_contact' Then ls_Table = 'ctx_orgs' //added by gavins 20130314
			for i = 1 to li_cols
				if dw_screen.Describe("#"+string( i ) + ".visible") = "0" then 
					if data <> "2002" then continue //Jervis 09.19.2010
				end if
				ls_dbname = lower( dw_screen.Describe("#"+string( i ) + ".dbname") )
				if pos(ls_dbname,".") > 0 then	//If Exists Table selection- jervis 03.17.2009
					ls_temp = f_get_token( ls_dbname, '.' )
				end if
				
		
				ls_colname = lower( dw_screen.Describe("#"+string( i ) + ".name") )
				ls_label = dw_screen.Describe( ls_colname + "_t.text")
				if ls_label = "?" or ls_label = "!" then ls_label = ""
				if ls_label = '' then ls_label = ls_dbname
				ls_format = dw_screen.Describe("#"+string( i ) + ".format") //jervis 09.06.2010
		
				//<add> andy 2007.05.23
				ls_DataType = ''
				ls_DataTypeTemp = lower( dw_screen.Describe("#"+string( i ) + ".ColType") )
				choose case left(ls_DataTypeTemp,5)
					case 'char('
						ls_DataType = 'S'
					case 'date','datet'
						ls_DataType = 'D'
					case 'decim','int','long','number','real','ulong'
						ls_DataType = 'N'
				end choose
				//end of add
				
				
				
				//if ls_temp = ls_table then
				if ls_temp = ls_table  or data = '12' then	//12-Export Profile detail-jervis 03.17.2009
					li_inserted = ldwc_fields.insertrow( 0 )
					ldwc_fields.setitem( li_inserted, "field_name", ls_colname )
					//ldwc_fields.setitem( li_inserted, "field_name", ls_dbname )	//03.16.2009 by Jervis
					ldwc_fields.setitem( li_inserted, "field_name_alias", ls_label )
					//<add> andy 2007.05.23
					ldwc_fields.setitem( li_inserted, "field_datatype", ls_DataType )
					//end of add
					ldwc_fields.setitem( li_inserted, "field_screen", data )	//08.07.2009 by jervis
					
					li_inserted = ldwc_linkfromcolumn.insertrow( 0 )
					//ldwc_linkfromcolumn.setitem( li_inserted, "field_name", ls_colname )
					ldwc_linkfromcolumn.setitem( li_inserted, "field_name", ls_colname ) //03.16.2009 by Jervis
					ldwc_linkfromcolumn.setitem( li_inserted, "field_name_alias", ls_label )
					ldwc_linkfromcolumn.setitem( li_inserted, "field_screen", data )	//08.07.2009 by jervis
					
					//Add field format - jervis 09.06.2010
					if ls_format <> "" and ls_format <> "?" then
						ldwc_fields.setitem( li_inserted, "field_format", ls_format )
					end if
					
					//Get DDDW Type -- jervis 11.26.2009
					ls_dddw_data = lower( dw_screen.Describe( "#"+string( i ) + ".dddw.datacolumn" ) )
					if ls_dddw_data = 'lookup_code' then
						ldwc_fields.SetItem(li_inserted,"field_type","C")
						//Add display name = jervis 09.06.2010
						ls_dddw_display = lower( dw_screen.Describe( "#"+string( i ) + ".dddw.displaycolumn" ) )
						ldwc_fields.SetItem(li_inserted,"field_display_name",ls_dddw_display)
					//elseif ls_dddw_data = 'facility_id' and dw_screen.Describe("#"+string( i ) + ".dddw.name") = 'd_dddw_company' then
					elseif ls_dddw_data = 'facility_id' and (dw_screen.Describe("#"+string( i ) + ".dddw.name") = 'd_dddw_company' or dw_screen.Describe("#"+string( i ) + ".dddw.name") = 'd_dddw_company_list') then
						ldwc_fields.SetItem(li_inserted,"field_type","P")
					end if
					
				end if
		
				//if Not ab_ctx_id_existed then
				//	if lower( ls_dbname ) = "ctx_id" then ab_ctx_id_existed = true
				//end if	
			next
		end if
		
		if len(dw_screen.Describe( "ctx_id.name")) > 1 then
			 ab_ctx_id_existed = true
		end if
		
	end if
	//Sort by field name
	ldwc_fields.Sort()
	ldwc_linkfromcolumn.Sort( )
end if
//---------------------------- APPEON END ---------------------------- 
//---------End Modfiied ------------------------------------------------------------------
end event

event ue_column_check(string data, integer row);//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
  /*      

		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-11-29 By: Rodger Wu (doc painter)
		//$<reason> New event.
		
		datastore lds_dataobject
		string ls_dataobject, ls_temp
		char lc_null
		
		SetNull( lc_null )
		
		ls_dataobject = This.GetItemString( row, "export_fields_ctx_scrn_dataobject" )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.20.2007 By: Jack (Export)
		//$<reason> Fix a defect.
		/*
		lds_dataobject = create datastore
		lds_dataobject.dataobject = ls_dataobject
		ls_temp = lower( lds_dataobject.Describe( data + ".dddw.datacolumn" ) )
		*/
		//If ls_dataobject = 'd_contract_det_contact_external' And data = 'contact_id' Then
		//Modified by Nova on 2008-08-22
		If ( ls_dataobject = 'd_contract_det_contact_external' or ls_dataobject = 'd_contract_det_contact_contact' or ls_dataobject = 'd_contract_det_contact_contact_notes') And data = 'contact_id' Then
			ls_temp = 'contact_id'
		Else
			lds_dataobject = create datastore
			lds_dataobject.dataobject = ls_dataobject
			ls_temp = lower( lds_dataobject.Describe( data + ".dddw.datacolumn" ) )
		End If
		//---------------------------- APPEON END ----------------------------
		if ls_temp = '?' or ls_temp = '!' then
			This.SetItem( row, "export_fields_ctx_lookup_type", lc_null )
			This.SetItem( row, "lu_field_name", lc_null )
		elseif ls_temp = "lookup_code" then
			This.SetItem( row, "export_fields_ctx_lookup_type", 'C' )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.20.2007 By: Jack (Export)
		//$<reason> Fix a defect.
		/*
		else
			This.SetItem( row, "export_fields_ctx_lookup_type", lc_null )	
			This.SetItem( row, "lu_field_name", lc_null )
		*/
		elseif ls_temp = 'facility_id' and This.getitemstring(row,'export_field_name') = 'company_id' Then
			This.SetItem( row, "export_fields_ctx_lookup_type", 'C' )
		elseif ls_temp = 'contact_id' Then
			This.SetItem( row, "export_fields_ctx_lookup_type", 'C' )
		else
			This.SetItem( row, "export_fields_ctx_lookup_type", lc_null )	
			This.SetItem( row, "lu_field_name", lc_null )
		//---------------------------- APPEON END ----------------------------
		end if
		
		//---------------------------- APPEON END ----------------------------
  */
 //--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> New event.

datastore lds_dataobject
string ls_dataobject, ls_temp
char lc_null
datawindowchild dwchild
long ll_find
SetNull( lc_null )

ls_dataobject = This.GetItemString( row, "export_fields_ctx_scrn_dataobject" )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.20.2007 By: Jack (Export)
//$<reason> Fix a defect.
/*
lds_dataobject = create datastore
lds_dataobject.dataobject = ls_dataobject
ls_temp = lower( lds_dataobject.Describe( data + ".dddw.datacolumn" ) )
*/
//If ls_dataobject = 'd_contract_det_contact_external' And data = 'contact_id' Then
//Modified by Nova on 2008-08-22
If ( ls_dataobject = 'd_contract_det_contact_external' or ls_dataobject = 'd_contract_det_contact_contact' or ls_dataobject = 'd_contract_det_contact_contact_notes') And data = 'contact_id' Then
	ls_temp = 'contact_id'
//Add by jervis 03.16.2009
//Export Requirements Profile data
elseif ls_dataobject = 'd_profile_header' and data = 'ctx_req_profile_id' then
	ls_temp = data
//Add by Jervis 06.09.2009
elseif ls_dataobject = 'd_contract_group_linked_locations' and data = 'loc_id' then
	ls_temp = data
elseif ls_dataobject = "d_contract_multi_group_browse" and data = "parent_comp_id" then
	ls_temp = data
Else
	//comment by jervis 11.26.2009
	/*
	lds_dataobject = create datastore
	lds_dataobject.dataobject = ls_dataobject
	ls_temp = lower( lds_dataobject.Describe( data + ".dddw.datacolumn" ) )
	*/
	//Add Comany dddw process -- Jervis 12.9.2009
	ls_temp = data
	if isnull(ls_temp) then ls_temp = ''
	if this.getchild("export_fields_ctx_column_name",dwchild) = 1 then
		ll_find = dwchild.find("field_name = '" + ls_temp +"'",1,dwchild.rowcount())
		If ll_find > 0 Then ls_temp = dwchild.GetItemString(ll_find,"field_type")
	End If
End If
//---------------------------- APPEON END ----------------------------
if ls_temp = '?' or ls_temp = '!' then
	This.SetItem( row, "export_fields_ctx_lookup_type", lc_null )
	This.SetItem( row, "lu_field_name", lc_null )
elseif ls_temp = "lookup_code" or ls_temp = "C" then
	This.SetItem( row, "export_fields_ctx_lookup_type", 'C' )
elseif ls_temp = "P" then	//Company dddw -- jervis 12.9.2009
	This.SetItem( row, "export_fields_ctx_lookup_type", 'P' )
	
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.20.2007 By: Jack (Export)
//$<reason> Fix a defect.
/*
else
	This.SetItem( row, "export_fields_ctx_lookup_type", lc_null )	
	This.SetItem( row, "lu_field_name", lc_null )
*/
elseif ls_temp = 'facility_id' and This.getitemstring(row,'export_field_name') = 'company_id' Then
	This.SetItem( row, "export_fields_ctx_lookup_type", 'C' )
elseif ls_temp = 'contact_id' Then
	This.SetItem( row, "export_fields_ctx_lookup_type", 'C' )
elseif ls_temp = 'ctx_req_profile_id' then	//Jervis 03.16.2009
	This.SetItem( row, "export_fields_ctx_lookup_type", 'R' )
elseif ls_temp = "loc_id" then
	This.SetItem( row, "export_fields_ctx_lookup_type", 'L' ) // Jervis 06.09.2009
elseif ls_temp = "parent_comp_id" then	//06.23.2009 by jervis
	This.SetItem( row, "export_fields_ctx_lookup_type", 'M' ) 
else
	This.SetItem( row, "export_fields_ctx_lookup_type", lc_null )	
	This.SetItem( row, "lu_field_name", lc_null )
//---------------------------- APPEON END ----------------------------
end if

//---------------------------- APPEON END ----------------------------
//---------End Modfiied ------------------------------------------------------------------
		
end event

event ue_set_reqfilter(long al_req_id);//Set Req Filter
//ctx_req_profile_hdr.ctx_req_profile_id = 1 and 
//ctx_rqmnt_category.category_name = 'Categroy two' and
//ctx_req_tmplt_element.element_name = 'two-Req-two'

long ll_profield_id
string ls_category_name
string ls_req_name
string ls_filter

select element_name,ctx_req_tmplt_element.ctx_req_profile_id,category_name 
into :ls_req_name,:ll_profield_id,:ls_category_name
from ctx_req_tmplt_element,ctx_rqmnt_category
where ctx_req_tmplt_element.ctx_rqmnt_category_id = ctx_rqmnt_category.ctx_rqmnt_category_id 
	and ctx_req_tmplt_element.ctx_req_profile_id = ctx_rqmnt_category.ctx_req_profile_id 
	and ctx_req_tmplt_element_id = :al_req_id;

ls_filter = "ctx_req_profile_hdr.ctx_req_profile_id = " + string(ll_profield_id) + &
				" and ctx_rqmnt_category.category_name = '" + ls_category_name + "' " + &
				" and ctx_req_tmplt_element.element_name = '" + ls_req_name + "'"
				
this.SetItem( 1,"filter_query",ls_filter)
end event

event constructor;This.of_SetReqColumn( TRUE )
//This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )

DataWindowChild dwchild

This.GetChild( "facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)

//This.GetChild( "lu_field_name", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve()
//dwchild.insertrow(1)

//Start Code Change ----03.18.2016 #V15 maha - removed
//--------Begin Added by Nova 11.05.2007------------------------
//this.of_setresize(true)
//this.inv_resize.of_setorigsize( this.width,this.height)
//this.inv_resize.of_setminsize( this.width,this.height)
//this.inv_resize.of_register(this.inv_resize.scale)
//this.inv_resize.of_SetDetailHeight(true)
//--------End Added --------------------------------------------
//End Code Change ----03.18.2016





end event

event itemchanged;call super::itemchanged;integer e, li_null
long ll_find
long ll_table_id //alfee 01.26.2010
string ls_field_name, ls_filter_addtl //alfee 01.26.2010
string ls_null
String ls_field,ls_DataType
string ls_lookup_type 
string ls_type_filter 
long   ll_data  //add by stephen 04.17.2013

datawindowchild dwchild

IF This.GetColumnName() = "intcred_table" THEN
	This.GetChild( "intcred_field", dwchild )
	dwchild.SetTransObject( SQLCA )
	il_table_id = 	Integer( data )
	dwchild.Retrieve(il_table_id )
	this.AcceptText()
	of_EnabledFacilityProp(true)
END IF

IF This.GetColumnName() = "intcred_field" THEN
	This.accepttext()
	This.GetChild( "intcred_field", dwchild )
	dwchild.SetTransObject( SQLCA )
	
	ll_find = dwchild.Find("field_id=" + data,1,dwchild.RowCount())
	if ll_find > 0 then 
		ls_DataType = dwchild.GetItemString(ll_find,"field_type")
		ls_lookup_type = dwchild.GetItemString(ll_find,"lookup_type")
		if isnull(ls_DataType) then ls_DataType = ''
		if UPPER(ls_DataType) = 'L' OR UPPER(ls_DataType) = 'I' THEN ls_DataType = 'N'
		if UPPER(ls_DataType) = 'C' THEN ls_DataType = 'S'
		//-----Begin Added by alfee 01.26.2010 --------
		//<$Reason>Privilege export
		ll_table_id = dwchild.GetItemNumber(ll_find,"table_id") 
		ls_field_name = dwchild.GetItemString(ll_find,"field_name") 
		if Upper(ls_lookup_type) = 'D' then //DDDW lookup type
			if ll_table_id = 90 then //priviliege
				choose case lower(ls_field_name)
					case "clinical_area_id"
						ls_filter_addtl = " and left(field_name, 4) = 'Dept'"
					case "priv_core_id"
						ls_filter_addtl = " and left(field_name, 4) = 'Sect'"
					case "procd_id"
						ls_filter_addtl = " and left(field_name, 4) = 'Proc'"			
				end choose
			elseif ll_table_id = 91 then //pd_comm_review added by long.zhang 01.21.2013
				choose case lower(ls_field_name)
					case "meeting_id"
						ls_filter_addtl = " and left(field_name,7) = 'Meeting' "
					case "committee_id"
						ls_filter_addtl = " and left(field_name, 9) = 'Committee'"
					end choose	
			end if
		end if
		//-----End Added -------------------------------
		
		//Start Code Change ----08.22.2017 #V154 maha - set field name from selected field if null
		if isnull(this.getitemstring(row, "export_field_name")) then
			this.setitem(row, "export_field_name" , ls_field_name)
		end if
		//End Code Change ----08.22.2017
		
		setitem(row,'ctx_column_datatype',ls_DataType)
		setitem(row,'db_lookup_type',ls_lookup_type)
		
		if LenA(ls_lookup_type) > 0 then
			//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
			//$Reason:Restore the initial data
			of_restore_lookupfieldname()
			//---------End Added ------------------------------------------------------------------
			This.GetChild( "lu_field_name", dwchild )
			choose case ls_lookup_type
				case "A","C"
					ls_type_filter  = "type = '" + ls_lookup_type + "' or type = 'B'"
				case "G"   //Start Code Change ----08.20.2012 #V12 maha - Standing Flag
					ls_type_filter  = "type = '" + ls_lookup_type + "'"
				case else
					ls_type_filter  = "type = '" + ls_lookup_type + "'"
					ls_type_filter += ls_filter_addtl //Privilege export - alfee 01.26.2010
			end choose
			integer res
			res = dwchild.setfilter(ls_type_filter )
			if res < 1 then
				messagebox("itemchanged;  filter failed",ls_type_filter )
			else
				dwchild.filter()
			end if
		end if
	end if
END IF

IF This.GetColumnName() = "export_fields_export_type" THEN
	if integer(data) = 2 then
		this.setitem(row,"export_fields_ctx_scrn_id",0)
		this.setitem(row,"export_fields_ctx_column_name",'')
		this.setitem(row,"ctx_column_datatype",'S')
		this.setitem(1,"intcred_record_number",0)
		this.setitem(1,"intcred_table",0)
		this.setitem(1,"intcred_field",0)
		setnull( ls_null )
		this.setitem(1,"export_fields_ctx_lookup_type",ls_Null)
	elseif integer(data) = 1 then
		this.setitem(1,"intcred_record_number",1)
		SetNull(li_null)
		This.SetItem( row, "export_fields_ctx_scrn_id", li_null)
	elseif long(data) = 3 then
		this.setitem(row,"export_fields_ctx_scrn_id",0)
		this.setitem(row,"export_fields_ctx_scrn_dataobject",'')
		this.setitem(row,"export_fields_ctx_column_name",'')
		this.setitem(row,"intcred_table",0)
		this.setitem(row,"intcred_field",0)
		setnull( ls_null )
		this.setitem(1,"export_fields_ctx_lookup_type",ls_Null)
		//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
		this.SetItem(1,"record_level",'C') //05.12.2009 by jervis		
		//---------End Added ------------------------------------------------------------------
	end if

	of_setui(long(data))
END IF

if This.GetColumnName() = "export_code" THEN
	//---------Begin Added by (Appeon)Harry 04.07.2015 for Allegheny export issue--------
	/*
	//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------	
	  /*
		this.setitem(1,"lu_field_name","lookup_code")	
	  */
	 //Only code Lookup -- jervis 08.07.2009
	this.GetChild( "lu_field_name",dwchild)
	if isnumber(dwchild.Describe("lookup_code.x")) then
		this.setitem(1,"lu_field_name","lookup_code")
	end if
	//---------End Modfiied ------------------------------------------------------------------	
	*/
	if data = '1' then
		this.setitem(1,"lu_field_name","Lookup_Code")
	end if
	//---------End Added ------------------------------------------------------
end if

if This.GetColumnName() = "dept_sect_field" THEN
		this.setitem(1,"lu_field_name","lookup_code")
end if

boolean lb_ctx_id_existed

if dwo.name = "export_fields_ctx_scrn_id" then
	This.Trigger Event ue_generate_dddw( dwo.name, data, row, lb_ctx_id_existed )
	setnull( ls_null )
	This.SetItem( row, "export_fields_ctx_column_name", ls_null )
	This.SetItem( row, "export_fields_ctx_lookup_type", ls_null )
	This.SetItem( row, "lu_field_name", ls_null )	

	If data = '2003' Then lb_ctx_id_existed = True
	if lb_ctx_id_existed then
		This.SetItem( row, "export_fields_ctx_uselink", 0 )
	else
		This.SetItem( row, "export_fields_ctx_uselink", 1 )
	end if
	//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
	  /*
		setnull( li_null )
		This.SetItem( row, "export_fields_ctx_linkfromcolumn", ls_null )
		This.SetItem( row, "export_fields_ctx_linktoscrnid", li_null )
		This.SetItem( row, "export_fields_ctx_linktocolumn", ls_null )			
	  */
	if data = "12" then  //Set Default link for Profile detail -- 06.25.2009 by jervis
		this.SetItem(row,"export_fields_ctx_linkfromcolumn","ctx_req_profile_hdr_id")
		this.SetItem(row,"export_fields_ctx_linktoscrnid",11)
		of_ctx_generate_linktocolumn("export_fields_ctx_linktoscrnid", "11", row )
		this.SetItem(row,"export_fields_ctx_linktocolumn","ctx_req_profile_hdr_id")
		
		this.SetItem(row,"export_fields_ctx_column_name","data_value")	//jervis 08.31.2009 - from john request.
	elseif data = '2001' or data = '2002' then//Set Default link for contact detail and contact number - jervis 03.30.2011
		this.SetItem(row,"export_fields_ctx_linkfromcolumn","contact_id")
		this.SetItem(row,"export_fields_ctx_linktoscrnid",7)
		of_ctx_generate_linktocolumn("export_fields_ctx_linktoscrnid", "7", row )
		this.SetItem(row,"export_fields_ctx_linktocolumn","contact_id")
	else
		setnull( li_null )
		This.SetItem( row, "export_fields_ctx_linkfromcolumn", ls_null )
		This.SetItem( row, "export_fields_ctx_linktoscrnid", li_null )
		This.SetItem( row, "export_fields_ctx_linktocolumn", ls_null )
	end if	  
	//---------End Modfiied ------------------------------------------------------------------

	
	If This.getitemstring(row,'export_field_name') = 'company_id' Then
		dw_detail.getchild("export_fields_ctx_column_name",dwchild)
		ll_find = dwchild.find("field_name = 'app_facility'",1,dwchild.rowcount())
		If ll_find > 0 Then
			dwchild.setitem(ll_find,'field_name_alias','Company ID')
		End If
	End If
	//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
	//Set Default Filter Value For Location Facility--jervis 06.11.2009
	if data = "19" then		//Location Facility Screen
		ls_type_filter = this.GetItemString(row,"filter_query")
		if ls_type_filter = "" or isnull(ls_type_filter) then
			this.SetItem( row,"filter_query","ctx_loc.loc_id <> 0")
		end if
	end if
	if data = '18' then	//Parent Organization screen
		ls_type_filter = this.GetItemString(row,"filter_query")
		if ls_type_filter = "" or isnull(ls_type_filter) then
			this.SetItem( row,"filter_query","ctx_loc.loc_id = 0")
		end if
	end if	
	//---------End Added ------------------------------------------------------------------
end if

if dwo.name = "export_fields_ctx_linktoscrnid" then
	of_ctx_generate_linktocolumn( dwo.name, data, row )
	setnull( ls_null )
	This.SetItem( row, "export_fields_ctx_linktocolumn", ls_null )
end if

if dwo.name = "export_fields_ctx_column_name" then
	//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
	setItem( row, 'lu_field_name', '' )//added by gavins 20130219	
	//---------End Added ------------------------------------------------------------------

	This.Trigger Event ue_column_check( data, row )

	of_set_lookup_dddw()	
	
	ls_field = data
	if isnull(ls_field) then ls_field = ''
	if this.getchild("export_fields_ctx_column_name",dwchild) = 1 then
		ll_find = dwchild.find("field_name = '" + ls_field +"'",1,dwchild.rowcount())
		If ll_find > 0 Then
			ls_DataType = dwchild.GetItemString(ll_find,"field_datatype")
			//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
			//$Reason:
			  /*
				setitem(row,'ctx_column_datatype',ls_DataType)	
			  */
			 string ls_dddwtype,ls_lu_name,ls_format,ls_export_name
			ls_dddwtype = dwchild.GetItemString(ll_find,"field_type")	//jervis 09.06.2010
			setitem(row,'ctx_column_datatype',ls_DataType)
			
			//Add by jervis -- 11.26.2009
			//ls_dddwtype = dwchild.GetItemString(ll_find,"field_type")
			//setitem(row,'export_fields_ctx_lookup_type',ls_dddwtype)
			
			//Init field format and lookup - jervis 09.06.2010
			if ls_dddwtype = 'C' then
				ls_lu_name = dwchild.GetItemString(ll_find,"field_display_name")
				this.SetItem( row, "lu_field_name", ls_lu_name)
			end if
			
			ls_format = this.GetItemString( row, "Export_format")
			if  ls_format = "None" or ls_format = "" or isnull(ls_format) then
				ls_format = dwchild.GetItemString(ll_find,"field_format")
				if not isnull(ls_format) and ls_format <> "" and ls_format <> '[general]' then
					this.SetItem( row,"export_format",ls_format)
				end if
			end if
			
			//Init Export Field Name - jervis 09.06.2010
			ls_export_name = this.GetItemString( row, "Export_Field_name")
			if ls_export_name = "" or isnull(ls_export_name) then
				ls_export_name = of_build_alias(dwchild.GetItemString(ll_find,"field_name_alias"))
				if ls_export_name <> "" then this.SetItem( row, "Export_Field_name",ls_export_name)
			end if			  
			//---------End Modfiied ------------------------------------------------------------------			
		End If
	end if
end if

//Use the data type of the displayed column as the data type of the column
if dwo.name = "lu_field_name" then 
	ls_field = data
	if isnull(ls_field) then ls_field = ''
	if this.getchild("lu_field_name",dwchild) = 1 then 
		ll_find = dwchild.find("field_name = '" + ls_field +"'",1,dwchild.rowcount())
		If ll_find > 0 Then
			ls_DataType = dwchild.GetItemString(ll_find,"datatype")
			setitem(row,'ctx_column_datatype',ls_DataType)
		End If
	end if
end if

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 04.17.2013
//$<reason> System Error when running export  -bug 3487
if dwo.name = "billing_link" then 
	ll_data = long(data)
	if ll_data = 1 then
		this.setitem(row, "use_link", 1)
	end if
end if

if dwo.name = "use_link" then 
	ll_data = long(data)
	if ll_data = 0  then
		this.setitem(row, "billing_link", 0)
	end if
end if
//------------------- APPEON END -------------------


//---------Begin Added by (Appeon)Harry 08.05.2014 for BugS072301 in V14.2 Issues of New Feature--------
long ll_export_type
ll_export_type = tab_1.tabpage_export_hdr.dw_export_file.getitemnumber( 1, "export_type" ) 
if ll_export_type = 5 or ll_export_type = 6 then
	if dwo.name = "export_fields_module_type" then
		if Long(data) = 1 then
			if ib_readonly = false then //Start Code Change ----02.05.2015 #V14.2 maha
				tab_1.tabpage_field_data.cb_quick.visible = true
			end if
		else
			tab_1.tabpage_field_data.cb_quick.visible = false
		end if
	end if
end if
//---------End Added ------------------------------------------------------

of_report_audit_set('C', dw_audit, false)  //Start Code Change ----06.16.2016 #V152 maha
end event

event buttonclicked;call super::buttonclicked;string ls_mess
integer li_table_id

IF dwo.Name = "filter_wizard" THEN

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-11-28 By: Rodger Wu (doc painter)
	//$<reason> 
	integer li_module_type, li_found
	long ll_ctx_scrnid
	string ls_dataobject, ls_screen_alias
	datawindowchild ldwc_screen

	li_module_type = This.GetItemNumber( row, "export_fields_module_type" )
	if not isnull( li_module_type ) and ( li_module_type = 3 or li_module_type = 4 ) then
		ll_ctx_scrnid = This.GetItemNumber( 1, "export_fields_ctx_scrn_id" )
		if isnull( ll_ctx_scrnid ) then return;
		//---------Begin Added by (Appeon)Toney 06.24.2013 for V141 ISG-CLX--------
		//Start code by jervis 05.21.2009
		if ll_ctx_scrnid = 12 then
			ls_screen_alias = "Profile detail"
			ls_dataobject = "d_export_contract_profile_wizard"
		else
		//End code by jervis 05.21.2009		
		//---------End Added ------------------------------------------------------------------
			This.GetChild( "export_fields_ctx_scrn_id", ldwc_screen )
			li_found = ldwc_screen.Find( "screen_id = " + string( ll_ctx_scrnid ), 1, ldwc_screen.rowcount() )
			
			if li_found > 0 then
				ls_screen_alias = ldwc_screen.GetitemString( li_found, "screen_name" )
			end if
			ls_dataobject = This.GetItemString( row, "export_fields_ctx_scrn_dataobject" )
		end if
		//------------------- APPEON BEGIN -------------------
		//$<modify> Evan 04.09.2009
		//$<reason> New feature for App Mapping Addition Filters
		//openwithparm(w_query_wizard, ls_screen_alias + "~t" + ls_dataobject )
		ls_Mess = "CTX_EXPORT|NULL|" + ls_screen_alias + "|" + ls_DataObject
		OpenWithParm(w_query_wizard, ls_Mess)
		//------------------- APPEON END ---------------------
		
		ls_mess = message.stringparm
		if ls_mess = "Cancel" then
			return
		else
			this.setitem(row,"filter_query",ls_mess)
		end if
		
		return;
	end if
	
	//---------------------------- APPEON END ----------------------------

	li_table_id = this.getitemnumber(row,"intcred_table")
	if li_table_id = 0 or isnull(li_table_id)then
		return
	else
		//------------------- APPEON BEGIN -------------------
		//$<modify> Evan 04.09.2009
		//$<reason> New feature for App Mapping Addition Filters
		//openwithparm(w_query_wizard,li_table_id)
		ls_Mess = "PD_EXPORT|" + String(li_table_id) + "|NULL|NULL"
		OpenWithParm(w_query_wizard, ls_Mess)
		//------------------- APPEON END ---------------------
		
		ls_mess = message.stringparm
		if ls_mess = "Cancel" then
			return
		else
			this.setitem(row,"filter_query",ls_mess)
		end if
	end if
end if

IF dwo.Name = "td" THEN
	open(w_special_field_export)
	ls_mess = message.stringparm

	choose case ls_mess
		case "T"
			this.setitem(row,"export_fields_field_value","&TODAY&")
		case "UI"
			this.setitem(row,"export_fields_field_value","&USERID&")
		case "UN"
			this.setitem(row,"export_fields_field_value","&USERNAME&")
		//Start Code Change ----11.03.2016 #V153 maha -NEW USER FIELDS
		case "US1"
			this.setitem(row,"export_fields_field_value","&USERSTREET1&")
		case "US2"
			this.setitem(row,"export_fields_field_value","&USERSTREET2&")
		case "UC"
			this.setitem(row,"export_fields_field_value","&USERCITY&")
		case "UST"
			this.setitem(row,"export_fields_field_value","&USERSTATE&")
		case "UZ"
			this.setitem(row,"export_fields_field_value","&USERZIP&")
		case "UE"
			this.setitem(row,"export_fields_field_value","&USEREMAIL&")	
		case "UP"
			this.setitem(row,"export_fields_field_value","&USERPHONE&")
		case "UF"
			this.setitem(row,"export_fields_field_value","&USERFAX&")	
		case "X"  //was C
			//cancel do nothing
		//End Code Change ----11.03.2016 
	end choose
end if
	
//---------Begin Added by (Appeon)Toney 06.24.2013 for V141 ISG-CLX--------
//Add by jervis 08.26.2009
if dwo.name = 'b_req' then	
	str_ole_ctxid lstr_parm
	lstr_parm.sl_opentype = 1
	lstr_parm.sdw_object = this
	OpenWithParm(w_agreement_template_insert_requirement,lstr_parm)
	if Message.longparm > 0 then
	end if
end if
//---------End Added ------------------------------------------------------------------
	
end event

event retrieveend;call super::retrieveend;Integer li_table_id
datawindowchild dwchild
string ls_lookup_type
string ls_type_filter
long ll_find
long ll_field
//IF rowcount < 1 THEN
//	Return
//END IF
//
if ib_lockcol then//<add> andy 2007.06.04 Because it is not need when update the history data 
	li_table_id = tab_1.tabpage_export_hdr.dw_export_file.GetItemNumber( 1, "lock_cols" )
	if li_table_id = 1 then
	//	//messagebox("","0")
		this.object.export_field_name.protect = true
		this.object.export_field_name.background.color = 12632256
	//	//this.object.field_value.bringtotop = true
	else
			this.object.export_field_name.protect = false
		this.object.export_field_name.background.color = 16777215 //white
	//	//messagebox("",li_table_id)
	//	This.GetChild( "intcred_field", dwchild )
	//	dwchild.SetTransObject( SQLCA )
	//	dwchild.Retrieve( li_table_id )
	//	//this.object.sle_value.bringtotop = false
	//	//this.object.st_value.visible = false
	end if
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-28 By: Rodger Wu (doc painter)
//$<reason> 
integer li_module_type
long ll_ctx_scrnid, ll_ctx_linktoscrnid
boolean lb_ctx_id_existed
long ll_ExportType//<add> andy 2007.05.23

if rowcount > 0 then
	
	li_module_type = This.GetItemNumber( 1, "export_fields_module_type" )
	if not isnull( li_module_type ) and ( li_module_type = 3 or li_module_type = 4 ) then
		ll_ctx_scrnid = This.GetItemNumber( 1, "export_fields_ctx_scrn_id" )
		if not isnull( ll_ctx_scrnid ) then
			This.Trigger Event ue_generate_dddw( "export_fields_ctx_scrn_id", string( ll_ctx_scrnid ), 0, lb_ctx_id_existed )
		end if

		of_ctx_add_scrn()
		
		ll_ctx_linktoscrnid = This.GetItemNumber( 1, "export_fields_ctx_linktoscrnid" )
		if not isnull( ll_ctx_linktoscrnid ) then
			of_ctx_generate_linktocolumn( "export_fields_ctx_linktoscrnid", string( ll_ctx_linktoscrnid ), 0 )
		end if
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 03.16.2007 By: Jack (Export)
		//$<reason> Fix a defect.
		of_set_lookup_dddw()
		//---------------------------- APPEON END ----------------------------

	end if
	//<add> andy 2007.05.23 set UI
	ll_ExportType = This.GetItemNumber(1,"export_fields_export_type")
	of_setui(ll_ExportType)
	//end of add
end if
//---------------------------- APPEON END ----------------------------


end event

event pfc_preupdate;call super::pfc_preupdate;//maha added to validate field name 062005
integer i
Int li_facility_id//Added by Appeon long.zhang 05.27.2017
String ls_dc_field //Added by Appeon long.zhang 05.27.2017

if this.rowcount() < 1 then
	//trap added maha 070605
else
	i = this.getrow()

	if isnumber(MidA(this.getitemstring(1,"export_field_name"),1,1)) then
		messagebox("Field name Error","The field name cannot start with a number")
		return -1
	end if
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 05.27.2017
	//<$>reason:Check facility id, for Dept Chair link field Dept Chair link field in Export not working (Bug #5642).
	If This.object.dept_sect_field.visible Then //dept_sect_field is visible 
		ls_dc_field = This.GetItemString(1,"dept_sect_field")
		If Not (ls_dc_field = 'none' Or IsNull(ls_dc_field) ) Then //Already using dept_sect_field
			li_facility_id = This.GetItemNumber(1,"facility_id")
			If IsNull(li_facility_id) or li_facility_id = 0 Then
				messagebox("Facility Error","The Facility field must be selected when getting Department Chair data.")
				This.SetColumn("facility_id")
				This.Post SetFocus()
				return -1			
			End If
		End If
	End If
	//------------------- APPEON END -------------------
		
end if


return 1
end event

type cb_add from u_cb within tabpage_field_data
integer x = 1829
integer y = 20
integer width = 402
integer height = 84
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;Integer li_nr
Long ll_rec_id

lb_new = True
//$<Modify> 03.19.2008 by Andy
//if cb_save.triggerevent(clicked!) < 1 then return
if cb_save.event clicked( ) < 0 then return
dw_detail.Reset()
//end of add 03.19.2008

//ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )
//il_recid = ll_rec_id

//$<add> 03.17.2008 by Andy
Long ll_order
ll_order = Long(dw_fld_list.describe("Evaluate('max(export_order)',0)"))
if isnull(ll_order) then ll_order = 0
ll_order ++
//end of add 03.17.2008

li_nr = dw_detail.InsertRow( 1 )
//dw_detail.SetItem( li_nr, "rec_id", ll_rec_id )
dw_detail.SetItem( li_nr, "export_id", il_export_id )
//$<modify> 03.17.2008 by Andy
//dw_detail.SetItem( li_nr, "export_order", dw_fld_list.RowCount( ) + 1 )
dw_detail.SetItem( li_nr, "export_order", ll_order )
//end of modify 03.17.2008
dw_detail.SetItem( li_nr, "export_code",0 )
dw_detail.SetItem( li_nr, "export_fixed","N" )
dw_detail.SetItem( li_nr, "use_link", 0 )
dw_detail.SetItem( li_nr, "use_default", 0 )
dw_detail.SetItem( li_nr, "export_field_length", 15 )
dw_detail.SetItem( li_nr, "export_fields_export_type", 1 )
dw_detail.SetItem( li_nr, "export_fields_drop_column", 0)  //Start Code Change ----09.27.2013 #V14 maha
//<add> andy 2007.05.24 set UI
//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
dw_detail.SetItem( li_nr,'record_level','C')	//jervis 09.03.2009
//---------End Added ------------------------------------------------------------------
of_setui(1)
//end of add
dw_detail.SetItem( li_nr, "intcred_record_number", 1 )
dw_detail.SetItem( li_nr, "billing_link", 0 ) //maha 080205

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-27 By: Rodger Wu

Integer li_export_type

if tab_1.tabpage_export_hdr.dw_export_file.rowcount() > 0 then
	li_export_type = tab_1.tabpage_export_hdr.dw_export_file.getitemnumber( 1, "export_type" )
	//---------Begin Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
	/*
	dw_detail.SetItem( li_nr, "export_fields_module_type", li_export_type )

	if not isnull( li_export_type ) and ( li_export_type = 3 or li_export_type = 4 ) then
		of_ctx_add_scrn()
	end if
	*/
	Choose Case li_export_type
		Case 6
			dw_detail.SetItem( li_nr, "export_fields_module_type", 3 )
			tab_1.tabpage_field_data.cb_quick.visible = false //(Appeon)Harry 08.05.2014 - for BugS072301 in V14.2 Issues of New Feature
		Case 5
			dw_detail.SetItem( li_nr, "export_fields_module_type", 1 )
			tab_1.tabpage_field_data.cb_quick.visible = true //(Appeon)Harry 08.05.2014 - for BugS072301 in V14.2 Issues of New Feature
		Case Else
			dw_detail.SetItem( li_nr, "export_fields_module_type", li_export_type )
	End Choose
	if not isnull( li_export_type ) and ( li_export_type = 3 or li_export_type = 4 or li_export_type = 6) then
		of_ctx_add_scrn()
	end if
	//---------End Modfiied ------------------------------------------------------
end if
//---------------------------- APPEON END ----------------------------

//dw_detail.ScrollToRow( li_nr )
dw_detail.SetRow( li_nr )
//
//dw_detail.ScrollToRow( li_nr )
//dw_detail.SetRow( li_nr )
//
//<add> 07/17/2007 by: Andy
dw_detail.Modify("export_field_name.protect='0'~texport_field_name.background.color='16777215'")
//end of add
dw_detail.SetColumn( "export_field_name" )

dw_detail.SetFocus( )

lb_new = False
end event

type cb_delete_col from u_cb within tabpage_field_data
integer x = 2665
integer y = 20
integer width = 402
integer height = 84
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete Column"
end type

event clicked;call super::clicked;//<add> andy 2007.05.29
//if the column is used in the Calculated field,can not delete.
long   ll_Row
String ls_Column,ls_Computer

ll_Row    = dw_detail.getRow()
if dw_detail.GetItemStatus(ll_Row,0,primary!) = datamodified! or &
	dw_detail.GetItemStatus(ll_Row,0,primary!) = notmodified! then
	ls_Column = dw_detail.GetItemString(ll_Row,"export_field_name")
	if isnull(ls_Column) then ls_Column = ''	
	if ls_Column <> '' then
		SELECT TOP 1 export_field_name INTO :ls_Computer 
			FROM export_fields 
			WHERE charindex(:ls_Column,export_fields_expression) > 0 
				and export_id = :il_export_id
				and export_field_name <> :ls_Column;
		if sqlca.sqlcode = 0 then
			messagebox(gnv_app.iapp_object.DisplayName,"The column is used in the Calculated field,~rcan not delete.")
			return 
		end if
	end if
end if
//end of add

dw_detail.deleteRow( dw_detail.getRow() )

//<add> andy 2007.05.29
//set mle_1¡¢st_1¡¢cb_4 visible = false
of_setui(1)
//end of add
end event

type cb_insert from u_cb within tabpage_field_data
integer x = 2249
integer y = 20
integer width = 402
integer height = 84
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Insert"
end type

event clicked;Integer li_nr
Long ll_rec_id
Integer li_fld_cnt
Integer i
integer a
integer li_ord

lb_new = True

//ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )
//il_recid = ll_rec_id

//$<add>  03.19.2008 by Andy
//$Reason:Reorder the Order field.(fixed BugA012301)
li_fld_cnt = dw_fld_list.RowCount( )
FOR i = 1 TO li_fld_cnt
	dw_fld_list.SetItem( i, "export_order", i )
NEXT
//Reason:fixed BugA012302
if cb_save.event clicked( ) < 0 then return
dw_detail.Reset()
//end of add 03.19.2008

li_nr = dw_detail.InsertRow( 1 )
a = dw_fld_list.GetRow( )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.22.2007 By: Jack (Export)
//$<reason> Fix a defect.
/*
li_ord = dw_fld_list.Getitemnumber(a,"export_order")
*/
If a > 1 Then
	li_ord = dw_fld_list.Getitemnumber(a,"export_order")
Else
	li_ord = 1
End If
//---------------------------- APPEON END ----------------------------
//dw_detail.SetItem( li_nr, "rec_id", ll_rec_id )
dw_detail.SetItem( li_nr, "export_id", il_export_id )
dw_detail.SetItem( li_nr, "export_order", li_ord  )
dw_detail.SetItem( li_nr, "export_code",0 )
dw_detail.SetItem( li_nr, "export_fixed","N" )
dw_detail.SetItem( li_nr, "use_link", 0 )
dw_detail.SetItem( li_nr, "use_default", 0 )
dw_detail.SetItem( li_nr, "export_field_length", 15 )
dw_detail.SetItem( li_nr, "export_fields_export_type", 1 )
//<add> andy 2007.05.24 set UI
of_setui(1)
//end of add
dw_detail.SetItem( li_nr, "intcred_record_number", 1 )
dw_detail.SetItem( li_nr, "billing_link", 0 ) //maha 080205

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-27 By: Rodger Wu
Integer li_export_type

if tab_1.tabpage_export_hdr.dw_export_file.rowcount() > 0 then
	li_export_type = tab_1.tabpage_export_hdr.dw_export_file.getitemnumber( 1, "export_type" )
	//---------Begin Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
	/*
	dw_detail.SetItem( li_nr, "export_fields_module_type", li_export_type )

	if not isnull( li_export_type ) and ( li_export_type = 3 or li_export_type = 4 ) then
		of_ctx_add_scrn()
	end if
	*/
	Choose Case li_export_type
		Case 6
			dw_detail.SetItem( li_nr, "export_fields_module_type", 3 )
			tab_1.tabpage_field_data.cb_quick.visible = false //(Appeon)Harry 08.05.2014 - for BugS072301 in V14.2 Issues of New Feature
		Case 5
			dw_detail.SetItem( li_nr, "export_fields_module_type", 1 )
			tab_1.tabpage_field_data.cb_quick.visible = true //(Appeon)Harry 08.05.2014 - for BugS072301 in V14.2 Issues of New Feature
		Case Else
			dw_detail.SetItem( li_nr, "export_fields_module_type", li_export_type )
	End Choose
	if not isnull( li_export_type ) and ( li_export_type = 3 or li_export_type = 4 or li_export_type = 6) then
		of_ctx_add_scrn()
	end if
	//---------End Modfiied ------------------------------------------------------
end if
//---------------------------- APPEON END ----------------------------

li_fld_cnt = dw_fld_list.RowCount( )
FOR i = 1 TO li_fld_cnt
	if i >= a then
		dw_fld_list.SetItem( i, "export_order", i + 1)
	end if 
END FOR

//dw_detail.ScrollToRow( li_nr )
//dw_detail.SetRow( li_nr )

//dw_detail.ScrollToRow( li_nr )
//dw_detail.SetRow( li_nr )

//<add> 07/17/2007 by: Andy
dw_detail.Modify("export_field_name.protect='0'~texport_field_name.background.color='16777215'")
//end of add
dw_detail.SetColumn( "export_field_name" )

dw_detail.SetFocus( )

lb_new = False
end event

type cb_1 from commandbutton within tabpage_field_data
integer x = 2574
integer y = 1912
integer width = 503
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Edit Export Codes..."
end type

event clicked;openwithparm(w_export_code_equiv,il_export_id)
end event

type cb_reorder from commandbutton within tabpage_field_data
integer x = 27
integer y = 20
integer width = 402
integer height = 84
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reorder"
end type

event clicked;integer i,li_fld_cnt

li_fld_cnt = dw_fld_list.RowCount( )
FOR i = 1 TO li_fld_cnt
	//if a >= i then
		dw_fld_list.SetItem( i, "export_order", i )
	//end if 
END FOR

cb_save.triggerevent(clicked!)
end event

type cb_copy from commandbutton within tabpage_field_data
integer x = 448
integer y = 20
integer width = 439
integer height = 84
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Co&py Fields"
end type

event clicked;integer i
integer r

//Start Code Change ----07.19.2016 #V152 maha - audit writing
r = tab_1.tabpage_field_data.dw_fld_list.rowcount()

openwithparm(w_export_copy,il_export_id)

i = tab_1.tabpage_field_data.dw_fld_list.Retrieve( il_export_id )

if i <> r then
	of_report_audit_set('C', dw_audit, true) 
end if
//End Code Change ----07.19.2016

tab_1.tabpage_field_data.dw_fld_list.scrolltorow(i)

tab_1.tabpage_field_data.dw_fld_list.setrow(i)

tab_1.tabpage_field_data.st_next.text = "Next Col " + (string(tab_1.tabpage_field_data.dw_fld_list.rowcount()+ 1))


end event

type st_next from statictext within tabpage_field_data
integer x = 987
integer y = 116
integer width = 558
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Next Col"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within tabpage_field_data
boolean visible = false
integer x = 2409
integer y = 1120
integer width = 96
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
end type

event clicked;//<add> andy 2007.05.28
//Open a window in order to define Expression
str_pass lstr_pass, lstr_Ret
Long     ll_Row
u_dw     ldw_Temp
String   ls_Expression,ls_field

ldw_Temp = tab_1.tabpage_field_data.dw_detail
ll_Row   = ldw_Temp.GetRow()
if ll_Row > 0 then
	ls_Expression = ldw_Temp.GetItemString(ll_Row,"export_fields_expression")
	ls_field      = ldw_Temp.GetItemString(ll_Row,"export_field_name")
end if
if isnull(ls_Expression) then ls_Expression = ''
if isnull(ls_field) then ls_field = ''
//---------Begin Added by (Appeon)Toney 06.24.2013 for V141 ISG-CLX--------
//lstr_pass.s_long[1] = 1	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call	--jervis 03.12.2009
//---------End Added ------------------------------------------------------------------
lstr_pass.l_facility_id     = il_export_id
lstr_pass.s_string          = ls_Expression
lstr_pass.s_string_array[1] = ls_field
lstr_pass.s_u_dw            = ldw_Temp


//Start Code Change ----07.11.2016 #V152 maha - modified to use w_report_expression
lstr_pass.s_long[1]			= 1

//openwithparm(w_export_expression,lstr_pass)
openwithparm(w_report_expression,lstr_pass)
//End Code Change ----07.11.2016 

lstr_Ret = message.Powerobjectparm
if Not IsValid(lstr_Ret) or ISNULL(lstr_Ret) THEN return

tab_1.tabpage_field_data.mle_1.text = lstr_Ret.s_string 
of_report_audit_set('C', dw_audit, false)   //Start Code Change ----06.16.2016 #V152 maha
end event

type st_1 from statictext within tabpage_field_data
boolean visible = false
integer x = 1051
integer y = 1052
integer width = 453
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 33554432
long backcolor = 16777215
string text = "Expression"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within tabpage_field_data
boolean visible = false
integer x = 1033
integer y = 1120
integer width = 1371
integer height = 608
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;//<add> andy 2007.05.28 
long ll_Row
u_dw ldw_Temp

ldw_Temp = tab_1.tabpage_field_data.dw_detail
ll_Row   = ldw_Temp.GetRow()
if ll_Row > 0 then
	ldw_Temp.SetItem(ll_Row,"export_fields_expression", tab_1.tabpage_field_data.mle_1.text )
end if
end event

type cb_save from u_cb within w_export_painter
integer x = 1010
integer y = 292
integer width = 402
integer height = 84
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;Integer li_retval
integer r
string s
long recid
integer i
integer rc
DataWindowChild dwchild
integer col
long    ll_FieldType//<add> andy 2007.05.24
//debugbreak()
li_retval = tab_1.tabpage_field_data.dw_fld_list.update()
//commit using sqlca;

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.10.2007 By: Jack
//$<reason> Fix a defect.
tab_1.tabpage_export_hdr.dw_export_file.accepttext()
tab_1.tabpage_field_data.dw_detail.accepttext()

If tab_1.tabpage_export_hdr.dw_export_file.modifiedcount() > 0 Or lb_new Or tab_1.tabpage_field_data.dw_detail.modifiedcount() > 0  Or tab_1.tabpage_field_data.dw_detail.deletedcount() > 0 Then
//---------------------------- APPEON END ----------------------------
	//---------Begin Commented by (Appeon)Stephen 11.09.2016 for Import with CSV file--------
	/*
	//---------Begin Added by (Appeon)Harry 06.05.2014 for (No Export selected- Unable to proceed Bug#4061)--------
	if Upper( appeongetclienttype() ) = "WEB" then
		if tab_1.tabpage_export_hdr.dw_export_file.GetItemString(1,"export_format") = ".csv" then
			MessageBox( "IntelliSoft", "The file type of CSV is unsupported on WEB." )
		end if
	end if
	//---------End Added ------------------------------------------------------
	*/
	//---------End Added ------------------------------------------------------
	
	if tab_1.tabpage_field_data.dw_detail.rowcount() > 0 then
		//<add> andy 2007.05.24
		ll_FieldType   = tab_1.tabpage_field_data.dw_detail.GetItemNumber( 1, "export_fields_export_type")
		if ll_FieldType = 3 then
			//check valid and set mle_1.text into export_fields_ctx_column_name 
			if of_check() = -1 then return -1 // Modify by Evan 01.31.2008
		end if
		//end of add
		
		if isnull(tab_1.tabpage_field_data.dw_detail.getItemnumber( 1, "rec_id" )) then
			recid = of_get_id( )
			tab_1.tabpage_field_data.dw_detail.SetItem( 1, "rec_id", recid )
			il_recid = recid
		end if
	end if
	testcnt++
	if tab_1.tabpage_field_data.dw_detail.rowcount() > 0 then
		if tab_1.tabpage_field_data.dw_detail.getItemnumber( 1, "use_default" ) = 2 then
			tab_1.tabpage_field_data.dw_detail.accepttext()
			col = integer(tab_1.tabpage_field_data.dw_detail.getItemstring( 1, "default_value" ))
			//messagebox("col",col)
			if col < 1 or col > tab_1.tabpage_field_data.dw_fld_list.rowcount() then
				//messagebox("Invalid setting","You are using a column default this column, but your default value is not a valid column number")
  				messagebox("Invalid setting","You are using a column default for this column, but your default value is not a valid column number")
				return -1 // Modify by Evan 01.31.2008
			end if
		end if
	end if
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-11-28 By: Rodger Wu
	integer li_module_type, li_getrow, li_ctx_uselink
	string ls_modify
	
	if tab_1.tabpage_field_data.dw_detail.rowcount() > 0 then
		li_module_type = tab_1.tabpage_field_data.dw_detail.GetItemNumber( 1, "export_fields_module_type" )
		li_ctx_uselink = tab_1.tabpage_field_data.dw_detail.GetItemNumber( 1, "export_fields_ctx_uselink" )
		if isnull( li_ctx_uselink ) then li_ctx_uselink = 0
		if li_module_type = 3 or li_module_type = 4 then
			ls_modify = "intcred_table.dddw.Required = 'No' intcred_field.dddw.Required = 'No' " + &
							"export_fields_ctx_scrn_id.dddw.Required = 'Yes' export_fields_ctx_column_name.dddw.Required = 'Yes'"
			if li_ctx_uselink = 0 then
				ls_modify += " export_fields_ctx_linkfromcolumn.dddw.Required = 'No' export_fields_ctx_linktoscrnid.dddw.Required = 'No'" + &
								 " export_fields_ctx_linktocolumn.dddw.Required = 'No'"
			else
				ls_modify += " export_fields_ctx_linkfromcolumn.dddw.Required = 'Yes' export_fields_ctx_linktoscrnid.dddw.Required = 'Yes'" + &
								 " export_fields_ctx_linktocolumn.dddw.Required = 'Yes'"
			end if
		else
			ls_modify = "intcred_table.dddw.Required = 'Yes' intcred_field.dddw.Required = 'Yes' " + &
							"export_fields_ctx_scrn_id.dddw.Required = 'No' export_fields_ctx_column_name.dddw.Required = 'No' " + &
							"export_fields_ctx_linkfromcolumn.dddw.Required = 'No' export_fields_ctx_linktoscrnid.dddw.Required = 'No' " + &
							"export_fields_ctx_linktocolumn.dddw.Required = 'No'"
		end if
		
		tab_1.tabpage_field_data.dw_detail.modify( ls_modify )
	end if
	//---------------------------- APPEON END ----------------------------
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.10.2007 By: Jack
	If tab_1.tabpage_field_data.dw_detail.rowcount() > 0 Then
		string ls_export_field_name,ls_export_field_name1
		int li_pos,li_num, li_test
		long ll_rec_id,ll_rec_id1
		boolean lb_duplicates = False
		ls_export_field_name = tab_1.tabpage_field_data.dw_detail.getitemstring(1,'export_field_name')
		
		li_pos = PosA(trim(ls_export_field_name),' ')
		If li_pos > 0 Then
			messagebox("Invalid Column Name","Field name cannot contain space.")
			tab_1.tabpage_field_data.dw_detail.setfocus()
			tab_1.tabpage_field_data.dw_detail.setcolumn('export_field_name')
			Return -1 // Modify by Evan 01.31.2008
		End If
		
		//Start Code Change ----04.04.2013 #V12 maha
		li_test = of_check_field_name(ls_export_field_name)
		if li_test = -1 then
			messagebox("Invalid Column Name", "Field cannot start with a number ( " + ls_export_field_name + " )" )
			return -1
		elseif li_test = -2 then 
			messagebox("Invalid Column Name", "The Field uses a protected SQL word ( " + ls_export_field_name + " )" )
			return -1
		end if
		//End Code Change ----04.04.2013				
		//---------Begin Added by (Appeon)Toney 07.09.2013 for V141 ISG-CLX--------
		if Not of_Field_Name_Check(ls_export_field_name) then
			MessageBox("Invalid Column Name","Column Name is invalid.~r~n~r~nColumn Name must start with a letter, can include any combination of~r~nletters, numbers, and underscores.")
			Return -1
		end if
		If tab_1.tabpage_field_data.dw_detail.describe( "lu_field_name.visible" )  = '1' Then
			If IsNull( tab_1.tabpage_field_data.dw_detail.getitemstring(1,'lu_field_name') ) Or Trim( tab_1.tabpage_field_data.dw_detail.getitemstring(1,'lu_field_name') ) = '' Then
				messagebox("Invalid setting","Value is not a valid in 'Lookup Table Field'.")
				Return -1			
			End If
		End If		 
		//---------End Added ------------------------------------------------------------------
		
		ll_rec_id = tab_1.tabpage_field_data.dw_detail.getitemnumber(1,'rec_id')
		If isnull(ll_rec_id) Then ll_rec_id = 0
		For i = 1 To tab_1.tabpage_field_data.dw_fld_list.rowcount()
			ls_export_field_name1 = tab_1.tabpage_field_data.dw_fld_list.getitemstring(i,'export_field_name')
			ll_rec_id1 = tab_1.tabpage_field_data.dw_fld_list.getitemnumber(i,'rec_id')		
			If ls_export_field_name1 = ls_export_field_name And ll_rec_id1 <> ll_rec_id Then
				lb_duplicates = True
				exit
			End If
		Next
		If lb_duplicates Then
			//messagebox("Invalid Column Name","Field name cannot duplicates.")
 			messagebox("Invalid Column Name","Field name cannot be duplicate.")
			tab_1.tabpage_field_data.dw_detail.setfocus()
			tab_1.tabpage_field_data.dw_detail.setcolumn('export_field_name')
			Return -1 // Modify by Evan 01.31.2008
		End If
	End If
	
	//---------------------------- APPEON END ----------------------------
	//Start Code Change ----10.24.2013 #V14 maha - set default for checkbox
	//if isnull(tab_1.tabpage_field_data.dw_detail.getitemnumber(1,'export_fields_drop_column')) then tab_1.tabpage_field_data.dw_detail.setitem(1,'export_fields_drop_column',0)//(Appeon)Toney 11.08.2013 - V141 ISG-CLX,Fixed Bug # 3743 - Can't save a new export file


	li_retval = Parent.Event pfc_Save()
	
	IF li_retval < 0 THEN
		Return li_retval // Modify by Evan 01.31.2008
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.23.2007 By: Jack
	//$<reason> Fix a defect.
	dw_select.event constructor()	
	//---------------------------- APPEON END ----------------------------
	
	
	//	dw_select.GetChild( "export_id", dwchild )
	//	dwchild.settransobject(sqlca)
	//	dwchild.retrieve()
		recid = il_recid
		rc = tab_1.tabpage_field_data.dw_fld_list.retrieve(il_export_id)
		s = "rec_id = " + string(recid)
		
		//find the current row and set it
		r = tab_1.tabpage_field_data.dw_fld_list.find(s,1,rc)
		
		if r > 0 then 
			tab_1.tabpage_field_data.dw_fld_list.scrolltorow(r)
			tab_1.tabpage_field_data.dw_fld_list.setrow(r)
		end if
	if lb_new = true then //remodified maha 081104
		//messagebox("","new")
	//	dw_select.retrieve()
		dw_select.GetChild( "export_id", dwchild )
		dwchild.settransobject(sqlca)
		rc = dwchild.retrieve()
		s = "export_id = " + string(il_export_id)
		
		//find the current row and set it
		r = dwchild.find(s,1,rc)
		
		if r > 0 then 
			dwchild.scrolltorow(r)
			dwchild.setrow(r)
		else
			dw_select.insertrow(1)
			//messagebox("il_export_id",il_export_id)
		end if	
		dw_select.setitem(dw_select.getrow(),'export_id',il_export_id)  //Add 04.27.2007 by Jack
		
		//Start Code Change ----06.16.2016 #V152 maha
		if tab_1.tabpage_export_hdr.dw_export_file.rowcount() > 0 then //Start Code Change ----07.18.2016 #V152 maha - added trap for delete
			dw_audit.setitem(1, "report_id", il_export_id)
			dw_audit.setitem(1, "report_name", tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1, "export_name") )
			dw_audit.update()
		end if
		//End Code Change ----06.16.2016
		
		//dwchild.insertrow(1)
		//dw_select.retrieve()
	end if
	
	lb_new = false
	
	tab_1.tabpage_field_data.st_next.text = "Next Col " + (string(tab_1.tabpage_field_data.dw_fld_list.rowcount()+ 1))
End If

Return 1 // Add by Evan 01.31.2008
end event

type cb_quit from u_cb within w_export_painter
integer x = 3214
integer y = 48
integer width = 329
integer height = 84
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.23.2007 By: Jack
//$<reason> Fix a defect.
/*
Parent.Event pfc_close()
*/
int li_mes
tab_1.tabpage_field_data.dw_detail.accepttext( )
tab_1.tabpage_export_hdr.dw_export_file.accepttext( )
If tab_1.tabpage_export_hdr.dw_export_file.modifiedcount() > 0 Or tab_1.tabpage_field_data.dw_detail.modifiedcount() > 0  Or tab_1.tabpage_field_data.dw_detail.deletedcount() > 0 Then
	li_mes = messagebox('IntelliSoftGroup','Do you want to save changes?',Question!,YesNoCancel!)
	If li_mes = 1 Then
		cb_save.triggerevent(clicked!)
		close(parent)
	Elseif li_mes = 2 then
		ib_closestatus = True
		close(parent)
	Else
		Return -1
	End If
Else
	close(parent)	
End If
//---------------------------- APPEON END ----------------------------

end event

type cb_auto from commandbutton within w_export_painter
boolean visible = false
integer x = 2071
integer y = 48
integer width = 457
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Open Auto Export"
end type

event clicked;//Long prac_ids[]
//
//prac_ids[1] = 1
//prac_ids[2] = 3
//prac_ids[3] = 4
//
//pfc_n_cst_ai_export  n_export
//
//
//n_export = CREATE pfc_n_cst_ai_export
//
//n_export.of_export_data( il_export_id, prac_ids )

openwithparm(w_auto_export,"I")
end event

type cb_test from commandbutton within w_export_painter
integer x = 2875
integer y = 48
integer width = 329
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run &Export"
end type

event clicked;Long prac_ids[]
string ls_presentation_str
string ls_sny_retrieve
string ls_dwsyntax_str
string ERRORS
string ls_path
long ll_prac_row
n_ds lds_export_retrieve
//Start Code Change ---- 11.03.2005 #26 maha
long ll_from
long ll_to
string ls_return
long i
long ic
long ll_pracid
long ll_log
integer li_savedata = 0
string ls_prompt1
string ls_prompt2
string ls_prompt3
string ls_prompt
string ls_arg
string ls_parm1 = ""
string ls_parm2 = ""
string ls_parm3 = ""
integer p1
integer p2
integer p3
//<add> 07/13/2007 by: Andy
String  ls_Temp1,ls_Temp2
String  ls_name
Long    ll_pracidold = -1
Long    ll_Num = 0,ll_pos
integer li_type1
String  ls_SQL = '',ls_temp
//end of add
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-25 By: Rodger Wu
integer li_type
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 01.13.2006 By: Wang Chao
//$<reason> It is currently unsupported to dynamically create a visual object.
//$<modification> Replaced the visual object with a non-visual object.
//pfc_n_cst_ai_export  n_export
//n_export = CREATE pfc_n_cst_ai_export

pfc_n_cst_ai_export_apb  n_export
n_export = CREATE pfc_n_cst_ai_export_apb
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.23.2007 By: Jack
//$<reason> Fix a defect.
il_export_id = dw_select.getitemnumber(dw_select.getrow(),'export_id')
If	tab_1.tabpage_field_data.dw_fld_list.rowcount() < 1 Then
	messagebox("Export error","No Export Column.")
	if IsValid(n_export) then destroy n_export
	Return
End If
//---------------------------- APPEON END ----------------------------

if isnull(il_export_id) or il_export_id < 1 then
	messagebox("Select error","Please select an export.")
	if IsValid(n_export) then destroy n_export
	return
end if

ls_path = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"save_path")
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.28.2007 By: Jack 
//$<reason> Fix a defect.
//Comment 08/21/2007 by: Andy Reason:BugG081801
/*
string ls_file
ls_file = right(ls_path,1)
If ls_file = '\' Then
	ls_path = mid(ls_path,1,len(ls_path) - 1)
End If
*/
//---------------------------- APPEON END ----------------------------

ls_sny_retrieve = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"prac_sql")

ls_prompt1 = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"prompt_type1")
ls_prompt2 = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"prompt_type2")
ls_prompt3 = tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"prompt_type3")

choose case ls_prompt1
	case "C","D","N","F"//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT071302,append F option
		ls_prompt = ls_prompt1
end choose
choose case ls_prompt2
	case "C","D","N"
		ls_prompt += "*" + ls_prompt2
	case else //(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2
		ls_prompt += "*"
end choose
choose case ls_prompt3
	case "C","D","N"
		ls_prompt += "*" + ls_prompt3
	case else //(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2
		ls_prompt += "*"
end choose
if ls_prompt = "**" then ls_prompt = "" //(Appeon)Harry 12.19.2013 - V141 for BugH121101 of History Issues 2

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-28 By: Rodger Wu (doc painter)
li_type = tab_1.tabpage_export_hdr.dw_export_file.GetItemNumber( 1, "export_type" )
//---------------------------- APPEON END ----------------------------

IF isnull(ls_sny_retrieve) or trim(ls_sny_retrieve) = "" then
	open(w_export_test_param)
	ls_return = message.stringparm
	
	if ls_return = "Cancel" then
		if IsValid(n_export) then destroy n_export
		return
	end if
	
	ll_from = long(MidA(ls_return,1,PosA(ls_return,"@") - 1))
	//messagebox("ls_from",ll_from)
	ll_to = long(MidA(ls_return,PosA(ls_return,"@") + 1))
	//messagebox("ll_to",ll_to)
	ic = ll_to - ll_from + 1
	//messagebox("ic",ic)
	if ic < 0 then
		//messagebox("Input Error","The To: value cannot be less that the From: value.")
		messagebox("Input Error","The To value must be greater than the From value.")
		if IsValid(n_export) then destroy n_export
		return
	end if
		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.18.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	ll_pracid = ll_from
	for i = 1 to ic
		prac_ids[i] = ll_pracid
		ll_pracid++
	next
	*/
	//Modify 07/13/2007 by: Andy
	//ls_sny_retrieve = 'Select distinct ctx_id from ctx_basic_info where ctx_id between ' + string(ll_from) + ' and ' + string(ll_to) + ';'
	//if li_type = 3 or li_type = 4 then
	if li_type = 3 or li_type = 4 or li_type = 6 then  //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking) add li_type = 6
		ls_sny_retrieve = 'Select distinct ctx_id from ctx_basic_info where ctx_id between ' + string(ll_from) + ' and ' + string(ll_to) + ';'
	else
		ls_sny_retrieve = 'Select distinct prac_id from pd_basic where prac_id between ' + string(ll_from) + ' and ' + string(ll_to) + ';'
	end if
	//end of modify
	
	ls_presentation_str = "style(type=grid)"		
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		if IsValid(n_export) then destroy n_export		
		RETURN -1
	END IF
	
	lds_export_retrieve = CREATE n_ds
	lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
	lds_export_retrieve.SetTransObject( SQLCA )
	

	
	ll_prac_row = lds_export_retrieve.retrieve()
	if ll_prac_row < 1 then 
		//if li_type = 3 or li_type = 4 then
		if li_type = 3 or li_type = 4 or li_type = 6 then //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking) add li_type = 6
			messagebox("Information","No contract rows returned.")
		else
			messagebox("Information","No practitioner rows returned.")
		end if
		if IsValid(n_export) then destroy n_export
		if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
		return -2
	end if
	
	//<add> 07/12/2007 by: Andy
	lds_export_retrieve.Setsort( "#1 A")
	lds_export_retrieve.Sort()
	//end of add
		
	for i = 1 to ll_prac_row
		prac_ids[i] = lds_export_retrieve.getitemnumber(i,1)
	next
	
	//<add> 07/17/2007 by: Andy
	li_type1 = 3
	//end of add
	
	//---------------------------- APPEON END ----------------------------
else
	
	if LenA(ls_prompt) > 0 then //maha 110305 for prompts
		openwithparm(w_export_prompt,ls_prompt)
		ls_prompt = message.stringparm
		if ls_prompt = "Cancel" then
			if IsValid(n_export) then destroy n_export
			if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
			return -1
		else
		//parses the return into separate variables
		ls_parm1 = ""
		ls_parm2 = ""
		ls_parm3 = ""
		
		ls_arg = ls_prompt
		
		p1 = PosA(ls_arg,"*",1)
		ls_parm1 = MidA(ls_arg,1,p1 - 1)
		
		p2 = PosA(ls_arg,"*",p1 + 1)
		if p2 > 0 then 
			ls_parm2 = MidA(ls_arg,p1 + 1,p2 - p1 - 1)
		
			if p2 < LenA(ls_arg) then //check for third param
				ls_parm3 = MidA(ls_arg,p2 + 1)
			end if
		end if
		
		ls_sny_retrieve = n_export.of_prompt_syntax(ls_sny_retrieve,ls_parm1,ls_parm2,ls_parm3)

		end if
	end if

	//<add> 07/17/2007 by: Andy
	li_type1 = 1
	ls_SQL = ls_sny_retrieve
	//end of add
	
	//$<add> 05.06.2008 by Andy
	ll_pos = PosA(lower(ls_sny_retrieve)," from ")
	if ll_pos <= 0 then ll_pos = PosA(lower(ls_sny_retrieve),"from") //(Appeon)Harry 05.04.2015 -  Issues running a custom correspondence letter against an IntelliBatch
	ls_temp = LeftA(ls_sny_retrieve,ll_pos - 1)
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 07.19.2012
	//$<reason> DataWindow column type does not match GetItem type
	/*
	if li_type = 3 or li_type = 4 then		
		if PosA(lower(ls_temp), "ctx_id") < 1 then
			MessageBox("Caution","The Contract Retrieval SQL must contain the ctx_id column.")
			if IsValid(n_export) then destroy n_export		
			RETURN -1
		end if
	else
		if PosA(lower(ls_temp), "prac_id") < 1 then
			MessageBox("Caution","The Practitioner Retrieval SQL must contain the prac_id column.")
			if IsValid(n_export) then destroy n_export		
			RETURN -1
		end if		
	end if
	*/
	//if li_type = 3 or li_type = 4 then
	if li_type = 3 or li_type = 4 or li_type = 6 then //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking) add li_type = 6
		if PosA(lower(ls_temp), "ctx_id") < 1 then
			MessageBox("Caution","ctx_id must be the first column of the Contract Retrieval SQL.")		
			if IsValid(n_export) then destroy n_export		
			RETURN -1
		else
			if (PosA(lower(ls_temp), "ctx_id") > PosA(lower(ls_temp), ",")) and  (PosA(lower(ls_temp), ",") > 0)  then
				MessageBox("Caution","ctx_id must be the first column of the Contract Retrieval SQL.")		
				if IsValid(n_export) then destroy n_export		
				RETURN -1
			end if
		end if
	else
		if PosA(lower(ls_temp), "prac_id") < 1 then	
			//MessageBox("Caution","prac_id must be the first column of the Contract Retrieval SQL.")		//Commented by (Appeon)Harry 05.04.2015
			MessageBox("Caution","prac_id must be the first column of the Practitioner Retrieval SQL.")	//(Appeon)Harry 05.04.2015
			if IsValid(n_export) then destroy n_export		
			RETURN -1
		else
			if (PosA(lower(ls_temp), "prac_id") > PosA(lower(ls_temp), ",")) and  (PosA(lower(ls_temp), ",") > 0)  then	
				//MessageBox("Caution","prac_id must be the first column of the Contract Retrieval SQL.")		 //Commented by (Appeon)Harry 05.04.2015
				MessageBox("Caution","prac_id must be the first column of the Practitioner Retrieval SQL.")  //(Appeon)Harry 05.04.2015
				if IsValid(n_export) then destroy n_export		
				RETURN -1
			end if
		end if	
	end if
	//------------------- APPEON END -------------------
	
	//end add 05.06.2008
	
	ls_presentation_str = "style(type=grid)"		
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		MessageBox("SyntaxFromSQL caused these errors: " + ERRORS, ls_sql)
		if IsValid(n_export) then destroy n_export
		RETURN -1
	END IF
	
	lds_export_retrieve = CREATE n_ds
	lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
	lds_export_retrieve.SetTransObject( SQLCA )
		
	ll_log = of_log_sys_report("E","MAN","", il_export_id,tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1, "export_name")  )  //Start Code Change ----06.06.2016 #V152 maha,	07.25.2016 - maha - name parameter
	ll_prac_row = lds_export_retrieve.retrieve()
	
//$<del> 05.06.2008 by Andy
//$<Reason> Allow select more than one field,maybe the old customers have many Retrieval SQL that select more than one field.	
//	//<add> 07/13/2007 by: Andy
//	if li_type = 3 or li_type = 4 then
//		ls_Temp1 = "The Contract Retrieval SQL"
//		ls_Temp2 = "ctx_id"
//	else
//		ls_Temp1 = "The Practitioner Retrieval SQL"
//		ls_Temp2 = "prac_id"
//	end if

//	//The Practitioner Retrieval SQL can only contain the prac_id column.	
//	if long(lds_export_retrieve.Describe( "DataWindow.Column.Count")) <> 1 then
//		messagebox(gnv_app.iapp_object.DisplayName,ls_Temp1 + " can only contain the " + ls_Temp2 + " column.")
//		if IsValid(n_export) then destroy n_export
//		if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
//		return -1
//	end if
	
//	ls_name = lds_export_retrieve.Describe( "#1.name")
//	if li_type = 3 or li_type = 4 then
//		if pos(ls_name,"ctx_id") < 1 then
//			messagebox(gnv_app.iapp_object.DisplayName,ls_Temp1 + " must contain the " + ls_Temp2 + " column.")
//			if IsValid(n_export) then destroy n_export
//			if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
//			return -1
//		end if		
//	else
//		if pos(ls_name,"prac_id") < 1 then
//			messagebox(gnv_app.iapp_object.DisplayName,ls_Temp1 + " must contain the " + ls_Temp2 + " column.")
//			if IsValid(n_export) then destroy n_export
//			if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
//			return -1
//		end if			
//	end if
//	//end of add
	
	if ll_prac_row < 1 then 
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-11-28 By: Rodger Wu (doc painter)
		//if li_type = 3 or li_type = 4 then
		if li_type = 3 or li_type = 4 or li_type = 6 then //Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
			messagebox("Information","No contract rows returned.")
		else
			messagebox("Information","No practitioner rows returned.")
		end if
		//---------------------------- APPEON END ----------------------------
		if IsValid(n_export) then destroy n_export
		if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
		return -2
	end if

	//<add> 07/12/2007 by: Andy
	lds_export_retrieve.Setsort( "#1 A")
	lds_export_retrieve.Sort()
	//end of add
	
	//lds_export_retrieve.retrieve()
	//Modify 07/13/2007 by: Andy Reason:filter repeated data
	for i = 1 to ll_prac_row
		ll_pracid   = lds_export_retrieve.getitemnumber(i,1)
		//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------		
		  /*
			if ll_pracid <> ll_pracidold then	
		  */
		if ll_pracid <> ll_pracidold and ll_pracid > 0 then  //jervis 08.26.2009
		//---------End Modfiied ------------------------------------------------------------------		
			ll_Num ++
			prac_ids[ll_Num] = ll_pracid
			ll_pracidold= ll_pracid
		end if
	next
	//end of modify
end if

/*comment 07/18/2007 by: Andy
if cbx_savedata.checked = true then
	//save
	li_savedata = 1
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-28 By: Rodger Wu (doc painter)

if cbx_previewdata.checked then
	li_savedata = 1
	cbx_savedata.checked = True
end if
*/

//<add> 07/18/2007 by: Andy
if cbx_savedata.checked and cbx_previewdata.checked then 
	//save & preview
	li_savedata = 3
elseif cbx_previewdata.checked then
	//preview
	li_savedata = 2
elseif cbx_savedata.checked then
	//save
	li_savedata = 1
else
	//do nothing
	li_savedata = 0
end if
//end of add
//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
n_export.ib_gen_rec_id = False //Added By Ken.Guo 2010-06-30.
//---------End Added ------------------------------------------------------------------
n_export.ib_export_test = True //(Appeon)Harry 09.01.2014 - for BugH070801 in V14.2 Issues of Integration.doc

//if li_type = 3 or li_type = 4 then

if li_type = 3 or li_type = 4 or li_type = 6 then	//Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
	i = n_export.of_export_data_with_text_ctx( il_export_id, prac_ids,ls_path,li_savedata,ls_parm1,ls_parm2,ls_parm3,li_type1,ls_SQL )
else
	i = n_export.of_export_data_with_text( il_export_id, prac_ids,ls_path,li_savedata,ls_parm1,ls_parm2,ls_parm3,li_type1,ls_SQL)	
end if

of_log_sys_report_end( ll_log, gl_export_rows_count, "")  //Start Code Change ----06.06.2016 #V152 maha

//comment 07/18/2007 by: Andy 
//Reason:Move to pfc_n_cst_ai_export_apb
//if i = 1 and cbx_previewdata.checked then
//	openwithparm( w_export_previewdata, n_export.is_select_syntax )
//end if
//end of comment

destroy n_export;
destroy lds_export_retrieve//<add> 07/13/2007 by: Andy
//End Code Change---11.03.2005
//---------------------------- APPEON END ----------------------------

end event

type cb_delete from u_cb within w_export_painter
integer x = 1568
integer y = 48
integer width = 453
integer height = 84
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Delete Export &File"
end type

event clicked;Integer li_export_id
Integer li_nr
integer res



li_export_id = dw_select.getitemnumber(1,'export_id')
IF li_export_id < 0 or isnull(li_export_id) THEN 
	messagebox('Delete','Please first select an export file to delete.')
	return
END IF

res = messagebox("Delete","Are you sure you want to delete the selected export file?",question!,yesno!,2)
//------------------Begin Modified by Alfee 05.20.2009-------------------------------
IF res = 1 THEN
	dw_audit.setitem(1, "add_edit", "D") //Start Code Change ----06.16.2016 #V152 maha - auditing record

	li_export_id = tab_1.tabpage_export_hdr.dw_export_file.getItemnumber(tab_1.tabpage_export_hdr.dw_export_file.getrow(),"export_id")
	IF of_check_exportid(li_export_id) < 0 THEN RETURN 
	
	//Start Code Change ----07.18.2016 #V152 maha
	dw_audit.setitem(1, "report_id", il_export_id)
	dw_audit.setitem(1, "report_name", tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1, "export_name") )
	dw_audit.setitem(1, "mod_date", datetime(today(), Now()))  //(Appeon) Add by harry 07.26.2016 for BugH070503
	dw_audit.update()
	//End Code Change ----06.16.2016
	
	Delete from export_fields where export_id = :li_export_id;	

	IF SQLCA.SQLCode < 0 THEN
		MessageBox("Delete","Failed to delete the export file due to " + SQLCA.SQLErrText)
		RETURN
	END IF
	
	tab_1.tabpage_export_hdr.dw_export_file.deleterow(tab_1.tabpage_export_hdr.dw_export_file.getrow())
	tab_1.tabpage_field_data.dw_detail.reset() //maha 081104
	lb_new = true
	il_export_id = 0 //maha 081104
	cb_save.triggerevent(clicked!)
END IF
/* 
if res = 1 then	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 01.31.2008 By: Evan
	//$<reason> When delete export header is fail, cannot be delete export file too.
	//	//res = messagebox("Delete","Are you positive you wish to delete the selected export file, and all setup fields?",question!,yesno!,2)
	//	//if res = 1 then		
	//		li_export_id = tab_1.tabpage_export_hdr.dw_export_file.getItemnumber(tab_1.tabpage_export_hdr.dw_export_file.getrow(),"export_id")
	//		delete from export_fields where export_id = :li_export_id;	
	//		tab_1.tabpage_export_hdr.dw_export_file.deleterow(tab_1.tabpage_export_hdr.dw_export_file.getrow())
	//		tab_1.tabpage_field_data.dw_detail.reset() //maha 081104
	//		lb_new = true
	//		il_export_id = 0 //maha 081104
	//		cb_save.triggerevent(clicked!)
	//		//il_export_id = 0 //maha 081104		
	//		
	//	//end if

	li_export_id = tab_1.tabpage_export_hdr.dw_export_file.getItemnumber(tab_1.tabpage_export_hdr.dw_export_file.getrow(),"export_id")	
	tab_1.tabpage_export_hdr.dw_export_file.deleterow(tab_1.tabpage_export_hdr.dw_export_file.getrow())
	tab_1.tabpage_field_data.dw_detail.reset() //maha 081104
	lb_new = true
	il_export_id = 0 //maha 081104
	res = cb_save.Event Clicked()
	if res = 1 then
		gnv_appeondb.of_StartQueue()
		delete from export_fields where export_id = :li_export_id;
		commit;
		gnv_appeondb.of_CommitQueue()
	else
		SetNull(li_export_id)
		dw_select.SetItem(1, "export_id", li_export_id)
		tab_1.SelectTab(1)
		tab_1.Enabled = false
	end if
	//---------------------------- APPEON END ----------------------------
end if
*/
//------------------End Modified ----------------------------------------------------
end event

type st_field1 from statictext within w_export_painter
integer x = 2135
integer y = 180
integer width = 818
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type cbx_savedata from checkbox within w_export_painter
integer x = 2377
integer y = 172
integer width = 699
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Save Data to export table"
end type

type cbx_open from checkbox within w_export_painter
boolean visible = false
integer x = 1797
integer y = 172
integer width = 466
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Open saved file"
end type

type dw_select from datawindow within w_export_painter
integer x = 59
integer y = 56
integer width = 1047
integer height = 80
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_export_hdr_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;integer cnt
integer li_user  //maha 06.14.2016
integer v, r  //maha 06.14.2016
integer li_save_count //maha 12.12.2017
datawindowchild dwchild

il_export_id = Integer( data )

/*
<add> andy 07/13/2007
Update the data type of the export column 
where the data type is null(only execute one time),
in order to resolve the history data.
Because the data type is very important for Calculated fields.
*/
of_updatehistorydata()
//end of add
//---------Begin Modified by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
  /*
    tab_1.tabpage_export_hdr.dw_export_file.Retrieve( il_export_id )  
  */
 long  ll_count
 ll_count =  tab_1.tabpage_export_hdr.dw_export_file.Retrieve( il_export_id ) 
//---------End Modfiied ------------------------------------------------------------------

//---------Begin Commented by (Appeon)Harry  08.12.2014 for BugS072401--------
/*
tab_1.tabpage_export_hdr.dw_export_file.GetChild( "multi_row_table", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve()
dwchild.insertrow(1)
*/
//---------End Commented ------------------------------------------------------

//---------Begin Added by (Appeon)Toney 06.21.2013 for V141 ISG-CLX--------
//Dynamic Retrieve Screens
if ll_count > 0 then	il_view_id = tab_1.tabpage_export_hdr.dw_export_file.GetItemNumber( 1,"view_id")
if isnull(il_view_id) or il_view_id = 0 then il_view_id = 1001

tab_1.tabpage_field_data.dw_detail.GetChild("export_fields_ctx_scrn_id",dwchild)
dwchild.SetTransObject(sqlca)
if dwchild.Retrieve(il_view_id) < 1 then	dwchild.insertrow(1)
tab_1.tabpage_field_data.dw_detail.GetChild("export_fields_ctx_linktoscrnid",dwchild)
dwchild.SetTransObject(sqlca)
if dwchild.Retrieve(il_view_id) < 1 then	dwchild.insertrow(1)
//---------End Added ------------------------------------------------------------------

//maha 121205
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.22.2006 By: Rodger Wu
//$<reason> Fix a defect.

/* cnt = tab_1.tabpage_field_data.dw_fld_list.Retrieve( il_export_id ) */

Integer li_currentrow

li_currentrow = tab_1.tabpage_field_data.dw_fld_list.GetRow()
cnt = tab_1.tabpage_field_data.dw_fld_list.Retrieve( il_export_id )
if cnt > 0 and li_currentrow = 1 then
	tab_1.tabpage_field_data.dw_fld_list.Trigger Event rowfocuschanged( 1 )
end if

//<add>    andy 2007.05.30 
//<reason> Fix a defect. bug:BugG053001
if cnt = 0 then tab_1.tabpage_field_data.dw_detail.reset()
//end of add

//---------------------------- APPEON END ----------------------------

//tab_1.tabpage_field_data.dw_detail.Retrieve( tab_1.tabpage_field_data.dw_fld_list.getitemnumber(1,"rec_id") )
tab_1.enabled = true

if cnt < 1 then
	tab_1.selecttab(1)
else 
	tab_1.selecttab(2)
	tab_1.tabpage_field_data.dw_detail.Retrieve( tab_1.tabpage_field_data.dw_fld_list.getitemnumber(1,"rec_id") )
	tab_1.tabpage_field_data.dw_fld_list.setfocus()
end if

//tab_1.tabpage_field_data.dw_fld_list.ShareData( tab_1.tabpage_field_data.dw_detail
//Start Code Change ----06.14.2016 #V152 maha - report security
this.getchild("export_id", dwchild)
r = dwchild.find("export_id = " + data , 1, dwchild.rowcount())
li_user = dwchild.getitemnumber(r, "report_owner")

if ib_readonly then
	v = 0
elseif gs_user_id = "MASTER" then
	v = 2 
elseif isnull(li_user) then  //Start Code Change ----07.28.2016 #V152 maha - blank has access to all
	v = 2
else
	choose case li_user
		case 0 //Any
			v = 2
		case -1 //master
			v = 1
		case else
			if li_user = gi_role_id then
				v = 2 
			else
				v = 1
			end if
	end choose
end if

of_security( v )
//End Code Change ----06.14.2016

//Start Code Change ----06.16.2016 #V152 maha - auditing record
dw_audit.reset()
dw_audit.insertrow(1)
dw_audit.setitem(1, "report_id", il_view_id)
dw_audit.setitem(1, "report_name",tab_1.tabpage_export_hdr.dw_export_file.getitemstring(1,"export_name"))
dw_audit.setitem(1, "mod_user", gs_user_id)
dw_audit.setitem(1, "add_edit", "E")
dw_audit.setitem(1, "report_type", "E")
//End Code Change ----06.16.2016

//Start Code Change ----12.12.2017 #V16 maha - Store button visibility
select count(srs_id) into :li_save_count from sys_report_storage where report_id = :il_export_id and report_type = 'E';
if li_save_count > 0 then
	cb_store.visible = true
else
	cb_store.visible = false
end if
//End Code Change ----12.12.2017

post of_resize() //(Appeon)Harry 10.23.2014 -  for BugA101404 / BugH052902
end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.04.2007 By: Jack 
//$<reason> Fix a defect
datawindowchild child
string ls_value
this.getchild("export_id",child)
child.settransobject(sqlca)
child.retrieve()
If gb_contract_version Then
	child.setfilter("export_type in (3,4)")
	child.filter()
	ls_value = 'CTX Agreement Export~t3/CTX Export~t4/'
Else
	child.setfilter('')
	child.filter()
	//---------Begin Modified by (Appeon)Toney 11.14.2013 for V141 ISG-CLX--------
	//$Reason:
	  /*
		ls_value = 'Data~t1/Data and Text~t2/CTX Agreement Export~t3/CTX Export~t4/'			
	  */
 	ls_value = 'Data (obsolete)~t1/Provider Data~t2/'   //Start Code Change ----03.23.2015 #V15 maha - changed labels
	  //---------Begin Modified by (Appeon)long.zhang 05.16.2014 (v14.2 Provider-Contract direct linking)
	 //IF gb_contract_module THEN ls_value += 'CTX Agreement Export~t3/CTX Export~t4/'
	 IF gb_contract_module THEN ls_value +='CTX Agreement Export~t3/CTX Export~t4/Provider Data w//CTX~t5/CTX with Provider~t6'
	 //---------End Modfiied ------------------------------------------------------
	//---------End Modfiied ------------------------------------------------------------------
End If
tab_1.tabpage_export_hdr.dw_export_file.modify("export_type.values = " + "'" + ls_value + "'")
//---------------------------- APPEON END ----------------------------

end event

type cbx_previewdata from checkbox within w_export_painter
integer x = 3122
integer y = 176
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Preview Data"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-25 By: Rodger Wu
//comment 07/18/2007 by: Andy 
//if it saves data into db,it will very slowly
//if this.checked then cbx_savedata.checked = true
//---------------------------- APPEON END ----------------------------
end event

type st_field from statictext within w_export_painter
boolean visible = false
integer x = 2117
integer y = 56
integer width = 1321
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type dw_screen from u_dw within w_export_painter
boolean visible = false
integer x = 3790
integer y = 508
integer width = 160
integer height = 60
integer taborder = 31
end type

type dw_audit from u_dw within w_export_painter
boolean visible = false
integer x = 3227
integer y = 2116
integer width = 297
integer height = 184
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_report_audit_view"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_settransobject( sqlca)
end event

