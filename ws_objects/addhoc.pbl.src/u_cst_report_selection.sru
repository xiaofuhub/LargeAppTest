$PBExportHeader$u_cst_report_selection.sru
forward
global type u_cst_report_selection from userobject
end type
type dw_view_screen_detail from u_dw within u_cst_report_selection
end type
type dw_view_screen_browse from u_dw within u_cst_report_selection
end type
type st_2 from statictext within u_cst_report_selection
end type
type st_1 from statictext within u_cst_report_selection
end type
type dw_selected_field from u_dw within u_cst_report_selection
end type
type dw_properties from u_dw within u_cst_report_selection
end type
type dw_view_name from datawindow within u_cst_report_selection
end type
type gb_1 from groupbox within u_cst_report_selection
end type
end forward

global type u_cst_report_selection from userobject
integer width = 3913
integer height = 2172
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_view_screen_detail dw_view_screen_detail
dw_view_screen_browse dw_view_screen_browse
st_2 st_2
st_1 st_1
dw_selected_field dw_selected_field
dw_properties dw_properties
dw_view_name dw_view_name
gb_1 gb_1
end type
global u_cst_report_selection u_cst_report_selection

type variables
pfc_cst_nv_data_entry_functions inv_data_entry
string is_v_name
string is_c_name
long il_deleterow
long il_view_id
String  is_c_alias
long il_currentrow
datastore ids_view_name_where //d_view_name_where

n_ds ids_fields  //add by stephen 10.09.2011  - Bug 2727
n_ds ids_app_fields  //add by stephen 10.09.2011  - Bug 2727
end variables

forward prototypes
public function string uf_get_view_screen (integer as_row)
public subroutine uf_set_protect (datawindow adw)
public subroutine uf_set_auto_retrieve (datawindow adw)
public subroutine uf_create_freeform (string as_viewname, datawindow adw)
public function integer uf_show_invisible (boolean ab_show)
public function string uf_get_column_alias (string as_viewname, string as_columnname)
public subroutine uf_delete_field ()
public function boolean uf_check_screen_in_view (integer ai_data_view_id, integer ai_screen_id)
public subroutine uf_add ()
public function integer uf_visible_field (string as_viewlist)
public subroutine uf_syncscreenitems (datastore lds_ds)
end prototypes

public function string uf_get_view_screen (integer as_row);RETURN dw_view_name.Object.screen[as_row]
end function

public subroutine uf_set_protect (datawindow adw);long  li_col_cnt
String is_object_list[]
long i
li_col_cnt = Integer(adw.Describe("DataWindow.Column.Count"))
FOR i = 1 TO li_col_cnt
	is_object_list[i] = adw.GetColumnName()
	adw.Modify(is_object_list[i]+".Protect=1")
END FOR


end subroutine

public subroutine uf_set_auto_retrieve (datawindow adw);long  li_col_cnt
long i
li_col_cnt = Integer(adw.Describe("DataWindow.Column.Count"))
FOR i = 1 TO li_col_cnt
	IF lower(adw.Describe( "#" +string(i)+ ".Edit.Style"))='dddw' THEN
		adw.Modify( "#" +string(i)+ ".DDDW.AutoRetrieve=No")
   END IF
END FOR
end subroutine

public subroutine uf_create_freeform (string as_viewname, datawindow adw);Long ll_rowcount,i
String ls_select_sql
String error_syntaxfromSQL, error_create
String new_syntax
datastore ds_view_name_where //d_view_name_where

ds_view_name_where = Create datastore
ds_view_name_where.DataObject = "d_view_name_where_name"
ds_view_name_where.SetTransObject(sqlca)

ll_rowcount = ds_view_name_where.Retrieve(as_viewname)

if ll_rowcount = 0 then
	messagebox("Infor","Not properly create the screen, because there is no relevant fields.")
	return
end if
IF ll_rowcount > 0 THEN
	ls_select_sql = 'select '
	FOR i = 1 To ll_rowcount
		IF i < ll_rowcount THEN
			ls_select_sql = ls_select_sql+ds_view_name_where.Object.c_name[i]+','+'~r~n'
		ELSE
			ls_select_sql = ls_select_sql+ds_view_name_where.Object.c_name[i]+ '~r~n' +' from '+as_viewname
		END IF
	NEXT
END IF
new_syntax = sqlca.SyntaxFromSQL(ls_select_sql,'Style(Type=Form)', error_syntaxfromSQL)
IF Len(error_syntaxfromSQL) > 0 THEN
	// Display errors
	 MessageBox("Caution", "SyntaxFromSQL caused these errors: " + error_syntaxfromSQL)
ELSE
	// Generate new DataWindow
	adw.Create(new_syntax, error_create)
	IF Len(error_create) > 0 THEN
		 MessageBox("Caution","Create cause these errors: " + error_create)
	END IF
	adw.SetTransObject(sqlca)
	adw.InsertRow(0)
END IF
destroy ds_view_name_where

end subroutine

public function integer uf_show_invisible (boolean ab_show);Integer li_rc
Integer i
String ls_fld

dw_properties.SetFilter("")
dw_properties.Filter( )
li_rc = dw_properties.RowCount()

FOR i = 1 TO li_rc
	IF dw_properties.GetItemString( i, "data_view_fields_visible" ) = "Y" THEN
		CONTINUE
	END IF
	ls_fld = dw_properties.GetItemString( i, "sys_fields_field_name" )
	IF NOT ab_show THEN
		dw_view_screen_detail.Modify( ls_fld + ".Visible = 1")	
		dw_view_screen_detail.Modify( ls_fld + "_t.Visible = 1")	
	ELSE
		dw_view_screen_detail.Modify( ls_fld + ".Visible = 0")	
		dw_view_screen_detail.Modify( ls_fld + "_t.Visible = 0")			
	END IF
END FOR

RETURN 1
end function

public function string uf_get_column_alias (string as_viewname, string as_columnname);Long ll_rowcount,i
Long ll_foundrow
Long ll_visible
Long ll_data_view_id

//as_viewname,v_name
ids_view_name_where.setfilter("v_name = '" + as_viewname + "'")
ids_view_name_where.filter( )
ll_rowcount = ids_view_name_where.rowcount()
IF ll_rowcount > 0 THEN
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 06.15.2015
	//<$>reason:Add data_view_id condition (issue:sanctions vs santions in ireport)
	ll_data_view_id = w_custom_report.il_data_view_id
	ll_foundrow = ids_view_name_where.Find("lower(c_name) = '" + as_columnname + "' and (data_view_id = 0 or data_view_id = " + String(ll_data_view_id)+")" , 1, ll_rowcount) //(Appeon)Stephen 09.09.2015 - Allegheny- Creating an Ireport and unable to add a column in Appointment Status Case# 57046 Bug_Id 4699
	//ll_foundrow = ids_view_name_where.Find("lower(c_name) = '" + as_columnname + "' and data_view_id = " + String(ll_data_view_id) , 1, ll_rowcount)  //Commented by (Appeon)Stephen 09.09.2015 - Allegheny- Creating an Ireport and unable to add a column in Appointment Status Case# 57046 Bug_Id 4699
	//ll_foundrow = ids_view_name_where.Find("lower(c_name) = '" + as_columnname + "'", 1, ll_rowcount)
	//------------------- APPEON END -------------------
	
	IF ll_foundrow > 0 THEN
		IF ids_view_name_where.GetItemNumber(ll_foundrow, "visible") = 0 THEN RETURN '#invisible#' //alfee 05.06.2011
		RETURN ids_view_name_where.Object.c_alias[ll_foundrow]
	END IF
END IF

RETURN ''

end function

public subroutine uf_delete_field ();Long ll_found_fields,ll_fields_rowcount,ll_found_tables,ll_tables_rowcount,ll_found_view
Long ll_links_rowcount,i
String ls_FtblNm,ls_TtblNm
IF IsValid(w_custom_report) THEN
	//delete fields
	w_custom_report.tab_1.tabpage_columns.dw_view_fields.DeleteRow(il_deleterow)
	ll_fields_rowcount = w_custom_report.tab_1.tabpage_columns.dw_view_fields.RowCount()
	ll_found_fields = w_custom_report.tab_1.tabpage_columns.dw_view_fields.Find("table_name = '" + is_v_name + "'", 1, ll_fields_rowcount)
	IF ll_found_fields = 0 THEN
		ll_tables_rowcount = w_custom_report.tab_1.tabpage_tables.dw_view_tables.RowCount()
		ll_found_tables = w_custom_report.tab_1.tabpage_tables.dw_view_tables.Find("table_name = '" + is_v_name + "'", 1, ll_tables_rowcount)
		IF ll_found_tables > 0 THEN
			//delete tables
			w_custom_report.tab_1.tabpage_tables.dw_view_tables.DeleteRow(ll_found_tables)
			//setbitmapflag  v_name
			ll_found_view=dw_view_name.find("v_name = '" + is_v_name + "'", 1, dw_view_name.rowcount())
			if ll_found_view>0 then
				dw_view_name.object.bitmapflag[ll_found_view]='0'
			end if
			//delete links
			ll_links_rowcount = w_custom_report.tab_1.tabpage_tables.dw_view_links.RowCount()
			FOR i = ll_links_rowcount To 1 Step -1
				ls_FtblNm = w_custom_report.tab_1.tabpage_tables.dw_view_links.GetItemString( i, "link_from_table_nm" )
				ls_TtblNm = w_custom_report.tab_1.tabpage_tables.dw_view_links.GetItemString( i, "link_to_table_nm" )
				If (ls_FtblNm = is_v_name) Or (ls_TtblNm = is_v_name) THEN
					w_custom_report.tab_1.tabpage_tables.dw_view_links.DeleteRow(i)
				END IF
			NEXT
			
		END IF
	END IF
END IF



end subroutine

public function boolean uf_check_screen_in_view (integer ai_data_view_id, integer ai_screen_id);Integer li_cnt
SELECT count(*) Into :li_cnt From data_view_screen Where data_view_id = :ai_data_view_id  And screen_id = :ai_screen_id;
IF li_cnt = 0 THEN
	RETURN False
ELSE
	RETURN True
END IF

end function

public subroutine uf_add ();Long ll_Cnt,ll_Find,li_nr,ll_i
String ls_table_ids[]
Long ll_table_id
Long ll_field_id
String ls_width
String  ls_DddwName,ls_Display
String  ls_lookup_name,ls_lookup_type
ll_Cnt  = w_custom_report.tab_1.tabpage_tables.dw_view_tables.RowCount()
ll_Find = w_custom_report.tab_1.tabpage_tables.dw_view_tables.Find( "conv_view_table_table_name='" + is_v_name + "'", 1, ll_Cnt)
IF ll_Find = 0 THEN
	
	li_nr = w_custom_report.tab_1.tabpage_tables.dw_view_tables.InsertRow( 0 )
	//w_custom_report.il_next_table_id++  //delete by stephen 03.27.2013 -IntelliReport primary key issues
	w_custom_report.il_next_table_id = gnv_app.of_get_irep_id("conv_view_table", 1)  //add by stephen 03.27.2013 -IntelliReport primary key issues
	
	w_custom_report.tab_1.tabpage_tables.dw_view_tables.SetItem( li_nr, "project_id", w_custom_report.ii_project_id )
	w_custom_report.tab_1.tabpage_tables.dw_view_tables.SetItem( li_nr, "view_id", w_custom_report.il_view_id )
	w_custom_report.tab_1.tabpage_tables.dw_view_tables.SetItem( li_nr, "table_id", w_custom_report.il_next_table_id )
	w_custom_report.tab_1.tabpage_tables.dw_view_tables.SetItem( li_nr, "conv_view_table_table_name", is_v_name)
	w_custom_report.tab_1.tabpage_tables.dw_view_tables.SetItem( li_nr, "table_name", is_v_name)
	
	ll_Cnt = UpperBound(w_custom_report.tab_1.tabpage_tables.tv_tables.inv_attrib)
	ll_Find = w_custom_report.ids_tables.Find("v_name='" + is_v_name + "'",0,w_custom_report.ids_tables.RowCount())
	IF ll_Find > 0 THEN
		w_custom_report.tab_1.tabpage_tables.dw_view_tables.SetItem( li_nr, "cust_table_name", w_custom_report.ids_tables.GetItemNumber( ll_Find, "table_id" ) )
	END IF
	
	w_custom_report.tab_1.tabpage_tables.dw_view_tables.ScrollToRow( li_nr )
	w_custom_report.tab_1.tabpage_tables.dw_view_tables.SetRow( li_nr )
   //setbitmapflag
	dw_view_name.object.bitmapflag[il_currentrow]='1'
	ll_Cnt = w_custom_report.tab_1.tabpage_tables.dw_view_tables.RowCount()
	FOR ll_i = 1 To ll_Cnt
		ls_table_ids[ll_i] = w_custom_report.tab_1.tabpage_tables.dw_view_tables.GetItemString( ll_i, "conv_view_table_table_name" )
	NEXT
	IF ll_Cnt > 0 THEN
		w_custom_report.tab_1.tabpage_columns.dw_all_fields.Retrieve(  ls_table_ids  )
		w_custom_report.ids_fields.Retrieve( ls_table_ids,w_custom_report.il_data_view_id )//Nova 12.17.2010
	END IF
END IF
//insert fields
ll_Cnt  = w_custom_report.tab_1.tabpage_columns.dw_view_fields.RowCount()
ll_Find = w_custom_report.tab_1.tabpage_columns.dw_view_fields.Find( "table_name = '" + is_v_name + "' and field_name='" + is_c_name + "'", 1, ll_Cnt)
IF ll_Find > 0 THEN RETURN

ll_Find = w_custom_report.ids_fields.Find("c_name='" + is_c_name + "' and table_name='" + is_v_name + "'",1,w_custom_report.ids_fields.RowCount())
IF ll_Find > 0 THEN
	ll_table_id = w_custom_report.ids_fields.GetItemNumber( ll_Find, "field_id" )
	ll_field_id = w_custom_report.ids_fields.GetItemNumber( ll_Find, "table_id" )
	ls_width    = String(w_custom_report.ids_fields.GetItemNumber( ll_Find, "length" ))
END IF

li_nr = w_custom_report.tab_1.tabpage_columns.dw_view_fields.InsertRow( 0 )

//w_custom_report.il_next_field_id++    //delete by stephen 03.27.2013 -IntelliReport primary key issues
w_custom_report.il_next_field_id = gnv_app.of_get_irep_id("conv_view_fields", 1)  //add by stephen 03.27.2013 -IntelliReport primary key issues

w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "field_id", w_custom_report.il_next_field_id )
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "project_id", w_custom_report.ii_project_id )
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "view_id", w_custom_report.il_view_id )

w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "field_name", is_c_name )
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "field_alias", is_c_name )
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "label_text", is_c_alias )

w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "field_order",li_nr * 10 )
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "field_x", 0 )

w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "field_align", 0 )
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "label_align", 2 )

w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "table_name", is_v_name )
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "sel_field_id", ll_table_id )
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "sel_table_id", ll_field_id )
//
w_custom_report.tab_1.tabpage_columns.dw_view_fields.ScrollToRow(li_nr)
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetRow(li_nr)
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SelectRow(0,False)
w_custom_report.tab_1.tabpage_columns.dw_view_fields.SelectRow(li_nr,True)
//scroll to row the new added
dw_selected_field.ScrollToRow(li_nr)
dw_selected_field.SetRow(li_nr)
dw_selected_field.SelectRow(0,False)
dw_selected_field.SelectRow(li_nr,True)
//Automatic set Code Lookup Display Field
IF w_custom_report.of_get_lookup_data(is_v_name,is_c_name,ls_Display,ls_lookup_type,ls_lookup_name) = 1 THEN
	IF Lower(ls_Display) = 'code' THEN 
		ls_Display = 'Code' 
	ELSE 
		ls_Display = 'Description'
		//w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "lu_field_name", ls_Display ) //Commented by (Appeon)Stephen 01.22.2014 - bug 3848
		w_custom_report.tab_1.tabpage_columns.dw_view_fields.SetItem( li_nr, "lookup_type", ls_lookup_type )
	END IF
END IF


end subroutine

public function integer uf_visible_field (string as_viewlist);//////////////////////////////////////////////////////////////////////
// $<event> uf_visible_field
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 10.09.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string  ls_field, ls_label
string  ls_viewname[]
integer r, li_vis, li_cnt, li_tableid[]
string  ls_fields[], ls_obj
n_cst_string lnv_string

ls_viewname[1] = 'v_gp_languages'
ls_viewname[2] = 'v_gp_questions'
ls_viewname[3] = 'v_gp_covering_partners'
ls_viewname[4] = 'v_gp_other_ids'
ls_viewname[5] = 'v_gp_insurance'
ls_viewname[6] = 'v_gp_practice_info'
li_tableid[1] = 80
li_tableid[2] = 81
li_tableid[3] = 82
li_tableid[4] = 83
li_tableid[5] = 84
li_tableid[6] = 85

for r= 1 to upperbound(ls_viewname)
	if ls_viewname[r] = as_viewlist then exit
next

if r > 0 and r < 7 then
	ids_fields.setfilter( "table_id = " + string(li_tableid[r]))
	ids_fields.filter()
	
	for r = 1 to ids_fields.rowcount()
		ls_field = ids_fields.getitemstring(r,"field_name")
		ls_label = ids_fields.getitemstring(r,"field_name_allias")
		li_vis = ids_fields.getitemnumber(r,"use_validation")
		dw_view_screen_detail.Modify( ls_field + "_t.text = '" + ls_label + "'")	
		if li_vis = 1 then
			dw_view_screen_detail.Modify( ls_field + "_t.visible = '0'")	
			dw_view_screen_detail.Modify( ls_field + ".visible = '0'")	
		end if
	next
else
	for r = 1 to ids_app_fields.rowcount()
		ls_field = ids_fields.getitemstring(r,"field_name")
		ls_label = ids_fields.getitemstring(r,"field_name_allias")
		dw_view_screen_detail.Modify( ls_field + "_t.text = '" + ls_label + "'")	
	next	
end if

dw_view_screen_detail.modify("datawindow.color = '16777215'")
ls_obj = dw_view_screen_detail.describe("datawindow.objects")

lnv_string.of_ParseToArray(ls_obj, "~t",  ls_fields[])

for r = 1 to upperbound(ls_fields)
	if dw_view_screen_detail.describe(ls_fields[r]+".type") = 'column' then
		dw_view_screen_detail.modify(ls_fields[r]+".color='0'")
		dw_view_screen_detail.modify(ls_fields[r]+".height='60'")
		dw_view_screen_detail.modify(ls_fields[r]+".background.color='16777215'")
		dw_view_screen_detail.modify(ls_fields[r]+".border='5'")
	end if
	if dw_view_screen_detail.describe(ls_fields[r]+".type") = 'compute' and dw_view_screen_detail.describe(ls_fields[r]+".band") ='detail' then
		dw_view_screen_detail.modify(ls_fields[r]+".color='0'")
		dw_view_screen_detail.modify(ls_fields[r]+".height='60'")
		dw_view_screen_detail.modify(ls_fields[r]+".background.color='16777215'")
		dw_view_screen_detail.modify(ls_fields[r]+".border='5'")
	end if
next

return 1
end function

public subroutine uf_syncscreenitems (datastore lds_ds);//====================================================================
// $<event> uf_syncscreenitems
// $<arguments> datastore
// $<returns> None
// $<description> N/A
//====================================================================
// $<add> (Appeon)10.18.2017 Gavin Question #5840 for IntelliReport,
//When I attempt a quick select to add one of those tables above I get this error below.
//--------------------------------------------------------------------
// Modify History:
//====================================================================

Long			li_i, ll_Find, ll_
string 		ls_Screen, ls_Find

For li_i = 1 To dw_view_name.Rowcount( )
	ls_Screen = dw_view_name.GetItemstring( li_i, 'screen' )
	if Not IsNumber(ls_Screen) then Continue
	ls_Find = "screen_id=" + ls_Screen
	ll_Find = lds_ds.Find( ls_Find, 0, lds_ds.RowCount( ))
	if ll_Find < 1 then 
		 dw_view_name.RowsMove( li_i, li_i, Primary!, dw_view_name,1, Filter! )
		 li_i = li_i - 1
	end if			
	
Next
end subroutine

on u_cst_report_selection.create
this.dw_view_screen_detail=create dw_view_screen_detail
this.dw_view_screen_browse=create dw_view_screen_browse
this.st_2=create st_2
this.st_1=create st_1
this.dw_selected_field=create dw_selected_field
this.dw_properties=create dw_properties
this.dw_view_name=create dw_view_name
this.gb_1=create gb_1
this.Control[]={this.dw_view_screen_detail,&
this.dw_view_screen_browse,&
this.st_2,&
this.st_1,&
this.dw_selected_field,&
this.dw_properties,&
this.dw_view_name,&
this.gb_1}
end on

on u_cst_report_selection.destroy
destroy(this.dw_view_screen_detail)
destroy(this.dw_view_screen_browse)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_selected_field)
destroy(this.dw_properties)
destroy(this.dw_view_name)
destroy(this.gb_1)
end on

event constructor;inv_data_entry = Create pfc_cst_nv_data_entry_functions
inv_data_entry.of_setup_cache()
inv_data_entry.of_refresh_cache()

ids_view_name_where = Create datastore
ids_view_name_where.DataObject = "d_view_name_where"
ids_view_name_where.SetTransObject(sqlca)
ids_view_name_where.Retrieve()


//------------------- APPEON BEGIN -------------------
//$<add> Stephen 10.09.2011
//$<reason> Intellireport Quick Select fields error
ids_fields = Create n_ds
ids_fields.dataobject = "d_gp_sys_fields"
ids_fields.settransobject( SQLCA )
ids_fields.retrieve()

ids_app_fields = create n_ds
ids_app_fields.dataobject = "d_affil_stat_painter"
ids_app_fields.settransobject( SQLCA )
ids_app_fields.retrieve()
//------------------- APPEON END -------------------
end event

event destructor;if isvalid(ids_view_name_where) then Destroy ids_view_name_where
if isvalid(inv_data_entry) then Destroy inv_data_entry
if isvalid(ids_fields) then destroy ids_fields           //add by stephen 10.09.2011  - Bug 2727
if isvalid(ids_app_fields) then destroy ids_app_fields //add by stephen 10.09.2011  - Bug 2727
end event

type dw_view_screen_detail from u_dw within u_cst_report_selection
integer x = 969
integer y = 100
integer width = 2907
integer height = 1308
integer taborder = 40
string dragicon = "droparrow.ico"
end type

event dragdrop;call super::dragdrop;DragObject	ldo_control
// Get the dragged object.
ldo_control = DraggedObject()
// Determine if the dragged object datawindow
IF ldo_control = dw_selected_field THEN
	//remove 
	uf_delete_field()
END IF

end event

event clicked;call super::clicked;String dwobjectname
Long ll_pos
dwobjectname = This.GetObjectAtPointer()
IF dwo.Type = 'column' or this.dataobject = 'd_priv_list_d_browse' or this.dataobject = 'd_pd_notes_detail' THEN //modify by stephen 10.10.2011 Intellireport Quick Select Practitioner Privileges - Bug 2720
	ll_pos = Pos(dwobjectname,"	")
	IF ll_pos > 0 THEN is_c_name = Mid(dwobjectname,1, ll_pos -1)
	st_1.Text = is_c_name
	This.Drag(Begin!)
//------------------- APPEON BEGIN -------------------
//$<add> Stephen 10.11.2011
//$<reason> Intellireport Quick Select Practitioner Privileges - Bug 2716
elseif this.dataobject = 'd_pd_app_audit_rqrd_data' and dwo.name = 'compute_2' then
	ll_pos = Pos(dwobjectname,"	")
	IF ll_pos > 0 THEN is_c_name = Mid(dwobjectname,1, ll_pos -1)
	st_1.Text = is_c_name
	This.Drag(Begin!)
//------------------- APPEON END -------------------
END IF
end event

type dw_view_screen_browse from u_dw within u_cst_report_selection
boolean visible = false
integer x = 1038
integer y = 100
integer width = 2802
integer height = 1052
integer taborder = 30
end type

type st_2 from statictext within u_cst_report_selection
boolean visible = false
integer x = 2048
integer y = 40
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Drag Object:"
boolean focusrectangle = false
end type

type st_1 from statictext within u_cst_report_selection
boolean visible = false
integer x = 2386
integer y = 12
integer width = 709
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type dw_selected_field from u_dw within u_cst_report_selection
integer x = 955
integer y = 1424
integer width = 2944
integer height = 724
integer taborder = 40
string dragicon = "droparrow.ico"
boolean titlebar = true
string title = "Selected Columns"
string dataobject = "d_view_selected_fields"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransObject(sqlca)

this.object.datawindow.color = 32897791 //alfee 11.10.2010
end event

event dragdrop;call super::dragdrop;DragObject	ldo_control
Long i
// Get the dragged object.
ldo_control = DraggedObject()
// Determine if the dragged object datawindow
IF ldo_control = dw_view_screen_detail THEN
	IF IsValid(w_custom_report) THEN
		is_v_name=dw_view_name.object.v_name[dw_view_name.getrow()]
		//
		open(w_select_fields)
		IF Message.StringParm = 'zero' THEN
			is_c_alias = uf_get_column_alias(is_v_name,lower(is_c_name))
			IF is_c_alias = '' THEN 
				//MessageBox("Info","This field cannot be added since there is no such a field in the View!") //alfee 11.15.2010
				MessageBox("Info","This field cannot be added as it does not appear in the View field list.  Please check View Alias Maintenance.   (You  may have to reselect the report  or re-open IntelliReport) ")  //Start Code Change ----06.14.2017 #V154 maha
				//MessageBox("Info","In the View there are no corresponding fields of the fields you are dragging!")
				RETURN
			ELSEIF is_c_alias='#invisible#' THEN //alfee 05.06.2011
				MessageBox("Info","This field cannot be added since it is not visible in the View. Please check it in View Alias Maintenance and reopen tntelliReport.")
				RETURN
			ELSE
				uf_add()
			END IF
		END IF
//		is_c_alias = uf_get_column_alias(is_v_name,is_c_name)
//		IF is_c_alias = '' THEN //In the View there are no corresponding fields of the fields you are dragging
//			Open(w_select_fields)
//			IF Message.StringParm = 'zero' THEN
//				MessageBox("Info","In the View there are no corresponding fields of the fields you are dragging!")
//			END IF
//			RETURN
//		END IF
//		uf_add()
	END IF
END IF


	
end event

event clicked;call super::clicked;IF row > 0 THEN
	// Select the Clicked row
	This.SelectRow(0, False)
	This.SelectRow(row, True)
	il_deleterow = row
	is_v_name = This.Object.table_name[row]
	il_view_id = This.Object.view_id[row]
	// Begin the drag
	This.Drag(Begin!)
END IF

end event

event doubleclicked;call super::doubleclicked;IF row > 0 THEN
	uf_delete_field()
END IF

end event

type dw_properties from u_dw within u_cst_report_selection
boolean visible = false
integer x = 142
integer y = 428
integer width = 457
integer taborder = 30
string dataobject = "d_sys_field_properties"
end type

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )
end event

type dw_view_name from datawindow within u_cst_report_selection
integer width = 933
integer height = 2144
integer taborder = 10
boolean titlebar = true
string title = "Select Data Screen"
string dataobject = "d_report_view"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)

end event

event rowfocuschanged;String ls_return_screen
String ls_screen_arr[]
Long i
Long ll_total
Integer li_data_view_id
n_cst_string   lnv_string

Parent.SetRedraw( False)
This.SelectRow(0, False)
This.SelectRow( currentrow, True)
dw_view_screen_detail.DataObject = ''
ls_return_screen = uf_get_view_screen (currentrow)
lnv_string.of_parsetoarray(ls_return_screen, ',', ls_screen_arr)
ll_total = UpperBound(ls_screen_arr)

is_v_name = This.Object.v_name[currentrow]
IF ll_total = 0 THEN
	uf_create_freeform(Lower(Trim(This.Object.v_name[currentrow])),dw_view_screen_detail)
ELSEIF ll_total = 1 And IsNumber(ls_screen_arr[1]) THEN
	
	//if screen exits in the data_view then data_view_id is w_custom_report.il_data_view_id else data_view_id is 1
	IF uf_check_screen_in_view(w_custom_report.il_data_view_id,Long(ls_screen_arr[1])) THEN
		li_data_view_id = w_custom_report.il_data_view_id
	ELSE
		li_data_view_id = 1
	END IF
	inv_data_entry.of_create_dynamic_dw(0, li_data_view_id, Long(ls_screen_arr[1]), dw_view_screen_detail, dw_view_screen_browse, True, 0, true )
	dw_properties.Retrieve(li_data_view_id,Long(ls_screen_arr[1]))
	//set field visible property
	uf_show_invisible(True)
	
ELSEIF ll_total = 1 And  Not IsNumber(ls_screen_arr[1]) THEN
	dw_view_screen_detail.DataObject = ls_screen_arr[1]
	dw_view_screen_detail.SetTransObject(sqlca)
	uf_set_auto_retrieve(dw_view_screen_detail)
	uf_visible_field( is_v_name)  // add by stephen 10.09.2011 - bug2727
	dw_view_screen_detail.InsertRow(1)
ELSEIF ll_total > 1 THEN
	IF Lower(Trim(This.Object.v_name[currentrow])) = "v_oppe_fppe" Or Lower(Trim(This.Object.v_name[currentrow])) = "v_site_survey" THEN //v_site_surve
		FOR i = 1 To ll_total
			IF Lower(ls_screen_arr[i]) = 'd_oppe_fppe_prac_detail' Or Lower(ls_screen_arr[i]) = 'd_survey_basic_info' THEN
				dw_view_screen_detail.DataObject = ls_screen_arr[i]
				dw_view_screen_detail.SetTransObject(sqlca)
				uf_set_auto_retrieve(dw_view_screen_detail)
				dw_view_screen_detail.InsertRow(0)
			END IF
		NEXT
	ELSEIF Lower(Trim(This.Object.v_name[currentrow])) = "v_priv_list" Or Lower(Trim(This.Object.v_name[currentrow])) = "v_qa_measurements"  Or Lower(Trim(This.Object.v_name[currentrow])) = "v_site_survey_results" THEN //v_priv_list,v_qa_measurements,v_site_survery_results	
		uf_create_freeform(Lower(Trim(This.Object.v_name[currentrow])),dw_view_screen_detail)
	END IF
END IF
//set protect prrperty
il_currentrow = currentrow
uf_set_protect(dw_view_screen_detail)
//set bringtotop
Parent.SetRedraw( True)
gb_1.BringToTop = False
dw_view_screen_detail.BringToTop = True

end event

event dragenter;DragObject	ldo_control
// Get the dragged object.
ldo_control = DraggedObject()
IF ldo_control = dw_view_screen_detail THEN
	ldo_control.Drag(Cancel!)
	st_1.Text = ''
END IF


end event

type gb_1 from groupbox within u_cst_report_selection
integer x = 951
integer y = 40
integer width = 2944
integer height = 1380
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Drag fields to column list to add"
end type

